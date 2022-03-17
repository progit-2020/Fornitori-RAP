unit R500Lin;

interface

uses System.SysUtils, Data.DB;

const
  MaxTimbrature = 40;  //Numero massimo di Timbrature per giorno
  MaxGiustif = 20;     //Numero massimo di Giustificativi per giorno
  MaxFasceGio = 12;     //Numero massimo di fasce del giorno
  //MaxFasceGio = 6;     //Numero massimo di fasce del giorno

  //Tipi fascia di T021_FASCEORARI
  TF_PUNTI_NOMINALI = 'PN';
  TF_PM_TIMBRATA = 'PMT';
  TF_PM_AUTO = 'PMA';
  TF_STRAORDINARIO = 'STR';
  TF_OBBLIGATORIA = 'FO';
  TF_MG_MAT = 'MGM';
  TF_MG_POM = 'MGP';

  C_POS_FLAGPO = 15; //Q090-Q060:Posizione - 1 nei campi persistenti di Flag Plus orario

  ARROT_PAUSAMENSA = 'ARRPM';
type
  //////////////////////////////////////////////////////////////////////
  //Tipi per variabili in R502Pro///////////////////////////////////////
  //////////////////////////////////////////////////////////////////////

  trieppres_sv = record
    tcauspres_sv,
    traggpres_sv    :String;
    tminpres_sv     :array [1..10] of Word;
  end;

  TParam = (pData,pProg,pNone);

  //////////////////////////////////////////////////////////////////////////
  //Tipi per variabili in R500Lin.Txt///////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////

  t_FasceInteri = array [1..MaxFasceGio] of Integer;

  t_tanom2riscontrate = record
    ta2puntdesc:Byte;
    ta2caus:String;
    ta2bloccante: Boolean;
  end;

  t_tanom3riscontrate = record
    ta3puntdesc:Byte;
    ta3timb:Integer;
    ta3desc:String;
    ta3param:array of String;
    ta3bloccante: Boolean;
  end;

  t_tfasceorarie = record
    tcodfasc:String;
    tpercfasc:Integer;
    tiniz1fasc:Integer;
    tfine1fasc:Integer;
    tiniz2fasc:Integer;
    tfine2fasc:Integer;
    ttipofasc:Byte; //tipo fascia    = 1 se FER    = 2 se FES    = 3 se SAB
    tposfasc:Byte;  //Posizione sulla tabella delle fasce del mese: usato in R400
    AbbFascia,AbbFasciaBck:Integer;
  end;

  t_ttimbraturecon = record
    ggsucc:Boolean;
    tminutic_e:Integer;
    tminutic_u:Integer;
    tpuntatore:Byte;
    ttipofascia:Byte;  //sembra non usato
    traggcaus:String;
    tcaus:String;
    tinclcaus:String;
    oralegsol:Boolean;
    trilev_e:String;
    trilev_u:String;
  end;

  t_tindennitapresenza = record
    //       1 cella = presenza di ieri per turno notturno competenza E
    //       2 cella = presenza di oggi per turno notturno competenza U
    //       3 cella = presenza di oggi senza cavallo mezzanotte
    tcodindpres:Char;
    tindpres:Single;
  end;

  tCoppiaEU = record
    Tag:String;
    e,u:Integer;
  end;

  tGettoni = record
    Causale:String;
    Minuti: Integer;
  end;

  t_triepgiuspres = record
    tcauspres       :String;
    traggpres       :String;
    CoppiaEU        :array of tCoppiaEU;
    DetPM           :Integer;
    tminpres        :t_FasceInteri;//array [1..MaxFasceGio] of Word;
  end;

  t_trieprilev = record
    rilevatore      :String;
    tminprestot     :Integer;
  end;

  t_triepgiusasse = record
    tcausasse       :String;
    traggasse       :String;
    thhmmasse       :Integer;
    tggasse         :Byte;
    tmezggasse      :Byte;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    ttipomg         :String;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    tminasse        :Integer;
    tminvalasse     :Integer;
    tminvalcompasse :Integer;
    tminfruizasse   :Integer;
    tminresasse     :Integer;
    tminfruitoPaghe :Integer;
    tminresoPaghe   :Integer;
    tfiniretr       :Byte;
    tumisurasse     :String;
    ttipofruiz      :String;
    GiornoDopo      :Boolean;
    DataFamiliare  :TDateTime;
  end;

  //////////////////////////////////////////////////////////////////////////
  //Tipi per variabili in R502wl1.Txt///////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////

  t_tcausale = record
    tcaus       :String;
    tcaus_orig  :String;
    tcaustip    :String;
    tcausrag    :String;
    tcauscodrag :String;
    tcauscon    :String;
    tcausrip    :String;
    tcausioe    :String;
    tcausarr    :ShortInt;
    tcausrpl    :String;
    tcauspiu    :Integer;
    tcausabi    :String;
    tcausMatMensa:String;
    tminminuti  :Integer;
    tmaxminuti  :Integer;
    tOreInsufficenti:String;
    tNonAutorizzate:String;
    tpianrep    :String;
    tLfsCavMez  :String;
  end;

  t_ttimbraturedip = record
    //tentratad.
    tminutid_e    :Integer;
    trilev_e      :String;
    tcausale_e    :t_tcausale;
    tflagarr_e    :String;
    //tuscitad.
    tminutid_u    :Integer;
    trilev_u      :String;
    tcausale_u    :t_tcausale;
    tflagarr_u    :String;
    tpuntnomin    :Byte; //puntatore alla coppia E _ U nominale su cui calcolare: = 0 se fuori orario
    tpuntnominold :Byte;
    oralegsol     :Boolean;
    spezzata      :Boolean;
    inserita      :Boolean;
    tag           :String;
    iOT           :Integer;
    timborig_e    :Integer;
    timborig_u    :Integer;
    tagmodif_e    :String;
    tagmodif_u    :String;
  end;

  tTimbratureOriginali = record
    e,u:Integer;
    ril_e,ril_u,
    caus_e,caus_u:String;
    esiste_e,esiste_u:Boolean;
  end;

  t_ttimbraturenom = record
    tminutin_e    :Integer;
    tpuntre       :Byte;
    //        puntatore E su maschera record per parametri
    //        solo per tipo orario E = 0 se E nominale forzata a 00:00
    tminutin_u    :Integer;
    tpuntru       :Byte;
    //        puntatore U su maschera record per parametri
    //        solo per tipo orario E = 0 se U nominale forzata a 24:00
    EntrataNomPrec:Integer;
    PuntreNomPrec :Byte;
    Flex          :Integer;
    FlexPM        :Integer; //'Di cui' di Flex: la flessibilità dovuta a PM tipo B o D
    Ritardo       :Integer;
  end;

  TTimbratureRilev = record
    Entrata:Integer;
    Uscita:Integer;
    Rilevatore:String;
  end;

  t_tgiustificdipmese = record
    tcausgius     :String;
    tproggius     :Integer;
    ttipogius     :Char;
    ttipomg       :String;
    tdallegius    :TDateTime;
    tallegius     :TDateTime;
    tflscheda     :Char;
    tnotegius     :String;
  end;

  TGiustificativiR600 = record
    causale       :String;
    causale_nuova :String;
    progrcausale  :Integer;
    tipogiust     :Char;
    dalle         :TDateTime;
    alle          :TDateTime;
    hhmmasse      :Integer;
    ggasse        :Byte;
    mezggasse     :Byte;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    tipomg        :String;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    minasse       :Integer;
    minvalasse    :Integer;
    minvalcompasse:Integer;
    minresasse    :Integer;
    puntAssCum    :Integer;
    RichiestaWeb  :Char;
  end;

  TGiustificativiDelGiorno = record
    tcausgius     :String;
    tdallegius    :Integer;
    ttipogius     :Char;
    ttipomg       :String;
    tallegius     :Integer;
    tdatanas      :TDateTime;
  end;

  t_ttimbraturedipmese = record
    toratimb        :TDateTime;
    tversotimb      :Char;
    trilevtimb      :String;
    tflagtimb       :Char;
    tcaustimb       :String;
  end;

  TTimbratureDelGiorno = record
    toratimb        :Integer;
    tversotimb      :Char;
    trilevtimb      :String;
    tflagtimb       :Char;
    tcaustimb       :String;
    tdagiustif      :Boolean;
  end;

  t_tgius_dallealle = record
    tminutida       :Integer;
    tminutia        :Integer;
    tcausdaa        :String;
    tassenza        :Boolean;
    PuntGiustR600   :Integer;
    DataFamiliare   :TDateTime;
  end;

  t_tgius_min = record
    tmin            :Integer;
    tcausore        :String;
    tflore          :Byte;
    tassenza        :Boolean;
    PuntGiustR600   :Integer;
    DataFamiliare   :TDateTime;
  end;

  t_tgius_mgass = record
    tcausmgass      :String;
    ttipomg         :String;
    tflmgass        :Byte;
    tmin            :Integer;
    mmresi          :Integer;
    dalle           :Integer;
    alle            :Integer;
    PuntGiustR600   :Integer;
    DataFamiliare   :TDateTime;
  end;

  t_tgius_ggass = record
    tcausggass      :String;
    tflggass        :Byte;
    tipocumulo      :String;
    mmresi          :Integer;
    PuntGiustR600   :Integer;
    DataFamiliare   :TDateTime;
  end;

  t_tparcaus = record
    l29_0paramet,  //Codice causale
    l29_1paramet,  //Tipo causale: A = Assenza, B = Presenza C = Giustif.
    l29_2paramet,  //Codice Raggruppamento della causale
    l29_Ragg,      //Codice interno Raggruppamento causale (A,B,C,...)
    l29_3paramet, l29_4paramet, l29_5paramet,
    l29_6paramet, l29_7paramet, l29_8paramet, l29_9paramet, l29_10paramet,
    l29_11paramet,l29_12paramet,l29_13paramet,l29_14paramet,l29_15paramet,
    l29_16paramet,l29_17paramet,l29_18paramet,l29_19paramet,l29_20paramet,
    l29_21paramet,l29_22paramet,l29_23paramet,l29_24paramet,l29_25paramet,
    l29_26paramet,l29_27paramet,l29_28paramet,l29_29paramet,l29_30paramet,
    l29_31paramet,l29_32paramet,l29_33paramet,l29_34paramet,l29_35paramet,
    l29_36paramet,l29_37paramet,l29_38paramet,l29_39paramet,l29_40paramet,
    l29_41paramet,l29_42paramet,l29_43paramet,l29_44paramet,l29_45paramet,
    l29_46paramet,l29_47paramet,l29_48paramet,l29_49paramet,l29_50paramet,
    l29_51paramet
    :String;
  end;

  t_tcausalilette = record
    tcodcaus        :String;
    tparcaus        :t_tparcaus;
  end;

  TDatoValore = record
    Dato,Valore:String;
  end;

  TElemento = class
  private
    function GetValore(Dato: String): String;
  public
    Codice:String;
    Decorrenza,DecorrenzaFine:TDateTime;
    Dati:array of TDatoValore;
    constructor Create;
    destructor Destroy; override;
    property Valore[Dato:String]:String read GetValore;
  end;

  TlstElementi = class
  private
    function GetValoreCorrente(Dato: String): String;
  public
    Elementi:array of TElemento;
    IndiceCorrente:Integer;
    constructor Create;
    destructor Destroy; override;
    function  Indice(Codice: String): Integer; overload;
    function  Indice(Codice: String; Data:TDateTime): Integer; overload;
    function  Aggiungi(Codice:String; DataSet:TDataSet; ConsentiDuplicati:Boolean = False):Integer; overload;
    function  Aggiungi(Codice:String; Decorrenza,DecorrenzaFine:TDateTime; DataSet:TDataSet; ConsentiDuplicati:Boolean = False):Integer; overload;
    procedure Svuota;
    property  ValoreCorrente[Dato:String]:String read GetValoreCorrente;
  end;

  TProfilo = array [0..9] of String;
  TSettimane = array [1..50,1..9] of String; //Contiene i profili orari
  t_tprofililetti = record
    Profilo         :TProfilo;
    Settimane       :TSettimane;
    NumSet          :Byte;
  end;

  TContratto   = array[0..20] of String;
  TFasceGiorno = array[0..13] of String;
  t_tcontrattiletti = record
    Contratto       :TContratto;
    FasceGiorno     :array[1..9] of TFasceGiorno;
  end;

  tIndNot = record
    Ore,
    Toll,
    Arr:Integer;
    EccGio:t_FasceInteri;//array[1..4] of Word;
  end;

  tIndFes = record
    Ore,
    Debito:Integer;
    EccGio:t_FasceInteri//array[1..4] of Word;
  end;

  ///////////////////////////////////////////////////////////
  //Tipi per costanti ///////////////////////////////////////
  ///////////////////////////////////////////////////////////

  t_tdescanom = record
    N       :Byte;
    D       :String;
  end;

  t_tdescanom1array = array [1..26] of t_tdescanom;

  t_tdescanom3array = array [1..11] of t_tdescanom;

  t_tdescanom2 = record
    N         :Byte;
    F         :Byte;
      //         flag per dettagli supplementari sull' anomalia
      //         = 0 se solo descrizione
      //         = 1 se indicata anche la causale
    D         :String;
  end;

  t_tdescanom2array = array [1..59] of t_tdescanom2;

  t_traggrcauspr = record
    C       :String;
    D       :String;
  end;

  t_traggrcausprarray = array [1..7] of t_traggrcauspr;

  t_traggrcausas      = array [1..8] of t_traggrcauspr;

