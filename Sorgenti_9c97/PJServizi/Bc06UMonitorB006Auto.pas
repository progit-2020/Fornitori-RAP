unit Bc06UMonitorB006Auto;

interface

uses
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  // include spostata da sezione da sezione implementation
  //R200UScaricoTimbratureDtM,
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  Bc06UExecMonitorB006Dtm,

  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Menus, Buttons, ExtCtrls, Spin, C004UParamForm, Oracle,
  ImgList, ActnList, ComCtrls, ToolWin, A000UCostanti, A000USessione, A000UInterfaccia,
  OracleData,ShellAPI, C180FunzioniGenerali, Variants, System.Actions, System.ImageList;

type
  TB006FScaricoAuto = class(TForm)
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Esci1: TMenuItem;
    Pianificazione1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    CheckBox1: TCheckBox;
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
    SEdtSpinRowLog: TSpinEdit;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpinEdit1Change(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure chkAcquisisciDaPianificazioneClick(Sender: TObject);
    procedure Esci1Click(Sender: TObject);
    procedure Pianificazione1Click(Sender: TObject);
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
    procedure FormDestroy(Sender: TObject);
  private
    SessioneOracleBc06:TOracleSession;
    //R200
        (*
      // rimozione variabile globale R200FScaricoTimbratureDtM.ini
          R200DM: TR200FScaricoTimbratureDtM;
          // rimozione variabile globale R200FScaricoTimbratureDtM.fine
    *)
    Bc06DM: TBc06FExecMonitorB006DtM;

    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure AbilitaFunzioni(ScaricoInCorso:Boolean);
    procedure GetPriority;
    function  CheckServiceIsRunning:Boolean;
  public
    { Public declarations }
  end;

const
  B006_SERVICE_EXENAME = 'Bc06PMonitorB006Srv.EXE';
  B006_SERVICE_NAME    = 'Bc06FMonitorB006Srv';

var
  B006FScaricoAuto: TB006FScaricoAuto;

implementation

//R200
uses // rimozione variabile globale R200FScaricoTimbratureDtM.ini
     // spostata in sezione interface
     //R200UScaricoTimbratureDtM,
     // rimozione variabile globale R200FScaricoTimbratureDtM.fine
     B006UPianificazioneScarichi;

{$R *.DFM}

procedure TB006FScaricoAuto.FormActivate(Sender: TObject);
{Mi posiziono sullo scarico di Default}
var Alias:String;
begin
  Alias:=R180GetRegistro(HKEY_LOCAL_MACHINE,'Bc06','Database','IRIS');
  InputQuery('<Bc06> Monitor','Selezionare database',Alias);
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  SessioneOracleBc06:=Bc06DM.Bc06SessioneOracle;
  R200DM.ConnettiDataBase(Alias);
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  edtDataBase.Text:=SessioneOracleBc06.LogonDatabase;
  if SessioneOracleBc06.Connected then
  begin
    R180PutRegistro(HKEY_LOCAL_MACHINE,'Bc06','Database',Alias);
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
    CreaC004(SessioneOracleBc06,'Bc06',0);
    GetParametriFunzione;
    GetPriority;
    edtDataBaseList.Text:=C004FParamForm.GetParametro('DATABASELIST',R180GetRegistro(HKEY_LOCAL_MACHINE,'Bc06','DatabaseList',''));
  except
    edtDataBaseList.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'Bc06','DatabaseList','');
  end;
  chkAcquisisciDaPianificazioneClick(nil);
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  with R200DM.QI100 do
  begin
    if Active then
      Locate('CORRENTE','S',[]);
  end;
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  AbilitaFunzioni(False);
  if CheckBox1.Checked then
  try
    BitBtn1Click(nil);
  except
  end;
  //R200
    (*
    Alias:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B006','Database','IRIS');
      InputQuery('<B006> Acquisizione automatica timbrature','Selezionare database',Alias);
      // rimozione variabile globale R200FScaricoTimbratureDtM.ini
      SessioneOracleB006:={R200FScaricoTimbratureDtM}R200DM.SessioneOracleB006;
      {R200FScaricoTimbratureDtM}R200DM.ConnettiDataBase(Alias);
      // rimozione variabile globale R200FScaricoTimbratureDtM.fine
      edtDataBase.Text:=SessioneOracleB006.LogonDatabase;
      if SessioneOracleB006.Connected then
      begin
        R180PutRegistro(HKEY_LOCAL_MACHINE,'B006','Database',Alias);
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
        CreaC004(SessioneOracleB006,'B006',0);
        GetParametriFunzione;
        GetPriority;
        edtDataBaseList.Text:=C004FParamForm.GetParametro('DATABASELIST',R180GetRegistro(HKEY_LOCAL_MACHINE,'B006','DatabaseList',''));
      except
        edtDataBaseList.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B006','DatabaseList','');
      end;
      chkAcquisisciDaPianificazioneClick(nil);
      // rimozione variabile globale R200FScaricoTimbratureDtM.ini
      with R200DM.QI100 do
      begin
        if Active then
          Locate('CORRENTE','S',[]);
      end;
      // rimozione variabile globale R200FScaricoTimbratureDtM.fine
      AbilitaFunzioni(False);
      if CheckBox1.Checked then
      try
        BitBtn1Click(nil);
      except
      end;
  *)
