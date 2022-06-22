unit R600;
{Controlli e calcoli delle assenze
 Fasi per l'inserimento di un periodo di assenza:
 1) ApriAssenze: Creazione del DataModule;
 2) SettaConteggi: Impostazione del Progressivo e del periodo;
   a) Lettura dei dati della causale in uso;
   b) Impostazione del periodo di fruizione se esiste;
   c) Lettura e calcolo delle competenze;
   d) Cumulo delle assenze fino al periodo di inserimento;
 3) Per ogni giorno di assenza inserito:
   a) GiornoSignificativo: Verifica, in base alla gestione turnista e ai giorni di
      significatività se si può inserire l'assenza nel giorno in questione
   b) ControlliGenerali: Controlli di validità e di compatibilità dell'assenza
      inserita con i dati già esistenti:
      - Abilitazione in anagrafico
      - Giorno compreso nel periodo di fruizione, se esiste
      - Il riposo può essere inserito solo a giornata intera
      - Non si può inserire più di un riposo in un giorno
      - Se ci sono delle timbrature non si può inserire una giornata intera di
        assenza non-riposo
      - Sono consentite solo due giornate intere di assenza
      - Sono consentite solo due mezze giornate di assenza
      - Le assenze di non-riposo a giornate o mezze-giornate sono permesse in questa forma:
        1 GG, 1GG + 1MG, 2 MG
      - Assenze da ore/a ore: intersezione con altri giustificativi da ore/a ore
                              intersezione con timbrature (controllo timbrature in sequenza)

Analisi del calcolo delle competenze (2-c):
  1) Lettura del codice interno del raggruppamento della causale in oggetto
  2) Lettura se conteggio ad anno solare nel raggruppamento della causale in oggetto
  3) Se conteggio ad anno solare e residuabile, memorizzazione dei residui
     dell'anno precedente nel vettore 'Residui'
  4) Se non uso conteggio ad anno solare, leggo le competenze direttamente sui
     dati della causale
  5) Se conteggio ad anno solare:
        - se esiste il profilo individuale ne leggo semplicemente le competenze
        - altrimenti calcolo le competenze tenendo conto dei cambiamenti di profilo
          nel corso dell'anno per proporzionare le comptenze di ciascun profilo:
          procedura CompetenzeProporzionate
  6) Leggo l'unità di misura di fruizione, a seconda dei punti precedenti,
     direttamente sulla causale, sul profilo individuale o sul profilo storico del
     periodo in cui inserisco l'assenza
  7) Sommo le competenze ottenute con gli eventuali residui.

  Analisi della procedura CompetenzeProporzionate:
    1) Seleziono i movimenti storici dal 1/1/aaaa al 31/12/aaaa
    2) Registro i dati di ciascuna movimentazione in una struttura contenente:
       DataAssunzione, DataCessazione, DataDecorrenza, DataFine, ProfiloAssenza,
       NumeroGiorni
       NumeroGiorni contiene i giorni di quel movimento storico che rientrano nel-
       l'anno e nella data di assunzione e cessazione
    3) Se il raggruppamento è Ferie o Festività soppresse calcolo eventuali
       arrotondamenti sulle date di assunzione/cessazione:
       a) Leggo i profili dell'anno considerando le date di assunzione/cessazione;
          posso avere i seguenti casi:
          - arrotondamento solo per assunzione:
            se i giorni fatti nel mese sono >= ArrotFerie, allora inserisco i
            giorni rimanenti del mese nel movimento in cui c'è la data di assunzione;
            se i giorni sono < ArrotFerie, tolgo i giorni fatti nel mese partendo
            dal movimento in cui c'è la data di assunzione, e anadando sui movimenti
            succesivi nel caso non ci siano abbastanza giorni da togliere
          - arrotondamento solo per cessazione:
            se i giorni fatti nel mese sono >= ArrotFerie, allora inserisco i
            giorni rimanenti del mese nel movimento in cui c'è la data di cessazione;
            se i giorni sono < ArrotFerie, tolgo i giorni fatti nel mese partendo
            dal movimento in cui c'è la data di cessazione, e anadando sui movimenti
            precedenti nel caso non ci siano abbastanza giorni da togliere
          - arrotondamento su assunzione e cessazione:
            se c'è stato un arrotondamento positivo su assunzione o cessazione non
            faccio operazioni particolari;
            se tutti e due gli arrotondamenti risultano negativi, per non sfavorire
            troppo si tiene conto della somma dei giorni lavorati nel primo e
            nell'ultimo mese.
            Si applica l'arrotondamento sulla somma:
              se la somma < ArrotFerie si tolgono i giorni lavorati
              sia partendo dall'assunzione che dalla cessazione;
              se la somma >= ArrotFerie, aggiungo ai movimenti di assunzione e
              cessazione tanti  giorni in modo da ottenere 15 gg per parte
    4) Raggruppo i dati in due vettori CodProfili e GgProfili contenenti
       il totale dei giorni per ciascun codice profilo
    5) Calcolo le competenze leggendo CodProfili
       - per ogni profilo leggo le sue competenze annuali
       - a seconda dell'unità di misura converto le competenze in minuti o giornate
       - proporziono le competenze annuali ai giorni contenuti in GgProfili sommando
         le competenze in fasce in 'Competenze'.
       - Arrotondo i valori ottenuti al minuto o alla MezzaGiornata
}

interface

uses
  {$IFNDEF IRISWEB}
  Windows, Messages, Graphics, Forms, Dialogs, Grids, R600Anomalie, ComCtrls,
  {$ENDIF}
  SysUtils,
  Classes,
  Controls,
  Db, R500Lin, C180FunzioniGenerali, Rp502Pro,
  A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia,
  RegistrazioneLog, QueryStorico, Oracle, OracleData, Math, Variants, DBClient,
  (*B021UUtils,*) StrUtils
  {$IFNDEF IRISWEB},OracleMonitor{$ENDIF};

const ArrotFerie = 15;
      DataFine = '31/12/3999';
      DataNome = 'Data:%s Matricola:%-8s %s%sCausale:%-5s%s';
      CRiposo = 'H';
      CRiposoComp = 'E';

      NumMessaggi = 39;
      constMessaggi:array [1..NumMessaggi] of String =
{1}              ('Sono presenti le seguenti timbrature:%s %s %s',
{2}               'Giornata già giustificata con codice %s',
{3}               'Non sono ammesse più di 2 giornate di assenza',
{4}               'Non sono ammesse più di 2 mezze giornate di assenza',
{5}               'Non sono ammessi più di %d giustificativi di assenza',
{6}               'Intersezione con altro giustificativo da %s a %s',
{7}               'Timbrature non in sequenza - Impossibile verificare le intersezioni',
{8}               'Causale di riposo già esistente.',
{9}               'Non si può inserire un riposo che non sia una giornata intera.',
{10}              'Intersezione con timbrature E%s U%s',
{11}              'Storici non disponibili per verificare le abilitazioni a questa causale.',
{12}              'Causale non abilitata.',
{13}              'Dato storico in anagrafico non accessibile.',
{14}              'Giorno escluso dal periodo di fruizione (%s - %s).',
{15}              'Data di assunzione non reperibile ai fini del cumulo assenze.',
{16}              'La durata del periodo di cumulo è nulla.',
{17}              'Non esiste la causale di riferimento per il cumulo.',
{18}              'Manca la data di riferimento per il cumulo.',
{19}              'Sono state superate le competenze della %d° fascia.',
{20}              'Sono state esaurite le competenze.',
{21}              'E'' stata superata la competenza unitaria della causale.',
{22}              'Le ore fruite nel giorno superano il massimo previsto nel profilo assenza.',
{23}              'Giornata già giustificata con causale non di riposo',
{24}              'Sono state esaurite le competenze della causale %s, e verrà ora utilizzata la causale %s',
{25}              'E'' stato raggiunto il numero massimo di fruizioni disponibili.',
{26}              'Dipendente non in servizio',
{27}              'Errore in Periodo di Cumulo personalizzato: %s',
{28}              'Errore in Competenze personalizzate: %s',
{29}              'Le fruizioni coprono più di una giornata intera',
{30}              'La fruizione è limitata al periodo %s',
{31}              'Incompatibilità con causale già presente, %s',
{32}              'Le ore fruite nel giorno superano il massimo previsto in funzione delle ore lavorative.',
{33}              'Assenza non fruibile nel giorno di festività particolare %s.',
{34}              'E'' stato raggiunto il numero massimo di fruizioni di %s',
{35}              'Non sono ammesse due mezze giornate dello stesso tipo (%s)',
{36}              'Incompatibilità con fruizioni già presenti nel giorno con le seguenti causali: %s',
{37}              'Sono state esaurite le competenze della causale collegata %s',
{38}              'È stato raggiunto il numero massimo di fruizioni a giornate previsto nel profilo assenza',
{39}              'Calendario non esistente'
                  );

type
  TGiustificativo = record
    Inserimento:Boolean;
    Modo:Char;
    DataGiust:TDateTime;
    Causale,
    DaOre,AOre,
    CodRagg,              //Cod. Interno di Raggruppamento
    Raggruppamento,
    Note:String;//Codice raggruppamento su T265
    ProgrCausale:Integer;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    CSITipoMG: String;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  end;

  TAssenzeCumulate = record
    Data,
    Causale,
    Tipo,
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    CSITipoMG,
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    Ore:String;
    DTData:TDateTime;
    Coniuge:Boolean;        //Lorena  03/12/2002
    RichiestaWeb:Boolean;   //Alberto 05/03/2010
    DaVisualizzare:Boolean; //se False non si visualizza nella grid
    OreConteggiate:String;
  end;

  TArrAssenzeCumulate = array of TAssenzeCumulate;

  TPeriodiCumulati = record
    Dal,Al:TDateTime;
    Causali:String;
    Coniuge:Boolean;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    NumGiorni,NumGiorniDip,NumGiorniConiuge: Real;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
  end;

  TProfAssenze = record
    Codice:String;
    Assunzione,Cessazione,
    Decorr,Fine,
    ValidoDal,ValidoAl:TDateTime;
    Giorni:LongInt;
    Minimo:Integer;
    VariazAssCess:Integer;
    TipoProporzione,PropCompGGMMRA,SommaAssCess,
    FormulaProporzione:String;
    PartTime:Real;  //Lorena 09/05/2006
  end;

  TProfPartTime = record
    ValidoDal,ValidoAl:TDateTime;
    Percentuale:Real;
  end;

  TTimbrat = record
    E,U,CausE,CausU:String;
  end;

  TCumuloM = record
    OreSett,         //Debito settimanale da anagrafico
    CompAn,          //Comp. annuali (MaxUnitario)
    CompSett,        //Comp. sett. (MaxUnitario/52)
    CompCorr,        //Comp. annuali reali fino alla data richiesta
    LavAnno:Int64; //Lavorato fino alla data richiesta
  end;

  TRapporto = record
    Inizio,Fine:TDateTime;
  end;

  TRapportoCorrente = record
    Esiste,CompetenzeDelPeriodo:Boolean;
    DataCorrente:TDateTime;
    Rapporto:array of TRapporto;
  end;

  TAssenzeConteggiate = record
    data:TDateTime;
    tipo:Char;
    causale:String;
    tipomg:String;
    tminresasse,tminvalasse,tminvalcompasse,tminasse,
    tggasse,tmezggasse:Integer;
  end;

  TFruizGiornaliereHMA = record
    causale:String;
    data:TDateTime;
    resto:Integer;
  end;

  TRiferimentoDataNascita = record
    Esiste:Boolean;
    Data:TDateTime;
    IDFamiliare,GradoPar:String;
    PartFruizMaternita:String;
  end;

  TConteggiOld = record
    Prg:LongInt;
    Data:TDateTime;
  end;

  TRiepQualMin = record
    DebitoGGQM:Integer;
    NumGiorniSett:Integer;
    OreSett:Integer;
    Quantita:Real;
  end;

  TValiditaProfili = record
    Competenza,
    CompetenzaLorda:Real;
  end;

  // informazioni per la gestione delle visite fiscali
  TVisiteFiscali = record
    Progressivo: Integer;
    DateArr: array of TDateTime;  // array di date per il periodo da considerare
    NumDate: Integer;             // numero di date valide dell'array DateArr [1..NumDate] (NumDate <= High(DateArr))
    CodComune,                    // dati di domicilio alternativo: codice comune
    Indirizzo,                    // dati di domicilio alternativo: indirizzo
    Cap,                          // dati di domicilio alternativo: cap
    Telefono,                     // dati di domicilio alternativo: telefono
    MedicinaLegale,               // medicina legale di competenza alternativa
    Note,
    TipoEsenzione,                // tipo esenzione
    OperatoreEsenzione: String;   // operatore esenzione
    DataEsenzione: TDateTime;     // data esenzione
  end;

  //USato da IrisWeb W008-W010
  TRiepilogoAssenze = record
    Matricola,Nominativo,Familiare,UM:String;
    CompFinale,CP,CC,CT,FP,FC,FT,R,RP,RC,CParz,RParz,IterRich,IterAut:String;
    H_CP,H_CC,H_CT,H_FP,H_FC,H_FT,H_R,H_RP,H_RC,H_CParz,H_RParz,H_IterRich,H_IterAut:String;
    ProfiloAssenze,PeriodoCumulo:String;
    CompLordeAC,VarPeriodiRapporto,AbbattiAssCess,DecurtazNonMatura,VarPartTime:String;
    VarAbilitazioneAnagrafica,VarCompManuale,CompNetteAC:String;
    VarFruizMMInteri,VarFruizMMInteriDip,VarMaxIndividuale,VarFruizMMContinuativi,VarFruizMMContinuativiDip,VarGGNoLavVuoti:String;
    VarFestePartic:String;
    Messaggio,PartTime,TitoloFruizMinimaAC,FruizMinimaAC:String;
    VisFamRif,EsisteResiduo,Residuabile,ArrotOre2Giorni,CompAnnoSolare:Boolean;
    NumPeriodi:Integer;
  end;

  TR600DtM1 = class(TDataModule)
    DFruizione: TDataSource;
    RiposiEsistenti: TOracleDataSet;
    CausaleRiposo: TOracleDataSet;
    CausFruizione: TOracleDataSet;
    AssenzeCollettive: TOracleDataSet;
    QuantAssenze: TOracleDataSet;
    Q040: TOracleDataSet;
    Q080: TOracleDataSet;
    Q100: TOracleDataSet;
    Q262: TOracleDataSet;
    Q262B: TOracleDataSet;
    Q262C: TOracleDataSet;
    Q263: TOracleDataSet;
    Q264: TOracleDataSet;
    GiustifDaOre: TOracleDataSet;
    Q130: TOracleDataSet;
    QAnagra: TOracleDataSet;
    Q430: TOracleDataSet;
    Q430Ragg: TOracleDataSet;
    NonMaturaFerie: TOracleDataSet;
    NumRiposi: TOracleDataSet;
    GetInizioAssenza: TOracleQuery;
    GetCalend: TOracleQuery;
    GetUMisura: TOracleQuery;
    Q265: TOracleDataSet;
    selMinDataDecorrenza: TOracleQuery;
    selPartTime: TOracleDataSet;
    GetGiorniServizio: TOracleQuery;
    selSG101: TOracleDataSet;
    QuantAssenzeDataNas: TOracleDataSet;
    selT040DataNas: TOracleDataSet;
    selGGnonLav: TOracleQuery;
    GiustifEsistenti: TOracleDataSet;
    PeriodiAssenza: TOracleQuery;
    selSG101NumOrd: TOracleDataSet;
    selT131: TOracleDataSet;
    selT262: TOracleDataSet;
    ScrBancaOreResidua: TOracleQuery;
    selFestiviInfraSett: TOracleQuery;
    QuantAssenzeQualMin: TOracleDataSet;
    selV010: TOracleDataSet;
    selT460: TOracleDataSet;
    selT266: TOracleDataSet;
    cdsPeriodiAssenza: TClientDataSet;
    selPeriodiAssenza: TOracleDataSet;
    scrDieciGiorniPrima: TOracleQuery;
    scrDieciGiorniDopo: TOracleQuery;
    selT047: TOracleDataSet;
    selT047CancPrec: TOracleDataSet;
    selT047Prec: TOracleDataSet;
    selT047Succ: TOracleDataSet;
    selT047InsPrec: TOracleDataSet;
    selT047InsPrecCom: TOracleDataSet;
    scrL133PServeCertificPubbl: TOracleQuery;
    selRapportiUniti: TOracleQuery;
    scrCausAssCatena: TOracleQuery;
    selT040Concat: TOracleDataSet;
    selSG101DataNas: TOracleDataSet;
    selCompS: TOracleDataSet;
    selT275: TOracleDataSet;
    selSG101Causali: TOracleDataSet;
    selT050: TOracleDataSet;
    selT460a: TOracleDataSet;
    cdsFruizioni: TClientDataSet;
    selGGContinuativi: TOracleQuery;
    selPresAbil: TOracleDataSet;
    selCatenaCausali: TOracleQuery;
    GetTurRepFest: TOracleQuery;
    selConiuge: TOracleQuery;
    T380F_Turnifestivi_NOChiamata: TOracleQuery;
    T265P_GETPERIODOCUMULO: TOracleQuery;
    T265P_GETCOMPETENZE: TOracleQuery;
    T265F_GETINIZIOCATENA: TOracleQuery;
    T265F_GETCATENACOMPLETA: TOracleQuery;
    T265P_COMP_CONGPARENTALI: TOracleQuery;
    T265P_ARROTCOMPETENZE: TOracleQuery;
    selT025: TOracleDataSet;
    selCausIncomp: TOracleQuery;
    selCSI010: TOracleDataSet;
    T265P_COMP_FESTEPARTIC: TOracleQuery;
    selT071Assestamento: TOracleDataSet;
    selCountFruizioniMGData: TOracleQuery;
    T040F_CHECKFRUIZCOMPATIBILE: TOracleQuery;
    T230F_HMASSENZA_PROPPT: TOracleQuery;
    T230F_GETVALUE: TOracleQuery;
    T230F_CHECK_SCARICOPAGHE_FRUIZ: TOracleQuery;
    scrDelT040GGAuto: TOracleQuery;
    scrT040UltimoGGAuto: TOracleQuery;
    selT040GGAuto: TOracleDataSet;
    selT265GGAutoFruizGG: TOracleDataSet;
    selT040Aspettative: TOracleQuery;
  private
    VariazioneCompetenze:String;
    CompTotali,CompArrotondate,CompSoloFerie,VariazioneCompetenzeF:Real;
    VariazionePartTime,VariazionePeriodiRapporto,VariazioneAbilitazioneAnagrafica:Real;
    VariazioneFruizMMInteri,VariazioneFruizMMInteriDip,VariazioneMaxIndividuale,
    VariazioneFruizMMContinuativi,VariazioneFruizMMContinuativiDip,
    VariazioneGGNoLavVuoti,VariazioneFestePartic:Real;
    ArrotMG,ArrotFav,ArrotOre,Matricola,Nome,CodIntQ260,CausAnomala:String;
    DProfiloAssenze,ProfiloAssenze:String;
    MaxUnitario, MaxUnitarioOld,MaxUnitarioOri,TotResiduo, FruizMinimaAC:Real;
    NumTimb:Byte;
    LCausCollegate:TStringList;
    Messaggi:array [1..NumMessaggi] of String;
    ProfAssenze:array [1..266] of TProfAssenze;
    CodProfili:array [1..24] of String;
    GgProfili:array [1..24] of TValiditaProfili;
    MmProfili:array [1..24] of TValiditaProfili;
    Timbrat:array [1..20] of TTimbrat;
    ProfPartTime:array of TProfPartTime;
    AssenzeConteggiate:array of TAssenzeConteggiate;
    AssAbbateFerieMM:array [1..12] of integer;
    AssAbbateRateoMM:array [1..12] of integer;
    AssenzeCumulate: TArrAssenzeCumulate; //array of TAssenzeCumulate;
    InizioRiduzioni:Boolean;
    CompetenzeAnnoSolare:Boolean;
    NumProfili,ProfiliSingoli:Integer;
    EsisteCumulo,EsisteFruizione,FineResiduo:Boolean;
    EsisteMaxUnitario,EsisteMaxFasce:Boolean;
    FruizDa,FruizA,LimiteResiduo,InizioFruizForzataAC,
    InizioCumulo:TDateTime;
    InizioCumuloIntero:TDateTime;
    InizioConteggi,FineConteggi:TDateTime;
    GiorniTot,GiorniUni,FruitoAP,FruitoAP_Ore,
    FruitoForzatoAC,FruitoForzatoAC_Ore:Real;
    OreTot,OreUni,OreConteggiate:LongInt;
    GiornataOre:Integer;
    CumuloM:TCumuloM;
    LStorico:TStringList;
    QSDip:TQueryStorico;
    DipendenteInServizio:TDipendenteInServizio;
    GiustifPrec:TGiustificativo;
    RapportoCorrente:TRapportoCorrente;
    RiepQualMin:TRiepQualMin;
    PropGG,PropMM:Real;
    PropMensile,PropRatei:Boolean;
    triepgiusasse_vuoto:t_triepgiusasse;
    tgiustific_vuoto:t_tgiustificdipmese;
    SessioneOracleR600:TOracleSession;
    FruitoCompPrec:Real;
    FruitoSommaAssenza:Real;
    RettificaCatenaCompetenze:Boolean;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    FruizMGMat, FruizMGPom: Integer;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    function Anomalie(Bottoni:Integer; Info:String):TModalResult;
    function _Anomalie(Bottoni:Integer; Info:String):TModalResult;
    procedure GetPeriodiRapporto_PartTime;
    procedure ProporzionaCompetenzePeriodiRapporto;
    procedure ProporzionaCompetenzeTipoRapporto;
    procedure ProporzionaCompetenzePartTime;
    procedure ProporzionaResiduiPartTime(Data:TDateTime; var PTPrec:TProfPartTime; Arrotonda:Boolean);
    procedure ProporzionaAbilitazioneAnagrafica;
    procedure VariazioneManualeCompetenze;
    procedure SettaProgressivo;
    procedure CercaCompetenze;
    procedure LeggiCompetenze(Source:Byte);
    procedure GetCompetenzeDelPeriodo(Inizio,Fine:TDateTime);
    procedure ValorizzaCompetenze(Sorg:array of String; var Dest:array of Real; UM:String; Incrementa:Boolean);
    procedure PeriodoFruizione;
    procedure CercaProfiloAssenze(A:Integer; CercaCompetenze:Boolean);
    procedure CompetenzeProporzionate(Anno:Integer; CalcolaCompetenzeParziali:Boolean);
    procedure ArrotondaAssCess(Ind1,Ind2:Integer; Ass,Cess:TDateTime; Modo:Byte);
    procedure ArrotondamentoAssunzCessaz(Anno1,Anno2:TDateTime);
    procedure TogliGiorni(Ind1,Ind2,Tot:Integer);
    procedure RaggruppaProfili;
    procedure TogliMaturazFerie(Anno1,Anno2:TDateTime);
    function  CalcolaCompetenze(Anno:Word):Real;
    procedure ArrotondaCompetenze(var Vettore: array of Real);
    procedure ProporzionaCompetenze(idxProfilo,Anno:Integer; PropGGMM:String);
    procedure CalcolaCumuli(PropResid:Boolean);
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    //procedure ConteggiAssenza(ChiamanteConteggi:String; Data:TDateTime; Causale:String; Tipo:Char; DaOre,AOre:TDateTime; Prg:LongInt);    
    procedure ConteggiAssenza(ChiamanteConteggi:String; Data:TDateTime; Causale:String; Tipo:Char; TipoMG:String; DaOre,AOre:TDateTime; Prg:LongInt);
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    procedure SommaAssenza(CodCaus:String; PuntGiustR600,NA:Integer; Caricato:Boolean; TipoGiust:Char);
    procedure TrasferisciCompetenze(Sorg:array of Real; var Dest:array of Real; Incrementa:Boolean);
    procedure ValorizzaOreInGiorni;
    function  PeriodoDiCumulo(DataInizio:TDateTime):TModalResult;
    function  EsistonoCompetenzeFasce:Boolean;
    function  TimbrInSeq(Data:TDateTime):Boolean;
    function  GiornoLavorativo(Data:TDateTime):TModalResult;
    function  RiposoPianificato(Data:TDateTime):TModalResult;
    function  CumuloAssenze:TModalResult;
    function  GetTotaleResidui:Real;
    procedure GetVariazioniCongediParentali(PInizio, PFine: TDateTime);
    procedure GetVariazioniFestivitaParticolari(PInizio, PFine: TDateTime);
    //function UnitaMisura(Causale:String):String;
    function  GetMaxUnitario(UM:String):Real;
    function  ArrotondaGiorno(R:Real; ApplicaArrotMG:Boolean=True):Real;
    function  ArrotondaOre(R:Real):Real;
    function  AggiornaCompetenzeCumuli(Data:TDateTime):TModalResult;
    function  SottraiCompetenze(var Dest:array of Real; Giorni:Real; Ore:LongInt; Data:TDateTime; Messaggio:Boolean):TModalResult;
    function  SottraiMaxUnitario(var Dest:Real; Giorni:Real; Ore:LongInt; Data:TDateTime; Messaggio:Boolean):TModalResult;
    procedure CalcolaLavorato(Inizio,Fine:TDateTime);
    procedure GetSaldiScheda(Data:TDateTime);
    procedure GetOreAssestamento(Data:TDateTime);
    procedure GetSaldoSettimanale;
    procedure GetSaldiGiornalieri(ConsideraT025:Boolean);
    procedure GetCausaliFruite(Dal,Al:TDateTime);
    procedure GetRecuperoPeriodico(D:TDateTime);
    function  MaturAssenze:Integer;
    procedure GetResiduiAnnoPrec(Anno:Integer);
    procedure GetProporzione(Data:TDateTime; Profilo,Raggr:String);
    procedure DividiPrecCorr;
    procedure GetFesteLavorate(Inizio,Fine:TDateTime);
    procedure GetFesteInfrasettimanali(Inizio,Fine:TDateTime);
    procedure GetTurniReperibilitaFestivi(Inizio,Fine:TDateTime);
    procedure GetGiorniNonLavorativi(Inizio,Fine:TDateTime);
    procedure GetTurniReperibilitaNOChiamata(Inizio,Fine:TDateTime);
    procedure CreaCdsFruizioni;
    procedure AddGiustificativiR600(puntAssCum:Integer);
    procedure ConteggiaGiorno(ConteggiOld:TConteggiOld; PropResid:Boolean; var PTPrec:TProfPartTime);
    function  GetNumPeriodiAssenzeCumulate(D:TDateTime; Causale:String; IncludiTutto:Boolean):Integer;
    function  GetFruizGGCumulate: Real;
    function  GetUltimaFruizione:Real;
    procedure GetCatenaCausAss(const PCausale: String; var RCatenaNorm, RCatenaL133, RCatenaRaggr: String); overload;
    function  ElencoProfPartTime:String;
    function  DescrizioneProfiloAssenze:String;
    function  DescrizionePeriodoCumulo:String;
    function  TitoloFruizioneMinimaAC:String;
    function  InizializzaSettaConteggi(Prog:LongInt; Inizio,Fine:TDateTime; Giustif:TGiustificativo):Boolean;
    function  ChekCompetenzeCollegate(Progressivo:Integer; Data:TDateTime; Giustificativo:TGiustificativo; Causale:String):Boolean;
    procedure CorreggiCumuliAspettativa;
  public
    { Public declarations }
    //04/09/2013 Spostate da private a public per utilizzo da WC023 - ini
    LetturaAssenze,Visualizza(*,ValorizzazioneOraria*):Boolean;
    FineCumulo:TDateTime;//04/09/2013 Spostate da private a public per utilizzo da WC023
    FineCumuloIntero:TDateTime;
    //04/09/2013  - fine
    UltimaAnomalia:String;
    TipoCumulo:Char;
    VisualizzaAnomalie,
    AnomalieBloccanti,
    AssenzaAbilitata,
    CalcolaCompetenzeDelPeriodo,
    EsisteResiduo,
    PassaggioDiAnno:Boolean;
    Progressivo:LongInt;
    DaData,AData:TDateTime;
    AnomalieNonBloccanti:String;
    ListAnomalie:TStringList;
    ListAnomalieNonBloccanti:TStringList;
    CompetenzeLette,Residui:array [1..6] of String;
    DestApp:array [0..5] of Real;
    ResiduiVal,ResiduiOri,Competenze,CompetenzeApp,
    CompetenzeOld,CompetenzeOri, CompetenzeParziali,
    VisCompetenzeAC,VisFruitoAP,VisFruitoAC:array [1..6] of Real;
    Riduzioni:Array[1..6] of Integer;
    RecupCumuloT:array of Integer;
    FruizCompPrecCumuloT:Integer;
    Giustificativo,OldGiustif:TGiustificativo;  //Usato per modifica causale da cartellino
    OreReseDaAssenza,ValenzaGiornaliera:Integer;
    LetturaRiduzioni,FasceDiRiduzione,EsisteRiduzione,GGSignific:Boolean;
    ScaricoPaghe:Boolean;
    TO_CSI_SaltaSettimanaCorrente:Boolean;
    FruitoCorrGG:Real;
    FruitoCorrHH:Integer;
    CompetenzeDelPeriodo:Real;
    RiferimentoDataNascita:TRiferimentoDataNascita;
    UMisura,
    GetCompPrec,GetCompCorr,GetCompTot,GetCompParz,
    GetFruitoPrec,GetFruitoCorr,GetFruitoTot,
    GetResiduo,GetResiduoPrec,GetResiduoCorr,GetResiduoParz,GetIterRichiesto,GetIterAutorizzato,
    GetCompAssIndivid,GetFruitoGGIndivid,GetResiduoGGIndivid, // TORINO_CSI - commessa 2015/142 SVILUPPO#7
    GetVariazioneFruizMMInteri,GetVariazioneFruizMMInteriDip,GetVariazioneMaxIndividuale:String; // csi
    ValCompPrec,ValCompCorr,ValCompTot,ValCompParz,
    ValFruitoPrec,ValFruitoCorr,ValFruitoTot,
    ValResiduo,ValResiduoPrec,ValResiduoCorr,ValResiduoParz,
    ValResiduoGG,ValResiduoPrecGG,ValResiduoCorrGG,ValIterRichiesto,ValIterAutorizzato,
    ValCompIndivConiugeEsistente: Real;
    AnomaliaAssenze:Byte;
    R502ProDtM1:TR502ProDtM1;
    VisFiscali:TVisiteFiscali;
    EsistonoAnomalieBloccanti:Boolean;
    InserimentoImpedito:Boolean;
    CheckIntersezioneTimbrature:Boolean;  //Usato da A004UCaricaAssRich per evitare il controllo sulle timbrature quando il giustif. arriva da web
    AssenzeConteggiate_Inserita:Boolean;
    IterAUtorizzativo,RichiesteIterAutorizzativo:Boolean;
    PeriodiCumulati:array of TPeriodiCumulati;
    AssenzeCumulateOrdData: TArrAssenzeCumulate;
    RiepilogoAssenze:array of TRiepilogoAssenze;  //Usato da W008-W010
    {$IFNDEF IRISWEB}R600FAnomalie: TR600FAnomalie;{$ENDIF}
    lstFruizGiornaliereHMA:array of TFruizGiornaliereHMA;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    function ControlliGenerali(Data:TDateTime; CheckSoloCompetenze:Boolean = False):TModalResult;
    function IntersezioneGiustTimb(Prog:LongInt; Data:TDateTime; CheckTimb:Boolean = True):TModalResult;
    function CausalePresenzaAbilitata(Prog:LongInt; Data:TDateTime):TModalResult;
    function SettaPeriodoCumulo(Prog:LongInt; Data:TDateTime; Giustif:TGiustificativo):Boolean;
    function SettaConteggi(Prog:LongInt; Inizio,Fine:TDateTime; Giustif:TGiustificativo):TModalResult;
    procedure ControllaVincoliFruizione(Minuti,Minimo,Massimo,Arrot:Integer; var Fruizione:Integer);
    procedure ControllaFruizMaxDebito(D:TDateTime; P,Minuti:Integer; Causale,TG,Dalle,Alle:String; var Fruizione:Integer);
    function SuperoFruizMaxOre(DataIns:TDateTime; Progressivo,Durata:Integer; Causale:String):boolean;
    function GiornoSignificativo(Data:TDateTime):TModalResult;
    function MGSignificativa(Data:TDateTime):TModalResult;
    procedure OrdinaAssCumulatePerData(var ArrSrc, ArrOrd: TArrAssenzeCumulate);
    procedure RiepilogaAssenze(Prog:Integer; dDataRiep:TDateTime; G:TGiustificativo; PEsisteRifDataNas:Boolean; DataNas: TRiferimentoDataNascita);
    procedure VisualizzaAssenze(Prog:LongInt; Inizio:TDateTime; Giustif:TGiustificativo);
    function SwitchRiepilogoConiuge(PRiepIndividuale:Boolean; var PRiepAss:TRiepilogoAssenze):Boolean;
    procedure GetAssenze(Prog:LongInt; Data,Fine,DataNas:TDateTime; Giustif:TGiustificativo; LettAss:Boolean = True);
    function  GetValStrT230(Causale,Nome:String; Data:TDateTime):String;
    function  CheckScaricoPagheFruiz(Causale,TipoGiust:String; Data:TDateTime):String;
    function  GetHMAssenza(Prog:LongInt; Data:TDateTime; Causale:String):Integer;
    function GetUnitaMisura(Prog:LongInt; Inizio:TDateTime; Gius:TGiustificativo):String;
    procedure GetRiduzione(Prog:LongInt; Data,Fine,DataNas:TDateTime; Giustif:TGiustificativo;
                           var UM,CP,CC,CT,FP,FC,FT,R:String; var ValGio,Giorno:Integer; InizioElab:Boolean; LettAss:Boolean = True);
    procedure GetQuantitaAssenze(Prog:LongInt; Inizio,Fine,DataNas:TDateTime; Giustif:TGiustificativo; var UM:String; var Quantita,OreRese:Real);
    procedure GetQuantitaAssenzeQualMin(Prog:LongInt; Inizio,Fine,DataNas:TDateTime; Giustif:TGiustificativo; var Quantita:Real);
    procedure GetIDFamiliare(PProgressivo:Integer);
    procedure GetPeriodiAssenza(Causali:String); //Lorena 03/06/2008
    function GetTotCompetenze:Real;
    function ContaGiustifAssFuturi(Progressivo: Integer; DataLimite: TDateTime; Giustif: TGiustificativo; DataFamiliare:String): Integer;
    procedure GestioneGiustifAssFuturi(Progressivo: Integer; DataLimite: TDateTime; Giustif: TGiustificativo; DataFamiliare: String {$IFNDEF IRISWEB}; const PrbElab: TProgressBar = nil{$ENDIF IRISWEB});
    procedure ChiudiGiustifAssFuturi;
    procedure VisFiscaliAddData(Data: TDateTime);
    procedure VisFiscaliSetArray(NewDim: Integer);
    procedure VisFiscaliFreeArray;
    procedure VisFiscaliInsPeriodi;
    procedure VisFiscaliCanPeriodi;
    function ServeCertificazionePubblica(Progressivo: Integer; Causale: String; D1,D2:TDateTime):Boolean;
    function FormattaAnomaliaWeb(const Testo:String; MostraCausale: Boolean = True):String; overload;
    function FormattaAnomaliaWeb(Lista:TStringList; MostraCausale: Boolean = True; MostraNome: Boolean = True):String; overload;
    function ImpostaLengthAssenzeConteggiate(Offset: Integer): Integer;
    function RimuoviAssenzeConteggiate(Data: TDateTime): Integer;
    function AllarmeFruizioneContinuativa(Progressivo:Integer; Data:TDateTime; Causale:String; Periodo:Integer):String;
    procedure SettaInfo1(pCognome,pNome,pMatricola,pCausale:String);
    function  TrasformaOre2Giorni(Ore:Real):Real;
    function  IsInizioCatenaCausAss(const PCausale: String; var RCausInizio: String): Boolean;
    procedure GetCatenaCausAss(const PCausale: String; var RCatena: String); overload; // l'altra procedure in overload è private
    function  SuddividiFruizione(var TG,Da,A,TGSucc,DaSucc,ASucc:String):Boolean;
    procedure CumuloAssenzeHMA(parCausale:String; parInizioCumulo,parFineCumulo:TDateTime; parResto:Integer);
    function  AcquisizioneRichiesteAuto(lstID:String; var Errore:String; var NumScartate,NumRichieste:Integer):Boolean;
    property UltimaFruizione:Real read GetUltimaFruizione;
    property ValCompTotali:Real read CompTotali;
    property ValVariazionePeriodiRapporto:Real read VariazionePeriodiRapporto;
    property ValCompArrotondate:Real read CompArrotondate;
    property ValCompSoloFerie:Real read CompSoloFerie;
    property ValVariazionePartTime:Real read VariazionePartTime;
    property ValVariazioneAbilitazioneAnagrafica:Real read VariazioneAbilitazioneAnagrafica;
    property ValVariazioneCompetenzeF:Real read VariazioneCompetenzeF;
    // AOSTA_REGIONE - commessa 2012/152.ini
    property ValVariazioneFruizMMInteri: Real read VariazioneFruizMMInteri;
    property ValVariazioneFruizMMInteriDip: Real read VariazioneFruizMMInteriDip; // TORINO_CSI - evolutive 02/10/2015
    property ValVariazioneMaxIndividuale: Real read VariazioneMaxIndividuale;
    property ValVariazioneFruizMMContinuativi: Real read VariazioneFruizMMContinuativi;
    property ValVariazioneFruizMMContinuativiDip: Real read VariazioneFruizMMContinuativiDip; // TORINO_CSI - evolutive 02/10/2015
    property ValVariazioneGGNoLavVuoti: Real read VariazioneGGNoLavVuoti;
    // AOSTA_REGIONE - commessa 2012/152.fine
    property ValVariazioneFestePartic: Real read VariazioneFestePartic;
    property ValFruizMinimaAC:Real read FruizMinimaAC;
    property ptFineResiduo:Boolean read FineResiduo;
    property ptLimiteResiduo:TDateTime read LimiteResiduo;
    property ptInizioCumulo:TDateTime read InizioCumulo;
    property ptFineCumulo:TDateTime read FineCumulo;
  end;

implementation

uses {$IFNDEF IRISWEB}
      R600UVisAssenze, R600UVisAssenzeCumulate, R600UFruiz,
     {$ENDIF}
     A004UGiustifAssPresMW, R450;

{$R *.DFM}

constructor TR600DtM1.Create(AOwner:TComponent);
{Creo il Data Module, imposto il database per le Query, le preparo e le apro}
var i:Integer;
begin
  inherited Create(AOwner);
  Self.Name:='';
  SessioneOracleR600:=SessioneOracle;
  if AOwner <> nil then
    if AOwner is TOracleSession then
      SessioneOracleR600:=AOwner as TOracleSession;
  {$IFNDEF IRISWEB}
  R600FAnomalie:=TR600FAnomalie.Create(nil);
  {$ENDIF}
  OldGiustif.AOre:='';
  OldGiustif.Causale:='';
  OldGiustif.CodRagg:='';
  OldGiustif.DaOre:='';
  OldGiustif.Inserimento:=False;
  OldGiustif.Modo:=#0;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  OldGiustif.CSITipoMG:='';
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  OldGiustif.Raggruppamento:='';
  OldGiustif.ProgrCausale:=-1;

  GiustifPrec.AOre:='';
  GiustifPrec.Causale:='';
  GiustifPrec.CodRagg:='';
  GiustifPrec.DaOre:='';
  GiustifPrec.Inserimento:=False;
  GiustifPrec.Modo:=#0;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  GiustifPrec.CSITipoMG:='';
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  GiustifPrec.Raggruppamento:='';
  GiustifPrec.ProgrCausale:=-1;

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  FruizMGMat:=0;
  FruizMGPom:=0;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

  ListAnomalie:=TStringList.Create;
  ListAnomalieNonBloccanti:=TStringList.Create;
  AnomalieNonBloccanti:='';
  LStorico:=TStringList.Create;
  LCausCollegate:=TStringList.Create;
  LetturaAssenze:=False;
  LetturaRiduzioni:=False;
  Visualizza:=False;
  (*ValorizzazioneOraria:=False;*)
  Progressivo:=0;
  DaData:=0;
  AData:=0;
  InizioConteggi:=0;
  FineConteggi:=0;
  RiferimentoDataNascita.Esiste:=False;
  VisualizzaAnomalie:=True;
  AnomalieBloccanti:=False;
  CalcolaCompetenzeDelPeriodo:=False;
  ScaricoPaghe:=False;
  PassaggioDiAnno:=False;
  EsistonoAnomalieBloccanti:=False;
  InserimentoImpedito:=False;
  UltimaAnomalia:='';
  RettificaCatenaCompetenze:=False;
  CheckIntersezioneTimbrature:=True;
  RichiesteIterAutorizzativo:=True;  //Dice se considerare o meno le richieste provenienti da iter autorizzativo non ancora autorizzare
  IterAutorizzativo:=False; //Dice se l'R600 viene usato nel contesto dell'iter autorizzativo (W018) o meno (A004, W010, ecc...): alcuni controlli possono cambiare
  TO_CSI_SaltaSettimanaCorrente:=True; //Per le competenze della banca ore di TORINO_CSI (1100): le competenza visualizzate sul cartellino devono essere fatte con False
  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
    begin
      (Components[i] as TOracleQuery).Session:=SessioneOracleR600;
      if (pos('/*NOHINT',UpperCase(TOracleQuery(Components[i]).SQL.Text)) > 0) or (pos('/*SIHINT',UpperCase(TOracleQuery(Components[i]).SQL.Text)) > 0) then
        TOracleQuery(Components[i]).SQL.Text:=R180AttivaHintSQL(TOracleQuery(Components[i]).SQL.Text,Parametri.VersioneOracle);
    end;
    if Components[i] is TOracleDataSet then
    begin
      (Components[i] as TOracleDataSet).Session:=SessioneOracleR600;
      if (pos('/*NOHINT',UpperCase(TOracleDataSet(Components[i]).SQL.Text)) > 0) or (pos('/*SIHINT',UpperCase(TOracleDataSet(Components[i]).SQL.Text)) > 0) then
        TOracleDataSet(Components[i]).SQL.Text:=R180AttivaHintSQL(TOracleDataSet(Components[i]).SQL.Text,Parametri.VersioneOracle);
    end;
  end;
  //SessioneOracleR600.Name:='RICORSIONE_' + SessioneOracleR600.Name;
  if (AOwner <> nil) and not(AOwner is TOracleSession) then
  begin
    //R502ProDtM1:=TR502ProDtM1.Create(AOwner);
    R502ProDtM1:=TR502ProDtM1.Create(AOwner,True);
    QSDip:=TQueryStorico.Create(AOwner);
    DipendenteInServizio:=TDipendenteInServizio.Create(AOwner);
  end
  else
  begin
    //R502ProDtM1:=TR502ProDtM1.Create(SessioneOracleR600);
    R502ProDtM1:=TR502ProDtM1.Create(SessioneOracleR600,True);
    QSDip:=TQueryStorico.Create(SessioneOracleR600);
    DipendenteInServizio:=TDipendenteInServizio.Create(SessioneOracleR600);
  end;
  QSDip.Session:=SessioneOracleR600;
  DipendenteInServizio.Session:=SessioneOracleR600;
  Q265.Open;
  selMinDataDecorrenza.ClearVariables;
  GetGiorniServizio.ClearVariables;
  selGGNonLav.ClearVariables;
  selFestiviInfraSett.ClearVariables;
  GetCalend.ClearVariables;
  GetInizioAssenza.ClearVariables;
  VisFiscali.Progressivo:=0;
  VisFiscaliFreeArray;
  VisFiscali.CodComune:='';
  VisFiscali.Indirizzo:='';
  VisFiscali.Cap:='';
  VisFiscali.Telefono:='';
  VisFiscali.MedicinaLegale:='';
  VisFiscali.Note:='';
  VisFiscali.TipoEsenzione:='';
  VisFiscali.DataEsenzione:=0;
  VisFiscali.OperatoreEsenzione:='';
  selT047CancPrec.ClearVariables;
  selT047Prec.ClearVariables;
  selT047Succ.ClearVariables;
  selT047InsPrec.ClearVariables;
  selT047InsPrecCom.ClearVariables;
  scrL133PServeCertificPubbl.ClearVariables;
  //Traduzione anomalie
  for i:=1 to NumMessaggi do
    Messaggi[i]:=A000TraduzioneStringhe(constMessaggi[i]);
end;

destructor TR600DtM1.Destroy;
begin
  QSDip.Free;
  try
    ListAnomalie.Free;
    ListAnomalieNonBloccanti.Free;
    LStorico.Free;
    LCausCollegate.Free;
    SetLength(ProfPartTime,0);
    SetLength(AssenzeConteggiate,0);
    SetLength(AssenzeCumulate,0);
    SetLength(AssenzeCumulateOrdData,0);
    SetLength(PeriodiCumulati,0);
    FreeAndNil(R502ProDtm1);
    VisFiscaliFreeArray;
    {$IFNDEF IRISWEB}R600FAnomalie.Free;{$ENDIF}
  except
  end;
  inherited Destroy;
end;

function TR600DtM1.FormattaAnomaliaWeb(const Testo: String; MostraCausale: Boolean = True): String;
// Formatta il testo dell'anomalia singola in modo da visualizzarlo
// nell'interfaccia di IrisWEB o nei log
var
  P1, P2, P3: Integer;
  S: String;
begin
  // "Testo" originale nel formato:
  //   Data:dd/mm/yyyy Badge:nnnnnnnn Nominativo Causale:XXXXX Testo_Anomalia
  // -> viene trasformato in:
  //   dd/mm/yyyy Causale:XXXXX Testo_Anomalia }
  S:=Testo;

  // rimuove la dicitura "Data:", sostituisce i CR (ascii 13) con spazi, e rimuove i LF
  S:=StringReplace(S,'Data:','',[rfReplaceAll]);
  S:=StringReplace(S,#13,' ',[rfReplaceAll]);
  S:=StringReplace(S,#10,'',[rfReplaceAll]);

  // taglia la stringa per riportare i soli dati desiderati: data + testo_anomalia
  P1:=Pos('Matricola:',S);
  P2:=Pos('Causale:',S);
  if (P1 > 0) and (P2 > 0) then
  begin
    if MostraCausale then
      P3:=P2
    else
      P3:=P2 + Pos(' ',Copy(S,P2,Length(S) - P2 + 1));
    Delete(S,P1,P3 - P1);
    S:=StringReplace(S,'  ',' ',[rfReplaceAll]);
  end;

   //Traduzione di 'Causale'
   S:=StringReplace(S,'Causale:',A000TraduzioneStringhe(A000MSG_MSG_CAUSALE) + ':',[rfReplaceAll]);

  // accoda un CRLF al testo formattato
  Result:=S + #13#10;
end;

function TR600DtM1.FormattaAnomaliaWeb(Lista: TStringList; MostraCausale: Boolean = True; MostraNome: Boolean = True): String;
// Formatta una stringlist di anomalie creando una stringa visualizzabile
// nell'interfaccia di IrisWEB
var
  P1,P2,i: Integer;
  Nome,StrOut: String;
begin
  if Lista = nil then
  begin
    Result:='';
    Exit
  end;

  //Alberto 14/11/2013: preleva matricola + nome dal primo messaggio
  Nome:='';
  // daniloc.ini
  // questa funzione era studiata per non visualizzare il nome!
  // ripristino comportamento originale con variabile boolean
  if MostraNome then
  // daniloc.fine
  begin
    if Lista.Count > 0 then
    begin
      P1:=Pos('Matricola:',Lista[0]);
      P2:=Pos('Causale:',Lista[0]);
      if (P1 > 0) and (P2 > 0) then
        Nome:=Trim(Copy(Lista[0],P1,P2 - P1 - 1));
      if Nome <> '' then
      begin
        //Traduzione di matricola:
        Nome:=StringReplace(Nome,'Matricola:',A000TraduzioneStringhe(A000MSG_MSG_MATRICOLA) + ':',[]);
        Nome:=Nome + #13#10 + #13#10;
      end;
    end;
  end;

  // formatta ogni elemento della stringlist
  for i:=0 to Lista.Count - 1 do
  begin
    StrOut:=StrOut + FormattaAnomaliaWeb(Lista[i],MostraCausale);
  end;

  // restituisce la stringa finale
  Result:=Nome + StrOut;
end;

function TR600DtM1.GetTotCompetenze:Real;
{ Restituisce la somma dell'array delle competenze }
var
  i:Integer;
  s:Real;
begin
  s:=0;
  for i:=Low(Competenze) to High(Competenze) do
    s:=s + Competenze[i];
  Result:=s;
end;

procedure TR600DtM1.GetAssenze(Prog:LongInt; Data,Fine,DataNas:TDateTime; Giustif:TGiustificativo; LettAss:Boolean = True);
{Restituisce unità di misura, valenza giornaliera, competenze, fruito, residuo}
var i:Byte;
    T1,T2,T3,T4,T5,T6,T7:Real;
    LetturaAssenzeOri,VisualizzaAnomalieOri:Boolean;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    VCompIndivConiugeEsistente: Variant;
    LEsisteCompIndiv, LCdsActive: Boolean;
    LFruitoIndiv: Real;
    LTipoGiust: String;
    OldCompetenze1,OldCompetenzeOri1,OldCompetenzeParziali1: real;
    OldCompetenzeLette1: String;
    LRiepAss:TRiepilogoAssenze;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    GiustifOri:TGiustificativo;
begin
  LetturaAssenzeOri:=LetturaAssenze;
  VisualizzaAnomalieOri:=VisualizzaAnomalie;
  LetturaAssenze:=LettAss; // True
  VisualizzaAnomalie:=False;
  T1:=0;
  T2:=0;
  T3:=0;
  T4:=0;
  T5:=0;
  T6:=0;
  T7:=0;
  GetCompPrec:='0';
  GetCompCorr:='0';
  GetCompTot:='0';
  GetFruitoPrec:='0';
  GetFruitoCorr:='0';
  GetFruitoTot:='0';
  GetResiduo:='0';
  GetResiduoPrec:='0';
  GetResiduoCorr:='0';
  GetCompParz:='0';
  GetResiduoParz:='0';
  GetIterRichiesto:='0';
  GetIterAutorizzato:='0';
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  GetCompAssIndivid:='0';
  GetFruitoGGIndivid:='0';
  GetResiduoGGIndivid:='0';
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
  // csi.ini
  GetVariazioneFruizMMInteri:='0';
  GetVariazioneFruizMMInteriDip:='0';
  GetVariazioneMaxIndividuale:='0';
  // csi.fine
  ValCompPrec:=0;
  ValCompCorr:=0;
  ValCompTot:=0;
  ValFruitoPrec:=0;
  ValFruitoCorr:=0;
  ValFruitoTot:=0;
  ValResiduo:=0;
  ValResiduoPrec:=0;
  ValResiduoCorr:=0;
  ValCompParz:=0;
  ValResiduoParz:=0;
  ValResiduoGG:=0;
  ValResiduoPrecGG:=0;
  ValResiduoCorrGG:=0;
  ValIterRichiesto:=0;
  ValIterAutorizzato:=0;
  RiferimentoDataNascita.Data:=DataNas;
  GetIDFamiliare({Progressivo}Prog); // bugfix

  //CCNL 2018.ini
  GiustifOri:=Giustif;
  if LetturaAssenze and (not LetturaRiduzioni) and (GetValStrT230(Giustif.Causale,'CAUSALE_VISUALCOMPETENZE',Fine) <> '') then
    Giustif.Causale:=GetValStrT230(Giustif.Causale,'CAUSALE_VISUALCOMPETENZE',Fine);
  //CCNL 2018.fine

  try
    if SettaConteggi(Prog,Data,Fine,Giustif) = mrOK then
    begin
      if UMisura = 'O' then
      begin
        GetCompPrec:='00.00';
        GetCompCorr:='00.00';
        GetCompTot:='00.00';
        GetFruitoPrec:='00.00';
        GetFruitoCorr:='00.00';
        GetFruitoTot:='00.00';
        GetResiduo:='00.00';
        GetResiduoPrec:='00.00';
        GetResiduoCorr:='00.00';
        GetCompParz:='00.00';
        GetResiduoParz:='00.00';
        GetIterRichiesto:='00.00';
        GetIterAutorizzato:='00.00';
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
        GetCompAssIndivid:='00.00';
        GetFruitoGGIndivid:='00.00';
        GetResiduoGGIndivid:='00.00';
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
        // csi.ini
        GetVariazioneFruizMMInteri:='00.00';
        GetVariazioneFruizMMInteriDip:='00.00';
        GetVariazioneMaxIndividuale:='00.00';
        // csi.fine
      end;
      DividiPrecCorr;
      //Dati divisi nelle 6 Fasce
      for i:=1 to 6 do
      begin
        //Calcolo totali
        if EsisteResiduo then
          //Se c'è Residuo calcolo competenze e fruito
        begin
          T1:=T1 + ResiduiVal[i];
          T3:=T3 + VisFruitoAP[i];
        end;
        T2:=T2 + VisCompetenzeAC[i];
        T4:=T4 + VisFruitoAC[i];
        T5:=T5 + Competenze[i];
        T6:=T6 + CompetenzeParziali[i];
        T7:=T7 + CompetenzeParziali[i] - VisFruitoAC[i];
      end;
      //Valori numerici
      if EsisteResiduo then
      begin
        ValCompPrec:=T1;     //Competenze anno precedente
        ValFruitoPrec:=T3;   //Fruito anno precedente
      end;
      ValCompCorr:=T2;       //Competenze anno corrente
      ValCompTot:=T2 + T1;    //Totale competenze
      ValFruitoCorr:=T4;     //Fruito anno corrente
      ValFruitoTot:=T3 + T4;  //Totale fruito
      ValResiduo:=T5;        //Residuo
      ValCompParz:=T6;       //Competenze parziali
      ValResiduoParz:=T7;    //Residuo parziale
      ValResiduoPrec:=T1 - T3;  //Residuo precedente
      ValResiduoCorr:=T2 - T4;  //Residuo corrente
      if (UMisura = 'O') and (ValenzaGiornaliera <> 0) then
      begin
        ValResiduoPrecGG:=TrasformaOre2Giorni(ValResiduoPrec);//ValResiduoPrec/ValenzaGiornaliera;
        ValResiduoCorrGG:=TrasformaOre2Giorni(ValResiduoCorr);//ValResiduoCorr/ValenzaGiornaliera;
        ValResiduoGG:=TrasformaOre2Giorni(ValResiduo);//ValResiduo/ValenzaGiornaliera;
      end;
      if UMisura = 'G' then
      begin
        ValResiduoPrecGG:=ValResiduoPrec;
        ValResiduoCorrGG:=ValResiduoCorr;
        ValResiduoGG:=ValResiduo;

        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
        // determina i valori delle competenze individuali (in caso di presenza di coniuge)
        if TipoCumulo = 'F' then
        begin
          // estrae le competenze individuali nel caso di coniuge
          VCompIndivConiugeEsistente:=Q265.Lookup('CODICE',Giustif.Causale,'COMPINDIV_CONIUGE_ESISTENTE');
          if VarIsNull(VCompIndivConiugeEsistente) then
            ValCompIndivConiugeEsistente:=-1
          else
            ValCompIndivConiugeEsistente:=StrToIntDef(VarToStr(VCompIndivConiugeEsistente),0);
          if ValCompIndivConiugeEsistente >= 0 then
          begin
            // determina le competenze individuali
            // salva competenze originali
            OldCompetenze1:=Competenze[1];
            OldCompetenzeOri1:=CompetenzeOri[1];
            OldCompetenzeParziali1:=CompetenzeParziali[1];
            OldCompetenzeLette1:=CompetenzeLette[1];

            // determina le variazioni per congedi parentali
            GetVariazioniCongediParentali(InizioCumulo,FineCumulo);

            // ripristina competenze originali
            Competenze[1]:=OldCompetenze1;
            CompetenzeOri[1]:=OldCompetenzeOri1;
            CompetenzeParziali[1]:=OldCompetenzeParziali1;
            CompetenzeLette[1]:=OldCompetenzeLette1;

            try
              SwitchRiepilogoConiuge(True,LRiepAss);
            except
            end;
            // dati individuali di competenze e residuo
            GetCompAssIndivid:=LRiepAss.CC;
            GetFruitoGGIndivid:=LRiepAss.FC;
            GetResiduoGGIndivid:=LRiepAss.RC;
          end;
        end;
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      end;
      //Valori trasformati in stringa
      if UMisura = 'G' then   //Giorni
      begin
        if EsisteResiduo then
        begin
          GetCompPrec:=FloatToStr(T1);     //Competenze anno precedente
          GetFruitoPrec:=FloatToStr(T3);   //Fruito anno precedente
        end;
        GetCompCorr:=FloatToStr(T2);       //Competenze anno corrente
        GetCompTot:=FloatToStr(T1 + T2);   //Totale competenze
        GetFruitoCorr:=FloatToStr(T4);     //Fruito anno corrente
        GetFruitoTot:=FloatToStr(T3 + T4); //Totale fruito
        GetResiduo:=FloatToStr(T5);        //Residuo
        GetResiduoPrec:=FloatToStr(T1 - T3); //Residuo precedente
        GetResiduoCorr:=FloatToStr(T2 - T4); //Residuo corrente
        GetCompParz:=FloatToStr(T6);       //Competenze Parziali
        GetResiduoParz:=FloatToStr(T7);    //Residuo parziale
        GetIterRichiesto:=FloatToStr(ValIterRichiesto);     //Fruito da iter autorizzativo solo richiesto
        GetIterAutorizzato:=FloatToStr(ValIterAutorizzato); //Fruito da iter autorizzativo già autorizzato
        // csi.ini
        GetVariazioneFruizMMInteri:=FloatToStr(ValVariazioneFruizMMInteri);
        GetVariazioneFruizMMInteriDip:=FloatToStr(ValVariazioneFruizMMInteriDip);
        // la variazione max individuale viene invertita di segno (in modo da essere positiva)
        GetVariazioneMaxIndividuale:=FloatToStr(-ValVariazioneMaxIndividuale);
        // csi.fine
      end
      else                   //Ore
      begin
        if EsisteResiduo then
        begin
          GetCompPrec:=R180MinutiOre(Trunc(T1));            //Competenze anno precedente
          GetFruitoPrec:=R180MinutiOre(Trunc(T3));          //Fruito anno precedente
        end;
        GetCompCorr:=R180MinutiOre(Trunc(T2));              //Competenze anno corrente
        GetCompTot:=R180MinutiOre(Trunc(T2) + Trunc(T1));   //Totale competenze
        GetFruitoCorr:=R180MinutiOre(Trunc(T4));            //Fruito anno corrente
        GetFruitoTot:=R180MinutiOre(Trunc(T3) + Trunc(T4)); //Totale fruito
        GetResiduo:=R180MinutiOre(Trunc(T5));               //Residuo
        GetResiduoPrec:=R180MinutiOre(Trunc(T1 - T3)); //Residuo precedente
        GetResiduoCorr:=R180MinutiOre(Trunc(T2 - T4)); //Residuo corrente
        GetCompParz:=R180MinutiOre(Trunc(T6));              //Competenze parziali
        GetResiduoParz:=R180MinutiOre(Trunc(T7));           //Residuo parziale
        GetIterRichiesto:=R180MinutiOre(Trunc(ValIterRichiesto));     //Fruito da iter autorizzativo solo richiesto
        GetIterAutorizzato:=R180MinutiOre(Trunc(ValIterAutorizzato)); //Fruito da iter autorizzativo già autorizzato
        // csi.ini
        GetVariazioneFruizMMInteri:=R180MinutiOre(Trunc(ValVariazioneFruizMMInteri));
        GetVariazioneFruizMMInteriDip:=R180MinutiOre(Trunc(ValVariazioneFruizMMInteriDip));
        // la variaz. max individuale viene invertita di segno, in modo da risultare positiva
        GetVariazioneMaxIndividuale:=R180MinutiOre(-Trunc(ValVariazioneMaxIndividuale));
        // csi.fine
      end;
    end;
  finally
    Giustif:=GiustifOri;
    LetturaAssenze:=LetturaAssenzeOri;
    VisualizzaAnomalie:=VisualizzaAnomalieOri;
  end;
end;

procedure TR600DtM1.GetRiduzione(Prog:LongInt; Data,Fine,DataNas:TDateTime; Giustif:TGiustificativo;
                                 var UM,CP,CC,CT,FP,FC,FT,R:String; var ValGio,Giorno:Integer; InizioElab:Boolean; LettAss:Boolean = True);
begin
  GiornataOre:=0;
  LetturaRiduzioni:=True;
  InizioRiduzioni:=InizioElab;
  GetAssenze(Prog,Data,Fine,DataNas,Giustif,LettAss);
  UM:=UMisura;
  ValGio:=ValenzaGiornaliera;
  CP:=GetCompPrec;
  CC:=GetCompCorr;
  CT:=GetCompTot;
  FP:=GetFruitoPrec;
  FC:=GetFruitoCorr;
  FT:=GetFruitoTot;
  R:=GetResiduo;
  Giorno:=GiornataOre;
  LetturaRiduzioni:=False;
end;

function TR600DtM1.TrasformaOre2Giorni(Ore:Real):Real;
var Arr:Real;
begin
  Result:=0;
  if ValenzaGiornaliera = 0 then
    exit;
  Arr:=0;
  if Q265.FieldByName('ARROT_ORE2GG').AsString = 'I' then
    Arr:=1
  else if Q265.FieldByName('ARROT_ORE2GG').AsString = 'M' then
    Arr:=0.5;
  if Arr > 0 then
    Result:=R180Arrotonda(Ore/ValenzaGiornaliera,Arr,'D')
  else
    Result:=Ore/ValenzaGiornaliera;
end;

procedure TR600DtM1.OrdinaAssCumulatePerData(var ArrSrc, ArrOrd: TArrAssenzeCumulate);
// copia l'array di assenze cumulate ArrSrc in un array parallelo ArrOrd,
// e ordina quest'ultimo per data
var
  i, j: Integer;
  Temp: TAssenzeCumulate;
  Scambio: Boolean;
begin
  // 1. copia l'array iniziale nell'array di destinazione
  SetLength(ArrOrd,Length(ArrSrc));
  for i:=Low(ArrSrc) to High(ArrSrc) do
  begin
    //CopyMemory(@ArrOrd[i],@ArrSrc[i],SizeOf(TAssenzeCumulate)); // esaminare perché dà problemi di AV (probabilmente x string)
    ArrOrd[i].Data:=ArrSrc[i].Data;
    ArrOrd[i].Causale:=ArrSrc[i].Causale;
    ArrOrd[i].Tipo:=ArrSrc[i].Tipo;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    ArrOrd[i].CSITipoMG:=ArrSrc[i].CSITipoMG;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    ArrOrd[i].Ore:=ArrSrc[i].Ore;
    ArrOrd[i].DTData:=ArrSrc[i].DTData;
    ArrOrd[i].Coniuge:=ArrSrc[i].Coniuge;
    ArrOrd[i].RichiestaWeb:=ArrSrc[i].RichiestaWeb;
    ArrOrd[i].DaVisualizzare:=ArrSrc[i].DaVisualizzare;
    ArrOrd[i].OreConteggiate:=ArrSrc[i].OreConteggiate;
  end;

  // 2. ordina l'array di destinazione per data
  for i:=Low(ArrOrd) to Length(ArrOrd) - 1 do
  begin
    Scambio:=False;
    for j:=Low(ArrOrd) to Length(ArrOrd) - 2 do
    begin
      if ArrOrd[j].DTData > ArrOrd[j + 1].DTData then
      begin
        Temp:=ArrOrd[j];
        ArrOrd[j]:=ArrOrd[j + 1];
        ArrOrd[j + 1]:=Temp;
        Scambio:=True;
      end;
    end;
    // nessuno scambio -> array ordinato
    if not Scambio then
      Break;
  end;
end;

//procedure TR600DtM1.RiepilogaAssenze(Prog:Integer; dDataRiep:TDateTime; G:TGiustificativo; RifDataNas:Boolean; DataNas:TDateTime);
procedure TR600DtM1.RiepilogaAssenze(Prog:Integer; dDataRiep:TDateTime; G:TGiustificativo; PEsisteRifDataNas:Boolean; DataNas: TRiferimentoDataNascita);
var i,j:Integer;
    CatenaCausali,saveUMisura,saveCodCausale,CodCausale:String;
    sumCompTotali,sumVariazionePeriodiRapporto,sumCompArrotondate,sumCompSoloFerie,
    sumVariazionePartTime,sumVariazionePartTimeResid,sumVariazioneAbilitazioneAnagrafica,sumVariazioneCompetenzeF,
    sumVariazioneFruizMMInteri,sumVariazioneFruizMMInteriDip,sumVariazioneMaxIndividuale,
    sumVariazioneFruizMMContinuativi,sumVariazioneFruizMMContinuativiDip,sumVariazioneGGNoLavVuoti,
    sumVariazioneFestePartic:Real;
    saveVisFruitoAP,saveVisFruitoAC,sumVisFruitoAC,sumVisCompetenzeAC:array [1..6] of Real;
    saveProfiloAssenze,CausConsiderate,RaggrConsiderati:String;
  procedure ResetTotali;
  var i:Integer;
  begin
      // inizializzazione variabili
    sumCompTotali:=0;
    sumVariazionePeriodiRapporto:=0;
    sumCompArrotondate:=0;
    sumCompSoloFerie:=0;
    sumVariazionePartTime:=0;
    sumVariazionePartTimeResid:=0;
    sumVariazioneAbilitazioneAnagrafica:=0;
    sumVariazioneCompetenzeF:=0;
    sumVariazioneFruizMMInteri:=0;
    sumVariazioneFruizMMInteriDip:=0; // TORINO_CSI - evolutive 02/10/2015
    sumVariazioneMaxIndividuale:=0;
    sumVariazioneFruizMMContinuativi:=0;
    sumVariazioneFruizMMContinuativiDip:=0; // TORINO_CSI - evolutive 02/10/2015
    sumVariazioneGGNoLavVuoti:=0;
    sumVariazioneFestePartic:=0;
    for i:=1 to High(sumVisCompetenzeAC) do
    begin
      sumVisCompetenzeAC[i]:=0;
      sumVisFruitoAC[i]:=0;
    end;
  end;
begin
  GetAssenze(Prog,dDataRiep,dDataRiep,DataNas.Data,G); // csi
  i:=Length(RiepilogoAssenze);
  SetLength(RiepilogoAssenze,i + 1);

  RiepilogoAssenze[i].Matricola:=Matricola;
  RiepilogoAssenze[i].Nominativo:=Nome;

  //Anomalie bloccanti
  //Nessun cumulo --> no competenze                           // Lorena 29/12/2005
  if TipoCumulo = 'H' then
    RiepilogoAssenze[i].Messaggio:='Competenze/residui non esistenti: causale con TipoCumulo = ''H-Nessun cumulo''.';
  //Anno solare senza profilo assenze --> no competenze       // Lorena 29/12/2005
  if (CompetenzeAnnoSolare) and (ProfiloAssenze = '') then
    RiepilogoAssenze[i].Messaggio:='Competenze/residui non esistenti: causale con TipoCumulo = ''A-Inizio anno solare'' non specificata nel Profilo assenze.';
  if RiepilogoAssenze[i].Messaggio <> '' then
    exit;

  RiepilogoAssenze[i].NumPeriodi:=GetNumPeriodiAssenzeCumulate(0,Q265.FieldByName('CODICE').AsString,True);
  // ordinamento array per data al fine di visualizzare correttamente i periodi
  //OrdinaAssCumulatePerData(AssenzeCumulate,AssenzeCumulateOrdData);
  //AssenzeCumulateOrdData, PeriodiCumulati

  if not PEsisteRifDataNas then
    PEsisteRifDataNas:=(R180CarattereDef(Q265.FieldByName('Cumulo_familiari').AsString,1,'N') in ['S','D']) or
                (R180CarattereDef(Q265.FieldByName('Fruizione_Familiari').AsString,1,'N') in ['S','D']);
  if PEsisteRifDataNas then
    RiepilogoAssenze[i].Familiare:=DateToStr(DataNas.Data) // csi
  else
    RiepilogoAssenze[i].Familiare:=SPAZIO;
  RiepilogoAssenze[i].VisFamRif:=(R180CarattereDef(Q265.FieldByName('Cumulo_familiari').AsString,1,'N') in ['S','D']) or (R180CarattereDef(Q265.FieldByName('Fruizione_Familiari').AsString,1,'N') in ['S','D']);
  RiepilogoAssenze[i].ArrotOre2Giorni:=(UMisura = 'O') and (ValenzaGiornaliera > 0) and R180In(Q265.FieldByName('ARROT_ORE2GG').AsString,['M','I']);
  RiepilogoAssenze[i].CompAnnoSolare:=CompetenzeAnnoSolare;
  RiepilogoAssenze[i].UM:=IfThen(UMisura = 'O','Ore','Giorni');

  RiepilogoAssenze[i].CP:=GetCompPrec;
  RiepilogoAssenze[i].CC:=GetCompCorr;
  RiepilogoAssenze[i].CT:=GetCompTot;
  RiepilogoAssenze[i].FP:=GetFruitoPrec;
  RiepilogoAssenze[i].FC:=GetFruitoCorr;
  RiepilogoAssenze[i].FT:=GetFruitoTot;
  RiepilogoAssenze[i].R:=GetResiduo;
  RiepilogoAssenze[i].RP:=GetResiduoPrec;
  RiepilogoAssenze[i].RC:=GetResiduoCorr;
  RiepilogoAssenze[i].CParz:=GetCompParz;
  RiepilogoAssenze[i].RParz:=GetResiduoParz;

  RiepilogoAssenze[i].EsisteResiduo:=R180StrToGiorniOre(GetCompPrec,UMisura) <> 0;
  RiepilogoAssenze[i].Residuabile:=Q265.FieldByName('Residuabile').AsString = 'S';
  RiepilogoAssenze[i].IterRich:=GetIterRichiesto;
  RiepilogoAssenze[i].IterAut:=GetIterAutorizzato;
  RiepilogoAssenze[i].ProfiloAssenze:=Trim(DescrizioneProfiloAssenze);
  RiepilogoAssenze[i].PeriodoCumulo:=DescrizionePeriodoCumulo;
  RiepilogoAssenze[i].CompLordeAC:=R180GiorniOreToStr(ValCompTotali + IfThen((DescrizioneProfiloAssenze.Trim <> '') and (Q265.FieldByName('Tipo_Proporzione').AsString <> 'R'),ValVariazionePartTime),UMisura,'%3.2f');
  RiepilogoAssenze[i].VarPeriodiRapporto:=R180GiorniOreToStr(-ValVariazionePeriodiRapporto,UMisura,'%3.2f');
  RiepilogoAssenze[i].AbbattiAssCess:=R180GiorniOreToStr(-ValCompArrotondate,UMisura,'%3.2f');
  RiepilogoAssenze[i].DecurtazNonMatura:=R180GiorniOreToStr(-ValCompSoloFerie,UMisura,'%3.2f');
  RiepilogoAssenze[i].VarPartTime:=R180GiorniOreToStr(-ValVariazionePartTime,UMisura,'%3.2f');
  RiepilogoAssenze[i].VarAbilitazioneAnagrafica:=R180GiorniOreToStr(-ValVariazioneAbilitazioneAnagrafica,UMisura,'%3.2f');
  RiepilogoAssenze[i].VarCompManuale:=R180GiorniOreToStr(ValVariazioneCompetenzeF,UMisura,'%3.2f');
  // AOSTA_REGIONE - commessa 2012/152.ini
  RiepilogoAssenze[i].VarFruizMMInteri:=R180GiorniOreToStr(ValVariazioneFruizMMInteri,UMisura,'%3.2f');
  RiepilogoAssenze[i].VarFruizMMInteriDip:=R180GiorniOreToStr(ValVariazioneFruizMMInteriDip,UMisura,'%3.2f'); // TORINO_CSI - evolutive 02/10/2015
  RiepilogoAssenze[i].VarMaxIndividuale:=R180GiorniOreToStr(ValVariazioneMaxIndividuale,UMisura,'%3.2f');
  RiepilogoAssenze[i].VarFruizMMContinuativi:=R180GiorniOreToStr(ValVariazioneFruizMMContinuativi,UMisura,'%3.2f');
  RiepilogoAssenze[i].VarFruizMMContinuativiDip:=R180GiorniOreToStr(ValVariazioneFruizMMContinuativiDip,UMisura,'%3.2f');
  RiepilogoAssenze[i].VarGGNoLavVuoti:=R180GiorniOreToStr(ValVariazioneGGNoLavVuoti,UMisura,'%3.2f');
  // AOSTA_REGIONE - commessa 2012/152.fine
  RiepilogoAssenze[i].VarFestePartic:=R180GiorniOreToStr(ValVariazioneFestePartic,UMisura,'%3.2f');
  RiepilogoAssenze[i].CompNetteAC:=R180GiorniOreToStr(ValCompTotali + IfThen((DescrizioneProfiloAssenze.Trim <> '') and (Q265.FieldByName('Tipo_Proporzione').AsString <> 'R'),ValVariazionePartTime) - ValVariazionePeriodiRapporto - ValCompArrotondate - ValCompSoloFerie - ValVariazionePartTime - ValVariazioneAbilitazioneAnagrafica + ValVariazioneCompetenzeF + ValVariazioneFruizMMInteri + ValVariazioneMaxIndividuale + ValVariazioneFruizMMContinuativi + ValVariazioneGGNoLavVuoti + ValVariazioneFestePartic,UMisura,'%3.2f');
  RiepilogoAssenze[i].PartTime:=ElencoProfPartTime;
  RiepilogoAssenze[i].TitoloFruizMinimaAC:=TitoloFruizioneMinimaAC;
  RiepilogoAssenze[i].FruizMinimaAC:=R180GiorniOreToStr(ValFruizMinimaAC,UMisura,'%3.2f');

  //Lettura causali concatenate per eventuale calcolo cumulativo delle competenze
  selCatenaCausali.SetVariable('CAUSALE',G.Causale);
  selCatenaCausali.Execute;
  CatenaCausali:=VarToStr(selCatenaCausali.Field(0));
  if Pos(',' + G.Causale + ',',',' + CatenaCausali + ',') <> 1 then
    CatenaCausali:='';
  CatenaCausali:=Copy(CatenaCausali,Pos(G.Causale,CatenaCausali) + Length(G.Causale) + 1);
  //Se non la causale non ha residui né competenze e ha causali concatenate, ricalcolo le competenze
  if (not RiepilogoAssenze[i].EsisteResiduo)
  and (ValCompTotali = 0)
  and (CatenaCausali <> '') then
  begin
    ResetTotali;
    //Salvo i dati originali
    saveCodCausale:=G.Causale;
    saveUMisura:=UMisura;
    saveProfiloAssenze:=ProfiloAssenze;
    for j:=1 to 6 do
      //saveVisFruitoAC:=saveVisFruitoAC + VisFruitoAC[j];
    begin
      saveVisFruitoAP[j]:=VisFruitoAP[j];
      saveVisFruitoAC[j]:=VisFruitoAC[j];
    end;
    //Ciclo sulle causali concatenate
    CatenaCausali:=CatenaCausali + ',';
    // MONDOEDP - commessa MAN/02 - SVILUPPO#94.ini
    CausConsiderate:='';
    RaggrConsiderati:='';
    // MONDOEDP - commessa MAN/02 - SVILUPPO#94.fine
    while Pos(',',CatenaCausali) > 0 do
    begin
      CodCausale:=Copy(CatenaCausali,1,Pos(',',CatenaCausali) - 1);
      //Cerco le competenze della causale concatenata
      G.Causale:=CodCausale;
      GetAssenze(Prog,dDataRiep,dDataRiep,DataNas.Data,G); // csi
      // MONDOEDP - commessa MAN/02 - SVILUPPO#94.ini
      // se nelle causali collegate ce n'è una già considerata
      // è necessario resettare i totali
      // C1, C2, C3, ... normalmente sommo le competenze
      // ma se C3 ha in LCausCollegate C1 e/o C2 allora ResetTotali
      // tenere traccia anche del CodRaggr: se una causale ha lo stesso CodRaggr già totalizzato allora ResetTotali
      G.CodRagg:=VarToStr(Q265.Lookup('CODICE',CodCausale,'CODRAGGR'));
      if (R180GetCsvIntersect(LCausCollegate.CommaText,CausConsiderate) <> '') or
         (R180CercaParolaIntera(G.CodRagg,RaggrConsiderati,',') > 0) then
      begin
        // azzera i totali
        ResetTotali;
        // pulisce le causali e i raggruppamenti già considerati
        CausConsiderate:='';
        RaggrConsiderati:='';
      end;
      CausConsiderate:=CausConsiderate + CodCausale + ',';
      RaggrConsiderati:=RaggrConsiderati + G.CodRagg + ',';
      // MONDOEDP - commessa MAN/02 - SVILUPPO#94.fine
      //Sommo le competenze di tutte le causali concatenate
      for j:=1 to 6 do
      begin
        sumVisCompetenzeAC[j]:=sumVisCompetenzeAC[j] + ResiduiVal[j] + VisCompetenzeAC[j];
        sumVisFruitoAC[j]:=sumVisFruitoAC[j] + VisFruitoAC[j];
      end;
      sumCompTotali:=sumCompTotali + valCompTotali;
      sumVariazionePeriodiRapporto:=sumVariazionePeriodiRapporto + valVariazionePeriodiRapporto;
      sumCompArrotondate:=sumCompArrotondate + valCompArrotondate;
      sumCompSoloFerie:=sumCompSoloFerie + valCompSoloFerie;
      sumVariazionePartTime:=sumVariazionePartTime + valVariazionePartTime;
      sumVariazionePartTimeResid:=sumVariazionePartTimeResid + IfThen(VarToStr(Q265.Lookup('CODICE',CodCausale,'Tipo_Proporzione')) = 'R',valVariazionePartTime);
      sumVariazioneAbilitazioneAnagrafica:=sumVariazioneAbilitazioneAnagrafica + valVariazioneAbilitazioneAnagrafica;
      sumVariazioneCompetenzeF:=sumVariazioneCompetenzeF + valVariazioneCompetenzeF;
      // AOSTA_REGIONE - commessa 2012/152.ini
      sumVariazioneFruizMMInteri:=sumVariazioneFruizMMInteri + ValVariazioneFruizMMInteri;
      sumVariazioneFruizMMInteriDip:=sumVariazioneFruizMMInteriDip + ValVariazioneFruizMMInteriDip; // TORINO_CSI - evolutive 02/10/2015
      sumVariazioneMaxIndividuale:=sumVariazioneMaxIndividuale + ValVariazioneMaxIndividuale;
      sumVariazioneFruizMMContinuativi:=sumVariazioneFruizMMContinuativi + ValVariazioneFruizMMContinuativi;
      sumVariazioneGGNoLavVuoti:=sumVariazioneGGNoLavVuoti + ValVariazioneGGNoLavVuoti;
      // AOSTA_REGIONE - commessa 2012/152.fine
      sumVariazioneFestePartic:=sumVariazioneFestePartic + ValVariazioneFestePartic;
      CatenaCausali:=Copy(CatenaCausali,Pos(',',CatenaCausali) + 1);
    end;
    //Ripristino i valori originali
    G.Causale:=saveCodCausale;//Necessario in caso di più familiari
    UMisura:=saveUMisura;
    ProfiloAssenze:=saveProfiloAssenze;

    for j:=1 to 6 do
    begin
      if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (G.Causale = TO_CSI_RICH_RECHH) then
        saveVisFruitoAC[j]:=sumVisFruitoAC[j];
      VisFruitoAP[j]:=saveVisFruitoAP[j];
      VisFruitoAC[j]:=saveVisFruitoAC[j];
      //Ricalcolo le competenze e residui
      ResiduiVal[j]:=0;
      VisCompetenzeAC[j]:=sumVisCompetenzeAC[j];
      Competenze[j]:=VisCompetenzeAC[j] - VisFruitoAC[j];
    end;
    RiepilogoAssenze[i].Residuabile:=False;
    //Ricalcolo le competenze e residui
    RiepilogoAssenze[i].CP:='0';
    RiepilogoAssenze[i].CC:=R180GiorniOreToStr(R180SommaArray(sumVisCompetenzeAC),saveUMisura);
    RiepilogoAssenze[i].CT:=R180GiorniOreToStr(R180SommaArray(sumVisCompetenzeAC),saveUMisura);
    if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (G.Causale = TO_CSI_RICH_RECHH) then
    begin
      RiepilogoAssenze[i].FP:='0';
      RiepilogoAssenze[i].FC:=R180GiorniOreToStr(R180SommaArray(saveVisFruitoAC),saveUMisura);
      RiepilogoAssenze[i].FT:=R180GiorniOreToStr(R180SommaArray(saveVisFruitoAC),saveUMisura);
    end;
    RiepilogoAssenze[i].RP:='0';
    RiepilogoAssenze[i].RC:=R180GiorniOreToStr(R180SommaArray(sumVisCompetenzeAC) - R180SommaArray(saveVisFruitoAC),saveUMisura);
    RiepilogoAssenze[i].R:=R180GiorniOreToStr(R180SommaArray(sumVisCompetenzeAC) - R180SommaArray(saveVisFruitoAC),saveUMisura);
    //Aggiorno il prospetto del calcolo delle competenze
    RiepilogoAssenze[i].CompLordeAC:=R180GiorniOreToStr(sumCompTotali + IfThen(RiepilogoAssenze[i].ProfiloAssenze <> '',sumVariazionePartTime - sumVariazionePartTimeResid),saveUMisura,'%3.2f');
    RiepilogoAssenze[i].VarPeriodiRapporto:=R180GiorniOreToStr(-sumVariazionePeriodiRapporto,saveUMisura,'%3.2f');
    RiepilogoAssenze[i].AbbattiAssCess:=R180GiorniOreToStr(-sumCompArrotondate,saveUMisura,'%3.2f');
    RiepilogoAssenze[i].DecurtazNonMatura:=R180GiorniOreToStr(-sumCompSoloFerie,saveUMisura,'%3.2f');
    RiepilogoAssenze[i].VarPartTime:=R180GiorniOreToStr(-sumVariazionePartTime,saveUMisura,'%3.2f');
    RiepilogoAssenze[i].VarAbilitazioneAnagrafica:=R180GiorniOreToStr(-sumVariazioneAbilitazioneAnagrafica,saveUMisura,'%3.2f');
    RiepilogoAssenze[i].VarCompManuale:=R180GiorniOreToStr(sumVariazioneCompetenzeF,saveUMisura,'%3.2f');
    // AOSTA_REGIONE - commessa 2012/152.ini
    RiepilogoAssenze[i].VarFruizMMInteri:=R180GiorniOreToStr(sumVariazioneFruizMMInteri,UMisura,'%3.2f');
    RiepilogoAssenze[i].VarFruizMMInteriDip:=R180GiorniOreToStr(sumVariazioneFruizMMInteriDip,UMisura,'%3.2f'); // TORINO_CSI - evolutive 02/10/2015
    RiepilogoAssenze[i].VarMaxIndividuale:=R180GiorniOreToStr(sumVariazioneMaxIndividuale,UMisura,'%3.2f');
    RiepilogoAssenze[i].VarFruizMMContinuativi:=R180GiorniOreToStr(sumVariazioneFruizMMContinuativi,UMisura,'%3.2f');
    RiepilogoAssenze[i].VarFruizMMContinuativiDip:=R180GiorniOreToStr(sumVariazioneFruizMMContinuativiDip,UMisura,'%3.2f');
    RiepilogoAssenze[i].VarGGNoLavVuoti:=R180GiorniOreToStr(sumVariazioneGGNoLavVuoti,UMisura,'%3.2f');
    // AOSTA_REGIONE - commessa 2012/152.fine
    RiepilogoAssenze[i].VarFestePartic:=R180GiorniOreToStr(sumVariazioneFestePartic,UMisura,'%3.2f');
    RiepilogoAssenze[i].CompNetteAC:=R180GiorniOreToStr(sumCompTotali + IfThen(RiepilogoAssenze[i].ProfiloAssenze <> '',sumVariazionePartTime - sumVariazionePartTimeResid) - sumVariazionePeriodiRapporto - sumCompArrotondate - sumCompSoloFerie - sumVariazionePartTime - sumVariazioneAbilitazioneAnagrafica + sumVariazioneCompetenzeF + sumVariazioneFruizMMInteri + sumVariazioneMaxIndividuale + sumVariazioneFruizMMContinuativi + sumVariazioneGGNoLavVuoti + sumVariazioneFestePartic,saveUMisura,'%3.2f');
  end;

  //Trasformazione dati orari in giorni se è previsto un arrotondamento significativo (ITC)
  if (UMisura = 'O') and (ValenzaGiornaliera > 0) (*and R180In(Q265.FieldByName('ARROT_ORE2GG').AsString,VarArrayof(['M','I']))*) then
  begin
    //RiepilogoAssenze[i].UM:='Giorni';
    RiepilogoAssenze[i].H_CP:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].CP))]),',00','',[]);
    RiepilogoAssenze[i].H_CC:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].CC))]),',00','',[]);
    RiepilogoAssenze[i].H_CT:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].CT))]),',00','',[]);
    RiepilogoAssenze[i].H_FP:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].FP))]),',00','',[]);
    RiepilogoAssenze[i].H_FC:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].FC))]),',00','',[]);
    RiepilogoAssenze[i].H_FT:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].FT))]),',00','',[]);
    RiepilogoAssenze[i].H_R:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].R))]),',00','',[]);
    RiepilogoAssenze[i].H_RP:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].RP))]),',00','',[]);
    RiepilogoAssenze[i].H_RC:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].RC))]),',00','',[]);
    RiepilogoAssenze[i].H_CParz:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].CParz))]),',00','',[]);
    RiepilogoAssenze[i].H_RParz:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].RParz))]),',00','',[]);
    RiepilogoAssenze[i].H_IterRich:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].IterRich))]),',00','',[]);
    RiepilogoAssenze[i].H_IterAut:=StringReplace(Format('%3.2f',[TrasformaOre2Giorni(R180OreMinutiExt(RiepilogoAssenze[i].IterAut))]),',00','',[]);
  end
  else
  begin
    RiepilogoAssenze[i].H_CP:='';
    RiepilogoAssenze[i].H_CC:='';
    RiepilogoAssenze[i].H_CT:='';
    RiepilogoAssenze[i].H_FP:='';
    RiepilogoAssenze[i].H_FC:='';
    RiepilogoAssenze[i].H_FT:='';
    RiepilogoAssenze[i].H_R:='';
    RiepilogoAssenze[i].H_RP:='';
    RiepilogoAssenze[i].H_RC:='';
    RiepilogoAssenze[i].H_CParz:='';
    RiepilogoAssenze[i].H_RParz:='';
    RiepilogoAssenze[i].H_IterRich:='';
    RiepilogoAssenze[i].H_IterAut:='';
  end;
end;

procedure TR600DtM1.VisualizzaAssenze(Prog:LongInt; Inizio:TDateTime; Giustif:TGiustificativo);
{Visualizzazione assenze su griglia: competenze, fruito, residuo
 usato da Cartellino Interattivo e Inserimento Giustificativi}
var
  FC,FCI:TDateTime;
  CambiaFineCumulo:Boolean;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  VCompIndivConiugeEsistente: Variant;
  LCompIndivConiugeEsistente: Integer;
  LMostraCompIndividuale: Boolean;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
  procedure MostraAssenze(const PAbilitaModificaFineCumulo: Boolean; const PFineCumuloAlternativa: TDateTime(* const PCompIndividuali: Integer; const PRifDataNas: TRiferimentoDataNascita*));
  {$IFNDEF IRISWEB}
  var
    i,j,
    OreConteggiateTot:Integer;
    VisFamRif,ColonnaZero:Boolean;
    LVarMaxIndividuale: real;
  {$ENDIF}
  begin
    {$IFNDEF IRISWEB}
    R600FVisAssenze:=TR600FVisAssenze.Create(nil);
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    R600FVisAssenze.R600DM:=Self;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    R600FVisAssenzeCumulate:=TR600FVisAssenzeCumulate.Create(nil);
    R600FVisPeriodiCumulati:=TR600FVisAssenzeCumulate.Create(nil);

    // form assenze cumulate
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    R600FVisAssenzeCumulate.Width:=500;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    with R600FVisAssenzeCumulate.StringGrid1 do
    begin
      RowCount:=1;
      OreConteggiateTot:=0;
      for i:=0 to High(AssenzeCumulateOrdData) do
      begin
        if AssenzeCumulateOrdData[i].DaVisualizzare then
        begin
          Cells[0,RowCount]:=IntToStr(RowCount);
          Cells[1,RowCount]:=AssenzeCumulateOrdData[i].Data;
          Cells[2,RowCount]:=AssenzeCumulateOrdData[i].Causale;
          Cells[3,RowCount]:=AssenzeCumulateOrdData[i].Tipo;
          Cells[4,RowCount]:=AssenzeCumulateOrdData[i].Ore;
          Cells[5,RowCount]:=AssenzeCumulateOrdData[i].OreConteggiate;
          OreConteggiateTot:=OreConteggiateTot + R180OreMinuti(AssenzeCumulateOrdData[i].OreConteggiate);
          Cells[6,RowCount]:=IfThen(AssenzeCumulateOrdData[i].Coniuge,'SI','');
          Cells[7,RowCount]:=IfThen(AssenzeCumulateOrdData[i].RichiestaWeb,'SI','');
          RowCount:=RowCount + 1;
        end;
      end;
      Cells[0,RowCount]:='Totale';
      Cells[5,RowCount]:=R180MinutiOre(OreConteggiateTot);
      RowCount:=RowCount + 1;
      if RowCount = 1 then
        RowCount:=2;
      FixedRows:=1;
    end;

    // numero di periodi
    if Length(AssenzeCumulate) > 0 then
      R600FVisAssenze.lblNumeroFruizioni.Caption:=IntToStr(RiepilogoAssenze[0].NumPeriodi)//IntToStr(GetNumPeriodiAssenzeCumulate(0,Q265.FieldByName('CODICE').AsString))
    else
      R600FVisAssenze.lblNumeroFruizioni.Caption:='-';

    // elenco dei periodi
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    R600FVisPeriodiCumulati.Width:=650;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    with R600FVisPeriodiCumulati.StringGrid1 do
    begin
      RowCount:=High(PeriodiCumulati) + 2;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
      //ColCount:=5;
      ColCount:=8;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      FixedCols:=1;
      Cells[1,0]:='Dal';
      Cells[2,0]:='Al';
      Cells[3,0]:='Causali';
      Cells[4,0]:='Coniuge';
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
      Cells[5,0]:='Dipendente';
      Cells[6,0]:='Coniuge';
      Cells[7,0]:='Totale';
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      ColWidths[1]:=70;
      ColWidths[2]:=70;
      ColWidths[3]:=180;
      ColWidths[4]:=50;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
      ColWidths[5]:=70;
      ColWidths[6]:=70;
      ColWidths[7]:=70;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      for i:=0 to High(PeriodiCumulati) do
      begin
        Cells[0,i + 1]:=IntToStr(i + 1);
        Cells[1,i + 1]:=DateToStr(PeriodiCumulati[i].Dal);
        Cells[2,i + 1]:=DateToStr(PeriodiCumulati[i].Al);
        Cells[3,i + 1]:=PeriodiCumulati[i].Causali;
        Cells[4,i + 1]:=IfThen(PeriodiCumulati[i].Coniuge,'SI','');
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
        Cells[5,i + 1]:=FloatToStr(PeriodiCumulati[i].NumGiorniDip);
        Cells[6,i + 1]:=FloatToStr(PeriodiCumulati[i].NumGiorniConiuge);
        Cells[7,i + 1]:=FloatToStr(PeriodiCumulati[i].NumGiorni);
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      end;
      if RowCount = 1 then
        RowCount:=2;
      FixedRows:=1;
    end;

    // form riepilogo assenze
    with R600FVisAssenze do
    begin
      try
        //RifDataNascita:=PRifDataNas; // csi
        btnAssCumulate.Enabled:=Length(AssenzeCumulate) > 0;
        btnPeriodiCumulati.Enabled:=Length(AssenzeCumulate) > 0;
        LMatricola.Caption:=RiepilogoAssenze[0].Matricola;
        LNome.Caption:=RiepilogoAssenze[0].Nominativo;
        LCausale.Caption:=Giustificativo.Causale + ' - ' + Giustificativo.Raggruppamento;
        lblPeriodoCumulo.Caption:=RiepilogoAssenze[0].PeriodoCumulo;
        VisFamRif:=RiepilogoAssenze[0].VisFamRif;
        lblFamRif.Visible:=VisFamRif;
        lblDataFamRif.Visible:=VisFamRif;
        if VisFamRif then
          lblDataFamRif.Caption:=RiepilogoAssenze[0].Familiare;
        GroupBox1.Caption:='Profilo assenze: ' + RiepilogoAssenze[0].ProfiloAssenze;
        // Lorena 29/12/2005: modifiche per nuova gestione profili assenze con Fruizione Minima A.C.
        lblFruizMinimaTitolo.Caption:=RiepilogoAssenze[0].TitoloFruizMinimaAC;
        LFruizMinima.Caption:=RiepilogoAssenze[0].FruizMinimaAC;
        // comptenza totale
        LCompTotale.Caption:=RiepilogoAssenze[0].CompLordeAC;
        // variazioni alle competenze lorde
        LPeriodiRapporto.Caption:=RiepilogoAssenze[0].VarPeriodiRapporto;
        LCompArrotondata.Caption:=RiepilogoAssenze[0].AbbattiAssCess;
        if PropRatei then
        begin
          j:=0;
          for i:=1 to 12 do
            j:=j + AssAbbateRateoMM[i];
          LCompSoloFerie.Caption:=IntToStr(-j) + ' rateo/i';
        end
        else
          LCompSoloFerie.Caption:=RiepilogoAssenze[0].DecurtazNonMatura;
        LPartTime.Caption:=RiepilogoAssenze[0].VarPartTime;
        LAbilAnagr.Caption:=RiepilogoAssenze[0].VarAbilitazioneAnagrafica;
        LDecurtazione.Caption:=RiepilogoAssenze[0].VarCompManuale;
        // AOSTA_REGIONE - commessa 2012/152.ini
        lblFruizMMInteri.Caption:=RiepilogoAssenze[0].VarFruizMMInteri; // VarFruizMMInteriDip??
        // TORINO_CSI - evolutive 02/10/2015.fine
        lblMaxIndividuale.Caption:=RiepilogoAssenze[0].VarMaxIndividuale;
        lblFruizMMContinuativi.Caption:=RiepilogoAssenze[0].VarFruizMMContinuativi;
        lblGGNoLavVuoti.Caption:=RiepilogoAssenze[0].VarGGNoLavVuoti;
        // AOSTA_REGIONE - commessa 2012/152.fine
        lblFestePartic.Caption:=RiepilogoAssenze[0].VarFestePartic;
        // competenza finale = netta
        LCompFinale.Caption:=RiepilogoAssenze[0].CompNetteAC;
        UnitaMisura:=UMisura;
        TCumulo:=TipoCumulo;
        CodInt:=CodIntQ260;
        //Part-time
        memoPartTime.Lines.Text:=RiepilogoAssenze[0].PartTime;
        for i:=1 to 6 do
        begin
          Grid1.Cells[i,1]:=R180GiorniOreToStr(ResiduiVal[i],UMisura);
          Grid1.Cells[i,3]:=R180GiorniOreToStr(VisFruitoAP[i],UMisura);
          Grid1.Cells[i,5]:=R180GiorniOreToStr(ResiduiVal[i] - VisFruitoAP[i],UMisura);
          Grid1.Cells[i,2]:=R180GiorniOreToStr(VisCompetenzeAC[i],UMisura);
          Grid1.Cells[i,4]:=R180GiorniOreToStr(VisFruitoAC[i],UMisura);
          Grid1.Cells[i,6]:=R180GiorniOreToStr(VisCompetenzeAC[i] - VisFruitoAC[i],UMisura);
          Grid1.Cells[i,7]:=R180GiorniOreToStr(Competenze[i],UMisura);
          Grid1.Cells[i,8]:=R180GiorniOreToStr(CompetenzeParziali[i],UMisura);
          Grid1.Cells[i,9]:=R180GiorniOreToStr(CompetenzeParziali[i] - VisFruitoAC[i],UMisura);
        end;
        // TORINO_CSI - evolutive.ini
        // modifica i dati delle competenze in F1 escludendo la variazione per comp. max individuale
        LVarMaxIndividuale:=R180StrToGiorniOre(RiepilogoAssenze[0].VarMaxIndividuale,UMisura);
        Grid1.Cells[1,2]:=R180GiorniOreToStr(VisCompetenzeAC[1] - LVarMaxIndividuale,UMisura);
        Grid1.Cells[1,4]:=R180GiorniOreToStr(VisFruitoAC[1],UMisura);
        Grid1.Cells[1,6]:=R180GiorniOreToStr(VisCompetenzeAC[1] - LVarMaxIndividuale - VisFruitoAC[1],UMisura);
        // TORINO_CSI - evolutive.fine
        //Visualizzazione totali
        Grid1.Cells[7,1]:=RiepilogoAssenze[0].CP;
        Grid1.Cells[7,3]:=RiepilogoAssenze[0].FP;
        Grid1.Cells[7,5]:=RiepilogoAssenze[0].RP;
        Grid1.Cells[7,2]:=RiepilogoAssenze[0].CC;
        Grid1.Cells[7,4]:=RiepilogoAssenze[0].FC;
        Grid1.Cells[7,6]:=RiepilogoAssenze[0].RC;
        Grid1.Cells[7,7]:=RiepilogoAssenze[0].R;
        Grid1.Cells[7,8]:=RiepilogoAssenze[0].CParz;
        Grid1.Cells[7,9]:=RiepilogoAssenze[0].RParz;
       //Galliera: visualizzazione assenze ad ore in giorni!!!
        if (UMisura = 'G') or (ValenzaGiornaliera = 0) then
          Grid1.ColCount:=8
        else
        begin
          if RiepilogoAssenze[0].EsisteResiduo then
          begin
            Grid1.Cells[8,1]:=RiepilogoAssenze[0].H_CP;
            Grid1.Cells[8,3]:=RiepilogoAssenze[0].H_FP;
            Grid1.Cells[8,5]:=RiepilogoAssenze[0].H_RP;
          end;
          Grid1.Cells[8,2]:=RiepilogoAssenze[0].H_CC;
          Grid1.Cells[8,4]:=RiepilogoAssenze[0].H_FC;
          Grid1.Cells[8,6]:=RiepilogoAssenze[0].H_RC;
          Grid1.Cells[8,7]:=RiepilogoAssenze[0].H_R;
        end;
        //Visualizzazione residui precedenti                            // Lorena 29/12/2005
        if RiepilogoAssenze[0].Residuabile then
        begin
          Grid1.RowHeights[1]:=Grid1.DefaultRowHeight;
          Grid1.RowHeights[3]:=Grid1.DefaultRowHeight;
          Grid1.RowHeights[5]:=Grid1.DefaultRowHeight;
          Grid1.RowHeights[7]:=Grid1.DefaultRowHeight;
        end
        else
        begin
          Grid1.RowHeights[1]:=0;
          Grid1.RowHeights[3]:=0;
          Grid1.RowHeights[5]:=0;
          Grid1.RowHeights[7]:=0;
        end;
        //Vis.comp.parziali se esiste profilo assenze               // Lorena 29/12/2005
        if RiepilogoAssenze[0].CompAnnoSolare then
        begin
          Grid1.RowHeights[8]:=Grid1.DefaultRowHeight;
          Grid1.RowHeights[9]:=Grid1.DefaultRowHeight;
        end
        else
        begin
          Grid1.RowHeights[8]:=0;
          Grid1.RowHeights[9]:=0;
        end;
        //Alberto 15/02/2006
        for i:=1 to Grid1.ColCount - 1 do
        begin
          ColonnaZero:=True;
          for j:=1 to Grid1.RowCount - 1 do
          begin
            if (Trim(Grid1.Cells[i,j]) <> '') and (Trim(Grid1.Cells[i,j]) <> '0') and (Trim(Grid1.Cells[i,j]) <> '00.00') then
            begin
              ColonnaZero:=False;
              Break;
            end;
          end;
          if ColonnaZero then
          begin
            for j:=1 to Grid1.RowCount - 1 do
              Grid1.Cells[i,j]:='';
          end;
        end;
        // determina se abilitare il pulsante di modifica fine cumulo
        btnCambiaFineCumulo.Visible:=PAbilitaModificaFineCumulo;
        btnCambiaFineCumulo.Caption:='Riepilogo al ' + DateToStr(PFineCumuloAlternativa);
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
        //CompIndividuali:=PCompIndividuali;
        btnRiepIndividuale.Visible:=(Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (ValCompIndivConiugeEsistente >= 0);
        btnRiepIndividuale.Caption:='Riepilogo individuale';
        btnRiepIndividuale.Tag:=0;
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
        ShowModal;
        // determina se è necessario modificare la data di fine cumulo
        CambiaFineCumulo:=SwitchFineCumulo;
      finally
        R600FVisAssenzeCumulate.Free;
        R600FVisPeriodiCumulati.Free;
        Free;
      end;
    end;
    {$ENDIF}
  end;
begin
  LetturaAssenze:=True;
  Visualizza:=True;
  CambiaFineCumulo:=False;
  SetLength(PeriodiCumulati,0);
  SetLength(RiepilogoAssenze,0);

  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  // estrae le competenze individuali nel caso di coniuge
  VCompIndivConiugeEsistente:=Q265.Lookup('CODICE',Giustif.Causale,'COMPINDIV_CONIUGE_ESISTENTE');
  //LMostraCompIndividuale:=not VarIsNull(VCompIndivConiugeEsistente);
  if VarIsNull(VCompIndivConiugeEsistente) then
    ValCompIndivConiugeEsistente:=-1
  else
    ValCompIndivConiugeEsistente:=StrToIntDef(VarToStr(VCompIndivConiugeEsistente),0);
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

  // csi.ini
  GetIDFamiliare(Prog);
  // csi.fine
  RiepilogaAssenze(Prog,Inizio,Giustif,False,RiferimentoDataNascita{.Data}); // csi
  if (Length(RiepilogoAssenze) > 0) and (RiepilogoAssenze[0].Messaggio <> '') then
  begin
    {$IFNDEF IRISWEB}
    R180MessageBox(RiepilogoAssenze[0].Messaggio,'INFORMA');
    {$ENDIF IRISWEB}
    exit;
  end;

  FC:=FineCumulo;
  FCI:=FineCumulointero;
  // visualizza le assenze dando eventualmente la possibilità di modificare
  // la data di fine cumulo
  MostraAssenze((TipoCumulo <> 'H') and (FCI > FC),FCI(*,LCompIndivConiugeEsistente,RiferimentoDataNascita*)); // csi
  while CambiaFineCumulo do
  begin
    Inizio:=IfThen(Inizio = FC,FCI,FC);
    //if SettaConteggi(Prog,Inizio,Inizio,Giustif) = mrOK then
    SetLength(RiepilogoAssenze,0);
    RiepilogaAssenze(Prog,Inizio,Giustif,False,RiferimentoDataNascita{.Data}); // csi
    FineCumulo:=FC;
    MostraAssenze(True,IfThen(Inizio = FC,FCI,FC)(*,LCompIndivConiugeEsistente,RiferimentoDataNascita*)); // csi
  end;

  LetturaAssenze:=False;
  Visualizza:=False;
end;

function TR600DtM1.SwitchRiepilogoConiuge(PRiepIndividuale:Boolean; var PRiepAss:TRiepilogoAssenze):Boolean;
var
  LCdsActive: Boolean;
  LFruitoIndiv, LFruizioneMesiContDip, LFruizioneMMInteriDip,
  LResiduoComplessivo, LResiduoIndiv, LVarMaxIndividuale: real;
  S,LTipoGiust: String;
begin
  Result:=True;
  // il residuo complessivo è dato dalla differenza fra A e B, dove:
  // A = competenze calcolate anno corrente
  //     (ESCLUDENDO la parte di variazione per la competenza max individuale)
  // B = fruito anno corrente
  LVarMaxIndividuale:=ValVariazioneFruizMMContinuativi;
  LResiduoComplessivo:=VisCompetenzeAC[1] - LVarMaxIndividuale - VisFruitoAC[1];

  // determina le competenze da visualizzare in fascia 1
  // csi.ini
  //if LRiepIndividuale then
  // nel caso di genitore single le competenze individuali e complessive
  // coincidono, pertanto viene riportato il dato complessivo
  //??GetIdFamiliare??
  if PRiepIndividuale and (RiferimentoDataNascita.PartFruizMaternita <> 'A') then
  begin
    // determina il fruito individuale sfruttando il clientdataset delle fruizioni
    LFruitoIndiv:=0;
    cdsFruizioni.Filtered:=False;
    try
      try
        cdsFruizioni.Filter:='CONIUGE = ''N''';
        cdsFruizioni.Filtered:=True;
        LCdsActive:=cdsFruizioni.Active;
        if not LCdsActive then
          cdsFruizioni.Open;
        cdsFruizioni.First;
        while not cdsFruizioni.Eof do
        begin
          LTipoGiust:=cdsFruizioni.FieldByName('TIPOGIUST').AsString;
          if LTipoGiust = 'I' then
            LFruitoIndiv:=LFruitoIndiv + 1
          else if LTipoGiust = 'M' then
            LFruitoIndiv:=LFruitoIndiv + 0.5;
          cdsFruizioni.Next;
        end;
      except
        on E: Exception do
        begin
          // segnala errore e chiude la finestra di visualizzazione
          Result:=False;
          raise;
        end;
      end;
    finally
      // rimuove il filter sul clientdataset
      cdsFruizioni.Filtered:=False;
      cdsFruizioni.Filter:='';
      if not LCdsActive then
        cdsFruizioni.Close;
    end;

    // dati individuali di competenze e residuo
    LFruizioneMesiContDip:=ValVariazioneFruizMMContinuativiDip;
    LFruizioneMMInteriDip:=ValVariazioneFruizMMInteriDip;
    PRiepAss.CompFinale:=R180GiorniOreToStr(ValCompIndivConiugeEsistente + LFruizioneMesiContDip + LFruizioneMMInteriDip,UMisura,'%3.2f');
    PRiepAss.CC:=R180GiorniOreToStr(ValCompIndivConiugeEsistente + LFruizioneMesiContDip + LFruizioneMMInteriDip,UMisura);
    PRiepAss.FC:=R180GiorniOreToStr(LFruitoIndiv,UMisura);
    LResiduoIndiv:=ValCompIndivConiugeEsistente + LFruizioneMesiContDip + LFruizioneMMInteriDip - LFruitoIndiv;
    PRiepAss.RC:=R180GiorniOreToStr(LResiduoIndiv,UMisura);
  end
  else
  begin
    // dati complessivi
    PRiepAss.CompFinale:=R180GiorniOreToStr(VisCompetenzeAC[1],UMisura,'%3.2f');
    PRiepAss.CC:=R180GiorniOreToStr(VisCompetenzeAC[1] - LVarMaxIndividuale,UMisura);
    PRiepAss.FC:=R180GiorniOreToStr(VisFruitoAC[1],UMisura);
    PRiepAss.RC:=R180GiorniOreToStr(LResiduoComplessivo,UMisura);
  end;
end;


function TR600DtM1.ElencoProfPartTime:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to High(ProfPartTime) do
    Result:=Result + IfThen(Result <> '',#13#10) + Format('%3.2f%% dal %s al %s',[ProfPartTime[i].Percentuale,DatetoStr(ProfPartTime[i].ValidoDal),DatetoStr(ProfPartTime[i].ValidoAl)]);
end;

function TR600DtM1.DescrizioneProfiloAssenze:String;
begin
  Result:=ProfiloAssenze + ' ' + Copy(DProfiloAssenze,1,25);
  if (ProfiloAssenze <> 'Individuale') and (ProfiloAssenze <> '') then
    Result:=Result + ' - Arrot. ' + IfThen((ArrotFav = 'F') or (ArrotFav = 'P'),'Favorevole','Sfavorevole');
end;

function TR600DtM1.DescrizionePeriodoCumulo:String;
begin
  Result:=DateToStr(InizioCumulo) + ' - ' + DateToStr(FineCumulo);
  // irisweb non è ancora pronto al cambio di fine cumulo!
  if FineCumulo < FineCumuloIntero then
    Result:=Result + ' (' + DateToStr(FineCumuloIntero) + ')';
end;

function TR600DtM1.TitoloFruizioneMinimaAC:String;
begin
  Result:='Fruiz. min. anno corrente' + IfThen(DateToStr(InizioFruizForzataAC) <> '31/12/3999',' (' + DateToStr(InizioFruizForzataAC) + ')') + ':';
end;

procedure TR600DtM1.DividiPrecCorr;
{Divide le competenze ed il fruito tra anno precedente ed anno corrente}
var i:Integer;
  FruitoTotale,Appoggio,FruizMinimaApp:Real;  //Lorena 29/12/2005
begin
  //ResiduiVal:      Competenze anno precedente
  //VisCompetenzeAC: Competenze anno corrente
  //VisFruitoAP:     Fruito anno precedente
  //VisFruitoAC:     Fruito anno corrente
  //Competenze:      Residuo
  FruizMinimaApp:=Min(FruizMinimaAC,FruitoForzatoAC);
  // Lorena 29/12/2005: modifiche per nuova gestione profili assenze con Fruizione Minima
  for i:=1 to 6 do
  begin
    VisFruitoAC[i]:=0;
    VisFruitoAP[i]:=0;
    VisCompetenzeAC[i]:=CompetenzeOri[i] - ResiduiVal[i];   //Comp.Tot. - Comp.A.P.
    //calcolato come distribuzione di FruitoAP sulle 6 fasce
    FruitoTotale:=CompetenzeOri[i] - Competenze[i];     //Lorena 29/12/2005  Comp.Tot. - Res.Tot.
    if FruizMinimaApp > 0 then  //Lorena 29/12/2005
    begin
      if FruitoTotale > FruizMinimaApp then
      begin
        VisFruitoAC[i]:=FruizMinimaApp;
        FruitoTotale:=FruitoTotale - FruizMinimaApp;
      end
      else if FruitoTotale > 0 then
      begin
        VisFruitoAC[i]:=FruitoTotale;
        FruitoTotale:=0;
      end;
    end;
    if FineResiduo then
    begin
      if FruizMinimaApp > 0 then  //Lorena 29/12/2005
      begin
        if (i = 1) and (FruitoAP > 0) then  //solo 1 volta
        begin
          if FruitoAP > FruizMinimaApp then
            FruitoAP:=FruitoAP - FruizMinimaApp
          else
            FruitoAP:=0;
        end;
        Appoggio:=FruizMinimaApp;
        if (ResiduiVal[i] > 0) and (Appoggio > 0) then
          if ResiduiVal[i] >= Appoggio then
          begin
            ResiduiVal[i]:=ResiduiVal[i] - Appoggio;
          end
          else
          begin
            ResiduiVal[i]:=0;
          end;
        Appoggio:=FruizMinimaApp;
        if (Competenze[i] > 0) and (Appoggio > 0) then
          if Competenze[i] >= Appoggio then
          begin
            Competenze[i]:=Competenze[i] - Appoggio;
          end
          else
          begin
            Competenze[i]:=0;
          end;
      end;
      if FruitoAP < ResiduiVal[i] then
      begin
        VisFruitoAP[i]:=FruitoAP;
        FruitoAP:=0;
      end
      else if ResiduiVal[i] >= 0 then
      begin
        VisFruitoAP[i]:=ResiduiVal[i];
        FruitoAP:=FruitoAP - ResiduiVal[i];
      end;
      VisFruitoAC[i]:=VisFruitoAC[i] + FruitoTotale - VisFruitoAP[i];       //Lorena 29/12/2005
      Competenze[i]:=Competenze[i] + VisFruitoAP[i] - ResiduiVal[i];        //Lorena 29/12/2005
    end
    else  //not FineResiduo
      if FruitoTotale < ResiduiVal[i] then       //Lorena 29/12/2005
      begin
        VisFruitoAP[i]:=FruitoTotale;       //Lorena 29/12/2005
        VisFruitoAC[i]:=VisFruitoAC[i];
      end
      //Alberto 10/04/2006
      else //if ResiduiVal[i] >= 0 then
      begin
        VisFruitoAP[i]:=Max(0,ResiduiVal[i]);
        VisFruitoAC[i]:=VisFruitoAC[i] + FruitoTotale - Max(0,ResiduiVal[i]);     //Lorena 29/12/2005
      end;
  end;
end;

procedure TR600DtM1.GetIDFamiliare(PProgressivo:Integer);
begin
  if selSG101NumOrd.GetVariable('PROGRESSIVO') <> PProgressivo then
  begin
    selSG101NumOrd.Close;
    selSG101NumOrd.SetVariable('PROGRESSIVO',PProgressivo);
  end;
  selSG101NumOrd.Open;
  RiferimentoDataNascita.IDFamiliare:=VarToStr(selSG101NumOrd.Lookup('DATA',RiferimentoDataNascita.Data,'NUMORD'));  //Lorena 02/09/2005
  RiferimentoDataNascita.GradoPar:=VarToStr(selSG101NumOrd.Lookup('DATA',RiferimentoDataNascita.Data,'GRADOPAR'));  //Alberto 14/11/2010
  if RiferimentoDataNascita.IDFamiliare = '' then
    RiferimentoDataNascita.IDFamiliare:='_';
  RiferimentoDataNascita.PartFruizMaternita:=VarToStr(selSG101NumOrd.Lookup('DATA',RiferimentoDataNascita.Data,'PART_FRUIZ_MATERNITA')); // csi
end;

function TR600DtM1.GetValStrT230(Causale,Nome:String; Data:TDateTime):String;
{Leggo il valore storicizzato alla Data per la Causale}
var D,DF:TDateTime;
begin
  Result:='';
  with T230F_GETVALUE do
  begin
    D:=0;
    DF:=0;
    if GetVariable('DECORRENZA') <> null then
    begin
      D:=GetVariable('DECORRENZA');
      DF:=GetVariable('DECORRENZA_FINE');
    end;
    if (VarToStr(GetVariable('CAUSALE')) <> Causale) or
       (VarToStr(GetVariable('NOME')) <> Nome) or
       //(GetVariable('DATA') <> Data) then
       (not R180Between(Data,D,DF)) then
    begin
      SetVariable('CAUSALE',Causale);
      SetVariable('NOME',Nome);
      SetVariable('DATA',Data);
      Execute;
    end;
    Result:=VarToStr(GetVariable('VALORE'));
  end;
end;

function TR600DtM1.CheckScaricoPagheFruiz(Causale,TipoGiust:String; Data:TDateTime):String;
{Leggo l'abilitazione allo scarico paghe in base alla fruizione}
begin
  Result:='';
  with T230F_CHECK_SCARICOPAGHE_FRUIZ do
  begin
    SetVariable('CAUSALE',Causale);
    SetVariable('TIPOGIUST',TipoGiust);
    SetVariable('DATA',Data);
    Execute;
    Result:=VarToStr(GetVariable('VALORE'));
  end;
end;

function TR600DtM1.GetHMAssenza(Prog:LongInt; Data:TDateTime; Causale:String):Integer;
{Leggo la valorizzazione giornaliera della causale storicizzata e proprozionata per part-time Orizz.}
begin
  Result:=0;
  with T230F_HMASSENZA_PROPPT do
  begin
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('DATA',Data);
    SetVariable('CAUSALE',Causale);
    Execute;
    Result:=GetVariable('HMASSENZA');
  end;
end;

function TR600DtM1.GetUnitaMisura(Prog:LongInt; Inizio:TDateTime; Gius:TGiustificativo):String;
{Come SettaConteggi, ma restituisce solo l'unità di misura}
var A,M,G:Word;
begin
  Giustificativo:=Gius;
  QSDip.GetDatiStorici('T430TGestione,T430AbCausale1,T430PAssenze,T430Inizio,T430Badge,T430Orario',Prog,Inizio,Inizio);
  if QSDip.RecordCount = 0 then
  begin
    if selMinDataDecorrenza.GetVariable('Progressivo') <> Prog then
    begin
      selMinDataDecorrenza.SetVariable('Progressivo',Prog);
      selMinDataDecorrenza.Execute;
    end;
    QSDip.GetDatiStorici('T430TGestione,T430AbCausale1,T430PAssenze,T430Inizio,T430Badge,T430Orario',Prog,Inizio,selMinDataDecorrenza.FieldAsDate(0));
  end;
  //Leggo la causale in uso
  with Q265 do
  begin
    SearchRecord('Codice',Giustificativo.Causale,[srFromBeginning]);
    Giustificativo.Raggruppamento:=FieldByname('CodRaggr').AsString;
  end;
  UMisura:='';
  ArrotMG:='S';
  ArrotFav:='F';
  ArrotOre:='00.00';
  LimiteResiduo:=StrToDate(DataFine);
  InizioFruizForzataAC:=StrToDate(DataFine);
  if Prog <> Progressivo then
  begin
    Progressivo:=Prog;
    SettaProgressivo;
  end;
  if (Inizio <> DaData) or (Inizio <> AData) then
  begin
    DaData:=Inizio;
    AData:=Inizio;
  end;
  DecodeDate(DaData,A,M,G);
  with Q265 do
    //Leggo se raggruppamento ad anno solare
  begin
    CodIntQ260:=FieldByName('CodInterno').AsString;
    if FieldByName('ContASolare').AsString = 'S' then
      CercaProfiloAssenze(A,False)
    else
      //Lettura competenze da Causale Assenze
      LeggiCompetenze(0);
  end;
  Result:=UMisura;
end;

procedure TR600DtM1.GetQuantitaAssenze(Prog:LongInt; Inizio,Fine,DataNas:TDateTime; Giustif:TGiustificativo; var UM:String; var Quantita,OreRese:Real);
{Restituisce in Quantità i giorni o le ore fruite con la causale specificata in Giustif}
var D1,D2:TDateTime;
    Q:TOracleDataSet;
    ConteggiOld:TConteggiOld;
    PTPRec:TProfPartTime;
begin
  GetCompPrec:='0';
  GetCompCorr:='0';
  GetCompTot:='0';
  GetFruitoPrec:='0';
  GetFruitoCorr:='0';
  GetFruitoTot:='0';
  GetResiduo:='0';
  GetResiduoPrec:='0';
  GetResiduoCorr:='0';
  GetCompParz:='0';
  GetResiduoParz:='0';
  ValCompPrec:=0;
  ValCompCorr:=0;
  ValCompTot:=0;
  ValFruitoPrec:=0;
  ValFruitoCorr:=0;
  ValFruitoTot:=0;
  ValResiduo:=0;
  ValResiduoPrec:=0;
  ValResiduoCorr:=0;
  ValCompParz:=0;
  ValResiduoParz:=0;
  UM:=GetUnitaMisura(Prog,Fine,Giustif);
  UMisura:=UM;
  Quantita:=0;
  ValenzaGiornaliera:=0;
  Giustificativo:=Giustif;
  (*ValorizzazioneOraria:=True;*)
  FruitoCorrGG:=0;
  FruitoCorrHH:=0;
  FruitoCompPrec:=0;
  //Leggo la valorizzazione giornaliera della causale
  (*
  with Q265 do
    if not FieldByName('HMAssenza').IsNull then
      ValenzaGiornaliera:=R180OreMinuti(FieldByName('HMAssenza').AsDateTime);
  *)
  //Leggo la valorizzazione giornaliera della causale (01/06/2018: storicizzata e proprozionata per part-time Orizz.)
  ValenzaGiornaliera:=GetHMAssenza(Prog,Fine,Giustificativo.Causale);
  if ValenzaGiornaliera = 0 then
    //Calcolo valorizzazione giornaliera
    with GetCalend do
    begin
      if (GetVariable('Prog') <> Prog) or (GetVariable('D') <> Fine) then
      begin
        SetVariable('Prog',Prog);
        SetVariable('D',Fine);
        Execute;
      end;
      if (VarToStr(GetVariable('L')) = '') and (VarToStr(GetVariable('F')) = '') and (GetVariable('G') = 0) then
        ValenzaGiornaliera:=0
      else
        try
          ValenzaGiornaliera:=R180OreMinutiExt(GetVariable('MONTEORE')) div GetVariable('G');
        except
          ValenzaGiornaliera:=0;
        end;
    end;
  if Giustificativo.Modo in ['I','M','N'] then
  begin
    Giustificativo.AOre:=TimeToStr(Time);
    if Giustificativo.Modo in ['I','M'] then
    begin
      if Giustificativo.Modo = 'I' then
        Giustificativo.DaOre:=TimeToStr(Time)
      else if Giustificativo.Modo = 'M' then
      begin
        if Trim(Giustificativo.DaOre) = '.' then
          Giustificativo.DaOre:=TimeToStr(StrToTime('00.00'))
        else
          Giustificativo.DaOre:=TimeToStr(StrToTime(Giustificativo.DaOre));
      end;
    end;
  end;
  //Trasformo le ore nel formato hh.nn.ss
  if Giustificativo.Modo in ['D','N'] then
  begin
    Giustificativo.DaOre:=TimeToStr(StrToTime(Giustificativo.DaOre));
    if Giustificativo.Modo = 'D' then
      Giustificativo.AOre:=TimeToStr(StrToTime(Giustificativo.AOre));
  end;
  GiorniTot:=0;
  GiorniUni:=0;
  FruitoAP:=0;
  FruitoAP_Ore:=0;
  FruitoForzatoAC:=0;
  FruitoForzatoAC_Ore:=0;
  OreTot:=0;
  OreUni:=0;
  OreReseDaAssenza:=0;
  if Prog <> Progressivo then
  begin
    Progressivo:=Prog;
    SettaProgressivo;
  end;
  if (Inizio <> DaData) or (Fine <> AData) then
  begin
    DaData:=Inizio;
    AData:=Fine;
  end;
  if R180CarattereDef(Q265.FieldByName('Cumulo_Familiari').AsString,1,'N') in ['S','D'] then
  begin
    Q:=QuantAssenzeDataNas;
    Q.SetVariable('DataNas',DataNas);
    RiferimentoDataNascita.Data:=DataNas;
    GetIDFamiliare(Progressivo);
  end
  else
    Q:=QuantAssenze;
  with Q do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA1',DaData);
    SetVariable('DATA2',AData);
    SetVariable('CAUSALE',Giustificativo.Causale);
    Open;
    if RecordCount > 0 then
    begin
      D1:=FieldByName('Data').AsDateTime - 2;
      Last;
      D2:=FieldByName('Data').AsDateTime + 2;
      First;
      //R502ProDtM1.Chiamante:='Cartolina';
      R502ProDtM1.PeriodoConteggi(D1,D2);
      {$IFDEF MEDP803}R502ProDtM1.Q100.Open;{$ENDIF}
      ConteggiOld.Prg:=Progressivo;
      ConteggiOld.Data:=0;
    end;
  end;

  CreaCdsFruizioni;
  while not Q.Eof do
  begin
    cdsFruizioni.Append;
    cdsFruizioni.FieldByName('PROGRESSIVO').AsInteger:=Progressivo;
    cdsFruizioni.FieldByName('DATA').AsDateTime:=Q.FieldByName('DATA').AsDateTime;
    cdsFruizioni.FieldByName('CAUSALE').AsString:=Q.FieldByName('CAUSALE').AsString;
    cdsFruizioni.FieldByName('CAUSALE_NUOVA').AsString:='';
    cdsFruizioni.FieldByName('PROGRCAUSALE').AsInteger:=Q.FieldByName('PROGRCAUSALE').AsInteger;
    cdsFruizioni.FieldByName('TIPOGIUST').AsString:=Q.FieldByName('TIPOGIUST').AsString;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    cdsFruizioni.FieldByName('CSI_TIPO_MG').AsString:=Q.FieldByName('CSI_TIPO_MG').AsString;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    cdsFruizioni.FieldByName('DAORE').Value:=Q.FieldByName('DAORE').Value;
    cdsFruizioni.FieldByName('AORE').Value:=Q.FieldByName('AORE').Value;
    cdsFruizioni.FieldByName('CONIUGE').AsString:='N';
    cdsFruizioni.FieldByName('RICHIESTA_WEB').AsString:='';
    cdsFruizioni.Post;
    Q.Next;
  end;

  RiepQualmin.DebitoGGQM:=0;
  RiepQualmin.NumGiorniSett:=0;
  RiepQualmin.OreSett:=0;
  RiepQualmin.Quantita:=0;
  SetLength(R502ProDtM1.GiustificativiR600,0);
  with cdsFruizioni do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('Data').AsDateTime <> ConteggiOld.Data then
        ConteggiaGiorno(ConteggiOld,False,PTPrec);
      //Registro il giustificativo in AssenzeCumulate
      AddGiustificativiR600(-1);
      ConteggiOld.Data:=FieldByName('Data').AsDateTime;
      Next;
    end;
  end;
  ConteggiaGiorno(ConteggiOld,False,PTPrec);
  cdsFruizioni.Close;

  (*    while not Eof do
      begin
        if (ConteggiOld.Data <> FieldByName('Data').AsDateTime) or ((ConteggiOld.Causale <> FieldByName('Causale').AsString)) then
        begin
          ConteggiAssenza('Cartolina',
                          FieldByName('Data').AsDateTime,
                          FieldByName('Causale').AsString,
                          R180CarattereDef(FieldByName('TipoGiust').AsString,1,#0),
                          FieldByName('DaOre').AsDateTime,
                          FieldByName('AOre').AsDateTime,
                          Progressivo);
          if R502ProDtM1.Blocca = 0 then
            SommaAssenza(FieldByName('Causale').AsString,-1,0,False,R180CarattereDef(FieldByName('TipoGiust').AsString,1,#0));
        end;
        ConteggiOld.Prg:=Progressivo;
        ConteggiOld.Data:=FieldByName('Data').AsDateTime;
        ConteggiOld.Causale:=FieldByName('Causale').AsString;
        Next;
      end;
    end;
    ValorizzaOreInGiorni;
    Close;
  end;*)
  ValorizzaOreInGiorni;
  if UM = 'G' then
    Quantita:=GiorniTot
  else
    Quantita:=OreTot;
  OreRese:=OreReseDaAssenza;
  (*ValorizzazioneOraria:=False;*)
end;

procedure TR600DtM1.GetQuantitaAssenzeQualMin(Prog:LongInt; Inizio,Fine,DataNas:TDateTime; Giustif:TGiustificativo; var Quantita:Real);
{Restituisce in Quantità i giorni fruiti nei giorni diversi da domeniche e festivi,
rapportando le ore rese alla valorizzazione giornaliera della Qualifica Ministeriale
E' richiesto che il dato libero sia di tipo Qualifica Ministeriale, e quindi ci siano le colonne ProgressivoQM e DebitoGGQM}
var D1,D2:TDateTime;
    Q:TOracleDataSet;
    ConteggiOld:TConteggiOld;
    PTPRec:TProfPartTime;
begin
  Quantita:=0;
  GetCompPrec:='0';
  GetCompCorr:='0';
  GetCompTot:='0';
  GetFruitoPrec:='0';
  GetFruitoCorr:='0';
  GetFruitoTot:='0';
  GetResiduo:='0';
  GetResiduoPrec:='0';
  GetResiduoCorr:='0';
  GetCompParz:='0';
  GetResiduoParz:='0';
  ValCompPrec:=0;
  ValCompCorr:=0;
  ValCompTot:=0;
  ValFruitoPrec:=0;
  ValFruitoCorr:=0;
  ValFruitoTot:=0;
  ValResiduo:=0;
  ValResiduoPrec:=0;
  ValResiduoCorr:=0;
  ValCompParz:=0;
  ValResiduoParz:=0;
  ValenzaGiornaliera:=0;
  Giustificativo:=Giustif;
  (*ValorizzazioneOraria:=True;*)
  FruitoCorrGG:=0;
  FruitoCorrHH:=0;
  FruitoCompPrec:=0;
  GiorniTot:=0;
  GiorniUni:=0;
  FruitoAP:=0;
  FruitoAP_Ore:=0;
  FruitoForzatoAC:=0;
  FruitoForzatoAC_Ore:=0;
  OreTot:=0;
  OreUni:=0;
  if Prog <> Progressivo then
  begin
    Progressivo:=Prog;
    SettaProgressivo;
  end;
  if (Inizio <> DaData) or (Fine <> AData) then
  begin
    DaData:=Inizio;
    AData:=Fine;
  end;
  Q:=QuantAssenzeQualMin;
  Q.ClearVariables;
  if R180CarattereDef(Q265.FieldByName('Cumulo_Familiari').AsString,1,'N') in ['S','D'] then
  begin
    Q.SetVariable('DataNas',Format('AND T040.DATANAS = TO_DATE(''%s'',''ddmmyyyy'')',[FormatDateTime('ddmmyyyy',DataNas)]));
    RiferimentoDataNascita.Data:=DataNas;
    GetIDFamiliare(Progressivo);
  end;
  with Q do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA1',DaData);
    SetVariable('DATA2',AData);
    SetVariable('CAUSALE',Giustificativo.Causale);
    Open;
    D1:=FieldByName('Data').AsDateTime - 2;
    Last;
    D2:=FieldByName('Data').AsDateTime + 2;
    First;
    R502ProDtM1.Chiamante:='Assenze';
    R502ProDtM1.PeriodoConteggi(D1,D2);
    {$IFDEF MEDP803}R502ProDtM1.Q100.Open;{$ENDIF}
    UMisura:='O';
    ConteggiOld.Prg:=Progressivo;
    ConteggiOld.Data:=0;
  end;

  CreaCdsFruizioni;
  while not Q.Eof do
  begin
    cdsFruizioni.Append;
    cdsFruizioni.FieldByName('PROGRESSIVO').AsInteger:=Progressivo;
    cdsFruizioni.FieldByName('DATA').AsDateTime:=Q.FieldByName('DATA').AsDateTime;
    cdsFruizioni.FieldByName('CAUSALE').AsString:=Q.FieldByName('CAUSALE').AsString;
    cdsFruizioni.FieldByName('CAUSALE_NUOVA').AsString:='';
    cdsFruizioni.FieldByName('PROGRCAUSALE').AsInteger:=Q.FieldByName('PROGRCAUSALE').AsInteger;
    cdsFruizioni.FieldByName('TIPOGIUST').AsString:=Q.FieldByName('TIPOGIUST').AsString;
    cdsFruizioni.FieldByName('DAORE').Value:=Q.FieldByName('DAORE').Value;
    cdsFruizioni.FieldByName('AORE').Value:=Q.FieldByName('AORE').Value;
    cdsFruizioni.FieldByName('CONIUGE').AsString:='N';
    cdsFruizioni.FieldByName('RICHIESTA_WEB').AsString:='';
    cdsFruizioni.FieldByName('DEBITOGGQM').AsString:=Q.FieldByName('DEBITOGGQM').AsString;
    cdsFruizioni.FieldByName('NUMGIORNISETT').AsInteger:=Q.FieldByName('NUMGIORNISETT').AsInteger;
    cdsFruizioni.FieldByName('ORESETT').AsInteger:=Q.FieldByName('ORESETT').AsInteger;
    cdsFruizioni.Post;
    Q.Next;
  end;

  RiepQualmin.DebitoGGQM:=0;
  RiepQualmin.NumGiorniSett:=0;
  RiepQualmin.OreSett:=0;
  RiepQualmin.Quantita:=0;
  SetLength(R502ProDtM1.GiustificativiR600,0);
  with cdsFruizioni do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('Data').AsDateTime <> ConteggiOld.Data then
        ConteggiaGiorno(ConteggiOld,False,PTPrec);
      //Registro il giustificativo in AssenzeCumulate
      AddGiustificativiR600(-1);
      ConteggiOld.Data:=FieldByName('Data').AsDateTime;
      //Dati utili per il calcolo del fruito ai fini della qualifica ministeriale
      RiepQualmin.DebitoGGQM:=R180OreMinutiExt(cdsFruizioni.FieldByName('DEBITOGGQM').AsString);
      RiepQualmin.NumGiorniSett:=FieldByName('NUMGIORNISETT').AsInteger;
      RiepQualmin.OreSett:=FieldByName('ORESETT').AsInteger;
      Next;
    end;
  end;
  ConteggiaGiorno(ConteggiOld,False,PTPrec);
  cdsFruizioni.Close;
  Quantita:=RiepQualMin.Quantita;
  (*
    while not Eof do
    begin
      OreReseDaAssenza:=0;
      if (ConteggiOld.Data <> FieldByName('Data').AsDateTime) then
      begin
        ConteggiAssenza('Cartolina',
                        FieldByName('Data').AsDateTime,
                        FieldByName('Causale').AsString,
                        R180CarattereDef(FieldByName('TipoGiust').AsString,1,#0),
                        FieldByName('DaOre').AsDateTime,
                        FieldByName('AOre').AsDateTime,
                        Progressivo);
        if R502ProDtM1.Blocca = 0 then
          SommaAssenza(FieldByName('Causale').AsString,-1,0,False,R180CarattereDef(FieldByName('TipoGiust').AsString,1,#0));
        try
          DebitoGGQM:=R180OreMinutiExt(FieldByName('DEBITOGGQM').AsString);
          if (DebitoGGQM = 0) and (FieldByName('NUMGIORNISETT').AsInteger > 0) then
            DebitoGGQM:=Round(R180OreMinutiExt(FieldByName('ORESETT').AsString)/FieldByName('NUMGIORNISETT').AsInteger);
          if DebitoGGQM > 0 then
            Quantita:=Quantita + (OreReseDaAssenza / DebitoGGQM);
        except
        end;
      end;
      ConteggiOld.Prg:=Progressivo;
      ConteggiOld.Data:=FieldByName('Data').AsDateTime;
      Next;
    end;
    Close;
  end;
  *)
  //Quantita:=Round(Quantita);
end;

function TR600DtM1.InizializzaSettaConteggi(Prog:LongInt; Inizio,Fine:TDateTime; Giustif:TGiustificativo):Boolean;
{Imposto il progressivo e la causale}
begin
  Result:=False;
  ValenzaGiornaliera:=0;
  DaData:=Inizio;
  AData:=Fine;
  Giustificativo:=Giustif;
  RapportoCorrente.Esiste:=False;
  RapportoCorrente.CompetenzeDelPeriodo:=False;
  RapportoCorrente.DataCorrente:=Fine;
  SetLength(RapportoCorrente.Rapporto,1);
  //Lettura dati anagrafici
  with QAnagra do
  begin
    if Prog <> GetVariable('Progressivo') then
    begin
      Close;
      SetVariable('Progressivo',Prog);
    end;
    Open;
    if RecordCount = 0 then
      exit;
  end;
  SettaInfo1(QAnagra.FieldByName('Cognome').AsString,QAnagra.FieldByName('Nome').AsString,QAnagra.FieldByName('Matricola').AsString,Giustificativo.Causale);
  //Imposto la Query sugli storici
  QSDip.GetDatiStorici('T430TGestione,T430AbCausale1,T430PAssenze,T430Inizio,T430Fine,T430Badge,T430Orario',Prog,Inizio,Fine);
  if QSDip.RecordCount = 0 then
  begin
    if selMinDataDecorrenza.GetVariable('Progressivo') <> Prog then
    begin
      selMinDataDecorrenza.SetVariable('Progressivo',Prog);
      selMinDataDecorrenza.Execute;
    end;
    QSDip.GetDatiStorici('T430TGestione,T430AbCausale1,T430PAssenze,T430Inizio,T430Fine,T430Badge,T430Orario',Prog,Inizio,selMinDataDecorrenza.FieldAsDate(0));
  end;
  if QSDip.RecordCount = 0 then
    exit;
  //Se causale di presenza, mi posiziono ed esco subito
  selT275.Open;
  if selT275.SearchRecord('Codice',Giustificativo.Causale,[srFromBeginning]) then
  begin
    Progressivo:=Prog;
    // bugfix.ini - chiamata <126779> di TORINO_ZOOPROFILATTICO
    // è indispensabile richiamare il metodo SettaProgressivo, che altrimenti non verrebbe più richiamato dove necessario
    SettaProgressivo;
    // bugfix.fine
    exit;
  end;
  //Se causale di assenza mi posiziono e verifico le abilitazioni
  with Q265 do
  begin
    SearchRecord('Codice',Giustificativo.Causale,[srFromBeginning]);
    Giustificativo.Raggruppamento:=FieldByname('CodRaggr').AsString;
    (*
    if not FieldByName('HMAssenza').IsNull then
      ValenzaGiornaliera:=R180OreMinuti(FieldByName('HMAssenza').AsDateTime);
    *)
    //Leggo la valorizzazione giornaliera della causale (01/06/2018: storicizzata e proprozionata per part-time Orizz.)
    ValenzaGiornaliera:=GetHMAssenza(Prog,Fine,Giustificativo.Causale);
    TipoCumulo:=R180CarattereDef(FieldByName('TipoCumulo').AsString,1,'H');
  end;
  if not QSDip.LocDatoStorico(Fine) then
    QSDip.First;
  selRapportiUniti.SetVariable('PROGRESSIVO',Prog);
  selRapportiUniti.SetVariable('CAUSALE',Q265.FieldByName('CODICE').AsString);
  selRapportiUniti.SetVariable('DATA',Fine);
  selRapportiUniti.Execute;
  if selRapportiUniti.RowCount > 0 then
    RapportoCorrente.Esiste:=IfThen(selRapportiUniti.FieldAsString(0) = 'A',QAnagra.FieldByName('Rapporti_Uniti').AsString,selRapportiUniti.FieldAsString(0)) = 'N'
  else
    RapportoCorrente.Esiste:=QAnagra.FieldByName('Rapporti_Uniti').AsString = 'N';

  //RapportoCorrente eventualmente modificato in base a IterIgnoraFineRapporto
  RapportoCorrente.Rapporto[0].Inizio:=QSDip.FieldByName('T430Inizio').AsDateTime;
  if QSDip.FieldByName('T430Fine').IsNull then
    RapportoCorrente.Rapporto[0].Fine:=StrToDate(DataFine)
  else
    RapportoCorrente.Rapporto[0].Fine:=QSDip.FieldByName('T430Fine').AsDateTime;

  if Prog <> Progressivo then
  begin
    Progressivo:=Prog;
    SettaProgressivo;
  end;

  UMisura:='';
  ArrotMG:='S';
  ArrotFav:='F';
  ArrotOre:='00.00';
  AssenzaAbilitata:=True;
  //Se l'assenza non è fruibile da tutti ed è disabilitata esco subito
  if Q265.FieldByName('Fruibile').AsString <> 'S' then
  begin
    AssenzaAbilitata:=False;
    if QSDip.LocDatoStorico(Fine) then
      with TStringList.Create do
      begin
        CommaText:=QSDip.FieldByName('T430AbCausale1').AsString;
        AssenzaAbilitata:=IndexOf(Q265.FieldByName('Codice').AsString) >= 0;
        Free;
      end;
  end;
  if not AssenzaAbilitata then
    exit;

  Result:=True;
end;

function TR600DtM1.SettaPeriodoCumulo(Prog:LongInt; Data:TDateTime; Giustif:TGiustificativo):Boolean;
{Come SettaConteggi, ma calcola solo il periodo di cumulo}
var VisualizzaAnomalie_Originale:Boolean;
begin
  Result:=False;
  VisualizzaAnomalie_Originale:=VisualizzaAnomalie;
  VisualizzaAnomalie:=False;
  try
    if not InizializzaSettaConteggi(Prog,Data,Data,Giustif) then
      exit;
    if PeriodoDiCumulo(Data) <> mrOk then
      exit;
    Result:=True;
  finally
    VisualizzaAnomalie:=VisualizzaAnomalie_Originale;
  end;
end;

function TR600DtM1.SettaConteggi(Prog:LongInt; Inizio,Fine:TDateTime; Giustif:TGiustificativo):TModalResult;
{Imposto il progressivo e le date di riferimento e calcolo il cumulo}
var i:Integer;
    TR:Real;
  procedure AzzeramentiIniziali;
  var xx:Integer;
  begin
    Result:=mrOk;
    AnomaliaAssenze:=0;
    (*ValorizzazioneOraria:=True;*)
    for xx:=Low(CompetenzeLette) to High(CompetenzeLette) do CompetenzeLette[xx]:='';
    for xx:=Low(Residui) to High(Residui) do Residui[xx]:='';
    for xx:=Low(ResiduiVal) to High(ResiduiVal) do ResiduiVal[xx]:=0;
    for xx:=Low(Competenze) to High(Competenze) do Competenze[xx]:=0;
    for xx:=Low(CompetenzeOri) to High(CompetenzeOri) do CompetenzeOri[xx]:=0;
    for xx:=Low(CompetenzeParziali) to High(CompetenzeParziali) do CompetenzeParziali[xx]:=0;
    SetLength(ProfPartTime,0);
    if (not LetturaRiduzioni) or (LetturaRiduzioni and InizioRiduzioni) then
      SetLength(AssenzeConteggiate,0);
    GiorniTot:=0;
    GiorniUni:=0;
    FruitoAP:=0;
    FruitoAP_Ore:=0;
    FruitoForzatoAC:=0;
    FruitoForzatoAC_Ore:=0;
    OreTot:=0;
    OreUni:=0;
    OreReseDaAssenza:=0;
    FruitoCorrGG:=0;
    FruitoCorrHH:=0;
    FruitoCompPrec:=0;
    FruizCompPrecCumuloT:=0;
    SetLength(RecupCumuloT,0);
    EsisteRiduzione:=False;
    FasceDiRiduzione:=False;
    for xx:=1 to 12 do
    begin
      AssAbbateFerieMM[xx]:=0;
      AssAbbateRateoMM[xx]:=0;
    end;
  end;
begin
  AzzeramentiIniziali;
  if not InizializzaSettaConteggi(Prog,Inizio,Fine,Giustif) then
    exit;

  //Leggo la valenza giornaliera = Monte Ore Settimanale / Num Giorni lavorativi (Da Calendario)
  if ValenzaGiornaliera = 0 then
    with GetCalend do
    begin
      if (GetVariable('Prog') <> Prog) or (GetVariable('D') <> Fine) then
      begin
        SetVariable('Prog',Prog);
        SetVariable('D',Fine);
        Execute;
      end;
      if (VarToStr(GetVariable('L')) = '') and (VarToStr(GetVariable('F')) = '') and (GetVariable('G') = 0) then
        ValenzaGiornaliera:=0
      else
        try
          ValenzaGiornaliera:=R180OreMinutiExt(GetVariable('MONTEORE')) div GetVariable('G');
        except
          ValenzaGiornaliera:=0;
        end;
    end;
  if Giustificativo.Modo in ['I','M','N'] then
  begin
    Giustificativo.AOre:=TimeToStr(Time);
    if Giustificativo.Modo in ['I','M'] then
      //Giustificativo.DaOre:=TimeToStr(Time);
    begin
      if Giustificativo.Modo = 'I' then
        Giustificativo.DaOre:=TimeToStr(Time)
      else if Giustificativo.Modo = 'M' then
        if Trim(Giustificativo.DaOre) = '.' then
          Giustificativo.DaOre:=TimeToStr(StrToTime('00.00'))
        else
          Giustificativo.DaOre:=TimeToStr(StrToTimeDef(Giustificativo.DaOre,0));
    end;
  end;
  //Trasformo le ore nel formato hh.nn.ss
  if Giustificativo.Modo in ['D','N'] then
  begin
    Giustificativo.DaOre:=TimeToStr(StrToTimeDef(Giustificativo.DaOre,0));
    if Giustificativo.Modo = 'D' then
      Giustificativo.AOre:=TimeToStr(StrToTimeDef(Giustificativo.AOre,0));
  end;
  VariazioneCompetenze:='0';
  VariazioneCompetenzeF:=0;
  LimiteResiduo:=StrToDate(DataFine);
  InizioFruizForzataAC:=StrToDate(DataFine);
  //if (Inizio <> DaData) or (Fine <> AData) then
  begin
    DaData:=Inizio;
    AData:=Fine;
    if InizioConteggi <= 0 then
      InizioConteggi:=Inizio - 2;
    if FineConteggi <= 0 then
      FineConteggi:=Fine + 2;
    if (Inizio - 2) < InizioConteggi then
      InizioConteggi:=Inizio - 2;
    if (Fine + 2) > FineConteggi then
      FineConteggi:=Fine + 2;
  end;
  //Gestisco il periodo di fruizione
  if (*(not LetturaAssenze) and*) (Q265.FieldByName('Fruizione').AsString = 'S') then
  begin
    PeriodoFruizione;
    EsisteFruizione:=True;
  end
  else
    EsisteFruizione:=False;
  //Calcolo competenze
  CompetenzeAnnoSolare:=False;
  if CalcolaCompetenzeDelPeriodo then
  begin
    GetCompetenzeDelPeriodo(Inizio,Fine);
    AzzeramentiIniziali;
  end;
  CercaCompetenze;
  if not AssenzaAbilitata then
    exit;
  Result:=CumuloAssenze;
  if Result = mrOk then
    if EsisteCumulo then
    begin
      if EsisteMaxFasce then
      begin
        SottraiCompetenze(Competenze,GiorniTot,OreTot,Date,False);  //La data non è significativa
        //Arrotondameno personalizzato con ARROT_COMPETENZE???
        //Eliminazione dei residui anno precedente non fruiti da Competenze, CompetenzeOri e ResiduiVal
        if FineResiduo then
        begin
          TR:=0;
          for i:=1 to 6 do
            TR:=TR + ResiduiVal[i];
          TR:=TR - FruitoAP;
          SottraiCompetenze(Competenze,TR,Trunc(TR),Date,False);
          SottraiCompetenze(CompetenzeOri,TR,Trunc(TR),Date,False);
          SottraiCompetenze(ResiduiVal,TR,Trunc(TR),Date,False);
        end;
      end;
      if EsisteMaxUnitario then
        SottraiMaxUnitario(MaxUnitario,GiorniUni,OreUni,Date,False);  //La data non è significativa
    end;
  (*ValorizzazioneOraria:=False;*)
  GiustifPrec:=Giustif;
end;

procedure TR600DtM1.GetCompetenzeDelPeriodo(Inizio,Fine:TDateTime);
{Competenze proporzionate al periodo Inizio/Fine: si simula un periodo di servizio fittizio in RapportoCorrente}
var i:Integer;
    RapportoCorrenteOriginale:TRapportoCorrente;
begin
  CompetenzeDelPeriodo:=0;
  //Salvataggio impostazioni originali
  RapportoCorrenteOriginale.Esiste:=RapportoCorrente.Esiste;
  SetLength(RapportoCorrenteOriginale.Rapporto,Length(RapportoCorrente.Rapporto));
  for i:=0 to High(RapportoCorrenteOriginale.Rapporto) do
    RapportoCorrenteOriginale.Rapporto[i]:=RapportoCorrente.Rapporto[i];
  //Impostazione periodo di servizio 'finto' e calcolo delle competenze
  RapportoCorrente.Esiste:=True;
  RapportoCorrente.CompetenzeDelPeriodo:=True;
  if QSDip.LocDatoStorico(Fine) then
  begin
    Inizio:=R180InizioMese(Inizio); //Porto la data di inizio periodo sempre all'inizio mese
    Fine:=R180FineMese(Fine); //Porto la data di fine periodo sempre alla fine del mese
    RapportoCorrente.Rapporto[0].Inizio:=Max(Inizio,QSDip.FieldByName('T430INIZIO').AsDateTime);
    RapportoCorrente.Rapporto[0].Fine:=Min(Fine,QSDip.FieldByName('T430FINE').AsDateTime);
    if QSDip.FieldByName('T430FINE').IsNull then
      RapportoCorrente.Rapporto[0].Fine:=Fine;
    CercaCompetenze;
    for i:=1 to 6 do
      CompetenzeDelPeriodo:=CompetenzeDelPeriodo + Competenze[i];
  end;
  //Ripristino impostazioni originali
  RapportoCorrente.Esiste:=RapportoCorrenteOriginale.Esiste;
  RapportoCorrente.CompetenzeDelPeriodo:=False;
  SetLength(RapportoCorrente.Rapporto,Length(RapportoCorrenteOriginale.Rapporto));
  for i:=0 to High(RapportoCorrente.Rapporto) do
    RapportoCorrente.Rapporto[i]:=RapportoCorrenteOriginale.Rapporto[i];
end;

procedure TR600DtM1.SettaProgressivo;
{Imposto il parametro progressivo a tutte le query che lo necessitano}
begin
  Q100.Close;
  Q100.SetVariable('Progressivo',Progressivo);
  RiposiEsistenti.Close;
  RiposiEsistenti.SetVariable('Progressivo',Progressivo);
  GiustifDaOre.Close;
  GiustifDaOre.SetVariable('Progressivo',Progressivo);
  NumRiposi.Close;
  NumRiposi.SetVariable('Progressivo',Progressivo);
  CausFruizione.Close;
  CausFruizione.SetVariable('Progressivo',Progressivo);
  NonMaturaferie.Close;
  NonMaturaferie.SetVariable('Progressivo',Progressivo);
  Q040.Close;
  Q040.SetVariable('Progressivo',Progressivo);
  Q080.Close;
  Q080.SetVariable('Progressivo',Progressivo);
  Q263.Close;
  Q263.SetVariable('Progressivo',Progressivo);
  Q264.Close;
  Q264.SetVariable('Progressivo',Progressivo);
  Q430.Close;
  Q430.SetVariable('Progressivo',Progressivo);
  selT131.Close;
  selT131.SetVariable('Progressivo',Progressivo);
  selPartTime.Close;
  selPartTime.SetVariable('Progressivo',Progressivo);
  // cumulo coniuge new.ini
  //selConiugeOld.Close;
  //selConiugeOld.SetVariable('Progressivo',Progressivo);
  selConiuge.ClearVariables;
  selConiuge.SetVariable('Progressivo',Progressivo);
  // cumulo coniuge new.fine
  ScrBancaOreResidua.SetVariable('Progressivo',Progressivo);
  selV010.Close;
  selV010.SetVariable('Progressivo',Progressivo);
  Q130.Close;
  Q130.SetVariable('Progressivo',Progressivo);
end;

//-------------------------------------------------------------------------------
//----------- C A L C O L O   P E R I O D O   F R U I Z I O N E -----------------
//-------------------------------------------------------------------------------
procedure TR600DtM1.PeriodoFruizione;
{Calcolo periodo di fruizione}
var A,M,G:Word;
    D,OffSet:Integer;
    PeriodoInesistente:Boolean;
    UM:Char;
  procedure ChiediDataRiferimento;
  begin
    //Leggo la causale di fruizione specificata
    with CausFruizione do
    begin
      FruizDa:=Date;
      Close;
      SetVariable('Data',DaData);
      SetVariable('Causale',Q265.FieldByName('CodCauFruizione').AsString);
      SetVariable('DataNas',Null);
      if R180CarattereDef(Q265.FieldByName('Cumulo_Familiari').AsString,1,'N') in ['S','D'] then
        SetVariable('DataNas',RiferimentoDataNascita.Data);
      Open;
      DFruizione.DataSet:=CausFruizione;
    end;
    FruizDa:=DFruizione.DataSet.FieldByName('Data').AsDateTime;
    if DFruizione.DataSet.RecordCount = 0 then
    begin
      FruizDa:=Date;
      FruizA:=Date - 1;
      PeriodoInesistente:=True;
      exit;
    end;
    if DFruizione.DataSet.RecordCount > 1 then
    begin
      {$IFNDEF IRISWEB}
      R600FFruiz:=TR600FFruiz.Create(nil);
      with R600FFruiz do
        try
          DbGrid1.DataSource:=DFruizione;
          LNome.Caption:='Matricola:' + Matricola + ' Nome:' + Nome;
          Causale.Caption:=Causale.Caption + Q265.FieldByName('Codice').AsString;
          if R180CarattereDef(Q265.FieldByName('Fruizione_Familiari').AsString,1,'N') in ['S','D'] then
            Riferimento.Caption:=''
          else
            Riferimento.Caption:=Riferimento.Caption + Q265.FieldByName('CodCauFruizione').AsString;
          ShowModal;
          FruizDa:=DFruizione.DataSet.FieldByName('Data').AsDateTime;
        finally
          Release;
        end;
      {$ENDIF}
    end;
    RiferimentoDataNascita.Data:=FruizDa;
  end;
  procedure LeggiCausaleRiferimento;
  begin
    //Leggo la causale di fruizione specificata solo se ne esiste una sola
    with CausFruizione do
    begin
      Close;
      SetVariable('Data',DaData);
      SetVariable('Causale',Q265.FieldByName('CodCauFruizione').AsString);
      Open;
      if RecordCount = 1 then
        FruizDa:=FieldByName('Data').AsDateTime
      else
      begin
        FruizDa:=Date;
        FruizA:=Date - 1;
        PeriodoInesistente:=True;
      end;
      Close;
    end;
  end;
begin
  PeriodoInesistente:=False;
  FruizDa:=Date;
  if Q265.FieldByName('Fruizione_Familiari').AsString = 'N' then
  begin
    //Richiesta interattiva della data di riferimento
    if (not LetturaAssenze) and VisualizzaAnomalie then
      ChiediDataRiferimento
    else
      PeriodoInesistente:=True;
  end
  else if R180CarattereDef(Q265.FieldByName('Fruizione_Familiari').AsString,1,'N') = 'S' then
  begin
    FruizDa:=RiferimentoDataNascita.Data
  end
  else if R180CarattereDef(Q265.FieldByName('Fruizione_Familiari').AsString,1,'N') = 'D' then
  begin
    R180SetVariable(selSG101DataNas,'PROGRESSIVO',Progressivo);
    R180SetVariable(selSG101DataNas,'DATANAS',RiferimentoDataNascita.Data);
    R180SetVariable(selSG101DataNas,'DATA',AData);
    selSG101DataNas.Open;
    if not selSG101DataNas.FieldByName('DATANAS').IsNull then
      FruizDa:=selSG101DataNas.FieldByName('DATANAS').AsDateTime
    else
      FruizDa:=RiferimentoDataNascita.Data;
  end
  else
    LeggiCausaleRiferimento;
  if PeriodoInesistente then
    exit;
  //Calcolo la durata del periodo
  DecodeDate(FruizDa,A,M,G);
  with Q265 do
  begin
    D:=FieldByName('DurataFruizione').AsInteger;
    OffSet:=FieldByName('Offset_Fruizione').AsInteger;
    UM:=R180CarattereDef(FieldByName('UMFruizione').AsString,1,'G');
    case UM of
      'G'://Fruizione in giorni
          begin
          FruizDa:=FruizDa + OffSet;
          FruizA:=FruizDa + D;
          end;
      'M'://Fruizione in mesi
          begin
            FruizDa:=R180AddMesi(FruizDa,Offset);
            FruizA:=R180AddMesi(FruizDa,D);
          end;
      'A'://Fruizione in anni
          begin
            FruizDa:=R180AddMesi(FruizDa,Offset * 12);
            FruizA:=R180AddMesi(FruizDa,D * 12);
          end;
    end;
    if Q265.FieldByName('FRUIZIONE_FAM_GGDOPO').AsString = 'N' then
      FruizA:=FruizA - 1;
  end;
end;
//-------------------------------------------------------------------------
//----------- C A L C O L O   C O M P E T E N Z E -------------------------
//-------------------------------------------------------------------------
procedure TR600DtM1.CercaCompetenze;
{Cerco le competenze su Profili assenze o su Causali}
var
  A,M,G,i:Word;
  PercPT: Real;
begin
  ProfiloAssenze:='';
  DProfiloAssenze:='';
  CompTotali:=0;
  VariazionePeriodiRapporto:=0;
  CompArrotondate:=0;
  CompSoloFerie:=0;
  VariazionePartTime:=0;
  VariazioneAbilitazioneAnagrafica:=0;
  VariazioneCompetenze:='0';
  VariazioneCompetenzeF:=0;
  // AOSTA_REGIONE - commessa 2012/152.ini
  VariazioneFruizMMInteri:=0;
  VariazioneMaxIndividuale:=0;
  VariazioneFruizMMContinuativi:=0;
  VariazioneGGNoLavVuoti:=0;
  // AOSTA_REGIONE - commessa 2012/152.fine
  VariazioneFestePartic:=0;
  //Leggo il tipo di cumulo
  TipoCumulo:=R180CarattereDef(Q265.FieldByName('TipoCumulo').AsString,1,'H');
  //Alberto 12/02/2019: se si sta leggendo il riepilogo per un periodo a cavallo di anno, per tipo cumulo = T si considerano i residui dell'anno di fine periodo altrimenti c'è incoerenza con il calcolo del fruito che si basa sempre sul fine periodo.
  if (TipoCumulo = 'T') and (LetturaAssenze) then
    DecodeDate(AData,A,M,G)
  else
    DecodeDate(DaData,A,M,G);
  EsisteResiduo:=False;
  FineResiduo:=False;
  TotResiduo:=0;
  CodIntQ260:=Q265.FieldByName('CodInterno').AsString;
  //Leggo i residui se raggruppamento residuabile
  if Q265.FieldByName('Residuabile').AsString = 'S' then
  begin
    if not((RapportoCorrente.Esiste) and (RapportoCorrente.Rapporto[0].Inizio > EncodeDate(A - 1,12,31))) then
    begin
      with Q264 do
      begin
        //Alberto 20/06/2006: leggo i residui solo se sono cambiati i dati
        if (StrToIntDef(VarToStr(GetVariable('Anno')),0) <> A) or
           (VarToStr(GetVariable('CodRaggr')) <> Q265.FieldByName('CodRaggr').AsString) then
        begin
          Close;
          SetVariable('Anno',A);
          SetVariable('CodRaggr',Q265.FieldByName('CodRaggr').AsString);
        end;
        Open;
        if RecordCount > 0 then
        begin
          for i:=0 to 5 do
          begin
            Residui[i + 1]:=Fields[i].AsString;
            if not Fields[i].IsNull then
              EsisteResiduo:=True;
          end;
        end;
      end;
    end;
  end;
  //Se non devo cumulare non leggo le competenze
  EsisteCumulo:=TipoCumulo <> 'H';
  if not(EsisteCumulo or EsisteResiduo) then
  begin
    //Leggo l'unità di misura da T265_CAUASSENZE
    LeggiCompetenze(0);
    exit;
  end;
  if Q265.FieldByName('ContASolare').AsString = 'S' then
  begin
    CompetenzeAnnoSolare:=True;
    CercaProfiloAssenze(A,True);
  end
  else
  //Lettura competenze da Causale Assenze
  begin
    LeggiCompetenze(0);
    ValorizzaCompetenze(CompetenzeLette,Competenze,UMisura,False);
    for i:=1 to 6 do
      CompetenzeParziali[i]:=Competenze[i];
  end;
  //Leggo il Max Unitario a seconda dell'unità di misura
  MaxUnitarioOri:=GetMaxUnitario(UMisura);
  MaxUnitario:=MaxunitarioOri;
  EsisteMaxUnitario:=MaxUnitario > 0;
  //Arrotondo i valori delle competenze ottenuti
  //Alberto 14/11/2005 ArrotondaCompetenze(Competenze);
  if EsisteResiduo then
  begin
    //Valorizzo i residui numericamente per la VisualizzazioneAssenze
    ValorizzaCompetenze(Residui,ResiduiVal,UMisura,False);
    //Ricalcolo i residui riportando gli eventuali negativi sulla prima fascia
    for i:=2 to 6 do
      if ResiduiVal[i] < 0 then
      begin
        ResiduiVal[1]:=ResiduiVal[1] + ResiduiVal[i];
        ResiduiVal[i]:=0;
      end;
    //Verifico se applicare proporzionamento residuo competenze per part-time
    if (Q265.FieldByName('Tipo_Proporzione').AsString = 'R') and (Q265.FieldByName('PartTime').AsString <> 'N') then
    //Riporto i residui da part-time a tempo pieno
    begin
      PercPT:=100;
      with selT460a do
      begin
        if (GetVariable('Progressivo') <> Progressivo) or
           (GetVariable('Data') <>  EncodeDate(A,1,1) - 1) then
        begin
          Close;
          SetVariable('Progressivo',Progressivo);
          SetVariable('Data',EncodeDate(A,1,1) - 1);
          Open;
        end;
        //Leggo part-time in vigore al 31/12 dell'anno precedente
        if Pos(FieldByName('Tipo').AsString,Q265.FieldByName('PartTime').AsString) > 0 then
          if (UMisura = 'G') and (not FieldByName('AssenzeGG').IsNull) or
             (UMisura = 'O') and (not FieldByName('AssenzeHH').IsNull) then
          begin
            if UMisura = 'G' then
              PercPT:=FieldByName('AssenzeGG').AsFloat
            else
              PercPT:=FieldByName('AssenzeHH').AsFloat;
          end;
      end;
      //Salvo i residui prima di trasformali a tempo pieno
      ResiduiOri:=ResiduiVal;
      for i:=1 to 6 do
        ResiduiVal[i]:=ResiduiVal[i] * 100 / PercPT;
      ArrotondaCompetenze(ResiduiVal);
      for i:=1 to 6 do
        if UMisura = 'G' then
          Residui[i]:=FloatToStr(ResiduiVal[i])
        else
          Residui[i]:=R180MinutiOre(Trunc(ResiduiVal[i]));
      //Sommo i residui alle competenze
      ValorizzaCompetenze(Residui,Competenze,UMisura,True);
      //Riporto i residui originali di fine anno
      ResiduiVal:=ResiduiOri;
      ArrotondaCompetenze(ResiduiVal);
      for i:=1 to 6 do
        if UMisura = 'G' then
          Residui[i]:=FloatToStr(ResiduiVal[i])
        else
          Residui[i]:=R180MinutiOre(Trunc(ResiduiVal[i]));
    end
    else
    begin
      ArrotondaCompetenze(ResiduiVal); //Alberto 13/07/2004
      for i:=1 to 6 do
        if UMisura = 'G' then
          Residui[i]:=FloatToStr(ResiduiVal[i])
        else
          Residui[i]:=R180MinutiOre(Trunc(ResiduiVal[i]));
      //Sommo i residui alle competenze
      ValorizzaCompetenze(Residui,Competenze,UMisura,True);
    end;
    for i:=1 to 6 do
      TotResiduo:=TotResiduo + ResiduiVal[i];
  end;
  //Salvo le competenze in CompetenzeOri
  TrasferisciCompetenze(Competenze,CompetenzeOri,False);
  EsisteMaxFasce:=True;//EsistonoCompetenzeFasce; Considero sempre le competenze anche quando sono a 0
end;

function TR600DtM1.GetTotaleResidui:Real;
var i:Integer;
begin
  Result:=0;
  for i:=1 to 6 do
  try
    if UMisura = 'O' then
      Result:=Result + R180OreMinutiExt(Residui[i])
    else
      Result:=Result + StrToFloat(Residui[i]);
  except
  end;
end;

procedure TR600DtM1.CercaProfiloAssenze(A:Integer; CercaCompetenze:Boolean);
{Cerco le competenze sul profilo individuale o sul profilo in anagrafico}
var PA:String;
    ProfInd:Boolean;
    i:Integer;
begin
  CompTotali:=0;
  CompArrotondate:=0;
  CompSoloFerie:=0;
  //Leggo profilo assenze individuale
  R180SetVariable(Q263,'InInizio',EncodeDate(A,1,1));
  R180SetVariable(Q263,'InFine',EncodeDate(A,12,31));
  R180SetVariable(Q263,'CodRaggr',Q265.FieldByName('CodRaggr').AsString);
  with Q263 do
  begin
    Open;
    //if not FieldByName('Decurtazione').IsNull then
    //  VariazioneCompetenze:=FieldByName('Decurtazione').AsString;
    if EsisteResiduo and CercaCompetenze then
    begin
      UMisura:=FieldByName('UMisura').AsString;
      if (not FieldByName('DATARES').IsNull) and (GetTotaleResidui > 0) then
        LimiteResiduo:=FieldByName('DATARES').AsDateTime;
      //if DaData > LimiteResiduo then
      if AData > LimiteResiduo then
        FineResiduo:=True;
      InizioFruizForzataAC:=EncodeDate(R180Anno(AData),12,31);  //Alberto: i profili individuali non gestiscono la fruizione minima nè la decorrenza
    end;
    ProfInd:=not FieldByName('Competenza1').IsNull;
    if ProfInd then
    //Lettura competenze da Profili Assenze Individuali
    begin
      LeggiCompetenze(1);
      if CercaCompetenze then
      begin
        ValorizzaCompetenze(CompetenzeLette,Competenze,UMisura,False);
        for i:=1 to High(Competenze) do
        begin
          //Se calcolo delle competenze periodiche, non si considera il profilo individuale
          if RapportoCorrente.CompetenzeDelPeriodo then
            Competenze[i]:=0;
          CompTotali:=CompTotali + Competenze[i];
          CompetenzeParziali[i]:=0//Competenze[i];
        end;
        ProfiloAssenze:='Individuale';
      end;
    end
    else
    begin
      //Ricerca del primo profilo assenze valido nel periodo richiesto
      PA:='';
      QSDip.First;
      while not QSDip.Eof do
      begin
        if ((QSDip.FieldByName('T430DATADECORRENZA').AsDateTime <= AData) and
            (QSDip.FieldByName('T430DATAFINE').AsDateTime >= DaData)) and
           (not QSDip.FieldByName('T430PASSENZE').IsNull) then
        begin
          PA:=QSDip.FieldByName('T430PASSENZE').AsString;
          Break;
        end;
        QSDip.Next;
      end;
      if PA <> '' then
        with Q262B do
        begin
          PA:=QSDip.FieldByName('T430PASSENZE').AsString;
          //Alberto 20/06/2006: leggo il profilo solo se sono cambiati i dati
          if (StrToIntDef(VarToStr(GetVariable('Anno')),0) <> A) or
             (VarToStr(GetVariable('CodRaggr')) <> Q265.FieldByName('CodRaggr').AsString) or
             (VarToStr(GetVariable('CodProfilo')) <> PA) then
          begin
            Close;
            SetVariable('CodProfilo',PA);
            SetVariable('CodRaggr',Q265.FieldByName('CodRaggr').AsString);
            SetVariable('Anno',A);
          end;
          Open;
          if RecordCount > 0 then
          begin
            ProfiloAssenze:=PA;
            DProfiloAssenze:=FieldByName('DESCRIZIONE').AsString;
            UMisura:=FieldByName('UMisura').AsString;
            ArrotMG:=FieldByName('MG').AsString;
            ArrotFav:=FieldByName('ARRFAV').AsString;
            ArrotOre:=FieldByName('ARR_COMPETENZA_IN_ORE').AsString;
            if EsisteResiduo and CercaCompetenze then
            begin
              if (not FieldByName('DATARES').IsNull) and (LimiteResiduo = StrToDate(DataFine)) and (GetTotaleResidui > 0) then
                LimiteResiduo:=FieldByName('DATARES').AsDateTime;
              //if DaData > LimiteResiduo then
              if AData > LimiteResiduo then
                FineResiduo:=True;
              if (not FieldByName('FRUIZ_MINIMA_DAL').IsNull) and (not FieldByName('FRUIZ_ANNO_MINIMA').IsNull) then
                InizioFruizForzataAC:=EncodeDate(A,R180mese(FieldByName('FRUIZ_MINIMA_DAL').AsDateTime),R180Giorno(FieldByName('FRUIZ_MINIMA_DAL').AsDateTime))
              else
                InizioFruizForzataAC:=EncodeDate(A,1,1);
            end;
          end
          else
            AssenzaAbilitata:=False;
          Close;
        end;
      if AssenzaAbilitata and CercaCompetenze then
      //Leggo profilo assenze da anagrafico
      begin
        if LetturaAssenze then
          CompetenzeProporzionate(A,True);  //Competenze parziali alla data di fine cumulo
        CompetenzeProporzionate(A,False);   //Competenze intere di tutto l'anno
      end;
    end;
  end;
  //Gestione della variazione manuale alle competenze: è possibile incrementare o decrementare le competenze
  //Alberto 01/10/2005: spostata in PeriodoDiCumulo dopo la proporzione per PartTime
  //VariazioneManualeCompetenze;
end;

procedure TR600DtM1.VariazioneManualeCompetenze;
{Abbattimento delle competenze con la variazione manuale indicata sul profilo individuale}
var R:Real;
    i:Integer;
begin
  //Alberto - 02/08/2011: Lettura profili individuali anche per Assenze senza profilo, per considerare eventuali variazioni
  //if not CompetenzeAnnoSolare then
  begin
    R180SetVariable(Q263,'ININIZIO',InizioCumulo);
    R180SetVariable(Q263,'INFINE',FineCumulo);
    R180SetVariable(Q263,'CodRaggr',Q265.FieldByName('CodRaggr').AsString);
    Q263.Open;
    if not Q263.FieldByName('Decurtazione').IsNull then
      VariazioneCompetenze:=Q263.FieldByName('Decurtazione').AsString;
  end;

  if UMisura = 'G' then
    VariazioneCompetenzeF:=StrToFloat(VariazioneCompetenze)
  else
    VariazioneCompetenzeF:=R180OreMinutiExt(VariazioneCompetenze);
  R:=VariazioneCompetenzeF;
  //Se calcolo delle competenze periodiche, non si considera la variazione manuale
  if RapportoCorrente.CompetenzeDelPeriodo then
    R:=0;
  if R < 0 then
  begin
    R:= -R;
    for i:=High(Competenze) downto 1 do
      if R > Competenze[i] then
      begin
        R:=R - Competenze[i];
        Competenze[i]:=0
      end
      else
      begin
        Competenze[i]:=Competenze[i] - R;
        R:=0;
      end;
    if R > 0 then
      Competenze[High(Competenze)]:= -R;
  end
  else
    Competenze[1]:=Competenze[1] + R;
end;

procedure TR600DtM1.ArrotondaCompetenze(var Vettore: array of Real);
{Arrotondo il contenuto del vettore Competenze a seconda se UMisura in Giorni o Ore}
var i:Byte;
begin
  for i:=0 to High(Vettore) do
    if UMisura = 'G' then
      //Arrotondo il valore alla mezza giornata (.5)
      Vettore[i]:=ArrotondaGiorno(Vettore[i])
    else
      //Arrotondo il valore in base ai minuti di arrotondamento
      Vettore[i]:=ArrotondaOre(Vettore[i]);
  //Arrotondo Fruizione Minima Anno Corrente         //Lorena 29/12/2005
  if FruizMinimaAC > 0 then
    if UMisura = 'G' then
      //Arrotondo il valore alla mezza giornata (.5)
      FruizMinimaAC:=ArrotondaGiorno(FruizMinimaAC)
    else
      //Arrotondo il valore in base ai minuti di arrotondamento
      FruizMinimaAC:=ArrotondaOre(FruizMinimaAC);
end;

function TR600DtM1.ArrotondaGiorno(R:Real; ApplicaArrotMG:Boolean=True):Real;
var L:LongInt;
begin
  //Arrotondamento a giornate (solo se LetturaAssenze è True)
  if (*LetturaAssenze*)ApplicaArrotMG and (ArrotMG = 'N') then
  begin
    if ArrotFav = 'F' then
      Result:=R180Arrotonda(R,1,'P-')
    else if ArrotFav = 'P' then
      Result:=R180Arrotonda(R,1,'P')
    else if ArrotFav = 'S' then
      Result:=Trunc(R) //Sfavorevole
    else
      Result:=R;
    exit;
  end;
  //Arrotondamento a mezze giornate
  L:=Trunc(R);
  R:=R - L;
  if (ArrotFav = 'F') or (ArrotFav = 'P') then
  begin
    //Favorevole
    if Abs(R) < 0.25 then
      Result:=L
    else
      if Abs(R) < 0.75 then
        Result:=L + 0.5 * (R/Abs(R))
      else
        Result:=L + 1 * (R/Abs(R));
  end
  else
    //Sfavorevole
    if Abs(R) < 0.5 then
      Result:=L
    else
      Result:=L + 0.5 * (R/Abs(R));
end;

function TR600DtM1.ArrotondaOre(R:Real):Real;
var c: Currency;
begin
  c:=R;  //Trasformo in Currency per precisione nel troncamento
  //Arrotondamento non previsto
  if R180OreMinutiExt(ArrotOre) = 0 then
  begin
    Result:=Trunc(c);
    exit;
  end;
  //Se arrotondamento favorevole e i minuti sono >= della metà dell'arrotondamento ore si porta al limite superiore
  if ((ArrotFav = 'F') or (ArrotFav = 'P')) and ((c - Trunc(c/R180OreMinutiExt(ArrotOre))*R180OreMinutiExt(ArrotOre)) >= (R180OreMinutiExt(ArrotOre)/2)) then
    Result:=(Trunc(c/R180OreMinutiExt(ArrotOre))*R180OreMinutiExt(ArrotOre)) + R180OreMinutiExt(ArrotOre)
  else
    Result:=Trunc(c/R180OreMinutiExt(ArrotOre))*R180OreMinutiExt(ArrotOre);
end;

procedure TR600DtM1.LeggiCompetenze(Source:Byte);
{Leggo le competenze dalla Query specificata da Source}
var DataSet:TOracleDataSet;
    xx:Integer;
begin
  DataSet:=nil;
  case Source of
    0:DataSet:=Q265;
    1:DataSet:=Q263;
    2:DataSet:=Q262;
  end;
  if TipoCumulo in ['H','N','P','Q'] then
  //Competenze calcolate da routine apposite e non lette dalla tabella
  begin
    for xx:=Low(CompetenzeLette) to High(CompetenzeLette) do
    begin
      CompetenzeLette[xx]:='';
      Competenze[xx]:=0;
      CompetenzeOri[xx]:=0;
      CompetenzeParziali[xx]:=0;
    end;
    UMisura:=DataSet.FieldByName('UMisura').AsString;
    exit;
  end;
  with DataSet do
  begin
    UMisura:=FieldByName('UMisura').AsString;
    if (Source <> 1) and (FieldByName('COMPETENZE_PERSONALIZZATE').AsString = 'S')  then
    begin
      try
        T265P_GETCOMPETENZE.SetVariable('PROGRESSIVO',Progressivo);
        T265P_GETCOMPETENZE.SetVariable('DATA',DaData); //?
        if Source = 0 then
          T265P_GETCOMPETENZE.SetVariable('CAUSALE',Q265.FieldByName('CODICE').AsString)
        else
          T265P_GETCOMPETENZE.SetVariable('CAUSALE',Q265.FieldByName('CODRAGGR').AsString);
        // AOSTA_REGIONE - commessa 2012/152.ini
        T265P_GETCOMPETENZE.SetVariable('DATANAS_FAM',RiferimentoDataNascita.Data);
        T265P_GETCOMPETENZE.SetVariable('INIZIO_CUMULO',null); // inizio cumulo non disponibile
        T265P_GETCOMPETENZE.SetVariable('FINE_CUMULO',null);   // fine cumulo non disponibile
        // AOSTA_REGIONE - commessa 2012/152.fine
        T265P_GETCOMPETENZE.Execute;
        for xx:=Low(CompetenzeLette) to High(CompetenzeLette) do
          CompetenzeLette[xx]:=VarToStr(T265P_GETCOMPETENZE.GetVariable('COMP' + IntToStr(xx)));
      except
        on E:Exception do
        begin
          AnomaliaAssenze:=28;
          // ? Result:=Anomalie(2,Format('Badge:%-8s %s %s %-5s %s %s',[Badge,Nome,Chr(13),CausAnomala,Chr(13),Messaggi[28],E.Message]));
          exit;
        end;
      end;
    end
    else
    begin
      CompetenzeLette[1]:=FieldByName('Competenza1').AsString;
      CompetenzeLette[2]:=FieldByName('Competenza2').AsString;
      CompetenzeLette[3]:=FieldByName('Competenza3').AsString;
      CompetenzeLette[4]:=FieldByName('Competenza4').AsString;
      CompetenzeLette[5]:=FieldByName('Competenza5').AsString;
      CompetenzeLette[6]:=FieldByName('Competenza6').AsString;
    end;
    Riduzioni[1]:=FieldByName('Retribuzione1').AsInteger;
    Riduzioni[2]:=FieldByName('Retribuzione2').AsInteger;
    Riduzioni[3]:=FieldByName('Retribuzione3').AsInteger;
    Riduzioni[4]:=FieldByName('Retribuzione4').AsInteger;
    Riduzioni[5]:=FieldByName('Retribuzione5').AsInteger;
    Riduzioni[6]:=FieldByName('Retribuzione6').AsInteger;
    EsisteRiduzione:=not FieldByName('Retribuzione1').IsNull;
    FasceDiRiduzione:=not FieldByName('Competenza2').IsNull;
  end;
end;

procedure TR600DtM1.ValorizzaCompetenze(Sorg:array of String; var Dest:array of Real; UM:String; Incrementa:Boolean);
{Trasformo i valori in forma stringa letti dalle tabelle in numeri reali
 (Giornate.MezzeGiornate o Minuti a seconda dell'unità di misura}
var i:Byte;
    R:Real;
begin
  for i:=0 to 5 do
  begin
    try
      if Trim(Sorg[i]) = '' then
        R:=0
      else if UM = 'G' then     //Competenze in giorni
        R:=StrToFloat(Sorg[i])  //Converto il dato stringa in Numero
      else                            //Competenze in ore
        R:=R180OreMinutiExt(Sorg[i]); //Converto da ore a minuti
    except
      R:=0;
    end;
    if Incrementa then      //Lo aggiungo o lo assegno direttamente
      Dest[i]:=Dest[i] + R
    else
      Dest[i]:=R;
  end;
end;

procedure TR600DtM1.TrasferisciCompetenze(Sorg:array of Real; var Dest:array of Real; Incrementa:Boolean);
var i:Byte;
begin
 for i:=0 to High(Sorg) do
   if Incrementa then      //Lo aggiungo o lo assegno direttamente
     Dest[i]:=Dest[i] + Sorg[i]
   else
     Dest[i]:=Sorg[i];
end;

function TR600DtM1.EsistonoCompetenzeFasce:Boolean;
{Se tutte le competenze sono a 0 non le controllo --> EsisteMaxFasce = False}
var i:Byte;
begin
  Result:=False;
  for i:=1 to 6 do
   if Competenze[i] > 0 then
   begin
     Result:=True;
     Break;
   end;
end;

function TR600DtM1.GetMaxUnitario(UM:String):Real;
{Restituisce il MaxUnitario in Giornate.MezzeGiornate o Minuti a seconda di UM}
begin
  try
    if Q265.FieldByName('GMaxUnitario').IsNull and Q265.FieldByName('HMaxUnitario').IsNull then
      Result:=0
    else if UM = 'G' then
      Result:=Q265.FieldByName('GMaxUnitario').AsFloat
    else
      Result:=R180OreMinutiExt(Q265.FieldByName('HMaxUnitario').AsString);
  except
    Result:=0;
  end;
end;

//------- GESTIONE COMPETENZE AD ANNO SOLARE SU PROFILI ASSENZE ---------//
procedure TR600DtM1.CompetenzeProporzionate(Anno:Integer; CalcolaCompetenzeParziali:Boolean);
{Leggo tutti i profili assenze dell'anno proporzionando le competenze}
var Anno1,Anno2,D1,D2,CessazionePrec:TDateTime;
    ProfiloDaInserire,InServizio:Boolean;
    i,j,xx:Integer;
    CompetenzeOriginali:array[1..6] of Real;
    PropGGOld,CompPrima,CompDopo,VariazionePartTimeOld:Real;
    procedure InserisciProfilo;
    {Inserisco il profilo assenze e le date di riferimento}
    var i:Integer;
        //UsaInizioServizio:Boolean;
        InizioServizio:TDateTime;
    begin
      inc(NumProfili);
      i:=NumProfili;
      with Q430,ProfAssenze[i] do
      begin
        //ProfAssenze contiene i dati dei profili nei singoli movimenti storici
        Codice:=FieldByName('PAssenze').AsString;
        Assunzione:=FieldByName('Inizio').AsDateTime;
        Cessazione:=FieldByName('Fine').AsDateTime;
        Decorr:=FieldByName('DataDecorrenza').AsDateTime;
        Fine:=FieldByName('DataFine').AsDateTime;
        //Lorena 09/05/2006: valorizzazione dato parttime
        PartTime:=100;
        if Trim(FieldByName('PartTime').AsString) <> '' then
        begin
          //Alberto 20/06/2006: rileggo il part-time solo se è cambiato il codice
          if VarToStr(selT460.GetVariable('COD')) <> FieldByName('PartTime').AsString then
          begin
            selT460.Close;
            selT460.SetVariable('COD',FieldByName('PartTime').AsString);
          end;
          selT460.Open;
          if Pos(selT460.FieldByName('Tipo').AsString,Q265.FieldByName('PartTime').AsString) > 0 then
          begin
            if UMisura = 'G' then
              PartTime:=selT460.FieldByName('AssenzeGG').AsFloat
            else
              PartTime:=selT460.FieldByName('AssenzeHH').AsFloat;
          end;
        end;
        ValidoDal:=Decorr;
        ValidoAl:=Fine;
        if ValidoDal < Anno1 then
          ValidoDal:=Anno1;
        if ValidoAl > Anno2 then
          ValidoAl:=Anno2;
        if RapportoCorrente.Esiste then
        begin
          if ValidoDal < RapportoCorrente.Rapporto[0].Inizio then
            ValidoDal:=RapportoCorrente.Rapporto[0].Inizio;
          if ValidoAl > RapportoCorrente.Rapporto[0].Fine then
            ValidoAl:=RapportoCorrente.Rapporto[0].Fine;
        end
        else
        begin
          if ValidoDal < FieldByName('Inizio').AsDateTime then
            ValidoDal:=FieldByName('Inizio').AsDateTime;
          if (ValidoAl > FieldByName('Fine').AsDateTime) and (not FieldByName('Fine').IsNull) then
            ValidoAl:=FieldByName('Fine').AsDateTime;
        end;
        //Gestione della data di inizio servizio su T030 per
        //ferie e festività soppresse
        if ((CodIntQ260 = 'A') or (CodIntQ260 = 'B')) and
           (not QAnagra.FieldByName('MIN_INIZIO').IsNull) and (not QAnagra.FieldByName('InizioServizio').IsNull) and
           (Assunzione = QAnagra.FieldByName('MIN_INIZIO').AsDateTime) then
        begin
          //da farsi solo sui movimenti riferiti alla prima assunzione dell'anno
          (*Remmato il 31/10/2002 - basta il test precedente su MIN_INIZIO e INIZIOSERVIZIO
            if (QAnagra.FieldByName('InizioServizio').AsDateTime > 0) and
             (QAnagra.FieldByName('InizioServizio').AsDateTime < Assunzione) then*)
          begin
            InizioServizio:=QAnagra.FieldByName('InizioServizio').AsDateTime;
            if InizioServizio < Anno1 then
              InizioServizio:=Anno1;
            Assunzione:=InizioServizio;
            //Sul primo periodo, imposto ValidoDal a InizioServizio per le competenze mensili
            if i = 1 then
              ValidoDal:=InizioServizio;
            (*UsaInizioServizio:=i = 1;
            //Sul primo periodo, imposto ValidoDal a InizioServizio per le competenze mensili
            if UsaInizioServizio and (InizioServizio < ValidoDal) then
              ValidoDal:=InizioServizio;
            if not UsaInizioServizio then
              UsaInizioServizio:=(ProfAssenze[i - 1].Assunzione = InizioServizio) and
                                 (ProfAssenze[i - 1].Cessazione = Cessazione);
            if UsaInizioServizio then
              Assunzione:=InizioServizio;*)
          end;
        end;
        if RapportoCorrente.CompetenzeDelPeriodo then
        begin
          //FLUPER: Competenze ferie del mese
          if Assunzione < RapportoCorrente.Rapporto[0].Inizio then
            Assunzione:=RapportoCorrente.Rapporto[0].Inizio;
          if (Cessazione > RapportoCorrente.Rapporto[0].Fine) or (Cessazione = 0) then
            Cessazione:=RapportoCorrente.Rapporto[0].Fine;
          //Alberto 02/12/2011: correggo ValidoDal nel caso sia stato anticipato da InizioServizio: in questo caso non lo deve essere
          if ValidoDal < RapportoCorrente.Rapporto[0].Inizio then
            ValidoDal:=RapportoCorrente.Rapporto[0].Inizio;
        end;
        //Calcolo le date di Inizio/Fine storicizzazione in modo che
        //siano comprese nelle date di Assunzione/Cessazione e nell'anno in
        //considerazione
        if (i = 1) and (Assunzione < Decorr) then
          D1:=Assunzione
        else if Assunzione > Decorr then
          D1:=Assunzione
        else
          D1:=Decorr;
        if (Cessazione > 0) and (Cessazione < Fine) then
          D2:=Cessazione
        else
          D2:=Fine;
        if D1 < Anno1 then
          D1:=Anno1;
        if D2 > Anno2 then
          D2:=Anno2;
        Giorni:=Trunc(D2 - D1) + 1;
        //Gestione anomalia nella storicizzazione
        if Giorni < 0 then Giorni:=0;
      end;
    end;
begin
  //Leggo tutti i movimenti storici dell'anno
  NumProfili:=0;
  ProfiliSingoli:=0;
  for xx:=Low(ProfAssenze) to High(ProfAssenze) do
  begin
    ProfAssenze[xx].Assunzione:=0;
    ProfAssenze[xx].Cessazione:=0;
    ProfAssenze[xx].Codice:='';
    ProfAssenze[xx].Decorr:=0;
    ProfAssenze[xx].Fine:=0;
    ProfAssenze[xx].Giorni:=0;
    ProfAssenze[xx].Minimo:=0;
    ProfAssenze[xx].SommaAssCess:='';
    ProfAssenze[xx].TipoProporzione:='';
    ProfAssenze[xx].PropCompGGMMRA:='';
    ProfAssenze[xx].FormulaProporzione:='';
    ProfAssenze[xx].ValidoAl:=0;
    ProfAssenze[xx].ValidoDal:=0;
    ProfAssenze[xx].VariazAssCess:=0;
    ProfAssenze[xx].PartTime:=0;
  end;
  for xx:=Low(CodProfili) to High(CodProfili) do
  begin
    CodProfili[xx]:='';
    GgProfili[xx].Competenza:=0;
    GgProfili[xx].CompetenzaLorda:=0;
    MmProfili[xx].Competenza:=0;
    MmProfili[xx].CompetenzaLorda:=0;
  end;
  for xx:=Low(Competenze) to High(Competenze) do Competenze[xx]:=0;
  with Q430 do
  begin
    Anno1:=EncodeDate(Anno,1,1);
    if CalcolaCompetenzeParziali then
      Anno2:=AData
    else
      Anno2:=EncodeDate(Anno,12,31);
    //Alberto 20/06/2006: rileggo l'anagrafico solo se sono cambiati i dati
    if (GetVariable('Data1') <> Anno1) or (GetVariable('Data2') <> Anno2) then
    begin
      Close;
      SetVariable('Data1',Anno1);
      SetVariable('Data2',Anno2);
    end;
    Open;
    First;
    //Verifico se la data di riferimento è in un periodo di servizio, altrimenti memorizzo la data di cessazione precedente
    InServizio:=False;
    CessazionePrec:=0;
    if RapportoCorrente.Esiste then
      while not Eof do
      begin
        if (RapportoCorrente.DataCorrente >= FieldByName('Inizio').AsDateTime) and (not FieldByName('Inizio').IsNull) and
           ((RapportoCorrente.DataCorrente <= FieldByName('Fine').AsDateTime) or FieldByName('Fine').IsNull) then
        begin
          InServizio:=True;
          Break;
        end
        else if (RapportoCorrente.DataCorrente > FieldByName('Fine').AsDateTime) and (not FieldByName('Fine').IsNull) then
          CessazionePrec:=Max(CessazionePrec,FieldByName('Fine').AsDateTime);
        Next;
      end;
    First;
    (*Carico i profili assenza dell'anno con i relativi giorni di valenza nell'anno
    Se l'elaborazione è attiva solo sul periodo corrente, inserisco solo i profili
    che ricadono all'interno del periodo di assunzione o che si riferiscono al periodo precedente se cessato nel mese di riferimento*)
    while not Eof do
    begin
      ProfiloDaInserire:=not RapportoCorrente.Esiste;
      if RapportoCorrente.Esiste then
      begin
        //In servizio
        ProfiloDaInserire:=(InServizio) and
                           (RapportoCorrente.DataCorrente >= FieldByName('Inizio').AsDateTime) and
                           (not FieldByName('Inizio').IsNull) and
                           ((RapportoCorrente.DataCorrente <= FieldByName('Fine').AsDateTime) or
                             FieldByName('Fine').IsNull);
        //Cessazione precedente nel mese di riferimento
        if LetturaAssenze and (not ProfiloDaInserire) then
          ProfiloDaInserire:=(not InServizio) and
                             (not FieldByName('Fine').IsNull) and
                             (FieldByName('Fine').AsDateTime = CessazionePrec) and
                             (FormatDateTime('yyyy',FieldByName('Fine').AsDateTime) = FormatDateTime('yyyy',RapportoCorrente.DataCorrente));
      end;
      ProfiloDaInserire:=ProfiloDaInserire and ((FieldByName('DataDecorrenza').AsDateTime <= FieldByName('Fine').AsDateTime) or FieldByName('Fine').IsNull);
      ProfiloDaInserire:=ProfiloDaInserire and (FieldByName('DataFine').AsDateTime >= FieldByName('Inizio').AsDateTime) and (not FieldByName('Inizio').IsNull);
      if ProfiloDaInserire then
      begin
        //Leggo il profilo e le sue caratteristiche di proporzionamento
        InserisciProfilo;
        GetProporzione(Anno2,ProfAssenze[NumProfili].Codice,Giustificativo.Raggruppamento);
        ProfAssenze[NumProfili].TipoProporzione:=Q262c.FieldByName('PROPORZIONE').AsString;
        ProfAssenze[NumProfili].PropCompGGMMRA:=Q262c.FieldByName('PROPGGMM').AsString;
        if Q262c.FindField('FORMULA_PROPORZIONE') <> nil then
          ProfAssenze[NumProfili].FormulaProporzione:=Trim(Q262c.FieldByName('FORMULA_PROPORZIONE').AsString);
        ProfAssenze[NumProfili].SommaAssCess:=Q262c.FieldByName('SOMMA').AsString;
        if Q262c.FieldByName('PROPORZIONE').AsString = '0' then
          ProfAssenze[NumProfili].Minimo:=-99
        else if Q262c.FieldByName('PROPORZIONE').AsString = '1' then
          ProfAssenze[NumProfili].Minimo:=ArrotFerie
        else if Q262c.FieldByName('PROPORZIONE').AsString = '2' then
          ProfAssenze[NumProfili].Minimo:=ArrotFerie - 1
        else if Q262c.FieldByName('PROPORZIONE').AsString = '3' then
          ProfAssenze[NumProfili].Minimo:=ArrotFerie - 1;
      end;
      Next;
    end;
    Close;
  end;
  //Compatto i periodi storici riferiti allo stesso profilo
  i:=2;
  while i <= NumProfili do
  begin
    //stesso profilo e stessa assunzione/cessazione
    if (ProfAssenze[i].Codice = ProfAssenze[i - 1].Codice) and
       (ProfAssenze[i].Assunzione = ProfAssenze[i - 1].Assunzione) and
       (ProfAssenze[i].PartTime = ProfAssenze[i - 1].PartTime) then  //Lorena 09/05/2006
    begin
      inc(ProfAssenze[i - 1].Giorni,ProfAssenze[i].Giorni);
      ProfAssenze[i - 1].Fine:=ProfAssenze[i].Fine;
      ProfAssenze[i - 1].ValidoAl:=ProfAssenze[i].ValidoAl;
      for j:=i to NumProfili - 1 do
        ProfAssenze[j]:=ProfAssenze[j + 1];
      dec(NumProfili);
    end
    //stesso profilo, assunzione consecutiva alla cessazione, periodi lavorativi unificati
    else if (ProfAssenze[i].Codice = ProfAssenze[i - 1].Codice) and
            (ProfAssenze[i].Assunzione - 1 = ProfAssenze[i - 1].Cessazione) and
            (ProfAssenze[i].PartTime = ProfAssenze[i - 1].PartTime) and  //Lorena 09/05/2006
            not RapportoCorrente.Esiste then
    begin
      inc(ProfAssenze[i - 1].Giorni,ProfAssenze[i].Giorni);
      ProfAssenze[i - 1].Fine:=ProfAssenze[i].Fine;
      ProfAssenze[i - 1].ValidoAl:=ProfAssenze[i].ValidoAl;
      ProfAssenze[i - 1].Cessazione:=ProfAssenze[i].Cessazione;
      for j:=i to NumProfili - 1 do
        ProfAssenze[j]:=ProfAssenze[j + 1];
      dec(NumProfili);
    end
    else
      inc(i);
  end;
  //Calcolo competenze totali senza decurtazioni
  TrasferisciCompetenze(Competenze,CompetenzeOriginali,False);
  RaggruppaProfili;
  CompTotali:=CalcolaCompetenze(Anno);
  //Gestisco l'arrotondamento su Assunzione/Cessazione
  ArrotondamentoAssunzCessaz(Anno1,Anno2);
  //Calcolo competenze dopo l'arrotondamento: CompArrotondate contiene la differenza
  for xx:=Low(CodProfili) to High(CodProfili) do
  begin
    CodProfili[xx]:='';
    GgProfili[xx].Competenza:=0;
    GgProfili[xx].CompetenzaLorda:=0;
    MmProfili[xx].Competenza:=0;
    MmProfili[xx].CompetenzaLorda:=0;
  end;
  ProfiliSingoli:=0;
  TrasferisciCompetenze(CompetenzeOriginali,Competenze,False);
  RaggruppaProfili;
  CompArrotondate:=CompTotali - CalcolaCompetenze(Anno);
  if CodIntQ260 = 'A' then
  begin
    VariazionePartTimeOld:=VariazionePartTime;
    TogliMaturazFerie(Anno1,Anno2);
  end;
  //Calcolo competenze effettive
  for xx:=Low(CodProfili) to High(CodProfili) do
  begin
    CodProfili[xx]:='';
    GgProfili[xx].Competenza:=0;
    GgProfili[xx].CompetenzaLorda:=0;
    MmProfili[xx].Competenza:=0;
    MmProfili[xx].CompetenzaLorda:=0;
  end;
  ProfiliSingoli:=0;
  CompPrima:=0;
  for xx:=Low(Competenze) to High(Competenze) do CompPrima:=CompPrima + Competenze[xx];
  TrasferisciCompetenze(CompetenzeOriginali,Competenze,False);
  RaggruppaProfili;
  PropGGOld:=PropGG;
  CalcolaCompetenze(Anno);
  if CodIntQ260 = 'A' then
  begin
    VariazionePartTime:=VariazionePartTimeOld;
  end;
  CompDopo:=0;
  for xx:=Low(Competenze) to High(Competenze) do CompDopo:=CompDopo + Competenze[xx];
  PropGGOld:=PropGGOld - PropGG;
  //Se unità di misura ad ore tronco i decimali dei minuti
  if UMisura = 'O' then
  begin
    if (PropGGOld <> Trunc(PropGGOld)) and (not PropMensile) then
    begin
      for i:=1 to High(Competenze) do
        if Competenze[i] > Trunc(Competenze[i]) then
          Competenze[i]:=Trunc(Competenze[i]) + 1;
    end;
    PropGGOld:=Trunc(PropGGOld);
  end;
  CompSoloFerie:=PropGGOld;
  (*Nel caso di proporzione mensile, la decurtazione dovuta ad assenze
    che non maturano viene comunque proporzionate a giorni. La decurtazione
    calcolata viene quindi tolta dalla proporzione mensile*)
  PropGGOld:=PropGGOld - Abs(CompDopo - CompPrima);
  if PropMensile and (PropGGOld > 0) then
    for i:=High(Competenze) downto 1 do
      if PropGGOld >= Competenze[i] then
      begin
        PropGGOld:=PropGGOld - Competenze[i];
        Competenze[i]:=0;
      end
      else
      begin
        Competenze[i]:=Competenze[i] - PropGGOld;
        Break;
      end;
  if CalcolaCompetenzeParziali then
  begin
    ArrotondaCompetenze(Competenze);
    for i:=1 to High(Competenze) do
      CompetenzeParziali[i]:=Competenze[i];
  end;
end;

function TR600DtM1.CalcolaCompetenze(Anno:Word):Real;
{Calcolo le competenze di ciascun profilo proporzionando i valori annuali al numero di giorni effettivi}
var i:Byte;
    UMOld:String;
    NG:Integer;
    FM:Real;
begin
  Result:=0;
  UMOld:=UMisura;
  PropMensile:=False;
  PropRatei:=False;
  PropGG:=0;
  PropMM:=0;
  FruizMinimaAC:=0;
  for i:=1 to ProfiliSingoli do
    with Q262 do
    begin
      //Alberto 20/06/2006: rileggo il profilo solo se sono cambiati i dati
      if (StrToIntDef(VarToStr(GetVariable('Anno')),0) <> Anno) or
         (VarToStr(GetVariable('CodRaggr')) <> Q265.FieldByName('CodRaggr').AsString) or
         (VarToStr(GetVariable('CodProfilo')) <> CodProfili[i]) then
      begin
        Close;
        SetVariable('CodProfilo',CodProfili[i]);
        SetVariable('CodRaggr',Q265.FieldByName('CodRaggr').AsString);
        SetVariable('Anno',Anno);
      end;
      Open;
      if RecordCount > 0 then
      begin
        LeggiCompetenze(2);
        //Leggo Fruizione Minima Anno Corrente        //Lorena 29/12/2005
        if UMisura = 'G' then
          //FruizMinimaAC:=StrToFloatDef(FieldByName('FRUIZ_ANNO_MINIMA').AsString,0)
          FM:=StrToFloatDef(FieldByName('FRUIZ_ANNO_MINIMA').AsString,0)
        else
          //FruizMinimaAC:=R180OreMinutiExt(FieldByName('FRUIZ_ANNO_MINIMA').AsString);
          FM:=R180OreMinutiExt(FieldByName('FRUIZ_ANNO_MINIMA').AsString);
        //Gestione competenze personalizzate
        if FieldByName('COMPETENZE_PERSONALIZZATE').AsString = 'S' then
        begin
          FruizMinimaAC:=FM;
          ValorizzaCompetenze(CompetenzeLette,Competenze,UMisura,False);
          PropMensile:=(FieldByName('PropGGMM').AsString = 'M') or (FieldByName('PropGGMM').AsString = 'R');
          PropRatei:=FieldByName('PropGGMM').AsString = 'R';
          Break;
        end
        //Se l'unità di misura differisce dall'originale non la considero
        else if UMisura = UMOld then
        begin
          ValorizzaCompetenze(CompetenzeLette,CompetenzeApp,UMisura,False);
          ProporzionaCompetenze(i,Anno,FieldByName('PropGGMM').AsString);
          //Proporziono Fruizione Minima Anno Corrente      //Lorena 29/12/2005
          //if FruizMinimaAC > 0 then
          if FM > 0 then
            try
              NG:=Trunc(EncodeDate(Anno,12,31)) - Trunc(EncodeDate(Anno,1,1)) + 1;
              if FieldByName('PropGGMM').AsString = 'G' then
                //FruizMinimaAC:=FruizMinimaAC * GgProfili[i] / NG
                FM:=FM * GgProfili[i].Competenza / NG
              else
                //FruizMinimaAC:=FruizMinimaAC * MmProfili[i] / 12;
                FM:=FM * MmProfili[i].Competenza / 12;
            except
              if UMisura = 'G' then
                //FruizMinimaAC:=StrToFloatDef(FieldByName('FRUIZ_ANNO_MINIMA').AsString,0)
                FM:=StrToFloatDef(FieldByName('FRUIZ_ANNO_MINIMA').AsString,0)
              else
                //FruizMinimaAC:=R180OreMinutiExt(FieldByName('FRUIZ_ANNO_MINIMA').AsString);
                FM:=R180OreMinutiExt(FieldByName('FRUIZ_ANNO_MINIMA').AsString);
            end;
          PropMensile:=(FieldByName('PropGGMM').AsString = 'M') or (FieldByName('PropGGMM').AsString = 'R');
          PropRatei:=FieldByName('PropGGMM').AsString = 'R';
        end;
        FruizMinimaAC:=FruizMinimaAC + FM;
      end;
    end;
  UMisura:=UMOld;
  for i:=1 to High(Competenze) do
    Result:=Result + Competenze[i];
end;

procedure TR600DtM1.ProporzionaCompetenze(idxProfilo,Anno:Integer; PropGGMM:String);
{Ripartisce le competenze in fasce annuali sulla base dei giorni disponibili per quel profilo}
var R,RM,RLorda,RMLorda:Real;
    i:Byte;
    NG,x:Integer;
    Formula:String;
begin
  VariazionePartTime:=0;
  NG:=Trunc(EncodeDate(Anno,12,31)) - Trunc(EncodeDate(Anno,1,1)) + 1;
  for i:=1 to 6 do
  begin
    try
      RLorda:=CompetenzeApp[i] * GgProfili[idxProfilo].CompetenzaLorda / NG;
      RMLorda:=CompetenzeApp[i] * MmProfili[idxProfilo].CompetenzaLorda / 12;
      R:=CompetenzeApp[i] * GgProfili[idxProfilo].Competenza / NG;
      RM:=CompetenzeApp[i] * MmProfili[idxProfilo].Competenza / 12;
      //Torino_ITC!!!!!
      for x:=1 to High(ProfAssenze) do
        if ProfAssenze[x].Codice = CodProfili[idxProfilo] then
        begin
          Formula:=ProfAssenze[x].FormulaProporzione;
          Break;
        end;
      if Formula <> '' then
      begin
        with TOracleQuery.Create(nil) do
        try
          Session:=SessioneOracle;
          //SQL.Text:=Format('select %s from dual',['round(:COMPETENZE / :GGANNO * :GGPROFILO / trunc(:VALENZAGG/2)) * trunc(:VALENZAGG/2)']);
          SQL.Text:=Format('select %s from dual',[Formula]);
          if Pos(':COMPETENZE',UpperCase(Formula)) > 0 then
            DeclareAndSet('COMPETENZE',otFloat,CompetenzeApp[i]);
          if Pos(':GGANNO',UpperCase(Formula)) > 0 then
            DeclareAndSet('GGANNO',otInteger,NG);
          if Pos(':GGPROFILO',UpperCase(Formula)) > 0 then
            DeclareAndSet('GGPROFILO',otFLoat,GgProfili[idxProfilo].Competenza);
          if Pos(':VALENZAGG',UpperCase(Formula)) > 0 then
            DeclareAndSet('VALENZAGG',otFloat,ValenzaGiornaliera);
          Execute;
          R:=FieldAsFloat(0);
          DeclareAndSet('GGPROFILO',otFLoat,GgProfili[idxProfilo].CompetenzaLorda);
          Execute;
          RLorda:=FieldAsFloat(0);
        finally
          Free;
        end;
      end;
    except
      RLorda:=0;
      RMLorda:=0;
      R:=0;
      RM:=0;
    end;
    if PropGGMM = 'G' then
    begin
      Competenze[i]:=Competenze[i] + R;
      VariazionePartTime:=VariazionePartTime + RLorda - R;
    end
    else
    begin
      Competenze[i]:=Competenze[i] + RM;
      VariazionePartTime:=VariazionePartTime + RMLorda - RM;
    end;
    PropGG:=PropGG + R;
    PropMM:=PropMM + RM;
  end;
end;

procedure TR600DtM1.RaggruppaProfili;
{Raggruppo i profili uguali
 CodProfili e GgProfili contengono i dati dei profili raggruppati per codice:
 non ho mai 2 elementi con lo stesso codice profilo}
var i,j,k:Integer;
    A1,M1,G1,A2,M2,G2:Word;
    NM:Real;
begin
  for i:=1 to NumProfili do
  begin
    for j:=1 to ProfiliSingoli do
      if CodProfili[j] = ProfAssenze[i].Codice then
        Break;
    if (j > ProfiliSingoli) or (ProfiliSingoli = 0) then
    begin
      inc(ProfiliSingoli);
      j:=ProfiliSingoli;
      CodProfili[j]:=ProfAssenze[i].Codice;
    end;
    if (Q265.FieldByName('Tipo_Proporzione').AsString <> 'R') or (Q265.FieldByName('PartTime').AsString = 'N') then  //Lorena 09/05/2006
      GgProfili[j].Competenza:=GgProfili[j].Competenza + (ProfAssenze[i].Giorni * ProfAssenze[i].PartTime / 100)
    else
      GgProfili[j].Competenza:=GgProfili[j].Competenza + ProfAssenze[i].Giorni;
    GgProfili[j].CompetenzaLorda:=GgProfili[j].CompetenzaLorda + ProfAssenze[i].Giorni;
    //Calcolo mesi per proporzione mensile
    if ProfAssenze[i].ValidoAl < ProfAssenze[i].ValidoDal then
      Continue;
    DecodeDate(ProfAssenze[i].ValidoDal,A1,M1,G1);
    DecodeDate(ProfAssenze[i].ValidoAl,A2,M2,G2);
    NM:=(M2 - 1) - M1;
    if NM < 0 then
      NM:=0;
    if ProfAssenze[i].TipoProporzione = '4' then  //Proporzione giornaliera
    begin
      NM:=NM + (R180GiorniMese(ProfAssenze[i].ValidoDal) - G1 + 1) / R180GiorniMese(ProfAssenze[i].ValidoDal);
      NM:=NM + (G2 / R180GiorniMese(ProfAssenze[i].ValidoAl));
    end
    else
    begin
      //Tipo proporzione delle competenze per Rateo gestione CSI
      if ProfAssenze[i].PropCompGGMMRA = 'R' then
      begin
        for k:=M1 + 1 to M2 -1 do
        // Cambiato controllo da (assenze > Giorni del mese/2) in (Giorni del mese - assenze >= 15) *** if AssAbbateFerieMM[k] > R180GiorniMese(EncodeDate(A1, k, 1)) / 2 then
        if R180GiorniMese(EncodeDate(A1, k, 1)) - AssAbbateFerieMM[k] < ArrotFerie then
        begin
          AssAbbateRateoMM[k]:=1;
          NM:=NM - 1;
        end;
        if M1 = M2 then
        begin
          if (G2 - G1 + 1) > ProfAssenze[i].Minimo then
             // Cambiato controllo da (assenze > Giorni del mese/2) in (Giorni del mese - assenze >= 15) *** if (AssAbbateFerieMM[M1] <= R180GiorniMese(EncodeDate(A1, M1, 1)) / 2) then
            if R180GiorniMese(EncodeDate(A1, M1, 1)) - AssAbbateFerieMM[M1] >= ArrotFerie then
              NM:=NM + 1
            else
              AssAbbateRateoMM[M1]:=1;
        end
        else
        begin
          (*Se il cambio di profilo avviene in corso di mese, considero il profilo
            con lo spezzone maggiore; se gli spezzoni sono uguali assegno metà mese ad entrambi*)
          if (R180GiorniMese(ProfAssenze[i].ValidoDal) - G1 + 1) > (G1 - 1) then
          begin
            // Cambiato controllo da (assenze > Giorni del mese/2) in (Giorni del mese - assenze >= 15) *** if AssAbbateFerieMM[M1] <= R180GiorniMese(EncodeDate(A1, M1, 1)) / 2 then
            if R180GiorniMese(EncodeDate(A1, M1, 1)) - AssAbbateFerieMM[M1] >= ArrotFerie then
              NM:=NM + 1
            else
              AssAbbateRateoMM[M1]:=1;
          end
          else if (R180GiorniMese(ProfAssenze[i].ValidoDal) - G1 + 1) = (G1 - 1) then
          begin
            if (i > 1) and (ProfAssenze[i].PartTime >= ProfAssenze[i - 1].PartTime) then
              // Cambiato controllo da (assenze > Giorni del mese/2) in (Giorni del mese - assenze >= 15) *** if AssAbbateFerieMM[M1] <= R180GiorniMese(EncodeDate(A1, M1, 1)) / 2 then
              if R180GiorniMese(EncodeDate(A1, M1, 1)) - AssAbbateFerieMM[M1] >= ArrotFerie then
                NM:=NM + 1
              else
                AssAbbateRateoMM[M1]:=1;
          end;
          if G2 > (R180GiorniMese(ProfAssenze[i].ValidoAl) - G2) then
          begin
            // Cambiato controllo da (assenze > Giorni del mese/2) in (Giorni del mese - assenze >= 15) *** if AssAbbateFerieMM[M2] <= R180GiorniMese(EncodeDate(A2, M2, 1)) / 2 then
            if R180GiorniMese(EncodeDate(A2, M2, 1)) - AssAbbateFerieMM[M2] >= ArrotFerie then
              NM:=NM + 1
            else
              AssAbbateRateoMM[M2]:=1;
          end
          else if G2 = (R180GiorniMese(ProfAssenze[i].ValidoAl) - G2) then
            if (i < NumProfili) and (ProfAssenze[i].PartTime >= ProfAssenze[i + 1].PartTime) then
              // Cambiato controllo da (assenze > Giorni del mese/2) in (Giorni del mese - assenze >= 15) *** if AssAbbateFerieMM[M2] <= R180GiorniMese(EncodeDate(A2, M2, 1)) / 2 then
              if R180GiorniMese(EncodeDate(A2, M2, 1)) - AssAbbateFerieMM[M2] >= ArrotFerie then
                NM:=NM + 1
              else
                AssAbbateRateoMM[M2]:=1;
        end;
      end
      else
      begin
        if M1 = M2 then
        begin
          if (*ProfAssenze[i].Giorni*) (G2 - G1 + 1) > ProfAssenze[i].Minimo then
            NM:=NM + 1;
        end
        else
        begin
          (*Se il cambio di profilo avviene in corso di mese, considero il profilo
            con lo spezzone maggiore; se gli spezzoni sono uguali assegno metà mese ad entrambi*)
          if (R180GiorniMese(ProfAssenze[i].ValidoDal) - G1 + 1) > (G1 - 1) then
            NM:=NM + 1
          else if (R180GiorniMese(ProfAssenze[i].ValidoDal) - G1 + 1) = (G1 - 1) then
          begin
            NM:=NM + 0.5;
          end;
          if G2 > (R180GiorniMese(ProfAssenze[i].ValidoAl) - G2) then
            NM:=NM + 1
          else if G2 = (R180GiorniMese(ProfAssenze[i].ValidoAl) - G2) then
            NM:=NM + 0.5;
        end;
      end
    end;
    if (Q265.FieldByName('Tipo_Proporzione').AsString <> 'R') or (Q265.FieldByName('PartTime').AsString = 'N') then  //Lorena 09/05/2006
      MmProfili[j].Competenza:=MmProfili[j].Competenza + (NM * ProfAssenze[i].PartTime / 100)
    else
      MmProfili[j].Competenza:=MmProfili[j].Competenza + NM;
    MmProfili[j].CompetenzaLorda:=MmProfili[j].CompetenzaLorda + NM;
  end;
end;

procedure TR600DtM1.ArrotondamentoAssunzCessaz(Anno1,Anno2:TDateTime);
{Calcolo arrotondamenti su assunzione/cessazione solo per le ferie
e festività soppresse}
var NewAssunz:Boolean;
    Data1:TDateTime;
    i,Cod1:Integer;
begin
  Cod1:=1;
  Data1:=Anno1;
  NewAssunz:=False;
  for i:=1 to NumProfili do
    with ProfAssenze[i] do
    begin
      if ValidoDal > ValidoAl then Continue;
      if not NewAssunz then
        //Se trovo una data di assunzione all'interno del periodo registro i dati
        if (Assunzione >= Anno1) and (Assunzione >= ValidoDal) and (Assunzione <= ValidoAl) then
        begin
          NewAssunz:=True;
          Cod1:=i;
          Data1:=Assunzione;
        end;
      //Se trovo una data di cessazione...
      if (Cessazione > Data1) and (Cessazione <= Anno2) and (Cessazione <= Fine) then
      begin
        //Se corrisponde a una assuzione arrotondo considerando sia assunzione che cessazione
        if NewAssunz then
        begin
          NewAssunz:=False;
          ArrotondaAssCess(Cod1,i,Data1,Cessazione,2);
          inc(Cod1);
        end
        else
          //Arrotondo considerando solo cessazione
          ArrotondaAssCess(Cod1,i,0,Cessazione,1);
      end;
    end;
  //Arrotondo considerando solo assunzione
  if NewAssunz then
    ArrotondaAssCess(Cod1,NumProfili,Data1,0,0);
end;

procedure TR600DtM1.ArrotondaAssCess(Ind1,Ind2:Integer; Ass,Cess:TDateTime; Modo:Byte);
var A,M,G: Word;
    NG,Tot1,Tot2,T1:Integer;
    GesAss,GesCess:Boolean;
    ArrAss,ArrCess:Integer;
    SommaAss,SommaCess:String;
begin
  ArrAss:=0;
  ArrCess:=0;
  SommaAss:='S';
  SommaCess:='S';
  if Modo in [0,2] then
  begin
    if ProfAssenze[Ind1].TipoProporzione = '2' then
      ArrAss:=R180GiorniMese(Ass) div 2// + 1
    else
      ArrAss:=ProfAssenze[Ind1].Minimo;
    SommaAss:=ProfAssenze[Ind1].SommaAssCess;
  end;
  if Modo in [1,2] then
  begin
    if ProfAssenze[Ind2].TipoProporzione = '2' then
      ArrCess:=R180GiorniMese(Ass) div 2// + 1
    else
      ArrCess:=ProfAssenze[Ind2].Minimo;
    SommaCess:=ProfAssenze[Ind2].SommaAssCess;
  end;
  if Modo = 2 then
    SommaAss:=SommaCess;
  Tot1:=0;
  Tot2:=0;
  GesAss:=True;
  if (Modo in [0,2]) and (ArrAss <> 0) then
  begin //Arrotondo data di assunzione
    NG:=R180GiorniMese(Ass);
    DecodeDate(Ass,A,M,G);
    Tot1:=NG - G + 1;
    if Tot1 <= ArrAss then
    begin
      if (Modo = 0) or ((Modo = 2) and (SommaAss = 'N')) then
      begin
        TogliGiorni(Ind1,Ind2,Tot1);         //Escludo gli ultimi giorni del mese
        dec(ProfAssenze[Ind1].VariazAssCess,Tot1);
        ProfAssenze[Ind1].ValidoDal:=EncodeDate(R180Anno(ProfAssenze[Ind1].ValidoDal),R180Mese(ProfAssenze[Ind1].ValidoDal),R180GiorniMese(ProfAssenze[Ind1].ValidoDal)) + 1;
      end
      else
        GesAss:=False;
    end
    else
      if ArrAss = -99 then
      begin
        inc(ProfAssenze[Ind1].Giorni,Trunc(Ass - EncodeDate(A,1,1)));  //Includo tutto l'anno
        ProfAssenze[Ind1].ValidoDal:=EncodeDate(A,1,1);  //Alberto 17/11/2005 - Adeguo anche la validità del profilo per la proporzione mensile
      end
      else if (ProfAssenze[Ind1].Cessazione = 0) or
              (ProfAssenze[Ind1].Cessazione - ProfAssenze[Ind1].Assunzione + 1 > ArrAss) then
      begin
        inc(ProfAssenze[Ind1].Giorni,G - 1);  //Includo i primi giorni del mese
        inc(ProfAssenze[Ind1].VariazAssCess,G - 1);
        ProfAssenze[Ind1].ValidoDal:=EncodeDate(R180Anno(ProfAssenze[Ind1].ValidoDal),R180Mese(ProfAssenze[Ind1].ValidoDal),1);
      end;
  end;
  GesCess:=True;
  if (Modo in [1,2]) and (ArrCess <> 0) then
  begin //Arrotondo data di cessazione
    NG:=R180GiorniMese(Cess);
    DecodeDate(Cess,A,M,G);
    Tot2:=G;
    if ((G >= ArrCess) and (G = NG / 2) and (SommaCess = 'S') and not GesAss) or (G > ArrCess) then
//    if G > ArrCess then  **Nando 29/10/2014 prima la riga precedente era questa
    begin
      if ArrCess = -99 then
        inc(ProfAssenze[Ind2].Giorni,Trunc(EncodeDate(A,12,31) - Cess))  //Includo tutto l'anno
      else if (ProfAssenze[Ind2].Cessazione = 0) or
              (ProfAssenze[Ind2].Cessazione - ProfAssenze[Ind2].Assunzione + 1 > ArrCess) then
      begin
        inc(ProfAssenze[Ind2].Giorni,NG - G);  //Includo gli ultimi giorni del mese
        inc(ProfAssenze[Ind2].VariazAssCess,NG - G);
        ProfAssenze[Ind2].ValidoAl:=EncodeDate(R180Anno(ProfAssenze[Ind2].ValidoAl),R180Mese(ProfAssenze[Ind2].ValidoAl),R180GiorniMese(ProfAssenze[Ind2].ValidoAl));
      end;
    end
    else if (Modo = 1) or (GesAss) or ((Modo = 2) and (SommaCess = 'N')) then
    begin
      TogliGiorni(Ind2,Ind1,Tot2);         //Escludo i primi giorni del mese
      dec(ProfAssenze[Ind2].VariazAssCess,Tot2);
      ProfAssenze[Ind2].ValidoAl:=EncodeDate(R180Anno(ProfAssenze[Ind2].ValidoAl),R180Mese(ProfAssenze[Ind2].ValidoAl),1) - 1;
    end
    else
      GesCess:=False;
  end;
  if (not GesAss) and (not GesCess) then
  begin
    //Cumulo i giorni residui di assunzione e cessazione
    T1:=Tot1 + Tot2;
    if T1 > ArrCess then
      //Assegno un mese di arrotondamento: aggiungo tanti giorni quanti servono per
      //ottenere 15gg nel movim. di assunzione e 15gg nel movim. di cessaione
    begin
      inc(ProfAssenze[Ind1].Giorni,ArrCess - Tot1);
      inc(ProfAssenze[Ind2].Giorni,ArrCess - Tot2);
      inc(ProfAssenze[Ind1].VariazAssCess,ArrCess - Tot1);
      inc(ProfAssenze[Ind2].VariazAssCess,ArrCess - Tot2);
      ProfAssenze[Ind1].ValidoDal:=EncodeDate(R180Anno(ProfAssenze[Ind1].ValidoDal),R180Mese(ProfAssenze[Ind1].ValidoDal),1);
    end
    else
      //Tolgo i giorni dall'inizio e dalla fine
    begin
      TogliGiorni(Ind1,Ind2,Tot1);
      TogliGiorni(Ind2,Ind1,Tot2);
      dec(ProfAssenze[Ind1].VariazAssCess,Tot1);
      dec(ProfAssenze[Ind2].VariazAssCess,Tot2);
      ProfAssenze[Ind1].ValidoDal:=EncodeDate(R180Anno(ProfAssenze[Ind1].ValidoDal),R180Mese(ProfAssenze[Ind1].ValidoDal),R180GiorniMese(ProfAssenze[Ind1].ValidoDal)) + 1;
      ProfAssenze[Ind2].ValidoAl:=EncodeDate(R180Anno(ProfAssenze[Ind2].ValidoAl),R180Mese(ProfAssenze[Ind2].ValidoAl),1) - 1;
    end;
  end;
  if (not GesAss) and (GesCess) and (ArrAss <> 0) then
  begin
    TogliGiorni(Ind1,Ind2,Tot1);
    dec(ProfAssenze[Ind1].VariazAssCess,Tot1);
    ProfAssenze[Ind1].ValidoDal:=EncodeDate(R180Anno(ProfAssenze[Ind1].ValidoDal),R180Mese(ProfAssenze[Ind1].ValidoDal),R180GiorniMese(ProfAssenze[Ind1].ValidoDal)) + 1;
  end;
end;

procedure TR600DtM1.GetProporzione(Data:TDateTime; Profilo,Raggr:String);
begin
  with Q262c do
  begin
    //Alberto 20/06/2006: leggo il profilo solo se sono cambiati i dati
    if (StrToIntDef(VarToStr(GetVariable('Anno')),0) <> R180Anno(Data)) or
       (VarToStr(GetVariable('CodRaggr')) <> Raggr) or
       (VarToStr(GetVariable('CodProfilo')) <> Profilo) then
    begin
      Close;
      SetVariable('CODPROFILO',Profilo);
      SetVariable('ANNO',R180Anno(Data));
      SetVariable('CODRAGGR',Raggr);
    end;
    Open;
  end;
end;

procedure TR600DtM1.TogliMaturazFerie(Anno1,Anno2:TDateTime);
{Leggo tutte le assenze a giornate intere che non maturano ferie e le sottraggo
ai giorni dei vari periodi di storicizzazione}
var i,j,QtaNoMatFerI:Integer;
    QtaNoMatFerD:Real;
    MesePrec:Integer;
begin
  if RapportoCorrente.Esiste then
  begin
    if Anno1 < RapportoCorrente.Rapporto[0].Inizio then
      Anno1:=RapportoCorrente.Rapporto[0].Inizio;
    if Anno2 > RapportoCorrente.Rapporto[0].Fine then
      Anno2:=RapportoCorrente.Rapporto[0].Fine;
  end;
  for i:=1 to 12 do
  begin
    AssAbbateFerieMM[i]:=0;
    AssAbbateRateoMM[i]:=0;
  end;
  MesePrec:=0;
  with NonMaturaFerie do
  begin
    Close;
    SetVariable('Data1',Anno1);
    SetVariable('Data2',Anno2);
    SetVariable('RichiesteIterAutorizzativo',IfThen(RichiesteIterAutorizzativo,'S','N'));
    Open;
    First;
    while not Eof do
    begin
      j:=NumProfili + 1;
      for i:=1 to NumProfili do
        if (ProfAssenze[i].Decorr <= FieldByName('Data').AsDateTime) and
           (ProfAssenze[i].Fine >= FieldByName('Data').AsDateTime) and
           (ProfAssenze[i].Assunzione <= FieldByName('Data').AsDateTime) and
           ((ProfAssenze[i].Cessazione = 0) or (ProfAssenze[i].Cessazione >= FieldByName('Data').AsDateTime)) then
        begin
          j:=i;
          Break;
        end;
      //Nella gestione a ratei mensili azzero le mezze giornate di abbattimento ferie al cambio mese
      if ProfAssenze[i].PropCompGGMMRA = 'R' then
      begin
        if MesePrec = 0 then
          MesePrec:=R180mese(FieldByName('Data').AsDateTime);
        if MesePrec <> R180mese(FieldByName('Data').AsDateTime) then
        begin
          MesePrec:=R180mese(FieldByName('Data').AsDateTime);
          QtaNoMatFerD:=0;
        end;
      end;
      if j <= NumProfili then
      begin
        //Sommo le quantità sia in giornate che in mezze giornate
        QtaNoMatFerD:=QtaNoMatFerD + FieldByName('Quantita').AsFloat;
        //Al raggiungimento di 1 giornata parte la decurtazione delle ferie
        if QtaNoMatFerD >= 1 then
        begin
          QtaNoMatFerI:=1;
          QtaNoMatFerD:=QtaNoMatFerD - 1;
        end
        else
          QtaNoMatFerI:=0;
        //Se ho raggiunto la giornata intera applico la riduzione
        if QtaNoMatFerI > 0 then
          if ProfAssenze[i].PropCompGGMMRA = 'R' then
            AssAbbateFerieMM[R180Mese(FieldByName('Data').AsDateTime)]:=AssAbbateFerieMM[R180Mese(FieldByName('Data').AsDateTime)] + QtaNoMatFerI
          else
            TogliGiorni(j,NumProfili,QtaNoMatFerI);
      end;
      Next;
    end;
    Close;
  end;
  (*Gestione del caso di assenze che non maturano ferie su TUTTO il periodo di servizio
  Si devono infatti annullare le variazioni che sono state fatte a causa degli
  arrotondamenti per Assunzione Cessazione in corso di mese*)
  for i:=1 to NumProfili do
    if (ProfAssenze[i].Giorni - ProfAssenze[i].VariazAssCess) <= 0 then
      ProfAssenze[i].Giorni:=0;
end;

procedure TR600DtM1.TogliGiorni(Ind1,Ind2,Tot:Integer);
{Tolgo i giorni di arrotondamento per assunzione/cessazione o giorni che
 non maturano ferie dai profili}
var i:Integer;
begin
  if Ind1 <= Ind2 then
    //Assunzione
    for i:=Ind1 to Ind2 do
    begin
      if Tot = 0 then Break;
      if Tot > ProfAssenze[i].Giorni then
      begin
        dec(Tot,ProfAssenze[i].Giorni);
        ProfAssenze[i].Giorni:=0;
      end
      else
      begin
        dec(ProfAssenze[i].Giorni,Tot);
        Tot:=0;
      end;
    end
  else
    for i:=Ind1 downto Ind2 do
    begin
      if Tot = 0 then Break;
      if Tot > ProfAssenze[i].Giorni then
      begin
        dec(Tot,ProfAssenze[i].Giorni);
        ProfAssenze[i].Giorni:=0;
      end
      else
      begin
        dec(ProfAssenze[i].Giorni,Tot);
        Tot:=0;
      end;
    end
end;
//-------------------------------------------------------------------------------
//----------- C U M U L O   A S S E N Z E ---------------------------------------
//-------------------------------------------------------------------------------
function TR600DtM1.CumuloAssenze:TModalResult;
{Cumulo le assenze fruite considerando le causali collegate}
begin
  //Se tipocumulo = H non esiste cumulo: esco subito
  Result:=mrOk;
  if  not EsisteCumulo then exit;
  //Leggo le causali collegate da considerare nel cumulo
  if Giustificativo.Causale <> GiustifPrec.Causale then
    LCausCollegate.CommaText:=Q265.FieldByName('CodCau1').AsString;
  //Restituisce InizioCumulo e FineCumulo in base al TipoCumulo
  Result:=PeriodoDiCumulo(DaData);
  //if (InizioCumulo - 2) < InizioConteggi then //Alberto 08/06/2006
  InizioConteggi:=InizioCumulo - 2;
  //if (FineCumulo + 2) > FineConteggi then  //Alberto 08/06/2006
  FineConteggi:=FineCumulo + 2;
  if LetturaRiduzioni and LetturaAssenze then
    FineCumulo:=DaData;
  if Result = mrOK then
  begin
    {$IFDEF MEDP803}
    //Preparo le query dei conteggi nel periodo interessato
    R502ProDtM1.Chiamante:='Assenze';
    R502ProDtM1.PeriodoConteggi(InizioConteggi,FineConteggi);
    R502ProDtM1.Q100.Open;
    if R502ProDtM1.Q040.Active then
      R502ProDtM1.Q040.Refresh;
    {$ENDIF}
    if not((TipoCumulo = 'R') and PassaggioDiAnno) then //Alberto 04/07/2012: non si considerano le fruizioni per questo tipo ci cumulo in fase di passaggio di anno: sono già residui al 31/12
      CalcolaCumuli(True);
  end;
end;

procedure TR600DtM1.CumuloAssenzeHMA(parCausale:String; parInizioCumulo,parFineCumulo:TDateTime; parResto:Integer);
{Cumulo le assenze fruite con giustificativi orari, per riconsocere quando formano una giornata intera}
var i,idx,mm,HMAssenza:Integer;
begin
  Giustificativo.Causale:=parCausale;
  Giustificativo.Raggruppamento:=Q265.Lookup('CODICE',Giustificativo.Causale,'CODRAGGR');
  if Parametri.CampiRiferimento.C23_VMHFruizGG = 'S' then
    //ReggioEmilia_Comune: cumulo anche i giustificativi a gg intera
    LCausCollegate.CommaText:=Q265.Lookup('CODICE',Giustificativo.Causale,'CodCau1')
  else
    LCausCollegate.CommaText:=Giustificativo.Causale;
  InizioCumulo:=parInizioCumulo;
  FineCumulo:=parFineCumulo;
  InizioConteggi:=InizioCumulo - 2;
  FineConteggi:=FineCumulo + 2;
  CalcolaCumuli(False);

  //Individuo i giorni per cui è necessario inserire il giustificativo a giornata intera (che impatta sul comporto malattia)
  SetLength(lstFruizGiornaliereHMA,0);
  mm:=parResto;
  idx:=-1;
  for i:=0 to High(AssenzeConteggiate) do
  begin
    //HMAssenza:=GetHMAssenza(Progressivo,AssenzeConteggiate[i].data,AssenzeConteggiate[i].causale);
    HMAssenza:=GetHMAssenza(Progressivo,AssenzeConteggiate[i].data,parCausale);
    if AssenzeConteggiate[i].tipo = 'I' then
      //ReggioEmilia_Comune: se gg intera considero la parte eccedente la valenza giornaliera (6 ore)
      inc(mm,Max(0,AssenzeConteggiate[i].tminvalasse - HMAssenza))
    else
      inc(mm,AssenzeConteggiate[i].tminvalasse);
    if mm >= HMAssenza then
    begin
      idx:=Length(lstFruizGiornaliereHMA);
      SetLength(lstFruizGiornaliereHMA,idx + 1);
      lstFruizGiornaliereHMA[idx].data:=AssenzeConteggiate[i].data;
      lstFruizGiornaliereHMA[idx].resto:=mm - HMAssenza;
      mm:=mm - HMAssenza;
    end
    else
    begin
      if (idx >= 0) and (lstFruizGiornaliereHMA[idx].data = AssenzeConteggiate[i].data) then
        lstFruizGiornaliereHMA[idx].resto:=mm;
    end;
  end;
end;

function TR600DtM1.AcquisizioneRichiesteAuto(lstID:String; var Errore:String; var NumScartate,NumRichieste:Integer):Boolean;
var A004MW: TA004FGiustifAssPresMW;
begin
  Result:=True;
  Errore:='';
  NumScartate:=0;
  NumRichieste:=-1;
  if Parametri.CampiRiferimento.C90_W010AcquisizioneAuto <> 'S' then
    exit;

  A004MW:=TA004FGiustifAssPresMW.Create(Self);
  try
    A004MW.Chiamante:='W010';
    with A004MW.selT050 do
    begin
      Close;
      SetVariable('AZIENDA',Parametri.Azienda);
      SetVariable('C700SELANAGRAFE','t030_anagrafico t030 where 1=1');
      SetVariable('FILTRO_RICHIESTE',Format('and t050.id in (%s)',[lstID]));
      Open;
      NumRichieste:=RecordCount;
      if RecordCount > 0 then
      try
        Result:=A004MW.AcquisizioneRichiesteWeb(False,False,Errore,NumScartate,True);
      except
      end;
    end;
  finally
    try FreeAndNil(A004MW); except end;
  end;
end;

function TR600DtM1.PeriodoDiCumulo(DataInizio:TDateTime):TModalResult;
{Date di riferimento per il cumulo: InizioCumulo - FineCumulo
 DataInizio contiene la prima volta DaData: successivamente, se supero il periodo
 di cumulo che ho considerato, conterrà il giorno}
var Anno,Mese,Giorno,A,M,G: Word;
    Durata:Integer;
    UMCumulo:String;
    D,DFine:TDateTime;
    i:Integer;
begin
  Result:=mrOk;
  DecodeDate(DataInizio,Anno,Mese,Giorno);
  Durata:=Min(999,Q265.FieldByName('DurataCumulo').AsInteger);
  UMCumulo:=Q265.FieldByName('UMCumulo').AsString;
  FineCumulo:=DataInizio;
  //Lettura dell'ultima causale per cumuli F e G
  if TipoCumulo in ['F','G'] then
  begin
    if R180CarattereDef(Q265.FieldByName('Cumulo_Familiari').AsString,1,'N') = 'S' then
      InizioCumulo:=RiferimentoDataNascita.Data
    else if R180CarattereDef(Q265.FieldByName('Cumulo_Familiari').AsString,1,'N') = 'D' then
    begin
      R180SetVariable(selSG101DataNas,'PROGRESSIVO',Progressivo);
      R180SetVariable(selSG101DataNas,'DATANAS',RiferimentoDataNascita.Data);
      R180SetVariable(selSG101DataNas,'DATA',AData);
      selSG101DataNas.Open;
      if not selSG101DataNas.FieldByName('DATANAS').IsNull then
        InizioCumulo:=selSG101DataNas.FieldByName('DATANAS').AsDateTime
      else
        InizioCumulo:=RiferimentoDataNascita.Data;
    end
    else
    with CausFruizione do
    begin
      Close;
      SetVariable('Causale',Q265.FieldByName('CodCauInizio').AsString);
      SetVariable('Data',FineCumulo);
      SetVariable('DataNas',Null);
      if R180CarattereDef(Q265.FieldByName('Fruizione_Familiari').AsString,1,'N') = 'S' then
        SetVariable('DataNas',RiferimentoDataNascita.Data)
      else if R180CarattereDef(Q265.FieldByName('Fruizione_Familiari').AsString,1,'N') = 'D' then
      begin
        R180SetVariable(selSG101DataNas,'PROGRESSIVO',Progressivo);
        R180SetVariable(selSG101DataNas,'DATANAS',RiferimentoDataNascita.Data);
        R180SetVariable(selSG101DataNas,'DATA',AData);
        selSG101DataNas.Open;
        if not selSG101DataNas.FieldByName('DATANAS').IsNull then
          SetVariable('DataNas',selSG101DataNas.FieldByName('DATANAS').AsDateTime)
        else
          SetVariable('DataNas',RiferimentoDataNascita.Data);
      end;
      Open;
      if RecordCount = 0 then
      begin  //Se non c'è causale di riferimento non faccio nulla
        AnomaliaAssenze:=17;
        Result:=Anomalie(2,Format('Matricola:%-8s %s %s %-5s %s %s',[Matricola,Nome,Chr(13),CausAnomala,Chr(13),Messaggi[17]]));
        exit;
      end;
      First;
      InizioCumulo:=FieldByName('Data').AsDateTime;
      Close;
    end;
    InizioCumuloIntero:=InizioCumulo;
    FineCumuloIntero:=FineCumulo;
  end;
  case TipoCumulo of
    //Anno solare
    'A','P','V':
        begin
        InizioCumulo:=EncodeDate(Anno,1,1);
        if LetturaAssenze then
          FineCumulo:=AData
        else
          FineCumulo:=EncodeDate(Anno,12,31);
        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=EncodeDate(Anno,12,31);
        end;
    //Mese e giorno da data di assunzione, anno in base alla durata specificata
    'B':begin
        if QSDip.LocDatoStorico(DataInizio) then
          InizioCumulo:=QSDip.FieldByName('T430INIZIO').AsDateTime
        else
        begin  //Non riesco a leggere la data di assunzione in questo periodo
          AnomaliaAssenze:=15;
          Result:=Anomalie(2,Format('Matricola:%-8s %s %s %-5s %s %s',[Matricola,Nome,Chr(13),CausAnomala,Chr(13),Messaggi[15]]));
          exit;
        end;
        if Durata = 0 then
        begin  //Controllo che la durata del periodo sia maggiore di 0
          AnomaliaAssenze:=16;
          Result:=Anomalie(2,Format('Matricola:%-8s %s %s %-5s %s %s',[Matricola,Nome,Chr(13),CausAnomala,Chr(13),Messaggi[16]]));
          exit;
        end;
        DecodeDate(InizioCumulo,A,M,G);
        //Periodicità annuale
        try
          D:=EncodeDate(A + Durata,M,G);
        except
          D:=R180FineMese(EncodeDate(A + Durata,M,1));
        end;
        while D <= DataInizio do
          try
            inc(A,Durata);
            D:=EncodeDate(A + Durata,M,G);
          except
            D:=R180FineMese(EncodeDate(A + Durata,M,1));
          end;
        try
          InizioCumulo:=EncodeDate(A,M,G);
        except
          InizioCumulo:=R180FineMese(EncodeDate(A,M,1));
        end;
        try
          FineCumulo:=EncodeDate(A + Durata,M,G) - 1;
        except
          FineCumulo:=R180FineMese(EncodeDate(A + Durata,M,1));
        end;
        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=FineCumulo;
        end;
    //Indietro di x mesi o x anni dalla fine o inizio del periodo indicato
    'C','I','O':
        begin
        if TipoCumulo = 'C' then
          FineCumulo:=AData
        else
//        FineCumulo:=DaData;  //Lorena 27/12/2005
          FineCumulo:=DataInizio; //Lorena 27/12/2005
        if TipoCumulo = 'O' then
          try
            GetInizioAssenza.SetVariable('PROG',Progressivo);
            GetInizioAssenza.SetVariable('D',FineCumulo);
            GetInizioAssenza.SetVariable('CAUS',Q265.FieldByName('CODICE').AsString);
            GetInizioAssenza.Execute;
            FineCumulo:=GetInizioAssenza.GetVariable('DI') - 1;
          except
          end;
        if TipoCumulo = 'I' then
          DecodeDate(FineCumulo - 1,A,M,G)
        else
          DecodeDate(FineCumulo,A,M,G);
        (*
        if TipoCumulo = 'O' then
          FineCumulo:=DaData;
        *)
        if Durata = 0 then
        begin  //Controllo che la durata del periodo sia maggiore di 0
          AnomaliaAssenze:=16;
          Result:=Anomalie(2,Format('Matricola:%-8s %s %s %-5s %s %s',[Matricola,Nome,Chr(13),CausAnomala,Chr(13),Messaggi[16]]));
          exit;
        end;
        if UMCumulo = 'A' then
          dec(A,Durata)
        else
          for i:=1 to Durata do
            if M = 1 then
            begin
              M:=12;
              dec(A);
            end
            else
              dec(M);
        try
          InizioCumulo:=EncodeDate(A,M,G) + 1;
        except
          InizioCumulo:=R180FineMese(EncodeDate(A,M,1)) + 1;
        end;
        //if TipoCumulo in ['I','O'] then
        //  InizioCumulo:=InizioCumulo - 1;

        //<154573> - Condizione che determina se il periodo di cumulo deve essere incrementato del periodi di aspettativa
        CorreggiCumuliAspettativa;

        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=FineCumulo;
        end;
    //Periodo in anni o mesi conteggiato da mese/giorno specificati
    'D':begin
        try
          InizioCumulo:=StrToDate(Q265.FieldByName('GMCumulo').AsString + '/' + IntToStr(Anno));
        except
          AnomaliaAssenze:=18;
          Result:=Anomalie(2,Format('Matricola:%-8s %s %s %-5s %s %s',[Matricola,Nome,Chr(13),CausAnomala,Chr(13),Messaggi[18]]));
          exit;
        end;
        DecodeDate(InizioCumulo,A,M,G);
        if InizioCumulo > FineCumulo then
          dec(A);
        repeat
          InizioCumulo:=EncodeDate(A,M,G);
          for i:=1 to Durata do
          begin
            if UMCumulo = 'A' then
              inc(A)
            else
            begin
              inc(M);
              if M > 12 then
              begin
                inc(A);
                M:=1;
              end;
            end;
            try
              FineCumulo:=EncodeDate(A,M,G) - 1;
            except
              FineCumulo:=R180FineMese(EncodeDate(A,M,1));
            end;
          end;
          if InizioCumulo > Datainizio then
            Break;
        until (DataInizio >= InizioCumulo) and (DataInizio <= FineCumulo);
        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=FineCumulo;
        if LetturaAssenze then
          FineCumulo:=AData;
        end;
    //Da inizio mese
    'E':begin
        InizioCumulo:=EncodeDate(Anno,Mese,1);
        FineCumulo:=EncodeDate(Anno,Mese,R180GiorniMese(InizioCumulo));
        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=FineCumulo;
        end;
    //A partire dall'ultima causale specificata
    'F':begin //8.0(4), prima FineCumulo = DaData!
          FineCumulo:=AData;
          FineCumuloIntero:=AData;
          if EsisteFruizione then
          begin
            if not LetturaAssenze then
              FineCumulo:=FruizA;
            FineCumuloIntero:=FruizA;
          end;
        end;
    //A partire dall'ultima causale specificata con periodicità annuale specificata
    'G':begin
        if Durata = 0 then
        begin  //Controllo che la durata del periodo sia maggiore di 0
          AnomaliaAssenze:=16;
          Result:=Anomalie(2,Format('Matricola:%-8s %s %s %-5s %s %s',[Matricola,Nome,Chr(13),CausAnomala,Chr(13),Messaggi[16]]));
          exit;
        end;
        DecodeDate(InizioCumulo,A,M,G);
        //Periodicità annuale
        (*
        try
          D:=EncodeDate(A + Durata,M,G);
        except
          D:=R180FineMese(EncodeDate(A + Durata,M,1));
        end;
        while D < DataInizio do  //Alberto 08/10/2004
          try
            inc(A,Durata);
            D:=EncodeDate(A + Durata,M,G);
          except
            D:=R180FineMese(EncodeDate(A + Durata,M,1));
          end;
        *)
        //Alberto 01/10/2005
        if UMCumulo = 'A' then
          Durata:=Durata * 12;
        D:=InizioCumulo;
        //D:=R180AddMesi(InizioCumulo,Durata);

        DFine:=IfThen(Q265.FieldByName('CUMULO_FAM_GGDOPO').AsString <> 'N',DataInizio,DataInizio + 1);
        //while R180AddMesi(D,Durata) < DataInizio do
        while R180AddMesi(D,Durata) < DFine do
          D:=R180AddMesi(D,Durata);
        try
          //Calcolo inizio cumulo considerando diversamente il primo periodo da quelli successivi:
          //Quelli successivi partono dal giorno successivo al giorno di riferimento (es. giorno successivo al compleanno)
          //e terminano il giorno di riferimento (giorno del compleanno)
          FineCumulo:=D;
          D:=InizioCumulo;
          //InizioCumulo:=EncodeDate(A,M,G);
          InizioCumulo:=FineCumulo;
          if (D < InizioCumulo) and (Q265.FieldByName('CUMULO_FAM_GGDOPO').AsString <> 'N') then
            InizioCumulo:=InizioCumulo + 1;
        except
          InizioCumulo:=R180FineMese(EncodeDate(A,M,1));
        end;
        (*
        try
          FineCumulo:=EncodeDate(A + Durata,M,G); //Alberto 28/01/2002 Originale: EncodeDate(A + Durata,M,G) - 1;
        except
          FineCumulo:=R180FineMese(EncodeDate(A + Durata,M,1));
        end;
        *)
        FineCumulo:=R180AddMesi(FineCumulo,Durata);
        if Q265.FieldByName('CUMULO_FAM_GGDOPO').AsString = 'N' then
           FineCumulo:=FineCumulo - 1;
        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=FineCumulo;
        end;
    //Periodo specificato per l'inserimento
    'L':begin
        InizioCumulo:=DaData;
        FineCumulo:=AData;
        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=FineCumulo;
        end;
    //Art.17: Inizio = 01 Gennaio, fine = Giorno in inserimento
    'M':begin
        InizioCumulo:=EncodeDate(Anno,1,1);
        FineCumulo:=AData;
        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=FineCumulo;
        end;
    //Recupero ore anno precedente: cumulo sull'anno solare
    'N':begin
        InizioCumulo:=EncodeDate(Anno,1,1);
        if LetturaAssenze then
          FineCumulo:=AData
        else
          FineCumulo:=EncodeDate(Anno,12,31);
        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=EncodeDate(Anno,12,31);
        end;
    //Giorni non lavorativi da inizio anno a FineMese(AData)
//    'Q','R','S':begin     Lorena 25/05/2004
    'Q':begin //Giorni non lavorativi da inizio anno a FineMese(AData)  Lorena 25/05/2004
        if (UMCumulo = 'A') or (UMCumulo = 'N') then
          InizioCumulo:=EncodeDate(Anno,1,1)
        else if UMCumulo = 'M' then //Giorni non lavorativi da inizio mese a FineMese(AData)  Lorena 25/05/2004
          InizioCumulo:=EncodeDate(Anno,Mese,1);
        if Q265.FieldByName('CQ_PROGRESSIVO').AsString = 'S' then
          FineCumulo:=AData
        else
          FineCumulo:=R180FineMese(AData);
        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=FineCumulo;
        end;
    'R':begin
        //InizioCumulo:=EncodeDate(Anno,1,1);
        //FineCumulo:=R180FineMese(AData);
        InizioCumulo:=EncodeDate(Anno,Mese,1);
        FineCumulo:=EncodeDate(Anno,Mese,R180GiorniMese(InizioCumulo));
        //Se cartellino settimanale calcolo il mese a settimane complete
        R180SetVariable(selT025,'PROGRESSIVO',Progressivo);
        R180SetVariable(selT025,'DATA',DataInizio);
        selT025.Open;
        if selT025.FieldByName('CARTELLINO').AsString = 'S' then
        begin
          InizioCumulo:=R180InizioMeseSettimanale(InizioCumulo,not Parametri.ModuloInstallato['TORINO_CSI_PRV']);
          FineCumulo:=R180FineMeseSettimanale(FineCumulo,not Parametri.ModuloInstallato['TORINO_CSI_PRV']);
          if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (R180InizioMese(InizioCumulo) = EncodeDate(2015,1,1)) then
            InizioCumulo:=EncodeDate(2015,1,1);
          //Il periodo di cumulo può accavallare il mese successivo, pertanto si deve gestire il caso in cui si richiedano
          //le competenze a inizio del mese successivo, ma in relatà riguardano ancora il mese precedente
          if DataInizio < InizioCumulo then
          begin
            InizioCumulo:=R180InizioMese(DataInizio - 7);
            FineCumulo:=R180FineMese(DataInizio - 7);
            InizioCumulo:=R180InizioMeseSettimanale(InizioCumulo,not Parametri.ModuloInstallato['TORINO_CSI_PRV']);
            FineCumulo:=R180FineMeseSettimanale(FineCumulo,not Parametri.ModuloInstallato['TORINO_CSI_PRV']);
            if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (R180InizioMese(InizioCumulo) = EncodeDate(2015,1,1)) then
              InizioCumulo:=EncodeDate(2015,1,1);
          end;
        end;
        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=FineCumulo;
        end;
    'S','U':
        begin
        InizioCumulo:=EncodeDate(Anno,1,1);
        FineCumulo:=R180FineMese(AData);
        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=FineCumulo;
        end;
    //Recupero di causale di assenza specifica
    'T':begin
        FineCumulo:=R180FineMese(AData);
        InizioCumulo:=R180AddMesi(R180InizioMese(AData),- Durata + 1);
        //if InizioCumulo < EncodeDate(R180Anno(AData),1,1) then
        //  InizioCumulo:=EncodeDate(R180Anno(AData),1,1);
        InizioCumuloIntero:=InizioCumulo;
        FineCumuloIntero:=FineCumulo;
        end;
    //Personalizzato
    'Z':try
          T265P_GETPERIODOCUMULO.SetVariable('PROGRESSIVO',Progressivo);
          T265P_GETPERIODOCUMULO.SetVariable('DATA',DataInizio);
          T265P_GETPERIODOCUMULO.SetVariable('CAUSALE',Q265.FieldByName('CODICE').AsString);
          T265P_GETPERIODOCUMULO.Execute;
          InizioCumulo:=T265P_GETPERIODOCUMULO.GetVariable('INIZIO_CUMULO');
          FineCumulo:=T265P_GETPERIODOCUMULO.GetVariable('FINE_CUMULO');
          InizioCumuloIntero:=InizioCumulo;
          FineCumuloIntero:=FineCumulo;
        except
          on E:Exception do
          begin
            AnomaliaAssenze:=27;
            // bugfix segnalazione anomalia
            //Result:=Anomalie(2,Format('Matricola:%-8s %s %s %-5s %s %s',[Matricola,Nome,Chr(13),CausAnomala,Chr(13),Messaggi[27],E.Message]));
            Result:=Anomalie(2,Format('Matricola:%-8s %s %s %-5s %s %s',[Matricola,Nome,Chr(13),CausAnomala,Chr(13),Format(Messaggi[27],[E.Message])]));
            // bugfix.fine
            exit;
          end;
        end;
  end;
  //Riduzione del periodo di cumulo all'ultimo periodo di rapporto
  if (TipoCumulo <> 'Z') and RapportoCorrente.Esiste then
  begin
    if InizioCumulo < RapportoCorrente.Rapporto[0].Inizio then
      InizioCumulo:=RapportoCorrente.Rapporto[0].Inizio;
    if FineCumulo > RapportoCorrente.Rapporto[0].Fine then
      FineCumulo:=RapportoCorrente.Rapporto[0].Fine;
    if not((RapportoCorrente.DataCorrente >= RapportoCorrente.Rapporto[0].Inizio) and
           (RapportoCorrente.Rapporto[0].Inizio > 0) and
           ((RapportoCorrente.DataCorrente <= RapportoCorrente.Rapporto[0].Fine) or
            (FormatDateTime('yyyy',RapportoCorrente.DataCorrente) = FormatDateTime('yyyy',RapportoCorrente.Rapporto[0].Fine))
           )) then
    begin
      InizioCumulo:=0;
      FineCumulo:=0;
    end;
  end;

  if TipoCumulo = 'M' then
  begin
    //Calcolo le competenze su cumulo M solo se esiste il Max Unitario
    if EsisteMaxUnitario then
      CalcolaLavorato(InizioCumulo,FineCumulo)
    else
      EsisteCumulo:=False;
  end;
  if TipoCumulo = 'N' then
    GetResiduiAnnoPrec(StrToInt(FormatDateTime('yyyy',DaData)));
  if TipoCumulo = 'P' then
    GetFesteLavorate(InizioCumulo,FineCumulo);
  if TipoCumulo = 'Q' then
    GetGiorniNonLavorativi(InizioCumulo,FineCumulo);
  if TipoCumulo = 'R' then
  begin
    if selT025.FieldByName('CARTELLINO').AsString = 'S' then
    begin
      //cartellino settimanale
      if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
        //L'ultima settimana può essere riferita al mese successivo
        GetSaldiScheda(InizioCumulo)
      else
        //La prima settimana può essere riferita al mese precedente
        GetSaldiScheda(FineCumulo);
    end
    else
      //Cartellino mensile
      GetSaldiScheda(FineCumulo);
  end;
  if TipoCumulo = 'S' then
    GetCausaliFruite(InizioCumulo,FineCumulo);
  if TipoCumulo = 'T' then
    GetRecuperoPeriodico(FineCumulo);
  if (TipoCumulo in ['C','I','O']) and (Q265.FieldByName('Tempo_Determinato').AsString = 'S') then
    ProporzionaCompetenzeTipoRapporto;
  if TipoCumulo = 'U' then
    GetFesteInfrasettimanali(InizioCumulo,FineCumulo);
  if TipoCumulo = 'V' then
  begin
    if Q265.FieldByName('UMISURA').AsString = 'G' then
      GetTurniReperibilitaFestivi(InizioCumulo,FineCumulo)
    else
      GetTurniReperibilitaNOChiamata(InizioCumulo, FineCumulo);
  end;
  if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and
     (TipoCumulo = 'Z') and (Q265.FieldByName('CODICE').AsString = TO_CSI_REC_SETT) then
  begin
    GetSaldoSettimanale;
  end;

  if not CompetenzeAnnoSolare then
  begin
    CompTotali:=0;
    for i:=1 to High(Competenze) do
      CompTotali:=CompTotali + Competenze[i];
  end;
  (*Carico i dati dei periodi rapporto e part time solo se
  l'assenza deve essere proporzionata ai giorni di servizio e posso considerare più periodi di servizio
  oppure deve essere proporzionata al part-time*)
  // AOSTA_REGIONE - commessa 2012/152.ini
  //Alberto 16/07/2001: calcolo competenze per tipi cumulo 'calcolati'
  if TipoCumulo = 'F' then
    GetVariazioniCongediParentali(InizioCumulo,FineCumulo);
  if CodIntQ260 = 'A' then
    GetVariazioniFestivitaParticolari(InizioCumulo,FineCumulo);
  // AOSTA_REGIONE - commessa 2012/152.fine
  if ((Q265.FieldByName('Proporziona_PerServ').AsString = 'S') and (not RapportoCorrente.Esiste)) or
     ((not Q265.FieldByName('PartTime').IsNull) and (Q265.FieldByName('PartTime').AsString <> 'N')) then
    GetPeriodiRapporto_PartTime;
  if (Q265.FieldByName('Proporziona_PerServ').AsString = 'S') and
     ((not(TipoCumulo in ['C','I','O'])) or (Q265.FieldByName('Tempo_Determinato').AsString <> 'S')) then
    ProporzionaCompetenzePeriodiRapporto;
  if (not CompetenzeAnnoSolare) and
     (Q265.FieldByName('Tipo_Proporzione').ASString = 'C') and
     (Q265.FieldByName('PartTime').AsString <> 'N') then
    //Alberto 27/07/2006: abilitato il proporzionamento part-time se non è profilo annuale
    ProporzionaCompetenzePartTime;
  //Lorena 16/01/2006 Proporzionamento in base a Abilitazione su scheda anagrafica
  if Q265.FieldByName('PROPORZIONA_ABILITAZIONE').AsString = 'S' then
    ProporzionaAbilitazioneAnagrafica;
  //Alberto 12/10/2005: spostato qui la variazione manuale alle competenze
  VariazioneManualeCompetenze;
  //Arrotondamento competenze: giornate a 0.5, minuti a 1
  if Q265.FieldByName('ARROT_COMPETENZE').AsString = 'S' then
    with T265P_ARROTCOMPETENZE do
    begin
      SQL.Clear;
      SQL.Add('begin');
      SQL.Add('  T265P_ARROTCOMPETENZE(:PROGRESSIVO,:DATA,:CAUSALE,:UMISURA,:TIPO,:COMP1,:COMP2,:COMP3,:COMP4,:COMP5,:COMP6,:COMP_PARZIALI);');
      SQL.Add('end;');
      if T265P_ARROTCOMPETENZE.VariableIndex('COMP_PARZIALI') < 0 then
        DeclareVariable('COMP_PARZIALI',otString);
      SetVariable('PROGRESSIVO',Progressivo);
      SetVariable('DATA',FineCumulo);
      SetVariable('CAUSALE',Q265.FieldByName('CODICE').AsString);
      SetVariable('UMISURA',UMisura);
      SetVariable('TIPO','COMPETENZE');
      SetVariable('COMP_PARZIALI',R180SommaArray(CompetenzeParziali));
      for i:=1 to 6 do
        SetVariable('COMP' + IntToStr(i),Competenze[i]);
      try
        Execute;
        for i:=1 to 6 do
          Competenze[i]:=GetVariable('COMP' + IntToStr(i));
      except
        SQL.Clear;
        SQL.Add('begin');
        SQL.Add('  T265P_ARROTCOMPETENZE(:PROGRESSIVO,:DATA,:CAUSALE,:UMISURA,:TIPO,:COMP1,:COMP2,:COMP3,:COMP4,:COMP5,:COMP6);');
        SQL.Add('end;');
        DeleteVariable('COMP_PARZIALI');
        try
          Execute;
          for i:=1 to 6 do
            Competenze[i]:=GetVariable('COMP' + IntToStr(i));
        except
        end;
      end;
    end;
  ArrotondaCompetenze(Competenze);
  ArrotondaCompetenze(CompetenzeParziali);
  TrasferisciCompetenze(Competenze,CompetenzeOri,False);

  if TipoCumulo in ['I','O'] then
  begin
    if LetturaAssenze then
      FineCumulo:=AData
    else
      FineCumulo:=DataInizio - 1;
  end;
end;

procedure TR600DtM1.GetPeriodiRapporto_PartTime;
var N1,N2,i,j:Integer;
begin
  //Lettura part-time e periodi di rapporto
  with selPartTime do
  begin
    //Alberto 20/06/2006: rilettura part-time solo se sono cambiati i dati
    if (GetVariable('Inizio') <> InizioCumuloIntero) or
       (GetVariable('Fine') <> FineCumuloIntero) then
    begin
      Close;
      SetVariable('Inizio',InizioCumuloIntero);
      SetVariable('Fine',FineCumuloIntero);
    end;
    Open;
    First;
    SetLength(ProfPartTime,0);
    N1:=0;
    N2:=0;
    while not Eof do
    begin
      if Pos(FieldByName('Tipo').AsString,Q265.FieldByName('PartTime').AsString) > 0 then
        if (UMisura = 'G') and (not FieldByName('AssenzeGG').IsNull) or
           (UMisura = 'O') and (not FieldByName('AssenzeHH').IsNull) then
        begin
          SetLength(ProfPartTime,N1 + 1);
          if UMisura = 'G' then
            ProfPartTime[N1].Percentuale:=FieldByName('AssenzeGG').AsFloat
          else
            ProfPartTime[N1].Percentuale:=FieldByName('AssenzeHH').AsFloat;
         ProfPartTime[N1].ValidoDal:=FieldByName('DataDecorrenza').AsDateTime;
         ProfPartTime[N1].ValidoAl:=FieldByName('DataFine').AsDateTime;
         if ProfPartTime[N1].ValidoDal < InizioCumuloIntero then
           ProfPartTime[N1].ValidoDal:=InizioCumuloIntero;
         if ProfPartTime[N1].ValidoAl > FineCumuloIntero then
           ProfPartTime[N1].ValidoAl:=FineCumuloIntero;
         inc(N1);
        end;
      if not RapportoCorrente.Esiste then
      begin
        SetLength(RapportoCorrente.Rapporto,N2 + 1);
        RapportoCorrente.Rapporto[N2].Inizio:=FieldByName('Inizio').AsDateTime;
        if FieldByName('Fine').IsNull then
          RapportoCorrente.Rapporto[N2].Fine:=StrToDate(DataFine)
        else
          RapportoCorrente.Rapporto[N2].Fine:=FieldByName('Fine').AsDateTime;
        inc(N2);
      end;
      Next;
    end;
  end;
  //Accorpamento percentuali di part-time
  i:=0;
  while True do
  begin
    if i >= High(ProfPartTime) then
      Break;
    if ((ProfPartTime[i].ValidoAl + 1) = ProfPartTime[i + 1].ValidoDal) and
        (ProfPartTime[i].Percentuale = ProfPartTime[i + 1].Percentuale) then
    begin
      ProfPartTime[i].ValidoAl:=ProfPartTime[i + 1].ValidoAl;
      for j:=i + 1 to High(ProfPartTime) - 1 do
        ProfPartTime[j]:=ProfPartTime[j + 1];
      SetLength(ProfPartTime,High(ProfPartTime));
    end
    else
      inc(i);
  end;
  //Accorpamento periodi di rapporto
  i:=0;
  while True do
  begin
    if i >= High(RapportoCorrente.Rapporto) then
      Break;
    if (RapportoCorrente.Rapporto[i].Inizio = RapportoCorrente.Rapporto[i + 1].Inizio) then
    begin
      for j:=i + 1 to High(RapportoCorrente.Rapporto) - 1 do
        RapportoCorrente.Rapporto[j]:=RapportoCorrente.Rapporto[j + 1];
      SetLength(RapportoCorrente.Rapporto,High(RapportoCorrente.Rapporto));
    end
    else
      inc(i);
  end;
end;

procedure TR600DtM1.ProporzionaCompetenzePeriodiRapporto;
{Proporzionamento competenze in base al numero di giorni di servizio all'interno del periodo di cumulo}
var i,GGServizio,GGCumulo:Integer;
begin
  VariazionePeriodiRapporto:=GetTotCompetenze;
  GGCumulo:=Trunc(FineCumuloIntero - InizioCumuloIntero + 1);
  if GGCumulo = 0 then exit;
  GGServizio:=0;
  for i:=0 to High(RapportoCorrente.Rapporto) do
  begin
    if RapportoCorrente.Rapporto[i].Inizio < InizioCumuloIntero then
      RapportoCorrente.Rapporto[i].Inizio:=InizioCumuloIntero;
    if RapportoCorrente.Rapporto[i].Fine > FineCumuloIntero then
      RapportoCorrente.Rapporto[i].Fine:=FineCumuloIntero;
    inc(GGServizio,Max(0,Trunc(RapportoCorrente.Rapporto[i].Fine - RapportoCorrente.Rapporto[i].Inizio + 1)));
  end;
  for i:=1 to 6 do
    if EsisteResiduo and (not FineResiduo) then
      //Se esistono i residui proporziono solo la parte corrente
      Competenze[i]:=ResiduiVal[i] + ((Competenze[i] - ResiduiVal[i]) * GGServizio / GGCumulo)
    else
      Competenze[i]:=Competenze[i] * GGServizio / GGCumulo;
  //Proporziono Fruizione Minima Anno Corrente              //Lorena 29/12/2005
  if FruizMinimaAC > 0 then
    FruizMinimaAC:=FruizMinimaAC * GGServizio / GGCumulo;
  VariazionePeriodiRapporto:=VariazionePeriodiRapporto - GetTotCompetenze;
end;

procedure TR600DtM1.ProporzionaCompetenzeTipoRapporto;
var i,xx,GS:Integer;
    Arr:Real;
    TR:String;
begin
  with GetGiorniServizio do
  begin
    if (GetVariable('Prog') <> Progressivo) or
       (GetVariable('InizioCumulo') <> InizioCumulo) or
       (GetVariable('FineCumulo') <> FineCumulo) or
       (GetVariable('Raggrup') <> Giustificativo.Raggruppamento) then
    begin
      SetVariable('Prog',Progressivo);
      SetVariable('InizioCumulo',InizioCumulo);
      SetVariable('FineCumulo',FineCumulo);
      SetVariable('Raggrup',Giustificativo.Raggruppamento);
      Execute;
    end;
    TR:=VarAsType(GetVariable('TR'),varString);
    if TR = 'TI' then exit;
    GS:=VarAsType(GetVariable('GS'),varInteger);
    InizioCumulo:=GetVariable('InizioCumulo');
    InizioCumuloIntero:=InizioCumulo;
  end;
  //Proporzionamento competenze per tempo determinato
  for xx:=Low(Competenze) to High(Competenze) do
    if Riduzioni[xx] <> 0 then
      Competenze[xx]:=0;
  if (Q265.FieldByName('UM_INSERIMENTO_MG').AsString = 'S') then
    Arr:=0.5
  else
    Arr:=1;
  if GS > 120 then
  begin
    for i:=1 to 6 do
      if Riduzioni[i] = 100 then
        Competenze[i]:=R180Arrotonda(GS / 2,Arr,'P-')
      else if Riduzioni[i] = 90 then
        Competenze[i]:=R180Arrotonda(GS / 6,Arr,'P-')
      else if Riduzioni[i] = 50 then
        Competenze[i]:=R180Arrotonda(GS / 3,Arr,'P-');
  end
  else if (GS >= 31) and (GS <= 120) then
  begin
    for i:=1 to 6 do
      if Riduzioni[i] = 100 then
        Competenze[i]:=60
      else if Riduzioni[i] = 90 then
        Competenze[i]:=R180Arrotonda(max(0,(1 - ((60 - GS/2) / (GS/2)))) * (GS / 6),Arr,'P-')
      else if Riduzioni[i] = 50 then
        Competenze[i]:=R180Arrotonda(max(0,(1 - ((60 - GS/2) / (GS/2)))) * (GS / 3),Arr,'P-');
  end
  else
    for i:=1 to 6 do
      if Riduzioni[i] = 100 then
        Competenze[i]:=30;
end;

procedure TR600DtM1.ProporzionaCompetenzePartTime;
{Proporzionamento competenze in base ad ogni periodo di PartTime (Percentuale e validità)}
var i,j,xx,GGPt,TotGGPt,GGCumulo:Integer;
    CompPT:array [1..6] of Real;
    D1,D2:TDateTime;
    CompTotI,CompTotP:Real;
begin
  VariazionePartTime:=GetTotCompetenze;
  //Salvataggio delle competenze intere da proporzionare    //Lorena 29/12/2005
  CompTotI:=0;
  for i:=1 to 6 do
    CompTotI:=CompTotI + Competenze[i];
  //Definizione del periodo di validità: se si considerano i rapporti separati,
  //le competenze sono già riferite al periodo di servizio corrente, per cui anche le proporzioni
  //del part-time devono riferirisi al solo periodo di servizio
  if (RapportoCorrente.Esiste) (*and (ProfiloAssenze <> '')*) then
  begin
    D1:=Max(InizioCumuloIntero,RapportoCorrente.Rapporto[0].Inizio);
    D2:=Min(FineCumuloIntero,RapportoCorrente.Rapporto[0].Fine);
  end
  else
  begin
    D1:=InizioCumuloIntero;
    D2:=FineCumuloIntero;
  end;
  if RapportoCorrente.Esiste or (ProfiloAssenze = '') then
    GGCumulo:=Trunc(D2 - D1 + 1)
  else
  begin
    GGCumulo:=0;
    for i:=1 to NumProfili do
      inc(GGCumulo,Trunc(ProfAssenze[i].ValidoAl - ProfAssenze[i].ValidoDal) + 1);
  end;
  if GGCumulo = 0 then exit;
  for xx:=Low(CompPT) to High(CompPT) do CompPT[xx]:=0;
  TotGGPt:=0;
  for i:=0 to High(ProfPartTime) do
  begin
    //Considero il periodo di part-time all'interno del periodo di cumulo valido
    if RapportoCorrente.Esiste or (ProfiloAssenze = '') then
      GGPt:=Max(0,Trunc(Min(ProfPartTime[i].ValidoAl,D2) - Max(ProfPartTime[i].ValidoDal,D1) + 1))
    else
    begin
      GGPt:=0;
      for j:=1 to NumProfili do
        inc(GGPt,Max(0,Trunc(Min(ProfPartTime[i].ValidoAl,ProfAssenze[j].ValidoAl) -
                             Max(ProfPartTime[i].ValidoDal,ProfAssenze[j].ValidoDal)) + 1));
    end;
    inc(TotGGPt,GGPt);
    for j:=1 to 6 do
      CompPT[j]:=CompPT[j] + ((Competenze[j] - ResiduiVal[j]) * ProfPartTime[i].Percentuale / 100) * GGPt / GGCumulo;
  end;
  (*Alle competenze proporzionate aggiungo i periodi non coperti da part-time
  proporzionati al numero di giorni non coperti (part-time nullo o del tipo non richiesto)*)
  for i:=1 to 6 do
    Competenze[i]:=ResiduiVal[i] + CompPT[i] + ((Competenze[i] - ResiduiVal[i]) * (GGCumulo - TotGGPt) / GGCumulo);
  //Salvataggio delle competenze proporzionate        //Lorena 29/12/2005
  CompTotP:=0;
  for i:=1 to 6 do
    CompTotP:=CompTotP + Competenze[i];
  //Proporziono Fruizione Minima Anno Corrente         //Lorena 29/12/2005
  if (FruizMinimaAC > 0) and (CompTotP <> 0) and (CompTotI <> 0) then
    FruizMinimaAC:=(CompTotP * FruizMinimaAC) / CompTotI;
  //Proporzione sulle competenze parziali (come sopra ma riferito a CompetenzeParziali anzichè a Competenze)
  if AData < D2 then
    D2:=AData;
  GGCumulo:=Trunc(D2 - D1 + 1);
  if GGCumulo <  0 then
    GGCumulo:=0;
  if GGCumulo = 0 then exit;
  for xx:=Low(CompPT) to High(CompPT) do CompPT[xx]:=0;
  TotGGPt:=0;
  for i:=0 to High(ProfPartTime) do
  begin
    GGPt:=Max(0,Trunc(Min(ProfPartTime[i].ValidoAl,D2) - Max(ProfPartTime[i].ValidoDal,D1) + 1));
    inc(TotGGPt,GGPt);
    for j:=1 to 6 do
      CompPT[j]:=CompPT[j] + (CompetenzeParziali[j] * ProfPartTime[i].Percentuale / 100) * GGPt / GGCumulo;
  end;
  (*Alle competenze proporzionate aggiungo i periodi non coperti da part-time
  proporzionati al numero di giorni non coperti (part-time nullo o del tipo non richiesto)*)
  for i:=1 to 6 do
    CompetenzeParziali[i]:=CompPT[i] + (CompetenzeParziali[i] * (GGCumulo - TotGGPt) / GGCumulo);
  VariazionePartTime:=VariazionePartTime - GetTotCompetenze;
end;

procedure TR600DtM1.ProporzionaResiduiPartTime(Data:TDateTime; var PTPrec:TProfPartTime; Arrotonda:Boolean);
var i:Integer;
    Trov:Boolean;
    Perc:Real;
begin
  if (Q265.FieldByName('Tipo_Proporzione').AsString <> 'R') or (Q265.FieldByName('PartTime').AsString = 'N') then
    exit;
  VariazionePartTime:=GetTotCompetenze;
  //Gestisco la proprozione solo se è cambiato il profilo
  if (Data >= PTPrec.ValidoDal) and (Data <= PTPrec.ValidoAl) then
  begin
    if Arrotonda then
      for i:=1 to 6 do
        if UMisura = 'G' then
          Competenze[i]:=R180Arrotonda(Competenze[i],0.5,'P-')
        else
          Competenze[i]:=R180Arrotonda(Competenze[i],1,'P-');
    TrasferisciCompetenze(Competenze,CompetenzeOri,False);
    VariazionePartTime:=VariazionePartTime - GetTotCompetenze;
    exit;
  end;
  Perc:=PTPrec.Percentuale;
  Trov:=False;
  for i:=0 to High(ProfPartTime) do
  begin
    if (Data >= ProfPartTime[i].ValidoDal) and (Data <= ProfPartTime[i].ValidoAl) then
    begin
      PTPrec:=ProfPartTime[i];
      Trov:=True;
      Break;
    end;
    //Periodo non definito
    if Data < ProfPartTime[i].ValidoDal then
    begin
      if i = 0 then
        PTPrec.ValidoDal:=InizioCumulo
      else
        PTPrec.ValidoDal:=ProfPartTime[i - 1].ValidoAl + 1;
      PTPrec.ValidoAl:=ProfPartTime[i].ValidoDal - 1;
      PTPrec.Percentuale:=100;
      Trov:=True;
      Break;
    end;
  end;
  //Ultimo periodo non definito
  if not Trov then
  begin
    if Length(ProfPartTime) = 0 then
      PTPrec.ValidoDal:=InizioCumulo
    else
      PTPrec.ValidoDal:=ProfPartTime[High(ProfPartTime)].ValidoAl + 1;
    PTPrec.ValidoAl:=FineCumulo;
    PTPrec.Percentuale:=100;
  end;
  ValorizzaOreinGiorni;
  if EsisteMaxFasce then
  begin
    SottraiCompetenze(Competenze,GiorniTot,OreTot,Date,False);  //La data non è significativa
    for i:=1 to 6 do
      Competenze[i]:=Competenze[i] * PTPrec.Percentuale / Perc;
    if Arrotonda then
      for i:=1 to 6 do
        if UMisura = 'G' then
          Competenze[i]:=R180Arrotonda(Competenze[i],0.5,'P-')
        else
          Competenze[i]:=R180Arrotonda(Competenze[i],1,'P-');
    //Proporziono Fruizione Minima Anno Corrente                  //Lorena 29/12/2005
    if FruizMinimaAC > 0 then
    begin
      FruizMinimaAC:=FruizMinimaAC * PTPrec.Percentuale / Perc;
      if Arrotonda then
        if UMisura = 'G' then
          FruizMinimaAC:=R180Arrotonda(FruizMinimaAC,0.5,'P-')
        else
          FruizMinimaAC:=R180Arrotonda(FruizMinimaAC,1,'P-');
    end;
  end;
  TrasferisciCompetenze(Competenze,CompetenzeOri,False);
  OreTot:=0;
  GiorniTot:=0;
  OreUni:=0;
  GiorniUni:=0;
  VariazionePartTime:=VariazionePartTime - GetTotCompetenze;
end;

procedure TR600DtM1.ProporzionaAbilitazioneAnagrafica;  //Lorena 16/01/2006
{Proporzionamento competenze in base all'abilitazione della causale sulla scheda anagrafica}
var i,GGNonAbil,GGServizio,GGCumulo:Integer;
  Fine,Inizio:TDateTime;
  D1,D2:TDateTime;
begin
  VariazioneAbilitazioneAnagrafica:=GetTotCompetenze;
  GGNonAbil:=0;
  if RapportoCorrente.Esiste (*and (ProfiloAssenze <> '')*) then
  begin
    D1:=Max(InizioCumuloIntero,RapportoCorrente.Rapporto[0].Inizio);
    D2:=Min(FineCumuloIntero,RapportoCorrente.Rapporto[0].Fine);
  end
  else
  begin
    D1:=InizioCumuloIntero;
    D2:=FineCumuloIntero;
  end;
  with Q430 do
  begin
    //Ciclo sui periodi storici che intersecano il periodo di cumulo
    //Alberto 20/06/2006: rileggo l'anagrafico solo se sono cambiati i dati
    if (GetVariable('Data1') <> D1) or (GetVariable('Data2') <> D2) then
    begin
      Close;
      SetVariable('Data1',D1);
      SetVariable('Data2',D2);
    end;
    Open;
    First;
    while not Eof do
    begin
      //Se il dip. è in servizio nel periodo di cumulo
      (*if (FieldByName('INIZIO').AsDateTime <= D1) and
         ((FieldByName('FINE').IsNull) or (FieldByName('FINE').AsDateTime >= D2)) then*)
        //Se causale non è abilitata tolgo i gg. di servizio non abilitati
        with TStringList.Create do
        begin
          CommaText:=FieldByName('AbCausale1').AsString;
          if IndexOf(Q265.FieldByName('Codice').AsString) < 0 then  //Assenza non abilitata
          begin
            Inizio:=Max(FieldByName('DATADECORRENZA').AsDateTime,D1);
            Fine:=Min(FieldByName('DATAFINE').AsDateTime,D2);
            inc(GGNonAbil,Max(0,Trunc(Fine - Inizio + 1)));
          end;
          Free;
        end;
      Next;
    end;
  end;
  GGCumulo:=Trunc(D2 - D1 + 1);
  if GGCumulo = 0 then
  begin
    VariazioneAbilitazioneAnagrafica:=VariazioneAbilitazioneAnagrafica - GetTotCompetenze;
    exit;
  end;
  GGServizio:=GGCumulo - GGNonAbil;
  for i:=1 to 6 do
    Competenze[i]:=Competenze[i] * GGServizio / GGCumulo;
  //Proporziono Fruizione Minima Anno Corrente              //Lorena 29/12/2005
  if FruizMinimaAC > 0 then
    FruizMinimaAC:=FruizMinimaAC * GGServizio / GGCumulo;
  VariazioneAbilitazioneAnagrafica:=VariazioneAbilitazioneAnagrafica - GetTotCompetenze;
end;

procedure TR600DtM1.CalcolaCumuli(PropResid:Boolean);
{Leggo tutte le assenze del periodo interessato e ne cumulo il valore}
var i:Integer;
    Q:TOracleDataSet;
    PrgConiuge:LongInt;
    S,Ragg:String;
    UsaCausGiustif,UsaCausGiustifOn:Boolean;
    PTPrec:TProfPartTime;
    ConteggiOld:TConteggiOld;
begin
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  // azzera i totali fruizioni di mezze giornate (mattine e pomeriggi)
  FruizMGMat:=0;
  FruizMGPom:=0;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

  //Setto i parametri alla query per estrarre le causali collegate nel periodo interessato
  PrgConiuge:=0;
  S:='';
  for i:=0 to LCausCollegate.Count - 1 do
  begin
    if S <> '' then
      S:=S + ',';
    S:=S + '''' + LCausCollegate[i] + '''';
  end;
  Q:=AssenzeCollettive;
  Q.DeleteVariables;
  Q.DeclareVariable('DATA1',otDate);
  Q.DeclareVariable('DATA2',otDate);
  Q.DeclareVariable('RAGGRUPPAMENTO',otString);
  if Q265.FieldByName('CUMULOGLOBALE').AsString  = 'N' then
  begin
    //Cumulo singolo
    Q.SQL.Clear;
    Q.SQL.Add('SELECT');
    if R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D'] then
      Q.SQL.Add('/*+ INDEX(T040_GIUSTIFICATIVI T040_DATANAS)*/')
    else
      Q.SQL.Add('/*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/');
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    //Q.SQL.Add('T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE,T040.TIPOGIUST,T040.DAORE,T040.AORE,T040.ID_RICHIESTA FROM');
    Q.SQL.Add('T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE,T040.TIPOGIUST,T040.CSI_TIPO_MG,T040.DAORE,T040.AORE,T040.ID_RICHIESTA FROM');
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    Q.SQL.Add('T040_GIUSTIFICATIVI T040,T265_CAUASSENZE T265');
    Q.SQL.Add('WHERE');
    Q.SQL.Add('T040.PROGRESSIVO = :PROGRESSIVO AND');
    Q.SQL.Add('T040.DATA BETWEEN :DATA1 AND :DATA2 AND');
    //Q.SQL.Add('T050F_REVOCATA(T040.ID_RICHIESTA) = ''N'' AND');
    //Q.SQL.Add('exists (select ''X'' from dual where T050F_REVOCATA(T040.ID_RICHIESTA) = ''N'') AND');
    Q.SQL.Add('exists (select ''X'' from dual where T050F_CANCELLATA(T040.ID_RICHIESTA,T040.DATA) = ''N'') AND');
    Q.SQL.Add('T265.CODICE = T040.CAUSALE AND');
    Q.SQL.Add('(T265.CODRAGGR = :RAGGRUPPAMENTO');
    if S <> '' then
      Q.SQL.Add('OR T040.CAUSALE IN(' + S + ')');
    Q.SQL.Add(')');
    if R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D'] then
    begin
      Q.SQL.Add('AND T040.DATANAS = :DATANAS');
      Q.DeclareVariable('DATANAS',otDate);
      Q.SetVariable('DATANAS',RiferimentoDataNascita.Data);
    end;
    Q.SQL.Add('ORDER BY T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE');
    Q.DeclareVariable('PROGRESSIVO',otInteger);
    Q.SetVariable('Progressivo',Progressivo);
  end
  else if Q265.FieldByName('CUMULOGLOBALE').AsString  = 'C' then
  begin
    // cumulo coniuge new.ini
    if R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D'] then
      selConiuge.SetVariable('DATANAS',RiferimentoDataNascita.Data)
    else
      selConiuge.SetVariable('DATANAS',null);
    //Cumulo col coniuge
    selConiuge.Execute;
    PrgConiuge:=StrToIntDef(VarToStr(selConiuge.GetVariable('PROG_CG')),0);
    if VarIsNull(selConiuge.GetVariable('PROG_CG')) then
    // cumulo coniuge new.fine
    begin
      //Coniuge esterno
      Q.SQL.Clear;
      Q.SQL.Add('SELECT');
      if R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D'] then
        Q.SQL.Add('/*+ INDEX(T040_GIUSTIFICATIVI T040_DATANAS)*/')
      else
        Q.SQL.Add('/*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/');
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      //Q.SQL.Add('T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE,T040.TIPOGIUST,T040.DAORE,T040.AORE,''N'' CONIUGE FROM'); //Lorena 3/12/2002
      Q.SQL.Add('T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE,T040.TIPOGIUST,T040.CSI_TIPO_MG,T040.DAORE,T040.AORE,''N'' CONIUGE FROM'); //Lorena 3/12/2002
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
      Q.SQL.Add('T040_GIUSTIFICATIVI T040,T265_CAUASSENZE T265');
      Q.SQL.Add('WHERE');
      Q.SQL.Add('T040.PROGRESSIVO = :PROGRESSIVO AND');
      Q.SQL.Add('T040.DATA BETWEEN :DATA1 AND :DATA2 AND');
      //Q.SQL.Add('T050F_REVOCATA(T040.ID_RICHIESTA) = ''N'' AND');
      //Q.SQL.Add('exists (select ''X'' from dual where T050F_REVOCATA(T040.ID_RICHIESTA) = ''N'') AND');
      Q.SQL.Add('exists (select ''X'' from dual where T050F_CANCELLATA(T040.ID_RICHIESTA,T040.DATA) = ''N'') AND');
      Q.SQL.Add('T265.CODICE = T040.CAUSALE AND');
      Q.SQL.Add('(T265.CODRAGGR = :RAGGRUPPAMENTO');
      if S <> '' then
        Q.SQL.Add('OR T040.CAUSALE IN(' + S + ')');
      Q.SQL.Add(')');
      if R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D'] then
      begin
        Q.SQL.Add('AND T040.DATANAS = :DATANAS');
        Q.DeclareVariable('DATANAS',otDate);
        Q.SetVariable('DATANAS',RiferimentoDataNascita.Data);
      end;
      Q.SQL.Add('UNION ALL');
      Q.SQL.Add('SELECT');
//      Q.SQL.Add('DATA,CAUSALE,TIPOGIUST,TO_DATE(''30121899''||DAORE,''DDMMYYYYHH24.MI''),TO_DATE(''30121899''||AORE,''DDMMYYYYHH24.MI'') FROM');             //Lorena 3/12/2002
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      //Q.SQL.Add('T046.PROGRESSIVO,T046.DATA,T046.CAUSALE,-1,T046.TIPOGIUST,TO_DATE(''30121899''||NVL(T046.DAORE,''00.00''),''DDMMYYYYHH24.MI''),TO_DATE(''30121899''||NVL(T046.AORE,''00.00''),''DDMMYYYYHH24.MI''),''S'' CONIUGE FROM'); //Lorena 3/12/2002
      Q.SQL.Add('T046.PROGRESSIVO,T046.DATA,T046.CAUSALE,-1,T046.TIPOGIUST,null,TO_DATE(''30121899''||NVL(T046.DAORE,''00.00''),''DDMMYYYYHH24.MI''),TO_DATE(''30121899''||NVL(T046.AORE,''00.00''),''DDMMYYYYHH24.MI''),''S'' CONIUGE FROM'); //Lorena 3/12/2002
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
      Q.SQL.Add('T046_GIUSTIFICATIVIFAMILIARI T046,T265_CAUASSENZE T265');
      Q.SQL.Add('WHERE');
      Q.SQL.Add('T046.PROGRESSIVO = :PROGRESSIVO AND');
      Q.SQL.Add('T046.DATA BETWEEN :DATA1 AND :DATA2 AND');
      Q.SQL.Add('T265.CODICE = T046.CAUSALE AND');
      Q.SQL.Add('(T265.CODRAGGR = :RAGGRUPPAMENTO');
      if S <> '' then
        Q.SQL.Add('OR T046.CAUSALE IN(' + S + ')');
      Q.SQL.Add(')');
      if R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D'] then
        Q.SQL.Add('AND T046.DATANAS = :DATANAS');
      Q.SQL.Add('ORDER BY DATA,CAUSALE,PROGRCAUSALE');
      Q.DeclareVariable('PROGRESSIVO',otInteger);
      Q.SetVariable('Progressivo',Progressivo);
    end
    else
    begin
      //Coniuge interno
      Q.SQL.Clear;
      Q.SQL.Add('SELECT');
      if R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D'] then
        Q.SQL.Add('/*+ INDEX(T040_GIUSTIFICATIVI T040_DATANAS)*/');
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      //Q.SQL.Add('T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE,T040.TIPOGIUST,T040.DAORE,T040.AORE,DECODE(T040.PROGRESSIVO,:PROG1,''N'',:PROG2,''S'') CONIUGE FROM');  //Lorena 3/12/2002
      Q.SQL.Add('T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE,T040.TIPOGIUST,T040.CSI_TIPO_MG,T040.DAORE,T040.AORE,DECODE(T040.PROGRESSIVO,:PROG1,''N'',:PROG2,''S'') CONIUGE FROM');  //Lorena 3/12/2002
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
      Q.SQL.Add('T040_GIUSTIFICATIVI T040,T265_CAUASSENZE T265');
      Q.SQL.Add('WHERE');
      Q.SQL.Add('T040.PROGRESSIVO IN (:PROG1,:PROG2) AND');
      Q.SQL.Add('T040.DATA BETWEEN :DATA1 AND :DATA2 AND');
      //Q.SQL.Add('T050F_REVOCATA(T040.ID_RICHIESTA) = ''N'' AND');
      //Q.SQL.Add('exists (select ''X'' from dual where T050F_REVOCATA(T040.ID_RICHIESTA) = ''N'') AND');
      Q.SQL.Add('exists (select ''X'' from dual where T050F_CANCELLATA(T040.ID_RICHIESTA,T040.DATA) = ''N'') AND');
      Q.SQL.Add('T265.CODICE = T040.CAUSALE AND');
      Q.SQL.Add('(T265.CODRAGGR = :RAGGRUPPAMENTO');
      if S <> '' then
        Q.SQL.Add('OR T040.CAUSALE IN(' + S + ')');
      Q.SQL.Add(')');
      if R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D'] then
      begin
        Q.SQL.Add('AND T040.DATANAS = :DATANAS');
        Q.DeclareVariable('DATANAS',otDate);
        Q.SetVariable('DATANAS',RiferimentoDataNascita.Data);
      end;
      Q.SQL.Add('ORDER BY T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE');
      Q.DeclareVariable('PROG1',otInteger);
      Q.DeclareVariable('PROG2',otInteger);
      Q.SetVariable('PROG1',Progressivo);
      Q.SetVariable('PROG2',PrgConiuge);
    end;
    //selConiugeOld.Close;  //Remmato per impedire letture sempre uguali
  end
  else if Q265.FieldByName('CUMULOGLOBALE').AsString  = 'S' then
  begin
    //Cumulo collettivo
    Q.SQL.Clear;
    if Trim(Q265.FieldByName('CAMPOGLOBALE').AsString) = '' then
    begin
      Q.SQL.Add('SELECT /*+ INDEX(T265_CAUASSENZE T265_CODRAGGR)*/');
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      //Q.SQL.Add('T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE,T040.TIPOGIUST,T040.DAORE,T040.AORE FROM');
      Q.SQL.Add('T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE,T040.TIPOGIUST,T040.CSI_TIPO_MG,T040.DAORE,T040.AORE FROM');
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
      Q.SQL.Add('T040_GIUSTIFICATIVI T040,T265_CAUASSENZE T265');
      Q.SQL.Add('WHERE T040.DATA BETWEEN :DATA1 AND :DATA2 AND ');
      //Q.SQL.Add('T050F_REVOCATA(T040.ID_RICHIESTA) = ''N'' AND');
      //Q.SQL.Add('exists (select ''X'' from dual where T050F_REVOCATA(T040.ID_RICHIESTA) = ''N'') AND');
      Q.SQL.Add('exists (select ''X'' from dual where T050F_CANCELLATA(T040.ID_RICHIESTA,T040.DATA) = ''N'') AND');
      Q.SQL.Add('T265.CODICE = T040.CAUSALE AND');
      Q.SQL.Add('(T265.CODRAGGR = :RAGGRUPPAMENTO');
      if S <> '' then
        Q.SQL.Add('OR T040.CAUSALE IN(' + S + ')');
      Q.SQL.Add(')');
      if R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D'] then
      begin
        Q.SQL.Add('AND T040.DATANAS = :DATANAS');
        Q.DeclareVariable('DATANAS',otDate);
        Q.SetVariable('DATANAS',RiferimentoDataNascita.Data);
      end;
      Q.SQL.Add('ORDER BY T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE');
    end
    else
    begin
      Q430Ragg.Close;
      Q430Ragg.DeleteVariables;
      Q430Ragg.SQL.Clear;
      Q430Ragg.SQL.Add('SELECT '+ Q265.FieldByName('CAMPOGLOBALE').AsString);
      Q430Ragg.SQL.Add('FROM T430_STORICO WHERE PROGRESSIVO = ' + IntToStr(Progressivo));
      Q430Ragg.SQL.Add('AND DATADECORRENZA <= :DATA AND DATAFINE >= :DATA');
      Q430Ragg.DeclareVariable('DATA',otDate);
      Q430Ragg.SetVariable('DATA',AData);
      Q430Ragg.Open;
      Ragg:=Q430Ragg.FieldByName(Q265.FieldByName('CAMPOGLOBALE').AsString).AsString;
      Q430Ragg.Close;
      Q.SQL.Add('SELECT /*+ INDEX(T265_CAUASSENZE CODRAGGR)*/');
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      //Q.SQL.Add('T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE,T040.TIPOGIUST,T040.DAORE,T040.AORE FROM');
      Q.SQL.Add('T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE,T040.TIPOGIUST,T040.CSI_TIPO_MG,T040.DAORE,T040.AORE FROM');
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
      Q.SQL.Add('T040_GIUSTIFICATIVI T040,T265_CAUASSENZE T265,T430_STORICO T430');
      Q.SQL.Add('WHERE T040.DATA BETWEEN :DATA1 AND :DATA2 AND');
      //Q.SQL.Add('T050F_REVOCATA(T040.ID_RICHIESTA) = ''N'' AND');
      //Q.SQL.Add('exists (select ''X'' from dual where T050F_REVOCATA(T040.ID_RICHIESTA) = ''N'') AND');
      Q.SQL.Add('exists (select ''X'' from dual where T050F_CANCELLATA(T040.ID_RICHIESTA,T040.DATA) = ''N'') AND');
      Q.SQL.Add('T430.PROGRESSIVO = T040.PROGRESSIVO AND');
      Q.SQL.Add('T040.DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE AND');
      Q.SQL.Add('T430.' + Q265.FieldByName('CAMPOGLOBALE').AsString + '= :CAMPO AND');
      Q.SQL.Add('T265.CODICE = T040.CAUSALE AND');
      Q.SQL.Add('(T265.CODRAGGR = :RAGGRUPPAMENTO');
      if S <> '' then
        Q.SQL.Add('OR T040.CAUSALE IN(' + S + ')');
      Q.SQL.Add(')');
      if R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D'] then
      begin
        Q.SQL.Add('AND T040.DATANAS = :DATANAS');
        Q.DeclareVariable('DATANAS',otDate);
        Q.SetVariable('DATANAS',RiferimentoDataNascita.Data);
      end;
      Q.SQL.Add('ORDER BY T040.PROGRESSIVO,T040.DATA,T040.CAUSALE,T040.PROGRCAUSALE');
      Q.DeclareVariable('CAMPO',otString);
      Q.SetVariable('CAMPO',Ragg);
    end;
  end;
  with Q do
  begin
    Close;
    if LetturaRiduzioni and (not InizioRiduzioni) and (High(AssenzeConteggiate) >= 0) then
      SetVariable('Data1',AssenzeConteggiate[High(AssenzeConteggiate)].data + 1)
    else
    begin
      SetVariable('Data1',InizioCumulo);
      SetLength(AssenzeConteggiate,0);  //Alberto 15/02/2006
    end;
    SetVariable('Data2',FineCumulo);
    SetVariable('Raggruppamento',Giustificativo.Raggruppamento);
    Open;
    if PropResid then
    begin
      PTPrec.ValidoDal:=InizioCumulo;
      PTPrec.ValidoAl:=InizioCumulo - 1;
      PTPrec.Percentuale:=100;
    end;
    if (LetturaRiduzioni) and (not InizioRiduzioni) then
      for i:=0 to High(AssenzeConteggiate) do
        if AssenzeConteggiate[i].data >= InizioCumulo then
        begin
          if PropResid then
            ProporzionaResiduiPartTime(AssenzeConteggiate[i].data,PTPrec,False);
          SommaAssenza('',-1,i,True,AssenzeConteggiate[i].Tipo);
        end;
    SetLength(AssenzeCumulate,0);
    UsaCausGiustifOn:=False;
    ConteggiOld.Prg:=-1;
    ConteggiOld.Data:=0;
  end;

  (*Caricare tutte le assenze da conteggiare in CDS order by progressivo,data,causale

    Leggo tutte le fruizioni del giorno e le salvo in qualcosa tipo m_tab_giustificativi
    Apporto le variazioni del caso (per es. Giustificativo.Causale<->FieldByName('Causale').AsString)
    Chiamo i conteggi in modo che leggano le assenze da T040 ma sostituiscano/aggiungano quelle passate qui
    I conteggi devono restituire la valorizzazione per ognuna delle fruizioni caricate.
    Si scorre l'array e si effettua il conteggio come ora con SommaAssenza

    La gestione della RettificaCatenaCompetenze dovrebbe annullare tutto l'ultimo giorno anzichè annullare solo l'ultimo elemento....

    Se UMisura = 'G' e ci sono solo fruizioni di Tipo I e M non fare i conteggi?
  *)
  CreaCdsFruizioni;
  while not Q.Eof do
  begin
    //Verifico che causale usare
    UsaCausGiustif:=(RettificaCatenaCompetenze) and
                    (OldGiustif.DataGiust = Q.FieldByName('Data').AsDateTime) and
                    (OldGiustif.Causale = Q.FieldByName('Causale').AsString) and
                    (OldGiustif.DaOre = FormatDateTime('hh.nn',Q.FieldByName('DaOre').AsDateTime)) and
                    (OldGiustif.AOre = FormatDateTime('hh.nn',Q.FieldByName('AOre').AsDateTime)) and
                    (OldGiustif.Modo = R180CarattereDef(Q.FieldByName('TipoGiust').AsString,1,#0)) and
                    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
                    // il dato TipoMG non viene considerato in questa condizione
                    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
                    (OldGiustif.Progrcausale = Q.FieldByName('ProgrCausale').AsInteger);
    if UsaCausGiustif then
      UsaCausGiustifOn:=True;
    cdsFruizioni.Append;
    cdsFruizioni.FieldByName('PROGRESSIVO').AsInteger:=Q.FieldByName('PROGRESSIVO').AsInteger;
    cdsFruizioni.FieldByName('DATA').AsDateTime:=Q.FieldByName('DATA').AsDateTime;
    cdsFruizioni.FieldByName('CAUSALE').AsString:=Q.FieldByName('CAUSALE').AsString;
    cdsFruizioni.FieldByName('CAUSALE_NUOVA').AsString:=IfThen(UsaCausGiustif,Giustificativo.Causale,'');
    cdsFruizioni.FieldByName('PROGRCAUSALE').AsInteger:=Q.FieldByName('PROGRCAUSALE').AsInteger;
    cdsFruizioni.FieldByName('TIPOGIUST').AsString:=Q.FieldByName('TIPOGIUST').AsString;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    cdsFruizioni.FieldByName('CSI_TIPO_MG').AsString:=Q.FieldByName('CSI_TIPO_MG').AsString;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    cdsFruizioni.FieldByName('DAORE').Value:=Q.FieldByName('DAORE').Value;
    cdsFruizioni.FieldByName('AORE').Value:=Q.FieldByName('AORE').Value;
    if Q265.FieldByName('CUMULOGLOBALE').AsString = 'C' then
      cdsFruizioni.FieldByName('CONIUGE').AsString:=Q.FieldByName('CONIUGE').AsString
    else
      cdsFruizioni.FieldByName('CONIUGE').AsString:='N';
    cdsFruizioni.FieldByName('RICHIESTA_WEB').AsString:='';
    cdsFruizioni.Post;
    Q.Next;
  end;

  if RichiesteIterAutorizzativo and (Q265.FindField('CUMULA_RICHIESTE_WEB') <> nil) then
  begin
    // AOSTA_REGIONE - chiamata 75174.ini
    selT050.Close;
    // AOSTA_REGIONE - chiamata 75174.fine
    R180SetVariable(selT050,'PROG1',Progressivo);
    R180SetVariable(selT050,'PROG2',PrgConiuge);
    R180SetVariable(selT050,'DATA1',Q.GetVariable('DATA1'));
    R180SetVariable(selT050,'DATA2',FineCumulo);
    R180SetVariable(selT050,'RAGGRUPPAMENTO',Giustificativo.Raggruppamento);
    R180SetVariable(selT050,'ELENCOCAUSALI',IfThen(S = '','''''',S));
    if R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D'] then
      R180SetVariable(selT050,'DATANAS',RiferimentoDataNascita.Data)
    else
      R180SetVariable(selT050,'DATANAS',null);
    if Q265.FindField('CUMULA_RICHIESTE_WEB') <> nil then
      R180SetVariable(selT050,'RAGGRUPPAMENTO',Giustificativo.Raggruppamento);
    selT050.Open;
    selT050.First;
    while not selT050.Eof do
    begin
      //Scorrimento delle richieste
      begin
        //Scorrimento del periodo
        cdsFruizioni.Append;
        cdsFruizioni.FieldByName('PROGRESSIVO').AsInteger:=selT050.FieldByName('PROGRESSIVO').AsInteger;
        cdsFruizioni.FieldByName('DATA').AsDateTime:=selT050.FieldByName('DATA').AsDateTime;
        cdsFruizioni.FieldByName('CAUSALE').AsString:=selT050.FieldByName('CAUSALE').AsString;
        cdsFruizioni.FieldByName('CAUSALE_NUOVA').AsString:='';
        cdsFruizioni.FieldByName('PROGRCAUSALE').AsInteger:=-1;
        cdsFruizioni.FieldByName('TIPOGIUST').AsString:=selT050.FieldByName('TIPOGIUST').AsString;
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
        cdsFruizioni.FieldByName('CSI_TIPO_MG').AsString:=selT050.FieldByName('CSI_TIPO_MG').AsString;
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
        cdsFruizioni.FieldByName('DAORE').Value:=selT050.FieldByName('DAORE').Value;
        cdsFruizioni.FieldByName('AORE').Value:=selT050.FieldByName('AORE').Value;
        if Q265.FieldByName('CUMULOGLOBALE').AsString  = 'C' then
          cdsFruizioni.FieldByName('CONIUGE').AsString:=selT050.FieldByName('CONIUGE').AsString
        else
          cdsFruizioni.FieldByName('CONIUGE').AsString:='N';
        cdsFruizioni.FieldByName('RICHIESTA_WEB').AsString:=IfThen(selT050.FieldByName('AUTORIZZAZIONE').AsString = 'S','A','R');
        cdsFruizioni.Post;
      end;
      selT050.Next;
    end;
  end;

  if RettificaCatenaCompetenze and (not UsaCausGiustifOn) then
  begin
    cdsFruizioni.Append;
    cdsFruizioni.FieldByName('PROGRESSIVO').AsInteger:=Progressivo;
    cdsFruizioni.FieldByName('DATA').AsDateTime:=OldGiustif.DataGiust;
    cdsFruizioni.FieldByName('CAUSALE').AsString:=OldGiustif.Causale;
    cdsFruizioni.FieldByName('CAUSALE_NUOVA').AsString:=Giustificativo.Causale;
    cdsFruizioni.FieldByName('PROGRCAUSALE').AsInteger:=OldGiustif.ProgrCausale;
    cdsFruizioni.FieldByName('TIPOGIUST').AsString:=OldGiustif.Modo;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    cdsFruizioni.FieldByName('CSI_TIPO_MG').AsString:=OldGiustif.CSITipoMG;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    cdsFruizioni.FieldByName('DAORE').AsDateTime:=StrToTime(OldGiustif.DaOre);
    cdsFruizioni.FieldByName('AORE').AsDateTime:=StrToTime(OldGiustif.AOre);
    cdsFruizioni.FieldByName('CONIUGE').AsString:='N';
    cdsFruizioni.FieldByName('RICHIESTA_WEB').AsString:='';
    cdsFruizioni.Post;
  end;

  RiepQualmin.DebitoGGQM:=0;
  RiepQualmin.NumGiorniSett:=0;
  RiepQualmin.OreSett:=0;
  RiepQualmin.Quantita:=0;
  //UsaCausGiustifOn:=False;//Assegnazione inutile
  SetLength(R502ProDtM1.GiustificativiR600,0);
  with cdsFruizioni do
  begin
    {$IFNDEF MEDP803}
    IndexName:='Secondario';
    First;
    if RecordCount > 0 then
      InizioConteggi:=Min(DaData,FieldByName('DATA').AsDateTime) - 2
    else
      InizioConteggi:=DaData - 2;
    FineConteggi:=Max(FineCumulo,AData) + 2;
    R502ProDtM1.Chiamante:='Assenze';
    R502ProDtM1.PeriodoConteggi(InizioConteggi,FineConteggi);
    if R502ProDtM1.Q040.Active then
      R502ProDtM1.Q040.Close;
    IndexName:='Primario';
    {$ENDIF}
    First;
    while not Eof do
    begin
      //Verifico che causale usare
      if (FieldByName('PROGRESSIVO').AsInteger <> ConteggiOld.Prg) or (FieldByName('DATA').AsDateTime <> ConteggiOld.Data)  then
        ConteggiaGiorno(ConteggiOld,PropResid,PTPrec);
      //Registro il giustificativo in AssenzeCumulate
      SetLength(AssenzeCumulate,Length(AssenzeCumulate) + 1);
      i:=High(AssenzeCumulate);
      AssenzeCumulate[i].DaVisualizzare:=True;
      AssenzeCumulate[i].Data:=FieldByName('Data').AsString;
      AssenzeCumulate[i].DTData:=FieldByName('Data').AsDateTime;
      AssenzeCumulate[i].Causale:=IfThen(FieldByName('CAUSALE_NUOVA').AsString = '',FieldByName('Causale').AsString,FieldByName('CAUSALE_NUOVA').AsString);
      AssenzeCumulate[i].Tipo:=FieldByName('TipoGiust').AsString;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      AssenzeCumulate[i].CSITipoMG:=FieldByName('CSI_TIPO_MG').AsString;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
      AssenzeCumulate[i].Ore:='';
      if not FieldByName('DaOre').IsNull then
        AssenzeCumulate[i].Ore:=FormatDateTime('hh.nn',FieldByName('DaOre').AsDateTime);
      if not FieldByName('AOre').IsNull then
        AssenzeCumulate[i].Ore:=AssenzeCumulate[i].Ore + '-' + FormatDateTime('hh.nn',FieldByName('AOre').AsDateTime);
      AssenzeCumulate[i].Coniuge:=FieldByName('CONIUGE').AsString = 'S'; //Lorena 03/12/2002
      AssenzeCumulate[i].RichiestaWeb:=FieldByName('RICHIESTA_WEB').AsString <> '';
      AddGiustificativiR600(i);
      ConteggiOld.Prg:=FieldByName('PROGRESSIVO').AsInteger;
      ConteggiOld.Data:=FieldByName('DATA').AsDateTime;
      Next;
    end;
  end;
  ConteggiaGiorno(ConteggiOld,PropResid,PTPrec);
  cdsFruizioni.Close;

  if PropResid then
    ProporzionaResiduiPartTime(FineCumulo,PTPrec,True);
  ValorizzaOreInGiorni;
  //Calcolo di quanto fruito dal residuo anno precedente
  if FineResiduo then
    if FruitoAP > TotResiduo then
      FruitoAP:=TotResiduo;
end;

procedure TR600DtM1.CreaCdsFruizioni;
begin
  //carica nel ClientDataset cdsFruizioni le fruizioni di cui fare i conteggi
  cdsFruizioni.Close;
  cdsFruizioni.FieldDefs.Clear;
  cdsFruizioni.FieldDefs.Add('PROGRESSIVO',ftInteger);
  cdsFruizioni.FieldDefs.Add('DATA',ftDate);
  cdsFruizioni.FieldDefs.Add('CAUSALE',ftString,5);
  cdsFruizioni.FieldDefs.Add('CAUSALE_NUOVA',ftString,5);
  cdsFruizioni.FieldDefs.Add('PROGRCAUSALE',ftInteger);
  cdsFruizioni.FieldDefs.Add('TIPOGIUST',ftString,1);
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  cdsFruizioni.FieldDefs.Add('CSI_TIPO_MG',ftString,1);
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  cdsFruizioni.FieldDefs.Add('DAORE',ftDateTime);
  cdsFruizioni.FieldDefs.Add('AORE',ftDateTime);
  cdsFruizioni.FieldDefs.Add('CONIUGE',ftString,1);
  cdsFruizioni.FieldDefs.Add('RICHIESTA_WEB',ftString,1);
  cdsFruizioni.FieldDefs.Add('DEBITOGGQM',ftString,10);
  cdsFruizioni.FieldDefs.Add('NUMGIORNISETT',ftInteger);
  cdsFruizioni.FieldDefs.Add('ORESETT',ftInteger);
  cdsFruizioni.IndexDefs.Clear;
  cdsFruizioni.IndexDefs.Add('Primario','PROGRESSIVO;DATA;CAUSALE',[]);
  cdsFruizioni.IndexDefs.Add('Secondario','DATA',[]);
  cdsFruizioni.IndexName:='Primario';
  cdsFruizioni.CreateDataSet;
  cdsFruizioni.LogChanges:=False;
end;

procedure TR600DtM1.AddGiustificativiR600(puntAssCum:Integer);
var x:Integer;
begin
  x:=Length(R502ProDtM1.GiustificativiR600);
  SetLength(R502ProDtM1.GiustificativiR600,x + 1);
  with R502ProDtM1 do
  begin
    GiustificativiR600[x].causale:=cdsFruizioni.FieldByName('CAUSALE').AsString;
    GiustificativiR600[x].causale_nuova:=cdsFruizioni.FieldByName('CAUSALE_NUOVA').AsString;//IfThen(UsaCausGiustif,Giustificativo.Causale,'');
    GiustificativiR600[x].progrcausale:=cdsFruizioni.FieldByName('PROGRCAUSALE').AsInteger;
    GiustificativiR600[x].tipogiust:=R180CarattereDef(cdsFruizioni.FieldByName('TIPOGIUST').AsString,1,'I');
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    GiustificativiR600[x].tipomg:=cdsFruizioni.FieldByName('CSI_TIPO_MG').AsString;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    GiustificativiR600[x].dalle:=cdsFruizioni.FieldByName('DAORE').AsDateTime;
    GiustificativiR600[x].alle:=cdsFruizioni.FieldByName('AORE').AsDateTime;
    GiustificativiR600[x].hhmmasse:=0;
    GiustificativiR600[x].ggasse:=0;
    GiustificativiR600[x].mezggasse:=0;
    GiustificativiR600[x].minasse:=0;
    GiustificativiR600[x].minvalasse:=0;
    GiustificativiR600[x].minresasse:=0;
    GiustificativiR600[x].puntAssCum:=puntAssCum;
    GiustificativiR600[x].RichiestaWeb:=R180CarattereDef(cdsFruizioni.FieldByName('RICHIESTA_WEB').AsString,1,#0);
  end;
end;

procedure TR600DtM1.ConteggiaGiorno(ConteggiOld:TConteggiOld; PropResid:Boolean; var PTPrec:TProfPartTime);
var x:Integer;
    DebitoGGQM:Integer;
    SoloGG:Boolean;
begin
  if Length(R502ProDtM1.GiustificativiR600) = 0 then
    exit;
  SoloGG:=True;
  R502ProDtM1.Blocca:=0;
  R502ProDtM1.DataCon:=ConteggiOld.Data;
  //Verifico se ci sono solo giornate e mezze giornate per evitare di fare i conteggi nel caso di ValorizzazioneOraria = 0
  for x:=0 to High(R502ProDtM1.GiustificativiR600) do
    if R502ProDtM1.GiustificativiR600[x].tipogiust in ['N','D'] then
    begin
      SoloGG:=False;
      Break;
    end;
  (*Alberto 16/02/2011: remmato perchè ValorizzazioneOraria valeva sempre True!
  if (UMisura = 'G') and SoloGG and (not ValorizzazioneOraria) then
  begin
    for x:=0 to High(R502ProDtM1.GiustificativiR600) do
      if R502ProDtM1.GiustificativiR600[x].tipogiust = 'I' then
        R502ProDtM1.GiustificativiR600[x].ggasse:=1
      else if R502ProDtM1.GiustificativiR600[x].tipogiust = 'M' then
        R502ProDtM1.GiustificativiR600[x].mezggasse:=1;
  end
  else
  *)
  begin
    //Conteggi giornalieri
    R502ProDtM1.ConteggiaGiustificativiR600:=True;
    R502ProDtM1.Conteggi('Cartolina',ConteggiOld.Prg,ConteggiOld.Data);
    R502ProDtM1.ConteggiaGiustificativiR600:=False;
    //Se i conteggi sono bloccati e si tratta di giornate, conteggio manualmente le assenze
    if (R502ProDtM1.Blocca <> 0) and (UMisura = 'G') and SoloGG then
    begin
      R502ProDtM1.Blocca:=0;
      for x:=0 to High(R502ProDtM1.GiustificativiR600) do
        if R502ProDtM1.GiustificativiR600[x].tipogiust = 'I' then
          R502ProDtM1.GiustificativiR600[x].ggasse:=1
        else if R502ProDtM1.GiustificativiR600[x].tipogiust = 'M' then
          R502ProDtM1.GiustificativiR600[x].mezggasse:=1;
    end;
  end;
  //Conteggio effettivo delle assenze
  if R502ProDtM1.Blocca in [0,2] then
    //Ciclo per tutte le fruizioni di quel giorno
    for x:=0 to High(R502ProDtM1.GiustificativiR600) do
    begin
      if PropResid then
        ProporzionaResiduiPartTime(ConteggiOld.Data,PTPrec,False);
      OreConteggiate:=0;
      FruitoSommaAssenza:=0;
      SommaAssenza('',x,High(AssenzeConteggiate) + 1,False,#0);
      if R502ProDtM1.GiustificativiR600[x].puntAssCum >= 0 then
      begin
        AssenzeCumulate[R502ProDtM1.GiustificativiR600[x].puntAssCum].OreConteggiate:=R180MinutiOre(OreConteggiate);
        if R502ProDtM1.GiustificativiR600[x].RichiestaWeb = 'A' then
          ValIterAutorizzato:=ValIterAutorizzato + FruitoSommaAssenza
        else if R502ProDtM1.GiustificativiR600[x].RichiestaWeb = 'R' then
          ValIterRichiesto:=ValIterRichiesto + FruitoSommaAssenza;
      end;
      //Gestione fruizione ai fini della qualifica ministeriale
      try
        DebitoGGQM:=RiepQualMin.DebitoGGQM;
        if (DebitoGGQM = 0) and (RiepQualMin.NumGiorniSett > 0) then
          DebitoGGQM:=Round(RiepQualMin.OreSett/RiepQualMin.NumGiorniSett);
        if DebitoGGQM > 0 then
          RiepQualMin.Quantita:=RiepQualMin.Quantita + ((*OreReseDaAssenza*)R502ProDtM1.GiustificativiR600[x].minresasse / DebitoGGQM);
      except
      end;
    end;
  SetLength(R502ProDtM1.GiustificativiR600,0);
end;

procedure TR600DtM1.ConteggiAssenza(ChiamanteConteggi:String; Data:TDateTime; Causale:String; Tipo:Char; TipoMG:String; DaOre,AOre:TDateTime; Prg:LongInt);
var A,M,G:Word;
    xx:Integer;
begin
  R502ProDtM1.Blocca:=0;
  R502ProDtM1.DataCon:=Data;
  //Non conteggio l'assenza modificata
  if (Data = DaData) and (Causale = OldGiustif.Causale) and (Tipo = OldGiustif.Modo) then
  begin
    if Tipo in ['I','M'] then exit;
    if Tipo = 'N' then
      if TimeToStr(DaOre) = OldGiustif.DaOre then exit;
    if Tipo = 'D' then
      if (TimeToStr(DaOre) = OldGiustif.DaOre) and (TimeToStr(AOre) = OldGiustif.AOre) then exit;
  end;
  //Se sono Giornate o Mezze Giornate e l'unità di misura = Giorni non richiamo i conteggi
  if (UMisura = 'G') and (Tipo in ['I','M']) (*and (not ValorizzazioneOraria)*) then
  begin
    R502ProDtM1.n_riepasse:=1;
    R502ProDtM1.triepgiusasse[1]:=triepgiusasse_vuoto;
    R502ProDtM1.triepgiusasse[1].tcausasse:=Causale;
    if Tipo = 'I' then
      R502ProDtM1.triepgiusasse[1].tggasse:=1
    else
    begin
      R502ProDtM1.triepgiusasse[1].tmezggasse:=1;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      R502ProDtM1.triepgiusasse[1].ttipomg:=TipoMG;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    end;
  end
  else
  begin
    DecodeDate(Data,A,M,G);  //Estraggo il giorno in G
    for xx:=1 to MaxGiustif do R502ProDtM1.m_tab_giustificativi[G,xx]:=tgiustific_vuoto;
    //Carico i dati dell'assenza nella matrice per R500
    if ChiamanteConteggi = 'Assenze' then
    begin
      R502ProDtM1.m_tab_giustificativi[G,1].tcausgius:=Causale;
      R502ProDtM1.m_tab_giustificativi[G,1].tdallegius:=DaOre;
      R502ProDtM1.m_tab_giustificativi[G,1].ttipogius:=Tipo;
      R502ProDtM1.m_tab_giustificativi[G,1].tallegius:=AOre;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      R502ProDtM1.m_tab_giustificativi[G,1].ttipomg:=TipoMG;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    end;
    //R502ProDtM1.Conteggi('Assenze',Prg,Data);
    //R502ProDtM1.Conteggi('Cartolina',Prg,Data);
    R502ProDtM1.Conteggi(ChiamanteConteggi,Prg,Data);  //ChiamanteConteggi è SEMPRE Assenze!!
    //Se i conteggi sono bloccati e si tratta di giornate, conteggio manualmente le assenze
    if (R502ProDtM1.Blocca <> 0) and (UMisura = 'G') and (Tipo in ['I','M']) then
    begin
      R502ProDtM1.Blocca:=0;
      R502ProDtM1.n_riepasse:=1;
      R502ProDtM1.triepgiusasse[1]:=triepgiusasse_vuoto;
      R502ProDtM1.triepgiusasse[1].tcausasse:=Causale;
      if Tipo = 'I' then
        R502ProDtM1.triepgiusasse[1].tggasse:=1
      else
      begin
        R502ProDtM1.triepgiusasse[1].tmezggasse:=1;
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
        R502ProDtM1.triepgiusasse[1].ttipomg:=TipoMG;
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
      end;
    end;
  end;
end;

procedure TR600DtM1.SommaAssenza(CodCaus:String; PuntGiustR600,NA:Integer; Caricato:Boolean; TipoGiust:Char);
var Q,Abb:Real;
    FruizArr,FruizMin,VG,xx:Integer;
    Trovato:Boolean;
  function SommaGiustificativiR600:Boolean;
  var k:Integer;
  begin
    Result:=True;
    k:=PuntGiustR600;
    if k <= High(R502ProDtM1.GiustificativiR600)  then
    begin
      if NA > High(AssenzeConteggiate) then
        SetLength(AssenzeConteggiate,Length(AssenzeConteggiate) + 1);
      NA:=High(AssenzeConteggiate);
      with AssenzeConteggiate[NA] do
      begin
        if R502ProDtM1.GiustificativiR600[k].causale_nuova = '' then
          causale:=R502ProDtM1.GiustificativiR600[k].causale
        else
          causale:=R502ProDtM1.GiustificativiR600[k].causale_nuova;
        tipo:=R502ProDtM1.GiustificativiR600[k].tipogiust;
        data:=R502ProDtM1.datacon;
        tggasse:=R502ProDtM1.GiustificativiR600[k].ggasse;
        tmezggasse:=R502ProDtM1.GiustificativiR600[k].mezggasse;
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
        tipomg:=R502ProDtM1.GiustificativiR600[k].tipomg;
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
        tminresasse:=R502ProDtM1.GiustificativiR600[k].minresasse;
        tminvalasse:=R502ProDtM1.GiustificativiR600[k].minvalasse;
        //Alberto 23/05/2018: CCNL 2018 - Valorizzazione ai fini della fruizione delle competenze
        tminvalcompasse:=R502ProDtM1.GiustificativiR600[k].minvalcompasse;
        //Alberto 03/11/2004: nel caso di assenza che diminuisce le ore,
        //considero i minuti di fruizione e non i minuti resi
        if R502ProDtM1.ValStrT265[causale,'INFLUCONT'] = 'D' then
          tminasse:=R502ProDtM1.GiustificativiR600[k].minasse
        else if R502ProDtM1.ValStrT265[causale,'CUMULO_TIPO_ORE'] = '0' then
          tminasse:=R502ProDtM1.GiustificativiR600[k].minasse
        else
          tminasse:=R502ProDtM1.GiustificativiR600[k].minvalasse;
      end
    end
    else
      Result:=False;
  end;
  function SommaRiepgiusasse:Boolean;
  var i,k:Integer;
  begin
    Result:=True;
    k:=-1;
    for i:=1 to R502ProDtM1.n_riepasse do
     if R502ProDtM1.triepgiusasse[i].tcausasse = CodCaus then
     begin
       k:=i;
       Break;
     end;
    if k > 0 then
    begin
      if NA > High(AssenzeConteggiate) then
        SetLength(AssenzeConteggiate,Length(AssenzeConteggiate) + 1);
      NA:=High(AssenzeConteggiate);
      with AssenzeConteggiate[NA] do
      begin
        causale:=R502ProDtM1.triepgiusasse[k].tcausasse;
        tipo:=TipoGiust;
        data:=R502ProDtM1.datacon;
        tggasse:=R502ProDtM1.triepgiusasse[k].tggasse;
        tmezggasse:=R502ProDtM1.triepgiusasse[k].tmezggasse;
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
        tipomg:=R502ProDtM1.triepgiusasse[k].ttipomg;
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
        tminresasse:=R502ProDtM1.triepgiusasse[k].tminresasse;
        tminvalasse:=R502ProDtM1.triepgiusasse[k].tminvalasse;
        //Alberto 23/05/2018: CCNL 2018 - Valorizzazione ai fini della fruizione delle competenze
        tminvalcompasse:=R502ProDtM1.triepgiusasse[k].tminvalcompasse;
        //Alberto 03/11/2004: nel caso di assenza che diminuisce le ore,
        //considero i minuti di fruizione e non i minuti resi
        if R502ProDtM1.ValStrT265[causale,'INFLUCONT'] = 'D' then
          tminasse:=R502ProDtM1.triepgiusasse[k].tminasse
        else if R502ProDtM1.ValStrT265[causale,'CUMULO_TIPO_ORE'] = '0' then
          tminasse:=R502ProDtM1.triepgiusasse[k].tminasse
        else
          tminasse:=R502ProDtM1.triepgiusasse[k].tminvalasse;
      end
    end
    else
      Result:=False;
  end;
begin
  VG:=0;
  OreConteggiate:=0;
  if not Caricato then
  begin
    if (CodCaus = '') and (PuntGiustR600 >= 0) then
      Trovato:=SommaGiustificativiR600
    else
      Trovato:=SommaRiepGiusasse;
    if not Trovato then
      exit;
  end;
  inc(OreReseDaAssenza,AssenzeConteggiate[NA].tminresasse);
  //Assenza a Giornata o Mezza giornata
  if AssenzeConteggiate[NA].Tipo in ['I','M'] then
  begin
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    if AssenzeConteggiate[NA].tipomg = 'M' then
      FruizMGMat:=FruizMGMat + AssenzeConteggiate[NA].tmezggasse
    else if AssenzeConteggiate[NA].tipomg = 'P' then
      FruizMGPom:=FruizMGPom + AssenzeConteggiate[NA].tmezggasse;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    if UMisura = 'G' then
      //Conto Giornate e mezze giornate
    begin
      Q:=AssenzeConteggiate[NA].tggasse + (AssenzeConteggiate[NA].tmezggasse / 2);
      //Gestione di FruitoCompPrec: scalo le fruizioni che non sono riferite a queste competenze
      Abb:=Min(FruitoCompPrec,Q);
      Q:=Q - Abb;
      FruitoCompPrec:=FruitoCompPrec - Abb;
      if (Q = 0) and (Length(AssenzeCumulate) > 0) then
      begin
        if (CodCaus = '') and (PuntGiustR600 >= 0) then
        begin
          if R502ProDtM1.GiustificativiR600[PuntGiustR600].puntAssCum >= 0 then
            AssenzeCumulate[R502ProDtM1.GiustificativiR600[PuntGiustR600].puntAssCum].DaVisualizzare:=False;
        end
        else
          SetLength(AssenzeCumulate,Length(AssenzeCumulate) - 1);
      end;
      //Cumulo totale
      GiorniTot:=GiorniTot + Q;
      //Cumulo unitario
      if AssenzeConteggiate[NA].Causale = Giustificativo.Causale then
        GiorniUni:=GiorniUni + Q;
      //Fruito nel giorno corrente
      if AssenzeConteggiate[NA].Data = DaData then
        FruitoCorrGG:=Q;
      //Fruizione singola per visualizzare nel web le fruizioni richieste e autorizzate
      FruitoSommaAssenza:=Q;
      //Fruito dal residuo anno precedente
      if FineResiduo and (AssenzeConteggiate[NA].Data <= LimiteResiduo) then
        FruitoAP:=FruitoAP + Q;
      if (AssenzeConteggiate[NA].Data >= InizioFruizForzataAC) and (FruitoForzatoAC < FruizMinimaAC) then
        FruitoForzatoAC:=FruitoForzatoAC + Q;
    end
    else
      //Conto Giornate e mezze giornate valorizzate in ore
    begin
      if False then
        Q:=AssenzeConteggiate[NA].tminvalasse
      else
        Q:=AssenzeConteggiate[NA].tminvalcompasse;
      //Gestione di FruitoCompPrec: scalo le fruizioni che non sono riferite a queste competenze
      Abb:=Min(FruitoCompPrec,Q);
      Q:=Q - Abb;
      FruitoCompPrec:=FruitoCompPrec - Abb;
      if (Q = 0) and (Length(AssenzeCumulate) > 0) then
      begin
        if (CodCaus = '') and (PuntGiustR600 >= 0) then
        begin
          if R502ProDtM1.GiustificativiR600[PuntGiustR600].puntAssCum >= 0 then
            AssenzeCumulate[R502ProDtM1.GiustificativiR600[PuntGiustR600].puntAssCum].DaVisualizzare:=False;
        end
        else
          SetLength(AssenzeCumulate,Length(AssenzeCumulate) - 1);
      end;
      OreTot:=OreTot + Trunc(Q);
      if AssenzeConteggiate[NA].Causale = Giustificativo.Causale then
      begin
        OreUni:=OreUni + Trunc(Q);
        if AssenzeConteggiate[NA].Data = AData then
          GiornataOre:=Trunc(Q);
      end;
      //Fruito nel giorno corrente
      if AssenzeConteggiate[NA].Data = DaData then
        FruitoCorrHH:=Trunc(Q);
      //Fruito dal residuo anno precedente
      if FineResiduo and (AssenzeConteggiate[NA].Data <= LimiteResiduo) then
        FruitoAP:=FruitoAP + Trunc(Q);
      if (AssenzeConteggiate[NA].Data >= InizioFruizForzataAC) and (FruitoForzatoAC < FruizMinimaAC) then
        FruitoForzatoAC:=FruitoForzatoAC + Trunc(Q);
      OreConteggiate:=Trunc(Q);
    end;
  end
  else
    //Assenza Da ore-A ore / Numero ore
    if (UMisura = 'O') or (ValenzaGiornaliera > 0) then
    begin
      Q:=AssenzeConteggiate[NA].tminasse;
      //>> GENOVA_COMUNE
      //Arr:=R180OreMinutiExt(VarToStr(Q265.Lookup('CODICE',AssenzeConteggiate[NA].causale,'FRUIZCOMPETENZE_ARR')));
      FruizArr:=0;
      if VarToStr(Q265.Lookup('CODICE',AssenzeConteggiate[NA].causale,'FRUIZCOMPETENZE_ARR')) = 'S' then
      begin
        FruizArr:=R180OreMinutiExt(VarToStr(Q265.Lookup('CODICE',AssenzeConteggiate[NA].causale,'FRUIZ_ARR')));
        if (Q > 0) and (Parametri.ModuloInstallato['TORINO_CSI_PRV']) then
        begin
          //Verfico che la fruizione sia almeno il minimo richiesto
          FruizMin:=R180OreMinutiExt(VarToStr(Q265.Lookup('CODICE',AssenzeConteggiate[NA].causale,'FRUIZ_MIN')));
          Q:=max(Q,FruizMin);
        end;
      end;
      if FruizArr > 1 then
        Q:=R180Arrotonda(Q,FruizArr,'E')
      else if FruizArr < -1 then
        Q:=R180Arrotonda(Q,abs(FruizArr),'D');
      //<< GENOVA_COMUNE
      //Gestione di FruitoCompPrec: scalo le fruizioni che non sono riferite a queste competenze
      Abb:=Min(FruitoCompPrec,Q);
      Q:=Q - Abb;
      FruitoCompPrec:=FruitoCompPrec - Abb;
      if Length(AssenzeCumulate) > 0 then
      begin
        if Q = 0 then  //Assenza da non visualizzare tra quelle cumulate
        begin
          if (CodCaus = '') and (PuntGiustR600 >= 0) then
          begin
            if R502ProDtM1.GiustificativiR600[PuntGiustR600].puntAssCum >= 0 then
              AssenzeCumulate[R502ProDtM1.GiustificativiR600[PuntGiustR600].puntAssCum].DaVisualizzare:=False
          end
          else
            SetLength(AssenzeCumulate,Length(AssenzeCumulate) - 1);
        end
        else if Abb <> 0 then  //Aggiorno la quantità oraria
        begin
          if (CodCaus = '') and (PuntGiustR600 >= 0) then
            xx:=R502ProDtM1.GiustificativiR600[PuntGiustR600].puntAssCum
          else
            xx:=High(AssenzeCumulate);
          if (xx >= 0) and (AssenzeCumulate[xx].Ore <> '') then
            //AssenzeCumulate[xx].Ore:=R180MinutiOre(Trunc(Q));
            AssenzeCumulate[xx].OreConteggiate:=R180MinutiOre(Trunc(Q));
        end;
      end;

      if UMisura = 'G' then
      begin
        (*
        if not VarIsNull(Q265.Lookup('CODICE',AssenzeConteggiate[NA].causale,'HMASSENZA')) then
          VG:=R180OreMinuti(Q265.Lookup('CODICE',AssenzeConteggiate[NA].causale,'HMASSENZA'));
        *)
        //Leggo la valorizzazione giornaliera della causale (01/06/2018: storicizzata e proprozionata per part-time Orizz.)
        VG:=GetHMAssenza(Progressivo,AssenzeConteggiate[NA].data,AssenzeConteggiate[NA].causale);
        if VG = 0 then
          with GetCalend do
          begin
            if (GetVariable('Prog') <> Progressivo) or (GetVariable('D') <> AssenzeConteggiate[NA].Data) then
            begin
              SetVariable('Prog',Progressivo);
              SetVariable('D',AssenzeConteggiate[NA].Data);
              Execute;
            end;
            if (VarToStr(GetVariable('L')) = '') and (VarToStr(GetVariable('F')) = '') and (GetVariable('G') = 0) then
              VG:=0
            else
              try
                VG:=R180OreMinutiExt(GetVariable('MONTEORE')) div GetVariable('G');
              except
                VG:=0;
              end;
          end;
        if VG <> 0 then
        begin
          //Ogni spezzone orario rende una frazione della giornata intera
          GiorniTot:=GiorniTot + (Q/VG);
          if AssenzeConteggiate[NA].Causale = Giustificativo.Causale then
            GiorniUni:=GiorniUni + (Q/VG);
        end;
      end
      else
      begin
        OreTot:=OreTot + Trunc(Q);
        if AssenzeConteggiate[NA].Causale = Giustificativo.Causale then
          OreUni:=OreUni + Trunc(Q);
      end;
      //Fruizione singola per visualizzare nel web le fruizioni richieste e autorizzate
      if UMisura = 'O' then
        FruitoSommaAssenza:=Trunc(Q)
      else if VG <> 0 then
        FruitoSommaAssenza:=ArrotondaGiorno(Trunc(Q) / VG, False);
      //Fruito nel giorno corrente
      if AssenzeConteggiate[NA].Data = DaData then
        if UMisura = 'O' then
          FruitoCorrHH:=Trunc(Q)
        else if VG <> 0 then
          FruitoCorrGG:=ArrotondaGiorno(Trunc(Q) / VG, False);
      //Fruito dal residuo anno precedente
      if FineResiduo and (AssenzeConteggiate[NA].Data <= LimiteResiduo) then
        if UMisura = 'O' then
          FruitoAP:=FruitoAP + Trunc(Q)
        else if VG > 0 then
          FruitoAP:=FruitoAP + (Q/VG);
          //FruitoAP_Ore:=FruitoAP_Ore + Trunc(Q);
      if (AssenzeConteggiate[NA].Data >= InizioFruizForzataAC) and (FruitoForzatoAC < FruizMinimaAC) then
      begin
        if UMisura = 'O' then
          FruitoForzatoAC:=FruitoForzatoAC + Q
        else if VG > 0 then
          FruitoForzatoAC:=FruitoForzatoAC + (Q/VG);
          //FruitoForzatoAC_Ore:=FruitoForzatoAC + Q;
      end;
      OreConteggiate:=Trunc(Q);
    end;
end;

procedure TR600DtM1.ValorizzaOreInGiorni;
begin
  if (UMisura = 'G') and (ValenzaGiornaliera > 0) then
  begin
    GiorniTot:=ArrotondaGiorno(GiorniTot + OreTot / ValenzaGiornaliera,False);
    GiorniUni:=ArrotondaGiorno(GiorniUni + OreUni / ValenzaGiornaliera,False);
    FruitoAP:=ArrotondaGiorno(FruitoAP + FruitoAP_Ore / ValenzaGiornaliera,False);
    FruitoForzatoAC:=ArrotondaGiorno(FruitoForzatoAC + FruitoForzatoAC_Ore / ValenzaGiornaliera,False);
    //GiorniTot:=ArrotondaGiorno(GiorniTot + ArrotondaGiorno(OreTot / ValenzaGiornaliera));
    //GiorniUni:=ArrotondaGiorno(GiorniUni + ArrotondaGiorno(OreUni / ValenzaGiornaliera));
    //FruitoAP:=ArrotondaGiorno(FruitoAP + ArrotondaGiorno(FruitoAP_Ore / ValenzaGiornaliera));
    //FruitoForzatoAC:=ArrotondaGiorno(FruitoForzatoAC + ArrotondaGiorno(FruitoForzatoAC_Ore / ValenzaGiornaliera));
  end;
end;

function TR600DtM1.SottraiCompetenze(var Dest:array of Real; Giorni:Real;
               Ore:LongInt; Data:TDateTime; Messaggio:Boolean):TModalResult;
{Detrae il cumulo in Giorni o Ore specificato dalle competenze in fasce}
var i:Byte;
    FasciaMax:Byte;
    R:Real;
    Info1:String;
begin
  for i:=0 to High(Dest) do
    DestApp[i]:=Dest[i];

  //Per TORINO_CSI: la causale di recupero banca ore può essere fruita fino a un negativo di 6 ore
  if Messaggio and
     (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and
     (Q265.FieldByName('CODICE').AsString = TO_CSI_REC_BANCAORE)
  then
    DestApp[0]:=DestApp[0] - TO_CSI_MIN_BANCAORE;

  Info1:=Format(DataNome,[DatetoStr(Data),Matricola,Nome,Chr(13),CausAnomala,Chr(13)]);
  Result:=mrOK;
  if UMisura = 'G' then
    R:=Giorni
  else
    R:=Ore;
  FasciaMax:=0;
  for i:=0 to 5 do
    if CompetenzeOri[i + 1] <> 0 then
      FasciaMax:=i;
  if Messaggio and (R = 0) and (DestApp[FasciaMax] <= 0) then
  begin
    AnomaliaAssenze:=20;
    if {VisualizzaAnomalie and} not Q265.FieldByName('CAUSALE_SUCCESSIVA').IsNull then  // daniloc. 26/02/2010 (per caricamento assenze da web)
      Result:=mrAbort //Non si chiede alcuna conferma
(*    else if (Q265.FieldByName('NO_SUPERO_COMPETENZE').AsString = 'S') and  //Lorena 12/10/2011
            ((Q265.FieldByName('TIPOCUMULO').AsString <> 'M') or
            ((Q265.FieldByName('TIPOCUMULO').AsString = 'M') and
             (Q265.FieldByname('CQ_PROGRESSIVO').AsString = 'N')))*)
    else if IterAutorizzativo and (Q265.FieldByName('NO_SUPERO_COMPETENZE').AsString = 'N') then
    begin
      if (Q265.FieldByName('NO_SUPERO_COMPETENZE_WEB').AsString = 'S') and
        ((Q265.FieldByName('TIPOCUMULO').AsString <> 'M') or
        ((Q265.FieldByName('TIPOCUMULO').AsString = 'M') and
         (Q265.FieldByname('CQ_PROGRESSIVO').AsString = 'N'))) then
        Result:=Anomalie(3,Info1 + Messaggi[20])
      else
        Result:=Anomalie(4,Info1 + Messaggi[20]);
    end
    else if (Q265.FieldByName('NO_SUPERO_COMPETENZE').AsString = 'S') and
           ((Q265.FieldByName('TIPOCUMULO').AsString <> 'M') or
           ((Q265.FieldByName('TIPOCUMULO').AsString = 'M') and
            (Q265.FieldByname('CQ_PROGRESSIVO').AsString = 'N'))) then
      Result:=Anomalie(3,Info1 + Messaggi[20])
    else
      Result:=Anomalie(4,Info1 + Messaggi[20]);
    if Result <> mrOK then
      exit;
  end;
  for i:=0 to (*5*)FasciaMax do
  begin
    if R = 0 then Break;
    if (DestApp[i] = 0) and (i < (*5*)FasciaMax) then Continue;
    //Sto usufruendo delle competenze di una nuova fascia
    if (
        ((i > 0) and (DestApp[i] = CompetenzeOri[i + 1])) or
        //((i = (*5*)FasciaMax) and (DestApp[i] - R < CompetenzeOri[i] + 1))
        ((i = (*5*)FasciaMax) and (DestApp[i] < R)) //Alberto 15/02/2006
       ) and (Messaggio) then
      //Segnalo il messaggio
    begin
      if (i = (*5*)FasciaMax) and (DestApp[i] < R) then  //Alberto 15/02/2006
      begin
        AnomaliaAssenze:=20;
        if {VisualizzaAnomalie and} not Q265.FieldByName('CAUSALE_SUCCESSIVA').IsNull then  // daniloc. 26/02/2010 (per caricamento assenze da web)
        begin
          Result:=mrAbort; //Non si chiede alcuna conferma
          (*Result:=Anomalie(4,Info1 + Format(Messaggi[24],[Q265.FieldByName('CODICE').AsString,Q265.FieldByName('CAUSALE_SUCCESSIVA').AsString]));
          if Result = mrOk then
            Result:=mrAbort
          else
            AnomaliaAssenze:=24;*)
        end
(*        else if (Q265.FieldByName('NO_SUPERO_COMPETENZE').AsString = 'S') and  //Lorena 21/10/2011
                ((Q265.FieldByName('TIPOCUMULO').AsString <> 'M') or
                 ((Q265.FieldByName('TIPOCUMULO').AsString = 'M') and
                  (Q265.FieldByname('CQ_PROGRESSIVO').AsString = 'N')))*)
        else if IterAutorizzativo and (Q265.FieldByName('NO_SUPERO_COMPETENZE').AsString = 'N') then
        begin
          if (Q265.FieldByName('NO_SUPERO_COMPETENZE_WEB').AsString = 'S') and
            ((Q265.FieldByName('TIPOCUMULO').AsString <> 'M') or
            ((Q265.FieldByName('TIPOCUMULO').AsString = 'M') and
             (Q265.FieldByname('CQ_PROGRESSIVO').AsString = 'N'))) then
            Result:=Anomalie(3,Info1 + Messaggi[20])
          else
            Result:=Anomalie(4,Info1 + Messaggi[20]);
        end
        else if (Q265.FieldByName('NO_SUPERO_COMPETENZE').AsString = 'S') and
               ((Q265.FieldByName('TIPOCUMULO').AsString <> 'M') or
               ((Q265.FieldByName('TIPOCUMULO').AsString = 'M') and
                (Q265.FieldByname('CQ_PROGRESSIVO').AsString = 'N'))) then
            Result:=Anomalie(3,Info1 + Messaggi[20])
          else
            Result:=Anomalie(4,Info1 + Messaggi[20]);
      end
      else
      begin
        AnomaliaAssenze:=19;
        Result:=Anomalie(4,Info1 + Format(Messaggi[19],[i]));
      end;
      if Result <> mrOK then Break;
    end;
    if R > DestApp[i] then
    begin
      if (i = (*5*)FasciaMax) then //Lascio andare l'ultima fascia in negativo
      begin
        DestApp[i]:=DestApp[i] - R;
        R:=0;
      end
      else
      begin
        R:=R - DestApp[i];
        DestApp[i]:=0;
      end;
    end
    else
    begin
      DestApp[i]:=DestApp[i] - R;
      R:=0;
    end;
  end;
  for i:=0 to High(Dest) do
    Dest[i]:=DestApp[i];
end;

function TR600DtM1.SottraiMaxUnitario(var Dest:Real; Giorni:Real; Ore:LongInt; Data:TDateTime; Messaggio:Boolean):TModalResult;
var R:Real;
    Info1:String;
begin
  Info1:=Format(DataNome,[DatetoStr(Data),Matricola,Nome,Chr(13),CausAnomala,Chr(13)]);
  Result:=mrOK;
  if UMisura = 'G' then
    R:=Giorni
  else
    R:=Ore;
  if R > Dest then
  begin
    R:=R - Dest;
    Dest:=0;
  end
  else
  begin
    Dest:=Dest - R;
    R:=0;
  end;
  if (R > 0) and (Messaggio) then
  begin
    AnomaliaAssenze:=21;
//    if Q265.FieldByName('NO_SUPERO_COMPETENZE').AsString = 'S' then  //Lorena 12/10/2011
    if IterAutorizzativo and (Q265.FieldByName('NO_SUPERO_COMPETENZE').AsString = 'N') then
    begin
      if Q265.FieldByName('NO_SUPERO_COMPETENZE_WEB').AsString = 'S' then
        Result:=Anomalie(3,Info1 + Messaggi[21])
      else
        Result:=Anomalie(4,Info1 + Messaggi[21]);
    end
    else if Q265.FieldByName('NO_SUPERO_COMPETENZE').AsString = 'S' then
      Result:=Anomalie(3,Info1 + Messaggi[21])
    else
      Result:=Anomalie(4,Info1 + Messaggi[21]);
  end;
end;

function TR600DtM1.GetUltimaFruizione:Real;
begin
  if UMisura = 'G' then
    Result:=GiorniTot
  else
    Result:=OreTot;
end;

// AOSTA_REGIONE - commessa 2012/152.ini
procedure TR600DtM1.GetVariazioniCongediParentali(PInizio, PFine: TDateTime);
// variazioni per le causali legate ai congedi parentali
begin
  VariazioneFruizMMInteri:=0;
  VariazioneMaxIndividuale:=0;
  VariazioneFruizMMContinuativi:=0;
  VariazioneGGNoLavVuoti:=0;
  // TORINO_CSI - evolutive 02/10/2015.ini
  VariazioneFruizMMInteriDip:=0;
  // TORINO_CSI - evolutive 02/10/2015.fine
  try
    T265P_COMP_CONGPARENTALI.SetVariable('PROGRESSIVO',Progressivo);
    if LetturaAssenze then
      T265P_COMP_CONGPARENTALI.SetVariable('DATA',DaData)
    else
      //Alberto 10/01/2018 - In caso di inserimento, elaboro la situazione a fine periodo per considerare anche le fruizioni future
      T265P_COMP_CONGPARENTALI.SetVariable('DATA',PFine);
    T265P_COMP_CONGPARENTALI.SetVariable('CAUSALE',Q265.FieldByName('CODICE').AsString);
    T265P_COMP_CONGPARENTALI.SetVariable('INIZIO_CUMULO',PInizio);
    T265P_COMP_CONGPARENTALI.SetVariable('FINE_CUMULO',PFine);
    T265P_COMP_CONGPARENTALI.SetVariable('DATANAS_FAM',RiferimentoDataNascita.Data);
    T265P_COMP_CONGPARENTALI.Execute;

    // estrae le variazioni
    VariazioneFruizMMInteri:=T265P_COMP_CONGPARENTALI.GetVariable('OFFSET_MMINTERI');
    VariazioneMaxIndividuale:=T265P_COMP_CONGPARENTALI.GetVariable('OFFSET_MAXINDIVIDUALE');
    VariazioneFruizMMContinuativi:=T265P_COMP_CONGPARENTALI.GetVariable('OFFSET_MMCONT');
    //Per TORINO_CSI: variazioni competenze su giorni non lavorativi vuoti per fruizioni frazionate senza ripresa di attività lavorativa
    if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
      VariazioneGGNoLavVuoti:=-T265P_COMP_CONGPARENTALI.GetVariable('OFFSET_GGVUOTI');
    // TORINO_CSI - evolutive 02/10/2015.ini
    VariazioneFruizMMInteriDip:=T265P_COMP_CONGPARENTALI.GetVariable('OFFSET_MMINTERI_DIP');
    VariazioneFruizMMContinuativiDip:=T265P_COMP_CONGPARENTALI.GetVariable('OFFSET_MMCONT_DIP');
    // TORINO_CSI - evolutive 02/10/2015.fine

    // applica le variazioni alla fascia 1
    Competenze[1]:=Competenze[1] + VariazioneFruizMMInteri + VariazioneMaxIndividuale + VariazioneFruizMMContinuativi + VariazioneGGNoLavVuoti;
    CompetenzeOri[1]:=Competenze[1];
    CompetenzeParziali[1]:=Competenze[1];
    CompetenzeLette[1]:=FloatToStr(Competenze[1]);
  except
  end;
end;
// AOSTA_REGIONE - commessa 2012/152.fine

procedure TR600DtM1.GetVariazioniFestivitaParticolari(PInizio, PFine: TDateTime);
// variazioni per le causali legate alle festività particolari
begin
  VariazioneFestePartic:=0;
  try
    T265P_COMP_FESTEPARTIC.SetVariable('PROGRESSIVO',Progressivo);
    T265P_COMP_FESTEPARTIC.SetVariable('CAUSALE',Q265.FieldByName('CODICE').AsString);
    T265P_COMP_FESTEPARTIC.SetVariable('INIZIO_CUMULO',PInizio);
    T265P_COMP_FESTEPARTIC.SetVariable('FINE_CUMULO',PFine);
    T265P_COMP_FESTEPARTIC.Execute;
    VariazioneFestePartic:=T265P_COMP_FESTEPARTIC.GetVariable('OFFSET_GGFESTEPARTIC');
    // applica le variazioni alla fascia 1
    Competenze[1]:=Competenze[1] + VariazioneFestePartic;
    CompetenzeOri[1]:=Competenze[1];
    CompetenzeParziali[1]:=CompetenzeParziali[1] + VariazioneFestePartic;
    CompetenzeLette[1]:=FloatToStr(Competenze[1]);
  except
  end;
end;

procedure TR600DtM1.CalcolaLavorato(Inizio,Fine:TDateTime);
{Usato per tipo cumulo = 'M' (Art.17)
 Calcolo le ore lavorate da Inizio a Fine considerando valide le assenze specificate
 nelle regole.
 Ogni settimana considero al massimo le ore di MaxUnitario/52}
var DataCorr:TDateTime;
    GS,i:Byte;
    TotLav,MinLav:Int64;
begin
  UMisura:='O';
  CumuloM.OreSett:=0;   //Debito orario settimanale (38 ore)
  CumuloM.LavAnno:=0;   //Lavorato nell'anno
  CumuloM.CompAn:=Trunc(MaxUnitario);      //Competenza annuale (208 ore)
  CumuloM.CompSett:=CumuloM.CompAn div 52; //Competenze settimanali (4 ore)
  TotLav:=0;  //Totale lavorato nella settimana
  //Calcolo competenza annuale e settimanale
  if R180OreMinutiExt(Q265.FieldByname('CM_DEBSETT').AsString) > 0 then
    CumuloM.OreSett:=R180OreMinutiExt(Q265.FieldByname('CM_DEBSETT').AsString)
  else if QSDip.LocDatoStorico(Fine) then
    //Debito orario settimanale (38 ore)
    CumuloM.OreSett:=R180OreMinutiExt(QSDip.FieldByName('T430Orario').AsString);
  DataCorr:=Inizio;
  GS:=DayOfWeek(Inizio - 1);  //Tengo traccia della settimana (Lu..Do)
  R502ProDtM1.Chiamante:='Cartolina';
  R502ProDtM1.PeriodoConteggi(Inizio,Fine);
  {$IFNDEF MEDP803}R502ProDtM1.Q040.Close;{$ENDIF}
  {$IFDEF MEDP803}R502ProDtM1.Q040.Open;{$ENDIF}
  {$IFDEF MEDP803}R502ProDtM1.Q100.Open;{$ENDIF}
  //Alberto 13/08/2007: gestione dei limiti
  selT266.SetVariable('CODICE',Q265.FieldByname('CODICE').AsString);
  selT266.Close;
  selT266.Open;
  while DataCorr <= Fine do
  try
    R502ProDtM1.Conteggi('Cartolina',Progressivo,DataCorr);
    if R502ProDtM1.Blocca <> 0 then
    begin
      //Se anomalia bloccante passo al giorno successivo (il Continue va al blocco Finally)
      Continue;
    end;
    //MinLav = ore lavorate del giorno
    MinLav:=R502ProDtM1.mintipoAesc; //Ore escluse dalle normali
    for i:=1 to R502ProDtM1.n_fasce do
      inc(MinLav,R502ProDtM1.tminlav[i]); //Contiene anche le ore rese da assenza
    //Tolgo le assenze che non maturano
    //dec(MinLav,MaturAssenze(Q265.FieldByName('AssToll').AsString));
    dec(MinLav,MaturAssenze);
  finally
    if GS > 7 then
      //Ho finito la settimana
    begin
      GS:=1;
      if (TotLav > CumuloM.OreSett) and (Q265.FieldByname('CQ_PROGRESSIVO').AsString = 'N')  then
        //Se il lavorato della settimana supera il debito settimanale, la limito
        TotLav:=CumuloM.OreSett;
      //Incremento il lavorato totale del lavorato settimanale
      inc(CumuloM.LavAnno,TotLav);
      TotLav:=0;
    end;
    inc(TotLav,MinLav);
    DataCorr:=DataCorr + 1;
    inc(GS);
  end;
  selT266.CancelUpdates;
  if (TotLav > CumuloM.OreSett) and (Q265.FieldByname('CQ_PROGRESSIVO').AsString = 'N') then
    //Se il lavorato della settimana supera il debito settimanale, la limito
    TotLav:=CumuloM.OreSett;
  //Incremento il lavorato totale del lavorato settimanale
  inc(CumuloM.LavAnno,TotLav);
  //Le competenze reali sono la proporzione:
  //   DebitoAnno : CompetenzeAnno = LavoratoAnno : X -> (38 * 52):208 = 145 : x
  try
    CumuloM.CompCorr:=(CumuloM.CompAn * Min(CumuloM.LavAnno,CumuloM.OreSett * 52)) div (CumuloM.OreSett * 52);
    if (Q265.FieldByname('CQ_PROGRESSIVO').AsString = 'S') and (CumuloM.CompCorr > CumuloM.CompAn) then
      CumuloM.CompCorr:=CumuloM.CompAn;
  except
    CumuloM.CompCorr:=0;
  end;
  if EsisteMaxFasce then
    SottraiCompetenze(Competenze,0,CumuloM.CompAn - CumuloM.CompCorr,Date,False);  //La data non è significativa
  //SottraiMaxUnitario(MaxUnitario,0,CumuloM.CompAn - CumuloM.CompCorr,Date,False);  //La data non è significativa
  CompetenzeParziali[1]:=Competenze[1];
  TrasferisciCompetenze(Competenze,CompetenzeOri,False);
  MaxUnitarioOri:=MaxUnitario;
end;

procedure TR600DtM1.GetSaldiScheda(Data:TDateTime);
{Lettura dei saldi del mese precedente indicati nel Tipo di recupero : viene comunque letta l'ultima scheda esistente fino al mese prec.}
var R450DtM:TR450DtM1;
    Saldo:String;
    D:TDateTime;
begin
  Competenze[1]:=0;
  CompetenzeOri[1]:=0;
  CompetenzeParziali[1]:=0;
  CompetenzeLette[1]:='00.00';
  CompetenzeLette[2]:='00.00';//dati del mese corrente per TORINO_CSI_PRV
  CompetenzeLette[3]:='00.00';//ore di assestamento
  if RapportoCorrente.Esiste and (R180InizioMese(RapportoCorrente.Rapporto[0].Inizio) > R180InizioMese(R180Addmesi(Data,-1))) then
    exit;
  Saldo:=Q265.FieldByName('TIPORECUPERO').AsString;
  if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
    R450DtM:=TR450DtM1.Create(Self.Owner)
  else
    R450DtM:=TR450DtM1.Create(SessioneOracleR600);
  try
    R450DtM.DataRiferimentoEsterna.Abilitata:=True;
    R450DtM.DataRiferimentoEsterna.Data:=Data;
    if not Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
      Data:=Min(Data,Date);
    D:=Data;
    if not PassaggioDiAnno then
      D:=R180AddMesi(D,-1);
    if R180Mese(D) < 12 then
    begin
      R450DtM.ConteggiMese('Generico',R180Anno(D),R180Mese(D),Progressivo);
      if Saldo = 'BO' then
        CompetenzeLette[1]:=R180MinutiOre(R450DtM.BancaOreResidua + R450DtM.BancaOreResiduaPrec)
      else if Saldo = 'AC' then
        CompetenzeLette[1]:=R180MinutiOre(max(0,R450DtM.salcompannoatt + R450DtM.salliqannoatt))
      else if Saldo = 'AL' then
        CompetenzeLette[1]:=R180MinutiOre(max(0,R450DtM.salcompannoatt + R450DtM.salliqannoatt))
      else if Saldo = 'PC' then
      begin
        if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
          CompetenzeLette[1]:=R180MinutiOre(R450DtM.salannoatt)
        else
          CompetenzeLette[1]:=R180MinutiOre(max(0,R450DtM.salannoatt));
      end
      else if Saldo = 'PL' then
      begin
        if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
          CompetenzeLette[1]:=R180MinutiOre(R450DtM.salannoatt)
        else
          CompetenzeLette[1]:=R180MinutiOre(max(0,R450DtM.salannoatt));
      end;
    end
    else
    begin
      R450DtM.ConteggiMese('Generico',R180Anno(D) + 1,1,Progressivo);
      if Saldo = 'BO' then
        CompetenzeLette[1]:=R180MinutiOre(R450DtM.l13_banca_ore)
      else if Saldo = 'AC' then
        CompetenzeLette[1]:='00.00'
      else if Saldo = 'AL' then
        CompetenzeLette[1]:='00.00'
      else if Saldo = 'PC' then
      begin
        if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
          CompetenzeLette[1]:=R180MinutiOre(R450DtM.l13_sallav_min)
        else
          CompetenzeLette[1]:=R180MinutiOre(max(0,R450DtM.l13_sallav_min))
      end
      else if Saldo = 'PL' then
      begin
        if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
          CompetenzeLette[1]:=R180MinutiOre(R450DtM.l13_sallav_min)
        else
          CompetenzeLette[1]:=R180MinutiOre(max(0,R450DtM.l13_sallav_min));
      end;
    end;
    (*
    if Saldo = 'BO' then
    begin
      if (R180OreMinutiExt(CompetenzeLette[1]) = 0) and (R450DtM.BancaOreResiduabile = 'S') then
        with ScrBancaOreResidua do
        begin
          SetVariable('Data',D);
          Execute;
          CompetenzeLette[1]:=R180MinutiOre(GetVariable('Banca_Ore'));
        end;
    end;
    *)
  finally
    FreeAndNil(R450DtM);
  end;
  GetSaldiGiornalieri(True);
  if (Saldo = 'PL') or (Saldo = 'PC') then
    GetOreAssestamento(Data);
  Competenze[1]:=Competenze[1] + R180OreMinutiExt(CompetenzeLette[1]) + R180OreMinutiExt(CompetenzeLette[2]) + R180OreMinutiExt(CompetenzeLette[3]);
  CompetenzeOri[1]:=Competenze[1];
  CompetenzeParziali[1]:=R180OreMinutiExt(CompetenzeLette[1]);
end;

procedure TR600DtM1.GetOreAssestamento(Data:TDateTime);
begin
  R180SetVariable(selT071Assestamento,'PROGRESSIVO',Progressivo);
  R180SetVariable(selT071Assestamento,'DATA',R180InizioMese(Data));
  with selT071Assestamento do
  begin
    Close;
    Open;
    CompetenzeLette[3]:=R180MinutiOre(FieldByName('OREASSEST').AsInteger);
  end;
end;

procedure TR600DtM1.GetSaldoSettimanale;
begin
  Competenze[1]:=0;
  CompetenzeOri[1]:=0;
  CompetenzeParziali[1]:=0;
  CompetenzeLette[1]:='00.00';
  CompetenzeLette[2]:='00.00';//dati della settimana corrente per TORINO_CSI_PRV

  GetSaldiGiornalieri(False);
  Competenze[1]:=Competenze[1] + R180OreMinutiExt(CompetenzeLette[1]) + R180OreMinutiExt(CompetenzeLette[2]);
  CompetenzeOri[1]:=Competenze[1];
  CompetenzeParziali[1]:=R180OreMinutiExt(CompetenzeLette[1]);
end;

procedure TR600DtM1.GetSaldiGiornalieri(ConsideraT025:Boolean);
var Saldo:String;
    DI:TDateTime;
    i,locScostSett,locBOSett,locEccSett:Integer;
    locScostGG,locRiepPresGG:Integer;
    XParRecSettNeg:Boolean;
begin
  if not Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    exit;
  Saldo:=Q265.FieldByName('TIPORECUPERO').AsString;
  XParRecSettNeg:=False;
  if (Saldo = 'BO') or (Saldo = 'PC') or ((TipoCumulo = 'Z') and (Q265.FieldByname('CODICE').AsString = TO_CSI_REC_SETT)) then
  try
    R502ProDtM1.ConsideraRichiesteWeb:=True;
    R502ProDtM1.ResettaProg;
    R502ProDtM1.PeriodoConteggi(InizioCumulo,FineCumulo);
    DI:=InizioCumulo;
    i:=DayOfWeek(InizioCumulo - 1);
    locScostSett:=0;
    locEccSett:=0;
    locBOSett:=0;
    while DI <= FineCumulo do
    begin
      //Se conteggio del mese intero, escludo la settimana corrente per cui è richiesta la fruizione/competenze
      //Infatti nella settima corrente si deve usare l'apposito giustificativo che ha come competenze
      //la somma delle eccedenze giornaliere positive, e richiama questa procedura con ConsideraT025 = False.
      if ConsideraT025 and
         (selT025.FieldByName('CARTELLINO').AsString = 'S') and
         (R180SettimanaAnno(DI,False) = R180SettimanaAnno(AData,False)) and
         TO_CSI_SaltaSettimanaCorrente then
      begin
        DI:=DI + 1;
        Continue;
      end;
      R502ProDtM1.Conteggi('Cartolina',Progressivo,DI);
      if R502ProDtM1.XParam['<TOCSI_RECSETTNEG>'] then
        XParRecSettNeg:=True;
      //Competenze banca ore 'normale'
      with R502ProDtM1 do
      begin
        //inc(locScostSett,scost - RiepAssenza[TO_CSI_REC_BANCAORE,'HHRESE'] - RiepAssenza[TO_CSI_RICH_RECHH,'HHRESE']);
        inc(locScostSett,scost);//Alberto 04/02/2015: si considera lo scostamento positivo totale senza alcun abbattimento
        //Competenze recupero settimanale: sono i positivi giornalieri
        locScostGG:=max(0,scost - RiepAssenza[TO_CSI_REC_BANCAORE,'HHRESE'] - RiepAssenza[TO_CSI_REC_SETT,'HHRESE'] + RiepAssenza[TO_CSI_ABB_ECCSETT,'HHVAL'] - RiepAssenza[TO_CSI_RICH_RECHH,'HHRESE']);
        //Non considero gli spezzoni fuori orario se c'è una mezza giornata di assenza (perchè nel caso di timbrature al pomeriggio, potrebbero essere fatte oltre i punti nominali per via della mancata flessibilità)
        if n_giusmga > 0 then
          locRiepPresGG:=0
        else
          //spezzoni fuori orario (prolungamento)
          locRiepPresGG:=RiepPresTotali[False]
      end;
      inc(locEccSett,max(locScostGG,locRiepPresGG));
      if ConsideraT025 and (selT025.FieldByName('CARTELLINO').AsString = 'S') and (i mod 7 = 0) then
      begin
        inc(locBOSett,max(0,locScostSett));
        locScostSett:=0;
      end;
      DI:=DI + 1;
      inc(i);
    end;
  finally
    R502ProDtM1.ConsideraRichiesteWeb:=False;
  end;
  if ConsideraT025 and (selT025.FieldByName('CARTELLINO').AsString = 'S') then
    CompetenzeLette[2]:=R180MinutiOre(locBOSett)
  else
  begin
    if (not XParRecSettNeg) and (locScostSett < 0) then
      locEccSett:=0;
    CompetenzeLette[2]:=R180MinutiOre(locEccSett);
  end;
end;

procedure TR600DtM1.GetCausaliFruite(Dal,Al:TDateTime);
{Lettura delle assenze/presenze fruite da inizio anno}
var L:TStringList;
    i,j:Integer;
    H,G,Quantita,OreRese:Real;
    Giustif:TGiustificativo;
    UM:String;
    Data,DataCG,DataCGInizioAnno,AlRiep:TDateTime;
    R450DtM:TR450DtM1;
    R600Loc:TR600DtM1;
    CompCausOreMax:Boolean;
begin
  L:=TStringList.Create;
  H:=0;
  G:=0;
  R450DtM:=nil;
  R600Loc:=nil;
  try
    L.CommaText:=Q265.FieldByName('ASSTOLL').AsString;
    i:=0;
    while i <= L.Count - 1 do
    begin
      if VarToStr(Q265.Lookup('CODICE',L[i],'CODICE')) <> '' then
      begin
        //Assenze fruite da inizio anno
        Giustif.Causale:=L[i];
        Giustif.Modo:='I';
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
        // il tipo mezza giornata è significativo solo per Modo = M
        Giustif.CSITipoMG:='';
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
        if R600Loc = nil then
        begin
          if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
            R600Loc:=TR600DtM1.Create(Self.Owner)
          else
            R600Loc:=TR600DtM1.Create(SessioneOracleR600);
        end;
        R600Loc.GetQuantitaAssenze(Progressivo,Dal,Al,0,Giustif,UM,Quantita,OreRese);
        if (UMisura = 'O') or (UM = 'O') then
          H:=H + Quantita
        else
          G:=G + Quantita;
        L.Delete(i);
      end
      else
        inc(i);
    end;
    //Presenze fruite da inizio anno
    selT275.Open;
    if L.Count > 0 then
    begin
      DataCG:=Al + 1;
      if (R180Mese(Al) > 1) or (Al = R180FineMese(Al)) then
      //Lettura dei riepiloghi al mese precedente solo se mese successivo al 30 gennaio
      begin
        if R450DtM = nil then
        begin
          if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
            R450DtM:=TR450DtM1.Create(Self.Owner)
          else
            R450DtM:=TR450DtM1.Create(SessioneOracleR600);
        end;
        if PassaggioDiAnno or (Al = R180FineMese(Al)) then
          AlRiep:=Al
        else
          AlRiep:=R180AddMesi(Al,-1);
        R450DtM.ConteggiMese('Generico',R180Anno(AlRiep),R180Mese(AlRiep),Progressivo);
        for i:=0 to High(R450DtM.RiepPres) do
          //Alberto 25/06/2009 - TORINO_COMUNE: non si considerano i riepiloghi se la causale può rendere al massimo il debito giornaliero (Art.16)
          if (L.IndexOf(R450DtM.RiepPres[i].Causale) >= 0) and (not selT275.SearchRecord('CODICE',R450DtM.RiepPres[i].Causale,[srFromBeginning])) then
          begin
            for j:=1 to R450DtM.NFasceMese do
              H:=H + R450DtM.RiepPres[i].Residuo[j] + R450DtM.RiepPres[i].Abbattimento[j];
            H:=H + R450DtM.RiepPres[i].RecuperoAnno;
          end;
        //Verifica dell'ultima scheda riepil. esistente per sapere da quando far partire i conteggi giornalieri
        for i:=R180Mese(AlRiep) downto 1 do
          if R450DtM.ttrovscheda[i] = 1 then
            Break
          else
            DataCG:=R180AddMesi(DataCG,-1);
      end
      else
      //Lettura residui anno precedente
      with selT131 do
      begin
        //Alberto 2006/2006
        if StrToIntDef(VarToStr(GetVariable('ANNO')),0) <> R180Anno(Al) then
        begin
          Close;
          SetVariable('ANNO',R180Anno(Al));
        end;
        Open;
        First;
        while not Eof do
        begin
          //Alberto 25/06/2009 - TORINO_COMUNE: non si considerano i riepiloghi se la causale può rendere al massimo il debito giornaliero (Art.16)
          if (L.IndexOf(FieldByName('CAUSALE').AsString) >= 0) and (not selT275.SearchRecord('CODICE',FieldByName('CAUSALE').AsString,[srFromBeginning])) then
            H:=H + FieldByName('RESIDUO').AsInteger;
          Next;
        end;
        Close;
      end;
      //if not PassaggioDiAnno then
      if PassaggioDiAnno then
        for i:=L.Count - 1 downto 0 do
          if not selT275.SearchRecord('CODICE',L[i],[srFromBeginning]) then
            L.Delete(i);
      if L.Count > 0 then
      begin
        //Conteggi Giornalieri da R180InizioMese(DataCG) a D (Giorni per i quali non esiste la scheda riepilogativa)
        R502ProDtM1.Chiamante:='APERTURA';
        DataCGInizioAnno:=DataCG;
        for i:=0 to L.Count - 1 do
          //Alberto 25/06/2009 - TORINO_COMUNE: se esistono causali che possono rendere al massimo il debito giornaliero (Art.16), si comincia il conteggio da Inizio anno perchè non si possono utilizzare i riepiloghi
          if selT275.SearchRecord('CODICE',L[i],[srFromBeginning]) then
          begin
            DataCGInizioAnno:=EncodeDate(R180Anno(Al),1,1);
            Break;
          end;
        //Alberto 25/06/2009 - TORINO_COMUNE: selCompS serve per ottenere le date in cui si sono utilizzate le causali che maturano competenze, partendo da DataCG per le causali 'normali' e da DataCGInizioAnno per le causali che maturano al massimo il debito gg.
        R180SetVariable(selCompS,'PROGRESSIVO',Progressivo);
        R180SetVariable(selCompS,'DATA0',DataCGInizioAnno);
        R180SetVariable(selCompS,'DATA1',DataCG);
        R180SetVariable(selCompS,'DATA2',Al);
        R180SetVariable(selCompS,'CAUSALI',L.CommaText);
        selCompS.Open;
        selCompS.First;
        R502ProDtM1.PeriodoConteggi(R180InizioMese(DataCGInizioAnno),Al);
        {$IFNDEF MEDP803}R502ProDtM1.Q040.Close;{$ENDIF}
        Data:=R180InizioMese(DataCGInizioAnno);
        while Data <= Al do
        begin
          if selCompS.SearchRecord('DATA',Data,[srFromBeginning]) then
          begin
            OreRese:=0;
            CompCausOreMax:=False;
            R502ProDtM1.Conteggi('Cartolina',Progressivo,Data);
            for i:=1 to R502ProDtM1.n_rieppres do
              if L.IndexOf(R502ProDtM1.triepgiuspres[i].tcauspres) >= 0 then
              begin
                //Alberto 22/11/2012: verifico se esiste nel giorno una causale con attivato il parametro COMP_CAUS_OREMAX per limitare la maturazione al debito gg.
                if selT275.SearchRecord('CODICE',R502ProDtM1.triepgiuspres[i].tcauspres,[srFromBeginning]) then
                  CompCausOreMax:=True;
                for j:=1 to R502ProDtM1.n_fasce do
                  OreRese:=OreRese + R502ProDtM1.triepgiuspres[i].tminpres[j];
              end;
            if CompCausOreMax then
              OreRese:=min(OreRese,R502ProDtM1.ValNumT020['OreTeor']);
            H:=H + OreRese;
          end;
          Data:=Data + 1;
        end;
        selCompS.Close;
      end;
    end;
    //Inizializzazione competenze e annullamento eventuali residui (i residui sono già letti dalle presenze)
    //In realtà si lascia la lettura dei residui: se si legge dalle presenze, l'assenza deve essere non residuabile
    //for i:=1 to 6 do
    //begin
    //  CompetenzeLette[i]:='0';
    //  Competenze[i]:=0;
    //  Residui[i]:='0';
    //  ResiduiVal[i]:=0;
    //end;
    if UMisura = 'G' then
    begin
      if ValenzaGiornaliera <> 0 then
      begin
        CompetenzeLette[1]:=FloatToStr(G + H/ValenzaGiornaliera);
        Competenze[1]:=Competenze[1] + G + H/ValenzaGiornaliera;
      end
      else
      begin
        CompetenzeLette[1]:=FloatToStr(G);
        Competenze[1]:=Competenze[1] + G;
      end
    end
    else
    begin
      CompetenzeLette[1]:=R180MinutiOre(Trunc(G * ValenzaGiornaliera + H));
      Competenze[1]:=Competenze[1] + Trunc(G * ValenzaGiornaliera + H);
    end;
    ArrotondaCompetenze(Competenze);
    CompetenzeOri[1]:=Competenze[1];
    CompetenzeParziali[1]:=Competenze[1];
  finally
    L.Free;
    if R450DtM <> nil then
      FreeAndNil(R450DtM);
    if R600Loc <> nil then
      FreeAndNil(R600Loc);
  end;
end;

procedure TR600DtM1.GetRecuperoPeriodico(D:TDateTime);
{Lettura delle assenze/presenze fruite da inizio anno (Torino_Regione: 1028-1029)}
var i,j,k,c,Indietro:Integer;
    DataComp,DataRec,InizioCumuloRecPer:TDateTime;
    Abb,CompMese,CompNeg:Real;
    Comp,Recup,RecupEcc:array of Real;
    lstAssToll,lstAssRecup:TStringList;
    S:String;
    R600Loc:TR600DtM1;
  function Fruito(Caus:String; Dal,Al:TDateTime):Real;
  var Giustif:TGiustificativo;
      UM:String;
      Quantita,OreRese:Real;
  begin
    Result:=0;
    if R600Loc = nil then
    begin
      if (Self.Owner <> nil) and not(Self.Owner is TOracleSession) then
        R600Loc:=TR600DtM1.Create(Self.Owner)
      else
        R600Loc:=TR600DtM1.Create(SessioneOracleR600);
    end;
    Giustif.Causale:=Caus;
    Giustif.Modo:='I';
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    // il tipo mezza giornata è significativo solo per Modo = M
    Giustif.CSITipoMG:='';
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    R600Loc.GetQuantitaAssenze(Progressivo,Dal,Al,0,Giustif,UM,Quantita,OreRese);
    if UM = UMisura then
      Result:=Quantita
    else if UMisura = 'O' then
      Result:=OreRese;
  end;
  function GetDataIniziale:TDateTime;
  begin
    Result:=D;
    with TOracleQuery.Create(Self.Owner) do
    try
      Session:=SessioneOracleR600;
      SQL.Add(Format('SELECT MIN(DATA) FROM T040_GIUSTIFICATIVI WHERE PROGRESSIVO = %d and CAUSALE in (%s)',[Progressivo,'''' + StringReplace(Q265.FieldByName('ASSTOLL').AsString,',',''',''',[rfReplaceAll]) + '''']));
      Execute;
      if (not FieldIsNull(0)) and (FieldAsDate(0) <= D) then
        Result:=FieldAsDate(0);
    finally
      Free;
    end;
  end;
begin
  R600Loc:=nil;
  FruitoCompPrec:=0;
  SetLength(Comp,1);
  Comp[0]:=0;
  SetLength(Recup,0);
  SetLength(RecupEcc,0);
  FruizCompPrecCumuloT:=0;
  SetLength(RecupCumuloT,0);
  Indietro:=Q265.FieldByName('DURATACUMULO').AsInteger - 1;
  lstAssToll:=TStringList.Create;
  lstAssToll.CommaText:=Q265.FieldByName('ASSTOLL').AsString;

  lstAssRecup:=TStringList.Create;
  lstAssRecup.Sorted:=True;
  lstAssRecup.Duplicates:=dupIgnore;
  S:=Q265.FieldByName('CODICE').AsString + ',' + Q265.FieldByName('CODCAU1').AsString;
  lstAssRecup.CommaText:=S;

  InizioCumuloRecPer:=R180InizioMese(InizioCumulo);
  if EsisteResiduo then
  begin
    //FruitoCompPrec:=R180OreMinutiExt(Residui[1]);
    DataComp:=R180AddMesi(EncodeDate(R180Anno(D),1,1), - Indietro - 1 - Indietro - 1);
    DataRec:=R180AddMesi(DataComp,Indietro);
    //CompMese:=Fruito(Q265.FieldByName('ASSTOLL').AsString,DataComp,R180FineMese(DataComp));
    //Comp[0]:=CompMese;
    j:=0;
    k:=0;
    //Lettura recuperi dai Residui
    //while (j <= Indietro) and (R180AddMesi(DataComp,j) <= D) do
    while (j <= Indietro) and ((DataComp <= D) or ScaricoPaghe) do //Alberto 20/02/2013
    begin
      //CompMese:=Fruito(Q265.FieldByName('ASSTOLL').AsString,DataComp,R180FineMese(DataComp));
      CompMese:=0;
      for c:=0 to lstAssToll.Count - 1 do
        CompMese:=CompMese + Fruito(lstAssToll[c],DataComp,R180FineMese(DataComp));
      SetLength(Comp,j + 1);
      Comp[j]:=CompMese;
      SetLength(Recup,j + 1);
      Recup[j]:=R180OreMinutiExt(Residui[j + 1]);
      DataComp:=R180AddMesi(DataComp,1);
      DataRec:=R180AddMesi(DataRec,1);
      inc(j);
      inc(k);
    end;
    (*
    //Resetto FruitoCompPrec se sto calcolando un periodo successivo a quello registrato nei residui
    if (R180AddMesi(DataComp,-1) >= R180InizioMese(InizioCumuloRecPer)) or (R180AddMesi(DataRec,-1) < R180InizioMese(InizioCumuloRecPer)) then
      FruitoCompPrec:=0;
    *)
    EsisteResiduo:=False;
    for j:=1 to High(Residui) do
    begin
      Residui[j]:='';
      ResiduiVal[j]:=0;
    end;
  end
  else
  begin
    DataComp:=R180InizioMese(GetDataIniziale);
    //DataComp:=EncodeDate(R180Anno(D),1,1);
    DataRec:=DataComp;
    //Lettura fruito al primo mese
    //CompMese:=Fruito(Q265.FieldByName('ASSTOLL').AsString,DataComp,R180FineMese(DataComp));
    CompMese:=0;
    for c:=0 to lstAssToll.Count - 1 do
      CompMese:=CompMese + Fruito(lstAssToll[c],DataComp,R180FineMese(DataComp));
    Comp[0]:=CompMese;
    k:=0;
    j:=0;
    //Lettura recuperi (riferiti a Gennaio) effettuati da Gennaio all'ultimo mese utile
    //Vengono già abbattute le competenze di gennaio
//    while (j <= Indietro) and (R180AddMesi(DataComp,j) <= D) do  Lorena 12/10/2005
    while (j <= Indietro) and ((R180AddMesi(DataComp,j) <= D) or ScaricoPaghe) do
    begin
      DataRec:=R180AddMesi(DataComp,j);
      SetLength(Recup,j + 1);

      //Recup[j]:=Fruito(Q265.FieldByName('CODICE').AsString,DataRec,R180FineMese(DataRec));
      Recup[j]:=0;
      for c:=0 to lstAssRecup.Count - 1 do
      begin
        if lstAssRecup[c] <> '' then
          Recup[j]:=Recup[j] + Fruito(lstAssRecup[c],DataRec,R180FineMese(DataRec));
      end;

      Abb:=Min(Recup[j],CompMese);
      Recup[j]:=Recup[j] - Abb;
      //--Modificato il 17/01/2005-- if (DataComp < InizioCumulo) and (DataRec >= InizioCumulo) then
      if (DataComp < R180InizioMese(InizioCumuloRecPer)) and (DataRec >= R180InizioMese(InizioCumuloRecPer)) then
        FruitoCompPrec:=FruitoCompPrec + Abb;
      CompMese:=CompMese - Abb;
      inc(j);
      inc(k);  //Ultimo elemento utile
    end;
    //Lettura mesi successivi, da febbraio fino al mese richiesto
    DataComp:=R180AddMesi(DataComp,1);
    DataRec:=R180AddMesi(DataRec,1);
  end;
  SetLength(Recup,k + 1);
  Recup[k]:=0;
  if k > 1 then
  begin
    SetLength(Comp,k); //High(Comp) = k - 1
    Comp[High(Comp)]:=Comp[0];
    Comp[0]:=0;
  end;
  while DataComp <= D do
  begin
    //Fruito del mese: sono le competenze da recuperare nei k mesi successivi
    //CompMese:=Fruito(Q265.FieldByName('ASSTOLL').AsString,DataComp,R180FineMese(DataComp));
    CompMese:=0;
    for c:=0 to lstAssToll.Count - 1 do
      CompMese:=CompMese + Fruito(lstAssToll[c],DataComp,R180FineMese(DataComp));

    //SetLength(Comp,Length(Comp) + 1);
    for j:=0 to k - 2 do
      Comp[j]:=Comp[j + 1];
    if k > 0 then
      Comp[k - 1]:=CompMese;
    //Lettura del recupero effettuato il mese successivo all'ultimo già letto
    if DataRec <= D then
    begin
      //Recup[k]:=Fruito(Q265.FieldByName('CODICE').AsString,DataRec,R180FineMese(DataRec));
      Recup[k]:=0;
      for c:=0 to lstAssRecup.Count - 1 do
      begin
        if lstAssRecup[c] <> '' then
          Recup[k]:=Recup[k] + Fruito(lstAssRecup[c],DataRec,R180FineMese(DataRec));
      end;
    end;

    //Alberto 17/11/2013: PIACENZA_COMUNE:
    //il recupero avanzato dai mesi precedenti significa che è stato fruito più RE20 delle competenze disponibili (residuo negativo)
    //Per gestirlo viene salvato in RecupEcc e recuperato separatamente, con impatto sulle competenze
    //Nota: algoritmo assolutamente Empirico!!
    if Q265.FieldByName('CODICE').AsString = 'RE20' then
    begin
      SetLength(RecupEcc,Length(RecupEcc) + 1);
      RecupEcc[High(RecupEcc)]:=max(0,Recup[0]);
      for j:=0 to High(RecupEcc) do
      begin
        Abb:=Min(RecupEcc[j],CompMese);
        if Abb > 0 then
        begin
          RecupEcc[j]:=RecupEcc[j] - Abb;
          CompMese:=CompMese - Abb;
          if DataComp < R180InizioMese(D) then
            Comp[k - 1]:=Comp[k - 1] - Abb
          else if DataComp = R180InizioMese(D) then
            Comp[k - 1]:=Comp[k - 1] - max(0,Abb - Recup[0]);
        end;
      end;
    end;
    //Abbattimento delle nuove competenze, considerando i recuperi avanzati dal mese prec e i recuperi letti dal nuovo mese
    for j:=0 to k - 1 do
    begin
      Recup[j]:=Recup[j + 1];
      Abb:=Min(Recup[j],CompMese);
      Recup[j]:=Recup[j] - Abb;
      CompMese:=CompMese - Abb;
      //Se le competenze sono lette prima di InizioCumulo, ma l'abbattimento avviene nel periodo di cumulo, lo conto in FruitoDaTogliere
      if (DataComp < InizioCumuloRecPer) and (R180AddMesi(DataRec,j - k + 1) >= InizioCumuloRecPer) then
        FruitoCompPrec:=FruitoCompPrec + Abb;
    end;
    Recup[k]:=0;
    if R180AddMesi(DataRec, - k + 1) < InizioCumuloRecPer then
    begin
      //Salvataggio su variabili pubbliche per la gestione dei residui
      //Provato ad utilizzarlo per PIACENZA_COMUNE nella gestione dei residui, ma non va ancora bene
      //FruizCompPrecCumuloT:=Trunc(FruitoCompPrec);
      SetLength(RecupCumuloT,Length(Recup) - 1);
      for i:=0 to High(Recup) - 1 do
        RecupCumuloT[i]:=Trunc(Recup[i]);
    end;
    DataComp:=R180AddMesi(DataComp,1);
    DataRec:=R180AddMesi(DataRec,1);
  end;
  //Totalizzazione delle competenze effettive
  CompMese:=0;
  //for i:=High(Comp) - Indietro to High(Comp) do
  for i:=0 to High(Comp) do
  begin
    CompMese:=CompMese + Comp[i];
    if ScaricoPaghe then Break;
  end;
  //Alberto 17/11/2013: PIACENZA_COMUNE:
  //Allineamento delle competenze con i recuperi avanzati dai mesi precedenti (RecupEcc)
  //Per es: si fruisce RE20 senza nessuna fruizione della causale di permesso: le competenze devono rimanere in negativo anche nei mesi precedenti
  if (Q265.FieldByName('CODICE').AsString = 'RE20') and (not ScaricoPaghe) then
  begin
    (**)
    for i:=0 to High(RecupEcc) - 1 do
      CompMese:=CompMese - RecupEcc[i];
  end;
  for j:=1 to High(Competenze) do
  begin
    CompetenzeLette[j]:='';
    Competenze[j]:=0;
    CompetenzeOri[j]:=0;
    CompetenzeParziali[j]:=0;
  end;
  CompetenzeLette[1]:=FloatToStr(CompMese);
  Competenze[1]:=CompMese;
  CompetenzeOri[1]:=Competenze[1];
  CompetenzeParziali[1]:=Competenze[1];
  FreeAndNil(lstAssToll);
  FreeAndNil(lstAssRecup);
  if R600Loc <> nil then
    FreeAndNil(R600Loc);
end;

procedure TR600DtM1.GetFesteLavorate(Inizio,Fine:TDateTime);
{Usato per tipo cumulo = 'P' (S.Giovanni)
 Le competenze sono maturate in base ai giorni festivi lavorati}
var Conta,Contagg,i:Integer;
    DataCorr:TDateTime;
    Causali:String;
  function CheckTimbrature(Rep:String):Byte;
  //Restituisce 0 se sono presenti timbrature NON di reperibilità e i giorni con la pianificazione non devono essere considerati
  var xx:Integer;
  begin
    Result:=0;
    if Rep = 'S' then
      Result:=1
    else
      with R502ProDtM1 do
      begin
        for xx:=1 to n_timbrdip do
          if (ttimbraturedip[xx].tcausale_e.tcaus = '') or
             ((ttimbraturedip[xx].tcausale_e.tcaus <> '') and (ttimbraturedip[xx].tcausale_e.tcausrag <> traggrcauspr[3].C)) or
             (ttimbraturedip[xx].tcausale_u.tcaus = '') or
             ((ttimbraturedip[xx].tcausale_u.tcaus <> '') and (ttimbraturedip[xx].tcausale_u.tcausrag <> traggrcauspr[3].C)) then
          begin
            Result:=1;
            Break;
          end;
      end;
  end;
begin
(*
- testare se il giorno è una domenica o una festività infrasettimanale
(in base ai check attivati sulla causale stessa) in base alla vista V010_CALENDARI
(estrarre V010 tra INIZIO e FINE dove FESTIVO = S o DOMENICA = S e puntare al record per data e progressivo)
- se il test va a buon fine richiamare R502.Conteggi e vedere se R502.n_timbrdip > 0 oppure se R502.TurniExtraPianificati['C']
    if not FestivoLavorato then   //se non ci sono timbrature ma il check 'Considera festività già recuperate' è attivo
      for i:=1 to n_giusgga do
        if tgius_ggass[i].tipocumulo = 'P' then
        begin
          FestivoLavorato:=True;
          Break;
        end;
    if (gglav = 'si') and FestivoLavorato then
      ................
*)
  //Alberto 20/06/2006
  if (selV010.GetVariable('DADATA') <> Inizio) or (selV010.GetVariable('ADATA') <> Fine) then
  begin
    selV010.Close;
    selV010.SetVariable('DADATA',Inizio);
    selV010.SetVariable('ADATA',Fine);
  end;
  selV010.Open;
  selV010.First;
  Conta:=0;
  R502ProDtM1.Chiamante:='Cartolina';
  R502ProDtM1.PeriodoConteggi(Inizio,Fine);
  {$IFNDEF MEDP803}R502ProDtM1.Q040.Close;{$ENDIF}
  DataCorr:=Inizio;
  Causali:=',' + Q265.FieldByname('ASSTOLL').AsString + ',';
  while DataCorr <= Fine do
  begin
    Contagg:=0;
    if selV010.SearchRecord('DATA',DataCorr,[srFromBeginning]) and
      ((selV010.FieldByName('FESTIVO').AsString = 'S') or
      ((selV010.FieldByName('FESTIVO').AsString = 'N') and (Q265.FieldByname('CP_DOMENICHE').AsString = 'S'))) then
    begin
      R502ProDtM1.Conteggi('Cartolina',Progressivo,DataCorr);
      if R502ProDtM1.Blocca = 0 then //no anomalia bloccante
      begin
        if selV010.FieldByName('FESTIVO').AsString = 'S' then  //se festivo
        begin
          if R502ProDtM1.n_timbrdip > 0 then
            Contagg:=CheckTimbrature(Q265.FieldByname('CP_PIANIFREPER').AsString)
            //Conta:=Conta + 1
          else if Q265.FieldByname('CP_FESTGIUSTIF').AsString = 'S' then  //se giustificato
          begin
            for i:=1 to R502ProDtM1.n_giusgga do
              if R502ProDtM1.tgius_ggass[i].tipocumulo = 'P' then
              begin
                Contagg:=1;
                Break;
              end;
          end
          else if Q265.FieldByname('CP_PIANIFREPER').AsString = 'S' then   //se reperibile
          begin
            if Trim(R502ProDtM1.TurniExtraPianificati['C']) <> '' then
              Contagg:=1;
          end;
          //Alberto 06/10/2008 (Firenze_Comune): Gestione di ASSTOLL
          if (Contagg = 0) and (R502ProDtM1.n_giusgga > 0) then
          begin
            if (Trim(R502ProDtM1.tgius_ggass[1].tcausggass) <> '') and (Pos(',' + R502ProDtM1.tgius_ggass[1].tcausggass + ',',Causali) > 0) then
              Contagg:=1
            else if (Trim(R502ProDtM1.tgius_ggass[2].tcausggass) <> '') and (Pos(',' + R502ProDtM1.tgius_ggass[2].tcausggass + ',',Causali) > 0) then
              Contagg:=1;
          end;
        end
        else  //se domenica e se checked
        begin
          if R502ProDtM1.n_timbrdip > 0 then
            Contagg:=CheckTimbrature(Q265.FieldByname('CP_PIANIFREPER').AsString)
          else if Q265.FieldByname('CP_PIANIFREPER').AsString = 'S' then  //se reperibile
          begin
            if Trim(R502ProDtM1.TurniExtraPianificati['C']) <> '' then
              Contagg:=1;
          end;
          //Alberto 06/10/2008 (Firenze_Comune): Gestione di ASSTOLL
          if (Contagg = 0) and (R502ProDtM1.n_giusgga > 0) then
          begin
            if (Trim(R502ProDtM1.tgius_ggass[1].tcausggass) <> '') and (Pos(',' + R502ProDtM1.tgius_ggass[1].tcausggass + ',',Causali) > 0) then
              Contagg:=1
            else if (Trim(R502ProDtM1.tgius_ggass[2].tcausggass) <> '') and (Pos(',' + R502ProDtM1.tgius_ggass[2].tcausggass + ',',Causali) > 0) then
              Contagg:=1;
          end;
        end;
      end;
    end;
    Conta:=Conta + Contagg;
    DataCorr:=DataCorr + 1;
  end;
  Competenze[1]:=Competenze[1] + Conta;
  CompetenzeOri[1]:=Competenze[1];
  CompetenzeParziali[1]:=CompetenzeParziali[1] + Conta;
  selV010.Close;
(*  Competenze[1]:=Competenze[1] + Q102.FieldByName('Totale').AsInteger;
  CompetenzeOri[1]:=Competenze[1];
  CompetenzeParziali[1]:=CompetenzeParziali[1] + Q102.FieldByName('Totale').AsInteger;
  Q102.Close;*)
end;

procedure TR600Dtm1.GetTurniReperibilitaNOChiamata(Inizio,Fine:TDateTime);
{Usato per tipo cumulo = 'V' (Torino_Comune)}
begin
  with T380F_Turnifestivi_NOChiamata do
  begin
    SetVariable('PROG',Progressivo);
    SetVariable('INIZIOCUMULO',Inizio);
    SetVariable('FINECUMULO',Fine);
    Execute;
    Competenze[1]:=Competenze[1] + GetVariable('NUMTURNI');
    CompetenzeOri[1]:=Competenze[1];
    CompetenzeParziali[1]:=CompetenzeParziali[1] + GetVariable('NUMTURNI');
    Close;
  end;
end;

procedure TR600DtM1.GetFesteInfrasettimanali(Inizio,Fine:TDateTime);
{Usato per tipo cumulo = 'U' (Genova_HSMartino)
 Le competenze sono maturate in base ai giorni festivi infrasettimanali
 non già giustificati con causali specificate in ASSTOLL}
var Causali:String;
begin
  //UMisura:='O';
  Causali:=StringReplace(Q265.FieldByname('ASSTOLL').AsString,',',''',''',[rfReplaceAll]);
  if Causali = '' then
    Causali:='''' + Q265.FieldByname('CODICE').AsString + ''''
  else
    Causali:='''' + Q265.FieldByname('CODICE').AsString + ''',''' + Causali + '''';
  with selFestiviInfraSett do
  begin
    (*if (GetVariable('PROGRESSIVO') <> Progressivo) or
       (GetVariable('DADATA') <> Inizio) or
       (GetVariable('ADATA') <> Fine) or
       (GetVariable('CAUSALI') <> Causali) then*)
    begin
      SetVariable('PROGRESSIVO',Progressivo);
      SetVariable('DADATA',Inizio);
      SetVariable('ADATA',Fine);
      SetVariable('CAUSALI',Causali);
      SetVariable('UMISURA',UMisura);
      Execute;
    end;
  end;
  Competenze[1]:=Competenze[1] + selFestiviInfraSett.FieldAsInteger('Totale');
  CompetenzeOri[1]:=Competenze[1];
  CompetenzeParziali[1]:=CompetenzeParziali[1] + selFestiviInfraSett.FieldAsInteger('Totale');
  selFestiviInfraSett.Close;
end;

procedure TR600DtM1.GetTurniReperibilitaFestivi(Inizio,Fine:TDateTime);
{Usato per tipo cumulo = 'V' (Torino_HMolinette)
 Le competenze sono maturate in base ai turni di reperibilità pianificati nei giorni
 Festivi o le domeniche. Sul cavallo di mezzanotte si verifica la maturazione sia sul
 giorno di entrata che su quello di uscita.}
begin
  with GetTurRepFest do
  begin
    SetVariable('PROG',Progressivo);
    SetVariable('INIZIOCUMULO',Inizio);
    SetVariable('FINECUMULO',Fine);
    Execute;
    Competenze[1]:=Competenze[1] + GetVariable('NUMTURNI');
    CompetenzeOri[1]:=Competenze[1];
    CompetenzeParziali[1]:=CompetenzeParziali[1] + GetVariable('NUMTURNI');
    Close;
  end;
end;

procedure TR600DtM1.GetResiduiAnnoPrec(Anno:Integer);
{Restituisce il saldo ore residue dell'anno precedente per causale di recupero ore
 anno precedente}
begin
  UMisura:='O';
  with Q130 do
  begin
     //Alberto 20/06/2006
    if StrToIntDef(VarToStr(GetVariable('Anno')),0) <> Anno then
    begin
      Close;
      SetVariable('Anno',Anno);
    end;
    Open;
    if RecordCount > 0 then
    begin
      CompetenzeLette[1]:=FieldByName('SaldoOreLav').AsString;
      Competenze[1]:=Competenze[1] + R180OreMinutiExt(CompetenzeLette[1]);
      CompetenzeOri[1]:=Competenze[1];
      CompetenzeParziali[1]:=R180OreMinutiExt(CompetenzeLette[1]);
    end;
    Close;
  end;
end;

procedure TR600DtM1.GetGiorniNonLavorativi(Inizio,Fine:TDateTime);
var
  iTotComp: Integer;
begin
  UMisura:='G';
  with selGGnonLav do
  begin
    if (GetVariable('Progressivo') <> Progressivo) or
       (GetVariable('DaData') <> Inizio) or
       (GetVariable('AData') <> Fine) then
    begin
      SetVariable('Progressivo',Progressivo);
      SetVariable('DaData',Inizio);
      SetVariable('AData',Fine);
      Execute;
    end;

    //Inizializzo le competenze totali
    iTotComp:=0;
    if Q265.FieldByName('UMCUMULO').AsString <> 'N' then
      //Aggiungo le domeniche salvo che non sia previsto che vengano considerate
      iTotComp:=iTotComp + FieldAsInteger(0);
    if Q265.FieldByName('CQ_FESTIVI').AsString = 'S' then
      //Aggiungo i Festivi dei giorni non lavorativi
      iTotComp:=iTotComp + FieldAsInteger(3);
    if Q265.FieldByName('CQ_GGNONLAV').AsString = 'S' then
      //Aggiungo i giorni non lavorativi e non festivi
      iTotComp:=iTotComp + FieldAsInteger(1);
    if Q265.FieldByName('CQ_GGNONLAV').AsString = 'F' then
      //Aggiungo i (giorni non lavorativi e non festivi) + (giorni non lavorativi e festivi)
      iTotComp:=iTotComp + FieldAsInteger(1) + FieldAsInteger(2);
    Competenze[1]:=Competenze[1] + iTotComp;
    CompetenzeOri[1]:=Competenze[1];
    CompetenzeParziali[1]:=iTotComp;
    CompetenzeLette[1]:=IntToStr(iTotComp);
(*
    if (Q265.FieldByName('CQ_FESTIVI').AsString = 'N') and (Q265.FieldByName('CQ_GGNONLAV').AsString = 'N') then //Lorena 04/06/2004
    begin //Solo Domeniche
      CompetenzeLette[1]:=FieldAsString(0);
      Competenze[1]:=Competenze[1] + FieldAsInteger(0);
      CompetenzeOri[1]:=Competenze[1];
      CompetenzeParziali[1]:=FieldAsInteger(0);
    end;
    if (Q265.FieldByName('CQ_FESTIVI').AsString = 'S') and (Q265.FieldByName('CQ_GGNONLAV').AsString = 'N') then //Lorena 04/06/2004
    begin //Domeniche + Festivi
      CompetenzeLette[1]:=IntToStr(FieldAsInteger(0) + FieldAsInteger(2) + FieldAsInteger(3));
      Competenze[1]:=Competenze[1] + FieldAsInteger(0) + FieldAsInteger(2) + FieldAsInteger(3);
      CompetenzeOri[1]:=Competenze[1];
      CompetenzeParziali[1]:=FieldAsInteger(0) + FieldAsInteger(2) + FieldAsInteger(3);
    end;
    if (Q265.FieldByName('CQ_FESTIVI').AsString = 'N') and (Q265.FieldByName('CQ_GGNONLAV').AsString = 'S') then //Lorena 04/06/2004
    begin //Domeniche + GGNonLav
//      CompetenzeLette[1]:=IntToStr(FieldAsInteger(0) + FieldAsInteger(1) + FieldAsInteger(2));
//      Competenze[1]:=Competenze[1] + FieldAsInteger(0) + FieldAsInteger(1) + FieldAsInteger(2);
//      CompetenzeOri[1]:=Competenze[1];
//      CompetenzeParziali[1]:=FieldAsInteger(0) + FieldAsInteger(1) + FieldAsInteger(2); //Lorena 27/10/2005
      CompetenzeLette[1]:=IntToStr(FieldAsInteger(0) + FieldAsInteger(1));
      Competenze[1]:=Competenze[1] + FieldAsInteger(0) + FieldAsInteger(1);
      CompetenzeOri[1]:=Competenze[1];
      CompetenzeParziali[1]:=FieldAsInteger(0) + FieldAsInteger(1);
    end;
    if (Q265.FieldByName('CQ_FESTIVI').AsString = 'S') and (Q265.FieldByName('CQ_GGNONLAV').AsString = 'S') then //Lorena 04/06/2004
    begin //Domeniche + Festivi + GGNonLav
      CompetenzeLette[1]:=IntToStr(FieldAsInteger(0) + FieldAsInteger(1) + FieldAsInteger(2) + FieldAsInteger(3));
      Competenze[1]:=Competenze[1] + FieldAsInteger(0) + FieldAsInteger(1) + FieldAsInteger(2) + FieldAsInteger(3);
      CompetenzeOri[1]:=Competenze[1];
      CompetenzeParziali[1]:=FieldAsInteger(0) + FieldAsInteger(1) + FieldAsInteger(2) + FieldAsInteger(3);
    end;
*)
  end;
end;

function TR600DtM1.MaturAssenze:Integer;
var i:Integer;
    NumGG:Real;
begin
  Result:=0;
  //Scorro le assenze fatte nel giorno
  for i:=1 to R502ProDtM1.n_riepasse do
  begin
    //Ciascuna assenza la conto come se non fosse tollerata
    Result:=Result + R502ProDtM1.triepgiusasse[i].tminresasse;
    selT266.First;
    while not selT266.Eof do
    begin
      //Ricerco l'assenza tra quelle tollerate
      if Pos(',' + R502ProDtM1.triepgiusasse[i].tcausasse + ',',',' + selT266.FieldByName('CAUSALI').AsString + ',') > 0 then
      begin
        NumGG:=R502ProDtM1.triepgiusasse[i].tggasse + (0.5 * R502ProDtM1.triepgiusasse[i].tmezggasse);
        if selT266.FieldByname('NUMGG').IsNull then
          //L'assenza è tollerata senza alcun massimale, quindi non la considero più nel Result
          Result:=Result - R502ProDtM1.triepgiusasse[i].tminresasse
        else if selT266.FieldByname('NUMGG').AsFloat > 0 then
        begin
          //L'assenza è tollerata con massimale, scalo dal massimale la quantità fruita
          selT266.Edit;
          selT266.FieldByname('NUMGG').AsFloat:=selT266.FieldByname('NUMGG').AsFloat - NumGG;
          selT266.Post;
          //Non considero l'assenza nel result, ma poi aggiungo la parte che eventualmente ha fatto andare in negativo il massimale
          Result:=Result - R502ProDtM1.triepgiusasse[i].tminresasse;
          if selT266.FieldByname('NUMGG').AsFloat < 0 then
            Result:=Result + Trunc((-selT266.FieldByname('NUMGG').AsFloat) / NumGG * R502ProDtM1.triepgiusasse[i].tminresasse);
        end;
        Break;
      end;
      selT266.Next;
    end;
    (*
    if not Esiste(R502ProDtM1.triepgiusasse[i].tcausasse) then
      //Conto Giornate e mezze giornate valorizzate in ore
      Result:=Result + R502ProDtM1.triepgiusasse[i].tminresasse;
    *)
  end;
end;

procedure TR600DtM1.GetPeriodiAssenza(Causali:String);  //Lorena 03/06/2008
var DataOld,DataInizio:TDateTime;
  TotGG:Integer;
begin
  //carica nel ClientDataset cdsPeriodiAssenza i periodi di assenza delle Causali passate
  cdsPeriodiAssenza.Close;
  cdsPeriodiAssenza.FieldDefs.Clear;
  cdsPeriodiAssenza.FieldDefs.Add('DATAINIZIO',ftDate);
  cdsPeriodiAssenza.FieldDefs.Add('DATAFINE',ftDate);
  cdsPeriodiAssenza.FieldDefs.Add('CAUSALE',ftString,5);
  cdsPeriodiAssenza.FieldDefs.Add('DESCRIZIONE',ftString,40);
  cdsPeriodiAssenza.FieldDefs.Add('TOTALEGG',ftInteger);
  cdsPeriodiAssenza.IndexDefs.Clear;
  cdsPeriodiAssenza.IndexDefs.Add('Primario',('DATAINIZIO'),[ixDescending]);
  cdsPeriodiAssenza.IndexName:='Primario';
  cdsPeriodiAssenza.CreateDataSet;
  cdsPeriodiAssenza.LogChanges:=False;
  selPeriodiAssenza.Close;
  selPeriodiAssenza.SetVariable('PROG',Progressivo);
  selPeriodiAssenza.SetVariable('CAUSALE','''' + StringReplace(Causali,',',''',''',[rfReplaceAll]) + '''');
  selPeriodiAssenza.Open;
  selPeriodiAssenza.First;
  DataOld:=selPeriodiAssenza.FieldByName('DATA').AsDateTime-1;
  DataInizio:=selPeriodiAssenza.FieldByName('DATA').AsDateTime;
  TotGG:=0;
  while not selPeriodiAssenza.Eof do
  begin
    if selPeriodiAssenza.FieldByName('DATA').AsDateTime <> (DataOld + 1) then
    begin
      cdsPeriodiAssenza.Insert;
      cdsPeriodiAssenza.FieldByName('DATAINIZIO').AsDateTime:=DataInizio;
      cdsPeriodiAssenza.FieldByName('CAUSALE').AsString:=selPeriodiAssenza.FieldByName('CAUSALE').AsString;
      cdsPeriodiAssenza.FieldByName('DESCRIZIONE').AsString:=selPeriodiAssenza.FieldByName('DESCRIZIONE').AsString;
      cdsPeriodiAssenza.FieldByName('DATAFINE').AsDateTime:=DataOld;
      cdsPeriodiAssenza.FieldByName('TOTALEGG').AsInteger:=TotGG;
      cdsPeriodiAssenza.Post;
      DataInizio:=selPeriodiAssenza.FieldByName('DATA').AsDateTime;
      TotGG:=0;
    end;
    DataOld:=selPeriodiAssenza.FieldByName('DATA').AsDateTime;
    inc(TotGG);
    selPeriodiAssenza.Next;
  end;
  if selPeriodiAssenza.FieldByName('DATA').AsDateTime <> (DataOld + 1) then
  begin
    cdsPeriodiAssenza.Insert;
    cdsPeriodiAssenza.FieldByName('DATAINIZIO').AsDateTime:=DataInizio;
    cdsPeriodiAssenza.FieldByName('CAUSALE').AsString:=selPeriodiAssenza.FieldByName('CAUSALE').AsString;
    cdsPeriodiAssenza.FieldByName('DESCRIZIONE').AsString:=selPeriodiAssenza.FieldByName('DESCRIZIONE').AsString;
    cdsPeriodiAssenza.FieldByName('DATAFINE').AsDateTime:=DataOld;
    cdsPeriodiAssenza.FieldByName('TOTALEGG').AsInteger:=TotGG;
    cdsPeriodiAssenza.Post;
  end;
end;

//-------------------------------------------------------------------------------
//----------- C O N T R O L L I   G I O R N A L I E R I -------------------------
//-------------------------------------------------------------------------------
procedure TR600DtM1.ControllaVincoliFruizione(Minuti,Minimo,Massimo,Arrot:Integer; var Fruizione:Integer);
begin
  Fruizione:=Minuti;
  //Controllo fruizione minima
  if Fruizione < Minimo then
  begin
    Fruizione:=0;
    exit;
  end;
  //Controllo fruizione massima
  if Fruizione > Massimo then
    Fruizione:=Massimo;
  //Arrotondamento fruizione
  if Arrot > 0 then
    Fruizione:=Trunc(R180Arrotonda(Fruizione,Arrot,'D'));
end;

procedure TR600DtM1.ControllaFruizMaxDebito(D:TDateTime; P,Minuti:Integer; Causale,TG,Dalle,Alle:String; var Fruizione:Integer);
begin
  Fruizione:=Minuti;
  R502ProDtM1.Chiamante:='APERTURA';
  R502ProDtM1.PeriodoConteggi(D,D);
  //Alberto 08/07/2010: conteggio il giustificativo da valutare per vedere se eccede il debito gg anche come valenza oraria
  with R502ProDtM1 do
  begin
    SetLength(GiustificativiR600,1);
    GiustificativiR600[0].causale:=Causale;
    GiustificativiR600[0].causale_nuova:='';
    GiustificativiR600[0].progrcausale:=-1;
    GiustificativiR600[0].tipogiust:=R180CarattereDef(TG,1,#0);
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    // il tipo giustificativo può essere solo 'N' o 'D'
    // pertanto il tipo mezza giornata è sempre stringa vuota
    GiustificativiR600[0].tipomg:='';
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    GiustificativiR600[0].dalle:=StrToTime(Dalle);
    if TG = 'D' then
      GiustificativiR600[0].alle:=StrToTime(Alle)
    else
      GiustificativiR600[0].alle:=EncodeTime(0,0,0,0);
    GiustificativiR600[0].hhmmasse:=0;
    GiustificativiR600[0].ggasse:=0;
    GiustificativiR600[0].mezggasse:=0;
    GiustificativiR600[0].minasse:=0;
    GiustificativiR600[0].minvalasse:=0;
    GiustificativiR600[0].minresasse:=0;
    GiustificativiR600[0].puntAssCum:=-1;
    GiustificativiR600[0].RichiestaWeb:='N';
  end;
  R502ProDtM1.ConteggiaGiustificativiR600:=True;
  R502ProDtM1.esegui_z432:=False;
  R502ProDtM1.Conteggi('Cartolina',P,D);
  R502ProDtM1.ConteggiaGiustificativiR600:=False;
  R502ProDtM1.esegui_z432:=True;
  if Fruizione > R502ProDtM1.debitogg then
  begin
    //Fruizione:=R502ProDtM1.debitogg;
    if R502ProDtM1.GiustificativiR600[0].minvalasse > R502ProDtM1.debitogg then
      dec(Fruizione,R502ProDtM1.GiustificativiR600[0].minvalasse - R502ProDtM1.debitogg);
  end;
end;

function TR600DtM1.SuperoFruizMaxOre(DataIns:TDateTime; Progressivo,Durata:Integer; Causale:String):boolean;
begin
  with selT262 do
  begin
    if (StrToIntDef(VarToStr(GetVariable('PROGRESSIVO')),0) <> Progressivo ) or
       (GetVariable('DATAINS') <> DataIns) or
       (VarToStr(GetVariable('CAUSALE')) <> Causale) then
    begin
      SetVariable('Progressivo',Progressivo);
      SetVariable('DataIns',DataIns);
      SetVariable('Causale',Causale);
      Close;
    end;
    Open;
    Result:=(Durata > FieldByName('MAX_FRUIZIONE_GIORN_IN_ORE').AsInteger);
  end;
end;

function TR600DtM1.GiornoSignificativo(Data:TDateTime):TModalResult;
{Controllo la significatività del giorno per sapere se inserire o meno la causale}
var GTurnista,GSignif,Info,Info1,D:String;
begin
  D:=DateToStr(Data);
  Info1:=Format(DataNome,[D,Matricola,Nome,Chr(13),CausAnomala,Chr(13)]);
  Result:=mrOK;
  if (TipoCumulo = 'M') and (FormatDateTime('yyyy',InizioCumulo) <> FormatDateTime('yyyy',Data)) then
    //Se tipo cumulo = M, posso inserire i giorni solo
    //nell'ambito dello stesso anno (per semplicità)
  begin
    Result:=mrIgnore;
    exit;
  end;
  GSignif:=Q265.FieldByName('GSignific').AsString;
  //Tutti i giorni sono significativi
  if GSignif = 'GC' then exit;
  //Tutti i giorni dal lunedì al sabato sono significativi
  if GSignif = 'G6' then
    if DayOfWeek(Data) = 1 then //Se Domenica salto il giorno
    begin
      Result:=mrIgnore;
      exit;
    end;
  //Leggo sul calendario se giorno lavorativo o meno
  if GSignif = 'GL' then
  begin
    Result:=GiornoLavorativo(Data);
    exit;
  end;
  //Leggo se gestione turnista
  if not QSDip.LocDatoStorico(Data) then
  begin
    AnomaliaAssenze:=13;
    Info:=Info1 + Messaggi[13];
    Result:=Anomalie(3,Info);
    Exit;
  end;
  GTurnista:=QSDip.FieldByName('T430TGestione').AsString;
  if GSignif = 'GT' then
    if GTurnista = '1' then
      Result:=RiposoPianificato(Data)
    else
      Result:=GiornoLavorativo(Data);
  if GSignif = 'EF' then //Lorena 05/12/2005
  begin
    GiornoLavorativo(Data);
    if (VarToStr(GetCalend.GetVariable('F')) = 'S') and (VarToStr(GetCalend.GetVariable('L')) = 'S') then
    begin
      Result:=mrIgnore;
      exit;
    end;
  end;
  if GSignif = 'DF' then //Lorena 24/03/2006
  begin
    GiornoLavorativo(Data);
    if (VarToStr(GetCalend.GetVariable('F')) = 'N') and (DayOfWeek(Data) <> 1) then
    begin
      Result:=mrIgnore;
      exit;
    end;
  end;
end;

function TR600DtM1.GiornoLavorativo(Data:TDateTime):TModalResult;
{Leggo sul calendario del dipendente se il giorno e' lavorativo}
var L,F,Info,D:String;
begin
  Result:=mrIgnore;
  //Leggo il calendario da anagrafico
  if not QSDip.LocDatoStorico(Data) then
  begin
    AnomaliaAssenze:=13;
    D:=DateToStr(Data);
    Info:=Format(DataNome,[D,Matricola,Nome,Chr(13),CausAnomala,Chr(13)]) + Messaggi[13];
    Result:=Anomalie(3,Info);
    exit;
  end;
  with GetCalend do
  begin
    if (GetVariable('Prog') <> Progressivo) or (GetVariable('D') <> Data) then
    begin
      SetVariable('Prog',Progressivo);
      SetVariable('D',Data);
      Execute;
    end;
    if (VarToStr(GetVariable('L')) = '') and (VarToStr(GetVariable('F')) = '') and (GetVariable('G') = 0) then
    begin
      AnomaliaAssenze:=39;
      D:=DateToStr(Data);
      Info:=Format(DataNome,[D,Matricola,Nome,Chr(13),CausAnomala,Chr(13)]) + Messaggi[39];
      Result:=Anomalie(3,Info);
      exit;
    end;
    L:=VarToStr(GetVariable('L'));
    F:=VarToStr(GetVariable('F'));
    if (L = 'S') and (F = 'N') then
      Result:=mrOK
    else
      Result:=mrIgnore;
  end;
end;

function TR600DtM1.MGSignificativa(Data:TDateTime):TModalResult;
var DaOre,AOre:String;
begin
  Result:=mrOk;
  R502ProDtM1.Chiamante:='Cartolina';
  R502ProDtM1.PeriodoConteggi(Data,Data);
  R502ProDtM1.Conteggi('Cartolina',Progressivo,Data);
  if Giustificativo.CSITipoMG = 'M' then
  begin
    DaOre:=R502ProDtM1.ValStrT021['ENTRATA',TF_MG_MAT,1];
    Aore:=R502ProDtM1.ValStrT021['USCITA',TF_MG_MAT,1];
  end
  else if Giustificativo.CSITipoMG = 'P' then
  begin
    DaOre:=R502ProDtM1.ValStrT021['ENTRATA',TF_MG_POM,1];
    Aore:=R502ProDtM1.ValStrT021['USCITA',TF_MG_POM,1];
  end;
  if (DaOre = '') or (AOre = '') then
    Result:=mrIgnore;
end;


function TR600DtM1.RiposoPianificato(Data:TDateTime):TModalResult;
{Leggo su pianificazione turni se è stato pianificato un riposo}
var NP,NT,NG:Byte;
begin
  Result:=mrIgnore;
  //Riposo pianificato
  with Q080 do
  begin
    //Alberto 20/06/2006
    if GetVariable('Data') <> Data then
    begin
      Close;
      SetVariable('Data',Data);
    end;
    Open;
    First;
    if RecordCount > 0 then
      if (FieldByName('Turno1').AsString = '0') or (FieldByName('Turno2').AsString = '0') then
        exit;
    NP:=RecordCount;
  end;
  //Riposo giustificato
  with NumRiposi do
  begin
    //Alberto 20/06/2006
    if (GetVariable('Data') <> Data) or
       (VarToStr(GetVariable('CodInterno')) <> CRiposo) or
       (VarToStr(GetVariable('RichiesteIterAutorizzativo')) <> IfThen(RichiesteIterAutorizzativo,'S','N')) then
    begin
      Close;
      SetVariable('Data',Data);
      SetVariable('CodInterno',CRiposo);
      SetVariable('RichiesteIterAutorizzativo',IfThen(RichiesteIterAutorizzativo,'S','N'));
    end;
    Open;
    if Fields[0].AsInteger > 0 then exit;
  end;
  //Controllo numero di timbrature
  with Q100 do
  begin
    //Alberto 20/06/2006
    if GetVariable('Data') <> Data then
    begin
      Close;
      SetVariable('Data',Data);
    end;
    Open;
    First;
    NT:=RecordCount;
  end;
  //Controllo numero di giustificativi
  with Q040 do
  begin
    //Alberto 20/06/2006
    if GetVariable('Data') <> Data then
    begin
      Close;
      SetVariable('Data',Data);
    end;
    Open;
    First;
    NG:=Fields[0].AsInteger;
  end;
  //Se ho dei giustificativi o delle timbrature o il turno è pianificato
  //posso inserire il giustificativo
  if (NG > 0) or (NT > 0) or (NP > 0) then
    Result:=mrOK;
  //Se il giorno è vuoto posso inserire il giustificativo
  if (NG = 0) and (NT = 0) then
    Result:=mrOK;
end;

function TR600DtM1.ControlliGenerali(Data:TDateTime; CheckSoloCompetenze:Boolean = False):TModalResult;
var NG,NMG,NR:Byte;
    Info,Info1,sPeriodoFruizione,Caus,CausCheckComp:String;
    Abil,Storico:Boolean;
    GGSignificResult,ResAnom:TModalResult;
    PrgConiuge:LongInt;
    MiLavorativi,MiMaxGG,MiFrutiGG:Integer;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    LMaxFruizMG: Integer;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    LFruizGG: Real;

  function AnomaliaGrave(Res1,Res2:TModalResult):TModalResult;
  begin
    Result:=Res1;
    if (Res1 <> mrAbort) and (Res2 <> mrOK) then
       Result:=Res2;
  end;
begin
  Result:=mrOK;
  EsistonoAnomalieBloccanti:=False;
  InserimentoImpedito:=False;
  AssenzeConteggiate_Inserita:=False;
  AnomaliaAssenze:=0;
  Info1:=Format(DataNome,[DateToStr(Data),Matricola,Nome,Chr(13),CausAnomala,Chr(13)]);
  Abil:=True;

  if not CheckSoloCompetenze then
    //Alberto 10/07/2018 - CCNL 2018: inserimento causali automatiche che non devono effettuare i controlli sul cartellino
    CheckSoloCompetenze:=GetValStrT230(Q265.FieldByName('CODICE').AsString,'CHECK_SOLOCOMPETENZE',Data) = 'S';

  if not CheckSoloCompetenze then
  begin
    if not DipendenteInServizio.DipendenteInServizio(Progressivo,Data,Data) then
    begin
      AnomaliaAssenze:=26;
      Info:=Info1 + Messaggi[26];
      Result:=AnomaliaGrave(Result,Anomalie(4,Info));
      //if Result <> mrOK then Exit;
    end;
    //Controllo se assenza fruibile da tutti (AssenzaAbilitata è stata impostata precedentemente da SettaConteggi)
    if AssenzaAbilitata and (Q265.FieldByName('Fruibile').AsString <> 'S') then
      //Leggo sugli storici se è abilitata
    begin
      Abil:=False;
      Storico:=True;
      if QSDip.LocDatoStorico(Data) then
        with TStringList.Create do
        begin
          CommaText:=QSDip.FieldByName('T430AbCausale1').AsString;
          Abil:=IndexOf(Q265.FieldByName('Codice').AsString) >= 0;
          Free;
        end
      else
        Storico:=False;
      if not Storico then
        //Storici inesistenti
      begin
        AnomaliaAssenze:=11;
        Info:=Info1 + Messaggi[11];
        ResAnom:=Anomalie(3,Info); //Bloccante
        exit;
      end;
    end;
    if (not Abil) or (not AssenzaAbilitata) then
    begin
      //Causale non abilitata
      AnomaliaAssenze:=12;
      Info:=Info1 + Messaggi[12];
      Result:=AnomaliaGrave(Result,Anomalie(2,Info)); //Bloccante
      exit;
    end;
    //Controllo che la data sia compresa nel periodo di fruizione
    if EsisteFruizione then
    begin
      if (Data < FruizDa) or (Data > FruizA) then
      begin
        //Alberto 16/05/2013: se fuori dal periodo di fruizione ma esiste una catena, simulo anomalia di fine competenze per passare su causale successiva.
        if not Q265.FieldByName('CAUSALE_SUCCESSIVA').IsNull then
        begin
          AnomaliaAssenze:=20;
          R180InizializzaArray(Competenze);
          Result:=AnomaliaGrave(Result,mrAbort); //Non si chiede alcuna conferma
          exit;
        end;
        AnomaliaAssenze:=14;
        Info:=Info1 + Format(Messaggi[14],[DateToStr(FruizDa),DateToStr(FruizA)]);
  //      if (Q265.FieldByName('NO_SUPERO_COMPETENZE').AsString = 'S') then  //Lorena 12/10/2011
        if IterAutorizzativo and (Q265.FieldByName('NO_SUPERO_COMPETENZE').AsString = 'N') then
        begin
          if (Q265.FieldByName('NO_SUPERO_COMPETENZE_WEB').AsString = 'S') then
            Result:=AnomaliaGrave(Result,Anomalie(3,Info))
          else
            Result:=AnomaliaGrave(Result,Anomalie(4,Info));
        end
        else if (Q265.FieldByName('NO_SUPERO_COMPETENZE').AsString = 'S') then
          Result:=AnomaliaGrave(Result,Anomalie(3,Info))
        else
          Result:=AnomaliaGrave(Result,Anomalie(4,Info));
        //if Result <> mrOK then Exit;
      end;
    end;
  end; //not CheckSoloCompetenze

  //Controllo giorni significativi  //Lorena 27/12/2005
  if Result = mrAbort then
    exit;
  GGSignific:=False;
  //Result:=AnomaliaGrave(Result,GiornoSignificativo(Data));
  //if Result = mrIgnore then
  GGSignificResult:=GiornoSignificativo(Data);
  if (GGSignificResult = mrOk) and (Giustificativo.Modo = 'M') and (Giustificativo.CSITipoMG <> '') then
    GGSignificResult:=MGSignificativa(Data);
  case GGSignificResult of
    mrIgnore:
    begin
      // MONDOEDP - chiamata <78745>.ini
      {
      GGSignific:=True;
      Exit;
      }
      GGSignific:=True;
      Result:=AnomaliaGrave(Result,mrIgnore);
      exit;
      // MONDOEDP - chiamata <78745>.fine
    end;
    mrAbort:
    begin
      Result:=mrAbort;
      Exit;
    end;
  end;
  //if Result <> mrOk then Exit;

  if not CheckSoloCompetenze then
  begin
    //Controllo limite massimo ore fruibili nel giorno
    if (Giustificativo.Modo = 'N') and (SuperoFruizMaxOre(Data,Progressivo,R180OreMinutiExt(Giustificativo.DaOre),Giustificativo.Causale)) then
    begin
      AnomaliaAssenze:=22;
      Info:=Info1 + Messaggi[22];
      Result:=AnomaliaGrave(Result,Anomalie(4,Info));
      //if Result <> mrOK then Exit;
    end;
    if (Giustificativo.Modo = 'D') and (SuperoFruizMaxOre(Data,Progressivo,R180OreMinutiExt(Giustificativo.Aore) - R180OreMinutiExt(Giustificativo.DaOre),Giustificativo.Causale)) then
    begin
      AnomaliaAssenze:=22;
      Info:=Info1 + Messaggi[22];
      Result:=AnomaliaGrave(Result,Anomalie(4,Info));
      //if Result <> mrOK then Exit;
    end;
    //TORINO_CSI: Controllo limite massimo ore fruibili nel giorno in base alle ore lavorative < di 6 o >= a 6
    if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    begin
      //Inizializzo minuti lavorativi a 24 ore
      MiLavorativi:=1440;
      if not Q265.FieldByname('OREGG_MAX_INF6').IsNull and not Q265.FieldByname('OREGG_MAX_SUP6').IsNull then
      begin
        //R502ProDtM1.datacon = Data
        R502ProDtM1.Chiamante:='Cartolina';
        R502ProDtM1.PeriodoConteggi(Data,Data);
        R502ProDtM1.Conteggi('Cartolina',Progressivo,Data);
        MiLavorativi:=R502ProDtM1.debitogg;
        //Imposto minuti massimi in fuzione delle ore lavorative
        if MiLavorativi < 360 then
          MiMaxGG:=R180OreMinutiExt(Q265.FieldByname('OREGG_MAX_INF6').AsString)
        else
          MiMaxGG:=R180OreMinutiExt(Q265.FieldByname('OREGG_MAX_SUP6').AsString);
        //Calcolo i minuti già fruiti con altro inserimento nel giorno
        MiFrutiGG:=R502ProDtM1.RiepAssenza[Q265.FieldByName('Codice').AsString,'HHVAL'];
        if (Giustificativo.Modo = 'N') and (MiFrutiGG + R180OreMinutiExt(Giustificativo.DaOre) > MiMaxGG) then
        begin
          AnomaliaAssenze:=32;
          Info:=Info1 + Messaggi[32];
          Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
          Exit;
        end;
        if (Giustificativo.Modo = 'D') and (MiFrutiGG + (R180OreMinutiExt(Giustificativo.Aore) - R180OreMinutiExt(Giustificativo.DaOre)) > MiMaxGG) then
        begin
          AnomaliaAssenze:=32;
          Info:=Info1 + Messaggi[32];
          Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
          Exit;
        end;
      end;
    end;

    //Leggo il codice interno di raggruppamento della causale che devo inserire
    with CausaleRiposo do
    begin
      //Alberto 20/06/2006
      if VarToStr(GetVariable('Codice')) <> Giustificativo.Causale then
      begin
        Close;
        SetVariable('Codice',Giustificativo.Causale);
      end;
      Open;
      Giustificativo.CodRagg:=FieldByName('CodInterno').AsString;
    end;
    //Non posso inserire un riposo che non sia una giornata intera
    if (Giustificativo.Modo <> 'I') and (Giustificativo.CodRagg = CRiposo) then
    begin
      AnomaliaAssenze:=9;
      Info:=Info1 + Messaggi[9];
      Result:=AnomaliaGrave(Result,Anomalie(2,Info)); //Bloccante
      Exit;
    end;
    //Numero di riposi già esistenti
    with NumRiposi do
    begin
      //Alberto 20/06/2006 - commentato daniloc. 02.09.2010
      //if (GetVariable('Data') <> Data) or (VarToStr(GetVariable('CodInterno')) <> CRiposo) then
      //begin
        Close;
        SetVariable('Data',Data);
        SetVariable('CodInterno',CRiposo);
        SetVariable('RichiesteIterAutorizzativo',IfThen(RichiesteIterAutorizzativo,'S','N'));
      //end;
      Open;
      NR:=Fields[0].AsInteger;
    end;
    //Non posso inserire più di un riposo in un giorno
    if (NR > 0) and (Giustificativo.CodRagg = CRiposo) then
    begin
      AnomaliaAssenze:=8;
      Info:=Info1 + Messaggi[8];
      Result:=AnomaliaGrave(Result,Anomalie(3,Info));  //Bloccante
      Exit;
    end;
    {Bruno(27/05/2015) - TORINO_CSI Gestione festività particolari
    Inibizione inserimento causale se compresa nelle causali incompatibili
     'Assenza %s non fruibile nel giorno %s di festività particolare %s.'}
    R180SetVariable(selCSI010,'PROGRESSIVO',Progressivo);
    selCSI010.Open;
    if selCSI010.SearchRecord('DATA_FESTIVITA',Data,[srFromBeginning]) and
       (R180CercaParolaIntera(Giustificativo.Causale,selCSI010.FieldByName('CAUS_INCOMP').asString,',') > 0) then
    begin
      AnomaliaAssenze:=33;
      Info:=Info1 + Format(Messaggi[33],[R180ValueToItem(TO_CSI_D_TipoFestivita,selCSI010.FieldByName('TIPO_FESTIVITA').AsString)]);
      Result:=AnomaliaGrave(Result,Anomalie(3,Info));  //Bloccante
      Exit;
    end;
    //Non posso superare il numero max di giustificativi
    with GiustifEsistenti do  //Lorena 27/12/2005
    begin
      //Alberto 20/06/2006 - commentato daniloc. 02.09.2010
      //if (GetVariable('Data') <> Data) or
      //   (StrToIntDef(VarToStr(GetVariable('Progressivo')),0) <> Progressivo) then
      //begin
        Close;
        SetVariable('Progressivo',Progressivo);
        SetVariable('Data',Data);
        SetVariable('RichiesteIterAutorizzativo',IfThen(RichiesteIterAutorizzativo,'S','N'));
      //end;
      Open;
      if Fields[0].AsInteger >= MaxGiustif then
      begin
        // daniloc.ini - adattato alla gestione con messaggi
        //Result:=Anomalie(3,'Superato il numero massimo di Giustificativi!');
        AnomaliaAssenze:=5;
        Info:=Info1 + Format(Messaggi[5],[MaxGiustif]);
        Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
        // daniloc.fine
        Exit;
      end;
    end;
    //Leggo le timbrature se inserisco Giornata o Da Ore ... A Ore
    if (Giustificativo.Modo = 'I') or (Giustificativo.Modo = 'D') then
    begin
      //Alberto 20/06/2006
      if Q100.GetVariable('Data') <> Data then
      begin
        Q100.Close;
        Q100.SetVariable('Data',Data);
      end;
      Q100.Open;
      Q100.First;
      if (Q100.RecordCount > 0) and (Giustificativo.Modo = 'I') and (Giustificativo.CodRagg <> CRiposo) then
        //Presenza di timbrature con giornata di assenza non riposo
      begin
        Info:='';
        while not Q100.Eof do
        begin
          Info:=Info + Q100.FieldByName('Verso').AsString +
                       FormatDateTime('hh.nn',Q100.FieldByName('Ora').AsDateTime) +
                       IfThen(Q100.FieldByName('Causale').AsString <> '',Format('(%s)',[Q100.FieldByName('Causale').AsString])) +
                       ' ';
          Q100.Next;
        end;
        AnomaliaAssenze:=1;
        Info:=Info1 + Format(Messaggi[1],[Chr(13),Info,Chr(13)]);
        Result:=AnomaliaGrave(Result,Anomalie(4,Info));
        //if Result <> mrOK then exit;
      end;
    end;
    //Non posso superare le 2 giornate di assenza
    if Giustificativo.Modo = 'I' then
    begin
      with RiposiEsistenti do
      begin
        Close;
        SetVariable('Data',Data);
        SetVariable('CodInterno',' ');
        SetVariable('RiposoComp',' ');
        SetVariable('TipoGiust','I');
        SetVariable('RichiesteIterAutorizzativo',IfThen(RichiesteIterAutorizzativo,'S','N'));
        Open;
        if Fields[0].AsInteger = 2 then
        begin
          AnomaliaAssenze:=3;
          Info:=Info1 + Messaggi[3];
          Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
          Exit;
        end;
      end;
    end;
    //Non posso superare le 2 mezze giornate di assenza
    if Giustificativo.Modo = 'M' then
    begin
      with RiposiEsistenti do
      begin
        Close;
        SetVariable('Data',Data);
        SetVariable('CodInterno',' ');
        SetVariable('RiposoComp',' ');
        SetVariable('TipoGiust','M');
        SetVariable('RichiesteIterAutorizzativo',IfThen(RichiesteIterAutorizzativo,'S','N'));
        Open;
        if Fields[0].AsInteger = 2 then
        begin
          AnomaliaAssenze:=4;
          Info:=Info1 + Messaggi[4];
          Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
          Exit;
        end;
      end;
    end;
    //Non posso avere due giustificativi non-riposo tranne il caso di 2 mezze giornate
    if (Giustificativo.Modo = 'I') or (Giustificativo.Modo = 'M') then
      //Cerco se ci sono causali di non-riposo sia a giornata che a mezza giornata
      with RiposiEsistenti do
      begin
        Close;
        SetVariable('Data',Data);
        SetVariable('CodInterno',CRiposo);
        SetVariable('RiposoComp',CRiposoComp);
        SetVariable('TipoGiust','I');
        SetVariable('RichiesteIterAutorizzativo',IfThen(RichiesteIterAutorizzativo,'S','N'));
        Open;
        //Numero giornate di non riposo
        NG:=Fields[0].AsInteger;
        Caus:=Fields[1].AsString;
        Close;
        SetVariable('TipoGiust','M');
        SetVariable('RiposoComp',' ');
        Open;
        //Numero mezze giornate di non riposo
        NMG:=Fields[0].AsInteger;
        if Caus = '' then
          Caus:=Fields[1].AsString;
        if (NG > 0) or (NMG > 0) then
          //Se ci sono assenze non-riposo controllo com'è quella da inserire
          if (Giustificativo.CodRagg <> CRiposo) and (Giustificativo.CodRagg <> CRiposoComp) then //Lorena 11/04/2006
          begin
            //Alberto 01/10/2012: non si può inserire 2 gg di assenza (bloccante) ma si può inserire una gg + una mg (anom.non bloccante)
            //Posso inserire due mezze giornate di non-riposo
            if NG + (NMG/2) + IfThen(Giustificativo.Modo = 'I',1,0.5) >= 2 then
            //if not((NG = 0) and (NMG = 1) and (Giustificativo.Modo = 'M')) then
            begin
              //Se anche questa è di non-riposo esco
              AnomaliaAssenze:=2;
              Info:=Info1 + Format(Messaggi[2],[Caus]);
              Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
              Exit;
            end
            else if NG + (NMG/2) + IfThen(Giustificativo.Modo = 'I',1,0.5) > 1 then
            begin
              AnomaliaAssenze:=29;
              Info:=Info1 + Messaggi[29];
              Result:=AnomaliaGrave(Result,Anomalie(IfThen(Parametri.CampiRiferimento.C31_Giustif_GGMG = 'S',4,3),Info));
              //if Result <> mrOK then exit;
            end
          end
          //Inserimento di riposo o riposo non compensativo su giornata già giustificata
          else if NG > 0 then
          begin
            //Se anche questa è di non-riposo esco
            AnomaliaAssenze:=23;
            Info:=Info1 + Messaggi[23];
            Result:=AnomaliaGrave(Result,Anomalie(4,Info));
            //if Result <> mrOK then exit;
          end;
      end;

    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    // non è possibile fruire 2 mezze giornate dello stesso tipo (mattina/pomeriggio) nello stesso giorno
    if Giustificativo.CSITipoMG <> '' then
    begin
      selCountFruizioniMGData.SetVariable('Progressivo',Progressivo);
      selCountFruizioniMGData.SetVariable('Data',Data);
      selCountFruizioniMGData.SetVariable('RichiesteIterAutorizzativo',IfThen(RichiesteIterAutorizzativo,'S','N'));
      selCountFruizioniMGData.Execute;
      if selCountFruizioniMGData.FieldAsInteger(IfThen(Giustificativo.CSITipoMG = 'M','MGM','MGP')) > 0 then
      begin
        AnomaliaAssenze:=35;
        Info:=Info1 + Format(Messaggi[AnomaliaAssenze],[IfThen(Giustificativo.CSITipoMG = 'M','mattina','pomeriggio')]);
        Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
        Exit;
      end;
    end;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

    //Alberto 01/06/2018 - CCNL 2018: controllo incompatibilità tra fruizioni di causali di assenza
    with T040F_CHECKFRUIZCOMPATIBILE do
    begin
      ClearVariables;
      SetVariable('TABELLA',IfThen(IterAutorizzativo,'T050','T040'));
      SetVariable('PROGRESSIVO',Progressivo);
      SetVariable('DATA',Data);
      SetVariable('CAUSALE',Giustificativo.Causale);
      SetVariable('TIPOGIUST',Giustificativo.Modo);
      SetVariable('DAORE',Giustificativo.DaOre);
      SetVariable('AORE',Giustificativo.AOre);
      SetVariable('FAMILIARE',RiferimentoDataNascita.Data);
      Execute;
      if VarToStr(GetVariable('CAUSALI_INCOMPATIBILI')) <> '' then
      begin
        AnomaliaAssenze:=36;
        Info:=Info1 + Format(Messaggi[AnomaliaAssenze],[VarToStr(GetVariable('CAUSALI_INCOMPATIBILI'))]);
        Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
        Exit;
      end;
    end;

    //TORINO_CSI: controllo incompatibilità tra fruizioni di causali di assenza
    if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    begin
      with selConiuge do
      begin
        ClearVariables;
        SetVariable('Progressivo',Progressivo);
        SetVariable('DATANAS',RiferimentoDataNascita.Data);
        Execute;
        PrgConiuge:=StrToIntDef(VarToStr(GetVariable('PROG_CG')),0);
      end;
      with selCausIncomp do
      begin
        ClearVariables;
        SetVariable('Progressivo',Progressivo);
        SetVariable('DATANAS',RiferimentoDataNascita.Data);
        SetVariable('Prog_CG',PrgConiuge);
        SetVariable('Causale',Q265.FieldByName('CODICE').AsString);
        SetVariable('Data',Data );
        Execute;
        if VarToStr(GetVariable('Mess_incomp')) <> '' then
        begin
          AnomaliaAssenze:=31;
          Info:=Info1 + Format(Messaggi[31],[VarToStr(GetVariable('Mess_incomp'))]);
          Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
          Exit;
        end;
      end;
    end;

    //TORINO_CSI: controllo periodo di fruizione entro l'orario al netto della flessibilità e PMT
    if (Giustificativo.Modo = 'D') and
       (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and
       R180In(Giustificativo.Causale,TO_CSI_GIUST_LIMITATI.Split([',']))
    then
    begin
      R502ProDtM1.Chiamante:='Cartolina';
      R502ProDtM1.PeriodoConteggi(Data,Data);
      R502ProDtM1.IgnTimbNonInSeqForzata:=True;
      R502ProDtM1.Conteggi('Cartolina',Progressivo,Data);
      R502ProDtM1.IgnTimbNonInSeqForzata:=False;
      if not R502ProDtM1.CheckFruizGiustdaa(Giustificativo.Causale,R180OreMinutiExt(Giustificativo.DaOre),R180OreMinutiExt(Giustificativo.AOre),sPeriodoFruizione) then
      begin
        AnomaliaAssenze:=30;
        Info:=Info1 + Format(Messaggi[30],[sPeriodoFruizione]);
        Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
        Exit;
      end;
    end;
    //Intersezione con timbrature e giustificativi
    Result:=AnomaliaGrave(Result,IntersezioneGiustTimb(Progressivo,Data));
    //if Result <> mrOk then exit;
  end; //not CheckSoloCompetenze

  //------- Controllo supero delle competenze unitarie e in fasce ------

  if not CheckSoloCompetenze then
  begin
    //Alberto 06/06/2018 - CCNL 2018: controllo competenze delle altre causali collegate (Visite mediche)
    CausCheckComp:=GetValStrT230(Q265.FieldByName('CODICE').AsString,'CAUSALI_CHECKCOMPETENZE',Data);
    for Caus in CausCheckComp.Split([',']) do
    begin
      if not ChekCompetenzeCollegate(Progressivo,Data,Giustificativo,Caus) then
      begin
        AnomaliaAssenze:=37;
        Info:=Info1 + Format(Messaggi[AnomaliaAssenze],[Caus]);
        Result:=AnomaliaGrave(Result,Anomalie(2,Info)); //Bloccante
        Exit;
      end;
    end;
  end; //not CheckSoloCompetenze

  if not EsisteCumulo then
  begin
    // commessa MAN/08 - SVILUPPO#56 - riesame del 01.10.2013.ini
    // in presenza di anomalie in modalità "interattiva" il result viene
    // già impostato = mrIgnore nella funzione Anomalie
    //{$IFDEF IRISWEB}
    //if (ListAnomalie.Count > 0) then
    //  Result:=mrIgnore;
    //{$ENDIF}
    // commessa MAN/08 - SVILUPPO#56 - riesame del 01.10.2013.fine
    Exit;
  end;
  //Aggiorno le competenze annuali se sono in un nuovo anno
  //Aggiorno i cumuli se il giorno da inserire va oltre la data di FineCumulo
  Result:=AnomaliaGrave(Result,AggiornaCompetenzeCumuli(Data));
  //if Result <> mrOk then  exit;

  //Controllo numero di fruizioni (Ferie aggiuntive radiologi/anestesisti)
  if (Q265.FieldByName('FRUIZ_MAX_NUM').AsInteger > 0) and (GetTotCompetenze > 0) then
  begin
    if GetNumPeriodiAssenzeCumulate(Data,Q265.FieldByName('CODICE').AsString,False) >= Q265.FieldByName('FRUIZ_MAX_NUM').AsInteger then
    begin
      AnomaliaAssenze:=25;
      Info:=Info1 + Messaggi[25];
      if IterAutorizzativo then
        Result:=AnomaliaGrave(Result,Anomalie(2,Info))
      else
        Result:=AnomaliaGrave(Result,Anomalie(4,Info));
      //if Result <> mrOK then exit;
    end;
  end;

  // TORINO_CSI - commessa 2019/158 SVILUPPO#1.ini
  // controllo dell'eventuale vincolo di max numero fruizioni a giornate da profilo assenze
  // il controllo è effettuato solo se si verificano queste condizioni:
  // - inserimento a giornata / mezza giornata
  // - vincolo di max fruizioni a giornate impostato (> 0)
  // - competenze della causale significative (> 0)
  if (Q262.FindField('FRUIZ_MAX_NUM_GG') <> nil) and
     (Q262.FieldByName('FRUIZ_MAX_NUM_GG').AsInteger > 0) and
     (R180In(Giustificativo.Modo,['I','M'])) and
     (GetTotCompetenze > 0) then
  begin
    // calcola il numero di giornate fruite (escluso il giustificativo in inserimento)
    LFruizGG:=GetFruizGGCumulate;

    // PRE: giustificativo a giornata o mezza giornata
    // aggiunge alle fruizioni il valore del giustificativo in fase di inserimento:
    // - giornata intera: 1
    // - mezza giornata:  0.5
    LFruizGG:=LFruizGG + IfThen(Giustificativo.Modo = 'I',1,0.5);

    // se la somma è superiore al max fruizioni a giornate restituisce un'anomalia bloccante
    if LFruizGG > Q262.FieldByName('FRUIZ_MAX_NUM_GG').AsInteger then
    begin
      AnomaliaAssenze:=38;
      Info:=Info1 + Messaggi[38];
      Result:=AnomaliaGrave(Result,Anomalie(2,Info));
      Exit;
    end;
  end;
  // TORINO_CSI - commessa 2019/158 SVILUPPO#1.fine

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  {
  Se fruizione corrente a mezza giornata con CSI_TIPO_MG corrente valorizzato a  M/P:
    se CSI_TIPO_MG = M e CSI_MAX_MGMAT is not null, verificare numero di gg fruiti
      con con la causale in oggetto,
      TIPOGIUST = 'M', e CSI_TIPO_MG = 'M':
      dare anomalia bloccante se fruizione attuale (su db) >= CSI_MAX_MGMAT;

    se CSI_TIPO_MG = P e CSI_MAX_MGPOM is not null, verificare numero di gg fruiti
      con con la causale in oggetto,
      TIPOGIUST = 'M', e CSI_TIPO_MG = 'P':
      dare anomalia bloccante se fruizione attuale (su db) >= CSI_MAX_MGPOM;

  il controllo delle fruizioni deve essere fatto nel periodo di cumulo,
  e deve considerare sia T040 che T050, com fatto già in NumRiposi,
  GiustifDaOre, Non MaturaFerie, ecc...
  }
  if Giustificativo.CSITipoMG <> '' then
  begin
    if (Giustificativo.CSITipoMG = 'M') and
       (not Q265.FieldByName('CSI_MAX_MGMAT').IsNull) and
       (Q265.FieldByName('CSI_MAX_MGMAT').AsInteger > 0) then
    begin
      // verifica che il totale non superi il max consentito
      if FruizMGMat >= Q265.FieldByName('CSI_MAX_MGMAT').AsInteger then
      begin
        AnomaliaAssenze:=34;
        Info:=Info1 + Format(Messaggi[AnomaliaAssenze],['mattine']);
        Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
        Exit;
      end;
    end
    else if (Giustificativo.CSITipoMG = 'P') and
            (not Q265.FieldByName('CSI_MAX_MGPOM').IsNull) and
            (Q265.FieldByName('CSI_MAX_MGPOM').AsInteger > 0) then
    begin
      // verifica che il totale non superi il max consentito
      if FruizMGPom >= Q265.FieldByName('CSI_MAX_MGPOM').AsInteger then
      begin
        AnomaliaAssenze:=34;
        Info:=Info1 + Format(Messaggi[AnomaliaAssenze],['pomeriggi']);
        Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
        Exit;
      end;
    end;
    //Controllo totale mezze giornate
    if (not Q265.FieldByName('CSI_MAX_MG').IsNull) and
       (Q265.FieldByName('CSI_MAX_MG').AsInteger > 0) then
    begin
      // verifica che il totale non superi il max consentito
      if FruizMGMat + FruizMGPom >= Q265.FieldByName('CSI_MAX_MG').AsInteger then
      begin
        AnomaliaAssenze:=34;
        Info:=Info1 + Format(Messaggi[AnomaliaAssenze],['mezze giornate']);
        Result:=AnomaliaGrave(Result,Anomalie(3,Info)); //Bloccante
        Exit;
      end;
    end;
  end;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

  //Calcolo l'assenza solo se devo controllare il massimo unitario o le competenze
  if (EsisteMaxUnitario) or (EsisteMaxFasce) then
  begin
    with Giustificativo do
    begin
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      //ConteggiAssenza('Assenze',Data,Causale,Modo,StrToTimeDef(DaOre,0),StrToTimeDef(AOre,0),Progressivo);
      ConteggiAssenza('Assenze',Data,Causale,Modo,CSITipoMG,StrToTimeDef(DaOre,0),StrToTimeDef(AOre,0),Progressivo);
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    end;
    GiorniTot:=0;
    GiorniUni:=0;
    FruitoAP:=0;
    FruitoAP_Ore:=0;
    FruitoForzatoAC:=0;
    FruitoForzatoAC_Ore:=0;
    OreTot:=0;
    OreUni:=0;
    if R502ProDtM1.Blocca in [0,2] then
    begin
      SommaAssenza(Giustificativo.Causale,-1,High(AssenzeConteggiate) + 1,False,Giustificativo.Modo);
      AssenzeConteggiate_Inserita:=True;
    end;
    ValorizzaOreInGiorni;
    if EsisteMaxFasce then
    begin
      //Salvo le competenze in CompetenzeOld
      TrasferisciCompetenze(Competenze,CompetenzeOld,False);
      Result:=AnomaliaGrave(Result,SottraiCompetenze(CompetenzeOld,GiorniTot,OreTot,Data,True));
      //if Result <> mrOk then exit;
    end;
    if EsisteMaxUnitario then
    begin
      MaxUnitarioOld:=MaxUnitario;
      Result:=AnomaliaGrave(Result,SottraiMaxUnitario(MaxUnitarioOld,GiorniUni,OreUni,Data,True));
      //if Result <> mrOk then exit;
    end;
  end;
  //Confermo le competenze conteggiate salvando CompetenzeOld in Competenze
  TrasferisciCompetenze(CompetenzeOld,Competenze,False);
  MaxUnitario:=MaxUnitarioOld;

  // commessa MAN/08 - SVILUPPO#56 - riesame del 01.10.2013.ini
  // in presenza di anomalie in modalità "interattiva" il result viene
  // già impostato = mrIgnore nella funzione Anomalie
  //{$IFDEF IRISWEB}
  //if (ListAnomalie.Count > 0) then
  //  Result:=mrIgnore;
  //{$ENDIF}
  // commessa MAN/08 - SVILUPPO#56 - riesame del 01.10.2013.fine
end;

procedure TR600DtM1.CorreggiCumuliAspettativa;
//Sposta la data di InizioCumulo se sono presenti dei giustificativi con le causali indicate nelle regole di cumulo
var
  ggAsp: Integer;
begin
  ggAsp:=0;

  selT040Aspettative.SetVariable('PROGRESSIVO', Progressivo);
  selT040Aspettative.SetVariable('DATA1', InizioCumulo);
  selT040Aspettative.SetVariable('DATA2', FineCumulo);
  selT040Aspettative.Execute;
  ggAsp:=StrToIntDef(VarToStr(selT040Aspettative.Field(0)),0);

  while ggAsp > 0 do
  begin
    InizioCumulo:=InizioCumulo-ggAsp;
    selT040Aspettative.SetVariable('DATA1', InizioCumulo);
    selT040Aspettative.SetVariable('DATA2', InizioCumulo + ggAsp);
    selT040Aspettative.Execute;
    ggAsp:=StrToIntDef(VarToStr(selT040Aspettative.Field(0)),0);
  end;
end;

function TR600DtM1.IntersezioneGiustTimb(Prog:LongInt; Data:TDateTime; CheckTimb:Boolean = True): TModalResult;
var
  DaOre,AOre,EOre,UOre,Info,Info1,Causale:String;
  Intersez:Boolean;
  i:Integer;
  procedure GetFasciaMG(TipoMG:String; var Dalle,Alle:String);
  begin
    R502ProDtM1.Chiamante:='Cartolina';
    R502ProDtM1.PeriodoConteggi(Data,Data);
    R502ProDtM1.Conteggi('Cartolina',Progressivo,Data);
    if TipoMG = 'M' then
    begin
      Dalle:=R502ProDtM1.ValStrT021['ENTRATA',TF_MG_MAT,1];
      Alle:=R502ProDtM1.ValStrT021['USCITA',TF_MG_MAT,1];
    end
    else if Giustificativo.CSITipoMG = 'P' then
    begin
      Dalle:=R502ProDtM1.ValStrT021['ENTRATA',TF_MG_POM,1];
      Alle:=R502ProDtM1.ValStrT021['USCITA',TF_MG_POM,1];
    end;
    if Dalle <> '' then
      Dalle:=Dalle + '.00';
    if Alle <> '' then
      Alle:=Alle + '.00';
  end;
begin
  Result:=mrOk;
  Info1:=Format(DataNome,[DateToStr(Data),Matricola,Nome,Chr(13),CausAnomala,Chr(13)]);
  //Controllo intersezione con Giustificativi/Timbrature
  DaOre:='';
  AOre:='';
  if (Giustificativo.Modo = 'M') and (Giustificativo.CSITipoMG <> '') then
    GetFasciaMG(Giustificativo.CSITipoMG,DaOre,AOre)
  else if Giustificativo.Modo = 'D' then
  begin
    DaOre:=TimeToStr(StrToTime(Giustificativo.DaOre));
    AOre:=TimeToStr(StrToTime(Giustificativo.AOre));
    if AOre = '00.00.00' then
      AOre:='24.00.00';
  end;

  if (DaOre <> '') and (AOre <> '') then
  begin
    Intersez:=False;
    //Controllo Giustificativi
    with GiustifDaOre do
    begin
      //Alberto 20/06/2006
      // daniloc 05.08.2010 - controllo commentato per problema su inserimenti consecutivi su stessa data
      //if GetVariable('Data') <> Data then
      //begin
        Close;
        SetVariable('Data',Data);
        SetVariable('Progressivo',Prog);
        SetVariable('RichiesteIterAutorizzativo',IfThen(RichiesteIterAutorizzativo,'S','N'));
      //end;
      Open;
      First;
      if RecordCount > 0 then
      begin
        while not Eof do
        begin
          //Per TORINO_CSI si esclude controllo intersezione tra causali di reperibilità e altre causali
          if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) then
          begin
            if (R180In(FieldByName('CAUSALE').AsString,TO_CSI_GIUST_REPE.Split([','])) and
                not R180In(Giustificativo.Causale,TO_CSI_GIUST_REPE.Split([','])))
               or
               (R180In(Giustificativo.Causale,TO_CSI_GIUST_REPE.Split([','])) and
                not R180In(FieldByName('CAUSALE').AsString,TO_CSI_GIUST_REPE.Split([','])))
            then
            begin
              Next;
              Continue;
            end;
          end;
          EOre:='';
          UOre:='';
          if (FieldByName('TIPOGIUST').AsString = 'M') and (FieldByName('CSI_TIPO_MG').AsString <> '') then
            GetFasciaMG(FieldByName('CSI_TIPO_MG').AsString,EOre,UOre)
          else if FieldByName('TIPOGIUST').AsString = 'D' then
          begin
            EOre:=TimeToStr(FieldByName('DaOre').AsDateTime);
            UOre:=TimeToStr(FieldByName('AOre').AsDateTime);
            if UOre = '00.00.00' then
              UOre:='24.00.00';
          end;
          if (EOre = '') or (UOre = '') then
            Next;
          Intersez:=((DaOre >= EOre) and (DaOre < UOre)) or   //Inters.inizio
                    ((AOre > EOre) and (AOre <= UOre)) or     //Inters.fine
                    ((DaOre < EOre) and (AOre > UOre));       //Nuovo giustif. più ampio di quello già esistente
          if Intersez then Break;
          Next;
        end;
        if Intersez then
        begin
          //Intersezione di Giustificativi
          AnomaliaAssenze:=6;
          Info:=Info1 + Format(Messaggi[6],[EOre,UOre]);
          Result:=Anomalie(3,Info); //Bloccante
          Exit;
        end;
      end;
    end;
    //Se giustificativo di presenza che causalizza le timbrature intersecanti il controllo sulle timbrature è inutile
    if not CheckTimb then
      exit;
    //Controllo Timbrature che ho già letto precedentemente
    R180SetVariable(Q100,'Data',Data);
    R180SetVariable(Q100,'Progressivo',Prog);
    with Q100 do
    begin
      Close;//Necessario per aggiornare eventuali modifiche dal cartellino interattivo
      Open;
      First;
      if (RecordCount > 0) and (CheckIntersezioneTimbrature or VisualizzaAnomalie) then
        if TimbrInSeq(Data) then
        begin
          for i:=1 to NumTimb do
          begin
            Intersez:=((DaOre >= Timbrat[i].E) and (DaOre < Timbrat[i].U)) or
                      ((AOre > Timbrat[i].E) and (AOre <= Timbrat[i].U)) or
                      ((DaOre < Timbrat[i].E) and (AOre > Timbrat[i].U));
            if Intersez then Break;
          end;
          if Intersez then
            //Intersezione con Timbrature
          begin
            AnomaliaAssenze:=10;
            Info:=Info1 + Format(Messaggi[10],[Timbrat[i].E + IfThen(Timbrat[i].CausE = '','',Format('(%s)',[Timbrat[i].CausE])),Timbrat[i].U + IfThen(Timbrat[i].CausU = '','',Format('(%s)',[Timbrat[i].CausU]))]);
            Result:=Anomalie(4,Info);
            //daniloa 14.07.2011 if Result <> mrOK then
            //daniloa 14.07.2011   exit;
          end;
        end
        else
        begin
          //Timbrature non in sequenza
          AnomaliaAssenze:=7;
          Info:=Info1 + Messaggi[7];
          Result:=Anomalie(4,Info);
          //daniloa 14.07.2011 if Result <> mrOK then
          //daniloa 14.07.2011   exit;
        end;
    end;
  end;
end;

function TR600DtM1.ChekCompetenzeCollegate(Progressivo:Integer; Data:TDateTime; Giustificativo:TGiustificativo; Causale:String):Boolean;
var R600Ricorsivo:TR600DtM1;
    LGiustificativo:TGiustificativo;
begin
  Result:=True;
  if Causale.Trim = '' then
    exit;

  R600Ricorsivo:=TR600DtM1.Create(SessioneOracleR600);
  try
    try
      LGiustificativo:=Giustificativo;
      LGiustificativo.Causale:=Causale;
      R600Ricorsivo.RiferimentoDataNascita.Data:=RiferimentoDataNascita.Data;
      R600Ricorsivo.RichiesteIterAutorizzativo:=RichiesteIterAutorizzativo;

      if R600Ricorsivo.SettaConteggi(Progressivo,Data,Data,LGiustificativo) = mrAbort then
        //annulla operazione
        Exit;

      //Controllo competenze
      if (R600Ricorsivo.ControlliGenerali(Data,True) <> mrOK) and
         (R600Ricorsivo.AnomaliaAssenze = 20) then
        Result:=False;
    finally
      FreeAndNil(R600Ricorsivo);
    end;
  except
    //errore
  end;
end;

function TR600DtM1.CausalePresenzaAbilitata(Prog:LongInt; Data:TDateTime):TModalResult;
var Info,Info1:String;
begin
  Result:=mrOk;
  Info1:=Format(DataNome,[DateToStr(Data),Matricola,Nome,Chr(13),CausAnomala,Chr(13)]);
  R180SetVariable(selPresAbil,'Data',Data);
  R180SetVariable(selPresAbil,'Progressivo',Prog);
  R180SetVariable(selPresAbil,'Causale',Giustificativo.Causale);
  with selPresAbil do
  begin
    Open;
    if RecordCount = 0 then
    begin
      AnomaliaAssenze:=12;
      Info:=Info1 + Messaggi[12];
      Result:=Anomalie(3,Info);
    end;
  end;
end;

function TR600DtM1.ImpostaLengthAssenzeConteggiate(Offset: Integer): Integer;
{ Incrementa la lunghezza dell'array AssenzeConteggiate dell'offset indicato.
  Restituisce la nuova lunghezza dell'array }
var
  LIni,NewDim: Integer;
begin
  LIni:=Length(AssenzeConteggiate);
  Result:=LIni + Offset;

  // termina se offset è 0
  if Offset = 0 then
    Exit;

  // termina se l'array è vuoto
  NewDim:=Max(0,Result);
  SetLength(AssenzeConteggiate,NewDim);
  Result:=NewDim;
end;

function TR600DtM1.RimuoviAssenzeConteggiate(Data: TDateTime): Integer;
begin
  if (Length(AssenzeConteggiate) > 0) and (AssenzeConteggiate[High(AssenzeConteggiate)].Data = Data) then
    ImpostaLengthAssenzeConteggiate(-1);
end;

function TR600DtM1.GetNumPeriodiAssenzeCumulate(D:TDateTime; Causale:String; IncludiTutto:Boolean):Integer;
var i:Integer;
    DUP:TDateTime;
    StrCatena,StrCatenaL133,StrCatenaRaggr,CausaliPeriodo,Ore:String;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    LNumGiorni,LNumGiorniDip,LNumGiorniConiuge,LIncNumGiorni: Real;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
begin
  Result:=0;
  DUP:=0;
  SetLength(PeriodiCumulati,0);
  GetCatenaCausAss(Causale,StrCatena,StrCatenaL133,StrCatenaRaggr);
  CausaliPeriodo:=',' + StrCatena + ',' + StrCatenaL133 + ',';

  // ordinamento array per data al fine di visualizzare correttamente i periodi
  OrdinaAssCumulatePerData(AssenzeCumulate,AssenzeCumulateOrdData);

  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  LNumGiorniDip:=0;
  LNumGiorniConiuge:=0;
  LNumGiorni:=0;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

  // estrae i periodi dalle assenze cumulate ordinate per data
  for i:=0 to High(AssenzeCumulateOrdData) do
  begin
    if IncludiTutto or (Pos(',' + AssenzeCumulateOrdData[i].Causale + ',',CausaliPeriodo) > 0) then
    begin
      if (AssenzeCumulateOrdData[i].DTData > DUP + 1) or
         ((i > 0) and ((AssenzeCumulateOrdData[i].Tipo <> AssenzeCumulateOrdData[i - 1].Tipo) or
                       (AssenzeCumulateOrdData[i].Ore <> AssenzeCumulateOrdData[i - 1].Ore)) or
                       (AssenzeCumulateOrdData[i].Coniuge <> AssenzeCumulateOrdData[i - 1].Coniuge)) then
      begin
        inc(Result);
        SetLength(PeriodiCumulati,Result);
        PeriodiCumulati[Result - 1].Causali:=AssenzeCumulateOrdData[i].Causale;
        PeriodiCumulati[Result - 1].Dal:=AssenzeCumulateOrdData[i].DTData;
        PeriodiCumulati[Result - 1].Coniuge:=AssenzeCumulateOrdData[i].Coniuge;
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
        LNumGiorniDip:=0;
        LNumGiorniConiuge:=0;
        LNumGiorni:=0;
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      end;
      //Non conto il periodo se è contiguo a quello in inserimento
      if (AssenzeCumulateOrdData[i].DTData = D - 1) or (AssenzeCumulateOrdData[i].DTData = D + 1) then
      begin
        Ore:='';
        if (Giustificativo.Modo = 'M') and (R180OreMinutiExt(Giustificativo.DaOre) > 0) then
          Ore:=R180MinutiOre(R180OreMinutiExt(Giustificativo.DaOre));
        if Giustificativo.Modo = 'N' then
          Ore:=R180MinutiOre(R180OreMinutiExt(Giustificativo.DaOre));
        if Giustificativo.Modo = 'D' then
          Ore:=R180MinutiOre(R180OreMinutiExt(Giustificativo.DaOre)) + '-' + R180MinutiOre(R180OreMinutiExt(Giustificativo.AOre));
        if (Giustificativo.Modo = AssenzeCumulateOrdData[i].Tipo) and (Ore = AssenzeCumulateOrdData[i].Ore) then
        begin
          dec(Result);
          SetLength(PeriodiCumulati,Result);
        end;
      end;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
      if AssenzeCumulateOrdData[i].Tipo = 'I' then
        LIncNumGiorni:=1
      else if AssenzeCumulateOrdData[i].Tipo = 'M' then
        LIncNumGiorni:=0.5
      else
        LIncNumGiorni:=0;
      if AssenzeCumulateOrdData[i].Coniuge then
        LNumGiorniConiuge:=LNumGiorniConiuge + LIncNumGiorni
      else
        LNumGiorniDip:=LNumGiorniDip + LIncNumGiorni;
      LNumGiorni:=LNumGiorni + LIncNumGiorni;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      DUP:=AssenzeCumulateOrdData[i].DTData;
      if Result > 0 then
      begin
        PeriodiCumulati[Result - 1].Al:=AssenzeCumulateOrdData[i].DTData;
        if Pos(',' + AssenzeCumulateOrdData[i].Causale + ',',',' + PeriodiCumulati[Result - 1].Causali + ',') = 0 then
          PeriodiCumulati[Result - 1].Causali:=PeriodiCumulati[Result - 1].Causali + ',' + AssenzeCumulateOrdData[i].Causale;
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
        PeriodiCumulati[Result - 1].NumGiorniDip:=LNumGiorniDip;
        PeriodiCumulati[Result - 1].NumGiorniConiuge:=LNumGiorniConiuge;
        PeriodiCumulati[Result - 1].NumGiorni:=LNumGiorni;
        // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      end;
    end;
  end;
end;

function TR600DtM1.GetFruizGGCumulate: Real;
// Restituisce il numero di giornate di assenza conteggiate nel periodo di cumulo
// IMPORTANTE
//   sono considerate anche le mezze giornate con peso = 0.5
var
  LElem: TAssenzeConteggiate;
  LSommaGG: Real;
  LIncNumGiorni: Real;
begin
  // somma le assenze assegnando questi valori in base al tipo di fruizione:
  // - giornata intera = 1
  // - mezza giornata  = 0.5
  // - numero ore      = 0
  // - da ore / a ore  = 0
  LSommaGG:=0;
  for LElem in AssenzeConteggiate do
  begin
    // determina il peso dell'assenza
    if LElem.Tipo = 'I' then
      LIncNumGiorni:=1
    else if LElem.Tipo = 'M' then
      LIncNumGiorni:=0.5
    else
      LIncNumGiorni:=0;

    // incrementa la somma
    LSommaGG:=LSommaGG + LIncNumGiorni;
  end;

  // imposta il risultato
  Result:=LSommaGG;
end;

function TR600DtM1.AggiornaCompetenzeCumuli(Data:TDateTime):TModalResult;
{Aggiorno le competenze annuali se sono in un nuovo anno
 Aggiorno i cumuli se il giorno da inserire va oltre la data di FineCumulo}
var A,M,G,A2,M2,G2:Word;
    CompChange,CumChange:Boolean;
    xx:Integer;
begin
  Result:=mrOk;
  CompChange:=False;
  CumChange:=False;
  //Controllo se ho oltrepassato il periodo di cumulo considerato precedentemente
  DecodeDate(DaData,A,M,G);
  DecodeDate(Data,A2,M2,G2);
  VariazioneCompetenze:='0';
  VariazioneCompetenzeF:=0;
  if (CompetenzeAnnoSolare) and (A2 > A) then
  begin
    CompChange:=True;
    //Salvo le competenze attuali in CompetenzeOld
    TrasferisciCompetenze(Competenze,CompetenzeOld,False);
    for xx:=Low(CompetenzeLette) to High(CompetenzeLette) do
    begin
      CompetenzeLette[xx]:='';
      Competenze[xx]:=0;
    end;
    RapportoCorrente.DataCorrente:=Data;
    CercaProfiloAssenze(A2,True);
    ArrotondaCompetenze(Competenze);
    //Sommo le vecchie competenze(Residui) alle nuove
    TrasferisciCompetenze(CompetenzeOld,Competenze,True);
    //Salvo le competenze ottenute in CompetenzeOld
    TrasferisciCompetenze(Competenze,CompetenzeOld,False);
    //Salvo le competenze ottenute in CompetenzeOri
    TrasferisciCompetenze(Competenze,CompetenzeOri,False);
    EsisteMaxFasce:=EsistonoCompetenzeFasce;
    //Ripristono il MaxUnitario originale
    MaxUnitario:=MaxUnitarioOri;
  end;
  //  if (Data > FineCumulo) and (TipoCumulo in ['A','B','D','E','F','G']) then  //Lorena 27/12/2005
  if (Data > FineCumulo) and (TipoCumulo in ['A','B','D','E','F','G','I','O','Z']) then  //Lorena 27/12/2005
  begin
    //Alberto 10/07/2012: per i casi che richiedono il proporzionamento (Tipo rapporto e Part time), rileggo le competenze non ancora proporzionate
    if (Q265.FieldByName('Proporziona_PerServ').AsString = 'S') and
       ((not(TipoCumulo in ['C','I','O'])) or (Q265.FieldByName('Tempo_Determinato').AsString <> 'S')) then
      ValorizzaCompetenze(CompetenzeLette,CompetenzeOri,UMisura,False)
    else if (not CompetenzeAnnoSolare) and
       (Q265.FieldByName('Tipo_Proporzione').ASString = 'C') and
       (Q265.FieldByName('PartTime').AsString <> 'N') then
      ValorizzaCompetenze(CompetenzeLette,CompetenzeOri,UMisura,False)
    else if Q265.FieldByName('PROPORZIONA_ABILITAZIONE').AsString = 'S' then
      ValorizzaCompetenze(CompetenzeLette,CompetenzeOri,UMisura,False);
    //Ripristino le competenze originali
    TrasferisciCompetenze(CompetenzeOri,Competenze,False);
    //Ricalcolo InizioCumulo e FineCumulo
    Result:=PeriodoDiCumulo(Data);
    (*
    if LetturaRiduzioni and LetturaAssenze then
      FineCumulo:=AData;
    *)
    if Result = mrOK then
    begin
      CumChange:=True;
      //Ripristino le competenze originali
      TrasferisciCompetenze(CompetenzeOri,Competenze,False);
      //Ripristino il Max Unitario originale
      MaxUnitario:=MaxUnitarioOri;
      //Preparo le query dei conteggi nel periodo interessato
      {$IFDEF MEDP803}
      if (InizioCumulo - 2) < InizioConteggi then
        InizioConteggi:=InizioCumulo - 2;
      if (FineCumulo + 2) > FineConteggi then
        FineConteggi:=FineCumulo + 2;
      R502ProDtM1.Chiamante:='Assenze';
      R502ProDtM1.PeriodoConteggi(InizioConteggi,FineConteggi);
      R502ProDtM1.Q100.Open;
      {$ENDIF}
      GiorniTot:=0;
      GiorniUni:=0;
      FruitoAP:=0;
      FruitoAP_Ore:=0;
      FruitoForzatoAC:=0;
      FruitoForzatoAC_Ore:=0;
      OreTot:=0;
      OreUni:=0;
      CalcolaCumuli(False);
    end;
  end;
  if (CompChange) or (CumChange) then
  begin
    //Aggiorno le competenze con i cumuli del nuovo periodo
    if EsisteMaxFasce then
      SottraiCompetenze(Competenze,GiorniTot,OreTot,Date,False);  //La data non è significativa
    if EsisteMaxUnitario then
      SottraiMaxUnitario(MaxUnitario,GiorniUni,OreUni,Date,False);  //La data non è significativa
  end;
end;

function TR600DtM1.TimbrInSeq(Data:TDateTime):Boolean;
{Controllo che le timbrature siano in sequenza}
var Verso:String;
    Sequenza,PrimaU,UltimaE:Boolean;
begin
  Result:=True;
  NumTimb:=1;
  Verso:='';
  Sequenza:=True;
  with Q100 do
  begin
    First;
    //Prima timbratura = Uscita
    PrimaU:=FieldByName('Verso').AsString = 'U';
    while (not Eof) and (NumTimb <= High(Timbrat)) do
    begin
      if Verso = FieldByName('Verso').AsString then
      begin
        Sequenza:=False;
        Break;
      end;
      Verso:=FieldByName('Verso').AsString;
      if Verso = 'E' then
      begin
        //Timbrat[NumTimb].E:=TimeToStr(FieldByName('Ora').AsDateTime);
        Timbrat[NumTimb].E:=FormatDateTime('hh.nn.00',FieldByName('Ora').AsDateTime);//si devono ignorare eventuali secondi
        Timbrat[NumTimb].CausE:=FieldByName('Causale').AsString;
      end
      else
      begin
        //Timbrat[NumTimb].U:=TimeToStr(FieldByName('Ora').AsDateTime);
        Timbrat[NumTimb].U:=FormatDateTime('hh.nn.00',FieldByName('Ora').AsDateTime);//si devono ignorare eventuali secondi
        Timbrat[NumTimb].CausU:=FieldByName('Causale').AsString;
        inc(NumTimb);
      end;
      Next;
    end;
    //Timbrature non in sequenza
    if not Sequenza then
    begin
      Result:=False;
      exit;
    end;
    //Ultima timbrature = Entrata
    UltimaE:=FieldByName('Verso').AsString = 'E';
    if not UltimaE then dec(NumTimb);
  end;
  //Controllo Prima Uscita se ha un'Entrata il giorno precedente
  if PrimaU then
    with Q100 do
    begin
      Timbrat[1].E:='00.00.00';
      Timbrat[1].CausE:='';
      Close;
      SetVariable('Data',Data - 1);
      Open;
      if RecordCount > 0 then
      begin
        Last;
        Result:=FieldByName('Verso').AsString = 'E';
      end
      else
        Result:=False;
    end;
  if not Result then Exit;
  //Controllo Ultima Entrata se ha un'Uscita il giorno successivo
  if UltimaE then
    with Q100 do
    begin
      Timbrat[NumTimb].U:='23.59.00';
      Timbrat[NumTimb].CausU:='';
      Close;
      SetVariable('Data',Data + 1);
      Open;
      if RecordCount > 0 then
      begin
        First;
        Result:=FieldByName('Verso').AsString = 'U';
      end
      else
        Result:=False;
    end;
end;

function TR600DtM1.Anomalie(Bottoni:Integer; Info:String):TModalResult;
begin
  Result:=mrOK;
  if LetturaAssenze then
    exit;
  if (not VisualizzaAnomalie) and (AnomaliaAssenze = 19) then
    exit;
  if not VisualizzaAnomalie then
  begin
    // modalità "batch" per la segnalazione delle anomalie

    if (Bottoni = 4) and (not AnomalieBloccanti) then
      Result:=mrOK
    else if Bottoni >= 3 then
      Result:=mrIgnore
    else if Bottoni >= 2 then
      Result:=mrAbort;
    if (Pos(',' + IntToStr(AnomaliaAssenze) + ',',',' + AnomalieNonBloccanti + ',') > 0) then
    begin
      Result:=mrOK;
      ListAnomalieNonBloccanti.Add(Info);
    end;
    if Result <> mrOK then
    begin
      EsistonoAnomalieBloccanti:=True;

      // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.ini
      // da adesso, in presenza di anomalie bloccanti restituisce mrAbort
      Result:=mrAbort;
      // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.fine
      ListAnomalie.Add(Info);
    end;
  end
  else
  begin
    // modalità "interattiva" di segnalazione delle anomalie

    // commessa MAN/08 - SVILUPPO#56 - riesame del 27.09.2013.ini
    // indicazione anomalie bloccanti con *
    if Bottoni < 4 then
    begin
      Info:='(*)' + Info;
    end;
    // commessa MAN/08 - SVILUPPO#56 - riesame del 27.09.2013.fine
    ListAnomalie.Add(Info);

    // commessa MAN/08 - SVILUPPO#56 - riesame del 01.10.2013.ini
    // in presenza di anomalie in modalità "interattiva" imposta comunque il result = mrIgnore
    // la modalità precedente prevedeva una successiva impostazione in ControlliGenerali,
    // che è stata ora commentata per centralizzare la gestione in questo punto
    Result:=mrIgnore;
    // commessa MAN/08 - SVILUPPO#56 - riesame del 01.10.2013.fine

    if Bottoni < 4 then
    begin
      // si tratta di anomalia bloccante
      EsistonoAnomalieBloccanti:=True;
      // commessa MAN/08 - SVILUPPO#56 - riesame del 01.10.2013.ini
      // v. sopra: in presenza di anomalie viene sempre restituito mrIgnore
      //Result:=mrIgnore;
      // commessa MAN/08 - SVILUPPO#56 - riesame del 01.10.2013.fine

      // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.ini
      // rettifica il comportamento stabilito nel riesame del 01.10.2013
      // da adesso, in presenza di anomalie bloccanti restituisce mrAbort
      Result:=mrAbort;
      // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.fine
      if Bottoni = 2 then
        InserimentoImpedito:=True;
    end;
  end;
  UltimaAnomalia:=Info;
end;

function TR600DtM1._Anomalie(Bottoni:Integer; Info:String):TModalResult;
begin
  Result:=mrOK;
  if LetturaAssenze then
    exit;
  if (not VisualizzaAnomalie) and (AnomaliaAssenze = 19) then
    exit;
  {$IFNDEF IRISWEB}
  with R600FAnomalie do
  begin
    Label1.Caption:=Info;
    Button1.Visible:=Bottoni = 4;  //OK
    Button2.Visible:=Bottoni >= 3; //Annulla giorno
    Button3.Visible:=Bottoni >= 2; //Annulla operazione
    if VisualizzaAnomalie and (UpperCase(ExtractFileName(Application.ExeName)) <> 'D003PEXPTIMBGIUS.EXE') then
      Result:=ShowModal
    else if Button1.Visible and (not AnomalieBloccanti) then
      Result:=Button1.ModalResult
    else if Button2.Visible then
      Result:=Button2.ModalResult
    else if Button3.Visible then
      Result:=Button3.ModalResult;
  end;
  // informazione anomalia
  if (not VisualizzaAnomalie) and
     (Pos(',' + IntToStr(AnomaliaAssenze) + ',',',' + AnomalieNonBloccanti + ',') > 0) then
  begin
     Result:=mrOK;
     ListAnomalieNonBloccanti.Add(Info);
  end;
  if Result <> mrOK then
  begin
    ListAnomalie.Add(Info);
  end;
  UltimaAnomalia:=Info;
  {$ELSE}
  (*{$IFDEF WEBPJ}*)
  if not VisualizzaAnomalie then
  begin
    if (Bottoni = 4) and (not AnomalieBloccanti) then
      Result:=mrOK
    else if Bottoni >= 3 then
      Result:=mrIgnore
    else if Bottoni >= 2 then
      Result:=mrAbort;
    if (Pos(',' + IntToStr(AnomaliaAssenze) + ',',',' + AnomalieNonBloccanti + ',') > 0) then
    begin
       Result:=mrOK;
       ListAnomalieNonBloccanti.Add(Info);
    end;
    if Result <> mrOK then
    begin
      EsistonoAnomalieBloccanti:=True;
      ListAnomalie.Add(Info);
    end;
  end
  else
  begin
    ListAnomalie.Add(Info);
    if Bottoni < 4 then
    begin
      // si tratta di anomalia bloccante
      EsistonoAnomalieBloccanti:=True;
      Result:=mrIgnore;
    end;
  end;
  UltimaAnomalia:=Info;
  (*
  {$ELSE}
  // informazione anomalia
  ListAnomalie.Add(Info);
  UltimaAnomalia:=Info;
  if Bottoni < 4 then
  begin
    // si tratta di anomalia bloccante
    EsistonoAnomalieBloccanti:=True;
    Result:=mrIgnore;
  end;
  {$ENDIF WEBPJ}
  *)
  {$ENDIF IRISWEB}
end;

//------------------------------------------------------------------------------
//---------   C O N T R O L L I   A S S E N Z E   F U T U R E   ----------------
//------------------------------------------------------------------------------
function TR600DtM1.IsInizioCatenaCausAss(const PCausale: String; var RCausInizio: String): Boolean;
// verifica se una causale è in testa ad una catena
// restituisce
//   - True  se la causale indicata è la causale di inizio di una catena
//   - False altrimenti
// parametri
//   PCausale    : codice della causale da verificare
//   RCausInizio : codice della causale in testa alla catena (oppure stringa vuota se non esiste catena)
begin
  RCausInizio:='';

  // se la causale non è indicata restituisce false
  if PCausale = '' then
  begin
    Result:=False;
    Exit;
  end;

  // esegue la procedura se la causale è variata
  try
    // estrae la causale di inizio catena per la causale PCausale
    with T265F_GETINIZIOCATENA do
    begin
      if PCausale <> VarToStr(GetVariable('CAUSALE')) then
      begin
        SetVariable('CAUSALE',PCausale);
        Execute;
      end;
      RCausInizio:=VarToStr(GetVariable('CAUS_INIZIO'));
    end;

    // se la causale è inizio catena restituisce true
    Result:=(PCausale = RCausInizio);
  except
    on E:Exception do
      raise Exception.Create('Si è verificato un errore durante la lettura delle'#13#10 +
                             'causali concatenate del giustificativo ' + PCausale + #13#10 +
                             E.Message);
  end;
end;

procedure TR600DtM1.GetCatenaCausAss(const PCausale: String; var RCatena: String);
// estrae le causali di assenza facenti parti della catena di causali
// in un unico elenco (comprensivo di causali normali e ridotte)
// - RCatenaNorm : contiene la catena di causali completa
begin
  RCatena:='';

  // esegue la procedura se la causale è variata
  try
    with T265F_GETCATENACOMPLETA do
    begin
      if PCausale <> VarToStr(GetVariable('CAUSALE')) then
      begin
        SetVariable('CAUSALE',PCausale);
        Execute;
      end;
      RCatena:=VarToStr(GetVariable('CATENA'));
    end;
  except
    on E:Exception do
      raise Exception.Create('Si è verificato un errore durante la lettura delle'#13#10 +
                             'causali concatenate del giustificativo ' + PCausale + #13#10 +
                             E.Message);
  end;
end;

procedure TR600DtM1.GetCatenaCausAss(const PCausale: String; var RCatenaNorm, RCatenaL133, RCatenaRaggr: String);
// Estrae le causali di assenza facenti parti della catena di causali da sostituire,
// divise in due elenchi separati
// - RCatenaNorm : contiene la catena di causali normali
// - RCatenaL133 : contiene la corrispondente catena di causali ridotte per la L.133
// In caso di errore solleva un'eccezione, e restituisce due stringhe vuote
begin
  RCatenaNorm:='';
  RCatenaL133:='';
  RCatenaRaggr:='';
  try
    // esegue la procedura se la causale è variata
    if PCausale <> VarToStr(scrCausAssCatena.GetVariable('C')) then
    begin
      scrCausAssCatena.ClearVariables;
      scrCausAssCatena.SetVariable('C',PCausale);
      scrCausAssCatena.Execute;
    end;
    // salva le due catene nelle variabili
    RCatenaNorm:=VarToStr(scrCausAssCatena.GetVariable('CHAIN'));
    RCatenaL133:=VarToStr(scrCausAssCatena.GetVariable('CHAIN_L133'));
    RCatenaRaggr:=VarToStr(scrCausAssCatena.GetVariable('CHAIN_RAGGR'));
  except
    on E:Exception do
      raise Exception.Create('Si è verificato un errore durante la lettura delle' + #13#10 +
                             'causali concatenate del giustificativo ' + PCausale + #13#10 +
                             E.Message);
  end;
end;

function TR600DtM1.SuddividiFruizione(var TG,Da,A,TGSucc,DaSucc,ASucc:String):Boolean;
// suddivide la fruizione nel caso che la stessa superi le competenze,
// ma vi sia ancora della disponibilità inferiore alla fruizione richiesta.
// In tal caso, in TGSucc,DaSucc,ASucc ci sarà la fruizione da inserire
// successivamente con la causale concatenata
var HDa: Integer;
    locTotCompetenze:Real;
begin
  Result:=True;
  locTotCompetenze:=max(0,GetTotCompetenze);
  if UMisura = 'G' then
  begin
    if TG = 'I' then
    begin
      if Q265.FieldByName('UM_INSERIMENTO_MG').AsString = 'N' then
        Result:=False
      else
      begin
        TG:='M';
        TGSucc:='M';
      end;
    end
    else if TG = 'N' then
    begin
      HDa:=R180OreMinutiExt(Da);
      TGSucc:=TG;
      DaSucc:=R180MinutiOre(HDa - Trunc(ValenzaGiornaliera * locTotCompetenze));
      Da:=R180MinutiOre(Trunc(ValenzaGiornaliera * locTotCompetenze));
    end
    else if TG = 'D' then
    begin
      HDa:=R180OreMinutiExt(Da);
      TGSucc:=TG;
      DaSucc:=R180MinutiOre(HDa + Trunc(ValenzaGiornaliera * locTotCompetenze));
      ASucc:=A;
      A:=DaSucc;
    end;
  end
  else if UMisura = 'O' then
  begin
    if (TG = 'I') or (TG = 'M') then
    begin
      if Q265.FieldByName('UM_INSERIMENTO_H').AsString = 'N' then
        Result:=False
      else
      begin
        TG:='N';
        Da:=R180MinutiOre(Trunc(locTotCompetenze));
        TGSucc:='N';
        DaSucc:=R180MinutiOre(Trunc(UltimaFruizione - locTotCompetenze));
      end;
    end
    else if TG = 'N' then
    begin
      HDa:=R180OreMinutiExt(Da);
      TGSucc:=TG;
      DaSucc:=R180MinutiOre(Trunc(HDa - locTotCompetenze));
      Da:=R180MinutiOre(Trunc(locTotCompetenze));
    end
    else if TG = 'D' then
    begin
      HDa:=R180OreMinutiExt(Da);
      TGSucc:=TG;
      ASucc:=A;
      A:=R180MinutiOre(HDa + Trunc(locTotCompetenze));
      DaSucc:=A;
    end
  end;
end;

function TR600DtM1.ContaGiustifAssFuturi(Progressivo: Integer; DataLimite: TDateTime; Giustif: TGiustificativo; DataFamiliare:String): Integer;
// Conta il numero di giustificativi di assenza presenti dopo la DataLimite
// per cui la causale è compresa nella catena di successione.
// In caso di errore restituisce un numero negativo.
var
  S,StrCatena,StrCatenaL133,StrCatenaRaggr,ElencoCausali,Cumulo,CodRaggr: String;
  v: Variant;
  i: Integer;
begin
  // se la causale non è specificata, restituisce un numero negativo
  if Giustif.Causale = '' then
  begin
    Result:=-1;
    Exit;
  end;

  // determina l'elenco di causali da considerare per i giustificativi futuri
  GetCatenaCausAss(Giustif.Causale,StrCatena,StrCatenaL133,StrCatenaRaggr);

  // se la catena è formata solo dalla causale stessa, restituisce un numero negativo
  if (Giustif.Causale = StrCatena) or
     (Giustif.Causale = StrCatenaL133) then
  begin
    Result:=-2;
    Exit;
  end;

  // estrae raggruppamento della causale + causali cumulate
  v:=Q265.Lookup('CODICE',Giustif.Causale,'CODRAGGR;CODCAU1');
  if VarIsNull(v) then
  begin
    Result:=-3;
    Exit;
  end;
  CodRaggr:=VarToStr(v[0]);
  Cumulo:=VarToStr(v[1]);

  // elenco causali da considerare composto da: catena + catena "brunetta" + cumulo
  // nota: vengono incluse anche le causali dello stesso raggruppamento
  ElencoCausali:=StrCatena + ',' + StrCatenaL133 + ',' + StrCatenaRaggr + ',' + Cumulo;
  //Leggo le catene di tutte le causali incluse nel raggruppamento e nel cumulo
  for S in (StrCatenaRaggr + ',' + Cumulo).Split([',']) do
  begin
    GetCatenaCausAss(S,StrCatena,StrCatenaL133,StrCatenaRaggr);
    ElencoCausali:=ElencoCausali + ',' + StrCatena + ',' + StrCatenaL133;
  end;
  // ciclo di rimozione virgole doppie
  while Pos(',,',ElencoCausali) > 0 do
    ElencoCausali:=StringReplace(ElencoCausali,',,',',',[rfReplaceAll]);
  // ciclo di rimozione delle causali doppie
  with TStringList.Create do
  try
    Sorted:=True;
    Duplicates:=dupIgnore;
    CommaText:=ElencoCausali;
    ElencoCausali:=CommaText;
  finally
    Free;
  end;
  //Racchiudo fra apici ogni elemento
  ElencoCausali:='''' + StringReplace(ElencoCausali,',',''',''',[rfReplaceAll]) + '''';

  // determina i giustificativi da considerare per controllo / sostituzione causale
  R180SetVariable(selT040Concat,'PROGRESSIVO',Progressivo);
  R180SetVariable(selT040Concat,'DATA_LIMITE',DataLimite);
  R180SetVariable(selT040Concat,'ELENCO_CAUSALI',ElencoCausali);
  R180SetVariable(selT040Concat,'CODRAGGR',CodRaggr);
  if DataFamiliare <> '' then
    R180SetVariable(selT040Concat,'DATANAS',StrToDateTime(DataFamiliare))
  else
    R180SetVariable(selT040Concat,'DATANAS',null);
  selT040Concat.Open;

  // nota: il dataset viene volutamente mantenuto aperto
  Result:=selT040Concat.RecordCount;
end;

procedure TR600DtM1.GestioneGiustifAssFuturi(Progressivo: Integer; DataLimite: TDateTime; Giustif: TGiustificativo;
  DataFamiliare: String {$IFNDEF IRISWEB}; const PrbElab: TProgressBar = nil{$ENDIF IRISWEB});
// Effettua il controllo delle competenze per ogni giustificativo presente dopo
// la DataLimite per cui la causale risulta:
// - facente parte della catena di causali della causale specificata, oppure
// - facente parte delle causali presenti nel cumulo della causale specificata, oppure
// - appartenente al raggruppamento della causale specificata
// Se queste risultano insufficienti, il giustificativo viene sostituito con la
// prima causale della catena con competenze disponibili (se non esistono causali
// con disponibilità, non viene fatto nulla).
var
  ListCatena,ListCatenaL133: TStringList;
  StrCatena,StrCatenaL133,StrCatenaRaggr,ElencoCausali,
  Caus,CausSost,
  CausPrec,CumuloCausPrec,CumuloCausAtt: String;
  DataAss: TDateTime;
  i,index: Integer;
  Comp: Real;
  IsL133DieciGG,InizioRiduzioni: Boolean;
  {$IFNDEF IRISWEB}
  CurDefaultIniziale: Boolean;
  {$ENDIF}
  UM,CP,CC,CT,FP,FC,FT,R:String;
  ValGio,Giorno: Integer;
begin
  // inizializzazioni
  {$IFNDEF IRISWEB}
  CurDefaultIniziale:=(Screen.Cursor = crDefault);
  if CurDefaultIniziale then
    Screen.Cursor:=crHourGlass;
  {$ENDIF}

  // nel caso, riapre il dataset dei giustificativi futuri
  if ContaGiustifAssFuturi(Progressivo,DataLimite,Giustif,DataFamiliare) <= 0 then
  begin
    {$IFNDEF IRISWEB}
    if CurDefaultIniziale then
      Screen.Cursor:=crDefault;
    {$ENDIF}
    Exit;
  end;

  // inizializzazione progressbar
  {$IFNDEF IRISWEB}
  if PrbElab <> nil then
  begin
    PrbElab.Position:=0;
    PrbElab.Max:=selT040Concat.RecordCount;
    PrbElab.Repaint;
  end;
  {$ENDIF IRISWEB}

  try
    // crea due stringlist "parallele" al fine di gestire la corrispondenza tra causali
    // di assenza normali (ListCatena) e decurtate per la L.133 (ListCatenaL133)
    ListCatena:=TStringList.Create;
    ListCatenaL133:=TStringList.Create;

    // ciclo sui giustificativi da considerare per controllo / sostituzione causale
    Caus:='';
    CausSost:='';
    selT040Concat.First;
    while not selT040Concat.Eof do
    begin
      DataAss:=selT040Concat.FieldByName('DATA').AsDateTime;
      Caus:=selT040Concat.FieldByName('CAUSALE').AsString;

      // se necessario rilegge la catena
      if (ListCatena.IndexOf(Caus) = -1) and
         (ListCatenaL133.IndexOf(Caus) = -1) then
      begin
        GetCatenaCausAss(Caus,StrCatena,StrCatenaL133,StrCatenaRaggr);
        ListCatena.CommaText:=StrCatena;
        ListCatenaL133.CommaText:=StrCatenaL133;
      end;
      IsL133DieciGG:=(ListCatenaL133.IndexOf(Caus) > -1);

      // individua la prima causale della catena che ha competenze sufficienti
      index:=-1;
      for i:=0 to ListCatena.Count - 1 do
      begin
        OldGiustif.Causale:=selT040Concat.FieldByName('CAUSALE').AsString;
        OldGiustif.Modo:=R180CarattereDef(selT040Concat.FieldByName('TIPOGIUST').AsString,1,#0);
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
        OldGiustif.CSITipoMG:=selT040Concat.FieldByName('CSI_TIPO_MG').AsString;
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
        OldGiustif.DaOre:=FormatDateTime('hh.nn',selT040Concat.FieldByName('DAORE').AsDateTime);
        OldGiustif.AOre:=FormatDateTime('hh.nn',selT040Concat.FieldByName('AORE').AsDateTime);
        OldGiustif.ProgrCausale:=selT040Concat.FieldByName('PROGRCAUSALE').AsInteger;
        OldGiustif.DataGiust:=DataAss;
        Giustif:=OldGiustif;
        Giustif.Causale:=ListCatena[i];
        RettificaCatenaCompetenze:=True;

        // determina la causale precedente
        // per la prima iterazione (i = 0) è quella del giustif. precedente
        // per le iterazioni succ. (i > 0) è quella di indice precedente nella catena
        if i = 0 then
          CausPrec:=CausSost
        else
          CausPrec:=ListCatena[i - 1];

        // in base alla causale precedente, verifica se è necessario rieseguire i conteggi
        if CausPrec = '' then
          // la prima volta effettua i conteggi
          InizioRiduzioni:=True
        else
        begin
          // se la causale è nel cumulo di quella precedente, e la causale prec. è nel cumulo di quella attuale
          // allora non riesegue i conteggi sul database
          CumuloCausPrec:=VarToStr(Q265.Lookup('CODICE',CausPrec,'CODCAU1'));
          CumuloCausAtt:=VarToStr(Q265.Lookup('CODICE',ListCatena[i],'CODCAU1'));
          InizioRiduzioni:=(Pos(',' + ListCatena[i] + ',',',' + CumuloCausPrec + ',') = 0) or
                           (Pos(',' + CausPrec + ',',',' + CumuloCausAtt + ',') = 0);
          // se la causale attuale e quella precedente fanno parte dello stesso raggruppamento
          // allora non riesegue i conteggi sul db
          if VarToStr(Q265.Lookup('CODICE',CausPrec,'CODRAGGR')) = VarToStr(Q265.Lookup('CODICE',ListCatena[i],'CODRAGGR')) then
            InizioRiduzioni:=False;
        end;

        // conteggi
        //GetRiduzione(Progressivo,DataAss,DataAss,RiferimentoDataNascita.Data(*0*),Giustif,UM,CP,CC,CT,FP,FC,FT,R,ValGio,Giorno,InizioRiduzioni);
        GetRiduzione(Progressivo,DataAss,DataAss,selT040Concat.FieldByName('DATANAS').AsDateTime,Giustif,UM,CP,CC,CT,FP,FC,FT,R,ValGio,Giorno,InizioRiduzioni);
        ImpostaLengthAssenzeConteggiate(-1); // rimuove l'ultima assenza conteggiata

        // verifica se le competenze sono sufficienti
        Comp:=GetTotCompetenze;
        // AOSTA_REGIONE - chiamata 79635.ini
        // controllo periodo fruizione
        // nota: introdurre anche altri controlli (cfr. ControlliGenerali)
        if EsisteFruizione and ((DataAss < FruizDa) or (DataAss > FruizA)) then
          Continue;
        // AOSTA_REGIONE - chiamata 79635.fine
        if Comp >= 0 then
        begin
          index:=i;
          Break;
        end;
      end;

      // se le competenze sono esaurite per le fasce -> setta l'indice all'ultima causale della catena
      if index = -1 then
      begin
        for i:=ListCatena.Count - 1 downto 0 do
          if ListCatena[i] <> '' then
          begin
            index:=i;
            Break;
          end;
      end;

      // determina la causale da impostare
      if IsL133DieciGG then
        CausSost:=IfThen(ListCatenaL133[index] <> '',ListCatenaL133[index],ListCatena[index])
      else
        CausSost:=ListCatena[index];

      // verifica se è necessario sostituire la causale
      if (CausSost <> '') and (Caus <> CausSost) then
      begin
        // sostituzione causale
        selT040Concat.Edit;
        selT040Concat.FieldByName('CAUSALE').AsString:=CausSost;
        RegistraLog.SettaProprieta('M','T040_GIUSTIFICATIVI','R600',selT040Concat,True);
        while True do
        try
          selT040Concat.Post;
          Break;
        except
          on E:Exception do
            if Copy(UpperCase(E.Message),1,9) = 'ORA-00001' then
              selT040Concat.FieldByName('PROGRCAUSALE').AsInteger:=selT040Concat.FieldByName('PROGRCAUSALE').AsInteger + 1
            else
              raise;
        end;
        RegistraLog.RegistraOperazione;

        // gestione periodi assenza
        with Periodiassenza do
        begin
          // vecchio giustificativo
          ClearVariables;
          SetVariable('PROG',Progressivo);
          SetVariable('INIZIO',DataAss);
          SetVariable('FINE',DataAss);
          SetVariable('CAUS',Caus);
          SetVariable('TG',selT040Concat.FieldByName('TIPOGIUST').AsString);
          SetVariable('OPER','C');
          if (selT040Concat.FieldByName('TIPOGIUST').AsString = 'N') or
             (selT040Concat.FieldByName('TIPOGIUST').AsString = 'D') then
            SetVariable('DALLE',FormatDateTime('hh.nn',selT040Concat.FieldByName('DAORE').AsDateTime));
          if (selT040Concat.FieldByName('TIPOGIUST').AsString = 'D') then
            SetVariable('ALLE',FormatDateTime('hh.nn',selT040Concat.FieldByName('AORE').AsDateTime));
          Execute;

          // nuovo giustificativo
          SetVariable('CAUS',CausSost);
          SetVariable('OPER','I');
          Execute;
        end;
        SessioneOracleR600.Commit;
      end;

      // aggiorna progressbar
      {$IFNDEF IRISWEB}
      if PrbElab <> nil then
      begin
        PrbElab.StepBy(1);
        PrbElab.Repaint;
      end;
      {$ENDIF IRISWEB}

      selT040Concat.Next;
    end;
  finally
    RettificaCatenacompetenze:=False;
    // riposiziona progressbar
    {$IFNDEF IRISWEB}
    if PrbElab <> nil then
    begin
      PrbElab.Position:=0;
      PrbElab.Repaint;
    end;
    {$ENDIF IRISWEB}
    // dealloca risorse
    FreeAndNil(ListCatena);
    FreeAndNil(ListCatenaL133);
    // chiude dataset dei giustificativi futuri
    selT040Concat.Close;
    {$IFNDEF IRISWEB}
    // ripristina cursore se necessario
    if CurDefaultIniziale then
      Screen.Cursor:=crDefault;
    {$ENDIF}
  end;
end;

procedure TR600DtM1.ChiudiGiustifAssFuturi;
// Chiude il dataset dei giustificativi di assenza da riallineare
begin
  selT040Concat.Close;
end;

//------------------------------------------------------------------------------
//----------   G E S T I O N E   V I S I T E   F I S C A L I   -----------------
//------------------------------------------------------------------------------
procedure TR600DtM1.VisFiscaliAddData(Data: TDateTime);
// Aggiunge la data indicata all'array da considerare per inserire o cancellare
// i periodi da comunicare per le visite fiscali
begin
  VisFiscali.NumDate:=VisFiscali.NumDate + 1;
  VisFiscali.DateArr[VisFiscali.NumDate]:=Data;
end;

procedure TR600DtM1.VisFiscaliFreeArray;
begin
  SetLength(VisFiscali.DateArr,0);
  VisFiscali.NumDate:=0;
end;

procedure TR600DtM1.VisFiscaliSetArray(NewDim: Integer);
// Imposta la dimensione dell'array dei giorni da considerare per le visite fiscali
var
  i:Integer;
begin
  // azzera il numero di elementi da considerare
  VisFiscali.NumDate:=0;

  // se la dimensione è 0, dealloca l'array dinamico
  if NewDim <= 0 then
    SetLength(VisFiscali.DateArr,0)
  else
  begin
    SetLength(VisFiscali.DateArr,NewDim);

    // pulizia array
    for i:=0 to (NewDim - 1) do
      VisFiscali.DateArr[i]:=0;
  end;
end;

procedure TR600DtM1.VisFiscaliInsPeriodi;
// Considera i periodi di assenza inseriti per la gestione della tabella
// T047 delle comunicazioni per le visite fiscali
var
  i:Integer;
  DataCorr: TDateTime;
  PeriodoPrec, PeriodoPrecProlungato, PeriodoPrecComunicato:Boolean;
  PeriodoSucc:Boolean;
  InizioUguale,FineUguale:Boolean;
  DataFineAssenzaTemp: TDateTime;
  DomicilioAlt: Boolean;
begin
  selT047CancPrec.CommitOnPost:=False;//Chiamante <> 'A087';
  selT047.CommitOnPost:=False;//Chiamante <> 'A087';
  selT047Prec.CommitOnPost:=False;//Chiamante <> 'A087';
  selT047InsPrec.CommitOnPost:=False;//Chiamante <> 'A087';
  selT047Succ.CommitOnPost:=False;//Chiamante <> 'A087';

  selT047.Close;
  selT047.Open;

  // verifica presenza di dati di domicilio alternativo
  DomicilioAlt:=(VisFiscali.CodComune <> '') or
                (VisFiscali.Indirizzo <> '') or
                (VisFiscali.Cap <> '');

  // ciclo sulle assenze inserite rilevanti per le visite fiscali
  for i:=1 to VisFiscali.NumDate do
  begin
    DataCorr:=VisFiscali.DateArr[i];

    // cerca se data è interna ad un periodo cancellato e non comunicato
    selT047CancPrec.Close;
    selT047CancPrec.SetVariable('PROGRESSIVO',VisFiscali.Progressivo);
    selT047CancPrec.SetVariable('DATA_CORR', DataCorr);
    selT047CancPrec.Open;
    if selT047CancPrec.RecordCount > 0 then
    begin
      selT047CancPrec.First;
      InizioUguale:=DataCorr = selT047CancPrec.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime;
      FineUguale:=DataCorr = selT047CancPrec.FieldByName('DATA_FINE_ASSENZA').AsDateTime;

      if InizioUguale and FineUguale then
      begin
        // ins copre interamente una cancellazione non ancora comunicata
        // elimina la riga relativa alla cancellazione
        selT047CancPrec.Delete;
      end
      else if InizioUguale then
      begin
        // ins copre il primo giorno di una cancellazione non ancora comunicata
        // sposta in avanti di un giorno la data inizio del periodo cancellato
        selT047CancPrec.Edit;
        selT047CancPrec.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataCorr+1;
        selT047CancPrec.FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
        selT047CancPrec.Post;
      end
      else if FineUguale then
      begin
        // ins copre l'ultimo giorno di una cancellazione non ancora comunicata
        // sposta indietro di un giorno la data fine del periodo cancellato
        selT047CancPrec.Edit;
        selT047CancPrec.FieldByName('DATA_FINE_ASSENZA').AsDateTime:=DataCorr-1;
        selT047CancPrec.FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
        selT047CancPrec.Post;
      end
      else
      begin
        // ins è strettamente interno ad una cancellazione non ancora comunicata
        // la cancellazione viene spezzata in due righe
        with selT047CancPrec do
        begin
          DataFineAssenzaTemp:=FieldByName('DATA_FINE_ASSENZA').AsDateTime;

          Edit;
          FieldByName('DATA_FINE_ASSENZA').AsDateTime:=DataCorr-1;
          FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
          Post;
        end;

        with selT047 do
        begin
          Append;
          FieldByName('TIPO_EVENTO').Value:=selT047CancPrec.FieldByName('TIPO_EVENTO').Value;
          FieldByName('PROGRESSIVO').Value:=selT047CancPrec.FieldByName('PROGRESSIVO').Value;
          FieldByName('OPERAZIONE').Value:=selT047CancPrec.FieldByName('OPERAZIONE').Value;
          FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataCorr+1;
          FieldByName('DATA_FINE_ASSENZA').AsDateTime:=DataFineAssenzaTemp;
          FieldByName('NUOVA_DATA_FINE').Value:=null;
          FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
          FieldByName('DATA_PRIMA_COMUNICAZIONE').Value:=null;
          FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
          FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
          FieldByName('COD_COMUNE').Value:=selT047CancPrec.FieldByName('COD_COMUNE').Value;
          FieldByName('INDIRIZZO').Value:=selT047CancPrec.FieldByName('INDIRIZZO').Value;
          FieldByName('CAP').Value:=selT047CancPrec.FieldByName('CAP').Value;
          FieldByName('TELEFONO').Value:=selT047CancPrec.FieldByName('TELEFONO').Value;
          FieldByName('MEDICINA_LEGALE').Value:=selT047CancPrec.FieldByName('MEDICINA_LEGALE').Value;
          FieldByName('NOTE').Value:=selT047CancPrec.FieldByName('NOTE').Value;
          Post;
        end;
      end;
      (*
      if Chiamante <> 'A087' then
        // committa e passa direttamente alla data successiva di assenza
        try SessioneOracleR600.Commit; except end;
      *)
      Continue;
    end;

    { verifica periodo immediatamente precedente
       vengono valutati i seguenti casi:
       1. non comunicato la prima volta
       2. comunicato la prima volta ma non prolungato
       3. prolungato ma non comunicato la seconda volta
       NOTA: in nessun caso il periodo è annullato }
    PeriodoPrecProlungato:=False;
    PeriodoPrecComunicato:=False;
    PeriodoPrec:=False;
    selT047Prec.Close;
    selT047Prec.SetVariable('PROGRESSIVO',VisFiscali.Progressivo);
    selT047Prec.SetVariable('OPERAZIONE','I');
    selT047Prec.SetVariable('DATA_FINE',(DataCorr - 1));
    selT047Prec.Open;
    if selT047Prec.RecordCount > 0 then
    begin
      selT047Prec.First;
      PeriodoPrecProlungato:=selT047Prec.FieldByName('NUOVA_DATA_FINE').AsDateTime = DataCorr-1;
      if not PeriodoPrecProlungato then
      begin
        PeriodoPrecComunicato:=not selT047Prec.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
        PeriodoPrec:=not PeriodoPrecComunicato;
      end;
    end;

    // verifica periodo immediatamente successivo non ancora comunicato
    selT047Succ.Close;
    selT047Succ.SetVariable('PROGRESSIVO',VisFiscali.Progressivo);
    selT047Succ.SetVariable('OPERAZIONE','I');
    selT047Succ.SetVariable('DATA_INIZIO',(DataCorr + 1));
    selT047Succ.Open;
    PeriodoSucc:=(selT047Succ.RecordCount > 0);
    if PeriodoSucc then
      selT047Succ.First;

    // gestione dei diversi casi
    if PeriodoPrec and PeriodoSucc then
    begin
      // periodo precedente non prolungato e non comunicato e successivo "adiacenti"
      // ingloba i due periodi, aggiornando la data di fine assenza del primo
      selT047Prec.Edit;
      selT047Prec.FieldByName('DATA_FINE_ASSENZA').Value:=selT047Succ.FieldByName('DATA_FINE_ASSENZA').Value;
      selT047Prec.FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
      selT047Prec.FieldByName('COD_COMUNE').AsString:=IfThen(DomicilioAlt,VisFiscali.CodComune,'');
      selT047Prec.FieldByName('INDIRIZZO').AsString:=IfThen(DomicilioAlt,VisFiscali.Indirizzo,'');
      selT047Prec.FieldByName('CAP').AsString:=IfThen(DomicilioAlt,VisFiscali.Cap,'');
      selT047Prec.FieldByName('TELEFONO').AsString:=VisFiscali.Telefono;
      selT047Prec.FieldByName('MEDICINA_LEGALE').AsString:=VisFiscali.MedicinaLegale;
      selT047Prec.FieldByName('NOTE').AsString:=VisFiscali.Note;
      selT047Prec.FieldByName('TIPO_ESENZIONE').AsString:=VisFiscali.TipoEsenzione;
      if VisFiscali.DataEsenzione = 0 then
        selT047Prec.FieldByName('DATA_ESENZIONE').Clear
      else
        selT047Prec.FieldByName('DATA_ESENZIONE').AsDateTime:=VisFiscali.DataEsenzione;
      selT047Prec.FieldByName('OPERATORE').AsString:=VisFiscali.OperatoreEsenzione;
      selT047Prec.Post;

      selT047Succ.Delete;
    end
    else if PeriodoPrecComunicato and PeriodoSucc then
    begin
      // periodo precedente comunicato e successivo "adiacenti"
      // ingloba i due periodi, impostando la data di fine prolungamento del primo
      selT047Prec.Edit;
      selT047Prec.FieldByName('NUOVA_DATA_FINE').Value:=selT047Succ.FieldByName('DATA_FINE_ASSENZA').Value;
      selT047Prec.FieldByName('DATA_REGIS_PROLUNGAMENTO').AsDateTime:=R180SysDate(SessioneOracleR600);
      selT047Prec.FieldByName('COD_COMUNE').AsString:=IfThen(DomicilioAlt,VisFiscali.CodComune,'');
      selT047Prec.FieldByName('INDIRIZZO').AsString:=IfThen(DomicilioAlt,VisFiscali.Indirizzo,'');
      selT047Prec.FieldByName('CAP').AsString:=IfThen(DomicilioAlt,VisFiscali.Cap,'');
      selT047Prec.FieldByName('TELEFONO').AsString:=VisFiscali.Telefono;
      selT047Prec.FieldByName('MEDICINA_LEGALE').AsString:=VisFiscali.MedicinaLegale;
      selT047Prec.FieldByName('NOTE').AsString:=VisFiscali.Note;
      selT047Prec.FieldByName('TIPO_ESENZIONE').AsString:=VisFiscali.TipoEsenzione;
      if VisFiscali.DataEsenzione = 0 then
        selT047Prec.FieldByName('DATA_ESENZIONE').Clear
      else
        selT047Prec.FieldByName('DATA_ESENZIONE').AsDateTime:=VisFiscali.DataEsenzione;
      selT047Prec.FieldByName('OPERATORE').AsString:=VisFiscali.OperatoreEsenzione;
      selT047Prec.Post;

      selT047Succ.Delete;
    end
    else if PeriodoPrecProlungato and PeriodoSucc then
    begin
      // periodo precedente prolungato ma non ancora comunicato e successivo "adiacenti"
      // ingloba i due periodi, aggiornando la data di fine prolungamento del primo
      selT047Prec.Edit;
      selT047Prec.FieldByName('NUOVA_DATA_FINE').Value:=selT047Succ.FieldByName('DATA_FINE_ASSENZA').Value;
      selT047Prec.FieldByName('DATA_REGIS_PROLUNGAMENTO').AsDateTime:=R180SysDate(SessioneOracleR600);
      selT047Prec.FieldByName('COD_COMUNE').AsString:=IfThen(DomicilioAlt,VisFiscali.CodComune,'');
      selT047Prec.FieldByName('INDIRIZZO').AsString:=IfThen(DomicilioAlt,VisFiscali.Indirizzo,'');
      selT047Prec.FieldByName('CAP').AsString:=IfThen(DomicilioAlt,VisFiscali.Cap,'');
      selT047Prec.FieldByName('TELEFONO').AsString:=VisFiscali.Telefono;
      selT047Prec.FieldByName('MEDICINA_LEGALE').AsString:=VisFiscali.MedicinaLegale;
      selT047Prec.FieldByName('NOTE').AsString:=VisFiscali.Note;
      selT047Prec.FieldByName('TIPO_ESENZIONE').AsString:=VisFiscali.TipoEsenzione;
      if VisFiscali.DataEsenzione = 0 then
        selT047Prec.FieldByName('DATA_ESENZIONE').Clear
      else
        selT047Prec.FieldByName('DATA_ESENZIONE').AsDateTime:=VisFiscali.DataEsenzione;
      selT047Prec.FieldByName('OPERATORE').AsString:=VisFiscali.OperatoreEsenzione;
      selT047Prec.Post;

      selT047Succ.Delete;
    end
    else if PeriodoPrec then
    begin
      // periodo precedente non prolungato e non ancora comunicato
      // sposta la data di fine del periodo precedente
      selT047Prec.Edit;
      selT047Prec.FieldByName('DATA_FINE_ASSENZA').AsDateTime:=DataCorr;
      selT047Prec.FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
      selT047Prec.FieldByName('COD_COMUNE').AsString:=IfThen(DomicilioAlt,VisFiscali.CodComune,'');
      selT047Prec.FieldByName('INDIRIZZO').AsString:=IfThen(DomicilioAlt,VisFiscali.Indirizzo,'');
      selT047Prec.FieldByName('CAP').AsString:=IfThen(DomicilioAlt,VisFiscali.Cap,'');
      selT047Prec.FieldByName('TELEFONO').AsString:=VisFiscali.Telefono;
      selT047Prec.FieldByName('MEDICINA_LEGALE').AsString:=VisFiscali.MedicinaLegale;
      selT047Prec.FieldByName('NOTE').AsString:=VisFiscali.Note;
      selT047Prec.FieldByName('TIPO_ESENZIONE').AsString:=VisFiscali.TipoEsenzione;
      if VisFiscali.DataEsenzione = 0 then
        selT047Prec.FieldByName('DATA_ESENZIONE').Clear
      else
        selT047Prec.FieldByName('DATA_ESENZIONE').AsDateTime:=VisFiscali.DataEsenzione;
      selT047Prec.FieldByName('OPERATORE').AsString:=VisFiscali.OperatoreEsenzione;
      selT047Prec.Post;
    end
    else if PeriodoPrecComunicato then
    begin
      // periodo precedente non prolungato ma già comunicato
      // imposta la data di prolungamento del periodo immediatamente precedente
      selT047Prec.Edit;
      selT047Prec.FieldByName('NUOVA_DATA_FINE').AsDateTime:=DataCorr;
      selT047Prec.FieldByName('DATA_REGIS_PROLUNGAMENTO').AsDateTime:=R180SysDate(SessioneOracleR600);
      selT047Prec.FieldByName('COD_COMUNE').AsString:=IfThen(DomicilioAlt,VisFiscali.CodComune,'');
      selT047Prec.FieldByName('INDIRIZZO').AsString:=IfThen(DomicilioAlt,VisFiscali.Indirizzo,'');
      selT047Prec.FieldByName('CAP').AsString:=IfThen(DomicilioAlt,VisFiscali.Cap,'');
      selT047Prec.FieldByName('TELEFONO').AsString:=VisFiscali.Telefono;
      selT047Prec.FieldByName('MEDICINA_LEGALE').AsString:=VisFiscali.MedicinaLegale;
      selT047Prec.FieldByName('NOTE').AsString:=VisFiscali.Note;
      selT047Prec.FieldByName('TIPO_ESENZIONE').AsString:=VisFiscali.TipoEsenzione;
      if VisFiscali.DataEsenzione = 0 then
        selT047Prec.FieldByName('DATA_ESENZIONE').Clear
      else
        selT047Prec.FieldByName('DATA_ESENZIONE').AsDateTime:=VisFiscali.DataEsenzione;
      selT047Prec.FieldByName('OPERATORE').AsString:=VisFiscali.OperatoreEsenzione;
      selT047Prec.Post;
    end
    else if PeriodoPrecProlungato then
    begin
      // periodo precedente prolungato e non ancora comunicato
      // sposta la data di prolungamento del periodo immediatamente precedente
      selT047Prec.Edit;
      selT047Prec.FieldByName('NUOVA_DATA_FINE').AsDateTime:=DataCorr;
      selT047Prec.FieldByName('DATA_REGIS_PROLUNGAMENTO').AsDateTime:=R180SysDate(SessioneOracleR600);
      selT047Prec.FieldByName('COD_COMUNE').AsString:=IfThen(DomicilioAlt,VisFiscali.CodComune,'');
      selT047Prec.FieldByName('INDIRIZZO').AsString:=IfThen(DomicilioAlt,VisFiscali.Indirizzo,'');
      selT047Prec.FieldByName('CAP').AsString:=IfThen(DomicilioAlt,VisFiscali.Cap,'');
      selT047Prec.FieldByName('TELEFONO').AsString:=VisFiscali.Telefono;
      selT047Prec.FieldByName('MEDICINA_LEGALE').AsString:=VisFiscali.MedicinaLegale;
      selT047Prec.FieldByName('NOTE').AsString:=VisFiscali.Note;
      selT047Prec.FieldByName('TIPO_ESENZIONE').AsString:=VisFiscali.TipoEsenzione;
      if VisFiscali.DataEsenzione = 0 then
        selT047Prec.FieldByName('DATA_ESENZIONE').Clear
      else
        selT047Prec.FieldByName('DATA_ESENZIONE').AsDateTime:=VisFiscali.DataEsenzione;
      selT047Prec.FieldByName('OPERATORE').AsString:=VisFiscali.OperatoreEsenzione;
      selT047Prec.Post;
    end
    else if PeriodoSucc then
    begin
      // periodo precedente non prolungato e non ancora comunicato
      // sposta la data di inizio del periodo immediatamente successivo
      selT047Succ.Edit;
      selT047Succ.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataCorr;
      selT047Succ.FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
      selT047Succ.FieldByName('COD_COMUNE').AsString:=IfThen(DomicilioAlt,VisFiscali.CodComune,'');
      selT047Succ.FieldByName('INDIRIZZO').AsString:=IfThen(DomicilioAlt,VisFiscali.Indirizzo,'');
      selT047Succ.FieldByName('CAP').AsString:=IfThen(DomicilioAlt,VisFiscali.Cap,'');
      selT047Succ.FieldByName('TELEFONO').AsString:=VisFiscali.Telefono;
      selT047Succ.FieldByName('MEDICINA_LEGALE').AsString:=VisFiscali.MedicinaLegale;
      selT047Succ.FieldByName('NOTE').AsString:=VisFiscali.Note;
      selT047Succ.FieldByName('TIPO_ESENZIONE').AsString:=VisFiscali.TipoEsenzione;
      if VisFiscali.DataEsenzione = 0 then
        selT047Succ.FieldByName('DATA_ESENZIONE').Clear
      else
        selT047Succ.FieldByName('DATA_ESENZIONE').AsDateTime:=VisFiscali.DataEsenzione;
      selT047Succ.FieldByName('OPERATORE').AsString:=VisFiscali.OperatoreEsenzione;
      selT047Succ.Post;
    end
    else
    begin
      // inserisce un nuovo periodo
      with selT047 do
      begin
        Append;
        FieldByName('TIPO_EVENTO').AsString:='01';
        FieldByName('PROGRESSIVO').AsInteger:=VisFiscali.Progressivo;
        FieldByName('OPERAZIONE').AsString:='I';
        FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataCorr;
        FieldByName('DATA_FINE_ASSENZA').AsDateTime:=DataCorr;
        FieldByName('NUOVA_DATA_FINE').Value:=null;
        FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
        FieldByName('DATA_PRIMA_COMUNICAZIONE').Value:=null;
        FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
        FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
        FieldByName('COD_COMUNE').AsString:=IfThen(DomicilioAlt,VisFiscali.CodComune,'');
        FieldByName('INDIRIZZO').AsString:=IfThen(DomicilioAlt,VisFiscali.Indirizzo,'');
        FieldByName('CAP').AsString:=IfThen(DomicilioAlt,VisFiscali.Cap,'');
        FieldByName('TELEFONO').AsString:=VisFiscali.Telefono;
        FieldByName('MEDICINA_LEGALE').AsString:=VisFiscali.MedicinaLegale;
        FieldByName('NOTE').AsString:=VisFiscali.Note;
        FieldByName('TIPO_ESENZIONE').AsString:=VisFiscali.TipoEsenzione;
        if VisFiscali.DataEsenzione = 0 then
          FieldByName('DATA_ESENZIONE').Clear
        else
          FieldByName('DATA_ESENZIONE').AsDateTime:=VisFiscali.DataEsenzione;
        FieldByName('OPERATORE').AsString:=VisFiscali.OperatoreEsenzione;
        Post;
      end; // => with selT047
    end;
    (*
    if Chiamante <> 'A087' then
      // commit
      try SessioneOracleR600.Commit; except end;
    *)
  end; // => end for principale

  // chiusura dataset
  selT047.Close;
  selT047CancPrec.Close;
  selT047Prec.Close;
  selT047Succ.Close;

  //Finalize(VisFiscali.DateArr);
  VisFiscaliFreeArray;
end;

procedure TR600DtM1.VisFiscaliCanPeriodi;
// Considera i periodi di assenza inseriti per la gestione della tabella
// T047 delle comunicazioni per le visite fiscali
var
  i:Integer;
  DataCorr: TDateTime;
  InizioUguale, FineUguale:Boolean;
  EsistePeriodoPrec, EsistePeriodoSucc: Boolean;
  DomicilioAlt: Boolean;
begin
  selT047.CommitOnPost:=False;//Chiamante <> 'A087';
  selT047Prec.CommitOnPost:=False;//Chiamante <> 'A087';
  selT047Succ.CommitOnPost:=False;//Chiamante <> 'A087';
  selT047InsPrec.CommitOnPost:=False;//Chiamante <> 'A087';
  selT047InsPrecCom.CommitOnPost:=False;

  selT047.Close;
  selT047.Open;

  DomicilioAlt:=(VisFiscali.CodComune <> '') or
                (VisFiscali.Indirizzo <> '') or
                (VisFiscali.Cap <> '');

  // ciclo sulle date di assenza cancellate per gestione tabella delle visite fiscali T047
  for i:=1 to VisFiscali.NumDate do
  begin
    DataCorr:=VisFiscali.DateArr[i];

    // verifica se data è interna alla prima parte (data_inizio..data_fine)
    // di un periodo prolungato e comunicato la prima volta
    selT047InsPrecCom.Close;
    selT047InsPrecCom.SetVariable('PROGRESSIVO',VisFiscali.Progressivo);
    selT047InsPrecCom.SetVariable('DATA_CORR',DataCorr);
    selT047InsPrecCom.Open;
    if selT047InsPrecCom.RecordCount > 0 then
    begin
      // considero periodo da data inizio assenza a data fine assenza
      FineUguale:=DataCorr = selT047InsPrecCom.FieldByName('DATA_FINE_ASSENZA').AsDateTime;

      if FineUguale then
      begin
        // il prolungamento non ha più ragione di esistere
        // inserisco un nuovo periodo
        with selT047 do
        begin
          Append;
          FieldByName('TIPO_EVENTO').Value:=selT047InsPrecCom.FieldByName('TIPO_EVENTO').Value;
          FieldByName('PROGRESSIVO').Value:=selT047InsPrecCom.FieldByName('PROGRESSIVO').Value;
          FieldByName('OPERAZIONE').Value:=selT047InsPrecCom.FieldByName('OPERAZIONE').Value;
          FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataCorr+1;
          FieldByName('DATA_FINE_ASSENZA').Value:=selT047InsPrecCom.FieldByName('NUOVA_DATA_FINE').Value;
          FieldByName('NUOVA_DATA_FINE').Value:=null;
          FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
          FieldByName('DATA_PRIMA_COMUNICAZIONE').Value:=null;
          FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
          FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
          FieldByName('COD_COMUNE').Value:=selT047InsPrecCom.FieldByName('COD_COMUNE').Value;
          FieldByName('INDIRIZZO').Value:=selT047InsPrecCom.FieldByName('INDIRIZZO').Value;
          FieldByName('CAP').Value:=selT047InsPrecCom.FieldByName('CAP').Value;
          FieldByName('TELEFONO').Value:=selT047InsPrecCom.FieldByName('TELEFONO').Value;
          FieldByName('MEDICINA_LEGALE').Value:=selT047InsPrecCom.FieldByName('MEDICINA_LEGALE').Value;
          FieldByName('NOTE').Value:=selT047InsPrecCom.FieldByName('NOTE').Value;
          Post;
        end;

        with selT047InsPrecCom do
        begin
          Edit;
          FieldByName('NUOVA_DATA_FINE').Value:=null;
          FieldByName('DATA_REGIS_PROLUNGAMENTO').AsDateTime:=R180SysDate(SessioneOracleR600);
          Post;
        end;
        (*
        if Chiamante <> 'A087' then
          // committa
          try SessioneOracleR600.Commit; except end;
        *)
      end;
    end;

    // verifica se data è interna ad un periodo non prolungato (data_inizio..data_fine) oppure
    // ad un periodo prolungato (data_fine+1..nuova_data_fine) non comunicato
    selT047InsPrec.Close;
    selT047InsPrec.SetVariable('PROGRESSIVO',VisFiscali.Progressivo);
    selT047InsPrec.SetVariable('DATA_CORR',DataCorr);
    selT047InsPrec.Open;
    if selT047InsPrec.RecordCount > 0 then
    begin
      selT047InsPrec.First;

      // considerazioni in base al periodo prolungato / non prolungato
      if selT047InsPrec.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull then
      begin
        // il periodo inserito non è prolungato
        // considero periodo da data inizio assenza a data fine assenza
        InizioUguale:=DataCorr = selT047InsPrec.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime;
        FineUguale:=DataCorr = selT047InsPrec.FieldByName('DATA_FINE_ASSENZA').AsDateTime;

        if InizioUguale and FineUguale then
        begin
          // can copre interamente un inserimento non ancora comunicato
          // elimina la riga relativa all'inserimento
          selT047InsPrec.Delete;
        end
        else if InizioUguale then
        begin
          // can copre il primo giorno di un inserimento non ancora comunicato
          // sposta avanti di un giorno la data inizio del periodo inserito
          selT047InsPrec.Edit;
          selT047InsPrec.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataCorr + 1;
          selT047InsPrec.FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
          selT047InsPrec.Post;
        end
        else if FineUguale then
        begin
          // can copre l'ultimo giorno di un inserimento non ancora comunicato
          // sposta indietro di un giorno la data fine del periodo inserito
          selT047InsPrec.Edit;
          selT047InsPrec.FieldByName('DATA_FINE_ASSENZA').AsDateTime:=DataCorr - 1;
          selT047InsPrec.FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
          selT047InsPrec.Post;
        end
        else
        begin
          // can è strettamente interna ad un inserimento non ancora comunicato
          // l'inserimento viene spezzato in due righe

          // parte 1. crea un nuovo periodo duplicando il precedente e modificando le date
          with selT047 do
          begin
            Append;
            FieldByName('TIPO_EVENTO').Value:=selT047InsPrec.FieldByName('TIPO_EVENTO').Value;
            FieldByName('PROGRESSIVO').Value:=selT047InsPrec.FieldByName('PROGRESSIVO').Value;
            FieldByName('OPERAZIONE').Value:=selT047InsPrec.FieldByName('OPERAZIONE').Value;
            FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataCorr + 1;
            FieldByName('DATA_FINE_ASSENZA').Value:=selT047InsPrec.FieldByName('DATA_FINE_ASSENZA').Value;
            FieldByName('NUOVA_DATA_FINE').Value:=null;
            FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
            FieldByName('DATA_PRIMA_COMUNICAZIONE').Value:=null;
            FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
            FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
            FieldByName('COD_COMUNE').Value:=selT047InsPrec.FieldByName('COD_COMUNE').Value;
            FieldByName('INDIRIZZO').Value:=selT047InsPrec.FieldByName('INDIRIZZO').Value;
            FieldByName('CAP').Value:=selT047InsPrec.FieldByName('CAP').Value;
            FieldByName('TELEFONO').Value:=selT047InsPrec.FieldByName('TELEFONO').Value;
            FieldByName('MEDICINA_LEGALE').Value:=selT047InsPrec.FieldByName('MEDICINA_LEGALE').Value;
            FieldByName('NOTE').Value:=selT047InsPrec.FieldByName('NOTE').Value;
            Post;
          end;

          // parte 2. sposta indietro di un giorno la data fine periodo
          with selT047InsPrec do
          begin
            Edit;
            FieldByName('DATA_FINE_ASSENZA').AsDateTime:=DataCorr - 1;
            FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
            Post;
          end;
        end;
      end
      else
      begin
        // il periodo inserito è prolungato
        // considero il periodo dal giorno successivo alla data fine alla nuova data fine
        InizioUguale:=DataCorr = selT047InsPrec.FieldByName('DATA_FINE_ASSENZA').AsDateTime + 1;
        FineUguale:=DataCorr = selT047InsPrec.FieldByName('NUOVA_DATA_FINE').AsDateTime;

        if InizioUguale and FineUguale then
        begin
          // can copre interamente un prolungamento non ancora comunicato
          // cancella i dati del prolungamento
          selT047InsPrec.Edit;
          selT047InsPrec.FieldByName('NUOVA_DATA_FINE').Value:=null;
          selT047InsPrec.FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
          selT047InsPrec.Post;
        end
        else if InizioUguale then
        begin
          // can copre il primo giorno di un prolungamento non ancora comunicato
          // cancella i dati del prolungamento e inserisce un nuovo periodo
          with selT047 do
          begin
            Append;
            FieldByName('TIPO_EVENTO').Value:=selT047InsPrec.FieldByName('TIPO_EVENTO').Value;
            FieldByName('PROGRESSIVO').Value:=selT047InsPrec.FieldByName('PROGRESSIVO').Value;
            FieldByName('OPERAZIONE').Value:=selT047InsPrec.FieldByName('OPERAZIONE').Value;
            FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataCorr + 1;
            FieldByName('DATA_FINE_ASSENZA').Value:=selT047InsPrec.FieldByName('NUOVA_DATA_FINE').Value;
            FieldByName('NUOVA_DATA_FINE').Value:=null;
            FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
            FieldByName('DATA_PRIMA_COMUNICAZIONE').Value:=null;
            FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
            FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
            FieldByName('COD_COMUNE').Value:=selT047InsPrec.FieldByName('COD_COMUNE').Value;
            FieldByName('INDIRIZZO').Value:=selT047InsPrec.FieldByName('INDIRIZZO').Value;
            FieldByName('CAP').Value:=selT047InsPrec.FieldByName('CAP').Value;
            FieldByName('TELEFONO').Value:=selT047InsPrec.FieldByName('TELEFONO').Value;
            FieldByName('MEDICINA_LEGALE').Value:=selT047InsPrec.FieldByName('MEDICINA_LEGALE').Value;
            FieldByName('NOTE').Value:=selT047InsPrec.FieldByName('NOTE').Value;
            Post;
          end;

          with selT047InsPrec do
          begin
            Edit;
            FieldByName('NUOVA_DATA_FINE').Value:=null;
            FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
            Post;
          end;
        end
        else if FineUguale then
        begin
          // can copre l'ultimo giorno di un prolungamento non ancora comunicato
          // sposta indietro di un giorno la data fine del prolungamento
          selT047InsPrec.Edit;
          selT047InsPrec.FieldByName('NUOVA_DATA_FINE').AsDateTime:=DataCorr - 1;
          selT047InsPrec.FieldByName('DATA_REGIS_PROLUNGAMENTO').AsDateTime:=R180SysDate(SessioneOracleR600);
          selT047InsPrec.Post;
        end
        else
        begin
          // can è strettamente interno ad un prolungamento non ancora comunicato
          // riduce il prolungamento e inserisce un nuovo periodo
          with selT047 do
          begin
            Append;
            FieldByName('TIPO_EVENTO').Value:=selT047InsPrec.FieldByName('TIPO_EVENTO').Value;
            FieldByName('PROGRESSIVO').Value:=selT047InsPrec.FieldByName('PROGRESSIVO').Value;
            FieldByName('OPERAZIONE').Value:=selT047InsPrec.FieldByName('OPERAZIONE').Value;
            FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataCorr + 1;
            FieldByName('DATA_FINE_ASSENZA').Value:=selT047InsPrec.FieldByName('NUOVA_DATA_FINE').Value;
            FieldByName('NUOVA_DATA_FINE').Value:=null;
            FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
            FieldByName('DATA_PRIMA_COMUNICAZIONE').Value:=null;
            FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
            FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
            FieldByName('COD_COMUNE').Value:=selT047InsPrec.FieldByName('COD_COMUNE').Value;
            FieldByName('INDIRIZZO').Value:=selT047InsPrec.FieldByName('INDIRIZZO').Value;
            FieldByName('CAP').Value:=selT047InsPrec.FieldByName('CAP').Value;
            FieldByName('TELEFONO').Value:=selT047InsPrec.FieldByName('TELEFONO').Value;
            FieldByName('MEDICINA_LEGALE').Value:=selT047InsPrec.FieldByName('MEDICINA_LEGALE').Value;
            FieldByName('NOTE').Value:=selT047InsPrec.FieldByName('NOTE').Value;
            Post;
          end;

          with selT047InsPrec do
          begin
            Edit;
            FieldByName('NUOVA_DATA_FINE').AsDateTime:=DataCorr - 1;
            FieldByName('DATA_REGIS_PROLUNGAMENTO').AsDateTime:=R180SysDate(SessioneOracleR600);
            Post;
          end;
        end;
      end;
      (*
      if Chiamante <> 'A087' then
        // committa e passa alla data successiva
        try SessioneOracleR600.Commit; except end;
      *)
      Continue;
    end;

    // verifica periodo immediatamente precedente
    EsistePeriodoPrec:=False;
    selT047Prec.Close;
    selT047Prec.SetVariable('PROGRESSIVO',VisFiscali.Progressivo);
    selT047Prec.SetVariable('OPERAZIONE','C');
    selT047Prec.SetVariable('DATA_FINE',(DataCorr - 1));
    selT047Prec.Open;
    if selT047Prec.RecordCount > 0 then
    begin
      selT047Prec.First;
      EsistePeriodoPrec:=selT047Prec.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull;
    end;

    // verifica periodo immediatamente successivo non ancora comunicato
    selT047Succ.Close;
    selT047Succ.SetVariable('PROGRESSIVO',VisFiscali.Progressivo);
    selT047Succ.SetVariable('OPERAZIONE','C');
    selT047Succ.SetVariable('DATA_INIZIO',(DataCorr + 1));
    selT047Succ.Open;
    EsistePeriodoSucc:=(selT047Succ.RecordCount > 0);

    // gestione dei diversi casi
    if EsistePeriodoPrec and EsistePeriodoSucc then
    begin
      // periodo precedente non comunicato e successivo "adiacenti"
      // ingloba i due periodi, aggiornando la data di fine assenza del primo
      selT047Prec.Edit;
      selT047Prec.FieldByName('DATA_FINE_ASSENZA').Value:=selT047Succ.FieldByName('DATA_FINE_ASSENZA').Value;
      selT047Prec.FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
      selT047Prec.Post;

      selT047Succ.Delete;
    end
    else if EsistePeriodoPrec then
    begin
      // periodo precedente non comunicato
      // sposta la data di fine del periodo precedente
      selT047Prec.Edit;
      selT047Prec.FieldByName('DATA_FINE_ASSENZA').AsDateTime:=DataCorr;
      selT047Prec.FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
      selT047Prec.Post;
    end
    else if EsistePeriodoSucc then
    begin
      // periodo precedente non prolungato e non ancora comunicato
      // sposta la data di inizio del periodo immediatamente successivo
      selT047Succ.Edit;
      selT047Succ.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataCorr;
      selT047Succ.FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
      selT047Succ.Post;
    end
    else
    begin
      // inserisce un nuovo periodo
      with selT047 do
      begin
        Append;
        FieldByName('TIPO_EVENTO').AsString:='01';
        FieldByName('PROGRESSIVO').AsInteger:=VisFiscali.Progressivo;
        FieldByName('OPERAZIONE').AsString:='C';
        FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataCorr;
        FieldByName('DATA_FINE_ASSENZA').AsDateTime:=DataCorr;
        FieldByName('NUOVA_DATA_FINE').Value:=null;
        FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracleR600);
        FieldByName('DATA_PRIMA_COMUNICAZIONE').Value:=null;
        FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
        FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
        FieldByName('COD_COMUNE').AsString:=IfThen(DomicilioAlt,VisFiscali.CodComune,'');
        FieldByName('INDIRIZZO').AsString:=IfThen(DomicilioAlt,VisFiscali.Indirizzo,'');;
        FieldByName('CAP').AsString:=IfThen(DomicilioAlt,VisFiscali.Cap,'');;
        FieldByName('TELEFONO').AsString:=VisFiscali.Telefono;
        FieldByName('MEDICINA_LEGALE').AsString:=VisFiscali.MedicinaLegale;
        FieldByName('NOTE').AsString:=VisFiscali.Note;
        FieldByName('TIPO_ESENZIONE').AsString:=VisFiscali.TipoEsenzione;
        if VisFiscali.DataEsenzione = 0 then
          FieldByName('DATA_ESENZIONE').Clear
        else
          FieldByName('DATA_ESENZIONE').AsDateTime:=VisFiscali.DataEsenzione;
        FieldByName('OPERATORE').AsString:=VisFiscali.OperatoreEsenzione;
        Post;
      end;
    end;
    (*
    if Chiamante <> 'A087' then
      // commit
      try SessioneOracleR600.Commit; except end;
    *)
  end; // => end for

  // chiusura dataset
  selT047.Close;
  selT047InsPrecCom.Close;
  selT047Prec.Close;
  selT047Succ.Close;

  //Finalize(VisFiscali.DateArr);
  VisFiscaliFreeArray;
end;

function TR600DtM1.ServeCertificazionePubblica(Progressivo: Integer; Causale: String; D1,D2:TDateTime):Boolean;
var S:String;
begin
  with scrL133PServeCertificPubbl do
  begin
    S:=Causale + ',' + Q265.FieldByName('CODCAU2').AsString;
    S:='''' + StringReplace(S,',',''',''',[rfReplaceAll]) + '''';
    SetVariable('p_progressivo',Progressivo);
    SetVariable('p_data1',D1);
    SetVariable('p_data2',D2);
    Execute;
    Result:=GetVariable('risultato') = 'S';
  end;
end;

function TR600DtM1.AllarmeFruizioneContinuativa(Progressivo:Integer; Data:TDateTime; Causale:String; Periodo:Integer):String;
begin
  Result:='';
  with selGGContinuativi do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('CAUSALE',Causale);
    SetVariable('DATA',Data);
    SetVariable('PERIODO',Periodo);
    Execute;
    if FieldAsInteger('NUMGG') >= Periodo then
      Result:=Format(DataNome,[DateToStr(Data),Matricola,Nome,#13,Causale,#13]) +
              Format('Sono stati inseriti %d giorni continuativi.',[Periodo]);
  end;
end;

procedure TR600DtM1.SettaInfo1(pCognome,pNome,pMatricola,pCausale:String);
begin
  Nome:=Trim(pCognome) + ' ' + Trim(pNome);
  Matricola:=pMatricola;
  CausAnomala:=pCausale;
end;

end.
