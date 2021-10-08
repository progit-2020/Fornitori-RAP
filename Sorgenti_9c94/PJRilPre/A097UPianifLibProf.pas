unit A097UPianifLibProf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StrUtils, Buttons, StdCtrls, ExtCtrls, DB, OracleData, Spin, DBCtrls, Menus,
  Grids, DBGrids, ComCtrls, Mask, Variants, RegistrazioneLog, SelAnagrafe,
  C001StampaLib, C005UDatiAnagrafici, C015UElencoValori, C180FunzioniGenerali,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione, A003UDataLavoroBis,
  A083UMsgElaborazioni, A096UProfiliLibProf, C700USelezioneAnagrafe, ToolbarFiglio;

type
  TA097FPianifLibProf = class(TForm)
    pnlGestioneProfilo: TPanel;
    EProfilo: TDBLookupComboBox;
    Label4: TLabel;
    btnInserimento: TBitBtn;
    DBGrid1: TDBGrid;
    PopupMenu2: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    Label6: TLabel;
    StatusBar: TStatusBar;
    btnCancellazione: TBitBtn;
    ProgressBar1: TProgressBar;
    PrinterSetupDialog1: TPrinterSetupDialog;
    ChkFestivi: TCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    pnlTestata: TPanel;
    btnStampante: TBitBtn;
    btnStampa: TBitBtn;
    sbtDataDa: TSpeedButton;
    lblDataDa: TLabel;
    lblDataA: TLabel;
    sbtDataA: TSpeedButton;
    edtDataDa: TMaskEdit;
    edtDataA: TMaskEdit;
    btnAnomalie: TBitBtn;
    frmToolbarFiglio: TfrmToolbarFiglio;
    rgpGestioneProfilo: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure sbtDataDaClick(Sender: TObject);
    procedure edtDataDaExit(Sender: TObject);
    procedure rgpGestioneProfiloClick(Sender: TObject);
    procedure EProfiloKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure btnStampanteClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure btnInserimentoClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
    procedure AbilitaComponenti;
  public
    { Public declarations }
  end;

var
  A097FPianifLibProf: TA097FPianifLibProf;

procedure OpenA097PianifLibProf(Prog:LongInt; Data:TDateTime);

implementation

uses A097UPianifLibProfDtM1, A097UStampaLibProf;

{$R *.DFM}

procedure OpenA097PianifLibProf(Prog:LongInt; Data:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA097PianifLibProf') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A097FPianifLibProf:=TA097FPianifLibProf.Create(nil);
  C700Progressivo:=Prog;
  A097FPianifLibProfDtM1:=TA097FPianifLibProfDtM1.Create(nil);
  with A097FPianifLibProf do
    try
      A097FPianifLibProfDtM1.A097MW.Dal:=R180InizioMese(Data);
      A097FPianifLibProfDtM1.A097MW.Al:=R180FineMese(Data);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
      A097FPianifLibProfDtM1.Free;
    end;
end;

procedure TA097FPianifLibProf.FormCreate(Sender: TObject);
begin
  A097FStampaLibProf:=TA097FStampaLibProf.Create(nil);
end;

procedure TA097FPianifLibProf.FormShow(Sender: TObject);
begin
  frmToolbarFiglio.TFDButton:=A097FPianifLibProfDtM1.D320;
  frmToolbarFiglio.TFDBGrid:=DBGrid1;
  A097FPianifLibProfDtM1.Q320.ReadOnly:=SolaLettura;
  //Per gestire i pulsanti quando CachedUpdate:=False; (si considera lo state della singola riga invece che tutta l'operazione di inserimento/modifica)
  //A097FPianifLibProfDtM1.D320.OnStateChange:=frmToolbarFiglio.DButtonStateChange;
  SetLength(frmToolbarFiglio.lstLock,3);
  frmToolbarFiglio.lstLock[0]:=pnlTestata;
  frmToolbarFiglio.lstLock[1]:=pnlGestioneProfilo;
  frmToolbarFiglio.lstLock[2]:=frmSelAnagrafe;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  with A097FPianifLibProfDtM1.A097MW do
  begin
    if Dal = 0 then
      Dal:=R180InizioMese(Parametri.DataLavoro);
    if Al = 0 then
      Al:=R180FineMese(Parametri.DataLavoro);
    edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',Dal);
    edtDataA.Text:=FormatDateTime('dd/mm/yyyy',Al);
    EProfilo.KeyValue:=Q310.FieldByName('Codice').AsString;
  end;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A097FPianifLibProfDtM1.A097MW,SessioneOracle,StatusBar,0,True);
  btnAnomalie.Enabled:=False;
  AbilitaComponenti;
