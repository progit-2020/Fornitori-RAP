unit A013UCalendIndivMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,DB, Oracle, OracleData,
  Dialogs, R005UDataModuleMW, A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali;

type
  TA013FCalendIndivMW = class(TR005FDataModuleMW)
    CancQ012: TOracleQuery;
    selV010: TOracleDataSet;
    Q011: TOracleDataSet;
    Q012: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    DaData, AData, DataPatrono: TDateTime;
    Lavorativo:array [1..7] of Boolean;
    procedure CancellaCalendario(DaGiorno, AGiorno: TDateTime);
    procedure GeneraCalendario(DaGiorno, AGiorno: TDateTime);
    function ValidaCalendario: String;
    function ConvData(Text: string; var Data: TDateTime): boolean;
  end;

implementation

{$R *.dfm}

procedure TA013FCalendIndivMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Q011.SetVariable('Codice','');
end;

procedure TA013FCalendIndivMW.CancellaCalendario(DaGiorno,AGiorno:TDateTime);
{Cancella il calendario da data a data}
begin
  CancQ012.SetVariable('Prog',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  CancQ012.SetVariable('Data1',DaGiorno);
  CancQ012.SetVariable('Data2',AGiorno);
  CancQ012.Execute;
  SessioneOracle.Commit;
  RegistraLog.SettaProprieta('C','T012_CALENDINDIVID',NomeOwner,nil,True);
  //RegistraLog.InserisciDato('GENERAZIONE',Format('%s %s - %s',[IntToStr(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger),DateToStr(DaGiorno),DateToStr(AGiorno)]),'');
  RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger),'');
  RegistraLog.InserisciDato('DAL',DateToStr(DaGiorno),'');
  RegistraLog.InserisciDato('AL',DateToStr(AGiorno),'');
  RegistraLog.RegistraOperazione;
end;

procedure TA013FCalendIndivMW.GeneraCalendario(DaGiorno,AGiorno:TDateTime);
var Anno,Mese,Giorno,AnnoP,MeseP,GiornoP:Word;
    i,NumGiorni:Byte;
    Festivo:boolean;
    Dal, Al: TDateTime;
{Genera i giorni registrando se sono lavorativi o festivi}
begin
  //Salvo riferimenti DaGiorno, AGiorno per emissione log
  Dal:=DaGiorno;
  Al:=AGiorno;
  //Calcolo il numero di giorni lavorativi della settimana
  NumGiorni:=0;
  AnnoP:=0;
  MeseP:=0;
  GiornoP:=0;
  for i:=1 to 7 do
    if Lavorativo[i] then
      inc(NumGiorni);
  (*  Progressbar win
  A013FCalendIndiv.ProgressBar1.Min:=0;
  A013FCalendIndiv.ProgressBar1.Max:=Round(AGiorno) - Round(DaGiorno);
  A013FCalendIndiv.ProgressBar1.Position:=0;
  *)
  CancQ012.SetVariable('Prog',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  CancQ012.SetVariable('Data1',DaGiorno);
  CancQ012.SetVariable('Data2',AGiorno);
  CancQ012.Execute;
  SessioneOracle.Commit;
  R180SetVariable(selV010,'PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  R180SetVariable(selV010,'DATA1',DaGiorno);
  R180SetVariable(selV010,'DATA2',AGiorno);
  selV010.Open;
  selV010.First;
  Q012.Close;
  Q012.SetVariable('Prog',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  Q012.SetVariable('Dal',DaGiorno);
  Q012.SetVariable('Al',AGiorno);
  Q012.Open;
  Q012.CachedUpdates:=True;
  while DaGiorno <= AGiorno do
  begin
    Q012.Append;
    Q012['Progressivo']:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    Q012['Data']:=DaGiorno;
    if Lavorativo[DayOfWeek(DaGiorno-1)] then
      Q012['Lavorativo']:='S'
    else
      Q012['Lavorativo']:='N';
    DecodeDate(DaGiorno,Anno,Mese,Giorno);
    if DataPatrono <> 0 then
      DecodeDate(DataPatrono,AnnoP,MeseP,GiornoP);
    Festivo:=False;
    if selV010.SearchRecord('DATA',DaGiorno,[srFromBeginning]) then
      if selV010.FieldByName('FESTIVO').AsString = 'S' then
        Festivo:=True;
    if (GiornoP = Giorno) and (MeseP = Mese) then
      Festivo:=True;
    if Festivo then
      Q012['Festivo']:='S'
    else
      Q012['Festivo']:='N';
    Q012.FieldByName('NumGiorni').AsInteger:=NumGiorni;
    DaGiorno:=DaGiorno + 1;
    Q012.Post;
    //Progressbar win
    //A013FCalendIndiv.ProgressBar1.Position:=A013FCalendIndiv.ProgressBar1.Position + 1;
  end;
  SessioneOracle.ApplyUpdates([Q012],True);
  Q012.CachedUpdates:=False;
  SessioneOracle.Commit;
  //Progressbar win
  //A013FCalendIndiv.ProgressBar1.Position:=0;
  RegistraLog.SettaProprieta('I','T012_CALENDINDIVID',NomeOwner,nil,True);
  //RegistraLog.InserisciDato('GENERAZIONE','',Format('%s %s - %s',[IntToStr(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger),DateToStr(DaGiorno),DateToStr(AGiorno)]));
  RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger));
  RegistraLog.InserisciDato('DAL','',DateToStr(Dal));
  RegistraLog.InserisciDato('AL','',DateToStr(Al));
  RegistraLog.RegistraOperazione;
end;

function TA013FCalendIndivMW.ValidaCalendario:String;
begin
  Result:='';
  Q012.Close;
  Q012.SetVariable('Prog',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  Q012.SetVariable('Dal',DaData);
  Q012.SetVariable('Al',AData);
  Q012.Open;
  if Q012.RecordCount = 0 then
  begin
    Result:=A000MSG_A013_ERR_CALENDARIO_NON_GENERATO;
    exit;
  end;
  Q012.First;
  DaData:=Q012['Data'];
  Q012.Last;
  AData:=Q012['Data'];
end;

function TA013FCalendIndivMW.ConvData(Text:string; var Data:TDateTime):boolean;
begin
  result:=True;
  try
    Data:=StrToDate(Text);
  except
    result:=false;
  end;
end;

end.
