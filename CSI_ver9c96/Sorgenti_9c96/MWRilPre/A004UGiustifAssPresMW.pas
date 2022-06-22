unit A004UGiustifAssPresMW;

interface

uses
  A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia,
  DatiBloccati, RegistrazioneLog,
  R005UDataModuleMW, Rp502Pro, R600,
  {$IFNDEF WEBSVC}
    {$IFDEF IRISWEB}
    IWApplication, medpIWMessageDlg, // incluse per messagebox modale web
    {$ENDIF IRISWEB}
  {$ENDIF WEBSVC}
  {$IFNDEF IRISWEB}
    ComCtrls,                        // inclusa in win per utilizzo progressbar
  {$ENDIF IRISWEB}
  //B021UWebSvcClientDtM,
  C017UEMailDtM, C018UIterAutDM, C180FunzioniGenerali,
  Oracle, Data.DB, OracleData, SysUtils, Variants,
  Classes, Controls, Forms, StrUtils, Math;

type

  // classe per oggetto che specifica il recapito alternativo per visite fiscali
  TRecapitoAlternativo = class(TComponent)
  private
    FAbilitato: Boolean; // indica se il recapito alternativo è abilitato (True) oppure no (False)
    FCodComune: String;  // codice del comune
    FDescComune: String; // descrizione comune
    FCap: String;        // cap
    FIndirizzo: String;  // indirizzo
    FTelefono: String;   // telefono
    FMedLegale: String;  // codice della medicina legale di riferimento
    FNote: String;       // note per il recapito alternativo
    FTipoEsenzione: String;      // tipo esenzione
    FDataEsenzione: TDateTime;   // data esenzione
    FOperatoreEsenzione: String; // operatore esenzione
    function  GetAbilitato: Boolean;
    procedure SetAbilitato(const PValue: Boolean);
  public
    procedure Clear;     // pulisce i dati del recapito alternativo
    property Abilitato: Boolean read GetAbilitato write SetAbilitato;
    property CodComune: String read FCodComune write FCodComune;
    property DescComune: String read FDescComune write FDescComune;
    property Cap: String read FCap write FCap;
    property Indirizzo: String read FIndirizzo write FIndirizzo;
    property Telefono: String read FTelefono write FTelefono;
    property MedLegale: String read FMedLegale write FMedLegale;
    property Note: String read FNote write FNote;
    property TipoEsenzione: String read FTipoEsenzione write FTipoEsenzione;
    property DataEsenzione: TDateTime read FDataEsenzione write FDataEsenzione;
    property OperatoreEsenzione: String read FOperatoreEsenzione write FOperatoreEsenzione;
  end;

  TCancellazione_CausaleHMAssenza = record
    Causale: String;
    Data: TDateTime;
  end;

  TA004FGiustifAssPresMW = class(TR005FDataModuleMW)
    Q040: TOracleDataSet;
    Q040B: TOracleDataSet;
    Q040BProgressivo: TFloatField;
    Q040BData: TDateTimeField;
    Q040BD_TipoCausale: TStringField;
    Q040BCausale: TStringField;
    Q040BDATANAS: TDateTimeField;
    Q040BProgrCausale: TFloatField;
    Q040BTipoGiust: TStringField;
    Q040BDaOre: TDateTimeField;
    Q040BAOre: TDateTimeField;
    Q040BD_Causale: TStringField;
    Q040BNote: TStringField;
    selT046: TOracleDataSet;
    selT046PROGRESSIVO: TFloatField;
    selT046DATA: TDateTimeField;
    selT046CAUSALE: TStringField;
    selT046DATANAS: TDateTimeField;
    selT046TIPOGIUST: TStringField;
    selT046DAORE: TStringField;
    selT046AORE: TStringField;
    dsrVisualizza: TDataSource;
    Q265: TOracleDataSet;
    D265: TDataSource;
    Q275: TOracleDataSet;
    D275: TDataSource;
    selConiuge: TOracleDataSet;
    dsrSG101: TDataSource;
    selT050: TOracleDataSet;
    selT050ID: TFloatField;
    selT050PROGRESSIVO: TIntegerField;
    selT050ELABORATO: TStringField;
    selT050CAUSALE: TStringField;
    selT050TIPOGIUST: TStringField;
    selT050DAL: TDateTimeField;
    selT050AL: TDateTimeField;
    selT050NUMEROORE: TStringField;
    selT050AORE: TStringField;
    selT050DATANAS: TDateTimeField;
    selT050NUMEROORE_PREV: TStringField;
    selT050AORE_PREV: TStringField;
    selT050DATA: TDateTimeField;
    selT050AUTORIZZAZIONE: TStringField;
    selT050TIPO_RICHIESTA: TStringField;
    selT050ID_REVOCA: TFloatField;
    selT050ID_REVOCATO: TFloatField;
    selT050NOTE1: TStringField;
    selT050COD_ITER: TStringField;
    selT050MATRICOLA: TStringField;
    selT050NOMINATIVO: TStringField;
    selT050NOMINATIVO_RESP: TStringField;
    selT050DESCRIZIONE: TStringField;
    selT050TIPOCAUS: TStringField;
    selT050TIPO_RICHIESTA_ORIG: TStringField;
    selT050D_CAUSALE: TStringField;
    selT050D_TIPO_RICHIESTA: TStringField;
    selT050TIPO: TStringField;
    selT050Upd: TOracleDataSet;
    selT047: TOracleDataSet;
    selElaborato: TOracleQuery;
    selT485: TOracleDataSet;
    dscT485: TDataSource;
    selT486: TOracleDataSet;
    insT280: TOracleQuery;
    delT046: TOracleQuery;
    insT046: TOracleQuery;
    scrCopriGGNonLav: TOracleQuery;
    scrT031: TOracleQuery;
    selT040Revoche: TOracleDataSet;
    updT850: TOracleQuery;
    selT480: TOracleDataSet;
    dsrQ480: TDataSource;
    selT047Esenzioni: TOracleDataSet;
    selT480CODICE: TStringField;
    selT480CITTA: TStringField;
    selT480CAP: TStringField;
    selT480PROVINCIA: TStringField;
    selT480CODCATASTALE: TStringField;
    delT040IdRichiesta: TOracleQuery;
    seqT850Id: TOracleQuery;
    insT040Extra: TOracleQuery;
    T040p_allinea: TOracleQuery;
    Q040BCSI_TIPO_MG: TStringField;
    Q040BD_CSI_TIPO_MG: TStringField;
    selT050CSI_TIPO_MG: TStringField;
    selT050D_CSI_TIPO_MG: TStringField;
    selT050STATO_REVOCA: TStringField;
    selT050FILE_ALLEGATO: TStringField;
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure Q040PostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure Q040BAfterOpen(DataSet: TDataSet);
    procedure Q040BCalcFields(DataSet: TDataSet);
    procedure T040DaOreSetText(Sender: TField; const Text: string);
    procedure Q275AfterOpen(DataSet: TDataSet);
    procedure selT050CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure Q040BFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#1.ini
    // variabili spostate in sezione public per utilizzo in A119MW
    //ErroreCancellazione: String;
    //DatoBloccatoCancellazione: Boolean;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#1.fine
    NumGiorni: Boolean;
    AcquisizioneWebInCorso: Boolean;
    Elaborato: String;
    OperatoreBck: String;
    AggiornaStato: Boolean;
    ControlliOK: Boolean;
    C018DM: TC018FIterAutDM;
    //ListAnomalieCompleta: TStringList;
    IdRichiestaWeb:integer;
    IdCertificato:string;
    lstFruizGiornaliereHMA:array of TFruizGiornaliereHMA;
    Cancellazione_CausaleHMAssenza: TCancellazione_CausaleHMAssenza;
    function  Parametri: TParametri;
    function  RegistraLog: TRegistraLog;
    procedure GeneraPeriodiAssenza(const POperazione,PCausale:String;
      const PDataInizio,PDataFine:TDateTime);
    function  FormattaDatiRichiesta(const CausIns: Boolean; var Note,
      CausInserita, NomeResp: String): String;
    function  FormattaDatiLog(const NomeResp, Note: String): String;
    procedure _InserisciGiustif(InsNormale:Boolean);
    //procedure _InserisciGiustifHMA(InsNormale:Boolean);
    procedure InserimentoTO_CSI_ABB_ECCSETT(Causale:String);
    procedure Inserimento_CausaleHMAssenza(Progressivo:Integer; Data1,Data2:TDateTime; Causale:String);
    procedure ImportaRichiesta(const PIns, PInterattiva: Boolean);
    procedure EseguiCancellazione;
    procedure InviaEMail(const PDestResponsabile:Boolean; const PProg:Integer; const PTesto:String);
    procedure WSCtrlCancella;
    procedure CoperturaGiorniNonLavorativi(var RDataInizio: TDateTime; var RCausale: String);
  public
    DataInizio: TDateTime;
    DataInizioOrig: TDateTime;
    DataFine: TDatetime;
    chkNuovoPeriodo: Boolean;
    GestioneSingolaDM: Boolean;                 // indica se la gestione è sul singolo dipendente (True) oppure massiva (False)
    Chiamante: String;                          // utilizzato da B021, A087 (viene anche usato come codice form per i messaggi delle elaborazioni)
    TipoCertificatoINPS: String;                // utilizzato da B021, A087: I=Inserimento,C=Continuazione
    RecapitoAlternativo: TRecapitoAlternativo;  // utilizzato da A087, A004UGiustifAssPres
    B021Autorizzatore: String;                  // utilizzato da B021UGiustificativiDM
    Giustif: TGiustificativo;
    AnomalieInterattive: Boolean;               // utilizzato da A004UCaricaAssRich
    EseguiCommit: Boolean;                      // utilizzato da A087, ...
    SessioneOracleA004: TOracleSession;         // utilizzato da A004UCaricaAssRich, ...
    R600DtM1: TR600DtM1;
    selDatiBloccati: TDatiBloccati;             // utilizzato solo da A004UGiustifAssPres
    {$IFNDEF IRISWEB}
    ProgressBar: TProgressBar;                  // utilizzato solo da win
    {$ENDIF IRISWEB}
    // variabili per controlli e gestione.ini
    Var_Gestione: Integer;
    Var_TipoGiust: Integer;
    Var_NumGG: Integer;
    Var_TipoCaus: Integer;
    Var_TipoGiust_Count: Integer;
    Var_RestoHMA: Integer;
    Var_Progressivo: Integer;
    Var_DaOre: String;
    Var_AOre: String;
    Var_DaData: String;
    Var_AData: String;
    Var_Causale: String;
    Var_Familiari: String;
    Var_Note: String;
    Var_FiltroCausaleSelezionata: Boolean;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    Var_TipoMG: String;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    ListAnomalieCompleta: TStringList;
    // variabili per controlli e gestione.fine
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#1.ini
    // variabili spostate da private per utilizzo in A119MW
    ErroreCancellazione: String;
    DatoBloccatoCancellazione: Boolean;
    A087ElencoCausali:TObject;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#1.fine
    procedure selT050FiltroAllegati(Val:string);
    procedure selT050FiltroFiltroCondizAllegati(Val:string);
    procedure selSG101FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    // gestione giustificativi
    procedure SettaGiustificativiVisualizzati;
    procedure Controlli(const PInsNormale,PInserisci:Boolean); // utilizzato da A004UGiustifAssPres, WA004UGiustifAssPres
    procedure InserisciGiustif(InsNormale:Boolean; ID:Int64 = 0); overload;
    procedure InserisciGiustif(InsNormale:Boolean; ID:string); overload;
    procedure CancellaGiustif(CancNormale:Boolean; ScriviLog:Boolean = True);
    // gestione giustificativi coniugi esterni
    procedure InserisciGiustFamiliari;
    procedure CancellaGiustFamiliari;
    // acquisizione richieste web
    function AcquisizioneRichiesteWeb(const PSingola, PInterattiva: Boolean;
      var ErrMsg: String; var Scartate: Integer; PNuoveRichieste: Boolean = True): Boolean;
    procedure PeriodoInserito;
    procedure PeriodoInseritoConAnomalie;
    procedure PeriodoNonInserito(const Errore:String);
    procedure PeriodoCancellato;
    procedure PeriodoNonCancellato(const Errore:String);
    procedure PeriodoCompensato(TracciaMsgWeb: Boolean);
    function  GetNoteRichiesta(PIdRichiesta: Integer): String;
    // medicine legali
    function  EstraiMedLeg(const PCodComune: String): String;
    //procedure Inserimento_CausaleHMAssenza(Progressivo:Integer; Dal,Al:TDateTime; Causale,TG:String);
    procedure Chek_CausaleHMAssenza(Progressivo:Integer; Dal,Al:TDateTime; Causale,TG:String);
    procedure _InserisciGiustifHMA(InsNormale:Boolean);
  end;

const
  FIRLAB_RIPOSO = '80001';

implementation

uses A087UImpAttestatiMalMW;

{$R *.dfm}

// ### RIDEFINIZIONE FUNZIONI DI A000UINTERFACCIA.ini  ### //
function TA004FGiustifAssPresMW.Parametri:TParametri;
begin
  if Owner is TSessioneIrisWin then
    Result:=(Owner as TSessioneIrisWin).Parametri
  else
    Result:=A000UInterfaccia.Parametri;
end;

function TA004FGiustifAssPresMW.RegistraLog:TRegistraLog;
begin
  if Owner is TSessioneIrisWin then
    Result:=((Owner as TSessioneIrisWin).RegistraLog) as TRegistraLog
  else
    Result:=(A000UInterfaccia.RegistraLog) as TRegistraLog;
end;
// ### RIDEFINIZIONE FUNZIONI DI A000UINTERFACCIA.fine ### //


procedure TA004FGiustifAssPresMW.DataModuleCreate(Sender: TObject);
// IMPORTANTE:
//   questo datamodule utilizza una sessione oracle propria, per cui
//   non richiamare inherited!
var
  i: Integer;
begin
 try
  // sessione oracle propria
  // nel caso di richiamo da servizi / fuori dal contesto win/web
  // viene passata la TOracleSession come owner
  // in questo caso i componenti vengono associati a questa sessione
  if (Owner <> nil) and (Owner is TOracleSession) then
    SessioneOracleA004:=(Owner as TOracleSession)
  else if (Owner <> nil) and (Owner is TSessioneIrisWIN) then
    SessioneOracleA004:=(Owner as TSessioneIrisWIN).SessioneOracle
  else
    SessioneOracleA004:=SessioneOracle;

  // richiesta login su iriswin
  if not (SessioneOracleA004.Connected) then
  begin
    if Password(Application.Name) = -1 then
      Application.Terminate;
    A000ParamDBOracle(SessioneOracleA004);
  end;

  // associa i componenti alla sessione oracle propria
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracleA004;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracleA004;
  end;

  A087ElencoCausali:=TA087InfoCertificati.Create(SessioneOracleA004);

  // apertura dataset
  Q265.Open;
  Q275.Open;
  selT485.Open;
  selT480.SetVariable('ORDERBY', 'ORDER BY CITTA');
  selT480.Open;

  // creazione oggetto di supporto per visite fiscali
  RecapitoAlternativo:=TRecapitoAlternativo.Create(Self);

  // creazione datamodulo conteggi assenze
  R600DtM1:=TR600Dtm1.Create(SessioneOracleA004);
  dsrSG101.DataSet:=R600DtM1.selSG101;

  // creazione oggetto per controllo blocco riepiloghi
  selDatiBloccati:=TDatiBloccati.Create(SessioneOracleA004);

  // inizializzazione variabili
  Chiamante:='';
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  // inizializzazione
  Var_TipoMG:='';
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  B021Autorizzatore:='';
  EseguiCommit:=True;
  DataInizio:=Parametri.DataLavoro;
  DataFine:=DATE_MAX;
  TipoCertificatoINPS:='';
  AcquisizioneWebInCorso:=False;
  Var_RestoHMA:=0;
  SetLength(lstFruizGiornaliereHMA,0);
  // commessa: MAN/08 SVILUPPO#56 - riesame del 09.10.2013.ini
  // gestione lista anomalie completa per elaborazioni massive
  ListAnomalieCompleta:=TStringList.Create;
  // commessa: MAN/08 SVILUPPO#56 - riesame del 09.10.2013.fine
  //Creato oggetto per inserimento singolo su tabella T048
 except
 end;
end;

procedure TA004FGiustifAssPresMW.DataModuleDestroy(Sender: TObject);
begin
 try
  FreeAndNil(A087ElencoCausali);
  // commessa: MAN/08 SVILUPPO#56 - riesame del 09.10.2013.ini
  // distrugge lista anomalie completa per elaborazioni massive
  FreeAndNil(ListAnomalieCompleta);
  // commessa: MAN/08 SVILUPPO#56 - riesame del 09.10.2013.fine
  FreeAndNil(RecapitoAlternativo);
  FreeAndNil(R600DtM1);
  FreeAndNil(selDatiBloccati);
  inherited;
 except
 end;
end;

