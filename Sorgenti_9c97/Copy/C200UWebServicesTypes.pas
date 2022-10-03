unit C200UWebServicesTypes;

interface

uses
  A000UCostanti,
  System.Classes,
  System.SysUtils,
  System.IOUtils,
  System.Types,
  System.TypInfo,
  System.Math,
  System.StrUtils,
  DBXJSONReflect,
  Web.HTTPApp,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client;

type
  TOperazione    = (opCreate,
                    opRead,
                    opUpdate,
                    opDelete);

  TOperazioneRec = record
  const
    Create       = opCreate;
    Read         = opRead;
    Update       = opUpdate;
    Delete       = opDelete;
  end;

  TTipoDettaglio = (tdDebug,
                    tdInfo,
                    tdWarning,
                    tdError);

  TTipoDettaglioRec = record
  const
    Debug        = tdDebug;
    Info         = tdInfo;
    Warning      = tdWarning;
    Error        = tdError;
  end;

  TStatus        = (srOk,
                    srWarning,
                    srError);

  TStatusRec     = record
  const
    Ok           = srOk;
    Warning      = srWarning;
    Error        = srError;
  end;

  TErrorCode = (
    NoError,
    Generic,
    NoConnection,
    AuthError,
    InvalidParameter,
    MarshallingError,
    UnmarshallingError,
    InvalidOperation,
    NotImplemented,
    DataNotFound,
    MethodExecutionError
  );

  TErrorCodeRecHelper = record helper for TErrorCode
    // spiegazione dell'errore
    function ToString: String;
    // da visualizzare nello status
    function ToStatusString: String;
  end;

  // interceptor per formati datetime standard mondoedp
  TC200DateTimeInterceptor = class(TJSONInterceptor)
  private
    FDateTimeIsUTC: Boolean;
  public
    constructor Create(ADateTimeIsUTC: Boolean); reintroduce;
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
    property DateTimeIsUTC: Boolean read FDateTimeIsUTC write FDateTimeIsUTC;
  end;

  // interceptor per formati datetime standard mondoedp
  TC200DateTimeInputInterceptor = class(TJSONInterceptor)
  private
    FDateTimeIsUTC: Boolean;
  public
    constructor Create(ADateTimeIsUTC: Boolean); reintroduce;
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
    property DateTimeIsUTC: Boolean read FDateTimeIsUTC write FDateTimeIsUTC;
  end;

  // classe per il dettaglio delle informazioni di elaborazione del metodo
  TDettaglio = class(TPersistent)
  private
    [JSONReflect(ctString,rtString,TC200DateTimeInterceptor,nil,True)]
    FTime: TDateTime;
    FTipo: TTipoDettaglio;
    FMessage: String;
    FErrCode: TErrorCode;
    FErrUserMessage: String;
  public
    constructor Create; overload;
    constructor Create(PTipo: TTipoDettaglio; PMessage: String); reintroduce; overload;
    constructor Create(PTipo: TTipoDettaglio; PMessage: String; PErrCode: TErrorCode; PErrUserMessage: String); reintroduce; overload;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
    function ToStatusInfo: String;
    function ToStatus: TStatus;
    property Time: TDateTime read FTime write FTime;
    property Tipo: TTipoDettaglio read FTipo write FTipo;
    property ErrCode: TErrorCode read FErrCode write FErrCode;
    property Message: String read FMessage write FMessage;
    property ErrUserMessage: String read FErrUserMessage write FErrUserMessage;
  end;

  TArrayDettaglio = array of TDettaglio;

  // classe per dati informativi sulla elaborazione del metodo
  TInfoElaborazione = class(TPersistent)
  private
    FDuration: Int64;
    FErrors: Boolean;
    FWarnings: Boolean;
    FDettagli: TArrayDettaglio;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function ToString: String; override;
    function GetDettagli: TArrayDettaglio;
    procedure AddDettaglio(PDett: TDettaglio);
    property Duration: Int64 read FDuration write FDuration;
    property Errors: Boolean read FErrors;
    property Warnings: Boolean read FWarnings;
    property Dettagli: TArrayDettaglio read GetDettagli;
  end;

  // classe per risultato generico dei servizi web mondoedp
  TRisultato = class(TPersistent)
  private
    FStatus: TStatus;
    FStatusInfo: String;
    //[JSONMarshalled(False)]
    FInfoElaborazione: TInfoElaborazione;
    FOutput: TPersistent;
    procedure AddDettaglio(PDett: TDettaglio);
    function GetInfoElaborazione: TInfoElaborazione;
    function  GetOutput: TPersistent;
    procedure SetOutput(const Value: TPersistent);
  public
    //---------------------------------------------------------
    [JSONMarshalled(False)]
    MemTable: TFDMemtable;
    [JSONMarshalled(False)]
    JSONDatasets: TFDJSONDataSets;
    //---------------------------------------------------------

    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function Clone: TRisultato;
    function ToString: String; override;
    function Check(POutClass: TClass): TResCtrl;
    procedure AddInfo(const PMessage: String);
    procedure AddWarning(const PMessage: String);
    procedure AddError(const PErrCode: TErrorCode; const PErrMessage: String; const PErrUserMessage: String = ''); overload;
    procedure AddError(const PErrMessage: String; const PErrUserMessage: String = ''); overload;
    function  GetDurataMetodo: Cardinal;
    procedure SetDurataMetodo(Value: Cardinal);
    property Status: TStatus read FStatus;
    property StatusInfo: String read FStatusInfo;
    property InfoElaborazione: TInfoElaborazione read GetInfoElaborazione;
    property Output: TPersistent read GetOutput write SetOutput;
  end;

  // classe generica per wrap di un tipo semplice
  {
  TGenericContainer<T> = class(TObject)
  private
    FValue: T;
  public
    constructor Create(Value: T);
    property Value: T read FValue;
  end;
  }

  // classe specifica per wrap di un array di byte
  TByteDynArrayWrapper = class(TPersistent)
  private
    FValue: TByteDynArray;
  public
    constructor Create(Value: TByteDynArray);
    destructor Destroy; override;
    procedure Assign(APersistent: TPersistent); override;
    function Clone: TByteDynArrayWrapper;
    function ToString: String; override;
    property Value: TByteDynArray read FValue;
  end;

  // classi di eccezioni personalizzate per i webservices
  EC200Exception = class(Exception)
  private
    FCode: TErrorCode;
    FUserMessage: String;
    function GetCode: TErrorCode;
    procedure SetCode(const Val: TErrorCode);
    function GetUserMessage: String;
    procedure SetUserMessage(const Val: String);
  protected
    procedure RaisingException(P: System.PExceptionRecord); override;
  public
    constructor Create(const PMsg: string; const PUserMsg: String); reintroduce; overload;
    property Code: TErrorCode read GetCode write SetCode;
    property UserMessage: String read GetUserMessage write SetUserMessage;
  end;

  EC200NoConnection = class(EC200Exception)
  protected
    procedure RaisingException(P: System.PExceptionRecord); override;
  end;

  EC200AuthError = class(EC200Exception)
  protected
    procedure RaisingException(P: System.PExceptionRecord); override;
  end;

  EC200InvalidParameter = class(EC200Exception)
  protected
    procedure RaisingException(P: System.PExceptionRecord); override;
  end;

  EC200MarshallingError = class(EC200Exception)
  protected
    procedure RaisingException(P: System.PExceptionRecord); override;
  end;

  EC200UnmarshallingError = class(EC200Exception)
  protected
    procedure RaisingException(P: System.PExceptionRecord); override;
  end;

  EC200InvalidOperation = class(EC200Exception)
  protected
    procedure RaisingException(P: System.PExceptionRecord); override;
  end;

  EC200NotImplemented = class(EC200Exception)
  protected
    procedure RaisingException(P: System.PExceptionRecord); override;
  end;

  EC200DataNotFoundError = class(EC200Exception)
  protected
    procedure RaisingException(P: System.PExceptionRecord); override;
  end;

  EC200ExecutionError = class(EC200Exception)
  protected
    procedure RaisingException(P: System.PExceptionRecord); override;
  end;

