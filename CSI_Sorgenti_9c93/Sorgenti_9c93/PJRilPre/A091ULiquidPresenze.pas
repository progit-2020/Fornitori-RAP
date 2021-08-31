unit A091ULiquidPresenze;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin ,C001StampaLib, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia,Grids, DBGrids, ExtCtrls,DB,ComCtrls,
  C004UParamForm, C700USelezioneAnagrafe, QueryStorico, R450, checklst,
  Mask, RegistrazioneLog, Menus, SelAnagrafe, C005UDatiAnagrafici,
  Variants, Math, StrUtils,
  C013UCheckList, A083UMsgElaborazioni, A000UMessaggi;

type
  TA091FLiquidPresenze = class(TForm)
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    Panel1: TPanel;
    BtnPrinterSetUp: TBitBtn;
    BtnStampa: TBitBtn;
    BtnClose: TBitBtn;
    chkSaltoPagina: TCheckBox;
    BtnPreView: TBitBtn;
    chkTotaliRaggr: TCheckBox;
    chkTotaliGenerali: TCheckBox;
    chkAggiornamento: TCheckBox;
    BitBtn1: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Intestazione: TCheckListBox;
    Dettaglio: TCheckListBox;
    Label1: TLabel;
    SEAnno: TSpinEdit;
    Label2: TLabel;
    SEMese: TSpinEdit;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    edtArrotLiq: TMaskEdit;
    Label4: TLabel;
    edtMaxLiq: TMaskEdit;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    edtArrotComp: TMaskEdit;
    edtMaxComp: TMaskEdit;
    lblCausale: TLabel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    btnAnomalie: TBitBtn;
    btnAnnullaLiquidazione: TBitBtn;
    rgpDisponibilita: TRadioGroup;
    btnCausale: TBitBtn;
    edtCausale: TEdit;
    procedure btnCausaleClick(Sender: TObject);
    procedure dcmbCausaleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkAggiornamentoClick(Sender: TObject);
    procedure IntestazioneMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IntestazioneMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DettaglioMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DettaglioMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtMaxLiqExit(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnAnnullaLiquidazioneClick(Sender: TObject);
  private
    ItemCB:Integer;
    FormWidth:Integer;
    slCodCausali:TStringList;
    procedure ScorriQueryAnagrafica;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    Gruppo1: String;
    CampoRagg: String;
    SolaLettura: Boolean;
  end;

var
  A091FLiquidPresenze: TA091FLiquidPresenze;

procedure OpenA091LiquidPresenze(Prog:LongInt);

implementation

uses A029UBudgetDtM1, A029ULiquidazione, A091UStampa, A091UAnnullaLiquidazione, A091ULiquidPresenzeDtM1;

{$R *.DFM}

procedure OpenA091LiquidPresenze(Prog:LongInt);
{Liquidazione/Compensazione ore causalizzate escluse dalle normali}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA091LiquidPresenze') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A091FLiquidPresenze:=TA091FLiquidPresenze.Create(nil);
  A091FLiquidPresenze.SolaLettura:=SolaLettura;
  with A091FLiquidPresenze do
    try
      C700Progressivo:=Prog;
      A091FLiquidPresenzeDtM1:=TA091FLiquidPresenzeDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A091FLiquidPresenzeDtM1.Free;
      Free;
    end;
end;

procedure TA091FLiquidPresenze.FormCreate(Sender: TObject);
begin
  //caratto 07/05/2013 rimozione variabili globali. A029FBudgetDtM1:=TA029FBudgetDtM1.Create(nil);
  A091FStampa:=TA091FStampa.Create(nil);
  SolaLettura:=False;
  ItemCB:=-1;
  FormWidth:=Width;
  Constraints.MinWidth:=Width;
  Constraints.MaxWidth:=Width;
  btnAnomalie.Enabled:=False;
end;

procedure TA091FLiquidPresenze.FormShow(Sender: TObject);
var
  i: Integer;
begin
  CreaC004(SessioneOracle,'A091',Parametri.ProgOper);
  GetParametriFunzione;
  SEAnno.Value:=StrToInt(FormatDateTime('yyyy',Parametri.DataLavoro));
  SEMese.Value:=StrToInt(FormatDateTime('mm',Parametri.DataLavoro));
  chkAggiornamento.Enabled:=not SolaLettura;
  BitBtn1.Enabled:=chkAggiornamento.Checked;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW,SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;

  with A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW do
    for i:=0 to LstCampiAnagrafe.Count - 1 do
    begin
      Intestazione.Items.Add(LstCampiAnagrafe[i]);
      Dettaglio.Items.Add(LstCampiAnagrafe[i]);
    end;

  A091FStampa.SettaDataset;

  // Carico la lista delle causali da elaborare
  slCodCausali:=TStringList.Create;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  begin
    try
      with A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.selT275 do
      begin
        First;
        clbListaDati.Items.Clear;
        while not Eof do
        begin
          clbListaDati.Items.Add(FieldByName('CODICE').AsString);
          Next;
        end;
      end;
      R180PutCheckList(edtCausale.Text,5,clbListaDati);
      edtCausale.Text:=R180GetCheckList(5,clbListaDati);
      slCodCausali.CommaText:=edtCausale.Text;
    finally
      Free;
    end;
  end;
end;

procedure TA091FLiquidPresenze.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A091FStampa.RepR);
end;

