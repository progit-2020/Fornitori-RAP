unit Bc22UGeneratoreCartellini;

interface

uses
  OracleMonitor,
  A000UInterfaccia, A000USessione,
  Bc22UGeneratoreCartelliniMW,
  C004UParamForm, C020UVisualizzaDataSet, C180FunzioniGenerali,
  Oracle, System.IOUtils, Winapi.ShellAPI, StrUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.ImgList, System.Actions, Vcl.ActnList, OracleData, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, FileCtrl;

type
  TBc22FGeneratoreCartellini = class(TForm)
    ActionList1: TActionList;
    actAvvio: TAction;
    actStop: TAction;
    actEsci: TAction;
    actServizio: TAction;
    actLeggiLog: TAction;
    ImageList1: TImageList;
    mnuFile: TMainMenu;
    File1: TMenuItem;
    Pianificazione1: TMenuItem;
    Esci1: TMenuItem;
    memLog: TMemo;
    pnl1: TPanel;
    lblDatabase: TLabel;
    lblDatabaseList: TLabel;
    lbl2: TLabel;
    edtDataBase: TEdit;
    btnDatabase: TButton;
    edtDataBaseList: TEdit;
    btnDatabaseList: TButton;
    sedtRigheLog: TSpinEdit;
    pmnServizio: TPopupMenu;
    Installa1: TMenuItem;
    Disinstalla1: TMenuItem;
    N1: TMenuItem;
    Avvia1: TMenuItem;
    Arresta1: TMenuItem;
    N2: TMenuItem;
    mnuPriority: TMenuItem;
    mnuLowest: TMenuItem;
    mnuLower: TMenuItem;
    mnuNormal: TMenuItem;
    mnuHigher: TMenuItem;
    mnuHighest: TMenuItem;
    tlb1: TToolBar;
    btnStart: TToolButton;
    btn8: TToolButton;
    btnStop: TToolButton;
    btn9: TToolButton;
    btnServizio: TToolButton;
    btn10: TToolButton;
    btnLeggiLog: TToolButton;
    btn12: TToolButton;
    btnChiudi: TToolButton;
    actServizioInstalla: TAction;
    actServizioDisinstalla: TAction;
    actServizioStart: TAction;
    actServizioStop: TAction;
    lblHome: TLabel;
    lblPathLog: TLabel;
    edtHome: TEdit;
    edtPathLog: TEdit;
    btnHome: TButton;
    btnPathLog: TButton;
    actInfo: TAction;
    actInfo1: TMenuItem;
    tmrPianificazione: TTimer;
    dgrdCartellini: TDBGrid;
    dsrVT860: TDataSource;
    Splitter1: TSplitter;
    pnlTabella: TPanel;
    btnRefresh: TBitBtn;
    lblNumRecord: TLabel;
    procedure actLeggiLogExecute(Sender: TObject);
    procedure actAvvioExecute(Sender: TObject);
    procedure actStopExecute(Sender: TObject);
    procedure actServizioExecute(Sender: TObject);
    procedure actEsciExecute(Sender: TObject);
    procedure tmrPianificazioneTimer(Sender: TObject);
    procedure actServizioInstallaExecute(Sender: TObject);
    procedure actServizioDisinstallaExecute(Sender: TObject);
    procedure actServizioStartExecute(Sender: TObject);
    procedure actServizioStopExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDataBaseClick(Sender: TObject);
    procedure btnDatabaseListClick(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
    procedure btnPathLogClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure dsrVT860StateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    SessioneOracleBc22: TOracleSession;
    C004: TC004FParamForm;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure AbilitaFunzioni(const PElaborazioneInCorso: Boolean);
    procedure GetPriority;
    procedure CtrlEseguiOperazione;
  public
    Bc22MW: TBc22FGeneratoreCartelliniMW;
  end;

var
  Bc22FGeneratoreCartellini: TBc22FGeneratoreCartellini;

const
  NUMREC_CAPTION = 'Record: %d';

implementation

{$R *.dfm}

procedure TBc22FGeneratoreCartellini.FormCreate(Sender: TObject);
begin
  A000SettaVariabiliAmbiente;
  Bc22MW:=TBc22FGeneratoreCartelliniMW.Create(nil);
  dsrVT860.DataSet:=Bc22MW.selVT860;
end;

procedure TBc22FGeneratoreCartellini.FormShow(Sender: TObject);
var
  Alias: String;
begin
  Alias:=R180GetRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'Database','IRIS');
  InputQuery(Self.Caption,'Selezionare database',Alias);
  SessioneOracleBc22:=Bc22MW.SessioneOracleBc22;
  Bc22MW.ConnettiDataBase(Alias);
  edtDataBase.Text:=SessioneOracleBc22.LogonDatabase;
  if SessioneOracleBc22.Connected then
  begin
    R180PutRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'Database',Alias);
    lblDatabase.Font.Color:=clBlue;
    edtDatabase.Hint:='';
    lblDatabase.Font.Style:=[];

    // apre il dataset della vista personalizzata VT860_CARTELLINI_PDF
    // in caso di errore nella vista termina immediatamente
    try
      Bc22MW.selVT860.Close;
      Bc22MW.selVT860.Open;
      lblNumRecord.Caption:=Format(NUMREC_CAPTION,[dsrVT860.DataSet.RecordCount]);
    except
      on E: Exception do
      begin
        lblNumRecord.Caption:=Format(NUMREC_CAPTION,[0]);
        R180MessageBox('La vista personalizzata VT860_CARTELLINI_PDF è invalida oppure non definita',ESCLAMA);
      end;
    end;
  end
  else
  begin
    lblDatabase.Font.Color:=clRed;
    edtDatabase.Hint:='Database non connesso';
    lblDatabase.Font.Style:=[fsStrikeOut];
    lblNumRecord.Caption:=Format(NUMREC_CAPTION,[0]);
  end;
  try
    C004:=CreaC004(SessioneOracleBc22,Bc22_MASCHERA,0,False);
    GetParametriFunzione;
    GetPriority;
    edtDataBaseList.Text:=C004.GetParametro('DATABASELIST',R180GetRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'DatabaseList',''));
  except
    edtDataBaseList.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'DatabaseList','');
  end;

  AbilitaFunzioni(False);
