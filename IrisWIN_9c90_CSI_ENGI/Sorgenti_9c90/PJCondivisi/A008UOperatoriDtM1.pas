unit A008UOperatoriDtM1;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, dbctrls, DBGrids, Math, A000UCostanti, A000USessione, A000UInterfaccia,  C180FunzioniGenerali,
  RegistrazioneLog, L021Call, OracleData, Oracle, Variants, USelI010, DBClient,
  A181UAziendeMW, A185UFiltroDizionarioMW, RegolePassword, A000UMessaggi, OracleMonitor;

type
  TFiltroProfiliI061 = record
    Attivo:Boolean;
    NomeProfilo,
    Permessi,
    FiltroAnagrafe,
    FiltroFunzioni,
    IterAutorizzativi,
    FiltroDizionario:String;
  end;

  TA008FOperatoriDtM1 = class(TDataModule)
    D090: TDataSource;
    D091: TDataSource;
    QI090: TOracleDataSet;
    QI090AZIENDA: TStringField;
    QI090DESCRIZIONE: TStringField;
    QI090INDIRIZZO: TStringField;
    QI090STORIAINTERVENTO: TStringField;
    QI090UTENTE: TStringField;
    QI090PAROLACHIAVE: TStringField;
    QI090TSLAVORO: TStringField;
    QI090TSINDICI: TStringField;
    QI091: TOracleDataSet;
    QI091AZIENDA: TStringField;
    QI091TIPO: TStringField;
    QI091DATO: TStringField;
    QI091D_Tipo: TStringField;
    _Ins091: TOracleQuery;
    QI092: TOracleDataSet;
    _Del092: TOracleQuery;
    _Ins092: TOracleQuery;
    QI070: TOracleDataSet;
    QI070AZIENDA: TStringField;
    QI070UTENTE: TStringField;
    QI070PASSWD: TStringField;
    QI070OCCUPATO: TStringField;
    QI070INTEGRAZIONEANAGRAFE: TStringField;
    QI070D_Azienda: TStringField;
    T035: TOracleDataSet;
    OperSQL: TOracleQuery;
    DbIris008B: TOracleSession;
    QCOLS: TOracleDataSet;
    QI070SBLOCCO: TStringField;
    QI090TIMBORIG_VERSO: TStringField;
    QI090TIMBORIG_CAUSALE: TStringField;
    selI071: TOracleDataSet;
    selI072: TOracleDataSet;
    selI073: TOracleDataSet;
    selI074: TOracleDataSet;
    selI072Dist: TOracleDataSet;
    selI073Dist: TOracleDataSet;
    selI074Dist: TOracleDataSet;
    dsrI072Dist: TDataSource;
    dsrI073Dist: TDataSource;
    dsrI074Dist: TDataSource;
    dsrI071: TDataSource;
    dsrI072: TDataSource;
    dsrI073: TDataSource;
    dsrI074: TDataSource;
    insI071: TOracleQuery;
    selValues: TOracleDataSet;
    insI072: TOracleQuery;
    insI073: TOracleQuery;
    insI074: TOracleQuery;
    selDizionario: TOracleDataSet;
    QI070PERMESSI: TStringField;
    QI070FILTRO_ANAGRAFE: TStringField;
    QI070FILTRO_FUNZIONI: TStringField;
    QI070FILTRO_DIZIONARIO: TStringField;
    QI070PROGRESSIVO: TIntegerField;
    selI073PROFILO: TStringField;
    selI073APPLICAZIONE: TStringField;
    selI073TAG: TIntegerField;
    selI073FUNZIONE: TStringField;
    selI073GRUPPO: TStringField;
    selI073DESCRIZIONE: TStringField;
    selI073INIBIZIONE: TStringField;
    selT033: TOracleDataSet;
    dsrT033: TDataSource;
    QI090CODICE_INTEGRAZIONE: TStringField;
    QI060: TOracleDataSet;
    QI060AZIENDA: TStringField;
    QI060MATRICOLA: TStringField;
    QI060NOME_UTENTE: TStringField;
    QI060PASSWORD: TStringField;
    selI090: TOracleDataSet;
    dselI090: TDataSource;
    selI090AZIENDA: TStringField;
    selI090ALIAS: TStringField;
    selI090DESCRIZIONE: TStringField;
    selI090INDIRIZZO: TStringField;
    selI090TIPOCONTEGGIO: TStringField;
    selI090STORIAINTERVENTO: TStringField;
    selI090AZZERAMENTOSALDO: TStringField;
    selI090ECCFASCESTR: TStringField;
    selI090UTENTE: TStringField;
    selI090PAROLACHIAVE: TStringField;
    selI090TSLAVORO: TStringField;
    selI090TSINDICI: TStringField;
    selI090FRAZIONANOTTE: TStringField;
    selI090TIMBORIG_VERSO: TStringField;
    selI090TIMBORIG_CAUSALE: TStringField;
    selI090RAGIONE_SOCIALE: TStringField;
    selI090VERSIONEDB: TStringField;
    selI090CODICE_INTEGRAZIONE: TStringField;
    dselI060: TDataSource;
    selI060: TOracleDataSet;
    insI060: TOracleQuery;
    selaT030: TOracleDataSet;
    QI060D_NOMINATIVO: TStringField;
    selaT030MATRICOLA: TStringField;
    selaT030NOMINATIVO: TStringField;
    delI060: TOracleQuery;
    QI060D_PASSWORD: TStringField;
    QI070DATA_PW: TDateTimeField;
    QI060DATA_PW: TDateTimeField;
    QI070ScadenzaPasswd: TDateField;
    QI090LUNG_PASSWORD: TIntegerField;
    QI090VALID_PASSWORD: TIntegerField;
    QI070NUOVA_PASSWORD: TStringField;
    QI070DATA_ACCESSO: TDateTimeField;
    QI090VALID_UTENTE: TIntegerField;
    selI090VALID_UTENTE: TIntegerField;
    QI070ScadenzaUtente: TDateField;
    selUser_Triggers: TOracleDataSet;
    QI070ACCESSO_NEGATO: TStringField;
    selI070Accessi: TOracleDataSet;
    selVSESSION: TOracleDataSet;
    selI070AccessiAZIENDA: TStringField;
    selI070AccessiUTENTE: TStringField;
    selI070AccessiACCESSO_NEGATO: TStringField;
    dsrVSESSION: TDataSource;
    selVSESSIONSID: TFloatField;
    selVSESSIONSERIAL: TFloatField;
    selVSESSIONSTATUS: TStringField;
    selVSESSIONUSERNAME: TStringField;
    selVSESSIONOSUSER: TStringField;
    selVSESSIONMACHINE: TStringField;
    selVSESSIONTERMINAL: TStringField;
    selVSESSIONPROGRAM: TStringField;
    selI070AccessiPROGRESSIVO: TIntegerField;
    delI060Filtri: TOracleQuery;
    QI090TSAUSILIARIO: TStringField;
    selI090TSAUSILIARIO: TStringField;
    QI090PATHALLCLIENT: TStringField;
    QI070VALIDITA_CESSATI: TIntegerField;
    selI073AZIENDA: TStringField;
    QI090DOMINIO_USR: TStringField;
    QI090DOMINIO_DIP: TStringField;
    selI061: TOracleDataSet;
    dsrI061: TDataSource;
    selI061AZIENDA: TStringField;
    selI061NOME_UTENTE: TStringField;
    selI061NOME_PROFILO: TStringField;
    selI061PERMESSI: TStringField;
    selI061FILTRO_FUNZIONI: TStringField;
    selI061FILTRO_ANAGRAFE: TStringField;
    selI061FILTRO_DIZIONARIO: TStringField;
    selI061INIZIO_VALIDITA: TDateTimeField;
    selI061FINE_VALIDITA: TDateTimeField;
    delI061: TOracleQuery;
    UpdI061: TOracleQuery;
    InsI061: TOracleQuery;
    QI060NOMI_PROFILI: TStringField;
    QI060EMAIL: TStringField;
    selI061Dist: TOracleDataSet;
    selPermessi: TOracleQuery;
    selFiltroAnagrafe: TOracleQuery;
    selFiltroFunzioni: TOracleQuery;
    selFiltroDizionario: TOracleQuery;
    delI073: TOracleQuery;
    QI090DOMINIO_DIP_TIPO: TStringField;
    QI090DOMINIO_USR_TIPO: TStringField;
    updI073: TOracleQuery;
    selI061DELEGATO_DA: TStringField;
    selI061FINE_VALIDITA2: TDateTimeField;
    _scrupdI090: TOracleQuery;
    _scrdelI090: TOracleQuery;
    selI075Dist: TOracleDataSet;
    selI061ITER_AUTORIZZATIVI: TStringField;
    dsrI075: TDataSource;
    dsrI075Dist: TDataSource;
    insI075: TOracleQuery;
    selI075: TOracleDataSet;
    delI075: TOracleQuery;
    selI075ITER: TStringField;
    selI075LIVELLO: TIntegerField;
    selI075ACCESSO: TStringField;
    cdsI075LookUp: TClientDataSet;
    cdsI075LookUpCODICE: TStringField;
    cdsI075LookUpDESCRIZIONE: TStringField;
    selI075D_ACCESSO: TStringField;
    selI075D_ITER: TStringField;
    selIterAutorizzativi: TOracleQuery;
    selI075AZIENDA: TStringField;
    selI075PROFILO: TStringField;
    insI075_2: TOracleQuery;
    dsrI096: TDataSource;
    cdsI096LookUp: TClientDataSet;
    cdsI096LookUpITER: TStringField;
    cdsI096LookUpDESCRIZIONE: TStringField;
    selI095: TOracleDataSet;
    selI096: TOracleDataSet;
    selI096AZIENDA: TStringField;
    selI096ITER: TStringField;
    selI096LIVELLO: TIntegerField;
    selI096OBBLIGATORIO: TStringField;
    selI096AVVISO: TStringField;
    selI096VALORI_POSSIBILI: TStringField;
    selI096DATI_MODIFICABILI: TStringField;
    dsrI095: TDataSource;
    selI095AZIENDA: TStringField;
    selI095ITER: TStringField;
    selI095COD_ITER: TStringField;
    selI096COD_ITER: TStringField;
    selI095Dist: TOracleDataSet;
    selI095DistCOD_ITER: TStringField;
    selI075COD_ITER: TStringField;
    selI095FILTRO_RICHIESTA: TStringField;
    selI095CONDIZ_AUTORIZZ_AUTOMATICA: TStringField;
    selI095MAX_LIV_AUTORIZZ_AUTOMATICA: TIntegerField;
    selI096AUTORIZZ_INTERMEDIA: TStringField;
    selI096INVIO_EMAIL: TStringField;
    selI093: TOracleDataSet;
    dsrI093: TDataSource;
    selI093AZIENDA: TStringField;
    selI093ITER: TStringField;
    selI093REVOCABILE: TStringField;
    selI093MAIL_OGGETTO_DIP: TStringField;
    selI093MAIL_CORPO_DIP: TStringField;
    selI093MAIL_OGGETTO_RESP: TStringField;
    selI093MAIL_CORPO_RESP: TStringField;
    selI093EXPR_PERIODO_VISUAL: TStringField;
    _selI097: TOracleDataSet;
    _selI097AZIENDA: TStringField;
    _selI097ITER: TStringField;
    _selI097COD_ITER: TStringField;
    _selI097NUM_CONDIZ: TIntegerField;
    _selI097CONDIZ_VALIDITA: TStringField;
    _selI097MESSAGGIO: TStringField;
    _selI097BLOCCANTE: TStringField;
    selI093D_iter: TStringField;
    selI096DESC_LIVELLO: TStringField;
    selI096CONDIZ_AUTORIZZ_AUTOMATICA: TStringField;
    selI096FASE: TIntegerField;
    _selI094: TOracleDataSet;
    _selI094AZIENDA: TStringField;
    _selI094ITER: TStringField;
    _selI094RIEPILOGO: TStringField;
    _selI094STATO: TStringField;
    _selI094EXPR_DATA: TStringField;
    _cdsBloccoRiep: TClientDataSet;
    _selI094d_riepilogo: TStringField;
    selI095VALIDITA_ITER_AUT: TStringField;
    selI093CHKDATI_ITER_AUT: TFloatField;
    selI093C_CHKDATI_ITER_AUT: TStringField;
    selI095VALIDITA_ITER_AUT2: TFloatField;
    selI096SCRIPT_AUTORIZZ: TStringField;
    selI061RICEZIONE_MAIL: TStringField;
    QI091Gruppo: TStringField;
    selSG746: TOracleDataSet;
    QI060C_PWD_DECRIPTATA: TStringField;
    QI090PASSWORD_CIFRE: TIntegerField;
    QI090PASSWORD_MAIUSCOLE: TIntegerField;
    QI090PASSWORD_CARSPECIALI: TIntegerField;
    UpdI060: TOracleQuery;
    selI065P: TOracleDataSet;
    dsrI065P: TDataSource;
    selI065U: TOracleDataSet;
    dsrI065U: TDataSource;
    selI065: TOracleDataSet;
    dsrI065: TDataSource;
    selI065TIPO: TStringField;
    selI065CODICE: TStringField;
    selI065ESPRESSIONE: TStringField;
    selI065C_TIPO: TStringField;
    testFiltroAnagrafe: TOracleDataSet;
    testFiltroAnagrafeMATRICOLA: TStringField;
    testFiltroAnagrafeCOGNOME: TStringField;
    testFiltroAnagrafeNOME: TStringField;
    testFiltroAnagrafeT430INIZIO: TDateTimeField;
    testFiltroAnagrafeT430FINE: TDateTimeField;
    dsrTestFiltroAnagrafe: TDataSource;
    QI090AGGIORNAMENTO_ABILITATO: TStringField;
    QI090GRUPPO_BADGE: TStringField;
    QI090LOGIN_USR_ABILITATO: TStringField;
    QI090LOGIN_DIP_ABILITATO: TStringField;
    selI095FILTRO_INTERFACCIA: TStringField;
    selI095MAX_LIV_NOTE_MODIFICABILI: TIntegerField;
    selI095DESCRIZIONE: TStringField;
    selI073ACCESSO_BROWSE: TStringField;
    selI073RIGHE_PAGINA: TIntegerField;
    selI095CONDIZIONE_ALLEGATI: TStringField;
    selI095ALLEGATI_MODIFICABILI: TStringField;
    selI096ALLEGATI_OBBLIGATORI: TStringField;
    selI096ALLEGATI_VISIBILI: TStringField;
    selI074Before: TOracleDataSet;
    selI074After: TOracleDataSet;
    selI076: TOracleDataSet;
    selI076AZIENDA: TStringField;
    selI076PROFILO: TStringField;
    selI076APPLICAZIONE: TStringField;
    selI076TAG: TIntegerField;
    selI076IP: TStringField;
    selI076CONSENTITO: TStringField;
    selI076IP_ESTERNO: TStringField;
    QI070T030_PROGRESSIVO: TIntegerField;
    selT030: TOracleDataSet;
    selI073Agg: TOracleDataSet;
    insI073Agg: TOracleQuery;
    updI073Agg: TOracleQuery;
    delI073Agg: TOracleQuery;
    QI060NOMINATIVO_QRY: TStringField;
    procedure QI060FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure I070PASSWDGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure I070PASSWDSetText(Sender: TField; const Text: string);
    procedure QI070PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure I071BeforeInsert(DataSet: TDataSet);
    procedure QI070BeforePost(DataSet: TDataSet);
    procedure QI070AfterPost(DataSet: TDataSet);
    procedure QI070BeforeDelete(DataSet: TDataSet);
    procedure QI070AfterDelete(DataSet: TDataSet);
    procedure BDEQI070UpdateError(DataSet: TDataSet; E: EDatabaseError;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure A008FOperatoriDtM1Create(Sender: TObject);
    procedure A008FOperatoriDtM1Destroy(Sender: TObject);
    procedure QI090AfterPost(DataSet: TDataSet);
    procedure QI090AfterDelete(DataSet: TDataSet);
    procedure QI070AfterCancel(DataSet: TDataSet);
    procedure QI090BeforeDelete(DataSet: TDataSet);
    procedure QI090NewRecord(DataSet: TDataSet);
    procedure QI091BeforeDelete(DataSet: TDataSet);
    procedure QI090AfterScroll(DataSet: TDataSet);
    procedure QI090AfterEdit(DataSet: TDataSet);
    procedure QI090BeforePost(DataSet: TDataSet);
    procedure QI091CalcFields(DataSet: TDataSet);
    procedure QI070AfterScroll(DataSet: TDataSet);
    procedure BDEQI090PAROLACHIAVEGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure BDEQI090PAROLACHIAVESetText(Sender: TField; const Text: String);
    procedure selI072FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI072DistAfterScroll(DataSet: TDataSet);
    procedure BeforeScroll(DataSet: TDataSet);
    procedure selI010AfterOpen(DataSet: TDataSet);
    procedure selI073FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI074DistAfterScroll(DataSet: TDataSet);
    procedure selI074FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI073BeforeDeleteInsert(DataSet: TDataSet);
    procedure selI073INIBIZIONEValidate(Sender: TField);
    procedure selI073DistAfterScroll(DataSet: TDataSet);
    procedure QI070BeforeInsert(DataSet: TDataSet);
    procedure QI070FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI090AfterScroll(DataSet: TDataSet);
    procedure QI060AfterDelete(DataSet: TDataSet);
    procedure QI060BeforeDelete(DataSet: TDataSet);
    procedure QI060BeforePost(DataSet: TDataSet);
    procedure QI060PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure QI060NewRecord(DataSet: TDataSet);
    procedure QI060CalcFields(DataSet: TDataSet);
    procedure QI070CalcFields(DataSet: TDataSet);
    procedure selI070AccessiBeforeDelete(DataSet: TDataSet);
    procedure selI070AccessiBeforeInsert(DataSet: TDataSet);
    procedure selUser_TriggersBeforeDelete(DataSet: TDataSet);
    procedure selUser_TriggersBeforeInsert(DataSet: TDataSet);
    procedure selI070AccessiBeforePost(DataSet: TDataSet);
    procedure selI073NewRecord(DataSet: TDataSet);
    procedure selI071FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure QI070AfterQuery(Sender: TOracleDataSet);
    procedure QI070BeforeScroll(DataSet: TDataSet);
    procedure QI070AZIENDAValidate(Sender: TField);
    procedure selI061BeforePost(DataSet: TDataSet);
    procedure selI061NewRecord(DataSet: TDataSet);
    procedure selI061BeforeEdit(DataSet: TDataSet);
    procedure selI061BeforeInsert(DataSet: TDataSet);
    procedure selI071AfterOpen(DataSet: TDataSet);
    procedure selI071BeforePost(DataSet: TDataSet);
    procedure QI091AfterScroll(DataSet: TDataSet);
    procedure selI061ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure QI090DOMINIO_DIP_TIPOChange(Sender: TField);
    procedure selI073BeforePost(DataSet: TDataSet);
    procedure QI091BeforePost(DataSet: TDataSet);
    procedure selI075DistAfterScroll(DataSet: TDataSet);
    procedure selI075CalcFields(DataSet: TDataSet);
    procedure selI096NewRecord(DataSet: TDataSet);
    procedure selI096BeforeDelete(DataSet: TDataSet);
    procedure selI096BeforePost(DataSet: TDataSet);
    procedure selI075NewRecord(DataSet: TDataSet);
    procedure selI095NewRecord(DataSet: TDataSet);
    procedure selI095AfterScroll(DataSet: TDataSet);
    procedure selI075ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selI095BeforeDelete(DataSet: TDataSet);
    procedure selI095BeforePost(DataSet: TDataSet);
    procedure selI093AfterScroll(DataSet: TDataSet);
    procedure selI093BeforeInsert(DataSet: TDataSet);
    procedure selI093BeforeDelete(DataSet: TDataSet);
    procedure _selI097NewRecord(DataSet: TDataSet);
    procedure selI093BeforePost(DataSet: TDataSet);
    procedure selI093CalcFields(DataSet: TDataSet);
    procedure _selI097BeforePost(DataSet: TDataSet);
    procedure _selI094NewRecord(DataSet: TDataSet);
    procedure _selI094BeforePost(DataSet: TDataSet);
    procedure selI095CalcFields(DataSet: TDataSet);
    procedure selI093AfterOpen(DataSet: TDataSet);
    procedure selI095BeforeInsert(DataSet: TDataSet);
    procedure selI096BeforeInsert(DataSet: TDataSet);
    procedure selI095AfterOpen(DataSet: TDataSet);
    procedure QI091DATOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure QI091FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI065AfterPost(DataSet: TDataSet);
    procedure selI065BeforePost(DataSet: TDataSet);
    procedure UpdI060AfterQuery(Sender: TOracleQuery);
    procedure selI065CalcFields(DataSet: TDataSet);
    procedure QI060AfterOpen(DataSet: TDataSet);
    procedure QI060AfterScroll(DataSet: TDataSet);
    procedure QI091AfterDelete(DataSet: TDataSet);
    procedure QI091AfterPost(DataSet: TDataSet);
    procedure DbIris008BAfterLogOn(Sender: TOracleSession);
    procedure selI093ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selI095ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selI096ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selI076NewRecord(DataSet: TDataSet);
    procedure selI076BeforePost(DataSet: TDataSet);
    procedure QI070BeforeEdit(DataSet: TDataSet);
    procedure selI061FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    Inserimento072:Boolean;
    VecchiaAzienda:String;
    CdFnz,CdFnzWeb:TStringList;
    selI010:TSelI010;
    //procedure GetI074(var DS:TOracleDataSet); // su MW
    //procedure ConfrontaFiltroDizionario; // su MW
    procedure OpenSelI095(Azienda:String = ''); // Massimo 14/12/2012 riportato anche su MW
    procedure OpenSelI095Dist;
    //procedure OpenSelI097;   Massimo 14/12/2012 gestione A181UAziendeMW
    procedure OpenSelI096;
    //procedure OpenSelI093;   Massimo 14/12/2012 gestione A181UAziendeMW
    //procedure OpenSelI094;   Massimo 17/12/2012 gestione A181UAziendeMW
    //procedure CaricaCdsBloccoRiep;    Massimo 17/12/2012 gestione A181UAziendeMW
    procedure AggiornaDatiEnte;
    procedure PutDatiEnte;
    procedure CreaInsert;
    procedure AggiornaI073;
    procedure EliminaFunzioniInesistenti;
    procedure NascondiDBGridColumns(var INDBGrid:TDBGrid);
    //procedure AbilitazioniColonneI096; Massimo 14/12/2012 gestione A181UAziendeMW
    //function Decod_Iter(InIter:String):String;  Massimo 14/12/2012 gestione A181UAziendeMW
    // function GetI091Gruppo(CodI091:String):String; Massimo 17/12/2012 gestione A181UAziendeMW
  public
    { Public declarations }
    A181MW:TA181FAziendeMW;
    A185MW:TA185FFiltroDizionarioMW;
    BrowseProfili:Boolean;
    AziendaCorrente:String;
    //ModuloIterAutorizzativi, I093EnabledInsert:Boolean;  Massimo 14/12/2012 gestione A181UAziendeMW
    //GruppoFiltroI091:String; Massimo 17/12/2012 gestione A181UAziendeMW
    FiltroProfiliI061:TFiltroProfiliI061;
    selI061VisioneCorrente:Boolean;
    procedure FiltraSelI075;
    // procedure AggiornaI095_I096(Azienda:String = '');  Massimo 14/12/2012 gestione A181UAziendeMW
    procedure GetFiltroAnagrafe;
    procedure PutFiltroAnagrafe;
    procedure PutFiltroDizionario;
    procedure CreaFiltroFunzioni(Azienda,Profilo:String);
    procedure CambioDataBase;
    procedure AggiornaFiltroProfili;
    procedure OpenI061;
    procedure I060SettaFiltroI061;
  end;

var
  A008FOperatoriDtM1: TA008FOperatoriDtM1;

implementation

uses A008UOperatori, A008UAziende, A008UProfili, A008ULoginDipendenti, A008UCambioPassword;

{$R *.DFM}

procedure TA008FOperatoriDtM1.A008FOperatoriDtM1Create(Sender: TObject);
var i:Integer;
begin
  CdFnz:=TStringList.Create;
  CdFnzWeb:=TStringList.Create;
  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='RILPRE';

  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if (Components[i] is TOracleQuery) and ((Components[i] as TOracleQuery).Session = nil) then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if (Components[i] is TOracleDataSet) and ((Components[i] as TOracleDataSet).Session = nil) then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;

  // Massimo 14/12/2012 gestione A181UAziendeMW
  A181MW:=TA181FAziendeMW.Create(nil);
  A181MW.selI093:=selI093;
  A181MW.selI095:=selI095;
  A181MW.selI096:=selI096;
  A181MW.QI090:=QI090;
  A181MW.QI091:=QI091;

  QI060.SetVariable('COLONNA_ORD','I060.NOME_UTENTE');
  QI060.SetVariable('TIPO_ORD','ASC');

  // Bruno 93/07/2015
  A185MW:=TA185FFiltroDizionarioMW.Create(nil);

  BrowseProfili:=True;
  // Massimo 14/12/2012 gestione A181UAziendeMW
  // ModuloIterAutorizzativi:=False;

  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='RILPRE';
  selDizionario.SQL.Text:=A000selDizionario + A000selDizionarioSicurezzaRiepiloghi;
  selDizionario.SQL.Add('ORDER BY TABELLA,CODICE');
  selI073.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  QI090.AfterScroll:=nil;
  if Parametri.Azienda <> 'AZIN' then
  begin
    QI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    QI090.Filtered:=True;
  end;
  QI090.Open;
  DbIris008B.LogonDatabase:=Parametri.Database;
  DbIris008B.LogonUserName:=QI090.FieldByName('UTENTE').AsString;
  DbIris008B.LogonPassword:=R180Decripta(QI090.FieldByName('PAROLACHIAVE').AsString,21041974);
  DbIris008B.Logon;
  selI010:=TselI010.Create(Self);
  selI010.AfterOpen:=selI010AfterOpen;
  try
    selI010.Apri(DbIris008B,'',Parametri.Applicazione,'','','');
  except
    on E:Exception do ShowMessage(E.Message);
  end;
  if Parametri.Azienda <> 'AZIN' then
  begin
    selI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    selI090.Filtered:=True;
  end;
  selI090.Open;
  try
    selT033.Open;
    selaT030.Open;
    selDizionario.Open;
  except
  end;

  selVSESSION.Filter:='USERNAME = ''' + Parametri.Username + '''';
  selVSESSION.Filtered:=Parametri.Azienda <> 'AZIN';
  selI070Accessi.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
  selI070Accessi.Filtered:=Parametri.Azienda <> 'AZIN';
  QI070.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
  QI070.Filtered:=Parametri.Azienda <> 'AZIN';
  QI070.Open;
  Inserimento072:=False;
  VecchiaAzienda:='';
  AggiornaDatiEnte;
  QI070.SearchRecord('AZIENDA;UTENTE',VararrayOf([Parametri.Azienda,Parametri.Operatore]),[srfromBeginning]);
  //LooUp tipo accesso maschera dei profili
  cdsI075LookUp.Open;
  cdsI075LookUp.Append;
  cdsI075LookUp.FieldByName('CODICE').AsString:='N';
  cdsI075LookUp.FieldByName('DESCRIZIONE').AsString:='Negato';
  cdsI075LookUp.Post;
  cdsI075LookUp.Append;
  cdsI075LookUp.FieldByName('CODICE').AsString:='F';
  cdsI075LookUp.FieldByName('DESCRIZIONE').AsString:='Da filtro funzioni';
  cdsI075LookUp.Post;
  cdsI075LookUp.Append;
  cdsI075LookUp.FieldByName('CODICE').AsString:='R';
  cdsI075LookUp.FieldByName('DESCRIZIONE').AsString:='Sola lettura';
  cdsI075LookUp.Post;
  //LookUp codice - descrizione maschera azienda
  cdsI096LookUp.IndexDefs.Add('MainKey','Iter',[ixUnique]);
  cdsI096LookUp.Open;
  cdsI096LookUp.IndexName:='MainKey';
  for i:=Low(A000IterAutorizzativi) to High(A000IterAutorizzativi) do
  begin
    cdsI096LookUp.Insert;
    cdsI096LookUp.FieldByName('ITER').AsString:=A000IterAutorizzativi[i].Cod;
    cdsI096LookUp.FieldByName('DESCRIZIONE').AsString:=A000IterAutorizzativi[i].Desc;
    cdsI096LookUp.Post;
  end;
  selI071.Open;
  selI072.Open;
  selI073.Open;
  selI074.Open;
  selI072Dist.Open;
  selI073Dist.Open;
  selI074Dist.Open;
  selI075Dist.Open;
  //CaricaCdsBloccoRiep;  //Massimo 17/12/2012 gestione A181UAziendeMW
  //I093EnabledInsert:=False;  Massimo 14/12/2012 gestione A181UAziendeMW
  A181MW.OpenSelI093;   //Massimo 14/12/2012 gestione A181UAziendeMW
  OpenSelI095(QI090.FieldByName('AZIENDA').AsString);
  OpenSelI095Dist;
  A181MW.OpenSelI094;  //Massimo 17/12/2012 gestione A181UAziendeMW
  A181MW.OpenSelI097;  //Massimo 14/12/2012 gestione A181UAziendeMW
  OpenSelI096;
  CreaInsert;
  AggiornaI073;
  A181MW.AggiornaI095_I096;
  selI061VisioneCorrente:=False;
end;

// su mw
//procedure TA008FOperatoriDtM1.GetI074(var DS:TOracleDataSet);
//begin
//  DS.Close;
//  DS.SQL.Clear;
//  DS.SQL.Add('select I074.TABELLA, I074.CODICE, I074.ABILITATO');
//  DS.SQL.Add('  from MONDOEDP.I074_FILTRODIZIONARIO I074');
//  DS.SQL.Add(' where I074.AZIENDA = :AZIENDA');
//  DS.SQL.Add('   and I074.PROFILO = :PROFILO');
//  DS.SQL.Add('   and I074.TABELLA = :TABELLA');
//  DS.SQL.Add(' order by I074.TABELLA, I074.CODICE');
//  DS.DeclareAndSet('AZIENDA',otString,QI090.FieldByName('AZIENDA').AsString);
//  DS.DeclareAndSet('PROFILO',otString,selI074Dist.FieldByName('PROFILO').AsString);
//  DS.DeclareAndSet('TABELLA',otString,A008FProfili.cmbDizionario.Text);
//  DS.Open;
//end;

// su mw
//procedure TA008FOperatoriDtM1.ConfrontaFiltroDizionario;
//begin
//  //Gestione log inserimenti
//  selI074After.First;
//  while not selI074After.Eof do
//  begin
//    if not selI074Before.SearchRecord('CODICE',selI074After.FieldByName('CODICE').AsString,[srFromBeginning]) then
//      begin
//        RegistraLog.SettaProprieta('I','I074_FILTRODIZIONARIO','A008',nil,True);
//        RegistraLog.InserisciDato('AZIENDA','',QI090.FieldByName('AZIENDA').AsString);
//        RegistraLog.InserisciDato('PROFILO','',selI072Dist.FieldByName('PROFILO').AsString);
//        RegistraLog.InserisciDato('TABELLA','',selI074Before.FieldByName('TABELLA').AsString);
//        RegistraLog.InserisciDato('CODICE','',selI074Before.FieldByName('CODICE').AsString);
//        RegistraLog.InserisciDato('STATO','',selI074After.FieldByName('ABILITATO').AsString);
//        RegistraLog.RegistraOperazione;
//      end;
//    selI074After.Next;
//  end;
//  //Gestione log cancellazioni
//  selI074Before.First;
//  while not selI074Before.Eof do
//  begin
//    if not selI074After.SearchRecord('CODICE',selI074Before.FieldByName('CODICE').AsString,[srFromBeginning]) then
//    begin
//      RegistraLog.SettaProprieta('C','I074_FILTRODIZIONARIO','A008',nil,True);
//      RegistraLog.InserisciDato('AZIENDA',QI090.FieldByName('AZIENDA').AsString,'');
//      RegistraLog.InserisciDato('PROFILO',selI072Dist.FieldByName('PROFILO').AsString,'');
//      RegistraLog.InserisciDato('TABELLA',selI074Before.FieldByName('TABELLA').AsString,'');
//      RegistraLog.InserisciDato('CODICE',selI074Before.FieldByName('CODICE').AsString,'');
//      RegistraLog.InserisciDato('STATO',selI074Before.FieldByName('ABILITATO').AsString,'');
//      RegistraLog.RegistraOperazione;
//    end;
//    selI074Before.Next;
//  end;
//  //Gestione log modifiche
//  selI074Before.First;
//  while not selI074Before.Eof do
//  begin
//    if selI074After.SearchRecord('CODICE',selI074Before.FieldByName('CODICE').AsString,[srFromBeginning]) then
//    begin
//      if selI074Before.FieldByName('ABILITATO').AsString <> selI074After.FieldByName('ABILITATO').AsString then
//      begin
//        RegistraLog.SettaProprieta('M','I074_FILTRODIZIONARIO','A008',nil,True);
//        RegistraLog.InserisciDato('AZIENDA',QI090.FieldByName('AZIENDA').AsString,'');
//        RegistraLog.InserisciDato('PROFILO',selI072Dist.FieldByName('PROFILO').AsString,'');
//        RegistraLog.InserisciDato('TABELLA',selI074Before.FieldByName('TABELLA').AsString,'');
//        RegistraLog.InserisciDato('CODICE',selI074Before.FieldByName('CODICE').AsString,'');
//        RegistraLog.InserisciDato('STATO',selI074Before.FieldByName('ABILITATO').AsString,selI074After.FieldByName('ABILITATO').AsString);
//        RegistraLog.RegistraOperazione;
//      end;
//    end;
//    selI074Before.Next;
//  end;
//end;

procedure TA008FOperatoriDtM1.NascondiDBGridColumns(var INDBGrid:TDBGrid);
var i:Integer;
begin
  for i:=0 to INDBGrid.Columns.Count - 1 do
    INDBGrid.Columns[i].Visible:=INDBGrid.Columns[i].Field.Visible;
end;

(* Massimo 17/12/2012 gestione A181UAziendeMW
procedure TA008FOperatoriDtM1.CaricaCdsBloccoRiep;
var i:integer;
begin
  for i:=0 to High(lstRiepiloghi) do
  begin
    cdsBloccoRiep.Insert;
    cdsBloccoRiep.FieldByName('CODICE').AsString:=Trim(Copy(lstRiepiloghi[i],1,5));
    cdsBloccoRiep.FieldByName('DESCRIZIONE').AsString:=Copy(lstRiepiloghi[i],1,Length(lstRiepiloghi[i]));
    cdsBloccoRiep.Post;
  end;
  cdsBloccoRiep.IndexDefs.Add('INDICE1','CODICE',[]);
  cdsBloccoRiep.IndexName:='INDICE1';
end;
*)

(* Massimo 14/12/2012 gestione A181UAziendeMW
procedure TA008FOperatoriDtM1.OpenSelI093;
var i:integer;
    DtsEdited:Boolean;
begin
  R180SetVariable(selI093,'AZIENDA','%');
  selI093.Open;
  with TOracleDataSet.Create(Self) do
  begin
    Session:=SessioneOracle;
    SQL.Add('SELECT I090.AZIENDA FROM MONDOEDP.I090_ENTI I090 ORDER BY I090.AZIENDA');
    Open;
    DtsEdited:=False;
    while Not Eof do
    begin
      for i:=Low(A000IterAutorizzativi) to High(A000IterAutorizzativi) do
        if Not selI093.SearchRecord('AZIENDA;ITER',VarArrayOf([FieldByName('AZIENDA').AsString,A000IterAutorizzativi[i].Cod]),[srFromBeginning]) then
        begin
          I093EnabledInsert:=True;
          selI093.ReadOnly:=False;
          selI093.Insert;
          selI093.FieldByName('AZIENDA').AsString:=FieldByName('AZIENDA').AsString;
          selI093.FieldByName('ITER').AsString:=A000IterAutorizzativi[i].Cod;
          selI093.FieldByName('REVOCABILE').AsString:='N';
          selI093.Post;
          DtsEdited:=True;
        end;
      Next;
    end;
    I093EnabledInsert:=False;
    if DtsEdited then
    begin
      SessioneOracle.ApplyUpdates([selI093],True);
      selI093.ReadOnly:=True;
    end;
    Close;
    Free;
  end;
  R180SetVariable(selI093,'AZIENDA',QI090.FieldByName('AZIENDA').AsString);
  selI093.Open;
end;
*)

(* Massimo 17/12/2012 gestione A181UAziendeMW
procedure TA008FOperatoriDtM1.OpenSelI094;
begin
  R180SetVariable(selI094,'AZIENDA',QI090.FieldByName('AZIENDA').AsString);
  selI094.Open;
end;
*)

procedure TA008FOperatoriDtM1.OpenSelI095Dist;
begin
  R180SetVariable(selI095Dist,'AZIENDA',QI090.FieldByName('AZIENDA').AsString);
  selI095Dist.Open;
end;

procedure TA008FOperatoriDtm1.OpenSelI095(Azienda:String = '');
begin
  R180SetVariable(selI095,'AZIENDA',Azienda);
  selI095.Open;
end;

(* Massimo 14/12/2012 gestione A181UAziendeMW
procedure TA008FOperatoriDtm1.OpenSelI097;
begin
  R180SetVariable(selI097,'AZIENDA',QI090.FieldByName('AZIENDA').AsString);
  selI097.Open;
end;
*)

procedure TA008FOperatoriDtm1.OpenSelI096;
begin
  R180SetVariable(selI096,'AZIENDA',QI090.FieldByName('AZIENDA').AsString);
  selI096.Open;
end;

procedure TA008FOperatoriDtm1.FiltraSelI075;
begin
  R180SetVariable(selI075,'AZIENDA',AziendaCorrente);
  R180SetVariable(selI075,'PROFILO',selI075Dist.FieldByName('PROFILO').AsString);
  R180SetVariable(selI075,'ITER',null);
  if A008FProfili <> nil then
    R180SetVariable(selI075,'ITER',A008FProfili.cmbCodiceIter.Text);
  selI075.Open;
end;

procedure TA008FOperatoriDtM1.CreaInsert;
{Creazione degli script di duplicazione dei profili}
var S:String;
    i:Integer;
begin
  S:='';
  for i:=0 to selI071.FieldCount - 1 do
  begin
    if selI071.Fields[i].FieldName <> 'PROFILO' then
    begin
      if S <> '' then
        S:=S + ',';
      S:=S + selI071.Fields[i].FieldName;
    end;
  end;
  with insI071 do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO MONDOEDP.I071_PERMESSI (PROFILO,' + S + ')');
    SQL.Add('SELECT :NEW_PROFILO,' + S);
    SQL.Add('FROM MONDOEDP.I071_PERMESSI WHERE PROFILO = :OLD_PROFILO AND AZIENDA = :AZIENDA');
  end;
  S:='';
  for i:=0 to selI072.FieldCount - 1 do
  begin
    if selI072.Fields[i].FieldName <> 'PROFILO' then
    begin
      if S <> '' then
        S:=S + ',';
      S:=S + selI072.Fields[i].FieldName;
    end;
  end;
  with insI072 do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO MONDOEDP.I072_FILTROANAGRAFE (PROFILO,' + S + ')');
    SQL.Add('SELECT :NEW_PROFILO,' + S);
    SQL.Add('FROM MONDOEDP.I072_FILTROANAGRAFE WHERE PROFILO = :OLD_PROFILO AND AZIENDA = :AZIENDA');
  end;
  S:='';
  for i:=0 to selI073.FieldCount - 1 do
  begin
    if selI073.Fields[i].FieldName <> 'PROFILO' then
    begin
      if S <> '' then
        S:=S + ',';
      S:=S + selI073.Fields[i].FieldName;
    end;
  end;
  with insI073 do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO MONDOEDP.I073_FILTROFUNZIONI (PROFILO,' + S + ')');
    SQL.Add('SELECT :NEW_PROFILO,' + S);
    //SQL.Add('FROM MONDOEDP.I073_FILTROFUNZIONI WHERE PROFILO = :OLD_PROFILO AND  AZIENDA = :AZIENDA AND APPLICAZIONE = :APPLICAZIONE');
    SQL.Add('FROM MONDOEDP.I073_FILTROFUNZIONI WHERE PROFILO = :OLD_PROFILO AND  AZIENDA = :AZIENDA');
    //SetVariable('APPLICAZIONE',Parametri.Applicazione);
  end;
  S:='';
  for i:=0 to selI074.FieldCount - 1 do
  begin
    if selI074.Fields[i].FieldName <> 'PROFILO' then
    begin
      if S <> '' then
        S:=S + ',';
      S:=S + selI074.Fields[i].FieldName;
    end;
  end;
  with insI074 do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO MONDOEDP.I074_FILTRODIZIONARIO (PROFILO,' + S + ')');
    SQL.Add('SELECT :NEW_PROFILO,' + S);
    SQL.Add('FROM MONDOEDP.I074_FILTRODIZIONARIO WHERE PROFILO = :OLD_PROFILO AND AZIENDA = :AZIENDA');
  end;
end;

procedure TA008FOperatoriDtM1.DbIris008BAfterLogOn(Sender: TOracleSession);
var SetPar:TOracleQuery;
begin
  SetPar:=TOracleQuery.Create(nil);
  try
    SetPar.Session:=Sender;
    SetPar.SQL.Add('ALTER SESSION SET NLS_TERRITORY = AMERICA');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_LANGUAGE = ITALIAN');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_SORT = BINARY');
    SetPar.Execute;
  finally
    SetPar.Free;
  end;
end;

procedure TA008FOperatoriDtM1.AggiornaDatiEnte;
var i:Integer;
begin
  QI090.DisableControls;
  QI091.Filtered:=False;

  //modifica ordinamento dei dati esistenti
  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Add('begin');
    for i:=1 to High(DatiEnte) do
      SQL.Add(Format('update MONDOEDP.I091_DATIENTE set ORDINE = %d where TIPO = ''%s'' and nvl(ORDINE,-1) <> %d;',[i,DatiEnte[i].Nome,i]));
    SQL.Add('end;');
    Execute;
  finally
    Free;
    SessioneOracle.Commit;
  end;

  //inserimento nuovi dati
  QI090.First;
  while not QI090.Eof do
  begin
    QI091.Close;
    QI091.SetVariable('AZIENDA',QI090.FieldByName('AZIENDA').AsString);
    QI091.Open;
    for i:=1 to High(DatiEnte) do
    begin
      if not QI091.Locate('TIPO',DatiEnte[i].Nome,[]) then
      begin
        A181MW.Ins091.SetVariable('AZIENDA',QI090Azienda.AsString);
        A181MW.Ins091.SetVariable('ORDINE',i);
        A181MW.Ins091.SetVariable('TIPO',DatiEnte[i].Nome);
        try
          A181MW.Ins091.Execute;
        except
        end;
      end;
    end;
    SessioneOracle.Commit;
    QI090.Next;
  end;
  QI091.Close;
  QI090.First;
  QI090.EnableControls;
end;

procedure TA008FOperatoriDtM1.I070PASSWDGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
{Rende visibile la password}
begin
  Text:=R180DeCriptaI070(Sender.AsString);
end;

procedure TA008FOperatoriDtM1.I070PASSWDSetText(Sender: TField;
  const Text: string);
{Codifica la password prima di registrarla}
begin
  Sender.Value:=R180CriptaI070(Text);
end;

procedure TA008FOperatoriDtM1.QI070PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  ShowMessage('Modifica non riuscita!' + #13#10 + E.Message);
  Action:=daAbort;
end;

procedure TA008FOperatoriDtM1.I071BeforeInsert(DataSet: TDataSet);
{Non permetto l'inserimento automatico nella griglia}
begin
  if not A008FOPeratori.Inserimento then Abort
  else A008FOPeratori.Inserimento:=False;
end;

procedure TA008FOperatoriDtM1.QI070BeforeInsert(DataSet: TDataSet);
begin
  QI070.FieldByName('AZIENDA').ReadOnly:=False;
  QI070.FieldByName('UTENTE').ReadOnly:=False;
end;

procedure TA008FOperatoriDtM1.QI070BeforeEdit(DataSet: TDataSet);
begin
  QI070.FieldByName('AZIENDA').ReadOnly:=True;
end;

procedure TA008FOperatoriDtM1.QI070BeforePost(DataSet: TDataSet);
{Gestione progressivo operatori e creazione inibizioni a funzioni}
var
  i:Word;
  RegolePassword:TRegolePassword;
  S:String;
  LOQ: TOracleQuery;
  LRowIDClause: String;
  LMsg: String;
begin
  if pos(' ', QI070.FieldByName('UTENTE').AsString) > 0 then
    raise exception.Create('L''operatore non può contenere degli spazi');

  if (VarToStr(QI070.FieldByName('FILTRO_FUNZIONI').OldValue) <> '') and
     (QI070.FieldByName('FILTRO_FUNZIONI').OldValue <> QI070.FieldByName('FILTRO_FUNZIONI').Value) and
     (VarToStr(selI073Dist.Lookup('PROFILO',VarToStr(QI070.FieldByName('FILTRO_FUNZIONI').OldValue),'PROFILO')) = '') then
  begin
    if R180MessageBox('Attenzione!' + #13 +
                      'Risulta già assegnato il Filtro Funzioni ' + VarToStr(QI070.FieldByName('FILTRO_FUNZIONI').OldValue) + #13 +
                      'ma non è visibile in questa applicazione.' + #13 +
                      'Si consiglia di mantenere lo stesso Filtro, creandolo per l''applicazione corrente.' + #13 + #13 +
                      'Creare il Filtro adesso?',DOMANDA) = mrYes then
    begin
      selI073.Filtered:=False;
      try
        CreaFiltroFunzioni(QI070.FieldByName('AZIENDA').AsString,VarToStr(QI070.FieldByName('FILTRO_FUNZIONI').OldValue));
      finally
        selI073.Filtered:=True;
        selI073Dist.Refresh;
      end;
      QI070.FieldByName('FILTRO_FUNZIONI').Value:=QI070.FieldByName('FILTRO_FUNZIONI').OldValue;
      ShowMessage('Filtro ' + QI070.FieldByName('FILTRO_FUNZIONI').Value + ' creato.' + #13 +
                  'Ricordarsi di attivare le funzioni desiderate');
    end;
  end;

  if DataSet.State = dsInsert then
  begin
    with T035 do
    begin
      Open;
      if FieldByName('PROPERATORI').IsNull then i:=0
      else i:=FieldByName('PROPERATORI').AsInteger;
      Inc(i);
      Edit;
      FieldByName('PROPERATORI').AsInteger:=i;
      Post;
      Close;
      DataSet.FieldByName('Progressivo').AsInteger:=i;
    end;

    // se è obbligatorio il collegamento ad una anagrafica, verificare che T030_PROGRESSIVO sia valorizzato
    if Parametri.CampiRiferimento.C33_Link_I070_T030 = 'O' then
    begin
      if (DataSet.FieldByName('T030_PROGRESSIVO').IsNull) or
         (DataSet.FieldByName('T030_PROGRESSIVO').AsInteger = 0) then
      begin
        raise Exception.CreateFmt('È necessario selezionare l''anagrafica collegata all''operatore %s',[DataSet.FieldByName('UTENTE').AsString]);
      end;
    end;
  end;
  if (DataSet.State = dsInsert) or
     (DataSet.FieldByName('PASSWD').medpOldValue <> DataSet.FieldByName('PASSWD').Value) then
  begin
    (*
    if (Length(DataSet.FieldByName('PASSWD').AsString) div 2) < Parametri.LunghezzaPassword then
      if QI090.FieldByName('DOMINIO_USR').IsNull or (Length(Dataset.FieldByName('PASSWD').AsString) > 0) then
        raise Exception.Create(Format('La password deve essere di almeno %d caratteri!',[Parametri.LunghezzaPassword]));
    *)
    with A008FOperatoriDtM1.QI090 do
      if FieldByName('DOMINIO_USR').IsNull or (Trim(Dataset.FieldByName('PASSWD').AsString) <> '') then
      try
        RegolePassword:=TRegolePassword.Create(nil);
        RegolePassword.PasswordI060:=False;
        RegolePassword.MesiValidita:=FieldByName('VALID_PASSWORD').AsInteger;
        RegolePassword.Lunghezza:=FieldByName('LUNG_PASSWORD').AsInteger;
        RegolePassword.Cifre:=FieldByName('PASSWORD_CIFRE').AsInteger;
        RegolePassword.Maiuscole:=FieldByName('PASSWORD_MAIUSCOLE').AsInteger;
        RegolePassword.CarSpeciali:=FieldByName('PASSWORD_CARSPECIALI').AsInteger;
        S:=RegolePassword.PasswordValida(R180DecriptaI070(Dataset.FieldByName('PASSWD').AsString));
        if S <> '' then
          raise Exception.Create(s);
      finally
        FreeAndNil(RegolePassword);
      end;
    DataSet.FieldByName('DATA_PW').AsDateTime:=Trunc(R180SysDate(SessioneOracle));
  end;

  // in modifica, verifica che T030_PROGRESSIVO sia valorizzato
  if DataSet.State = dsEdit then
  begin
    // se è obbligatorio il collegamento ad una anagrafica, verifica che T030_PROGRESSIVO sia valorizzato
    // fa eccezione il caso in cui OldValue sia null ->  in tal caso consentire di mantenere il valore nullo.
    if Parametri.CampiRiferimento.C33_Link_I070_T030 = 'O' then
    begin
      if (DataSet.FieldByName('T030_PROGRESSIVO').medpOldValue <> null) and
         (DataSet.FieldByName('T030_PROGRESSIVO').medpOldValue <> 0) and
         ((DataSet.FieldByName('T030_PROGRESSIVO').IsNull) or
          (DataSet.FieldByName('T030_PROGRESSIVO').AsInteger = 0)) then
      begin
        raise Exception.CreateFmt('È necessario selezionare l''anagrafica collegata all''operatore %s',[DataSet.FieldByName('UTENTE').AsString]);
      end;
    end;
  end;

  // se il progressivo è valorizzato verifica l'univocità (limitatamente all'azienda)
  // e chiede conferma in caso di violazione
  if DataSet.FieldByName('T030_PROGRESSIVO').AsInteger <> 0 then
  begin
    LMsg:='';
    LRowIDClause:=IfThen(DataSet.State = dsInsert,'',Format(' AND ROWID <> ''%s''',[(DataSet as TOracleDataset).RowId.QuotedString]));
    LOQ:=TOracleQuery.Create(nil);
    try
      try
        LOQ.Session:=SessioneOracle;
        LOQ.SQL.Add(
          Format(
            'select concatena_testo(''SELECT UTENTE FROM MONDOEDP.I070_UTENTI WHERE AZIENDA = ''%s'' AND T030_PROGRESSIVO = %d %s ORDER BY 1'' ,'','') from dual',
            [DataSet.FieldByName('AZIENDA').AsString.QuotedString,
             DataSet.FieldByName('T030_PROGRESSIVO').AsInteger,
             LRowIDClause]));
        LOQ.Execute;
        if not LOQ.Eof then
          LMsg:=LOQ.FieldAsString(0);
      except
      end;
    finally
      FreeAndNil(LOQ);
    end;
    if LMsg <> '' then
    begin
      LMsg:=Format(
              'L''anagrafica di riferimento risulta già associata'#13#10 +
              IfThen(LMsg.Contains(','),
                'ai seguenti operatori:'#13#10'%s',
                'all''operatore "%s".') + #13#10 +
              'Confermare?',
            [LMsg]);
      if R180MessageBox(LMsg,DOMANDA) = mrNo then
        Abort;
    end;
  end;

  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','I070_UTENTI',Copy(Name,1,4),QI070,True);
    dsEdit:  RegistraLog.SettaProprieta('M','I070_UTENTI',Copy(Name,1,4),QI070,True);
  end;
