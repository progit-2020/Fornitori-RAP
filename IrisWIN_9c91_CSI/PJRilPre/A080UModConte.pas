unit A080UModConte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  A000UCostanti, A000USessione,A000UInterfaccia, StdCtrls, Mask, DBCtrls, ActnList, ImgList, ToolWin,
  CheckLst, C013UCheckList, C180FunzioniGenerali, Variants, C600USelAnagrafe,
  System.Actions;

type
  TA080FModConte = class(TR001FGestTab)
    Panel3: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    DBRadioGroup2: TDBRadioGroup;
    DBEdit1: TDBEdit;
    DBComboBox1: TDBComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit5: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBRadioGroup3: TDBRadioGroup;
    TabSheet3: TTabSheet;
    DBRadioGroup4: TDBRadioGroup;
    GroupBox1: TGroupBox;
    lblMesiSaldoPrec: TLabel;
    lblAbbattimentoMobileMax: TLabel;
    lblSaldiAbbattibili: TLabel;
    dedtMesiSaldoPrec: TDBEdit;
    dedtAbbattimentoMobileMax: TDBEdit;
    clstSaldiAbbattibili: TCheckListBox;
    drgpPeriodicitaAbbattimento: TDBRadioGroup;
    dgrpLimitiEccComp: TDBRadioGroup;
    dedtLimitiEccComp: TDBEdit;
    GroupBox2: TGroupBox;
    Label10: TLabel;
    DBEdit2: TDBEdit;
    btnSaldiAbbattibili: TBitBtn;
    DBEdit6: TDBEdit;
    dedtCausaliCompensabili: TDBEdit;
    Label8: TLabel;
    btnCausaliCompensabili: TButton;
    Label13: TLabel;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    DBComboBox2: TDBComboBox;
    Label9: TLabel;
    DBComboBox3: TDBComboBox;
    dchkLiquidazioneDistribuita: TDBCheckBox;
    TabSheet4: TTabSheet;
    gpbLimitiMensiliEccedenzaLiquidabile: TGroupBox;
    drgpTipoApplicazioneLimiteLiq: TDBRadioGroup;
    drgpLimitiNonDefinitiLiquidabile: TDBRadioGroup;
    gpbLimitiMensiliEccedenzaResiduabile: TGroupBox;
    drgpTipoApplicazioneLimiteRes: TDBRadioGroup;
    drgpLimitiNonDefinitiResiduabile: TDBRadioGroup;
    dchkSuperoLiqAnnuo: TDBCheckBox;
    GroupBox5: TGroupBox;
    Label15: TLabel;
    dedtSaldoNegativoMinimo: TDBEdit;
    dedtSogliaCompLiq: TDBEdit;
    dcmbAbbattMobileRiferimento: TDBComboBox;
    lblAbbattMobileRiferimento: TLabel;
    gpbBancaOre: TGroupBox;
    dchkBancaOre: TDBCheckBox;
    dchkBancaOreResid: TDBCheckBox;
    dchkBancaOreLimitataSaldoComp: TDBCheckBox;
    dchkBancaOreLimitataStrLiqAnno: TDBCheckBox;
    Label16: TLabel;
    dedtArrSogliaCompLiq: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    dchkBancaOreEsclusaAbbatt: TDBCheckBox;
    dchkRecupStraordPrec: TDBCheckBox;
    GroupBox4: TGroupBox;
    Label17: TLabel;
    dcmbRiposoNonFruito: TDBLookupComboBox;
    DBRadioGroup5: TDBRadioGroup;
    dchkTipoLimiteCompP: TDBCheckBox;
    dchkBancaOreResidAnnoPrec: TDBCheckBox;
    Label22: TLabel;
    dedtBancaOreMensArr: TDBEdit;
    drgpSaldoNegativoMinimoTipo: TDBRadioGroup;
    lblArrRecScostNeg: TLabel;
    dedtArrRecScostNeg: TDBEdit;
    grpPassaggioAnno: TGroupBox;
    lblOreresiduabili: TLabel;
    dedtPALimite: TDBEdit;
    dchkPAAzzeramentoPerodico: TDBCheckBox;
    DBRadioGroup6: TDBRadioGroup;
    dchkBancaOreAbbattibile: TDBCheckBox;
    GroupBox6: TGroupBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    btnAbbattOreNonRecup: TBitBtn;
    dchkAbbattimentoFissoRecupero: TDBCheckBox;
    dgrpRiposoRecupLiquid: TDBRadioGroup;
    Label14: TLabel;
    dedtCausRipComFasce: TDBLookupComboBox;
    dlblCausRiepFasce: TDBText;
    dlblRiposoNonFruito: TDBText;
    GroupBox7: TGroupBox;
    dchkDebAggRappAnno: TDBCheckBox;
    Label23: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DBText1: TDBText;
    Label24: TLabel;
    dedtPALimiteSaldoAtt: TDBEdit;
    Label25: TLabel;
    dedtPALimiteSaldoPrec: TDBEdit;
    dchkDebAggConsideraOrePrec: TDBCheckBox;
    rgrpLimiteStraordliq: TDBRadioGroup;
    GroupBox8: TGroupBox;
    Label26: TLabel;
    dedtRNFAssenzeTollerate: TDBEdit;
    btnRNFAssenzeTollerate: TButton;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    Label27: TLabel;
    dedtRNFFiltro: TDBEdit;
    DBRadioGroup7: TDBRadioGroup;
    lblIterRichStraord: TLabel;
    dcmbIterRichStraord: TDBLookupComboBox;
    dchkBancaOreEsclusaSaldi: TDBCheckBox;
    dchkTipoLimiteCompNoRec: TDBCheckBox;
    actSoglieStraordinario: TAction;
    Button1: TButton;
    lblRecDebito_maxtollerato: TLabel;
    dedtRecDebito_maxtollerato: TDBEdit;
    GroupBox9: TGroupBox;
    lblCausRiebtriObbl: TLabel;
    dedtCausRiebtriObbl: TDBEdit;
    btnCausRiebtriObbl: TButton;
    btnRientri: TButton;
    Label28: TLabel;
    dcmbPARaggrLimite: TDBLookupComboBox;
    Label29: TLabel;
    dcmbPARaggrLimiteSaldoAtt: TDBLookupComboBox;
    Label30: TLabel;
    dcmbPARaggrLimiteSaldoPrec: TDBLookupComboBox;
    chkIterEccGGCheckSaldo: TDBCheckBox;
    Label31: TLabel;
    dedtCausaliCompensabiliMensili: TDBEdit;
    btnCausaliCompensabiliMensili: TButton;
    procedure Copiada1Click(Sender: TObject);
    procedure drgpSaldoNegativoMinimoTipoChange(Sender: TObject);
    procedure DBRadioGroup6Change(Sender: TObject);
    procedure dchkBancaOreResidClick(Sender: TObject);
    procedure dcmbRiposoNonFruitoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBRadioGroup1Change(Sender: TObject);
    procedure DBComboBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure DBComboBox1Change(Sender: TObject);
    procedure DBComboBox2DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure DBComboBox3DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure dedtMesiSaldoPrecChange(Sender: TObject);
    procedure btnAbbattOreNonRecupClick(Sender: TObject);
    procedure drgpPeriodicitaAbbattimentoChange(Sender: TObject);
    procedure btnSaldiAbbattibiliClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnCausaliCompensabiliClick(Sender: TObject);
    procedure drgpTipoApplicazioneLimiteLiqClick(Sender: TObject);
    procedure dchkBancaOreClick(Sender: TObject);
    procedure dcmbAbbattMobileRiferimentoDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure dgrpLimitiEccCompChange(Sender: TObject);
    procedure dchkDebAggRappAnnoClick(Sender: TObject);
    procedure dchkBancaOreLimitataStrLiqAnnoClick(Sender: TObject);
    procedure btnRNFAssenzeTollerateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure dchkBancaOreEsclusaSaldiClick(Sender: TObject);
    procedure actSoglieStraordinarioExecute(Sender: TObject);
    procedure btnCausRiebtriObblClick(Sender: TObject);
    procedure btnRientriClick(Sender: TObject);
  private
    { Private declarations }
    ListaAssenze:TStringList;
  public
    { Public declarations }
  end;