end;

procedure TBc22FGeneratoreCartellini.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
end;

procedure TBc22FGeneratoreCartellini.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Bc22MW);
  FreeAndNil(C004);
end;

// ########################################################################## //

procedure TBc22FGeneratoreCartellini.AbilitaFunzioni(const PElaborazioneInCorso: Boolean);
begin
  actAvvio.Enabled:=not PElaborazioneInCorso;
  actEsci.Enabled:=not PElaborazioneInCorso;
  actStop.Enabled:=PElaborazioneInCorso;
  btnDatabase.Enabled:=not PElaborazioneInCorso;
  btnDatabaseList.Enabled:=not PElaborazioneInCorso;
  btnHome.Enabled:=not PElaborazioneInCorso;
  btnPathLog.Enabled:=not PElaborazioneInCorso;
  if PElaborazioneInCorso then
    Screen.Cursor:=crHourGlass
  else
    Screen.Cursor:=crDefault;
end;

procedure TBc22FGeneratoreCartellini.actAvvioExecute(Sender: TObject);
// avvia il timer di elaborazione
begin
  PutParametriFunzione;

  tmrPianificazione.Interval:=60000;
  AbilitaFunzioni(True);
  tmrPianificazione.Enabled:=True;
  tmrPianificazioneTimer(nil);
end;

procedure TBc22FGeneratoreCartellini.actStopExecute(Sender: TObject);
// arresta il timer di elaborazione
begin
  tmrPianificazione.Enabled:=False;
  AbilitaFunzioni(False);
end;

procedure TBc22FGeneratoreCartellini.actServizioExecute(Sender: TObject);
// gestione del servizio windows
begin
  // nessuna azione
end;

procedure TBc22FGeneratoreCartellini.actServizioInstallaExecute(Sender: TObject);
// installa il servizio windows
var
  NomeExe: String;
  ParAzione: String;
