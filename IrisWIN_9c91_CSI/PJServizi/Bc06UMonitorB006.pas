unit Bc06UMonitorB006;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus,
  ShellApi,
  A000USessione, A000UInterfaccia, Oracle, Bc06UConfigMonitorB006, C013UCheckList,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Bc06UMonitorB006DtM, System.StrUtils, Vcl.ExtCtrls,
  C180FunzioniGenerali, Bc06UClassi, A083UMsgElaborazioni, InputPeriodo, Vcl.DBCtrls, Math, Vcl.Mask;

type
  TBc06FMonitorB006 = class(TForm)
    MainMenu: TMainMenu;
    File1: TMenuItem;
    N1: TMenuItem;
    Chiudi1: TMenuItem;
    ActionList: TActionList;
    actStartMonitoraggio: TAction;
    actStopMonitoraggio: TAction;
    actChiudi: TAction;
    actConfigurazione: TAction;
    Configurazione1: TMenuItem;
    ToolBar: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    grpUltimoControllo: TGroupBox;
    dgrdInfoControllo: TDBGrid;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    actControllaOra: TAction;
    pnlStato: TPanel;
    lblTitStato: TLabel;
    lblStato: TLabel;
    pnlLog: TPanel;
    splSplitter: TSplitter;
    pgcMsgControllo: TPageControl;
    tbsMsg1: TTabSheet;
    memMsg1: TMemo;
    tbsMsg2: TTabSheet;
    memMsg2: TMemo;
    Splitter2: TSplitter;
    grpLogControllo: TGroupBox;
    memLogControllo: TMemo;
    actLogAttivit‡: TAction;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    pnlPulsantiLog: TPanel;
    btnSvuotaLog: TButton;
    ppmDG: TPopupMenu;
    Controllaora1: TMenuItem;
    pnlMsg: TPanel;
    pnlFiltroUtente: TPanel;
    frmInputPeriodo: TfrmInputPeriodo;
    lblTipo: TLabel;
    cmbTipo: TComboBox;
    Label1: TLabel;
    btnAnnullaFiltro: TButton;
    cmbAzienda: TComboBox;
    btnApplicaFiltro: TButton;
    actServizio: TToolButton;
    ToolButton14: TToolButton;
    popmnuServizio: TPopupMenu;
    Installa: TMenuItem;
    Disinstalla: TMenuItem;
    MenuItem1: TMenuItem;
    Avvia: TMenuItem;
    Arresta: TMenuItem;
    N2: TMenuItem;
    mnuPriority: TMenuItem;
    mnuLowest: TMenuItem;
    mnuLower: TMenuItem;
    mnuNormal: TMenuItem;
    mnuHigher: TMenuItem;
    mnuHighest: TMenuItem;
    pnlToolbar2: TPanel;
    pnlDBLst: TPanel;
    lblDBLst: TLabel;
    btnDBLst: TButton;
    edtLstDB: TEdit;
    procedure actConfigurazioneExecute(Sender: TObject);
    procedure actStartMonitoraggioExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actStopMonitoraggioExecute(Sender: TObject);
    procedure actControllaOraExecute(Sender: TObject);
    procedure actChiudiExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dgrdInfoControlloDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure actLogAttivit‡Execute(Sender: TObject);
    procedure btnSvuotaLogClick(Sender: TObject);
    procedure ControllaOraDB;
    procedure ApplicaFiltroUtente;
    procedure AggiornaParametriFiltroUtente();
    procedure frmInputPeriodoedtInizioExit(Sender: TObject);
    procedure frmInputPeriodobtnDataInizioClick(Sender: TObject);
    procedure frmInputPeriodobtnDataFineClick(Sender: TObject);
    procedure frmInputPeriodobtnIndietroClick(Sender: TObject);
    procedure frmInputPeriodobtnAvantiClick(Sender: TObject);
    procedure cmbTipoChange(Sender: TObject);
    procedure dCmbAziendaChange(Sender: TObject);
    procedure btnControllaOraDB(Sender: TObject);
    procedure btnApplicaFiltroClick(Sender: TObject);
    procedure frmInputPeriodoedtInizioEnter(Sender: TObject);
    procedure frmInputPeriodoedtFineEnter(Sender: TObject);
    procedure frmInputPeriodoedtFineExit(Sender: TObject);
    procedure InstallaClick(Sender: TObject);
    procedure DisinstallaClick(Sender: TObject);
    procedure AvviaClick(Sender: TObject);
    procedure ArrestaClick(Sender: TObject);
    procedure mnuPrioritaClick(Sender: TObject);
    procedure PutParametriFunzione;
    procedure btnDBLstClick(Sender: TObject);
    procedure SetLstDB(S:String);
    function GetLstDB:String;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    DataT: TDateTime;
    ListaDB:TStringList;
  public
    procedure SvuotaLog;
    procedure AggiungiLineeLog(Linee:TStringList; optDestroy:Boolean = True);
    procedure AggiungiLineaLog(Linea:String);
    procedure AggiornaInterfaccia;
    procedure BloccaInterfaccia;
  end;

