unit R014URestDM;

interface

uses
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} A000UCostanti,
  A000USessione, DBXJSONReflect, Math, C180FunzioniGenerali,
  B021UCustomConverter, B021UUtils, C200UWebServicesTypes, R600, DatiBloccati, Variants,
  SysUtils, StrUtils, Classes, DB, Oracle, OracleData, DBXPlatform,
  System.Generics.Collections;

type
  TInfoAutenticazione = class
  private
    FAutenticato: Boolean;
    FUtente: String;
    FRuolo: String;
  public
    constructor Create;
    procedure SetAutenticato(const Value: Boolean);
    function  IsAutenticato: Boolean;
    procedure SetUtente(const Value: String);
    function  GetUtente: String;
    procedure SetRuolo(const Value: String);
    function  GetRuolo: String;
    property  Autenticato: Boolean read IsAutenticato write SetAutenticato;
    property  Utente: String read GetUtente write SetUtente;
    property  Ruolo: String read GetRuolo write SetRuolo;
  end;

  TDettaglio = class(TPersistent)
  private
    FTime: TDateTime;
    FTipo: String;
    FInput: String;
    FErrCode: Integer;
    FResult: String;
  end;

  TRisultato = class(TPersistent)
  private
    FTipologia: String;
    FOperazione: String;
    FInizio: TDateTime;
    FFine: TDateTime;
    FErrors: Boolean;
    FWarnings: Boolean;
    FInput: String;
    FDettagli: array of TDettaglio;
    procedure AddDettaglio(PDett: TDettaglio);
    function  GetInput: String;
    procedure SetInput(const Val: String);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddResultOk;
    procedure AddWarning(const PWarnDescription: String);
    procedure AddError(const PErrCode: Integer; const PErrDescription: String); overload;
    procedure AddError(E: Exception); overload;
    procedure Clear;
    function ToJson: TJSONObject;
    property Input: String read GetInput write SetInput;
  end;

  TR014FRestDM = class(TDataModule)
    selProg: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject); overload;
    procedure DataModuleDestroy(Sender: TObject);
  private
    FConnessoDB: Boolean;                // true se la connessione al db è ok
    FDatiConnessione: TDatiConnessione;  // dati di connessione al database
    FSIW: TSessioneIrisWin;              // sessione iriswin
    FLogAttivita: Boolean;               // true per effettuare log di debug su file
    FAutenticazione: Boolean;            // true per specificare che necessita di token di autenticazione
    FOperazione: String;                 // operazione metodo: (C)reate, (R)ead, (U)pdate, (D)elete
    FDescOperazione: String;             // descrizione operazione
    FDatiAuth: TInfoAutenticazione;      // informazioni stato autenticazione utente
    FParList: TStringList;               // lista interna di parametri
    FJObject: TJSONObject;               // oggetto json per operazioni di post / put
    procedure SetOperazione(const Val: String);
    function VerificaTokenAccesso: TResCtrl;
  protected
    selDatiBloccati: TDatiBloccati;
    // rappresenta il risultato standard in presenza di errori di elaborazione
    RisultatoStd: TRisultato;
    procedure Log(const PNomeProc: String; const PLogInfo: String);
    // funzioni per marshalling / unmarshalling json
    function ConvertJSON(PObj: TPersistent): TJSONObject; virtual;
    function RevertJSON(PJson: TJSONObject): TPersistent; virtual;
    // se i parametri sono ok, restituire True
    // altrimenti restituire False e valorizzare RErrMsg con un messaggio di errore
    function ControlloParametri(var RErrMsg: String): Boolean; virtual; abstract;
    // se il metodo prevede una autenticazione, ridefinire questo metodo, altrimenti no
    //   se l'autenticazione è andata a buon fine restituire True
    //   altrimenti restituire False e valorizzare RErrAuth con un messaggio di errore
    function ControlloAutenticazione(var RErrAuth: String): TInfoAutenticazione; virtual;
    function GetResultOnError(PException: Exception): TJSONObject; virtual;
  public
    constructor Create(AOwner: TComponent; PDatiConnessione: TDatiConnessione; PAutenticazione: Boolean; POperazione: String; PDebugLogSuFile: Boolean); reintroduce; overload;
    procedure SetParam(const Chiave, Valore: String);
    function  GetParam(const Chiave: String): String;
    procedure SetJObject(PObject: TJSONObject);
    function  GetJObject: TJSONObject;
    function  EseguiOperazione: TJSONObject;
    function  AcceptDato: TJSONObject; virtual;
    function  GetDato: TJSONObject; virtual;
    function  UpdateDato: TJSONObject; virtual;
    function  CancelDato: TJSONObject; virtual;
    procedure Disconnetti;
    property JObject: TJSONObject read GetJObject write SetJObject;
    property DatiConnessione: TDatiConnessione read FDatiConnessione write FDatiConnessione;
    property ConnessoDB: Boolean read FConnessoDB write FConnessoDB;
    property Autenticazione: Boolean read FAutenticazione;
    property Operazione: String read FOperazione;
    property SIW: TSessioneIrisWin read FSIW write FSIW;
    property DatiAuth: TInfoAutenticazione read FDatiAuth write FDatiAuth;
  end;

