unit A007UProfiliOrariDtM1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, Oracle, DB, OracleData,
  A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog;
type
  //Eccezioni su orari incompleti e vuoti nella routine OrarioOK
  EOrarioIncompleto = class(Exception);
  EOrarioVuoto = class(Exception);

  TA007FProfiliOrariDtM1 = class(TR004FGestStoricoDtM)
    D020: TDataSource;
    D221: TDataSource;
    Q220: TOracleDataSet;
    Q220CODICE: TStringField;
    Q220DESCRIZIONE: TStringField;
    Q220ANTICIPOUSCITA: TDateTimeField;
    Q220PRITIMSC: TStringField;
    Q220SCOSTENTRATA: TStringField;
    Q220TIMBNONAPPOGGIATE: TStringField;
    Q220RITARDO_ENTRATA: TIntegerField;
    Q221: TOracleDataSet;
    Q221Codice: TStringField;
    Q221D_Codice: TStringField;
    Q221Progressivo: TFloatField;
    Q221Lunedi: TStringField;
    Q221Martedi: TStringField;
    Q221Mercoledi: TStringField;
    Q221Giovedi: TStringField;
    Q221Venerdi: TStringField;
    Q221Sabato: TStringField;
    Q221Domenica: TStringField;
    Q221NonLav: TStringField;
    Q221FESTIVO: TStringField;
    Q221DLunedi: TStringField;
    Q221DMartedi: TStringField;
    Q221DMercoledi: TStringField;
    Q221DGiovedi: TStringField;
    Q221DVenerdi: TStringField;
    Q221DSabato: TStringField;
    Q221DDomenica: TStringField;
    Q221DNonLav: TStringField;
    Q221DFestivo: TStringField;
    Q020: TOracleDataSet;
    Q020CODICE: TStringField;
    Q020DESCRIZIONE: TStringField;
    Q221ModificaProfilo: TOracleQuery;
    Q220DECORRENZA: TDateTimeField;
    Q221DECORRENZA: TDateTimeField;
    OperSQL: TOracleQuery;
    insT221: TOracleQuery;
    Q220DECORRENZA_FINE: TDateTimeField;
    Q220IGNORA_TIMBNONINSEQ: TStringField;
    selT220CopiaR: TOracleDataSet;
    selT220CopiaW: TOracleDataSet;
    selT221Copia: TOracleDataSet;
    Q220PRIORITA_DOM_FEST: TStringField;
    Q220PRIORITA_DOM_NONLAV: TStringField;
    procedure Q220ANTICIPOUSCITAGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure Q221AfterPost(DataSet: TDataSet);
    procedure Q221AfterCancel(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure D221StateChange(Sender: TObject);
    procedure Q221AfterDelete(DataSet: TDataSet);
    procedure Q221NewRecord(DataSet: TDataSet);
    procedure Q221AfterOpen(DataSet: TDataSet);
    procedure OrarioValidate(Sender: TField);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure Q220AfterScroll(DataSet: TDataSet);
    procedure T220AnticipoUscitaSetText(Sender: TField;
      const Text: string);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    VecchioCodiceDizionario:String;
    storic:Boolean;
    CodiceOld,CodiceNew:String;
    DecorrenzaOld,DecorrenzaNew:TDateTime;
    procedure CambiaCodiceDecorrenza;
  public
    { Public declarations }
    function OrarioOk:boolean;
  end;

var
  A007FProfiliOrariDtM1: TA007FProfiliOrariDtM1;

implementation

uses A007UProfiliOrari;

{$R *.dfm}

procedure TA007FProfiliOrariDtM1.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A007FProfiliOrari.InterfacciaR004;
  InizializzaDataSet(Q220,[evBeforePost,
                           evBeforeDelete,
                           evBeforeInsert,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord]);
  Q220.Open;
  Q221.Open;
  Q020.Open;
end;

procedure TA007FProfiliOrariDtM1.Q221NewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('Codice').AsString:=Q220.FieldByName('Codice').AsString;
  DataSet.FieldByName('Decorrenza').AsDateTime:=Q220.FieldByName('Decorrenza').AsDateTime;
  DataSet.FieldByName('Progressivo').AsInteger:=0
end;

function TA007FProfiliOrariDtM1.OrarioOk:boolean;
{Controllo la validità degli orari introdotti}
{Non possono esserci due giorni con lo stesso orario}
var Nomi,CodCorr:Array [0..8] of String;
    CodOra:Array [0..8,0..50] of String;
    NumOra:Array [0..8] of Byte;
    num,i,j,x,z:ShortInt;
procedure OrarioNullo;
{procedura per gestire il caso di 'buco' negli orari}
var i1,j1,x1,Ind1,Ind2:ShortInt;
    RigaNulla:boolean;
begin
  for i1:=0 to 8 do
    for x1:=0 to Num do
      if (Trim(CodOra[i1,x1]) = '') then
        begin
        Ind2:=x1;
        j1:=x1+1;
        while (j1 <= Num) and (Trim(CodOra[i1,j1])='') do j1:=j1+1;
        if j1 <= Num then
          for Ind1:=j1 to Num do
            begin
            CodOra[i1,Ind2]:=CodOra[i1,Ind1];
            CodOra[i1,Ind1]:='';
            Ind2:=Ind2+1;
            end;
        end;
  {Registro le modifiche cancellando i vecchi record e
  inserendo quelli nuovi}
  with Q221 do
    begin
    First;
    while not Eof do
      Delete;
    //Inserisco i nuovi record;
    for j1:=0 to Num do
      begin
      RigaNulla:=True;
      Append;
      FieldbyName('Codice').AsString:=Q220.FieldByName('Codice').AsString;
      FieldbyName('Decorrenza').AsDateTime:=Q220.FieldByName('Decorrenza').AsDateTime;
      FieldByName('Progressivo').AsInteger:=j1+1;
      for i1:=0 to 8 do
        if Trim(CodOra[i1,j1]) <> '' then
          begin
          Fields[i1+3].AsString:=CodOra[i1,j1];
          RigaNulla:=False;
          end;
      if RigaNulla then
        begin
        Cancel;
        Break;
        end
      else
        Post;
      end;
    end;
end;
begin
  Result:=True;
  Nomi[0]:='Lunedì';Nomi[1]:='Martedì';Nomi[2]:='Mercoledì';
  Nomi[3]:='Giovedì';Nomi[4]:='Venerdì';Nomi[5]:='Sabato';
  Nomi[6]:='Domenica';Nomi[7]:='Non lavorativo';Nomi[8]:='Festivo';
  for i:=0 to 8 do
    for j:=0 to 50 do CodOra[i,j]:='';
  with Q221 do
    begin
    {Carico in memoria gli orari del codice corrente}
    if State in [dsInsert,dsEdit] then Post;
    DisableControls;
    j:=0;
    First;
    while not Eof do
      begin
      for i:=0 to 8 do
        CodOra[i,j]:=Fields[i+3].AsString;
      Next;
      inc(j);
      end;
    Num:=j - 1;
    //Gestisco i 'buchi' negli orari
    OrarioNullo;
    z:=0;
    {Faccio i controlli sulla matrice in memoria}
    try
      for x:=0 to Num do
        begin
        {Ciclo di caricamento della riga corrente}
        for i:=0 to 8 do
          //Prima settimana incompleta
          if (x = 0) and (Trim(CodOra[i,x]) = '') then
            raise EOrarioIncompleto.Create('Prima settimana incompleta!')
          else
            begin
            CodCorr[i]:=CodOra[i,x];
            NumOra[i]:=0;
            end;
        {Ciclo di scorrimento delle righe rimanenti per
        il confronto}
        for j:=x+1 to Num do
          begin
          for i:=0 to 8 do
            if (CodCorr[i] = CodOra[i,j]) and (Trim(CodCorr[i]) <> '') then
            begin
              z:=j;
              raise EOrarioVuoto.Create('Orario del giorno '+Nomi[i]+' ripetuto!');
            end;
          end;
        end;
    except
      on E:EOrarioVuoto do
        begin
        Result:=False;
        ShowMessage(E.Message);
        First;
        for i:=1 to z do
          Q221.Next;  {Mi posiziono sul record che contiene il duplicato}
        end;
      on E:Exception do
        begin
        Result:=False;
        ShowMessage(E.Message);
        end;
    end;
    First;
    EnableControls;
    end;
end;

procedure TA007FProfiliOrariDtM1.T220AnticipoUscitaSetText(Sender: TField;
  const Text: string);
begin
  inherited;
  {$I CampoOra}
end;

procedure TA007FProfiliOrariDtM1.D221StateChange(Sender: TObject);
{Aggiorno il numero di settimane registrate del profilo}
begin
  inherited;
  A007FProfiliOrari.NumSettimane.Caption:=IntToStr(Q221.RecordCount);
end;

procedure TA007FProfiliOrariDtM1.Q221AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A007FProfiliOrari.NumSettimane.Caption:=IntToStr(Q221.RecordCount);
end;

procedure TA007FProfiliOrariDtM1.Q221AfterOpen(DataSet: TDataSet);
begin
  inherited;
  A007FProfiliOrari.NumSettimane.Caption:=IntToStr(Q221.RecordCount);
end;

procedure TA007FProfiliOrariDtM1.OrarioValidate(Sender: TField);
{Controllo la validità degli orari immessi}
begin
  inherited;
  if Sender.AsString = '' then
    exit;
  if (Sender.AsString = ':GGST') and ((UpperCase(Sender.FieldName) = 'NONLAV') or (UpperCase(Sender.FieldName) = 'FESTIVO')) then
    exit;
  if not Q020.Locate('Codice',Sender.AsString,[]) then
    raise Exception.Create('Orario inesistente!');
  if (Sender = Q221Lunedi) and (Q221.State = dsInsert) and (Q221.RecordCount = 0) then
  begin
    if Q221Martedi.IsNull then
      Q221Martedi.AsString:=Sender.AsString;
    if Q221Mercoledi.IsNull then
      Q221Mercoledi.AsString:=Sender.AsString;
    if Q221Giovedi.IsNull then
      Q221Giovedi.AsString:=Sender.AsString;
    if Q221Venerdi.IsNull then
      Q221Venerdi.AsString:=Sender.AsString;
    if Q221Sabato.IsNull then
      Q221Sabato.AsString:=Sender.AsString;
    if Q221Domenica.IsNull then
      Q221Domenica.AsString:=Sender.AsString;
    if Q221NonLav.IsNull then
      Q221NonLav.AsString:=Sender.AsString;
    if Q221Festivo.IsNull then
      Q221Festivo.AsString:=Sender.AsString;
  end;
end;

procedure TA007FProfiliOrariDtM1.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('C','T220_PROFILIORARI',Copy(Name,1,4),Q220,True);
  A000AggiornaFiltroDizionario('PROFILI ORARIO',DataSet.FieldByName('CODICE').AsString,'');
  A000AggiornaFiltroDizionario('PROFILI ORARIO',DataSet.FieldByName('CODICE').AsString,'');
end;

procedure TA007FProfiliOrariDtM1.BeforePost(DataSet: TDataSet);
begin
  inherited;
  if DataSet.State = dsEdit then
    VecchioCodiceDizionario:=VarToStr(DataSet.FieldByName('CODICE').medpOldValue)
  else
    VecchioCodiceDizionario:='';
  //Se storicizzo devo riportare i ProfiliSettimanali sul nuovo periodo
  storic:=InterfacciaR004.StoricizzazioneInCorso and (Q221.RecordCount > 0);
  //Gestione del cambio codice/decorrenza per salvaguardare la foreign key
  if (Q220.State = dsEdit) and
     ((Q220.FieldByName('CODICE').Value <> Q220.FieldByName('CODICE').medpOldValue) or
      (Q220.FieldByName('DECORRENZA').Value <> Q220.FieldByName('DECORRENZA').medpOldValue)) then
  begin
    CodiceOld:=Q220.FieldByName('CODICE').medpOldValue;
    CodiceNew:=Q220.FieldByName('CODICE').Value;
    DecorrenzaOld:=Q220.FieldByName('DECORRENZA').medpOldValue;
    DecorrenzaNew:=Q220.FieldByName('DECORRENZA').Value;
    Q220.FieldByName('CODICE').Value:=Q220.FieldByName('CODICE').medpOldValue;
    Q220.FieldByName('DECORRENZA').Value:=Q220.FieldByName('DECORRENZA').medpOldValue;
  end;
end;

procedure TA007FProfiliOrariDtM1.AfterPost(DataSet: TDataSet);
var S:String;
begin
  //Abilitazione della foreign key sulla tabella T221
  S:=Q220.FieldByName('Codice').AsString;
  if Dataset.Name = 'Q221' then
    inherited
  else
  begin
    if storic then
      InterfacciaR004.OttimizzaStorico:=False;
    if (CodiceOld <> CodiceNew) or (DecorrenzaOld <> DecorrenzaNew) then
      CambiaCodiceDecorrenza;
    try
      inherited;
    finally
      InterfacciaR004.OttimizzaStorico:=True;
    end;
    A000AggiornaFiltroDizionario('PROFILI ORARIO',VecchioCodiceDizionario,S);
    if (CodiceOld <> CodiceNew) or (DecorrenzaOld <> DecorrenzaNew) then
    begin
      RegistraLog.SettaProprieta('M','T220_PROFILIORARI',Copy(Self.Name,1,4),nil,True);
      if CodiceOld <> CodiceNew  then
        RegistraLog.InserisciDato('CODICE',CodiceOld,CodiceNew);
      if DecorrenzaOld <> DecorrenzaNew  then
        RegistraLog.InserisciDato('DECORRENZA',DateToStr(DecorrenzaOld),DateToStr(DecorrenzaNew));
      RegistraLog.RegistraOperazione;
    end;
  end;
end;

procedure TA007FProfiliOrariDtM1.CambiaCodiceDecorrenza;
var i:Integer;
begin
  //Copia di selT020 con nuovo codice/decorrenza
  selT220CopiaR.SetVariable('CODICE',CodiceOld);
  selT220CopiaR.Open;
  selT220CopiaW.SetVariable('CODICE',CodiceNew);
  selT220CopiaW.Open;
  while not selT220CopiaR.Eof do
  begin
    if (CodiceOld <> CodiceNew) or (DecorrenzaOld = selT220CopiaR.FieldByname('DECORRENZA').AsDateTime) then
    begin
      selT220CopiaW.Append;
      for i:=0 to selT220CopiaR.FieldCount - 1 do
        selT220CopiaW.Fields[i].Value:=selT220CopiaR.Fields[i].Value;
      if CodiceOld <> CodiceNew then
        selT220CopiaW.FieldByName('CODICE').AsString:=CodiceNew;
      if DecorrenzaOld = selT220CopiaR.FieldByname('DECORRENZA').AsDateTime then
        selT220CopiaW.FieldByName('DECORRENZA').AsDateTime:=DecorrenzaNew;
      selT220CopiaW.Post;
    end;
    selT220CopiaR.Next;
  end;
  //Modifica di selT221
  selT221Copia.SetVariable('CODICE',CodiceOld);
  selT221Copia.Open;
  while not selT221Copia.Eof do
  begin
    if (CodiceOld <> CodiceNew) or (DecorrenzaOld = selT221Copia.FieldByname('DECORRENZA').AsDateTime) then
    begin
      selT221Copia.Edit;
      if CodiceOld <> CodiceNew then
        selT221Copia.FieldByname('CODICE').AsString:=CodiceNew;
      if DecorrenzaOld = selT221Copia.FieldByname('DECORRENZA').AsDateTime then
        selT221Copia.FieldByname('DECORRENZA').AsDateTime:=DecorrenzaNew;
      selT221Copia.Post;
    end;
    selT221Copia.Next;
  end;
  //Eliminazione di selT220 originale
  if DecorrenzaOld <> DecorrenzaNew then
    if selT220CopiaR.SearchRecord('DECORRENZA',DecorrenzaOld,[srFromBeginning]) then
      selT220CopiaR.Delete;
  if CodiceOld <> CodiceNew then
  begin
    selT220CopiaR.First;
    while not selT220CopiaR.Eof do
      selT220CopiaR.Delete;
  end;
  selT220CopiaW.CloseAll;
  selT220CopiaR.CloseAll;
  selT221Copia.CloseAll;
  Q220.Refresh;
  if CodiceOld <> CodiceNew then
    Q220.SearchRecord('CODICE',CodiceNew,[srFromBeginning]);
  Q220.SearchRecord('CODICE;DECORRENZA',VarArrayOf([CodiceNew,DecorrenzaNew]),[srFromBeginning]);
end;

procedure TA007FProfiliOrariDtM1.Q220AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if InterfacciaR004.StoricizzazioneInCorso = False then
  begin
    Q221.DisableControls;
    Q221.Close;
    Q221.SetVariable('Codice',Q220.FieldByName('Codice').AsString);
    Q221.SetVariable('Decorrenza',Q220.FieldByName('Decorrenza').AsDateTime);
    Q221.Open;
    Q221.EnableControls;
    A007FProfiliOrari.NumSettimane.Caption:=IntToStr(Q221.RecordCount);
  end;
end;

procedure TA007FProfiliOrariDtM1.FiltroDizionario(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if DataSet = Q220 then
    Accept:=A000FiltroDizionario('PROFILI ORARIO',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = Q020 then
    Accept:=A000FiltroDizionario('MODELLI ORARIO',DataSet.FieldByName('CODICE').AsString);  
end;

procedure TA007FProfiliOrariDtM1.Q221AfterCancel(DataSet: TDataSet);
begin
  inherited;
  A007FProfiliOrari.NumSettimane.Caption:=IntToStr(Q221.RecordCount);
end;

procedure TA007FProfiliOrariDtM1.Q221AfterPost(DataSet: TDataSet);
begin
  inherited;
  A007FProfiliOrari.NumSettimane.Caption:=IntToStr(Q221.RecordCount);
end;

procedure TA007FProfiliOrariDtM1.Q220ANTICIPOUSCITAGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

end.