const
  Bc06_SERVICE_EXENAME = 'Bc06PMonitorB006Srv.exe';
  Bc06_SERVICE_NAME    = 'Bc06FMonitorB006Srv';
  Bc06_SHORT_NAME      = 'Bc06';
var
  Bc06FMonitorB006: TBc06FMonitorB006;

implementation

{$R *.dfm}

uses Bc06UExecMonitorB006DtM;

procedure TBc06FMonitorB006.FormShow(Sender: TObject);
begin
  pgcMsgControllo.ActivePageIndex:=0;
  actStartMonitoraggio.Enabled:=False;
  actStopMonitoraggio.Enabled:=False;
  actControllaOra.Enabled:=False;
  //Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.LeggiConfigurazione;
  AggiornaInterfaccia;

  R180AbilitaOggetti(pnlFiltroUtente, False);
  R180AbilitaOggetti(Bc06FMonitorB006.frmInputPeriodo, False);

  ListaDB:=TStringList.Create;
  ListaDB.CommaText:=Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.LocalOracleAliasList.CommaText;
  ListaDB.Insert(0,'<B006_DatabaseList>');
  edtLstDB.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE, Bc06_SHORT_NAME,'DatabaseList', '');
end;

procedure TBc06FMonitorB006.frmInputPeriodobtnAvantiClick(Sender: TObject);
begin
  frmInputPeriodo.btnAvantiClick(Sender);
  btnApplicaFiltro.Enabled:=True;
end;

procedure TBc06FMonitorB006.frmInputPeriodobtnDataFineClick(Sender: TObject);
begin
  DataT:=frmInputPeriodo.DataFine;
  frmInputPeriodo.btnDataFineClick(Sender);
  btnApplicaFiltro.Enabled:=frmInputPeriodo.DataFine <> DataT;
end;

procedure TBc06FMonitorB006.frmInputPeriodobtnDataInizioClick(Sender: TObject);
begin
  DataT:=frmInputPeriodo.DataInizio;
  frmInputPeriodo.btnDataInizioClick(Sender);
  btnApplicaFiltro.Enabled:=frmInputPeriodo.DataInizio <> DataT;
end;

procedure TBc06FMonitorB006.frmInputPeriodobtnIndietroClick(Sender: TObject);
begin
  frmInputPeriodo.btnIndietroClick(Sender);
  btnApplicaFiltro.Enabled:=True;
end;

procedure TBc06FMonitorB006.frmInputPeriodoedtFineEnter(Sender: TObject);
begin
  DataT:=frmInputPeriodo.DataFine;
end;

procedure TBc06FMonitorB006.frmInputPeriodoedtFineExit(Sender: TObject);
begin
  btnApplicaFiltro.Enabled:=frmInputPeriodo.DataFine <> DataT;
end;

procedure TBc06FMonitorB006.frmInputPeriodoedtInizioEnter(Sender: TObject);
begin
  DataT:=frmInputPeriodo.DataInizio;
end;

procedure TBc06FMonitorB006.frmInputPeriodoedtInizioExit(Sender: TObject);
begin
  frmInputPeriodo.edtInizioExit(Sender);
  btnApplicaFiltro.Enabled:=frmInputPeriodo.DataInizio <> DataT;
