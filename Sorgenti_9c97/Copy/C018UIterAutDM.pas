unit C018UIterAutDM;

interface

uses
  SysUtils, StrUtils, Math, Classes, Forms, DB, Oracle, OracleData, Variants,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  C180FunzioniGenerali, R005UDataModuleMW, DatiBloccati
  {$IFDEF IRISWEB} {$IFNDEF WEBSVC}
  , meIWCheckBox, medpIWDBGrid, meIWImageFile, C190FunzioniGeneraliWeb
  {$ENDIF} {$ENDIF}
  {$IFNDEF IRISWEB} {$IFNDEF WEBSVC}
  , C017UEMailDtM
  {$ENDIF} {$ENDIF}
  ;

type
  //Condizioni per filtro richieste
  TRichiesteAllegati = (raTutte, raConAllegati, raSenzaAllegati);
  TRCondizAllegati = (caTutte, caNonPrevisti, caFacoltativi, caObbligatori);

  //Condizioni per visualizzazione icona allegati e abilitazione all'autorizzazione in grid richieste
  TCondizAllegati = (aNonRichiesti, aOpzAssenti, aObbAssenti, aPresenti, aPresBloccati);
  TVisAllegati = (aVisibile, aNonVisibile);

  TStatoAllegati = record
    Condizione: TCondizAllegati;
    Visibilita: TVisAllegati;
  end;

  TC018AllegatoInfo = class(TOracleDataSet)
  private
    FID:integer;
    C018AllegatoInfoID_ALLEGATO:TFloatField;
    C018AllegatoInfoNOME_ALLEGATO:TStringField;
    C018AllegatoInfoNOTE_ALLEGATO:TStringField;
    C018AllegatoInfoALLEGATO_BACKOFFICE:TStringField;
    procedure IniSelAllegati;
    procedure FormattaFields;
    procedure SetIDIter(ID:integer);
    procedure EstraiAllegati(ID:integer);
  public
    property ID:integer read FID write setIDIter;
    constructor Create;
    destructor Destroy; override;
  end;

  TC018IterInfo = class
  private
    FIDRichiesta:integer;

    FDataRichiesta:TDateTime;
    FNoteRichiesta:string;
    FIter:string;
    FCodIter:string;
    FRichiedente:string;

    FDataAutorizzazione:TDateTime;
    FAutorizzatore:string;
    FNoteAutorizzatore:string;

    FIDRevoca:integer;
    FDataRevoca:TDateTime;
    FNoteRevoca:string;

    FEsisteGestioneAllegati: Boolean;
    FAllegati:TC018AllegatoInfo;
    selRichiesta:TOracleDataSet;
    procedure IniSelRichiesta;
    procedure EstraiInfoIter(ID:integer;ForzaAggiornamento:Boolean);
    procedure setIDIter(ID:integer);
  public
    property IDRichiesta:integer read FIDRichiesta write setIDIter;
    property Iter:string read FIter;
    property CodIter:string read FCodIter;
    property DataRichiesta:TDateTime read FDataRichiesta;
    property Richiedente:string read FRichiedente;
    property NoteRichiesta:string read FNoteRichiesta;

    property DataAutorizzazione:TDateTime read FDataAutorizzazione;
    property Autorizzatore:string read FAutorizzatore;
    property NoteAutorizzatore:string read FNoteAutorizzatore;

    property IDRevoca:integer read FIDrevoca;
    property DataRevoca:TDateTime read FDataRevoca;
    property NoteRevoca:string read FNoteRevoca;

    property EsisteGestioneAllegati: Boolean read FEsisteGestioneAllegati;
    property Allegati:TC018AllegatoInfo read FAllegati;
    procedure AggiornaInfoIter;
    constructor Create;
    destructor Destroy; override;
  end;

  TTabellaDBInfo = record
    NomeTabella:string;
    NomeDatoID:string;
  end;

  // tipologia iter
  TC018TipoIter = (tiNone,tiRichiesta,tiAutorizzazione);

  TC018DatoAutorizzatore = record
    Esiste:Boolean;
    Valore:String;
    Livello:Integer;
  end;

  TC018DatiMail = record
    Oggetto: String;
    Corpo: String;
    // MONZA_HSGERARDO - chiamata 88132.ini
    //HasOperazione: Boolean;
    VariabiliArr: array[0..4] of String;
    // MONZA_HSGERARDO - chiamata 88132.fine
  end;

  TPeriodoVisual = record
    Dal,Al:TDateTime;
  end;

  // tipologia di richieste gestite nei vari iter
  TTipoRichieste = (// parte standard
                    trDaAutorizzare,
                    trAutorizzate,
                    trNegate,
                    trDaAutFinale,
                    trAutFinale,
                    trTutte,
                    // parte specifica
                    trDaDefinire,          // ITER_GIUSTIF
                    trAutorizzAuto,        // ITER_GIUSTIF
                    trRevocate,            // ITER_GIUSTIF
                    trDaEffettuare,        // ITER_STRGIORNO
                    trRegione,             // ITER_MISSIONI
                    trFuoriRegione,        // ITER_MISSIONI
                    trEstero,              // ITER_MISSIONI
                    trIspettive,           // ITER_MISSIONI
                    trNonIspettive,        // ITER_MISSIONI
                    trRimbDaAutorizzare,   // ITER_MISSIONI
                    trRimbDaLiquidare,     // ITER_MISSIONI
                    trRimbLiquidati,       // ITER_MISSIONI
                    trAnnullate,           // ITER_STRGIORNO + ITER_MISSIONI
                    trRichiedibili,        // ITER_STRMESE
                    trNonAutorizzabili,    // ITER_STRMESE
                    trInAutorizzazione,    // ITER_STRMESE
                    trValidate             // ITER_STRMESE
                   );

  TTipoVisto = (tvVisto,tvNoVisto,tvTutti);

  TTipoRichiesteSet = set of TTipoRichieste;

  TTipoRichiesteDati = record
    TipoRich: TTipoRichieste;  // tipologia richiesta
    Nome: String;              // nome del componente da creare
    Caption: String;           // caption del componente da creare
    FiltroResp: String;        // filtro da impostare per responsabile (oracledataset)
    FiltroDip: String;         // filtro da impostare per dipendente   (oracledataset)
    FiltroClientResp: String;  // filtro da impostare per responsabile (clientdataset)
    FiltroClientDip: String;   // filtro da impostare per dipendente   (clientdataset)
  end;

  TTipoRichiesteDatiArr = array [0..22] of TTipoRichiesteDati;

  TGruppoRichieste = record
    Iter: String;              // iter di riferimento
    IdGruppo: Integer;         // id univoco del gruppo all'interno dell'iter
    Filtro: String;            // filtro relativo al gruppo (con variabile %s per sostituzione)
  end;

  TGruppoRichiesteDett = record
    Iter: String;              // iter di riferimento
    IdGruppo: Integer;         // id univoco del gruppo all'interno dell'iter
    TipoRich: TTipoRichieste;  // tipo richiesta
    FiltroSost: String;        // sostituzione per il filtro di gruppo
  end;

  TLivelliFase = record
    Min: Integer;              // livello min per la fase
    Max: Integer;              // livello max per la fase
  end;

  TDescrizioneFase = record
    Ok: String;                // descrizione fase corrente (se autorizzata al livello "utile")
    Neg: String;               // descrizione fase corrente (se rifiutata al livello "utile")
  end;

const
  C018SI = 'S';
  C018NO = 'N';

  T065FASE_VALIDAZIONE = 1;
  T065FASE_AUTORIZZAZIONE = 2;

  // valori di T850.TIPO_RICHIESTA
  // tipologie comuni
  C018TR_ANNULLATA = 'A';         // richiesta annullata
  //M140 - missioni
  M140TR_0 = '0';                 // richiesta iniziale
  M140TR_3 = '3';                 //
  M140TR_4 = '4';                 // dopo aver chiuso la missione da parte del dipendente, dopo il caricamento rimborsi
  M140TR_5 = '5';                 // dopo aver autorizzato i rimborsi
  M140TR_6 = '6';                 // dopo aver importato i rimborsi in M050
  M140TR_A = C018TR_ANNULLATA;    // richiesta annullata
  //T251 - scioperi
  T251TR_P = 'P';                 // notifica provvisoria (bozza)
  T251TR_D = 'D';                 // notifica definitiva (richiesta effettuata)
  T251TR_E = 'E';                 // richiesta elaborata
  //T325 - ecced. giornalierie
  T325TR_I = 'I';                 // richiesta inseribile (da conteggi)
  T325TR_P = 'P';                 // richiesta salvata da inoltrare
  T325TR_R = 'R';                 // richiesta effettuata
  T325TR_E = 'E';                 // richiesta elaborata
  T325TR_A = C018TR_ANNULLATA;    // richiesta annullata

  // fasi richiesta e relative descrizioni
  M140FASE_INIZIALE       = -1;
  M140FASE_AUTORIZZAZIONE = 1;
  M140FASE_AGVIAGGIO      = 2;
  M140FASE_CASSA          = 3;  //Obbligatorio
  M140FASE_RIMBORSI       = 4;  //Obbligatorio
  M140FASE_CHIUSURA       = 5;

  M140FLAG_PERCORSO_SEDE      = 'SEDE';
  M140FLAG_PERCORSO_DOMICILIO = 'DOMICILIO';
  M140FLAG_PERCORSO_ALTRO     = 'ALTRO';

  T860FASE_CONTROLLO      = 1;
  T860FASE_VALIDAZIONE    = 2;
  T860ITER_DEFAULT        = 'CART_DIPENDENTE';
  T860STATO_INIZIALE      = 'N';
  T860STATO_VALID_MAXLIV  = '';

  // valori parametri
  TIPORICHIESTE_STANDARD  = [trDaAutorizzare,trAutorizzate,trNegate,trTutte];

  C018STRUTTURA_TUTTE     = '<Tutte>';
  C018STRUTTURA_STANDARD  = C018STRUTTURA_TUTTE;

  TIPORICHIESTE_NUMGRUPPI = 9; // un numero di 10 (0..9) raggruppamenti per ogni iter dovrebbe essere sufficiente

  // dati dei raggruppamenti di richieste
  TIPORICHIESTE_GRUPPI: array [0..3] of TGruppoRichieste = (
    (Iter: ITER_MISSIONI;  IdGruppo:  1; Filtro: 'T_ITER.FLAG_DESTINAZIONE %s'),
    (Iter: ITER_MISSIONI;  IdGruppo:  2; Filtro: 'T_ITER.FLAG_ISPETTIVA %s'),
    (Iter: ITER_MISSIONI;  IdGruppo:  3; Filtro: 'exists (select ''X'' from dual where M150F_FILTRORIMBORSI(T850.ID) %s)'),
    (Iter: ITER_STRMESE;   IdGruppo:  1; Filtro: 'T850.TIPO_RICHIESTA %s')
  );

  // dati per la sostituzione del filtro richieste nei raggruppamenti
  TIPORICHIESTE_GRUPPI_DETT: array[0..13] of TGruppoRichiesteDett = (
    (Iter: ITER_MISSIONI;  IdGruppo: 1; TipoRich:trRegione;           FiltroSost: '''R'''),
    (Iter: ITER_MISSIONI;  IdGruppo: 1; TipoRich:trFuoriRegione;      FiltroSost: '''I'''),
    (Iter: ITER_MISSIONI;  IdGruppo: 1; TipoRich:trEstero;            FiltroSost: '''E'''),
    (Iter: ITER_MISSIONI;  IdGruppo: 2; TipoRich:trIspettive;         FiltroSost: '''S'''),
    (Iter: ITER_MISSIONI;  IdGruppo: 2; TipoRich:trNonIspettive;      FiltroSost: '''N'''),
    (Iter: ITER_MISSIONI;  IdGruppo: 3; TipoRich:trRimbDaAutorizzare; FiltroSost: '''N'',''A'''),
    (Iter: ITER_MISSIONI;  IdGruppo: 3; TipoRich:trRimbDaLiquidare;   FiltroSost: '''D'''),
    (Iter: ITER_MISSIONI;  IdGruppo: 3; TipoRich:trRimbLiquidati;     FiltroSost: '''L'''),
    (Iter: ITER_STRMESE;   IdGruppo: 1; TipoRich:trRichiedibili;      FiltroSost: '''R'''),
    (Iter: ITER_STRMESE;   IdGruppo: 1; TipoRich:trDaAutorizzare;     FiltroSost: '''A'''),
    (Iter: ITER_STRMESE;   IdGruppo: 1; TipoRich:trValidate;          FiltroSost: '''V'''),
    (Iter: ITER_STRMESE;   IdGruppo: 1; TipoRich:trInAutorizzazione;  FiltroSost: '''I'''),
    (Iter: ITER_STRMESE;   IdGruppo: 1; TipoRich:trAutorizzate;       FiltroSost: '''S'''),
    (Iter: ITER_STRMESE;   IdGruppo: 1; TipoRich:trNegate;            FiltroSost: '''N''')
  );

  // dati delle tipologie di richieste con filtri individuali
  TIPORICHIESTE_DATI: TTipoRichiesteDatiArr = (
    (TipoRich:trDaAutorizzare;     Nome:'chkDaAutorizzare';     Caption:'da autorizzare';          FiltroResp:'T850.STATO is null and T851.STATO is null';    FiltroDip:'T850.STATO is null';                FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trAutorizzate;       Nome:'chkAutorizzate';       Caption:'autorizzate';             FiltroResp:'T851.STATO = ''' + C018SI + '''';              FiltroDip:'T850.STATO = ''' + C018SI + '''';   FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trDaAutFinale;       Nome:'chkDaAutFinale';       Caption:'da aut finale';           FiltroResp:'T850.STATO is null';                           FiltroDip:'T850.STATO is null';                FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trAutFinale;         Nome:'chkAutFinale';         Caption:'aut finale';              FiltroResp:'T850.STATO = ''' + C018SI + '''';              FiltroDip:'T850.STATO = ''' + C018SI + '''';   FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trNegate;            Nome:'chkNegate';            Caption:'negate';                  FiltroResp:'T851.STATO = ''' + C018NO + '''';              FiltroDip:'T850.STATO = ''' + C018NO + '''';   FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trTutte;             Nome:'chkTutte';             Caption:'tutte';                   FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trDaDefinire;        Nome:'chkDaDefinire';        Caption:'da definire';             FiltroResp:'';                                             FiltroDip:'T_ITER.ELABORATO = ''N'' and T850.TIPO_RICHIESTA = ''P'' and decode(T851P.STATO,''N'',''N'',''S'') = ''S'' and (T850.ID_REVOCA is null or T850R.STATO = ''N'')'; FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trAutorizzAuto;      Nome:'chkAutorizzAuto';      Caption:'autorizz.automatica';     FiltroResp:'T850.AUTORIZZ_AUTOMATICA = ''S''';             FiltroDip:'T850.AUTORIZZ_AUTOMATICA = ''S''';  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trRevocate;          Nome:'chkRevocate';          Caption:'revocate';                FiltroResp:'(T_ITER.ELABORATO = ''N'') and (T850.ID_REVOCATO is not null or T850.ID_REVOCA is not null)'; FiltroDip:'(T_ITER.ELABORATO = ''N'') and (T850.ID_REVOCATO is not null or T850.ID_REVOCA is not null)'; FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trDaEffettuare;      Nome:'chkDaEffettuare';      Caption:'da effettuare';           FiltroResp:'';                                             FiltroDip:'T030A.PROGRESSIVO = -1';            FiltroClientResp:''; FiltroClientDip:'TIPO_RICHIESTA =''I'''),
    (TipoRich:trAnnullate;         Nome:'chkAnnullate';         Caption:'annullate';               FiltroResp:'T850.TIPO_RICHIESTA = ''A''';                  FiltroDip:'T850.TIPO_RICHIESTA = ''A''';       FiltroClientResp:'TIPO_RICHIESTA = ''A'''; FiltroClientDip:'TIPO_RICHIESTA = ''A'''),
    (TipoRich:trRegione;           Nome:'chkRegione';           Caption:'regione';                 FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trFuoriRegione;      Nome:'chkItalia';            Caption:'fuori regione';           FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trEstero;            Nome:'chkEstero';            Caption:'estero';                  FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trIspettive;         Nome:'chkIspettive';         Caption:'ispettive';               FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trNonIspettive;      Nome:'chkNonIspettive';      Caption:'non ispettive';           FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trRimbDaAutorizzare; Nome:'chkRimbDaAutorizzare'; Caption:'rimborsi da autorizzare'; FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trRimbDaLiquidare;   Nome:'chkRimbDaLiquidare';   Caption:'rimborsi da liquidare';   FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trRimbLiquidati;     Nome:'chkRimbLiquidati';     Caption:'rimborsi liquidati';      FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trRichiedibili;      Nome:'chkRichiedibili';      Caption:'richiedibili';            FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trNonAutorizzabili;  Nome:'chkNonAutorizzabili';  Caption:'non autorizzabili';       FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trInAutorizzazione;  Nome:'chkInAutorizzazione';  Caption:'in autorizzazione';       FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:''),
    (TipoRich:trValidate;          Nome:'chkValidate';          Caption:'validate';                FiltroResp:'';                                             FiltroDip:'';                                  FiltroClientResp:''; FiltroClientDip:'')
  );

  // filtri particolari per la tipologia "annullate"
  FILTRO_ESCLUDI_ANNULLATE = 'T850.TIPO_RICHIESTA <> ''A''';
  FILTROCLIENT_ESCLUDI_ANNULLATE = 'TIPO_RICHIESTA <> ''A''';

