unit B007UManipolazioneDatiMW;

interface

uses
  System.SysUtils, System.Classes, A000UInterfaccia, R005UDataModuleMW, USelI010,
  System.Variants, A000USessione, Data.DB, OracleData, Datasnap.DBClient, A000UMessaggi,
  StrUtils, Oracle, C006UStoriaDati, C180FunzioniGenerali, R600,Provider, Math, Cestino,
  A000UCostanti, A023UAllTimbMW, C700USelezioneAnagrafe;

type
  TTempoCancellazione = record
    DaDataMese  :TDateTime;
    ADataMese   :TDateTime;
    MeseOk      :Boolean;
    DaMese      :Integer;
    AMese       :Integer;
    DaAnMe      :Integer;
    AAnMe       :Integer;
    DaAnno      :Integer;
    AAnno       :Integer;
    AnnoOk      :Boolean;
  end;

  TTabelle = record
    Nome,Desc:String;
    Peri: Char;
    Campi:String;
    Indiv,Dipe,Log:Boolean;
  end;

  TPreparazioneStoricizzazione = record
    NomeTabella: String;
    VOld,VNew: String;
    Sql: String;
  end;

  TParametriStoricizzazione = record
    bStorico: boolean;
    DataDa, DataA: TDateTime;
    iPeriodo: Integer;
    bStoriciSuccessivi: Boolean;
    Dato,DescDato: String;
    PreparazioneStoricizzazione: TPreparazioneStoricizzazione;
  end;

  TElencoValoriAggDati = class
  public
    lstValoreEsistente: TStringList;
    lstNuovoValore: TStringList;
    constructor create;
    destructor destroy; override;
  end;

  TDatiAgg = record
    SelezioneAnagrafe: String;
    Dal: TDateTime;
    Al: TDateTime;
  end;

  TB007FManipolazioneDatiMW = class(TR005FDataModuleMW)
    selSQL: TOracleDataSet;
    cdsValori: TClientDataSet;
    cdsValoriVALOREOLD: TStringField;
    cdsValoriVALORENEW: TStringField;
    CreazioneStorico: TOracleQuery;
    CreazioneStoricoStipendi: TOracleQuery;
    updT430: TOracleQuery;
    updP430: TOracleQuery;
    AllineaPeriodiStorici: TOracleQuery;
    AllineaPeriodiStipendi: TOracleQuery;
    insI020: TOracleQuery;
    QDProg: TOracleQuery;
    selCols: TOracleDataSet;
    cdsDipendenti: TClientDataSet;
    dsrDipendenti: TDataSource;
    selContaTabelle: TOracleQuery;
    QBadget: TOracleDataSet;
    QDAnno: TOracleQuery;
    QDMeseAnno: TOracleQuery;
    QDData: TOracleQuery;
    QDProgData: TOracleQuery;
    CancAssenze: TOracleQuery;
    QDProgMeseAnno: TOracleQuery;
    QDProgAnno: TOracleQuery;
    QDDaA: TOracleQuery;
    QDProgDaA: TOracleQuery;
    selQ265: TOracleDataSet;
    dsrQ265: TDataSource;
    selQ275: TOracleDataSet;
    dsrQ275: TDataSource;
    QRenCaus: TOracleQuery;
    QRenTimb: TOracleQuery;
    QRenRes: TOracleQuery;
    QRenProgCaus: TOracleQuery;
    QRenProgRes: TOracleQuery;
    QRenProgTimb: TOracleQuery;
    selT265TesteCatena: TOracleDataSet;
    dsrDipendentiUnificazione: TDataSource;
    cdsDipendentiUnificazione: TClientDataSet;
    selV430: TOracleDataSet;
    QSQL: TOracleQuery;
    selP441: TOracleDataSet;
    selP442: TOracleDataSet;
    updTabelle: TOracleQuery;
    selPeriodi: TOracleDataSet;
    selT430: TOracleDataSet;
    selT430Dec: TOracleDataSet;
    selPeriodiStipendi: TOracleDataSet;
    selP430Dec: TOracleDataSet;
    ScrExeScript: TOracleScript;
    selT960: TOracleDataSet;
    selCausali: TOracleDataSet;
    dsrT960: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsValoriBeforePost(DataSet: TDataSet);
  private
    R600DtM1: TR600DtM1;
    procedure CaricaValori(var Valori: TElencoValoriAggDati; S, T: String; Tipo: integer);
    function ElaboraStorico(ParametriStoricizzazione: TParametriStoricizzazione;var LMessaggi: TStringList): Integer;
    function ElaboraAggiornamento(ParametriStoricizzazione: TParametriStoricizzazione;var LMessaggi: TStringList): Integer;
    procedure ElaboraPeriodiStorici(Tabella, AggLibera: String; var LMessaggi: TStringList);
    procedure CicloBudget(AnnoDa, AnnoA: Integer);
    procedure CreaCdsDipendentiUnificazione;
    procedure PulisciTab(Tabella: String; Progressivo: Integer);
  public
    MaxLung:Integer;
    selI010:TselI010;
    DatoDaAggiornare: String;
    MyCestino:TCestino;
    A023FAllTimbMW: TA023FAllTimbMW;
    function ValoriAggDati(Dato: String): TElencoValoriAggDati;
    procedure InizializzaCdsValori;
    procedure ResetCdsValori;
    function ControlliStoricizzazione(Dato: String; bStoriciSuccessivi: Boolean): String;
    function MessaggioConfermaStoricizzazione(iPeriodo: Integer; DallaData, AllaData: TDateTime): String;
    function MessaggioConfermaCancellazioneDatiDipendente: String;
    function MessaggioConfermaCancellazioneSchedeAnag(num: Integer): String;
    function MessaggioConfermaRiallineamentoGiust(DallaData: TDateTime; numAnag: Integer): String;
    function MessaggioConfermaAllineamentoTimb(const PDal, PAl: TDateTime; PNumAnag: Integer): String;
    function PreparaStoricizzazione(NomeCampo: String): TPreparazioneStoricizzazione;
    function ElaborazioneStoricizzaDipendente(ParametriStoricizzazione: TParametriStoricizzazione;var LMessaggi: TStringList): Boolean;
    procedure InserisciI020(NomeTabella, NomeCampo: String);
    function ElaborazioneCancellaTabellaDipendente(Tabella: String): Boolean;
    function ElaborazioneCancellatabelleAnagDipendente: Boolean;
    procedure ElaborazioneCancellaSchedaAnagDipendente(Progressivo: Integer);
    procedure ImpostaCdsDipendenti;
    procedure CaricaCdsDipendentiSelCols(bLogSchedeAnag: Boolean);
    procedure CaricaCdsDipendentiSelSQL;
    function ElencoTabelleCancellaTotale: TStringList;
    function ElencoTabelleCancellaDipendente: TStringList;
    procedure CancellaBudget(MeseDa, MeseA, AnnoDa, AnnoA: Integer);
    procedure CancellaSchedaRiepil(DaDataMese, ADataMese: TDateTime);
    function ItemTabellaCancella(i: Integer): String;
    function InizializzaTempo(DallaData, AllaData: TDateTime): TTempoCancellazione;
    function IsBudgetAnno(indice: Integer): boolean;
    function IsSchedaRiepil(indice: Integer): boolean;
    procedure CancellaSchedaRiepilDipendente(DaDataMese, ADataMese: TDateTime);
    procedure CancellaDatiGiustif(DallaData, AllaData: TDateTime);
    procedure CancellaDatiGiustifDipendente(DallaData, AllaData: TDateTime);
    function IsGiustificativi(indice: Integer): boolean;
    procedure CancellaMesi(Indice: Integer; tempoCancellazione: TtempoCancellazione);
    procedure CancellaMesiDipendente(Indice: Integer; tempoCancellazione: TtempoCancellazione);
    procedure CancellaAnni(Indice: Integer; tempoCancellazione: TtempoCancellazione);
    procedure CancellaAnniDipendente(Indice: Integer; tempoCancellazione: TtempoCancellazione);
    function CampiAData(Indice: Integer): String;
    function CampiDaData(Indice: Integer): String;
    procedure CancellaDate(indice: Integer; DallaData, AllaData: TDateTime; tempoCancellazione: TtempoCancellazione);
    procedure CancellaDateDipendente(indice: Integer; DallaData, AllaData: TDateTime; tempoCancellazione: TtempoCancellazione);
    procedure CancellaDaA(indice: Integer; DallaData, AllaData: TDateTime);
    procedure CancellaDaADipendente(indice: Integer; DallaData,AllaData: TDateTime);
    procedure CancellaCodiceGiustifProg(Codice: String; DallaData,AllaData: TDateTime; Progressivo: Integer);
    function ElaborazioneRicodificaGiust(DallaData, AllaData: TDateTime; OldCausale, NewCausale: String; bPresenze: Boolean): Boolean;
    function ElaborazioneRicodificaGiustDipendente(DallaData, AllaData: TDateTime; OldCausale, NewCausale: String; bPresenze: Boolean): Boolean;
    procedure FineElaborazioneRiallineamentoGiust;
    procedure InizioElaborazioneRiallineamentoGiust;
    function ElaborazioneRiallinementoGiustDipendente(lstCausali: TStringList; DallaData: TDateTime): Boolean;
    procedure ImpostaDispLabelDipendentiUnificazione;
    function ListaDatiAnagraficiUnificazione: TElencoValoriChecklist;
    function ListaTesteCatena: TElencoValoriChecklist;
    procedure CaricaElencoUnificazioneMatr(DatiAnag: String);
    procedure UnificazioneMatricolaDip(OldProgressivo: Integer);
    function VerificaDateUnificazione(Progressivo: Integer): String;
    function InizioUnificazioneMatricole: String;
    procedure FineUnificazioneMatricole(SalvaFine: String);
    function EseguiScript(NomeFile: String): TStringList;
    function RipristinaCestino(NuovoValore: String): String;
    function CancellaCestino: String;
    procedure AllineamentoTimbrature(const PProgressivo: Integer; const PDal, PAl: TDateTime);
    procedure FiltraCausali(UsaSelezioneAnagrafica: Boolean; PathStorage: String; DataInizio, DataFine: TDateTime; Iter, Stato: string);
    procedure FiltraT960(UsaSelezioneAnagrafica: Boolean; DataInizio, DataFine: TDateTime; Iter, Stato, InfoRichiesta: string);
  end;

  (*
 Dipe:
     True: tabelle anagrafiche, cancellate solo se Cancellazione dati del dipendente
     False: tabelle cancellabili da Cancellazione periodica dipendente e Cancellazione periodica totale
 Indiv:
     True: Cancellazione dati del dipendente, Cancellazione periodica dipendente, Cancellazione periodica totale
     False: Cancellazione periodica totale
 Peri:
     A: Tabelle con campo ANNO
     M: Tabelle con campi ANNO e MESE
     G: Tabelle con campo di tipo Date (dd/mm/yyyy)
     E: Tabelle con campo di tipo Date sempre al primo del mese (01/mm/yyyy)
     D: Tabelle con campi Dal - Al di tipo Date
     N: Non gestita la periodicità
 Campi:
     indica il nome del campo usato da CancDate, se diverso da DATA, altrimenti ''
 Log: Se True registra l'operazione di cancellazione sui log
*)
(*  --- FOREIGN KEY ---
P254_VOCIPROGRAMMATE --> T030
P256_VOCIRIASSORBIBILI --> T030
P258_ADDIZIONALIIRPEF --> T030
P264_MOD730IMPORTI --> P262 CASCADE
P266_MODONAOSI --> T030
P268_RAPPORTIPRECEDENTI --> T030
P270_REDDITIANNUALI --> T030
P272_RETRIBUZIONE_CONTRATTUALE --> T030
P430_ANAGRAFICO --> P010, P020, P040, P080, P120, P130, T030, T480, T482
P440_CEDOLINOSTATO --> T030
P441_CEDOLINO --> P130, T030
P450_DATIMENSILI --> T030
P605_770DATIINDIVIDUALI --> P604 CASCADE
P655_INPDAPMMDATIINDIVIDUALI --> P654 CASCADE

SG101_FAMILIARI --> T030
*)
  const
   TabelleCancella:Array [0..85] of TTabelle =
    (
     (Nome:'I000_LOG';Desc:'RIL.PRES.: LOG OPERAZIONI';Peri:'G';Campi:'';Indiv:False;Dipe:False;Log:True),
     (Nome:'I101_TIMBIRREGOLARI';Desc:'RIL.PRES.: TIMBRATURE IRREGOLARI';Peri:'G';Campi:'';Indiv:False;Dipe:False;Log:True),

     (Nome:'T011_CALENDARI';Desc:'RIL.PRES.: CALENDARI';Peri:'G';Campi:'';Indiv:False;Dipe:False;Log:True),
     (Nome:'T012_CALENDINDIVID';Desc:'RIL.PRES.: CALENDARIO INDIVIDUALE';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T031_DATACARTELLINO';Desc:'RIL.PRES.: DATA CARTELLINO';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T040_GIUSTIFICATIVI';Desc:'RIL.PRES.: GIUSTIFICATIVI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T041_PROVVISORIO';Desc:'RIL.PRES.: GIUSTIFICATIVI PIANIF.ORARI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T042_PERIODIASSENZA';Desc:'RIL.PRES.: PERIODI ASSENZE';Peri:'D';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T043_ASSENZEMENSILI';Desc:'RIL.PRES.: ASSENZE PER CONTO ANNUALE';Peri:'G';Campi:'DATA_FINE_PERIODO';Indiv:True;Dipe:False;Log:True),
     (Nome:'T044_STORICOGIUSTIFICATIVI';Desc:'RIL.PRES.: STORICO GIUSTIFICATIVI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T046_GIUSTIFICATIVIFAMILIARI';Desc:'RIL.PRES.: GIUSTIFICATIVI FAMILIARI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T047_VISITEFISCALI';Desc:'RIL.PRES.: COMUN. VISITE FISCALI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T070_SCHEDARIEPIL';Desc:'RIL.PRES.: SCHEDA RIEPILOGATIVA';Peri:'E';Campi:'';Indiv:True;Dipe:False;Log:True),
     (*
     (Nome:'T071_SCHEDAFASCE';Desc:'RIL.PRES.: SCHEDA FASCE';Peri:'E';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T072_SCHEDAINDPRES';Desc:'RIL.PRES.: SCHEDA INDENNITA PRESENZA';Peri:'E';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T073_SCHEDACAUSPRES';Desc:'RIL.PRES.: SCHEDA CAUSALI PRESENZA';Peri:'E';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T074_CAUSPRESFASCE';Desc:'RIL.PRES.: SCHEDA CAUSALI PRESENZA FASCE';Peri:'E';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T075_STRESTERNO';Desc:'RIL.PRES.: STRAORDINARIO ESTERNO';Peri:'E';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T076_CAUSPRESPAGHE';Desc:'RIL.PRES.: CAUSALI PRESENZA PAGHE';Peri:'E';Campi:'';Indiv:True;Dipe:False;Log:True),
     *)
     (Nome:'T080_PIANIFORARI';Desc:'RIL.PRES.: PIANIFICAZIONE ORARI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T081_PROVVISORIO';Desc:'RIL.PRES.: PIANIF. ORARI PROVV.';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T090_PLUSORAINDIV';Desc:'RIL.PRES.: PLUS ORARIO INDIVIDUALE';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:False),
     (Nome:'T100_TIMBRATURE';Desc:'RIL.PRES.: TIMBRATURE';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T101_ANOMALIE';Desc:'RIL.PRES.: ANOMALIE';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T102_FESTELAVORATE';Desc:'RIL.PRES.: FESTE LAVORATE';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T130_RESIDANNOPREC';Desc:'RIL.PRES.: RESIDUO ORE';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T131_RESIDPRESENZE';Desc:'RIL.PRES.: RESIDUI PRESENZE';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T134_ORELIQUIDATEANNIPREC';Desc:'RIL.PRES.: ORE LIQUID. DA ANNI PREC.';Peri:'E';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T180_DATIBLOCCATI';Desc:'RIL.PRES.: SICUREZZA RIEPILOGHI';Peri:'E';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T195_VOCIVARIABILI';Desc:'RIL.PRES.: VOCI VARIABILI';Peri:'E';Campi:'DATA_CASSA';Indiv:True;Dipe:False;Log:True),
     (Nome:'T246_ISCRIZIONISINDACATI';Desc:'RIL.PRES.: ISCRIZIONI SINDACATI';Peri:'D';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T247_PARTECIPAZIONISINDACATI';Desc:'RIL.PRES.: PARTECIPAZIONI SINDACATI';Peri:'D';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T248_PERMESSISINDACALI';Desc:'RIL.PRES.: PERMESSI SINDACALI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T262_PROFASSANN';Desc:'RIL.PRES.: PROFILI ASSENZE';Peri:'A';Campi:'';Indiv:False;Dipe:False;Log:True),
     (Nome:'T263_PROFASSIND';Desc:'RIL.PRES.: PROFILI ASSENZE INDIVIDUALI';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T264_RESIDASSANN';Desc:'RIL.PRES.: RESIDUO ASSENZE';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T295_MESSAGGIINVIATI';Desc:'RIL.PRES.: MESAGGI INVIATI';Peri:'G';Campi:'DATA_MSG';Indiv:True;Dipe:False;Log:True),
     (Nome:'T299_MESSAGGIRICHIESTI';Desc:'RIL.PRES.: MESSAGGI RICHIESTI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T320_PIANLIBPROFESSIONE';Desc:'RIL.PRES.: PIANIF.LIBERA PROFESSIONE';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T332_PIAN_ATT_AGGIUNTIVE';Desc:'RIL.PRES.: PIANIF.ATTIV.AGGIUNTIVE';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T340_TURNIREPERIB';Desc:'RIL.PRES.: TURNI REPERIBILITA'' SPETTANTI';Peri:'M';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T370_TIMBMENSA';Desc:'RIL.PRES.: TIMBRATURE MENSA';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T375_ACCESSIMENSA';Desc:'RIL.PRES.: ACCESSI MENSA';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T380_PIANIFREPERIB';Desc:'RIL.PRES.: PIANIFICAZIONE REPERIBILITA''';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T410_PASTI';Desc:'RIL.PRES.: PASTI';Peri:'M';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T430_STORICO';Desc:'RIL.PRES.: DATI STORICI';Peri:'N';Campi:'';Indiv:True;Dipe:True;Log:True),
     (Nome:'T435_BADGESERVIZIO';Desc:'RIL.PRES.: BADGE DI SERVIZIO';Peri:'N';Campi:'';Indiv:True;Dipe:True;Log:True),
//     (Nome:'T500_PIANTAORG';Desc:'RIL.PRES.: PIANTA ORGANICA';Peri:'G';Campi:'VARIAZ';Indiv:False;Dipe:False;Log:True),
     (Nome:'T620_TURNAZIND';Desc:'RIL.PRES.: TURNAZIONI INDIVIDUALI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T630_SPOSTSQUADRA';Desc:'RIL.PRES.: SPOSTAMENTO DI SQUADRA';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:False),
     (Nome:'T680_BUONIMENSILI';Desc:'RIL.PRES.: BUONI PASTO MATURATI';Peri:'M';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T690_ACQUISTOBUONI';Desc:'RIL.PRES.: BUONI PASTO ACQUISTATI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T692_RESIDUOBUONI';Desc:'RIL.PRES.: RESIDUO BUONI';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T710_BUDGETANNUO';Desc:'RIL.PRES.: BUDGET STRAORDINARIO ANNUO';Peri:'A';Campi:'';Indiv:False;Dipe:False;Log:True),
     (Nome:'T730_VALUTAORE';Desc:'RIL.PRES.: VALORIZZAZIONE ECONOMICA ORE DI STRAORDINARIO';Peri:'D';Campi:'';Indiv:False;Dipe:False;Log:True),
     (Nome:'T761_INCENTIVI';Desc:'RIL.PRES.: REGOLE INCENTIVI';Peri:'A';Campi:'';Indiv:False;Dipe:False;Log:True),
     (Nome:'T762_INCENTIVIMATURATI';Desc:'RIL.PRES.: INCENTIVI MATURATI';Peri:'M';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T820_LIMITIIND';Desc:'RIL.PRES.: LIMITI INDIVIDUALI';Peri:'M';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'T825_LIQUIDINDANNUO';Desc:'RIL.PRES.: LIQUID.INDIV.ANNUO';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),

     (Nome:'M040_MISSIONI';Desc:'RIL.PRES.: MISSIONI';Peri:'D';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'M050_RIMBORSI';Desc:'RIL.PRES.: RIMBORSI';Peri:'E';Campi:'';Indiv:True;Dipe:False;Log:True),

     (Nome:'T280_MESSAGGIWEB';Desc:'FUNZIONI WEB: MESSAGGI';Peri:'G';Campi:'DATA';Indiv:True;Dipe:False;Log:True),//LORENA
     (Nome:'T050_RICHIESTEASSENZA';Desc:'FUNZIONI WEB: RICHIESTE ASSENZA';Peri:'E';Campi:'';Indiv:True;Dipe:False;Log:True),//LORENA

     (Nome:'P254_VOCIPROGRAMMATE';Desc:'STIPENDI: VOCI PROGRAMMATE';Peri:'D';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'P256_VOCIRIASSORBIBILI';Desc:'STIPENDI: VOCI ASSORBIBILI';Peri:'G';Campi:'DATA_INIZIO';Indiv:True;Dipe:False;Log:True),
     (Nome:'P258_ADDIZIONALIIRPEF';Desc:'STIPENDI: ADDIZIONALI IRPEF';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),
     // P264 ha una foreign key su P262
//     (Nome:'P262_MOD730TESTATA';Desc:'STIPENDI: MOD.730 TESTATA';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'P264_MOD730IMPORTI';Desc:'STIPENDI: MOD.730 IMPORTI';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'P266_MODONAOSI';Desc:'STIPENDI: MOD.10 NAOSI';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'P268_RAPPORTIPRECEDENTI';Desc:'STIPENDI: RAPPORTI PRECEDENTI';Peri:'G';Campi:'DATA_CEDOLINO_RP';Indiv:True;Dipe:False;Log:True),
     (Nome:'P270_REDDITIANNUALI';Desc:'STIPENDI: REDDITI ANNUALI';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'P272_RETRIBUZIONE_CONTRATTUALE';Desc:'STIPENDI: RETRIB.CONTRATTUALE';Peri:'N';Campi:'';Indiv:True;Dipe:True;Log:True),
     (Nome:'P430_ANAGRAFICO';Desc:'STIPENDI: ANAGRAFICO ';Peri:'N';Campi:'';Indiv:True;Dipe:True;Log:True),
     (Nome:'P440_CEDOLINOSTATO';Desc:'STIPENDI: CEDOLINO STATO';Peri:'G';Campi:'DATA_CEDOLINO_CHIUSO';Indiv:True;Dipe:False;Log:True),
     (Nome:'P441_CEDOLINO';Desc:'STIPENDI: CEDOLINO';Peri:'G';Campi:'DATA_CEDOLINO';Indiv:True;Dipe:False;Log:True),
     (Nome:'P450_DATIMENSILI';Desc:'STIPENDI: DATI MENSILI';Peri:'G';Campi:'DATA_RETRIBUZIONE';Indiv:True;Dipe:False;Log:True),
     (Nome:'P504_CUDTESTATE';Desc:'STIPENDI: CUD TESTATE';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'P605_770DATIINDIVIDUALI';Desc:'STIPENDI: DATI INDIVIDUALI MOD.770';Peri:'N';Campi:'';Indiv:True;Dipe:True;Log:True),
//     (Nome:'P655_INPDAPMMDATIINDIVIDUALI';Desc:'STIPENDI: DATI INDIVIDUALI INPDAP';Peri:'N';Campi:'';Indiv:True;Dipe:True;Log:True),

     (Nome:'SG100_PROVVEDIMENTO';Desc:'STATO GIURIDICO: PROVVEDIMENTO';Peri:'G';Campi:'DATADECOR';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG101_FAMILIARI';Desc:'STATO GIURIDICO: FAMILIARI';Peri:'G';Campi:'DECORRENZA';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG102_DOCUMENTI';Desc:'STATO GIURIDICO: DOCUMENTI';Peri:'G';Campi:'DATAPRES';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG303_INCINDIVIDUALI';Desc:'STATO GIURIDICO: INCARICHI';Peri:'G';Campi:'DATA_AFFIDAMENTO';Indiv:True;Dipe:False;Log:True),  //Lorena 05/06/2008
     (Nome:'SG402_TESTATARISCHI';Desc:'STATO GIURIDICO: RISCHI E PRESCRIZIONI';Peri:'G';Campi:'DATA_INIZIO';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG403_DETTAGLIORISCHI';Desc:'STATO GIURIDICO: RISCHI E PRESCRIZIONI';Peri:'G';Campi:'DATA_INIZIO';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG110_CURRICULUM';Desc:'STATO GIURIDICO: CURRICULUM';Peri:'G';Campi:'DATA_REGISTRAZIONE';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG113_PREFERENZE';Desc:'STATO GIURIDICO: PREFERENZE';Peri:'G';Campi:'DATA_REGISTRAZIONE';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG651_PIANIFICAZIONECORSI';Desc:'STATO GIURIDICO: PIANIFICAZIONE CORSI';Peri:'G';Campi:'DATA_CORSO';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG656_RESIDUOCREDITI';Desc:'STATO GIURIDICO: RESIDUO CREDITI';Peri:'A';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG705_VALUTATORI';Desc:'STATO GIURIDICO: VALUTAZIONI';Peri:'G';Campi:'DECORRENZA';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG706_VALUTATORI_DIPENDENTE';Desc:'STATO GIURIDICO: VALUTAZIONI';Peri:'G';Campi:'DECORRENZA';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG710_TESTATA_VALUTAZIONI';Desc:'STATO GIURIDICO: VALUTAZIONI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG711_VALUTAZIONI_DIPENDENTE';Desc:'STATO GIURIDICO: VALUTAZIONI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),
     (Nome:'SG745_CONSEGNA_VALUTAZIONI';Desc:'STATO GIURIDICO: VALUTAZIONI';Peri:'G';Campi:'';Indiv:True;Dipe:False;Log:True),

     //Viene cancellata per ultima perchè esistono foreign key su questa tabella
     (Nome:'T030_ANAGRAFICO';Desc:'RIL.PRES.: ANAGRAFICO';Peri:'N';Campi:'';Indiv:True;Dipe:True;Log:False)
  );

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
procedure TB007FManipolazioneDatiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,
      'DECODE(SUBSTR(NOME_CAMPO,1,4),''T430'',''T430_STORICO'',''P430'',''P430_ANAGRAFICO'',''T030_ANAGRAFICO'')  TABELLA, ' +
      'REPLACE(REPLACE(NOME_CAMPO,''T430'',''''),''P430'','''') NOME_CAMPO, ' +
      'NOME_LOGICO, TABLE_NAME, DATA_TYPE, DATA_LENGTH',
      '(TABLE_NAME = ''V430_STORICO'' AND SUBSTR(NOME_CAMPO,5,2) <> ''D_''' +
      ' AND REPLACE(NOME_CAMPO,''T430'','''') <> ''PROGRESSIVO'' AND REPLACE(NOME_CAMPO,''T430'','''') <> ''DATADECORRENZA''' +
      ' AND REPLACE(NOME_CAMPO,''T430'','''') <> ''DATAFINE'' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''PROGRESSIVO''' +
      ' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''DECORRENZA'' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''DECORRENZA_FINE''' +
      ' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''FRAZIONE_PARTTIME'' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''PERC_PARTTIME''' +
      ' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''ABI_BANCA'' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''CAB_BANCA''' +
      ' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''AGENZIA_BANCA'')' +
    ' OR (TABLE_NAME = ''T030_ANAGRAFICO'')',
    'TABLE_NAME, TABELLA, NOME_LOGICO');
  InizializzaCdsValori;
  selQ265.Open;
  selQ275.Open;
  selT265TesteCatena.Open;
  R600DtM1:=nil;
  CreaCdsDipendentiUnificazione;
  MyCestino:=TCestino.Create(SessioneOracle);
end;

procedure TB007FManipolazioneDatiMW.cdsValoriBeforePost(DataSet: TDataSet);
var
  PosAnd,PosDot: Integer;
  ValoreNew: String;
  ElencoValori: TElencoValoriAggDati;
begin
  //Validazione valore old
  if (cdsValori.FieldByName('VALOREOLD').AsString <> '') and
     (Uppercase(cdsValori.FieldByName('VALOREOLD').AsString) <> 'NULL') then
  begin
    ElencoValori:=ValoriAggDati(DatoDaAggiornare);
    try
      if ElencoValori.lstValoreEsistente.IndexOf(cdsValori.FieldByName('VALOREOLD').AsString) = - 1 then
        raise Exception.Create(A000MSG_B007_ERR_VAL_OLD_NON_PREVISTO);
    finally
      FreeAndNil(ElencoValori);
    end;
  end;

  //Validazione valore new
  ValoreNew:=Trim(cdsValori.FieldByName('VALORENEW').AsString);
  if ValoreNew = '' then
    raise Exception.Create(A000MSG_B007_ERR_VAL_OLD_NON_PREVISTO);

  // controlla correttezza sintassi operatore "&" e "-&"
  PosAnd:=Pos('&',ValoreNew);
  if PosAnd > 2 then
    raise Exception.Create(A000MSG_B007_ERR_SINTASSI)
  else if PosAnd = 2 then
  begin
    PosDot:=Pos('-',ValoreNew);
    if PosDot = 0 then
    raise Exception.Create(A000MSG_B007_ERR_SINTASSI)
  end
  else
  begin
    // verifica presenza di altri caratteri speciali
    if Pos('&',Copy(ValoreNew,PosAnd + 1,Length(ValoreNew)- PosAnd)) > 0 then
      raise Exception.Create(A000MSG_B007_ERR_SINTASSI);
  end;
end;

procedure TB007FManipolazioneDatiMW.CaricaValori(var Valori: TElencoValoriAggDati;S,T: String; Tipo:integer);
begin
  with selSQL do
  begin
    Close;
    SQL.Clear;
    SQL.Add(S);
    Open;
    First;
    while not Eof do
    begin
      if FieldByName('CODICE').AsString <> '' then
        if (T <> 'T430_STORICO') and (T <> 'P430_ANAGRAFICO') and (T <> '') then
        begin
          if Tipo = 1 then
              Valori.lstValoreEsistente.Add(FieldByName('CODICE').AsString)
            else
              Valori.lstNuovoValore.Add(FieldByName('CODICE').AsString);
        end
        else
        begin
          Valori.lstValoreEsistente.Add(FieldByName('CODICE').AsString);
          Valori.lstNuovoValore.Add(FieldByName('CODICE').AsString);
        end;
      Next;
    end;
    MaxLung:=FieldByName('CODICE').Size;
  end;
end;

function TB007FManipolazioneDatiMW.ValoriAggDati(Dato: String): TElencoValoriAggDati;
var
  S,T,C,Storico,NomeCampo,NomeLogico,NomeTabella: String;
begin
  Result:=TElencoValoriAggDati.Create;

  if Dato <> '' then
  begin
    NomeCampo:=Dato;
    NomeLogico:=VarToStr(selI010.Lookup('NOME_CAMPO',NomeCampo,'NOME_LOGICO'));
    NomeTabella:=VarToStr(selI010.Lookup('NOME_CAMPO',NomeCampo,'TABELLA'));
    if NomeTabella = 'T430_STORICO' then
    begin
      A000GetTabella(NomeCampo,T,C,Storico);
      if T <> '' then
      begin
        if T <> 'T430_STORICO' then
        begin
          if Storico = 'N' then
          begin
            Result.lstValoreEsistente.Add('NULL');
            Result.lstNuovoValore.Add('&'); //LORENA 22/10/2004
            Result.lstNuovoValore.Add('-&');
            Result.lstNuovoValore.Add('NULL');
          end;
          S:='SELECT DISTINCT ' + NomeCampo + ' CODICE FROM T430_STORICO ORDER BY CODICE';
          CaricaValori(Result,S,T,1);
          S:='SELECT DISTINCT CODICE FROM ' + T + ' ORDER BY CODICE';
          CaricaValori(Result,S,T,2);
        end
        else
        begin
          Result.lstValoreEsistente.Add('NULL');
          Result.lstNuovoValore.Add('&');  //LORENA 22/10/2004
          Result.lstNuovoValore.Add('-&');
          Result.lstNuovoValore.Add('NULL');
          S:='SELECT DISTINCT ' + C + ' CODICE FROM T430_STORICO ORDER BY CODICE';
          CaricaValori(Result,S,T,3);
        end
      end
      else
      begin
        S:='SELECT DISTINCT ' + NomeCampo  + ' CODICE FROM T430_STORICO ORDER BY CODICE';
        CaricaValori(Result,S,T,3);
      end;
    end
    else if NomeTabella = 'P430_ANAGRAFICO' then
    begin
      A000GetTabellaP430(NomeCampo,T,C,Storico);
      if T <> '' then
      begin
        if T <> 'P430_ANAGRAFICO' then
        begin
          if Storico = 'N' then
          begin
            Result.lstValoreEsistente.Add('NULL');
            Result.lstNuovoValore.Add('&'); //LORENA 22/10/2004
            Result.lstNuovoValore.Add('-&');
            Result.lstNuovoValore.Add('NULL');
          end;
          S:='SELECT DISTINCT ' + NomeCampo + ' CODICE FROM P430_ANAGRAFICO ORDER BY CODICE';
          CaricaValori(Result,S,T,1);
          S:='SELECT DISTINCT ' + C + ' CODICE FROM ' + T + ' ORDER BY ' + C;
          CaricaValori(Result,S,T,2);
        end
        else
        begin
          Result.lstValoreEsistente.Add('NULL');
          Result.lstNuovoValore.Add('&');  //LORENA 22/10/2004
          Result.lstNuovoValore.Add('-&');
          Result.lstNuovoValore.Add('NULL');
          S:='SELECT DISTINCT ' + C + ' CODICE FROM P430_ANAGRAFICO ORDER BY CODICE';
          CaricaValori(Result,S,T,3);
        end
      end
      else
      begin
        S:='SELECT DISTINCT ' + NomeCampo  + ' CODICE FROM P430_ANAGRAFICO ORDER BY CODICE';
        CaricaValori(Result,S,T,3);
      end;
    end;
  end;
end;

procedure TB007FManipolazioneDatiMW.InizializzaCdsValori;
begin
  // Pulizia cdsValori
  with cdsValori do
  begin
    Close;
    CreateDataSet;
    Open;
    LogChanges:=False;
  end;
end;

procedure TB007FManipolazioneDatiMW.ResetCdsValori;
begin
  // Pulizia cdsValori
  cdsValori.EmptyDataset;
end;

function TB007FManipolazioneDatiMW.ControlliStoricizzazione(Dato: String; bStoriciSuccessivi: Boolean): String;
begin
  // Controlli
  if Dato = '' then
  begin
    Result:=A000MSG_B007_ERR_DATO_AGG_EMPTY;
    Exit;
  end;

  with cdsValori do
  begin
    if RecordCount = 0 then
    begin
      Result:=A000MSG_B007_ERR_NO_VALORI;
      Exit;
    end;

    if bStoriciSuccessivi and (RecordCount > 1) then
    begin
      Result:=A000MSG_B007_ERR_CORRISPONDENZA_SINGOLA;
      Exit;
    end;

    // verifica che sia specificato un solo valore di default
    Filter:='(TRIM(VALOREOLD)='''') OR (VALOREOLD IS NULL)';
    Filtered:=True;
    try
      if RecordCount > 1 then
      begin
        Result:=A000MSG_B007_ERR_DEFAULT;
        Exit;
      end;
    finally
      Filter:='';
      Filtered:=False;
    end;
  end;
end;

function TB007FManipolazioneDatiMW.MessaggioConfermaStoricizzazione(iPeriodo:Integer; DallaData, AllaData: TDateTime): String;
begin
  Result:=Format(A000MSG_B007_DLG_FMT_CONFERMA_STORICIZZA,[
          IfThen(iPeriodo = 0,
                Format(A000MSG_B007_DLG_FMT_PERIODO_STORICIZZA,[DateToStr(DallaData),DateToStr(AllaData)]),
                Format(A000MSG_B007_DLG_FMT_DAL_STORICIZZA,[DateToStr(DallaData)])
                )]);
end;

function TB007FManipolazioneDatiMW.MessaggioConfermaAllineamentoTimb(const PDal, PAl: TDateTime; PNumAnag: Integer): String;
begin
  Result:=Format(A000MSG_B007_DLG_FMT_ALL_TIMB_DIP,[DateToStr(PDal),DateToStr(PAl),PNumAnag]);
end;

function TB007FManipolazioneDatiMW.MessaggioConfermaCancellazioneDatiDipendente: String;
begin
  Result:=Format(A000MSG_B007_DLG_FMT_CANC_DATI_DIP,[IntToStr(selAnagrafe.Recordcount)]);
end;

function TB007FManipolazioneDatiMW.MessaggioConfermaCancellazioneSchedeAnag(num: Integer): String;
begin
  Result:=Format(A000MSG_B007_DLG_FMT_CANC_SCHEDE_ANAG,[IntToStr(num)]);
end;

function TB007FManipolazioneDatiMW.MessaggioConfermaRiallineamentoGiust(DallaData:TDateTime; numAnag:Integer): String;
begin
  Result:=Format(A000MSG_B007_DLG_FMT_RIALL_GIUST,[DateToStr(DallaData),IntToStr(numAnag)]);
end;

function TB007FManipolazioneDatiMW.PreparaStoricizzazione(NomeCampo: String): TPreparazioneStoricizzazione;
var
  Valori,ValoreOld,ValoreNew,Val,Temp: String;
  Default: Boolean;
begin
  Result.NomeTabella:=VarToStr(selI010.Lookup('NOME_CAMPO',NomeCampo,'TABELLA'));
  with cdsValori do
  begin
    Valori:='';
    Result.VOld:='';
    Result.VNew:='';
    Default:=False;
    First;
    //Accoda:=False;
    while not Eof do
    begin
      if Uppercase(FieldByName('VALORENEW').AsString) <> 'NULL' then
        ValoreNew:='''' + FieldByName('VALORENEW').AsString + ''''
      else
        ValoreNew:=FieldByName('VALORENEW').AsString;
      if Uppercase(FieldByName('VALOREOLD').AsString) <> 'NULL' then
        ValoreOld:='''' + FieldByName('VALOREOLD').AsString + ''''
      else
        ValoreOld:=FieldByName('VALOREOLD').AsString;
      Result.VOld:=Result.VOld + IfThen(Result.VOld <> '',',','') + ValoreOld;
      Result.VNew:=Result.VNew + IfThen(Result.VNew <> '',',','') + ValoreNew;
      Valori:=Valori + IfThen(Valori <> '',',','');

      // blocco modificato.ini
      Valori:=Valori + IfThen(Trim(FieldByName('VALOREOLD').AsString) = '','',ValoreOld + ',');
      if Trim(FieldByName('VALOREOLD').AsString) = '' then
        Default:=True;
      if Copy(ValoreNew,2,1) = '&' then
      begin
        // aggiunta di valori (evita duplicazione dati già presenti)
        Val:=Copy(ValoreNew,3,Length(ValoreNew) - 3);
        Temp:='DECODE(INSTR('',''||' + NomeCampo + '||'','','',''||''' + Val + '''||'',''),0,' + NomeCampo + '||'',' + Val + ''',' + NomeCampo + ')';
        Valori:=Valori + ' DECODE(RTRIM(LTRIM(' + NomeCampo + ')),'''',''' + Val + ''',' + Temp + ')';
      end
      else if Copy(ValoreNew,2,2) = '-&' then
      begin
        // cancellazione di un valore
        Val:=Copy(ValoreNew,4,Length(ValoreNew) - 4);
        Valori:=Valori + 'SUBSTR(REPLACE('',''||' + NomeCampo + '||'','','',''||''' + Val + '''||'','','',''),2,' +
                         'LENGTH(REPLACE('',''||' + NomeCampo + '||'','','',''||''' + Val + '''||'','','',''))-2)';
      end
      else
      begin
        Valori:=Valori + ValoreNew;
      end;
      // blocco modificato.fine

      Next;
    end;

    // blocco modificato.ini
    if not Default then
      Valori:=Valori + ',' + NomeCampo;
    if Default and (RecordCount = 1) then
      Result.Sql:=NomeCampo + ' = ' + Valori
    else
      Result.Sql:=NomeCampo + ' = DECODE(' + NomeCampo + ',' + Valori + ')';
    // blocco modificato.fine
  end;
end;

function TB007FManipolazioneDatiMW.ElaboraStorico(ParametriStoricizzazione:TParametriStoricizzazione;var LMessaggi:TStringList):Integer;
var OK:Boolean;
begin
  Result:=0;
  OK:=False;
  if ParametriStoricizzazione.PreparazioneStoricizzazione.NomeTabella= 'T430_STORICO' then
  begin
    with CreazioneStorico do
    begin
      SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DADATA',ParametriStoricizzazione.DataDa);
      if (ParametriStoricizzazione.iPeriodo = 0) and (ParametriStoricizzazione.DataA < StrToDate('31/12/3999')) then
        SetVariable('ADATA',ParametriStoricizzazione.DataA)
      else
        SetVariable('ADATA',null);
      try
        Execute;
        OK:=True;
        Result:=RowsProcessed;
      except
        on E:Exception do
          LMessaggi.Add(E.Message);
      end;
    end;
  end
  else if ParametriStoricizzazione.PreparazioneStoricizzazione.NomeTabella = 'P430_ANAGRAFICO' then
  begin
    with CreazioneStoricoStipendi do
    begin
      SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DADATA',ParametriStoricizzazione.DataDa);
      if (ParametriStoricizzazione.iPeriodo = 0) and (ParametriStoricizzazione.DataA < StrToDate('31/12/3999')) then
        SetVariable('ADATA',ParametriStoricizzazione.DataA)
      else
        SetVariable('ADATA',null);
      try
        Execute;
        Result:=RowsProcessed;
        OK:=True;
      except
        on E:Exception do
          LMessaggi.Add(E.Message);
      end;
    end;
  end;
  if OK then
  begin
    RegistraLog.SettaProprieta('I',ParametriStoricizzazione.PreparazioneStoricizzazione.NomeTabella,NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger),'');
    RegistraLog.InserisciDato('DA DATA',DateToStr(ParametriStoricizzazione.DataDa),'');
    if ParametriStoricizzazione.iPeriodo = 0 then
      RegistraLog.InserisciDato('A DATA',DateToStr(ParametriStoricizzazione.DataA),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

function TB007FManipolazioneDatiMW.ElaboraAggiornamento(ParametriStoricizzazione: TParametriStoricizzazione; var LMessaggi:TStringList):Integer;
var OK:Boolean;
  i:Integer;
  DFine,PrimoAgg:TDateTime;
  Msg:String;
begin
  OK:=False;
  Result:=0;
  if ParametriStoricizzazione.iPeriodo = 0 then
    DFine:=ParametriStoricizzazione.DataA
  else
    DFine:=EncodeDate(3999,12,31);
  if ParametriStoricizzazione.PreparazioneStoricizzazione.NomeTabella = 'T430_STORICO' then
  begin
    if ParametriStoricizzazione.bStoriciSuccessivi then
    begin
      C006FStoriaDati:=TC006FStoriaDati.Create(nil);
      C006FStoriaDati.GetStoriaDato(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,ParametriStoricizzazione.Dato);
      PrimoAgg:=0;
      for i:=0 to C006FStoriaDati.StoriaDipendente.Count -1 do
      begin
        if ParametriStoricizzazione.DataDa <= RecStoria(C006FStoriaDati.StoriaDipendente[i]).Decorrenza then
        begin
          if (PrimoAgg = 0) and
             (RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore = StringReplace(ParametriStoricizzazione.PreparazioneStoricizzazione.VOld,'''','',[rfReplaceAll])) then
            PrimoAgg:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Decorrenza;
          if (PrimoAgg <> 0) and (PrimoAgg < RecStoria(C006FStoriaDati.StoriaDipendente[i]).Decorrenza) and
            (RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore <> ParametriStoricizzazione.PreparazioneStoricizzazione.VOld) then
          begin
            DFine:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Decorrenza - 1;
            Msg:=Format(A000MSG_B007_MSG_ERR_AGG_STORICO,[RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataDec,
                                                          ParametriStoricizzazione.Dato,
                                                          RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore,
                                                         ParametriStoricizzazione.PreparazioneStoricizzazione.VOld]);
            RegistraMsg.InserisciMessaggio('I',Msg,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            Break;
          end;
        end
        else
        begin
          if (PrimoAgg = 0) and
             (RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore = StringReplace(ParametriStoricizzazione.PreparazioneStoricizzazione.VOld,'''','',[rfReplaceAll])) then
            PrimoAgg:=ParametriStoricizzazione.DataDa;
        end;
      end;
      FreeAndNil(C006FStoriaDati);
    end;
    with updT430 do
    begin
      SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATADECORRENZA',ParametriStoricizzazione.DataDa);
      SetVariable('DATAFINE',DFine);
      SetVariable('SET',ParametriStoricizzazione.PreparazioneStoricizzazione.Sql);
      try
        Execute;
        Result:=RowsProcessed;
        OK:=True;
      except
       on E:Exception do
          LMessaggi.Add(E.Message);
      end;
    end;
  end
  else if ParametriStoricizzazione.PreparazioneStoricizzazione.NomeTabella = 'P430_ANAGRAFICO' then
  begin
    if ParametriStoricizzazione.bStoriciSuccessivi then
    begin
      C006FStoriaDati:=TC006FStoriaDati.Create(nil);
      C006FStoriaDati.GetStoriaDatoP430(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,ParametriStoricizzazione.Dato);
      PrimoAgg:=0;
      for i:=0 to C006FStoriaDati.StoriaDipendente.Count -1 do
      begin
        if ParametriStoricizzazione.DataDa <= RecStoria(C006FStoriaDati.StoriaDipendente[i]).Decorrenza then
        begin
          if (PrimoAgg = 0) and
             (RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore = StringReplace(ParametriStoricizzazione.PreparazioneStoricizzazione.VOld,'''','',[rfReplaceAll])) then
            PrimoAgg:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Decorrenza;
          if (PrimoAgg <> 0) and (PrimoAgg < RecStoria(C006FStoriaDati.StoriaDipendente[i]).Decorrenza) and
            (RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore <> ParametriStoricizzazione.PreparazioneStoricizzazione.VOld) then
          begin
            DFine:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Decorrenza - 1;
            Msg:=Format(A000MSG_B007_MSG_ERR_AGG_STORICO,[RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataDec,
                                                          ParametriStoricizzazione.Dato,
                                                          RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore,
                                                          ParametriStoricizzazione.PreparazioneStoricizzazione.VOld]);
            RegistraMsg.InserisciMessaggio('I',Msg,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            Break;
          end;
        end
        else
        begin
          if (PrimoAgg = 0) and
             (RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore = StringReplace(ParametriStoricizzazione.PreparazioneStoricizzazione.VOld,'''','',[rfReplaceAll])) then
            PrimoAgg:=ParametriStoricizzazione.DataDa;
        end;
      end;
      FreeAndNil(C006FStoriaDati);
    end;
    with updP430 do
    begin
      SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATADECORRENZA',ParametriStoricizzazione.DataDa);
      SetVariable('DATAFINE',DFine);
      SetVariable('SET',ParametriStoricizzazione.PreparazioneStoricizzazione.Sql);
      try
        Execute;
        Result:=RowsProcessed;
        OK:=True;
      except
       on E:Exception do
          LMessaggi.Add(E.Message);
      end;
    end;
  end;
  if OK then
  begin
    RegistraLog.SettaProprieta('M',ParametriStoricizzazione.PreparazioneStoricizzazione.NomeTabella,NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger),'');
    RegistraLog.InserisciDato(ParametriStoricizzazione.DescDato,ParametriStoricizzazione.PreparazioneStoricizzazione.VOld,ParametriStoricizzazione.PreparazioneStoricizzazione.VNew);
    RegistraLog.InserisciDato('DA DATA',DateToStr(ParametriStoricizzazione.DataDa),'');
    if ParametriStoricizzazione.iPeriodo = 0 then
      RegistraLog.InserisciDato('A DATA',DateToStr(DFine),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

procedure TB007FManipolazioneDatiMW.ElaboraPeriodiStorici(Tabella,AggLibera:String;var LMessaggi:TStringList);
var OK:Boolean;
begin
  OK:=False;
  if Tabella = 'T430_STORICO' then
  begin
    with AllineaPeriodiStorici do
    begin
      SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('AGGLIBERA',AggLibera);
      try
        Execute;
        OK:=True;
      except
        on E:Exception do
          LMessaggi.Add(E.Message);
      end;
    end;
  end
  else if Tabella = 'P430_ANAGRAFICO' then
  begin
    with AllineaPeriodiStipendi do
    begin
      SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      try
        Execute;
        OK:=True;
      except
        on E:Exception do
          LMessaggi.Add(E.Message);
      end;
    end;
  end;
  if OK then
  begin
    RegistraLog.SettaProprieta('I',Tabella,NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsString,'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

function TB007FManipolazioneDatiMW.ElaborazioneRicodificaGiust(DallaData,AllaData:TDateTime;OldCausale,NewCausale:String;bPresenze: Boolean): Boolean;
var
  Tabella, s: string;
begin
  Result:=True;
  // ricodifica giustificativi
  QRenCaus.SetVariable('DaData',DallaData);
  QRenCaus.SetVariable('AData',AllaData);
  QRenCaus.SetVariable('NewCausale',NewCausale);
  QRenCaus.SetVariable('OldCausale',OldCausale);
  QRenCaus.Execute;
  RegistraLog.SettaProprieta('M','T040_GIUSTIFICATIVI',NomeOwner,nil,True);
  RegistraLog.InserisciDato('CAUSALE',newCausale,OldCausale);
  RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;

  if bPresenze then //Presenze
  begin
    // ricodifica timbrature
    QRenTimb.SetVariable('NewCausale',NewCausale);
    QRenTimb.SetVariable('OldCausale',OldCausale);
    Tabella:='T100_TIMBRATURE';
    QRenTimb.SetVariable('Tabella',Tabella);
    QRenTimb.SetVariable('DaData',DallaData);
    QRenTimb.SetVariable('AData',AllaData);
    QRenTimb.Execute;
    RegistraLog.SettaProprieta('M',Tabella,NomeOwner,nil,True);
    RegistraLog.InserisciDato('CAUSALE',NewCausale,OldCausale);
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
    // ricodifica schede riepilogative
    if R180Giorno(DallaData) = 1 then
      QRenTimb.SetVariable('DaData',DallaData)
    else
      QRenTimb.SetVariable('DaData',R180FineMese(DallaData) + 1);
    if AllaData = R180FineMese(AllaData) then
      QRenTimb.SetVariable('AData',AllaData)
    else
      QRenTimb.SetVariable('AData',R180InizioMese(AllaData) - 1);
    Tabella:='T073_SCHEDACAUSPRES';
    QRenTimb.SetVariable('Tabella',Tabella);
    try
      QRenTimb.Execute;
    except
      on E:Exception do
      begin
        Result:=False;
        s:=Format(A000MSG_B007_MSG_FMT_ERR_RICODIFICA_CAU,[Tabella]);
        RegistraMsg.InserisciMessaggio('A',s);
        RegistraMsg.InserisciMessaggio('A',E.Message);
      end;
    end;
    RegistraLog.SettaProprieta('M',Tabella,NomeOwner,nil,True);
    RegistraLog.InserisciDato('CAUSALE',NewCausale,OldCausale);
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
    Tabella:='T074_CAUSPRESFASCE';
    QRenTimb.SetVariable('Tabella',Tabella);
    try
      QRenTimb.Execute;
    except
      on E:Exception do
      begin
        Result:=False;
        s:=Format(A000MSG_B007_MSG_FMT_ERR_RICODIFICA_CAU,[Tabella]);
        RegistraMsg.InserisciMessaggio('A',s);
        RegistraMsg.InserisciMessaggio('A',E.Message);
      end;
    end;
    RegistraLog.SettaProprieta('M',Tabella,NomeOwner,nil,True);
    RegistraLog.InserisciDato('CAUSALE',NewCausale,OldCausale);
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
    // ricodifica residui
    if (R180Giorno(DallaData) = 1) and (R180Mese(DallaData) = 1) then
      QRenRes.SetVariable('DaAnno',R180Anno(DallaData))
    else
      QRenRes.SetVariable('DaAnno',R180Anno(DallaData) + 1);
    if (R180Giorno(AllaData) = 31) and (R180Mese(AllaData) = 12) then
      QRenRes.SetVariable('AAnno',R180Anno(AllaData))
    else
      QRenRes.SetVariable('AAnno',R180Anno(AllaData) - 1);
    QRenRes.SetVariable('NewCausale',NewCausale);
    QRenRes.SetVariable('OldCausale',OldCausale);
    try
      QRenRes.Execute;
    except
      on E:Exception do
      begin
        Result:=False;
        s:=Format(A000MSG_B007_MSG_FMT_ERR_RICODIFICA_CAU,['T131_RESIDPRESENZE']);
        RegistraMsg.InserisciMessaggio('A',s);
        RegistraMsg.InserisciMessaggio('A',E.Message);
      end;
    end;
    RegistraLog.SettaProprieta('M','T131_RESIDPRESENZE',NomeOwner,nil,True);
    RegistraLog.InserisciDato('CAUSALE',NewCausale,OldCausale);
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

procedure TB007FManipolazioneDatiMW.InizioElaborazioneRiallineamentoGiust;
begin
  R600DtM1:=TR600DtM1.Create(Self);
  RegistraMsg.InserisciMessaggio('I',Format(A000MSG_B007_MSG_FMT_INI_RIALL_GIUST,[IntToStr(SelAnagrafe.RecordCount)]));
end;

procedure TB007FManipolazioneDatiMW.FineElaborazioneRiallineamentoGiust;
begin
  RegistraMsg.InserisciMessaggio('I',A000MSG_B007_MSG_FINE_RIALL_GIUST);
  // libera le risorse utilizzate
  FreeAndNil(R600DtM1);
end;

function TB007FManipolazioneDatiMW.ElaborazioneRiallinementoGiustDipendente(lstCausali:TStringList; DallaData: TDateTime):Boolean;
var
  Caus,CausaleMsg,Msg: String;
  Giust: TGiustificativo;
  Conta: Integer;
begin
  Result:=true;

  // ciclo sulle causali
  for Caus in lstCausali do
  begin
    CausaleMsg:='Causale "' + Caus + '"';

    // determina i giustificativi con data >= alla data limite
    // la cui causale appartiene alla catena della causale i-esima,
    Giust.Causale:=Caus;
    Conta:=R600DtM1.ContaGiustifAssFuturi(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DallaData - 1,Giust,'');

    if Conta > 0 then
    begin
      // esegue il riallineamento dei giustificativi
      try
        R600DtM1.GestioneGiustifAssFuturi(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DallaData - 1,Giust,'');
        Msg:=CausaleMsg + ': effettuato il riallineamento di n. ' + IntToStr(Conta) + ' giustificativi a partire dal ' + DateToStr(DallaData) + '.';
        RegistraMsg.InserisciMessaggio('I',Msg,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      except
        on E: Exception do
        begin
          Msg:=CausaleMsg + ': riallineamento a partire dal ' + DateToStr(DallaData) + ' fallito! Errore: ' + E.Message;
          RegistraMsg.InserisciMessaggio('A',Msg,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          Result:=False
        end;
      end;
    end
    else
    begin
      R600DtM1.ChiudiGiustifAssFuturi;
      Msg:=CausaleMsg + ' - riallineamento non necessario';
      RegistraMsg.InserisciMessaggio('I',Msg,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end;
end;

function TB007FManipolazioneDatiMW.ElaborazioneRicodificaGiustDipendente(DallaData,AllaData:TDateTime;OldCausale,NewCausale:String;bPresenze: Boolean): Boolean;
var
  Tabella, s: String;
begin
  Result:=true;
  //ricodifica giustificativi
  QRenProgCaus.SetVariable('DaData',DallaData);
  QRenProgCaus.SetVariable('AData',AllaData);
  QRenProgCaus.SetVariable('NewCausale',NewCausale);
  QRenProgCaus.SetVariable('OldCausale',OldCausale);

  //ricodifica giustificativi
  QRenProgCaus.SetVariable('Progressivo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  QRenProgCaus.Execute;

  RegistraLog.SettaProprieta('M','T040_GIUSTIFICATIVI',NomeOwner,nil,True);
  RegistraLog.InserisciDato('CAUSALE',NewCausale,OldCausale);
  RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
  RegistraLog.InserisciDato('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsString,'');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  if bPresenze then //Presenze
  begin
    QRenProgTimb.SetVariable('NewCausale',NewCausale);
    QRenProgTimb.SetVariable('OldCausale',OldCausale);

    //ricodifica timbrature
    QRenProgTimb.SetVariable('DaData',DallaData);
    QRenProgTimb.SetVariable('AData',AllaData);
    QRenProgTimb.SetVariable('Progressivo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    Tabella:='T100_TIMBRATURE';
    QRenProgTimb.SetVariable('Tabella',Tabella);
    QRenProgTimb.Execute;
    RegistraLog.SettaProprieta('M',Tabella,NomeOwner,nil,True);
    RegistraLog.InserisciDato('CAUSALE',NewCausale,OldCausale);
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
    RegistraLog.InserisciDato('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsString,'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
    //ricodifica schede riepilogative
    if R180Giorno(DallaData) = 1 then
      QRenProgTimb.SetVariable('DaData',DallaData)
    else
      QRenProgTimb.SetVariable('DaData',R180FineMese(DallaData) + 1);
    if AllaData = R180FineMese(AllaData) then
      QRenProgTimb.SetVariable('AData',AllaData)
    else
      QRenProgTimb.SetVariable('AData',R180InizioMese(AllaData) - 1);
    Tabella:='T073_SCHEDACAUSPRES';
    QRenProgTimb.SetVariable('Tabella',Tabella);
    try
      QRenProgTimb.Execute;
    except
      on E:Exception do
      begin
        Result:=False;
        s:=Format(A000MSG_B007_MSG_FMT_ERR_RICODIFICA_CAU,[Tabella]);
        RegistraMsg.InserisciMessaggio('A',s,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        RegistraMsg.InserisciMessaggio('A',E.Message,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
    end;
    RegistraLog.SettaProprieta('M',Tabella,NomeOwner,nil,True);
    RegistraLog.InserisciDato('CAUSALE',NewCausale,OldCausale);
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
    RegistraLog.InserisciDato('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsString,'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
    Tabella:='T074_CAUSPRESFASCE';
    QRenProgTimb.SetVariable('Tabella',Tabella);
    try
      QRenProgTimb.Execute;
    except
      on E:Exception do
      begin
        Result:=False;
        s:=Format(A000MSG_B007_MSG_FMT_ERR_RICODIFICA_CAU,[Tabella]);
        RegistraMsg.InserisciMessaggio('A',s,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        RegistraMsg.InserisciMessaggio('A',E.Message,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
    end;
    RegistraLog.SettaProprieta('M',Tabella,NomeOwner,nil,True);
    RegistraLog.InserisciDato('CAUSALE',NewCausale,OldCausale);
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
    RegistraLog.InserisciDato('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsString,'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
    //ricodifica residui
    QRenProgRes.SetVariable('Progressivo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    if (R180Giorno(DallaData) = 1) and (R180Mese(DallaData) = 1) then
      QRenProgRes.SetVariable('DaAnno',R180Anno(DallaData))
    else
      QRenProgRes.SetVariable('DaAnno',R180Anno(DallaData)+1);
    if (R180Giorno(AllaData) = 31) and (R180Mese(AllaData) = 12) then
      QRenProgRes.SetVariable('AAnno',R180Anno(AllaData))
    else
      QRenProgRes.SetVariable('AAnno',R180Anno(AllaData)-1);
    QRenProgRes.SetVariable('NewCausale',NewCausale);
    QRenProgRes.SetVariable('OldCausale',OldCausale);
    try
      QRenProgRes.Execute;
    except
      on E:Exception do
      begin
        Result:=False;
        s:=Format(A000MSG_B007_MSG_FMT_ERR_RICODIFICA_CAU,['T131_RESIDPRESENZE']);
        RegistraMsg.InserisciMessaggio('A',s,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        RegistraMsg.InserisciMessaggio('A',E.Message,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
    end;
    RegistraLog.SettaProprieta('M','T131_RESIDPRESENZE',NomeOwner,nil,True);
    RegistraLog.InserisciDato('CAUSALE',NewCausale,OldCausale);
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

function TB007FManipolazioneDatiMW.ElaborazioneCancellatabelleAnagDipendente: Boolean;
var
  s: String;
begin
  Result:=True;
  QDProg.Sql[1]:='From T030_ANAGRAFICO';
  QDProg.SetVariable('Progressivo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  try
    QDProg.Execute;
  except
    on E:Exception do
    begin
      Result:=False;
      s:=Format(A000MSG_B007_ERR_FMT_CANC_TAB,['T030_ANAGRAFICO']);
      RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end;

  QDProg.Sql[1]:='From T430_STORICO';
  QDProg.SetVariable('Progressivo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  try
    QDProg.Execute;
  except
    on E:Exception do
    begin
      Result:=False;
      s:=Format(A000MSG_B007_ERR_FMT_CANC_TAB,['T430_STORICO']);
      RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end;

  QDProg.Sql[1]:='From P430_ANAGRAFICO';
  QDProg.SetVariable('Progressivo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  try
    QDProg.Execute;
  except
    on E:Exception do
    begin
      Result:=False;
      s:=Format(A000MSG_B007_ERR_FMT_CANC_TAB,['P430_ANAGRAFICO']);
      RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end;

  RegistraLog.SettaProprieta('C','T030_ANAGRAFICO',NomeOwner,nil,True);
  RegistraLog.InserisciDato('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsString,'');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

function TB007FManipolazioneDatiMW.ElaborazioneCancellaTabellaDipendente(Tabella: String): Boolean;
var
  s: string;
begin
  Result:=True;
  QDProg.Sql[1]:='From ' + Tabella;
  QDProg.SetVariable('Progressivo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  try
    QDProg.Execute;
  except
    on E:Exception do
    begin
      Result:=False;
      s:=Format(A000MSG_B007_ERR_FMT_CANC_TAB,[Tabella]);
      RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end;
end;

//Non usare selAnagrafe perchè questa funzione prende i progressivi selezionati nella tabella
procedure TB007FManipolazioneDatiMW.ElaborazioneCancellaSchedaAnagDipendente(Progressivo:Integer);
begin
  QDProg.Sql[1]:='From T030_ANAGRAFICO';
  QDProg.SetVariable('Progressivo',Progressivo);
  QDProg.Execute;
  QDProg.Sql[1]:='From T430_STORICO';
  QDProg.SetVariable('Progressivo',Progressivo);
  QDProg.Execute;
  SessioneOracle.Commit;
end;

function TB007FManipolazioneDatiMW.ElaborazioneStoricizzaDipendente(ParametriStoricizzazione: TParametriStoricizzazione;var LMessaggi:TStringList):boolean;
var
  RecordAggiornati: Integer;
begin
  Result:=False;
  RecordAggiornati:=0;
  if ParametriStoricizzazione.bStorico then
    RecordAggiornati:=RecordAggiornati + ElaboraStorico(ParametriStoricizzazione, LMessaggi);
  RecordAggiornati:=RecordAggiornati + ElaboraAggiornamento(ParametriStoricizzazione,LMessaggi);
  ElaboraPeriodiStorici(ParametriStoricizzazione.PreparazioneStoricizzazione.NomeTabella,'',LMessaggi);
  Result:=RecordAggiornati > 0;
end;

procedure TB007FManipolazioneDatiMW.InserisciI020(NomeTabella,NomeCampo: String);
begin
  with insI020 do
  begin
    SetVariable('TABELLA',NomeTabella);
    SetVariable('COLONNA',NomeCampo);
    Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TB007FManipolazioneDatiMW.ImpostaCdsDipendenti;
begin
  selCols.Close;
  selCols.Open;
  cdsDipendenti.Close;
  cdsDipendenti.FieldDefs.Clear;
  cdsDipendenti.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
  cdsDipendenti.FieldDefs.Add('MATRICOLA',ftString,8,False);
  cdsDipendenti.FieldDefs.Add('COGNOME',ftString,30,False);
  cdsDipendenti.FieldDefs.Add('NOME',ftString,30,False);
  cdsDipendenti.FieldDefs.Add('INIZIO',ftDate,0,False);
  cdsDipendenti.FieldDefs.Add('FINE',ftDate,0,False);
  cdsDipendenti.IndexDefs.Clear;
  cdsDipendenti.IndexDefs.Add('Primario',('Cognome;Nome;Matricola;Progressivo'),[ixUnique]);
  cdsDipendenti.IndexName:='Primario';
  cdsDipendenti.CreateDataSet;
  cdsDipendenti.LogChanges:=False;
end;

procedure TB007FManipolazioneDatiMW.CreaCdsDipendentiUnificazione;
begin
  with cdsDipendentiUnificazione do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('T430PROGRESSIVO',ftInteger,0,False);
    FieldDefs.Add('MATRICOLA',ftString,8,False);
    FieldDefs.Add('COGNOME',ftString,30,False);
    FieldDefs.Add('NOME',ftString,30,False);
    FieldDefs.Add('T430INIZIO',ftDate,0,False);
    FieldDefs.Add('T430FINE',ftDate,0,False);
    CreateDataSet;
    LogChanges:=False;
    EmptyDataset;
    ImpostaDispLabelDipendentiUnificazione;
  end;
end;

procedure TB007FManipolazioneDatiMW.ImpostaDispLabelDipendentiUnificazione;
begin
  with cdsDipendentiUnificazione do
  begin
    FieldByName('T430PROGRESSIVO').DisplayLabel:='PROGRESSIVO';
    FieldByName('T430INIZIO').DisplayLabel:='INIZIO';
    FieldByName('T430FINE').DisplayLabel:='FINE';
  end;
end;

procedure TB007FManipolazioneDatiMW.CaricaCdsDipendentiSelSQL;
var
  s: String;
begin
  //Controllo progressivi presenti solo in T030 e non in T430
  selSQL.Close;
  selSQL.SQL.Clear;
  selSQL.SQL.Add('SELECT PROGRESSIVO FROM T030_ANAGRAFICO');
  selSQL.SQL.Add('MINUS');
  selSQL.SQL.Add('SELECT DISTINCT PROGRESSIVO FROM T430_STORICO');
  selSQL.Open;
  while not selSQL.Eof do
  begin
    if not cdsDipendenti.Locate('PROGRESSIVO',selSQL.FieldByName('PROGRESSIVO').AsInteger,[]) then
    begin
      cdsDipendenti.Append;
      cdsDipendenti.FieldByName('PROGRESSIVO').AsInteger:=selSQL.FieldByName('PROGRESSIVO').AsInteger;
      cdsDipendenti.FieldByName('MATRICOLA').AsString:='';
      cdsDipendenti.FieldByName('COGNOME').AsString:='';
      cdsDipendenti.FieldByName('NOME').AsString:='';
      cdsDipendenti.FieldByName('INIZIO').AsDateTime:=0;
      cdsDipendenti.FieldByName('FINE').AsDateTime:=0;
      cdsDipendenti.Post;
      s:=Format(A000MSG_B007_ERR_FMT_DIP_TAB,['T030_ANAGRAFICO','T430_STORICO',selSQL.FieldByName('PROGRESSIVO').AsString]);
      RegistraMsg.InserisciMessaggio('A',s,'',selSQL.FieldByName('PROGRESSIVO').AsInteger);
    end;
    selSQL.Next;
  end;
  //Controllo progressivi presenti solo in T430 e non in T030
  selSQL.Close;
  selSQL.SQL.Clear;
  selSQL.SQL.Add('SELECT DISTINCT PROGRESSIVO FROM T430_STORICO');
  selSQL.SQL.Add('MINUS');
  selSQL.SQL.Add('SELECT PROGRESSIVO FROM T030_ANAGRAFICO');
  selSQL.Open;
  while not selSQL.Eof do
  begin
    if not cdsDipendenti.Locate('PROGRESSIVO',selSQL.FieldByName('PROGRESSIVO').AsInteger,[]) then
    begin
      cdsDipendenti.Append;
      cdsDipendenti.FieldByName('PROGRESSIVO').AsInteger:=selSQL.FieldByName('PROGRESSIVO').AsInteger;
      cdsDipendenti.FieldByName('MATRICOLA').AsString:='';
      cdsDipendenti.FieldByName('COGNOME').AsString:='';
      cdsDipendenti.FieldByName('NOME').AsString:='';
      cdsDipendenti.FieldByName('INIZIO').AsDateTime:=0;
      cdsDipendenti.FieldByName('FINE').AsDateTime:=0;
      cdsDipendenti.Post;
      s:=Format(A000MSG_B007_ERR_FMT_DIP_TAB,['T430_STORICO','T030_ANAGRAFICO',selSQL.FieldByName('PROGRESSIVO').AsString]);
      RegistraMsg.InserisciMessaggio('A',s,'',selSQL.FieldByName('PROGRESSIVO').AsInteger);
    end;
    selSQL.Next;
  end;
  //Controllo progressivi presenti solo in P430 e non in T030
  selSQL.Close;
  selSQL.SQL.Clear;
  selSQL.SQL.Add('SELECT DISTINCT PROGRESSIVO FROM P430_ANAGRAFICO');
  selSQL.SQL.Add('MINUS');
  selSQL.SQL.Add('SELECT PROGRESSIVO FROM T030_ANAGRAFICO');
  selSQL.Open;
  while not selSQL.Eof do
  begin
    if not cdsDipendenti.Locate('PROGRESSIVO',selSQL.FieldByName('PROGRESSIVO').AsInteger,[]) then
    begin
      cdsDipendenti.Append;
      cdsDipendenti.FieldByName('PROGRESSIVO').AsInteger:=selSQL.FieldByName('PROGRESSIVO').AsInteger;
      cdsDipendenti.FieldByName('MATRICOLA').AsString:='';
      cdsDipendenti.FieldByName('COGNOME').AsString:='';
      cdsDipendenti.FieldByName('NOME').AsString:='';
      cdsDipendenti.FieldByName('INIZIO').AsDateTime:=0;
      cdsDipendenti.FieldByName('FINE').AsDateTime:=0;
      cdsDipendenti.Post;
      s:=Format(A000MSG_B007_ERR_FMT_DIP_TAB,['P430_ANAGRAFICO','T030_ANAGRAFICO',selSQL.FieldByName('PROGRESSIVO').AsString]);
      RegistraMsg.InserisciMessaggio('A',s,'',selSQL.FieldByName('PROGRESSIVO').AsInteger);
    end;
    selSQL.Next;
  end;
end;

procedure TB007FManipolazioneDatiMW.CaricaCdsDipendentiSelCols(bLogSchedeAnag:Boolean);
var
  Trovato:Boolean;
  Tab,s: String;
  ContaTab:Integer;
begin
  Trovato:=False;
  selCols.First;
  Tab:='';
  ContaTab:=0;
  while selCols.Eof do  //ciclo su ogni tabella
  begin
    selContaTabelle.SetVariable('TABELLA',selCols.FieldByName('TABELLA').AsString);
    selContaTabelle.SetVariable('PROG',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selContaTabelle.Execute;
    if StrToIntDef(VarToStr(selContaTabelle.Field(0)),0) > 0 then
    begin
      Trovato:=True;
      if (bLogSchedeAnag) and (ContaTab < 5) then
      begin
        if Trim(Tab) <> '' then
          Tab:=Tab + ',';
        Tab:=Tab + selCols.FieldByName('TABELLA').AsString;
        inc(ContaTab);
      end
      else
        Break;
    end;
    selCols.Next;
  end;

  if not Trovato then
  begin
    cdsDipendenti.Append;
    cdsDipendenti.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    cdsDipendenti.FieldByName('MATRICOLA').AsString:=SelAnagrafe.FieldByName('MATRICOLA').AsString;
    cdsDipendenti.FieldByName('COGNOME').AsString:=SelAnagrafe.FieldByName('COGNOME').AsString;
    cdsDipendenti.FieldByName('NOME').AsString:=SelAnagrafe.FieldByName('NOME').AsString;
    cdsDipendenti.FieldByName('INIZIO').AsDateTime:=SelAnagrafe.FieldByName('T430INIZIO').AsDateTime;
    cdsDipendenti.FieldByName('FINE').AsDateTime:=SelAnagrafe.FieldByName('T430FINE').AsDateTime;
    cdsDipendenti.Post;
    s:=Format(A000MSG_B007_ERR_FMT_DIP_NO_DATI,[SelAnagrafe.FieldByName('T430INIZIO').AsString,SelAnagrafe.FieldByName('T430FINE').AsString]);
    RegistraMsg.InserisciMessaggio('A',s,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  end;
  if bLogSchedeAnag then
  begin
    s:=Format(A000MSG_B007_MSG_FMT_TAB_DIPENDENTE,[Tab]);
    RegistraMsg.InserisciMessaggio('I',s,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  end;
end;

function TB007FManipolazioneDatiMW.ItemTabellaCancella(i: Integer): String;
begin
  //Result:=Format('%-40s <%s>',[TabelleCancella[i].Desc,TabelleCancella[i].Nome]);
  //I caratteri < > danno fastidio alle fantastiche checklist e advCheckGroup TMS. convertiti in [ ]
  Result:=Format('%-40s [%s]',[TabelleCancella[i].Desc,TabelleCancella[i].Nome]);
end;

function TB007FManipolazioneDatiMW.ElencoTabelleCancellaTotale: TStringList;
var
  i: Integer;
begin
  Result:=TStringList.Create;
  For i:=0 to high(TabelleCancella) do
    if not TabelleCancella[i].Dipe then
      Result.Add(ItemTabellaCancella(i));
  Result.Sort;
end;

function TB007FManipolazioneDatiMW.ElencoTabelleCancellaDipendente: TStringList;
var
  i: Integer;
begin
  Result:=TStringList.Create;
  For i:=0 to high(TabelleCancella) do
    if (TabelleCancella[i].Indiv) and (not TabelleCancella[i].Dipe) then
      Result.Add(ItemTabellaCancella(i));
  Result.Sort;
end;

procedure TB007FManipolazioneDatiMW.CicloBudget(AnnoDa,AnnoA: Integer);
begin
  QBadget.Open;
  QBadget.First;
  While not QBadget.Eof do
  begin
    QDAnno.Sql[1]:='From '+ QBadget.FieldByName('TABLE_NAME').AsString;
    QDAnno.SetVariable('DaAnno',AnnoDa);
    QDAnno.SetVariable('AAnno',AnnoA);
    QDAnno.Execute;
    QBadget.Next;
  end;
  QBadget.Close;
end;

procedure TB007FManipolazioneDatiMW.CancellaBudget(MeseDa, MeseA, AnnoDa, AnnoA: Integer);
begin
  // Cancellazione tabella T710_BudgetAnnuo
  QDAnno.Sql[1]:='From T710_BudgetAnnuo';
  QDAnno.SetVariable('DaAnno',AnnoDa);
  QDAnno.SetVariable('AAnno',AnnoA);
  QDAnno.Execute;

  // cancellazione di tutte le tabelle T711Budget*
  QBadget.Sql.Clear;
  QBadget.Sql.Add('select table_name from all_tables');
  QBadget.Sql.Add('where SUBSTR(TABLE_NAME,1,11)=''T711_BUDGET''');
  CicloBudget(AnnoDa, AnnoA);

  // cancellazione di tutte le tabelle T712Budget*
  QBadget.Sql.Clear;
  QBadget.Sql.Add('select table_name from all_tables');
  QBadget.Sql.Add('where SUBSTR(TABLE_NAME,1,11)=''T712_BUDGET''');
  CicloBudget(AnnoDa, AnnoA);

  // cancellazione di T720_Budgetmensile
  QDMeseAnno.Sql[1]:='From T720_Budgetmensile';
  QDMeseAnno.SetVariable('DaAnno',AnnoDa);
  QDMeseAnno.SetVariable('AAnno',AnnoA);
  QDMeseAnno.SetVariable('DaMese',MeseDa);
  QDMeseAnno.SetVariable('AMese',MeseA);
  QDMeseAnno.Execute;

  // Registrazione su file di log
  RegistraLog.SettaProprieta('C','T710_BUDGETANNUO',NomeOwner,nil,True);
  RegistraLog.InserisciDato('ANNO',IntToStr(AnnoDa),'');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

function TB007FManipolazioneDatiMW.InizializzaTempo(DallaData, AllaData: TDateTime): TTempoCancellazione;
var datain: string;
begin
  datain:=FormatDateTime('dd/mm/yyyy',DallaData);
  if FormatDateTime('d',DallaData) <> '1' then
  begin
    datain:='01' + Copy(datain,3,8);
    Result.DaDataMese:=StrToDate(datain);
    Result.DaDataMese:=Result.DaDataMese + R180GiorniMese(Result.DaDataMese);
  end
  else
    Result.DaDataMese:=DallaData;

  Result.ADataMese:=AllaData;
  if R180GiorniMese(Result.ADataMese)>StrToInt(FormatDateTime('d',Result.ADataMese)) then
  begin
    datain:=FormatDateTime('dd/mm/yyyy',Result.ADataMese);
    datain:='01'+Copy(datain,3,8);
    Result.ADataMese:=StrToDate(datain)-1;
  end;

  if Result.ADataMese - Result.DaDataMese + 1 < R180GiorniMese(Result.DaDataMese) then
    Result.MeseOk:=False
  else
    Result.MeseOk:=True;
  Result.DaMese:=StrToInt(FormatDateTime('m',Result.DaDataMese));
  Result.AMese:=StrToInt(FormatDateTime('m',Result.ADataMese));
  Result.DaAnMe:=StrToInt(FormatDateTime('yyyy',Result.DaDataMese));
  Result.DaAnno:=Result.DaAnMe;
  Result.AAnMe:=StrToInt(FormatDateTime('yyyy',Result.ADataMese));
  Result.AAnno:=Result.AAnMe;
  if Result.DaMese <> 1 then
    Result.DaAnno:=Result.DaAnno + 1;
  if Result.AMese <> 12 then
    Result.AAnno:=Result.AAnno - 1;
  if Result.AAnno >= Result.DaAnno then
    Result.AnnoOk:=True
  else
    Result.AnnoOk:=False;
end;

function TB007FManipolazioneDatiMW.IsBudgetAnno(indice: Integer): boolean;
begin
  Result:=(TabelleCancella[indice].Nome = 'T710_BUDGETANNUO');
end;

function TB007FManipolazioneDatiMW.IsSchedaRiepil(indice: Integer): boolean;
begin
  Result:=(TabelleCancella[indice].Nome='T070_SCHEDARIEPIL');
end;

function TB007FManipolazioneDatiMW.IsGiustificativi(indice: Integer): boolean;
begin
  Result:=(TabelleCancella[indice].Nome='T040_GIUSTIFICATIVI');
end;

procedure TB007FManipolazioneDatiMW.CancellaSchedaRiepil(DaDataMese, ADataMese: TDateTime);
begin
  QDData.Sql[1]:='From T070_SCHEDARIEPIL';
  QDData.Sql[3]:='DATA >= :DADATA AND';
  QDData.Sql[4]:='DATA < :ADATA + 1';
  QDData.SetVariable('DaData',DaDataMese);
  QDData.SetVariable('AData',ADataMese);

  QDData.Execute;
  QDData.Sql[1]:='From T071_SCHEDAFASCE';
  QDData.Execute;
  QDData.Sql[1]:='From T072_SCHEDAINDPRES';
  QDData.Execute;
  QDData.Sql[1]:='From T073_SCHEDACAUSPRES';
  QDData.Execute;
  QDData.Sql[1]:='From T074_CAUSPRESFASCE';
  QDData.Execute;
  QDData.Sql[1]:='From T075_STRESTERNO';
  QDData.Execute;
  QDData.Sql[1]:='From T076_CAUSPRESPAGHE';
  QDData.Execute;
  RegistraLog.SettaProprieta('C','T070_SCHEDARIEPIL',NomeOwner,nil,True);
  RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DaDataMese),DateToStr(ADataMese)]),'');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TB007FManipolazioneDatiMW.CancellaSchedaRiepilDipendente(DaDataMese, ADataMese: TDateTime);
begin
  QDProgData.Sql[3]:='DATA >= :DADATA AND';
  QDProgData.Sql[4]:='DATA < :ADATA + 1';
  QDProgData.SetVariable('DaData',DaDataMese);
  QDProgData.SetVariable('AData',ADataMese);

  QDProgData.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  QDProgData.Sql[1]:='From T070_SCHEDARIEPIL';
  QDProgData.Execute;
  QDProgData.Sql[1]:='From T071_SCHEDAFASCE';
  QDProgData.Execute;
  QDProgData.Sql[1]:='From T072_SCHEDAINDPRES';
  QDProgData.Execute;
  QDProgData.Sql[1]:='From T073_SCHEDACAUSPRES';
  QDProgData.Execute;
  QDProgData.Sql[1]:='From T074_CAUSPRESFASCE';
  QDProgData.Execute;
  QDProgData.Sql[1]:='From T075_STRESTERNO';
  QDProgData.Execute;
  QDProgData.Sql[1]:='From T076_CAUSPRESPAGHE';
  QDProgData.Execute;
  RegistraLog.SettaProprieta('C','T070_SCHEDARIEPIL',Copy(Self.Name,1,4),nil,True);
  RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DaDataMese),DateToStr(ADataMese)]),'');
  RegistraLog.InserisciDato('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsString,'');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TB007FManipolazioneDatiMW.CancellaDatiGiustif(DallaData, AllaData: TDateTime);
begin
  // Cancellazione tabella T040_Giustificativi
  CancAssenze.SetVariable('D1',DallaData);
  CancAssenze.SetVariable('D2',AllaData);
  CancAssenze.SetVariable('P',0);
  CancAssenze.SetVariable('C','');
  CancAssenze.Execute;
  RegistraLog.SettaProprieta('C','T040_GIUSTIFICATIVI',NomeOwner,nil,True);
  RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TB007FManipolazioneDatiMW.CancellaDatiGiustifDipendente(DallaData, AllaData: TDateTime);
begin
  CancAssenze.SetVariable('D1',DallaData);
  CancAssenze.SetVariable('D2',AllaData);
  CancAssenze.SetVariable('P',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  CancAssenze.SetVariable('C','');
  CancAssenze.Execute;
  RegistraLog.SettaProprieta('C','T040_GIUSTIFICATIVI',NomeOwner,nil,True);
  RegistraLog.InserisciDato('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsString,'');
  RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TB007FManipolazioneDatiMW.CancellaCodiceGiustifProg(Codice: String; DallaData, AllaData: TDateTime; Progressivo: Integer);
begin
  CancAssenze.SetVariable('D1',DallaData);
  CancAssenze.SetVariable('D2',AllaData);
  CancAssenze.SetVariable('P',Progressivo);
  CancAssenze.SetVariable('C',Codice);
  CancAssenze.Execute;

  RegistraLog.SettaProprieta('C','T040_GIUSTIFICATIVI',NomeOwner,nil,True);
  RegistraLog.InserisciDato('CODICE',Codice,'');
  if Progressivo > 0 then
    RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(Progressivo),'');
  RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TB007FManipolazioneDatiMW.CancellaMesi(Indice: Integer;tempoCancellazione: TtempoCancellazione);
begin
  QDMeseAnno.Sql[1]:='From ' + TabelleCancella[indice].Nome;
  QDMeseAnno.SetVariable('DaAnno',tempoCancellazione.DaAnMe);
  QDMeseAnno.SetVariable('AAnno',tempoCancellazione.AAnMe);
  QDMeseAnno.SetVariable('DaMese',tempoCancellazione.DaMese);
  QDMeseAnno.SetVariable('AMese',tempoCancellazione.AMese);
  QDMeseAnno.Execute;
  if TabelleCancella[indice].Log then
  begin
    RegistraLog.SettaProprieta('C',TabelleCancella[indice].Nome,NomeOwner,nil,True);
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(EncodeDate(tempoCancellazione.DaAnMe,tempoCancellazione.DaMese,1)),DateToStr(EncodeDate(tempoCancellazione.AAnMe,tempoCancellazione.AMese,1))]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

procedure TB007FManipolazioneDatiMW.CancellaMesiDipendente(Indice: Integer; tempoCancellazione: TtempoCancellazione);
begin
  QDProgMeseAnno.Sql[1]:='From ' + TabelleCancella[indice].Nome;
  QDProgMeseAnno.SetVariable('DaAnno',tempoCancellazione.DaAnMe);
  QDProgMeseAnno.SetVariable('AAnno',tempoCancellazione.AAnMe);
  QDProgMeseAnno.SetVariable('DaMese',tempoCancellazione.DaMese);
  QDProgMeseAnno.SetVariable('AMese',tempoCancellazione.AMese);

  QDProgMeseAnno.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  QDProgMeseAnno.Execute;
  if TabelleCancella[indice].Log then
  begin
    RegistraLog.SettaProprieta('C',TabelleCancella[indice].Nome,NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsString,'');
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(EncodeDate(tempoCancellazione.DaAnMe,tempoCancellazione.DaMese,1)),DateToStr(EncodeDate(tempoCancellazione.AAnMe,tempoCancellazione.AMese,1))]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

procedure TB007FManipolazioneDatiMW.CancellaAnni(Indice: Integer; tempoCancellazione: TtempoCancellazione);
begin
  QDAnno.Sql[1]:='From ' + TabelleCancella[indice].Nome;
  QDAnno.SetVariable('DaAnno',tempoCancellazione.DaAnno);
  QDAnno.SetVariable('AAnno',tempoCancellazione.AAnno);
  QDAnno.Execute;
  if TabelleCancella[indice].Log then
  begin
    RegistraLog.SettaProprieta('C',TabelleCancella[indice].Nome,NomeOwner,nil,True);
    RegistraLog.InserisciDato('DA - A',Format('%d - %d',[tempoCancellazione.DaAnno,tempoCancellazione.AAnno]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

procedure TB007FManipolazioneDatiMW.CancellaAnniDipendente(Indice: Integer; tempoCancellazione: TtempoCancellazione);
begin
  QDProgAnno.Sql[1]:='From ' + TabelleCancella[indice].Nome;
  QDProgAnno.SetVariable('DaAnno',tempoCancellazione.DaAnno);
  QDProgAnno.SetVariable('AAnno',tempoCancellazione.AAnno);

  QDProgAnno.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  QDProgAnno.Execute;
  if TabelleCancella[indice].Log then
  begin
    RegistraLog.SettaProprieta('C',TabelleCancella[indice].Nome,NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsString,'');
    RegistraLog.InserisciDato('DA - A',Format('%d - %d',[tempoCancellazione.DaAnno,tempoCancellazione.AAnno]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

function TB007FManipolazioneDatiMW.CampiDaData(Indice: Integer): String;
begin
  if TabelleCancella[indice].Campi='' then
  begin
    Result:='DATA>=:DADATA AND';
  end
  else
  begin
    Result:=TabelleCancella[indice].Campi+'>=:DADATA AND';
  end;
end;

function TB007FManipolazioneDatiMW.CampiAData(Indice: Integer): String;
begin
  if TabelleCancella[indice].Campi='' then
  begin
    Result:='DATA<=TO_DATE(TO_CHAR(:ADATA,''DD/MM/YYYY'')||''2359'',''DD/MM/YYYYHH24MI'')';
  end
  else
  begin
    Result:=TabelleCancella[indice].Campi+'<=TO_DATE(TO_CHAR(:ADATA,''DD/MM/YYYY'')||''2359'',''DD/MM/YYYYHH24MI'')';
  end;
end;

procedure TB007FManipolazioneDatiMW.CancellaDate(indice: Integer; DallaData, AllaData:TDateTime; tempoCancellazione: TtempoCancellazione);
begin
  QDData.Sql[1]:='From '+TabelleCancella[indice].Nome;
  QDData.Sql[3]:=CampiDaData(indice);
  QDData.Sql[4]:=CampiAData(indice);
  if TabelleCancella[indice].Peri='E' then
  begin
    QDData.SetVariable('DaData',tempoCancellazione.DaDataMese);
    QDData.SetVariable('AData',tempoCancellazione.ADataMese);
  end
  else
  begin
    QDData.SetVariable('DaData',DallaData);
    QDData.SetVariable('AData',AllaData);
  end;
  QDData.Execute;
  if TabelleCancella[indice].Log then
  begin
    RegistraLog.SettaProprieta('C',TabelleCancella[indice].Nome,NomeOwner,nil,True);
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

procedure TB007FManipolazioneDatiMW.CancellaDateDipendente(indice: Integer; DallaData, AllaData:TDateTime; tempoCancellazione: TtempoCancellazione);
begin
  QDProgData.Sql[1]:='From ' + TabelleCancella[indice].Nome;
  QDProgData.Sql[3]:=CampiDaData(indice);
  QDProgData.Sql[4]:=CampiAData(indice);
  if TabelleCancella[indice].Peri = 'E' then
  begin
    QDProgData.SetVariable('DaData',tempoCancellazione.DaDataMese);
    QDProgData.SetVariable('AData',tempoCancellazione.ADataMese);
  end
  else
  begin
    QDProgData.SetVariable('DaData',DallaData);
    QDProgData.SetVariable('AData',AllaData);
  end;

  QDProgData.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  QDProgData.Execute;
  if TabelleCancella[indice].Log then
  begin
    RegistraLog.SettaProprieta('C',TabelleCancella[indice].Nome,NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsString,'');
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

procedure TB007FManipolazioneDatiMW.CancellaDaA(indice: Integer; DallaData, AllaData: TDateTime);
begin
  QDDaA.Sql[1]:='From ' + TabelleCancella[indice].Nome;
  QDDaA.SetVariable('DaData',DallaData);
  QDDaA.SetVariable('AData',AllaData);
  QDDaA.Execute;
  if TabelleCancella[indice].Log then
  begin
    RegistraLog.SettaProprieta('C',TabelleCancella[indice].Nome,NomeOwner,nil,True);
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

procedure TB007FManipolazioneDatiMW.CancellaDaADipendente(indice: Integer; DallaData, AllaData: TDateTime);
begin
  QDProgDaA.Sql[1]:='From ' + TabelleCancella[indice].Nome;
  QDProgDaA.SetVariable('DaData',DallaData);
  QDProgDaA.SetVariable('AData',AllaData);

  QDProgDaA.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  QDProgDaA.Execute;
  if TabelleCancella[indice].Log then
  begin
    RegistraLog.SettaProprieta('C',TabelleCancella[indice].Nome,NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsString,'');
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

procedure TB007FManipolazioneDatiMW.DataModuleDestroy(Sender: TObject);
begin
  selI010.Close;
  selQ265.Close;
  selQ275.Close;
  selT265TesteCatena.Close;
  FreeAndNil(selI010);
  FreeAndNil(MyCestino);
  inherited;
end;

function TB007FManipolazioneDatiMW.ListaTesteCatena: TElencoValoriChecklist;
var
  codice: String;
begin
  Result:=TElencoValoriChecklist.Create;
  with selT265TesteCatena do
  begin
    First;
    while not Eof do
    begin
      codice:=FieldByName('Codice').AsString;
      Result.lstCodice.Add(codice);
      Result.lstDescrizione.Add(Format('%-5s %s',[codice, FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;

function TB007FManipolazioneDatiMW.ListaDatiAnagraficiUnificazione: TElencoValoriChecklist;
var
  s: string;
  codice: string;
begin
  Result:=TElencoValoriChecklist.Create;
  //serve per cloud. per win già fatto in tab change, ma non crea problemi reimpostarlo
  selI010.Filter:='';
  selI010.Filtered:=False;

  selI010.First;
  while not selI010.Eof do
  begin
    s:='';
    if selI010.FieldByName('Tabella').AsString = 'T430_STORICO' then
      s:='T430'
    else if selI010.FieldByName('Tabella').AsString = 'P430_ANAGRAFICO' then
      s:='P430';

    codice:=s + selI010.FieldByName('NOME_CAMPO').AsString;
    Result.lstCodice.Add(codice);
    Result.lstDescrizione.Add(Format('%-40s %s',[codice, '(' + selI010.FieldByName('NOME_LOGICO').AsString + ')']));
    selI010.Next;
  end;
end;

procedure TB007FManipolazioneDatiMW.CaricaElencoUnificazioneMatr(DatiAnag:String);
var
  LDati: TStringList;
  Filtro: String;
  i:Integer;
begin
  //Caratto 12/09/2014 Prima usava C700DataLavoro al posto di parametri.DataLavoro.
  //In unificazione matricole le date sono bloccate. se entro e vado subito nel tab unificazione matricole
  // C700DataLavoro è impostato con AllaData , ovvero datalavoro.
  //se faccio prima altre elaborazioni cambiando le date, C700DataLavoro sarebbe il valore indicato
  //in allaData...ma non è modificabile e non sarebbe giusto
  selV430.Close;
  selV430.SetVariable('CAMPI',DatiAnag);
  selV430.SetVariable('FILTRO',' AND TO_DATE(''' + DateToStr(Parametri.DataLavoro) + ''',''DD/MM/YYYY'') BETWEEN T430DATADECORRENZA AND T430DATAFINE' +
    ' AND T030.PROGRESSIVO = ' + selAnagrafe.FieldByName('PROGRESSIVO').AsString);
  selV430.Open;
  LDati:=TStringList.Create;
  LDati.Clear;
  LDati.CommaText:=DatiAnag;
  Filtro:=' AND T030.PROGRESSIVO <> ' + selAnagrafe.FieldByName('PROGRESSIVO').AsString;
  Filtro:=Filtro + ' AND TO_DATE(''' + DateToStr(Parametri.DataLavoro) + ''',''DD/MM/YYYY'') BETWEEN T430DATADECORRENZA AND T430DATAFINE';
  for i:=0 to LDati.Count -1 do
    Filtro:=Filtro + ' AND TO_CHAR(' + LDati.Strings[i] + ') = ''' + selV430.FieldByName(LDati.Strings[i]).AsString + '''';
  selV430.Close;
  selV430.SetVariable('CAMPI','T430PROGRESSIVO,MATRICOLA,COGNOME,NOME,T430INIZIO,T430FINE');
  selV430.SetVariable('FILTRO',Filtro);
  selV430.Open;
//    selV430.Filter:='(T430DATADECORRENZA <= ''' + DateToStr(C700DataLavoro) + ''') AND ' +
//                    '(T430DATAFINE >= ''' + DateToStr(C700DataLavoro) + ''')';
//    selV430.Filtered:=True;
  with TDataSetProvider.Create(nil) do
  try
    cdsDipendentiUnificazione.Close;
    DataSet:=selV430;
    cdsDipendentiUnificazione.Data:=Data;
    ImpostaDispLabelDipendentiUnificazione;
  finally
    Free;
  end;
  FreeAndNil(LDati);
end;

procedure TB007FManipolazioneDatiMW.PulisciTab(Tabella:String;Progressivo:Integer);
var
  s: string;
begin
  QDProg.Sql[1]:='From ' + Tabella;
  QDProg.SetVariable('Progressivo',Progressivo);
  try
    QDProg.Execute;
  except
    on E: Exception do
    begin
      s:=Format(A000MSG_B007_MSG_FMT_CANC_ERRORE,[Tabella,E.Message]);
      RegistraMsg.InserisciMessaggio('A',s,'',Progressivo);
    end;
  end;
end;

procedure TB007FManipolazioneDatiMW.UnificazioneMatricolaDip(OldProgressivo:Integer);
var
  Anom: Boolean;
  s: String;
  DDec: TDateTime;
  DFine: TDateTime;
  BookselPeriodi: TBookmark;
  i: Integer;
begin
  Anom:=False;
  // -------------------------- Controlli ------------------------------
  QSQL.SQL.Clear;
  QSQL.SQL.Add('SELECT COUNT(*) FROM');
  QSQL.SQL.Add('(select distinct INIZIO, NVL(FINE,TO_DATE(''31123999'',''DDMMYYYY'')) FINE');
  QSQL.SQL.Add('   from t430_storico');
  QSQL.SQL.Add('  where PROGRESSIVO = ' + IntToStr(OldProgressivo) + ') A,');
  QSQL.SQL.Add('(select distinct INIZIO, NVL(FINE,TO_DATE(''31123999'',''DDMMYYYY'')) FINE');
  QSQL.SQL.Add('   from t430_storico');
  QSQL.SQL.Add('  where PROGRESSIVO = ' + selAnagrafe.FieldByName('PROGRESSIVO').AsString + ') B');
  QSQL.SQL.Add('WHERE A.INIZIO <= B.FINE');
  QSQL.SQL.Add('  AND A.FINE >= B.INIZIO');
  QSQL.Execute;
  if StrToIntDef(VarToStr(QSQL.Field(0)),0) > 0 then
  begin
    Anom:=True;
    s:=A000MSG_B007_MSG_UNIF_PERIODI_INTERSECANTI;
    RegistraMsg.InserisciMessaggio('A',s,'',OldProgressivo);
  end;
  if not Anom then
  begin
    QSQL.SQL.Clear;
    QSQL.SQL.Add('SELECT P441.DATA_CEDOLINO, P441.DATA_RETRIBUZIONE FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442 ');
    QSQL.SQL.Add('WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO ');
    QSQL.SQL.Add('  AND P441.PROGRESSIVO = ' + IntToStr(OldProgressivo));
    QSQL.SQL.Add('  AND P442.ORIGINE IN (''P'',''C'')');

    QSQL.SQL.Add('  AND EXISTS');
    QSQL.SQL.Add('  (SELECT ''X'' FROM P441_CEDOLINO P441A WHERE P441A.PROGRESSIVO = ' + selAnagrafe.FieldByName('PROGRESSIVO').AsString);
    QSQL.SQL.Add('  AND TO_CHAR(P441A.DATA_CEDOLINO,''YYYY'') = TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ');
    QSQL.SQL.Add('ORDER BY P441.DATA_CEDOLINO');
    QSQL.Execute;
    if QSQL.RowsProcessed > 0 then
    begin
      Anom:=True;
      s:=Format(A000MSG_B007_MSG_UNIF_PRESENZA_442,[VarToStr(QSQL.Field(0)),VarToStr(QSQL.Field(1))]);
      RegistraMsg.InserisciMessaggio('A',s,'',OldProgressivo);
    end;
  end;
  if not Anom then
  begin
    QSQL.SQL.Clear;
    QSQL.SQL.Add('SELECT ANNO FROM P504_CUDTESTATE ');
    QSQL.SQL.Add('WHERE PROGRESSIVO = ' + IntToStr(OldProgressivo));
    QSQL.SQL.Add('  AND ANNO IN ');
    QSQL.SQL.Add('    (SELECT ANNO FROM P504_CUDTESTATE ');
    QSQL.SQL.Add('      WHERE PROGRESSIVO = ' + selAnagrafe.FieldByName('PROGRESSIVO').AsString + ')');
    QSQL.SQL.Add('ORDER BY ANNO');
    QSQL.Execute;
    if QSQL.RowsProcessed > 0 then
    begin
      Anom:=True;
      s:=Format(A000MSG_B007_MSG_FMT_UNIF_ANNO,[VarToStr(QSQL.Field(0))]);
      RegistraMsg.InserisciMessaggio('A',s,'',OldProgressivo);
    end;
  end;
  if not Anom then
  begin
    selP441.Close;
    selP441.SetVariable('OLD',OldProgressivo);
    selP441.Open;
    while (not selP441.Eof) and (not Anom) do  //Ciclo sui cedolini del vecchio dip.
    begin
      QSQL.SQL.Clear; //Verifico se sul nuovo dip. esiste già lo stesso cedolino
      QSQL.SQL.Add('SELECT ID_CEDOLINO FROM P441_CEDOLINO P441 ');
      QSQL.SQL.Add('WHERE PROGRESSIVO = ' + selAnagrafe.FieldByName('PROGRESSIVO').AsString);
      QSQL.SQL.Add('  AND TIPO_CEDOLINO = ''' + selP441.FieldByName('TIPO_CEDOLINO').AsString + '''');
      QSQL.SQL.Add('  AND DATA_CEDOLINO = TO_DATE(''' + selP441.FieldByName('DATA_CEDOLINO').AsString + ''',''DD/MM/YYYY'')');
      QSQL.SQL.Add('  AND DATA_RETRIBUZIONE = TO_DATE(''' + selP441.FieldByName('DATA_RETRIBUZIONE').AsString + ''',''DD/MM/YYYY'')');
      QSQL.SQL.Add('ORDER BY DATA_CEDOLINO');
      QSQL.Execute;
      if QSQL.RowsProcessed <= 0 then //non esiste ancora --> aggiorno il progressivo di P441 con il nuovo
      begin
        selP441.Edit;
        selP441.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
        selP441.Post;
        selP441.Next;
      end
      else if QSQL.RowsProcessed > 0 then  //esiste già
      begin
        selP442.Close; //Controllo i record di P442 origine 'P' o 'C' per la nuova matr.
        selP442.SetVariable('ID',StrToIntDef(VarToStr(QSQL.Field(0)),0));
        selP442.Open;
        selP442.Filter:='(ORIGINE = ''P'') OR (ORIGINE = ''C'')';
        selP442.Filtered:=True;
        if selP442.RecordCount > 0 then  //esistono record P o C sulla matr. new
        begin
          Anom:=True;
          s:=Format(A000MSG_B007_MSG_FMT_UNIF_PRESENZA_441,[selP441.FieldByName('DATA_CEDOLINO').AsString,
                                                            selP441.FieldByName('DATA_RETRIBUZIONE').AsString,
                                                            selP441.FieldByName('TIPO_CEDOLINO').AsString]);
          RegistraMsg.InserisciMessaggio('A',s,'',OldProgressivo);
        end
        else
        begin
          selP442.Filtered:=False;
          selP442.Filter:='';
          selP442.Close; //Controllo i record di P442 origine 'P' o 'C' per la vecchia matr.
          selP442.SetVariable('ID',selP441.FieldByName('ID_CEDOLINO').AsInteger);
          selP442.Open;
          while not selP442.Eof do
          begin
            selP442.Edit;
            selP442.FieldByName('ID_CEDOLINO').AsInteger:=StrToIntDef(VarToStr(QSQL.Field(0)),0);
            selP442.Post;
            selP442.Next;
          end;
          //Cancellare P441
          selP441.Delete;
        end;
      end;
    end; //fine ciclo P441
  end;

  // -------------------------- Inizio aggiornamento tabelle legate a PROGRESSIVO ------------------------------
  if not Anom then
  begin
    selCols.Close;
    selCols.Open;
    while (not selCols.Eof) and (not Anom) do  //ciclo su ogni tabella legata a PROGRESSIVO
    begin
      if (selCols.FieldByName('TABELLA').AsString = 'P254_VOCIPROGRAMMATE') then
      begin  //Se il dip.old è cessato chiudo le date fine vuote
        QSQL.SQL.Clear;
        QSQL.SQL.Add('SELECT MAX(NVL(FINE,TO_DATE(''31/12/3999'',''DD/MM/YYYY''))) FINE FROM T430_STORICO');
        QSQL.SQL.Add('WHERE PROGRESSIVO = ' + IntToStr(OldProgressivo));
        QSQL.Execute;
        s:='';
        if QSQL.RowsProcessed > 0 then
          s:=DateToStr(R180FineMese(StrToDate(VarToStr(VarToStr(QSQL.Field(0))))));
        QSQL.SQL.Clear;
        QSQL.SQL.Add('UPDATE P254_VOCIPROGRAMMATE');
        QSQL.SQL.Add('   SET PROGRESSIVO = ' + selAnagrafe.FieldByName('PROGRESSIVO').AsString);
        if (s <> '') and (StrToDate(s) < Parametri.DataLavoro) then
          QSQL.SQL.Add('    , DATA_FINE = NVL(DATA_FINE,TO_DATE(''' + s + ''',''DD/MM/YYYY''))');
        QSQL.SQL.Add(' WHERE PROGRESSIVO = ' + IntToStr(OldProgressivo));
        try
          QSQL.Execute;
        except
          on E: Exception do
          begin
            Anom:=True;
            s:=Format(A000MSG_B007_MSG_FMT_ERR_254,[E.Message]);
            RegistraMsg.InserisciMessaggio('A',s,'',OldProgressivo);
          end;
        end;
      end;
      if (selCols.FieldByName('TABELLA').AsString <> 'P272_RETRIBUZIONE_CONTRATTUALE') and
         (selCols.FieldByName('TABELLA').AsString <> 'P280_SERVIZIPENSPREV') and
         (selCols.FieldByName('TABELLA').AsString <> 'P282_PERIODIRETR') and
         (selCols.FieldByName('TABELLA').AsString <> 'P284_IMPORTIRETR') and
         (selCols.FieldByName('TABELLA').AsString <> 'P430_APPOGGIO') and
         (selCols.FieldByName('TABELLA').AsString <> 'P440_CEDOLINOSTATO') and
         (selCols.FieldByName('TABELLA').AsString <> 'P441_CEDOLINO') and   //già gestito prima
         (selCols.FieldByName('TABELLA').AsString <> 'P445_CEDOLINOTEMP') and
         (selCols.FieldByName('TABELLA').AsString <> 'P254_VOCIPROGRAMMATE') and //già gestito prima
         (selCols.FieldByName('TABELLA').AsString <> 'P593_CONTABDATIINDIVIDUALI') then
      begin
        updTabelle.SetVariable('TABELLA',selCols.FieldByName('TABELLA').AsString);
        updTabelle.SetVariable('PROGOLD',OldProgressivo);
        updTabelle.SetVariable('PROGNEW',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        try
          updTabelle.Execute;
        except
          on E: Exception do
          begin
            Anom:=True;
            s:='Unificazione fallita: ' + 'aggiornamento ' + selCols.FieldByName('TABELLA').AsString + ' terminato con errore ' + E.Message;
            RegistraMsg.InserisciMessaggio('A',s,'',OldProgressivo);
          end;
        end;
      end;
      selCols.Next;
    end;
    // -------------------------- Fine aggiornamento tabelle legate a PROGRESSIVO ------------------------------

    // -- Unificare periodi di rapporto: verifico se esistono periodi di servizio non esistenti sul prog. di partenza
    if not Anom then
    begin
      selPeriodi.Close;
      selPeriodi.SetVariable('PROG',OldProgressivo);
      selPeriodi.SetVariable('PROGPARTENZA',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      selPeriodi.Open;
      while not selPeriodi.Eof do  //Ciclo sui periodi di servizio
      begin
        selT430.Close;
        selT430.SetVariable('PROGRESSIVO',OldProgressivo);
        selT430.SetVariable('INIZIO',selPeriodi.FieldByName('INIZIO').AsDateTime);
        selT430.Open;
        while not selT430.Eof do  //ciclo sui periodi di T430 contenenti l'attuale periodo di servizio
        begin
          //creo periodo storico e aggiorno
          DDec:=Max(selT430.FieldByName('DATADECORRENZA').AsDateTime,selT430.FieldByName('INIZIO').AsDateTime);
          DFine:=selT430.FieldByName('FINE').AsDateTime;
          if DFine <= 0 then
            DFine:=StrToDate('31/12/3999');
          DFine:=Min(selT430.FieldByName('DATAFINE').AsDateTime,DFine);
          //Cerco la prima decorrenza per il progressivo destinatario successiva alla
          //fine del nuovo periodo da importare
          selT430Dec.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          selT430Dec.SetVariable('DATAFINE',DFine);
          selT430Dec.Open;
          //Se esiste decorrenza successiva per il progressivo destinatario..
          if not selT430Dec.Eof then
          begin
            if selPeriodi.RecNo < selPeriodi.RecordCount then
            begin
              BookselPeriodi:=selPeriodi.GetBookmark;
              { TODO : TEST IW 15 }
              try
                selPeriodi.Next;
                //..e non ci periodi di rapporto successivi da importare inferiori
                //alla decorrenza del dipendente destinatario uso la
                //maggiore tra data fine già calcolata e decorrenza - 1
                if selPeriodi.FieldByName('INIZIO').AsDateTime > selT430Dec.FieldByName('DATADECORRENZA').AsDateTime then
                  DFine:=Max(DFine,selT430Dec.FieldByName('DATADECORRENZA').AsDateTime - 1);
                selPeriodi.GotoBookMark(BookselPeriodi);
              finally
                //caratto 15/09/2014 mancava free bookmark fin dalla preistoria
                selPeriodi.FreeBookmark(BookselPeriodi);
              end;
            end;
            //..e non ci periodi di rapporto successivi da importare uso la
            //maggiore tra data fine già calcolata e decorrenza - 1
            if selPeriodi.RecNo = selPeriodi.RecordCount then
              DFine:=Max(DFine,selT430Dec.FieldByName('DATADECORRENZA').AsDateTime - 1);
          end;
          CreazioneStorico.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          CreazioneStorico.SetVariable('DADATA',DDec);
          if DFine >= StrToDate('31/12/3999') then
            CreazioneStorico.SetVariable('ADATA',null)
          else
            CreazioneStorico.SetVariable('ADATA',DFine);
          try
            CreazioneStorico.Execute;
          except
            on E: Exception do
            begin
              Anom:=True;
              s:=Format(A000MSG_B007_MSG_FMT_PERIODO_STORICO,[DateToStr(DDec),DateToStr(DFine),E.Message]);
              RegistraMsg.InserisciMessaggio('A',s,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            end;
          end;
          if not Anom then
          begin
            //La data fine periodi storici da aggiornare viene impostata come la
            //maggiore tra quella già fin qui calcolata e la data assunzione periodo
            //di servizio successivo -1
            if selPeriodi.RecNo < selPeriodi.RecordCount then
            begin
              { TODO : TEST IW 15 }
              BookselPeriodi:=selPeriodi.GetBookmark;
              try
                selPeriodi.Next;
                if selPeriodi.FieldByName('INIZIO').AsDateTime > DFine then
                begin
                  DFine:=selPeriodi.FieldByName('INIZIO').AsDateTime - 1;
                  //Creo periodo storico relativo al prossimo periodo di servizio da unificare
                  CreazioneStorico.SetVariable('DADATA',selPeriodi.FieldByName('INIZIO').AsDateTime);
                  CreazioneStorico.SetVariable('ADATA',selPeriodi.FieldByName('FINE').AsDateTime);
                  try
                    CreazioneStorico.Execute;
                  except
                    on E: Exception do
                    begin
                      Anom:=True;
                      s:=Format(A000MSG_B007_MSG_FMT_PERIODO_STORICO,[DateToStr(DDec),DateToStr(DFine),E.Message]);
                      RegistraMsg.InserisciMessaggio('A',s,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
                    end;
                  end;
                end;
                selPeriodi.GotoBookMark(BookselPeriodi);
              finally
                //caratto 15/09/2014 mancava free bookmark fin dalla preistoria
                selPeriodi.FreeBookmark(BookselPeriodi);
              end;
            end;
          end;
          if not Anom then
          begin
            updT430.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            updT430.SetVariable('DATADECORRENZA',DDec);
            updT430.SetVariable('DATAFINE',DFine);
            s:='';
            for i:=0 to selT430.Fields.Count -1 do
            begin
              if (selT430.Fields[i].FieldName <> 'PROGRESSIVO') and (selT430.Fields[i].FieldName <> 'DATADECORRENZA') and (selT430.Fields[i].FieldName <> 'DATAFINE') then
              begin
                if Trim(s) <> '' then
                  s:=s + ',';
                if selT430.Fields[i].DataType = ftString then
                  s:=s + selT430.Fields[i].FieldName + ' = ''' + AggiungiApice(selT430.FieldByName(selT430.Fields[i].FieldName).AsString) + ''''
                else if (selT430.Fields[i].DataType = ftInteger) or (selT430.Fields[i].DataType = ftFloat) then
                begin
                  if not selT430.FieldByName(selT430.Fields[i].FieldName).IsNull then
                    s:=s + selT430.Fields[i].FieldName + ' = ' + selT430.FieldByName(selT430.Fields[i].FieldName).AsString
                  else
                    s:=s + selT430.Fields[i].FieldName + ' = 0';
                end
                else if selT430.Fields[i].DataType = ftDateTime then
                begin
                  if not selT430.FieldByName(selT430.Fields[i].FieldName).IsNull then
                    s:=s + selT430.Fields[i].FieldName + ' = TO_DATE(''' + selT430.FieldByName(selT430.Fields[i].FieldName).AsString + ''',''DD/MM/YYYY'')'
                  else
                    s:=s + selT430.Fields[i].FieldName + ' = ''''';
                end
                else
                  s:=s + 'TO_CHAR(' + selT430.Fields[i].FieldName + ') = ''' + selT430.FieldByName(selT430.Fields[i].FieldName).AsString + '''';
              end;
            end;
            updT430.SetVariable('SET',s);
            try
              updT430.Execute;
            except
              on E: Exception do
              begin
                Anom:=True;
                s:=Format(A000MSG_B007_MSG_FMT_PERIODO_STORICO,[DateToStr(DDec),DateToStr(DFine),E.Message]);
                RegistraMsg.InserisciMessaggio('A',s,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
              end;
            end;
          end;
          selT430.Next;
        end;
        selPeriodi.Next;
      end;
    end;

    // -- Unificare periodi stipendiali: verifico se esistono periodi stipendiali antecedenti a quelli del prog. di partenza
    if not Anom then
    begin
      s:='';
      //se ci sono periodi sul prog.di partenza imposto il filtro altrimenti prendo tutto
      QSQL.SQL.Clear;
      QSQL.SQL.Add('select count(*) from p430_anagrafico where progressivo = ' + selAnagrafe.FieldByName('PROGRESSIVO').AsString);
      QSQL.Execute;
      if StrToIntDef(VarToStr(QSQL.Field(0)),0) > 0 then
        s:=' AND DECORRENZA < (select min(decorrenza) from p430_anagrafico where progressivo = ' + selAnagrafe.FieldByName('PROGRESSIVO').AsString + ')';
      selPeriodiStipendi.Close;
      selPeriodiStipendi.SetVariable('PROG',OldProgressivo);
      selPeriodiStipendi.SetVariable('FILTRO',s);
      selPeriodiStipendi.Open;
      while not selPeriodiStipendi.Eof do  //Ciclo sui periodi stipendiali
      begin
        //creo periodo stipendiale
        DDec:=selPeriodiStipendi.FieldByName('DECORRENZA').AsDateTime;
        //la prima decorrenza non può essere antecedente il primo periodo storico
        selT430Dec.Close;
        selT430Dec.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selT430Dec.SetVariable('DATAFINE',StrToDate('01/01/1900'));
        selT430Dec.Open;
        if not selT430Dec.Eof then
          if (DDec < selT430Dec.FieldByName('DATADECORRENZA').AsDateTime) then
          begin
            if (selPeriodiStipendi.RecordCount > 1) then
            begin
              Anom:=True;
              s:=A000MSG_B007_MSG_PERIODI_STIP_ANTE;
              RegistraMsg.InserisciMessaggio('A',s,'',OldProgressivo);
            end
            else
              DDec:=selT430Dec.FieldByName('DATADECORRENZA').AsDateTime;
          end;
        DFine:=selPeriodiStipendi.FieldByName('DECORRENZA_FINE').AsDateTime;
        if DFine <= 0 then
          DFine:=StrToDate('31/12/3999');
        //Cerco la prima decorrenza per il progressivo destinatario successiva alla
        //fine del nuovo periodo da importare
        selP430Dec.Close;
        selP430Dec.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selP430Dec.Open;
        //Se esiste decorrenza successiva per il progressivo destinatario..
        if not selP430Dec.Eof then
        begin
          //se non ci sono periodi successivi da importare uso la
          //maggiore tra data fine già calcolata e decorrenza - 1
          if selPeriodiStipendi.RecNo = selPeriodiStipendi.RecordCount then
            DFine:=Min(DFine,selP430Dec.FieldByName('DECORRENZA').AsDateTime - 1);
        end;
        CreazioneStoricoStipendi.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        CreazioneStoricoStipendi.SetVariable('DADATA',DDec);
        if DFine >= StrToDate('31/12/3999') then
          CreazioneStoricoStipendi.SetVariable('ADATA',null)
        else
          CreazioneStoricoStipendi.SetVariable('ADATA',DFine);
        try
          CreazioneStoricoStipendi.Execute;
        except
          on E: Exception do
          begin
            Anom:=True;
            s:=Format(A000MSG_B007_MSG_FMT_PERIODO_STIPENDIALE,[DateToStr(DDec),DateToStr(DFine),E.Message]);
            RegistraMsg.InserisciMessaggio('A',s,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          end;
        end;
        if not Anom then //aggiorno periodi stipendiali
        begin
          updP430.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          updP430.SetVariable('DATADECORRENZA',DDec);
          updP430.SetVariable('DATAFINE',DFine);
          s:='';
          for i:=0 to selPeriodiStipendi.Fields.Count -1 do
          begin
            if (selPeriodiStipendi.Fields[i].FieldName <> 'PROGRESSIVO') and
               (selPeriodiStipendi.Fields[i].FieldName <> 'DECORRENZA') and
               (selPeriodiStipendi.Fields[i].FieldName <> 'DECORRENZA_FINE') then
            begin
              if Trim(s) <> '' then
                s:=s + ',';
              if selPeriodiStipendi.Fields[i].DataType = ftString then
                s:=s + selPeriodiStipendi.Fields[i].FieldName + ' = ''' + selPeriodiStipendi.FieldByName(selPeriodiStipendi.Fields[i].FieldName).AsString + ''''
              else if (selPeriodiStipendi.Fields[i].DataType = ftInteger) or (selPeriodiStipendi.Fields[i].DataType = ftFloat) then
              begin
                if not selPeriodiStipendi.FieldByName(selPeriodiStipendi.Fields[i].FieldName).IsNull then
                  s:=s + selPeriodiStipendi.Fields[i].FieldName + ' = ' + selPeriodiStipendi.FieldByName(selPeriodiStipendi.Fields[i].FieldName).AsString
                else
                  s:=s + selPeriodiStipendi.Fields[i].FieldName + ' = 0';
              end
              else if selPeriodiStipendi.Fields[i].DataType = ftDateTime then
              begin
                if not selPeriodiStipendi.FieldByName(selPeriodiStipendi.Fields[i].FieldName).IsNull then
                  s:=s + selPeriodiStipendi.Fields[i].FieldName + ' = TO_DATE(''' + selPeriodiStipendi.FieldByName(selPeriodiStipendi.Fields[i].FieldName).AsString + ''',''DD/MM/YYYY'')'
                else
                  s:=s + selPeriodiStipendi.Fields[i].FieldName + ' = ''''';
              end
              else
                s:=s + 'TO_CHAR(' + selPeriodiStipendi.Fields[i].FieldName + ') = ''' + selPeriodiStipendi.FieldByName(selPeriodiStipendi.Fields[i].FieldName).AsString + '''';
            end;
          end;
          updP430.SetVariable('SET',s);
          try
            updP430.Execute;
          except
            on E: Exception do
            begin
              Anom:=True;
              s:=Format(A000MSG_B007_MSG_FMT_AGG_PERIODO_STIPENDIALE,[DateToStr(DDec),DateToStr(DFine),E.Message]);
              RegistraMsg.InserisciMessaggio('A',s,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            end;
          end;
        end;
        selPeriodiStipendi.Next;
      end;
    end;

    if Anom then
      SessioneOracle.Rollback
    else
    begin
      SessioneOracle.Commit;
      AllineaPeriodiStorici.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      AllineaPeriodiStorici.SetVariable('AGGLIBERA','');
      try
        AllineaPeriodiStorici.Execute;
        SessioneOracle.Commit;
      except
        on E: Exception do
        begin
          Anom:=True;
          s:=Format(A000MSG_B007_MSG_FMT_ALL_STORICI,[E.Message]);
          RegistraMsg.InserisciMessaggio('A',s,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        end;
      end;
      AllineaPeriodiStipendi.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      try
        AllineaPeriodiStipendi.Execute;
        SessioneOracle.Commit;
      except
        on E: Exception do
        begin
          Anom:=True;
          s:=Format(A000MSG_B007_MSG_FMT_ALL_STIPENDIALI,[E.Message]);
          RegistraMsg.InserisciMessaggio('A',s,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        end;
      end;
    end;
    // ----------------------------------------- Cancellare matricola unificata --------------------------
    if not Anom then
    begin
      PulisciTab('P272_RETRIBUZIONE_CONTRATTUALE',OldProgressivo);
      PulisciTab('P280_SERVIZIPENSPREV',OldProgressivo);
      PulisciTab('P282_PERIODIRETR',OldProgressivo);
      PulisciTab('P284_IMPORTIRETR',OldProgressivo);
      PulisciTab('P430_APPOGGIO',OldProgressivo);
      PulisciTab('P440_CEDOLINOSTATO',OldProgressivo);
      PulisciTab('P445_CEDOLINOTEMP',OldProgressivo);
      PulisciTab('P593_CONTABDATIINDIVIDUALI',OldProgressivo);
      PulisciTab('P430_ANAGRAFICO',OldProgressivo);
      PulisciTab('T430_STORICO',OldProgressivo);
      PulisciTab('T030_ANAGRAFICO',OldProgressivo);
      SessioneOracle.Commit;
    end;
  end;
end;

function TB007FManipolazioneDatiMW.InizioUnificazioneMatricole: String;
begin
  QSQL.SQL.Text:='ALTER TRIGGER TIMBRIDOPPIT100 DISABLE';
  QSQL.Execute;
  //Caratt0 16/09/2014 SalvaInizio mai usata
  //SalvaInizio:=C700SelAnagrafe.FieldByName('T430INIZIO').AsString;
  Result:=SelAnagrafe.FieldByName('T430FINE').AsString;
end;

procedure TB007FManipolazioneDatiMW.FineUnificazioneMatricole(SalvaFine: String);
var
  DDec,DFine:TDateTime;
  s:String;
begin
  if not RegistraMsg.ContieneTipoA then
  begin
    //Controllo - 2 o più periodi di servizio aperti e non chiusi
    selSQL.Close;
    selSQL.SQL.Clear;
    selSQL.SQL.Add('select distinct inizio, fine');
    selSQL.SQL.Add('  from t430_storico');
    selSQL.SQL.Add(' where progressivo = ' + SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
    selSQL.SQL.Add('   and inizio is not null and fine is null');
    selSQL.Open;
    if selSQL.RecordCount > 1 then
    begin
      s:=A000MSG_B007_MSG_PIU_PERIODI_SERVIZIO;
      RegistraMsg.InserisciMessaggio('A',s,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
    //Controllo - inizio rapporto < cessazione periodo precedente
    selSQL.Close;
    selSQL.SQL.Clear;
    selSQL.SQL.Add('select datadecorrenza, datafine, inizio, fine');
    selSQL.SQL.Add('  from t430_storico');
    selSQL.SQL.Add(' where progressivo = ' + SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
    selSQL.SQL.Add('   and inizio is not null');
    selSQL.SQL.Add('order by datadecorrenza');
    selSQL.Open;
    DDec:=selSQL.FieldByName('INIZIO').AsDateTime;
    DFine:=selSQL.FieldByName('FINE').AsDateTime;
    if DFine <= 0 then
      DFine:=StrToDate('31/12/3999');
    while not selSQL.Eof do
    begin
      if (selSQL.FieldByName('INIZIO').AsDateTime <> DDec) and
         (selSQL.FieldByName('INIZIO').AsDateTime < DFine) then
      begin
        s:=A000MSG_B007_MSG_ANOM_PERIODI_SERVIZIO;
        RegistraMsg.InserisciMessaggio('A',s,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
      selSQL.FieldByName('INIZIO').AsDateTime;
      selSQL.FieldByName('FINE').AsDateTime;
      if DFine <= 0 then
        DFine:=StrToDate('31/12/3999');
      selSQL.Next;
    end;
    //Controllo - periodo di servizio diverso da quello di partenza
    SelAnagrafe.Refresh;
    s:='';
    if SalvaFine <> SelAnagrafe.FieldByName('T430FINE').AsString then
    begin
      if Trim(SalvaFine) <> '' then
        s:=A000MSG_B007_MSG_DIP_MESSO_SERVIZIO;
      if Trim(SelAnagrafe.FieldByName('T430FINE').AsString) <> '' then
        s:=A000MSG_B007_MSG_DIP_DISMESSO_SERVIZIO;
    end;
    if Trim(s) <> '' then
      RegistraMsg.InserisciMessaggio('A',s,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  end;
  QSQL.SQL.Text:='ALTER TRIGGER TIMBRIDOPPIT100 ENABLE';
  QSQL.Execute;
end;

function TB007FManipolazioneDatiMW.EseguiScript(NomeFile: String):TStringList;
begin
  Result:=TStringList.Create;
  with ScrExeScript do
  begin
    Output.Clear;
    Lines.LoadFromFile(NomeFile);
    Execute;
    RegistraMsg.InserisciMessaggioList('I',Output);
    Result.Assign(Output);
  end;
end;

function TB007FManipolazioneDatiMW.VerificaDateUnificazione(Progressivo:Integer):String;
begin
  cdsDipendentiUnificazione.Locate('T430PROGRESSIVO',Progressivo,[]);
  if (cdsDipendentiUnificazione.FieldByName('T430FINE').IsNull) or (cdsDipendentiUnificazione.FieldByName('T430FINE').AsDateTime >= Parametri.DataLavoro) or
     (cdsDipendentiUnificazione.FieldByName('T430FINE').AsDateTime >= SelAnagrafe.FieldByName('T430FINE').AsDateTime) then
  begin
    Result:=Format(A000MSG_B007_DLG_FMT_UNIF_SERVIZIO,[SelAnagrafe.FieldByName('MATRICOLA').AsString,cdsDipendentiUnificazione.FieldByName('MATRICOLA').AsString]);
  end;
end;

function TB007FManipolazioneDatiMW.RipristinaCestino(NuovoValore: String): String;
begin
  Result:=MyCestino.Ripristino(NuovoValore);
  RegistraLog.SettaProprieta('I',MyCestino.Get_selI025.FieldByName('TABELLA').AsString,NomeOwner,nil,True);
  RegistraLog.InserisciDato('CODICE',MyCestino.Get_selI025.FieldByName('CHIAVE').AsString,'');
  RegistraLog.RegistraOperazione;
end;

function TB007FManipolazioneDatiMW.CancellaCestino: String;
begin
  Result:=MyCestino.CancFisica;
  RegistraLog.SettaProprieta('C',MyCestino.Get_selI025.FieldByName('TABELLA').AsString,NomeOwner,nil,True);
  RegistraLog.InserisciDato('CODICE',MyCestino.Get_selI025.FieldByName('CHIAVE').AsString,'');
  RegistraLog.RegistraOperazione;
end;

procedure TB007FManipolazioneDatiMW.AllineamentoTimbrature(const PProgressivo: Integer; const PDal, PAl: TDateTime);
begin
  try
    A023FAllTimbMW.Allinea(PProgressivo,PDal,PAl);

    RegistraLog.SettaProprieta('M','T100_TIMBRATURE','B007',nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',PProgressivo.ToString,'');
    RegistraLog.InserisciDato('ALLINEAMENTO DAL - AL',Format('%s - %s',[DateToStr(PDal),DateToStr(PAl)]),'');
    RegistraLog.RegistraOperazione;

    SessioneOracle.Commit;
  except
    on E: Exception do
    begin
      if not RegistraMsg.ContieneTipoA then
        RegistraMsg.InserisciMessaggio('A',Format('Elenco errori riscontrati durante l''allineamento delle timbrature dal %s al %s',[DateToStr(PDal),DateToStr(PAl)]));
      RegistraMsg.InserisciMessaggio('A',Format('%s (%s)',[E.Message,E.ClassName]),'',PProgressivo);
      SessioneOracle.RollBack;
    end;
  end;
end;

procedure TB007FManipolazioneDatiMW.FiltraCausali(UsaSelezioneAnagrafica: Boolean; PathStorage: String; DataInizio, DataFine: TDateTime; Iter, Stato: string);
begin
  selCausali.Close;
  if UsaSelezioneAnagrafica then
  begin
    // implementazione nell'sql della c700
    C700MergeSelAnagrafe(selCausali,False);
    C700MergeSettaPeriodo(selCausali,DataInizio,DataFine);
    R180SetVariable(selCausali,'OUT_JOIN',null);
  end
  else
  begin
    R180SetVariable(selCausali,'C700SELANAGRAFE','T030_ANAGRAFICO T030 where :DATALAVORO = :DATALAVORO');
    R180SetVariable(selCausali,'DATALAVORO',Date);
    R180SetVariable(selCausali,'OUT_JOIN','(+)');
  end;
  if PathStorage = '' then
    R180SetVariable(selCausali,'PATH_STORAGE', 'and 1 <> 1')
  else
    R180SetVariable(selCausali,'PATH_STORAGE', 'and upper(PATH_STORAGE) in (' + PathStorage + ')');

  if R180In(Stato, ['S','N']) then
    R180SetVariable(selCausali,'STATO','and T850.STATO = ''' + Stato + '''')
  else
    R180SetVariable(selCausali,'STATO','');

  if Iter = 'T050' then
  begin  //Giustificativi
    R180SetVariable(selCausali,'CAUSALE','CAUSALE');
    R180SetVariable(selCausali,'TABELLA_ITER','T050_RICHIESTEASSENZA');
  end
  else if Iter = 'M140' then
  begin  //Missioni
    R180SetVariable(selCausali,'CAUSALE','PROTOCOLLO');
    R180SetVariable(selCausali,'TABELLA_ITER','M140_RICHIESTE_MISSIONI');
  end;

  R180SetVariable(selCausali,'DAL', DataInizio);
  R180SetVariable(selCausali,'AL', DataFine);
  selCausali.Open;
end;

procedure TB007FManipolazioneDatiMW.FiltraT960(UsaSelezioneAnagrafica: Boolean; DataInizio, DataFine: TDateTime; Iter, Stato, InfoRichiesta: string);
begin
  selT960.Close;
  if UsaSelezioneAnagrafica then
  begin
    // implementazione nell'sql della c700
    C700MergeSelAnagrafe(selT960,False);
    C700MergeSettaPeriodo(selT960,DataInizio,DataFine);
  end
  else
  begin
    selT960.SetVariable('C700SELANAGRAFE','T030_ANAGRAFICO T030 where 1=1');
  end;

  if Iter <> '' then
    R180SetVariable(selT960, 'ITER', 'and T850.ITER = ''' + Iter + '''')
  else
    R180SetVariable(selT960, 'ITER', '');

  if Stato <> '' then
    R180SetVariable(selT960, 'STATO', 'and T850.STATO = ''' + Stato + '''')
  else
    R180SetVariable(selT960, 'STATO', '');

  if InfoRichiesta <> '' then
    R180SetVariable(selT960, 'INFO_RICHIESTA', 'and decode(T850.ITER,''T050'',T050.CAUSALE,''M140'',M140.PROTOCOLLO) = ''' + InfoRichiesta + '''')
  else
    R180SetVariable(selT960, 'INFO_RICHIESTA', '');

  selT960.SetVariable('DAL', DataInizio);
  selT960.SetVariable('AL', DataFine);
  selT960.Open;
end;

{ TElencoValoriAggDati }

constructor TElencoValoriAggDati.create;
begin
  lstValoreEsistente:=TStringList.Create;
  lstNuovoValore:=TStringList.Create;
end;

destructor TElencoValoriAggDati.destroy;
begin
  FreeAndNil(lstValoreEsistente);
  FreeAndNil(lstNuovoValore);
  inherited;
end;


end.