implementation

{$R *.dfm}

procedure TR014FRestDM.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
  // inizializzazioni
  FConnessoDB:=False;
  FSIW:=nil;
  FLogAttivita:=False;
  FAutenticazione:=False;
  SetOperazione(OPER_READ);
  FParList:=TStringList.Create;
  FJObject:=nil;
  RisultatoStd:=TRisultato.Create;
  selDatiBloccati:=TDatiBloccati.Create(nil);

  // gestione sessione iriswin
  if Self.Owner is TSessioneIrisWin and
     Assigned(Self.Owner) and
     Assigned(TSessioneIrisWIN(Self.Owner).SessioneOracle) then
  begin
    // attribuzione oraclesession
    SIW:=TSessioneIrisWIN(Self.Owner);
    for i:=0 to ComponentCount - 1 do
    begin
      if Components[i] is TOracleQuery then
        try (Components[i] as TOracleQuery).Session:=SIW.SessioneOracle; except end
      else if Components[i] is TOracleDataSet then
        try (Components[i] as TOracleDataSet).Session:=SIW.SessioneOracle; except end;
    end;
    FConnessoDB:=True;
  end;
end;

procedure TR014FRestDM.DataModuleDestroy(Sender: TObject);
begin
  try FreeAndNil(selDatiBloccati); except end;
  try FreeAndNil(RisultatoStd); except end;
  try FreeAndNil(FParList); except end;
  try
    if FDatiAuth <> nil then
      FreeAndNil(FDatiAuth);
  except end;
end;

procedure TR014FRestDM.Log(const PNomeProc: String; const PLogInfo: String);
// se è attivo LogAttivita traccia sul file di log definito in B021UUtils
// l'operazione indicata
var
  S: String;
begin
  if FLogAttivita then
  begin
    S:=GetLogFmt(Self.ClassName,PNomeProc,PLogInfo);
    R180ScriviMsgLog(FILE_LOG,S);
  end;
end;

function TR014FRestDM.ControlloAutenticazione(var RErrAuth: String): TInfoAutenticazione;
// ridefinire solo se è necessario verificare l'autenticazione
// se (Result.Autenticato = False) sarà lanciata un'eccezione di tipo EC200AuthError
begin
  Result:=nil;
end;

function TR014FRestDM.ConvertJSON(PObj: TPersistent): TJSONObject;
// ridefinire se necessario
begin
  Result:=nil;
end;

constructor TR014FRestDM.Create(AOwner: TComponent; PDatiConnessione: TDatiConnessione;
  PAutenticazione: Boolean; POperazione: String; PDebugLogSuFile: Boolean);
begin
  inherited Create(AOwner);

  FDatiConnessione:=PDatiConnessione;
  FAutenticazione:=PAutenticazione;
  FOperazione:=POperazione;
  FLogAttivita:=PDebugLogSuFile;
end;

function TR014FRestDM.RevertJSON(PJson: TJSONObject): TPersistent;
// ridefinire se necessario
begin
  Result:=nil;
end;

