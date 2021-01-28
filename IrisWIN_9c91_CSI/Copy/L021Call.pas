unit L021Call;

interface

type
  TFunzioniDisponibili = record
    A,        //Nome dell'applicazione
    S,        //Nome della scheda
    SW,       //Nome della scheda in WEBProject
    N,        //Nome della funzione a Menu
    G:String; //Gruppo di menu
    DI:Boolean; //Dati Individuali: se True viene fatto il controllo da menu che sia selezionata almeno una anagrafica
    T:Integer; //Tag del TMenuItem e eventualmente dello SpeedButton
    F:String; //Nome della funzione/procedura da richiamare
    M:String; //Nome del modulo opzionale criptato su I080
    MIW:String; //Nome del modulo opzionale criptato su I080 al'interno di IrisWEB
    WEB:String; //default nullo, S=aggiunto in webproject
  end;

(*Tag liberi:
(RILPRE)77,78,79,80,81,82,89,
(RILPRE)118,135,147,148,153,154,158,161,181,182,183,184,185,186,187,188,
(RILPRE)200,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,
(RILPRE)235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,
(RILPRE)257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,
(RILPRE)279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,
(STAGIU)346,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,
(STAGIU)374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,
(IRISWEB)447,448,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,
(IRISWEB)466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,
(IRISWEB)488,489,490,491,492,493,494,495,496,497,498,499,
(PAGHE)633-->
(RILPRE CSI)100012-->
(IRISWEB CSI)100405-->
*)

