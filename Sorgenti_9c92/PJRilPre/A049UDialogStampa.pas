unit A049UDialogStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls,C001StampaLib, C180FunzioniGenerali,A000UCostanti, A000USessione,
  A000UInterfaccia, ExtCtrls,DB,checklst, ComCtrls,
  RegistrazioneLog, C004UParamForm, Menus, SelAnagrafe, C700USelezioneAnagrafe,
  C005UDatiAnagrafici, {C012UVisualizzaTesto,} A003UDataLavoroBis, Variants,
  DatiBloccati,A083UMsgElaborazioni, InputPeriodo;

type
  TA049FDialogStampa = class(TForm)
    BtnPrinterSetUp: TBitBtn;
    BtnStampa: TBitBtn;
    BtnClose: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    CkBAggiorna: TCheckBox;
    Panel1: TPanel;
    Label1: TLabel;
    LBTerm: TCheckListBox;
    CkBSelectAll: TCheckBox;
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    dcmbRaggruppamento: TDBLookupComboBox;
    Label2: TLabel;
    chkSaltoPagina: TCheckBox;
    chkDettaglio: TCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    btnAnomalie: TBitBtn;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure dcmbRaggruppamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CkBSelectAllClick(Sender: TObject);
    procedure dcmbRaggruppamentoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dcmbRaggruppamentoCloseUp(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
  private
    { Private declarations }
    procedure ScorriQueryAnagrafica;
    procedure AbilitaSalvataggio;
    procedure CaricaListBoxTerminali;
    function GetFiltro:String;
    procedure GetParametriFunzione;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    { Public declarations }
    //selDatiBloccati:TDatiBloccati;
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A049FDialogStampa: TA049FDialogStampa;

procedure OpenA049StampaPasti(Prog:LongInt);

implementation

uses A049UStampa, A049UStampaPastiDtM1;

{$R *.DFM}

procedure OpenA049StampaPasti(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA049StampaPasti') of
    'N':
        begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A049FDialogStampa:=TA049FDialogStampa.Create(nil);
  with A049FDialogStampa do
    try
      C700Progressivo:=Prog;
      A049FStampaPastiDtM1:=TA049FStampaPastiDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A049FStampaPastiDtM1.Free;
      Free;
    end;
end;

procedure TA049FDialogStampa.FormCreate(Sender: TObject);
begin
  A049FStampa:=TA049FStampa.Create(nil);
  //selDatiBloccati:=TDatiBloccati.Create(Self);
  btnAnomalie.Enabled:=False;
end;

procedure TA049FDialogStampa.FormShow(Sender: TObject);
begin
  DataI:=R180InizioMese(Parametri.DataLavoro);
  DataF:=R180FineMese(Parametri.DataLavoro);
  AbilitaSalvataggio;
  CaricaListBoxTerminali;
  CreaC004(SessioneOracle,'A049',Parametri.ProgOper);
  GetParametriFunzione;
  chkSaltoPagina.Enabled:=dcmbRaggruppamento.KeyValue <> null;
  chkDettaglio.Enabled:=dcmbRaggruppamento.KeyValue <> null;
  C700DatiVisualizzati:='MATRICOLA,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A049FStampaPastiDtM1.A049FStampaPastiMW,SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
end;

procedure TA049FDialogStampa.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A049FStampa.RepR);
end;

procedure TA049FDialogStampa.ScorriQueryAnagrafica;
var
  Raggr:String;
begin
  with A049FStampaPastiDtM1.A049FStampaPastiMW do
  begin
    C700SelAnagrafe.First;
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Self.Enabled:=False;
    try
    while not C700SelAnagrafe.EOF do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.StepBy(1);
      R300FAccessiMensaDtM.ConteggiaPastiPeriodo(C700Progressivo,DataI,DataF,CkBAggiorna.Checked);
      //Salvataggio dati per stampa
      Raggr:='';
      if dcmbRaggruppamento.KeyValue <> null then
        Raggr:=dcmbRaggruppamento.KeyValue;
      InserisciDipendente(C700SelAnagrafe,Raggr);

      C700SelAnagrafe.Next;
    end;
    finally
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      Self.Enabled:=True;
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.Position:=0;
    end;
  end;
end;

function TA049FDialogStampa.GetFiltro:String;
var I:Integer;
begin
  Result:='';
  if CkBSelectAll.Checked then
    exit;
  for I:=0 to LBTerm.Items.Count - 1 do
    if LBTerm.Checked[I] then
    begin
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + Trim(Copy(LBTerm.Items[I],1,2));
    end;
end;

procedure TA049FDialogStampa.BtnStampaClick(Sender: TObject);
var i:Integer;
    S,C:String;
begin
  if CkBAggiorna.Checked and not((DataI = R180InizioMese(DataI)) and (DataF = R180FineMese(DataF))) then
  begin
    CkBAggiorna.SetFocus;
    raise Exception.Create('Attenzione!' + CRLF + 'Aggiornamento impedito sui mesi parziali.');
  end;

  btnAnomalie.Enabled:=False;
  A049FStampaPastiDtM1.A049FStampaPastiMW.R300FAccessiMensaDtM.selDatiBloccati.Close;
  //R300FAccessiMensaDtM.selDatiBloccati.FileLog:='';
  RegistraMsg.IniziaMessaggio('A049');
  if DataI > DataF then
  begin
    R180MessageBox('La data iniziale deve essere minore di quella finale',ESCLAMA);
    exit;
  end;
  Screen.Cursor:=crHourGlass;
  C001SettaQuickReport(A049FStampa.RepR);
  A049FStampaPastiDtM1.A049FStampaPastiMW.CreaTabellaStampa;
  with A049FStampaPastiDtM1.A049FStampaPastiMW do
  begin
    R300FAccessiMensaDtM.SettaPeriodo(DataI,DataF);
    R300FAccessiMensaDtM.FiltroRilevatori:=GetFiltro;
  end;
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI,DataF) then
    C700SelAnagrafe.CloseAll;
  if dcmbRaggruppamento.KeyValue <> null then
  begin
    C:=dcmbRaggruppamento.KeyValue;
    S:=C700SelAnagrafe.SQL.Text;
    if R180InserisciColonna(S,C) then
    begin
      C700SelAnagrafe.CloseAll;
      C700SelAnagrafe.SQL.Text:=S;
    end;
  end;
  C700SelAnagrafe.Open;
  ScorriQueryAnagrafica;
  A049FStampa.SettaDataset;
  A049FStampa.SalvaDatiPasti:=CkBAggiorna.Checked;
  A049FStampa.DataI:=DataI;
  A049FStampa.DataF:=DataF;
  A049FStampa.QRLAzienda.Caption:=Parametri.DAzienda;
  if A049FStampaPastiDtM1.A049FStampaPastiMW.R300FAccessiMensaDtM.FiltroRilevatori = '' then
    A049FStampa.QRLOrologi.Caption:='Tutti gli orologi:'
  else
    begin
    A049FStampa.QRLOrologi.Caption:='Orologi:';
    for i:=0 to LBTerm.Items.Count - 1 do
      if LBTerm.Checked[i] then
        A049FStampa.QRLOrologi.Caption:=A049FStampa.QRLOrologi.Caption + ' ' + Trim(Copy(LBTerm.Items[I],1,3));
    end;
  Screen.Cursor:=crDefault;
  with A049FStampa do
    begin
    QRGroup.Expression:='Raggruppamento';
    QRGroup.Enabled:=dcmbRaggruppamento.KeyValue <> Null;
    QRFoot.Enabled:=dcmbRaggruppamento.KeyValue <> Null;
    QRGroup.ForceNewPage:=chkSaltoPagina.Checked;
    if chkDettaglio.Checked then
      QRGroup.Height:=16
    else
      QRGroup.Height:=0;
    lblRaggruppamento2.Enabled:=not chkDettaglio.Checked;
    QRLabel1.Enabled:=chkDettaglio.Checked;
    QRLabel2.Enabled:=chkDettaglio.Checked;
    QRLabel3.Enabled:=chkDettaglio.Checked;
    QRLabel5.Enabled:=chkDettaglio.Checked;
    CreaReport;
    end;
  A049FStampaPastiDtM1.A049FStampaPastiMW.TabellaStampa.Close;
  //btnAnomalie.Enabled:=R300FAccessiMensaDtM.selDatibloccati.FileLog <> '';
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
end;