function TR014FRestDM.VerificaTokenAccesso: TResCtrl;
// verifica il token di accesso fornito nella querystring (insieme al timestamp)
var
  LMetaData: TDSInvocationMetadata;
  LParToken: String;
  LParTimestampStr: String;
  LParTimestamp: Int64;
  i: Integer;
  LParam: string;
  LParKeyValue: TArray<String>;
  LKey: string;
  LValue: string;
  LParTokenPassphrase: string;
  LParTokenTimeout: Integer;
begin
  Result.Clear;

  LParToken:='';
  LParTimestampStr:='';

  // gestione parametri querystring
  // cfr. http://stackoverflow.com/questions/10562454/delphi-xe2-how-to-define-custom-datasnap-rest-uri
  LMetaData:=GetInvocationMetadata;

  // estrae il token di autenticazione ed il timestamp dalla querystring
  for i:=0 to LMetaData.QueryParams.Count - 1 do
  begin
    LParam:=LMetaData.QueryParams[i];

    LParKeyValue:=LParam.Split(['='],2,None);
    LKey:=LParKeyValue[0];
    LValue:=LParKeyValue[1];
    if LKey = 'token' then
    begin
      LParToken:=LValue;
    end
    else if LKey = 'timestamp' then
    begin
      LParTimestampStr:=LValue;
    end;
  end;

  // verifica i parametri di autenticazione
  if LParToken = '' then
  begin
    Result.Messaggio:='Accesso al metodo non consentito: il token di autenticazione non è stato fornito';
    Exit;
  end;

  if LParTimestampStr = '' then
  begin
    Result.Messaggio:='Accesso al metodo non consentito: dati di autenticazione non indicati';
    Exit;
  end;

  if not TryStrToInt64(LParTimestampStr,LParTimestamp) then
  begin
    Result.Messaggio:='Accesso al metodo non consentito: dati di autenticazione non validi';
    Exit;
  end;

  // estrae il timeout impostato
  LParTokenPassphrase:=SIW.Parametri.CampiRiferimento.C30_WebSrv_B021_PASSPHRASE;
  LParTokenTimeout:=StrToIntDef(SIW.Parametri.CampiRiferimento.C30_WebSrv_B021_TIMEOUT,0);

  // verifica che il token di accesso sia valido
  Result:=VerificaToken(LParToken, LParTimestamp, LParTokenPassphrase, LParTokenTimeout);
  if not Result.Ok then
    Exit;
end;

function TR014FRestDM.EseguiOperazione: TJSONObject;
// esegue l'operazione richiesta
var
  LParametriOk: Boolean;
  LAuthPrevista, LAuthOk: Boolean;
  LErrore: String;
  LResCtrl: TResCtrl;
const
  NOME_PROC = 'EseguiOperazione';
