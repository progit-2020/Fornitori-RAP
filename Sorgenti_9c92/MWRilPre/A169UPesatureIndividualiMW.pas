unit A169UPesatureIndividualiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, DB, Graphics,
  C180FunzioniGenerali, A000USessione, A000UInterfaccia, Forms, Controls, A169UCalcoloDTM, A000UMessaggi;

type
  TA169FPesatureIndividualiMW = class(TR005FDataModuleMW)
    selT765: TOracleDataSet;
    dsrT765: TDataSource;
    selV430: TOracleDataSet;
    selT773b: TOracleDataSet;
    ControlloT774: TOracleDataSet;
    selT774: TOracleDataSet;
    selT774ANNO: TFloatField;
    selT774CODGRUPPO: TStringField;
    selT774CODTIPOQUOTA: TStringField;
    selT774PROGRESSIVO: TIntegerField;
    selT774MATRICOLA: TStringField;
    selT774COGNOME: TStringField;
    selT774NOME: TStringField;
    selT774DATAINIZIO: TDateTimeField;
    selT774DATAFINE: TDateTimeField;
    selT774GG_SERVIZIO: TFloatField;
    selT774OBIETTIVI_ASSEGNATI: TStringField;
    selT774PESO_INDIVIDUALE: TFloatField;
    selT774QUOTA_INDIVIDUALE: TFloatField;
    selT774QUOTA_ASSEGNATA: TFloatField;
    selT774PESO_CALCOLATO: TFloatField;
    selT774QUOTA_CALCOLATA: TFloatField;
    dsrT774: TDataSource;
    procedure selT774PESO_INDIVIDUALEValidate(Sender: TField);
    procedure AfterPostInizio;
    procedure AfterPostElaboraElemento;
    procedure selT774BeforeInsert(DataSet: TDataSet);
    procedure selT774BeforeDelete(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public
    A169FCalcoloDTM: TA169FCalcoloDTM;
    selT773: TOracleDataSet;
    AggT774,InsT774:Boolean;
    InizioCiclo: procedure of object;
    AvanzamentoCiclo: procedure of object;
    FineCiclo: procedure of object;
    procedure selT773AfterScroll(DataSet: TDataSet);
    procedure selT773FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure AfterPost(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet);
    procedure selT773NewRecord(DataSet: TDataSet);
    function  SumT774PesoIndividuale:Real;
    function  SumT774QuotaIndividuale:Real;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA169FPesatureIndividualiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A169FCalcoloDTM:=TA169FCalcoloDTM.Create(Self);
  selT765.SetVariable('DEC',StrToDate('01/01/1900'));
  selT765.Open;
end;

procedure TA169FPesatureIndividualiMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A169FCalcoloDTM);
end;

procedure TA169FPesatureIndividualiMW.selT773AfterScroll(DataSet: TDataSet);
begin
  inherited;
  selT774.Close;
  selT774.SetVariable('ANNO',selT773.FieldByName('ANNO').AsInteger);
  selT774.SetVariable('CODICE',selT773.FieldByName('CODGRUPPO').AsString);
  selT774.SetVariable('CODQUOTA',selT773.FieldByName('CODTIPOQUOTA').AsString);
  selT774.Open;
//  Aggiorna(False,False);
end;

procedure TA169FPesatureIndividualiMW.selT773FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('GRUPPI PESATURE INDIVIDUALI',DataSet.FieldByName('CODGRUPPO').AsString);
end;

