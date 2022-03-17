unit B019UGeneratoreStampe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Spin, Mask, ExtCtrls, ImgList, ActnList, Menus,
  ComCtrls, C180FunzioniGenerali, OracleData, Grids, DBGrids, Db, DBCtrls,
  A000UCostanti, A000USessione, A000UInterfaccia, A001UPasswordDtM1, (*Midaslib,*)
  Crtl, dbclient, RegistrazioneLog, C004UParamForm, ToolWin, ShellAPI, Variants, System.Actions;

type
  TB019FGeneratoreStampe = class(TForm)
    StatusBar: TStatusBar;
    MainMenu1: TMainMenu;
    VisualizzaFile: TMenuItem;
    Esegui: TMenuItem;
    Schedulazione: TMenuItem;
    N1: TMenuItem;
    ActionList1: TActionList;
    actAvvio: TAction;
    actEsci: TAction;
    actSchedulazione: TAction;
    ImageList1: TImageList;
    Panel1: TPanel;
    Panel2: TPanel;
    Esci: TMenuItem;
    actLog: TAction;
    VisualizzaLog: TMenuItem;
    N2: TMenuItem;
    memoLog: TMemo;
    actStop: TAction;
    Stop1: TMenuItem;
    N3: TMenuItem;
    actPulisciLog: TAction;
    PulisciLog1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton6: TToolButton;
    ToolButton2: TToolButton;
    ToolButton7: TToolButton;
    ToolButton3: TToolButton;
    ToolButton1: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton13: TToolButton;
    actServizio: TAction;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    Panel4: TPanel;
    lblDatabase: TLabel;
    Label2: TLabel;
    edtDataBase: TEdit;
    btnDataBase: TButton;
    edtRigheLog: TSpinEdit;
    popmnuServizio: TPopupMenu;
    Installa1: TMenuItem;
    Disinstalla1: TMenuItem;
    MenuItem1: TMenuItem;
    Avvia1: TMenuItem;
    Arresta1: TMenuItem;
    MenuItem2: TMenuItem;
    mnuPriority: TMenuItem;
    mnuLowest: TMenuItem;
    mnuLower: TMenuItem;
    mnuNormal: TMenuItem;
    mnuHigher: TMenuItem;
    mnuHighest: TMenuItem;
    Label3: TLabel;
    cmbAzienda: TComboBox;
    lblDatabaseList: TLabel;
    edtDatabaseList: TEdit;
    btnDataBaseList: TButton;
    procedure btnSchedulazioneClick(Sender: TObject);
    procedure btnAvvioClick(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPulisciLogClick(Sender: TObject);
    procedure actEsciExecute(Sender: TObject);
    procedure edtRigheLogExit(Sender: TObject);
    procedure actServizioExecute(Sender: TObject);
    procedure Installa2Click(Sender: TObject);
    procedure Avvia2Click(Sender: TObject);
    procedure Arresta2Click(Sender: TObject);
    procedure Disinstalla2Click(Sender: TObject);
    procedure btnDataBaseClick(Sender: TObject);
    procedure mnuHighestClick(Sender: TObject);
    procedure cmbAziendaChange(Sender: TObject);
    procedure btnDataBaseListClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetPriority;
    procedure GetAziende;
  public
    { Public declarations }
  end;

var
  B019FGeneratoreStampe: TB019FGeneratoreStampe;

implementation

uses B019UGeneratoreStampeDTM, B019USchedulazione;

{$R *.DFM}

procedure TB019FGeneratoreStampe.FormShow(Sender: TObject);
var Azienda:String;
begin
  GetPriority;
  edtRigheLog.Text:='0';
  edtDataBase.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B019','Database','');
  Azienda:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B019','Azienda','AZIN');
  edtDataBaseList.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B019','DatabaseList','');
  B019FGeneratoreStampeDtM.ConnettiDataBase(edtDataBase.Text,Azienda);
  if SessioneOracle.Connected then
  begin
    edtRigheLog.Text:=B019FGeneratoreStampeDtM.C004.GetParametro('MAXRIGHELOG',edtRigheLog.Text);
    lblDatabase.Font.Color:=clBlue;
    edtDatabase.Hint:='';
    lblDatabase.Font.Style:=[];
    GetAziende;
    cmbAzienda.ItemIndex:=cmbAzienda.Items.IndexOf(Azienda);
  end
  else
  begin
    lblDatabase.Font.Color:=clRed;
    edtDatabase.Hint:='Database non connesso';
    lblDatabase.Font.Style:=[fsStrikeOut];
  end;
  B019FGeneratoreStampeDtM.Timer1.Enabled:=False;
  actAvvio.Enabled:=True;
  actStop.Enabled:=False;
  actEsci.Enabled:=True;
  btnDatabase.Enabled:=True;
  memoLog.Clear;
  B019FGeneratoreStampeDtM.Statusbar:=StatusBar;
  edtDatabase.Text:=SessioneOracle.LogonDataBase;
end;

procedure TB019FGeneratoreStampe.GetAziende;
begin
  cmbAzienda.Items.Clear;
  with B019FGeneratoreStampeDtM.selI090 do
  begin
    First;
    while not Eof do
    begin
      cmbAzienda.Items.Add(FieldByName('AZIENDA').AsString);
      Next;
    end;
  end;
end;

procedure TB019FGeneratoreStampe.btnSchedulazioneClick(Sender: TObject);
begin
  B019FSchedulazione:=TB019FSchedulazione.Create(nil);
  try
    B019FSchedulazione.ShowModal;
  finally
    FreeAndNil(B019FSchedulazione);
  end;
end;

procedure TB019FGeneratoreStampe.btnAvvioClick(Sender: TObject);
begin
  B019FGeneratoreStampeDtM.Timer1.Enabled:=True;
  actStop.Enabled:=True;
  actAvvio.Enabled:=False;
  actEsci.Enabled:=False;
  btnDatabase.Enabled:=False;
end;

procedure TB019FGeneratoreStampe.btnLogClick(Sender: TObject);
begin
  {
  memoLog.Clear;
  if FileExists(B019FGeneratoreStampeDtM.FileLog) then
    memoLog.Lines.LoadFromFile(B019FGeneratoreStampeDtM.FileLog);
  }
  try
    with TRegistraMsg(A000SessioneIrisWIN.RegistraMsg) do
    begin
      LeggiMessaggi('B019,P077COM');
      GetListaMessaggi(memoLog.Lines,edtRigheLog.Value,StringOfChar('=',19));
    end;
  except
    on E:Exception do
      R180MessageBox('Errore durante la visualizzazione del log:' + #13#10 +
                     E.Message,INFORMA);
  end;
end;

procedure TB019FGeneratoreStampe.btnStopClick(Sender: TObject);
begin
  B019FGeneratoreStampeDtM.Timer1.Enabled:=False;
  actAvvio.Enabled:=True;
  actStop.Enabled:=False;
  actEsci.Enabled:=True;
  btnDatabase.Enabled:=True;
end;

procedure TB019FGeneratoreStampe.cmbAziendaChange(Sender: TObject);
begin
  B019FGeneratoreStampeDtM.ConnettiDataBase(edtDataBase.Text,cmbAzienda.Text);
  if SessioneOracle.Connected then
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B019','Azienda',cmbAzienda.Text);
end;

procedure TB019FGeneratoreStampe.btnPulisciLogClick(Sender: TObject);
begin
  {
  if FileExists(B019FGeneratoreStampeDtM.FileLog) then
    if MessageDlg('Eliminare il file ' + B019FGeneratoreStampeDtM.FileLog + '?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      DeleteFile(B019FGeneratoreStampeDtM.FileLog);
      memoLog.Clear;
    end;
  }
end;

procedure TB019FGeneratoreStampe.actEsciExecute(Sender: TObject);
begin
  Close;
end;

procedure TB019FGeneratoreStampe.edtRigheLogExit(Sender: TObject);
begin
  B019FGeneratoreStampeDtM.C004.Cancella001;
  B019FGeneratoreStampeDtM.C004.PutParametro('MAXRIGHELOG',edtRigheLog.Text);
  SessioneOracle.Commit;
end;

procedure TB019FGeneratoreStampe.actServizioExecute(Sender: TObject);
{Evento inutile ma necessario per abilitare l'azione actServizio}
begin
  if True then;
end;

procedure TB019FGeneratoreStampe.Installa2Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFilePath(Application.ExeName) + 'B019PGENERATORESTAMPESRV.EXE'),PChar('/INSTALL'),nil,SW_SHOWNORMAL);
end;

procedure TB019FGeneratoreStampe.Avvia2Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar('NET'),PChar('START B019FGENERATORESTAMPESRV'),nil,SW_SHOWNORMAL);
end;