procedure TA091FLiquidPresenze.ScorriQueryAnagrafica;
begin
  //Alberto 24/02/2006: Inizializzo i conteggi
  A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.R450DtM1.ConteggiMese('Generico',SEAnno.Value,SEMese.Value,0);
  ProgressBar.Position:=0;
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  C700SelAnagrafe.First;
  //Massimo 23/07/2013: l'abbinamento è già fatto nel CreaSelAnagrafe
  //A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.SelAnagrafe:=C700SelAnagrafe;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    while not C700SelAnagrafe.Eof do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.StepBy(1);

      with A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW do
        ElaboraDipendente(slCodCausali, SEAnno.Value, SEMese.Value,
                          R180OreMinutiExt(edtMaxLiq.Text),StrToIntDef(Trim(edtArrotLiq.Text),0),
                          R180OreMinutiExt(edtMaxComp.Text),StrToIntDef(Trim(edtArrotComp.Text),0),
                          rgpDisponibilita.ItemIndex,
                          chkAggiornamento.Checked);

      C700SelAnagrafe.Next;
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar.Position:=0;
  end;
end;

procedure TA091FLiquidPresenze.BtnStampaClick(Sender: TObject);
var
  Data: TDateTime;
  i,L: Integer;
  LstIntestazione, LstDettaglio: TStringList;
  S: String;
begin
  btnAnomalie.Enabled:=False;
  A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.selDatiBloccati.Close;
  //selDatiBloccati.FileLog:='';
  RegistraMsg.IniziaMessaggio('A091');
  if edtCausale.Text = '' then
    raise Exception.Create(A000MSG_A091_ERR_NO_CAUSALE);
  Data:=EncodeDate(SEAnno.Value,SEMese.Value,1);
  Data:=EncodeDate(SEAnno.Value,SEMese.Value,R180GiorniMese(Data));
  LstIntestazione:=TStringList.Create;
  LstDettaglio:=TStringList.Create;
  try
    for i:=0 to Intestazione.Items.Count - 1 do
      if Intestazione.Checked[i] then
        LstIntestazione.Add(Intestazione.Items[i]);

    for i:=0 to Dettaglio.Items.Count - 1 do
      if Dettaglio.Checked[i] then
        LstDettaglio.Add(Dettaglio.Items[i]);

    S:=A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.SettaIntestazioneDettaglio(C700SelAnagrafe.SQL.Text, LstIntestazione, LstDettaglio);
    if S <> '' then
    begin
      C700SelAnagrafe.CloseAll;
      C700SelAnagrafe.SQL.Text:=S;
    end;

  finally
    FreeAndNil(LstIntestazione);
    FreeAndNil(LstDettaglio);
  end;

  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(R180InizioMese(Data),R180FineMese(Data)) then
  begin
    C700SelAnagrafe.Close;
  end;
  with C700SelAnagrafe do
  begin
    Open;
    StatusBar.SimpleText:=IntToStr(RecordCount) + ' Records';
  end;

  A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.CreaTabellaStampa;
