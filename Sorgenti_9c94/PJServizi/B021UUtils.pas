unit B021UUtils;

interface

uses A000UCostanti, C180FunzioniGenerali, SysUtils, DateUtils, StrUtils, Generics.Collections, WinApi.Windows;

type

  TDatiConnessione = record
    Database: String;
    Azienda: String;
    UtenteI070: String;
  end;

  // **************************************************
  // *      CLASSI DI ECCEZIONI PERSONALIZZATE        *
  // **************************************************

  EB021NoConnection = class(Exception)
  end;

  EB021InvalidParameter = class(Exception)
  end;

  EB021MarshallingError = class(Exception)
  end;

  EB021UnmarshallingError = class(Exception)
  end;

  EB021InvalidOperation = class(Exception)
  end;

  EB021InvalidStructure = class(Exception)
  end;

  EB021DuplicateDocument = class(Exception)
  end;

  EB021NotImplemented = class(Exception)
  end;

  EB021ExecutionError = class(Exception)
  end;

  TMetodoRest = (mrGet, mrPut, mrPost, mrDelete);

  // **************************************************
  // *               METODI DI SUPPORTO               *
  // **************************************************

  function ConvertiDateStr(const PData: TDateTime): String;
  function ConvertiDateTimeStr(const PData: TDateTime): String;
  function ConvertiStrDate(const PDataStr: String; var RData: TDateTime): Boolean;
  function ConvertiStrDateTime(const PDataStr: String; var RData: TDateTime): Boolean;
  function CreateFormatSettingsMonzaHSGerardo: TFormatSettings;
  function CreaToken(const PUnixTime: Int64; const PParTokenPassphrase: String): String;
  function GetAziendaEffettiva(const PAzienda: String): String;
  function GetDatabaseEffettivo(const PDatabase: String): String;
  function GetDatiConnessione(const PDatabase, PAzienda, PUtenteI070: String): TDatiConnessione;
  function GetDatiConnessioneEffettivi(const PDatabase, PAzienda, PUtenteI070: String): TDatiConnessione;
  function GetHashAutenticazioneAostaAsl(const PUnixTime: Int64): String;
  function GetLogFmt(const PClassName, PProcName, PLogInfo: String): String;
  function GetQuerystringParams(const PQueryString: String): TDictionary<String,String>;
  function GetUnixTimeCorrente: Int64;
  function GetUtenteI070Effettivo(const PUtenteI070: String): String;
  function IsTimeOkAostaAsl(const PUnixTime: Int64): Boolean;
  function PulisciStringaJson(const strJson: String): String;
  function VerificaToken(const PToken: String; const PUnixTime: Int64; const PParTokenPassphrase: String; const PParTokenTimeout: Integer): TResCtrl;
const
  FILE_LOG                   = 'B021.log';           // path file log

  // valori di default per parametri da leggere su registro
  DATABASE_DEFAULT                        = '*';
  AZIENDA_DEFAULT                         = '*';
  UTENTE_I070_DEFAULT                     = '*';

  OPER_CREATE                = 'C';
  OPER_READ                  = 'R';
  OPER_UPDATE                = 'U';
  OPER_DELETE                = 'D';

  DESC_OPER_CREATE                        = 'create';
  DESC_OPER_READ                          = 'read';
  DESC_OPER_UPDATE                        = 'update';
  DESC_OPER_DELETE                        = 'delete';

  FIRLAB_DATO_LIBERO_TURNI   = 'ATTIVO_TURNI';       // dato libero anagrafico che identifica i turnisti
  FIRLAB_SHARED_PWD          = 'pwdIrisRostersha1';  // password condivisa per generazione hash
  FIRLAB_DATE_FMT            = 'dd-mm-yyyy';         // formato data standard
  FIRLAB_DATETIME_FMT        = 'dd-mm-yyyy hhhh:nn'; // formato data/ora standard
  FIRLAB_TIME_FMT            = 'hhhh:nn';            // formato ora standard

  // tipi dati integrazione anagrafica B014
  B014_TIPO_DATO_ALFANUMERICO             = 'A';
  B014_TIPO_DATO_NUMERICO                 = 'N';
  B014_TIPO_DATO_DATA                     = 'D';

  // dati personalizzati per Monza_HSGerardo
  MONZA_HSGERARDO_DATE_SEPARATOR: Char    = '-';                       // carattere di separazione data
  MONZA_HSGERARDO_SHORT_DATE_FMT          = 'dd-mm-yyyy';              // formato data standard

  // dati personalizzati per Aosta ASL
  AOSTA_ASL_SHARED_PWD                    = 'm0nD03dP$405tA';          // password condivisa per generazione hash
  AOSTA_ASL_VALIDITA_TOKEN                = 60;                        // validità del token espressa in secondi

  // costanti comuni
  SPAZIO = #32;
  TAB    = #9;
  CR     = #13;
  LF     = #10;

