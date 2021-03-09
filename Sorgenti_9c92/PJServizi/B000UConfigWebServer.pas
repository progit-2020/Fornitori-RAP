unit B000UConfigWebServer;

interface

uses
  B000UConfigWebServerDM,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C180FunzioniGenerali, ImgList, ComCtrls, ToolWin, Tabs, StdCtrls,
  Registry, ShellAPI, StrUtils, Mask, ExtCtrls, Buttons,
  A000UCostanti, Grids, DBGrids, CheckLst, Menus,
  IniFiles, System.IOUtils, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, Vcl.OleCtrls, SHDocVw, ActiveX, OracleCI, Data.DB,
  System.ImageList, Vcl.Samples.Spin;

type
  TElementiForm = record
    Contenitore,
    Elementi: String;
  end;

  TAppInfo = record
    Nome: String;
    FileIni: String;
  end;

  TB000FConfigWebServer = class(TForm)
    imglstToolbarFiglio: TImageList;
    PageControl: TPageControl;
    tsParametri: TTabSheet;
    grpImpOper: TGroupBox;
    Label1: TLabel;
    lblTOOperatore: TLabel;
    lblTODipendente: TLabel;
    Label5: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    lblProfiloDefault: TLabel;
    edtTOOperatore: TMaskEdit;
    edtTODipendente: TMaskEdit;
    grpCampiInvisibili: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Shape2: TShape;
    cmbPagina: TComboBox;
    cmbComponente: TComboBox;
    btnAggiungiCI: TBitBtn;
    lstCampiInvisibili: TListBox;
    chkLoginEsterno: TCheckBox;
    edtPathLog: TEdit;
    edtAziendaDefault: TEdit;
    edtProfiloDefault: TEdit;
    grpImpSist: TGroupBox;
    Label6: TLabel;
    lblMaxOpenCursors: TLabel;
    lblCursoriLogin: TLabel;
    lblCursoriSessione: TLabel;
    grpLogAbil: TGroupBox;
    chkSessione: TCheckBox;
    chkAccesso: TCheckBox;
    chkTraccia: TCheckBox;
    chkErrore: TCheckBox;
    grpParAvanzati: TGroupBox;
    rgpCom: TRadioGroup;
    edtPort: TMaskEdit;
    edtCursoriLogin: TMaskEdit;
    edtCursoriSessione: TMaskEdit;
    edtMaxOpenCursors: TMaskEdit;
    ToolBar1: TToolBar;
    btnModifica: TToolButton;
    ToolButton4: TToolButton;
    btnAnnulla: TToolButton;
    btnSalva: TToolButton;
    tsComponenti: TTabSheet;
    lblMidasPath: TLabel;
    lblA077ComServer: TLabel;
    GroupBoxLibrerie: TGroupBox;
    Label12: TLabel;
    btnMidasReg: TButton;
    GroupBoxGenStampe: TGroupBox;
    Label13: TLabel;
    Label20: TLabel;
    btnRegA077PComServer: TButton;
    btnUnRegA077PComServer: TButton;
    tsURL: TTabSheet;
    lblUrlWsAuth: TLabel;
    edtUrlWsAuth: TEdit;
    edtURLMan: TEdit;
    lblURLMan: TLabel;
    btnMidasUnreg: TButton;
    Label27: TLabel;
    StatusBar1: TStatusBar;
    tsMessaggi: TTabSheet;
    GroupBox4: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edtPasswordMsg: TEdit;
    edtUtenteMsg: TEdit;
    btnLogon: TButton;
    GroupBox5: TGroupBox;
    dbgHead: TDBGrid;
    grpDett: TGroupBox;
    dgrdDettaglio: TDBGrid;
    Panel1: TPanel;
    chkFiltroErrore: TCheckBox;
    chkFiltroSessione: TCheckBox;
    chkFiltroAccesso: TCheckBox;
    chkFiltroTraccia: TCheckBox;
    Panel2: TPanel;
    edtDal: TMaskEdit;
    Label31: TLabel;
    edtAl: TMaskEdit;
    Label32: TLabel;
    btnFiltra: TButton;
    chkMemoria: TCheckBox;
    lblNumMsg: TLabel;
    chkFiltroMemoria: TCheckBox;
    Splitter1: TSplitter;
    Label36: TLabel;
    edtMaxProcessMemory: TMaskEdit;
    chkParametriAvanzati: TCheckListBox;
    pmnDettaglio: TPopupMenu;
    mnuFiltraIdSessione: TMenuItem;
    mnuFiltraIP: TMenuItem;
    GroupBox6: TGroupBox;
    Label38: TLabel;
    Button2: TButton;
    pnlInfo: TPanel;
    lblParRiavvio: TLabel;
    edtTabColPartenza: TEdit;
    edtNumLivelli: TMaskEdit;
    lblTabColPartenza: TLabel;
    lblNumLivelli: TLabel;
    grpAzioniUrl: TGroupBox;
    grpGenerazioneUrl: TGroupBox;
    lblAziendaGen: TLabel;
    edtUrlAzienda: TEdit;
    lblUtenteGen: TLabel;
    edtUrlUtente: TEdit;
    lblPasswordGen: TLabel;
    edtUrlPassword: TEdit;
    lblProfiloGen: TLabel;
    edtUrlProfilo: TEdit;
    lblDatabaseGen: TLabel;
    lblHomeGen: TLabel;
    edtUrlHome: TEdit;
    edtURLGenerato: TEdit;
    shp1: TShape;
    lblURL: TLabel;
    pnlTop: TPanel;
    rgpTipoInstallazione: TRadioGroup;
    cmbAzioni: TComboBox;
    grpGestioneSito: TGroupBox;
    lblMonitorSessioni: TLabel;
    lblVisParConfig: TLabel;
    btnEseguiAzione: TButton;
    IdHTTP1: TIdHTTP;
    memRisultato: TMemo;
    lblDescrizioneAzione: TLabel;
    edtUrlBase: TEdit;
    lblUrlBase: TLabel;
    lblAccessoSito: TLabel;
    pnlApplicativo: TPanel;
    pnlInfoApplicativo: TPanel;
    lblInfoApplicativo: TLabel;
    GroupBox1: TGroupBox;
    edtPathBase: TEdit;
    rgpApplicativo: TRadioGroup;
    lblMaxSessioni: TLabel;
    edtMaxSessioni: TMaskEdit;
    lblUrlSuperoMaxSessioni: TLabel;
    edtHome: TEdit;
    edtUrlSuperoMaxSessioni: TEdit;
    Label2: TLabel;
    edtURLLoginErrato: TEdit;
    lblPaginaIniziale: TLabel;
    edtPaginaIniziale: TEdit;
    lblPaginaSingola: TLabel;
    edtPaginaSingola: TEdit;
    lblUrlIrisWebCloud: TLabel;
    edtUrlIrisWebCloud: TEdit;
    chkIrisWebCloudNewTab: TCheckBox;
    lblRegB028PComServer: TLabel;
    lblUnRegB028PComServer: TLabel;
    btnRegBc28PComServer: TButton;
    btnUnRegBc28PComServer: TButton;
    cmbDataBase: TComboBox;
    cmbURLDataBase: TComboBox;
    cmbDataBaseMsg: TComboBox;
    tsAltro: TTabSheet;
    pnlAltroInfo: TPanel;
    Label3: TLabel;
    pnlAltroSettings: TPanel;
    grpExceptionLogger: TGroupBox;
    lblELNomeFile: TLabel;
    lblELPathFile: TLabel;
    lblELPurge1: TLabel;
    lblELPurge2: TLabel;
    grpELEcc: TGroupBox;
    lblELEccPredefinite: TLabel;
    lblELEccCustom: TLabel;
    chkELEccPredefinite: TCheckListBox;
    edtELEccCustom: TEdit;
    edtELPathFile: TEdit;
    edtELNomeFile: TEdit;
    edtELNumGiorniPurge: TSpinEdit;
    memELHelp: TMemo;
    chkEnableExcLog: TCheckBox;
    ToolBar2: TToolBar;
    btnModifica2: TToolButton;
    ToolButton2: TToolButton;
    btnAnnulla2: TToolButton;
    btnSalva2: TToolButton;
    procedure edtUrlAziendaChange(Sender: TObject);
    procedure btnModificaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure btnMidasRegClick(Sender: TObject);
    procedure cmbPaginaChange(Sender: TObject);
    procedure btnAggiungiCIClick(Sender: TObject);
    procedure lstCampiInvisibiliKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lstCampiInvisibiliDblClick(Sender: TObject);
    procedure btnLogonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure PageControlChange(Sender: TObject);
    procedure chkFiltroErroreClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFiltraClick(Sender: TObject);
    procedure mnuFiltraIdSessioneClick(Sender: TObject);
    procedure mnuFiltraIPClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure rgpApplicativoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgpTipoInstallazioneClick(Sender: TObject);
    procedure lnkMonitorSessioniClick(Sender: TObject);
    procedure lnkVisParametriConfigClick(Sender: TObject);
    procedure btnEseguiAzioneClick(Sender: TObject);
    procedure edtUrlBaseChange(Sender: TObject);
    procedure btnClearMemoClick(Sender: TObject);
    procedure cmbAzioniChange(Sender: TObject);
    procedure lblAccessoSitoClick(Sender: TObject);
    procedure cmbURLDataBaseChange(Sender: TObject);
    procedure chkEnableExcLogClick(Sender: TObject);
  private
    W000ParConfig: TParConfig;
    InModifica: Boolean;
    ItemIrisWeb: Integer;
    ItemIrisCloud: Integer;
    ItemX001: Integer;
    procedure ViewURL;
    //procedure LeggiRegistro;
    procedure AttivaCampiParametri(Attiva: Boolean);
    procedure GetConfigurazione;
    procedure SetConfigurazione;
    function  CtrlDirectoryWriteable(const PDirName: String): Boolean;
    procedure CaricaParametriAvanzati;
    procedure AbilitazioneFileConfig;
    procedure ApriUrl(const PContesto: String);
    function  GetUrlBase: String;
    procedure AddToMemo(var PMemo: TMemo; const PLine: String);
  public
    FiltroMsg,
    FiltroPeriodo: String;
    DalOrig,
    AlOrig: TDateTime;
  end;

