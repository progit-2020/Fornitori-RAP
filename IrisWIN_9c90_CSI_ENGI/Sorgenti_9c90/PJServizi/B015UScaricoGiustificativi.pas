unit B015UScaricoGiustificativi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Menus, Buttons, ExtCtrls, Spin, C004UParamForm, Oracle,
  ImgList, ActnList, ComCtrls, ToolWin, A000UCostanti, A000USessione, A000UInterfaccia,
  OracleData,ShellAPI, C180FunzioniGenerali, StrUtils, Variants;

type
  TB015FScaricoGiustificativi = class(TForm)
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Esci1: TMenuItem;
    Pianificazione1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    chkAvvioAutomatico: TCheckBox;
    chkAcquisisciDaPianificazione: TCheckBox;
    Memo1: TMemo;
    ToolBar1: TToolBar;
    ToolButton9: TToolButton;
    ToolButton6: TToolButton;
    ToolButton2: TToolButton;
    ToolButton7: TToolButton;
    ToolButton3: TToolButton;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    ToolButton8: TToolButton;
    ActionList1: TActionList;
    actAvvio: TAction;
    actStop: TAction;
    actEsci: TAction;
    actServizio: TAction;
    ImageList1: TImageList;
    popmnuServizio: TPopupMenu;
    Installa1: TMenuItem;
    Avvia1: TMenuItem;
    Arresta1: TMenuItem;
    Disinstalla1: TMenuItem;
    ToolButton5: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    actLeggiLog: TAction;
    actCancellaLog: TAction;
    lblDatabase: TLabel;
    edtDataBase: TEdit;
    btnDataBase: TButton;
    N1: TMenuItem;
    N2: TMenuItem;
    mnuPriority: TMenuItem;
    mnuLowest: TMenuItem;
    mnuLower: TMenuItem;
    mnuNormal: TMenuItem;
    mnuHigher: TMenuItem;
    mnuHighest: TMenuItem;
    lblDatabaseList: TLabel;
    edtDataBaseList: TEdit;
    btnDatabaseList: TButton;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpinEdit1Change(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure chkAcquisisciDaPianificazioneClick(Sender: TObject);
    procedure Esci1Click(Sender: TObject);
    procedure Pianificazione1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure actEsciExecute(Sender: TObject);
    procedure actServizioExecute(Sender: TObject);
    procedure Installa1Click(Sender: TObject);
    procedure Avvia1Click(Sender: TObject);
    procedure Arresta1Click(Sender: TObject);
    procedure Disinstalla1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actLeggiLogExecute(Sender: TObject);
    procedure actCancellaLogExecute(Sender: TObject);
    procedure btnDataBaseClick(Sender: TObject);
    procedure mnuHighestClick(Sender: TObject);
    procedure btnDatabaseListClick(Sender: TObject);
  private
    { Private declarations }
    SessioneOracleB015:TOracleSession;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure AbilitaFunzioni(ScaricoInCorso:Boolean);
    procedure GetPriority;
  public
    { Public declarations }
  end;

var
  B015FScaricoGiustificativi: TB015FScaricoGiustificativi;

implementation

uses B015UPianificazioneScarichi, R250UScaricoGiustificativiDtM;

{$R *.DFM}

procedure TB015FScaricoGiustificativi.FormActivate(Sender: TObject);
{Mi posiziono sullo scarico di Default}
var Alias:String;
begin
  GetPriority;
  Alias:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B015','Database','IRIS');
  SessioneOracleB015:=R250FScaricoGiustificativiDtM.SessioneOracleB015;
  R250FScaricoGiustificativiDtM.ConnettiDataBase(Alias);
  edtDataBase.Text:=SessioneOracleB015.LogonDatabase;
  edtDataBaseList.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B015','DatabaseList','');
  if SessioneOracleB015.Connected then
  begin
    lblDatabase.Font.Color:=clBlue;
    edtDatabase.Hint:='';
    lblDatabase.Font.Style:=[];
  end
  else
  begin
    lblDatabase.Font.Color:=clRed;
    edtDatabase.Hint:='Database non connesso';
    lblDatabase.Font.Style:=[fsStrikeOut];
  end;
  try
    CreaC004(SessioneOracleB015,'B015',Parametri.ProgOper);
    GetParametriFunzione;
  except
  end;
  chkAcquisisciDaPianificazioneClick(nil);
  with R250FScaricoGiustificativiDtM.selI150 do
    if Active then
      Locate('CORRENTE','S',[]);
  AbilitaFunzioni(False);
  if chkAvvioAutomatico.Checked then
    BitBtn1Click(nil);
end;

procedure TB015FScaricoGiustificativi.GetParametriFunzione;
begin
  SpinEdit1.Value:=StrToInt(C004FParamForm.GetParametro('MM','60'));
  chkAvvioAutomatico.Checked:=C004FParamForm.GetParametro('AUTOMATICO','N') = 'S';
  chkAcquisisciDaPianificazione.Checked:=C004FParamForm.GetParametro('ORARIPIANIFICATI','N') = 'S';
end;

procedure TB015FScaricoGiustificativi.PutParametriFunzione;
begin
  try
    C004FParamForm.Cancella001;
    C004FParamForm.PutParametro('MM',IntToStr(SpinEdit1.Value));
    C004FParamForm.PutParametro('AUTOMATICO',IfThen(chkAvvioAutomatico.Checked,'S','N'));
    C004FParamForm.PutParametro('ORARIPIANIFICATI',IfThen(chkAcquisisciDaPianificazione.Checked,'S','N'));
    SessioneOracleB015.Commit;
  except
  end;
end;

procedure TB015FScaricoGiustificativi.SpinEdit1Change(Sender: TObject);
begin
  Timer1.Interval:=SpinEdit1.Value * 60000;
  if Timer1.Enabled then
  begin
    Timer1.Enabled:=False;
    Timer1.Enabled:=True;
  end;
end;

procedure TB015FScaricoGiustificativi.BitBtn1Click(Sender: TObject);
begin
  //Se acquisizione pianificata leggo l'ora ogni minuto, altrimenti la leggo alla periodicità specificata 
  if chkAcquisisciDaPianificazione.Checked then
    Timer1.Interval:=60000
  else
    Timer1.Interval:=SpinEdit1.Value * 60000;
  AbilitaFunzioni(True);
  Timer1.Enabled:=True;
  Timer1Timer(nil);
end;

procedure TB015FScaricoGiustificativi.AbilitaFunzioni(ScaricoInCorso:Boolean);
begin
  actAvvio.Enabled:=not ScaricoInCorso;
  actEsci.Enabled:=not ScaricoInCorso;
  actStop.Enabled:=ScaricoInCorso;
  chkAcquisisciDaPianificazione.Enabled:=not ScaricoInCorso;
  SpinEdit1.Enabled:=(not ScaricoInCorso) and (not chkAcquisisciDaPianificazione.Checked);
  btnDataBase.Enabled:=not ScaricoInCorso;
end;

procedure TB015FScaricoGiustificativi.Timer1Timer(Sender: TObject);
begin
  if not R250FScaricoGiustificativiDtM.ControlloConnessioneDatabase then
    exit;
  A000SettaVariabiliAmbiente;
  if chkAcquisisciDaPianificazione.Checked then
  begin
    R250FScaricoGiustificativiDtM.selI102.Refresh;
    if R250FScaricoGiustificativiDtM.selI102.SearchRecord('ORA',FormatDateTime('hh.nn',Now),[srFromBeginning]) then
    try
      R250FScaricoGiustificativiDtM.Scarico(False,True);
    except
    end;
  end
  else
  try
    R250FScaricoGiustificativiDtM.Scarico(False,True);
  except
  end;
end;

procedure TB015FScaricoGiustificativi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not actEsci.Enabled then
    Action:=caNone
  else
  begin
    PutParametriFunzione;
    C004FParamForm.Free;
  end;
end;

procedure TB015FScaricoGiustificativi.BitBtn3Click(Sender: TObject);
begin
  Timer1.Enabled:=False;
  AbilitaFunzioni(False);
end;

procedure TB015FScaricoGiustificativi.chkAcquisisciDaPianificazioneClick(
  Sender: TObject);
begin
  SpinEdit1.Enabled:=not chkAcquisisciDaPianificazione.Checked;
end;

procedure TB015FScaricoGiustificativi.Esci1Click(Sender: TObject);
begin
  Close;
end;

procedure TB015FScaricoGiustificativi.Pianificazione1Click(Sender: TObject);
begin
  B015FPianificazioneScarichi.ShowModal;
end;

procedure TB015FScaricoGiustificativi.Button2Click(Sender: TObject);
begin
  if R180MessageBox('Eliminare il file B015.log?',DOMANDA) = mrYes then
    DeleteFile('B015.log');
end;

procedure TB015FScaricoGiustificativi.actEsciExecute(Sender: TObject);
begin
  Close;
end;

procedure TB015FScaricoGiustificativi.actServizioExecute(Sender: TObject);
begin
  //actServizio.Enabled:=True;
end;

procedure TB015FScaricoGiustificativi.Installa1Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFilePath(Application.ExeName) + 'B015PSCARICOGIUSTIFICATIVISRV.EXE'),PChar('/INSTALL'),nil,SW_SHOWNORMAL);
end;