const
  NFComuni = 50;
  NFRilpre = 227;
  NFPaghe  = 140;
  NFStagiu = 84;

  FunzioniDisponibili:array [1..NFComuni + NFRilpre + NFPaghe + NFStagiu] of TFunzioniDisponibili = (

    //FUNZIONI COMUNI

    (A:'IRIS';  S:'A008';SW:'WA008';N:'Aziende/Operatori';                      G:'Amministrazione sistema';       DI:False;T:100;F:'OpenA008Operatori';                    M:''),
    (A:'IRIS';  S:'A008';SW:'WA186';N:'Login dipendenti';                       G:'Amministrazione sistema';       DI:False;T:209;F:'OpenA008LoginDipendente';              M:''),
    (A:'IRIS';  S:'A083';SW:'WA083';N:'Messaggi delle elaborazioni';            G:'Amministrazione sistema';       DI:False;T:201;F:'OpenA083MsgElaborazioni';              M:''),
    (A:'IRIS';  S:'A026';SW:'WA026';N:'Definizione dati liberi';                G:'Amministrazione sistema';       DI:False;T:116;F:'OpenA026DatiLiberi';                   M:''),
    (A:'IRIS';  S:'A044';SW:'WA044';N:'Allineamento dati storici';              G:'Amministrazione sistema';       DI:False;T:20; F:'OpenA044AllineaStorici';               M:''),
    (A:'IRIS';  S:'A099';SW:'WA099';N:'Utility del Database';                   G:'Amministrazione sistema';       DI:False;T:51; F:'OpenA099UtilityDB';                    M:''),
    (A:'IRIS';  S:'A093';SW:'WA093';N:'Monitoraggio tabella di log';            G:'Amministrazione sistema';       DI:False;T:149;F:'OpenA093Operazioni';                   M:'MONITORAGGIO_LOG'),
    (A:'IRIS';  S:'A136';SW:'WA136';N:'Relazioni tra dati anagrafici';          G:'Amministrazione sistema';       DI:False;T:190;F:'OpenA136FRelazioniAnagrafe';           M:''),
    (A:'IRIS';  S:'B007';SW:'WB007';N:'Utility manipolazione dati';             G:'Amministrazione sistema';       DI:False;T:202;F:'OpenB007ManipolazioneDati';            M:''),
    (A:'IRIS';  S:'I010';SW:'WI010';N:'Ridefinizione campi anagrafici';         G:'Amministrazione sistema';       DI:False;T:115;F:'RidefAnag';                            M:''),
    (A:'IRIS';  S:'A008';SW:'WA008';N:'Gestione sicurezza';                     G:'Amministrazione sistema';       DI:False;T:152;F:'OpenA008GestioneSicurezza';            M:''),
    (A:'IRIS';  S:'';    SW:'WA180';N:'Operatori';                              G:'Amministrazione sistema';       DI:False;T:83;                                           M:''; WEB:'S'),
    (A:'IRIS';  S:'';    SW:'WA181';N:'Aziende';                                G:'Amministrazione sistema';       DI:False;T:84;                                           M:''; WEB:'S'),
    (A:'IRIS';  S:'';    SW:'WA182';N:'Permessi';                               G:'Amministrazione sistema';       DI:False;T:85;                                           M:''; WEB:'S'),
    (A:'IRIS';  S:'';    SW:'WA183';N:'Filtro anagrafe';                        G:'Amministrazione sistema';       DI:False;T:86;                                           M:''; WEB:'S'),
    (A:'IRIS';  S:'';    SW:'WA184';N:'Filtro funzioni';                        G:'Amministrazione sistema';       DI:False;T:87;                                           M:''; WEB:'S'),
    (A:'IRIS';  S:'';    SW:'WA185';N:'Filtro dizionario';                      G:'Amministrazione sistema';       DI:False;T:88;                                           M:''; WEB:'S'),
    (A:'IRIS';  S:'';    SW:'WA187';N:'Accessi';                                G:'Amministrazione sistema';       DI:False;T:90;                                           M:''; WEB:'S'),
    (A:'IRIS';  S:'A005';SW:'WA005';N:'Dati liberi non storicizzati';           G:'Ambiente';                      DI:False;T:114;F:'OpenA005Tabelle';                      M:''),
    (A:'IRIS';  S:'A011';SW:'WA011';N:'Enti locali';                            G:'Ambiente';                      DI:False;T:530;F:'OpenA011ComuniProvinceRegioni';        M:''),
    (A:'IRIS';  S:'A016';SW:'WA016';N:'Causali di assenza';                     G:'Ambiente';                      DI:False;T:105;F:'OpenA016CausAssenze';                  M:''),
    (A:'IRIS';  S:'A017';SW:'WA017';N:'Raggruppamenti di assenza';              G:'Ambiente';                      DI:False;T:106;F:'OpenA017RaggrAsse';                    M:''),
    (A:'IRIS';  S:'A084';SW:'WA084';N:'Tipi di rapporto';                       G:'Ambiente';                      DI:False;T:143;F:'OpenA084TipoRapporto';                 M:''),
    (A:'IRIS';  S:'A115';SW:'WA115';N:'Dati liberi storicizzati';               G:'Ambiente';                      DI:False;T:167;F:'OpenA115DatiLiberiStoricizzati';       M:''),
    (A:'IRIS';  S:'A142';SW:'WA142';N:'Qualifiche ministeriali';                G:'Ambiente';                      DI:False;T:191;F:'OpenA142FQualificaMinisteriale';       M:''),
    (A:'IRIS';  S:'A150';SW:'WA150';N:'Accorpamenti causali di assenza';        G:'Ambiente';                      DI:False;T:196;F:'OpenA150AccorpamentoCausali';          M:''),
    (A:'IRIS';  S:'A002';SW:'WA002';N:'Scheda anagrafica';                      G:'Personale';                     DI:False;T:0;  F:'Anagrafico';                           M:''),
    (A:'IRIS';  S:'A004';SW:'WA004';N:'Giustificativi ass./pres.';              G:'Personale';                     DI:True ;T:2;  F:'OpenA004GiustifAssPres';               M:''),
    (A:'IRIS';  S:'A078';SW:'WA078';N:'Richiesta di assistenza';                G:'Personale';                     DI:False;T:45; F:'OpenA078EsportaDatiInd';               M:''),
    (A:'IRIS';  S:'A082';SW:'WA082';N:'Centri di costo percentualizzati';       G:'Personale';                     DI:True ;T:162;F:'OpenA082CdcPercent';                   M:''),
    (A:'IRIS';  S:'A146';SW:'WA146';N:'Foto del dipendente';                    G:'Personale';                     DI:True ;T:67 ;F:'OpenA146FotoDipendente';               M:''),
    (A:'IRIS';  S:'S031';SW:'WS031';N:'Familiari';                              G:'Personale';                     DI:True ;T:303;F:'OpenS031Familiari';                    M:''),
    (A:'IRIS';  S:'P430';SW:'WP430';N:'Anagrafica stipendi';                    G:'Personale';                     DI:True ;T:503;F:'OpenP430FAnagrafico'),
    (A:'IRIS';  S:'A045';SW:'WA045';N:'Statistica ministeriale assenze';        G:'Elaborazioni';                  DI:False;T:595;F:'OpenA045StatAssenze';                  M:''),
    (A:'IRIS';  S:'A061';SW:'WA061';N:'Elenco assenze individuali';             G:'Elaborazioni';                  DI:False;T:30; F:'OpenA061DettAssenze';                  M:''),
    (A:'IRIS';  S:'A062';SW:'WA062';N:'Interrogazioni di servizio';             G:'Elaborazioni';                  DI:False;T:31; F:'OpenA062QueryServizio';                M:''),
    (A:'IRIS';  S:'A092';SW:'WA092';N:'Elenco movimenti storici';               G:'Elaborazioni';                  DI:False;T:42; F:'OpenA092StampaStorico';                M:''),
    (A:'IRIS';  S:'A105';SW:'WA105';N:'Storico giustificativi';                 G:'Elaborazioni';                  DI:False;T:6;  F:'OpenA105StoricoGiustificativi';        M:''),
    (A:'IRIS';  S:'A002';SW:'WA197';N:'Layout scheda anagrafica';               G:'Amministrazione sistema';       DI:False;T:151;F:'LayoutSchedaAnagrafica';               M:''),
    (A:'IRIS';  S:'';    SW:'WA198';N:'Dati calcolati';                         G:'Elaborazioni';                  DI:False;T:73;                                           M:''; WEB:'S'),
    (A:'FUNWEB';S:'W002';SW:'';     N:'Scheda anagrafica';                      G:'Funzioni WEB';                  DI:False;T:412; F:'OpenW002AnagrafeScheda';              M:'IRIS_WEB'),
    (A:'FUNWEB';S:'W007';SW:'';     N:'Gestione sicurezza';                     G:'Funzioni WEB';                  DI:False;T:415; F:'OpenW007GestioneSicurezza';           M:'IRIS_WEB'),
    (A:'FUNWEB';S:'W008';SW:'';     N:'Gestione giustificativi';                G:'Funzioni WEB';                  DI:False;T:401; F:'OpenW008Giustificativi';              M:'IRIS_WEB'),
    (A:'FUNWEB';S:'W015';SW:'';     N:'Generatore di stampe';                   G:'Funzioni WEB';                  DI:False;T:414; F:'OpenW015GeneratoreStampe';            M:'IRIS_WEB'),
    (A:'FUNWEB';S:'W019';SW:'';     N:'Gestione deleghe';                       G:'Funzioni WEB';                  DI:False;T:420; F:'OpenW019GestioneDeleghe';             M:'IRIS_WEB'),
    (A:'FUNWEB';S:'W020';SW:'';     N:'Cambio profilo';                         G:'Funzioni WEB';                  DI:False;T:421; F:'OpenW020CambioProfilo';               M:'IRIS_WEB'),
    (A:'FUNWEB';S:'W034';SW:'';     N:'Pubblicazione documenti';                G:'Funzioni WEB';                  DI:False;T:444; F:'OpenW034PubblicazioneDocumenti';      M:'IRIS_WEB';MIW:'PUBBL_DOCUMENTI_ESTERNI'),
    (A:'FUNWEB';S:'W040';SW:'';     N:'Upload documenti';                       G:'Funzioni WEB';                  DI:False;T:449; F:'OpenW040UploadDocumenti';             M:'IRIS_WEB';MIW:'PUBBL_DOCUMENTI_ESTERNI'),
    (A:'FUNWEB';S:'W035';SW:'';     N:'Messaggistica';                          G:'Funzioni WEB';                  DI:False;T:445; F:'OpenW035Messaggistica';               M:'IRIS_WEB';MIW:'MESSAGGISTICA'),
    (A:'FUNWEB';S:'Wc38';SW:'';     N:'Bollatrice virtuale';                    G:'Funzioni WEB';                  DI:False;T:100075;  F:'OpenWc38BollatriceVirtuale';      M:'IRIS_WEB'),
    (A:'FUNWEB';S:'Wc41';SW:'';     N:'Interrogazioni di servizio';             G:'Funzioni WEB';                  DI:False;T:100404;  F:'OpenWc41QueryServizio';           M:'IRIS_WEB'),

    //RILEVAZIONE PRESENZE

    (A:'RILPRE';S:'A023';SW:'WA023';N:'Cartellino interattivo';                 G:'Personale';                     DI:True ;T:7;  F:'OpenA023Timbrature';                   M:''),
    (A:'RILPRE';S:'A029';SW:'WA029';N:'Scheda riepilogativa';                   G:'Personale';                     DI:True ;T:10; F:'OpenA029SchedaRiepil';                 M:''),
    (A:'RILPRE';S:'A030';SW:'WA030';N:'Residui anno precedente';                G:'Personale';                     DI:True ; T:11; F:'OpenA030Residui';                     M:''),
    (A:'RILPRE';S:'A117';SW:'WA117';N:'Assestamento ore anni precedenti';       G:'Personale';                     DI:True ;T:168;F:'OpenA117OreLiquidateAnniPrec';         M:''),
    (A:'RILPRE';S:'Ac09';SW:'';     N:'Indennità di funzione';                  G:'Personale';                     DI:False;T:100011;F:'OpenAc09IndFunzione';               M:''),
    (A:'RILPRE';S:'A010';SW:'WA010';N:'Competenze assenze individuali';         G:'Personale';                     DI:True ;T:4;  F:'OpenA010ProfAsseInd';                  M:''),
    (A:'RILPRE';S:'A013';SW:'WA013';N:'Calendario individuale';                 G:'Personale';                     DI:True ;T:1;  F:'OpenA013CalendIndiv';                  M:''),
    (A:'RILPRE';S:'A015';SW:'WA015';N:'Debiti aggiuntivi individuali';          G:'Personale';                     DI:True ;T:3;  F:'OpenA015PlusOraIndiv';                 M:''),
    (A:'RILPRE';S:'A025';SW:'WA025';N:'Pianificazioni giornaliere';             G:'Personale';                     DI:True ;T:8;  F:'OpenA025Pianif';                       M:''),
    (A:'RILPRE';S:'A033';SW:'WA033';N:'Stampa anomalie';                        G:'Elaborazioni';                  DI:False;T:12; F:'OpenA033StampaAnomalie';               M:''),
    (A:'RILPRE';S:'A027';SW:'WA027';N:'Cartellino mensile';                     G:'Elaborazioni';                  DI:False;T:9;  F:'OpenA027CarMen';                       M:''),
    (A:'RILPRE';S:'A126';SW:'WA126';N:'Sicurezza riepiloghi';                   G:'Elaborazioni';                  DI:False;T:59; F:'OpenA126BloccoRiepiloghi';             M:''),
    (A:'RILPRE';S:'A041';SW:'WA041';N:'Inserimento automatico riposi';          G:'Elaborazioni';                  DI:False;T:17; F:'OpenA041InsRiposi';                    M:''),
    (A:'RILPRE';S:'A075';SW:'WA075';N:'Passaggio di anno';                      G:'Elaborazioni';                  DI:False;T:37; F:'OpenA075FineAnno';                     M:''),
    (A:'RILPRE';S:'A077';SW:'WA077';N:'Generatore di stampe';                   G:'Elaborazioni';                  DI:False;T:139;F:'OpenA077GeneratoreStampe';             M:''),
    (A:'RILPRE';S:'A042';SW:'WA042';N:'Stampe analitiche presenze/assenze';     G:'Elaborazioni';                  DI:False;T:18; F:'OpenA042StampaPreAsse';                M:''),
    (A:'RILPRE';S:'A051';SW:'WA051';N:'Stampa timbrature originali';            G:'Elaborazioni';                  DI:False;T:26; F:'OpenA051TimbOrig';                     M:''),
    (A:'RILPRE';S:'A079';SW:'WA079';N:'Inserimento automatico assenze';         G:'Elaborazioni';                  DI:False;T:38; F:'OpenA079AssenzeAuto';                  M:''),
    (A:'RILPRE';S:'A108';SW:'WA108';N:'Compensazione giornaliera automatica';   G:'Elaborazioni';                  DI:False;T:54; F:'OpenA108InsAssAuto';                   M:''),
    (A:'RILPRE';S:'Ac08';SW:'';     N:'Calcolo indennità di funzione';          G:'Elaborazioni';                  DI:False;T:100010;F:'OpenAc08RegistraIndFunzione';       M:''),
    (A:'RILPRE';S:'A090';SW:'WA090';N:'Scheda annuale assenze';                 G:'Elaborazioni';                  DI:False;T:41; F:'OpenA090AssenzeAnno';                  M:''),
    (A:'RILPRE';S:'A004';SW:'WA004';N:'Inserimento giustificativi collettivi';  G:'Elaborazioni';                  DI:False;T:47; F:'OpenA004GiustifGruppo';                M:''),
    (A:'RILPRE';S:'A091';SW:'WA091';N:'Liquidazione ore causalizzate';          G:'Elaborazioni';                  DI:False;T:48; F:'OpenA091LiquidPresenze';               M:''),
    (A:'RILPRE';S:'A116';SW:'WA116';N:'Liquidazione ore anni precedenti';       G:'Elaborazioni';                  DI:False;T:169;F:'OpenA116LiquidazioneOreAnniPrec';      M:''),
    (A:'RILPRE';S:'A173';SW:'WA173';N:'Importazione assestamento ore';          G:'Elaborazioni';                  DI:False;T:208;F:'OpenA173FImportAssestamento';          M:''),
    (A:'RILPRE';S:'A081';SW:'WA081';N:'Elenco timbrature causalizzate';         G:'Elaborazioni';                  DI:False;T:141;F:'OpenA081TimbCaus';                     M:''),
    (A:'RILPRE';S:'A012';SW:'WA012';N:'Calendari';                              G:'Ambiente';                      DI:False;T:101;F:'OpenA012Calendari';                    M:''),
    (A:'RILPRE';S:'A014';SW:'WA014';N:'Debiti aggiuntivi';                      G:'Ambiente';                      DI:False;T:102;F:'OpenA014PlusOrario';                   M:''),
    (A:'RILPRE';S:'A024';SW:'WA024';N:'Indennità di presenza';                  G:'Ambiente';                      DI:False;T:112;F:'OpenA024IndPresenza';                  M:''),
    (A:'RILPRE';S:'Ac07';SW:'';     N:'Regole indennità di funzione';           G:'Ambiente';                      DI:False;T:100009;F:'OpenAc07RegoleIndFunzione';         M:''),
    (A:'RILPRE';S:'A006';SW:'WA006';N:'Modelli orario';                         G:'Ambiente';                      DI:False;T:103;F:'OpenA006ModelliOrario';                M:''),
    (A:'RILPRE';S:'A007';SW:'WA007';N:'Profili orario';                         G:'Ambiente';                      DI:False;T:113;F:'OpenA007ProfiliOrari';                 M:''),
    (A:'RILPRE';S:'A022';SW:'WA022';N:'Contratti';                              G:'Ambiente';                      DI:False;T:111;F:'OpenA022Contratti';                    M:''),
    (A:'RILPRE';S:'A009';SW:'WA009';N:'Profili assenze annuali';                G:'Ambiente';                      DI:False;T:104;F:'OpenA009ProfiliAsse';                  M:''),
    (A:'RILPRE';S:'A020';SW:'WA020';N:'Causali di presenza';                    G:'Ambiente';                      DI:False;T:107;F:'OpenA020CausPresenze';                 M:''),
    (A:'RILPRE';S:'A018';SW:'WA018';N:'Raggruppamenti di presenza';             G:'Ambiente';                      DI:False;T:108;F:'OpenA018RaggrPres';                    M:''),
    (A:'RILPRE';S:'A021';SW:'WA021';N:'Causali di giustificazione';             G:'Ambiente';                      DI:False;T:109;F:'OpenA021CausGiustif';                  M:''),
    (A:'RILPRE';S:'A019';SW:'WA019';N:'Raggruppamenti di giustificazione';      G:'Ambiente';                      DI:False;T:110;F:'OpenA019RaggrGiustif';                 M:''),
    (A:'RILPRE';S:'A107';SW:'WA107';N:'Regole compensazione giornaliera';       G:'Ambiente';                      DI:False;T:163;F:'OpenA107InsAssAutoRegole';             M:''),
    (A:'RILPRE';S:'A141';SW:'WA141';N:'Regole inserimento riposi';              G:'Ambiente';                      DI:False;T:176;F:'OpenA141RegoleRiposi';                 M:''),
    (A:'RILPRE';S:'A076';SW:'WA076';N:'Indennità di presenza associate';        G:'Ambiente';                      DI:False;T:138;F:'OpenA076IndGruppo';                    M:''),
    (A:'RILPRE';S:'A080';SW:'WA080';N:'Tipologie cartellini';                   G:'Ambiente';                      DI:False;T:142;F:'OpenA080ModConte';                     M:''),
    (A:'RILPRE';S:'A085';SW:'WA085';N:'Part-time';                              G:'Ambiente';                      DI:False;T:144;F:'OpenA085PartTime';                     M:''),
    (A:'RILPRE';S:'P130';SW:'WP130';N:'Modalità di pagamento';                  G:'Ambiente';                      DI:False;T:514;F:'OpenP130FPagamenti';                   M:''),
    (A:'RILPRE';S:'P150';SW:'WP150';N:'Configurazione dati economici';          G:'Ambiente';                      DI:False;T:520;F:'OpenP150FSetup';                       M:''),
    (A:'RILPRE';S:'P030';SW:'WP030';N:'Valute';                                 G:'Ambiente';                      DI:False;T:517;F:'OpenP030FValute';                      M:''),
    (A:'RILPRE';S:'P050';SW:'WP050';N:'Arrotondamenti valute';                  G:'Ambiente';                      DI:False;T:519;F:'OpenP050FArrotondamenti';              M:''),
    (A:'RILPRE';S:'P032';SW:'WP032';N:'Cambi valute';                           G:'Ambiente';                      DI:False;T:518;F:'OpenP032FCambi';                       M:''),
    (A:'RILPRE';S:'A052';SW:'WA052';N:'Parametrizzazione stampa del cartellino';G:'Ambiente';                      DI:False;T:125;F:'OpenA052ParCar';                       M:''),
    (A:'RILPRE';S:'A109';SW:'WA109';N:'Loghi aziendali';                        G:'Ambiente';                      DI:False;T:164;F:'OpenA109Immagini';                     M:''),
    (A:'RILPRE';S:'P501';SW:'WP501';N:'Configurazione dati aziendali';          G:'Ambiente';                      DI:False;T:543;F:'OpenP501FCudSetup';                    M:''),
    (A:'RILPRE';S:'A101';SW:'';     N:'Raggruppamenti interrogazioni di servizio';G:'Ambiente';                    DI:False;T:52; F:'OpenA101RaggrInterrogazioni';          M:''),
    (A:'RILPRE';S:'A034';SW:'WA034';N:'Attivazione voci variabili';             G:'Interfacce/Scarico paghe';      DI:False;T:121;F:'OpenA034IntPaghe';                     M:''),
    (A:'RILPRE';S:'A035';SW:'WA035';N:'Regole scarico paghe';                   G:'Interfacce/Scarico paghe';      DI:False;T:122;F:'OpenA035ParScarico';                   M:''),
    (A:'RILPRE';S:'A037';SW:'WA037';N:'Scarico paghe';                          G:'Interfacce/Scarico paghe';      DI:False;T:13; F:'OpenA037ScaricoPaghe';                 M:''),
    (A:'RILPRE';S:'A038';SW:'WA038';N:'Voci variabili scaricate';               G:'Interfacce/Scarico paghe';      DI:False;T:14; F:'OpenA038VociVariabili';                M:''),
    (A:'RILPRE';S:'A031';SW:'WA031';N:'Regole acquisizione timbrature';         G:'Interfacce/Timbrature';         DI:False;T:119;F:'OpenA031ParScarico';                   M:''),
    (A:'RILPRE';S:'A032';SW:'WA032';N:'Acquisizione timbrature';                G:'Interfacce/Timbrature';         DI:False;T:120;F:'OpenA032Scarico';                      M:''),
    (A:'RILPRE';S:'A060';SW:'WA060';N:'Timbrature irregolari';                  G:'Interfacce/Timbrature';         DI:False;T:130;F:'OpenA060TimbIrregolari';               M:''),
    (A:'RILPRE';S:'A050';SW:'WA050';N:'Orologi di timbratura';                  G:'Interfacce/Timbrature';         DI:False;T:124;F:'OpenA050Orologi';                      M:''),
    (A:'RILPRE';S:'A125';SW:'WA125';N:'Badge di servizio';                      G:'Interfacce/Timbrature';         DI:False;T:172;F:'OpenA125BadgeServizio';                M:''),
    (A:'RILPRE';S:'A130';SW:'WA130';N:'Cambio ora legale/solare';               G:'Interfacce/Timbrature';         DI:False;T:178;F:'OpenA130OraLegaleSolare';              M:''),
    (A:'RILPRE';S:'Bc06';SW:'';     N:'Monitor B006';                           G:'Interfacce/Timbrature';         DI:False;T:76; F:'OpenBc06MonitorB006';                  M:''),
    (A:'RILPRE';S:'A102';SW:'WA102';N:'Regole acquisizione giustificativi';     G:'Interfacce/Giustificativi';     DI:False;T:159;F:'OpenA102ParScaricoGiust';              M:''),
    (A:'RILPRE';S:'A103';SW:'WA103';N:'Acquisizione giustificativi';            G:'Interfacce/Giustificativi';     DI:False;T:160;F:'OpenA103ScaricoGiust';                 M:''),
    (A:'RILPRE';S:'A086';SW:'WA086';N:'Causali per iter autorizzativi';         G:'Interfacce/IrisWeb';            DI:False;T:203;F:'OpenA086MotivazioniRichieste';         M:''),
    (A:'RILPRE';S:'A118';SW:'WA118';N:'Pubblicazione documenti';                G:'Interfacce/IrisWeb';            DI:False;T:210;F:'OpenA118PubblicazioneDocumenti';       M:'PUBBL_DOCUMENTI_ESTERNI'),
    (A:'RILPRE';S:'Ac03';SW:'';     N:'Validazione cartellino';                 G:'Interfacce/IrisWeb';            DI:False;T:100005;F:'OpenAc03FValidazioneCartellino';    M:''),
    (A:'RILPRE';S:'A119';SW:'WA119';N:'Partecipazione scioperi';                G:'Assenteismo/Scioperi';          DI:False;T:21; F:'OpenA119Scioperi';                     M:'ASSENTEISMO'),
    (A:'RILPRE';S:'A028';SW:'WA028';N:'Conteggi giornalieri';                   G:'Personale';                     DI:False;T:5;  F:'OpenA028Sc';                           M:''),

    //Funzioni WEB
    (A:'RILPRE';S:'W005';SW:'';     N:'Cartellino interattivo';                 G:'Funzioni WEB';                  DI:False;T:400; F:'OpenW005Cartellino';                  M:'IRIS_WEB'),
    (A:'RILPRE';S:'W003';SW:'';     N:'Elenco anomalie';                        G:'Funzioni WEB';                  DI:False;T:402; F:'OpenW003Anomalie';                    M:'IRIS_WEB'),
    (A:'RILPRE';S:'W004';SW:'';     N:'Pianificazione reperibilità';            G:'Funzioni WEB';                  DI:False;T:403; F:'OpenW004Reperibilita';                M:'IRIS_WEB';MIW:'PIANIFICAZIONE_REPERIBILITA'),
    (A:'RILPRE';S:'W006';SW:'';     N:'Elenco reperibili';                      G:'Funzioni WEB';                  DI:False;T:404; F:'OpenW006ListaReperibili';             M:'IRIS_WEB'),
    (A:'RILPRE';S:'W009';SW:'';     N:'Stampa cartellino';                      G:'Funzioni WEB';                  DI:False;T:405; F:'OpenW009StampaCartellino';            M:'IRIS_WEB'),
    (A:'RILPRE';S:'W009';SW:'';     N:'Validazione cartellino';                 G:'Funzioni WEB';                  DI:False;T:442; F:'OpenW009ValidazioneCartellino';       M:'IRIS_WEB'),
    (A:'RILPRE';S:'W010';SW:'';     N:'Richiesta giustificativi';               G:'Funzioni WEB';                  DI:False;T:406; F:'OpenW010RichiestaAssenze';            M:'IRIS_WEB'),
    (A:'RILPRE';S:'W010';SW:'';     N:'Autorizzazione giustificativi';          G:'Funzioni WEB';                  DI:False;T:407; F:'OpenW010AutorizzAssenze';             M:'IRIS_WEB'),
    (A:'RILPRE';S:'W011';SW:'';     N:'Notifiche delle elaborazioni';           G:'Funzioni WEB';                  DI:False;T:408; F:'OpenW011NotificheElaborazioni';       M:'IRIS_WEB'),
    (A:'RILPRE';S:'W016';SW:'';     N:'Accessi mensa';                          G:'Funzioni WEB';                  DI:False;T:416; F:'OpenW016AccessiMensa';                M:'IRIS_WEB'),
    (A:'RILPRE';S:'W018';SW:'';     N:'Richiesta modifica timbrature';          G:'Funzioni WEB';                  DI:False;T:418; F:'OpenW018RichiestaTimbrature';         M:'IRIS_WEB'),
    (A:'RILPRE';S:'W018';SW:'';     N:'Autorizzazione modifica timbrature';     G:'Funzioni WEB';                  DI:False;T:419; F:'OpenW018RichiestaTimbrature';         M:'IRIS_WEB'),
    (A:'RILPRE';S:'W022';SW:'';     N:'Scheda di valutazione';                  G:'Funzioni WEB';                  DI:False;T:423; F:'OpenW022SchedaValutazioni';           M:'IRIS_WEB';MIW:'VALUTAZIONI'),
    (A:'RILPRE';S:'W022';SW:'';     N:'Scheda di autovalutazione';              G:'Funzioni WEB';                  DI:False;T:424; F:'OpenW022SchedaAutovalutazioni';       M:'IRIS_WEB';MIW:'VALUTAZIONI'),
    (A:'RILPRE';S:'W023';SW:'';     N:'Pianificazioni giornaliere';             G:'Funzioni WEB';                  DI:False;T:425; F:'OpenW023PianifOrari';                 M:'IRIS_WEB'),
    (A:'RILPRE';S:'W024';SW:'';     N:'Richiesta straordinari';                 G:'Funzioni WEB';                  DI:False;T:426; F:'OpenW024RichiestaStraordinari';       M:'IRIS_WEB'),
    (A:'RILPRE';S:'W024';SW:'';     N:'Autorizzazione straordinari';            G:'Funzioni WEB';                  DI:False;T:427; F:'OpenW024RichiestaStraordinari';       M:'IRIS_WEB'),
    (A:'RILPRE';S:'W025';SW:'';     N:'Richiesta cambio orario';                G:'Funzioni WEB';                  DI:False;T:430; F:'OpenW025RichiestaCambioOrario';       M:'IRIS_WEB'),
    (A:'RILPRE';S:'W025';SW:'';     N:'Autorizzazione cambio orario';           G:'Funzioni WEB';                  DI:False;T:431; F:'OpenW025RichiestaCambioOrario';       M:'IRIS_WEB'),
    (A:'RILPRE';S:'W026';SW:'';     N:'Richiesta ecced. giornaliere';           G:'Funzioni WEB';                  DI:False;T:432; F:'OpenW026RichiestaStraordGiornaliero'; M:'IRIS_WEB'),
    (A:'RILPRE';S:'W026';SW:'';     N:'Autorizzazione ecced. giornaliere';      G:'Funzioni WEB';                  DI:False;T:433; F:'OpenW026RichiestaStraordGiornaliero'; M:'IRIS_WEB'),
    (A:'RILPRE';S:'W028';SW:'';     N:'Chiamate in reperibilità';               G:'Funzioni WEB';                  DI:False;T:435; F:'OpenW028ChiamateReperibili';          M:'IRIS_WEB';MIW:'PIANIFICAZIONE_REPERIBILITA'),
    (A:'RILPRE';S:'W029';SW:'';     N:'Pesature individuali';                   G:'Funzioni WEB';                  DI:False;T:436; F:'OpenW029PesatureIndividuali';         M:'IRIS_WEB';MIW:'INCENTIVI'),
    (A:'RILPRE';S:'W033';SW:'';     N:'Prospetto assenze';                      G:'Funzioni WEB';                  DI:False;T:437; F:'OpenW033ProspettoAssenze';            M:'IRIS_WEB'),
    (A:'RILPRE';S:'W030';SW:'';     N:'Tabellone turni';                        G:'Funzioni WEB';                  DI:False;T:438; F:'OpenW030TabelloneTurni';              M:'IRIS_WEB';MIW:'PIANIFICAZIONE_ORARI'),
    (A:'RILPRE';S:'W031';SW:'';     N:'Schede quantitative individuali';        G:'Funzioni WEB';                  DI:False;T:439; F:'OpenW031SchedeQuantIndividuali';      M:'IRIS_WEB';MIW:'INCENTIVI'),
    (A:'RILPRE';S:'W032';SW:'';     N:'Richiesta missioni';                     G:'Funzioni WEB';                  DI:False;T:440; F:'OpenW032RichiestaMissioni';           M:'IRIS_WEB';MIW:'MISSIONI_TRASFERTE_WEB'),
    (A:'RILPRE';S:'W032';SW:'';     N:'Autorizzazione missioni';                G:'Funzioni WEB';                  DI:False;T:441; F:'OpenW032RichiestaMissioni';           M:'IRIS_WEB';MIW:'MISSIONI_TRASFERTE_WEB'),
    (A:'RILPRE';S:'W022';SW:'';     N:'Stampa scheda di valutazione';           G:'Funzioni WEB';                  DI:False;T:443; F:'OpenW022StampaSchedaValutazioni';     M:'IRIS_WEB';MIW:'VALUTAZIONI'),
    (A:'RILPRE';S:'W037';SW:'';     N:'Notifica adesione scioperi';             G:'Funzioni WEB';                  DI:False;T:428; F:'OpenW037RichiestaScioperi';           M:'IRIS_WEB';MIW:'ASSENTEISMO'),
    (A:'RILPRE';S:'W037';SW:'';     N:'Autorizzazione adesione scioperi';       G:'Funzioni WEB';                  DI:False;T:429; F:'OpenW037RichiestaSscioperi';          M:'IRIS_WEB';MIW:'ASSENTEISMO'),
    (A:'RILPRE';S:'Wc01';SW:'';     N:'Richiesta rendicontazione progetti';     G:'Funzioni WEB';                  DI:False;T:100401; F:'OpenWc01RichiestaRendiProj';       M:'IRIS_WEB'),
    (A:'RILPRE';S:'Wc01';SW:'';     N:'Autorizzazione rendicontazione progetti';G:'Funzioni WEB';                  DI:False;T:100402; F:'OpenWc01RichiestaRendiProj';       M:'IRIS_WEB'),
    (A:'RILPRE';S:'Wc10';SW:'';     N:'Scelta festività';                       G:'Funzioni WEB';                  DI:False;T:100403; F:'OpenWc10FestivitaParticolari';     M:'IRIS_WEB'),
    //Reperibilita
    (A:'RILPRE';S:'A039';SW:'WA039';N:'Regole turni di reperibilità/guardia';   G:'Reperibilità/Guardia';          DI:False;T:123;F:'OpenA039RegReperib';                   M:'PIANIFICAZIONE_REPERIBILITA'),
    (A:'RILPRE';S:'A147';SW:'WA147';N:'Vincoli pianificazione reperibilità';    G:'Reperibilità/Guardia';          DI:False;T:68; F:'OpenA147RepVincoliIndividuali';        M:'PIANIFICAZIONE_REPERIBILITA'),
    (A:'RILPRE';S:'A147';SW:'WA147';N:'Vincoli pianificazione guardia';         G:'Reperibilità/Guardia';          DI:False;T:69; F:'OpenA147GuardiaVincoliIndividuali';    M:'PIANIFICAZIONE_REPERIBILITA'),
    (A:'RILPRE';S:'Ac06';SW:'';     N:'Priorità di chiamata reperibilità';      G:'Reperibilità/Guardia';          DI:False;T:100008;F:'OpenAc06PianifPrioritaChiamata';    M:'PIANIFICAZIONE_REPERIBILITA'),
    (A:'RILPRE';S:'A040';SW:'WA040';N:'Pianificazione turni reperibilità';      G:'Reperibilità/Guardia';          DI:True ;T:16; F:'OpenA040PianifRep';                    M:'PIANIFICAZIONE_REPERIBILITA'),
    (A:'RILPRE';S:'A040';SW:'WA040';N:'Pianificazione turni guardia';           G:'Reperibilità/Guardia';          DI:True ;T:63; F:'OpenA040PianifGuardia';                M:'PIANIFICAZIONE_REPERIBILITA'),
    (A:'RILPRE';S:'A043';SW:'WA043';N:'Cartolina reperibilità';                 G:'Reperibilità/Guardia';          DI:False;T:19; F:'OpenA043StampaRep';                    M:'PIANIFICAZIONE_REPERIBILITA'),
    (A:'RILPRE';S:'A067';SW:'WA067';N:'Turni di reperibilità sostitutivi';      G:'Reperibilità/Guardia';          DI:False;T:32; F:'OpenA067RepSostB';                     M:'PIANIFICAZIONE_REPERIBILITA'),
    (A:'RILPRE';S:'A036';SW:'WA036';N:'Riepilogo turni di reperibilità';        G:'Reperibilità/Guardia';          DI:True ;T:15; F:'OpenA036TurniRep';                     M:''),
    //Turni
    (A:'RILPRE';S:'A054';SW:'WA054';N:'Cicli';                                  G:'Pianificazione turni';          DI:False;T:126;F:'OpenA054CicliTurni';                   M:'PIANIFICAZIONE_ORARI'),
    (A:'RILPRE';S:'A055';SW:'WA055';N:'Turnazioni dei cicli';                   G:'Pianificazione turni';          DI:False;T:127;F:'OpenA055Turnazioni';                   M:'PIANIFICAZIONE_ORARI'),
    (A:'RILPRE';S:'A053';SW:'WA053';N:'Squadre';                                G:'Pianificazione turni';          DI:False;T:128;F:'OpenA053Squadre';                      M:'PIANIFICAZIONE_ORARI'),
    (A:'RILPRE';S:'A056';SW:'WA056';N:'Assegnazione turnazioni';                G:'Pianificazione turni';          DI:True ;T:22; F:'OpenA056TurnazInd';                    M:'PIANIFICAZIONE_ORARI'),
    (A:'RILPRE';S:'A057';SW:'WA057';N:'Spostamenti di squadra';                 G:'Pianificazione turni';          DI:False;T:23; F:'OpenA057SpostSquadra';                 M:'PIANIFICAZIONE_ORARI'),
    (A:'RILPRE';S:'A058';SW:'WA058';N:'Pianificazione tabellone';               G:'Pianificazione turni';          DI:False;T:24;F:'OpenA058PianifTurni';                   M:'PIANIFICAZIONE_ORARI'),
    (A:'RILPRE';S:'A059';SW:'WA059';N:'Controllo pianificazione';               G:'Pianificazione turni';          DI:False;T:25; F:'OpenA059ContSquadre';                  M:'PIANIFICAZIONE_ORARI'),
    (A:'RILPRE';S:'A068';SW:'WA068';N:'Situazione giornaliera dei turni';       G:'Pianificazione turni';          DI:False;T:33; F:'OpenA068TurniGior';                    M:'PIANIFICAZIONE_ORARI'),
    (A:'RILPRE';S:'A070';SW:'WA070';N:'Profili turni';                          G:'Pianificazione turni';          DI:False;T:140;F:'OpenA070ProfiliTurni';                 M:'PIANIFICAZIONE_ORARI'),
    (A:'RILPRE';S:'A098';SW:'WA098';N:'Pianificazione intelligente';            G:'Pianificazione turni';          DI:False;T:50; F:'OpenA098PianifTurni';                  M:'PIANIFICAZIONE_ORARI'),
    (A:'RILPRE';S:'A174';SW:'WA174';N:'Profili di pianificazione';              G:'Pianificazione turni';          DI:False;T:213;F:'OpenA174ParPianifTurni';               M:'PIANIFICAZIONE_ORARI'),
    //Pianificazione servizi Polizia Municipale
    (A:'RILPRE';S:'A140';SW:'WA140';N:'Servizi';                                G:'Pianificazione turni';          DI:False;T:192; F:'OpenA140TurniServizi';                M:'PIANIFICAZIONE_SERVIZI'),
    (A:'RILPRE';S:'A139';SW:'WA139';N:'Pianificazione servizi';                 G:'Pianificazione turni';          DI:False;T:194; F:'OpenA139PianifServizi';               M:'PIANIFICAZIONE_SERVIZI'),
    (A:'RILPRE';S:'A138';SW:'WA138';N:'Apparati';                               G:'Pianificazione turni';          DI:False;T:193; F:'OpenA138TurniApparati';               M:'PIANIFICAZIONE_SERVIZI'),
    //Accessi mensa
    (A:'RILPRE';S:'A046';SW:'WA046';N:'Regole accessi mensa';                   G:'Accessi mensa';                 DI:False;T:129;F:'OpenA046TerMensa';                     M:'CONTEGGIO_PASTI'),
    (A:'RILPRE';S:'A047';SW:'WA047';N:'Timbrature di mensa';                    G:'Accessi mensa';                 DI:False;T:27; F:'OpenA047TimbMensa';                    M:'CONTEGGIO_PASTI'),
    (A:'RILPRE';S:'A049';SW:'WA049';N:'Cartolina accessi mensa';                G:'Accessi mensa';                 DI:False;T:28; F:'OpenA049StampaPasti';                  M:'CONTEGGIO_PASTI'),
    (A:'RILPRE';S:'A048';SW:'WA048';N:'Riepilogo accessi mensa';                G:'Accessi mensa';                 DI:True ;T:29; F:'OpenA048PastiMese';                    M:'CONTEGGIO_PASTI'),
    //Budget straordinario
    (A:'RILPRE';S:'A064';SW:'WA064';N:'Gestione del budget';                    G:'Budget straordinario';          DI:False;T:132;F:'OpenA064FBudgetStraordinario';         M:'BUDGET_STRAORDINARIO'),
    (A:'RILPRE';S:'A063';SW:'WA063';N:'Allineamento del budget';                G:'Budget straordinario';          DI:False;T:131;F:'OpenA063FBudgetGenerazione';           M:'BUDGET_STRAORDINARIO'),
    (A:'RILPRE';S:'A065';SW:'WA065';N:'Stampa situazione del budget';           G:'Budget straordinario';          DI:False;T:133;F:'OpenA065StampaBudget';                 M:'BUDGET_STRAORDINARIO'),
    (A:'RILPRE';S:'A066';SW:'WA066';N:'Monetizzazione ore di straordinario';    G:'Budget straordinario';          DI:False;T:134;F:'OpenA066ValutaStr';                    M:'BUDGET_STRAORDINARIO'),
    (A:'RILPRE';S:'A069';SW:'WA069';N:'Budget esterno annuo';                   G:'Budget straordinario';          DI:False;T:136;F:'OpenA069BudgetEsterno';                M:'BUDGET_STRAORDINARIO'),
    (A:'RILPRE';S:'A095';SW:'WA095';N:'Liquidazione automatica straordinario';  G:'Budget straordinario';          DI:False;T:44; F:'OpenA095StRiasStr';                    M:'BUDGET_STRAORDINARIO'),
    (A:'RILPRE';S:'A094';SW:'WA094';N:'Limiti mensili delle eccedenze orarie';  G:'Budget straordinario';          DI:False;T:43; F:'OpenA094LimitiStr';                    M:''),
    (A:'RILPRE';S:'A152';SW:'WA152';N:'Eventi straordinari';                    G:'Budget straordinario';          DI:False;T:212;F:'OpenA152EventiStraord';                M:'BUDGET_STRAORDINARIO'),
    (A:'RILPRE';S:'A153';SW:'WA153';N:'Partecipazione eventi straordinari';     G:'Budget straordinario';          DI:False;T:71 ;F:'OpenA153PartecipEventiStraord';        M:'BUDGET_STRAORDINARIO'),
    //Rendicontazione progetti
    (A:'RILPRE';S:'Ac01';SW:'';     N:'Progetti';                               G:'Rendicontazione progetti';      DI:False;T:100001;F:'OpenAc01FProgettiRendiProj';        M:''),
    (A:'RILPRE';S:'Ac02';SW:'';     N:'Limiti individuali';                     G:'Rendicontazione progetti';      DI:True ;T:100002;F:'OpenAc02FLimitiRendiProj';          M:''),
    (A:'RILPRE';S:'Ac04';SW:'';     N:'Stampa rendicontazione';                 G:'Rendicontazione progetti';      DI:True ;T:100006;F:'OpenAc04FStampaRendiProj';          M:''),
    //Festività particolari
    (A:'RILPRE';S:'Ac10';SW:'';     N:'Regole festività particolari';           G:'Festività particolari';         DI:False;T:100003;F:'OpenAC10FestivitaParticolari';      M:''),
    (A:'RILPRE';S:'Ac11';SW:'';     N:'Elaborazione festività particolari';     G:'Festività particolari';         DI:False;T:100004;F:'OpenAc11FElaborazioneFesteParticolari';M:''),
    //Buoni pasto/ticket
    (A:'RILPRE';S:'A071';SW:'WA071';N:'Regole di gestione buoni pasto/ticket';  G:'Buoni pasto/Ticket';            DI:False;T:137;F:'OpenA071RegoleBuoni';                  M:'BUONI_PASTO'),
    (A:'RILPRE';S:'A072';SW:'WA072';N:'Riepilogo buoni pasto/ticket';           G:'Buoni pasto/Ticket';            DI:True ;T:34; F:'OpenA072BuoniMese';                    M:'BUONI_PASTO'),
    (A:'RILPRE';S:'A132';SW:'WA132';N:'Magazzino buoni pasto/ticket';           G:'Buoni pasto/Ticket';            DI:False;T:179;F:'OpenA132MagazzinoBuoniPasto';          M:'BUONI_PASTO'),
    (A:'RILPRE';S:'A073';SW:'WA073';N:'Riepilogo acquisto buoni pasto/ticket';  G:'Buoni pasto/Ticket';            DI:True ;T:35; F:'OpenA073AcquistoBuoni';                M:'BUONI_PASTO'),
    (A:'RILPRE';S:'A074';SW:'WA074';N:'Cartolina buoni pasto/ticket';           G:'Buoni pasto/Ticket';            DI:False;T:36; F:'OpenA074RiepilogoBuoni';               M:'BUONI_PASTO'),
    //Incentivi
    (A:'RILPRE';S:'A160';SW:'WA160';N:'Regole incentivi';                       G:'Incentivi';                     DI:False;T:145;F:'OpenA160RegoleIncentivi';              M:'INCENTIVI'),
    (A:'RILPRE';S:'A161';SW:'WA161';N:'Tipologie di abbattimento incentivi';    G:'Incentivi';                     DI:False;T:198;F:'OpenA161TipoAbbattimenti';             M:'INCENTIVI'),
    (A:'RILPRE';S:'A162';SW:'WA162';N:'Abbattimento incentivi per assenze';     G:'Incentivi';                     DI:False;T:174;F:'OpenA162IncentiviAssenze';             M:'INCENTIVI'),
    (A:'RILPRE';S:'A163';SW:'WA163';N:'Tipologie quote';                        G:'Incentivi';                     DI:False;T:199;F:'OpenA163TipoQuote';                    M:'INCENTIVI'),
    (A:'RILPRE';S:'A164';SW:'WA164';N:'Quote di incentivazione';                G:'Incentivi';                     DI:False;T:146;F:'OpenA164QuoteIncentivi';               M:'INCENTIVI'),
    (A:'RILPRE';S:'A166';SW:'WA166';N:'Quote individuali';                      G:'Incentivi';                     DI:False;T:62; F:'OpenA166QuoteIndividuali';             M:'INCENTIVI'),
    (A:'RILPRE';S:'S735';SW:'WS735';N:'Scaglioni part-time incentivi';          G:'Incentivi';                     DI:False;T:205;F:'OpenS735FPunteggiFasceIncentivi';      M:'INCENTIVI'),
    (A:'RILPRE';S:'S735';SW:'WS735';N:'Scaglioni gg. effettivi incentivi';      G:'Incentivi';                     DI:False;T:211;F:'OpenS735FPunteggiFasceIncentivi';      M:'INCENTIVI'),
    (A:'RILPRE';S:'A169';SW:'WA169';N:'Pesature individuali';                   G:'Incentivi';                     DI:False;T:173;F:'OpenA169PesatureIndividuali';          M:'INCENTIVI'),
    (A:'RILPRE';S:'A172';SW:'WA172';N:'Schede quantitative individuali';        G:'Incentivi';                     DI:False;T:206;F:'OpenA172SchedeQuantIndividuali';       M:'INCENTIVI'),
    (A:'RILPRE';S:'A170';SW:'WA170';N:'Gruppi pesature/schede';                 G:'Incentivi';                     DI:False;T:204;F:'OpenA170GestioneGruppi';               M:'INCENTIVI'),
    (A:'RILPRE';S:'A167';SW:'WA167';N:'Cartolina incentivi';                    G:'Incentivi';                     DI:False;T:39; F:'OpenA167RegistraIncentivi';            M:'INCENTIVI'),
    (A:'RILPRE';S:'A168';SW:'WA168';N:'Riepilogo incentivi';                    G:'Incentivi';                     DI:False;T:40; F:'OpenA168IncentiviMaturati';            M:'INCENTIVI'),
    //LiberaProfessione
    (A:'RILPRE';S:'A096';SW:'WA096';N:'Profili libera professione';             G:'Libera professione';            DI:False;T:150;F:'OpenA096ProfiliLibProf';               M:'LIBERA_PROFESSIONE'),
    (A:'RILPRE';S:'A097';SW:'WA097';N:'Pianificazione libera professione';      G:'Libera professione';            DI:False;T:46; F:'OpenA097PianifLibProf';                M:'LIBERA_PROFESSIONE'),
    //Missioni
    (A:'RILPRE';S:'A110';SW:'WA110';N:'Regole trasferte';                       G:'Missioni/trasferte';            DI:False;T:155;F:'OpenA110ParametriConteggio';           M:'MISSIONI_TRASFERTE'),
    (A:'RILPRE';S:'A133';SW:'WA133';N:'Tariffe trasferte';                      G:'Missioni/trasferte';            DI:False;T:180;F:'OpenA133TariffeMissioni';              M:'MISSIONI_TRASFERTE'),
    (A:'RILPRE';S:'A120';SW:'WA120';N:'Tipi rimborsi';                          G:'Missioni/trasferte';            DI:False;T:156;F:'OpenA120TipiRimborsi';                 M:'MISSIONI_TRASFERTE'),
    (A:'RILPRE';S:'A106';SW:'WA106';N:'Distanze chilometriche';                 G:'Missioni/trasferte';            DI:False;T:175;F:'OpenA106DistanzeTrasferta';            M:'MISSIONI_TRASFERTE'),
    (A:'RILPRE';S:'A129';SW:'WA129';N:'Indennità chilometriche';                G:'Missioni/trasferte';            DI:False;T:157;F:'OpenA129IndennitaKm';                  M:'MISSIONI_TRASFERTE'),
    (A:'RILPRE';S:'A131';SW:'WA131';N:'Gestione anticipi';                      G:'Missioni/trasferte';            DI:False;T:177;F:'OpenA131GestioneAnticipi';             M:'MISSIONI_TRASFERTE'),
    (A:'RILPRE';S:'A137';SW:'WA137';N:'Calcolo spese di accesso';               G:'Missioni/trasferte';            DI:False;T:195;F:'OpenA137FCalcoloSpeseAccesso';         M:'MISSIONI_TRASFERTE'),
    (A:'RILPRE';S:'A100';SW:'WA100';N:'Registrazione trasferte';                G:'Missioni/trasferte';            DI:True ;T:49; F:'OpenA100Missioni';                     M:'MISSIONI_TRASFERTE'),
    (A:'RILPRE';S:'Ac05';SW:'';     N:'Importazione rimborsi da agenzia viaggio';G:'Missioni/trasferte';           DI:False;T:100007;F:'OpenAc05ImportRimborsi';            M:'MISSIONI_TRASFERTE'),
    (A:'RILPRE';S:'A104';SW:'WA104';N:'Stampa trasferte';                       G:'Missioni/trasferte';            DI:False;T:53; F:'OpenA104StampaMissioni';               M:'MISSIONI_TRASFERTE'),
    (A:'RILPRE';S:'A088';SW:'WA088';N:'Dati liberi iter missioni';              G:'Missioni/trasferte';            DI:False;T:207;F:'OpenA088MotivazioniMissioni';          M:'MISSIONI_TRASFERTE'),
    (A:'RILPRE';S:'';    SW:'WA199';N:'Controllo rimborsi';                     G:'Missioni/trasferte';            DI:False;T:74;                                           M:''),
    //Messaggi orologi
    (A:'RILPRE';S:'A111';SW:'WA111';N:'Parametrizzazione interfacce messaggi';  G:'Messaggistica orologi';         DI:False;T:165;F:'OpenA111ParMessaggi';                  M:'INFO_OROLOGI'),
    (A:'RILPRE';S:'A112';SW:'WA112';N:'Generazione messaggi';                   G:'Messaggistica orologi';         DI:False;T:166;F:'OpenA112InvioMessaggi';                M:'INFO_OROLOGI'),
    //Flussi statistici
    (A:'RILPRE';S:'A113';SW:'WA113';N:'Parametrizzazione estrazione dati';      G:'Flussi statistici';             DI:False;T:170;F:'OpenA113ParEstrazioniStampe';          M:'FLUSSI_STATISTICI'),
    (A:'RILPRE';S:'A114';SW:'WA114';N:'Estrazione dati';                        G:'Flussi statistici';             DI:False;T:171;F:'OpenA114EstrazioniStampe';             M:'FLUSSI_STATISTICI'),
    (A:'RILPRE';S:'P655';SW:'WP655';N:'Fornitura FLUPER';                       G:'Flussi statistici';             DI:False;T:572;F:'OpenP655FDatiFLUPER';                  M:'FLUSSI_STATISTICI'),
    (A:'RILPRE';S:'P656';SW:'WP656';N:'Elaborazione fornitura FLUPER'  ;        G:'Flussi statistici';             DI:False;T:574;F:'OpenP656FElaborazioneFLUPER';          M:'FLUSSI_STATISTICI'),
    (A:'RILPRE';S:'P652';SW:'WP652';N:'Regole fornitura FLUPER';                G:'Flussi statistici';             DI:False;T:571;F:'OpenP652FFLUPERRegole';                M:'FLUSSI_STATISTICI'),
    //Sindacati
    (A:'RILPRE';S:'A121';SW:'WA121';N:'Organizzazioni sindacali';               G:'Sindacati';                     DI:False;T:55 ;F:'OpenA121OrganizzSindacali';            M:'SINDACATI'),
    (A:'RILPRE';S:'A122';SW:'WA122';N:'Iscrizioni ai sindacati';                G:'Sindacati';                     DI:False;T:56 ;F:'OpenA122IscrizioniSindacati';          M:'SINDACATI'),
    (A:'RILPRE';S:'A123';SW:'WA123';N:'Partecipazioni ai sindacati';            G:'Sindacati';                     DI:False;T:57 ;F:'OpenA123PartecipazioniSindacati';      M:'SINDACATI'),
    (A:'RILPRE';S:'A124';SW:'WA124';N:'Permessi sindacali';                     G:'Sindacati';                     DI:False;T:58 ;F:'OpenA124PermessiSindacali';            M:'SINDACATI'),
    //Prestazioni aggiuntive
    (A:'RILPRE';S:'A127';SW:'WA127';N:'Regole prestazioni aggiuntive';          G:'Prestazioni aggiuntive';        DI:False;T:60 ;F:'OpenA127TurniPrestazioniAggiuntive';   M:'PRESTAZIONI_AGGIUNTIVE'),
    (A:'RILPRE';S:'A128';SW:'WA128';N:'Pianificazione prestazioni aggiuntive';  G:'Prestazioni aggiuntive';        DI:False;T:61 ;F:'OpenA128PianPrestazioniAggiuntive';    M:'PRESTAZIONI_AGGIUNTIVE'),
    //Conto annuale
    (A:'RILPRE';S:'P555';SW:'WP555';N:'Conto annuale';                          G:'Conto annuale';                 DI:False;T:582;F:'OpenP555FContoAnnuale';                M:'CONTO_ANNUALE'),
    (A:'RILPRE';S:'P554';SW:'WP554';N:'Elaborazione conto annuale';             G:'Conto annuale';                 DI:False;T:583;F:'OpenP554FElaborazioneContoAnnuale';    M:'CONTO_ANNUALE'),
    (A:'RILPRE';S:'P552';SW:'WP552';N:'Regole conto annuale';                   G:'Conto annuale';                 DI:False;T:580;F:'OpenP552RegoleContoAnnuale';           M:'CONTO_ANNUALE'),
    (A:'RILPRE';S:'P553';SW:'WP553';N:'Risorse residue conto annuale';          G:'Conto annuale';                 DI:False;T:584;F:'OpenP553FRisorseResidueContoAnnuale';  M:'CONTO_ANNUALE'),
    (A:'RILPRE';S:'A151';SW:'WA151';N:'Assenteismo e Forza Lavoro';             G:'Assenteismo/Scioperi';          DI:False;T:197;F:'OpenA151AssenteismoForzaLav';          M:'ASSENTEISMO'),
    //Timbrature scartate
    (A:'RILPRE';S:'A135';SW:'WA135';N:'Timbrature scartate';                    G:'Interfacce/Timbrature';         DI:False;T:189;F:'OpenA135FTimbratureScartate';          M:''),
    //Visite fiscali
    (A:'RILPRE';S:'A143';SW:'WA143';N:'Medicine legali';                        G:'Visite fiscali';                DI:False;T:64; F:'OpenA143MedicineLegali';               M:'VISITE_FISCALI'),
    (A:'RILPRE';S:'A144';SW:'WA144';N:'Associazione comuni - medicine legali';  G:'Visite fiscali';                DI:False;T:65; F:'OpenA144ComuniMedLegali';              M:'VISITE_FISCALI'),
    (A:'RILPRE';S:'A145';SW:'WA145';N:'Comunicazione visite fiscali';           G:'Visite fiscali';                DI:False;T:66; F:'OpenA145ComunicazioniVisiteFiscali';   M:'VISITE_FISCALI'),
    (A:'RILPRE';S:'A087';SW:'WA087';N:'Importazione certificati di malattia';   G:'Visite fiscali';                DI:False;T:70; F:'OpenA087ImpAttestatiMal';              M:'VISITE_FISCALI'),
    (A:'RILPRE';S:'A148';SW:'WA148';N:'Profili importazione certificati INPS';  G:'Visite fiscali';                DI:False;T:72; F:'OpenA148ProfiliImportazioneCertificatiINPS';M:'VISITE_FISCALI'),
    //Valutazioni
    (A:'RILPRE';S:'S740';SW:'WS740';N:'Regole valutazioni';                     G:'Valutazioni';                   DI:False;T:350;F:'OpenS740FRegoleValutazioni';           M:'VALUTAZIONI'),
    (A:'RILPRE';S:'S746';SW:'WS746';N:'Stati avanzamento valutazioni';          G:'Valutazioni';                   DI:False;T:354;F:'OpenS746FStatiAvanzamento';            M:'VALUTAZIONI'),
    (A:'RILPRE';S:'S700';SW:'WS700';N:'Aree ed elementi di valutazione';        G:'Valutazioni';                   DI:False;T:342;F:'OpenS700FAreeValutazioni';             M:'VALUTAZIONI'),
    (A:'RILPRE';S:'S720';SW:'WS720';N:'Profili valutazioni';                    G:'Valutazioni';                   DI:False;T:345;F:'OpenS720FProfiliAree';                 M:'VALUTAZIONI'),
    (A:'RILPRE';S:'S706';SW:'WS706';N:'Legami individuali valutatori';          G:'Valutazioni';                   DI:False;T:343;F:'OpenS706FValutatoriDipendente';        M:'VALUTAZIONI'),
    (A:'RILPRE';S:'S730';SW:'WS730';N:'Punteggi valutazioni';                   G:'Valutazioni';                   DI:False;T:340;F:'OpenS730FPunteggiValutazioni';         M:'VALUTAZIONI'),
    (A:'RILPRE';S:'S735';SW:'WS735';N:'Scaglioni valutazioni per incentivi';    G:'Valutazioni';                   DI:False;T:353;F:'OpenS735FPunteggiFasceIncentivi';      M:'VALUTAZIONI'),
    (A:'RILPRE';S:'S750';SW:'WS750';N:'Parametrizzazione protocollazione';      G:'Valutazioni';                   DI:False;T:355;F:'OpenS750FParProtocollo';               M:'VALUTAZIONI'),
    (A:'RILPRE';S:'S715';SW:'WS715';N:'Elaborazione schede di valutazione';     G:'Valutazioni';                   DI:False;T:347;F:'OpenS715FStampaValutazioni';           M:'VALUTAZIONI'),
    //Fondi
    (A:'RILPRE';S:'P680';SW:'WP680';N:'Macrocategorie fondi';                   G:'Fondi';                         DI:False;T:607;F:'OpenP680MacrocategorieFondi';          M:'FONDI'),
    (A:'RILPRE';S:'P682';SW:'WP682';N:'Raggruppamenti fondi';                   G:'Fondi';                         DI:False;T:608;F:'OpenP682RaggruppamentiFondi';          M:'FONDI'),
    (A:'RILPRE';S:'P684';SW:'WP684';N:'Definizione fondi';                      G:'Fondi';                         DI:False;T:609;F:'OpenP684DefinizioneFondi';             M:'FONDI'),
    (A:'RILPRE';S:'P686';SW:'WP686';N:'Calcolo consumi mensili fondi';          G:'Fondi';                         DI:False;T:610;F:'OpenP686CalcoloFondi';                 M:'FONDI'),
    (A:'RILPRE';S:'P688';SW:'WP688';N:'Monitoraggio fondi';                     G:'Fondi';                         DI:False;T:611;F:'OpenP688MonitoraggioFondi';            M:'FONDI'),
    (A:'RILPRE';S:'P690';SW:'WP690';N:'Stampa fondi';                           G:'Fondi';                         DI:False;T:612;F:'OpenP690StampaFondi';                  M:'FONDI'),
    //Funzioni solo IrisCloud
    (A:'RILPRE';S:'';    SW:'WA150';N:'Codici Accorpamento causali assenza';    G:'Ambiente';                      DI:False;T:91;                                           M:''; WEB:'S'),
    (A:'RILPRE';S:'';    SW:'WA189';N:'Limiti eccedenza liquidabile';           G:'Budget straordinario';          DI:False;T:92;                                           M:''; WEB:'S'),
    (A:'RILPRE';S:'';    SW:'WA190';N:'Limiti eccedenza residuabile';           G:'Budget straordinario';          DI:False;T:93;                                           M:''; WEB:'S'),
    (A:'RILPRE';S:'';    SW:'WA191';N:'Definizione campi di raggruppamento';    G:'Budget straordinario';          DI:False;T:94;                                           M:''; WEB:'S'),
    (A:'RILPRE';S:'';    SW:'WA192';N:'Elaborazione omesse timbrature';         G:'Elaborazioni';                  DI:False;T:95;                                           M:''; WEB:'S'),
    (A:'RILPRE';S:'';    SW:'WA193';N:'Carica giustificativi richiesti';        G:'Elaborazioni';                  DI:False;T:96;                                           M:''; WEB:'S'),
    (A:'RILPRE';S:'';    SW:'WA194';N:'Recapiti sindacali';                     G:'Sindacati';                     DI:False;T:97;                                           M:''; WEB:'S'),
    (A:'RILPRE';S:'';    SW:'WA195';N:'Importazione richieste di rimborso dei dipendenti';G:'Missioni/trasferte';  DI:False;T:98;                                           M:''; WEB:'S'),
    (A:'RILPRE';S:'';    SW:'WA196';N:'Tipi pagamento';                         G:'Missioni/trasferte';            DI:False;T:99;                                           M:''; WEB:'S'),
    (A:'RILPRE';S:'';    SW:'WA089';N:'Regole indennità di presenza';           G:'Ambiente';                      DI:False;T:117;                                          M:''; WEB:'S'),

    //PAGHE

    (A:'PAGHE';S:'P002';SW:'WP002'; N:'Passaggio di anno';                       G:'Elaborazioni';                 DI:False;T:555;F:'OpenP002FPassaggioAnno'),
    (A:'PAGHE';S:'P016';SW:'WP016'; N:'Importazione voci programmate';           G:'Elaborazioni';                 DI:False;T:600;F:'OpenP016FImportProgrammate'),
    (A:'PAGHE';S:'P239';SW:'WP239'; N:'Calcolo variazioni e chiusura A.N.F.';    G:'Elaborazioni';                 DI:False;T:585;F:'OpenP239FCalcoloANF'),
    (A:'PAGHE';S:'P253';SW:'WP253'; N:'Importazione modello 730 da file';        G:'Elaborazioni';                 DI:False;T:564;F:'OpenP253FImporta730'),
    (A:'PAGHE';S:'P254';SW:'WP254'; N:'Voci programmate';                        G:'Personale';                    DI:False;T:506;F:'OpenP254FVociProgrammate'),
    (A:'PAGHE';S:'P258';SW:'WP258'; N:'Addizionali IRPEF';                       G:'Personale';                    DI:True; T:526;F:'OpenP258FAddizionaliIRPEF'),
    (A:'PAGHE';S:'P259';SW:'WP259'; N:'Calcolo addizionali IRPEF';               G:'Elaborazioni';                 DI:False;T:581;F:'OpenP259FCalcoloAddizionaliIRPEF'),
    (A:'PAGHE';S:'P261';SW:'WP261'; N:'Impostazione % rimb. Luglio mod.730';     G:'Elaborazioni';                 DI:False;T:624;F:'OpenP261ImpostazionePercRimbLuglio'),
    (A:'PAGHE';S:'P262';SW:'WP262'; N:'Modello 730';                             G:'Personale';                    DI:True; T:539;F:'OpenP262FDatiMod730'),
    (A:'PAGHE';S:'P265';SW:'WP265'; N:'Elaborazione modello O.N.A.O.S.I.';       G:'Elaborazioni';                 DI:False;T:556;F:'OpenP265FElaborazioneONAOSI'),
    (A:'PAGHE';S:'P266';SW:'WP266'; N:'Dati O.N.A.O.S.I.';                       G:'Personale';                    DI:True; T:557;F:'OpenP266FMod1ONAOSI'),
    (A:'PAGHE';S:'P268';SW:'WP268'; N:'Dati rapporti precedenti';                G:'Personale';                    DI:True; T:547;F:'OpenP268FRapportiPrecedenti'),
    (A:'PAGHE';S:'P270';SW:'WP270'; N:'Redditi annuali';                         G:'Personale';                    DI:True; T:554;F:'OpenP270FRedditiAnnuali'),
    (A:'PAGHE';S:'P272';SW:'WP272'; N:'Storico retrib. contrattuale';            G:'Elaborazioni';                 DI:False;T:566;F:'OpenP272FStoricoRetribuzioneContrattuale'),
    (A:'PAGHE';S:'P273';SW:'WP273'; N:'Stampa storico retrib.contr.le';          G:'Elaborazioni';                 DI:False;T:578;F:'OpenP273FStampaStoricoRetribContr'),
    (A:'PAGHE';S:'P441';SW:'WP441'; N:'Cedolini';                                G:'Personale';                    DI:False;T:523;F:'OpenP441FDatiCedolino'),
    (A:'PAGHE';S:'P447';SW:'WP447'; N:'Parcheggio voci';                         G:'Personale';                    DI:False;T:568;F:'OpenP447FParcheggioVoci'),
    (A:'PAGHE';S:'P449';SW:'WP449'; N:'Calcola INAIL';                           G:'Elaborazioni';                 DI:False;T:575;F:'OpenP449FCalcoloINAIL'),
    (A:'PAGHE';S:'P450';SW:'WP450'; N:'Dati mensili';                            G:'Personale';                    DI:True ;T:527;F:'OpenP450FDatiMensili'),
    (A:'PAGHE';S:'P454';SW:'WP454'; N:'Voci da recuperare/recuperate';           G:'Personale';                    DI:True ;T:625;F:'OpenP454RecuperoVoci'),
    (A:'PAGHE';S:'P460';SW:'WP460'; N:'Quantità mensili';                        G:'Personale';                    DI:True; T:590;F:'OpenP460FQuantitaMensili'),
    (A:'PAGHE';S:'P461';SW:'WP461'; N:'Acquisizione quantità mensili';           G:'Elaborazioni';                 DI:False;T:592;F:'OpenP461FImportazioneAssistSanitConvenz'),
    (A:'PAGHE';S:'P462';SW:'WP462'; N:'Sostituzioni convenzionati';              G:'Personale';                    DI:False;T:621;F:'OpenP462Sostituzioni'),
    (A:'PAGHE';S:'P464';SW:'WP464'; N:'Premio di operosità';                     G:'Elaborazioni';                 DI:False;T:614;F:'OpenP464PremioOperosita'),
    (A:'PAGHE';S:'P480';SW:'WP480'; N:'Coefficienti rivalutazione TFR';          G:'Ambiente';                     DI:False;T:627;F:'OpenP480CoefficientiTFR'),
    (A:'PAGHE';S:'P482';SW:'WP482'; N:'Calcolo TFR';                             G:'Elaborazioni';                 DI:False;T:628;F:'OpenP482FCalcoloTFR'),
    (A:'PAGHE';S:'P483';SW:'WP483'; N:'Dati TFR';                                G:'Personale';                    DI:False;T:629;F:'OpenP483FDatiTFR'),
    (A:'PAGHE';S:'P500';SW:'WP500'; N:'Elaborazione cedolini';                   G:'Elaborazioni';                 DI:False;T:505;F:'OpenP500FCalcoloCedolino'),
    (A:'PAGHE';S:'P503';SW:'WP503'; N:'Modelli CU particolari';                  G:'Personale';                    DI:False;T:500;F:'OpenP503ModelliCUParticolari'),
    (A:'PAGHE';S:'P504';SW:'WP504'; N:'Elaborazione modelli CU';                 G:'Elaborazioni';                 DI:False;T:542;F:'OpenP504FCalcoloCUD'),
    (A:'PAGHE';S:'P505';SW:'WP505'; N:'Modello CU';                              G:'Personale';                    DI:False;T:551;F:'OpenP505FDatiCUD'),
    (A:'PAGHE';S:'P506';SW:'WP506'; N:'Creazione file pagamenti per banca';      G:'Elaborazioni';                 DI:False;T:565;F:'OpenP506FFileCedolini'),
    (A:'PAGHE';S:'P507';SW:'WP507'; N:'Controllo tetto accessorie';              G:'Elaborazioni';                 DI:False;T:619;F:'OpenP507FConguaglioRetroattivo'),
    (A:'PAGHE';S:'P507';SW:'WP507'; N:'Conguagli retroattivi';                   G:'Elaborazioni';                 DI:False;T:567;F:'OpenP507FConguaglioRetroattivo'),
    (A:'PAGHE';S:'P508';SW:'WP508'; N:'Calcolo tredicesima virtuale';            G:'Elaborazioni';                 DI:False;T:569;F:'OpenP508FContabAnaliticaRatei'),
    (A:'PAGHE';S:'P509';SW:'WP509'; N:'Copia voci su cedolino';                  G:'Elaborazioni';                 DI:False;T:577;F:'OpenP509FCopiaVociTredicesima'),
    (A:'PAGHE';S:'P510';SW:'WP510'; N:'Creazione file SEPA';                     G:'Elaborazioni';                 DI:False;T:562;F:'OpenP510FileSEPA'),
    (A:'PAGHE';S:'P511';SW:'WP511'; N:'Importazione ricevute modelli CU';        G:'Elaborazioni';                 DI:False;T:630;F:'OpenP511ImportaRicevuteCU'),
    (A:'PAGHE';S:'P554';SW:'WP554'; N:'Elaborazione conto annuale';              G:'Elaborazioni';                 DI:False;T:583;F:'OpenP554FElaborazioneContoAnnuale'),
    (A:'PAGHE';S:'P555';SW:'WP555'; N:'Conto annuale';                           G:'Personale';                    DI:False;T:582;F:'OpenP555FContoAnnuale'),
    (A:'PAGHE';S:'P603';SW:'WP603'; N:'Modelli 770 particolari';                 G:'Personale';                    DI:False;T:632;F:'OpenP603Modelli770Particolari'),
    (A:'PAGHE';S:'P604';SW:'WP604'; N:'Elaborazione modelli 770';                G:'Elaborazioni';                 DI:False;T:546;F:'OpenP604FCalcolo770'),
    (A:'PAGHE';S:'P605';SW:'WP605'; N:'Modello 770';                             G:'Personale';                    DI:False;T:553;F:'OpenP605FDati770'),
    (A:'PAGHE';S:'P655';SW:'WP655'; N:'Forniture mensili INPDAP';                G:'Personale';                    DI:False;T:561;F:'OpenP655FDatiINPDAPMM'),
    (A:'PAGHE';S:'P655';SW:'WP655'; N:'Fornitura FLUPER';                        G:'Personale';                    DI:False;T:572;F:'OpenP655FDatiFLUPER'),
    (A:'PAGHE';S:'P656';SW:'WP656'; N:'Elaborazione fornitura FLUPER';           G:'Elaborazioni';                 DI:False;T:574;F:'OpenP656FElaborazioneFLUPER'),
    (A:'PAGHE';S:'P658';SW:'WP658'; N:'Elaborazione forniture F24 EP';           G:'Elaborazioni';                 DI:False;T:593;F:'OpenP658FElaborazioneF24EP'),
    (A:'PAGHE';S:'P659';SW:'WP659'; N:'Elaborazione forniture F24 ordinario';    G:'Elaborazioni';                 DI:False;T:631;F:'OpenP659ElaborazioneF24Ord'),
    (A:'PAGHE';S:'P671';SW:'WP671'; N:'Elaborazione flusso INPS';                G:'Elaborazioni';                 DI:False;T:570;F:'OpenP671FElaborazioneINPS'),
    (A:'PAGHE';S:'P672';SW:'WP672'; N:'Forniture mensili INPS';                  G:'Personale';                    DI:False;T:573;F:'OpenP672FXmlDatiIndividuali'),
    (A:'PAGHE';S:'P700';SW:'WP700'; N:'Riepiloghi mensili INPS';                 G:'Elaborazioni';                 DI:False;T:531;F:'OpenP700FRiepilogoMensile'),
    (A:'PAGHE';S:'P710';SW:'WP710'; N:'Stampa INAIL';                            G:'Elaborazioni';                 DI:False;T:533;F:'OpenP710FRiepilogoAnnualeINAIL'),
    (A:'PAGHE';S:'P714';SW:'WP714'; N:'Stampa modelli CUD';                      G:'Elaborazioni';                 DI:False;T:563;F:'OpenP714FStampaModCUD'),
    (A:'PAGHE';S:'P715';SW:'WP715'; N:'Stampa modelli CU';                       G:'Elaborazioni';                 DI:False;T:516;F:'OpenP715FStampaModCU'),
    (A:'PAGHE';S:'P716';SW:'WP716'; N:'Stampa modello DMA';                      G:'Elaborazioni';                 DI:False;T:579;F:'OpenP716FStampaModDMA'),
    (A:'PAGHE';S:'P718';SW:'WP718'; N:'Certificazione ritenuta d’acconto';       G:'Elaborazioni';                 DI:False;T:594;F:'OpenP718FStampaCompensi'),
    (A:'PAGHE';S:'P719';SW:'WP719'; N:'Elaborazione fornitura mensile ENPAM';    G:'Elaborazioni';                 DI:False;T:576;F:'OpenP719ElaborazioneMensileENPAM'),
    (A:'PAGHE';S:'P720';SW:'WP720'; N:'Elaborazione fornitura annuale ENPAM';    G:'Elaborazioni';                 DI:False;T:560;F:'OpenP720ElaborazioneENPAM'),
    (A:'PAGHE';S:'P721';SW:'WP721'; N:'Elaborazione fornitura ENPAP';            G:'Elaborazioni';                 DI:False;T:623;F:'OpenP721ElaborazioneENPAP'),
    (A:'PAGHE';S:'P722';SW:'WP722'; N:'Elaborazione fornitura ENPAV';            G:'Elaborazioni';                 DI:False;T:558;F:'OpenP722ElaborazioneENPAV'),
    (A:'PAGHE';S:'P725';SW:'WP725'; N:'Elaborazione fornitura Perseo';           G:'Elaborazioni';                 DI:False;T:622;F:'OpenP725ElaborazionePerseo'),
    (A:'PAGHE';S:'P842';SW:'WP842'; N:'Voci variabili';                          G:'Personale';                    DI:False;T:504;F:'OpenP842FVociVariabiliDipendente'),
    (A:'PAGHE';S:'P844';SW:'WP844'; N:'Voci variabili collettive';               G:'Personale';                    DI:False;T:626;F:'OpenP844VociVariabiliCollettive'),
    (A:'PAGHE';S:'P852';SW:'WP852'; N:'Controllo IBAN';                          G:'Elaborazioni';                 DI:False;T:591;F:'OpenP852ControlloIBAN'),
    (A:'PAGHE';S:'P077';SW:'WP077'; N:'Generatore di stampe';                    G:'Elaborazioni';                 DI:False;T:139;F:'OpenA077GeneratoreStampe'),
    (A:'PAGHE';S:'A151';SW:'WA151'; N:'Assenteismo e Forza Lavoro';              G:'Personale';                    DI:False;T:197;F:'OpenA151AssenteismoForzaLav'),
    //Interfacce
    (A:'PAGHE';S:'P192';SW:'WP192'; N:'Acquisizione file voci';                  G:'Interfacce';                   DI:False;T:535;F:'OpenP192FAcquisizioneFileVociInput'),
    (A:'PAGHE';S:'P191';SW:'WP191'; N:'Parametri acquisizione file voci';        G:'Interfacce';                   DI:False;T:536;F:'OpenP191FParFileVociInput'),
    (A:'PAGHE';S:'A037';SW:'WA037'; N:'Scarico paghe';                           G:'Interfacce';                   DI:False;T:13; F:'OpenA037ScaricoPaghe'; M:''),
    (A:'PAGHE';S:'A038';SW:'WA038'; N:'Voci variabili scaricate';                G:'Interfacce';                   DI:False;T:14; F:'OpenA038VociVariabili'; M:''),
    (A:'PAGHE';S:'A034';SW:'WA034'; N:'Attivazione voci variabili';              G:'Interfacce';                   DI:False;T:121;F:'OpenA034IntPaghe'; M:''),
    (A:'PAGHE';S:'A035';SW:'WA035'; N:'Regole scarico paghe';                    G:'Interfacce';                   DI:False;T:122;F:'OpenA035ParScarico'; M:''),
    //Ambiente
    (A:'PAGHE';S:'P010';SW:'WP010'; N:'Banche';                                  G:'Ambiente';                     DI:False;T:515;F:'OpenP010FBanche'),
    (A:'PAGHE';S:'P012';SW:'WP012'; N:'Beneficiari';                             G:'Ambiente';                     DI:False;T:617;F:'OpenP012Beneficiari'),
    (A:'PAGHE';S:'P020';SW:'WP020'; N:'Stato civile';                            G:'Ambiente';                     DI:False;T:548;F:'OpenP020FStatoCivile'),
    (A:'PAGHE';S:'P022';SW:'WP022'; N:'C.A.F.';                                  G:'Ambiente';                     DI:False;T:537;F:'OpenP022FCAF'),
    (A:'PAGHE';S:'P026';SW:'WP026'; N:'Fondi previdenza complementare';          G:'Ambiente';                     DI:False;T:613;F:'OpenP026FFPC'),
    (A:'PAGHE';S:'P030';SW:'WP030'; N:'Valute';                                  G:'Ambiente';                     DI:False;T:517;F:'OpenP030FValute'),
    (A:'PAGHE';S:'P032';SW:'WP032'; N:'Cambi valute';                            G:'Ambiente';                     DI:False;T:518;F:'OpenP032FCambi'),
    (A:'PAGHE';S:'P040';SW:'WP040'; N:'Part-time';                               G:'Ambiente';                     DI:False;T:512;F:'OpenP040FPartTime'),
    (A:'PAGHE';S:'P042';SW:'WP042'; N:'Tabelle addizionali IRPEF';               G:'Ambiente';                     DI:False;T:525;F:'OpenP042FEntiIRPEF'),
    (A:'PAGHE';S:'P050';SW:'WP050'; N:'Arrotondamenti valute';                   G:'Ambiente';                     DI:False;T:519;F:'OpenP050FArrotondamenti'),
    (A:'PAGHE';S:'P070';SW:'WP070'; N:'Misure quantità';                         G:'Ambiente';                     DI:False;T:521;F:'OpenP070FMisureQuantita'),
    (A:'PAGHE';S:'P080';SW:'WP080'; N:'Causali versamenti IRPEF';                G:'Ambiente';                     DI:False;T:522;F:'OpenP080FCausaliIrpef'),
    (A:'PAGHE';S:'P090';SW:'WP090'; N:'Codici INPS';                             G:'Ambiente';                     DI:False;T:528;F:'OpenP090FCodiciINPS'),
    (A:'PAGHE';S:'P092';SW:'WP092'; N:'Codici INAIL';                            G:'Ambiente';                     DI:False;T:529;F:'OpenP092FCodiciINAIL'),
    (A:'PAGHE';S:'P094';SW:'WP094'; N:'Inquadramenti INPDAP';                    G:'Ambiente';                     DI:False;T:541;F:'OpenP094FInquadramentoINPDAP'),
    (A:'PAGHE';S:'P096';SW:'WP096'; N:'Inquadramenti INPS';                      G:'Ambiente';                     DI:False;T:540;F:'OpenP096FInquadramentoINPS'),
    (A:'PAGHE';S:'P120';SW:'WP120'; N:'Nazionalità';                             G:'Ambiente';                     DI:False;T:549;F:'OpenP120FNazionalita'),
    (A:'PAGHE';S:'P130';SW:'WP130'; N:'Modalità di pagamento';                   G:'Ambiente';                     DI:False;T:514;F:'OpenP130FPagamenti'),
    (A:'PAGHE';S:'P150';SW:'WP150'; N:'Configurazione dati economici';           G:'Ambiente';                     DI:False;T:520;F:'OpenP150FSetup'),
    (A:'PAGHE';S:'P198';SW:'WP198'; N:'Raggruppamenti voci';                     G:'Ambiente';                     DI:False;T:524;F:'OpenP198FRaggruppamentoVoci'),
    (A:'PAGHE';S:'P200';SW:'WP200'; N:'Voci';                                    G:'Ambiente';                     DI:False;T:501;F:'OpenP200FVoci'),
    (A:'PAGHE';S:'P202';SW:'WP202'; N:'Albero assoggettamenti';                  G:'Ambiente';                     DI:False;T:502;F:'OpenP202FLetturaAssoggettamenti'),
    (A:'PAGHE';S:'P212';SW:'WP212'; N:'Aree contrattuali';                       G:'Ambiente';                     DI:False;T:508;F:'OpenP212FParametriStipendi'),
    (A:'PAGHE';S:'P210';SW:'WP210'; N:'Contratti voci';                          G:'Ambiente';                     DI:False;T:507;F:'OpenP210FContratti'),
    (A:'PAGHE';S:'P214';SW:'WP214'; N:'Accorpamenti voci';                       G:'Ambiente';                     DI:False;T:552;F:'OpenP214FAccorpamentoVoci'),
    (A:'PAGHE';S:'';    SW:'WP215'; N:'Accorpamenti voci: tipologie';            G:'Ambiente';                     DI:False;T:550;M:'';WEB:'S'),
    (A:'PAGHE';S:'P220';SW:'WP220'; N:'Posizioni economiche';                    G:'Ambiente';                     DI:False;T:509;F:'OpenP220FLivelli'),
    (A:'PAGHE';S:'P228';SW:'WP228'; N:'Regole sostituzioni convenzionati';       G:'Ambiente';                     DI:False;T:620;F:'OpenP228SostituzRegole'),
    (A:'PAGHE';S:'P236';SW:'WP236'; N:'Tabelle ANF';                             G:'Ambiente';                     DI:False;T:513;F:'OpenP236FTabelleANF'),
    (A:'PAGHE';S:'P240';SW:'WP240'; N:'Tipi assoggettamenti';                    G:'Ambiente';                     DI:False;T:534;F:'OpenP240FTipiAssoggettamenti'),
    (A:'PAGHE';S:'P250';SW:'WP250'; N:'Voci aggiuntive';                         G:'Ambiente';                     DI:False;T:510;F:'OpenP250FVociAggiuntive'),
    (A:'PAGHE';S:'P252';SW:'WP252'; N:'Importi voci aggiuntive';                 G:'Ambiente';                     DI:False;T:511;F:'OpenP252FVociAggiuntiveImporti'),
    (A:'PAGHE';S:'P260';SW:'WP260'; N:'Tipi importi';                            G:'Ambiente';                     DI:False;T:538;F:'OpenP260FMod730TipoImporti'),
    (A:'PAGHE';S:'P292';SW:'WP292'; N:'Calcolo parametri INAIL';                 G:'Ambiente';                     DI:False;T:601;F:'OpenP292FCalcoloMinimaleMassimaleINAIL'),
    (A:'PAGHE';S:'P501';SW:'WP501'; N:'Configurazione dati aziendali';           G:'Ambiente';                     DI:False;T:543;F:'OpenP501FCudSetup'),
    (A:'PAGHE';S:'P502';SW:'WP502'; N:'Regole di calcolo della CU';              G:'Ambiente';                     DI:False;T:544;F:'OpenP502FCudRegole'),
    (A:'PAGHE';S:'P552';SW:'WP552'; N:'Regole conto annuale';                    G:'Ambiente';                     DI:False;T:580;F:'OpenP552RegoleContoAnnuale'),
    (A:'PAGHE';S:'P553';SW:'WP553'; N:'Risorse residue conto annuale';           G:'Ambiente';                     DI:False;T:584;F:'OpenP553FRisorseResidueContoAnnuale'),
    (A:'PAGHE';S:'P602';SW:'WP602'; N:'Regole di calcolo del 770';               G:'Ambiente';                     DI:False;T:545;F:'OpenP602F770Regole'),
    (A:'PAGHE';S:'P652';SW:'WP652'; N:'Regole fornitura INPDAP';                 G:'Ambiente';                     DI:False;T:559;F:'OpenP652FINPDAPMMRegole'),
    (A:'PAGHE';S:'P652';SW:'WP652'; N:'Regole fornitura FLUPER';                 G:'Ambiente';                     DI:False;T:571;F:'OpenP652FFLUPERRegole'),
    (A:'PAGHE';S:'P670';SW:'WP670'; N:'Regole fornitura INPS';                   G:'Ambiente';                     DI:False;T:618;F:'OpenP670XmlINPSRegole'),
    (A:'PAGHE';S:'P850';SW:'WP850'; N:'Cambio codici voci';                      G:'Ambiente';                     DI:False;T:532;F:'OpenP850FCambioCodici'),
    (A:'PAGHE';S:'A109';SW:'WA109'; N:'Loghi aziendali';                         G:'Ambiente';                     DI:False;T:164;F:'OpenA109Immagini'),
    //Modulo contabilità
    (A:'PAGHE';S:'P590';SW:'WP590'; N:'Regole contabilità';                      G:'Ambiente';                     DI:False;T:586;F:'OpenP590FContabRegole';                M:'CONTABILITA'),
    (A:'PAGHE';S:'P591';SW:'WP591'; N:'Contabilità';                             G:'Elaborazioni';                 DI:False;T:587;F:'OpenP591FElaborazioneContab';          M:'CONTABILITA'),
    (A:'PAGHE';S:'P592';SW:'WP592'; N:'Contabilità';                             G:'Personale';                    DI:False;T:588;F:'OpenP592FDatiContab';                  M:'CONTABILITA'),
    (A:'PAGHE';S:'A035';SW:'WA035'; N:'Parametrizzazione scarico contabilità';   G:'Ambiente';                     DI:False;T:589;F:'OpenA035FParContabilita';              M:'CONTABILITA'),
    //Modulo pensioni
    (A:'PAGHE';S:'P280';SW:'WP280'; N:'Periodi pensionistici e previdenziali';   G:'Elaborazioni';                 DI:False;T:596;F:'OpenP280FPeriodiPensPrev';             M:'PENSIONI'),
    (A:'PAGHE';S:'P282';SW:'WP282'; N:'Periodi retributivi';                     G:'Elaborazioni';                 DI:False;T:597;F:'OpenP282FPeriodiRetributivi';          M:'PENSIONI'),
    (A:'PAGHE';S:'P283';SW:'WP283'; N:'Stampa periodi retributivi';              G:'Elaborazioni';                 DI:False;T:598;F:'OpenP283FStampaPeriodiRetrib';         M:'PENSIONI'),
    (A:'PAGHE';S:'P285';SW:'WP285'; N:'Creazione file per INPDAP - Pensioni S7'; G:'Elaborazioni';                 DI:False;T:599;F:'OpenP285FFileINPDAP';                  M:'PENSIONI'),
    (A:'PAGHE';S:'P286';SW:'WP286'; N:'Elaborazione UNJSPF';                     G:'Elaborazioni';                 DI:False;T:615;F:'OpenP286ElaborazioneUnjspf';           M:'PENSIONI'),
    (A:'PAGHE';S:'P287';SW:'WP287'; N:'UNJSPF';                                  G:'Elaborazioni';                 DI:False;T:616;F:'OpenP287PensioneUnjspf';               M:'PENSIONI'),
    //Budget
    (A:'PAGHE';S:'P300';SW:'WP300'; N:'Creazione ambiente budget';               G:'Ambiente';                     DI:False;T:602;F:'OpenP300AmbienteBudget';               M:'BUDGET'),
    (A:'PAGHE';S:'P301';SW:'WP301'; N:'Previsione aumenti contrattuali';         G:'Ambiente';                     DI:False;T:603;F:'OpenP301AumentiContrattuali';          M:'BUDGET'),
    (A:'PAGHE';S:'P302';SW:'WP302'; N:'Applicazione scatti economici';           G:'Elaborazioni';                 DI:False;T:604;F:'OpenP302ScattiEconomici';              M:'BUDGET'),
    (A:'PAGHE';S:'P499';SW:'WP499'; N:'Simulazione cedolini';                    G:'Elaborazioni';                 DI:False;T:605;F:'OpenP499FSimulazioneCedolino';         M:'BUDGET'),
    (A:'PAGHE';S:'P303';SW:'WP303'; N:'Previsione aumento del personale';        G:'Ambiente';                     DI:False;T:606;F:'OpenP303AumentoPersonale';             M:'BUDGET'),
    //Fondi
    (A:'PAGHE';S:'P680';SW:'WP680'; N:'Macrocategorie fondi';                    G:'Ambiente/Fondi';               DI:False;T:607;F:'OpenP680MacrocategorieFondi';          M:'FONDI'),
    (A:'PAGHE';S:'P682';SW:'WP682'; N:'Raggruppamenti fondi';                    G:'Ambiente/Fondi';               DI:False;T:608;F:'OpenP682RaggruppamentiFondi';          M:'FONDI'),
    (A:'PAGHE';S:'P684';SW:'WP684'; N:'Definizione fondi';                       G:'Ambiente/Fondi';               DI:False;T:609;F:'OpenP684DefinizioneFondi';             M:'FONDI'),
    (A:'PAGHE';S:'P686';SW:'WP686'; N:'Calcolo consumi mensili fondi';           G:'Ambiente/Fondi';               DI:False;T:610;F:'OpenP686CalcoloFondi';                 M:'FONDI'),
    (A:'PAGHE';S:'P688';SW:'WP688'; N:'Monitoraggio fondi';                      G:'Ambiente/Fondi';               DI:False;T:611;F:'OpenP688MonitoraggioFondi';            M:'FONDI'),
    (A:'PAGHE';S:'P690';SW:'WP690'; N:'Stampa fondi';                            G:'Ambiente/Fondi';               DI:False;T:612;F:'OpenP690StampaFondi';                  M:'FONDI'),
    //Funzioni WEB PAGHE
    (A:'PAGHE';S:'W017';SW:'';      N:'Stampa cedolino';                         G:'Funzioni WEB';                 DI:False;T:417; F:'OpenW017StampaCedolino';              M:'IRIS_WEB'),
    (A:'PAGHE';S:'W021';SW:'';      N:'Stampa CUD/CU';                           G:'Funzioni WEB';                 DI:False;T:422; F:'OpenW021StampaCUD';                   M:'IRIS_WEB'),
    (A:'PAGHE';S:'W027';SW:'';      N:'Detrazioni fiscali';                      G:'Funzioni WEB';                 DI:False;T:434; F:'OpenW027DetrazioniIRPEF';             M:'IRIS_WEB'),

    //STATO GIURIDICO

    (A:'STAGIU';S:'A030';SW:'';     N:'Residui anno precedente';                 G:'Personale';                    DI:True ;T:11; F:'OpenA030Residui';                      M:''),
    (A:'STAGIU';S:'A010';SW:'';     N:'Competenze assenze individuali';          G:'Personale';                    DI:True ;T:4;  F:'OpenA010ProfAsseInd';                  M:''),
    (A:'STAGIU';S:'A013';SW:'';     N:'Calendario individuale';                  G:'Personale';                    DI:True ;T:1;  F:'OpenA013CalendIndiv';                  M:''),
    (A:'STAGIU';S:'A004';SW:'';     N:'Inserimento giustificativi collettivi';   G:'Elaborazioni';                 DI:False;T:47; F:'OpenA004GiustifGruppo';                M:''),
    (A:'STAGIU';S:'A090';SW:'';     N:'Scheda annuale assenze';                  G:'Elaborazioni';                 DI:False;T:41; F:'OpenA090AssenzeAnno';                  M:''),
    (A:'STAGIU';S:'A075';SW:'';     N:'Passaggio di anno';                       G:'Elaborazioni';                 DI:False;T:37; F:'OpenA075FineAnno';                     M:''),
    (A:'STAGIU';S:'A077';SW:'';     N:'Generatore di stampe';                    G:'Elaborazioni';                 DI:False;T:139;F:'OpenA077GeneratoreStampe';             M:''),
    (A:'STAGIU';S:'A085';SW:'';     N:'Part-time';                               G:'Ambiente';                     DI:False;T:144;F:'OpenA085PartTime';                     M:''),
    (A:'STAGIU';S:'A012';SW:'';     N:'Calendari';                               G:'Ambiente';                     DI:False;T:101;F:'OpenA012Calendari';                    M:''),
    (A:'STAGIU';S:'A009';SW:'';     N:'Profili assenze annuali';                 G:'Ambiente';                     DI:False;T:104;F:'OpenA009ProfiliAsse';                  M:''),
    (A:'STAGIU';S:'A020';SW:'';     N:'Causali di presenza';                     G:'Ambiente';                     DI:False;T:107;F:'OpenA020CausPresenze';                 M:''),
    (A:'STAGIU';S:'A018';SW:'';     N:'Raggruppamenti di presenza';              G:'Ambiente';                     DI:False;T:108;F:'OpenA018RaggrPres';                    M:''),
    //Certificazione
    (A:'STAGIU';S:'S026';SW:'';     N:'Definizione variabili';                   G:'Ambiente/Certificazione';      DI:False;T:302;F:'OpenS026Variabili';                    M:'CERTIFICAZIONE'),
    (A:'STAGIU';S:'S100';SW:'';     N:'Edizione modelli .rtf';                   G:'Ambiente/Certificazione';      DI:False;T:307;F:'OpenS100EditCert';                     M:'CERTIFICAZIONE'),
    (A:'STAGIU';S:'S027';SW:'';     N:'Tipologie documenti';                     G:'Ambiente';                     DI:False;T:317;F:'OpenS027Documenti';                    M:'CERTIFICAZIONE'),
    (A:'STAGIU';S:'S028';SW:'';     N:'Motivazioni provvedimento';               G:'Ambiente';                     DI:False;T:301;F:'OpenS028Motivazioni';                  M:'CERTIFICAZIONE'),
    (A:'STAGIU';S:'S108';SW:'';     N:'Tipologie esperienze';                    G:'Ambiente/Curriculum';          DI:False;T:319;F:'OpenS108TipoEsperienze';               M:'CERTIFICAZIONE'),
    (A:'STAGIU';S:'S109';SW:'';     N:'Dettaglio esperienze';                    G:'Ambiente/Curriculum';          DI:False;T:320;F:'OpenS109DettaglioEsperienze';          M:'CERTIFICAZIONE'),
    (A:'STAGIU';S:'S101';SW:'';     N:'Stampa modelli .rtf';                     G:'Elaborazioni';                 DI:False;T:308;F:'OpenS101StampaCert';                   M:'CERTIFICAZIONE'),
    (A:'STAGIU';S:'S030';SW:'';     N:'Gestione provvedimenti';                  G:'Personale';                    DI:False;T:304;F:'OpenS030Provvedimento';                M:'CERTIFICAZIONE'),
    (A:'STAGIU';S:'S032';SW:'';     N:'Gestione documentazione';                 G:'Personale';                    DI:False;T:305;F:'OpenS032Documenti';                    M:'CERTIFICAZIONE'),
    (A:'STAGIU';S:'S110';SW:'';     N:'Gestione curriculum';                     G:'Personale/Curriculum';         DI:False;T:306;F:'OpenS110Curriculum';                   M:'CERTIFICAZIONE'),
    (A:'STAGIU';S:'S111';SW:'';     N:'Preferenze lavorative';                   G:'Personale/Curriculum';         DI:False;T:315;F:'OpenS111Preferenze';                   M:'CERTIFICAZIONE'),
    (A:'STAGIU';S:'S112';SW:'';     N:'Stampa preferenze curriculari';           G:'Personale/Curriculum';         DI:False;T:316;F:'OpenS112StampaPreferenze';             M:'CERTIFICAZIONE'),
    (A:'STAGIU';S:'S210';SW:'';     N:'Esportazione XML curriculum';             G:'Personale/Curriculum';         DI:False;T:344;F:'OpenS210FEsportaCurriculum';           M:'CERTIFICAZIONE'),
    //Crediti formativi
    (A:'STAGIU';S:'S652';SW:'';     N:'Tabelle base - corsi';                    G:'Crediti formativi';            DI:False;T:311;F:'OpenS652TabelleBaseCorsi';             M:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'S650';SW:'';     N:'Corsi di formazione';                     G:'Crediti formativi';            DI:False;T:309;F:'OpenS650GestioneCorsi';                M:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'S651';SW:'';     N:'Pianificazione corsi';                    G:'Crediti formativi';            DI:False;T:310;F:'OpenS651PianificazioneCorsi';          M:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'S655';SW:'';     N:'Profili annuali crediti';                 G:'Crediti formativi';            DI:False;T:314;F:'OpenS655ProfiliCrediti';               M:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'S656';SW:'';     N:'Stampe formazione';                       G:'Crediti formativi';            DI:False;T:321;F:'OpenS656StampeFormazione';             M:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'P652';SW:'';     N:'Regole flusso crediti';                   G:'Crediti formativi';            DI:False;T:324;F:'OpenP652FFlussoCreditiRegole';         M:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'S657';SW:'';     N:'Elaborazione flusso crediti';             G:'Crediti formativi';            DI:False;T:325;F:'OpenS657FElaborazioneFlussoCrediti';   M:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'P655';SW:'';     N:'Fornitura flusso crediti';                G:'Crediti formativi';            DI:False;T:332;F:'OpenP655FDatiFlussoCrediti';           M:'CREDITI_FORMATIVI'),
    //Flussi statistici (fanno      parte dei CREDITI_FORMATIVI)
    (A:'STAGIU';S:'A113';SW:'';     N:'Parametrizzazione estrazione dati';       G:'Flussi statistici';            DI:False;T:170;F:'OpenA113ParEstrazioniStampe';          M:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'A114';SW:'';     N:'Estrazione dati';                         G:'Flussi statistici';            DI:False;T:171;F:'OpenA114EstrazioniStampe';             M:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'P655';SW:'';     N:'Fornitura FLUPER';                        G:'Flussi statistici';            DI:False;T:572;F:'OpenP655FDatiFLUPER';                  M:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'P656';SW:'';     N:'Elaborazione fornitura FLUPER';           G:'Flussi statistici';            DI:False;T:574;F:'OpenP656FElaborazioneFLUPER';          M:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'P652';SW:'';     N:'Regole fornitura FLUPER';                 G:'Flussi statistici';            DI:False;T:571;F:'OpenP652FFLUPERRegole';                M:'CREDITI_FORMATIVI'),
    //Pianta Organica
    (A:'STAGIU';S:'S200';SW:'';     N:'Estremi struttura/atti';                  G:'Pianta organica';              DI:False;T:322;F:'OpenS200EstremiStruttura';             M:'PIANTA_ORGANICA'),
    (A:'STAGIU';S:'S201';SW:'';     N:'Distribuzione organico';                  G:'Pianta organica';              DI:False;T:312;F:'OpenS201DistribuzioneOrganico';        M:'PIANTA_ORGANICA'),
    (A:'STAGIU';S:'S202';SW:'';     N:'Visualizzazione pianta organica';         G:'Pianta organica';              DI:False;T:323;F:'OpenS202VisualizzazionePianta';        M:'PIANTA_ORGANICA'),
    (A:'STAGIU';S:'S203';SW:'';     N:'Stampa situazione organico';              G:'Pianta organica';              DI:False;T:313;F:'OpenS203StampaPiantaOrganica';         M:'PIANTA_ORGANICA'),
    //Gestione rischi
    (A:'STAGIU';S:'S400';SW:'';     N:'Tipologie rischi e visite';               G:'Rischi e prescrizioni';        DI:False;T:326;F:'OpenS400TipologieRischi';              M:'RISCHI_PRESCRIZIONI'),
    (A:'STAGIU';S:'S401';SW:'';     N:'Motivazioni cessazione rischi';           G:'Rischi e prescrizioni';        DI:False;T:327;F:'OpenS401CessazioniRischi';             M:'RISCHI_PRESCRIZIONI'),
    (A:'STAGIU';S:'S405';SW:'';     N:'Tipologie attività';                      G:'Rischi e prescrizioni';        DI:False;T:348;F:'OpenS405TipoAttivita';                 M:'RISCHI_PRESCRIZIONI'),
    (A:'STAGIU';S:'S406';SW:'';     N:'Tipologie esposizioni';                   G:'Rischi e prescrizioni';        DI:False;T:349;F:'OpenS406TipoEsposizione';              M:'RISCHI_PRESCRIZIONI'),
    (A:'STAGIU';S:'S403';SW:'';     N:'Tipologie prescrizioni';                  G:'Rischi e prescrizioni';        DI:False;T:330;F:'OpenS403TipologiePrescrizioni';        M:'RISCHI_PRESCRIZIONI'),
    (A:'STAGIU';S:'S402';SW:'';     N:'Gestione rischi e prescrizioni';          G:'Rischi e prescrizioni';        DI:False;T:328;F:'OpenS402GestioneRischi';               M:'RISCHI_PRESCRIZIONI'),
    (A:'STAGIU';S:'S404';SW:'';     N:'Stampa periodi rischio';                  G:'Rischi e prescrizioni';        DI:False;T:331;F:'OpenS404StampaRischi';                 M:'RISCHI_PRESCRIZIONI'),
    (A:'STAGIU';S:'S450';SW:'';     N:'Posti letto';                             G:'Rischi e prescrizioni';        DI:False;T:329;F:'OpenS450PostiLetto';                   M:'RISCHI_PRESCRIZIONI'),
    //Conto annuale
    (A:'STAGIU';S:'P555';SW:'';     N:'Conto annuale';                           G:'Conto annuale';                DI:False;T:582;F:'OpenP555FContoAnnuale';                M:'CONTO_ANNUALE'),
    (A:'STAGIU';S:'P554';SW:'';     N:'Elaborazione conto annuale';              G:'Conto annuale';                DI:False;T:583;F:'OpenP554FElaborazioneContoAnnuale';    M:'CONTO_ANNUALE'),
    (A:'STAGIU';S:'P552';SW:'';     N:'Regole conto annuale';                    G:'Conto annuale';                DI:False;T:580;F:'OpenP552RegoleContoAnnuale';           M:'CONTO_ANNUALE'),
    (A:'STAGIU';S:'P553';SW:'';     N:'Risorse residue conto annuale';           G:'Conto annuale';                DI:False;T:584;F:'OpenP553FRisorseResidueContoAnnuale';  M:'CONTO_ANNUALE'),
    (A:'STAGIU';S:'A151';SW:'';     N:'Assenteismo e Forza Lavoro';              G:'Conto annuale';                DI:False;T:197;F:'OpenA151AssenteismoForzaLav';          M:'ASSENTEISMO'),
    //Gestione incarichi
    (A:'STAGIU';S:'S300';SW:'';     N:'Categorie incarichi';                     G:'Ambiente/Incarichi';           DI:False;T:333;F:'OpenS300CategorieIncarichi';           M:'INCARICHI'),
    (A:'STAGIU';S:'S301';SW:'';     N:'Tipi incarichi';                          G:'Ambiente/Incarichi';           DI:False;T:334;F:'OpenS301TipiIncarichi';                M:'INCARICHI'),
    (A:'STAGIU';S:'S302';SW:'';     N:'Incarichi aziendali';                     G:'Ambiente/Incarichi';           DI:False;T:335;F:'OpenS302IncarichiAziendali';           M:'INCARICHI'),
    (A:'STAGIU';S:'S309';SW:'';     N:'Tipologie verifiche';                     G:'Ambiente/Incarichi';           DI:False;T:351;F:'OpenS309TipiVerifiche';                M:'INCARICHI'),
    (A:'STAGIU';S:'S305';SW:'';     N:'Commissioni';                             G:'Ambiente/Incarichi';           DI:False;T:336;F:'OpenS305Commissioni';                  M:'INCARICHI'),
    (A:'STAGIU';S:'S306';SW:'';     N:'Componenti delle commissioni';            G:'Ambiente/Incarichi';           DI:False;T:337;F:'OpenS306ComponentiCommissioni';        M:'INCARICHI'),
    (A:'STAGIU';S:'S303';SW:'';     N:'Gestione incarichi';                      G:'Personale/Incarichi';          DI:False;T:338;F:'OpenS303IncarichiIndividuali';         M:'INCARICHI'),
    (A:'STAGIU';S:'S307';SW:'';     N:'Verifiche incarichi';                     G:'Personale/Incarichi';          DI:False;T:318;F:'OpenS307VerificheIncarichi';           M:'INCARICHI'),
    (A:'STAGIU';S:'S304';SW:'';     N:'Riepilogo incarichi';                     G:'Personale/Incarichi';          DI:False;T:339;F:'OpenS304RiepilogoIncarichi';           M:'INCARICHI'),
    (A:'STAGIU';S:'S308';SW:'';     N:'Verifiche indennità';                     G:'Personale/Incarichi';          DI:False;T:352;F:'OpenS308IndennitaInc';                 M:'INCARICHI'),
    //Funzioni WEB
    (A:'STAGIU';S:'W012';SW:'';     N:'Gestione curriculum';                     G:'Funzioni WEB';                 DI:False;T:409; F:'OpenW012Curriculum';                  M:'IRIS_WEB'),
    (A:'STAGIU';S:'W013';SW:'';     N:'Gestione preferenze';                     G:'Funzioni WEB';                 DI:False;T:410; F:'OpenW013Preferenze';                  M:'IRIS_WEB'),
    (A:'STAGIU';S:'W014';SW:'';     N:'Richiesta iscrizione corsi';              G:'Funzioni WEB';                 DI:False;T:411; F:'OpenW014RichiestaIscrizioneCorsi';    M:'IRIS_WEB';MIW:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'W014';SW:'';     N:'Autorizzazione iscrizione corsi';         G:'Funzioni WEB';                 DI:False;T:413; F:'OpenW014AutorizzazioneIscrizioneCorsi'; M:'IRIS_WEB';MIW:'CREDITI_FORMATIVI'),
    (A:'STAGIU';S:'W022';SW:'';     N:'Scheda di valutazione';                   G:'Funzioni WEB';                 DI:False;T:423; F:'OpenW022SchedaValutazioni';           M:'IRIS_WEB';MIW:'VALUTAZIONI'),
    (A:'STAGIU';S:'W022';SW:'';     N:'Scheda di autovalutazione';               G:'Funzioni WEB';                 DI:False;T:424; F:'OpenW022SchedaAutovalutazioni';       M:'IRIS_WEB';MIW:'VALUTAZIONI'),
    (A:'STAGIU';S:'W022';SW:'';     N:'Stampa scheda di valutazione';            G:'Funzioni WEB';                 DI:False;T:443; F:'OpenW022StampaSchedaValutazioni';     M:'IRIS_WEB';MIW:'VALUTAZIONI'),
    (A:'STAGIU';S:'W036';SW:'';     N:'Curriculum - Trasparenza';                G:'Funzioni WEB';                 DI:False;T:446; F:'OpenW036TraspDirigenza';              M:'IRIS_WEB';MIW:''),
    //Valutazioni
    (A:'STAGIU';S:'S740';SW:'';     N:'Regole valutazioni';                      G:'Valutazioni';                  DI:False;T:350;F:'OpenS740FRegoleValutazioni';           M:'VALUTAZIONI'),
    (A:'STAGIU';S:'S746';SW:'';     N:'Stati avanzamento valutazioni';           G:'Valutazioni';                  DI:False;T:354;F:'OpenS746FStatiAvanzamento';            M:'VALUTAZIONI'),
    (A:'STAGIU';S:'S700';SW:'';     N:'Aree ed elementi di valutazione';         G:'Valutazioni';                  DI:False;T:342;F:'OpenS700FAreeValutazioni';             M:'VALUTAZIONI'),
    (A:'STAGIU';S:'S720';SW:'';     N:'Profili valutazioni';                     G:'Valutazioni';                  DI:False;T:345;F:'OpenS720FProfiliAree';                 M:'VALUTAZIONI'),
    (A:'STAGIU';S:'S706';SW:'';     N:'Legami individuali valutatori';           G:'Valutazioni';                  DI:False;T:343;F:'OpenS706FValutatoriDipendente';        M:'VALUTAZIONI'),
    (A:'STAGIU';S:'S730';SW:'';     N:'Punteggi valutazioni';                    G:'Valutazioni';                  DI:False;T:340;F:'OpenS730FPunteggiValutazioni';         M:'VALUTAZIONI'),
    (A:'STAGIU';S:'S735';SW:'';     N:'Scaglioni valutazioni per incentivi';     G:'Valutazioni';                  DI:False;T:353;F:'OpenS735FPunteggiFasceIncentivi';      M:'VALUTAZIONI'),
    (A:'STAGIU';S:'S750';SW:'';     N:'Parametrizzazione protocollazione';       G:'Valutazioni';                  DI:False;T:355;F:'OpenS750FParProtocollo';               M:'VALUTAZIONI'),
    (A:'STAGIU';S:'S715';SW:'';     N:'Elaborazione schede di valutazione';      G:'Valutazioni';                  DI:False;T:347;F:'OpenS715FStampaValutazioni';           M:'VALUTAZIONI'),
    //Firma digitale
    (A:'STAGIU';S:'S250';SW:'';     N:'Smart-card';                              G:'Firma digitale';               DI:False;T:300;F:'OpenS250SmartCard';                    M:'FIRMA_DIGITALE'),
    (A:'STAGIU';S:'S251';SW:'';     N:'Tipologie smart-card';                    G:'Firma digitale';               DI:False;T:341;F:'OpenS251TipiSmartCard';                M:'FIRMA_DIGITALE')
    );