var
  B000FConfigWebServer: TB000FConfigWebServer;

const
  ITEM_NAME_IRISWEB       = 'IrisWeb';
  ITEM_NAME_IRISCLOUD     = 'IrisCloud';
  ITEM_NAME_X001          = 'X001';

  ITEM_EXE_NAME_IRISWEB   = 'W000PIrisWeb.exe';
  ITEM_EXE_NAME_IRISCLOUD = 'IrisCloudRilPre.exe';
  ITEM_EXE_NAME_X001      = 'X001PCentriCostoTOHM.exe';

  ITEM_DLL_NAME_IRISWEB   = 'W000PIrisWeb_IIS.dll';
  ITEM_DLL_NAME_IRISCLOUD = 'IrisCloudRilPre_IIS.dll';
  ITEM_DLL_NAME_X001      = 'X001PCentriCostoTOHM_IIS.dll';

  ITEM_SRV_NAME_IRISWEB   = 'IrisWeb';
  ITEM_SRV_NAME_IRISCLOUD = 'IrisCloud';
  ITEM_SRV_NAME_X001      = 'X001';

  // irisweb
  Elementi: array [0..32] of TElementiForm = (
    (Contenitore:'';                             Elementi:'lnkHelp'),
    (Contenitore:'W001FLogin';                   Elementi:'edtAzienda,edtUtente,edtPassword,edtDatabase,edtNomeProfilo,cmbNomeProfilo,lblAzienda,lblUtente,lblPassword,lblDatabase,lblNomeProfilo'),
    (Contenitore:'W002FAnagrafeElenco';          Elementi:'chkDipendentiCessati'),
    (Contenitore:'W002FRicercaAnagrafe';         Elementi:'lnkRicercaSalvata,cmbSelezioni,lnkSQLSalvato'),
    (Contenitore:'W003FAnomalie';                Elementi:'chkLivello1,chkLivello2,chkLivello3'),
    (Contenitore:'W005FCartellino';              Elementi:'lblCausPresDisponibili,cmbCausPresDisponibili,lblCausAssDisponibili,cmbCausAssDisponibili'),
    (Contenitore:'W007FGestioneSicurezza';       Elementi:'lblEMail,edtEMail'),
    (Contenitore:'W008FGiustificativi';          Elementi:'chkStampaRicevuta,chkFiltro'),
    (Contenitore:'W009FStampaCartellino';        Elementi:'chkAggiornamentoScheda,chkAutoGiustificazione,chkAggiornamentoBuoniPasto,chkAggiornamentoAccessiMensa'),
    (Contenitore:'W010FRichiestaAssenze';        Elementi:''),
    (Contenitore:'W011FMessaggi';                Elementi:''),
    (Contenitore:'W012FCurriculum';              Elementi:''),
    (Contenitore:'W013FPreferenze';              Elementi:''),
    (Contenitore:'W014FPianifCorsi';             Elementi:''),
    (Contenitore:'W015FServerStampe';            Elementi:''),
    (Contenitore:'W016FAccessiMensa';            Elementi:''),
    (Contenitore:'W017FStampaCedolino';          Elementi:''),
    (Contenitore:'W018FRichiestaTimbrature';     Elementi:'btnTuttiSi,btnTuttiNo'),
    (Contenitore:'W019FGestioneDeleghe';         Elementi:''),
    (Contenitore:'W020FCambioProfilo';           Elementi:''),
    (Contenitore:'W021FStampaCUD';               Elementi:'lnkIstrCUD'),
    (Contenitore:'W022FDettaglioValutazioni';    Elementi:''),
    (Contenitore:'W022FSchedaValutazioni';       Elementi:''),
    (Contenitore:'W023FPianifOrari';             Elementi:''),
    (Contenitore:'W024FRichiestaStraordinari';   Elementi:''),
    (Contenitore:'W026FRichiestaStrGG';          Elementi:''),
    (Contenitore:'W027FDetrazioniIRPEF';         Elementi:''),
    (Contenitore:'W028FChiamateReperibili';      Elementi:''),
    (Contenitore:'W029FPesatureIndividuali';     Elementi:''),
    (Contenitore:'W030FTabelloneTurni';          Elementi:''),
    (Contenitore:'W031FSchedeQuantIndividuali';  Elementi:''),
    (Contenitore:'W032FRichiestaMissioni';       Elementi:'tabMissioniTab0,tabMissioniTab1,tabMissioniTab2,tabMissioniTab3,lblProgettoEuropeo,memProgettoEuropeo,cgpMotivEstero,cgpIpotesiEstero'),
    (Contenitore:'W033FProspettoAssenze';        Elementi:'')
  );

implementation
{$R *.dfm}

procedure TB000FConfigWebServer.FormCreate(Sender: TObject);
var
  PathCorr: String;
  i: Integer;
