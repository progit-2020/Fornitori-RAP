unit B021UIrisRestSvcDM;

interface

uses
  SysUtils, Classes, DSServer, WinApi.Windows,
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} DBXPlatform, Oracle, OracleData,
  C200UWebServicesTypes, B021UUtils,
  A000Versione, A000UCostanti, A000USessione,
  C180FunzioniGenerali, DB, Generics.Collections, Datasnap.DSSession;

type

  TInfoLog = class
  public
    SIW: TSessioneIrisWIN;
    ClassNameServizio: String;
    Operazione: String;
    Parametri: TDictionary<String,String>;
    constructor Create;
    destructor Destroy; override;
    function LogAccesso: Boolean;
  end;

{$METHODINFO ON}
  TB021FIrisRestSvcDM = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    FConnDB: Boolean;
    function  Connessione(PParDatabase,PParAzienda,PParUtenteI070:String):TSessioneIrisWIN;
    procedure Log(const PNomeProc, PLogInfo: String); overload; inline;
    procedure Log(const PLogInfo: String); overload; inline;
  public
    LogAttivo: Boolean;

    // ####################   M E T O D I   D I   T E S T   ####################

    function EchoString(PParValue: String): String;
    function updateEchoString(PParId: String; PParJsonObj: TJSONObject): String;

    // ###################################################################### //
    // #################   M E T O D I   U F F I C I A L I  ################# //
    // #################                                    ################# //
    // #################        C O M O _ H S A N N A       ################# //
    // ###################################################################### //

    // elenco dati anagrafici matricole indicate
    function Anagrafiche(PParDatabase,PParAzienda,PParUtenteI070,PParMatricole:String): TJSONObject;

    // dizionario generico
    function Dizionario(PParDatabase,PParAzienda,PParUtenteI070,PParStruttura,PParParametri:String): TJSONObject;

    // elenco codice / descrizione assenze fruibili da matricola indicata
    function DizionarioAssenze(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola:String): TJSONObject;

    // dizionario orari per matricola / reparto
    function DizionarioOrari(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola,PParReparto: String): TJSONObject;

    // elenco giustificativi periodo per matricola indicata
    function Giustificativi(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola,PParInizio,PParFine:String): TJSONObject;
    function acceptGiustificativi(PParDatabase,PParAzienda,PParUtenteI070: String; PParGiust: TJSONObject): TJSONObject;
    function updateGiustificativi(PParDatabase,PParAzienda,PParUtenteI070: String; PParGiust: TJSONObject): TJSONObject;
    function cancelGiustificativi(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola,PParCausale,PParInizio,PParFine:String): TJSONObject;

    // conteggi giornalieri per matricola indicata
    function R502Conteggi(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola,PParData:String): TJSONObject;

    // COMO_HSANNA - commessa 2013/012 SVILUPPO#6.ini
    // dati sulle timbrature conteggiate per matricole indicate
    function R502TimbratureConteggiate(PParDatabase,PParAzienda,PParUtenteI070,PParMatricole,PParInizio,PParFine:String): TJSONObject;
    // COMO_HSANNA - commessa 2013/012 SVILUPPO#6.fine

    // dati riepilogativi per causale di assenza indicata
    function R600GetAssenze(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola,PParData,PParCausale:String;PParDataNasFam: String = ''): TJSONObject;

    // COMO_HSANNA - commessa 2013/012 SVILUPPO#6.ini
    // elenco timbrature nel periodo per matricole indicate
    function Timbrature(PParDatabase,PParAzienda,PParUtenteI070,PParMatricole,PParInizio,PParFine:String): TJSONObject;
    // COMO_HSANNA - commessa 2013/012 SVILUPPO#6.fine

    // turni pianificati
    // Tipo: T080=Modelli orario, T380=Reperibilità
    function Turni(PParDatabase,PParAzienda,PParUtenteI070,PParTipo,PParInizio,PParFine:String): TJSONObject;
    function acceptTurni(PParDatabase,PParAzienda,PParUtenteI070,PParTipo: String; PParTurni: TJSONObject): TJSONObject;
    function updateTurni(PParDatabase,PParAzienda,PParUtenteI070,PParTipo: String; PParTurni: TJSONObject): TJSONObject;
    function cancelTurni(PParDatabase,PParAzienda,PParUtenteI070,PParTipo,PParMatricola,PParInizio,PParFine:String): TJSONObject;

    function R600ControlliGenerali(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola,PParCausale,PParData,PParDalle,PParAlle: String): TJSONObject;

    // ###################################################################### //
    // #################   M E T O D I   U F F I C I A L I  ################# //
    // #################                                    ################# //
    // #################          A O S T A _ A S L         ################# //
    // ###################################################################### //

    // AOSTA_ASL - commessa 2015/257 SVILUPPO#1.ini
    // anagrafiche FSE
    function AnaOpeFSE(PParDatabase,PParAzienda,PParUtenteI070,PParTipo,PParDataInizio,PParDataFine:String): TJSONObject;
    // AOSTA_ASL - commessa 2015/257 SVILUPPO#1.ini


    // ###################################################################### //
    // #################   M E T O D I   U F F I C I A L I  ################# //
    // #################                                    ################# //
    // #################    M O N Z A _ H S G E R A R D O   ################# //
    // ###################################################################### //

    // MONZA_HSGERARDO - commessa 2015/233 SVILUPPO#1.ini
    // anagrafiche
    function Mancop_PersGG(PParDatabase,PParAzienda,PParUtenteI070,PParData,PParUtente,PParPassword:String): TJSONObject;
    function Mancop_PersMM(PParDatabase,PParAzienda,PParUtenteI070,PParMese,PParUtente,PParPassword:String): TJSONObject;
    // MONZA_HSGERARDO - commessa 2015/233 SVILUPPO#1.ini

    //Gestione documentale su file system
    function C021DocumentoBlob(PParDatabase, PParAzienda, PParUtenteI070, PPath, PFileName: String): TJSONObject;
    function C021DocumentoBlobTicket(PParDatabase, PParAzienda, PParUtenteI070, PId: String): TJSONObject;
    function AcceptC021DocumentoBlob(PParDatabase, PParAzienda, PParUtenteI070: String; PParDocumento: TJSONObject): TJSONObject;
    function CancelC021DocumentoBlob(PParDatabase, PParAzienda, PParUtenteI070, PPath, PFileName: String): TJSONObject;
  end;
{$METHODINFO OFF}