(* caratto 07/05/2013 creato nel Dtm. rimossa variabile globale
  A029FLiquidazione:=TA029FLiquidazione.Create(nil);
  A029FLiquidazione.R450DtM:=A091FLiquidPresenzeDtM1.R450DtM1;
*)
  try
    Screen.Cursor:=crHourGlass;
    ScorriQueryAnagrafica;
    A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.PreparaAggiornaFruitoBudget(Data);
  finally
    // caratto 07/05/2013 distrutto nel Dtm. rimossa variabile globale
    // FreeAndNil(A029FLiquidazione);
    Screen.Cursor:=crDefault;
  end;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  //Non è richiesta la stampa
  if Sender = BitBtn1 then
  begin
    if btnAnomalie.Enabled then
    begin
      if (R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes) then
        btnAnomalieClick(nil);
    end
    else
      R180MessageBox('Elaborazione terminata',INFORMA);
  end
  else
  begin
    A091FStampa.QRGroup1.Expression:='';
    A091FStampa.QRGroup1.Enabled:=False;

    for i:=0 to A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.INomeCampo.Count - 1 do
    begin
      if A091FStampa.QRGroup1.Expression <> '' then
      begin
        A091FStampa.QRGroup1.Expression:=A091FStampa.QRGroup1.Expression + '+';
      end;
      A091FStampa.QRGroup1.Expression:=A091FStampa.QRGroup1.Expression + A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.INomeCampo[i];
      A091FStampa.QRGroup1.Enabled:=True;
    end;

    A091FStampa.QRFoot1.Enabled:=(chkTotaliRaggr.Checked) and (A091FStampa.QRGroup1.Enabled);
    A091FStampa.ChildBand1.Enabled:=(A091FStampa.QRGroup1.Enabled) and (chkSaltoPagina.Checked);
    A091FStampa.QRBIntestazione.Enabled:=not A091FStampa.ChildBand1.Enabled;
    // abilita gli eventuali totali generali
    A091FStampa.QRBand2.Enabled:=chkTotaliGenerali.Checked;
    // abilita il salto pagina
    A091FStampa.QRGroup1.ForceNewPage:=chkSaltoPagina.Checked;
    //Definizione della label di intestazione NomiDettaglio
    A091FStampa.NomiDettaglio.Caption:='';
    for i:=0 to A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DNomeCampo.Count - 1 do
    begin
      if i > 0 then
        A091FStampa.NomiDettaglio.Caption:=A091FStampa.NomiDettaglio.Caption + ' ';
      if Length(A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DNomeLogico[i]) > C700SelAnagrafe.FieldByName(A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DNomeCampo[i]).Size then
        L:=Length(A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DNomeLogico[i])
      else
        L:=C700SelAnagrafe.FieldByName(A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DNomeCampo[i]).Size;
      S:=Format('%-*s',[L,A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DNomeLogico[i]]);
      S:=Copy(S,1,L);
      A091FStampa.NomiDettaglio.Caption:=A091FStampa.NomiDettaglio.Caption + S;
    end;
    // crea la stampa
    A091FStampa.CreaReport(Sender=BtnPreView);
    A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.TabellaStampa.Close;
  end;
end;

procedure TA091FLiquidPresenze.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A091','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW);
end;

procedure TA091FLiquidPresenze.GetParametriFunzione;
{Leggo i parametri della form}
var i,P:Integer;
    L:TStringList;
    S,S1:String;