end;

procedure TA097FPianifLibProf.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA097FPianifLibProf.CambiaProgressivo;
begin
  if A097FPianifLibProfDtM1.A097MW.SelAnagrafe = nil then
    exit;
  if C700OldProgressivo <> C700Progressivo then
    A097FPianifLibProfDtM1.A097MW.RefreshSelT320;
  AbilitaComponenti;
end;

procedure TA097FPianifLibProf.AbilitaComponenti;
begin
  pnlGestioneProfilo.Visible:=rgpGestioneProfilo.ItemIndex = 1;
  frmToolBarFiglio.Enabled:=(rgpGestioneProfilo.ItemIndex = 0) and (C700SelAnagrafe.RecordCount > 0);
  DBGrid1.Enabled:=(rgpGestioneProfilo.ItemIndex = 0) and (C700SelAnagrafe.RecordCount > 0);
  btnInserimento.Enabled:=C700SelAnagrafe.RecordCount > 0;
  btnCancellazione.Enabled:=C700SelAnagrafe.RecordCount > 0;
end;

procedure TA097FPianifLibProf.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  try
    C005DataVisualizzazione:=A097FPianifLibProfDtM1.A097MW.Al;
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA097FPianifLibProf.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    C700DataLavoro:=A097FPianifLibProfDtM1.A097MW.Al;
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA097FPianifLibProf.sbtDataDaClick(Sender: TObject);
begin
  with A097FPianifLibProfDtM1.A097MW do
  begin
    if Sender = sbtDataDa then
      Dal:=DataOut(Dal,'Inizio periodo','G')
    else
    begin
      Al:=DataOut(Al,'Fine periodo','G');
      with C700SelAnagrafe do
        if GetVariable('DataLavoro') <> Al then
        begin
          Close;
          SetVariable('DataLavoro',Al);
          Open;
          frmSelAnagrafe.NumRecords;
          frmSelAnagrafe.VisualizzaDipendente;
        end;
    end;
    edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',Dal);
    edtDataA.Text:=FormatDateTime('dd/mm/yyyy',Al);
    RefreshSelT320;
  end;
end;

procedure TA097FPianifLibProf.edtDataDaExit(Sender: TObject);
begin
  with A097FPianifLibProfDtM1.A097MW do
  begin
    if Sender = edtDataDa then
      Dal:=StrToDate(edtDataDa.Text)
    else
    begin
      Al:=StrToDate(edtDataA.Text);
      with C700SelAnagrafe do
        if GetVariable('DataLavoro') <> Al then
        begin
          Close;
          SetVariable('DataLavoro',Al);
          Open;
          frmSelAnagrafe.NumRecords;
          frmSelAnagrafe.VisualizzaDipendente;
        end;
    end;
    RefreshSelT320;
  end;
end;

procedure TA097FPianifLibProf.rgpGestioneProfiloClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TA097FPianifLibProf.EProfiloKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (not EProfilo.ListVisible) then
    Label6.Caption:='';
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      //if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA097FPianifLibProf.Nuovoelemento1Click(Sender: TObject);
{Richiamo gestione turnazioni}
begin
  OpenA096ProfiliLibProf(EProfilo.Text);
  with A097FPianifLibProfDtM1.A097MW.Q310 do
  begin
    DisableControls;
    Refresh;
    EnableControls;
  end;
end;

procedure TA097FPianifLibProf.btnStampanteClick(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A097FStampaLibProf.QRep);
end;