implementation

function ConvertiStrDate(const PDataStr: String; var RData: TDateTime): Boolean;
// converte la data indicata come stringa nel formato TDateTime
// formati riconosciuti:
//   yyyy-mm-dd
//   dd-mm-yyyy
var
  Anno,Mese,Giorno: String;
begin
  RData:=0;

  if Trim(PDataStr) = '' then
  begin
    Result:=True;
    Exit;
  end;

  if R180IsDigit(PDataStr,5) then
  begin
    // formato dd-mm-yyyy
    Anno:=Copy(PDataStr,7,4);
    Mese:=Copy(PDataStr,4,2);
    Giorno:=Copy(PDataStr,1,2);
  end
  else
  begin
    // formato yyyy-mm-dd
    Anno:=Copy(PDataStr,1,4);
    Mese:=Copy(PDataStr,6,2);
    Giorno:=Copy(PDataStr,9,2);
  end;
  try
    RData:=EncodeDate(StrToInt(Anno),
                      StrToInt(Mese),
                      StrToInt(Giorno));
    Result:=True;
  except
    on E: EConvertError do
    begin
      RData:=0;
      Result:=False;
    end;
  end;
end;

function ConvertiDateStr(const PData: TDateTime): String;
// converte la data indicata nella rappresentazione string
// con formato standard
begin
  Result:=FormatDateTime(FIRLAB_DATE_FMT,PData);
end;

function ConvertiStrDateTime(const PDataStr: String; var RData: TDateTime): Boolean;
// converte la data/ora indicata in formato stringa nel formato TDateTime
// formato riconosciuti:
//   yyyy-mm-dd hhhh:nn
//   dd-mm-yyyy hhhh:nn
var
  DOra: TDateTime;
  Ore,Minuti: String;
begin
  Result:=False;
  RData:=0;

  if Trim(PDataStr) = '' then
  begin
    Result:=True;
    Exit;
  end;

  if not ConvertiStrDate(Copy(PDataStr,1,10),RData) then
    Exit;

  // parte relativa all'ora
  if Length(PDataStr) > 10 then
  begin
    Ore:=Copy(PDataStr,12,2);
    Minuti:=Copy(PDataStr,15,2);

    try
      DOra:=EncodeTime(StrToInt(Ore),
                       StrToInt(Minuti),
                       0,0);
    except
      on E: EConvertError do
      begin
        RData:=0;
        Exit;
      end;
    end;
    RData:=RData + DOra;
  end;
  Result:=True;
end;

function ConvertiDateTimeStr(const PData: TDateTime): String;
// converte la data/ora indicata nella rappresentazione string
// con formato standard
begin
  Result:=FormatDateTime(FIRLAB_DATETIME_FMT,PData);
end;