// ############# GESTIONE GIUSTIFICATIVI.ini  ############ //
procedure TA004FGiustifAssPresMW.SettaGiustificativiVisualizzati;
begin
  if GestioneSingolaDM then
  begin
    if Var_Gestione = 0 then //Dipendenti
    begin
      dsrVisualizza.DataSet:=Q040B;
      Q040B.Close;
      Q040B.SetVariable('Progressivo',ProgressivoC700);
      Q040B.SetVariable('Data1',DataInizio);
      Q040B.SetVariable('Data2',DataFine);
      if Var_FiltroCausaleSelezionata then
        Q040B.SetVariable('FILTROCAUSALE',' AND CAUSALE = ''' + Var_Causale + '''')
      else
        Q040B.SetVariable('FILTROCAUSALE','');
      Q040B.Open;
    end
    else  //Coniugi esterni
    begin
      dsrVisualizza.DataSet:=selT046;
      selT046.Close;
      selT046.SetVariable('Progressivo',ProgressivoC700);
      selT046.SetVariable('Data1',DataInizio);
      selT046.SetVariable('Data2',DataFine);
      selT046.Open;
    end;
  end;
end;

procedure TA004FGiustifAssPresMW.Controlli(const PInsNormale, PInserisci:Boolean);
// questa procedure effettua la prima fase di controlli per l'inserimento
// o la cancellazione di un giustificativo
// IMPORTANTE:
//   prima di richiamare questa procedure valorizzare:
//   - le variabili Var_xxx
//   - la variabile ControlliOK = true
// se vengono riscontrati degli errori, la procedura si comporta in questo modo,
// in base al parametro PInsNormale:
//   - PInsNormale = True  -> viene sollevata un eccezione con l'errore riscontrato
//   - PInsNormale = False -> viene richiamata la procedure PeriodoNonInserito
// parametri
// - PInsNormale
//     determina il tipo di azione che ha determinato la chiamata di questa procedura
//     valori possibili
//     - True:  controlli da effettuare in caso di inserimento / cancellazione manuale del giustificativo
//     - False: controlli da effettuare in caso di acquisizione richieste da web
// - PInserisci
//     determina se i controlli sono da effettuare per un inserimento o per una cancellazione
//     valori possibili
//     - True:  controlli da effettuare in caso di inserimento
//     - False: controlli da effettuare in caso di cancellazione
var Errore,CausInizio,Msg:String;
    FruizVincolata,FruizMin,FruizArr:Integer;
    Trovato:Boolean;
begin
  R600DtM1.ListAnomalie.Clear;
  R600DtM1.ListAnomalieNonBloccanti.Clear;
  // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.ini
  // cancella lista completa anomalie per elaborazioni massive
  ListAnomalieCompleta.Clear;
  // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.fine
  Errore:='';

  // controllo esistenza coniuge di riferimento
  if (Var_Gestione = 1) and (selConiuge.FieldByName('NUM').AsInteger = 0) then
  begin
    Errore:=A000TraduzioneStringhe(A000MSG_A004_MSG_NO_CONIUGE);
  end;

  // controllo indicazione causale
  if (Errore = '') and (Var_Causale = '') then
  begin
    Errore:=A000TraduzioneStringhe(A000MSG_A004_MSG_NO_CAUSALE);
  end;

  // controlli sul periodo dal / al
  if Errore = '' then
  begin
    NumGiorni:=Var_NumGG <> 0;
    if NumGiorni then
      R180ControllaPeriodo(Var_DaData,Var_NumGG,DataInizio,DataFine,Errore)
    else
      R180ControllaPeriodo(Var_DaData,Var_AData,DataInizio,DataFine,Errore);
  end;

  //CCNL 2018 - non lascio inserire un periodo di più giorni per i permessi per visite mediche, altrimenti non funziona bene il controllo sulle competenze alternative
  if (Errore = '') and (Var_TipoCaus = 1) and (Var_TipoGiust in [2,3]) and (DataInizio <> DataFine) then
  begin
    if (R600DtM1.GetValStrT230(Var_Causale,'CAUSALI_CHECKCOMPETENZE',DataInizio) <> '') or
       (R600DtM1.GetValStrT230(Var_Causale,'CAUSALI_CHECKCOMPETENZE',DataFine) <> '') or
       (R600DtM1.GetValStrT230(Var_Causale,'CAUSALE_FRUIZORE',DataInizio) <> '') or
       (R600DtM1.GetValStrT230(Var_Causale,'CAUSALE_FRUIZORE',DataFine) <> '') or
       (R600DtM1.GetValStrT230(Var_Causale,'CAUSALE_HMASSENZA',DataInizio) <> '') or
       (R600DtM1.GetValStrT230(Var_Causale,'CAUSALE_HMASSENZA',DataFine) <> '')
    then
    begin
      Errore:=A000TraduzioneStringhe(A000MSG_A004_ERR_GGCONSECUTIVI);
    end;
  end;

  // dato "da ore" / "numero ore"
  if (Errore = '') and (Var_TipoGiust >= IfThen(Var_TipoCaus = 0,0,2)) then
  begin
    if Trim(Var_DaOre) = '' then
    begin
      Errore:=A000TraduzioneStringhe(A000MSG_A004_MSG_DAORE_VUOTO);
    end
    else
    begin
      try
        Var_DaOre:=FormatDateTime('hh.nn',StrToTime(Var_DaOre));
      except
        Errore:=A000TraduzioneStringhe(A000MSG_A004_MSG_DAORE_ERRATO);
      end;
    end;
  end;

  // dato "a ore" (periodo "da ore" / "a ore")
  if (Errore = '') and (Var_TipoGiust = IfThen(Var_TipoCaus = 0,1,3)) then
  begin
    if Trim(Var_AOre) = '' then
    begin
      Errore:=A000TraduzioneStringhe(A000MSG_A004_MSG_AORE_VUOTO);
    end
    else
    begin
      try
        Var_AOre:=FormatDateTime('hh.nn',StrToTime(Var_AOre));
      except
        Errore:=A000TraduzioneStringhe(A000MSG_A004_MSG_AORE_ERRATO);
      end;
      if (Errore = '') and (StrToTime(Var_DaOre) > StrToTime(Var_AOre)) and (R180OreMinutiExt(Var_AOre) <> 0) then
      begin
        Errore:=A000TraduzioneStringhe(A000MSG_A004_MSG_DAORE_AORE_ERRATO);
      end;
    end;
  end;

  // controllo inizio catena.ini - TORINO_ASLTO2 - 2013/044 - INT_TECN 4
  // l'operazione di inserimento è consentita solo se la causale è a inizio catena
  if (Errore = '') and (PInserisci) then
  begin
    if (Parametri.CampiRiferimento.C23_InsNegCatena = 'S') and
       (not R600DtM1.IsInizioCatenaCausAss(Var_Causale,CausInizio)) then
    begin
      Errore:=A000TraduzioneStringhe(Format(A000MSG_MSG_FMT_INIZIOCATENA,[Var_Causale,CausInizio]));
    end;
  end;
  // controllo inizio catena.fine

  // Controllo 'tipo giustificativo' con 'unità di misura inserimento' della causale
  if (Errore = '') and (Var_TipoCaus = 0) and (PInserisci) then
  begin
    // non inseribile in numero ore
    if (Errore = '') and (Var_TipoGiust = 0) and
       (Q275.FieldByName('UM_INSERIMENTO_H').AsString = 'N') then
    begin
      Errore:=A000TraduzioneStringhe(A000MSG_ERR_NO_INS_HH_NUMERO);
    end;

    // non inseribile nella forma da ore / a ore
    if (Errore = '') and (Var_TipoGiust = 1) and
       (Q275.FieldByName('UM_INSERIMENTO_D').AsString = 'N') then
    begin
      Errore:=A000TraduzioneStringhe(A000MSG_ERR_NO_INS_HH_DA_A);
    end;
  end;

  // tipo giustificativo per assenze
  if (Errore = '') and (Var_TipoCaus = 1) and (PInserisci) then
  begin
    // non inseribile a giornate intere
    if (Errore = '') and (Var_TipoGiust = 0) and
       (Q265.FieldByName('UM_INSERIMENTO').AsString = 'N') then
    begin
      Errore:=A000TraduzioneStringhe(A000MSG_ERR_NO_INS_GG_INTERE);
    end;

    // non inseribile a mezze giornate
    if (Errore = '') and (Var_TipoGiust = 1) and
       (Q265.FieldByName('UM_INSERIMENTO_MG').AsString = 'N') then
    begin
      Errore:=A000TraduzioneStringhe(A000MSG_ERR_NO_INS_GG_MEZZE);
    end;

    // non inseribile in numero ore
    if (Errore = '') and (Var_TipoGiust = 2) and
       (Q265.FieldByName('UM_INSERIMENTO_H').AsString = 'N') then
    begin
      Errore:=A000TraduzioneStringhe(A000MSG_ERR_NO_INS_HH_NUMERO);
    end;

    // non inseribile nella forma da ore / a ore
    if (Errore = '') and (Var_TipoGiust = 3) and
       (Q265.FieldByName('UM_INSERIMENTO_D').AsString = 'N') then
    begin
      Errore:=A000TraduzioneStringhe(A000MSG_ERR_NO_INS_HH_DA_A);
    end;
  end;

  //Verifica vincoli sulla fruizione oraria
  if (Errore = '') and (Var_TipoCaus = 1) and (PInserisci) then
  begin
    FruizArr:=Q265.FieldByName('FRUIZ_ARR').AsInteger;
    FruizMin:=Q265.FieldByName('FRUIZ_MIN').AsInteger;
    if Q265.FieldByName('FRUIZCOMPETENZE_ARR').AsString = 'S' then
    begin
      FruizArr:=0;
      if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
        FruizMin:=0;
    end;
    case Var_TipoGiust of
    2:begin
        FruizVincolata:=R180OreMinutiExt(Var_DaOre);
        if FruizVincolata > 0 then
        begin
          R600DtM1.ControllaVincoliFruizione(R180OreMinutiExt(Var_DaOre),FruizMin,Q265.FieldByName('FRUIZ_MAX').AsInteger,FruizArr,FruizVincolata);
          Var_DaOre:=R180MinutiOre(FruizVincolata);
        end
        else
          FruizVincolata:=1;
      end;
    3:begin
        R600DtM1.ControllaVincoliFruizione(IfThen(R180OreMinutiExt(Var_AOre) = 0,1440,R180OreMinutiExt(Var_AOre)) - R180OreMinutiExt(Var_DaOre),FruizMin,Q265.FieldByName('FRUIZ_MAX').AsInteger,FruizArr,FruizVincolata);
        if R180OreMinutiExt(Var_DaOre) + FruizVincolata = 1440 then
          Var_AOre:='00.00'
        else
          Var_AOre:=R180MinutiOre(R180OreMinutiExt(Var_DaOre) + FruizVincolata);
      end;
    end;

    // fruizione inferiore ai vincoli
    if (Var_TipoGiust in [2,3]) and (FruizVincolata = 0) then
    begin
      Errore:=A000TraduzioneStringhe(A000MSG_ERR_FRUIZ_INF_VINCOLI);
    end;
  end;

  // controlli sul familiare di riferimento
  // mantenere come ultimi controlli nell'ordine (per via di controllo non bloccante sui familiari)
  if Errore = '' then
  begin
    if Var_TipoCaus = 1 then
    begin
      Q265.Locate('CODICE',Var_Causale,[]);

      // giustificativi legati ai familiari solo per assenze
      with Q265 do
      begin
        if ((R180CarattereDef(FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D']) or
            (R180CarattereDef(FieldByName('FRUIZIONE_FAMILIARI').AsString,1,'N') in ['S','D'])) then
        begin
          // il familiare di riferimento è obbligatorio
          if Var_Familiari = '' then
          begin
            Errore:=A000TraduzioneStringhe(A000MSG_MSG_SPECIFIC_FAMILIARE_RIF);
          end
          else if PInsNormale then
          begin
            //Verifico se il familiare è valido a fine periodo
            //Non si fa questo controllo per inserimento delle richieste da Web
            with R600Dtm1.selSG101Causali do
            begin
              Trovato:=False;
              if SearchRecord('DATA',StrToDateTime(Var_Familiari),[srFromBeginning]) then
              begin
                repeat
                  if (DataFine >= FieldByName('DECORRENZA').AsDateTime) and (DataFine <= FieldByName('DECORRENZA_FINE').AsDateTime) then
                  begin
                    Trovato:=(Pos('<*>',FielDByName('CAUSALI_ABILITATE').AsString) > 0) or
                             (Pos('<' + Var_Causale + '>',FieldByName('CAUSALI_ABILITATE').AsString) > 0);
                    Break;
                  end;
                until not SearchRecord('DATA',StrToDateTime(Var_Familiari),[]);
                if not Trovato then
                begin
                  // familiare non associato alla causale alla data di fine periodo: conferma operazione
                  Msg:=Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_CAUS_FAMILIARE2),[Var_Causale]);
                  if R180MessageBox(Msg,DOMANDA) = mrNo then
                    Errore:=A000TraduzioneStringhe(A000MSG_ERR_CAUS_FAMILIARE);
                end;
              end;
            end;
          end;
        end;
      end;
    end
    else
    begin
      Q275.Locate('CODICE',Var_Causale,[]);
    end;
  end;

  // in fase di inserimento controlla se è necessario richiedere la certificazione pubblica
  // (per decreto brunetta)
  if (Errore = '') and
     (PInserisci) and
     (GestioneSingolaDM) and
     (Var_TipoCaus = 1) and
     (Var_Gestione = 0) and
     (DataFine >= EncodeDate(2008,06,25)) and
     (not Q265.FieldByName('CODCAU3').IsNull) and
     (R600DtM1.ServeCertificazionePubblica(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Var_Causale,DataInizio,DataFine)) then
  begin
    Msg:=A000TraduzioneStringhe(A000MSG_A004_DLG_CERT_PUBBLICA);
    if R180MessageBox(Msg,DOMANDA) = mrNo then
      Abort;
  end;

  // se i controlli hanno evidenziato un errore si comporta di conseguenza:
  // in base a PInsNormale
  // - True  -> controlli per inserimento singolo
  // - False -> controlli per inserimenti massivi (acquisizioni richieste / giustificativi da file)
  if (Errore <> '') or (R600DtM1.ListAnomalie.Count <> 0) then
  begin
    if PInsNormale then
    begin
      raise Exception.Create(Errore);
    end
    else
    begin
      PeriodoNonInserito(Errore);
    end;
  end;
end;

procedure TA004FGiustifAssPresMW.InserisciGiustif(InsNormale:Boolean; ID: string);
begin
  IdCertificato:=ID;
  IdRichiestaWeb:=0;
  Var_RestoHMA:=0;
  SetLength(lstFruizGiornaliereHMA,0);
  _InserisciGiustif(InsNormale);
  //Alberto 11/07/2018 - CCNL 2018:Inserimento giustificativi giornalieri automatici corrispondenti al cumulo delle fruizioni orarie (Visite mediche)
  _InserisciGiustifHMA(InsNormale);
end;

procedure TA004FGiustifAssPresMW.InserisciGiustif(InsNormale:Boolean; ID: int64 = 0);
begin
  IdRichiestaWeb:=ID;
  IdCertificato:='';
  Var_RestoHMA:=0;
  SetLength(lstFruizGiornaliereHMA,0);
  _InserisciGiustif(InsNormale);
  //Alberto 11/07/2018 - CCNL 2018:Inserimento giustificativi giornalieri automatici corrispondenti al cumulo delle fruizioni orarie (Visite mediche)
  _InserisciGiustifHMA(InsNormale);
end;

procedure TA004FGiustifAssPresMW.Chek_CausaleHMAssenza(Progressivo:Integer; Dal,Al:TDateTime; Causale,TG:String);
var CausHMAssenza:String;
begin
  Cancellazione_CausaleHMAssenza.Causale:='';
  Cancellazione_CausaleHMAssenza.Data:=0;

  if R180In(TG,['N','D']) and (R600DtM1.GetValStrT230(Causale,'CAUSALE_HMASSENZA',Dal) <> '') then
  begin
    Inserimento_CausaleHMAssenza(Progressivo,Dal,Al,Causale);
  end
  //ReggioEmilia_Comune: considero anche le fruizioni a gg intera
  else if (Parametri.CampiRiferimento.C23_VMHFruizGG = 'S') and R180In(TG,['I']) then
  begin
    R180SetVariable(R600DtM1.selT265GGAutoFruizGG,'CAUSALE',Causale);
    R600DtM1.selT265GGAutoFruizGG.Open;
    if R600DtM1.selT265GGAutoFruizGG.RecordCount > 0 then
      Inserimento_CausaleHMAssenza(Progressivo,Dal,Al,R600DtM1.selT265GGAutoFruizGG.FieldByName('CODICE').AsString);
  end;
end;

procedure TA004FGiustifAssPresMW._InserisciGiustifHMA(InsNormale:Boolean);
var i:Integer;
  bckDataInizio:TDateTime;
  bckDataFine:TDateTime;
  bckVar_DaData:String;
  bckVar_AData:String;
  bckVar_Causale:String;
  bckVar_TipoCaus:Integer;
  bckVar_Gestione:Integer;
  bckVar_TipoGiust:Integer;
  bckVar_TipoGiust_Count:Integer;
  bckVar_DaOre:String;
  bckVar_AOre:String;
  bckVar_NumGG:Integer;
  bckVar_Familiari:String;
  bckGiustif:TGiustificativo;
  bckchkNuovoPeriodo:Boolean;
  bckNumGiorni:Boolean;
  bckR600DtM1VisualizzaAnomalie:Boolean;
  bckR600DtM1AnomalieBloccanti:Boolean;
  bckR600DtM1CheckIntersezioneTimbrature:Boolean;
  bckR600DtM1RichiesteIterAutorizzativo:Boolean;
begin
  if Length(lstFruizGiornaliereHMA) = 0 then
    exit;
  //Salvataggio valori originali
  bckDataInizio:=DataInizio;
  bckDataFine:=DataFine;
  bckVar_DaData:=Var_DaData;
  bckVar_AData:=Var_AData;
  bckVar_Causale:=Var_Causale;
  bckVar_TipoCaus:=Var_TipoCaus;
  bckVar_Gestione:=Var_Gestione;
  bckVar_TipoGiust:=Var_TipoGiust;
  bckVar_TipoGiust_Count:=Var_TipoGiust_Count;
  bckVar_DaOre:=Var_DaOre;
  bckVar_AOre:=Var_AOre;
  bckVar_NumGG:=Var_NumGG;
  bckVar_Familiari:=Var_Familiari;
  bckGiustif:=Giustif;
  bckchkNuovoPeriodo:=chkNuovoPeriodo;
  bckNumGiorni:=NumGiorni;
  bckR600DtM1VisualizzaAnomalie:=R600DtM1.VisualizzaAnomalie;
  bckR600DtM1AnomalieBloccanti:=R600DtM1.AnomalieBloccanti;
  bckR600DtM1CheckIntersezioneTimbrature:=R600DtM1.CheckIntersezioneTimbrature;
  bckR600DtM1RichiesteIterAutorizzativo:=R600DtM1.RichiesteIterAutorizzativo;

  IdRichiestaWeb:=0;
  IdCertificato:='';
  //Var_Progressivo//Già valorizzato
  for i:=0 to High(lstFruizGiornaliereHMA) do
  begin
    DataInizio:=lstFruizGiornaliereHMA[i].data;
    DataFine:=lstFruizGiornaliereHMA[i].data;
    Var_DaData:=FormatDateTime('dd/mm/yyyy',lstFruizGiornaliereHMA[i].data);
    Var_AData:=FormatDateTime('dd/mm/yyyy',lstFruizGiornaliereHMA[i].data);
    Var_Causale:=lstFruizGiornaliereHMA[i].causale;
    Var_RestoHMA:=lstFruizGiornaliereHMA[i].Resto;
    //Valori di default
    Var_TipoCaus:=1;
    Var_Gestione:=0;
    Var_TipoGiust:=0;
    Var_TipoGiust_Count:=4;
    Var_DaOre:='  .  ';
    Var_AOre:='  .  ';
    Var_NumGG:=0;
    Var_Familiari:='';
    Giustif.Inserimento:=True;
    Giustif.Modo:='I';
    Giustif.Causale:=Var_Causale;
    Giustif.DaOre:='.';
    Giustif.AOre:='.';
    Giustif.Note:='';
    chkNuovoPeriodo:=False;
    NumGiorni:=False;
    R600DtM1.VisualizzaAnomalie:=False;
    R600DtM1.AnomalieBloccanti:=True;
    R600DtM1.CheckIntersezioneTimbrature:=False;
    R600DtM1.RichiesteIterAutorizzativo:=False;
    //Inserimento del giustificativo
    _InserisciGiustif(InsNormale);
  end;
  Var_RestoHMA:=0;
  SetLength(lstFruizGiornaliereHMA,0);

  //Ripristino valori originali
  DataInizio:=bckDataInizio;
  DataFine:=bckDataFine;
  Var_DaData:=bckVar_DaData;
  Var_AData:=bckVar_AData;
  Var_Causale:=bckVar_Causale;
  Var_TipoCaus:=bckVar_TipoCaus;
  Var_Gestione:=bckVar_Gestione;
  Var_TipoGiust:=bckVar_TipoGiust;
  Var_TipoGiust_Count:=bckVar_TipoGiust_Count;
  Var_DaOre:=bckVar_DaOre;
  Var_AOre:=bckVar_AOre;
  Var_NumGG:=bckVar_NumGG;
  Var_Familiari:=bckVar_Familiari;
  Giustif:=bckGiustif;
  chkNuovoPeriodo:=bckchkNuovoPeriodo;
  NumGiorni:=bckNumGiorni;
  R600DtM1.VisualizzaAnomalie:=bckR600DtM1VisualizzaAnomalie;
  R600DtM1.AnomalieBloccanti:=bckR600DtM1AnomalieBloccanti;
  R600DtM1.CheckIntersezioneTimbrature:=bckR600DtM1CheckIntersezioneTimbrature;
  R600DtM1.RichiesteIterAutorizzativo:=bckR600DtM1RichiesteIterAutorizzativo;
end;

procedure TA004FGiustifAssPresMW._InserisciGiustif(InsNormale:Boolean);
// Inserisce i giustificativi al dipendente col progressivo assegnato
var
  DataCorr:TDateTime;
  TG,EdtDa,EdtA,ElencoCausali,CausaleOriginale,
  CausInserita,CausaleGGNonLav,
  VisitaFiscale,CausPeriodi,CumuloCausPrec,CumuloCausAtt,Msg: String;
  TGOriginale,EdtDaOriginale,EdtAOriginale,
  TGSucc,EdtDaSucc,EdtASucc:String;
  CausaleSuccessiva,Inserito,InizioRiduzioni,Esegui: Boolean;
  PostEseguito,InserisciGGNonSignificativo:Boolean;
  FruizVincolata,n:Integer;
  UM,CP,CC,CT,FP,FC,FT,R,S:String;
  ValGio,Giorno:Integer;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  LFruizMaxMattine,LFruizMaxPomeriggi: Integer;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
begin
  // inizializzazione variabili
  Inserito:=False;
  InserisciGGNonSignificativo:=False;

  if not InsNormale then
  begin
    R600DtM1.ListAnomalie.Clear;
    R600DtM1.ListAnomalieNonBloccanti.Clear;
    // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.ini
    // cancella lista completa anomalie per elaborazioni massive
    ListAnomalieCompleta.Clear;
    // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.fine
  end;
  Q040B.DisableControls;

  //Alberto 09/07/2018 - CCNL 2018: inserimento assenza ad ore viene 'girato' su altra causale (VMD10 --> VMH)
  if (Var_TipoCaus = 1) and (Var_TipoGiust in [2,3]) then
  begin
    S:=R600DtM1.GetValStrT230(Var_Causale,'CAUSALE_FRUIZORE',DataInizio);
    if S <> '' then
    begin
      Var_Causale:=S;
      Giustif.Causale:=S;
    end;
  end;

  try
    //Alberto 19/02/2015: resetto il periodo nel caso di periodo specificato in num.giorni e inserimento massivo
    if NumGiorni then
    begin
      R180ControllaPeriodo(Var_DaData,Var_NumGG,DataInizio,DataFine,Msg);
      Msg:='';
    end;
    //Alberto 04/01/2011: resetto il riferimento ai familiari se non ci sono le condizioni.
    //Controllo utile per ricalcolo causali concatenate successivamente.
    if not ((Var_TipoCaus = 1) and
            ((R180CarattereDef(VarToStr(Q265.Lookup('Codice',Var_Causale,'Cumulo_Familiari'))) in ['S','D']) or
             (R180CarattereDef(VarToStr(Q265.Lookup('Codice',Var_Causale,'Fruizione_Familiari'))) in ['S','D']))) then
    begin
      Var_Familiari:='';
    end;
    EdtDa:=Var_DaOre;
    EdtA:=Var_AOre;
    if Var_Familiari <> '' then
      R600DtM1.RiferimentoDataNascita.Data:=StrToDateTime(Var_Familiari);
    case Var_TipoGiust of
      0:if Var_TipoGiust_Count = 4 then
          TG:='I'
        else
          TG:='N';
      1:if Var_TipoGiust_Count = 4 then
          TG:='M'
        else
          TG:='D';
      2:TG:='N';
      3:TG:='D';
    end;
    //Verifica della fruizione oraria se richiesto il controllo col debito gg
    if (Var_TipoCaus = 1) and (Var_TipoGiust in [2,3]) and (VarToStr(Q265.Lookup('CODICE',Var_Causale,'FRUIZ_MAX_DEBITO')) = 'S') then
    begin
      case Var_TipoGiust of
        2:begin
            R600DtM1.ControllaFruizMaxDebito(DataInizio,Var_Progressivo,R180OreMinutiExt(EdtDa),Var_Causale,'N',Var_DaOre,Var_AOre,FruizVincolata);
            EdtDa:=R180MinutiOre(FruizVincolata);
          end;
        3:begin
            R600DtM1.ControllaFruizMaxDebito(DataInizio,Var_Progressivo,IfThen(R180OreMinutiExt(EdtA) = 0,1440,R180OreMinutiExt(EdtA)) - R180OreMinutiExt(EdtDa),Var_Causale,'D',Var_DaOre,Var_AOre,FruizVincolata);
            if R180OreMinutiExt(EdtDa) + FruizVincolata = 1440 then
              EdtA:='00.00'
            else
              EdtA:=R180MinutiOre(R180OreMinutiExt(EdtDa) + FruizVincolata);
          end;
      end;
      if FruizVincolata = 0 then
        Abort;
    end;
    if chkNuovoPeriodo then
    begin
      scrT031.SetVariable('PROGRESSIVO',Var_Progressivo);
      scrT031.SetVariable('DATA1',DataInizio);
      scrT031.SetVariable('DATA2',DataFine);
      scrT031.SetVariable('INSERIMENTO','S');
      scrT031.Execute;
    end;
    //Alberto 08/04/2009: Torino_Comune - Copertura automatica dei gg non lav.
    //CausaleGGNonLav può essere diversa da Var_causale (CausaleOriginale) per coprire i gg non lav con la causale del periodo precedente
    {Bruno 20/05/2011:(A087 Inserimento Certificati INPS)
     TipoCertificatoINPS se tipo certificato INSP = 'I', ovvero "inserimento nuovo periodo",
     la variabile COPRI_GGNONLAV è come se fosse = N}
    DataInizioOrig:=DataInizio;
    if (Var_TipoCaus = 1) and (Var_TipoGiust = 0) and (TipoCertificatoINPS <> 'I') and
       (VarToStr(Q265.Lookup('CODICE',Var_Causale,'GSIGNIFIC')) = 'GC') and
       R180In(VarToStr(Q265.Lookup('CODICE',Var_Causale,'COPRI_GGNONLAV')),['S','E']) then
       {Bruno: 12/01/2015
       (VarToStr(Q265.Lookup('CODICE',Var_Causale,'COPRI_GGNONLAV')) = 'S') then}
    begin
      // controlla copertura giorni non lavorativi
      if not chkNuovoPeriodo then
      begin
        CoperturaGiorniNonLavorativi(DataInizio,CausaleGGNonLav);
      end
      else if {chkNuovoPeriodo and} InsNormale then // la condizione commentata è superflua
      begin
        Msg:=A000TraduzioneStringhe(A000MSG_A004_DLG_NUOVO_PERIODO);
        if R180MessageBox(Msg,DOMANDA) = mrYes then
          CoperturaGiorniNonLavorativi(DataInizio,CausaleGGNonLav);
      end;
    end;

    // inizializzazioni per ciclo di inserimento / cancellazione
    DataCorr:=DataInizio;
    //Solo per assenze:Calcolo periodo di fruizione, competenze e cumuli
    if Var_TipoCaus = 1 then
    begin
      R600DtM1.LetturaRiduzioni:=False;
      case R600DtM1.SettaConteggi(Var_Progressivo,DataInizio,DataFine,Giustif) of
        mrAbort:
          begin
            // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.ini
            // la function Anomalie non visualizza più un messaggio interattivo
            // pertanto occorre prevederlo qui (solo se VisualizzaAnomalie è True)
            Msg:=A000TraduzioneStringhe(A000MSG_A004_MSG_PRESENZA_ANOMALIE) + CRLF +
                 R600DtM1.FormattaAnomaliaWeb(R600DtM1.ListAnomalie) + CRLF +
                 A000TraduzioneStringhe(A000MSG_A004_MSG_GG_STOP_INS);
            if R600DtM1.VisualizzaAnomalie then
              R180MessageBox(Msg,ESCLAMA);
            // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.fine

            // annulla operazione: abort
            Abort;
          end;
      end;
    end;

    // gestione progressbar delegata alla form
    {$IFNDEF IRISWEB}
    if GestioneSingolaDM and (Assigned(ProgressBar)) and (not AcquisizioneWebInCorso) then
    begin
      ProgressBar.Position:=0;
      ProgressBar.Max:=Trunc(DataFine - DataCorr) + 1;
    end;
    {$ENDIF IRISWEB}

    Q040.CommitOnPost:=EseguiCommit;
    CausaleSuccessiva:=False;
    CausaleOriginale:=Var_Causale;
    CausInserita:='';
    TGOriginale:=TG;
    EdtDaOriginale:=EdtDa;
    EdtAOriginale:=EdtA;
    // dimensiona l'array dei giorni per le visite fiscali
    // viene volutamente dimensionato con un elemento in più
    // (in modo da ottenere un range di tipo [1..Numero_Giorni])
    R600DtM1.VisFiscaliSetArray(Trunc(DataFine - DataInizio) + 2);

    R600DtM1.LetturaRiduzioni:=False;

    // ciclo di gestione nel periodo indicato
    while DataCorr <= DataFine do
    begin
      // commessa: MAN/08 SVILUPPO#56 - riesame del 09.10.2013.ini
      // aggiunge la lista di anomalie alla lista completa per le elaborazioni massive
      ListAnomalieCompleta.AddStrings(R600DtM1.ListAnomalie);
      // commessa: MAN/08 SVILUPPO#56 - riesame del 09.10.2013.fine

      // commessa: MAN/08 SVILUPPO#56 - riesame del 08.10.2013.ini
      // pulisce la lista di anomalie
      R600DtM1.ListAnomalie.Clear;
      // commessa: MAN/08 SVILUPPO#56 - riesame del 08.10.2013.fine

      PostEseguito:=False;
      if not CausaleSuccessiva then
      begin
        // gestione progressbar delegata alla form.ini
        {$IFNDEF IRISWEB}
        if GestioneSingolaDM and (Assigned(ProgressBar)) and (not AcquisizioneWebInCorso) then
        begin
          ProgressBar.StepBy(1);
          ProgressBar.Repaint;
        end;
        {$ENDIF IRISWEB}
        // gestione progressbar delegata alla form.fine

        if Var_Causale <> IfThen(DataCorr < DataInizioOrig,CausaleGGNonLav,CausaleOriginale) then
        begin
          Giustif.Causale:=IfThen(DataCorr < DataInizioOrig,CausaleGGNonLav,CausaleOriginale);
          // se la causale è nel cumulo di quella precedente, e la causale prec. è nel cumulo di quella attuale
          // allora non riesegue i conteggi
          if CausInserita = '' then
            InizioRiduzioni:=True
          else
          begin
            CumuloCausPrec:=VarToStr(R600DtM1.Q265.Lookup('CODICE',CausInserita,'CODCAU1'));
            CumuloCausAtt:=VarToStr(R600DtM1.Q265.Lookup('CODICE',Giustif.Causale,'CODCAU1'));
            InizioRiduzioni:=(Pos(',' + IfThen(DataCorr < DataInizioOrig,CausaleGGNonLav,CausaleOriginale) + ',',',' + CumuloCausPrec + ',') = 0) or
                             (Pos(',' + Var_Causale + ',',',' + CumuloCausAtt + ',') = 0);
            // se la causale attuale e quella precedente fanno parte dello stesso raggruppamento
            // allora non riesegue i conteggi
            if VarToStr(R600DtM1.Q265.Lookup('CODICE',CausInserita,'CODRAGGR')) = VarToStr(R600DtM1.Q265.Lookup('CODICE',Giustif.Causale,'CODRAGGR')) then
              InizioRiduzioni:=False;
          end;
          R600DtM1.GetRiduzione(Var_Progressivo,DataCorr,DataFine,R600DtM1.RiferimentoDataNascita.Data(*0*),Giustif,UM,CP,CC,CT,FP,FC,FT,R,ValGio,Giorno,InizioRiduzioni,False);
          //InizioRiduzioni:=False;
          R600DtM1.LetturaRiduzioni:=True;
        end;
        R600DtM1.LetturaRiduzioni:=True; //Alberto 11/03/2013: sembra che si debba sempre impostare questo valore su LetturaRiduzioni affinchè il sucessivo ControlliGenerali non ricalcoli sempre le competenze (Malattia) quando si inserisce prolunamento periodo non brunettizzato
        Var_Causale:=IfThen(DataCorr < DataInizioOrig,CausaleGGNonLav,CausaleOriginale);
        ElencoCausali:=Var_Causale;
      end
      else
      begin
        CausaleSuccessiva:=False;
        // se la causale è nel cumulo di quella precedente, e la causale prec. è nel cumulo di quella attuale
        // allora non riesegue i conteggi
        CumuloCausPrec:=VarToStr(R600DtM1.Q265.Lookup('CODICE',Giustif.Causale,'CODCAU1'));
        CumuloCausAtt:=VarToStr(R600DtM1.Q265.Lookup('CODICE',Var_Causale,'CODCAU1'));
        InizioRiduzioni:=(Pos(',' + Var_Causale + ',',',' + CumuloCausPrec + ',') = 0) or
                         (Pos(',' + Giustif.Causale + ',',',' + CumuloCausAtt + ',') = 0);
        // se la causale attuale e quella precedente fanno parte dello stesso raggruppamento
        // allora non riesegue i conteggi
        if VarToStr(R600DtM1.Q265.Lookup('CODICE',Giustif.Causale,'CODRAGGR')) = VarToStr(R600DtM1.Q265.Lookup('CODICE',Var_Causale,'CODRAGGR')) then
          InizioRiduzioni:=False;
        //per TORINO_CSI, reset dei conteggi nel caso di causali legate alla catena RECOR
        if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (CausaleOriginale = TO_CSI_RICH_RECHH) then
          InizioRiduzioni:=True;

        Giustif.Causale:=Var_Causale;
        R600DtM1.GetRiduzione(Var_Progressivo,DataCorr,DataFine,R600DtM1.RiferimentoDataNascita.Data,Giustif,UM,CP,CC,CT,FP,FC,FT,R,ValGio,Giorno,InizioRiduzioni,False);
        R600DtM1.LetturaRiduzioni:=True;
      end;

      // controlli in base al tipo di causale (presenza / assenza)
      if Var_TipoCaus = 1 then
      begin
        // controlli per causali di assenza (Var_TipoCaus = 1)
        case R600DtM1.ControlliGenerali(DataCorr) of
          mrIgnore: //Passo al giorno successivo
            begin
              // anomalie non bloccanti
              if R600DtM1.AnomaliaAssenze > 0 then
              begin
                Msg:=A000TraduzioneStringhe(A000MSG_A004_MSG_PRESENZA_ANOMALIE) + CRLF +
                     R600DtM1.FormattaAnomaliaWeb(R600DtM1.ListAnomalie) + CRLF +
                     A000TraduzioneStringhe(A000MSG_MSG_CONTINUA_ANOM);
                if R600Dtm1.VisualizzaAnomalie then
                begin
                  // richiesta di ignorare anomalie
                  // continua (si), annulla giorno (no), annulla operazione (abort)
                  case R180MessageBox(Msg,ERR_ELAB_CONTINUA,A000TraduzioneStringhe(A000MSG_MSG_ANOMALIE_R600)) of
                    mrNo:
                      begin
                        // annulla giorno: passa al giorno successivo
                        R600DtM1.RimuoviAssenzeConteggiate(DataCorr);  // rimuove l'ultima assenza conteggiata se corrispondente alla data corrente
                        DataCorr:=DataCorr + 1;
                        Continue;
                      end;
                    mrAbort:
                      begin
                        // annulla operazione: abort
                        Abort;
                      end;
                  end;
                end
                else
                begin
                  // annulla operazione: abort
                  Abort;
                end;
              end
              else
              begin
                if (R600DtM1.GGSignific) and
                   (Parametri.CampiRiferimento.C30_WebSrv_A004_URL <> '') and
                   (Parametri.CampiRiferimento.C30_WebSrv_A004_Dati <> '') and
                   (TG = 'I') and
                   (not SelDatiBloccati.DatoBloccato(Var_Progressivo,SelDatiBloccati.MeseBloccoRiepiloghi(DataCorr),'T040')) and
                   (not Q040.SearchRecord('Progressivo;Data;Causale',VarArrayOf([Var_Progressivo,DataCorr,FIRLAB_RIPOSO]),[srFrombEginning])) then
                begin
                  //if InserisciGGNonSignificativo then //Alberto 16/09/2013: pare che sia sempre necessario passare i giorni non significativi a Firlab, anche se sono i primi del periodo
                  begin
                    R600DtM1.ListAnomalie.Clear;
                    Q040.Append;
                    if (not InsNormale) and (IdRichiestaWeb <> 0) then
                      Q040.FieldByName('Id_Richiesta').AsLargeInt:=IdRichiestaWeb;
                    if (not InsNormale) and (IdCertificato <> '') then
                      Q040.FieldByName('Id_Certificato').AsString:=IdCertificato;
                    Q040.FieldByName('Progressivo').AsInteger:=Var_Progressivo;
                    Q040.FieldByName('Data').AsDateTime:=DataCorr;
                    Q040.FieldByName('Causale').AsString:=FIRLAB_RIPOSO;
                    Q040.FieldByName('Note').AsString:=Var_Note;
                    Q040.FieldByName('ProgrCausale').AsInteger:=0;
                    Q040.FieldByName('TipoGiust').AsString:='I';
                    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
                    // il tipo mezza giornata è significativo solo per Modo = M
                    Q040.FieldByName('TIPO_MG').AsString:='';
                    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
                    // decreto brunetta.fine
                    OperatoreBck:=Parametri.Operatore; //Per gestire l'operatore che chiama dal web service B021
                    if (Chiamante = 'B021') and (B021Autorizzatore <> '') then
                      Parametri.Operatore:=B021Autorizzatore;
                    RegistraLog.SettaProprieta('I','T040_GIUSTIFICATIVI',IfThen(Chiamante <> '',Copy(Chiamante,1,4),Copy(Self.Name,1,4)),Q040,True);
                    Parametri.Operatore:=OperatoreBck;
                    begin
                      Q040.Post;
                      PostEseguito:=True;
                      RegistraLog.RegistraOperazione;
                    end
                  end;
                  (*Eventuale messaggio aggiuntivo per firlab
                  else
                    with R600DtM1 do
                      ListAnomalie.Add(Format('Badge:%-8s %s %s %s %-5s %s %s',[
                                                '',
                                                QAnagra.FieldByName('COGNOME').AsString,
                                                QAnagra.FieldByName('NOME').AsString,Chr(13),
                                                Var_Causale,Chr(13),
                                                'Giorno non significativo']));
                  *)
                end;
                if R600DtM1.GGSignific and NumGiorni and (Var_NumGG > 1) then
                  DataFine:=DataFine + 1;
                DataCorr:=DataCorr + 1;
                InserisciGGNonSignificativo:=PostEseguito;
                Continue;
              end;
            end;
          mrAbort:
            begin
              // anomalia bloccante
              if (R600DtM1.AnomaliaAssenze = 20) and (not R600DtM1.Q265.FieldByName('CAUSALE_SUCCESSIVA').IsNull) then
              begin
                if (TGSucc = '') and (R600DtM1.GetTotCompetenze > 0) and R600DtM1.SuddividiFruizione(TG,EdtDa,EdtA,TGSucc,EdtDasucc,EdtASucc) then
                begin
                  //Se c'è residuo ma inferiore alla fruizione richiesta, si suddivide la fruizione
                  Giustif.Modo:=TG[1];
                  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
                  Giustif.CSITipoMG:=Var_TipoMG;
                  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
                  Giustif.DaOre:=EdtDa;
                  Giustif.AOre:=EdtA;

                  R600DtM1.Giustificativo.Modo:=TG[1];
                  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
                  R600DtM1.Giustificativo.CSITipoMG:=Var_TipoMG;
                  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
                  R600DtM1.Giustificativo.DaOre:=EdtDa;
                  R600DtM1.Giustificativo.AOre:=EdtA;
                  if R600DtM1.AssenzeConteggiate_Inserita then
                    R600DtM1.ImpostaLengthAssenzeConteggiate(-1);  // rimuove l'ultima assenza conteggiata
                  CausaleSuccessiva:=True;
                  Continue;
                end
                else if Pos(',' + R600DtM1.Q265.FieldByName('CAUSALE_SUCCESSIVA').AsString + ',',',' + ElencoCausali + ',') = 0 then
                begin
                  CausaleSuccessiva:=True;
                  Var_Causale:=R600DtM1.Q265.FieldByName('CAUSALE_SUCCESSIVA').AsString;
                  ElencoCausali:=ElencoCausali + ',' + Var_Causale;
                  if R600DtM1.AssenzeConteggiate_Inserita then
                    R600DtM1.ImpostaLengthAssenzeConteggiate(-1); // rimuove l'ultima assenza conteggiata
                  R600DtM1.ListAnomalie.Clear;  //Rimuove ultime anomalie riferite all'inserimento con causale precedente
                  //Se fruizione spezzata, ma si deve provare a inserire su nuova causale, ricompongo la fruizione attuale con quella successiva
                  if (TGSucc <> '') and (TGSucc = Giustif.Modo) and R180In(TGSucc,['D','N']) then
                  begin
                    if Giustif.Modo = 'D' then
                    begin
                      EdtA:=EdtASucc;
                      Giustif.AOre:=EdtA;
                      R600DtM1.Giustificativo.AOre:=EdtA;
                    end
                    else if Giustif.Modo = 'N' then
                    begin
                      EdtDa:=R180MinutiOre(R180OreMinutiExt(EdtDa) + R180OreMinutiExt(EdtDaSucc));
                      Giustif.DaOre:=EdtA;
                      R600DtM1.Giustificativo.DaOre:=EdtDa;
                    end;
                    TGSucc:='';
                    EdtDaSucc:='';
                    EdtASucc:='';
                  end;
                  Continue;
                end
                else
                begin
                  // commessa 2011/178

                  // annulla operazione: abort
                  Abort;
                end;
              end
              else
              begin
                // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.ini
                // la function Anomalie non visualizza più un messaggio interattivo
                // pertanto occorre prevederlo qui (solo se VisualizzaAnomalie è True)

                //Abort;
                //R600DtM1.ListAnomalie.Clear;

                if R600DtM1.VisualizzaAnomalie then
                begin
                  // anomalie presentate in modo interattivo

                  // se inserimento impedito è True significa che l'operazione non può
                  // proseguire quindi dà un messaggio specifico
                  if R600DtM1.InserimentoImpedito then
                  begin
                    // annulla operazione: abort
                    Msg:=A000TraduzioneStringhe(A000MSG_A004_MSG_PRESENZA_ANOMALIE) + CRLF +
                         R600DtM1.FormattaAnomaliaWeb(R600DtM1.ListAnomalie) + CRLF +
                         A000TraduzioneStringhe(A000MSG_ERR_NO_INSERIMENTO);
                    R180MessageBox(Msg,ERR_ELAB_TERMINA,A000TraduzioneStringhe(A000MSG_MSG_ANOMALIE_R600));
                    Abort;
                  end
                  else
                  begin
                    // annulla giorno (ignore), annulla operazione (abort)
                    Msg:=A000TraduzioneStringhe(A000MSG_A004_MSG_PRESENZA_ANOMALIE) + CRLF +
                         R600DtM1.FormattaAnomaliaWeb(R600DtM1.ListAnomalie) + CRLF +
                         A000TraduzioneStringhe(A000MSG_A004_MSG_GG_STOP_INS);
                    if R180MessageBox(Msg,ERR_ELAB_STOP,A000TraduzioneStringhe(A000MSG_MSG_ANOMALIE_R600)) = mrIgnore then
                    begin
                      // annulla giorno: passa al giorno successivo
                      R600DtM1.RimuoviAssenzeConteggiate(DataCorr);  // rimuove l'ultima assenza conteggiata se corrispondente alla data corrente
                      DataCorr:=DataCorr + 1;
                      Continue;
                    end
                    else
                    begin
                      // annulla operazione: abort
                      Abort;
                    end;
                  end;
                end
                else
                begin
                  // anomalie non presentate in modo interattivo

                  // annulla operazione: abort
                  Abort;
                end;
                // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.fine
              end;
            end;
        end;
      end
      else
      begin
        // controlli per causali di presenza (Var_TipoCaus = 0)
        R600DtM1.Giustificativo:=Giustif;
        if AcquisizioneWebInCorso then
          R600DtM1.SettaInfo1(selT050.FieldByName('NOMINATIVO').AsString,'',selT050.FieldByName('MATRICOLA').AsString,Var_Causale)
        else if (SelAnagrafe <> nil) and (SelAnagrafe.Active) then
          R600DtM1.SettaInfo1(SelAnagrafe.FieldByName('COGNOME').AsString,SelAnagrafe.FieldByName('NOME').AsString,SelAnagrafe.FieldByName('MATRICOLA').AsString,Var_Causale)
        else
          R600DtM1.SettaInfo1('cognome','nome','0',Var_Causale);

        // controlla abilitazione causale
        if R600DtM1.CausalePresenzaAbilitata(Var_Progressivo,DataCorr) <> mrOk then
        begin
          Msg:=A000TraduzioneStringhe(A000MSG_A004_MSG_PRESENZA_ANOMALIE) + CRLF +
               R600DtM1.FormattaAnomaliaWeb(R600DtM1.ListAnomalie) + CRLF +
               A000TraduzioneStringhe(A000MSG_A004_MSG_GG_STOP_INS);
          if R600Dtm1.VisualizzaAnomalie then
            R180MessageBox(Msg,ESCLAMA);
          // annulla operazione: abort
          Abort;
        end;

        // controlla eventuale intersezione del giustificativo con timbrature
        if R600DtM1.IntersezioneGiustTimb(Var_Progressivo,DataCorr,VarToStr(Q275.Lookup('CODICE',Var_Causale,'CAUSALIZZA_TIMB_INTERSECANTI')) <> 'S') <> mrOk then
        begin
          Msg:=A000TraduzioneStringhe(A000MSG_A004_MSG_PRESENZA_ANOMALIE) + CRLF +
               R600DtM1.FormattaAnomaliaWeb(R600DtM1.ListAnomalie) + CRLF +
               A000TraduzioneStringhe(A000MSG_MSG_CONTINUA_ANOM);
          if not R600Dtm1.VisualizzaAnomalie then
            Abort
          else case R180MessageBox(Msg,ERR_ELAB_CONTINUA,A000TraduzioneStringhe(A000MSG_MSG_ANOMALIE_R600)) of
            mrNo:
              begin
                // annulla giorno: passa al giorno successivo
                DataCorr:=DataCorr + 1;
                Continue;
              end;
            mrAbort:
              begin
                // annulla operazione: abort
                Abort;
              end;
          end;
        end;
      end;

      R600DtM1.ListAnomalie.Clear;
      // controlla blocco riepiloghi T040
      if not SelDatiBloccati.DatoBloccato(Var_Progressivo,SelDatiBloccati.MeseBloccoRiepiloghi(DataCorr),'T040') then
      begin
        Q040.Append;
        if (not InsNormale) and (IdRichiestaWeb <> 0) then
          Q040.FieldByName('Id_Richiesta').AsLargeInt:=IdRichiestaWeb
        else if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (Var_Causale = TO_CSI_REC_SETT) and (IdRichiestaWeb = 0) then
        begin
          //Per TORINO_CSI, la causale di recup.ecc.settimanale ha sempre bisogno di un ID anche quando non arriva dall'iter
          seqT850Id.Execute;
          IdRichiestaWeb:=seqT850Id.FieldAsInteger(0);
          Q040.FieldByName('Id_Richiesta').AsLargeInt:=IdRichiestaWeb;
          IdRichiestaWeb:=0;
        end;
        if (not InsNormale) and (IdCertificato <> '') then
          Q040.FieldByName('Id_Certificato').AsString:=IdCertificato;
        Q040.FieldByName('Progressivo').AsInteger:=Var_Progressivo;
        Q040.FieldByName('Data').AsDateTime:=DataCorr;
        Q040.FieldByName('Causale').AsString:=Var_Causale;
        Q040.FieldByName('Note').AsString:=Var_Note;
        Q040.FieldByName('ProgrCausale').AsInteger:=0;
        Q040.FieldByName('TipoGiust').AsString:=TG;
        if Var_RestoHMA > 0 then
          Q040.FieldByName('RESTO_CUMULO_HMA').AsInteger:=Var_RestoHMA;
        if (Var_TipoCaus = 1) and
           ((R180CarattereDef(R600DtM1.Q265.FieldByName('Cumulo_Familiari').AsString,1,'N') in ['S','D']) or
            (R180CarattereDef(R600DtM1.Q265.FieldByName('Fruizione_Familiari').AsString,1,'N') in ['S','D'])) then
          Q040.FieldByName('DataNas').AsDateTime:=R600DtM1.RiferimentoDataNascita.Data;
        if TG = 'M' then
        begin
          try
            Q040.FieldByName('DaOre').AsDateTime:=StrToTime(EdtDa);
          except
          end;
        end;
        if (TG = 'N') or (TG = 'D') then
          Q040.FieldByName('DaOre').AsDateTime:=StrToTime(EdtDa);
        if TG = 'D' then
          Q040.FieldByName('AOre').AsDateTime:=StrToTime(EdtA);

        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
        if TG = 'M' then
          Q040.FieldByName('CSI_TIPO_MG').AsString:=Var_TipoMG;
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

        // decreto brunetta: modifica causale per i primi 10 giorni di assenza
        if (Var_TipoCaus = 1) and
           (DataCorr >= EncodeDate(2008,06,25)) and
           (not R600DtM1.Q265.FieldByName('CODCAU3').IsNull) and
           //(R180In(TG,['I','M']))
           (R600DtM1.CheckScaricoPagheFruiz(R600DtM1.Q265.FieldByName('CODCAU3').AsString,TG,DataCorr) = 'S')
        then
        begin
          with R600DtM1.scrDieciGiorniPrima do
          begin
            SetVariable('PROGRESSIVO',Var_Progressivo);
            SetVariable('DATA',DataCorr);
            SetVariable('GSIGNIFIC',R600DtM1.Q265.FieldByName('GSIGNIFIC').AsString);
            CausPeriodi:=Var_Causale + ',' + R600DtM1.Q265.FieldByName('CODCAU2').AsString;
            CausPeriodi:='''' + StringReplace(CausPeriodi,',',''',''',[rfReplaceAll]) + '''';
            SetVariable('CAUSPERIODI',CausPeriodi);
            Execute;
            if GetVariable('NUMGG') <= 9 then
            begin
              Var_Causale:=R600DtM1.Q265.FieldByName('CODCAU3').AsString;
              Q040.FieldByName('Causale').AsString:=Var_Causale;
            end;
          end;
        end;
        // decreto brunetta.fine
        OperatoreBck:=Parametri.Operatore; //Per gestire l'operatore che chiama dal web service B021
        if (Chiamante = 'B021') and (B021Autorizzatore <> '') then
          Parametri.Operatore:=B021Autorizzatore;
        RegistraLog.SettaProprieta('I','T040_GIUSTIFICATIVI',IfThen(Chiamante <> '',Copy(Chiamante,1,4),Copy(Self.Name,1,4)),Q040,True);
        Parametri.Operatore:=OperatoreBck;
        Q040.Post;
        PostEseguito:=True;
        RegistraLog.RegistraOperazione;

        // solo per assenze
        if Var_TipoCaus = 1 then
        begin
          // decreto brunetta
          if (DataCorr >= EncodeDate(2008,06,25)) and
             (VarToStr(R600DtM1.Q265.Lookup('CODICE',IfThen(DataCorr < DataInizioOrig,CausaleGGNonLav,CausaleOriginale),'CODCAU3')) <> '') then
          begin
            R600DtM1.scrDieciGiorniDopo.SetVariable('PROGRESSIVO',Var_Progressivo);
            R600DtM1.scrDieciGiorniDopo.SetVariable('DATA',DataCorr);
            R600DtM1.scrDieciGiorniDopo.Execute;
          end;
          // periodo di assenza
          if (CausInserita <> '') and (CausInserita <> Q040.FieldByName('Causale').AsString) then
            GeneraPeriodiAssenza('I',CausInserita,DataInizio,DataCorr - 1);
          CausInserita:=Q040.FieldByName('Causale').AsString;
          // visite fiscali: gestione periodi da comunicare
          VisitaFiscale:=R600DtM1.Q265.FieldByName('VISITA_FISCALE').AsString;
          if (VisitaFiscale = 'S') and (TG = 'I') then
            R600DtM1.VisFiscaliAddData(DataCorr);
        end;

        //CCNL 2018: Visite mediche ad ore devono inserire fruizione gg intera di malattia ogni 6 ore
        Chek_CausaleHMAssenza(Var_Progressivo, DataCorr, DATE_MAX, Var_Causale, TG);
        (*
        if (Var_TipoCaus = 1) and R180In(TG,['N','D']) and (R600DtM1.GetValStrT230(Var_Causale,'CAUSALE_HMASSENZA',DataCorr) <> '') then
        begin
          Inserimento_CausaleHMAssenza(Var_Progressivo,DataCorr,DATE_MAX,Var_Causale);
        end;
        *)

        //TORINO_CSI: Per ogni recupero di ecc.settimanali, inserimento contestuale di causale di abbattimento delle eccedenze della settimana
        if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (Var_Causale = TO_CSI_REC_SETT) then
        begin
          InserimentoTO_CSI_ABB_ECCSETT(TO_CSI_ABB_ECCSETT);
        end;

        Inserito:=True;
        if TGSucc <> '' then
        begin
          TG:=TGSucc;
          EdtDa:=EdtDaSucc;
          EdtA:=EdtASucc;
          Giustif.Modo:=TG[1];
          // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
          Giustif.CSITipoMG:=Var_TipoMG;
          // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
          Giustif.DaOre:=EdtDa;
          Giustif.AOre:=EdtA;

          R600DtM1.Giustificativo.Modo:=TG[1];
          // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
          R600DtM1.Giustificativo.CSITipoMG:=Var_TipoMG;
          // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
          R600DtM1.Giustificativo.DaOre:=EdtDa;
          R600DtM1.Giustificativo.AOre:=EdtA;
          TGSucc:='';
          EdtDaSucc:='';
          EdtASucc:='';
          DataCorr:=DataCorr - 1;
        end
        else
        begin
          TG:=TGOriginale;
          EdtDa:=EdtDaOriginale;
          EdtA:=EdtAOriginale;
          Giustif.Modo:=TG[1];
          // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
          Giustif.CSITipoMG:=Var_TipoMG;
          // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
          Giustif.DaOre:=EdtDa;
          Giustif.AOre:=EdtA;

          R600DtM1.Giustificativo.Modo:=TG[1];
          // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
          R600DtM1.Giustificativo.CSITipoMG:=Var_TipoMG;
          // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
          R600DtM1.Giustificativo.DaOre:=EdtDa;
          R600DtM1.Giustificativo.AOre:=EdtA;
        end;
        if Q265.Lookup('CODICE',CausaleOriginale,'ALLARME_FRUIZIONE_CONTINUATIVA') > 0 then
        begin
          S:=R600DtM1.AllarmeFruizioneContinuativa(Var_Progressivo,Q040.FieldByName('Data').AsDateTime,CausaleOriginale,Q265.Lookup('CODICE',CausaleOriginale,'ALLARME_FRUIZIONE_CONTINUATIVA'));
          if S <> '' then
          begin
            if InsNormale then
            begin
              // segnala avviso fruizione continuativa
              R180MessageBox(S,INFORMA);
            end
            else
            begin
              R600DtM1.ListAnomalieNonBloccanti.Add(S);
            end;
          end;
        end;
      end;
      DataCorr:=DataCorr + 1;
      InserisciGGNonSignificativo:=PostEseguito;
    end;
  except
    on EAbort do;
    {$IFNDEF WEBSVC}
    {$IFDEF IRISWEB}
    on E: EThreadElaborazioneException do
    begin
      GGetWebApplicationThreadVar.ShowMessage('Inserimento giustificativi: ' + E.Message);
    end;
    {$ENDIF IRISWEB}
    {$ENDIF WEBSVC}
    on E: Exception do
    begin
      if InsNormale then
      begin
        // visualizza errore inserimento
        R180MessageBox(E.Message,ESCLAMA);
      end;
    end;
  end;

  // commessa: MAN/08 SVILUPPO#56 - riesame del 09.10.2013.ini
  // dopo la fine del ciclo di inserimento aggiunge la lista di anomalie
  // alla lista completa per le elaborazioni massive
  // (anche in caso di errore)
  ListAnomalieCompleta.AddStrings(R600DtM1.ListAnomalie);
  // commessa: MAN/08 SVILUPPO#56 - riesame del 09.10.2013.fine

  R600DtM1.LetturaRiduzioni:=False;

  // visite fiscali: elabora assenze inserite per aggiornamento T047
  if R600DtM1.VisFiscali.NumDate > 0 then
  begin
    // imposta variabili per gestione periodi assenze
    R600DtM1.VisFiscali.Progressivo:=Var_Progressivo;
    R600DtM1.VisFiscali.CodComune:=RecapitoAlternativo.CodComune;
    R600DtM1.VisFiscali.Indirizzo:=RecapitoAlternativo.Indirizzo;
    R600DtM1.VisFiscali.Cap:=RecapitoAlternativo.Cap;
    R600DtM1.VisFiscali.Telefono:=RecapitoAlternativo.Telefono;
    R600DtM1.VisFiscali.MedicinaLegale:=RecapitoAlternativo.MedLegale;
    R600DtM1.VisFiscali.Note:=RecapitoAlternativo.Note;
    R600DtM1.VisFiscali.TipoEsenzione:=RecapitoAlternativo.TipoEsenzione;
    R600DtM1.VisFiscali.DataEsenzione:=RecapitoAlternativo.DataEsenzione;
    R600DtM1.VisFiscali.OperatoreEsenzione:=RecapitoAlternativo.OperatoreEsenzione;

    // inserisce i periodi di assenza per le visite fiscali
    R600DtM1.VisFiscaliInsPeriodi;
  end;
  // visite fiscali.fine

  // gestione progressbar delegata alla form
  {$IFNDEF IRISWEB}
  if GestioneSingolaDM and (Assigned(ProgressBar)) and (not AcquisizioneWebInCorso) then
    ProgressBar.Position:=0;
  {$ENDIF IRISWEB}

  if Inserito then
  begin
    // giustificativo inserito

    // se si tratta di un'assenza genera il relativo record di periodo su T042
    if Var_TipoCaus = 1 then
      GeneraPeriodiAssenza('I',CausInserita,DataInizio,DataFine);

    // anomalie per elaborazioni massive
    if (AcquisizioneWebInCorso) and (not InsNormale) and (Chiamante <> 'A087') and (Chiamante <> 'R250') then
    begin
      // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.ini
      // controlla la lista di anomalie completa
      //if Trim(R600DtM1.ListAnomalie.Text) = '' then
      if ListAnomalieCompleta.Count = 0 then
      // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.fine
        PeriodoInserito
      else
        PeriodoInseritoConAnomalie;
    end;
  end
  else
  begin
    // giustificativo NON inserito
    if chkNuovoPeriodo then //Alberto 09/04/2009: Se è stato inserito il record in T031 e non è stato fatto nessun inserimento, lo si elimina considerando i precedenti parametri
    begin
      scrT031.SetVariable('INSERIMENTO','N');
      scrT031.Execute;
    end;
    if InsNormale then
    begin
      // segnala "nessun giustificativo inserito"
      R180MessageBox(A000TraduzioneStringhe(A000MSG_A004_MSG_NESSUN_GIUST_INSERITO),INFORMA);
    end
    else if (AcquisizioneWebInCorso) and (Chiamante <> 'A087') and (Chiamante <> 'R250') then
    begin
      PeriodoNonInserito('');
    end;
  end;

  if Inserito and (Parametri.ModuloInstallato['TORINO_CSI_PRV']) then
  begin
    T040P_ALLINEA.ClearVariables;
    T040P_ALLINEA.SetVariable('PROGRESSIVO',Var_Progressivo);
    T040P_ALLINEA.SetVariable('DATA',DataInizio);
    T040P_ALLINEA.SetVariable('CAUSALE',Var_Causale);
    T040P_ALLINEA.SetVariable('OPERAZIONE','I');
    try
      T040P_ALLINEA.Execute;
    except
      // segnala allineamento fallito in seguito a problemi sulla procedura Oracle
      R180MessageBox(A000TraduzioneStringhe(A000MSG_A004_MSG_ALLINEAMENTO_FALLITO),INFORMA);
    end;
  end;

  // commit
  if EseguiCommit then
  begin
    SessioneOracleA004.Commit;
  end;

  // controllo competenze giustificativi assenza futuri
  if (Inserito) and (Var_TipoCaus = 1) and
     (Parametri.CampiRiferimento.C23_ContrCompetenze = 'S') then
  begin
    Giustif.Causale:=Var_Causale;
    n:=R600DtM1.ContaGiustifAssFuturi(Var_Progressivo,DataFine,Giustif,Var_Familiari);
    // riallineamento causali concatenate anche in fase di acquisizione
    // delle richieste web (sia da iriswin che da irisweb)
    if n > 0 then
    begin
      Msg:=Format(A000TraduzioneStringhe(A000MSG_A004_DLG_FMT_RIALLINEA),[n]);
      // riallineamento in questi due casi:
      // a. InsNormale = True  -> inserimento normale + conferma con messagebox
      // b. InsNormale = False -> inserimento da acquisizione dei giustificativi richiesti via iter autorizzativo web
      Esegui:=(not InsNormale) or (R180MessageBox(Msg,DOMANDA) = mrYes);
      if Esegui then
        R600DtM1.GestioneGiustifAssFuturi(Var_Progressivo,DataFine,Giustif,Var_Familiari{$IFNDEF IRISWEB},ProgressBar{$ENDIF IRISWEB});
    end;
    R600DtM1.ChiudiGiustifAssFuturi;
  end;

  // aggiornamento dataset
  Q040B.EnableControls;
  Q040.Close;
  Q040.Open;
end;

procedure TA004FGiustifAssPresMW.CoperturaGiorniNonLavorativi(var RDataInizio: TDateTime; var RCausale: String);
// determina la data di inizio e la causale per la copertura dei giorni non lavorativi
begin
  scrCopriGGNonLav.ClearVariables;
  scrCopriGGNonLav.SetVariable('PROGRESSIVO',Var_Progressivo);
  scrCopriGGNonLav.SetVariable('DATA',DataInizio);
  scrCopriGGNonLav.SetVariable('CAUSNEW',Var_Causale);
  scrCopriGGNonLav.SetVariable('CAUSALI',Var_Causale + ',' + VarToStr(Q265.Lookup('CODICE',Var_Causale,'CODCAU1')) + ',' + VarToStr(Q265.Lookup('CODICE',Var_Causale,'CODCAU2')));
  try
    scrCopriGGNonLav.Execute;
    RDataInizio:=scrCopriGGNonLav.GetVariable('DATA');
    RCausale:=VarToStr(scrCopriGGNonLav.GetVariable('CAUSNEW'));
  except
    // data e causale rimangono le stesse di prima
    RDataInizio:=DataInizio;
    RCausale:=Var_Causale;
  end;
end;

procedure TA004FGiustifAssPresMW.Inserimento_CausaleHMAssenza(Progressivo:Integer; Data1,Data2:TDateTime; Causale:String);
var GiustifHMA:  TGiustificativo;
    GiustifVMH: TGiustificativo;
    CausaleHMAssenza:String;
    R600HMA:TR600DtM1;
    InizioCumuloHMA,FineCumuloHMA:TDateTime;
    i,RestoHMA,bckVar_TipoGiust:Integer;
begin
  //ReggioEmilia_Comune: la gestione è limitata all'ano solare
  Data2:=Min(Data2,Encodedate(R180Anno(Data1),12,31));

  //(*
  GiustifHMA.Causale:=R600DtM1.GetValStrT230(Causale,'CAUSALE_HMASSENZA',Data1);
  GiustifHMA.Inserimento:=True;
  GiustifHMA.Modo:='I';
  GiustifHMA.DataGiust:=Data1;
  //*)
  CausaleHMAssenza:=R600DtM1.GetValStrT230(Causale,'CAUSALE_HMASSENZA',Data1);

  GiustifVMH.Causale:=Causale;
  GiustifVMH.Inserimento:=True;
  GiustifVMH.Modo:='I';
  GiustifVMH.DataGiust:=Data1;

  if CausaleHMAssenza = '' then
    exit;

  (*
  //Alberto 11/07/2018 - CCNL 2018: eliminazione giustificativi automatico inseriti tramite CAUSALE_HMASSENZA da questa Data in poi (vengono reinseriti qui)
  R600DtM1.scrDelT040GGAuto.SetVariable('CAUSALE',CausaleHMAssenza);
  R600DtM1.scrDelT040GGAuto.SetVariable('PROGRESSIVO',Progressivo);
  R600DtM1.scrDelT040GGAuto.SetVariable('DAL',Data1);
  R600DtM1.scrDelT040GGAuto.SetVariable('AL',Data2);
  R600DtM1.scrDelT040GGAuto.Execute;
  *)

  R600DtM1.selT040GGAuto.ClearVariables;
  R600DtM1.selT040GGAuto.SetVariable('CAUSALE',CausaleHMAssenza);
  R600DtM1.selT040GGAuto.SetVariable('PROGRESSIVO',Progressivo);
  R600DtM1.selT040GGAuto.SetVariable('DAL',Data1);
  R600DtM1.selT040GGAuto.SetVariable('AL',Data2);

  bckVar_TipoGiust:=Var_TipoGiust;
  try
    R600DtM1.selT040GGAuto.Open;

    //Alberto 11/07/2018 - CCNL 2018: eliminazione giustificativi automatico inseriti tramite CAUSALE_HMASSENZA da questa Data in poi (vengono reinseriti qui)
    R600DtM1.scrDelT040GGAuto.SetVariable('CAUSALE',CausaleHMAssenza);
    R600DtM1.scrDelT040GGAuto.SetVariable('PROGRESSIVO',Progressivo);
    R600DtM1.scrDelT040GGAuto.SetVariable('DAL',Data1);
    R600DtM1.scrDelT040GGAuto.SetVariable('AL',Data2);
    R600DtM1.scrDelT040GGAuto.Execute;

    Var_TipoGiust:=0;
    while not R600DtM1.selT040GGAuto.EOF do
    begin
      Cancellazione_CausaleHMAssenza.Causale:=R600DtM1.selT040GGAuto.FieldByName('CAUSALE').AsString;
      Cancellazione_CausaleHMAssenza.Data:=R600DtM1.selT040GGAuto.FieldByName('DATA').AsDateTime;
      GeneraPeriodiAssenza('C',
                           R600DtM1.selT040GGAuto.FieldByName('CAUSALE').AsString,
                           Trunc(R600DtM1.selT040GGAuto.FieldByName('DATA').AsDateTime),
                           Trunc(R600DtM1.selT040GGAuto.FieldByName('DATA').AsDateTime));
      R600DtM1.selT040GGAuto.Next;
    end;
  finally
    Var_TipoGiust:=bckVar_TipoGiust;
    R600DtM1.selT040GGAuto.Close;
  end;

  R600HMA:=TR600DtM1.Create(SessioneOracleA004);
  try
    R600HMA.LetturaAssenze:=True;
    //Esclude le richieste web che non devono entrare in questo conteggio
    R600HMA.RichiesteIterAutorizzativo:=False;
    if Parametri.CampiRiferimento.C23_VMHCumuloTriennio = 'S' then
    begin
      //trovo periodo di cumulo per CausaleHMAssenza (ultimo triennio malattia)
      if not R600HMA.SettaPeriodoCumulo(Progressivo,Data1,GiustifHMA) then
        exit;
    end
    else
    begin
      //trovo periodo di cumulo per Causale (VMH: anno solare)
      if not R600HMA.SettaPeriodoCumulo(Progressivo,Data1,GiustifVMH) then
        exit;
    end;
    if not R180Between(Data1,R600HMA.ptInizioCumulo,R600HMA.ptFineCumulo) then
      exit;
    InizioCumuloHMA:=R600HMA.ptInizioCumulo;
    FineCumuloHMA:=Data2; //Vado sempre avanti fino alla fine
    RestoHMA:=0;
    //cerco ultima gg intera CAUSALE_HMASSENZA precedente a ptFineCumulo, e leggo il resto orario da cui partire
    R600DtM1.scrT040UltimoGGAuto.SetVariable('CAUSALE',CausaleHMAssenza);
    R600DtM1.scrT040UltimoGGAuto.SetVariable('PROGRESSIVO',Progressivo);
    R600DtM1.scrT040UltimoGGAuto.SetVariable('DAL',InizioCumuloHMA);
    R600DtM1.scrT040UltimoGGAuto.SetVariable('AL',Data1);
    R600DtM1.scrT040UltimoGGAuto.Execute;
    if R600DtM1.scrT040UltimoGGAuto.GetVariable('DATA') <> null then
    begin
      InizioCumuloHMA:=R600DtM1.scrT040UltimoGGAuto.GetVariable('DATA') + 1;
      RestoHMA:=R600DtM1.scrT040UltimoGGAuto.GetVariable('RESTO_CUMULO_HMA');
    end;

    //cumulo fruizioni orarie fatte con Causale nel periodo InizioCumuloHMA..FineCumuloHMA, calcolando le gg intere da inserire successivamente
    R600HMA.CumuloAssenzeHMA(Causale,InizioCumuloHMA,FineCumuloHMA,RestoHMA);
    SetLength(lstFruizGiornaliereHMA,Length(R600HMA.lstFruizGiornaliereHMA));
    for i:=0 to High(R600HMA.lstFruizGiornaliereHMA) do
    begin
      lstFruizGiornaliereHMA[i]:=R600HMA.lstFruizGiornaliereHMA[i];
      lstFruizGiornaliereHMA[i].Causale:=CausaleHMAssenza; //E' sempre uguale per tutti gli elementi, ma serve renderla disponibile per la fase successiv di inserimento
    end;
  finally
    FreeAndNil(R600HMA);
  end;
end;

procedure TA004FGiustifAssPresMW.InserimentoTO_CSI_ABB_ECCSETT(Causale:String);
{Per il record appena inserito sulla T040, si deve inserire una quantità corrispondente
nei giorni della settimana in cui c'è eccedenza, usando la causale passata come parametro.
Importante: valorizzare anche ID_RICHIESTA per gestire eventuale cancellazione successiva}
var Abbattimento,App,App1,App2,DaOre,AOre:Integer;
    D,Dal,Al:TDateTime;
    R502DtM:TR502ProDtM1;
begin
  Abbattimento:=0;
  if Q040.FieldByName('TIPOGIUST').AsString = 'N' then
    Abbattimento:=R180OreMinuti(Q040.FieldByName('DAORE').AsDateTime)
  else if Q040.FieldByName('TIPOGIUST').AsString = 'D' then
    Abbattimento:=R180OreMinuti(Q040.FieldByName('AORE').AsDateTime) - R180OreMinuti(Q040.FieldByName('DAORE').AsDateTime);
  if Abbattimento = 0 then
    exit;
  D:=Q040.FieldByName('DATA').AsDateTime;
  Dal:=D - DayOfWeek(D - 1) + 1;//Lunedì a partire dal 01/01/2015
  Dal:=Max(Dal,EncodeDate(2015,1,1));
  Al:=D - DayOfWeek(D - 1) + 7;//Domenica
  D:=Dal;
  R502DtM:=TR502ProDtM1.Create(Owner,True);
  try
    R502DtM.Chiamante:='Cartolina';
    R502DtM.ConsideraRichiesteWeb:=True;
    R502DtM.PeriodoConteggi(Dal,Al);
  while (D <= Al) and (Abbattimento > 0) do
  begin
    R502DtM.Conteggi('Cartolina',Q040.FieldByName('PROGRESSIVO').AsInteger,D);
    //Scostamento positivo
    App1:=R502DtM.scost -
         R502DtM.RiepAssenza[TO_CSI_REC_BANCAORE,'HHRESE'] -
         R502DtM.RiepAssenza[TO_CSI_REC_SETT,'HHRESE'];
    //Spezzoni di ore normali (solo se non ci sono mezze giornate di assenza)
    if R502DtM.n_giusmga > 0 then
      App2:=0
    else
      App2:=R502DtM.RiepPresTotali[False] - R502DtM.RiepAssenza[TO_CSI_ABB_ECCSETT,'HHVAL'];
    App:=max(0,max(App1,App2));
    App:=min(App,Abbattimento);
    dec(Abbattimento,App);
    DaOre:=App;
    //AOre:=16*60 + 40;
    if App > 0 then
      with insT040Extra do
      begin
        SetVariable('PROGRESSIVO',Q040.FieldByName('PROGRESSIVO').AsInteger);
        SetVariable('DATA',D);
        SetVariable('CAUSALE',Causale);
        SetVariable('TIPOGIUST','N');
        SetVariable('DAORE',DaOre);
        SetVariable('AORE',null);
        SetVariable('ID_RICHIESTA',Q040.FieldByName('ID_RICHIESTA').AsLargeInt);
        Execute;
      end;
    D:=D + 1;
  end;
  finally
    FreeAndNil(R502DtM);
  end;
end;

procedure TA004FGiustifAssPresMW.CancellaGiustif(CancNormale:Boolean; ScriviLog:Boolean = True);
// Cancella i giustificativi nel periodo assegnato
var DataCorr:TDateTime;
    TG:Char;
    Trovato,Cancellato,DatoBloccato,DatiBloccatiPeriodo,InizioCatena:Boolean;
    VisitaFiscale,Caus10GGDopo,Errore,CausInizio,
    Catena,CausCorrente,CausCancellata,Msg:String;
    i:Integer;
    n:Integer;
    LstCatena: TStringList;
begin
  ErroreCancellazione:='';
  DatoBloccatoCancellazione:=False;
  Cancellato:=False;
  CausCancellata:='';
  Var_RestoHMA:=0;
  SetLength(lstFruizGiornaliereHMA,0);

  if not CancNormale then
  begin
    R600DtM1.ListAnomalie.Clear;
    R600DtM1.ListAnomalieNonBloccanti.Clear;
  end;
  Caus10GGDopo:='';
  Errore:='';
  //Alberto 04/01/2011: resetto il riferimento ai familiari se non ci sono le condizioni.
  //Controllo utile per ricalcolo causali concatenate successivamente.
  if not((Var_TipoCaus = 1) and
         ((R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D']) or
          (R180CarattereDef(Q265.FieldByName('FRUIZIONE_FAMILIARI').AsString,1,'N') in ['S','D']))) then
    Var_Familiari:='';
  Q040B.DisableControls;
  Q040.CommitOnPost:=EseguiCommit;
  try
    //Imposto il range sul progressivo del dipendente
    DataCorr:=DataFine;
    TG:=#0;
    Trovato:=False;
    case Var_TipoGiust of
      0:if Var_TipoGiust_Count = 4 then
          TG:='I'
        else
          TG:='N';
      1:if Var_TipoGiust_Count = 4 then
          TG:='M'
        else
          TG:='D';
      2:TG:='N';
      3:TG:='D';
    end;

    // determina se la causale selezionata è in testa ad una catena di causali
    // in questo caso la cancellazione avverrà per tutte le causali facenti parte della catena
    InizioCatena:=R600DtM1.IsInizioCatenaCausAss(Var_Causale,CausInizio);
    Catena:='';
    if InizioCatena then
    begin
      R600DtM1.GetCatenaCausAss(Var_Causale,Catena);
      //Alberto 11/07/2018: Se giustificativo assenza ad ore aggiungo alla catena da cancellare la causale indicata in CAUSALE_FRUIZORE
      if (Var_TipoGiust_Count = 4) and R180In(TG,['N','D']) then
        Catena:=Catena + ',' + R600DtM1.GetValStrT230(Var_Causale,'CAUSALE_FRUIZORE',DataFine);
    end;

    // dimensiona l'array per la gestione delle visite fiscali
    // viene volutamente dimensionato con un elemento in più
    // (in modo da ottenere un range di tipo [1..Numero_Giorni])
    R600DtM1.VisFiscaliSetArray(Trunc(DataFine - DataInizio) + 2);

    //Ciclo sui giorni richiesti
    DatiBloccatiPeriodo:=False;
    while DataCorr >= DataInizio  do
    begin
      // cerca giustificativo per causale selezionata
      case TG of
        'I': Trovato:=Q040.Locate('Data;Causale;TipoGiust',VarArrayOf([DataCorr,Var_Causale,TG]),[]);
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
        //'M': Trovato:=Q040.Locate('Data;Causale;TipoGiust',VarArrayOf([DataCorr,Var_Causale,TG]),[]);
        'M': Trovato:=Q040.Locate('Data;Causale;TipoGiust;CSI_TIPO_MG',VarArrayOf([DataCorr,Var_Causale,TG,Var_TipoMG]),[]);
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
        'N': Trovato:=Q040.Locate('Data;Causale;TipoGiust;DaOre',VarArrayOf([DataCorr,Var_Causale,TG,StrToTime(Var_DaOre)]),[]);
        'D': Trovato:=Q040.Locate('Data;Causale;TipoGiust;DaOre;AOre',VarArrayOf([DataCorr,Var_Causale,TG,StrToTime(Var_DaOre),StrToTime(Var_AOre)]),[]);
      end;

      // cerca giustificativo con causale ridotta (decreto brunetta)
      if not Trovato then
      begin
        Caus10GGDopo:=VarToStr(R600DtM1.Q265.Lookup('CODICE',Var_Causale,'CODCAU3'));
        if Caus10GGDopo <> '' then
        begin
          case TG of
            'I': Trovato:=Q040.Locate('Data;Causale;TipoGiust',VarArrayOf([DataCorr,Caus10GGDopo,TG]),[]);
            // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
            'M': Trovato:=Q040.Locate('Data;Causale;TipoGiust;CSI_TIPO_MG',VarArrayOf([DataCorr,Caus10GGDopo,TG,Var_TipoMG]),[]);
            // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
            'N': Trovato:=Q040.Locate('Data;Causale;TipoGiust;DaOre',VarArrayOf([DataCorr,Caus10GGDopo,TG,StrToTime(Var_DaOre)]),[]);
            'D': Trovato:=Q040.Locate('Data;Causale;TipoGiust;DaOre;AOre',VarArrayOf([DataCorr,Caus10GGDopo,TG,StrToTime(Var_DaOre),StrToTime(Var_AOre)]),[]);
          end;
        end;
      end;

      // cancellazione giustificativi a catena.ini - TORINO_ASLTO2 - 2013/044 - INT_TECN 4
      if (not Trovato) and InizioCatena then
      begin
        LstCatena:=TStringList.Create;
        try
          LstCatena.CommaText:=Catena;
          for i:=0 to LstCatena.Count - 1 do
          begin
            // esclude dalla ricerca la causale stessa e l'eventuale causale ridotta
            // poiché già considerate in precedenza
            if (LstCatena[i] <> Var_Causale) and (LstCatena[i] <> Caus10GGDopo) then
            begin
              case TG of
                'I': Trovato:=Q040.Locate('Data;Causale;TipoGiust',VarArrayOf([DataCorr,LstCatena[i],TG]),[]);
                // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
                'M': Trovato:=Q040.Locate('Data;Causale;TipoGiust;CSI_TIPO_MG',VarArrayOf([DataCorr,LstCatena[i],TG,Var_TipoMG]),[]);
                // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
                'N': Trovato:=Q040.Locate('Data;Causale;TipoGiust;DaOre',VarArrayOf([DataCorr,LstCatena[i],TG,StrToTime(Var_DaOre)]),[]);
                'D': Trovato:=Q040.Locate('Data;Causale;TipoGiust;DaOre;AOre',VarArrayOf([DataCorr,LstCatena[i],TG,StrToTime(Var_DaOre),StrToTime(Var_AOre)]),[]);
              end;
              if Trovato then
                Break;
            end;
          end;
        finally
          FreeAndNil(LstCatena);
        end;
      end;
      // cancellazione giustificativi a catena.fine

      // verifica familiare di riferimento
      if Trovato and (Var_Familiari <> '') and (Var_TipoCaus = 1) and
         ((R180CarattereDef(Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D']) or
          (R180CarattereDef(Q265.FieldByName('FRUIZIONE_FAMILIARI').AsString,1,'N') in ['S','D'])) then
      begin
        Trovato:=Q040.FieldByName('DATANAS').AsDateTime = StrToDateTime(Var_Familiari);
      end;
      //Cancellazione riposo per Firlab
      if (not Trovato) and
         (Parametri.CampiRiferimento.C30_WebSrv_A004_URL <> '') and
         (Parametri.CampiRiferimento.C30_WebSrv_A004_Dati <> '') then
      begin
        Trovato:=Q040.Locate('Data;Causale;TipoGiust',VarArrayOf([DataCorr,FIRLAB_RIPOSO,'I']),[]);
      end;
      // errore se non trovato
      if (not Trovato) and (not CancNormale) then
        Errore:='Giustificativo da cancellare non trovato.';
      // controllo blocco riepiloghi
      DatoBloccato:=selDatiBloccati.DatoBloccato(Var_Progressivo,SelDatiBloccati.MeseBloccoRiepiloghi(DataCorr),'T040');
      if Trovato and (not DatoBloccato) then
      begin
        try
          // COMO_HSANNA - chiamata 76459.ini
          // salva la causale corrente prima della cancellazione del record
          CausCorrente:=Q040.FieldByName('CAUSALE').AsString;
          // COMO_HSANNA - chiamata 76459.fine
          //TORINO_CSI per causale 1110 (recup.ecc.settimanale) cancello anche causale 9104
          if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (CausCorrente = TO_CSI_REC_SETT) then
          begin
            delT040IdRichiesta.SetVariable('PROGRESSIVO',Var_Progressivo);
            delT040IdRichiesta.SetVariable('ID_RICHIESTA',Q040.FieldByName('ID_RICHIESTA').AsLargeInt);
            delT040IdRichiesta.SetVariable('CAUSALE',TO_CSI_ABB_ECCSETT);
            delT040IdRichiesta.Execute;
          end;
          Q040.Delete;
          if Var_TipoCaus = 1 then
          begin
            // decreto brunetta
            R600DtM1.scrDieciGiorniDopo.SetVariable('PROGRESSIVO',Var_Progressivo);
            R600DtM1.scrDieciGiorniDopo.SetVariable('DATA',DataCorr);
            R600DtM1.scrDieciGiorniDopo.Execute;
            // decreto brunetta.fine

            // visite fiscali: gestione periodi da comunicare
            VisitaFiscale:=VarToStr(R600DtM1.Q265.Lookup('CODICE',Var_Causale,'VISITA_FISCALE'));
            if (VisitaFiscale = 'S') and (TG = 'I') then
              R600DtM1.VisFiscaliAddData(DataCorr);
            // visite fiscali.fine

            // COMO_HSANNA - chiamata 76459.ini
            // periodo di assenza
            if (CausCancellata <> '') and (CausCancellata <> CausCorrente) then
              GeneraPeriodiAssenza('C',CausCancellata,DataCorr + 1,DataFine);
            CausCancellata:=CausCorrente;
            // COMO_HSANNA - chiamata 76459.fine

            //CCNL 2018: Visite mediche ad ore devono inserire fruizione gg intera di malattia ogni 6 ore
            Chek_CausaleHMAssenza(Var_Progressivo, DataCorr, DATE_MAX, CausCorrente, TG);
            (*
            if (Var_TipoCaus = 1) and R180In(TG,['N','D']) and (R600DtM1.GetValStrT230(CausCorrente,'CAUSALE_HMASSENZA',DataCorr) <> '') then
            begin
              Inserimento_CausaleHMAssenza(Var_Progressivo,DataCorr,DATE_MAX,CausCorrente);
            end;
            *)
          end;
          Cancellato:=True;
        except
          on E:Exception do
            Errore:=E.Message;
        end;
      end
      else if DatoBloccato then
      begin
        // indica che nel periodo sono stati trovati riepiloghi bloccati
        DatiBloccatiPeriodo:=True;
      end;
      DataCorr:=DataCorr - 1;
    end;

    //Alberto 11/07/2018 - CCNL 2018:Inserimento giustificativi giornalieri automatici corrispondenti al cumulo delle fruizioni orarie (Visite mediche)
    _InserisciGiustifHMA(CancNormale);

    // visite fiscali.ini
    // elaborazione dei giorni di assenza cancellati
    if R600DtM1.VisFiscali.NumDate > 0 then
    begin
      // imposta variabili per gestione periodi assenze
      R600DtM1.VisFiscali.Progressivo:=Var_Progressivo;
      R600DtM1.VisFiscali.CodComune:=RecapitoAlternativo.CodComune;
      R600DtM1.VisFiscali.Indirizzo:=RecapitoAlternativo.Indirizzo;
      R600DtM1.VisFiscali.Cap:=RecapitoAlternativo.Cap;
      R600DtM1.VisFiscali.Telefono:=RecapitoAlternativo.Telefono;
      R600DtM1.VisFiscali.MedicinaLegale:=RecapitoAlternativo.MedLegale;
      R600DtM1.VisFiscali.Note:=RecapitoAlternativo.Note;
      R600DtM1.VisFiscali.TipoEsenzione:=RecapitoAlternativo.TipoEsenzione;
      R600DtM1.VisFiscali.DataEsenzione:=RecapitoAlternativo.DataEsenzione;
      R600DtM1.VisFiscali.OperatoreEsenzione:=RecapitoAlternativo.OperatoreEsenzione;

      // gestione cancellazione periodi di assenza
      R600DtM1.VisFiscaliCanPeriodi;
    end;
    // visite fiscali.fine

    if Cancellato then
    begin
      OperatoreBck:=Parametri.Operatore;//Per gestire l'operatore che chiama dal web service B021
      if (Chiamante = 'B021') and (B021Autorizzatore <> '') then
        Parametri.Operatore:=B021Autorizzatore;
      RegistraLog.SettaProprieta('C','T040_GIUSTIFICATIVI',IfThen(Chiamante <> '',Copy(Chiamante,1,4),Copy(Self.Name,1,4)),nil,True);
      Parametri.Operatore:=OperatoreBck;
      RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(Var_Progressivo),'');
      RegistraLog.InserisciDato('CAUSALE',Var_Causale,'');
      RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]),'');
      RegistraLog.InserisciDato('MODO',Format('%s %s %s',[TG,Var_DaOre,Var_AOre]),'');
      RegistraLog.RegistraOperazione;
      if Var_TipoCaus = 1 then
      begin
        // cancella periodo con CausCancellata
        GeneraPeriodiAssenza('C',CausCancellata,DataInizio,DataFine);

        // cancellazione giustificativo da caricamento assenze
        if (AcquisizioneWebInCorso) and (not CancNormale) and (ScriviLog) then
          PeriodoCancellato;

        //Alberto 09/04/2009: se chkNuovoPeriodo abilitato (caus. assenza a giornate con TipoCumulo = O) elimino eventuale indicatore dell'inizio periodo
        if chkNuovoPeriodo then
        begin
          scrT031.SetVariable('PROGRESSIVO',Var_Progressivo);
          scrT031.SetVariable('DATA1',DataInizio);
          scrT031.SetVariable('DATA2',DataFine);
          scrT031.SetVariable('INSERIMENTO','N');
          scrT031.Execute;
        end;
      end;
    end
    else
    begin
      // errore durante cancellazione giustificativo
      if (Errore <> '') and (AcquisizioneWebInCorso) and (Chiamante <> 'A087') and (Chiamante <> 'R250') then
      begin
        if CancNormale then
          raise Exception.Create(Errore)
        else
        begin
          // 05.09.2012.ini
          // anomalie eventualmente segnalate in A004FCaricaAssRich (dove è presente il ciclo di CancellaGiustif)
          //A004FCaricaAssRich.PeriodoNonCancellato(Errore);
          ErroreCancellazione:=Errore;
          // 05.09.2012.fine
        end;
      end
      // 05.09.2012.ini
      // segnalazione presenza di uno o più giorni con dati bloccati
      else if DatiBloccatiPeriodo and not CancNormale then
      begin
        DatoBloccatoCancellazione:=True;
      end;
      // 05.09.2012.fine
    end;
  except
  end;

  if Cancellato and (Parametri.ModuloInstallato['TORINO_CSI_PRV']) then
  begin
    T040P_ALLINEA.ClearVariables;
    T040P_ALLINEA.SetVariable('PROGRESSIVO',Var_Progressivo);
    T040P_ALLINEA.SetVariable('DATA',DataInizio);
    T040P_ALLINEA.SetVariable('CAUSALE',Var_Causale);
    T040P_ALLINEA.SetVariable('OPERAZIONE','C');
    try
      T040P_ALLINEA.Execute;
    except
      // segnala allineamento fallito in seguito a problemi sulla procedura Oracle
      on E:Exception do
        R180MessageBox(A000TraduzioneStringhe(A000MSG_A004_MSG_ALLINEAMENTO_FALLITO) + E.Message,INFORMA);
    end;
  end;

  if EseguiCommit then
    SessioneOracleA004.Commit;

  // controllo competenze giustificativi assenza futuri
  if (Var_TipoCaus = 1) and (Parametri.CampiRiferimento.C23_ContrCompetenze = 'S') and
     Cancellato and CancNormale and ScriviLog then
  begin
    Giustif.Causale:=Var_Causale;
    n:=R600DtM1.ContaGiustifAssFuturi(Var_Progressivo,DataFine,Giustif,Var_Familiari);
    if n > 0 then
    begin
      Msg:=Format(A000TraduzioneStringhe(A000MSG_A004_DLG_FMT_RIALLINEA),[n]);
      if R180MessageBox(Msg,DOMANDA) = mrYes then
        R600DtM1.GestioneGiustifAssFuturi(Var_Progressivo,DataFine,Giustif,Var_Familiari{$IFNDEF IRISWEB},ProgressBar{$ENDIF IRISWEB});
    end;
    R600DtM1.ChiudiGiustifAssFuturi;
  end;

  if Chiamante <> 'A087' then
  begin
    Q040.Close;
    Q040.Open;
  end;
  Q040B.EnableControls;
