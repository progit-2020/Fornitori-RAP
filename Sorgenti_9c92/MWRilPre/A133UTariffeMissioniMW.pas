unit A133UTariffeMissioniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData,
  A000USessione, A000UInterfaccia, A000UMessaggi, Oracle, ControlloVociPaghe, Variants;

type
  TA133FTariffeMissioniMW = class(TR005FDataModuleMW)
    QSource: TOracleDataSet;
    DSource: TDataSource;
    dsrM066: TDataSource;
    selM066: TOracleDataSet;
    selM066COD_RIDUZIONE: TStringField;
    selM066DESCRIZIONE: TStringField;
    selM066PERC_RIDUZIONE: TFloatField;
    selM066QUOTA_ESENTE: TFloatField;
    selM066COEFF_MAGGIORAZIONE: TFloatField;
    selM066CODICE: TStringField;
    selM066COD_TARIFFA: TStringField;
    selM066DECORRENZA: TDateTimeField;
    InsM066: TOracleQuery;
    selT430: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selM066NewRecord(DataSet: TDataSet);
  private
    OldDecorrenza:TDateTime;
    FSelM065_Funzioni: TOracleDataset;
    selControlloVociPaghe:TControlloVociPaghe;
  public
    procedure relazionaM066;
    procedure selM065BeforeInsert;
    procedure selM065BeforePost;
    procedure selM065AfterPost(Storicizza: boolean);
    function VerificaVociPaghe(CampoCodVoce: String): String;
    procedure InserisciVocePaghe(CampoCodVoce: String);
    procedure TrovaCodice(Progressivo: Integer);
    property selM065_Funzioni: TOracleDataset read FSelM065_Funzioni write FSelM065_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA133FTariffeMissioniMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  if A000LookupTabella(Parametri.CampiRiferimento.C8_Missione,QSource) then
  begin
    if QSource.VariableIndex('DECORRENZA') >= 0 then
      QSource.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    QSource.Open;
  end
  else
    raise Exception.Create('Dato non specificato!');
  selM066.Open;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;

procedure TA133FTariffeMissioniMW.relazionaM066;
begin
  selM066.Close;
  selM066.SetVariable('CODICE',FSelM065_Funzioni.FieldByName('CODICE').AsString);
  selM066.SetVariable('CODTARIFFA',FSelM065_Funzioni.FieldByName('COD_TARIFFA').AsString);
  selM066.SetVariable('DECORRENZA',FSelM065_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  selM066.Open;
end;

procedure TA133FTariffeMissioniMW.selM065BeforePost;
begin
  if FSelM065_Funzioni.FieldByName('CODICE').AsString = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_CODICE]));

  if FSelM065_Funzioni.FieldByName('COD_TARIFFA').AsString = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A133_MSG_COD_TARIFFA]));

  if FSelM065_Funzioni.FieldByName('DECORRENZA').AsString = '' then
    Raise Exception.Create(A000MSG_ERR_DATA_DECORRENZA);
end;

procedure TA133FTariffeMissioniMW.selM065AfterPost(Storicizza: boolean);
begin
  //GESTIONE DUPLICAZIONE CODICI RIDUZIONE SU NUOVA STORICIZZAZIONE
  //SU CLOUD AUTOMATICO IMPOSTANDO TABELLERELAZIONATE
  if Storicizza then
  begin
    insM066.SetVariable('CODICE',FSelM065_Funzioni.FieldByName('CODICE').AsString);
    insM066.SetVariable('COD_TARIFFA',FSelM065_Funzioni.FieldByName('COD_TARIFFA').AsString);
    insM066.SetVariable('DECORRENZA_OLD',OldDecorrenza);
    insM066.SetVariable('DECORRENZA_NEW',FSelM065_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    insM066.Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TA133FTariffeMissioniMW.selM065BeforeInsert;
begin
  OldDecorrenza:=FSelM065_Funzioni.FieldByName('DECORRENZA').AsDateTime;
end;

procedure TA133FTariffeMissioniMW.selM066NewRecord(DataSet: TDataSet);
begin
  selM066.FieldByName('CODICE').AsString:=FSelM065_Funzioni.FieldByName('CODICE').AsString;
  selM066.FieldByName('COD_TARIFFA').AsString:=FSelM065_Funzioni.FieldByName('COD_TARIFFA').AsString;
  selM066.FieldByName('DECORRENZA').AsDateTime:=FSelM065_Funzioni.FieldByName('DECORRENZA').AsDateTime;
end;

function TA133FTariffeMissioniMW.VerificaVociPaghe(CampoCodVoce:String): String;
var VoceOld: String;
begin
  Result:='';
  if (FSelM065_Funzioni.State = dsInsert) or (FSelM065_Funzioni.FieldByName(CampoCodVoce).medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=FSelM065_Funzioni.FieldByName(CampoCodVoce).medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,FSelM065_Funzioni.FieldByName(CampoCodVoce).AsString) then
    Result:=selControlloVociPaghe.MessaggioLog;
end;

procedure TA133FTariffeMissioniMW.InserisciVocePaghe(CampoCodVoce:String);
begin
  //se voce vuota esco ma non faccio abort altrimenti interromperei il salvataggio
  if Trim(FSelM065_Funzioni.FieldByName(CampoCodVoce).AsString) = '' then Exit;

  if not selControlloVociPaghe.ValutaInserimentoVocePaghe(FSelM065_Funzioni.FieldByName(CampoCodVoce).AsString) then
    Abort;
end;

procedure TA133FTariffeMissioniMW.TrovaCodice(Progressivo: Integer);
begin
  selT430.SetVariable('DATOLIB',Parametri.CampiRiferimento.C8_Missione);
  selT430.SetVariable('PROGRESSIVO',Progressivo);
  selT430.SetVariable('DATALAV',Parametri.DataLavoro);
  selT430.Open;
  if selT430.RecordCount > 0 then
    FSelM065_Funzioni.SearchRecord('CODICE',selT430.FieldByName(Parametri.CampiRiferimento.C8_Missione).asString,[srFromBeginning])
  else
    FSelM065_Funzioni.First;
end;

procedure TA133FTariffeMissioniMW.DataModuleDestroy(Sender: TObject);
begin
  selM066.Close;
  QSource.Close;
  FreeAndNil(selControlloVociPaghe);
  inherited;
end;

end.
