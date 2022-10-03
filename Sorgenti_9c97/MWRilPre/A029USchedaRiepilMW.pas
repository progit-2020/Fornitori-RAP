unit A029USchedaRiepilMW;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData,DB, R005UDataModuleMW, R450, C180FunzioniGenerali, Oracle,
  A000UCostanti, A000USessione, A000UInterfaccia, QueryStorico, RegistrazioneLog,
  A029ULiquidazione, A029UBudgetDtM1, DatiBloccati, A000UMessaggi,Math;

type
  TTipoOreCausalizzate = (tocEscluse,tocIncluse,tocCompensabili);

  TFasciaPresenza = record
    CodFascia   : String;
    Fascia      : String;
    OreRese     : Integer;
    AnnoPrec    : Integer;
    Liquidabile : Integer;
    Liquidato   : Integer;
    Residuo     : Integer;
    OrePerse    : Integer;
    BancaOre    : Integer;
  end;

  TTotPresenza = record
    LiquidatoMese : Integer;
    Ore           : Integer;
    Liquidato     : Integer;
    Abbattimento  : Integer;
    Liquidabile   : Integer;
    Residuo       : Integer;
    AnnoPrec      : Integer;
    OreBO         : Integer;
  end;

  TPresenzeAnnue = record
    FascePresenza       : Array of TFasciaPresenza;
    TotaliPresenza      : TTotPresenza;
    CompensabileAnno    : Integer;
    CompensabileAnnoEff : Integer;
    CompensabileMeseEff : Integer;
    RecuperoAnno        : Integer;
  end;

  TContrattoPartTime = record
    CodContratto: String;
    DescContratto: String;
    CodPartTime: String;
    DescPartTime: String;
  end;

  TDaLiquidare = record
    Maggiorazione,Liquidato:Integer;
    CodFascia:String;
  end;

  TTotali = record
    TotLiqNelMese: LongInt;
    TotAss1: LongInt;
    TotAss2: LongInt;
    TotStrEcc: LongInt;
    TotStrMes: LongInt;
    TotStrLiq: LongInt;
    TotStrAut: LongInt;
    TotStrAnn: LongInt;
  end;

  TVariazioniRiepPres = record
    Compensabile,CompensabileEff:Integer;
    Liquidato:array[1..Maxfasce] of Integer;
  end;

  TA029VisualizzaDatiCalcolatiProcedure = procedure(totali: TTotali) of object;
  TA029Procedure = procedure of object;
  TA029ImpostaSE = procedure (SE: Integer) of object;
  TA029ImpostaContratto = procedure (ContrPartTime: TContrattoPartTime; EsisteContratto:Boolean) of object;

  TA029FSchedaRiepilMW = class(TR005FDataModuleMW)
    selT071: TOracleDataSet;
    selT071PROGRESSIVO: TFloatField;
    selT071DATA: TDateTimeField;
    selT071MAGGIORAZIONE: TFloatField;
    selT071CODFASCIA: TStringField;
    selT071ORELAVORATE: TStringField;
    selT071ORE1ASSEST: TStringField;
    selT071ORE2ASSEST: TStringField;
    selT071OREINDTURNO: TStringField;
    selT071OREECCEDGIORN: TStringField;
    selT071ORESTRAORDLIQ: TStringField;
    selT071LIQUIDNELMESE: TStringField;
    selT071Totale: TStringField;
    selT071D_Fascia: TStringField;
    selT071StrMese: TStringField;
    selT071StrAnnoAut: TStringField;
    selT071StrAnnoLiq: TStringField;
    selT071StrDaLiq: TStringField;
    dsrT071: TDataSource;
    selT074: TOracleDataSet;
    dsrT074: TDataSource;
    selT073Comp: TOracleDataSet;
    selT073CompCAUSALE: TStringField;
    selT073CompCOMPENSABILE: TStringField;
    selT073CompGETTONE_RESIDUO: TStringField;
    dsrT073Comp: TDataSource;
    selT074Liq: TOracleDataSet;
    selT074LiqCAUSALE: TStringField;
    selT074LiqFASCIA: TStringField;
    selT074LiqCODFASCIA: TStringField;
    selT074LiqMAGGIORAZIONE: TFloatField;
    selT074LiqLIQUIDATO: TStringField;
    dsrT074Liq: TDataSource;
    InsT074: TOracleQuery;
    InsT073: TOracleQuery;
    UpdT073: TOracleQuery;
    updT074: TOracleQuery;
    OperSQL: TOracleQuery;
    DelT073: TOracleQuery;
    selT275: TOracleDataSet;
    dsrT072: TDataSource;
    selT072: TOracleDataSet;
    selT072PROGRESSIVO: TFloatField;
    selT072DATA: TDateTimeField;
    selT072CODINDPRES: TStringField;
    selT072D_IndPres: TStringField;
    selT072INDPRES: TStringField;
    selT072INDSUPP_RESTO: TStringField;
    selT162: TOracleDataSet;
    QLook75: TOracleDataSet;
    dsrT075: TDataSource;
    selT075: TOracleDataSet;
    selT075PROGRESSIVO: TFloatField;
    selT075DATA: TDateTimeField;
    selT075CENTROCOSTO: TStringField;
    selT075C_CentroCosto: TStringField;
    selT075D_CentroCosto: TStringField;
    selT075ORESTRAORD: TStringField;
    selT276: TOracleDataSet;
    selT076: TOracleDataSet;
    selT076PROGRESSIVO: TFloatField;
    selT076DATA: TDateTimeField;
    selT076VOCEPAGHE: TStringField;
    selT076Causale: TStringField;
    selT076ORE: TStringField;
    dsrT076: TDataSource;
    selT077: TOracleDataSet;
    selT077PROGRESSIVO: TIntegerField;
    DateTimeField1: TDateTimeField;
    selT077DATO: TStringField;
    selT077DESCRIZIONE: TStringField;
    selT077VALORE_AUT: TStringField;
    selT077VALORE_MAN: TStringField;
    dsrT077: TDataSource;
    selT200: TOracleDataSet;
    dsrT200: TDataSource;
    selT201: TOracleDataSet;
    selT065: TOracleDataSet;
    dsrT305: TDataSource;
    selT305: TOracleDataSet;
    selUsrT072: TOracleDataSet;
    Prova: TOracleDataSet;
    selT072TIPO_RECORD: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT071BeforeDelete(DataSet: TDataSet);
    procedure selT071BeforeInsert(DataSet: TDataSet);
    procedure selT071ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure selT071CalcFields(DataSet: TDataSet);
    procedure selT074AfterPost(DataSet: TDataSet);
    procedure selT074ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure selT074CalcFields(DataSet: TDataSet);
    procedure selT074AfterScroll(DataSet: TDataSet);
    procedure dsrT074StateChange(Sender: TObject);
    procedure selT073CompAfterPost(DataSet: TDataSet);
    procedure selT074LiqAfterPost(DataSet: TDataSet);
    procedure selT074LiqBeforeInsert(DataSet: TDataSet);
    procedure selT275FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure BDEQ070DEBITOORARIOValidate(Sender: TField);
    procedure selT076OREValidate(Sender: TField);
    procedure selT072NewRecord(DataSet: TDataSet);
    procedure selT072CODINDPRESValidate(Sender: TField);
    procedure selT072INDPRESValidate(Sender: TField);
    procedure selT075AfterCancel(DataSet: TDataSet);
    procedure selT075AfterPost(DataSet: TDataSet);
    procedure selT075NewRecord(DataSet: TDataSet);
    procedure selT076NewRecord(DataSet: TDataSet);
    procedure selT077BeforeDelete(DataSet: TDataSet);
    procedure selT077BeforeInsert(DataSet: TDataSet);
    procedure selT077CalcFields(DataSet: TDataSet);
    procedure selT074BeforeDelete(DataSet: TDataSet);
    procedure selT072BeforePost(DataSet: TDataSet);
    procedure selT072BeforeDelete(DataSet: TDataSet);
    procedure selT072BeforeEdit(DataSet: TDataSet);
  private
    FselT070_Funzioni: TOracleDataSet;
    FVisualizzaDatiCalcolati: TA029VisualizzaDatiCalcolatiProcedure;
    FAggiornaDettaglioCausalePresenza : TA029Procedure;
    FCaricaComboCausaliPresenza : TA029Procedure;
    FImpostaStraordinarioEsterno : TA029ImpostaSE;
    FImpostaContrattoEPartTime : TA029ImpostaContratto;
    FApplyUpdatesT075: Boolean;
    DaLiquidare:Array[1..MaxFasce] of TDaLiquidare;
    InserimentoFasce: Boolean;
    CausLiqEsterneOld:Integer;
    RegistraLogT071,RegistraLogT072,RegistraLogT073,RegistraLogT074,RegistraLogT077:TRegistraLog;
    VariazioniRiepPres:TVariazioniRiepPres;
    procedure CaricaL07;
    procedure selT074CAUSALEValidate(Sender: TField);
    procedure T074Validate(Sender: TField);
    procedure SetQLook75(D: String);
    function EsisteContratto(CodContratto: String): Boolean;
    function GetContrattoEPartTime: TContrattoPartTime;
    procedure RegistraLogFigli(ODS: TOracleDataSet; RL: TRegistraLog);
  public
    LiquidBloccata,
    LiquidCompBloccata,
    BloccoT071S,
    BloccoT070,
    BloccoT071A,
    BloccoT074:Boolean;
    PresenzaLiquidataSuccessiva:Boolean;
    TipoOreCausalizzate:TTipoOreCausalizzate;
    TotaliCalcolati: TTotali;
    Budget:Boolean;
    DataInserimento:TDateTime;
    NDaLiquidare:Byte;
    A029FLiquidazione: TA029FLiquidazione;
    R450DtM1:TR450DtM1;
    selDatiBloccati:TDatiBloccati;
    function OpenDettaglioGG: Boolean;
    procedure LiquidazioneAutomatica(UsaGestioneBudget: Boolean;OreLiq :Integer; ImpLiq: Real);
    function ParametriConteggio: String;
    procedure AttivaLiquidazione(CodiceCausPresenza: String);
    procedure selT073CompBeforePost(CodiceCausPresenza: String);
    function ControllaLiquidato(var DialogConferma: Boolean): String;
    function selT074LiqBeforePost(CodiceCausPresenza: String; var DialogConferma: boolean): String;
    function CalcolaBancaOreLiquidata: Integer;
    function CalcolaCompLiquidato: Integer;
    function CalcolaTotAss: Integer;
    function VerificaDispLiquidità: String;
    function TotaliPresenza(CodiceCausPresenza: String; Aggiorna: Boolean;OreEsclCompMese: String): TPresenzeAnnue;
    function GetPosFascia(C: String; M: Integer): Integer;
    procedure dsrT071DataChange(Sender: TObject; Field: TField);
    procedure ImpostaLiquidazione;
    procedure ControllaStraordinarioLiquidato(var Cambiato: Boolean;var OreLiq: Integer; var ImpLiq: real; var MaxLiquidato: Integer);
    procedure PostDataSetFigli;
    procedure ApplicaModifiche;
    procedure selT070AfterCancel;
    function selT070AfterInsert: Boolean;
    procedure selT070Edit;
    procedure selT070NewRecord;
    procedure selT070BeforeDelete;
    procedure selT070BeforeInsert;
    procedure selT070BeforePost(SettaProprietaLog: Boolean);
    procedure selT070AfterScroll;
    procedure selT070AfterDelete;
    function x022_StrAutAnn: Boolean;
    procedure GetStraordinarioEsterno(Ricalcola: Boolean);
    procedure ImpostaDataset;
    procedure FascePresenza;
    procedure CalcolaDati;
    procedure ImpostaLiquidazioneEBancaOre(BancaOreLiquidata: Integer);
    function BancaOreVariazioneLiqVisibile: Boolean;
    function CambioCausPresenza(CodiceCausPresenza: String): String;
    function CaptionOreIncluseEscluse(OreNormali: String): String;
    function LiquidazioneAttiva(CodiceCausPresenza: String): Boolean;
    property selT070_Funzioni: TOracleDataSet read FselT070_Funzioni write FselT070_Funzioni;
    property VisualizzaDatiCalcolati: TA029VisualizzaDatiCalcolatiProcedure read FVisualizzaDatiCalcolati write FVisualizzaDatiCalcolati ;
    property AggiornaDettaglioCausalePresenza: TA029Procedure read FAggiornaDettaglioCausalePresenza write FAggiornaDettaglioCausalePresenza ;
    property ImpostaStraordinarioEsterno: TA029ImpostaSE read FImpostaStraordinarioEsterno write FImpostaStraordinarioEsterno ;
    property ImpostaContrattoEPartTime: TA029ImpostaContratto read FImpostaContrattoEPartTime write FImpostaContrattoEPartTime;
    property CaricaComboCausaliPresenza: TA029Procedure read FCaricaComboCausaliPresenza write FCaricaComboCausaliPresenza ;
    property ApplyUpdatesT075: Boolean read FApplyUpdatesT075 write FApplyUpdatesT075;
  end;