const
////////////////////////////////////////////////////////////////////////
//DESCRIZIONI ANOMALIE E MESSAGGI///////////////////////////////////////
////////////////////////////////////////////////////////////////////////

//_________________________________________________________________
//===            Gestione Conteggi   r502wgl                    ===
//_________________________________________________________________
//_________________________________________________________________
//***   Descrizione anomalie del primo livello
  tdescanom1:t_tdescanom1array =
   ((N:01;D:'Causale di presenza non abilitata'),
    (N:02;D:'Timbrature non in sequenza'),
    (N:03;D:'Timbratura con ora errata'),
    (N:04;D:'Dati per conteggio con dipendente non in servizio'),
    (N:05;D:'Intersezione fra timbrature e giustificativi'),
    (N:06;D:'Orario non esistente'),
    (N:07;D:'Turno pianificato non presente nell''orario'),
    (N:08;D:'E in pausa mensa maggiore dell''U dopo arrotondamento'),
    (N:09;D:'Entrata maggiore dell''uscita dopo arrotondamento'),
    (N:10;D:'Dipendente privo di codice contratto nel giorno attuale'),
    (N:11;D:'Contratto non esistente il giorno 01 del mese attuale'),
    (N:12;D:'Mancano le fasce orarie sul contratto'),
    (N:13;D:'Le fasce orarie feriali non coprono l''intera giornata'),
    (N:14;D:'Le fasce orarie festive non coprono l''intera giornata'),
    (N:15;D:'Le fasce orarie sabato non coprono l''intera giornata'),
    (N:16;D:'Dipendente privo di codice monte ore nel giorno attuale'),
    (N:17;D:'Monte ore non esistente'),
    (N:18;D:'Dipendente privo dei giorni lavorat. nel giorno attuale'),
    (N:19;D:'Categoria plus orario non esistente'),
    (N:20;D:'Fasce orarie > 4: non gestibili'),
    (N:21;D:'Calendario non esistente'),
    (N:22;D:'Mancano gg lavorativi di tutto il mese per calcolo P.O.'),
    (N:23;D:'Profilo orario non esistente'),
    (N:24;D:'Unità di misura assenza non esistente'),
    (N:25;D:'Anomalia di 2° livello bloccante'),
    (N:26;D:'Anomalia di 3° livello bloccante')
    )
    ;
