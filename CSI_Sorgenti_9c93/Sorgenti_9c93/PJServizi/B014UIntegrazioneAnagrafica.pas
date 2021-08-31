unit B014UIntegrazioneAnagrafica;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Spin, C004UParamForm, A000UInterfaccia,
  ExtCtrls, Grids, DBGrids, Db, C013UCheckList, C180Funzionigenerali, Menus,
  ShellAPI, ToolWin, ImgList, ActnList, Oracle, DBCtrls, OracleData, Variants,
  SelAnagrafe, RegistrazioneLog, C700USelezioneAnagrafe, ToolbarFiglio,
  A003UDataLavoroBis, Mask, System.ImageList, System.Actions;

type
  TDatiEngiSanita = record
    CdTab,CdInt,TpRec,TpChr,Storia:String;
  end;

  TB014FIntegrazioneAnagrafica = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    memoLog: TMemo;
    Panel1: TPanel;
    btnLog: TBitBtn;
    btnPulisciLog: TBitBtn;
    Label2: TLabel;
    edtRigheLog: TSpinEdit;
    TabSheet3: TTabSheet;
    Panel2: TPanel;
    dgrdIA000: TDBGrid;
    Label3: TLabel;
    edtFiltroIA000: TEdit;
    btnEseguiIA000: TBitBtn;
    StatusBar1: TStatusBar;
    btnEliminaIA000: TBitBtn;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    dgrdIA190: TDBGrid;
    StatusBar: TStatusBar;
    mnuSchedulazione: TPopupMenu;
    Copiaschedulazione1: TMenuItem;
    Eliminaschedulazione1: TMenuItem;
    TabSheet4: TTabSheet;
    GroupBox2: TGroupBox;
    dgrdIA100: TDBGrid;
    GroupBox3: TGroupBox;
    dgrdIA110: TDBGrid;
    popmnuServizio2: TPopupMenu;
    Installa2: TMenuItem;
    Avvia2: TMenuItem;
    Arresta2: TMenuItem;
    Disinstalla2: TMenuItem;
    ToolBar1: TToolBar;
    chkAvvioAutomatico: TCheckBox;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton1: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ActionList1: TActionList;
    actAvvio: TAction;
    actStop: TAction;
    actEsci: TAction;
    actServizio: TAction;
    ToolButton9: TToolButton;
    ImageList1: TImageList;
    Splitter1: TSplitter;
    popmnuBrowse: TPopupMenu;
    Browse1: TMenuItem;
    Eseguiora1: TMenuItem;
    N1: TMenuItem;
    Eliminatabella1: TMenuItem;
    popmnuInizializzaStrutture: TPopupMenu;
    CreaEngisanit1: TMenuItem;
    tabTriggerOutput: TTabSheet;
    popmnuTriggerOutput: TPopupMenu;
    Creatrigger1: TMenuItem;
    N2: TMenuItem;
    B014Personalizzata1: TMenuItem;
    Strutturabase1: TMenuItem;
    Engisanit1: TMenuItem;
    GroupBox4: TGroupBox;
    ToolBar2: TToolBar;
    TInserGriglia: TToolButton;
    TModifGriglia: TToolButton;
    TCancGriglia: TToolButton;
    ToolButton11: TToolButton;
    TAnnullaGriglia: TToolButton;
    TRegisGriglia: TToolButton;
    ToolButton10: TToolButton;
    TCreaTrigger: TToolButton;
    TEliminaTrigger: TToolButton;
    dgrdIA130: TDBGrid;
    Splitter2: TSplitter;
    DBMemo1: TDBMemo;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    btnEstrazioneDati: TBitBtn;
    dcmbAzienda: TDBLookupComboBox;
    cmbStrutture: TComboBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel4: TPanel;
    lblDatabase: TLabel;
    edtDataBase: TEdit;
    btnDataBase: TButton;
    lblDatabaseList: TLabel;
    edtDatabaseList: TEdit;
    btnDatabaseList: TButton;
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
    BitBtn1: TBitBtn;
    N3: TMenuItem;
    CopiainExcel1: TMenuItem;
    N4: TMenuItem;
    Visualizzaquellaesistente1: TMenuItem;
    N5: TMenuItem;
    tabModificaLog: TTabSheet;
    pnlModificaLog: TPanel;
    frmToolbarFiglio: TfrmToolbarFiglio;
    dgrdModificaLog: TDBGrid;
    StatusBar2: TStatusBar;
    DButton: TDataSource;
    rgpStato: TRadioGroup;
    gpbDataElab: TGroupBox;
    edtDaData: TMaskEdit;
    sbtDaData: TSpeedButton;
    edtAData: TMaskEdit;
    sbtAData: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    dcmbStruttura: TDBLookupComboBox;
    Label7: TLabel;
    procedure Visualizzaquellaesistente1Click(Sender: TObject);
    procedure CopiainExcel1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure dcmbAziendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actStopExecute(Sender: TObject);
    procedure avtAvvioExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure btnEseguiIA000Click(Sender: TObject);
    procedure btnEliminaIA000Click(Sender: TObject);
    procedure dgrdIA000EditButtonClick(Sender: TObject);
    procedure dgrdIA190EditButtonClick(Sender: TObject);
    procedure Copiaschedulazione1Click(Sender: TObject);
    procedure mnuSchedulazionePopup(Sender: TObject);
    procedure Eliminaschedulazione1Click(Sender: TObject);
    procedure actEsciExecute(Sender: TObject);
    procedure actServizioExecute(Sender: TObject);
    procedure Installa1Click(Sender: TObject);
    procedure Avvia1Click(Sender: TObject);
    procedure Disinstalla1Click(Sender: TObject);
    procedure Arresta1Click(Sender: TObject);
    procedure dgrdIA100DblClick(Sender: TObject);
    procedure Browse1Click(Sender: TObject);
    procedure popmnuBrowsePopup(Sender: TObject);
    procedure Eseguiora1Click(Sender: TObject);
    procedure Eliminatabella1Click(Sender: TObject);
    procedure popmnuInizializzaStrutturePopup(Sender: TObject);
    procedure CreaEngisanit1Click(Sender: TObject);
    procedure TAzioniGrigliaClick(Sender: TObject);
    procedure popmnuTriggerOutputPopup(Sender: TObject);
    procedure Creatrigger1Click(Sender: TObject);
    procedure Engisanit1Click(Sender: TObject);
    procedure btnEstrazioneDatiClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure dgrdIA100EditButtonClick(Sender: TObject);
    procedure btnDataBaseClick(Sender: TObject);
    procedure btnDatabaseListClick(Sender: TObject);
    procedure mnuHighestClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbtDaDataClick(Sender: TObject);
    procedure sbtADataClick(Sender: TObject);
    procedure rgpStatoClick(Sender: TObject);
    procedure edtDaDataExit(Sender: TObject);
    procedure dcmbStrutturaCloseUp(Sender: TObject);
    procedure dcmbStrutturaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DButtonStateChange(Sender: TObject);
    procedure dgrdModificaLogTitleClick(Column: TColumn);
    procedure dgrdModificaLogEditButtonClick(Sender: TObject);
  private
    { Private declarations }
    Servizio:Boolean;
    TestoScript:String;
    procedure PutParametriFunzione;
    procedure GetPriority;
    procedure AggiornaIA000;
  public
    { Public declarations }
  end;