begin
  NomeExe:=Format('%s\%s',[TPath.GetDirectoryName(Application.ExeName),Bc22_SERVICE_EXE]);
  if TFile.Exists(NomeExe) then
  begin
    ParAzione:='/install';
    ShellExecute(0,'open',PChar(NomeExe),PChar(ParAzione),nil,SW_SHOWNORMAL);
  end
  else
  begin
    R180MessageBox(Format('L''eseguibile del servizio Bc22 non è presente!'#13#10'Verificare il path %s',[NomeExe]),ESCLAMA);
  end;
end;

procedure TBc22FGeneratoreCartellini.actServizioDisinstallaExecute(Sender: TObject);
// disinstalla il servizio windows
var
  NomeExe: String;
  ParAzione: String;
begin
  NomeExe:=Format('%s\%s',[TPath.GetDirectoryName(Application.ExeName),Bc22_SERVICE_EXE]);
  if TFile.Exists(NomeExe) then
  begin
    ParAzione:='/uninstall';
    ShellExecute(0,'open',PChar(NomeExe),PChar(ParAzione),nil,SW_SHOWNORMAL);
  end
  else
  begin
    R180MessageBox(Format('L''eseguibile del servizio Bc22 non è presente!'#13#10'Verificare il path %s',[NomeExe]),ESCLAMA);
  end;
end;

procedure TBc22FGeneratoreCartellini.actServizioStartExecute(Sender: TObject);
// avvia il servizio, dopo aver registrato i parametri
var
  ParAzione: String;
begin
  PutParametriFunzione;

  ParAzione:=Format('start %s',[Bc22_SERVICE_NAME]);
  ShellExecute(0,'open',PChar('net'),PChar(ParAzione),nil,SW_SHOWNORMAL);
end;

procedure TBc22FGeneratoreCartellini.actServizioStopExecute(Sender: TObject);
// arresta il servizio
var
  Azione: String;
begin
  Azione:=Format('stop %s',[Bc22_SERVICE_NAME]);
  ShellExecute(0,'open',PChar('net'),PChar(Azione),nil,SW_SHOWNORMAL);
end;

procedure TBc22FGeneratoreCartellini.actLeggiLogExecute(Sender: TObject);
// lettura dei messaggi di log da I005 / I006
begin
  RegistraMsg.SessioneOracleApp:=SessioneOracleBc22;
  RegistraMsg.LeggiMessaggi(Bc22_MASCHERA);
  RegistraMsg.GetListaMessaggi(memLog.Lines,sedtRigheLog.Value,StringOfChar('-',150));
end;

procedure TBc22FGeneratoreCartellini.actEsciExecute(Sender: TObject);
begin
  Close;
end;

procedure TBc22FGeneratoreCartellini.GetParametriFunzione;
// estrae i parametri della maschera su database
begin
  sedtRigheLog.Value:=StrToIntDef(C004.GetParametro('RIGHELOG','0'),0);
  edtHome.Text:=C004.GetParametro('HOME',R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME',''));
  edtPathLog.Text:=C004.GetParametro('PATH_LOG',R180GetRegistro(HKEY_LOCAL_MACHINE,'','PATH_LOG',''));
end;

procedure TBc22FGeneratoreCartellini.PutParametriFunzione;
// salva i parametri della maschera su database
var
  PrioritaStr: String;
  function GetPriority:Integer;
  begin
    Result:=3;
    if mnuLowest.Checked then
      Result:=mnuLowest.Tag
    else if mnuLower.Checked then
      Result:=mnuLower.Tag
    else if mnuNormal.Checked then
      Result:=mnuNormal.Tag
    else if mnuHigher.Checked then
      Result:=mnuHigher.Tag
    else if mnuHighest.Checked then
      Result:=mnuHighest.Tag;
  end;
begin
  PrioritaStr:=GetPriority.ToString;
  try
    // salva su database
    C004.Cancella001;
    C004.PutParametro('RIGHELOG',sedtRigheLog.Value.ToString);
    C004.PutParametro('DATABASELIST',edtDatabaseList.Text);
    C004.PutParametro('PRIORITY',GetPriority.ToString);
    C004.PutParametro('HOME',edtHome.Text);
    C004.PutParametro('PATH_LOG',edtPathLog.Text);
    SessioneOracleBc22.Commit;

    // salva su registro
    R180PutRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'RigheLog',sedtRigheLog.Value.ToString);
    R180PutRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'DatabaseList',edtDatabaseList.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'Priority',GetPriority.ToString);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'','HOME',edtHome.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'','PATH_LOG',edtPathLog.Text);
  except
    SessioneOracleBc22.Rollback;
  end;
end;

procedure TBc22FGeneratoreCartellini.btnDataBaseClick(Sender: TObject);
var
  Db:String;
begin
  Db:=edtDatabase.Text;
  if InputQuery('Connessione al database','Database:',Db) then
  begin
    SessioneOracleBc22.LogonDatabase:=Db;
    SessioneOracleBc22.Logoff;
  end;
  if Bc22MW.ControlloConnessioneDatabase then
  begin
    R180PutRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'Database',Db);
    edtDatabase.Text:=Db;
  end
  else
  begin
    SessioneOracleBc22.LogonDatabase:=edtDatabase.Text;
    SessioneOracleBc22.Logoff;
  end;
  if Bc22MW.ControlloConnessioneDatabase then
  begin
    lblDatabase.Font.Color:=clBlue;
    edtDatabase.Hint:='';
    lblDatabase.Font.Style:=[];
    try
      if C004 <> nil then
        FreeAndNil(C004);
      C004:=CreaC004(SessioneOracleBc22,Bc22_MASCHERA,0,False);
      GetParametriFunzione;
      GetPriority;
      edtDataBaseList.Text:=C004.GetParametro('DATABASELIST',R180GetRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'DatabaseList',''));
    except
      edtDataBaseList.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'DatabaseList','');
    end;
  end
  else
  begin
    lblDatabase.Font.Color:=clRed;
    edtDatabase.Hint:='Database non connesso';
    lblDatabase.Font.Style:=[fsStrikeOut];
  end;