//_________________________________________________________________
//*   Descrizione anomalie del secondo livello
  tdescanom2:t_tdescanom2array =
    ((N:01;F:1;D:'causale non esistente; ignorata'),
     (N:02;F:1;D:'causale assenza su timbratura; ignorata'),
     (N:03;F:1;D:'causale non esterna all'' orario; ignorata'),
     (N:04;F:1;D:'causale non abilitata; periodo non conteggiato'),
     (N:05;F:1;D:'causale non interna all'' orario; ignorata'),
     (N:06;F:1;D:'causale priva della corrispondente; ignorata'),
     (N:07;F:1;D:'causale errata nel periodo; ignorata'),
     (N:08;F:1;D:'causale priva della corrispondente; inserita'),
     (N:09;F:1;D:'causale non abilitata; ignorata'),
     (N:10;F:1;D:'causale non accoppiata;periodo non conteggiato'),
     (N:11;F:0;D:'Straordinario non abilitato; non conteggiato'),
     (N:12;F:1;D:'Straordinario < minuti minimi; non conteggiato'),
     (N:13;F:0;D:'Straordinario fuori range; troncato'),
     (N:14;F:0;D:'Inizio straordinario fuori range; ritardato'),
     (N:15;F:1;D:'prolungamento inibito; non conteggiato'),
     (N:16;F:1;D:'caus. non per prolung.;periodo non conteggiato'),
     (N:17;F:1;D:'causale non esistente; giustificativo ignorato'),
     (N:18;F:1;D:'causale di tipo errato;giustificativo ignorato'),
     (N:19;F:1;D:'Straor.del gg < minuti minimi; non conteggiato'),
     (N:20;F:0;D:'Ore lavorate in fascia < minime'),
     (N:21;F:0;D:'Ore lavorate in fascia > massime; troncate'),
     (N:22;F:1;D:'giornata intera di assenza con timbrature'),
     (N:23;F:0;D:'Straord. del gg > minuti massimi; troncato'),
     (N:24;F:1;D:'Intersezione fra timbrature e giustificativi'),
     (N:25;F:1;D:'Timbratura in reperibilità/guardia spostata sul turno pianificato'),
     (N:26;F:1;D:'Timbratura in reperibilità/guardia troncata sul turno pianificato'),//Mai usata??
     (N:27;F:1;D:'Turno di reperibilità/guardia pianificato non esistente'),
     (N:28;F:1;D:'Timbrature in reperibilità/guardia esterne al turno pianificato; ignorate'),
     (N:29;F:1;D:'Timbratura interna al turno di libera professione'),
     (N:30;F:1;D:'Causale esterna al turno di reperibilità/guardia: ignorata'),
     (N:31;F:0;D:'Giorno vuoto'),
     (N:32;F:0;D:'24 ore di servizio'),
     (N:33;F:0;D:'Timbrature a cavallo di mezzanotte'),
     (N:34;F:1;D:'Ore causalizzate troncate'),
     (N:35;F:1;D:'Causale esterna alla fascia di abilitazione: ignorata'),
     (N:36;F:1;D:'Causale spostata nella fascia di abilitazione'),
     (N:37;F:1;D:'Causale esterna alla fascia di abilitazione: timbratura persa'),
     (N:38;F:1;D:'Ore causalizzate inferiori al minimo: causale ignorata'),
     (N:39;F:1;D:'Ore causalizzate inferiori al minimo: timbratura persa'),
     (N:40;F:1;D:'Ore causalizzate inferiori al gettone: causale ignorata'),
     (N:41;F:1;D:'Ore causalizzate inferiori al gettone: timbratura persa'),
     (N:42;F:1;D:'Ore causalizzate superiori al gettone: causale ignorata'),
     (N:43;F:1;D:'Ore causalizzate superiori al gettone: timbratura troncata'),
     (N:44;F:1;D:'Ore causalizzate limitate al debito gg'),
     (N:45;F:1;D:'Turno di prestazioni aggiuntive pianificato non esistente'),
     (N:46;F:1;D:'Timbratura in prestazioni aggiuntive spostata sul turno pianificato'),
     (N:47;F:1;D:'Timbratura in prestazioni aggiuntive troncata sul turno pianificato'),//Mai usata??
     (N:48;F:1;D:'Timbrature in prestazioni aggiuntive esterne al turno pianificato; ignorate'),
     (N:49;F:1;D:'Causale esterna al turno di prestazioni aggiuntive: ignorata'),
     (N:50;F:1;D:'Arrotondamento del giustificativo fallito'),
     (N:51;F:1;D:'Timbratura non in sequenza; ignorata'),
     (N:52;F:1;D:'Entrata maggiore dell''uscita dopo arrotondamento'),
     (N:53;F:1;D:'Detrazione mensa su ore causalizzate'),
     (N:54;F:0;D:'Giorno vuoto su personale turnista'),
     (N:55;F:0;D:'Manca conteggio notte su entrata sul giorno corr.'),
     (N:56;F:0;D:'Manca conteggio notte su entrata sul giorno prec.'),
     (N:57;F:1;D:'Giustificativo prolungato'),
     (N:58;F:1;D:'Giustificativo accorciato'),
     (N:59;F:1;D:'Copertura della carenza oraria')
     );