function L021GetMaschera(i:Integer):String;
function L021VerificaMaschera(Maschera: String; i:Integer):Boolean;
function L021VerificaApplicazione(Applicazione: String; i:Integer):Boolean;
function L021RichiedeAnagraficaSelezionata(Tag:Integer):Boolean;
function L021SiglaByTag(Tag:Integer; Sigla:String = 'S'):String;

var
  GeneratoreDiStampe:Boolean = False;
  IndennitaTurno:Boolean = False;
  IntegrazioneFTP:Boolean = False;
  CheckEutron:Boolean = False;
  VersioneDimostrativa:Boolean = False;
  CartellinoAscii:Boolean = False;

implementation

uses C180FunzioniGenerali, StrUtils, SysUtils;

function L021GetMaschera(i:Integer):String;
begin
  if i > High(FunzioniDisponibili) then
    Result:=''
  else if FunzioniDisponibili[i].S <> '' then
    Result:=FunzioniDisponibili[i].S
  else
    Result:=FunzioniDisponibili[i].SW;
end;

function L021VerificaMaschera(Maschera: String; i:Integer):Boolean;
begin
  Result:=(i <= High(FunzioniDisponibili)) and ((UpperCase(FunzioniDisponibili[i].S) = UpperCase(Maschera)) or (UpperCase(FunzioniDisponibili[i].SW) = UpperCase(Maschera)));