procedure TB015FScaricoGiustificativi.Avvia1Click(Sender: TObject);
{Avvio del servizio dopo aver registrato i parametri}
begin
  R180PutRegistro(HKEY_LOCAL_MACHINE,'B015','Intervallo',SpinEdit1.Text);
  R180PutRegistro(HKEY_LOCAL_MACHINE,'B015','Pianificazione',IfThen(chkAcquisisciDaPianificazione.Checked,'S','N'));
  ShellExecute(0,'open', PChar('NET'),PChar('START B015FSCARICOGIUSTIFICATIVISRV'),nil,SW_SHOWNORMAL);
end;

procedure TB015FScaricoGiustificativi.Arresta1Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar('NET'),PChar('STOP B015FSCARICOGIUSTIFICATIVISRV'),nil,SW_SHOWNORMAL);
end;

procedure TB015FScaricoGiustificativi.Disinstalla1Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFilePath(Application.ExeName) + 'B015PSCARICOGIUSTIFICATIVISRV.EXE'),PChar('/UNINSTALL'),nil,SW_SHOWNORMAL);
end;

procedure TB015FScaricoGiustificativi.FormCreate(Sender: TObject);
begin
  A000SettaVariabiliAmbiente;
end;

procedure TB015FScaricoGiustificativi.actLeggiLogExecute(Sender: TObject);
begin
  {
  try
    Memo1.Lines.LoadFromFile(edtDatabase.Text + 'B015.log');
  except
    Memo1.Lines.Clear;
  end;
  }
  try
    RegistraMsg.LeggiMessaggi('B015');
    RegistraMsg.GetListaMessaggi(Memo1.Lines);
  except
    on E:Exception do
      R180MessageBox('Errore durante la visualizzazione dei log:' + #13#10 +
                     E.Message,INFORMA);
  end;