implementation

{$R *.dfm}

uses A001UPasswordDtM1,
     RegistrazioneLog,
     B021UAnagraficoDM,
     B021UAssenzeDM,
     B021UConteggiDM,
     B021UControlliGeneraliDM,
     B021UDizionarioDM,
     B021UDizionarioAssenzeDM,
     B021UDizionarioOrariDM,
     B021UGiustificativiDM,
     B021UTimbratureDM,
     B021UTimbratureConteggiateDM,
     B021UTurniDM,
     B021UAnaOpeFSEDM,
     B021UMancopPersGGDM,
     B021UMancopPersMMDM,
     B021UC021DOcumentoBlobDM,
     B021UC021DocumentoBlobTicketDM;

procedure TB021FIrisRestSvcDM.DataModuleCreate(Sender: TObject);
const
  NOME_PROC = 'DataModuleCreate';
begin
  LogAttivo:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B021','FILE_LOG','N') = 'S';

  Log(StringOfChar('-',80));
  Log(NOME_PROC,Format('creazione datamodule',[]));
  SessionPool.PoolType:=ptDefault;
  FConnDB:=True;
end;

procedure TB021FIrisRestSvcDM.Log(const PNomeProc: String; const PLogInfo: String);
// se LogAttivo traccia sul file di log definito in B021UUtils l'operazione indicata
begin
  if LogAttivo then
    Log(GetLogFmt(Self.ClassName,PNomeProc,PLogInfo));
end;

procedure TB021FIrisRestSvcDM.Log(const PLogInfo: String);
// se LogAttivo traccia sul file di log definito in B021UUtils le informazioni indicate
begin
  if LogAttivo then
    R180ScriviMsgLog(FILE_LOG,PLogInfo);
end;

function TB021FIrisRestSvcDM.Connessione(PParDatabase,PParAzienda,PParUtenteI070:String):TSessioneIrisWIN;
// restituisce oggetto SessioneIrisWin oppure nil in caso di errore
// intercettare tutte le eccezioni in questo metodo
var
  A001DtM:TA001FPasswordDtM1;
  LCurrentDSSession: TDSSession;
const
  NOME_PROC = 'Connessione';
