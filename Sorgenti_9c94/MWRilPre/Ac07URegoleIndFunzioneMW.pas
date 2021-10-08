unit Ac07URegoleIndFunzioneMW;

interface

uses
  System.SysUtils, System.Classes, System.Variants, R005UDataModuleMW, Oracle, Data.DB,
  OracleData, C180FunzioniGenerali, StrUtils, Datasnap.DBClient,
  A000UInterfaccia, A000UCostanti, A000UMessaggi, A000USessione;

type
  TAc07FRegoleIndFunzioneMW = class(TR005FDataModuleMW)
    selCSI005: TOracleDataSet;
    dsrCSI005: TDataSource;
    selCodice: TOracleDataSet;
    selT200: TOracleDataSet;
    selCodiceCODICE: TStringField;
    selCodiceDESCRIZIONE: TStringField;
    selID_CSI004: TOracleQuery;
    selCSI005ID: TIntegerField;
    selCSI005FASCIA: TStringField;
    selCSI005D_FASCIA: TStringField;
    selCSI005IMPORTO: TFloatField;
    selCSI005MAGG_DISAGIO_SERALE: TFloatField;
    selT210: TOracleDataSet;
    selT200CODICE: TStringField;
    selT200DESCRIZIONE: TStringField;
    selT210CODICE: TStringField;
    selT210DESCRIZIONE: TStringField;
    insCSI005: TOracleQuery;
    selT265: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selCSI005NewRecord(DataSet: TDataSet);
    procedure selCSI005BeforeDelete(DataSet: TDataSet);
    procedure selCSI005AfterDelete(DataSet: TDataSet);
    procedure selCSI005BeforePost(DataSet: TDataSet);
    procedure selCSI005AfterPost(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    DuplicaDettaglio:Boolean;
    procedure ImpostaDecorrenza(Query: TOracleDataSet; Decorrenza: TDateTime);
  public
    { Public declarations }
    selCSI004:TOracleDataSet;
    ListaAssenze:TStringList;
    procedure selCSI004AfterScroll;
    procedure selCSI004BeforePost(Storicizzazione:Boolean);
    procedure selCSI004AfterPost;
    procedure CaricamentoDati(Query: TOracleDataSet; ParametriDato: String; Decorrenza: TDateTime);
    procedure ImpostaDecorrenzaDatasetLookup;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TAc07FRegoleIndFunzioneMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT200.Open;
  selT210.Open;
  ListaAssenze:=TStringList.Create;
  with selT265 do
  begin
    Open;
    while not Eof do
    begin
      ListaAssenze.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    Close;
  end;
end;

procedure TAc07FRegoleIndFunzioneMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ListaAssenze);
end;

procedure TAc07FRegoleIndFunzioneMW.selCSI004AfterScroll;
begin
  if not selCSI004.Eof then //refreshrecord resetterebbe EOF e i cicli vanno in loop
  begin
    ImpostaDecorrenzaDatasetLookup;
    selCSI004.RefreshRecord;
  end;
  selCSI005.Close;
  selCSI005.SetVariable('ID',selCSI004.FieldByName('ID').AsInteger);
  selCSI005.Open;
end;

procedure TAc07FRegoleIndFunzioneMW.selCSI004BeforePost(Storicizzazione:Boolean);
var IdOld,IdNew:Integer;
begin
  DuplicaDettaglio:=False;
  if VarToStr(selCodice.Lookup('CODICE',selCSI004.FieldByName('CODICE').AsString,'CODICE')) = '' then
    raise exception.Create(Format(A000MSG_ERR_FMT_DATO_ELEM_LISTA,[selCSI004.FieldByName('CODICE').DisplayLabel]));
  if VarToStr(selT200.Lookup('CODICE',selCSI004.FieldByName('CONTRATTO').AsString,'CODICE')) = '' then
    raise exception.Create(Format(A000MSG_ERR_FMT_DATO_ELEM_LISTA,[selCSI004.FieldByName('CONTRATTO').DisplayLabel]));
  if Storicizzazione then
  begin
    IdOld:=selCSI004.FieldByName('ID').AsInteger;
    try
      selID_CSI004.Execute;
      IdNew:=selID_CSI004.Field(0);
    except
      raise exception.Create(A000MSG_Ac07_ERR_SEQUENZA_CSI004);
    end;
    selCSI004.FieldByName('ID').AsInteger:=IdNew;

    insCSI005.SetVariable('ID_OLD',IdOld);
    insCSI005.SetVariable('ID_NEW',IdNew);
    DuplicaDettaglio:=True;
  end;
end;

procedure TAc07FRegoleIndFunzioneMW.selCSI004AfterPost;
begin
  if DuplicaDettaglio then
  begin
    insCSI005.Execute;
    SessioneOracle.Commit;
  end;
  DuplicaDettaglio:=False;
end;

procedure TAc07FRegoleIndFunzioneMW.selCSI005NewRecord(DataSet: TDataSet);
begin
  inherited;
  selCSI005.FieldByName('ID').AsInteger:=selCSI004.FieldByName('ID').AsInteger;
  ImpostaDecorrenza(selCodice,selCSI004.FieldByName('DECORRENZA').AsDateTime);
end;

procedure TAc07FRegoleIndFunzioneMW.selCSI005BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TAc07FRegoleIndFunzioneMW.selCSI005AfterDelete(DataSet: TDataSet);
begin
  inherited;
  selCSI005AfterPost(DataSet);
end;

procedure TAc07FRegoleIndFunzioneMW.selCSI005BeforePost(DataSet: TDataSet);
begin
  if VarToStr(selT210.Lookup('CODICE',selCSI005.FieldByName('FASCIA').AsString,'CODICE')) = '' then
    raise exception.Create(Format(A000MSG_ERR_FMT_DATO_ELEM_LISTA,[selCSI005.FieldByName('FASCIA').DisplayLabel]));
  if selCSI005.FieldByName('IMPORTO').IsNull then
    raise exception.Create(Format(A000MSG_ERR_FMT_DATO_NON_VALORIZZATO,[selCSI005.FieldByName('IMPORTO').DisplayLabel]));
  case DataSet.State of
    dsInsert: RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:   RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TAc07FRegoleIndFunzioneMW.selCSI005AfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;//Per committare registrazione log e altre operazioni eventuali
end;

procedure TAc07FRegoleIndFunzioneMW.CaricamentoDati(Query: TOracleDataSet; ParametriDato:String; Decorrenza: TDateTime);
begin
  if A000LookupTabella(ParametriDato,Query) then
    ImpostaDecorrenza(Query,Decorrenza);
end;

procedure TAc07FRegoleIndFunzioneMW.ImpostaDecorrenzaDatasetLookup;
begin
  if Parametri.CampiRiferimento.C3_Indennita_Funzione <> '' then
    ImpostaDecorrenza(selCodice,selCSI004.FieldByName('DECORRENZA').AsDateTime);
end;

procedure TAc07FRegoleIndFunzioneMW.ImpostaDecorrenza(Query: TOracleDataSet; Decorrenza: TDateTime);
begin
  if Query.VariableIndex('DECORRENZA') >= 0 then
    Query.SetVariable('DECORRENZA',Decorrenza);
  Query.Close;
  Query.Open;
end;

end.