var
  B014FIntegrazioneAnagrafica: TB014FIntegrazioneAnagrafica;

implementation

uses B014UMonitorIntegrazioneDtM, B014UIntegrazioneAnagraficaDtM,
     B014UViewMemo, B014UCopiaSchedulazione, B014UBrowseStruttura;

{$R *.DFM}

procedure TB014FIntegrazioneAnagrafica.FormCreate(Sender: TObject);
var Alias:String;
begin
  Alias:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B014','Database','');
  InputQuery('<B014> Integrazione Anagrafica','Seleziona database',Alias);
  edtDataBase.Text:=Alias;
  //edtDatabase.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B014','Database','');
  edtDataBaseList.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B014','DatabaseList','');
  PageControl1.ActivePage:=TabSheet1;
end;

procedure TB014FIntegrazioneAnagrafica.FormShow(Sender: TObject);
{I parametri di elaborazione sono letti già da B014FIntegrazioneAnagraficaDtM}
begin
  TRegistraMsg(B014FIntegrazioneAnagraficaDtM.SessioneIWB014.RegistraMsg).IniziaMessaggio('B014');
  GetPriority;
  //B014FIntegrazioneAnagraficaDtM.SessioneOracleB014:=SessioneOracle;
  B014FIntegrazioneAnagraficaDtM.ConnettiDatabase(edtDataBase.Text);
  if SessioneOracle.Connected then
  begin
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B014','Database',edtDataBase.Text);
    B014FMonitorIntegrazioneDtM.selIA100.Open;
    B014FMonitorIntegrazioneDtM.selIA190.Open;
    B014FMonitorIntegrazioneDtM.selIA130.Open;
  end;
  chkAvvioAutomatico.Checked:=B014FIntegrazioneAnagraficaDtM.AvvioAutomatico;
  actAvvio.Enabled:=not B014FIntegrazioneAnagraficaDtM.AvvioAutomatico;
  actEsci.Enabled:=not B014FIntegrazioneAnagraficaDtM.AvvioAutomatico;
  actStop.Enabled:=B014FIntegrazioneAnagraficaDtM.AvvioAutomatico;
  if SessioneOracle.Connected then
  begin
    CreaC004(SessioneOracle,'B014',-1);
    edtFiltroIA000.Text:=C004FParamForm.GetParametro('FILTROIA000','');
    TestoScript:=C004FParamForm.GetParametro('TESTOSCRIPT','');
    C004FParamForm.Free;
  end;
  edtRigheLog.Value:=B014FIntegrazioneAnagraficaDtM.RigheLog;
  dgrdIA000.DataSource:=B014FMonitorIntegrazioneDtM.dsrIA000;
  dgrdIA190.DataSource:=B014FMonitorIntegrazioneDtM.dsrIA190;
  dgrdIA100.DataSource:=B014FMonitorIntegrazioneDtM.dsrIA100;
  dgrdIA110.DataSource:=B014FMonitorIntegrazioneDtM.dsrIA110;
  B014FMonitorIntegrazioneDtM.selIA100.ReadOnly:=actStop.Enabled;
  B014FMonitorIntegrazioneDtM.selIA110.ReadOnly:=actStop.Enabled;
  B014FIntegrazioneAnagraficaDtM.StatusBar:=StatusBar;
  if SessioneOracle.Connected then
    with B014FMonitorIntegrazioneDtM.selI090 do
    begin
      dgrdIA110.Columns[0].PickList.Clear;
      dgrdIA110.Columns[0].PickList.Add('*');
      Open;
      while not Eof do
      begin
        dgrdIA110.Columns[0].PickList.Add(FieldByName('AZIENDA').AsString);
        dgrdIA130.Columns[0].PickList.Add(FieldByName('AZIENDA').AsString);
        Next;
      end;
    end;
  frmSelAnagrafe.Visible:=False;
  if SessioneOracle.Connected then
  begin
    lblDatabase.Font.Color:=clBlue;
    lblDatabase.Font.Style:=[];
    edtDatabase.Hint:='';
  end
  else
  begin
    lblDatabase.Font.Color:=clRed;
    lblDatabase.Font.Style:=[fsStrikeOut];
    edtDatabase.Hint:='Database non connesso';
  end;
  if B014FIntegrazioneAnagraficaDtM.AvvioAutomatico then
  begin
    B014FIntegrazioneAnagraficaDtM.Timer1.Enabled:=True;
    B014FIntegrazioneAnagraficaDtM.Timer1Timer(nil);
  end;
  B014FMonitorIntegrazioneDtM.selIA100.Filter:='LOG_MODIFICA = ''S''';
  B014FMonitorIntegrazioneDtM.selIA100.Filtered:=True;
//  tabModificaLog.Enabled:=B014FMonitorIntegrazioneDtM.selIA100.RecordCount > 0;
  tabModificaLog.TabVisible:=B014FMonitorIntegrazioneDtM.selIA100.RecordCount > 0;
  B014FMonitorIntegrazioneDtM.selIA100.Filter:='';
  B014FMonitorIntegrazioneDtM.selIA100.Filtered:=False;
end;

procedure TB014FIntegrazioneAnagrafica.actStopExecute(Sender: TObject);
begin
  B014FIntegrazioneAnagraficaDtM.Timer1.Enabled:=False;
  actAvvio.Enabled:=True;
  actStop.Enabled:=False;
  actEsci.Enabled:=True;
  B014FMonitorIntegrazioneDtM.selIA100.ReadOnly:=False;
  B014FMonitorIntegrazioneDtM.selIA110.ReadOnly:=False;
end;

procedure TB014FIntegrazioneAnagrafica.avtAvvioExecute(Sender: TObject);
begin
  actAvvio.Enabled:=False;
  actStop.Enabled:=True;
  actEsci.Enabled:=False;
  PutParametriFunzione;
  B014FIntegrazioneAnagraficaDtM.RigheLog:=edtRigheLog.Value;
  B014FIntegrazioneAnagraficaDtM.Timer1.Enabled:=True;
  B014FIntegrazioneAnagraficaDtM.Timer1Timer(nil);
  B014FMonitorIntegrazioneDtM.selIA100.ReadOnly:=True;
  B014FMonitorIntegrazioneDtM.selIA110.ReadOnly:=True;
end;

procedure TB014FIntegrazioneAnagrafica.PutParametriFunzione;
begin
  try
    CreaC004(SessioneOracle,'B014',-1);
    C004FParamForm.Cancella001;
    C004FParamForm.PutParametro('RIGHELOG',edtRigheLog.Text);
    if chkAvvioAutomatico.Checked then
      C004FParamForm.PutParametro('AVVIO','S')
    else
      C004FParamForm.PutParametro('AVVIO','N');
    C004FParamForm.PutParametro('FILTROIA000',edtFiltroIA000.Text);
    if Trim(TestoScript) <> '' then
      C004FParamForm.PutParametro('TESTOSCRIPT',TestoScript);
    C004FParamForm.Free;
    try SessioneOracle.Commit; except end;
  except
  end;
end;

procedure TB014FIntegrazioneAnagrafica.rgpStatoClick(Sender: TObject);
begin
  AggiornaIA000;
end;

procedure TB014FIntegrazioneAnagrafica.sbtADataClick(Sender: TObject);
begin
  edtAData.Text:=DateToStr(DataOut(StrToDate(edtAData.Text),'Data fine elaborazione','G'));