end;

procedure TB015FScaricoGiustificativi.actCancellaLogExecute(Sender: TObject);
begin
  if MessageDlg('Eliminare il file ' + edtDatabase.Text + 'B015.log?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    DeleteFile(edtDatabase.Text + 'B015.log');
    Memo1.Lines.Clear;
  end;
end;

procedure TB015FScaricoGiustificativi.btnDataBaseClick(Sender: TObject);
var Db:String;
begin
  Db:=edtDatabase.Text;
  if InputQuery('Connessione al database','Database:',Db) then
  begin
    SessioneOracleB015.LogonDatabase:=Db;
    SessioneOracleB015.Logoff;
  end;
  if R250FScaricoGiustificativiDtM.ControlloConnessioneDatabase then
  begin
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B015','Database',Db);
    edtDatabase.Text:=Db;
  end
  else
  begin
    SessioneOracleB015.LogonDatabase:=edtDatabase.Text;
    SessioneOracleB015.Logoff;
  end;
  if R250FScaricoGiustificativiDtM.ControlloConnessioneDatabase then
  begin
    lblDatabase.Font.Color:=clBlue;
    edtDatabase.Hint:='';
    lblDatabase.Font.Style:=[];
  end
  else
  begin
    lblDatabase.Font.Color:=clRed;
    edtDatabase.Hint:='Database non connesso';
    lblDatabase.Font.Style:=[fsStrikeOut];
  end;
end;

procedure TB015FScaricoGiustificativi.mnuHighestClick(Sender: TObject);
begin
  R180PutRegistro(HKEY_LOCAL_MACHINE,'B015','Priority',IntToStr(TMenuItem(Sender).Tag));
  GetPriority;
end;

procedure TB015FScaricoGiustificativi.GetPriority;
var P:Integer;
begin
  P:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B015','Priority','3'),3);
  mnuLowest.Checked:=mnuLowest.Tag = P;
  mnuLower.Checked:=mnuLower.Tag = P;
  mnuNormal.Checked:=mnuNormal.Tag = P;
  mnuHigher.Checked:=mnuHigher.Tag = P;
  mnuHighest.Checked:=mnuHighest.Tag = P;
end;

procedure TB015FScaricoGiustificativi.btnDatabaseListClick(Sender: TObject);
var Db:String;
begin
  Db:=edtDatabaseList.Text;
  if InputQuery('Connessioni ai database','Database:',Db) then
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B015','DatabaseList',Db);
    edtDatabaseList.Text:=Db;
end;

end.