type
  TPeriodo = class(TObject)
  private
    FTipo, FFiltro, FFiltroClient,
    FColonnaDal,FColonnaAl: String;
    FInizio,
    FFine,
    InizioVuoto,
    FineVuoto,
    InizioDefault,
    FineDefault: TDateTime;
    function  GetTipo: String;
    procedure SetTipo(const Val: String);
    function  GetColonnaDal: String;
    procedure SetColonnaDal(const Val: String);
    function  GetColonnaAl: String;
    procedure SetColonnaAl(const Val: String);
    procedure AggiornaFiltro;
    function  GetInizio: TDateTime;
    procedure SetInizio(const Val: TDateTime);
    function  GetInizioStr: String;
    procedure SetInizioStr(const Val: String);
    function  GetFine: TDateTime;
    procedure SetFine(const Val: TDateTime);
    function  GetFineStr: String;
    procedure SetFineStr(const Val: String);
    function  IsVuoto: Boolean;
    function  GetFiltro: String;
    procedure SetFiltro(const Val: String);
    function  GetFiltroClient: String;
    procedure SetFiltroClient(const Val: String);
  public
    constructor Create(const PColonnaDal, PColonnaAl: String; const PInizio, PFine: TDateTime); overload;
    constructor Create(const PColonnaData: String; const PData: TDateTime); overload;
    procedure SetVuoto;
    function EstendiInizio(const PInizio: TDateTime): Boolean;
    function EstendiFine(const PFine: TDateTime): Boolean;
    function Estendi(const PInizio, PFine: TDateTime): Boolean;
    property ColonnaDal: String read GetColonnaDal write SetColonnaDal;       // campo dataset per inizio periodo
    property ColonnaAl: String read GetColonnaAl write SetColonnaAl;          // campo dataset per fine periodo
    property Tipo: String read GetTipo write SetTipo;                         // M = manuale, A = automatico
    property Inizio: TDateTime read GetInizio write SetInizio;                // inizio periodo
    property InizioStr: String read GetInizioStr write SetInizioStr;          // inizio periodo (formato stringa)
    property Fine: TDateTime read GetFine write SetFine;                      // fine periodo
    property FineStr: String read GetFineStr write SetFineStr;                // fine periodo (formato stringa)
    property Vuoto: Boolean read IsVuoto;
    property Filtro: String read GetFiltro write SetFiltro;                   // filtro SQL per dataset
    property FiltroClient: String read GetFiltroClient write SetFiltroClient; // filtro SQL per dataset
  end;

  TC018FIterAutDM = class(TR005FDataModuleMW)
    insT850: TOracleQuery;
    updT850IdRevoca: TOracleQuery;
    updT850Note: TOracleQuery;
    updT850Stato: TOracleQuery;
    selI096: TOracleDataSet;
    delIterRichiesta: TOracleQuery;
    selI095: TOracleDataSet;
    updT850TipoRichiesta: TOracleQuery;
    updT850AutorizzAutomatica: TOracleQuery;
    updT851: TOracleQuery;
    selMaxLivelloAut: TOracleQuery;
    insT851: TOracleQuery;
    updT851Note: TOracleQuery;
    updT851Stato: TOracleQuery;
    updT851AutorizzAutomatica: TOracleQuery;
    selDualExprRichiesta: TOracleQuery;
    selMailPerAutorizzatore: TOracleQuery;
    selMailPerRichiedente: TOracleQuery;
    selT851: TOracleDataSet;
    selI093: TOracleDataSet;
    selI094: TOracleDataSet;
    selI097: TOracleDataSet;
    insupdT852: TOracleQuery;
    selT852: TOracleDataSet;
    T851F_FASE_CORRENTE: TOracleQuery;
    selT851RespFasi: TOracleDataSet;
    updT850CodIter: TOracleQuery;
    selT851StatoLivelli: TOracleDataSet;
    updT850Data: TOracleQuery;
    scrT851: TOracleQuery;
    selI075: TOracleDataSet;
    selT002_Richiesta: TOracleDataSet;
    selT002_Autorizzazione: TOracleDataSet;
    delT852: TOracleQuery;
    selT851DESC_LIVELLO: TStringField;
    selT851TITOLO_LIVELLO: TStringField;
    selT851TIPO_LIVELLO: TStringField;
    selT851OBBLIGATORIO: TStringField;
    selT851AVVISO: TStringField;
    selT851STATO: TStringField;
    selT851AUTORIZZ_AUTOMATICA: TStringField;
    selT851NOMINATIVO: TStringField;
    selT851DATA: TDateTimeField;
    selT851NOTE: TStringField;
    selT851LIVELLO: TFloatField;
    selT851C_TITOLO_LIVELLO: TStringField;
    selT851C_STATO: TStringField;
    selT853_T960: TOracleDataSet;
    insT853: TOracleQuery;
    delT853: TOracleQuery;
    selT853Count: TOracleQuery;
    selT850: TOracleQuery;
    delT851: TOracleQuery;
    delDBDato: TOracleQuery;
    updElaborato: TOracleQuery;
    delTabRichieste: TOracleQuery;
    selSG101: TOracleDataSet;
    selT230: TOracleDataSet;
    updT960Note: TOracleQuery;
    selT230Count: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT851CalcFields(DataSet: TDataSet);
  private
    FResponsabile: Boolean;
    FIter: String;
    FDescIter: String;
    FCodIter: String;
    FDescCodIter: String;
    FIterCodForm: string;
    FValAutIntermedia: String;
    FDecodeAutIntermedia: String;
    FDecodeLivMaxObb: String;
    FTipoRichiesta: String;
    // MONDOEDP - commessa MAN/07 SVILUPPO#62.ini
    FNote: String;
    // MONDOEDP - commessa MAN/07 SVILUPPO#62.fine
    FRevocabile,FEsisteAutorizzIntermedia,FEsisteAutorizzAutomatica:Boolean;
    FInibisciMailPerRichiedente,FInibisciMailPerAutorizzatore:Boolean;
    FUtilizzoAvviso,FIterModificaValori,FNoAccessoAut: Boolean;
    FId,FLivMaxObb,FLivAutIntermedia,FLivMinAllegatiObbligatori,FFaseCorrente,FMaxValoriPossibili:Integer;
    FMessaggioOperazione:String;
    FPeriodoVisual:TPeriodoVisual;
    FPeriodo:TPeriodo;
    FNoteIndicate:Boolean;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    FIDContieneAllegati: Boolean;
    FIDAllegatiVisibili: Boolean;
    FEsisteGestioneAllegati: Boolean;         // gestione allegati prevista a livello di iter     (modulo abilitato e <> 'N' su almeno un cod_iter)
    FEsisteGestioneAllegatiCodIter: Boolean;  // gestione allegati prevista a livello di cod_iter (<> 'N')
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    FRichiesteConAllegati: TRichiesteAllegati;
    FCondizioneAllegati: TRCondizAllegati;
    FStatoRichiesta: String;
    IdOld:Integer;
    selDatiBloccati:TDatiBloccati;
    FRefreshForzato_selT851StatoLivelli:Boolean;
    // R013.ini
    {$IFNDEF _IRISWEB}
    {$IFNDEF _WEBSVC}
    grArr: array[0..TIPORICHIESTE_NUMGRUPPI] of TTipoRichiesteSet;
    FTipoRichiesteDisp: TTipoRichiesteSet;
    FTipoRichiesteDefault: TTipoRichiesteSet;
    FTipoRichiesteSel: TTipoRichiesteSet;
    FTipoRichiesteDati: TTipoRichiesteDatiArr;
    FTipoVisto:TTipoVisto;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    FStruttureDisp: String;
    FStruttureDefault: String;
    FStrutturaSel: String;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    {$ENDIF}
    {$ENDIF}

    // R013.fine
    procedure ImpostaVariabiliExprRichiesta;
    procedure EseguiScriptAutorizz(var RLivello:Integer; var RStato,RResponsabile,RAutorizzAutomatica:String; PScriptAutorizz:String);
    procedure RicercaCodIter;
    function  RicercaAutorizzAutomatica:String;
    function  RicercaAutorizzAutomaticaLiv(PLivello:Integer):String;
    function  AutorizzAutomaticaLivSucc(PLivello:Integer):Integer;
    function  ValiditaRichiesta(CondizioniBloccanti:Boolean):Boolean;
    function  CheckDatiBloccati:Boolean;
    procedure MailPerAutorizzatore(LivelloObb,LivelloNoObb:Integer; Operazione:String);
    procedure MailImmediata(PDestResponsabile: Boolean; PProgressivo: Integer;
      const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
      const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
    // MONZA_HSGERARDO - chiamata 88132.ini
    procedure ImpostaVariabiliDatasetMail(DS: TOracleQuery; PDatiMail: TC018DatiMail);
    // MONZA_HSGERARDO - chiamata 88132.fine
    function  GetIterCodForm:String;
    function  GetTabellaIter:String;
    function  GetTabellaDB:TTabellaDBInfo;
    function  GetColonneIter:String;
    function  GetColonnaPeriodoInizio: String;
    function  GetColonnaPeriodoFine: String;
    function  GetOrderByIter:String;
    function  GetSQLRichiestaIter:String;
    function  GetSQLAutorizzazioneIter:String;
    function  GetTagRichiesta:Integer;
    function  GetTagAutorizzazione:Integer;
    function  GetMaxValoriPossibili: Integer;
    function  GetNumValoriPossibili(Livello:Integer):Integer;
    function  GetValoriPossibili(Livello:Integer):String;
    function  GetFaseLivello(PLivello:Integer):Integer;
    function  GetDescLivello(PLivello: Integer): String;
    function  GetAllegatiVisibili(PLivello: Integer): String;
    function  GetAllegatiObbligatori(PLivello: Integer): String;
    function  GetEsisteFase(Fase:Integer):Boolean;
    function  GetLivelliFase(const PFase: Integer): TLivelliFase;
    procedure PutIter(Iter:String);
    procedure PutCodIter(CodIter:String);
    procedure PutID(const PId:Integer);
    function  GetPeriodoVisual:TPeriodoVisual;
    function  GetUtilizzoAvviso: Boolean;
    function  GetLivMaxSoloAut: Integer;
    function  GetLivMaxAutNeg: Integer;
    function  GetLivMaxAut(AncheNegato:Boolean): Integer;
    function  GetLivObbSucc(const PLiv: Integer): Integer;
    function  ImpostaDatiMail(const SQLOggetto, SQLCorpo: String):TC018DatiMail;
    function  GetDatiMailPerAutorizzatore:TC018DatiMail;
    function  GetDatiMailPerRichiedente:TC018DatiMail;
    // EMPOLI_ASL11 - chiamata 82422.ini
    function  CronologiaNotePresente(const PNote: String): Boolean;
    // EMPOLI_ASL11 - chiamata 82422.fine
    procedure ImpostaFiltroSQLIdRichiesta(var PDataset: TOracleDataSet); inline;
    {$IFNDEF _IRISWEB}
    {$IFNDEF _WEBSVC}
    function  GetTipoRichiesteIni: TTipoRichiesteSet;
    function  GetTipoRichiesteDisp: TTipoRichiesteSet;
    procedure SetTipoRichiesteDisp(const Val: TTipoRichiesteSet);
    function  GetTipoRichiesteSel: TTipoRichiesteSet;
    procedure SetTipoRichiesteSel(const Val: TTipoRichiesteSet);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    function  GetStruttureDisp: String;
    procedure SetStruttureDisp(const Val: String);
    function  GetStruttureDefault: String;
    function  GetStrutturaSel: String;
    procedure SetStrutturaSel(const Val: String);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    function  GetFiltroGruppo(const PGruppo: Integer): String;
    function  IndexOfTipoRichiesta(const PTipoRichiesta:TTipoRichieste): Integer;
    function  GetFiltroRichiesta(const PTipoRichiesta:TTipoRichieste):String;
    procedure SetFiltroRichiesta(const PTipoRichiesta:TTipoRichieste; const Val: String);
    function  GetFiltroRichiestaClient(const PTipoRichiesta:TTipoRichieste):String;
    procedure SetFiltroRichiestaClient(const PTipoRichiesta:TTipoRichieste; const Val: String);
    function  GetFiltroRichiestaGruppo(const PTipoRichiesta: TTipoRichieste): String;
    function  GetGruppoRichiesta(const PTipoRichiesta:TTipoRichieste): Integer;
    function  IsSetCompleto(const PGruppo: Integer; PTipoRichiesteSet:TTipoRichiesteSet): Boolean;
    function  GetCombinazioneGruppo(const PGruppo: Integer): String;
    function  GetFiltroRichieste:String;
    function  GetFiltroRichiesteClient:String;
    function  GetFiltroVisto:String;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    function  GetFiltroStruttura: String;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    function  GetFiltroAllegati: String;
    function  GetTipoRichiesteDefault:TTipoRichiesteSet;
    function  GetTipoRichiestaNome(const PTipoRichiesta:TTipoRichieste):String;
    function  GetTipoRichiestaCaption(const PTipoRichiesta:TTipoRichieste):String;
    procedure SetTipoRichiestaCaption(const PTipoRichiesta:TTipoRichieste; const Val: String);
    function  IsSceltaEsclusivaTipoRichieste:Boolean;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    function  IsSceltaEsclusivaStrutture: Boolean;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    {$ENDIF}
    {$ENDIF}
  public
    lstIdFiltrati:TStringList;
    AccessoReadOnly:Boolean;
    selTabellaIter:TDataSet;
    Chiamante: String;
    procedure MailPerRichiedente(Livello:Integer);
    procedure PreparaDataSetIter(PDataSet:TDataSet; PTipoIter:TC018TipoIter);
    function  InsRichiesta(PTipoRichiesta,PNote,PIdRevocato:String; PUpdRichiesta:Boolean = False):Integer;
    function  UpdRichiesta(const PTipoRichiesta: String = ''):Integer;
    function  VerificaRichiestaEsistente(PAutorizzAutomatica:String):Integer;
    procedure EliminaIter(const PTabella: String = '');
    procedure SetIdRevoca(PIdRevoca:Integer);
    function  InsAutorizzazione(PLivello:Integer; PStato,PResponsabile,PAutorizzAutomatica,PNote:String; PApplicaAutorizzIntermedia:Boolean = False):Integer;
    procedure InsUltimeAutorizzazioni(PDaLivello:Integer; PStato,PResponsabile,PAutorizzAutomatica,PNote:String; PObbligatorie:Boolean; InibisciMailPerRichiedente:Boolean = True);
    function  InsAutorizzazioniAutomatiche:Integer;
    procedure AssegnaCodIter(parID:Integer; parIter,parCodIter:String);
    procedure SetCodIter;
    function  GetIDIter:String;
    procedure SetTipoRichiesta(PTipoRichiesta:String);
    procedure SetDataRichiesta(const PData:TDateTime = 0);
    // EMPOLI_ASL11 - chiamata 82422.ini
    //procedure SetNote(Note:String; Livello:Integer);
    function  SetNote(PNote:String; PLivello:Integer): String;
    // EMPOLI_ASL11 - chiamata 82422.fine
    procedure SetStato(PStato:String; PLivello:Integer);
    procedure SetAutorizzAutomatica(PAutorizzAutomatica:String; PLivello:Integer);
    procedure SetDatoAutorizzatore(PDato,PValore:String; PLivello:Integer);
    function  GetDatoAutorizzatore(PDato:String; PLivello:String = ''):TC018DatoAutorizzatore;
    procedure DelDatoAutorizzatore(const PDato:String; const PLivello:Integer);
    function  ModificaValori(PLivello:Integer):Boolean;
    procedure MailAnnullamentoPerAutorizzatore;
    procedure LeggiResponsabiliFasi;
    procedure LeggiIterCompleto(PForzaChiusura:Boolean = True);
    function  LeggiNoteComplete(PFormatoHTML:Boolean = True):String;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    function  GetCondizioneAllegati: String;
    function  GetAllegatiModificabili: String;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    function  LeggiAllegati(PFormatoHTML:Boolean = True): String;
    function  GetVistiPrecedenti(const PLivAttuale: Integer):String;
    function  GetCFFamiliare(Progressivo: Integer; DataNas: TDateTime):String;
    function  StatoAutorizzato(Stato:String):Boolean;
    function  StatoNegato(Stato:String):Boolean;
    {$IFDEF IRISWEB}
    {$IFNDEF WEBSVC}
    // utilizzata solo in IrisWeb
    function  SetIconaAllegati(PImg: TmeIWImageFile): TStatoAllegati;
    procedure SetValoriAut(grd: TmedpIWDBGrid; rowGrd,rowComp,idxS,idxN: Integer;
      chkAutorizzazioneClick: TprocObject);
    function  IncludiTipoRichieste(const PTipoRichieste: TTipoRichieste): Boolean;
    {$ENDIF}
    {$ENDIF}
    function  WarningRichiesta(const PTipoRichiesta: String = ''):Boolean;
    // EMPOLI_ASL11 - chiamata 82422.ini
    function  PulisciCronologiaNote(const PNote: String): String;
    function  ImpostaCronologiaNote(const PNote: String): String;
    // EMPOLI_ASL11 - chiamata 82422.fine
    //Gestione richieste
    function ResetRichiesta(const Livello:Integer;const DelDatiDB:Boolean):string;
    function CancellaRichiesta(const DelDatiDB:Boolean):string;
    function ForzaRichiesta(const Livello:Integer; const Stato:Boolean):string;
    function GetCodIterFromId(const PId: Integer): String;
    function  GetColonnaVistaPeriodoInizio: String;
    function  GetColonnaVistaPeriodoFine: String;
    //Proprietà
    property Responsabile: Boolean read FResponsabile write FResponsabile;
    property IterCodForm:String read FIterCodForm write FIterCodForm;
    property TabellaIter:String read GetTabellaIter;
    property TabellaDB:TTabellaDBInfo read GetTabellaDB;
    property ColonneIter:String read GetColonneIter;
    property OrderByIter:String read GetOrderByIter;
    property SQLRichiestaIter:String read GetSQLRichiestaIter;
    property SQLAutorizzazioneIter:String read GetSQLAutorizzazioneIter;
    property Iter:String read FIter write PutIter;
    property DescIter:String read FDescIter;
    property CodIter:String read FCodIter write PutCodIter;
    property DescCodIter:String read FDescCodIter;
    property Id:Integer read FId write PutId;
    property TipoRichiesta:String read FTipoRichiesta;
    // MONDOEDP - commessa MAN/07 SVILUPPO#62.ini
    property Note: String read FNote write FNote;
    // MONDOEDP - commessa MAN/07 SVILUPPO#62.fine
    property IterModificaValori:Boolean read FIterModificaValori;
    property LivMaxObb:Integer read FLivMaxObb;
    property LivAutIntermedia:Integer read FLivAutIntermedia;
    property ValAutIntermedia:String read FValAutIntermedia;
    property LivMaxAutNeg:Integer read GetLivMaxAutNeg;
    property LivMaxAut:Integer read GetLivMaxSoloAut;
    property LivObbSucc[const PLiv: Integer]: Integer read GetLivObbSucc;
    property LivMinAllegatiObbligatori: Integer read FLivMinAllegatiObbligatori;
    property NumValoriPossibili[Livello:Integer]:Integer read GetNumValoriPossibili;
    property ValoriPossibili[Livello:Integer]:String read GetValoriPossibili;
    property MaxValoriPossibili: Integer read GetMaxValoriPossibili;
    property MessaggioOperazione:String read FMessaggioOperazione;
    property FaseCorrente:Integer read FFaseCorrente;
    property DescLivello[Livello:Integer]:String read GetDescLivello;
    property AllegatiVisibili[Livello:Integer]:String read GetAllegatiVisibili;
    property AllegatiObbligatori[Livello:Integer]:String read GetAllegatiObbligatori;
    property FaseLivello[Livello:Integer]:Integer read GetFaseLivello;
    property EsisteFase[Fase:Integer]:Boolean read GetEsisteFase;
    property LivelliFase[const PFase: Integer]: TLivelliFase read GetLivelliFase;
    property Revocabile:Boolean read FRevocabile;
    property EsisteAutorizzIntermedia:Boolean read FEsisteAutorizzIntermedia;
    property EsisteAutorizzAutomatica:Boolean read FEsisteAutorizzAutomatica;
    property TagRichiesta:Integer read GetTagRichiesta;
    property TagAutorizzazione:Integer read GetTagAutorizzazione;
    property PeriodoVisual:TPeriodoVisual read FPeriodoVisual;
    property UtilizzoAvviso: Boolean read FUtilizzoAvviso;
    property NoteIndicate: Boolean read FNoteIndicate;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    property EsisteGestioneAllegati: Boolean read FEsisteGestioneAllegati;
    property EsisteGestioneAllegatiCodIter: Boolean read FEsisteGestioneAllegatiCodIter;
    property IDContieneAllegati: Boolean read FIDContieneAllegati;
    property IDAllegatiVisibili: Boolean read FIDAllegatiVisibili;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    property RichiesteConAllegati: TRichiesteAllegati read FRichiesteConAllegati write FRichiesteConAllegati;
    property CondizioneAllegati: TRCondizAllegati read FCondizioneAllegati write FCondizioneAllegati;
    property NoAccessoAut: Boolean read FNoAccessoAut;
    property VistiPrecedenti[const LivAttuale:Integer]: String read GetVistiPrecedenti;
    property StatoRichiesta: String read FStatoRichiesta;//Stato della richiesta su T850 dopo operazioni di InsRichiesta o InsAutorizzazione
    property RefreshForzato_selT851StatoLivelli: Boolean read FRefreshForzato_selT851StatoLivelli write FRefreshForzato_selT851StatoLivelli;
    {$IFNDEF _IRISWEB}
    {$IFNDEF _WEBSVC}
    property TipoRichiesteDisp: TTipoRichiesteSet read GetTipoRichiesteDisp write SetTipoRichiesteDisp;
    property TipoRichiesteDefault: TTipoRichiesteSet read FTipoRichiesteDefault;
    property TipoRichiesteSel: TTipoRichiesteSet read GetTipoRichiesteSel write SetTipoRichiesteSel;
    property TipoRichiesteEsclusivo: Boolean read IsSceltaEsclusivaTipoRichieste;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    property StruttureDisp: String read GetStruttureDisp write SetStruttureDisp;
    property StruttureDefault: String read FStruttureDefault;
    property StrutturaSel: String read GetStrutturaSel write SetStrutturaSel;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    property TipoVisto: TTipoVisto read FTipoVisto write FTipoVisto;
    property TipoRichiestaNome[const TipoRichiesta: TTipoRichieste]: String read GetTipoRichiestaNome;
    property TipoRichiestaCaption[const TipoRichiesta: TTipoRichieste]: String read GetTipoRichiestaCaption write SetTipoRichiestaCaption;
    property GruppoRichiesta[const TipoRichiesta: TTipoRichieste]: Integer read GetGruppoRichiesta;
    property FiltroRichiesta[const TipoRichiesta: TTipoRichieste]: String read GetFiltroRichiesta write SetFiltroRichiesta;
    property FiltroRichiestaClient[const TipoRichiesta: TTipoRichieste]: String read GetFiltroRichiestaClient write SetFiltroRichiestaClient;
    property FiltroRichiestaGruppo[const TipoRichiesta: TTipoRichieste]: String read GetFiltroRichiestaGruppo;
    property FiltroRichieste: String read GetFiltroRichieste;
    property FiltroRichiesteClient: String read GetFiltroRichiesteClient;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    property FiltroStruttura: String read GetFiltroStruttura;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    property FiltroAllegati: String read GetFiltroAllegati;
    property FiltroVisto: String read GetFiltroVisto;
    property Periodo: TPeriodo read FPeriodo;
    {$ENDIF}
    {$ENDIF}
  end;

implementation

{$R *.dfm}

{begin TC018AllegatoInfoArray}
constructor TC018AllegatoInfo.Create;
begin
  inherited Create(nil);
  IniSelAllegati;
end;

destructor TC018AllegatoInfo.Destroy;
begin
  FreeAndNil(C018AllegatoInfoID_ALLEGATO);
  FreeAndNil(C018AllegatoInfoNOME_ALLEGATO);
  inherited;
end;

procedure TC018AllegatoInfo.IniSelAllegati;
begin
  //Inizializzazione e assegnazione della sessione a finalizzata
  //all'estrazione degli allegati
  Self.Session:=SessioneOracle;
  Self.SQL.Add('select T960.ID as ID_ALLEGATO, T960.NOME_FILE||''.''||T960.EXT_FILE as NOME_ALLEGATO,');
  Self.SQL.Add('       T960.NOTE NOTE_ALLEGATO, nvl2(T960.NOME_UTENTE, ''N'', ''S'') ALLEGATO_BACKOFFICE');
  Self.SQL.Add('  from T853_DOC_ALLEGATI T853, T960_DOCUMENTI_INFO T960');
  Self.SQL.Add(' where T853.ID_T960 = T960.ID');
  Self.SQL.Add('   and T853.ID = :ID');
  Self.SQL.Add(' order by T960.DATA_CREAZIONE');
  Self.DeclareVariable('ID',otInteger);
end;

procedure TC018AllegatoInfo.FormattaFields;
begin
  //Inizializzo campi persistenti
  //Field: ID_ALLEGATO
  C018AllegatoInfoID_ALLEGATO:=TFloatField.Create(Self);
  C018AllegatoInfoID_ALLEGATO.Name:=Self.Name + 'ID_ALLEGATO';
  C018AllegatoInfoID_ALLEGATO.FieldName:='ID_ALLEGATO';
  C018AllegatoInfoID_ALLEGATO.DataSet:=Self;
  C018AllegatoInfoID_ALLEGATO.Index:=Self.FieldCount;
  C018AllegatoInfoID_ALLEGATO.DisplayLabel:='ID allegato';
  C018AllegatoInfoID_ALLEGATO.DisplayWidth:=10;
  //Field: NOME_ALLEGATO
  C018AllegatoInfoNOME_ALLEGATO:=TStringField.Create(Self);
  C018AllegatoInfoNOME_ALLEGATO.Name:=Self.Name + 'NOME_ALLEGATO';
  C018AllegatoInfoNOME_ALLEGATO.FieldName:='NOME_ALLEGATO';
  C018AllegatoInfoNOME_ALLEGATO.DataSet:=Self;
  C018AllegatoInfoNOME_ALLEGATO.Index:=Self.FieldCount;
  C018AllegatoInfoNOME_ALLEGATO.DisplayLabel:='Nome allegato';
  C018AllegatoInfoNOME_ALLEGATO.Size:=221;
  C018AllegatoInfoNOME_ALLEGATO.DisplayWidth:=20;
  //Field: NOTE_RICHIESTA
  C018AllegatoInfoNOTE_ALLEGATO:=TStringField.Create(Self);
  C018AllegatoInfoNOTE_ALLEGATO.Name:=Self.Name + 'NOTE_ALLEGATO';
  C018AllegatoInfoNOTE_ALLEGATO.FieldName:='NOTE_ALLEGATO';
  C018AllegatoInfoNOTE_ALLEGATO.DataSet:=Self;
  C018AllegatoInfoNOTE_ALLEGATO.Index:=Self.FieldCount;
  C018AllegatoInfoNOTE_ALLEGATO.DisplayLabel:='Note';
  C018AllegatoInfoNOTE_ALLEGATO.Size:=221;
  C018AllegatoInfoNOTE_ALLEGATO.DisplayWidth:=50;

  //Field: ALLEGATO_BACKOFFICE - allegato inserito da backoffice
  C018AllegatoInfoALLEGATO_BACKOFFICE:=TStringField.Create(Self);
  C018AllegatoInfoALLEGATO_BACKOFFICE.Name:=Self.Name + 'ALLEGATO_BACKOFFICE';
  C018AllegatoInfoALLEGATO_BACKOFFICE.FieldName:='ALLEGATO_BACKOFFICE';
  C018AllegatoInfoALLEGATO_BACKOFFICE.DataSet:=Self;
  C018AllegatoInfoALLEGATO_BACKOFFICE.Index:=Self.FieldCount;
  C018AllegatoInfoALLEGATO_BACKOFFICE.Visible:=False;

  Self.FieldDefs.Update;
end;

procedure TC018AllegatoInfo.EstraiAllegati(ID:integer);
begin
  FormattaFields;
  R180SetVariable(Self,'ID',ID);
  Self.Open;
end;

procedure TC018AllegatoInfo.SetIDIter(ID:integer);
begin
  EstraiAllegati(ID);
end;
{end TC018AllegatoInfoArray}

{begin TC018IterInfo}
constructor TC018IterInfo.Create;
begin
  FIDRichiesta:=-1;
  selRichiesta:=TOracleDataSet.Create(nil);
  IniSelRichiesta;
  FAllegati:=TC018AllegatoInfo.Create;
end;

destructor TC018IterInfo.Destroy;
begin
  FreeAndNil(selRichiesta);
  FreeAndNil(FAllegati);
end;

procedure TC018IterInfo.IniSelRichiesta;
begin
  //Inizializzazione e assegnazione della sessione finalizzata
  //all'estrazione dei dati generici sull'iter
  selRichiesta.Session:=SessioneOracle;
  selRichiesta.SQL.Add('select');
  //richiesta
  selRichiesta.SQL.Add('       T850.ID ID_RICHIESTA,');
  selRichiesta.SQL.Add('       T850.ITER,');
  selRichiesta.SQL.Add('       T850.COD_ITER,');
  selRichiesta.SQL.Add('       T850.DATA DATA_RICHIESTA,');
  selRichiesta.SQL.Add('       T850.NOTE NOTE_RICHIESTA,');
  selRichiesta.SQL.Add('       I060F_NOMINATIVO(T000F_GETAZIENDACORRENTE,T850.RICHIEDENTE) RICHIEDENTE,');
  //condizione allegati
  selRichiesta.SQL.Add('       T850.CONDIZ_ALLEGATI CONDIZ_ALLEGATI,');
  //autorizzazione
  selRichiesta.SQL.Add('       T851DATA DATA_AUTORIZZAZIONE,');
  selRichiesta.SQL.Add('       decode(T850.AUTORIZZ_AUTOMATICA,null,T851NOME_RESPONSABILE,''S'',''(automatico)'') RESPONSABILE,');
  selRichiesta.SQL.Add('       T851NOTE NOTE_RESPONSABILE,');
  //revoca
  selRichiesta.SQL.Add('       T850RVC.ID ID_REVOCA,');
  selRichiesta.SQL.Add('       T850RVC.DATA DATA_REVOCA,');
  selRichiesta.SQL.Add('       T850RVC.NOTE NOTE_REVOCA,');
  selRichiesta.SQL.Add('       I060F_NOMINATIVO(T000F_GETAZIENDACORRENTE,T850RVC.RICHIEDENTE) RICHIEDENTE_REVOCA');
  selRichiesta.SQL.Add('  from VT850_T851_UL T850, T850_ITER_RICHIESTE T850RVC');
  selRichiesta.SQL.Add(' where T850.ID = :ID');
  selRichiesta.SQL.Add('   and T850.ID_REVOCA = T850RVC.ID(+)');
  selRichiesta.DeclareVariable('ID',otInteger);
end;

procedure TC018IterInfo.EstraiInfoIter(ID:integer;ForzaAggiornamento:Boolean);
begin
  //Valorizzo le proprietà dell'iter
  //  - ForzaAggornamento se True e l'ID è lo stesso svuota e ricarica le propietà
  if (FIDRichiesta = ID) and not ForzaAggiornamento then
  begin
    Exit;
  end;
  try
    FIDRichiesta:=ID;
    selRichiesta.SetVariable('ID',ID);
    selRichiesta.Open;

    FDataRichiesta:=selRichiesta.FieldByName('DATA_RICHIESTA').AsDateTime;
    FIter:=selRichiesta.FieldByName('ITER').AsString;
    FCodIter:=selRichiesta.FieldByName('COD_ITER').AsString;
    FNoteRichiesta:=selRichiesta.FieldByName('NOTE_RICHIESTA').AsString;
    FRichiedente:=selRichiesta.FieldByName('RICHIEDENTE').AsString;

    FDataAutorizzazione:=selRichiesta.FieldByName('DATA_AUTORIZZAZIONE').AsDateTime;
    FAutorizzatore:=selRichiesta.FieldByName('RESPONSABILE').AsString;
    FNoteAutorizzatore:=selRichiesta.FieldByName('NOTE_RESPONSABILE').AsString;

    FIDRevoca:=selRichiesta.FieldByName('ID_REVOCA').AsInteger;
    FDataRevoca:=selRichiesta.FieldByName('DATA_REVOCA').AsDateTime;
    FNoteRevoca:=selRichiesta.FieldByName('NOTE_REVOCA').AsString;

    FEsisteGestioneAllegati:=(selRichiesta.FieldByName('CONDIZ_ALLEGATI').AsString <> 'N') and (selRichiesta.FieldByName('CONDIZ_ALLEGATI').AsString <> '');

    FAllegati.ID:=ID;
  finally
    selRichiesta.Close;
  end;
end;

procedure TC018IterInfo.AggiornaInfoIter;
begin
  EstraiInfoIter(FIDRichiesta,True);
end;

procedure TC018IterInfo.setIDIter(ID:integer);
begin
  EstraiInfoIter(ID,False);
end;
{end TC018IterInfo}


constructor TPeriodo.Create(const PColonnaDal, PColonnaAl: String; const PInizio, PFine: TDateTime);
begin
  // inizializzazioni
  InizioVuoto:=DATE_MIN;
  FineVuoto:=DATE_MAX;
  FInizio:=InizioVuoto;
  FFine:=FineVuoto;

  // impostazione parametri
  ColonnaDal:=PColonnaDal;
  ColonnaAl:=PColonnaAl;
  Inizio:=PInizio;
  Fine:=PFine;
  InizioDefault:=Inizio;
  FineDefault:=Fine;
  FTipo:='A';
end;

constructor TPeriodo.Create(const PColonnaData: String; const PData: TDateTime);
begin
  Create(PColonnaData,PColonnaData,PData,PData);
end;

function TPeriodo.GetTipo: String;
begin
  Result:=FTipo;
end;

procedure TPeriodo.SetTipo(const Val: String);
begin
  if (Val <> 'M') and (Val <> 'A') then
    raise Exception.Create('Tipologia di periodo non valida: ' + Val);
  FTipo:=Val;
end;

function TPeriodo.GetColonnaDal: String;
begin
  Result:=FColonnaDal;
end;

procedure TPeriodo.SetColonnaDal(const Val: String);
begin
  if Pos('.',Val) = 0 then
    FColonnaDal:='T_ITER.' + Val
  else
    FColonnaDal:=Val;
  AggiornaFiltro;
end;

function TPeriodo.GetColonnaAl: String;
begin
  Result:=FColonnaAl;
end;

procedure TPeriodo.SetColonnaAl(const Val: String);
begin
  if Pos('.',Val) = 0 then
    FColonnaAl:='T_ITER.' + Val
  else
    FColonnaAl:=Val;
  AggiornaFiltro;
end;

procedure TPeriodo.AggiornaFiltro;
var
  ColDalClient,
  ColAlClient: String;
begin
  ColDalClient:=StringReplace(FColonnaDal,'T_ITER.','',[]);
  ColAlClient:=StringReplace(FColonnaAl,'T_ITER.','',[]);

  // non imposta il filtro se una delle due colonne
  // (data inizio / fine) non è indicata
  if (ColDalClient = '') and (ColAlClient = '') then
  begin
    FFiltro:='';
    FFiltroClient:='';
    Exit;
  end;

  if (FInizio = InizioVuoto) and (FFine = FineVuoto) then
  begin
    // periodo non indicato
    FFiltro:='';
    FFiltroClient:='';
  end
  else if FInizio = FFine then
  begin
    // periodo di un solo giorno
    FFiltro:=Format('and %s = to_date(''%s'',''dd/mm/yyyy'') ',[FColonnaDal,FormatDateTime('dd/mm/yyyy',FInizio)]);
    FFiltroClient:=Format(' %s = %s',[ColDalClient,FloatToStr(FInizio)]);
    if FColonnaDal <> FColonnaAl then
    begin
      FFiltro:=FFiltro + Format('and %s = to_date(''%s'',''dd/mm/yyyy'')',[FColonnaAl,FormatDateTime('dd/mm/yyyy',FFine)]);
      FFiltroClient:=FFiltroClient + Format(' %s = %s',[ColAlClient,FloatToStr(FFine)]);
    end;
  end
  else if FInizio = InizioVuoto then
  begin
    // periodo <= di una data
    FFiltro:=Format('and %s <= to_date(''%s'',''dd/mm/yyyy'')',[FColonnaAl,FormatDateTime('dd/mm/yyyy',FFine)]);
    FFiltroClient:=Format(' %s <= %s',[ColAlClient,FloatToStr(FFine)]);
  end
  else if FFine = FineVuoto then
  begin
    // periodo >= di una data
    FFiltro:=Format('and %s >= to_date(''%s'',''dd/mm/yyyy'')',[FColonnaDal,FormatDateTime('dd/mm/yyyy',FInizio)]);
    FFiltroClient:=Format(' %s >= %s',[ColDalClient,FloatToStr(FInizio)]);
  end
  else
  begin
    // periodo di più giorni compreso fra due date
    if FColonnaDal = FColonnaAl then
    begin
      FFiltro:=Format('and %s between to_date(''%s'',''dd/mm/yyyy'') and to_date(''%s'',''dd/mm/yyyy'')',
                      [FColonnaDal,FormatDateTime('dd/mm/yyyy',FInizio),FormatDateTime('dd/mm/yyyy',FFine)]);
      FFiltroClient:=Format(' %s >= %s and %s <= %s',[ColDalClient,FloatToStr(FInizio),ColDalClient,FloatToStr(FFine)]);
    end
    else
    begin
      FFiltro:=Format('and (least(%s,to_date(''%s'',''dd/mm/yyyy'')) - greatest(%s,to_date(''%s'',''dd/mm/yyyy'')) >= 0)',
                     [FColonnaAl,FormatDateTime('dd/mm/yyyy',FFine),
                      FColonnaDal,FormatDateTime('dd/mm/yyyy',FInizio)]);
      FFiltroClient:=Format(' (%s >= %s) and (%s <= %s)',[FColonnaAl,FloatToStr(FInizio),FColonnaDal,FloatToStr(FFine)]);
    end;
  end;
end;

function TPeriodo.GetInizio: TDateTime;
begin
  Result:=FInizio;
end;

procedure TPeriodo.SetInizio(const Val: TDateTime);
begin
  if Val > FFine then
    raise Exception.Create('Il periodo di visualizzazione indicato non è valido!');

  if Val <> FInizio then
  begin
    FInizio:=Val;
    AggiornaFiltro;
  end;
end;

function TPeriodo.GetInizioStr: String;
begin
  if FInizio = InizioVuoto then
    Result:=''
  else
    Result:=FormatDateTime('dd/mm/yyyy',FInizio);
end;

procedure TPeriodo.SetInizioStr(const Val: String);
var
  D: TDateTime;
begin
  if Val = '' then
    Inizio:=InizioVuoto
  else if TryStrToDate(Val,D) then
    Inizio:=D;
end;

function TPeriodo.GetFine: TDateTime;
// restituisce data fine
begin
  Result:=FFine;
end;

procedure TPeriodo.SetFine(const Val: TDateTime);
// imposta data fine
begin
  if Val < FInizio then
    raise Exception.Create('Il periodo di visualizzazione indicato non è valido!');

  if Val <> FFine then
  begin
    FFine:=Val;
    AggiornaFiltro;
  end;
end;

function TPeriodo.GetFineStr: String;
// restituisce data fine in formato string
begin
  if FFine = FineVuoto then
    Result:=''
  else
    Result:=FormatDateTime('dd/mm/yyyy',FFine);
end;

procedure TPeriodo.SetFineStr(const Val: String);
// imposta data fine in formato string
var
  D: TDateTime;
begin
  if Val = '' then
    Fine:=FineVuoto
  else if TryStrToDate(Val,D) then
    Fine:=D;
end;

procedure TPeriodo.SetVuoto;
// imposta il periodo vuoto
begin
  Inizio:=InizioVuoto;
  Fine:=FineVuoto;
end;

function TPeriodo.IsVuoto: Boolean;
// restituisce True se il periodo è vuoto
begin
  Result:=(FInizio = InizioVuoto) and
          (FFine = FineVuoto);
end;

function TPeriodo.EstendiInizio(const PInizio: TDateTime): Boolean;
// valuta se è necessario anticipare la data di inizio periodo
// restituisce True se l'inizio è stato anticipato, False altrimenti
begin
  Result:=PInizio < FInizio;
  if Result then
    Inizio:=PInizio;
end;

function TPeriodo.EstendiFine(const PFine: TDateTime): Boolean;
// valuta se è necessario posticipare la data di fine periodo
// restituisce True se la fine è stata posticipata, False altrimenti
begin
  Result:=PFine > FFine;
  if Result then
    Fine:=PFine;
end;

function TPeriodo.Estendi(const PInizio, PFine: TDateTime): Boolean;
// valuta se è necessario estendere il periodo dal - al
// restituisce True se il periodo è stato effettivamente esteso, False altrimenti
var
  RIni,RFine: Boolean;
begin
  RIni:=EstendiInizio(PInizio);
  RFine:=EstendiFine(PFine);
  Result:=RIni or RFine;
end;

function TPeriodo.GetFiltro: String;
begin
  Result:=FFiltro;
end;

procedure TPeriodo.SetFiltro(const Val: String);
begin
  FFiltro:=Val;
end;

function TPeriodo.GetFiltroClient: String;
begin
  Result:=FFiltroClient;
end;

procedure TPeriodo.SetFiltroClient(const Val: String);
begin
  FFiltroClient:=Val;
end;



// ############################################################### //
// #####################   DATAMODULO C018   ##################### //
// ############################################################### //
procedure TC018FIterAutDM.DataModuleCreate(Sender: TObject);
var
  ElemTipoRich: TTipoRichieste;
begin
  try
    inherited;
    Chiamante:='C018';
    selDatiBloccati:=TDatiBloccati.Create(nil);
    FInibisciMailPerRichiedente:=False;
    FInibisciMailPerAutorizzatore:=False;
    FRefreshForzato_selT851StatoLivelli:=True;

    AccessoReadOnly:=False;
    lstIdFiltrati:=TStringList.Create;

    // R013.ini
    {$IFDEF IRISWEB}
    {$IFNDEF WEBSVC}
    FTipoRichiesteDati:=TIPORICHIESTE_DATI;
    for ElemTipoRich:=Low(TTipoRichieste) to High(TTipoRichieste) do
      TipoRichiestaCaption[ElemTipoRich]:=A000TraduzioneStringhe(TipoRichiestaCaption[ElemTipoRich]);
    {$ENDIF}
    {$ENDIF}
    // R013.fine
  except
  end;
end;

{-- Gestione richieste --}
{-- Reset richiesta --}
function TC018FIterAutDM.ResetRichiesta(const Livello:Integer;const DelDatiDB:Boolean):string;
begin
  Result:='';

  try
    //Cancello record su T851(ID,Livello)
    delT851.SetVariable('ID',Self.ID);
    delT851.SetVariable('LIVELLO',Livello);
    delT851.Execute;
    //Modifico T850 stato = a null
    updT850Stato.SetVariable('STATO',null);
    updT850Stato.SetVariable('ITER',Self.Iter);
    updT850Stato.SetVariable('ID',Self.ID);
    updT850Stato.Execute;
    //Se si tratta delle tabelle T050, T105(Giustificativi, Timbrature)
    //Imposto su tabella il flag ELABORATO = 'N'
    //Cancello i dati inseriti sulle tabelle
    if DelDatiDB and R180In(Self.Iter,[ITER_GIUSTIF,ITER_TIMBR,ITER_MISSIONI]) then
    begin
      //Cancellazione dato inserito su tabella
      delDBDato.SetVariable('TABELLA_ITER',GetTabellaDB.NomeTabella);
      delDBDato.SetVariable('NOME_DATO',GetTabellaDB.NomeDatoID);
      delDBDato.SetVariable('ID',Self.ID);
      delDBDato.Execute;
      if R180In(Self.Iter,[ITER_GIUSTIF,ITER_TIMBR]) then
      begin
        //Set elaborato uguale a 'N', solo se iter è timbrature o giustificativi
        updElaborato.SetVariable('TABELLA_ITER',TabellaIter);
        updElaborato.SetVariable('ELABORATO','N');
        updElaborato.SetVariable('ID',Self.ID);
        updElaborato.Execute;
      end;
    end;
    delT851.Session.Commit;
    //delT851.Session.Rollback;
  except
    on e:exception do
    begin
      delT851.Session.Rollback;
      Result:=e.Message;
    end;
  end;
end;

{-- Cancella richiesta --}
function TC018FIterAutDM.CancellaRichiesta(const DelDatiDB:Boolean):string;
var
  selIterGenerico: TOracleDataSet;
begin
  Result:='';
  selIterGenerico:=TOracleDataSet.Create(nil);
  try
    try
      // prepara un dataset per eseguire l'eliminazione della richiesta
      selIterGenerico.Session:=SessioneOracle;
      PreparaDataSetIter(selIterGenerico, tiRichiesta);
      ImpostaFiltroSQLIdRichiesta(selIterGenerico);
      selIterGenerico.SetVariable('DataLavoro', Trunc(R180SysDate(SessioneOracle)));
      selIterGenerico.Open;
      if selIterGenerico.RecordCount = 0 then
        raise Exception.CreateFmt('Richiesta %d non disponibile per l''eliminazione',[FId]);

      // elimina la richiesta dal database
      EliminaIter;

      // verifica se necessaria cancellazione dei dati inseriti su cartellino
      if DelDatiDB and R180In(FIter,[ITER_GIUSTIF,ITER_TIMBR,ITER_MISSIONI]) then
      begin
        //Cancellazione dato inserito su tabella
        delDBDato.SetVariable('TABELLA_ITER',GetTabellaDB.NomeTabella);
        delDBDato.SetVariable('NOME_DATO',GetTabellaDB.NomeDatoID);
        delDBDato.SetVariable('ID',Self.ID);
        delDBDato.Execute;
        //Cancellazione record T050 - T105 - M140
        delTabRichieste.SetVariable('TABELLA_ITER', TabellaIter);
        delTabRichieste.SetVariable('COLONNA_ID', GetIDIter);
        delTabRichieste.SetVariable('ID', Self.ID);
        delTabRichieste.Execute;
      end;
      SessioneOracle.Commit;
    except
      on e:exception do
      begin
        delT851.Session.Rollback;
        Result:=e.Message;
      end;
    end;
  finally
    FreeAndNil(selIterGenerico);
  end;
end;

procedure TC018FIterAutDM.ImpostaFiltroSQLIdRichiesta(var PDataset: TOracleDataSet);
// modifica la query SQL in modo da filtrare solo l'ID corrente (Self.Id)
var
  LEsisteOrderBy: Boolean;
  i: Integer;
begin
  LEsisteOrderBy:=False;
  for i:=PDataset.SQL.Count - 1 downto 0 do
  begin
    if PDataset.SQL[i].ToLower.IndexOf('order by') > -1 then
    begin
      LEsisteOrderBy:=True;
      PDataset.SQL.Insert(i, Format('and T_ITER.ID = %d',[Self.Id]));
      Break;
    end;
  end;
  if not LEsisteOrderBy then
    PDataset.SQL.Add(Format('and T_ITER.ID = %d',[Self.Id]));
end;

{-- Forza richiesta --}
function TC018FIterAutDM.ForzaRichiesta(const Livello:Integer; const Stato:Boolean):string;
var
  LivelloElab:integer;
  selIterGenerico:TOracleDataSet;
  function EsisteValoreAutorizzIntermedia(LivCorr:Integer):Boolean;
  {Restituisce True se esiste un livello <= LivCorr che prevede la possibilità di specificare il valore di auotrizzazione intermedia X usato nelle richieste preventive}
  var i:Integer;
  begin
    Result:=False;
    for i:=1 to LivCorr do
    begin
      if Pos('X',ValoriPossibili[i]) > 0 then
      begin
        Result:=True;
        Break;
      end;
    end;
  end;
begin
  selIterGenerico:=TOracleDataSet.Create(nil);
  try
    selIterGenerico.Session:=SessioneOracle;
    //PreparaDataSetIter(selIterGenerico, tiAutorizzazione);
    PreparaDataSetIter(selIterGenerico, tiRichiesta);

    //Inserisco Filtro su ID
    ImpostaFiltroSQLIdRichiesta(selIterGenerico);

    //SetVariable('DataLavoro')
    selIterGenerico.SetVariable('DataLavoro', Trunc(R180SysDate(SessioneOracle)));
    //selIterGenerico.Debug:=DebugHook <> 0;
    selIterGenerico.Open;
    if selIterGenerico.RecordCount = 0 then
      raise Exception.Create('Richiesta non disponibile per l''autorizzazione');
    selT851.First;
    while (Not selT851.Eof) and (selT851.FieldByName('LIVELLO').AsInteger <= Livello) do
    begin
      if selT851.FieldByName('STATO').IsNull and (selT851.FieldByName('OBBLIGATORIO').AsString = 'S') then
      begin
        LivelloElab:=InsAutorizzazione(selT851.FieldByName('LIVELLO').AsInteger,IfThen(Stato,'S','N'),Parametri.Operatore,'N','autorizzazione da BackOffice',False);
        if MessaggioOperazione <> '' then
        begin
          raise Exception.Create(MessaggioOperazione);
          //Break;
        end
        else
        begin
          //Se richiesta Preventiva deve essere trasformata in Definitiva
          if Stato and
             (Iter = ITER_GIUSTIF) and
             (selIterGenerico.FieldByName('TIPO_RICHIESTA').AsString = 'P') and
             EsisteValoreAutorizzIntermedia(selT851.FieldByName('LIVELLO').AsInteger)
          then
          begin
            SetTipoRichiesta('D');
          end;
        end;
        selT851.SearchRecord('LIVELLO',LivelloElab,[srFromBeginning]);
      end;
      selT851.Next;
    end;
    SessioneOracle.Commit;
  finally
    FreeAndNil(selIterGenerico);
  end;
end;


function TC018FIterAutDM.GetTabellaIter:String;
// estrae il nome della tabella Oracle specifica per l'iter indicato
// nella property "Iter"
begin
  if Iter = ITER_MISSIONI then
    Result:='M140_RICHIESTE_MISSIONI'
  else if Iter = ITER_GIUSTIF then
    Result:='T050_RICHIESTEASSENZA'
  else if Iter = ITER_STRMESE then
    Result:='T065_RICHIESTESTRAORDINARI'
  else if Iter = ITER_ORARIGG then
    Result:='T085_RICHIESTECAMBIORARI'
  else if Iter = ITER_TIMBR then
    Result:='T105_RICHIESTETIMBRATURE'
  else if Iter = ITER_STRGIORNO then
    Result:=IfThen(R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']),
                   'VT325_RICHIESTESTR_GG_EU',
                   'VT325_RICHIESTESTR_GG')
  else if Iter = ITER_CARTELLINO then
    Result:='T860_ITER_STAMPACARTELLINI'
  else if Iter = ITER_SCIOPERI then
    Result:='VT251_RICHIESTESCIOPERI'
  else if Iter = ITER_RENDI_PROJ then
    Result:='T755_RICHIESTE_RENDICONTO'
  else
    raise Exception.Create(Format('GetTabellaIter fallito: il codice iter %s non è gestito!',[Iter]));
end;

function TC018FIterAutDM.GetIDIter:String;
// estrae il nome della colonna specifica per l'iter indicato
// nella property "Iter"
begin
  Result:='ID';
end;

function TC018FIterAutDM.GetTabellaDB:TTabellaDBInfo;
begin
  Result.NomeTabella:='';
  Result.NomeDatoID:='';
  if Iter = ITER_GIUSTIF then
  begin
    Result.NomeTabella:='T040_GIUSTIFICATIVI';
    Result.NomeDatoID:='ID_RICHIESTA';
  end
  else if Iter = ITER_TIMBR then
  begin
    Result.NomeTabella:='T100_TIMBRATURE';
    Result.NomeDatoID:='ID_RICHIESTA';
  end
  else if Iter = ITER_MISSIONI then
  begin
    Result.NomeTabella:='M040_MISSIONI';
    Result.NomeDatoID:='ID_MISSIONE';
  end;
end;


function TC018FIterAutDM.GetIterCodForm:String;
// restituisce il codice della form web in cui è gestito l'iter indicato
// nella property "Iter"
begin
  if Iter = ITER_MISSIONI then
    Result:='W032'
  else if Iter = ITER_GIUSTIF then
    Result:='W010'
  else if Iter = ITER_STRMESE then
    Result:='W024'
  else if Iter = ITER_ORARIGG then
    Result:='W025'
  else if Iter = ITER_TIMBR then
    Result:='W018'
  else if Iter = ITER_STRGIORNO then
    Result:='W026'
  else if Iter = ITER_CARTELLINO then
    Result:='W009'
  else if Iter = ITER_SCIOPERI then
    Result:='W037'
  else if Iter = ITER_RENDI_PROJ then
    Result:='Wc01'
  else
    raise Exception.Create(Format('GetIterCodForm fallito: il codice iter %s non è gestito!',[Iter]));
end;

function TC018FIterAutDM.GetColonneIter:String;
// restituisce le colonne della tabella specifica dell'iter da estrarre
// nella selezione principale delle richieste / autorizzazioni
// IMPORTANTE: specificare *obbligatoriamente* le colonne con l'alias T_ITER
//             pena il rischio di ambiguità sui nomi colonna
begin
  if Iter = ITER_MISSIONI then
    Result:='T_ITER.ROWID,T_ITER.ID,T_ITER.PROGRESSIVO,T_ITER.FLAG_DESTINAZIONE,T_ITER.FLAG_ISPETTIVA,T_ITER.DATADA,T_ITER.DATAA,T_ITER.ORADA,T_ITER.ORAA,' +
            'T_ITER.PROTOCOLLO,T_ITER.FLAG_TIPOACCREDITO,T_ITER.DELEGATO,T_ITER.TIPOREGISTRAZIONE,T_ITER.ANNULLAMENTO,T_ITER.FLAG_PERCORSO,' +
            'M140F_GETPARTENZA(T_ITER.ID) PARTENZA,M140F_GETDESTINAZIONI(T_ITER.ID) ELENCO_DESTINAZIONI,M140F_GETRIENTRO(T_ITER.ID) RIENTRO,T_ITER.MISSIONE_RIAPERTA,T_ITER.PROTOCOLLO_MANUALE'
  else if Iter = ITER_GIUSTIF then
    Result:='T_ITER.ROWID,T_ITER.ID,T_ITER.PROGRESSIVO,T_ITER.CAUSALE,T_ITER.TIPOGIUST,T_ITER.DAL,T_ITER.AL,T_ITER.NUMEROORE,T_ITER.DATANAS,T_ITER.AORE,T_ITER.ELABORATO,T_ITER.NUMEROORE_PREV,T_ITER.AORE_PREV,T_ITER.CSI_TIPO_MG'
  else if Iter = ITER_STRMESE then
    Result:='T_ITER.ROWID,T_ITER.ID,T_ITER.PROGRESSIVO,T_ITER.DATA,T_ITER.ID_CONGUAGLIO,T_ITER.TIPO,T_ITER.ORE_ECCED_CALC,T_ITER.ORE_ECCEDENTI,T_ITER.ORE_DACOMPENSARE,T_ITER.ORE_DALIQUIDARE,T_ITER.CAUSALE,T_ITER.ORE_CAUSALIZZATE,' +
            'T_ITER.MIN_ORE_DALIQUIDARE,T_ITER.MIN_ORE_DACOMPENSARE'
  else if Iter = ITER_ORARIGG then
    Result:='T_ITER.ROWID,T_ITER.ID,T_ITER.PROGRESSIVO,T_ITER.DATA,T_ITER.TIPOGIORNO,T_ITER.ORARIO,T_ITER.DATA_INVER,T_ITER.TIPOGIORNO_INVER,T_ITER.ORARIO_INVER,T_ITER.SOLO_NOTE'
  else if Iter = ITER_TIMBR then
    Result:='T_ITER.ROWID,T_ITER.ID,T_ITER.PROGRESSIVO,T_ITER.DATA,T_ITER.ORA,T_ITER.VERSO,T_ITER.CAUSALE,T_ITER.OPERAZIONE,T_ITER.ELABORATO,T_ITER.CAUSALE_ORIG,T_ITER.VERSO_ORIG,T_ITER.MOTIVAZIONE,T_ITER.RILEVATORE_RICH,T_ITER.RILEVATORE_ORIG'
  else if Iter = ITER_STRGIORNO then
    Result:='T_ITER.*'
  else if Iter = ITER_CARTELLINO then
    Result:='T_ITER.ROWID,T_ITER.*'
  else if Iter = ITER_SCIOPERI then
    Result:='T_ITER.ROWID,T_ITER.*'
  else if Iter = ITER_RENDI_PROJ then
    Result:='T_ITER.ROWID,T_ITER.*'
  else
    raise Exception.Create(Format('GetColonneIter fallito: il codice iter %s non è gestito!',[Iter]));
end;

function TC018FIterAutDM.GetColonnaPeriodoInizio: String;
// restituisce il nome della colonna della tabella specifica dell'iter
// che rappresenta la data di inizio periodo
// questa informazione viene utilizzata nel filtro sul periodo
// se il periodo non è di tipo dal/al ma è un giorno singolo indicare questa colonna
begin
  if Iter = ITER_MISSIONI then
    Result:='T_ITER.DATADA'
  else if Iter = ITER_GIUSTIF then
    Result:='T_ITER.DAL'
  else if Iter = ITER_STRMESE then
    Result:='T_ITER.DATA'
  else if Iter = ITER_ORARIGG then
    Result:='T_ITER.DATA'
  else if Iter = ITER_TIMBR then
    Result:='T_ITER.DATA'
  else if Iter = ITER_STRGIORNO then
    Result:='T_ITER.DATA'
  else if Iter = ITER_CARTELLINO then
    Result:='T_ITER.MESE_CARTELLINO'
  else if Iter = ITER_SCIOPERI then
    Result:='T_ITER.DATA'
  else if Iter = ITER_RENDI_PROJ then
    Result:='T_ITER.DATA'
  else
    raise Exception.Create(Format('GetColonnaPeriodoInizio fallito: il codice iter %s non è gestito!',[Iter]));
end;

function TC018FIterAutDM.GetColonnaVistaPeriodoFine: String;
// restituisce il nome della colonna della vista specifica dell'iter (VTxxx_ITER_.....)
// che rappresenta la data di fine periodo
begin
  Result:='';
  if Iter = ITER_MISSIONI then
    Result:='M140DATAA'
  else if Iter = ITER_GIUSTIF then
    Result:='T050AL'
  else if Iter = ITER_STRMESE then
    Result:='T065DATA'
  else if Iter = ITER_ORARIGG then
    Result:='T085DATA_INVER'
  else if Iter = ITER_TIMBR then
    Result:='T105DATA'
  else if Iter = ITER_STRGIORNO then
    Result:='VT325DATA'
  else if Iter = ITER_CARTELLINO then
    Result:='T860MESE_CARTELLINO'
  else if Iter = ITER_SCIOPERI then
    Result:='VT251DATA_SCIOPERO'
  else if Iter = ITER_RENDI_PROJ then
    Result:='T755DATA'
  else
    raise Exception.Create(Format('GetColonnaVistaPeriodoFine fallito: il codice iter %s non è gestito!',[Iter]));
end;

function TC018FIterAutDM.GetColonnaVistaPeriodoInizio: String;
// restituisce il nome della colonna della vista specifica dell'iter (VTxxx_ITER_.....)
// che rappresenta la data di inizio periodo
begin
  Result:='';
  if Iter = ITER_MISSIONI then
    Result:='M140DATADA'
  else if Iter = ITER_GIUSTIF then
    Result:='T050DAL'
  else if Iter = ITER_STRMESE then
    Result:='T065DATA'
  else if Iter = ITER_ORARIGG then
    Result:='T085DATA_ORARIO'
  else if Iter = ITER_TIMBR then
    Result:='T105DATA'
  else if Iter = ITER_STRGIORNO then
    Result:='VT325DATA'
  else if Iter = ITER_CARTELLINO then
    Result:='T860MESE_CARTELLINO'
  else if Iter = ITER_SCIOPERI then
    Result:='VT251DATA_SCIOPERO'
  else if Iter = ITER_RENDI_PROJ then
    Result:='T755DATA'
  else
    raise Exception.Create(Format('GetColonnaVistaPeriodoFine fallito: il codice iter %s non è gestito!',[Iter]));
end;

function TC018FIterAutDM.GetCFFamiliare(Progressivo: Integer; DataNas: TDateTime): String;
begin
  Result:= '';
  if selSG101.Active then
    selSG101.Close;
  selSG101.SetVariable('PROGRESSIVO',Progressivo);
  selSG101.SetVariable('DATANAS',DataNas);
  selSG101.Open;
  selSG101.First;
  if selSG101.RecordCount > 0 then
    Result:=selSG101.FieldByName('CODFISCALE').AsString;
end;

function TC018FIterAutDM.GetColonnaPeriodoFine: String;
// restituisce il nome della colonna della tabella specifica dell'iter
// che rappresenta la data di fine periodo
// questa informazione viene utilizzata nel filtro sul periodo
// se il periodo non è di tipo dal/al ma è un giorno singolo indicare questa colonna
begin
  Result:='';
  if Iter = ITER_MISSIONI then
    Result:='T_ITER.DATAA'
  else if Iter = ITER_GIUSTIF then
    Result:='T_ITER.AL'
  else if Iter = ITER_STRMESE then
    Result:='T_ITER.DATA'
  else if Iter = ITER_ORARIGG then
    Result:='T_ITER.DATA'
  else if Iter = ITER_TIMBR then
    Result:='T_ITER.DATA'
  else if Iter = ITER_STRGIORNO then
    Result:='T_ITER.DATA'
  else if Iter = ITER_CARTELLINO then
    Result:='T_ITER.MESE_CARTELLINO'
  else if Iter = ITER_SCIOPERI then
    Result:='T_ITER.DATA'
  else if Iter = ITER_RENDI_PROJ then
    Result:='T_ITER.DATA'
  else
    raise Exception.Create(Format('GetColonnaPeriodoFine fallito: il codice iter %s non è gestito!',[Iter]));
end;

function TC018FIterAutDM.GetOrderByIter:String;
// restituisce le colonne per ordinamento della query di selezione principale
// delle richieste / autorizzazioni
// l'ordinamento indicato viene utilizzato sulla tabella delle richieste
begin
  Result:='';
  if Iter = ITER_MISSIONI then
    Result:='null'
  else if Iter = ITER_GIUSTIF then
    Result:='T_ITER.DAL DESC, T_ITER.TIPOGIUST, T_ITER.NUMEROORE, T_ITER.CAUSALE'
  else if Iter = ITER_STRMESE then
    Result:='T_ITER.DATA DESC, T_ITER.TIPO, T_ITER.ID_CONGUAGLIO'
  else if Iter = ITER_ORARIGG then
    Result:='T_ITER.DATA DESC'
  else if Iter = ITER_TIMBR then
    Result:='T_ITER.DATA DESC, T_ITER.ORA'
  else if Iter = ITER_STRGIORNO then
    Result:='null'
  else if Iter = ITER_CARTELLINO then
    Result:='T_ITER.MESE_CARTELLINO desc'
  else if Iter = ITER_SCIOPERI then
    Result:='T_ITER.DATA DESC'
  else if Iter = ITER_RENDI_PROJ then
    Result:='T_ITER.DATA DESC, T_ITER.ID_T752'
  else
    raise Exception.Create(Format('GetOrderByIter fallito: il codice iter %s non è gestito!',[Iter]));
end;

function TC018FIterAutDM.GetSQLRichiestaIter:String;
// restituisce la query principale per estrarre le richieste (lato dipendente)
// dell'iter specifico
begin
  Result:='';

  // per ogni cliente / azienda è possibile ridefinire la query per estrarre
  // le richieste sulla tabella T002_QUERYPERSONALIZZATE
  // questo passaggio verifica la presenza dell'eventuale query ridefinita
  // con NOME = '#MEDP_C018_RICHIESTA#' e APPLICAZIONE = 'MEDP'
  with selT002_Richiesta do
  begin
    Open;
    First;
    while not Eof do
    begin
      Result:=Result + FieldByName('RIGA').AsString + #13#10;
      Next;
    end;
  end;

  // se non esiste una ridefinizione specifica utilizza la query standard
  if Result = '' then
  begin
    Result:='select /* LEADING(T030A) */' + #13#10 +
            '  ' + ColonneIter + ',' + #13#10 +
            '  T030A.MATRICOLA, T030A.COGNOME || '' '' || T030A.NOME NOMINATIVO, T030A.SESSO,' + #13#10 +
            '  T850.STATO AUTORIZZAZIONE,T850.DATA DATA_RICHIESTA,T850.TIPO_RICHIESTA,T850.ID_REVOCA,T850.ID_REVOCATO,T850.AUTORIZZ_AUTOMATICA,T850.COD_ITER,' + #13#10 +
            '  T851F_REVOCABILE(:AZIENDA, :ITER, T850.COD_ITER, T850.ID) REVOCABILE,' + #13#10 +
            '  I060F_NOMINATIVO(:AZIENDA, decode(T850.STATO,''N'',T851F_AUTORIZZATORE_NEGATO(T850.ID),T851A.RESPONSABILE)) NOMINATIVO_RESP,' + #13#10 +
            '  T851A.DATA DATA_AUTORIZZAZIONE,' + #13#10 +
            '  decode(T850.TIPO_RICHIESTA,''P'',decode(T851P.STATO,null,null,''N'',''N'',''S''),T850.STATO) AUTORIZZ_UTILE,' + #13#10 +
            '  decode(T851P.STATO,null,null,''N'',''N'',''S'') AUTORIZZ_PREV,' + #13#10 +
            '  T851P.AUTORIZZ_AUTOMATICA AUTORIZZ_AUTOM_PREV,' + #13#10 +
            '  T851P.RESPONSABILE RESPONSABILE_PREV,' + #13#10 +
            '  T850R.STATO AUTORIZZ_REVOCA,' + #13#10 +
            '  0 LIVELLO_AUTORIZZAZIONE,' + #13#10 +
            '  T851F_FASE_CORRENTE(:AZIENDA, :ITER, T850.COD_ITER, T850.ID) FASE_CORRENTE' + #13#10 +
            'from' + #13#10 +
            '  ' + TabellaIter + ' T_ITER,' + #13#10 +
            '  T850_ITER_RICHIESTE T850,' + #13#10 +
            '  T850_ITER_RICHIESTE T850R,' + #13#10 +
            '  T851_ITER_AUTORIZZAZIONI T851P,' + #13#10 +
            '  T851_ITER_AUTORIZZAZIONI T851A,' + #13#10 +
            '  T030_ANAGRAFICO T030A' + #13#10 +
            'where exists (select /* UNNEST */ PROGRESSIVO from' + #13#10 +
            '              ' + QVistaOracle + #13#10 +
            '              :FILTRO_ANAG' + #13#10 +
            '              and T030A.PROGRESSIVO = T030.PROGRESSIVO)' + #13#10 +
            'and T_ITER.PROGRESSIVO = T030A.PROGRESSIVO' + #13#10 +
            'and T850.ITER = :ITER and T850.ID = T_ITER.ID' + #13#10 +
            'and T850R.ITER(+) = :ITER and T850R.ID(+) = T850.ID_REVOCA' + #13#10 +
            'and T851P.ID(+) = T850.ID and T851P.LIVELLO(+) = ' + FDecodeAutIntermedia + #13#10 +
            'and T851A.ID(+) = T850.ID and T851A.LIVELLO(+) = ' + FDecodeLivMaxObb + #13#10 +
            ':FILTRO_VISUALIZZAZIONE' + #13#10 +
            IfThen(Iter = ITER_RENDI_PROJ,':FILTRO_PROGETTO' + #13#10) +
            // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
            ':FILTRO_STRUTTURA' + #13#10 +
            // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
            ':FILTRO_ALLEGATI' + #13#10 +
            ':FILTRO_PERIODO' + #13#10 +
            'order by' + #13#10 +
            '  NOMINATIVO, T030A.MATRICOLA, ' + OrderByIter + ', T850.DATA DESC';
  end;

  Result:=StringReplace(Result,'<:ColonneIter>',ColonneIter,[rfReplaceAll,rfIgnoreCase]);
  Result:=StringReplace(Result,'<:TabellaIter>',TabellaIter,[rfReplaceAll,rfIgnoreCase]);
  Result:=StringReplace(Result,'<:QVistaOracle>',QVistaOracle,[rfReplaceAll,rfIgnoreCase]);
  Result:=StringReplace(Result,'<:FDecodeAutIntermedia>',FDecodeAutIntermedia,[rfReplaceAll,rfIgnoreCase]);
  Result:=StringReplace(Result,'<:FDecodeLivMaxObb>',FDecodeLivMaxObb,[rfReplaceAll,rfIgnoreCase]);
  Result:=StringReplace(Result,'<:OrderByIter>',OrderByIter,[rfReplaceAll,rfIgnoreCase]);
end;

function TC018FIterAutDM.GetSQLAutorizzazioneIter:String;
// restituisce la query principale per estrarre le richieste (lato autorizzatore)
// dell'iter specifico
var
  Cart: Boolean;
begin
  Result:='';

  // per ogni cliente / azienda è possibile ridefinire la query per estrarre
  // le richieste sulla tabella T002_QUERYPERSONALIZZATE
  // questo passaggio verifica la presenza dell'eventuale query ridefinita
  // con NOME = '#MEDP_C018_AUTORIZZAZIONE#' e APPLICAZIONE = 'MEDP'
  with selT002_Autorizzazione do
  begin
    Open;
    First;
    while not Eof do
    begin
      Result:=Result + FieldByName('RIGA').AsString + #13#10;
      Next;
    end;
  end;

  // indica il caso della validazione cartellino lato dipendente
  Cart:=(Iter = ITER_CARTELLINO) and Parametri.InibizioneIndividuale;

  // se non esiste una ridefinizione specifica utilizza la query standard
  if Result = '' then
  begin
    Result:='select /* LEADING(T030A) */' + #13#10 +
            '  ' + ColonneIter + ',' + #13#10 +
            '  T030A.MATRICOLA, T030A.COGNOME || '' '' || T030A.NOME NOMINATIVO, T030A.SESSO,' + #13#10 +
            '  T850.COD_ITER, T850.DATA DATA_RICHIESTA, T850.STATO AUTORIZZAZIONE, T850.TIPO_RICHIESTA, T850.ID_REVOCA, T850.ID_REVOCATO,' + #13#10 +
            '  T851F_LIVELLO_AUTORIZZABILE(:AZIENDA, :PROFILO, :ITER, T850.COD_ITER, T850.ID) LIVELLO_AUTORIZZAZIONE,' + #13#10 +
            '  T851.DATA DATA_AUTORIZZAZIONE, T851.STATO AUTORIZZ_UTILE, T851.AUTORIZZ_AUTOMATICA,' + #13#10 +
            '  I060F_NOMINATIVO(:AZIENDA, T851.RESPONSABILE) NOMINATIVO_RESP,' + #13#10 +
            IfThen(Cart,
            '  I060F_NOMINATIVO(:AZIENDA, T851A.RESPONSABILE)','null'
            ) + ' NOMINATIVO_RESP2, ' + #13#10 +
            '  null AUTORIZZ_PREV,' + #13#10 +
            '  null AUTORIZZ_AUTOM_PREV,' + #13#10 +
            '  null RESPONSABILE_PREV,' + #13#10 +
            '  T850R.STATO AUTORIZZ_REVOCA,' + #13#10 +
            '  null REVOCABILE,' + #13#10 +
            '  T851F_FASE_CORRENTE(:AZIENDA, :ITER, T850.COD_ITER, T850.ID) FASE_CORRENTE' + #13#10 +
            'from' + #13#10 +
            '  ' + TabellaIter + ' T_ITER,' + #13#10 +
            '  T850_ITER_RICHIESTE T850,' + #13#10 +
            '  T850_ITER_RICHIESTE T850R,' + #13#10 +
            '  T851_ITER_AUTORIZZAZIONI T851,' + #13#10 +
            IfThen(Cart,
            '  T851_ITER_AUTORIZZAZIONI T851A,' + #13#10
            ) +
            '  T030_ANAGRAFICO T030A' + #13#10 +
            'where exists (select /* UNNEST */ PROGRESSIVO from' + #13#10 +
            '              ' + QVistaOracle + #13#10 +
            '              :FILTRO_ANAG' + #13#10 +
            '              and T030A.PROGRESSIVO = T030.PROGRESSIVO)' + #13#10 +
            'and T_ITER.PROGRESSIVO = T030A.PROGRESSIVO' + #13#10 +
            'and T850.ITER = :ITER and T850.ID = T_ITER.ID' + #13#10 +
            'and T850R.ITER(+) = :ITER and T850R.ID(+) = T850.ID_REVOCA' + #13#10 +
            'and exists(select ''X'' from dual where I075F_LIVOBBPRECAUT(:AZIENDA, :ITER, T850.COD_ITER, T850.ID, :PROFILO) = ''S'')' + #13#10 +
            'and T851.ID(+) = T850.ID and T851.LIVELLO(+) = abs(T851F_LIVELLO_AUTORIZZABILE(:AZIENDA, :PROFILO, :ITER, T850.COD_ITER, T850.ID))' + #13#10 +
            IfThen(Cart,
            'and T851A.ID(+) = T850.ID and T851A.LIVELLO(+) = ' + FDecodeLivMaxObb + #13#10
            ) +
            ':FILTRO_VISUALIZZAZIONE' + #13#10 +
            IfThen(Iter = ITER_RENDI_PROJ,':FILTRO_PROGETTO' + #13#10) +
            // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
            ':FILTRO_STRUTTURA' + #13#10 +
            // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
            ':FILTRO_ALLEGATI '#13#10 +
            ':FILTRO_PERIODO' + #13#10 +
            {
            IfThen(FIterRangeVisibilita,
            // v1. exists
            //'and exists(select ''X'' from dual where I096_VISIBILITA_PERIODO(:AZIENDA, :PROFILO, :ITER, T850.COD_ITER, T850.ID) = ''S'')'#13#10
            // v2. chiamata diretta
            'and I096_VISIBILITA_PERIODO(:AZIENDA, :PROFILO, :ITER, T850.COD_ITER, T850.ID) = ''S'''#13#10
            ) +
            }
            'order by' + #13#10 +
            '  NOMINATIVO, T030A.MATRICOLA, ' + OrderByIter + ', T850.DATA DESC';
  end;

  Result:=StringReplace(Result,'<:ColonneIter>',ColonneIter,[rfReplaceAll,rfIgnoreCase]);
  Result:=StringReplace(Result,'<:TabellaIter>',TabellaIter,[rfReplaceAll,rfIgnoreCase]);
  Result:=StringReplace(Result,'<:QVistaOracle>',QVistaOracle,[rfReplaceAll,rfIgnoreCase]);
  Result:=StringReplace(Result,'<:OrderByIter>',OrderByIter,[rfReplaceAll,rfIgnoreCase]);
end;

function TC018FIterAutDM.GetTagRichiesta:Integer;
// restituisce il tag del form di richiesta in base all'iter
// indicato nella property "Iter"
begin
  if Iter = ITER_MISSIONI then
    Result:=440
  else if Iter = ITER_GIUSTIF then
    Result:=406
  else if Iter = ITER_STRMESE then
    Result:=426
  else if Iter = ITER_ORARIGG then
    Result:=430
  else if Iter = ITER_TIMBR then
    Result:=418
  else if Iter = ITER_STRGIORNO then
    Result:=432
  else if Iter = ITER_CARTELLINO then
    Result:=442
  else if Iter = ITER_SCIOPERI then
    Result:=428
  else if Iter = ITER_RENDI_PROJ then
    Result:=100401
  else
    raise Exception.Create(Format('GetTagRichiesta fallito: il codice iter %s non è gestito!',[Iter]));
end;

function TC018FIterAutDM.GetTagAutorizzazione:Integer;
// restituisce il tag del form di autorizzazione in base all'iter
// indicato nella property "Iter"
begin
  if Iter = ITER_MISSIONI then
    Result:=441
  else if Iter = ITER_GIUSTIF then
    Result:=407
  else if Iter = ITER_STRMESE then
    Result:=427
  else if Iter = ITER_ORARIGG then
    Result:=431
  else if Iter = ITER_TIMBR then
    Result:=419
  else if Iter = ITER_STRGIORNO then
    Result:=433
  else if Iter = ITER_CARTELLINO then
    Result:=442
  else if Iter = ITER_SCIOPERI then
    Result:=429
  else if Iter = ITER_RENDI_PROJ then
    Result:=100402
  else
    raise Exception.Create(Format('GetTagAutorizzazione fallito: il codice iter %s non è gestito!',[Iter]));
end;

procedure TC018FIterAutDM.PreparaDataSetIter(PDataSet:TDataSet; PTipoIter:TC018TipoIter);
var wProfiloWebIterAutorizativi:String;
// prepara la query di richiesta / autorizzazione (in base a TipoIter)
// e la inserisce nel dataset indicato
begin
  selTabellaIter:=PDataSet;
  if PDataSet is TOracleDataSet then
  begin
    with (PDataSet as TOracleDataSet) do
    begin
      ClearVariables;
      DeleteVariables;
      SQL.Clear;
      if PTipoIter = tiRichiesta then
        SQL.Text:=SQLRichiestaIter
      else if PTipoIter = tiAutorizzazione then
      begin
        SQL.Text:=SQLAutorizzazioneIter;

        if (Iter = ITER_CARTELLINO) and Parametri.InibizioneIndividuale and (Parametri.ProfiloWEBIterAutorizzativi = '') then
          wProfiloWebIterAutorizativi:=T860ITER_DEFAULT
        else
          wProfiloWebIterAutorizativi:=Parametri.ProfiloWebIterAutorizzativi;

        if wProfiloWebIterAutorizativi = '' then
          raise Exception.Create(Format('Il proprio profilo web "%s" non è impostato correttamente: ' +
                                        'non è stato attribuito il profilo per gli iter autorizzativi!',
                                        [Parametri.ProfiloWeb]));
        DeclareVariable('PROFILO',otString);
        SetVariable('PROFILO',wProfiloWebIterAutorizativi);
      end;
      DeclareVariable('AZIENDA',otString);
      DeclareVariable('ITER',otString);
      DeclareVariable('DATALAVORO',otDate);
      DeclareVariable('FILTRO_PERIODO',otSubst);
      DeclareVariable('FILTRO_VISUALIZZAZIONE',otSubst);
      If Iter = ITER_RENDI_PROJ then
        DeclareVariable('FILTRO_PROGETTO',otSubst);
      // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
      DeclareVariable('FILTRO_STRUTTURA',otSubst);
      // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
      DeclareVariable('FILTRO_ALLEGATI',otSubst);
      if Pos(':FILTRO_ANAG',UpperCase(SQL.Text)) > 0 then
        DeclareVariable('FILTRO_ANAG',otSubst);
      if Pos(':FILTRO_PROGRESSIVI',UpperCase(SQL.Text)) > 0 then
        DeclareVariable('FILTRO_PROGRESSIVI',otSubst);
      SetVariable('AZIENDA',Parametri.Azienda);
      SetVariable('ITER',Iter);
      {$IFDEF IRISWEB}
      {$IFNDEF WEBSVC}
      if Parametri.VersioneOracle >= 10 then
      begin
        if (Pos(INI_PAR_C018_NO_LEADING_T030,W000ParConfig.ParametriAvanzati) = 0) then
          SQL.Text:=StringReplace(SQL.Text,'/* LEADING(T030A) */','/*+ LEADING(T030A) */',[]);
        if (Pos(INI_PAR_C018_NO_UNNEST,W000ParConfig.ParametriAvanzati) = 0) then
          SQL.Text:=StringReplace(SQL.Text,'/* UNNEST */','/*+ UNNEST */',[]);
      end
      else
      begin
        if (Pos(INI_PAR_C018_LEADING_T030,W000ParConfig.ParametriAvanzati) > 0) then
          SQL.Text:=StringReplace(SQL.Text,'/* LEADING(T030A) */','/*+ LEADING(T030A) */',[]);
        if (Pos(INI_PAR_C018_UNNEST,W000ParConfig.ParametriAvanzati) > 0) then
          SQL.Text:=StringReplace(SQL.Text,'/* UNNEST */','/*+ UNNEST */',[]);
      end;
      if Parametri.CampiRiferimento.C26_HintT030V430 <> '' then
      begin
        SQL.Text:=StringReplace(SQL.Text,'/* UNNEST */',Parametri.CampiRiferimento.C26_HintT030V430,[]);
        // chiamata <74701>.ini
        // per l'iter T325 non accoda il parametro hint personalizzato al parametro unnest, ma mantiene solo unnest
        if Iter <> ITER_STRGIORNO then
        // chiamata <74701>.fine
          SQL.Text:=StringReplace(SQL.Text,'/*+ UNNEST */',Format('/*+ %s UNNEST */',[StringReplace(StringReplace(Parametri.CampiRiferimento.C26_HintT030V430,'/*+','',[]),'*/','',[])]),[]);
      end;
      {$ENDIF}
      {$ENDIF}
      // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
      // per l'iter missioni è necessario impostare la tabella sulla quale eseguire i comandi DML
      // per via di un errore su ROWID non valido
      if Iter = ITER_MISSIONI then
      begin
        UpdatingTable:=TabellaIter;
      end;
      // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
    end;
  end;
end;

procedure TC018FIterAutDM.PutIter(Iter:String);
// gestisce le operazioni da effettuare quando si imposta la property "Iter"
var i:Integer;
    MailAut,MailDip: TC018DatiMail;
    wProfiloWebIterAutorizativi,DataCorrStr:String;
    ListaCodIter: TStringList; // MONDOEDP - commessa MAN/07 SVILUPPO#58
begin
  FIter:=Iter;
  FDescIter:='';
  if (Iter = ITER_CARTELLINO) and Parametri.InibizioneIndividuale and (Parametri.ProfiloWEBIterAutorizzativi = '') then
    wProfiloWebIterAutorizativi:=T860ITER_DEFAULT
  else
    wProfiloWebIterAutorizativi:=Parametri.ProfiloWebIterAutorizzativi;

  for i:=0 to High(A000IterAutorizzativi) do
  begin
    if Iter = A000IterAutorizzativi[i].Cod then
    begin
      FDescIter:=A000IterAutorizzativi[i].Desc;
      Break;
    end;
  end;
  FRevocabile:=False;
  FEsisteAutorizzIntermedia:=False;
  FEsisteAutorizzAutomatica:=False;
  FIterCodForm:=GetIterCodForm;
  R180SetVariable(selI093,'AZIENDA',Parametri.Azienda);
  R180SetVariable(selI093,'ITER',Iter);
  selI093.Open;
  R180SetVariable(selI094,'AZIENDA',Parametri.Azienda);
  R180SetVariable(selI094,'ITER',Iter);
  selI094.Open;
  R180SetVariable(selI095,'AZIENDA',Parametri.Azienda);
  R180SetVariable(selI095,'ITER',Iter);
  selI095.Open;
  R180SetVariable(selI096,'AZIENDA',Parametri.Azienda);
  R180SetVariable(selI096,'ITER',Iter);
  selI096.Open;
  R180SetVariable(selI097,'AZIENDA',Parametri.Azienda);
  R180SetVariable(selI097,'ITER',Iter);
  selI097.Open;
  T851F_FASE_CORRENTE.SetVariable('AZIENDA',Parametri.Azienda);
  T851F_FASE_CORRENTE.SetVariable('ITER',Iter);
  R180SetVariable(selI075,'AZIENDA',Parametri.Azienda);
  R180SetVariable(selI075,'ITER',Iter);
  R180SetVariable(selI075,'PROFILO',wProfiloWebIterAutorizativi);
  selI075.Open;
  FTipoRichiesta:='';
  // MONDOEDP - commessa MAN/07 SVILUPPO#62.ini
  FNote:='';
  // MONDOEDP - commessa MAN/07 SVILUPPO#62.fine
  FRevocabile:=selI093.FieldByName('REVOCABILE').AsString = 'S';
  {Proprietà DecodeAutIntermedia: restituisce espressione "decode(T850.COD_ITER,CodIter1,Liv1,CodIter2,Liv2,...)"}
  {Proprietà DecodeLivMaxObb:     restituisce espressione "decode(T850.COD_ITER,CodIter1,Liv1,CodIter2,Liv2,...)"}
  FDecodeAutIntermedia:='';
  FDecodeLivMaxObb:='';

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  // gestione allegati
  FEsisteGestioneAllegati:=False;
  FEsisteGestioneAllegatiCodIter:=False;
  FIDContieneAllegati:=False;
  FIDAllegatiVisibili:=False;
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

  //Per l'iter dei giustificativi, gli allegati sono abilitati anche in base alla regola sulle causali (T230)
  if Iter = ITER_GIUSTIF then
  begin
    selT230Count.Open;
    FEsisteGestioneAllegati:=selT230Count.Fields[0].AsInteger > 0;
  end;

  // ciclo sulle strutture
  selI095.First;
  while not selI095.Eof do
  begin
    //Riconoscimento Livelli max e intermedio
    CodIter:=selI095.FieldByName('COD_ITER').AsString;

    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    {$IFDEF IRISWEB}
    {$IFNDEF WEBSVC}
    // aggiunge il codice iter (struttura) alla lista
    if selI095.FieldByName('FILTRO_INTERFACCIA').AsString = 'S' then
      FStruttureDisp:=Format('%s,%s',[FStruttureDisp,CodIter]);
    {$ENDIF WEBSVC}
    {$ENDIF IRISWEB}
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    // gestione allegati
    if (R180In(Iter,[ITER_GIUSTIF,ITER_MISSIONI])) and // disponibile al momento solo su giustificativi e missioni
       //(Parametri.ModuloInstallato['PUBBL_DOCUMENTI_ESTERNI']) and
       (selI095.FieldByName('CONDIZIONE_ALLEGATI').AsString <> '') and
       (selI095.FieldByName('CONDIZIONE_ALLEGATI').AsString <> 'N') then
      FEsisteGestioneAllegati:=True;

    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

    if LivAutIntermedia > 0 then
      FDecodeAutIntermedia:=FDecodeAutIntermedia + Format(',''%s'',%d',[CodIter,LivAutIntermedia]);
    if LivMaxObb > 0 then
      FDecodeLivMaxObb:=FDecodeLivMaxObb + Format(',''%s'',%d',[CodIter,LivMaxObb]);
    //Riconoscimento Autorizzazione automatica all'ultimo livello
    if selI095.FieldByName('CONDIZ_AUTORIZZ_AUTOMATICA').AsString.Trim <> '' then
    begin
      if R180In(selI095.FieldByName('MAX_LIV_AUTORIZZ_AUTOMATICA').AsInteger,[-1,LivMaxObb]) then
        FEsisteAutorizzAutomatica:=True;
    end;
    selI095.Next;
  end;
  if FDecodeAutIntermedia <> '' then
  begin
    FDecodeAutIntermedia:=Format('decode(T850.COD_ITER%s,-1)',[FDecodeAutIntermedia]);
    FEsisteAutorizzIntermedia:=True;
  end
  else
    FDecodeAutIntermedia:='-1';
  if FDecodeLivMaxObb <> '' then
    FDecodeLivMaxObb:=Format('decode(T850.COD_ITER%s,-1)',[FDecodeLivMaxObb])
  else
    FDecodeLivMaxObb:='-1';

  FIterModificaValori:=selI096.SearchRecord('DATI_MODIFICABILI','S',[srFromBeginning]);
  FUtilizzoAvviso:=GetUtilizzoAvviso;
  FPeriodoVisual:=GetPeriodoVisual;
  FNoAccessoAut:=not (selI075.SearchRecord('ACCESSO','F',[srFromBeginning]) or
                      selI075.SearchRecord('ACCESSO','R',[srFromBeginning]));
  FNoteIndicate:=False;
  FStatoRichiesta:='';

  // R013.ini
  {$IFNDEF _IRISWEB}
  {$IFNDEF _WEBSVC}
  FTipoRichiesteDisp:=GetTipoRichiesteIni;
  FTipoRichiesteDefault:=GetTipoRichiesteDefault;
  FTipoRichiesteSel:=FTipoRichiesteDefault;
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  FStruttureDefault:=GetStruttureDefault;
  FStrutturaSel:=FStruttureDefault;
  // l'elenco delle strutture disponibili è popolato in precedenza
  // (viene inoltre incluso l'elemento speciale <Tutte>)
  FStruttureDisp:=C018STRUTTURA_TUTTE + FStruttureDisp;
  // elenco strutture disponibili per l'iter selezionato
  if FStruttureDisp <> '' then
  begin
    ListaCodIter:=TStringList.Create;
    try
      ListaCodIter.StrictDelimiter:=True;
      ListaCodIter.CommaText:=FStruttureDisp;
      ListaCodIter.Sorted:=True;
      FStruttureDisp:=ListaCodIter.CommaText;
    finally
      FreeAndNil(ListaCodIter);
    end;
  end;
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

  FPeriodo:=TPeriodo.Create(GetColonnaPeriodoInizio,GetColonnaPeriodoFine,PeriodoVisual.Dal,PeriodoVisual.Al);
  if FTipoRichiesteSel = [trDaAutorizzare] then
    FPeriodo.SetVuoto;
  FTipoVisto:=tvTutti;
  {$ENDIF}
  {$ENDIF}
  // R013.fine

  // imposta dati della mail diretta all'autorizzatore
  MailAut:=GetDatiMailPerAutorizzatore;
  selMailPerAutorizzatore.SetVariable('ITER',Iter);
  selMailPerAutorizzatore.SetVariable('TABELLA',TabellaIter);
  selMailPerAutorizzatore.SetVariable('OGGETTO',MailAut.Oggetto);
  selMailPerAutorizzatore.SetVariable('CORPO',MailAut.Corpo);
  // MONZA_HSGERARDO - chiamata 88132.ini
  // gestione variabili nell'oggetto / testo della mail
  {
  if MailAut.HasOperazione then
  begin
    if selMailPerAutorizzatore.VariableIndex('OPERAZIONE') < 0 then
      selMailPerAutorizzatore.DeclareVariable('OPERAZIONE',otString);
  end
  else
  begin
    if selMailPerAutorizzatore.VariableIndex('OPERAZIONE') >= 0 then // correzione daniloc 21.03.2012
      selMailPerAutorizzatore.DeleteVariable('OPERAZIONE');
  end;
  }
  ImpostaVariabiliDatasetMail(selMailPerAutorizzatore,MailAut);
  // MONZA_HSGERARDO - chiamata 88132.fine

  // imposta dati della mail diretta al richiedente
  MailDip:=GetDatiMailPerRichiedente;
  selMailPerRichiedente.SetVariable('ITER',Iter);
  selMailPerRichiedente.SetVariable('TABELLA',TabellaIter);
  selMailPerRichiedente.SetVariable('OGGETTO',MailDip.Oggetto);
  selMailPerRichiedente.SetVariable('CORPO',MailDip.Corpo);
  ImpostaVariabiliDatasetMail(selMailPerRichiedente,MailDip);
end;

procedure TC018FIterAutDM.ImpostaVariabiliDatasetMail(DS: TOracleQuery; PDatiMail: TC018DatiMail);
var
  NomeVar, TestoRicerca: String;
  TestoContieneVar, DSContieneVar: Boolean;
  i: Integer;
begin
  // determina il testo su cui eseguire la ricerca
  TestoRicerca:=PDatiMail.Oggetto.ToUpper + ' ' + PDatiMail.Corpo.ToUpper;

  for i:=Low(PDatiMail.VariabiliArr) to High(PDatiMail.VariabiliArr) do
  begin
    NomeVar:=PDatiMail.VariabiliArr[i].ToUpper;
    if NomeVar <> '' then
    begin
      TestoContieneVar:=R180CercaParolaIntera(Format(':%s',[NomeVar]),TestoRicerca,',;()=<>|!/+-*') > 0;
      DSContieneVar:=DS.VariableIndex(NomeVar) >= 0;
      if TestoContieneVar and not DSContieneVar then
      begin
        // dichiara la variabile nel dataset
        DS.DeclareVariable(NomeVar,otString);
      end
      else if not TestoContieneVar and DSContieneVar then
      begin
        // rimuove la dichiarazione della variabile
        DS.DeleteVariable(NomeVar);
      end;
    end;
  end;
end;

function TC018FIterAutDM.ImpostaDatiMail(const SQLOggetto, SQLCorpo: String): TC018DatiMail;
// estrae il codice SQL per effettuare la query su "TabellaIter"
// che imposta oggetto e corpo delle mail
begin
  // verifica se sono presenti oggetto / corpo definiti dall'utente per l'iter attuale
  Result.Oggetto:=IfThen(Trim(SQLOggetto) <> '',SQLOggetto,'null');
  Result.Corpo:=IfThen(Trim(SQLCorpo) <> '',SQLCorpo,'null');
end;

function TC018FIterAutDM.GetDatiMailPerAutorizzatore: TC018DatiMail;
// estrae i dati della mail diretta all'autorizzatore
var
  MailOggetto, MailCorpo: String;
  i: Integer;
begin
  // estrae oggetto / corpo definiti dall'utente per l'iter attuale
  Result:=ImpostaDatiMail(selI093.FieldByName('MAIL_OGGETTO_RESP').AsString,selI093.FieldByName('MAIL_CORPO_RESP').AsString);

  // se non tutti i dati della mail sono ridefiniti sulla I093,
  // imposta i valori di default mancanti
  if (Result.Oggetto = 'null') or (Result.Corpo = 'null') then
  begin
    // imposta default per oggetto e corpo mail
    if Iter = ITER_GIUSTIF then
    begin
      MailOggetto:='decode(:OPERAZIONE,''C'',''Annullamento richiesta '',''Richiesta '')||decode(T850.TIPO_RICHIESTA,''D'',''definitiva'',''P'',''preventiva'',''R'',''di revoca'','''')||'' di giustificativo''||'': ''||T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='''Si avvisa che è stata ''||decode(:OPERAZIONE,''C'',''annullata'',''ricevuta'')||'' una richiesta di giustificativo''||chr(13)||chr(10)||''dal dipendente in oggetto ''||' +
                 'decode(T_ITER.DAL,T_ITER.AL,''per il giorno ''||to_char(T_ITER.DAL,''dd/mm/yyyy''),''per i giorni dal ''||to_char(T_ITER.DAL,''dd/mm/yyyy'')||'' al ''||to_char(T_ITER.AL,''dd/mm/yyyy''))';
    end
    else if Iter = ITER_TIMBR then
    begin
      MailOggetto:='decode(:OPERAZIONE,''C'',''Annullamento '','''')||decode(T_ITER.OPERAZIONE,''I'',''segnalazione omessa'',''M'',''richiesta di modifica'',''C'',''richiesta di cancellazione'','''')||'' timbratura''||'': ''||T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else if Iter = ITER_ORARIGG then
    begin
      MailOggetto:='''Richiesta di cambio orario: ''||' + 'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else if Iter = ITER_STRMESE then
    begin
      MailOggetto:='''Richiesta di straordinario mensile: ''||' + 'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else if Iter = ITER_STRGIORNO then
    begin
      MailOggetto:='''Richiesta di eccedenza giornaliera: ''||' + 'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else if Iter = ITER_MISSIONI then
    begin
      MailOggetto:='decode(:OPERAZIONE,''C'',''Annullamento richiesta di missione '',''Richiesta di missione '')||' + 'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='''Si avvisa che è stata ''||decode(:OPERAZIONE,''C'',''annullata'',''ricevuta'')||'' una richiesta di missione''||chr(13)||chr(10)||''dal dipendente in oggetto ''||' +
                 'decode(T_ITER.DATADA,T_ITER.DATAA,''per il giorno ''||to_char(T_ITER.DATADA,''dd/mm/yyyy''),''per i giorni dal ''||to_char(T_ITER.DATADA,''dd/mm/yyyy'')||'' al ''||to_char(T_ITER.DATAA,''dd/mm/yyyy''))';
    end
    else if Iter = ITER_CARTELLINO then
    begin
      MailOggetto:='''Richiesta di validazione cartellino: ''||' + 'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else if Iter = ITER_SCIOPERI then
    begin
      MailOggetto:='''Richiesta di sciopero per il giorno ''||to_char(T_ITER.DATA,''dd/mm/yyyy'')'': ''||T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else if Iter = ITER_RENDI_PROJ then
    begin
      MailOggetto:='''Richiesta di rendicontazione progetto: ''||' + 'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else
      raise Exception.Create(Format('GetDatiMailPerAutorizzatore fallito: il codice iter %s non è gestito!',[Iter]));

    // imposta valori predefiniti
    if Result.Oggetto = 'null' then
      Result.Oggetto:=MailOggetto;
    if Result.Corpo = 'null' then
      Result.Corpo:=MailCorpo;
  end;
  // MONZA_HSGERARDO - chiamata 88132.ini
  // imposta l'elenco di variabili lecite nell'oggetto / testo nella mail
  //Result.HasOperazione:=Pos(':OPERAZIONE',UpperCase(Result.Oggetto + Result.Corpo)) > 0;
  for i:=Low(Result.VariabiliArr) to High(Result.VariabiliArr) do
    Result.VariabiliArr[i]:='';
  Result.VariabiliArr[0]:='OPERAZIONE';
  // MONZA_HSGERARDO - chiamata 88132.fine
end;

function TC018FIterAutDM.GetDatiMailPerRichiedente: TC018DatiMail;
// estrae i dati della mail diretta al richiedente
var
  MailOggetto, MailCorpo: String;
  i: Integer;
begin
  // estrae oggetto / corpo definiti dall'utente per l'iter attuale
  Result:=ImpostaDatiMail(selI093.FieldByName('MAIL_OGGETTO_DIP').AsString,selI093.FieldByName('MAIL_CORPO_DIP').AsString);

  // se non tutti i dati della mail sono ridefiniti sulla I093,
  // imposta i valori di default mancanti
  if (Result.Oggetto = 'null') or (Result.Corpo = 'null') then
  begin
    // imposta default per oggetto e corpo mail
    if Iter = ITER_GIUSTIF then
    begin
      MailOggetto:='''Autorizzazione ''||decode(T851.STATO,''N'',''respinta'',''concessa'')||'' per richiesta ''||decode(T850.TIPO_RICHIESTA,''D'',''definitiva'',''P'',''preventiva'',''R'',''di revoca'','''')||'' di giustificativo: ''||T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='''Si avvisa che la richiesta di seguito riportata e'''' stata ''||decode(T851.STATO,''N'',''respinta'',''concessa'')||chr(13)||chr(10)||' +
                 '''da ''||I060F_NOMINATIVO(T000F_GETAZIENDACORRENTE,T851.RESPONSABILE)||' +
                 IfThen(Parametri.ProfiloWEBDelegatoDa <> '',
                 ''', su delega di ''|| I060F_NOMINATIVO(T000F_GETAZIENDACORRENTE,:DELEGATO_DA)||') +
                 ''', in data ''||to_char(T851.DATA,''dd/mm/yyyy hh24.mi'')||'':''||chr(13)||chr(10)||' +
                 'decode(T851.NOTE,null,'''',''Note del responsabile: ''||T851.NOTE||chr(13)||chr(10))||' +
                 '''Data richiesta: ''||to_char(T850.DATA,''dd/mm/yyyy hh24.mi'')||chr(13)||chr(10)||' +
                 '''Tipo richiesta: ''||decode(T850.TIPO_RICHIESTA,''D'',''Definitiva'',''P'',''Preventiva'',''R'',''Revoca'')||chr(13)||chr(10)||' +
                 '''Periodo:        ''||decode(T_ITER.DAL,T_ITER.AL,''giorno ''||to_char(T_ITER.DAL,''dd/mm/yyyy''),''dal ''||to_char(T_ITER.DAL,''dd/mm/yyyy'')||'' al ''||to_char(T_ITER.AL,''dd/mm/yyyy''))||chr(13)||chr(10)||' +
                 '''Causale:        ''||T_ITER.CAUSALE||chr(13)||chr(10)||' +
                 '''Tipo giustif.:  ''||decode(T_ITER.TIPOGIUST,''I'',''Giornate'',''M'',''Mezze giorn.'',''N'',''Numero Ore'',''D'',''Da ore/A ore'')||'' ''||decode(T_ITER.TIPOGIUST,''N'',T_ITER.NUMEROORE,''D'',T_ITER.NUMEROORE||''-''||T_ITER.AORE,'''')||chr(13)||chr(10)||' +
                 'decode(T_ITER.DATANAS,null,'''',''Familiare rif.: ''||to_char(T_ITER.DATANAS,''dd/mm/yyyy hh24.mi''))';
    end
    else if Iter = ITER_TIMBR then
    begin
      MailOggetto:='''Autorizzazione ''||decode(T851.STATO,''N'',''respinta'',''concessa'')||'' per ''||decode(T_ITER.OPERAZIONE,''I'',''segnalazione omessa'',''M'',''richiesta di modifica'',''C'',''richiesta di cancellazione'','''')||'' timbratura: ''||' +
                   'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else if Iter = ITER_ORARIGG then
    begin
      MailOggetto:='''Autorizzazione ''||decode(T851.STATO,''N'',''respinta'',''concessa'')||'' per richiesta di cambio orario: ''||' +
                   'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else if Iter = ITER_STRMESE then
    begin
      MailOggetto:='''Autorizzazione ''||decode(T851.STATO,''N'',''respinta'',''concessa'')||'' per richiesta di straordinario mensile: ''||' +
                   'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else if Iter = ITER_STRGIORNO then
    begin
      MailOggetto:='''Autorizzazione ''||decode(T851.STATO,''N'',''respinta'',''concessa'')||'' per richiesta di eccedenza giornaliera: ''||' +
                   'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else if Iter = ITER_MISSIONI then
    begin
      MailOggetto:='''Autorizzazione ''||decode(T851.STATO,''N'',''respinta'',''concessa'')||'' per richiesta di missione: ''||' +
                   'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='''Si avvisa che la richiesta di seguito riportata e'''' stata ''||decode(T851.STATO,''N'',''respinta'',''concessa'')||chr(13)||chr(10)||' +
                 '''da ''||I060F_NOMINATIVO(T000F_GETAZIENDACORRENTE,T851.RESPONSABILE)||' +
                 IfThen(Parametri.ProfiloWEBDelegatoDa <> '',
                 ''', su delega di ''|| I060F_NOMINATIVO(T000F_GETAZIENDACORRENTE,:DELEGATO_DA)||') +
                 ''', in data ''||to_char(T851.DATA,''dd/mm/yyyy hh24.mi'')||'':''||chr(13)||chr(10)||' +
                 'decode(T851.NOTE,null,'''',''Note del responsabile: ''||T851.NOTE||chr(13)||chr(10))||' +
                 '''Data richiesta: ''||to_char(T850.DATA,''dd/mm/yyyy hh24.mi'')||chr(13)||chr(10)||' +
                 '''Periodo:        ''||decode(T_ITER.DATADA,T_ITER.DATAA,''giorno ''||to_char(T_ITER.DATADA,''dd/mm/yyyy''),''dal ''||to_char(T_ITER.DATADA,''dd/mm/yyyy'')||'' al ''||to_char(T_ITER.DATAA,''dd/mm/yyyy''))||chr(13)||chr(10)||' +
                 '''Destinazione:   ''||decode(T_ITER.FLAG_DESTINAZIONE,''R'',''Italia (regione)'',''I'',''Italia (fuori regione)'',''E'',''Estero'')||chr(13)||chr(10)||' +
                 '''Loc. partenza:  ''||M140F_GETPARTENZA(T_ITER.ID)||chr(13)||chr(10)||' +
                 '''Loc. destinaz.: ''||M140F_GETDESTINAZIONI(T_ITER.ID)||chr(13)||chr(10)||' +
                 '''Loc. rientro:   ''||M140F_GETRIENTRO(T_ITER.ID)||chr(13)||chr(10)';
    end
    else if Iter = ITER_CARTELLINO then
    begin
      MailOggetto:='''Autorizzazione ''||decode(T851.STATO,''N'',''respinta'',''concessa'')||'' per richiesta di validazione cartellino: ''||' +
                   'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else if Iter = ITER_SCIOPERI then
    begin
      MailOggetto:='''Autorizzazione ''||decode(T851.STATO,''N'',''respinta'',''concessa'')||'' per richiesta di sciopero ' +
                   'del giorno ''||to_char(T_ITER.DATADA,''dd/mm/yyyy'')|| '': ' +
                   'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else if Iter = ITER_RENDI_PROJ then
    begin
      MailOggetto:='''Autorizzazione ''||decode(T851.STATO,''N'',''respinta'',''concessa'')||'' per richiesta di rendicontazione progetto: ''||' +
                   'T030.COGNOME||'' ''||T030.NOME||'' (''||T030.MATRICOLA||'')''';
      MailCorpo:='null';
    end
    else
      raise Exception.Create(Format('GetDatiMailPerRichiedente fallito: il codice iter %s non è gestito!',[Iter]));

    // imposta valori predefiniti
    if Result.Oggetto = 'null' then
      Result.Oggetto:=MailOggetto;
    if Result.Corpo = 'null' then
      Result.Corpo:=MailCorpo;
  end;
  // MONZA_HSGERARDO - chiamata 88132.ini
  // imposta l'elenco di variabili lecite nell'oggetto / testo nella mail
  for i:=Low(Result.VariabiliArr) to High(Result.VariabiliArr) do
    Result.VariabiliArr[i]:='';
  Result.VariabiliArr[0]:='DELEGATO_DA';
  // MONZA_HSGERARDO - chiamata 88132.fine
end;

function TC018FIterAutDM.GetPeriodoVisual:TPeriodoVisual;
// estrae il periodo di default da proporre in base alla configurazione
// dell'iter specificato nella property "Iter"
begin
  Result.Dal:=DATE_MIN;
  Result.Al:=DATE_MAX;
  if Trim(selI093.FieldByName('EXPR_PERIODO_VISUAL').AsString) = '' then
    exit;

  with selDualExprRichiesta do
  begin
    SQL.Text:=Format('select %s from DUAL',[selI093.FieldByName('EXPR_PERIODO_VISUAL').AsString]);
    try
      Execute;
      Result.Dal:=Trunc(FieldAsDate(0));
      if selDualExprRichiesta.FieldCount > 1 then
        Result.Al:=Trunc(FieldAsDate(1));
    except
    end;
  end;
end;

{$IFNDEF _IRISWEB}
{$IFNDEF _WEBSVC}
function TC018FIterAutDM.GetFiltroGruppo(const PGruppo: Integer): String;
// determina il filtro generico per il gruppo indicato all'interno dell'iter
var
  i: Integer;
begin
  Result:='';
  for i:=Low(TIPORICHIESTE_GRUPPI) to High(TIPORICHIESTE_GRUPPI) do
  begin
    if (TIPORICHIESTE_GRUPPI[i].Iter = Iter) and
       (TIPORICHIESTE_GRUPPI[i].IdGruppo = PGruppo) then
    begin
      Result:=TIPORICHIESTE_GRUPPI[i].Filtro;
      Break;
    end;
  end;
end;

function TC018FIterAutDM.IndexOfTipoRichiesta(const PTipoRichiesta: TTipoRichieste): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=Low(FTipoRichiesteDati) to High(FTipoRichiesteDati) do
  begin
    if PTipoRichiesta = FTipoRichiesteDati[i].TipoRich then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

function TC018FIterAutDM.GetFiltroRichiesta(const PTipoRichiesta: TTipoRichieste): String;
// restituisce il codice SQL per il filtro del dataset
// in base alla tipologia di richiesta
var
  idx: Integer;
begin
  idx:=IndexOfTipoRichiesta(PTipoRichiesta);
  if idx = -1 then
    Result:=''
  else
  begin
    if Responsabile then
      Result:=FTipoRichiesteDati[idx].FiltroResp
    else
      Result:=FTipoRichiesteDati[idx].FiltroDip;
  end;
end;

procedure TC018FIterAutDM.SetFiltroRichiesta(const PTipoRichiesta:TTipoRichieste; const Val: String);
var
  idx: Integer;
  S: String;
begin
  // impedisce l'impostazione del filtro "tutte" se la modalità non è esclusiva
  if (PTipoRichiesta = trTutte) and (not IsSceltaEsclusivaTipoRichieste) then
    raise Exception.Create('Impossibile impostare il filtro richieste per la voce "Tutte" in modalità non esclusiva!');

  idx:=IndexOfTipoRichiesta(PTipoRichiesta);
  if idx > -1 then
  begin
    S:=Trim(R180EliminaSpaziMultipli(Val));
    if Responsabile then
      FTipoRichiesteDati[idx].FiltroResp:=S
    else
      FTipoRichiesteDati[idx].FiltroDip:=S;
  end;
end;

function TC018FIterAutDM.GetFiltroRichiestaClient(const PTipoRichiesta: TTipoRichieste): String;
// restituisce il codice per il filtro del clientdataset
// in base alla tipologia di richiesta
var
  idx: Integer;
begin
  idx:=IndexOfTipoRichiesta(PTipoRichiesta);
  if idx = -1 then
    Result:=''
  else
  begin
    if Responsabile then
      Result:=FTipoRichiesteDati[idx].FiltroClientResp
    else
      Result:=FTipoRichiesteDati[idx].FiltroClientDip;
  end;
end;

procedure TC018FIterAutDM.SetFiltroRichiestaClient(const PTipoRichiesta:TTipoRichieste; const Val: String);
var
  idx: Integer;
  S: String;
begin
  // impedisce l'impostazione del filtro "tutte" se la modalità non è esclusiva
  if (PTipoRichiesta = trTutte) and (not IsSceltaEsclusivaTipoRichieste) then
    raise Exception.Create('Impossibile impostare il filtro richieste per la voce Tutte in modalità non esclusiva!');

  idx:=IndexOfTipoRichiesta(PTipoRichiesta);
  if idx > -1 then
  begin
    S:=Trim(R180EliminaSpaziMultipli(Val));
    if Responsabile then
      FTipoRichiesteDati[idx].FiltroClientResp:=S
    else
      FTipoRichiesteDati[idx].FiltroClientDip:=S;
  end;
end;

function TC018FIterAutDM.GetFiltroRichiestaGruppo(const PTipoRichiesta: TTipoRichieste): String;
// restituisce la stringa di sostituzione da utilizzare nel filtro gruppo
// in base al tipo richiesta indicato
var
  i: Integer;
begin
  Result:='';
  for i:=Low(TIPORICHIESTE_GRUPPI_DETT) to High(TIPORICHIESTE_GRUPPI_DETT) do
  begin
    if (TIPORICHIESTE_GRUPPI_DETT[i].Iter = Iter) and
       (TIPORICHIESTE_GRUPPI_DETT[i].TipoRich = PTipoRichiesta) then
    begin
      Result:=TIPORICHIESTE_GRUPPI_DETT[i].FiltroSost;
      Break;
    end;
  end;
end;

function TC018FIterAutDM.GetGruppoRichiesta(const PTipoRichiesta:TTipoRichieste): Integer;
// determina il gruppo di appartenenza del tipo richiesta indicato
// all'interno dell'iter di riferimento
var
  i: Integer;
begin
  Result:=-1;
  for i:=Low(TIPORICHIESTE_GRUPPI_DETT) to High(TIPORICHIESTE_GRUPPI_DETT) do
  begin
    if (TIPORICHIESTE_GRUPPI_DETT[i].Iter = Iter) and
       (TIPORICHIESTE_GRUPPI_DETT[i].TipoRich = PTipoRichiesta) then
    begin
      Result:=TIPORICHIESTE_GRUPPI_DETT[i].IdGruppo;
      Break;
    end;
  end;
end;

function TC018FIterAutDM.IsSetCompleto(const PGruppo: Integer; PTipoRichiesteSet:TTipoRichiesteSet): Boolean;
// restituisce True se il set indicato rappresenta il set completo del gruppo PGruppo
// False altrimenti
var
  i: Integer;
  GruppoCompleto: TTipoRichiesteSet;
begin
  GruppoCompleto:=[];
  for i:=Low(TIPORICHIESTE_GRUPPI_DETT) to High(TIPORICHIESTE_GRUPPI_DETT) do
  begin
    if (TIPORICHIESTE_GRUPPI_DETT[i].Iter = Iter) and
       (TIPORICHIESTE_GRUPPI_DETT[i].IdGruppo = PGruppo) then
      GruppoCompleto:=GruppoCompleto + [TIPORICHIESTE_GRUPPI_DETT[i].TipoRich];
  end;
  Result:=(PTipoRichiesteSet = GruppoCompleto);
end;

function TC018FIterAutDM.GetCombinazioneGruppo(const PGruppo: Integer): String;
var
  Elem: TTipoRichieste;
  GruppoSet: TTipoRichiesteSet;
  conta: Integer;
  FSingolo,S: String;
begin
  Result:='';

  // filtro vuoto se il numero del gruppo non è valido
  if PGruppo <= 0 then
    Exit;

  // tipologie del gruppo indicato
  GruppoSet:=grArr[PGruppo];

  // filtro vuoto se nessun elemento del filtro è selezionato
  if GruppoSet = [] then
    Exit;

  // filtro vuoto se tutti gli elementi dei filtro sono selezionati
  if IsSetCompleto(PGruppo,GruppoSet) then
    Exit;

  // esamina le tipologie del gruppo selezionate
  S:='';
  conta:=0;
  for Elem in GruppoSet do
  begin
    S:=S + FiltroRichiestaGruppo[Elem] + ',';
    FSingolo:=FiltroRichiesta[Elem];
    inc(conta);
  end;
  // combinazioni richieste
  if (conta = 1) and (FSingolo <> '') then
  begin
    // se il gruppo è composto da un solo elemento che ha un filtro richiesta indicato
    // utilizza questo e non e non quello del gruppo
    Result:=FSingolo;
  end
  else
  begin
    S:=Copy(S,1,Length(S) - 1);
    if Pos(',',S) = 0 then
      S:=' = ' + S
    else
      S:=' in (' + S + ')';

    // filtro combinato
    Result:=Format(GetFiltroGruppo(PGruppo),[S]);
  end;
end;

function TC018FIterAutDM.GetFiltroRichieste:String;
var
  Elem: TTipoRichieste;
  S: String;
  i,g: Integer;
begin
  Result:='';

  // valuta il caso particolare della tipologia "tutte"
  // se la selezione delle richieste è esclusiva, esce subito (filtro vuoto)
  // altrimenti continua il normale flusso, valutando l'eventuale filtro impostato per il tipo trTutte
  if (trTutte in TipoRichiesteSel) and (not TipoRichiesteEsclusivo) then
    Exit;

  // pulizia array di supporto
  for i:=0 to TIPORICHIESTE_NUMGRUPPI do
    grArr[i]:=[];

  // se tipo richieste esclusivo l'insieme avrà un solo elemento
  // altrimenti verifica se è necessario considerare i filtri in "or"
  // oppure considerare la gestione dei gruppi di filtri
  for Elem in TipoRichiesteSel do
  begin
    S:=FiltroRichiesta[Elem];
    if S <> '' then
    begin
      if TipoRichiesteEsclusivo then
      begin
        Result:=Format(' and (%s)',[S]);
        Break;
      end
      else
      begin
        // verifica esistenza filtro di gruppo
        g:=GruppoRichiesta[Elem];
        if g = -1 then
          Result:=Result + Format('(%s) or ',[S])
        else
          grArr[g]:=grArr[g] + [Elem];
      end;
    end
    else
    begin
      // verifica esistenza filtro di gruppo
      g:=GruppoRichiesta[Elem];
      if g <> -1 then
        grArr[g]:=grArr[g] + [Elem];
    end;
  end;

  // caso di tipologie multiple
  if (not TipoRichiesteEsclusivo) and (Result <> '') then
  begin
    Result:=Copy(Result,1,Length(Result) - 4);
    Result:=Format(' and (%s)',[Result]);
  end;

  // gestione dei gruppi di filtri
  for i:=1 to TIPORICHIESTE_NUMGRUPPI do
  begin
    S:=GetCombinazioneGruppo(i);
    if S <> '' then
      Result:=Result + Format(' and (%s)',[S]);
  end;

  // caso del tipo richieste "annullate" non selezionato
  if (trAnnullate in TipoRichiesteDisp) and
     (not (trAnnullate in TipoRichiesteSel)) then
    Result:=Result + Format(' and (%s)',[FILTRO_ESCLUDI_ANNULLATE]);

  // se è previsto l'avviso, viene incluso il filtro relativo ai visti precedenti
  if Responsabile and UtilizzoAvviso then
    Result:=Result + ' ' + FiltroVisto;
end;

function TC018FIterAutDM.GetFiltroRichiesteClient:String;
var
  Elem: TTipoRichieste;
  S: String;
begin
  Result:='';

  // valuta il caso particolare della tipologia "tutte"
  // se la selezione delle richieste è esclusiva, esce subito (filtro vuoto)
  // altrimenti continua il normale flusso, valutando l'eventuale filtro impostato per il tipo trTutte
  if (trTutte in TipoRichiesteSel) and (not TipoRichiesteEsclusivo) then
    Exit;

  // se tipo richieste esclusivo l'insieme avrà un solo elemento
  for Elem in TipoRichiesteSel do
  begin
    S:=FiltroRichiestaClient[Elem];
    if S <> '' then
      Result:=Result + Format(IfThen(TipoRichiesteEsclusivo,'%s','(%s) or '),[S]);
  end;

  if (not TipoRichiesteEsclusivo) and (Result <> '') then
    Result:=Copy(Result,1,Length(Result) - 4);

  // caso del tipo richieste "annullate" non selezionato
  if (trAnnullate in TipoRichiesteDisp) and
     (not (trAnnullate in TipoRichiesteSel)) then
    Result:=Result + IfThen(Result <> '',' and ') + Format('(%s)',[FILTROCLIENT_ESCLUDI_ANNULLATE]);
end;

function TC018FIterAutDM.GetFiltroVisto: String;
const
  FILTRO_FMT = 'and exists (select ''X'' from dual where T851F_AVVISO_LIVPREC(:AZIENDA, :PROFILO, :ITER, T850.COD_ITER, T850.ID) = ''%s'')';
begin
  case FTipoVisto of
    tvVisto:
      Result:=Format(FILTRO_FMT,['N']);
    tvNoVisto:
      Result:=Format(FILTRO_FMT,['S']);
  else
    Result:='';
  end;
end;

// MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
function TC018FIterAutDM.GetFiltroStruttura: String;
// restituisce il filtro SQL-like per filtrare le richieste con il COD_ITER selezionato
begin
  if FStrutturaSel = C018STRUTTURA_TUTTE then
  begin
    // nessun filtro
    Result:='';
  end
  else
  begin
    // filtro su struttura selezionata
    Result:=Format('and T850.COD_ITER = ''%s''',[FStrutturaSel]);
  end;
end;
// MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

function TC018FIterAutDM.GetFiltroAllegati: String;
// restituisce il filtro SQL-like per filtrare le richieste in base alla presenza di allegati
var CodAllegato, CodCondAllegato: String;
begin
  CodAllegato:='';
  case FRichiesteConAllegati of
    raTutte: CodAllegato:='';
    raConAllegati: CodAllegato:='>';
    raSenzaAllegati: CodAllegato:='=';
  end;
  CodAllegato:=IfThen(CodAllegato <> '',Format('and exists (select ''X'' from dual where T853F_NUMALLEGATI(T850.ID) %s 0)', [CodAllegato]));

  CodCondAllegato:='';
  case FCondizioneAllegati of
    caTutte: CodCondAllegato:='';
    caNonPrevisti: CodCondAllegato:=Format(' and nvl(T850.CONDIZ_ALLEGATI,''N'') = ''%s''',['N']);
    caFacoltativi: CodCondAllegato:=Format(' and nvl(T850.CONDIZ_ALLEGATI,''N'') = ''%s''',['F']);
    caObbligatori: CodCondAllegato:=Format(' and nvl(T850.CONDIZ_ALLEGATI,''N'') = ''%s''',['O']);
  end;

  Result:=CodAllegato + CodCondAllegato;
end;

function TC018FIterAutDM.GetTipoRichiesteIni:TTipoRichiesteSet;
// restituisce il set di filtri richiesta selezionabili da proporre inizialmente
// in base all'iter specificato nella property "Iter"
begin
  // filtri standard
  Result:=[trDaAutorizzare,trAutorizzate,trNegate,trTutte];

  // richieste negate è nascosto se è presente un solo valore
  // possibile in tutti i livelli dell'iter
  // (quindi se non è prevista una autorizzazione negativa)
  if MaxValoriPossibili <= 1 then
    Result:=Result - [trNegate];

  // filtri specifici per ogni iter
  if Iter = ITER_MISSIONI then
  begin
    Result:=Result + [trRegione,trFuoriRegione,trEstero,trIspettive,trNonIspettive,trRimbDaAutorizzare,trRimbDaLiquidare,trRimbLiquidati,trAnnullate];
  end
  else if Iter = ITER_GIUSTIF then
  begin
    if Responsabile then
    begin
      if FEsisteAutorizzAutomatica then
        Result:=Result + [trAutorizzAuto];
      // ROMA_HSANTANDREA - chiamata 82505.ini
      // si chiede di visualizzare le richieste revocate anche lato responsabile
      if FRevocabile then
        Result:=Result + [trRevocate];
      // ROMA_HSANTANDREA - chiamata 82505.fine
    end
    else
    begin
      if FEsisteAutorizzIntermedia then
        Result:=Result + [trDaDefinire];
      if FRevocabile then
        Result:=Result + [trRevocate];
    end;
  end
  else if Iter = ITER_STRMESE then
  begin
    if Responsabile then
      Result:=Result + [trValidate,trNonAutorizzabili]
    else
      Result:=Result + [trRichiedibili,trValidate,trNonAutorizzabili];
    if FIterModificaValori then
      Result:=Result + [trInAutorizzazione];
  end
  else if Iter = ITER_ORARIGG then
    Result:=Result
  else if Iter = ITER_TIMBR then
  begin
    if Responsabile and FEsisteAutorizzAutomatica then
      Result:=Result + [trAutorizzAuto];
  end
  else if Iter = ITER_STRGIORNO then
  begin
    if not Responsabile then
    begin
      if Parametri.CampiRiferimento.C90_W026TipoRichiesta = 'A' then
        Result:=[trDaEffettuare,trAutorizzate,trAnnullate,trTutte]
      else
        Result:=[trTutte];
    end;
  end
  else if Iter = ITER_CARTELLINO then
  begin
    // il dipendente ha accesso al primo livello di autorizzazione
    if Parametri.InibizioneIndividuale then
      Result:=Result + [trDaAutFinale,trAutFinale];
  end
  else if Iter = ITER_SCIOPERI then
  begin
    if Responsabile then
    begin
      if FEsisteAutorizzAutomatica then
        Result:=Result + [trAutorizzAuto];
    end;
  end
  else if Iter = ITER_RENDI_PROJ then
  begin
    if Responsabile then
    begin
      if FEsisteAutorizzAutomatica then
        Result:=Result + [trAutorizzAuto];
    end
    else
      Result:=Result - [trNegate];
  end
  else
  begin
    // iter inesistente
    raise Exception.Create(Format('GetTipoRichiesteIni fallito: l''iter %s non è gestito!',[Iter]));
  end;
end;

function TC018FIterAutDM.GetTipoRichiesteDisp:TTipoRichiesteSet;
begin
  Result:=FTipoRichiesteDisp;
end;

procedure TC018FIterAutDM.SetTipoRichiesteDisp(const Val:TTipoRichiesteSet);
begin
  // mantiene coerente l'insieme dei tipi richiesta selezionati
  // in modo che risulti compreso in quello delle richieste disponibili
  if not (FTipoRichiesteSel <= Val) then
  begin
    // intersezione fra i due insiemi
    FTipoRichiesteSel:=FTipoRichiesteSel * Val;
  end;

  FTipoRichiesteDisp:=Val;
end;

function TC018FIterAutDM.GetTipoRichiesteDefault:TTipoRichiesteSet;
// restituisce il set di filtri richiesta da proporre inizialmente come selezionati
// in base all'iter specificato nella property "Iter"
// ATTENZIONE: il set da proporre deve essere un sottoinsieme dei tipi
//             restituiti da GetTipoRichiesteIni
begin
  if Iter = ITER_MISSIONI then
  begin
    Result:=FTipoRichiesteDisp - [trAnnullate,trAutorizzate,trNegate,trTutte];
  end
  else if Iter = ITER_GIUSTIF then
  begin
    Result:=[trDaAutorizzare];
    // AOSTA_REGIONE.ini
    // nel default considera anche le richieste da definire - daniloc. 29.10.2012
    if (not Responsabile) and FEsisteAutorizzIntermedia then
      Result:=Result + [trDaDefinire];
    // AOSTA_REGIONE.fine
  end
  else if Iter = ITER_STRMESE then
  begin
    if Responsabile then
    begin
      Result:=[trDaAutorizzare,trValidate];
      if IterModificaValori then
        Result:=Result + [trInAutorizzazione];
    end
    else
    begin
      Result:=[trRichiedibili];
    end;
  end
  else if Iter = ITER_ORARIGG then
  begin
    Result:=[trDaAutorizzare];
  end
  else if Iter = ITER_TIMBR then
  begin
    Result:=[trDaAutorizzare];
  end
  else if Iter = ITER_STRGIORNO then
  begin
    if not Responsabile then
    begin
      if Parametri.CampiRiferimento.C90_W026TipoRichiesta = 'A' then
        Result:=[trDaEffettuare]
      else
        Result:=[trTutte];
    end
    else
    begin
      Result:=[trDaAutorizzare];
    end;
  end
  else if Iter = ITER_CARTELLINO then
  begin
    Result:=[trDaAutorizzare];
  end
  else if Iter = ITER_SCIOPERI then
  begin
    Result:=[trDaAutorizzare];
  end
  else if Iter = ITER_RENDI_PROJ then
  begin
    if Responsabile then
      Result:=[trDaAutorizzare]
    else
      Result:=[trDaAutorizzare,trAutorizzate,trTutte];
  end
  else
    raise Exception.Create(Format('GetTipoRichiesteDefault fallito: l''iter %s non è gestito!',[Iter]));

  // eccezione se l'insieme di tipi indicato non è un sottoinsieme dei tipi disponibili
  if not (Result <= FTipoRichiesteDisp) then
  begin
    Result:=[];
    raise Exception.Create('[C018] Elenco default tipologie richieste non valido!');
  end;
end;

function TC018FIterAutDM.GetTipoRichiesteSel: TTipoRichiesteSet;
begin
  Result:=FTipoRichiesteSel;
end;

procedure TC018FIterAutDM.SetTipoRichiesteSel(const Val: TTipoRichiesteSet);
var
  Elem: TTipoRichieste;
  conta: Integer;
begin
  if not (Val <= FTipoRichiesteDisp) then
    raise Exception.Create('[C018] Elenco tipologie richieste selezionate non valido!');

  if IsSceltaEsclusivaTipoRichieste then
  begin
    // se tipologia richieste esclusiva, verifica che sia presente un solo elemento nel set
    conta:=0;
    for Elem in Val do
      inc(conta);
    if conta > 1 then
      raise Exception.Create('[C018] Impossibile selezionare più di una tipologia di richieste!');
  end;

  FTipoRichiesteSel:=Val;
end;

// MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
function TC018FIterAutDM.GetStruttureDisp: String;
begin
  Result:=FStruttureDisp;
end;

procedure TC018FIterAutDM.SetStruttureDisp(const Val: String);
begin
  // controllo valore
  if Val = '' then
    raise Exception.Create('[C018] L''elenco di strutture disponibili non può essere vuoto!');

  if R180CercaParolaIntera(C018STRUTTURA_TUTTE,Val,',') = -1 then
    raise Exception.Create(Format('[C018] L''elenco di strutture disponibili deve contenere la tipologia speciale %s',[C018STRUTTURA_TUTTE]));

  // mantiene coerente l'insieme delle strutture selezionate
  // in modo che risulti compreso in quello delle strutture disponibili
  if R180CercaParolaIntera(FStrutturaSel,Val,',') = -1 then
    FStrutturaSel:=C018STRUTTURA_TUTTE;

  FStruttureDisp:=Val;
end;

function TC018FIterAutDM.GetStruttureDefault: String;
begin
  Result:=C018STRUTTURA_STANDARD;
end;

function TC018FIterAutDM.GetStrutturaSel: String;
begin
  Result:=FStrutturaSel;
end;

procedure TC018FIterAutDM.SetStrutturaSel(const Val: String);
var
  LstTemp: TStringList;
begin
  if R180CercaParolaIntera(Val,FStruttureDisp,',') = -1 then
    raise Exception.Create(Format('[C018] La struttura selezionata non è valida: %s!',[Val]));

  // al momento è gestito solo il caso in cui la struttura selezionata è una sola
  if IsSceltaEsclusivaStrutture then
  begin
    // se il filtro strutture è esclusivo, verifica che sia presente un solo elemento nel set
    LstTemp:=TStringList.Create;
    try
      LstTemp.StrictDelimiter:=True;
      LstTemp.CommaText:=Val;
      if LstTemp.Count > 1 then
        raise Exception.Create('[C018] Impossibile selezionare più di una struttura!');
    finally
      FreeAndNil(LstTemp);
    end;
  end;

  FStrutturaSel:=Val;
end;
// MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

function TC018FIterAutDM.GetTipoRichiestaNome(const PTipoRichiesta:TTipoRichieste):String;
var
  idx: Integer;
begin
  idx:=IndexOfTipoRichiesta(PTipoRichiesta);
  if idx = -1 then
    Result:=''
  else
    Result:=FTipoRichiesteDati[idx].Nome;
end;

function TC018FIterAutDM.GetTipoRichiestaCaption(const PTipoRichiesta:TTipoRichieste):String;
// estrae la caption del tipo richiesta indicato
var
  idx: Integer;
begin
  idx:=IndexOfTipoRichiesta(PTipoRichiesta);
  if idx = -1 then
    Result:=''
  else
    Result:=FTipoRichiesteDati[idx].Caption;
end;

procedure TC018FIterAutDM.SetTipoRichiestaCaption(const PTipoRichiesta:TTipoRichieste; const Val: String);
// imposta la caption del tipo richiesta indicato
var
  idx: Integer;
begin
  idx:=IndexOfTipoRichiesta(PTipoRichiesta);
  if idx > -1 then
    FTipoRichiesteDati[idx].Caption:=Val;
end;

function TC018FIterAutDM.IsSceltaEsclusivaTipoRichieste: Boolean;
// indica se la scelta del tipo richieste da considerare nel filtro
// è esclusiva (True, ovvero se è possibile filtrare una sola tipologia per volta)
// oppure no (False)
begin
  if Iter = ITER_MISSIONI then
    Result:=False
  else if Iter = ITER_GIUSTIF then
    Result:=False
  else if Iter = ITER_STRMESE then
    Result:=False
  else if Iter = ITER_ORARIGG then
    Result:=False
  else if Iter = ITER_TIMBR then
    Result:=False
  else if Iter = ITER_STRGIORNO then
    Result:=True
  else if Iter = ITER_CARTELLINO then
    Result:=False
  else if Iter = ITER_SCIOPERI then
    Result:=False
  else if Iter = ITER_RENDI_PROJ then
    Result:=False
  else
    raise Exception.Create(Format('IsSceltaEsclusivaTipoRichieste fallito: il codice iter %s non è gestito!',[Iter]));
end;

// MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
function TC018FIterAutDM.IsSceltaEsclusivaStrutture: Boolean;
// indica se la scelta del codice struttura da considerare nel filtro
// è esclusiva (True)
// oppure no   (False)
begin
  // al momento è possibile solo la scelta esclusiva
  // per consentire una scelta multipla è necessario gestire l'interfaccia
  // in modo opportuno nella unit R013UIterBase
  Result:=True;
end;
// MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
{$ENDIF}
{$ENDIF}

function TC018FIterAutDM.GetUtilizzoAvviso: Boolean;
// Restituisce True se si verifica questa condizione:
//   ciclo sui livelli disponibili in base al proprio profilo
//     per ogni codice struttura esegue queste considerazioni:
//       per ogni livello abilitato (Li), ovvero i livelli con accesso 'F'
//       - estrae il livello obbligatorio immediatamente precedente (LiOP)
//         se questo non esiste utilizza convenzionalmente il livello 0
//       - se tra il livello Li e il livello LiOP esiste un livello con Avviso = 'S'
//         questa funzione restituisce True
// Altrimenti viene restituito False
var
  LCodIter: String;
  LRecNo,LLivAtt,LLivOP,i: Integer;
begin
  Result:=False;

  // se non sono presenti livelli con Avviso = 'S' restituisce False
  if not selI096.SearchRecord('AVVISO','S',[srFromBeginning]) then
    Exit;

  // ciclo sui livelli disponibili in base al proprio "profilo iter"
  // ordinati per codice struttura (cod. iter) + livello
  if selI075.SearchRecord('ACCESSO','F',[srFromBeginning]) then
  begin
    repeat
      // imposta livello e struttura attuali
      LLivAtt:=selI075.FieldByName('LIVELLO').AsInteger;
      LCodIter:=selI075.FieldByName('COD_ITER').AsString;

      // determina livello obbligatorio precedente
      // (solo se il livello attuale non è il primo)
      LRecNo:=selI075.RecNo; // serve per riposizionamento successivo dopo searchrecord
      if selI075.SearchRecord('COD_ITER;OBBLIGATORIO',VarArrayOf([LCodIter,'S']),[srBackward]) then
        LLivOP:=selI075.FieldByName('LIVELLO').AsInteger
      else
      begin
        LLivOP:=0;
        LRecNo:=-1;
      end;

      // se tra il livello attuale e il livello obbligatorio precedente (esclusi)
      // esiste un livello con Avviso = 'S' restituisce True
      for i:=LLivOP + 1 to LLivAtt - 1 do
        if VarToStr(selI075.Lookup('COD_ITER;LIVELLO',VarArrayOf([LCodIter,i]),'AVVISO')) = 'S' then
        begin
          Result:=True;
          Break;
        end;
      if Result then
        Break;

      // riposiziona il dataset sul livello attuale se necessario
      if LRecNo <> -1 then
        selI075.RecNo:=LRecNo;
    until not selI075.SearchRecord('ACCESSO','F',[]);
  end;
end;

procedure TC018FIterAutDM.PutCodIter(CodIter:String);
var
  LstValori: TStringList;
  c: Integer;
  CondizAlleg: String;
begin
  FCodIter:=CodIter;

  // descrizione struttura (se vuota utilizza il codice iter)
  FDescCodIter:='';
  if selI095.Active then
    FDescCodIter:=VarToStr(selI095.Lookup('COD_ITER',FCodIter,'DESCRIZIONE'));
  if FDescCodIter = '' then
    FDescCodIter:=FCodIter;

  //Proprietà LivMaxObb: Lettura max livello obbligatorio
  FLivMaxObb:=-1;
  if selI096.Active then
  begin
    if selI096.SearchRecord('COD_ITER;OBBLIGATORIO',VarArrayOf([CodIter,'S']),[srFromEnd]) then
      FLivMaxObb:=selI096.FieldByName('LIVELLO').AsInteger;
  end;

  // imposta proprietà
  // - MaxValoriPossibili: numero massimo di valori possibili per l'iter
  // - LivMinAllegatiObbligatori: livello minimo per cui gli allegati sono obbligatori (-1 se non previsto)
  FLivMinAllegatiObbligatori:=-1;
  FMaxValoriPossibili:=0;
  if selI096.Active then
  begin
    LstValori:=TStringList.Create;
    try
      selI096.First;
      while not selI096.Eof do
      begin
        try
          LstValori.CommaText:=selI096.FieldByName('VALORI_POSSIBILI').AsString;
          c:=LstValori.Count;
        except
          c:=0;
        end;
        if c > FMaxValoriPossibili then
          FMaxValoriPossibili:=c;

        if (selI096.FieldByName('COD_ITER').AsString = FCodIter) and
           (FLivMinAllegatiObbligatori = -1) and
           (selI096.FieldByName('ALLEGATI_OBBLIGATORI').AsString = 'S') then
        begin
          FLivMinAllegatiObbligatori:=selI096.FieldByName('LIVELLO').AsInteger;
        end;

        selI096.Next;
      end;
    finally
      LstValori.Free;
    end;
  end;

  //Proprietà LivAutIntermedia e ValAutIntermedia: Lettura livello di autorizzazione intermedia (preventiva) e relativo valore
  FLivAutIntermedia:=-1;
  FValAutIntermedia:='';
  if selI096.Active then
  begin
    if selI096.SearchRecord('COD_ITER',FCodIter,[srFromBeginning]) then
      repeat
        if selI096.FieldByName('AUTORIZZ_INTERMEDIA').AsString <> '' then
        begin
          FLivAutIntermedia:=selI096.FieldByName('LIVELLO').AsInteger;
          FValAutIntermedia:=selI096.FieldByName('AUTORIZZ_INTERMEDIA').AsString;
          Break;
        end;
      until not selI096.SearchRecord('COD_ITER',CodIter,[]);
  end;

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  FEsisteGestioneAllegatiCodIter:=False;
  if (FEsisteGestioneAllegati) and
     (selI095.Active) then
  begin
    CondizAlleg:=VarToStr(selI095.Lookup('COD_ITER',FCodIter,'CONDIZIONE_ALLEGATI'));
    FEsisteGestioneAllegatiCodIter:=(CondizAlleg <> '') and (CondizAlleg <> 'N');
    if not FEsisteGestioneAllegatiCodIter and (FIter = ITER_GIUSTIF) and (selT230Count.Active) then
      FEsisteGestioneAllegatiCodIter:=selT230Count.Fields[0].AsInteger > 0;
  end;
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
end;

procedure TC018FIterAutDM.PutID(const PId:Integer);
begin
  FId:=PId;
  FTipoRichiesta:='';
end;

function TC018FIterAutDM.GetMaxValoriPossibili: Integer;
// max numero di valori possibili per l'iter (considera tutte le strutture)
begin
  Result:=FMaxValoriPossibili;
end;

function TC018FIterAutDM.GetNumValoriPossibili(Livello:Integer):Integer;
// numero di valori possibili del livello indicato
// PRE: CodIter impostato
begin
  with TStringList.Create do
  begin
    try
      try
        CommaText:=VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VararrayOf([CodIter,Livello]),'VALORI_POSSIBILI'));
        Result:=Count;
      except
        Result:=0;
      end;
    finally
      Free;
    end;
  end;
end;

function TC018FIterAutDM.GetValoriPossibili(Livello:Integer):String;
// restituisce i valori di autorizzazione possibili del livello indicato per l'iter e il codice iter definiti
// PRE: CodIter impostato
begin
  Result:=VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,Livello]),'VALORI_POSSIBILI'));
end;

function TC018FIterAutDM.GetDescLivello(PLivello: Integer): String;
// restituisce la descrizione del livello indicato per l'iter e il codice iter definiti
// PRE: CodIter impostato
begin
  if PLivello = 0 then
  begin
    Result:='Richiesta';
  end
  else
  begin
    // descrizione livello: se non è indicata restituisce il numero del livello
    Result:=VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,Abs(PLivello)]),'DESC_LIVELLO'));
    if Result = '' then
      Result:=PLivello.ToString;
  end;
