unit A016UCausAssenze;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask, Math,
  DBCtrls, ActnList, ImgList, ToolWin, A017URaggrAsse, C015UElencoValori, C180FunzioniGenerali,
  A000UCostanti, A000USessione,A000UInterfaccia, C008UCercaDuplicati, C013UCheckList,
  Variants, OracleData, Grids, DBGrids, A000UMessaggi, System.Actions, C012UVisualizzaTesto,
  Oracle, System.ImageList;

type
  TA016FCausAssenze = class(TR001FGestTab)
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DBText1: TDBText;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    DBCheckBox4: TDBCheckBox;
    Label4: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    DBRadioGroup3: TDBRadioGroup;
    DBRadioGroup4: TDBRadioGroup;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBEdit3: TDBEdit;
    DBRadioGroup5: TDBRadioGroup;
    DBRadioGroup6: TDBRadioGroup;
    DBComboBox1: TDBComboBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBComboBox2: TDBComboBox;
    EGSignific: TDBRadioGroup;
    EFruibile: TDBCheckBox;
    EMaturFerie: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    GroupBox1: TGroupBox;
    DBCheckBox9: TDBCheckBox;
    actRicercaDuplicati: TAction;
    Ricercaduplicati1: TMenuItem;
    DBCheckBox10: TDBCheckBox;
    dchkNoSuperoCompetenze: TDBCheckBox;
    lblDescrizioneEstesa1: TLabel;
    dedtDescrizioneEstesa: TDBEdit;
    grpVincoliFruizione: TGroupBox;
    Label20: TLabel;
    dedtFruizMin: TDBEdit;
    Label22: TLabel;
    dedtFruizArr: TDBEdit;
    dchkFruizMaxDebito: TDBCheckBox;
    dchkFlessibilitaOrario: TDBCheckBox;
    gbxUnInserimento: TGroupBox;
    dchkUnInserimento: TDBCheckBox;
    dchkUnInserimentoMg: TDBCheckBox;
    dchkUnInserimentoH: TDBCheckBox;
    pnlCausaliCollegate: TPanel;
    Label21: TLabel;
    dedtCausaliCollegate: TDBEdit;
    btnCausaliCollegate: TButton;
    pnlAssenzeTollerate: TPanel;
    LAssenze: TLabel;
    EAssenze: TDBEdit;
    BAssenze: TButton;
    pnlInizioCumulo: TPanel;
    LDCausale: TDBText;
    ECodCauInizio: TDBLookupComboBox;
    LCausale: TLabel;
    pnlEUMCumulo: TPanel;
    pnlCumuloCollettivo: TPanel;
    ERaggruppamento: TDBLookupComboBox;
    LRaggruppamento: TLabel;
    dgrpCumuloGlobale: TDBRadioGroup;
    Panel3: TPanel;
    Label17: TLabel;
    ETipoCumulo: TDBComboBox;
    pnlRiposi: TPanel;
    chkMaturazioneProgressiva: TDBCheckBox;
    chkFestiviInfrasettimanali: TDBCheckBox;
    Label23: TLabel;
    DBEdit4: TDBEdit;
    dedtCodCau2: TDBEdit;
    btnCodCau2: TButton;
    lblCodCau2: TLabel;
    dchkFruizCompetenzeArr: TDBCheckBox;
    drgpIntersezioneTimbrature: TDBRadioGroup;
    pnlFestivita: TPanel;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox14: TDBCheckBox;
    lblCausaleSuccessiva: TLabel;
    dedtCausaleSuccessiva: TDBLookupComboBox;
    dlblCausaleSuccessiva: TDBText;
    DBCheckBox13: TDBCheckBox;
    dchkTimbPM: TDBCheckBox;
    dgrpCumuloTipoOre: TDBRadioGroup;
    pnlTipoCumuloM: TPanel;
    pnlTipoCumuloM2: TPanel;
    lblCMDebSett: TLabel;
    dedtCMDebSett: TDBEdit;
    grpCausaliTollerate: TGroupBox;
    dgrdT266: TDBGrid;
    DBCheckBox15: TDBCheckBox;
    lblCausale10Giorni: TLabel;
    dedtCausale10Giorni: TDBLookupComboBox;
    dlblCodCaus3: TDBText;
    dchkVisitaFiscale: TDBCheckBox;
    dchkPeriodoLungo: TDBCheckBox;
    TabSheet4: TTabSheet;
    gbxProporzioneCompetenze: TGroupBox;
    dchkPropozionaPerServ: TDBCheckBox;
    drgpTipoProporzione: TDBRadioGroup;
    dchkTempoDeterminato: TDBCheckBox;
    dChkPropAbilitazione: TDBCheckBox;
    EUMisura: TDBRadioGroup;
    grpMaxUnitario: TGroupBox;
    Label8: TLabel;
    Label29: TLabel;
    EHMaxUnitario: TDBEdit;
    EGMaxUnitario: TDBEdit;
    drdgRapportiUniti: TDBRadioGroup;
    grpFasce: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    GroupBox3: TGroupBox;
    lblFruizioneDurata: TLabel;
    lblFruizioneDopo: TLabel;
    EFruizione: TDBCheckBox;
    EDurata: TDBEdit;
    EUMFruizione: TDBRadioGroup;
    DBEdit5: TDBEdit;
    GroupBox2: TGroupBox;
    lblFruizioneCausale: TLabel;
    DBText10: TDBText;
    ECauFruizione: TDBLookupComboBox;
    dchkMaternitaObbl: TDBCheckBox;
    dcmbFruizioneFamiliari: TDBComboBox;
    lblFruizioneFamiliari: TLabel;
    Label6: TLabel;
    dcmbCumuloFamiliari: TDBComboBox;
    dchkTimbPMDetraz: TDBCheckBox;
    dchkUnInserimentoD: TDBCheckBox;
    lblFruizMax: TLabel;
    dedtFruizMax: TDBEdit;
    drgpCumulaRichiesteWeb: TDBRadioGroup;
    dgrpGiorniNonLav: TDBRadioGroup;
    EGMCumulo: TDBEdit;
    LData: TLabel;
    EDurataCumulo: TDBEdit;
    LDurata: TLabel;
    EUMCumulo: TDBRadioGroup;
    dchkCumuloFamGGDopo: TDBCheckBox;
    dchkFruizioneFamGGDopo: TDBCheckBox;
    Label7: TLabel;
    dedtFruizMaxNum: TDBEdit;
    lblAllarme: TLabel;
    dedtAllarmeFruizCont: TDBEdit;
    lblAllarmegg: TLabel;
    dchkDetReperibIntera: TDBCheckBox;
    dchkNoSuperoCompWeb: TDBCheckBox;
    lblDetReperib: TLabel;
    dcmbDetReperib: TDBComboBox;
    dchkCompetenzePersonalizzate: TDBCheckBox;
    grpPartTime: TGroupBox;
    chkPartTimeO: TCheckBox;
    chkPartTimeV: TCheckBox;
    chkPartTimeC: TCheckBox;
    TabSheet5: TTabSheet;
    GroupBox4: TGroupBox;
    LblDescVoce: TLabel;
    Label5: TLabel;
    dedtVocePaghe: TDBEdit;
    BtnVocePaghe: TButton;
    dchkScaricoPagheUMProp: TDBCheckBox;
    drgpUmScaricoPaghe: TDBRadioGroup;
    DBCheckBox11: TDBCheckBox;
    drgpArrotOre2GG: TDBRadioGroup;
    Label24: TLabel;
    dedtSiglaCausale: TDBEdit;
    dchkAbbatteGGSerTempoDet: TDBCheckBox;
    dchkAbbatteGgValutazione: TDBCheckBox;
    pnlCongParentali: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    dchkVarCompFruizMMInteri: TDBCheckBox;
    dedtMMContVarComp: TDBEdit;
    dedtVarCompFruizMMCont: TDBEdit;
    dedtCompIndivConiugeEsistente: TDBEdit;
    dchkArrotCompetenze: TDBCheckBox;
    ppmnuProcPers: TPopupMenu;
    Accedi1: TMenuItem;
    lblOreGGMaxInf6: TLabel;
    dedtOreGGMaxInf6: TDBEdit;
    lblOreGGMaxSup6: TLabel;
    dedtOreGGMaxSup6: TDBEdit;
    TabSheet6: TTabSheet;
    dGrdCausIncomp: TDBGrid;
    dcmbggnnlav: TDBComboBox;
    Label25: TLabel;
    dchkCopriFasciaObb: TDBCheckBox;
    dedtCSIMaxMGMat: TDBEdit;
    lblCSIMaxMGMat: TLabel;
    lblCSIMaxMGPom: TLabel;
    dedtCSIMaxMGPom: TDBEdit;
    lblCSIMaxMG: TLabel;
    dedtCSIMaxMG: TDBEdit;
    TabSheet7: TTabSheet;
    pnlParStorOpzioni: TPanel;
    chkVistaPeriodoCorr: TCheckBox;
    btnModificaParStor: TButton;
    pnlParStorGrid: TPanel;
    grdParamStoriciz: TStringGrid;
    btnDecParStorPrec: TSpeedButton;
    btnDecParStorSucc: TSpeedButton;
    cmbDecParStor: TComboBox;
    dchkEstendeMalattia: TDBCheckBox;
    procedure dgrdT266EditButtonClick(Sender: TObject);
    procedure DBCheckBox10Click(Sender: TObject);
    procedure btnCausaliSuccessiveClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure BtnVocePagheClick(Sender: TObject);
    procedure EFruibileClick(Sender: TObject);
    procedure btnCodCau2Click(Sender: TObject);
    procedure dcmbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TCancClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure EFruizioneClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure EUMisuraClick(Sender: TObject);
    procedure EUMisuraChange(Sender: TObject);
    procedure EHMaxUnitarioChange(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ETipoCumuloDrawItem(Control: TWinControl; Index: Integer;Rect: TRect; State: TOwnerDrawState);
    procedure ETipoCumuloChange(Sender: TObject);
    procedure BAssenzeClick(Sender: TObject);
    procedure CBCumuloCollettivoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBComboBox1DrawItem(Control: TWinControl; Index: Integer;Rect: TRect; State: TOwnerDrawState);
    procedure DBComboBox1Change(Sender: TObject);
    procedure DBComboBox2DrawItem(Control: TWinControl; Index: Integer;Rect: TRect; State: TOwnerDrawState);
    procedure btnCausaliCollegateClick(Sender: TObject);
    procedure actRicercaDuplicatiExecute(Sender: TObject);
    procedure dchkUnInserimentoHClick(Sender: TObject);
    procedure EGSignificChange(Sender: TObject);
    procedure dchkTimbPMClick(Sender: TObject);
    procedure dedtVocePagheExit(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure dedtVocePagheChange(Sender: TObject);
    procedure DBCheckBox15Click(Sender: TObject);
    procedure dchkNoSuperoCompetenzeClick(Sender: TObject);
    procedure dcmbDetReperibChange(Sender: TObject);
    procedure chkPartTimeOClick(Sender: TObject);
    procedure ImpostaPartTime;
    procedure Accedi1Click(Sender: TObject);
    procedure ppmnuProcPersPopup(Sender: TObject);
    procedure dchkUnInserimentoMgClick(Sender: TObject);
    procedure grdParamStoricizDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure chkVistaPeriodoCorrClick(Sender: TObject);
    procedure Copiada1Click(Sender: TObject);
    procedure btnModificaParStorClick(Sender: TObject);
    procedure cmbDecParStorChange(Sender: TObject);
    procedure btnDecParStorPrecClick(Sender: TObject);
    procedure btnDecParStorSuccClick(Sender: TObject);
  private
    procedure CaricaLista;
    procedure CaricaCausaliAssPres;
  public
    procedure ToggleControlliSchedaParStor(Attiva:Boolean);
  end;

var
  A016FCausAssenze: TA016FCausAssenze;

procedure OpenA016CausAssenze(Cod:String);

implementation

uses A016UCausAssenzeMW, A016UCausAssenzeDtM1, A016UListaCaus, C016UElencoVoci,
     A016UCausAssenzeStoricoMW, A016UCausAssenzeStorico, A016UCausAssenzeStoricoDM;

{$R *.DFM}

procedure OpenA016CausAssenze(Cod:String);
{Causali di assenza}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA016CausAssenze') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A016FCausAssenze:=TA016FCausAssenze.Create(nil);
  with A016FCausAssenze do
  try
    A016FCausAssenzeDtM1:=TA016FCausAssenzeDtM1.Create(nil);
    DButton.DataSet:=A016FCausAssenzeDtM1.T265;
    DButton.DataSet.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A016FCausAssenzeDtM1.Free;
    Release;
  end;
end;

procedure TA016FCausAssenze.FormCreate(Sender: TObject);
{Imposto la prima pagina attiva}
begin
  inherited;
  PageControl1.ActivePage:=TabSheet1;
  R180SetComboItemsValues(DBComboBox1.Items,A016FCausAssenzeDtM1.A016MW.D_InfCont,'V');
  R180SetComboItemsValues(DBComboBox2.Items,A016FCausAssenzeDtM1.A016MW.D_ModRecupero,'V');
  R180SetComboItemsValues(ETipoCumulo.Items,A016FCausAssenzeDtM1.A016MW.D_Cumulo,'V');
  R180SetComboItemsValues(dcmbDetReperib.Items,A016FCausAssenzeDtM1.A016MW.D_DetReperib,'V');
  R180SetComboItemsValues(dcmbCumuloFamiliari.Items,A016FCausAssenzeDtM1.A016MW.D_FruizioneFamiliari,'V');
  R180SetComboItemsValues(dcmbFruizioneFamiliari.Items,A016FCausAssenzeDtM1.A016MW.D_FruizioneFamiliari,'V');

  grdParamStoriciz.RowCount:=2;
  grdParamStoriciz.FixedRows:=1;
  grdParamStoriciz.ColCount:=4;
  grdParamStoriciz.DefaultRowHeight:=18;

  grdParamStoriciz.Cells[0,0]:='Dato';
  grdParamStoriciz.ColWidths[0]:=270;
  grdParamStoriciz.Cells[1,0]:='Decorrenza';
  grdParamStoriciz.ColWidths[1]:=70;
  grdParamStoriciz.Cells[2,0]:='Termine';
  grdParamStoriciz.ColWidths[2]:=70;
  grdParamStoriciz.Cells[3,0]:='Valore';
  grdParamStoriciz.ColWidths[3]:=190;
end;

procedure TA016FCausAssenze.grdParamStoricizDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (gdSelected in State) or (gdFixed in State) then
    Exit;
  if (A016FCausAssenzeDtM1.A016StoricoMW.StoriaDati.Items[ARow - 1].IndiceDato mod 2 = 0) then
  begin
    grdParamStoriciz.Canvas.Brush.Color:=$00FFFF80;
    grdParamStoriciz.Canvas.Font.Color:=clWindowText;
    grdParamStoriciz.Canvas.FillRect(Rect);
    grdParamStoriciz.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top + 2,grdParamStoriciz.Cells[ACol,ARow]);
  end;
end;

procedure TA016FCausAssenze.TAnnullaClick(Sender: TObject);
begin
  inherited;
  A016FCausAssenzeDtM1.RefreshCodiceVoce;
end;

procedure TA016FCausAssenze.TCancClick(Sender: TObject);
begin
  inherited;
  with A016FCausAssenzeDtM1.A016MW do
  begin
    Q265A.Close;
    Q265A.Open;
    Q265B.Close;
    Q265B.Open;
    selT265T275.Close;
    selT265T275.Open;
  end;
end;

procedure TA016FCausAssenze.TRegisClick(Sender: TObject);
begin
  inherited;
  with A016FCausAssenzeDtM1.A016MW do
  begin
    Q265A.Close;
    Q265A.Open;
    Q265B.Close;
    Q265B.Open;
    selT265T275.Close;
    selT265T275.Open;
  end;
end;

procedure TA016FCausAssenze.EFruizioneClick(Sender: TObject);
{Abilito/disabilito dati di fruizione}
begin
  with A016FCausAssenzeDtM1.T265 do
  begin
    lblFruizioneDurata.Enabled:=EFruizione.Checked;
    lblFruizioneDopo.Enabled:=EFruizione.Checked;
    lblFruizioneCausale.Enabled:=EFruizione.Checked;
    EDurata.Enabled:=EFruizione.Checked;
    EUMFruizione.Enabled:=EFruizione.Checked;
    ECauFruizione.Enabled:=EFruizione.Checked;
    lblFruizioneFamiliari.Enabled:=EFruizione.Checked;
    dcmbFruizioneFamiliari.Enabled:=EFruizione.Checked;
    dchkFruizioneFamGGDopo.Enabled:=EFruizione.Checked;
    FieldByName('DurataFruizione').Required:=EFruizione.Checked;
    if not(State in [dsInsert,dsEdit]) then exit;
    if not EFruizione.Checked then
    begin
      FieldByName('DurataFruizione').Clear;
      FieldByName('CodCauFruizione').Clear;
      FieldByName('Fruizione_Familiari').AsString:='N';
    end;
  end;
end;

procedure TA016FCausAssenze.EGSignificChange(Sender: TObject);
begin
  inherited;
  if EGSignific.ItemIndex >= 0 then
  begin
    //dChkggnnLav.Enabled:=EGSignific.Items[EGSignific.ItemIndex] = 'Giorni di Calendario';
    dcmbggnnlav.Enabled:=EGSignific.Items[EGSignific.ItemIndex] = 'Giorni di Calendario';
    if EGSignific.Items[EGSignific.ItemIndex] <> 'Giorni di Calendario' then
      A016FCausAssenzeDtM1.T265.FieldByName('COPRI_GGNONLAV').AsString:='N';
  end;
end;

procedure TA016FCausAssenze.DButtonDataChange(Sender: TObject;
  Field: TField);
{Abilito/disabilito i controlli in scorrimento}
begin
  with A016FCausAssenzeDtM1 do
  begin
    if (Field = nil) and (DButton.State = dsBrowse) then
    begin
      ETipoCumuloChange(ETipoCumulo);
      A016MW.Q260.SearchRecord('CODICE',T265.FieldByName('CodRaggr').AsString,[srFromBeginning]);
      BDET265CodRaggrChange(T265.FieldByName('CodRaggr'));
      EDurata.Enabled:=EFruizione.Checked;
      EUMFruizione.Enabled:=EFruizione.Checked;
      ECauFruizione.Enabled:=EFruizione.Checked;
      DbCheckBox1.Visible:=DBComboBox1.Text = 'B';
      DbComboBox2.Enabled:=(DBComboBox1.Text = 'A') or (DBComboBox1.Text = 'C') or (DBComboBox1.Text = 'G') or (DBComboBox1.Text = 'H') or (DBComboBox1.Text = 'I');
      lblDetReperib.Enabled:=(DBComboBox1.Text <> 'B') and (DBComboBox1.Text <> 'D');
      dcmbDetReperib.Enabled:=(DBComboBox1.Text <> 'B') and (DBComboBox1.Text <> 'D');
      dchkDetReperibIntera.Enabled:=R180CarattereDef(dcmbDetReperib.Text) in ['1','2'];
      // TODO: il legame si � perso in seguito alla storicizzazione di ABBATTE_STRIND
      // dchkAbbatteStrInd.Enabled:=DBComboBox1.Text = 'D';
      dchkTimbPMClick(nil);
    end;
  end;
end;

procedure TA016FCausAssenze.EUMisuraChange(Sender: TObject);
{Cambio la picture dei campi Competenze a seconda che si
lavori in Ore o in Giorni}
begin
  if DButton.State = dsBrowse then
    EUMisuraClick(Sender);
end;

procedure TA016FCausAssenze.EUMisuraClick(Sender: TObject);
{Cambio la picture dei campi Competenze a seconda che si lavori in Ore o in Giorni}
var i:Byte;
    RadioValue:Integer;
begin
  RadioValue:=Max(0,EUMisura.ItemIndex); //Se vale -1 lo porto a 0
  drgpArrotOre2GG.Enabled:=(RadioValue = 0) or (A016FCausAssenzeDtM1.A016MW.Q260.FieldByName('CONTASOLARE').AsString = 'S');
  {Max Unitario e Competenze G/H}
  EHMaxUnitario.Enabled:=(not EUMisura.Enabled) or (RadioValue = 0);
  EGMaxUnitario.Enabled:=(not EUMisura.Enabled) or (RadioValue = 1);
  with A016FCausAssenzeDtM1.T265 do
  begin
    if State in [dsInsert,dsEdit] then
    begin
      if not EHMaxUnitario.Enabled then
        FieldByName('HMaxUnitario').Clear;
      if not EGMaxUnitario.Enabled then
        FieldByName('GMaxUnitario').Clear;
    end;
    i:=20;
    while i<=30 do
    begin
      if RadioValue = 0 then
        Fields[i].EditMask:='!9990:00;1;_'  {hhhh.mm}
      else
        Fields[i].EditMask:='!990,9;1;_';   {ggg,[5]}
      i:=i+2;
    end;
  end;
end;

procedure TA016FCausAssenze.EHMaxUnitarioChange(Sender: TObject);
begin
  {Abblenco il campo se non contiene niente}
  if DButton.State in [dsInsert,dsEdit] then
    if (Trim((Sender as TDBEdit).Text) = '.') or (Trim((Sender as TDBEdit).Text) = '/') then
      (Sender as TDBEdit).Field.Clear;
end;

procedure TA016FCausAssenze.Nuovoelemento1Click(Sender: TObject);
{Gestione Raggruppamenti assenze}
begin
  OpenA017RaggrAsse(DBLookupComboBox1.Text);
  A016FCausAssenzeDtM1.A016MW.Q260.Refresh;
  A016FCausAssenzeDtM1.A016MW.Q260.SearchRecord('CODICE',DbLookupComboBox1.Field.AsString,[srFromBeginning]);
end;

procedure TA016FCausAssenze.ppmnuProcPersPopup(Sender: TObject);
begin
  inherited;
  with A016FCausAssenzeDtM1.A016MW do
  begin
    if ppmnuProcPers.PopupComponent = ETipoCumulo then
      selVSource.SetVariable('SNAME','T265P_GETPERIODOCUMULO')
    else if ppmnuProcPers.PopupComponent = dchkCompetenzePersonalizzate then
      selVSource.SetVariable('SNAME','T265P_GETCOMPETENZE')
    else if ppmnuProcPers.PopupComponent = dchkArrotCompetenze then
      selVSource.SetVariable('SNAME','T265P_ARROTCOMPETENZE');
    selVSource.Open;
    if selVSource.RecordCount = 0 then
    begin
      selVSource.Close;
      Abort;
    end;
  end;
end;

procedure TA016FCausAssenze.ETipoCumuloDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
{Inserisco le descrizioni dei tipi cumulo nel ComboBox}
begin
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A016FCausAssenzeDtM1.A016MW.D_Cumulo[Index].Item);
end;