end;

procedure TA004FGiustifAssPresMW.GeneraPeriodiAssenza(const POperazione,PCausale:String; const PDataInizio,PDataFine:TDateTime);
begin
  if Var_TipoCaus = 0 then
    exit;

  with R600DtM1.PeriodiAssenza do
  begin
    SetVariable('PROG',Var_Progressivo);
    SetVariable('CAUS',PCausale);
    // COMO_HSANNA - chiamata 76459.ini
    // passaggio parametri inizio e fine per gestione correzione periodi assenza in cancellazione
    //SetVariable('INIZIO',DataInizio);
    SetVariable('INIZIO',PDataInizio);
    // COMO_HSANNA - chiamata 76459.fine
    SetVariable('FINE',PDataFine);
    SetVariable('OPER',POperazione);
    case Var_TipoGiust of
      0:begin
        SetVariable('TG','I');
        SetVariable('DALLE','');
        SetVariable('ALLE','');
        end;
      1:begin
        SetVariable('TG','M');
        SetVariable('DALLE','');
        SetVariable('ALLE','');
        end;
      2:begin
        SetVariable('TG','N');
        SetVariable('DALLE',Var_DaOre);
        SetVariable('ALLE','');
        end;
      3:begin
        SetVariable('TG','D');
        SetVariable('DALLE',Var_DaOre);
        SetVariable('ALLE',Var_AOre);
        end;
    end;
    try
      Execute;
      if EseguiCommit then
        SessioneOracleA004.Commit;
    except
    end;
  end;
