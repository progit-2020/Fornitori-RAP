unit R450;

interface

uses
  //Windows, Messages, Graphics, Forms, Dialogs,
  SysUtils, Classes, Controls,
  DB, C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, OracleData, Oracle,
  Math, QueryStorico, Variants, R600, DBClient;

const
  MaxFasce = 28;       //Numero massimo di fasce nel Mese

type
  T_tdatiassestam = record
    tcauassest:String;
    tminassest:array [1..MaxFasce] of LongInt;
  end;

  TDataRiferimentoEsterna = record
    Abilitata:Boolean;
    Data:TDateTime;
  end;

  TRiepPres = record
    Causale:String;
    OreReseMese:array [1..MaxFasce] of Integer;
    OreBOMese:array [1..MaxFasce] of Integer;
    OreRese:array [1..MaxFasce] of Integer;
    Liquidabile:array [1..MaxFasce] of Integer;
    LiquidatoMese:array [1..MaxFasce] of Integer;
    Liquidato:array [1..MaxFasce] of Integer;
    Residuo:array [1..MaxFasce] of Integer;
    AnnoPrec:array [1..MaxFasce] of Integer;
    {*}Abbattimento:array [1..MaxFasce] of Integer;
    LimiteMensile:Integer;
    CompensabileMese:Integer;
    CompensabileMeseEff:Integer;
    CompensabileAnno:Integer;
    CompensabileAnnoEff:Integer;
    RecuperoAnno:Integer;
    RecuperoMese:Integer;
    {*}CompMeseUsato:Integer;
    {*}RecupMeseUsato:Integer;
    {*}LiquidMeseUsato:Integer;
  end;

  TRiepPresCartellino = record
    Causale:String;
    OreRese:array [1..MaxFasce] of Integer;
    Compensabile:Integer;
    Liquidato:array [1..MaxFasce] of Integer;
  end;

  TRiepilogoMese = record
    Data:TDateTime;
    SaldoMese:Integer;
    SaldoMeseNoCau:Integer;
    EccSoloCompMes:Integer;
    StrLiqGGMese:Integer;
    OreLiqMese:Integer;
    OreRecuperate:Integer;
    RecuperoMensile:Integer;
    RecuperoNegativi:Integer;
    NegativiNonRecuperati:Integer;
    SaldoAnnoComp:Integer;
    SaldoAnnoLiq:Integer;
    SaldoAnnoAtt:Integer;
    Abbattimento:Integer;
    AddebitoPaghe:Integer;
    BancaOreResAtt:Integer;
    BancaOreResPrec:Integer;
    RiposiNonFruitiOre:Integer;
    SaldoNegativoMinimo:Integer;
    RiepSaldiMobili_SaldoPrecedente:Integer;
    RiepSaldiMobili_SaldoDisponibile:Integer;
    RiepSaldiMobili_Recupero:Integer;
    RiepPres: array of TRiepPres;{//*//}
  end;

  TRiepilogoRecuperiItem = record
    DataReso,DataAbbatt:TDateTime;
    Recupero:Integer;
  end;

  TRiepilogoRecuperi = array of TRiepilogoRecuperiItem;

  TRiepAssenzeCumuloS = record
    Codice:String;
    Ore:Integer;
  end;

  TRiepilogoRecuperiRiepPres = record
    Causale:String;
    Data:TDateTime;
    OreRese,OreResidue,OrePerse,OreRecuperate,
    Compensabile,CompUsato,
    Recuperato,RecupUsato,
    Liquidato,LiquidUsato:Integer;
  end;

  TSchedaRiep = record
    debormes:Integer;
    debggtot:Integer;
    debpomes:Integer;
    poflag:Char;
    fesintmesVar:Real;
    fesridmesVar:Real;
    notggmesVar:Integer;
    notminmesVar:String;
    tdatiassestamento:array [1..2] of T_tdatiassestam;
    eccsolocompmes:Integer;
    EccSoloCompMesOltreSoglia:Integer;
    vareccliqmes:Integer;
    scostnegmes:Integer;
    abbannoprecmes:Integer;
    abbannoattmes:Integer;
    abbliqannoprecmes:Integer;
    abbliqannoattmes:Integer;
    ripcommes:Integer;
    abbripcommes:Integer;
    NFasce:Byte;
    AddebitoPaghe:Integer;
    OreCompLiquidate:Integer;
    BancaOreLiqVar:Integer;
    OreCompRecuperate:Integer;
    CarenzaObbligatoria:Integer;
    RiposiNonFruitiOre:String;
    tfasce:array [1..MaxFasce] of String;
    tmaggioraz:array [1..MaxFasce] of Word;
    tminlavmese:array [1..MaxFasce] of LongInt;
    tmininturno:array [1..MaxFasce] of LongInt;
    tminstrmens:array [1..MaxFasce] of LongInt;
    tstrliquidatomm:array [1..MaxFasce] of LongInt;
    tLiqNelMese:array [1..MaxFasce] of LongInt;
  end;

  TRiepilogoPrecedente = record
    CompensabilePrec:Integer;
    CompensabileAtt:Integer;
    LiquidabilePrec:Integer;
    LiquidabileAtt:Integer;
    BancaOreResidua:Integer;     //Banca ore residua totale
    BancaOreResiduaPrec:Integer; //Banca ore residua relativa all'anno precedente
    CompAttMaggiorato:Integer;
    LiqAttMaggiorato:Integer;
    StrResiduoAnno:Integer;
    SaldoNegativoMinimoEcced:Integer;
  end;

  TselT077 = class(TComponent)
  private
    T077P_SCRIVIVALORE: TOracleQuery;
    T077F_LEGGIVALORE: TOracleQuery;
    FProgressivo:Integer;
    FData:TDateTime;
    procedure PutOracleSession(Value:TOracleSession);
    procedure PutProgressivo(Value:Integer);
    procedure PutData(Value:TDateTime);
  public
    procedure ScriviValore(Dato,Valore:String; Tipo:String = 'A');
    function  LeggiValore(Dato:String; Tipo:String = ''):String;
    property Session:TOracleSession write PutOracleSession;
    property Progressivo:Integer read FProgressivo write PutProgressivo;
    property Data:TDateTime read FData write PutData;
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;
  end;

  TR450DtM1 = class(TDataModule)
    selT070: TOracleDataSet;
    selT071: TOracleDataSet;
    selT130: TOracleDataSet;
    FasceCount: TOracleDataSet;
    selT075: TOracleDataSet;
    QIndPresTot: TOracleDataSet;
    QTurniReperib: TOracleDataSet;
    QMaturazioneMensa: TOracleDataSet;
    QAcquistoMensa: TOracleDataSet;
    QNumPasti: TOracleDataSet;
    selT025: TOracleDataSet;
    selT800: TOracleDataSet;
    selT810: TOracleDataSet;
    selT811: TOracleDataSet;
    selT074: TOracleDataSet;
    selT073: TOracleDataSet;
    selT074liq: TOracleDataSet;
    sum071: TOracleQuery;
    selT026: TOracleDataSet;
    selT430: TOracleDataSet;
    sum070: TOracleQuery;
    QResiduiMensa: TOracleDataSet;
    selT275: TOracleDataSet;
    selT131: TOracleDataSet;
    selT134: TOracleDataSet;
    selT430InizioFine: TOracleDataSet;
    scrStrAnnuo: TOracleQuery;
    selT040: TOracleDataSet;
    selT265_CumuloS: TOracleQuery;
    selT074lb: TOracleDataSet;
    selT305: TOracleDataSet;
    selBuoniPastoTotali: TOracleQuery;
    selT820: TOracleDataSet;
    cdsStrAnnuo: TClientDataSet;
    selT265: TOracleDataSet;
    selT011: TOracleDataSet;
    selT077: TOracleDataSet;
    procedure R450DtM1Create(Sender: TObject);
    procedure R450DtM1Destroy(Sender: TObject);
  private
    { Private declarations }
    AnnoCorr400           :Integer;
    MeseCorr400           :Byte;
    diffcomodo            :LongInt;
    fascomodo             :LongInt;
    Serbatoi              :array[0..4] of String;
    FOrePersePeriodiche   :Integer;
    FAddebitoPaghe        :LongInt;
    FAddebitoPagheRec     :LongInt;
    FOreTroncate          :LongInt;
    FCompensabileMensile  :Integer;
    FCompensabileAnnuo    :Integer;
    FBancaOreLiquidata    :Integer;
    FBancaOreResidua      :Integer;
    FBancaOreRecuperata   :Integer;
    FBancaOreRecAnnoPrec  :Integer;
    FBancaOreRecInterna   :Integer;
    FBancaOreRecInternaMensile: Integer;
    FBancaOreAnno         :Integer;
    FBancaOreResiduaPrec  :Integer;
    FBancaOreMese         :Integer;
    SaldoNegNonRecuperato :Integer;
    LiqAnnoCauEstIncBud   :Integer;
    ResoAnnoCauEstIncBO   :Integer;
    NewEccResAutMen       :LongInt;
    NewStrAutMen          :LongInt;
    TeorStrAutMen         :LongInt;
    TeorResAutMen         :LongInt;
    //Melegnano
    SaldoDaAbbattere      :LongInt;
    ScostNegDaAbbattere   :LongInt;
    selStorico            :TQueryStorico;
    //S.Martino
    RiepilogoMese         :array of TRiepilogoMese;
    lstAssenzeCumuloS     :TStringList;
    lstPresenzeCumuloS    :TStringList;
    R600DtM               :TR600DtM1;
    RiepAssenzeCumuloS    :array of TRiepAssenzeCumuloS;
    RiposoNonFruito       :String;
    RiposoRecupLiquid     :String;
    RecupStraordPrec      :String;
    DescT025              :String;
    SessioneOracleR450    :TOracleSession;
    function GetOreInTurnoDelMese:Integer;
    function GetStrFattoMeseTotale:Integer;
    function GetLiqDalMese:Integer;
    function GetLiqNelMese:Integer;
    function GetStrFattoAnno:Integer;
    function GetLiqNellAnno:Integer;
    function GetStrResiduoAnno:Integer;
    function GetStrResiduoAnno_Prec:Integer;
    function GetOreAssenze:Integer;
    function GetGGPresenza:Integer;
    function GetGGVuoti:Integer;
    function GetPrimiTurni:Integer;
    function GetSecondiTurni:Integer;
    function GetTerziTurni:Integer;
    function GetQuartiTurni:Integer;
    function GetFesIntMes:Real;
    function GetFesRidMes:Real;
    function GetIndNotturnaGG:Integer;
    function GetIndNotturnaOre:Integer;
    function GetFestiviNonGoduti:Integer;
    function GetOreReseINAIL:Integer;
    function GetIndPresTotali:Real;
    function GetReperibilitaTurni:String;
    function GetReperibilitaSpezzoni:String;
    function GetReperibilitaOreMaggiorate:String;
    function GetReperibilitaOreNonMagg:String;
    function GetBuoniMensaMaturati:Integer;
    function GetBuoniMensaVariati:Integer;
    function GetFornituraBuoniTicketAcquistati:TDateTime;
    function GetBlocchettiAcquistati:String;
    function GetBuoniMensaAcquistati:Integer;
    function GetBuoniMensaRecuperati:Integer;
    function GetBuoniMensaAnnoPrec:Integer;
    function GetTicketMaturati:Integer;
    function GetTicketVariati:Integer;
    function GetTicketAcquistati:Integer;
    function GetTicketRecuperati:Integer;
    function GetTicketAnnoPrec:Integer;
    function GetBuoniPastoAnno(Dato:String):Integer;
    function GetNumeroPastiConv:Integer;
    function GetNumeroPastiInteri:Integer;
    function GetNoteBuoniMensaTicket:string;
    function GetOreAnnoPrec:Integer;
    function GetEccCompAnnoPrec:Integer;
    function GetAssestamento1Totale:Integer;
    function GetAssestamento2Totale:Integer;
    function GetTipoConteggio:Byte;
    function GetStrAutMen:LongInt;
    function GetEccAutAnno(Dato:String):LongInt;
    //function GetEccResAutAnn:LongInt;
    function GetEccResAutMen:LongInt;
    function GetResAutMen_Teorico:LongInt;
    function GetStrAutMen_Teorico:LongInt;
    function GetStrEsterno:LongInt;
    function GetOreCausLiqEsterneInBudget:Integer;
    function GetOreCausLiqSenzaLimiti:LongInt;
    function GetOreCausMeseIncluseSaldi:LongInt;
    function GetOreCausAnnoIncluseSaldi:LongInt;
    function GetOreCausReseEsterneInBO:Integer;
    function GetOreCausLiqEsterneInBO:Integer;
    function GetOreCausLiqIncluse:Integer;
    function GetBOMaturataCausEsterne:Integer;
    function GetEccedenzaMensile:LongInt;
    function GetCompensabileMensileNettoRiposi:LongInt;
    function GetElencoSerbatoi:String;
    function GetNegativiNonRecuperati:Integer;
    function GetSaldoMobileAbbattibile:Integer;
    function GetSaldoMobileDisponibile:Integer;
    function GetSaldoMobileRecupero(D:TDateTime):Integer;
    function GetBancaOreEccedente(StraordAutorizzato:Integer):Integer;
    procedure GetTipoConteggioMensile;
    procedure GetLimitiAutMen;
    procedure x400_conteggio;
    procedure x401_leggiresid(LeggiTabella:Boolean);
    procedure x402_salvresid;
    procedure x404_impcontmese;
    procedure x450_contdati;
    procedure x470_impdaticont;
    procedure x472_saldatiprec;
    procedure y010_contcomune;
    procedure y100_contdati1;
    procedure y200_contdati2;
    procedure y300_contdati3;
    procedure y400_contdati4;
    procedure y420_sottrserb;
    procedure y421_AbbattiSerbatoio(TipoSerbatoio:String; arrot:Integer; var recupero,serbatoio,abbeff,differenza:Integer);
    procedure y500_contdati5;
    procedure y600_contdati6;
    procedure ImpostaRiepilogoPresenze(LeggiTabella:Boolean);
    //procedure GetRiepilogoPresenze(Causale:String; Data:TDateTime; App:TRiepPres; PresCart:Integer);
    procedure ConteggiRiepiloghiPresenza;
    procedure AbbattiRiepPres(k:Integer; var Abbatti:Integer);
    procedure AbbattiRiepPresMensile(k:Integer; var Abbatti:Integer);
    procedure AbbattiRiepPresBO(k:Integer; var Abbatti:Integer);
    function GetAbbattimentoSaldi(var MR,MA:Integer):Boolean;
    function GetCampiStorici:String;
    function ConteggiMobili:TDateTime;
    function GetAssenzeCumuloS(Causale:String; Data:TDateTime):Boolean;
    procedure AbbattimentoAssenzeCumuloS;
    function GetRipComLiqMes:Integer;
    function GetBOInclusaSaldi(V:Integer):Integer;
    function GetResidCompNegativo:Boolean;
  public
    { Public declarations }
    R455_tipocon:Integer;
    MesiSaldoPrec:Integer;  //Gestione saldi periodica (Pinerolo/Genova_HSMartino)
    PeriodicitaAbbattimento:String;
    AbbattimentoFissoRecupero:String;
    SaldoMobile_AbbatteMax:Integer;
    SaldoMobile_SaldiUsati:String;
    SaldoMobile_Riferimento:String;
    CausaliCompensabili,CausaliCompensabiliMensili:String;
    progress400:LongInt;
    anno400:Integer;
    mese400:Byte;
    RicalcoloIndennita:String;
    RicalcoloIndPresenza:String;
    RecuperoDebito:Integer;
    RecuperoDebitoMax:Integer;
    RecDebitoMaxTollerato:Integer;
    RecuperoDebitoTipo:String;
    LiquidazioneDistribuita:String;
    BancaOreResiduabile:String;
    BancaOreResidAnnoPrec:String;
    TipoLimiteCompA:String;
    TipoLimiteCompP:String;
    TipoLimiteCompNoRec:String;
    LimiteCompA:Integer;
    RecuperoSerbatoi:String;
    BancaOre:String;
    BancaOreEsclusaSaldi:String;
    BancaOreLimitataSaldoComplessivo:String;
    BancaOreLimitataStrLiquidabile:String;
    BancaOrePreservata:String;
    BancaOreMensArr:Integer;
    BancaOreAbbattibile:String;
    BancaOreContrLiquidaz:String;
    AbbattimentoLiquidabile:String;
    IterEccGGCheckSaldo:Boolean;
    Caller:String;
    DataRiferimentoEsterna:TDataRiferimentoEsterna;
    L07,L07SV:TSchedaRiep;
    s_trovato:String;
    NFasceMese:Byte;
    DaData,AData:TDateTime;
    Back_l13_sallav_min,Back_RecAnnoCorrOld,
    Back_RecuperiAP_Prec,Back_RecuperiAC_Prec:LongInt;
    tOreRepDiff:array[1..MaxFasce] of LongInt;
    RiepPres:array of TRiepPres;
    RiepPresCartellino:array of TRiepPresCartellino;
    AppRiepPres:TRiepPres;
    //_________________________________________________________________
    //Dati per totalizzazioni mensili
    //Per loro descrizione si veda il file formule.doc
    //_________________________________________________________________
    l13_sallav_min,
    l13_respo_min,
    l13_rescnl_min,l13_rescnl_min_orig,
    l13_resrco_min,
    l13_banca_ore:LongInt;
    l13_banca_ore_recuperata:LongInt;
    tfasce:array [1..MaxFasce] of String;
    tmaggioraz:array[1..MaxFasce] of Byte;
    tminlavmes:array [1..MaxFasce] of LongInt;
    tmininturno:array [1..MaxFasce] of LongInt;
    tdatiassestamen:array [1..2] of T_tdatiassestam;
    tdatiassestamen_app:array [1..2] of T_tdatiassestam;
    tsupann:array [1..MaxFasce] of LongInt;
    tsupann_prec:array [1..MaxFasce] of LongInt;
    tminstrmen:array [1..MaxFasce] of LongInt;
    tminstrmen_ori:array [1..MaxFasce] of LongInt;
    tstrmese:array [1..MaxFasce] of LongInt;
    tbancaore:array [1..MaxFasce] of LongInt;
    tstrliqmm:array [1..MaxFasce] of LongInt;
    tLiqNelMese:array [1..MaxFasce] of LongInt;
    tstranno:array [1..MaxFasce] of LongInt;
    tstranno_prec:array [1..MaxFasce] of LongInt;
    tstrliq:array [1..MaxFasce] of LongInt;
    tstrliq_prec:array [1..MaxFasce] of LongInt;
    tstrannom:array [1..MaxFasce] of LongInt;
    tstrannom_prec:array [1..MaxFasce] of LongInt;
    tstrannoprecm:array [1..MaxFasce] of LongInt;
    ttrovscheda:array [1..12] of Byte;
    RiepilogoRecuperiRiepPres:array of TRiepilogoRecuperiRiepPres;
    NFasceMeseNew         :Byte;
    azzsaldofmpos         :String;
    eccfascdastr          :String;
    tipopers              :Char;
    debormes              :Integer;
    debggtot              :Integer;
    debpomes              :Integer;
    debpo_percptmes       :single;
    scostmes              :LongInt;
    eccsolocompmes        :SmallInt;
    fesintmesVar          :Real;
    fesridmesVar          :Real;
    notggmesVar           :Integer;
    notminmesVar          :String;
    EccSoloCompMesOltreSoglia:Integer;
    eccsolocompmesazz     :Longint;
    scostfasciames        :LongInt;
    minassenzemes         :LongInt;
    vareccliqmes          :LongInt;
    totasscompmes         :LongInt;
    totoreresori          :LongInt;
    totoreres             :LongInt;
    debtotmes             :LongInt;
    totliqmm              :LongInt;
    totcausliqmm          :LongInt;
    salmeseatt            :LongInt;
    salmese_prec          :LongInt;
    salfmprec             :LongInt;
    salfmprecnetto        :LongInt;
    salannoatt            :LongInt;
    salannoatt_prec       :LongInt;
    salannonetto          :LongInt;
    salannonetto_prec     :LongInt;
    scostnegmes           :LongInt;
    scostnegmescom        :LongInt;
    scostnegmesnetto      :LongInt;
    abbannoprecmes        :LongInt;
    abbannoattmes         :LongInt;
    abbliqannoprecmes     :LongInt;
    abbliqannoattmes      :LongInt;
    abbannopreceff        :LongInt;
    abbannoatteff         :LongInt;
    abbannoprecanno       :LongInt;
    totoreresnorip        :LongInt;
    ripcommes             :LongInt;
    abbripcommes          :LongInt;
    poflag                :Char;
    debpoanno             :LongInt;
    debpoanno_prec        :LongInt;
    totore                :LongInt;
    debpoannores          :LongInt;
    debpoeff              :LongInt;
    poreso                :LongInt;
    poresoanno            :LongInt;
    poresoanno_prec       :LongInt;
    salpoanno             :LongInt;
    salpoanno_prec        :LongInt;
    eccsolocompanno       :LongInt;
    eccsolocompanno_prec  :LongInt;
    eccsolocompres_prec   :LongInt;
    salcompannoprec       :LongInt;
    salcompannoprec_prec  :LongInt;
    salripcommes          :LongInt;
    salripcomfmprec       :LongInt;
    salripcom             :LongInt;
    salripcom_prec        :LongInt;
    abbannoprecanno_prec  :LongInt;
    salcompannoatt        :LongInt;
    salcompannoatt_prec   :LongInt;
    salcompannoattExt     :LongInt;
    salcompannoattNetto   :Longint;
    salliqannoatt         :LongInt;
    salliqannoatt_prec    :LongInt;
    salliqannoprec        :LongInt;
    salliqannoprec_prec   :LongInt;
    BancaOreResidua_prec  :LongInt;
    BancaOreResiduaPrec_prec:LongInt;
    BOMaturataCausEsterneAnno :LongInt;
    salmeseattnocau       :LongInt;
    sottrserbcomodo       :LongInt;
    diffsalserb           :LongInt;
    vareccliqanno         :LongInt;
    vareccliqanno_prec    :LongInt;
    strliqgganno          :LongInt;
    ecctotanno            :LongInt;
    totasscompanno        :LongInt;
    totasscompanno_prec   :LongInt;
    eccsolocompres        :LongInt;
    eccsolocompAC         :LongInt;
    eccsolocompAP         :LongInt;
    stranno               :LongInt;
    stranno_prec          :LongInt;
    strliqggmese          :LongInt;
    ancoraliq             :LongInt;
    abbannoattmescom      :LongInt;
    abbannoprecmescom     :LongInt;
    abbliqannoattmescom   :LongInt;
    abbliqannoprecmescom  :LongInt;
    OreCompLiquidate      :LongInt;
    BancaOreLiqVar        :LongInt;
    OreCompRecuperate     :LongInt;
    CarenzaObbligatoria   :LongInt;
    RecAnnoCorr           :LongInt;
    RecAnnoPrec           :LongInt;
    RecAnnoCorrOld        :LongInt;
    scostcomodo           :LongInt;
    LiquidabileMensileSenzaLimiti:LongInt;
    liquidabmese          :LongInt;
    liquidabmese_prec     :LongInt;
    TotLiquidNelMese      :Integer;//Word; // correzione 22.02.2011
    OreEsclComp           :LongInt;
    TroncaEccedenze       :String;
    TroncaLiquidabile     :String;
    LimiteEccRes          :String;
    LimiteEccLiq          :String;
    LimiteLiquidabileAnnuo:String;
    LiqOreAnniPrec        :LongInt;
    VariazioneSaldo       :LongInt;
    DataVariazSaldiPrec   :TDateTime;
    NoteVariazSaldiPrec   :String;
    SogliaCompLiq         :Integer;
    ArrSogliaCompLiq      :Integer;
    ArrotondaCP           :Integer;
    ArrotondaCA           :Integer;
    ArrotondaLP           :Integer;
    ArrotondaLA           :Integer;
    ArrRecScostNeg        :Integer;
    SaldoNegativoMinimo   :Integer;
    SaldoNegativoMinimoTipo:String;
    SaldoNegativoMinimoEcced:Integer;
    RiepilogoPrecedente   :TRiepilogoPrecedente;
    RiposiNonFruitiGG     :Real;
    RiposiNonFruitiOre    :Integer;
    MaxLiquidabile_RiposiNonFruiti:Integer;
    StrAutMenNoCau        :Integer;
    {
    PALimite              :String;
    PALimiteSaldoAtt      :Boolean;
    }
    PALimite              :Integer;
    PALimiteSaldoAtt      :Integer;
    PALimiteSaldoPrec     :Integer;
    PARaggrLimite         :String;
    PARaggrLimiteSaldoAtt :String;
    PARaggrLimiteSaldoPrec:String;
    PAAzzeramentoPeriodico:Boolean;
    PATipoResiduo         :Integer;
    AbbattRifLiquidabile  :String;
    AbbattRifCompensabile :String;
    AbbattRifRecupero     :String;
    CausRipComFasce       :String;
    DebAggRappAnno        :String;
    DebAggConsidOrePrec   :String;
    ParCartellino         :String;
    IterAutorizzativoStr  :String;
    procedure DeallocaQueryStampa;
    procedure ParametrizzazioneQueryStampa(Q:Byte);
    procedure ConteggiMese(Chiamante:String; Anno,Mese:Integer; Progressivo:LongInt);
    procedure x300_GetFasceMese(Anno,Mese:Integer; ResetFasce:Boolean);
    function IndiceRiepPres(Causale:String):Integer;
    {*}function IndiceRiepPresSM(iRM:Integer; Causale:String):Integer;
    function GetOreBOMese(Causale:String; Fascia:Integer):Integer;
    (*new*)procedure GetRiepilogoPresenze(Causale:String; Data:TDateTime; App:TRiepPres; PresCart:Integer);
    (*new*)function AddRiepPres:Integer;
    //procedure EliminaRiepPres(Causale:String);//Non dovrebbe MAI servire, altrimenti non posso leggere i riepiloghi annuali
    function EsistePresenzaLiquidataSuccessiva(Causale:String):Boolean;
    function EsisteLiquidazioneSuccessiva(Progressivo:Integer; Data:TDateTime):Boolean;
    function EsisteCompLiquidatoSuccessivo(Progressivo:Integer; Data:TDateTime):Boolean;
    procedure GetRiepilogoRecuperi(var RiepilogoRecuperi:TRiepilogoRecuperi);
    function GetDatiSaldiMobili(Dato:String; Data:TDateTime):Integer;
    function LeggiValoreT077(Dato:String; Data:TDateTime):String;
    property OreInTurnoDelMese:Integer read GetOreInTurnoDelMese;
    property StrFattoMeseTotale:Integer read GetStrFattoMeseTotale;
    property LiqDalMese:Integer read GetLiqDalMese;
    property LiqNelMese:Integer read GetLiqNelMese;
    property StrFattoAnno:Integer read GetStrFattoAnno;
    property LiqNellAnno:Integer read GetLiqNellAnno;
    property StrResiduoAnno:Integer read GetStrResiduoAnno;
    property StrResiduoAnno_Prec:Integer read GetStrResiduoAnno_Prec;
    property OreAssenze:Integer read GetOreAssenze;
    property GGPresenza:Integer read GetGGPresenza;
    property GGVuoti:Integer read GetGGVuoti;
    property PrimiTurni:Integer read GetPrimiTurni;
    property SecondiTurni:Integer read GetSecondiTurni;
    property TerziTurni:Integer read GetTerziTurni;
    property QuartiTurni:Integer read GetQuartiTurni;
    property FesRidMes:Real read GetFesRidMes;
    property FesIntMes:Real read GetFesIntMes;
    property IndNotturnaGG:Integer read GetIndNotturnaGG;
    property IndNotturnaOre:Integer read GetIndNotturnaOre;
    property FestiviNonGoduti:Integer read GetFestiviNonGoduti;
    property OreReseInail:Integer read GetOreReseInail;
    property IndPresTotali:Real read GetIndPresTotali;
    property OreCausLiqEsterneInBudget:Integer read GetOreCausLiqEsterneInBudget;
    property OreCausReseEsterneInBO:Integer read GetOreCausReseEsterneInBO;
    property OreCausLiqEsterneInBO:Integer read GetOreCausLiqEsterneInBO;
    property OreCausLiqIncluse:Integer read GetOreCausLiqIncluse;
    property BOMaturataCausEsterne:Integer read GetBOMaturataCausEsterne;
    property ReperibilitaTurni:string read GetReperibilitaTurni;
    property ReperibilitaSpezzoni:String read GetReperibilitaSpezzoni;
    property ReperibilitaOreMaggiorate:String read GetReperibilitaOreMaggiorate;
    property ReperibilitaOreNonMagg:String read GetReperibilitaOreNonMagg;
    property BuoniMensaMaturati:Integer read GetBuoniMensaMaturati;
    property BuoniMensaVariati:Integer read GetBuoniMensaVariati;
    property FornituraBuoniTicketAcquistati:TDateTime read GetFornituraBuoniTicketAcquistati;
    property BlocchettiAcquistati:String read GetBlocchettiAcquistati;
    property BuoniMensaAcquistati:Integer read GetBuoniMensaAcquistati;
    property BuoniMensaRecuperati:Integer read GetBuoniMensaRecuperati;
    property BuoniMensaAnnoPrec:Integer read GetBuoniMensaAnnoPrec;
    property TicketMaturati:Integer read GetTicketMaturati;
    property TicketVariati:Integer read GetTicketVariati;
    property TicketAcquistati:Integer read GetTicketAcquistati;
    property TicketRecuperati:Integer read GetTicketRecuperati;
    property TicketAnnoPrec:Integer read GetTicketAnnoPrec;
    property BuoniPastoAnno[Dato:String]:Integer read GetBuoniPastoAnno;
    property NumeroPastiConv:Integer read GetNumeroPastiConv;
    property NumeroPastiInteri:Integer read GetNumeroPastiInteri;
    property NoteBuoniMensaTicket:string read GetNoteBuoniMensaTicket;
    property OreAnnoPrec:Integer read GetOreAnnoPrec;
    property EccCompAnnoPrec:Integer read GetEccCompAnnoPrec;
    property Assestamento1Totale:Integer read GetAssestamento1Totale;
    property Assestamento2Totale:Integer read GetAssestamento2Totale;
    property TipoConteggio:Byte read GetTipoConteggio;
    property OrePersePeriodiche:Integer read FOrePersePeriodiche;
    property OreTroncate:Integer read FOreTroncate;
    property AddebitoPaghe:Integer read FAddebitoPaghe;
    property StrAutMen:LongInt read GetStrAutMen;
    property EccResAutMen:LongInt read GetEccResAutMen;
    property StrAutMen_Teorico:LongInt read GetStrAutMen_Teorico;
    property ResAutMen_Teorico:LongInt read GetResAutMen_Teorico;
    property StrEsterno:LongInt read GetStrEsterno;
    property OreCausLiqSenzaLimiti:LongInt read GetOreCausLiqSenzaLimiti;
    property OreCausMeseIncluseSaldi:LongInt read GetOreCausMeseIncluseSaldi;
    property OreCausAnnoIncluseSaldi:LongInt read GetOreCausAnnoIncluseSaldi;
    property EccAutAnno[Dato:String]:LongInt read GetEccAutAnno;
    //property EccResAutAnn:LongInt read GetEccResAutAnn;
    property EccedenzaMensile:LongInt read GetEccedenzaMensile;
    property CompensabileMensile:LongInt read FCompensabileMensile;
    property CompensabileAnnuo:LongInt read FCompensabileAnnuo;
    property CompensabileMensileNettoRiposi:LongInt read GetCompensabileMensileNettoRiposi;
    property BancaOreAnno:LongInt read FBancaOreAnno;
    property BancaOreLiquidata:LongInt read FBancaOreLiquidata;
    property BancaOreRecuperata:LongInt read FBancaOreRecuperata;
    property BancaOreRecInternaMensile:LongInt read FBancaOreRecInternaMensile;
    property BancaOreResidua:LongInt read FBancaOreResidua;
    property BancaOreResiduaPrec:LongInt read FBancaOreResiduaPrec;
    property BancaOreMese:LongInt read FBancaOreMese;
    property BancaOreEccedente[StraordAutorizzato:Integer]:LongInt read GetBancaOreEccedente;
    property ElencoSerbatoi:String read GetElencoSerbatoi;
    property NegativiNonRecuperati:Integer read GetNegativiNonRecuperati;
    property SaldoMobileAbbattibile:Integer read GetSaldoMobileAbbattibile;
    property SaldoMobileDisponibile:Integer read GetSaldoMobileDisponibile;
    property SaldoMobileRecupero[D:TDateTime]:Integer read GetSaldoMobileRecupero;
    property RipComLiqMes:Integer read GetRipComLiqMes;
    property ResidCompNegativo:Boolean read GetResidCompNegativo;
  end;

(*var
  R450DtM1: TR450DtM1;*)

implementation

{$R *.DFM}

// classe TselT077 //
constructor TselT077.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  T077P_SCRIVIVALORE:=TOracleQuery.Create(nil);
  with T077P_SCRIVIVALORE do
  begin
    SQL.Add('begin');
    SQL.Add('  T077P_SCRIVIVALORE(:PROGRESSIVO,:DATA,:TIPO,:DATO,:VALORE);');
    SQL.Add('end;');
    DeclareVariable('PROGRESSIVO',otInteger);
    DeclareVariable('DATA',otDate);
    DeclareVariable('TIPO',otString);
    DeclareVariable('DATO',otString);
    DeclareVariable('VALORE',otString);
  end;
  T077F_LEGGIVALORE:=TOracleQuery.Create(nil);
  with T077F_LEGGIVALORE do
  begin
    SQL.Add('begin');
    SQL.Add('  :VALORE:=T077F_LEGGIVALORE(:PROGRESSIVO,:DATA,:DATO,:TIPO);');
    SQL.Add('end;');
    DeclareVariable('PROGRESSIVO',otInteger);
    DeclareVariable('DATA',otDate);
    DeclareVariable('DATO',otString);
    DeclareVariable('VALORE',otString);
    DeclareVariable('TIPO',otString);
  end;
end;

destructor TselT077.Destroy;
begin
  FreeAndNil(T077P_SCRIVIVALORE);
  FreeAndNil(T077F_LEGGIVALORE);
  inherited Destroy;
end;

procedure TselT077.PutOracleSession(Value:TOracleSession);
begin
  T077P_SCRIVIVALORE.Session:=Value;
  T077F_LEGGIVALORE.Session:=Value;
end;

procedure TselT077.PutProgressivo(Value:Integer);
begin
  FProgressivo:=Value;
  T077P_SCRIVIVALORE.SetVariable('PROGRESSIVO',FProgressivo);
  T077F_LEGGIVALORE.SetVariable('PROGRESSIVO',FProgressivo);
end;

procedure TselT077.PutData(Value:TDateTime);
begin
  FData:=R180inizioMese(Value);
  T077P_SCRIVIVALORE.SetVariable('DATA',FData);
  T077F_LEGGIVALORE.SetVariable('DATA',FData);
end;

procedure TselT077.ScriviValore(Dato,Valore:String; Tipo:String = 'A');
begin
  with T077P_SCRIVIVALORE do
  begin
    SetVariable('DATO',Dato);
    SetVariable('VALORE',Valore);
    SetVariable('TIPO',Tipo);
    Execute;
  end;
end;

function TselT077.LeggiValore(Dato:String; Tipo:String = ''):String;
begin
  Result:='';
  with T077F_LEGGIVALORE do
  begin
    SetVariable('DATO',Dato);
    SetVariable('TIPO',Tipo);
    Execute;
    Result:=Trim(VarToStr(GetVariable('VALORE')));
  end;
end;

// classe TR450DtM1 //
procedure TR450DtM1.R450DtM1Create(Sender: TObject);
{Preparazione delle Query}
var i:Integer;
begin
  SessioneOracleR450:=SessioneOracle;
  if Self.Owner <> nil then
    if Self.Owner is TOracleSession then
      SessioneOracleR450:=Self.Owner as TOracleSession;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracleR450;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracleR450;
    end;
  DataRiferimentoEsterna.Abilitata:=False;
  RiepPresCartellino:=nil;
  TroncaEccedenze:='CL';
  TroncaLiquidabile:='CL';
  LimiteEccRes:='N';
  LimiteEccLiq:='N';
  LimiteLiquidabileAnnuo:='N';
  //Parametri per il passaggio anno
  {
  PALimite:='';
  PALimiteSaldoAtt:=False;
  }
  PALimite:=9999999;
  PALimiteSaldoAtt:=9999999;
  PALimiteSaldoPrec:=9999999;
  PAAzzeramentoPeriodico:=False;
  PATipoResiduo:=0;
  selT025.Open;
  selT026.Open;
  selT275.Open;
  selT305.Open;
  selT800.Open;
  selT810.Open;
  selT811.Open;
  if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
  begin
    selStorico:=TQueryStorico.Create(Self.Owner);
  end
  else
  begin
    selStorico:=TQueryStorico.Create(SessioneOracleR450);
  end;
  selStorico.Session:=SessioneOracleR450;
  lstAssenzeCumuloS:=TStringList.Create;
  lstPresenzeCumuloS:=TStringList.Create;
  selT265_CumuloS.Execute;
  lstAssenzeCumuloS.CommaText:=VarToStr(selT265_CumuloS.GetVariable('LISTA_ASS'));
  lstPresenzeCumuloS.CommaText:=VarToStr(selT265_CumuloS.GetVariable('LISTA_PRES'));
  selT265_CumuloS.Close;
end;

function TR450DtM1.GetCampiStorici:String;
begin
  Result:='';
  with TStringList.Create do
  try
    Add('T430PERSELASTICO');
    selT800.First;
    while not selT800.Eof do
    begin
      if not selT800.FieldByName('NOMECAMPO1').IsNull then
        if IndexOf('T430' + selT800.FieldByName('NOMECAMPO1').AsString) = -1 then
          Add('T430' + selT800.FieldByName('NOMECAMPO1').AsString);
      if not selT800.FieldByName('NOMECAMPO2').IsNull then
        if IndexOf('T430' + selT800.FieldByName('NOMECAMPO2').AsString) = -1 then
          Add('T430' + selT800.FieldByName('NOMECAMPO2').AsString);
      selT800.Next;
    end;
    Result:=CommaText;
  finally
    Free;
  end;
end;

function TR450DtM1.ConteggiMobili:TDateTime;
{Vengono considerati Conteggi mobili se è asseganta una tipologia cartellino con conteggio mobile
 in un periodo storico che interseca l'anno in elaborazione fino al mese corrente (Anno400 + Mese400)
 In questo caso, la Data da cui considerare le schede è Gennaio dell'anno che contiene il primo mese
 utile per i coneggi mobili, indicato da MesiSaldoPrec.
 Questa è la data da cui si può partire leggendo i residui da tabella}
var MesiOffSet:Integer;
    Mobile:Boolean;
begin
  Result:=EncodeDate(Anno400,1,1);
  Mobile:=False;
  MesiOffset:=-1;
  with selStorico do
  begin
    First;
    //Verifico se un periodo storico dell'anno in corso richiede i conteggi mobili
    while not Eof do
    begin
      if (VarToStr(selT025.Lookup('CODICE',FieldByName('T430PERSELASTICO').AsString,'PERIODICITA_ABBATTIMENTO')) = 'M') and
         (FieldByName('T430DATADECORRENZA').AsDateTime <= R180FineMese(EncodeDate(Anno400,Mese400,1))) and
         (FieldByName('T430DATAFINE').AsDateTime >= EncodeDate(Anno400,1,1)) then
      begin
        MesiOffSet:=selT025.Lookup('CODICE',FieldByName('T430PERSELASTICO').AsString,'MESISALDOPREC');
        if MesiOffSet >= 0 then
        begin
          Mobile:=True;
          Break;
        end;
      end;
      Next;
    end;
    //Se esiste un periodo dell'anno che richiede i conteggi mobili risalgo alla prima decorrenza consecutiva
    //che li richiede, che può essere antecedente all'anno in corso
    if Mobile then
    begin
      First;
      while not Eof do
      begin
        MesiOffSet:=StrToIntDef(VarToStr(selT025.Lookup('CODICE',FieldByName('T430PERSELASTICO').AsString,'MESISALDOPREC')),MesiOffset);
        Mobile:=VarToStr(selT025.Lookup('CODICE',FieldByName('T430PERSELASTICO').AsString,'PERIODICITA_ABBATTIMENTO')) = 'M';
        if Mobile and (MesiOffset >= 0) then
        begin
          Result:=EncodeDate(R180Anno(R180AddMesi(FieldByName('T430DATADECORRENZA').AsDateTime,-MesiOffSet)),1,1);
          Break;
        end;
        Next;
      end;
      (*SearchRecord('T430DATADECORRENZA',Decorrenza,[srFromBeginning]);
      MesiOffSet:=StrToIntDef(VarToStr(selT025.Lookup('CODICE',FieldByName('T430PERSELASTICO').AsString,'MESISALDOPREC')),0);
      while (not Bof) and (Mobile) and (MesiOffSet >= 0) do
      begin
        Result:=EncodeDate(R180Anno(R180AddMesi(FieldByName('T430DATADECORRENZA').AsDateTime,-MesiOffSet)),1,1);
        Prior;
        MesiOffSet:=StrToIntDef(VarToStr(selT025.Lookup('CODICE',FieldByName('T430PERSELASTICO').AsString,'MESISALDOPREC')),MesiOffset);
        Mobile:=VarToStr(selT025.Lookup('CODICE',FieldByName('T430PERSELASTICO').AsString,'PERIODICITA_ABBATTIMENTO')) = 'M';
      end;*)
    end;
  end;
end;

procedure TR450DtM1.ConteggiMese(Chiamante:String; Anno,Mese:Integer; Progressivo:LongInt);
begin
  Caller:=Chiamante;
  Anno400:=Anno;
  Mese400:=Mese;
  Progress400:=Progressivo;
  //Salvo dati originali
  L07SV:=L07;
  //Conteggio dati del mese partendo da inizio anno o dall'inizio della storia del dipendente
  x400_conteggio;
  //Ripristino dati originali
  L07:=L07SV;
end;

function TR450DtM1.GetTipoConteggio:Byte;
var xx:Integer;
begin
  Result:=4;
  Serbatoi[1]:='CP';
  Serbatoi[2]:='LP';
  Serbatoi[3]:='CA';
  Serbatoi[4]:='LA';
  LiquidazioneDistribuita:='S';
  //BancaOreResiduabile:='N';
  //BancaOreResidAnnoPrec:='N';
  selT026.Filtered:=False;
  selT026.Filter:='CODICE = '' ''';
  selT026.Filtered:=True;
  if selStorico.LocDatoStorico(EncodeDate(Anno400,12,31)) and
     selT025.SearchRecord('CODICE',selStorico.FieldByName('T430PERSELASTICO').AsString,[srFromBeginning]) then
    with selT025 do
    begin
      //Lettura dei parametri annuali dei conteggi
      Result:=FieldByName('CONTEGGIO').AsInteger;
      for xx:=Low(Serbatoi) to High(Serbatoi) do Serbatoi[xx]:='';
      Serbatoi[FieldByName('CompPrec').AsInteger]:='CP';
      Serbatoi[FieldByName('LiqPrec').AsInteger]:='LP';
      Serbatoi[FieldByName('CompAtt').AsInteger]:='CA';
      Serbatoi[FieldByName('LiqAtt').AsInteger]:='LA';
      LiquidazioneDistribuita:=FieldByName('LiquidDistribuita').AsString;
      //try BancaOreResiduabile:=FieldByName('BANCAORE_RESID').AsString; except end;
      //try BancaOreResidAnnoPrec:=FieldByName('BANCA_ORE_RESID_ANNOPREC').AsString; except end;
      selT026.Filtered:=False;
      selT026.Filter:='CODICE = ''' + FieldByName('CODICE').AsString + '''';
      selT026.Filtered:=True;
    end;
end;

procedure TR450DtM1.GetTipoConteggioMensile;
var
  xx:Integer;
  CampoNullo: Boolean;

  function ControllaArrotondamento(Dato:Integer):Integer;
  begin
    Result:=Dato;
    if Result = 0 then
      Result:=1;
    if (60 mod Result) > 0 then
      Result:=1;
  end;
begin
  DescT025:='';
  Serbatoi[1]:='CP';
  Serbatoi[2]:='LP';
  Serbatoi[3]:='CA';
  Serbatoi[4]:='LA';
  RicalcoloIndennita:='0';
  RicalcoloIndPresenza:='0';
  RecuperoDebito:=-1;
  RecuperoDebitoMax:=999999;
  RecDebitoMaxTollerato:=0;
  RecuperoDebitoTipo:='0';
  MesiSaldoPrec:=-1;
  TipoLimiteCompA:='N';
  TipoLimiteCompP:='N';
  TipoLimiteCompNoRec:='N';
  LimiteCompA:=-1;
  RecuperoSerbatoi:='G';
  BancaOre:='N';
  BancaOreEsclusaSaldi:='N';
  BancaOreLimitataSaldoComplessivo:='N';
  BancaOreLimitataStrLiquidabile:='N';
  BancaOrePreservata:='N';
  BancaOreMensArr:=1;
  BancaOreAbbattibile:='N';
  BancaOreContrLiquidaz:='M';
  (*Spostato da annuale a mensile!*)BancaOreResiduabile:='N';
  (*Spostato da annuale a mensile!*)BancaOreResidAnnoPrec:='N';
  AbbattimentoLiquidabile:='0';
  PeriodicitaAbbattimento:='F';
  AbbattimentoFissoRecupero:='N';
  SaldoMobile_AbbatteMax:=0;
  SaldoMobile_SaldiUsati:='';
  SaldoMobile_Riferimento:='';
  CausaliCompensabili:='';
  CausaliCompensabiliMensili:='';
  TroncaEccedenze:='CL';
  TroncaLiquidabile:='CL';
  LimiteEccRes:='N';
  LimiteEccLiq:='N';
  LimiteLiquidabileAnnuo:='N';
  SogliaCompLiq:=-1;
  SaldoNegativoMinimo:=0;
  SaldoNegativoMinimoTipo:='0';
  ArrSogliaCompLiq:=1;
  RiposoNonFruito:='';
  RiposoRecupLiquid:='N';
  ArrotondaCP:=1;
  ArrotondaCA:=1;
  ArrotondaLP:=1;
  ArrotondaLA:=1;
  ArrRecScostNeg:=0;  //Alberto: 0 significa che è disattivato il recupero
  RecupStraordPrec:='N';
  AbbattRifLiquidabile:='S';
  AbbattRifCompensabile:='S';
  AbbattRifRecupero:='0';
  CausRipComFasce:='';
  DebAggRappAnno:='N';
  DebAggConsidOrePrec:='N';
  ParCartellino:='';
  IterAutorizzativoStr:='0';
  IterEccGGCheckSaldo:=False;
  //Parametri per il passaggio anno
  {
  PALimite:='';
  PALimiteSaldoAtt:=False;
  }
  PALimite:=9999999;
  PALimiteSaldoAtt:=9999999;
  PALimiteSaldoPrec:=9999999;
  PAAzzeramentoPeriodico:=False;
  PATipoResiduo:=0;
  if selStorico.LocDatoStorico(R180FineMese(EncodeDate(AnnoCorr400,MeseCorr400,1))) and
     selT025.SearchRecord('CODICE',selStorico.FieldByName('T430PERSELASTICO').AsString,[srFromBeginning]) then
    with selT025 do
    begin
      DescT025:=FieldByName('Descrizione').AsString;
      for xx:=Low(Serbatoi) to High(Serbatoi) do Serbatoi[xx]:='';
      Serbatoi[FieldByName('CompPrec').AsInteger]:='CP';
      Serbatoi[FieldByName('LiqPrec').AsInteger]:='LP';
      Serbatoi[FieldByName('CompAtt').AsInteger]:='CA';
      Serbatoi[FieldByName('LiqAtt').AsInteger]:='LA';
      try MesiSaldoPrec:=FieldByName('MesiSaldoPrec').AsInteger; except end;
      try PeriodicitaAbbattimento:=FieldByName('Periodicita_Abbattimento').AsString; except end;
      try SaldoMobile_AbbatteMax:=R180OreMinutiExt(FieldByName('Abbattimento_Mobile_Max').AsString); except end;
      try SaldoMobile_SaldiUsati:=FieldByName('Abbattimento_Mobile_Saldi').AsString; except end;
      try SaldoMobile_Riferimento:=FieldByName('Abbatt_Mobile_Riferimento').AsString; except end;
      try RicalcoloIndennita:=FieldByName('Indennita').AsString; except end;
      try RicalcoloIndPresenza:=FieldByName('IndPresenza').AsString; except end;
      try RecuperoDebito:=FieldByName('RecuperoDebito').AsInteger; except end;
      try RecuperoDebitoMax:=R180OreMinutiExt(FieldByName('RecuperoDebito_Max').AsString); except end;
      try RecDebitoMaxTollerato:=R180OreMinutiExt(FieldByName('RecDebito_MaxTollerato').AsString); except end;
      try RecuperoDebitoTipo:=FieldByName('RecuperoDebito_Tipo').AsString; except end;
      try TipoLimiteCompA:=FieldByName('TipoLimiteCompA').AsString; except end;
      try TipoLimiteCompP:=FieldByName('TipoLimiteCompP').AsString; except end;
      try TipoLimiteCompNoRec:=FieldByName('TipoLimiteComp_NoRec').AsString; except end;
      if not(FieldByName('LimiteCompA').IsNull) then
        try LimiteCompA:=R180OreMinutiExt(FieldByName('LimiteCompA').AsString); except end;
      try RecuperoSerbatoi:=FieldByName('Recupero_Serbatoi').AsString; except end;
      try BancaOre:=FieldByName('BancaOre').AsString; except end;
      try BancaOreEsclusaSaldi:=FieldByName('BANCA_ORE_ESCLUSA_SALDI').AsString; except end;
      try BancaOreLimitataSaldoComplessivo:=FieldByName('BANCA_ORE_LIMITATA_SALDO_COMP').AsString; except end;
      try BancaOreLimitataStrLiquidabile:=FieldByName('BANCA_ORE_LIMITATA_STR_LIQ').AsString; except end;
      (*Spostato da annuale a mensile!*)try BancaOreResiduabile:=FieldByName('BANCAORE_RESID').AsString; except end;
      (*Spostato da annuale a mensile!*)try BancaOreResidAnnoPrec:=FieldByName('BANCA_ORE_RESID_ANNOPREC').AsString; except end;
      try AbbattimentoLiquidabile:=FieldByName('Abbattimento_Liquidabile').AsString; except end;
      try CausaliCompensabili:=FieldByName('Causali_Compensabili').AsString; except end;
      try CausaliCompensabiliMensili:=FieldByName('Causali_Compensabili_Mensili').AsString; except end;
      try TroncaEccedenze:=FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString; except end;
      try TroncaLiquidabile:=FieldByName('LIMITE_MM_ECCRES_TIPO').AsString; except end;
      try LimiteEccRes:=FieldByName('LIMITE_MM_ECCRES_DEFAULT').AsString; except end;
      try LimiteEccLiq:=FieldByName('LIMITE_MM_ECCLIQ_DEFAULT').AsString; except end;
      try LimiteLiquidabileAnnuo:=FieldByName('TRASF_SUPERO_LIQANN').AsString; except end;
      try SogliaCompLiq:=R180OreMinutiExt(FieldByName('SOGLIA_COMP_LIQ').AsString); except end;
      try ArrSogliaCompLiq:=R180OreMinutiExt(FieldByName('ARR_SOGLIA_COMP_LIQ').AsString); except end;
      try SaldoNegativoMinimo:=R180OreMinutiExt(FieldByName('SALDO_NEGATIVO_MINIMO').AsString); except end;
      try SaldoNegativoMinimoTipo:=FieldByName('SALDO_NEGATIVO_MINIMO_TIPO').AsString; except end;
      try RiposoNonFruito:=Trim(FieldByName('RIPOSO_NONFRUITO').AsString); except end;
      try RiposoRecupLiquid:=Trim(FieldByName('RIPOSO_RECUPLIQUID').AsString); except end;
      try ArrotondaCP:=R180OreMinutiExt(FieldByName('ARRREC_COMPPREC').AsString); except end;
      try ArrotondaCA:=R180OreMinutiExt(FieldByName('ARRREC_COMPATT').AsString); except end;
      try ArrotondaLP:=R180OreMinutiExt(FieldByName('ARRREC_LIQPREC').AsString); except end;
      try ArrotondaLA:=R180OreMinutiExt(FieldByName('ARRREC_LIQATT').AsString); except end;
      try ArrRecScostNeg:=R180OreMinutiExt(FieldByName('ARRREC_SCOSTNEG').AsString); except end;
      try BancaOrePreservata:=FieldByName('BANCA_ORE_ESCLUSA_ABBATT').AsString; except end;
      try RecupStraordPrec:=FieldByName('RECUP_STRAORD_PREC').AsString; except end;
      try BancaOreMensArr:=R180OreMinutiExt(FieldByName('BANCA_ORE_MENS_ARR').AsString); except end;
      try BancaOreAbbattibile:=FieldByName('BANCA_ORE_ABBATTIBILE').AsString; except end;
      //Parametri per il passaggio anno
      {
      try PALimite:=FieldByName('PA_LIMITE').AsString; except end;
      try PALimiteSaldoAtt:=FieldByName('PA_LIMITESALDOATT').AsString = 'S'; except end;
      }
      try
        CampoNullo:=StringReplace(StringReplace(Trim(FieldByName('PA_LIMITE').AsString),'.','',[]),':','',[]) = '';
        PALimite:=IfThen(CampoNullo,9999999,R180OreMinutiExt(FieldByName('PA_LIMITE').AsString));
      except end;
      try
        CampoNullo:=StringReplace(StringReplace(Trim(FieldByName('PA_LIMITESALDOATT').AsString),'.','',[]),':','',[]) = '';
        PALimiteSaldoAtt:=IfThen(CampoNullo,9999999,R180OreMinutiExt(FieldByName('PA_LIMITESALDOATT').AsString));
      except end;
      try
        CampoNullo:=StringReplace(StringReplace(Trim(FieldByName('PA_LIMITESALDOPREC').AsString),'.','',[]),':','',[]) = '';
        PALimiteSaldoPrec:=IfThen(CampoNullo,9999999,R180OreMinutiExt(FieldByName('PA_LIMITESALDOPREC').AsString));
      except end;
      PARaggrLimite:=FieldByName('PA_RAGGR_LIMITE').AsString;
      PARaggrLimiteSaldoAtt:=FieldByName('PA_RAGGR_LIMITESALDOATT').AsString;
      PARaggrLimiteSaldoPrec:=FieldByName('PA_RAGGR_LIMITESALDOPREC').AsString;
      try PAAzzeramentoPeriodico:=FieldByName('PA_AZZERAMENTOPERIODICO').AsString = 'S'; except end;
      try PATipoResiduo:=StrToIntDef(FieldByName('PA_TIPORESIDUO').AsString,0); except end;
      try AbbattRifLiquidabile:=FieldByName('ABBATT_RIF_LIQUIDABILE').AsString; except end;
      try AbbattRifCompensabile:=FieldByName('ABBATT_RIF_COMPENSABILE').AsString; except end;
      try AbbattRifRecupero:=FieldByName('ABBATT_RIF_RECUPERO').AsString; except end;
      try AbbattimentoFissoRecupero:=FieldByName('ABBATTIMENTO_FISSO_RECUPERO').AsString; except end;
      try CausRipComFasce:=FieldByName('CAUSRIPCOM_FASCE').AsString; except end;
      try DebAggRappAnno:=FieldByName('DEBAGG_RAPP_ANNO').AsString; except end;
      try DebAggConsidOrePrec:=FieldByName('DEBAGG_CONSIDERA_OREPREC').AsString; except end;
      try ParCartellino:=FieldByName('PAR_CARTELLINO').AsString; except end;
      try IterAutorizzativoStr:=FieldByName('ITER_AUTORIZZATIVO_STR').AsString; except end;
      try BancaOreContrLiquidaz:=FieldByName('BANCA_ORE_CONTR_LIQUIDAZ').AsString; except end;
      try IterEccGGCheckSaldo:=FieldByName('ITER_ECCGG_CHECKSALDO').AsString = 'S'; except end;
      if (SaldoNegativoMinimo > 0) or (SaldoNegativoMinimoTipo <> '1') then
        SaldoNegativoMinimo:=0;
      ArrSogliaCompLiq:=Trunc(ControllaArrotondamento(ArrSogliaCompLiq));
      BancaOreMensArr:=Trunc(ControllaArrotondamento(BancaOreMensArr));
      ArrotondaCP:=ControllaArrotondamento(ArrotondaCP);
      ArrotondaCA:=ControllaArrotondamento(ArrotondaCA);
      ArrotondaLP:=ControllaArrotondamento(ArrotondaLP);
      ArrotondaLA:=ControllaArrotondamento(ArrotondaLA);
      if ArrRecScostNeg <> 0 then
        ArrRecScostNeg:=ControllaArrotondamento(ArrRecScostNeg);
    end;
end;

function TR450DtM1.GetEccAutAnno(Dato:String):LongInt;
{Lettura straordinario autorizzato nell'anno dalla tabella individuale o dal contratto
 I dati sono salvati in un client dataset per non rileggere i dati ogni mese}
begin
  Result:=0;
  if (cdsStrAnnuo.Tag <> Progress400) or (not cdsStrAnnuo.Active) then
  begin
    cdsStrAnnuo.Close;
    if cdsStrAnnuo.FieldDefs.Count = 0 then
    begin
      cdsStrAnnuo.FieldDefs.Add('Data',ftDateTime);
      cdsStrAnnuo.FieldDefs.Add('StrAnno',ftInteger);
      cdsStrAnnuo.FieldDefs.Add('StrAnnoCaus',ftInteger);
      cdsStrAnnuo.FieldDefs.Add('EccAnno',ftInteger);
      cdsStrAnnuo.FieldDefs.Add('StrAnno_Teorico',ftInteger);
      cdsStrAnnuo.FieldDefs.Add('EccAnno_Teorico',ftInteger);
    end;
    cdsStrAnnuo.CreateDataSet;
    cdsStrAnnuo.Tag:=Progress400;
  end;
  //if not cdsStrAnnuo.Locate('Data',DateTostr(EncodeDate(Annocorr400,MeseCorr400,1)),[]) then
  if not cdsStrAnnuo.Locate('Data',EncodeDate(Annocorr400,MeseCorr400,1),[]) then
    with scrStrAnnuo do
    begin
      if (GetVariable('Progressivo') <> Progress400) or
         (GetVariable('Data') <> EncodeDate(AnnoCorr400,MeseCorr400,1)) then
      begin
        SetVariable('Progressivo',Progress400);
        SetVariable('Data',EncodeDate(AnnoCorr400,MeseCorr400,1));
        Execute;
      end;
      cdsStrAnnuo.Append;
      cdsStrAnnuo.FieldByName('Data').AsdateTime:=EncodeDate(AnnoCorr400,MeseCorr400,1);
      cdsStrAnnuo.FieldByName('StrAnno').AsInteger:=GetVariable('MaxStrAnno');
      cdsStrAnnuo.FieldByName('EccAnno').AsInteger:=GetVariable('MaxResAnno');
      cdsStrAnnuo.FieldByName('StrAnnoCaus').AsInteger:=GetVariable('MaxStrAnnoCaus');
      cdsStrAnnuo.Post;
    end;
  //if cdsStrAnnuo.Locate('Data',DateToStr(EncodeDate(Annocorr400,MeseCorr400,1)),[]) then
  if cdsStrAnnuo.Locate('Data',EncodeDate(Annocorr400,MeseCorr400,1),[]) then
    if UpperCase(Dato) = 'LIQUIDABILE' then
      Result:=cdsStrAnnuo.FieldByName('StrAnno').AsInteger
    else if UpperCase(Dato) = 'CAUSALIZZATO' then
      Result:=cdsStrAnnuo.FieldByName('StrAnnoCaus').AsInteger
    else if UpperCase(Dato) = 'RESIDUABILE' then
      Result:=cdsStrAnnuo.FieldByName('EccAnno').AsInteger;
end;

function TR450DtM1.GetStrAutMen:LongInt;
begin
  GetLimitiAutMen;
  Result:=NewStrAutMen;
end;

function TR450DtM1.GetEccResAutMen:LongInt;
begin
  GetLimitiAutMen;
  Result:=NewEccResAutMen;
end;

function TR450DtM1.GetStrAutMen_Teorico:LongInt;
begin
  GetLimitiAutMen;
  Result:=TeorStrAutMen;
end;

function TR450DtM1.GetResAutMen_Teorico:LongInt;
begin
  GetLimitiAutMen;
  Result:=TeorResAutMen;
end;

procedure TR450DtM1.GetLimitiAutMen;
var CL1,CL2,CR1,CR2:String;
    GetLiq,GetRes:Boolean;
begin
  StrAutMenNoCau:=-1;
  TeorStrAutMen:=0;
  TeorResAutMen:=0;
  if LimiteEccLiq = 'Z' then
    NewStrAutMen:=0
  else
    NewStrAutMen:=R180OreMinutiExt('9999.59');
  if LimiteEccRes = 'Z' then
    NewEccResAutMen:=0
  else
    NewEccResAutMen:=R180OreMinutiExt('9999.59');
  GetLiq:=False;
  GetRes:=False;
  (*TroncaEccedenze:='S';
  TroncaLiquidabile:='S';*)
  CL1:='';
  CL2:='';
  CR1:='';
  CR2:='';
  if MeseCorr400 = 0 then
    exit;
  with selT800 do
  begin
    //Lettura modalità di limitazione per il liquidabile
    if SearchRecord('TIPOLIMITE','L',[srFromBeginning]) then
      repeat
        if FieldByName('DATADECORR').AsDateTime <= EncodeDate(AnnoCorr400,12,31) then
        begin
          //TroncaEccedenze:=FieldByName('TRONCA_ECCEDENZE').AsString;
          CL1:=FieldByName('NOMECAMPO1').AsString;
          CL2:=FieldByName('NOMECAMPO2').AsString;
          if CL1 <> '' then
            CL1:='T430' + CL1;
          if CL2 <> '' then
            CL2:='T430' + CL2;
          //NewStrAutMen:=0;
          Break;
        end;
      until not SearchRecord('TIPOLIMITE','L',[]);
    //Lettura modalità di limitazione per il residuabile
    if SearchRecord('TIPOLIMITE','R',[srFromBeginning]) then
      repeat
        if FieldByName('DATADECORR').AsDateTime <= EncodeDate(AnnoCorr400,12,31) then
        begin
          //TroncaLiquidabile:=FieldByName('TRONCA_ECCEDENZE').AsString;
          CR1:=FieldByName('NOMECAMPO1').AsString;
          CR2:=FieldByName('NOMECAMPO2').AsString;
          if CR1 <> '' then
            CR1:='T430' + CR1;
          if CR2 <> '' then
            CR2:='T430' + CR2;
          //NewEccResAutMen:=0;
          Break;
        end;
      until not SearchRecord('TIPOLIMITE','R',[]);
  end;
  //Lettura limiti mensili individuali liquidabile/residuabile
  //Alberto 16/01/2006
  with selT820 do
  begin
    if SearchRecord('ANNO;MESE',VarArrayOf([AnnoCorr400,MeseCorr400]),[srFromBeginning]) then
    repeat
      if FieldByName('LIQUIDABILE').AsString = 'N' then
      begin
        //Residuabile
        inc(TeorResAutMen,R180OreMinutiExt(FieldByName('ORE_TEORICHE').AsString));
        if not FieldByName('ORE').IsNull then
        begin
          if NewEccResAutMen = R180OreMinutiExt('9999.59') then
            NewEccResAutMen:=0;
          inc(NewEccResAutMen,R180OreMinutiExt(FieldByName('ORE').AsString));
          GetRes:=True;
        end;
      end
      else
      begin
        //Liquidabile
        inc(TeorStrAutMen,R180OreMinutiExt(FieldByName('ORE_TEORICHE').AsString));
        if not FieldByName('ORE').IsNull then
        begin
          if StrAutMenNoCau = -1 then
            StrAutMenNoCau:=0;
          if FieldByName('CAUSALE').AsString = A000LimiteMensileLiquidabile then
          begin
            inc(StrAutMenNoCau,R180OreMinutiExt(FieldByName('ORE').AsString));
            if NewStrAutMen = R180OreMinutiExt('9999.59') then
              NewStrAutMen:=0;
            inc(NewStrAutMen,R180OreMinutiExt(FieldByName('ORE').AsString));
            GetLiq:=True;
          end;
        end;
      end;
    until not (SearchRecord('ANNO;MESE',VarArrayOf([AnnoCorr400,MeseCorr400]),[]));
  end;

  //Ho già letto i limiti individuali
  if GetRes and GetLiq then
    exit;
  //Lettura limiti mensili per aggregazione
  //Limite liquidabile
  if not selStorico.LocDatoStorico(R180FineMese(EncodeDate(AnnoCorr400,MeseCorr400,1))) then
    exit;
  if (not GetLiq) and (CL1 <> '') then
  begin
    if CL2 = '' then
    begin
      if selT810.SearchRecord('CAMPO1;ANNO;MESE',VarArrayOf([selStorico.FieldByName(CL1).AsString,AnnoCorr400,MeseCorr400]),[srFromBeginning]) then
        NewStrAutMen:=R180OreMinutiExt(selT810.FieldByName('Valore').AsString);
    end
    else
    begin
      if selT810.SearchRecord('CAMPO1;CAMPO2;ANNO;MESE',VarArrayOf([selStorico.FieldByName(CL1).AsString,selStorico.FieldByName(CL2).AsString,AnnoCorr400,MeseCorr400]),[srFromBeginning]) then
        NewStrAutMen:=R180OreMinutiExt(selT810.FieldByName('Valore').AsString);
    end;
  end;
  //Limite residuabile
  if (not GetRes) and (CR1 <> '') then
  begin
    if CR2 = '' then
    begin
      if selT811.SearchRecord('CAMPO1;ANNO;MESE',VarArrayOf([selStorico.FieldByName(CR1).AsString,AnnoCorr400,MeseCorr400]),[srFromBeginning]) then
        NewEccResAutMen:=R180OreMinutiExt(selT811.FieldByName('Valore').AsString);
    end
    else
    begin
      if selT811.SearchRecord('CAMPO1;CAMPO2;ANNO;MESE',VarArrayOf([selStorico.FieldByName(CR1).AsString,selStorico.FieldByName(CR2).AsString,AnnoCorr400,MeseCorr400]),[srFromBeginning]) then
        NewEccResAutMen:=R180OreMinutiExt(selT811.FieldByName('Valore').AsString);
    end;
  end;
  if StrAutMenNoCau = -1 then
    StrAutMenNoCau:=NewStrAutMen;
end;

function TR450DtM1.GetStrEsterno:LongInt;
begin
  Result:=0;
  if selT075.SearchRecord('DATA',EncodeDate(AnnoCorr400,MeseCorr400,1),[srFromBeginning]) then
    Result:=selT075.FieldByName('mm').AsInteger;
end;

function TR450DtM1.GetOreCausLiqSenzaLimiti:LongInt;
var i,j,Reso:Integer;
begin
  Result:=0;
  for i:=0 to High(RiepPres) do
    if selT275.SearchRecord('CODICE',RiepPres[i].Causale,[srFromBeginning]) then
      if (selT275.FieldByName('NO_LIMITE_MENSILE_LIQ').AsString = 'S') and
         ((selT275.FieldByName('ORENORMALI').AsString = 'B') or
          (selT275.FieldByName('ORENORMALI').AsString = 'D')) then
      begin
        Reso:=0;
        for j:=1 to MaxFasce do
          inc(Reso,RiepPres[i].OreReseMese[j]);
        if RiepPres[i].LimiteMensile >= 0 then
          Reso:=Min(Reso,RiepPres[i].LimiteMensile);
        inc(Result,Reso);
      end;
end;

function TR450DtM1.GetOreCausMeseIncluseSaldi:LongInt;
var i,j:Integer;
begin
  Result:=0;
  for i:=0 to High(RiepPres) do
    if selT275.SearchRecord('CODICE',RiepPres[i].Causale,[srFromBeginning]) then
      if (selT275.FieldByName('INCLUSIONE_SALDI_CAUSALI').AsString = 'S') and
         (selT275.FieldByName('ORENORMALI').AsString = 'A') then
        for j:=1 to MaxFasce do
          inc(Result,RiepPres[i].OreReseMese[j]);
end;

function TR450DtM1.GetOreCausAnnoIncluseSaldi:LongInt;
var i,j:Integer;
begin
  Result:=0;
  for i:=0 to High(RiepPres) do
    if selT275.SearchRecord('CODICE',RiepPres[i].Causale,[srFromBeginning]) then
      if (selT275.FieldByName('INCLUSIONE_SALDI_CAUSALI').AsString = 'S') and
         (selT275.FieldByName('ORENORMALI').AsString = 'A') then
        for j:=1 to MaxFasce do
          inc(Result,RiepPres[i].Residuo[j]);
end;

function TR450DtM1.GetOreCausLiqEsterneInBudget:Integer;
var i,j:Integer;
begin
  Result:=0;
  for i:=0 to High(RiepPres) do
  if selT275.SearchRecord('CODICE',RiepPres[i].Causale,[srFromBeginning]) then
    if (selT275.FieldByName('ABBATTE_BUDGET').AsString = 'L') and
       (selT275.FieldByName('ORENORMALI').AsString = 'A') then
    begin
      for j:=1 to MaxFasce do
        inc(Result,RiepPres[i].LiquidatoMese[j]);
    end;
end;

function TR450DtM1.GetOreBOMese(Causale:String; Fascia:Integer):Integer;
var i:Integer;
begin
  Result:=0;
  try
    for i:=0 to High(RiepPres) do
      if RiepPres[i].Causale = Causale then
        Result:=RiepPres[i].OreBOMese[Fascia];
  except
  end;
end;

function TR450DtM1.GetOreCausReseEsterneInBO:Integer;
var i,j:Integer;
begin
  Result:=0;
  for i:=0 to High(RiepPres) do
  if selT275.SearchRecord('CODICE',RiepPres[i].Causale,[srFromBeginning]) then
    if (selT275.FieldByName('ABBATTE_BUDGET').AsString = 'B') and
       (selT275.FieldByName('ORENORMALI').AsString = 'A') then
    begin
      for j:=1 to MaxFasce do
        inc(Result,RiepPres[i].OreReseMese[j]);
    end;
end;

function TR450DtM1.GetOreCausLiqEsterneInBO:Integer;
var i,j:Integer;
begin
  Result:=0;
  for i:=0 to High(RiepPres) do
  if selT275.SearchRecord('CODICE',RiepPres[i].Causale,[srFromBeginning]) then
    if (selT275.FieldByName('ABBATTE_BUDGET').AsString = 'B') and
       (selT275.FieldByName('ORENORMALI').AsString = 'A') then
    begin
      for j:=1 to MaxFasce do
        inc(Result,RiepPres[i].LiquidatoMese[j]);
    end;
end;

function TR450DtM1.GetOreCausLiqIncluse:Integer;
var i,j:Integer;
begin
  Result:=0;
  for i:=0 to High(RiepPres) do
  if selT275.SearchRecord('CODICE',RiepPres[i].Causale,[srFromBeginning]) then
    if (selT275.FieldByName('ORENORMALI').AsString <> 'A') then
    begin
      for j:=1 to MaxFasce do
        inc(Result,RiepPres[i].LiquidatoMese[j]);
    end;
end;

function TR450DtM1.GetBOMaturataCausEsterne:Integer;
var i,j:Integer;
begin
  Result:=0;
  for i:=0 to High(RiepPres) do
  if selT275.SearchRecord('CODICE',RiepPres[i].Causale,[srFromBeginning]) then
    if (selT275.FieldByName('ABBATTE_BUDGET').AsString = 'B') and
       (selT275.FieldByName('ORENORMALI').AsString = 'A') then
    begin
      for j:=1 to MaxFasce do
        inc(Result,RiepPres[i].OreBOMese[j]);
    end;
end;

function TR450DtM1.GetEccedenzaMensile:LongInt;
var i:Integer;
begin  //ECCEDENZA LIQUIDABILE MATURATA NEL MESE
  Result:=0;
  for i:=1 to NFasceMese do
    Result:=Result + tminstrmen[i];
end;

function TR450DtM1.GetCompensabileMensileNettoRiposi:LongInt;
begin
  if (RiposoRecupLiquid = 'S') and (RiposoNonFruito <> '') then
    Result:=FCompensabileMensile - RiposiNonFruitiOre
  else
    Result:=FCompensabileMensile;
end;

function TR450DtM1.GetElencoSerbatoi:String;
var i:Integer;
begin  //ECCEDENZA LIQUIDABILE MATURATA NEL MESE
  Result:='';
  for i:=1 to 4 do
  begin
    if Result <> '' then Result:=Result + ',';
    Result:=Result + Serbatoi[i];
  end;
end;

function TR450DtM1.GetNegativiNonRecuperati:Integer;
begin
  Result:=0;
  if High(RiepilogoMese) > 0 then
    Result:=RiepilogoMese[High(RiepilogoMese)].NegativiNonRecuperati;
end;

function TR450DtM1.GetSaldoMobileAbbattibile:Integer;
begin
  Result:=0;
  if High(RiepilogoMese) > 0 then
    Result:=RiepilogoMese[High(RiepilogoMese)].RiepSaldiMobili_SaldoPrecedente;
end;

function TR450DtM1.GetSaldoMobileDisponibile:Integer;
begin
  Result:=0;
  if High(RiepilogoMese) > 0 then
    Result:=RiepilogoMese[High(RiepilogoMese)].RiepSaldiMobili_SaldoDisponibile;
end;

function TR450DtM1.GetSaldoMobileRecupero(D:TDateTime):Integer;
var i:Integer;
begin
  Result:=0;
  for i:=0 to High(RiepilogoMese) do
    if RiepilogoMese[i].Data = D then
    begin
      Result:=RiepilogoMese[i].RiepSaldiMobili_Recupero;
      Break;
    end;
end;

procedure TR450DtM1.x300_GetFasceMese(Anno,Mese:Integer; ResetFasce:Boolean);
var i:Integer;
begin
  with FasceCount do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progress400);
    try
      SetVariable('DATA',R180FineMese(EncodeDate(Anno,Mese,1)));
      Open;
      //NFasceMese:=Fields[0].AsInteger;
      NFasceMese:=RecordCount;
      if ResetFasce then  //Alberto: corretto per gestire il cambiamento di fasce da un mese all'altro sulla shceda riepilogativa (riepil.presenze)
      begin
        i:=1;
        while not Eof do
        begin
          tfasce[i]:=FieldByName('CODICE').AsString;
          tmaggioraz[i]:=FieldByName('MAGGIORAZIONE').AsInteger;
          Next;
          inc(i);
        end;
      end;
      Close;
    except
      NFasceMese:=4;
    end;
    Close;
  end;
end;

procedure TR450DtM1.x400_Conteggio;
var AnnoOld,AnnoResidui,i,yy:Integer;
    CampiStorici:String;
    DataIniziale:TDateTime;
  procedure AzzeramentoVariabiliAnnuali;
  {Inizializzazioni annuali}
  var xx:integer;
  begin
    for xx:=Low(tstrmese) to High(tstrmese) do tstrmese[xx]:=0;
    for xx:=Low(tstranno) to High(tstranno) do tstranno[xx]:=0;
    for xx:=Low(tstrannom) to High(tstrannom) do tstrannom[xx]:=0;
    for xx:=Low(tstrliq) to High(tstrliq) do tstrliq[xx]:=0;
    for xx:=Low(tbancaore) to High(tbancaore) do tbancaore[xx]:=0;
    vareccliqanno:=0;
    FBancaOreLiquidata:=0;
    FBancaOreAnno:=0;
    FBancaOreResidua:=0;
    FBancaOreResiduaPrec:=0;
    FBancaOreRecuperata:=0;
    FBancaOreRecAnnoPrec:=0;
    FBancaOreRecInterna:=0;
    CarenzaObbligatoria:=0;
    LiqAnnoCauEstIncBud:=0;
    ResoAnnoCauEstIncBO:=0;
    BOMaturataCausEsterneAnno:=0;
    debpoannores:=0;  //Alberto 28/02/2008: Collegno
    //Riepiloghi precedenti per stampe
    RiepilogoPrecedente.BancaOreResidua:=0;
    RiepilogoPrecedente.BancaOreResiduaPrec:=0;
    RiepilogoPrecedente.CompensabileAtt:=0;
    RiepilogoPrecedente.CompensabilePrec:=0;
    RiepilogoPrecedente.LiquidabileAtt:=0;
    RiepilogoPrecedente.LiquidabilePrec:=0;
    RiepilogoPrecedente.CompAttMaggiorato:=0;
    RiepilogoPrecedente.LiqAttMaggiorato:=0;
    RiepilogoPrecedente.StrResiduoAnno:=0;
  end;
  procedure AzzeramentoVariabiliMensili;
  {Inizializzazioni mensili}
  var i,xx:integer;
  begin
    for xx:=1 to MaxFasce do
    begin
      L07.tmaggioraz[xx]:=0;
      L07.tfasce[xx]:='';
      L07.tminlavmese[xx]:=0;
      L07.tmininturno[xx]:=0;
      L07.tdatiassestamento[1].tminassest[xx]:=0;
      L07.tdatiassestamento[2].tminassest[xx]:=0;
      L07.tminstrmens[xx]:=0;
      L07.tstrliquidatomm[xx]:=0;
      L07.tliqnelmese[xx]:=0;
      tstrannom[xx]:=0;
      tliqnelmese[xx]:=0;
      tstrliqmm[xx]:=0;
    end;
    L07.tdatiassestamento[1].tcauassest:='';
    L07.tdatiassestamento[2].tcauassest:='';
    L07.fesintmesVar:=0;
    L07.fesridmesVar:=0;
    L07.notggmesVar:=0;
    L07.notminmesVar:='';
    salmeseatt:=0;
    OreEsclComp:=0;
    NFasceMese:=0;
    RiposiNonFruitiGG:=0;
    RiposiNonFruitiOre:=0;
    FBancaOreRecInternaMensile:=0;
    for i:=0 to High(RiepPres) do
    begin
      for xx:=1 to MaxFasce do RiepPres[i].OreReseMese[xx]:=0;
      for xx:=1 to MaxFasce do RiepPres[i].OreBOMese[xx]:=0;
      for xx:=1 to MaxFasce do RiepPres[i].LiquidatoMese[xx]:=0;
      for xx:=1 to MaxFasce do RiepPres[i].Abbattimento[xx]:=0;
      RiepPres[i].CompensabileMese:=0;
      RiepPres[i].CompensabileMeseEff:=0;
    end;
  end;
begin
  //Azzeramenti iniziali variabili di output
  TotLiquidNelMese:=0;
  LiquidabileMensileSenzaLimiti:=0;
  liquidabmese:=0;
  totoreres:=0;
  debtotmes:=0;
  salmeseatt:=0;
  salfmprec:=0;
  salfmprecnetto:=0;
  salannoatt:=0;
  salannonetto:=0;
  debpoanno:=0;
  poreso:=0;
  poresoanno:=0;
  salpoanno:=0;
  eccsolocompanno:=0;
  eccsolocompres:=0;
  totoreresori:=0;
  salripcommes:=0;
  salripcom:=0;
  salripcomfmprec:=0;
  salcompannoprec:=0;
  salliqannoprec:=0;
  salcompannoatt:=0;
  salcompannoattExt:=0;
  salliqannoatt:=0;
  abbannopreceff:=0;
  abbannoatteff:=0;
  CarenzaObbligatoria:=0;
  FAddebitoPaghe:=0;
  FCompensabileAnnuo:=0;
  LiqOreAnniPrec:=0;
  VariazioneSaldo:=0;
  DataVariazSaldiPrec:=0;
  NoteVariazSaldiPrec:='';
  totliqmm:=0;
  totcausliqmm:=0;
  azzsaldofmpos:='N';
  ScostNegDaAbbattere:=0;
  SaldoDaAbbattere:=0;
  SaldoNegativoMinimoEcced:=0;
  {*}
  for i:=0 to High(RiepilogoMese) do
    SetLength(RiepilogoMese[i].RiepPres,0);
  {*}
  SetLength(RiepilogoMese,0);
  SetLength(RiepPres,0);
  SetLength(RiepAssenzeCumuloS,0);
  SetLength(RiepilogoRecuperiRiepPres,0);
  //Lettura ultimo mese lavorativo dell'anno
  with selT430InizioFine do
  begin
    Close;
    SetVariable('Progressivo',Progress400);
    Open;
  end;
  //Lettura del periodo di rapporto valido
  with selT430 do
  begin
    Close;
    SetVariable('Progressivo',Progress400);
    //DataRiferimentoEsterna può essere valorizzata da TR600DtM1.GetBancaOre
    if (DataRiferimentoEsterna.Abilitata) and (DataRiferimentoEsterna.Data > 0) then
      SetVariable('Data',DataRiferimentoEsterna.Data)
    else
      SetVariable('Data',EncodeDate(Anno400,Mese400,1));
    Open;
  end;
  //Lettura dati storici utilizzati per il Tipo Cartellino e i limiti di budget
  CampiStorici:=GetCampiStorici;
  selStorico.GetDatiStorici(CampiStorici,Progress400,EncodeDate(1900,1,1),EncodeDate(3999,12,31));
  DataIniziale:=ConteggiMobili;
  R455_tipocon:=TipoConteggio;
  //Apertura query individuali
  selT070.Filtered:=False;
  with selT134 do
  begin
    SetVariable('PROGRESSIVO',Progress400);
    SetVariable('DATA',DataIniziale);
    Close;
    Open;
  end;
  if (Progress400 <> selT070.GetVariable('PROGRESSIVO')) or
     (DataIniziale <> selT070.GetVariable('DATA1')) or
     (EncodeDate(Anno400,Mese400,1) <> selT070.GetVariable('DATA2')) then
  begin
    with selT070 do
    begin
      Filter:='DATA = ' + FloatToStr(EncodeDate(Anno400,Mese400,1));
      SetVariable('PROGRESSIVO',Progress400);
      SetVariable('DATA1',DataIniziale);
      SetVariable('DATA2',EncodeDate(Anno400,Mese400,1));
      Close;
      Open;
    end;
    with selT071 do
    begin
      SetVariable('PROGRESSIVO',Progress400);
      SetVariable('DATA1',DataIniziale);
      SetVariable('DATA2',EncodeDate(Anno400,Mese400,1));
      Close;
      Open;
    end;
    with selT073 do
    begin
      Close;
      SetVariable('Progressivo',Progress400);
      SetVariable('Data1',DataIniziale);
      SetVariable('Data2',EncodeDate(Anno400,Mese400,1));
      Open;
    end;
    with selT074 do
    begin
      Close;
      SetVariable('Progressivo',Progress400);
      SetVariable('Data1',DataIniziale);
      SetVariable('Data2',EncodeDate(Anno400,Mese400,1));
      Open;
    end;
    with selT074liq do
    begin
      Close;
      SetVariable('Progressivo',Progress400);
      SetVariable('Data1',R180AddMesi(EncodeDate(Anno400,Mese400,1),1));
      SetVariable('Data2',EncodeDate(Anno400,12,1));
      Open;
    end;
    if selT070.RecordCount = 0 then
      AnnoResidui:=Anno400
    else
      AnnoResidui:=R180Anno(selT070.FieldByName('DATA').AsDateTime);
    with selT130 do
    begin
      SetVariable('PROGRESSIVO',Progress400);
      SetVariable('ANNO1',AnnoResidui);
      SetVariable('ANNO2',AnnoResidui);
      Close;
      Open;
    end;
    with selT131 do
    begin
      SetVariable('PROGRESSIVO',Progress400);
      SetVariable('ANNO1',AnnoResidui);
      SetVariable('ANNO2',AnnoResidui);
      Close;
      Open;
    end;
    (*Alberto 16/01/2006*)
    with selT820 do
    begin
      Close;
      SetVariable('PROGRESSIVO',Progress400);
      SetVariable('DATA1',R180AddMesi(DataIniziale,-1));
      SetVariable('DATA2',EncodeDate(Anno400,Mese400,1));
      Open;
    end;
    R180SetVariable(selT011,'PROGRESSIVO',Progress400);
    R180SetVariable(selT011,'DATA1',DataIniziale);
    R180SetVariable(selT011,'DATA2',EncodeDate(Anno400,Mese400,1));

    x300_GetFasceMese(Anno400,Mese400,False);
  end
  else
  begin
    selT070.First;
    if selT070.RecordCount = 0 then
      AnnoResidui:=Anno400
    else
      AnnoResidui:=R180Anno(selT070.FieldByName('DATA').AsDateTime);
  end;
  //Leggo sempre selT075 per avere i dati aggiornati quando vengono modificati sulla scheda
  with selT075 do
  begin
    SetVariable('PROGRESSIVO',Progress400);
    SetVariable('DATA1',DataIniziale);
    SetVariable('DATA2',EncodeDate(Anno400,Mese400,1));
    Close;
    Open;
  end;
  NFasceMeseNew:=NFasceMese;
  //Lettura dati annuali
  AzzeramentoVariabiliAnnuali;
  //Lettura residui anno precedente e salvataggio come dati del mese precedente
  AnnoCorr400:=AnnoResidui;
  MeseCorr400:=1;
  GetTipoConteggioMensile;
  selT070.First;
  AnnoOld:=R180Anno(selT070.FieldByName('DATA').AsDateTime);
  AnnoCorr400:=R180Anno(selT070.FieldByName('DATA').AsDateTime);
  MeseCorr400:=R180Mese(selT070.FieldByName('DATA').AsDateTime);
  x401_leggiresid(True);
  x402_salvresid;
  ImpostaRiepilogoPresenze(True);
  //Calcolo dati cumulativi dei mesi precedenti
  while not selT070.Eof do
  begin
    //Impostazione e conteggio dati di un mese
    for yy:=Low(ttrovscheda) to High(ttrovscheda) do ttrovscheda[yy]:=0;
    AnnoCorr400:=R180Anno(selT070.FieldByName('DATA').AsDateTime);
    MeseCorr400:=R180Mese(selT070.FieldByName('DATA').AsDateTime);
    GetTipoConteggioMensile;
    if (PeriodicitaAbbattimento = 'M') or (MesiSaldoPrec < 0) then
      FOrePersePeriodiche:=0;
    if AnnoCorr400 <> AnnoOld then
    begin
      //Lettura dati annuali
      AzzeramentoVariabiliAnnuali;
      //Lettura residui anno precedente e salvataggio come dati del mese preccedente
      x401_leggiresid(False);
      x402_salvresid;
      ImpostaRiepilogoPresenze(False);
      AnnoOld:=AnnoCorr400;
    end;
    AzzeramentoVariabiliMensili;
    if (selT070.FieldByName('DATA').AsDateTime >= selT430.FieldByName('INIZIO').AsDateTime) and
       (selT070.FieldByName('DATA').AsDateTime <= selT430.FieldByName('FINE').AsDateTime) then
      x404_impcontmese;
    if ttrovscheda[MeseCorr400] = 1 then
      //Salvataggio dati attuali come dati mese precedente
      x472_saldatiprec;
    selT070.Next;
  end;
  //Non esiste la scheda del mese richiesto, ma leggo ugualmente i dati salvati in memoria
  if (AnnoCorr400 <> Anno400) or (MeseCorr400 <> Mese400) then
  begin
    AnnoCorr400:=Anno400;
    MeseCorr400:=Mese400;
    GetTipoConteggioMensile;
    if (PeriodicitaAbbattimento = 'M') or (MesiSaldoPrec < 0) then
      FOrePersePeriodiche:=0;
    AzzeramentoVariabiliMensili;
    x404_impcontmese;
  end;
  selT070.Filtered:=True;
  NFasceMese:=NFasceMeseNew;
end;

procedure TR450DtM1.ImpostaRiepilogoPresenze(LeggiTabella:Boolean);
{Lettura di tutti i riepiloghi presenze dell'anno.
 Vengono letti i residui in questo modo:
   la prima volta sempre da tabella, le eventuali volte successive (conteggi mobili) vengono ribaltati
   i riepiloghi calcolati}
var i,k,xx,MaxResiduo,OreRes,TotRes:Integer;
    RiepPresResiduo:array of TRiepPres;
begin
  //Mantengo i residui per le causali residuabili considerando se il periodo di assunzione è valido
  RiepPresResiduo:=nil;
  RiepAssenzeCumuloS:=nil;
  if LeggiTabella then
  begin
    with selT131 do
    begin
      First;
      while not Eof do
      begin
        //Il residuabile lo controllo ma non lo gestisco in quanto già gestito nel passaggio di anno
        MaxResiduo:=R180OreMinutiExt(VarToStr(selT275.Lookup('CODICE',FieldByName('Causale').AsString,'RESIDUABILE')));
        if (MaxResiduo > 0) and
           (selT430.FieldByName('Inizio').AsDateTime <= EncodeDate(FieldByName('ANNO').AsInteger - 1,12,31)) then
        begin
          SetLength(RiepPresResiduo,Length(RiepPresResiduo) + 1);
          k:=High(RiepPresResiduo);
          RiepPresResiduo[k].Causale:=FieldByName('Causale').AsString;
          RiepPresResiduo[k].CompensabileAnno:=0;
          RiepPresResiduo[k].CompensabileAnnoEff:=0;
          RiepPresResiduo[k].CompensabileMese:=0;
          RiepPresResiduo[k].CompensabileMeseEff:=0;
          RiepPresResiduo[k].RecuperoAnno:=0;
          RiepPresResiduo[k].RecuperoMese:=0;
          for xx:=1 to MaxFasce do RiepPresResiduo[k].Liquidato[xx]:=0;
          for xx:=1 to MaxFasce do RiepPresResiduo[k].LiquidatoMese[xx]:=0;
          for xx:=1 to MaxFasce do RiepPresResiduo[k].OreReseMese[xx]:=0;
          for xx:=1 to MaxFasce do RiepPresResiduo[k].Abbattimento[xx]:=0;
          for xx:=1 to MaxFasce do RiepPresResiduo[k].OreBOMese[xx]:=0;
          for xx:=1 to MaxFasce do RiepPresResiduo[k].Residuo[xx]:=0;
          for xx:=1 to MaxFasce do RiepPresResiduo[k].AnnoPrec[xx]:=0;
          for xx:=1 to 6 do RiepPresResiduo[k].Residuo[xx]:=R180OreMinutiExt(FieldByName('ORE_FASCIA' + IntToStr(xx)).AsString);
          for xx:=1 to 6 do RiepPresResiduo[k].AnnoPrec[xx]:=R180OreMinutiExt(FieldByName('ORE_FASCIA' + IntToStr(xx)).AsString);
          for xx:=1 to 6 do RiepPresResiduo[k].OreRese[xx]:=RiepPresResiduo[k].Residuo[xx];
          if VarToStr(selT275.Lookup('CODICE',FieldByName('Causale').AsString,'RESIDUO_LIQUIDABILE')) = 'S' then
            for xx:=1 to MaxFasce do RiepPresResiduo[k].Liquidabile[xx]:=RiepPresResiduo[k].Residuo[xx];
        end;
        Next;
      end;
    end;
  end
  else if selT430.FieldByName('Inizio').AsDateTime <= EncodeDate(AnnoCorr400 - 1,12,31) then
    for i:=0 to High(RiepPres) do
    begin
      MaxResiduo:=R180OreMinutiExt(VarToStr(selT275.Lookup('CODICE',RiepPres[i].Causale,'RESIDUABILE')));

      //Quando ci sono i conteggi mobili si arriva qui e si deve
      //aggiornare la lettura dei residui per verificare il limite residuabile
      if Pos('<URCP>',DescT025) > 0 then
        with selT131 do
        begin
          SetVariable('ANNO1',AnnoCorr400);
          SetVariable('ANNO2',AnnoCorr400);
          Close;
          Open;
          if SearchRecord('CAUSALE',RiepPres[i].Causale,[srFromBeginning]) then
          begin
            MaxResiduo:=0;
            for xx:=1 to 6 do
              MaxResiduo:=MaxResiduo + R180OreMinutiExt(FieldByName('ORE_FASCIA' + IntToStr(xx)).AsString);
            MaxResiduo:=min(MaxResiduo,R180OreMinutiExt(VarToStr(selT275.Lookup('CODICE',RiepPres[i].Causale,'RESIDUABILE'))));
          end
          else
            MaxResiduo:=0;
        end;

      if MaxResiduo > 0 then
      begin
        TotRes:=0;
        for xx:=MaxFasce downto 1 do
        begin
          OreRes:=min(MaxResiduo,RiepPres[i].Residuo[xx]);
          dec(MaxResiduo,OreRes);
          RiepPres[i].Residuo[xx]:=OreRes;
          inc(TotRes,OreRes);
        end;
        if TotRes = 0 then
          Continue;
        SetLength(RiepPresResiduo,Length(RiepPresResiduo) + 1);
        k:=High(RiepPresResiduo);
        RiepPresResiduo[k]:=RiepPres[i];
        RiepPresResiduo[k].CompensabileAnno:=0;
        RiepPresResiduo[k].CompensabileAnnoEff:=0;
        RiepPresResiduo[k].CompensabileMese:=0;
        RiepPresResiduo[k].CompensabileMeseEff:=0;
        RiepPresResiduo[k].RecuperoAnno:=0;
        RiepPresResiduo[k].RecuperoMese:=0;
        for xx:=1 to MaxFasce do RiepPresResiduo[k].Liquidato[xx]:=0;
        for xx:=1 to MaxFasce do RiepPresResiduo[k].LiquidatoMese[xx]:=0;
        for xx:=1 to MaxFasce do RiepPresResiduo[k].OreReseMese[xx]:=0;
        for xx:=1 to MaxFasce do RiepPresResiduo[k].Abbattimento[xx]:=0;
        for xx:=1 to MaxFasce do RiepPresResiduo[k].OreBOMese[xx]:=0;
        for xx:=1 to MaxFasce do RiepPresResiduo[k].OreRese[xx]:=RiepPresResiduo[k].Residuo[xx];
        for xx:=1 to MaxFasce do RiepPresResiduo[k].AnnoPrec[xx]:=RiepPresResiduo[k].Residuo[xx];
        if VarToStr(selT275.Lookup('CODICE',RiepPres[i].Causale,'RESIDUO_LIQUIDABILE')) = 'S' then
          for xx:=1 to MaxFasce do RiepPresResiduo[k].Liquidabile[xx]:=RiepPresResiduo[k].Residuo[xx]
        else
          for xx:=1 to MaxFasce do RiepPresResiduo[k].Liquidabile[xx]:=0;
      end;
    end;
  RiepPres:=nil;
  for i:=0 to High(RiepPresResiduo) do
  begin
    SetLength(RiepPres,Length(RiepPres) + 1);
    RiepPres[i]:=RiepPresResiduo[i];
  end;
  //Lettura delle causali utilizzate nell'anno e registrazione in RiepPres
  with selT073 do
  begin
    Filtered:=False;
    First;
    while not Eof do
    begin
      if R180Anno(FieldByName('DATA').AsDateTime) = AnnoCorr400 then
      begin
        k:=IndiceRiepPres(FieldByName('CAUSALE').AsString);
        if k = -1 then
        begin
          k:=High(RiepPres) + 1;
          SetLength(RiepPres,k + 1);
          RiepPres[k].Causale:=FieldByName('CAUSALE').AsString;
          RiepPres[k].CompensabileMese:=0;
          RiepPres[k].CompensabileMeseEff:=0;
          RiepPres[k].CompensabileAnno:=0;
          RiepPres[k].CompensabileAnnoEff:=0;
          RiepPres[k].RecuperoAnno:=0;
          RiepPres[k].RecuperoMese:=0;
          for xx:=1 to MaxFasce do RiepPres[k].Liquidabile[xx]:=0;
          for xx:=1 to MaxFasce do RiepPres[k].Liquidato[xx]:=0;
          for xx:=1 to MaxFasce do RiepPres[k].LiquidatoMese[xx]:=0;
          for xx:=1 to MaxFasce do RiepPres[k].OreRese[xx]:=0;
          for xx:=1 to MaxFasce do RiepPres[k].OreReseMese[xx]:=0;
          for xx:=1 to MaxFasce do RiepPres[k].Abbattimento[xx]:=0;
          for xx:=1 to MaxFasce do RiepPres[k].OreBOMese[xx]:=0;
          for xx:=1 to MaxFasce do RiepPres[k].Residuo[xx]:=0;
          for xx:=1 to MaxFasce do RiepPres[k].AnnoPrec[xx]:=0;
        end;
      end;
      Next;
    end;
  end;
end;

procedure TR450DtM1.ConteggiRiepiloghiPresenza;
var Trov:Boolean;
    i,k,xx:Integer;
begin
  AppRiepPres.Causale:='';
  AppRiepPres.CompensabileAnno:=0;
  AppRiepPres.CompensabileAnnoEff:=0;
  AppRiepPres.CompensabileMese:=0;
  AppRiepPres.CompensabileMeseEff:=0;
  for xx:=1 to MaxFasce do AppRiepPres.Liquidabile[xx]:=0;
  for xx:=1 to MaxFasce do AppRiepPres.Liquidato[xx]:=0;
  for xx:=1 to MaxFasce do AppRiepPres.LiquidatoMese[xx]:=0;
  for xx:=1 to MaxFasce do AppRiepPres.OreRese[xx]:=0;
  for xx:=1 to MaxFasce do AppRiepPres.OreReseMese[xx]:=0;
  for xx:=1 to MaxFasce do AppRiepPres.Abbattimento[xx]:=0;
  for xx:=1 to MaxFasce do AppRiepPres.OreBOMese[xx]:=0;
  for xx:=1 to MaxFasce do AppRiepPres.Residuo[xx]:=0;
  for xx:=1 to MaxFasce do AppRiepPres.AnnoPrec[xx]:=0;
  for k:=0 to High(RiepPres) do
  begin
    if ((Caller = 'Cartolina') or (Caller = 'Scheda')) and (AnnoCorr400 = Anno400) and (MeseCorr400 = Mese400) then
    begin
      Trov:=False;
      for i:=0 to High(RiepPresCartellino) do
        if RiepPres[k].Causale = RiepPresCartellino[i].Causale then
        begin
          Trov:=True;
          //Riepilogo mensile ed annuale esistente
          GetRiepilogoPresenze('',EncodeDate(AnnoCorr400,MeseCorr400,1),AppRiepPres,i);
          Break;
        end;
      if not Trov then
        //Riepilogo annuale esistente
        GetRiepilogoPresenze(RiepPres[k].Causale,EncodeDate(AnnoCorr400,MeseCorr400,1),AppRiepPres,0);
    end
    else
      GetRiepilogoPresenze(RiepPres[k].Causale,EncodeDate(AnnoCorr400,MeseCorr400,1),AppRiepPres,-1);
  end;
  if ((Caller = 'Cartolina') or (Caller = 'Scheda')) and (AnnoCorr400 = Anno400) and (MeseCorr400 = Mese400) then
    for i:=0 to High(RiepPresCartellino) do
    begin
      Trov:=IndiceRiepPres(RiepPresCartellino[i].Causale) >= 0;
      if not Trov then
      begin
        AddRiepPres;
        (*SetLength(RiepPres,Length(RiepPres) + 1);
        k:=High(RiepPres);
        RiepPres[k].Causale:='';
        RiepPres[k].CompensabileMese:=0;
        RiepPres[k].CompensabileMeseEff:=0;
        RiepPres[k].CompensabileAnno:=0;
        RiepPres[k].CompensabileAnnoEff:=0;
        RiepPres[k].RecuperoAnno:=0;
        RiepPres[k].RecuperoMese:=0;
        for xx:=1 to MaxFasce do RiepPres[k].Liquidabile[xx]:=0;
        for xx:=1 to MaxFasce do RiepPres[k].Liquidato[xx]:=0;
        for xx:=1 to MaxFasce do RiepPres[k].LiquidatoMese[xx]:=0;
        for xx:=1 to MaxFasce do RiepPres[k].OreRese[xx]:=0;
        for xx:=1 to MaxFasce do RiepPres[k].OreReseMese[xx]:=0;
        for xx:=1 to MaxFasce do RiepPres[k].OreBOMese[xx]:=0;
        for xx:=1 to MaxFasce do RiepPres[k].Residuo[xx]:=0;
        for xx:=1 to MaxFasce do RiepPres[k].AnnoPrec[xx]:=0;
        *)
        //Riepilogo mensile esistente
        GetRiepilogoPresenze('',EncodeDate(AnnoCorr400,MeseCorr400,1),AppRiepPres,i);
      end;
    end;
  //Lettura dgli eventuali limiti mensili
  for i:=0 to High(RiepPres) do
  begin
    RiepPres[i].LimiteMensile:=-1;
    if selT820.SearchRecord('ANNO;MESE;CAUSALE',VarArrayOf([AnnoCorr400,MeseCorr400,RiepPres[i].Causale]),[srFromBeginning]) then
      RiepPres[i].LimiteMensile:=R180OreMinutiExt(selT820.FieldByName('ORE').AsString);
  end;
  selT073.Filtered:=False;
  AbbattimentoAssenzeCumuloS;
end;

function TR450DtM1.AddRiepPres:Integer;
var k,xx:Integer;
begin
  SetLength(RiepPres,Length(RiepPres) + 1);
  k:=High(RiepPres);
  RiepPres[k].Causale:='';
  RiepPres[k].CompensabileMese:=0;
  RiepPres[k].CompensabileMeseEff:=0;
  RiepPres[k].CompensabileAnno:=0;
  RiepPres[k].CompensabileAnnoEff:=0;
  RiepPres[k].RecuperoAnno:=0;
  RiepPres[k].RecuperoMese:=0;
  for xx:=1 to MaxFasce do RiepPres[k].Liquidabile[xx]:=0;
  for xx:=1 to MaxFasce do RiepPres[k].Liquidato[xx]:=0;
  for xx:=1 to MaxFasce do RiepPres[k].LiquidatoMese[xx]:=0;
  for xx:=1 to MaxFasce do RiepPres[k].OreRese[xx]:=0;
  for xx:=1 to MaxFasce do RiepPres[k].OreReseMese[xx]:=0;
  for xx:=1 to MaxFasce do RiepPres[k].Abbattimento[xx]:=0;
  for xx:=1 to MaxFasce do RiepPres[k].OreBOMese[xx]:=0;
  for xx:=1 to MaxFasce do RiepPres[k].Residuo[xx]:=0;
  for xx:=1 to MaxFasce do RiepPres[k].AnnoPrec[xx]:=0;
  Result:=k;
end;

procedure TR450DtM1.GetRiepilogoPresenze(Causale:String; Data:TDateTime; App:TRiepPres; PresCart:Integer);
{Gestisce i conteggi in 3 modalità diverse:
 - Automatica: i conteggi vengono eseguiti leggendo esclusivamente dalle tabelle registrate:
              conteggi fino al mese precedente e conteggi per stampe o scheda riepilogativa in lettura
 - Scheda riepilogativa modificata: i riepiloghi presenze della scheda corrente vengono salvati in
              RiepPresCartellino, che viene aggiornato con le modifiche manuali (ancora non registrate)
              relativamente alle Ore Rese, Liquidato e Compensabile.
              RiepPresCartellino è caricata sulla scheda riepilogativa.
 - Stampa cartellino: legge le Ore Rese dell'ultimo mese dalla struttura RiepPresCartellino;
              il resto è letto dalle tabelle.
              RiepPreCartellino è caricato sulla stampa del cartellino.
 !ConteggiMese considera PresCart se caller = 'Cartolina' o 'Scheda'.
}
var A,M,G:Word;
    DCorr:TDateTime;
    CompMese,i,k,LimiteMensile,OreReseMese,Resto:Integer;
    DatiScheda:Boolean;
begin
  DatiScheda:=False;
  if PresCart >= 0 then
    if Causale = '' then
    begin
      Causale:=RiepPresCartellino[PresCart].Causale;
      for i:=1 to MaxFasce do
        App.OreRese[i]:=RiepPresCartellino[PresCart].OreRese[i];
      if Caller = 'Scheda' then
      begin
        DatiScheda:=True;
        for i:=1 to MaxFasce do
          App.Liquidato[i]:=RiepPresCartellino[PresCart].Liquidato[i];
        App.CompensabileMese:=RiepPresCartellino[PresCart].Compensabile;
      end;
    end
    else
      for i:=1 to MaxFasce do
        App.OreRese[i]:=0;
  //Filtro sulla causale specificata
  DecodeDate(Data,A,M,G);
  with selT073 do
  begin
    Filtered:=False;
    Filter:='CAUSALE = ''' + Causale + '''';
    Filtered:=True;
  end;
  with selT074 do
  begin
    Filtered:=False;
    Filter:='CAUSALE = ''' + Causale + '''';
    Filtered:=True;
  end;
  //Ricerca causale specificata in RiepPres
  k:=-1;
  for i:=0 to High(RiepPres) do
    if (RiepPres[i].Causale = Causale) or (RiepPres[i].Causale = '') then
    begin
      k:=i;
      Break;
    end;
  if RiepPres[k].Causale = '' then
    RiepPres[k].Causale:=Causale;
  DCorr:=EncodeDate(A,M,1);
  //Lettura compensabile nel mese
  if (Causale <> App.Causale) and (not DatiScheda) then
  begin
    if selT073.SearchRecord('DATA',DCorr,[srFromBeginning]) then
      App.CompensabileMese:=selT073.FieldByName('COMPENSABILE').AsInteger;
    i:=0;
    if selT074.SearchRecord('DATA',DCorr,[srFromBeginning]) then
      repeat
        inc(i);
        if PresCart < 0 then
          App.OreRese[i]:=selT074.FieldByName('OrePresenza').AsInteger;
        App.Liquidato[i]:=selT074.FieldByName('Liquidato').AsInteger;
      until not selT074.SearchRecord('DATA',DCorr,[]);
  end;
  CompMese:=App.CompensabileMese;
  RiepPres[k].CompensabileMese:=CompMese;
  RiepPres[k].CompensabileMeseEff:=CompMese;
  //Lettura dell'eventuale limite mensile
  RiepPres[k].LimiteMensile:=-1;
  if selT820.SearchRecord('ANNO;MESE;CAUSALE',VarArrayOf([AnnoCorr400,MeseCorr400,RiepPres[k].Causale]),[srFromBeginning]) then
    RiepPres[k].LimiteMensile:=R180OreMinutiExt(selT820.FieldByName('ORE').AsString);
  LimiteMensile:=RiepPres[k].LimiteMensile;
  for i:=MaxFasce downto 1 do
  begin
    if LimiteMensile >= 0 then
    begin
      Resto:=Min(LimiteMensile,App.OreRese[i]);
      dec(LimiteMensile,Resto);
      OreReseMese:=Resto;
    end
    else
      OreReseMese:=App.OreRese[i];
    //Alberto 23/02/2006: sostituito App.OreRese[i] con OreReseMese
    //inc(RiepPres[k].OreRese[i],App.OreRese[i]);
    //inc(RiepPres[k].Liquidabile[i],App.OreRese[i]);
    //inc(RiepPres[k].Residuo[i],App.OreRese[i] - App.Liquidato[i]);
    inc(RiepPres[k].OreRese[i],OreReseMese);
    inc(RiepPres[k].Liquidabile[i],OreReseMese);
    inc(RiepPres[k].Residuo[i],OreReseMese - App.Liquidato[i]);
    inc(RiepPres[k].Liquidato[i],App.Liquidato[i]);
    RiepPres[k].OreReseMese[i]:=App.OreRese[i];
    RiepPres[k].OreBOMese[i]:=RiepPres[k].OreReseMese[i];
    RiepPres[k].LiquidatoMese[i]:=App.Liquidato[i];
    (*if RiepPres[k].Residuo[i] >= 0 then
      if CompMese < RiepPres[k].Residuo[i] then
      begin
        dec(RiepPres[k].Residuo[i],CompMese);
        dec(RiepPres[k].Liquidabile[i],CompMese);
        CompMese:=0;
      end
      else
      begin
        dec(CompMese,RiepPres[k].Residuo[i]);
        dec(RiepPres[k].Liquidabile[i],RiepPres[k].Residuo[i]);
        RiepPres[k].Residuo[i]:=0;
      end;*)
  end;
  AbbattiRiepPres(k,CompMese);
  dec(RiepPres[k].CompensabileMeseEff,CompMese);
  inc(RiepPres[k].CompensabileAnno,RiepPres[k].CompensabileMese);
  inc(RiepPres[k].CompensabileAnnoEff,RiepPres[k].CompensabileMeseEff);
end;

procedure TR450DtM1.AbbattiRiepPres(k:Integer; var Abbatti:Integer);
var i,h:Integer;
begin
  if Abbatti > 0 then
  begin
    for i:=1 to MaxFasce do
    begin
      h:=Max(0,Min(Abbatti,RiepPres[k].Residuo[i] - RiepPres[k].Liquidabile[i] + RiepPres[k].Liquidato[i]));
      dec(Abbatti,h);
      dec(RiepPres[k].Residuo[i],h);
    end;
  end;
  if Abbatti > 0 then
  begin
    for i:=1 to MaxFasce do
    begin
      h:=Max(0,Min(Abbatti,RiepPres[k].Residuo[i]));
      dec(Abbatti,h);
      dec(RiepPres[k].Residuo[i],h);
      dec(RiepPres[k].Liquidabile[i],h);
    end;
  end;
end;

procedure TR450DtM1.AbbattiRiepPresMensile(k:Integer; var Abbatti:Integer);
var i,h:Integer;
begin
  if Abbatti > 0 then
  begin
    for i:=1 to MaxFasce do
    begin
      h:=Min(Abbatti,RiepPres[k].Residuo[i] - RiepPres[k].Liquidabile[i] + RiepPres[k].Liquidato[i]);
      h:=Max(0,Min(h,RiepPres[k].OreReseMese[i]));
      dec(Abbatti,h);
      dec(RiepPres[k].Residuo[i],h);
    end;
  end;
  if Abbatti > 0 then
  begin
    for i:=1 to MaxFasce do
    begin
      h:=Min(Abbatti,RiepPres[k].Residuo[i]);
      h:=Max(0,Min(h,RiepPres[k].OreReseMese[i]));
      dec(Abbatti,h);
      dec(RiepPres[k].Residuo[i],h);
      dec(RiepPres[k].Liquidabile[i],h);
    end;
  end;
end;

procedure TR450DtM1.AbbattiRiepPresBO(k:Integer; var Abbatti:Integer);
var i,h:Integer;
begin
  if Abbatti > 0 then
  begin
    for i:=1 to MaxFasce do
    begin
      h:=Max(0,Min(Abbatti,RiepPres[k].OreBOMese[i]));
      dec(Abbatti,h);
      dec(RiepPres[k].OreBOMese[i],h);
    end;
  end;
end;

function TR450DtM1.GetAssenzeCumuloS(Causale:String; Data:TDateTime):Boolean;
begin
  with selT040 do
  begin
    if (not Active) or (GetVariable('PROGRESSIVO') <> Progress400) or
       (GetVariable('DAL') <> EncodeDate(AnnoCorr400,1,1)) then
    begin
      SetVariable('PROGRESSIVO',Progress400);
      SetVariable('DAL',EncodeDate(AnnoCorr400,1,1));
      SetVariable('AL',EncodeDate(AnnoCorr400,12,31));
      Close;
      Open;
    end;
  end;
  Result:=selT040.SearchRecord('CAUSALE;DATA',VarArrayOf([Causale,Data]),[srFromBeginning]);
end;

procedure TR450DtM1.AbbattimentoAssenzeCumuloS;
(*In fase di creazione di R450 si deve eseguire uno script Oracle che restituisca le causali di
  assenza che fruiscono da causali di presenza, in modo da avere una tabella Assenza/Presenza.
  In questo modo si leggono le causali di assenza solo se il riepilogo presenze del dipendente
  prevede una di queste causali di presenza, altrimenti non viene eseguito nulla.
  Nel caso invece si debbano leggere le causali di assenza, la procedura ConteggiRiepiloghiPresenza
  verifica se in selT040 esiste per il MeseCorr400 qualche causale di assenza da conteggiare.
  In quel caso si deve richiamare GetQuantitaAssenza per il mese per ogni assenza, facendo attenzione che
  si può avere la stessa causale di assenza per più causali di presenza.
  In questo caso l'ordine di abbattimento è alfabetico.*)
var Giustif:TGiustificativo;
    i,j,k,h,Res:Integer;
    UM,Caus:String;
    Quantita,OreRese:Real;
    lstAssenzeMese:TStringList;
  function GetRiepAssenze(S:String):Integer;
  var xx:Integer;
  begin
    Result:=-1;
    for xx:=0 to High(RiepAssenzeCumuloS) do
      if RiepAssenzeCumuloS[xx].Codice = S then
      begin
        Result:=xx;
        Break;
      end;
  end;
  procedure AbbattiResiduo(var RP:TRiepPres; N:Integer);
  var h,xx:Integer;
  begin
    for xx:=1 to NFasceMese do
    begin
      if N = 0 then Break;
      h:=Min(N,RP.Residuo[xx]);
      dec(RP.Residuo[xx],h);
      RP.Liquidabile[xx]:=Max(0,RP.Liquidabile[xx] - h);
      dec(N,h);
    end;
  end;
begin
  //Verifica se i riepiloghi presenza sono soggetti ad abbattimenti da parte di causali di assenza con TipoCumulo = S
  //lstPresenzeCumuloS contiene l'elenco delle causali di presenza specificate sui parametri
  //delle causali di assenza nel caso di Tipo Cumulo = S
  lstAssenzeMese:=TStringList.Create;
  for i:=0 to High(RiepPres) do
  begin
    RiepPres[i].RecuperoMese:=0;
    //Per ogni causale di presenza si verifica se può essere abbattuta da causali di assenza (lstPresenzeCumuloS)
    //Alberto 07/06/2006: ciclo su tutte le causali, prima si considerava solo la prima dell'elenco
    for j:=0 to lstPresenzeCumuloS.Count - 1 do
      if lstPresenzeCumuloS[j] = RiepPres[i].Causale then
      //if lstPresenzeCumuloS.IndexOf(RiepPres[i].Causale) > 0 then
      begin
        Caus:=lstAssenzeCumuloS[j];
        //Caus:=lstAssenzeCumuloS[lstPresenzeCumuloS.IndexOf(RiepPres[i].Causale)];
        if lstAssenzeMese.IndexOf(Caus) = -1 then
        begin
          lstAssenzeMese.Add(Caus);
          //Se l'assenza è ancora da calcolare, si verifica che nel mese il dip. ne abbia fruito
          if GetAssenzeCumuloS(Caus,EncodeDate(AnnoCorr400,MeseCorr400,1)) then
          begin
            //Se ci sono fruizioni fino al mese da conteggiare, si richiamano i conteggi dell'assenza e si riepilogano in RiepAssenzeCumuloS
            if R600DtM = nil then
            begin
              if (Self.Owner <> nil) and not(Self.Owner is TOracleDataSet) then
                R600DtM:=TR600DtM1.Create(Self.Owner)
              else
                R600DtM:=TR600DtM1.Create(SessioneOracleR450);
            end;
            Giustif.Causale:=Caus;
            Giustif.Modo:='I';
            R600DtM.GetQuantitaAssenze(Progress400,EncodeDate(AnnoCorr400,MeseCorr400,1),EncodeDate(AnnoCorr400,MeseCorr400,R180GiorniMese(EncodeDate(AnnoCorr400,MeseCorr400,1))),0,Giustif,UM,Quantita,OreRese);
            k:=GetRiepAssenze(Caus);
            if k = -1 then
            begin
              k:=High(RiepAssenzeCumuloS) + 1;
              SetLength(RiepAssenzeCumuloS,k + 1);
              RiepAssenzeCumuloS[k].Codice:=Caus;
              RiepAssenzeCumuloS[k].Ore:=0;
            end;
            //Causale che non aumenta le ore
            if R180CarattereDef(R600DtM.Q265.FieldByName('INFLUCONT').AsString,1,'A') in ['B','D'] then
            begin
              if UM = 'O' then
                inc(RiepAssenzeCumuloS[k].Ore,Trunc(Quantita))
              else if R600DtM.ValenzaGiornaliera > 0 then
                inc(RiepAssenzeCumuloS[k].Ore,Trunc(Quantita/R600DtM.ValenzaGiornaliera));
            end
            else
              //Causale che aumenta le ore
              inc(RiepAssenzeCumuloS[k].Ore,Trunc(OreRese));
          end;
        end;
      end;
  end;
  lstAssenzeMese.Free;
  //Gestione delle assenze riepilogate
  for i:=0 to High(RiepAssenzeCumuloS) do
    if RiepAssenzeCumuloS[i].Ore > 0 then
    begin
      for j:=0 to lstAssenzeCumuloS.Count - 1 do
        if lstAssenzeCumuloS[j] = RiepAssenzeCumuloS[i].Codice then
        begin
          k:=IndiceRiepPres(lstPresenzeCumuloS[j]);
          if k >= 0 then
          begin
            //Lettura del residuo disponibile ed abbattimento
            Res:=0;
            for h:=1 to MaxFasce do inc(Res,RiepPres[k].Residuo[h]);
            h:=Max(0,Min(Res,RiepAssenzeCumuloS[i].Ore));
            inc(RiepPres[k].RecuperoAnno,h);
            inc(RiepPres[k].RecuperoMese,h);
            dec(RiepAssenzeCumuloS[i].Ore,h);
            //AbbattiResiduo(RiepPres[k],h);
            AbbattiRiepPres(k,h);
          end;
        end;
    end;
  //Abbattimento delle ore non disponibili nei residui: i residui vanno in negativo
  //L'abbattimento viene fatto sulla prima fascia della prima causale di presenza associata
  //all'assenza considerata
  //if (AnnoCorr400 = Anno400) and (MeseCorr400 = Mese400) then
  //Alberto 16/05/2008: (AOSTA) remmato il controllo precedente in modo che possa andare in negativo su tutti i mesi, anche quelli intermedi
  begin
    for i:=0 to High(RiepAssenzeCumuloS) do
      if RiepAssenzeCumuloS[i].Ore > 0 then
      begin
        for j:=0 to lstAssenzeCumuloS.Count - 1 do
        if lstAssenzeCumuloS[j] = RiepAssenzeCumuloS[i].Codice then
        begin
          k:=IndiceRiepPres(lstPresenzeCumuloS[j]);
          if k >= 0 then
          begin
            inc(RiepPres[k].RecuperoAnno,RiepAssenzeCumuloS[i].Ore);
            inc(RiepPres[k].RecuperoMese,RiepAssenzeCumuloS[i].Ore);
            dec(RiepPres[k].Residuo[1],RiepAssenzeCumuloS[i].Ore);
            RiepAssenzeCumuloS[i].Ore:=0;
          end;
        end;
      end;
  end;
end;

function TR450DtM1.IndiceRiepPres(Causale:String):Integer;
{Restituisce l'indice a RiepPres relativo alla causale specificata}
var i:Integer;
begin
  Result:= -1;
  for i:=0 to High(RiepPres) do
    if RiepPres[i].Causale = Causale then
    begin
      Result:=i;
      Break;
    end;
end;

function TR450DtM1.IndiceRiepPresSM(iRM:Integer; Causale:String):Integer;
{Restituisce l'indice a RiepilogoMese[iRM].RiepPres relativo alla causale specificata}
var i:Integer;
begin
  Result:= -1;
  if iRM > High(RiepilogoMese) then
    exit;
  for i:=0 to High(RiepilogoMese[iRM].RiepPres) do
    if RiepilogoMese[iRM].RiepPres[i].Causale = Causale then
    begin
      Result:=i;
      Break;
    end;
end;

(*procedure TR450DtM1.EliminaRiepPres(Causale:String);
var k,xx,i:Integer;
begin
  k:=IndiceRiepPres(Causale);
  if k = -1 then
    exit;
  for i:=k to High(RiepPres) - 1 do
  begin
    RiepPres[i].Causale:=RiepPres[i + 1].Causale;
    RiepPres[i].CompensabileMese:=RiepPres[i + 1].CompensabileMese;
    RiepPres[i].CompensabileMeseEff:=RiepPres[i + 1].CompensabileMeseEff;
    RiepPres[i].CompensabileAnno:=RiepPres[i + 1].CompensabileAnno;
    RiepPres[i].CompensabileAnnoEff:=RiepPres[i + 1].CompensabileAnnoEff;
    RiepPres[i].RecuperoAnno:=RiepPres[i + 1].RecuperoAnno;
    RiepPres[i].RecuperoMese:=RiepPres[i + 1].RecuperoMese;
    for xx:=1 to MaxFasce do
    begin
      RiepPres[i].Liquidabile[xx]:=RiepPres[i + 1].Liquidabile[xx];
      RiepPres[i].Liquidato[xx]:=RiepPres[i + 1].Liquidato[xx];
      RiepPres[i].LiquidatoMese[xx]:=RiepPres[i + 1].LiquidatoMese[xx];
      RiepPres[i].OreRese[xx]:=RiepPres[i + 1].OreRese[xx];
      RiepPres[i].OreReseMese[xx]:=RiepPres[i + 1].OreReseMese[xx];
      RiepPres[i].Residuo[xx]:=RiepPres[i + 1].Residuo[xx];
      RiepPres[i].AnnoPrec[xx]:=RiepPres[i + 1].AnnoPrec[xx];
    end;
  end;
  SetLength(RiepPres,Length(RiepPres) - 1);
end;*)

function TR450DtM1.EsistePresenzaLiquidataSuccessiva(Causale:String):Boolean;
{TRUE se esiste una liquidazione superiore alla data specificata}
begin
  Result:=False;
  with selT074liq do
    if SearchRecord('CAUSALE',Causale,[srFromBeginning]) then
      if FieldByName('LIQUIDATO').AsInteger > 0 then
        Result:=True;
end;

function TR450DtM1.EsisteLiquidazioneSuccessiva(Progressivo:Integer; Data:TDateTime):Boolean;
{Straordinario liquidato in mesi successivi al corrente}
var A,M,G:Word;
begin
  DecodeDate(Data,A,M,G);
  with sum071 do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA1',Data + 1);
    SetVariable('DATA2',EncodeDate(A,12,31));
    Execute;
    Result:=FieldAsInteger(0) > 0;
  end;
end;

function TR450DtM1.EsisteCompLiquidatoSuccessivo(Progressivo:Integer; Data:TDateTime):Boolean;
{Ore compensabili liquidate in mesi successivi al corrente}
var A,M,G:Word;
begin
  DecodeDate(Data,A,M,G);
  with sum070 do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA1',Data + 1);
    SetVariable('DATA2',EncodeDate(A,12,31));
    Execute;
    Result:=FieldAsInteger(0) > 0;
  end;
end;

function TR450DtM1.GetRipComLiqMes:Integer;
var i,j:Integer;
begin
  Result:=0;
  for i:=0 to High(RiepPres) do
  begin
    if CausRipComFasce = RiepPres[i].Causale then
    begin
      for j:=1 to NFasceMese do
        inc(Result,RiepPres[i].LiquidatoMese[j]);
      inc(Result,RiepPres[i].CompensabileMeseEff);
      Break;
    end;
  end;
end;

function TR450DtM1.GetBOInclusaSaldi(V:Integer):Integer;
{Restituisce 0 se Banca Ore esclusa dai saldi}
begin
  Result:=IfThen(BancaOreEsclusaSaldi = 'S',0,V);
end;

function TR450DtM1.GetResidCompNegativo:Boolean;
begin
  Result:=(SaldoNegativoMinimoTipo = '1') and (SaldoNegativoMinimo < 0);
end;

procedure TR450DtM1.x401_leggiresid(LeggiTabella:Boolean);
{Lettura residui anno precedente:
 La prima volta sempre da Tabella, le eventuali volte successive(conteggi mobili)
 si riportano i dati calcolati}
begin
  //Inizializzazioni
  l13_sallav_min:=0;
  l13_respo_min:=0;
  l13_rescnl_min:=0;
  l13_rescnl_min_orig:=0;
  l13_resrco_min:=0;
  l13_banca_ore:=0;
  l13_banca_ore_recuperata:=0;
  FOrePersePeriodiche:=0;
  if LeggiTabella then
  begin
    with selT130 do
      //Se periodi di servizio separati e la data di assunzione è nell'anno corrente, non considero il residuo
      if (RecordCount > 0) and (selT430.FieldByName('Inizio').AsDateTime <= EncodeDate(FieldByName('ANNO').AsInteger - 1,12,31)) then
      begin
        s_trovato:='si';
        l13_sallav_min:=R180OreMinutiExt(FieldByname('SaldoOreLav').AsString);
        l13_respo_min:=R180OreMinutiExt(FieldByname('SaldoOrePo').AsString);
        l13_rescnl_min:=R180OreMinutiExt(FieldByname('OreCompensabili').AsString);
        l13_resrco_min:=R180OreMinutiExt(FieldByname('RiposiComp').AsString);
        l13_banca_ore:=R180OreMinutiExt(FieldByname('Banca_Ore').AsString);
        //Il compensabile non può superare il saldo anno prec.
        l13_rescnl_min_orig:=l13_rescnl_min;
        if l13_rescnl_min > l13_sallav_min then
          l13_rescnl_min:=l13_sallav_min;
      end
      else
        s_trovato:='no';
  end
  //Se periodi di servizio separati e la data di assunzione è nell'anno corrente, non considero il residuo
  else if selT430.FieldByName('Inizio').AsDateTime <= EncodeDate(AnnoCorr400 - 1,12,31) then
  begin
    s_trovato:='si';
    l13_sallav_min:=salannoatt_prec;
    l13_respo_min:=salpoanno_prec;
    l13_rescnl_min:=salcompannoprec_prec + salcompannoatt_prec;
    l13_resrco_min:=salripcom_prec;
    l13_banca_ore:=BancaOreResidua_prec + BancaOreResiduaPrec_prec;
    l13_rescnl_min_orig:=l13_rescnl_min;
  end;
  if (BancaOre = 'N') or (BancaOreResiduabile = 'N') then
    l13_banca_ore:=0;
  l13_banca_ore_recuperata:=l13_banca_ore;
end;

procedure TR450DtM1.x402_salvresid;
{Salvataggio residui come dati mese precedente}
var i,xx,m400:Integer;
begin
  salannoatt_prec:=l13_sallav_min;
  salannonetto_prec:=l13_sallav_min;
  salpoanno_prec:=l13_respo_min;
  salmese_prec:=0;
  liquidabmese_prec:=0;
  (*Alberto 14/04/1999*)
  eccsolocompanno_prec:=l13_rescnl_min;//l13_sallav_min;//
  salcompannoprec_prec:=l13_rescnl_min;//l13_sallav_min;//
  salripcom_prec:=l13_resrco_min;
  for xx:=Low(tstranno_prec) to High(tstranno_prec) do tstranno_prec[xx]:=0;
  for xx:=Low(tsupann_prec) to High(tsupann_prec) do tsupann_prec[xx]:=0;
  for xx:=Low(tstrannom_prec) to High(tstrannom_prec) do tstrannom_prec[xx]:=0;
  for xx:=Low(tstrliq_prec) to High(tstrliq_prec) do tstrliq_prec[xx]:=0;
  eccsolocompres_prec:=0;
  abbannoprecanno_prec:=0;
  salcompannoatt_prec:=0;
  salliqannoatt_prec:=0;
  BancaOreResidua_prec:=0;
  BancaOreResiduaPrec_prec:=l13_banca_ore;
  debpoanno_prec:=0;
  poresoanno_prec:=0;
  vareccliqanno_prec:=0;
  totasscompanno_prec:=0;
  //Lettura eccedenza residua autorizzata di Dicembre dell'anno precedente
  dec(AnnoCorr400);
  m400:=MeseCorr400;
  MeseCorr400:=12;
  inc(AnnoCorr400);
  MeseCorr400:=m400;
  if (l13_sallav_min - l13_respo_min) > max(0,l13_rescnl_min) then
    stranno_prec:=l13_sallav_min - l13_respo_min - max(0,l13_rescnl_min)
  else
    stranno_prec:=0;
  salliqannoprec_prec:=stranno_prec;
  //--Inizio--Gestione delle ore compensabili negative --//
  if (l13_rescnl_min_orig < 0) and ResidCompNegativo then
  begin
    if l13_sallav_min < 0 then
      salliqannoprec_prec:=l13_sallav_min - l13_rescnl_min_orig
    else
      dec(salliqannoprec_prec,l13_rescnl_min_orig);
    dec(salcompannoprec_prec,l13_rescnl_min_orig);
    salcompannoatt_prec:=l13_rescnl_min_orig;
  end;
  //--Fine--//
  //Impostazione fasce per liquidazione anno precedente
  fascomodo:=stranno_prec;
  (*MaxFasce-->NFasceMese*)
  for i:=NFasceMese + 1 downto 1 do
    begin
    if fascomodo = 0 then Break;
    tstranno_prec[i]:=fascomodo;
    tstrannom_prec[i]:=fascomodo;
    fascomodo:=0;
    end;
  inc(tstranno_prec[1],fascomodo);
  inc(tstrannom_prec[1],fascomodo);
  //Salvataggio straordinario liquidabile anno precedente
  for i:=1 to NFasceMese + 1 do
    tstrannoprecm[i]:=tstrannom_prec[i];
  //Impostazione fasce liquidate anno precedente
  fascomodo:=0; //l13_liqann_min;
end;

procedure TR450DtM1.x404_impcontmese;
{Impostazione e conteggio dati di un mese}
var i2,xx:Integer;
begin
  //Lettura dati del mese NON in elaborazione
  //Leggo TUTTI i dati registrati
  if (AnnoCorr400 <> Anno400) or (MeseCorr400 <> mese400) or (caller = 'Generico') then
    with selT070 do
    begin
      //Lettura scheda riepilogativa di un mese
      if not SearchRecord('DATA',EncodeDate(AnnoCorr400,MeseCorr400,1),[srFromBeginning]) then
      begin
        ttrovscheda[MeseCorr400]:=0;
        exit;
      end
      else
        //Lettura dati in fasce
      begin
        ttrovscheda[MeseCorr400]:=1;
        L07.debormes:=R180OreMinutiExt(FieldByName('DebitoOrario').AsString);
        L07.debggtot:=0;//R180OreMinutiExt(FieldByName('DebitoGG_Tot').AsString);
        L07.debpomes:=R180OreMinutiExt(FieldByName('DebitoPo').AsString);
        L07.poflag:=R180CarattereDef(FieldByName('TipoPo').AsString,1,#0);
        L07.tdatiassestamento[1].tcauassest:=FieldByName('Causale1MinAss').AsString;
        L07.tdatiassestamento[2].tcauassest:=FieldByName('Causale2MinAss').AsString;
        L07.fesintmesVar:=FieldByName('FESTIVINTERA_VAR').AsFloat;
        L07.fesridmesVar:=FieldByName('FESTIVRIDOTTA_VAR').AsFloat;
        L07.notggmesVar:=FieldByName('INDTURNONUM_VAR').AsInteger;
        L07.notminmesVar:=FieldByName('INDTURNOORE_VAR').AsString;
        L07.eccsolocompmes:=R180OreMinutiExt(FieldByName('OreEccedComp').AsString);
        L07.EccSoloCompMesOltreSoglia:=R180OreMinutiExt(FieldByName('OreEccedCompOltreSoglia').AsString);
        L07.vareccliqmes:=R180OreMinutiExt(FieldByName('OreVariazEcc').AsString);
        L07.scostnegmes:=R180OreMinutiExt(FieldByName('ScostNeg').AsString);
        L07.ripcommes:=R180OreMinutiExt(FieldByName('RipCom').AsString);
        L07.abbripcommes:=R180OreMinutiExt(FieldByName('AbbRipCom').AsString);
        L07.NFasce:=0;
        L07.AddebitoPaghe:=R180OreMinutiExt(FieldByName('AddebitoPaghe').AsString);
        (*RecAnnoCorr*)L07.abbannoattmes:=R180OreMinutiExt(FieldByName('RecAnnoCorr').AsString);
        (*RecAnnoPrec*)L07.abbannoprecmes:=R180OreMinutiExt(FieldByName('RecAnnoPrec').AsString);
        L07.abbliqannoattmes:=R180OreMinutiExt(FieldByName('RecLiqCorr').AsString);
        L07.abbliqannoprecmes:=R180OreMinutiExt(FieldByName('RecLiqPrec').AsString);
        L07.OreCompLiquidate:=R180OreMinutiExt(FieldByName('OreComp_Liquidate').AsString) + R180OreMinutiExt(FieldByName('BancaOre_Liq_Var').AsString);
        L07.BancaOreLiqVar:=R180OreMinutiExt(FieldByName('BancaOre_Liq_Var').AsString);
        L07.OreCompRecuperate:=R180OreMinutiExt(FieldByName('OreComp_Recuperate').AsString);
        L07.CarenzaObbligatoria:=R180OreMinutiExt(FieldByName('Carenza_Obbligatoria').AsString);
        (*RIETI*)L07.RiposiNonFruitiOre:=FieldByName('RiposiNonFruitiOre').AsString;
        //Lettura dati in fasce
        with selT071 do
        begin
          i2:=1;
          NFasceMese:=0;
          if SearchRecord('DATA',EncodeDate(AnnoCorr400,MeseCorr400,1),[srFromBeginning]) then
          repeat
            L07.tfasce[i2]:=FieldByName('CodFascia').AsString;
            L07.tmaggioraz[i2]:=FieldByName('Maggiorazione').AsInteger;
            L07.tminlavmese[i2]:=R180OreMinutiExt(FieldByName('OreLavorate').AsString);
            L07.tmininturno[i2]:=R180OreMinutiExt(FieldByName('OreIndTurno').AsString);
            L07.tdatiassestamento[1].tminassest[i2]:=R180OreMinutiExt(FieldByName('Ore1Assest').AsString);
            L07.tdatiassestamento[2].tminassest[i2]:=R180OreMinutiExt(FieldByName('Ore2Assest').AsString);
            L07.tminstrmens[i2]:=R180OreMinutiExt(FieldByName('OreEccedGiorn').AsString);
            L07.tstrliquidatomm[i2]:=R180OreMinutiExt(FieldByName('OreStraordLiq').AsString);
            L07.tLiqNelMese[i2]:=R180OreMinutiExt(FieldByName('LiquidNelMese').AsString);
            inc(i2);
          until not SearchRecord('DATA',EncodeDate(AnnoCorr400,MeseCorr400,1),[]);
          L07.NFasce:=i2 - 1;
          NFasceMese:=L07.NFasce;
        end;
      end;
    end
  //Lettura dati del mese in elaborazione
  else if caller = 'Scheda' then
  //Ripristino i dati registrati in memoria
  begin
    L07:=L07SV;
    ttrovscheda[MeseCorr400]:=1;
  end
  else if caller = 'Cartolina' then
  begin
    //Ripristino i dati registrati in memoria
    L07:=L07SV;
    with selT070 do
    //Leggo solo i dati relativi all' ASSESTAMENTO e alle ORE LIQUIDATE
    begin
      if not SearchRecord('DATA',EncodeDate(AnnoCorr400,MeseCorr400,1),[srFromBeginning]) then
      begin
        ttrovscheda[MeseCorr400]:=0;
        for xx:=1 to MaxFasce do
        begin
          L07.tstrliquidatomm[xx]:=0;
          L07.tLiqNelMese[xx]:=0;
          L07.tdatiassestamento[1].tminassest[xx]:=0;
          L07.tdatiassestamento[2].tminassest[xx]:=0;
        end;
        L07.tdatiassestamento[1].tcauassest:='';
        L07.tdatiassestamento[2].tcauassest:='';
        L07.fesintmesVar:=0;
        L07.fesridmesVar:=0;
        L07.notggmesVar:=0;
        L07.notminmesVar:='';
      end
      else
      begin
        ttrovscheda[MeseCorr400]:=1;
        L07.tdatiassestamento[1].tcauassest:=FieldByName('Causale1MinAss').AsString;
        L07.tdatiassestamento[2].tcauassest:=FieldByName('Causale2MinAss').AsString;
        L07.OreCompLiquidate:=R180OreMinutiExt(FieldByName('OreComp_Liquidate').AsString) + R180OreMinutiExt(FieldByName('BancaOre_Liq_Var').AsString);
        L07.BancaOreLiqVar:=R180OreMinutiExt(FieldByName('BancaOre_Liq_Var').AsString);
        L07.fesintmesVar:=FieldByName('FESTIVINTERA_VAR').AsFloat;
        L07.fesridmesVar:=FieldByName('FESTIVRIDOTTA_VAR').AsFloat;
        L07.notggmesVar:=FieldByName('INDTURNONUM_VAR').AsInteger;
        L07.notminmesVar:=FieldByName('INDTURNOORE_VAR').AsString;
        with selT071 do
        begin
          i2:=1;
          if SearchRecord('DATA',EncodeDate(AnnoCorr400,MeseCorr400,1),[srFromBeginning]) then
          repeat
            L07.tfasce[i2]:=FieldByName('CodFascia').AsString;
            L07.tmaggioraz[i2]:=FieldByName('Maggiorazione').AsInteger;
            L07.tdatiassestamento[1].tminassest[i2]:=R180OreMinutiExt(FieldByName('Ore1Assest').AsString);
            L07.tdatiassestamento[2].tminassest[i2]:=R180OreMinutiExt(FieldByName('Ore2Assest').AsString);
            L07.tstrliquidatomm[i2]:=R180OreMinutiExt(FieldByName('OreStraordLiq').AsString);
            L07.tLiqNelMese[i2]:=R180OreMinutiExt(FieldByName('LiquidNelMese').AsString);
            inc(i2);
          until not SearchRecord('DATA',EncodeDate(AnnoCorr400,MeseCorr400,1),[]);
        end;
      end;
    end;
  end;
  //Impostazioni dati per conteggio
  x470_impdaticont;
  //Conteggio dati per mese attuale
  x450_contdati;
end;

procedure TR450DtM1.x450_contdati;
{Conteggio dati del mese}
var i:Integer;
begin
  //Salvo le causali di assestamento per ripristinarle a fine conteggi:
  //possono essere annullate nel caso che la causale di giustificazione
  //specifichi una data di inizio validità successiva ai conteggi correnti (PINEROLO_ASLTO3)
  for i:=1 to 2 do
    tdatiassestamen_app[i]:=tdatiassestamen[i];
  //Conteggi comuni a tutte le tipologie
  y010_contcomune;
  case R455_tipocon of
    1:y100_contdati1;
    2:y200_contdati2;
    3:y300_contdati3;
    4:y400_contdati4;
    5:y500_contdati5;
    6:y600_contdati6;
  end;
  for i:=1 to 2 do
    tdatiassestamen[i]:=tdatiassestamen_app[i];
end;

procedure TR450DtM1.x470_impdaticont;
{Impostazioni dati per conteggio}
var i:Integer;
begin
  //Lettura dati globali
  debormes:=L07.debormes;
  debggtot:=L07.debggtot;
  debpomes:=L07.debpomes;
  poflag:=L07.poflag;
  tdatiassestamen[1].tcauassest:=L07.tdatiassestamento[1].tcauassest;
  tdatiassestamen[2].tcauassest:=L07.tdatiassestamento[2].tcauassest;
  eccsolocompmes:=L07.eccsolocompmes;
  EccSoloCompMesOltreSoglia:=L07.EccSoloCompMesOltreSoglia;
  vareccliqmes:=L07.vareccliqmes;
  scostnegmes:=L07.scostnegmes;
  ripcommes:=L07.ripcommes;
  abbripcommes:=L07.abbripcommes;
  (*RecAnnoCorr*)abbannoattmes:=L07.abbannoattmes;
  (*RecAnnoPrec*)abbannoprecmes:=L07.abbannoprecmes;
  abbliqannoattmes:=L07.abbliqannoattmes;
  abbliqannoprecmes:=L07.abbliqannoprecmes;
  OreCompLiquidate:=L07.OreCompLiquidate;
  BancaOreLiqVar:=L07.BancaOreLiqVar;
  OreCompRecuperate:=L07.OreCompRecuperate;
  fesintmesVar:=L07.fesintmesVar;
  fesridmesVar:=L07.fesridmesVar;
  notggmesVar:=L07.notggmesVar;
  notminmesVar:=L07.notminmesVar;
  (*RIETI*)RiposiNonFruitiOre:=R180OreMinutiExt(L07.RiposiNonFruitiOre);
  //Lettura dati in fasce
  for i:=1 to L07.NFasce do
  begin
    tfasce[i]:=L07.tfasce[i];
    tmaggioraz[i]:=L07.tmaggioraz[i];
    tminlavmes[i]:=L07.tminlavmese[i];
    tmininturno[i]:=L07.tmininturno[i];
    tdatiassestamen[1].tminassest[i]:=L07.tdatiassestamento[1].tminassest[i];
    tdatiassestamen[2].tminassest[i]:=L07.tdatiassestamento[2].tminassest[i];
    tminstrmen[i]:=L07.tminstrmens[i];
    tminstrmen_ori[i]:=L07.tminstrmens[i];
    tstrliqmm[i]:=L07.tstrliquidatomm[i];
    tLiqNelMese[i]:=L07.tLiqNelMese[i];
  end;
  NFasceMese:=L07.NFasce;
end;

procedure TR450DtM1.x472_saldatiprec;
{Salvataggio dati attuali come dati mese precedente}
var i:Integer;
begin
  (*MaxFasce-->NFasceMese*)
  for i:=1 to NFasceMese + 1 do
    begin
    tsupann_prec[i]:=tsupann[i];
    tstranno_prec[i]:=tstranno[i];
    tstrliq_prec[i]:=tstrliq[i];
    tstrannom_prec[i]:=tstrannom[i];
    end;
  salannoatt_prec:=salannoatt - IfThen(SaldoNegativoMinimoTipo = '1',SaldoNegativoMinimoEcced,0);
  salannonetto_prec:=salannonetto;
  salmese_prec:=salmeseatt;
  if LiquidazioneDistribuita <> 'S' then
    dec(salmese_prec,totliqmm);
  liquidabmese_prec:=liquidabmese;
  salpoanno_prec:=salpoanno;
  debpoanno_prec:=debpoanno;
  poresoanno_prec:=poresoanno;
  eccsolocompanno_prec:=eccsolocompanno;
  eccsolocompres_prec:=eccsolocompres;
  vareccliqanno_prec:=vareccliqanno;
  totasscompanno_prec:=totasscompanno;
  stranno_prec:=stranno;
  abbannoprecanno_prec:=abbannoprecanno;
  salripcom_prec:=salripcom;
  salcompannoprec_prec:=salcompannoprec;
  salliqannoprec_prec:=salliqannoprec;
  salcompannoatt_prec:=salcompannoatt - IfThen(SaldoNegativoMinimoTipo = '1',SaldoNegativoMinimoEcced,0);
  salliqannoatt_prec:=salliqannoatt;
  BancaOreResidua_prec:=FBancaOreResidua;
  BancaOreResiduaPrec_prec:=FBancaOreResiduaPrec;
  //Sommo dati cumulativi da Gennaio
  inc(TotLiquidNelMese,GetLiqNelMese);
end;

procedure TR450DtM1.y010_contcomune;
{Conteggi comuni a tutte le tipologie}
var i,j,xx:Integer;
    v:Variant;
begin
  //Azzeramenti iniziali variabili di output
  for xx:=Low(tstrmese) to High(tstrmese) do tstrmese[xx]:=0;
  for xx:=Low(tstrannom) to High(tstrannom) do tstrannom[xx]:=0;
  for xx:=Low(tstrliq) to High(tstrliq) do tstrliq[xx]:=0;
  for xx:=Low(tbancaore) to High(tbancaore) do tbancaore[xx]:=0;
  LiquidabileMensileSenzaLimiti:=0;
  liquidabmese:=0;
  totoreres:=0;
  debtotmes:=0;
  debpoeff:=0;
  salmeseatt:=0;
  salfmprec:=0;
  salfmprecnetto:=0;
  salannoatt:=0;
  salannonetto:=0;
  debpoanno:=0;
  poreso:=0;
  poresoanno:=0;
  salpoanno:=0;
  eccsolocompanno:=0;
  eccsolocompres:=0;
  totoreresori:=0;
  salripcommes:=0;
  salripcom:=0;
  salripcomfmprec:=0;
  salcompannoprec:=0;
  salliqannoprec:=0;
  salcompannoatt:=0;
  salliqannoatt:=0;
  abbannopreceff:=0;
  abbannoatteff:=0;
  FAddebitoPaghe:=0;
  FOreTroncate:=0;
  FBancaOreMese:=0;
  FBancaOreResidua:=0;
  LiqOreAnniPrec:=0;
  VariazioneSaldo:=0;
  inc(CarenzaObbligatoria,L07.CarenzaObbligatoria);
  //Lavorato mensile originale
  for i:=1 to NFasceMese do
    inc(totoreresori,tminlavmes[i]);
  //Lavorato mensile effettivo
  totoreres:=totoreresori;
  for i:=1 to 2 do
  begin
    //if (UpperCase(Parametri.RagioneSociale) = 'AZIENDA SANITARIA LOCALE TO3') and (tdatiassestamen[i].tcauassest = 'HAP09') and (EncodeDate(Anno400,Mese400,1) < EncodeDate(2009,7,1)) then
    v:=selT305.Lookup('CODICE',tdatiassestamen[i].tcauassest,'DATA_MIN_ASSEST');
    if (v <> null) and (R180InizioMese(v) > EncodeDate(Anno400,Mese400,1)) then
    begin
      tdatiassestamen[i].tcauassest:='';
      for j:=1 to NFasceMese do
        tdatiassestamen[i].tminassest[j]:=0;
    end;
    if (tdatiassestamen[i].tcauassest <> '') and (Trim(VarToStr(selT305.Lookup('CODICE',tdatiassestamen[i].tcauassest,'ASSEST_ANNUO'))) = '') then
      for j:=1 to NFasceMese do
        inc(totoreres,tdatiassestamen[i].tminassest[j]);
  end;
  (*NUOVO*)if (SaldoNegativoMinimoTipo = '1') and (SaldoNegativoMinimo < 0) then
    inc(totoreres, - SaldoNegativoMinimo);
  //Debito totale del mese
  if DebAggRappAnno <> 'S' then
    debtotmes:=debormes + debpomes
  else
    debtotmes:=debormes;  //Alberto 28/02/2008: Collegno
  //Debito plus orario da inizio anno
  debpoanno:=debpoanno_prec + debpomes;
  inc(debpoannores,debpomes); //Alberto 28/02/2008: Collegno
  //Totale straordinario liquidato del mese e straordinario liquidato da inizio anno
  //Alberto 5/9/2000: considerazione del Liquidato Nel Mese
  totliqmm:=0;
  for i:=1 to NFasceMese do
    if (LiquidazioneDistribuita = 'S') or (R455_tipocon <> 4) then
    begin
      inc(totliqmm,tstrliqmm[i]);
      tstrliq[i]:=tstrliq_prec[i] + tstrliqmm[i];
    end
    else
    begin
      inc(totliqmm,tLiqNelMese[i]);
      tstrliq[i]:=tstrliq_prec[i] + tLiqNelMese[i];
    end;
  //Variazione alle eccedenze per liquidazione dell'anno
  vareccliqanno:=vareccliqanno_prec + vareccliqmes;
  //Riepilogo delle causali di presenza
  ConteggiRiepiloghiPresenza;
  totcausliqmm:=0;
  for i:=0 to High(RiepPres) do
    //Ore escluse dalle normali compensabili
    if VarToStr(selT275.Lookup('CODICE',RiepPres[i].Causale,'ORENORMALI')) = 'A' then
      inc(OreEsclComp,RiepPres[i].CompensabileMeseEff)
    //Ore incluse nelle normali liquidate dal riepilogo delle presenze
    else if (VarToStr(selT275.Lookup('CODICE',RiepPres[i].Causale,'ORENORMALI')) = 'B') or
            (VarToStr(selT275.Lookup('CODICE',RiepPres[i].Causale,'ORENORMALI')) = 'D') then
      for j:=1 to NFasceMese do
      begin
        tstrliq[j]:=tstrliq[j] + RiepPres[i].LiquidatoMese[j];
        inc(totcausliqmm,RiepPres[i].LiquidatoMese[j]);
      end;
end;

procedure TR450DtM1.y100_contdati1;
{Conteggio dati del mese tipo 'Standard'
 Es. SAVIGLIANO}
var i,xx:Integer;
begin
  //Saldo mese attuale
  salmeseatt:=totoreres - debtotmes - totliqmm;
  //Saldo fine mese precedente
  //considerando eventuali azzeramenti
  salfmprec:=salannoatt_prec;
  if (azzsaldofmpos = 'S') and (salfmprec > 0) then
    salfmprec:=0;
  if (azzsaldofmpos = 'C') and (anno400 > 1998) and (eccsolocompres_prec > salcompannoprec_prec) then
    salfmprec:=salfmprec - eccsolocompres_prec + salcompannoprec_prec;
  //Saldo anno attuale
  salannoatt:=salfmprec + salmeseatt;
  //Straordinario liq. da inizio anno derivato dal giornaliero
  for i:=1 to NFasceMese + 1 do
    tstranno[i]:=tstranno_prec[i] + tminstrmen[i];
  //Lavorato mensile per calcolo PORESO
  totore:=totoreres - totliqmm;
  if (poflag = '1') or (salannoatt_prec <= salpoanno_prec) then
    totore:=totore + salannoatt_prec - salpoanno_prec;
  //Debito plus orario effettivo del mese
  debpoeff:=debpomes - salpoanno_prec;
  //Plus orario effettivo reso nel mese
  if totore <= debormes then
    poreso:=0
  else
    begin
    poreso:=totore - debormes;
    if poreso > debpoeff then
      poreso:=debpoeff;
    end;
  //Plus orario reso da inizio anno
  poresoanno:=poresoanno_prec + poreso;
  //Saldo plus orario annuale
  salpoanno:=salpoanno_prec + poreso - debpomes;
  //Eccedenza solo comp. dell'anno derivata dalla giornaliera
  eccsolocompanno:=eccsolocompanno_prec + eccsolocompmes;
  //Totale straordinario liq. da inizio anno derivato dal
  //giornaliero detratto del liquidato e dell'eventuale plus orario reso
  strliqgganno:=0;
  for i:=1 to NFasceMese + 1 do
    strliqgganno:=strliqgganno + tstranno[i] - tstrliq[i];
  if eccsolocompanno < poresoanno then
    strliqgganno:=strliqgganno - (poresoanno - eccsolocompanno);
  //Totale straordinario liq. da inizio anno derivato dal
  //giornaliero aggiornato con la variazione alle eccedenze
  //per liquidazione dell'anno
  strliqgganno:=strliqgganno + vareccliqanno;
  if strliqgganno < 0 then
    strliqgganno:=0;
  //Eccedenza totale da inizio anno
  if salannoatt > salpoanno then
    ecctotanno:=salannoatt - salpoanno
  else
    ecctotanno:=0;
  //Eccedenza solo compensabile residua da inizio anno
  if strliqgganno > ecctotanno then
    eccsolocompres:=0
  else
    eccsolocompres:=ecctotanno - strliqgganno;
  //Straordinario liquidabile da inizio anno (automatico)
  for i:=1 to NFasceMese + 1 do
    tstrannom[i]:=tstrliq[i];
  if strliqgganno > ecctotanno then
    scostcomodo:=ecctotanno
  else
    scostcomodo:=strliqgganno;
  for i:=NFasceMese + 1 downto 1 do
    begin
    if scostcomodo = 0 then Break;
    if tstrannom[i] < tstranno[i] then
      begin
      diffcomodo:=tstranno[i] - tstrannom[i];
      if diffcomodo > scostcomodo then
        begin
        inc(tstrannom[i],scostcomodo);
        scostcomodo:=0;
        end
      else
        begin
        inc(tstrannom[i],diffcomodo);
        dec(scostcomodo,diffcomodo);
        end;
      end;
    end;
  inc(tstrannom[1],scostcomodo);
  //Totale straordinario liquidabile da inizio anno
  stranno:=0;
  for i:=1 to NFasceMese + 1 do
    inc(stranno,tstrannom[i]);
  //Straordinario effettivo liquidabile nel mese
  if stranno > stranno_prec then
    for i:=1 to NFasceMese + 1 do tstrmese[i]:=tstrannom[i] - tstrannom_prec[i]
  else
    for xx:=Low(tstrmese) to High(tstrmese) do tstrmese[xx]:=0;
  //Straordinario liquidabile anno precedente
  salliqannoprec:=salliqannoprec_prec;
  //Saldo compensabile anno precedente
  salcompannoprec:=salcompannoprec_prec;
  if (scostnegmes + eccsolocompmes) < 0 then
    begin
    diffcomodo:= - (scostnegmes + eccsolocompmes);
    if diffcomodo > salcompannoprec then
      salcompannoprec:=0
    else
      dec(salcompannoprec,diffcomodo);
    end;
end;

procedure TR450DtM1.y200_contdati2;
{Conteggio dati del mese tipo 'Compensazione non cumulabile'
 Es. MARTINI}
var i,xx:Integer;
begin
  //Saldo fine mese precedente
  salfmprec:=salannoatt_prec;
  if (azzsaldofmpos = 'S') and (salfmprec > 0) then
    salfmprec:=0;
  //Lo scostamento negativo viene consederato al netto della
  //variazione alle eccedenze per liquidazione
  if vareccliqmes < 0 then
    begin
    scostnegmesnetto:=scostnegmes - vareccliqmes;
    if scostnegmesnetto > 0 then
      scostnegmesnetto:=0;
    end
  else
    scostnegmesnetto:=scostnegmes;
  //Calcolo eccedenza solo compensabile con assenza da azzerare
  if eccsolocompmes < - scostnegmesnetto then
    eccsolocompmesazz:=0
  else
    begin
    eccsolocompmesazz:=eccsolocompmes + scostnegmesnetto;
    if salfmprec < 0 then
      if eccsolocompmesazz < - salfmprec then
        eccsolocompmesazz:=0
      else
        inc(eccsolocompmesazz,salfmprec);
    end;
  //Saldo mese attuale
  salmeseatt:=totoreres - eccsolocompmesazz - debtotmes - totliqmm;
  //Saldo anno attuale
  salannoatt:=salfmprec + salmeseatt;
  //Totale recupero ore anno precedente da inizio anno
  abbannoprecanno:=abbannoprecanno_prec + abbannoprecmes;
  //Saldo compensabile anno precedente
  salcompannoprec:=l13_sallav_min - (*l13_liqann_min -*) abbannoprecanno;
  //Saldo compensabile anno attuale
  if (salcompannoprec > 0) and (salannoatt > 0) then
    if salcompannoprec > salannoatt then
      begin
      salcompannoprec:=salannoatt;
      salcompannoatt:=0;
      end
    else
      salcompannoatt:=salannoatt - salcompannoprec
  else
    begin
    salcompannoprec:=0;
    salcompannoatt:=salannoatt;
    end;
  //Straordinario liq. da inizio anno derivato dal giornaliero
  for i:=1 to NFasceMese + 1 do
    tstranno[i]:=tstranno_prec[i] + tminstrmen[i];
  //Lavorato mensile per calcolo PORESO
  totore:=totoreres - totliqmm;
  if (poflag = '1') or (salannoatt_prec <= salpoanno_prec) then
    totore:=totore + salannoatt_prec - salpoanno_prec;
  //Debito plus orario effettivo del mese
  debpoeff:=debpomes - salpoanno_prec;
  //Plus orario effettivo reso nel mese
  if totore <= debormes then
    poreso:=0
  else
    begin
    poreso:=totore - debormes;
    if poreso > debpoeff then
      poreso:=debpoeff;
    end;
  //Plus orario reso da inizio anno
  poresoanno:=poresoanno_prec + poreso;
  //Saldo plus orario annuale
  salpoanno:=salpoanno_prec + poreso - debpomes;
  //Eccedenza solo comp. dell'anno derivata dalla giornaliera
  eccsolocompanno:=eccsolocompanno_prec + eccsolocompmes;
  //Totale straordinario liq. da inizio anno derivato dal
  //giornaliero detratto del liquidato e dell'eventuale plus orario reso
  strliqgganno:=0;
  for i:=1 to NFasceMese + 1 do
    strliqgganno:=strliqgganno + tstranno[i] - tstrliq[i];
  if eccsolocompanno < poresoanno then
    strliqgganno:=strliqgganno - (poresoanno - eccsolocompanno);
  //Totale straordinario liq. da inizio anno derivato dal
  //giornaliero aggiornato con la variazione alle eccedenze
  //per liquidazione dell'anno
  strliqgganno:=strliqgganno + vareccliqanno;
  if strliqgganno < 0 then
    strliqgganno:=0;
  //cedenza totale da inizio anno
  if salannoatt > salpoanno then
    ecctotanno:=salannoatt - salpoanno
  else
    ecctotanno:=0;
  //Eccedenza solo compensabile residua da inizio anno
  if strliqgganno > ecctotanno then
    eccsolocompres:=0
  else
    eccsolocompres:=ecctotanno - strliqgganno;
  //Straordinario liquidabile da inizio anno (automatico)
  for i:=1 to NFasceMese + 1 do
    tstrannom[i]:=tstrliq[i];
  if strliqgganno > ecctotanno then
    scostcomodo:=ecctotanno
  else
    scostcomodo:=strliqgganno;
  for i:=NFasceMese + 1 downto 1 do
    begin
    if scostcomodo = 0 then Break;
    if tstrannom[i] < tstranno[i] then
      begin
      diffcomodo:=tstranno[i] - tstrannom[i];
      if diffcomodo > scostcomodo then
        begin
        inc(tstrannom[i],scostcomodo);
        scostcomodo:=0;
        end
      else
        begin
        inc(tstrannom[i],diffcomodo);
        dec(scostcomodo,diffcomodo);
        end;
      end;
    end;
  inc(tstrannom[1],scostcomodo);
  //Totale straordinario liquidabile da inizio anno
  stranno:=0;
  for i:=1 to NFasceMese + 1 do
    inc(stranno,tstrannom[i]);
  //Straordinario effettivo liquidabile nel mese
  if stranno > stranno_prec then
    for i:=1 to NFasceMese + 1 do tstrmese[i]:=tstrannom[i] - tstrannom_prec[i]
  else
    for xx:=Low(tstrmese) to High(tstrmese) do tstrmese[xx]:=0;
  //Straordinario liquidabile anno precedente
  salliqannoprec:=salliqannoprec_prec;
end;

procedure TR450DtM1.y300_contdati3;
{Conteggio dati del mese tipo 'Mensile elastico'
 Es. CARRARA}
var i,xx:Integer;
begin
  //Saldo mese attuale
  salmeseatt:=totoreres - debtotmes - totliqmm;
  //Saldo fine mese precedente
  salfmprec:=salannoatt_prec;
  //Saldo anno attuale
  salannoatt:=salfmprec + salmeseatt;
  //Straordinario liq. da inizio anno derivato dal giornaliero
  for i:=1 to NFasceMese + 1 do
    tstranno[i]:=tstranno_prec[i] + tminstrmen[i];
  //Lavorato mensile per calcolo PORESO
  totore:=totoreres - totliqmm;
  if (poflag = '1') or (salannoatt_prec <= salpoanno_prec) then
    totore:=totore + salannoatt_prec - salpoanno_prec;
  //Debito plus orario effettivo del mese
  debpoeff:=debpomes - salpoanno_prec;
  //Plus orario effettivo reso nel mese
  if totore <= debormes then
    poreso:=0
  else
    begin
    poreso:=totore - debormes;
    if poreso > debpoeff then
      poreso:=debpoeff;
    end;
  //Plus orario reso da inizio anno
  poresoanno:=poresoanno_prec + poreso;
  //Saldo plus orario annuale
  salpoanno:=salpoanno_prec + poreso - debpomes;
  //Eccedenza solo comp. dell'anno derivata dalla giornaliera
  eccsolocompanno:=eccsolocompanno_prec + eccsolocompmes;
  //Totale straordinario liq. da inizio anno derivato dal
  //giornaliero detratto del liquidato e dell'eventuale plus orario reso
  strliqgganno:=0;
  for i:=1 to NFasceMese + 1 do
    strliqgganno:=strliqgganno + tstranno[i] - tstrliq[i];
  if eccsolocompanno < poresoanno then
    strliqgganno:=strliqgganno - (poresoanno - eccsolocompanno);
  //Totale straordinario liq. da inizio anno derivato dal
  //giornaliero aggiornato con la variazione alle eccedenze
  //per liquidazione dell'anno
  strliqgganno:=strliqgganno + vareccliqanno;
  if strliqgganno < 0 then
    strliqgganno:=0;
  //Eccedenza totale da inizio anno
  if salannoatt > salpoanno then
    ecctotanno:=salannoatt - salpoanno
  else
    ecctotanno:=0;
  //Eccedenza solo compensabile residua da inizio anno
  if strliqgganno > ecctotanno then
    eccsolocompres:=0
  else
    eccsolocompres:=ecctotanno - strliqgganno;
  //Straordinario liquidabile da inizio anno (automatico)
  for i:=1 to NFasceMese + 1 do
    tstrannom[i]:=tstrliq[i];
  ecctotanno:=salannoatt - salpoanno + 180;
  if ecctotanno < 0 then
    ecctotanno:=0;
  if strliqgganno > ecctotanno then
    scostcomodo:=ecctotanno
  else
    scostcomodo:=strliqgganno;
  for i:=NFasceMese + 1 downto 1 do
    begin
    if scostcomodo = 0 then Break;
    if tstrannom[i] < tstranno[i] then
      begin
      diffcomodo:=tstranno[i] - tstrannom[i];
      if diffcomodo > scostcomodo then
        begin
        inc(tstrannom[i],scostcomodo);
        scostcomodo:=0;
        end
      else
        begin
        inc(tstrannom[i],diffcomodo);
        dec(scostcomodo,diffcomodo);
        end;
      end;
    end;
  inc(tstrannom[1],scostcomodo);
  //Totale straordinario liquidabile da inizio anno
  stranno:=0;
  for i:=1 to NFasceMese + 1 do
    inc(stranno,tstrannom[i]);
  //Straordinario effettivo liquidabile nel mese
  if stranno > stranno_prec then
    for i:=1 to NFasceMese + 1 do tstrmese[i]:=tstrannom[i] - tstrannom_prec[i]
  else
    for xx:=Low(tstrmese) to High(tstrmese) do tstrmese[xx]:=0;
  //Straordinario liquidabile anno precedente
  salliqannoprec:=salliqannoprec_prec;
end;

procedure TR450DtM1.y400_contdati4;
{Conteggio dati del mese tipo 'Gestione compensazioni' Es. COLLEGNO}
var i,j,xx,iRM,StrEsternoApp,app,app1,app2,DiffRecup,DiffRecupTot:Integer;
    OreRecuperate,RecuperoMensile,LiquidabilePrecedente:Integer;
    MeseRif,MeseAbb:Integer;
    iVariazioneSaldiAnniPrec,VariazioneLiqAnnoAtt:Integer;
    EccResAutMenVariato:Integer;
    OreCompRecupSoloBancaOre:Integer;
    abbannopreceffComodo:Integer;
    procedure SalvaRiepilogoPrecedente;
    {Salvataggio saldi del mese precedente}
    begin
      RiepilogoPrecedente.CompensabileAtt:=salcompannoatt_prec;
      RiepilogoPrecedente.CompensabilePrec:=salcompannoprec_prec;
      RiepilogoPrecedente.LiquidabileAtt:=salliqannoatt_prec;
      RiepilogoPrecedente.LiquidabilePrec:=salliqannoprec_prec;
      RiepilogoPrecedente.BancaOreResidua:=GetBOInclusaSaldi(BancaOreResidua_prec);
      RiepilogoPrecedente.BancaOreResiduaPrec:=GetBOInclusaSaldi(BancaOreResiduaPrec_prec);
      RiepilogoPrecedente.StrResiduoAnno:=StrResiduoAnno_prec;
      RiepilogoPrecedente.SaldoNegativoMinimoEcced:=SaldoNegativoMinimoEcced;
      SaldoNegativoMinimoEcced:=0;
    end;
    procedure AbbattiLiquidabile(Q:Integer);
    {Abbatte lo straordinario in seguito alla decurtazione mensile indicata nel limite straordinario}
    var i,QSalva:Integer;
    begin
      QSalva:=Q;
      for i:=1 to NFasceMese do
      begin
        if Q = 0 then Break;
        //Abbattimento straordinario annuale
        if tstrannom[i] > Q then
        begin
          dec(tstrannom[i],Q);
          Q:=0;
        end
        else
        begin
          dec(Q,tstrannom[i]);
          tstrannom[i]:=0;
        end;
      end;
      Q:=QSalva;
      for i:=1 to NFasceMese do
      begin
        if Q = 0 then Break;
        //Abbattimento straordinario mensile
        if tstrmese[i] > Q then
        begin
          dec(tstrmese[i],Q);
          Q:=0;
        end
        else
        begin
          dec(Q,tstrmese[i]);
          tstrmese[i]:=0;
        end;
      end;
    end;
    procedure LimiteEccedenzaMensile2;
    {Limitazione eccedenza mensile dai limiti del Budget (Molinette)}
    begin
      app:=EccResAutMenVariato;
      if (RiposoRecupLiquid = 'S') and (RiposoNonFruito <> '') then
        inc(app,RiposiNonFruitiOre);
      if TroncaLiquidabile = 'CL' then
        //scostcomodo:=(FCompensabileMensile + min(liquidabmese,max(0,salmeseatt - salmeseattnocau)) + min(min(0,salcompannoatt_prec),salfmprec)) - app
        //scostcomodo:=(max(FCompensabileMensile,liquidabmese) + min(min(0,salcompannoatt_prec),salfmprec)) - app  //Alberto: Rieti_ASL
        scostcomodo:=min(max(FCompensabileMensile,liquidabmese),max(0,salmeseatt)) + min(min(0,salcompannoatt_prec),salfmprec) - app  //Alberto 07/02/2009: Torino_ARPA
      else
        scostcomodo:=liquidabmese - app;
      inc(FOreTroncate,scostcomodo);
      dec(salmeseatt,scostcomodo);
      dec(salmeseattnocau,scostcomodo);
      dec(FCompensabileMensile,scostcomodo);
      if FCompensabileMensile < 0 then
        FCompensabileMensile:=0;
      dec(salannoatt,scostcomodo);
      dec(salannonetto,scostcomodo);
      if salcompannoatt > scostcomodo then
      begin
        dec(salcompannoatt,scostcomodo);
        scostcomodo:=0;
      end
      else
      begin
        dec(scostcomodo,salcompannoatt);
        salcompannoatt:=0;
      end;
      if salliqannoatt > scostcomodo then
      begin
        dec(salliqannoatt,scostcomodo);
        AbbattiLiquidabile(scostcomodo);
        scostcomodo:=0;
      end
      else
      begin
        dec(scostcomodo,salliqannoatt);
        AbbattiLiquidabile(salliqannoatt);
        salliqannoatt:=0;
      end;
      if scostcomodo > 0 then
        dec(salcompannoatt,scostcomodo);
    end;
    procedure TroncaturaPeriodica;
    {Gestione troncatura dei saldi positivi periodica (Pinerolo)}
    var i:Integer;
    begin
      //Ricalcolo del saldo fine mese precedente come saldo del solo anno attuale
      salfmprec:=salcompannoatt_prec + salliqannoatt_prec;
      if salcompannoprec_prec + salliqannoprec_prec < 0 then
      begin
        //Aggiunta del saldo anno precedente solo se negativo
        inc(salfmprec,salcompannoprec_prec + salliqannoprec_prec);
        inc(salcompannoatt_prec,salcompannoprec_prec);
        inc(salliqannoatt_prec,salliqannoprec_prec);
      end
      else if (salfmprec < 0) and (AbbattimentoFissoRecupero = 'S') then  //Per MONDOVI_ASL 16
      begin
        //Aggiunta del saldo anno precedente solo se negativo
        inc(FOrePersePeriodiche,salcompannoprec_prec + salliqannoprec_prec - min(salcompannoprec_prec + salliqannoprec_prec,-salfmprec));
        inc(salcompannoatt_prec,min(salcompannoprec_prec + salliqannoprec_prec,-salfmprec));
        inc(salfmprec,min(salcompannoprec_prec + salliqannoprec_prec,-salfmprec));
      end
      else
        //Memorizzazione ore perse
        inc(FOrePersePeriodiche,salcompannoprec_prec + salliqannoprec_prec);
      //La situazione attuale diventa quella precedente
      salcompannoprec_prec:=salcompannoatt_prec;
      salliqannoprec_prec:=salliqannoatt_prec;
      if salliqannoprec_prec < 0 then
      begin
        inc(salcompannoprec_prec,salliqannoprec_prec);
        salliqannoprec_prec:=0;
      end;
      //Azzeramento saldo attuale
      salliqannoatt_prec:=0;
      salcompannoatt_prec:=0;
      //Alberto 06/09/2000 azzeramento già liquidato
      for i:=1 to NFasceMese do
      begin
        tstrannom_prec[i]:=0;
        tstrannoprecm[i]:=0;
        tstrliq_prec[i]:=0;
        if (LiquidazioneDistribuita = 'S') or (R455_tipocon <> 4) then
          tstrliq[i]:=tstrliqmm[i]
        else
          tstrliq[i]:=tLiqNelMese[i];
      end;
    end;
    procedure AbbattimentoSaldiNonRecuperati;
    {Melegnano:Abbattimento del saldo non usato per coprire gli scostamenti negativi
     maturati tra i mesi indicati (MeseRif e MeseAbb)}
    var i,AbbTemp:Integer;
    begin
      if MeseCorr400 = MeseRif then
      begin
        //Salvataggio del saldo anno al mese di riferimento (es. fine Giugno)
        SaldoDaAbbattere:=salfmprec;
        //Alberto 10/02/2007: AIPO_PARMA e GENOVA_COMUNE
        if AbbattRifLiquidabile = 'N' then
          dec(SaldoDaAbbattere,Max(0,RiepilogoPrecedente.LiquidabileAtt) + Max(0,RiepilogoPrecedente.LiquidabilePrec));
        if AbbattRifCompensabile = 'N' then
          dec(SaldoDaAbbattere,Max(0,RiepilogoPrecedente.CompensabileAtt) + Max(0,RiepilogoPrecedente.CompensabilePrec))
        else if BancaOrePreservata = 'S' then
          dec(SaldoDaAbbattere,RiepilogoPrecedente.BancaOreResidua + RiepilogoPrecedente.BancaOreResiduaPrec);
        ScostNegDaAbbattere:=0;
      end;
      //Cumulo degli scostamenti negativi tra Luglio e Settembre
      if (MeseCorr400 >= MeseRif) and (MeseCorr400 < MeseAbb) then
        //inc(ScostNegDaAbbattere,Abs(scostnegmes)); Alberto 19/06/2008: sostituito con la riga seguente:
        if AbbattRifRecupero = '0' then
          inc(ScostNegDaAbbattere,Max(Abs(scostnegmes),Abs(min(0,salmeseatt))))
        else if AbbattRifRecupero = '1' then
          inc(ScostNegDaAbbattere,Abs(min(0,salmeseatt)));
      //A Ottobre si perdono le ore
      //if (MeseCorr400 = MeseAbb) and (SaldoDaAbbattere > 0) then
      if (MeseCorr400 <> MeseAbb) or (SaldoDaAbbattere <= 0) then
        exit;
      //Ore effettive da perdere
      SaldoDaAbbattere:=SaldoDaAbbattere - ScostNegDaAbbattere;
      if SaldoDaAbbattere > (salcompannoprec_prec + salliqannoprec_prec + salcompannoatt_prec + salliqannoatt_prec) then
        SaldoDaAbbattere:=Max(0,salcompannoprec_prec + salliqannoprec_prec + salcompannoatt_prec + salliqannoatt_prec);
      if SaldoDaAbbattere <= 0 then
        exit;
      inc(FOrePersePeriodiche,SaldoDaAbbattere);
      //Abbattimento saldo complessivo
      dec(salfmprec,SaldoDaAbbattere);
      //Anno precedente
      if AbbattRifCompensabile = 'S' then
      begin
        //Abbattimento saldo compensabile anno precedente
        if BancaOrePreservata = 'S' then
          AbbTemp:=Max(0,salcompannoprec_prec - GetBOInclusaSaldi(l13_banca_ore))
        else
          AbbTemp:=Max(0,salcompannoprec_prec);
        AbbTemp:=Min(AbbTemp,SaldoDaAbbattere);
        dec(salcompannoprec_prec,AbbTemp);
        dec(SaldoDaAbbattere,Abbtemp);
        if (BancaOrePreservata = 'N') and (BancaOreEsclusaSaldi <> 'S') then
          dec(l13_banca_ore,Max(0,Min(l13_banca_ore,AbbTemp)));
      end;
      if AbbattRifLiquidabile = 'S' then
      begin
        //Abbattimento saldo liquidabile anno precedente
        if salliqannoprec_prec >= SaldoDaAbbattere then
        begin
          dec(salliqannoprec_prec,SaldoDaAbbattere);
          SaldoDaAbbattere:=0;
        end
        else
        begin
          dec(SaldoDaAbbattere,salliqannoprec_prec);
          salliqannoprec_prec:=0;
        end;
      end;
      //Anno corrente
      if AbbattRifCompensabile = 'S' then
      begin
        //Abbattimento saldo compensabile anno corrente
        if BancaOrePreservata = 'S' then
          AbbTemp:=Max(0,salcompannoatt_prec - FBancaoreAnno)
        else
          AbbTemp:=Max(0,salcompannoatt_prec);
        AbbTemp:=Min(AbbTemp,SaldoDaAbbattere);
        dec(salcompannoatt_prec,AbbTemp);
        dec(SaldoDaAbbattere,Abbtemp);
        if BancaOrePreservata = 'N' then
          dec(FBancaoreAnno,Max(0,Min(FBancaoreAnno,AbbTemp)));
      end;
      if AbbattRifLiquidabile = 'S' then
      begin
        //Abbattimento saldo liquidabile anno attuale
        SaldoDaAbbattere:=Min(SaldoDaAbbattere,salliqannoatt_prec);
        dec(salliqannoatt_prec,SaldoDaAbbattere);
        //Abbattimento liquidabile da inizio anno (non viene abbattuto il liquidato tstrliq_prec)
        for i:=1 to NFasceMese do
        begin
          if SaldoDaAbbattere = 0 then Break;
          if tstrannom_prec[i] > SaldoDaAbbattere then
          begin
            dec(tstrannom_prec[i],SaldoDaAbbattere);
            SaldoDaAbbattere:=0;
          end
          else
          begin
            dec(SaldoDaAbbattere,tstrannom_prec[i]);
            tstrannom_prec[i]:=0;
          end;
        end;
      end;
    end;
    procedure SaldiMobili;
    {Troncatura dell'eccedenza non recuperata entro i mesi specificati (Genova_HSMartino)}
    var i,j,k,x,Q,iRM,Abbattimento,BO,BOCorr,BOPrec:Integer;
        SaldoPrec,SaldoAtt,SaldoDisponibile:Integer;
        D:TDateTime;
    begin
      iRM:=High(RiepilogoMese);
      //Saldo al mese corrente
      SaldoAtt:=RiepilogoMese[iRM].SaldoAnnoAtt;
      RiepilogoMese[iRM].RiepSaldiMobili_SaldoDisponibile:=SaldoAtt;
      //if SaldoAtt <= 0 then //Alberto: esco dopo, in modo da calcolare comunque il saldo precedente per la visualizzazione
      //  exit;
      //Ricerca del mese precedente a cui riferirsi (0 = mese corrente)
      x:=-1;
      D:=R180AddMesi(EncodeDate(AnnoCorr400,Mesecorr400,1),-MesiSaldoprec);
      for i:=Low(RiepilogoMese) to High(RiepilogoMese) do
        if RiepilogoMese[i].Data = D then
        begin
          x:=i;
          Break;
        end;
      if x = -1 then
        exit;
      //SaldoPrec è il saldo del primo mese del periodo: indica quanto può essere l'abbattimento,
      //considerando i recuperi che sono stati fatti nei mesi successivi (RecuperoMensile)
      //Saldo abbattibile: saldo mensile
      SaldoPrec:=RiepilogoMese[x].SaldoMeseNoCau + RiepilogoMese[x].OreRecuperate;
      if LiquidazioneDistribuita = 'N' then
        //Non considero l'eventuale liquidato nel mese
        Dec(SaldoPrec,RiepilogoMese[x].OreLiqMese);
      if (SaldoMobile_Riferimento = '1') or (SaldoMobile_Riferimento = '2') then
      //Saldo abbattibile: minimo tra saldo mensile ed annuale (Per COMUNEDIGENOVA è l'annuale)
      begin
        Q:=0;
        BO:=RiepilogoMese[x].BancaOreResAtt + RiepilogoMese[x].BancaOreResPrec;
        if Pos('C',SaldoMobile_SaldiUsati) > 0 then
          if BancaOrePreservata = 'S' then
            Inc(Q,RiepilogoMese[x].SaldoAnnoComp - BO)
          else
            Inc(Q,RiepilogoMese[x].SaldoAnnoComp);
        if Pos('L',SaldoMobile_SaldiUsati) > 0 then
          inc(Q,RiepilogoMese[x].SaldoAnnoLiq);
        if SaldoMobile_Riferimento = '1' then
          SaldoPrec:=Min(SaldoPrec,Q)
        else
          SaldoPrec:=Q; //COMUNEDIGENOVA
      end;
      RiepilogoMese[iRM].RiepSaldiMobili_SaldoPrecedente:=SaldoPrec;
      if SaldoAtt <= 0 then
        exit;
      for i:=x + 1 to High(RiepilogoMese) do
      begin
        k:=max(0,min(SaldoPrec,RiepilogoMese[i].RecuperoMensile));
        dec(RiepilogoMese[i].RecuperoMensile,k);
        dec(SaldoPrec,k);
        RiepilogoMese[i].RiepSaldiMobili_Recupero:=k;
      end;
      if SaldoPrec <= 0 then
        exit;
      //Calcolo delle ore che si possono effettivamente abbattere considerando i serbatoi specificati dall'utente
      SaldoDisponibile:=0;
      BO:=RiepilogoMese[iRM].BancaOreResAtt + RiepilogoMese[iRM].BancaOreResPrec;
      if Pos('C',SaldoMobile_SaldiUsati) > 0 then
        if BancaOrePreservata = 'S' then
          inc(SaldoDisponibile,RiepilogoMese[iRM].SaldoAnnoComp - BO)
        else
          inc(SaldoDisponibile,RiepilogoMese[iRM].SaldoAnnoComp);
      if Pos('L',SaldoMobile_SaldiUsati) > 0 then
        inc(SaldoDisponibile,RiepilogoMese[iRM].SaldoAnnoLiq);
      RiepilogoMese[iRM].RiepSaldiMobili_SaldoDisponibile:=SaldoDisponibile;
      //Calcolo dell'abbattimento applicabile, tenendo conto del limite impostato dall'utente
      RiepilogoMese[iRM].Abbattimento:=min(SaldoPrec,SaldoAtt);
      RiepilogoMese[iRM].Abbattimento:=min(RiepilogoMese[iRM].Abbattimento,SaldoMobile_AbbatteMax);
      RiepilogoMese[iRM].Abbattimento:=min(RiepilogoMese[iRM].Abbattimento,SaldoDisponibile);
      if RiepilogoMese[iRM].Abbattimento < 0 then
      begin
        RiepilogoMese[iRM].Abbattimento:=0;
        exit;
      end;
      //Abbattimento delle ore dai serbatoi
      Abbattimento:=RiepilogoMese[iRM].Abbattimento;
      dec(salannoatt,Abbattimento);
      FOrePersePeriodiche:=Abbattimento;
      BO:=0;
      BOPrec:=0;
      BOCorr:=0;
      if BancaOrePreservata = 'S' then
      begin
        BO:=RiepilogoMese[iRM].BancaOreResAtt + RiepilogoMese[iRM].BancaOreResPrec;
        BOCorr:=RiepilogoMese[iRM].BancaOreResAtt;
        BOPrec:=RiepilogoMese[iRM].BancaOreResPrec;
      end;
      for i:=1 to Length(SaldoMobile_SaldiUsati) do
        if (Abbattimento > 0) and (SaldoMobile_SaldiUsati[i] = 'C') and (RiepilogoMese[iRM].SaldoAnnoComp - BO > 0) then
        begin
          k:=min(Abbattimento,RiepilogoMese[iRM].SaldoAnnoComp - BO);
          dec(RiepilogoMese[iRM].SaldoAnnoComp,k);
          if (salcompannoprec - BOPrec) > 0 then
          begin
            k:=min(Abbattimento,salcompannoprec - BOPrec);
            dec(Abbattimento,k);
            dec(salcompannoprec,k);
          end;
          if (Abbattimento > 0) and (salcompannoatt - BOCorr > 0) then
          begin
            k:=min(Abbattimento,salcompannoatt - BOCorr);
            dec(Abbattimento,k);
            dec(salcompannoatt,k);
          end;
        end
        else if (Abbattimento > 0) and (SaldoMobile_SaldiUsati[i] = 'L') and (RiepilogoMese[iRM].SaldoAnnoLiq > 0) then
        begin
          k:=min(Abbattimento,RiepilogoMese[iRM].SaldoAnnoLiq);
          dec(RiepilogoMese[iRM].SaldoAnnoLiq,k);
          if salliqannoprec > 0 then
          begin
            k:=min(Abbattimento,salliqannoprec);
            dec(Abbattimento,k);
            dec(salliqannoprec,k);
          end;
          if (Abbattimento > 0) and (salliqannoatt > 0) then
          begin
            k:=min(Abbattimento,salliqannoatt);
            dec(Abbattimento,k);
            dec(salliqannoatt,k);
            //Abbattimento straordinario annuale
            for j:=1 to NFasceMese do
            begin
              if k = 0 then Break;
              Q:=min(k,tstrannom[j] - tstrliq[j]);
              if Q < 0 then Continue;
              dec(tstrannom[j],Q);
              dec(k,Q);
            end;
          end;
        end;
    end;
    procedure SaldiMobiliRecuperoNegativi;
    {Verifica dello scostamento negativo non recuperato nei mesi successivi (Genova_HSMartino)}
    var i,k,x,iRM:Integer;
        SaldoPrec,SaldoAtt:Integer;
        D:TDateTime;
    begin
      iRM:=High(RiepilogoMese);
      //Ricerca del mese precedente a cui riferirsi (0 = mese corrente)
      x:=-1;
      D:=R180AddMesi(EncodeDate(AnnoCorr400,Mesecorr400,1),-MesiSaldoprec);
      for i:=Low(RiepilogoMese) to High(RiepilogoMese) do
        if RiepilogoMese[i].Data = D then
        begin
          x:=i;
          Break;
        end;
      if x = -1 then
        exit;
      //SaldoPrec è il saldo utile del primo mese del periodo: indica di quanto deve essere il recupero,
      //considerando i saldi positivi fatti nei mesi successivi (RecuperoMensile)
      SaldoPrec:=RiepilogoMese[x].SaldoMeseNoCau;
      if LiquidazioneDistribuita = 'N' then
        //Non considero l'eventuale liquidato nel mese
        Dec(SaldoPrec,RiepilogoMese[x].OreLiqMese);
      if (SaldoPrec >= 0) or (RiepilogoMese[x].SaldoAnnoAtt >= 0) then
        exit;
      SaldoPrec:=-SaldoPrec;
      //Ultimo saldo, utile per i recuperi dei mesi precedenti
      SaldoAtt:=RiepilogoMese[iRM].SaldoMeseNoCau;
      if LiquidazioneDistribuita = 'N' then
        Dec(SaldoAtt,RiepilogoMese[iRM].OreLiqMese);
      RiepilogoMese[iRM].RecuperoNegativi:=Max(0,SaldoAtt);
      for i:=x + 1 to iRM do
      begin
        k:=max(0,min(SaldoPrec,RiepilogoMese[i].RecuperoNegativi));
        dec(RiepilogoMese[i].RecuperoNegativi,k);
        dec(SaldoPrec,k);
      end;
      RiepilogoMese[iRM].NegativiNonRecuperati:=-SaldoPrec;
    end;
    {*}procedure SaldiMobiliRiepPres(Caus:String; Periodo:Integer);{*}
    var i,k,x,Q,iRM,iAtt,iPrec,iRiep:Integer;
        SaldoPrec,SaldoAtt,OreRecuperate:Integer;
        OreReseMeseTemp:array [1..MaxFasce] of Integer;
        D:TDateTime;
      procedure RecuperaLiquidato(Ore:Integer; Usato:Integer; Liquidato:array of Integer);
      var i,app:Integer;
      begin
        //Elimino la parte liquidata già usata da recuperi precedenti
        for i:=0 to High(Liquidato) do
        begin
          if Usato = 0 then
            Break;
          app:=min(Usato,Liquidato[i]);
          dec(Usato,app);
          dec(Liquidato[i],app);
        end;
        //Recupero la parte liquidata recuperata adesso
        for i:=0 to High(Liquidato) do
        begin
          if Ore = 0 then
            Break;
          app:=min(Ore,Liquidato[i]);
          app:=min(app,OreReseMeseTemp[i + 1]);
          dec(Ore,app);
          dec(OreReseMeseTemp[i + 1],app);
        end;
      end;
      procedure RecuperaOre(Ore:Integer);
      //Elimino le ore recuperate dalel fasce basse in modo da non abbatterle successivamente
      var i,app:Integer;
      begin
        for i:=1 to MaxFasce do
        begin
          if Ore = 0 then
            Break;
          app:=min(OreReseMeseTemp[i],Ore);
          dec(Ore,app);
          dec(OreReseMeseTemp[i],app);
        end;
      end;
    begin
      iRM:=High(RiepilogoMese);
      //Ricerca del mese precedente a cui riferirsi (0 = mese corrente)
      x:=-1;
      D:=R180AddMesi(EncodeDate(AnnoCorr400,Mesecorr400,1),-Periodo);
      for i:=Low(RiepilogoMese) to High(RiepilogoMese) do
        if RiepilogoMese[i].Data = D then
        begin
          x:=i;
          Break;
        end;
      if x = -1 then
        exit;
      //Indici di riferimento della causale sui riepiloghi
      iAtt:=IndiceRiepPres(Caus);
      iPrec:=IndiceRiepPresSM(x,Caus);
      if (iAtt = -1) or (iPrec = -1) then
        exit;
      //Saldi di riferimento:
      //SaldoAtt è il residuo della causale disponibile sull'ultimo mese da cui decurtare le ore perse
      SaldoAtt:=R180SommaArray(RiepilogoMese[iRM].RiepPres[iAtt].Residuo);
      //SaldoPrec sono le ore rese nel primo mese del periodo: indica quanto può essere l'abbattimento massimo
      SaldoPrec:=min(R180SommaArray(RiepilogoMese[x].RiepPres[iPrec].OreReseMese),R180SommaArray(RiepilogoMese[x].RiepPres[iPrec].Residuo));
      //Registro gli abbattimenti e i recuperi per la visualizzazione su scheda ripeilogativa
      if (AnnoCorr400 = Anno400) and (MeseCorr400 = Mese400) then
      begin
        SetLength(RiepilogoRecuperiRiepPres,Length(RiepilogoRecuperiRiepPres) + 1);
        iRiep:=High(RiepilogoRecuperiRiepPres);
        RiepilogoRecuperiRiepPres[iRiep].Causale:=Caus;
        RiepilogoRecuperiRiepPres[iRiep].Data:=D;
        RiepilogoRecuperiRiepPres[iRiep].OreRese:=SaldoPrec;
        RiepilogoRecuperiRiepPres[iRiep].OreResidue:=SaldoAtt;
        RiepilogoRecuperiRiepPres[iRiep].OrePerse:=0;
        RiepilogoRecuperiRiepPres[iRiep].OreRecuperate:=0;
        RiepilogoRecuperiRiepPres[iRiep].Compensabile:=0;
        RiepilogoRecuperiRiepPres[iRiep].CompUsato:=0;
        RiepilogoRecuperiRiepPres[iRiep].Recuperato:=0;
        RiepilogoRecuperiRiepPres[iRiep].RecupUsato:=0;
        RiepilogoRecuperiRiepPres[iRiep].Liquidato:=0;
        RiepilogoRecuperiRiepPres[iRiep].LiquidUsato:=0;
      end;
      //registro le ore rese nel primo mese per decurtarle dei recuperi già effettuati e non abbatterle ulteriormente
      for i:=1 to MaxFasce do
        OreReseMeseTemp[i]:=RiepilogoMese[x].RiepPres[iPrec].OreReseMese[i];
      //Scorro i mesi successivi per verificare i recuperi effettuati (compensazione su ore normali, causali cumulo S, liquidazione)
      for i:=x + 1 to iRM do
      begin
        k:=IndiceRiepPresSM(i,Caus);
        if k >= 0 then
        begin
          //Ore già recuperate nel mese all'interno dell'abbattimento disponibile (SaldoPrec)
          if SaldoPrec < 0 then
            OreRecuperate:=0
          else
          begin
            OreRecuperate:=RiepilogoMese[i].RiepPres[k].CompensabileMeseEff - RiepilogoMese[i].RiepPres[k].CompMeseUsato +
                           RiepilogoMese[i].RiepPres[k].RecuperoMese - RiepilogoMese[i].RiepPres[k].RecupMeseUsato +
                           R180SommaArray(RiepilogoMese[i].RiepPres[k].LiquidatoMese) - RiepilogoMese[i].RiepPres[k].LiquidMeseUsato;
            OreRecuperate:=min(SaldoPrec,OreRecuperate);
          end;
          dec(SaldoPrec,OreRecuperate);  //Le ore recuperate non saranno più da abbattere quindi le tolgo da SaldoPrec
          //Registro gli abbattimenti e i recuperi per la visualizzazione su scheda ripeilogativa
          if (AnnoCorr400 = Anno400) and (MeseCorr400 = Mese400) then
          begin
            SetLength(RiepilogoRecuperiRiepPres,Length(RiepilogoRecuperiRiepPres) + 1);
            iRiep:=High(RiepilogoRecuperiRiepPres);
            RiepilogoRecuperiRiepPres[iRiep].Causale:=Caus;
            RiepilogoRecuperiRiepPres[iRiep].Data:=R180AddMesi(D,i - x);
            RiepilogoRecuperiRiepPres[iRiep].OreRese:=0;
            RiepilogoRecuperiRiepPres[iRiep].OreResidue:=0;
            RiepilogoRecuperiRiepPres[iRiep].OreRecuperate:=OreRecuperate;
            RiepilogoRecuperiRiepPres[iRiep].Compensabile:=RiepilogoMese[i].RiepPres[k].CompensabileMeseEff;
            RiepilogoRecuperiRiepPres[iRiep].Recuperato:=RiepilogoMese[i].RiepPres[k].RecuperoMese;
            RiepilogoRecuperiRiepPres[iRiep].Liquidato:=R180SommaArray(RiepilogoMese[i].RiepPres[k].LiquidatoMese);
          end;
          //Aggiorno i contatori con i recuperi utilizzati
          //Liquidazione (si deve considerare per prima in modo da recuperare più precisamente dalle fasce giuste)
          Q:=min(OreRecuperate,R180SommaArray(RiepilogoMese[i].RiepPres[k].LiquidatoMese) - RiepilogoMese[i].RiepPres[k].LiquidMeseUsato);
          inc(RiepilogoMese[i].RiepPres[k].LiquidMeseUsato,Q);
          dec(OreRecuperate,Q);
          RecuperaLiquidato(Q,RiepilogoMese[i].RiepPres[k].LiquidMeseUsato,RiepilogoMese[i].RiepPres[k].LiquidatoMese);
          if (AnnoCorr400 = Anno400) and (MeseCorr400 = Mese400) then
            RiepilogoRecuperiRiepPres[iRiep].LiquidUsato:=Q;
          //Compensazioni su ore normali
          Q:=min(OreRecuperate,RiepilogoMese[i].RiepPres[k].CompensabileMeseEff - RiepilogoMese[i].RiepPres[k].CompMeseUsato);
          inc(RiepilogoMese[i].RiepPres[k].CompMeseUsato,Q);
          dec(OreRecuperate,Q);
          RecuperaOre(Q);
          if (AnnoCorr400 = Anno400) and (MeseCorr400 = Mese400) then
            RiepilogoRecuperiRiepPres[iRiep].CompUsato:=Q;
          //Recuperi da causali di assenza
          Q:=min(OreRecuperate,RiepilogoMese[i].RiepPres[k].RecuperoMese - RiepilogoMese[i].RiepPres[k].RecupMeseUsato);
          inc(RiepilogoMese[i].RiepPres[k].RecupMeseUsato,Q);
          dec(OreRecuperate,Q);
          RecuperaOre(Q);
          if (AnnoCorr400 = Anno400) and (MeseCorr400 = Mese400) then
            RiepilogoRecuperiRiepPres[iRiep].RecupUsato:=Q;
        end;
      end;
      //Registro gli abbattimenti e i recuperi per la visualizzazione su scheda riepilogativa
      if (AnnoCorr400 = Anno400) and (MeseCorr400 = Mese400) then
      begin
        SetLength(RiepilogoRecuperiRiepPres,Length(RiepilogoRecuperiRiepPres) + 1);
        iRiep:=High(RiepilogoRecuperiRiepPres);
        RiepilogoRecuperiRiepPres[iRiep].Causale:=Caus;
        RiepilogoRecuperiRiepPres[iRiep].Data:=EncodeDate(Anno400,Mese400,1);
        RiepilogoRecuperiRiepPres[iRiep].OreRese:=0;
        RiepilogoRecuperiRiepPres[iRiep].OreResidue:=0;
        RiepilogoRecuperiRiepPres[iRiep].OrePerse:=max(0,SaldoPrec);
      end;
      //Decurto l'abbattimento dai riepiloghi della causale sull'ultimo mese considerando le fasce delle ore rese nel primo mese.
      if (SaldoAtt > 0) and (SaldoPrec > 0) then
        for i:=1 to MaxFasce do
        begin
          Q:=min(SaldoPrec,RiepilogoMese[iRM].RiepPres[iAtt].Residuo[i]);
          Q:=min(Q,OreReseMeseTemp[i]);
          dec(RiepilogoMese[iRM].RiepPres[iAtt].Residuo[i],Q);
          dec(SaldoPrec,Q);
          inc(RiepilogoMese[iRM].RiepPres[iAtt].Abbattimento[i],Q);
        end;
      //Eventuali altri residui vengono tolti dalle fasce più basse
      if (SaldoAtt > 0) and (SaldoPrec > 0) then
        for i:=1 to MaxFasce do
        begin
          Q:=min(SaldoPrec,RiepilogoMese[iRM].RiepPres[iAtt].Residuo[i]);
          dec(RiepilogoMese[iRM].RiepPres[iAtt].Residuo[i],Q);
          dec(SaldoPrec,Q);
          inc(RiepilogoMese[iRM].RiepPres[iAtt].Abbattimento[i],Q);
        end;
      //Allinemento dei dati effettivi del riepilogo della causale
      for i:=1 to MaxFasce do
      begin
        RiepPres[iAtt].Residuo[i]:=RiepilogoMese[iRM].RiepPres[iAtt].Residuo[i];
        RiepPres[iAtt].Abbattimento[i]:=RiepilogoMese[iRM].RiepPres[iAtt].Abbattimento[i];
      end;
    end;
    procedure AddebitoSaldoNegativo(Effettivo:Boolean);
    {Il saldo negativo, addebitato sulle paghe, viene abbuonato sul cartellino}
    var i,j,k,SaldiMese,OreLiquidate,SaldoPrec,
        SaldoFin,RecupMesePrec:Integer;
        D:TDateTime;
    begin
      (* Alberto 17/06/2005: calcolo comunque
      if (AnnoCorr400 <> Anno400) or (MeseCorr400 <> Mese400) then
        //Mesi precedenti: si considera l'addebito registrato
      begin
        FAddebitoPaghe:=L07.AddebitoPaghe;
        inc(salannoatt,FAddebitoPaghe);
        inc(salcompannoatt,FAddebitoPaghe);
        exit;
      end;
      *)
      FAddebitoPagheRec:=0;
      if RecuperoDebito < 0 then
        exit;
      SaldiMese:=0;
      OreLiquidate:=0;
      SaldoPrec:=0;
      SaldoFin:=0;
      RecupMesePrec:=0;
      SaldoNegNonRecuperato:=0;
      D:=R180AddMesi(EncodeDate(AnnoCorr400,MeseCorr400,1),-RecuperoDebito);
      //Ricerca del mese di riferimento
      for i:=0 to High(RiepilogoMese) do
        if RiepilogoMese[i].Data = D then
        begin
          //Calcolo del saldo iniziale e del saldo finale
          //Saldo iniziale = saldo annuo (negativo)
          //Saldo finale = saldo iniziale + saldi mesi positivi + addebiti - liquidazioni(se Liquidazione non distribuita)
          SaldoFin:=0;
          for j:=i + 1 to High(RiepilogoMese) do
          begin
            if RecuperoDebitoTipo = '0' then
              inc(SaldiMese,max(0,RiepilogoMese[j].SaldoMeseNoCau))
            else
              inc(SaldiMese,max(0,RiepilogoMese[j].EccSoloCompMes + RiepilogoMese[j].StrLiqGGMese));
            inc(OreLiquidate,RiepilogoMese[j].OreLiqMese);
            inc(SaldoFin,RiepilogoMese[j].AddebitoPaghe);
          end;
          RecupMesePrec:=SaldiMese;
          if (LiquidazioneDistribuita = 'N') and (RecuperoDebitoTipo = '0') then
            RecupMesePrec:=max(0,SaldiMese - OreLiquidate);
          SaldoPrec:=RiepilogoMese[i].SaldoAnnoAtt;
          //Alberto 06/06/2005 - GENOVA_COMUNE - riporto il saldo al valore reale usando il saldo negativo minimo
          if SaldoNegativoMinimoTipo = '2' then //COMUNEDIGENOVA
            SaldoPrec:=RiepilogoMese[i].SaldoAnnoAtt + RiepilogoMese[i].SaldoNegativoMinimo - (RiepilogoMese[i].BancaOreResAtt + RiepilogoMese[i].BancaOreResPrec + RiepilogoMese[i].SaldoAnnoLiq);
          if RecuperoDebitoTipo = '0' then
            inc(SaldiMese,max(0,salmeseattnocau + IfThen(SaldoNegativoMinimoTipo = '1',SaldoNegativoMinimo,0)))
          else
            inc(SaldiMese,max(0,eccsolocompmes + strliqggmese + IfThen(SaldoNegativoMinimoTipo = '1',SaldoNegativoMinimo,0)));
          inc(OreLiquidate,totliqmm);
          if (LiquidazioneDistribuita = 'N') and (RecuperoDebitoTipo = '0') then
            SaldiMese:=max(0,SaldiMese - OreLiquidate);
          SaldoFin:=SaldoPrec + SaldoFin + SaldiMese;
          //Alberto 17/06/2005
          if (AnnoCorr400 <> Anno400) or (MeseCorr400 <> Mese400) then
            //Mesi precedenti: si considera l'addebito registrato
            FAddebitoPaghe:=L07.AddebitoPaghe
          else if (SaldoPrec < 0) and (SaldoFin < 0) then
          begin
            FAddebitoPaghe:=max(0,abs(SaldoFin) - RecDebitoMaxTollerato);
            FAddebitoPaghe:=min(FAddebitoPaghe,RecuperoDebitoMax);
          end;
          //Addebito delle ore sui saldi complessivi
          if Effettivo then
          begin
            inc(salannoatt,FAddebitoPaghe);
            inc(salcompannoatt,FAddebitoPaghe);
          end
          else
          begin
            SaldoNegNonRecuperato:=Min(0,SaldoPrec + FAddebitoPaghe);
            FAddebitoPaghe:=0;
          end;
          Break;
        end;
      //Gestione del saldo negativo del mese corrente se il periodo di recupero è di zero mesi
      if RecuperoDebito = 0 then
      begin
        RecupMesePrec:=0;
        SaldoPrec:=SalAnnoAtt;
        //Alberto 06/06/2005 - GENOVA_COMUNE - riporto il saldo al valore reale usando il saldo negativo minimo
        if SaldoNegativoMinimoTipo = '2' then //COMUNEDIGENOVA
          SaldoPrec:=SalAnnoAtt + SaldoNegativoMinimo - (GetBOInclusaSaldi(FBancaOreResidua) + GetBOInclusaSaldi(FBancaOreResiduaPrec) + salliqannoatt + salliqannoprec);
        SaldoFin:=SaldoPrec;
        //Alberto 17/06/2005
        if (AnnoCorr400 <> Anno400) or (MeseCorr400 <> Mese400) then
          //Mesi precedenti: si considera l'addebito registrato
          FAddebitoPaghe:=L07.AddebitoPaghe
        else if (SaldoPrec < 0) and (SaldoFin < 0) then
          begin
            FAddebitoPaghe:=max(0,abs(SaldoFin) - RecDebitoMaxTollerato);
            FAddebitoPaghe:=min(FAddebitoPaghe,RecuperoDebitoMax);
          end;
        //Addebito delle ore sui saldi complessivi
        if Effettivo then
        begin
          inc(salannoatt,FAddebitoPaghe);
          inc(salcompannoatt,FAddebitoPaghe);
        end
        else
        begin
          SaldoNegNonRecuperato:=Min(0,SaldoPrec + FAddebitoPaghe);
          FAddebitoPaghe:=0;
        end;
      end;
      //Lettura dei residui anni precedenti nel caso non siano attivati i saldi mobili
      if (Length(RiepilogoMese) = 0) and (MeseCorr400 = 1) and (RecuperoDebito = 1) then
      begin
        //Calcolo del saldo iniziale e del saldo finale
        //Saldo iniziale = saldo annuo precedente
        //Saldo finale = saldo mese corrente - liquidazioni(se Liquidazione non distribuita)
        SaldoFin:=0;
        SaldoPrec:=salfmprec + IfThen(SaldoNegativoMinimoTipo = '1',-SaldoNegativoMinimo,0);
        if RecuperoDebitoTipo = '0' then
          SaldiMese:=max(0,salmeseattnocau)
        else
          SaldiMese:=max(0,eccsolocompmes + strliqggmese);
        OreLiquidate:=totliqmm;
        if (LiquidazioneDistribuita = 'N') and (RecuperoDebitoTipo = '0') then
          SaldiMese:=max(0,SaldiMese - OreLiquidate);
        SaldoFin:=SaldoPrec + SaldoFin + SaldiMese;
        //Alberto 17/06/2005
        if (AnnoCorr400 <> Anno400) or (MeseCorr400 <> Mese400) then
          //Mesi precedenti: si considera l'addebito registrato
          FAddebitoPaghe:=L07.AddebitoPaghe
        else if (SaldoPrec < 0) and (SaldoFin < 0) then
        begin
          FAddebitoPaghe:=max(0,abs(SaldoFin) - RecDebitoMaxTollerato);
          FAddebitoPaghe:=min(FAddebitoPaghe,RecuperoDebitoMax);
        end;
        //Addebito delle ore sui saldi complessivi
        if Effettivo then
        begin
          inc(salannoatt,FAddebitoPaghe);
          inc(salcompannoatt,FAddebitoPaghe);
          FAddebitoPagheRec:=Max(0,-SaldoPrec) - FAddebitoPaghe;
        end
        else
        begin
          SaldoNegNonRecuperato:=Min(0,SaldoPrec + FAddebitoPaghe);
          FAddebitoPaghe:=0;
        end;
      end;
      //Alberto 19/11/2005: non si fa più la parte successiva:
      //si considera FAddebitoPagheRec nell'abbattimento finale di Banca ore e Liquidabile
      exit;
      (*Alberto 30/12/2005: il pezzo sotto non viene più eseguito*)
      if not Effettivo then
        exit;
      //COMUNE.DI.GENOVA: Abbattimento eccedenza liquidabile/banca ore usata per compensare il negativo
      if BancaOreMensArr > 0 then
      begin
        //Calcolo ore complessive da recuperare
        app:=Max(0,-(Min(0,SaldoPrec) - Min(0,SaldoFin)));
        //Calcolo quanto rimane da recuperare nel mese corrente
        app:=Max(0,app - RecupMesePrec);
        //Tolgo l'eccedenza liquidabile che non figura
        app:=Max(0,app - eccsolocompmes - (strliqggmese - (StrFattoMeseTotale + liquidabmese)));
        (*Alberto 21/01/2005 - prima era così
        //app1: straordinario liquidabile abbattibile
        app1:=Min(StrFattoMeseTotale,Trunc(R180Arrotonda(Min(app,StrFattoMeseTotale),BancaOreMensArr,'E')));
        //app: banca ore abbattibile
        app:=Max(0,app - app1);
        ...
        *)
        //Alberto 21/01/2005 - adesso è così (giro in più per recuperare prima sulla banca ore e poi sul liquidabile...)
        //app1: calcolo la banca ore abbattibile...
        app1:=Min(liquidabmese,Trunc(R180Arrotonda(Min(app,liquidabmese),BancaOreMensArr,'E')));
        //app1: ...poi lo trasformo nello straordinario liquidabile abbattibile
        app1:=Max(0,app - app1);
        app1:=Trunc(R180Arrotonda(app1,BancaOreMensArr,'E'));
        //app: banca ore abbattibile
        app:=Max(0,app - app1);
        //Abbattimento liquidabile
        dec(salliqannoatt,app1);
        inc(salcompannoatt,app1);
        for k:=1 to NFasceMese do
        begin
          if app1 = 0 then Break;
            if tstrmese[k] >= app1 then
            begin
              dec(tstrannom[k],app1);
              dec(tstrmese[k],app1);
              app1:=0;
            end
            else
            begin
              dec(tstrannom[k],tstrmese[k]);
              dec(app1,tstrmese[k]);
              tstrmese[k]:=0;
            end;
        end;
        //Abbattimento banca ore
        liquidabmese:=Max(0,liquidabmese - Trunc(R180Arrotonda(app,BancaOreMensArr,'E')));
      end;
    end;
    function Abbatti(var Saldo,Abbattimento:Integer):Integer;
    {Abbattimento del Saldo restituendo quanto effettivamente abbattuto}
    begin
      if Saldo >= Abbattimento then
      begin
        dec(Saldo,Abbattimento);
        Result:=Abbattimento;
        Abbattimento:=0;
      end
      else
      begin
        dec(Abbattimento,Saldo);
        Result:=Saldo;
        Saldo:=0;
      end;
    end;
    (*procedure VariazioniEccedenzeLiquidabili;
    {abbattimento liquidabile da variazione alle eccedenze}
    var Tot,i,j:Integer;
      procedure TrasferisciLiquidabileCompensabile(N:Integer);
      begin
        inc(salcompannoatt,N);
        inc(salcompannoattExt,N);
        dec(salliqannoatt,N);
      end;
    begin
      if vareccliqanno > 0 then
        vareccliqanno:=0;
      if vareccliqanno = 0 then
        exit;
      //abbattimento liquidabile mensile
      //scostcomodo = eccedenze giornaliere ancora disponibili dopo la variazione
      scostcomodo:= - vareccliqanno;
      Tot:=0;
      for i:=1 to NFasceMese do
        inc(Tot,tminstrmen[i]);
      scostcomodo:=Tot - scostcomodo;
      if scostcomodo < 0 then
        scostcomodo:=0;
      //nel liquidabile mensile preservo al massimo quanto c'è in scostcomodo (dalle fasce più alte)
      for i:=NFasceMese downto 1 do
      begin
        if scostcomodo = 0 then
        begin
          for j:=i downto 1 do
            tstrmese[j]:=0;
          Break;
        end;
        if tstrmese[i] > scostcomodo then
        begin
          tstrmese[i]:=scostcomodo;
          scostcomodo:=0;
        end
        else
          dec(scostcomodo,tstrmese[i]);
      end;
      //abbattimento eccedenze per liquidazione da inizio anno
      scostcomodo:= - vareccliqanno;
      Tot:=0;
      for i:=1 to NFasceMese do
      begin
        if tstranno[i] > scostcomodo then
        begin
          dec(tstranno[i],scostcomodo);
          scostcomodo:=0;
        end
        else
        begin
          dec(scostcomodo,tstranno[i]);
          tstranno[i]:=0;
        end;
        inc(Tot,tstranno[i]);
      end;
      vareccliqanno:= - scostcomodo;
      //scostcomodo = eccedenze annue disponibili dopo la variazione
      scostcomodo:=Tot;
      //nel liquidabile annuo preservo al massimo quanto c'è in scostcomodo (dalle fasce più alte)
      for i:=NFasceMese downto 1 do
      begin
        if scostcomodo = 0 then
        begin
          for j:=i downto 1 do
          begin
            TrasferisciLiquidabileCompensabile(tstrannom[j]);
            tstrannom[j]:=0;
          end;
          Break;
        end;
        if tstrannom[i] > scostcomodo then
        begin
          TrasferisciLiquidabileCompensabile(tstrannom[i] - scostcomodo);
          tstrannom[i]:=scostcomodo;
          scostcomodo:=0;
        end
        else
          dec(scostcomodo,tstrannom[i]);
      end;
    end;*)
    {Modificato rispetto al precedente per LaSpezia}
    procedure VariazioniEccedenzeLiquidabili;
    {abbattimento liquidabile da variazione alle eccedenze}
    var AbbEcc,AbbLiq,DiffLiq,Tot,i,j:Integer;
      procedure TrasferisciLiquidabileCompensabile(N:Integer);
      var N2:Integer;
      begin
        inc(salcompannoatt,N);
        inc(salcompannoattExt,N);
        dec(salliqannoatt,N);
        //Gestione del caso in cui il liquidabile aumenti e il compensabile diminuisca
        if (N < 0) and (salcompannoatt < 0) then
        begin
          N2:=Abs(Max(N,salcompannoatt));
          N2:=Min(N2,Max(0,salcompannoprec));
          inc(salcompannoatt,N2);
          inc(salcompannoattExt,N2);
          dec(salcompannoprec,N2);
        end;
      end;
    begin
      if vareccliqanno > 0 then
        vareccliqanno:=0;
      if vareccliqanno = 0 then
        exit;

      //Calcolo differenza negativa tra straordinario annuo precedente ed attuale
      DiffLiq:=0;
      for i:=1 to NFasceMese do
        inc(DiffLiq,tstrannom[i] - tstrannom_prec[i]);
      //Se differenza negativa (lo straordianrio è diminuito)
      //abbattimento liquidabile mensile
      //scostcomodo = eccedenze giornaliere ancora disponibili dopo la variazione
      scostcomodo:= - vareccliqanno;
      Tot:=0;
      AbbLiq:=0;
      for i:=1 to NFasceMese do
      begin
        inc(Tot,tminstrmen[i]);
        inc(AbbLiq,tstrmese[i]);
      end;
      AbbEcc:=Min(- vareccliqanno, Tot); //Abbattimento delle eccedenze
      scostcomodo:=Tot - scostcomodo;
      if scostcomodo < 0 then
        scostcomodo:=0;
      //nel liquidabile mensile preservo al massimo quanto c'è in scostcomodo (dalle fasce più alte)
      for i:=NFasceMese downto 1 do
      begin
        if scostcomodo = 0 then
        begin
          for j:=i downto 1 do
            tstrmese[j]:=0;
          Break;
        end;
        if tstrmese[i] > scostcomodo then
        begin
          tstrmese[i]:=scostcomodo;
          scostcomodo:=0;
        end
        else
          dec(scostcomodo,tstrmese[i]);
      end;
      Tot:=0;
      for i:=1 to NFasceMese do
        inc(Tot,tstrmese[i]);
      //Abbattimento liquidabile
      dec(AbbLiq,Tot);
      //Abbattimento delle eccedenze mensili sulle eccedenze da inizio anno
      scostcomodo:=AbbEcc;
      //Abbattimento ancora da effettuare sui mesi successivi
      vareccliqanno:=vareccliqanno + scostcomodo;
      for i:=1 to NFasceMese do
      begin
        if tstranno[i] > scostcomodo then
        begin
          dec(tstranno[i],scostcomodo);
          scostcomodo:=0;
        end
        else
        begin
          dec(scostcomodo,tstranno[i]);
          tstranno[i]:=0;
        end;
      end;
      //vareccliqanno:= - scostcomodo;
      //Abbattimento del liquidabile mensile sul liquidabile da inizio anno
      scostcomodo:=AbbLiq;
      TrasferisciLiquidabileCompensabile(AbbLiq);
      for i:=1 to NFasceMese do
      begin
        if tstrannom[i] > scostcomodo then
        begin
          dec(tstrannom[i],scostcomodo);
          scostcomodo:=0;
        end
        else
        begin
          dec(scostcomodo,tstrannom[i]);
          tstrannom[i]:=0;
        end;
      end;
      //Questa seconda parte considera la variazione negativa del liquidabile rispetto al mese precedente
      //come un 'assorbimento' della variazione alle eccedenze liquidabili, che quindi non devono essere più considerate
      //Usato da La Spezia
      if (AbbattimentoLiquidabile = '3') and (vareccliqanno < 0) then
      begin
        //Abbatto la variazione per liquidazione del liquidabile che è stato perso dal mese precedente
        Dec(vareccliqanno,Max(Min(DiffLiq,0),vareccliqanno));
        scostcomodo:= - vareccliqanno;
        //Abbattimento liquidabile da inizio anno
        for i:=1 to NFasceMese do
        begin
          if tstrannom[i] > scostcomodo then
          begin
            dec(tstrannom[i],scostcomodo);
            scostcomodo:=0;
          end
          else
          begin
            dec(scostcomodo,tstrannom[i]);
            tstrannom[i]:=0;
          end;
        end;
        TrasferisciLiquidabileCompensabile(-vareccliqanno - scostcomodo);
        //Abbattimento eccedenze liquidabili da inizio anno
        scostcomodo:=(-vareccliqanno - scostcomodo);
        inc(vareccliqanno,scostcomodo);
        for i:=1 to NFasceMese do
        begin
          if tstranno[i] > scostcomodo then
          begin
            dec(tstranno[i],scostcomodo);
            scostcomodo:=0;
          end
          else
          begin
            dec(scostcomodo,tstranno[i]);
            tstranno[i]:=0;
          end;
        end;
        //vareccliqanno:= - scostcomodo;
      end;
    end;
    {LaSpezia}
    procedure VariazioniEccedenzeLiquidabiliRecuperate;
    {abbattimento liquidabile da variazione alle eccedenze entro il saldo mese}
    var Tot,i,j,AbbattimentoReale:Integer;
      procedure TrasferisciLiquidabileCompensabile(N:Integer);
      begin
        inc(salcompannoatt,N);
        inc(salcompannoattExt,N);
        dec(salliqannoatt,N);
      end;
    begin
      if vareccliqanno > 0 then
        vareccliqanno:=0;
      if vareccliqanno = 0 then
        exit;
      //abbattimento liquidabile mensile
      //scostcomodo = eccedenze giornaliere ancora disponibili dopo la variazione
      scostcomodo:= - vareccliqanno;
      Tot:=0;
      AbbattimentoReale:=0;
      for i:=1 to NFasceMese do
        inc(Tot,tminstrmen[i]);
      scostcomodo:=Tot - scostcomodo;
      if scostcomodo < 0 then
        scostcomodo:=0;
      //Preservo il liquidabile fino al saldo mese
      if scostcomodo < salmeseatt then
        scostcomodo:=salmeseatt;
      //nel liquidabile mensile preservo al massimo quanto c'è in scostcomodo (dalle fasce più alte)
      for i:=NFasceMese downto 1 do
      begin
        if scostcomodo = 0 then
        begin
          for j:=i downto 1 do
          begin
            inc(AbbattimentoReale,tstrmese[j]);
            tstrmese[j]:=0;
          end;
          Break;
        end;
        if tstrmese[i] > scostcomodo then
        begin
          inc(AbbattimentoReale,tstrmese[i] - scostcomodo);
          tstrmese[i]:=scostcomodo;
          scostcomodo:=0;
        end
        else
          dec(scostcomodo,tstrmese[i]);
      end;
      //abbattimento eccedenze per liquidazione da inizio anno
      scostcomodo:=AbbattimentoReale;
      for i:=1 to NFasceMese do
      begin
        if tstrannom[i] > scostcomodo then
        begin
          TrasferisciLiquidabileCompensabile(scostcomodo);
          dec(tstranno[i],scostcomodo);
          dec(tstrannom[i],scostcomodo);
          scostcomodo:=0;
        end
        else
        begin
          TrasferisciLiquidabileCompensabile(tstrannom[i]);
          dec(scostcomodo,tstrannom[i]);
          tstranno[i]:=0;
          tstrannom[i]:=0;
        end;
      end;
      vareccliqanno:= -(- vareccliqanno - AbbattimentoReale);
    end;
    procedure CompensabileMensileInFasce;
    {Distribuzione delle ore compensabili del mese in fasce}
    var i,T:Integer;
    begin
      //Carico in tbancaore la differenza tra l'eccedenza liquidabile e l'effettivo liquidabile
      //Se la differenza è negativa (il liquidabile può accrescere per effetto dei recuperi),
      //ne viene mantenuta traccia in T per abbatterla successivamente, senza lasciare in negativo
      //tbancaore
      T:=0;
      for i:=1 to NFasceMese do
      begin
        tbancaore[i]:=tminstrmen[i] - tstrmese[i];
        if tbancaore[i] < 0 then
        begin
          inc(T,tstrmese[i] - tminstrmen[i]);
          tbancaore[i]:=0;
        end;
      end;
      //Se T > 0 significa che ci sono dei negativi da recuperare in tbancaore
      if T > 0 then
        for i:=1 to NFasceMese do
        begin
          if T = 0 then Break;
          if T > tbancaore[i] then
          begin
            dec(T,tbancaore[i]);
            tbancaore[i]:=0;
          end
          else
          begin
            dec(tbancaore[i],T);
            T:=0;
          end;
        end;
      //tbancaore viene 'limata' in modo che non possa essere superiore a FBancaOreMese
      T:=FBancaOreMese;
      FBancaOreMese:=0;
      for i:=NFasceMese downto 1 do
      begin
        if T = 0 then
          tbancaore[i]:=0
        else if T >= tbancaore[i] then
          dec(T,tbancaore[i])
        else if T < tbancaore[i] then
        begin
          tbancaore[i]:=T;
          T:=0;
        end;
        inc(FBancaOremese,tbancaore[i]);
      end;
    end;
  procedure CompensazioneDaCausaliEscluse(TipoComp:String = 'A');
  {Compensazione del negativo con le ore escluse dalle normali}
  var i,k,m,Saldo,Saldo2,Saldo3:Integer;
  begin
    if TipoComp = 'A' then
      Saldo:=Abs(Min(0,salannoatt))
    else
      Saldo:=Abs(Min(0,salmeseatt));
    with TStringList.Create do
    try
      if TipoComp = 'A' then
        CommaText:=CausaliCompensabili
      else
        CommaText:=CausaliCompensabiliMensili;
      for i:=0 to Count - 1 do
      begin
        if Saldo = 0 then
          Break;
        if VarToStr(selT275.Lookup('CODICE',Strings[i],'ORENORMALI')) <> 'A' then
          Continue;
        k:=IndiceRiepPres(Strings[i]);
        if k = -1 then
          Continue;
        //Aggiornamento dei saldi
        //Alberto 11/09/2006: Chiamata alla procedura AbbattiRiepPres
        if TipoComp = 'A' then
        begin
          Saldo2:=Saldo;
          AbbattiRiepPres(k,Saldo);
          m:=Saldo2 - Saldo;
        end
        else
        begin
          Saldo2:=Saldo;
          Saldo2:=min(Saldo2,R180SommaArray(RiepPres[k].OreReseMese) - RiepPres[k].CompensabileMeseEff);
          Saldo2:=min(Saldo2,R180SommaArray(RiepPres[k].Residuo));
          Saldo3:=Saldo2;
          AbbattiRiepPresMensile(k,Saldo3);
          m:=Saldo2 - Saldo3;
          dec(Saldo,m);
        end;
        inc(RiepPres[k].CompensabileMeseEff,m);
        inc(RiepPres[k].CompensabileAnnoEff,m);
        inc(OreEsclComp,m);
        inc(salmeseatt,m);
        inc(salmeseattnocau,m);
        inc(salannoatt,m);
        inc(salannonetto,m);
        inc(salcompannoatt,m);
      end;
    finally
      Free;
    end;
  end;
  procedure AbbattiBancaOreLiquidata;
  {Applicazione delle ore liquidate ai saldi}
  begin
    dec(salannoatt,L07.OreCompLiquidate);
    //Aggiornamento saldo compensabile anno attuale con Banca Ore liquidata nel mese
    if L07.OreCompLiquidate > 0 then
      if salcompannoatt > L07.OreCompLiquidate then
        dec(salcompannoatt,L07.OreCompLiquidate)
      else
      begin
        salliqannoatt:=salliqannoatt - (L07.OreCompLiquidate - salcompannoatt);
        salcompannoatt:=0;
        if salliqannoatt < 0 then
        begin
          inc(salcompannoatt,salliqannoatt);
          salliqannoatt:=0;
        end;
      end;
  end;
  procedure AbbattiBancaOreRecuperata(Recupero:Integer);
  {Applicazione delle ore recuperate ai saldi}
  var Q,i,app1:Integer;
  begin
    app:=Recupero;
    dec(salannoatt,app);
    dec(salannonetto,app);
    //Abbattimento compensabile anno precedente (limitata alla banca ore anno precedente)
    app1:=Min(app,Max(0,Min(salcompannoprec - Min(0,SaldoNegativoMinimo),BancaOreResiduaPrec_prec)));
    dec(l13_banca_ore_recuperata,app1);
    dec(salcompannoprec,app1);
    dec(app,app1);
    //Abbattimento compensabile anno attuale
    app1:=Min(Max(0,salcompannoatt),app);
    dec(salcompannoatt,app1);
    dec(app,app1);
    //inc(FBancaOreRecAnnoPrec,app1);
    //Abbattimento compensabile anno precedente (oltre alla banca ore anno precedente)
    app1:=Min(Max(0,salcompannoprec),app);
    dec(salcompannoprec,app1);
    dec(app,app1);
    //Abbattimento liquidabile anno precedente
    app1:=Min(Max(0,salliqannoprec),app);
    dec(salliqannoprec,app1);
    dec(app,app1);
    //Abbattimento liquidabile anno corrente (anche dal residuo liquidabile)
    app1:=Min(Max(0,salliqannoatt),app);
    dec(salliqannoatt,app1);
    dec(app,app1);
    //inc(FBancaOreRecAnnoPrec,app1);
    for i:=1 to NFasceMese do
    begin
      if app1 = 0 then Break;
      Q:=Max(0,Min(app1,tstrannom[i] - tstrliq[i]));
      dec(tstrannom[i],Q);
      dec(app1,Q);
    end;
    //Abbattimento finale sul compensabile anno attuale
    dec(salcompannoatt,app);
    //inc(FBancaOreRecAnnoPrec,app);
  end;
  procedure LiquidazioniVariazioniAnniPrecedenti;
  {Abbattimento saldi con le variazioni/liquidazioni fatte sulle ore degli anni precedenti}
  var Q,j:Integer;
      UltimoMeseServizio:Boolean;
  begin
    LiqOreAnniPrec:=0;
    VariazioneSaldo:=0;
    DataVariazSaldiPrec:=0;
    NoteVariazSaldiPrec:='';
    //Ricerca di tutti i movimenti validi dal mese corrente in poi.
    //Se il dipendente è cessato, oltre al movimento del mese corrente si considerano gli eventuali successivi
    with selT134 do
    begin
      First;
      while not Eof do
      begin
        if FieldByName('DATA').AsDateTime = EncodeDate(AnnoCorr400,MeseCorr400,1) then
        begin
          inc(LiqOreAnniPrec,FieldByName('LIQORE_ANNIPREC').AsInteger);
          inc(VariazioneSaldo,FieldByName('VARIAZIONE_SALDO').AsInteger);
          DataVariazSaldiPrec:=FieldByName('DATA').AsDateTime;
          NoteVariazSaldiPrec:=FieldByName('NOTE').AsString;
        end
        else if (FieldByName('DATA').AsDateTime > EncodeDate(AnnoCorr400,MeseCorr400,1)) then
        begin
          UltimoMeseServizio:=False;
          selT430InizioFine.First;
          while not selT430InizioFine.Eof do
          begin
            if (FieldByName('DATA').AsDateTime >= selT430InizioFine.FieldByName('INIZIO').AsDateTime) and
               (FieldByName('DATA').AsDateTime <= selT430InizioFine.FieldByName('FINE').AsDateTime) then
              //In servizio
              Break;
            if (EncodeDate(AnnoCorr400,MeseCorr400,1) < selT430InizioFine.FieldByName('INIZIO').AsDateTime) and
               (FieldByName('DATA').AsDateTime >= selT430InizioFine.FieldByName('INIZIO').AsDateTime) then
              //Successivo al periodo corrente ma da conteggiare in un periodo di servizio successivo
              Break;
            if R180InizioMese(selT430InizioFine.FieldByName('FINE').AsDateTime) = EncodeDate(AnnoCorr400,MeseCorr400,1) then
              //Il mese corrente è l'ultimo del periodo di servizio
              UltimoMeseServizio:=True;
            if UltimoMeseServizio and (FieldByName('DATA').AsDateTime < selT430InizioFine.FieldByName('INIZIO').AsDateTime) and
               (selT430InizioFine.FieldByName('INIZIO').AsDateTime > EncodeDate(AnnoCorr400,MeseCorr400,1)) then
            begin
              //Successivo al periodo corrente e da conteggiare comunque in questo mese
              inc(LiqOreAnniPrec,FieldByName('LIQORE_ANNIPREC').AsInteger);
              inc(VariazioneSaldo,FieldByName('VARIAZIONE_SALDO').AsInteger);
              DataVariazSaldiPrec:=FieldByName('DATA').AsDateTime;
              NoteVariazSaldiPrec:=FieldByName('NOTE').AsString;
              Break;
            end;
            selT430InizioFine.Next;
          end;
        end;
        Next;
      end;
    end;
    if (LiqOreAnniPrec <> 0) or (VariazioneSaldo <> 0) then
    begin
      iVariazioneSaldiAnniPrec:=LiqOreAnniPrec - VariazioneSaldo;
      salannoatt:=salannoatt - iVariazioneSaldiAnniPrec;
      if iVariazioneSaldiAnniPrec < 0 then
        salcompannoatt:=salcompannoatt - iVariazioneSaldiAnniPrec
      else
      begin
        if salcompannoprec > iVariazioneSaldiAnniPrec then
        begin
          salcompannoprec:=salcompannoprec - iVariazioneSaldiAnniPrec;
          iVariazioneSaldiAnniPrec:=0;
        end
        else
        begin
          iVariazioneSaldiAnniPrec:=iVariazioneSaldiAnniPrec - salcompannoprec;
          salcompannoprec:=0;
        end;
        if salcompannoatt > iVariazioneSaldiAnniPrec then
        begin
          salcompannoatt:=salcompannoatt - iVariazioneSaldiAnniPrec;
          iVariazioneSaldiAnniPrec:=0;
        end
        else
        begin
          iVariazioneSaldiAnniPrec:=iVariazioneSaldiAnniPrec - salcompannoatt;
          salcompannoatt:=0;
        end;
        if salliqannoprec > iVariazioneSaldiAnniPrec then
        begin
          salliqannoprec:=salliqannoprec - iVariazioneSaldiAnniPrec;
          iVariazioneSaldiAnniPrec:=0;
        end
        else
        begin
          iVariazioneSaldiAnniPrec:=iVariazioneSaldiAnniPrec - salliqannoprec;
          salliqannoprec:=0;
        end;
        if salliqannoatt > iVariazioneSaldiAnniPrec then
        begin
          salliqannoatt:=salliqannoatt - iVariazioneSaldiAnniPrec;
          VariazioneLiqAnnoAtt:=iVariazioneSaldiAnniPrec;
          iVariazioneSaldiAnniPrec:=0;
        end
        else
        begin
          iVariazioneSaldiAnniPrec:=iVariazioneSaldiAnniPrec - salliqannoatt;
          VariazioneLiqAnnoAtt:=salliqannoatt;
          salliqannoatt:=0;
        end;
        if iVariazioneSaldiAnniPrec > 0 then
          salcompannoatt:=salcompannoatt - iVariazioneSaldiAnniPrec;
        //Se la variazione dei saldi ha comportato abbattimento dello str.liq.anno att.
        //allora abbatto anche il vettore dello straord. ancora liq.
        if (VariazioneLiqAnnoAtt > 0) and (salliqannoatt > 0) then
        begin
          //Abbattimento straordinario annuale
          for j:=1 to NFasceMese do
          begin
            if VariazioneLiqAnnoAtt = 0 then Break;
            Q:=min(VariazioneLiqAnnoAtt,tstrannom[j] - tstrliq[j]);
            if Q < 0 then Continue;
            dec(tstrannom[j],Q);
            dec(VariazioneLiqAnnoAtt,Q);
          end;
        end;
      end;
    end;
  end;
  procedure AssestamentoAnnuale(Assestamento:Byte);
  {Abbattimento saldi con le variazioni/liquidazioni fatte sulle ore degli anni precedenti}
  var Ore,i,j,x,iVariazioneSaldo:Integer;
      Appoggio:array [1..MaxFasce] of LongInt;
      Serbatoi:String;
  begin
    Serbatoi:=VarToStr(selT305.Lookup('CODICE',tdatiassestamen[Assestamento].tcauassest,'ASSEST_ANNUO'));
    if Length(Serbatoi) <> 11 then
      exit;
    for i:=1 to MaxFasce do
    begin
      Appoggio[i]:=tdatiassestamen[Assestamento].tminassest[i];
      //if (UpperCase(Parametri.RagioneSociale) <> 'ISTITUTO NAZIONALE PER LA RICERCA SUL CANCRO - GENOVA') then
      if (RecuperoSerbatoi = 'G') or (RecuperoSerbatoi = 'M') then
        inc(RecuperoMensile,-Min(0,tdatiassestamen[Assestamento].tminassest[i]));
    end;
    for i:=1 to MaxFasce do
    begin
      inc(salannoatt,Appoggio[i]);
      inc(salannonetto,Appoggio[i]);
      if Appoggio[i] >= 0 then
        inc(salcompannoatt,Appoggio[i])
      else
      begin
        iVariazioneSaldo:=-Appoggio[i];
        for x:=0 to 3 do
          if Copy(Serbatoi,x*3 + 1,2) = 'CP' then
            //Abbattimento Compensabile anno prec.
            Abbatti(salcompannoprec,iVariazioneSaldo)
          else if Copy(Serbatoi,x*3 + 1,2) = 'LP' then
            //Abbattimento Liquidabile anno prec.
            Abbatti(salliqannoprec,iVariazioneSaldo)
          else if Copy(Serbatoi,x*3 + 1,2) = 'CA' then
            //Abbattimento Compensabile anno att.
            Abbatti(salcompannoatt,iVariazioneSaldo)
          else if Copy(Serbatoi,x*3 + 1,2) = 'LA' then
          begin
            //Abbattimento Liquidabile anno att. nella fascia indicata
            Ore:=Max(0,Min(iVariazioneSaldo,tstrannom[i] - tstrliq[i]));
            dec(tstrannom[i],Ore);
            dec(iVariazioneSaldo,Ore);
            dec(salliqannoatt,Ore);
            //nelle altre fasce disponibili
            if iVariazioneSaldo > 0 then
              for j:=1 to MaxFasce do
              begin
                Ore:=Max(0,Min(iVariazioneSaldo,tstrannom[j] - tstrliq[j]));
                dec(tstrannom[j],Ore);
                dec(iVariazioneSaldo,Ore);
                dec(salliqannoatt,Ore);
              end;
          end;
        //Ultimo abbattimento sul compensabile attuale (negativo)
        dec(salcompannoatt,iVariazioneSaldo);
      end;
    end;
  end;
  procedure GetResiduoRiposi;
  var ResPrec,Res:Real;
      Giustif:TGiustificativo;
      Data:TDateTime;
  begin
    if R600DtM = nil then
    begin
      if (Self.Owner <> nil) and not(Self.Owner is TOracleDataSet) then
        R600DtM:=TR600DtM1.Create(Self.Owner)
      else
        R600DtM:=TR600DtM1.Create(SessioneOracleR450);
    end;
    Giustif.Causale:=RiposoNonFruito;
    Giustif.Modo:='I';
    if VarToStr(R600DtM.Q265.Lookup('CODICE',Giustif.Causale,'UMCUMULO')) = 'A' then
    begin
      ResPrec:=0;
      (*Data:=EncodeDate(AnnoCorr400,MeseCorr400,1) - 1;
      R600DtM.GetAssenze(Progress400,Data,Data,Data,Giustif);
      ResPrec:=R600DtM.ValResiduo;*)
    end
    else
      ResPrec:=0;
    Data:=R180AddMesi(EncodeDate(AnnoCorr400,MeseCorr400,1),1) - 1;
    R600DtM.GetAssenze(Progress400,Data,Data,Data,Giustif);
    Res:=R600DtM.ValResiduo;
    RiposiNonFruitiGG:=Max(0,Res - ResPrec);
    if R600DtM.UMisura = 'O' then
      RiposiNonFruitiOre:=Trunc(RiposiNonFruitiGG)
    else
      RiposiNonFruitiOre:=Trunc(RiposiNonFruitiGG * R600DtM.ValenzaGiornaliera);
  end;
  procedure LimitiMensiliCausalizzati;
  var aStrMese,aStrAnno,aBancaOre:array [1..MaxFasce] of LongInt;
      hh1,hh2,k:LongInt;
      i,nf:Integer;
  begin
    //salvataggio liquidabile mensile/annuale e banca ore mensile
    for i:=1 to MaxFasce do
    begin
      aStrAnno[i]:=tstrannom[i];
      aStrMese[i]:=tstrmese[i];
      aBancaOre[i]:=tbancaore[i];
    end;
    with selT820 do
    begin
      if SearchRecord('ANNO;MESE;LIQUIDABILE',VarArrayOf([AnnoCorr400,MeseCorr400,'S']),[srFromBeginning]) then
      repeat
        //Considero solo le causali escluse dalle normali
        if VarToStr(selT275.Lookup('CODICE',FieldByName('CAUSALE').AsString,'ORENORMALI')) <> 'A' then
          k:=-1
        else
          k:=IndiceRiepPres(FieldByName('CAUSALE').AsString);
        if (k >= 0) and (R180OreMinutiExt(FieldByName('ORE').AsString) > 0) then
        begin
          //Abbatto la quantità indicata in RiepPres.Liquidato a partire dalle fasce più alte
          for nf:=MaxFasce downto 1 do
          begin
            hh1:=RiepPres[k].Liquidato[nf];
            if hh1 = 0 then Continue;
            for i:=nf downto 1 do
            begin
              if hh1 <= 0 then Break;
              hh2:=min(hh1,aStrMese[i]);
              if hh2 <= 0 then Continue;
              dec(hh1,hh2);
              //Abbattimento saldi
              dec(salannoatt,hh2);
              dec(salannonetto,hh2);
              dec(salliqannoatt,hh2);
              dec(salmeseatt,hh2);
              dec(salmeseattnocau,hh2);
              //Abbattimento liquidabile
              dec(aStrMese[i],hh2);
              dec(aStrAnno[i],hh2);
            end;
          end;
        end;
      until not (SearchRecord('ANNO;MESE',VarArrayOf([AnnoCorr400,MeseCorr400]),[]));
    end;
    for i:=1 to MaxFasce do
    begin
      tstrannom[i]:=aStrAnno[i];
      tstrmese[i]:=aStrMese[i];
    end;
  end;
  procedure AbbattimentoEG_Riposi(TotAbb:Integer; TroncaOre:Boolean; BancaOre:Boolean);
  var i,app,app1:Integer;
  begin
    //le restanti ore si perdono, abbattono strliqggmese, tminstrmen, diffsalserb, salannoatt, salmeseatt, salmeseattnocau
    dec(strliqggmese,TotAbb);
    dec(diffsalserb,TotAbb);
    dec(salannoatt,TotAbb);
    dec(salannonetto,TotAbb);
    dec(salmeseatt,TotAbb);
    dec(salmeseattnocau,TotAbb);
    if TroncaOre then
      inc(FOreTroncate,TotAbb);
    //Abbattimento dei serbatoi se il saldo è diminuito rispetto al precedente
    if diffsalserb < 0 then
    begin
      app:=Min(TotAbb,Abs(diffsalserb));
      app1:=Min(app,Max(0,salcompannoatt));
      dec(salcompannoatt,app1);
      dec(app,app1);
      app1:=Min(app,Max(0,salliqannoatt));
      dec(salliqannoatt,app1);
      dec(app,app1);
      app1:=Min(app,Max(0,salcompannoprec));
      dec(salcompannoprec,app1);
      dec(app,app1);
      app1:=Min(app,Max(0,salliqannoprec));
      dec(salliqannoprec,app1);
      dec(app,app1);
      //La rimanenza fa andare in negativo il compensabile anno attuale
      if app > 0 then
        dec(salcompannoatt,app);
    end;
    for i:=1 to NFasceMese do
    begin
      if TotAbb = 0 then
        Break;
      app:=min(tminstrmen[i],TotAbb);
      dec(tminstrmen[i],app);
      dec(TotAbb,app);
    end;
    if BancaOre then
    begin
      //la banca ore è alimentata da strliqggmese che non fa parte del liquidabile, considerando i limiti di liquidazione:
      StrEsternoApp:=StrAutMen + StrEsterno + OreCausLiqSenzaLimiti;
      FBancaOreMese:=Max(0,strliqggmese - Min(Max(0,diffsalserb),StrEsternoApp));
    end;
  end;
  procedure GestioneBancaOreMeseNegativa;
  var AssTot,BOR,i,xx,app1,SM:Integer;
  begin
    //Considero il sado mese al lordo della liquidazione
    SM:=salmeseatt;
    if LiquidazioneDistribuita = 'S' then
      inc(salmeseatt,totliqmm);
    //Se il saldo mese è positivo non faccio nulla
    if SM >= 0 then
      exit;

    for i:=1 to 2 do
      //Considero le causali che non sono ad assest.annuo e che consentono la banca ore negativa
      if (tdatiassestamen[i].tcauassest <> '') and
         //(VarToStr(selT305.Lookup('CODICE',tdatiassestamen[i].tcauassest,'BANCAORE_NEGATIVA')) = 'T')) then
         (VarToStr(selT305.Lookup('CODICE',tdatiassestamen[i].tcauassest,'BANCAORE_NEGATIVA')) = 'S') and
         (Trim(VarToStr(selT305.Lookup('CODICE',tdatiassestamen[i].tcauassest,'ASSEST_ANNUO'))) = '') then
      begin
        //Considero la quantità negativa dovuta alla causale di assestamento
        if i = 1 then
          AssTot:=GetAssestamento1Totale
        else
          AssTot:=GetAssestamento2Totale;
        //Considero la banca ore maturata nell'anno corrente
        BOR:=Min(FBancaOreAnno,-SM);
        if AssTot < 0 then
        begin
          AssTot:=max(0,min(-AssTot,BOR));
          dec(FBancaOreMese,AssTot);
          dec(FBancaOreAnno,AssTot);
          for xx:=1 to NFasceMese do
            if tdatiassestamen[i].tminassest[xx] < 0 then
            begin
              app1:=min(-tdatiassestamen[i].tminassest[xx],AssTot);
              dec(AssTot,app1);
              dec(tbancaore[xx],app1);
            end;
        end;
      end;
  end;
begin
  //Salvataggio saldi precedenti in RiepilogoPrecedente
  SalvaRiepilogoPrecedente;
  //Salvataggio causali abbattimento anno precedente ed attuale
  (*01/09/2000 utilizzo delle variabili abbliqannoprecmescom e abbliqannoattmescom*)
  (*Abbattono:
      RecuperoMensile (se Recupero serbatoi = 'G')
      salmeseattnocau (se Recupero serbatoi = 'L')
      scostnegmescom
      salannoatt
      salannonetto
  *)
  abbannoprecmescom:=abbannoprecmes;
  abbannoattmescom:=abbannoattmes;
  abbliqannoprecmescom:=abbliqannoprecmes;
  abbliqannoattmescom:=abbliqannoattmes;
  //Alberto 28/12/2007: Abbattimento residuo della causale di presenza usata per riepilogare i riposi compensativi
  if (Trim(CausRipComFasce) <> '') then
  begin
    app:=abbripcommes;
    //Verifico che il riepilogo non sia già abbattuto dalle causali di tipo Riposo Compensativo con tipo cumulo S
    for i:=0 to lstPresenzeCumuloS.Count - 1 do
    begin
      if (CausRipComFasce = lstPresenzeCumuloS[i]) then
      begin
        if selT265.GetVariable('CODICE') <> lstAssenzeCumuloS[i] then
        begin
          selT265.Close;
          selT265.SetVariable('CODICE',lstAssenzeCumuloS[i]);
        end;
        selT265.Open;
        if selT265.FieldByName('CODINTERNO').AsString = 'E' then
          app:=0;
      end;
    end;
    if app > 0 then
      for i:=0 to High(RiepPres) do
        if CausRipComFasce = RiepPres[i].Causale then
        begin
          inc(RiepPres[i].RecuperoAnno,app);
          inc(RiepPres[i].RecuperoMese,app);
          AbbattiRiepPres(i,app);
          Break;
        end;
  end;
  //Saldo riposi compensativi del mese
  salripcommes:=ripcommes - abbripcommes - RipComLiqMes;
  //Saldo riposi compensativi fine mese precedente
  salripcomfmprec:=salripcom_prec;
  //Saldo riposi compensativi dell'anno
  salripcom:=salripcomfmprec + salripcommes;
  //Lavorato mensile al netto dei riposi compensativi
  //da turnazione maturati
  totoreresnorip:=totoreres - ripcommes;
  //Saldo mese attuale al netto dei riposi compensativi
  //da turnazione maturati ed al lordo del mensile liquidato
  salmeseatt:=totoreresnorip - debtotmes;
  //Alberto 10/08/2000: includo le ore escluse dalle normali indicate come compensabili
  salmeseatt:=salmeseatt + OreEsclComp;
  //Saldo mese attuale al netto causali che abbattono serbatoi
  salmeseattnocau:=salmeseatt - abbannoprecmescom - abbannoattmescom - abbliqannoprecmescom - abbliqannoattmescom;
  //Totalizzazione annuale delle ore causalizzate esterne liquidate incluse nel budget di straordinario
  inc(LiqAnnoCauEstIncBud,OreCausLiqEsterneInBudget);
  inc(ResoAnnoCauEstIncBO,OreCausReseEsterneInBO);
  //Totale straordinario liq. del mese derivato dal giornaliero
  strliqggmese:=0;
  for i:=1 to NFasceMese + 1 do
  begin
    strliqggmese:=strliqggmese + tminstrmen[i];
    tstranno[i]:=tstranno_prec[i] + tminstrmen[i];
  end;
  //Alberto: Biella_Asl12 - abbattimento eccedenza giornaliera con causali di giustificazione per libera professione (ALP)
  if (tdatiassestamen[1].tcauassest <> '') and (Trim(VarToStr(selT305.Lookup('CODICE',tdatiassestamen[1].tcauassest,'ABBATTE_ECC_GIORN'))) = 'S') then
    for i:=1 to NFasceMese + 1 do
      dec(strliqggmese,min(strliqggmese,-min(0,tdatiassestamen[1].tminassest[i])));
  if (tdatiassestamen[2].tcauassest <> '') and (Trim(VarToStr(selT305.Lookup('CODICE',tdatiassestamen[2].tcauassest,'ABBATTE_ECC_GIORN'))) = 'S') then
    for i:=1 to NFasceMese + 1 do
      dec(strliqggmese,min(strliqggmese,-min(0,tdatiassestamen[2].tminassest[i])));
  //Alberto 18/11/2005 Gestione del SaldoNegativoMinimo per il Comune di Genova
  if SaldoNegativoMinimoTipo = '2' then //COMUNEDIGENOVA
  begin
    if Pos('<>',DescT025) > 0 then
      //SaldoNegativoMinimo:=min(0,salmeseatt - strliqggmese + salcompannoatt_prec + salcompannoprec_prec - BancaOreResidua_prec - BancaOreResiduaPrec_prec)
      SaldoNegativoMinimo:=min(0,salmeseattnocau - strliqggmese + salcompannoatt_prec + salcompannoprec_prec - GetBOInclusaSaldi(BancaOreResidua_prec) - GetBOInclusaSaldi(BancaOreResiduaPrec_prec))
    else
      //-> per Aipo_Parma dovrebbe essere così, va bene anche per Genova???? Se no, mettere '<>' nella descrizione in modo che utilizzi la valorizzazione sopra
      //SaldoNegativoMinimo:=min(0,salmeseatt - strliqggmese + salcompannoatt_prec + salcompannoprec_prec - Max(0,BancaOreResidua_prec + BancaOreResiduaPrec_prec)(* + OreCompRecuperate*));
      SaldoNegativoMinimo:=min(0,salmeseattnocau - strliqggmese + salcompannoatt_prec + salcompannoprec_prec - Max(0,GetBOInclusaSaldi(BancaOreResidua_prec) + GetBOInclusaSaldi(BancaOreResiduaPrec_prec))(* + OreCompRecuperate*));
    if SaldoNegativoMinimo < 0 then
    begin
      inc(totoreres, -SaldoNegativoMinimo);
      inc(totoreresnorip, -SaldoNegativoMinimo);
      inc(salmeseatt, -SaldoNegativoMinimo);
      inc(salmeseattnocau, -SaldoNegativoMinimo);
    end;
  end;
  //Limite dell'eccedenza residuabile mensile in base al limite annuale e alla banca ore effettuata da inizio anno
  app:=EccAutAnno['RESIDUABILE'];
  EccResAutMenVariato:=EccResAutMen;
  if FBancaOreAnno + EccResAutMenVariato > app then
    EccResAutMenVariato:=Max(0,EccResAutMenVariato - (FBancaOreAnno + EccResAutMenVariato - app));
  //Scostamento negativo
  scostnegmescom:=0;
  if RecuperoSerbatoi = 'G' then
    //negativi giornalieri
    scostnegmescom:=scostnegmes
  else if RecuperoSerbatoi = 'M' then
    //negativo mensile
    scostnegmescom:=Min(0,salmeseatt)
  else if RecuperoSerbatoi = 'L' then
    //liquidabile mensile (Martini)
    //scostnegmescom:=Min(0,salmeseattnocau - (strliqggmese)); // + vareccliqanno);  //Alberto 25/05/2001
    scostnegmescom:=Min(0,salmeseatt - strliqggmese);  //Alberto 14/02/2005 - Le ore recuperate da causale vengono già messe nel liquidabile!
  if (RiposoNonFruito <> '') and (RiposoRecupLiquid = 'S') and (High(RiepilogoMese) >= 0) then
    if RiepilogoMese[High(RiepilogoMese)].Data = R180AddMesi(EncodeDate(AnnoCorr400,MeseCorr400,1),-1) then
      dec(scostnegmescom,RiepilogoMese[High(RiepilogoMese)].RiposiNonFruitiOre);
  RecuperoMensile:=0;
  if (RecuperoSerbatoi = 'G') or (RecuperoSerbatoi = 'M') then
    RecuperoMensile:= - scostnegmescom + (abbannoprecmescom + abbliqannoprecmescom + abbannoattmescom + abbliqannoattmescom)
  else if (RecuperoSerbatoi = 'L') and (SaldoMobile_Riferimento = '2') then  //COMUNEDIGENOVA
    RecuperoMensile:= - scostnegmes + (abbannoprecmescom + abbliqannoprecmescom + abbannoattmescom + abbliqannoattmescom);
  //Se tutti i serbatoi sono esclusi non considero lo scostamento negativo
  if (Serbatoi[1] = '') and (Serbatoi[2] = '') and (Serbatoi[3] = '') and (Serbatoi[4] = '') then
    scostnegmescom:=0;
  (*Genova S.Martino / Carrara*)
  if (TipoLimiteCompA = 'C') then
  begin
    if TipoLimiteCompNoRec = 'S' then
      app2:=salmeseatt
    else
      app2:=salmeseattnocau;
    if app2 > strliqggmese then
    begin
      //Calcolo la parte di eccsolocompmes utilizzata dal liquidabile (liqid.gg > scost.gg) che è quindi da NON abbattere
      app1:=Max(0,strliqggmese + eccsolocompmes + scostnegmes - app2);
      //tolgo dal eccsolocompmes le quantità da mantenere (app1, EccSoloCompMesOltreSoglia, scostnegmes, LimiteCompA)
      app:=Min(Max(0,eccsolocompmes - app1 - EccSoloCompMesOltreSoglia - Max(0,LimiteCompA) + scostnegmes),Max(0,app2 - strliqggmese));
      dec(salmeseatt,app);
      dec(salmeseattnocau,app);
      inc(FOreTroncate,app);
    end;
  end;
  //S.Paolo: l'eccedenza non liquidabile del mese viene persa
  if (TipoLimiteCompA = 'M') then
  begin
    if TipoLimiteCompNoRec = 'S' then
      app2:=salmeseatt
    else
      app2:=salmeseattnocau;
    if app2 > strliqggmese then
    begin
      dec(salmeseatt,app2 - strliqggmese);
      dec(salmeseattnocau,app2 - strliqggmese);
      inc(FOreTroncate,app2 - strliqggmese);
    end;
  end;
  //Saldo fine mese precedente
  salfmprec:=salannoatt_prec;
  //Saldo fine mese precedente
  salfmprecnetto:=salannonetto_prec;
  (*Alberto: Gestione troncatura dei saldi positivi periodica (Pinerolo)
   Abilitata solo se è specificata una periodicità e il mese non è Gennaio*)
  if (PeriodicitaAbbattimento = 'F') and (MesiSaldoPrec > 0) and (MeseCorr400 > 1) then
    if (MesiSaldoPrec = 1) or (MeseCorr400 mod MesiSaldoPrec = 1) then
      TroncaturaPeriodica;
  //Melegnano
  if GetAbbattimentoSaldi(MeseRif,MeseAbb) then
    AbbattimentoSaldiNonRecuperati;
  //Saldo anno attuale
  salannoatt:=salfmprec + salmeseattnocau;
  //Saldo anno netto
  salannonetto:=salannonetto_prec + salmeseattnocau;
  for i:=1 to NFasceMese + 1 do
    dec(salannonetto,tLiqNelMese[i]);
  (*Alberto: gestione del recupero anno attuale
    in mancanza di disponibilità dai 2 serbatoi dell'anno attuale*)
  (*01/09/2000 serbatoi differenziati tra compensabile e liquidabile*)
  if (abbannoattmescom  + abbliqannoattmescom) > (salcompannoatt_prec + salliqannoatt_prec) then
  begin
    i:=(abbannoattmescom  + abbliqannoattmescom) - (salcompannoatt_prec + salliqannoatt_prec);
    dec(abbliqannoattmescom,i);
    if abbliqannoattmescom < 0 then
    begin
      inc(abbannoattmescom,abbliqannoattmescom);
      abbliqannoattmescom:=0;
      if abbannoattmescom < 0 then
        abbannoattmescom:=0;
    end;
  end;
  //Abbattimento dei 4 serbatoi da ore di recupero causalizzate
  salcompannoprec:=salcompannoprec_prec;
  salliqannoprec:=salliqannoprec_prec;
  salcompannoatt:=salcompannoatt_prec;
  salliqannoatt:=salliqannoatt_prec;
  DiffRecupTot:=0;
  //Recupero da anno precedente Compensabile/Liquidabile
  y421_AbbattiSerbatoio('CP',ArrotondaCP,abbannoprecmescom,salcompannoprec,abbannopreceff,DiffRecup);
  inc(DiffRecupTot,DiffRecup);
  y421_AbbattiSerbatoio('LP',ArrotondaLP,abbannoprecmescom,salliqannoprec,abbannopreceff,DiffRecup);
  inc(DiffRecupTot,DiffRecup);
  y421_AbbattiSerbatoio('CA',ArrotondaCA,abbannoprecmescom,salcompannoatt,abbannoatteff,DiffRecup);
  inc(DiffRecupTot,DiffRecup);
  y421_AbbattiSerbatoio('LA',ArrotondaLA,abbannoprecmescom,salliqannoatt,abbannoatteff,DiffRecup);
  inc(DiffRecupTot,DiffRecup);
  //Recupero da anno precedente Liquidabile/Compensabile (Belluno)
  y421_AbbattiSerbatoio('LP',ArrotondaLP,abbliqannoprecmescom,salliqannoprec,abbannopreceff,DiffRecup);
  inc(DiffRecupTot,DiffRecup);
  y421_AbbattiSerbatoio('LA',ArrotondaLA,abbliqannoprecmescom,salliqannoatt,abbannoatteff,DiffRecup);
  inc(DiffRecupTot,DiffRecup);
  y421_AbbattiSerbatoio('CP',ArrotondaCP,abbliqannoprecmescom,salcompannoprec,abbannopreceff,DiffRecup);
  inc(DiffRecupTot,DiffRecup);
  y421_AbbattiSerbatoio('CA',ArrotondaCA,abbliqannoprecmescom,salcompannoatt,abbannoatteff,DiffRecup);
  inc(DiffRecupTot,DiffRecup);
  //Recupero da anno corrente Compensabile/Liquidabile
  y421_AbbattiSerbatoio('CA',ArrotondaCA,abbannoattmescom,salcompannoatt,abbannoatteff,DiffRecup);
  inc(DiffRecupTot,DiffRecup);
  y421_AbbattiSerbatoio('LA',ArrotondaLA,abbannoattmescom,salliqannoatt,abbannoatteff,DiffRecup);
  inc(DiffRecupTot,DiffRecup);
  //Recupero da anno precedente Liquidabile/Compensabile
  y421_AbbattiSerbatoio('LA',ArrotondaLA,abbliqannoattmescom,salliqannoatt,abbannoatteff,DiffRecup);
  inc(DiffRecupTot,DiffRecup);
  y421_AbbattiSerbatoio('CA',ArrotondaCA,abbliqannoattmescom,salcompannoatt,abbannoatteff,DiffRecup);
  inc(DiffRecupTot,DiffRecup);
  abbannopreceffComodo:=abbannopreceff;
  //Allineamento dei dati interessati dai recuperi con causale alle variazioni dovute all'arrotondamento in fase di abbattimento
  if RecuperoSerbatoi = 'G' then
    inc(RecuperoMensile,DiffRecupTot)
  else if RecuperoSerbatoi = 'L' then
    dec(scostnegmescom,DiffRecupTot);
  dec(salmeseattnocau,DiffRecupTot);
  dec(salannoatt,DiffRecupTot);
  dec(salannonetto,DiffRecupTot);
  //Riporto sugli scostamenti negativi gli abbattimenti che non è stato possibile recuperare dai serbatoi
  if RecuperoSerbatoi = 'G' then
    dec(scostnegmescom,abbannoprecmescom + abbliqannoprecmescom + abbannoattmescom + abbliqannoattmescom);
  //Abbattimento dei 4 serbatoi dagli scostamenti negativi (G) oppure dal saldo mensile negativo (M)
  sottrserbcomodo:= - scostnegmescom;
  y420_sottrserb;
  //Alberto 25/02/2008: Gestione Debito Aggiuntivo ripartito sull'anno (Collegno/Pinerolo)
  if DebAggRappAnno = 'S' then
  begin
    if DebAggConsidOrePrec = 'N' then
      totore:=salmeseatt - max(0,abbannopreceffComodo)//(abbannoprecmes - abbannoprecmescom)
    else
    begin
      totore:=salmeseatt;
      if MeseCorr400 = 1 then
        inc(totore,salcompannoprec + salliqannoprec);
    end;
    //Se le ore ai fini del deb.agg. sono positive, verifico di non utilizzare più del saldo complessivo
    //per consentire il recupero di eventuali negativi dell'anno preccedente
    if totore > 0 then
      totore:=max(0,min(totore,salannoatt))
    else if totore < 0 then //Alberto 14/10/2008: il negativo va prima a recuperarsi sull'eventuale residuo totale.
      //totore:=totore + min(-totore,max(0,salcompannoprec + salliqannoprec));
      totore:=totore + min(-totore,max(0,salannoatt - totore));
    dec(totore,totliqmm);
    //debpoannores: Debito aggiuntivo residuo da inizio anno
    //debpoeff:     Ore rese nel mese ai fini del debito aggiuntivo
    debpoeff:=max(min(totore,debpoannores),debpoannores - debpoanno);
    dec(debpoannores,debpoeff);
    inc(debtotmes,max(0,debpoeff));
    dec(salmeseatt,debpoeff);
    dec(salmeseattnocau,debpoeff);
    dec(salannoatt,debpoeff);
    dec(salannonetto,debpoeff);
  end;
  //Calcolo differenza tra saldo anno attuale ed i quattro serbatoi
  diffsalserb:=salannoatt - salcompannoprec - salliqannoprec - salcompannoatt - salliqannoatt;
  if diffsalserb < 0 then
    //Sottrazione eventuali negativi dai quattro serbatoi
    begin
    sottrserbcomodo:= - diffsalserb;
    y420_sottrserb;
    dec(salcompannoatt,sottrserbcomodo);
    //Distribuisco l'eventuale compensabile negativo sul liquidabile, se disponibile
    //Si può verificare il caso quando escludo tutti i 4 serbatoi dalla
    //compensazione dei saldi negativi
    if (salcompannoatt < 0) and (salliqannoatt > 0) then
      if salliqannoatt > abs(salcompannoatt) then
        begin
        inc(salliqannoatt,salcompannoatt);
        salcompannoatt:=0;
        end
      else
        begin
        inc(salcompannoatt,salliqannoatt);
        salliqannoatt:=0;
        end;
    end;
  //OreRecuperate dai mesi precedenti e utilizzate negli abbattimenti a periodi mobili (RecuperoSerbatoi = M/G???)
  if (SaldoMobile_Riferimento = '1') or (SaldoMobile_Riferimento = '2') then
    OreRecuperate:=-Min(salmeseattnocau,0) //ROMA_ASLC
  else
    OreRecuperate:=abbannoatteff + abbannopreceff;
  //Recupero straordinario liquidabile fino al mese precedente
  for i:=1 to NFasceMese + 1 do
    tstrannom[i]:=tstrannom_prec[i];
  //Eventuale abbattimento straordinario liquidabile anno precedente
  if salliqannoprec_prec > salliqannoprec then
    begin
    scostcomodo:=salliqannoprec_prec - salliqannoprec;
    for i:=1 to NFasceMese + 1 do
      begin
      if scostcomodo = 0 then Break;
      if tstrannoprecm[i] > scostcomodo then
        begin
        dec(tstrannoprecm[i],scostcomodo);
        dec(tstrannom[i],scostcomodo);
        scostcomodo:=0;
        end
      else
        begin
        dec(scostcomodo,tstrannoprecm[i]);
        dec(tstrannom[i],tstrannoprecm[i]);
        tstrannoprecm[i]:=0;
        end;
      end;
    end;
  //Eventuale abbattimento straordinario liquidabile anno attuale
  if salliqannoatt_prec > salliqannoatt then
    begin
    scostcomodo:=salliqannoatt_prec - salliqannoatt;
    for i:=1 to NFasceMese + 1 do
      begin
      if scostcomodo = 0 then Break;
      if tstrannom[i] > tstrliq_prec[i] then
        diffcomodo:=tstrannom[i] - tstrliq_prec[i]
      else
        diffcomodo:=0;
      if diffcomodo > scostcomodo then
        begin
        dec(tstrannom[i],scostcomodo);
        scostcomodo:=0;
        end
      else
        begin
        dec(tstrannom[i],diffcomodo);
        dec(scostcomodo,diffcomodo);
        end;
      end;
    dec(tstrannom[1],scostcomodo);
    end;

  //20/05/2003 Regione Piemonte
  //Trasformazione del compensabile in liquidabile tramite il parametro SOGLIA_COMP_LIQ
  app:=salcompannoprec + salcompannoatt -
       (RiepilogoPrecedente.BancaOreResiduaPrec + RiepilogoPrecedente.BancaOreResidua) +
       max(0,diffsalserb - strliqggmese + min(0,SaldoNegativoMinimo));
  //Alberto: 11/05/2010 - diffsalserb non può essere negativo
  if (SogliaCompLiq >= 0) and (app > SogliaCompLiq) and (diffsalserb >= 0) then
  begin
    app1:=Max(0,Min(app - SogliaCompLiq,salcompannoatt - RiepilogoPrecedente.BancaOreResidua + max(0,diffsalserb - strliqggmese)));
    app:=Trunc(R180Arrotonda(app1,ArrSogliaCompLiq,'D'));
    app2:=Min(app1 - app,diffsalserb); //Alberto: 11/05/2010 - diffsalserb non può essere negativo
    dec(diffsalserb,app2);
    dec(salannoatt,app2);
    inc(tminstrmen[1],app);
    inc(strliqggmese,app);
    dec(salcompannoatt,Max(0,strliqggmese - diffsalserb));
    inc(diffsalserb,Max(0,strliqggmese - diffsalserb));
  end;

  //ROMA_HSCAMILLO
  if RiposoNonFruito <> '' then
  begin
    if ((AnnoCorr400 = anno400) and (MeseCorr400 = mese400) and (Caller = 'Cartolina')) or (L07.RiposiNonFruitiOre = '') then
      GetResiduoRiposi
    else
    begin
      if not selT011.Active then
        selT011.Open;
      if selT011.SearchRecord('DATA',EncodeDate(AnnoCorr400,MeseCorr400,1),[srFromBeginning]) then
      begin
        if selT011.FieldByName('VALENZA_GIORNALIERA').AsInteger > 0 then
          RiposiNonFruitiGG:=RiposiNonFruitiOre / selT011.FieldByName('VALENZA_GIORNALIERA').AsInteger
        else
          RiposiNonFruitiGG:=0;
      end;
    end;
    MaxLiquidabile_RiposiNonFruiti:=Max(0,diffsalserb - RiposiNonFruitiOre);//Max(0,salmeseattnocau - RiposiNonFruitiOre);
    //Alberto 29/09/2007: Rieti
    if RiposoRecupLiquid = 'R' then
    begin
      scostcomodo:=RiposiNonFruitiOre;
      inc(salripcommes,scostcomodo);
      inc(salripcom,scostcomodo);
      AbbattimentoEG_Riposi(scostcomodo,False,False);
    end;
  end;

  if TroncaEccedenze = 'EG' then
  begin
    //15/05/2003 Nuovo limite sul liquidabile (Molinette)
    (*strliqggmese = totale eccedenze giornaliere
      tminstrmen = eccedenze giornaliere in fasce
      diffsalserb = scostamento dalla situazione del mese precedente

      strliqggmese al massimo può essere StrAutMen + EccResAutMenVariato + StrEsterno + OreCausLiqSenzaLimiti
      le restanti ore si perdono, abbattono strliqggmese, tminstrmen, diffsalserb, salannoatt, salmeseatt, salmeseattnocau
        (salliqannoatt e salcompannoatt vengono aggiornati solo se diffsalserb < 0)

      la banca ore è alimentata da tminstrmen che non è finito sul liquidabile (StrAutMen):
        quindi: strliqggmese - diffsalserb
    *)
    //strliqggmese al massimo può essere StrAutMen + EccResAutMenVariato + StrEsterno + OreCausLiqSenzaLimiti
    scostcomodo:=Min(strliqggmese,StrAutMen + EccResAutMenVariato + StrEsterno + OreCausLiqSenzaLimiti);
    scostcomodo:=strliqggmese - scostcomodo;
    AbbattimentoEG_Riposi(scostcomodo, True, True);
  end;
  (*if (TroncaEccedenze = 'EG') or ((RiposoNonFruito <> '') and (RiposoEsclusoSaldi = 'S')) then
  begin
    //le restanti ore si perdono, abbattono strliqggmese, tminstrmen, diffsalserb, salannoatt, salmeseatt, salmeseattnocau
    dec(strliqggmese,scostcomodo);
    dec(diffsalserb,scostcomodo);
    dec(salannoatt,scostcomodo);
    dec(salannonetto,scostcomodo);
    dec(salmeseatt,scostcomodo);
    dec(salmeseattnocau,scostcomodo);
    if TroncaEccedenze = 'EG' then
      inc(FOreTroncate,scostcomodo);
    //Abbattimento dei serbatoi se il saldo è diminuito rispetto al precedente
    if diffsalserb < 0 then
    begin
      app:=Min(scostcomodo,Abs(diffsalserb));
      app1:=Min(app,Max(0,salcompannoatt));
      dec(salcompannoatt,app1);
      dec(app,app1);
      app1:=Min(app,Max(0,salliqannoatt));
      dec(salliqannoatt,app1);
      dec(app,app1);
      app1:=Min(app,Max(0,salcompannoprec));
      dec(salcompannoprec,app1);
      dec(app,app1);
      app1:=Min(app,Max(0,salliqannoprec));
      dec(salliqannoprec,app1);
      dec(app,app1);
      //La rimanenza fa andare in negativo il compensabile anno attuale
      if app > 0 then
        dec(salcompannoatt,app);
    end;
    for i:=1 to NFasceMese do
    begin
      if scostcomodo = 0 then
        Break;
      app:=min(tminstrmen[i],scostcomodo);
      dec(tminstrmen[i],app);
      dec(scostcomodo,app);
    end;
    //la banca ore è alimentata da strliqggmese che non fa parte del liquidabile, considerando i limiti di liquidazione:
    StrEsternoApp:=StrAutMen + StrEsterno + OreCausLiqSenzaLimiti;
    FBancaOreMese:=Max(0,strliqggmese - Min(Max(0,diffsalserb),StrEsternoApp));
  end;*)
  LiquidabilePrecedente:=0;
  if diffsalserb > 0 then
  //Aggiornamento due serbatoi con straordinario liquidabile e compensabile maturato nel mese
  begin
    if strliqggmese > diffsalserb then
      scostcomodo:=diffsalserb
    else
    begin
      scostcomodo:=strliqggmese;
      inc(salcompannoatt,diffsalserb - strliqggmese);
      LiquidabilePrecedente:=diffsalserb - strliqggmese;
    end;
    if (RiposoNonFruito <> '') and (scostcomodo > MaxLiquidabile_RiposiNonFruiti) then
    begin
      inc(salcompannoatt,scostcomodo - MaxLiquidabile_RiposiNonFruiti);
      scostcomodo:=MaxLiquidabile_RiposiNonFruiti;
    end;

    LiquidabileMensileSenzaLimiti:=scostcomodo;
    liquidabmese:=scostcomodo;
    //Esclusione dai limiti mensili dello Straordinario Esterno e delle Ore Causalizzate escluse dai limiti
    StrEsternoApp:=StrEsterno + OreCausLiqSenzaLimiti;
    if scostcomodo > StrAutMen + StrEsternoApp then
    begin
      dec(liquidabmese,StrAutMen + StrEsternoApp);
      if (TroncaEccedenze = 'LM') or (TroncaEccedenze = 'EG') then
      begin
        inc(salcompannoatt,scostcomodo - (StrAutMen + StrEsternoApp));
        scostcomodo:=StrAutMen + StrEsternoApp;
      end;
    end
    else
      liquidabmese:=0;
    //Limite sul liquidabile annuo
    if LimiteLiquidabileAnnuo = 'S' then
    begin
      StrEsternoApp:=StrEsterno + OreCausLiqSenzaLimiti;
      if StrFattoAnno + scostcomodo > EccAutAnno['LIQUIDABILE'] + EccAutAnno['CAUSALIZZATO'] + StrEsternoApp then
      begin
        app:=scostcomodo - Max(0,EccAutAnno['LIQUIDABILE'] + EccAutAnno['CAUSALIZZATO'] + StrEsternoApp - StrFattoAnno);
        inc(salcompannoatt,app);
        dec(scostcomodo,app);
        //liquidabmese:=Max(0,liquidabmese - app);
        inc(liquidabmese,app);
        if TroncaEccedenze = 'EG' then
          inc(FBancaOreMese,app);
      end;
    end;
    inc(salliqannoatt,scostcomodo);
    //Straordinario liquidabile fatto nel mese suddiviso in fasce
    for xx:=Low(tstrmese) to High(tstrmese) do tstrmese[xx]:=0;
    for i:=NFasceMese + 1 downto 1 do
    begin
      if scostcomodo = 0 then Break;
      if tminstrmen[i] > scostcomodo then
      begin
        inc(tstrannom[i],scostcomodo);
        inc(tstrmese[i],scostcomodo);
        scostcomodo:=0;
      end
      else
      begin
        inc(tstrannom[i],tminstrmen[i]);
        inc(tstrmese[i],tminstrmen[i]);
        dec(scostcomodo,tminstrmen[i]);
      end;
    end;
  end;
  //!!!!VERIFICARE LA BANCA ORE!!!!
  if (RecupStraordPrec = 'S') and (LiquidabilePrecedente > 0) then
  begin
    app:=R180SommaArray(tstranno);
    app1:=R180SommaArray(tstrannom);
    if app > app1 then
    begin
      LiquidabilePrecedente:=Min(LiquidabilePrecedente,app - app1);
      LiquidabilePrecedente:=Min(LiquidabilePrecedente,Max(0,salcompannoatt));
      for i:=NFasceMese + 1 downto 1 do
      begin
        app:=Min(LiquidabilePrecedente,Max(0,tstranno[i] - tstrannom[i]));
        dec(LiquidabilePrecedente,app);
        inc(tstrannom[i],app);
        inc(salliqannoatt,app);
        dec(salcompannoatt,app);
      end;
    end;
  end;
  //Azzeramento ancora liquidabile negativo, se possibile
  scostcomodo:=0;
  for i:=NFasceMese + 1 downto 1 do
    begin
    if tstrliq[i] > tstrannom[i] then
      begin
      scostcomodo:=tstrliq[i] - tstrannom[i];
      for j:=1 to NFasceMese + 1 do
        begin
        if scostcomodo = 0 then Break;
        if tstrliq[j] < tstrannom[j] then
          begin
          diffcomodo:=tstrannom[j] - tstrliq[j];
          if diffcomodo > scostcomodo then
            begin
            dec(tstrannom[j],scostcomodo);
            inc(tstrannom[i],scostcomodo);
            scostcomodo:=0;
            end
          else
            begin
            dec(tstrannom[j],diffcomodo);
            inc(tstrannom[i],diffcomodo);
            dec(scostcomodo,diffcomodo);
            end;
          end;
        end;
      (*Alberto 29/10/1999: se è stato liquidato più della disponibilità,
        carico tstrannom in modo da non ottenere negativi*)
      inc(tstrannom[i],scostcomodo);
      end;
    end;

  //Variazione alle eccedenze per liquidazione
  if (AbbattimentoLiquidabile = '1') or (AbbattimentoLiquidabile = '3') then
    VariazioniEccedenzeLiquidabili
  else if AbbattimentoLiquidabile = '2' then
    VariazioniEccedenzeLiquidabiliRecuperate;
  //Aggiornamento saldi con il liquidato del mese
  //Alberto 5/9/2000: il liquidato non influenza il debito mensile
  if LiquidazioneDistribuita = 'S' then
  begin
    dec(salmeseatt,totliqmm);
    dec(salmeseattnocau,totliqmm);
  end;
  dec(salannoatt,totliqmm);
  dec(salannoatt,totcausliqmm);
  //Aggiornamento saldo liquidabile anno attuale
  //con il liquidato del mese
  if salliqannoatt > (totliqmm + totcausliqmm) then
    dec(salliqannoatt,totliqmm + totcausliqmm)
  else
  begin
    salcompannoatt:=salcompannoatt - (totliqmm + totcausliqmm - salliqannoatt);
    salliqannoatt:=0;
  end;

  //Aosta_ASL
  AssestamentoAnnuale(1);
  AssestamentoAnnuale(2);

  //Compensazione saldo negativo con ore escluse dalle normali
  if (CausaliCompensabiliMensili <> '') and
     (RecuperoDebito >= 0) and (salmeseatt < 0) then
    CompensazioneDaCausaliEscluse('M');

  if (Pos('GALLIERA',UpperCase(Parametri.RagioneSociale)) > 0) and
     (RecuperoDebito >= 0) and (salannoatt < 0) then
    CompensazioneDaCausaliEscluse;

  //Genova_Comune (Alberto 25/02/2005)
  if (SogliaCompLiq < 0) and (ArrSogliaCompLiq > 0) and (salliqannoatt > 0) then
  begin
    app:=salliqannoatt;
    app1:=Trunc(R180Arrotonda(app,ArrSogliaCompLiq,'D'));
    app:=app - app1;
    salliqannoatt:=app1;
    inc(salcompannoatt,app);
    for i:=1 to MaxFasce do
    begin
      if app = 0 then
        Break;
      app1:=Min(tstrmese[i],app);
      dec(app,app1);
      dec(tstrannom[i],app1);
      dec(tstrmese[i],app1);
    end;
  end;
  //Arrotondamento (solo se la banca ore è inclusa nei saldi)
  if (BancaOreMensArr > 0) and (BancaOreEsclusaSaldi <> 'S')  then
    liquidabmese:=Trunc(R180Arrotonda(liquidabmese,BancaOreMensArr,'D'));
  //Alberto 03/09/1999: Gestione dell'addebito del saldo negativo non recuperato
  AddebitoSaldoNegativo(True);
  //27-05-2003 Regione Piemonte, abbuono delle ore inferiori al minimo stabilito (-12.00) -> Non vale per il Comune di Genova!
  if (SaldoNegativoMinimoTipo = '1') and (SaldoNegativoMinimo < 0) and (salannoatt < 0) then
  begin
    if RecuperoDebito < 0 then
    begin
      app:=Abs(salannoatt);
      inc(FAddebitoPaghe,app);
      inc(salannoatt,app);
      inc(salcompannoatt,app);
    end
    else
      SaldoNegativoMinimoEcced:=Abs(salannoatt);
  end;
  salcompannoattNetto:=salcompannoatt - salcompannoattExt; //Alberto 25/05/2001
  if salcompannoattNetto < 0 then
    salcompannoattNetto:=0;
  (*//Martini: azzeramento compensabile
  if (TipoLimiteCompA = 'T') and (salcompannoattNetto > 0) then
  begin
    dec(salannoatt,salcompannoattNetto);
    dec(salmeseatt,salcompannoattNetto);
    dec(salmeseattnocau,salcompannoattNetto);
    inc(FOreTroncate,salcompannoattNetto);
    salcompannoatt:=salcompannoatt - salcompannoattNetto;
  end;*)
  //Come il Martini, ma filtrato al limite fisso LimiteCompA
  if (TipoLimiteCompA = 'H') and (LimiteCompA >= 0) then
  begin
    app:=0;
    if (TipoLimiteCompP = 'S') and (salcompannoattNetto + salcompannoprec > LimiteCompA) then
      app:=salcompannoattNetto + salcompannoprec;
    if (TipoLimiteCompP = 'N') and (salcompannoattNetto > LimiteCompA) then
      app:=salcompannoattNetto;
    dec(salannoatt,Max(0,app - LimiteCompA));
    inc(FOreTroncate,Max(0,app - LimiteCompA));
    if TipoLimiteCompP = 'S' then
      app1:=Max(0,Min(salcompannoprec,Max(0,app - LimiteCompA)))
    else
      app1:=0;
    dec(salcompannoatt,Max(0,app - LimiteCompA) - app1);
    dec(salmeseatt,Max(0,app - LimiteCompA) - app1);
    dec(salmeseattnocau,Max(0,app - LimiteCompA) - app1);
    dec(salcompannoprec,app1);
    //Abbatto anche liquidabmese (usato per banca ore) per evitare che venga ulteriormente abbattuto in LimiteEccedenzaMensile2
    if (Max(0,app - LimiteCompA) - app1) > 0 then
      liquidabmese:=Max(0,Min(liquidabmese,salmeseatt));
  end;
  //Alberto 03/07/2001
  //Calcolo del solo compensabile mensile tenendo conto dell'eventuale limite straordinario mensile
  //che non tronca le eccedenze liquidabili
  FCompensabileMensile:=salmeseattnocau; //Alberto 07/02/2007 (BRUINO_COMUNE) - considero il saldo mese al netto del recupero da causale
  //FCompensabileMensileLIQUeseatt;
  if LiquidazioneDistribuita = 'S' then
    inc(FCompensabileMensile,totliqmm);
  dec(FCompensabileMensile,StrFattoMeseTotale);
  if FCompensabileMensile < 0 then
    FCompensabileMensile:=0;
  //Alberto 03/07/2001: Applicazione del limite residuabile  sull'eccedenza mensile visibile sulla scheda corrente
  //Alberto 15/11/2005: il limite del residuabile deve preservare i riposi non fruiti
  app:=EccResAutMenVariato;
  if (RiposoRecupLiquid = 'S') and (RiposoNonFruito <> '') then
    inc(app,RiposiNonFruitiOre);
  if //((TroncaLiquidabile = 'CL') and (FCompensabileMensile + min(liquidabmese,max(0,salmeseatt - salmeseattnocau)) + min(min(0,salcompannoatt_prec),salfmprec) > app)) or
     //((TroncaLiquidabile = 'CL') and (max(FCompensabileMensile,liquidabmese) + min(min(0,salcompannoatt_prec),salfmprec) > app)) or
     ((TroncaLiquidabile = 'CL') and (min(max(FCompensabileMensile,liquidabmese),max(0,salmeseatt)) + min(min(0,salcompannoatt_prec),salfmprec) > app)) or
     ((TroncaLiquidabile = 'LL') and (liquidabmese >= app)) then
    LimiteEccedenzaMensile2;
  //Alberto 19/11/2005 (COMUNEDIGENOVA)
  //gli scostamenti negativi al netto del compensabile 'puro', abbattono la banca ore mensile e poi il liquidabile
  OreCompRecupSoloBancaOre:=0;
  if (SaldoNegativoMinimoTipo = '2') and (SaldoNegativoMinimo < 0) and (ArrRecScostNeg > 0) then
  begin
    //Alberto 13/04/2006
    (*Prima era così:
      app:=Max(0,-SaldoNegativoMinimo + scostnegmes); //Flessibilità negativa che arriva dal mese precedente non recuperata
      app1:=Trunc(R180Arrotonda(-SaldoNegativoMinimo - app,ArrRecScostNeg,'D')); //Scostamento negativo del mese: considero solo la quantità arrotondata (il resto viene portato al mese successivo come flessibilità negativa)
      app1:=app1 + Trunc(R180Arrotonda(app,ArrRecScostNeg,'E')); //Aggiungo la flessibilità negativa che arriva dal mese precedente: viene sempre recuperata arrotondata per eccesso.
      Ora è così (faccio prima l'arrotondamento per eccesso di app):
    *)
    app:=Max(0,-SaldoNegativoMinimo + scostnegmes); //Flessibilità negativa che arriva dal mese precedente non recuperata
    app:=Trunc(R180Arrotonda(app,ArrRecScostNeg,'E'));  //Flessibilità negativa che arriva dal mese precedente: viene sempre recuperata arrotondata per eccesso.
    //Alberto 05/07/2008: ripristinato app1 come era prima del 18/02/2008
    app1:=Trunc(R180Arrotonda(-SaldoNegativoMinimo - app,ArrRecScostNeg,'D')); //Scostamento negativo del mese: considero solo la quantità arrotondata (il resto viene portato al mese successivo come flessibilità negativa)
    //Alberto 18/02/2008: app1:=0 per impedire il recupero del negativo su banca ore e straordinario.
    //app1:=0;//app1:=Trunc(R180Arrotonda(-SaldoNegativoMinimo - app,ArrRecScostNeg,'D')); //Scostamento negativo del mese: considero solo la quantità arrotondata (il resto viene portato al mese successivo come flessibilità negativa)
    app1:=app1 + app;
    //Alberto 22/11/2005 abbattimento banca ore Mensile
    app:=Min(liquidabmese,app1);
    dec(liquidabmese,app);
    dec(app1,app);
    (*Alberto 22/11/2005: la banca ore viene abbattuta già prima quando si calcola la maturazione mensile
    app:=Min(liquidabmese,Min(app1,Max(0,FBancaOreResiduaPrec)));
    inc(FBancaOreRecuperata,app);
    inc(FBancaOreRecAnnoPrec,app);
    dec(l13_banca_ore_recuperata,app);
    dec(app1,app);
      dec(FBancaOreResiduaPrec,app);
    app:=Min(app1,Max(0,FBancaOreResidua));
    inc(FBancaOreRecuperata,app);
    dec(app1,app);
      dec(FBancaOreResidua,app);
    *)
    app:=Min(app1,Max(0,salliqannoatt));
    dec(app1,app);
    dec(salliqannoatt,app);
    inc(salcompannoatt,app);
    AbbattiLiquidabile(app);
    //Alberto 06/02/2012: correzione conteggio banca ore per Genova_Comune a partire da Gennaio 2011
    if (EncodeDate(AnnoCorr400,MeseCorr400,1) < EncodeDate(2011,1,1)) or ((UpperCase(Parametri.RagioneSociale) <> 'COMUNE DI GENOVA')) then
    begin
      app1:=max(0,min(app1,abbannopreceff + abbannoatteff));
      app1:=Trunc(R180Arrotonda(app1,ArrRecScostNeg,'D'));
      inc(OreCompRecuperate,app1);
      OreCompRecupSoloBancaOre:=app1;
    end;
    (*inc(salcompannoatt,app1);
    inc(salannoatt,app1);
    inc(salannonetto,app1);*)
  end;
  //Alberto 03/07/2001
  //***** BANCA ORE ***** (MOLINETTE/TORINO_REGIONE)
  //Suddivisione del compensabile mensile nelle fasce di maggiorazione, sulla base delle ore lavorate
  if BancaOre = 'S' then
  begin
    if TroncaLiquidabile = 'LL' then
      FBancaOreMese:=Min(liquidabmese,EccResAutMenVariato)
    else if TroncaLiquidabile = 'CL' then
    begin
      if BancaOreAbbattibile = 'S' then //Alberto 10/02/2007: BIELLA_ASL12
        FBancaOreMese:=Min(FCompensabileMensile + min(liquidabmese,max(0,salmeseatt - salmeseattnocau)),EccResAutMenVariato)
      else
        //Alberto 19/09/2006: considero anche il liquidabmese, nel caso che sia maggiore di FCompensabileMese (recupero da eccedenze pregresse)
        FBancaOreMese:=Min(Max(FCompensabileMensile + min(liquidabmese,max(0,salmeseatt - salmeseattnocau)),liquidabmese),EccResAutMenVariato);
      FBancaOreMese:=Min(FBancaOreMese,Max(salcompannoatt + salcompannoprec,0));
    end
    else if TroncaLiquidabile = 'EG' then  //Molinette
      ;//FBancaOreMese è già stato valorizzato nella gestione TroncaEccedenze = EG
    if BancaOreLimitataSaldoComplessivo = 'S' then
    //Se previsto limito la banca ore al saldo complessivo
      FBancaOreMese:=Min(FBancaOreMese,Max(salannoatt,0));
    if BancaOreLimitataStrLiquidabile = 'S' then
    begin
      //Se previsto limito la banca ore allo straord.liq.annuo (Alberto 30/04/2009: AOSTA_ASL - si tiene conto anche delle causali escluse dalle normali)
      FBancaOreMese:=Min(FBancaOreMese,Max((EccAutAnno['LIQUIDABILE'] + EccAutAnno['CAUSALIZZATO'] - FBancaOreAnno - LiqNellAnno - LiqAnnoCauEstIncBud - ResoAnnoCauEstIncBO),0));
      //Alberto 30/04/2009: AOSTA_ASL - limitazione del riepilogo delle causali di presenza escluse che vengono considerate in BancaOre
      if FBancaOreMese = 0 then
      begin
        app:=Max(0,OreCausReseEsterneInBO - Max((EccAutAnno['LIQUIDABILE'] + EccAutAnno['CAUSALIZZATO'] - FBancaOreAnno - LiqNellAnno - LiqAnnoCauEstIncBud - ResoAnnoCauEstIncBO + OreCausReseEsterneInBO),0));
        if app > 0 then
          for xx:=0 to High(RiepPres) do
          begin
            if selT275.SearchRecord('CODICE',RiepPres[xx].Causale,[srFromBeginning]) then
              if (selT275.FieldByName('ABBATTE_BUDGET').AsString = 'B') and
                 (selT275.FieldByName('ORENORMALI').AsString = 'A') then
              begin
                app1:=app;
                AbbattiRiepPresBO(xx,app);
              end;
          end;
      end;
    end;
    CompensabileMensileInFasce;
  end
  else
  begin
    for xx:=Low(tbancaore) to High(tbancaore) do tbancaore[xx]:=0;
    FBancaOreMese:=0;
    //Alberto 27/06/2012: AIPO
    FBancaOreAnno:=0;
    FBancaOreLiquidata:=0;
    FBancaOreResidua:=0;
    FBancaOreResiduaPrec:=0;
    FBancaOrerecuperata:=0;
    l13_banca_ore:=0;
  end;
  if BancaOreEsclusaSaldi = 'S' then
  begin
    //CRV - Inizio: la banca ore è esclusa dai saldi con arrotondamento puro su ogni fascia
    for xx:=Low(tbancaore) to High(tbancaore) do
    begin
      //Esclusione banca ore dalle ore normali
      dec(salcompannoatt,tbancaore[xx]);
      dec(salannoatt,tbancaore[xx]);
      dec(FCompensabileMensile,tbancaore[xx]);
      if BancaOreMensArr > 1 then
      begin
        //Applicazione arrotondamento su ogni fascia
        app:=Trunc(R180Arrotonda(tbancaore[xx],BancaOreMensArr,'P'));
        inc(FBancaOreMese,app - tbancaore[xx]);
        if app < tbancaore[xx] then
        begin
          //Resituzione delle ore normali in caso arrotondamento inferiore
          inc(salcompannoatt,tbancaore[xx] - app);
          inc(salannoatt,tbancaore[xx] - app);
          inc(FCompensabileMensile,tbancaore[xx] - app);
        end;
        tbancaore[xx]:=app;
      end;
    end;
  end;
  //CRV - Fine
  //Banca Ore maturata da inizio anno
  inc(FBancaOreAnno,FBancaOreMese);
  //Banca Ore liquidata da inizio anno
  inc(FBancaOreLiquidata,L07.OreCompLiquidate);
  //Banca Ore recuperate con assenze da inizio anno
  inc(FBancaOreRecuperata,OreCompRecuperate);
  dec(OreCompRecuperate,OreCompRecupSoloBancaOre); //Alberto 18/07/2007: aggiunta la detrazione, altrimenti su scheda riepilogativa veniva salavto OreCompRecuperate + OreCompRecupSoloBancaOre
  if BancaOreEsclusaSaldi <> 'S' then
  begin
    //Abbattimento saldi con Banca Ore liquidata
    AbbattiBancaOreLiquidata;
    //Abbattimento saldi con Banca Ore recuperata
    //AbbattiBancaOreRecuperata(OreCompRecuperate - OreCompRecupSoloBancaOre);  //Alberto 18/07/2007:
    AbbattiBancaOreRecuperata(OreCompRecuperate);
    //Alberto 08/05/2009: AOSTA_ASL - le causali di assestamento in negativo possono rendere negativa la banca ore
    //Se il residuo della banca ore è diminuito, si verifica se dipende dalle causali di assestamento
    GestioneBancaOreMeseNegativa;
  end;
  //Banca ore residua dall'anno prec.: (non può essere negativa) Residuo anno precedente al netto del recupero fatto da inizio anno
  if BancaOreEsclusaSaldi = 'S' then //La banca ore liquidata intacca anche l'anno precedente
    FBancaOreResiduaPrec:=Max(0,l13_banca_ore - FBancaOreRecuperata - FBancaOreRecInterna - FBancaOreLiquidata)
  else if SaldoNegativoMinimoTipo = '2' then //COMUNEDIGENOVA: Alberto 23/02/2006
    FBancaOreResiduaPrec:=Max(0,l13_banca_ore - FBancaOreRecuperata - FBancaOreRecInterna)
  else
    FBancaOreResiduaPrec:=Max(0,Min(Max(0,l13_banca_ore - FBancaOreRecuperata - FBancaOreRecInterna),salcompannoprec (*NUOVO*) - Min(0,SaldoNegativoMinimo)));
  //Alberto 21/11/2005
  FBancaOreRecAnnoPrec:=Max(0,Max(0,l13_banca_ore) - FBancaOreResiduaPrec);
  //La banca ore può esistere anche senza eccedenza compensabile, se specificato un SaldoNegativoMinimo (Regione Piemonte)
  if (Pos('CP',ElencoSerbatoi) = 0) and (SaldoNegativoMinimoTipo = '0') then
    app1:=salcompannoatt
  else
    app1:=salcompannoatt + salcompannoprec - FBancaOreResiduaPrec;
  if BancaOreEsclusaSaldi = 'S' then //La banca ore liquidata intacca anche l'anno precedente
    FBancaOreResidua:=FBancaOreAnno - (FBancaOreLiquidata + FBancaOreRecuperata + FBancaOreRecInterna - FBancaOreRecAnnoPrec)
  else
    FBancaOreResidua:=Max(-FBancaOreRecuperata,Min(app1,FBancaOreAnno - FBancaOreLiquidata - Max(0,FBancaOreRecuperata + FBancaOreRecInterna - FBancaOreRecAnnoPrec)));
  //Gestione eccsolocompres (???)
  inc(FCompensabileAnnuo,FCompensabileMensile);
  eccsolocompres:=salcompannoatt + salcompannoprec - FCompensabileAnnuo;
  if eccsolocompres < 0 then
    eccsolocompres:=0;
  //Compensazione saldo negativo con ore escluse dalle normali
  if salannoatt < 0 then
    CompensazioneDaCausaliEscluse;
  //Detrazione ore liquidate da anni precedenti e variazione ore per i saldi di fine anno
  LiquidazioniVariazioniAnniPrecedenti;
  //Salvataggio saldi
  SetLength(RiepilogoMese,Length(RiepilogoMese) + 1);
  iRM:=High(RiepilogoMese);
  RiepilogoMese[iRM].Data:=EncodeDate(AnnoCorr400,MeseCorr400,1);
  RiepilogoMese[iRM].Abbattimento:=0;
  RiepilogoMese[iRM].SaldoMese:=salmeseatt;
  RiepilogoMese[iRM].SaldoMeseNoCau:=salmeseattnocau;
  RiepilogoMese[iRM].EccSoloCompMes:=eccsolocompmes;
  RiepilogoMese[iRM].StrLiqGGMese:=strliqggmese;
  RiepilogoMese[iRM].OreLiqMese:=totliqmm;
  RiepilogoMese[iRM].RecuperoMensile:=RecuperoMensile;
  RiepilogoMese[iRM].RecuperoNegativi:=0;
  RiepilogoMese[iRM].NegativiNonRecuperati:=0;
  RiepilogoMese[iRM].OreRecuperate:=OreRecuperate;
  //RiepilogoMese[iRM].RecuperoUtilizzato:=0;
  RiepilogoMese[iRM].SaldoAnnoAtt:=salannoatt;
  RiepilogoMese[iRM].SaldoAnnoLiq:=salliqannoatt + salliqannoprec;
  RiepilogoMese[iRM].SaldoAnnoComp:=salcompannoatt + salcompannoprec;
  RiepilogoMese[iRM].AddebitoPaghe:=FAddebitoPaghe;
  RiepilogoMese[iRM].BancaOreResAtt:=GetBOInclusaSaldi(FBancaOreResidua);
  RiepilogoMese[iRM].BancaOreResPrec:=GetBOInclusaSaldi(FBancaOreResiduaPrec);
  RiepilogoMese[iRM].RiposiNonFruitiOre:=RiposiNonFruitiOre;
  RiepilogoMese[iRM].SaldoNegativoMinimo:=SaldoNegativoMinimo;
  RiepilogoMese[iRM].RiepSaldiMobili_SaldoPrecedente:=0;
  RiepilogoMese[iRM].RiepSaldiMobili_SaldoDisponibile:=0;
  {*}
  SetLength(RiepilogoMese[iRM].RiepPres,Length(RiepPres));
  for xx:=0 to High(RiepPres) do
    RiepilogoMese[iRM].RiepPres[xx]:=RiepPres[xx];
  {*}
  for xx:=0 to High(RiepilogoMese) do
    RiepilogoMese[xx].RiepSaldiMobili_Recupero:=0;
  //Saldi mobili (S.Martino)
  if (PeriodicitaAbbattimento = 'M') and
     (MesiSaldoPrec >= 0) and
     (SaldoMobile_AbbatteMax > 0) and
     (SaldoMobile_SaldiUsati <> '') then
  begin
    SaldiMobili;
    SaldiMobiliRecuperoNegativi;
    {*}
    for xx:=0 to High(RiepPres) do
      if (VarToStr(selT275.Lookup('CODICE',RiepPres[xx].Causale,'ORENORMALI')) = 'A') and
         (selT275.Lookup('CODICE',RiepPres[xx].Causale,'PERIODICITA_ABBATTIMENTO') >= 0) then
        SaldiMobiliRiepPres(RiepPres[xx].Causale,selT275.Lookup('CODICE',RiepPres[xx].Causale,'PERIODICITA_ABBATTIMENTO'));
    {*}
  end;
  //Riaggiornamento del residuo banca ore dopo l'abbattimento dei saldi mobili
  if BancaOreEsclusaSaldi <> 'S' then
  begin
    if SaldoNegativoMinimoTipo = '2' then //COMUNEDIGENOVA: Alberto 23/02/2006
      FBancaOreResiduaPrec:=Max(0,l13_banca_ore - FBancaOreRecuperata - FBancaOreRecInterna)
    else
      FBancaOreResiduaPrec:=Max(0,Min(Max(0,l13_banca_ore - FBancaOreRecuperata - FBancaOreRecInterna),salcompannoprec (*NUOVO*) - Min(0,SaldoNegativoMinimo)));
    if (Pos('CP',ElencoSerbatoi) = 0) and (SaldoNegativoMinimoTipo = '0') then
      app1:=salcompannoatt
    else
      app1:=salcompannoatt + salcompannoprec - FBancaOreResiduaPrec;
    FBancaOreResidua:=Max(-FBancaOreRecuperata,Min(app1,FBancaOreAnno - FBancaOreLiquidata - Max(0,FBancaOreRecuperata + FBancaOreRecInterna - FBancaOreRecAnnoPrec)));
    //Alberto 31/10/2006: Biella_ASL12: recupero automatico della banca ore se diminuisce il compensabile annuo
    if (BancaOreAbbattibile = 'S') and
       (FBancaOreResidua + FBancaOreRecuperata + FBancaOreRecInterna + FBancaOreLiquidata < FBancaOreAnno) then
    begin
      FBancaOreRecInternaMensile:=FBancaOreAnno - (FBancaOreResidua + FBancaOreRecuperata + FBancaOreRecInterna + FBancaOreLiquidata);
      inc(FBancaOreRecInterna,FBancaOreRecInternaMensile);
      //Il recupero viene effettuato subito anche sull'anno precedente
      app1:=min(FBancaOreRecInternaMensile,max(0,FBancaOreResiduaPrec));
      dec(FBancaOreResiduaPrec,app1);
      inc(FBancaOreResidua,app1);
    end;
    RiepilogoMese[iRM].BancaOreResAtt:=FBancaOreResidua;
    RiepilogoMese[iRM].BancaOreResPrec:=FBancaOreResiduaPrec;
  end;
  //Alberto 16/01/2005: Straordinario elettorale
  (*- Scorrere i limiti mensili del mese in ordine di priorità,
    - Per ciascuno creare il corrispondente riepilogo presenze
    - Se Banca Ore = 'N' togliere le ore dai saldi*)
  LimitiMensiliCausalizzati;
  //Ri-aggiornamento dei saldi modificati in LimitiMensiliCausalizzati
  RiepilogoMese[iRM].SaldoMese:=salmeseatt;
  RiepilogoMese[iRM].SaldoMeseNoCau:=salmeseattnocau;
  RiepilogoMese[iRM].SaldoAnnoAtt:=salannoatt;
  RiepilogoMese[iRM].SaldoAnnoLiq:=salliqannoatt + salliqannoprec;
  //Regione piemonte: debito/credito. I saldi vengono riabbassati della soglia minima specificata
  (*NUOVO*)if SaldoNegativoMinimo < 0 then
  begin
    RiepilogoPrecedente.CompAttMaggiorato:=salcompannoatt;
    RiepilogoPrecedente.LiqAttMaggiorato:=salliqannoatt;
    inc(salmeseatt,SaldoNegativoMinimo);
    inc(salmeseattnocau,SaldoNegativoMinimo);
    inc(salannoatt,SaldoNegativoMinimo + IfThen(SaldoNegativoMinimoTipo = '1',SaldoNegativoMinimoEcced,0));
    inc(totoreres,SaldoNegativoMinimo);
    inc(totoreresnorip,SaldoNegativoMinimo);
    app:=Abs(SaldoNegativoMinimo) - IfThen(SaldoNegativoMinimoTipo = '1',SaldoNegativoMinimoEcced,0);
    app1:=max(0,min(app,salcompannoatt));
    dec(salcompannoatt,app1);
    dec(app,app1);
    app1:=max(0,min(app,salliqannoatt));
    dec(salliqannoatt,app1);
    dec(app,app1);
    dec(salcompannoatt,app);
  end;
  inc(BOMaturataCausEsterneAnno,BOMaturataCausEsterne);
end;

procedure TR450DtM1.y420_sottrserb;
{Sottrazione eventuali negativi dai quattro serbatoi}
var i:Byte;
    differenza:Integer;
begin
  if sottrserbcomodo = 0 then exit;
  for i:=1 to 4 do
  begin
    if Serbatoi[i] = 'CP' then
      y421_AbbattiSerbatoio(Serbatoi[i],ArrotondaCP,sottrserbcomodo,salcompannoprec,abbannopreceff,differenza)
    else if Serbatoi[i] = 'LP' then
      y421_AbbattiSerbatoio(Serbatoi[i],ArrotondaLP,sottrserbcomodo,salliqannoprec,abbannopreceff,differenza)
    else if Serbatoi[i] = 'CA' then
      y421_AbbattiSerbatoio(Serbatoi[i],ArrotondaCA,sottrserbcomodo,salcompannoatt,abbannoatteff,differenza)
    else if Serbatoi[i] = 'LA' then
      y421_AbbattiSerbatoio(Serbatoi[i],ArrotondaLA,sottrserbcomodo,salliqannoatt,abbannoatteff,differenza);
  end;
end;

procedure TR450DtM1.y421_AbbattiSerbatoio(TipoSerbatoio:String; arrot:Integer; var recupero,serbatoio,abbeff,differenza:Integer);
var Abb,SerbatoioApp:Integer;
begin
  differenza:=0;
  SerbatoioApp:=serbatoio;
  if BancaOrePreservata = 'S' then
    if TipoSerbatoio = 'CP' then
      SerbatoioApp:=SerbatoioApp - Max(0,Min(RiepilogoPrecedente.BancaOreResiduaPrec,serbatoio))
    else if TipoSerbatoio = 'CA' then
      SerbatoioApp:=SerbatoioApp - Max(0,Min(RiepilogoPrecedente.BancaOreResidua,serbatoio));
  if (arrot > 1) and (recupero < SerbatoioApp) then
  begin
    differenza:=recupero;
    recupero:=Min(SerbatoioApp,Trunc(R180Arrotonda(recupero,arrot,'E')));
    differenza:=recupero - differenza;
  end;
  Abb:=Min(recupero,SerbatoioApp);
  dec(recupero,Abb);
  dec(serbatoio,Abb);
  inc(abbeff,Abb);
end;

procedure TR450DtM1.y500_contdati5;
{Conteggio dati del mese tipo 'Compensazione con causale'
 Es. SAVONA}
var i,xx:Integer;
begin
  //Saldo mese attuale
  salmeseatt:=totoreres - debtotmes - totliqmm;
  //Saldo fine mese precedente
  salfmprec:=salannoatt_prec;
  if (azzsaldofmpos = 'S') and (salfmprec > 0) then
    salfmprec:=0;
  //Saldo anno attuale
  salannoatt:=salfmprec + salmeseatt;
  //Straordinario liq. da inizio anno derivato dal giornaliero
  for i:=1 to NFasceMese + 1 do
    tstranno[i]:=tstranno_prec[i] + tminstrmen[i];
  //Lavorato mensile per calcolo PORESO
  totore:=totoreres - totliqmm;
  if (poflag = '1') or (salannoatt_prec <= salpoanno_prec) then
    totore:=totore + salannoatt_prec - salpoanno_prec;
  //Debito plus orario effettivo del mese
  debpoeff:=debpomes - salpoanno_prec;
  //Plus orario effettivo reso nel mese
  if totore <= debormes then
    poreso:=0
  else
    begin
    poreso:=totore - debormes;
    if poreso > debpoeff then
      poreso:=debpoeff;
    end;
  //Plus orario reso da inizio anno
  poresoanno:=poresoanno_prec + poreso;
  //Saldo plus orario annuale
  salpoanno:=salpoanno_prec + poreso - debpomes;
  //Eccedenza solo comp. dell'anno derivata dalla giornaliera
  eccsolocompanno:=eccsolocompanno_prec + eccsolocompmes;
  //Totale straordinario liq. da inizio anno derivato dal
  //giornaliero detratto del liquidato e dell'eventuale plus orario reso
  strliqgganno:=0;
  for i:=1 to NFasceMese + 1 do
    strliqgganno:=strliqgganno + tstranno[i] - tstrliq[i];
  if eccsolocompanno < poresoanno then
    strliqgganno:=strliqgganno - (poresoanno - eccsolocompanno);
  //Totale straordinario liq. da inizio anno derivato dal
  //giornaliero aggiornato con la variazione alle eccedenze
  //per liquidazione dell'anno
  strliqgganno:=strliqgganno + vareccliqanno;
  if strliqgganno < 0 then
    strliqgganno:=0;
  //Eccedenza totale da inizio anno
  if salannoatt > salpoanno then
    ecctotanno:=salannoatt - salpoanno
  else
    ecctotanno:=0;
  //Totale compensato con assenza da inizio anno
  abbannoprecanno:=abbannoprecanno_prec + abbannoprecmes;
  //Eccedenza solo compensabile residua da inizio anno
  if eccsolocompanno > abbannoprecanno then
    eccsolocompres:=eccsolocompanno - abbannoprecanno
  else
    eccsolocompres:=0;
  //Straordinario liquidabile da inizio anno (automatico)
  for i:=1 to NFasceMese + 1 do
    tstrannom[i]:=tstrliq[i];
  if ecctotanno > eccsolocompres then
    scostcomodo:=ecctotanno - eccsolocompres
  else
    scostcomodo:=0;
  for i:=NFasceMese + 1 downto 1 do
    begin
    if scostcomodo = 0 then Break;
    if tstrannom[i] < tstranno[i] then
      begin
      diffcomodo:=tstranno[i] - tstrannom[i];
      if diffcomodo > scostcomodo then
        begin
        inc(tstrannom[i],scostcomodo);
        scostcomodo:=0;
        end
      else
        begin
        inc(tstrannom[i],diffcomodo);
        dec(scostcomodo,diffcomodo);
        end;
      end;
    end;
  inc(tstrannom[1],scostcomodo);
  //Totale straordinario liquidabile da inizio anno
  stranno:=0;
  for i:=1 to NFasceMese + 1 do
    inc(stranno,tstrannom[i]);
  //Straordinario effettivo liquidabile nel mese
  if stranno > stranno_prec then
    for i:=1 to NFasceMese + 1 do tstrmese[i]:=tstrannom[i] - tstrannom_prec[i]
  else
    for xx:=Low(tstrmese) to High(tstrmese) do tstrmese[xx]:=0;
  //Straordinario liquidabile anno precedente
  salliqannoprec:=salliqannoprec_prec;
end;

procedure TR450DtM1.y600_contdati6;
{Conteggio dati del mese tipo 'Straordin. dopo resa debito'
 Es. SAN CAMILLO}
var i,xx:Integer;
begin
  //Saldo mese attuale
  salmeseatt:=totoreres - debtotmes - totliqmm;
  //Saldo fine mese precedente
  salfmprec:=salannoatt_prec;
  if (azzsaldofmpos = 'S') and (salfmprec > 0) then
    salfmprec:=0;
  //Saldo anno attuale
  salannoatt:=salfmprec + salmeseatt;
  //Straordinario liq. da inizio anno derivato dal giornaliero
  for i:=1 to NFasceMese + 1 do
    tstranno[i]:=tstranno_prec[i] + tminstrmen[i];
  //Lavorato mensile per calcolo PORESO
  totore:=totoreres - totliqmm;
  if (poflag = '1') or (salannoatt_prec <= salpoanno_prec) then
    totore:=totore + salannoatt_prec - salpoanno_prec;
  //Debito plus orario effettivo del mese
  debpoeff:=debpomes - salpoanno_prec;
  //Plus orario effettivo reso nel mese
  if totore <= debormes then
    poreso:=0
  else
    begin
    poreso:=totore - debormes;
    if poreso > debpoeff then
      poreso:=debpoeff;
    end;
  //Plus orario reso da inizio anno
  poresoanno:=poresoanno_prec + poreso;
  //Saldo plus orario annuale
  salpoanno:=salpoanno_prec + poreso - debpomes;
  //Eccedenza solo comp. dell'anno derivata dalla giornaliera
  eccsolocompanno:=eccsolocompanno_prec + eccsolocompmes;
  //Totale straordinario liq. da inizio anno derivato dal
  //giornaliero detratto del liquidato e dell'eventuale plus orario reso
  strliqgganno:=0;
  for i:=1 to NFasceMese do
    strliqgganno:=strliqgganno + tstranno[i] - tstrliq[i];
  if eccsolocompanno < poresoanno then
    strliqgganno:=strliqgganno - (poresoanno - eccsolocompanno);
  //Totale straordinario liq. da inizio anno derivato dal
  //giornaliero aggiornato con la variazione alle eccedenze
  //per liquidazione dell'anno
  strliqgganno:=strliqgganno + vareccliqanno;
  //Totale straordinario liq. da inizio anno derivato dal
  //giornaliero aggiornato con scostamenti negativi
  //e ore abbattimento anno precedente
  strliqgganno:=strliqgganno + scostnegmes + abbannoprecmes;
  if strliqgganno < 0 then
    strliqgganno:=0;
  //Eccedenza totale da inizio anno
  if salannoatt > salpoanno then
    ecctotanno:=salannoatt - salpoanno
  else
    ecctotanno:=0;
  //Eccedenza solo compensabile residua da inizio anno
  if strliqgganno > ecctotanno then
    eccsolocompres:=0
  else
    eccsolocompres:=ecctotanno - strliqgganno;
  //Straordinario liquidabile da inizio anno (automatico)
  for i:=1 to NFasceMese + 1 do
    tstrannom[i]:=tstrliq[i];
  if strliqgganno > ecctotanno then
    scostcomodo:=ecctotanno
  else
    scostcomodo:=strliqgganno;
  for i:=NFasceMese + 1 downto 1 do
    begin
    if scostcomodo = 0 then Break;
    if tstrannom[i] < tstranno[i] then
      begin
      diffcomodo:=tstranno[i] - tstrannom[i];
      if diffcomodo > scostcomodo then
        begin
        inc(tstrannom[i],scostcomodo);
        scostcomodo:=0;
        end
      else
        begin
        inc(tstrannom[i],diffcomodo);
        dec(scostcomodo,diffcomodo);
        end;
      end;
    end;
  inc(tstrannom[1],scostcomodo);
  //Totale straordinario liquidabile da inizio anno
  stranno:=0;
  for i:=1 to NFasceMese + 1 do
    inc(stranno,tstrannom[i]);
  //Straordinario effettivo liquidabile nel mese
  if stranno > stranno_prec then
    for i:=1 to NFasceMese + 1 do tstrmese[i]:=tstrannom[i] - tstrannom_prec[i]
  else
    for xx:=Low(tstrmese) to High(tstrmese) do tstrmese[xx]:=0;
  //Straordinario liquidabile anno precedente
  salliqannoprec:=salliqannoprec_prec;
end;

function TR450DtM1.GetAbbattimentoSaldi(var MR,MA:Integer):Boolean;
{Ricerca dati di abbattimento saldi (Melegnano)}
begin
  Result:=False;
  with selT026 do
  begin
    First;
    while not Eof do
    begin
      if (FieldByName('ANNO_RIF').AsInteger = AnnoCorr400) and
         (FieldByName('MESE_RIF').AsInteger <= MeseCorr400) and
         (FieldByName('MESE_ABBATT').AsInteger >= MeseCorr400) then
      begin
        MR:=FieldByName('MESE_RIF').AsInteger;
        MA:=FieldByName('MESE_ABBATT').AsInteger;
        Result:=True;
        Break;
      end;
      Next;
    end;
  end;
end;

procedure TR450DtM1.GetRiepilogoRecuperi(var RiepilogoRecuperi:TRiepilogoRecuperi);
{Lettura dei saldi da recuperare entro il periodo di abbattimento: si considerano i mesi
da Mese400 - MesiSaldoPrec + 1 fino a Mese400
La struttura è ripresa da quella di y400.SaldiMobili}
var i,x,k,rec,Q,BO:Integer;
    D:TDateTime;
    RM:array of TRiepilogoMese;
begin
  SetLength(RiepilogoRecuperi,0);
  SetLength(RM,0);
  //Ricerca del mese precedente a cui riferirsi (0 = mese corrente)
  //copia dei mesi interessati in RM
  D:=R180AddMesi(EncodeDate(Anno400,Mese400,1),-MesiSaldoPrec);
  for i:=Low(RiepilogoMese) to High(RiepilogoMese) do
    if RiepilogoMese[i].Data >= D then
    begin
      SetLength(RM,Length(RM) + 1);
      RM[High(RM)]:=RiepilogoMese[i];
      RM[High(RM)].RecuperoMensile:=RM[High(RM)].RecuperoMensile + RM[High(RM)].RiepSaldiMobili_Recupero;
      RM[High(RM)].RiepSaldiMobili_Recupero:=0;
    end;
  if Length(RM) = 0 then
    exit;
  for i:=0 to High(RM) do
  begin
    SetLength(RiepilogoRecuperi,Length(RiepilogoRecuperi) + 1);
    k:=High(RiepilogoRecuperi);
    RiepilogoRecuperi[k].DataReso:=RM[i].Data;
    RiepilogoRecuperi[k].DataAbbatt:=R180AddMesi(RM[i].Data,MesiSaldoPrec);
    RiepilogoRecuperi[k].Recupero:=max(0,RM[i].SaldoMeseNoCau + RM[i].OreRecuperate);
    if LiquidazioneDistribuita = 'N' then
      //Non considero l'eventuale liquidato nel mese
      Dec(RiepilogoRecuperi[k].Recupero,RM[i].OreLiqMese);
    if (SaldoMobile_Riferimento = '1') or (SaldoMobile_Riferimento = '2') then
    //Saldo abbattibile: minimo tra saldo mensile ed annuale
    begin
      Q:=0;
      BO:=RM[i].BancaOreResAtt + RM[i].BancaOreResPrec;
      if Pos('C',SaldoMobile_SaldiUsati) > 0 then
        if BancaOrePreservata = 'S' then
          Inc(Q,RM[i].SaldoAnnoComp - BO)
        else
          Inc(Q,RM[i].SaldoAnnoComp);
      if Pos('L',SaldoMobile_SaldiUsati) > 0 then
        inc(Q,RM[i].SaldoAnnoLiq);
      if SaldoMobile_Riferimento = '1' then
        RiepilogoRecuperi[k].Recupero:=Min(RiepilogoRecuperi[k].Recupero,Q)
      else
        RiepilogoRecuperi[k].Recupero:=Q;  //COMUNEDIGENOVA
    end;
    for x:=i + 1 to High(RM) do
    begin
      rec:=max(0,min(RiepilogoRecuperi[k].Recupero,RM[x].RecuperoMensile));
      dec(RiepilogoRecuperi[k].Recupero,rec);
      dec(RM[x].RecuperoMensile,rec);
    end;
    RiepilogoRecuperi[k].Recupero:=max(0,RiepilogoRecuperi[k].Recupero);
    RiepilogoRecuperi[k].Recupero:=min(RiepilogoRecuperi[k].Recupero,SaldoMobile_AbbatteMax);
  end;
end;

function TR450DtM1.GetDatiSaldiMobili(Dato:String; Data:TDateTime):Integer;
var RR:TRiepilogoRecuperi;
    i:Integer;
begin
  Result:=0;
  GetRiepilogoRecuperi(RR);
  for i:=0 to High(RR) do
    //if Data = RR[i].DataAbbatt then
    if Data = RR[i].DataReso then
      if UpperCase(Dato) = 'RECUPERO' then
        Result:=RR[i].Recupero;
end;

function TR450DtM1.LeggiValoreT077(Dato:String; Data:TDateTime):String;
begin
  Result:='';
  with selT077 do
    if SearchRecord('DATA;DATO',VarArrayOf([Data,Dato]),[srFromBeginning]) then
      Result:=FieldByName('VALORE').AsString;
end;

procedure TR450DtM1.DeallocaQueryStampa;
begin
  QIndPresTot.Close;
  QTurniReperib.Close;
  QMaturazioneMensa.Close;
  QAcquistoMensa.Close;
  QNumPasti.Close;
  selBuoniPastoTotali.Close;
end;
procedure TR450DtM1.ParametrizzazioneQueryStampa(Q:Byte);
begin
  case Q of
    0:with QTurniReperib do
        begin
        Close;
        SetVariable('PROGRESSIVO',Progress400);
        SetVariable('DATA1',R180InizioMese(DaData));
        SetVariable('DATA2',R180FineMese(AData));
        Open;
        end;
    1:with QMaturazioneMensa do
        begin
        Close;
        SetVariable('PROGRESSIVO',Progress400);
        SetVariable('DATA1',R180InizioMese(DaData));
        SetVariable('DATA2',R180FineMese(AData));
        Open;
        end;
    2:with QAcquistoMensa do
        begin
        Close;
        SetVariable('PROGRESSIVO',Progress400);
        SetVariable('DATA1',DaData);
        SetVariable('DATA2',AData);
        Open;
        end;
    3:with QIndPresTot do
        begin
        Close;
        SetVariable('PROGRESSIVO',Progress400);
        SetVariable('DATA1',R180InizioMese(DaData));
        SetVariable('DATA2',R180FineMese(AData));
        Open;
        end;
    4:with QResiduiMensa do
        begin
        Close;
        SetVariable('PROGRESSIVO',Progress400);
        SetVariable('ANNO1',R180Anno(DaData));
        SetVariable('ANNO2',R180Anno(AData));
        Open;
        end;
    5:with QNumPasti do
        begin
        Close;
        SetVariable('PROGRESSIVO',Progress400);
        SetVariable('DATA1',DaData);
        SetVariable('DATA2',AData);
        Open;
        end;
    6:with selT077 do
        begin
        Close;
        SetVariable('PROGRESSIVO',Progress400);
        SetVariable('DATA1',DaData);
        SetVariable('DATA2',AData);
        Open;
        end;
  end;
end;

//Lettura dei campi proprietà per stampa riepilogativa
function TR450DtM1.GetOreInTurnoDelMese:Integer;
var i:Integer;
begin  //MINUTI LAVORATI IN TURNO NEL MESE
  Result:=0;
  for i:=1 to NFasceMese do
    Result:=Result + tmininturno[i];
end;
function TR450DtM1.GetAssestamento1Totale:Integer;
var i:Integer;
begin  //ORE DI ASSESTAMENTO 1° CAUSALE
  Result:=0;
  for i:=1 to NFasceMese do
    Result:=Result + tdatiassestamen[1].tminassest[i];
end;
function TR450DtM1.GetAssestamento2Totale:Integer;
var i:Integer;
begin  //ORE DI ASSESTAMENTO 2° CAUSALE
  Result:=0;
  for i:=1 to NFasceMese do
    Result:=Result + tdatiassestamen[2].tminassest[i];
end;
function TR450DtM1.GetStrFattoMeseTotale:Integer;
var i:Integer;
begin  //STRAORDINARIO MATURATO NEL MESE
  Result:=0;
  for i:=1 to NFasceMese do
    Result:=Result + tstrmese[i];
end;
function TR450DtM1.GetLiqDalMese:Integer;
var i:Integer;
begin  //STRAORDINARIO LIQUIDATO DAL MESE
  Result:=0;
  for i:=1 to NFasceMese do
    Result:=Result + tstrliqmm[i];
end;
function TR450DtM1.GetLiqNelMese:Integer;
var i:Integer;
begin  //STRAORDINARIO LIQUIDATO NEL MESE
  Result:=0;
  for i:=1 to NFasceMese do
    Result:=Result + tLiqNelMese[i];
end;
function TR450DtM1.GetStrFattoAnno:Integer;
var i:Integer;
begin  //STRAORDINARIO FATTO NELL'ANNO
  Result:=0;
  for i:=1 to NFasceMese do
    Result:=Result + tstrannom[i];
end;
function TR450DtM1.GetLiqNellAnno:Integer;
var i:Integer;
begin  //STRAORDINARIO LIQUIDATO NELL'ANNO
  Result:=0;
  for i:=1 to NFasceMese do
    Result:=Result + tstrliq[i];
end;
function TR450DtM1.GetStrResiduoAnno:Integer;
var i:Integer;
begin  //STRAORDINARIO RESIDUO NELL'ANNO
  Result:=0;
  for i:=1 to NFasceMese do
    Result:=Result + tstrannom[i] - tstrliq[i];
end;
function TR450DtM1.GetStrResiduoAnno_Prec:Integer;
var i:Integer;
begin  //STRAORDINARIO RESIDUO NELL'ANNO RELATIVO IL MESE PRECEDENTE
  Result:=0;
  for i:=1 to NFasceMese do
    Result:=Result + tstrannom_prec[i] - tstrliq_prec[i];
end;
function TR450DtM1.GetOreAssenze:Integer;
begin  //ORE RESE DA ASSENZA
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=R180OreMinutiExt(selT070.FieldByName('OREASSENZE').AsString);
end;
function TR450DtM1.GetGGPresenza:Integer;
begin  //GIORNI DI PRESENZA
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=selT070.FieldByName('GGPRESENZA').AsInteger;
end;
function TR450DtM1.GetGGVuoti:Integer;
begin  //GIORNI VUOTI
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=selT070.FieldByName('GGVUOTI').AsInteger;
end;
function TR450DtM1.GetPrimiTurni:Integer;
begin  //PRIMI TURNI
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=selT070.FieldByName('TURNI1').AsInteger;
end;
function TR450DtM1.GetSecondiTurni:Integer;
begin  //SECONDI TURNI
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=selT070.FieldByName('TURNI2').AsInteger;
end;
function TR450DtM1.GetTerziTurni:Integer;
begin  //TERZI TURNI
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=selT070.FieldByName('TURNI3').AsInteger;
end;
function TR450DtM1.GetQuartiTurni:Integer;
begin  //QUARTI TURNI
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=selT070.FieldByName('TURNI4').AsInteger;
end;
function TR450DtM1.GetFesIntMes:Real;
begin  //FESTIVITA' INTERE
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=selT070.FieldByName('FESTIVINTERA').AsFloat + selT070.FieldByName('FESTIVINTERA_VAR').AsFloat;
end;
function TR450DtM1.GetFesRidMes:Real;
begin  //FESTIVITA' RIDOTTE
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=selT070.FieldByName('FESTIVRIDOTTA').AsFloat + selT070.FieldByName('FESTIVRIDOTTA_VAR').AsFloat;
end;
function TR450DtM1.GetIndNotturnaGG:Integer;
begin  //INDENNITA' NOTTURNA IN GIORNI
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=selT070.FieldByName('INDTURNONUM').AsInteger + selT070.FieldByName('INDTURNONUM_VAR').AsInteger;
end;
function TR450DtM1.GetIndNotturnaOre:Integer;
begin  //INDENNITA' NOTTURNA IN ORE
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=R180OreMinutiExt(selT070.FieldByName('INDTURNOORE').AsString) + R180OreMinutiExt(selT070.FieldByName('INDTURNOORE_VAR').AsString);
end;
function TR450DtM1.GetFestiviNonGoduti:Integer;
begin  //FESTIVI NON GODUTI
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=selT070.FieldByName('RIPOSI_NONFRUITI').AsInteger;
end;
function TR450DtM1.GetOreReseInail:Integer;
begin  //ORE RESE INAIL
  Result:=0;
  if selT070.RecordCount > 0 then
    Result:=R180OreMinutiExt(selT070.FieldByName('ORE_INAIL').AsString);
end;
function TR450DtM1.GetIndPresTotali:Real;
begin  //INDENNITA' DI PRESENZA TOTALI
  Result:=0;
  try
    if QIndPresTot.Active and QIndPresTot.SearchRecord('DATA',EncodeDate(anno400,mese400,1),[srFromBeginning]) then
      Result:=QIndPresTot.FieldByName('IND').AsFloat;
  except
  end;
end;
function TR450DtM1.GetReperibilitaTurni:String;
begin  //NUMERO TURNI REPERIBILITA' PIANIFICATI
  Result:='';
  try
    if QTurniReperib.Active and QTurniReperib.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[srFromBeginning]) then
    repeat
      if QTurniReperib.FieldByName('TURNI').AsInteger > 0 then
      begin
        if Result <> '' then
          Result:=Result + ' ';
        Result:=Result + QTurniReperib.FieldByName('VP_TURNO').AsString + ':' + QTurniReperib.FieldByName('TURNI').AsString;
      end;
    until not QTurniReperib.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[]);
  except
  end;
end;
function TR450DtM1.GetReperibilitaSpezzoni:String;
begin  //SPEZZONI TURNI REPERIBILITA' PIANIFICATI
  Result:='';
  try
    if QTurniReperib.Active and QTurniReperib.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[srFromBeginning]) then
    repeat
      if R180OreMinutiExt(QTurniReperib.FieldByName('SPEZZONI').AsString) <> 0 then
      begin
        if Result <> '' then
          Result:=Result + ' ';
        Result:=Result + QTurniReperib.FieldByName('VP_ORE').AsString + ':' + QTurniReperib.FieldByName('SPEZZONI').AsString
      end;
    until not QTurniReperib.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[]);
  except
  end;
end;
function TR450DtM1.GetReperibilitaOreMaggiorate:String;
begin  //ORE MAGGIORATE DA TURNI REPERIBILITA' PIANIFICATI
  Result:='';
  try
    if QTurniReperib.Active and QTurniReperib.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[srFromBeginning]) then
    repeat
      if R180OreMinutiExt(QTurniReperib.FieldByName('MAGGIORATE').AsString) <> 0 then
      begin
        if Result <> '' then
          Result:=Result + ' ';
        Result:=Result + QTurniReperib.FieldByName('VP_MAGGIORATE').AsString + ':' + QTurniReperib.FieldByName('MAGGIORATE').AsString;
      end;
    until not QTurniReperib.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[]);
  except
  end;
end;
function TR450DtM1.GetReperibilitaOreNonMagg:String;
begin  //ORE NON MAGGIORATE DA TURNI REPERIBILITA' PIANIFICATI
  Result:='';
  try
    if QTurniReperib.Active and QTurniReperib.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[srFromBeginning]) then
    repeat
      if R180OreMinutiExt(QTurniReperib.FieldByName('NONMAGGIORATE').AsString) <> 0 then
      begin
        if Result <> '' then
          Result:=Result + ' ';
        Result:=Result + QTurniReperib.FieldByName('VP_NONMAGGIORATE').AsString + ':' + QTurniReperib.FieldByName('NONMAGGIORATE').AsString;
      end;
    until not QTurniReperib.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[]);
  except
  end;
end;
function TR450DtM1.GetBuoniMensaMaturati:Integer;
begin  //BUONI MENSA MATURATI DA CONTEGGIO
  Result:=0;
  try
    if QMaturazioneMensa.Active and QMaturazioneMensa.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[srFromBeginning]) then
      Result:=QMaturazioneMensa.FieldByName('BUONIMATURATI').AsInteger;
  except
  end;
end;
function TR450DtM1.GetBuoniMensaVariati:Integer;
begin  //BUONI MENSA VARIATI MANUALMENTE
  Result:=0;
  try
    if QMaturazioneMensa.Active and QMaturazioneMensa.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[srFromBeginning]) then
      Result:=QMaturazioneMensa.FieldByName('BUONIVARIATI').AsInteger;
  except
  end;
end;
function TR450DtM1.GetBuoniMensaRecuperati:Integer;
begin  //BUONI MENSA RECUPERATI
  Result:=0;
  try
    if QAcquistoMensa.Active and QAcquistoMensa.SearchRecord('DATA',R180FineMese(EncodeDate(anno400,mese400,1)),[srFromBeginning]) then
      Result:=QAcquistoMensa.FieldByName('BUONI_RECUPERATI').AsInteger;
  except
  end;
end;
function TR450DtM1.GetBuoniMensaAnnoPrec:Integer;
begin  //BUONI MENSA RESIDUI ALL'ANNO PERCEDENTE
  Result:=0;
  try
    if QResiduiMensa.Active and QResiduiMensa.SearchRecord('ANNO',anno400,[srFromBeginning]) then
      Result:=QResiduiMensa.FieldByName('BUONIPASTO').AsInteger;
  except
  end;
end;
function TR450DtM1.GetTicketMaturati:Integer;
begin  //TICKET MATURATI DA CONTEGGIO
  Result:=0;
  try
    if QMaturazioneMensa.Active and QMaturazioneMensa.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[srFromBeginning]) then
      Result:=QMaturazioneMensa.FieldByName('TICKETMATURATI').AsInteger;
  except
  end;
end;
function TR450DtM1.GetTicketVariati:Integer;
begin  //TICKET VARIATI MANUALMENTE
  Result:=0;
  try
    if QMaturazioneMensa.Active and QMaturazioneMensa.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[srFromBeginning]) then
      Result:=QMaturazioneMensa.FieldByName('TICKETVARIATI').AsInteger;
  except
  end;
end;
function TR450DtM1.GetFornituraBuoniTicketAcquistati:TDateTime;
begin  //DATA FORNITURA DEI BUONI/TICKET ACQUISTATI (PERUGIA_REGIONE)
  Result:=0;
  try
    if QAcquistoMensa.Active and QAcquistoMensa.SearchRecord('DATA',R180FineMese(EncodeDate(anno400,mese400,1)),[srFromBeginning]) then
      Result:=QAcquistoMensa.FieldByName('DATA_MAGAZZINO').AsDateTime;
  except
  end;
end;
function TR450DtM1.GetBlocchettiAcquistati:String;
begin  //Elenco blocchetti acquistati nel mese
  Result:='';
  try
    if QAcquistoMensa.Active and QAcquistoMensa.SearchRecord('DATA',R180FineMese(EncodeDate(anno400,mese400,1)),[srFromBeginning]) then
      Result:=QAcquistoMensa.FieldByName('ID_BLOCCHETTI').AsString;
  except
  end;
end;
function TR450DtM1.GetBuoniMensaAcquistati:Integer;
begin  //BUONI MENSA ACQUISTATI
  Result:=0;
  try
    if QAcquistoMensa.Active and QAcquistoMensa.SearchRecord('DATA',R180FineMese(EncodeDate(anno400,mese400,1)),[srFromBeginning]) then
      Result:=QAcquistoMensa.FieldByName('BUONI').AsInteger;
  except
  end;
end;
function TR450DtM1.GetTicketAcquistati:Integer;
begin  //TICKET ACQUISTATI
  Result:=0;
  try
    if QAcquistoMensa.Active and QAcquistoMensa.SearchRecord('DATA',R180FineMese(EncodeDate(anno400,mese400,1)),[srFromBeginning]) then
      Result:=QAcquistoMensa.FieldByName('TICKET').AsInteger;
  except
  end;
end;
function TR450DtM1.GetTicketRecuperati:Integer;
begin  //TICKET RECUPERATI
  Result:=0;
  try
    if QAcquistoMensa.Active and QAcquistoMensa.SearchRecord('DATA',R180FineMese(EncodeDate(anno400,mese400,1)),[srFromBeginning]) then
      Result:=QAcquistoMensa.FieldByName('TICKET_RECUPERATI').AsInteger;
  except
  end;
end;
function TR450DtM1.GetTicketAnnoPrec:Integer;
begin  //TICKET RESIDUI ALL'ANNO PERCEDENTE
  Result:=0;
  try
    if QResiduiMensa.Active and QResiduiMensa.SearchRecord('ANNO',anno400,[srFromBeginning]) then
      Result:=QResiduiMensa.FieldByName('TICKET').AsInteger;
  except
  end;
end;
function TR450DtM1.GetBuoniPastoAnno(Dato:String):Integer;
begin  //BUONI MENSA MATURATI NELL'ANNO
  Result:=0;
  try
    if (selBuoniPastoTotali.GetVariable('PROGRESSIVO') <> Progress400) or
       (selBuoniPastoTotali.GetVariable('DATA1') <> EncodeDate(Anno400,1,1)) or
       (selBuoniPastoTotali.GetVariable('DATA2') <> R180FineMese(EncodeDate(Anno400,Mese400,1))) then
    begin
      selBuoniPastoTotali.SetVariable('PROGRESSIVO',Progress400);
      selBuoniPastoTotali.SetVariable('DATA1',EncodeDate(Anno400,1,1));
      selBuoniPastoTotali.SetVariable('DATA2',R180FineMese(EncodeDate(Anno400,Mese400,1)));
      selBuoniPastoTotali.Execute;
    end;
    Result:=selBuoniPastoTotali.GetVariable(Dato);
  except
  end;
end;
function TR450DtM1.GetNumeroPastiConv:Integer;
begin  //NUMERO PASTI CONVENZIONATI
  Result:=0;
  try
    if QNumPasti.Active and QNumPasti.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[srFromBeginning]) then
      Result:=QNumPasti.FieldByName('NUMPASTI').AsInteger;
  except
  end;
end;
function TR450DtM1.GetNumeroPastiInteri:Integer;
begin  //NUMERO PASTI INTERI
  Result:=0;
  try
    if QNumPasti.Active and QNumPasti.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[srFromBeginning]) then
      Result:=QNumPasti.FieldByName('NUMPASTI2').AsInteger;
  except
  end;
end;
function TR450DtM1.GetNoteBuoniMensaTicket:string;
begin  //NOTE BUONI PASTO\TICKET
  Result:='';
  try
    if QMaturazioneMensa.Active and QMaturazioneMensa.SearchRecord('ANNO;MESE',VarArrayOf([anno400,mese400]),[srFromBeginning]) then
      Result:=QMaturazioneMensa.FieldByName('NOTE').AsString;
  except
  end;
end;
function TR450DtM1.GetOreAnnoPrec:Integer;
begin  //ORE ANNO PRECEDENTE
  Result:=0;
  try
    if selT130.SearchRecord('ANNO',Anno400,[srFromBeginning]) then
      Result:=R180OreMinutiext(selT130.FieldByName('SALDOORELAV').AsString);
  except
  end;
end;
function TR450DtM1.GetEccCompAnnoPrec:Integer;
begin  //ECCEDENZA SOLO COMPENSABILE ANNO PRECEDENTE
  Result:=0;
  try
    if selT130.SearchRecord('ANNO',Anno400,[srFromBeginning]) then
      Result:=R180OreMinutiext(selT130.FieldByName('ORECOMPENSABILI').AsString);
  except
  end;
end;

function TR450DtM1.GetBancaOreEccedente(StraordAutorizzato:Integer):Integer;
var idx,strpag,abbatt_mensile:Integer;
    S:String;
begin
  Result:=0;
  if Pos('TORINO_CSI_PRV' + #13,Parametri.ModuliInstallati) > 0 then
  begin
    strpag:=0;
    for S in TO_CSI_STR_PAG.Split([',']) do
    begin
      idx:=IndiceRiepPres(S);
      if idx >= 0 then
        strpag:=strpag + R180SommaArray(RiepPres[idx].OreReseMese);
    end;
    abbatt_mensile:=max(0,salmeseatt - StraordAutorizzato);
    Result:=max(0,salannoatt + strpag - TO_CSI_MAX_BANCAORE);
    Result:=max(0,Result - StraordAutorizzato);
    Result:=min(Result,abbatt_mensile);
    (*
    idx:=IndiceRiepPres(TO_CSI_STR_AUT);
    if idx >= 0 then
      Result:=Result - R180SommaArray(RiepPres[idx].OreReseMese);
    *)
  end;
end;

procedure TR450DtM1.R450DtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).CloseAll;
    if Self.Components[i] is TOracleQuery then
      (Self.Components[i] as TOracleQuery).Close;
    end;
  FreeAndNil(selStorico);
  FreeAndNil(lstAssenzeCumuloS);
  FreeAndNil(lstPresenzeCumuloS);
  RiepPres:=nil;
  RiepPresCartellino:=nil;
  RiepAssenzeCumuloS:=nil;
  if R600DtM <> nil then
    FreeAndNil(R600DtM);
end;

end.