procedure TA016FCausAssenze.ETipoCumuloChange(Sender: TObject);
{Abilito/disabilito i dati di cumulo in base al tipo}
var Cod:Char;
begin
  if Trim(ETipoCumulo.Text) = '' then exit;
  Cod:=ETipoCumulo.Text[1];
  A016FCausAssenzeDtM1.A016MW.AllineaFieldTipoCumulo(Cod);
  GroupBox1.Visible:=not(Cod in ['H']);
  R180AbilitaOggetti(grpFasce,not(Cod in ['H','N','P','Q','R','S','T']));
  dchkCompetenzePersonalizzate.Enabled:=Cod <> 'H';
  dchkArrotCompetenze.Enabled:=Cod <> 'H';

  drdgRapportiUniti.Enabled:=(A016FCausAssenzeDtM1.A016MW.Q260.FieldByName('ContASolare').AsString = 'N') and (Cod <> 'H');
  lblCausaleSuccessiva.Enabled:=not(Cod in ['H']);
  dlblCausaleSuccessiva.Enabled:=not(Cod in ['H']);
  dedtCausaleSuccessiva.Enabled:=not(Cod in ['H']);
  gbxProporzioneCompetenze.Visible:=not(Cod in ['H']);
  dchkTempoDeterminato.Enabled:=(Cod in ['C','I','O']);
  pnlEUMCumulo.Visible:=Cod in ['B','C','D','G','I','O','T','Q'];
  if Cod = 'Q' then
  begin
    EUMCumulo.Caption:='Parametri di maturazione primi riposi';
    EUMCumulo.Columns:=3;
    EUMCumulo.Items.Clear;
    EUMCumulo.Items.Add('Domeniche da inizio anno');
    EUMCumulo.Items.Add('Domeniche del mese');
    EUMCumulo.Items.Add('No Domeniche');
    EUMCumulo.Values.Clear;
    EUMCumulo.Values.Add('A');
    EUMCumulo.Values.Add('M');
    EUMCumulo.Values.Add('N');
    EUMCumulo.Width:=450;
  end
  else
  begin
    EUMCumulo.Caption:='Unit� di misura';
    EUMCumulo.Columns:=2;
    EUMCumulo.Items.Clear;
    EUMCumulo.Items.Add('Anni');
    EUMCumulo.Items.Add('Mesi');
    EUMCumulo.Values.Clear;
    EUMCumulo.Values.Add('A');
    EUMCumulo.Values.Add('M');
    EUMCumulo.Width:=120;
  end;
  EUMCumulo.ItemIndex:=EUMCumulo.Values.IndexOf(EUMCumulo.Field.AsString);
  EUMCumulo.ReadOnly:=Cod in ['B','T'];
  EDurataCumulo.Visible:=Cod in ['B','C','D','G','I','O','T'];
  EGMCumulo.Visible:=Cod in ['D'];
  pnlRiposi.Visible:=Cod in ['Q'];
  pnlRiposi.Top:=pnlEUMCumulo.Top + 1;
  pnlFestivita.Visible:=Cod in ['P'];
  pnlInizioCumulo.Visible:=not(Cod in ['H']);
  dchkCumuloFamGGDopo.Visible:=Cod in ['G'];
  ECodCauInizio.Visible:=Cod in ['F','G'];
  LDCausale.Visible:=Cod in ['F','G'];
  LCausale.Visible:=Cod in ['F','G'];
  // AOSTA_REGIONE - commessa 2012/152.ini
  pnlCongParentali.Visible:=Cod in ['F'];
  // AOSTA_REGIONE - commessa 2012/152.fine
  pnlAssenzeTollerate.Visible:=Cod in ['P','S','T','U'];
  pnlTipoCumuloM.Visible:=Cod in ['M'];
  if pnlTipoCumuloM.Visible then
  begin
    pnlTipoCumuloM.Align:=alNone;
    pnlTipoCumuloM.Top:=pnlCumuloCollettivo.Top + pnlCumuloCollettivo.Width;
    pnlTipoCumuloM.Align:=alClient;
    chkMaturazioneProgressiva.Parent:=pnlTipoCumuloM2;
    chkMaturazioneProgressiva.Top:=7;
  end
  else
  begin
    chkMaturazioneProgressiva.Parent:=pnlRiposi;
    chkMaturazioneProgressiva.Top:=0;
  end;
  //Nascondo le labels
  LDurata.Visible:=EDurataCumulo.Visible;
  LData.Visible:=EGMCumulo.Visible;
  if Cod in ['M','P','U'] then
    LAssenze.Caption:='Causali tollerate:'
  else
    LAssenze.Caption:='Causali considerate:';