function CreateFormatSettingsMonzaHSGerardo: TFormatSettings;
// crea un oggetto TFormatSettings con le impostazioni per MONZA_HSGERARDO
// IMPORTANTE
//   la distruzione dell'oggetto non è necessaria
begin
  Result:=TFormatSettings.Create;

  // DateToStr usa DateSeparator e ShortDateFormat
  Result.DateSeparator:=MONZA_HSGERARDO_DATE_SEPARATOR;
  Result.ShortDateFormat:=MONZA_HSGERARDO_SHORT_DATE_FMT;

  // DateTimeToStr usa TimeSeparator e LongTimeFormat
  // (sì, non ho bevuto, date usa shortdateformat e questo usa longtimeformat)
  // cfr. http://www.delphibasics.co.uk/RTL.asp?Name=DateTimeToStr
  Result.TimeSeparator:='.';
  Result.LongTimeFormat:='hh.mm';
end;

function CreaToken(const PUnixTime: Int64; const PParTokenPassphrase: String): String;
// crea il token di accesso ai servizi cifrato con l'algoritmo SHA-1
var
  LTokenData: String;
begin
  // il token contiene il timestamp e una passphrase
  LTokenData:=Format('%d%s',[PUnixTime, PParTokenPassphrase]);

  // cifra il token con l'algoritmo SHA-1
  Result:=R180Sha1Encrypt(LTokenData);
end;

function GetAziendaEffettiva(const PAzienda: String): String;
begin
  Result:=PAzienda;
  if Result = AZIENDA_DEFAULT then
    Result:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B021','AZIENDA','');
end;

function GetDatabaseEffettivo(const PDatabase: String): String;
begin
  Result:=PDatabase;
  if Result = DATABASE_DEFAULT then
    Result:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B021','DATABASE','')
end;

function GetDatiConnessione(const PDatabase, PAzienda, PUtenteI070: String): TDatiConnessione;
begin
  Result.Database:=PDatabase;
  Result.Azienda:=PAzienda;
  Result.UtenteI070:=PUtenteI070;
end;

function GetDatiConnessioneEffettivi(const PDatabase, PAzienda, PUtenteI070: String): TDatiConnessione;
// restituisce il record con i parametri effettivi di connessione
begin
  Result:=GetDatiConnessione(GetDatabaseEffettivo(PDatabase),
                             GetAziendaEffettiva(PAzienda),
                             GetUtenteI070Effettivo(PUtenteI070));
end;

function GetHashAutenticazioneAostaAsl(const PUnixTime: Int64): String;
// restituisce una chiave sha1 basata sull'ora indicata e su una password condivisa
begin
  Result:=R180Sha1Encrypt(Format('%d%s',[PUnixTime,AOSTA_ASL_SHARED_PWD]));
end;

function GetUnixTimeCorrente: Int64;
// restituisce data/ora attuale in formato unix
var
  OraAttuale:TDateTime;
  UTC:TSystemTime;
begin
  GetSystemTime(UTC);
  OraAttuale:=SystemTimeToDateTime(UTC);
  Result:=DateTimeToUnix(OraAttuale);
end;

function GetUtenteI070Effettivo(const PUtenteI070: String): String;
begin
  Result:=PUtenteI070;
  if Result = UTENTE_I070_DEFAULT then
    Result:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B021','UTENTE','')
end;

function IsTimeOkAostaAsl(const PUnixTime: Int64): Boolean;
// restituisce True se fra l'ora corrente e l'ora indicata sono passati
// al max AOSTA_ASL_VALIDITA_TOKEN secondi
var
  LDiff: Integer;
begin
  // differenza in secondi
  LDiff:=GetUnixTimeCorrente - PUnixTime;

  // verifica differenza
  Result:=R180Between(LDiff,0,AOSTA_ASL_VALIDITA_TOKEN);
end;

function PulisciStringaJson(const strJson: String): String;
// rimuove i caratteri spazio, tab, cr, lf dalla stringa in formato json
// workaround per bug riconoscimento json (delphi 2010)
var
  P: PChar;
  InTag: Boolean;
