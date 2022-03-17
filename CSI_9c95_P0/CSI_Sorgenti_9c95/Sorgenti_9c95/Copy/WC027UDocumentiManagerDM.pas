unit WC027UDocumentiManagerDM;

interface

uses
  Oracle, OracleData,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  C180FunzioniGenerali, System.Classes, Data.DB,
  System.Generics.Collections, IWGlobal, IWApplication,
  IOUtils, System.TypInfo, System.SysUtils;

type
  TDocumento = class
  private
    FId: Integer;
    FDataCreazione: TDateTime;
    FNomeUtente: String;
    FUtente: String;
    FProgressivo: Integer;
    FTipologia: String;
    FUfficio: String;
    FNomeFile: String;
    FExtFile: String;
    FTempFile: String;
    FDimensione: Int64;
    FPeriodoDal: TDateTime;
    FPeriodoAl: TDateTime;
    FNote: String;
    FBlob: TLOBLocator;
    function  GeneraID: Integer;
    procedure SetProgressivo(const PVal: Integer);
    procedure SetPeriodoDal(PVal: TDateTime);
    procedure SetPeriodoAl(PVal: TDateTime);
    procedure SetNomeFile(const PVal: String);
    procedure SetExtFile(const PVal: String);
    procedure SetTempFile(const PVal: String);
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    function  GetNomeFileCompleto: String;
    procedure SetNomeFileCompleto(const PVal: String);
    property Id: Integer read FId write FId;
    property DataCreazione: TDateTime read FDataCreazione write FDataCreazione;
    property NomeUtente: String read FNomeUtente write FNomeUtente;
    property Utente: String read FUtente write FUtente;
    property Progressivo: Integer read FProgressivo write SetProgressivo;
    property Tipologia: String read FTipologia write FTipologia;
    property Ufficio: String read FUfficio write FUfficio;
    property NomeFile: String read FNomeFile write SetNomeFile;
    property ExtFile: String read FExtFile write SetExtFile;
    property TempFile: String read FTempFile write SetTempFile;
    property Dimensione: Int64 read FDimensione write FDimensione;
    property PeriodoDal: TDateTime read FPeriodoDal write SetPeriodoDal;
    property PeriodoAl: TDateTime read FPeriodoAl write SetPeriodoAl;
    property Note: String read FNote write FNote;
    property Blob: TLOBLocator read FBlob write FBlob;
  end;

  TWC027FDocumentiManagerDM = class(TDataModule)
    selT960: TOracleDataSet;
    selT961: TOracleQuery;
    insT961: TOracleQuery;
    selT960Count: TOracleQuery;
    delT960: TOracleQuery;
    delT961: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    function  FindById(const PId: Integer): Boolean;
    function  GetById(const PId: Integer; const PReadBlob: Boolean = True): TDocumento;
    function  Save(PDoc: TDocumento; var RErrMsg: String): Boolean;
    function  Delete(const PId: Integer; var RErrMsg: String): Boolean;
  end;

const
  DOC_TIPOLOGIA_ITER = 'ITER';
  // ufficio predefinito (in assenza di default specificato)
  DOC_UFFICIO_PREDEF      = '*';

implementation

{$R *.dfm}

procedure TWC027FDocumentiManagerDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
 except
 end;
end;

procedure TWC027FDocumentiManagerDM.DataModuleDestroy(Sender: TObject);
var
  i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).CloseAll;
    if Self.Components[i] is TOracleQuery then
      (Self.Components[i] as TOracleQuery).Close;
  end;
 except
 end;
end;

function TWC027FDocumentiManagerDM.FindById(const PId: Integer): Boolean;
// cerca il documento sulla tabella T960
// restituisce
//   - True se il documento è stato trovato
//   - False altrimenti
begin
  // conta record su T960 con l'ID indicato
  selT960Count.SetVariable('ID',PId);
  selT960Count.Execute;
  Result:=selT960Count.FieldAsInteger(0) > 0;
end;

function TWC027FDocumentiManagerDM.GetById(const PId: Integer; const PReadBlob: Boolean = True): TDocumento;
// estrae il documento indicato in base all'id
// se PReadBlob = True estrae anche il blob
begin
  Result:=nil;

  // apertura dataset dei metadati del documento
  selT960.Close;
  selT960.SetVariable('ID',PId);
  selT960.Open;
  if selT960.RecordCount = 0 then
    Exit;

  // crea l'oggetto documento
  Result:=TDocumento.Create;

  // imposta i metadati
  Result.Id:=PId;
  Result.DataCreazione:=selT960.FieldByName('DATA_CREAZIONE').AsDateTime;
  Result.NomeUtente:=selT960.FieldByName('NOME_UTENTE').AsString;
  Result.Utente:=selT960.FieldByName('UTENTE').AsString;
  Result.Progressivo:=selT960.FieldByName('PROGRESSIVO').AsInteger;
  Result.Tipologia:=selT960.FieldByName('TIPOLOGIA').AsString;
  Result.Ufficio:=selT960.FieldByName('UFFICIO').AsString;
  Result.NomeFile:=selT960.FieldByName('NOME_FILE').AsString;
  Result.ExtFile:=selT960.FieldByName('EXT_FILE').AsString;
  Result.Dimensione:=selT960.FieldByName('DIMENSIONE').AsLargeInt;
  Result.PeriodoDal:=selT960.FieldByName('PERIODO_DAL').AsDateTime;
  Result.PeriodoAl:=selT960.FieldByName('PERIODO_AL').AsDateTime;
  Result.Note:=selT960.FieldByName('NOTE').AsString;

  // valuta estrazione blob
  if PReadBlob then
  begin
    // imposta il documento binario nel lob locator
    selT961.SetVariable('ID',PId);
    selT961.Execute;
    Result.Blob:=selT961.LOBField('DOCUMENTO');
    Result.Blob.Tag:=0;
  end
  else
  begin
    Result.Blob:=nil;
  end;
