unit A116ULiquidazioneOreAnniPrec;

interface

uses Dialogs, Forms, SelAnagrafe, Controls, StdCtrls, CheckLst, Mask, Spin,
  Buttons, ExtCtrls, ComCtrls, Classes, SysUtils, StrUtils, Variants,
  A000UInterfaccia, A000UMessaggi, A000USessione, A003UDataLavoroBis,
  C001StampaLib, C004UParamForm, C005UDatiAnagrafici, C180FunzioniGenerali,
  C700USelezioneAnagrafe, A083UMsgElaborazioni, A116ULiquidazioneOreAnniPrecMW;

type
  TA116FLiquidazioneOreAnniPrec = class(TForm)
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    pnlPrincipale: TPanel;
    BtnPrinterSetUp: TBitBtn;
    BtnStampa: TBitBtn;
    BtnClose: TBitBtn;
    chkSaltoPag: TCheckBox;
    BtnPreView: TBitBtn;
    chkTotaliRaggr: TCheckBox;
    chkTotaliGen: TCheckBox;
    btnEffettuaLiq: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    clbIntestazione: TCheckListBox;
    clbDettaglio: TCheckListBox;
    Label1: TLabel;
    edtAnno: TSpinEdit;
    gpbParametriLiquidazione: TGroupBox;
    lblArrotondamento: TLabel;
    edtArrotLiq: TMaskEdit;
    lblLimiteOreLiquidabili: TLabel;
    edtMaxLiq: TMaskEdit;
    frmSelAnagrafe: TfrmSelAnagrafe;
    lblMeseLiquidazione: TLabel;
    edtData: TMaskEdit;
    sbtDataLiquidazione: TSpeedButton;
    chkAbbattimentoOre: TCheckBox;
    chkCessati: TCheckBox;
    btnCancella: TBitBtn;
    btnAnomalie: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure sbtDataLiquidazioneClick(Sender: TObject);
    procedure edtMaxLiqExit(Sender: TObject);
    procedure clbIntestazioneMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure clbIntestazioneMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure clbDettaglioMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure clbDettaglioMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
  private
    { Private declarations }
    ItemCB:Integer;
    FormWidth:Integer;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ScorriQueryAnagrafica;
  public
    { Public declarations }
    A116MW: TA116FLiquidazioneOreAnniPrecMW;
    Gruppo1 : String;
    CampoRagg : String;
    SoloAgg:String;//Usato per richiamo da WA043 tramite B028
  end;

var
  A116FLiquidazioneOreAnniPrec: TA116FLiquidazioneOreAnniPrec;

procedure OpenA116LiquidazioneOreAnniPrec(Prog:LongInt);

implementation

uses A116UStampa;

{$R *.DFM}

procedure OpenA116LiquidazioneOreAnniPrec(Prog:LongInt);
{Liquidazione/Compensazione ore causalizzate escluse dalle normali}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA116LiquidazioneOreAnniPrec') of
    'N','R':begin
              ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
              Exit;
            end;
  end;
  A116FLiquidazioneOreAnniPrec:=TA116FLiquidazioneOreAnniPrec.Create(nil);
  with A116FLiquidazioneOreAnniPrec do
    try
      C700Progressivo:=Prog;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
    end;
end;

procedure TA116FLiquidazioneOreAnniPrec.FormCreate(Sender: TObject);
begin
  A116MW:=TA116FLiquidazioneOreAnniPrecMW.Create(Self);
  ItemCB:=-1;
  FormWidth:=Width;
  btnAnomalie.Enabled:=False;
end;

procedure TA116FLiquidazioneOreAnniPrec.FormShow(Sender: TObject);
begin
  A116MW.CodForm:=IfThen(A116MW.TipoModulo = 'CS','A116','WA116');
  A116FStampa:=TA116FStampa.Create(nil);
  CreaC004(SessioneOracle,A116MW.CodForm,Parametri.ProgOper);
  with A116MW.selI010 do
    while not Eof do
    begin
      if (Copy(FieldByname('NOME_CAMPO').AsString,1,6) <> 'T430D_') and
         (FieldByname('NOME_CAMPO').AsString <> 'COGNOME') and
         (FieldByname('NOME_CAMPO').AsString <> 'NOME') and
         (FieldByname('NOME_CAMPO').AsString <> 'MATRICOLA') then
        clbIntestazione.Items.Add(FieldByname('NOME_LOGICO').AsString);
      clbDettaglio.Items.Add(FieldByname('NOME_LOGICO').AsString);
      Next;
    end;
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  edtAnno.Text:=IntToStr(R180Anno(Parametri.DataLavoro) - 1);
  edtData.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro);
  frmSelAnagrafe.CreaSelAnagrafe(A116MW,SessioneOracle,StatusBar,0,False);