begin
  Result:=nil;
  Log(NOME_PROC,Format('parametri di connessione',[]));

  // controllo parametri
  // database
  if PParDatabase = DATABASE_DEFAULT then
  begin
    PParDatabase:=GetDatabaseEffettivo(PParDatabase);
    Log(NOME_PROC,Format('  database = [%s] -> [%s] (da registro)',[DATABASE_DEFAULT,PParDatabase]));
  end
  else
  begin
    Log(NOME_PROC,Format('  database = [%s]',[PParDatabase]));
  end;
  // azienda
  if PParAzienda = AZIENDA_DEFAULT then
  begin
    PParAzienda:=GetAziendaEffettiva(PParAzienda);
    Log(NOME_PROC,Format('  azienda  = [%s] -> [%s] (da registro)',[AZIENDA_DEFAULT,PParAzienda]));
  end
  else
  begin
    Log(NOME_PROC,Format('  azienda  = [%s]',[PParAzienda]));
  end;
  // utente I070
  if PParUtenteI070 = UTENTE_I070_DEFAULT then
  begin
    PParUtenteI070:=GetUtenteI070Effettivo(PParUtenteI070);
    Log(NOME_PROC,Format('  utente   = [%s] -> [%s] (da registro)',[UTENTE_I070_DEFAULT,PParUtenteI070]));
  end
  else
  begin
    Log(NOME_PROC,Format('  utente   = [%s]',[PParUtenteI070]));
  end;

  // se mancano i parametri per l'accesso esce restituendo nil
  if FConnDB and ((PParDatabase = '') or (PParAzienda = '') or (PParUtenteI070 = '')) then
  begin
    Log(NOME_PROC,Format('connessione impossibile: mancano uno o più parametri (azienda, utente)',[]));
    Exit;
  end;
  if FConnDB then
    Log(NOME_PROC,Format('connessione al database %s: %s@%s in corso...',[PParDatabase,PParUtenteI070,PParAzienda]));

  // creazione sessione IrisWin
  Result:=TSessioneIrisWIN.Create(nil);

  // l'oggetto sessione iriswin viene immediatamente associato alla sessione datasnap
  // questo viene utilizzato nella function globale A000SessioneIrisWIN definita in A000UInterfaccia
  LCurrentDSSession:=TDSSessionManager.GetThreadSession;
  LCurrentDSSession.PutObject(DS_OBJECT_SESSIONE_IRISWIN,Result);

  Result.SessioneOracle.Preferences.UseOCI7:=False;
  Result.SessioneOracle.ThreadSafe:=False;
  Result.SessioneOracle.StatementCache:=True;
  Result.SessioneOracle.StatementCacheSize:=20;
  Result.SessioneOracle.Pooling:=spInternal;
  Result.Parametri.VersionePJ:=VersionePA;

  Result.Parametri.Database:=PParDatabase;
  Result.Parametri.Azienda:=PParAzienda;
  Result.Parametri.Operatore:=PParUtenteI070;

  Result.Name:='B021';
  if FConnDB then
  begin
    A001DtM:=TA001FPasswordDtM1.Create(Result);
    try
      try
        A001DtM.InizializzazioneSessione(PParDatabase);
        A001DtM.QI090.Close;
        A001DtM.QI090.SetVariable('AZIENDA',PParAzienda);
        A001DtM.QI090.Open;
        if A001DtM.QI090.RecordCount = 0 then
          raise Exception.Create('Azienda inesistente');
        A001DtM.QI070.Close;
        A001DtM.QI070.SetVariable('AZIENDA',PParAzienda);
        A001DtM.QI070.SetVariable('UTENTE',PParUtenteI070);
        A001DtM.QI070.Open;
        if A001DtM.QI070.RecordCount = 0 then
        begin
          PParUtenteI070:='SYSMAN';
          A001DtM.QI070.Close;
          A001DtM.QI070.SetVariable('AZIENDA',PParAzienda);
          A001DtM.QI070.SetVariable('UTENTE',PParUtenteI070);
          A001DtM.QI070.Open;
        end;
        if A001DtM.QI070.RecordCount = 0 then
          raise Exception.Create('Utente inesistente');
        A001DtM.RegistraInibizioni;
        //Controllo allineamento versione db e versione applicativo
        if (Result.Parametri.VersioneDB <> '') and (Result.Parametri.VersionePJ <> Result.Parametri.VersioneDB) then
          ;//raise Exception.Create(Format('La versione del database (%s) non corrisponde alla versione del prodotto (%s).',[Result.Parametri.VersioneDB,Result.Parametri.VersionePJ]));
        //Verifica se il campo ACCESSO_NEGATO è N (significa che l'accesso è valido)
        if A001DtM.QI070.FieldByName('ACCESSO_NEGATO').AsString = 'S' then
          raise Exception.Create('L''accesso all''applicativo è momentaneamente inibito per attività di amministrazione.' + CRLF +
                                 'Riprovare più tardi o contattare l''amministratore dell''applicativo.');
      except
        on E: Exception do
        begin
          Log(NOME_PROC,Format('connessione al database [%s] fallita: %s (%s)',[PParDatabase,E.Message,E.ClassName]));
          Result:=nil;
        end;
      end;
    finally
      A001DtM.SessioneMondoEDP.Logoff;
      FreeAndNil(A001DtM);
    end;
  end;

  if Result = nil then
    Exit;

  //Ricerca e inizializzazione di SessioneOracle
  if FConnDB then
    A000ParamDBOracleMultiThread(Result);
  //IndennitaTurno:=True;
  Log(NOME_PROC,'connessione ok');
end;


// ******************************************************************* //
// **************   M E T O D I   E S P O R T A T I   **************** //
// ******************************************************************* //

function TB021FIrisRestSvcDM.EchoString(PParValue: string): string;
begin
  Result:=PParValue;
end;

function TB021FIrisRestSvcDM.updateEchoString(PParId: String; PParJsonObj: TJSONObject):String;
begin
  if PParId = 'chiave' then
    Result:='ciao padrone'
  else
    Result:=PParJsonObj.Pairs[0].JsonValue.Value;