const
  // costanti comuni
  DS_OBJECT_SESSIONE_IRISWIN       = 'SessioneIrisWin';

  // informazioni per formattazione data/ora per scambio dati via JSON
  JSON_DATE_SEPARATOR: Char        = '-';
  JSON_SHORT_DATE_FMT              = 'yyyy-mm-dd';
  JSON_TIME_SEPARATOR: Char        = ':';
  JSON_SHORT_TIME_FMT              = 'hhhh:nn:ss';
  JSON_LONG_TIME_FMT               = 'hhhh:nn:ss';

  // costanti utilizzate nella unit più vecchia R014
  ERR_EC200CONNESSIONE_DB          =   10; // 'Connessione al database non disponibile'; // usato in R014
  ERR_EC200NON_PREVISTO            =   99; // 'Errore imprevisto';                       // usato in R014

implementation

uses
    System.Rtti
  , C200UWebServicesUtils
  ;

{ TDettaglio }

constructor TDettaglio.Create;
begin
  inherited Create;
  FTime:=Now;
  FTipo:=TTipoDettaglioRec.Info;
  FErrCode:=TErrorCode.NoError;
  FMessage:='';
end;

constructor TDettaglio.Create(PTipo: TTipoDettaglio; PMessage: String);
begin
  Create;
  FTipo:=PTipo;
  FMessage:=PMessage;
  FErrCode:=TErrorCode.NoError;
  FErrUserMessage:='';