//_________________________________________________________________
//***   Descrizione anomalie del terzo livello
  tdescanom3:t_tdescanom3array =
    ((N:01;D:'entrata fuori orario'),
     (N:02;D:'uscita fuori orario'),
     (N:03;D:'timbratura con rilevatore errato'),
     (N:04;D:'Compresenza con turno di reperibilità'),
     (N:05;D:'Ore lavorate (%s) < ore minime (%s)'),
     (N:06;D:'Fascia obbligatoria scoperta'),
     (N:07;D:'Tipo di straordinario incompatible con riposi comp. in fasce'),
     (N:08;D:'La causale per riposi comp. in fasce deve essere esclusa dalle ore normali'),
     (N:09;D:'Pausa mensa > della flessibilità massima consentita'),
     (N:10;D:'Assenza da giustificare'),
     (N:11;D:'Fascia lavorativa scoperta')
    );
//_________________________________________________________________
//***   Tabella raggruppamenti fissi causali presenza
  traggrcauspr:t_traggrcausprarray =
    ((C:'A';D:'Straordinario'),
     (C:'B';D:'Plus orario'),
     (C:'C';D:'Reperibilita'),
     (C:'D';D:'Guardia P.S.'),
     (C:'E';D:'Comando prof.'),
     (C:'F';D:'Recupero ore'),
     (C:'G';D:'Prestazioni aggiuntive'));