end;

// anagrafiche como_hsanna
function TB021FIrisRestSvcDM.Anagrafiche(PParDatabase,PParAzienda,PParUtenteI070,PParMatricole:String): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FAnagraficoDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FAnagraficoDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add(B021UAnagraficoDM.PAR_MATRICOLE,PParMatricole);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FAnagraficoDM.Create(LSIW,
                                  GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                  True,
                                  OPER_READ,
                                  LogAttivo);
    try
      DM.SetParam(B021UAnagraficoDM.PAR_MATRICOLE,PParMatricole);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;


// dizionario generico
function TB021FIrisRestSvcDM.Dizionario(PParDatabase,PParAzienda,PParUtenteI070,PParStruttura,PParParametri:String): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FDizionarioDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FDizionarioDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add('struttura',PParStruttura);
    LInfoLog.Parametri.Add('parametri',PParParametri);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FDizionarioDM.Create(LSIW,
                                  GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                  True,
                                  OPER_READ,
                                  LogAttivo);
    try
      DM.SetParam('struttura',PParStruttura);
      DM.SetParam('parametri',PParParametri);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;


// dizionario assenze
function TB021FIrisRestSvcDM.DizionarioAssenze(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola:String): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FDizionarioAssenzeDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FDizionarioAssenzeDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add('matricola',PParMatricola);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FDizionarioAssenzeDM.Create(LSIW,
                                         GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                         True,
                                         OPER_READ,
                                         LogAttivo);
    try
      DM.SetParam('matricola',PParMatricola);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;


// dizionario orari
function TB021FIrisRestSvcDM.DizionarioOrari(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola,PParReparto: String): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FDizionarioOrariDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FDizionarioOrariDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add('matricola',PParMatricola);
    LInfoLog.Parametri.Add('reparto',PParReparto);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FDizionarioOrariDM.Create(LSIW,
                                       GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                       True,
                                       OPER_READ,
                                       LogAttivo);
    try
      DM.SetParam('matricola',PParMatricola);
      DM.SetParam('reparto',PParReparto);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

// giustificativi
function TB021FIrisRestSvcDM.Giustificativi(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola,PParInizio,PParFine:String): TJSONObject;
// estrae i giustificativi per la matricola indicata nel periodo specificato
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FGiustificativiDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FGiustificativiDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add('matricola',PParMatricola);
    LInfoLog.Parametri.Add('inizio',PParInizio);
    LInfoLog.Parametri.Add('fine',PParFine);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FGiustificativiDM.Create(LSIW,
                                      GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                      True,
                                      OPER_READ,
                                      LogAttivo);
    try
      DM.SetParam('matricola',PParMatricola);
      DM.SetParam('inizio',PParInizio);
      DM.SetParam('fine',PParFine);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

function TB021FIrisRestSvcDM.updateGiustificativi(PParDatabase,PParAzienda,PParUtenteI070: String; PParGiust: TJSONObject): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FGiustificativiDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FGiustificativiDM.ClassName;
    LInfoLog.Operazione:=OPER_UPDATE;
    LInfoLog.Parametri.Add('JObject',PParGiust.ToString);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FGiustificativiDM.Create(LSIW,
                                      GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                      True,
                                      OPER_UPDATE,
                                      LogAttivo);
    try
      DM.JObject:=PParGiust;
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

function TB021FIrisRestSvcDM.cancelGiustificativi(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola,PParCausale,PParInizio,PParFine:String): TJSONObject;
// cancellazione giustificativi
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FGiustificativiDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FGiustificativiDM.ClassName;
    LInfoLog.Operazione:=OPER_DELETE;
    LInfoLog.Parametri.Add('matricola',PParMatricola);
    LInfoLog.Parametri.Add('inizio',PParInizio);
    LInfoLog.Parametri.Add('fine',PParFine);
    LInfoLog.Parametri.Add('causale',PParCausale);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FGiustificativiDM.Create(LSIW,
                                      GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                      True,
                                      OPER_DELETE,
                                      LogAttivo);
    try
      DM.SetParam('matricola',PParMatricola);
      DM.SetParam('inizio',PParInizio);
      DM.SetParam('fine',PParFine);
      DM.SetParam('causale',PParCausale);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

function TB021FIrisRestSvcDM.acceptGiustificativi(PParDatabase,PParAzienda,PParUtenteI070: String; PParGiust: TJSONObject): TJSONObject;
// inserimento giustificativi
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FGiustificativiDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FGiustificativiDM.ClassName;
    LInfoLog.Operazione:=OPER_CREATE;
    LInfoLog.Parametri.Add('JObject',PParGiust.ToString);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FGiustificativiDM.Create(LSIW,
                                      GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                      True,
                                      OPER_CREATE,
                                      LogAttivo);
    try
      DM.JObject:=PParGiust;
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;