const
  D_Conteggio:array[0..5] of String =
    ('Standard','Gestione recuperi','Compensazione non cumulabile','Mensile elastico','Compensazione con causale','Straordinario dopo resa debito');
  D_Indennita:array[0..3] of String =
    ('Nessuno','Separazione dal liquidabile','Separazione ind.notturna','Separazione ind.festiva');
  D_IndPresenza:array[0..1] of String =
    ('Nessuno','Controllo ciclicità turni');
  D_SaldMobiliRif:array[0..2] of String =
    ('Saldo mensile','Saldo mensile e annuale','Saldo annuale');

var
  A080FModConte: TA080FModConte;

procedure OpenA080ModConte(Cod:String);

implementation

uses A080UModConteDtM1, A080USaldiAbbattuti, A080UCausaliCompensabili,
     A080USoglieStraordinario, A080URientriObbligatori;

{$R *.DFM}

procedure OpenA080ModConte(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA080ModConte') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A080FModConte:=TA080FModConte.Create(nil);
  with A080FModConte do
  try
    A080FModConteDtM1:=TA080FModConteDtM1.Create(nil);
    A080FModConteDtM1.Q025.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A080FModConteDtM1.Free;
    Release;
  end;
end;

procedure TA080FModConte.FormCreate(Sender: TObject);
begin
  inherited;
  ListaAssenze:=TStringList.Create;
end;

procedure TA080FModConte.FormDestroy(Sender: TObject);
begin
  inherited;
  ListaAssenze.Free;
end;

procedure TA080FModConte.FormShow(Sender: TObject);
begin
  DButton.DataSet:=A080FModConteDtM1.Q025;
  PageControl1.ActivePageIndex:=0;
  inherited;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
  dchkBancaOreClick(nil);
end;

procedure TA080FModConte.DBRadioGroup1Change(Sender: TObject);
begin
  inherited;
  DbRadioGroup2.Enabled:=DbRadioGroup1.ItemIndex = 1;
  Label4.Visible:=DbRadioGroup1.ItemIndex = 1;
  DbEdit1.Visible:=DbRadioGroup1.ItemIndex = 1;
  if DButton.State in [dsEdit,dsInsert] then
    if DbRadioGroup1.ItemIndex = 0 then
      begin
      DbRadioGroup2.Field.AsString:='M';
      DbEdit1.Field.Clear;
      end;
end;

procedure TA080FModConte.DBComboBox1DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,D_Conteggio[Index]);
end;