end;

procedure TA016FCausAssenze.CBCumuloCollettivoClick(Sender: TObject);
begin
  if (DButton.State in [dsEdit,dsInsert]) and (dgrpCumuloGlobale.ItemIndex <> 2) then
    ERaggruppamento.Field.Clear;
  ERaggruppamento.Enabled:=dgrpCumuloGlobale.ItemIndex = 2;
  LRaggruppamento.Enabled:=dgrpCumuloGlobale.ItemIndex = 2;
end;

procedure TA016FCausAssenze.chkPartTimeOClick(Sender: TObject);
begin
  drgpTipoProporzione.Enabled:=chkPartTimeO.Checked or chkPartTimeV.Checked or chkPartTimeC.Checked;
end;

procedure TA016FCausAssenze.chkVistaPeriodoCorrClick(Sender: TObject);
begin
  if (DButton.DataSet.State = dsBrowse) and (DButton.DataSet.RecordCount > 0) then
  begin
    if chkVistaPeriodoCorr.Checked then
    begin
      cmbDecParStor.ItemIndex:=A016FCausAssenzeDtM1.A016StoricoMW.IndiceDecorrenzaCorrente;
      cmbDecParStor.Enabled:=False;
      btnDecParStorPrec.Enabled:=False;
      btnDecParStorSucc.Enabled:=False;
      cmbDecParStor.OnChange(nil);
    end
    else
    begin
      cmbDecParStor.Enabled:=True;
      btnDecParStorPrec.Enabled:=True;
      btnDecParStorSucc.Enabled:=True;
    end;
  end;
