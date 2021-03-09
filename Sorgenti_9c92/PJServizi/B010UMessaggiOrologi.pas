unit B010UMessaggiOrologi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Spin, Mask, ExtCtrls, ImgList, ActnList, Menus,
  ComCtrls, C180FunzioniGenerali, OracleData, Grids, DBGrids, Db, DBCtrls,
  A000UCostanti, A000USessione, A000UInterfaccia, A001UPasswordDtM1, (*Midaslib,*)
  RegistrazioneLog, Crtl, dbclient, C004UParamForm, ToolWin, ShellAPI, Variants;

type
  TB010FMessaggiOrologi = class(TForm)
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
    Label1: TLabel;
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
    lblDatabaseList: TLabel;
    edtDatabaseList: TEdit;
    btnDataBaseList: TButton;
    chkAvvioAutomatico: TCheckBox;
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
    procedure btnDataBaseListClick(Sender: TObject);
    procedure mnuHighestClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetPriority;
  public
    { Public declarations }
  end;

var
  B010FMessaggiOrologi: TB010FMessaggiOrologi;

implementation

uses B010UMessaggiOrologiDTM1, B010USchedulazione;

{$R *.DFM}

procedure TB010FMessaggiOrologi.FormShow(Sender: TObject);
begin
  GetPriority;
  chkAvvioAutomatico.Checked:=False;
  edtRigheLog.Text:='0';
  edtDataBase.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B010','Database','');
  edtDataBaseList.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B010','DatabaseList','');
  B010FMessaggiOrologiDtm1.ConnettiDataBase(edtDataBase.Text);
  if SessioneOracle.Connected then
  begin
    edtRigheLog.Text:=B010FMessaggiOrologiDtm1.C004.GetParametro('MAXRIGHELOG',edtRigheLog.Text);
    chkAvvioAutomatico.Checked:=B010FMessaggiOrologiDtm1.C004.GetParametro('AVVIOAUTOM','N') = 'S';
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
  B010FMessaggiOrologiDTM1.Timer1.Enabled:=chkAvvioAutomatico.Checked;
  actAvvio.Enabled:=not chkAvvioAutomatico.Checked;
  actStop.Enabled:=chkAvvioAutomatico.Checked;
  actEsci.Enabled:=not chkAvvioAutomatico.Checked;
  btnDatabase.Enabled:=not chkAvvioAutomatico.Checked;
  memoLog.Clear;
  B010FMessaggiOrologiDTM1.Statusbar:=StatusBar;
  edtDatabase.Text:=SessioneOracle.LogonDataBase;
end;

procedure TB010FMessaggiOrologi.btnSchedulazioneClick(Sender: TObject);
begin
  B010FSchedulazione:=TB010FSchedulazione.Create(nil);
  try
    B010FSchedulazione.ShowModal;
  finally
    FreeAndNil(B010FSchedulazione);
  end;
end;

procedure TB010FMessaggiOrologi.btnAvvioClick(Sender: TObject);
begin
  B010FMessaggiOrologiDTM1.Timer1.Enabled:=True;
  actStop.Enabled:=True;
  actAvvio.Enabled:=False;
  actEsci.Enabled:=False;
  btnDatabase.Enabled:=False;
end;

procedure TB010FMessaggiOrologi.btnLogClick(Sender: TObject);
begin
  {
  memoLog.Clear;
  if FileExists(B010FMessaggiOrologiDTM1.FileLog) then
    memoLog.Lines.LoadFromFile(B010FMessaggiOrologiDTM1.FileLog);
  }
  with TRegistraMsg(B010FMessaggiOrologiDTM1.SessioneIWB010.RegistraMsg) do
  begin
    LeggiMessaggi('B010');
    GetListaMessaggi(memoLog.Lines,edtRigheLog.Value,'',[miMessaggio]);
  end;
end;

procedure TB010FMessaggiOrologi.btnStopClick(Sender: TObject);
begin
  B010FMessaggiOrologiDTM1.Timer1.Enabled:=False;
  actAvvio.Enabled:=True;
  actStop.Enabled:=False;
  actEsci.Enabled:=True;
  btnDatabase.Enabled:=True;
end;

procedure TB010FMessaggiOrologi.btnPulisciLogClick(Sender: TObject);
begin
  {
  if FileExists(B010FMessaggiOrologiDTM1.FileLog) then
    if R180MessageBox('Eliminare il file ' + B010FMessaggiOrologiDTM1.FileLog + '?',DOMANDA) = mrYes then
    begin
      DeleteFile(B010FMessaggiOrologiDTM1.FileLog);
      memoLog.Clear;
    end;
  }
