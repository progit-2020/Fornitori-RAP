unit B022UUtilityGestDocumentaleDM;

interface

uses
  SysUtils, Forms, A000USessione, A000UInterfaccia, Oracle,
  Variants, C700USelezioneAnagrafe, B022UUtilityGestDocumentaleMW, OracleData, System.Classes, Data.DB,
  C021UDocumentiManagerDM;

type
  TB022FUtilityGestDocumentaleDM = class(TDataModule)
    selT960: TOracleDataSet;
    dsrT960: TDataSource;
    selT960PathStorage: TOracleDataSet;
    selT960PATH_STORAGE: TStringField;
    selT960ID: TFloatField;
    selT960PROGRESSIVO: TFloatField;
    selT960DIMENSIONE: TFloatField;
    selT960DATA_CREAZIONE: TDateTimeField;
    selT960INFO_FILE: TStringField;
    selDataCreazioneMinMax: TOracleDataSet;
    selT960MATRICOLA: TStringField;
    selT960NOMINATIVO: TStringField;
    selT960D_DIMENSIONE: TStringField;
    selI091: TOracleDataSet;
    selT962: TOracleDataSet;
    dsrT962: TDataSource;
    selT963: TOracleDataSet;
    dsrT963: TDataSource;
    selT960PROVENIENZA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT960BeforePost(DataSet: TDataSet);
    procedure selT960AfterPost(DataSet: TDataSet);
    procedure selT960CalcFields(DataSet: TDataSet);
  public
    B022FUtilityGestDocumentaleMW: TB022FUtilityGestDocumentaleMW;
    CodTipologiaDefault,CodUfficioDefault:String;
    IterMaxDimAllegatoMB:Integer;
    procedure ApplicaFiltri(UsaSelezioneAnagrafica: Boolean; PathStorage: String; DataInizio, DataFine: TDateTime);
    procedure ElaborazioneRecords(TipoElaborazione: Integer; PathStorage: String);
    function LeggiParametroI091(Parametro:String):String;
    procedure SalvaParametroI091(Parametro,Valore:String);
    const
      PARAM_PATH_ALLEGATI:String = 'C90_PATH_ALLEGATI';
      PARAM_URL_B021:String      = 'C30_WEBSRV_B021_URL';
end;

var
  B022FUtilityGestDocumentaleDM: TB022FUtilityGestDocumentaleDM;

implementation

{$R *.DFM}

procedure TB022FUtilityGestDocumentaleDM.ApplicaFiltri(UsaSelezioneAnagrafica: Boolean; PathStorage: String; DataInizio, DataFine: TDateTime);
begin
  selT960.Close;
  if UsaSelezioneAnagrafica then
  begin
    // implementazione nell'sql della c700
    C700MergeSelAnagrafe(selT960,False);
    C700MergeSettaPeriodo(selT960,DataInizio,DataFine);
    selT960.SetVariable('OUT_JOIN',null);
  end
  else
  begin
    selT960.SetVariable('C700SELANAGRAFE','T030_ANAGRAFICO T030 where :DATALAVORO = :DATALAVORO');
    selT960.SetVariable('DATALAVORO',Date);
    selT960.SetVariable('OUT_JOIN','(+)');
  end;
  if PathStorage = '' then
    selT960.SetVariable('PATH_STORAGE', 'and 1 <> 1')
  else
    selT960.SetVariable('PATH_STORAGE', 'and upper(PATH_STORAGE) in (' + PathStorage + ')');
  selT960.SetVariable('DAL', DataInizio);
  selT960.SetVariable('AL', DataFine);
  selT960.Open;
end;

procedure TB022FUtilityGestDocumentaleDM.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
  if not SessioneOracle.Connected then
  begin
    Password(Application.Title);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;

  // creazione MW
  B022FUtilityGestDocumentaleMW:=TB022FUtilityGestDocumentaleMW.Create(Self);

  // passaggio dei puntatori dei dataset
  B022FUtilityGestDocumentaleMW.selT960_Funzioni:=selT960;
  B022FUtilityGestDocumentaleMW.selT960PathStorage_Funzioni:=selT960PathStorage;

  // apertura dataset per la valorizzazione degli edit del periodo
  selDataCreazioneMinMax.Open;

  // apertura dataset per lettura e modifica parametri aziendali
  selI091.SetVariable('AZIENDA',Parametri.Azienda);
  selI091.Open;

  CodTipologiaDefault:=DOC_TIPOL_PREDEF;
  CodUfficioDefault:=DOC_UFFICIO_PREDEF;

  IterMaxDimAllegatoMB:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB,5);

  selT962.Filter:='CODICE <> ''' + DOC_TIPOL_ITER + '''';
  selT962.Filtered:=True;
  selT962.Open;
  selT962.First;
  while not selT962.Eof do
  begin
    // codice default
    if selT962.FieldByName('CODICE_DEFAULT').AsString = 'S' then
      CodTipologiaDefault:=selT962.FieldByName('CODICE').AsString;
    selT962.Next;
  end;
  selT962.First;

  selT963.Open;
  selT963.First;
  while not selT963.Eof do
  begin
    // codice default
    if selT963.FieldByName('CODICE_DEFAULT').AsString = 'S' then
      CodUfficioDefault:=selT963.FieldByName('CODICE').AsString;
    selT963.Next;
  end;
  selT963.First;
end;

procedure TB022FUtilityGestDocumentaleDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(B022FUtilityGestDocumentaleMW);
  inherited;
end;

procedure TB022FUtilityGestDocumentaleDM.ElaborazioneRecords(TipoElaborazione: Integer; PathStorage: String);
begin
  B022FUtilityGestDocumentaleMW.ElaborazioneRecords(TipoElaborazione, PathStorage);
end;

procedure TB022FUtilityGestDocumentaleDM.selT960AfterPost(DataSet: TDataSet);
begin
  B022FUtilityGestDocumentaleMW.selT960AfterPost;
end;

procedure TB022FUtilityGestDocumentaleDM.selT960BeforePost(DataSet: TDataSet);
begin
  B022FUtilityGestDocumentaleMW.selT960BeforePost;
end;

procedure TB022FUtilityGestDocumentaleDM.selT960CalcFields(DataSet: TDataSet);
begin
  B022FUtilityGestDocumentaleMW.selT960CalcFields;
end;

function TB022FUtilityGestDocumentaleDM.LeggiParametroI091(Parametro:String):String;
var
  Risultato:Variant;
begin
  Risultato:=selI091.Lookup('TIPO',Parametro,'DATO');
  if ((VarType(Risultato) and varTypeMask) = varBoolean) then // Se è un boolean può solo essere false
    raise Exception.Create(Parametro +' non esiste nei parametri aziendali');
  Result:=VarToStr(Risultato);
end;

procedure TB022FUtilityGestDocumentaleDM.SalvaParametroI091(Parametro,Valore:String);
begin
  if not selI091.SearchRecord('TIPO',Parametro,[srFromBeginning]) then
    raise Exception.Create(Parametro +' non esiste nei parametri aziendali');
  selI091.Edit;
  selI091.FieldByName('DATO').AsString:=Valore;
  selI091.Post;
end;

end.