end;
// ############# GESTIONE GIUSTIFICATIVI.fine ############ //


// ######### GESTIONE GIUST. CONIUGI ESTERNI.ini ######### //
procedure TA004FGiustifAssPresMW.InserisciGiustFamiliari;
// Inserisce i giustificativi dei familiari nel periodo assegnato
var
  DataCorr:TDateTime;
  LErrore: String;
begin
  selT046.DisableControls;
  try
    insT046.ClearVariables;
    insT046.SetVariable('PROGRESSIVO',Var_Progressivo);
    insT046.SetVariable('CAUSALE',Var_Causale);
    if Var_Familiari <> '' then
      insT046.SetVariable('DATANAS',Var_Familiari);
    case Var_TipoGiust of
      0:insT046.SetVariable('TIPOGIUST','I');
      1:insT046.SetVariable('TIPOGIUST','M');
      2:begin
          insT046.SetVariable('TIPOGIUST','N');
          insT046.SetVariable('DAORE',Var_DaOre);
        end;
      3:begin
          insT046.SetVariable('TIPOGIUST','D');
          insT046.SetVariable('DAORE',Var_DaOre);
          insT046.SetVariable('AORE',Var_AOre);
        end;
    end;
    DataCorr:=DataInizio;
    while DataCorr <= DataFine do
    begin
      insT046.SetVariable('DATA',DataCorr);
      try
        insT046.Execute;
      except
        // CSI - evolutive.ini
        on E: Exception do
        begin
          LErrore:=E.Message;
          if LErrore.ToUpper.StartsWith('ORA-00001') then
            LErrore:='Giustificativo già presente!';
          R180MessageBox(Format('Errore durante l''inserimento del giustificativo!'#13#10'Data: %s'#13#10'%s',[DateToStr(DataCorr),LErrore]),ESCLAMA);
        end;
        // CSI - evolutive.fine
      end;
      DataCorr:=DataCorr + 1;
    end;
    RegistraLog.SettaProprieta('I','T046_GIUSTIFICATIVIFAMILIARI',IfThen(Chiamante <> '',Copy(Chiamante,1,4),Copy(Self.Name,1,4)),nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(Var_Progressivo),'');
    RegistraLog.InserisciDato('CAUSALE',Var_Causale,'');
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]),'');
    RegistraLog.RegistraOperazione;
  except
  end;
  SessioneOracleA004.Commit;
  selT046.Close;
  selT046.Open;
  selT046.EnableControls;