procedure TA049FDialogStampa.btnAnomalieClick(Sender: TObject);
begin
  //OpenC012VisualizzaTesto('<A049> Riepiloghi bloccati',R300FAccessiMensaDtM.selDatibloccati.FileLog,nil);
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A049','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A049FStampaPastiDtM1.A049FStampaPastiMW);
end;

procedure TA049FDialogStampa.CaricaListBoxTerminali;
begin
  with A049FStampaPastiDtM1.A049FStampaPastiMW do
    begin
    LBTerm.Items.Clear;
    LBTerm.Items.Add(Format('%2s %s',['**','<Orologio nullo>']));
    selT361.First;
    while not(selT361.EOF) do
      begin
      LBTerm.Items.Add(Format('%2s %s',[selT361.FieldByName('Codice').AsString,selT361.FieldByName('Descrizione').AsString]));
      selT361.Next;
      end;
    end;
end;

procedure TA049FDialogStampa.GetParametriFunzione;
{Leggo i parametri della form}
var S:TStringList;
  i:Integer;
begin
  dcmbRaggruppamento.KeyValue:=C004FParamForm.GetParametro('RAGGRUPPAMENTO','');
  if dcmbRaggruppamento.Text = '' then
    dcmbRaggruppamento.KeyValue:=null;
  chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  chkDettaglio.Checked:=C004FParamForm.GetParametro('DETTAGLIO','S') = 'S';
  ckbSelectAll.Checked:=C004FParamForm.GetParametro('SELECTALL','S') = 'S';
  S:=TStringList.Create;
  S.Clear;
  S.CommaText:=C004FParamForm.GetParametro('RILEVATORI','');
  for i:=0 to lbTerm.Count - 1 do
  begin
    if R180IndexOf(S,Trim(Copy(LBTerm.Items[I],1,2)),2) <> -1 then
      lbTerm.Checked[i]:=True;
  end;
  FreeAndNil(S);
