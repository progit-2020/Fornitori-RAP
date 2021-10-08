unit A000UCostanti;

interface

//uses R500Lin;
uses SysUtils, System.Classes, System.Variants;

type
  TResCtrl = record
    Ok: Boolean;
    Messaggio: String;
    procedure Clear; inline;
  end;

  TMedpCriticalSection = class(TObject)
  private
    dummy : Array[1..96] of Byte;
  public
    procedure Enter;
    procedure Leave;
  end;

  TElencoValoriChecklist = class
  public
    lstCodice: TStringList;
    lstDescrizione: TStringList;
    constructor Create;
    destructor Destroy; override;
  end;

  TDataBaseDrv = (dbInterBase, dbOracle, dbStandard);

  TTabelleDizionario = record
    Tabella, DescTabella:String;
  end;

  TItemsValues = record
    Item:String;
    Value:String;
  end;

  // tipo record per parametri di configurazione
  TParConfig = record
    // parametri di configurazione impostati sul file
    Database: String;              // database da proporre come default in fase di login
    Azienda: String;               // azienda da proporre di default in fase di login
    Profilo: String;               // profilo da proporre di default in fase di login
    TimeoutOper: Integer;          // timeout di sessione web per l'operatore (utente di I070) espresso in minuti
    TimeoutDip: Integer;           // timeout di sessione web per il dipendente (utente di I060) espresso in minuti
    MaxSessioni: Integer;          // numero massimo di sessioni web accettate
    UrlSuperoMaxSessioni: String;  // url per il redirect nel caso di supero max sessioni accettate
    Home: String;                  // url per il redirect dopo il logout dalla sessione web
    UrlLoginErrato: String;        // url per il redirect se il login esterno fallisce
    PathLog: String;               // path della directory in cui salvare il file di log W000.log
    UrlWSAutenticazione: String;   // url per il webservice di autenticazione (utilizzato da ROMA_HSANDREA)
    UrlManutenzione: String;       // url da impostare se il sito � in manutenzione
    UrlIrisWebCloud: String;       // url per richiamare IrisWeb da IrisCloud e viceversa
    IrisWebCloudNewTab: String;    // S = apre nuova pagina quando richiama IrisWeb->IrisCloud o viceversa, N = sostituisce la sessione corrente quando richiama IrisWeb->IrisCloud o viceversa
    LoginEsterno: String;          // S = gestione con login esterno (preautenticazione), N = gestione con login interattivo
    PaginaIniziale: String;        // sigla della pagina da visualizzare automaticamente all'accesso in IrisWEB
    PaginaSingola:String;          // sigla della singola pagina da rendere disponibile, oscurando tutte le altre
    CampiInvisibili: String;       // elenco di campi da non visualizzare separati da virgola ed espressi nella forma [NomeForm.NomeComponente]
    Port: Integer;                 // porta su cui risponde il webserver
    CursoriLogin: Integer;         //
    CursoriSessione: Integer;      //
    MaxOpenCursors: Integer;       //
    MaxWorkingMemMb: Integer;      // se impostato indica il valore max di memoria da utilizzare per il processo espresso in Mb
    LogAbilitati: String;          // elenco dei log abilitati separati da virgola e scelti fra le costanti INI_LOG_*
    LogFile: String;               // file di log per i trace che non riescono ad essere salvati su database
    ParametriAvanzati: String;     // elenco dei parametri avanzati separati da virgola e scelti fra le costanti INI_PAR_*
    // parametri per X001
    TabColPartenza: String;        // ...
    NumLivelli: Integer;           // ...
    // parametri derivati dalle impostazioni di configurazione
    // introdotti per semplicit� di utilizzo
    ReconnectSession: Boolean;     // parametro boolean da utilizzare in CheckConnection
    LogoffDbPool:Boolean;          // parametro boolean per consentire/impedire il logoff delle sessioni inutilizzate
    MaxWorkingMemByte: Cardinal;   // se impostato indica il valore max di memorya da utilizzare per il processo espresso in byte
    ComInitialization: String;     // tipo di com initialization, scelto fra le costanti INI_COM_*
    RaveStreamMode: String;        // tipo di stream mode per rave report, scelto fra le costanti INI_RAVE_STREAM_MODE_*
    // IW Exception Logger
    IWExcLogAbilitato: Boolean;    // true se il log abilitato, false altrimenti.
    IWExcLogPathFile: String;      // path dei file di log, se non specificato IW usa "ErrorLog" nell'application path.
    IWExcLogNomeFile: String;      // prefisso nome file di log, se non specificato sar� usato il nome dell'applicazione.
    IWExcLogGiorniRimoz: Integer;  // et� minima in giorni dei file di log che saranno cancellati allo shutdown del server. 0 = nessuna cancellazione
    IWExcLogEccezIgnorate: String; // elenco delle classi delle eccezioni da ignorare separate da ','.
  end;

  // informazioni utente estratte da active directory
  TActiveDirectoryUserInfo = record
    User: string;
    FullName: string;
    Email: string;
    procedure Clear; inline;
  end;

  TIterAutorizzativi = record
    Cod,Desc:String;
  end;

  TFasiIterAutorizzativi = record
    Cod:String;
    Fase:Integer;
    Desc:String;
  end;

  TDatiEnte = record
    Nome,Gruppo,Lista,Desc:String;
  end;

  TStruttT430 = record
    Campo:String;
    Tabella:String;
    Codice:String;
    Storico:String;
  end;

  TArrString = array of String;
  TCampiT030 = Array [1..12] of String;
  TCampiT480 = Array [1..5] of String;

  TAzioniSitoWeb = record
    Nome: String;
    Comando: String;
    Descrizione: String;
  end;

  //Usata da A023 e A047 e relativi progetti cloud
  TTimbrature = record
    _Progressivo: Integer;
    _Data: TDateTime;
    Ora:Variant;
    Verso,Flag:String[1];
    Rilevatore:String[2];
    Causale:String[5];
    _IDRichiesta: Integer;
    procedure Clear; inline;
  end;

  TAccessiMensa = record
    PranzoCena: String;
    Accessi: Integer;
    Causale: String;
    Rilevatore: String;
  end;

  //Usata da A023 e A047 e relativi progetti cloud
  TGiustificativi = record
    _Progressivo: Integer; //+++
    _Data: TDateTime;
    Causale:String;
    DataNas:TDateTime;
    ProgCaus:Integer;
    Tipo:String;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    CSITipoMG: String;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    DaOre,AOre:TDateTime;
    FlagScheda:Char;
    NuovoPeriodo:Boolean;
    Validata:String;//S:Assenza Validata, N:Assenza da Validare,  :Assenza senza bisogno di validazione
    Note:String;
    _IDRichiesta:integer;
    _IDCertificato: String;
    procedure Clear;
  end;

  //usata da WA023 E WA047
  TGiorniCartellino = record
    Data:TDateTime;
    NonImpostato:Boolean;
    Lavorativo:Boolean;
    Festivo:Boolean;
    Domenica:Boolean;
  end;

  TVociPaghe = record
    CodInt     :String;
    Descrizione:String;
    Ordine     :Word;
    VocePaghe  :String;
    Misura     :String;
  end;
  TVettVociPaghe = array [1..54] of TVociPaghe;
  TAnomScaricoPaghe = array [1..19] of String;

  function A000selDizionarioSicurezzaRiepiloghi:String;