//_______________________________________________________________
//*   Tabella raggruppamenti fissi causali assenza
  traggrcausas:t_traggrcausas =
    ((C:'A';D:'Ferie'),
     (C:'B';D:'Fest.Soppr.'),
     (C:'C';D:'Perm.Retr.'),
     (C:'D';D:'Perm.non Ret.'),
     (C:'E';D:'Riposi Comp.'),
     (C:'F';D:'Perm.Sindac.'),
     (C:'G';D:'Diritto Stud.'),
     (C:'H';D:'Riposi'));
//_________________________________________________________________
//***   Raggruppamento fisso giustificativi ( Pausa Mensa )
  traggrgius:t_traggrcauspr =
     (C:'B';D:'Pausa mensa');

  re_020:t_tdescanom =
     (N:01;D:'Uscita forzata da anomalia');

implementation

{ TElemento }

constructor TElemento.Create;
begin
  inherited Create;
  SetLength(Dati,0);
end;

destructor TElemento.Destroy;
begin
  SetLength(Dati,0);
  inherited Destroy;
end;

function TElemento.GetValore(Dato: String): String;
var i:Integer;
begin
  Result:='';
  for i:=0 to High(Dati) do
    if Dati[i].Dato.ToUpper = Dato.ToUpper then
    begin
      Result:=Dati[i].Valore;
      Break;
    end;