end;

procedure TA049FDialogStampa.CkBSelectAllClick(Sender: TObject);
var I : Integer;
begin
  if CkBSelectAll.Checked then
    begin
    for I:=0 to LBTerm.Items.Count-1 do
      LBTerm.Checked[I]:=True;
    LBTerm.Enabled:=False;
    end
  else
    LBTerm.Enabled:=True;
end;

procedure TA049FDialogStampa.dcmbRaggruppamentoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  chkSaltoPagina.Enabled:=dcmbRaggruppamento.KeyValue <> null;
  chkDettaglio.Enabled:=dcmbRaggruppamento.KeyValue <> null;
end;

procedure TA049FDialogStampa.dcmbRaggruppamentoCloseUp(Sender: TObject);
begin
  chkSaltoPagina.Enabled:=dcmbRaggruppamento.KeyValue <> null;
  chkDettaglio.Enabled:=dcmbRaggruppamento.KeyValue <> null;
end;

procedure TA049FDialogStampa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('RAGGRUPPAMENTO',VarToStr(dcmbRaggruppamento.KeyValue));
  C004FParamForm.PutParametro('RILEVATORI',GetFiltro);
  if chkSaltoPagina.Checked then
    C004FParamForm.PutParametro('SALTOPAGINA','S')
  else
    C004FParamForm.PutParametro('SALTOPAGINA','N');
  if chkDettaglio.Checked then
    C004FParamForm.PutParametro('DETTAGLIO','S')
  else
    C004FParamForm.PutParametro('DETTAGLIO','N');
  if ckbSelectAll.Checked then
    C004FParamForm.PutParametro('SELECTALL','S')
  else
    C004FParamForm.PutParametro('SELECTALL','N');
  try SessioneOracle.Commit; except end;
end;

procedure TA049FDialogStampa.FormDestroy(Sender: TObject);
begin
  A049FStampa.Free;
  frmSelAnagrafe.DistruggiSelAnagrafe;
  //FreeAndNil(selDatiBloccati);
end;

procedure TA049FDialogStampa.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=DataF;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA049FDialogStampa.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataDal:=DataI;
  C700DataLavoro:=DataF;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA049FDialogStampa.dcmbRaggruppamentoKeyDown(Sender: TObject;
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

{ DataF }
function TA049FDialogStampa._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;

procedure TA049FDialogStampa._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ ----DataF }

{ DataI }
function TA049FDialogStampa._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;

procedure TA049FDialogStampa._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ ----DataI }

procedure TA049FDialogStampa.AbilitaSalvataggio;
begin
 CkBAggiorna.Enabled:= Not SolaLettura;
end;

end.