begin
  Result:=nil;

  // prepara il json standard da inviare in caso di problemi durante l'esecuzione del metodo richiesto
  RisultatoStd.Clear;
  RisultatoStd.FTipologia:=Self.ClassName.Substring(6,Self.ClassName.Length - 8);
  RisultatoStd.FOperazione:=Operazione;
  RisultatoStd.FInizio:=Now;

  try
    // 1. verifica connessione al db
    if not ConnessoDB then
    begin
      Log(NOME_PROC,Format('%d: %s',[ERR_EC200CONNESSIONE_DB,FDatiConnessione.Database]));
      raise EC200NoConnection.CreateFmt('impossibile stabilire una connessione al database [%s], azienda [%s], operatore [%s]',[FDatiConnessione.Database,FDatiConnessione.Azienda,FDatiConnessione.UtenteI070]);
    end;

    // 2. controllo del token di accesso se previsto da parametro aziendale
    //    i metodi che espongono dati privati e sensibili devono essere protetti tramite autenticazione con token
    if (SIW.Parametri.CampiRiferimento.C30_WebSrv_B021_TOKEN = 'S') and
       (FAutenticazione) then
    begin
      LResCtrl:=VerificaTokenAccesso;
      if not LResCtrl.Ok then
      begin
        Log(NOME_PROC,LResCtrl.Messaggio);
        raise EC200AuthError.Create(LResCtrl.Messaggio);
      end;
    end;

    // 3. controllo dei parametri della richiesta
    try
      LParametriOk:=ControlloParametri(LErrore);
    except
      on E: Exception do
      begin
        Log(NOME_PROC,Format('errore in fase di controllo dei parametri: %s',[E.Message]));
        raise EC200InvalidParameter.Create(E.Message);
      end;
    end;
    if not LParametriOk then
    begin
      Log(NOME_PROC,Format('errore nei parametri: %s',[LErrore]));
      raise EC200InvalidParameter.Create(LErrore);
    end;

    // 4. verifica autenticazione
    try
      DatiAuth:=ControlloAutenticazione(LErrore);
      // se il risultato è nil, significa che l'autenticazione non è prevista
      LAuthPrevista:=DatiAuth <> nil;
      if LAuthPrevista then
      begin
        // autenticazione prevista: verifica stato autenticazione
        LAuthOk:=DatiAuth.IsAutenticato;
        Log(NOME_PROC,Format('verifica autenticazione: utente %s',[IfThen(LAuthOk,'autenticato','non autenticato')]));
      end
      else
      begin
        // autenticazione non prevista
        Log(NOME_PROC,'autenticazione non prevista');
        LAuthOk:=True;
      end;
    except
      on E: Exception do
      begin
        Log(NOME_PROC,Format('errore in fase di autenticazione: %s',[E.Message]));
        raise EC200AuthError.Create(E.Message);
      end;
    end;
    // se l'utente non risulta autenticato solleva un'eccezione di tipo EC200AuthError
    if (LAuthPrevista) and (not LAuthOk) then
    begin
      Log(NOME_PROC,Format('autenticazione fallita: %s',[LErrore]));
      raise EC200AuthError.Create(LErrore);
    end;

    // 5. esecuzione dell'operazione richiesta
    Log(NOME_PROC,Format('inizio elaborazione richiesta %s',[FDescOperazione]));
    try
      // esegue il metodo corretto in base all'operazione
      if Operazione = OPER_CREATE then
        Result:=AcceptDato
      else if Operazione = OPER_READ then
        Result:=GetDato
      else if Operazione = OPER_UPDATE then
        Result:=UpdateDato
      else if Operazione = OPER_DELETE then
        Result:=CancelDato;
      Log(NOME_PROC,Format('fine elaborazione',[]));
    except
      on E: Exception do
      begin
        Log(NOME_PROC,Format('errore %s durante l''elaborazione: %s',[E.ClassName,E.Message]));
        Result:=nil;
        raise;
      end;
    end;
  except
    on E: EC200Exception do
    begin
      // eccezione contemplata a livello di B021
      RisultatoStd.AddError(E);
      // registra ora di fine esecuzione
      RisultatoStd.FFine:=Now;
      Result:=GetResultOnError(E);
      Exit;
    end;
    on E: Exception do
    begin
      // altri tipi di eccezione non gestiti
      RisultatoStd.AddError(E);
      // registra ora di fine esecuzione
      RisultatoStd.FFine:=Now;
      Result:=GetResultOnError(E);
    end;
  end;

  // elaborazione ok: registra ora di fine esecuzione
  RisultatoStd.FFine:=Now;

  // se non è previsto un oggetto Json specifico da restituire, utilizza quello standard
  if Result = nil then
    Result:=RisultatoStd.ToJson;
end;

function TR014FRestDM.AcceptDato: TJSONObject;
// ridefinire nella sottoclasse
const
  NOME_PROC = 'AcceptDato';
begin
  raise EC200NotImplemented.Create(NOME_PROC);
end;

function TR014FRestDM.GetDato: TJSONObject;
// ridefinire nella sottoclasse
const
  NOME_PROC = 'GetDato';
begin
  raise EC200NotImplemented.Create(NOME_PROC);
end;

function TR014FRestDM.UpdateDato: TJSONObject;
// ridefinire nella sottoclasse
const
  NOME_PROC = 'UpdateDato';
begin
  raise EC200NotImplemented.Create(NOME_PROC);
end;