procedure TA080FModConte.DBComboBox1Change(Sender: TObject);
begin
  PageControl1.Visible:=DBComboBox1.ItemIndex = 1;
  if (DBComboBox1.ItemIndex = 0) and (DButton.State in [dsEdit,dsInsert]) then
    with A080FModConteDtM1.Q025 do
      begin
      FieldByName('INDENNITA').AsString:='0';
      FieldByName('INDPRESENZA').AsString:='0';
      FieldByName('RECUPERODEBITO').AsString:='N';
      FieldByName('LIQUIDDISTRIBUITA').AsString:='S';
      end;
end;

procedure TA080FModConte.DBComboBox2DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,D_Indennita[Index]);
end;

procedure TA080FModConte.DBComboBox3DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,D_IndPresenza[Index]);
end;

procedure TA080FModConte.dcmbAbbattMobileRiferimentoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,D_SaldMobiliRif[Index]);
end;


procedure TA080FModConte.dedtMesiSaldoPrecChange(Sender: TObject);
begin
  dchkLiquidazioneDistribuita.Enabled:=StrToIntDef(dedtMesiSaldoPrec.Text,0) < 0;
  if (StrToIntDef(dedtMesiSaldoPrec.Text,0) >= 0) and (DButton.State in [dsEdit,dsInsert]) then
    dchkLiquidazioneDistribuita.Field.AsString:='N';