// conteggi
function TB021FIrisRestSvcDM.R502Conteggi(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola,PParData:String): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FConteggiDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FConteggiDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add('matricola',PParMatricola);
    LInfoLog.Parametri.Add('data',PParData);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FConteggiDM.Create(LSIW,
                                GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                True,
                                OPER_READ,
                                LogAttivo);
    try
      DM.SetParam('matricola',PParMatricola);
      DM.SetParam('data',PParData);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;


// COMO_HSANNA - commessa 2013/012 SVILUPPO#6.ini
function TB021FIrisRestSvcDM.R502TimbratureConteggiate(PParDatabase, PParAzienda, PParUtenteI070, PParMatricole, PParInizio, PParFine: String): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FTimbratureConteggiateDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FTimbratureConteggiateDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add('matricola',PParMatricole);
    LInfoLog.Parametri.Add('inizio',PParInizio);
    LInfoLog.Parametri.Add('fine',PParFine);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FTimbratureConteggiateDM.Create(LSIW,
                                             GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                             True,
                                             OPER_READ,
                                             LogAttivo);
    try
      DM.SetParam('matricola',PParMatricole);
      DM.SetParam('inizio',PParInizio);
      DM.SetParam('fine',PParFine);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;
// COMO_HSANNA - commessa 2013/012 SVILUPPO#6.fine

// assenze
function TB021FIrisRestSvcDM.R600ControlliGenerali(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola,PParCausale,PParData,PParDalle,PParAlle: String): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FControlliGeneraliDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FControlliGeneraliDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add('matricola',PParMatricola);
    LInfoLog.Parametri.Add('data',PParData);
    LInfoLog.Parametri.Add('causale',PParCausale);
    LInfoLog.Parametri.Add('dalle',PParDalle);
    LInfoLog.Parametri.Add('alle',PParAlle);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FControlliGeneraliDM.Create(LSIW,
                                         GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                         True,
                                         OPER_READ,
                                         LogAttivo);
    try
      DM.SetParam('matricola',PParMatricola);
      DM.SetParam('data',PParData);
      DM.SetParam('causale',PParCausale);
      DM.SetParam('dalle',PParDalle);
      DM.SetParam('alle',PParAlle);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

function TB021FIrisRestSvcDM.R600GetAssenze(PParDatabase,PParAzienda,PParUtenteI070,PParMatricola,PParData,PParCausale:String;PParDataNasFam: String = ''): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FAssenzeDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FAssenzeDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add('matricola',PParMatricola);
    LInfoLog.Parametri.Add('data',PParData);
    LInfoLog.Parametri.Add('causale',PParCausale);
    LInfoLog.Parametri.Add('dataFamiliare',PParDataNasFam);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FAssenzeDM.Create(LSIW,
                               GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                               True,
                               OPER_READ,
                               LogAttivo);
    try
      DM.SetParam('matricola',PParMatricola);
      DM.SetParam('data',PParData);
      DM.SetParam('causale',PParCausale);
      DM.SetParam('dataFamiliare',PParDataNasFam);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;


// COMO_HSANNA - commessa 2013/012 SVILUPPO#6.ini
function TB021FIrisRestSvcDM.Timbrature(PParDatabase, PParAzienda, PParUtenteI070, PParMatricole, PParInizio,
  PParFine: String): TJSONObject;
// estrae l'elenco di timbrature per la matricola specificata (* = tutti i turnisti) nel periodo indicato
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FTimbratureDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FTimbratureDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add('matricola',PParMatricole);
    LInfoLog.Parametri.Add('inizio',PParInizio);
    LInfoLog.Parametri.Add('fine',PParFine);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FTimbratureDM.Create(LSIW,
                                  GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                  True,
                                  OPER_READ,
                                  LogAttivo);
    try
      DM.SetParam('matricola',PParMatricole);
      DM.SetParam('inizio',PParInizio);
      DM.SetParam('fine',PParFine);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;


// turni
function TB021FIrisRestSvcDM.Turni(PParDatabase,PParAzienda,PParUtenteI070,PParTipo,PParInizio,PParFine:String): TJSONObject;
// Turni pianif. - read
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FTurniDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FTurniDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add('tipo_turni',PParTipo);
    LInfoLog.Parametri.Add('inizio',PParInizio);
    LInfoLog.Parametri.Add('fine',PParFine);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FTurniDM.Create(LSIW,
                             GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                             True,
                             OPER_READ,
                             LogAttivo);
    try
      DM.TipoTurni:=PParTipo;
      DM.SetParam('inizio',PParInizio);
      DM.SetParam('fine',PParFine);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

function TB021FIrisRestSvcDM.acceptTurni(PParDatabase,PParAzienda,PParUtenteI070,PParTipo: String; PParTurni: TJSONObject): TJSONObject;
// turni - create
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FTurniDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FTurniDM.ClassName;
    LInfoLog.Operazione:=OPER_CREATE;
    LInfoLog.Parametri.Add('tipo_turni',PParTipo);
    LInfoLog.Parametri.Add('JObject',PParTurni.ToString);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FTurniDM.Create(LSIW,
                             GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                             True,
                             OPER_CREATE,
                             LogAttivo);
    try
      DM.TipoTurni:=PParTipo;
      DM.JObject:=PParTurni;
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