end;

function TC018FIterAutDM.GetAllegatiVisibili(PLivello: Integer): String;
// restituisce il flag di visibilità allegati del livello indicato per l'iter e il codice iter definiti
// PRE: CodIter impostato
begin
  if PLivello = 0 then
  begin
    // richiedente: allegati sempre visibili
    Result:='S';
  end
  else
  begin
    // autorizzatore: ricerca il flag per il livello
    Result:=VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,Abs(PLivello)]),'ALLEGATI_VISIBILI'));
  end;
end;

function TC018FIterAutDM.GetAllegatiObbligatori(PLivello: Integer): String;
// restituisce il flag di obbligatorietà allegati del livello indicato per l'iter e il codice iter definiti
// PRE: CodIter impostato
begin
  if PLivello = 0 then
  begin
    // richiedente: allegati sempre obbligatori
    Result:='S';
  end
  else
  begin
    // autorizzatore: ricerca il flag per il livello
    Result:=VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,Abs(PLivello)]),'ALLEGATI_OBBLIGATORI'));
  end;
end;

function TC018FIterAutDM.GetFaseLivello(PLivello:Integer):Integer;
// restituisce la fase corrispondente al livello indicato per l'iter e il codice iter definiti
// PRE: CodIter impostato
begin
  if PLivello = 0 then
    Result:=0
  else
    Result:=StrToIntDef(VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VararrayOf([CodIter,Abs(PLivello)]),'FASE')),0);
