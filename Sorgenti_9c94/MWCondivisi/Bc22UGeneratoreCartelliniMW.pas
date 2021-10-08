unit Bc22UGeneratoreCartelliniMW;

interface

uses
  A000USessione,
  C180FunzioniGenerali,
  A000UCostanti, W009UStampaCartellinoDtm, Winapi.Windows,
  RegistrazioneLog, Oracle, OracleData, Vcl.Forms, Math,
  System.SysUtils, System.Classes, System.IOUtils, Data.DB, Variants, StrUtils,
  System.Generics.Collections, Winapi.ActiveX, Winapi.ShellAPI;

type
  TParametriAziendali = class
  public
    PathPdf: String;
    FilePdf: String;
    function ToString: String; override;
  end;

  TRigaMetadati = class
  private
    FNumRiga: Integer;       // numero_riga     = progressivo di riga impostato automaticamente (da 1 in avanti)
  public
    NomeFile: String;        // nomefile.pdf    = formato che cambia di giorno in giorno....pdf
    Ente:String;             // ente            = da T430
    Matricola: String;       // matricola       = da anagrafico
    Cognome: String;         // cognome         = da anagrafico
    Nome: String;            // nome            = da anagrafico
    CodFiscale: String;      // codice fiscale  = da anagrafico
    DataNascita: TDateTime;  // data nascita    = da anagrafico
    Email: String;           // e-mail          = da I060F_EMAIL, se non esiste indicare 'e'
    procedure SetNumRiga(const PValue: Integer);
    function ToString: String; override;
    property NumRiga: Integer read FNumRiga;
  end;

  TMetadatiMgr = class
  private
    LstRighe: TObjectList<TRigaMetadati>;
    function GetNextIdFlusso: Integer;
  public
    SessionBc22: TOracleSession;
    Azienda: String;
    CodAzienda: String;
    DescAzienda: String;
    MeseCartellino: TDateTime;
    NomeFileMetadati: String;
    NomeFileFinale: String;
    function AddRigaMetadati(PRiga: TRigaMetadati): Boolean;
    procedure ClearRigheMetadati;
    function GeneraFileMeta(var RErrMsg: String): Boolean;
    constructor Create;
    destructor Destroy; override;
  const
    NOME_FILE_METADATI = 'fileMetadati.txt';
  end;

  TDatiVistaVT860 = record
    Azienda: String;
    CodAzienda: String;
    DescAzienda: String;
    Ente: String;
    Progressivo: Integer;
    Matricola: String;
    Cognome: String;
    Nome: String;
    CodFiscale: String;
    DataNascita: TDateTime;
    Email: String;
    MeseCartellino: TDateTime;
    ParamCartellino: String;
  end;

  TBc22FGeneratoreCartelliniMW = class(TDataModule)
    selVT860: TOracleDataSet;
    selI091: TOracleDataSet;
    updT860: TOracleQuery;
    selVT860AZIENDA: TStringField;
    selVT860COD_AZIENDA: TStringField;
    selVT860DESC_AZIENDA: TStringField;
    selVT860PROGRESSIVO: TFloatField;
    selVT860MATRICOLA: TStringField;
    selVT860COGNOME: TStringField;
    selVT860NOME: TStringField;
    selVT860CODFISCALE: TStringField;
    selVT860DATANAS: TDateTimeField;
    selVT860EMAIL: TStringField;
    selVT860MESE_CARTELLINO: TDateTimeField;
    selVT860PARAM_CARTELLINO: TStringField;
    selVT860ENTE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSessioneOracleBc22: TOracleSession;
    RegistraMsg: TRegistraMsg;
    ParAziendaliList: TDictionary<String,TParametriAziendali>;
    W009DtM: TW009FStampaCartellinoDtm;
    procedure SetSessioneOracleBc22(const POracleSession: TOracleSession);
    procedure RiapriDataset;
    procedure EstraiParametriAziendali(const PAzienda: String; var RParAz: TParametriAziendali);
    function AddAndSetParamAziendali(const PAzienda: String; var RParAz: TParametriAziendali): Boolean;
    function _CtrlFilePdf(const PParFile: String; const PDatiVista: TDatiVistaVT860;
      var RFilePdfSost, RErrMsg: String): Boolean;
    function CreaCartellinoPDF(pSessioneOracle: TOracleSession; pProgressivo,
      pDal, pAl, Parametrizzazione, FilePdf,
      CartelliniChiusi: WideString): WideString;
    function EstraiSessioneOracle(const DB, Azienda: WideString): Integer;
    function GetSessioneOracle(LogonDB, LogonUsr, LogonPwd: String): Integer;
  public
    lstSessioniOracle:array of TOracleSession;
    function  ControlloConnessioneDatabase: Boolean;
    procedure ConnettiDataBase(const PAlias: String);
    function  CtrlPathPdf(const PPath: String; var RErrMsg: String): Boolean;
    function  CtrlFilePdf(const PParFilePdf: String; var RErrMsg: String): Boolean;
    function  GetNomeFilePdf(const PParFilePdf: String; const PDatiVista: TDatiVistaVT860): String;
    procedure GeneraPdf;
    procedure EseguiBatchPostElaborazione(const PBaseDir: String; const PNomeFile: String);
    property SessioneOracleBc22: TOracleSession read FSessioneOracleBc22 write SetSessioneOracleBc22;
  end;

var
  CSStampa, CSStampaCartellino: TmedpCriticalSection;

const
  // modificare con cognizione di causa
  Bc22_MASCHERA                   = 'Bc22';
  Bc22_SERVICE_NAME               = 'Bc22FGENERATORECARTELLINISRV';
  Bc22_SERVICE_EXE                = 'Bc22PGENERATORECARTELLINISRV.exe';
  Bc22_ORACLE_SESSION_TAG_DESTROY = -1000;

implementation

uses A000UInterfaccia;

{$R *.dfm}

procedure TBc22FGeneratoreCartelliniMW.DataModuleCreate(Sender: TObject);
begin
  // istanzia sessione oracle propria
  FSessioneOracleBc22:=TOracleSession.Create(Self);
  FSessioneOracleBc22.Tag:=Bc22_ORACLE_SESSION_TAG_DESTROY;

  // istanzia oggetto per registrazione log
  RegistraMsg:=TRegistraMsg.Create(FSessioneOracleBc22);

  // istanzia dictionary per parametri aziendali
  ParAziendaliList:=TDictionary<String,TParametriAziendali>.Create;
end;

procedure TBc22FGeneratoreCartelliniMW.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
  // chiusura dei dataset
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleDataSet then
    begin
      TOracleDataSet(Components[i]).CloseAll;
    end;
  end;

  // distruzione oggetti
  FreeAndNil(RegistraMsg);
  FreeAndNil(ParAziendaliList);
  if Assigned(FSessioneOracleBc22) and (FSessioneOracleBc22.Tag = Bc22_ORACLE_SESSION_TAG_DESTROY) then
    FreeAndNil(FSessioneOracleBc22);

  // distruzione lista sessioni oracle
  for i:=0 to High(lstSessioniOracle) do
  begin
    FreeAndNil(lstSessioniOracle[i]);
  end;