function TB021FIrisRestSvcDM.updateTurni(PParDatabase,PParAzienda,PParUtenteI070,PParTipo: String; PParTurni: TJSONObject): TJSONObject;
// turni - update
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FTurniDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FTurniDM.ClassName;
    LInfoLog.Operazione:=OPER_UPDATE;
    LInfoLog.Parametri.Add('tipo_turni',PParTipo);
    LInfoLog.Parametri.Add('JObject',PParTurni.ToString);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FTurniDM.Create(LSIW,
                             GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                             True,
                             OPER_UPDATE,
                             LogAttivo);
    try
      DM.TipoTurni:=PParTipo;
      DM.JObject:=PParTurni;
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

function TB021FIrisRestSvcDM.cancelTurni(PParDatabase,PParAzienda,PParUtenteI070,PParTipo,PParMatricola,PParInizio,PParFine:String): TJSONObject;
// turni - delete
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FTurniDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FTurniDM.ClassName;
    LInfoLog.Operazione:=OPER_DELETE;
    LInfoLog.Parametri.Add('tipo_turni',PParTipo);
    LInfoLog.Parametri.Add('matricola',PParMatricola);
    LInfoLog.Parametri.Add('inizio',PParInizio);
    LInfoLog.Parametri.Add('fine',PParFine);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FTurniDM.Create(LSIW,
                             GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                             True,
                             OPER_DELETE,
                             LogAttivo);
    try
      DM.TipoTurni:=PParTipo;
      DM.SetParam('matricola',PParMatricola);
      DM.SetParam('inizio',PParInizio);
      DM.SetParam('fine',PParFine);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;


// ########################################################################## //
// #########################   A O S T A _ A S L   ########################## //
// ########################################################################## //

function TB021FIrisRestSvcDM.AnaOpeFSE(PParDatabase,PParAzienda,PParUtenteI070,PParTipo,PParDataInizio,PParDataFine:String): TJSONObject;
// anagrafiche per FSE (Fascicolo Sanitario Elettronico) Aosta_Asl
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FAnaOpeFSEDM;
  i: Integer;
  MetaData: TDSInvocationMetadata;
  LParam, LParAuth, LParTime: String;
  LParKeyValue: TArray<String>;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // gestione parametri querystring
  // cfr. http://stackoverflow.com/questions/10562454/delphi-xe2-how-to-define-custom-datasnap-rest-uri
  LParAuth:='';
  MetaData:=GetInvocationMetadata;
  for i:=0 to MetaData.QueryParams.Count - 1 do
  begin
    LParam:=MetaData.QueryParams[i];
    LParKeyValue:=LParam.Split(['='],2,None);
    if LParKeyValue[0] = B021UAnaOpeFSEDM.PAR_AUTH then
    begin
      LParAuth:=LParKeyValue[1];
    end
    else if LParKeyValue[0] = B021UAnaOpeFSEDM.PAR_TIME then
    begin
      LParTime:=LParKeyValue[1];
    end;
  end;

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FAnaOpeFSEDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add(B021UAnaOpeFSEDM.PAR_AUTH,LParAuth);
    LInfoLog.Parametri.Add(B021UAnaOpeFSEDM.PAR_TIME,LParTime);
    LInfoLog.Parametri.Add(B021UAnaOpeFSEDM.PAR_TIPO,PParTipo);
    LInfoLog.Parametri.Add(B021UAnaOpeFSEDM.PAR_DATA_INIZIO,PParDataInizio);
    LInfoLog.Parametri.Add(B021UAnaOpeFSEDM.PAR_DATA_FINE,PParDataFine);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FAnaOpeFSEDM.Create(LSIW,
                                 GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                 False, // usa autenticazione specifica
                                 OPER_READ,
                                 LogAttivo);
    try
      DM.SetParam(B021UAnaOpeFSEDM.PAR_AUTH,LParAuth);
      DM.SetParam(B021UAnaOpeFSEDM.PAR_TIME,LParTime);
      DM.SetParam(B021UAnaOpeFSEDM.PAR_TIPO,PParTipo);
      DM.SetParam(B021UAnaOpeFSEDM.PAR_DATA_INIZIO,PParDataInizio);
      DM.SetParam(B021UAnaOpeFSEDM.PAR_DATA_FINE,PParDataFine);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

// ########################################################################## //
// ###################   M O N Z A _ H S G E R A R D O   #################### //
// ########################################################################## //