procedure TB019FGeneratoreStampe.Arresta2Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar('NET'),PChar('STOP B019FGENERATORESTAMPESRV'),nil,SW_SHOWNORMAL);
end;

procedure TB019FGeneratoreStampe.Disinstalla2Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFilePath(Application.ExeName) + 'B019PGENERATORESTAMPESRV.EXE'),PChar('/UNINSTALL'),nil,SW_SHOWNORMAL);
end;

procedure TB019FGeneratoreStampe.btnDataBaseClick(Sender: TObject);
var Db,DbOld:String;
begin
  Db:=edtDatabase.Text;
  if InputQuery('Connessione al database','Database:',Db) then
    with B019FGeneratoreStampeDtM do
    begin
      DbOld:=SessioneOracle.LogonDatabase;
      try
        ConnettiDataBase(Db,'');
        if not SessioneOracle.Connected then
          Abort  //va sul try..except
        else
        begin
          Db:=SessioneOracle.LogonDatabase;
          edtDatabase.Text:=Db;
          R180PutRegistro(HKEY_LOCAL_MACHINE,'B019','Database',Db);
        end;
      except
        on E:Exception do
        begin
          ShowMessage('Database non valido!' + #13 + E.Message);
          try
            ConnettiDataBase(DbOld,'');
          except
          end;
        end;
      end;
    end;
  if SessioneOracle.Connected then
  begin
    lblDatabase.Font.Color:=clBlue;
    edtDatabase.Hint:='';
    lblDatabase.Font.Style:=[];
    GetAziende;
    cmbAzienda.ItemIndex:=cmbAzienda.Items.IndexOf(Parametri.Azienda);
  end
  else
  begin
    lblDatabase.Font.Color:=clRed;
    edtDatabase.Hint:='Database non connesso';
    lblDatabase.Font.Style:=[fsStrikeOut];
    cmbAzienda.Items.Clear;
  end;
end;

procedure TB019FGeneratoreStampe.btnDataBaseListClick(Sender: TObject);
var Db:String;
begin
  Db:=edtDatabaseList.Text;
  if InputQuery('Connessioni ai database','Database:',Db) then
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B019','DatabaseList',Db);
  edtDatabaseList.Text:=Db;
end;

procedure TB019FGeneratoreStampe.mnuHighestClick(Sender: TObject);
begin
  R180PutRegistro(HKEY_LOCAL_MACHINE,'B019','Priority',IntToStr(TMenuItem(Sender).Tag));
  GetPriority;
end;

procedure TB019FGeneratoreStampe.GetPriority;
var P:Integer;
begin
  P:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B019','Priority','3'),3);
  mnuLowest.Checked:=mnuLowest.Tag = P;
  mnuLower.Checked:=mnuLower.Tag = P;
  mnuNormal.Checked:=mnuNormal.Tag = P;
  mnuHigher.Checked:=mnuHigher.Tag = P;
  mnuHighest.Checked:=mnuHighest.Tag = P;
end;

procedure TB019FGeneratoreStampe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if B019FGeneratoreStampeDtM.Timer1.Enabled then
    Action:=caNone
  else
  try
    B019FGeneratoreStampeDtM.C004.Cancella001;
    B019FGeneratoreStampeDtM.C004.PutParametro('MAXRIGHELOG',edtRigheLog.Text);
  except
  end;
end;

end.