begin
  P:=PChar(strJson);
  Result:='';
  if Trim(strJson) = '' then
    exit;

  // rimozione dei tag
  InTag:=False;
  repeat
    case P^ of
      '"': begin
             InTag:=not InTag;
             Result:=Result + P^;
           end;
      SPAZIO, TAB, CR, LF:
           if InTag then
             Result:=Result + P^; // nessuna operazione
      else
        //if not InTag then
        //begin
        //  if (P^ in [#9, #32]) and
        //     ((P + 1)^ in [#10, #13, #32, #9, '"']) then
        //  else
            Result:=Result + P^;
        //end;
    end;
    Inc(P);
  until (P^ = #0);
end;

function GetQuerystringParams(const PQueryString: String): TDictionary<String,String>;
// data una querystring (che può iniziare con il carattere ? o meno)
// estrae un TDictionary contenente le coppie (parametro,valore)
var
  S, ParCoppia: String;
  KeyValueArr: TArray<String>;
const
  PAR_SEPARATOR       = '&';
  PAR_VALUE_SEPARATOR = '=';
begin
  Result:=TDictionary<String,String>.Create;

  // trim degli eventuali spazi
  S:=PQueryString.Trim;

  // elimina eventuale punto interrogativo iniziale in modo da ottenere 
  // solo l'elenco di coppie parametro / valore
  if S.StartsWith('?') then
    S:=S.Substring(1);

  // inoltre vengono riportate le coppie dei parametri in input
  for ParCoppia in S.Split([PAR_SEPARATOR]) do
  begin
    KeyValueArr:=ParCoppia.Split([PAR_VALUE_SEPARATOR]);
    Result.Add(KeyValueArr[0],KeyValueArr[1]);
  end;
end;

function GetLogFmt(const PClassName, PProcName, PLogInfo: String): String;
// formatta le informazioni per il log
begin
  Result:=Format('%s [%s.%s] %s',[FormatDateTime('dd/mm/yyyy hh.mm.ss',Now),PClassName,PProcName,PLogInfo]);
end;

function VerificaToken(const PToken: String; const PUnixTime: Int64; const PParTokenPassphrase: String; const PParTokenTimeout: Integer): TResCtrl;
var
  LTimestampCorr: Int64;
  LDiff: Int64;
  LTokenCfr: string;
begin
  Result.Clear;

  // controllo parametri in ingresso
  if PToken = '' then
  begin
    Result.Messaggio:='Accesso al metodo non consentito: il token di autenticazione non è stato fornito';
    Exit;
  end;

  if PUnixTime = 0 then
  begin
    Result.Messaggio:='Accesso al metodo non consentito: il timestamp per l''autenticazione non è stato fornito';
    Exit;
  end;

  // salva il timestamp corrente
  LTimeStampCorr:=GetUnixTimeCorrente;

  // ricostruisce il token con i parametri ricevuti
  LTokenCfr:=CreaToken(PUnixTime,PParTokenPassphrase);

  // confronta il token ricevuto con quello ricostruito
  if PToken.ToUpper <> LTokenCfr.ToUpper then
  begin
    Result.Messaggio:='Accesso al metodo non consentito: il token fornito non è valido';
    Exit;
  end;

  // verifica la scadenza del token

  // differenza in secondi fra il timestamp della richiesta e quello corrente
  LDiff:=LTimeStampCorr - PUnixTime;

  // verifica differenza
  Result.Ok:=Abs(LDiff) <= PParTokenTimeout;
  if not Result.Ok then
  begin
    Result.Messaggio:='Accesso al metodo non consentito: ' +
                      IfThen(LDiff < 0,
                             'il timestamp della richiesta è incongruente',
                             'il token fornito è scaduto');
    Exit;
  end;

  // tutto ok
  Result.Ok:=True;
end;

end.