function TB021FIrisRestSvcDM.Mancop_PersGG(PParDatabase,PParAzienda,PParUtenteI070,PParData,PParUtente,PParPassword:String): TJSONObject;
// informazioni anagrafiche personale
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FMancopPersGGDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FMancopPersGGDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add(B021UMancopPersGGDM.PAR_DATA,PParData);
    LInfoLog.Parametri.Add(B021UMancopPersGGDM.PAR_UTENTE,PParUtente);
    LInfoLog.Parametri.Add(B021UMancopPersGGDM.PAR_PASSWORD,PParPassword);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FMancopPersGGDM.Create(LSIW,
                                    GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                    True,
                                    OPER_READ,
                                    LogAttivo);
    try
      DM.SetParam(B021UMancopPersGGDM.PAR_DATA,PParData);
      DM.SetParam(B021UMancopPersGGDM.PAR_UTENTE,PParUtente);
      DM.SetParam(B021UMancopPersGGDM.PAR_PASSWORD,PParPassword);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if LSIW <> nil then
      FreeAndNil(LSIW);
  end;
end;

function TB021FIrisRestSvcDM.Mancop_PersMM(PParDatabase,PParAzienda,PParUtenteI070,PParMese,PParUtente,PParPassword:String): TJSONObject;
// informazioni anagrafiche personale
var
  LSIW:TSessioneIrisWIN;
  DM: TB021FMancopPersMMDM;
  LInfoLog: TInfoLog;
begin
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);

  // log accesso
  LInfoLog:=TInfoLog.Create;
  try
    LInfoLog.SIW:=LSIW;
    LInfoLog.ClassNameServizio:=TB021FMancopPersGGDM.ClassName;
    LInfoLog.Operazione:=OPER_READ;
    LInfoLog.Parametri.Add(B021UMancopPersMMDM.PAR_MESE,PParMese);
    LInfoLog.Parametri.Add(B021UMancopPersMMDM.PAR_UTENTE,PParUtente);
    LInfoLog.Parametri.Add(B021UMancopPersMMDM.PAR_PASSWORD,PParPassword);
    LInfoLog.LogAccesso;
  finally
    FreeAndNil(LInfoLog);
  end;

  // elaborazione
  try
    DM:=TB021FMancopPersMMDM.Create(LSIW,
                                    GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                    True,
                                    OPER_READ,
                                    LogAttivo);
    try
      DM.SetParam(B021UMancopPersMMDM.PAR_MESE,PParMese);
      DM.SetParam(B021UMancopPersMMDM.PAR_UTENTE,PParUtente);
      DM.SetParam(B021UMancopPersMMDM.PAR_PASSWORD,PParPassword);
      Result:=DM.EseguiOperazione;
      DM.Disconnetti;
    finally
      FreeAndNil(DM);
    end;
  finally
    if LSIW <> nil then
      FreeAndNil(LSIW);
  end;
end;

function TB021FIrisRestSvcDM.C021DocumentoBlob(PParDatabase, PParAzienda, PParUtenteI070, PPath, PFileName: String): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  B021C021DM: TB021FC021DocumentoBlobDM;
  LInfoLog: TInfoLog;
