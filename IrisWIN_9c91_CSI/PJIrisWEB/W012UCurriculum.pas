unit W012UCurriculum;

interface

uses
  A000UInterfaccia, A000UCostanti,
  R010UPaginaWeb, R012UWebAnagrafico,
  C190FunzioniGeneraliWeb, Math,
  SysUtils, Variants, Classes, Graphics, Controls,
  IWVCLBaseContainer, IWContainer,
  IWCompButton, IWCompListbox, RegistrazioneLog,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, Oracle, OracleData,
  IWCompEdit, IWCompMemo, DB, IWVCLComponent, RpCon, RpConDS, RpSystem, RpDefine,
  RpRave, RVCsStd, RVData, RvDirectDataView, RpRender, RpRenderPDF,
  RVClass, RVProj, IWDBGrids, DBClient, medpIWDBGrid, meIWEdit, meIWComboBox,
  meIWLabel, meIWButton, meIWImageFile, meIWMemo, IWCompGrids, meIWLink,
  IWCompExtCtrls;

type
  TW012FCurriculum = class(TR012FWebAnagrafico)
    cdsSG110: TClientDataSet;
    dsrSG110: TDataSource;
    grdCurriculum: TmedpIWDBGrid;
    lblTipoEsp: TmeIWLabel;
    cmbTipoEsp: TmeIWComboBox;
    cmbDettaglioEsp: TmeIWComboBox;
    lblDettaglioEsp: TmeIWLabel;
    lblLuogo: TmeIWLabel;
    edtLuogo: TmeIWEdit;
    cmbLuoghi: TmeIWComboBox;
    lblPeriodoDal: TmeIWLabel;
    lblPeriodoAl: TmeIWLabel;
    edtDal: TmeIWEdit;
    edtAl: TmeIWEdit;
    btnStampa: TmeIWButton;
    btnInserisci: TmeIWButton;
    btnConferma: TmeIWButton;
    memDescrizione: TmeIWMemo;
    procedure btnStampaClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure cmbTipoEspChange(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnInserisciClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure grdCurriculumRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdCurriculumBeforeCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdCurriculumAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    rvSystem: TRVSystem;
    rvDWDettaglio: TRaveDataView;
    rvProject: TRVProject;
    rvPage: TRaveComponent;
    rvRenderPDF: TRvRenderPDF;
    connDettaglio: TRVDataSetConnection;
    ScalaStampa: Real;
    ListaTipoEsp, ListaDettaglioEsp, ListaLuoghi: TStringList;
    Inserimento, bPrimaVolta: Boolean;
    LungDett, LungTipo: Integer;
    function Controlli: Boolean;
    procedure GetTipoEsperienze;
    procedure GetDettaglioEsperienze;
    procedure GetLuoghi;
    procedure EsecuzioneStampa;
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
  protected
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

uses IWApplication, IWGlobal, SyncObjs;

function TW012FCurriculum.InizializzaAccesso:Boolean;
begin
  Result:=True;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
end;

procedure TW012FCurriculum.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  btnInserisci.Visible:=not SolaLettura;
  btnConferma.Visible:=not SolaLettura;
  ListaTipoEsp:=TStringList.Create;
  ListaDettaglioEsp:=TStringList.Create;
  ListaLuoghi:=TStringList.Create;
  GetTipoEsperienze;
  GetDettaglioEsperienze;
  GetLuoghi;
  bPrimaVolta:=True;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdCurriculum.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdCurriculum.medpDataSet:=WR000DM.selSG110;
end;

procedure TW012FCurriculum.RefreshPage;
begin
  VisualizzaDipendenteCorrente;
end;

procedure TW012FCurriculum.GetTipoEsperienze;
begin
  // Elenco tipologie esperienze
  ListaTipoEsp.Clear;
  cmbTipoEsp.Items.Clear;
  ListaTipoEsp.Add('');
  cmbTipoEsp.Items.Add('');
  with WR000DM.selQSQL do
  begin
    SQL.Clear;
    SQL.Text:='SELECT NVL(MAX(LENGTH(CODICE)),0) FROM SG112_DETTAGLIOESPERIENZE';
    Execute;
    LungTipo:=Field(0);
  end;
  with WR000DM.selSG111 do
  begin
    Close;
    Open;
    while not Eof do
    begin
      cmbTipoEsp.Items.Add(Format('%-' + IntToStr(LungTipo) + 's %s',
                                  [FieldByName('CODICE').AsString,
                                   FieldByName('DESCRIZIONE').AsString]));
      ListaTipoEsp.Add(FieldByName('CODICE').AsString);
      Next;
    end;
  end;
  cmbTipoEsp.ItemIndex:=0;
end;

procedure TW012FCurriculum.GetDettaglioEsperienze;
begin
  // Elenco dettaglio esperienze
  ListaDettaglioEsp.Clear;
  cmbDettaglioEsp.Items.Clear;
  ListaDettaglioEsp.Add('');
  cmbDettaglioEsp.Items.Add('');
  with WR000DM.selQSQL do
  begin
    SQL.Clear;
    SQL.Text:='SELECT NVL(MAX(LENGTH(CODICE)),0) FROM SG112_DETTAGLIOESPERIENZE';
    Execute;
    LungDett:=Field(0);
  end;
  with WR000DM.selSG112 do
  begin
    Close;
    Open;
    Filter:='TIPOESPERIENZA = ''' + Trim(Copy(cmbTipoEsp.Text,1,LungTipo)) + '''';
    Filtered:=True;
    while not Eof do
    begin
      cmbDettaglioEsp.Items.Add(Format('%-' + IntToStr(LungDett) + 's %s',
                                [FieldByName('CODICE').AsString,
                                 FieldByName('DESCRIZIONE').AsString]));
      ListaDettaglioEsp.Add(FieldByName('CODICE').AsString);
      Next;
    end;
  end;
  cmbDettaglioEsp.ItemIndex:=0;
end;

procedure TW012FCurriculum.GetLuoghi;
begin
  // Elenco luoghi esperienze
  ListaLuoghi.Clear;
  cmbLuoghi.Items.Clear;
  ListaLuoghi.Add('');
  cmbLuoghi.Items.Add('');
  with WR000DM.selSG110_Luoghi do
  begin
    Close;
    Open;
    while not Eof do
    begin
      cmbLuoghi.Items.Add(FieldByName('LUOGO').AsString);
      ListaLuoghi.Add(FieldByName('LUOGO').AsString);
      Next;
    end;
  end;
  cmbLuoghi.ItemIndex:=0;
end;

procedure TW012FCurriculum.grdCurriculumAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var i:Integer;
begin
  if not SolaLettura then
  begin
    for i:=0 to High(grdCurriculum.medpCompGriglia) do
    begin
      if (VarToStr(cdsSG110.Lookup('DBG_ROWID',grdCurriculum.medpCompGriglia[i].RowID,'DESC_STATO')) = 'Valida') and
         (Parametri.CampiRiferimento.C90_WebAutorizCurric = 'S') then
      begin
        //Componenti da eliminare
        FreeAndNil(grdCurriculum.medpCompGriglia[i].CompColonne[0]);
      end
      else
      begin
        (grdCurriculum.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=btnCancellaClick;
      end;
    end;
  end;
  Inserimento:=False;
  memDescrizione.Lines.Clear;
  cdsSG110.First;
  if cdsSG110.RecordCount > 0 then
  begin
    btnConferma.Visible:=not SolaLettura;
    DBGridColumnClick(grdCurriculum, cdsSG110.FieldByName('DBG_ROWID').AsString);
  end
  else
  begin
    edtDal.Text:='';
    edtAl.Text:='';
    edtLuogo.Text:='';
    cmbTipoEsp.ItemIndex:=0;
    cmbDettaglioEsp.ItemIndex:=0;
    cmbLuoghi.ItemIndex:=0;
    btnConferma.Visible:=False;
  end;
end;

procedure TW012FCurriculum.grdCurriculumBeforeCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
begin
  WR000DM.selSG112.Filter:='';
  WR000DM.selSG112.Filtered:=False;
end;

procedure TW012FCurriculum.grdCurriculumRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if not grdCurriculum.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  // assegnazione stili
  if (ARow > 0) and
     (UpperCase(grdCurriculum.medpColonna(AColumn).DataField) = 'DESC_STATO') and
     (ACell.Text <> '') then
    ACell.Css:=ACell.Css + ' align_center segnalazione';

  // assegnazione controlli
  if (ARow > 0) and (ARow <= High(grdCurriculum.medpCompGriglia) + 1) and (grdCurriculum.medpCompGriglia[ARow - 1].CompColonne[AColumn] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdCurriculum.medpCompGriglia[ARow - 1].CompColonne[AColumn];
  end
end;

procedure TW012FCurriculum.DBGridColumnClick(ASender: TObject; const AValue: string);
var
  C: String;
  i: Integer;
begin
  if WR000DM.selSG110.State in [dsEdit, dsInsert] then
    WR000DM.selSG110.Cancel;
  cdsSG110.Locate('DBG_ROWID',AValue,[]);
  btnInserisci.Caption:='Inserisci';
  btnConferma.Confirmation:='Confermare le variazioni dell''esperienza corrente?';
  btnConferma.Visible:=(not SolaLettura) and (cdsSG110.FieldByName('DESC_STATO').AsString <> 'Valida');
  // Descrizione
  memDescrizione.Lines.Clear;
  memDescrizione.FriendlyName:=cdsSG110.FieldByName('DBG_ROWID').AsString;
  memDescrizione.Lines.Add(cdsSG110.FieldByName('DESCRIZIONE').AsString);
  // Tipo
  C:=Trim(Copy(cdsSG110.FieldByName('DESC_TIPO').AsString, 1, Pos(' - ',cdsSG110.FieldByName('DESC_TIPO').AsString)));
  i:=ListaTipoEsp.IndexOf(C);
  cmbTipoEsp.ItemIndex:=max(i,0);
  // Dettaglio
  GetDettaglioEsperienze;
  C:=Trim(Copy(cdsSG110.FieldByName('DESC_DETTAGLIO').AsString, 1, Pos(' - ',cdsSG110.FieldByName('DESC_DETTAGLIO').AsString)));
  i:=ListaDettaglioEsp.IndexOf(C);
  cmbDettaglioEsp.ItemIndex:=max(i,0);
  // Date
  edtDal.Text:=cdsSG110.FieldByName('INIZIO_ESPERIENZA').AsString;
  edtAl.Text:=cdsSG110.FieldByName('FINE_ESPERIENZA').AsString;
  // Luogo
  C:=Trim(cdsSG110.FieldByName('LUOGO_ESPERIENZA').AsString);
  i:=ListaLuoghi.IndexOf(C);
  cmbLuoghi.ItemIndex:=max(i,0);
end;

procedure TW012FCurriculum.VisualizzaDipendenteCorrente;
begin
  inherited;
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  with WR000DM.selSG110 do
  begin
    Close;
    SetVariable('FILTRO','AND SG110.PROGRESSIVO = ' + IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger));
    SetVariable('DATALAVORO', Parametri.DataLavoro);
    Open;
  end;
  grdCurriculum.medpCreaCDS;
  grdCurriculum.medpEliminaColonne;
  grdCurriculum.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdCurriculum.medpAggiungiColonna('DESC_STATO','Stato','',nil);
  grdCurriculum.medpAggiungiColonna('INIZIO_ESPERIENZA','Dal','',nil);
  grdCurriculum.medpAggiungiColonna('FINE_ESPERIENZA','Al','',nil);
  grdCurriculum.medpAggiungiColonna('DESC_TIPO','Tipo Esp.','',nil);
  grdCurriculum.medpAggiungiColonna('DESC_DETTAGLIO','Dettaglio Esp.','',nil);
  grdCurriculum.medpAggiungiColonna('LUOGO_ESPERIENZA','Luogo Esp.','',nil);
  grdCurriculum.medpAggiungiColonna('DESCRIZIONE','Descrizione','',nil);
  grdCurriculum.medpColonna('DESC_STATO').Visible:=Parametri.CampiRiferimento.C90_WebAutorizCurric <> 'N';
  grdCurriculum.medpColonna('DESCRIZIONE').Visible:=False;
  grdCurriculum.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdCurriculum.medpInizializzaCompGriglia;
  if not SolaLettura then
    grdCurriculum.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null');
  grdCurriculum.medpCaricaCDS;
end;

procedure TW012FCurriculum.IWAppFormRender(Sender: TObject);
begin
  inherited;
  if (WR000DM.selSG110.RecordCount = 0) and bPrimaVolta then
  begin
    btnInserisciClick(nil);
    bPrimaVolta:=False;
  end;
end;

procedure TW012FCurriculum.cmbTipoEspChange(Sender: TObject);
begin
  inherited;
  GetDettaglioEsperienze;
end;

procedure TW012FCurriculum.btnConfermaClick(Sender: TObject);
var
  C, T, D: String;
  Dal, Al: TDateTime;
begin
  inherited;
  if not Controlli then
    exit;
  Dal:=StrToDate(edtDal.Text);
  if edtAl.Text <> '' then
    Al:=StrToDate(edtAl.Text)
  else
    Al:=StrToDate('31/12/3999');
  btnInserisci.Caption:='Inserisci';
  btnStampa.Enabled:=True;
  with WR000DM.selSG110 do
  begin
    if Inserimento then
    begin
      Append;
      FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName
        ('PROGRESSIVO').AsInteger;
    end
    else
    begin
      SearchRecord('ROWID', memDescrizione.FriendlyName, [srFromBeginning]);
      Edit;
    end;
    FieldByName('DATA_REGISTRAZIONE').AsDateTime:=Now;
    T:=Trim(Copy(StringReplace(cmbTipoEsp.Text, SPAZIO, ' ', [rfReplaceAll]),
        1, LungTipo));
    FieldByName('TIPOESPERIENZA').AsString:=T;
    D:=Trim(Copy(StringReplace(cmbDettaglioEsp.Text, SPAZIO, ' ',
          [rfReplaceAll]), 1, LungDett));
    FieldByName('DETTAGLIOESPERIENZA').AsString:=D;
    C:=Trim(StringReplace(cmbLuoghi.Text, SPAZIO, ' ', [rfReplaceAll]));
    if Trim(edtLuogo.Text) <> '' then
      FieldByName('LUOGO_ESPERIENZA').AsString:=edtLuogo.Text
    else
      FieldByName('LUOGO_ESPERIENZA').AsString:=C;
    FieldByName('INIZIO_ESPERIENZA').AsDateTime:=Dal;
    FieldByName('FINE_ESPERIENZA').AsDateTime:=Al;
    FieldByName('DESCRIZIONE').AsString:=memDescrizione.Lines.Text;
    FieldByName('ORIGINE').AsString:='D';
    if Parametri.CampiRiferimento.C90_WebAutorizCurric = 'N' then
      FieldByName('STATO').AsString:='I'
    else
      FieldByName('STATO').AsString:='R';
    FieldByName('INCLUDI_STAMPA').AsString:='S';
    if Inserimento then
      RegistraLog.SettaProprieta('I','SG110_CURRICULUM',medpCodiceForm,WR000DM.selSG110,True)
    else
      RegistraLog.SettaProprieta('M','SG110_CURRICULUM',medpCodiceForm,WR000DM.selSG110,True);
    try
      Post;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      Cancel;
    end;
  end;
  edtLuogo.Text:='';
  GetLuoghi;
  VisualizzaDipendenteCorrente;
end;

function TW012FCurriculum.Controlli: Boolean;
begin
  Result:=False;
  if cmbTipoEsp.ItemIndex = 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Specificare il tipo di esperienza!');
    exit;
  end;
  if cmbDettaglioEsp.ItemIndex = 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Specificare il dettaglio dell''esperienza!');
    exit;
  end;
  if (cmbLuoghi.ItemIndex = 0) and (Trim(edtLuogo.Text) = '') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Specificare il luogo dell''esperienza!');
    exit;
  end;
  if Trim(edtDal.Text) = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Specificare la data di inizio dell''esperienza!');
    exit;
  end;
  if edtAl.Text <> '' then
  begin
    if StrToDate(edtAl.Text) < StrToDate(edtDal.Text) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Il periodo indicato non è corretto!');
      exit;
    end;
  end;
  Result:=True;
end;

procedure TW012FCurriculum.btnInserisciClick(Sender: TObject);
begin
  if btnInserisci.Caption = 'Inserisci' then
  begin
    Inserimento:=True;
    memDescrizione.Lines.Clear;
    edtDal.Text:='';
    edtAl.Text:='';
    edtLuogo.Text:='';
    // se esiste una sola esperienza la seleziona automaticamente
    if cmbTipoEsp.Items.Count = 2 then
    begin
      cmbTipoEsp.ItemIndex:=1;
      cmbTipoEspChange(cmbTipoEsp);
    end
    else
      cmbTipoEsp.ItemIndex:=0;
    cmbDettaglioEsp.ItemIndex:=0;
    cmbLuoghi.ItemIndex:=0;
    btnInserisci.Caption:='Annulla';
    btnConferma.Visible:=not SolaLettura;
    btnConferma.Confirmation:='Inserire l''esperienza nel periodo specificato?';
    btnStampa.Enabled:=False;
  end
  else
  begin
    Inserimento:=False;
    btnInserisci.Caption:='Inserisci';
    btnConferma.Confirmation:='Confermare le variazioni dell''esperienza corrente?';
    btnStampa.Enabled:=True;
    WR000DM.selSG110.Cancel;
    VisualizzaDipendenteCorrente;
  end;
end;

procedure TW012FCurriculum.btnCancellaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  with WR000DM.selSG110 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      DBGridColumnClick(Sender,FN);
      RegistraLog.SettaProprieta('C','SG110_CURRICULUM',medpCodiceForm,WR000DM.selSG110,True);
      Delete;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    end;
  end;
  GetLuoghi;
  VisualizzaDipendenteCorrente;
end;

procedure TW012FCurriculum.btnStampaClick(Sender: TObject);
begin
  EsecuzioneStampa;
end;

procedure TW012FCurriculum.EsecuzioneStampa;
var
  rvComp: TRaveComponent;
  L: TStringList;
  NomeFile, Mat: String;
  dconnDettaglio: TRaveDataConnection;
begin
  CSStampa.Enter;
  rvSystem:=TRVSystem.Create(Self);
  rvProject:=TRVProject.Create(Self);
  connDettaglio:=TRVDataSetConnection.Create(Self);
  rvRenderPDF:=TRvRenderPDF.Create(Self);
  L:=TStringList.Create;
  try
    rvProject.Engine:=rvSystem;
    rvRenderPDF.Active:=True;
    rvProject.ProjectFile:=gSC.ContentPath + 'report\W012StampaCurriculum.rav';
    connDettaglio.Name:='connDettaglio';
    connDettaglio.DataSet:=WR000DM.SelCurriculum;
    connDettaglio.RuntimeVisibility:=RpCon.rtNone;
    // Posizionamento sulla matricola correntemente selezionata
    Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
    With WR000DM do
    begin
      SelCurriculum.Close;
      SelCurriculum.SetVariable('MATRICOLA', Mat);
      SelCurriculum.Open;
    end;
    rvProject.Open;
    rvProject.GetReportList(L, True);
    rvProject.SelectReport(L[0], True);
    rvDWDettaglio:=(rvProject.ProjMan.FindRaveComponent('dwDettaglio',
        nil) as TRaveDataView);
    // Impostazioni dei campi di Dettaglio
    dconnDettaglio:=CreateDataCon(connDettaglio);
    rvDWDettaglio.ConnectionName:=dconnDettaglio.Name;
    rvDWDettaglio.DataCon:=dconnDettaglio;
    CreateFields(rvDWDettaglio, nil, nil, True);
    rvPage:=rvProject.ProjMan.FindRaveComponent('W012.Page', nil);
    // Impostazioni della banda bndTitolo
    rvComp:=rvProject.ProjMan.FindRaveComponent('lblAzienda', rvPage);
    (rvComp as TRaveText).Text:=Parametri.RagioneSociale;
    rvComp:=rvProject.ProjMan.FindRaveComponent('lblTitolo', rvPage);
   (rvComp as TRaveText).Text:='CURRICULUM VITAE';
    // Impostazioni della banda bndIntestazione
    ScalaStampa:=0.2 / 18;
    // Generazione del file PDF
    rvSystem.SystemSetups:=rvSystem.SystemSetups - [ssAllowSetup];
    rvSystem.SystemOptions:=rvSystem.SystemOptions - [soShowStatus,soPreviewModal];
    rvSystem.DefaultDest:=rdFile;
    rvSystem.DoNativeOutput:=False;
    rvSystem.RenderObject:=rvRenderPDF;
    if W000ParConfig.RaveStreamMode = INI_RAVE_STREAM_MODE_TEMPFILE then
      rvSystem.SystemFiler.StreamMode:=smTempFile
    else
      rvSystem.SystemFiler.StreamMode:=smMemory;
    NomeFile:=GetNomeFile('pdf');
    rvSystem.OutputFileName:=NomeFile;
    ForceDirectories(ExtractFileDir(rvSystem.OutputFileName));
    rvProject.Execute;
    VisualizzaFile(NomeFile,'Anteprima stampa curriculum',nil,nil);
  finally
    L.Free;
    rvProject.Close;
    FreeAndNil(dconnDettaglio);
    FreeAndNil(rvSystem);
    FreeAndNil(rvRenderPDF);
    FreeAndNil(rvProject);
    FreeAndNil(connDettaglio);
    CSStampa.Leave;
  end;
end;

procedure TW012FCurriculum.DistruggiOggetti;
begin
  if ListaTipoEsp <> nil then
    FreeAndNil(ListaTipoEsp);
  if ListaDettaglioEsp <> nil then
    FreeAndNil(ListaDettaglioEsp);
  if ListaLuoghi <> nil then
    FreeAndNil(ListaLuoghi);

  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    try WR000DM.selSG110.CloseAll; except end;
    try WR000DM.selSG111.CloseAll; except end;
    try WR000DM.selSG112.CloseAll; except end;
    try WR000DM.selSG110_Luoghi.CloseAll; except end;
  end;
end;

end.