begin
  edtCausale.Text:=C004FParamForm.GetParametro('CAUSALE','');
  edtMaxLiq.Text:=C004FParamForm.GetParametro('MAXLIQ','00.00');
  edtArrotLiq.Text:=C004FParamForm.GetParametro('ARROTLIQ','0');
  edtMaxComp.Text:=C004FParamForm.GetParametro('MAXCOMP','00.00');
  edtArrotComp.Text:=C004FParamForm.GetParametro('ARROTCOMP','0');
  rgpDisponibilita.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('DISPONIBILITA','1'),1);
  chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  chkTotaliRaggr.Checked:=C004FParamForm.GetParametro('TOTALIPARZIALI','N') = 'S';
  chkTotaliGenerali.Checked:=C004FParamForm.GetParametro('TOTALIGENERALI','N') = 'S';
  L:=TStringList.Create;
  S1:='';
  S:=C004FParamForm.GetParametro('INTESTAZIONE','');
  for i:=1 to Length(S) do
  begin
    if S[i] = ',' then
    begin
      L.Add(S1);
      S1:='';
    end
    else
      S1:=S1 + S[i];
  end;
  if Trim(S1) <> '' then
    L.Add(S1);
  for i:=L.Count - 1 downto 0 do
  begin
    P:=Intestazione.Items.IndexOf(L[i]);
    if P >= 0 then
      Intestazione.Items.Delete(P);
    Intestazione.Items.Insert(0,L[i]);
    Intestazione.Checked[0]:=True;
  end;
  L.Clear;
  S1:='';
  S:=C004FParamForm.GetParametro('DETTAGLIO','');
  for i:=1 to Length(S) do
  begin
    if S[i] = ',' then
    begin
      L.Add(S1);
      S1:='';
    end
    else
      S1:=S1 + S[i];
  end;
  if Trim(S1) <> '' then
    L.Add(S1);
  for i:=L.Count - 1 downto 0 do
  begin
    P:=Dettaglio.Items.IndexOf(L[i]);
    if P >= 0 then
      Dettaglio.Items.Delete(P);
    Dettaglio.Items.Insert(0,L[i]);
    Dettaglio.Checked[0]:=True;
  end;
  FreeAndNil(L);
end;