procedure TA169FPesatureIndividualiMW.AfterPost(DataSet: TDataSet);
var s:String;
begin
  inherited;
  if not InsT774 then
   exit;
  selT774.Close;
  selT774.SetVariable('ANNO',selT773.FieldByName('ANNO').AsInteger);
  selT774.SetVariable('CODICE',selT773.FieldByName('CODGRUPPO').AsString);
  selT774.SetVariable('CODQUOTA',selT773.FieldByName('CODTIPOQUOTA').AsString);
  selT774.Open;
  selT774.ReadOnly:=False;
  selT774.BeforeInsert:=nil;
  //Carico tutti i dip. che verificano il filtro anagrafe del gruppo e sono in servizio dal 1/1/Anno a DataRif
  selV430.Close;
  selV430.SetVariable('DATAINIZIO',StrToDate('01/01/' + selT773.FieldByName('ANNO').AsString));
  selV430.SetVariable('DATAFINE',selT773.FieldByName('DATARIF').AsDateTime);
  selV430.SetVariable('FILTRO',selT773.FieldByName('FILTRO_ANAGRAFE').AsString);
  selV430.Open;

  if Assigned(InizioCiclo) then
    InizioCiclo;//implementata sul dtm per gestire l'interfaccia win
  RegistraMsg.IniziaMessaggio(NomeOwner);
  selV430.First;
  while not selV430.Eof do
  begin
    if Assigned(AvanzamentoCiclo) then
      AvanzamentoCiclo;//implementata sul dtm per gestire l'interfaccia win

    //Controllare che il dip. non verifichi altri filtri, non faccia parte di altri gruppi else anomalia
    ControlloT774.Close;
    ControlloT774.SetVariable('ANNO',selT773.FieldByName('ANNO').AsInteger);
    ControlloT774.SetVariable('QUOTA',selT773.FieldByName('CODTIPOQUOTA').AsString);
    ControlloT774.SetVariable('GRUPPO',selT773.FieldByName('CODGRUPPO').AsString);
    ControlloT774.SetVariable('PROG',selV430.FieldByName('PROGRESSIVO').AsInteger);
    ControlloT774.SetVariable('INIZIO',selV430.FieldByName('DATAINIZIO').AsDateTime);
    ControlloT774.SetVariable('FINE',selV430.FieldByName('DATAFINE').AsDateTime);
    ControlloT774.Open;

    if ControlloT774.RecordCount > 0 then
    begin
      //Anomalia
      s:=A000MSG_A169_MSG_DIPENDENTI_GRUPPO + ControlloT774.FieldByName('CODGRUPPO').AsString;
      RegistraMsg.InserisciMessaggio('A',s,'',selV430.FieldByName('PROGRESSIVO').AsInteger);
    end
    else
    begin
      selT774.Insert;
      selT774.FieldByName('ANNO').AsInteger:=selT773.FieldByName('ANNO').AsInteger;
      selT774.FieldByName('CODGRUPPO').AsString:=selT773.FieldByName('CODGRUPPO').AsString;
      selT774.FieldByName('CODTIPOQUOTA').AsString:=selT773.FieldByName('CODTIPOQUOTA').AsString;
      selT774.FieldByName('PROGRESSIVO').AsInteger:=selV430.FieldByName('PROGRESSIVO').AsInteger;
      selT774.FieldByName('PESO_INDIVIDUALE').AsFloat:=selT773.FieldByName('PESO_IND_MIN').AsFloat;
      selT774.FieldByName('GG_SERVIZIO').AsInteger:=selV430.FieldByName('GGSERVIZIO').AsInteger;
      selT774.FieldByName('DATAINIZIO').AsDateTime:=selV430.FieldByName('DATAINIZIO').AsDateTime;
      selT774.FieldByName('DATAFINE').AsDateTime:=selV430.FieldByName('DATAFINE').AsDateTime;
      A169FCalcoloDTM.CalcolaQuota('',selT774.FieldByName('CODTIPOQUOTA').AsString,selT774.FieldByName('PROGRESSIVO').AsInteger,selT774.FieldByName('ANNO').AsInteger,
      selT774.FieldByName('GG_SERVIZIO').AsFloat,selT774.FieldByName('PESO_INDIVIDUALE').AsFloat);
      selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat:=A169FCalcoloDTM.QuotaIndividuale;
      if selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat = 0 then
         selT774.FieldByName('PESO_INDIVIDUALE').AsFloat:=0;
      selT774.FieldByName('QUOTA_ASSEGNATA').AsFloat:=R180Arrotonda(selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat * selT774.FieldByName('PESO_INDIVIDUALE').AsFloat,0.01,'P');
      selT774.FieldByName('PESO_CALCOLATO').AsFloat:=A169FCalcoloDTM.PesoCalcolato;
      selT774.FieldByName('QUOTA_CALCOLATA').AsFloat:=A169FCalcoloDTM.QuotaCalcolata;
      selT774.FieldByName('OBIETTIVI_ASSEGNATI').AsString:='N';
      selT774.Post;
      SessioneOracle.ApplyUpdates([selT774],True);
    end;
    selV430.Next;
  end;
  selT774.Refresh;
  selT774.ReadOnly:=True;
  selT774.BeforeInsert:=selT774BeforeInsert;

  if Assigned(FineCiclo) then
    FineCiclo;//implementata sul dtm per gestire l'interfaccia win