end;

procedure TA116FLiquidazioneOreAnniPrec.FormResize(Sender: TObject);
begin
  if Width <> FormWidth then
    Width:=FormWidth;
end;

procedure TA116FLiquidazioneOreAnniPrec.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA116FLiquidazioneOreAnniPrec.FormDestroy(Sender: TObject);
begin
  A116FStampa.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
  A116MW.Free;
end;

procedure TA116FLiquidazioneOreAnniPrec.GetParametriFunzione;
{Leggo i parametri della form}
var i,P:Integer;
    L:TStringList;
    S,S1:String;
begin
  edtMaxLiq.Text:=C004FParamForm.GetParametro('MAXLIQ','00.00');
  edtArrotLiq.Text:=C004FParamForm.GetParametro('ARROTLIQ','0');
  chkAbbattimentoOre.Checked:=C004FParamForm.GetParametro('ABBATTIMENTOORE','N') = 'S';
  chkSaltoPag.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  chkTotaliRaggr.Checked:=C004FParamForm.GetParametro('TOTALIPARZIALI','N') = 'S';
  chkTotaliGen.Checked:=C004FParamForm.GetParametro('TOTALIGENERALI','N') = 'S';
  chkCessati.Checked:=C004FParamForm.GetParametro('CESSATI','N') = 'S';
  L:=TStringList.Create;
  S1:='';
  S:=C004FParamForm.GetParametro('INTESTAZIONE','');
  for i:=1 to Length(S) do
    if S[i] = ',' then
    begin
      L.Add(S1);
      S1:='';
    end
    else
      S1:=S1 + S[i];
  if Trim(S1) <> '' then
    L.Add(S1);
  for i:=L.Count - 1 downto 0 do
  begin
    P:=clbIntestazione.Items.IndexOf(L[i]);
    if P >= 0 then
      clbIntestazione.Items.Delete(P);
    clbIntestazione.Items.Insert(0,L[i]);
    clbIntestazione.Checked[0]:=True;
  end;
  L.Clear;
  S1:='';
  S:=C004FParamForm.GetParametro('DETTAGLIO','');
  for i:=1 to Length(S) do
    if S[i] = ',' then
    begin
      L.Add(S1);
      S1:='';
    end
    else
      S1:=S1 + S[i];
  if Trim(S1) <> '' then
    L.Add(S1);
  for i:=L.Count - 1 downto 0 do
  begin
    P:=clbDettaglio.Items.IndexOf(L[i]);
    if P >= 0 then
      clbDettaglio.Items.Delete(P);
    clbDettaglio.Items.Insert(0,L[i]);
    clbDettaglio.Checked[0]:=True;
  end;
end;