end;

function TC018FIterAutDM.GetEsisteFase(Fase:Integer):Boolean;
// restituisce True se è prevista la fase indicata per l'iter e il codice iter definiti
// PRE: CodIter impostato
begin
  Result:=selI096.SearchRecord('COD_ITER;FASE',VararrayOf([CodIter,Fase]),[srFromBeginning]);
end;

function TC018FIterAutDM.GetLivelliFase(const PFase: Integer): TLivelliFase;
// restituisce il livello min e max per la fase indicata
// PRE: CodIter impostato
var
  Liv: Integer;
begin
  Result.Min:=99;
  Result.Max:=0;
  selI096.First;
  while selI096.SearchRecord('COD_ITER;FASE',VararrayOf([CodIter,PFase]),[srFromCurrent]) do
  begin
    Liv:=selI096.FieldByName('LIVELLO').AsInteger;
    if Liv < Result.Min then
      Result.Min:=Liv;
    if Liv > Result.Max then
      Result.Max:=Liv;
  end;
end;

procedure TC018FIterAutDM.ImpostaVariabiliExprRichiesta;
var i,TipoVariabile:Integer;
    Filtro:String;
begin
  selDualExprRichiesta.ClearVariables;
  selDualExprRichiesta.DeleteVariables;
  Filtro:=UpperCase(selDualExprRichiesta.SQL.Text);
  //Variabili fisse
  if R180CercaParolaIntera(':NOME_UTENTE',Filtro,',;()=<>|!/+-*') > 0  then
  begin
    selDualExprRichiesta.DeclareAndSet('NOME_UTENTE',otString,Parametri.Operatore);
  end;
  if R180CercaParolaIntera(':PROFILO_UTENTE',Filtro,',;()=<>|!/+-*') > 0  then
  begin
    selDualExprRichiesta.DeclareAndSet('PROFILO_UTENTE',otString,Parametri.ProfiloWEB);
  end;
  //Variabili legate al dataset
  for i:=0 to selTabellaIter.FieldCount - 1 do
  begin
    if selTabellaIter.Fields[i].FieldKind = fkData then
    begin
      if R180CercaParolaIntera(':' + selTabellaIter.Fields[i].FieldName,Filtro,',;()=<>|!/+-*') > 0  then
      begin
        if selTabellaIter.Fields[i] is TDateTimeField then
          TipoVariabile:=otDate
        else if selTabellaIter.Fields[i] is TDateField then
          TipoVariabile:=otDate
        else if selTabellaIter.Fields[i] is TIntegerField then
          TipoVariabile:=otInteger
        else if selTabellaIter.Fields[i] is TFloatField then
          TipoVariabile:=otFloat
        else
          TipoVariabile:=otString;
        selDualExprRichiesta.DeclareVariable(selTabellaIter.Fields[i].FieldName,TipoVariabile);
        selDualExprRichiesta.SetVariable(selTabellaIter.Fields[i].FieldName,selTabellaIter.Fields[i].Value);
      end;
    end;
  end;