begin
  FConnDB:=False;
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);
  // log accesso
  if FConnDB then
  begin
    LInfoLog:=TInfoLog.Create;
    try
      LInfoLog.SIW:=LSIW;
      LInfoLog.ClassNameServizio:=TB021FConteggiDM.ClassName;
      LInfoLog.Operazione:=OPER_READ;
      LInfoLog.Parametri.Add('Path',PPath);
      LInfoLog.Parametri.Add('FileName',PFileName);
      LInfoLog.LogAccesso;
    finally
      FreeAndNil(LInfoLog);
    end;
  end;
  // elaborazione
  try
    B021C021DM:=TB021FC021DocumentoBlobDM.Create(LSIW,
                                                 GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                                 False,
                                                 OPER_READ,
                                                 LogAttivo);
    try
      B021C021DM.SetParam('Path',PPath);
      B021C021DM.SetParam('FileName',PFileName);
      Result:=B021C021DM.EseguiOperazione;
      B021C021DM.Disconnetti;
    finally
      FreeAndNil(B021C021DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

function TB021FIrisRestSvcDM.C021DocumentoBlobTicket(PParDatabase, PParAzienda, PParUtenteI070, PId: String): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  B021C021DM: TB021FC021DocumentoBlobTicketDM;
  LInfoLog: TInfoLog;
begin
  FConnDB:=True;
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);
  // log accesso
  if FConnDB then
  begin
    LInfoLog:=TInfoLog.Create;
    try
      LInfoLog.SIW:=LSIW;
      LInfoLog.ClassNameServizio:=TB021FConteggiDM.ClassName;
      LInfoLog.Operazione:=OPER_READ;
      LInfoLog.Parametri.Add('Id',PId);
      LInfoLog.LogAccesso;
    finally
      FreeAndNil(LInfoLog);
    end;
  end;
  // elaborazione
  try
    B021C021DM:=TB021FC021DocumentoBlobTicketDM.Create(LSIW,
                                                 GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                                 False,
                                                 OPER_READ,
                                                 LogAttivo);
    try
      B021C021DM.SetParam('Id',PId);
      Result:=B021C021DM.EseguiOperazione;
      B021C021DM.Disconnetti;
    finally
      FreeAndNil(B021C021DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

function TB021FIrisRestSvcDM.AcceptC021DocumentoBlob(PParDatabase, PParAzienda, PParUtenteI070: String; PParDocumento: TJSONObject): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  B021C021DM: TB021FC021DocumentoBlobDM;
  LInfoLog: TInfoLog;
begin
  FConnDB:=False;
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);
  // log accesso
  if FConnDB then
  begin
    LInfoLog:=TInfoLog.Create;
    try
      LInfoLog.SIW:=LSIW;
      LInfoLog.ClassNameServizio:=TB021FConteggiDM.ClassName;
      LInfoLog.Operazione:=OPER_CREATE; // così viene eseguita la procedura AcceptDato
      LInfoLog.Parametri.Add('Json',PParDocumento.ToString);
      LInfoLog.LogAccesso;
    finally
      FreeAndNil(LInfoLog);
    end;
  end;
  // elaborazione
  try
    B021C021DM:=TB021FC021DocumentoBlobDM.Create(LSIW,
                                                 GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                                 False,
                                                 OPER_CREATE,
                                                 LogAttivo); // così viene eseguita la procedura AcceptDato
    try
      B021C021DM.SetParam('Json',PParDocumento.ToString);
      Result:=B021C021DM.EseguiOperazione;
      B021C021DM.Disconnetti;
    finally
      FreeAndNil(B021C021DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

function TB021FIrisRestSvcDM.CancelC021DocumentoBlob(PParDatabase, PParAzienda, PParUtenteI070, PPath, PFileName: String): TJSONObject;
var
  LSIW:TSessioneIrisWIN;
  B021C021DM: TB021FC021DocumentoBlobDM;
  LInfoLog: TInfoLog;
begin
  FConnDB:=False;
  // connessione
  LSIW:=Connessione(PParDatabase,PParAzienda,PParUtenteI070);
  // log accesso
  if FConnDB then
  begin
    LInfoLog:=TInfoLog.Create;
    try
      LInfoLog.SIW:=LSIW;
      LInfoLog.ClassNameServizio:=TB021FConteggiDM.ClassName;
      LInfoLog.Operazione:=OPER_DELETE; // così viene eseguita la procedura CancelDato
      LInfoLog.Parametri.Add('Path',PPath);
      LInfoLog.Parametri.Add('FileName',PFileName);
      LInfoLog.LogAccesso;
    finally
      FreeAndNil(LInfoLog);
    end;
  end;
  // elaborazione
  try
    B021C021DM:=TB021FC021DocumentoBlobDM.Create(LSIW,
                                                 GetDatiConnessioneEffettivi(PParDatabase,PParAzienda,PParUtenteI070),
                                                 False,
                                                 OPER_DELETE,
                                                 LogAttivo); // così viene eseguita la procedura CancelDato
    try
      B021C021DM.SetParam('Path',PPath);
      B021C021DM.SetParam('FileName',PFileName);
      Result:=B021C021DM.EseguiOperazione;
      B021C021DM.Disconnetti;
    finally
      FreeAndNil(B021C021DM);
    end;
  finally
    if Assigned(LSIW) then
      FreeAndNil(LSIW);
  end;
end;

{ TInfoLog }

constructor TInfoLog.Create;
begin
  Parametri:=TDictionary<String,String>.Create;
end;

destructor TInfoLog.Destroy;
begin
  FreeAndNil(Parametri);
  inherited;
end;

function TInfoLog.LogAccesso: Boolean;
// effettua il log di accesso del servizio richiamato su I000 / I001
var
  LRegLog: TRegistraLog;
  LNomeServizio, LNomePar: String;
begin
  Result:=False;
  if SIW <> nil then
  begin
    try
      LRegLog:=(SIW.RegistraLog as TRegistraLog);
      if LRegLog <> nil then
      begin
        LNomeServizio:=ClassNameServizio.Substring(6,ClassNameServizio.Length - 8);

        LRegLog.SettaProprieta('A','','B021',nil,True);
        LRegLog.InserisciDato('NOME_SERVIZIO','',LNomeServizio);
        LRegLog.InserisciDato('OPERAZIONE','',Operazione);
        LRegLog.InserisciDato('OPERATORE','',SIW.Parametri.Operatore);
        for LNomePar in Parametri.Keys do
          LRegLog.InserisciDato(LNomePar.ToUpper,'',Parametri[LNomePar]);
        LRegLog.RegistraOperazione;
        LRegLog.Session.Commit;
        Result:=True;
      end;
    except
      on E: Exception do
        R180ScriviMsgLog(FILE_LOG,GetLogFmt(Self.ClassName,'LogAccesso',Format('errore log I000: %s',[E.Message])));
    end;
  end;
end;

end.