end;

{ TlstElementi }

constructor TlstElementi.Create;
begin
  inherited Create;
  SetLength(Elementi,0);
  IndiceCorrente:=-1;
end;

destructor TlstElementi.Destroy;
var i:Integer;
begin
  for i:=0 to High(Elementi) do
  begin
    Elementi[i].Free;
    Elementi[i]:=nil;
  end;
  SetLength(Elementi,0);
  inherited Destroy;
end;

function TlstElementi.GetValoreCorrente(Dato: String): String;
begin
  Result:='';
  if IndiceCorrente >= 0 then
    Result:=Elementi[IndiceCorrente].Valore[Dato];
end;

function TlstElementi.Indice(Codice: String): Integer;
var i:Integer;
begin
  Result:=-1;
  for i:=0 to High(Elementi) do
    if Elementi[i].Codice = Codice then
    begin
      Result:=i;
      Break;
    end;
  IndiceCorrente:=Result;
end;

function TlstElementi.Indice(Codice: String; Data:TDateTime): Integer;
var i:Integer;
begin
  Result:=-1;
  for i:=0 to High(Elementi) do
    if (Elementi[i].Codice = Codice) and (Data >= Elementi[i].Decorrenza) and (Data <= Elementi[i].DecorrenzaFine) then
    begin
      Result:=i;
      Break;
    end;
  IndiceCorrente:=Result;