end;

constructor TDettaglio.Create(PTipo: TTipoDettaglio; PMessage: String; PErrCode: TErrorCode; PErrUserMessage: String);
begin
  Create;
  FTipo:=PTipo;
  FMessage:=PMessage;
  FErrCode:=PErrCode;
  if PErrUserMessage.Trim = '' then
    FErrUserMessage:=PMessage
  else
    FErrUserMessage:=PErrUserMessage;
end;

procedure TDettaglio.Clear;
begin
  FTime:=0;
  FTipo:=TTipoDettaglioRec.Info;
  FMessage:='';
  FErrCode:=TErrorCode.NoError;
  FErrUserMessage:='';
end;

procedure TDettaglio.Assign(APersistent: TPersistent);
begin
  if APersistent is TDettaglio then
  begin
    FTime:=TDettaglio(APersistent).Time;
    FTipo:=TDettaglio(APersistent).Tipo;
    FMessage:=TDettaglio(APersistent).Message;
    FErrCode:=TDettaglio(APersistent).ErrCode;
    FErrUserMessage:=TDettaglio(APersistent).ErrUserMessage;
  end
  else
    inherited Assign(APersistent);
end;

function TDettaglio.ToString: String;
begin
  Result:=inherited;
end;

function TDettaglio.ToStatus: TStatus;
begin
  case FTipo of
    TTipoDettaglioRec.Debug:   Result:=TStatusRec.Ok;
    TTipoDettaglioRec.Info:    Result:=TStatusRec.Ok;
    TTipoDettaglioRec.Warning: Result:=TStatusRec.Warning;
    TTipoDettaglioRec.Error:   Result:=TStatusRec.Error;
  else
    raise Exception.Create('Tipo dettaglio non valido!');
  end;
end;

function TDettaglio.ToStatusInfo: String;
begin
  Result:=FMessage;
  if FTipo = TTipoDettaglioRec.Error then
    Result:=Format('%s: %s',[FErrCode.ToStatusString,Result]);
end;

{ TInfoElaborazione }

constructor TInfoElaborazione.Create;
begin
  inherited;

  FDuration:=0;
  FErrors:=False;
  FWarnings:=False;
  SetLength(FDettagli,0);