end;

procedure TA169FPesatureIndividualiMW.selT774BeforeDelete(DataSet: TDataSet);
begin
  Abort;
  inherited;
end;

procedure TA169FPesatureIndividualiMW.selT774BeforeInsert(DataSet: TDataSet);
begin
  Abort;
  inherited;
end;

procedure TA169FPesatureIndividualiMW.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if Trim(selT773.FieldByName('ANNO').AsString) = '' then
  begin
    //A169FPesatureIndividuali.dedtAnno.SetFocus;
    raise exception.Create(A000MSG_A172_ERR_ANNO_RIF);
  end;
  if selT773.FieldByName('DATARIF').IsNull then
     selT773.FieldByName('DATARIF').AsDateTime:=StrToDate('31/12/' + selT773.FieldByName('ANNO').AsString);
  if R180Anno(selT773.FieldByName('DATARIF').AsDateTime) <> selT773.FieldByName('ANNO').AsInteger then
  begin
    //A169FPesatureIndividuali.dedtDataRif.SetFocus;
    raise exception.Create(A000MSG_A172_ERR_DATA_RIF);
  end;
  if Trim(selT773.FieldByName('CODTIPOQUOTA').AsString) = '' then
  begin
    //A169FPesatureIndividuali.dcmbTipoQuota.SetFocus;
    raise exception.Create('Indicare il tipo quota!');
  end;
  if Trim(selT773.FieldByName('FILTRO_ANAGRAFE').AsString) = '' then
  begin
    //A169FPesatureIndividuali.dedtFiltroAnagrafe.SetFocus;
    raise exception.Create(A000MSG_A172_ERR_NO_FILTRO_ANAG);
  end;
  if Trim(selT773.FieldByName('FILTRO_ANAGRAFE').AsString) <> '' then
  begin
    selV430.Close;
    selV430.SetVariable('DATAINIZIO',StrToDate('01/01/' + selT773.FieldByName('ANNO').AsString));
    selV430.SetVariable('DATAFINE',selT773.FieldByName('DATARIF').AsDateTime);
    selV430.SetVariable('FILTRO',selT773.FieldByName('FILTRO_ANAGRAFE').AsString);
    try
      selV430.Open;
    except
      //A169FPesatureIndividuali.dedtFiltroAnagrafe.SetFocus;
      raise exception.Create(A000MSG_A172_ERR_FILTRO_ANAG);
    end;
  end;
  if selT773.FieldByName('PESO_IND_MIN').AsFloat = 0 then
  begin
    //A169FPesatureIndividuali.dedtPesoIndMin.SetFocus;
    raise exception.Create(A000MSG_A169_MSG_PESO_MINIMO);
  end;

  //aggiungere controllo che selT773.FieldByName('PESO_TOTALE').AsFloat >= SumT774PesoIndividuale
  //raise exception.Create('Attenzione: totale pesi base superiore al peso totale previsto!');
  if (selT773.FieldByName('PESO_TOTALE').AsFloat < SumT774PesoIndividuale) then
      raise exception.Create(A000MSG_A169_ERR_PESI_BASE);

  AggT774:=False;
  InsT774:=False;
  if selT773.State = dsInsert then
     InsT774:=True;
  if (selT773.State = dsEdit) and
     ((selT773.FieldByName('ANNO').medpOldValue <> selT773.FieldByName('ANNO').AsInteger) or
      (selT773.FieldByName('DATARIF').medpOldValue <> selT773.FieldByName('DATARIF').AsDateTime) or
      (selT773.FieldByName('FILTRO_ANAGRAFE').medpOldValue <> selT773.FieldByName('FILTRO_ANAGRAFE').AsString)) then
    AggT774:=True;