end;

procedure TA016FCausAssenze.cmbDecParStorChange(Sender: TObject);
var
  DataPeriodo:TDateTime;
begin
  A016FCausAssenzeDtM1.SvuotaGrigliaDatiStoriciz;
  if (DButton.DataSet.State = dsBrowse) and (DButton.DataSet.RecordCount > 0) then
  begin
    DataPeriodo:=StrToDate(cmbDecParStor.Text);
    A016FCausAssenzeDtM1.AggiornaGrigliaDatiStoriciz(DataPeriodo);
  end;
end;

procedure TA016FCausAssenze.Copiada1Click(Sender: TObject);
var
  IDSorgente,IDDestinazione:Integer;
begin
  IDSorgente:=DButton.DataSet.FieldByName('ID').AsInteger;
  inherited;
  if CodiceCopiaSu <> '' then
  begin
    IDDestinazione:=DButton.DataSet.FieldByName('ID').AsInteger;
    try
      A016FCausAssenzeDtM1.A016StoricoMW.CreaCopiaParametriStorici(IDSorgente,IDDestinazione);
    finally
      DButton.DataSet.Refresh;
      DButton.DataSet.Locate('ID',IDDestinazione,[]);
    end;
  end;
end;

procedure TA016FCausAssenze.BAssenzeClick(Sender: TObject);
var S:String;
begin
  if not(DButton.State in [dsEdit,dsInsert]) then
    exit;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    S:=EAssenze.Field.AsString;
    if (ETipoCumulo.Field.AsString = 'M') or (ETipoCumulo.Field.AsString = 'T') or (ETipoCumulo.Field.AsString = 'U') then
      CaricaLista
    else
      CaricaCausaliAssPres;
    R180PutCheckList(S,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
    begin
      EAssenze.Field.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
      if (ETipoCumulo.Field.AsString = 'T') and (Pos(',',EAssenze.Field.AsString) > 0) then
        ETipoCumulo.Field.AsString:=Copy(ETipoCumulo.Field.AsString,1,Pos(',',EAssenze.Field.AsString) - 1);
    end;
  finally
    Release;
  end;
end;

procedure TA016FCausAssenze.CaricaLista;
begin
  with A016FCausAssenzeDtM1.A016MW.Q265A do
  begin
    First;
    while not Eof do
    begin
      C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;

procedure TA016FCausAssenze.CaricaCausaliAssPres;
var P:Boolean;
begin
  with A016FCausAssenzeDtM1.A016MW.selT265T275 do
  begin
    P:=False;
    C013FCheckList.clbListaDati.Items.Add('     * ASSENZE *');
    C013FCheckList.clbListaDati.Header[C013FCheckList.clbListaDati.Items.Count - 1]:=True;
    First;
    while not Eof do
    begin
      if (not P) and (FieldByName('TIPO').AsString = 'P') then
      begin
        C013FCheckList.clbListaDati.Items.Add('     * PRESENZE *');
        C013FCheckList.clbListaDati.Header[C013FCheckList.clbListaDati.Items.Count - 1]:=True;
        P:=True;
      end;
      C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;

procedure TA016FCausAssenze.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A016FCausAssenzeDtm1.T265;
  dGrdCausIncomp.DataSource:=A016FCausAssenzeDtm1.A016MW.dsrT259;
  R180SetComboItemsValues(dGrdCausIncomp.Columns[0].PickList,A016FCausAssenzeDtm1.A016MW.D_Incomp_TipoContr,'I');
  R180SetComboItemsValues(dGrdCausIncomp.Columns[1].PickList,A016FCausAssenzeDtm1.A016MW.D_Incomp_Genere,'I');
  A016FCausAssenzeDtM1.A016MW.CaricaListaCausIncomp;
  R180SetComboItemsValues(dGrdCausIncomp.Columns[2].PickList,A016FCausAssenzeDtm1.A016MW.D_Incomp_Caus,'I');
  R180SetComboItemsValues(dGrdCausIncomp.Columns[3].PickList,A016FCausAssenzeDtm1.A016MW.D_Incomp_Genere,'I');
  R180SetComboItemsValues(dGrdCausIncomp.Columns[4].PickList,A016FCausAssenzeDtm1.A016MW.D_Incomp_InclFam,'I');
  inherited;
  EFruizioneClick(nil);
  dgrdT266.DataSource:=A016FCausAssenzeDtm1.A016MW.dsrT266;
  DBCheckBox4.DataSource:=A016FCausAssenzeDtm1.A016MW.D260;
  DBLookupComboBox1.ListSource:=A016FCausAssenzeDtm1.A016MW.D260;
  ERaggruppamento.ListSource:=A016FCausAssenzeDtm1.A016MW.DCols;
  ECodCauInizio.ListSource:=A016FCausAssenzeDtM1.A016MW.D265A;
  ECauFruizione.ListSource:=A016FCausAssenzeDtM1.A016MW.D265A;
  dedtCausaleSuccessiva.ListSource:=A016FCausAssenzeDtM1.A016MW.D265A;
  dedtCausale10Giorni.ListSource:=A016FCausAssenzeDtM1.A016MW.D265A;
end;

procedure TA016FCausAssenze.DBComboBox1DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  if Control = DBComboBox1 then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A016FCausAssenzeDtM1.A016MW.D_InfCont[Index].Item)
  else if Control = DBComboBox2 then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A016FCausAssenzeDtM1.A016MW.D_ModRecupero[Index].Item)
  else if Control = ETipoCumulo then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A016FCausAssenzeDtM1.A016MW.D_Cumulo[Index].Item)
  else if Control = dcmbCumuloFamiliari then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A016FCausAssenzeDtM1.A016MW.D_FruizioneFamiliari[Index].Item)
  else if Control = dcmbFruizioneFamiliari then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A016FCausAssenzeDtM1.A016MW.D_FruizioneFamiliari[Index].Item)
  else if Control = dcmbDetReperib then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A016FCausAssenzeDtM1.A016MW.D_DetReperib[Index].Item)
  else if Control = dcmbggnnlav then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A016FCausAssenzeDtM1.A016MW.D_CopriGGNonLav[Index].Item);