end;

procedure TC018FIterAutDM.RicercaCodIter;
var Filtro:String;
begin
  CodIter:='';
  selI095.First;
  while not selI095.Eof do
  begin
    Filtro:=Trim(selI095.FieldByName('FILTRO_RICHIESTA').AsString);
    if Filtro = '' then
    begin
      CodIter:=selI095.FieldByName('COD_ITER').AsString;
      Break;
    end
    else
    begin
      with selDualExprRichiesta do
      begin
        SQL.Text:=Format('select count(*) TOT from DUAL where %s',[Filtro]);
        ImpostaVariabiliExprRichiesta;
        try
          Execute;
          if FieldAsInteger('TOT') > 0 then
          begin
            CodIter:=selI095.FieldByName('COD_ITER').AsString;
            Break;
          end;
        except
          on E:Exception do
          begin
            FMessaggioOperazione:=Format('Riconoscimento della struttura "%s" fallito: %s',[selI095.FieldByName('COD_ITER').AsString,E.Message]);
            CodIter:='';
            Break;
          end;
        end;
      end;
    end;
    selI095.Next;
  end;
  if (CodIter = '') and (FMessaggioOperazione = '') then
    FMessaggioOperazione:='struttura non trovata';
end;

procedure TC018FIterAutDM.selT851CalcFields(DataSet: TDataSet);
begin
  inherited;
  selT851.FieldByName('C_TITOLO_LIVELLO').AsString:=A000TraduzioneStringhe(selT851.FieldByName('TITOLO_LIVELLO').AsString);
  selT851.FieldByName('C_STATO').AsString:=A000TraduzioneStringhe(selT851.FieldByName('STATO').AsString);