end;

procedure TA169FPesatureIndividualiMW.selT773NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT773.FieldByName('ANNO').AsInteger:=R180Anno(Parametri.DataLavoro);
  selT773.FieldByName('PESO_IND_MIN').AsFloat:=1;
end;

procedure TA169FPesatureIndividualiMW.selT774PESO_INDIVIDUALEValidate(
  Sender: TField);
begin
  inherited;
  if (selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat > 0) and
     (selT774.FieldByName('PESO_INDIVIDUALE').AsFloat < selT773.FieldByName('PESO_IND_MIN').AsFloat) then
    raise exception.Create(A000MSG_A169_MSG_PESO_INFERIORE);
  if (selT773.FieldByName('PESO_IND_MAX').AsFloat <> 0) and
     (selT774.FieldByName('PESO_INDIVIDUALE').AsFloat > selT773.FieldByName('PESO_IND_MAX').AsFloat) then
    raise exception.Create(A000MSG_A169_MSG_PESO_SUPERIORE);
  A169FCalcoloDtM.CalcolaQuota('C',selT774.FieldByName('CODTIPOQUOTA').AsString,selT774.FieldByName('PROGRESSIVO').AsInteger,selT774.FieldByName('ANNO').AsInteger,
  selT774.FieldByName('GG_SERVIZIO').AsFloat,selT774.FieldByName('PESO_INDIVIDUALE').AsFloat);
  selT774.FieldByName('PESO_CALCOLATO').AsFloat:=A169FCalcoloDtM.PesoCalcolato;
  selT774.FieldByName('QUOTA_CALCOLATA').AsFloat:=A169FCalcoloDtM.QuotaCalcolata;
  selT774.FieldByName('QUOTA_ASSEGNATA').AsFloat:=R180Arrotonda(selT774.FieldByName('PESO_INDIVIDUALE').AsFloat *
                                                                selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat,0.01,'P');
  //Alberto 26/02/2015: remmato perchè in Cloud viene eseguito sempre forzando 'S'; sembra invece permesso indicare un valore diverso in OBIETTIVI_ASSEGNATI
  //selT774.FieldByName('OBIETTIVI_ASSEGNATI').AsString:='S';
end;

function TA169FPesatureIndividualiMW.SumT774PesoIndividuale:Real;
begin
  Result:=0;
  with selT774 do
  begin
    First;
    while not Eof do
    begin
      Result:=Result + FieldByName('PESO_INDIVIDUALE').AsFloat;
      Next;
    end;
  end;
end;

function TA169FPesatureIndividualiMW.SumT774QuotaIndividuale:Real;
begin
  Result:=0;
  with selT774 do
  begin
    First;
    while not Eof do
    begin
      Result:=Result + FieldByName('QUOTA_INDIVIDUALE').AsFloat;
      Next;
    end;
  end;
end;


procedure TA169FPesatureIndividualiMW.AfterPostInizio;
begin
    RegistraMsg.IniziaMessaggio(NomeOwner);
    selV430.Close;
    selV430.SetVariable('DATAINIZIO',StrToDate('01/01/' + selT773.FieldByName('ANNO').AsString));
    selV430.SetVariable('DATAFINE',selT773.FieldByName('DATARIF').AsDateTime);
    selV430.SetVariable('FILTRO',selT773.FieldByName('FILTRO_ANAGRAFE').AsString);
    selV430.Open;