implementation

{$R *.dfm}

{ TA029FSchedaRiepilMW }
procedure TA029FSchedaRiepilMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  R450DtM1:=TR450Dtm1.Create(Self);
  A029FLiquidazione:=TA029FLiquidazione.Create(nil);
  A029FLiquidazione.A029FBudgetDtM1.R450DtM:=R450DtM1;
  A029FLiquidazione.R450DtM:=R450DtM1;
  FApplyUpdatesT075:=True;
  InserimentoFasce:=False;
  selT201.Sql.Text:=FasceOracle;
  selT162.Open;
  selT275.Open;
  selT276.Open;
  selT200.Open;
  selT305.Open;
  SetQLook75(Parametri.CampiRiferimento.C2_Budget);
  selT075.FieldByName('C_CentroCosto').DisplayLabel:=Parametri.CampiRiferimento.C2_Budget;

  selDatiBloccati:=TDatiBloccati.Create(nil);
  selDatiBloccati.TipoLog:='M';
  Budget:=Parametri.CampiRiferimento.C2_Facoltativo <> '';

  //Registrazione log
  RegistraLogT071:=TRegistraLog.Create(nil);
  RegistraLogt071.Session:=SessioneOracle;
  RegistraLogT072:=TRegistraLog.Create(nil);
  RegistraLogt072.Session:=SessioneOracle;
  RegistraLogT073:=TRegistraLog.Create(nil);
  RegistraLogt073.Session:=SessioneOracle;
  RegistraLogT074:=TRegistraLog.Create(nil);
  RegistraLogt074.Session:=SessioneOracle;
  RegistraLogT077:=TRegistraLog.Create(nil);
  RegistraLogt077.Session:=SessioneOracle;
end;

//usare solo win perchè su web reimposta dataset in browse
procedure TA029FSchedaRiepilMW.dsrT071DataChange(Sender: TObject; Field: TField);
{Impostazione tabelle dei conteggi dai dati in fasce correnti per il
calcolo in Real-Time}
var i:Byte;
begin
  inherited;
  if Field = nil then
    exit;
  if selT071.State = dsBrowse then
    exit;
  if (Field.Calculated) or (Field.Lookup) then
    exit;
  i:=GetPosFascia(selT071CodFascia.AsString,selT071Maggiorazione.AsInteger);
  //OreLavorate
  if Field = selT071OreLavorate then
    R450DtM1.L07.tminlavmese[i]:=R180OreMinutiExt(Field.AsString)
  else if Field = selT071Ore1Assest then
  //Ore Assestamento 1
    R450DtM1.L07.tdatiassestamento[1].tminassest[i]:=R180OreMinutiExt(Field.AsString)
  else if Field = selT071Ore2Assest then
  //Ore Assestamento 2
    R450DtM1.L07.tdatiassestamento[2].tminassest[i]:=R180OreMinutiExt(Field.AsString)
  else if Field = selT071OreEccedGiorn then
  //Ore Eccedenze giornaliere
    R450DtM1.L07.tminstrmens[i]:=R180OreMinutiExt(Field.AsString)
  else if (R450DtM1.LiquidazioneDistribuita = 'S') and (Field = selT071LiquidNelMese) then
  //Ore Sraordinario liquidabile
    R450DtM1.L07.tLiqNelMese[i]:=R180OreMinutiExt(Field.AsString);
  CalcolaDati;
end;

procedure TA029FSchedaRiepilMW.dsrT074StateChange(Sender: TObject);
{Il codice causale non è modificabile}
begin
  selT074.FieldByName('Causale').ReadOnly:=selT074.State <> dsInsert;
end;

procedure TA029FSchedaRiepilMW.CaricaL07;
var i,j,iRPC,xx:Integer;
    B1,B2:TBookmark;