procedure TA116FLiquidazioneOreAnniPrec.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('MAXLIQ',edtMaxLiq.Text);
  C004FParamForm.PutParametro('ARROTLIQ',edtArrotLiq.Text);
  C004FParamForm.PutParametro('ABBATTIMENTOORE',IfThen(chkAbbattimentoOre.Checked,'S','N'));
  C004FParamForm.PutParametro('SALTOPAGINA',IfThen(chkSaltoPag.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTALIPARZIALI',IfThen(chkTotaliRaggr.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTALIGENERALI',IfThen(chkTotaliGen.Checked,'S','N'));
  C004FParamForm.PutParametro('CESSATI',IfThen(chkCessati.Checked,'S','N'));
  C004FParamForm.PutParametro('INTESTAZIONE',R180GetCheckList(99,clbIntestazione));
  C004FParamForm.PutParametro('DETTAGLIO',R180GetCheckList(99,clbDettaglio));
  try SessioneOracle.Commit; except end;
end;

procedure TA116FLiquidazioneOreAnniPrec.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=R180FineMese(StrToDate('01/'+edtData.Text));
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA116FLiquidazioneOreAnniPrec.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=EncodeDate(StrToInt(edtAnno.Text),12,31);
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA116FLiquidazioneOreAnniPrec.sbtDataLiquidazioneClick(Sender: TObject);
begin
  edtData.Text:=FormatDateTime('mm/yyyy',DataOut(StrToDate('01/'+edtData.Text),'Mese liquidazione','M'));
end;

procedure TA116FLiquidazioneOreAnniPrec.edtMaxLiqExit(Sender: TObject);
begin
  try
    OreMinutiValidate(TMaskEdit(Sender).Text);
  except
    TWinControl(Sender).SetFocus;
    raise;
  end;
end;

procedure TA116FLiquidazioneOreAnniPrec.clbIntestazioneMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemCB:=clbIntestazione.ItemIndex;
end;

procedure TA116FLiquidazioneOreAnniPrec.clbIntestazioneMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C1,C2:Boolean;
begin
  if (ItemCB <> -1) and (ItemCB <> clbIntestazione.ItemIndex) then
  begin
    C1:=clbIntestazione.Checked[ItemCB];
    C2:=clbIntestazione.Checked[clbIntestazione.ItemIndex];
    clbIntestazione.Items.Exchange(ItemCB,clbIntestazione.ItemIndex);
    clbIntestazione.Checked[ItemCB]:=C2;
    clbIntestazione.Checked[clbIntestazione.ItemIndex]:=C1;
  end;
  ItemCB:= - 1;
end;

procedure TA116FLiquidazioneOreAnniPrec.clbDettaglioMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemCB:=clbDettaglio.ItemIndex;
end;

procedure TA116FLiquidazioneOreAnniPrec.clbDettaglioMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C1,C2:Boolean;
begin
  if (ItemCB <> -1) and (ItemCB <> clbDettaglio.ItemIndex) then
  begin
    C1:=clbDettaglio.Checked[ItemCB];
    C2:=clbDettaglio.Checked[clbDettaglio.ItemIndex];
    clbDettaglio.Items.Exchange(ItemCB,clbDettaglio.ItemIndex);
    clbDettaglio.Checked[ItemCB]:=C2;
    clbDettaglio.Checked[clbDettaglio.ItemIndex]:=C1;
  end;
  ItemCB:= - 1;
end;

procedure TA116FLiquidazioneOreAnniPrec.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A116FStampa.RepR);
end;

procedure TA116FLiquidazioneOreAnniPrec.BtnStampaClick(Sender: TObject);
var C,D_C,S:String;
    L,i:Integer;
begin
  with A116MW do
  begin
    AnnoRif:=StrToInt(edtAnno.Text);
    Data:=StrToDate('01/' + edtData.Text);
    if (AnnoRif <> R180Anno(Data) - 1) and (AnnoRif <> R180Anno(Data) - 2) then
      raise exception.Create(A000MSG_A116_ERR_ANNO_RIF_PREC);
    btnAnomalie.Enabled:=False;
    RegistraMsg.IniziaMessaggio(CodForm);
    selDatiBloccati.Close;
    INomeCampo.Clear;
    INomeLogico.Clear;
    DNomeCampo.Clear;
    DNomeLogico.Clear;
    S:=C700SelAnagrafe.SQL.Text;
    for i:=0 to clbIntestazione.Items.Count - 1 do
      if clbIntestazione.Checked[i] then
      begin
        C:=clbIntestazione.Items[i];
        D_C:=VarToStr(selI010.Lookup('NOME_LOGICO',C,'NOME_CAMPO'));
        INomeCampo.Add(D_C);
        INomeLogico.Add(C);
        if R180InserisciColonna(S,D_C) then
          C700SelAnagrafe.CloseAll;
        Insert('D_',D_C,5);
        if selI010.Locate('NOME_CAMPO',D_C,[]) then
          if R180InserisciColonna(S,D_C) then
            C700SelAnagrafe.CloseAll;
      end;
    for i:=0 to clbDettaglio.Items.Count - 1 do
      if clbDettaglio.Checked[i] then
      begin
        C:=clbDettaglio.Items[i];
        D_C:=VarToStr(selI010.Lookup('NOME_LOGICO',C,'NOME_CAMPO'));
        DNomeCampo.Add(D_C);
        DNomeLogico.Add(C);
        if R180InserisciColonna(S,D_C) then
          C700SelAnagrafe.CloseAll;
      end;
    C700SelAnagrafe.SQL.Text:=S;
  end;
  with C700SelAnagrafe do
  begin
    R180SetVariable(C700SelAnagrafe,'DataLavoro',R180FineMese(A116MW.Data));
    Open;
    StatusBar.SimpleText:=IntToStr(RecordCount) + ' Records';
  end;

  A116MW.CreaTabellaStampa;
  ScorriQueryAnagrafica;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);

  //Non è richiesta la stampa
  if Sender = btnEffettuaLiq then
  begin
    if A116MW.TipoModulo = 'CS' then
    begin
      if btnAnomalie.Enabled then
      begin
        if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
          btnAnomalieClick(nil);
      end
      else
        R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
    end;
  end
  else
  begin
    A116FStampa.QRGroup1.Expression:='';
    A116FStampa.QRGroup1.Enabled:=False;
    for i:=0 to A116MW.INomeCampo.Count - 1 do
    begin
      if A116FStampa.QRGroup1.Expression <> '' then
        A116FStampa.QRGroup1.Expression:=A116FStampa.QRGroup1.Expression + '+';
      A116FStampa.QRGroup1.Expression:=A116FStampa.QRGroup1.Expression + A116MW.INomeCampo[i];
      A116FStampa.QRGroup1.Enabled:=True;
    end;
    A116FStampa.QRFoot1.Enabled:=(chkTotaliRaggr.Checked) and (A116FStampa.QRGroup1.Enabled);
    A116FStampa.ChildBand1.Enabled:=(A116FStampa.QRGroup1.Enabled) and (chkSaltoPag.Checked);
    A116FStampa.QRBIntestazione.Enabled:=not A116FStampa.ChildBand1.Enabled;
    // abilita gli eventuali totali generali
    A116FStampa.QRBand2.Enabled:=chkTotaliGen.Checked;
    // abilita il salto pagina
    A116FStampa.QRGroup1.ForceNewPage:=chkSaltoPag.Checked;
    //Definizione della label di intestazione NomiDettaglio
    A116FStampa.NomiDettaglio.Caption:='';
    for i:=0 to A116MW.DNomeCampo.Count - 1 do
    begin
      if i > 0 then
        A116FStampa.NomiDettaglio.Caption:=A116FStampa.NomiDettaglio.Caption + ' ';
      if Length(A116MW.DNomeLogico[i]) > C700SelAnagrafe.FieldByName(A116MW.DNomeCampo[i]).Size then
        L:=Length(A116MW.DNomeLogico[i])
      else
        L:=C700SelAnagrafe.FieldByName(A116MW.DNomeCampo[i]).Size;
      S:=Format('%-*s',[L,A116MW.DNomeLogico[i]]);
      S:=Copy(S,1,L);
      A116FStampa.NomiDettaglio.Caption:=A116FStampa.NomiDettaglio.Caption + S;
    end;
    // crea la stampa
    A116FStampa.CreaReport(Sender=BtnPreView);
    A116MW.TabellaStampa.Close;
  end;