end;

procedure TA080FModConte.actSoglieStraordinarioExecute(Sender: TObject);
begin
  inherited;
  if DButton.State <> dsBrowse then
    exit;
  A080FSoglieStraordinario:=TA080FSoglieStraordinario.Create(nil);
  try
    A080FSoglieStraordinario.TipoCartellino:=A080FModConteDtM1.Q025.FieldByName('CODICE').AsString;
    A080FSoglieStraordinario.ShowModal;
  finally
    FreeAndNil(A080FSoglieStraordinario);
  end;
end;

procedure TA080FModConte.btnAbbattOreNonRecupClick(Sender: TObject);
begin
  if DButton.State in [dsEdit,dsBrowse] then
  begin
    A080FSaldiAbbattuti:=TA080FSaldiAbbattuti.Create(nil);
    A080FModConteDtM1.Q026.Close;
    A080FModConteDtM1.Q026.SetVariable('Codice',A080FModConteDtM1.Q025.FieldByName('Codice').AsString);
    A080FModConteDtM1.Q026.ReadOnly:=DButton.State = dsBrowse;
    A080FModConteDtM1.Q026.Open;
    A080FSaldiAbbattuti.ShowModal;
    FreeAndNil(A080FSaldiAbbattuti);
  end;
end;

procedure TA080FModConte.drgpPeriodicitaAbbattimentoChange(Sender: TObject);
begin
  dedtAbbattimentoMobileMax.Enabled:=drgpPeriodicitaAbbattimento.ItemIndex = 1;
  lblAbbattimentoMobileMax.Enabled:=drgpPeriodicitaAbbattimento.ItemIndex = 1;
  clstSaldiAbbattibili.Enabled:=drgpPeriodicitaAbbattimento.ItemIndex = 1;
  lblSaldiAbbattibili.Enabled:=drgpPeriodicitaAbbattimento.ItemIndex = 1;
  btnSaldiAbbattibili.Enabled:=(drgpPeriodicitaAbbattimento.ItemIndex = 1) and (dButton.State in [dsEdit,dsInsert]);
  dcmbAbbattMobileRiferimento.Enabled:=drgpPeriodicitaAbbattimento.ItemIndex = 1;
  lblAbbattMobileRiferimento.Enabled:=drgpPeriodicitaAbbattimento.ItemIndex = 1;
  dchkAbbattimentoFissoRecupero.Enabled:=drgpPeriodicitaAbbattimento.ItemIndex = 0;
end;

procedure TA080FModConte.btnSaldiAbbattibiliClick(Sender: TObject);
begin
  clstSaldiAbbattibili.Items.Move(1,0);
end;

procedure TA080FModConte.DButtonStateChange(Sender: TObject);
begin
  inherited;
  drgpPeriodicitaAbbattimentoChange(nil);
  C600frmSelAnagrafe.btnSelezione.Enabled:=DButton.State in [dsInsert,dsEdit];
  actSoglieStraordinario.Enabled:=DButton.State = dsBrowse;
end;

procedure TA080FModConte.btnCausaliCompensabiliClick(Sender: TObject);
var F:TStringField;
begin
  if DButton.State in [dsEdit,dsInsert] then
  try
    if Sender = btnCausaliCompensabili then
      F:=(dedtCausaliCompensabili.Field as TStringField)
    else
      F:=(dedtCausaliCompensabiliMensili.Field as TStringField);
    A080FCausaliCompensabili:=TA080FCausaliCompensabili.Create(nil);
    A080FCausaliCompensabili.lstCausali.Items.CommaText:=F.AsString;
    if A080FCausaliCompensabili.ShowModal = mrOk then
      F.AsString:=A080FCausaliCompensabili.lstCausali.Items.CommaText;
  finally
    FreeAndNil(A080FCausaliCompensabili);
  end;
