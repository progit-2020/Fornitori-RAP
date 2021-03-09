unit A100UMissioniMW;

interface

uses
  System.SysUtils, System.Classes, Variants,R005UDataModuleMW, Data.DB, OracleData,
  A000USessione, A000UInterfaccia, A000UMessaggi, A000UCostanti, Oracle,
  C180FunzioniGenerali, QueryStorico,A004UGiustifAssPresMW,StrUtils, Math,
  Rp502Pro, DatiBloccati, Datasnap.DBClient;

type
  TCostiDettaglio = record
    nCosto:Real;
    nRimborso:Real;
    EstCosto:Real;
    EstRimborso:Real;
  end;

  TMessaggioAvviso = procedure (msg: String) of object;
  TMostraColonne = procedure (Mostra: Boolean) of object;
  TProcedure = procedure of object;
  //TFunctionBool = function: Boolean of object;
  TValidate = procedure (Sender: TField) of object;
  TEvDataset = procedure (DataSet: TDataSet) of object;

  TA100FMissioniMW = class(TR005FDataModuleMW)
    QM011: TOracleDataSet;
    QM011CODICE: TStringField;
    QM011DESCRIZIONE: TStringField;
    QM011SELEZIONATO: TStringField;
    dsrM011: TDataSource;
    M013F_CALC_RIMB_PASTO: TOracleQuery;
    QSource: TOracleDataSet;
    M049: TOracleDataSet;
    M049CODICE: TStringField;
    M049DESCRIZIONE: TStringField;
    M049SOMMA: TStringField;
    DM049: TDataSource;
    M051: TOracleDataSet;
    M051PROGRESSIVO: TFloatField;
    M051MESESCARICO: TDateTimeField;
    M051MESECOMPETENZA: TDateTimeField;
    M051DATADA: TDateTimeField;
    M051ORADA: TStringField;
    M051CODICERIMBORSOSPESE: TStringField;
    M051PROGRIMBORSO: TFloatField;
    M051DATARIMBORSO: TDateTimeField;
    M051IMPORTO: TFloatField;
    M051TIPORIMBORSO: TStringField;
    M051IMPORTO_VALEST: TFloatField;
    M051desctiporimborso: TStringField;
    M051somma: TStringField;
    M051A: TOracleDataSet;
    D051: TDataSource;
    Q050: TOracleDataSet;
    Q050PROGRESSIVO: TFloatField;
    Q050MESESCARICO: TDateTimeField;
    Q050MESECOMPETENZA: TDateTimeField;
    Q050DATADA: TDateTimeField;
    Q050ORADA: TStringField;
    Q050CODICERIMBORSOSPESE: TStringField;
    Q050IMPORTORIMBORSOSPESE: TFloatField;
    Q050IMPORTOCOSTORIMBORSO: TFloatField;
    Q050IMPORTOINDENNITASUPPLEMENTARE: TFloatField;
    Q050DESCRIZIONE: TStringField;
    Q050CODICEVOCEPAGHE: TStringField;
    Q050ESISTENZAINDENNITASUPPL: TStringField;
    Q050CODICEVOCEPAGHEINDENNITASUPPL: TStringField;
    Q050COD_VALUTA_EST: TStringField;
    Q050IMPRIMB_VALEST: TFloatField;
    Q050COSTORIMB_VALEST: TFloatField;
    Q050TIPO: TStringField;
    Q050flag_anticipo: TStringField;
    Q050codrimborso: TStringField;
    Q050descrimborso: TStringField;
    Q020: TOracleDataSet;
    Q020CODICE: TStringField;
    Q020DESCRIZIONE: TStringField;
    Q020CODICEVOCEPAGHE: TStringField;
    Q020SCARICOPAGHE: TStringField;
    Q020ESISTENZAINDENNITASUPPL: TStringField;
    Q020CODICEVOCEPAGHEINDENNITASUPPL: TStringField;
    Q020SCARICOPAGHEINDENNITASUPPL: TStringField;
    Q020PERCINDENNITASUPPL: TFloatField;
    Q020ARROTINDENNITASUPPL: TStringField;
    Q020FLAG_ANTICIPO: TStringField;
    Q020TIPO: TStringField;
    D020: TDataSource;
    D010: TDataSource;
    Q010: TOracleDataSet;
    Q010DECORRENZA: TDateTimeField;
    Q010CODICE: TStringField;
    Q010TIPO_MISSIONE: TStringField;
    Q010DESCRIZIONE: TStringField;
    Q010OREMINIMEPERINDENNITA: TStringField;
    Q010LIMITEORERETRIBUITEINTERE: TStringField;
    Q010ARROTONDAMENTOORE: TFloatField;
    Q010TIPO: TStringField;
    Q010PERCRETRIBSUPEROORE: TFloatField;
    Q010MAXGIORNIRETRMESE: TFloatField;
    Q010PERCRETRIBSUPEROGG: TFloatField;
    Q010ARROTTARIFFADOPORIDUZIONE: TStringField;
    Q010ARROTTOTIMPORTIDATIPAGHE: TStringField;
    Q010RIDUZIONE_PASTO: TStringField;
    Q010PERCRETRIBPASTO: TFloatField;
    Q010TARIFFAINDENNITA: TFloatField;
    Q010TIPO_TARIFFA: TStringField;
    Q010CODVOCEPAGHEINTERA: TStringField;
    Q010CODVOCEPAGHESUPHH: TStringField;
    Q010CODVOCEPAGHESUPGG: TStringField;
    Q010CODVOCEPAGHESUPHHGG: TStringField;
    Q010ORERIMBORSOPASTO: TStringField;
    Q010TARIFFARIMBORSOPASTO: TFloatField;
    Q010ORERIMBORSOPASTO2: TStringField;
    Q010TARIFFARIMBORSOPASTO2: TFloatField;
    Q010CODICI_INDENNITAKM: TStringField;
    Q010CODICI_RIMBORSI: TStringField;
    Q010IND_DA_TAB_TARIFFE: TStringField;
    Q010CAUSALE_MISSIONE: TStringField;
    Q010GIUSTIF_HHMAX: TStringField;
    Q010GIUSTIF_COPRE_DEBITOGG: TStringField;
    Q010TIPO_RIMBORSOPASTO: TStringField;
    countM050: TOracleQuery;
    selCountM050: TOracleQuery;
    SelP030: TOracleDataSet;
    DSelP030: TDataSource;
    DP050: TDataSource;
    P050: TOracleDataSet;
    P050COD_ARROTONDAMENTO: TStringField;
    P050COD_VALUTA: TStringField;
    P050DECORRENZA: TDateTimeField;
    P050DESCRIZIONE: TStringField;
    P050VALORE: TFloatField;
    P050TIPO: TStringField;
    selP032: TOracleDataSet;
    DSuperoGiorni: TDataSource;
    QSuperoGiorni: TOracleDataSet;
    QSuperoGiorniGIORNI: TFloatField;
    DM065: TDataSource;
    selM065: TOracleDataSet;
    DM066: TDataSource;
    selM066: TOracleDataSet;
    P050Est: TOracleDataSet;
    OperSQL: TOracleQuery;
    QM021: TOracleDataSet;
    QM021CODICE: TStringField;
    QM021DESCRIZIONE: TStringField;
    QM021DECORRENZA: TDateTimeField;
    QM021IMPORTO: TFloatField;
    QM021CODVOCEPAGHE: TStringField;
    QM021ARROTONDAMENTO: TStringField;
    QM052: TOracleDataSet;
    QM052PROGRESSIVO: TFloatField;
    QM052MESESCARICO: TDateTimeField;
    QM052MESECOMPETENZA: TDateTimeField;
    QM052DATADA: TDateTimeField;
    QM052ORADA: TStringField;
    QM052CODICEINDENNITAKM: TStringField;
    QM052KMPERCORSI: TFloatField;
    QM052IMPORTOINDENNITA: TFloatField;
    QM052codice: TStringField;
    QM052descrizione: TStringField;
    QM052importounitario: TFloatField;
    QM052decorrenza: TDateField;
    D052: TDataSource;
    selM043: TOracleDataSet;
    selM043ID: TFloatField;
    selM043DATA: TDateTimeField;
    selM043DALLE: TStringField;
    selM043ALLE: TStringField;
    selM043NOTE: TStringField;
    dsrM043: TDataSource;
    QCommessa: TOracleDataSet;
    QSede: TOracleDataSet;
    SelM041: TOracleDataSet;
    SelM041TIPO1: TStringField;
    SelM041LOCALITA1: TStringField;
    SelM041PARTENZA: TStringField;
    SelM041TIPO2: TStringField;
    SelM041LOCALITA2: TStringField;
    SelM041DESTINAZIONE: TStringField;
    SelM041CHILOMETRI: TFloatField;
    DSelM041: TDataSource;
    SelM060: TOracleDataSet;
    InsM050: TOracleQuery;
    SelM020: TOracleDataSet;
    GrpM060: TOracleDataSet;
    selM021A: TOracleDataSet;
    UpdM060: TOracleQuery;
    SelT195: TOracleDataSet;
    SelM052: TOracleDataSet;
    UM052: TOracleQuery;
    selM043TIPO: TStringField;
    QM052STATO: TStringField;
    QM052NOTE: TStringField;
    QM052KMPERCORSI_ORIGINALI: TFloatField;
    Q050NOTE: TStringField;
    Q050STATO: TStringField;
    QM052D_STATO: TStringField;
    Q050ID_MISSIONE: TIntegerField;
    QM052ID_MISSIONE: TIntegerField;
    USR_M050P_CARICA_GIUST_DAITER: TOracleQuery;
    updM140Riapri: TOracleQuery;
    Q020TIPO_QUANTITA: TStringField;
    Q050TIPO_QUANTITA: TStringField;
    selM141: TOracleDataSet;
    selM141ID: TFloatField;
    selM141ORD: TIntegerField;
    selM141D_TAPPA: TStringField;
    selM141D_LOCALITA: TStringField;
    selM141IND_KM: TStringField;
    selM141TIPO_LOCALITA: TStringField;
    selM141LOCALITA: TStringField;
    selM141C_COD_COMUNE: TStringField;
    selM141NUMERO_RIGA2: TFloatField;
    dsrM141: TDataSource;
    cdsM141: TClientDataSet;
    cdsM141TAPPA: TStringField;
    cdsM141LOCALITA: TStringField;
    cdsM141IND_KM: TStringField;
    cdsM141KM: TIntegerField;
    cdsM141KM_IND: TIntegerField;
    cdsM141D_KM: TStringField;
    cdsM141D_KM_IND: TStringField;
    selLogRiaperture: TOracleDataSet;
    dsrLogRiaperture: TDataSource;
    selLogRiapertureID_MISSIONE: TStringField;
    selLogRiapertureID_LOG: TFloatField;
    selLogRiapertureDATA: TDateTimeField;
    selProtocolloUnique: TOracleQuery;
    procedure QM011FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure M049BeforePost(DataSet: TDataSet);
    procedure M051AfterDelete(DataSet: TDataSet);
    procedure M051IMPORTO_VALESTChange(Sender: TField);
    procedure M051sommaGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure M051BeforeDelete(DataSet: TDataSet);
    procedure M051BeforePost(DataSet: TDataSet);
    procedure D051DataChange(Sender: TObject; Field: TField);
    procedure Q050CODICERIMBORSOSPESEValidate(Sender: TField);
    procedure Q050IMPORTORIMBORSOSPESEChange(Sender: TField);
    procedure Q050IMPORTORIMBORSOSPESEValidate(Sender: TField);
    procedure Q050COD_VALUTA_ESTChange(Sender: TField);
    procedure Q050COD_VALUTA_ESTValidate(Sender: TField);
    procedure Q050IMPRIMB_VALESTChange(Sender: TField);
    procedure Q010AfterScroll(DataSet: TDataSet);
    procedure Q050AfterDelete(DataSet: TDataSet);
    procedure Q050AfterPost(DataSet: TDataSet);
    procedure Q050AfterScroll(DataSet: TDataSet);
    procedure Q050BeforeDelete(DataSet: TDataSet);
    procedure Q050BeforeInsert(DataSet: TDataSet);
    procedure Q050BeforePost(DataSet: TDataSet);
    procedure Q050ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure Q050NewRecord(DataSet: TDataSet);
    procedure QM052AfterDelete(DataSet: TDataSet);
    procedure QM052AfterPost(DataSet: TDataSet);
    procedure QM052BeforeDelete(DataSet: TDataSet);
    procedure QM052BeforePost(DataSet: TDataSet);
    procedure QM052NewRecord(DataSet: TDataSet);
    procedure selM043DATAValidate(Sender: TField);
    procedure selM043DALLEValidate(Sender: TField);
    procedure selM043BeforePost(DataSet: TDataSet);
    procedure selM043NewRecord(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsM141CalcFields(DataSet: TDataSet);
  private
    dPv_DataCassa: TDateTime;
    dPv_DataCompetenza: TDateTime;
    EsisteDaA,CavalloMezzanotteOld,
    EsisteGGInt: Boolean;
    DataCorr: TDateTime;
    bWarning:boolean;
    ValutaTemp: string;
    TotaleRimborsi: Real;
    TotaleIndennitaKm: Real;
    CostoRimborsi: Real;
    RiduzionePasto: Boolean;
    SuperoHH: Boolean;
    SuperoGG: Boolean;
    SuperoHHGG: Boolean;
    sPv_CodiceRimborso, sPv_TipoParamentoRimborso: String;
    dPv_DataRimborso: TDateTime;
    FSelM040_Funzioni: TOracleDataset;
    selDatiBloccati: TDatiBloccati;
    A004MW: TA004FGiustifAssPresMW;
    IndennitaIntera: Boolean;
    TotaleIndennitaOrarie: Real;
    DataDa, DataDaOld, DataA,
    DataAOld, OraDa, OraDaOld, OraA, OraAOld: String;
    CopreDebito, OreMax: String;
    function ValToEuro(Value: Real): Real;
    procedure PulisciCampi;
    function EstArrotondamento(Valore: Real): Real;
    procedure CalcolaIndKmFromDataset(var kmPercorsi, importoIndennita: Double);
    procedure ControlliObbligatorieta;
    procedure ControlloDatiBloccati;
    function CalcolaDurataArrotondata(DataDa, OraDa, DataA, OraA: string): integer;
    function TO_ZOO_PROFRimborsi: Real;
    function ControlliFormali(bGeneraErrore: Boolean): Boolean;
    procedure CalcolaMissioni;
    function CtrlProtocolloUnivoco(const PId: Integer; const PProtocollo: String; out RErrMsg: String): Boolean;
  public
    Inserire, Cancellare: Boolean;
    nLunghezzaCommessa, nLunghezzaPartenza:integer;
    nPb_Arrotondamento: Real;
    bPv_SegnalazionePasto: Boolean;
    bPb_RimborsoPastoEsistente:boolean;
    bIndennitaSupMaxGG: boolean;
    sPb_Tipo: String;
    RegoleTrovate: Boolean;
    bPv_RicalcoloIndennitaKm: Boolean;
    MessaggioAvviso: TMessaggioAvviso;
    MostraColonne: TMostraColonne;
    Q010Scroll: TProcedure;
    ImpostaCampiElaboraMissione: TProcedure;
    Azione, Causale, CausaleOld: String;
    TabTariffe: Boolean;
    procedure M040DATAAValidate;
    procedure M040DATADAValidate;
    procedure CambioDate;
    procedure GetArrotondamento(Codice: string; Data: TDateTime);
    procedure GetCommessa(Prog: integer; DaData, AData: TDateTime;var sCodiceCommessa, sDescrizione: String);
    procedure GetSede(Prog: integer; DaData, AData: TDateTime; var sCodiceSede,sDescrizione: String);
    procedure AggiornaDati;
    procedure AggiornaQueryCombo;
    procedure selM040AfterScroll;
    function CaptionTariffaOraria: String;
    function CaptionTariffaQuotaEsente: String;
    procedure CalcolaTotaliIndennitaOrarie;
    procedure CalcolaTotaliIndennitaKm;
    procedure CalcolaTotaleRimborsi;
    procedure LeggiParametri(Data: TDateTime; TipoRegistazione: string; VisualizzaMessaggio: Boolean = True);
    procedure M040AfterOpen;
    procedure M040INDINTERAValidate;
    procedure M040INDRIDOTTAHValidate;
    procedure M040INDRIDOTTAGValidate;
    procedure M040INDRIDOTTAHGValidate;
    procedure ImpostaQSourceDestinazione;
    procedure M040MESESCARICOValidate;
    procedure InizializzaM066;
    procedure ImpostaSelM041;
    procedure FiltraRegoleIndennita(bApplica:Boolean = True);
    procedure FiltraRegoleRimborsi(bApplica:Boolean = True);
    procedure M040ORAValidate(Sender: TField);
    procedure VerificaRimborsoPastoEsistente;
    function VerificaDettaglioRimborsi: String;
    procedure ElaboraDaTariffe;
    procedure ElaboraMissione;
    function CostiDettaglio: TCostiDettaglio;
    function GestioneMese: String;
    function RicalcolaDeleteRimborso(bSegnalazionePastoOldValue: boolean): String;
    procedure M040BeforePostPasso1;
    function M040BeforePostPasso2:String;
    function M040AfterPostPasso1: String;
    function M040AfterPostPasso2:String;
    function M040AfterPostPasso3:String;
    function M040AfterPostPasso4:boolean;
    procedure M040AfterPostPasso5;
    procedure M040AfterPostPasso6(AzioneApp:String);
    procedure M040BeforeEdit;
    procedure M040BeforeDelete;
    procedure M040NewRecord;
    function M040FiltroDizionario: Boolean;
    procedure M040Apply(Action: String);
    procedure M040PostError(E: EDatabaseError);
    function TestMeseScarico: Boolean;
    function AnticipiDaUnire: String;
    function AnticipiSospesi: String;
    function UnisciAnticipi: String;
    procedure RicalcolaIndennitaKM;
    function GetIndennitaKm(const NumKm: double; const Codice: String; const DataRif: TDateTime): double;
    property SelM040_Funzioni: TOracleDataset read FSelM040_Funzioni write FSelM040_Funzioni;
    procedure AggGiustServiziAttivi;
    procedure RiapriRichiestaMissione;
    procedure ApriDatasetPercorso(PId: Integer);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA100FMissioniMW.DataModuleCreate(Sender: TObject);
var
  Progressivo: Integer;
  Year, Month, Day: Word;
begin
  inherited;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  selDatiBloccati.TipoLog:='M';

  nLunghezzaCommessa:=0;
  nLunghezzaPartenza:=0;
  bIndennitaSupMaxGG:=False;

  M051.setVariable('ORDERBY','ORDER BY M051.DATARIMBORSO ASC, M051.IMPORTO ASC');
  M051.FieldByName('descTipoRimborso').LookupDataSet:=M049;
  M051.FieldByName('SOMMA').LookupDataSet:=M049;

  QM052.FieldByName('CODICE').LookupDataSet:=QM021;
  QM052.FieldByName('DESCRIZIONE').LookupDataSet:=QM021;
  QM052.FieldByName('IMPORTOUNITARIO').LookupDataSet:=QM021;
  QM052.FieldByName('DECORRENZA').LookupDataSet:=QM021;

  Progressivo:=0;
  if SelAnagrafe <> nil then
    Progressivo:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;

  if Parametri.CampiRiferimento.C8_Missione <> '' then
  begin
    QM011.SetVariable('PROGRESSIVO', Progressivo);
    QM011.SetVariable('DATA', Parametri.DataLavoro);
    QM011.SetVariable('C8_MISSIONI', Parametri.CampiRiferimento.C8_Missione);
    QM011.Open;
  end;

  Q020.Open;
  M049.Open;

  Q050.setVariable('ORDERBY','ORDER BY M050.CODICERIMBORSOSPESE');

  Q050.FieldByName('DESCRIZIONE').LookupDataSet:=Q020;
  Q050.FieldByName('CODICEVOCEPAGHE').LookupDataSet:=Q020;
  Q050.FieldByName('ESISTENZAINDENNITASUPPL').LookupDataSet:=Q020;
  Q050.FieldByName('CODICEVOCEPAGHEINDENNITASUPPL').LookupDataSet:=Q020;
  Q050.FieldByName('TIPO').LookupDataSet:=Q020;
  Q050.FieldByName('TIPO_QUANTITA').LookupDataSet:=Q020;
  Q050.FieldByName('FLAG_ANTICIPO').LookupDataSet:=Q020;
  Q050.FieldByName('CODRIMBORSO').LookupDataSet:=Q020;
  Q050.FieldByName('DESCRIMBORSO').LookupDataSet:=Q020;

  if A000LookupTabella(Parametri.CampiRiferimento.C8_MissioneCommessa,QCommessa) then
  begin
    if QCommessa.VariableIndex('DECORRENZA') >= 0 then
      QCommessa.SetVariable('DECORRENZA', Parametri.DataLavoro);
    QCommessa.Close;
    QCommessa.Open;
    nLunghezzaCommessa:=QCommessa.FieldByName('CODICE').Size;
  end
  else
  begin
    nLunghezzaCommessa:=0;
    QCommessa.SQL.Clear;
    QCommessa.DeleteVariables;
    QCommessa.SQL.Add('SELECT NULL CODICE,NULL DESCRIZIONE FROM DUAL');
    QCommessa.Close;
    QCommessa.Open;
  end;

  if A000LookupTabella(Parametri.CampiRiferimento.C8_Sede, QSede) then
  begin
    if QSede.VariableIndex('DECORRENZA') >= 0 then
      QSede.SetVariable('DECORRENZA', Parametri.DataLavoro);
    if Parametri.CampiRiferimento.C8_Sede = 'COMUNE' then
      QSede.ReadBuffer:=10000
    else
      QSede.ReadBuffer:=1000;
    QSede.Close;
    QSede.Open;
    nLunghezzaPartenza:=QSede.FieldByName('CODICE').Size;
  end
  else
  begin
    nLunghezzaPartenza:=0;
    QSede.SQL.Clear;
    QSede.DeleteVariables;
    QSede.SQL.Add('SELECT NULL CODICE,NULL DESCRIZIONE FROM DUAL');
    QSede.Close;
    QSede.Open;
  end;
 (* impostare sempre le variabili altrimenti
  errore se progetto singolo e faccio nuovo record su un dipendente che non ha elementi
  *)
  // ==============================
  // VALORIZZO DCMBLOOKUPCODTTARIFF
  // ==============================
  selM065.Close;
  selM065.SetVariable('DATOLIB', Parametri.CampiRiferimento.C8_Missione);
  selM065.SetVariable('PROGRESSIVO', Progressivo);
  selM065.Open;

  selM043.SetVariable('ORDERBY','ORDER BY M043.DATA, M043.DALLE');

  A004MW:=TA004FGiustifAssPresMW.Create(nil);
  A004MW{A004DtM1}.Name:='A004DtM1';
  A004MW{A004DtM1}.R600DtM1.VisualizzaAnomalie:=False;
  with A004MW{A004DtM1} do
  begin
    chkNuovoPeriodo:=False;
    GestioneSingolaDM:=True;
    AnomalieInterattive:=False;
    EseguiCommit:=False;
    //***ProgressBar := nil;
    Chiamante:='A100';
    R600DtM1.VisualizzaAnomalie:=False;
    R600DtM1.AnomalieBloccanti:=True;
    R600DtM1.AnomalieNonBloccanti:='';
  end;

  SelT195.Open;
  if SelT195.FieldByName('DATARIF').AsString <> '' then
    dPv_DataCassa:=R180InizioMese(SelT195.FieldByName('DATARIF').AsDateTime)
  else
    dPv_DataCassa:=R180InizioMese(Parametri.DataLavoro);

  DecodeDate(dPv_DataCassa, Year, Month, Day);
  if Month = 1 then
    dPv_DataCompetenza:=EncodeDate(Year - 1, 12, 1)
  else
    dPv_DataCompetenza:=EncodeDate(Year, Month - 1, 1);
end;

procedure TA100FMissioniMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A004MW{A004DtM1});
  inherited;
end;

procedure TA100FMissioniMW.InizializzaM066;
var Progressivo: Integer;
begin
  Progressivo:=0;
  if SelAnagrafe <> nil then
    Progressivo:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  // ================================
  // VALORIZZO DCMBLOOKUPCODRIDUZIONE
  // ================================
  selM066.SetVariable('DATOLIB', Parametri.CampiRiferimento.C8_Missione);
  selM066.SetVariable('PROGRESSIVO', Progressivo);
  selM066.SetVariable('COD_TARIFF', FSelM040_Funzioni.FieldByName('COD_TARIFFA').AsString);
  selM066.Open;
end;

procedure TA100FMissioniMW.ImpostaQSourceDestinazione;
begin
  QSource.ReadBuffer:=5000;
  QSource.Close;
  QSource.SQL.Clear;
  QSource.DeleteVariables;
  QSource.SQL.Add('SELECT DISTINCT(DESTINAZIONE) AS DESTINAZIONE FROM M040_MISSIONI');
  QSource.SQL.Add('WHERE DESTINAZIONE IS NOT NULL');
  QSource.Open;
end;

procedure TA100FMissioniMW.D051DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  //per cloud il controllo fatto sui pulsanti di modifica e cancella.
  {$IFNDEF WEBPJ}
  M051.ReadOnly:=M051.FieldByName('IMPORTO').AsCurrency < 0;
  {$ENDIF}
end;

procedure TA100FMissioniMW.M049BeforePost(DataSet: TDataSet);
begin
  inherited;
  if (M049.FieldByName('SOMMA').AsString <> 'S') and (M049.FieldByName('SOMMA').AsString <> 'N') then
    raise Exception.Create(A000MSG_A100_ERR_RIMBORSA);
end;

