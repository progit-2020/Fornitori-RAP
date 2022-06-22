unit C021UDocumentiManagerDM;

interface

uses
  DBXJSON{$IF CompilerVersion >= 31},System.JSON{$ENDIF},
  A000UCostanti,
  A000USessione,
  A000UInterfaccia,
  A000UMessaggi,
  B021UWebSvcClientDtM,
  C021UDebenuPDFLibrary_TLB,
  C180FunzioniGenerali,
  ActiveX,
  Oracle,
  OracleData,
  System.IOUtils, System.SysUtils, System.Classes, System.Variants, System.Types, Data.DB,
  Windows, System.StrUtils, IdStack, System.Hash, IdGlobal, IdCoderMIME;

type
  TBlobTag = (btNoFree,btFree);

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
    FCFFamiliare: String;
    FNote: String;
    FBlob: TLOBLocator;
    FFileBase64: String;
    FPathStorage: String;
    FProvenienza: String;
    FHash: String;
    // attributi non propri dell'oggetto?
    FEsisteDocumento: Boolean;
    FFilePath: String;
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
    function SaveToFilePath: TResCtrl;
    function CopyToFilePath: TResCtrl;
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
    property CFFamiliare: String read FCFFamiliare write FCFFamiliare;
    property Note: String read FNote write FNote;
    property Blob: TLOBLocator read FBlob write FBlob;
    property FileBase64: String read FFileBase64 write FFileBase64;
    property PathStorage: String read FPathStorage write FPathStorage;
    property Provenienza: String read FProvenienza write FProvenienza;
    property Hash: String read FHash write FHash;
    property EsisteDocumento: Boolean read FEsisteDocumento write FEsisteDocumento;
    property FilePath: String read FFilePath;
    function  GeneraID: Integer;
  end;

  TC021FDocumentiManagerDM = class(TDataModule)
    selT960: TOracleDataSet;
    selT961: TOracleQuery;
    insT961: TOracleQuery;
    selT960Count: TOracleQuery;
    delT960: TOracleQuery;
    delT961: TOracleQuery;
    updT960SetAccesso: TOracleQuery;
    updT960ResetAccesso: TOracleQuery;
    updT960SetLettura: TOracleQuery;
    selT960MaxVersione: TOracleQuery;
    delT960Sovrascrivi: TOracleQuery;
    selT960DocPresente: TOracleQuery;
    selT962: TOracleDataSet;
    selScript: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FUrlB021: String;
    function  _DownloadJson(const PUrl: String; var FileBase64: String): TResCtrl;
    function  DownloadJson(const PPath: String; const PId: Integer; var RFileBase64: String): TResCtrl; overload;
    function  DownloadJson(const PPath: String; const PFileName: String; var RFileBase64: String): TResCtrl; overload;
    function  DownloadJsonTicket(const PId: Integer; var RFileBase64: String): TResCtrl;
    function  _DeleteJson(const PUrl: String): TResCtrl;
    function  CreaInputJson(Path: String; ID, Size: Integer; FileBase64: String): String;
    procedure LeggiOutputJson(InputString, TipoJson: String; var FileBase64: String; var PErrMsg: String);
    function  AddBlob(PDoc: TDocumento): TResCtrl; //overload;
    function  UploadJson(InputString: String): String;
    function  EscapePath(const PPath: String): String; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    function  GetBase64HashSHA512(Stream: TStream): String;
  public
    Maschera: String;
    CancellaFileTemp: Boolean;
    function  FindById(const PId: Integer): Boolean;  //al momento non utilizzato
    function  GetById(const PId: Integer; const PReadBinaryData: Boolean; out RDoc: TDocumento): TResCtrl;
    function  DownloadFromDocumentale(const PId: Integer; out RDoc: TDocumento): TResCtrl;
    function  Save(PDoc: TDocumento): TResCtrl; overload;
    function  Delete(const PId: Integer): TResCtrl;
    procedure AggiornaDatiAccesso(const PId: Integer; const PUtente: String);
    procedure ResetDatiAccesso(const PId: Integer);
    procedure AggiornaDatiLettura(const PId: Integer; const PProgressivo: Integer);
    function  Upload(PDoc:TDocumento): TResCtrl;
    function  DeleteJson(const PPath: String; const PId: Integer): TResCtrl; overload;
    function  DeleteJson(const PPath: String; const PFileName: String): TResCtrl; overload;
    function  TestWebService: Boolean;
    function  TestAccesso(PathStorage: String): Boolean;
    function  AggiungiTicketPdf(PDoc: TDocumento; PDimensioneTesto: Integer = 8; PAltezzaRiga: Integer = 10): TResCtrl;
    //salvataggio del documento con gestione della versione
    function  Save(PDoc: TDocumento; Sovrascrivi, Versionabile, EliminaFile: Boolean; var IdDocumento: Integer): TResCtrl; overload;
    function  CheckFileEsistente(Progressivo: Integer; NomeFile, Estensione, Tipologia: String): Boolean;
    function  GetMaxVersione(Progressivo: Integer; NomeFile, Estensione, Tipologia: String): Integer;
  end;

const
  // tipologia predefinita (in assenza di default specificato)
  DOC_TIPOL_PREDEF        = '*';
  D_DOC_TIPOL_PREDEF      = 'Non specificata';
  // tipologia "iter"
  DOC_TIPOL_ITER          = 'ITER';
  D_DOC_TIPOL_ITER        = 'Documenti allegati alle richieste da IrisWEB';
  // tipologia "inps"
  DOC_TIPOL_INPS          = 'MEDP_INPS';
  // ufficio predefinito (in assenza di default specificato)
  DOC_UFFICIO_PREDEF      = '*';
  D_DOC_UFFICIO_PREDEF    = 'Non specificato';
  // provenienza
  DOC_PROVENIENZA_INTERNA = 'I';
  DOC_PROVENIENZA_ESTERNA = 'E';

  C_DOWNLOAD              = 'D';
  C_UPLOAD                = 'U';
  // tipologia di storage
  DOC_STORAGE_DB              = 'DB';

implementation

{$IFNDEF WEBSVC}
uses
  {$IFDEF IRISWEB}
  IWApplication, IWGlobal
  {$ELSE}
  Vcl.Forms
  {$ENDIF}
  ;
{$ENDIF}

{$R *.dfm}

