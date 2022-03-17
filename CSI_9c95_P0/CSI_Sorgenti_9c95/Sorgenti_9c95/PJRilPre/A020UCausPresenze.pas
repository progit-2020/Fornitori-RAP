unit A020UCausPresenze;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, OracleData, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask,
  DBCtrls, Grids, DBGrids, ActnList, ImgList, ToolWin, C180FunzioniGenerali,
  A018URaggrPres, A000UCostanti, A000USessione,A000UInterfaccia, Variants, Math, System.Actions,
  A020UCausPresenzeStorico, A020UCausPresenzeStoricoDtM1, System.ImageList;

type
  TA020FCausPresenze = class(TR001FGestTab)
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBText1: TDBText;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    lblArrotondamento: TLabel;
    Label5: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    EOreNormali: TDBRadioGroup;
    DBCheckBox2: TDBCheckBox;
    EArrotondamento: TDBEdit;
    EScostamento: TDBEdit;
    dchkLiquidabile: TDBCheckBox;
    dchkSempreAppoggiata: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    DBEdit8: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit14: TDBEdit;
    GroupBox4: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label15: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    TabSheet4: TTabSheet;
    dGrdFasce: TDBGrid;
    pnlFasceAutParametri: TPanel;
    DBRadioGroup5: TDBRadioGroup;
    GroupBox2: TGroupBox;
    DBCheckBox5: TDBCheckBox;
    Label7: TLabel;
    Label17: TLabel;
    EMaxMinuti: TDBEdit;
    dedtMinMinuti: TDBEdit;
    DBRadioGroup7: TDBRadioGroup;
    grpGettoni: TGroupBox;
    Label18: TLabel;
    dlckGettIndennita: TDBLookupComboBox;
    lblGettOre: TLabel;
    dedtGettOre: TDBEdit;
    dgrpGettOreSup: TDBRadioGroup;
    dgrpGettOreInf: TDBRadioGroup;
    dchkGettSpezzoni: TDBCheckBox;
    rgpTipoMinMinimi: TDBRadioGroup;
    dchkLimiteDebitoGG: TDBCheckBox;
    dchkUsaFlessibilita: TDBCheckBox;
    dchkScostPuntiNominali: TDBCheckBox;
    dchkStaccoMinimoScost: TDBCheckBox;
    drgpNoEccedenzaInFascia: TDBRadioGroup;
    grpAutoCausalizzazione: TGroupBox;
    lblLinkAssenza: TLabel;
    dlblLinkAssenza: TDBText;
    dcmbLinkAssenza: TDBLookupComboBox;
    dchkCompetenzeAutoGiust: TDBCheckBox;
    dchkFlessibilitaOrario: TDBCheckBox;
    lblSogliaFasceObblFac: TLabel;
    dedtSogliaFasceObblFac: TDBEdit;
    drgpControlloTimbTurno: TDBRadioGroup;
    Panel3: TPanel;
    lblCausFuoriTurno: TLabel;
    dcmbCausFuoriTurno: TDBLookupComboBox;
    dchkEsclusioneFasciaObb: TDBCheckBox;
    lblGettoneDalle: TLabel;
    dedtGettoneDalle: TDBEdit;
    lblGettoneAlle: TLabel;
    dedtGettoneAlle: TDBEdit;
    dchkTimbPM: TDBCheckBox;
    TabSheet5: TTabSheet;
    DBRadioGroup2: TDBRadioGroup;
    ESigla: TDBEdit;
    Label6: TLabel;
    DBEdit7: TDBEdit;
    Label16: TLabel;
    dchkResiduoLiquidabile: TDBCheckBox;
    dchkNoLimiteMensileLiq: TDBCheckBox;
    DBRadioGroup4: TDBRadioGroup;
    GrpArrGG: TGroupBox;
    LblArrotondamento2: TLabel;
    DEdtArrotondamento: TDBEdit;
    dchkPerdiArr: TDBCheckBox;
    dchkArrFascie: TDBCheckBox;
    dchkEInFlessibilita: TDBCheckBox;
    dchkPercInail: TDBCheckBox;
    dchkIncludiIndTurno: TDBCheckBox;
    drgpAutogiustDalleAlle: TDBRadioGroup;
    gbxUnInserimento: TGroupBox;
    dchkUnInserimentoH: TDBCheckBox;
    dchkUnInserimentoD: TDBCheckBox;
    dchkCompCausOreMax: TDBCheckBox;
    dchkAutoCompletamentoUE: TDBCheckBox;
    drgpTipoRichiestaWeb: TDBRadioGroup;
    dchkConsideraSceltaOrario: TDBCheckBox;
    lblFlexTimbrCaus: TLabel;
    dcmbFlexTimbrCaus: TDBComboBox;
    dchkInclusioneSaldiCausali: TDBCheckBox;
    dchkForzaNotteSpezzata: TDBCheckBox;
    dchkCausalizzaTimbIntersecanti: TDBCheckBox;
    dchkTimbPMDetraz: TDBCheckBox;
    lblPeriodicitaAbbattimento: TLabel;
    dedtPeriodicitaAbbattimento: TDBEdit;
    dchkTimbFittizie: TDBCheckBox;
    drgpCumulaRichiesteWeb: TDBRadioGroup;
    drgpIntersezioneTimbrature: TDBRadioGroup;
    dchkNoEccedInFasciaConsAss: TDBCheckBox;
    lblCausCompDebitoGG: TLabel;
    dcmbCausCompDebitoGG: TDBLookupComboBox;
    TabSheet6: TTabSheet;
    pnlParStorOpzioni: TPanel;
    btnDecParStorPrec: TSpeedButton;
    btnDecParStorSucc: TSpeedButton;
    cmbDecParStor: TComboBox;
    chkVistaPeriodoCorr: TCheckBox;
    pnlParStorOpzBtn: TPanel;
    btnModificaParStor: TButton;
    pnlParStorGrid: TPanel;
    grdParamStoriciz: TStringGrid;
    procedure dedtGettoneDalleChange(Sender: TObject);
    procedure dcmbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EHMaxUnitarioChange(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure EOreNormaliChange(Sender: TObject);
    procedure dchkLiquidabileClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBRadioGroup1Change(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure dchkGettSpezzoniClick(Sender: TObject);
    procedure dchkLimiteDebitoGGClick(Sender: TObject);
    procedure dchkEsclusioneFasciaObbClick(Sender: TObject);
    procedure drgpControlloTimbTurnoChange(Sender: TObject);
    procedure DBRadioGroup4Change(Sender: TObject);
    procedure dcmbFlexTimbrCausDrawItem(Control: TWinControl;Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure dchkUnInserimentoDClick(Sender: TObject);
    procedure DBCheckBox6Click(Sender: TObject);
    procedure dchkCausalizzaTimbIntersecantiClick(Sender: TObject);
    procedure dchkTimbFittizieClick(Sender: TObject);
    procedure dchkSempreAppoggiataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdParamStoricizDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure btnDecParStorPrecClick(Sender: TObject);
    procedure btnDecParStorSuccClick(Sender: TObject);
    procedure btnModificaParStorClick(Sender: TObject);
    procedure chkVistaPeriodoCorrClick(Sender: TObject);
    procedure cmbDecParStorChange(Sender: TObject);
    procedure Copiada1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AbilitazioneControlli(Sender:TObject);
    procedure ToggleControlliSchedaParStor(Attiva:Boolean);
  end;

var
  A020FCausPresenze: TA020FCausPresenze;

procedure OpenA020CausPresenze(Cod:String);

implementation

uses A020UCausPresenzeDtM1;

{$R *.DFM}

procedure OpenA020CausPresenze(Cod:String);
{Causali di presenza}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA020CausPresenze') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A020FCausPresenze:=TA020FCausPresenze.Create(nil);
  with A020FCausPresenze do
    try
      A020FCausPresenzeDtM1:=TA020FCausPresenzeDtM1.Create(nil);
      DButton.DataSet:=A020FCausPresenzeDtM1.selT275;
      DButton.DataSet.Locate('Codice',Cod,[]);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A020FCausPresenzeDtM1.Free;
      Release;
    end;
end;

procedure TA020FCausPresenze.EHMaxUnitarioChange(Sender: TObject);
begin
  {Abblenco il campo se non contiene niente}
  if DButton.State in [dsInsert,dsEdit] then
    if (Trim((Sender as TDBEdit).Text) = '.') or (Trim((Sender as TDBEdit).Text) = '/') then
      (Sender as TDBEdit).Field.Clear;
end;

procedure TA020FCausPresenze.Nuovoelemento1Click(Sender: TObject);
{Dll di gestione Raggruppamenti assenze}
begin
  OpenA018RaggrPres((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
  A020FCausPresenzeDtM1.A020MW.selT270.Refresh;
end;

procedure TA020FCausPresenze.FormActivate(Sender: TObject);
var i:Integer;
begin
  DBGrid1.DataSource := A020FCausPresenzeDtM1.A020MW.dsrT276;
  dGrdFasce.DataSource := A020FCausPresenzeDtM1.A020MW.dsrT277;
  dcmbCausFuoriTurno.ListSource:=A020FCausPresenzeDtM1.A020MW.dsrT275lkp;
  dcmbCausCompDebitoGG.ListSource:=A020FCausPresenzeDtM1.A020MW.dsrT275lkpOreNorm;
  dlckGettIndennita.ListSource:=A020FCausPresenzeDtM1.A020MW.dsrT162;
  dcmbLinkAssenza.ListSource:= A020FCausPresenzeDtM1.A020MW.dsrT265;
  DBLookupComboBox1.ListSource := A020FCausPresenzeDtM1.A020MW.dsrT270;
  DButton.DataSet:=A020FCausPresenzeDtM1.selT275;
  R180SetComboItemsValues(dcmbFlexTimbrCaus.Items,A020FCausPresenzeDtM1.A020MW.D_FlexSogliaObblFac,'V');
  //Popolo PickList Campo TIPOGIORNO di DBGrid1
  R180SetComboItemsValues(DBGrid1.Columns[0].PickList ,A020FCausPresenzeDtM1.A020MW.D_VociSuddiviseTipoGiorno,'V');
  //Popolo PickList Campo FASCE_PN di dGrdFasce
  R180SetComboItemsValues(dGrdFasce.Columns[4].PickList ,A020FCausPresenzeDtM1.A020MW.D_FascePN,'V');
  //Popolo PickList Campo TIPOGIORNO di dGrdFasce
  for i:=0 to High(A020FCausPresenzeDtM1.A020MW.D_TipoGiorno) do
    dGrdFasce.Columns[0].PickList.add(A020FCausPresenzeDtM1.A020MW.D_TipoGiorno[i].Value+' - '+A020FCausPresenzeDtM1.A020MW.D_TipoGiorno[i].Item);
  inherited;
end;

procedure TA020FCausPresenze.FormCreate(Sender: TObject);
begin
  inherited;
  grdParamStoriciz.RowCount:=2;
  grdParamStoriciz.FixedRows:=1;
  grdParamStoriciz.ColCount:=4;
  grdParamStoriciz.DefaultRowHeight:=18;

  grdParamStoriciz.Cells[0,0]:='Dato';
  grdParamStoriciz.ColWidths[0]:=260;
  grdParamStoriciz.Cells[1,0]:='Decorrenza';
  grdParamStoriciz.ColWidths[1]:=70;
  grdParamStoriciz.Cells[2,0]:='Termine';
  grdParamStoriciz.ColWidths[2]:=70;
  grdParamStoriciz.Cells[3,0]:='Valore';
  grdParamStoriciz.ColWidths[3]:=170;
end;

procedure TA020FCausPresenze.DButtonStateChange(Sender: TObject);
begin
  inherited;
  A020FCausPresenzeDtM1.A020MW.selT276.ReadOnly:=not(DButton.State in [dsEdit]);
  A020FCausPresenzeDtM1.A020MW.selT277.ReadOnly:=not(DButton.State in [dsEdit]);
  ToggleControlliSchedaParStor(not (DButton.State in [dsInsert,dsEdit]));
end;

procedure TA020FCausPresenze.DButtonDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if Field = nil then
    AbilitazioneControlli(Sender);
end;

procedure TA020FCausPresenze.FormShow(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage:=TabSheet1;
end;

procedure TA020FCausPresenze.grdParamStoricizDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (gdSelected in State) or (gdFixed in State) then
    Exit;
  if (A020FCausPresenzeDtM1.A020StoricoMW.StoriaDati.Items[ARow - 1].IndiceDato mod 2 = 0) then
  begin
    grdParamStoriciz.Canvas.Brush.Color:=$00FFFF80;
    grdParamStoriciz.Canvas.Font.Color:=clWindowText;
    grdParamStoriciz.Canvas.FillRect(Rect);
    grdParamStoriciz.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top + 2,grdParamStoriciz.Cells[ACol,ARow]);
  end;
end;

procedure TA020FCausPresenze.dchkLiquidabileClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TA020FCausPresenze.dchkTimbFittizieClick(Sender: TObject);
begin
  inherited;
  if DButton.State in [dsEdit,dsInsert] then
    if dchkTimbFittizie.Checked then
      A020FCausPresenzeDtM1.selT275.FieldByName('CAUSALIZZA_TIMB_INTERSECANTI').AsString:='N';
end;

procedure TA020FCausPresenze.dchkUnInserimentoDClick(Sender: TObject);
begin
  inherited;
  AbilitazioneControlli(Sender);
end;

procedure TA020FCausPresenze.EOreNormaliChange(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
  if EOreNormali.ItemIndex >= 0 then
    with A020FCausPresenzeDtM1 do
      if (DButton.state in [dsInsert,dsEdit]) and (EOreNormali.Values[EOreNormali.ItemIndex] <> 'A') then
        selt275.FieldByName('Abbatte_Budget').AsString:='N';
end;

procedure TA020FCausPresenze.dchkSempreAppoggiataClick(Sender: TObject);
begin
  inherited;
  AbilitazioneControlli(Sender);
end;

procedure TA020FCausPresenze.btnDecParStorPrecClick(Sender: TObject);
begin
  if (DButton.DataSet.State = dsBrowse) and (DButton.DataSet.RecordCount > 0)
     and (cmbDecParStor.ItemIndex > 0) then
  begin
    cmbDecParStor.ItemIndex:=(cmbDecParStor.ItemIndex - 1);
    cmbDecParStor.OnChange(nil);
  end;

end;

procedure TA020FCausPresenze.btnDecParStorSuccClick(Sender: TObject);
begin
  if (DButton.DataSet.State = dsBrowse) and (DButton.DataSet.RecordCount > 0)
      and (cmbDecParStor.ItemIndex < cmbDecParStor.Items.Count - 1) then
  begin
    cmbDecParStor.ItemIndex:=(cmbDecParStor.ItemIndex + 1);
    cmbDecParStor.OnChange(nil);
  end;
end;

procedure TA020FCausPresenze.btnModificaParStorClick(Sender: TObject);
var
  IdCausale:Integer;
  NuovoA020StoricoDataLavoroStr:String;
begin
  if (DButton.DataSet.State = dsBrowse) and (DButton.DataSet.RecordCount > 0) then
  begin
    IdCausale:=DButton.DataSet.FieldByName('ID').AsInteger;
    NuovoA020StoricoDataLavoroStr:='';
    ToggleControlliSchedaParStor(False);
    try
      A020FCausPresStorico:=TA020FCausPresStorico.Create(Self);
      A020FCausPresenzeStoricoDtM1:=TA020FCausPresenzeStoricoDtM1.Create(Self,IdCausale);
      A020FCausPresStorico.A020StoricoDataLavoro:=StrToDate(cmbDecParStor.Text);
      A020FCausPresStorico.ShowModal;
      NuovoA020StoricoDataLavoroStr:=DateToStr(A020FCausPresStorico.A020StoricoDataLavoro);
    finally
      FreeAndNil(A020FCausPresenzeStoricoDtM1);
      FreeAndNil(A020FCausPresStorico);
      DButton.DataSet.Refresh;
      DButton.DataSet.Locate('ID',IdCausale,[]);
      if NuovoA020StoricoDataLavoroStr <> '' then
      begin
        cmbDecParStor.ItemIndex:=cmbDecParStor.Items.IndexOf(NuovoA020StoricoDataLavoroStr);
        cmbDecParStorChange(nil);
      end;
      ToggleControlliSchedaParStor(True);
    end;
  end;
end;

procedure TA020FCausPresenze.chkVistaPeriodoCorrClick(Sender: TObject);
begin
  if (DButton.DataSet.State = dsBrowse) and (DButton.DataSet.RecordCount > 0) then
  begin
    if chkVistaPeriodoCorr.Checked then
    begin
      cmbDecParStor.ItemIndex:=A020FCausPresenzeDtM1.A020StoricoMW.IndiceDecorrenzaCorrente;
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

procedure TA020FCausPresenze.cmbDecParStorChange(Sender: TObject);
var
  DataPeriodo:TDateTime;
begin
  A020FCausPresenzeDtM1.SvuotaGrigliaDatiStoriciz;
  if (DButton.DataSet.State = dsBrowse) and (DButton.DataSet.RecordCount > 0) then
  begin
    DataPeriodo:=StrToDate(cmbDecParStor.Text);
    A020FCausPresenzeDtM1.AggiornaGrigliaDatiStoriciz(DataPeriodo);
  end;
end;

procedure TA020FCausPresenze.Copiada1Click(Sender: TObject);
var
  IDSorgente,IDDestinazione:Integer;
begin
  IDSorgente:=DButton.DataSet.FieldByName('ID').AsInteger;
  inherited;
  if CodiceCopiaSu <> '' then
  begin
    IDDestinazione:=DButton.DataSet.FieldByName('ID').AsInteger;
    try
      A020FCausPresenzeDtM1.A020StoricoMW.CreaCopiaParametriStorici(IDSorgente,IDDestinazione);
    finally
      DButton.DataSet.Refresh;
      DButton.DataSet.Locate('ID',IDDestinazione,[]);
    end;
  end;
end;

procedure TA020FCausPresenze.DBCheckBox6Click(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TA020FCausPresenze.DBRadioGroup1Change(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TA020FCausPresenze.DBRadioGroup4Change(Sender: TObject);
begin
  inherited;
  AbilitazioneControlli(Sender);
end;

procedure TA020FCausPresenze.dchkGettSpezzoniClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TA020FCausPresenze.dchkLimiteDebitoGGClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TA020FCausPresenze.dchkCausalizzaTimbIntersecantiClick(Sender: TObject);
begin
  inherited;
  if DButton.State in [dsEdit,dsInsert] then
    if dchkCausalizzaTimbIntersecanti.Checked then
      A020FCausPresenzeDtM1.selT275.FieldByName('GIUST_DAA_TIMB').AsString:='N';
end;

procedure TA020FCausPresenze.dchkEsclusioneFasciaObbClick(Sender: TObject);
begin
  AbilitazioneControlli(Sender);
end;

procedure TA020FCausPresenze.AbilitazioneControlli(Sender:TObject);
begin
  //Opzioni - arrotondamento, fascia obbl/fac
  EArrotondamento.Enabled:=EOreNormali.ItemIndex = 0;
  lblArrotondamento.Enabled:=EOreNormali.ItemIndex = 0;
  dchkLimiteDebitoGG.Enabled:=EOreNormali.ItemIndex > 0;
  dchkNoLimiteMensileLiq.Enabled:=EOreNormali.ItemIndex in [1,3];
  drgpNoEccedenzaInFascia.Enabled:=(DBRadioGroup1.ItemIndex in [0,4]) and (EOreNormali.ItemIndex > 0) and (not dchkLimiteDebitoGG.Checked);
  dchkNoEccedInFasciaConsAss.Enabled:=drgpNoEccedenzaInFascia.Enabled;
  dchkEsclusioneFasciaObb.Enabled:=(EOreNormali.ItemIndex = 0) and (DBRadioGroup1.ItemIndex in [0,4]);
  lblSogliaFasceObblFac.Enabled:=(DBRadioGroup1.ItemIndex in [0,4]) and (EOreNormali.ItemIndex = 0);// and (not dchkEsclusioneFasciaObb.Checked);
  dedtSogliaFasceObblFac.Enabled:=lblSogliaFasceObblFac.Enabled;
  lblFlexTimbrCaus.Enabled:=(DBRadioGroup1.ItemIndex in [0,4]) and (EOreNormali.ItemIndex = 0);// and (not dchkEsclusioneFasciaObb.Checked);
  dcmbFlexTimbrCaus.Enabled:=lblFlexTimbrCaus.Enabled;
  dchkPercInail.Enabled:=EOreNormali.ItemIndex = 0;
  dchkCausalizzaTimbIntersecanti.Enabled:=dchkUnInserimentoD.Checked;
  dchkTimbFittizie.Enabled:=(dchkUnInserimentoD.Checked) (*and (DBRadioGroup1.ItemIndex in [1,2,3])*);
  if not dchkTimbFittizie.Enabled then
    dchkTimbFittizie.Checked:=False;
  dchkTimbPMDetraz.Enabled:=DBCheckBox6.Checked;
  //Abilitazione conteggio a cavallo di mezzanotte
  DBCheckBox8.Enabled:=DBRadioGroup1.ItemIndex in [0,4];
  dchkUsaFlessibilita.Enabled:=DBRadioGroup1.ItemIndex = 0;
  dchkEInFlessibilita.Enabled:=(DBRadioGroup1.ItemIndex = 0) or
                               ((DBRadioGroup1.ItemIndex in [1,2]) and dchkLiquidabile.Checked);
  if DBRadioGroup1.ItemIndex in [1,2] then
    dchkEInFlessibilita.Caption:='Non considerare l''Entrata nella flessibilità'
  else
    dchkEInFlessibilita.Caption:='Entrata posticipata in flessibilità';
  dchkScostPuntiNominali.Enabled:=DBRadioGroup1.ItemIndex = 0;
  dchkLiquidabile.Enabled:=not (DBRadioGroup1.ItemIndex in [0,4]);
  dchkSempreAppoggiata.Enabled:=not (DBRadioGroup1.ItemIndex in [0,4]);
  dchkAutoCompletamentoUE.Enabled:=DBRadioGroup1.ItemIndex = 0;
  //Abilitazione Auto-causalizzazione
  lblLinkAssenza.Enabled:=DBRadioGroup1.ItemIndex in [0,4];
  dcmbLinkAssenza.Enabled:=DBRadioGroup1.ItemIndex in [0,4];
  dlblLinkAssenza.Enabled:=DBRadioGroup1.ItemIndex in [0,4];
  dchkCompetenzeAutoGiust.Enabled:=DBRadioGroup1.ItemIndex in [0,4];
  //Abilitazione Integrazione con turni reperibilità
  with A020FCausPresenzeDtM1.A020MW do
  begin
    if selT270.SearchRecord('CODICE',VarArrayOf([selT275.FieldByName('CODRAGGR').AsString]),[srFromBeginning]) then
      drgpControlloTimbTurno.Enabled:=(DBRadioGroup1.ItemIndex in [1,2,3]) and
      ((selT270.FieldByName('CODINTERNO').AsString = 'C') or (selT270.FieldByName('CODINTERNO').AsString = 'D')or (selT270.FieldByName('CODINTERNO').AsString = 'G'))
    else
      drgpControlloTimbTurno.Enabled:=DBRadioGroup1.ItemIndex in [1,2,3];
  end;
  //Abilitazione gettoni
  R180AbilitaOggetti(grpGettoni,DBRadioGroup1.ItemIndex in [1,2,3]);
  if DBRadioGroup1.ItemIndex in [1,2,3] then
    dgrpGettOreInf.Enabled:=(not dchkGettSpezzoni.Checked) and (R180OreMinutiExt(dedtGettoneDalle.Text) = R180OreMinutiExt(dedtGettoneAlle.Text));
  if DButton.State in [dsEdit,dsInsert] then
  begin
    if not drgpNoEccedenzaInFascia.Enabled then
      drgpNoEccedenzaInFascia.Field.AsString:='N';
    if not EArrotondamento.Enabled then
      EArrotondamento.Field.Clear;
    if not dchkEsclusioneFasciaObb.Enabled then
      dchkEsclusioneFasciaObb.Field.AsString:='N';
    if not(DBRadioGroup1.ItemIndex in [0,4]) then
    begin
      DbCheckBox8.Field.AsString:='N';
      dchkUsaFlessibilita.Field.AsString:='N';
      dchkScostPuntiNominali.Field.AsString:='N';
    end;
    if not dchkEInFlessibilita.Enabled then
      dchkEInFlessibilita.Field.AsString:='N';
    if not dchkLiquidabile.Enabled then
      dchkLiquidabile.Field.AsString:='A';
    if not dchkSempreAppoggiata.Enabled then
      dchkSempreAppoggiata.Field.AsString:='N';
    if (Sender = dchkLiquidabile) and dchkLiquidabile.Checked then
      dchkSempreAppoggiata.Field.AsString:='N';
    if (Sender = dchkSempreAppoggiata) and dchkSempreAppoggiata.Checked then
      dchkLiquidabile.Field.AsString:='A';

    if not drgpControlloTimbTurno.Enabled then
      drgpControlloTimbTurno.Field.AsString:='N';
  end;
  if (DBRadioGroup4.ItemIndex >= 0)  then
    if (DBRadioGroup4.Values[DBRadioGroup4.ItemIndex] = 'B') then
      GroupBox4.Caption:='Voce da fasce contrattuali - ore rese in banca ore'
    else
      GroupBox4.Caption:='Voce da fasce contrattuali - ore rese';
  if EOreNormali.ItemIndex >= 0 then
  begin
    (*Alberto 19/08/2014: Arrotondamento abilitato anche per causali incluse nelle normali
    DEdtArrotondamento.Enabled:=EOreNormali.Values[EOreNormali.ItemIndex] = 'A';
    dchkArrFascie.Enabled:=EOreNormali.Values[EOreNormali.ItemIndex] = 'A';
    dchkPerdiArr.Enabled:=EOreNormali.Values[EOreNormali.ItemIndex] = 'A';
    LblArrotondamento2.Enabled:=EOreNormali.Values[EOreNormali.ItemIndex] = 'A';
    *)
    DBRadioGroup4.Buttons[3].Enabled:=EOreNormali.Values[EOreNormali.ItemIndex] = 'A';
    dchkInclusioneSaldiCausali.Enabled:=EOreNormali.Values[EOreNormali.ItemIndex] = 'A';
    if not dchkInclusioneSaldiCausali.Enabled then
      A020FCausPresenzeDtM1.selT275.FieldByName('INCLUSIONE_SALDI_CAUSALI').AsString:='N';
  end;
  dchkEsclusioneFasciaObb.Enabled:=(EOreNormali.ItemIndex = 0);
  lblPeriodicitaAbbattimento.Enabled:=(EOreNormali.ItemIndex = 0);
  dedtPeriodicitaAbbattimento.Enabled:=(EOreNormali.ItemIndex = 0);
end;

procedure TA020FCausPresenze.drgpControlloTimbTurnoChange(Sender: TObject);
begin
  dcmbCausFuoriTurno.Enabled:=drgpControlloTimbTurno.ItemIndex in [1,2];
  lblCausFuoriTurno.Enabled:=drgpControlloTimbTurno.ItemIndex in [1,2];
end;

procedure TA020FCausPresenze.dcmbFlexTimbrCausDrawItem(Control: TWinControl;Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A020FCausPresenzeDtM1.A020MW.D_FlexSogliaObblFac[Index].Item);
end;

procedure TA020FCausPresenze.dcmbKeyDown(Sender: TObject; var Key: Word;
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

procedure TA020FCausPresenze.dedtGettoneDalleChange(Sender: TObject);
begin
  inherited;
  dgrpGettOreInf.Enabled:=R180OreMinutiExt(dedtGettoneDalle.Text) = R180OreMinutiExt(dedtGettoneAlle.Text);
  dgrpGettOreSup.Enabled:=R180OreMinutiExt(dedtGettoneDalle.Text) = R180OreMinutiExt(dedtGettoneAlle.Text);
end;

procedure TA020FCausPresenze.ToggleControlliSchedaParStor(Attiva:Boolean);
begin
  btnDecParStorPrec.Enabled:=Attiva;
  btnDecParStorSucc.Enabled:=Attiva;
  cmbDecParStor.Enabled:=Attiva;
  chkVistaPeriodoCorr.Enabled:=Attiva;
  btnModificaParStor.Enabled:=Attiva;
end;

end.