end;

procedure TlstElementi.Svuota;
var i:Integer;
begin
  for i:=0 to High(Elementi) do
  begin
    Elementi[i].Free;
    Elementi[i]:=nil;
  end;
  SetLength(Elementi,0);
end;

function TlstElementi.Aggiungi(Codice: String; DataSet: TDataSet; ConsentiDuplicati:Boolean = False):Integer;
var idx,i:Integer;
begin
  Result:=-1;

  if not ConsentiDuplicati then
  begin
    Result:=Indice(Codice);
    if Result >= 0 then
      exit;
  end;

  SetLength(Elementi,Length(Elementi) + 1);
  idx:=High(Elementi);
  Result:=idx;

  Elementi[idx]:=TElemento.Create;
  Elementi[idx].Codice:=Codice;
  Elementi[idx].Decorrenza:=0;
  Elementi[idx].DecorrenzaFine:=EncodeDate(3999,12,31);
  SetLength(Elementi[idx].Dati,DataSet.FieldCount);
  for i:=0 to DataSet.FieldCount -1 do
  begin
    Elementi[idx].Dati[i].Dato:=DataSet.Fields[i].FieldName;
    Elementi[idx].Dati[i].Valore:=DataSet.Fields[i].AsString;
  end;
end;

function TlstElementi.Aggiungi(Codice: String; Decorrenza, DecorrenzaFine: TDateTime; DataSet: TDataSet; ConsentiDuplicati:Boolean = False):Integer;
var idx:Integer;
begin
  Result:=-1;

  if not ConsentiDuplicati then
  begin
    Result:=Indice(Codice,Decorrenza);
    if Result >= 0 then
      exit;
  end;

  idx:=Aggiungi(Codice,DataSet,True);
  Result:=idx;

  Elementi[idx].Decorrenza:=Decorrenza;
  Elementi[idx].DecorrenzaFine:=DecorrenzaFine;
end;

end.