end;

procedure TBc22FGeneratoreCartelliniMW.SetSessioneOracleBc22(const POracleSession: TOracleSession);
// se si imposta una sessione oracle distrugge quella eventualmente creata
begin
  if FSessioneOracleBc22 <> nil then
    FreeAndNil(FSessioneOracleBc22);
  FSessioneOracleBc22:=POracleSession;
end;

procedure TBc22FGeneratoreCartelliniMW.ConnettiDataBase(const PAlias: String);
// connessione al db specificato nel parametro
var
  i: Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleDataSet then
    begin
      // dataset: assegna sessione oracle
      if (Components[i] as TOracleDataSet).Session = nil then
        (Components[i] as TOracleDataSet).Session:=FSessioneOracleBc22;
    end
    else if Components[i] is TOracleQuery then
    begin
      // oracle query
      // assegna sessione oracle
      if (Components[i] as TOracleQuery).Session = nil then
        (Components[i] as TOracleQuery).Session:=FSessioneOracleBc22;
    end
    else if Components[i] is TOracleScript then
    begin
      // oracle script
      // assegna sessione oracle
      if (Components[i] as TOracleScript).Session = nil then
        (Components[i] as TOracleScript).Session:=FSessioneOracleBc22;
    end;
  end;

  // verifica che la sessione oracle sia correttamente connessa
  if not FSessioneOracleBc22.Connected then
  begin
    FSessioneOracleBc22.LogonDatabase:=PAlias;
    A000LogonDBOracle(FSessioneOracleBc22);
  end;

  // apertura dei dataset
  if FSessioneOracleBc22.Connected then
    RiapriDataset;
end;

function TBc22FGeneratoreCartelliniMW.ControlloConnessioneDatabase:Boolean;
// verifica la connessione al db, se necessario rieffettua la connessione
// e quindi riapre i dataset
var
  CR: TCheckConnectionResult;
  ErrMsg: String;
const
  FUNC_NAME = 'TBc22FGeneratoreCartelliniMW.ControlloConnessioneDatabase';
  ERR_MSG   = FUNC_NAME + '[%s] - %s: %s (%s)';
begin
  if not FSessioneOracleBc22.Connected then
  begin
    try
      FSessioneOracleBc22.LogOn;
      RiapriDataset;
    except
      on E: Exception do
      begin
        ErrMsg:='Errore di connessione al db (tentativo 1/3)';
        RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[FSessioneOracleBc22.LogonDatabase,ErrMsg,E.Message,E.ClassName]));
      end;
    end;
  end;

  CR:=FSessioneOracleBc22.CheckConnection(True);
  case CR of
    ccError:
      begin
        ErrMsg:='Errore di connessione al db (tentativo 2/3)';
        RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[FSessioneOracleBc22.LogonDatabase,ErrMsg,'CheckConnection fallita','ccError']));
        try
          FSessioneOracleBc22.LogOff;
          FSessioneOracleBc22.LogOn;
          RiapriDataset;
        except
          on E: Exception do
          begin
            ErrMsg:='Errore di connessione al db (tentativo 3/3)';
            RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[FSessioneOracleBc22.LogonDatabase,ErrMsg,E.Message,E.ClassName]));
          end;
        end;
      end;
    ccReconnected:
      begin
        RiapriDataset;
      end;
  end;

  // restituisce lo stato di connessione
  Result:=FSessioneOracleBc22.Connected;
end;

procedure TBc22FGeneratoreCartelliniMW.RiapriDataset;
// effettua close e open di tutti i dataset presenti
var
  i: Integer;
begin
  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TOracleDataSet then
    begin
      try
        TOracleDataSet(Components[i]).Close;
        TOracleDataSet(Components[i]).Open;
      except
        on E:Exception do
        begin
          RegistraMsg.InserisciMessaggio('A',Format('%s (%s)',[E.Message,E.ClassName]));
          raise;
        end;
      end;
    end;
  end;
end;

function TBc22FGeneratoreCartelliniMW.GetSessioneOracle(LogonDB,LogonUsr,LogonPwd:String):Integer;
var i,k:Integer;
begin
  Result:=-1;
  for i:=0 to High(lstSessioniOracle) do
    if (lstSessioniOracle[i].LogonDatabase = LogonDB) and
       (lstSessioniOracle[i].LogonUserName = LogonUsr) and
       (lstSessioniOracle[i].LogonPassword = LogonPwd) then
    begin
      Result:=i;
      Break;
    end;
  if Result = -1 then
  begin
    SetLength(lstSessioniOracle,Length(lstSessioniOracle) + 1);
    Result:=High(lstSessioniOracle);
    k:=Result;
    lstSessioniOracle[k]:=TOracleSession.Create(nil);
    lstSessioniOracle[k].LogonDatabase:=LogonDB;
    lstSessioniOracle[k].LogonUserName:=LogonUsr;
    lstSessioniOracle[k].LogonPassword:=LogonPwd;
    lstSessioniOracle[k].NullValue:=nvNull;
    lstSessioniOracle[k].Preferences.ZeroDateIsNull:=False;
    lstSessioniOracle[k].Preferences.TrimStringFields:=False;
    lstSessioniOracle[k].Preferences.UseOCI7:=False;
    lstSessioniOracle[k].ThreadSafe:=True;
    lstSessioniOracle[k].Name:='SessioneOracleBc22_' + IntToStr(k);
    lstSessioniOracle[k].Logon;
  end;
end;

function TBc22FGeneratoreCartelliniMW.EstraiSessioneOracle(const DB, Azienda: WideString): Integer;
var
  x: Integer;
  LogonDB,LogonUsr,LogonPwd:WideString;