end;

procedure TB010FMessaggiOrologi.actEsciExecute(Sender: TObject);
begin
  Close;
end;

procedure TB010FMessaggiOrologi.edtRigheLogExit(Sender: TObject);
begin
  B010FMessaggiOrologiDtm1.C004.Cancella001;
  B010FMessaggiOrologiDtm1.C004.PutParametro('MAXRIGHELOG',edtRigheLog.Text);
  SessioneOracle.Commit;
end;

procedure TB010FMessaggiOrologi.actServizioExecute(Sender: TObject);
{Evento inutile ma necessario per abilitare l'azione actServizio}
begin
  if True then;
end;

procedure TB010FMessaggiOrologi.Installa2Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFilePath(Application.ExeName) + 'B010PMESSAGGIOROLOGISRV.EXE'),PChar('/INSTALL'),nil,SW_SHOWNORMAL);
end;

procedure TB010FMessaggiOrologi.Avvia2Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar('NET'),PChar('START B010FMESSAGGIOROLOGISRV'),nil,SW_SHOWNORMAL);
end;

procedure TB010FMessaggiOrologi.Arresta2Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar('NET'),PChar('STOP B010FMESSAGGIOROLOGISRV'),nil,SW_SHOWNORMAL);
end;

procedure TB010FMessaggiOrologi.Disinstalla2Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFilePath(Application.ExeName) + 'B010PMESSAGGIOROLOGISRV.EXE'),PChar('/UNINSTALL'),nil,SW_SHOWNORMAL);
end;

procedure TB010FMessaggiOrologi.btnDataBaseClick(Sender: TObject);
var Db,DbOld:String;
begin
  Db:=edtDatabase.Text;
  if InputQuery('Connessione al database','Database:',Db) then
    with B010FMessaggiOrologiDtM1 do
    begin
      DbOld:=SessioneOracle.LogonDatabase;
      try
        ConnettiDataBase(Db);
        if not SessioneOracle.Connected then
          Abort  //va sul try..except
        else
        begin
          Db:=SessioneOracle.LogonDatabase;
          edtDatabase.Text:=Db;
          R180PutRegistro(HKEY_LOCAL_MACHINE,'B010','Database',Db);
        end;
      except
        on E:Exception do
        begin
          ShowMessage('Database non valido!' + #13 + E.Message);
          try
            ConnettiDataBase(DbOld);
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
  end
  else
  begin
    lblDatabase.Font.Color:=clRed;
    edtDatabase.Hint:='Database non connesso';
    lblDatabase.Font.Style:=[fsStrikeOut];
  end;
end;

procedure TB010FMessaggiOrologi.btnDataBaseListClick(Sender: TObject);
var Db:String;
begin
  Db:=edtDatabaseList.Text;
  if InputQuery('Connessioni ai database','Database:',Db) then
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B010','DatabaseList',Db);
  edtDatabaseList.Text:=Db;
end;

procedure TB010FMessaggiOrologi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if B010FMessaggiOrologiDTM1.Timer1.Enabled then
    Action:=caNone
  else
  try
    B010FMessaggiOrologiDtm1.C004.Cancella001;
    if chkAvvioAutomatico.Checked then
      B010FMessaggiOrologiDtm1.C004.PutParametro('AVVIOAUTOM','S')
    else
      B010FMessaggiOrologiDtm1.C004.PutParametro('AVVIOAUTOM','N');
    B010FMessaggiOrologiDtm1.C004.PutParametro('MAXRIGHELOG',edtRigheLog.Text);
  except
  end;
end;

procedure TB010FMessaggiOrologi.mnuHighestClick(Sender: TObject);
begin
  R180PutRegistro(HKEY_LOCAL_MACHINE,'B010','Priority',IntToStr(TMenuItem(Sender).Tag));
  GetPriority;
end;

procedure TB010FMessaggiOrologi.GetPriority;
var P:Integer;
begin
  P:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B010','Priority','3'),3);
  mnuLowest.Checked:=mnuLowest.Tag = P;
  mnuLower.Checked:=mnuLower.Tag = P;
  mnuNormal.Checked:=mnuNormal.Tag = P;
  mnuHigher.Checked:=mnuHigher.Tag = P;
  mnuHighest.Checked:=mnuHighest.Tag = P;
end;

end.