end;

function TC018FIterAutDM.WarningRichiesta(const PTipoRichiesta: String = ''):Boolean;
// restituisce True se la richiesta è ok
// oppure False altrimenti
begin
  Result:=True;
  FMessaggioOperazione:='';
  if not selI097.SearchRecord('BLOCCANTE','N',[srFromBeginning]) then
    exit;
  RicercaCodIter;
  if (CodIter <> '') and (selTabellaIter.State in [dsInsert,dsEdit]) then
  begin
    // valuta validità richiesta
    FTipoRichiesta:=PTipoRichiesta;
    Result:=ValiditaRichiesta(False);
    FTipoRichiesta:='';
  end;
end;

function TC018FIterAutDM.ValiditaRichiesta(CondizioniBloccanti:Boolean):Boolean;
//valuto le espressioni di validazione richieste per questa struttura (CodIter)
var Filtro,Messaggio,ColPeriodoInizio:String;
begin
  Result:=True;
  FMessaggioOperazione:='';

  //Verifico condizione automatica che la richiesta non sia antecedente a Parametri.WEBCartelliniDataMin
  if CondizioniBloccanti then
  begin
    ColPeriodoInizio:=StringReplace(GetColonnaPeriodoInizio,'T_ITER.','',[]);
    if selTabellaIter.FieldByName(ColPeriodoInizio).AsDateTime < Parametri.WEBCartelliniDataMin then
    begin
      Result:=False;
      FMessaggioOperazione:=Format(A000TraduzioneStringhe(A000MSG_C018_ERR_STOP_DATA_ANTECEDENTE),[DateToStr(Parametri.WEBCartelliniDataMin)]);
      exit;
    end;
  end;

  if selI097.SearchRecord('COD_ITER',CodIter,[srFromBeginning]) then
    repeat
      if CondizioniBloccanti <> (selI097.FieldByName('BLOCCANTE').AsString = 'S') then
        Continue;
      Filtro:=selI097.FieldByName('CONDIZ_VALIDITA').AsString.Trim;
      // sostituzione TIPO_RICHIESTA per valutazione validità richiesta.ini
      Filtro:=Filtro.Replace(':TIPO_RICHIESTA',FTipoRichiesta.QuotedString,[rfReplaceAll,rfIgnoreCase]);
      // sostituzione TIPO_RICHIESTA per valutazione validità richiesta.fine
      // MONDOEDP - commessa MAN/07 SVILUPPO#62.ini
      // sostituzione delle note (per le maschere che ne prevedono l'impostazione già in fase di inserimento)
      Filtro:=Filtro.Replace(':NOTE',FNote.QuotedString,[rfReplaceAll,rfIgnoreCase]);
      // MONDOEDP - commessa MAN/07 SVILUPPO#62.fine
      Messaggio:='';
      with selDualExprRichiesta do
      begin
        SQL.Text:=Format('select count(*) TOT from DUAL where %s',[Filtro]);
        ImpostaVariabiliExprRichiesta;
        try
          Execute;
          if FieldAsInteger('TOT') = 0 then
          begin
            // la richiesta non è valida: valuta il messaggio da visualizzare
            Result:=False;
            if selI097.FieldByName('MESSAGGIO').AsString.Trim = '' then
              Messaggio:=Format('La richiesta non rispetta la condizione di validità num. %d della struttura "%s".',[selI097.FieldByName('NUM_CONDIZ').AsInteger,CodIter])
            else
            begin
              Filtro:=selI097.FieldByName('MESSAGGIO').AsString.Trim;
              SQL.Text:=Format('select %s MSG from DUAL',[Filtro]);
              ImpostaVariabiliExprRichiesta;
              try
                Execute;
                Messaggio:=FieldAsString('MSG');
                if Messaggio.Trim = '' then
                  Messaggio:=Format('La richiesta non rispetta la condizione di validità num. %d della struttura "%s".' + CRLF +
                                    '(messaggio di errore non indicato)',
                                    [selI097.FieldByName('NUM_CONDIZ').AsInteger,CodIter]);
              except
                Messaggio:=Format('La richiesta non rispetta la condizione di validità num. %d della struttura "%s".' + CRLF +
                                  '(messaggio di errore non visualizzabile)',
                                  [selI097.FieldByName('NUM_CONDIZ').AsInteger,CodIter]);
              end;
            end;
            if selI097.FieldByName('BLOCCANTE').AsString = 'S' then
              Break;
          end;
        except
          on E:Exception do
          begin
            Result:=False;
            Messaggio:=Format('Validazione della richiesta per la struttura "%s" num. %d fallita: %s',[CodIter,selI097.FieldByName('NUM_CONDIZ').AsInteger,E.Message]);
            if selI097.FieldByName('BLOCCANTE').AsString = 'S' then
              Break;
          end;
        end;
      end;
      if Messaggio <> '' then
        FMessaggioOperazione:=FMessaggioOperazione + IfThen(FMessaggioOperazione <> '',CRLF,'') + Messaggio;
    until not selI097.SearchRecord('COD_ITER',CodIter,[]);

  if selI097.FieldByName('BLOCCANTE').AsString = 'S' then
    FMessaggioOperazione:=Messaggio;
end;

function TC018FIterAutDM.CheckDatiBloccati:Boolean;
var Espressione:String;
    DataRiepilogo:TDateTime;
begin
  Result:=True;
  selI094.First;
  while not selI094.Eof do
  begin
    Espressione:=Trim(selI094.FieldByName('EXPR_DATA').AsString);
    if Espressione <> '' then
    begin
      with selDualExprRichiesta do
      begin
        SQL.Text:=Format('select %s DATA from DUAL',[Espressione]);
        ImpostaVariabiliExprRichiesta;
        try
          Execute;
          if RowCount > 0 then
          begin
            DataRiepilogo:=FieldAsDate('DATA');
            if selI094.FieldByName('STATO').AsString <> IfThen(selDatiBloccati.DatoBloccato(selTabellaIter.FieldByName('PROGRESSIVO').AsInteger,DataRiepilogo,selI094.FieldByName('RIEPILOGO').AsString),'C','A') then
            begin
              Result:=False;
              FMessaggioOperazione:=Format('La richiesta non è compatibile con lo stato del riepilogo %s.',[selI094.FieldByName('RIEPILOGO').AsString]);
              Break;
            end;
          end;
        except
          on E:Exception do
          begin
            Result:=False;
            FMessaggioOperazione:=Format('Valutazione del blocco del riepilogo %s fallita: %s',[selI094.FieldByName('RIEPILOGO').AsString,E.Message]);
          end;
        end;
      end;
    end;
    selI094.Next;
  end;
  selDatiBloccati.Close;
end;

// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
function TC018FIterAutDM.GetCondizioneAllegati: String;
// valuta la condizione di gestione allegati per la richiesta attuale
// restituisce
// - N: allegati non previsti
// - F: allegati facoltativi
// - O: allegati obbligatori
var
  Condiz: String;
begin
  Result:='N';

  if Iter = ITER_GIUSTIF then
  begin
    //Gestione Condizione Allegati per Causali Assenza
    R180SetVariable(selT230, 'DATA', selTabellaIter.FieldByName('AL').AsDateTime);
    R180SetVariable(selT230, 'CODICE', selTabellaIter.FieldByName('CAUSALE').AsString);
    selT230.Open;
    Condiz:=selT230.FieldByName('CONDIZIONE_ALLEGATI').AsString;
    if R180In(Condiz,['N','O','F']) then
    begin
      Result:=Condiz;
      Exit;
    end;
  end;

  if selI095.SearchRecord('COD_ITER',CodIter,[srFromBeginning]) then
  begin
    // condizione per allegati
    Condiz:=selI095.FieldByName('CONDIZIONE_ALLEGATI').AsString;
    if Condiz.Trim = '' then
      Exit;

    // se nella condizione è già specificato direttamente uno dei flag, lo considera
    if R180In(Condiz,['N','F','O']) then
    begin
      Result:=Condiz;
      Exit;
    end;

    // valuta espressione
    selDualExprRichiesta.SQL.Text:=Format('select %s from dual',[Condiz]);
    try
      ImpostaVariabiliExprRichiesta;
      selDualExprRichiesta.Execute;
      Result:=selDualExprRichiesta.FieldAsString(0);
    except
      on E:Exception do
        raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_C018_ERR_FMT_CONDIZ_ALLEG),[selI095.FieldByName('COD_ITER').AsString,E.Message]));
    end;

    // se il flag non è tra quelli leciti, imposta flag N e segnala anomalia
    if not R180In(Result,['N','F','O']) then
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_C018_ERR_FMT_FLAG_CONDIZ_ALLEG),[selI095.FieldByName('COD_ITER').AsString,Result]));
  end;
end;

function TC018FIterAutDM.GetAllegatiModificabili: String;
// restituisce True se la struttura prevede allegati modificabili dopo un'autorizzazione intermedia
// oppure False altrimenti
begin
  Result:=VarToStr(selI095.Lookup('COD_ITER',CodIter,'ALLEGATI_MODIFICABILI'));
end;
// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

function TC018FIterAutDM.RicercaAutorizzAutomatica:String;
var Filtro:String;
begin
  Result:='';
  if selI095.SearchRecord('COD_ITER',CodIter,[srFromBeginning]) then
  begin
    Filtro:=selI095.FieldByName('CONDIZ_AUTORIZZ_AUTOMATICA').AsString.Trim;
    if Filtro <> '' then
    begin
      // sostituzione TIPO_RICHIESTA per aut. automatica.ini
      Filtro:=Filtro.Replace(':TIPO_RICHIESTA',QuotedStr(FTipoRichiesta),[rfReplaceAll,rfIgnoreCase]);
      // sostituzione TIPO_RICHIESTA per aut. automatica.fine
      with selDualExprRichiesta do
      begin
        SQL.Text:=Format('select count(*) TOT from DUAL where %s',[Filtro]);
        ImpostaVariabiliExprRichiesta;
        try
          Execute;
          if FieldAsInteger('TOT') > 0 then
            Result:='S';
        except
          on E:Exception do
            FMessaggioOperazione:=Format('Riconoscimento del''autorizzazione automatica per la struttura "%s" fallito: %s',[selI095.FieldByName('COD_ITER').AsString,E.Message]);
        end;
      end;
    end;
  end;
end;

function TC018FIterAutDM.RicercaAutorizzAutomaticaLiv(PLivello:Integer):String;
var Filtro:String;
begin
  Result:='';
  if selI096.SearchRecord('COD_ITER;LIVELLO',VarArrayOf([CodIter,PLivello]),[srFromBeginning]) then
  begin
    Filtro:=selI096.FieldByName('CONDIZ_AUTORIZZ_AUTOMATICA').AsString.Trim;
    if Filtro <> '' then
    begin
      // sostituzione TIPO_RICHIESTA per aut. automatica.ini
      Filtro:=Filtro.Replace(':TIPO_RICHIESTA',QuotedStr(FTipoRichiesta),[rfReplaceAll,rfIgnoreCase]);
      // sostituzione TIPO_RICHIESTA per aut. automatica.fine
      with selDualExprRichiesta do
      begin
        SQL.Text:=Format('select count(*) TOT from DUAL where %s',[Filtro]);
        ImpostaVariabiliExprRichiesta;
        try
          Execute;
          if FieldAsInteger('TOT') > 0 then
            Result:='S';
        except
          on E:Exception do
            FMessaggioOperazione:=Format('Riconoscimento del''autorizzazione automatica per la struttura "%s" e livello %d fallito: %s',[selI096.FieldByName('COD_ITER').AsString,PLivello,E.Message]);
        end;
      end;
    end;
  end;
  if (Result = 'S') and (GetCondizioneAllegati = 'O') and (GetAllegatiObbligatori(PLivello) = 'S') then
  begin
    selT853Count.SetVariable('ID',Id);
    selT853Count.Execute;
    if selT853Count.FieldAsInteger(0) <= 0 then
      Result:='';
  end;
end;

procedure TC018FIterAutDM.EseguiScriptAutorizz(var RLivello:Integer; var RStato,RResponsabile,RAutorizzAutomatica:String; PScriptAutorizz:String);
var
  i,TipoVariabile:Integer;
  ScriptUpper: String;
begin
  scrT851.ClearVariables;
  scrT851.DeleteVariables;
  scrT851.SQL.Clear; // daniloc. 21.11.2012
  scrT851.SQL.Add('begin');
  scrT851.SQL.Add(PScriptAutorizz);
  scrT851.SQL.Add('end;');

  ScriptUpper:=PScriptAutorizz.ToUpper;
  for i:=0 to selTabellaIter.FieldCount - 1 do
    if selTabellaIter.Fields[i].FieldKind = fkData then
      if not R180In(UpperCase(selTabellaIter.Fields[i].FieldName),['ID','LIVELLO','STATO','RESPONSABILE','AUTORIZZ_AUTOMATICA','NOME_UTENTE','PROFILO_UTENTE']) then
        if R180CercaParolaIntera(':' + selTabellaIter.Fields[i].FieldName,ScriptUpper,',;()=<>|!/+-*') > 0  then
        begin
          if selTabellaIter.Fields[i] is TDateTimeField then
            TipoVariabile:=otDate
          else if selTabellaIter.Fields[i] is TDateField then
            TipoVariabile:=otDate
          else if selTabellaIter.Fields[i] is TIntegerField then
            TipoVariabile:=otInteger
          else if selTabellaIter.Fields[i] is TFloatField then
            TipoVariabile:=otFloat
          else
            TipoVariabile:=otString;
          scrT851.DeclareVariable(selTabellaIter.Fields[i].FieldName,TipoVariabile);
          scrT851.SetVariable(selTabellaIter.Fields[i].FieldName,selTabellaIter.Fields[i].Value);
        end;
  if R180CercaParolaIntera(':ID',ScriptUpper,',;()=<>|!/+-*') > 0  then
  begin
    scrT851.DeclareVariable('ID',otInteger);
    scrT851.SetVariable('ID',Id);
  end;
  if R180CercaParolaIntera(':LIVELLO',ScriptUpper,',;()=<>|!/+-*') > 0  then
  begin
    scrT851.DeclareVariable('LIVELLO',otInteger);
    scrT851.SetVariable('LIVELLO',RLivello);
  end;
  if R180CercaParolaIntera(':STATO',ScriptUpper,',;()=<>|!/+-*') > 0  then
  begin
    scrT851.DeclareVariable('STATO',otString);
    scrT851.SetVariable('STATO',RStato);
  end;
  if R180CercaParolaIntera(':RESPONSABILE',ScriptUpper,',;()=<>|!/+-*') > 0  then
  begin
    scrT851.DeclareVariable('RESPONSABILE',otString);
    scrT851.SetVariable('RESPONSABILE',RResponsabile);
  end;
  if R180CercaParolaIntera(':AUTORIZZ_AUTOMATICA',ScriptUpper,',;()=<>|!/+-*') > 0  then
  begin
    scrT851.DeclareVariable('AUTORIZZ_AUTOMATICA',otString);
    scrT851.SetVariable('AUTORIZZ_AUTOMATICA',RAutorizzAutomatica);
  end;
  if R180CercaParolaIntera(':NOME_UTENTE',ScriptUpper,',;()=<>|!/+-*') > 0  then
  begin
    scrT851.DeclareVariable('NOME_UTENTE',otString);
    scrT851.SetVariable('NOME_UTENTE',Parametri.Operatore);
  end;
  if R180CercaParolaIntera(':PROFILO_UTENTE',ScriptUpper,',;()=<>|!/+-*') > 0  then
  begin
    scrT851.DeclareVariable('PROFILO_UTENTE',otString);
    scrT851.SetVariable('PROFILO_UTENTE',Parametri.ProfiloWEB);
  end;
  try
    scrT851.Execute;
    if scrT851.VariableIndex('LIVELLO') >= 0 then
      RLivello:=scrT851.GetVariable('LIVELLO');
    if scrT851.VariableIndex('STATO') >= 0 then
      RStato:=VarToStr(scrT851.GetVariable('STATO'));
    if scrT851.VariableIndex('RESPONSABILE') >= 0 then
      RResponsabile:=VarToStr(scrT851.GetVariable('RESPONSABILE'));
    if scrT851.VariableIndex('AUTORIZZ_AUTOMATICA') >= 0 then
      RAutorizzAutomatica:=VarToStr(scrT851.GetVariable('AUTORIZZ_AUTOMATICA'));
  except
    on E:Exception do
      FMessaggioOperazione:='Errore nell''esecuzione dello script:' + CRLF + scrT851.SQL.Text + CRLF + E.Message;
  end;
end;

function TC018FIterAutDM.InsRichiesta(PTipoRichiesta,PNote,PIdRevocato:String; PUpdRichiesta:Boolean = False):Integer;
var
  AutorizzAutomatica,AppTipoRichiesta:String;
begin
  //Inserimento dati della richiesta
  Result:=0;
  Id:=0;
  FFaseCorrente:=-1;
  FMessaggioOperazione:='';
  FStatoRichiesta:='';
  if (selTabellaIter.State <> dsInsert) and
     (selTabellaIter.State <> dsEdit) then // aggiunto daniloc. 14.11.2011 per gestire W026
    exit;
  if not CheckDatiBloccati then
  begin
    //FMessaggioOperazione:='Richiesta annullata' + #13#10 + FMessaggioOperazione;
    exit;
  end;
  RicercaCodIter;
  if CodIter = '' then
  begin
    //FMessaggioOperazione:='Richiesta annullata' + #13#10 + FMessaggioOperazione;
    exit;
  end;
  { // spostato sotto per valutare la variabile tiporichiesta (caso della revoca)
  if not ValiditaRichiesta(True) then
  begin
    //FMessaggioOperazione:='Richiesta annullata' + #13#10 + FMessaggioOperazione;
    exit;
  end;
  }
  FTipoRichiesta:=R180CarattereDef(PTipoRichiesta); // tipo richiesta iniziale
  if not ValiditaRichiesta(True) then
  begin
    FTipoRichiesta:='';
    exit;
  end;
  AutorizzAutomatica:=RicercaAutorizzAutomatica;
  AppTipoRichiesta:=PTipoRichiesta;
  PTipoRichiesta:=R180CarattereDef(AppTipoRichiesta);
  if (Pos(',',AppTipoRichiesta) > 0) and (AutorizzAutomatica = 'S') then
    PTipoRichiesta:=R180CarattereDef(AppTipoRichiesta,Pos(',',AppTipoRichiesta) + 1);
  FTipoRichiesta:=PTipoRichiesta;
  with insT850 do
  begin
    ClearVariables;
    // modifica per consentire ricalcolo coditer.ini
    if PUpdRichiesta and (not selTabellaIter.FieldByName('ID').IsNull) then
      SetVariable('ID',selTabellaIter.FieldByName('ID').AsInteger);
    // modifica per consentire ricalcolo coditer.fine
    SetVariable('ITER',Iter);
    SetVariable('COD_ITER',CodIter);
    SetVariable('DATA',Now);
    SetVariable('NOTE',PNote);
    SetVariable('TIPO_RICHIESTA',PTipoRichiesta);
    SetVariable('RICHIEDENTE',Parametri.Operatore);
    if StrToIntDef(PIDRevocato,0) <> 0 then
      SetVariable('ID_REVOCATO',PIdRevocato.ToInteger);
    SetVariable('CONDIZ_ALLEGATI','N');
    if not R180In(FTipoRichiesta,['R','C']) then
    try
      SetVariable('CONDIZ_ALLEGATI',GetCondizioneAllegati);
    except
      SetVariable('CONDIZ_ALLEGATI','N');
    end;
    try
      Execute;
      // ROMA_HSANTANDREA - chiamata 76183.ini
      // settando la property "Id", viene anche pulita la variabile FTipoRichiesta,
      // che però è utilizzata dalla funzione VerificaRichiestaEsistente
      // nella valutazione delle condizioni di autorizzazione automatica
      //Id:=GetVariable('ID');
      FId:=GetVariable('ID');
      // ROMA_HSANTANDREA - chiamata 76183.fine
    except
      on E:Exception do
      begin
        FMessaggioOperazione:=E.Message;
        exit;
      end;
    end;
  end;

  selTabellaIter.FieldByName('ID').AsInteger:=Id;
  RegistraLog.SettaProprieta('I',TabellaIter,Copy(IterCodForm,1,4),selTabellaIter,True);
  selTabellaIter.Post;  //Registro i dati in modo da averli a disposizione sul db per query successive in questa transazione
  RegistraLog.RegistraOperazione;
  //Test di carico CSI 2014
  if (selTabellaIter is TOracleDataSet) and (False) then //parametro su Iter per eseguire la commit!
    (selTabellaIter as TOracleDataSet).Session.Commit;

  // in caso di revoca lego la richiesta di revoca alla richiesta originale che viene revocata
  // in caso di cancellazione imposto l'id_revoca della cancellazione a -1
  if ((PTipoRichiesta = 'R') or (PTipoRichiesta = 'C')) and // empoli - commessa 2012/102
     (StrToIntDef(PIDRevocato,0) <> 0) then
  begin
    try
      IdOld:=Id;
      // ROMA_HSANTANDREA - chiamata 76183.ini
      // settando la property "Id", viene anche pulita la variabile FTipoRichiesta,
      // che però è utilizzata dalla funzione VerificaRichiestaEsistente
      // nella valutazione delle condizioni di autorizzazione automatica
      //Id:=StrToInt(IdRevocato);
      FId:=PIdRevocato.ToInteger;
      // ROMA_HSANTANDREA - chiamata 76183.fine

      // EMPOLI_ASL11 - commessa 2012/102.ini
      //SetIdRevoca(IdOld);
      SetIdRevoca(IfThen(PTipoRichiesta = 'R',IdOld,-1));
      // EMPOLI_ASL11 - commessa 2012/102.fine
    finally
      // ROMA_HSANTANDREA - chiamata 76183.ini
      // settando la property "Id", viene anche pulita la variabile FTipoRichiesta,
      // che però è utilizzata dalla funzione VerificaRichiestaEsistente
      // nella valutazione delle condizioni di autorizzazione automatica
      //Id:=IdOld;
      FId:=IdOld;
      // ROMA_HSANTANDREA - chiamata 76183.fine
    end;
  end;

  Result:=VerificaRichiestaEsistente(AutorizzAutomatica);
  FTipoRichiesta:='';