end;

procedure TA016FCausAssenze.DBComboBox1Change(Sender: TObject);
begin
  DbCheckBox1.Visible:=DBComboBox1.Text = 'B';
  if (DButton.State in [dsInsert,dsEdit]) and (DBComboBox1.Text <> 'B') then
    DBCheckBox1.Field.AsString:='B';
  DbComboBox2.Enabled:=(DBComboBox1.Text = 'A') or (DBComboBox1.Text = 'C') or (DBComboBox1.Text = 'G') or (DBComboBox1.Text = 'H') or (DBComboBox1.Text = 'I');
  if (DButton.State in [dsInsert,dsEdit]) and (not DBComboBox2.Enabled) then
    DBComboBox2.Field.AsString:='0';
  dcmbDetReperib.Enabled:=(DBComboBox1.Text <> 'B') and (DBComboBox1.Text <> 'D');
  lblDetReperib.Enabled:=dcmbDetReperib.Enabled;
  if (DButton.State in [dsInsert,dsEdit]) and (not dcmbDetReperib.Enabled) then
    dcmbDetReperib.Field.AsString:='0';
  // TODO: il legame si � perso in seguito alla storicizzazione di ABBATTE_STRIND
  {
  dchkAbbatteStrInd.Enabled:=DBComboBox1.Text = 'D';
  if (DButton.State in [dsInsert,dsEdit]) and (not dchkAbbatteStrInd.Enabled) then
    dchkAbbatteStrInd.Field.AsString:='N';
  }
  if (DButton.State in [dsInsert,dsEdit]) then
  begin
    DBCheckBox8.Enabled:=not (DBComboBox1.Text = 'I');
    if DBComboBox1.Text = 'I' then
      DBCheckBox8.Field.AsString:='N';
  end;