end;

procedure TA080FModConte.btnCausRiebtriObblClick(Sender: TObject);
  procedure CaricaLista;
  begin
    C013FCheckList.clbListaDati.Clear;
    with A080FModConteDtM1.selT265RNF do
    begin
      Open;
      First;
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%5s %s',[FieldByName('CODICE').asString,FieldByName('DESCRIZIONE').asString]));
        Next;
      end;
    end;
  end;
begin
  inherited;
  if not (DButton.State in [dsEdit,dsInsert]) then
    exit;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    CaricaLista;
    R180PutCheckList(dedtCausRiebtriObbl.Field.AsString,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      dedtCausRiebtriObbl.Field.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    Release;
  end;
end;

procedure TA080FModConte.btnRientriClick(Sender: TObject);
begin
  inherited;
  if DButton.State <> dsBrowse then
    exit;
  A080FRientriObbligatori:=TA080FRientriObbligatori.Create(nil);
  try
    A080FRientriObbligatori.TipoCartellino:=A080FModConteDtM1.Q025.FieldByName('CODICE').AsString;
    A080FRientriObbligatori.ShowModal;
  finally
    FreeAndNil(A080FRientriObbligatori);
  end;
end;

procedure TA080FModConte.btnRNFAssenzeTollerateClick(Sender: TObject);
  procedure CaricaLista;
  begin
    C013FCheckList.clbListaDati.Clear;
    with A080FModConteDtM1.selT265RNF do
    begin
      Open;
      First;
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%5s %s',[FieldByName('CODICE').asString,FieldByName('DESCRIZIONE').asString]));
        Next;
      end;
    end;
  end;
begin
  inherited;
  if not (DButton.State in [dsEdit,dsInsert]) then
    exit;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    CaricaLista;
    R180PutCheckList(dedtRNFAssenzeTollerate.Field.AsString,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      dedtRNFAssenzeTollerate.Field.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    Release;
  end;
end;

procedure TA080FModConte.drgpTipoApplicazioneLimiteLiqClick(
  Sender: TObject);
begin
  inherited;
  if (DButton.State in [dsEdit,dsInsert]) and ((Sender as TDBRadioGroup).ItemIndex = 2) then
    if Sender = drgpTipoApplicazioneLimiteLiq then
      drgpTipoApplicazioneLimiteRes.Field.AsString:='EG'
    else
      drgpTipoApplicazioneLimiteLiq.Field.AsString:='EG';
end;

procedure TA080FModConte.dchkBancaOreClick(Sender: TObject);
begin
  dchkBancaOreEsclusaSaldi.Enabled:=dchkBancaOre.Checked;
  dchkBancaOreResidAnnoPrec.Enabled:=dchkBancaOre.Checked;
  dchkBancaOreEsclusaAbbatt.Enabled:=dchkBancaOre.Checked and (not dchkBancaOreEsclusaSaldi.Checked);
  dchkBancaOreLimitataStrLiqAnno.Enabled:=dchkBancaOre.Checked;
  dchkBancaOreAbbattibile.Enabled:=dchkBancaOre.Checked and (not dchkBancaOreEsclusaSaldi.Checked);
  dchkBancaOreResid.Enabled:=dchkBancaOre.Checked;
  dchkBancaOreLimitataSaldoComp.Enabled:=dchkBancaOre.Checked and (not dchkBancaOreEsclusaSaldi.Checked);
  dchkBancaOreLimitataStrLiqAnno.Enabled:=dchkBancaOre.Checked;
  rgrpLimiteStraordliq.Enabled:=dchkBancaOre.Checked and dchkBancaOreLimitataStrLiqAnno.Checked;
  dedtBancaOreMensArr.Enabled:=dchkBancaOre.Checked;
  Label22.Enabled:=dchkBancaOre.Checked;
end;

procedure TA080FModConte.dchkBancaOreEsclusaSaldiClick(Sender: TObject);
begin
  inherited;
  dchkBancaOreEsclusaAbbatt.Enabled:=not dchkBancaOreEsclusaSaldi.Checked and dchkBancaOre.Checked;
  dchkBancaOreAbbattibile.Enabled:=not dchkBancaOreEsclusaSaldi.Checked and dchkBancaOre.Checked;
  dchkBancaOreLimitataSaldoComp.Enabled:=not dchkBancaOreEsclusaSaldi.Checked and dchkBancaOre.Checked;
end;

procedure TA080FModConte.dchkBancaOreLimitataStrLiqAnnoClick(Sender: TObject);
begin
  inherited;
  rgrpLimiteStraordliq.Enabled:=dchkBancaOre.Checked and dchkBancaOreLimitataStrLiqAnno.Checked;
end;

procedure TA080FModConte.dgrpLimitiEccCompChange(Sender: TObject);
begin
  dchkTipoLimiteCompP.Enabled:=dgrpLimitiEccComp.ItemIndex = 2;
  dchkTipoLimiteCompNoRec.Enabled:=dgrpLimitiEccComp.ItemIndex in [1,3];
  if not dchkTipoLimiteCompNoRec.Enabled then
    dchkTipoLimiteCompNoRec.Checked:=False;
end;

procedure TA080FModConte.dcmbRiposoNonFruitoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA080FModConte.dchkBancaOreResidClick(Sender: TObject);
begin
  inherited;
  dchkBancaOreResidAnnoPrec.Enabled:=dchkBancaOreResid.Checked;
end;

procedure TA080FModConte.dchkDebAggRappAnnoClick(Sender: TObject);
begin
  inherited;
  dchkDebAggConsideraOrePrec.Enabled:=dchkDebAggRappAnno.Checked;
end;

procedure TA080FModConte.DBRadioGroup6Change(Sender: TObject);
begin
  dchkTipoLimiteCompP.Enabled:=dgrpLimitiEccComp.ItemIndex = 2;
end;

procedure TA080FModConte.drgpSaldoNegativoMinimoTipoChange(Sender: TObject);
begin
  inherited;
  dedtSaldoNegativoMinimo.Enabled:=drgpSaldoNegativoMinimoTipo.ItemIndex = 1;
  dedtArrRecScostNeg.Enabled:=drgpSaldoNegativoMinimoTipo.ItemIndex = 2;
  lblArrRecScostNeg.Enabled:=drgpSaldoNegativoMinimoTipo.ItemIndex = 2;
end;

procedure TA080FModConte.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
var S:String;
begin
  if not (DButton.State in [dsEdit,dsInsert]) then
    exit;
  C600frmSelAnagrafe.C600DataLavoro:=Date;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text:=dedtRNFFiltro.Field.AsString;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    S:=StringReplace(S,#13#10,' ',[rfReplaceAll]);
    dedtRNFFiltro.Field.AsString:=S;
  end;
end;

procedure TA080FModConte.Copiada1Click(Sender: TObject);
var CodiceOld,CodiceNew:String;
begin
  with A080FModConteDtM1 do
  begin
    CodiceOld:=Q025.FieldByName('CODICE').AsString;
    Q026.Close;
    Q026.SetVariable('Codice',Q025.FieldByName('Codice').AsString);
    Q026.Open;
    inherited;
    //if Q025.FieldByName('CODICE').AsString <> VarToStr(Q026.GetVariable('Codice')) then
    if Q025.FieldByName('CODICE').AsString <> CodiceOld then
    begin
      insT026.SetVariable('CODICE_OLD',CodiceOld);
      insT026.SetVariable('CODICE_NEW',Q025.FieldByName('CODICE').AsString);
      insT026.Execute;
      insT029.SetVariable('CODICE_OLD',CodiceOld);
      insT029.SetVariable('CODICE_NEW',Q025.FieldByName('CODICE').AsString);
      insT029.Execute;
      SessioneOracle.Commit;
    end;
    Q026.Close;
  end;
end;

end.