end;

procedure TBc06FMonitorB006.actChiudiExecute(Sender: TObject);
begin
  if Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.MonitorAttivo then
    raise Exception.Create('Arrestare il controllo prima di chiudere l''applicazione.');
  if R180MessageBox('Uscire dall''utilit‡ di monitoraggio?',DOMANDA) = mrYes then
  begin
    PutParametriFunzione;
    Application.Terminate;
  end;
end;

procedure TBc06FMonitorB006.actConfigurazioneExecute(Sender: TObject);
var
  OldSolaLettura:Boolean;
begin
  if Bc06FConfigMonitorB006 <> nil then
    FreeAndNil(Bc06FConfigMonitorB006);

  OldSolaLettura:=SolaLettura;
  SolaLettura:=SolaLettura or Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.MonitorAttivo; // Se il monitor Ë attivo blocco le modifiche
  Bc06FConfigMonitorB006:=TBc06FConfigMonitorB006.Create(Self);
  try
    Bc06FConfigMonitorB006.ShowModal;
    if (* Bc06FConfigMonitorB006.Modificato and *) not SolaLettura then // Sicurezza
    begin
      actStartMonitoraggio.Enabled:=False;
      actStopMonitoraggio.Enabled:=False;
      actControllaOra.Enabled:=False;
      Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.LeggiConfigurazione;
      AggiornaInterfaccia;
    end;
  finally
    SolaLettura:=OldSolaLettura;
    FreeAndNil(Bc06FConfigMonitorB006);
  end;
end;

procedure TBc06FMonitorB006.actControllaOraExecute(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  BloccaInterfaccia;
  try
    Bc06FMonitorB006DtM.ControllaOra;
  finally
    Screen.Cursor:=crDefault;
    AggiornaInterfaccia;
  end;
end;

procedure TBc06FMonitorB006.actLogAttivit‡Execute(Sender: TObject);
begin
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'Bc06','');
end;

procedure TBc06FMonitorB006.actStartMonitoraggioExecute(Sender: TObject);
begin
  if Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.MonitorAttivo then
    raise Exception.Create('Il monitoraggio Ë gi‡ attivo.');
  // Lancio manualmente i controlli la prima volta
  Bc06FMonitorB006DtM.ControllaOra;
  Bc06FMonitorB006DtM.StartMonitor;
  AggiornaInterfaccia;
end;

procedure TBc06FMonitorB006.actStopMonitoraggioExecute(Sender: TObject);
begin
  Bc06FMonitorB006DtM.StopMonitor;
  AggiornaInterfaccia;
end;

procedure TBc06FMonitorB006.SvuotaLog;
begin
  memLogControllo.Lines.Clear;
end;

procedure TBc06FMonitorB006.AggiungiLineeLog(Linee: TStringList; optDestroy: Boolean = True);
var Linea: string;
begin
  for Linea in Linee do
    memLogControllo.Lines.Add(Format('[%s]: %s',[DateTimeToStr(Now),Linea]));

  if optDestroy then
    Linee.Free;

  Application.ProcessMessages;
end;

procedure TBc06FMonitorB006.AggiungiLineaLog(Linea:String);
begin
  memLogControllo.Lines.Add(Format('[%s]: %s',[DateTimeToStr(Now),Linea]));
  Application.ProcessMessages;
end;

procedure TBc06FMonitorB006.btnApplicaFiltroClick(Sender: TObject);
begin
  ApplicaFiltroUtente;
end;

procedure TBc06FMonitorB006.btnControllaOraDB(Sender: TObject);
begin
  frmInputPeriodo.DataInizio:=0;
  frmInputPeriodo.DataFine:=0;
  cmbTipo.ItemIndex:=0;
  cmbAzienda.Items.Clear;
  cmbAzienda.Text:='';
  AggiornaParametriFiltroUtente;
  ControllaOraDB;
end;

procedure TBc06FMonitorB006.btnSvuotaLogClick(Sender: TObject);
begin
  memLogControllo.Clear;
end;