end;

procedure TA016FCausAssenze.DBComboBox2DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A016FCausAssenzeDtM1.A016MW.D_ModRecupero[Index].Item);
end;

procedure TA016FCausAssenze.btnCausaliCollegateClick(Sender: TObject);
var S:String;
begin
  if not(DButton.State in [dsEdit,dsInsert]) then exit;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    S:=dedtCausaliCollegate.Field.AsString;
    CaricaLista;
    R180PutCheckList(S,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      dedtCausaliCollegate.Field.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    Release;
  end;
end;

procedure TA016FCausAssenze.Accedi1Click(Sender: TObject);
var
  MySQL:TStringList;
begin
  inherited;
  {selVSource viene aperto sull'evento onPopUp del popupmen�}
  MySQL:=TStringList.Create;
  with A016FCausAssenzeDtM1.A016MW do
    try
      while Not selVSource.Eof do
      begin
        MySQL.Add(StringReplace(selVSource.FieldByName('TEXT').AsString,#$D#$A,'',[rfReplaceAll]));
        selVSource.Next;
      end;
      OpenC012VisualizzaTesto(selVSource.GetVariable('SNAME'),'',MySQL);
    finally
      selVSource.Close;
      FreeAndNil(MySQL);
    end;
end;

procedure TA016FCausAssenze.actRicercaDuplicatiExecute(Sender: TObject);
begin
  C008FCercaDuplicati:=TC008FCercaDuplicati.Create(nil);
  with C008FCercaDuplicati do
  try
    ODS:=A016FCausAssenzeDtM1.T265;
    Codice:='CODICE,DESCRIZIONE';
    ShowModal;
  finally
    Free;
  end;
end;

procedure TA016FCausAssenze.dchkTimbPMClick(Sender: TObject);
begin
  inherited;
  dchkTimbPMDetraz.Enabled:=dchkTimbPM.Checked;
end;

procedure TA016FCausAssenze.dchkUnInserimentoHClick(Sender: TObject);
var i:Integer;
begin
  for i:=0 to grpVincoliFruizione.ControlCount - 1 do
    grpVincoliFruizione.Controls[i].Enabled:=dchkUnInserimentoH.Checked or dchkUnInserimentoD.Checked;
end;

procedure TA016FCausAssenze.dchkUnInserimentoMgClick(Sender: TObject);
begin
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  lblCSIMaxMG.Enabled:=dchkUnInserimentoMg.Checked;       
  dedtCSIMaxMG.Enabled:=dchkUnInserimentoMg.Checked;      
  lblCSIMaxMGMat.Enabled:=dchkUnInserimentoMg.Checked;
  dedtCSIMaxMGMat.Enabled:=dchkUnInserimentoMg.Checked;
  lblCSIMaxMGPom.Enabled:=dchkUnInserimentoMg.Checked;
  dedtCSIMaxMGPom.Enabled:=dchkUnInserimentoMg.Checked;
  if DButton.State in [dsInsert,dsEdit] then
  begin
    if not dedtCSIMaxMG.Enabled then                  
      dedtCSIMaxMG.Clear;                             
    if not dedtCSIMaxMGMat.Enabled then
      dedtCSIMaxMGMat.Clear;
    if not dedtCSIMaxMGPom.Enabled then
      dedtCSIMaxMGPom.Clear;
  end;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
end;

procedure TA016FCausAssenze.dcmbDetReperibChange(Sender: TObject);
begin
  inherited;
  dchkDetReperibIntera.Enabled:=dcmbDetReperib.ItemIndex in [1,2];
end;

procedure TA016FCausAssenze.dcmbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA016FCausAssenze.dedtVocePagheChange(Sender: TObject);
begin
  inherited;
  LblDescVoce.Caption:='';
  drgpUmScaricoPaghe.Visible:=dedtVocePaghe.Text <> '';
end;

procedure TA016FCausAssenze.dedtVocePagheExit(Sender: TObject);
begin
  inherited;
  A016FCausAssenzeDtM1.RefreshCodiceVoce;
end;

procedure TA016FCausAssenze.btnCodCau2Click(Sender: TObject);
var S:String;
begin
  if not(DButton.State in [dsEdit,dsInsert]) then exit;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    S:=dedtCodCau2.Field.AsString;
    CaricaLista;
    R180PutCheckList(S,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      dedtCodCau2.Field.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    Release;
  end;
end;

procedure TA016FCausAssenze.btnDecParStorPrecClick(Sender: TObject);
begin
  if (DButton.DataSet.State = dsBrowse) and (DButton.DataSet.RecordCount > 0)
     and (cmbDecParStor.ItemIndex > 0) then
  begin
    cmbDecParStor.ItemIndex:=(cmbDecParStor.ItemIndex - 1);
    cmbDecParStor.OnChange(nil);
  end;
end;

procedure TA016FCausAssenze.btnDecParStorSuccClick(Sender: TObject);
begin
  if (DButton.DataSet.State = dsBrowse) and (DButton.DataSet.RecordCount > 0)
      and (cmbDecParStor.ItemIndex < cmbDecParStor.Items.Count) then
  begin
    cmbDecParStor.ItemIndex:=(cmbDecParStor.ItemIndex + 1);
    cmbDecParStor.OnChange(nil);
  end;
end;

procedure TA016FCausAssenze.btnModificaParStorClick(Sender: TObject);
var
  IdCausale:Integer;
  NuovoA016StoricoDataLavoroStr:String;
begin
  if (DButton.DataSet.State = dsBrowse) and (DButton.DataSet.RecordCount > 0) then
  begin
    IdCausale:=DButton.DataSet.FieldByName('ID').AsInteger;
    NuovoA016StoricoDataLavoroStr:='';
    ToggleControlliSchedaParStor(False);
    try
      A016FCausAssenzeStorico:=TA016FCausAssenzeStorico.Create(Self);
      A016FCausAssenzeStoricoDM:=TA016FCausAssenzeStoricoDM.Create(Self,IdCausale);
      A016FCausAssenzeStorico.A016StoricoDataLavoro:=StrToDate(cmbDecParStor.Text);
      A016FCausAssenzeStorico.ShowModal;
      NuovoA016StoricoDataLavoroStr:=DateToStr(A016FCausAssenzeStorico.A016StoricoDataLavoro);
    finally
      FreeAndNil(A016FCausAssenzeStoricoDM);
      FreeAndNil(A016FCausAssenzeStorico);
      DButton.DataSet.Refresh;
      DButton.DataSet.Locate('ID',IdCausale,[]);
      if NuovoA016StoricoDataLavoroStr <> '' then
      begin
        cmbDecParStor.ItemIndex:=cmbDecParStor.Items.IndexOf(NuovoA016StoricoDataLavoroStr);
        cmbDecParStorChange(nil);
      end;
      ToggleControlliSchedaParStor(True);
    end;
  end;
end;

procedure TA016FCausAssenze.EFruibileClick(Sender: TObject);
begin
  inherited;
  dChkPropAbilitazione.Enabled:=not EFruibile.Checked;
  if (not dChkPropAbilitazione.Enabled) and (DButton.State in [dsEdit, dsInsert]) then
    A016FCausAssenzeDtM1.T265.FieldByName('PROPORZIONA_ABILITAZIONE').AsString:='N';
end;

procedure TA016FCausAssenze.BtnVocePagheClick(Sender: TObject);
begin
  inherited;
  C016FElencoVoci:=TC016FElencoVoci.Create(nil);
  C016FElencoVoci.DecorrenzaElencoVoci:=StrToDateTime('01/01/1900');
  C016FElencoVoci.TestoFiltroSql:=' AND TIPO = ''AS''';
  C016FElencoVoci.ShowModal;
  if C016FElencoVoci.ModalResult = mrOK then
  begin
    LblDescVoce.Caption:=C016FElencoVoci.DescrizioneVoceElencoVoci;
    A016FCausAssenzeDtM1.T265.Edit;
    A016FCausAssenzeDtM1.T265.FieldByName('VOCEPAGHE').AsString:=C016FElencoVoci.CodVoceElencoVoci;
    A016FCausAssenzeDtM1.RefreshCodiceVoce;
  end;
  FreeAndNil(C016FElencoVoci);
end;

procedure TA016FCausAssenze.DButtonStateChange(Sender: TObject);
begin
  inherited;
  BtnVocePaghe.Enabled:=(DButton.State in [dsInsert,dsEdit]) and (A016FCausAssenzeDtM1.A016MW.selP200.RecordCount > 0);
  A016FCausAssenzeDtM1.A016MW.selT266.ReadOnly:=not(DButton.State in [dsEdit,dsInsert]);
  A016FCausAssenzeDtM1.A016MW.selT259.ReadOnly:=not(DButton.State in [dsEdit,dsInsert]);
  DBCheckBox8.Enabled:=not (DBComboBox1.Text = 'I');
  A016FCausAssenzeDtM1.RefreshCodiceVoce;
  grpPartTime.Enabled:=(DButton.State in [dsInsert,dsEdit]);
  ImpostaPartTime;
  A016FCausAssenzeDtM1.A016MW.CaricaListaCausIncomp;
  R180SetComboItemsValues(dGrdCausIncomp.Columns[2].PickList,A016FCausAssenzeDtm1.A016MW.D_Incomp_Caus,'I');
  ToggleControlliSchedaParStor(not (DButton.State in [dsInsert,dsEdit]));
end;

procedure TA016FCausAssenze.ImpostaPartTime;
begin
  if DButton.State = dsBrowse then
  begin
    chkPartTimeO.Checked:=Pos('O',A016FCausAssenzeDtM1.T265.FieldByName('PARTTIME').AsString) > 0;
    chkPartTimeV.Checked:=Pos('V',A016FCausAssenzeDtM1.T265.FieldByName('PARTTIME').AsString) > 0;
    chkPartTimeC.Checked:=Pos('C',A016FCausAssenzeDtM1.T265.FieldByName('PARTTIME').AsString) > 0;
  end;
end;

procedure TA016FCausAssenze.btnCausaliSuccessiveClick(Sender: TObject);
begin
  if not(DButton.State in [dsEdit,dsInsert]) then exit;
end;

procedure TA016FCausAssenze.DBCheckBox10Click(Sender: TObject);
begin
  if DButton.State = dsEdit then
    R180MessageBox(A000MSG_A016_MSG_REGISTRA_STORICO,INFORMA);
end;

procedure TA016FCausAssenze.DBCheckBox15Click(Sender: TObject);
var
  vCodice: Variant;
begin
  if (DButton.State = dsEdit) and DBCheckBox15.Checked then
  begin
    if R180MessageBox(A000MSG_A016_DLG_RICHIEDI_VALIDAZIONE,'DOMANDA') = mrNo then
      begin
        DBCheckBox15.Checked:=False;
        Abort;
      end;
  end
  else
  begin
    if DButton.State = dsEdit then
      with A016FCausAssenzeDtM1 do
      begin
        A016MW.selAssDaValidare.Close;
        A016MW.selAssDaValidare.SetVariable('CODICE',T265.FieldByName('CODICE').AsString);
        A016MW.selAssDaValidare.Open;
        if A016MW.selAssDaValidare.RecordCount > 0 then
        begin
          ShowMessage(A000MSG_A016_MSG_ASSENZE_DA_VALIDARE);
          vCodice:=VarArrayOf(['','','',0,'']);
          OpenC015FElencoValori('T040_GIUSTIFICATIVI','<A016> Assenze da validare',A016MW.selAssDaValidare.SQL.Text,'COGNOME;NOME;MATRICOLA;DATA;CAUSALE',vCodice,A016MW.selAssDaValidare,660,400,False);
          DBCheckBox15.Checked:=True;
        end;
      end;
  end;
end;

procedure TA016FCausAssenze.dchkNoSuperoCompetenzeClick(Sender: TObject);
begin
  inherited;
  dchkNoSuperoCompWeb.Enabled:=not dchkNoSuperoCompetenze.Checked;
  if not dchkNoSuperoCompWeb.Enabled then
  begin
    dchkNoSuperoCompWeb.Checked:=True;
    if DButton.State in [dsEdit,dsInsert] then
      DButton.DataSet.FieldByName('NO_SUPERO_COMPETENZE_WEB').AsString:='S';
  end;
end;

procedure TA016FCausAssenze.dgrdT266EditButtonClick(Sender: TObject);
begin
  inherited;
  if not(DButton.State in [dsEdit,dsInsert]) then exit;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    CaricaLista;
    R180PutCheckList(A016FCausAssenzeDtM1.A016MW.selT266.FieldByName('CAUSALI').AsString,5,clbListaDati);
    if ShowModal = mrOK then
    begin
      if A016FCausAssenzeDtM1.A016MW.selT266.State = dsBrowse then
        A016FCausAssenzeDtM1.A016MW.selT266.Edit;
      A016FCausAssenzeDtM1.A016MW.selT266.FieldByName('CAUSALI').AsString:=R180GetCheckList(5,clbListaDati);
    end;
  finally
    Release;
  end;
end;

procedure TA016FCausAssenze.ToggleControlliSchedaParStor(Attiva:Boolean);
begin
  btnDecParStorPrec.Enabled:=Attiva;
  btnDecParStorSucc.Enabled:=Attiva;
  cmbDecParStor.Enabled:=Attiva;
  chkVistaPeriodoCorr.Enabled:=Attiva;
  btnModificaParStor.Enabled:=Attiva;
end;

end.