end;

procedure TB006FScaricoAuto.GetParametriFunzione;
begin
  with B006FScaricoAuto do
  begin
    SpinEdit1.Value:=StrToInt(C004FParamForm.GetParametro('MM','60'));
    CheckBox1.Checked:=C004FParamForm.GetParametro('AUTOMATICO','N') = 'S';
    chkAcquisisciDaPianificazione.Checked:=C004FParamForm.GetParametro('ORARIPIANIFICATI','N') = 'S';
    SEdtSpinRowLog.Value:=StrToIntDef(C004FParamForm.GetParametro('RIGHELOG','0'),0);
  end;
end;

procedure TB006FScaricoAuto.PutParametriFunzione;
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
  try
    C004FParamForm.Cancella001;
    C004FParamForm.PutParametro('AUTOMATICO',IfThen(CheckBox1.Checked,'S','N'));
    C004FParamForm.PutParametro('ORARIPIANIFICATI',IfThen(chkAcquisisciDaPianificazione.Checked,'S','N'));
    C004FParamForm.PutParametro('MM',IntToStr(SpinEdit1.Value));
    C004FParamForm.PutParametro('RIGHELOG',IntToStr(SEdtSpinRowLog.Value));
    C004FParamForm.PutParametro('DATABASELIST',edtDatabaseList.Text);
    C004FParamForm.PutParametro('PRIORITY',IntToStr(GetPriority));
    SessioneOracleBc06.Commit;
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B006','Pianificazione',IfThen(chkAcquisisciDaPianificazione.Checked,'S','N'));
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B006','Intervallo',SpinEdit1.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B006','RigheLog',SEdtSpinRowLog.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B006','DatabaseList',edtDatabaseList.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B006','Priority',IntToStr(GetPriority))
  except
  end;
end;

procedure TB006FScaricoAuto.SpinEdit1Change(Sender: TObject);
begin
  Timer1.Interval:=SpinEdit1.Value * 60000;
  if Timer1.Enabled then
  begin
    Timer1.Enabled:=False;
    Timer1.Enabled:=True;
  end;
end;

procedure TB006FScaricoAuto.BitBtn1Click(Sender: TObject);
begin
  PutParametriFunzione;
  if CheckServiceIsRunning then
    raise Exception.Create('E'' già in esecuzione il servizio ' + B006_SERVICE_NAME + CRLF +  'Non è consentito avviare l''elaborazione anche da questo pannello.');
  //Se acquisizione pianificata leggo l'ora ogni minuto, altrimenti la leggo alla periodicità specificata
  if chkAcquisisciDaPianificazione.Checked then
    Timer1.Interval:=60000
  else
    Timer1.Interval:=SpinEdit1.Value * 60000;
  AbilitaFunzioni(True);
  Timer1.Enabled:=True;
  Timer1Timer(nil);
end;