const
  SPAZIO                    = #32;
  NAME_VALUE_SEPARATOR      = #177;
  CR    = #13;
  LF    = #10;
  CRLF  = #13#10;
  TAB   = #9;
  SPACE = #32;
  SPAZI_SET = [#10,#13,#32];     // LF, CR, SPACE
  DATE_NULL: TDateTime = 0;      // 30/12/1899
  DATE_MIN: TDateTime = 2;       // 01/01/1900
  DATE_MAX: TDateTime = 767010;  // 31/12/3999
  SPECIAL_CHAR  = ' !"#$%&''()*+,-./:;<=>?@[\]^_`{|}~';//'!%&/()=@#-_*';
  NEW_SPECIAL_CHAR = ' !"#$%&''()*+,-./:;<=>?@[\]^_`{|}~';
  ORACLE_MAX_IN_VALUES = 1000;
  C700NEO_ASSUNTO = $0055AA00;

  A000PasswordFissa=Chr(84) + Chr(73) + Chr(77) + Chr(79) + Chr(84) + Chr(69) + Chr(79);

  QVistaOracle_Const = 'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #13#10 +
                       'WHERE T030.Progressivo = V430.T430Progressivo AND' + #13#10 +
                       'T030.ComuneNas = T480.Codice(+) AND' + #13#10 +
                       ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine';

  QVistaInServizio = 'AND EXISTS (SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T430PROGRESSIVO AND :DataLavoro BETWEEN T430INIZIO AND NVL(T430FINE,:DataLavoro))';
  QVistaInServizioPeriodica = 'AND EXISTS (SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T430PROGRESSIVO AND :DataLavoro >= T430INIZIO AND :C700DATADAL <= NVL(T430FINE,:DataLavoro))';
  QDipInServizio = ':DataLavoro BETWEEN T430INIZIO AND ADD_MONTHS(LAST_DAY(NVL(T430FINE,TO_DATE(''31123999'',''DDMMYYYY''))),%s)'; //Passare Parametri.ValiditaCessati

  FasceOracle = 'SELECT DISTINCT T210.Codice,T210.Maggiorazione' + #13#10 +
                'FROM T210_Maggiorazioni T210, T201_Maggiorazioni T201' + #13#10 +
                'WHERE (T210.Codice = T201.Maggior1 OR T210.Codice = T201.Maggior2 OR' + #13#10 +
                'T210.Codice = T201.Maggior3 OR T210.Codice = T201.Maggior4) AND' + #13#10 +
                'T201.Codice = :Codice' + #13#10 +
                'ORDER BY T210.Maggiorazione,T210.Codice';

  A000selDizionario = 'SELECT ''CAUSALI ASSENZA'' TABELLA,CODICE FROM T265_CAUASSENZE UNION' + #13#10 +
                      'SELECT ''RAGGRUPPAMENTI ASSENZA'' TABELLA,CODICE FROM T260_RAGGRASSENZE UNION' + #13#10 +
                      'SELECT ''PROFILI ASSENZA'' TABELLA,CODICE FROM T261_DESCPROFASS UNION' + #13#10 +
                      'SELECT ''CAUSALI PRESENZA'' TABELLA,CODICE FROM T275_CAUPRESENZE UNION' + #13#10 +
                      'SELECT ''RAGGRUPPAMENTI PRESENZA'' TABELLA,CODICE FROM T270_RAGGRPRESENZE UNION' + #13#10 +
                      'SELECT ''CAUSALI GIUSTIFICAZIONE'' TABELLA,CODICE FROM T305_CAUGIUSTIF UNION' + #13#10 +
                      'SELECT ''CAUSALI SUL CARTELLINO'' TABELLA,CODICE FROM T265_CAUASSENZE UNION' + #13#10 +
                        'SELECT ''CAUSALI SUL CARTELLINO'' TABELLA,CODICE FROM T275_CAUPRESENZE UNION' + #13#10 +
                        'SELECT ''CAUSALI SUL CARTELLINO'' TABELLA,CODICE FROM T305_CAUGIUSTIF UNION' + #13#10 +
                      'SELECT ''MODELLI ORARIO'' TABELLA,CODICE FROM T020_ORARI UNION' + #13#10 +
                      'SELECT ''PROFILI ORARIO'' TABELLA,CODICE FROM T220_PROFILIORARI UNION' + #13#10 +
                      'SELECT ''CALENDARI'' TABELLA,CODICE FROM T010_CALENDIMPOSTAZ UNION' + #13#10 +
                      'SELECT ''TURNI REPERIBILITA'' TABELLA,CODICE FROM T350_REGREPERIB UNION' + #13#10 +
                      'SELECT ''GENERATORE DI STAMPE'' TABELLA,CODICE FROM T910_RIEPILOGO WHERE CODICE NOT IN (SELECT ID FROM I025_CESTINO WHERE TABELLA = ''T910_RIEPILOGO'') UNION' + #13#10 +
                      'SELECT ''PARAMETRIZZAZIONI CARTELLINO'' TABELLA,CODICE FROM T950_STAMPACARTELLINO UNION' + #13#10 +
                      'SELECT ''TIPOLOGIA TRASFERTA'' TABELLA,CODICE FROM M011_TIPOMISSIONE UNION' + #13#10 +
                      'SELECT DISTINCT ''INTERROGAZIONI DI SERVIZIO'' TABELLA, NOME AS CODICE FROM T002_QUERYPERSONALIZZATE WHERE NOME NOT IN (SELECT ID FROM I025_CESTINO WHERE TABELLA = ''T002_QUERYPERSONALIZZATE'') UNION' + #13#10 +
                      'SELECT DISTINCT ''GRUPPI PESATURE INDIVIDUALI'' TABELLA, CODGRUPPO AS CODICE FROM T773_PESATUREGRUPPO UNION' + #13#10 +
                      'SELECT DISTINCT ''GRUPPI SC.QUANTITATIVE IND.'' TABELLA, CODGRUPPO AS CODICE FROM T767_INCQUANTGRUPPO UNION' + #13#10 +
                      'SELECT DISTINCT ''SELEZIONI ANAGRAFICHE'' TABELLA, NOME AS CODICE FROM T003_SELEZIONIANAGRAFE UNION' + #13#10 +
                      'SELECT ''RIMBORSI MISSIONI'' TABELLA, CODICE FROM M020_TIPIRIMBORSI UNION' + #13#10 +
                      'SELECT ''PROFILI INDENNITA'' TABELLA, CODICE FROM T163_CODICIINDENNITA UNION' + #13#10 +
                      'SELECT ''PROFILI PIANIF. TURNI'' TABELLA, CODICE FROM T082_PAR_PIANIFORARI UNION' + #13#10 +
                      'SELECT ''OROLOGI DI TIMBRATURA'' TABELLA, CODICE FROM T361_OROLOGI UNION' + #13#10 +
                      'SELECT ''PROGETTI RENDICONTABILI'' TABELLA, TO_CHAR(ID) AS CODICE FROM T750_PROGETTI_RENDICONTO';//+ subquery dinamica di A000selDizionarioSicurezzaRiepiloghi

  TabelleDizionario:array[1..26] of TTabelleDizionario = (
    (Tabella:'T265_CAUASSENZE';           DescTabella:'CAUSALI ASSENZA'),
    (Tabella:'T260_RAGGRASSENZE';         DescTabella:'RAGGRUPPAMENTI ASSENZA'),
    (Tabella:'T261_DESCPROFASS';          DescTabella:'PROFILI ASSENZA'),
    (Tabella:'T275_CAUPRESENZE';          DescTabella:'CAUSALI PRESENZA'),
    (Tabella:'T270_RAGGRPRESENZE';        DescTabella:'RAGGRUPPAMENTI PRESENZA'),
    (Tabella:'T305_CAUGIUSTIF';           DescTabella:'CAUSALI GIUSTIFICAZIONE'),
    (Tabella:'-';                         DescTabella:'CAUSALI SUL CARTELLINO'),
    (Tabella:'T020_ORARI';                DescTabella:'MODELLI ORARIO'),
    (Tabella:'T220_PROFILIORARIO';        DescTabella:'PROFILI ORARIO'),
    (Tabella:'T010_CALENDIMPOSTAZ';       DescTabella:'CALENDARI'),
    (Tabella:'T380_PIANIFREPERIB';        DescTabella:'TURNI REPERIBILITA'),
    (Tabella:'T910_RIEPILOGO';            DescTabella:'GENERATORE DI STAMPE'),
    (Tabella:'T950_STAMPACARTELLINO';     DescTabella:'PARAMETRIZZAZIONI CARTELLINO'),
    (Tabella:'M011_TIPOMISSIONE';         DescTabella:'TIPOLOGIA TRASFERTA'),
    (Tabella:'T002_QUERYPERSONALIZZATE';  DescTabella:'INTERROGAZIONI DI SERVIZIO'),
    (Tabella:'T003_SELEZIONIANAGRAFE';    DescTabella:'SELEZIONI ANAGRAFICHE'),
    (Tabella:'T773_PESATUREGRUPPO';       DescTabella:'GRUPPI PESATURE INDIVIDUALI'),
    (Tabella:'P070_MISUREQUANTITA';       DescTabella:'GRUPPI SC.QUANTITATIVE IND.'),
    (Tabella:'T101_ANOMALIE';             DescTabella:'ANOMALIE DEI CONTEGGI'),
    (Tabella:'T101_ANOMALIE';             DescTabella:'ANOMALIE NASCOSTE SU CARTELLINO WEB'),
    (Tabella:'M050_RIMBORSI';             DescTabella:'RIMBORSI MISSIONI'),
    (Tabella:'T163_CODICIINDENNITA';      DescTabella:'PROFILI INDENNITA'),
    (Tabella:'T082_PAR_PIANIFORARI';      DescTabella:'PROFILI PIANIF. TURNI'),
    (Tabella:'T361_OROLOGI';              DescTabella:'OROLOGI DI TIMBRATURA'),
    (Tabella:'T750_PROGETTI_RENDICONTO';  DescTabella:'PROGETTI RENDICONTABILI'),
    (Tabella:'-';                         DescTabella:'SICUREZZA RIEPILOGHI')//subquery dinamica di A000selDizionarioSicurezzaRiepiloghi
    );

  A000T433 = 'select t433.progressivo, decorrenza, decorrenza_fine, t433.codice, t433.percentuale' + #13#10 +
             '  from t433_cdc_percent t433' + #13#10 +
             'union' + #13#10 +
             'select t430.progressivo, greatest(t430.datadecorrenza,t433a.decorrenza_fine + 1) decorrenza, least(t430.datafine,t433b.decorrenza - 1) scadenza, t430.:centro_costo, 100' + #13#10 +
             '  from t430_storico t430, t433_cdc_percent t433a,  t433_cdc_percent t433b' + #13#10 +
             '  where t430.progressivo = t433a.progressivo' + #13#10 +
             '  and t430.datadecorrenza <= t433b.decorrenza - 1 and t430.datafine >=  t433a.decorrenza_fine + 1' + #13#10 +
             '  and t433a.progressivo = t433b.progressivo and t433b.decorrenza =' + #13#10 +
             '    (select  min(decorrenza) from t433_cdc_percent t433c' + #13#10 +
             '     where t433c.progressivo = t433b.progressivo and t433c.decorrenza > t433a.decorrenza)' + #13#10 +
             '  and greatest(t430.datadecorrenza,t433a.decorrenza_fine + 1) <= least(t430.datafine,t433b.decorrenza - 1)' + #13#10 +
             'union' + #13#10 +
             'select t430.progressivo, t430.datadecorrenza,least(t430.datafine,(select  nvl(min(decorrenza - 1),t430.datafine) from t433_cdc_percent t433c where t433c.progressivo = t430.progressivo)),t430.:centro_costo, 100' + #13#10 +
             '  from t430_storico t430' + #13#10 +
             '  where datadecorrenza < (select  nvl(min(decorrenza),t430.datafine + 1) from t433_cdc_percent t433c where t433c.progressivo = t430.progressivo)' + #13#10 +
             'union' + #13#10 +
             'select t430.progressivo, greatest(t430.datadecorrenza,(select  nvl(max(decorrenza_fine + 1),t430.datadecorrenza) from t433_cdc_percent t433c where t433c.progressivo = t430.progressivo)),t430.datafine,t430.:centro_costo, 100' + #13#10 +
             '  from t430_storico t430' + #13#10 +
             '  where datafine > (select  nvl(max(decorrenza_fine),t430.datadecorrenza - 1) from t433_cdc_percent t433c where t433c.progressivo = t430.progressivo)';

  I091CryptKey = 30011945;
  DatiEnte:array [1..152] of TDatiEnte = (
    (Nome:'C6_INIZIOPROVA';                           Gruppo:'Anagrafico';          Lista:'T430';              Desc:'Inizio del periodo di prova'),
    (Nome:'C6_DURATAPROVA';                           Gruppo:'Anagrafico';          Lista:'T430';              Desc:'Durata del periodo di prova'),
    (Nome:'C13_CDC_PERCENT';                          Gruppo:'Anagrafico';          Lista:'T430';              Desc:'Centro di costo percentualizzato'),
    (Nome:'C19_STORIAINIZIOFINE';                     Gruppo:'Anagrafico';          Lista:'SN';                Desc:'Storia dato: considera Inizio-Fine'),
    (Nome:'C0_DECORRENZANONBOLLANTI';                 Gruppo:'Varie';               Lista:'';                  Desc:'Decorrenza non bollanti'),
    (Nome:'C4_BUONIMENSA';                            Gruppo:'Varie';               Lista:'T430';              Desc:'Buoni pasto/Ticket'),
    (Nome:'C9_SCARICOPAGHE';                          Gruppo:'Varie';               Lista:'T430';              Desc:'Scarico paghe: interfaccia'),
    (Nome:'C16_INSRIPOSI';                            Gruppo:'Varie';               Lista:'T430';              Desc:'Inserimento automatico riposi'),
    (Nome:'C17_POSTILETTO';                           Gruppo:'Varie';               Lista:'T430';              Desc:'Posti letto'),
    (Nome:'C18_ACCESSIMENSA';                         Gruppo:'Varie';               Lista:'T430';              Desc:'Accessi mensa'),
    (Nome:'C23_CONTR_COMPETENZE';                     Gruppo:'Varie';               Lista:'SN';                Desc:'Riallineamento causali concatenate'),
    (Nome:'C23_INSNEG_CATENA';                        Gruppo:'Varie';               Lista:'SN';                Desc:'Inserimento negato per causali concatenate'),
    (Nome:'C23_VMH_FRUIZGG';                          Gruppo:'Varie';               Lista:'SN';                Desc:'La Visita medica ad ore considera le fruizioni a gg'),
    (Nome:'C23_VMH_CUMULO_TRIENNIO';                  Gruppo:'Varie';               Lista:'SN';                Desc:'La Visita medica ad ore � cumulata nel triennio'),
    (Nome:'C25_TIMBIRR_AUTO';                         Gruppo:'Varie';               Lista:'SN';                Desc:'Ripristino automatico timbr.irregolari'),
    (Nome:'C29_CHIAMATEREP_FILTRO1';                  Gruppo:'Varie';               Lista:'T430';              Desc:'Reperibilit�: filtro 1'),
    (Nome:'C29_CHIAMATEREP_FILTRO2';                  Gruppo:'Varie';               Lista:'T430';              Desc:'Reperibilit�: filtro 2'),
    (Nome:'C29_CHIAMATEREP_DATIVIS';                  Gruppo:'Varie';               Lista:'T430_MULTI';        Desc:'Reperibilit�: dati da visualizzare nelle info'),
    (Nome:'C29_CHIAMATEREP_DATIMODIF';                Gruppo:'Varie';               Lista:'T430_MULTI';        Desc:'Reperibilit�: dati modificabili dalle chiamate'),
    (Nome:'C31_NOTEGIUSTIFICATIVI';                   Gruppo:'Varie';               Lista:'SN';                Desc:'Note per i giustificativi'),
    (Nome:'C31_GIUSTIF_GGMG';                         Gruppo:'Varie';               Lista:'SN';                Desc:'Intersezione giustif. a giornata e mezza giornata'),
    (Nome:'C32_GESTMENSILE';                          Gruppo:'Varie';               Lista:'SN';                Desc:'Gestione mensile su cart.interattivo'),
    (Nome:'C33_LINK_I070_T030';                       Gruppo:'Varie';               Lista:'NOF';               Desc:'Operatori collegati alle anagrafiche'),
    (Nome:'C2_BUDGET';                                Gruppo:'Budget straord.';     Lista:'T430';              Desc:'B.S.: livello strutturale'),
    (Nome:'C2_CAPITOLO';                              Gruppo:'Budget straord.';     Lista:'T430';              Desc:'Budget esterno - capitolo'),
    (Nome:'C2_ARTICOLO';                              Gruppo:'Budget straord.';     Lista:'T430';              Desc:'Budget esterno - articolo'),
    (Nome:'C2_COSTO_ORARIO';                          Gruppo:'Budget straord.';     Lista:'T430';              Desc:'Budget esterno - costo orario'),
    (Nome:'C2_WEBSRV_BILANCIO';                       Gruppo:'Budget straord.';     Lista:'';                  Desc:'Budget esterno - web service'),
    (Nome:'C2_LIVELLO';                               Gruppo:'Budget straord.';     Lista:'T430';              Desc:'B.S.: livello per monetizzazione'),
    (Nome:'C2_FACOLTATIVO';                           Gruppo:'Budget straord.';     Lista:'SNL';               Desc:'B.S.: uso facoltativo del Budget'),
    (Nome:'C15_LIMITIMENSCAUS';                       Gruppo:'Budget straord.';     Lista:'SN';                Desc:'Limiti mensili causalizzati'),
    (Nome:'C3_INDPRES';                               Gruppo:'Profili indennit�';   Lista:'T430';              Desc:'Indennit� di presenza (Liv.1)'),
    (Nome:'C3_INDPRES2';                              Gruppo:'Profili indennit�';   Lista:'T430';              Desc:'Indennit� di presenza (Liv.2)'),
    (Nome:'C3_DATOPIANIFICABILE';                     Gruppo:'Profili indennit�';   Lista:'C3_INDPRES';        Desc:'Indennit� di presenza - Liv.pianificabile'),
    (Nome:'C3_RIEPTURNI_INDPRES';                     Gruppo:'Profili indennit�';   Lista:'SN';                Desc:'Riepilogo turni solo se maturazione indennit�'),
    (Nome:'C3_DETTGG_TIPOI';                          Gruppo:'Profili indennit�';   Lista:'SN';                Desc:'Salvataggio dettaglio GG per ind.oraria'),
    (Nome:'C3_INDENNITA_FUNZIONE';                    Gruppo:'Profili indennit�';   Lista:'T430';              Desc:'Indennit� di funzione'),
    (Nome:'C7_DATO1';                                 Gruppo:'Incentivi';           Lista:'T430';              Desc:'Incentivi: dato 1'),
    (Nome:'C7_DATO2';                                 Gruppo:'Incentivi';           Lista:'T430';              Desc:'Incentivi: dato 2'),
    (Nome:'C7_DATO3';                                 Gruppo:'Incentivi';           Lista:'T430';              Desc:'Incentivi: dato 3'),
    (Nome:'C8_MISSIONE';                              Gruppo:'Missioni';            Lista:'T430';              Desc:'Trasferte: regole'),
    (Nome:'C8_MISSIONECOMMESSA';                      Gruppo:'Missioni';            Lista:'T430';              Desc:'Trasferte: commessa'),
    (Nome:'C8_SEDE';                                  Gruppo:'Missioni';            Lista:'T430';              Desc:'Trasferte: sede di riferimento'),
    (Nome:'C8_GESTIONEMENSILE';                       Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte: gestione mensile'),
    (Nome:'C8_PROTOCOLLO_OBBLIGATORIO';               Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte: protocollo obbligatorio'),
    (Nome:'C8_W032_RICHIEDI_TIPOMISSIONE';            Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: richiesta del tipo trasferta'),
    (Nome:'C8_W032_DETTAGLIOGG';                      Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: gestione servizio attivo'),
    (Nome:'C8_W032_DOCUMENTO_MISSIONI';               Gruppo:'Missioni';            Lista:'';                  Desc:'Trasferte web: path documento informativo'),
    (Nome:'C8_W032_RIMBORSIDETT';                     Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: dettaglio rimborsi'),
    (Nome:'C8_W032_RIAPRI_MISSIONE';                  Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: riapertura trasferte liquidate'),
    (Nome:'C8_W032_TAPPE_SOLO_SU_DISTANZIOMETRO';     Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: scelta tappe solo da distanziometro'),
    (Nome:'C8_W032_MESSAGGIO_TAPPE_INESISTENTI';      Gruppo:'Missioni';            Lista:'';                  Desc:'Trasferte web: messaggio per tappe non previste'),
    (Nome:'C8_W032_UPDRICHIESTA';                     Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: richiesta considera dati di dettaglio'),
    (Nome:'C8_W032_PROTOCOLLO_MANUALE';               Gruppo:'Missioni';            Lista:'SN';                Desc:'Trasferte web: protocollo inseribile manualmente'),
    (Nome:'C11_PIANIFORARIPROG';                      Gruppo:'Pianificazione turni';Lista:'SN';                Desc:'Pianificazione orari progressiva'),
    (Nome:'C11_PIANIFORARI_DEBGG';                    Gruppo:'Pianificazione turni';Lista:'C11_MODORA_PUNTNOM';Desc:'Pianificazione orari: Debito GG'), //MODELLO ORARIO / PUNTI NOMINALI
    //(Nome:'C11_PIANIFORARI_NO_GIUSTIF';               Gruppo:'Pianificazione turni';Lista:'C11_OPE_NOOPE';     Desc:'Pianificazione orari no oper: giustificativi'), //OPERATIVA / NON OPERATIVA
    (Nome:'C11_PIANIFORARI_NO_COPIAGIUSTIF';          Gruppo:'Pianificazione turni';Lista:'C11_NO_SOVR_AGG';   Desc:'Pianificazione orari no oper: copia giustificativi'), //NO / SOVRASCRIVI / AGGIUNGI
    (*(Nome:'C22_PIANSERV_LIV1';                        Gruppo:'Pianificazione turni';Lista:'T430';              Desc:'Pianificazione servizi: livello 1'),
    (Nome:'C22_PIANSERV_LIV2';                        Gruppo:'Pianificazione turni';Lista:'T430';              Desc:'Pianificazione servizi: livello 2'),*)
    (Nome:'C1_CEDOLINICONVALUTA';                     Gruppo:'Economico';           Lista:'SN';                Desc:'Gestione cedolini con valuta'),
    (Nome:'C5_OFFICE';                                Gruppo:'Giuridico';           Lista:'OFFICE';            Desc:'Stampa certificati: pacchetto office'),
    (Nome:'C12_PREFERENZADEST';                       Gruppo:'Giuridico';           Lista:'T430';              Desc:'Preferenze destinazione'),
    (Nome:'C12_PREFERENZACOMP';                       Gruppo:'Giuridico';           Lista:'T430';              Desc:'Preferenze competenza'),
    (Nome:'C14_PROVVSEDE';                            Gruppo:'Giuridico';           Lista:'T430';              Desc:'Provvedimenti: sede'),
    (Nome:'C20_INCARICOUNITAORG';                     Gruppo:'Giuridico';           Lista:'T430';              Desc:'Incarichi: unit� organizzativa'),
    (Nome:'C10_FORMAZPROFCRED';                       Gruppo:'Formazione';          Lista:'T430';              Desc:'Formazione: profili crediti'),
    (Nome:'C10_FORMAZPROFCORSO';                      Gruppo:'Formazione';          Lista:'T430';              Desc:'Formazione: filtro partecipanti'),
    (Nome:'C21_VALUTAZIONI_LIV1';                     Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: livello 1'),
    (Nome:'C21_VALUTAZIONI_LIV2';                     Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: livello 2'),
    (Nome:'C21_VALUTAZIONI_LIV3';                     Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: livello 3'),
    (Nome:'C21_VALUTAZIONI_LIV4';                     Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: livello 4'),
    (Nome:'C21_VALUTAZIONI_RSP1';                     Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: raggrupp.responsabili Livello 1'),
    (Nome:'C21_VALUTAZIONI_RSP2';                     Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: raggrupp.responsabili Livello 2'),
    (Nome:'C21_VALUTAZIONI_PNT1';                     Gruppo:'Valutazioni';         Lista:'T430';              Desc:'Valutazioni: raggrupp. scale punteggi'),
    (Nome:'C37_NUM_COL_ALTRI_PROG';                   Gruppo:'Rendicontazione progetti'; Lista:'NUMERICO';     Desc:'Rend. prog.: colonne per altri progetti'),
    (Nome:'C37_SOLO_ATT_REND';                        Gruppo:'Rendicontazione progetti'; Lista:'SN';           Desc:'Rend. prog.: solo attivit� rendicontate'),
    (Nome:'C37_TIPO_TEMPO';                           Gruppo:'Rendicontazione progetti'; Lista:'SN';           Desc:'Rend. prog.: tipologia part-time'),
    (Nome:'C37_SEZ_GIUST_RITARDI';                    Gruppo:'Rendicontazione progetti'; Lista:'SN';           Desc:'Rend. prog.: sezione giustificazione ritardi'),
    (Nome:'C5_INTEGRAZANAG';                          Gruppo:'Sistema';             Lista:'NFT';               Desc:'Integrazione anagrafica'),
    (Nome:'C24_AZIENDABUDGET';                        Gruppo:'Sistema';             Lista:'SN';                Desc:'Azienda di tipo budget'),
    (Nome:'C26_HINTT030V430';                         Gruppo:'Sistema';             Lista:'';                  Desc:'Hint da usare per query su V430_STORICO'),
    (Nome:'C26_V430MATERIALIZZATA';                   Gruppo:'Sistema';             Lista:'SN';                Desc:'V430_STORICO materializzata'),
    (Nome:'C27_TABLESPACE_FREE';                      Gruppo:'Sistema';             Lista:'';                  Desc:'Limite minimo di spazio libero sui tablespace (MB)'),
    (Nome:'C28_CANCELLA_ANNO_LOG';                    Gruppo:'Sistema';             Lista:'NUMERICO';          Desc:'Numero di anni di mantenimento dei log'),
    (Nome:'C30_WEBSRV_A004_URL';                      Gruppo:'Web services';        Lista:'';                  Desc:'URL Inserimento giustificativi'),
    (Nome:'C30_WEBSRV_A004_DATI';                     Gruppo:'Web services';        Lista:'';                  Desc:'Dati per inserimento giustificativi'),
    (Nome:'C30_WEBSRV_A025_URL_GET';                  Gruppo:'Web services';        Lista:'';                  Desc:'URL lettura turni'),
    (Nome:'C30_WEBSRV_A025_URL_PUT';                  Gruppo:'Web services';        Lista:'';                  Desc:'URL pianificazione turni'),
    (Nome:'C30_WEBSRV_B021_URL';                      Gruppo:'Web services';        Lista:'';                  Desc:'URL web service B021'),
    (Nome:'C30_WEBSRV_B021_TOKEN';                    Gruppo:'Web services';        Lista:'SN';                Desc:'Autenticazione richiesta per i servizi web'),
    (Nome:'C30_WEBSRV_B021_PASSPHRASE';               Gruppo:'Web services';        Lista:'';                  Desc:'Passphrase SHA1 per il token di accesso'),
    (Nome:'C30_WEBSRV_B021_TIMEOUT';                  Gruppo:'Web services';        Lista:'NUMERICO';          Desc:'Timeout del token di accesso (secondi)'),
    (Nome:'C90_LINGUA';                               Gruppo:'IrisWEB-varie';       Lista:'';                  Desc:'Web: lingua dizionario'),
    (Nome:'C90_NOMEPROFILODELEGA';                    Gruppo:'IrisWEB-varie';       Lista:'';                  Desc:'Web: nome profilo da delegare'),
    (Nome:'C90_MESSAGGISTICA_REPLY';                  Gruppo:'IrisWEB-varie';       Lista:'SN';                Desc:'Web: messaggistica: abilita risposte'),
    (Nome:'C90_FILTRO_DELEGHE';                       Gruppo:'IrisWEB-varie';       Lista:'';                  Desc:'Web: filtro anagrafiche da delegare'),
    (Nome:'C90_MESSAGGISTICA_OBBLIGOLETTURA';         Gruppo:'IrisWEB-varie';       Lista:'SN';                Desc:'Web: messaggi con lettura obbligatoria'),
    (Nome:'C90_WEBAUTORIZCURRIC';                     Gruppo:'IrisWEB-varie';       Lista:'SN';                Desc:'Web: autorizzazione curriculum'),
    (Nome:'C90_WEBRIGHEPAG';                          Gruppo:'IrisWEB-varie';       Lista:'NUMERICO';          Desc:'Web: numero di righe per tabella'),
    (Nome:'C90_W005SETTIMANE';                        Gruppo:'IrisWEB-varie';       Lista:'NUMERICO';          Desc:'Web: periodo di visualizzazione cartellino interattivo'),
    (Nome:'C90_W005RIEPILOGO';                        Gruppo:'IrisWEB-varie';       Lista:'SN';                Desc:'Web: riepilogo orario del cartellino interattivo'),
    (Nome:'C90_W003MSGACCESSO';                       Gruppo:'IrisWEB-varie';       Lista:'';                  Desc:'Web: messaggio se esistenza anomalie cartellini'),
    (Nome:'C90_W009PATH_PDF';                         Gruppo:'IrisWEB-varie';       Lista:'';                  Desc:'Web: path per i file pdf dei cartellini'),
    (Nome:'C90_W009FILE_PDF';                         Gruppo:'IrisWEB-varie';       Lista:'';                  Desc:'Web: nome file pdf per servizio stampa cartellini'),

    (Nome:'C90_EMAIL_SMTPHOST';                       Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'Host SMTP per servizio mail'),
    (Nome:'C90_EMAIL_USERNAME';                       Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'UserName per servizio mail'),
    (Nome:'C90_EMAIL_PASSWORD';                       Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'PassWord per servizio mail'),
    (Nome:'C90_EMAIL_PORT';                           Gruppo:'IrisWEB-Email';       Lista:'NUMERICO';          Desc:'Porta per servizio mail'),
    (Nome:'C90_EMAIL_HELONAME';                       Gruppo:'IrisWEB-EMail';       Lista:'';                  Desc:'HeloName per servizio mail'),
    (Nome:'C90_EMAIL_AUTHTYPE';                       Gruppo:'IrisWEB-EMail';       Lista:'C90_AUTENTICAZIONI';Desc:'Tipo di autenticazione mail'),
    (Nome:'C90_EMAIL_USETLS';                         Gruppo:'IrisWEB-EMail';       Lista:'C90_USETLS';        Desc:'Uso di TLS per servizio mail'),
    (Nome:'C90_EMAIL_SENDER_INDIRIZZO';               Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'Indirizzo mail del mittente per notifiche'),
    //(Nome:'C90_EMAIL_SENDER';                         Crypt:'N'; Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'Nome del mittente per notifiche'),
    (Nome:'C90_EMAIL_W010UFF';                        Gruppo:'IrisWEB-Email';       Lista:'SN';                Desc:'Servizio mail per elaborazione assenze'),
    (Nome:'C90_EMAIL_W018UFF';                        Gruppo:'IrisWEB-Email';       Lista:'SN';                Desc:'Servizio mail per elaborazione timbrature'),
    (Nome:'C90_EMAIL_THREAD';                         Gruppo:'IrisWEB-EMail';       Lista:'SN';                Desc:'Servizio mail con invio asincrono'),
    (Nome:'C90_EMAIL_RESP_OTTIMIZZATA';               Gruppo:'IrisWEB-Email';       Lista:'SN';                Desc:'Servizio mail ottimizzato per le richieste'),
    (Nome:'C90_EMAIL_RESP_GG_REINVIO';                Gruppo:'IrisWEB-Email';       Lista:'NUMERICO';          Desc:'Limite di GG per servizio mail ottimizzato'),
    (Nome:'C90_EMAIL_RESP_OGGETTO';                   Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'Oggetto mail ottimizzata'),
    (Nome:'C90_EMAIL_RESP_TESTO';                     Gruppo:'IrisWEB-Email';       Lista:'';                  Desc:'Testo mail ottimizzata'),

    (Nome:'C90_W026UTILIZZO_DAL';                     Gruppo:'IrisWEB-Ecced.gg';    Lista:'GIORNO_MESE';       Desc:'Web: primo giorno del mese per richiedere ecced.gg'),
    (Nome:'C90_W026UTILIZZO_AL';                      Gruppo:'IrisWEB-Ecced.gg';    Lista:'GIORNO_MESE';       Desc:'Web: ultimo giorno del mese per richiedere ecced.gg'),
    (Nome:'C90_W026MMINDIETRODAL';                    Gruppo:'IrisWEB-Ecced.gg';    Lista:'NUMERICO';          Desc:'Web: primo mese antecedente al corrente per richiesta ecced.gg'),
    (Nome:'C90_W026MMINDIETROAL';                     Gruppo:'IrisWEB-Ecced.gg';    Lista:'NUMERICO';          Desc:'Web: ultimo mese antecedente al corrente per richiesta ecced.gg'),
    (Nome:'C90_W026TIPO_RICHIESTA';                   Gruppo:'IrisWEB-Ecced.gg';    Lista:'RA';                Desc:'Web: iter ecced.gg con Richiesta o solo Autorizzazione'),
    (Nome:'C90_W026CAUS_E';                           Gruppo:'IrisWEB-Ecced.gg';    Lista:'T275';              Desc:'Web: causale per straordinario su entrata'),
    (Nome:'C90_W026CAUS_U';                           Gruppo:'IrisWEB-Ecced.gg';    Lista:'T275';              Desc:'Web: causale per straordinario su uscita'),
    (Nome:'C90_W026TIPO_AUTORIZZAZIONE';              Gruppo:'IrisWEB-Ecced.gg';    Lista:'TP';                Desc:'Web: tipo autorizzazione ecced.gg (causali Pianificate o Giustificativi)'),
    (Nome:'C90_W026SPEZZONI';                         Gruppo:'IrisWEB-Ecced.gg';    Lista:'EUT';               Desc:'Web: tipo spezzoni ecced.gg (Entrata/Uscita/Tutti)'),
    (Nome:'C90_W026TIPO_STRAORD';                     Gruppo:'IrisWEB-Ecced.gg';    Lista:'NA';                Desc:'Web: tipo ore ecced.gg (Abilitate/Non abilitate)'),
    (Nome:'C90_W026ECCEDOLTREDEBITO';                 Gruppo:'IrisWEB-Ecced.gg';    Lista:'SN';                Desc:'Web: ecced.gg deve superare il debito gg'),
    (Nome:'C90_W026ECCEDGG_TUTTA';                    Gruppo:'IrisWEB-Ecced.gg';    Lista:'SN';                Desc:'Web: iter ecced.gg deve usare tutta l''eccedenza disponibile'),
    (Nome:'C90_W026ARROTONDAMENTO';                   Gruppo:'IrisWEB-Ecced.gg';    Lista:'NUMERICO';          Desc:'Web: arrotondamento dell''ecced.gg richiesta'),
    (Nome:'C90_W026SPEZZONEMINIMO';                   Gruppo:'IrisWEB-Ecced.gg';    Lista:'NUMERICO';          Desc:'Web: ecced.gg minima autorizzabile'),
    (Nome:'C90_W026CHECKSALDODISPONIBILE';            Gruppo:'IrisWEB-Ecced.gg';    Lista:'SN';                Desc:'Web: iter ecced.gg verifica il saldo mensile disponibile'),
    (Nome:'C90_CRONOLOGIA_NOTE';                      Gruppo:'IrisWEB-Iter';        Lista:'SN';                Desc:'Web: cronologia note negli iter autorizzativi'),
    (Nome:'C90_PATH_ALLEGATI';                        Gruppo:'IrisWEB-Iter';        Lista:'';                  Desc:'Path dello storage dove registrare gli allegati'),
    (Nome:'C90_ITER_MAX_ALLEGATI';                    Gruppo:'IrisWEB-Iter';        Lista:'NUMERICO';          Desc:'Web: max allegati consentiti per richiesta'),
    (Nome:'C90_ITER_MAX_DIM_ALLEGATO_MB';             Gruppo:'IrisWEB-Iter';        Lista:'NUMERICO';          Desc:'Web: dimensione massima allegato richiesta (in MB)'),
    (Nome:'C90_ITER_ESTENSIONE_ALLEGATO';             Gruppo:'IrisWEB-Iter';        Lista:'';                  Desc:'Web: estensioni ammesse per gli allegati'),
    (Nome:'C90_CANCELLA_ANNO_ALLEGATI_ITER';          Gruppo:'IrisWEB-Iter';        Lista:'NUMERICO';          Desc:'Numero di anni di mantenimento allegati iter'),
    (Nome:'C90_GG_PREAVVISO_CANCELLA_ALLEGATI';       Gruppo:'IrisWEB-Iter';        Lista:'NUMERICO';          Desc:'Giorni di preavviso all''eliminazione degli allegati'),
    (Nome:'C90_W010CAUS_PRES';                        Gruppo:'IrisWEB-Iter';        Lista:'SN';                Desc:'Web: richiesta giustificativi di presenza'),
    (Nome:'C90_W010ACQUISIZIONE_AUTO';                Gruppo:'IrisWEB-Iter';        Lista:'SN';                Desc:'Web: acquisizione automatica assenze sul cartellino'),
    (Nome:'C90_W018ACQUISIZIONE_AUTO';                Gruppo:'IrisWEB-Iter';        Lista:'SN';                Desc:'Web: acquisizione automatica timbrature sul cartellino'),
    (Nome:'C90_W024MMINDIETRO';                       Gruppo:'IrisWEB-Iter';        Lista:'NUMERICO';          Desc:'Web: mese antecedente al corrente per richiesta straord.'),
    (Nome:'C90_W024AGGSCHEDA';                        Gruppo:'IrisWEB-Iter';        Lista:'SN';                Desc:'Web: agg.scheda automatico nell''iter straord.'),
    (Nome:'C90_WEBTIPOCAMBIOORARIO';                  Gruppo:'IrisWEB-Iter';        Lista:'ICE';               Desc:'Web: tipologia cambio orario'),
    (Nome:'C90_WEBSETTCAMBIOORARIO';                  Gruppo:'IrisWEB-Iter';        Lista:'NUMERICO';          Desc:'Web: settimane per cambio orario'),
    (Nome:'C90_WC38TOLLERANZA_E';                     Gruppo:'IrisWEB-Bollatrice virtuale'; Lista:'NUMERICO';  Desc:'Web: tolleranza bollatura virtuale in E'),
    (Nome:'C90_WC38TOLLERANZA_U';                     Gruppo:'IrisWEB-Bollatrice virtuale'; Lista:'NUMERICO';  Desc:'Web: tolleranza bollatura virtuale in U'),
    (Nome:'C90_WC38RILEVATORE';                       Gruppo:'IrisWEB-Bollatrice virtuale'; Lista:'';          Desc:'Web: codice bollatrice virtuale'),
    (Nome:'C90_W038TIMBCAUSALIZZABILE';               Gruppo:'IrisWEB-Bollatrice virtuale'; Lista:'SN';        Desc:'Web: bollatura virtuale con causale'),
    (Nome:'C99_DECORRENZA_TAS000000233536';           Gruppo:'Attivazione correzioni';      Lista:'DATA';      Desc:'Decorrenza TAS000000233536 (Ind.pres. oraria)'),
    (Nome:'C99_DECORRENZA_TAS000000240638';           Gruppo:'Attivazione correzioni';      Lista:'DATA';      Desc:'Decorrenza TAS000000240638 (Causale PM con intersez.giust/timb)')
  );

  lstRiepiloghi: array[0..30] of String =
      ('T040   - Giustificativi',
       'T080   - Pianificazione',
       'T100   - Timbrature',
       'T070   - Scheda riepilogativa',
       'T071A  - Ore di assestamento',
       'T071S  - Liquidazione straordinario',
       'T074   - Liquidazione ore causalizzate',
       'T134   - Liquidazione ore anni prec.',
       'T195   - Scarico paghe',
       'T320   - Libera professione',
       'T340   - Reperibilit�',
       'T380   - Pianificazione reperibilit�',
       'T410   - Pasti',
       'T370   - Timbrature mensa',
       'T375   - Accessi mensa',
       'T680   - Buoni pasto',
       'T690   - Acquisto buoni',
       'T762   - Incentivi',
       'T130   - Residui saldi',
       'T131   - Residui presenze',
       'T264   - Residui assenze',
       'T692   - Residuo buoni',
       'SG656  - Residuo crediti formativi',
       'T820   - Limiti individuali mensili',
       'T825   - Limiti individuali annuali',
       'M040   - Missioni liquidate',
       'T500   - Servizi',
       'T860   - Validazione cartellini',
       'T250   - Notifica scioperi',
       'T860A  - Pre-validazione cartellini',
       'CSI006 - Indennit� di funzione'
      );

  //Voci per scarico paghe
  VettConst : TVettVociPaghe =
                 ((CodInt:'010';Descrizione:'Saldo mese negativo      ';Ordine:010;VocePaghe:'S';Misura:'H'),
                  (CodInt:'020';Descrizione:'Saldo mese positivo      ';Ordine:020;VocePaghe:'S';Misura:'H'),
                  (CodInt:'022';Descrizione:'Saldo mes.pos. senza ass.';Ordine:022;VocePaghe:'S';Misura:'H'),
                  (CodInt:'030';Descrizione:'Ore lavorate in fasce    ';Ordine:030;VocePaghe:'N';Misura:'H'),
                  (CodInt:'040';Descrizione:'Ore ind.turno in fasce   ';Ordine:040;VocePaghe:'N';Misura:'H'),
                  (CodInt:'060';Descrizione:'Ore straordinario        ';Ordine:050;VocePaghe:'N';Misura:'H'),
                  (CodInt:'200';Descrizione:'Ore assestamento         ';Ordine:060;VocePaghe:'N';Misura:'H'),
                  (CodInt:'205';Descrizione:'Ore liquidate anni prec. ';Ordine:065;VocePaghe:'S';Misura:'H'),
                  (CodInt:'032';Descrizione:'Banca ore in fasce       ';Ordine:070;VocePaghe:'N';Misura:'H'),
                  (CodInt:'034';Descrizione:'Banca ore liquidata      ';Ordine:072;VocePaghe:'S';Misura:'H'),
                  (CodInt:'080';Descrizione:'Recupero debito          ';Ordine:080;VocePaghe:'S';Misura:'H'),
                  (CodInt:'082';Descrizione:'Permessi non recuperati  ';Ordine:082;VocePaghe:'N';Misura:'H'),
                  (CodInt:'190';Descrizione:'Festivit� non godute     ';Ordine:083;VocePaghe:'S';Misura:'N'),
                  (CodInt:'090';Descrizione:'Totale ore lavorate      ';Ordine:090;VocePaghe:'S';Misura:'H'),
                  (CodInt:'092';Descrizione:'Ore rese INAIL           ';Ordine:092;VocePaghe:'S';Misura:'H'),
                  (CodInt:'230';Descrizione:'Ore causalizzate         ';Ordine:100;VocePaghe:'N';Misura:'H'),
                  (CodInt:'160';Descrizione:'Ore causalizzate liquid. ';Ordine:110;VocePaghe:'N';Misura:'H'),
                  (CodInt:'250';Descrizione:'Ore causalizz. a blocchi ';Ordine:120;VocePaghe:'N';Misura:'H'),
                  (CodInt:'170';Descrizione:'Giustificativi assenza   ';Ordine:130;VocePaghe:'N';Misura:'H'),
                  (CodInt:'180';Descrizione:'Periodi di assenza       ';Ordine:140;VocePaghe:'N';Misura:'H'),
                  (CodInt:'110';Descrizione:'Ind.Notturna in ore      ';Ordine:150;VocePaghe:'S';Misura:'H'),
                  (CodInt:'120';Descrizione:'Ind.Notturna in numero   ';Ordine:160;VocePaghe:'S';Misura:'N'),
                  (CodInt:'130';Descrizione:'Ind.Festive intere       ';Ordine:170;VocePaghe:'S';Misura:'N'),
                  (CodInt:'140';Descrizione:'Ind.Festive ridotte      ';Ordine:180;VocePaghe:'S';Misura:'N'),
                  (CodInt:'150';Descrizione:'Ind.Presenza             ';Ordine:190;VocePaghe:'N';Misura:'N'),
                  (CodInt:'155';Descrizione:'Ind.Funzione             ';Ordine:195;VocePaghe:'S';Misura:'V'),
                  (CodInt:'240';Descrizione:'Incentivi                ';Ordine:200;VocePaghe:'N';Misura:'V'),
                  (CodInt:'242';Descrizione:'Quota quantitativa       ';Ordine:202;VocePaghe:'N';Misura:'H'),
                  (CodInt:'244';Descrizione:'Penalizzazioni           ';Ordine:204;VocePaghe:'N';Misura:'V'),
                  (CodInt:'260';Descrizione:'Turni rep.interi         ';Ordine:210;VocePaghe:'S';Misura:'N'),
                  (CodInt:'270';Descrizione:'Turni rep.in ore         ';Ordine:220;VocePaghe:'S';Misura:'H'),
                  (CodInt:'280';Descrizione:'Turni rep.ore maggiorate ';Ordine:230;VocePaghe:'S';Misura:'H'),
                  (CodInt:'290';Descrizione:'Turni rep.ore non magg.  ';Ordine:240;VocePaghe:'S';Misura:'H'),
                  (CodInt:'295';Descrizione:'Turni rep.gett chiamata  ';Ordine:245;VocePaghe:'S';Misura:'N'),
                  (CodInt:'297';Descrizione:'Turni rep.eccedenti      ';Ordine:247;VocePaghe:'S';Misura:'N'),
                  (CodInt:'300';Descrizione:'1� turni                 ';Ordine:250;VocePaghe:'S';Misura:'N'),
                  (CodInt:'310';Descrizione:'2� turni                 ';Ordine:260;VocePaghe:'S';Misura:'N'),
                  (CodInt:'320';Descrizione:'3� turni                 ';Ordine:270;VocePaghe:'S';Misura:'N'),
                  (CodInt:'330';Descrizione:'4� turni                 ';Ordine:280;VocePaghe:'S';Misura:'N'),
                  (CodInt:'100';Descrizione:'Numero pasti             ';Ordine:290;VocePaghe:'N';Misura:'N'),
                  (CodInt:'210';Descrizione:'Buoni pasto maturati     ';Ordine:300;VocePaghe:'S';Misura:'N'),
                  (CodInt:'220';Descrizione:'Ticket maturati          ';Ordine:310;VocePaghe:'S';Misura:'N'),
                  (CodInt:'215';Descrizione:'Buoni pasto acquistati   ';Ordine:320;VocePaghe:'S';Misura:'N'),
                  (CodInt:'225';Descrizione:'Ticket acquistati        ';Ordine:330;VocePaghe:'S';Misura:'N'),
                  (CodInt:'400';Descrizione:'Trasferte:indennit� intera           ';Ordine:340;VocePaghe:'N';Misura:'V'),
                  (CodInt:'402';Descrizione:'Trasferte:indennit� rid.supero hh    ';Ordine:350;VocePaghe:'N';Misura:'V'),
                  (CodInt:'404';Descrizione:'Trasferte:indennit� rid.supero gg    ';Ordine:360;VocePaghe:'N';Misura:'V'),
                  (CodInt:'406';Descrizione:'Trasferte:indennit� rid.supero hhgg  ';Ordine:370;VocePaghe:'N';Misura:'V'),
                  (CodInt:'408';Descrizione:'Trasferte:indennit� km               ';Ordine:380;VocePaghe:'N';Misura:'V'),
                  (CodInt:'410';Descrizione:'Trasferte:quota esente tassazione    ';Ordine:390;VocePaghe:'N';Misura:'V'),
                  (CodInt:'412';Descrizione:'Trasferte:quota assoggetta tassazione';Ordine:400;VocePaghe:'N';Misura:'V'),
                  (CodInt:'424';Descrizione:'Trasferte:Rimborso spese           ';Ordine:460;VocePaghe:'N';Misura:'V'),
                  (CodInt:'426';Descrizione:'Trasferte:Rimborso spese-ind.suppl.';Ordine:470;VocePaghe:'N';Misura:'V'),
                  (CodInt:'428';Descrizione:'Trasferte:Anticipo recuperato      ';Ordine:480;VocePaghe:'S';Misura:'V')
                  );

  //Anomalie scarico paghe
  VettAnom : TAnomScaricoPaghe =
                 (('Conteggi non abilitati'),
                  ('Anomalia nel conteggio delle assenze'),
                  ('Tabella assenze non disponibile'),
                  ('Causale di assenza inesistente : '),
                  ('Ore lavorate non disponibili'),
                  ('Dati scheda non disponibili'),
                  ('Dati ore lavorate in fasce non disponibili'),
                  ('Dati indennit� di presenza non disponibili'),
                  ('Dati ore reperibilit� non disponibili'),
                  ('Dati assestamento Causali 1 non disponibili'),
                  ('Dati assestamento Causali 2 non disponibili'),
                  ('Dati assestamento fasce non disponibili'),
                  ('Dati straordinari in fasce non disponibili'),
                  ('Contratto inesistente'),
                  ('Interfaccia paghe inesistente'),
                  ('Dati anagarafici non disponibili'),
                  (''),
                  (''),
                  (''));

  ITER_ATTIVO     = 'S';

  // elenco degli iter autorizzativi gestiti
  ITER_MISSIONI   = 'M140';
  ITER_GIUSTIF    = 'T050';
  ITER_STRMESE    = 'T065';
  ITER_ORARIGG    = 'T085';
  ITER_TIMBR      = 'T105';
  ITER_STRGIORNO  = 'T325';
  ITER_CARTELLINO = 'T860';
  ITER_SCIOPERI   = 'T251';
  ITER_RENDI_PROJ = 'T755';

  ITER_SCIOPERI_DEFAULT_SCRIPT =  'begin'#13#10 +
                                  '  T250P_ANNULLA_RICHIESTA(:ID,:LIVELLO,:STATO,:RESPONSABILE,:AUTORIZZ_AUTOMATICA); '#13#10 +
                                  'end;';
  // descrizioni degli iter autorizzativi
  A000IterAutorizzativi:array [0..8] of TIterAutorizzativi = (
    (Cod:ITER_MISSIONI;   Desc:'Missioni'),
    (Cod:ITER_GIUSTIF;    Desc:'Giustificativi'),
    (Cod:ITER_STRMESE;    Desc:'Straordinario mensile'),
    (Cod:ITER_ORARIGG;    Desc:'Orario giornaliero'),
    (Cod:ITER_TIMBR;      Desc:'Timbrature'),
    (Cod:ITER_STRGIORNO;  Desc:'Eccedenze giornaliere'),
    (Cod:ITER_CARTELLINO; Desc:'Cartellino'),
    (Cod:ITER_SCIOPERI;   Desc:'Scioperi'),
    (Cod:ITER_RENDI_PROJ; Desc:'Rendicontazione progetti')
    );

  A000FasiIterAutorizzativi:array [0..4] of TFasiIterAutorizzativi = (
    (Cod:ITER_MISSIONI; Fase:1; Desc:'Missione e anticipi in attesa di autorizzazione'), //missioni e anticipi autorizzati e non pi� modificabili; non si possono ancora importare su M040
    (Cod:ITER_MISSIONI; Fase:2; Desc:'Missione e anticipi in attesa di caricamento'),    //missioni e anticipi visibili alla fase di importazione (cassa economale)
    (Cod:ITER_MISSIONI; Fase:3; Desc:'Missione e anticipi caricati'),                    //missioni e anticipi importati su M040
    (Cod:ITER_MISSIONI; Fase:4; Desc:'Rimborsi in attesa di autorizzazione'),            //rimborsi gi� autorizzati ma in attesa di validazione da uff.missioni
    (Cod:ITER_MISSIONI; Fase:5; Desc:'Autorizzazione rimborsi')                          //rimborsi validati da uff.misisoni importati su M050
    );

  A000LimiteMensileLiquidabile = '* L';
  A000LimiteMensileResiduabile = '* B';

  //Sigla pagina principale IrisCloud
  WA001PaginaPrincipale = 'WA001';

  BYTES_KB = 1024;
  BYTES_MB = 1024 * BYTES_KB;
  BYTES_GB = 1024 * BYTES_MB;

  EXT_PDF = 'pdf';
  EXT_XLS = 'xls';

  I011RIENTRIPOM_TEORICI = 'RIENTRIPOM_TEORICI';
  I011RIENTRIPOM_REALI   = 'RIENTRIPOM_REALI';
  I011RIENTRIPOM_RESI    = 'RIENTRIPOM_RESI';
  I011RIENTRIPOM_SALDO   = 'RIENTRIPOM_SALDO';
  I011BLOCCO_T860A       = 'BLOCCO_T860A';
  I011BLOCCO_T860A_USR   = 'BLOCCO_T860A_USR';
  I011BLOCCO_T860        = 'BLOCCO_T860';
  I011BLOCCO_T860_USR    = 'BLOCCO_T860_USR';

  M020TIPO_PASTO    = 'PASTO';
  M020TIPO_MEZZO    = 'MEZZO';
  M020TIPO_PEDAGGIO = 'PEDAG';

  T102STRAOSETTIMANALE = 'STRAOSETTIMANALE';
  T102STRAOSETT_ESC    = 'STRAOSETT_ESC';
  T102RIEPPRES_EU      = 'RIEPPRES_EU';
  T102RIEPASSE         = 'RIEPASSE';
  T102STRAOGG          = 'STRAOGG';
  T102STRAOGG_CAUSECC  = 'STRAOGG_CAUSECC';

  CampiT030:TCampiT030 = ('MATRICOLA','PROGRESSIVO','COGNOME','NOME','SESSO','DATANAS',
                              'COMUNENAS','CAPNAS','CODFISCALE','INIZIOSERVIZIO','RAPPORTI_UNITI','TIPO_PERSONALE');

  CampiT480:TCampiT480 = ('CODICE','CITTA','CAP','PROVINCIA','CODCATASTALE');

  ParamDelimiter: Char = '|';

  IPV4_SEPARATOR: Char = '.';
  PUBLIC_IP_UNKNOWN    = 'unknown';

  // azioni particolari degli applicativi web, richiamabili via querystring
  // formato:
  //   http://url_sito?[nome_azione]
  // esempio:
  //   http://localhost:5000?ping
  //
  // gestire le azioni in A000UInterfaccia.IWServerControllerBaseNewSession
  WEB_ACT_PING           = 'ping';
  WEB_ACT_GETFILECONFIG  = 'getfileconfig';
  WEB_ACT_DEBUG_TO_FILE  = 'debug';
  WEB_FLAG_DEBUG_TO_FILE = 'MEdp_DebugToFileEnabled';

  A000AzioniSitoWeb: array [0..4] of TAzioniSitoWeb = (
    (Nome: 'Riavvio sito web';          Comando: '#01';                          Descrizione: 'Riavvio del sito web (pu� richiedere privilegi di amministrazione)'; ),
    (Nome: 'Arresto sito web';          Comando: '#02';                          Descrizione: 'Arresto del sito web (pu� richiedere privilegi di amministrazione)'; ),
    (Nome: 'Avvio sito web';            Comando: '#03';                          Descrizione: 'Avvio del sito web (pu� richiedere privilegi di amministrazione)'; ),
    (Nome: 'Ping sito web';             Comando: '?' + WEB_ACT_PING;             Descrizione: 'Ping del sito web'; ),
    (Nome: 'Aggiornamento parametri';   Comando: '?' + WEB_ACT_GETFILECONFIG;    Descrizione: 'Lettura e aggiornamento dei parametri di configurazione da file .ini'; )
  );

  // ### parametri di configurazione applicativi web.ini ###
  FILE_CONFIG_IRISWEB   = 'IrisWeb.ini';
  FILE_CONFIG_IRISCLOUD = 'IrisCloud.ini';
  FILE_CONFIG_X001      = 'X001.ini';
  {$IF DEFINED(WEBPJ)}
  FILE_CONFIG = FILE_CONFIG_IRISCLOUD;
  {$ELSEIF DEFINED(X001)}
  FILE_CONFIG = FILE_CONFIG_X001;
  {$ELSE}
  FILE_CONFIG = FILE_CONFIG_IRISWEB;
  {$ENDIF}

  // sezioni file configurazione
  INI_SEZ_IMPOST_OPER        = 'ImpostazioniOperative';
  INI_SEZ_IMPOST_SIST        = 'ImpostazioniSistema';
  INI_SEZ_IMPOST_IW_LOG      = 'IWExceptionLogger';
  // identificativi per file di configurazione
  INI_ID_DATABASE            = 'Database';
  INI_ID_AZIENDA             = 'Azienda';
  INI_ID_PROFILO             = 'Profilo';
  INI_ID_TIMEOUT_OPER        = 'TimeoutOperatore';
  INI_ID_TIMEOUT_DIP         = 'TimeoutDipendente';
  INI_ID_MAX_SESSIONI        = 'MaxSessioni';
  INI_ID_URL_SUP_MAX_SESS    = 'URL_Supero_MaxSessioni';
  INI_ID_HOME                = 'Home';
  INI_ID_URL_LOGINERR        = 'URL_LoginErrato';
  INI_ID_PATH_LOG            = 'PathLog';
  INI_ID_URL_WS_AUT          = 'URL_WS_Autenticazione';
  INI_ID_URL_MANUTENZIONE    = 'URL_Manutenzione';
  INI_ID_URL_IRISWEBCLOUD    = 'URL_IrisWEBCLOUD';
  INI_ID_IRISWEBCLOUD_NEWTAB = 'IrisWEBCLOUD_NewTab';
  INI_ID_LOGIN_ESTERNO       = 'LoginEsterno';
  INI_ID_CAMPI_INVISIBILI    = 'CampiInvisibili';
  INI_ID_TAB_COL_PARTENZA    = 'TabColPartenza';
  INI_ID_STRUTTURA           = 'Struttura';
  INI_ID_SLR_COL_PILOTA      = 'SLRColPilota';
  INI_ID_SLR_COL_PILOTATA1   = 'SLRColPilotata1';
  INI_ID_SLR_COL_PILOTATA2   = 'SLRColPilotata2';
  INI_ID_VERSIONEDB          = 'VersioneDB';
  INI_ID_NUM_LIVELLI         = 'NumLivelli';
  INI_ID_PORT                = 'Port';
  INI_ID_CURSORI_LOGIN       = 'CursoriLogin';
  INI_ID_CURSORI_SESSIONE    = 'CursoriSessione';
  INI_ID_MAX_OPEN_CURSORS    = 'MaxOpenCursors';
  INI_ID_MAX_WORKING_MEMORY  = 'MaxWorkingMemory';
  INI_ID_LOG_ABILITATI       = 'LogAbilitati';
  INI_ID_PARAMETRI_AVANZATI  = 'ParametriAvanzati';
  INI_ID_SINGLEPAGE          = 'PaginaSingola';
  INI_ID_STARTPAGE           = 'PaginaIniziale';

  // tipologie di log abilitati
  INI_LOG_ERRORE             = 'ERRORE';
  INI_LOG_MEMORIA            = 'MEMORIA';
  INI_LOG_SESSIONE           = 'SESSIONE';
  INI_LOG_ACCESSO            = 'ACCESSO';
  INI_LOG_TRACCIA            = 'TRACCIA';

  // tipologie di com initialization
  INI_COM_NONE               = 'COM_NONE';
  INI_COM_NORMAL             = 'COM_NORMAL';
  INI_COM_MULTI              = 'COM_MULTI';

  // tipologie di stream mode per rave report
  INI_RAVE_STREAM_MODE_TEMPFILE  = 'SM_TEMPFILE';
  INI_RAVE_STREAM_MODE_MEMORY    = 'SM_MEMORY';

  // nomi dei parametri avanzati
  INI_PAR_NO_CRITICAL_SECTION_LOGIN       = 'NO_CRITICAL_SECTION_LOGIN';
  INI_PAR_NO_CRITICAL_SECTION_SESSIONE    = 'NO_CRITICAL_SECTION_SESSIONE';
  INI_PAR_NO_SHARED_LOGIN                 = 'NO_SHARED_LOGIN';
  INI_PAR_NO_REGISTRA_MSG                 = 'NO_REGISTRA_MSG';
  INI_PAR_RECUPERO_PASSWORD               = 'RECUPERO_PASSWORD';
  INI_PAR_NO_ABILITAZIONI                 = 'NO_ABILITAZIONI';
  INI_PAR_USE_STANDARD_PRINTER            = 'USE_STANDARD_PRINTER';
  INI_PAR_COMPRESSION                     = 'COMPRESSION';
  INI_PAR_NO_STAMPACARTELLINO             = 'NO_STAMPACARTELLINO';
  INI_PAR_NO_STAMPACEDOLINO               = 'NO_STAMPACEDOLINO';
  INI_PAR_NO_PDF                          = 'NO_PDF';
  INI_PAR_NO_COINITIALIZE                 = 'NO_COINITIALIZE';
  INI_PAR_CAPTION_LAYOUT                  = 'CAPTION_LAYOUT';
  INI_PAR_TRADUZIONE_CAPTION              = 'TRADUZIONE_CAPTION';
  INI_PAR_NO_DEL_TEMPFILE_ONCREATE        = 'NO_DEL_TEMPFILE_ONCREATE';
  INI_PAR_CACHED_FILES                    = 'CACHED_FILES';
  INI_PAR_NO_UNIFIED_FILES                = 'NO_UNIFIED_FILES';
  INI_PAR_JQUERY_UNCOMPRESSED             = 'JQUERY_UNCOMPRESSED';
  INI_PAR_FILE_INLINE                     = 'FILE_INLINE';
  INI_PAR_DB_STATEMENT_CACHE              = 'DB_STATEMENT_CACHE';
  INI_PAR_DB_NO_CHECK_CONNECTION          = 'DB_NO_CHECK_CONNECTION';
  INI_PAR_LOGOFF_DBPOOL                   = 'LOGOFF_DBPOOL';
  INI_PAR_DB_NO_RECONNECT                 = 'DB_NO_RECONNECT';
  INI_PAR_C017_V430                       = 'C017_V430=P430';
  INI_PAR_C018_LEADING_T030               = 'C018_LEADING_T030';
  INI_PAR_C018_NO_LEADING_T030            = 'C018_NO_LEADING_T030';
  INI_PAR_C018_UNNEST                     = 'C018_UNNEST';
  INI_PAR_C018_NO_UNNEST                  = 'C018_NO_UNNEST';
  INI_PAR_T050_CANCELLAZIONE              = 'T050_CANCELLAZIONE';
  INI_PAR_RAVEREPORT_IN_MEMORIA           = 'RAVEREPORT_IN_MEMORIA';
  INI_PAR_TOLLERA_IE7                     = 'TOLLERA_IE7';
  INI_PAR_COOKIES_ENABLE_HTTPONLY         = 'COOKIES_ENABLE_HTTPONLY';
  INI_PAR_COOKIES_ENABLE_SAMESITE_STRICT  = 'COOKIES_ENABLE_SAMESITE_STRICT';
  INI_PAR_SECURITY_ENABLE_FORM_ID_CHECK   = 'SECURITY_ENABLE_FORM_ID_CHECK';
  INI_PAR_SECURITY_ENABLE_SAME_IP_CHECK   = 'SECURITY_ENABLE_SAME_IP_CHECK';
  INI_PAR_SECURITY_ENABLE_SAME_UA_CHECK   = 'SECURITY_ENABLE_SAME_UA_CHECK';
  INI_PAR_IRISWEB_ENABLE_MULTISCHEDA      = 'IRISWEB_ENABLE_MULTISCHEDA';

  // Intraweb Exception Logger
  INI_EL_ABILITATO              = 'Abilitato';
  INI_EL_PATH_FILE_LOG          = 'PathFileLog';
  INI_EL_NOME_FILE_LOG          = 'NomeFileLog';
  INI_EL_GIORNI_RIMOZIONE       = 'RimuoviDopoGiorni';
  INI_EL_ECCEZ_IGNORATE         = 'EccezioniIgnorate';

  // ### parametri di configurazione applicativi web.fine ###

  // ### url responder.ini  ###
  URL_RESPONDER_ERROR_RESP    = 'IWERROR: ';
  URL_RESPONDER_PARAM_ID      = 'id';
  URL_RESPONDER_VALUE_ID      = 'mondoedp';
  URL_RESPONDER_PARAM_ACTION  = 'action';
  URL_RESPONDER_PARAM_SID     = 'sid';
  // ### url responder.fine ###

  DEBIT                       = 'DEBIT';
  COD_MISSIONE_DA_LIQUIDARE   = 'D';
  COD_MISSIONE_LIQUIDATA      = 'L';
  COD_MISSIONE_PARZ_LIQUIDATA = 'P';
  COD_MISSIONE_SOSPESA        = 'S';

  DESC_MISSIONE_DA_LIQUIDARE  = 'Da Liquidare';
  DESC_MISSIONE_LIQUIDATA     = 'Liquidata';
  DESC_MISSIONE_PARZ_LIQUIDATA= 'Parzialmente Liquidata';
  DESC_MISSIONE_SOSPESA       = 'Sospesa';

  MISSIONE_COD_CAT_ESTERO_MOTIVAZIONI  = 'EST01';
  MISSIONE_COD_CAT_ESTERO_IPOTESI      = 'EST02';
  MISSIONE_COD_CAT_DATI_LIBERI         = 'DET01';

  MaxAccessi=10;

  FLUSSO_INPDAP             = 'DMA';
  FLUSSO_FLUPER             = 'FLUPER';
  FLUSSO_CREDITI            = 'CREDITI';

  // ### parametri specifici per clienti.inizio ###

  TORINO_COMUNE_STRUTT_EVENTI_STR = 'CODICE_SERVIZIO';

  TO_CSI_AUT_STR = 'AUTST';     //Causale straordinario da autorizzare tramite richiesta del responsabile
  TO_CSI_STR_AUT = 'STAUT';     //Causale straordinario autorizzato dal responsabile
  TO_CSI_STR_ESC = 'STESC';     //Causale straordinario sab/dom/festivi, generato dai modelli orari ed escluso dalle ore normali
  TO_CSI_STR_PAG = 'STPAG,STMAG,HSPAG,HSMAG'; //Causali straordinario usate per liquidazione completa (esclusa dalle normali)
  TO_CSI_STR_BAO = 'STBAO,HSBAO,MGGNT'; //Causali straordinario usate per le ore a recupero (incluse nelle normali)
  TO_CSI_ABB_BANCAORE = '9103'; //Causale abbattimento giornaliero banca ore
  TO_CSI_ABB_ECCSETT  = '9104';  //Causale abbattimento giornaliero da recupero ecc.settimanale TO_CSI_REC_SETT
  TO_CSI_RICH_RECHH   = 'RECOR'; //Causale di richiesta rcupero ore da IrisWEB: capolista della catena TO_CSI_RICH_RECHH->TO_CSI_REC_SETT->TO_CSI_REC_BANCAORE
  TO_CSI_REC_SETT     = '1110'; //Causale recupero eccedenza settimanale
  TO_CSI_REC_BANCAORE = '1100'; //Causale recupero banca ore
  TO_CSI_MIN_BANCAORE = -360;   //Min Banca ore tollerata dalla fruizione assenze
  TO_CSI_MAX_BANCAORE = 1200;   //Max Banca ore riportabile da un mese all'altro
  TO_CSI_GIUST_AUMENTAFLEX = '1007'; //Giustificativi che aumentano la flessibilit�
  TO_CSI_GIUST_REPE        = '2090,2091'; //Giustificativi di reperibilit� su cui non applicare i controlli di intersezione con altri giustificativi
  TO_CSI_GIUST_LIMITATI    = '1007,1025,1100,1110,RECOR'; //Giustificativi da limitare entro i punti nominali + flex ed esternamente alla PMT
  TO_CSI_GIUST_VISITAMED   = '##1025'; //Tempo viaggio per visita medica (1025)
  TO_CSI_TEMPO_VISITAMED   = 30;     //Tempo viaggio per visita medica (1025)
  TO_CSI_MIN_STRAOSETT     = 30;     //minuti minimi per straordinario settimanale
  TO_CSI_ARR_STRAOSETT     = 15;     //minuti di arrotondmento per straordinario settimanale
  TO_CSI_CAUSALI_AUTOMATICHE = '5007,5007C,5007D'; // elenco separato da virgola di causali di assenza non gestibili manualmente

  //Array di costanti(Item Values) per maschera Ac10(CSI_TORINO))
  TO_CSI_D_TipoFestivita:array[0..2]of TItemsValues = (
    (Item:'Santo Patrono';                  Value:'A'),
    (Item:'Ex-festivit�';                   Value:'B'),
    (Item:'Festivit� in giorno di riposo';  Value:'C')
    );

  TO_CSI_D_CompNOScelta:array[0..3]of TItemsValues = (
    (Item:'Fruizione';                Value:'A'),
    (Item:'Pagamento';                Value:'B'),
    (Item:'Aumenta competenza ferie'; Value:'C'),
    (Item:'Esclude il diritto';       Value:'Z')
    );

  TO_CSI_D_CondizioneApplic:array[0..3]of TItemsValues = (
    (Item:'Sabato e domenica/Riposo per turnista';  Value:'A'),
    (Item:'Sabato e domenica per tutti';            Value:'B'),
    (Item:'Solo se giorno lavorativo';              Value:'C'),
    (Item:'Sempre senza restrizioni';               Value:'S')
    );

  TO_CSI_D_Scelta:array[0..2]of TItemsValues = (
    (Item:'Prevista la scelta per il dipendente';                         Value:'S'),
    (Item:'Non prevista scelta';                                          Value:'N'),
    (Item:'prevista scelta se non di riposo(causale o turno di riposo)';  Value:'L')
    );

  TO_CSI_D_SceltaEffettuata:array[0..2]of TItemsValues = (
    (Item:'Fruizione';                Value:'A'),
    (Item:'Pagamento';                Value:'B'),
    (Item:'Aumenta competenza ferie'; Value:'C')
    );

  TO_CSI_D_CompCausSost:array[0..2]of TItemsValues = (
    (Item:'Pagamento';                Value:'B'),
    (Item:'Aumenta competenza ferie'; Value:'C'),
    (Item:'Esclude il diritto';       Value:'Z')
    );

  // ### parametri specifici per clienti.fine ###

implementation

{ TMedpCriticalSection }
procedure TMedpCriticalSection.Enter;
begin
  TMonitor.Enter(Self);
end;

procedure TMedpCriticalSection.Leave;
begin
  TMonitor.Exit(Self);
end;

{ TElencoValoriChecklist }

constructor TElencoValoriChecklist.create;
begin
  inherited;
  lstCodice:=TStringList.Create;
  lstDescrizione:=TStringList.Create;
end;

destructor TElencoValoriChecklist.destroy;
begin
  FreeAndNil(lstCodice);
  FreeAndNil(lstDescrizione);
  inherited;
end;

function A000selDizionarioSicurezzaRiepiloghi:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to High(lstRiepiloghi) do
    Result:=Result + ' UNION' + #13#10 + 'SELECT ''SICUREZZA RIEPILOGHI'' TABELLA, ''' + Trim(Copy(lstRiepiloghi[i],1,6)) + ''' CODICE FROM DUAL';
end;

{ TGiustificativi }

procedure TGiustificativi.Clear;
begin
  _Progressivo:=0;
  //Data:=DATE_NULL;
  Causale:='';
  DataNas:=DATE_NULL;
  ProgCaus:=0;
  Tipo:='';
  DaOre:=0;
  AOre:=0;
  NuovoPeriodo:=False;
  Validata:='';
  Note:='';
  _IDRichiesta:=0;
  _IDCertificato:='';
end;

{ TTimbrature }

procedure TTimbrature.Clear;
begin
  _Progressivo:=0;
  _Data:=DATE_NULL;
  Ora:=Null;
  Verso:='';
  Flag:='';
  Rilevatore:='';
  Causale:='';
  _IDRichiesta:=0;
end;

{ TActiveDirectoryUserInfo }

procedure TActiveDirectoryUserInfo.Clear;
begin
  Self.User:='';
  Self.FullName:='';
  Self.Email:='';
end;

{ TResCtrl }

procedure TResCtrl.Clear;
begin
  Self.Ok:=False;
  Self.Messaggio:='';
end;

end.