procedure TA100FMissioniMW.M051AfterDelete(DataSet: TDataSet);
var
  TotRimborsiPasto, TotRimborsoGiorno, TotCostoGiorno,
  TotDaAddebitare: Currency;
  nProgRimborso: integer;
  bTotaleSuperato: Boolean;
begin
  inherited;
  if M051.RecordCount = 0 then
    exit;

  // GESTISCO LA CANCELLAZIONE DEL RIMBORSO PASTO...
  // Leggo i parametri alla data del rimborso...
  LeggiParametri(M051.FieldByName('DATARIMBORSO').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
  if (Q050.FieldByName('TIPO').AsString = M020TIPO_PASTO) then
  // E' previsto il rimborso pasto
  begin
    // ******************************** INIZIO CALCOLO DEL RIMBORSO SPETTANTE ****************************
    M013F_CALC_RIMB_PASTO.SetVariable('CODICE',Q010.FieldByName('CODICE').AsString);
    M013F_CALC_RIMB_PASTO.SetVariable('TIPOREGISTRAZIONE', Q010.FieldByName('TIPO_MISSIONE').AsString);
    // TotRimborsiPasto:=0;
    // Durata effettiva in minuti della misisone nel giorno del rimborso...
    if M051.FieldByName('DATARIMBORSO').AsDateTime = FSelM040_Funzioni.FieldByName('DATADA').AsDateTime then
    // se la data di rimborso è uguale alla data di inzio missione
    begin
      M013F_CALC_RIMB_PASTO.SetVariable('DATADA',FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
      M013F_CALC_RIMB_PASTO.SetVariable('ORADA', FSelM040_Funzioni.FieldByName('ORADA').AsString);
      if FSelM040_Funzioni.FieldByName('TOTALEGG').AsInteger = 1 then
      begin
        // Se la missione dura un solo giorno ne calcolo la durata
        M013F_CALC_RIMB_PASTO.SetVariable('ORAA', FSelM040_Funzioni.FieldByName('ORAA').AsString);
        M013F_CALC_RIMB_PASTO.SetVariable('DATAA',FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
      end
      else
      begin
        // Se la missione dura più giorni calcolo la durata del primo giorno dall'inizio a mezza notte...
        M013F_CALC_RIMB_PASTO.SetVariable('ORAA', '23.59');
        M013F_CALC_RIMB_PASTO.SetVariable('DATAA',
        FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
      end;
    end
    else if M051.FieldByName('DATARIMBORSO').AsDateTime = FSelM040_Funzioni.FieldByName('DATAA').AsDateTime then
    begin
      M013F_CALC_RIMB_PASTO.SetVariable('ORAA', FSelM040_Funzioni.FieldByName('ORAA').AsString);
      // se la data di rimborso è uguale alla data di fine missione
      if FSelM040_Funzioni.FieldByName('TOTALEGG').AsInteger = 1 then
      begin
        // Se la missione dura un solo giorno ne calcolo la durata
        M013F_CALC_RIMB_PASTO.SetVariable('DATADA', FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
        M013F_CALC_RIMB_PASTO.SetVariable('DATAA', FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
        M013F_CALC_RIMB_PASTO.SetVariable('ORADA', FSelM040_Funzioni.FieldByName('ORADA').AsString);
      end
      else
        // Se la missione dura più giorni calcolo la durata del primo giorno da mezza notte alla fine...
        M013F_CALC_RIMB_PASTO.SetVariable('DATADA', FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
        M013F_CALC_RIMB_PASTO.SetVariable('DATAA', FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
        M013F_CALC_RIMB_PASTO.SetVariable('ORADA', '00.00');
      end
    else
    begin
      // se la data di rimborso non è uguale nè alla data di inzio missione e nemmeno alla data di fine missione
      // significa che la missione dura più giorni per cui la durata della missione copre un giono intero
      M013F_CALC_RIMB_PASTO.SetVariable('DATADA', M051.FieldByName('DATARIMBORSO').AsString);
      M013F_CALC_RIMB_PASTO.SetVariable('DATAA', M051.FieldByName('DATARIMBORSO').AsString);
      M013F_CALC_RIMB_PASTO.SetVariable('ORADA', '00.00');
      M013F_CALC_RIMB_PASTO.SetVariable('ORAA', '23.59');
    end;
    try
      M013F_CALC_RIMB_PASTO.Execute;
    except
      on E: Exception do
        if Assigned(MessaggioAvviso) then
          MessaggioAvviso(E.Message);
    end;
    TotRimborsiPasto:=M013F_CALC_RIMB_PASTO.GetVariable('RESULT');
    // ********************************  FINE CALCOLO DEL RIMBORSO SPETTANTE ****************************
    if TotRimborsiPasto > 0 then
    begin
      GetArrotondamento(Q010.FieldByName('ARROTTARIFFADOPORIDUZIONE').AsString,M051.FieldByName('DATARIMBORSO').AsDateTime);
      TotRimborsiPasto:=R180Arrotonda(TotRimborsiPasto, nPb_Arrotondamento, sPb_Tipo);
    end;
    // Verifico che nello stesso giorno non ci siano altri rimborsi pasto e se li trovo faccio la somma...
    M051.AfterDelete:=nil;
    M051.BeforePost:=nil;
    TotRimborsoGiorno:=0;
    TotDaAddebitare:=0;
    TotCostoGiorno:=0;
    bTotaleSuperato:=False;

    // Elimino eventuali addebiti negativi esistenti in giornata
    M051.First;
    while not M051.Eof do
    begin
      if (M051IMPORTO.AsCurrency < 0) and
         (M051DATARIMBORSO.AsDateTime = dPv_DataRimborso) then
        M051.Delete
      else
        M051.Next;
    end;
    M051.First;
    // 1 - Faccio la somma dei rimborsi pasto del giorno
    while not M051.Eof do
    begin
      if (M051.FieldByName('DATARIMBORSO').AsDateTime = dPv_DataRimborso) then
      begin
        if (UpperCase(M051.FieldByName('somma').AsString) = 'S') then
        begin
          if not bTotaleSuperato then
          begin
            // Se non ho ancora superato il totale previsto per il rimborso pasto allora sonno tutti i rimborsi pasto
            // sino a quando supero il totale...
            TotRimborsoGiorno:=TotRimborsoGiorno + M051IMPORTO.AsCurrency;
            if TotRimborsoGiorno > TotRimborsiPasto then
            begin
              // Quando supero il totale forzo l'importo da rimborsare al residuo disponibile...
              bTotaleSuperato:=True;
              M051.Edit;
              M051IMPORTO.AsCurrency:=M051IMPORTO.AsCurrency + (TotRimborsiPasto - TotRimborsoGiorno);
              M051.Post;
            end;
          end
          else
          begin
            M051.Edit;
            M051.FieldByName('IMPORTO').AsInteger:=0;
            M051.Post;
          end;
        end;
        TotCostoGiorno:=TotCostoGiorno + M051IMPORTO.AsCurrency;
      end;
      M051.Next;
    end;

    // 2 - Controllo se maggiore del totale...
    if TotCostoGiorno > TotRimborsiPasto then
      TotDaAddebitare:=TotRimborsiPasto - TotCostoGiorno;

    if TotDaAddebitare < 0 then
    begin
      // Leggo il progressivo disponibile per il rimborso
      M051A.Close;
      if (M051A.GetVariable('PROGRESSIVO') <> M051.FieldByName('PROGRESSIVO').AsInteger) or
         (M051A.GetVariable('MESESCARICO') <> M051.FieldByName('MESESCARICO').AsDateTime) or
         (M051A.GetVariable('MESECOMPETENZA') <> M051.FieldByName('MESECOMPETENZA').AsDateTime) or
         (M051A.GetVariable('DATADA') <> M051.FieldByName('DATADA').AsDateTime) or
         (M051A.GetVariable('ORADA') <> M051.FieldByName('ORADA').AsString) or
         (M051A.GetVariable('CODICERIMBORSOSPESE') <> M051.FieldByName('CODICERIMBORSOSPESE').AsString) or
         (M051A.GetVariable('DATARIMBORSO') <> M051.FieldByName('DATARIMBORSO').AsDateTime)
        then
      begin
        M051A.SetVariable('PROGRESSIVO', M051.FieldByName('PROGRESSIVO').AsInteger);
        M051A.SetVariable('MESESCARICO', M051.FieldByName('MESESCARICO').AsDateTime);
        M051A.SetVariable('MESECOMPETENZA', M051.FieldByName('MESECOMPETENZA').AsDateTime);
        M051A.SetVariable('DATADA', M051.FieldByName('DATADA').AsDateTime);
        M051A.SetVariable('ORADA', M051.FieldByName('ORADA').AsString);
        M051A.SetVariable('CODICERIMBORSOSPESE', M051.FieldByName('CODICERIMBORSOSPESE').AsString);
        M051A.SetVariable('DATARIMBORSO', M051.FieldByName('DATARIMBORSO').AsDateTime);
      end;
      M051A.Open;
      nProgRimborso:=M051A.FieldByName('progrimborso').AsInteger + M051.RecNo;
      // Fine lettura il progressivo disponibile per il rimborso

      M051.Insert;
      M051.FieldByName('PROGRESSIVO').AsInteger:=Q050.FieldByName('PROGRESSIVO').AsInteger;
      M051.FieldByName('MESESCARICO').AsDateTime:=Q050.FieldByName('MESESCARICO').AsDateTime;
      M051.FieldByName('MESECOMPETENZA').AsDateTime:=Q050.FieldByName('MESECOMPETENZA').AsDateTime;
      M051.FieldByName('DATADA').AsDateTime:=Q050.FieldByName('DATADA').AsDateTime;
      M051.FieldByName('ORADA').AsString:=Q050.FieldByName('ORADA').AsString;
      M051.FieldByName('CODICERIMBORSOSPESE').AsString:=Q050.FieldByName('CODICERIMBORSOSPESE').AsString;
      M051.FieldByName('PROGRIMBORSO').AsInteger:=nProgRimborso;
      M051.FieldByName('DATARIMBORSO').AsDateTime:=dPv_DataRimborso;
      M051.FieldByName('IMPORTO').AsCurrency:=TotDaAddebitare;
      M051.FieldByName('TIPORIMBORSO').AsString:='DEBIT';
      M051.Post;
    end;

    M051.AfterDelete:=M051AfterDelete;
    M051.BeforePost:=M051BeforePost;
  end;
end;

procedure TA100FMissioniMW.M051BeforeDelete(DataSet: TDataSet);
begin
  sPv_CodiceRimborso:=M051.FieldByName('CODICERIMBORSOSPESE').AsString;
  dPv_DataRimborso:=M051.FieldByName('DATARIMBORSO').AsDateTime;
  sPv_TipoParamentoRimborso:=UpperCase(M051.FieldByName('somma').AsString);
end;

procedure TA100FMissioniMW.M051BeforePost(DataSet: TDataSet);
var
  TotRimborsiPasto, TotRimborsoGiorno, TotCostoGiorno,
  TotDaAddebitare: Currency;
  nProgRimborso: integer;
  SavePlace: TBookmark;
  dDataRimborso: TDateTime;
  bTotaleSuperato: Boolean;
  sTipoParamentoRimborso: string;
begin
  if M051.FieldByName('DATARIMBORSO').IsNull then
    raise Exception.Create(A000MSG_A100_ERR_NO_DATA_RIMB)
  else if M051.FieldByName('DATARIMBORSO').AsDateTime < FSelM040_Funzioni.FieldByName('DATADA').AsDateTime then
    raise Exception.Create(A000MSG_A100_ERR_DATA_RIMB_ANTE)
  else if M051.FieldByName('DATARIMBORSO').AsDateTime > FSelM040_Funzioni.FieldByName('DATAA').AsDateTime then
    raise Exception.Create(A000MSG_A100_ERR_DATA_RIMB_POST);
  if M051.FieldByName('TIPORIMBORSO').IsNull then
    raise Exception.Create(A000MSG_A100_ERR_NO_MOD_PAG);
  if (M051.FieldByName('IMPORTO').IsNull) or (M051.FieldByName('IMPORTO').AsCurrency = 0) then
    raise Exception.Create(A000MSG_A100_ERR_NO_IMP_RIMB);
  if (M051.FieldByName('IMPORTO').AsCurrency < 0) then
    raise Exception.Create(A000MSG_A100_ERR_IMP_RIMB_NEG);

  M051.FieldByName('PROGRESSIVO').AsInteger:=Q050.FieldByName('PROGRESSIVO').AsInteger;
  M051.FieldByName('MESESCARICO').AsDateTime:=Q050.FieldByName('MESESCARICO').AsDateTime;
  M051.FieldByName('MESECOMPETENZA').AsDateTime:=Q050.FieldByName('MESECOMPETENZA').AsDateTime;
  M051.FieldByName('DATADA').AsDateTime:=Q050.FieldByName('DATADA').AsDateTime;
  M051.FieldByName('ORADA').AsString:=Q050.FieldByName('ORADA').AsString;
  M051.FieldByName('CODICERIMBORSOSPESE').AsString:=Q050.FieldByName('CODICERIMBORSOSPESE').AsString;
  M051A.Close;
  if (M051A.GetVariable('PROGRESSIVO') <> M051.FieldByName('PROGRESSIVO').AsInteger) or
     (M051A.GetVariable('MESESCARICO') <> M051.FieldByName('MESESCARICO').AsDateTime) or
     (M051A.GetVariable('MESECOMPETENZA') <> M051.FieldByName('MESECOMPETENZA').AsDateTime) or
     (M051A.GetVariable('DATADA') <> M051.FieldByName('DATADA').AsDateTime) or
     (M051A.GetVariable('ORADA') <> M051.FieldByName('ORADA').AsString) or
     (M051A.GetVariable('CODICERIMBORSOSPESE') <> M051.FieldByName('CODICERIMBORSOSPESE').AsString) or
     (M051A.GetVariable('DATARIMBORSO') <> M051.FieldByName('DATARIMBORSO').AsDateTime) then
  begin
    M051A.SetVariable('PROGRESSIVO', M051.FieldByName('PROGRESSIVO').AsInteger);
    M051A.SetVariable('MESESCARICO', M051.FieldByName('MESESCARICO').AsDateTime);
    M051A.SetVariable('MESECOMPETENZA', M051.FieldByName('MESECOMPETENZA').AsDateTime);
    M051A.SetVariable('DATADA', M051.FieldByName('DATADA').AsDateTime);
    M051A.SetVariable('ORADA', M051.FieldByName('ORADA').AsString);
    M051A.SetVariable('CODICERIMBORSOSPESE', M051.FieldByName('CODICERIMBORSOSPESE').AsString);
    M051A.SetVariable('DATARIMBORSO', M051.FieldByName('DATARIMBORSO').AsDateTime);
  end;

  M051A.Open;
  nProgRimborso:=M051A.FieldByName('progrimborso').AsInteger + M051.RecNo;
  M051.FieldByName('PROGRIMBORSO').AsInteger:=nProgRimborso;

  // GESTISCO I RIMBORSI PASTO
  // Leggo i parametri alla data del rimborso...
  LeggiParametri(M051.FieldByName('DATARIMBORSO').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
  if (Q050.FieldByName('TIPO').AsString = M020TIPO_PASTO) then
  // E' previsto il rimborso pasto
  begin
    if Parametri.RagioneSociale <> 'ISTITUTO ZOOPROFILATTICO SPERIMENTALE del Piemonte-Liguria-Valle D''aosta' then
    begin
      // ******************************** INIZIO CALCOLO DEL RIMBORSO SPETTANTE ****************************
      M013F_CALC_RIMB_PASTO.SetVariable('CODICE', Q010.FieldByName('CODICE').AsString);
      M013F_CALC_RIMB_PASTO.SetVariable('TIPOREGISTRAZIONE', Q010.FieldByName('TIPO_MISSIONE').AsString);
      TotRimborsiPasto:=0;
      // Durata effettiva in minuti della misisone nel giorno del rimborso...
      if M051.FieldByName('DATARIMBORSO').AsDateTime = FSelM040_Funzioni.FieldByName('DATADA').AsDateTime then
      // se la data di rimborso è uguale alla data di inzio missione
      begin
        M013F_CALC_RIMB_PASTO.SetVariable('DATADA',FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
        M013F_CALC_RIMB_PASTO.SetVariable('ORADA',FSelM040_Funzioni.FieldByName('ORADA').AsString);
        if FSelM040_Funzioni.FieldByName('TOTALEGG').AsInteger = 1 then
        begin
          // Se la missione dura un solo giorno ne calcolo la durata
          M013F_CALC_RIMB_PASTO.SetVariable('ORAA', FSelM040_Funzioni.FieldByName('ORAA').AsString);
          M013F_CALC_RIMB_PASTO.SetVariable('DATAA',FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
        end
        else
        begin
          // Se la missione dura più giorni calcolo la durata del primo giorno dall'inizio a mezza notte...
          M013F_CALC_RIMB_PASTO.SetVariable('ORAA', '23.59');
          M013F_CALC_RIMB_PASTO.SetVariable('DATAA',
          FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
        end;
      end
      else if M051.FieldByName('DATARIMBORSO').AsDateTime = FSelM040_Funzioni.FieldByName('DATAA').AsDateTime then
      begin
        M013F_CALC_RIMB_PASTO.SetVariable('ORAA',FSelM040_Funzioni.FieldByName('ORAA').AsString);
        // se la data di rimborso è uguale alla data di fine missione
        if FSelM040_Funzioni.FieldByName('TOTALEGG').AsInteger = 1 then
        begin
          // Se la missione dura un solo giorno ne calcolo la durata
          M013F_CALC_RIMB_PASTO.SetVariable('DATADA',FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
          M013F_CALC_RIMB_PASTO.SetVariable('DATAA', FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
          M013F_CALC_RIMB_PASTO.SetVariable('ORADA', FSelM040_Funzioni.FieldByName('ORADA').AsString);
        end
        else
          // Se la missione dura più giorni calcolo la durata del primo giorno da mezza notte alla fine...
          M013F_CALC_RIMB_PASTO.SetVariable('DATADA',FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
        M013F_CALC_RIMB_PASTO.SetVariable('DATAA', FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
        M013F_CALC_RIMB_PASTO.SetVariable('ORADA', '00.00');
      end
      else
      begin
        // se la data di rimborso non è uguale nè alla data di inzio missione e nemmeno alla data di fine missione
        // significa che la missione dura più giorni per cui la durata della missione copre un giono intero
        M013F_CALC_RIMB_PASTO.SetVariable('DATADA',M051.FieldByName('DATARIMBORSO').AsString);
        M013F_CALC_RIMB_PASTO.SetVariable('DATAA',M051.FieldByName('DATARIMBORSO').AsString);
        M013F_CALC_RIMB_PASTO.SetVariable('ORADA', '00.00');
        M013F_CALC_RIMB_PASTO.SetVariable('ORAA', '23.59');
      end;
      try
        M013F_CALC_RIMB_PASTO.Execute;
      except
        on E: Exception do
          if Assigned(MessaggioAvviso) then
            MessaggioAvviso(E.Message);
      end;
      TotRimborsiPasto:=M013F_CALC_RIMB_PASTO.GetVariable('RESULT');
      // ********************************  FINE CALCOLO DEL RIMBORSO SPETTANTE ****************************
    end
    else
      TotRimborsiPasto:=TO_ZOO_PROFRimborsi;

    if TotRimborsiPasto > 0 then
    begin
      GetArrotondamento(Q010.FieldByName('ARROTTARIFFADOPORIDUZIONE').AsString,M051.FieldByName('DATARIMBORSO').AsDateTime);
      TotRimborsiPasto:=R180Arrotonda(TotRimborsiPasto, nPb_Arrotondamento, sPb_Tipo);
    end;
    // 1) Se l'importo inserito è > importo dovuto allora assegno importo dovuto solo se il tipo di pagamento è rimborsabile
    // Se si tratta, per es. di pagamento con carta di credito non devo troncare...
    // 1) Se l'importo inserito è <= importo dovuto allora mantengo importo assegnato
    if (M051.FieldByName('IMPORTO').AsCurrency > TotRimborsiPasto) and
       (UpperCase(M051.FieldByName('somma').AsString) = 'S') then
      M051.FieldByName('IMPORTO').AsCurrency:=TotRimborsiPasto;

    // Verifico che nello stesso giorno non ci siano altri rimborsi pasto e se li trovo faccio la somma...
    dDataRimborso:=M051.FieldByName('DATARIMBORSO').AsDateTime;
    sTipoParamentoRimborso:=UpperCase(M051.FieldByName('somma').AsString);
    SavePlace:=M051.GetBookmark;
	try { TODO : TEST IW 15 }
      M051.AfterDelete:=nil;
      M051.BeforePost:=nil;
      TotRimborsoGiorno:=0;
      TotDaAddebitare:=0;
      TotCostoGiorno:=0;
      bTotaleSuperato:=False;
      
      // Elimino eventuali addebiti negativi esistenti in giornata
      M051.First;
      while not M051.Eof do
      begin
        if (M051.FieldByName('IMPORTO').AsCurrency < 0) and
           (M051.FieldByName('DATARIMBORSO').AsDateTime = dDataRimborso) then
          M051.Delete
        else
          M051.Next;
      end;
      
      M051.First;
      // 1 - Faccio la somma dei rimborsi pasto del giorno
      while not M051.Eof do
      begin
        if (M051.FieldByName('DATARIMBORSO').AsDateTime = dDataRimborso) then
        begin
          if (UpperCase(M051.FieldByName('somma').AsString) = 'S') then
          begin
            if not bTotaleSuperato then
            begin
              // Se non ho ancora superato il totale previsto per il rimborso pasto allora sonno tutti i rimborsi pasto
              // sino a quando supero il totale...
              TotRimborsoGiorno:=TotRimborsoGiorno + M051.FieldByName('IMPORTO').AsCurrency;
              if TotRimborsoGiorno > TotRimborsiPasto then
              begin
                // Quando supero il totale forzo l'importo da rimborsare al residuo disponibile...
                bTotaleSuperato := True;
                M051.Edit;
                M051.FieldByName('IMPORTO').AsCurrency:=M051.FieldByName('IMPORTO').AsCurrency + (TotRimborsiPasto - TotRimborsoGiorno);
                M051.Post;
              end;
            end
            else
            begin
              M051.Edit;
              M051.FieldByName('IMPORTO').AsInteger:=0;
              M051.Post;
            end;
          end;
          TotCostoGiorno := TotCostoGiorno + M051IMPORTO.AsCurrency;
        end;
        M051.Next;
      end;
      
      // 2 - Controllo se maggiore del totale...
      if TotCostoGiorno > TotRimborsiPasto then
        TotDaAddebitare:=TotRimborsiPasto - TotCostoGiorno;
      
      if TotDaAddebitare < 0 then
      begin
        M051.Insert;
        M051.FieldByName('PROGRESSIVO').AsInteger:=Q050.FieldByName('PROGRESSIVO').AsInteger;
        M051.FieldByName('MESESCARICO').AsDateTime:=Q050.FieldByName('MESESCARICO').AsDateTime;
        M051.FieldByName('MESECOMPETENZA').AsDateTime:=Q050.FieldByName('MESECOMPETENZA').AsDateTime;
        M051.FieldByName('DATADA').AsDateTime:=Q050.FieldByName('DATADA').AsDateTime;
        M051.FieldByName('ORADA').AsString:=Q050.FieldByName('ORADA').AsString;
        M051.FieldByName('CODICERIMBORSOSPESE').AsString:=Q050.FieldByName('CODICERIMBORSOSPESE').AsString;
        M051.FieldByName('PROGRIMBORSO').AsInteger:=nProgRimborso + 1;
        M051.FieldByName('DATARIMBORSO').AsDateTime:=dDataRimborso;
        M051.FieldByName('IMPORTO').AsCurrency:=TotDaAddebitare;
        M051.FieldByName('TIPORIMBORSO').AsString:='DEBIT';
        M051.Post;
      end;
      
      M051.GotoBookmark(SavePlace);
	finally
      M051.FreeBookmark(SavePlace);
	end;
    if sTipoParamentoRimborso = 'S' then
      M051.FieldByName('IMPORTO').AsCurrency:=M051.FieldByName('IMPORTO').AsCurrency + TotDaAddebitare;

    M051.AfterDelete:=M051AfterDelete;
    M051.BeforePost:=M051BeforePost;
  end;
  inherited;
end;

procedure TA100FMissioniMW.M051IMPORTO_VALESTChange(Sender: TField);
var
  ImpTemp: Real;
begin
  inherited;
  if (M051.FieldByName('IMPORTO_VALEST').OldValue <> M051.FieldByName
      ('IMPORTO_VALEST').Value) and Not
    (Q050.FieldByName('COD_VALUTA_EST').IsNull) then
  begin
    ImpTemp:=ValToEuro(M051.FieldByName('IMPORTO_VALEST').AsFloat);
    if ImpTemp <> 0 then
      M051.FieldByName('IMPORTO').AsFloat:=ImpTemp;
  end;
end;

procedure TA100FMissioniMW.M051sommaGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.AsString = 'S' then
    Text:='Si'
  else if Sender.AsString = 'N' then
    Text:='No'
  else
    Text:='';
end;

procedure TA100FMissioniMW.Q010AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if Assigned(Q010Scroll) then
    Q010Scroll;
end;

procedure TA100FMissioniMW.Q050AfterDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TA100FMissioniMW.Q050AfterPost(DataSet: TDataSet);
begin
  inherited;
  CalcolaMissioni;
  RegistraLog.RegistraOperazione;
end;

procedure TA100FMissioniMW.Q050AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if M051.Active then
  begin
    M051.Filtered:=False;
    M051.Filter:='CODICERIMBORSOSPESE=''' + Q050.FieldByName('CODICERIMBORSOSPESE').AsString + '''';
    M051.Filtered:=True;
    //se i campi sono readonly in cloud la medpGrid non crea i componenti.
    //per cloud il readonly deve essere impostato sull'edit creato in  datset2componenti della grid.
    {$IFNDEF WEBPJ}
    Q050.FieldByName('IMPORTORIMBORSOSPESE').ReadOnly:=M051.RecordCount > 0;
    Q050.FieldByName('IMPORTOCOSTORIMBORSO').ReadOnly:=M051.RecordCount > 0;
    {$ENDIF}
  end;
  {$IFNDEF WEBPJ}
  Q050COD_VALUTA_ESTChange(nil);
  Q050.FieldByName('IMPORTOCOSTORIMBORSO').ReadOnly:=Q050.FieldByName('IMPORTOCOSTORIMBORSO').ReadOnly and
                                                     (VarToStr(Q020.Lookup('CODICE', Q050.FieldByName('CODICERIMBORSOSPESE').AsString, 'FLAG_ANTICIPO')) = 'S');
  {$ENDIF}
end;

procedure TA100FMissioniMW.Q050ApplyRecord(Sender: TOracleDataSet; Action: Char;
  var Applied: Boolean; var NewRowId: string);
begin
  inherited;
  if Action = 'U' then
  begin
    if Q050.FieldByName('CODICERIMBORSOSPESE').medpOldValue <> Q050.FieldByName('CODICERIMBORSOSPESE').AsString then
    begin
      M051.First;
      while not M051.Eof do
      begin
        M051.Edit;
        M051.FieldByName('CODICERIMBORSOSPESE').AsString:=Q050.FieldByName('CODICERIMBORSOSPESE').AsString;
        M051.Post;
        M051.Next;
      end;
    end;
  end
  else if Action = 'D' then
  begin
    OperSQL.SQL.Clear;
    OperSQL.SQL.Add('DELETE M051_DETTAGLIORIMBORSO');
    OperSQL.SQL.Add(' WHERE PROGRESSIVO = ' + Q050PROGRESSIVO.AsString);
    OperSQL.SQL.Add('   AND MESESCARICO = TO_DATE(''' + FormatDateTime('dd/mm/yyyy', Q050.FieldByName('MESESCARICO').AsDateTime) + ''', ''DD/MM/YYYY'')');
    OperSQL.SQL.Add('   AND MESECOMPETENZA = TO_DATE(''' + FormatDateTime('dd/mm/yyyy', Q050.FieldByName('MESECOMPETENZA').AsDateTime) + ''', ''DD/MM/YYYY'')');
    OperSQL.SQL.Add('   AND DATADA = TO_DATE(''' + FormatDateTime('dd/mm/yyyy', Q050.FieldByName('DATADA').AsDateTime) + ''', ''DD/MM/YYYY'')');
    OperSQL.SQL.Add('   AND ORADA = ''' + Q050.FieldByName('ORADA').AsString + '''');
    OperSQL.SQL.Add('   AND CODICERIMBORSOSPESE = ''' + Q050.FieldByName('CODICERIMBORSOSPESE').AsString + '''');
    OperSQL.Execute;
  end;
end;

procedure TA100FMissioniMW.Q050BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('C', R180Query2NomeTabella(DataSet), NomeOwner, DataSet, True);
end;

procedure TA100FMissioniMW.Q050BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  ValutaTemp:=Q050.FieldByName('COD_VALUTA_EST').AsString;
end;

procedure TA100FMissioniMW.Q050BeforePost(DataSet: TDataSet);
var
  TotRimborsiPasto: Real;
begin
  inherited;
  if QueryPK1.EsisteChiave('M050_RIMBORSI',Q050.RowId,Q050.State,['PROGRESSIVO','MESESCARICO','MESECOMPETENZA','DATADA','ORADA','CODICERIMBORSOSPESE'],
                                                                 [Q050.FieldByName('Progressivo').AsString,
                                                                 Q050.FieldByName('MESESCARICO').AsString,
                                                                 Q050.FieldByName('MESECOMPETENZA').AsString,
                                                                 Q050.FieldByName('DATADA').AsString,
                                                                 Q050.FieldByName('ORADA').AsString,
                                                                 Q050.FieldByName('CODICERIMBORSOSPESE').AsString]) then
    raise Exception.Create(A000MSG_ERR_CODICE_ESISTENTE);

  if Q050.FieldByName('IMPORTORIMBORSOSPESE').AsString = '' then
    Q050.FieldByName('IMPORTORIMBORSOSPESE').AsInteger:=0;
  if Q050.FieldByName('IMPORTOINDENNITASUPPLEMENTARE').AsString = '' then
    Q050.FieldByName('IMPORTOINDENNITASUPPLEMENTARE').AsInteger:=0;

  if (Q050.FieldByName('CODICERIMBORSOSPESE').IsNull) and
     (Q050.FieldByName('IMPORTORIMBORSOSPESE').AsCurrency = 0) and
     (Q050.FieldByName('IMPORTOINDENNITASUPPLEMENTARE').AsCurrency = 0) and
     (Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsCurrency = 0) then
    raise Exception.Create(A000MSG_A100_ERR_DATI_NON_SIGNIFICATIVI);
  // GESTISCO I RIMBORSI PASTO
  // GetIndennita(C700Progressivo,m040DATAA.AsDateTime,m040DATAA.AsDateTime);
  LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
  // Verifico che il rimborso selezionato sia abilitato nelle regole missione
  if (Not Q010.FieldByName('CODICI_RIMBORSI').IsNull) and
     (pos(',' + Q050.FieldByName('CODICERIMBORSOSPESE').AsString + ',',',' + Q010.FieldByName('CODICI_RIMBORSI').AsString + ',') <= 0) then
    raise Exception.Create(A000MSG_A100_ERR_COD_RIMB_NON_ABIL);

  if (Q050.FieldByName('TIPO').AsString = M020TIPO_PASTO) and (M051.RecordCount = 0) then
  // E' previsto il rimborso pasto
  begin
    if Parametri.RagioneSociale = 'ISTITUTO ZOOPROFILATTICO SPERIMENTALE del Piemonte-Liguria-Valle D''aosta' then
      TotRimborsiPasto:=TO_ZOO_PROFRimborsi * FSelM040_Funzioni.FieldByName('TOTALEGG').AsInteger
    else
    begin
      // ******************************** INIZIO CALCOLO DEL RIMBORSO SPETTANTE ****************************
      M013F_CALC_RIMB_PASTO.SetVariable('CODICE', Q010.FieldByName('CODICE').AsString);
      M013F_CALC_RIMB_PASTO.SetVariable('TIPOREGISTRAZIONE',Q010.FieldByName('TIPO_MISSIONE').AsString);
      M013F_CALC_RIMB_PASTO.SetVariable('DATADA', FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
      M013F_CALC_RIMB_PASTO.SetVariable('DATAA', FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
      M013F_CALC_RIMB_PASTO.SetVariable('ORADA', FSelM040_Funzioni.FieldByName('ORADA').AsString);
      M013F_CALC_RIMB_PASTO.SetVariable('ORAA', FSelM040_Funzioni.FieldByName('ORAA').AsString);
      try
        M013F_CALC_RIMB_PASTO.Execute;
      except
        on E: Exception do
          MessaggioAvviso(e.Message);
      end;
      TotRimborsiPasto:=M013F_CALC_RIMB_PASTO.GetVariable('RESULT');
      // ********************************  FINE CALCOLO DEL RIMBORSO SPETTANTE ****************************
    end;
    if TotRimborsiPasto >= 0 then
    begin
      if TotRimborsiPasto > 0 then
      begin
        GetArrotondamento(Q010.FieldByName('ARROTTARIFFADOPORIDUZIONE').AsString, FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
        TotRimborsiPasto:=R180Arrotonda(TotRimborsiPasto,nPb_Arrotondamento, sPb_Tipo);
      end;
      // 1) Se l'importo inserito è > importo dovuto allora assegno importo dovuto
      // 1) Se l'importo inserito è <= importo dovuto allora mantengo importo assegnato
      if (Q050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat > TotRimborsiPasto) then
        Q050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat:=TotRimborsiPasto;
    end;
  end;
  if M051.RecordCount = 0 then
    if Q050.FieldByName('flag_anticipo').AsString = 'S' then
    begin
      Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsInteger:=0;
      Q050.FieldByName('COSTORIMB_VALEST').AsFloat:=0;
    end
    else
    begin
      if Q050.FieldByName('IMPORTOCOSTORIMBORSO').IsNull or
         (Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsFloat < Q050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat) then
        Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsFloat:=Q050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat;
      Q050.FieldByName('COSTORIMB_VALEST').AsFloat:=Q050.FieldByName('IMPRIMB_VALEST').AsFloat;
    end;
  Q050IMPORTORIMBORSOSPESEValidate(nil);
  case DataSet.State of
    dsEdit:
      RegistraLog.SettaProprieta('M', R180Query2NomeTabella(DataSet), NomeOwner, DataSet, True);
    dsInsert:
    RegistraLog.SettaProprieta('I', R180Query2NomeTabella(DataSet), NomeOwner, DataSet, True);
  end;
  // Gestione Valute estere
  Q050.FieldByName('IMPRIMB_VALEST').AsFloat:=EstArrotondamento(Q050.FieldByName('IMPRIMB_VALEST').AsFloat);
  Q050.FieldByName('COSTORIMB_VALEST').AsFloat:=EstArrotondamento(Q050.FieldByName('COSTORIMB_VALEST').AsFloat);

  if Q050.FieldByName('CODRIMBORSO').IsNull then
    Q050.Delete;
end;

procedure TA100FMissioniMW.Q050CODICERIMBORSOSPESEValidate(Sender: TField);
begin
  // controllo che il codice del rimborso sia presente nella tabella M050_RIMBORSI
  if (VarToStr(Q020.Lookup('CODICE', Q050.FieldByName('CODICERIMBORSOSPESE').AsString, 'CODICE')) = '') then
  begin
    // disabilito temporaneamente l'evento onValidate per evitare un loop che
    // mandi il programma in stack overflow
    Q050.FieldByName('CODICERIMBORSOSPESE').OnValidate:=nil;
    Q050.FieldByName('CODICERIMBORSOSPESE').Clear;
    Q050.FieldByName('CODICERIMBORSOSPESE').OnValidate:=Q050CODICERIMBORSOSPESEValidate;
    raise Exception.Create(A000MSG_A100_ERR_COD_RIMB_NO_ESISTE);
  end;
  //se i campi sono readonly in cloud la medpGrid non crea i componenti.
  //per cloud il readonly deve essere impostato sull'edit creato in  datset2componenti della grid.
  {$IFNDEF WEBPJ}
  Q050.FieldByName('IMPORTOCOSTORIMBORSO').ReadOnly:=(M051.RecordCount > 0) or (VarToStr(Q020.Lookup('CODICE', Q050.FieldByName('CODICERIMBORSOSPESE').AsString, 'FLAG_ANTICIPO')) = 'S');

  //Cloud scatenaa validate anche sul conferma della grid. questo controllo lo fa con queryPK nel beforePost
  countM050.Close;
  countM050.SetVariable('PROG', Q050.GetVariable('PROG'));
  countM050.SetVariable('MSCARICO', Q050.GetVariable('MSCARICO'));
  countM050.SetVariable('MCOMPETENZA', Q050.GetVariable('MCOMPETENZA'));
  countM050.SetVariable('DDA', Q050.GetVariable('DDA'));
  countM050.SetVariable('ODA', Q050.GetVariable('ODA'));
  countM050.SetVariable('CODICE', Q020.FieldByName('CODICE').AsString);
  countM050.Execute;
  if countM050.RowCount > 0 then
  begin
    if Assigned(MessaggioAvviso) then
      MessaggioAvviso(A000MSG_A100_ERR_COD_RIMB_GIA_INS);
    Abort;
  end;
  {$ENDIF}
  Q050IMPORTORIMBORSOSPESEValidate(nil);
end;

procedure TA100FMissioniMW.Q050COD_VALUTA_ESTChange(Sender: TField);
var
  Mostra: Boolean;
begin
  inherited;
  if Q050.Active then
  begin
    // ======================================================================
    // SE IL CODICE VALUTA E' = NULL NASCONDO I CAMPI DEI 2 RELATIVI RIMBORSI
    // E ANNULLO I LORO VALORI
    // ======================================================================
    //Mostra:=False;
    if (FSelM040_Funzioni.State <> dsBrowse)
    or (selCountM050.GetVariable('PROG') <> Q050.FieldByName('PROGRESSIVO').AsInteger)
    or (selCountM050.GetVariable('MSCARICO') <> Q050.FieldByName('MESESCARICO').AsDateTime)
    or (selCountM050.GetVariable('MCOMPETENZA') <> Q050.FieldByName('MESECOMPETENZA').AsDateTime)
    or (selCountM050.GetVariable('DDA') <> Q050.FieldByName('DATADA').AsDateTime)
    or (selCountM050.GetVariable('ODA') <> Q050.FieldByName('ORADA').AsString)
    then
    begin
      selCountM050.Close;
      selCountM050.SetVariable('PROG',Q050.FieldByName('PROGRESSIVO').AsInteger);
      selCountM050.SetVariable('MSCARICO',Q050.FieldByName('MESESCARICO').AsDateTime);
      selCountM050.SetVariable('MCOMPETENZA',Q050.FieldByName('MESECOMPETENZA').AsDateTime);
      selCountM050.SetVariable('DDA',Q050.FieldByName('DATADA').AsDateTime);
      selCountM050.SetVariable('ODA',Q050.FieldByName('ORADA').AsString);
      selCountM050.Execute;
    end;

    Mostra:=(selCountM050.FieldAsInteger(0) > 0) or (not Q050.FieldByName('COD_VALUTA_EST').IsNull);

    if Assigned(MostraColonne)then
      MostraColonne(Mostra);
    if (Mostra) and (Q050.State in [dsInsert, dsEdit]) then
    begin
      Q050.FieldByName('COSTORIMB_VALEST').AsString:='';
      Q050.FieldByName('IMPRIMB_VALEST').AsString:='';
    end;
  end;
end;

procedure TA100FMissioniMW.Q050COD_VALUTA_ESTValidate(Sender: TField);
begin
  inherited;
  if (Q050.FieldByName('COD_VALUTA_EST').IsNull) or
     (Q050.FieldByName('COD_VALUTA_EST').AsString = '') then
    exit;
  SelP030.Close;
  SelP030.SetVariable('DATADA', FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
  SelP030.Open;
  if (VarToStr(SelP030.Lookup('COD_VALUTA', Q050.FieldByName('COD_VALUTA_EST').AsString, 'COD_VALUTA')) = '')
  then
  begin
    Q050.FieldByName('COD_VALUTA_EST').Clear;
    raise Exception.Create(A000MSG_A100_ERR_COD_VALUTA);
  end;
end;

procedure TA100FMissioniMW.Q050IMPORTORIMBORSOSPESEChange(Sender: TField);
var
  Importo: Real;
begin
  inherited;
  if M051.RecordCount = 0 then
    if Q050.FieldByName('flag_anticipo').AsString = 'S' then
    begin
      Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsInteger:=0;
      Q050.FieldByName('COSTORIMB_VALEST').AsFloat:=0;
    end
    else if Q050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat >= Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsFloat then
    begin
      Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsFloat:=Q050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat;
      Q050.FieldByName('COSTORIMB_VALEST').AsFloat:=Q050.FieldByName('IMPRIMB_VALEST').AsFloat;
    end;
  if (Q050.ReadOnly = False) then
  begin
    Q050.FieldByName('IMPORTOINDENNITASUPPLEMENTARE').AsInteger:=0;
    if Q020.SearchRecord('CODICE', Q050.FieldByName('CODICERIMBORSOSPESE').AsVariant,[srFromBeginning]) then
    begin
      if (Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsString <> '') and
         (Q020.FieldByName('ESISTENZAINDENNITASUPPL').AsString = 'S') then
      begin
        // Leggo il valore numerico dell'arrotondamento dalla tabellaP050 passando il codice di
        // arrotondamento e la data di decorrenza
        GetArrotondamento(Q020.FieldByName('ARROTINDENNITASUPPL').AsString, FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
        Importo:=((Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsFloat *
                   Q020.FieldByName('PERCINDENNITASUPPL').AsFloat) / 100);
        Q050.FieldByName('IMPORTOINDENNITASUPPLEMENTARE').AsFloat:=R180Arrotonda(Importo,nPb_Arrotondamento, sPb_Tipo);
      end;
    end;
  end;
end;

procedure TA100FMissioniMW.Q050IMPORTORIMBORSOSPESEValidate(Sender: TField);
var
  Importo: Real;
begin
  if (Q050.ReadOnly = False) then
  begin
    Q050.FieldByName('IMPORTOINDENNITASUPPLEMENTARE').AsInteger:=0;
    if Q020.SearchRecord('CODICE', Q050.FieldByName('CODICERIMBORSOSPESE').AsVariant, [srFromBeginning]) then
    begin
      if (Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsString <> '') and
         (Q020.FieldByName('ESISTENZAINDENNITASUPPL').AsString = 'S') then
      begin
        // Leggo il valore numerico dell'arrotondamento dalla tabellaP050 passando il codice di
        // arrotondamento e la data di decorrenza
        GetArrotondamento(Q020.FieldByName('ARROTINDENNITASUPPL').AsString, FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
        Importo:=((Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsFloat *
                   Q020.FieldByName('PERCINDENNITASUPPL').AsFloat) / 100);
        Q050.FieldByName('IMPORTOINDENNITASUPPLEMENTARE').AsFloat:=R180Arrotonda(Importo,nPb_Arrotondamento, sPb_Tipo);
      end;
    end;
  end;
end;

procedure TA100FMissioniMW.Q050IMPRIMB_VALESTChange(Sender: TField);
var
  ImpTemp: Real;
begin
  inherited;
  if (Q050.FieldByName('IMPRIMB_VALEST').OldValue <> Q050.FieldByName('IMPRIMB_VALEST').Value) and
      Not (Q050.FieldByName('COD_VALUTA_EST').IsNull) then
  begin
    ImpTemp:=ValToEuro(Q050.FieldByName('IMPRIMB_VALEST').AsFloat);
    if ImpTemp <> 0 then
      Q050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat := ImpTemp;
  end;

  if M051.RecordCount = 0 then
    if Q050flag_anticipo.AsString = 'S' then
      Q050.FieldByName('COSTORIMB_VALEST').AsFloat := 0
    else
      Q050.FieldByName('COSTORIMB_VALEST').AsFloat := Q050.FieldByName('IMPRIMB_VALEST').AsFloat;

  if (Q050.FieldByName('COSTORIMB_VALEST').OldValue <> Q050.FieldByName('COSTORIMB_VALEST').Value) and
      Not(Q050.FieldByName('COD_VALUTA_EST').IsNull) then
  begin
    ImpTemp:=ValToEuro(Q050.FieldByName('COSTORIMB_VALEST').AsFloat);
    if ImpTemp <> 0 then
      Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsFloat := ImpTemp;
  end;
end;

procedure TA100FMissioniMW.Q050NewRecord(DataSet: TDataSet);
begin
  inherited;
  Q050.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  Q050.FieldByName('ID_MISSIONE').AsInteger:=FSelM040_Funzioni.FieldByName('ID_MISSIONE').AsInteger;
  Q050.FieldByName('MESESCARICO').AsDateTime:=FSelM040_Funzioni.FieldByName('MESESCARICO').AsDateTime;
  Q050.FieldByName('MESECOMPETENZA').AsDateTime:=FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsDateTime;
  Q050.FieldByName('DATADA').AsDateTime:=FSelM040_Funzioni.FieldByName('DATADA').AsDateTime;
  Q050.FieldByName('ORADA').AsString:=FSelM040_Funzioni.FieldByName('ORADA').AsString;
  Q050.FieldByName('IMPORTORIMBORSOSPESE').AsInteger:=0;
  Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsInteger:=0;
  Q050.FieldByName('COD_VALUTA_EST').AsString:=ValutaTemp;
end;

procedure TA100FMissioniMW.QM011FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('TIPOLOGIA TRASFERTA', DataSet.FieldByName('CODICE').AsString)
end;

procedure TA100FMissioniMW.QM052AfterDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TA100FMissioniMW.QM052AfterPost(DataSet: TDataSet);
begin
  inherited;
  CalcolaMissioni;
  RegistraLog.RegistraOperazione;
end;

procedure TA100FMissioniMW.QM052BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('C', R180Query2NomeTabella(DataSet), NomeOwner, DataSet, True);
end;

procedure TA100FMissioniMW.QM052BeforePost(DataSet: TDataSet);
begin
  inherited;
  //WA100 - Chiamata: 83638
  if QueryPK1.EsisteChiave('M052_INDENNITAKM ',QM052.RowId,QM052.State,['CODICEINDENNITAKM',
                                                                        'PROGRESSIVO',
                                                                        'MESESCARICO',
                                                                        'MESECOMPETENZA',
                                                                        'DATADA',
                                                                        'ORADA'
                                                                        ],
                                                                        [QM052.FieldByName('CODICE').AsString,
                                                                         SelAnagrafe.FieldByName('PROGRESSIVO').AsString,
                                                                         FSelM040_Funzioni.FieldByName('MESESCARICO').AsString,
                                                                         FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsString,
                                                                         FSelM040_Funzioni.FieldByName('DATADA').AsString,
                                                                         FSelM040_Funzioni.FieldByName('ORADA').AsString
                                                                         ]) then
    raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);

  if (QM052.FieldByName('codice').AsString <> '') and
     (QM052.FieldByName('KMPERCORSI').AsFloat <> 0) and
     (QM052.FieldByName('importounitario').AsFloat <> 0) then
  begin
    QM052.FieldByName('IMPORTOINDENNITA').AsFloat:=QM052.FieldByName('importounitario').AsFloat * QM052.FieldByName('KMPERCORSI').AsFloat;
    GetArrotondamento(QM021.FieldByName('ARROTONDAMENTO').AsString, FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
    QM052.FieldByName('IMPORTOINDENNITA').AsFloat:=R180Arrotonda(QM052.FieldByName('IMPORTOINDENNITA').AsFloat, nPb_Arrotondamento, sPb_Tipo);
  end
  else
    QM052.FieldByName('IMPORTOINDENNITA').AsInteger := 0;

  if (QM052.FieldByName('codiceindennitakm').IsNull) and
     (QM052.FieldByName('kmpercorsi').AsInteger = 0) and
     (QM052.FieldByName('importoindennita').AsCurrency = 0) then
    raise Exception.Create(A000MSG_A100_ERR_DATI_NON_SIGNIFICATIVI);

  case DataSet.State of
    dsEdit:
      RegistraLog.SettaProprieta('M', R180Query2NomeTabella(DataSet),NomeOwner, DataSet, True);
    dsInsert:
      RegistraLog.SettaProprieta('I', R180Query2NomeTabella(DataSet), NomeOwner, DataSet, True);
  end;
end;

procedure TA100FMissioniMW.QM052NewRecord(DataSet: TDataSet);
begin
  inherited;
  QM052.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  QM052.FieldByName('ID_MISSIONE').AsInteger:=FSelM040_Funzioni.FieldByName('ID_MISSIONE').AsInteger;
  QM052.FieldByName('MESESCARICO').AsDateTime:=FSelM040_Funzioni.FieldByName('MESESCARICO').AsDateTime;
  QM052.FieldByName('MESECOMPETENZA').AsDateTime:=FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsDateTime;
  QM052.FieldByName('DATADA').AsDateTime:=FSelM040_Funzioni.FieldByName('DATADA').AsDateTime;
  QM052.FieldByName('ORADA').AsString:=FSelM040_Funzioni.FieldByName('ORADA').AsString;
  QM052.FieldByName('KMPERCORSI').AsInteger:=0;
end;

procedure TA100FMissioniMW.selM043BeforePost(DataSet: TDataSet);
var
  Dalle, Alle: integer;
begin
  // data
  if selM043.FieldByName('DATA').IsNull then
    raise Exception.Create(A000MSG_A100_ERR_NO_DATA_ATTIVITA);

  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
  // tipo
  if selM043.FieldByName('TIPO').IsNull then
    raise Exception.Create(A000MSG_A100_ERR_NO_TIPO_DETT_MISSIONE);

  if (selM043.FieldByName('TIPO').AsString <> 'S') and
     (selM043.FieldByName('TIPO').AsString <> 'V') then
    raise Exception.Create(A000MSG_A100_ERR_TIPO_DETT_MISSIONE);

  if (SelM040_Funzioni.FieldByName('DATADA').AsDateTime = SelM040_Funzioni.FieldByName('DATAA').AsDateTime) and
     (selM043.FieldByName('TIPO').AsString <> 'S') then
    raise Exception.Create(A000MSG_A100_ERR_TIPO_DETT_MISSIONE_1GG);
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine

  // dalle
  if selM043.FieldByName('DALLE').IsNull then
    raise Exception.Create(A000MSG_A100_ERR_NO_ORA_INIZIO_ATTIVITA);
  R180OraValidate(selM043.FieldByName('DALLE').AsString);

  // alle
  if selM043.FieldByName('ALLE').IsNull then
    raise Exception.Create(A000MSG_A100_ERR_NO_ORA_FINE_ATTIVITA);
  R180OraValidate(selM043.FieldByName('ALLE').AsString);

  Dalle:=R180OreMinutiExt(selM043.FieldByName('DALLE').AsString);
  Alle:=R180OreMinutiExt(selM043.FieldByName('ALLE').AsString);

  // controlli ulteriori su dalle / alle
  if (selM043.FieldByName('DATA').AsDateTime = FSelM040_Funzioni.FieldByName('DATADA').AsDateTime) and
     (Dalle < R180OreMinutiExt(FSelM040_Funzioni.FieldByName('ORADA').AsString)) then
    raise Exception.Create(A000MSG_A100_ERR_ORA_INIZIO_ATTIVITA);
  if (selM043.FieldByName('DATA').AsDateTime = FSelM040_Funzioni.FieldByName('DATAA').AsDateTime) and
     (Alle > R180OreMinutiExt(FSelM040_Funzioni.FieldByName('ORAA').AsString)) then
    raise Exception.Create(A000MSG_A100_ERR_ORA_FINE_ATTIVITA);

  // coerenza dalle-alle se la trasferta è in giornata
  if (FSelM040_Funzioni.FieldByName('DATADA').AsDateTime = FSelM040_Funzioni.FieldByName('DATAA').AsDateTime) and
     (Dalle > Alle) then
    raise Exception.Create(A000MSG_A100_ERR_PERIODO_ATTIVITA);

  {
  // note non obbligatorie!
  if (selM043.FieldByName('NOTE').IsNull) or
     (trim(selM043.FieldByName('NOTE').AsString) = '') then
    raise Exception.Create(A000MSG_A100_ERR_NOTE_ATTIVITA);
  }

  // verifica intersezione periodi dalle - alle nel giorno (via query)
  with TOracleQuery.Create(Self) do
  try
    Session:=SessioneOracle;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*), MAX(DALLE || '' - '' || ALLE)');
    SQL.Add('FROM   M043_DETTAGLIOGG');
    SQL.Add('WHERE  ID = ' + selM043.FieldByName('ID').AsString);
    SQL.Add('AND    DATA = ' + DateToStr(selM043.FieldByName('DATA').AsDateTime).QuotedString);
    SQL.Add('AND    least(oreminuti(ALLE),' + inttostr(Alle) + ') - greatest(oreminuti(DALLE),' + inttostr(Dalle) + ') > 0 ');
    if selM043.State = dsEdit then
      SQL.Add('AND    ROWID <> ' + selM043.RowId.QuotedString);
    Execute;
    if FieldAsInteger(0) > 0 then
      raise Exception.Create(Format(A000MSG_A100_ERR_FMT_PERIODO_ATT_INTERS,[FieldAsString(1)]));
  finally
    Free;
  end;

  {
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
  // verifica presenza di una sola tipologia (servizio / viaggio) al giorno (via query)
  with TOracleQuery.Create(Self) do
  begin
    try
      Session:=SessioneOracle;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*)');
      SQL.Add('FROM   M043_DETTAGLIOGG');
      SQL.Add('WHERE  ID = ' + selM043.FieldByName('ID').AsString);
      SQL.Add('AND    DATA = ' + DateToStr(selM043.FieldByName('DATA').AsDateTime).QuotedString);
      SQL.Add('AND    TIPO <> ' + selM043.FieldByName('TIPO').AsString.QuotedString);
      if selM043.State = dsEdit then
        SQL.Add('AND    ROWID <> ' + selM043.RowId.QuotedString);
      Execute;
      if FieldAsInteger(0) > 0 then
        raise Exception.Create(A000MSG_A100_ERR_PERIODO_ATT_DIVERSE);
    finally
      Free;
    end;
  end;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine
  }
end;

procedure TA100FMissioniMW.selM043DALLEValidate(Sender: TField);
var
  Minuti: integer;
begin
  if not(Sender.IsNull) then
    R180OraValidate(Sender.AsString);

  Minuti:=R180OreMinutiExt(Sender.AsString);
  if Sender = selM043.FieldByName('DALLE') then
  begin
    // ora di inizio periodo
    if (selM043.FieldByName('DATA').AsDateTime = FSelM040_Funzioni.FieldByName('DATADA').AsDateTime) and
       (Minuti < R180OreMinutiExt(FSelM040_Funzioni.FieldByName('ORADA').AsString)) then
      raise Exception.Create(A000MSG_A100_ERR_ORA_INIZIO_ATTIVITA);
  end
  else
  begin
    // ora di fine
    if (selM043.FieldByName('DATA').AsDateTime = FSelM040_Funzioni.FieldByName('DATAA').AsDateTime) and
       (Minuti > R180OreMinutiExt(FSelM040_Funzioni.FieldByName('ORAA').AsString)) then
      raise Exception.Create(A000MSG_A100_ERR_ORA_FINE_ATTIVITA);
  end;
end;

procedure TA100FMissioniMW.selM043DATAValidate(Sender: TField);
var
  D: TDateTime;
begin
  if not Sender.IsNull then
  begin
    if not TryStrToDate(Sender.AsString, D) then
      raise Exception.Create(A000MSG_A100_ERR_DATA_DETT);
    if (D < FSelM040_Funzioni.FieldByName('DATADA').AsDateTime) or
       (D > FSelM040_Funzioni.FieldByName('DATAA').AsDateTime) then
      raise Exception.Create(A000MSG_A100_ERR_DATA_DETT_MISSIONE);
  end;
end;

procedure TA100FMissioniMW.selM043NewRecord(DataSet: TDataSet);
begin
  // missione di un giorno solo -> forza la data di dettaglio e la nasconde
  DataSet.FieldByName('ID').AsInteger:=FSelM040_Funzioni.FieldByName('ID_MISSIONE').AsInteger;
  if FSelM040_Funzioni.FieldByName('DATADA').AsDateTime = FSelM040_Funzioni.FieldByName('DATAA').AsDateTime then
  begin
    DataSet.FieldByName('DATA').AsDateTime:=FSelM040_Funzioni.FieldByName('DATADA').AsDateTime;
  end;
end;

procedure TA100FMissioniMW.CalcolaTotaliIndennitaOrarie;
var
  Totale: Real;
begin
  // Calcolo il totale delle ore indennità
  Totale:=0;
  TotaleIndennitaOrarie:=0;
  FSelM040_Funzioni.FieldByName('TotaleMissione').AsInteger:=0;
  FSelM040_Funzioni.FieldByName('CostoMissione').AsInteger:=0;
  FSelM040_Funzioni.FieldByName('TotaleOreIndennita').AsInteger := 0;
  if FSelM040_Funzioni.FieldByName('OREINDINTERA').AsFloat <> 0 then
    Totale:=Totale + FSelM040_Funzioni.FieldByName('OREINDINTERA').AsFloat;
  if FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').AsFloat <> 0 then
    Totale:=Totale + FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').AsFloat;
  if FSelM040_Funzioni.FieldByName('OREINDRIDOTTAG').AsFloat <> 0 then
    Totale:=Totale + FSelM040_Funzioni.FieldByName('OREINDRIDOTTAG').AsFloat;
  if FSelM040_Funzioni.FieldByName('OREINDRIDOTTAHG').AsFloat <> 0 then
    Totale:=Totale + FSelM040_Funzioni.FieldByName('OREINDRIDOTTAHG').AsFloat;
  if Totale <> 0 then
    if Not(TabTariffe) then
      FSelM040_Funzioni.FieldByName('TotaleOreIndennita').AsFloat:=Totale
    else
      FSelM040_Funzioni.FieldByName('TotaleOreIndennita').AsFloat:=FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').AsFloat;
  // Calcolo il totale dei totali delle indennità
  Totale:=0;
  FSelM040_Funzioni.FieldByName('TotaleImportiIndennita').AsInteger:=0;
  if FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsFloat <> 0 then
    Totale:=Totale + FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsFloat;
  if FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsFloat <> 0 then
    Totale:=Totale + FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsFloat;
  if FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAG').AsFloat <> 0 then
    Totale:=Totale + FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAG').AsFloat;
  if FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAHG').AsFloat <> 0 then
    Totale:=Totale + FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAHG').AsFloat;
  if Totale <> 0 then
  begin
    FSelM040_Funzioni.FieldByName('TotaleImportiIndennita').AsFloat:=Totale;
    TotaleIndennitaOrarie:=Totale;
  end;
  FSelM040_Funzioni.FieldByName('TotaleMissione').AsFloat:=TotaleRimborsi + TotaleIndennitaOrarie +
    TotaleIndennitaKm;
  FSelM040_Funzioni.FieldByName('CostoMissione').AsFloat:=CostoRimborsi + TotaleIndennitaOrarie +
    TotaleIndennitaKm;
  FSelM040_Funzioni.FieldByName('TotaleMissione').AsFloat:=R180Arrotonda(FSelM040_Funzioni.FieldByName('TotaleMissione').AsFloat, 0.01, 'P');
  FSelM040_Funzioni.FieldByName('CostoMissione').AsFloat:=R180Arrotonda(FSelM040_Funzioni.FieldByName('CostoMissione').AsFloat, 0.01, 'P');
end;

procedure TA100FMissioniMW.CalcolaTotaleRimborsi;
begin
  // Calcolo il totale della missione...
  TotaleRimborsi:=0;
  CostoRimborsi:=0;
  FSelM040_Funzioni.FieldByName('TotaleMissione').AsInteger:=0;
  FSelM040_Funzioni.FieldByName('CostoMissione').AsInteger:=0;
  if not Q050.Active then
    exit;
  Q050.First;
  while not Q050.Eof do
  begin
    if (Q050.FieldByName('TIPO_QUANTITA').AsString.ToUpper = 'I') or (Q050.FieldByName('FLAG_ANTICIPO').AsString.ToUpper = 'S') then
    begin
      if UpperCase(Q050.FieldByName('FLAG_ANTICIPO').AsString) = 'S' then
        TotaleRimborsi:=TotaleRimborsi - (Q050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat +
            Q050.FieldByName('IMPORTOINDENNITASUPPLEMENTARE').AsFloat)
      else
      begin
        TotaleRimborsi:=TotaleRimborsi + (Q050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat +
            Q050.FieldByName('IMPORTOINDENNITASUPPLEMENTARE').AsFloat);
        CostoRimborsi:=CostoRimborsi + (Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsFloat +
            Q050.FieldByName('IMPORTOINDENNITASUPPLEMENTARE').AsFloat);
      end;
    end;
    Q050.Next;
  end;
  Q050.First;
  FSelM040_Funzioni.FieldByName('TotaleMissione').AsFloat:=TotaleRimborsi + TotaleIndennitaOrarie +
    TotaleIndennitaKm;
  FSelM040_Funzioni.FieldByName('CostoMissione').AsFloat:=CostoRimborsi + TotaleIndennitaOrarie +
    TotaleIndennitaKm;
  FSelM040_Funzioni.FieldByName('TotaleMissione').AsFloat:=R180Arrotonda(FSelM040_Funzioni.FieldByName('TotaleMissione').AsFloat,
    0.01, 'P');
  FSelM040_Funzioni.FieldByName('CostoMissione').AsFloat := R180Arrotonda(FSelM040_Funzioni.FieldByName('CostoMissione').AsFloat, 0.01,
    'P');
end;

procedure TA100FMissioniMW.CalcolaTotaliIndennitaKm;
var
  kmPercorsi,ImportiKmIndennita: Double;
  Imposta:Boolean;
begin
  // Calcolo il totale delle ore indennità
  TotaleIndennitaKm:=0;
  FSelM040_Funzioni.FieldByName('TotaleMissione').AsInteger:=0;
  FSelM040_Funzioni.FieldByName('CostoMissione').AsInteger:=0;
  Imposta:=False;
  if (Qm052.UpdatesPending) then
  begin
    CalcolaIndKmFromDataset(kmPercorsi,ImportiKmIndennita);
    Imposta:=True;
  end
  else
  begin
    // Calcolo il totale dei Km Indennità e del totale degli Importi Indennità Km
    if (FSelM040_Funzioni.FieldByName('PROGRESSIVO').IsNull = False) and (FSelM040_Funzioni.FieldByName('MESESCARICO').IsNull = False)
        and (FSelM040_Funzioni.FieldByName('MESECOMPETENZA').IsNull = False) and
        (FSelM040_Funzioni.FieldByName('DATADA').IsNull = False) and (FSelM040_Funzioni.FieldByName('ORADA').IsNull = False) then
    begin
      QSource.Close;
      QSource.ReadBuffer:=2;
      QSource.SQL.Clear;
      QSource.DeleteVariables;
      QSource.SQL.Add('select sum(kmpercorsi) as kmpercorsi, sum(importoindennita) as importoindennita');
      QSource.SQL.Add(' from m052_indennitakm');
      QSource.SQL.Add('where progressivo = ' + FSelM040_Funzioni.FieldByName('PROGRESSIVO').AsString);
      QSource.SQL.Add('  AND MESESCARICO = TO_DATE(''' + FormatDateTime('dd/mm/yyyy', FSelM040_Funzioni.FieldByName('MESESCARICO').AsDateTime) + ''', ''DD/MM/YYYY'')');
      QSource.SQL.Add('  AND MESECOMPETENZA = TO_DATE(''' + FormatDateTime('dd/mm/yyyy', FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsDateTime)+ ''', ''DD/MM/YYYY'')');
      QSource.SQL.Add('  AND DATADA = TO_DATE(''' + FormatDateTime('dd/mm/yyyy', FSelM040_Funzioni.FieldByName('DATADA').AsDateTime) + ''', ''DD/MM/YYYY'')');
      QSource.SQL.Add('  AND ORADA = ''' + FSelM040_Funzioni.FieldByName('ORADA').AsString + '''');
      QSource.Open;
      kmPercorsi:=QSource.FieldByName('kmpercorsi').AsFloat;
      ImportiKmIndennita:=QSource.FieldByName('importoindennita').AsFloat;
      Imposta:=True;
    end;
  end;
  if Imposta then
  begin
    FSelM040_Funzioni.FieldByName('TotaleKmIndennita').AsFloat:=kmPercorsi;
    FSelM040_Funzioni.FieldByName('TotaleImportiKmIndennita').AsFloat:=ImportiKmIndennita;
    TotaleIndennitaKm:=TotaleIndennitaKm + FSelM040_Funzioni.FieldByName('TotaleImportiKmIndennita').AsFloat;
  end;

  FSelM040_Funzioni.FieldByName('TotaleMissione').AsFloat:=TotaleRimborsi + TotaleIndennitaOrarie + TotaleIndennitaKm;
  FSelM040_Funzioni.FieldByName('CostoMissione').AsFloat:=CostoRimborsi + TotaleIndennitaOrarie + TotaleIndennitaKm;
  FSelM040_Funzioni.FieldByName('TotaleMissione').AsFloat:=R180Arrotonda(FSelM040_Funzioni.FieldByName('TotaleMissione').AsFloat, 0.01, 'P');
  FSelM040_Funzioni.FieldByName('CostoMissione').AsFloat:=R180Arrotonda(FSelM040_Funzioni.FieldByName('CostoMissione').AsFloat, 0.01, 'P');
end;

procedure TA100FMissioniMW.CalcolaIndKmFromDataset(var kmPercorsi:Double; var importoIndennita:Double);
var SavePlace: TBookmark;
begin
  SavePlace:=QM052.GetBookmark;
  try { TODO : TEST IW 15 }
    QM052.First;

    kmPercorsi:=0;
    importoIndennita:=0;
    while not QM052.Eof do
    begin
      kmPercorsi:=kmPercorsi + QM052.FieldByName('kmpercorsi').AsFloat;
      importoIndennita:=importoIndennita + QM052.FieldByName('importoindennita').AsFloat;
      QM052.Next;
    end;
    QM052.GotoBookmark(SavePlace);
  finally
    QM052.FreeBookmark(SavePlace);
  end;
end;

procedure TA100FMissioniMW.LeggiParametri(Data: TDateTime;
  TipoRegistazione: string; VisualizzaMessaggio: Boolean = True);
var
  CodiceRegole: string;
  QSIndennita: TQueryStorico;
begin
  RegoleTrovate:=True;
  CodiceRegole:='';
  QSIndennita:=TQueryStorico.Create(nil);
  QSIndennita.Session:=SessioneOracle;
  if (FSelM040_Funzioni.FieldByName('DATAA').IsNull) then
    IndennitaIntera:=True
  else
  begin
    QSIndennita.GetDatiStorici('T430' + Parametri.CampiRiferimento.C8_Missione,
      SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger, FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
    if QSIndennita.LocDatoStorico(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime) then
      CodiceRegole:=QSIndennita.FieldByName('T430' + Parametri.CampiRiferimento.C8_Missione).AsString;
  end;
  if (CodiceRegole <> '') and (TipoRegistazione <> '') then
  begin
    if (Q010.GetVariable('DECORRENZA') <> Data) or
      (Q010.GetVariable('TIPOREGISTRAZIONE') <> TipoRegistazione) or
      (Q010.GetVariable('CODICE') <> CodiceRegole) then
    begin
      Q010.Close;
      Q010.SetVariable('DECORRENZA', Data);
      Q010.SetVariable('TIPOREGISTRAZIONE', TipoRegistazione);
      Q010.SetVariable('CODICE', CodiceRegole);
      Q010.Open;
    end;
  end;
  QSIndennita.Free;

  if Not(Q010.Active) or (Q010.Active and (Q010.RecordCount = 0)) then
  begin
    if VisualizzaMessaggio then
    begin
      if Assigned(MessaggioAvviso) then
        MessaggioAvviso(Format(A000MSG_A100_ERR_FMT_REGOLE,[DateToStr(Data)]));
    end;
    RegoleTrovate:=False;
  end;
  TabTariffe:=False;
  if Q010.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S' then
    TabTariffe:=True;
end;

Procedure TA100FMissioniMW.GetArrotondamento(Codice: string; Data: TDateTime);
begin
  nPb_Arrotondamento:=1;
  sPb_Tipo:='P';
  P050.Close;
  P050.SetVariable('DECORRENZA', Data);
  P050.SetVariable('CODICE', Codice);
  P050.Open;
  P050.First;
  if not P050.Eof then
  begin
    nPb_Arrotondamento:=P050.FieldByName('VALORE').AsFloat;
    sPb_Tipo:=P050.FieldByName('TIPO').AsString;
  end;
end;

function TA100FMissioniMW.TO_ZOO_PROFRimborsi: Real;
var
  DurataArr: integer;
begin
  with TOracleDataSet.Create(Self) do
    try
      DurataArr:=0;
      Result:=0;
      Session:=SessioneOracle;
      DurataArr:=CalcolaDurataArrotondata(FSelM040_Funzioni.FieldByName('DATADA').AsString,
                                          FSelM040_Funzioni.FieldByName('ORADA').AsString,
                                          FSelM040_Funzioni.FieldByName('DATAA').AsString,
                                          FSelM040_Funzioni.FieldByName('ORAA').AsString);
      SQL.Add('select OREMINUTI(M013.SOGLIA_GG) SOGLIA_GG, M013.RIMBORSO_MAX');
      SQL.Add('  from M013_SOGLIE_RIMBORSIPASTO M013');
      SQL.Add(' where M013.CODICE = :CODICE');
      SQL.Add('   and M013.TIPO_MISSIONE = :TIPO_MISSIONE');
      SQL.Add('   and :DATADA between M013.DECORRENZA and M013.DECORRENZA_FINE');
      SQL.Add(' order by M013.SOGLIA_GG DESC');
      DeclareVariable('CODICE', otString);
      DeclareVariable('TIPO_MISSIONE', otString);
      DeclareVariable('DATADA', otDate);
      SetVariable('CODICE', Q010.FieldByName('CODICE').AsString);
      SetVariable('TIPO_MISSIONE', Q010.FieldByName('TIPO_MISSIONE').AsString);
      SetVariable('DATADA', FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
      Open;
      while (Not Eof) and (FieldByName('SOGLIA_GG').AsInteger > DurataArr) do
        Next;
      if FieldByName('SOGLIA_GG').AsInteger <= DurataArr then
        Result := FieldByName('RIMBORSO_MAX').AsFloat;
    finally
      Free;
    end;
end;

function TA100FMissioniMW.ValToEuro(Value: Real): Real;
var
  TempVal: Real;
  Ret: Real;
begin
  Ret:=0;
  if Not(Q050.FieldByName('COD_VALUTA_EST').IsNull) then
  begin
    selP032.Close;
    selP032.SetVariable('VALEST', Q050.FieldByName('COD_VALUTA_EST').AsString);
    selP032.SetVariable('DATAMISS', FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
    selP032.Open;
    if selP032.RecordCount <= 0 then
    begin
      if Assigned(MessaggioAvviso) then
        MessaggioAvviso(A000MSG_A100_ERR_COEFF_CAMBIO);
    end
    else
     begin
      TempVal:=selP032.FieldByName('COEFF_CALCOLI').AsFloat;
      if (nPb_Arrotondamento <= 0) and (sPb_Tipo = '') then
      begin
        nPb_Arrotondamento:=0.01;
        sPb_Tipo:='P';
      end;
      Ret:=R180Arrotonda((Value / TempVal), nPb_Arrotondamento, sPb_Tipo);
    end;
  end;
  Result:=Ret;
end;

function TA100FMissioniMW.CalcolaDurataArrotondata(DataDa: string; OraDa: string; DataA: string; OraA: string): integer;
var
  Inizio, Fine: String;
  Differenza: TDateTime;
  TotaleOre, TotaleMinuti: integer;
  DurataEffettiva: integer;
begin
  Inizio:=DataDa + ' ' + OraDa + '.00';
  Fine:=DataA + ' ' + OraA + '.00';
  Differenza:=StrToDateTime(Fine) - StrToDateTime(Inizio);
  // DIFFERENZA IN MINUTI....
  // Ottengo le Ore effettive
  TotaleOre:=Trunc(Differenza * 24);
  // Ottengo i minuti effettivi
  TotaleMinuti:=Round(((Differenza * 24) - TotaleOre) * 60);
  // Durata effettiva tra le due date in minuti...
  DurataEffettiva:=R180OreMinutiExt(inttostr(TotaleOre) + '.' + inttostr(TotaleMinuti));
  // Arrotondo la durata effettiva
  Result:=Trunc(R180Arrotonda(DurataEffettiva, Q010ARROTONDAMENTOORE.AsInteger, Q010TIPO.AsString));
end;

procedure TA100FMissioniMW.CalcolaMissioni;
begin
  if (FSelM040_Funzioni.FieldByName('DATAA').AsString <> '') and
     (FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString <> '') and
     (FSelM040_Funzioni.FieldByName('ORADA').AsString <> '') then
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
  if Not(TabTariffe) then
    ElaboraMissione
  else
  ElaboraDaTariffe;
end;

procedure TA100FMissioniMW.ElaboraMissione;
Var
  TotaleGG, TotaleGGMEse, DurataArrotondata: integer;
  Year, Month, Day: Word;
  // CodiceRimborsoPasto:String;
begin
  if FSelM040_Funzioni.State in [dsInsert, dsEdit] then
    PulisciCampi;

  if not ControlliFormali(False) then
    exit;
  // Ripulisco i bolleani dell'indennità
  IndennitaIntera:=False;
  SuperoHH:=False;
  SuperoGG:=False;
  SuperoHHGG:=False;
  RiduzionePasto:=False;
  bPv_SegnalazionePasto:=False;

  // -------------------------- INIZIO CALCOLI  ---------------------------------
  if (FSelM040_Funzioni.State in [dsInsert, dsEdit]) and
    (FSelM040_Funzioni.FieldByName('DATADA').AsString <> '') and (FSelM040_Funzioni.FieldByName('DATAA').AsString <> '') then
  begin
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
    TotaleGG:=Trunc(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime - FSelM040_Funzioni.FieldByName('DATADA').AsDateTime) + 1;
    FSelM040_Funzioni.FieldByName('TOTALEGG').AsInteger:=TotaleGG;

    if Assigned(ImpostaCampiElaboraMissione) then
      ImpostaCampiElaboraMissione;

    if (FSelM040_Funzioni.FieldByName('ORADA').AsString <> '') and (FSelM040_Funzioni.FieldByName('ORAA').AsString <> '') then
    begin
      // Durata della missione
      DurataArrotondata:=CalcolaDurataArrotondata(FSelM040_Funzioni.FieldByName('DATADA').AsString,FSelM040_Funzioni.FieldByName('ORADA').AsString, FSelM040_Funzioni.FieldByName('DATAA').AsString, FSelM040_Funzioni.FieldByName('ORAA').AsString);
      FSelM040_Funzioni.FieldByName('DURATA').AsString:=R180MinutiOre(DurataArrotondata);
      // --------------------- CONTROLLO IN CHE FASCIA DI INDENNITA' CADE LA MIA MISSIONE ----------------
      // VERIFICO in quale categoria fare rientrare la missione, effettuando alcune
      // valutazioni sulla DURATA EFFETTIVA....
      if DurataArrotondata < R180OreMinutiExt(Q010.FieldByName('OREMINIMEPERINDENNITA').AsString) then
        // NESSUNA INDENNITA - non supero il limite delle ore previste per l'indennità
        // non verifico nemmeno se supero i gg nel mese poichè non avrei comunque diritto
        // as indennità
      else if Parametri.CampiRiferimento.C8_GestioneMensile <> 'N' then
      // Se si tratta di Gestione mensile faccio tutti gli automatismi
      begin
        if (Q010.FieldByName('RIDUZIONE_PASTO').AsString = 'S') then
        begin
          IndennitaIntera:=True;
          if Q050.Active then
          begin
            // CodiceRimborsoPasto:=Q010.FieldByName('CODRIMBORSOPASTO').AsString;
            // if Q050.SearchRecord('CODICERIMBORSOSPESE',CodiceRimborsoPasto,[srFromBeginning]) then
            Q050.First;
            if Q050.SearchRecord('TIPO', M020TIPO_PASTO, [srFromBeginning]) then
              repeat
                if Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsCurrency <> 0 then
                begin
                  RiduzionePasto:=True;
                  IndennitaIntera:=False;
                  Break;
                end;
              until not Q050.SearchRecord('TIPO', M020TIPO_PASTO, []);
          end;
        end
        else
        begin
          // Controllo se supero i giorni max nel mese di missione per la persoma selezionata.
          QSuperoGiorni.Close;
          QSuperoGiorni.SetVariable('PROGRESSIVO', SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          DecodeDate(FSelM040_Funzioni.FieldByName('DATADA').AsDateTime, Year, Month, Day);
          QSuperoGiorni.SetVariable('DATADA', EncodeDate(Year, Month, 1));
          If FSelM040_Funzioni.State = dsEdit then
          begin
            QSuperoGiorni.SetVariable('STATO', 'U');
            QSuperoGiorni.SetVariable('IDRIGA', FSelM040_Funzioni.RowId);
          end
          else
            QSuperoGiorni.SetVariable('STATO', 'I');
          QSuperoGiorni.Open;

          TotaleGGMEse:=QSuperoGiorni.FieldByName('GIORNI').AsInteger;
          TotaleGGMEse:=TotaleGGMEse + TotaleGG;

          if (TotaleGGMEse > Q010.FieldByName('MAXGIORNIRETRMESE').AsInteger) and
             (bIndennitaSupMaxGG = False) and
             (trim(Q010.FieldByName('MAXGIORNIRETRMESE').AsString) <> '') then
            SuperoGG:=True
          else
            SuperoGG:=False;

          if (DurataArrotondata <= R180OreMinutiExt
             (Q010.FieldByName('LIMITEORERETRIBUITEINTERE').AsString)) or
             (trim(Q010.FieldByName('LIMITEORERETRIBUITEINTERE').AsString) = '') then
          begin
            // INDENNITA INTERA - non supero il limite delle ore retribuite intere ma supero le ore previste per l'indennità
            if SuperoGG = False then
              IndennitaIntera:=True;
          end
          else if not SuperoGG then
            SuperoHH:=True
          else
          begin
            SuperoGG:=False;
            SuperoHHGG:=True;
          end;
        end;
      end;

      // Visualizzo tutte le indennità di trasferta...
      GetArrotondamento(Q010.FieldByName('ARROTTARIFFADOPORIDUZIONE').AsString,FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
      FSelM040_Funzioni.FieldByName('TARIFFAINDINTERA').AsFloat:=Q010.FieldByName('TARIFFAINDENNITA').AsFloat;
      // if RiduzionePasto=True then
      if (Q010.FieldByName('RIDUZIONE_PASTO').AsString = 'S') then
        FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAH').AsFloat:=R180Arrotonda(((Q010.FieldByName('TARIFFAINDENNITA').AsFloat * Q010.FieldByName('PERCRETRIBPASTO').AsFloat) / 100), nPb_Arrotondamento,sPb_Tipo)
      else
        FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAH').AsFloat:=R180Arrotonda(((Q010.FieldByName('TARIFFAINDENNITA').AsFloat * Q010.FieldByName('PERCRETRIBSUPEROORE').AsFloat) / 100), nPb_Arrotondamento,sPb_Tipo);
      FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAG').AsFloat:=R180Arrotonda(((Q010.FieldByName('TARIFFAINDENNITA').AsFloat * Q010.FieldByName('PERCRETRIBSUPEROGG').AsFloat) / 100), nPb_Arrotondamento, sPb_Tipo);
      FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAHG').AsFloat:=((Q010.FieldByName('TARIFFAINDENNITA').AsFloat * Q010.FieldByName('PERCRETRIBSUPEROORE').AsFloat) / 100);
      FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAHG').AsFloat:=R180Arrotonda(((FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAHG').AsFloat * Q010.FieldByName('PERCRETRIBSUPEROGG').AsFloat)/ 100), nPb_Arrotondamento, sPb_Tipo);

      // ------------------------- CALCOLO LA TARIFFA DELL'IND. di TRASFERTA ------------------
      // ------------------------- solo se non è checcato il campo MODIFICA MANUALE ------------------
      //testava A100FMissioni.dChkModifica.Checked. fatto su campo

      if not (FSelM040_Funzioni.FieldByName('FLAG_MODIFICATO').AsString = 'S') then
      begin
        // //Apro la query sulle indennità spettanti al dipendente
        // LeggiParametri(m040DATAA.AsDateTime,m040TIPOREGISTRAZIONE.AsString);
        // //Visualizzo tutte le indennità di trasferta...
        // GetArrotondamento(Q010ARROTTARIFFADOPORIDUZIONE.asstring, m040datada.AsDateTime);
        // M040TARIFFAINDINTERA.AsFloat:=Q010TARIFFAINDENNITA.AsFloat;
        // if RiduzionePasto=True then
        // M040TARIFFAINDRIDOTTAH.AsFloat:=R180Arrotonda(((Q010TARIFFAINDENNITA.AsFLOAT * Q010PERCRETRIBPASTO.ASFLOAT)/100),nPb_Arrotondamento,sPb_Tipo)
        // else
        // M040TARIFFAINDRIDOTTAH.AsFloat:=R180Arrotonda(((Q010TARIFFAINDENNITA.AsFLOAT * Q010PERCRETRIBSUPEROORE.ASFLOAT)/100),nPb_Arrotondamento,sPb_Tipo);
        // M040TARIFFAINDRIDOTTAG.AsFloat:=R180Arrotonda(((Q010TARIFFAINDENNITA.AsFLOAT * Q010PERCRETRIBSUPEROGG.ASFLOAT)/100),nPb_Arrotondamento,sPb_Tipo);
        // M040TARIFFAINDRIDOTTAHG.AsFloat:=((Q010TARIFFAINDENNITA.AsFLOAT * Q010PERCRETRIBSUPEROORE.ASFLOAT)/100);
        // M040TARIFFAINDRIDOTTAHG.AsFloat:=R180Arrotonda(((M040TARIFFAINDRIDOTTAHG.AsFLOAT * Q010PERCRETRIBSUPEROGG.ASFLOAT)/100),nPb_Arrotondamento,sPb_Tipo);
        // ------------------------- VALORIZZO L'OPPORTUNA TRASFERTA ------------------
        if IndennitaIntera then
        begin
          if Q010.FieldByName('TIPO_TARIFFA').AsString = 'G' then
            // Tariffa giornaliera... indico i giorni...
            FSelM040_Funzioni.FieldByName('OREINDINTERA').AsFloat:=TotaleGG
          else
            FSelM040_Funzioni.FieldByName('OREINDINTERA').AsCurrency:=R180OreMinutiExt(FSelM040_Funzioni.FieldByName('DURATA').AsString) / 60;
          if bPb_RimborsoPastoEsistente then
            bPv_SegnalazionePasto:=True;
        end
        else if (RiduzionePasto) then
        begin
          if Q010.FieldByName('TIPO_TARIFFA').AsString = 'G' then
            FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').AsFloat:=TotaleGG
          else
            FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').AsCurrency:=R180OreMinutiExt(FSelM040_Funzioni.FieldByName('DURATA').AsString) / 60;
          if bPb_RimborsoPastoEsistente = False then
            bPv_SegnalazionePasto:=True;
        end
        else if (SuperoHH) then
        begin
          if Q010.FieldByName('TIPO_TARIFFA').AsString = 'G' then
            FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').AsFloat:=TotaleGG
          else
            FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').AsCurrency:=R180OreMinutiExt(FSelM040_Funzioni.FieldByName('DURATA').AsString) / 60;
        end
        else if (SuperoGG) then
        begin
          if Q010.FieldByName('TIPO_TARIFFA').AsString = 'G' then
            FSelM040_Funzioni.FieldByName('OREINDRIDOTTAG').AsFloat:=TotaleGG
          else
            FSelM040_Funzioni.FieldByName('OREINDRIDOTTAG').AsCurrency:=R180OreMinutiExt(FSelM040_Funzioni.FieldByName('DURATA').AsString) / 60;
        end
        else if (SuperoHHGG) then
        begin
          if Q010.FieldByName('TIPO_TARIFFA').AsString = 'G' then
            FSelM040_Funzioni.FieldByName('OREINDRIDOTTAHG').AsFloat:=TotaleGG
          else
            // APPLICO PRIMA LA RIDUZIONE RELATIVA AL SUPERO ORE E POI SUL RISULTATO QUELLA RELATIVA AL SUPERO DEI GIORNI
            FSelM040_Funzioni.FieldByName('OREINDRIDOTTAHG').AsCurrency := R180OreMinutiExt(FSelM040_Funzioni.FieldByName('DURATA').AsString) / 60;
        end;
      end;
    end;
  end;
end;

procedure TA100FMissioniMW.PulisciCampi;
var
  ValidateTARIFFAINDINTERA,
  ValidateOREINDINTERA,
  ValidateTARIFFAINDRIDOTTAH,
  ValidateOREINDRIDOTTAH,
  ValidateTARIFFAINDRIDOTTAG,
  ValidateOREINDRIDOTTAG,
  ValidateTARIFFAINDRIDOTTAHG,
  ValidateOREINDRIDOTTAHG: TValidate;
  CalcM040: TEvDataset;
begin
  // Disabilito gli eventi...
  // if M040FLAG_MODIFICATO.AsString <> 'S' then
  //testava A100FMissioni.dChkModifica.Checked. fatto su campo
  if not (FSelM040_Funzioni.FieldByName('FLAG_MODIFICATO').AsString = 'S') then
  begin
    CalcM040:=FSelM040_Funzioni.OnCalcFields;
    FSelM040_Funzioni.OnCalcFields:=nil;
    ValidateTARIFFAINDINTERA:=FSelM040_Funzioni.FieldByName('TARIFFAINDINTERA').OnValidate;
    ValidateOREINDINTERA:=FSelM040_Funzioni.FieldByName('OREINDINTERA').OnValidate;
    ValidateTARIFFAINDRIDOTTAH:=FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAH').OnValidate;
    ValidateOREINDRIDOTTAH:=FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').OnValidate;
    ValidateTARIFFAINDRIDOTTAG:=FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAG').OnValidate;
    ValidateOREINDRIDOTTAG:=FSelM040_Funzioni.FieldByName('OREINDRIDOTTAG').OnValidate;
    ValidateTARIFFAINDRIDOTTAHG:=FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAHG').OnValidate;
    ValidateOREINDRIDOTTAHG:=FSelM040_Funzioni.FieldByName('OREINDRIDOTTAHG').OnValidate;

    FSelM040_Funzioni.FieldByName('TARIFFAINDINTERA').OnValidate:=nil;
    FSelM040_Funzioni.FieldByName('OREINDINTERA').OnValidate:=nil;
    FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAH').OnValidate:=nil;
    FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').OnValidate:=nil;
    FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAG').OnValidate:=nil;
    FSelM040_Funzioni.FieldByName('OREINDRIDOTTAG').OnValidate:=nil;
    FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAHG').OnValidate:=nil;
    FSelM040_Funzioni.FieldByName('OREINDRIDOTTAHG').OnValidate:=nil;

    // Ripulisco i campi sul form
    //testava A100FMissioni.dChkModifica.Checked. fatto su campo
    if not (FSelM040_Funzioni.FieldByName('FLAG_MODIFICATO').AsString = 'S') then
    begin
      FSelM040_Funzioni.FieldByName('TARIFFAINDINTERA').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('OREINDINTERA').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAH').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAG').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('OREINDRIDOTTAG').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAG').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAHG').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('OREINDRIDOTTAHG').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAHG').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('TOTALEGG').AsInteger:=0;
      FSelM040_Funzioni.FieldByName('DURATA').AsInteger:=0;
    end;
    // Ri-abilito gli eventi...
    FSelM040_Funzioni.OnCalcFields:=CalcM040;

    FSelM040_Funzioni.FieldByName('TARIFFAINDINTERA').OnValidate:=ValidateTARIFFAINDINTERA;
    FSelM040_Funzioni.FieldByName('OREINDINTERA').OnValidate:=ValidateOREINDINTERA;
    FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAH').OnValidate:=ValidateTARIFFAINDRIDOTTAH;
    FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').OnValidate:=ValidateOREINDRIDOTTAH;
    FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAG').OnValidate:=ValidateTARIFFAINDRIDOTTAG;
    FSelM040_Funzioni.FieldByName('OREINDRIDOTTAG').OnValidate:=ValidateOREINDRIDOTTAG;
    FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAHG').OnValidate:=ValidateTARIFFAINDRIDOTTAHG;
    FSelM040_Funzioni.FieldByName('OREINDRIDOTTAHG').OnValidate:=ValidateOREINDRIDOTTAHG;
  end;
end;

function TA100FMissioniMW.CtrlProtocolloUnivoco(const PId: Integer; const PProtocollo: String; out RErrMsg: String): Boolean;
// effettua query per stabilire se il protocollo indicato è univoco
// considerando i record di M040 e M140
begin
  // se il protocollo non è indicato non effettua controlli
  if PProtocollo = '' then
  begin
    Result:=True;
    Exit;
  end;

  // verifica duplicazione protocollo
  Result:=False;
  RErrMsg:='';
  try
    selProtocolloUnique.SetVariable('ID',PId);
    selProtocolloUnique.SetVariable('PROTOCOLLO',PProtocollo);
    selProtocolloUnique.Execute;

    Result:=selProtocolloUnique.Eof;
    if not Result then
      RErrMsg:='Esiste già una missione presente con lo stesso numero di protocollo. Inserimento richiesta non consentito.';
  except
    on E: Exception do
    begin
      RErrMsg:=Format('Errore durante la verifica di univocità del numero di protocollo della richiesta:'#13#10'%s',[E.Message]);
    end;
  end;
end;

function TA100FMissioniMW.ControlliFormali(bGeneraErrore: Boolean): Boolean;
var
  Year, Month, Day: Word;
  Year2, Month2, Day2: Word;
  LErrMsg: String;
begin
  Result:=False;
  if (FSelM040_Funzioni.State in [dsInsert, dsEdit]) then
  begin
    if (FSelM040_Funzioni.FieldByName('DATADA').AsString <> '') and (FSelM040_Funzioni.FieldByName('DATAA').AsString <> '') then
    begin
      // --------------------------- CONTROLLI SULLA DATA ---------------------------------
      // Controllo che dataa e datada siano all'interno dello stesso mese
      DecodeDate(FSelM040_Funzioni.FieldByName('DATADA').AsDateTime, Year, Month, Day);
      DecodeDate(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, Year2, Month2, Day2);
      if Parametri.CampiRiferimento.C8_GestioneMensile <> 'N' then
      // Se è prevista la gertione mensile (S oppure vuoto)
      begin
        if (Month <> Month2) or (Year <> Year2) then
          if bGeneraErrore then
            raise Exception.Create(A000MSG_A100_ERR_DATE_TRASFERTA_MESE_ANNO)
          else
            exit;
      end;
      // Controllo che dataa sia successiva a datada
      if FSelM040_Funzioni.FieldByName('DATADA').AsDateTime >FSelM040_Funzioni.FieldByName('DATAA').AsDateTime then
        if bGeneraErrore then
          raise Exception.Create(A000MSG_A100_ERR_INTERVALLO_DATE)
        else
          exit;
      // ----------------------- FINE CONTROLLI SULLA DATA ---------------------------------

      // --------------------------- CONTROLLI SULL'ORA ---------------------------------
      if (FSelM040_Funzioni.FieldByName('ORADA').AsString <> '') and (FSelM040_Funzioni.FieldByName('ORAA').AsString <> '') then
      begin
        // Se sono nell'ambito della stessa giornata...
        if FSelM040_Funzioni.FieldByName('DATADA').AsString = FSelM040_Funzioni.FieldByName('DATAA').AsString then
        begin
          // Controllo che oraa sia successiva a orada
          if FSelM040_Funzioni.FieldByName('ORADA').AsDateTime > FSelM040_Funzioni.FieldByName('ORAA').AsDateTime then
            if bGeneraErrore then
              raise Exception.Create(A000MSG_A100_ERR_INTERVALLO_ORE)
            else
              exit;
        end;
      end;
      // ----------------------- FINE CONTROLLI SULL'ORA ---------------------------------
    end;

    // verifica protocollo univoco M140 + M040
    if bGeneraErrore then
    begin
      if not CtrlProtocolloUnivoco(FSelM040_Funzioni.FieldByName('ID_MISSIONE').AsInteger,FSelM040_Funzioni.FieldByName('PROTOCOLLO').AsString,LErrMsg) then
        raise Exception.Create(LErrMsg);
    end;
  end;
  Result:=True;
end;

procedure TA100FMissioniMW.ElaboraDaTariffe;
var
  DurataGG, DurataOO: integer;
  IndennitaGiornaliera: Real;

  procedure CalcGiorniOre(var GGMiss, OOMiss: integer);
  var
    GG: Real;
  begin
    GG:=StrToDateTime(FSelM040_Funzioni.FieldByName('DATAA').AsString + ' ' + FSelM040_Funzioni.FieldByName('ORAA').AsString + '.00');
    GG:=GG - StrToDateTime(FSelM040_Funzioni.FieldByName('DATADA').AsString + ' ' + FSelM040_Funzioni.FieldByName('ORADA').AsString + '.00');
    GGMiss:=Trunc(GG);
    OOMiss:=Trunc(CalcolaDurataArrotondata(FSelM040_Funzioni.FieldByName('DATADA').AsString,FSelM040_Funzioni.FieldByName('ORADA').AsString, FSelM040_Funzioni.FieldByName('DATAA').AsString, FSelM040_Funzioni.FieldByName('ORAA').AsString) / 60) - (GGMiss * 24);
  end;

  function ArrCfr(Imp: Real): Real;
  var
    Ret: Real;
  begin
    Ret:=Imp;
    if (Q010.Active) and (Q010.RecordCount >= 0) then
      Ret:=R180Arrotonda(Imp, Q010.FieldByName('ARROTONDAMENTOORE').AsInteger, Q010.FieldByName('TIPO').AsString);
    Result:=Ret;
  end;

  function CalcolaRiduzione(Tot, Rid: Real): Real;
  var
    Ret: Real;
  begin
    Ret := Tot;
    if Rid <> 0 then
      Ret := Tot - ((Tot / 100) * Rid);
    Result := Ret;
  end;

begin
  if (FSelM040_Funzioni.FieldByName('DATADA').AsString <> '') and (FSelM040_Funzioni.FieldByName('ORADA').AsString <> '') and
    (FSelM040_Funzioni.State in [dsInsert, dsEdit]) and
    (FSelM040_Funzioni.FieldByName('COD_TARIFFA').AsString <> '') and
    (FSelM040_Funzioni.FieldByName('COD_RIDUZIONE').AsString <> '') then
  begin
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
    DurataGG:=0;
    DurataOO:=0;
    CalcGiorniOre(DurataGG, DurataOO);
    FSelM040_Funzioni.FieldByName('TOTALEGG').AsFloat:=DurataGG;
    // ==========================================================
    // CALCOLO UN EVENTUALE RIDUZIONE SULL'INDENNITA' GIORNALIERA
    // ==========================================================
    IndennitaGiornaliera:=CalcolaRiduzione(selM065.FieldByName('IND_GIORNALIERA').AsFloat,selM066.FieldByName('PERC_RIDUZIONE').AsFloat);

    // ==============================================================================
    // TARIFFA UGUALE SIA PER TASSATE CHE NON I DATI VISUALIZZATI (NUM ORE * TARIFFA)
    // NON CORRISPONDONO ALL'IMPORTO FINALE
    // ==============================================================================
    FSelM040_Funzioni.FieldByName('TARIFFAINDINTERA').AsFloat:=ArrCfr(selM066.FieldByName('QUOTA_ESENTE').AsFloat / 24);
    FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAH').AsFloat:=ArrCfr(selM066.FieldByName('QUOTA_ESENTE').AsFloat / 24);
    // =====================================================
    // DURATA MISSIONE IN ORA = SIA PER TASSAZIONE CHE SENZA
    // =====================================================
    FSelM040_Funzioni.FieldByName('OREINDINTERA').AsFloat:=(DurataGG * 24) + DurataOO;
    FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').AsFloat:=(DurataGG * 24) + DurataOO;
    FSelM040_Funzioni.FieldByName('DURATA').AsString:=inttostr((DurataGG * 24) + DurataOO) + '.00';
    // ========================================
    // ELEBORAZIONE IMPORTO TARIFFA GIORNALIERA
    // ========================================
    if (IndennitaGiornaliera * DurataGG) > (selM066.FieldByName('QUOTA_ESENTE').AsFloat * DurataGG) then
    begin
      FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsFloat:=(selM066.FieldByName('QUOTA_ESENTE').AsFloat * DurataGG);
      FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsFloat:=(((IndennitaGiornaliera * DurataGG) - (selM066.FieldByName('QUOTA_ESENTE').AsFloat * DurataGG)) * (selM066.FieldByName('COEFF_MAGGIORAZIONE').AsFloat));
    end
    else
    begin
      FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsFloat:=(IndennitaGiornaliera * DurataGG);
      FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsFloat:=0;
    end;
    // ===================================
    // ELEBORAZIONE IMPORTO TARIFFA ORARIA
    // ===================================
    if ((IndennitaGiornaliera / 24) * DurataOO) > selM066.FieldByName('QUOTA_ESENTE').AsFloat then
    begin
      FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsFloat:=FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsFloat + ((selM066.FieldByName('QUOTA_ESENTE').AsFloat / 24) * DurataOO);
      FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsFloat:=FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsFloat + (((IndennitaGiornaliera / 24) * DurataOO) - ((selM066.FieldByName('QUOTA_ESENTE').AsFloat / 24) * DurataOO)) * selM066.FieldByName('COEFF_MAGGIORAZIONE').AsFloat;
    end
    else
    begin
      FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsFloat:=FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsFloat + ((IndennitaGiornaliera / 24) * DurataOO);
      FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsFloat:=FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsFloat + 0;
    end;
    // ==========================================================================
    // ARROTONDO POICHE' L'EVENTO ONVALIDATE(IN CUI LE CIFRE VENGONO ARROTONDATE)
    // VIENE ESEGUITO PRIMA DELLA VALORIZZAZIONE EFFETTIVA DEI CAMPI
    // ==========================================================================
    FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsFloat:=R180Arrotonda(FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsFloat, 0.01, 'P');
    FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsFloat:=R180Arrotonda(FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsFloat, 0.01, 'P');
  end;
end;

procedure TA100FMissioniMW.GetSede(Prog: integer; DaData, AData: TDateTime; var sCodiceSede:String; var sDescrizione: String );
var
  QSSede: TQueryStorico;
  sTabella, sCodice, sStorico: String;
begin
  if Parametri.CampiRiferimento.C8_Sede = '' then
    exit;
  sCodiceSede:='';
  sDescrizione:='';
  sTabella:='';
  sCodice:='';
  sStorico:='';
  A000GetTabella(Parametri.CampiRiferimento.C8_Sede, sTabella, sCodice, sStorico);
  QSSede:=TQueryStorico.Create(nil);
  QSSede.Session:=SessioneOracle;
  QSSede.GetDatiStorici('T430' + Parametri.CampiRiferimento.C8_Sede, Prog, DaData, AData);
  if QSSede.LocDatoStorico(AData) then
  begin
    sCodiceSede:=QSSede.FieldByName('T430' + Parametri.CampiRiferimento.C8_Sede).AsString;
    if sCodiceSede <> '' then
    begin
      QSource.Close;
      QSource.ReadBuffer:=200;
      QSource.DeleteVariables;
      QSource.SQL.Clear;
      if A000LookupTabella(Parametri.CampiRiferimento.C8_Sede, QSource) then
      begin
        if QSource.VariableIndex('DECORRENZA') >= 0 then
          QSource.SetVariable('DECORRENZA', AData);
        QSource.Close;
        QSource.Open;
        // AOSTA_REGIONE - commessa: 2013/031 VARIE#1.ini
        // bugfix: il codice della località viene sempre ridefinito con l'alias "codice"
        //QSource.Filter := sCodice + '=' + '''' + sCodiceSede + '''';
        QSource.Filter:='CODICE=' + '''' + sCodiceSede + '''';
        // AOSTA_REGIONE - commessa: 2013/031 VARIE#1.fine
        QSource.Filtered:=True;
        if not QSource.Eof then
          if QSource.FieldByName('DESCRIZIONE').AsString <> '' then
            sDescrizione:=QSource.FieldByName('DESCRIZIONE').AsString;
        QSource.Filtered:=False;
      end;
    end;
  end;
  QSSede.Free;
end;

procedure TA100FMissioniMW.GetCommessa(Prog: integer; DaData, AData: TDateTime; var sCodiceCommessa:String; var sDescrizione:String);
var
  QSCommessa: TQueryStorico;
  sTabella, sCodice, sStorico: String;
begin
  sCodiceCommessa:='';
  sDescrizione:='';
  if Parametri.CampiRiferimento.C8_MissioneCommessa = '' then
    exit;
  sTabella:='';
  sCodice:='';
  sStorico:='';
  A000GetTabella(Parametri.CampiRiferimento.C8_MissioneCommessa, sTabella, sCodice, sStorico);
  QSCommessa:=TQueryStorico.Create(nil);
  QSCommessa.Session:=SessioneOracle;
  QSCommessa.GetDatiStorici('T430' + Parametri.CampiRiferimento.C8_MissioneCommessa, Prog, DaData, AData);
  if QSCommessa.LocDatoStorico(AData) then
  begin
    sCodiceCommessa:=QSCommessa.FieldByName('T430' + Parametri.CampiRiferimento.C8_MissioneCommessa).AsString;
    if sCodiceCommessa <> '' then
    begin
      QSource.Close;
      QSource.ReadBuffer:=2000;
      QSource.DeleteVariables;
      QSource.SQL.Clear;
      if A000LookupTabella(Parametri.CampiRiferimento.C8_MissioneCommessa,QSource) then
      begin
        if QSource.VariableIndex('DECORRENZA') >= 0 then
          QSource.SetVariable('DECORRENZA', AData);
        QSource.Close;
        QSource.Open;
        // AOSTA_REGIONE - commessa: 2013/031 VARIE#1.ini
        // bugfix: il codice della commessa viene sempre ridefinito con l'alias "codice"
        //QSource.Filter := sCodice + '=' + '''' + sCodiceCommessa + '''';
        QSource.Filter := 'CODICE=' + '''' + sCodiceCommessa + '''';
        // AOSTA_REGIONE - commessa: 2013/031 VARIE#1.fine
        QSource.Filtered:=True;
        if not QSource.Eof then
          if QSource.FieldByName('DESCRIZIONE').AsString <> '' then
            sDescrizione:=QSource.FieldByName('DESCRIZIONE').AsString;
        QSource.Filtered:=False;
      end;
    end;
  end;
  QSCommessa.Free;
end;

function TA100FMissioniMW.EstArrotondamento(Valore: Real): Real;
var
  Ret: Real;
begin
  Ret:=Valore;
  if (Q050.Active) and (FSelM040_Funzioni.Active) and (Q010.Active) then
  begin
    P050Est.Close;
    P050Est.SetVariable('CODICE', Q050.FieldByName('COD_VALUTA_EST').AsString);
    P050Est.SetVariable('DECORRENZA', FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
    P050Est.SetVariable('CODARR', Q010.FieldByName('ARROTTOTIMPORTIDATIPAGHE').AsString);
    P050Est.Open;
    if P050Est.RecordCount > 0 then
      Ret:=R180Arrotonda(Valore, P050Est.FieldByName('VALORE').AsFloat, P050Est.FieldByName('TIPO').AsString);
  end;
  Result:=Ret;
end;

procedure TA100FMissioniMW.AggiornaDati;
begin
  if SelAnagrafe = nil then
    Exit;

  QM021.Close;
  M051.Close;
  {$IFNDEF WEBPJ}
  Q050.Close;
  QM052.Close;
  // AOSTA_REGIONE - commessa: 2013/031 VARIE#1.ini
  // bugfix: occorre chiudere il dataset dei servizi attivi in tutti i casi,
  // per la corretta valutazione delle abilitazioni della relativa toolbar
  selM043.Close;
  // AOSTA_REGIONE - commessa: 2013/031 VARIE#1.fine
  {$ENDIF}

  if (FSelM040_Funzioni.FieldByName('PROGRESSIVO').AsInteger <> 0) and
     (FSelM040_Funzioni.FieldByName('MESESCARICO').AsString <> '') and
     (FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsString <> '') and
     (FSelM040_Funzioni.FieldByName('DATADA').AsString <> '') and
     (FSelM040_Funzioni.FieldByName('ORADA').AsString <> '') then
  begin
    // ------------------------------------
    QM011.Close;
    QM011.SetVariable('PROGRESSIVO', SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    if FSelM040_Funzioni.FieldByName('DATADA').IsNull then
      QM011.SetVariable('DATA', Parametri.DataLavoro)
    else
      QM011.SetVariable('DATA', FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);

    QM011.SetVariable('C8_MISSIONI', Parametri.CampiRiferimento.C8_Missione);
    QM011.Open;
    // INDENNITA' CHILOMETRICA
    QM021.SetVariable('DECORRENZA', FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
    QM021.Open;
    // Valorizzo i rimborsi già inseriti...
    Q050.Close;
    Q050.SetVariable('PROG', SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    Q050.SetVariable('MSCARICO', FSelM040_Funzioni.FieldByName('MESESCARICO').AsDateTime);
    Q050.SetVariable('MCOMPETENZA', FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsDateTime);
    Q050.SetVariable('DDA', FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
    Q050.SetVariable('ODA', FSelM040_Funzioni.FieldByName('ORADA').AsString);
    Q050.Open;
    // Apro la query del dettaglio rimborsi
    M051.Close;
    M051.SetVariable('PROGRESSIVO', Q050.FieldByName('PROGRESSIVO').AsInteger);
    M051.SetVariable('MESESCARICO', Q050.FieldByName('MESESCARICO').AsDateTime);
    M051.SetVariable('MESECOMPETENZA', Q050.FieldByName('MESECOMPETENZA').AsDateTime);
    M051.SetVariable('DATADA', Q050.FieldByName('DATADA').AsDateTime);
    M051.SetVariable('ORADA', Q050.FieldByName('ORADA').AsString);
    M051.Open;
    // Valorizzo le indennità chilometriche inserite...
    QM052.Close;
    QM052.SetVariable('PROG', SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    QM052.SetVariable('MSCARICO', FSelM040_Funzioni.FieldByName('MESESCARICO').AsDateTime);
    QM052.SetVariable('MCOMPETENZA', FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsDateTime);
    QM052.SetVariable('DDA', FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
    QM052.SetVariable('ODA', FSelM040_Funzioni.FieldByName('ORADA').AsString);
    QM052.Open;
    // apertura dataset dettaglio giornaliero missione
    selM043.Close;
    selM043.SetVariable('ID', FSelM040_Funzioni.FieldByName('ID_MISSIONE').AsInteger);
    selM043.Open;
    // ==============================
    // VALORIZZO DCMBLOOKUPCODTTARIFF
    // ==============================
    selM065.Close;
    selM065.SetVariable('DATOLIB', Parametri.CampiRiferimento.C8_Missione);
    selM065.SetVariable('PROGRESSIVO', SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selM065.SetVariable('DATA', FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
    selM065.Open;
    // ================================
    // VALORIZZO DCMBLOOKUPCODRIDUZIONE
    // ================================
    selM066.Close;
    selM066.SetVariable('DATOLIB', Parametri.CampiRiferimento.C8_Missione);
    selM066.SetVariable('PROGRESSIVO', SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selM066.SetVariable('COD_TARIFF', FSelM040_Funzioni.FieldByName('COD_TARIFFA').AsString);
    selM066.SetVariable('DATA', FSelM040_Funzioni.FieldByName('DATADA').AsString);
    selM066.Open;
  end;
  Q050COD_VALUTA_ESTChange(nil);
  CalcolaTotaleRimborsi;
  CalcolaTotaliIndennitaKm;
end;

procedure TA100FMissioniMW.AggiornaQueryCombo;
var dData: TDateTime;
begin
  if FSelM040_Funzioni.FieldByName('DATAA').AsString <> '' then
    dData:=FSelM040_Funzioni.FieldByName('DATAA').AsDateTime
  else
    dData:=Parametri.DataLavoro;

  //Imposto varibile data su QCommessa
  if QCommessa.VariableIndex('DECORRENZA') >= 0 then
  begin
    if QCommessa.GetVariable('DECORRENZA') <> dData then
    begin
      QCommessa.SetVariable('DECORRENZA', dData);
      QCommessa.Close;
      QCommessa.Open;
    end
  end
  else
    QCommessa.Refresh;
  QCommessa.First;

  ///  // SEDE DI RIFERIMENTO - PARTENZA
  if QSede.VariableIndex('DECORRENZA') >= 0 then
  begin
    if QSede.GetVariable('DECORRENZA') <> dData then
    begin
      QSede.SetVariable('DECORRENZA', dData);
      QSede.Close;
      QSede.Open;
    end;
  end
  else
    QSede.Refresh;
  QSede.First;
end;

procedure TA100FMissioniMW.selM040AfterScroll;
begin
  if SelAnagrafe = nil then
    Exit;

  Azione:='';
  Causale:='';
  CausaleOld:='';
  AggiornaDati;

  // ====================================================
  // REFRESH SULLA VISUALIZZAZIONE DEL TIPO DELLA TARIFFA
  // ====================================================
  if Not(FSelM040_Funzioni.FieldByName('DATAA').IsNull) and (FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString <> '') then
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString,False);

  //per cloud il controllo fatto su dataset2Componenti della griglia
  {$IFNDEF WEBPJ}
  // missione di un giorno solo
  if selM043.Active then
    selM043.FieldByName('DATA').ReadOnly:=FSelM040_Funzioni.FieldByName('DATADA').AsDateTime = FSelM040_Funzioni.FieldByName('DATAA').AsDateTime;
 {$ENDIF}
end;

function TA100FMissioniMW.CaptionTariffaOraria: String;
begin
  if TabTariffe then
    Result:='Tariffa Ind. Oraria: ' + FloatToStr(R180Arrotonda((selM065.FieldByName('IND_GIORNALIERA').AsFloat / 24), 0.0001, 'P'))
  else
    Result:='';
end;

function TA100FMissioniMW.CaptionTariffaQuotaEsente: String;
begin
  if TabTariffe then
    Result:='Tariffa Quota Esente: ' + FloatToStr(R180Arrotonda((selM066.FieldByName('QUOTA_ESENTE').AsFloat / 24),0.0001, 'P'))
  else
    Result:='';
end;

procedure TA100FMissioniMW.cdsM141CalcFields(DataSet: TDataSet);
var
  LKm: Integer;
  LKmInd: Integer;
begin
  LKm:=DataSet.FieldByName('KM').AsInteger;
  LKmInd:=DataSet.FieldByName('KM_IND').AsInteger;

  DataSet.FieldByName('D_KM').AsString:=IfThen(LKm = -1,'-',LKm.ToString);
  DataSet.FieldByName('D_KM_IND').AsString:=IfThen(LKmInd <= 0,'-',LKmInd.ToString);
end;

procedure TA100FMissioniMW.M040AfterOpen;
begin
  if  (SelAnagrafe <> nil) and (FSelM040_Funzioni.RecordCount > 0) then
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
end;

procedure TA100FMissioniMW.M040DATAAValidate;
begin
  if FSelM040_Funzioni.State in [dsEdit, dsInsert] then
    FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsDateTime:=R180InizioMese(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);

  if FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').IsNull then
    exit;

  if Not(TabTariffe) then
    ElaboraMissione
  else
    ElaboraDaTariffe;
end;

procedure TA100FMissioniMW.M040INDINTERAValidate;
var
  Importo: Real;
begin
  if (FSelM040_Funzioni.FieldByName('TARIFFAINDINTERA').AsFloat <> 0) and (FSelM040_Funzioni.FieldByName('OREINDINTERA').AsFloat <> 0) then
  begin
    // Leggo il valore numerico dell'arrotondamento dalla tabellaP050 passando il codice di
    // arrotondamento e la data di decorrenza
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString,False);
    GetArrotondamento(Q010.FieldByName('ARROTTOTIMPORTIDATIPAGHE').AsString,FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
    Importo:=FSelM040_Funzioni.FieldByName('TARIFFAINDINTERA').AsFloat * FSelM040_Funzioni.FieldByName('OREINDINTERA').AsFloat;
    FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsFloat:=R180Arrotonda(Importo,nPb_Arrotondamento, sPb_Tipo);
  end
  else
    FSelM040_Funzioni.FieldByName('IMPORTOINDINTERA').AsInteger:=0;
end;

procedure TA100FMissioniMW.M040INDRIDOTTAHValidate;
var
  Importo: Real;
begin
  if (FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAH').AsFloat <> 0) and (FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').AsFloat <> 0) then
  begin
    // Leggo il valore numerico dell'arrotondamento dalla tabellaP050 passando il codice di
    // arrotondamento e la data di decorrenza
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString,False);
    GetArrotondamento(Q010.FieldByName('ARROTTOTIMPORTIDATIPAGHE').AsString, FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
    Importo:=FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAH').AsFloat * FSelM040_Funzioni.FieldByName('OREINDRIDOTTAH').AsFloat;
    FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsFloat:=R180Arrotonda(Importo,nPb_Arrotondamento, sPb_Tipo);
  end
  else
   FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAH').AsInteger:=0;
end;

procedure TA100FMissioniMW.M040INDRIDOTTAGValidate;
var Importo: Real;
begin
  if (FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAG').AsFloat <> 0) and (FSelM040_Funzioni.FieldByName('OREINDRIDOTTAG').AsFloat <> 0) then
  begin
    // Leggo il valore numerico dell'arrotondamento dalla tabellaP050 passando il codice di
    // arrotondamento e la data di decorrenza
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
    GetArrotondamento(Q010.FieldByName('ARROTTOTIMPORTIDATIPAGHE').AsString,FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
    Importo:=FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAG').AsFloat * FSelM040_Funzioni.FieldByName('OREINDRIDOTTAG').AsFloat;
    FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAG').AsFloat:=R180Arrotonda(Importo,nPb_Arrotondamento, sPb_Tipo);
  end
  else
    FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAG').AsInteger:=0;
end;

procedure TA100FMissioniMW.M040INDRIDOTTAHGValidate;
var Importo: Real;
begin
  if (FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAHG').AsFloat <> 0) and (FSelM040_Funzioni.FieldByName('OREINDRIDOTTAHG').AsFloat <> 0) then
  begin
    // Leggo il valore numerico dell'arrotondamento dalla tabellaP050 passando il codice di
    // arrotondamento e la data di decorrenza
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
    GetArrotondamento(Q010.FieldByName('ARROTTOTIMPORTIDATIPAGHE').AsString,FSelM040_Funzioni.FieldByName('DATADA').AsDateTime);
    Importo:=FSelM040_Funzioni.FieldByName('TARIFFAINDRIDOTTAHG').AsFloat * FSelM040_Funzioni.FieldByName('OREINDRIDOTTAHG').AsFloat;
    FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAHG').AsFloat:=R180Arrotonda(Importo,nPb_Arrotondamento, sPb_Tipo);
  end
  else
    FSelM040_Funzioni.FieldByName('IMPORTOINDRIDOTTAHG').AsInteger:=0;
end;

procedure TA100FMissioniMW.FiltraRegoleIndennita(bApplica:Boolean = True);
var i:integer;
    sCodiciIndennitaKm:TStringList;
    sDep:string;
    dDataDecorrenza:TDateTime;
begin
  //A seconda della tipologia di missione, se sono impostati filtri nelle regole
  //applico tali filtri alle indennità km ed ai rimborsi.
  dDataDecorrenza:=QM021.GetVariable('DECORRENZA');
  QM021.Close;
  QM021.ClearVariables;
  QM021.SetVariable('DECORRENZA',dDataDecorrenza);
  if bApplica then
  begin
    sDep:='';
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').asDatetime,FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
    sCodiciIndennitaKm:=TStringList.Create;
    sCodiciIndennitaKm.CommaText:=Q010.FieldByName('CODICI_INDENNITAKM').AsString;
    for i:=0 to sCodiciIndennitaKm.Count-1 do
      if sDep='' then
        sDep:='''' + sCodiciIndennitaKm[i] + ''''
      else
        sDep:= sDep + ',''' + sCodiciIndennitaKm[i] + '''';
    sCodiciIndennitaKm.Free;
    if sDep<>'' then
    begin
      sDep:='AND CODICE IN (' + sDep + ')';
      QM021.SetVariable('FILTRO',sDep);
    end;
  end;
  QM021.Open;
end;

procedure TA100FMissioniMW.ImpostaSelM041;
begin
  SelM041.Close;
  SelM041.ClearVariables;
  SelM041.SetVariable('ORDERBY','ORDER BY PARTENZA ASC, DESTINAZIONE ASC');
  SelM041.Open;
end;

procedure TA100FMissioniMW.CambioDate;
begin
  if FSelM040_Funzioni.State in [dsInsert, dsEdit] then
  begin
    if (FSelM040_Funzioni.FieldByName('DATADA').AsString = '') and (FSelM040_Funzioni.FieldByName('DATAA').AsString = '') then
      FSelM040_Funzioni.FieldByName('DATADA').AsDateTime:=Parametri.DataLavoro;
    if (FSelM040_Funzioni.FieldByName('DATADA').AsString <> '') and (FSelM040_Funzioni.FieldByName('DATAA').AsString = '') then
      FSelM040_Funzioni.FieldByName('DATAA').AsDateTime:=FSelM040_Funzioni.FieldByName('DATADA').AsDateTime;
    QM011.Close;
    QM011.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    QM011.SetVariable('C8_MISSIONI',Parametri.CampiRiferimento.C8_Missione);
    selM065.Close;
    selM065.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selM065.SetVariable('DATOLIB',Parametri.CampiRiferimento.C8_Missione);
    selM066.Close;
    selM066.SetVariable('DATOLIB',Parametri.CampiRiferimento.C8_Missione);
    selM066.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selM066.SetVariable('COD_TARIFF',FSelM040_Funzioni.FieldByName('COD_TARIFFA').AsString);
    //Caratto 17/12/2013. non veniva impostatata data ma solo in change di Field DATADA
    selM066.SetVariable('DATA', FSelM040_Funzioni.FieldByName('DATADA').AsString);

    if FSelM040_Funzioni.FieldByName('DATAA').IsNull then
    begin
      QM011.SetVariable('DATA',Parametri.DataLavoro);
      selM065.SetVariable('DATA',Parametri.DataLavoro);
    end
    else
    begin
      QM011.SetVariable('DATA',FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
      selM065.SetVariable('DATA',FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
    end;
    QM011.Open;
    selM065.Open;
    selM066.Open;
  end;
end;

procedure TA100FMissioniMW.M040MESESCARICOValidate;
var
  Year, Month, Day: Word;
begin
  // Propongo in automatico il mese di compenza se non c'è nulla di impostato...
  // if (M040MESECOMPETENZA.AsString = '') or (M040.DataSource.State = dsInsert) then
  if (FSelM040_Funzioni.State = dsInsert) and (FSelM040_Funzioni.FieldByName('DATADA').AsString = '')
      and (FSelM040_Funzioni.FieldByName('DATAA').AsString = '') then
  begin
    DecodeDate(FSelM040_Funzioni.FieldByName('MESESCARICO').AsDateTime, Year, Month, Day);
    if Month = 1 then
      FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsDateTime:=EncodeDate(Year - 1, 12, 1)
    else
      FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsDateTime:=EncodeDate(Year, Month - 1, 1);
  end;
end;

procedure TA100FMissioniMW.M040DATADAValidate;
begin
  if (FSelM040_Funzioni.FieldByName('DATAA').AsString <> '') and
     (FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString <> '') then
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
  if Not(TabTariffe) then
    ElaboraMissione
  else
    ElaboraDaTariffe;
end;

procedure TA100FMissioniMW.M040ORAValidate(Sender: TField);
begin
  if not(Sender.IsNull) then
    R180OraValidate(Sender.AsString);

  if (FSelM040_Funzioni.FieldByName('DATAA').AsString <> '') and (FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString <> '') then
  begin
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString,False);
    if Not(TabTariffe) then
      ElaboraMissione
    else
      ElaboraDaTariffe;
  end;
end;

procedure TA100FMissioniMW.FiltraRegoleRimborsi(bApplica:Boolean = True);
var i:integer;
    sCodiciRimborsi:TStringList;
    sDep:string;
    Q050Pos:TBookmark;
begin
  //A seconda della tipologia di missione, se sono impostati filtri nelle regole
  //applico tali filtri alle indennità km ed ai rimborsi.
  Q050Pos:=Q050.GetBookmark;
  Q020.Close;
  Q020.ClearVariables;
  if bApplica then
  begin
    sDep:='';
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').asDatetime,FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
    sCodiciRimborsi:=TStringList.Create;
    sCodiciRimborsi.CommaText:=Q010.FieldByName('CODICI_RIMBORSI').AsString;
    for i:=0 to sCodiciRimborsi.Count-1 do
      if sDep='' then
        sDep:='''' + sCodiciRimborsi[i] + ''''
      else
        sDep:= sDep + ',''' + sCodiciRimborsi[i] + '''';
    sCodiciRimborsi.Free;
    if sDep <> '' then
    begin
      sDep:='WHERE CODICE IN (' + sDep + ')';
      Q020.SetVariable('FILTRO',sDep);
    end;
  end;
  Q020.Open;
  Q050.Refresh;
  Q050.GotoBookmark(Q050Pos);
end;

procedure TA100FMissioniMW.VerificaRimborsoPastoEsistente;
(*obsoleto??*)
begin
  bPb_RimborsoPastoEsistente:=True;
  //iPb_ImportoRimborsoPasto:=0;
  //iPb_ImportoIndennita:=0;
  LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').asDatetime,FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
  if Q010.FieldByName('RIDUZIONE_PASTO').AsString = 'S' then
  begin
    //Devo verifica se è stato riconosciuto per la missione corrente un buono pasto... ed eventualmente abbattere l'indennità
    if not FSelM040_Funzioni.FieldByName('DATAA').IsNull then
    begin
      //sPb_CodiceRimborsoPasto:=Q010.FieldByName('CODRIMBORSOPASTO').AsString;
      //Verifico se tra i rimborsi caricati esista quello del pasto... e se lo trovo ne leggo gli importi...
      //if Not Q050.SearchRecord('CODICERIMBORSOSPESE',sPb_CodiceRimborsoPasto,[srFromBeginning]) then
      if not Q050.SearchRecord('TIPO',M020TIPO_PASTO,[srFromBeginning]) then
        bPb_RimborsoPastoEsistente:=False
      else if Q050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat = 0 then
        bPb_RimborsoPastoEsistente:=False;
      (*
      else
      begin
        iPb_ImportoRimborsoPasto:=Q050IMPORTORIMBORSOSPESE.AsFloat;
        iPb_ImportoIndennita:=Q050IMPORTOINDENNITASUPPLEMENTARE.AsFloat;
      end;
      *)
    end;
  end;
end;

function TA100FMissioniMW.VerificaDettaglioRimborsi: String;
begin
  Result:='';
  {Se la regola prevede gli scaglioni cumulativi impedisco l'apertura della maschera per dettagliare il rimborso}
  LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').asDatetime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString, False);
  if (Q010.FieldByName('TIPO_RIMBORSOPASTO').AsString = '1') and (Q050TIPO.AsString = M020TIPO_PASTO) then
  begin
    Result:=A000MSG_A100_ERR_DETT_SCAGLIONI;
    Exit;
  end;

  //Se manca il codice del rimborso non faccio dettagliare...
  if (Q050.FieldByName('CODICERIMBORSOSPESE').IsNull) then
  begin
    Result:=A000MSG_A100_ERR_DETT_NO_CODICE;
    Exit;
  end;

  //Se il rimborso è un acconto non faccio dettagliare...
  if Q050.FieldByName('flag_anticipo').AsString='S' then
  begin
    Result:=A000MSG_A100_ERR_DETT_ANTICIPO;
    Exit;
  end;

  //Se ho già indicato l'importo del rimborso nella griglia, non posso più dettagliarlo...
  if (Q050.FieldByName('IMPORTORIMBORSOSPESE').AsCurrency <> 0) and (M051.RecordCount = 0) then
  begin
    Result:=A000MSG_A100_ERR_DETT_IMP_RIMB;
    Exit;
  end;
end;

function TA100FMissioniMW.CostiDettaglio: TCostiDettaglio;
begin
  Result.nCosto:=0;
  Result.EstCosto:=0;
  Result.nRimborso:=0;
  Result.EstRimborso:=0;
  M051.First;
  while not M051.Eof do
  begin
    if M051.FieldByName('SOMMA').AsString = 'S' then
    begin
      Result.nRimborso:=Result.nRimborso + M051.FieldByName('IMPORTO').AsFloat;
      Result.EstCosto:=Result.EstCosto + M051.FieldByName('IMPORTO_VALEST').AsFloat;
    end;
    Result.EstRimborso:=Result.EstRimborso + M051.FieldByName('IMPORTO_VALEST').AsFloat;
    Result.nCosto:=Result.nCosto + M051.FieldByName('IMPORTO').AsFloat;
    M051.Next;
  end;
end;

function TA100FMissioniMW.RicalcolaDeleteRimborso(bSegnalazionePastoOldValue:boolean):String;
begin
  Result:='';
  LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').asDatetime,FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
  if (Q010.FieldByName('RIDUZIONE_PASTO').AsString = 'S') then
  begin
    FSelM040_Funzioni.Edit;
    if not TabTariffe  then
      ElaboraMissione
    else
      ElaboraDaTariffe;
    FSelM040_Funzioni.Post;
    FSelM040_Funzioni.Session.Commit;
    SessioneOracle.ApplyUpdates([FSelM040_Funzioni],True);
    VerificaRimborsoPastoEsistente;
    if bSegnalazionePastoOldValue and (not bPb_RimborsoPastoEsistente) then
      Result:=A000MSG_A100_MSG_IMP_RICALC_CANC;
  end;
end;

function TA100FMissioniMW.GestioneMese: String;
var evBeforePost:TEvDataset;
begin
  Result:='';
  if Parametri.CampiRiferimento.C8_GestioneMensile <> 'N' then //Se si tratta di Gestione mensile faccio la verifica sulla riduzione del rimborso pasto
  begin
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').asDatetime,FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
    if Q010.FieldByName('RIDUZIONE_PASTO').AsString = 'S' then
    begin
      FSelM040_Funzioni.Edit;
      if not TabTariffe then
        ElaboraMissione
      else
        ElaboraDaTariffe;
        evBeforePost:=FSelM040_Funzioni.BeforePost;
        FSelM040_Funzioni.BeforePost:=nil;
        FSelM040_Funzioni.Post;
        FSelM040_Funzioni.BeforePost:=evBeforePost;
        FSelM040_Funzioni.Session.Commit;
        if bPv_SegnalazionePasto then
          Result:=A000MSG_A100_MSG_IMP_RICALC;
      end;
    end;
end;

procedure TA100FMissioniMW.ControlliObbligatorieta;
begin
  if (FSelM040_Funzioni.State in [dsInsert, dsEdit]) then
  begin
    // CONTROLLO SUI VALORI OBBLIGATORI DELLE MISSIONI
    if FSelM040_Funzioni.FieldByName('MESESCARICO').AsString = '' then
    begin
      FSelM040_Funzioni.FieldByName('MESESCARICO').FocusControl;
      //A100UMISSIONI.A100FMissioni.dedtPeriodo.SetFocus;
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_PERIODO]));
    end;
    // if m040MeseCompetenza.AsString = '' then
    // begin
    // a100umissioni.A100FMISSIONI.dedtCompetenza.SetFocus;
    // raise Exception.Create('Indicare la competenza.');
    // end;
    if FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString = '' then
    begin
      FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').FocusControl;
      //A100UMISSIONI.A100FMissioni.dCmbTipoMissione.SetFocus;
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_TIPOLOGIA]));
    end;
    if FSelM040_Funzioni.FieldByName('DATADA').AsString = '' then
    begin
      FSelM040_Funzioni.FieldByName('DATADA').FocusControl;
      //A100UMISSIONI.A100FMissioni.dedtDataDa.SetFocus;
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_DATA_INIZIO]));
    end;
    if FSelM040_Funzioni.FieldByName('DATAA').AsString = '' then
    begin
      FSelM040_Funzioni.FieldByName('DATAA').FocusControl;
      //A100UMISSIONI.A100FMissioni.dedtDataA.SetFocus;
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_DATA_FINE]));
    end;
    if FSelM040_Funzioni.FieldByName('ORADA').AsString = '' then
    begin
      FSelM040_Funzioni.FieldByName('ORADA').FocusControl;
      //A100UMISSIONI.A100FMissioni.dedtOraDa.SetFocus;
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_ORA_INIZIO]));
    end;
    if FSelM040_Funzioni.FieldByName('ORAA').AsString = '' then
    begin
      FSelM040_Funzioni.FieldByName('ORAA').FocusControl;
      //A100UMISSIONI.A100FMissioni.dedtOraA.SetFocus;
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_ORA_FINE]));
    end;
    if TabTariffe then
    begin
      if FSelM040_Funzioni.FieldByName('COD_TARIFFA').AsString = '' then
      begin
        FSelM040_Funzioni.FieldByName('COD_TARIFFA').FocusControl;
        //A100FMissioni.DCmbLookpCodTariff.SetFocus;
        raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_COD_TARIFFA]));
      end;
      if FSelM040_Funzioni.FieldByName('COD_RIDUZIONE').AsString = '' then
      begin
        FSelM040_Funzioni.FieldByName('COD_RIDUZIONE').FocusControl;
        //A100FMissioni.DCmbLookUpCodRiduzione.SetFocus;
        raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_COD_RIDUZIONE]));
      end;
    end;
    if FSelM040_Funzioni.FieldByName('PROTOCOLLO').IsNull and (Parametri.CampiRiferimento.C8_ProtocolloObbligatorio = 'S') then
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_PROTOCOLLO]));
    // FINE CONTROLLO SUI CAMPI OBBLIGATORI...
  end;
end;

procedure TA100FMissioniMW.M040BeforePostPasso1;
begin
  Azione:=IfThen(FSelM040_Funzioni.State = dsInsert, 'I', 'M');

  CausaleOld := '';
  try
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').OldValue, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').OldValue);
    if RegoleTrovate then
      CausaleOld:=Q010.FieldByName('CAUSALE_MISSIONE').AsString;
  except
  end;
  DataDaOld:=VarToStr(FSelM040_Funzioni.FieldByName('DATADA').OldValue);
  DataAOld:=VarToStr(FSelM040_Funzioni.FieldByName('DATAA').OldValue);
  OraDaOld:=VarToStr(FSelM040_Funzioni.FieldByName('ORADA').OldValue);
  OraAOld:=VarToStr(FSelM040_Funzioni.FieldByName('ORAA').OldValue);

  Causale:='';
  LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
  if Not RegoleTrovate then
    Abort;
  Causale:=Q010.FieldByName('CAUSALE_MISSIONE').AsString;
  CopreDebito:=Q010.FieldByName('GIUSTIF_COPRE_DEBITOGG').AsString;
  OreMax:=Q010.FieldByName('GIUSTIF_HHMAX').AsString;
  DataDa:=FSelM040_Funzioni.FieldByName('DATADA').AsString;
  DataA:=FSelM040_Funzioni.FieldByName('DATAA').AsString;
  OraDa:=FSelM040_Funzioni.FieldByName('ORADA').AsString;
  OraA:=FSelM040_Funzioni.FieldByName('ORAA').AsString;

  // Controlli di Obbligatorietà
  ControlliObbligatorieta;

  // Controllo formale sui campi con generazione di errore...
  ControlliFormali(True);
end;

function TA100FMissioniMW.TestMeseScarico: Boolean;
var ScaricoAA, ScaricoMM, ScaricoGG, MissioneAA, MissioneMM, MissioneGG: Word;
begin
  // Controllo che la "data missione" non sia successiva alla "data di scarico"
  // se si chiedo conferma all'operatore sull'inserimento del record
  Result:=False;
  if (FSelM040_Funzioni.FieldByName('MESESCARICO').OldValue <> FSelM040_Funzioni.FieldByName('MESESCARICO').Value) or
     (FSelM040_Funzioni.FieldByName('DATADA').OldValue <> FSelM040_Funzioni.FieldByName('DATADA').Value) then
  begin
    DecodeDate(FSelM040_Funzioni.FieldByName('MESESCARICO').AsDateTime, ScaricoAA, ScaricoMM, ScaricoGG);
    DecodeDate(FSelM040_Funzioni.FieldByName('DATADA').AsDateTime, MissioneAA, MissioneMM, MissioneGG);
    if (MissioneAA > ScaricoAA) or ((MissioneAA >= ScaricoAA) and (MissioneMM > ScaricoMM)) then
      Result:=True;
  end;
end;

function TA100FMissioniMW.M040BeforePostPasso2:String;
var s: String;
begin
  Result:='';
  // ************************************************************************************
  // ***************************** ERRORI BLOCCANTI *************************************
  // ************************************************************************************
  // SE ESISTE GIA' UNA MISSIONE CON LA STESSI progressivo + mesecompetenza + datada + orada non permetto di inserire la nuova missione
  // non prendo in considerazione il mese di scarico perchè voglio controllare che non esistano 2 missioni nello stesso identico periodo
  OperSQL.Close;
  OperSQL.SQL.Clear;
  s:='select count(*) as numero from m040_missioni t where t.datada = ''' + FSelM040_Funzioni.FieldByName('DATADA').AsString + ''' and t.orada = ''' + FSelM040_Funzioni.FieldByName('ORADA').AsString + ''' and t.progressivo = ' + SelAnagrafe.FieldByName('PROGRESSIVO').AsString;
  if FSelM040_Funzioni.State = dsEdit then
    s:=s + ' and t.rowid <> ''' + FSelM040_Funzioni.RowId + '''';

  OperSQL.SQL.Add(s);
  OperSQL.Execute;
  if OperSQL.FieldAsInteger('NUMERO') > 0 then
    raise Exception.Create(A000MSG_A100_ERR_TRASFERTA_PRESENTE);
  // ************************************************************************************
  // ************************* WARNING MA NON ERRORE BLOCCANTE **************************
  // ************************************************************************************
  bWarning:=False;
  // ---------------------A-------------------------B-----------------------
  // |______________|
  // MISSIONE CONTENUTA
  OperSQL.Close;
  OperSQL.SQL.Clear;
  s:='select count(*) as numero from m040_missioni t where t.datada > ''' + FSelM040_Funzioni.FieldByName('DATADA').AsString + ''' and t.dataa < ''' + FSelM040_Funzioni.FieldByName('DATAA').AsString + ''' and t.progressivo = ' + SelAnagrafe.FieldByName('PROGRESSIVO').AsString;

  if FSelM040_Funzioni.State = dsEdit then
    s:=s +  ' and t.rowid <> ''' + FSelM040_Funzioni.RowId + '''';
  OperSQL.SQL.Add(s);
  OperSQL.Execute;
  if OperSQL.FieldAsInteger('NUMERO') > 0 then
  begin
    Result:=Format(A000MSG_A100_MSG_FMT_TRASFERTA_COMPRESA,[OperSQL.FieldAsString('NUMERO')]);
    bWarning:=True;
  end;

  if not bWarning then
  begin
    // ---------------------A-------------------------B-----------------------
    // |______________________________________|
    // MISSIONE CONTENENTE
    OperSQL.Close;
    OperSQL.SQL.Clear;
    s:='select count(*) as numero from m040_missioni t where t.datada < ''' + FSelM040_Funzioni.FieldByName('DATADA').AsString +
        ''' and t.dataa > ''' + FSelM040_Funzioni.FieldByName('DATAA').AsString + ''' and t.progressivo = ' + SelAnagrafe.FieldByName('PROGRESSIVO').AsString;

    if FSelM040_Funzioni.State = dsEdit then
      s:=s + ' and t.rowid <> ''' + FSelM040_Funzioni.RowId + '''';

    OperSQL.SQL.Add(s);
    OperSQL.Execute;
    if OperSQL.FieldAsInteger('NUMERO') > 0 then
    begin
      Result:=Format(A000MSG_A100_MSG_FMT_TRASFERTA_COMPRENDE,[OperSQL.FieldAsString('NUMERO')]);
      bWarning := True;
    end;
    // if OperSql.FieldAsInteger('NUMERO') > 0 then
    // raise Exception.Create('Esiste già una trasferta che comprende il periodo indicato.');
  end;

  if not bWarning then
  begin
    if (FSelM040_Funzioni.FieldByName('DATAA').AsDateTime - FSelM040_Funzioni.FieldByName('DATADA').AsDateTime) > 0 then
    begin
      // ---------------------A-------------------------B-----------------------
      // |_____________|_ _ _ _ _ _ _ _ _ _ _ |
      //
      // |_ _ _ _ _ _ _ _ _ _ _|___________|
      // MISSIONE  SU + GIORNI CHE INIZIA DOVE INIZIA UN'ALTRA O FINISCE DOVE FINISCE UN'ALLTRA...
      OperSQL.Close;
      OperSQL.SQL.Clear;
      s:='select count(*) as numero from m040_missioni t where ((t.datada = '''+ FSelM040_Funzioni.FieldByName('DATADA').AsString +
         ''' and t.dataa <> ''' + FSelM040_Funzioni.FieldByName('DATADA').AsString + ''') or (t.datada <> ''' + FSelM040_Funzioni.FieldByName('DATAA').AsString +
         ''' and t.dataa = ''' + FSelM040_Funzioni.FieldByName('DATAA').AsString + ''')) and t.progressivo = ' + SelAnagrafe.FieldByName('PROGRESSIVO').AsString;
      if FSelM040_Funzioni.State = dsEdit then
        s:=s+' and t.rowid <> ''' + FSelM040_Funzioni.RowId + '''';

      OperSQL.SQL.Add(s);
      OperSQL.Execute;
      if OperSQL.FieldAsInteger('NUMERO') > 0 then
      begin
        Result:=Format(A000MSG_A100_MSG_FMT_TRASFERTA_PERIODO,[OperSQL.FieldAsString('NUMERO')]);
        bWarning := True;
      end;
      // if OperSql.FieldAsInteger('NUMERO') > 0 then
      // raise Exception.Create('Esiste già una trasferta per il periodo indicato.');
    end;
  end;

  if not bWarning then
  begin
    // ---------------------A-------------------------B-----------------------
    // |_____________________|
    // |_____________________|
    // MISSIONE CHE SI ACCAVALLA CON QUELLA DATA
    OperSQL.Close;
    OperSQL.SQL.Clear;
    s:='select count(*) as numero from m040_missioni t where ((t.datada > ''' + FSelM040_Funzioni.FieldByName('DATADA').AsString +
       ''' and t.datada < ''' + FSelM040_Funzioni.FieldByName('DATAA').AsString + ''') or (t.dataa > ''' + FSelM040_Funzioni.FieldByName('DATADA').AsString +
       ''' and t.dataa < ''' + FSelM040_Funzioni.FieldByName('DATAA').AsString + ''')) and t.progressivo = ' + SelAnagrafe.FieldByName('PROGRESSIVO').AsString;

    if FSelM040_Funzioni.State = dsEdit then
      s:=s + ' and t.rowid <> ''' + FSelM040_Funzioni.RowId + '''';

    OperSQL.SQL.Add(s);
    OperSQL.Execute;
    if OperSQL.FieldAsInteger('NUMERO') > 0 then
    begin
      Result:=Format(A000MSG_A100_MSG_FMT_TRASFERTA_PERIODO_PARZ,[OperSQL.FieldAsString('NUMERO')]);
      bWarning:=True;
    end;
    // if OperSql.FieldAsInteger('NUMERO') > 0 then
    // raise Exception.Create('Esiste già una trasferta che comprende in parte il periodo indicato.');
  end;

  if not bWarning then
  begin
    // ---------------------A-------------------------B-----------------------
    // |_________________________|
    // MISSIONE COINCIDENTE
    OperSQL.Close;
    OperSQL.SQL.Clear;
    s:='select count(*) as numero from m040_missioni t where t.datada = ''' + FSelM040_Funzioni.FieldByName('DATADA').AsString +
       ''' and t.dataa = ''' + FSelM040_Funzioni.FieldByName('DATAA').AsString + ''' and t.progressivo = ' + SelAnagrafe.FieldByName('PROGRESSIVO').AsString;

    if FSelM040_Funzioni.State = dsEdit then
      s:=s + ' and t.rowid <> ''' + FSelM040_Funzioni.RowId + '''';

    OperSQL.SQL.Add(s);
    OperSQL.Execute;
    if OperSQL.FieldAsInteger('NUMERO') > 0 then
    begin
      Result:=Format(A000MSG_A100_MSG_FMT_TRASFERTA_DATA,[OperSQL.FieldAsString('NUMERO'),FSelM040_Funzioni.FieldByName('DATADA').AsString,FSelM040_Funzioni.FieldByName('DATAA').AsString]);
      bWarning := True;
    end;
  end;

  if not bWarning then
  begin
    // Nel caso in cui si rilevi una missione esistente che termina lo stesso giorno in cui un'altra inizia oppure
    // Inizi lo stesso giorno in cui un'altra termina, do soltanto una comunicazione warning, ma non blocco l'inserimento
    // ---------------------A-------------------------B-----------------------
    // |__________________|
    OperSQL.Close;
    OperSQL.SQL.Clear;
    s:='select count(*) as numero from m040_missioni t where t.dataa = ''' + FSelM040_Funzioni.FieldByName('DATADA').AsString + ''' and t.progressivo = ' + SelAnagrafe.FieldByName('PROGRESSIVO').AsString;

    if FSelM040_Funzioni.State = dsEdit then
      s:=s + ' and t.rowid <> ''' + FSelM040_Funzioni.RowId + '''';

    OperSQL.SQL.Add(s);
    OperSQL.Execute;
    if OperSQL.FieldAsInteger('NUMERO') > 0 then
    begin
      Result:=Format(A000MSG_A100_MSG_FMT_TRASFERTA_TERMINA,[FSelM040_Funzioni.FieldByName('DATADA').AsString]);
      bWarning := True;
    end;
  end;

  if not bWarning then
  begin
    // ---------------------A-------------------------B-----------------------
    // |_________________|
    OperSQL.Close;
    OperSQL.SQL.Clear;
    s:='select count(*) as numero from m040_missioni t where t.datada = ''' + FSelM040_Funzioni.FieldByName('DATAA').AsString +
       ''' and t.progressivo = ' + SelAnagrafe.FieldByName('PROGRESSIVO').AsString;

    if FSelM040_Funzioni.State = dsEdit then
      s:=s + ' and t.rowid <> ''' + FSelM040_Funzioni.RowId + '''';

    OperSQL.SQL.Add(s);
    OperSQL.Execute;
    if OperSQL.FieldAsInteger('NUMERO') > 0 then
    begin
      Result:=Format(A000MSG_A100_MSG_FMT_TRASFERTA_INIZIA,[FSelM040_Funzioni.FieldByName('DATAA').AsString]);
    end;
  end;
end;

function TA100FMissioniMW.AnticipiDaUnire: String;
begin
  Result:='';
  if (FSelM040_Funzioni.State <> dsEdit) and (FSelM040_Funzioni.State <> dsInsert) then
    exit;
  SelM060.Close;
  SelM060.SetVariable('PROGRESSIVO', FSelM040_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  SelM060.SetVariable('FILTRO', ' AND M060.DATA_MISSIONE=TO_DATE(''' + FSelM040_Funzioni.FieldByName('DATADA').AsString + ''',''DD/MM/YYYY'')');
  SelM060.Open;
  if (SelM060.RecordCount > 0) then
  begin
    // ==================================
    // COMPOSIZIONE MESSAGGIO DI CONFERMA
    // ==================================
    Result:=A000MSG_A100_MSG_COLLEGA_ANTICIPI;
    SelM060.First;
    while Not(SelM060.Eof) do
    begin
      Result:=Result + Format(A000MSG_A100_MSG_FMT_ANTICIPO_COLL,[SelM060.FieldByName('COD_VOCE').AsString,SelM060.FieldByName('IMPORTO').AsString]);
      SelM060.Next;
    end;
  end;
end;

// ===========================================
// COLLEGAMENTO MISSIONE CON RELATIVI ANTICIPI
// ===========================================
function TA100FMissioniMW.UnisciAnticipi:String;
var AusImp: String;
begin
  Result:='';
  SelM060.First;
  while Not(SelM060.Eof) do
  begin
    InsM050.SQL.Clear;
    InsM050.SQL.Add('INSERT INTO M050_RIMBORSI(');
    InsM050.SQL.Add('PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA, CODICERIMBORSOSPESE, IMPORTORIMBORSOSPESE) ');
    InsM050.SQL.Add('VALUES(' + FSelM040_Funzioni.FieldByName('PROGRESSIVO').AsString + ', ');
    InsM050.SQL.Add('TO_DATE(''' + FSelM040_Funzioni.FieldByName('MESESCARICO').AsString + ''',''DD/MM/YYYY''), ');
    InsM050.SQL.Add('TO_DATE(''' + FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsString + ''',''DD/MM/YYYY''), ');
    InsM050.SQL.Add('TO_DATE(''' + FSelM040_Funzioni.FieldByName('DATADA').AsString + ''',''DD/MM/YYYY''), ');
    InsM050.SQL.Add('''' + FSelM040_Funzioni.FieldByName('ORADA').AsString + ''', ');
    InsM050.SQL.Add('''' + SelM060.FieldByName('COD_VOCE').AsString + ''', ');
    AusImp:='0';
    if SelM060.FieldByName('IMPORTO').AsFloat <> 0 then
      AusImp:=StringReplace(SelM060.FieldByName('IMPORTO').AsString,',', '.', [rfReplaceAll]);
    InsM050.SQL.Add(AusImp + ')');
    try
      SelM020.Close;
      SelM020.SetVariable('COD_RIMB',
      SelM060.FieldByName('COD_VOCE').AsString);
      SelM020.Open;
      if (SelM020.RecordCount > 0) then
      begin
        // ==============================================================================
        // VERIFICO CHE GLI ANTICIPI SIANO GESTIBILI DALLA REGOLA ASSOCIATA ALLA MISSIONE
        // ==============================================================================
        if (Length(Q010.FieldByName('CODICI_RIMBORSI').AsString) > 0) and
           (pos(SelM060.FieldByName('COD_VOCE').AsString, Q010.FieldByName('CODICI_RIMBORSI').AsString) = 0) then
        begin
          Result:=Result + Format(A000MSG_A100_MSG_FMT_ANT_REGOLA,[SelM060.FieldByName('COD_VOCE').AsString])
        end
        else
        begin
          InsM050.Execute;
          // =============================================
          // REGISTRAZIONE LOG SU INSERIMENTO TABELLA M050
          // =============================================
          RegistraLog.SettaProprieta('M', 'M050_RIMBORSI',NomeOwner, nil, True);
          RegistraLog.InserisciDato('PROGRESSIVO', '', FSelM040_Funzioni.FieldByName('PROGRESSIVO').AsString);
          RegistraLog.InserisciDato('MESESCARICO', '', FSelM040_Funzioni.FieldByName('MESESCARICO').AsString);
          RegistraLog.InserisciDato('MESECOMPETENZA', '',FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsString);
          RegistraLog.InserisciDato('DATADA', '', FSelM040_Funzioni.FieldByName('DATADA').AsString);
          RegistraLog.InserisciDato('ORADA', '', FSelM040_Funzioni.FieldByName('ORADA').AsString);
          RegistraLog.InserisciDato('CODICERIMBORSOSPESE', '', SelM060.FieldByName('COD_VOCE').AsString);
          RegistraLog.InserisciDato('IMPORTORIMBORSOSPESE', '', SelM060.FieldByName('IMPORTO').AsString);
          RegistraLog.RegistraOperazione;
          // =============================================
          SelM060.Edit;
          SelM060.FieldByName('DATA_IMPOSTAZIONE_STATO').AsDateTime:=Trunc(R180SysDate(SessioneOracle));
          SelM060.FieldByName('STATO').AsString:='P';
          SelM060.FieldByName('ID_MISSIONE').AsInteger:=FSelM040_Funzioni.FieldByName('ID_MISSIONE').AsInteger;
          // ==========================================
          // REGISTRAZIONE LOG SU MODIFICA TABELLA M060
          // ==========================================
          RegistraLog.SettaProprieta('M', R180Query2NomeTabella(SelM060),NomeOwner, SelM060, True);
          SelM060.Post;
          RegistraLog.RegistraOperazione;
          // ==========================================
          SessioneOracle.Commit;
        end;
      end
      else
      begin
        Result:=Result + Format(A000MSG_A100_MSG_FMT_VOCE_NO_RIMB,[SelM060.FieldByName('COD_VOCE').AsString]);
      end;
    except
      Result:=Result + A000MSG_A100_MSG_ANT_GIA_INS +
              Format(A000MSG_A100_MSG_FMT_ANTICIPO_COLL,[SelM060.FieldByName('COD_VOCE').AsString,SelM060.FieldByName('IMPORTO').AsString]);
    end;
    SelM060.Next;
  end;
end;

function TA100FMissioniMW.AnticipiSospesi: String;
begin
  Result:='';
  GrpM060.Close;
  GrpM060.SetVariable('PROGRESSIVO', ProgressivoC700);
  GrpM060.Open;
  if GrpM060.RecordCount > 0 then
  begin
    Result:='Anticipi sospesi per il dipendente:' + #13#10#13#10;
    GrpM060.First;
    while Not(GrpM060.Eof) do
    begin
      Result:=Result + Format(A000MSG_A100_MSG_FMT_SOSP,[GrpM060.FieldByName('NROSOSP').AsString,GrpM060.FieldByName('DATA_MISSIONE').AsString,GrpM060.FieldByName('IMPORTO').AsString]);
      GrpM060.Next;
    end;
  end;
end;

procedure TA100FMissioniMW.ApriDatasetPercorso(PId: Integer);
// apre il dataset del percorso e imposta il clientdataset da visualizzare con i km
var
  LTappa: String;
  LDeltaKm, LDeltaKmPos, LTotKm, LTotKmInd: Integer;
  LFlagIndKmCorr: String;
  LTipoPrec: String;
  LLocalitaPrec: String;
  LTipoCorr: String;
  LLocalitaCorr: String;
begin
  selM141.Close;

  if PId <= 0 then
    Exit;

  // se il dataset delle distanze non è attivo lo apre
  if not selM041.Active then
  begin
    selM041.Close;
    selM041.Open;
  end;

  LTipoPrec:='';
  LLocalitaPrec:='';

  cdsM141.ReadOnly:=False;
  cdsM141.EmptyDataSet;

  // dataset percorso
  selM141.SetVariable('ID',FSelM040_Funzioni.FieldByName('ID').AsInteger);
  selM141.Open;
  while not selM141.Eof do
  begin
    // imposta località corrente e flag ind. km
    LFlagIndKmCorr:=selM141.FieldByName('IND_KM').AsString;
    LTipoCorr:=selM141.FieldByName('TIPO_LOCALITA').AsString;
    LLocalitaCorr:=selM141.FieldByName('LOCALITA').AsString;

    cdsM141.Append;

    // tappa
    if selM141.FieldByName('NUMERO_RIGA').AsInteger = 1 then
      LTappa:='Partenza'
    else if selM141.FieldByName('NUMERO_RIGA').AsInteger = selM141.RecordCount then
      LTappa:='Rientro'
    else
    begin
      // distingue i casi di destinazione unica / più tappe
      if selM141.RecordCount = 3 then
        LTappa:='Destinazione'
      else
        LTappa:=Format('Tappa %d:',[selM141.FieldByName('NUMERO_RIGA').AsInteger - 1]);
    end;
    cdsM141.FieldByName('TAPPA').AsString:=LTappa;

    // localita
    cdsM141.FieldByName('LOCALITA').AsString:=selM141.FieldByName('D_LOCALITA').AsString;

    // distanza tratta
    if (LTipoPrec = '') or (LTipoCorr = '') then
    begin
      LDeltaKm:=-1;
    end
    else
    begin
      // cerca distanza tra A e B (A -> B oppure l'equivalente B -> A)
      if selM041.SearchRecord('TIPO1;LOCALITA1;TIPO2;LOCALITA2',VarArrayOf([LTipoPrec,LLocalitaPrec,LTipoCorr,LLocalitaCorr]),[srFromBeginning]) then
      begin
        // trovata distanza A - B
        LDeltaKm:=selM041.FieldByName('CHILOMETRI').AsInteger;
      end
      else if selM041.SearchRecord('TIPO2;LOCALITA2;TIPO1;LOCALITA1',VarArrayOf([LTipoCorr,LLocalitaCorr,LTipoPrec,LLocalitaPrec]),[srFromBeginning]) then
      begin
        // trovata distanza B - A
        LDeltaKm:=selM041.FieldByName('CHILOMETRI').AsInteger;
      end
      else
      begin
        // distanza non trovata
        LDeltaKm:=-1;
      end;
    end;

    // km
    cdsM141.FieldByName('KM').AsInteger:=LDeltaKm;
    cdsM141.FieldByName('IND_KM').AsString:=LFlagIndKmCorr;
    cdsM141.FieldByName('KM_IND').AsInteger:=IfThen(LFlagIndKmCorr = 'S',LDeltaKm,0);

    // totali
    LDeltaKmPos:=Max(0,LDeltaKm);
    if LFlagIndKmCorr = 'S' then
      LTotKmInd:=LTotKmInd + LDeltaKmPos;
    LTotKm:=LTotKm + LDeltaKmPos;

    // salva la località precedente per calcolo della prossima distanza
    LTipoPrec:=LTipoCorr;
    LLocalitaPrec:=LLocalitaCorr;

    cdsM141.Post;

    selM141.Next;
  end;

  // riga del totale
  cdsM141.Append;
  cdsM141.FieldByName('TAPPA').AsString:='';
  cdsM141.FieldByName('LOCALITA').AsString:='Percorso totale:';
  cdsM141.FieldByName('KM').AsInteger:=LTotKm;
  cdsM141.FieldByName('KM_IND').AsInteger:=LTotKmInd;
  cdsM141.Post;

  // posizionamento sul primo record
  cdsM141.First;
  cdsM141.ReadOnly:=True;
end;

function TA100FMissioniMW.M040AfterPostPasso1: String;
begin
  Result:='';
  Cancellare:=False;
  Inserire:=False;
  EsisteGGInt:=False;
  EsisteDaA:=False;
  if (Causale <> '') or (CausaleOld <> '') then
    with A004MW{A004DtM1} do
    begin
      Q040.Close;
      Q040.SetVariable('PROGRESSIVO', ProgressivoC700);
      Q040.Open;
      if Azione <> 'I' then
      begin
        CavalloMezzanotteOld:=(StrToDateTime(DataAOld) = StrToDateTime(DataDaOld) + 1) and
                              (StrToTime(OraDaOld) >= StrToTime(OraAOld));
        DataCorr:=StrToDateTime(DataDaOld);
        while DataCorr <= StrToDateTime(DataAOld) do
        begin
          EsisteDaA:=Q040.Locate('Data;Causale;TipoGiust;DaOre;AOre',
                     VarArrayOf([DataCorr, CausaleOld, 'D', StrToTime(IfThen(CavalloMezzanotteOld and(DataCorr = StrToDateTime(DataAOld)), '00.00',OraDaOld)),
                                 StrToTime(IfThen(CavalloMezzanotteOld and (DataCorr = StrToDateTime(DataDaOld)), '00.00', OraAOld))]), []);
          if not EsisteDaA then
            EsisteGGInt:=Q040.Locate('Data;Causale;TipoGiust',VarArrayOf([DataCorr, CausaleOld, 'I']), []);
          if EsisteDaA or EsisteGGInt then
            Break;
          DataCorr:=DataCorr + 1;
        end;
      end;
    end;
  if Azione = 'I' then
    Inserire:=(Causale <> '')
  else if Azione = 'M' then
  begin
    Cancellare:=(CausaleOld <> '') and (EsisteGGInt or EsisteDaA) and
                ((Causale <> CausaleOld) or (DataDa <> DataDaOld) or
                 (DataA <> DataAOld) or (OraDa <> OraDaOld) or
                 (OraA <> OraAOld));
    Inserire:=(Causale <> '') and ((Causale <> CausaleOld) or (DataDa <> DataDaOld) or
              (DataA <> DataAOld) or (OraDa <> OraDaOld) or (OraA <> OraAOld));
  end
  else if Azione = 'C' then
    Cancellare:=(CausaleOld <> '') and (EsisteGGInt or EsisteDaA);
  Inserire:=Inserire and ((R180OreMinutiExt(OraDa) <> 0) or (R180OreMinutiExt(OraA) <> 0));
  Cancellare:=Cancellare and ((R180OreMinutiExt(OraDaOld) <> 0) or (R180OreMinutiExt(OraAOld) <> 0));
  if Inserire and (StrToDateTime(DataA) > StrToDateTime(DataDa) + 1) and (StrToTime(OraDa) >= StrToTime(OraA)) then
  begin
    Inserire:=False;
    Result:='Attenzione! Non è possibile inserire automaticamente giustificativi a cavallo di mezzanotte per più di 2 giorni. Si vuole accedere al cartellino interattivo per inserirlo manualmente?';
  end;
end;

function TA100FMissioniMW.M040AfterPostPasso2:String;
begin
  Result:='';
  if Inserire then
  begin
    Result:='Si vuole inserire automaticamente il giustificativo ' + Causale +
          ' nel cartellino per il periodo indicato?';
  end;
end;

function TA100FMissioniMW.M040AfterPostPasso3:String;
begin
  Result:='';
   if not Inserire then
   begin
    if Cancellare then
      Result:='Si vuole cancellare automaticamente il giustificativo ' +
            CausaleOld + ' nel cartellino nel' + IfThen
            (DataDaOld = DataAOld, ' giorno ' + DataDaOld + IfThen(EsisteDaA,
              ' dalle ' + OraDaOld + ' alle ' + OraAOld),
            ' periodo ' + DataDaOld + ' - ' + DataAOld) + '?';
   end;
end;

function TA100FMissioniMW.M040AfterPostPasso4:boolean;
var PresenzaAnomalieB,PresenzaAnomalieNB,CavalloMezzanotte : boolean;
  j: Integer;
  R502ProDtM1: TR502ProDtM1;

begin
  Result:=True;
  if Inserire or Cancellare then
  with A004MW{A004DtM1} do
  begin
    RegistraMsg.IniziaMessaggio(nomeowner);
    PresenzaAnomalieB:=False;
    PresenzaAnomalieNB:=False;
    Var_Progressivo:=ProgressivoC700;
    Var_Gestione:=0;
    Var_NumGG:=0;
    Var_Familiari:='';
    if Cancellare then
    begin
      Var_Causale:=CausaleOld;
      Var_TipoCaus:=IfThen(VarToStr(Q275.Lookup('CODICE', Var_Causale, 'CODICE')) = Var_Causale, 0, 1);
      Var_TipoGiust_Count:=IfThen(Var_TipoCaus = 0, 2, 4);
      Giustif.Causale:=Var_Causale;
      Giustif.Inserimento:=False;
      DataCorr:=StrToDateTime(DataDaOld);
      while DataCorr <= StrToDateTime(DataAOld) do
      begin
        Var_DaData:=DateToStr(DataCorr);
        Var_AData:=DateToStr(DataCorr);
        DataInizioOrig:=DataCorr;
        DataInizio:=DataCorr;
        DataFine:=DataCorr;
        EsisteGGInt:=Q040.Locate('Data;Causale;TipoGiust',VarArrayOf([DataCorr, CausaleOld, 'I']), []);
        Var_TipoGiust:=IfThen(EsisteGGInt, 0, IfThen(Var_TipoCaus = 0, 1, 3));
        Giustif.Modo:=R180CarattereDef(IfThen(Var_TipoGiust = 0, 'I', 'D'));
        Var_DaOre:=IfThen(Var_TipoGiust = 0, '', IfThen(CavalloMezzanotteOld and (DataCorr = StrToDateTime (DataAOld)), '00.00', OraDaOld));
        Var_AOre:=IfThen(Var_TipoGiust = 0, '',IfThen(CavalloMezzanotteOld and (DataCorr = StrToDateTime(DataDaOld)), '00.00', OraAOld));
        Giustif.DaOre:=Var_DaOre;
        Giustif.AOre:=Var_AOre;
        try
          CancellaGiustif(False, False);
        except
        on E: Exception do
          begin
            RegistraMsg.InserisciMessaggio('A', 'Anomalia bloccante: ' + E.Message, Parametri.Azienda,Var_Progressivo);
            PresenzaAnomalieB:=True;
          end;
        end;
        for j:=0 to R600DtM1.ListAnomalie.Count - 1 do
        begin
          RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + R600DtM1.ListAnomalie[j],
                                         Parametri.Azienda, Var_Progressivo);
          PresenzaAnomalieB:=True;
        end;
        if PresenzaAnomalieB then
          Break;
        for j:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
        begin
          RegistraMsg.InserisciMessaggio('A', 'Anomalia non bloccante: ' + R600DtM1.ListAnomalieNonBloccanti[j], Parametri.Azienda, Var_Progressivo);
          PresenzaAnomalieNB:=True;
        end;
        DataCorr:=DataCorr + 1;
      end;
      if PresenzaAnomalieB then
      begin
        SessioneOracle.Rollback;
        PresenzaAnomalieNB:=True; // Se ho avuto un problema grave in cancellazione non blocco l'inserimento, ma lo segnalo alla fine di tutto
        PresenzaAnomalieB:=False; // Se ho avuto un problema grave in cancellazione non blocco l'inserimento, ma lo segnalo alla fine di tutto
      end
      else
        SessioneOracle.Commit;
    end;
    if Inserire then
    begin
      Var_Causale:=Causale;
      Var_TipoCaus:=IfThen(VarToStr(Q275.Lookup('CODICE', Var_Causale,'CODICE')) = Var_Causale, 0, 1);
      Var_TipoGiust_Count:=IfThen(Var_TipoCaus = 0, 2, 4);
      Giustif.Causale:=Var_Causale;
      Giustif.Inserimento:=True;
      CavalloMezzanotte:=(StrToDateTime(DataA) = StrToDateTime(DataDa) + 1) and (StrToTime(OraDa) >= StrToTime(OraA));
      DataCorr:=StrToDateTime(DataDa);
      while DataCorr <= StrToDateTime(DataA) do
      begin
        Var_DaData:=DateToStr(DataCorr);
        Var_AData:=DateToStr(DataCorr);
        DataInizioOrig:=DataCorr;
        DataInizio:=DataCorr;
        DataFine:=DataCorr;
        Var_TipoGiust:=IfThen(Var_TipoCaus = 0, 1, 3);
        // Controllo la durata oraria massima per il giustificativo
        if not CavalloMezzanotte and (OreMax <> '') and (R180OreMinuti(StrToTime(OraA) - StrToTime(OraDa)) > R180OreMinutiExt(OreMax)) then
          OraA:=R180MinutiOre(R180OreMinutiExt(OraDa) + R180OreMinutiExt(OreMax));
        // Per le assenze, controllo se inserire a giornata intera quando non copro il debito giornaliero
        if (Var_TipoCaus = 1) and (CopreDebito = 'S') and not CavalloMezzanotte then
        begin
          R502ProDtM1:=TR502ProDtM1.Create(nil, True);
          with R502ProDtM1 do
          begin
            ConteggiaGiustificativiR600:=True;
            PeriodoConteggi(DataCorr, DataCorr);
            Conteggi('Cartolina', ProgressivoC700, DataCorr);
            ConteggiaGiustificativiR600:=False;
            if (n_timbrdip = 0) and ((Debitogg - OreReseTotali - R180OreMinuti(StrToTime(OraA) - StrToTime(OraDa))) >= 0) then
              Var_TipoGiust:=0;
          end;
          FreeAndNil(R502ProDtM1);
        end;
        Giustif.Modo:=R180CarattereDef(IfThen(Var_TipoGiust = 0, 'I', 'D'));
        Var_DaOre:=IfThen(Var_TipoGiust = 0, '', IfThen(CavalloMezzanotte and (DataCorr = StrToDateTime(DataA)), '00.00', OraDa));
        Var_AOre:=IfThen(Var_TipoGiust = 0, '', IfThen(CavalloMezzanotte and (DataCorr = StrToDateTime(DataDa)), '00.00', OraA));
        Giustif.DaOre:=Var_DaOre;
        Giustif.AOre:=Var_AOre;
        try
          InserisciGiustif(False);
        except
        on E: Exception do
          begin
            RegistraMsg.InserisciMessaggio('A', 'Anomalia bloccante: ' + E.Message, Parametri.Azienda, Var_Progressivo);
            PresenzaAnomalieB:=True;
          end;
        end;
        for j:=0 to R600DtM1.ListAnomalie.Count - 1 do
        begin
          RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + R600DtM1.ListAnomalie[j], Parametri.Azienda, Var_Progressivo);
          PresenzaAnomalieB:=True;
        end;
        if PresenzaAnomalieB then
          Break;
        for j:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
        begin
          RegistraMsg.InserisciMessaggio('A', 'Anomalia non bloccante: ' + R600DtM1.ListAnomalieNonBloccanti[j], Parametri.Azienda, Var_Progressivo);
          PresenzaAnomalieNB:=True;
        end;
        DataCorr:=DataCorr + 1;
      end;
      if PresenzaAnomalieB then
        SessioneOracle.Rollback
      else
        SessioneOracle.Commit;
    end;
    if PresenzaAnomalieB or PresenzaAnomalieNB then
    begin
      Result:=False;
    end;
  end;
end;

procedure TA100FMissioniMW.M040AfterPostPasso5;
var nImportoDep: Real;
begin
  AggiornaDati;
  if bPv_RicalcoloIndennitaKm then // RICALCOLO LE INDENNITA' CHILOMETRICHE RIFERITE ALLA MISSIONE MODIFICATA
  begin
    // Ricerco tutte le indennità chilometriche che cadono nel periodo indicato...
    If QM052.RecordCount > 0 then
    begin
      QM052.First;
      if (selM021A.GetVariable('CODICE') <> QM052.FieldByName('CODICEINDENNITAKM').AsString) or
         (selM021A.GetVariable('DECORRENZA') <> FSelM040_Funzioni.FieldByName('DATAA').AsString) then
      begin
        selM021A.Close;
        selM021A.SetVariable('CODICE',QM052.FieldByName('CODICEINDENNITAKM').AsString);
        selM021A.SetVariable('DECORRENZA',FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
        selM021A.Open;
      end;
      while not QM052.Eof do
      begin
        nImportoDep:=selM021A.FieldByName('IMPORTO').AsFloat * QM052.FieldByName('KMPERCORSI').AsFloat;
        GetArrotondamento(selM021A.FieldByName('ARROTONDAMENTO').AsString, FSelM040_Funzioni.FieldByName('DATAA').AsDateTime);
        nImportoDep:=R180Arrotonda(nImportoDep, nPb_Arrotondamento,sPb_Tipo);
        if QM052.FieldByName('IMPORTOINDENNITA').AsFloat <> nImportoDep then
        begin
          QM052.ReadOnly:=False;
          QM052.Edit;
          QM052.FieldByName('IMPORTOINDENNITA').AsFloat:=nImportoDep;
          QM052.Post;
          //per cloud il controllo fatto sui pulsanti di modifica e cancella.
          {$IFNDEF WEBPJ}
          QM052.ReadOnly := True;
          {$ENDIF}
        end;
        QM052.Next;
      end;
      //Per cloud fare sempre ApplyUpdates perchè in cachedUpdate la griglia non fa commit;
      SessioneOracle.ApplyUpdates([QM052], True);
    end;
    bPv_RicalcoloIndennitaKm:=False;
    CalcolaTotaliIndennitaKm;
  end;
end;

procedure TA100FMissioniMW.M040AfterPostPasso6(AzioneApp:String);
begin
  //Salvataggio log della M050_RIMBORSI (cancellata dal trigger M040_AFTERDELETE ma ancora disponibile sul Q050 prima del refresh)
  if (AzioneApp = 'C') and Q050.Active then
  begin
    Q050.First;//Non c'è bisogno di tener traccia del record su cui si è posizionati prima dello scorrimento, perché tanto è già stato cancellato dal trigger su DB e non è più utile se non ai fini della registrazione del log
    while not Q050.Eof do
    begin
      RegistraLog.SettaProprieta('C',R180Query2NomeTabella(Q050),NomeOwner,Q050,False(*usa un solo "log id" per tutti i rimborsi, anche se risulta diverso da quello usato per la testata*));
      Q050.Next;
    end;
    if Q050.RecordCount > 0 then
      RegistraLog.RegistraOperazione;
    //La commit è demandata alla procedura chiamante
  end;
end;

function TA100FMissioniMW.GetIndennitaKm(const NumKm: double; const Codice: String; const DataRif: TDateTime): double;
var
  nImportoDep: double;
begin
  if (Codice <> selM021A.GetVariable('CODICE')) or
     (DataRif <> selM021A.GetVariable('DECORRENZA')) then
  begin
    selM021A.Close;
    selM021A.SetVariable('CODICE', Codice);
    selM021A.SetVariable('DECORRENZA', DataRif);
    selM021A.Open;
  end;
  nImportoDep:=NumKm * selM021A.FieldByName('IMPORTO').AsFloat;
  GetArrotondamento(selM021A.FieldByName('ARROTONDAMENTO').AsString, DataRif);
  Result:=R180Arrotonda(nImportoDep, nPb_Arrotondamento, sPb_Tipo);
end;

procedure TA100FMissioniMW.M040BeforeEdit;
begin
  ControlloDatiBloccati;
  if Parametri.CampiRiferimento.C8_GestioneMensile = 'N' then
    // Se è prevista la gertione a cavallo di mese
    FSelM040_Funzioni.FieldByName('FLAG_MODIFICATO').AsString := 'S';
end;

procedure TA100FMissioniMW.ControlloDatiBloccati;
begin
  if (FSelM040_Funzioni.Active) and (FSelM040_Funzioni.RecordCount > 0) then
  begin
    // Blocco le missioni liquidate x il mese specificato sul blocco riepiloghi
    if (selDatiBloccati.DatoBloccato(FSelM040_Funzioni.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(FSelM040_Funzioni.FieldByName('DATADA').AsDateTime), 'M040')) and
       (FSelM040_Funzioni.FieldByName('STATO').AsString = 'L') then
      raise Exception.Create(selDatiBloccati.MessaggioLog);
  end;
end;

procedure TA100FMissioniMW.M040BeforeDelete;
begin
  if not FSelM040_Funzioni.FieldByName('ID').IsNull then
    raise Exception.Create('La missione è stata richiesta dal dipendente tramite IrisWEB.' + CRLF +
                           'Impossibile cancellarla.');
  ControlloDatiBloccati;
  UpdM060.Close;
  UpdM060.SetVariable('ID_MISSIONE', FSelM040_Funzioni.FieldByName('ID_MISSIONE').AsInteger);
  UpdM060.Execute;
  SessioneOracle.Commit;

  Azione:='C';

  CausaleOld:='';
  try
    LeggiParametri(FSelM040_Funzioni.FieldByName('DATAA').AsDateTime, FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
    if RegoleTrovate then
      CausaleOld:=Q010.FieldByName('CAUSALE_MISSIONE').AsString;
  except
  end;
  DataDaOld:=FSelM040_Funzioni.FieldByName('DATADA').AsString;
  DataAOld:=FSelM040_Funzioni.FieldByName('DATAA').AsString;
  OraDaOld:=FSelM040_Funzioni.FieldByName('ORADA').AsString;
  OraAOld:=FSelM040_Funzioni.FieldByName('ORAA').AsString;

  Causale:='';
  DataDa:='';
  DataA:='';
  OraDa:='';
  OraA:='';
end;

procedure TA100FMissioniMW.M040NewRecord;
begin
  // Imposto il tipo di misione predefinito
  if QM011.RecordCount > 0 then
  begin
    QM011.First;
    if QM011.FieldByName('SELEZIONATO').AsString = 'S' then
      FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString:=QM011.Fields[0].AsString
    else
      FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').Clear;
  end;
  // Mese/Anno di scarico
  FSelM040_Funzioni.FieldByName('MESESCARICO').AsDateTime:=dPv_DataCassa;
  //deve scatenare m040MesescaricoValidate
  // Mese/Anno di competenza
  FSelM040_Funzioni.FieldByName('DATADA').AsDateTime:=dPv_DataCompetenza;
   //cloud deve lanciare i validate dei campi perchè eventi non associati (in win si)
  {$IFDEF WEBPJ}
  M040MESESCARICOValidate;
  M040DATADAValidate;
  {$ENDIF}
  // Inizializzo i contatori
  FSelM040_Funzioni.FieldByName('TotaleOreIndennita').AsInteger:=0;
  FSelM040_Funzioni.FieldByName('TotaleImportiIndennita').AsInteger:=0;
  FSelM040_Funzioni.FieldByName('TotaleKmIndennita').AsInteger:=0;
  FSelM040_Funzioni.FieldByName('TotaleImportiKmIndennita').AsInteger:=0;
  FSelM040_Funzioni.FieldByName('PROGRESSIVO').AsInteger:=ProgressivoC700;
  if Parametri.CampiRiferimento.C8_GestioneMensile <> 'N' then
  // Gestione mensile
    FSelM040_Funzioni.FieldByName('FLAG_MODIFICATO').AsString:='N'
  else
    FSelM040_Funzioni.FieldByName('FLAG_MODIFICATO').AsString:='S';
end;

function TA100FMissioniMW.M040FiltroDizionario:Boolean;
begin
  Result:=A000FiltroDizionario('TIPOLOGIA TRASFERTA', FSelM040_Funzioni.FieldByName('TIPOREGISTRAZIONE').AsString);
end;

procedure TA100FMissioniMW.M040Apply(Action: String);
begin
  if Action = 'U' then
  begin
    // Se uno dei campi chiave è cambiato, vario la chiave anche sui rimoborsi e sulle indennità chilometriche...
    if (FSelM040_Funzioni.FieldByName('PROGRESSIVO').medpOldValue <> FSelM040_Funzioni.FieldByName('PROGRESSIVO').AsInteger) or
      (FSelM040_Funzioni.FieldByName('MESESCARICO').medpOldValue <> FSelM040_Funzioni.FieldByName('MESESCARICO').AsDateTime) or
      (FSelM040_Funzioni.FieldByName('MESECOMPETENZA').medpOldValue <> FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsDateTime) or
      (FSelM040_Funzioni.FieldByName('DATADA').medpOldValue <> FSelM040_Funzioni.FieldByName('DATADA').AsDateTime) or
      (FSelM040_Funzioni.FieldByName('ORADA').medpOldValue <> FSelM040_Funzioni.FieldByName('ORADA').AsString) then
    begin
      if FSelM040_Funzioni.FieldByName('MESECOMPETENZA').medpOldValue <> FSelM040_Funzioni.FieldByName('MESECOMPETENZA').AsDateTime then
        bPv_RicalcoloIndennitaKm:=True;
    end;
  end;
end;

procedure TA100FMissioniMW.M040PostError(E: EDatabaseError);
begin
  if UpperCase(Copy(E.message, 1, 9)) = 'ORA-00001' then
    raise Exception.Create(A000MSG_A100_ERR_INS_TRASFERTA);
end;

procedure TA100FMissioniMW.RicalcolaIndennitaKM;
var nImportoDep:Real;
begin
  SelM052.Open;
  while not SelM052.Eof do
  begin
    //Verifico se esistono altri periodi storici successivi a quello selezionato
    if (selM021A.GetVariable('CODICE') <> SelM052.FieldByName('CODICEINDENNITAKM').asString) or
       (selM021A.GetVariable('DECORRENZA') <> SelM052.FieldByName('DATAA').asString) then
    begin
      selM021A.Close;
      selM021A.setvariable('CODICE', SelM052.FieldByName('CODICEINDENNITAKM').asString);
      selM021A.setvariable('DECORRENZA', SelM052.FieldByName('DATAA').AsDateTime);
      selM021A.Open;
    end;
    UM052.SetVariable('progressivo',SelM052.FieldByName('progressivo').AsInteger);
    UM052.SetVariable('mesescarico',SelM052.FieldByName('mesescarico').AsDateTime);
    UM052.SetVariable('mesecompetenza',SelM052.FieldByName('mesecompetenza').AsDateTime);
    UM052.SetVariable('datada',SelM052.FieldByName('datada').AsDateTime);
    UM052.SetVariable('orada',SelM052.FieldByName('orada').AsString);
    UM052.SetVariable('codiceindennitakm',SelM052.FieldByName('codiceindennitakm').AsString);
    nImportoDep:=selM021A.FieldByName('IMPORTO').AsFloat * SelM052.FieldByName('KMPERCORSI').asFloat;
    GetArrotondamento(selM021A.FieldByName('ARROTONDAMENTO').AsString, SelM052.FieldByName('DATAA').asDateTime);
    nImportoDep:=R180Arrotonda(nImportoDep,nPb_Arrotondamento, sPb_Tipo);
    UM052.SetVariable('IMPORTOINDENNITA',nImportoDep);
    UM052.Execute;
    SelM052.Next;
  end;
end;

procedure TA100FMissioniMW.AggGiustServiziAttivi;
begin
  USR_M050P_CARICA_GIUST_DAITER.SetVariable('AGGIORNA', 'S');
  USR_M050P_CARICA_GIUST_DAITER.SetVariable('ID', FSelM040_Funzioni.FieldByName('ID_MISSIONE').AsInteger);
  USR_M050P_CARICA_GIUST_DAITER.Execute;
  if USR_M050P_CARICA_GIUST_DAITER.GetVariable('AGGIORNA') <> 'E' then
  begin
    // Registrazione log su aggiorna giustificativi su cartellino
    RegistraLog.SettaProprieta('M', 'T040_GIUSTIFICATIVI',NomeOwner, nil, True);
    RegistraLog.InserisciDato('DATADA', '', FSelM040_Funzioni.FieldByName('DATADA').AsString);
    RegistraLog.InserisciDato('DATAA', '', FSelM040_Funzioni.FieldByName('DATAA').AsString);
    RegistraLog.InserisciDato('ORADA', '', FSelM040_Funzioni.FieldByName('ORADA').AsString);
    RegistraLog.InserisciDato('ORAA', '', FSelM040_Funzioni.FieldByName('ORAA').AsString);
    RegistraLog.InserisciDato('ID_MISSIONE', '', FSelM040_Funzioni.FieldByName('ID_MISSIONE').AsString);
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;
end;

procedure TA100FMissioniMW.RiapriRichiestaMissione;
// imposta il flag di missione riaperta sulla richiesta
begin
  updM140Riapri.SetVariable('ID',FSelM040_Funzioni.FieldByName('ID_MISSIONE').AsInteger);
  updM140Riapri.SetVariable('MISSIONE_RIAPERTA','S');
  try
    updM140Riapri.Execute;
    // registrazione log
    RegistraLog.SettaProprieta('M','M140_RICHIESTE_MISSIONI',NomeOwner,nil,True);
    RegistraLog.InserisciDato('ID','',FSelM040_Funzioni.FieldByName('ID_MISSIONE').AsString);
    RegistraLog.InserisciDato('MISSIONE_RIAPERTA','N','S');
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    SessioneOracle.Rollback;
  end;
end;

end.