end;

function L021VerificaApplicazione(Applicazione: String; i:Integer):Boolean;
begin
  // bugfix.ini
  // in modalità progetto singolo l'applicazione vale stringa vuota
  // pertanto il result sarebbe sempre False: in questo caso forza RILPRE
  if Applicazione = '' then
    Applicazione:='RILPRE';
  // bugfix.fine
  Result:=(i <= High(FunzioniDisponibili)) and R180In(FunzioniDisponibili[i].A,['IRIS','FUNWEB',Applicazione]);
end;

function L021RichiedeAnagraficaSelezionata(Tag:Integer):Boolean;
var i:Integer;
begin
  Result:=False;
  for i:=Low(FunzioniDisponibili) to High(FunzioniDisponibili) do
    if FunzioniDisponibili[i].T = Tag then
    begin
      Result:=FunzioniDisponibili[i].DI;
      Break;
    end;
end;

function L021SiglaByTag(Tag:Integer; Sigla:String = 'S'):String;
var i:Integer;
begin
  Result:='';
  for i:=Low(FunzioniDisponibili) to High(FunzioniDisponibili) do
    if FunzioniDisponibili[i].T = Tag then
    begin
      Result:=FunzioniDisponibili[i].S;
      if (Sigla = 'SW') and (FunzioniDisponibili[i].SW <> '') then
        Result:=FunzioniDisponibili[i].SW;
      Break;
    end;
end;

end.