procedure TC021FDocumentiManagerDM.DataModuleCreate(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  CancellaFileTemp:=True;

  // imposta url servizio B021 rimuovendo slash finale
  FUrlB021:=Parametri.CampiRiferimento.C30_WebSrv_B021_URL;
  if FUrlB021.EndsWith('/') then
    FUrlB021:=FUrlB021.Substring(0,FUrlB021.Length - 1);
  FUrlB021:=FUrlB021 + '/datasnap/rest/TB021FIrisRestSvcDM/';
end;

procedure TC021FDocumentiManagerDM.DataModuleDestroy(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).CloseAll;
    if Self.Components[i] is TOracleQuery then
      (Self.Components[i] as TOracleQuery).Close;
  end;
end;

function TC021FDocumentiManagerDM.FindById(const PId: Integer): Boolean;
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

function TC021FDocumentiManagerDM.GetById(const PId: Integer; const PReadBinaryData: Boolean; out RDoc: TDocumento): TResCtrl;
// estrae il documento indicato in base all'id
//  se PReadBinaryData = True estrae anche il blob / file da servizio esterno B021
var
  LFileBase64: String;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  RDoc:=nil;

  // apertura dataset dei metadati del documento
  selT960.Close;
  selT960.SetVariable('ID',PId);
  selT960.Open;
  if selT960.RecordCount = 0 then
  begin
    Result.Messaggio:=Format('Il documento indicato non è presente nel database (ID %d)',[PId]);
    Exit;
  end;

  // crea l'oggetto documento
  RDoc:=TDocumento.Create;

  // imposta i metadati
  RDoc.Id:=PId;
  RDoc.DataCreazione:=selT960.FieldByName('DATA_CREAZIONE').AsDateTime;
  RDoc.NomeUtente:=selT960.FieldByName('NOME_UTENTE').AsString;
  RDoc.Utente:=selT960.FieldByName('UTENTE').AsString;
  RDoc.Progressivo:=selT960.FieldByName('PROGRESSIVO').AsInteger;
  RDoc.Tipologia:=selT960.FieldByName('TIPOLOGIA').AsString;
  RDoc.Ufficio:=selT960.FieldByName('UFFICIO').AsString;
  RDoc.FNomeFile:=selT960.FieldByName('NOME_FILE').AsString;
  RDoc.ExtFile:=selT960.FieldByName('EXT_FILE').AsString;
  RDoc.Dimensione:=selT960.FieldByName('DIMENSIONE').AsLargeInt;
  RDoc.PeriodoDal:=selT960.FieldByName('PERIODO_DAL').AsDateTime;
  RDoc.PeriodoAl:=selT960.FieldByName('PERIODO_AL').AsDateTime;
  RDoc.Note:=selT960.FieldByName('NOTE').AsString;
  RDoc.PathStorage:=selT960.FieldByName('PATH_STORAGE').AsString;
  RDoc.Provenienza:=selT960.FieldByName('PROVENIENZA').AsString;
  RDoc.Hash:=selT960.FieldByName('HASH').AsString;

  // valuta estrazione del file binario
  RDoc.Blob:=nil;
  RDoc.FileBase64:='';
  RDoc.EsisteDocumento:=False;

  // se non è necessario estrarre il file binario esce restituendo true
  if not PReadBinaryData then
  begin
    Result.Ok:=True;
    Exit;
  end;

  selT962.Close;
  selT962.SetVariable('CODICE', RDoc.Tipologia);
  selT962.Open;

  //se è richiesto l'inserimento del ticket, lo chiede al servizio B021
  if not selT962.FieldByName('SCRIPT_TICKET_PDF').IsNull then
  begin
    //Chiamata al B021 per Download + Ticket
    Result:=DownloadJsonTicket(RDoc.Id, LFileBase64);
    // in caso di errore esce
    if not Result.Ok then
      Exit;

    RDoc.FileBase64:=LFileBase64;
  end
  else
  begin
    // estrae il file binario in base al tipo di storage
    if RDoc.PathStorage = DOC_STORAGE_DB then
    begin
      // estrae il file binario dal nostro db e lo memorizza nel lob locator
      try
        selT961.SetVariable('ID',PId);
        selT961.Execute;
        RDoc.Blob:=selT961.LOBField('DOCUMENTO');
        RDoc.Blob.Tag:=Integer(btNoFree);
      except
        on E: Exception do
        begin
          Result.Messaggio:=Format('Errore durante la lettura del file (ID %d, storage: %s)',[PId,IfThen(RDoc.PathStorage = DOC_STORAGE_DB,'database','file system')]);
          Exit;
        end;
      end;
    end
    else
    begin
      // effettua il download del file tramite il webservice B021
      if RDoc.Provenienza = DOC_PROVENIENZA_INTERNA then
        Result:=DownloadJson(RDoc.PathStorage,RDoc.Id,LFileBase64)
      else
        Result:=DownloadJson(RDoc.PathStorage,Format('%s.%s',[RDoc.NomeFile,RDoc.ExtFile]),LFileBase64);

      // in caso di errore esce
      if not Result.Ok then
        Exit;

       // valorizza la rappresentazione in base 64 del file
      RDoc.FileBase64:=LFileBase64;
    end;
  end;

  // se il file non esiste dà segnalazione
  if (((RDoc.Blob = nil) or (RDoc.Blob.IsNull)) and (RDoc.PathStorage = DOC_STORAGE_DB) and selT962.FieldByName('SCRIPT_TICKET_PDF').IsNull) or
     ((Length(RDoc.FileBase64) = 0) and (RDoc.PathStorage = DOC_STORAGE_DB) and (not selT962.FieldByName('SCRIPT_TICKET_PDF').IsNull)) or
     ((Length(RDoc.FileBase64) = 0) and (RDoc.PathStorage <> DOC_STORAGE_DB)) then
  begin
    RDoc.EsisteDocumento:=False;
    Result.Messaggio:=Format('Il file associato al documento non è stato trovato (ID %d, storage %s)',[PId,RDoc.PathStorage]);
    Exit;
  end;

  // salvataggio del file binario
  RDoc.EsisteDocumento:=True;

  // determina la cartella in cui salvare il file
  RDoc.FFilePath:=
  {$IFDEF WEBSVC}
    R180GetOSTempDir;
  {$ELSE}
  {$IFDEF IRISWEB}
    { DONE : TEST IW 14 OK }
    GGetWebApplicationThreadVar.UserCacheDir;
  {$ELSE}
    R180GetOSTempDir;
  {$ENDIF}
  {$ENDIF}

  // determina il nome completo del file da generare
  RDoc.FFilePath:=TPath.Combine(RDoc.FFilePath,RDoc.GetNomeFileCompleto);

  // cancella eventuale file già esistente
  if TFile.Exists(RDoc.FilePath) then
  begin
    try
      TFile.Delete(RDoc.FilePath);
    except
      //proteggo eccezione in modo da far fallire eventualmente il metodo successivo, che dà indicazioni sul percorso dove vorrebbe creare il file.
    end;
  end;

  // salvataggio del file
  Result:=RDoc.SaveToFilePath;
end;

function TC021FDocumentiManagerDM.DownloadFromDocumentale(const PId: Integer; out RDoc: TDocumento): TResCtrl;
// estrae il documento indicato in base all'id
var
  LFileBase64: String;
begin
  Result.Clear;
  RDoc:=nil;

  // apertura dataset dei metadati del documento
  selT960.Close;
  selT960.SetVariable('ID',PId);
  selT960.Open;
  if selT960.RecordCount = 0 then
  begin
    Result.Messaggio:=Format('Il documento indicato non è presente nel database (ID %d)',[PId]);
    Exit;
  end;

  // crea l'oggetto documento
  RDoc:=TDocumento.Create;
  // imposta i metadati
  RDoc.Id:=PId;
  RDoc.DataCreazione:=selT960.FieldByName('DATA_CREAZIONE').AsDateTime;
  RDoc.NomeUtente:=selT960.FieldByName('NOME_UTENTE').AsString;
  RDoc.Utente:=selT960.FieldByName('UTENTE').AsString;
  RDoc.Progressivo:=selT960.FieldByName('PROGRESSIVO').AsInteger;
  RDoc.Tipologia:=selT960.FieldByName('TIPOLOGIA').AsString;
  RDoc.Ufficio:=selT960.FieldByName('UFFICIO').AsString;
  RDoc.FNomeFile:=selT960.FieldByName('NOME_FILE').AsString;
  RDoc.ExtFile:=selT960.FieldByName('EXT_FILE').AsString;
  RDoc.Dimensione:=selT960.FieldByName('DIMENSIONE').AsLargeInt;
  RDoc.PeriodoDal:=selT960.FieldByName('PERIODO_DAL').AsDateTime;
  RDoc.PeriodoAl:=selT960.FieldByName('PERIODO_AL').AsDateTime;
  RDoc.Note:=selT960.FieldByName('NOTE').AsString;
  RDoc.PathStorage:=selT960.FieldByName('PATH_STORAGE').AsString;
  RDoc.Provenienza:=selT960.FieldByName('PROVENIENZA').AsString;
  RDoc.Hash:=selT960.FieldByName('HASH').AsString;

  // valuta estrazione del file binario
  RDoc.Blob:=nil;
  RDoc.FileBase64:='';
  RDoc.EsisteDocumento:=False;

  // estrae il file binario in base al tipo di storage
  if RDoc.PathStorage = DOC_STORAGE_DB then
  begin
    // estrae il file binario dal nostro db e lo memorizza nel lob locator
    try
      selT961.SetVariable('ID',PId);
      selT961.Execute;
      RDoc.Blob:=selT961.LOBField('DOCUMENTO');
      RDoc.Blob.Tag:=Integer(btNoFree);
    except
      on E: Exception do
      begin
        Result.Messaggio:=Format('Errore durante la lettura del file (ID %d, storage: %s)',[PId,IfThen(RDoc.PathStorage = DOC_STORAGE_DB,'database','file system')]);
        Exit;
      end;
    end;
    // se il file non esiste lo segnala
    if ((RDoc.Blob = nil) or (RDoc.Blob.IsNull)) then
    begin
      RDoc.EsisteDocumento:=False;
      Result.Messaggio:=Format('Il file associato al documento non è stato trovato (ID %d, storage %s)',[PId,RDoc.PathStorage]);
      Exit;
    end;
  end
  else
  begin
    // se il file non esiste lo segnala
    if not TFile.Exists(TPath.Combine(RDoc.PathStorage,RDoc.GetNomeFileCompleto)) then
    begin
      RDoc.EsisteDocumento:=False;
      Result.Messaggio:=Format('Il file associato al documento non è stato trovato nello storage (ID %d)',[PId]);
      Exit;
    end;
  end;
  RDoc.EsisteDocumento:=True;

  // determina la cartella in cui salvare il file
  RDoc.FFilePath:=
  {$IFDEF WEBSVC}
    R180GetOSTempDir;
  {$ELSE}
  {$IFDEF IRISWEB}
    { DONE : TEST IW 14 OK }
    GGetWebApplicationThreadVar.UserCacheDir;
  {$ELSE}
    R180GetOSTempDir;
  {$ENDIF}
  {$ENDIF}

  // determina il nome completo del file da generare
  RDoc.FFilePath:=TPath.Combine(RDoc.FFilePath,RDoc.GetNomeFileCompleto);

  // salvataggio del file
  Result:=RDoc.CopyToFilePath;
end;

function TC021FDocumentiManagerDM.Delete(const PId: Integer): TResCtrl;
// elimina dal database il documento con l'id indicato
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // apertura dataset dei metadati del documento
  selT960.Close;
  selT960.SetVariable('ID',PId);
  selT960.Open;
  if selT960.RecordCount = 0 then
  begin
    Result.Messaggio:=Format('Il documento non è presente in archivio! (ID = %d)',[PId]);
    Exit;
  end;

  try
    // cancellazione del documento binario
    if selT960.FieldByName('PATH_STORAGE').AsString = DOC_STORAGE_DB then
    begin
      // cancellazione di T961 (blob)
      delT961.SetVariable('ID',PId);
      delT961.Execute;
    end
    else
    begin
      // cancellazione via webservice B021
      if selT960.FieldByName('PROVENIENZA').AsString = DOC_PROVENIENZA_INTERNA then
        DeleteJson(selT960.FieldByName('PATH_STORAGE').AsString,selT960.FieldByName('ID').AsInteger)
      else
        DeleteJson(selT960.FieldByName('PATH_STORAGE').AsString,Format('%s.%s',[selT960.FieldByName('NOME_FILE').AsString,selT960.FieldByName('EXT_FILE').AsString]));
    end;

    // cancellazione di T960 (metadati)
    delT960.SetVariable('ID',PId);
    delT960.Execute;
  except
    on E: Exception do
    begin
      Result.Messaggio:=Format(A000TraduzioneStringhe(A000MSG_C021_ERR_FMT_ELIMINA_DOC),[E.Message]);
      Exit;
    end;
  end;

  // operazione ok
  Result.Ok:=True;
end;

function TC021FDocumentiManagerDM.EscapePath(const PPath: String): String;
begin
  Result:=PPath.Replace('/','\',[rfReplaceAll]).Replace('\','%5C',[rfReplaceAll]);
end;

function TC021FDocumentiManagerDM._DeleteJson(const PUrl: String): TResCtrl;
var
  LOutputStr: String;
  LB021: TB021FWebSvcClientDtM;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  LB021:=TB021FWebSvcClientDtM.Create(Owner);
  try
    try
      // chiamata al servizio web
      LOutputStr:=LB021.EseguiMetodoRest(PUrl,'json','DELETE','');
    except
      on E1: EIdSocketError do
        Result.Messaggio:=Format('Cancellazione del documento fallita!'#13#10'Errore di connessione al servizio web B021:'#13#10'%s',[E1.Message]);
      on E2: Exception do
        Result.Messaggio:=Format('Cancellazione del documento fallita:'#13#10'%s',[E2.Message]);
    end;

    // determina risultato operazione
    Result.Ok:=Result.Messaggio = '';
  finally
    FreeAndNil(LB021);
  end;
end;

function TC021FDocumentiManagerDM.DeleteJson(const PPath: String; const PId: Integer): TResCtrl;
var
  LUrlServizio: String;
begin
  LUrlServizio:=FUrlB021 + Format('C021DocumentoBlob/*/%s/%s/%s/%d',[Parametri.Azienda,Parametri.Operatore,EscapePath(PPath),PId]);
  Result:=_DeleteJson(LUrlServizio);
end;

function TC021FDocumentiManagerDM.DeleteJson(const PPath: String; const PFileName: String): TResCtrl;
var
  LUrlServizio: String;
begin
  LUrlServizio:=FUrlB021 + Format('C021DocumentoBlob/*/%s/%s/%s/%s',[Parametri.Azienda,Parametri.Operatore,EscapePath(PPath),PFileName]);
  Result:=_DeleteJson(LUrlServizio);
end;

function TC021FDocumentiManagerDM._DownloadJson(const PUrl: String; var FileBase64: String): TResCtrl;
var
  LOutputStr: String;
  LB021: TB021FWebSvcClientDtM;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  LB021:=TB021FWebSvcClientDtM.Create(Owner);
  try
    // chiamata al servizio web
    try
      LOutputStr:=LB021.EseguiMetodoRest(PUrl,'json','GET','');

      // conversione da json ad array di byte
      LeggiOutputJson(LOutputStr, C_DOWNLOAD, FileBase64, Result.Messaggio);
    except
      on E1: EIdSocketError do
        Result.Messaggio:=Format('Download del documento fallito!'#13#10'Errore di connessione al servizio web B021:'#13#10'%s',[E1.Message]);
      on E2: Exception do
        Result.Messaggio:=Format('Download del documento fallito:'#13#10'%s',[E2.Message]);
    end;

    // determina risultato operazione
    Result.Ok:=Result.Messaggio = '';
  finally
    FreeAndNil(LB021);
  end;
end;

function TC021FDocumentiManagerDM.DownloadJson(const PPath: String; const PId: Integer; var RFileBase64: String): TResCtrl;
var
  LUrlServizio: String;
begin
  LUrlServizio:=FUrlB021 + Format('C021DocumentoBlob/*/%s/%s/%s/%d',[Parametri.Azienda,Parametri.Operatore,EscapePath(PPath),PId]);
  Result:=_DownloadJson(LUrlServizio,RFileBase64);
end;

function TC021FDocumentiManagerDM.DownloadJson(const PPath: String; const PFileName: String; var RFileBase64: String): TResCtrl;
var
  LUrlServizio: String;
begin
  LUrlServizio:=FUrlB021 + Format('C021DocumentoBlob/*/%s/%s/%s/%s',[Parametri.Azienda,Parametri.Operatore,EscapePath(PPath),PFileName]);
  Result:=_DownloadJson(LUrlServizio,RFileBase64);
end;

function TC021FDocumentiManagerDM.DownloadJsonTicket(const PId: Integer; var RFileBase64: String): TResCtrl;
var
  LUrlServizio: String;
begin
  LUrlServizio:=FUrlB021 + Format('C021DocumentoBlobTicket/*/%s/%s/%d',[Parametri.Azienda,Parametri.Operatore,PId]);
  Result:=_DownloadJson(LUrlServizio,RFileBase64);
end;

function TC021FDocumentiManagerDM.Save(PDoc: TDocumento): TResCtrl;
// salva il documento su db effettuando inserimento o aggiornamento
// - inserimento: metadati + blob
// - aggiornamento: metadati
var
  LResCtrl: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

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
      if PDoc.Progressivo <> 0 then
        selT960.FieldByName('PROGRESSIVO').AsInteger:=PDoc.Progressivo
      else
        selT960.FieldByName('PROGRESSIVO').Value:=null;
      selT960.FieldByName('TIPOLOGIA').AsString:=PDoc.Tipologia;
      selT960.FieldByName('UFFICIO').AsString:=PDoc.Ufficio;
      selT960.FieldByName('NOME_FILE').AsString:=PDoc.NomeFile;
      selT960.FieldByName('EXT_FILE').AsString:=PDoc.ExtFile;
      selT960.FieldByName('DIMENSIONE').AsInteger:=PDoc.Dimensione;
      if PDoc.PeriodoDal = DATE_NULL then
        selT960.FieldByName('PERIODO_DAL').Value:=null
      else
        selT960.FieldByName('PERIODO_DAL').AsDateTime:=PDoc.PeriodoDal;
      if PDoc.PeriodoAl = DATE_NULL then
        selT960.FieldByName('PERIODO_AL').Value:=null
      else
        selT960.FieldByName('PERIODO_AL').AsDateTime:=PDoc.PeriodoAl;
      selT960.FieldByName('CF_FAMILIARE').AsString:=PDoc.CFFamiliare;
      selT960.FieldByName('NOTE').AsString:=PDoc.Note;
      selT960.FieldByName('PATH_STORAGE').AsString:=PDoc.PathStorage;
      selT960.FieldByName('PROVENIENZA').AsString:=PDoc.Provenienza;
      selT960.Post;

      // impostazione del path storage
      PDoc.PathStorage:=selT960.FieldByName('PATH_STORAGE').AsString;

      LResCtrl:=Upload(PDoc);
      if not LResCtrl.Ok then
        raise Exception.Create(LResCtrl.Messaggio);
      SessioneOracle.Commit;

      // elimina il file temporaneo del documento dalla user cache directory
      if CancellaFileTemp and TFile.Exists(PDoc.TempFile) then
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
      if PDoc.PeriodoDal = DATE_NULL then
        selT960.FieldByName('PERIODO_DAL').Value:=null
      else
        selT960.FieldByName('PERIODO_DAL').AsDateTime:=PDoc.PeriodoDal;
      if PDoc.PeriodoAl = DATE_NULL then
        selT960.FieldByName('PERIODO_AL').Value:=null
      else
        selT960.FieldByName('PERIODO_AL').AsDateTime:=PDoc.PeriodoAl;
      selT960.FieldByName('CF_FAMILIARE').AsString:=PDoc.CFFamiliare;
      selT960.FieldByName('NOTE').AsString:=PDoc.Note;
      selT960.Post;
    end;
  except
    on E: Exception do
    begin
      Result.Messaggio:=Format(A000TraduzioneStringhe(A000MSG_C021_ERR_FMT_SALVA_DOC),[E.Message]);
      Exit;
    end;
  end;

  // operazione ok
  Result.Ok:=True;
end;

function TC021FDocumentiManagerDM.Save(PDoc: TDocumento; Sovrascrivi, Versionabile, EliminaFile: Boolean; var IdDocumento: Integer): TResCtrl;
// salva il documento su T960 gestendo la sovrascrittura e il versionamento se richiesto dai parametri (Sovrascrivi e Versionabile)
// se PDoc.PathStorage = DOC_STORAGE_DB esegue anche l'upload del file su db, eventualmente con cancellazione del
// file temporaneo (parametro EliminaFile)
var LVersione: Integer;
    LResCtrl: TResCtrl;
begin
  Result.Clear;
  IdDocumento:=0;
  try
    if Sovrascrivi and not Versionabile then
    begin
      // elimina eventuali record su T960 con stesso progressivo, nome file, estensione e tipologia
      delT960Sovrascrivi.SetVariable('PROGRESSIVO', PDoc.Progressivo);
      delT960Sovrascrivi.SetVariable('NOME_FILE', PDoc.NomeFile);
      delT960Sovrascrivi.SetVariable('EXT_FILE', PDoc.ExtFile);
      delT960Sovrascrivi.SetVariable('TIPOLOGIA', PDoc.Tipologia);
      delT960Sovrascrivi.Execute;
    end;

    LVersione:=0;
    // trovo il numero di versione se richiesto
    if Versionabile then
      LVersione:=GetMaxVersione(PDoc.Progressivo, PDoc.NomeFile, PDoc.ExtFile, PDoc.Tipologia) +1;

    PDoc.Id:=PDoc.GeneraID;

    selT960.Close;
    selT960.SetVariable('ID', PDoc.Id);
    selT960.Open;

    // inserimento del record su T960
    selT960.Append;
    selT960.FieldByName('ID').AsInteger:=PDoc.Id;
    selT960.FieldByName('DATA_CREAZIONE').AsDateTime:=PDoc.DataCreazione;
    selT960.FieldByName('NOME_UTENTE').AsString:=PDoc.NomeUtente;
    selT960.FieldByName('UTENTE').AsString:=PDoc.Utente;
    if PDoc.Progressivo > 0 then
      selT960.FieldByName('PROGRESSIVO').AsInteger:=PDoc.Progressivo
    else
      selT960.FieldByName('PROGRESSIVO').Value:=null;
    selT960.FieldByName('TIPOLOGIA').AsString:=PDoc.Tipologia;
    if PDoc.Ufficio <> '' then
      selT960.FieldByName('UFFICIO').AsString:=PDoc.Ufficio
    else
      selT960.FieldByName('UFFICIO').AsString:='*';
    selT960.FieldByName('NOME_FILE').AsString:=PDoc.NomeFile;
    selT960.FieldByName('EXT_FILE').AsString:=PDoc.ExtFile;
    selT960.FieldByName('DIMENSIONE').AsInteger:=PDoc.Dimensione;
    if PDoc.PeriodoDal = DATE_NULL then
      selT960.FieldByName('PERIODO_DAL').Value:=null
    else
      selT960.FieldByName('PERIODO_DAL').AsDateTime:=PDoc.PeriodoDal;
    if PDoc.PeriodoAl = DATE_NULL then
      selT960.FieldByName('PERIODO_AL').Value:=null
    else
      selT960.FieldByName('PERIODO_AL').AsDateTime:=PDoc.PeriodoAl;
    selT960.FieldByName('CF_FAMILIARE').AsString:=PDoc.CFFamiliare;
    selT960.FieldByName('NOTE').AsString:=PDoc.Note;
    selT960.FieldByName('PATH_STORAGE').AsString:=PDoc.PathStorage;
    selT960.FieldByName('PROVENIENZA').AsString:=PDoc.Provenienza;
    if LVersione <> 0 then
      selT960.FieldByName('VERSIONE').AsInteger:=LVersione;
    selT960.Post;

    //se è previsto il salvataggio su db, faccio anche l'upload del blob
    if PDoc.PathStorage = DOC_STORAGE_DB then
    begin
      LResCtrl:=AddBlob(PDoc);

      if not LResCtrl.Ok then
        raise Exception.Create(LResCtrl.Messaggio);
    end;

    if EliminaFile then   //elimina il file temporaneo se richiesto
      if TFile.Exists(PDoc.TempFile) then
        TFile.Delete(PDoc.TempFile);

    SessioneOracle.Commit;
    IdDocumento:=PDoc.Id;
    Result.Ok:=True;
  except
    on E: Exception do
    begin
      SessioneOracle.Rollback;  // rollback in caso di errore
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TC021FDocumentiManagerDM.TestAccesso(PathStorage: String): Boolean;
var
  InputString,
  outputString,
  Percorso,
  FileBytePath,
  FileBase64,
  PErrMsg: String;
  StringList: TStringList;
  FileByteID, FileByteSize: Integer;
begin
  // valorizzazione stringlist per upload di prova sul percorso designato
  StringList:=TStringList.Create;
  try
    StringList.Add('Test');
    Percorso:=R180GetOSTempDir + 'Test.medp';
    StringList.SaveToFile(Percorso);

    // valorizzazione dei parametri per il servizio web
    FileBase64:=R180EncodeFileB64(Percorso);
    FileByteSize:=Length(FileBase64);
    FileBytePath:=IncludeTrailingPathDelimiter(PathStorage);
    FileByteID:=0;

    // conversione in json
    InputString:=CreaInputJson(FileBytePath,FileByteID,FileByteSize,FileBase64);

    try
      // lancio del servizio
      OutputString:=UploadJson(InputString);

      // memorizzazione della risposta
      LeggiOutputJson(OutputString, C_UPLOAD, FileBase64, PErrMsg);
    except
      Result:=False;
    end;
    if PErrMsg = '' then
    begin
      DeleteJson(PathStorage, 0);
      Result:=True;
    end
    else
      Result:=False;
  finally
    FreeAndNil(StringList);
    try
      TFile.Delete(Percorso);
    except
    end;
  end;
end;

function TC021FDocumentiManagerDM.TestWebService: Boolean;
var
  LUrlServizio: String;
  LOutputStr: String;
  LB021DM: TB021FWebSvcClientDtM;
begin
  LUrlServizio:=FUrlB021 + 'EchoString/Test';
  LB021DM:=TB021FWebSvcClientDtM.Create(Owner);
  try
    try
      //chiamata al servizio web
      LOutputStr:=LB021DM.EseguiMetodoRest(LUrlServizio,'','GET','');
      Result:=LOutputStr = '{"result":["Test"]}';
    except
      Result:=False;
    end;
  finally
    FreeAndNil(LB021DM);
  end;
end;

function TC021FDocumentiManagerDM.UploadJson(InputString: String): String;
var
  LUrlServizio: String;
  LB021DM: TB021FWebSvcClientDtM;
begin
  // valorizzazione variabili per chiamata al servizio web
  LUrlServizio:=FUrlB021 + Format('C021DocumentoBlob/*/%s/%s',[Parametri.Azienda,Parametri.Operatore]);
  LB021DM:=TB021FWebSvcClientDtM.Create(Owner);
  try
    // chiamata al servizio web
    Result:=LB021DM.EseguiMetodoRest(LUrlServizio, 'json', 'PUT', InputString);
  finally
    FreeAndNil(LB021DM);
  end;
end;

function TC021FDocumentiManagerDM.Upload(PDoc: TDocumento): TResCtrl;
var
  LFileByteID: Integer;
  LFileByteSize: Integer;
  LFileBytePath: String;
  LFileBase64: String;
  LInputString: String;
  LOutputString: String;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  if PDoc.PathStorage = DOC_STORAGE_DB then
  begin
    // upload documento su database T961
    Result:=AddBlob(PDoc);
  end
  else
  begin
    // upload documento su file system

    // valorizzazione dei parametri per il servizio web
    LFileBase64:=R180EncodeFileB64(PDoc.TempFile);
    LFileByteSize:=Length(LFileBase64);
    LFileBytePath:=IncludeTrailingPathDelimiter(PDoc.PathStorage);
    LFileByteID:=PDoc.Id;

    // conversione in json
    LInputString:=CreaInputJson(LFileBytePath,LFileByteID,LFileByteSize,LFileBase64);

    // lancio del servizio
    LOutputString:=UploadJson(LInputString);

    // memorizzazione della risposta
    LeggiOutputJson(LOutputString, C_UPLOAD, LFileBase64, Result.Messaggio);

    // controllo errori
    Result.Ok:=Result.Messaggio = '';
  end;
end;

function TC021FDocumentiManagerDM.AddBlob(PDoc: TDocumento): TResCtrl;
// crea e carica il PLob, prima di inserire il documento in T961
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  if PDoc.Blob = nil then
    PDoc.Blob:=TLOBLocator.CreateTemporary(SessioneOracle,otBLOB,True);
  try
    if PDoc.Blob.Size = 0 then
      PDoc.Blob.LoadFromFile(PDoc.TempFile);
    try
      // inserimento del blob su T961
      insT961.SetVariable('ID',PDoc.ID);
      insT961.SetComplexVariable('DOCUMENTO',PDoc.Blob);
      insT961.Execute;

      // inserimento dell'hash su T960
      PDoc.Hash:=GetBase64HashSHA512(PDoc.Blob);

      selT960.Close;
      selT960.SetVariable('ID',PDoc.Id);
      selT960.Open;

      if selT960.RecordCount <> 0 then
      begin
        selT960.Edit;
        selT960.FieldByName('HASH').AsString:=PDoc.Hash;
        selT960.Post;
      end;

      // operazione ok
      Result.Ok:=True;
    except
      on E: Exception do
      begin
        Result.Messaggio:=Format(A000TraduzioneStringhe(A000MSG_C021_ERR_FMT_SALVA_DOC),[E.Message]);
        Exit;
      end;
    end;
  finally
    if PDoc.Blob.Tag <> Integer(btFree) then
      try PDoc.Blob.Free; except end;
  end;
end;

procedure TC021FDocumentiManagerDM.AggiornaDatiAccesso(const PId: Integer; const PUtente: String);
// aggiorna i dati di accesso per il documento:
// - UTENTE_ACCESSO
// - DATA_ACCESSO
// IMPORTANTE
//   questa operazione è effettuata solo nel caso di operatore IrisWin / IrisCloud
//   e solo se l'operatore di accesso non è l'utente che ha creato il documento
var
  LDataAccesso: TDateTime;
begin
  if Parametri.TipoOperatore = 'I070' then
  begin
    // operatore iriswin / iriscloud
    LDataAccesso:=Now;
    try
      // aggiorna i dati di ultimo accesso
      updT960SetAccesso.SetVariable('ID',PId);
      updT960SetAccesso.SetVariable('UTENTE_ACCESSO',PUtente);
      updT960SetAccesso.SetVariable('DATA_ACCESSO',LDataAccesso);
      updT960SetAccesso.Execute;

      // log dell'operazione
      RegistraLog.SettaProprieta('I','T960_DOCUMENTI_INFO',Maschera,nil,True);
      RegistraLog.InserisciDato('ID','',PId.ToString);
      RegistraLog.InserisciDato('UTENTE_ACCESSO','',PUtente);
      RegistraLog.InserisciDato('DATA_ACCESSO','',DateTimeToStr(LDataAccesso));
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        if SessioneOracle.Tag = 1 then
          SessioneOracle.Rollback
        else
          SessioneOracle.Commit;
        raise;
      end;
    end;
  end;
end;

procedure TC021FDocumentiManagerDM.ResetDatiAccesso(const PId: Integer);
// annulla i dati di accesso per il documento:
// - UTENTE_ACCESSO
// - DATA_ACCESSO
var
  LOldUtenteAccesso: String;
  LOldDataAccesso: String;
begin
  try
    // estrae i dati di ultimo accesso in variabili e quindi annulla i dati di ultimo accesso
    updT960ResetAccesso.SetVariable('ID',PId);
    updT960ResetAccesso.Execute;
    LOldUtenteAccesso:=VarToStr(updT960SetAccesso.GetVariable('UTENTE_ACCESSO'));
    LOldDataAccesso:=VarToStr(updT960SetAccesso.GetVariable('DATA_ACCESSO'));

    // log dell'operazione
    RegistraLog.SettaProprieta('I','T960_DOCUMENTI_INFO',Maschera,nil,True);
    RegistraLog.InserisciDato('ID','',PId.ToString);
    RegistraLog.InserisciDato('UTENTE_ACCESSO',LOldUtenteAccesso,'null');
    RegistraLog.InserisciDato('DATA_ACCESSO',LOldDataAccesso,'null');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    on E: Exception do
    begin
      if SessioneOracle.Tag = 1 then
        SessioneOracle.Rollback
      else
        SessioneOracle.Commit;
      raise;
    end;
  end;
end;

procedure TC021FDocumentiManagerDM.AggiornaDatiLettura(const PId: Integer; const PProgressivo: Integer);
// aggiorna i dati di lettura per il documento:
// - DATA_LETTURA
// IMPORTANTE
//   questa operazione è effettuata solo nel caso l'utente web
//   è legato al progressivo a cui è riferito il documento
var
  LDataLettura: TDateTime;
begin
  if Parametri.TipoOperatore = 'I060' then
  begin
    // operatore iriswin / iriscloud
    LDataLettura:=Now;
    try
      // aggiorna i dati di lettura
      updT960SetLettura.SetVariable('ID',PId);
      updT960SetLettura.SetVariable('PROGRESSIVO',PProgressivo);
      updT960SetLettura.SetVariable('DATA_LETTURA',LDataLettura);
      updT960SetLettura.Execute;

      // log dell'operazione
      RegistraLog.SettaProprieta('I','T960_DOCUMENTI_INFO',Maschera,nil,True);
      RegistraLog.InserisciDato('ID','',PId.ToString);
      RegistraLog.InserisciDato('PROGRESSIVO','',PProgressivo.ToString);
      RegistraLog.InserisciDato('DATA_LETTURA','',DateTimeToStr(LDataLettura));
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        if SessioneOracle.Tag = 1 then
          SessioneOracle.Rollback
        else
          SessioneOracle.Commit;
        raise;
      end;
    end;
  end;
end;

function TC021FDocumentiManagerDM.AggiungiTicketPdf(PDoc: TDocumento; PDimensioneTesto: Integer = 8; PAltezzaRiga: Integer = 10): TResCtrl;
var
  ListaRighe: TStringList;
  i,j, esito: Integer;
  AltezzaNew, AltezzaOld: Double;
  PDFLibrary: TPDFLibrary;
  ResultScript: Variant;
const
  ERRORE = 'Errore nell''inserimento del ticket del pdf: ';
begin
  Result.Clear;
  try
    if not FileExists(PDoc.FilePath) then
    begin
      Result.Messaggio:=ERRORE + 'file non trovato';
      Exit;
    end;

    selT962.Close;
    selT962.SetVariable('CODICE', PDoc.Tipologia);
    selT962.Open;

    if not selT962.FieldByName('SCRIPT_TICKET_PDF').IsNull then
    begin
      PDFLibrary:=nil;
      ListaRighe:=TStringList.Create;
      try
        selScript.SQL.Text:=selT962.FieldByName('SCRIPT_TICKET_PDF').AsString;
        selScript.SetVariable('PROGRESSIVO', PDoc.Progressivo);  //da definire le variabili richieste
        selScript.SetVariable('DATA', PDoc.PeriodoAl);
        selScript.SetVariable('ID', PDoc.Id);
        selScript.Execute;
        ResultScript:=selScript.GetVariable('RESULT');
        if VarIsNull(ResultScript) then
        begin
          Result.Ok:=True;
          Exit;
        end
        else
          ListaRighe.Text:=ResultScript;

        ListaRighe.Text:=ResultScript;
        if ListaRighe.Count <= 0 then    //se non ci sono righe da aggiungere
          Exit;

        PDFLibrary:=TPDFLibrary.Create(Self);
        CoInitialize(nil);
        PDFLibrary.Connect;
        try
          esito:=PDFLibrary.LoadFromFile(PDoc.FilePath, '');
          if esito = 0 then
          begin
            Result.Messaggio:=ERRORE + 'caricamento del file fallito, error code ' + PDFLibrary.LastErrorCode.ToString;
            Exit;
          end;
          AltezzaOld:=PDFLibrary.PageHeight;
          AltezzaNew:=PDFLibrary.PageHeight + PAltezzaRiga*(ListaRighe.Count+1) + 15;
          //inserisco il ticket per tutte le pagine del pdf
          for i:=1 to PDFLibrary.PageCount do
          begin
            PDFLibrary.SelectPage(i);
            //aumento l'altezza del pdf
            PDFLibrary.SetPageDimensions(PDFLibrary.PageWidth, AltezzaNew);
            PDFLibrary.SetTextSize(PDimensioneTesto);
            //scrivo il ticket (calcolo la posizione dal vertice basso a sinistra della pagina)
            PDFLibrary.DrawText(15, AltezzaNew-15, '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
            for j:=0 to ListaRighe.Count-1 do
            begin
              PDFLibrary.DrawText(15, PDFLibrary.PageHeight - (j+1)*PAltezzaRiga - 15, ListaRighe[j]);
            end;
            PDFLibrary.DrawText(15, AltezzaOld, '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
          end;

          esito:=PDFLibrary.SaveToFile(PDoc.FilePath);
          if esito = 0 then
          begin
            Result.Messaggio:=ERRORE + 'salvataggio del file fallito, error code ' + PDFLibrary.LastErrorCode.ToString;
            Exit;
          end;
        finally
          PDFLibrary.Disconnect;
          CoUninitialize;
        end;
      finally
        FreeAndNil(ListaRighe);
        FreeAndNil(PDFLibrary);
      end;
    end;
    Result.Ok:=True;
  except
    on E: Exception do
      Result.Messaggio:=ERRORE + E.Message;
  end;
end;

function TC021FDocumentiManagerDM.CheckFileEsistente(Progressivo: Integer; NomeFile, Estensione, Tipologia: String): Boolean;
begin
  selT960DocPresente.SetVariable('PROGRESSIVO', Progressivo);
  selT960DocPresente.SetVariable('NOME_FILE', NomeFile);
  selT960DocPresente.SetVariable('EXT_FILE', Estensione);
  selT960DocPresente.SetVariable('TIPOLOGIA', Tipologia);
  selT960DocPresente.Execute;

  Result:=selT960DocPresente.RowCount <> 0;
end;

function TC021FDocumentiManagerDM.GetMaxVersione(Progressivo: Integer; NomeFile, Estensione, Tipologia: String): Integer;
begin
  selT960MaxVersione.SetVariable('PROGRESSIVO', Progressivo);
  selT960MaxVersione.SetVariable('NOME_FILE', NomeFile);
  selT960MaxVersione.SetVariable('EXT_FILE', Estensione);
  selT960MaxVersione.SetVariable('TIPOLOGIA', Tipologia);
  selT960MaxVersione.Execute;

  Result:=selT960MaxVersione.Field(0);
end;

function TC021FDocumentiManagerDM.CreaInputJson(Path:String; ID, Size:Integer; FileBase64:String):String;
var
  LJson: TJSONObject;
begin
  LJson:=TJSONObject.Create;
  try
    // occorre effettuare il replace dei caratteri di controllo del json, altrimenti errore
    LJson.AddPair('Path',TJsonString.Create(Path.Replace('\', '\\', [rfReplaceAll])));
    LJson.AddPair('ID',TJsonString.Create(IntToStr(ID)));
    LJson.AddPair('FileBase64', TJsonString.Create(FileBase64));
    LJson.AddPair('Size', TJsonString.Create(IntToStr(Size)));
    Result:=LJson.ToString;
  finally
    FreeAndNil(LJson);
  end;
end;

procedure TC021FDocumentiManagerDM.LeggiOutputJson(InputString, TipoJson: String; var FileBase64: String; var PErrMsg: String);
var
  Dimensione: Integer;
  JsonValue: TJSONValue;
  InputJson, InputJSON2, InputJson3: TJSONObject;
  InputJsonValue, Errore: String;
begin
  PErrMsg:='';

  // conversione da stringa a json
  InputJson:=TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(InputString),0) as TJSONObject;
  JsonValue:=nil;
  InputJson2:=nil;
  InputJson3:=nil;
  try
    // estrazione della parte dati del json
    InputJsonValue:=InputJson.Pairs[0].JsonValue.ToString;
    // creazione di un nuovo oggetto Json con solo la parte valore
    JsonValue:=TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(InputJsonValue),0);
    InputJson2:=TJSONArray(JsonValue).Items[0] as TJSONObject;

    if InputJson2.Get('errori') <> nil then
    begin
      Errore:=InputJson2.Get('errori').JsonValue.ToString;
      if Errore = 'true' then
      begin
        // discesa nel secondo livello json
        InputJsonValue:=InputJson2.Get('dettagli').JsonValue.ToString.Replace('\', '\\', [rfReplaceAll]).Replace('[', '', [rfReplaceAll]).Replace(']', '', [rfReplaceAll]);
        InputJson3:=TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(InputJsonValue),0) as TJSONObject;
        // estrazione errore
        PErrMsg:=InputJson3.Get('result').JsonValue.Value;
      end;
    end;

    if PErrMsg <> '' then
      Exit;

    if TipoJSon = C_DOWNLOAD then
    begin
      // estrazione dei valori corretti
      Dimensione:=InputJson2.Get('Size').JsonValue.Value.ToInteger;
      FileBase64:=InputJson2.Get('FileBase64').JsonValue.Value;
      // la procedura continua solo se la dimensione calcolata in partenza è uguale a quella in arrivo (serve per il download)
      if (Length(FileBase64) <> Dimensione) then
        PErrMsg:='La dimensione di arrivo del file non corrisponde con quella di partenza';
    end;
  finally
    FreeAndNil(InputJson);
    FreeAndNil(JsonValue);
    if InputJson3 <> nil then
      FreeAndNil(InputJSON3);
  end;
end;

function TC021FDocumentiManagerDM.GetBase64HashSHA512(Stream: TStream): String;
var
  HashSHA: THashSHA2;
  Readed: Integer;
  Buffer: PByte;
  HashBytes: TBytes;
  HashIdBytes: TIdBytes;
begin
  HashSHA:=THashSHA2.Create(SHA512);
  Buffer:=AllocMem(Stream.Size+10);
  try
    Stream.Seek(0, soBeginning);
    while Stream.Position < Stream.Size do
    begin
      Readed:=Stream.Read(Buffer^, Stream.Size);
      if Readed > 0 then
      begin
        HashSHA.update(Buffer^, Readed);
      end;
    end;
  finally
    FreeMem(Buffer)
  end;
  HashBytes:=HashSHA.HashAsBytes;
  HashIdBytes:=TIdBytes(HashBytes);
  Result:=TIdEncoderMIME.EncodeBytes(HashIdBytes);
end;

{ TDocumento }

constructor TDocumento.Create;
begin
  inherited;

  // pulizia proprietà
  Clear;

  // impostazione proprietà determinabili automaticamente
  FDataCreazione:=Now;

  {$IF DEFINED(IRISWEB) AND (NOT DEFINED(WEBPJ))}
  FNomeUtente:=Parametri.Operatore;
  FUtente:='';
  {$ELSE}
  FNomeUtente:='';
  FUtente:=Parametri.Operatore;
  {$ENDIF}
end;

destructor TDocumento.Destroy;
begin
  // verifica se è necessaria la distruzione esplicita del blob
  if (Blob <> nil) and
     (Blob.Tag = Integer(btFree)) then
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
  FHash:='';
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
// determina inoltre la cartella temporanea e il nome del file temporaneo per l'upload
var
  LTempDir: string;
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
    {$IFDEF WEBSVC}
    //WebServices (non usato)
    LTempDir:=A000GetHomePath;
    LTempDir:=IncludeTrailingPathDelimiter(LTempDir);
    if not TDirectory.Exists(LTempDir) then
      ForceDirectories(LTempDir);
    {$ELSE}
      {$IFDEF IRISWEB}
      //IrisWEB/IrisCloud
      LTempDir:=GGetWebApplicationThreadVar.UserCacheDir;
      {$ELSE}
      //IrisWIN
      LTempDir:=ExtractFilePath(Application.ExeName) + 'Archivi\';
      {$ENDIF IRISWEB}
    {$ENDIF WEBSVC}
    FTempFile:=LTempDir + PVal;
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
  if (PVal < DATE_MIN) and (PVal <> DATE_NULL) then
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

function TDocumento.SaveToFilePath: TResCtrl;
// salva il file binario nel path indicato nella proprietà FilePath
// se presente, il file deve essere sovrascritto
begin
  Result.Clear;

  // salva il documento in base al tipo di storage
  try
    if (FPathStorage = DOC_STORAGE_DB) and not ((Blob = nil) or (Blob.IsNull)) then
      Blob.SaveToFile(FFilePath)
    else
      R180DecodeFileB64(FFileBase64, FFilePath);
  except
    on E: Exception do
    begin
      Result.Messaggio:=Format('Errore in fase di salvataggio del file associato al documento (ID %d, storage: %s):'#13#10'%s',[FId,IfThen(FPathStorage = DOC_STORAGE_DB,'database','file system'),E.Message]);
      Exit;
    end;
  end;

  // operazione ok
  Result.Ok:=True;
end;

function TDocumento.CopyToFilePath: TResCtrl;
// copia il file dal documentale nel path indicato nella proprietà FilePath
// se presente, il file deve essere sovrascritto
begin
  Result.Clear;
  // salva il documento in base al tipo di storage
  try
    if (FPathStorage = DOC_STORAGE_DB) then
      Blob.SaveToFile(FFilePath)
    else
      TFile.Copy(TPath.Combine(PathStorage,GetNomeFileCompleto), FFilePath, True);
  except
    on E: Exception do
    begin
      Result.Messaggio:=Format('Errore in fase di salvataggio del file associato al documento (ID %d, storage: %s):'#13#10'%s',[FId,IfThen(FPathStorage = DOC_STORAGE_DB,'database','file system'),E.Message]);
      Exit;
    end;
  end;

  // operazione ok
  Result.Ok:=True;
end;

end.