end;

function TWC027FDocumentiManagerDM.Delete(const PId: Integer; var RErrMsg: String): Boolean;
// elimina dal database il documento con l'id indicato
// restituisce
//   - True:  se l'operazione è andata a buon fine
//   - False: in caso di errori (valorizza RErrMsg con il messaggio di errore)
begin
  Result:=False;
  RErrMsg:='';

  try
    // cancellazione di T961 (blob)
    delT961.SetVariable('ID',PId);
    delT961.Execute;

    // cancellazione di T960 (metadati)
    delT960.SetVariable('ID',PId);
    delT960.Execute;
  except
    on E: Exception do
    begin
      RErrMsg:=Format(A000TraduzioneStringhe(A000MSG_WC027_ERR_FMT_ELIMINA_DOC),[E.Message]);
      Exit;
    end;
  end;

  // operazione ok
  Result:=True;
end;

function TWC027FDocumentiManagerDM.Save(PDoc: TDocumento; var RErrMsg: String): Boolean;
// salva il documento su db effettuando inserimento o aggiornamento
// - inserimento: metadati + blob
// - aggiornamento: metadati
// restituisce
//   - True:  se l'operazione è andata a buon fine
//   - False: in caso di errori (valorizza RErrMsg con il messaggio di errore)
begin
  Result:=False;
  RErrMsg:='';

  // genera id documento
  if PDoc.Id = 0 then
    PDoc.Id:=PDoc.GeneraID;

  // apertura dataset dei metadati del documento
  try
    selT960.Close;
    selT960.SetVariable('ID',PDoc.Id);
    selT960.Open;
    if selT960.RecordCount = 0 then
    begin
      // inserimento del record su T960
      selT960.Append;
      selT960.FieldByName('ID').AsInteger:=PDoc.Id;
      selT960.FieldByName('DATA_CREAZIONE').AsDateTime:=PDoc.DataCreazione;
      selT960.FieldByName('NOME_UTENTE').AsString:=PDoc.NomeUtente;
      selT960.FieldByName('UTENTE').AsString:=PDoc.Utente;
      selT960.FieldByName('PROGRESSIVO').AsInteger:=PDoc.Progressivo;
      selT960.FieldByName('TIPOLOGIA').AsString:=PDoc.Tipologia;
      selT960.FieldByName('UFFICIO').AsString:=PDoc.Ufficio;
      selT960.FieldByName('NOME_FILE').AsString:=PDoc.NomeFile;
      selT960.FieldByName('EXT_FILE').AsString:=PDoc.ExtFile;
      selT960.FieldByName('DIMENSIONE').AsInteger:=PDoc.Dimensione;
      selT960.FieldByName('PERIODO_DAL').AsDateTime:=PDoc.PeriodoDal;
      selT960.FieldByName('PERIODO_AL').AsDateTime:=PDoc.PeriodoAl;
      selT960.FieldByName('NOTE').AsString:=PDoc.Note;
      selT960.Post;

      // inserimento del blob su T961
      insT961.SetVariable('ID',PDoc.Id);
      insT961.SetComplexVariable('DOCUMENTO',PDoc.Blob);
      insT961.Execute;

      // elimina il file temporaneo del documento dalla user cache directory
      TFile.Delete(PDoc.TempFile);
    end
    else
    begin
      // modifica del record su T960
      selT960.Edit;
      // selT960.FieldByName('DATA_CREAZIONE').AsDateTime:= // non impostata su update
      selT960.FieldByName('NOME_UTENTE').AsString:=PDoc.NomeUtente;
      selT960.FieldByName('UTENTE').AsString:=PDoc.Utente;
      selT960.FieldByName('PROGRESSIVO').AsInteger:=PDoc.Progressivo;
      selT960.FieldByName('TIPOLOGIA').AsString:=PDoc.Tipologia;
      selT960.FieldByName('UFFICIO').AsString:=PDoc.Ufficio;
      selT960.FieldByName('NOME_FILE').AsString:=PDoc.NomeFile;
      selT960.FieldByName('EXT_FILE').AsString:=PDoc.ExtFile;
      selT960.FieldByName('DIMENSIONE').AsInteger:=PDoc.Dimensione;
      selT960.FieldByName('PERIODO_DAL').AsDateTime:=PDoc.PeriodoDal;
      selT960.FieldByName('PERIODO_AL').AsDateTime:=PDoc.PeriodoAl;
      selT960.FieldByName('NOTE').AsString:=PDoc.Note;
      selT960.Post;
    end;
  except
    on E: Exception do
    begin
      RErrMsg:=Format(A000TraduzioneStringhe(A000MSG_WC027_ERR_FMT_SALVA_DOC),[E.Message]);
      Exit;
    end;
  end;

  // operazione ok
  Result:=True;