procedure TBc06FMonitorB006.btnDBLstClick(Sender: TObject);
begin
  c013FCheckList:=TC013FCheckList.Create(nil);
  with c013FCheckList do
  try
    clbListaDati.Items.Clear;
    clbListaDati.Items.Assign(ListaDB);
    SetLstDB(edtLstDB.Text);
    if ShowModal = mrOK then
      edtLstDB.Text:=GetLstDB;
  finally
    Release;
  end;
end;

procedure TBc06FMonitorB006.SetLstDB(S:String);
  var Lista:TStringList;
    i,j,indice:Integer;
begin
  try
    for i:=0 to C013FCheckList.clbListaDati.Items.Count - 1 do
      C013FCheckList.clbListaDati.Checked[i]:=False;
    Lista:=TStringList.Create;

    Lista.StrictDelimiter:=True;
    Lista.CommaText:=S;

    indice:=-1;
    for i:=0 to Lista.Count - 1 do
      for j:=0 to C013FCheckList.clbListaDati.Items.Count - 1 do
        if Lista[i] = C013FCheckList.clbListaDati.Items[j] then
          begin
          C013FCheckList.clbListaDati.Checked[j]:=True;
          if indice = -1 then
            indice:=j;
          Break;
          end;
    if indice > -1 then
      C013FCheckList.clbListaDati.ItemIndex:=indice;
  finally
    Lista.Free;
  end;
end;

function TBc06FMonitorB006.GetLstDB:String;
var i: Integer;
begin
  Result:='';
  if C013FCheckList.clbListaDati.Checked[0] then
    Result:=C013FCheckList.clbListaDati.Items[0]
  else
    for i:=1 to C013FCheckList.clbListaDati.Items.Count - 1 do
      if C013FCheckList.clbListaDati.Checked[i] then
      begin
        if Result <> '' then
          Result:=Result + ',';
        Result:=Result + C013FCheckList.clbListaDati.Items[i];
      end;
end;

{Aggiorna il dataset con i valori a video}
procedure TBc06FMonitorB006.AggiornaParametriFiltroUtente();
begin
  with Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.cdsInfoControlli do
  begin
    Edit;

    FieldByName('F_Tipo').AsInteger:=cmbTipo.ItemIndex;
    FieldByName('F_Azienda').AsInteger:=CmbAzienda.ItemIndex;

    FieldByName('F_DataI').AsDateTime:=frmInputPeriodo.DataInizio;
    FieldByName('F_DataF').AsDateTime:=frmInputPeriodo.DataFine; //IfThen(frmInputPeriodo.DataFine>0, frmInputPeriodo.DataFine, StrToDate('31/12/3999'));

    Post;
  end;
end;

{Imposta il filtro utente}
procedure TBc06FMonitorB006.ApplicaFiltroUtente;
begin
  AggiornaParametriFiltroUtente;
  ControllaOraDB;
  btnApplicaFiltro.Enabled:=False;
end;

procedure TBc06FMonitorB006.ArrestaClick(Sender: TObject);
begin
  ShellExecute(0,'open', PChar('NET'),PChar('STOP '+ Bc06_SERVICE_NAME),nil,SW_SHOWNORMAL);
end;

procedure TBc06FMonitorB006.cmbTipoChange(Sender: TObject);
begin
  btnApplicaFiltro.Enabled:=True;
end;

procedure TBc06FMonitorB006.ControllaOraDB;
begin
  Screen.Cursor:=crHourGlass;
  BloccaInterfaccia;
  try
    Bc06FMonitorB006DtM.ControllaOra(dgrdInfoControllo.DataSource.DataSet.FieldByName('ID').AsInteger, dgrdInfoControllo.DataSource.DataSet.FieldByName('DATABASE').AsString);
  finally
    Screen.Cursor:=crDefault;
    AggiornaInterfaccia;
  end;
end;

procedure TBc06FMonitorB006.AggiornaInterfaccia;
begin
  actStartMonitoraggio.Enabled:=not Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.MonitorAttivo;
  actStopMonitoraggio.Enabled:=Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.MonitorAttivo;
  actControllaOra.Enabled:=True;
  actChiudi.Enabled:=not  Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.MonitorAttivo;
  lblStato.Caption:=IfThen(Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.MonitorAttivo,'Attivo','Non attivo');
  pnlMsg.Enabled:=True;