end;

procedure TB014FIntegrazioneAnagrafica.sbtDaDataClick(Sender: TObject);
begin
  edtDaData.Text:=DateToStr(DataOut(StrToDate(edtDaData.Text),'Data inizio elaborazione','G'));
end;

procedure TB014FIntegrazioneAnagrafica.btnLogClick(Sender: TObject);
{Visualizzazione del file di log}
begin
  if MessageDlg('Visualizzare i log delle elaborazioni?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  memoLog.Clear;
  try
    Screen.Cursor:=crHourGlass;
    with TRegistraMsg(B014FIntegrazioneAnagraficaDtM.SessioneIWB014.RegistraMsg) do
    begin
      LeggiMessaggi('B014');
      GetListaMessaggi(memoLog.Lines,edtRigheLog.Value,StringOfChar('=',19));
      Screen.Cursor:=crDefault;
    end;
  except
    on E:Exception do
    begin
      Screen.Cursor:=crDefault;
      R180MessageBox('Errore durante la visualizzazione del log:' + #13#10 +
                     E.Message,INFORMA);
    end;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.btnEseguiIA000Click(Sender: TObject);
{Esecuzione della query di interrogazione dei log delle registrazioni}
begin
  if MessageDlg('Visualizzare i log delle registrazioni col filtro indicato?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  with B014FMonitorIntegrazioneDtM.selIA000 do
  begin
    ClearVariables;
    if Trim(edtFiltroIA000.Text) <> '' then
      SetVariable('FILTRO','WHERE ' + Trim(edtFiltroIA000.Text));
    Close;
    Screen.Cursor:=crDefault;
    try
      Open;
    finally
      Screen.Cursor:=crDefault;
    end;
    StatusBar1.SimpleText:=Format('%d Records',[RecordCount]);
    StatusBar1.Repaint;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.btnEliminaIA000Click(Sender: TObject);
{Eliminazione del log delle registrazioni}
var S:String;
begin
  if MessageDlg('Eliminare i dati specificati dal filtro?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  Screen.Cursor:=crHourGlass;
  with B014FMonitorIntegrazioneDtM.delIA000 do
  try
    ClearVariables;
    S:=Trim(edtFiltroIA000.Text);
    if S <> '' then
    begin
      if Pos('ORDER BY',S) > 0 then
        S:=Trim(Copy(S,1,Pos('ORDER BY',S) - 1));
      if S <> '' then
        SetVariable('FILTRO',' WHERE ' + S);
    end;
    Execute;
    SessioneOracle.Commit;
    B014FMonitorIntegrazioneDtM.selIA000.Close;
    B014FMonitorIntegrazioneDtM.selIA000.Open;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.BitBtn1Click(Sender: TObject);
begin
  if MessageDlg('Attenzione! Verranno eliminate tutte le registrazioni.'+ #13 + 'Continuare?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    with TOracleQuery.Create(nil) do
    try
      Session:=B014FMonitorIntegrazioneDtM.delIA000.Session;
      SQL.Add('TRUNCATE TABLE IA000_LOGINTEGRAZIONE');
      Screen.Cursor:=crHourGlass;
      Execute;
      ShowMessage('Cancellazione effettuata');
      B014FMonitorIntegrazioneDtM.selIA000.Close;
      B014FMonitorIntegrazioneDtM.selIA000.Open;
    finally
      Free;
      Screen.Cursor:=crDefault;
    end;
end;


procedure TB014FIntegrazioneAnagrafica.dgrdIA000EditButtonClick(
  Sender: TObject);
{Visualizzazione del testo SQL}
begin
  B014FViewMemo:=TB014FViewMemo.Create(nil);
  with B014FViewMemo do
  try
    Memo1.Lines.Text:=dgrdIA000.SelectedField.AsString;
    ShowModal;
  finally
    Release;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.dgrdIA190EditButtonClick(Sender: TObject);
{Elenco delle strutture da schedulare}
var Browse:Boolean;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with B014FMonitorIntegrazioneDtM.selIA100Nome do
  begin
    Close;
    Open;
    while not Eof do
    begin
      C013FCheckList.clbListaDati.Items.Add(FieldByName('NOME_STRUTTURA').AsString);
      Next;
    end;
    Close;
  end;
  Browse:=B014FMonitorIntegrazioneDtM.selIA190.State = dsBrowse;
  R180PutCheckList(dgrdIA190.SelectedField.AsString,200,C013FCheckList.clbListaDati);
  if C013FCheckList.ShowModal = mrOK then
  begin
    if Browse then
      B014FMonitorIntegrazioneDtM.selIA190.Edit;
    dgrdIA190.SelectedField.AsString:=R180GetCheckList(200,C013FCheckList.clbListaDati);
    if Browse then
      B014FMonitorIntegrazioneDtM.selIA190.Post;
  end;
  FreeAndNil(C013FCheckList);
end;

procedure TB014FIntegrazioneAnagrafica.dgrdModificaLogEditButtonClick(Sender: TObject);
begin
  B014FViewMemo:=TB014FViewMemo.Create(nil);
  with B014FViewMemo do
  try
    Memo1.Lines.Text:=dgrdModificaLog.SelectedField.AsString;
    ShowModal;
  finally
    Release;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.dgrdModificaLogTitleClick(Column: TColumn);
var FiltroOrig,FiltroNew,App,s:String;
begin
  with B014FMonitorIntegrazioneDtM do
  begin
    FiltroOrig:=selIA000.GetVariable('FILTRO');
    App:=Copy(FiltroOrig,Pos('ORDER BY',FiltroOrig)+ 8,Length(FiltroOrig) - Pos('ORDER BY',FiltroOrig)- 7);
    s:=Column.FieldName;
    if (Pos(s,App) > 0) and
       (Copy(App,Pos(s,App)+Length(s)+1,4) <> 'DESC') then
      s:=s + ' DESC';
    if Column <> dgrdModificaLog.Columns[0] then
      s:=s + ', DATA_ELABORAZIONE';
    FiltroNew:=Copy(FiltroOrig,1,Pos('ORDER BY',FiltroOrig)-1);
    FiltroNew:=FiltroNew + 'ORDER BY ' + s;
    selIA000.Close;
    selIA000.SetVariable('FILTRO',FiltroNew);
    selIA000.Open;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.mnuSchedulazionePopup(Sender: TObject);
begin
  Copiaschedulazione1.Visible:=(actAvvio.Enabled) and
                               (B014FMonitorIntegrazioneDtM.selIA190.RecordCount > 0) and
                               (B014FMonitorIntegrazioneDtM.selIA190.State = dsBrowse) and
                               (not B014FMonitorIntegrazioneDtM.selIA190.FieldByName('ORA').IsNull) and
                               (not B014FMonitorIntegrazioneDtM.selIA190.FieldByName('STRUTTURE').IsNull);
  Eliminaschedulazione1.Visible:=(actAvvio.Enabled) and
                               (B014FMonitorIntegrazioneDtM.selIA190.RecordCount > 0) and
                               (B014FMonitorIntegrazioneDtM.selIA190.State = dsBrowse);
end;

procedure TB014FIntegrazioneAnagrafica.Copiaschedulazione1Click(Sender: TObject);
{copia delle schedulazione a intervalli fissi}
var Partenza,Intervallo,Termine:Integer;
    S:String;
begin
  B014FCopiaSchedulazione:=TB014FCopiaSchedulazione.Create(nil);
  with B014FCopiaSchedulazione do
  try
    if ShowModal = mrOK then
    begin
      S:=B014FMonitorIntegrazioneDtM.selIA190.FieldByName('STRUTTURE').AsString;
      Partenza:=R180OreMinutiExt(B014FMonitorIntegrazioneDtM.selIA190.FieldByName('ORA').AsString);
      Intervallo:=StrToInt(edtIntervallo.Text);
      Termine:=R180OreMinutiExt(edtTermine.Text);
      if (Intervallo < 1) or (Termine < 1) or (Termine >= 1440) then
        raise Exception.Create('Dati errati!');
      inc(Partenza,Intervallo);
      while Partenza <= Termine do
      begin
        B014FMonitorIntegrazioneDtM.selIA190.Append;
        B014FMonitorIntegrazioneDtM.selIA190.FieldByName('ORA').AsString:=R180MinutiOre(Partenza);
        B014FMonitorIntegrazioneDtM.selIA190.FieldByName('STRUTTURE').AsString:=S;
        B014FMonitorIntegrazioneDtM.selIA190.Post;
        inc(Partenza,Intervallo);
      end;
      SessioneOracle.Commit;
    end;
  finally
    Free;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.Eliminaschedulazione1Click(Sender: TObject);
{Eliminazione delle schedulazioni esistenti}
begin
  if MessageDlg('Attenzione!' + #13 + 'Verranno eliminate tutte le schedulazioni esistenti' + #13 + 'Confermare?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  with B014FMonitorIntegrazioneDtM.selIA190 do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      Delete;
    end;
  finally
    EnableControls;
    SessioneOracle.Commit;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.Eseguiora1Click(Sender: TObject);
begin
  if R180MessageBox('Eseguire le strutture selezionate?',DOMANDA) <> mrYes then
    Exit;

  TRegistraMsg(B014FIntegrazioneAnagraficaDtM.SessioneIWB014.RegistraMsg).IniziaMessaggio('B014');
  B014FIntegrazioneAnagraficaDtM.ElaborazioneStrutture(B014FMonitorIntegrazioneDtM.selIA190.FieldByName('STRUTTURE').AsString);
end;

procedure TB014FIntegrazioneAnagrafica.dgrdIA100DblClick(Sender: TObject);
begin
  B014FMonitorIntegrazioneDtM.selIA100.Refresh;
end;

procedure TB014FIntegrazioneAnagrafica.actServizioExecute(Sender: TObject);
{Evento inutile ma necessario per abilitare l'azione actServizio}
begin
  Servizio:=True;
end;

procedure TB014FIntegrazioneAnagrafica.Installa1Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFilePath(Application.ExeName) + 'B014PINTEGRAZIONEANAGRAFICASRV.EXE'),PChar('/INSTALL'),nil,SW_SHOWNORMAL);
end;

procedure TB014FIntegrazioneAnagrafica.Avvia1Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar('NET'),PChar('START B014INTEGRAZIONEANAGRAFICA'),nil,SW_SHOWNORMAL);
end;

procedure TB014FIntegrazioneAnagrafica.Arresta1Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar('NET'),PChar('STOP B014INTEGRAZIONEANAGRAFICA'),nil,SW_SHOWNORMAL);
end;

procedure TB014FIntegrazioneAnagrafica.Disinstalla1Click(Sender: TObject);
begin
  ShellExecute(0,'open', PChar(ExtractFilePath(Application.ExeName) + 'B014PINTEGRAZIONEANAGRAFICASRV.EXE'),PChar('/UNINSTALL'),nil,SW_SHOWNORMAL);
end;

procedure TB014FIntegrazioneAnagrafica.edtDaDataExit(Sender: TObject);
begin
  if (Sender = edtDaData) and (edtAData.Text = '  /  /    ') then
    edtAData.Text:=DateToStr(R180FineMese(StrToDate(edtDaData.Text)));
  AggiornaIA000;
end;

procedure TB014FIntegrazioneAnagrafica.actEsciExecute(Sender: TObject);
begin
  Close;
end;

procedure TB014FIntegrazioneAnagrafica.popmnuBrowsePopup(Sender: TObject);
begin
  Browse1.Enabled:=not B014FMonitorIntegrazioneDtM.selIA100.FieldByName('NOME_STRUTTURA').IsNull;
  EliminaTabella1.Enabled:=(not B014FMonitorIntegrazioneDtM.selIA100.FieldByName('NOME_STRUTTURA').IsNull) and
                           (B014FMonitorIntegrazioneDtM.selIA100.FieldByName('TIPO_STRUTTURA').AsString = 'F');
  //Verifica che le tabelle non siano della base dati (Progressivo numerico in posizione 2 o 3)
  if EliminaTabella1.Enabled then
  with B014FMonitorIntegrazioneDtM.selIA100 do
    if (StrToIntDef(Copy(FieldByName('NOME_STRUTTURA').AsString,2,3),-1) <> -1) or
       (StrToIntDef(Copy(FieldByName('NOME_STRUTTURA').AsString,3,3),-1) <> -1) then
      EliminaTabella1.Enabled:=False;
end;

procedure TB014FIntegrazioneAnagrafica.Browse1Click(Sender: TObject);
begin
  B014FBrowseStruttura:=TB014FBrowseStruttura.Create(nil);
  with B014FBrowseStruttura do
  try
    NomeStruttura:=B014FMonitorIntegrazioneDtM.selIA100.FieldByName('NOME_STRUTTURA').AsString;
    TestoSQL:='SELECT * FROM ' + B014FMonitorIntegrazioneDtM.selIA100.FieldByName('NOME_STRUTTURA').AsString;
    edtScript.Text:=TestoScript;
    dgrdIADati.DataSource:=B014FMonitorIntegrazioneDtM.dsrIADati;
    Caption:=Caption + ' ' + B014FMonitorIntegrazioneDtM.selIA100.FieldByName('NOME_STRUTTURA').AsString;
    btnRefreshClick(nil);
    ShowModal;
    if Trim(edtScript.Text) <> '' then
      TestoScript:=edtScript.Text;
  finally
    Release;
    B014FMonitorIntegrazioneDtM.selIADati.Close;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not actEsci.Enabled then
    Action:=caNone
  else
    PutParametriFunzione;
end;

procedure TB014FIntegrazioneAnagrafica.Eliminatabella1Click(
  Sender: TObject);
begin
  if MessageDlg('Eliminare la tabella ' + B014FMonitorIntegrazioneDtM.selIA100.FieldByName('NOME_STRUTTURA').AsString + '?',mtConfirmation,[mbNo,mbYes],0) <> mrYes then exit;
  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneOracle;
    if Parametri.VersioneOracle >= 10 then
      SQL.Add('DROP TABLE ' + B014FMonitorIntegrazioneDtM.selIA100.FieldByName('NOME_STRUTTURA').AsString + ' PURGE')
    else
      SQL.Add('DROP TABLE ' + B014FMonitorIntegrazioneDtM.selIA100.FieldByName('NOME_STRUTTURA').AsString);
    Execute;
    ShowMessage('Tabella eliminata');
  finally
    Free;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.popmnuInizializzaStrutturePopup(
  Sender: TObject);
begin
  CreaEngisanit1.Visible:=PageControl1.ActivePage <> tabModificaLog;
  CreaEngisanit1.Enabled:=(B014FMonitorIntegrazioneDtM.selIA110.RecordCount = 0) and
                          (B014FMonitorIntegrazioneDtM.selIA100.FieldByName('TIPO_STRUTTURA').AsString = 'F');
end;

procedure TB014FIntegrazioneAnagrafica.CreaEngisanit1Click(
  Sender: TObject);
const DatiEngiSanita:array[1..63] of TDatiEngiSanita =
  ((CdTab:'T430_STORICO'   ;CdInt:'BADGE';         TpRec:'GPA-BADGE';  TpChr:'N';Storia:'N'),
   (CdTab:'T030_ANAGRAFICO';CdInt:'';              TpRec:'GPA-CRMA';   TpChr:'A';Storia:'N'),
   (CdTab:'T030_ANAGRAFICO';CdInt:'COGNOME';       TpRec:'GPA-COGN';   TpChr:'A';Storia:'N'),
   (CdTab:'T030_ANAGRAFICO';CdInt:'NOME';          TpRec:'GPA-NOME';   TpChr:'A';Storia:'N'),
   (CdTab:'T030_ANAGRAFICO';CdInt:'CODFISCALE';    TpRec:'GPA-COFI';   TpChr:'A';Storia:'N'),
   (CdTab:'T030_ANAGRAFICO';CdInt:'SESSO';         TpRec:'GPA-SESS';   TpChr:'A';Storia:'N'),
   (CdTab:'T030_ANAGRAFICO';CdInt:'DATANAS';       TpRec:'GPA-DTNA';   TpChr:'D';Storia:'N'),
   (CdTab:'T030_ANAGRAFICO';CdInt:'COMUNENAS';     TpRec:'GPA-CONA';   TpChr:'A';Storia:'N'),
   (CdTab:'T030_ANAGRAFICO';CdInt:'';              TpRec:'GPA-DENA';   TpChr:'A';Storia:'N'),
   (CdTab:'T030_ANAGRAFICO';CdInt:'';              TpRec:'GPA-PROVCN'; TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'COMUNE';        TpRec:'GPA-CORE';   TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-DERE';   TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-PROVCR'; TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'CAP';           TpRec:'GPA-CAPR';   TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'INDIRIZZO';     TpRec:'GPA-INDR';   TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CODO';   TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-DEDO';   TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-PROVCD'; TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CAPD';   TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-INDD';   TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-RECA';   TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'STATO_CIVILE';  TpRec:'GPA-STCV';   TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-SCRIL';  TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'TELEFONO';      TpRec:'GPA-TELEF';  TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CDEP';   TpChr:'A';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'SEDE_SERVIZIO'; TpRec:'GPA-SESE';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-SSRIL';  TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'SETTORE';       TpRec:'GPA-UNOR';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-UORIL';  TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CDCO';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CCRIL';  TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'INIZIO';        TpRec:'GPA-DTAS';   TpChr:'D';Storia:'S'),
   (CdTab:'T030_ANAGRAFICO';CdInt:'';              TpRec:'GPA-ANZCO';  TpChr:'D';Storia:'N'),
   (CdTab:'T430_STORICO';   CdInt:'FINE';          TpRec:'GPA-DTCE';   TpChr:'D';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'QUALIFICA';     TpRec:'GPA-CDQU';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'QUALIF_MINIST'; TpRec:'GPA-QUMT';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CDRU';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CDLR';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'LIVELLO';       TpRec:'GPA-CDLC';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CDRG';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CDPP';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CDPF';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CDDI';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-QURIL';  TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CDNT';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-NTRIL';  TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'TIPO_RAPPORTO'; TpRec:'GPA-CDTP';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-TPRIL';  TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CDIS';   TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISCDQU'; TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISCDRU'; TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISCDLR'; TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISCDLC'; TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISCDRG'; TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISCDPP'; TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISCDPF'; TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISCDDI'; TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISQURIL';TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISCDNT'; TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISNTRIL';TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISCDTP'; TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-ISTPRIL';TpChr:'A';Storia:'S'),
   (CdTab:'T430_STORICO';   CdInt:'';              TpRec:'GPA-CDST';   TpChr:'A';Storia:'S')
   );
var i:Integer;
begin
  with B014FMonitorIntegrazioneDtM.selIA110 do
  begin
    Append;
    FieldByName('INTESTAZIONE').AsString:='CHIAVE';
    FieldByName('TABELLA').AsString:='T030_ANAGRAFICO';
    FieldByName('CAMPO').AsString:='MATRICOLA';
    FieldByName('POS_DATO').AsInteger:=21;
    FieldByName('LUNG_DATO').AsInteger:=8;
    FieldByName('NOME_DATO').AsString:='CHIAVE';
    FieldByName('TIPO_DATO').AsString:='N';
    Post;
    Append;
    FieldByName('INTESTAZIONE').AsString:='DATA';
    FieldByName('POS_DATO').AsInteger:=124;
    FieldByName('LUNG_DATO').AsInteger:=12;
    FieldByName('NOME_DATO').AsString:='DATA_AGG';
    FieldByName('TIPO_DATO').AsString:='D';
    FieldByName('FMT_DATA').AsString:='YYYYMMDDHHNN';
    Post;
    Append;
    FieldByName('INTESTAZIONE').AsString:='SEQUENZA';
    FieldByName('LUNG_DATO').AsInteger:=20;
    FieldByName('NOME_DATO').AsString:='ID';
    FieldByName('TIPO_DATO').AsString:='A';
    Post;
    Append;
    FieldByName('INTESTAZIONE').AsString:='UTENTE';
    FieldByName('POS_DATO').AsInteger:=136;
    FieldByName('LUNG_DATO').AsInteger:=6;
    FieldByName('NOME_DATO').AsString:='UTENTE';
    FieldByName('TIPO_DATO').AsString:='A';
    Post;
    Append;
    FieldByName('INTESTAZIONE').AsString:='DECORRENZA';
    FieldByName('POS_DATO').AsInteger:=101;
    FieldByName('LUNG_DATO').AsInteger:=8;
    FieldByName('NOME_DATO').AsString:='DECORRENZA';
    FieldByName('TIPO_DATO').AsString:='D';
    FieldByName('FMT_DATA').AsString:='YYYYMMDD';
    Post;
    Append;
    FieldByName('INTESTAZIONE').AsString:='SCADENZA';
    FieldByName('POS_DATO').AsInteger:=109;
    FieldByName('LUNG_DATO').AsInteger:=8;
    FieldByName('NOME_DATO').AsString:='SCADENZA';
    FieldByName('TIPO_DATO').AsString:='D';
    FieldByName('FMT_DATA').AsString:='YYYYMMDD';
    Post;
    Append;
    FieldByName('INTESTAZIONE').AsString:='DATO';
    FieldByName('POS_DATO').AsInteger:=1;
    FieldByName('LUNG_DATO').AsInteger:=10;
    FieldByName('NOME_DATO').AsString:='NOME_DATO';
    FieldByName('TIPO_DATO').AsString:='A';
    Post;
    Append;
    FieldByName('INTESTAZIONE').AsString:='VALORE';
    FieldByName('POS_DATO').AsInteger:=41;
    FieldByName('LUNG_DATO').AsInteger:=60;
    FieldByName('NOME_DATO').AsString:='VALORE';
    FieldByName('TIPO_DATO').AsString:='A';
    Post;
    for i:=1 to High(DatiEngiSanita) do
    begin
      Append;
      FieldByName('TABELLA').AsString:=DatiEngiSanita[i].CdTab;
      FieldByName('CAMPO').AsString:=DatiEngiSanita[i].CdInt;
      FieldByName('NOME_DATO').AsString:=DatiEngiSanita[i].TpRec;
      FieldByName('TIPO_DATO').AsString:=DatiEngiSanita[i].TpChr;
      FieldByName('STORICO').AsString:=DatiEngiSanita[i].Storia;
      if (FieldByName('CAMPO').AsString = 'INIZIO') or (FieldByName('CAMPO').AsString = 'FINE') then
        FieldByName('VIRTUALE').AsString:='S';
      if FieldByName('TIPO_DATO').AsString = 'D' then
        FieldByName('FMT_DATA').AsString:='YYYYMMDD';
      Post;
    end;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.TAzioniGrigliaClick(Sender: TObject);
begin
  if Sender = TInserGriglia then
    B014FMonitorIntegrazioneDtM.selIA130.Insert
  else if Sender = TModifGriglia then
    B014FMonitorIntegrazioneDtM.selIA130.Edit
  else if Sender = TCancGriglia then
    B014FMonitorIntegrazioneDtM.selIA130.Delete
  else if Sender = TAnnullaGriglia then
    B014FMonitorIntegrazioneDtM.selIA130.Cancel
  else if Sender = TRegisGriglia then
    B014FMonitorIntegrazioneDtM.selIA130.Post
  else if Sender = TCreaTrigger then
    B014FMonitorIntegrazioneDtM.GestisciTriggerIA130('CREA')
  else if Sender = TEliminaTrigger then
    B014FMonitorIntegrazioneDtM.GestisciTriggerIA130('ELIMINA');
end;

procedure TB014FIntegrazioneAnagrafica.popmnuTriggerOutputPopup(Sender: TObject);
begin
  Creatrigger1.Enabled:=(B014FMonitorIntegrazioneDtM.selIA130.State in [dsInsert,dsEdit]) and
                        (not B014FMonitorIntegrazioneDtM.selIA130.FieldByName('TABELLA').IsNull) and
                        (B014FMonitorIntegrazioneDtM.selIA130.FieldByName('TRIGGER_TEXT').IsNull);
end;

procedure TB014FIntegrazioneAnagrafica.Creatrigger1Click(Sender: TObject);
var Tabella,TriggerText:String;
begin
  Tabella:=B014FMonitorIntegrazioneDtM.selIA130.FieldByName('TABELLA').AsString;
  TriggerText:='-- E'' necessario eseguire i seguenti comandi come utente SYS:' + #13#10 +
               '-- GRANT SELECT ON V_$SESSION TO PUBLIC;' + #13#10 +
               '-- GRANT SELECT ON V_$MYSTAT TO PUBLIC;' + #13#10 + #13#10 +
               '-- Sostituire opportunamente campo1,campo2 con' + #13#10 +
               '-- l''elenco dei campi che si vuole gestire in output (BADGE,CENTRO_COSTO, ecc...)' + #13#10 + #13#10 +
               'CREATE OR REPLACE TRIGGER ' + Tabella + '_DATI_OUT' + #13#10 +
               'AFTER INSERT OR UPDATE OF campo1,campo2 ON ' + Tabella + ' FOR EACH ROW' + #13#10 +
               'DECLARE' + #13#10 +
               'BEGIN' + #13#10 +
               '  INSERT INTO MONDOEDP.IA120_DATIOUTPUT' + #13#10 +
               '    (AZIENDA,TABELLA,ID_DATO,DATA_REGISTRAZIONE,ID,OS_USER,MACHINE_USER,USERNAME)' + #13#10 +
               '    SELECT NVL(I090.CODICE_INTEGRAZIONE,''*''),''' + Tabella + ''',:NEW.PROGRESSIVO,SYSDATE,' + #13#10 +
               '           MONDOEDP.IA120_ID.NEXTVAL,V.OSUSER,V.MACHINE,V.USERNAME' + #13#10 +
               '      FROM V$SESSION V, MONDOEDP.I090_ENTI I090 WHERE' + #13#10 +
               '      V.SID = (SELECT MAX(SID) FROM V$MYSTAT) AND V.USERNAME = I090.UTENTE(+) AND ROWNUM = 1 AND' + #13#10 +
               '      NOT EXISTS(SELECT ''X'' FROM MONDOEDP.IA120_DATIOUTPUT WHERE TABELLA = ''' + Tabella + '''' + #13#10 +
               '                 AND ID_DATO = :NEW.PROGRESSIVO AND AZIENDA = I090.CODICE_INTEGRAZIONE);' + #13#10 +
               'EXCEPTION' + #13#10 +
               '  WHEN OTHERS THEN NULL;' + #13#10 +
               'END;';
  B014FMonitorIntegrazioneDtM.selIA130.FieldByName('TRIGGER_TEXT').AsString:=TriggerText;
end;

procedure TB014FIntegrazioneAnagrafica.DButtonStateChange(Sender: TObject);
begin
  if DButton <> nil then
  begin
    frmToolbarFiglio.DButtonStateChange(DButton);
    if DButton.State = dsBrowse then
      dgrdModificaLog.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgTitleClick,dgTitleHotTrack];
  end;
end;

procedure TB014FIntegrazioneAnagrafica.Engisanit1Click(Sender: TObject);
{Visualizzazione stuttura di B014Personalizzata, da inserire nel package SELECT_APERTE}
begin
  with TB014FViewMemo.Create(nil) do
  try
    Memo1.Lines.Clear;
    Memo1.Lines.Add('  procedure B014Personalizzata(p in integer, dal in date, dato in varchar2, valore in varchar2, struttura in varchar2, sequenza in varchar2, rowid_riga in varchar2) is');
    if Sender = Engisanit1 then
    begin
      Memo1.Lines.Add('  m varchar2(8);');
      Memo1.Lines.Add('  t430inizio date;');
      Memo1.Lines.Add('  t430fine date;');
      Memo1.Lines.Add('  dadata date;');
      Memo1.Lines.Add('  begin');
      Memo1.Lines.Add('    --''dal'' corrisponde al dato di assunzione/cessazione, mentre la scadenza non è significativa');
      Memo1.Lines.Add('    --nel caso di GPA-DTCE, ''dato'' può essere 00000000 (null) con il dal riferito alla precedente cessazione');
      Memo1.Lines.Add('    if dato in (''GPA-DTAS'',''GPA-DTCE'') then');
      Memo1.Lines.Add('      --Gestione cessazione senza creare periodi storici');
      Memo1.Lines.Add('      if dato = ''GPA-DTCE'' then');
      Memo1.Lines.Add('        if NVL(valore,''NULL'') in ('''',''NULL'') then');
      Memo1.Lines.Add('          UPDATE T430_STORICO T430 SET FINE = null WHERE');
      Memo1.Lines.Add('            PROGRESSIVO = p AND');
      Memo1.Lines.Add('            INIZIO = (SELECT MAX(INIZIO) FROM T430_STORICO WHERE PROGRESSIVO = T430.PROGRESSIVO AND INIZIO <= dal);');
      Memo1.Lines.Add('        else');
      Memo1.Lines.Add('          UPDATE T430_STORICO T430 SET FINE = dal WHERE');
      Memo1.Lines.Add('            PROGRESSIVO = p AND');
      Memo1.Lines.Add('            INIZIO = (SELECT MAX(INIZIO) FROM T430_STORICO WHERE PROGRESSIVO = T430.PROGRESSIVO AND INIZIO <= dal);');
      Memo1.Lines.Add('        end if;');
      Memo1.Lines.Add('      end if;');
      Memo1.Lines.Add('      --Gestione assunzione dopo aver creato il periodo storico');
      Memo1.Lines.Add('      if dato = ''GPA-DTAS'' then');
      Memo1.Lines.Add('        begin');
      Memo1.Lines.Add('          dadata:=dal;');
      Memo1.Lines.Add('          creazione_storico(p,dadata,null);');
      Memo1.Lines.Add('          --Lettura inizio, fine validi nel periodo storico della nuova assunzione (dal)');
      Memo1.Lines.Add('          SELECT NVL(INIZIO,TO_DATE(''31123999'',''DDMMYYYY'')),NVL(FINE,TO_DATE(''31123999'',''DDMMYYYY'')) INTO t430inizio,t430fine FROM T430_STORICO WHERE');
      Memo1.Lines.Add('          PROGRESSIVO = p AND');
      Memo1.Lines.Add('          dal BETWEEN DATADECORRENZA AND DATAFINE;');
      Memo1.Lines.Add('          if dal <= t430fine then');
      Memo1.Lines.Add('            --correzione assunzione esistente, aggiorno tuti i periodi con INIZIO corrispondente al vecchio INIZIO');
      Memo1.Lines.Add('            UPDATE T430_STORICO SET INIZIO = dal WHERE');
      Memo1.Lines.Add('              PROGRESSIVO = p AND');
      Memo1.Lines.Add('              NVL(INIZIO,TO_DATE(''31123999'',''DDMMYYYY'')) = t430inizio;');
      Memo1.Lines.Add('          else');
      Memo1.Lines.Add('            --nuova assunzione');
      Memo1.Lines.Add('            UPDATE T430_STORICO SET INIZIO = dal WHERE');
      Memo1.Lines.Add('              PROGRESSIVO = p AND');
      Memo1.Lines.Add('              DATADECORRENZA >= dal AND (INIZIO IS NULL OR INIZIO < dal);');
      Memo1.Lines.Add('          end if;');
      Memo1.Lines.Add('        exception');
      Memo1.Lines.Add('          when no_data_found then');
      Memo1.Lines.Add('            null;');
      Memo1.Lines.Add('        end;');
      Memo1.Lines.Add('      end if;');
      Memo1.Lines.Add('      --Chiamata alla procedura Oracle standard di Allineamento Periodi Rapporto');
      Memo1.Lines.Add('      select matricola into m from t030_anagrafico where progressivo = p;');
      Memo1.Lines.Add('      allineaperiodirapporto(m);');
      Memo1.Lines.Add('    end if;');
      Memo1.Lines.Add('  exception');
      Memo1.Lines.Add('    when no_data_found then');
      Memo1.Lines.Add('      null;');
      Memo1.Lines.Add('  end;');
    end
    else
    begin
      Memo1.Lines.Add('begin');
      Memo1.Lines.Add('  null;');
      Memo1.Lines.Add('end;');
    end;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.PageControl1Change(Sender: TObject);
{Caricamento delle strutture di Output per l'estrazione dati}
begin
  B014FMonitorIntegrazioneDtM.selIA100.Filter:='';
  B014FMonitorIntegrazioneDtM.selIA100.Filtered:=False;
  if Pagecontrol1.ActivePage = tabTriggerOutput then
    with B014FMonitorIntegrazioneDtM.selIA100 do
    begin
      cmbStrutture.Items.Clear;
      First;
      while not Eof do
      begin
        if FieldByName('DIREZIONE_DATI').AsString = 'O' then
          cmbStrutture.Items.Add(FieldByName('NOME_STRUTTURA').AsString);
        Next;
      end;
    end;
  if Pagecontrol1.ActivePage = tabModificaLog then
  begin
    B014FMonitorIntegrazioneDtM.selIA100.Filter:='LOG_MODIFICA = ''S''';
    B014FMonitorIntegrazioneDtM.selIA100.Filtered:=True;
    if B014FMonitorIntegrazioneDtM.selIA100.RecordCount > 0 then
      dcmbStruttura.KeyValue:=B014FMonitorIntegrazioneDtM.selIA100.FieldByName('NOME_STRUTTURA').AsString;
    DButton.Dataset:=B014FMonitorIntegrazioneDtM.selIA000;
    frmToolbarFiglio.TFDButton:=DButton;
    frmToolbarFiglio.TFDBGrid:=dgrdModificaLog;
    SetLength(frmToolbarFiglio.lstLock,1);
    frmToolbarFiglio.lstLock[0]:=pnlModificaLog;
    edtDaData.Clear;
    edtAData.Clear;
    with B014FMonitorIntegrazioneDtM do
    begin
      if selIA100.RecordCount <= 0 then
      begin
        selIA000.Close;
        Exit;
      end;
      scrGenerico.SQL.Clear;
      scrGenerico.SQL.Add('SELECT MAX(TRUNC(DATA_ELABORAZIONE))-7 MINIMO, MAX(TRUNC(DATA_ELABORAZIONE)) MASSIMO');
      scrGenerico.SQL.Add('  FROM IA000_LOGINTEGRAZIONE');
      scrGenerico.SQL.Add(' WHERE STRUTTURA = ''' + VarToStr(dcmbStruttura.KeyValue) + '''');
      scrGenerico.Execute;
      if (scrGenerico.RowsProcessed <= 0) or (VarToStr(scrGenerico.Field(0)) = '') then
      begin
        selIA000.Close;
        Exit;
      end;
      edtDaData.Text:=VarToStr(scrGenerico.Field(0));
      edtAData.Text:=VarToStr(scrGenerico.Field(1));
    end;
    AggiornaIA000;
    frmToolbarFiglio.AbilitaAzioniTF(nil);
  end;
end;

procedure TB014FIntegrazioneAnagrafica.AggiornaIA000;
var s:String;
begin
  with B014FMonitorIntegrazioneDtM do
  begin
    selIA000.Close;
    selIA000.ClearVariables;
    s:='WHERE STRUTTURA = ''' + VarToStr(dcmbStruttura.KeyValue) + '''';
    s:=s + '  AND TRUNC(DATA_ELABORAZIONE) BETWEEN TO_DATE(''' + edtDaData.Text + ''',''DD/MM/YYYY'') AND TO_DATE(''' + edtAData.Text + ''',''DD/MM/YYYY'')';
    if rgpStato.ItemIndex = 0 then
      s:=s + ' AND STATO = ''E'''
    else if rgpStato.ItemIndex = 1 then
      s:=s + ' AND STATO = ''R'''
    else if rgpStato.ItemIndex = 2 then
      s:=s + ' AND STATO IN (''I'',''M'')';
    s:=s + ' ORDER BY DATA_ELABORAZIONE';
    selIA000.SetVariable('FILTRO',s);
    try
      selIA000.Open;
    except
    end;
    StatusBar2.SimpleText:=Format('%d Records',[selIA000.RecordCount]);
    StatusBar2.Repaint;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.btnEstrazioneDatiClick(Sender: TObject);
{Estrazione dati}
var L:TStringList;
begin
  if (dcmbAzienda.Text = '') or (cmbStrutture.Text = '') then
    raise Exception.Create('Specificare Azienda e Struttura!');
  TRegistraMsg(B014FIntegrazioneAnagraficaDtM.SessioneIWB014.RegistraMsg).IniziaMessaggio('B014');
  with B014FMonitorIntegrazioneDtM do
  begin
    SessioneAzienda.Logoff;
    SessioneAzienda.LogonDatabase:=SessioneOracle.LogonDatabase;
    SessioneAzienda.LogonUserName:=VarToStr(selI090.Lookup('AZIENDA',dcmbAzienda.Text,'UTENTE'));
    SessioneAzienda.LogonPassword:=R180Decripta(VarToStr(selI090.Lookup('AZIENDA',dcmbAzienda.Text,'PAROLACHIAVE')),21041974);
    SessioneAzienda.Logon;
  end;
  L:=TStringList.Create;
  try
    L.Assign(Parametri.ColonneStruttura);
    Parametri.ColonneStruttura.Clear;
    C700DatiVisualizzati:='';
    C700DatiSelezionati:=C700CampiBase;
    C700DataLavoro:=Date;
    frmSelAnagrafe.OnCambiaProgressivo:=nil;
    frmSelAnagrafe.CreaSelAnagrafe(B014FMonitorIntegrazioneDtM.SessioneAzienda,nil,0,False);
    frmSelAnagrafe.btnSelezioneClick(Sender);
    if R180MessageBox(Format('Sono state selezionate %d anagrafiche. Eseguire l''estrazione?',[C700SelAnagrafe.RecordCount]),DOMANDA) = mrYes then
    begin
      C700SelAnagrafe.First;
      while not C700SelAnagrafe.Eof do
      begin
        with B014FMonitorIntegrazioneDtM.insIA120 do
        try
          SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByname('PROGRESSIVO').AsInteger);
          Execute;
        except
        end;
        C700SelAnagrafe.Next;
      end;
      B014FMonitorIntegrazioneDtM.SessioneAzienda.Commit;
      B014FIntegrazioneAnagraficaDtM.ElaborazioneStrutture(cmbStrutture.Text);
      ShowMessage('Estrazione terminata');
    end;
  finally
    frmSelAnagrafe.DistruggiSelAnagrafe;
    Parametri.ColonneStruttura.Assign(L);
    L.Free;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.dgrdIA100EditButtonClick(Sender: TObject);
begin
  if (dgrdIA100.SelectedField.FieldName = 'SCRIPT_BEFORE') or (dgrdIA100.SelectedField.FieldName = 'SCRIPT_AFTER') then
  begin
    B014FViewMemo:=TB014FViewMemo.Create(nil);
    try
      B014FViewMemo.Memo1.ReadOnly:=False;
      B014FViewMemo.Memo1.Text:=dgrdIA100.SelectedField.AsString;
      B014FViewMemo.ShowModal;
      if dgrdIA100.SelectedField.DataSet.State = dsBrowse then
        dgrdIA100.SelectedField.DataSet.Edit;
      dgrdIA100.SelectedField.AsString:=B014FViewMemo.Memo1.Text;
    finally
      FreeAndNil(B014FViewMemo);
    end;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.btnDataBaseClick(Sender: TObject);
var Db,DbOld:String;
begin
  Db:=edtDatabase.Text;
  DbOld:=SessioneOracle.LogonDatabase;
  if InputQuery('Connessione al database','Database:',Db) then
  begin
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B014','Database',Db);
    edtDatabase.Text:=Db;
    SessioneOracle.Logoff;
    FormShow(nil);
    if not SessioneOracle.Connected then
    begin
      R180PutRegistro(HKEY_LOCAL_MACHINE,'B014','Database',DbOld);
      edtDatabase.Text:=DbOld;
      lblDatabase.Font.Color:=clRed;
      lblDatabase.Font.Style:=[fsStrikeOut];
      edtDatabase.Hint:='Database non connesso';
      FormShow(nil);
    end;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.btnDatabaseListClick(Sender: TObject);
var Db:String;
begin
  Db:=edtDatabaseList.Text;
  if InputQuery('Connessioni ai database','Database:',Db) then
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B014','DatabaseList',Db);
  edtDatabaseList.Text:=Db;
end;

procedure TB014FIntegrazioneAnagrafica.mnuHighestClick(Sender: TObject);
begin
  R180PutRegistro(HKEY_LOCAL_MACHINE,'B014','Priority',IntToStr(TMenuItem(Sender).Tag));
  GetPriority;
end;

procedure TB014FIntegrazioneAnagrafica.GetPriority;
var P:Integer;
begin
  P:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B014','Priority','3'),3);
  mnuLowest.Checked:=mnuLowest.Tag = P;
  mnuLower.Checked:=mnuLower.Tag = P;
  mnuNormal.Checked:=mnuNormal.Tag = P;
  mnuHigher.Checked:=mnuHigher.Tag = P;
  mnuHighest.Checked:=mnuHighest.Tag = P;
end;

procedure TB014FIntegrazioneAnagrafica.dcmbAziendaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TB014FIntegrazioneAnagrafica.dcmbStrutturaCloseUp(Sender: TObject);
begin
  edtDaData.Clear;
  edtAData.Clear;
  with B014FMonitorIntegrazioneDtM do
  begin
    scrGenerico.SQL.Clear;
    scrGenerico.SQL.Add('SELECT MAX(TRUNC(DATA_ELABORAZIONE))-7 MINIMO, MAX(TRUNC(DATA_ELABORAZIONE)) MASSIMO');
    scrGenerico.SQL.Add('  FROM IA000_LOGINTEGRAZIONE');
    scrGenerico.SQL.Add(' WHERE STRUTTURA = ''' + VarToStr(dcmbStruttura.KeyValue) + '''');
    scrGenerico.Execute;
    if (scrGenerico.RowsProcessed <= 0) or (VarToStr(scrGenerico.Field(0)) = '') then
    begin
      selIA000.Close;
      Exit;
    end;
    edtDaData.Text:=VarToStr(scrGenerico.Field(0));
    edtAData.Text:=VarToStr(scrGenerico.Field(1));
  end;
  AggiornaIA000;
end;

procedure TB014FIntegrazioneAnagrafica.dcmbStrutturaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  dcmbStrutturaCloseUp(nil);
end;

procedure TB014FIntegrazioneAnagrafica.CopiainExcel1Click(Sender: TObject);
begin
  if PageControl1.ActivePage = tabModificaLog then
    R180DBGridCopyToClipboard(dgrdModificaLog,True,False)
  else
    R180DBGridCopyToClipboard(dgrdIA110,True,False);
end;

procedure TB014FIntegrazioneAnagrafica.Visualizzaquellaesistente1Click(
  Sender: TObject);
begin
  with TB014FViewMemo.Create(nil) do
  try
    pnlAzienda.Visible:=True;
    ShowModal;
  finally
    Release;
  end;
end;

end.