begin
  //Lettura dati del mese in elaborazione
  with FSelT070_Funzioni do
  //Lettura scheda riepilogativa di un mese
  begin
    R450DtM1.L07.debormes:=R180OreMinutiExt(FieldByName('DebitoOrario').AsString);
    R450DtM1.L07.debpomes:=R180OreMinutiExt(FieldByName('DebitoPo').AsString);
    R450DtM1.L07.poflag:=R180CarattereDef(FieldByName('TipoPo').AsString,1,#0);
    R450DtM1.L07.tdatiassestamento[1].tcauassest:=FieldByName('Causale1MinAss').AsString;
    R450DtM1.L07.tdatiassestamento[2].tcauassest:=FieldByName('Causale2MinAss').AsString;
    R450DtM1.L07.eccsolocompmes:=R180OreMinutiExt(FieldByName('OreEccedComp').AsString);
    R450DtM1.L07.EccSoloCompMesOltreSoglia:=R180OreMinutiExt(FieldByName('OreEccedCompOltreSoglia').AsString);
    R450DtM1.L07.vareccliqmes:=R180OreMinutiExt(FieldByName('OreVariazEcc').AsString);
    R450DtM1.L07.scostnegmes:=R180OreMinutiExt(FieldByName('ScostNeg').AsString);
    R450DtM1.L07.ripcommes:=R180OreMinutiExt(FieldByName('RipCom').AsString);
    R450DtM1.L07.abbripcommes:=R180OreMinutiExt(FieldByName('AbbRipCom').AsString);
    (*RecAnnoCorr*)R450DtM1.L07.abbannoattmes:=R180OreMinutiExt(FieldByName('RecAnnoCorr').AsString);
    (*RecAnnoPrec*)R450DtM1.L07.abbannoprecmes:=R180OreMinutiExt(FieldByName('RecAnnoPrec').AsString);
    R450DtM1.L07.abbliqannoattmes:=R180OreMinutiExt(FieldByName('RecLiqCorr').AsString);
    R450DtM1.L07.abbliqannoprecmes:=R180OreMinutiExt(FieldByName('RecLiqPrec').AsString);
    R450DtM1.L07.OreCompLiquidate:=R180OreMinutiExt(FieldByName('OreComp_Liquidate').AsString) + R180OreMinutiExt(FieldByName('BancaOre_Liq_Var').AsString);
    R450DtM1.L07.BancaOreLiqVar:=R180OreMinutiExt(FieldByName('BancaOre_Liq_Var').AsString);
    R450DtM1.L07.OreCompRecuperate:=R180OreMinutiExt(FieldByName('OreComp_Recuperate').AsString);
    R450DtM1.L07.RiposiNonFruitiOre:=FieldByName('RiposiNonFruitiOre').AsString;
    R450DtM1.L07.NFasce:=selT071.RecordCount;
  end;
  if (selT071.State = dsEdit) or selT071.UpdatesPending then
    exit;
  //Lettura dati in fasce
  with R450DtM1 do
  begin
    //Azzeramento tabelle prima del caricamento
    for xx:=1 to MaxFasce do
    begin
      L07.tmaggioraz[xx]:=0;
      L07.tfasce[xx]:='';
      L07.tminlavmese[xx]:=0;
      L07.tdatiassestamento[1].tminassest[xx]:=0;
      L07.tdatiassestamento[2].tminassest[xx]:=0;
      L07.tminstrmens[xx]:=0;
      tstrannom[xx]:=0;
      L07.tstrliquidatomm[xx]:=0;
    end;
    salmeseatt:=0;
    NFasceMese:=0;
  end;
  with selT071 do
  begin
    OnCalcFields:=nil;
    DisableControls;
    i:=1;
    First;
    R450DtM1.NFasceMese:=0;
    while not Eof do
    begin
      R450DtM1.L07.tfasce[i]:=FieldByName('CodFascia').AsString;
      R450DtM1.L07.tmaggioraz[i]:=FieldByName('Maggiorazione').AsInteger;
      R450DtM1.L07.tminlavmese[i]:=R180OreMinutiExt(FieldByName('OreLavorate').AsString);
      R450DtM1.L07.tdatiassestamento[1].tminassest[i]:=R180OreMinutiExt(FieldByName('Ore1Assest').AsString);
      R450DtM1.L07.tdatiassestamento[2].tminassest[i]:=R180OreMinutiExt(FieldByName('Ore2Assest').AsString);
      R450DtM1.L07.tminstrmens[i]:=R180OreMinutiExt(FieldByName('OreEccedGiorn').AsString);
      R450DtM1.L07.tstrliquidatomm[i]:=R180OreMinutiExt(FieldByName('OreStraordLiq').AsString);
      R450DtM1.L07.tLiqNelMese[i]:=R180OreMinutiExt(FieldByName('LiquidNelMese').AsString);
      inc(i);
      Next;
    end;
    First;
    OnCalcFields:=selT071CalcFields;
    EnableControls;
    R450DtM1.L07.NFasce:=i - 1;
    R450DtM1.NFasceMese:=i - 1;
  end;
  //Caricamento riepilogo delle presenze in RiepPresCartellino
  R450DtM1.RiepPresCartellino:=nil;
  with selT074 do
  begin
    AfterScroll:=nil;
    DisableControls;
    B1:=GetBookmark;
    selT073Comp.DisableControls;
    selT073Comp.Filtered:=False;
    B2:=selT074Liq.GetBookmark;
	  try { DONE : TEST IW 15 }
      selT074Liq.Filtered:=False;
      First;
      while not Eof do
      begin
        SetLength(R450DtM1.RiepPresCartellino,Length(R450DtM1.RiepPresCartellino) + 1);
        iRPC:=High(R450DtM1.RiepPresCartellino);
        R450DtM1.RiepPresCartellino[iRPC].Causale:=FieldByName('CAUSALE').AsString;
        for xx:=1 to MaxFasce do
          R450DtM1.RiepPresCartellino[iRPC].Liquidato[xx]:=0;
        for xx:=1 to MaxFasce do
          R450DtM1.RiepPresCartellino[iRPC].OreRese[xx]:=0;
        R450DtM1.RiepPresCartellino[iRPC].Compensabile:=0;
        //Ore rese
        j:=0;
        for i:=0 to FieldDefs.Count - 1 do
        begin
          if Copy(UpperCase(FieldDefs[i].Name),1,11) = 'OREPRESENZA' then
          begin
            inc(j);
            R450DtM1.RiepPresCartellino[iRPC].OreRese[j]:=R180OreMinutiExt(FieldByName(FieldDefs[i].Name).AsString);
          end;
        end;
        //Ore compensabili registrate
        R450DtM1.RiepPresCartellino[iRPC].Compensabile:=R180OreMinutiExt(VarToStr(selT073Comp.Lookup('CAUSALE',FieldByName('CAUSALE').AsString,'COMPENSABILE')));
        //A029FSchedaRiepil.VariazioniRiepPres.Compensabile:=R450DtM1.RiepPresCartellino[iRPC].Compensabile;
        //Ore liquidate
        j:=0;
        if selT074Liq.SearchRecord('CAUSALE',FieldByName('CAUSALE').AsString,[srFromBeginning]) then
          repeat
            inc(j);
            R450DtM1.RiepPresCartellino[iRPC].Liquidato[j]:=R180OreMinutiExt(selT074Liq.FieldByName('LIQUIDATO').AsString);
            //A029FSchedaRiepil.VariazioniRiepPres.Liquidato[j]:=R180OreMinutiExt(sel074Liq.FieldByName('LIQUIDATO').AsString);
          until not selT074Liq.SearchRecord('CAUSALE',FieldByName('CAUSALE').AsString,[srForward]);
        Next;
      end;
      selT073Comp.Filtered:=True;
      selT073Comp.EnableControls;
      //sel074Liq.GotoBookmark(B2); // spostato dopo il filtered (altrimenti non funziona)
      selT074Liq.Filtered:=True;
      if selT074Liq.BookmarkValid(B2) then
        selT074Liq.GotoBookmark(B2);
      if BookmarkValid(B1) then
        GotoBookMark(B1);
      EnableControls;
	  finally
      FreeBookmark(B1);
      selT074Liq.FreeBookmark(B2);
	  end;
    AfterScroll:=selT074AfterScroll;
  end;
end;

procedure TA029FSchedaRiepilMW.selT073CompAfterPost(DataSet: TDataSet);
{Ricalcolo situazione da inizio anno e totali}
begin
  CalcolaDati;
end;

procedure TA029FSchedaRiepilMW.selT074LiqAfterPost(DataSet: TDataSet);
{Ricalcolo situazione da inizio anno e totali}
begin
  CalcolaDati;
end;

procedure TA029FSchedaRiepilMW.selT074LiqBeforeInsert(DataSet: TDataSet);
{Non è permesso inserire o cancellare direttamente sulla griglia}
begin
  Abort;
end;

procedure TA029FSchedaRiepilMW.selT075AfterCancel(DataSet: TDataSet);
begin
  selT075.CancelUpdates;
end;

procedure TA029FSchedaRiepilMW.selT075AfterPost(DataSet: TDataSet);
begin
  inherited;
  if FApplyUpdatesT075 then
  begin
    SessioneOracle.ApplyUpdates([selT075],True);
    SessioneOracle.Commit;
  end;
  GetStraordinarioEsterno(True);
end;

procedure TA029FSchedaRiepilMW.selT075NewRecord(DataSet: TDataSet);
begin
  selT075.FieldByName('Progressivo').AsInteger:= FselT070_Funzioni.FieldByName('Progressivo').AsInteger;
  selT075.FieldByName('Data').AsDateTime:=FselT070_Funzioni.FieldByName('Data').AsDateTime;
end;

procedure TA029FSchedaRiepilMW.selT076NewRecord(DataSet: TDataSet);
begin
  selT076.FieldByName('Progressivo').AsInteger:=FselT070_Funzioni.FieldByName('Progressivo').AsInteger;
  selT076.FieldByName('Data').AsDateTime:=FselT070_Funzioni.FieldByName('Data').AsDateTime;
end;

procedure TA029FSchedaRiepilMW.selT076OREValidate(Sender: TField);
var P:Word;
begin
  if Sender.IsNull then
    exit;
  P:=Pos('.',Sender.AsString);
  if P = 0 then
    P:=Pos(',',Sender.AsString);
  if P > 0 then
  begin
    if Pos(' ',Copy(Sender.AsString,P - 2,P + 2)) > 0 then
      raise Exception.Create(A000MSG_ERR_DATO_SPAZI);
    if StrToInt(Copy(Sender.AsString,P + 1,2)) > 59 then
      raise Exception.Create(A000MSG_ERR_MINUTI);
  end;
end;

procedure TA029FSchedaRiepilMW.selT077BeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA029FSchedaRiepilMW.selT077BeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA029FSchedaRiepilMW.selT077CalcFields(DataSet: TDataSet);
begin
  (*
  DataSet.FieldByName('C_DATO').AsString:=DataSet.FieldByName('DATO').AsString;
  if DataSet.FieldByName('DATO').AsString = 'RIENTRIPOM_TEORICI' then
    DataSet.FieldByName('C_DATO').AsString:='Rientri pom. teorici dovuti'
  else if DataSet.FieldByName('DATO').AsString = 'RIENTRIPOM_REALI' then
    DataSet.FieldByName('C_DATO').AsString:='Rientri pom. reali dovuti'
  else if DataSet.FieldByName('DATO').AsString = 'RIENTRIPOM_OBBL' then
    DataSet.FieldByName('C_DATO').AsString:='Rientri pom. obbl.'
  else if DataSet.FieldByName('DATO').AsString = 'RIENTRIPOM_SUPPL' then
    DataSet.FieldByName('C_DATO').AsString:='Rientri pom. suppl.'
  else if DataSet.FieldByName('DATO').AsString = 'RIENTRIPOM_SALDO' then
    DataSet.FieldByName('C_DATO').AsString:='Saldo rientri pom.';
  *)
end;

procedure TA029FSchedaRiepilMW.selT275FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA029FSchedaRiepilMW.selT071ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
  var Liquidato:Integer;
begin
  inherited;
  Applied:=False;

  //Se ho modificato lo straord. liq. nel mese, liquido quella fascia
  if Action in ['I','U'] then
  begin
    Liquidato:=R180OreMinutiExt(VarToStr(selT071LiquidNelMese.Value)) -
               R180OreMinutiExt(VarToStr(selT071LiquidNelMese.OldValue));
    if Liquidato <> 0 then
    begin
      inc(NDaLiquidare);
      DaLiquidare[NDaLiquidare].Liquidato:=Liquidato;
      DaLiquidare[NDaLiquidare].Maggiorazione:=selT071Maggiorazione.OldValue;
      DaLiquidare[NDaLiquidare].CodFascia:=selT071CodFascia.OldValue;
    end;
  end;
end;

procedure TA029FSchedaRiepilMW.selT071BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TA029FSchedaRiepilMW.selT071BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if not InserimentoFasce then
    Abort;
end;

procedure TA029FSchedaRiepilMW.selT071CalcFields(DataSet: TDataSet);
var i:Byte;
begin
  inherited;
  //Posizione della fascia nei vettori calcolati
  i:=GetPosFascia(selT071.FieldByName('CodFascia').AsString,selT071.FieldByName('Maggiorazione').AsInteger);
  selT071.FieldByName('D_Fascia').AsString:=Format('%s (%d%%)',[selT071.FieldByName('CodFascia').AsString,selT071.FieldByName('Maggiorazione').AsInteger]);
  selT071.FieldByName('Totale').AsString:=R180MinutiOre(R180OreMInutiExt(selT071.FieldByName('OreLavorate').AsString) +
                                       R180OreMInutiExt(selT071.FieldByName('Ore1Assest').AsString) +
                                       R180OreMInutiExt(selT071.FieldByName('Ore2Assest').AsString));
  if (i >= Low(R450DtM1.tstrmese)) and (i <= High(R450DtM1.tstrmese)) then
  begin
    selT071.FieldByName('StrMese').AsString:=R180MinutiOre(R450DtM1.tstrmese[i]);
    selT071.FieldByName('StrAnnoAut').AsString:=R180MinutiOre(R450DtM1.tstrannom[i]);
    selT071.FieldByName('StrAnnoLiq').AsString:=R180MinutiOre(R450DtM1.tstrliq[i]);
    selT071.FieldByName('StrDaLiq').AsString:=R180MinutiOre(R450DtM1.tstrannom[i] - R450DtM1.tstrliq[i]);
  end
  else
  begin
    selT071.FieldByName('StrMese').AsString:='00.00';
    selT071.FieldByName('StrAnnoAut').AsString:='00.00';
    selT071.FieldByName('StrAnnoLiq').AsString:='00.00';
    selT071.FieldByName('StrDaLiq').AsString:='00.00';
  end
end;

procedure TA029FSchedaRiepilMW.selT072BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if selT072.FieldByName('Tipo_Record').AsString = 'A' then
    raise exception.Create(A000MSG_A029_ERR_RECORD_AUTOMATICO);
end;

procedure TA029FSchedaRiepilMW.selT072BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if selT072.FieldByName('Tipo_Record').AsString = 'A' then
    raise exception.Create(A000MSG_A029_ERR_RECORD_AUTOMATICO);
end;

procedure TA029FSchedaRiepilMW.selT072BeforePost(DataSet: TDataSet);
begin
  inherited;
  if selT072.FieldByName('Tipo_Record').AsString = 'A' then
    raise exception.Create(A000MSG_A029_ERR_RECORD_AUTOMATICO);

  //StringRaplace ' ' = '' Elimino eventuali spazi all'interno del numero
  //R180RPad inserisco a destra spazi riempitivi per permettere la corretta visualizzazione a video del dato
  selT072.FieldByName('INDSUPP_RESTO').AsString:=R180RPad(StringReplace(selT072.FieldByName('INDSUPP_RESTO').AsString,' ','',[rfReplaceAll]),5,' ');
end;

procedure TA029FSchedaRiepilMW.selT072CODINDPRESValidate(Sender: TField);
{Controllo la validità del codice indennità di presenza}
begin
  if Sender.AsString = '' then
    exit;
  if not selT162.Locate('Codice',Sender.AsString,[]) then
    raise Exception.Create(A000MSG_A029_ERR_INDENNITA);
end;

procedure TA029FSchedaRiepilMW.selT072INDPRESValidate(Sender: TField);
{Controllo parte decimale dell'indennità di presenza e indennità supplementare}
var PosVirgola:Integer;
begin
  if Sender.IsNull then
    exit;
  PosVirgola:=pos(',', Sender.AsString) - 1;
  //Caratto 13/05/2013. su WebPj la virgola può non esserci
  if PosVirgola = -1 then
    exit;
  if (Pos(' ',TrimLeft(Copy(Sender.AsString,1,PosVirgola))) > 0) or
     (Trim(Copy(Sender.AsString,1,PosVirgola)) = '') then
    raise Exception.Create(A000MSG_ERR_DATO_NON_VALIDO);
end;

procedure TA029FSchedaRiepilMW.selT072NewRecord(DataSet: TDataSet);
{Dati di inizializzazione delle indennità di presenza}
begin
  selT072.FieldByName('Tipo_Record').AsString:='M';
  selT072.FieldByName('Progressivo').AsInteger:=FselT070_Funzioni.FieldByName('Progressivo').AsInteger;
  selT072.FieldByName('Data').AsDateTime:=FselT070_Funzioni.FieldByName('Data').AsDateTime;
end;

procedure TA029FSchedaRiepilMW.selT074AfterPost(DataSet: TDataSet);
begin
  inherited;
  CalcolaDati;
end;

procedure TA029FSchedaRiepilMW.selT074AfterScroll(DataSet: TDataSet);
{Aggiornamento della situazione di dettaglio della causale di presenza selezionata}
begin
  if Assigned(FAggiornaDettaglioCausalePresenza) then
    FAggiornaDettaglioCausalePresenza;
end;

procedure TA029FSchedaRiepilMW.selT074ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
{Gestione degli aggiornamenti delle causali di presenza con i relativi dati
in fasce}
var i:byte;
begin
  //Aggiornamento dei dati in fasce
  case Action of
    //Inserimento causali di presenza
    'I':
      begin
        with InsT074 do
        begin
          for i:=0 to selT074.FieldCount - 1 do
            if (selT074.Fields[i].FieldName <> 'CAUSALE') and
               (selT074.Fields[i].FieldName <> 'Totale') and
               (selT074.Fields[i].FieldName <> 'D_Causale') then
            begin
              SetVariable('Progressivo',FselT070_Funzioni.FieldByName('Progressivo').AsInteger);
              SetVariable('Data',FselT070_Funzioni.FieldByName('Data').AsDateTime);
              SetVariable('Causale',selT074.FieldByName('Causale').AsString);
              SetVariable('Maggiorazione',R450DtM1.tmaggioraz[selT074.Fields[i].tag]);
              SetVariable('CodFascia',R450DtM1.tfasce[selT074.Fields[i].tag]);
              if selT074.Fields[i].IsNull then
                selT074.Fields[i].AsString:='00.00';
              SetVariable('OrePresenza',selT074.Fields[i].AsString);
              try
                Execute;
              except
            end;
          end;
        end;

        with InsT073 do
        begin
          SetVariable('Progressivo',FselT070_Funzioni.FieldByName('Progressivo').AsInteger);
          SetVariable('Data',FselT070_Funzioni.FieldByName('Data').AsDateTime);
          SetVariable('Causale',selT074.FieldByName('Causale').AsString);
          Execute;
        end;
      end;
    //Modifica causali di presenza
    'U':
      begin
        with UpdT073 do
        begin
          SetVariable('Progressivo',FselT070_Funzioni.FieldByName('Progressivo').AsInteger);
          SetVariable('Data',FselT070_Funzioni.FieldByName('Data').AsDateTime);
          SetVariable('Causale',selT074.FieldByName('Causale').AsString);
          SetVariable('Old_Causale',selT074.FieldByName('Causale').medpOldValue);
          Execute;
        end;
        with UpdT074 do
        begin
          SetVariable('Progressivo',FselT070_Funzioni.FieldByName('Progressivo').AsInteger);
          SetVariable('Data',FselT070_Funzioni.FieldByName('Data').AsDateTime);
          SetVariable('Causale',selT074.FieldByName('Causale').AsString);
          for i:=0 to selT074.FieldCount - 1 do
          begin
            if UpperCase(Copy(selT074.Fields[i].FieldName,1,11)) = 'OREPRESENZA' then
            begin
              SetVariable('Maggiorazione',R450DtM1.tmaggioraz[selT074.Fields[i].tag]);
              SetVariable('CodFascia',R450DtM1.tfasce[selT074.Fields[i].tag]);
              if selT074.Fields[i].IsNull then
                selT074.Fields[i].AsString:='00.00';
              SetVariable('OrePresenza',selT074.Fields[i].AsString);
              try
                Execute;
              except
              end;
            end;
          end;
        end;
      end;
    //Cancellazione causali di presenza
    'D':
      begin
        with OperSql do
        begin
          SQL.Clear;
          SQL.Add(Format('DELETE FROM T074_CausPresFasce WHERE Progressivo = %d AND Data = ''%s'' AND Causale = ''%s''',
                 [FselT070_Funzioni.FieldByName('Progressivo').AsInteger,FormatDateTime('dd/mm/yyyy',FselT070_Funzioni.FieldByName('Data').AsDateTime),VarToStr(selT074.FieldByName('Causale').medpOldValue)]));
          Execute;
        end;
        with DelT073 do
        begin
          SetVariable('Progressivo',FselT070_Funzioni.FieldByName('Progressivo').AsInteger);
          SetVariable('Data',FselT070_Funzioni.FieldByName('Data').AsDateTime);
          SetVariable('Causale',selT074.FieldByName('Causale').medpOldValue);
          Execute;
        end;
      end;
  end;
  Applied:=True;
end;


procedure TA029FSchedaRiepilMW.selT074BeforeDelete(DataSet: TDataSet);
var
  PresenzeAnnue : TPresenzeAnnue;
begin
  inherited;
  //devo reperire i dati di totali per il record che sto cercando di eliminare e non
  //quelli già calcolati che potrebbero essere relativi a un altro codice
  PresenzeAnnue:=TotaliPresenza(selT074.FieldByName('CAUSALE').AsString,False,'');

  if (PresenzeAnnue.TotaliPresenza.LiquidatoMese <> 0) or
     (R180OreMinutiExt(selT073Comp.FieldByName('Compensabile').AsString) <> 0) then
    raise Exception.Create(A000MSG_A029_ERR_DELETE_LIQUID);
end;

procedure TA029FSchedaRiepilMW.selT074CalcFields(DataSet: TDataSet);
{Calcolo il totale ore per Causale di presenza}
var
  Totale:LongInt;
  i:Byte;
begin
  Totale:=0;
  for i:=0 to selT074.FieldCount - 1 do
  begin
    if (selT074.Fields[i].FieldName <> 'CAUSALE') and
       (selT074.Fields[i].FieldName <> 'Totale') and
       (selT074.Fields[i].FieldName <> 'D_Causale') then
    begin
      Totale:=Totale + R180OreMinutiExt(selT074.Fields[i].AsString);
    end;
  end;
  selT074.FieldByName('Totale').AsString:=R180MinutiOre(Totale);
end;

function TA029FSchedaRiepilMW.GetPosFascia(C:String; M:Integer):Integer;
var i:Integer;
begin
  Result:=0;
  for i:=1 to R450DtM1.L07.NFasce do
  begin
    if (C = R450DtM1.L07.tfasce[i]) and
       (M = R450DtM1.L07.tmaggioraz[i]) then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

procedure TA029FSchedaRiepilMW.ImpostaDataset;
var
  i: Integer;
begin
  for i:=0 to FselT070_Funzioni.Fields.Count - 1 do
    if FselT070_Funzioni.Fields[i].FieldKind = fkData then
      FselT070_Funzioni.Fields[i].ReadOnly:=BloccoT070;
  for i:=0 to selT071.Fields.Count - 1 do
    if selT071.Fields[i].FieldKind = fkData then
      selT071.Fields[i].ReadOnly:=BloccoT070;
  //Blocco ore di assestamento
  FselT070_Funzioni.FieldByName('Causale1MinAss').ReadOnly:=BloccoT071A;
  FselT070_Funzioni.FieldByName('Causale2MinAss').ReadOnly:=BloccoT071A;
  selT071Ore1Assest.ReadOnly:=BloccoT071A;
  selT071Ore2Assest.ReadOnly:=BloccoT071A;
  //Blocco liquidazione straordinario
  selT071OreStraordLiq.ReadOnly:=BloccoT071S;
  selT071LiquidNelMese.ReadOnly:=BloccoT071S;
  (* Caratto . Fatto in visualizzadati
  Data:=Q070.FieldByName('Data').AsDateTime;
  DecodeDate(Data,A,M,G);
  if Data <> 0 then
    A029FSchedaRiepil.LData.Caption:=FormatDateTime('mmmm yyyy',Data)
  else
    A029FSchedaRiepil.LData.Caption:='';
  *)
  with selT071 do
  begin
    DisableControls;
    Close;
    OnCalcFields:=nil;
    SetVariable('PROGRESSIVO',FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA',FselT070_Funzioni.FieldByName('DATA').AsDateTime);
    Open;
    OnCalcFields:=selT071CalcFields;
    EnableControls;
  end;
  with selT072 do
  begin
    DisableControls;
    Close;
    SetVariable('PROGRESSIVO',FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA',FselT070_Funzioni.FieldByName('DATA').AsDateTime);
    Open;
    EnableControls;
  end;
  with selT075 do
  begin
    Close;
    SetVariable('PROGRESSIVO',FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA',FselT070_Funzioni.FieldByName('DATA').AsDateTime);
    Open;
  end;
  with selT076 do
  begin
    DisableControls;
    Close;
    SetVariable('PROGRESSIVO',FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA',FselT070_Funzioni.FieldByName('DATA').AsDateTime);
    Open;
    EnableControls;
  end;
  with selT077 do
  begin
    DisableControls;
    Close;
    SetVariable('PROGRESSIVO',FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA',FselT070_Funzioni.FieldByName('DATA').AsDateTime);
    Open;
    EnableControls;
  end;
  with selT073Comp do
  begin
    DisableControls;
    Close;
    SetVariable('PROGRESSIVO',FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA',FselT070_Funzioni.FieldByName('DATA').AsDateTime);
    Filtered:=False;
    Open;
    EnableControls;
  end;
  with selT074Liq do
  begin
    DisableControls;
    Close;
    SetVariable('PROGRESSIVO',FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA',FselT070_Funzioni.FieldByName('DATA').AsDateTime);
    Filtered:=False;
    Open;
    EnableControls;
  end;
end;

procedure TA029FSchedaRiepilMW.ImpostaLiquidazioneEBancaOre(BancaOreLiquidata: Integer);
var Data: TDateTime;
  i:Integer;
begin
  Data:=FselT070_Funzioni.FieldByName('Data').AsDateTime;
  FselT070_Funzioni.CachedUpdates:=False;
  selT071.CachedUpdates:=False;
  selT072.CachedUpdates:=False;
  selT074.CachedUpdates:=False;
  selT071.ReadOnly:=True;
  selT072.ReadOnly:=True;
  selT074.ReadOnly:=True;
  selT075.ReadOnly:=True;
  selT076.ReadOnly:=True;
  selT077.ReadOnly:=True;
  selT074Liq.ReadOnly:=True;
  selT073Comp.ReadOnly:=True;
  //Liquidazione/Storno straordinario
  if NDaLiquidare > 0 then
    ImpostaLiquidazione;
  for i:=1 to NDaLiquidare do
  begin
    A029FLiquidazione.Liquidazione(False,Data,FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,DaLiquidare[i].Maggiorazione,DaLiquidare[i].Liquidato,DaLiquidare[i].CodFascia);
    //SessioneOracle.Commit;
  end;
  if BancaOreLiquidata <> 0 then
    A029FLiquidazione.AggiornaResiduiBancaOre(FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,R180Anno(Data),BancaOreLiquidata);
  SessioneOracle.Commit;
  FselT070_Funzioni.CachedUpdates:=True;
  (*
  FselT070_Funzioni.Close;
  FselT070_Funzioni.Open;
  FselT070_Funzioni.Locate('Data',Data,[]);
  *)
  selT071.FieldByName('LIQUIDNELMESE').ReadOnly:=False;
end;

function TA029FSchedaRiepilMW.LiquidazioneAttiva(CodiceCausPresenza: String): Boolean;
begin
  Result:=(FselT070_Funzioni.State = dsBrowse) and
          (CodiceCausPresenza <> '') and
          (TipoOreCausalizzate in [tocEscluse,tocIncluse]) and
          (not BloccoT074) and
          (selT074.Lookup('Causale',CodiceCausPresenza,'Causale') = null);
end;

procedure TA029FSchedaRiepilMW.AttivaLiquidazione(CodiceCausPresenza: String);
begin
  with selT074 do
  begin
    CachedUpdates:=True;
    ReadOnly:=False;
    //Caratto 29/05/2013 inibisco evento scroll perchè in webPJ riporterebbe il dataset in browse
    AfterScroll:=nil;
    Append;
    FieldByName('Causale').AsString:=CodiceCausPresenza;
    Post;
    SessioneOracle.ApplyUpdates([selT074],True);
    AfterScroll:=selT074AfterScroll;
    ReadOnly:=True;
    CachedUpdates:=False;
    selT074Liq.DisableControls;
    selT074Liq.Refresh;
    selT073Comp.DisableControls;
    selT073Comp.Refresh;
    //Caratto 30/05/2013 Su applyrecord setta i campi a 00.00 ma la griglia
    //fasce presenza in win visualizza ancora i campi a null. forzato refresh
    Refresh;
    Locate('Causale',CodiceCausPresenza,[]);
    selT074Liq.EnableControls;
    selT073Comp.EnableControls;
  end;
end;

function TA029FSchedaRiepilMW.BancaOreVariazioneLiqVisibile: Boolean;
begin
  Result:=selT065.Active and (selT065.RecordCount > 0);
end;

procedure TA029FSchedaRiepilMW.BDEQ070DEBITOORARIOValidate(Sender: TField);
{Controllo che i minuti siano minori di 60}
var Minuti,Posiz:Byte;
begin
  if Sender.IsNull then
    exit;
  //Controllo minuti di assestamento 1
  if Sender = selT071Ore1Assest then
  begin
    //Caratto fatto controllo su campo if (A029FSchedaRiepil.DbLookupComboBox1.Text = '') and
    if (FselT070_Funzioni.FieldByName('CAUSALE1MINASS').AsString = '') and
       (R180OreMinutiExt(selT071Ore1Assest.AsString) <> 0) then
      raise Exception.Create(A000MSG_A029_ERR_CAUS_ASSESTAMENTO);
  end;
  //Controllo minuti di assestamento 2
  if Sender = selT071Ore2Assest then
  begin
    //Caratto. fatto controllo su campo  if (A029FSchedaRiepil.DbLookupComboBox2.Text = '') and
    if (FselT070_Funzioni.FieldByName('CAUSALE2MINASS').AsString = '') and
       (R180OreMinutiExt(selT071Ore2Assest.AsString) <> 0) then
      raise Exception.Create(A000MSG_A029_ERR_CAUS_ASSESTAMENTO);
  end;
  if Pos(' ',Trim(Sender.AsString)) > 1 then
    raise Exception.Create(A000MSG_ERR_DATO_NON_VALIDO);
  Posiz:=Pos('.',Sender.AsString);
  if Posiz = 0 then
    Posiz:=Pos(':',Sender.AsString);
  if Posiz = 0 then
    exit;
  Minuti:=StrToInt(Copy(Sender.AsString,Posiz + 1,2));
  if Minuti > 59 then
    raise Exception.Create(A000MSG_ERR_MINUTI);
end;

procedure TA029FSchedaRiepilMW.CalcolaDati;
{Dati calcolati
Aggiornamento dei dati in fasce nella griglia}
var
    A,M,G:Word;
    i:Byte;
    BK:TBookMark;
begin
  if SelAnagrafe = nil then Exit;
  DecodeDate(FselT070_Funzioni.FieldByname('Data').AsDateTime,A,M,G);
  //Calcolo i totali
  TotaliCalcolati.TotLiqNelMese:=0;
  TotaliCalcolati.TotAss1:=0;
  TotaliCalcolati.TotAss2:=0;
  TotaliCalcolati.TotStrEcc:=0;
  TotaliCalcolati.TotStrMes:=0;
  TotaliCalcolati.TotStrLiq:=0;
  TotaliCalcolati.TotStrAut:=0;
  TotaliCalcolati.TotStrAnn:=0;
  if (A <> 0) and (M <> 0) then
  begin
    try
      CaricaL07;
      R450DtM1.ConteggiMese('Scheda',A,M,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      //Ciclo su Q071 per ricalcolare i campi calcolati
      selT071.DisableControls;
      BK:=selT071.GetBookmark;
	  try { TODO : TEST IW 15 }
        selT071.First;
        while not selT071.Eof do
        begin
          TotaliCalcolati.TotLiqNelMese:=TotaliCalcolati.TotLiqNelMese + R180OreMinutiExt(selT071LiquidNelMese.AsString); //Liquidato nel mese
          selT071.Next;
        end;
        selT071.GotoBookmark(BK);
	  finally
        selT071.FreeBookmark(BK);
	  end;
      selT071.EnableControls;
    except
    end;
  end;
  with R450DtM1 do
  begin
    for i:=1 to NFasceMese do
    begin
      TotaliCalcolati.TotAss1:=TotaliCalcolati.TotAss1 + tdatiassestamen[1].tminassest[i]; //Ore di assest. 1
      TotaliCalcolati.TotAss2:=TotaliCalcolati.TotAss2 + tdatiassestamen[2].tminassest[i]; //Ore di assest. 2
      TotaliCalcolati.TotStrEcc:=TotaliCalcolati.TotStrEcc + tminstrmen_ori[i];            //OreEccedGiorn
      TotaliCalcolati.TotStrMes:=TotaliCalcolati.TotStrMes + tstrmese[i];                  //Liquidabile fatto nel mese
      TotaliCalcolati.TotStrLiq:=TotaliCalcolati.TotStrLiq + tstrliqmm[i];                 //Ore Straord Liquidato
      TotaliCalcolati.TotStrAut:=TotaliCalcolati.TotStrAut + tstrannom[i];                 //Maturato da inizio anno
      TotaliCalcolati.TotStrAnn:=TotaliCalcolati.TotStrAnn + tstrliq[i];                   //Liquidato da inizio anno
    end;
  end;
  //Visualizzo i dati calcolati nei TEdit
  if Assigned(FVisualizzaDatiCalcolati) then
    FVisualizzaDatiCalcolati(TotaliCalcolati);
end;

function TA029FSchedaRiepilMW.CambioCausPresenza(CodiceCausPresenza: String): String;
begin
  Result:=VarToStr(selT275.Lookup('Codice',CodiceCausPresenza,'OreNormali'));

  if Result = 'A' then
    TipoOreCausalizzate:=tocEscluse
  else if Result = 'B' then
    TipoOreCausalizzate:=tocIncluse
  else if Result = 'D' then
    TipoOreCausalizzate:=tocIncluse
  else
    TipoOreCausalizzate:=tocCompensabili;

  selT073Comp.Filter:='Causale = ''' +  CodiceCausPresenza + '''';
  selT073Comp.Filtered:=False;
  selT073Comp.Filtered:=True;
  selT074Liq.Filter:='Causale = ''' +  CodiceCausPresenza + '''';
  selT074Liq.Filtered:=False;
  selT074Liq.Filtered:=True;
  PresenzaLiquidataSuccessiva:=R450DtM1.EsistePresenzaLiquidataSuccessiva(CodiceCausPresenza);
  selT074Liq.ReadOnly:=(TipoOreCausalizzate = tocCompensabili) or (FselT070_Funzioni.State = dsBrowse) or (PresenzaLiquidataSuccessiva) or (BloccoT074);
  selT073Comp.ReadOnly:=(TipoOreCausalizzate in [tocIncluse,tocCompensabili]) or (FselT070_Funzioni.State = dsBrowse) or (PresenzaLiquidataSuccessiva) or (BloccoT074);
end;

function TA029FSchedaRiepilMW.CaptionOreIncluseEscluse(
  OreNormali: String): String;
begin
  if OreNormali = 'A' then
    Result:='Esclusa dalle ore normali'
  else if OreNormali = 'B' then
    Result:='Inclusa nelle ore normali'
  else if OreNormali = 'D' then
    Result:='Inclusa nelle ore normali'
  else if OreNormali = 'C' then
    OreNormali:='Compensabile'
  else //Caratto. 22/05/2013. Non so se possibili altri valori
    OreNormali:='';
end;

procedure TA029FSchedaRiepilMW.FascePresenza;
{Costruisco la frase SQL per leggere le causali di presenza in fasce}
var
  Carat:Char;
  Alias,Tabella,SQLSelect:String;
  i:ShortInt;
  SQLJoin,DispLab,JoinOra:Array[1..28] of String;
begin
  R450DtM1.x300_GetFasceMese(R180Anno(FselT070_Funzioni.FieldByname('DATA').AsDateTime),R180Mese(FselT070_Funzioni.FieldByname('DATA').AsDateTime),True);
  selT074.DisableControls;
  selT074.Close;
  Carat:='A';
  SQLSelect:='SELECT T073.ROWID,T073.Causale';
  //Leggo le fasce dai dati in fasce
  for i:=1 to R450DtM1.NFasceMese do
  begin
    Alias:='T074' + Carat;
    Tabella:='T074_CausPresFasce ' + Alias;
    SQLSelect:=SQLSelect + ',' + Alias + '.OrePresenza';
    SQLJoin[i]:=',' + Tabella;
    JoinOra[i]:='T073.Progressivo = ' + Alias +
                '.Progressivo AND T073.Data = '  + Alias +
                '.Data AND T073.Causale = ' + Alias +
                '.Causale AND '+ Alias + '.CodFascia = ''' + R450DtM1.tfasce[i] + ''' AND';
    DispLab[i]:=Format('%s (%d%%)',[R450DtM1.tfasce[i],R450DtM1.tmaggioraz[i]]);
    inc(Carat);
  end;
  with selT074.Sql do
  begin
    Clear;
    Add(SQLSelect);
    Add('FROM T073_SchedaCausPres T073');
    for i:=1 to R450DtM1.NFasceMese do
      Add(SQLJoin[i]);
    Add('WHERE');
    for i:=1 to R450DtM1.NFasceMese do
      Add(JoinOra[i]);
    Add(Format('T073.Progressivo = %d AND T073.Data = ''%s''',[FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,FormatDateTime('dd/mm/yyyy',FselT070_Funzioni.FieldByName('DATA').AsDateTime)]));
    Add('ORDER BY T073.Causale');
  end;
  selT074.FieldDefs.Update;
  //Elimino i campi persistenti se ci sono
  for i:=selT074.FieldCount - 1 downto 0 do
    selT074.Fields[i].Free;
  //Creo i campi persistenti e scrivo la descrizione della fascia
  //nell'intestazione di colonna
  for i:=0 to selT074.FieldDefs.Count - 1 do
  begin
    selT074.FieldDefs[i].CreateField(selT074);
    if UpperCase(selT074.FieldDefs[i].Name) = 'CAUSALE' then
    begin
      selT074.Fields[i].DisplayLabel:='Causale';
      selT074.Fields[i].OnValidate:=selT074CAUSALEValidate;
      selT074.Fields[i].ReadOnly:=True;
    end
    else
    begin
      selT074.Fields[i].DisplayLabel:=DispLab[i];
      (selT074.Fields[i] as TStringField).EditMask:='!9000:00;1;_';
      selT074.Fields[i].Tag:=i;
      selT074.Fields[i].OnValidate:=T074Validate;
    end;
  end;
  //Creo il campo di lookup sulla descrizione della causale
  with TStringField.Create(Self) do
  begin
    FieldName:='D_Causale';
    Name:='Q074D_Causale';
    DisplayLabel:='Descrizione';
    Size:=30;
    DisplayWidth:=18;
    LookUp:=True;
    LookupDataSet:=selT275;
    LookupKeyFields:='Codice';
    LookupResultField:='Descrizione';
    KeyFields:='Causale';
    DataSet:=selT074;
    Index:=1;
  end;
  //Creo il Campo calcolato Totale
  with TStringField.Create(Self) do
  begin
    FieldName:='Totale';
    Name:='Q074Totale';
    Size:=8;
    Calculated:=True;
    DataSet:=selT074;
  end;
  selT074.AfterScroll:=nil;
  selT074.EnableControls;
  selT074.Open;
  selT074.AfterScroll:=selT074AfterScroll;
end;

procedure TA029FSchedaRiepilMW.selT074CAUSALEValidate(Sender: TField);
{Controllo la validità della causale di presenza}
begin
  if Sender.AsString = '' then
    exit;
  if not selT275.Locate('Codice',Sender.AsString,[]) then
    raise Exception.Create(A000MSG_A029_ERR_CAUS_PRES);
end;

procedure TA029FSchedaRiepilMW.T074Validate(Sender: TField);
{Controllo che i minuti siano minori di 60}
var Minuti,Posiz:Byte;
begin
  if Sender.IsNull then
    exit;
  if Pos(' ',Trim(Sender.AsString)) > 1 then
    raise Exception.Create(A000MSG_ERR_DATO_NON_VALIDO);
  Posiz:=Pos('.',Sender.AsString);
  if Posiz = 0 then
    Posiz:=Pos(':',Sender.AsString);
  if Posiz = 0 then
    exit;
  Minuti:=StrToInt(Copy(Sender.AsString,Posiz + 1,2));
  if Minuti > 59 then
    raise Exception.Create(A000MSG_ERR_MINUTI);
end;

procedure TA029FSchedaRiepilMW.GetStraordinarioEsterno(Ricalcola:Boolean);
var B:TBookMark;
    SE:Integer;
begin
  if Ricalcola then
    CalcolaDati;
  B:=selT075.GetBookmark;
  selT075.DisableControls;
  try { TODO : TEST IW 15 }
    selT075.First;
    SE:=0;
    while not selT075.Eof do
    begin
      SE:=SE + R180OreMinutiExt(selT075.FieldByName('ORESTRAORD').AsString);
      selT075.Next;
    end;
  finally
    try
      selT075.GotoBookmark(B);
	except
	end;
    selT075.FreeBookmark(B);
    selT075.EnableControls;
  end;
  if Assigned(FImpostaStraordinarioEsterno) then
    FImpostaStraordinarioEsterno(SE);
end;

procedure TA029FSchedaRiepilMW.SetQLook75(D:String);
begin
  QLook75.SQL.Clear;
  if A000LookupTabella(D,QLook75) then
  begin
    if QLook75.VariableIndex('DECORRENZA') >= 0 then
      QLook75.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
  end
  else
    QLook75.SQL.Add('SELECT '' '' CODICE,'' '' DESCRIZIONE FROM DUAL');
  QLook75.Open;
end;

function TA029FSchedaRiepilMW.GetContrattoEPartTime : TContrattoPartTime;
var
  QSContratto:TQueryStorico;
begin
  Result.CodContratto:='';
  if SelAnagrafe = nil then Exit;

  QSContratto:=TQueryStorico.Create(nil);
  try
    //Lettura contratto nello storico
    QSContratto.Session:=SessioneOracle;
    QSContratto.GetDatiStorici('T430CONTRATTO,T430D_CONTRATTO,T430PARTTIME,T430D_PARTTIME',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,R180FineMese(FselT070_Funzioni.FieldByName('Data').AsDateTime),R180FineMese(FselT070_Funzioni.FieldByName('Data').AsDateTime));
    if QSContratto.LocDatoStorico(R180FineMese(FselT070_Funzioni.FieldByName('Data').AsDateTime)) then
    begin
      Result.CodContratto:=QSContratto.FieldByName('T430CONTRATTO').AsString;
      Result.DescContratto:=QSContratto.FieldByName('T430D_CONTRATTO').AsString;
      Result.CodPartTime:=QSContratto.FieldByName('T430PARTTIME').AsString;
      Result.DescPartTime:=QSContratto.FieldByName('T430D_PARTTIME').AsString;
    end;
  finally
    QSContratto.Free;
  end;
end;

function TA029FSchedaRiepilMW.EsisteContratto(CodContratto: String) : Boolean;
begin
  Result:=False;
  if selT200.Locate('Codice',CodContratto,[]) then
    Result:=True;
end;

function TA029FSchedaRiepilMW.x022_StrAutAnn: Boolean;
{Lettura Contratto e Part-Time}
var
  ContrPartTime: TContrattoPartTime;
begin
  ContrPartTime:=GetContrattoEPartTime;
  Result:=EsisteContratto(ContrPartTime.CodContratto);

  if Assigned(FImpostaContrattoEPartTime) then
    FImpostaContrattoEPartTime(ContrPartTime,Result);
end;

procedure TA029FSchedaRiepilMW.selT070NewRecord;
begin
  with FselT070_Funzioni do
  begin
    FieldByName('Progressivo').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    FieldByName('Data').AsDateTime:=DataInserimento;
    FieldByName('DebitoOrario').AsString:=' 00.00';
    FieldByName('DebitoPO').AsString:=' 00.00';
    FieldByName('TipoPO').AsString:='0';
    FieldByName('FestivIntera').AsInteger:=0;
    FieldByName('FestivRidotta').AsInteger:=0;
    FieldByName('IndTurnoNum').AsInteger:=0;
    FieldByName('IndTurnoOre').AsString:=' 00.00';
    FieldByName('OreEccedComp').AsString:=' 00.00';
    FieldByName('OreEccedCompOltreSoglia').AsString:=' 00.00';
    FieldByName('Turni1').AsInteger:=0;
    FieldByName('Turni2').AsInteger:=0;
    FieldByName('Turni3').AsInteger:=0;
    FieldByName('Turni4').AsInteger:=0;
    FieldByName('GGPresenza').AsInteger:=0;
    FieldByName('GGVuoti').AsInteger:=0;
    FieldByName('OreVariazEcc').AsString:='  00.00';
  end;
end;

function TA029FSchedaRiepilMW.selT070AfterInsert: Boolean;
var i,xx:Integer;
  ReimpostaT071DataChange: boolean;
begin
  Result:=False;
  if x022_StrAutAnn then
  begin
    //Leggo le fasce per inserire i record dei dati in fasce
    with selT201 do
    begin
      Close;
      SetVariable('Codice', selT200.FieldByName('CODICE').AsString);
      Open;
      if RecordCount > 0 then
      begin
        InserimentoFasce:=True;
        //Aggiorno le tabelle
        selT071.Close;
        selT071.SetVariable('PROGRESSIVO',FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
        selT071.SetVariable('DATA',FselT070_Funzioni.FieldByName('DATA').AsDateTime);
        selT071.Open;
        selT072.Close;
        selT072.SetVariable('PROGRESSIVO',FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
        selT072.SetVariable('DATA',FselT070_Funzioni.FieldByName('DATA').AsDateTime);
        selT072.Open;
        //Abilito le cache delle tabelle
        selT071.CachedUpdates:=True;
        selT072.CachedUpdates:=True;
        selT074.CachedUpdates:=True;
        selT071.ReadOnly:=False;
        selT072.ReadOnly:=False;
        selT074.ReadOnly:=False;
        selT074Liq.ReadOnly:=TipoOreCausalizzate in [tocCompensabili];
        selT073Comp.ReadOnly:=(TipoOreCausalizzate in [tocCompensabili,tocIncluse]) or (selT073Comp.RecordCount = 0);
        //Azzeramento tabelle conteggi
        with R450DtM1 do
        begin
          for xx:=1 to MaxFasce do
          begin
            L07.tmaggioraz[xx]:=0;
            L07.tfasce[xx]:='';
            L07.tminlavmese[xx]:=0;
            L07.tdatiassestamento[1].tminassest[xx]:=0;
            L07.tdatiassestamento[2].tminassest[xx]:=0;
            L07.tminstrmens[xx]:=0;
            tstrannom[xx]:=0;
            L07.tstrliquidatomm[xx]:=0;
          end;
          L07.tdatiassestamento[1].tcauassest:='';
          L07.tdatiassestamento[2].tcauassest:='';
          NFasceMese:=0;
          L07.NFasce:=0;
        end;
        i:=1;
        First;
        selT071Ore1Assest.OnValidate:=nil;
        selT071Ore2Assest.OnValidate:=nil;
        //su web evento non impostato
        ReimpostaT071DataChange:=Assigned(dsrT071.OnDataChange);
        dsrT071.OnDataChange:=nil;
        while not Eof do
        begin
          R450DtM1.L07.tfasce[i]:=selT201.FieldByName('Codice').AsString;
          R450DtM1.L07.tmaggioraz[i]:=selT201.FieldByName('Maggiorazione').AsInteger;
          selT071.Append;
          selT071PROGRESSIVO.AsInteger:=FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger;
          selT071DATA.AsDateTime:=FselT070_Funzioni.FieldByName('DATA').AsDateTime;
          selT071MAGGIORAZIONE.AsInteger:=selT201.FieldByName('Maggiorazione').AsInteger;
          selT071CODFASCIA.AsString:=selT201.FieldByName('Codice').AsString;
          selT071ORELAVORATE.AsString:=' 00.00';
          selT071ORE1ASSEST.AsString:=' 00.00';
          selT071ORE2ASSEST.AsString:=' 00.00';
          selT071OREINDTURNO.AsString:=' 00.00';
          selT071OREECCEDGIORN.AsString:=' 00.00';
          selT071ORESTRAORDLIQ.AsString:=' 00.00';
          selT071LIQUIDNELMESE.AsString:=' 00.00';
          selT071.Post;
          Next;
          inc(i);
        end;
        selT071LIQUIDNELMESE.ReadOnly:=True;
        selT071Ore1Assest.OnValidate:=BDEQ070DEBITOORARIOValidate;
        selT071Ore2Assest.OnValidate:=BDEQ070DEBITOORARIOValidate;
        if ReimpostaT071DataChange then
          dsrT071.OnDataChange:=DsrT071DataChange;
        R450DtM1.NFasceMese:=i - 1;
        R450DtM1.L07.NFasce:=i - 1;
        InserimentoFasce:=False;
        FascePresenza;
        CalcolaDati;
        CausLiqEsterneOld:=R450DtM1.OreCausLiqEsterneInBudget + R450DtM1.OreCausLiqEsterneInBO;
        Result:=True;
      end;
    end;
  end;
end;

procedure TA029FSchedaRiepilMW.selT070AfterScroll;
begin
  if SelAnagrafe = nil then Exit;

  if selT071.CachedUpdates then
    exit;
  //Lettura blocchi sui riepiloghi
  BloccoT070:=selDatiBloccati.DatoBloccato(FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,FselT070_Funzioni.FieldByName('Data').AsDateTime,'T070');
  BloccoT071A:=selDatiBloccati.DatoBloccato(FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,FselT070_Funzioni.FieldByName('Data').AsDateTime,'T071A');
  BloccoT071S:=selDatiBloccati.DatoBloccato(FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,FselT070_Funzioni.FieldByName('Data').AsDateTime,'T071S');
  BloccoT074:=selDatiBloccati.DatoBloccato(FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,FselT070_Funzioni.FieldByName('Data').AsDateTime,'T074');
  ImpostaDataset;
  //Leggo dati su contratto
  R450DtM1.Progress400:=FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger;
  FascePresenza;
  x022_StrAutAnn;

  R450DtM1.selT070.SetVariable('PROGRESSIVO',0);
  CalcolaDati;

  //Richieste per iter autorizzativo straordinario
  selT065.Close;
  selT065.SetVariable('PROGRESSIVO',FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  selT065.SetVariable('DATA',FselT070_Funzioni.FieldByName('DATA').AsDateTime);
  if R450DtM1.IterAutorizzativoStr = '1' then
    selT065.Open;
  if Assigned(FCaricaComboCausaliPresenza) then
    FCaricaComboCausaliPresenza;

  selT074AfterScroll(nil);
  GetStraordinarioEsterno(False);
  //Abilitazione alla liquidazione straordinario
  LiquidBloccata:=(R450DtM1.LiquidazioneDistribuita = 'N') and (R450DtM1.EsisteLiquidazioneSuccessiva(FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,FselT070_Funzioni.FieldByName('DATA').AsDateTime));
  selT071LiquidNelMese.ReadOnly:=LiquidBloccata or BloccoT071S;
  //Abilitazione alla liquidazione ore compensabili
  LiquidCompBloccata:=R450DtM1.EsisteCompLiquidatoSuccessivo(FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,FselT070_Funzioni.FieldByName('DATA').AsDateTime);

  //Q070OreComp_Liquidate.ReadOnly:=A029FSchedaRiepil.lblLiquidCompBloccata.Visible;
  //Banca ore liquidata è read-only se esiste richiesta di autorizzazione straordinario su T065
  FselT070_Funzioni.FieldByName('OreComp_Liquidate').ReadOnly:=selT065.Active and (selT065.RecordCount > 0);
end;

procedure TA029FSchedaRiepilMW.selT070BeforeDelete;
var Data:TDateTime;
    PresenzeLiquidate:Boolean;
    i,j:Integer;
begin
  //Caratto sostituito valori di griglia con valori calcolati
  (*
  if (R180OreMinutiExt(SGStraord.Cells[4,0]) <> 0) or
     (R180OreMinutiExt(SGStraord.Cells[5,0]) <> 0) or
     (A029FSchedaRiepilMW.R450DtM1.L07.OreCompLiquidate <> 0) then
   *)
  //TotaliCalcolati impostati in CalcolaDati
  if (totaliCalcolati.TotStrLiq <> 0) or
     (totaliCalcolati.TotLiqNelMese <> 0) or
     (R450DtM1.L07.OreCompLiquidate <> 0) then
    raise Exception.Create(A000MSG_A029_ERR_DELETE_LIQUID);

  PresenzeLiquidate:=False;
  with selT074Liq do
  begin
    DisableControls;
    Filtered:=False;
    First;
    while not Eof do
    begin
      if R180OreMinutiExt(FieldByName('Liquidato').AsString) <> 0 then
      begin
        PresenzeLiquidate:=True;
        Break;
      end;
      Next;
    end;
    Filtered:=True;
    EnableControls;
  end;
  if PresenzeLiquidate then
    raise Exception.Create(A000MSG_A029_ERR_DELETE_LIQUID);
  PresenzeLiquidate:=False; // spero sia inutile
  with selT073Comp do
  begin
    DisableControls;
    Filtered:=False;
    First;
    while not Eof do
    begin
      if R180OreMinutiExt(FieldByName('Compensabile').AsString) <> 0 then
      begin
        PresenzeLiquidate:=True;
        Break;
      end;
      Next;
    end;
    Filtered:=True;
    EnableControls;
  end;
  if PresenzeLiquidate then
    raise Exception.Create(A000MSG_A029_ERR_DELETE_LIQUID);
  for i:=1 to High(R450DtM1.L07.tdatiassestamento) do
  begin
    for j:=1 to High(R450DtM1.L07.tdatiassestamento[i].tminassest) do
    begin
      if R450DtM1.L07.tdatiassestamento[i].tminassest[j] <> 0 then
        raise Exception.Create(A000MSG_A029_ERR_DELETE_ASSEST);
    end;
  end;
  Data:=FselT070_Funzioni.FieldByName('Data').AsDateTime;
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('Progressivo').AsInteger,Data,'T070') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  with OperSQL do
  begin
    Sql.Clear;
    Sql.Add(Format('DELETE FROM T071_SchedaFasce WHERE Progressivo = %d AND Data = ''%s''',[SelAnagrafe.FieldByName('Progressivo').AsInteger,FormatDateTime('dd/mm/yyyy',Data)]));
    Execute;
    Sql.Clear;
    Sql.Add(Format('DELETE FROM T072_SchedaIndPres WHERE Progressivo = %d AND Data = ''%s''',[SelAnagrafe.FieldByName('Progressivo').AsInteger,FormatDateTime('dd/mm/yyyy',Data)]));
    Execute;
    Sql.Clear;
    Sql.Add(Format('DELETE FROM T073_SchedaCausPres WHERE Progressivo = %d AND Data = ''%s''',[SelAnagrafe.FieldByName('Progressivo').AsInteger,FormatDateTime('dd/mm/yyyy',Data)]));
    Execute;
    Sql.Clear;
    Sql.Add(Format('DELETE FROM T074_CausPresFasce WHERE Progressivo = %d AND Data = ''%s''',[SelAnagrafe.FieldByName('Progressivo').AsInteger,FormatDateTime('dd/mm/yyyy',Data)]));
    Execute;
    Sql.Clear;
    Sql.Add(Format('DELETE FROM T075_STRESTERNO WHERE Progressivo = %d AND Data = ''%s''',[SelAnagrafe.FieldByName('Progressivo').AsInteger,FormatDateTime('dd/mm/yyyy',Data)]));
    Execute;
    Sql.Clear;
    Sql.Add(Format('DELETE FROM T076_CAUSPRESPAGHE WHERE Progressivo = %d AND Data = ''%s''',[SelAnagrafe.FieldByName('Progressivo').AsInteger,FormatDateTime('dd/mm/yyyy',Data)]));
    Execute;
  end;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(FselT070_Funzioni),NomeOwner,FselT070_Funzioni,True);

end;

procedure TA029FSchedaRiepilMW.selT070BeforeInsert;
begin
  if FselT070_Funzioni.SearchRecord('Data',DataInserimento,[srFromBeginning]) then
    raise Exception.Create(A000MSG_A029_ERR_SCHEDA_PRESENTE);
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataInserimento,'T070') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA029FSchedaRiepilMW.selT070BeforePost(SettaProprietaLog: Boolean);
begin
  if LiquidCompBloccata and
     (R180OreMinutiExt(FselT070_Funzioni.FieldByName('ORECOMP_LIQUIDATE').AsString) + R180OreMinutiExt(FselT070_Funzioni.FieldByName('BANCAORE_LIQ_VAR').AsString) >
      R180OreMinutiExt(VarToStr(FselT070_Funzioni.FieldByName('ORECOMP_LIQUIDATE').OldValue)) + R180OreMinutiExt(VarToStr(FselT070_Funzioni.FieldByName('BANCAORE_LIQ_VAR').OldValue))) then
    raise Exception.Create(A000MSG_A029_ERR_LIQ_BLOC);
  if SettaProprietaLog then
  begin
    case FselT070_Funzioni.State of
      dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(FselT070_Funzioni),NomeOwner,FselT070_Funzioni,False);
      dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(FselT070_Funzioni),NomeOwner,FselT070_Funzioni,False);
    end;
  end;
  PostDataSetFigli;
end;

procedure TA029FSchedaRiepilMW.selT070Edit;
{Tolgo i collegamenti con Q070 e abilito la cache}
begin
  selT071.CachedUpdates:=True;
  selT072.CachedUpdates:=True;
  selT074.CachedUpdates:=True;
  selT071.ReadOnly:=False;
  selT072.ReadOnly:=BloccoT070;
  selT074.ReadOnly:=BloccoT070;
  selT075.ReadOnly:=BloccoT070;
  selT076.ReadOnly:=BloccoT070;
  selT077.ReadOnly:=BloccoT070;
  selT074Liq.ReadOnly:=(TipoOreCausalizzate in [tocCompensabili]) or
                       (PresenzaLiquidataSuccessiva) or
                        BloccoT074;
  selT073Comp.ReadOnly:=(selT073Comp.RecordCount = 0) or
                        (TipoOreCausalizzate in [tocCompensabili,tocIncluse]) or
                        (PresenzaLiquidataSuccessiva) or
                         BloccoT074 ;
  CausLiqEsterneOld:=R450DtM1.OreCausLiqEsterneInBudget + R450DtM1.OreCausLiqEsterneInBO;
  selT071LiquidNelMese.ReadOnly:=LiquidBloccata or BloccoT071S;
end;

procedure TA029FSchedaRiepilMW.selT070AfterCancel;
{Elimino le operazioni nella cache}
begin
  FselT070_Funzioni.CancelUpdates;
  selT071.CachedUpdates:=False;
  selT072.CachedUpdates:=False;
  selT074.CachedUpdates:=False;
  selT074Liq.CancelUpdates;
  selT073Comp.CancelUpdates;
  selT071.ReadOnly:=True;
  selT072.ReadOnly:=True;
  selT074.ReadOnly:=True;
  selT075.ReadOnly:=True;
  selT076.ReadOnly:=True;
  selT077.ReadOnly:=True;
  selT074Liq.ReadOnly:=True;
  selT073Comp.ReadOnly:=True;
end;

procedure TA029FSchedaRiepilMW.selT070AfterDelete;
begin
  SessioneOracle.ApplyUpdates([FselT070_Funzioni],True);
end;

procedure TA029FSchedaRiepilMW.ApplicaModifiche;
begin
  //Caratto 16/05/2013 aggiunto selT075 perchè con webpj non esegue apply in after post
  SessioneOracle.ApplyUpdates([FselT070_Funzioni,selT071,selT072,selT074,selT074Liq,selT073Comp,selT077,selT075],True);

  //Caratto 20/05/2013 su WEbPJ usa selT076 in cachedUpdate
  if selT076.CachedUpdates then
    SessioneOracle.ApplyUpdates([selT076],True);

  RegistraLog.RegistraOperazione;
  RegistraLogT071.RegistraOperazione;
  RegistraLogT072.RegistraOperazione;
  RegistraLogT073.RegistraOperazione;
  RegistraLogT074.RegistraOperazione;
  RegistraLogT077.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TA029FSchedaRiepilMW.PostDataSetFigli;
begin
  if selT071.State in [dsEdit,dsInsert] then
    selT071.Post;
  if selT072.State in [dsEdit,dsInsert] then
    selT072.Post;
  if selT074.State in [dsEdit,dsInsert] then
    selT074.Post;
  if selT075.State in [dsEdit,dsInsert] then
    selT075.Post;
  if selT076.State in [dsEdit,dsInsert] then
    selT076.Post;
  if selT077.State in [dsEdit,dsInsert] then
    selT077.Post;
  if selT073Comp.State in [dsEdit,dsInsert] then
    selT073Comp.Post;
  if selT074Liq.State in [dsEdit,dsInsert] then
    selT074Liq.Post;
  RegistraLogFigli(selT071,RegistraLogT071);
  RegistraLogFigli(selT072,RegistraLogT072);
  RegistraLogFigli(selT073Comp,RegistraLogT073);
  RegistraLogFigli(selT074,RegistraLogT074);
  RegistraLogFigli(selT074Liq,RegistraLogT074);
  RegistraLogFigli(selT077,RegistraLogT077);
end;

procedure TA029FSchedaRiepilMW.RegistraLogFigli(ODS:TOracleDataSet; RL:TRegistraLog);
begin
  if not ODS.UpdatesPending then
    exit;
  ODS.First;
  while not ODS.Eof do
  begin
    RL.SettaProprieta('M',R180Query2NomeTabella(ODS),NomeOwner,ODS,False);
    ODS.Next;
  end;
  ODS.First;
end;

procedure TA029FSchedaRiepilMW.ImpostaLiquidazione;
begin
  A029FLiquidazione.Q071Liq.SetVariable('Progressivo',FselT070_Funzioni.FieldByname('Progressivo').AsInteger);
end;

procedure TA029FSchedaRiepilMW.ControllaStraordinarioLiquidato(var Cambiato: Boolean; var OreLiq: Integer; var ImpLiq: real; var MaxLiquidato: Integer);
// Controllo che il totale di ore liquidare non superi il budget mensile di straordinario
var
    DeltaLiq: Integer;
begin
  MaxLiquidato:=0;
  A029FLiquidazione.A029FBudgetDtM1.CtrlLiqClear;

  // verifica lo straordinario liquidato in fasce di maggiorazione
  with selT071 do
  begin
    First;
    OreLiq:=0;
    while not Eof do
    begin
      if UpdateStatus in [usModified,usInserted] then
      begin
        DeltaLiq:=R180OreMinutiExt(VarToStr(selT071.FieldByName('LiquidNelMese').Value)) - R180OreMinutiExt(VarToStr(selT071.FieldByName('LiquidNelMese').OldValue));
        OreLiq:=OreLiq + DeltaLiq;
        A029FLiquidazione.A029FBudgetDtM1.CtrlLiqAdd(TIPOLIQ,selT071.FieldByName('MAGGIORAZIONE').AsFloat,DeltaLiq);
      end;
      MaxLiquidato:=MaxLiquidato + R180OreMinutiExt(VarToStr(selT071LiquidNelMese.Value));
      Next;
    end;
  end;
  Cambiato:=(OreLiq <> 0); // per successivi controlli sul budget

  // verifica il riepilogo causali di presenza
  // se la causale di presenza abbatte il budget (liquidato) viene inclusa nel controllo
  with selT074Liq do
  begin
    Filtered:=False;
    First;
    while not Eof do
    begin
      if (VarToStr(selT275.Lookup('CODICE',selT074LiqCausale.AsString,'ABBATTE_BUDGET')) = 'L') then
      begin
        if UpdateStatus in [usModified,usInserted] then
        begin
          DeltaLiq:=R180OreMinutiExt(VarToStr(selT074Liq.FieldByName('Liquidato').Value)) - R180OreMinutiExt(VarToStr(selT074Liq.FieldByName('Liquidato').OldValue));
          OreLiq:=OreLiq + DeltaLiq;
          Cambiato:=Cambiato or (DeltaLiq <> 0);
          A029FLiquidazione.A029FBudgetDtM1.CtrlLiqAdd(selT074Liq.FieldByName('CAUSALE').AsString,selT074Liq.FieldByName('MAGGIORAZIONE').AsFloat,DeltaLiq);
        end;
        MaxLiquidato:=MaxLiquidato + R180OreMinutiExt(VarToStr(selT074Liq.FieldByName('Liquidato').Value));
      end;
      Next;
    end;
    Filtered:=True;
  end;
  ImpLiq:=A029FLiquidazione.A029FBudgetDtM1.CtrlLiqGetImporto(FselT070_Funzioni.FieldByName('Progressivo').AsInteger,FselT070_Funzioni.FieldByName('Data').AsDateTime);
end;

function TA029FSchedaRiepilMW.TotaliPresenza(CodiceCausPresenza: String; Aggiorna: Boolean; OreEsclCompMese: String): TPresenzeAnnue;
var
  i,k:Integer;
begin
  SetLength(Result.FascePresenza,0);
  with Result.TotaliPresenza do
  begin
    LiquidatoMese:=0;
    Ore:=0;
    Liquidato:=0;
    Abbattimento:=0;
    Liquidabile:=0;
    Residuo:=0;
    AnnoPrec:=0;
    OreBO:=0;
  end;

  k:=R450DtM1.IndiceRiepPres(CodiceCausPresenza);
  if k = -1 then exit;
  if Aggiorna then
  begin
    VariazioniRiepPres.Compensabile:=R180OreMinutiExt(OreEsclCompMese);
    R450DtM1.AppRiepPres.CompensabileMese:=R180OreMinutiExt(OreEsclCompMese);
  end;
  Result.CompensabileAnno:=R450DtM1.RiepPres[k].CompensabileAnno;
  Result.CompensabileAnnoEff:=R450DtM1.RiepPres[k].CompensabileAnnoEff;
  Result.CompensabileMeseEff:=R450DtM1.RiepPres[k].CompensabileMeseEff;
  Result.RecuperoAnno:=R450DtM1.RiepPres[k].RecuperoAnno;

  SetLength(Result.FascePresenza,R450DtM1.NFasceMese);
  for i:=1 to R450DtM1.NFasceMese do
  begin
    with Result.FascePresenza[i-1] do
    begin
      CodFascia:=R450DtM1.tfasce[i];
      Fascia:=Format('%s (%d%%)',[R450DtM1.tfasce[i],R450DtM1.tmaggioraz[i]]);
      OreRese:=R450DtM1.RiepPres[k].OreRese[i];
      AnnoPrec:=R450DtM1.RiepPres[k].AnnoPrec[i];
      Liquidabile:=R450DtM1.RiepPres[k].Liquidabile[i] - R450DtM1.RiepPres[k].Liquidato[i];
      Liquidato:=R450DtM1.RiepPres[k].Liquidato[i];
      Residuo:=R450DtM1.RiepPres[k].Residuo[i];
      OrePerse:=R450DtM1.RiepPres[k].Abbattimento[i];
      BancaOre:=R450DtM1.RiepPres[k].OreBOMese[i];
      if Aggiorna then
        VariazioniRiepPres.Liquidato[i]:=R450DtM1.RiepPres[k].LiquidatoMese[i];

      //totali
      inc(Result.TotaliPresenza.Ore,OreRese);
      inc(Result.TotaliPresenza.AnnoPrec,AnnoPrec);
      inc(Result.TotaliPresenza.Liquidabile,Liquidabile);
      inc(Result.TotaliPresenza.Liquidato,Liquidato);
      inc(Result.TotaliPresenza.Residuo,Residuo);
      inc(Result.TotaliPresenza.Abbattimento,OrePerse);
      inc(Result.TotaliPresenza.OreBO,BancaOre);
      inc(Result.TotaliPresenza.LiquidatoMese,VariazioniRiepPres.Liquidato[i]);
    end;
  end;
end;

function TA029FSchedaRiepilMW.VerificaDispLiquidità: String;
begin
  Result:='';
  if FselT070_Funzioni.FieldByName('ORECOMP_LIQUIDATE').IsNull and FselT070_Funzioni.FieldByName('BANCAORE_LIQ_VAR').isNull then
    exit;
  if (R180OreMinutiExt(FselT070_Funzioni.FieldByName('ORECOMP_LIQUIDATE').AsString) + R180OreMinutiExt(FselT070_Funzioni.FieldByName('BANCAORE_LIQ_VAR').AsString)) = 0 then
    exit;
  if (R180OreMinutiExt(FselT070_Funzioni.FieldByName('ORECOMP_LIQUIDATE').AsString) + R180OreMinutiExt(FselT070_Funzioni.FieldByName('BANCAORE_LIQ_VAR').AsString) - R450DtM1.L07.OreCompLiquidate) > R450DtM1.BancaOreResidua then
    Result:=A000MSG_A029_ERR_DISP_LIQ;
end;

function TA029FSchedaRiepilMW.CalcolaCompLiquidato:Integer;
begin
  Result:=(R180OreMinutiExt(VarToStr(FselT070_Funzioni.FieldByName('ORECOMP_LIQUIDATE').Value)) + R180OreMinutiExt(VarToStr(FselT070_Funzioni.FieldByName('BANCAORE_LIQ_VAR').Value))) - (R180OreMinutiExt(VarToStr(FselT070_Funzioni.FieldByName('ORECOMP_LIQUIDATE').OldValue)) + R180OreMinutiExt(VarToStr(FselT070_Funzioni.FieldByName('BANCAORE_LIQ_VAR').OldValue)));
end;

function TA029FSchedaRiepilMW.CalcolaTotAss: Integer;
begin
  Result:=0;
  if VarToStr(selT305.Lookup('CODICE',FselT070_Funzioni.FieldByName('CAUSALE1MINASS').AsString,'LIMITE_LIQ')) = 'S' then
    Result:=Result + Abs(Min(R180OreMinutiExt(VarToStr(selT071.FieldByName('ORE1ASSEST').Value)),0)) - Abs(Min(R180OreMinutiExt(VarToStr(selT071.FieldByName('ORE1ASSEST').OldValue)),0));
  if VarToStr(selT305.Lookup('CODICE',FselT070_Funzioni.FieldByName('CAUSALE2MINASS').AsString,'LIMITE_LIQ')) = 'S' then
    Result:=Result + Abs(Min(R180OreMinutiExt(selT071.FieldByName('ORE2ASSEST').AsString),0)) - Abs(Min(R180OreMinutiExt(VarToStr(selT071.FieldByName('ORE2ASSEST').OldValue)),0));
end;

function TA029FSchedaRiepilMW.CalcolaBancaOreLiquidata: Integer;
begin
  Result:=(R180OreMinutiExt(VarToStr(FselT070_Funzioni.FieldByName('ORECOMP_LIQUIDATE').Value)) + R180OreMinutiExt(VarToStr(FselT070_Funzioni.FieldByName('BANCAORE_LIQ_VAR').Value))) - (R180OreMinutiExt(VarToStr( FselT070_Funzioni.FieldByName('ORECOMP_LIQUIDATE').OldValue)) + R180OreMinutiExt(VarToStr(FselT070_Funzioni.FieldByName('BANCAORE_LIQ_VAR').OldValue)));
end;

function TA029FSchedaRiepilMW.ControllaLiquidato(var DialogConferma: Boolean): String;
var CanConfirm: Boolean;
    Liquidato,TotLiquidato,TotLiquidatoMM,TotDaLiquidare,CompLiquidato,TotAss:Integer;
    VerificaCanConfirm: Boolean;
    MsgLimiteStraord: String;
begin
  CanConfirm:=Parametri.LiquidazioneForzata = 'S';
  VerificaCanConfirm:=False;
  //Banca delle ore liquidata
  CompLiquidato:=CalcolaCompLiquidato;
  //Straordinario liquidato
  with selT071 do
  begin
    First;
    TotLiquidato:=0;
    TotDaLiquidare:=0;
    TotAss:=0;
    Result:='';
    while not Eof do
    begin
      TotAss:=TotAss + CalcolaTotAss;
      Liquidato:=R180OreMinutiExt(VarToStr(selT071.FieldByName('LiquidNelMese').Value)) - R180OreMinutiExt(VarToStr(selT071.FieldByName('LiquidNelMese').OldValue));
      inc(TotLiquidato,Liquidato);
      inc(TotDaLiquidare,R180OreMinutiExt(selT071.FieldByName('StrDaLiq').AsString));
      if Liquidato > R180OreMinutiExt(selT071.FieldByName('StrDaLiq').AsString) then
      begin
        Result:=Result + Format(A000MSG_A029_ERR_FMT_LIQ_FASCIA,[selT071.FieldByName('CodFascia').AsString]) + CRLF +
              R180MinutiOre(Liquidato) + ' > ' + selT071.FieldByName('StrDaLiq').AsString + CRLF + CRLF;
      end;
      Next;
    end;
    First;
  end;
  if TotLiquidato > TotDaLiquidare then
  begin
    Result:=Result + A000MSG_A029_ERR_LIQ_COMPL + CRLF +
            R180MinutiOre(TotLiquidato) + ' > ' + R180MinutiOre(TotDaLiquidare) + CRLF + CRLF;
    VerificaCanConfirm:=True;
  end;
  //Considero nel liquidato anche le ore di assestamento negative riferite a caus. di giustificazione con LIMITE_LIQ = 'S'
  inc(TotLiquidato,TotAss);
  //Registro TotLiquidato in TotLiquidatoMM per controllo su disponibilità mensile, che non tiene conto delle ore escluse dalle normali
  TotLiquidatoMM:=TotLiquidato - TotAss;  //Alberto 09/05/2009: le ore di assestamento non partecipano ai controlli mensili
  //Considero nel liquidato annuale anche le ore liquidate escluse dalle normali con ABBATTE_BUDGET = 'S'
  inc(TotLiquidato,R450DtM1.OreCausLiqEsterneInBudget + R450DtM1.OreCausLiqEsterneInBO - CausLiqEsterneOld);
  MsgLimiteStraord:='';
  if (TotLiquidato > 0) or (CompLiquidato > 0) then
    MsgLimiteStraord:=A029FLiquidazione.LimiteIndividualeStraordinario(FSelT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,TotLiquidato,TotLiquidatoMM,CompLiquidato,FSelT070_Funzioni.FieldByName('DATA').AsDateTime);
  //Caratto 24/05/2013 rimosse msg e gestito con unico messaggio per unificazione con WEB
  if MsgLimiteStraord <> '' then
  begin
    VerificaCanConfirm:=True;
    Result:=Result + MsgLimiteStraord;
  end;
  DialogConferma:=False;
  if Result <> '' then
  begin
    if (not VerificaCanConfirm) or (CanConfirm) then
    begin
      //Solo messaggio di errore sulle fasce. Dialog di conferma per proseguire
      Result:=Result + 'Confermare?';
      DialogConferma:=True;
    end;
  end;
end;

function TA029FSchedaRiepilMW.selT074LiqBeforePost(CodiceCausPresenza: String; var DialogConferma: boolean): String;
var
  PresenzeAnnue: TPresenzeAnnue;
  i,Residuo,Liquidato,Tot:Integer;
begin
  Result:='';
  if R180OreMinutiExt(selT074Liq.FieldByName('LIQUIDATO').AsString) = 0 then
    exit;

  PresenzeAnnue:=TotaliPresenza(CodiceCausPresenza,False,'');
  //Residuo:=R180OreMinutiExt(A029FSchedaRiepil.grdPresAnnueTot.Cells[6,0]);
  //Residuo:=R180OreMinutiExt(A029FSchedaRiepil.grdPresAnnueTot.Cells[4,0]) - R180OreMinutiExt(A029FSchedaRiepil.grdPresAnnueTot.Cells[5,0]);

  //Caratto 28/05/2013 utilizzo struttura dati al posto della griglia direttamente
  //  Residuo:=R180OreMinutiExt(A029FSchedaRiepil.grdPresAnnueTot.Cells[4,0]);
  Residuo:=PresenzeAnnue.TotaliPresenza.Liquidabile;

  Liquidato:=0;
  for i:=0 to Length(PresenzeAnnue.FascePresenza) - 1 do
  begin
    if PresenzeAnnue.FascePresenza[i].CodFascia = selT074Liq.FieldByName('CODFASCIA').AsString then
    begin
      Liquidato:=R180OreMinutiExt(selT074Liq.FieldByName('LIQUIDATO').AsString) - VariazioniRiepPres.Liquidato[i+1]; //VariazioniRiepPres.Liquidato parte da indice 1 e non 0
      Break;
    end;
  end;
  if Liquidato > Residuo then
  begin
    raise exception.Create('Residuo insufficiente: ' + R180MinutiOre(Residuo));
  end;
   //Caratto sostituito valori di griglia con valori calcolati
  //if not(TipoOreCausalizzate in [tocEscluse]) and (Liquidato > R180OreMinutiExt(A029FSchedaRiepil.SGStraord.Cells[8,0])) then
  //TotaliCalcolati impostati in CalcolaDati
  Tot:=TotaliCalcolati.TotStrAut - TotaliCalcolati.TotStrAnn;
  if not(TipoOreCausalizzate in [tocEscluse]) and (Liquidato > Tot) then
  begin
    DialogConferma:=Parametri.LiquidazioneForzata = 'S';
    Result:=Format(A000MSG_A029_DLG_FMT_STR_INSUF,[R180MinutiOre(Tot)]);
  end;
end;

procedure TA029FSchedaRiepilMW.selT073CompBeforePost(CodiceCausPresenza: String);
{Controllo che il compensabile non sia maggiore della disponibilità}
var
  PresenzeAnnue: TPresenzeAnnue;
begin
  if R180OreMinutiExt(selT073Comp.FieldByName('COMPENSABILE').AsString) = 0 then
    exit;

  PresenzeAnnue:=TotaliPresenza(CodiceCausPresenza,False,'');

  (*if (R180OreMinutiExt(sel073CompCOMPENSABILE.AsString) - A029FSchedaRiepil.VariazioniRiepPres.Compensabile) >
     R180OreMinutiExt(A029FSchedaRiepil.grdPresAnnueTot.Cells[5,0]) then*)
   //Caratto sostituito valori di griglia con valori calcolati
  (*if R180OreMinutiExt(selT073Comp.FieldByName('COMPENSABILE').AsString) >
       (R180OreMinutiExt(A029FSchedaRiepil.edtOreEsclCompMeseEff.Text) +
       R180OreMinutiExt(A029FSchedaRiepil.grdPresAnnueTot.Cells[6,0])) then*)
  if R180OreMinutiExt(selT073Comp.FieldByName('COMPENSABILE').AsString) >
       (PresenzeAnnue.CompensabileMeseEff + PresenzeAnnue.TotaliPresenza.Residuo) then
    raise exception.Create('Residuo insufficiente: ' + R180MinutiOre(PresenzeAnnue.TotaliPresenza.Residuo));
end;

function TA029FSchedaRiepilMW.ParametriConteggio: String;
begin
  Result:='Tipo Conteggio: ' + IntToStr(R450DtM1.R455_tipocon) + CRLF +
     'Eccedenze liquidabili troncate: ' + R450DtM1.TroncaEccedenze + CRLF +
     'Eccedenze residuabili troncate: ' + R450DtM1.TroncaLiquidabile + CRLF +
     'Limite liquidabile default: ' + R450DtM1.LimiteEccLiq + CRLF +
     'Limite residuabile default: ' + R450DtM1.LimiteEccRes + CRLF +
     'Liquidabile abbattuto oltre limite annuo: ' + R450DtM1.LimiteLiquidabileAnnuo + CRLF +
     'Serbatoi: ' + R450DtM1.ElencoSerbatoi + CRLF +
     'Recupero serbatoi: ' + R450DtM1.RecuperoSerbatoi + CRLF +
     'Liquidazione distribuita: ' + R450DtM1.LiquidazioneDistribuita + CRLF +
     'Recupero debito: ' + IntToStr(R450DtM1.RecuperoDebito) + CRLF +
     'Recupero debito max: ' + R180MinutiOre(R450DtM1.RecuperoDebitoMax) + CRLF +
     'Banca ore: ' + R450DtM1.BancaOre + CRLF +
     'Soglia ecc.comp.: ' + R180MinutiOre(R450DtM1.SogliaCompLiq) + CRLF +
     'Tipo limite ecc.comp.: ' + R450DtM1.TipoLimiteCompA + CRLF +
     'Limite ecc.comp.: ' + R180MinutiOre(R450DtM1.LimiteCompA) + CRLF +
     'Abbattimento liquidabile: ' + R450DtM1.AbbattimentoLiquidabile + CRLF +
     'Periodicità abbattimento eccedenza: ' + R450DtM1.PeriodicitaAbbattimento + CRLF +
     'Mesi periodicità: ' + IntToStr(R450DtM1.MesiSaldoPrec) + CRLF +
     'Abbattimento max: ' + R180MinutiOre(R450DtM1.SaldoMobile_AbbatteMax) + CRLF +
     'Saldi abbattibili: ' + R450DtM1.SaldoMobile_SaldiUsati + CRLF +
     'Causali compensabili: ' + R450DtM1.CausaliCompensabili + CRLF +
     'Riposi non fruiti: ' + FloatToStr(R450DtM1.RiposiNonFruitiGG) + ' (' + R180MinutiOre(R450DtM1.RiposiNonFruitiOre) + ')' + CRLF
     ;
end;

procedure TA029FSchedaRiepilMW.LiquidazioneAutomatica(UsaGestioneBudget: Boolean;OreLiq :Integer; ImpLiq: Real);
var CodGruppo,FiltroAnagrafe:String;
begin
  if Parametri.CampiRiferimento.C2_Facoltativo = 'S' then
  begin
    if UsaGestioneBudget then
      A029FLiquidazione.A029FBudgetDtM1.ControllaBudget(True,FSelT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,FSelT070_Funzioni.FieldByName('DATA').AsDateTime,OreLiq,ImpLiq)
    else
      A029FLiquidazione.A029FBudgetDtM1.PutLiquidatoFuoriBudget(FSelT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,FSelT070_Funzioni.FieldByName('DATA').AsDateTime,OreLiq);
  end;

  // effettua liquidazione
  ImpostaLiquidazione;
  A029FLiquidazione.Liquidazione(False,FSelT070_Funzioni.FieldByName('DATA').AsDateTime,FSelT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,-1,OreLiq,'');
  SessioneOracle.Commit;
  selT071.Close;
  selT071.Open;
  R450DtM1.selT071.Refresh;  //Alberto 19/05/2006: refresh per consentire una nuova liquidazione automatica
  CalcolaDati;
  //Calcolo il fruito e aggiorno il budget straordinario
  if Budget then
  begin
    A029FLiquidazione.A029FBudgetDtM1.GetRaggruppamentiBudget(FSelT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger,FSelT070_Funzioni.FieldByName('DATA').AsDateTime,CodGruppo,FiltroAnagrafe);
    A029FLiquidazione.A029FBudgetDtM1.AggiornaFruitoBudget(FSelT070_Funzioni.FieldByName('DATA').AsDateTime,TipoLiq,CodGruppo,FiltroAnagrafe,'E');
    SessioneOracle.Commit;
  end;
end;

function TA029FSchedaRiepilMW.OpenDettaglioGG: Boolean;
begin
  Result:=False;
(*
  if VarToStr(selT162.Lookup('CODICE',selT072.FieldByName('CODINDPRES').AsString,'TIPO')) <> 'I' then
    exit;

  if Parametri.CampiRiferimento.C3_DettGG_TipoI <> 'S' then
    exit;
*)
  if (Parametri.ModuloInstallato['TORINO_CSI']) then
  begin
    selUsrT072.Close;
    selUsrT072.setVariable('PROGRESSIVO',FselT070_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    selUsrT072.setVariable('DATA',FselT070_Funzioni.FieldByName('DATA').AsDateTime);
    try
      selUsrT072.Open;
      Result:=True;
    except
    end;
  end;
end;

procedure TA029FSchedaRiepilMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(R450DtM1);
  FreeAndNil(A029FLiquidazione);
  FreeAndNil(selDatiBloccati);
  FreeAndNil(RegistraLogT071);
  FreeAndNil(RegistraLogT072);
  FreeAndNil(RegistraLogT073);
  FreeAndNil(RegistraLogT074);
  FreeAndNil(RegistraLogT077);
  inherited;
end;

end.