end;

procedure TA004FGiustifAssPresMW.CancellaGiustFamiliari;
// Cancella i giustificativi dei familiari nel periodo assegnato
begin
  selT046.DisableControls;
  try
    delT046.SetVariable('PROGRESSIVO',Var_Progressivo);
    delT046.SetVariable('CAUSALE',Var_Causale);
    delT046.SetVariable('DATA1',DataInizio);
    delT046.SetVariable('DATA2',DataFine);
    delT046.Execute;
    RegistraLog.SettaProprieta('C','T046_GIUSTIFICATIVIFAMILIARI',IfThen(Chiamante <> '',Copy(Chiamante,1,4),Copy(Self.Name,1,4)),nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(Var_Progressivo),'');
    RegistraLog.InserisciDato('CAUSALE',Var_Causale,'');
    RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]),'');
    RegistraLog.RegistraOperazione;
  except
  end;
  SessioneOracleA004.Commit;
  selT046.Close;
  selT046.Open;
  selT046.EnableControls;
end;
// ######### GESTIONE GIUST. CONIUGI ESTERNI.fine ######## //


// ############ IMPORTAZIONE ASSENZE WEB.ini  ############ //

function TA004FGiustifAssPresMW.AcquisizioneRichiesteWeb(const PSingola, PInterattiva: Boolean;
  var ErrMsg: String; var Scartate: Integer; PNuoveRichieste: Boolean = True): Boolean;
