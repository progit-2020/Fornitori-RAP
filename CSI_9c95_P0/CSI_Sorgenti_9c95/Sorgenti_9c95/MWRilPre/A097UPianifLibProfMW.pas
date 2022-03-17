unit A097UPianifLibProfMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData, DB, StrUtils, Oracle, A000UInterfaccia,
  DatiBloccati, RegistrazioneLog,
  R005UDataModuleMW, A000UMessaggi, C180FunzioniGenerali;

type
  TA097FPianifLibProfMW = class(TR005FDataModuleMW)
    Q310: TOracleDataSet;
    Q311: TOracleDataSet;
    selaT320: TOracleDataSet;
    Del320: TOracleQuery;
    Ins320: TOracleQuery;
    GetCalendario: TOracleQuery;
    Q275: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    selDatiBloccati:TDatiBloccati;
    function ControlloFestivo(P:Integer; D:TDateTime):Boolean;
  public
    selT320: TOracleDataSet;
    Dal,Al:TDateTime;
    PianifFestivi:Boolean;
    procedure RefreshSelT320;
    procedure selT320BeforeDelete;
    procedure selT320BeforePost;
    procedure selT320CalcFields;
    procedure selT320NewRecord;
    procedure selT320DALLEValidate(Sender: TField);
    procedure selT320CAUSALEValidate(Sender: TField);
    procedure GestionePianificazione(Prog:LongInt;Inserimento:Boolean);
  end;

implementation

{$R *.dfm}

procedure TA097FPianifLibProfMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selDatiBloccati:=TDatiBloccati.Create(nil);
  selDatiBloccati.TipoLog:='';
  Q310.Open;
  Q275.Open;
end;

procedure TA097FPianifLibProfMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selDatiBloccati);
end;

procedure TA097FPianifLibProfMW.RefreshSelT320;
begin
  selT320.Close;
  selT320.SetVariable('Progressivo',selAnagrafe.FieldByName('Progressivo').AsInteger);
  selT320.SetVariable('Data1',Dal);
  selT320.SetVariable('Data2',Al);
  selT320.Open;
end;

procedure TA097FPianifLibProfMW.selT320BeforeDelete;
begin
  if selDatiBloccati.DatoBloccato(selT320.FieldByName('PROGRESSIVO').AsInteger,selT320.FieldByName('DATA').AsDateTime,'T320') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA097FPianifLibProfMW.selT320BeforePost;