end;

procedure TBc22FGeneratoreCartellini.btnDatabaseListClick(Sender: TObject);
var
  Db:String;
begin
  Db:=edtDatabaseList.Text;
  if InputQuery('Connessioni ai database','Database:',Db) then
    edtDatabaseList.Text:=Db;
end;

procedure TBc22FGeneratoreCartellini.btnHomeClick(Sender: TObject);
var
  LDir: String;
begin
  LDir:=edtHome.Text;
  if SelectDirectory('Directory Home',
                     ExtractFileDrive(''),
                     LDir,
                     [sdNewUI,sdNewFolder,sdShowEdit,sdValidateDir]) then
    edtHome.Text:=LDir;
end;

procedure TBc22FGeneratoreCartellini.btnPathLogClick(Sender: TObject);
var
  LDir: String;
begin
  LDir:=edtPathLog.Text;
  if SelectDirectory('Directory Path Log',
                     ExtractFileDrive(''),
                     LDir,
                     [sdNewUI,sdNewFolder,sdShowEdit,sdValidateDir]) then
    edtPathLog.Text:=LDir;
end;

procedure TBc22FGeneratoreCartellini.btnRefreshClick(Sender: TObject);
begin
  dsrVT860.DataSet.Close;
  dsrVT860.DataSet.Open;
  lblNumRecord.Caption:=Format(NUMREC_CAPTION,[dsrVT860.DataSet.RecordCount]);
end;

procedure TBc22FGeneratoreCartellini.tmrPianificazioneTimer(Sender: TObject);
begin
  tmrPianificazione.Enabled:=False;
  // verifica se è necessario eseguire l'operazione nell'orario corrente
  CtrlEseguiOperazione;
  AbilitaFunzioni(False);
end;

procedure TBc22FGeneratoreCartellini.GetPriority;
var P:Integer;
begin
  // leggo da C004, e se non esiste leggo da registro
  P:=StrToIntDef(C004.GetParametro('PRIORITY',R180GetRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'Priority','3')),3);
  mnuLowest.Checked:=mnuLowest.Tag = P;
  mnuLower.Checked:=mnuLower.Tag = P;
  mnuNormal.Checked:=mnuNormal.Tag = P;
  mnuHigher.Checked:=mnuHigher.Tag = P;
  mnuHighest.Checked:=mnuHighest.Tag = P;
end;

procedure TBc22FGeneratoreCartellini.CtrlEseguiOperazione;
// procedura di gestione: controlla pianificazione ed esegue l'elaborazione
begin
  {
  // controlla se è necessario eseguire l'operazione
  if not Bc22MW.IsOrarioCorrentePianificato then
    Exit;
  }

  // effettua la generazione dei pdf
  Bc22MW.GeneraPdf;
end;

procedure TBc22FGeneratoreCartellini.dsrVT860StateChange(Sender: TObject);
begin
  if dsrVT860.DataSet.Active then
    lblNumRecord.Caption:=Format(NUMREC_CAPTION,[dsrVT860.DataSet.RecordCount])
  else
    lblNumRecord.Caption:=Format(NUMREC_CAPTION,[0]);
end;

end.