end;

function TC018FIterAutDM.UpdRichiesta(const PTipoRichiesta: String = ''):Integer;
begin
  Result:=InsRichiesta(PTipoRichiesta,'','',True);
end;

function TC018FIterAutDM.VerificaRichiestaEsistente(PAutorizzAutomatica:String):Integer;
var
  i,Liv,LivSucc,MaxLivAutorAutom,MaxLivAutorizzato,NumRec:Integer;
begin
  //restituisce il livello a cui è arrivata l'autorizzazione automatica
  //Gestione dell'autorizzazione automatica: si attivano tutti i livelli obbligatori
  MaxLivAutorizzato:=max(LivMaxAut,0);//prima era sempre 0;
  if ((PAutorizzAutomatica = '') and (Iter = ITER_STRMESE)) or (PAutorizzAutomatica = 'V')  then //Alberto 17/10/2011: se la chiamata arriva da W024 valuto l'autorizzazione automatica
    PAutorizzAutomatica:=RicercaAutorizzAutomatica;
  if (PAutorizzAutomatica = 'S') and selI096.Active then
  begin
    MaxLivAutorAutom:=selI095.Lookup('COD_ITER',CodIter,'MAX_LIV_AUTORIZZ_AUTOMATICA');
    if selI096.SearchRecord('COD_ITER',CodIter,[srFromBeginning]) then
      repeat
        Liv:=selI096.FieldByName('LIVELLO').AsInteger;
        if Liv > MaxLivAutorizzato then  //condizione per non sovrascrivere autorizzazione già presente
        begin
          if (GetCondizioneAllegati = 'O') and (GetAllegatiObbligatori(Liv) = 'S') then
          begin
            selT853Count.SetVariable('ID',Id);
            selT853Count.Execute;
            if selT853Count.FieldAsInteger(0) <= 0 then
              Break;
          end;
          if (MaxLivAutorAutom <= 0) or (Liv <= MaxLivAutorAutom) then
          begin
            NumRec:=selI096.RecNo;
            LivSucc:=InsAutorizzazione(Liv,C018SI,'(automatico)',PAutorizzAutomatica,'');
            selI096.RecNo:=NumRec;
            if selI096.FieldByName('OBBLIGATORIO').AsString = 'S' then
              MaxLivAutorizzato:=Liv;
            //Alberto 30/01/2015: Gestione del fatto che il livello può avanzare in InsAutorizzazione per via di autorizzazioni automatiche sui singoli livelli
            for i:=Liv + 1 to LivSucc do
            begin
              if selI096.SearchRecord('COD_ITER;LIVELLO',VarArrayOf([CodIter,i]),[]) then
                if selI096.FieldByName('OBBLIGATORIO').AsString = 'S' then
                  MaxLivAutorizzato:=i;
            end;
          end
          else
            Break;
        end;
      until not selI096.SearchRecord('COD_ITER',CodIter,[]);
  end;
  MaxLivAutorizzato:=AutorizzAutomaticaLivSucc(MaxLivAutorizzato);
  Result:=MaxLivAutorizzato;

  //Gestione della mail solo se non c'è stato avanzamento di livello; in caso contrario la mail è stata già gestita da InsAutorizzazione
  if MaxLivAutorizzato = 0 then
    MailPerAutorizzatore(MaxLivAutorizzato,0,'R');
end;

procedure TC018FIterAutDM.EliminaIter(const PTabella: String = '');
// elimina l'iter completo della richiesta: tabella_iter, T850 e T851
// utilizzare il parametro per ridefinire la tabella dell'iter da cui eliminare
var
  Tabella: String;
begin
  FMessaggioOperazione:='';
  if PTabella <> '' then
    Tabella:=PTabella
  else
    Tabella:=TabellaIter;

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  // controllo presenza allegati
  selT853Count.SetVariable('ID',Id);
  selT853Count.Execute;
  if selT853Count.FieldAsInteger(0) > 0 then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_C018_ERR_PRESENZA_ALLEGATI));
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

  //Invio mail annullamento richiesta
  MailAnnullamentoPerAutorizzatore;

  RegistraLog.SettaProprieta('C',Tabella,Copy(IterCodForm,1,4),selTabellaIter,True);
  with delIterRichiesta do
  begin
    ClearVariables;
    SetVariable('TABELLA',Tabella);
    SetVariable('ITER',Iter);
    SetVariable('ID',Id);
    try
      Execute;
    except
      on E: Exception do
        raise Exception.Create(Format('Eliminazione della richiesta %d fallita:%s%s (%s)',[Id,CRLF,E.Message,E.ClassName]));
    end;
  end;
  RegistraLog.RegistraOperazione;
end;

function TC018FIterAutDM.GetLivMaxSoloAut: Integer;
//Massimo livello autorizzato (aut. c'è ed è diversa da NO)
begin
  Result:=GetLivMaxAut(False);
end;

function TC018FIterAutDM.GetLivMaxAutNeg: Integer;
//Massimo livello autorizzato o negato (aut. c'è)
begin
  Result:=GetLivMaxAut(True);
end;

function TC018FIterAutDM.GetLivMaxAut(AncheNegato:Boolean): Integer;
// restituisce il livello più alto con stato autorizzato della attuale richiesta
// se la richiesta non risulta autorizzata restituisce -1
begin
  Result:=-1;
  if ID = 0 then
    exit;

  // ciclo sull'elenco dei livelli (ordinato in modo decrescente)
  R180SetVariable(selT851StatoLivelli,'ID',Id);
  if RefreshForzato_selT851StatoLivelli then
    selT851StatoLivelli.Close;
  selT851StatoLivelli.Open;
  selT851StatoLivelli.First;
  while not selT851StatoLivelli.Eof do
  begin
    if StatoAutorizzato(selT851StatoLivelli.FieldByName('STATO').AsString)
    or (AncheNegato and StatoNegato(selT851StatoLivelli.FieldByName('STATO').AsString)) then
    begin
      Result:=selT851StatoLivelli.FieldByName('LIVELLO').AsInteger;
      Break;
    end;
    selT851StatoLivelli.Next;
  end;
end;

function TC018FIterAutDM.GetLivObbSucc(const PLiv: Integer): Integer;
// restituisce il livello obbligatorio successivo a quello indicato
// oppure il livello stesso se non ne esiste uno successivo
// PRE: CodIter impostato
begin
  Result:=PLiv;

  // esce se il livello indicato è già l'ultimo obbligatorio
  if PLiv = FLivMaxObb then
    Exit;

  // ciclo per determinare il livello obbligatorio successivo
  if selI096.Active then
  begin
    if selI096.SearchRecord('COD_ITER',CodIter,[srFromBeginning]) then
      repeat
        if (selI096.FieldByName('OBBLIGATORIO').AsString = 'S') and
           (selI096.FieldByName('LIVELLO').AsInteger > PLiv) then
        begin
          Result:=selI096.FieldByName('LIVELLO').AsInteger;
          Break;
        end;
      until not selI096.SearchRecord('COD_ITER',CodIter,[]);
  end;
end;

procedure TC018FIterAutDM.MailAnnullamentoPerAutorizzatore;
var Liv,MaxLivAutorizzato,MaxLivAutorAutom:Integer;
begin
  if Parametri.CampiRiferimento.C90_EMailRespOttimizzata = 'S' then
    exit;
  //Se autorizzazione automatica estraggo ultimo livello obbligatorio
  MaxLivAutorizzato:=0;
  if (selTabellaIter.FieldByName('AUTORIZZ_AUTOMATICA').AsString = 'S') and selI096.Active then
  begin
    MaxLivAutorAutom:=selI095.Lookup('COD_ITER',CodIter,'MAX_LIV_AUTORIZZ_AUTOMATICA');
    if selI096.SearchRecord('COD_ITER;OBBLIGATORIO',VarArrayOf([CodIter,'S']),[srFromBeginning]) then
      repeat
        Liv:=selI096.FieldByName('LIVELLO').AsInteger;
        if (MaxLivAutorAutom <= 0) or (Liv <= MaxLivAutorAutom) then
          MaxLivAutorizzato:=Liv
        else
          Break;
      until not selI096.SearchRecord('COD_ITER;OBBLIGATORIO',VarArrayOf([CodIter,'S']),[]);
  end;
  MailPerAutorizzatore(MaxLivAutorizzato,0,'C');
end;

procedure TC018FIterAutDM.MailPerAutorizzatore(LivelloObb,LivelloNoObb:Integer; Operazione:String);
{Gestione mail verso autorizzatore
 deve essere inviata a:
   livello obbligatorio successivo a quello già autorizzato (se autorizz.automatica non è il primo)
   livelli facoltativi inferiori al prox.livello obbligatorio
   i livelli candidati devono avere il flag di INVIO_EMAIL in (A,E)
   si verificano tra i responsabili quelli che hanno l'indirizzo email e hanno un profilo che consenta l'accesso all'ITER + COD_ITER + LIVELLO
}
var
  LivObbSucc:Integer;
  ElencoLivelli:String;
  MailOggetto,MailCorpo: String;
  MailTag: Integer;
begin
  if Parametri.CampiRiferimento.C90_EMailSMTPHost = '' then
    exit;
  if FInibisciMailPerAutorizzatore then
   exit;
  LivObbSucc:=999;
  ElencoLivelli:='';
  if selI096.Active then
  begin
    if selI096.SearchRecord('COD_ITER',CodIter,[srFromBeginning]) then
      repeat
        if R180CarattereDef(selI096.FieldByName('INVIO_EMAIL').AsString) in ['A','E'] then
        begin
          if (selI096.FieldByName('OBBLIGATORIO').AsString = 'S') and (selI096.FieldByName('LIVELLO').AsInteger > LivelloObb) and (LivObbSucc = 999) then
            LivObbSucc:=selI096.FieldByName('LIVELLO').AsInteger
          else if (selI096.FieldByName('OBBLIGATORIO').AsString = 'N') and (selI096.FieldByName('LIVELLO').AsInteger > LivelloNoObb) and (selI096.FieldByName('LIVELLO').AsInteger < LivObbSucc) then
            ElencoLivelli:=ElencoLivelli + selI096.FieldByName('LIVELLO').AsString + ',';
        end;
      until not selI096.SearchRecord('COD_ITER',CodIter,[]);
  end;
  if LivObbSucc < 999 then
    ElencoLivelli:=ElencoLivelli + IntToStr(LivObbSucc)
  else
    ElencoLivelli:=Copy(ElencoLivelli,1,Length(ElencoLivelli) - 1);
  if ElencoLivelli = '' then
    exit;
  //Preparazione testo
  MailTag:=TagAutorizzazione;
  if Parametri.CampiRiferimento.C90_EMailRespOttimizzata = 'S' then
  begin
    MailOggetto:=Parametri.CampiRiferimento.C90_EMailRespOggetto;
    if MailOggetto = '' then
      MailOggetto:='Notifica presenza richieste da autorizzare';
    MailCorpo:=Parametri.CampiRiferimento.C90_EMailRespTesto;
    if MailCorpo = '' then
      MailCorpo:='Si avvisa che sono presenti richieste in attesa di autorizzazione.';
  end
  else
    with selMailPerAutorizzatore do
    begin
      SetVariable('PROGRESSIVO',selTabellaIter.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('ID',Id);
      if VariableIndex('OPERAZIONE') >= 0 then
        SetVariable('OPERAZIONE',Operazione);
      try
        Execute;
        MailOggetto:=FieldAsString('MAIL_OGGETTO');
        MailCorpo:=FieldAsString('MAIL_CORPO');
      except
        on E:Exception do
        begin
          MailOggetto:='';
          MailCorpo:='';
          {$IFDEF IRISWEB}{$IFNDEF WEBSVC}
          W000RegistraLog('Errore',GetTestoLog('C018') + 'Errore durante invio email all''autorizzatore: ' + E.Message);
          {$ENDIF}{$ENDIF}
        end;
      end;
    end;
  //Richiamare InviaEMail con Iter,CodIter,ElencoLivelli
  if (MailOggetto <> '') or (MailCorpo <> '') then
  {$IFDEF IRISWEB}
  {$IFNDEF WEBSVC}
    WR000DM.InviaEMail(True,selTabellaIter.FieldByName('PROGRESSIVO').AsInteger,MailOggetto,MailCorpo,MailTag,Iter,CodIter,ElencoLivelli);
  {$ENDIF}
  {$ENDIF}
  {$IFNDEF IRISWEB}
  {$IFNDEF WEBSVC}
    MailImmediata(True,selTabellaIter.FieldByName('PROGRESSIVO').AsInteger,MailOggetto,MailCorpo,MailTag,Iter,CodIter,ElencoLivelli);
  {$ENDIF}
  {$ENDIF}
end;

procedure TC018FIterAutDM.MailImmediata(PDestResponsabile: Boolean; PProgressivo: Integer;
    const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
    const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
  (*vedi TWR000FBaseDM._MailImmediata*)
  {$IFNDEF IRISWEB}{$IFNDEF WEBSVC}
var
  C017DtM:TC017FEMailDtM;
  i: Integer;
  L: TStringList;
  {$ENDIF}{$ENDIF}
begin
  {$IFNDEF IRISWEB}{$IFNDEF WEBSVC}
  C017DtM:=TC017FEMailDtM.Create(nil);
  try
    try
      C017DtM.SollevaEccezioni:=True;
      C017DtM.Sessione:=SessioneOracle;
      C017DtM.DestResponsabile:=PDestResponsabile;
      C017DtM.Progressivo:=PProgressivo;
      C017DtM.Oggetto:=POggetto;
      C017DtM.Testo:=PTesto;
      C017DtM.TagFunzione:=PTag;
      C017DtM.Iter:=PIter;
      C017DtM.CodIter:=PCodIter;
      C017DtM.LivelliDest:=PLivelliDest;
      C017DtM.WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
      C017DtM.InviaEMail;
    except
      on E:Exception do
        ;//W000RegistraLog('Errore',GetTestoLog('W001D',GGetWebApplicationThreadVar) + '[C017] ' + E.Message);
    end;
  finally
    FreeAndNil(C017DtM);
  end;

  if (PDestinatari <> '') or (PDestinatariCC <> '') or (PDestinatariCCN <> '') then
  begin
    // In questo caso in aggiunta alla mail inviata precedentemente ne inviamo una ai destinatari
    // esplicitamente indicati
    C017DtM:=TC017FEMailDtM.Create(nil);
    try
      try
        C017DtM.SollevaEccezioni:=True;
        C017DtM.Sessione:=SessioneOracle;
        C017DtM.DestResponsabile:=False;
        C017DtM.Oggetto:=POggetto;
        C017DtM.Testo:=PTesto;
        C017DtM.TagFunzione:=PTag;
        C017DtM.CercaDestinatari:=False;
        C017DtM.Destinatari:=PDestinatari;
        C017DtM.DestinatariCC:=PDestinatariCC;
        C017DtM.DestinatariCCN:=PDestinatariCCN;
        C017DtM.WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
        C017DtM.InviaEMail;
      except
        on E:Exception do
          ;//W000RegistraLog('Errore',GetTestoLog('W001D',GGetWebApplicationThreadVar) + '[C017] ' + E.Message);
      end;
    finally
      FreeAndNil(C017DtM);
    end;
  end;
  {$ENDIF}{$ENDIF}
end;

procedure TC018FIterAutDM.MailPerRichiedente(Livello:Integer);
// Gestione mail verso dipendente
var
  MailOggetto,MailCorpo:String;
  MailTag: Integer;
begin
  if Parametri.CampiRiferimento.C90_EMailSMTPHost = '' then
    exit;
  if FInibisciMailPerRichiedente then
   exit;
  if not (R180CarattereDef(VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,Livello]),'INVIO_EMAIL'))) in ['R','E']) then
    exit;
  //Preparazione testo
  MailTag:=TagRichiesta;
  with selMailPerRichiedente do
  try
    SetVariable('PROGRESSIVO',selTabellaIter.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('ID',Id);
    SetVariable('LIVELLO',Livello);
    // MONZA_HSGERARDO - chiamata 88132.ini
    // gestione variabili nel testo della mail
    if VariableIndex('DELEGATO_DA') >= 0 then
      SetVariable('DELEGATO_DA',Parametri.ProfiloWEBDelegatoDa);
    // MONZA_HSGERARDO - chiamata 88132.fine
    Execute;
    MailOggetto:=FieldAsString('MAIL_OGGETTO');
    MailCorpo:=FieldAsString('MAIL_CORPO');
  except
    on E:Exception do
    begin
      MailOggetto:='';
      MailCorpo:='';
      {$IFDEF IRISWEB} {$IFNDEF WEBSVC}
      W000RegistraLog('Errore',GetTestoLog('C018') + 'Errore durante invio email al dipendente: ' + E.Message);
      {$ENDIF} {$ENDIF}
    end;
  end;
  //Richiamare InviaEMail con Iter,CodIter,ElencoLivelli
  if (MailOggetto <> '') or (MailCorpo <> '') then
  {$IFDEF IRISWEB}
  {$IFNDEF WEBSVC}
    WR000DM.InviaEMail(False,selTabellaIter.FieldByName('PROGRESSIVO').AsInteger,MailOggetto,MailCorpo,MailTag(*,Iter,CodIter,ElencoLivelli*));
  {$ENDIF}
  {$ENDIF}
  {$IFNDEF IRISWEB}
  {$IFNDEF WEBSVC}
    MailImmediata(False,selTabellaIter.FieldByName('PROGRESSIVO').AsInteger,MailOggetto,MailCorpo,MailTag(*,Iter,CodIter,ElencoLivelli*));
  {$ENDIF}
  {$ENDIF}
end;

procedure TC018FIterAutDM.SetIdRevoca(PIdRevoca:Integer);
begin
  FMessaggioOperazione:='';
  with updT850IdRevoca do
  begin
    ClearVariables;
    SetVariable('ITER',Iter);
    SetVariable('ID',Id);
    SetVariable('ID_REVOCA',PIdRevoca);
    Execute;
  end;
end;

procedure TC018FIterAutDM.AssegnaCodIter(parID:Integer; parIter,parCodIter:String);
{imposta il coditer assegnando direttamente il parametro NewCodIter}
begin
  if parCodIter <> '' then
    with updT850CodIter do
    begin
      ClearVariables;
      SetVariable('ITER',parIter);
      SetVariable('ID',parID);
      SetVariable('COD_ITER',parCodIter);
      Execute;
    end;
end;

procedure TC018FIterAutDM.SetCodIter;
{imposta il coditer riconosciuto dall'espressione sql per l'id corrente}
begin
  RicercaCodIter;
  if CodIter <> '' then
    with updT850CodIter do
    begin
      ClearVariables;
      SetVariable('ITER',Iter);
      SetVariable('ID',selTabellaIter.FieldByName('ID').AsInteger);
      SetVariable('COD_ITER',CodIter);
      Execute;
    end;
end;

function TC018FIterAutDM.GetCodIterFromId(const PId: Integer): String;
begin
  selT850.SetVariable('ID',PId);
  selT850.Execute;
  Result:=selT850.FieldAsString('COD_ITER');
end;

procedure TC018FIterAutDM.SetTipoRichiesta(PTipoRichiesta:String);
var
  LOldTipoRichiesta: String;
begin
  FMessaggioOperazione:='';

  // prepara log
  LOldTipoRichiesta:=FTipoRichiesta;
  if selTabellaIter.FindField('TIPO_RICHIESTA') <> nil then
    LOldTipoRichiesta:=selTabellaIter.FieldByName('TIPO_RICHIESTA').AsString;
  RegistraLog.SettaProprieta('M',TabellaIter,IterCodForm,nil,True);
  RegistraLog.InserisciDato('ID',Id.ToString,'');
  RegistraLog.InserisciDato('TIPO_RICHIESTA',LOldTipoRichiesta,PTipoRichiesta);
  if (Iter = ITER_MISSIONI) and (PTipoRichiesta = M140TR_4) then
    RegistraLog.InserisciDato('TIPO_AZIONE','','Chiusura richiesta missione');

  with updT850TipoRichiesta do
  begin
    ClearVariables;
    SetVariable('ITER',Iter);
    SetVariable('ID',Id);
    SetVariable('TIPO_RICHIESTA',PTipoRichiesta);
    Execute;
  end;

  RegistraLog.RegistraOperazione;
  FTipoRichiesta:=PTipoRichiesta;
end;

procedure TC018FIterAutDM.SetDataRichiesta(const PData:TDateTime = 0);
begin
  FMessaggioOperazione:='';
  with updT850Data do
  begin
    ClearVariables;
    SetVariable('ITER',Iter);
    SetVariable('ID',Id);
    if PData <> 0 then
      SetVariable('DATA',PData);
    Execute;
  end;
end;

function TC018FIterAutDM.AutorizzAutomaticaLivSucc(PLivello:Integer):Integer;
{restituisco il livello successivo se soddisfa la condizione di autorizzazione automatica}
var L,Liv:Integer;
    AALiv:String;
begin
  Result:=PLivello;
  Liv:=-1;
  AALiv:='';
  if (PLivello = 0) and selI096.SearchRecord('COD_ITER;OBBLIGATORIO',VarArrayOf([CodIter,'S']),[srFromBeginning]) then
    Liv:=selI096.FieldByName('LIVELLO').AsInteger
  else if (PLivello > 0) and selI096.SearchRecord('COD_ITER;LIVELLO;OBBLIGATORIO',VarArrayOf([CodIter,PLivello,'S']),[srFromBeginning]) then
  begin
    if selI096.SearchRecord('COD_ITER;OBBLIGATORIO',VarArrayOf([CodIter,'S']),[]) then
      Liv:=selI096.FieldByName('LIVELLO').AsInteger;
  end;
  if Liv > 0 then
  begin
    AALiv:=RicercaAutorizzAutomaticaLiv(Liv);
    if AALiv = 'S' then
    begin
      for L:=PLivello + 1 to Liv do
        Result:=InsAutorizzazione(L,C018SI,'(automatico)',C018SI,'');
    end;
  end;
end;

function TC018FIterAutDM.InsAutorizzazioniAutomatiche:Integer;
var
  L1,L2: Integer;
begin
  L1:=max(LivMaxAut,0);
  L2:=AutorizzAutomaticaLivSucc(L1);
  if L2 > L1 then
    MailPerAutorizzatore(L2,L2,'R');
  Result:=L2;
end;

function TC018FIterAutDM.InsAutorizzazione(PLivello:Integer; PStato,PResponsabile,PAutorizzAutomatica,PNote:String; PApplicaAutorizzIntermedia:Boolean = False):Integer;
var
  Liv:Integer;
  AllegatiObbligatori: Boolean;
begin
  FMessaggioOperazione:='';
  FStatoRichiesta:='';
  Result:=PLivello;
  if (selTabellaIter.FieldByName('TIPO_RICHIESTA').AsString <> '') and (FTipoRichiesta = '') then
    FTipoRichiesta:=selTabellaIter.FieldByName('TIPO_RICHIESTA').AsString; // tipo richiesta del record corrente
  if PApplicaAutorizzIntermedia and (PStato = C018SI) and selTabellaIter.FieldByName('ID_REVOCATO').IsNull then
    PStato:=R180CarattereDef(StringReplace(ValoriPossibili[PLivello],',','',[rfReplaceAll]));

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  // solo in caso di autorizzazione manuale, se uno dei livelli <= a quello corrente
  // prevede la presenza obbligatoria di allegati,
  // e questi non sono presenti, termina segnalando l'errore
  if PStato = C018SI then
  begin
    AllegatiObbligatori:=(PAutorizzAutomatica <> 'S') and
                         (LivMinAllegatiObbligatori > -1) and
                         (PLivello >= LivMinAllegatiObbligatori);
    if (AllegatiObbligatori) and
       (GetCondizioneAllegati = 'O') then
    begin
      LeggiAllegati;
      if not IDContieneAllegati then
      begin
        FMessaggioOperazione:='la richiesta prevede la presenza obbligatoria di allegati';
        Exit;
      end;
    end;
  end;
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

  updT851.ClearVariables;
  updT851.SetVariable('ID',Id);
  updT851.SetVariable('LIVELLO',PLivello);
  updT851.SetVariable('DATA',Now);
  updT851.SetVariable('STATO',PStato);
  updT851.SetVariable('RESPONSABILE',PResponsabile);
  (*
  // autorizzazione automatica e note non aggiornate
  SetVariable('AUTORIZZ_AUTOMATICA',PAutorizzAutomatica);
  SetVariable('NOTE',PNote);
  *)
  updT851.Execute;
  if updT851.RowsProcessed = 0 then
  begin
    // inserimento
    insT851.ClearVariables;
    insT851.SetVariable('ID',Id);
    insT851.SetVariable('LIVELLO',PLivello);
    insT851.SetVariable('DATA',Now);
    insT851.SetVariable('STATO',PStato);
    insT851.SetVariable('RESPONSABILE',PResponsabile);
    insT851.SetVariable('AUTORIZZ_AUTOMATICA',PAutorizzAutomatica);
    insT851.SetVariable('NOTE',PNote);
    insT851.Execute;
  end;
  if PAutorizzAutomatica <> 'S' then
  begin
    RegistraLog.SettaProprieta('I',TabellaIter,Copy(IterCodForm,1,4),nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',selTabellaIter.FieldByName('PROGRESSIVO').AsString);
    RegistraLog.InserisciDato('ID','',Id.ToString);
    RegistraLog.InserisciDato('LIVELLO','',PLivello.ToString);
    RegistraLog.InserisciDato('STATO','',PStato);
    RegistraLog.RegistraOperazione;
  end;

  //Alberto 24/11/2013: esecuzione dello script anche quando Stato = ''
  //if (Stato <> '') and (Trim(VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,Livello]),'SCRIPT_AUTORIZZ'))) <> '') then
  if (Trim(VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,PLivello]),'SCRIPT_AUTORIZZ'))) <> '') then
    EseguiScriptAutorizz(PLivello,PStato,PResponsabile,PAutorizzAutomatica,Trim(VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,PLivello]),'SCRIPT_AUTORIZZ'))));
  if (PLivello = LivMaxObb) or (PStato = C018NO) then
  begin
    //Imposto i valori per il livello 0 se sono sull'ultimo livello obbligatorio, oppure l'autorizzazione è negata
    if VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,PLivello]),'OBBLIGATORIO')) = 'S' then
      SetStato(PStato,0);
    if PAutorizzAutomatica = 'S' then
      SetAutorizzAutomatica('S',0);
  end
  else
  begin
    if VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,PLivello]),'OBBLIGATORIO')) = 'S' then
      //non sono su ultimo livello e lo stato è obbligatorio: annullo lo stato al livello 0
      SetStato('',0);
    //Gestione autorizzazione revoca a S
    if PStato = C018SI (*and IDRevocato > 0??*) then
    begin
      with selMaxLivelloAut do
      begin
        //Verifica se è una revoca;
        //Se sì, verifica l'ultimo livello obbligatorio della richiesta REVOCATA con stato = S;
        //se Livello = livello richiesta autorizzata, si setta lo stato = 'S' per tutti i livelli obbligatori restanti
        SetVariable('AZIENDA',Parametri.Azienda);
        SetVariable('ITER',Iter);
        SetVariable('ID',Id);
        Execute;
        if PLivello = FieldAsInteger('LIVELLO_MAX') then
        begin
          if selI096.SearchRecord('COD_ITER;OBBLIGATORIO',VarArrayOf([CodIter,'S']),[srFromBeginning]) then
            repeat
              Liv:=selI096.FieldByName('LIVELLO').AsInteger;
              if Liv > PLivello then
              begin
                InsAutorizzazione(Liv,C018SI,'','','');
                Break;  //Mi fermo sul primo livello successivo perchè i livelli successivi vengono già gestiti dalla chiamata ricorsiva
              end;
            until not selI096.SearchRecord('COD_ITER;OBBLIGATORIO',VarArrayOf([CodIter,'S']),[]);
        end;
      end;
    end;
    //Gestione autorizzazione a S e prossimo livello con autorizzazione automatica
    if (PStato = C018SI) and (VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,PLivello]),'OBBLIGATORIO')) = 'S') then
      Result:=AutorizzAutomaticaLivSucc(PLivello);
  end;

  if Result = PLivello then
  begin
    with T851F_FASE_CORRENTE do
    begin
      SetVariable('COD_ITER',CodIter);
      SetVariable('ID',Id);
      Execute;
      FFaseCorrente:=StrToIntDef(VarToStr(GetVariable('FASE')),-1);
    end;
  end;

  //Verificare se il prox livello obbligatorio ha la condizione di autorizzazione automatica
  //se sì, si deve richiamare InsAutorizzazione per il prox livello,
  //e la mail per il responsabile deve partire solo se il prox livello non ha l'autorizzazione automatica
  if (VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,PLivello]),'OBBLIGATORIO')) = 'S') and (Result = PLivello)(*(AutorizzAutomatica <> 'S')*) then
  begin
    //Gestione mail verso il prossimo autorizzatore
    if PStato = C018SI then
      MailPerAutorizzatore(PLivello,PLivello,'R');
    //Gestione mail verso il dipendente
    if ((PLivello = LivMaxObb) and (PStato <> '')) or (PStato = C018NO) then
    begin
      //Non invio subito la mail al richiedente, se è prevista la'Acquisizione automatica sul cartellino
      //La mail viene inviata successivamente da A004MW / A023MW, quando si confermano le autorizzazioni.
      if ((Iter <> ITER_GIUSTIF) or (Parametri.CampiRiferimento.C90_EMailW010Uff <> 'I'))
      and
         ((Iter <> ITER_TIMBR) or (Parametri.CampiRiferimento.C90_EMailW018Uff <> 'I'))
      then
        MailPerRichiedente(PLivello);
    end
    else if (PLivello = LivAutIntermedia) and (PStato = ValAutIntermedia) then
      MailPerRichiedente(PLivello);
  end;