end;

procedure TA116FLiquidazioneOreAnniPrec.ScorriQueryAnagrafica;
var MesAnomalia:String;
begin
  ProgressBar.Position:=0;
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  C700SelAnagrafe.First;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    while not C700SelAnagrafe.EOF do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.StepBy(1);
      //Calcolo ore liquidabili ed inserisco in tabella i dipendenti elaborati
      if A116MW.CalcolaOreLiquidabili(chkCessati.Checked,MesAnomalia) then
        A116MW.InserisciRecord(MesAnomalia,
                               R180OreMinutiExt(edtMaxLiq.Text),
                               StrToIntDef(Trim(edtArrotLiq.Text),0),
                               chkAbbattimentoOre.Checked);
      C700SelAnagrafe.Next;
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar.Position:=0;
  end;
end;

procedure TA116FLiquidazioneOreAnniPrec.btnCancellaClick(Sender: TObject);
//Esegue la cancellazione delle liquidazioni/abbattimenti relativi ai periodi indicati
begin
  A116MW.AnnoRif:=StrToInt(edtAnno.Text);
  A116MW.Data:=StrToDate('01/' + edtData.Text);
  if R180MessageBox(Format(A000MSG_A116_DLG_FMT_CANCELLA,[edtAnno.Text,edtData.Text]),DOMANDA) = mrNo then
    exit;
  btnAnomalie.Enabled:=False;
  RegistraMsg.IniziaMessaggio(A116MW.CodForm);
  A116MW.selDatiBloccati.Close;
  with C700SelAnagrafe do
  begin
    R180SetVariable(C700SelAnagrafe,'DataLavoro',R180FineMese(A116MW.Data));
    Open;
    StatusBar.SimpleText:=IntToStr(RecordCount) + ' Records';
  end;
  ProgressBar.Position:=0;
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  C700SelAnagrafe.First;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    while not C700SelAnagrafe.EOF do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.StepBy(1);
      A116MW.CancellaLiquidazione(C700Progressivo);
      C700SelAnagrafe.Next;
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
  end;
  ProgressBar.Position:=0;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if btnAnomalie.Enabled then
  begin
    if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
end;

procedure TA116FLiquidazioneOreAnniPrec.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,A116MW.CodForm,'');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A116MW);
end;

end.