end;

procedure TBc06FMonitorB006.dCmbAziendaChange(Sender: TObject);
begin
  ApplicaFiltroUtente;
end;

procedure TBc06FMonitorB006.dgrdInfoControlloDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  DsOrigine:TDataSet;
  EsitoContr:Integer;
begin
  DsOrigine:=dgrdInfoControllo.DataSource.DataSet;
  EsitoContr:=DsOrigine.FieldByName('ESITO_CONTROLLO').AsInteger;
  if (EsitoContr <> ESITO_OK) and (EsitoContr <> ESITO_CONTROLLO_SALTATO) and
     (EsitoContr <> ESITO_INDEFINITO) then
  begin
    dgrdInfoControllo.Canvas.Brush.Color:=clRed;
    dgrdInfoControllo.Canvas.Font.Style:=[fsBold];
    dgrdInfoControllo.Canvas.Font.Color:=clWhite;
  end
  else
  begin
    dgrdInfoControllo.Canvas.Brush.Color:=dgrdInfoControllo.Color;
    dgrdInfoControllo.Canvas.Font.Color:=dgrdInfoControllo.Font.Color;
  end;

  dgrdInfoControllo.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TBc06FMonitorB006.BloccaInterfaccia;
begin
  actControllaOra.Enabled:=False;
  actStartMonitoraggio.Enabled:=False;
  actStopMonitoraggio.Enabled:=False;
  pnlMsg.Enabled:=False;
end;

procedure TBc06FMonitorB006.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caNone;
  actChiudiExecute(nil);
end;

procedure TBc06FMonitorB006.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ListaDB);
end;

procedure TBc06FMonitorB006.DisinstallaClick(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFilePath(Application.ExeName) + Bc06_SERVICE_EXENAME),PChar('/UNINSTALL'),nil,SW_SHOWNORMAL);
end;

procedure TBc06FMonitorB006.InstallaClick(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFilePath(Application.ExeName) + Bc06_SERVICE_EXENAME),PChar('/INSTALL'),nil,SW_SHOWNORMAL);
end;

procedure TBc06FMonitorB006.mnuPrioritaClick(Sender: TObject);
begin
  mnuLowest.Checked:=mnuLowest = TMenuItem(Sender);
  mnuLower.Checked:=mnuLower = TMenuItem(Sender);
  mnuNormal.Checked:=mnuNormal = TMenuItem(Sender);
  mnuHigher.Checked:=mnuHigher = TMenuItem(Sender);
  mnuHighest.Checked:=mnuHighest = TMenuItem(Sender);
end;

procedure TBc06FMonitorB006.AvviaClick(Sender: TObject);
{Avvio del servizio dopo aver registrato i parametri}
begin
  //BitBtn3Click(nil);
  PutParametriFunzione;
  ShellExecute(0,'open', PChar('NET'),PChar('START ' + Bc06_SERVICE_NAME),nil,SW_SHOWNORMAL);

  { $EXTERNALSYM ShellExecute
  ShellExecute(hWnd   -> 0
  Operation: LPWSTR   -> 'open'
  FileName: LPWSTR    -> PChar('NET')
  Parameters: LPWSTR  -> PChar('START ' + Bc06_SERVICE_NAME)
  Directory: LPWSTR   -> nil
  ShowCmd: Integer -> SW_SHOWNORMAL
  ): HINST; stdcall;}
end;

procedure TBc06FMonitorB006.PutParametriFunzione;
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
    R180PutRegistro(HKEY_LOCAL_MACHINE, Bc06_SHORT_NAME, 'DatabaseList', edtLstDB.Text);
    R180PutRegistro(HKEY_LOCAL_MACHINE, Bc06_SHORT_NAME, 'Database', Bc06FMonitorB006DtM.Bc06FExecMonitorB006DtM.cdsInfoControlli.FieldByName('DATABASE').AsString);
    R180PutRegistro(HKEY_LOCAL_MACHINE, Bc06_SHORT_NAME, 'Priority', IntToStr(GetPriority))
  except
  end;
end;


end.