begin
  //Cerco la sessione oracle corrispondente a DB e Azienda specificati
  LogonDB:=DB;
  if LogonDB = '' then
    LogonDB:=R180GetRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'Database','IRIS');
  LogonUsr:='MONDOEDP';
  LogonPwd:=A000GetPassword;
  x:=GetSessioneOracle(LogonDB,LogonUsr,LogonPwd);
  if x = -1 then
    raise Exception.Create('Connessione al db MONDOEDP non riuscita');
  with TOracleQuery.Create(nil) do
  try
    Session:=lstSessioniOracle[x];
    SQL.Text:='select UTENTE,PAROLACHIAVE from I090_ENTI where AZIENDA = ''' + Azienda + '''';
    Execute;
    LogonUsr:=FieldAsString(0);
    LogonPwd:=R180Decripta(FieldAsString(1),21041974);
  finally
    Free;
  end;
  Result:=GetSessioneOracle(LogonDB,LogonUsr,LogonPwd);
end;

procedure TBc22FGeneratoreCartelliniMW.EstraiParametriAziendali(const PAzienda: String;
  var RParAz: TParametriAziendali);
// legge da db i parametri dell'azienda indicata e li imposta nel record indicato
// PRE: RParAz deve essere istanziato
begin
  if RParAz = nil then
    raise Exception.Create('Parametro RParAz nullo!');

  selI091.Close;
  selI091.SetVariable('AZIENDA',PAzienda);
  selI091.Open;
  if selI091.RecordCount > 0 then
  begin
    RParAz.PathPdf:=VarToStr(selI091.Lookup('TIPO','C90_W009PATH_PDF','DATO'));
    RParAz.FilePdf:=VarToStr(selI091.Lookup('TIPO','C90_W009FILE_PDF','DATO'));
  end;
end;

function TBc22FGeneratoreCartelliniMW.AddAndSetParamAziendali(const PAzienda: String;
  var RParAz: TParametriAziendali): Boolean;
// verifica se i parametri per l'azienda indicata sono già presenti nel dictionary
// in alternativa li legge da db (tabella I091 di MONDOEDP)
// valorizza la variabile RParAz con i valori dei parametri
// restituisce True se i parametri sono stati aggiunti al dictionary
// oppure False altrimenti
begin
  if RParAz = nil then
    raise Exception.Create('Parametro RParAz nullo!');

  if ParAziendaliList.ContainsKey(PAzienda) then
  begin
    // estrae i dati dal dictionary
    ParAziendaliList.TryGetValue(PAzienda,RParAz);
    Result:=False;
  end
  else
  begin
    // estrae i dati da db e quindi li aggiunge al dictionary
    EstraiParametriAziendali(PAzienda,RParAz);
    ParAziendaliList.Add(PAzienda,RParAz);
    Result:=True;
  end;
end;

function TBc22FGeneratoreCartelliniMW.CtrlPathPdf(const PPath: String; var RErrMsg: String): Boolean;
// controlla il path di destinazione per i file pdf indicato come parametro aziendale
// se il path non esiste lo crea
begin
  Result:=False;
  RErrMsg:='';

  // controllo indicazione path
  if PPath.Trim = '' then
  begin
    RErrMsg:='la directory per i file pdf dei cartellini non è indicata!';
    Exit;
  end;

  // controllo esistenza path
  if not TDirectory.Exists(PPath) then
  begin
    // path inesistente: prova a crearlo
    try
      TDirectory.CreateDirectory(PPath);
    except
      on E: Exception do
      begin
        RErrMsg:='la directory per i file pdf dei cartellini non è accessibile!';
        Exit;
      end;
    end;
  end;

  // controllo permessi scrittura
  if not R180IsDirectoryWritable(PPath) then
  begin
    RErrMsg:='la directory per i file pdf dei cartellini non è accessibile in scrittura!';
    Exit;
  end;

  // tutti i controlli ok
  Result:=True;
end;

function TBc22FGeneratoreCartelliniMW._CtrlFilePdf(const PParFile: String;
  const PDatiVista: TDatiVistaVT860; var RFilePdfSost, RErrMsg: String): Boolean;
// verifica la sintassi file indicato e restituisce:
// - True
//     se la sintassi è ok
// - False
//     se ci sono errori (nel caso, valorizza RErrMsg con l'errore riscontrato)
// il nome file può contenere le seguenti variabili:
//   :AZIENDA
//   :PROGRESSIVO
//   :MATRICOLA
//   :MESE_CARTELLINO
//   :PARAM_CARTELLINO
var
  OQ: TOracleQuery;
  Src: String;
begin
  Result:=False;
  RFilePdfSost:=PParFile;
  RErrMsg:='';

  // utilizza una query del tipo "select [PParFile] from dual"
  // per verificare la sintassi del nome file
  Src:=PParFile.ToUpper;
  OQ:=TOracleQuery.Create(nil);
  try
    try
      OQ.Session:=FSessioneOracleBc22;

      // stringa da estrarre
      OQ.DeclareVariable('S',otSubst);
      OQ.SetVariable('S',PParFile);

      // ricerca variabili conosciute
      // azienda
      if Pos(':AZIENDA',Src) > 0 then
      begin
        OQ.DeclareVariable('AZIENDA',otString);
        OQ.SetVariable('AZIENDA',PDatiVista.Azienda);
      end;
      // progressivo
      if Pos(':PROGRESSIVO',Src) > 0 then
      begin
        OQ.DeclareVariable('PROGRESSIVO',otInteger);
        OQ.SetVariable('PROGRESSIVO',PDatiVista.Progressivo)
      end;
      // matricola
      if Pos(':MATRICOLA',Src) > 0 then
      begin
        OQ.DeclareVariable('MATRICOLA',otString);
        OQ.SetVariable('MATRICOLA',PDatiVista.Matricola);
      end;
      // mese cartellino
      if Pos(':MESE_CARTELLINO',Src) > 0 then
      begin
        OQ.DeclareVariable('MESE_CARTELLINO',otDate);
        OQ.SetVariable('MESE_CARTELLINO',PDatiVista.MeseCartellino);
      end;
      // parametrizzazione cartellino
      if Pos(':PARAM_CARTELLINO',Src) > 0 then
      begin
        OQ.DeclareVariable('PARAM_CARTELLINO',otString);
        OQ.SetVariable('PARAM_CARTELLINO',PDatiVista.ParamCartellino);
      end;

      // esegue query
      OQ.SQL.Text:='select :S from DUAL';
      OQ.Execute;
      RFilePdfSost:=OQ.FieldAsString(0);
      Result:=True;
    except
      on E:Exception do
      begin
        RErrMsg:=Format('Errore nella sintassi del parametro aziendale "Web: nome file pdf per servizio stampa cartellini": %s (%s)',[E.Message,E.ClassName]);
        Exit;
      end;
    end;
  finally
    FreeAndNil(OQ);
  end;
end;

function TBc22FGeneratoreCartelliniMW.CtrlFilePdf(const PParFilePdf: String;
  var RErrMsg: String): Boolean;
// restituisce True se il parametro aziendale relativo al nome file pdf
// - è corretto a livello sintattico
// - e contiene solo variabili conosciute
// oppure False altrimenti
var
  DatiTest: TDatiVistaVT860;
  TempStr: String;
begin
  // controlla il nome file pdf utilizzando dati fittizi (ma sintatticamente ok)
  // per la sostituzione variabili
  DatiTest.Azienda:='AAA';
  DatiTest.Progressivo:=5000;
  DatiTest.Matricola:='99999999';
  DatiTest.MeseCartellino:=R180InizioMese(Date);
  DatiTest.ParamCartellino:='TEST';

  Result:=_CtrlFilePdf(PParFilePdf,DatiTest,TempStr,RErrMsg);
end;

function TBc22FGeneratoreCartelliniMW.GetNomeFilePdf(const PParFilePdf: String;
  const PDatiVista: TDatiVistaVT860): String;
// restituisce il nome file pdf sostituendo i dati variabili con i valori del record
// attuale della vista specificato in PDatiVista
var
  ErrMsg: String;
begin
  // sostituisce le eventuali variabili contenute nel nome
  // con i valori del record attuale della vista
  if not _CtrlFilePdf(PParFilePdf,PDatiVista,Result,ErrMsg) then
    raise Exception.Create(ErrMsg);
end;

function TBc22FGeneratoreCartelliniMW.CreaCartellinoPDF(pSessioneOracle:TOracleSession;
  pProgressivo,pDal,pAl,Parametrizzazione,FilePdf,CartelliniChiusi: WideString): WideString;
// Stessa procedura utilizzata in IrisWEB in W009UStampaCartellino
var DataI,DataF:TDateTime;
    A,M,G,A2,M2,G2:Word;
    iSQL:Integer;
    S,SQLText:String;
    CodiceT950:String;
    lst:TStringList;
    FS:TFormatSettings;
    PathModelliRave: String;
const
  RAVE_MODEL_REL_PATH   = 'wwwroot\report';
  RAVE_MODEL_CARTELLINO = 'W009StampaCartellino.rav';
begin
  Result:='';
  // bugfix.ini:
  // verifica e impostazione path modelli corretto
  PathModelliRave:=R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME','C:\IrisWIN');
  PathModelliRave:=IncludeTrailingPathDelimiter(PathModelliRave) + RAVE_MODEL_REL_PATH;
  if not TDirectory.Exists(PathModelliRave) then
  begin
    Result:=Format('Il path dei modelli di stampa indicato è invalido o non accessibile: "%s". Verificare la variabile di ambiente HKLM\Software\IrisWin\HOME',[PathModelliRave]);
    exit;
  end;
  // bugfix.fine

  {$WARN SYMBOL_PLATFORM OFF}
  FS:=TFormatSettings.Create(MAKELCID(MAKELANGID(LANG_ITALIAN, SUBLANG_ITALIAN), SORT_DEFAULT));  //non serve fare il free
  {$WARN SYMBOL_PLATFORM ON}
  FS.ShortDateFormat:='dd/mm/yyyy';
  Parametri.WEBCartelliniDataMin:=0;
  Parametri.WEBCartelliniMMPrec:=-1;
  Parametri.WEBCartelliniMMSucc:=-1;
  W009DtM.Sessione:=pSessioneOracle;
  W009DtM.selAnagrafeW:=W009DtM.selAnagrafeProgr;
  W009DtM.selAnagrafeW.Session:=pSessioneOracle;
  W009DtM.CartelliniChiusi:=CartelliniChiusi = 'S';
  W009DtM.Stampa:=True;
  W009DtM.RegLog:=False;
  W009DtM.RaveProjectFile:=IncludeTrailingPathDelimiter(PathModelliRave) + RAVE_MODEL_CARTELLINO;
  W009DtM.NomeFile:=FilePDF;
  W009DtM.RaveOutputFileName:=FilePDF;
  DataI:=StrToDate(pDal,FS);
  DataF:=StrToDate(pAl,FS);
  if DataF < DataI then
  begin
    Result:='Date non corrette!';
    exit;
  end;
  if R180Anno(DataI) <> R180Anno(DataF) then
  begin
    Result:='Le date devono essere riferite allo stesso anno!';
    exit;
  end;
  if DataI < Parametri.WEBCartelliniDataMin then
  begin
    Result:=Format('Non è possibile elaborare il cartellino prima del %s!',[DateToStr(Parametri.WEBCartelliniDataMin)]);
    exit;
  end;
  if (Parametri.WEBCartelliniMMPrec >= 0) and (R180AddMesi(R180InizioMese(DataI),Parametri.WEBCartelliniMMPrec) < R180InizioMese(Date)) then
  begin
    Result:=Format('Non è possibile elaborare il cartellino antecedente di %d mesi!',[Parametri.WEBCartelliniMMPrec]);
    exit;
  end;
  if (Parametri.WEBCartelliniMMSucc >= 0) and (R180InizioMese(DataF) > R180AddMesi(R180InizioMese(Date),Parametri.WEBCartelliniMMSucc)) then
  begin
    Result:=Format('Non è possibile elaborare il cartellino successivo a %d mesi!',[Parametri.WEBCartelliniMMSucc]);
    exit;
  end;
  SQLText:=W009DtM.selAnagrafeW.SQL.Text;
  CodiceT950:=Parametrizzazione;
  DecodeDate(DataI,A,M,G);
  DecodeDate(DataF,A2,M2,G2);
  //Se le date differiscono di mese o di anno, allora i giorni vanno
  //da 1 all'ultimo del mese
  if (M <> M2) or (A <> A2) then
  begin
    G:=1;
    G2:=R180GiorniMese(DataF);
    DataI:=EncodeDate(A,M,G);
    DataF:=EncodeDate(A2,M2,G2);
    pDal:=DateToStr(DataI);
    pAl:=DateToStr(DataF);
  end;
  try
    W009DtM.CreazioneR400(pSessioneOracle); //W009FStampaCartellinoDtm.W009FStampaCartellinoDtM.R400FCartellinoDtM:=TW009FStampaCartellinoDtM.R400FCartellinoDtM.Create(Self);
    W009DtM.R400FCartellinoDtM.R450DtM1.Name:=''; //Altrimenti duplicazione sul nome quando viene creata la R450 dalla R600 per i conteggi di alcune assenze
    W009DtM.R400FCartellinoDtM.R600DtM1.Name:='';
    W009DtM.R400FCartellinoDtM.R410FAutoGiustificazioneDtM.Name:='';
  except
    on E:Exception do
    begin
      Result:=E.Message;
      exit;
    end;
  end;
  //RegistraMsg.IniziaMessaggio('W009');
  if False then
    W009DtM.CreazioneR350;
  if False then
    W009DtM.CreazioneR300(DataI,DataF);
  try
    try
      with W009DtM.R400FCartellinoDtM.Q950Int do
      begin
        Close;
        SetVariable('Codice',CodiceT950);
        Open;
      end;
      W009DtM.R400FCartellinoDtM.selDatiBloccati.Close;
      W009DtM.R400FCartellinoDtM.SoloAggiornamento:=False;
      W009DtM.R400FCartellinoDtM.AggiornamentoScheda:=False;
      W009DtM.R400FCartellinoDtM.AutoGiustificazione:=False;
      W009DtM.R400FCartellinoDtM.CalcoloCompetenze:=False;
      W009DtM.R400FCartellinoDtM.lstDettaglio.Clear;
      W009DtM.R400FCartellinoDtM.lstRiepilogo.Clear;
      W009DtM.R400FCartellinoDtM.LeggiDatiRichiesti('Intestazione');
      W009DtM.R400FCartellinoDtM.LeggiDatiRichiesti('Dettaglio');
      W009DtM.R400FCartellinoDtM.LeggiDatiRichiesti('Riepilogo');
      //W009DtM.selAnagrafeW.SetVariable('MATRICOLA',pMatricola);
      W009DtM.selAnagrafeW.SetVariable('PROGRESSIVO',pProgressivo);
      W009DtM.selAnagrafeW.SetVariable('DATALAVORO',DataF);
      W009DtM.selAnagrafeW.Close;
      if (Pos(W009DtM.R400FCartellinoDtM.CampiIntestazione,W009DtM.SelAnagrafeW.SQL.Text) = 0) and
         ((Pos('T030.*',W009DtM.SelAnagrafeW.SQL.Text) = 0) or (Pos('V430.*',W009DtM.SelAnagrafeW.SQL.Text) = 0)) then
      begin
        S:=W009DtM.SelAnagrafeW.SQL.Text;
        iSQL:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');
        if iSQL > 0 then
          Insert(',' + W009DtM.R400FCartellinoDtM.CampiIntestazione + ' ',S,iSQL);
        W009DtM.SelAnagrafeW.SQL.Text:=S;
      end;
      W009DtM.selAnagrafeW.Open;
      lst:=TStringList.Create;
      with W009DtM.R400FCartellinoDtM do
      try
        SetLength(VetDatiLiberiSQL,0);
        selT951.Close;
        selT951.SetVariable('Codice',Q950Int.FieldByName('CODICE').AsString);
        selT951.Open;
        while not selT951.Eof do
        begin
          lst.Add(Trim(selT951.FieldByName('RIGA').AsString));
          selT951.Next;
        end;
        selT951.Close;
        W009DtM.GetLabels(lst,'Riepilogo2001',nil);
        //Devo già avere l'elenco dei dati liberi 2001
        CreaClientDataSet(W009DtM.selAnagrafeW);
      finally
        lst.Free;
      end;
      W009DtM.R400FCartellinoDtM.A027SelAnagrafe:=W009DtM.selAnagrafeW;
      //Posizionamento sulla matricola correntemente selezionata
      //if W009DtM.selAnagrafeW.SearchRecord('MATRICOLA',pMatricola,[srFromBeginning]) then
      if W009DtM.selAnagrafeW.SearchRecord('PROGRESSIVO',pProgressivo,[srFromBeginning]) then
      begin
        //Result:=W009DtM.CalcoloCartellini(A,M,G,A2,M2,G2)
        Result:=W009DtM.R400FCartellinoDtM.CalcoloCartelliniWeb(W009DtM.selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,
                                                                                     A,M,G,A2,M2,G2,
                                                                                     W009DtM.CartelliniChiusi,
                                                                                     W009DtM.Stampa,
                                                                                     W009DtM.RegLog);
      end
      else
      begin
        //GetDipendentiDisponibili(DataF);
        Result:='Anagrafico non disponibile!';
        Abort;
      end;
      W009DtM.ChiusuraQuery(W009DtM.R400FCartellinoDtM);
      with W009DtM.R400FCartellinoDtM do
      begin
        //Chiudo subito le query e le unit dei conteggi, salvo Q950Int che serve in stampa
        Q950Int.Open;
        W009DtM.ChiusuraQuery(R450DtM1);
        FreeAndNil(W009DtM.R400FCartellinoDtM.R450DtM1);
        FreeAndNil(W009DtM.R400FCartellinoDtM.R600DtM1);
      end;
      try
       if W009DtM.R400FCartellinoDtM.cdsRiepilogo.RecordCount > 0 then
       begin
         W009DtM.W009CSStampa:=CSStampa;
         W009DtM.RPDefine_DataID(Bc22_MASCHERA);
         Result:=W009DtM.EsecuzioneStampa;
       end
       else
         Result:='Nessun cartellino disponibile nel periodo specificato!';
      except
        on E:Exception do
          Result:=E.Message;
      end;
      with W009DtM.R400FCartellinoDtM do
      begin
        cdsRiepilogo.Close;
        cdsDettaglio.Close;
        cdsSettimana.Close;
        cdsAssenze.Close;
        cdsPresenze.Close;
        Q950Int.CloseAll;
      end;
    finally
      W009DtM.R400FCartellinoDtM.Q950Int.CloseAll;
      W009DtM.selAnagrafeW.CloseAll;
      //W009FStampaCartellinoDtm.selAnagrafeW.SQL.Text:=SQLText;
      if W009DtM.R400FCartellinoDtM <> nil then
      begin
        W009DtM.R400FCartellinoDtM.Q950Int.CloseAll;
        W009DtM.R400FCartellinoDtM.A027SelAnagrafe:=nil;
        if W009DtM.R400FCartellinoDtM.R300DtM <> nil then
          FreeAndNil(W009DtM.R400FCartellinoDtM.R300DtM);
        if W009DtM.R400FCartellinoDtM.R350DtM <> nil then
          FreeAndNil(W009DtM.R400FCartellinoDtM.R350DtM);
        FreeAndNil(W009DtM.R400FCartellinoDtM);
      end;
      //W009FStampaCartellinoDtm.selAnagrafeW.Open;
      W009DtM.DistruggiLstRaveComp;
      FreeAndNil(W009DtM);
    end;
  except
    on E:Exception do
      Result:=E.Message;
  end;
end;

procedure TBc22FGeneratoreCartelliniMW.GeneraPdf;
// genera i cartellini in formato pdf
// segnala le eventuali anomalie su database attraverso RegistraMsg
var
  DatiVista: TDatiVistaVT860;
  OldAzienda: String;
  OldCodAzienda: String;
  OldDescAzienda: String;
  OldMeseCartellino: TDateTime;
  Dal: TDateTime;
  Al: TDateTime;
  DalStr: String;
  AlStr: String;
  FilePdfOutput: String;
  MetadatiMgr: TMetadatiMgr;
  RigaMetadati: TRigaMetadati;
  InfoMsg: String;
  ErrMsg: String;
  LParAziendali: TParametriAziendali;
  TempoIni: TDateTime;
  k: Integer;
  LPadding: Integer;
  InfoAvanzamento: string;
  AziendaCorr: String;
const
  FUNC_NAME       = 'TBc22FGeneratoreCartelliniMW.GeneraPdf';
  ERR_MSG         = FUNC_NAME + ' - %s: %s (%s)';
  INFO_MSG        = FUNC_NAME + ': %s';
begin
  TempoIni:=Now;

  // log avvio elaborazione
  RegistraMsg.IniziaMessaggio('Bc22');
  InfoMsg:='avvio elaborazione';
  RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));

  ParAziendaliList.Clear;
  LParAziendali:=TParametriAziendali.Create;
  try
    // apre il dataset della vista personalizzata VT860_CARTELLINI_PDF
    // in caso di errore nella vista termina immediatamente
    try
      selVT860.Close;
      selVT860.Open;
      InfoMsg:=Format('vista personalizzata VT860_CARTELLINI_PDF ok: %d record da elaborare',[selVT860.RecordCount]);
      RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
    except
      on E: Exception do
      begin
        ErrMsg:='vista personalizzata VT860_CARTELLINI_PDF invalida oppure non definita';
        RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg,E.Message,E.ClassName]));
        Exit;
      end;
    end;

    // verifica se la vista contiene richieste da considerare
    if selVT860.RecordCount = 0 then
    begin
      // nessuna richiesta: elaborazione non necessaria
      InfoMsg:='elaborazione non necessaria';
      RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
    end
    else
    begin
      // operazioni iniziali
      MetadatiMgr:=TMetadatiMgr.Create;
      // sessione di mondoedp
      MetadatiMgr.SessionBc22:=SessioneOracleBc22;

      // 1. scorre una prima volta la vista per controllare i parametri
      //    path e nome file per ogni azienda
      //    in caso di errore nei parametri termina immediatamente
      InfoMsg:='verifica dei parametri aziendali: inizio';
      RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
      selVT860.First;
      while not selVT860.Eof do
      begin
        // se i parametri per l'azienda non sono ancora stati determinati
        // li estrae e li verifica
        AziendaCorr:=selVT860.FieldByName('AZIENDA').AsString;
        if AddAndSetParamAziendali(AziendaCorr,LParAziendali) then
        begin
          InfoMsg:=Format('parametri aziendali: %s',[LParAziendali.ToString]);
          RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]),AziendaCorr);
          // controlli sul path di destinazione per i file
          if not CtrlPathPdf(LParAziendali.PathPdf,ErrMsg) then
          begin
            RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg,LParAziendali.PathPdf,'Verificare il parametro aziendale "Web: path per i file pdf dei cartellini"']),AziendaCorr);
            Exit;
          end;
          LParAziendali.PathPdf:=IncludeTrailingPathDelimiter(LParAziendali.PathPdf);

          // controlli sulla sintassi del nome file pdf
          if not CtrlFilePdf(LParAziendali.FilePdf,ErrMsg) then
          begin
            RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg,LParAziendali.FilePdf,'']),AziendaCorr);
            Exit;
          end;
        end;
        selVT860.Next;
      end;
      InfoMsg:='verifica dei parametri aziendali: completata correttamente';
      RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));

      // 2. scorre la vista personalizzata VT860_CARTELLINI_PDF per generare i cartellini
      //    dei dipendenti nel path parametrizzato a livello aziendale
      OldAzienda:='';
      OldCodAzienda:='';
      OldDescAzienda:='';
      OldMeseCartellino:=DATE_NULL;
      k:=-1;

      InfoMsg:='produzione dei cartellini: inizio';
      RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
      selVT860.First;
      while not selVT860.Eof do
      begin
        // imposta variabili per gestione
        DatiVista.Azienda:=selVT860.FieldByName('AZIENDA').AsString;
        DatiVista.CodAzienda:=selVT860.FieldByName('COD_AZIENDA').AsString;
        DatiVista.DescAzienda:=selVT860.FieldByName('DESC_AZIENDA').AsString;
        DatiVista.Ente:=selVT860.FieldByName('ENTE').AsString;
        DatiVista.Progressivo:=selVT860.FieldByName('PROGRESSIVO').AsInteger;
        DatiVista.Matricola:=selVT860.FieldByName('MATRICOLA').AsString;
        DatiVista.Cognome:=selVT860.FieldByName('COGNOME').AsString;
        DatiVista.Nome:=selVT860.FieldByName('NOME').AsString;
        DatiVista.CodFiscale:=selVT860.FieldByName('CODFISCALE').AsString;
        DatiVista.DataNascita:=selVT860.FieldByName('DATANAS').AsDateTime;
        DatiVista.Email:=selVT860.FieldByName('EMAIL').AsString;
        DatiVista.MeseCartellino:=selVT860.FieldByName('MESE_CARTELLINO').AsDateTime;
        Dal:=DatiVista.MeseCartellino;
        DalStr:=DateToStr(Dal);
        Al:=R180FineMese(Dal);
        AlStr:=DateToStr(Al);
        DatiVista.ParamCartellino:=selVT860.FieldByName('PARAM_CARTELLINO').AsString;

        // gestione cambio di azienda
        if (DatiVista.Azienda <> OldAzienda) then
        begin
          // legge i parametri per l'azienda (il dictionary è già stato caricato
          // in precedenza, quindi non effettua più accessi al db)
          AddAndSetParamAziendali(DatiVista.Azienda,LParAziendali);

          // imposta il nome del file di metadati sul manager
          MetadatiMgr.NomeFileMetadati:=IncludeTrailingPathDelimiter(LParAziendali.PathPdf) + TMetadatiMgr.NOME_FILE_METADATI;

          // connessione oracle all'utente dell'azienda specifica
          k:=EstraiSessioneOracle(FSessioneOracleBc22.LogonDatabase,DatiVista.Azienda);
          if k = -1 then
          begin
            ErrMsg:='Connessione al db dell''azienda non riuscita';
            RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg,FSessioneOracleBc22.LogonDatabase,'']),DatiVista.Azienda);
            Exit;
          end;
        end;

        // gestione rottura di azienda / mese
        // scrive il file dei metadati ed esegue la post-elaborazione su batch
        if (selVT860.RecNo > 1) and
           ((DatiVista.Azienda <> OldAzienda) or
            (DatiVista.MeseCartellino <> OldMeseCartellino)) then
        begin
          // genera il file di metadati
          if MetadatiMgr.GeneraFileMeta(ErrMsg) then
          begin
            InfoMsg:=Format('file dei metadati di %s salvato in %s',[FormatDateTime('mmmm yyyy',OldMeseCartellino),MetadatiMgr.NomeFileMetadati]);
            RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]),OldAzienda);
          end
          else
          begin
            ErrMsg:=Format('mese di %s: %s',[ErrMsg]);
            RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg,LParAziendali.FilePdf,'']),OldAzienda);
          end;

          // esegue l'eventuale contenuto del batch di post-elaborazione
          EseguiBatchPostElaborazione(LParAziendali.PathPdf,MetadatiMgr.NomeFileFinale);
        end;

        // determina il nome del file pdf del cartellino
        FilePdfOutput:=GetNomeFilePdf(LParAziendali.FilePdf,DatiVista);
        FilePdfOutput:=IncludeTrailingPathDelimiter(LParAziendali.PathPdf) + FilePdfOutput;

        // info log
        LPadding:=Trunc(R180Arrotonda(Math.Log10(selVT860.RecordCount),1,'E'));
        InfoAvanzamento:=Format('%.*d/%.*d -',[LPadding,selVT860.Recno,LPadding,selVT860.RecordCount]);
        InfoMsg:=Format('%s matr. %s, %s, param. %s',
                        [InfoAvanzamento,DatiVista.Matricola,FormatDateTime('mmmm yyyy',Dal),DatiVista.ParamCartellino]);
        RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]),DatiVista.Azienda,DatiVista.Progressivo);

        try
          // a. genera il cartellino pdf
          CSStampaCartellino.Enter;
          try
            W009Dtm:=TW009FStampaCartellinoDtm.Create(lstSessioniOracle[k]);
            //ErrMsg:=CreaCartellinoPDF(lstSessioniOracle[k],DatiVista.Matricola,DalStr,AlStr,DatiVista.ParamCartellino,FilePdfOutput,'N');
            ErrMsg:=CreaCartellinoPDF(lstSessioniOracle[k],DatiVista.Progressivo.ToString,DalStr,AlStr,DatiVista.ParamCartellino,FilePdfOutput,'N');
            if ErrMsg = '' then
            begin
              // elaborazione ok
              InfoMsg:=Format('%s cartellino pdf salvato in %s',[InfoAvanzamento,FilePdfOutput]);
              RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]),DatiVista.Azienda,DatiVista.Progressivo);
            end
            else
            begin
              // elaborazione con errori
              InfoMsg:=Format('%s errore durante produzione cartellino: %s',[InfoAvanzamento,ErrMsg]);
              RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg,LParAziendali.FilePdf,'']),DatiVista.Azienda,DatiVista.Progressivo);
            end;
          finally
            FreeAndNil(W009Dtm);
            CSStampaCartellino.Leave;
          end;

          // se il file pdf è stato creato effettua ulteriori operazioni
          if ErrMsg = '' then
          begin
            // b. aggiunge le informazioni sul record per il file di metadati
            RigaMetadati:=TRigaMetadati.Create;
            RigaMetadati.NomeFile:=FilePdfOutput;
            RigaMetadati.Ente:=DatiVista.Ente;
            RigaMetadati.Matricola:=DatiVista.Matricola;
            RigaMetadati.Cognome:=DatiVista.Cognome;
            RigaMetadati.Nome:=DatiVista.Nome;
            RigaMetadati.CodFiscale:=DatiVista.CodFiscale;
            RigaMetadati.DataNascita:=DatiVista.DataNascita;
            RigaMetadati.Email:=DatiVista.Email;

            // aggiunge info al gestore dei metadati
            MetadatiMgr.AddRigaMetadati(RigaMetadati);

            // c. aggiorna il valore di ESISTE_PDF
            updT860.Session:=lstSessioniOracle[k];
            updT860.SetVariable('PROGRESSIVO',DatiVista.Progressivo);
            updT860.SetVariable('MESE_CARTELLINO',DatiVista.MeseCartellino);
            updT860.SetVariable('ESISTE_PDF','S');
            updT860.Execute;
            updT860.Session.Commit;

            // messaggio di ok
            InfoMsg:=Format('%s aggiornamento tabella T860 ok',[InfoAvanzamento]);
            RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]),DatiVista.Azienda,DatiVista.Progressivo);
          end;
        except
          on E: Exception do
          begin
            ErrMsg:=Format('%s errore durante l''elaborazione',[InfoAvanzamento]);
            RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg,E.Message,E.ClassName]));
            lstSessioniOracle[k].RollBack;
          end;
        end;

        // imposta alcune informazioni sul manager dei metadati per la produzione del file
        MetadatiMgr.Azienda:=DatiVista.Azienda;
        MetadatiMgr.CodAzienda:=DatiVista.CodAzienda;
        MetadatiMgr.DescAzienda:=DatiVista.DescAzienda;
        MetadatiMgr.MeseCartellino:=DatiVista.MeseCartellino;

        // salva variabili old
        OldAzienda:=DatiVista.Azienda;
        OldCodAzienda:=DatiVista.CodAzienda;
        OldDescAzienda:=DatiVista.DescAzienda;
        OldMeseCartellino:=DatiVista.MeseCartellino;
        selVT860.Next;
      end;

      // effettua le operazioni per l'ultimo blocco di cartellini
      // genera il file di metadati
      if MetadatiMgr.GeneraFileMeta(ErrMsg) then
      begin
        InfoMsg:=Format('file dei metadati di %s salvato in %s',[FormatDateTime('mmmm yyyy',OldMeseCartellino),MetadatiMgr.NomeFileMetadati]);
        RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]),OldAzienda);
      end
      else
      begin
        ErrMsg:=Format('mese di %s: %s',[ErrMsg]);
        RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg,LParAziendali.FilePdf,'']),OldAzienda);
      end;

      // esegue l'eventuale contenuto del batch di post-elaborazione
      EseguiBatchPostElaborazione(LParAziendali.PathPdf,MetadatiMgr.NomeFileFinale);

      // info log
      InfoMsg:='produzione dei cartellini: terminata';
      RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
    end;
  finally
    FreeAndNil(LParAziendali);

    if MetadatiMgr <> nil then
      FreeAndNil(MetadatiMgr);

    // refresh della vista per loggare l''eventuale numero di record restanti
    try
      if (selVT860.Active) and (selVT860.RecordCount > 0) then
      begin
        selVT860.Refresh;
        InfoMsg:=Format('vista personalizzata VT860_CARTELLINI_PDF dopo l''elaborazione: contiene %d record',[selVT860.RecordCount]);
        RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
        // chiude il dataset se non è associato a un datasource
        //if selVT860.DataSource = nil then
        //  selVT860.Close;
      end;
    except
    end;

    // log di fine elaborazione
    InfoMsg:=Format('fine elaborazione, durata complessiva: %s',[FormatDateTime('hh.mm.ss.zzz',Now - TempoIni)]);
    RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
  end;
end;

procedure TBc22FGeneratoreCartelliniMW.EseguiBatchPostElaborazione(const PBaseDir: String;
  const PNomeFile: String);
// se presente esegue il file batch per le eventuali operazioni post-elaborazione
// il file batch ha come nome [BATCH_POST_EXEC], ed è contenuto
// nella cartella dell'eseguibile
// questa procedura viene eseguita a rottura di azienda o mese
// Parametri:
//   PBaseDir
//     cartella base in cui sono presenti i file pdf
//   PNomeFile
//     nome del file finale secondo le richieste del CSI
// PRE: RegistraMsg.IniziaMessaggio è stato richiamato
var
  lstCmd: TStringList;
  FileBatPostElab: String;
  i: Integer;
  Cmd: string;
  posSpazio: Integer;
  OldCurrentDir: string;
  InfoAvanzamento: String;
  InfoMsg: String;
  ErrMsg: String;
  LPadding: Integer;
  FilePresente: Boolean;
  wR180SyncProcessExecResults:T180SyncProcessExecResults;
const
  FUNC_NAME       = 'TBc22FGeneratoreCartelliniMW.EseguiBatchPostElaborazione';
  ERR_MSG         = FUNC_NAME + ' - %s';
  INFO_MSG        = FUNC_NAME + ': %s';
  BATCH_POST_EXEC = 'Bc22_FineElaborazione.bat';
begin
  // salva cartella corrente
  OldCurrentDir:=GetCurrentDir;

  // cerca il file batch nella directory in cui è presente l'eseguibile (vale anche per il servizio)
  FileBatPostElab:=IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0))) + BATCH_POST_EXEC;

  FilePresente:=TFile.Exists(FileBatPostElab);
  InfoMsg:=Format('file batch di post-elaborazione [%s] %s',
                  [FileBatPostElab,IfThen(FilePresente,'presente','non presente')]);
  RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));

  if FilePresente then
  begin
    InfoMsg:='esecuzione comandi di post-elaborazione: inizio';
    RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));

    // carica stringlist con comandi batch da eseguire
    lstCmd:=TStringList.Create;
    try
      lstCmd.LoadFromFile(FileBatPostElab);

      // imposta la directory corrente
      SetCurrentDir(PBaseDir);
      InfoMsg:=Format('impostata la directory corrente: %s',[PBaseDir]);
      RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));

      LPadding:=Trunc(R180Arrotonda(Math.Log10(lstCmd.Count),1,'E'));
      for i:=0 to lstCmd.Count - 1 do
      begin
        Cmd:=lstCmd[i];
        if Cmd.Trim = '' then
          Continue;

        InfoAvanzamento:=Format('riga %.*d:',[LPadding,i + 1]);

        // log comando originale
        InfoMsg:=Format('%s [%s]',[InfoAvanzamento,Cmd]);
        RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));

        // sostituzione variabili
        if Pos('<NOME_FILE>',Cmd) > 0 then
        begin
          Cmd:=StringReplace(Cmd,'<NOME_FILE>',PNomeFile,[rfReplaceAll,rfIgnoreCase]);

          // log comando modificato
          InfoMsg:=Format('%s [%s] (variabile sostituita)',[InfoAvanzamento,Cmd]);
          RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
        end;

        // richiama la shellexecuteandwait
        //ExecReturn:=ShellExecute_AndWait('open',Cmd,CmdPar,'',SW_HIDE{SW_NORMAL},True);
        wR180SyncProcessExecResults:=R180SyncProcessExec(Cmd,'','');
        if wR180SyncProcessExecResults.CodiceUscita = 0 then
        begin
          InfoMsg:=Format('%s comando eseguito correttamente',[InfoAvanzamento]);
          RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
        end
        else
        begin
          // se c'è un errore termina senza considerare i comandi successivi
          ErrMsg:=Format('%s errore in fase di esecuzione del comando: exit code %d',[InfoAvanzamento,wR180SyncProcessExecResults.CodiceUscita,wR180SyncProcessExecResults.DatiStdErr]);
          RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg]));
          if i < lstCmd.Count - 1 then
          begin
            ErrMsg:=Format('%s l''esecuzione del file batch viene interrotta',[InfoAvanzamento]);
            RegistraMsg.InserisciMessaggio('A',Format(ERR_MSG,[ErrMsg]));
          end;
          Break;
        end;
      end;

      InfoMsg:='esecuzione comandi di post-elaborazione: terminata';
      RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
    finally
      FreeAndNil(lstCmd);
      SetCurrentDir(OldCurrentDir);
    end;
  end
  else
  begin
    // notifica file batch non presente
    InfoMsg:='nessuna operazione da effettuare';
    RegistraMsg.InserisciMessaggio('I',Format(INFO_MSG,[InfoMsg]));
  end;
end;

{ TParametriAziendali }

function TParametriAziendali.ToString: String;
begin
  Result:=Format('Path pdf = [%s] | File pdf = [%s]',[PathPdf,FilePdf]);
end;

{ TRigaMetadati }

procedure TRigaMetadati.SetNumRiga(const PValue: Integer);
begin
  FNumRiga:=PValue;
end;

function TRigaMetadati.ToString: String;
// formatta opportunamente la stringa per il file dei metadati
begin
  Result:=Format('%s,%d,%s,%s,%s,%s,%s,%s,%s,%s,%s',
                 [TPath.GetFileName(NomeFile),
                  NumRiga,
                  Matricola,
                  Cognome,
                  Nome,
                  IfThen(Email = '','e',Email),
                  CodFiscale,
                  FormatDateTime('dd/mm/yyyy',DataNascita),
                  Ente,//'0',
                  '1',
                  '10'//'26'
                  ]);
end;

{ TMetadatiMgr }

constructor TMetadatiMgr.Create;
begin
  inherited;
  LstRighe:=TObjectList<TRigaMetadati>.Create(True);
end;

destructor TMetadatiMgr.Destroy;
begin
  FreeAndNil(LstRighe);
  inherited;
end;

function TMetadatiMgr.AddRigaMetadati(PRiga: TRigaMetadati): Boolean;
var
  i: Integer;
begin
  i:=LstRighe.Add(PRiga) + 1;
  PRiga.SetNumRiga(i);
  Result:=i > -1;
end;

procedure TMetadatiMgr.ClearRigheMetadati;
begin
  LstRighe.Clear;
end;

function TMetadatiMgr.GetNextIdFlusso: Integer;
// determina l'ID del flusso utilizzando la sequence BC22_ID_FLUSSO di MONDOEDP
var
  OQ: TOracleQuery;
begin
  OQ:=TOracleQuery.Create(nil);
  try
    OQ.ReadBuffer:=2;
    OQ.Session:=SessionBc22;
    OQ.SQL.Text:='select BC22_ID_FLUSSO.nextval '#13#10 +
                 'from   dual ';
    try
      OQ.Execute;
      Result:=OQ.FieldAsInteger(0);
    except
      on E: Exception do
        raise Exception.Create(Format('Si è verificato un errore durante il reperimento dell''identificativo di invio del file: %s',[E.Message]));
    end;
  finally
    FreeAndNil(OQ);
  end;
end;

function TMetadatiMgr.GeneraFileMeta(var RErrMsg: String): Boolean;
// produce il file di metadati contenente le informazioni sui file pdf dei cartellini
var
  RigaMD: TRigaMetadati;
  RigaHeader: String;
  IdFlusso: Integer;
  DataFlusso: TDateTime;
  StrOutput: String;
begin
  Result:=False;
  RErrMsg:='';

  // recupera nuovo id flusso
  IdFlusso:=GetNextIdFlusso;

  // imposta la data del flusso
  DataFlusso:=Date;

  // determina il nome del file tar.gz finale
  NomeFileFinale:=Format('%s_%s_%s_%.6d_%s_%s',//Format('%s_%s_%.6d_%s_%s_%s',
                  ['HRENTIL',
                   CodAzienda,
                   FormatDateTime('yyyymm',MeseCartellino),
                   IdFlusso,
                   'J',//'A',
                   FormatDateTime('yyyymmdd',DataFlusso)
                   //'CARTELLINO_PRESENZE'
                   ]);

  // riga di intestazione
  RigaHeader:=Format('%-12s%-10s%s%-50s%s%s%s%.6d%.6d%s%s.tar.gz',
                    ['SFCEDO03CE',
                     'HRENTIL',
                     CodAzienda,
                     DescAzienda,
                     FormatDateTime('yyyymmdd',DataFlusso),
                     FormatDateTime('yyyymm',MeseCartellino),
                     'J',//'A',
                     IdFlusso,//1,//IdFlusso,
                     IdFlusso,//1,//IdFlusso, // non è un refuso, lo ha chiesto il cliente
                     ',',
                     NomeFileFinale]);

  // seconda riga di intestazione (costante CC)
  StrOutput:=RigaHeader + #13#10 + 'CC';

  // contenuto
  for RigaMD in LstRighe do
    StrOutput:=StrOutput + #13#10 + RigaMD.ToString;

  try
    // se il file è già presente lo elimina
    if TFile.Exists(NomeFileMetadati) then
      TFile.Delete(NomeFileMetadati);

    // scrive il file
    R180AppendFile(NomeFileMetadati,StrOutput);

    // tutto ok
    Result:=True;
  except
    on E: Exception do
    begin
      RErrMsg:=Format('errore durante salvataggio file di metadati in %s: %s',[NomeFileMetadati,E.Message]);
    end;
  end;

  // pulisce le righe dei metadati
  ClearRigheMetadati;
end;

initialization
  // critical section per stampa cartellino
  CSStampa:=TMedpCriticalSection.Create;
  CSStampaCartellino:=TMedpCriticalSection.Create;

finalization
  // distruzione critical section
  FreeAndNil(CSStampa);
  FreeAndNil(CSStampaCartellino);

end.