end;

procedure TC018FIterAutDM.InsUltimeAutorizzazioni(PDaLivello:Integer; PStato,PResponsabile,PAutorizzAutomatica,PNote:String; PObbligatorie:Boolean; InibisciMailPerRichiedente:Boolean = True);
var Liv:Integer;
begin
  FMessaggioOperazione:='';
  FInibisciMailPerRichiedente:=InibisciMailPerRichiedente;
  FInibisciMailPerAutorizzatore:=True;
  try
    if selI096.Active then
    begin
      if selI096.SearchRecord('COD_ITER',CodIter,[srFromBeginning]) then
        repeat
          Liv:=selI096.FieldByName('LIVELLO').AsInteger;
          if (Liv >= PDaLivello) and ((selI096.FieldByName('OBBLIGATORIO').AsString = 'S') or (not PObbligatorie)) then
          begin
            Liv:=InsAutorizzazione(Liv,PStato,PResponsabile,PAutorizzAutomatica,PNote);
            selI096.SearchRecord('COD_ITER;LIVELLO',VararrayOf([CodIter,Liv]),[srFromBeginning]);
          end;
        until not selI096.SearchRecord('COD_ITER',CodIter,[]);
    end;
  finally
    FInibisciMailPerRichiedente:=False;
    FInibisciMailPerAutorizzatore:=False;
  end;
end;

// EMPOLI_ASL11 - chiamata 82422.ini
// gestione data/ora ultima modifica note

function TC018FIterAutDM.CronologiaNotePresente(const PNote: String): Boolean;
// restituisce True se nelle note è presente l'indicazione di data/ora
// nella prima riga del testo (convenzione)
// oppure False altrimenti
var
  NoteArr: TArray<String>;
  Valore: TDateTime;
begin
  Result:=False;

  // se le note sono vuote esce subito
  if PNote.Trim = '' then
    Exit;

  // se il parametro aziendale corrispondente non è attivo esce subito
  if Parametri.CampiRiferimento.C90_CronologiaNote <> 'S' then
    Exit;

  // splitta le note in un array di 1 elemento che contiene la prima riga
  NoteArr:=PNote.Split([CRLF],1,none);

  // se l'array è vuoto (anomalia) esce subito
  if Length(NoteArr) = 0 then
    Exit;

  // se la riga è un date/time valido restituisce true
  Result:=TryStrToDateTime(NoteArr[0],Valore);
end;

function TC018FIterAutDM.PulisciCronologiaNote(const PNote: String): String;
// restituisce le note senza l'indicazione di data/ora riportata convenzionalmente
// nella prima riga del testo (opzionalmente)
var
  p: Integer;
begin
  Result:=PNote;

  // se le note sono vuote esce subito
  if PNote.Trim = '' then
    Exit;

  // se il parametro aziendale corrispondente non è attivo esce subito
  if Parametri.CampiRiferimento.C90_CronologiaNote <> 'S' then
    Exit;

  // se non è presente l'indicazione di data/ora sulla prima riga esce subito
  if not CronologiaNotePresente(PNote) then
    Exit;

  // PRE: la prima riga del testo contiene l'indicazione di data/ora
  // restituisce la sottostringa dopo la prima occorrenza di CRLF
  p:=Pos(CRLF,PNote);
  if p = 0 then
  begin
    // solo una riga con data/ora -> note vuote
    Result:=''
  end
  else
  begin
    // restituisce solo le note
    Result:=PNote.Substring(p + 1);
  end;
end;

function TC018FIterAutDM.ImpostaCronologiaNote(const PNote: String): String;
// aggiunge oppure modifica le note in modo da riportare convenzionalmente nella
// prima riga del testo l'indicazione della data/ora in cui sono state modificate
var
  p: Integer;
  OraStr: String;
begin
  Result:=PNote;

  // se il parametro aziendale corrispondente non è attivo esce subito
  if Parametri.CampiRiferimento.C90_CronologiaNote <> 'S' then
    Exit;

  // dato orario da inserire convenzionalmente nella prima riga delle note
  OraStr:=FormatDateTime('dd/mm/yyyy hh.mm',Now) + CRLF;

  if CronologiaNotePresente(PNote) then
  begin
    // aggiorna data/ora presenti nella prima riga

    // PRE: la prima riga del testo contiene l'indicazione di data/ora
    // restituisce data/ora + eventuali note già presenti (sottostringa dopo la prima occorrenza di CRLF)
    p:=Pos(CRLF,PNote);
    if p = 0 then
    begin
      // note vuote: imposta solo l'ora di modifica
      Result:=OraStr;
    end
    else
    begin
      // note valorizzate: le accoda all'ora di modifica
      Result:=OraStr + PNote.Substring(p + 1);
    end;
  end
  else
  begin
    // inserisce data/ora nella prima riga
    Result:=PNote.Insert(0,OraStr);
  end;
end;
// EMPOLI_ASL11 - chiamata 82422.fine

// EMPOLI_ASL11 - chiamata 82422.ini
// la procedure è stata trasformata in function, e restituisce le note realmente salvate su db,
// che potrebbero essere state modificate per effetto del parametro "Web: cronologia note"
function TC018FIterAutDM.SetNote(PNote:String; PLivello:Integer): String;
// EMPOLI_ASL11 - chiamata 82422.fine
// aggiorna le note sul livello indicato
begin
  FMessaggioOperazione:='';

  // EMPOLI_ASL11 - chiamata 82422.ini
  // se è attiva l'impostazione a livello aziendale imposta la data/ora di ultima modifica delle note
  // (convenzionalmente sulla prima riga delle note)
  if Parametri.CampiRiferimento.C90_CronologiaNote = 'S' then
    PNote:=ImpostaCronologiaNote(PNote);
  // EMPOLI_ASL11 - chiamata 82422.fine

  if PLivello = 0 then
  begin
    // note della richiesta
    with updT850Note do
    begin
      ClearVariables;
      SetVariable('ITER',Iter);
      SetVariable('ID',Id);
      SetVariable('NOTE',PNote);
      Execute;
    end;
  end
  else
  begin
    // note del livello di autorizzazione
    with updT851Note do
    begin
      ClearVariables;
      SetVariable('ID',Id);
      SetVariable('LIVELLO',PLivello);
      SetVariable('NOTE',PNote);
      Execute;
    end;
    if updT851Note.RowsProcessed = 0 then
    begin
      with insT851 do
      begin
        ClearVariables;
        SetVariable('ID',Id);
        SetVariable('LIVELLO',PLivello);
        SetVariable('DATA',Now);
        SetVariable('RESPONSABILE',Parametri.Operatore);
        SetVariable('NOTE',PNote);
        Execute;
      end;
    end;
  end;

  // EMPOLI_ASL11 - chiamata 82422.ini
  Result:=PNote;
  // EMPOLI_ASL11 - chiamata 82422.ini
end;

procedure TC018FIterAutDM.SetStato(PStato:String; PLivello:Integer);
var Liv:Integer;
begin
  FMessaggioOperazione:='';
  if PLivello = 0 then
  begin
    with updT850Stato do
    begin
      ClearVariables;
      SetVariable('ITER',Iter);
      SetVariable('ID',Id);
      SetVariable('STATO',PStato);
      Execute;
      //Registro stato appena impostato in modo che sia accessibile dalla property
      FStatoRichiesta:=PStato;
    end;
  end
  else
  begin
    with updT851Stato do
    begin
      ClearVariables;
      SetVariable('ID',Id);
      SetVariable('LIVELLO',PLivello);
      SetVariable('STATO',PStato);
      Execute;
    end;
  end;
  if (PLivello > 0) and (PLivello = LivMaxObb) then
    SetStato(PStato,0);
  Liv:=PLivello;
  if (PLivello > 0) and (PStato = C018SI) then
    Liv:=AutorizzAutomaticaLivSucc(PLivello);

  // bugfix.ini
  // ridetermina fase corrente
  with T851F_FASE_CORRENTE do
  begin
    SetVariable('COD_ITER',CodIter);
    SetVariable('ID',Id);
    Execute;
    FFaseCorrente:=StrToIntDef(VarToStr(GetVariable('FASE')),-1);
  end;
  // bugfix.fine

  if (VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,PLivello]),'OBBLIGATORIO')) = 'S') then
  begin
    //Gestione mail verso il prossimo autorizzatore
    if (PStato = C018SI) and (Liv = PLivello) then
      MailPerAutorizzatore(PLivello,PLivello,'R');
    //Gestione mail verso il dipendente
    if ((PLivello = LivMaxObb) and (PStato <> '')) or (PStato = C018NO) then
    begin
      if ((Iter <> ITER_GIUSTIF) or (Parametri.CampiRiferimento.C90_EMailW010Uff <> 'I'))
      and
         ((Iter <> ITER_TIMBR) or (Parametri.CampiRiferimento.C90_EMailW018Uff <> 'I'))
      then
        MailPerRichiedente(PLivello);
    end;
  end;
end;

procedure TC018FIterAutDM.SetAutorizzAutomatica(PAutorizzAutomatica:String; PLivello:Integer);
begin
  FMessaggioOperazione:='';
  if PLivello = 0 then
    with updT850AutorizzAutomatica do
    begin
      ClearVariables;
      SetVariable('ITER',Iter);
      SetVariable('ID',Id);
      SetVariable('AUTORIZZ_AUTOMATICA',PAutorizzAutomatica);
      Execute;
    end
  else
    with updT851AutorizzAutomatica do
    begin
      ClearVariables;
      SetVariable('ID',Id);
      SetVariable('LIVELLO',PLivello);
      SetVariable('AUTORIZZ_AUTOMATICA',PAutorizzAutomatica);
      Execute;
    end;
end;

procedure TC018FIterAutDM.SetDatoAutorizzatore(PDato,PValore:String; PLivello:Integer);
// Setta il dato modificato dall'autorizzatore
begin
  FMessaggioOperazione:='';
  PValore:=Copy(Trim(PValore),1,30);
  with insupdT852 do
  begin
    ClearVariables;
    SetVariable('ID',Id);
    SetVariable('LIVELLO',PLivello);
    SetVariable('DATO',PDato);
    SetVariable('VALORE',PValore);
    SetVariable('RESPONSABILE',Parametri.Operatore);
    Execute;
  end;
  selT852.Close;  //Chiudo il dataset usato da GetDatoAutorizzatore per forzare il refresh
end;

procedure TC018FIterAutDM.DelDatoAutorizzatore(const PDato:String; const PLivello:Integer);
// Elimina la modifica del dato precedentemente impostato dall'autorizzatore
begin
  FMessaggioOperazione:='';
  with delT852 do
  begin
    ClearVariables;
    SetVariable('ID',Id);
    SetVariable('LIVELLO',PLivello);
    SetVariable('DATO',PDato);
    Execute;
  end;
  selT852.Close; //Chiudo il dataset per forzare il refresh
end;

function TC018FIterAutDM.GetDatoAutorizzatore(PDato:String; PLivello:String = ''):TC018DatoAutorizzatore;
// Legge le modifiche registrate dagli autorizzatori all'ultimo livello
var ILivello:Integer;
begin
  FMessaggioOperazione:='';
  Result.Esiste:=False;
  Result.Valore:='';
  Result.Livello:=0;
  R180SetVariable(selT852,'ID',Id);
  if TryStrToInt(PLivello,ILivello) then
    R180SetVariable(selT852,'LIVELLO',IntToStr(Abs(ILivello)))
  else
    R180SetVariable(selT852,'LIVELLO','(select max(LIVELLO) from T852_ITER_DATI_AUTORIZZATORI where ID = :ID and DATO = T852.DATO)');
  with selT852 do
  begin
    Open;
    if SearchRecord('DATO',PDato,[srFromBeginning]) then
    begin
      Result.Esiste:=True;
      Result.Valore:=FieldByName('VALORE').AsString;
      Result.Livello:=FieldByName('LIVELLO').AsInteger;
    end;
  end;
end;

function TC018FIterAutDM.ModificaValori(PLivello:Integer):Boolean;
// Indica se il livello prevede la possibilità di modificare i valori richiesti dall'utente
begin
  FMessaggioOperazione:='';
  Result:=VarToStr(selI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([CodIter,PLivello]),'DATI_MODIFICABILI')) = 'S';
end;

procedure TC018FIterAutDM.LeggiResponsabiliFasi;
begin
  with selT851RespFasi do
  begin
    Close;
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('ITER',Iter);
    SetVariable('COD_ITER',CodIter);
    SetVariable('ID',Id);
    Open;
  end;
end;

procedure TC018FIterAutDM.LeggiIterCompleto(PForzaChiusura:Boolean = True);
begin
  if PForzaChiusura then
    selT851.Close;
  R180SetVariable(selT851,'AZIENDA',Parametri.Azienda);
  R180SetVariable(selT851,'ITER',Iter);
  R180SetVariable(selT851,'COD_ITER',CodIter);
  R180SetVariable(selT851,'ID',Id);
  // TORINO_COMUNE
  // commentata questa parte aggiunta per risolvere lentezza presso ROMA_HSANTANDREA
  // vedi mail di Eleuteri ad Alberto del 07/02/2013
  // così come è definita la query non si può utilizzare la tabella T325: l'ID utilizzato
  // per la join con T850 deve essere quello della vista VT325 (che ridefinisce il T326.ID_T850)
  // e non quello della tabella T325, che non è in relazione
  {
  if Iter = ITER_STRGIORNO then
    R180SetVariable(selT851,'TABELLA','T325_RICHIESTESTR_GG')
  else
  }
  R180SetVariable(selT851,'TABELLA',TabellaIter);
  // TORINO_COMUNE.fine
  //Alberto 11/07/2013: per ROMA_HSANDREA la vista VT325_RICHIESTESTR_GG_EU è troppo lenta. Provare con la vista ad hoc VT325_ID_T850
  if TabellaIter = 'VT325_RICHIESTESTR_GG_EU' then
    R180SetVariable(selT851,'TABELLA','VT325_ID_T850');
  selT851.Open;
end;

function TC018FIterAutDM.LeggiNoteComplete(PFormatoHTML:Boolean = True):String;
//Lettura delle note da visualizzare nell'hint desiderato.
//I ritorni a capo sono realizzati con <br>
//Il tag <html> serve per essere gestito correttamente da jQuery
var
  LNote, LTradNessunaNota: String;
begin
  Result:='';
  FNoteIndicate:=False;
  LTradNessunaNota:=A000TraduzioneStringhe(A000MSG_WC018_MSG_NESSUNA_NOTA);

  // apre il dataset selT851 per estrarre i dati delle autorizzazioni
  LeggiIterCompleto;

  with selT851 do
  begin
    First;
    while not Eof do
    begin
      LNote:=Trim(FieldByName('NOTE').AsString);

      //Visualizzo nominativo e note solo se esistono e se non si tratta di Autorizzazione Automatica
      if (((LNote <> '') or (Trim(FieldByName('NOMINATIVO').AsString) <> '')) and (FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S'))
         or
         ((LNote <> '') and (FieldByName('AUTORIZZ_AUTOMATICA').AsString = 'S')) then
      begin
        if Result <> '' then
          Result:=Result + CRLF + CRLF;
        Result:=Result + FieldByName('NOMINATIVO').AsString;
        if not FieldByName('STATO').IsNull then
          Result:=Result + Format(' (%s)',[FieldByName('STATO').AsString]);
        Result:=Result + CRLF;
        if LNote = '' then
        begin
          // nessuna nota
          Result:=Result + LTradNessunaNota;
        end
        else
        begin
          Result:=Result + LNote;
          FNoteIndicate:=True;
        end;
      end;
      Next;
    end;
  end;

  // nessuna nota
  if Trim(Result) = '' then
  begin
    Result:=LTradNessunaNota;
  end;

  // formato html
  if PFormatoHTML then
  begin
    Result:=Result.Replace(CRLF,'<br>',[rfReplaceAll]);

    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    // visualizza la struttura nell'hint dei dettagli
    Result:=Format('<html><h3>Struttura %s</h3>%s',[DescCodIter,Result]);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
  end;
end;

function TC018FIterAutDM.LeggiAllegati(PFormatoHTML:Boolean = True): String;
// apre il dataset degli allegati con l'id della richiesta attuale
// quindi restituisce una stringa con l'elenco dei nomi degli allegati
var
  FmtRiga: String;
begin
  try
    // apertura dataset
    selT853_T960.Close;
    R180SetVariable(selT853_T960,'ID',Id);
    selT853_T960.ReadBuffer:=Max(500,StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxAllegati,999));
    selT853_T960.Open;
    FIDContieneAllegati:=selT853_T960.RecordCount > 0;

    if FIDContieneAllegati then
    begin
      // imposta la stringa con l'elenco dei nomi degli allegati
      Result:='';

      // formato riga
      if PFormatoHTML then
        FmtRiga:='<tr><td>%s.%s</td><td style=''text-align: right;''>(%s)</td></tr>'
      else
        FmtRiga:='%s.%s (%s)'#13#10;

      selT853_T960.First;
      while not selT853_T960.Eof do
      begin
        Result:=Result + Format(FmtRiga,
                                [selT853_T960.FieldByName('NOME_FILE').AsString,
                                 selT853_T960.FieldByName('EXT_FILE').AsString,
                                 R180GetFileSizeStr(selT853_T960.FieldByName('DIMENSIONE').AsInteger)]);
        selT853_T960.Next;
      end;
      selT853_T960.First;
    end
    else
    begin
      // imposta la dicitura "nessun allegato"
      Result:=Format('<tr><td colspan=2 style=''text-align: center;''>%s</td>',[A000TraduzioneStringhe(A000MSG_C018_MSG_NESSUN_ALLEGATO)]);
    end;

    // formato html
    if PFormatoHTML then
    begin
      // visualizza l'id richiesta nell'hint dei dettagli
      Result:=Format('<html><h3>Allegati richiesta</h3><table style=''border: 0 none;''><tbody>%s</tbody></table>',[Result]);
    end;
  except
    on E: Exception do
    begin
      FIDContieneAllegati:=False;
      Result:=E.Message;
    end;
  end;
end;

function TC018FIterAutDM.GetVistiPrecedenti(const PLivAttuale: Integer):String;
// La funzione concatena i valori di STATO dei livelli compresi tra il livello attuale
// e il livello obbligatorio immediatamente precedente (esclusi)
// che verificano la condizione AVVISO = 'S'
var
  NumVisti: Integer;
  VistoUnico: String;
begin
  Result:='';

  // la ricerca di visti precedenti ha senso solo dal livello 2 in su
  if PLivAttuale <= 1 then
    Exit;

  // se non sono presenti livelli con Avviso = 'S' restituisce False
  if not selI096.SearchRecord('AVVISO','S',[srFromBeginning]) then
    Exit;

  LeggiIterCompleto(False);
  NumVisti:=0;
  with selT851 do
  begin
    // posizionamento sul livello attuale
    if SearchRecord('LIVELLO',PLivAttuale,[srFromEnd]) then
    begin
      // cicla sui livelli non obbligatori precedenti a quello attuale
      Prior;
      while (not Bof) and (FieldByName('OBBLIGATORIO').AsString <> 'S') do
      begin
        if (FieldByName('AVVISO').AsString = 'S') and (FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and (FieldByName('STATO').AsString <> '') then
        begin
          Result:=Format('Liv. %s: %s%s',[FieldByName('LIVELLO').AsString,
                                          FieldByName('STATO').AsString,
                                          CRLF]) + Result;
          VistoUnico:=FieldByName('STATO').AsString;
          NumVisti:=NumVisti + 1;
        end;
        Prior;
      end;
    end;
  end;

  if NumVisti = 1 then
    Result:=VistoUnico
  else if NumVisti > 1 then
    Result:=Copy(Result,1,Length(Result) - 2);
end;

function TC018FIterAutDM.StatoAutorizzato(Stato:String):Boolean;
begin
  Result:=(Stato <> C018NO) and (Stato <> '');
end;

function TC018FIterAutDM.StatoNegato(Stato:String):Boolean;
begin
  Result:=Stato = C018NO;
end;

{$IFNDEF WEBSVC}
{$IFDEF IRISWEB}
function TC018FIterAutDM.SetIconaAllegati(PImg: TmeIWImageFile): TStatoAllegati;
// restituisce True se l'immagine è visibile e cliccabile
var
  OldCss, GestAllegati, AllegVisibili, TestoHint, Legenda,
  RowIDRichiesta, AutorizzAuto: String;
  AllegObblig: Boolean;
  LivAut, PuntoInserimentoLegenda: Integer;
  BM: TBookmark;
const
  RIGA_LEGENDA = '<tr><td colspan=2><span class=''%s'' style=''display: inline-block; width: 12px; height: 12px; margin-right: 2px;''>&nbsp;</span><span> %s</span></td></tr>';
begin
  // inizializzazioni
  Result.Condizione:=aNonRichiesti;
  Result.Visibilita:=aNonVisibile;
  OldCss:=PImg.Css;
  PImg.Css:='invisibile';
  PImg.ImageFile.FileName:=fileImgAllegati;
  PImg.Hint:='';
  RowIDRichiesta:=PImg.FriendlyName;

  // esce se non è attiva la gestione allegati a livello di iter / cod. iter
  //   icona visibile:   no
  //   icona cliccabile: no
  //   hint visibile:    no
  if (not EsisteGestioneAllegati) or
     (not EsisteGestioneAllegatiCodIter) then
    Exit;

  // è necessario il posizionamento su rowid della richiesta corrente
  // per la corretta valutazione delle variabili nella condizione allegati
  BM:=selTabellaIter.GetBookmark;
  try
    if selTabellaIter is TOracleDataSet then
      TOracleDataSet(selTabellaIter).SearchRecord('ROWID',RowIDRichiesta,[srFromBeginning])
    else
      raise Exception.Create('non implementato!'); //selTabellaIter.RecNo:=RowIDRichiesta.ToInteger; // verificare

    // valuta condizione allegati risolvendo sulla singola richiesta:
    // - eventuale espressione sql
    // - regola T230.CONDIZIONE_ALLEGATI sulla causale se iter = T050
    GestAllegati:=GetCondizioneAllegati;
    // esce se la richiesta non prevede allegati
    if GestAllegati = 'N' then
      Exit;

    // legge gli allegati e imposta variabili per successivi controlli
    TestoHint:=LeggiAllegati;
    PuntoInserimentoLegenda:=TestoHint.IndexOf('<tbody>') + '<tbody>'.Length;

    // salva livello corrente
    LivAut:=selTabellaIter.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
    AutorizzAuto:=selTabellaIter.FieldByName('AUTORIZZ_AUTOMATICA').AsString;

    // imposta l'icona degli allegati
    if IDContieneAllegati then
    begin
      // icona allegati gialla (evidenzia presenza allegati)
      PImg.ImageFile.FileName:=fileImgAllegatiHighlight;
      Legenda:=Format(RIGA_LEGENDA,['bg_giallo','allegati presenti']);
      Result.Condizione:=aPresenti;
    end
    else
    begin
      // se non sono presenti allegati
      // - se la richiesta ha gli allegati obbligatori (per l'autorizzatore verifica
      //   l'obbligatorietà al livello di autorizzazione e l'assenza di autorizzazione automatica)
      //   -> imposta icona rossa (evidenzia obbligatorietà)
      // - altrimenti
      //   -> imposta icona grigia
      AllegObblig:=(GestAllegati = 'O') and (GetAllegatiObbligatori(LivAut) = 'S') and (AutorizzAuto <> 'S');
      if AllegObblig then
      begin
        PImg.ImageFile.FileName:=fileImgAllegatiObblig;
        Legenda:=Format(RIGA_LEGENDA,['bg_rosso','allegati obbligatori']);
        Result.Condizione:=aObbAssenti;
      end
      else
      begin
        PImg.ImageFile.FileName:=fileImgAllegati;
        Legenda:=Format(RIGA_LEGENDA,['bg_alleg_facoltativi','allegati facoltativi']);
        Result.Condizione:=aOpzAssenti;
      end;
    end;
    TestoHint:=TestoHint.Insert(PuntoInserimentoLegenda,Legenda);

    // rende visibile l'icona
    PImg.Css:=OldCss;

    // se la visibilità degli allegati è impedita,
    // visualizza l'icona ma non la rende cliccabile e nasconde il tooltip
    //   icona visibile:   sì
    //   icona cliccabile: no
    //   hint visibile:    no
    AllegVisibili:=GetAllegatiVisibili(LivAut);
    if AllegVisibili = 'N' then
    begin
      Result.Visibilita:=aNonVisibile;
      Exit
    end;

    // imposta il tooltip e rende cliccabile l'icona
    //   icona visibile:   sì
    //   icona cliccabile: sì
    //   hint visibile:    sì
    PImg.Hint:=TestoHint;
    Result.Visibilita:=aVisibile;

    // ripristina il bookmark
    if selTabellaIter.BookmarkValid(BM) then
      selTabellaIter.GotoBookmark(BM);
  finally
    selTabellaIter.FreeBookmark(BM);
  end;
end;

procedure TC018FIterAutDM.SetValoriAut(grd: TmedpIWDBGrid; rowGrd,rowComp,idxS,idxN: Integer;
  chkAutorizzazioneClick: TprocObject);
var
  TmpLivAut: Integer;
  TmpAut: String;
begin
  if grd = nil then
    Exit;

  // variabili di supporto
  TmpAut:=grd.medpValoreColonna(rowGrd,'AUTORIZZ_UTILE');
  TmpLivAut:= StrToIntDef(grd.medpValoreColonna(rowGrd,'LIVELLO_AUTORIZZAZIONE'),0);

  // check autorizzazione SI
  if idxS >= 0 then
  begin
    with (grd.medpCompCella(rowGrd,rowComp,idxS) as TmeIWCheckBox) do
    begin
      Checked:=StatoAutorizzato(TmpAut);
      Css:=Css + ' autSi';
      OnClick:=chkAutorizzazioneClick;
    end;
  end;

  // check autorizzazione NO
  if idxN >= 0 then
  begin
    with (grd.medpCompCella(rowGrd,rowComp,idxN) as TmeIWCheckBox) do
    begin
      if NumValoriPossibili[TmpLivAut] = 1 then
        Css:='invisibile'
      else
        Css:=Css + ' autNo';
      Checked:=StatoNegato(TmpAut);
      OnClick:=chkAutorizzazioneClick;
    end;
  end;
end;

function TC018FIterAutDM.IncludiTipoRichieste(const PTipoRichieste: TTipoRichieste): Boolean;
// include nelle richieste selezionate la tipologia specificata
// restituisce True se sono state apportate modifiche alle richieste selezionate, False altrimenti
begin
  // non permette di includere una tipologia di richieste non prevista
  // nell'elenco di quelle disponibili
  if (PTipoRichieste in TipoRichiesteDisp) then
  begin
    if IsSceltaEsclusivaTipoRichieste then
    begin
      Result:=TipoRichiesteSel <> [PTipoRichieste];
      if Result then
        TipoRichiesteSel:=[PTipoRichieste]
    end
    else
    begin
      Result:=not (PTipoRichieste in TipoRichiesteSel);
      if Result then
        TipoRichiesteSel:=TipoRichiesteSel + [PTipoRichieste];
    end;
  end
  else
    Result:=False;
end;
{$ENDIF}
{$ENDIF}

procedure TC018FIterAutDM.DataModuleDestroy(Sender: TObject);
{$IFDEF IRISWEB}
{$IFNDEF WEBSVC}
var
  IdRich: String;
{$ENDIF}
{$ENDIF}
begin
  try
  // daniloc.ini - 09.08.2012
  // gestione errore su iter T050 (giustificativi):
  // se tipo richiesta è 'X' (esclusa dai conteggi in fase di definizione)
  // occorre riportarla a 'P' (preventiva)
  {$IFDEF IRISWEB}
  {$IFNDEF WEBSVC}
  if (Iter = ITER_GIUSTIF) and
     (EsisteAutorizzIntermedia) and
     (TipoRichiesta = 'X') then
  begin
    try
      IdRich:=IntToStr(Id);
    except
      IdRich:='#N/D#';
    end;
    W000RegistraLog('Errore',GetTestoLog('C018') + 'Attenzione: la richiesta ' + IdRich + ' risulta in stato X = Esclusa dai conteggi');
    try
      SetTipoRichiesta('P');
      updT850TipoRichiesta.Session.Commit;
      W000RegistraLog('Errore',GetTestoLog('C018') + 'Attenzione: la richiesta ' + IdRich + ' è stata ripristinata allo stato P = Preventiva');
    except
      on E: Exception do
        W000RegistraLog('Errore',GetTestoLog('C018') + 'Errore: la richiesta ' + IdRich + ' non è stata ripristinata allo stato P = Preventiva per il seguente errore: ' + E.Message);
    end;
  end;
  {$ENDIF}
  {$ENDIF}
  // daniloc.fine
  try selI093.Session.Commit; except end;
  FreeAndNil(selDatiBloccati);
  FreeAndNil(lstIdFiltrati);
  FreeAndNil(FPeriodo);
  inherited;
 except
 end;
end;

end.