end;

procedure TA008FOperatoriDtM1.QI070BeforeScroll(DataSet: TDataSet);
begin
  //AziendaCorrente:=AziendaCorrente;
end;

procedure TA008FOperatoriDtM1.QI070AfterPost(DataSet: TDataSet);
var Az,Op:String;
begin
  Az:=DataSet.FieldByName('Azienda').AsString;
  Op:=DataSet.FieldByName('Utente').AsString;
  RegistraLog.RegistraOperazione;
  try
    SessioneOracle.ApplyUpdates([QI070],True);
  except
    SessioneOracle.Rollback;
  end;
  QI070.Close;
  QI070.Open;
  QI070.Locate('Azienda;Utente',VarArrayOf([Az,Op]),[]);
end;

procedure TA008FOperatoriDtM1.QI070AfterQuery(Sender: TOracleDataSet);
begin
  //AziendaCorrente:=AziendaCorrente;
end;

procedure TA008FOperatoriDtM1.BDEQI070UpdateError(DataSet: TDataSet;
  E: EDatabaseError; UpdateKind: TUpdateKind;
  var UpdateAction: TUpdateAction);
begin
  if UpdateKind in [ukModify,ukInsert] then
  begin
    ShowMessage('Operatore già esistente!');
    UpdateAction:=uaAbort;
  end;