procedure TB006FScaricoAuto.AbilitaFunzioni(ScaricoInCorso:Boolean);
begin
  actAvvio.Enabled:=not ScaricoInCorso;
  actEsci.Enabled:=not ScaricoInCorso;
  actStop.Enabled:=ScaricoInCorso;
  chkAcquisisciDaPianificazione.Enabled:=not ScaricoInCorso;
  SpinEdit1.Enabled:=(not ScaricoInCorso) and (not chkAcquisisciDaPianificazione.Checked);
  btnDataBase.Enabled:=not ScaricoInCorso;
end;

function TB006FScaricoAuto.CheckServiceIsRunning:Boolean;
begin
  Result:=False;
  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneOracleBc06;
    SQL.Text:='select count(*) from V$SESSION where upper(PROGRAM) = ''' + B006_SERVICE_EXENAME + '''';
    try
      Execute;
      if FieldAsInteger(0) > 0 then
        Result:=True;
    except
    end;
  finally
    Free;
  end;
end;

procedure TB006FScaricoAuto.Timer1Timer(Sender: TObject);
begin
  //R200
    (*
    // rimozione variabile globale R200FScaricoTimbratureDtM.ini
      if not {R200FScaricoTimbratureDtM}R200DM.ControlloConnessioneDatabase then
        exit;
      A000SettaVariabiliAmbiente;
      if chkAcquisisciDaPianificazione.Checked then
      begin
        {R200FScaricoTimbratureDtM}R200DM.selI102.Refresh;
        if {R200FScaricoTimbratureDtM}R200DM.selI102.SearchRecord('ORA',FormatDateTime('hh.nn',Now),[srFromBeginning]) then
        try
          {R200FScaricoTimbratureDtM}R200DM.Scarico(False,True);
        except
        end;
      end
      else
      try
        {R200FScaricoTimbratureDtM}R200DM.Scarico(False,True);
      except
      end;
      // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  *)
end;

procedure TB006FScaricoAuto.FormClose(Sender: TObject;
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

procedure TB006FScaricoAuto.BitBtn3Click(Sender: TObject);
begin
  Timer1.Enabled:=False;
  AbilitaFunzioni(False);
end;

procedure TB006FScaricoAuto.chkAcquisisciDaPianificazioneClick(
  Sender: TObject);
begin
  SpinEdit1.Enabled:=not chkAcquisisciDaPianificazione.Checked;
end;

procedure TB006FScaricoAuto.Esci1Click(Sender: TObject);
begin
  Close;
end;

procedure TB006FScaricoAuto.Pianificazione1Click(Sender: TObject);
begin
  B006FPianificazioneScarichi.ShowModal;
end;

procedure TB006FScaricoAuto.actEsciExecute(Sender: TObject);
begin
  Close;
end;

procedure TB006FScaricoAuto.actServizioExecute(Sender: TObject);
begin
  //actServizio.Enabled:=True;
end;

procedure TB006FScaricoAuto.Installa1Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFilePath(Application.ExeName) + B006_SERVICE_EXENAME),PChar('/INSTALL'),nil,SW_SHOWNORMAL);
end;

procedure TB006FScaricoAuto.Avvia1Click(Sender: TObject);
{Avvio del servizio dopo aver registrato i parametri}
begin
  BitBtn3Click(nil);
  PutParametriFunzione;
  ShellExecute(0,'open', PChar('NET'),PChar('START ' + B006_SERVICE_NAME),nil,SW_SHOWNORMAL);
end;

procedure TB006FScaricoAuto.Arresta1Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar('NET'),PChar('STOP ' + B006_SERVICE_NAME),nil,SW_SHOWNORMAL);
end;

procedure TB006FScaricoAuto.Disinstalla1Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFilePath(Application.ExeName) + B006_SERVICE_EXENAME),PChar('/UNINSTALL'),nil,SW_SHOWNORMAL);
end;

procedure TB006FScaricoAuto.FormCreate(Sender: TObject);
begin
  A000SettaVariabiliAmbiente;
  //R200
    (*
    // rimozione variabile globale R200FScaricoTimbratureDtM.ini
      R200DM:=TR200FScaricoTimbratureDtM.Create(nil);
      // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  *)

  Bc06DM:=TBc06FExecMonitorB006DtM.Create(nil);
end;

procedure TB006FScaricoAuto.FormDestroy(Sender: TObject);
begin
  //R200
(*
    // rimozione variabile globale R200FScaricoTimbratureDtM.ini
    FreeAndNil(R200DM);
    // rimozione variabile globale R200FScaricoTimbratureDtM.fine
*)
  FreeAndNil(Bc06DM);
end;

procedure TB006FScaricoAuto.actLeggiLogExecute(Sender: TObject);
begin
  RegistraMsg.SessioneOracleApp:=SessioneOracleBc06;
  RegistraMsg.LeggiMessaggi('B006');
  RegistraMsg.GetListaMessaggi(Memo1.Lines,SEdtSpinRowLog.Value);
end;

procedure TB006FScaricoAuto.actCancellaLogExecute(Sender: TObject);
begin
  if MessageDlg('Eliminare il file ' + 'B006_' + edtDatabase.Text + '.log?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    DeleteFile('B006_' + edtDatabase.Text + '.log');
    Memo1.Lines.Clear;
  end;
end;

procedure TB006FScaricoAuto.btnDataBaseClick(Sender: TObject);
var Db:String;
begin
  //R200
(*
    Db:=edtDatabase.Text;
    if InputQuery('Connessione al database','Database:',Db) then
    begin
      SessioneOracleB006.LogonDatabase:=Db;
      SessioneOracleB006.Logoff;
    end;
    if R200DM.ControlloConnessioneDatabase then
    begin
      R180PutRegistro(HKEY_LOCAL_MACHINE,'B006','Database',Db);
      edtDatabase.Text:=Db;
    end
    else
    begin
      SessioneOracleB006.LogonDatabase:=edtDatabase.Text;
      SessioneOracleB006.Logoff;
    end;
    if R200DM.ControlloConnessioneDatabase then
    begin
      lblDatabase.Font.Color:=clBlue;
      edtDatabase.Hint:='';
      lblDatabase.Font.Style:=[];
      try
        if C004FParamForm <> nil then
          FreeAndNil(C004FParamForm);
        CreaC004(SessioneOracleB006,'B006',0);
        GetParametriFunzione;
        GetPriority;
        edtDataBaseList.Text:=C004FParamForm.GetParametro('DATABASELIST',R180GetRegistro(HKEY_LOCAL_MACHINE,'B006','DatabaseList',''));
      except
        edtDataBaseList.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B006','DatabaseList','');
      end;
    end
    else
    begin
      lblDatabase.Font.Color:=clRed;
      edtDatabase.Hint:='Database non connesso';
      lblDatabase.Font.Style:=[fsStrikeOut];
    end;
*)
end;

procedure TB006FScaricoAuto.mnuHighestClick(Sender: TObject);
begin
  mnuLowest.Checked:=mnuLowest = TMenuItem(Sender);
  mnuLower.Checked:=mnuLower = TMenuItem(Sender);
  mnuNormal.Checked:=mnuNormal = TMenuItem(Sender);
  mnuHigher.Checked:=mnuHigher = TMenuItem(Sender);
  mnuHighest.Checked:=mnuHighest = TMenuItem(Sender);
end;

procedure TB006FScaricoAuto.GetPriority;
var P:Integer;
begin
  //leggo da C004 , se non esiste leggo da registro
  P:=StrToIntDef(C004FParamForm.GetParametro('PRIORITY',R180GetRegistro(HKEY_LOCAL_MACHINE,'B006','Priority','3')),3);
  mnuLowest.Checked:=mnuLowest.Tag = P;
  mnuLower.Checked:=mnuLower.Tag = P;
  mnuNormal.Checked:=mnuNormal.Tag = P;
  mnuHigher.Checked:=mnuHigher.Tag = P;
  mnuHighest.Checked:=mnuHighest.Tag = P;
end;

procedure TB006FScaricoAuto.btnDatabaseListClick(Sender: TObject);
var Db:String;
begin
  Db:=edtDatabaseList.Text;
  if InputQuery('Connessioni ai database','Database:',Db) then
    edtDatabaseList.Text:=Db;
end;

end.