end;

{ TDocumento }

constructor TDocumento.Create;
begin
  inherited;

  // pulizia proprietà
  Clear;

  // impostazione proprietà determinabili automaticamente
  FDataCreazione:=Now;
  if WR000DM.TipoUtente = 'Dipendente' then
  begin
    FNomeUtente:=Parametri.Username;
    FUtente:='';
  end
  else
  begin
    FNomeUtente:='';
    FUtente:=Parametri.Operatore;
  end;
end;

destructor TDocumento.Destroy;
begin
  // distruzione blob
  if (Blob <> nil) and (Blob.Tag = 1) then
  begin
    try Blob.Free; except end;
  end;

  inherited;
end;

procedure TDocumento.Clear;
// pulisce le proprietà dell'oggetto
begin
  FId:=0;
  FDataCreazione:=DATE_NULL;
  FNomeUtente:='';
  FUtente:='';
  FProgressivo:=0;
  FTipologia:='';
  FUfficio:='';
  FNomeFile:='';
  FExtFile:='';
  FDimensione:=0;
  FPeriodoDal:=DATE_NULL;
  FPeriodoAl:=DATE_NULL;
  FNote:='';
end;

function TDocumento.GeneraID: Integer;
// genera un nuovo id documento utilizzando la sequence oracle T960_ID
// restituendone il valore
var
  OQ: TOracleQuery;
begin
  OQ:=TOracleQuery.Create(nil);
  try
    try
      OQ.Session:=SessioneOracle;
      OQ.SQL.Text:='select T960_ID.nextval from dual';
      OQ.Execute;
      Result:=OQ.FieldAsInteger(0);
    except
      Result:=-1;
    end;
  finally
    FreeAndNil(OQ);
  end;
end;

procedure TDocumento.SetNomeFile(const PVal: String);
// imposta il nome del file senza estensione
begin
  if TPath.GetExtension(PVal).Trim <> '' then
    FNomeFile:=TPath.GetFileNameWithoutExtension(PVal)
  else
    FNomeFile:=PVal;
end;

procedure TDocumento.SetExtFile(const PVal: String);
// imposta l'estensione del file senza separatore
begin
  if PVal.StartsWith(TPath.ExtensionSeparatorChar) then
    FExtFile:=PVal.Substring(1)
  else
    FExtFile:=PVal;
end;

procedure TDocumento.SetTempFile(const PVal: String);
// imposta il file temporaneo per download e upload
begin
  if PVal = '' then
    FTempFile:=''
  else
    FTempFile:=PVal;
end;

function TDocumento.GetNomeFileCompleto: String;
// estrae il nome del file completo di estensione
begin
  Result:=Format('%s%s%s',[FNomeFile,TPath.ExtensionSeparatorChar,FExtFile]);
end;

procedure TDocumento.SetNomeFileCompleto(const PVal: String);
// imposta in proprietà distinte il nome file del documento e l'estensione
begin
  if PVal = '' then
  begin
    FNomeFile:='';
    FExtFile:='';
    FTempFile:='';
  end
  else
  begin
    // imposta il nome del file e l'estensione (per questa rimuove il separatore)
    FNomeFile:=TPath.GetFileNameWithoutExtension(PVal);
    FExtFile:=TPath.GetExtension(PVal).Replace(TPath.ExtensionSeparatorChar,'');

    // imposta il file temporaneo per upload e download
    FTempFile:=GGetWebApplicationThreadVar.UserCacheDir + PVal;
  end;
end;

procedure TDocumento.SetProgressivo(const PVal: Integer);
begin
  FProgressivo:=PVal;
end;

procedure TDocumento.SetPeriodoDal(PVal: TDateTime);
// imposta data iniziale periodo
begin
  // limita il valore indicato
  if PVal < DATE_MIN then
    PVal:=DATE_MIN;

  // controllo periodo
  if PVal > FPeriodoAl then
    FPeriodoAl:=PVal;

  FPeriodoDal:=PVal;
end;

procedure TDocumento.SetPeriodoAl(PVal: TDateTime);
// imposta data finale periodo
begin
  // limita il valore indicato
  if PVal > DATE_MAX then
    PVal:=DATE_MAX;

  // controllo periodo
  if PVal < FPeriodoDal then
    FPeriodoDal:=PVal;

  FPeriodoAl:=PVal;
end;

end.