end;

destructor TInfoElaborazione.Destroy;
var
  i: Integer;
begin
  for i:=High(FDettagli) downto Low(FDettagli) do
    FreeAndNil(FDettagli[i]);
  SetLength(FDettagli,0);
  inherited;
end;

procedure TInfoElaborazione.Clear;
begin
  FDuration:=0;
  FErrors:=False;
  FWarnings:=False;
  SetLength(FDettagli,0);
end;

procedure TInfoElaborazione.Assign(APersistent: TPersistent);
var
  i: Integer;
begin
  if APersistent is TInfoElaborazione then
  begin
    FDuration:=TInfoElaborazione(APersistent).Duration;
    FErrors:=TInfoElaborazione(APersistent).Errors;
    FWarnings:=TInfoElaborazione(APersistent).Warnings;
    SetLength(FDettagli,Length(TInfoElaborazione(APersistent).Dettagli));
    for i:=Low(FDettagli) to High(FDettagli) do
    begin
      FDettagli[i]:=TDettaglio.Create;
      FDettagli[i].Assign(TInfoElaborazione(APersistent).Dettagli[i]);
    end;
  end
  else
    inherited Assign(APersistent);
end;

function TInfoElaborazione.GetDettagli: TArrayDettaglio;
begin
  Result:=FDettagli;
end;

function TInfoElaborazione.ToString: String;
begin
  Result:=inherited;
end;

procedure TInfoElaborazione.AddDettaglio(PDett: TDettaglio);
begin
  // aggiunge il dettaglio all'array
  SetLength(FDettagli,Length(FDettagli) + 1);
  FDettagli[High(FDettagli)]:=PDett;

  // imposta proprietà del risultato in base al tipo di dettaglio aggiunto
  case PDett.FTipo of
    TTipoDettaglioRec.Error:
      begin
        FErrors:=True;
      end;
    TTipoDettaglioRec.Warning:
      begin
        FWarnings:=True;
      end;
  end;
end;

{ TRisultato }

constructor TRisultato.Create;
begin
  inherited Create;

  FStatus:=TStatusRec.Ok;
  FStatusInfo:='';
  FInfoElaborazione:=TInfoElaborazione.Create;
  FOutput:=nil;
  //---------------------------------------------------------
  JSONDatasets:= nil;
  MemTable := nil;
  //---------------------------------------------------------
end;

destructor TRisultato.Destroy;
begin
  FreeAndNil(FInfoElaborazione);
  // è necessario effettuare la free dell'output generato
  if FOutput <> nil then
    try FreeAndNil(FOutput); except end;

  //---------------------------------------------------------
  if JSONDatasets <> nil then
    FreeAndNil(JSONDatasets);
  if MemTable <> nil then
    FreeAndNil(MemTable);
  //---------------------------------------------------------
  inherited;
end;