function TR014FRestDM.CancelDato: TJSONObject;
const
  NOME_PROC = 'CancelDato';
// ridefinire nella sottoclasse
begin
  raise EC200NotImplemented.Create(NOME_PROC);
end;

function TR014FRestDM.GetResultOnError(PException: Exception): TJSONObject;
// ridefinire per restituire, in caso di errore in fase di elaborazione,
// un risultato json differente da quello standard
begin
  Result:=RisultatoStd.ToJson;
end;

procedure TR014FRestDM.Disconnetti;
begin
  if (Assigned(SIW)) and
     (SIW.SessioneOracle = nil) then
  begin
    if SIW.SessioneOracle.Connected then
    begin
      try
        SIW.SessioneOracle.Logoff;
        FConnessoDB:=False;
      except
      end;
    end
    else
    begin
      FConnessoDB:=False;
    end;
  end;
end;

procedure TR014FRestDM.SetParam(const Chiave, Valore: String);
begin
  FParList.Values[UpperCase(Chiave)]:=Valore;
end;

function TR014FRestDM.GetParam(const Chiave: String): String;
var
  LChiaveUpper: String;
begin
  LChiaveUpper:=Chiave.ToUpper;
  if FParList.IndexOfName(LChiaveUpper) < 0 then
    Result:=''
  else
    Result:=FParList.Values[LChiaveUpper];
end;

procedure TR014FRestDM.SetJObject(PObject: TJSONObject);
begin
  FJObject:=PObject;
end;

function TR014FRestDM.GetJObject: TJSONObject;
begin
  Result:=FJObject;
end;

procedure TR014FRestDM.SetOperazione(const Val: String);
begin
  if (Val = OPER_CREATE) or (Val = OPER_READ) or (Val = OPER_UPDATE) or (Val = OPER_DELETE) then
  begin
    FOperazione:=Val;
    if Val = OPER_CREATE then
      FDescOperazione:=DESC_OPER_CREATE
    else if Val = OPER_READ then
      FDescOperazione:=DESC_OPER_READ
    else if Val = OPER_UPDATE then
      FDescOperazione:=DESC_OPER_UPDATE
    else if Val = OPER_DELETE then
      FDescOperazione:=DESC_OPER_DELETE;
  end
  else
    raise EC200InvalidOperation.Create(Format('Operazione %s non valida!',[Val]));
end;

{ TRisultato }

constructor TRisultato.Create;
begin
  Clear;
end;

destructor TRisultato.Destroy;
var
  i: Integer;
begin
  for i:=High(FDettagli) downto Low(FDettagli) do
    FreeAndNil(FDettagli[i]);
  SetLength(FDettagli,0);
  inherited;
end;

procedure TRisultato.Clear;
var
  i: Integer;
begin
  FTipologia:='';
  FOperazione:='';
  FInizio:=0;
  FFine:=0;
  FErrors:=False;
  FWarnings:=False;
  FInput:='';
  for i:=High(FDettagli) downto Low(FDettagli) do
    FreeAndNil(FDettagli[i]);
  SetLength(FDettagli,0);
end;

function TRisultato.GetInput: String;
begin
  Result:=FInput;
end;

procedure TRisultato.SetInput(const Val: String);
begin
  FInput:=Val;
end;

procedure TRisultato.AddDettaglio(PDett: TDettaglio);
begin
  // ora del dettaglio
  if PDett.FTime = DATE_NULL then
    PDett.FTime:=Now;

  PDett.FInput:=FInput;

  // aggiunge il dettaglio all'array
  SetLength(FDettagli,Length(FDettagli) + 1);
  FDettagli[High(FDettagli)]:=PDett;

  if PDett.FTipo = 'error' then
    FErrors:=True
  else if PDett.FTipo = 'warning' then
    FWarnings:=True;
end;

procedure TRisultato.AddResultOk;
var
  D: TDettaglio;