// Questa procedura effettua l'acquisizione su cartellino delle richieste di timbrature autorizzate da web
// Parametri:
//   PSingola
//     True:  acquisizione di una richiesta singola
//     False: acquisizione di tutte le richieste
//   PInterattiva
//     True:  per ogni richiesta per cui si verificano anomalie non bloccanti
//            viene mostrata una finestra di dialogo in cui l'operatore sceglie come comportarsi
//     False: eventuali anomalie non bloccanti durante l'acquisizione comportano
//            il fallimento dell'acquisizione della richiesta (elaborazione con errori)
//   ErrMsg
//     restituisce un eventuale messaggio di errore generato durante l'elaborazione
//   Scartate
//     restituisce il numero di richieste non considerate perché già considerate
//     nel frattempo da elaborazioni contemporanee
//   PNuoveRichieste
//     True:  indica se l'elaborazione deve considerare le richieste da elaborare
//     False: indica se l'elaborazione deve considerare le richieste elaborate con errori
var
  ListRevocate: TStringList;
  RichCollegata, OldIdSingolo: Integer;
  TipoRich, Msg: String;
  procedure ResumeNext(const PMsg: String);
  begin
    if selT050Upd.State = dsEdit then
      selT050Upd.Cancel;

    // gestione eccezione
    if PSingola then
    begin
      R180MessageBox(PMsg,ESCLAMA);
      Abort;
    end
    else
    begin
      Scartate:=Scartate + 1;
      if Pos(PMsg,ErrMsg) = 0 then
        ErrMsg:=ErrMsg + CRLF + PMsg;
      selT050.Next;
    end;
  end;
begin
  AcquisizioneWebInCorso:=True;

  // datamodulo di supporto per lettura note richiesta
  C018DM:=TC018FIterAutDM.Create(nil);
  C018DM.Iter:=ITER_GIUSTIF;

  //Alberto 26/09/2017: se registraMsg già iniziato dall'acquisizioen giustificativi, non lo resetto
  if not R180In(VarToStr(RegistraMsg.GetVariable('MASCHERA')),['B015','A103','WA103']) then
    RegistraMsg.IniziaMessaggio(Chiamante);

  if PSingola then
  begin
    // importazione richiesta singola
    OldIdSingolo:=selT050.FieldByName('ID').AsInteger;
  end
  else
  begin
    OldIdSingolo:=-1;
  end;

  {$IFNDEF IRISWEB}
  if Assigned(ProgressBar) then
    ProgressBar.Position:=0;
  {$ENDIF IRISWEB}

  ErrMsg:='';
  RichCollegata:=0;
  Result:=True;
  ListRevocate:=TStringList.Create;

  // Importante:
  //   le richieste sono ordinate in modo da proporre prima quelle definitive e
  //   preventive, e in fondo le revoche e le cancellazioni
  //   questo accorgimento è utile soprattutto per gestire correttamente le cancellazioni
  //   per le quali servirebbero dei controlli specifici
  try
    // aggiorna le richieste da importare prima di iniziare l'elaborazione
    selT050.Refresh;

    // avvisa se dopo il refresh non ci sono più richieste da importare
    if selT050.RecordCount = 0 then
    begin
      Msg:=IfThen(PSingola,
                  'La richiesta selezionata è già stata importata in precedenza.',
                  'Tutte le richieste visualizzate sono già state importate in precedenza.');
      R180MessageBox(Msg,INFORMA);
      Abort;
    end
    else if (PSingola) and
            (not selT050.SearchRecord('ID',OldIdSingolo,[srFromBeginning])) then
    begin
      R180MessageBox('La richiesta selezionata è già stata importata in precedenza.',INFORMA);
      Abort;
    end;

    //selT050.DisableControls; // non utilizzare questa funzione (problemi di disallineamento dopo refresh)

    // imposta progressbar
    {$IFNDEF IRISWEB}
    if Assigned(ProgressBar) then
      ProgressBar.Max:=IfThen(PSingola,1,selT050.RecordCount);
    {$ENDIF IRISWEB}

    // posizionamento su prima richiesta per elaborazione massiva
    if not PSingola then
      selT050.First;

    // ciclo di importazione giustificativi
    Scartate:=0;
    while not selT050.Eof do
    begin
      {$IFNDEF IRISWEB}
      if Assigned(ProgressBar) then
        ProgressBar.StepBy(1);
      {$ENDIF IRISWEB}

      // lock richiesta.ini
      selT050Upd.Close;
      selT050Upd.SetVariable('ID',selT050.FieldByName('ID').AsInteger);
      selT050Upd.Open;
      if selT050Upd.RecordCount = 0 then
      begin
        // decisamente improbabile
        ResumeNext('La richiesta selezionata è stata eliminata.');
        Continue;
      end;

      // lock immediato sul record
      try
        selT050Upd.Edit;
      except
        // errore: il record è in stato di lock (risorsa occupata)
        ResumeNext('La richiesta selezionata è già in fase di elaborazione da parte di altro utente.');
        Continue;
      end;

      // ulteriore controllo per verificare se la richiesta è già stata elaborata
      // da un altro operatore
      if (selT050Upd.FieldByName('ELABORATO').AsString = 'S') or
         ((selT050Upd.FieldByName('ELABORATO').AsString = 'E') and
          (PNuoveRichieste)) then
      begin
        ResumeNext('La richiesta selezionata è già stata importata in precedenza.');
        Continue;
      end;
      // lock richiesta.fine

      // lock acquisito: inizio elaborazione della richiesta
      TipoRich:=selT050.FieldByName('TIPO_RICHIESTA').AsString;

      AggiornaStato:=False; // chiamata <71526>
      if selT050.FieldByName('AUTORIZZAZIONE').AsString = 'N' then
      begin
        // richiesta negata: errore
        if TipoRich = 'D' then
        begin
          PeriodoNonInserito('Richiesta non autorizzata!');

          // COMO_HSANNA - commessa 2013/012.ini
          // richiesta non autorizzata -> cancella la richiesta
          WSCtrlCancella;
          // COMO_HSANNA - commessa 2013/012.fine
        end
        else if TipoRich = 'R' then
        begin
          PeriodoNonCancellato('Revoca non autorizzata!');

          // COMO_HSANNA - commessa 2013/012.ini
          // revoca non autorizzata -> nessuna chiamata (la richiesta di revoca non è salvata su StaffRoster)
          // COMO_HSANNA - commessa 2013/012.fine
        end
        // empoli - commessa 2012/102.ini
        else if TipoRich = 'C' then
        begin
          PeriodoNonCancellato('Cancellazione non autorizzata!');

          // COMO_HSANNA - commessa 2013/012.ini
          // cancellazione non autorizzata -> nessuna chiamata (la richiesta di cancellazione non è salvata su StaffRoster)
          // COMO_HSANNA - commessa 2013/012.fine
        end;
        // empoli - commessa 2012/102.fine
      end
      else
      begin
        // COMO_HSANNA - commessa 2013/012.ini
        // richiesta autorizzata -> cancella:
        //   la richiesta originale (se tipo_richiesta P/D)
        //   il giustificativo      (se tipo_richiesta R/C)
        WSCtrlCancella;
        // COMO_HSANNA - commessa 2013/012.fine

        // richiesta autorizzata / preventiva non autorizzata
        R180SetVariable(Q040,'PROGRESSIVO',selT050.FieldByName('PROGRESSIVO').AsInteger);
        Q040.Open;
        if TipoRich = 'P' then
        begin
          // richiesta preventiva: imposta solo il flag elaborato = S
          // caso 1: autorizzazione negata
          // caso 2: collegata ad una revoca autorizzata
          Elaborato:='S';

          // considera il caso 2 (richiesta legata a revoca autorizzata)
          if (not selT050.FieldByName('ID_REVOCA').IsNull) and
             (VarToStr(selT050.Lookup('ID',selT050.FieldByName('ID_REVOCA').AsInteger,'AUTORIZZAZIONE')) = 'S') then
          begin
            // la richiesta è collegata ad una revoca pendente autorizzata
            // in caso di importazione singola forza anche l'importazione della revoca
            if PSingola then
            begin
              if RichCollegata = 0 then
                RichCollegata:=selT050.FieldByName('ID_REVOCA').AsInteger
              else
                RichCollegata:=0;
            end;
          end;
        end
        else if TipoRich = 'D' then
        begin
          // richiesta definitiva
          // empoli - commessa 2012/102.ini
          if //(not selT050.FieldByName('ID_REVOCA').IsNull) and
             (selT050.FieldByName('ID_REVOCA').AsInteger > 0) and
          // empoli - commessa 2012/102.fine
             (VarToStr(selT050.Lookup('ID',selT050.FieldByName('ID_REVOCA').AsInteger,'AUTORIZZAZIONE')) = 'S') then
          begin
            // la richiesta è collegata ad una revoca pendente autorizzata -> compensazione
            // in caso di importazione singola forza anche l'importazione della revoca
            // Importante:
            //   alcune richieste definitive non ancora autorizzate possono
            //   pertanto essere flaggate come elaborate
            //   il motivo di questa scelta è il seguente: una volta che la revoca
            //   è autorizzata, il giustificativo non deve essere caricato sul cartellino,
            //   indipendentemente da come si chiude l'iter della richiesta originale,
            //   che viene pertanto considerata già elaborata
            ListRevocate.Add(selT050.FieldByName('ID_REVOCA').AsString);
            if PSingola then
            begin
              if RichCollegata = 0 then
              begin
                // segnala la presenza della revoca corrispondente
                ErrMsg:=A000TraduzioneStringhe(A000MSG_A004_MSG_RICH_COMPENSATA_REVOCA);
                RichCollegata:=selT050.FieldByName('ID_REVOCA').AsInteger;
              end
              else
                RichCollegata:=0;
            end;
            PeriodoCompensato(True);
          end
          else
          begin
            //Se c'è una revoca non autorizzata non faccio nulla
            if (selT050.FieldByName('ID_REVOCA').AsInteger > 0) and (selT050.FieldByName('STATO_REVOCA').IsNull) then
            begin
              ResumeNext('Esiste una revoca in fase di autorizzazione!');
              Continue;
            end
            else
              //altrimenti procede con l'inserimento del/i giustificativo/i
              ImportaRichiesta(True,PInterattiva);
          end;
        end
        else if TipoRich = 'R' then
        begin
          // richiesta di revoca
          if selT050.FieldByName('TIPO_RICHIESTA_ORIG').AsString = 'P' then
          begin
            // revoca di una richiesta preventiva
            Elaborato:='S';

            // pulisce l'eventuale richiesta collegata
            if RichCollegata > 0 then
              RichCollegata:=0;
          end
          else
          begin
            // revoca di una richiesta definitiva
            // se non è già stata considerata la richiesta corrispondente -> cancella il giustificativo
            if ListRevocate.IndexOf(selT050.FieldByName('ID').AsString) >= 0 then
            begin
              // richiesta definitiva presente nell'elenco e già considerata
              if RichCollegata > 0 then
                RichCollegata:=0;
              PeriodoCompensato(True);
            end
            else if (PSingola) and
                    (VarToStr(selT050.Lookup('ID_REVOCA',selT050.FieldByName('ID').AsInteger,'ID')) <> '') then
            begin
              if RichCollegata = 0 then
              begin
                // segnala la presenza della richiesta corrispondente (che verrà trattata in modo particolare)
                ErrMsg:=A000TraduzioneStringhe(A000MSG_A004_MSG_RICH_COMPENSATA_GIUSTIF);
                RichCollegata:=StrToInt(VarToStr(selT050.Lookup('ID_REVOCA',selT050.FieldByName('ID').AsInteger,'ID')));
              end
              else
                RichCollegata:=0;
              PeriodoCompensato(True);
            end
            else
            begin
              // procede con la cancellazione del/i giustificativo/i
              ImportaRichiesta(False,PInterattiva);
            end;
          end;
        end
        // empoli - commessa 2012/102.ini
        else if TipoRich = 'C' then
        begin
          // richiesta di cancellazione
          // in modalità singola elabora la richiesta solo se è già stata importata la corrispondente richiesta defintiiva
          // la modalità collettiva opera in modo da elaborare prima la richiesta definitiva, quindi il problema non si pone

          // nota operativa: non è possibile utilizzare la lookup perché il dataset
          // non viene aggiornato dopo l'update
          selElaborato.SetVariable('ID',selT050.FieldByName('ID_REVOCATO').AsInteger);
          selElaborato.Execute;
          if selElaborato.FieldAsString(0) = 'N' then
          begin
            //IdBookmark:=selT050.FieldByName('ID_REVOCATO').AsInteger;
            ResumeNext('E'' necessario importare prima la corrispondente richiesta di giustificativo!');
            Continue;
          end
          else
          begin
            ImportaRichiesta(False,PInterattiva);
          end;
        end;
        // empoli - commessa 2012/102.fine
      end;
      // nuova gestione.fine

      // Imposto la colonna-flag elaborato
      if Elaborato = 'E' then
        Result:=False;

      // nuova gestione del lock.ini
      selT050Upd.FieldByName('ELABORATO').AsString:=Elaborato;
      selT050Upd.Post;
      // nuova gestione del lock.fine

      // chiamata <71526>.ini
      if AggiornaStato then
      begin
        updT850.SetVariable('ID',selT050.FieldByName('ID').AsInteger);
        updT850.SetVariable('STATO',C018SI);
        updT850.Execute;
      end;
      // chiamata <71526>.fine

      // commit e conseguente rilascio del lock
      // bugfix.ini: occorre utilizzare la sessione A004! - daniloc. 25.07.2013
      //SessioneOracle.Commit;
      SessioneOracleA004.Commit;
      // bugfix.fine

      // gestione invio mail
      if Parametri.CampiRiferimento.C90_EMailW010Uff = 'S' then
      begin
        Msg:='Elaborazione richiesta di ';
        if TipoRich = 'D' then
          Msg:=Msg + 'giustificativo'
        else if TipoRich = 'R' then
          Msg:=Msg + 'revoca'
        else if TipoRich = 'C' then
          Msg:=Msg + 'cancellazione';
        Msg:=Format('%s: %s (%s)',[Msg,selT050.FieldByName('NOMINATIVO').AsString,selT050.FieldByName('MATRICOLA').AsString]);
        InviaEMail(False,selT050.FieldByName('PROGRESSIVO').AsInteger,Msg);
      end;

      // verifica se proseguire nel ciclo
      if not PSingola then
        selT050.Next
      else
      begin
        if RichCollegata = 0 then
          Break
        else
        begin
          // posizionamento sul record della richiesta collegata
          // (revoca oppure richiesta definitiva corrispondente) per elaborazione
          selT050.SearchRecord('ID',RichCollegata,[srFromBeginning]);
        end;
      end;
    end; // end while
  finally
    FreeAndNil(ListRevocate);
    {$IFNDEF IRISWEB}
    if Assigned(ProgressBar) then
      ProgressBar.Position:=0;
    {$ENDIF IRISWEB}
    //selT050.EnableControls;

    // in caso di errori rimuove l'eventuale lock sul record di T050
    if selT050Upd.State = dsEdit then
      selT050Upd.Cancel;

    try FreeAndNil(C018DM); except end;
    AcquisizioneWebInCorso:=False;
  end;