procedure TA097FPianifLibProf.btnStampaClick(Sender: TObject);
var OldProg: Integer;
begin
  OldProg:=C700Progressivo;
  C700SelAnagrafe.First;
  with A097FStampaLibProf do
  begin
    LEnte.Caption:=Parametri.DAzienda;
    LTitolo.Caption:='Turni di libera professione pianificati';
    QRep.DataSet:=C700SelAnagrafe;
    QrDBText1.DataSet:=C700SelAnagrafe;
    LTitolo.Caption:=LTitolo.Caption + ' dal ' + edtDataDa.Text + ' al ' + edtDataA.Text;
    A097FPianifLibProfDtM1.Q320.SetVariable('Data1',A097FPianifLibProfDtM1.A097MW.Dal);
    A097FPianifLibProfDtM1.Q320.SetVariable('Data2',A097FPianifLibProfDtM1.A097MW.Al);
    QRep.Preview;
  end;
  C700SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
  frmSelAnagrafe.VisualizzaDipendente;
  C700OldProgressivo:=-1;
  CambiaProgressivo;
end;

procedure TA097FPianifLibProf.btnInserimentoClick(Sender: TObject);
{Inserisco la turnazione specificata cancellando eventualmente una già esistente
 nello stesso periodo}
var OldProg: Integer;
begin
  with A097FPianifLibProfDtM1.A097MW do
  begin
    if Dal > Al then
      raise Exception.Create(A000MSG_ERR_DATE_INVERTITE);
    if (Al - Dal) > (R180AddMesi(Dal,(12 * 5)) - Dal) then
      raise Exception.Create(A000MSG_A097_ERR_PERIODO_LUNGO);
  end;
  if EProfilo.Text = '' then
    raise Exception.create(A000MSG_A097_ERR_PROFILO_NON_VALIDO);
  if R180MessageBox(Format(A000MSG_A097_DLG_FMT_CONFERMA,[IfThen(Sender = btnInserimento,'l''inserimento','la cancellazione'),edtDataDa.Text,edtDataA.Text]),DOMANDA) <> mrYes then
    exit;
  with A097FPianifLibProfDtM1.A097MW.Q311 do
  begin
    Close;
    SetVariable('Codice',EProfilo.Text);
    Open;
  end;
  btnAnomalie.Enabled:=False;
  A097FPianifLibProfDtM1.A097MW.PianifFestivi:=ChkFestivi.Checked;
  RegistraMsg.IniziaMessaggio('A097');
  OldProg:=C700Progressivo;
  C700SelAnagrafe.First;
  ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
  ProgressBar1.Position:=0;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    while not C700SelAnagrafe.Eof do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.StepBy(1);
      A097FPianifLibProfDtM1.A097MW.GestionePianificazione(C700Progressivo,Sender = btnInserimento);
      C700SelAnagrafe.Next;
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    ProgressBar1.Position:=0;
    C700SelAnagrafe.First;
    C700SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
    frmSelAnagrafe.VisualizzaDipendente;
    C700OldProgressivo:=-1;
    CambiaProgressivo;
  end;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if btnAnomalie.Enabled then
  begin
    if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,'DOMANDA') = mrYes) then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,'INFORMA');
end;

procedure TA097FPianifLibProf.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A097','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A097FPianifLibProfDtM1.A097MW);
end;

procedure TA097FPianifLibProf.DBGrid1EditButtonClick(Sender: TObject);
var  vCodice:Variant;
begin
  if (A097FPianifLibProfDtM1.Q320.ReadOnly) or (A097FPianifLibProfDtM1.Q320.State in [dsBrowse]) then
    exit;
  vCodice:=VarArrayOf([A097FPianifLibProfDtM1.Q320.FieldByName('CAUSALE').asString]);
  OpenC015FElencoValori('','<A097> Selezione della causale',A097FPianifLibProfDtM1.A097MW.Q275.Sql.Text,'CODICE',vCodice,A097FPianifLibProfDtM1.A097MW.Q275,350);
  if not VarIsClear(vCodice) then
    A097FPianifLibProfDtM1.Q320.FieldByName('CAUSALE').asString:=VarToStr(vCodice[0]);
end;

end.