begin
  if (selT320.FieldByName('DATA').AsDateTime < Dal)
  or (selT320.FieldByName('DATA').AsDateTime > Al) then
    raise exception.Create(A000MSG_A097_ERR_DATA_ESTERNA);
  if selDatiBloccati.DatoBloccato(selT320.FieldByName('PROGRESSIVO').AsInteger,selT320.FieldByName('DATA').AsDateTime,'T320') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);

  selaT320.Close;
  selaT320.SetVariable('PROGRESSIVO',selT320.FieldByName('PROGRESSIVO').AsInteger);
  if selT320.State in [dsEdit] then
    selaT320.SetVariable('COND_ROWID',' and rowid <> ''' + selT320.RowId + ''' ')
  else
    selaT320.SetVariable('COND_ROWID','');
  selaT320.SetVariable('DATA',selT320.FieldByName('DATA').AsDateTime);
  selaT320.SetVariable('DALLE',selT320.FieldByName('DALLE').AsString);
  selaT320.SetVariable('ALLE',selT320.FieldByName('ALLE').AsString);
  selaT320.SetVariable('ALLE_CONTINUE',IfThen(R180OreMinutiExt(selT320.FieldByName('DALLE').AsString) > R180OreMinutiExt(selT320.FieldByName('ALLE').AsString),R180MinutiOre(R180OreMinutiExt(selT320.FieldByName('ALLE').AsString) + R180OreMinutiExt('24.00')),selT320.FieldByName('ALLE').AsString));
  selaT320.Open;
  if not selaT320.Eof then
    raise exception.Create(Format(A000MSG_A097_ERR_FMT_INTERSEZIONE,[selT320.FieldByName('DATA').AsString,
                                                                     selT320.FieldByName('Dalle').AsString,
                                                                     selT320.FieldByName('Alle').AsString,
                                                                     selaT320.FieldByName('DATA').AsString,
                                                                     selaT320.FieldByName('Dalle').AsString,
                                                                     selaT320.FieldByName('Alle').AsString]));
end;

procedure TA097FPianifLibProfMW.selT320CalcFields;
begin
  selT320.FieldByName('D_Giorno').AsString:=R180NomeGiorno(selT320.FieldByName('Data').AsDateTime);
end;

procedure TA097FPianifLibProfMW.selT320NewRecord;
begin
  selT320.FieldByName('Progressivo').AsInteger:=selAnagrafe.FieldByName('Progressivo').AsInteger;
end;

procedure TA097FPianifLibProfMW.selT320DALLEValidate(Sender: TField);
begin
  R180OraValidate(Sender.AsString);
end;

procedure TA097FPianifLibProfMW.selT320CAUSALEValidate(Sender: TField);
begin
  if Sender.IsNull or (Sender.Text = '') then
    exit;
  if not Q275.Locate('CODICE',Sender.AsString,[]) then
    raise Exception.Create(A000MSG_A097_ERR_CAUSALE_INESISTENTE);
end;

procedure TA097FPianifLibProfMW.GestionePianificazione(Prog:LongInt;Inserimento:Boolean);
var D:TDateTime;
begin
  Q311.First;
  selDatiBloccati.TipoLog:='F';
  try
    while not Q311.Eof do
    begin
      D:=Dal;
      while D <= Al do
      begin
        if DayOfWeek(D - 1) = Q311.FieldByName('Giorno').AsInteger then
          if ControlloFestivo(Prog,D) then
          begin
            //Verifico se ci sono i riepiloghi bloccati
            if selDatiBloccati.DatoBloccato(Prog,D,'T320') then
            begin
              D:=D + 1;
              Continue;
            end;
            if Inserimento then
            begin
              selaT320.Close;
              selaT320.SetVariable('PROGRESSIVO',Prog);
              selaT320.SetVariable('COND_ROWID','');
              selaT320.SetVariable('DATA',D);
              selaT320.SetVariable('DALLE',Q311.FieldByName('Dalle').AsString);
              selaT320.SetVariable('ALLE',Q311.FieldByName('Alle').AsString);
              selaT320.SetVariable('ALLE_CONTINUE',IfThen(R180OreMinutiExt(Q311.FieldByName('DALLE').AsString) > R180OreMinutiExt(Q311.FieldByName('ALLE').AsString),R180MinutiOre(R180OreMinutiExt(Q311.FieldByName('ALLE').AsString) + R180OreMinutiExt('24.00')),Q311.FieldByName('ALLE').AsString));
              selaT320.Open;
              if not selaT320.Eof then
                RegistraMsg.InserisciMessaggio('A','Nel giorno ' + DateToStr(D) + ' la pianificazione ' + Q311.FieldByName('Dalle').AsString + '-' + Q311.FieldByName('Alle').AsString + ' ne interseca una già esistente (' + selaT320.FieldByName('DATA').AsString + ' ' + selaT320.FieldByName('Dalle').AsString + '-' + selaT320.FieldByName('Alle').AsString + ')!','',Prog)
              else
                try
                  Ins320.SetVariable('Progressivo',Prog);
                  Ins320.SetVariable('Data',D);
                  Ins320.SetVariable('Causale',Q311.FieldByName('Causale').AsString);
                  Ins320.SetVariable('Dalle',Q311.FieldByName('Dalle').AsString);
                  Ins320.SetVariable('Alle',Q311.FieldByName('Alle').AsString);
                  Ins320.Execute;
                  RegistraLog.SettaProprieta('I','T320_PIANLIBPROFESSIONE',NomeOwner,nil,True);
                  RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
                  RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(Dal),DateToStr(Al)]));
                  RegistraLog.RegistraOperazione;
                  SessioneOracle.Commit;
                except
                  SessioneOracle.RollBack;
                end;
            end
            else
            begin
              try
                Del320.SetVariable('Progressivo',Prog);
                Del320.SetVariable('Data',D);
                Del320.SetVariable('Dalle',Q311.FieldByName('Dalle').AsString);
                Del320.SetVariable('Alle',Q311.FieldByName('Alle').AsString);
                Del320.Execute;
                RegistraLog.SettaProprieta('C','T320_PIANLIBPROFESSIONE',NomeOwner,nil,True);
                RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(Prog),'');
                RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(Dal),DateToStr(Al)]),'');
                RegistraLog.RegistraOperazione;
                SessioneOracle.Commit;
              except
                SessioneOracle.RollBack;
              end;
            end;
          end;
        D:=D + 1;
      end;
      Q311.Next;
    end;
  finally
    selDatiBloccati.TipoLog:='';
  end;
end;

function  TA097FPianifLibProfMW.ControlloFestivo(P:Integer; D:TDateTime):Boolean;
{Restituisce True se i Festivi sono abilitati, oppure se il giorno non è festivo}
begin
  Result:=PianifFestivi;
  if not Result then
    with GetCalendario do
    begin
      ClearVariables;
      SetVariable('Prog',P);
      SetVariable('D',D);
      Execute;
      Result:=GetVariable('F') <> 'S';
    end;
end;

end.