end;

procedure TA004FGiustifAssPresMW.PeriodoInserito;
var
  s, NomeResp, Note, CausInserita: String;
begin
  // 1. log elaborazione
  s:=FormattaDatiRichiesta(True,Note,CausInserita,NomeResp);
  RegistraMsg.InserisciMessaggio('I',s,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  // segnala se la causale richiesta è differente da quella effettivamente
  // inserita (es. per legge Brunetta o competenze esaurite)
  if CausInserita <> '' then
    RegistraMsg.InserisciMessaggio('I',Format('Causale inserita: %s',[CausInserita]),'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  RegistraMsg.InserisciMessaggio('I',Format('Autorizzato dall''utente %s',[NomeResp]),'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  if Note <> '' then
    RegistraMsg.InserisciMessaggio('I',Note,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  RegistraMsg.InserisciMessaggio('I','ESITO POSITIVO: Periodo inserito completamente!','',selT050.FieldByName('PROGRESSIVO').AsInteger);

  // 2. log messaggio web
  insT280.SetVariable('PROGRESSIVO',selT050.FieldByName('PROGRESSIVO').AsInteger);
  insT280.SetVariable('DATA',Now);
  insT280.SetVariable('MITTENTE',Parametri.Operatore);
  insT280.SetVariable('LOG',s + #13#10 + 'Periodo inserito completamente!');
  s:=FormattaDatiLog(NomeResp,Note);
  insT280.SetVariable('TESTO',s);
  insT280.SetVariable('FLAG','0');
  insT280.SetVariable('TITOLO','<A004> ESITO POSITIVO - Caricamento giustificativi richiesti e autorizzati');
  insT280.Execute;
  if EseguiCommit then
    SessioneOracleA004.Commit;

  // elaborazione positiva
  Elaborato:='S';
end;

procedure TA004FGiustifAssPresMW.PeriodoInseritoConAnomalie;
var
  s,Note,Temp,NomeResp: String;
begin
  // 1. log elaborazione
  s:=FormattaDatiRichiesta(False,Note,Temp,NomeResp);
  RegistraMsg.InserisciMessaggio('I',s,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  RegistraMsg.InserisciMessaggio('I',Format('Autorizzato dall''utente %s',[NomeResp]),'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  if Note <> '' then
    RegistraMsg.InserisciMessaggio('I',Note,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  RegistraMsg.InserisciMessaggio('A','ESITO NEGATIVO: Periodo inserito con ANOMALIE!','',selT050.FieldByName('PROGRESSIVO').AsInteger);
  // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.ini
  // riporta nel log la lista completa di anomalie
  //RegistraMsg.InserisciMessaggio('A',R600DtM1.FormattaAnomaliaWeb(R600DtM1.ListAnomalie),'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  RegistraMsg.InserisciMessaggio('A',R600DtM1.FormattaAnomaliaWeb(ListAnomalieCompleta),'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.fine

  // 2. log messaggio web
  insT280.SetVariable('PROGRESSIVO',selT050.FieldByName('PROGRESSIVO').AsInteger);
  insT280.SetVariable('DATA',Now);
  insT280.SetVariable('MITTENTE',Parametri.Operatore);
  // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.ini
  // riporta nel log la lista completa di anomalie
  //insT280.SetVariable('LOG',Copy(s + #13#10'ESITO NEGATIVO: Periodo inserito con ANOMALIE!'#13#10 + R600DtM1.ListAnomalie.Text,1,2000));
  insT280.SetVariable('LOG',Copy(s + #13#10'ESITO NEGATIVO: Periodo inserito con ANOMALIE!'#13#10 + ListAnomalieCompleta.Text,1,2000));
  // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.fine
  s:=FormattaDatiLog(NomeResp,Note);
  insT280.SetVariable('TESTO',s);
  insT280.SetVariable('FLAG','1');
  insT280.SetVariable('TITOLO','<A004> ESITO NEGATIVO - Caricamento giustificativi richiesti e autorizzati');
  if EseguiCommit then
    insT280.Execute;
  SessioneOracleA004.Commit;

  // elaborazione con errori
  Elaborato:='E';
end;

procedure TA004FGiustifAssPresMW.PeriodoNonInserito(const Errore:String);
var
  s,Err,Note,NomeResp,Temp:String;
begin
  Err:='';
  ControlliOK:=False;

  // 1. log elaborazione
  s:=FormattaDatiRichiesta(False,Note,Temp,NomeResp);
  RegistraMsg.InserisciMessaggio('I',s,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  RegistraMsg.InserisciMessaggio('I',Format('Autorizzato dall''utente %s',[NomeResp]),'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  if Note <> '' then
    RegistraMsg.InserisciMessaggio('I',Note,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  if Errore <> 'Richiesta non autorizzata!' then
  begin
    // elaborazione con errori
    Elaborato:='E';
    RegistraMsg.InserisciMessaggio('A','ESITO NEGATIVO: Periodo NON inserito!','',selT050.FieldByName('PROGRESSIVO').AsInteger);
    if Errore <> '' then
    begin
      RegistraMsg.InserisciMessaggio('A',Trim(Errore),'',selT050.FieldByName('PROGRESSIVO').AsInteger);
      Err:=Errore;
    end
    else
    begin
      // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.ini
      // riporta nel log la lista completa di anomalie
      //Err:=R600DtM1.FormattaAnomaliaWeb(R600DtM1.ListAnomalie);
      Err:=R600DtM1.FormattaAnomaliaWeb(ListAnomalieCompleta);
      // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.fine
    end;
    RegistraMsg.InserisciMessaggio('A',Err,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  end
  else
  begin
    // elaborazione senza errori
    Elaborato:='S';
    RegistraMsg.InserisciMessaggio('A','ESITO NEGATIVO: Richiesta non autorizzata!','',selT050.FieldByName('PROGRESSIVO').AsInteger);
  end;

  // 2. log messaggio web
  insT280.SetVariable('PROGRESSIVO',selT050.FieldByName('PROGRESSIVO').AsInteger);
  insT280.SetVariable('DATA',Now);
  insT280.SetVariable('MITTENTE',Parametri.Operatore);
  if Errore <> 'Richiesta non autorizzata!' then
  begin
    insT280.SetVariable('LOG',Copy(s + #13#10 + 'ESITO NEGATIVO: Periodo NON inserito!' + #13#10 + Err,1,2000));
    insT280.SetVariable('FLAG','1');
  end
  else
  begin
    insT280.SetVariable('LOG',s + #13#10 + 'ESITO NEGATIVO: Richiesta non autorizzata!');
    insT280.SetVariable('FLAG','2');
  end;
  s:=FormattaDatiLog(NomeResp,Note);
  insT280.SetVariable('TESTO',s);
  insT280.SetVariable('TITOLO','<A004> ESITO NEGATIVO - Caricamento giustificativi richiesti e autorizzati');
  insT280.Execute;
  if EseguiCommit then
    SessioneOracleA004.Commit;

  // elaborazione con errori
  //Elaborato:='E';
end;

procedure TA004FGiustifAssPresMW.PeriodoCancellato;
var
  s, NomeResp, Note, CausInserita: String;
begin
  // 1. log elaborazione
  s:=FormattaDatiRichiesta(True,Note,CausInserita,NomeResp);
  RegistraMsg.InserisciMessaggio('I',s,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  RegistraMsg.InserisciMessaggio('I',Format('Autorizzato dall''utente %s',[NomeResp]),'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  if Note <> '' then
    RegistraMsg.InserisciMessaggio('I',Note,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  RegistraMsg.InserisciMessaggio('I','ESITO POSITIVO: Periodo cancellato completamente!','',selT050.FieldByName('PROGRESSIVO').AsInteger);

  // 2. log messaggio web
  insT280.SetVariable('PROGRESSIVO',selT050.FieldByName('PROGRESSIVO').AsInteger);
  insT280.SetVariable('DATA',Now);
  insT280.SetVariable('MITTENTE',Parametri.Operatore);
  insT280.SetVariable('LOG',s + #13#10 + 'Periodo cancellato completamente!');
  s:=FormattaDatiLog(NomeResp,Note);
  insT280.SetVariable('TESTO',s);
  insT280.SetVariable('FLAG','0');
  insT280.SetVariable('TITOLO','<A004> ESITO POSITIVO - Caricamento giustificativi richiesti e autorizzati');
  insT280.Execute;
  if EseguiCommit then
    SessioneOracleA004.Commit;

  // elaborazione positiva
  Elaborato:='S';
end;

procedure TA004FGiustifAssPresMW.PeriodoNonCancellato(const Errore:String);
var
  s,Err,Note,NomeResp,Temp:String;
begin
  Err:='';
  ControlliOK:=False;

  // 1. log elaborazione
  s:=FormattaDatiRichiesta(False,Note,Temp,NomeResp);
  RegistraMsg.InserisciMessaggio('I',s,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  RegistraMsg.InserisciMessaggio('I',Format('Autorizzato dall''utente %s',[NomeResp]),'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  if Note <> '' then
    RegistraMsg.InserisciMessaggio('I',Note,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  if Errore <> 'Richiesta non autorizzata!' then
  begin
    // elaborazione con errori
    Elaborato:='E';
    RegistraMsg.InserisciMessaggio('A','ESITO NEGATIVO: Periodo NON cancellato!','',selT050.FieldByName('PROGRESSIVO').AsInteger);
    if Errore <> '' then
    begin
      RegistraMsg.InserisciMessaggio('A',Trim(Errore),'',selT050.FieldByName('PROGRESSIVO').AsInteger);
      Err:=Errore;
    end
    else
      RegistraMsg.InserisciMessaggio('A','Errore non specificato','',selT050.FieldByName('PROGRESSIVO').AsInteger);
  end
  else
  begin
    // elaborazione senza errori
    Elaborato:='S';
    RegistraMsg.InserisciMessaggio('A','ESITO NEGATIVO: Richiesta non autorizzata!','',selT050.FieldByName('PROGRESSIVO').AsInteger);
  end;

  // 2. log messaggio web
  insT280.SetVariable('PROGRESSIVO',selT050.FieldByName('PROGRESSIVO').AsInteger);
  insT280.SetVariable('DATA',Now);
  insT280.SetVariable('MITTENTE',Parametri.Operatore);
  if Errore <> 'Richiesta non autorizzata!' then
  begin
    insT280.SetVariable('LOG',Copy(s + #13#10 + 'ESITO NEGATIVO: Periodo NON cancellato!' + #13#10 + Err,1,2000));
    insT280.SetVariable('FLAG','1');
  end
  else
  begin
    insT280.SetVariable('LOG',s + #13#10 + 'ESITO NEGATIVO: Richiesta non autorizzata!');
    insT280.SetVariable('FLAG','2');
  end;
  s:=FormattaDatiLog(NomeResp,Note);
  insT280.SetVariable('TESTO',s);
  insT280.SetVariable('TITOLO','<A004> ESITO NEGATIVO - Caricamento giustificativi richiesti e autorizzati');
  insT280.Execute;
  if EseguiCommit then
    SessioneOracleA004.Commit;

  // elaborazione con errori
  //Elaborato:='E';
end;

procedure TA004FGiustifAssPresMW.PeriodoCompensato(TracciaMsgWeb: Boolean);
var
  s, NomeResp, Note, Temp, TipoRichComp: String;
begin
  // "TracciaMsgWeb" al momento è sempre passato a True
  TipoRichComp:='richiesta di ' + IfThen(selT050.FieldByName('TIPO_RICHIESTA').AsString = 'R','giustificativo','revoca');

  // 1. log elaborazione
  s:=FormattaDatiRichiesta(False,Note,Temp,NomeResp);
  RegistraMsg.InserisciMessaggio('I',s,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  RegistraMsg.InserisciMessaggio('I',Format('Autorizzato dall''utente %s',[NomeResp]),'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  if Note <> '' then
    RegistraMsg.InserisciMessaggio('I',Note,'',selT050.FieldByName('PROGRESSIVO').AsInteger);
  RegistraMsg.InserisciMessaggio('I','ESITO POSITIVO: Periodo non considerato per compensazione con ' + TipoRichComp,'',selT050.FieldByName('PROGRESSIVO').AsInteger);

  // 2. log messaggio web
  if TracciaMsgWeb then
  begin
    insT280.SetVariable('PROGRESSIVO',selT050.FieldByName('PROGRESSIVO').AsInteger);
    insT280.SetVariable('DATA',Now);
    insT280.SetVariable('MITTENTE',Parametri.Operatore);
    // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.ini
    // riporta nel log la lista completa di anomalie
    //insT280.SetVariable('LOG',Copy(s + #13#10 + 'ESITO POSITIVO: Periodo non considerato per compensazione con ' + TipoRichComp + #13#10 + R600DtM1.ListAnomalie.Text,1,2000));
    insT280.SetVariable('LOG',Copy(s + #13#10 + 'ESITO POSITIVO: Periodo non considerato per compensazione con ' + TipoRichComp + #13#10 + ListAnomalieCompleta.Text,1,2000));
    // commessa MAN/08 - SVILUPPO#56 - riesame del 09.10.2013.fine
    s:=FormattaDatiLog(NomeResp,Note);
    insT280.SetVariable('TESTO',s);
    insT280.SetVariable('FLAG','4');
    insT280.SetVariable('TITOLO','<A004> ESITO POSITIVO - Caricamento giustificativi richiesti e autorizzati');
    insT280.Execute;
    if EseguiCommit then
      SessioneOracleA004.Commit;
  end;

  // elaborazione positiva
  Elaborato:='S';
  // indica di chiudere l'iter di una richiesta definitiva revocata
  AggiornaStato:=selT050.FieldByName('TIPO_RICHIESTA').AsString = 'D';
end;

function TA004FGiustifAssPresMW.GetNoteRichiesta(PIdRichiesta: Integer): String;
// PIdRichiesta non è utilizzato!!
begin
  C018DM.CodIter:=selT050.FieldByName('COD_ITER').AsString;
  C018DM.Id:=selT050.FieldByName('ID').AsInteger;
  Result:=C018DM.LeggiNoteComplete(False);
end;

function TA004FGiustifAssPresMW.FormattaDatiRichiesta(const CausIns: Boolean; var Note,CausInserita,NomeResp: String): String;
var
  Tipo: String;
begin
  // prepara testo formattato
  if selT050.FieldByName('TIPO_RICHIESTA').AsString = 'D' then
    Tipo:='Richiesta'
  else if selT050.FieldByName('TIPO_RICHIESTA').AsString = 'R' then
    Tipo:='Revoca richiesta'
  else
    Tipo:='Cancellazione';
  Result:=Format('%s causale: %s - Dal %s al %s',
                 [Tipo,
                  selT050.FieldByName('D_CAUSALE').AsString,
                  selT050.FieldByName('DAL').AsString,
                  selT050.FieldByName('AL').AsString]);

  if not selT050.FieldByName('NUMEROORE').IsNull then
    Result:=Result + ' - Ore: ' + selT050.FieldByName('NUMEROORE').AsString;
  if not selT050.FieldByName('AORE').IsNull then
    Result:=Result + '-' + selT050.FieldByName('AORE').AsString;

  // se periodo inserito: considera causale effettivamente inserita
  CausInserita:='';
  if (CausIns) and
     (selT050.FieldByName('CAUSALE').AsString <> Var_Causale) then
  begin
    CausInserita:=Var_Causale;
  end;

  // estrae le note
  Note:='';
  C018DM.CodIter:=selT050.FieldByName('COD_ITER').AsString;
  C018DM.Id:=selT050.FieldByName('ID').AsInteger;
  Note:=C018DM.LeggiNoteComplete(False);

  // estrae nominativo responsabile
  NomeResp:=selT050.FieldByName('NOMINATIVO_RESP').AsString;
end;

procedure TA004FGiustifAssPresMW.ImportaRichiesta(const PIns: Boolean; const PInterattiva: Boolean);
// esegue l'importazione della richiesta
// PIns: indica se si tratta di un inserimento / cancellazione di giustificativo
//   True  = inserimento
//   False = cancellazione
// PInterattiva: indica se la unit R600 deve avere VisualizzaAnomalie
var
  GestioneSingolaDMOrig: Boolean;
begin
  // imposta le variabili per l'inserimento / cancellazione
  if Q265.SearchRecord('CODICE',selT050.FieldByName('CAUSALE').AsString,[srFromBeginning]) then
    Var_TipoCaus:=1
  else if Q275.SearchRecord('CODICE',selT050.FieldByName('CAUSALE').AsString,[srFromBeginning]) then
    Var_TipoCaus:=0
  else
  begin
    if PIns then
      PeriodoNonInserito(Format(A000MSG_ERR_FMT_NON_ESISTENTE,['Causale ' + selT050.FieldByName('CAUSALE').AsString]))
    else
      PeriodoNonCancellato(Format(A000MSG_ERR_FMT_NON_ESISTENTE,['Causale ' + selT050.FieldByName('CAUSALE').AsString]));
    exit;
  end;
  Var_Gestione:=0;
  if selT050.FieldByName('TIPOGIUST').AsString = 'I' then
    Var_TipoGiust:=0
  else if selT050.FieldByName('TIPOGIUST').AsString = 'M' then
    Var_TipoGiust:=1
  else if selT050.FieldByName('TIPOGIUST').AsString = 'N' then
    Var_TipoGiust:=IfThen(Var_TipoCaus = 0,0,2)
  else if selT050.FieldByName('TIPOGIUST').AsString = 'D' then
    Var_TipoGiust:=IfThen(Var_TipoCaus = 0,1,3);
  Var_TipoGiust_Count:=IfThen(Var_TipoCaus = 0,2,4);
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  Var_TipoMG:=selT050.FieldByName('CSI_TIPO_MG').AsString;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  if selT050.FieldByName('NUMEROORE').AsString = '' then
    Var_DaOre:='  .  '
  else
    Var_DaOre:=selT050.FieldByName('NUMEROORE').AsString;
  if selT050.FieldByName('AORE').AsString = '' then
    Var_AOre:='  .  '
  else
    Var_AOre:=selT050.FieldByName('AORE').AsString;
  Var_DaData:=selT050.FieldByName('DAL').AsString;
  Var_AData:=selT050.FieldByName('AL').AsString;
  Var_NumGG:=0;
  Var_Causale:=selT050.FieldByName('Causale').AsString;
  Var_Familiari:=selT050.FieldByName('DATANAS').AsString;
  Var_Progressivo:=selT050.FieldByName('Progressivo').AsInteger;

  // controlli per inserimento oppure cancellazione
  // nota: il controllo non bloccante sul familiare di riferimento è escluso in questo caso
  //       per cui non viene valutato il messaggio di errore
  ControlliOK:=True;
  R600DtM1.VisualizzaAnomalie:=False;
  R600DtM1.AnomalieBloccanti:=True;
  Controlli(False,PIns);
  R600DtM1.VisualizzaAnomalie:=True;
  R600DtM1.AnomalieBloccanti:=False;

  // esclude le richieste nel calcolo delle fruizioni, per non conteggiarle 2 volte
  R600DtM1.RichiesteIterAutorizzativo:=False;

  if ControlliOK then
  begin
    Giustif.Inserimento:=PIns; // inserimento / cancellazione
    Giustif.Modo:=selT050.FieldByName('TIPOGIUST').AsString[1];
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    Giustif.CSITipoMG:=selT050.FieldByName('CSI_TIPO_MG').AsString;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    Giustif.Causale:=selT050.FieldByName('CAUSALE').AsString;
    if Trim(selT050.FieldByName('NUMEROORE').AsString) = '' then
      Giustif.DaOre:='.'
    else
      Giustif.DaOre:=selT050.FieldByName('NUMEROORE').AsString;
    if Trim(selT050.FieldByName('AORE').AsString) = '' then
      Giustif.AOre:='.'
    else
      Giustif.AOre:=selT050.FieldByName('AORE').AsString;
    chkNuovoPeriodo:=False;

    // forza gestione singola, salvando il valore originale che sarà poi reimpostato
    GestioneSingolaDMOrig:=GestioneSingolaDM;
    GestioneSingolaDM:=True;

    R600DtM1.VisualizzaAnomalie:=PInterattiva;
    R600DtM1.AnomalieBloccanti:=True;
    R600DtM1.CheckIntersezioneTimbrature:=False;

    // esegue inserimento / cancellazione
    if PIns then
      InserisciGiustif(False,selT050.FieldByName('ID').AsInteger)
    else
      EseguiCancellazione;

    // ripristino variabili per conteggi
    R600DtM1.VisualizzaAnomalie:=True;
    R600DtM1.AnomalieBloccanti:=False;
    R600DtM1.CheckIntersezioneTimbrature:=True;
    R600DtM1.RichiesteIterAutorizzativo:=True;

    // reimposta valore di gestione singola originale
    GestioneSingolaDM:=GestioneSingolaDMOrig;
  end;
end;

procedure TA004FGiustifAssPresMW.EseguiCancellazione;
// esegue la cancellazione dei giustificativi con
// t040.id_richiesta = id della richiesta originale
begin
  selT040Revoche.Close;
  // empoli - commessa 2012/102.ini
  // per gestire le cancellazioni parziali, verifica anche che i giustificativi
  // rientrino nel periodo della richiesta
  selT040Revoche.SetVariable('ID',selT050.FieldByName('ID_REVOCATO').AsInteger);
  selT040Revoche.SetVariable('DAL',selT050.FieldByName('DAL').AsDateTime);
  selT040Revoche.SetVariable('AL',selT050.FieldByName('AL').AsDateTime);
  // empoli - commessa 2012/102.fine
  selT040Revoche.Open;
  if selT040Revoche.RecordCount = 0 then
  begin
    // nessun giustificativo trovato con l'ID richiesta
    PeriodoNonCancellato('Giustificativo da cancellare non trovato.');
  end
  else
  begin
    // ciclo di cancellazione
    while not selT040Revoche.Eof do
    begin
      //Impedisco la cancellazione della 9104, che ha lo stesso ID del vero giustificativo revocato, ma deve essere cancellata successivamente
      if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (selT040Revoche.FieldByName('CAUSALE').AsString = TO_CSI_ABB_ECCSETT) then
      begin
        selT040Revoche.Next;
        Continue;
      end;
      Var_DaData:=selT040Revoche.FieldByName('DATA').AsString;
      Var_AData:=Var_DaData;
      Var_Causale:=selT040Revoche.FieldByName('CAUSALE').AsString;
      if selT040Revoche.FieldByName('TIPOGIUST').AsString = 'I' then
        Var_TipoGiust:=0
      else if selT040Revoche.FieldByName('TIPOGIUST').AsString = 'M' then
        Var_TipoGiust:=1
      else if selT040Revoche.FieldByName('TIPOGIUST').AsString = 'N' then
        Var_TipoGiust:=IfThen(Var_TipoCaus = 0,0,2)
      else if selT040Revoche.FieldByName('TIPOGIUST').AsString = 'D' then
        Var_TipoGiust:=IfThen(Var_TipoCaus = 0,1,3);
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
      Var_TipoMG:=selT040Revoche.FieldByName('CSI_TIPO_MG').AsString;
      // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
      if selT040Revoche.FieldByName('DAORE').IsNull then
        Var_DaOre:='  .  '
      else
        Var_DaOre:=FormatDateTime('hh.nn',selT040Revoche.FieldByName('DAORE').AsDateTime);
      if selT040Revoche.FieldByName('AORE').IsNull then
        Var_AOre:='  .  '
      else
        Var_AOre:=FormatDateTime('hh.nn',selT040Revoche.FieldByName('AORE').AsDateTime);
      DataInizio:=StrToDate(Var_DaData);
      DataFine:=StrToDate(Var_AData);
      CancellaGiustif(False,selT040Revoche.Recno = selT040Revoche.RecordCount);
      // in caso di un giorno con errore segnala comunque periodo non cancellato
      if ErroreCancellazione <> '' then
      begin
        PeriodoNonCancellato(ErroreCancellazione);
        Break;
      end;
      if DatoBloccatoCancellazione then
      begin
        PeriodoNonCancellato('Riepilogo bloccato');
        Break;
      end;
      selT040Revoche.Next;
    end;
  end;
  selT040Revoche.Close;
end;

// ############ IMPORTAZIONE ASSENZE WEB.fine ############ //


function TA004FGiustifAssPresMW.EstraiMedLeg(const PCodComune: String): String;
// estrae il codice della medicina legale associata al comune indicato
begin
  Result:='';
  if PCodComune = '' then
    Exit;
  try
    R180SetVariable(selT486,'COD_COMUNE',PCodComune);
    selT486.Open;
    if selT486.RecordCount > 0 then
      Result:=selT486.FieldByName('MED_LEGALE').AsString;
  except
  end;
end;

function TA004FGiustifAssPresMW.FormattaDatiLog(const NomeResp, Note: String): String;
begin
  Result:='Autorizzato dall''utente ' + NomeResp;
  if Note <> '' then
    Result:=Result + #13#10 + Note;
end;

procedure TA004FGiustifAssPresMW.InviaEMail(const PDestResponsabile:Boolean; const PProg:Integer; const PTesto:String);
var
  C017FEMailDtM: TC017FEMailDtM;
begin
  C017FEMailDtM:=TC017FEMailDtM.Create(nil);
  try
    C017FEMailDtM.InviaEMail(SessioneOracleA004,PDestResponsabile,PProg,PTesto,'',406);
  finally
    FreeAndNil(C017FEMailDtM);
  end;
end;

// COMO_HSANNA - commessa 2013/012.ini - chiamata webservice firlab
procedure TA004FGiustifAssPresMW.WSCtrlCancella;
// verifica se è necessario chiamare il webservice per allineare i dati
// a seguito dell'elaborazione di una richiesta
var
  D: TDateTime;
  TR: String;
  TipoCaus: Integer;
  CancRichiesta: Boolean;
begin
  if (Parametri.CampiRiferimento.C30_WebSrv_A004_URL <> '') and
     (Parametri.CampiRiferimento.C30_WebSrv_A004_Dati <> '') then
  begin
    // nel caso di richieste di inserimento, la cancellazione si fa sia se la richiesta è autorizzata che negata
    TR:=selT050.FieldByName('TIPO_RICHIESTA').AsString;
    if (TR = 'P') or (TR = 'D') then
    begin
      // nuova richiesta preventiva / definitiva: sarà elaborata in ogni caso
      // -> chiama il webservice chiedendo di cancellare la richiesta
      CancRichiesta:=True;
    end
    else if (TR = 'R') and (selT050.FieldByName('TIPO_RICHIESTA_ORIG').AsString = 'P') then
    begin
      // revoca di richiesta preventiva
      // -> chiama il webservice chiedendo di cancellare la richiesta
      CancRichiesta:=True;
    end
    else
    begin
      // revoca di richiesta definitiva (o cancellazione) solo se autorizzata (controllato dal chiamante):
      // verifica se il giustificativo è già presente
      // in questo caso chiama il webservice chiedendo di cancellare il giustificativo
      // altrimenti chiede di cancellare la richiesta
      CancRichiesta:=VarToStr(selT050.Lookup('ID',selT050.FieldByName('ID_REVOCATO').AsInteger,'AUTORIZZAZIONE')) = 'S';
    end;
  end;
end;
// COMO_HSANNA - commessa 2013/012.fine

procedure TA004FGiustifAssPresMW.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
// filtro dataset per i seguenti dataset:
//    Q265: causali di assenza
//    Q275: causali di presenza
// selT050: richieste di giustificativo web
var
  Tipo: String;
begin
  if DataSet = Q265 then
    Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = Q275 then
    Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString)
  // commessa MAN/02 - SVILUPPO 90.ini
  // applica il filtro dizionario sull'elenco richieste da importare
  // inclusa correzione chiamata <76068>
  else if Dataset = selT050 then
  begin
    Tipo:=IfThen(DataSet.FieldByName('TIPOCAUS').AsString = 'A','CAUSALI ASSENZA','CAUSALI PRESENZA');
    Accept:=(UpperCase(Parametri.RagioneSociale) = 'PROVINCIA DI VARESE') or
            (A000FiltroDizionario(Tipo,DataSet.FieldByName('CAUSALE').AsString));
  end;
  // commessa MAN/02 - SVILUPPO 90.fine
end;

procedure TA004FGiustifAssPresMW.selSG101FilterRecord(DataSet: TDataSet; var Accept: Boolean);
var D:TDateTime;
begin
  try
    D:=StrToDateDef(Var_DaData,0);
    Accept:=D <> 0;
  except
    D:=0;
    Accept:=False;
  end;
  Accept:=Accept and
         ((R180CarattereDef(VarToStr(Q265.Lookup('CODICE',Var_Causale,'CUMULO_FAMILIARI')),1,#0) in ['S','D'])
           or
          (R180CarattereDef(VarToStr(Q265.Lookup('CODICE',Var_Causale,'FRUIZIONE_FAMILIARI')),1,#0) in ['S','D']));
  if Accept then
  begin
    with R600DtM1.selSG101Causali do
    begin
      Accept:=False;
      if SearchRecord('NUMORD',Dataset.FieldByName('NUMORD').AsInteger,[srFromBeginning]) then
        repeat
          if (D >= FieldByName('DECORRENZA').AsDateTime) and (D <= FieldByName('DECORRENZA_FINE').AsDateTime) then
          begin
            Accept:=(Pos('<*>',FielDByName('CAUSALI_ABILITATE').AsString) > 0)
                    or
                   (Pos('<' + VarToStr(Var_Causale) + '>',FieldByName('CAUSALI_ABILITATE').AsString) > 0);
            Break;
          end;
        until not SearchRecord('NUMORD',Dataset.FieldByName('NUMORD').AsInteger,[]);
    end;
  end;
end;

procedure TA004FGiustifAssPresMW.Q040PostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
// Gestisco il progressivo causale sull'errore di chiave
begin
  if Copy(E.Message,1,9) = 'ORA-00001' then
  begin
    Q040.FieldByName('ProgrCausale').AsInteger:=Q040.FieldByName('ProgrCausale').AsInteger + 1;
    Action:=daRetry;
  end
  else
    Action:=daFail;
end;

procedure TA004FGiustifAssPresMW.Q040BAfterOpen(DataSet: TDataSet);
begin
  Q040B.FieldByName('NOTE').Visible:=Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S';
end;

procedure TA004FGiustifAssPresMW.Q040BCalcFields(DataSet: TDataSet);
var
  LTipoMG, LDTipoMG: String;
// Descrive il tipo di giustificativo
begin
  if Q265.Lookup('Codice',Q040B.FieldByName('Causale').AsString,'Codice') <> null then
    Q040B.FieldByName('D_TipoCausale').AsString:='Ass'
  else if Q275.Lookup('Codice',Q040B.FieldByName('Causale').AsString,'Codice') <> null then
    Q040B.FieldByName('D_TipoCausale').AsString:='Pres';

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  LTipoMG:=Q040B.FieldByName('CSI_TIPO_MG').AsString;
  if LTipoMG = 'M' then
    LDTipoMG:='Mattino'
  else if LTipoMG = 'P' then
    LDTipoMG:='Pomeriggio'
  else
    LDTipoMG:=LTipoMG;
  Q040B.FieldByName('D_CSI_TIPO_MG').AsString:=LDTipoMG;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
end;

procedure TA004FGiustifAssPresMW.Q040BFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('CAUSALI SUL CARTELLINO',DataSet.FieldByName('CAUSALE').AsString);
end;

procedure TA004FGiustifAssPresMW.T040DaOreSetText(Sender: TField; const Text: string);
begin
  {$I CampoOra}
end;

procedure TA004FGiustifAssPresMW.Q275AfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('CODICE').DisplayWidth:=8;
end;

procedure TA004FGiustifAssPresMW.selT050FiltroAllegati(Val:string);
var
  CodAllegato:string;
begin
  CodAllegato:='';
  if Val <> 'tutti' then
  begin
    if Val = 'con allegato' then
    begin
      CodAllegato:='>';
    end
    else if Val = 'senza allegato' then
    begin
      CodAllegato:='=';
    end;
    R180SetVariable(selT050,'FILTRO_ALLEGATI',Format('and T853F_NUMALLEGATI(T850.ID) %s 0', [CodAllegato]));
  end
  else
  begin
    R180SetVariable(selT050,'FILTRO_ALLEGATI',null);
  end;
  selT050.Open;
end;

procedure TA004FGiustifAssPresMW.selT050FiltroFiltroCondizAllegati(Val:string);
var
  CodCondizAllegati:string;
begin
  if Val <> 'tutti' then
  begin
    CodCondizAllegati:='';
    if Val = 'allegati non previsti' then
    begin
      CodCondizAllegati:='N';
    end
    else if Val = 'allegati facoltativi' then
    begin
      CodCondizAllegati:='F';
    end
    else if Val = 'allegati obbligatori' then
    begin
      CodCondizAllegati:='O';
    end;
    R180SetVariable(selT050,'FILTRO_CONDIZ_ALLEGATI',Format('and nvl(T850.CONDIZ_ALLEGATI,''N'') = ''%s''',[CodCondizAllegati]));
  end
  else
  begin
    R180SetVariable(selT050,'FILTRO_CONDIZ_ALLEGATI',null);
  end;
  selT050.Open;
end;

procedure TA004FGiustifAssPresMW.selT050CalcFields(DataSet: TDataSet);
var
  DescCaus: String;
begin
  // tipo giust.
  if selT050.FieldByName('TIPOGIUST').AsString = 'I' then
    selT050.FieldByName('TIPO').AsString:='Giornate'
  else if selT050.FieldByName('TIPOGIUST').AsString = 'M' then
    selT050.FieldByName('TIPO').AsString:='Mezze Giorn.'
  else if selT050.FieldByName('TIPOGIUST').AsString = 'N' then
    selT050.FieldByName('TIPO').AsString:='Num. ore'
  else if selT050.FieldByName('TIPOGIUST').AsString = 'D' then
    selT050.FieldByName('TIPO').AsString:='Da ore - a ore';

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  if selT050.FieldByName('CSI_TIPO_MG').AsString = 'M' then
    selT050.FieldByName('D_CSI_TIPO_MG').AsString:='Mattino'
  else if selT050.FieldByName('CSI_TIPO_MG').AsString = 'P' then
    selT050.FieldByName('D_CSI_TIPO_MG').AsString:='Pomeriggio'
  else
    selT050.FieldByName('D_CSI_TIPO_MG').AsString:=selT050.FieldByName('CSI_TIPO_MG').AsString;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

  // descrizione tipo richiesta
  if selT050.FieldByName('TIPO_RICHIESTA').AsString = 'D' then
  begin
    selT050.FieldByName('D_TIPO_RICHIESTA').AsString:='Definitiva';
  end
  else if selT050.FieldByName('TIPO_RICHIESTA').AsString = 'R' then
  begin
    selT050.FieldByName('D_TIPO_RICHIESTA').AsString:='Revoca';
  end
  else if selT050.FieldByName('TIPO_RICHIESTA').AsString = 'P' then
  begin
    selT050.FieldByName('D_TIPO_RICHIESTA').AsString:='Prev. ' +
      IfThen(selT050.FieldByName('AUTORIZZAZIONE').AsString = 'N','negata','revocata');
  end
  else if selT050.FieldByName('TIPO_RICHIESTA').AsString = 'C' then
  begin
    selT050.FieldByName('D_TIPO_RICHIESTA').AsString:='Cancellazione';
  end;

  // descr. causale
  DescCaus:=Trim(selT050.FieldByName('DESCRIZIONE').AsString);
  selT050.FieldByName('D_CAUSALE').AsString:=selT050.FieldByName('CAUSALE').AsString +
    IfThen(DescCaus <> '',' (' + DescCaus + ')');
end;

{ TRecapitoAlternativo }
procedure TRecapitoAlternativo.Clear;
// pulisce i dati del recapito alternativo per le visite fiscali
begin
  CodComune:='';
  DescComune:='';
  Cap:='';
  Indirizzo:='';
  Telefono:='';
  MedLegale:='';
  Note:='';
  TipoEsenzione:='';
  DataEsenzione:=0;
  OperatoreEsenzione:='';
end;

function TRecapitoAlternativo.GetAbilitato: Boolean;
begin
  Result:=FAbilitato;
end;

procedure TRecapitoAlternativo.SetAbilitato(const PValue: Boolean);
begin
  // se il recapito alternativo viene disabilitato pulisce i valori
  if not PValue then
    Clear;
  FAbilitato:=PValue;
end;

end.