begin
  PageControl.ActivePageIndex:=0;
  // popola la checklistbox dei parametri avanzati
  CaricaParametriAvanzati;

  if OracleAliasList <> nil then
  begin
    cmbDataBase.Items.Assign(OracleAliasList);
    cmbURLDataBase.Items.Assign(OracleAliasList);
    cmbDataBaseMsg.Items.Assign(OracleAliasList);
  end;

  // parametri di configurazione applicativi web su file.ini
  //LeggiRegistro;
  PathCorr:=ExtractFilePath(Application.ExeName);
  edtPathBase.Text:=PathCorr;

  if not CtrlDirectoryWriteable(PathCorr) then
    raise Exception.Create('Non sono disponibili i diritti di scrittura sulla directory'#13#10 +
                           PathCorr +
                           #13#10'Impossibile modificare la configurazione degli applicativi web!');

  // aggiunge al radiogrup gli item degli applicativi in base alla presenza
  // dei file che li contraddistinguono
  rgpApplicativo.OnClick:=nil;
  rgpApplicativo.Items.Clear;
  if Length(TDirectory.GetFiles(PathCorr,'W000*.*')) = 0 then
    ItemIrisWeb:=-1
  else
    ItemIrisWeb:=rgpApplicativo.Items.Add(ITEM_NAME_IRISWEB);
  if Length(TDirectory.GetFiles(PathCorr,'IrisCloud*.*')) = 0 then
    ItemIrisCloud:=-1
  else
    ItemIrisCloud:=rgpApplicativo.Items.Add(ITEM_NAME_IRISCLOUD);
  if Length(TDirectory.GetFiles(PathCorr,'X001*.*')) = 0 then
    ItemX001:=-1
  else
    ItemX001:=rgpApplicativo.Items.Add(ITEM_NAME_X001);

  // seleziona il primo applicativo con un file di configurazione esistente
  if TFile.Exists(PathCorr + FILE_CONFIG_IRISWEB) then
    rgpApplicativo.ItemIndex:=ItemIrisWeb
  else if TFile.Exists(PathCorr + FILE_CONFIG_IRISCLOUD) then
    rgpApplicativo.ItemIndex:=ItemIrisCloud
  else if TFile.Exists(PathCorr + FILE_CONFIG_X001) then
    rgpApplicativo.ItemIndex:=ItemX001
  else
  begin
    rgpApplicativo.ItemIndex:=-1;
    btnModifica.Enabled:=False;
    PageControl.Enabled:=False;
    raise Exception.Create('Nessun file di configurazione presente!');
  end;
  rgpApplicativo.OnClick:=rgpApplicativoClick;

  GetConfigurazione;
  // parametri di configurazione applicativi web su file.fine

  PageControl.TabIndex:=0;
  InModifica:=False;
  edtUrlAzienda.Text:='AZIN';

  // carica combo pagine
  cmbPagina.Items.BeginUpdate;
  for i:=0 to High(Elementi) do
    cmbPagina.Items.Add(Elementi[i].Contenitore);
  cmbPagina.Items.EndUpdate;

  // carica azioni sito
  cmbAzioni.Items.Clear;
  for i:=Low(A000AzioniSitoWeb) to High(A000AzioniSitoWeb) do
  begin
    cmbAzioni.Items.Add(A000AzioniSitoWeb[i].Nome);
  end;
  cmbAzioni.ItemIndex:=-1;
end;

procedure TB000FConfigWebServer.FormShow(Sender: TObject);
begin
  lblUrlIrisWebCloud.Top:=312;
  edtUrlIrisWebCloud.Top:=309;
  chkIrisWebCloudNewTab.Top:=334;
  AttivaCampiParametri(InModifica);
  AbilitazioneFileConfig;
end;

procedure TB000FConfigWebServer.AbilitazioneFileConfig;
var
  PathCorr, Info: String;
  Abil: Boolean;
begin
  PathCorr:=ExtractFilePath(Application.ExeName);
  Info:='';

  if ItemIrisWeb > -1 then
  begin
    Abil:=TFile.Exists(PathCorr + FILE_CONFIG_IRISWEB);
    R180RadioGroupButton(rgpApplicativo,ItemIrisWeb).Enabled:=Abil;
    if not Abil then
      Info:=Info + ITEM_NAME_IRISWEB + ', ';
  end;
  if ItemIrisCloud > -1 then
  begin
    Abil:=TFile.Exists(PathCorr + FILE_CONFIG_IRISCLOUD);
    R180RadioGroupButton(rgpApplicativo,ItemIrisCloud).Enabled:=Abil;
    if not Abil then
      Info:=Info + ITEM_NAME_IRISCLOUD + ', ';
  end;
  if ItemX001 > -1 then
  begin
    Abil:=TFile.Exists(PathCorr + FILE_CONFIG_X001);
    R180RadioGroupButton(rgpApplicativo,ItemX001).Enabled:=Abil;
    if not Abil then
      Info:=Info + ITEM_NAME_X001 + ', ';
  end;

  if Info <> '' then
    Info:=Copy(Info,1,Length(Info) - 2);
  pnlInfoApplicativo.Visible:=Info <> '';
  lblInfoApplicativo.Visible:=Info <> '';
  if Info <> '' then
    lblInfoApplicativo.Caption:=Format('File di configurazione non presente per %s: avviare il sito per generarlo',[Info]);
end;

procedure TB000FConfigWebServer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with B000FConfigWebServerDM do
  begin
    if DbMessaggi.Connected then
    begin
      try selMsgDett.CloseAll; except end;
      try selMsgHead.CloseAll; except end;
      try DbMessaggi.LogOff; except end;
    end;
  end;
end;

procedure TB000FConfigWebServer.CaricaParametriAvanzati;
begin
  chkParametriAvanzati.Items.BeginUpdate;
  chkParametriAvanzati.Items.Clear;
  chkParametriAvanzati.Items.Add(INI_PAR_NO_CRITICAL_SECTION_LOGIN);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_CRITICAL_SECTION_SESSIONE);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_SHARED_LOGIN);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_REGISTRA_MSG);
  chkParametriAvanzati.Items.Add(INI_PAR_RECUPERO_PASSWORD);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_ABILITAZIONI);
  chkParametriAvanzati.Items.Add(INI_PAR_USE_STANDARD_PRINTER);
  chkParametriAvanzati.Items.Add(INI_PAR_COMPRESSION);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_STAMPACARTELLINO);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_STAMPACEDOLINO);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_PDF);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_COINITIALIZE);
  chkParametriAvanzati.Items.Add(INI_PAR_CAPTION_LAYOUT);
  chkParametriAvanzati.Items.Add(INI_PAR_TRADUZIONE_CAPTION);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_DEL_TEMPFILE_ONCREATE);
  chkParametriAvanzati.Items.Add(INI_PAR_CACHED_FILES);
  chkParametriAvanzati.Items.Add(INI_PAR_NO_UNIFIED_FILES);
  chkParametriAvanzati.Items.Add(INI_PAR_JQUERY_UNCOMPRESSED);
  chkParametriAvanzati.Items.Add(INI_PAR_FILE_INLINE);
  chkParametriAvanzati.Items.Add(INI_PAR_DB_STATEMENT_CACHE);
  chkParametriAvanzati.Items.Add(INI_PAR_DB_NO_CHECK_CONNECTION);
  chkParametriAvanzati.Items.Add(INI_PAR_DB_NO_RECONNECT);
  chkParametriAvanzati.Items.Add(INI_PAR_LOGOFF_DBPOOL);
  chkParametriAvanzati.Items.Add(INI_PAR_C017_V430);
  chkParametriAvanzati.Items.Add(INI_PAR_C018_LEADING_T030);
  chkParametriAvanzati.Items.Add(INI_PAR_C018_NO_LEADING_T030);
  chkParametriAvanzati.Items.Add(INI_PAR_C018_UNNEST);
  chkParametriAvanzati.Items.Add(INI_PAR_C018_NO_UNNEST);
  chkParametriAvanzati.Items.Add(INI_PAR_T050_CANCELLAZIONE);
  chkParametriAvanzati.Items.Add(INI_PAR_RAVEREPORT_IN_MEMORIA);
  chkParametriAvanzati.Items.Add(INI_PAR_TOLLERA_IE7);
  chkParametriAvanzati.Items.Add(INI_PAR_COOKIES_ENABLE_HTTPONLY);
  chkParametriAvanzati.Items.Add(INI_PAR_COOKIES_ENABLE_SAMESITE_STRICT);
  chkParametriAvanzati.Items.Add(INI_PAR_SECURITY_ENABLE_FORM_ID_CHECK);
  chkParametriAvanzati.Items.Add(INI_PAR_SECURITY_ENABLE_SAME_UA_CHECK);
  chkParametriAvanzati.Items.Add(INI_PAR_SECURITY_ENABLE_SAME_IP_CHECK);
  chkParametriAvanzati.Items.Add(INI_PAR_IRISWEB_ENABLE_MULTISCHEDA);
  chkParametriAvanzati.Items.EndUpdate;
end;

function TB000FConfigWebServer.CtrlDirectoryWriteable(const PDirName: String): Boolean;
// determina se si hanno i diritti di scrittura sulla directory specificata
var
  FileName: String;
  H: THandle;
begin
  FileName:=IncludeTrailingPathDelimiter(PDirName) + 'chk.tmp';
  H:=CreateFile(PChar(FileName),GENERIC_READ or GENERIC_WRITE,0,nil,
       CREATE_NEW, FILE_ATTRIBUTE_TEMPORARY or FILE_FLAG_DELETE_ON_CLOSE, 0);
  Result:=H <> INVALID_HANDLE_VALUE;
  if Result then
    CloseHandle(H);
end;

procedure TB000FConfigWebServer.rgpApplicativoClick(Sender: TObject);
begin
  GetConfigurazione;
  rgpTipoInstallazioneClick(rgpTipoInstallazione);
end;

procedure TB000FConfigWebServer.rgpTipoInstallazioneClick(Sender: TObject);
begin
  // url base applicativo selezionato
  edtUrlBase.Text:=GetUrlBase;
end;

procedure TB000FConfigWebServer.GetConfigurazione;
var
  NomeFileConfig, PathFileConfig: String;
  LogAbilitati, ParamAvanzati: TStringList;
  IniFile: TIniFile;
  i,j: Integer;
  StringList:TStringList;