function TRisultato.Check(POutClass: TClass): TResCtrl;
// verifica la risposta del servizio e restituisce:
//   - True
//     se risposta ok
//   - False + messaggio
//     se risposta non valida o contenente errori
begin
  Result.Clear;

  // risposta non ok (con warning / errori)
  if FStatus <> srOk then
  begin
    Result.Messaggio:=FStatusInfo;
    Exit;
  end;

  // se è indicato il tipo di output atteso lo verifica
  if POutClass = nil then
  begin
    // verifica assenza output
    if FOutput <> nil then
    begin
      // situazione anomala: gestita con un messaggio di errore
      Result.Messaggio:=Format('Il servizio ha fornito un output inatteso:'#13#10'%s',[FOutput.ClassName]);
      Exit;
    end;
  end
  else
  begin
    // verifica presenza output
    if FOutput = nil then
    begin
      // situazione anomala: gestita con un messaggio di errore
      Result.Messaggio:='Il servizio non ha fornito un output nella risposta';
      Exit;
    end;

    // verifica tipo output
    if not (FOutput is POutClass) then
    begin
      // situazione anomala: gestita con un messaggio di errore
      Result.Messaggio:=Format('Il servizio ha fornito un output non previsto'#13#10 +
                               'Ricevuto: %s'#13#10 +
                               'Atteso: %s',
                               [FOutput.ClassName,
                                POutClass.ClassName]);
      Exit;
    end;
  end;

  // controlli ok
  Result.Ok:=True;
end;

procedure TRisultato.Clear;
begin
  inherited;

  FStatus:=TStatusRec.Ok;
  FStatusInfo:='';
  FInfoElaborazione.Clear;
  FOutput:=nil;
end;

procedure TRisultato.Assign(APersistent: TPersistent);
var
  LResOutput: TPersistent;
  LCtx: TRttiContext;
  LType: TRttiType;
  LValue: TValue;
begin
  if APersistent is TRisultato then
  begin
    // informazioni elaborazione
    FStatus:=TRisultato(APersistent).Status;
    FStatusInfo:=TRisultato(APersistent).StatusInfo;
    FInfoElaborazione.Assign(TRisultato(APersistent).InfoElaborazione);

    // output elaborazione
    //   per la clonazione si usa il metodo create + assign
    //   utilizza RTTI per invocare il costruttore corretto (e non quello generico di TPersistent)
    LResOutput:=TRisultato(APersistent).Output;
    if LResOutput <> nil then
    begin
      LCtx:=TRttiContext.Create;
      try
        LType:=LCtx.GetType(LResOutput.ClassType);
        LValue:=LType.GetMethod('Create').Invoke(LType.AsInstance.MetaclassType,[]);
        FOutput:=(LValue.AsObject as TPersistent);
        FOutput.Assign(LResOutput);
      finally
        LCtx.Free;
      end;
    end;
  end
  else
    inherited Assign(APersistent);
end;

function TRisultato.Clone: TRisultato;
begin
  Result:=TRisultato.Create;
  Result.Assign(Self);
end;

function TRisultato.ToString: String;
begin
  Result:=inherited;
end;

function TRisultato.GetInfoElaborazione: TInfoElaborazione;
begin
  Result:=FInfoElaborazione;
end;

function TRisultato.GetOutput: TPersistent;
begin
  Result:=FOutput;
end;

procedure TRisultato.SetOutput(const Value: TPersistent);
begin
  FOutput:=Value;
end;

function TRisultato.GetDurataMetodo: Cardinal;
begin
  if FInfoElaborazione <> nil then
    Result:=FInfoElaborazione.Duration
  else
    Result:=0;
end;

procedure TRisultato.SetDurataMetodo(Value: Cardinal);
begin
  FInfoElaborazione.Duration:=Value;
end;

procedure TRisultato.AddDettaglio(PDett: TDettaglio);
var
  LNewStatus: TStatus;
  LNumDett: Integer;
  LIsDettaglioImportante: Boolean;
begin
  LNewStatus:=PDett.ToStatus;

  // imposta la proprietà StatusInfo del risultato
  LNumDett:=Length(FInfoElaborazione.FDettagli);
  LIsDettaglioImportante:=Integer(LNewStatus) > Integer(FStatus);
  if (LNumDett = 0) or (LIsDettaglioImportante) then
  begin
    // se il dettaglio è il primo ed è l'unico oppure
    // è di importanza maggiore del precedente
    FStatusInfo:=PDett.ToStatusInfo;
  end
  else if (LNumDett > 0) and (FStatus = TStatusRec.Ok) and (PDett.Tipo = TTipoDettaglioRec.Info) then
  begin
    // se lo status è ok e vengono accodati più messaggi di informazione
    // cancella lo status info (non è significativo)
    FStatusInfo:='';
  end;

  // imposta lo Status del risultato in base al tipo di dettaglio aggiunto
  if LIsDettaglioImportante then
    FStatus:=LNewStatus;

  // aggiunge il dettaglio alle informazioni di elaborazione
  FInfoElaborazione.AddDettaglio(PDett);
end;

procedure TRisultato.AddInfo(const PMessage: String);
var
  D: TDettaglio;
begin
  D:=TDettaglio.Create(TTipoDettaglioRec.Info,PMessage);
  AddDettaglio(D);
end;

procedure TRisultato.AddWarning(const PMessage: String);
var
  D: TDettaglio;
begin
  D:=TDettaglio.Create(TTipoDettaglioRec.Warning,PMessage);
  AddDettaglio(D);
end;

procedure TRisultato.AddError(const PErrCode: TErrorCode; const PErrMessage: String; const PErrUserMessage: String = '');
var
  D: TDettaglio;
begin
  D:=TDettaglio.Create(TTipoDettaglioRec.Error,PErrMessage,PErrCode,PErrUserMessage);
  AddDettaglio(D);
end;

procedure TRisultato.AddError(const PErrMessage: String; const PErrUserMessage: String = '');
var
  D: TDettaglio;
begin
  D:=TDettaglio.Create(TTipoDettaglioRec.Error,PErrMessage,TErrorCode.Generic,PErrUserMessage);
  AddDettaglio(D);
end;

{ TGenericContainer<T> }
{
constructor TGenericContainer<T>.Create(Value: T);
begin
  FValue:=Value;
end;
}

{ TByteDynArrayWrapper }

function TByteDynArrayWrapper.Clone: TByteDynArrayWrapper;
begin
  Result:=TByteDynArrayWrapper.Create(Self.Value);
end;

constructor TByteDynArrayWrapper.Create(Value: TByteDynArray);
begin
  FValue:=Value;
end;

destructor TByteDynArrayWrapper.Destroy;
begin
  SetLength(FValue,0);
  inherited;
end;

procedure TByteDynArrayWrapper.Assign(APersistent: TPersistent);
var
  i: Integer;
begin
  if APersistent is TByteDynArrayWrapper then
  begin
    SetLength(FValue,Length(TByteDynArrayWrapper(APersistent).Value));
    for i:=Low(FValue) to High(FValue) do
    begin
      FValue[i]:=TByteDynArrayWrapper(APersistent).Value[i];
    end;
  end
  else
    inherited Assign(APersistent);
end;

function TByteDynArrayWrapper.ToString: String;
begin
  Result:=inherited;
end;

{ TC200DateTimeInterceptor }

constructor TC200DateTimeInterceptor.Create(ADateTimeIsUTC: Boolean);
begin
  ConverterType:=ctString;
  ReverterType:=rtString;
  FDateTimeIsUTC:=True;
end;

function TC200DateTimeInterceptor.StringConverter(Data: TObject; Field: string): string;
var
  ctx: TRTTIContext;
  date: TDateTime;
begin
  date:=ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
  Result:=DateTimeToStr(date,TC200FWebServicesUtils.CreateJSONFormatSettings);
end;

procedure TC200DateTimeInterceptor.StringReverter(Data: TObject; Field, Arg: string);
var
  ctx: TRTTIContext;
  datetime: TDateTime;
begin
  datetime:=StrToDateTime(Arg,TC200FWebServicesUtils.CreateJSONFormatSettings);
  ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data, datetime);