end;

procedure TA008FOperatoriDtM1.QI070BeforeDelete(DataSet: TDataSet);
var S:String;
begin
  if QI070.FieldByName('UTENTE').AsString = 'SYSMAN' then
    raise Exception.Create('Impossibile cancellare l''utente SYSMAN!');

  S:='';
  with selI071 do
  begin
    First;
    while not Eof do
    begin
      if (FieldByName('LAYOUT').AsString = QI070.FieldByName('UTENTE').AsString) and
         (FieldByName('AZIENDA').AsString = QI070.FieldByName('AZIENDA').AsString) then
        S:=S + IfThen(S <> '',',') + FieldByName('PROFILO').AsString;
      Next;
    end;
    if S <> '' then
      raise Exception.Create('Impossibile cancellare l''utente.' + #13#10 +
                              'E'' usato come layout nei seguenti profili dei Permessi:' + #13#10 + S);
  end;

  RegistraLog.SettaProprieta('C','I070_UTENTI',Copy(Name,1,4),QI070,True);
end;

procedure TA008FOperatoriDtM1.QI070AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  try
    SessioneOracle.ApplyUpdates([QI070],True);
  except
    SessioneOracle.Rollback;
  end;
end;

procedure TA008FOperatoriDtM1.QI070AfterCancel(DataSet: TDataSet);
var i:Integer;
begin
  (DataSet as TOracleDataSet).CancelUpdates;
  QI091.ReadOnly:=True;
  //Ripristino la selezione dei log
  with A008FAziende.TabelleLog do
    for i:=0 to Items.Count - 1 do
      Checked[i]:=QI092.Locate('SCHEDA',CdFnz[i],[]);
  // aggiorna anagrafica collegata
  if (Assigned(A008FOperatori)) and
     (A008FOperatori.GestSelAnag) then
    A008FOperatori.AggiornaDatiAnagraficaCollegata;
end;

procedure TA008FOperatoriDtM1.QI090AfterPost(DataSet: TDataSet);
var Az,AzOld,Iter,CodIter:String;
    i:Integer;
begin
  Az:=DataSet.FieldByName('Azienda').AsString;
  AzOld:=VarToStr(DataSet.FieldByName('Azienda').OldValue);
  try
    Iter:=selI095.FieldByName('ITER').AsString;
    CodIter:=selI095.FieldByName('COD_ITER').AsString;
    SessioneOracle.ApplyUpdates([QI090,QI091],True);
    selI095.Filtered:=False;
    SessioneOracle.ApplyUpdates([selI093,selI095,A181MW.selI094,A181MW.selI097,selI096],True);
    A181MW.AggiornaI095_I096(QI090.FieldByName('AZIENDA').AsString);
    selI093.ReadOnly:=True;
    A181MW.selI094.ReadOnly:=True;
    selI095.ReadOnly:=True;
    A181MW.selI097.ReadOnly:=True;
    selI096.ReadOnly:=True;
    selI093.Refresh;
    A181MW.selI094.Refresh;
    A181MW.selI097.Refresh;
    selI096.Refresh;
    if (AzOld <> '') and (Az <> AzOld) then
    begin
      A181MW.scrupdI090.SetVariable('AZIENDA_OLD',AzOld);
      A181MW.scrupdI090.SetVariable('AZIENDA_NEW',Az);
      A181MW.scrupdI090.Execute;
      SessioneOracle.Commit;
    end;
    if QI090.FieldByName('STORIAINTERVENTO').AsString = 'S' then
      //Scrivo le tabelle selezionate per il log cancellando quelle non selezionate
       with A008FAziende.TabelleLog do
        for i:=0 to Items.Count - 1 do
          if Checked[i] then
          begin
            A181MW.Ins092.SetVariable('AZIENDA',Az);
            A181MW.Ins092.SetVariable('SCHEDA',CdFnz[i]);
            try
              A181MW.Ins092.Execute;
            except
            end;
            //Caratto: 11/04/2013. Unificazione L021. abilito anche la maschera web
            if (CdFnz[i] <> CdFnzWeb[i]) and (CdFnzWeb[i] <> '') then
            begin
              A181MW.Ins092.SetVariable('AZIENDA',Az);
              A181MW.Ins092.SetVariable('SCHEDA',CdFnzWeb[i]);
              try
                A181MW.Ins092.Execute;
              except
              end;
            end;
          end
          else
          begin
            A181MW.Del092.SetVariable('AZIENDA',Az);
            A181MW.Del092.SetVariable('SCHEDA',CdFnz[i]);
            A181MW.Del092.Execute;
            //Caratto: 11/04/2013. Unificazione L021. disabilito anche la maschera web
            if (CdFnz[i] <> CdFnzWeb[i]) and (CdFnzWeb[i] <> '') then
            begin
              A181MW.Del092.SetVariable('AZIENDA',Az);
              A181MW.Del092.SetVariable('SCHEDA',CdFnzWeb[i]);
              try
                A181MW.Del092.Execute;
              except
              end;
            end;
          end;
    SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
  except
    on e:exception do
    begin
      SessioneOracle.Rollback;
      R180MessageBox(E.Message,ERRORE);
    end;
  end;
  SessioneOracle.Commit;
  QI091.CachedUpdates:=False;
  QI091.ReadOnly:=True;
  QI091.Filtered:=False;
  QI090.Close;
  QI090.AfterScroll:=nil;
  QI090.Open;
  QI090.AfterScroll:=QI090AfterScroll;
  QI090.Locate('Azienda',Az,[]);
  selI093.SearchRecord('ITER',Iter,[srFromBeginning]);
  selI095.SearchRecord('ITER;COD_ITER',VarArrayOf([Iter,CodIter]),[srFromBeginning]);
  if QI091.RecordCount = 0 then
    PutDatiEnte;
  //Gestione Jobs Archiviazione Log
  A181MW.JobArchiviazioneLOG;

  if Az = Parametri.Azienda then
    //ASSEGNAZIONE DEGLI EVENTUALI CAMBIAMENTI SUI PARAMETRI AZIENDALI IN TEMPO REALE
  begin
    Parametri.LogTabelle:=QI090.FieldByName('STORIAINTERVENTO').AsString;
    if Parametri.LogTabelle = 'S' then
    begin
      QI092.First;
      Parametri.NomiTabelleLog.Clear;
      while not QI092.Eof do
      begin
        Parametri.NomiTabelleLog.Add(QI092.FieldByName('SCHEDA').AsString);
        QI092.Next;
      end;
      QI092.First;
    end;

    Parametri.RegolePassword.PasswordI060:=Parametri.ProfiloWEB <> '';
    Parametri.RegolePassword.Lunghezza:=QI090.FieldByName('Lung_Password').AsInteger;
    Parametri.RegolePassword.MesiValidita:=QI090.FieldByName('Valid_Password').AsInteger;
    Parametri.RegolePassword.Cifre:=QI090.FieldByName('Password_Cifre').AsInteger;
    Parametri.RegolePassword.Maiuscole:=QI090.FieldByName('Password_Maiuscole').AsInteger;
    Parametri.RegolePassword.CarSpeciali:=QI090.FieldByName('Password_CarSpeciali').AsInteger;
    Parametri.TimbOrig_Verso:=QI090.FieldByName('TimbOrig_Verso').AsString;
    Parametri.TimbOrig_Causale:=QI090.FieldByName('TimbOrig_Causale').AsString;
    Parametri.LunghezzaPassword:=QI090.FieldByName('Lung_Password').AsInteger;
    Parametri.ValiditaPassword:=QI090.FieldByName('Valid_Password').AsInteger;
    Parametri.ValiditaUtente:=QI090.FieldByName('Valid_Utente').AsInteger;
    Parametri.CampiRiferimento.C0_DecorrenzaNonBollanti:=VarToStr(QI091.Lookup('Tipo','C0_DECORRENZANONBOLLANTI','Dato'));
    Parametri.CampiRiferimento.C1_CedoliniConValuta:=VarToStr(QI091.Lookup('Tipo','C1_CEDOLINICONVALUTA','Dato'));
    Parametri.CampiRiferimento.C2_Budget:=VarToStr(QI091.Lookup('Tipo','C2_BUDGET','Dato'));
    Parametri.CampiRiferimento.C2_Capitolo:=VarToStr(QI091.Lookup('Tipo','C2_CAPITOLO','Dato'));
    Parametri.CampiRiferimento.C2_Articolo:=VarToStr(QI091.Lookup('Tipo','C2_ARTICOLO','Dato'));
    Parametri.CampiRiferimento.C2_Costo_Orario:=VarToStr(QI091.Lookup('Tipo','C2_COSTO_ORARIO','Dato'));
    Parametri.CampiRiferimento.C2_Websrv_Bilancio:=VarToStr(QI091.Lookup('Tipo','C2_WEBSRV_BILANCIO','Dato'));
    Parametri.CampiRiferimento.C2_Livello:=VarToStr(QI091.Lookup('Tipo','C2_LIVELLO','Dato'));
    Parametri.CampiRiferimento.C2_Facoltativo:=VarToStr(QI091.Lookup('Tipo','C2_FACOLTATIVO','Dato'));
    Parametri.CampiRiferimento.C3_IndPres:=VarToStr(QI091.Lookup('Tipo','C3_INDPRES','Dato'));
    Parametri.CampiRiferimento.C3_IndPres2:=VarToStr(QI091.Lookup('Tipo','C3_INDPRES2','Dato'));
    Parametri.CampiRiferimento.C3_DatoPianificabile:=VarToStr(QI091.Lookup('Tipo','C3_DATOPIANIFICABILE','Dato'));
    Parametri.CampiRiferimento.C3_RiepTurni_IndPres:=VarToStr(QI091.Lookup('Tipo','C3_RIEPTURNI_INDPRES','Dato'));
    Parametri.CampiRiferimento.C3_DettGG_TipoI:=VarToStr(QI091.Lookup('Tipo','C3_DETTGG_TIPOI','Dato'));
    Parametri.CampiRiferimento.C3_Indennita_Funzione:=VarToStr(QI091.Lookup('Tipo','C3_INDENNITA_FUNZIONE','Dato'));
    Parametri.CampiRiferimento.C4_BuoniMensa:=VarToStr(QI091.Lookup('Tipo','C4_BUONIMENSA','Dato'));
    Parametri.CampiRiferimento.C5_IntegrazAnag:=VarToStr(QI091.Lookup('Tipo','C5_INTEGRAZANAG','Dato'));
    Parametri.CampiRiferimento.C5_Office:=VarToStr(QI091.Lookup('Tipo','C5_OFFICE','Dato'));
    Parametri.CampiRiferimento.C6_InizioProva:=VarToStr(QI091.Lookup('Tipo','C6_INIZIOPROVA','Dato'));
    Parametri.CampiRiferimento.C6_DurataProva:=VarToStr(QI091.Lookup('Tipo','C6_DURATAPROVA','Dato'));
    Parametri.CampiRiferimento.C7_DATO1:=VarToStr(QI091.Lookup('Tipo','C7_DATO1','Dato'));
    Parametri.CampiRiferimento.C7_DATO2:=VarToStr(QI091.Lookup('Tipo','C7_DATO2','Dato'));
    Parametri.CampiRiferimento.C7_DATO3:=VarToStr(QI091.Lookup('Tipo','C7_DATO3','Dato'));
    Parametri.CampiRiferimento.C8_Missione:=VarToStr(QI091.Lookup('Tipo','C8_MISSIONE','Dato'));
    Parametri.CampiRiferimento.C8_MissioneCommessa:=VarToStr(QI091.Lookup('Tipo','C8_MISSIONECOMMESSA','Dato'));
    Parametri.CampiRiferimento.C8_Sede:=VarToStr(QI091.Lookup('Tipo','C8_SEDE','Dato'));
    Parametri.CampiRiferimento.C8_GestioneMensile:=VarToStr(QI091.Lookup('Tipo','C8_GESTIONEMENSILE','Dato'));
    Parametri.CampiRiferimento.C8_ProtocolloObbligatorio:=VarToStr(QI091.Lookup('Tipo','C8_PROTOCOLLO_OBBLIGATORIO','Dato'));
    Parametri.CampiRiferimento.C8_W032RichiediTipoMissione:=VarToStr(QI091.Lookup('Tipo','C8_W032_RICHIEDI_TIPOMISSIONE','Dato'));
    Parametri.CampiRiferimento.C8_W032DettaglioGG:=VarToStr(QI091.Lookup('Tipo','C8_W032_DETTAGLIOGG','Dato'));
    Parametri.CampiRiferimento.C8_W032DocumentoMissioni:=VarToStr(QI091.Lookup('Tipo','C8_W032_DOCUMENTO_MISSIONI','Dato'));
    Parametri.CampiRiferimento.C8_W032RimborsiDett:=VarToStr(QI091.Lookup('Tipo','C8_W032_RIMBORSIDETT','Dato'));
    Parametri.CampiRiferimento.C8_W032RiapriMissione:=VarToStr(QI091.Lookup('Tipo','C8_W032_RIAPRI_MISSIONE','Dato'));
    Parametri.CampiRiferimento.C8_W032TappeSoloSuDistanziometro:=VarToStr(QI091.Lookup('Tipo','C8_W032_TAPPE_SOLO_SU_DISTANZIOMETRO','Dato'));
    Parametri.CampiRiferimento.C8_W032MessaggioTappeInesistenti:=VarToStr(QI091.Lookup('Tipo','C8_W032_MESSAGGIO_TAPPE_INESISTENTI','Dato'));
    Parametri.CampiRiferimento.C8_W032UpdRichiesta:=VarToStr(QI091.Lookup('Tipo','C8_W032_UPDRICHIESTA','Dato'));
    Parametri.CampiRiferimento.C8_W032ProtocolloManuale:=VarToStr(QI091.Lookup('Tipo','C8_W032_PROTOCOLLO_MANUALE','Dato'));
    Parametri.CampiRiferimento.C9_ScaricoPaghe:=VarToStr(QI091.Lookup('Tipo','C9_SCARICOPAGHE','Dato'));
    Parametri.CampiRiferimento.C10_FormazioneProfiloCrediti:=VarToStr(QI091.Lookup('Tipo','C10_FORMAZPROFCRED','Dato'));
    Parametri.CampiRiferimento.C10_FormazioneProfiloCorso:=VarToStr(QI091.Lookup('Tipo','C10_FORMAZPROFCORSO','Dato'));
    Parametri.CampiRiferimento.C11_PianifOrariProg:=VarToStr(QI091.Lookup('Tipo','C11_PIANIFORARIPROG','Dato'));
    Parametri.CampiRiferimento.C11_PianifOrari_DebGG:=VarToStr(QI091.Lookup('Tipo','C11_PIANIFORARI_DEBGG','Dato'));
    Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif:=VarToStr(QI091.Lookup('Tipo','C11_PIANIFORARI_NO_COPIAGIUSTIF','Dato'));
    Parametri.CampiRiferimento.C12_PreferenzeDestinazione:=VarToStr(QI091.Lookup('Tipo','C12_PREFERENZADEST','Dato'));
    Parametri.CampiRiferimento.C12_PreferenzeCompetenza:=VarToStr(QI091.Lookup('Tipo','C12_PREFERENZACOMP','Dato'));
    Parametri.CampiRiferimento.C13_CdcPercentualizzati:=VarToStr(QI091.Lookup('Tipo','C13_CDC_PERCENT','Dato'));
    Parametri.CampiRiferimento.C14_ProvvSede:=VarToStr(QI091.Lookup('Tipo','C14_PROVVSEDE','Dato'));
    Parametri.CampiRiferimento.C15_LimitiMensCaus:=VarToStr(QI091.Lookup('Tipo','C15_LIMITIMENSCAUS','Dato'));
    Parametri.CampiRiferimento.C16_InsRiposi:=VarToStr(QI091.Lookup('Tipo','C16_INSRIPOSI','Dato'));
    Parametri.CampiRiferimento.C17_PostiLetto:=VarToStr(QI091.Lookup('Tipo','C17_POSTILETTO','Dato'));
    Parametri.CampiRiferimento.C18_AccessiMensa:=VarToStr(QI091.Lookup('Tipo','C18_ACCESSIMENSA','Dato'));
    Parametri.CampiRiferimento.C19_StoriaInizioFine:=VarToStr(QI091.Lookup('Tipo','C19_STORIAINIZIOFINE','Dato'));
    Parametri.CampiRiferimento.C20_IncaricoUnitaOrg:=VarToStr(QI091.Lookup('Tipo','C20_INCARICOUNITAORG','Dato'));
    Parametri.CampiRiferimento.C21_ValutazioniLiv1:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_LIV1','Dato'));
    Parametri.CampiRiferimento.C21_ValutazioniLiv2:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_LIV2','Dato'));
    Parametri.CampiRiferimento.C21_ValutazioniLiv3:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_LIV3','Dato'));
    Parametri.CampiRiferimento.C21_ValutazioniLiv4:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_LIV4','Dato'));
    Parametri.CampiRiferimento.C21_ValutazioniRsp1:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_RSP1','Dato'));
    Parametri.CampiRiferimento.C21_ValutazioniRsp2:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_RSP2','Dato'));
    Parametri.CampiRiferimento.C21_ValutazioniPnt1:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_PNT1','Dato'));
    Parametri.CampiRiferimento.C22_PianServLiv1:=VarToStr(QI091.Lookup('Tipo','C21_PIANSERV_LIV1','Dato'));
    Parametri.CampiRiferimento.C22_PianServLiv2:=VarToStr(QI091.Lookup('Tipo','C21_PIANSERV_LIV2','Dato'));
    Parametri.CampiRiferimento.C23_ContrCompetenze:=VarToStr(QI091.Lookup('Tipo','C23_CONTR_COMPETENZE','Dato'));
    Parametri.CampiRiferimento.C23_InsNegCatena:=VarToStr(QI091.Lookup('Tipo','C23_INSNEG_CATENA','Dato'));
    Parametri.CampiRiferimento.C23_VMHFruizGG:=VarToStr(QI091.Lookup('Tipo','C23_VMH_FRUIZGG','Dato'));
    Parametri.CampiRiferimento.C23_VMHCumuloTriennio:=VarToStr(QI091.Lookup('Tipo','C23_VMH_CUMULO_TRIENNIO','Dato'));
    Parametri.CampiRiferimento.C24_AziendaTipoBudget:=VarToStr(QI091.Lookup('Tipo','C24_AZIENDABUDGET','Dato'));
    Parametri.CampiRiferimento.C25_TimbIrr_Auto:=VarToStr(QI091.Lookup('Tipo','C25_TIMBIRR_AUTO','Dato'));
    Parametri.CampiRiferimento.C26_V430Materializzata:=VarToStr(QI091.Lookup('Tipo','C26_V430MATERIALIZZATA','Dato'));
    Parametri.CampiRiferimento.C27_TablespaceFree:=VarToStr(QI091.Lookup('Tipo','C27_TABLESPACE_FREE','Dato'));
    Parametri.CampiRiferimento.C28_CancellaAnnoLog:=VarToStr(QI091.Lookup('Tipo','C28_CANCELLA_ANNO_LOG','Dato'));
    Parametri.CampiRiferimento.C29_ChiamateRepFiltro1:=VarToStr(QI091.Lookup('Tipo','C29_CHIAMATEREP_FILTRO1','Dato'));
    Parametri.CampiRiferimento.C29_ChiamateRepFiltro2:=VarToStr(QI091.Lookup('Tipo','C29_CHIAMATEREP_FILTRO2','Dato'));
    Parametri.CampiRiferimento.C29_ChiamateRepDatiVis:=VarToStr(QI091.Lookup('Tipo','C29_CHIAMATEREP_DATIVIS','Dato'));
    // dati modificabili solo se esistono dati visualizzati
    if Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
      Parametri.CampiRiferimento.C29_ChiamateRepDatiModif:=VarToStr(QI091.Lookup('Tipo','C29_CHIAMATEREP_DATIMODIF','Dato'));
    Parametri.CampiRiferimento.C30_WebSrv_A004_URL:=VarToStr(QI091.Lookup('Tipo','C30_WEBSRV_A004_URL','Dato'));
    Parametri.CampiRiferimento.C30_WebSrv_A004_Dati:=VarToStr(QI091.Lookup('Tipo','C30_WEBSRV_A004_DATI','Dato'));
    Parametri.CampiRiferimento.C31_NoteGiustificativi:=VarToStr(QI091.Lookup('Tipo','C31_NOTEGIUSTIFICATIVI','Dato'));
    Parametri.CampiRiferimento.C33_Link_I070_T030:=VarToStr(QI091.Lookup('Tipo','C33_LINK_I070_T030','Dato'));
    Parametri.CampiRiferimento.C35_ResiduiTriggerBefore:=VarToStr(QI091.Lookup('Tipo','C35_RESIDUI_TRIGGER_BEFORE','Dato'));
    Parametri.CampiRiferimento.C35_ResiduiTriggerAfter:=VarToStr(QI091.Lookup('Tipo','C35_RESIDUI_TRIGGER_AFTER','Dato'));
    Parametri.CampiRiferimento.C90_WebAutorizCurric:=VarToStr(QI091.Lookup('Tipo','C90_WEBAUTORIZCURRIC','Dato'));
    Parametri.CampiRiferimento.C90_EMailW010Uff:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_W010UFF','Dato'));
    Parametri.CampiRiferimento.C90_EMailW018Uff:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_W018UFF','Dato'));
    Parametri.CampiRiferimento.C90_EMailSMTPHost:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_SMTPHOST','Dato'));
    Parametri.CampiRiferimento.C90_EMailUserName:=VarToStr(QI091.LookUp('Tipo','C90_EMAIL_USERNAME','Dato'));
    Parametri.CampiRiferimento.C90_EMailHeloName:=VarToStr(QI091.LookUp('Tipo','C90_EMAIL_HELONAME','Dato'));
    Parametri.CampiRiferimento.C90_EMailPassWord:=R180Decripta(VarToStr(QI091.LookUp('Tipo','C90_EMAIL_PASSWORD','Dato')),30011945);
    Parametri.CampiRiferimento.C90_EMailPort:=VarToStr(QI091.LookUp('Tipo','090_EMAIL_PORT','Dato'));
    Parametri.CampiRiferimento.C90_EMailRespOttimizzata:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_OTTIMIZZATA','Dato'));
    Parametri.CampiRiferimento.C90_EMailRespGGReinvio:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_GG_REINVIO','Dato'));
    Parametri.CampiRiferimento.C90_EMailRespOggetto:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_OGGETTO','Dato'));
    Parametri.CampiRiferimento.C90_EMailRespTesto:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_TESTO','Dato'));
    Parametri.CampiRiferimento.C90_EMailSenderIndirizzo:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_SENDER_INDIRIZZO','Dato'));
    Parametri.CampiRiferimento.C90_WebRighePag:=VarToStr(QI091.Lookup('Tipo','C90_WEBRIGHEPAG','Dato'));
    Parametri.CampiRiferimento.C90_WebTipoCambioOrario:=VarToStr(QI091.Lookup('Tipo','C90_WEBTIPOCAMBIOORARIO','Dato'));
    Parametri.CampiRiferimento.C90_WebSettCambioOrario:=VarToStr(QI091.Lookup('Tipo','C90_WEBSETTCAMBIOORARIO','Dato'));
    Parametri.CampiRiferimento.C90_W026CausE:=VarToStr(QI091.Lookup('Tipo','C90_W026CAUS_E','Dato'));
    Parametri.CampiRiferimento.C90_W026CausU:=VarToStr(QI091.Lookup('Tipo','C90_W026CAUS_U','Dato'));
    Parametri.CampiRiferimento.C90_W005Settimane:=VarToStr(QI091.Lookup('Tipo','C90_W005SETTIMANE','Dato'));
    Parametri.CampiRiferimento.C90_W026TipoRichiesta:=VarToStr(QI091.Lookup('Tipo','C90_W026TIPO_RICHIESTA','Dato'));
    Parametri.CampiRiferimento.C90_W026Spezzoni:=VarToStr(QI091.Lookup('Tipo','C90_W026SPEZZONI','Dato'));
    Parametri.CampiRiferimento.C90_W026TipoAutorizzazione:=VarToStr(QI091.Lookup('Tipo','C90_W026TIPO_AUTORIZZAZIONE','Dato'));
    Parametri.CampiRiferimento.C90_W026TipoStraord:=VarToStr(QI091.Lookup('Tipo','C90_W026TIPO_STRAORD','Dato'));
    Parametri.CampiRiferimento.C90_W026UtilizzoDal:=VarToStr(QI091.Lookup('Tipo','C90_W026UTILIZZO_DAL','Dato'));
    Parametri.CampiRiferimento.C90_W026UtilizzoAl:=VarToStr(QI091.Lookup('Tipo','C90_W026UTILIZZO_AL','Dato'));
    Parametri.CampiRiferimento.C90_W026EccedGGTutta:=VarToStr(QI091.Lookup('Tipo','C90_W026ECCEDGG_TUTTA','Dato'));
    Parametri.CampiRiferimento.C90_W026CheckSaldoDisponibile:=VarToStr(QI091.Lookup('Tipo','C90_W026CHECKSALDODISPONIBILE','Dato'));
    Parametri.CampiRiferimento.C90_NomeProfiloDelega:=VarToStr(QI091.Lookup('Tipo','C90_NOMEPROFILODELEGA','Dato'));
    Parametri.CampiRiferimento.C90_EmailThread:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_THREAD','Dato'));
    Parametri.CampiRiferimento.C90_EMailAuthType:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_AUTHTYPE','Dato'));
    Parametri.CampiRiferimento.C90_EMailUseTLS:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_USETLS','Dato'));
    Parametri.CampiRiferimento.C90_Lingua:=VarToStr(QI091.Lookup('Tipo','C90_LINGUA','Dato')); //***
    Parametri.CampiRiferimento.C90_W009PathPdf:=VarToStr(QI091.Lookup('Tipo','C90_W009PATH_PDF','Dato'));
    Parametri.CampiRiferimento.C90_W009FilePdf:=VarToStr(QI091.Lookup('Tipo','C90_W009FILE_PDF','Dato'));
    Parametri.CampiRiferimento.C90_W010AcquisizioneAuto:=VarToStr(QI091.Lookup('Tipo','C90_W010ACQUISIZIONE_AUTO','Dato'));
    Parametri.CampiRiferimento.C90_W018AcquisizioneAuto:=VarToStr(QI091.Lookup('Tipo','C90_W018ACQUISIZIONE_AUTO','Dato'));
    Parametri.CampiRiferimento.C90_MessaggisticaReply:=VarToStr(QI091.Lookup('Tipo','C90_MESSAGGISTICA_REPLY','Dato'));
    Parametri.CampiRiferimento.C90_FiltroDeleghe:=VarToStr(QI091.Lookup('Tipo','C90_FILTRO_DELEGHE','Dato'));
    Parametri.CampiRiferimento.C90_MessaggisticaObbligoLettura:=VarToStr(QI091.Lookup('Tipo','C90_MESSAGGISTICA_OBBLIGOLETTURA','Dato'));
    Parametri.CampiRiferimento.C90_CronologiaNote:=VarToStr(QI091.Lookup('Tipo','C90_CRONOLOGIA_NOTE','Dato'));
    Parametri.CampiRiferimento.C90_IterMaxAllegati:=VarToStr(QI091.Lookup('Tipo','C90_ITER_MAX_ALLEGATI','Dato'));
    Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB:=VarToStr(QI091.Lookup('Tipo','C90_ITER_MAX_DIM_ALLEGATO_MB','Dato'));
    Parametri.CampiRiferimento.C90_WC38Tolleranza_E:=VarToStr(QI091.Lookup('Tipo','C90_WC38TOLLERANZA_E','Dato'));
    Parametri.CampiRiferimento.C90_WC38Tolleranza_U:=VarToStr(QI091.Lookup('Tipo','C90_WC38TOLLERANZA_U','Dato'));
    Parametri.CampiRiferimento.C90_WC38Rilevatore:=VarToStr(QI091.Lookup('Tipo','C90_WC38RILEVATORE','Dato'));
    Parametri.CampiRiferimento.C90_WC38TimbCausalizzabile:=VarToStr(QI091.Lookup('Tipo','C90_W038TIMBCAUSALIZZABILE','Dato'));
    try
      Parametri.CampiRiferimento.C99_DecorrenzaTAS000000233536:=StrToDate(VarToStr(QI091.Lookup('Tipo','C99_DECORRENZA_TAS000000233536','Dato')));
    except
      Parametri.CampiRiferimento.C99_DecorrenzaTAS000000233536:=DATE_MAX;
    end;
    try
      Parametri.CampiRiferimento.C99_DecorrenzaTAS000000240638:=StrToDate(VarToStr(QI091.Lookup('Tipo','C99_DECORRENZA_TAS000000240638','Dato')));
    except
      Parametri.CampiRiferimento.C99_DecorrenzaTAS000000240638:=DATE_MAX;
    end;
    QI091.Filtered:=True;
  end;
end;

procedure TA008FOperatoriDtM1.PutDatiEnte;
var i:Integer;
begin
  for i:=1 to High(DatiEnte) do
  begin
    A181MW.Ins091.SetVariable('AZIENDA',QI090Azienda.AsString);
    A181MW.Ins091.SetVariable('ORDINE',i);
    A181MW.Ins091.SetVariable('TIPO',DatiEnte[i].Nome);
    try
      A181MW.Ins091.Execute;
    except
    end;
  end;
  SessioneOracle.Commit;
  QI091.Close;
  QI091.Open;
end;

procedure TA008FOperatoriDtM1.QI090BeforeDelete(DataSet: TDataSet);
{Cancello gli operatori associati all'azienda col metodo Delete per scatenare
l'evento BeforeDelete di QI070}
begin
  if DataSet.FieldByName('AZIENDA').AsString = 'AZIN' then
    raise Exception.Create('Impossibile cancellare l''azienda AZIN!');
  with A181MW.scrdelI090 do
  begin
    SetVariable('AZIENDA',DataSet.FieldByName('AZIENDA').AsString);
    Execute;
  end;
  RegistraLog.SettaProprieta('C','I090_ENTI',Copy(Name,1,4),QI090,True);
end;

procedure TA008FOperatoriDtM1.QI090AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([QI070,QI090],True);
  try
    SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
  except
    SessioneOracle.Rollback;
  end;
end;

procedure TA008FOperatoriDtM1.QI090NewRecord(DataSet: TDataSet);
begin
  with QI090 do
  begin
    FieldByName('Utente').AsString:='MONDOEDP';
    FieldByName('ParolaChiave').AsString:=R180Cripta(A000PasswordFissa,21041974);
    FieldByName('StoriaIntervento').AsString:='N';
    FieldByName('TSLavoro').AsString:='LAVORO';
    FieldByName('TSIndici').AsString:='INDICI';
  end;
end;

procedure TA008FOperatoriDtM1.QI091AfterDelete(DataSet: TDataSet);
begin
  A181MW.QI091AfterDelete;
end;

procedure TA008FOperatoriDtM1.QI091AfterPost(DataSet: TDataSet);
begin
  A181MW.QI091AfterPost;
end;

procedure TA008FOperatoriDtM1.QI091AfterScroll(DataSet: TDataSet);
var i:Integer;
begin
  for i:=1 to High(DatiEnte) do
    if QI091.FieldByName('TIPO').AsString = DatiEnte[i].Nome then
    begin
      QI091.FieldByName('DATO').ReadOnly:=not R180In(DatiEnte[i].Lista,['','NUMERICO','GIORNO_MESE','DATA']);
      if A008FAziende <> nil then
      try
        if R180In(DatiEnte[i].Lista,['','NUMERICO','GIORNO_MESE','DATA']) then
          A008FAziende.DbGrid1.Columns[2].ButtonStyle:=cbsNone
        else
          A008FAziende.DbGrid1.Columns[2].ButtonStyle:=cbsEllipsis;
      except
      end;
    end;
end;

procedure TA008FOperatoriDtM1.QI091BeforeDelete(DataSet: TDataSet);
begin
  //Abort;  Massimo 17/12/2012 gestione A181UAziendeMW
  A181MW.QI091BeforeDelete;
end;

procedure TA008FOperatoriDtM1.QI091BeforePost(DataSet: TDataSet);
(*
var i,j,TestInt:integer;
    TestString, ListaNumeri:String;
*)
begin
  A181MW.QI091BeforePost;
  { Massimo 17/12/2012 gestione A181UAziendeMW
  //Verifica dei dati numerici della I091 Dati aziendali
  ListaNUmeri:='0123456789';
  i:=1;
  while (DatiEnte[i].Nome <> QI091.FieldByName('TIPO').AsString) do
    inc(i);
  if DatiEnte[i].Nome = QI091.FieldByName('TIPO').AsString then
  begin
    TestString:=QI091.FieldByName('DATO').AsString;
    if DatiEnte[i].Lista = 'NUMERICO' then
    begin
      for j:=1 to Length(TestString) do
        if pos(TestString[j], ListaNUmeri) <= 0 then
          raise Exception.Create('Impossibile inserire un valore non numerico!');
    end
    else if DatiEnte[i].Lista = 'GIORNO_MESE' then
    begin
      if not TryStrToInt(TestString,TestInt) then
        raise Exception.Create('Il valore da inserire deve essere un intero compreso fra 1 e 31!');
      if (TestInt < 1) or (TestInt > 31) then
        raise Exception.Create('Il valore da inserire deve essere compreso fra 1 e 31!');
    end;
  end;
  if DatiEnte[i].Nome = 'C90_EMAIL_PASSWORD' then
    QI091.FieldByName('DATO').AsString:=R180Cripta(QI091.FieldByName('DATO').AsString,30011945);
  }
end;

procedure TA008FOperatoriDtM1.QI090AfterScroll(DataSet: TDataSet);
var
  i,j:Integer;
  GestAllegati: Boolean;
begin
  //Rilettura dati aziendali
  with QI091 do
  begin
    Close;
    SetVariable('AZIENDA',QI090Azienda.AsString);
    Open;
  end;
  //Rilettura indicazioni sui log
  with QI092 do
  begin
    Close;
    SetVariable('AZIENDA',QI090Azienda.AsString);
    Open;
  end;
  //Apertura del database indicato dall'Azienda
  with DbIris008B do
  begin
    if (not Connected) or
       (UpperCase(LogonUserName) <> UpperCase(QI090.FieldByName('UTENTE').AsString)) then
    begin
      Logoff;
      if QI090.State = dsInsert then
      begin
        LogonDataBase:=Parametri.Database;
        LogonUserName:='MONDOEDP';
        LogonPassword:=Parametri.PasswordMondoEDP;
      end
      else
      begin
        LogonDataBase:=Parametri.Database;
        LogonUserName:=QI090.FieldByName('UTENTE').AsString;
        LogonPassword:=R180Decripta(QI090.FieldByName('PAROLACHIAVE').AsString,21041974);
      end;
      Logon;
    end;
  end;
  //Apertura tabelle dell'Azienda
  QCols.Open;
  selaT030.Open;
  selDizionario.Open;
  selT033.Open;
  CdFnz.Clear;
  CdFnzWeb.Clear;
  with A008FAziende do
  begin
    TabelleLog.Items.Clear;
    TabelleLog.Sorted:=False;
    j:=0;
    for i:=1 to High(FunzioniDisponibili) do
    begin
      if (L021GetMaschera(i) <> 'XXXX') and (FunzioniDisponibili[i].T <> 47) and //Alberto 28/11/2005: escludo l'inserimento collettivo giustificativi, che ha la stessa sigla di A004
         L021VerificaApplicazione(Parametri.Applicazione,i) then
      begin
        TabelleLog.Items.Add(FunzioniDisponibili[i].G + ': ' + FunzioniDisponibili[i].N);
        TabelleLog.Checked[j]:=QI092.Locate('SCHEDA',L021GetMaschera(i),[]);
        inc(j);
      end;
    end;
    TabelleLog.Sorted:=True;
    for i:=0 to TabelleLog.Items.Count - 1 do
      for j:=1 to High(FunzioniDisponibili) do
      begin
        if (L021GetMaschera(j) <> 'XXXX') and (FunzioniDisponibili[j].T <> 47) and //Alberto 28/11/2005: escludo l'inserimento collettivo giustificativi, che ha la stessa sigla di A004
           L021VerificaApplicazione(Parametri.Applicazione,j) and
           (TabelleLog.Items[i] = FunzioniDisponibili[j].G + ': ' + FunzioniDisponibili[j].N) then
        begin
          CdFnz.Add(L021GetMaschera(j));
          CdFnzWeb.Add(FunzioniDisponibili[j].SW);//Caratto: 11/04/2013. Unificazione L021. codice della maschera web. abilito/disabilito in coppia con la maschera win
          Break;
        end;
      end;
  end;
  A181MW.OpenSelI093;
  OpenSelI095(QI090.FieldByName('AZIENDA').AsString);
  OpenSelI095Dist;
  A181MW.OpenSelI094;
  A181MW.OpenSelI097;
  OpenSelI096;

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  // visibilità colonne allegati
  GestAllegati:=A000ModuloAbilitato(SessioneOracle,'PUBBL_DOCUMENTI_ESTERNI',QI090.FieldByName('AZIENDA').AsString);
  A008FAziende.dgrdselI095.Columns[8].Visible:=GestAllegati;
  A008FAziende.dgrdselI095.Columns[9].Visible:=GestAllegati;
  A008FAziende.dgrdselI096.Columns[11].Visible:=GestAllegati;
  A008FAziende.dgrdselI096.Columns[12].Visible:=GestAllegati;
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

  // aggiornamento di alcuni parametri aziendali
  Parametri.CampiRiferimento.C33_Link_I070_T030:=VarToStr(QI091.Lookup('Tipo','C33_LINK_I070_T030','Dato'));
  if Assigned(A008FOperatori) then
    A008FOperatori.OnAziendaChange;
end;

procedure TA008FOperatoriDtM1.QI090AfterEdit(DataSet: TDataSet);
begin
  QI091.CachedUpdates:=True;
  QI091.ReadOnly:=False;
end;

procedure TA008FOperatoriDtM1.QI090BeforePost(DataSet: TDataSet);
var MassimoI095, MassimoI096, i:Integer;
    Iter, CodIter:String;
begin
  if QI090.State = dsInsert then
  begin
    QI091.CachedUpdates:=True;
    QI091.ReadOnly:=False;
  end;
  //Tabelle degli iter autorizzativi
  if selI093.State in [dsInsert,dsEdit] then
    selI093.Post;
  if selI095.State in [dsInsert,dsEdit] then
    selI095.Post;
  if A181MW.selI097.State in [dsInsert,dsEdit] then
    A181MW.selI097.Post;
  if selI096.State in [dsInsert,dsEdit] then
    selI096.Post;

  selI093.DisableControls;
  A181MW.selI094.DisableControls;
  selI095.DisableControls;
  selI096.DisableControls;
  A181MW.selI097.DisableControls;
  Iter:=selI093.FieldByName('ITER').AsString;
  CodIter:=selI095.FieldByName('COD_ITER').AsString;

  try
    selI093.First;
    while not selI093.Eof do
    begin
      //Verifico che non vi siano più di 1 struttura con condizione nulla per ciascun iter
      selI095.First;
      MassimoI095:=0;
      while not selI095.Eof do
      begin
        if selI095.FieldByName('FILTRO_RICHIESTA').IsNull then
          inc(MassimoI095);
        if MassimoI095 > 1 then
        begin
          i:=selI095.RecNo - 1; // boh..
          raise Exception.Create('Impossibile inserire più di un "Condiz. per riconoscimento Codice Iter" nullo per l''iter ' + A000IterAutorizzativi[i].Desc);
        end;

        //Per ogni struttura verifico completezza di livelli per ogni iter + cod_iter
        selI096.First;
        MassimoI096:=0;
        while not selI096.Eof do
        begin
          MassimoI096:=Max(MassimoI096,selI096.FieldByName('LIVELLO').AsInteger);
          selI096.Next;
        end;
        if MassimoI096 <> selI096.RecordCount then
        begin
          Iter:=selI096.FieldByName('ITER').AsString;
          CodIter:=selI096.FieldByName('COD_ITER').AsString;
          raise Exception.Create(Format('Livelli non consecutivi per l''iter "%s" e codice iter "%s"',[A181MW.Decod_Iter(selI096.FieldByName('ITER').AsString),selI096.FieldByName('COD_ITER').AsString]));
        end;

        //Riordinamento record delle condizioni di validità
        i:=1;
        A181MW.selI097.First;
        while not A181MW.selI097.Eof do
        begin
          A181MW.selI097.Edit;
          A181MW.selI097.FieldByName('NUM_CONDIZ').AsInteger:=i;
          A181MW.selI097.Post;
          inc(i);
          A181MW.selI097.Next;
        end;

        selI095.Next;
      end;

      selI093.Next;
    end;
  finally
    selI095.Filtered:=True;
    selI093.SearchRecord('ITER',Iter,[srFromBeginning]);
    selI095.SearchRecord('COD_ITER',CodIter,[srFromBeginning]);
    selI093.EnableControls;
    A181MW.selI094.EnableControls;
    selI095.EnableControls;
    selI096.EnableControls;
    A181MW.selI097.EnableControls;
  end;

  if (QI090.State = dsEdit) and
     (QI090.FieldByName('PAROLACHIAVE').Value <> QI090.FieldByName('PAROLACHIAVE').medpOldValue) then
    if R180MessageBox('ATTENZIONE!' + #13#10 +
                      'E'' stata modificata la password di connessione al database.' + #13#10 +
                      'Si ricorda che questa NON E'' la password del proprio operatore.' + #13#10 +
                      'Questa operazione avrà effetto a livello globale per tutti' + #13#10 +
                      'gli utenti dell''azienda "' + QI090.FieldByName('AZIENDA').AsString + '".' + #13#10 +
                      'Vuoi continuare?',DOMANDA) = mrNo then
      Abort;

  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','I090_ENTI',Copy(Name,1,4),QI090,True);
    dsEdit:RegistraLog.SettaProprieta('M','I090_ENTI',Copy(Name,1,4),QI090,True);
  end;
end;

procedure TA008FOperatoriDtM1.QI090DOMINIO_DIP_TIPOChange(Sender: TField);
begin
  if Sender.IsNull then
    Sender.AsString:='NTLM';
end;

(* Massimo 17/12/2012 gestione A181UAziendeMW
function TA008FOperatoriDtM1.GetI091Gruppo(CodI091:String):String;
var i:Integer;
begin
  i:=Low(DatiEnte);
  while (i < High(DatiEnte)) and (DatiEnte[i].Nome <> CodI091) do
    inc(i);
  Result:=DatiEnte[i].Gruppo;
end;
*)

procedure TA008FOperatoriDtM1.QI091CalcFields(DataSet: TDataSet);
{descrizione dei dati disponibili in Gestione Moduli}
begin
  A181MW.QI091CalcFields;
  (* Massimo 17/12/2012 gestione A181UAziendeMW
  QI091D_Tipo.AsString:=A000DescDatiEnte(QI091Tipo.AsString);
  if QI091D_Tipo.AsString = '' then
    QI091D_Tipo.AsString:=QI091Tipo.AsString;
  QI091.FieldByName('GRUPPO').AsString:=GetI091Gruppo(QI091.FieldByName('TIPO').AsString);
  *)
end;

procedure TA008FOperatoriDtM1.QI091DATOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
 if QI091.FieldByName('TIPO').AsString = 'C90_EMAIL_PASSWORD' then
   Text:=DupeString('*',Length(Sender.AsString))
 else
   Text:=Sender.AsString;
end;

procedure TA008FOperatoriDtM1.QI091FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  A181MW.QI091FilterRecord(DataSet,Accept);
end;

procedure TA008FOperatoriDtM1.QI070AfterScroll(DataSet: TDataSet);
begin
  QI070.FieldByName('AZIENDA').ReadOnly:=False;
  QI070.FieldByName('UTENTE').ReadOnly:=QI070.FieldByName('UTENTE').AsString = 'SYSMAN';
  QI090.Locate('AZIENDA',QI070.FieldByName('AZIENDA').AsString,[]);
  // se necessario forza un afterscroll (qualora sia disattivato)
  if (@QI090.AfterScroll = nil) and (QI090.FieldByName('AZIENDA').AsString <> AziendaCorrente) then
    QI090AfterScroll(QI090);
  AziendaCorrente:=QI070.FieldByName('AZIENDA').AsString;
  AggiornaFiltroProfili;
  try
    if A008FOperatori <> nil then
    begin
      if VarToStr(A008FOperatori.dlckPermessi.KeyValue) <> A008FOperatori.dlckPermessi.Text then
      begin
        A008FOperatori.dlckPermessi.KeyValue:=null;
        A008FOperatori.dlckFiltroAnagrafe.KeyValue:=null;
        A008FOperatori.dlckFiltroFunzioni.KeyValue:=null;
        A008FOperatori.dlckFiltroDizionario.KeyValue:=null;
        A008FOperatori.dlckPermessi.KeyValue:=QI070.FieldByName('PERMESSI').AsString;
        A008FOperatori.dlckFiltroAnagrafe.KeyValue:=QI070.FieldByName('FILTRO_ANAGRAFE').AsString;
        A008FOperatori.dlckFiltroFunzioni.KeyValue:=QI070.FieldByName('FILTRO_FUNZIONI').AsString;
        A008FOperatori.dlckFiltroDizionario.KeyValue:=QI070.FieldByName('FILTRO_DIZIONARIO').AsString;
      end;

      // operazioni in caso di anagrafica collegata
      if A008FOperatori.GestSelAnag then
      begin
        // aggiorna anagrafica collegata
        A008FOperatori.AggiornaDatiAnagraficaCollegata;

        // reset selezione anagrafica
        A008FOperatori.ResetSelAnagrafe;
      end;
    end;
  except
  end;
  //Apertura del database indicato dall'Azienda
  if (not DbIris008B.Connected) or
     (UpperCase(DbIris008B.LogonUserName) <> UpperCase(QI090.FieldByName('UTENTE').AsString)) then
  begin
    DbIris008B.Logoff;
    DbIris008B.LogonDatabase:=Parametri.Database;
    DbIris008B.LogonUserName:=QI090.FieldByName('UTENTE').AsString;
    DbIris008B.LogonPassword:=R180Decripta(QI090.FieldByName('PAROLACHIAVE').AsString,21041974);
    DbIris008B.Logon;
    try
      selI010.Apri(DbIris008B,'',Parametri.Applicazione,'','','');
    except
      on E:Exception do
        ShowMessage(E.Message);
    end;
    selT033.Open;
    selDizionario.Open;
  end;
end;

procedure TA008FOperatoriDtM1.QI070AZIENDAValidate(Sender: TField);
begin
  AziendaCorrente:=Sender.AsString;
  AggiornaFiltroProfili;
end;

procedure TA008FOperatoriDtM1.BDEQI090PAROLACHIAVEGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  Text:=R180Decripta(Sender.AsString,21041974);
end;

procedure TA008FOperatoriDtM1.BDEQI090PAROLACHIAVESetText(Sender: TField;
  const Text: String);
begin
  Sender.AsString:=R180Cripta(Text,21041974);
end;

procedure TA008FOperatoriDtM1.AggiornaFiltroProfili;
begin
  with selI071 do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
  with selI072Dist do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
  with selI073Dist do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
  with selI074Dist do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
  with selI075Dist do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      FiltraSelI075;
      EnableControls;
    end;
end;

procedure TA008FOperatoriDtM1.selI072FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=selI072Dist.Active and
          (selI072.FieldByName('PROFILO').AsString = selI072Dist.FieldByName('PROFILO').AsString) and
          (selI072.FieldByName('AZIENDA').AsString = selI072Dist.FieldByName('AZIENDA').AsString);
end;

procedure TA008FOperatoriDtM1.selI073FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=selI073Dist.Active and
          (selI073.FieldByName('PROFILO').AsString = selI073Dist.FieldByName('PROFILO').AsString) and
          (selI073.FieldByName('AZIENDA').AsString = selI073Dist.FieldByName('AZIENDA').AsString);
end;

procedure TA008FOperatoriDtM1.selI074FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=selI074Dist.Active and
          (selI074.FieldByName('PROFILO').AsString = selI074Dist.FieldByName('PROFILO').AsString) and
          (selI074.FieldByName('AZIENDA').AsString = selI074Dist.FieldByName('AZIENDA').AsString);
end;

(*  Massimo 14/12/2012 gestione A181UAziendeMW
  function TA008FOperatoriDtm1.Decod_Iter(InIter:String):String;
  var i:Integer;
  begin
    Result:='';
    if InIter = '' then
      Exit;
    i:=0;
    while (A000IterAutorizzativi[i].Cod <> InIter) and (i < High(A000IterAutorizzativi)) do
      inc(i);
    Result:=A000IterAutorizzativi[i].Desc;
  end;
*)

procedure TA008FOperatoriDtM1.selI075ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  if (Action = 'C') and (Sender.RowID = '') then
    Applied:=True
  else if Sender.RowID = '' then
  begin
    if Action = 'U' then
    begin
      insI075.SetVariable('AZIENDA',selI075.FieldByName('AZIENDA').AsString);
      insI075.SetVariable('PROFILO',selI075.FieldByName('PROFILO').AsString);
      insI075.SetVariable('ITER',selI075.FieldByName('ITER').AsString);
      insI075.SetVariable('COD_ITER',selI075.FieldByName('COD_ITER').AsString);
      insI075.SetVariable('LIVELLO',selI075.FieldByName('LIVELLO').AsString);
      insI075.SetVariable('ACCESSO',selI075.FieldByName('ACCESSO').AsString);
      insI075.Execute;
    end;
    Applied:=True;
  end;
end;

procedure TA008FOperatoriDtM1.selI075CalcFields(DataSet: TDataSet);
begin
  selI075.FieldByName('D_ITER').AsString:=A181MW.Decod_Iter(selI075.FieldByName('ITER').AsString);
end;

procedure TA008FOperatoriDtM1.selI075DistAfterScroll(DataSet: TDataSet);
begin
  FiltraSelI075;
end;

procedure TA008FOperatoriDtM1.selI075NewRecord(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA008FOperatoriDtM1.selI076BeforePost(DataSet: TDataSet);
var
  LConsentito: String;
  LIPEsterno: String;
begin
  // ip: dato obbligatorio
  if selI076.FieldByName('IP').AsString.Trim = '' then
    raise Exception.Create('Indicare l''indirizzo IP');

  // consentito: valori possibili: S/N
  LConsentito:=selI076.FieldByName('CONSENTITO').AsString.Trim;
  if (LConsentito = '') or
     (not R180In(LConsentito,['S','N'])) then
    raise Exception.Create('Selezionare S oppure N per consentire o meno l''indirizzo IP indicato!');

  // ip_esterno: valori possibili: S/N
  LIPEsterno:=selI076.FieldByName('IP_ESTERNO').AsString.Trim;
  if (LIPEsterno = '') or
     (not R180In(LIPEsterno,['S','N'])) then
    raise Exception.Create('Selezionare S oppure N per indicare se l''IP indicato è esterno o interno!');
end;

procedure TA008FOperatoriDtM1.selI076NewRecord(DataSet: TDataSet);
begin
  selI076.FieldByName('AZIENDA').AsString:=selI073.FieldByName('AZIENDA').AsString;
  selI076.FieldByName('PROFILO').AsString:=selI073.FieldByName('PROFILO').AsString;
  selI076.FieldByName('APPLICAZIONE').AsString:=selI073.FieldByName('APPLICAZIONE').AsString;
  selI076.FieldByName('TAG').AsInteger:=selI073.FieldByName('TAG').AsInteger;
end;

procedure TA008FOperatoriDtM1.selI072DistAfterScroll(DataSet: TDataSet);
begin
  selI072.Filtered:=False;
  selI072.Filtered:=True;
  GetFiltroAnagrafe;
  A008FProfili.EspandiGridFAnagrafe(False);
end;

procedure TA008FOperatoriDtM1.selI073DistAfterScroll(DataSet: TDataSet);
begin
  selI073.Filtered:=False;
  selI073.Filtered:=True;
end;

procedure TA008FOperatoriDtM1.selI074DistAfterScroll(DataSet: TDataSet);
begin
  selI074.Filtered:=False;
  selI074.Filtered:=True;
  A008FProfili.cmbDizionarioChange(nil);
end;

procedure TA008FOperatoriDtM1.GetFiltroAnagrafe;
{Lettura del filtro anagrafe dentro il memo}
begin
  A008FProfili.memoFiltroAnagrafe.Lines.Clear;
  selI072.First;
  while not selI072.Eof do
  begin
    A008FProfili.memoFiltroAnagrafe.Lines.Add(selI072.FieldByName('FILTRO').AsString);
    selI072.Next;
  end;
  A008FProfili.memoFiltroAnagrafe.SelStart:=Length(A008FProfili.memoFiltroAnagrafe.Lines.Text) - 1;
end;

procedure TA008FOperatoriDtM1.PutFiltroAnagrafe;
{Registrazione del contenuto di memoFiltroAnagrafe}
var i:Integer;
begin
  selI072.First;
  while not selI072.Eof do
    selI072.Delete;
  for i:=0 to A008FProfili.memoFiltroAnagrafe.Lines.Count - 1 do
  begin
    selI072.Append;
    selI072.FieldByName('AZIENDA').AsString:=AziendaCorrente;
    selI072.FieldByName('PROFILO').AsString:=selI072Dist.FieldByName('PROFILO').AsString;
    selI072.FieldByName('PROGRESSIVO').AsInteger:=i;
    selI072.FieldByName('FILTRO').AsString:=A008FProfili.memoFiltroAnagrafe.Lines[i];
    selI072.Post;
  end;
end;

procedure TA008FOperatoriDtM1.PutFiltroDizionario;
{Registrazione dei codici di dizionari selezionati}
var
  i:Integer;
  Inserito:Boolean;
begin
  A185MW.GetI074(A185MW.selI074Before,
                 QI090.FieldByName('AZIENDA').AsString,
                 selI074Dist.FieldByName('PROFILO').AsString,
                 A008FProfili.cmbDizionario.Text);
  selI074.First;
  while not selI074.Eof do
  begin
    if selI074.FieldByName('TABELLA').AsString = A008FProfili.cmbDizionario.Text then
      selI074.Delete
    else
      selI074.Next;
  end;
  Inserito:=False;
  for i:=0 to A008FProfili.lstDizionario.Items.Count - 1 do
  begin
    if A008FProfili.lstDizionario.Checked[i] then
    begin
      Inserito:=True;
      selI074.Append;
      selI074.FieldByName('AZIENDA').AsString:=AziendaCorrente;
      selI074.FieldByName('PROFILO').AsString:=selI074Dist.FieldByName('PROFILO').AsString;
      selI074.FieldByName('TABELLA').AsString:=A008FProfili.cmbDizionario.Text;
      if not R180In(A008FProfili.cmbDizionario.Text,['ANOMALIE DEI CONTEGGI','ANOMALIE NASCOSTE SU CARTELLINO WEB']) then
        selI074.FieldByName('CODICE').AsString:=A008FProfili.lstDizionario.Items[i]
      else
        selI074.FieldByName('CODICE').AsString:=Trim(Copy(A008FProfili.lstDizionario.Items[i],1,5));
      if A008FProfili.rgpDizionario.ItemIndex = 0 then
        selI074.FieldByName('ABILITATO').AsString:='S'
      else
        selI074.FieldByName('ABILITATO').AsString:='N';
      selI074.Post;
    end;
  end;
  if (not Inserito) and (A008FProfili.rgpDizionario.ItemIndex = 0) then
  begin
    selI074.Append;
    selI074.FieldByName('AZIENDA').AsString:=AziendaCorrente;
    selI074.FieldByName('PROFILO').AsString:=selI074Dist.FieldByName('PROFILO').AsString;
    selI074.FieldByName('TABELLA').AsString:=A008FProfili.cmbDizionario.Text;
    selI074.FieldByName('CODICE').AsString:='DIZIONARIO DISABILITATO';
    selI074.FieldByName('ABILITATO').AsString:='S';
    selI074.Post;
  end;
  A185MW.GetI074(A185MW.selI074After,
                 QI090.FieldByName('AZIENDA').AsString,
                 selI074Dist.FieldByName('PROFILO').AsString,
                 A008FProfili.cmbDizionario.Text);
  A185MW.ConfrontaFiltroDizionario;
end;

procedure TA008FOperatoriDtM1.BeforeScroll(DataSet: TDataSet);
{Si impedisce lo scorrimento sui profili disponibili se si è in modifica}
begin
  if not BrowseProfili then
    Abort;
end;

procedure TA008FOperatoriDtM1.selI010AfterOpen(DataSet: TDataSet);
{Lettura dei nomi di colonna validi per l'azienda selezionata}
begin
  A008FProfili.lstNomeCampo.Clear;
  while not selI010.Eof do
  begin
    A008FProfili.lstNomeCampo.Add(selI010.FieldByName('NOME_CAMPO').AsString);
    selI010.Next;
  end;
end;

procedure TA008FOperatoriDtM1.selI061ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  case Action of
    'I':RegistraLog.SettaProprieta('I','I061_PROFILI_DIPENDENTE',Copy(Name,1,4),selI061,True);
    'U':RegistraLog.SettaProprieta('M','I061_PROFILI_DIPENDENTE',Copy(Name,1,4),selI061,True);
    'D':RegistraLog.SettaProprieta('C','I061_PROFILI_DIPENDENTE',Copy(Name,1,4),selI061,True);
  end;
  if Action in ['I','U','D'] then
    RegistraLog.RegistraOperazione;
end;

procedure TA008FOperatoriDtM1.selI061BeforeEdit(DataSet: TDataSet);
begin
  if QI060.RecordCount <= 0 then
    Raise Exception.Create(A000MSG_A186_ERR_NO_UTENTE);
end;

procedure TA008FOperatoriDtM1.selI061BeforeInsert(DataSet: TDataSet);
begin
  if QI060.RecordCount <= 0 then
    Raise Exception.Create(A000MSG_A186_ERR_NO_UTENTE);
end;

procedure TA008FOperatoriDtM1.selI061BeforePost(DataSet: TDataSet);
begin
  if not selI071.SearchRecord('PROFILO',selI061.FieldByName('PERMESSI').AsString,[srFromBeginning]) then
    raise exception.Create('Codice Permessi non esistente!');
  if not selI073Dist.SearchRecord('PROFILO',selI061.FieldByName('FILTRO_FUNZIONI').AsString,[srFromBeginning]) then
    raise exception.Create('Filtro funzioni non esistente!');
  if (Not selI061.FieldByName('ITER_AUTORIZZATIVI').IsNull) and
     (Not selI075Dist.SearchRecord('PROFILO',selI061.FieldByName('ITER_AUTORIZZATIVI').AsString,[srFromBeginning])) then
    raise Exception.Create('Iter autorizzativo non esistente!');
  if (not selI061.FieldByName('FILTRO_ANAGRAFE').IsNull) and
     (not selI072Dist.SearchRecord('PROFILO',selI061.FieldByName('FILTRO_ANAGRAFE').AsString,[srFromBeginning])) then
    raise exception.Create('Filtro anagrafe non esistente!');
  if (not selI061.FieldByName('FILTRO_DIZIONARIO').IsNull) and
     (not selI074Dist.SearchRecord('PROFILO',selI061.FieldByName('FILTRO_DIZIONARIO').AsString,[srFromBeginning])) then
    raise exception.Create('Filtro dizionario non esistente!');
  if Not R180In(selI061.FieldByName('RICEZIONE_MAIL').AsString,['S','N']) then
    raise exception.Create('Il campo Ricezione E-Mail può contenere solo i valori "S" o "N".');
  // modifica delegato_da.ini
  if (not selI061.FieldByName('DELEGATO_DA').IsNull) and
     (not selI060.SearchRecord('NOME_UTENTE',selI061.FieldByName('DELEGATO_DA').AsString,[srFromBeginning])) then
    raise exception.Create('Il valore di Delegato non è un nome utente valido!');
  // modifica delegato_da.fine
end;

procedure TA008FOperatoriDtM1.selI061FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=True;
  if selI061VisioneCorrente then
    Accept:=(selI061.FieldByName('INIZIO_VALIDITA').AsDateTime <= Parametri.DataLavoro) and
            (selI061.FieldByName('FINE_VALIDITA').AsDateTime >= Parametri.DataLavoro);
end;

procedure TA008FOperatoriDtM1.selI061NewRecord(DataSet: TDataSet);
begin
  selI061.FieldByName('AZIENDA').AsString:=QI060.FieldByName('AZIENDA').AsString;
  selI061.FieldByName('NOME_UTENTE').AsString:=QI060.FieldByName('NOME_UTENTE').AsString;
  selI061.FieldByName('NOME_PROFILO').AsString:=A008FLoginDipendenti.cmbNomeProfilo.Text;
  selI061.FieldByName('PERMESSI').AsString:=A008FLoginDipendenti.cmbPermessi.Text;
  selI061.FieldByName('PERMESSI').AsString:=A008FLoginDipendenti.cmbPermessi.Text;
  selI061.FieldByName('FILTRO_ANAGRAFE').AsString:=A008FLoginDipendenti.cmbFiltroAnagrafe.Text;
  selI061.FieldByName('FILTRO_FUNZIONI').AsString:=A008FLoginDipendenti.cmbFiltroFunzioni.Text;
  selI061.FieldByName('ITER_AUTORIZZATIVI').AsString:=A008FLoginDipendenti.cmbIterAutor.Text;
  selI061.FieldByName('FILTRO_DIZIONARIO').AsString:=A008FLoginDipendenti.cmbFiltroDizionario.Text;
  selI061.FieldByName('INIZIO_VALIDITA').AsDateTime:=EncodeDate(1900,1,1);
  selI061.FieldByName('FINE_VALIDITA').AsDateTime:=EncodeDate(3999,12,31);
end;

procedure TA008FOperatoriDtM1.selI065AfterPost(DataSet: TDataSet);
begin
  selI065U.Refresh;
  selI065P.Refresh;
end;

procedure TA008FOperatoriDtM1.selI065BeforePost(DataSet: TDataSet);
var ODS:TOracleDataSet;
begin
  with selI065.FieldByName('TIPO') do
    if (AsString <> 'P') and (AsString <> 'U') then
      Raise Exception.Create('Il campo Tipo non è valido!');
  selI065.FieldByName('CODICE').AsString:=Trim(selI065.FieldByName('CODICE').AsString);
  ODS:=TOracleDataset.Create(nil);
  try
    ODS.Session:=A008FOperatoriDtM1.DbIris008B;
    ODS.SQL.Text:='SELECT :ESPRESSIONE ESPRESSIONE FROM T030_ANAGRAFICO WHERE PROGRESSIVO = 0';
    ODS.DeclareVariable('ESPRESSIONE',otSubst);
    ODS.SetVariable('ESPRESSIONE',DataSet.FieldByName('ESPRESSIONE').AsString);
    try
      ODS.Open;
    except
      on E:Exception do
       Raise Exception.Create('Il campo espressione non è un comando SQL valido!');
    end;
  finally
    FreeAndNil(ODS);
  end;

end;

procedure TA008FOperatoriDtM1.selI065CalcFields(DataSet: TDataSet);
begin
  selI065.FieldByName('C_TIPO').AsString:=ifthen(selI065.FieldByName('TIPO').AsString='P','Password','Utente');
end;

(*
procedure TA008FOperatoriDtM1.AggiornaI073;
{Aggiornamento iniziale delle funzioni disponibili}
begin
  if Parametri.Azienda = 'AZIN' then
    selI073Dist.Filtered:=False;
  Screen.Cursor:=crHourGlass;
  selI073Dist.First;
  while not selI073Dist.Eof do
  begin
    CreaFiltroFunzioni(selI073Dist.FieldByName('AZIENDA').AsString,selI073Dist.FieldByName('PROFILO').AsString);
    selI073Dist.Next;
  end;
  selI073Dist.Filtered:=True;
  selI073.Refresh;
  selI073.First;
  Screen.Cursor:=crDefault;
end;
*)
procedure TA008FOperatoriDtm1.AggiornaI073;
{Aggiornamento iniziale delle funzioni disponibili}
var i:Integer;
  procedure AggiornaFunzione(Funzione:TFunzioniDisponibili);
  //Aggiorna e aggiunge le funzioni disponibili
  begin
    if Funzione.A = 'XXXX' then
      exit;
    if (Funzione.A <> 'IRIS') and (Funzione.A <> 'FUNWEB') and (Funzione.A <> Parametri.Applicazione) then
      exit;

    with updI073Agg do
    try
      SetVariable('TAG',Funzione.T);
      SetVariable('APPLICAZIONE',IfThen(Funzione.A = 'IRIS',Parametri.Applicazione,Funzione.A));
      SetVariable('FUNZIONE',Funzione.F);
      SetVariable('GRUPPO',Funzione.G);
      SetVariable('DESCRIZIONE',Funzione.N);
      Execute;
    except
    end;

    with insI073Agg do
    try
      SetVariable('TAG',Funzione.T);
      SetVariable('APPLICAZIONE',IfThen(Funzione.A = 'IRIS',Parametri.Applicazione,Funzione.A));
      SetVariable('FUNZIONE',Funzione.F);
      SetVariable('GRUPPO',Funzione.G);
      SetVariable('DESCRIZIONE',Funzione.N);
      Execute;
    except
    end;
  end;
begin
  Screen.Cursor:=crHourGlass;
  try
    EliminaFunzioniInesistenti;
    for i:=1 to High(FunzioniDisponibili) do
      AggiornaFunzione(FunzioniDisponibili[i]);
  finally
    SessioneOracle.Commit;
    Screen.Cursor:=crDefault;
  end;
end;

(*
  procedure TA008FOperatoriDtM1.AggiornaI095_I096(Azienda:String = '');
  {Aggiornamento iniziale delle funzioni disponibili}
  var i:integer;
      TempSelI090:TOracleDataSet;
      TempModuloIterAutorizzativi:Boolean;
  begin
    TempModuloIterAutorizzativi:=ModuloIterAutorizzativi;
    ModuloIterAutorizzativi:=True;
    TempSelI090:=TOracleDataSet.Create(Self);
    TempSelI090.Session:=SessioneOracle;
    TempSelI090.SQL.Add('SELECT I090.*');
    TempSelI090.SQL.Add('FROM MONDOEDP.I090_ENTI I090');
    if Azienda <> '' then
      TempSelI090.SQL.Add('WHERE I090.AZIENDA = ''' + Azienda + '''');
    TempSelI090.SQL.Add('ORDER BY AZIENDA');
    TempSelI090.Open;
    TempSelI090.First;
    selI095.Filtered:=False;
    while not TempSelI090.Eof do
    begin
      //selI095
      OpenSelI095(TempSelI090.FieldByName('AZIENDA').AsString);
      for i:=Low(A000IterAutorizzativi) to High(A000IterAutorizzativi) do
        if VarToStr(selI095.Lookup('ITER',A000IterAutorizzativi[i].Cod,'ITER')) = '' then
        begin
          selI095.Insert;
          selI095.FieldByName('AZIENDA').AsString:=TempSelI090.FieldByName('AZIENDA').AsString;
          selI095.FieldByName('ITER').AsString:=A000IterAutorizzativi[i].Cod;
          selI095.FieldByName('COD_ITER').AsString:='DEFAULT';
          selI095.Post;
        end;
      SessioneOracle.ApplyUpdates([selI095],True);
      if Azienda <> '' then
        Break;
      TempSelI090.Next;
    end;
    selI095.Filtered:=True;
    selI095.Refresh;
    //selI096
    with TOracleQuery.Create(Self) do
    begin
      Session:=SessioneOracle;
      SQL.Add('INSERT INTO MONDOEDP.I096_LIVELLI_ITER_AUT ');
      SQL.Add('(AZIENDA, ITER, COD_ITER, LIVELLO, OBBLIGATORIO, AVVISO, VALORI_POSSIBILI, DATI_MODIFICABILI, INVIO_EMAIL) ');
      SQL.Add('SELECT AZIENDA,ITER,COD_ITER,1,''S'',''N'',''S,N'',''N'',''N''');
      SQL.Add('FROM(SELECT AZIENDA,ITER,COD_ITER FROM MONDOEDP.I095_ITER_AUT MINUS ');
      SQL.Add('SELECT AZIENDA,ITER,COD_ITER FROM MONDOEDP.I096_LIVELLI_ITER_AUT)');
      Execute;
      Free;
    end;
    SessioneOracle.Commit;
    selI096.Refresh;
    TempSelI090.Close;
    FreeAndNil(TempSelI090);
    ModuloIterAutorizzativi:=TempModuloIterAutorizzativi;
  end;
*)

procedure TA008FOperatoriDtM1.CreaFiltroFunzioni(Azienda,Profilo:String);
{Lettura e aggiornamento delle funzioni disponibili}
var i:Integer;
  procedure GetFunzione(Funzione:TFunzioniDisponibili);
  //Aggiorna e aggiunge le funzioni disponibili
  begin
    if Funzione.A = 'XXXX' then
      exit;
    if (Funzione.A <> 'IRIS') and (Funzione.A <> 'FUNWEB') and (Funzione.A <> Parametri.Applicazione) then
      exit;
    with selI073 do
      if SearchRecord('AZIENDA;PROFILO;TAG',VarArrayOf([Azienda,Profilo,Funzione.T]),[srFromBeginning]) then
      begin
        if (FieldByName('FUNZIONE').AsString <> Funzione.F) or
           (FieldByName('GRUPPO').AsString <> Funzione.G) or
           (FieldByName('DESCRIZIONE').AsString <> Funzione.N) then
        begin
          Edit;
          FieldByName('FUNZIONE').AsString:=Funzione.F;
          FieldByName('GRUPPO').AsString:=Funzione.G;
          FieldByName('DESCRIZIONE').AsString:=Funzione.N;
          Post;
        end;
      end
      else //if Funzione.WEB = '' then
           //Caratto 10/04/2013 le funzioni specifiche di web non le inserisce.
           //Se fossero già presenti (inserite da webpj) le gestisce in update
      begin
        Append;
        FieldByName('AZIENDA').AsString:=Azienda;
        FieldByName('PROFILO').AsString:=Profilo;
        //if Funzione.G = 'Funzioni WEB' then
        if Funzione.A = 'FUNWEB' then
          FieldByName('APPLICAZIONE').AsString:=Funzione.A
        else
          FieldByName('APPLICAZIONE').AsString:=Parametri.Applicazione;
        FieldByName('TAG').AsInteger:=Funzione.T;
        FieldByName('FUNZIONE').AsString:=Funzione.F;
        FieldByName('GRUPPO').AsString:=Funzione.G;
        FieldByName('DESCRIZIONE').AsString:=Funzione.N;
        FieldByName('INIBIZIONE').AsString:='N';
        //Gestisco l'eccezione nel caso in cui il profilo esistà gia in un altro applicativo
        try
          Post;
        except
          Cancel;
        end;
      end;
  end;
begin
  with selI073 do
  begin
    DisableControls;
    ReadOnly:=False;
    BeforeInsert:=nil;
    BeforeDelete:=nil;
    CommitOnPost:=True;
    try
      for i:=1 to High(FunzioniDisponibili) do
        GetFunzione(FunzioniDisponibili[i]);
    finally
      SessioneOracle.Commit;
      EnableControls;
      ReadOnly:=True;
      BeforeInsert:=selI073BeforeDeleteInsert;
      BeforeDelete:=selI073BeforeDeleteInsert;
      Filtered:=False;
      Filtered:=True;
      CommitOnPost:=False;
    end;
  end;
end;

(*
procedure TA008FOperatoriDtM1.EliminaFunzioniInesistenti;
//Elimina le funzioni registrate ma non più disponibili
var i:Integer;
    Esiste:Boolean;
begin
  with selI073 do
  try
    BeforeDelete:=nil;
    Filtered:=False;
    First;
    while not Eof do
    begin
      Esiste:=False;
      for i:=1 to High(FunzioniDisponibili) do
        if (FunzioniDisponibili[i].T = FieldByName('TAG').AsInteger) and L021VerificaApplicazione(Parametri.Applicazione,i) then
        begin
          Esiste:=True;
          Break;
        end;
      if Esiste then
        Next
      else
      try
        Delete;
      except
        Next;
      end;
    end;
  finally
    Filtered:=True;
    BeforeDelete:=selI073BeforeDeleteInsert;
  end;
  SessioneOracle.Commit;
end;
*)
procedure TA008FOperatoriDtm1.EliminaFunzioniInesistenti;
//Elimina le funzioni registrate ma non più disponibili
var i:Integer;
    Esiste:Boolean;
begin
  with selI073Agg do
  try
    Open;
    while not Eof do
    begin
      Esiste:=False;
      for i:=1 to High(FunzioniDisponibili) do
        if (FunzioniDisponibili[i].T = FieldByName('TAG').AsInteger) and L021VerificaApplicazione(Parametri.Applicazione,i) then
        begin
          Esiste:=True;
          Break;
        end;
      if Esiste then
        Next
      else
      begin
        with delI073Agg do
        try
          SetVariable('TAG',FieldByName('TAG').AsInteger);
          SetVariable('APPLICAZIONE',FieldByName('APPLICAZIONE').AsString);
          Execute;
        except
        end;
        Next;
      end;
    end;
  finally
    Close;
    SessioneOracle.Commit;
  end;
end;

procedure TA008FOperatoriDtM1.A008FOperatoriDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  CdFnz.Free;
  CdFnzWeb.Free;
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(A181MW);
  FreeAndNil(A185MW);
end;

procedure TA008FOperatoriDtM1.selI073BeforeDeleteInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA008FOperatoriDtM1.selI073BeforePost(DataSet: TDataSet);
begin
  // controllo validità dati
  if (selI073.FieldByName('ACCESSO_BROWSE').AsString <> 'S') and
     (selI073.FieldByName('ACCESSO_BROWSE').AsString <> 'N') then
    raise Exception.Create('Il valore del dato Accesso Browse deve essere S oppure N');

  if selI073.FieldByName('RIGHE_PAGINA').AsInteger < -1 then
    raise Exception.Create('Il valore indicato per il dato Righe Pagina non è valido');

  if selI073.FieldByName('RIGHE_PAGINA').AsInteger > 9999 then
    raise Exception.Create('Il valore indicato per il dato Righe Pagina non è valido');

  if (selI073.FieldByName('GRUPPO').AsString = 'Funzioni WEB')
  and (selI073.FieldByName('INIBIZIONE').OldValue <> selI073.FieldByName('INIBIZIONE').Value) then
  begin
    updI073.SetVariable('INIBIZIONE',selI073.FieldByName('INIBIZIONE').AsString);
    updI073.SetVariable('AZIENDA',selI073.FieldByName('AZIENDA').AsString);
    updI073.SetVariable('PROFILO',selI073.FieldByName('PROFILO').AsString);
    updI073.SetVariable('GRUPPO',selI073.FieldByName('GRUPPO').AsString);
    updI073.SetVariable('FUNZIONE',selI073.FieldByName('FUNZIONE').AsString);
    updI073.SetVariable('APPLICAZIONE',selI073.FieldByName('APPLICAZIONE').AsString);
    updI073.Execute;
  end;
end;

procedure TA008FOperatoriDtM1.selI073INIBIZIONEValidate(Sender: TField);
begin
  if (Sender.AsString <> 'S') and (Sender.AsString <> 'N') and (Sender.AsString <> 'R') then
    raise Exception.Create('Valori ammessi: S/N/R');
end;

procedure TA008FOperatoriDtM1.selI073NewRecord(DataSet: TDataSet);
begin
  selI073.FieldByName('AZIENDA').AsString:=AziendaCorrente;//A008FProfili.cmbSelAzin.Text;
  selI073.FieldByName('ACCESSO_BROWSE').AsString:='S';
  selI073.FieldByName('RIGHE_PAGINA').AsInteger:=0;
end;

procedure TA008FOperatoriDtM1.QI070FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=True;
  if Parametri.Operatore <> 'MONDOEDP' then
    Accept:=DataSet.FieldByName('UTENTE').AsString <> 'MONDOEDP';
end;

procedure TA008FOperatoriDtM1.selI090AfterScroll(DataSet: TDataSet);
begin
  //Apertura del database indicato dall'Azienda
  if DbIris008B.Connected and
     (UpperCase(DbIris008B.LogonUserName) = UpperCase(selI090.FieldByName('UTENTE').AsString)) and
     ((A008FLoginDipendenti = nil) or
      (A008FLoginDipendenti <> nil) and (A008FLoginDipendenti.DBGridDettaglio.Columns.Items[3].PickList.Count > 0)) then
    exit;
  Screen.Cursor:=crHourGlass;
  CambioDataBase;
  AziendaCorrente:=selI090.FieldByName('AZIENDA').AsString;
  AggiornaFiltroProfili;
  if A008FLoginDipendenti <> nil then
    with A008FLoginDipendenti do
    try
      QI060.Close;
      QI060.SetVariable('AZIENDA',selI090.FieldByName('AZIENDA').AsString);
      QI060.Open;
      A008FLoginDipendenti.DButton.DataSet:=QI060;
      CaricaCmbNomiProfili;
      cmbPermessi.Items.Clear;
      cmbFiltroAnagrafe.Items.Clear;
      cmbFiltroFunzioni.Items.Clear;
      cmbIterAutor.Items.Clear;
      cmbFiltroDizionario.Items.Clear;
      DBGridDettaglio.Columns.Items[3].PickList.BeginUpdate;
      DBGridDettaglio.Columns.Items[3].PickList.Clear;
      selI071.First;
      while not selI071.Eof do
      begin
        DBGridDettaglio.Columns.Items[3].PickList.Add(selI071.FieldByName('PROFILO').AsString);
        cmbPermessi.Items.Add(selI071.FieldByName('PROFILO').AsString);
        selI071.Next;
      end;
      DBGridDettaglio.Columns.Items[3].PickList.EndUpdate;
      DBGridDettaglio.Columns.Items[4].PickList.BeginUpdate;
      DBGridDettaglio.Columns.Items[4].PickList.Clear;
      selI072Dist.First;
      selI072Dist.AfterScroll:=nil;
      try
        while not selI072Dist.Eof do
        begin
          DBGridDettaglio.Columns.Items[4].PickList.Add(selI072Dist.FieldByName('PROFILO').AsString);
          cmbFiltroAnagrafe.Items.Add(selI072Dist.FieldByName('PROFILO').AsString);
          selI072Dist.Next;
        end;
      finally
        selI072Dist.AfterScroll:=selI072DistAfterScroll;
        selI072Dist.First;
      end;
      DBGridDettaglio.Columns.Items[4].PickList.EndUpdate;
      DBGridDettaglio.Columns.Items[5].PickList.BeginUpdate;
      DBGridDettaglio.Columns.Items[5].PickList.Clear;
      selI073Dist.First;
      selI073Dist.AfterScroll:=nil;
      try
        while not selI073Dist.Eof do
        begin
          DBGridDettaglio.Columns.Items[5].PickList.Add(selI073Dist.FieldByName('PROFILO').AsString);
          cmbFiltroFunzioni.Items.Add(selI073Dist.FieldByName('PROFILO').AsString);
          selI073Dist.Next;
        end;
      finally
        selI073Dist.AfterScroll:=selI073DistAfterScroll;
        selI073Dist.First;
      end;
      DBGridDettaglio.Columns.Items[5].PickList.EndUpdate;
      DBGridDettaglio.Columns.Items[6].PickList.BeginUpdate;
      DBGridDettaglio.Columns.Items[6].PickList.Clear;
      selI075Dist.First;
      selI075Dist.AfterScroll:=nil;
      try
        while not selI075Dist.Eof do
        begin
          DBGridDettaglio.Columns.Items[6].PickList.Add(selI075Dist.FieldByName('PROFILO').AsString);
          cmbIterAutor.Items.Add(selI075Dist.FieldByName('PROFILO').AsString);
          selI075Dist.Next;
        end;
      finally
        selI075Dist.AfterScroll:=selI075DistAfterScroll;
        selI075Dist.First;
      end;
      DBGridDettaglio.Columns.Items[6].PickList.EndUpdate;
      DBGridDettaglio.Columns.Items[7].PickList.BeginUpdate;
      DBGridDettaglio.Columns.Items[7].PickList.Clear;
      selI074Dist.First;
      selI074Dist.AfterScroll:=nil;
      try
        while not selI074Dist.Eof do
        begin
          DBGridDettaglio.Columns.Items[7].PickList.Add(selI074Dist.FieldByName('PROFILO').AsString);
          cmbFiltroDizionario.Items.Add(selI074Dist.FieldByName('PROFILO').AsString);
          selI074Dist.Next;
        end;
      finally
        selI074Dist.AfterScroll:=selI074DistAfterScroll;
        selI074Dist.First;
      end;
      DBGridDettaglio.Columns.Items[7].PickList.EndUpdate;
      spvAzienda:=selI090.FieldByName('AZIENDA').AsString;

      if spvAzienda = A008Flogindipendenti.dcmbAzienda.Text then
        A008FLoginDipendenti.OldSel:=spvAzienda;
      QI090.SearchRecord('AZIENDA',selI090.FieldByName('AZIENDA').AsString,[srFromBeginning]);
    except
    end;
  Screen.Cursor:=crDefault;
end;

procedure TA008FOperatoriDtM1.selI093AfterOpen(DataSet: TDataSet);
begin
  A181MW.selI093AfterOpen;
  //ModuloIterAutorizzativi:=A000ModuloAbilitato(SessioneOracle,'ITER_AUTORIZZATIVI',QI090.FieldByName('AZIENDA').AsString);
end;

(* Massimo 14/12/2012 gestione A181UAziendeMW
procedure TA008FOperatoriDtM1.AbilitazioniColonneI096;
var AbilitaI096:Boolean;
begin
  AbilitaI096:=A181MW.ModuloIterAutorizzativi or (selI096.FieldByName('ITER').AsString = ITER_CARTELLINO);
  selI096.FieldByName('LIVELLO').ReadOnly:=not AbilitaI096;
  selI096.FieldByName('DESC_LIVELLO').ReadOnly:=not AbilitaI096;
  selI096.FieldByName('FASE').ReadOnly:=not AbilitaI096;
  selI096.FieldByName('OBBLIGATORIO').Visible:=AbilitaI096;
  selI096.FieldByName('AVVISO').Visible:=AbilitaI096;
  selI096.FieldByName('VALORI_POSSIBILI').Visible:=AbilitaI096;
  selI096.FieldByName('AUTORIZZ_INTERMEDIA').Visible:=AbilitaI096;
  selI096.FieldByName('SCRIPT_AUTORIZZ').Visible:=AbilitaI096;
  selI096.FieldByName('CONDIZ_AUTORIZZ_AUTOMATICA').Visible:=AbilitaI096;
  NascondiDBGridColumns(A008FAziende.dgrdselI096);
end;
*)

procedure TA008FOperatoriDtM1.selI093AfterScroll(DataSet: TDataSet);
begin
  (*   Massimo 14/12/2012 gestione A181UAziendeMW
  selI095.Filtered:=False;
  selI095.Filter:='ITER = ''' + selI093.FieldByName('ITER').AsString + '''';
  selI095.Filtered:=True;
  selI094.Filtered:=False;
  selI094.Filter:='ITER = ''' + selI093.FieldByName('ITER').AsString + '''';
  selI094.Filtered:=True;
  selI093.FieldByName('REVOCABILE').ReadOnly:=selI093.FieldByName('ITER').AsString <> ITER_GIUSTIF;
  *)
  A181MW.selI093AfterScroll;
  NascondiDBGridColumns(A008FAziende.dgrdselI096);
  (* Massimo 14/12/2012 gestione A181UAziendeMW
  A008FAziende.dgrdselI096.Columns[R180GetColonnaDBGrid(A008FAziende.dgrdselI096,'AUTORIZZ_INTERMEDIA')].Visible:=selI095.FieldByName('ITER').AsString = ITER_GIUSTIF;
  A008FAziende.dgrdselI096.Columns[R180GetColonnaDBGrid(A008FAziende.dgrdselI096,'FASE')].Visible:=R180In(selI095.FieldByName('ITER').AsString,[ITER_MISSIONI, ITER_STRMESE]);
  AbilitazioniColonneI096;
  *)
end;

procedure TA008FOperatoriDtM1.selI093ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  case Action of
  'I':begin
        A181MW.RegistraLogSecondario.SettaProprieta('I','I093_BASE_ITER_AUT','A008',Sender,True);
        A181MW.RegistraLogSecondario.RegistraOperazione;
      end;
  'U':begin
        A181MW.RegistraLogSecondario.SettaProprieta('M','I093_BASE_ITER_AUT','A008',Sender,True);
        A181MW.RegistraLogSecondario.RegistraOperazione;
      end;
  'D':begin
        A181MW.RegistraLogSecondario.SettaProprieta('C','I093_BASE_ITER_AUT','A008',Sender,True);
        A181MW.RegistraLogSecondario.RegistraOperazione;
      end;
  end;
end;

procedure TA008FOperatoriDtM1.selI093BeforeDelete(DataSet: TDataSet);
begin
  A181MW.selI093BeforeDelete;
  //Abort;
end;

procedure TA008FOperatoriDtM1.selI093BeforeInsert(DataSet: TDataSet);
begin
  (* Massimo 14/12/2012 gestione A181UAziendeMW
    if not I093EnabledInsert then
       Abort;
  *)
  A181MW.selI093BeforeInsert;
end;

procedure TA008FOperatoriDtM1.selI093BeforePost(DataSet: TDataSet);
begin
  // Massimo 14/12/2012 gestione A181UAziendeMW
  A181MW.selI093BeforePost;
end;

procedure TA008FOperatoriDtM1.selI093CalcFields(DataSet: TDataSet);
begin
  (* Massimo 14/12/2012 gestione A181UAziendeMW
    selI093.FieldByName('D_ITER').AsString:=Decod_Iter(selI093.FieldByName('ITER').AsString);
    selI093.FieldByName('C_CHKDATI_ITER_AUT').AsString:='(vuoto)';
    if selI093.FieldByName('CHKDATI_ITER_AUT').AsInteger = 1 then
      selI093.FieldByName('C_CHKDATI_ITER_AUT').AsString:='(1 elemento)'
    else if selI093.FieldByName('CHKDATI_ITER_AUT').AsInteger > 0 then
      selI093.FieldByName('C_CHKDATI_ITER_AUT').AsString:=Format('(%d elementi)',[selI093.FieldByName('CHKDATI_ITER_AUT').AsInteger]);
  *)
  A181MW.selI093CalcFields;
end;


procedure TA008FOperatoriDtM1._selI094BeforePost(DataSet: TDataSet);
begin
  (* Massimo 17/12/2012 gestione A181UAziendeMW
  if selI094.FieldByName('RIEPILOGO').IsNull then
    Raise Exception.Create('Impossibile inserire NULL nel campo riepilogo.');
  if (selI094.FieldByName('STATO').AsString <> 'C') and
     (selI094.FieldByName('STATO').AsString <> 'A') then
    Raise Exception.Create('I valori permessi nel campo "Stato" sono C o A.');
  *)
end;

procedure TA008FOperatoriDtM1._selI094NewRecord(DataSet: TDataSet);
begin
  (* Massimo 17/12/2012 gestione A181UAziendeMW
  selI094.FieldByName('AZIENDA').AsString:=selI093.FieldByName('AZIENDA').AsString;
  selI094.FieldByName('ITER').AsString:=selI093.FieldByName('ITER').AsString;
  *)
end;


procedure TA008FOperatoriDtM1.selI095AfterOpen(DataSet: TDataSet);
begin
  (*  Massimo 14/12/2012 gestione A181UAziendeMW
  selI095.FieldByName('COD_ITER').ReadOnly:=not A181MW.ModuloIterAutorizzativi;
  selI095.FieldByName('FILTRO_RICHIESTA').Visible:=A181MW.ModuloIterAutorizzativi;
  selI095.FieldByName('MAX_LIV_AUTORIZZ_AUTOMATICA').Visible:=A181MW.ModuloIterAutorizzativi;
  *)
  A181MW.selI095AfterOpen;
  with A008FAziende do
  begin
    NascondiDBGridColumns(dgrdSelI095);
    if selI095.FieldByName('COD_ITER').AsString = 'DEFAULT' then
      dgrdSelI095.Options:=dgrdSelI095.Options - [dgConfirmDelete]
    else
      dgrdSelI095.Options:=dgrdSelI095.Options + [dgConfirmDelete];
  end;
end;

procedure TA008FOperatoriDtM1.selI095AfterScroll(DataSet: TDataSet);
begin
  (*  Massimo 14/12/2012 gestione A181UAziendeMW
  selI097.Filtered:=False;
  selI097.Filter:='(ITER = ''' + selI095.FieldByName('ITER').AsString + ''') AND ' +
                  '(COD_ITER = ''' + selI095.FieldByName('COD_ITER').AsString + ''')';
  selI097.Filtered:=True;
  selI096.Filtered:=False;
  selI096.Filter:=A181MW.selI097.Filter;
  selI096.Filtered:=True;
  *)
  A181MW.selI095AfterScroll;
end;

procedure TA008FOperatoriDtM1.selI095ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  case Action of
  'I':begin
        A181MW.RegistraLogSecondario.SettaProprieta('I','I095_ITER_AUT','A008',Sender,True);
        A181MW.RegistraLogSecondario.RegistraOperazione;
      end;
  'U':begin
        A181MW.RegistraLogSecondario.SettaProprieta('M','I095_ITER_AUT','A008',Sender,True);
        A181MW.RegistraLogSecondario.RegistraOperazione;
      end;
  'D':begin
        A181MW.RegistraLogSecondario.SettaProprieta('C','I095_ITER_AUT','A008',Sender,True);
        A181MW.RegistraLogSecondario.RegistraOperazione;
      end;
  end;
end;

procedure TA008FOperatoriDtM1.selI095BeforeDelete(DataSet: TDataSet);
begin
  { Massimo 14/12/2012 gestione A181UAziendeMW
  if not A181MW.ModuloIterAutorizzativi then
    Abort;
  //Controlli per delete
  with TOracleDataSet.Create(Self) do
  begin
    Session:=SessioneOracle;
    SQL.Add('SELECT COUNT(*) AS NREC');
    SQL.Add('  FROM MONDOEDP.I075_ITER_AUTORIZZATIVI I075, MONDOEDP.I096_LIVELLI_ITER_AUT I096');
    SQL.Add(' WHERE I096.AZIENDA = ''' + selI095.FieldByName('AZIENDA').AsString + '''');
    SQL.Add('   AND I096.ITER = ''' + selI095.FieldByName('ITER').AsString + '''');
    SQL.Add('   AND I096.COD_ITER = ''' + selI095.FieldByName('COD_ITER').AsString + '''');
    SQL.Add('   AND NVL(I075.ACCESSO,''N'') <> ''N''');
    SQL.Add('   AND I096.AZIENDA = I075.AZIENDA(+)');
    SQL.Add('   AND I096.ITER = I075.ITER(+)');
    SQL.Add('   AND I096.COD_ITER = I075.COD_ITER(+)');
    SQL.Add('   AND I096.LIVELLO = I075.LIVELLO(+)');
    Open;
    if FieldByName('NREC').AsInteger > 0 then
    begin
      Close;
      Free;
      raise Exception.Create('Impossibile cancellare l''Iter "' + selI095.FieldByName('AZIENDA').AsString +
                             ', ' + selI095.FieldByName('ITER').AsString +
                             ', ' + selI095.FieldByName('COD_ITER').AsString + '" è utilizzato da un profilo dipendente.');
    end;

    Close;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) AS NREC FROM ' + QI090.FieldByName('UTENTE').AsString + '.T850_ITER_RICHIESTE T850');
    SQL.Add(' WHERE T850.ITER = ''' + selI095.FieldByName('ITER').AsString + '''');
    SQL.Add('  AND T850.COD_ITER = ''' + selI095.FieldByName('COD_ITER').AsString + '''');
    Open;
    if fieldByName('NREC').AsInteger > 0 then
    begin
      Close;
      Free;
      raise Exception.Create('Impossibile cancellare l''Iter "' + Parametri.Username +
                             ', ' + selI095.FieldByName('ITER').AsString +
                             ', ' + selI095.FieldByName('COD_ITER').AsString + '" è utilizzato da un profilo dipendente.');
    end;
    Close;
    Free;
  end;
  }
  A181MW.selI095BeforeDelete;
end;

procedure TA008FOperatoriDtM1.selI095BeforeInsert(DataSet: TDataSet);
begin
  (* Massimo 14/12/2012 gestione A181UAziendeMW
  if not A181MW.ModuloIterAutorizzativi then
    Abort;
  *)
  A181MW.selI095BeforeInsert;
end;

procedure TA008FOperatoriDtM1.selI095BeforePost(DataSet: TDataSet);
begin
  (* Massimo 14/12/2012 gestione A181UAziendeMW
  if selI095.FieldByName('CONDIZ_AUTORIZZ_AUTOMATICA').IsNull then
    selI095.FieldByName('MAX_LIV_AUTORIZZ_AUTOMATICA').AsInteger:=-1;
  *)
  A181MW.selI095BeforePost;
end;

procedure TA008FOperatoriDtM1.selI095CalcFields(DataSet: TDataSet);
begin
  (* Massimo 14/12/2012 gestione A181UAziendeMW
  selI095.FieldByName('C_VALIDITA_ITER_AUT').AsString:='(vuoto)';
  if selI095.FieldByName('VALIDITA_ITER_AUT').AsInteger = 1 then
    selI095.FieldByName('C_VALIDITA_ITER_AUT').AsString:='(1 elemento)'
  else if selI095.FieldByName('VALIDITA_ITER_AUT').AsInteger > 0 then
    selI095.FieldByName('C_VALIDITA_ITER_AUT').AsString:=Format('(%d elementi)',[selI095.FieldByName('VALIDITA_ITER_AUT').AsInteger]);
  *)
  A181MW.selI095CalcFields;
end;

procedure TA008FOperatoriDtM1.selI095NewRecord(DataSet: TDataSet);
begin
  (* Massimo 14/12/2012 gestione A181UAziendeMW
  selI095.FieldByName('AZIENDA').asString:=selI093.FieldByName('AZIENDA').asString;
  selI095.FieldByName('ITER').asString:=selI093.FieldByName('ITER').asString;
  *)
  A181MW.selI095NewRecord;
end;

procedure TA008FOperatoriDtM1.selI096ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  case Action of
  'I':begin
        A181MW.RegistraLogSecondario.SettaProprieta('I','I096_LIVELLI_ITER_AUT','A008',Sender,True);
        A181MW.RegistraLogSecondario.RegistraOperazione;
      end;
  'U':begin
        A181MW.RegistraLogSecondario.SettaProprieta('M','I096_LIVELLI_ITER_AUT','A008',Sender,True);
        A181MW.RegistraLogSecondario.RegistraOperazione;
      end;
  'D':begin
        A181MW.RegistraLogSecondario.SettaProprieta('C','I096_LIVELLI_ITER_AUT','A008',Sender,True);
        A181MW.RegistraLogSecondario.RegistraOperazione;
      end;
  end;
end;

procedure TA008FOperatoriDtM1.selI096BeforeDelete(DataSet: TDataSet);
begin
  {   Massimo 14/12/2012 gestione A181UAziendeMW
  if not A181MW.ModuloIterAutorizzativi then
    Abort;
  with TOracleDataSet.Create(Self) do
  begin
    Session:=SessioneOracle;
    SQL.Add('SELECT COUNT(*) AS NREC');
    SQL.Add('  FROM MONDOEDP.I075_ITER_AUTORIZZATIVI I075');
    SQL.Add(' WHERE I075.AZIENDA = ''' + selI096.FieldByName('AZIENDA').AsString + '''');
    SQL.Add('   AND I075.ITER = ''' + selI096.FieldByName('ITER').AsString + '''');
    SQL.Add('   AND I075.COD_ITER = ''' + selI096.FieldByName('COD_ITER').AsString + '''');
    SQL.Add('   AND I075.LIVELLO = ''' + selI096.FieldByName('LIVELLO').AsString + '''');
    SQL.Add('   AND I075.ACCESSO <> ''N''');
    Open;
    if fieldByName('NREC').AsInteger > 0 then
    begin
      Close;
      Free;
      raise Exception.Create('Impossibile cancellare l''Iter "' + selI096.FieldByName('AZIENDA').AsString +
                             ', ' + selI096.FieldByName('ITER').AsString +
                             ', ' + selI096.FieldByName('COD_ITER').AsString +
                             ', ' + selI096.FieldByName('LIVELLO').AsString + '" è utilizzato da un profilo dipendente.');
    end;
  end;
  if selI096.FieldByName('LIVELLO').AsInteger = 1 then
    Abort;
  }
  A181MW.selI096BeforeDelete;
end;

procedure TA008FOperatoriDtM1.selI096BeforeInsert(DataSet: TDataSet);
begin
  (*  Massimo 14/12/2012 gestione A181UAziendeMW
  if not A181MW.ModuloIterAutorizzativi then
    if selI096.FieldByName('ITER').AsString <> ITER_CARTELLINO then
      Raise Exception.Create('Impossibile inserire più di un livello per l''iter "' +
                             A181MW.Decod_Iter(selI096.FieldByName('ITER').AsString) +
                             '", se il modulo Iter Autorizzativi è disabilitato.')
    else if selI096.RecordCount >= 2 then
      Raise Exception.Create('Impossibile inserire più di due livelli per l''iter "' +
                             A181MW.Decod_Iter(selI096.FieldByName('ITER').AsString) +
                             '", se il modulo Iter Autorizzativi è disabilitato.');
  *)
  //selI096.FieldByName('LIVELLO').ReadOnly:=False;
  A181MW.selI096BeforeInsert;
end;

procedure TA008FOperatoriDtM1.selI096BeforePost(DataSet: TDataSet);
//var ValPossibili:TArrString;
//    i:Integer;
begin
  A181MW.selI096BeforePost;
  {  Massimo 14/12/2012 gestione A181UAziendeMW
  //Controlli campo OBBLIGATORIO I096
  if (selI096.FieldByName('OBBLIGATORIO').AsString = 'N') and selI096.FieldByName('VALORI_POSSIBILI').IsNull then
    selI096.FieldByName('VALORI_POSSIBILI').AsString:='S';
  if (selI096.FieldByName('OBBLIGATORIO').AsString = 'N') then
  begin
    selI096.FieldByName('AUTORIZZ_INTERMEDIA').Clear;
    selI096.FieldByName('CONDIZ_AUTORIZZ_AUTOMATICA').Clear;
  end;
  if selI096.FieldByName('OBBLIGATORIO').AsString = 'S' then
    selI096.FieldByName('AVVISO').AsString:='N';
  if not(R180CarattereDef(selI096.FieldByName('OBBLIGATORIO').AsString) in ['S','N']) then
    raise Exception.Create('I valori permessi nel campo "Obbligatorio" sono S o N.');
  if not(R180CarattereDef(selI096.FieldByName('DATI_MODIFICABILI').AsString) in ['S','N']) then
    raise Exception.Create('I valori permessi nel campo "Dati modificabili" sono S o N.');
  if (selI096.FieldByName('OBBLIGATORIO').AsString = 'N') and not(R180CarattereDef(selI096.FieldByName('AVVISO').AsString) in ['S','N']) then
    raise Exception.Create('I valori permessi nel campo "Avviso" sono S o N.');
  if selI096.FieldByName('AUTORIZZ_INTERMEDIA').IsNull and
     (selI096.FieldByName('VALORI_POSSIBILI').AsString <> 'S,N') and
     (selI096.FieldByName('VALORI_POSSIBILI').AsString <> 'N,S') and
     (selI096.FieldByName('VALORI_POSSIBILI').AsString <> 'S') and
     (selI096.FieldByName('VALORI_POSSIBILI').AsString <> 'N') then
    raise Exception.Create('Se "Autorizz. intermedia" è nulla, "Valori possibili" può contenere solo S o N.');
  ValPossibili:=R180SplittaArray(selI096.FieldByName('VALORI_POSSIBILI').AsString,',');
  for i:=Low(ValPossibili) to High(ValPossibili) do
    if Length(ValPossibili[i]) > 1 then
      raise Exception.Create(ValPossibili[i] + ': più lungo di un carattere.');
  SetLength(ValPossibili,0);
  if selI096.FieldByName('ITER').AsString = ITER_GIUSTIF then
  begin
    if (not selI096.FieldByName('AUTORIZZ_INTERMEDIA').IsNull) and
       ((selI096.FieldByName('AUTORIZZ_INTERMEDIA').AsString = 'N') or
        (selI096.FieldByName('AUTORIZZ_INTERMEDIA').AsString <> StringReplace(StringReplace(selI096.FieldByName('VALORI_POSSIBILI').AsString,',N','',[]),'N,','',[]))) then
      raise Exception.Create('Il valore di "Autorizz. intermedia" può essere solo ' + StringReplace(StringReplace(selI096.FieldByName('VALORI_POSSIBILI').AsString,',N','',[]),'N,','',[]));
  end
  else
    selI096.FieldByName('AUTORIZZ_INTERMEDIA').Clear;
  if (selI096.FieldByName('INVIO_EMAIL').AsString <> 'N') and (selI096.FieldByName('INVIO_EMAIL').AsString <> 'A') and
     (selI096.FieldByName('INVIO_EMAIL').AsString <> 'R') and (selI096.FieldByName('INVIO_EMAIL').AsString <> 'E') then
    raise Exception.Create('Valore "' + selI096.FieldByName('INVIO_EMAIL').AsString + '" non consentito.');
  }
end;

procedure TA008FOperatoriDtM1.selI096NewRecord(DataSet: TDataSet);
begin
  (* Massimo 14/12/2012 gestione A181UAziendeMW
  selI096.FieldByName('AZIENDA').AsString:=selI095.FieldByName('AZIENDA').AsString;
  selI096.FieldByName('ITER').AsString:=selI095.FieldByName('ITER').AsString;
  selI096.FieldByName('COD_ITER').AsString:=selI095.FieldByName('COD_ITER').AsString;
  selI096.FieldByName('LIVELLO').AsInteger:=1;
  selI096.FieldByName('OBBLIGATORIO').AsString:='S';
  selI096.FieldByName('AVVISO').AsString:='N';
  selI096.FieldByName('VALORI_POSSIBILI').AsString:='S,N';
  selI096.FieldByName('DATI_MODIFICABILI').AsString:='N';
  selI096.FieldByName('AUTORIZZ_INTERMEDIA').AsString:='';
  selI096.FieldByName('INVIO_EMAIL').AsString:='N';
  *)
  A181MW.selI096NewRecord;
end;

procedure TA008FOperatoriDtM1._selI097BeforePost(DataSet: TDataSet);
begin
  (* Massimo 14/12/2012 gestione A181UAziendeMW
  if (selI097.FieldByName('BLOCCANTE').AsString <> 'S') and
     (selI097.FieldByName('BLOCCANTE').AsString <> 'N') then
    raise Exception.Create('I valori permessi nel campo "bloccante" sono S o N.');
  *)
end;

procedure TA008FOperatoriDtM1._selI097NewRecord(DataSet: TDataSet);
begin
  (* Massimo 14/12/2012 gestione A181UAziendeMW
  selI097.FieldByName('AZIENDA').AsString:=selI095.FieldByName('AZIENDA').AsString;
  selI097.FieldByName('ITER').AsString:=selI095.FieldByName('ITER').AsString;
  selI097.FieldByName('COD_ITER').AsString:=selI095.FieldByName('COD_ITER').AsString;
  selI097.FieldByName('NUM_CONDIZ').AsInteger:=-1;
  *)
end;

procedure TA008FOperatoriDtM1.CambioDataBase;
begin
  //Apertura del database indicato dall'Azienda
  with DbIris008B do
    if (not Connected) or
       (UpperCase(LogonUserName) <> UpperCase(selI090.FieldByName('UTENTE').AsString)) then
    begin
      Logoff;
      LogonDataBase:=Parametri.Database;
      LogonUserName:=selI090.FieldByName('UTENTE').AsString;
      LogonPassword:=R180Decripta(selI090.FieldByName('PAROLACHIAVE').AsString,21041974);
      Logon;
      selaT030.Close;
      selaT030.Open;
      selDizionario.Close;
      selDizionario.Open;
      selT033.Close;
      selT033.Open;
      QCols.Close;
      QCols.Open;
    end;
end;

procedure TA008FOperatoriDtM1.QI060AfterDelete(DataSet: TDataSet);
begin
  try
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    SessioneOracle.Rollback;
  end;
end;

procedure TA008FOperatoriDtM1.QI060AfterOpen(DataSet: TDataSet);
begin
 if QI060.RecordCount = 0 then
   OpenI061;
end;

procedure TA008FOperatoriDtM1.QI060AfterScroll(DataSet: TDataSet);
var
  ColAttuale: Integer;
begin
  OpenI061;

  // modifica delegato_da.ini
  // imposta colonna "delegato da"
  // propone elenco dei nomi utenti diversi da quello selezionato
  ColAttuale:=10;
  A008FLoginDipendenti.DBGridDettaglio.Columns.Items[ColAttuale].PickList.BeginUpdate;
  A008FLoginDipendenti.DBGridDettaglio.Columns.Items[ColAttuale].PickList.Clear;
  selI060.Close;
  selI060.SetVariable('AZIENDA',Parametri.Azienda);
  selI060.SetVariable('NOME_UTENTE',QI060.FieldByName('NOME_UTENTE').AsString);
  selI060.Open;
  try
    while not selI060.Eof do
    begin
      A008FLoginDipendenti.DBGridDettaglio.Columns.Items[ColAttuale].PickList.Add(selI060.FieldByName('NOME_UTENTE').AsString);
      selI060.Next;
    end;
  finally
    selI060.First;
  end;
  A008FLoginDipendenti.DBGridDettaglio.Columns.Items[ColAttuale].PickList.EndUpdate;
  // modifica delegato_da.fine
end;

procedure TA008FOperatoriDtM1.OpenI061;
begin
  if Not QI060.Active then
    Exit;
  if VarToStr(selI061.GetVariable('AZIENDA')) <> QI060.FieldByName('AZIENDA').AsString then
  begin
    selI061.SetVariable('AZIENDA',QI060.FieldByName('AZIENDA').AsString);
    selI061.Close;
  end;
  if VarToStr(selI061.GetVariable('NOME_UTENTE')) <> QI060.FieldByName('NOME_UTENTE').AsString then
  begin
    selI061.SetVariable('NOME_UTENTE',QI060.FieldByName('NOME_UTENTE').AsString);
    selI061.Close;
  end;
  selI061.Open;
end;

procedure TA008FOperatoriDtM1.QI060BeforeDelete(DataSet: TDataSet);
begin
  delI061.SetVariable('AZIENDA',QI060.FieldByName('AZIENDA').AsString);
  delI061.SetVariable('NOME_UTENTE',QI060.FieldByName('NOME_UTENTE').AsString);
  delI061.Execute;
  RegistraLog.SettaProprieta('C','I060_LOGIN_DIPENDENTE',Copy(Name,1,4),QI060,True);
end;

procedure TA008FOperatoriDtM1.QI060BeforePost(DataSet: TDataSet);
begin
  if (not QI060.FieldByName('MATRICOLA').IsNull) and (VarToStr(selaT030.Lookup('MATRICOLA',QI060.FieldByName('MATRICOLA').AsString,'MATRICOLA')) = '') then
    raise Exception.Create('Matricola non esistente!');
  if ((DataSet.State = dsInsert) or
     (Dataset.FieldByName('PASSWORD').medpOldValue <> Dataset.FieldByName('PASSWORD').Value)) then
  begin
    if Length(Dataset.FieldByName('PASSWORD').AsString) < Parametri.LunghezzaPassword then
      if QI090.FieldByName('DOMINIO_DIP').IsNull or (Length(Dataset.FieldByName('PASSWORD').AsString) > 0) then
        raise Exception.Create(Format(A000MSG_A186_ERR_FMT_LUNG_PWD,[Parametri.LunghezzaPassword]));
    if Not A008FLoginDipendenti.ForzaCambioPsw then
      Dataset.FieldByName('DATA_PW').AsDateTime:=Trunc(R180SysDate(SessioneOracle));
  end;
  A008FLoginDipendenti.ForzaCambioPsw:=False;

  if QI060.State = dsInsert then
  begin
    selI061.FieldByName('AZIENDA').AsString:=QI060.FieldByName('AZIENDA').AsString;
    selI061.FieldByName('NOME_UTENTE').AsString:=QI060.FieldByName('NOME_UTENTE').AsString;
  end
  else if (QI060.State = dsEdit) and
          (QI060.FieldByName('NOME_UTENTE').AsString <> VarToStr(QI060.FieldByName('NOME_UTENTE').medpOldValue)) then
  begin
    UpdI061.SetVariable('NOME_UTENTENEW',QI060.FieldByName('NOME_UTENTE').AsString);
    UpdI061.SetVariable('NOME_UTENTEOLD',VarToStr(QI060.FieldByName('NOME_UTENTE').medpOldValue));
    UpdI061.SetVariable('AZIENDA',QI060.FieldByName('AZIENDA').AsString);
    UpdI061.Execute;
  end;  
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','I060_LOGIN_DIPENDENTE',Copy(Name,1,4),QI060,True);
    dsEdit:RegistraLog.SettaProprieta('M','I060_LOGIN_DIPENDENTE',Copy(Name,1,4),QI060,True);
  end;
end;

procedure TA008FOperatoriDtM1.QI060PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  ShowMessage(Format(A000MSG_ERR_FMT_REG_FALLITA,[E.Message]));
  Action:=daAbort;
end;

procedure TA008FOperatoriDtM1.QI060NewRecord(DataSet: TDataSet);
begin
  QI060.FieldByName('AZIENDA').AsString:=selI090.FieldByName('AZIENDA').AsString;
end;

procedure TA008FOperatoriDtM1.QI060CalcFields(DataSet: TDataSet);
begin
  if QI060.FieldByName('PASSWORD').IsNull then
    QI060.FieldByName('D_PASSWORD').AsString:='<No password>'
  else
    QI060.FieldByName('D_PASSWORD').AsString:=StringReplace(Format('%*s',[Length(QI060.FieldByName('PASSWORD').AsString),'*']),' ','*',[rfReplaceAll]);
  if not SolaLettura then
    QI060.FieldByName('C_PWD_DECRIPTATA').AsString:=R180Decripta(QI060.FieldByName('PASSWORD').AsString,30011945);
end;

procedure TA008FOperatoriDtM1.QI070CalcFields(DataSet: TDataSet);
begin
  QI070.FieldByName('SCADENZAPASSWD').AsDateTime:=R180AddMesi(QI070.FieldByName('DATA_PW').AsDateTime,Parametri.RegolePassword.MesiValidita);
  { Se l'operatore ha già effettuato il primo ingresso, e quidi è stata memorizzata la sysdate, comparirà
    la data di scadenza utente, altrimenti non comapare nulla (significa che l'operatore non ha ancora effettuato il
    primo ingresso ed il campo DATA_ACCESSO è vuoto) }
  try
  if not QI070.FieldByName('DATA_ACCESSO').IsNull then
    QI070.FieldByName('ScadenzaUtente').AsDateTime:=R180AddMesi(QI070.FieldByName('DATA_ACCESSO').AsDateTime,QI090.FieldByName('VALID_UTENTE').AsInteger);
  except
  end;
end;

procedure TA008FOperatoriDtM1.selI070AccessiBeforeDelete(
  DataSet: TDataSet);
begin
  showmessage('In questa sezione non è possibile eliminare record.');
  Abort;
end;

procedure TA008FOperatoriDtM1.selI070AccessiBeforeInsert(
  DataSet: TDataSet);
begin
  Abort;
end;

procedure TA008FOperatoriDtM1.selUser_TriggersBeforeDelete(
  DataSet: TDataSet);
begin
  showmessage('In questa sezione non è possibile eliminare record.');
  Abort;
end;

procedure TA008FOperatoriDtM1.selUser_TriggersBeforeInsert(
  DataSet: TDataSet);
begin
  Abort;
end;

procedure TA008FOperatoriDtM1.UpdI060AfterQuery(Sender: TOracleQuery);
begin
  RegistraLog.SettaProprieta('M','I060_LOGIN_DIPENDENTE',Copy(Name,1,4),nil,True);
  RegistraLog.InserisciDato('NOME_UTENTE',UpdI060.GetVariable('NOME_UTENTE'),'');
  RegistraLog.InserisciDato('PASSWORD','',UpdI060.GetVariable('PASSWORD_NEW'));
  RegistraLog.RegistraOperazione;
end;

procedure TA008FOperatoriDtM1.selI070AccessiBeforePost(DataSet: TDataSet);
begin
  if (selI070Accessi.FieldByName('ACCESSO_NEGATO').AsString <> 'S') and
     (selI070Accessi.FieldByName('ACCESSO_NEGATO').AsString <> 'N') then
  begin
    showmessage('Il campo accetta solo i valori S o N.');
    Abort;
  end;
end;

procedure TA008FOperatoriDtM1.selI071AfterOpen(DataSet: TDataSet);
begin
  TDateTimeField(selI071.FieldByName('WEB_CARTELLINI_DATAMIN')).EditMask:='!00/00/0000;1;_';
  TDateTimeField(selI071.FieldByName('WEB_CARTELLINI_DATAMIN')).DisplayFormat:='dd/mm/yyyy';
  TDateTimeField(selI071.FieldByName('WEB_CEDOLINI_DATAMIN')).EditMask:='!00/00/0000;1;_';
  TDateTimeField(selI071.FieldByName('WEB_CEDOLINI_DATAMIN')).DisplayFormat:='dd/mm/yyyy';
end;

procedure TA008FOperatoriDtM1.selI071BeforePost(DataSet: TDataSet);
begin
  selI071.FieldByName('WEB_CARTELLINI_DATAMIN').AsDateTime:=R180InizioMese(selI071.FieldByName('WEB_CARTELLINI_DATAMIN').AsDateTime);
  selI071.FieldByName('WEB_CEDOLINI_DATAMIN').AsDateTime:=R180InizioMese(selI071.FieldByName('WEB_CEDOLINI_DATAMIN').AsDateTime);
end;

procedure TA008FOperatoriDtM1.selI071FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=DataSet.FieldByName('AZIENDA').AsString = AziendaCorrente;
end;

procedure TA008FOperatoriDtM1.I060SettaFiltroI061;
var Filtro:String;
begin
  Filtro:='';
  if FiltroProfiliI061.Attivo then
  begin
    if FiltroProfiliI061.NomeProfilo <> '' then
      Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('NOME_PROFILO = ''%s''',[FiltroProfiliI061.NomeProfilo]);
    if FiltroProfiliI061.Permessi <> '' then
      Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('PERMESSI = ''%s''',[FiltroProfiliI061.Permessi]);
    if FiltroProfiliI061.FiltroAnagrafe <> '' then
      Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('FILTRO_ANAGRAFE = ''%s''',[FiltroProfiliI061.FiltroAnagrafe]);
    if FiltroProfiliI061.FiltroFunzioni <> ''then
      Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('FILTRO_FUNZIONI = ''%s''',[FiltroProfiliI061.FiltroFunzioni]);
    if FiltroProfiliI061.IterAutorizzativi <> ''then
      Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('ITER_AUTORIZZATIVI = ''%s''',[FiltroProfiliI061.IterAutorizzativi]);
    if FiltroProfiliI061.FiltroDizionario <> ''then
      Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('FILTRO_DIZIONARIO = ''%s''',[FiltroProfiliI061.FiltroDizionario]);
    if Filtro <> '' then
      Filtro:=Format('and exists (select ''X'' from MONDOEDP.I061_PROFILI_DIPENDENTE I061 where I061.NOME_UTENTE = I060.NOME_UTENTE and I061.AZIENDA = I060.AZIENDA and %s)',[Filtro]);
  end;

  QI060.SetVariable('FILTRO_I061',Filtro);
  QI060.Close;
  QI060.Open;
end;

procedure TA008FOperatoriDtM1.QI060FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  //Gestire il filtro sulla griglia
  try
    if (A008FLoginDipendenti = nil) or
       (A008FLoginDipendenti.C600frmSelAnagrafe.C600SelAnagrafe = nil) or
       (not A008FLoginDipendenti.C600frmSelAnagrafe.C600SelAnagrafe.Active) then
      Accept:=False
    else
      Accept:=QI060.FieldByName('MATRICOLA').IsNull or (VarToStr(A008FLoginDipendenti.C600frmSelAnagrafe.C600SelAnagrafe.Lookup('MATRICOLA',QI060.FieldByName('MATRICOLA').AsString,'MATRICOLA')) <> '');
  except
    Accept:=False;
  end;
end;

end.