begin
  LogAbilitati:=TStringList.Create;
  ParamAvanzati:=TStringList.Create;

  if rgpApplicativo.ItemIndex = ItemIrisWeb then
    NomeFileConfig:=FILE_CONFIG_IRISWEB
  else if rgpApplicativo.ItemIndex = ItemIrisCloud then
    NomeFileConfig:=FILE_CONFIG_IRISCLOUD
  else if rgpApplicativo.ItemIndex = ItemX001 then
    NomeFileConfig:=FILE_CONFIG_X001;

  // *** visibilità elementi in base all'applicativo
  // profilo: solo per irisweb
  lblProfiloDefault.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  edtProfiloDefault.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  // max sessioni: sempre visibile
  edtMaxSessioni.Visible:=True;
  edtUrlSuperoMaxSessioni.Visible:=True;
  // timeout operatore: solo per irisweb e iriscloud
  lblTOOperatore.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  edtTOOperatore.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  // timeout dipendente: solo per irisweb e x001
  lblTODipendente.Visible:=(rgpApplicativo.ItemIndex <> ItemIrisCloud);
  edtTODipendente.Visible:=(rgpApplicativo.ItemIndex <> ItemIrisCloud);
  // url ws autenticazione: solo per irisweb
  lblUrlWsAuth.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  edtUrlWsAuth.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  // login esterno: solo per irisweb e iriscloud
  chkLoginEsterno.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  lblPaginaSingola.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  edtPaginaSingola.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  lblPaginaIniziale.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  edtPaginaIniziale.Visible:=(rgpApplicativo.ItemIndex = ItemIrisWeb);
  // url richiamo IrisWeb/IrisCloud: solo per irisweb e iriscloud
  lblUrlIrisWebCloud.Caption:='URL richiamo ' + IfThen(rgpApplicativo.ItemIndex = ItemIrisWeb,ITEM_NAME_IRISCLOUD,ITEM_NAME_IRISWEB);
  lblUrlIrisWebCloud.Visible:=(rgpApplicativo.ItemIndex <> ItemX001) and (ItemIrisWeb <> -1) and (ItemIrisCloud <> -1);
  edtUrlIrisWebCloud.Visible:=(rgpApplicativo.ItemIndex <> ItemX001) and (ItemIrisWeb <> -1) and (ItemIrisCloud <> -1);
  // richiamo IrisWeb/IrisCloud in un'altra finestra: solo per irisweb e iriscloud
  chkIrisWebCloudNewTab.Caption:='Apri ' + IfThen(rgpApplicativo.ItemIndex = ItemIrisWeb,ITEM_NAME_IRISCLOUD,ITEM_NAME_IRISWEB) + ' in un''altra finestra';
  chkIrisWebCloudNewTab.Visible:=(rgpApplicativo.ItemIndex <> ItemX001) and (ItemIrisWeb <> -1) and (ItemIrisCloud <> -1);
  // tab. col partenza: solo per x001
  lblTabColPartenza.Visible:=(rgpApplicativo.ItemIndex = ItemX001);
  edtTabColPartenza.Visible:=(rgpApplicativo.ItemIndex = ItemX001);
  // num. livelli: solo per x001
  lblNumLivelli.Visible:=(rgpApplicativo.ItemIndex = ItemX001);
  edtNumLivelli.Visible:=(rgpApplicativo.ItemIndex = ItemX001);
  // cursori login: solo per irisweb e iriscloud
  lblCursoriLogin.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  edtCursoriLogin.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  // cursori sessione: solo per irisweb e iriscloud
  lblCursoriSessione.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  edtCursoriSessione.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  // max open cursors: solo per irisweb e iriscloud
  lblMaxOpenCursors.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  edtMaxOpenCursors.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  // iw exception logger
  chkEnableExcLog.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);
  grpExceptionLogger.Visible:=(rgpApplicativo.ItemIndex <> ItemX001);

  // determina il file ini di configurazione dell'applicativo
  PathFileConfig:=ExtractFilePath(Application.ExeName) + NomeFileConfig;
  IniFile:=TIniFile.Create(PathFileConfig);
  try
    //impostazioni operative
    cmbDatabase.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_DATABASE,'');
    edtAziendaDefault.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_AZIENDA,'');
    edtProfiloDefault.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_PROFILO,'');
    edtMaxSessioni.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_MAX_SESSIONI,0));
    edtUrlSuperoMaxSessioni.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS,'');
    edtTOOperatore.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_TIMEOUT_OPER,30));
    edtTODipendente.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_TIMEOUT_DIP,15));
    edtHome.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME,'');
    edtURLLoginErrato.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_LOGINERR,'');
    edtPathLog.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_PATH_LOG,'C:\IrisWIN\Archivi');
    edtUrlWsAuth.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_WS_AUT,'');
    edtURLMan.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_MANUTENZIONE,'');
    edtUrlIrisWebCloud.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_URL_IRISWEBCLOUD,'');
    chkIrisWebCloudNewTab.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_IRISWEBCLOUD_NEWTAB,'N') = 'S';
    chkLoginEsterno.Checked:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_LOGIN_ESTERNO,'N') = 'S';
    lstCampiInvisibili.Items.CommaText:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_CAMPI_INVISIBILI,'');
    edtTabColPartenza.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_TAB_COL_PARTENZA,'');
    edtNumLivelli.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_OPER,INI_ID_NUM_LIVELLI,0));
    edtPaginaIniziale.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_STARTPAGE,'');
    edtPaginaSingola.Text:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_SINGLEPAGE,'');
    //impostazioni di sistema
    edtPort.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT,5000));
    edtCursoriLogin.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_CURSORI_LOGIN,12));
    edtCursoriSessione.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_CURSORI_SESSIONE,10));
    edtMaxOpenCursors.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_MAX_OPEN_CURSORS,1000));
    edtMaxProcessMemory.Text:=IntToStr(IniFile.ReadInteger(INI_SEZ_IMPOST_SIST,INI_ID_MAX_WORKING_MEMORY,0));

    LogAbilitati.CommaText:=IniFile.ReadString(INI_SEZ_IMPOST_SIST,INI_ID_LOG_ABILITATI,'');
    chkErrore.Checked:=False;
    chkMemoria.Checked:=False;
    chkSessione.Checked:=False;
    chkAccesso.Checked:=False;
    chkTraccia.Checked:=False;
    if LogAbilitati.Count <> 0 then
    begin
      for i:=0 to LogAbilitati.Count - 1 do
      begin
        if LogAbilitati[i] = INI_LOG_ERRORE then
          chkErrore.Checked:=True
        else if LogAbilitati[i] = INI_LOG_MEMORIA then
          chkMemoria.Checked:=True
        else if LogAbilitati[i] = INI_LOG_SESSIONE then
          chkSessione.Checked:=True
        else if LogAbilitati[i] = INI_LOG_ACCESSO then
          chkAccesso.Checked:=True
        else if LogAbilitati[i] = INI_LOG_TRACCIA then
          chkTraccia.Checked:=True;
      end;
    end;

    ParamAvanzati.CommaText:=IniFile.ReadString(INI_SEZ_IMPOST_SIST,INI_ID_PARAMETRI_AVANZATI,'');
    chkParametriAvanzati.CheckAll(cbUnchecked);
    rgpCom.ItemIndex:=0;
    if ParamAvanzati.Count <> 0 then
    begin
      R180PutCheckList(ParamAvanzati.CommaText,50,chkParametriAvanzati);

      for i:=0 to ParamAvanzati.Count - 1 do
      begin
        if ParamAvanzati[i] = INI_COM_NONE then
        begin
          rgpCom.ItemIndex:=1;
          Break;
        end
        else if ParamAvanzati[i] = INI_COM_NORMAL then
        begin
          rgpCom.ItemIndex:=2;
          Break;
        end
        else if ParamAvanzati[i] = INI_COM_MULTI then
        begin
          rgpCom.ItemIndex:=3;
          Break;
        end;
      end;
    end;

    // iw exception log
    chkEnableExcLog.Checked:=(IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_ABILITATO,'N') = 'S');
    edtELPathFile.Text:=IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_PATH_FILE_LOG,'');
    edtELNomeFile.Text:=IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_NOME_FILE_LOG,'');
    edtELNumGiorniPurge.Value:=IniFile.ReadInteger(INI_SEZ_IMPOST_IW_LOG,INI_EL_GIORNI_RIMOZIONE,1);
    edtELPathFile.Text:=IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_PATH_FILE_LOG,'');
    StringList:=TStringList.Create();
    chkELEccPredefinite.CheckAll(TCheckBoxState.cbUnchecked);
    edtELEccCustom.Text:='';
    try
      StringList.CaseSensitive:=False;
      StringList.Sorted:=True;
      StringList.Duplicates:=TDuplicates.dupIgnore;
      StringList.StrictDelimiter:=True;
      StringList.DelimitedText:=IniFile.ReadString(INI_SEZ_IMPOST_IW_LOG,INI_EL_ECCEZ_IGNORATE,'');
      for i:=0 to (StringList.Count - 1) do
      begin
        j:=chkELEccPredefinite.Items.IndexOf(StringList[i]);
        if j >= 0 then
          chkELEccPredefinite.Checked[j]:=True
        else
          edtELEccCustom.Text:=edtELEccCustom.Text +
                               IfThen(edtELEccCustom.Text <> '',',','') +
                               StringList[i];
      end;
    finally
      StringList.Free;
    end;

  finally
    FreeAndNil(IniFile);
    FreeAndNil(LogAbilitati);
    FreeAndNil(ParamAvanzati);
  end;
end;

procedure TB000FConfigWebServer.SetConfigurazione;
var
  Valore, NomeFileConfig, ComInit: String;
  IniFile: TIniFile;
  i:Integer;
  StringList:TStringList;