end;

procedure TA169FPesatureIndividualiMW.AfterPostElaboraElemento;
var s:String;
begin
  //Controllare che il dip. non verifichi altri filtri, non faccia parte di altri gruppi else anomalia
  ControlloT774.Close;
  ControlloT774.SetVariable('ANNO',selT773.FieldByName('ANNO').AsInteger);
  ControlloT774.SetVariable('QUOTA',selT773.FieldByName('CODTIPOQUOTA').AsString);
  ControlloT774.SetVariable('GRUPPO',selT773.FieldByName('CODGRUPPO').AsString);
  ControlloT774.SetVariable('PROG',selV430.FieldByName('PROGRESSIVO').AsInteger);
  ControlloT774.SetVariable('INIZIO',selV430.FieldByName('DATAINIZIO').AsDateTime);
  ControlloT774.SetVariable('FINE',selV430.FieldByName('DATAFINE').AsDateTime);
  ControlloT774.Open;
  if ControlloT774.RecordCount > 0 then
  begin
    //Anomalia
    s:=A000MSG_A169_MSG_DIPENDENTI_GRUPPO + ControlloT774.FieldByName('CODGRUPPO').AsString;
    RegistraMsg.InserisciMessaggio('A',s,'',selV430.FieldByName('PROGRESSIVO').AsInteger);
  end
  else
  begin
    selT774.Insert;
    selT774.FieldByName('ANNO').AsInteger:=selT773.FieldByName('ANNO').AsInteger;
    selT774.FieldByName('CODGRUPPO').AsString:=selT773.FieldByName('CODGRUPPO').AsString;
    selT774.FieldByName('CODTIPOQUOTA').AsString:=selT773.FieldByName('CODTIPOQUOTA').AsString;
    selT774.FieldByName('PROGRESSIVO').AsInteger:=selV430.FieldByName('PROGRESSIVO').AsInteger;
    selT774.FieldByName('PESO_INDIVIDUALE').AsFloat:=selT773.FieldByName('PESO_IND_MIN').AsFloat;
    selT774.FieldByName('GG_SERVIZIO').AsInteger:=selV430.FieldByName('GGSERVIZIO').AsInteger;
    selT774.FieldByName('DATAINIZIO').AsDateTime:=selV430.FieldByName('DATAINIZIO').AsDateTime;
    selT774.FieldByName('DATAFINE').AsDateTime:=selV430.FieldByName('DATAFINE').AsDateTime;
    A169FCalcoloDTM.CalcolaQuota('',selT774.FieldByName('CODTIPOQUOTA').AsString,selT774.FieldByName('PROGRESSIVO').AsInteger,selT774.FieldByName('ANNO').AsInteger,
      selT774.FieldByName('GG_SERVIZIO').AsFloat,selT774.FieldByName('PESO_INDIVIDUALE').AsFloat);
    selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat:=A169FCalcoloDTM.QuotaIndividuale;
    if selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat = 0 then
      selT774.FieldByName('PESO_INDIVIDUALE').AsFloat:=0;
    selT774.FieldByName('QUOTA_ASSEGNATA').AsFloat:=R180Arrotonda(selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat * selT774.FieldByName('PESO_INDIVIDUALE').AsFloat,0.01,'P');
    selT774.FieldByName('PESO_CALCOLATO').AsFloat:=A169FCalcoloDTM.PesoCalcolato;
    selT774.FieldByName('QUOTA_CALCOLATA').AsFloat:=A169FCalcoloDTM.QuotaCalcolata;
    selT774.FieldByName('OBIETTIVI_ASSEGNATI').AsString:='N';
    selT774.Post;
    SessioneOracle.ApplyUpdates([selT774],True);
  end;
end;

end.