end;

{ TC200DateTimeInputInterceptor }

constructor TC200DateTimeInputInterceptor.Create(ADateTimeIsUTC: Boolean);
begin
  ConverterType:=ctString;
  ReverterType:=rtString;
  FDateTimeIsUTC:=True;
end;

function TC200DateTimeInputInterceptor.StringConverter(Data: TObject; Field: string): string;
var
  ctx: TRTTIContext;
  date: TDateTime;
  LI64: Int64;
begin
  date:=ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
  LI64:=PInt64(@date)^;
  Result:=Format('%.16X',[LI64]);
end;

procedure TC200DateTimeInputInterceptor.StringReverter(Data: TObject; Field, Arg: string);
var
  ctx: TRTTIContext;
  datetime: TDateTime;
  LI64: Int64;
  LDouble: double;
begin
  LI64:=StrToInt64('$' + Arg);
  LDouble:=PDouble(@LI64)^;
  datetime:=TDateTime(LDouble);
  ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data, datetime);
end;

{ EC200Exception }
constructor EC200Exception.Create(const PMsg, PUserMsg: String);
begin
  create(PMsg);
  FUserMessage:=PUserMsg;
end;

function EC200Exception.GetCode: TErrorCode;
begin
  Result:=FCode;
end;

procedure EC200Exception.SetCode(const Val: TErrorCode);
begin
  FCode:=Val;