begin
  if rgpApplicativo.ItemIndex = ItemIrisWeb then
    NomeFileConfig:=FILE_CONFIG_IRISWEB
  else if rgpApplicativo.ItemIndex = ItemIrisCloud then
    NomeFileConfig:=FILE_CONFIG_IRISCLOUD
  else if rgpApplicativo.ItemIndex = ItemX001 then
    NomeFileConfig:=FILE_CONFIG_X001;
  IniFile:=TIniFile.Create(ExtractFilePath(Application.ExeName) + NomeFileConfig);
  try
    //impostazioni operative

    // sezione impostazioni operative
    W000ParConfig.Database:=Trim(cmbDatabase.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_DATABASE,W000ParConfig.Database);

    W000ParConfig.Azienda:=Trim(edtAziendaDefault.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_AZIENDA,W000ParConfig.Azienda);

    if edtProfiloDefault.Visible then
    begin
      W000ParConfig.Profilo:=Trim(edtProfiloDefault.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_PROFILO,W000ParConfig.Profilo);
    end;

    if edtMaxSessioni.Visible then
    begin
      Valore:=Trim(edtMaxSessioni.Text);
      if not TryStrToInt(Valore,W000ParConfig.MaxSessioni) then
        raise Exception.Create('Il numero massimo di sessioni web indicato non è valido.'#13#10'Indicare un valore intero compreso fra 0 e 9999');
      IniFile.WriteInteger(INI_SEZ_IMPOST_OPER,INI_ID_MAX_SESSIONI,W000ParConfig.MaxSessioni);
    end;

    if edtUrlSuperoMaxSessioni.Visible then
    begin
      W000ParConfig.UrlSuperoMaxSessioni:=Trim(edtUrlSuperoMaxSessioni.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_SUP_MAX_SESS,W000ParConfig.UrlSuperoMaxSessioni);
    end;

    if edtTOOperatore.Visible then
    begin
      Valore:=Trim(edtTOOperatore.Text);
      if not TryStrToInt(Valore,W000ParConfig.TimeoutOper) then
        raise Exception.Create('Il valore del timeout operatore non è valido.'#13#10'Indicare un valore intero compreso fra 1 e 999');
      IniFile.WriteInteger(INI_SEZ_IMPOST_OPER,INI_ID_TIMEOUT_OPER,W000ParConfig.TimeoutOper);
    end;

    if edtTODipendente.Visible then
    begin
      Valore:=Trim(edtTODipendente.Text);
      if not TryStrToInt(Valore,W000ParConfig.TimeoutDip) then
        raise Exception.Create('Il valore del timeout dipendente non è valido.'#13#10'Indicare un valore intero compreso fra 1 e 999');
      IniFile.WriteInteger(INI_SEZ_IMPOST_OPER,INI_ID_TIMEOUT_DIP,W000ParConfig.TimeoutDip);
    end;

    W000ParConfig.Home:=Trim(edtHome.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_HOME,W000ParConfig.Home);

    W000ParConfig.UrlLoginErrato:=Trim(edtUrlLoginErrato.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_LOGINERR,W000ParConfig.UrlLoginErrato);

    W000ParConfig.PathLog:=Trim(edtPathLog.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_PATH_LOG,W000ParConfig.PathLog);

    if edtUrlWsAuth.Visible then
    begin
      W000ParConfig.UrlWSAutenticazione:=Trim(edtUrlWsAuth.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_WS_AUT,W000ParConfig.UrlWSAutenticazione);
    end;

    W000ParConfig.UrlManutenzione:=Trim(edtURLMan.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_MANUTENZIONE,W000ParConfig.UrlManutenzione);

    W000ParConfig.UrlIrisWebCloud:=Trim(edtUrlIrisWebCloud.Text);
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_URL_IRISWEBCLOUD,W000ParConfig.UrlIrisWebCloud);

    W000ParConfig.IrisWebCloudNewTab:=IfThen(chkIrisWebCloudNewTab.Checked,'S','N');
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_IRISWEBCLOUD_NEWTAB,W000ParConfig.IrisWebCloudNewTab);

    if chkLoginEsterno.Visible then
    begin
      W000ParConfig.LoginEsterno:=IfThen(chkLoginEsterno.Checked,'S','N');
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_LOGIN_ESTERNO,W000ParConfig.LoginEsterno);
    end;

    if edtPaginaIniziale.Visible then
    begin
      W000ParConfig.PaginaIniziale:=Trim(edtPaginaIniziale.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_STARTPAGE,W000ParConfig.PaginaIniziale);
    end;

    if edtPaginaSingola.Visible then
    begin
      W000ParConfig.PaginaSingola:=Trim(edtPaginaSingola.Text);
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_SINGLEPAGE,W000ParConfig.PaginaSingola);
    end;

    W000ParConfig.CampiInvisibili:=lstCampiInvisibili.Items.CommaText;
    IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_CAMPI_INVISIBILI,W000ParConfig.CampiInvisibili);

    if edtTabColPartenza.Visible then
    begin
      W000ParConfig.TabColPartenza:=edtTabColPartenza.Text;
      IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_TAB_COL_PARTENZA,W000ParConfig.TabColPartenza);
    end;

    if edtNumLivelli.Visible then
    begin
      Valore:=Trim(edtNumLivelli.Text);
      if not TryStrToInt(Valore,W000ParConfig.NumLivelli) then
        raise Exception.Create('Il numero di livelli indicato non è valido.'#13#10'Indicare un valore intero compreso fra 0 e 999');
      IniFile.WriteInteger(INI_SEZ_IMPOST_OPER,INI_ID_NUM_LIVELLI,W000ParConfig.NumLivelli);
    end;

    // sezione impostazioni di sistema
    Valore:=Trim(edtPort.Text);
    if not TryStrToInt(Valore,W000ParConfig.Port) then
      raise Exception.Create('Il numero di porta indicato non è valido.'#13#10'Indicare un valore intero.');
    IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_PORT,W000ParConfig.Port);

    if edtCursoriLogin.Visible then
    begin
      Valore:=Trim(edtCursoriLogin.Text);
      if not TryStrToInt(Valore,W000ParConfig.CursoriLogin) then
        raise Exception.Create('Il numero di cursori per il login indicato non è valido.'#13#10'Indicare un valore intero.');
      IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_CURSORI_LOGIN,W000ParConfig.CursoriLogin);
    end;

    if edtCursoriSessione.Visible then
    begin
      Valore:=Trim(edtCursoriSessione.Text);
      if not TryStrToInt(Valore,W000ParConfig.CursoriSessione) then
        raise Exception.Create('Il numero di cursori per sessione indicato non è valido.'#13#10'Indicare un valore intero.');
      IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_CURSORI_SESSIONE,W000ParConfig.CursoriSessione);
    end;

    if edtMaxOpenCursors.Visible then
    begin
      Valore:=Trim(edtMaxOpenCursors.Text);
      if not TryStrToInt(Valore,W000ParConfig.MaxOpenCursors) then
        raise Exception.Create('Il numero massimo di open cursor indicato non è valido.'#13#10'Indicare un valore intero.');
      IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_MAX_OPEN_CURSORS,W000ParConfig.MaxOpenCursors);
    end;

    Valore:=Trim(edtMaxProcessMemory.Text);
    if not TryStrToInt(Valore,W000ParConfig.MaxWorkingMemMb) then
      raise Exception.Create('La memoria massima per il processo indicata non è valida.'#13#10'Indicare 0 per disabilitare il controllo'#13#10'oppure un valore maggiore di 0.');
    IniFile.WriteInteger(INI_SEZ_IMPOST_SIST,INI_ID_MAX_WORKING_MEMORY,W000ParConfig.MaxWorkingMemMb);

    // log abilitati
    W000ParConfig.LogAbilitati:=IfThen(chkErrore.Checked,INI_LOG_ERRORE + ',') +
                                IfThen(chkMemoria.Checked,INI_LOG_MEMORIA + ',') +
                                IfThen(chkSessione.Checked,INI_LOG_SESSIONE + ',') +
                                IfThen(chkAccesso.Checked,INI_LOG_ACCESSO + ',') +
                                IfThen(chkTraccia.Checked,INI_LOG_TRACCIA + ',');
    if Length(W000ParConfig.LogAbilitati) > 0 then
      W000ParConfig.LogAbilitati:=Copy(W000ParConfig.LogAbilitati,1,Length(W000ParConfig.LogAbilitati) - 1);
    IniFile.WriteString(INI_SEZ_IMPOST_SIST,INI_ID_LOG_ABILITATI,W000ParConfig.LogAbilitati);

    // parametri avanzati
    W000ParConfig.ParametriAvanzati:=R180GetCheckList(50,chkParametriAvanzati);
    case rgpCom.ItemIndex of
      0: ComInit:='';
      1: ComInit:=',' + INI_COM_NONE;
      2: ComInit:=',' + INI_COM_NORMAL;
      3: ComInit:=',' + INI_COM_MULTI;
    end;
    W000ParConfig.ParametriAvanzati:=W000ParConfig.ParametriAvanzati + ComInit;
    IniFile.WriteString(INI_SEZ_IMPOST_SIST,INI_ID_PARAMETRI_AVANZATI,W000ParConfig.ParametriAvanzati);

    // IW Exception logger
    if grpExceptionLogger.Visible then
    begin
      IniFile.WriteString(INI_SEZ_IMPOST_IW_LOG,INI_EL_ABILITATO,
                          IfThen(chkEnableExcLog.Checked,'S','N'));
      IniFile.WriteString(INI_SEZ_IMPOST_IW_LOG,INI_EL_PATH_FILE_LOG,Trim(edtELPathFile.Text));
      IniFile.WriteString(INI_SEZ_IMPOST_IW_LOG,INI_EL_NOME_FILE_LOG,Trim(edtELNomeFile.Text));
      IniFile.WriteInteger(INI_SEZ_IMPOST_IW_LOG,INI_EL_GIORNI_RIMOZIONE,edtELNumGiorniPurge.Value);
      StringList:=TStringList.Create;
      try
        StringList.CaseSensitive:=False;
        StringList.Sorted:=True;
        StringList.Duplicates:=TDuplicates.dupIgnore;
        StringList.StrictDelimiter:=True;
        StringList.DelimitedText:=Trim(edtELEccCustom.Text);
        for i:=0 to (chkELEccPredefinite.Items.Count - 1) do
        begin
          if chkELEccPredefinite.Checked[i] then
            StringList.Add(chkELEccPredefinite.Items[i]);
        end;
        IniFile.WriteString(INI_SEZ_IMPOST_IW_LOG,INI_EL_ECCEZ_IGNORATE,StringList.DelimitedText);
      finally
        FreeAndNil(StringList);
      end;
    end;
  finally
    FreeAndNil(IniFile);
  end;
end;
// 9.1 - eliminata gestione su registro.fine

procedure TB000FConfigWebServer.AttivaCampiParametri(Attiva: Boolean);
begin
  rgpApplicativo.Enabled:=not Attiva;
  if rgpApplicativo.Enabled then
    AbilitazioneFileConfig;

  // impostazioni operative
  cmbDatabase.Enabled:=Attiva;
  edtAziendaDefault.ReadOnly:=not Attiva;
  edtProfiloDefault.ReadOnly:=not Attiva;
  edtMaxSessioni.ReadOnly:=not Attiva;
  edtUrlSuperoMaxSessioni.ReadOnly:=not Attiva;
  edtTOOperatore.ReadOnly:=not Attiva;
  edtTODipendente.ReadOnly:=not Attiva;
  edtHome.ReadOnly:=not Attiva;
  edtUrlLoginErrato.ReadOnly:=not Attiva;
  edtPathLog.ReadOnly:=not Attiva;
  edtUrlWsAuth.ReadOnly:=not Attiva;
  edtURLMan.ReadOnly:=not Attiva;
  edtUrlIrisWebCloud.ReadOnly:=not Attiva;
  chkIrisWebCloudNewTab.Enabled:=Attiva;
  chkLoginEsterno.Enabled:=Attiva;
  edtTabColPartenza.ReadOnly:=not Attiva;
  edtNumLivelli.ReadOnly:=not Attiva;
  edtPaginaIniziale.ReadOnly:=not Attiva;
  edtPaginaSingola.ReadOnly:=not Attiva;

  // impostazioni di sistema
  edtPort.ReadOnly:=not Attiva;
  edtCursoriLogin.ReadOnly:=not Attiva;
  edtCursoriSessione.ReadOnly:=not Attiva;
  edtMaxOpenCursors.ReadOnly:=not Attiva;
  edtMaxProcessMemory.ReadOnly:=not Attiva;

  // campi da non visualizzare
  cmbPagina.Enabled:=Attiva;
  cmbComponente.Enabled:=Attiva;
  btnAggiungiCI.Enabled:=Attiva;
  lstCampiInvisibili.Enabled:=Attiva;

  // log abilitati
  chkErrore.Enabled:=Attiva;
  chkMemoria.Enabled:=Attiva;
  chkSessione.Enabled:=Attiva;
  chkAccesso.Enabled:=Attiva;
  chkTraccia.Enabled:=Attiva;

  // parametri avanzati
  chkParametriAvanzati.Enabled:=Attiva;
  rgpCom.Enabled:=Attiva;

  // altro - exception logger
  chkEnableExcLog.Enabled:=Attiva;
  lblELPathFile.Enabled:=Attiva and chkEnableExcLog.Checked;
  edtELPathFile.Enabled:=Attiva and chkEnableExcLog.Checked;
  lblELNomeFile.Enabled:=Attiva and chkEnableExcLog.Checked;
  edtELNomeFile.Enabled:=Attiva and chkEnableExcLog.Checked;
  lblELPurge1.Enabled:=Attiva and chkEnableExcLog.Checked;
  lblELPurge2.Enabled:=Attiva and chkEnableExcLog.Checked;
  edtELNumGiorniPurge.Enabled:=Attiva and chkEnableExcLog.Checked;
  memELHelp.Enabled:=Attiva and chkEnableExcLog.Checked;
  grpELEcc.Enabled:=Attiva and chkEnableExcLog.Checked;
  lblELEccPredefinite.Enabled:=Attiva and chkEnableExcLog.Checked;
  chkELEccPredefinite.Enabled:=Attiva and chkEnableExcLog.Checked;
  lblELEccCustom.Enabled:=Attiva and chkEnableExcLog.Checked;
  edtELEccCustom.Enabled:=Attiva and chkEnableExcLog.Checked;
end;

procedure TB000FConfigWebServer.btnModificaClick(Sender: TObject);
begin
  InModifica:=True;
  btnModifica.Enabled:=False;
  btnModifica2.Enabled:=False;
  btnAnnulla.Enabled:=True;
  btnAnnulla2.Enabled:=True;
  btnSalva.Enabled:=True;
  btnSalva2.Enabled:=True;
  AttivaCampiParametri(True);
end;

procedure TB000FConfigWebServer.btnAnnullaClick(Sender: TObject);
begin
  InModifica:=False;
  btnModifica.Enabled:=True;
  btnModifica2.Enabled:=True;
  btnAnnulla.Enabled:=False;
  btnAnnulla2.Enabled:=False;
  btnSalva.Enabled:=False;
  btnSalva2.Enabled:=False;
  AttivaCampiParametri(False);
  //LeggiRegistro;
  GetConfigurazione;
end;

procedure TB000FConfigWebServer.btnClearMemoClick(Sender: TObject);
begin
  memRisultato.Clear;
end;

procedure TB000FConfigWebServer.chkFiltroErroreClick(Sender: TObject);
begin
  FiltroMsg:='';
  if chkFiltroErrore.Checked then
    FiltroMsg:='(MSG = ''<Er>*'')';
  if chkFiltroSessione.Checked then
    FiltroMsg:=IfThen(FiltroMsg <> '',FiltroMsg + ' or ') + '(MSG = ''<Se>*'')';
  if chkFiltroAccesso.Checked then
    FiltroMsg:=IfThen(FiltroMsg <> '',FiltroMsg + ' or ') + '(MSG = ''<Ac>*'')';
  if chkFiltroTraccia.Checked then
    FiltroMsg:=IfThen(FiltroMsg <> '',FiltroMsg + ' or ') + '(MSG = ''<Tr>*'')';
  if chkFiltroMemoria.Checked then
    FiltroMsg:=IfThen(FiltroMsg <> '',FiltroMsg + ' or ') + '(MSG = ''<Me>*'')';

  if B000FConfigWebServerDM.selMsgDett.Active then
  begin
    B000FConfigWebServerDM.selMsgDett.Filtered:=False;
    B000FConfigWebServerDM.selMsgDett.Filter:=FiltroMsg;
    B000FConfigWebServerDM.selMsgDett.Filtered:=(FiltroMsg <> '');
  end;
end;

procedure TB000FConfigWebServer.chkEnableExcLogClick(Sender: TObject);
begin
  AttivaCampiParametri(InModifica);
end;

procedure TB000FConfigWebServer.cmbAzioniChange(Sender: TObject);
begin
  if cmbAzioni.ItemIndex < 0 then
    lblDescrizioneAzione.Caption:=''
  else
    lblDescrizioneAzione.Caption:=A000AzioniSitoWeb[cmbAzioni.ItemIndex].Descrizione;
end;

procedure TB000FConfigWebServer.cmbPaginaChange(Sender: TObject);
var
  i: Integer;
  CompList: TStringList;
begin
  cmbComponente.Clear;
  if cmbPagina.ItemIndex < 0 then
    Exit;

  CompList:=TStringList.Create;
  try
    CompList.CommaText:=Elementi[cmbPagina.ItemIndex].Elementi;
    cmbComponente.Items.BeginUpdate;
    for i:=0 to CompList.Count - 1 do
      cmbComponente.Items.Add(CompList[i]);
    cmbComponente.Items.EndUpdate;
  finally
    FreeAndNil(CompList);
  end;
end;

procedure TB000FConfigWebServer.cmbURLDataBaseChange(Sender: TObject);
begin
  ViewURL;
end;

procedure TB000FConfigWebServer.btnAggiungiCIClick(Sender: TObject);
var
  S,SUp: String;
  i: Integer;
  Found: Boolean;
begin
  if cmbComponente.Text <> '' then
  begin
    S:=IfThen(trim(cmbPagina.Text) <> '',trim(cmbPagina.Text) + '.','') + trim(cmbComponente.Text);
    SUp:=UpperCase(S);
    Found:=False;
    for i:=0 to lstCampiInvisibili.Count - 1 do
      if UpperCase(lstCampiInvisibili.Items[i]) = SUp then
      begin
        Found:=True;
        break;
      end;
    if not Found then
      lstCampiInvisibili.Items.Add(S);
  end
  else
    beep;
end;

procedure TB000FConfigWebServer.AddToMemo(var PMemo: TMemo; const PLine: String);
var
  LLine, Ora, Sep: String;
begin
  Ora:=FormatDateTime('hhhh.mm.ss',Now);
  Sep:=' - ';
  if PLine.Contains(#13#10) then
    LLine:=StringReplace(PLine,#13#10,#13#10 + StringOfChar(' ',Length(Ora) + Length(Sep)),[rfReplaceAll])
  else
    LLine:=PLine;
  PMemo.Lines.Add(Format('%s%s%s',[Ora,Sep,LLine]));
  PMemo.Repaint;
end;

procedure TB000FConfigWebServer.btnEseguiAzioneClick(Sender: TObject);
var
  Comando, NomeSrv, Url, Html: String;
begin
  memRisultato.Clear;
  if cmbAzioni.ItemIndex < 0 then
  begin
    R180MessageBox('Selezionare un''azione da eseguire',INFORMA);
  end
  else
  begin
    cmbAzioni.Enabled:=False;
    btnEseguiAzione.Enabled:=False;

    AddToMemo(memRisultato,Format('%s: attendere...',[cmbAzioni.Text]));

    // determina eventuale comando
    Comando:=A000AzioniSitoWeb[cmbAzioni.ItemIndex].Comando;
    if Copy(Comando,1,1) = '#' then
    begin
      // 1. azioni personalizzate
      //    #1 = riavvio sito
      //    #2 = arresto sito
      //    #3 = avvio sito
      try
        case rgpTipoInstallazione.ItemIndex of
          0: begin
               // IIS
               if (Comando = '#01') or (Comando = '#02') then
               begin
                 // riavvio oppure arresto
                 AddToMemo(memRisultato,'Arresto di IIS con iisreset...');
                 //ExecuteAndWait('cmd.exe /C iisreset -stop');
                 R180SyncProcessExec('cmd.exe /C iisreset -stop','','');
               end;
               if (Comando = '#01') or (Comando = '#03') then
               begin
                 // riavvio oppure avvio
                 AddToMemo(memRisultato,'Avvio di IIS con iisreset...');
                 //ExecuteAndWait('cmd.exe /C iisreset -start');
                 R180SyncProcessExec('cmd.exe /C iisreset -start','','');
               end;
             end;
          1: begin
               // Windows service
               if rgpApplicativo.ItemIndex = ItemIrisWeb then
                 NomeSrv:=ITEM_SRV_NAME_IRISWEB
               else if rgpApplicativo.ItemIndex = ItemIrisCloud then
                 NomeSrv:=ITEM_SRV_NAME_IRISCLOUD
               else if rgpApplicativo.ItemIndex = ItemX001 then
                 NomeSrv:=ITEM_SRV_NAME_X001;

               if (Comando = '#01') or (Comando = '#02') then
               begin
                 // riavvio oppure arresto
                 AddToMemo(memRisultato,Format('Arresto del servizio %s in corso...',[NomeSrv]));
                 //ExecuteAndWait('cmd.exe /C net stop ' + NomeSrv);
                 R180SyncProcessExec('cmd.exe /C net stop ' + NomeSrv,'','');
               end;
               if (Comando = '#01') or (Comando = '#03') then
               begin
                 // riavvio oppure avvio
                 AddToMemo(memRisultato,Format('Avvio del servizio %s in corso...',[NomeSrv]));
                 //ExecuteAndWait('cmd.exe /C net start ' + NomeSrv);
                 R180SyncProcessExec('cmd.exe /C net start ' + NomeSrv,'','');
               end;
             end;
        end;
        AddToMemo(memRisultato,Format('%s completato',[cmbAzioni.Text]));
      except
        on E: Exception do
        begin
          AddtoMemo(memRisultato,Format('Errore: %s (%s)',[E.Message,E.ClassName]));
          AddToMemo(memRisultato,Format('%s non completato correttamente',[cmbAzioni.Text]));
        end;
      end;
    end
    else
    begin
      // 2. comandi standard

      // determina url
      Url:=edtUrlBase.Text + Comando;

      AddToMemo(memRisultato,Format('Comando %s',[Copy(Comando,2)]));
      AddToMemo(memRisultato,Url);

      try
        AddToMemo(memRisultato,'...');
        Html:=IdHTTP1.Get(Url);
        AddToMemo(memRisultato,Format('%s eseguito correttamente',[cmbAzioni.Text]));
      except
        on E: Exception do
        begin
          AddtoMemo(memRisultato,Format('Errore: %s (%s)',[E.Message,E.ClassName]));
          AddToMemo(memRisultato,Format('%s non eseguito correttamente',[cmbAzioni.Text]));
        end;
      end;
    end;

    // abilita interfaccia
    cmbAzioni.Enabled:=True;
    btnEseguiAzione.Enabled:=True;
  end;
end;

procedure TB000FConfigWebServer.ApriUrl(const PContesto: String);
begin
  ShellExecute(0,'OPEN',PChar(edtUrlBase.Text + PContesto),'','', SW_SHOWNORMAL);
end;

procedure TB000FConfigWebServer.lblAccessoSitoClick(Sender: TObject);
begin
  ApriUrl('?loginesterno=N');
end;

procedure TB000FConfigWebServer.lnkMonitorSessioniClick(Sender: TObject);
begin
  ApriUrl('/iwmonitor?id=mondoedp');
end;

procedure TB000FConfigWebServer.lnkVisParametriConfigClick(Sender: TObject);
begin
  ApriUrl('/iwconfig?id=mondoedp');
end;

procedure TB000FConfigWebServer.lstCampiInvisibiliDblClick(Sender: TObject);
begin
  if lstCampiInvisibili.ItemIndex > -1 then
    lstCampiInvisibili.DeleteSelected;
end;

procedure TB000FConfigWebServer.lstCampiInvisibiliKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 46) and (lstCampiInvisibili.ItemIndex <> -1) then
    lstCampiInvisibili.DeleteSelected;
end;

procedure TB000FConfigWebServer.mnuFiltraIdSessioneClick(Sender: TObject);
begin
  //
end;

procedure TB000FConfigWebServer.mnuFiltraIPClick(Sender: TObject);
begin
  //
end;

procedure TB000FConfigWebServer.btnMidasRegClick(Sender: TObject);
var
  FN,Par: String;
  Ret: Integer;
  Registra: Boolean;
  function DecodeErr(ErrCode: Integer): String;
  begin
    case Ret of
     0: Result:='not enough memory';
     2: Result:='file not found';
     3: Result:='path not found';
     5: Result:='access denied (Windows 95)';
     8: Result:='not enough memory (Windows 95)';
    10: Result:='wrong Windows version';
    11: Result:='.EXE file is invalid (non-Win32 .EXE or error in .EXE image).';
    12: Result:='application was designed for a different operating system';
    13: Result:='application was designed for MS-DOS 4.0';
    15: Result:='attempt to load a real-mode program';
    16: Result:='attempt to load a second instance of an application with non-readonly data segments';
    19: Result:='attempt to load a compressed application file';
    20: Result:='dynamic-link library (DLL) file failure';
    26: Result:='sharing violation';
    27: Result:='filename association incomplete or invalid';
    28: Result:='DDE request timed out';
    29: Result:='DDE transaction failed';
    30: Result:='DDE busy';
    31: Result:='no application associated with the given filename extension';
    32: Result:='dynamic-link library not found';
    else
      Result:='undocumented';
  end;
  end;
begin
  //ShellExecute(0,'open','regsvr32',  PChar(FPath), NIL, SW_SHOWNORMAL);
  if (Sender = btnMidasReg) or (Sender = btnMidasUnReg) then
  begin
    // librerie generali
    FN:='regsvr32';
    Par:=IfThen(Sender = btnMidasReg,'midas.dll','/u midas.dll');
    if FileExists('midas.dll') then
    begin
      Ret:=ShellExecute(0,'open',PChar(FN),PChar(Par),nil,SW_NORMAL);
      if (Ret >= 0) and (Ret <= 32) then
        R180MessageBox('L''operazione non è andata a buon fine.' + #13#10 +
                       'Codice di errore ' + IntToStr(Ret) + ': ' + DecodeErr(Ret),ESCLAMA);
    end
    else
      R180MessageBox('Attenzione! Il file midas.dll non è stato trovato.',INFORMA);
  end
  else
  begin
    // componenti per le stampe
    if Sender = btnRegA077PComServer then
      FN:='A077PCOMServer.exe'
    else if Sender = btnUnRegA077PComServer then
      FN:='A077PCOMServer.exe'
    else if Sender = btnRegBc28PComServer then
      FN:='Bc28PPrintServer_COM.exe'
    else if Sender = btnUnRegBc28PComServer then
      FN:='Bc28PPrintServer_COM.exe';

    Registra:=(Sender = btnRegA077PComServer) or
              (Sender = btnRegBc28PCOMServer);
    Par:=IfThen(Registra,'/regserver','/unregserver');
    if FileExists(FN) then
    begin
      Ret:=ShellExecute(0,'open',PChar(FN),PChar(Par),nil,SW_HIDE);
      if (Ret >= 0) and (Ret <= 32) then
        R180MessageBox('L''operazione non è andata a buon fine.' + #13#10 +
                       'Codice di errore ' + IntToStr(Ret) + ': ' + DecodeErr(Ret),ESCLAMA)
      else
      begin
        if Registra then
          R180MessageBox('Il componente ' + FN + ' è stato registrato.',INFORMA)
        else
          R180MessageBox('La registrazione del componente ' + FN + ' è stata annullata.' + #13#10 +
                         'Potrebbe essere necessario eseguire una nuova registrazione.',INFORMA);
      end
    end
    else
      R180MessageBox('Attenzione! Il file ' + FN + ' non è stato trovato.',INFORMA);
  end;
end;

procedure TB000FConfigWebServer.ViewURL;
var
  UrlPar: String;
  procedure AddPar(const Nome, Valore: String);
  var
    LVal: String;
  begin
    LVal:=Trim(Valore);
    if LVal <> '' then
      UrlPar:=UrlPar + IfThen(UrlPar = '','?','&') + Format('%s=%s',[Nome,LVal])
  end;
begin
  if (edtUrlAzienda.Text = '') or ((edtUrlAzienda.Text <> '') and ((edtUrlUtente.Text = '') and (edtUrlPassword.Text <> ''))) then
    edtURLGenerato.Text:=''
  else
  begin
    UrlPar:='';
    AddPar('azienda',edtUrlAzienda.Text);
    AddPar('usr',edtUrlUtente.Text);
    AddPar('pwd',edtUrlPassword.Text);
    AddPar('profilo',edtUrlProfilo.Text);
    AddPar('database',cmbUrlDatabase.Text);
    AddPar('home',edtUrlHome.Text);
    edtURLGenerato.Text:=edtUrlBase.Text + UrlPar;
  end;
end;

procedure TB000FConfigWebServer.edtUrlAziendaChange(Sender: TObject);
begin
  ViewURL;
end;

procedure TB000FConfigWebServer.edtUrlBaseChange(Sender: TObject);
begin
  ViewURL;
end;

procedure TB000FConfigWebServer.btnSalvaClick(Sender: TObject);
begin
  SetConfigurazione;

  AttivaCampiParametri(False);
  InModifica:=False;
  btnModifica.Enabled:=True;
  btnModifica2.Enabled:=True;
  btnAnnulla.Enabled:=False;
  btnAnnulla2.Enabled:=False;
  btnSalva.Enabled:=False;
  btnSalva2.Enabled:=False;
end;

procedure TB000FConfigWebServer.Button2Click(Sender: TObject);
var Registro:TRegistry;
begin
  if MessageDlg('Lanciare RegEdit ed eseguire il salvataggio della chiave "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion".' + #13#10 +
                'Continuare con la configurazione della stampante?',
                mtConfirmation,[mbYes,mbNo],0,mbNo) = mrNo then
    exit;

  Registro:=TRegistry.Create;
  try
    Registro.RootKey:=HKEY_USERS;
    if Registro.OpenKey('.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion',False) then
    begin
      try
        Registro.DeleteKey('Devices');
        Registro.DeleteKey('PrinterPorts');
        //Registro.DeleteKey('Windows');
        Registro.CreateKey('Devices');
        Registro.CreateKey('PrinterPorts');
        //Registro.CreateKey('Windows');
        Registro.CloseKey;

        Registro.OpenKey('.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion\Devices',False);
        Registro.WriteString('Microsoft XPS Document Writer','winspool,LPT1:');
        Registro.CloseKey;
        Registro.OpenKey('.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion\PrinterPorts',False);
        Registro.WriteString('Microsoft XPS Document Writer','winspool,LPT1:');
        Registro.CloseKey;
        Registro.OpenKey('.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion\Windows',False);
        Registro.DeleteValue('Device');
        Registro.DeleteValue('UserSelectedDefault');
        Registro.WriteString('Device','Microsoft XPS Document Writer,winspool,LPT1:');
        Registro.WriteInteger('UserSelectedDefault',0);
        Registro.CloseKey;
      except
        Registro.CloseKey;
        raise;
      end;
    end;
  finally
    FreeAndNil(Registro);
  end;
  ShowMessage('Effettuata configurazione delle chiavi Devices, PrinterPorts e Windows in "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion"');
end;

procedure TB000FConfigWebServer.btnLogonClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  with B000FConfigWebServerDM do
  begin
    if btnLogon.Caption = 'Connetti' then
    begin
      if DbMessaggi.Connected then
        DbMessaggi.LogOff;
      DbMessaggi.LogonUsername:=edtUtenteMsg.Text;
      DbMessaggi.LogonPassword:=edtPasswordMsg.Text;
      DbMessaggi.LogonDatabase:=cmbDatabaseMsg.Text;
      try
        StatusBar1.Panels[1].Text:='Connessione...';
        StatusBar1.Repaint;
        DbMessaggi.Logon;
      except
        R180MessageBox('Connessione non riuscita!',ERRORE);
        Screen.Cursor:=crDefault;
        Exit;
      end;

      if DbMessaggi.Connected then
      begin
        btnFiltra.Enabled:=True;
        grpDett.Visible:=True;
        selMsgHead.AfterScroll:=nil;
        selMsgHead.Close;
        try
          // apertura dataset
          if (Trim(StringReplace(edtDal.Text,'/','',[rfReplaceAll])) = '') or
             (Trim(StringReplace(edtAl.Text,'/','',[rfReplaceAll])) = '') then
          begin
            selMsgHead.ClearVariables;
            selMsgHead.Open;
          end
          else
          begin
            btnFiltraClick(nil);
          end;
          // salva data del primo messaggio
          selMsgHead.Last;
          DalOrig:=Trunc(selMsgHead.FieldByName('DATA').AsDateTime);
          selMsgHead.First;
          AlOrig:=Date;
          lblNumMsg.Caption:=Format('Num. messaggi: %d',[selMsgHead.RecordCount]);
          edtDal.Text:=DateToStr(DalOrig);
          edtAl.Text:=DateToStr(AlOrig);
        finally
          selMsgHead.AfterScroll:=selMsgHeadAfterScroll;
          selMsgHeadAfterScroll(nil);
          btnLogon.Caption:='Disconnetti';
          Screen.Cursor:=crDefault;
        end;
      end;
    end
    else
    begin
      StatusBar1.Panels[1].Text:='Disconnessione...';
      StatusBar1.Repaint;
      btnFiltra.Enabled:=False;
      grpDett.Visible:=False;
      // chiusura dataset
      try selMsgDett.CloseAll; except end;
      try selMsgHead.CloseAll; except end;
      try DbMessaggi.LogOff;  except end;
      btnLogon.Caption:='Connetti';
      Screen.Cursor:=crDefault;
    end;
  end;

  if B000FConfigWebServerDM.DbMessaggi.Connected then
  begin
    StatusBar1.Panels[1].Text:='Connesso';
    StatusBar1.Panels[2].Text:=B000FConfigWebServerDM.DbMessaggi.ServerVersion;
  end
  else
  begin
    StatusBar1.Panels[1].Text:='Non connesso';
    StatusBar1.Panels[2].Text:='';
  end;
  StatusBar1.Repaint;
end;

procedure TB000FConfigWebServer.btnFiltraClick(Sender: TObject);
var
  Dal,Al: TDateTime;
begin
  if not TryStrToDateTime(edtDal.Text,Dal) then
  begin
    R180MessageBox('La data di inizio periodo non è valida!',INFORMA);
    Exit;
  end;
  if not TryStrToDateTime(edtAl.Text,Al) then
  begin
    R180MessageBox('La data di fine periodo non è valida!',INFORMA);
    Exit;
  end;
  if Dal > Al then
  begin
    R180MessageBox('Il periodo indicato non è valido!',INFORMA);
    Exit;
  end;
  // determina il filtro periodo
  if (Dal = DalOrig) and (Al = AlOrig) then
    FiltroPeriodo:=''
  else if Dal = Al then
    FiltroPeriodo:=Format('having to_date(''%s'',''ddmmyyyy'') between trunc(min(I006.DATA_MSG)) and max(I006.DATA_MSG)',[FormatDateTime('ddmmyyyy',Dal)])
  else
    FiltroPeriodo:=Format('having max(I006.DATA_MSG) >= to_date(''%s'',''ddmmyyyy'') and trunc(min(I006.DATA_MSG)) <= to_date(''%s'',''ddmmyyyy'')',
                          [FormatDateTime('ddmmyyyy',Dal),FormatDateTime('ddmmyyyy',Al)]);

  // applica il filtro periodo
  B000FConfigWebServerDM.selMsgDett.Close;
  grpDett.Visible:=False;

  B000FConfigWebServerDM.selMsgHead.Close;
  B000FConfigWebServerDM.selMsgHead.SetVariable('FILTRO_PERIODO',FiltroPeriodo);
  B000FConfigWebServerDM.selMsgHead.Open;
  lblNumMsg.Caption:=Format('Num. messaggi: %d',[B000FConfigWebServerDM.selMsgHead.RecordCount]);
end;

function TB000FConfigWebServer.GetUrlBase: String;
var
  MyHostName: String;
  MyIP: String;
  MYWSError: String;
begin
  // url base
  if R180GetIPFromHost(MyHostName,MyIP,MyWSError) then
    Result:=Format('http://%s',[MyIP])
  else
    Result:='http://localhost';

  if rgpTipoInstallazione.ItemIndex = 0 then
  begin
    // iis
    Result:=Format('%s/%s',[Result,rgpApplicativo.Items[rgpApplicativo.ItemIndex]]);
    if rgpApplicativo.ItemIndex = ItemIrisWeb then
      Result:=Format('%s/%s',[Result,ITEM_DLL_NAME_IRISWEB])
    else if rgpApplicativo.ItemIndex = ItemIrisCloud then
      Result:=Format('%s/%s',[Result,ITEM_DLL_NAME_IRISCLOUD])
    else if rgpApplicativo.ItemIndex = ItemX001 then
      Result:=Format('%s/%s',[Result,ITEM_DLL_NAME_X001]);
  end
  else
  begin
    // service
    Result:=Format('%s:%d',[Result,StrToInt(Trim(edtPort.Text))]);
  end;
end;

procedure TB000FConfigWebServer.PageControlChange(Sender: TObject);
begin
  case PageControl.TabIndex of
    2: begin
         // Tab "Generazione URL"

         // url base applicativo selezionato
         edtUrlBase.Text:=GetUrlBase;

         // generazione url con parametri
         edtUrlAzienda.Text:=edtAziendaDefault.Text;
         edtUrlProfilo.Text:=edtProfiloDefault.Text;
         cmbUrlDatabase.Text:=cmbDatabase.Text;
         edtUrlHome.Text:=edtHome.Text;
       end;
    3: begin
         cmbDatabaseMsg.Text:=cmbDatabase.Text;
         edtPasswordMsg.SetFocus;
       end;
  end;
end;

procedure TB000FConfigWebServer.PageControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  if InModifica then
    AllowChange:=False;
end;

end.