begin
  D:=TDettaglio.Create;
  D.FTime:=Now;
  D.FTipo:='info';
  D.FErrCode:=0;
  if FOperazione = OPER_CREATE then
    D.FResult:='inserimento ok'
  else if FOperazione = OPER_READ then
    D.FResult:='lettura ok'
  else if FOperazione = OPER_UPDATE then
    D.FResult:='aggiornamento ok'
  else if FOperazione = OPER_DELETE then
    D.FResult:='cancellazione ok'
  else
    D.FResult:='';
  AddDettaglio(D);
end;

procedure TRisultato.AddWarning(const PWarnDescription: String);
var
  D: TDettaglio;
begin
  D:=TDettaglio.Create;
  D.FTime:=Now;
  D.FTipo:='warning';
  D.FErrCode:=0;
  D.FResult:=PWarnDescription;
  AddDettaglio(D);
end;

procedure TRisultato.AddError(const PErrCode: Integer; const PErrDescription: String);
var
  D: TDettaglio;
begin
  D:=TDettaglio.Create;
  D.FTime:=Now;
  D.FTipo:='error';
  D.FErrCode:=PErrCode;
  D.FResult:=PErrDescription;
  AddDettaglio(D);
end;

procedure TRisultato.AddError(E: Exception);
var
  LErrCode: Integer;
begin
  if E is EC200Exception then
    LErrCode:=Integer(EC200Exception(E).Code)
  else
    LErrCode:=ERR_EC200NON_PREVISTO;
  AddError(LErrCode,Format('%s (%s)',[E.Message,E.ClassName]))
end;

function TRisultato.ToJson: TJSONObject;
var
  DettArr: TJSONArray;
  hObj: TJSONObject;
  Dett: TDettaglio;
  i: Integer;
begin
  Result:=TJSONObject.Create;

  Result.AddPair('tipologia',TJsonString.Create(FTipologia));
  Result.AddPair('operazione',TJsonString.Create(FOperazione));
  Result.AddPair('start',TJsonString.Create(FormatDateTime('dd-mm-yyyy hhhh:nn:ss',FInizio)));
  Result.AddPair('end',TJsonString.Create(FormatDateTime('dd-mm-yyyy hhhh:nn:ss',FFine)));

  // indica se l'elaborazione ha prodotto errori
  if FErrors then
    Result.AddPair('errori',TJsonTrue.Create)
  else
    Result.AddPair('errori',TJsonFalse.Create);

  // indica se l'elaborazione ha prodotto warning
  if FWarnings then
    Result.AddPair('warning',TJsonTrue.Create)
  else
    Result.AddPair('warning',TJsonFalse.Create);

  // array dettaglio anomalie
  DettArr:=TJSONArray.Create;
  for i:=0 to High(FDettagli) do
  begin
    Dett:=FDettagli[i];

    hObj:=TJSONObject.Create;
    hObj.AddPair('data',TJsonString.Create(FormatDateTime('dd-mm-yyyy hhhh:nn:ss',Dett.FTime)));
    hObj.AddPair('input',TJsonString.Create(Dett.FInput));
    hObj.AddPair('codErrore',TJsonNumber.Create(Dett.FErrCode));
    hObj.AddPair('result',TJsonString.Create(Dett.FResult.Replace('\', '\\', [rfReplaceAll]).Replace('"', '''', [rfReplaceAll])));    //inserito il replace perchè \ e " sono caratteri di controllo json

    DettArr.Add(hObj);
  end;
  Result.AddPair('dettagli',DettArr);
end;

{ TInfoAutenticazione }

function TInfoAutenticazione.IsAutenticato: Boolean;
begin
  Result:=FAutenticato;
end;

constructor TInfoAutenticazione.Create;
begin
  inherited;
  FAutenticato:=False;
  FUtente:='';
  FRuolo:='';
end;

function TInfoAutenticazione.GetRuolo: String;
begin
  Result:=FRuolo;
end;

function TInfoAutenticazione.GetUtente: String;
begin
  Result:=FUtente;
end;

procedure TInfoAutenticazione.SetAutenticato(const Value: Boolean);
begin
  FAutenticato:=Value;
end;

procedure TInfoAutenticazione.SetRuolo(const Value: String);
begin
  FRuolo:=Value;
end;

procedure TInfoAutenticazione.SetUtente(const Value: String);
begin
  FUtente:=Value;
end;

end.