procedure TA091FLiquidPresenze.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('CAUSALE',edtCausale.Text);
  C004FParamForm.PutParametro('MAXLIQ',edtMaxLiq.Text);
  C004FParamForm.PutParametro('ARROTLIQ',edtArrotLiq.Text);
  C004FParamForm.PutParametro('MAXCOMP',edtMaxComp.Text);
  C004FParamForm.PutParametro('ARROTCOMP',edtArrotComp.Text);
  C004FParamForm.PutParametro('DISPONIBILITA',IntToStr(rgpDisponibilita.ItemIndex));
  C004FParamForm.PutParametro('SALTOPAGINA',IfThen(chkSaltoPagina.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTALIPARZIALI',IfThen(chkTotaliRaggr.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTALIGENERALI',IfThen(chkTotaliGenerali.Checked,'S','N'));
  C004FParamForm.PutParametro('INTESTAZIONE',R180GetCheckList(99,Intestazione));
  C004FParamForm.PutParametro('DETTAGLIO',R180GetCheckList(99,Dettaglio));
  try SessioneOracle.Commit; except end;
end;

procedure TA091FLiquidPresenze.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA091FLiquidPresenze.chkAggiornamentoClick(Sender: TObject);
begin
  BitBtn1.Enabled:=chkAggiornamento.Checked;
end;

procedure TA091FLiquidPresenze.IntestazioneMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemCB:=Intestazione.ItemIndex;
end;

procedure TA091FLiquidPresenze.IntestazioneMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C1,C2:Boolean;
begin
  if (ItemCB <> -1) and (ItemCB <> Intestazione.ItemIndex) then
  begin
    C1:=Intestazione.Checked[ItemCB];
    C2:=Intestazione.Checked[Intestazione.ItemIndex];
    Intestazione.Items.Exchange(ItemCB,Intestazione.ItemIndex);
    Intestazione.Checked[ItemCB]:=C2;
    Intestazione.Checked[Intestazione.ItemIndex]:=C1;
  end;
  ItemCB:= - 1;
end;

procedure TA091FLiquidPresenze.DettaglioMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemCB:=Dettaglio.ItemIndex;
end;

procedure TA091FLiquidPresenze.DettaglioMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C1,C2:Boolean;
begin
  if (ItemCB <> -1) and (ItemCB <> Dettaglio.ItemIndex) then
  begin
    C1:=Dettaglio.Checked[ItemCB];
    C2:=Dettaglio.Checked[Dettaglio.ItemIndex];
    Dettaglio.Items.Exchange(ItemCB,Dettaglio.ItemIndex);
    Dettaglio.Checked[ItemCB]:=C2;
    Dettaglio.Checked[Dettaglio.ItemIndex]:=C1;
  end;
  ItemCB:= - 1;
end;

procedure TA091FLiquidPresenze.edtMaxLiqExit(Sender: TObject);
begin
  try
    OreMinutiValidate(TMaskEdit(Sender).Text);
  except
    TWinControl(Sender).SetFocus;
    raise;
  end;
end;

procedure TA091FLiquidPresenze.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=R180FineMese(EncodeDate(SEAnno.Value,SEMese.Value,1));
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA091FLiquidPresenze.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataDal:=R180InizioMese(EncodeDate(SEAnno.Value,SEMese.Value,1));
  C700DataLavoro:=R180FineMese(EncodeDate(SEAnno.Value,SEMese.Value,1));
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA091FLiquidPresenze.FormDestroy(Sender: TObject);
begin
(* Caratto 07/05/2013 Rimosso variabili globali
  FreeAndNil(A029FBudgetDtM1);
*)
  FreeAndNil(A091FStampa);
  FreeAndNil(slCodCausali);
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA091FLiquidPresenze.btnAnnullaLiquidazioneClick(Sender: TObject);
begin
  if slCodCausali.Count = 0 then
  begin
    R180MessageBox(A000MSG_A091_ERR_NO_CAUSALE,INFORMA);
    exit;
  end;
  (*
  else if slCodCausali.Count > 1 then
  begin
    R180MessageBox(A000MSG_A091_ERR_TROPPE_CAUSALI,INFORMA);
    exit;
  end;
  *)
  // annullamento liquidazione
  A091FAnnullaLiquidazione:=TA091FAnnullaLiquidazione.Create(nil);
  A091FAnnullaLiquidazione.DataLavoro:=EncodeDate(SEAnno.Value,SEMese.Value,R180GiorniMese(EncodeDate(SEAnno.Value,SEMese.Value,1)));
  A091FAnnullaLiquidazione.Causale:=Trim(slCodCausali.CommaText);
  //Caratto deve valutare i dipendenti nel periodo indicato
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(R180InizioMese(A091FAnnullaLiquidazione.DataLavoro),R180FineMese(A091FAnnullaLiquidazione.DataLavoro)) then
  begin
    C700SelAnagrafe.Close;
  end;
  C700SelAnagrafe.Open;

  try
    A091FAnnullaLiquidazione.ShowModal;
  finally
    FreeAndNil(A091FAnnullaLiquidazione);
  end;
end;

procedure TA091FLiquidPresenze.dcmbCausaleKeyDown(Sender: TObject;
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

procedure TA091FLiquidPresenze.btnCausaleClick(Sender: TObject);
begin
  inherited;
  // richiamo C013 per esplodere lista
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    C013FCheckList.Caption:='Elenco accorpamenti';
    with A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.selT275 do
    begin
      First;
      C013FCheckList.clbListaDati.Items.Clear;
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-5s',[FieldByName('CODICE').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
        Next;
      end;
    end;
    R180PutCheckList(edtCausale.Text,5,C013FCheckList.clbListaDati);
    if C013FCheckList.ShowModal = mrOK then
    begin
      edtCausale.Text:=R180GetCheckList(5,C013FCheckList.clbListaDati);
      slCodCausali.CommaText:=edtCausale.Text;
    end;
  finally
    FreeAndNil(C013FCheckList);
  end;
end;

end.