end;

function EC200Exception.GetUserMessage: String;
begin
  Result:=FUserMessage;
end;

procedure EC200Exception.SetUserMessage(const Val: String);
begin
  FUserMessage:=Val;
end;

procedure EC200Exception.RaisingException(P: System.PExceptionRecord);
begin
  inherited;
  FCode:=TErrorCode.Generic;
end;

{ EC200NoConnection }

procedure EC200NoConnection.RaisingException(P: System.PExceptionRecord);
begin
  inherited;
  FCode:=TErrorCode.NoConnection;
end;

{ EC200AuthError }

procedure EC200AuthError.RaisingException(P: System.PExceptionRecord);
begin
  inherited;
  FCode:=TErrorCode.AuthError;
end;

{ EC200InvalidParameter }

procedure EC200InvalidParameter.RaisingException(P: System.PExceptionRecord);
begin
  inherited;
  FCode:=TErrorCode.InvalidParameter;
end;

{ EC200MarshallingError }

procedure EC200MarshallingError.RaisingException(P: System.PExceptionRecord);
begin
  inherited;
  FCode:=TErrorCode.MarshallingError;
end;

{ EC200UnmarshallingError }

procedure EC200UnmarshallingError.RaisingException(P: System.PExceptionRecord);
begin
  inherited;
  FCode:=TErrorCode.UnmarshallingError;
end;

{ EC200InvalidOperation }

procedure EC200InvalidOperation.RaisingException(P: System.PExceptionRecord);
begin
  inherited;
  FCode:=TErrorCode.InvalidOperation;
end;

{ EC200NotImplemented }

procedure EC200NotImplemented.RaisingException(P: System.PExceptionRecord);
begin
  inherited;
  FCode:=TErrorCode.NotImplemented;
end;

{ EC200DataNotFoundError }

procedure EC200DataNotFoundError.RaisingException(P: System.PExceptionRecord);
begin
  inherited;
  FCode:=TErrorCode.DataNotFound;
end;

{ EC200ExecutionError }

procedure EC200ExecutionError.RaisingException(P: System.PExceptionRecord);
begin
  inherited;
  FCode:=TErrorCode.MethodExecutionError;
end;

{ TErrorCodeRecHelper }

function TErrorCodeRecHelper.ToString: string;
begin
  case Self of
    TErrorCode.NoError:
      Result:='nessun errore';
    TErrorCode.Generic:
      Result:='errore generico del webservice';
    TErrorCode.NoConnection:
      Result:='errore di connessione al database';
    TErrorCode.AuthError:
      Result:='errore di autenticazione';
    TErrorCode.InvalidParameter:
      Result:='errore nei parametri della richiesta';
    TErrorCode.MarshallingError:
      Result:='errore di marshalling';
    TErrorCode.UnmarshallingError:
      Result:='errore di unmarshalling';
    TErrorCode.InvalidOperation:
      Result:='operazione non valida';
    TErrorCode.NotImplemented:
      Result:='metodo non implementato';
    TErrorCode.DataNotFound:
      Result:='dato non trovato';
    TErrorCode.MethodExecutionError:
      Result:='errore di esecuzione del metodo';
  else
    Result:='errore sconosciuto';
  end;
end;

function TErrorCodeRecHelper.ToStatusString: String;
begin
  Result:=Format('E%.2d',[Integer(Self)]);
end;

end.
