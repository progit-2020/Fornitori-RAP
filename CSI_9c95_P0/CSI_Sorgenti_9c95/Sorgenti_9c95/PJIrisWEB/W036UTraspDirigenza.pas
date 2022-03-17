unit W036UTraspDirigenza;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R012UWebAnagrafico, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, StrUtils,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompExtCtrls, meIWEdit,
  meIWImageFile, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, Data.DB, OracleData,
  Datasnap.DBClient, IWCompGrids, IWDBGrids, medpIWDBGrid, meIWGrid, meIWDBEdit, meIWMemo,
  A000UInterfaccia, W036UTraspDirigenzaDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  MedpIWMultiColumnComboBox, IWCompEdit, IWVCLBaseContainer, Math,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion,
  medpIWTabControl, W036UEsperienzeFM, IWCompCheckbox, IWDBStdCtrls,
  meIWDBCheckBox, meIWCheckBox, A000UCostanti,
  RpCon, RpConDS, RpDefine, RpRave, RpRenderPDF,
  RvClass, RvCsDraw, RvCsStd, RvData, RvDirectDataView, RpSystem,
  medpIWImageButton;

type
  TW036FTraspDirigenza = class(TR012FWebAnagrafico)
    grdTabDetail: TmedpIWTabControl;
    W036EsperienzeRG: TmeIWRegion;
    grdIncaricoAttuale: TmedpIWDBGrid;
    grdEsperienzePrecedenti: TmedpIWDBGrid;
    W036IstruzioneRG: TmeIWRegion;
    grdTitoloStudio: TmedpIWDBGrid;
    grdLingue: TmedpIWDBGrid;
    grdCapacitaTecnologiche: TmedpIWDBGrid;
    grdAltro: TmedpIWDBGrid;
    tpEsperienze: TIWTemplateProcessorHTML;
    tpIstruzione: TIWTemplateProcessorHTML;
    W036InconferibilitaRG: TmeIWRegion;
    tpInconferibilita: TIWTemplateProcessorHTML;
    tpIncompatibilita: TIWTemplateProcessorHTML;
    lblInconfSottoscritto: TmeIWLabel;
    lblInconfPresso: TmeIWLabel;
    W036IncompatibilitaRG: TmeIWRegion;
    lblIncompSottoscritto: TmeIWLabel;
    dchkInconfSentenze: TmeIWDBCheckBox;
    dchkInconfNo: TmeIWDBCheckBox;
    dchkInconfSi: TmeIWDBCheckBox;
    dchkIncompSentenze: TmeIWDBCheckBox;
    dchkIncompNo: TmeIWDBCheckBox;
    dedtInconfIncarico: TmeIWDBEdit;
    dedtInconfAmm: TmeIWDBEdit;
    lblInconfSentenze: TmeIWLabel;
    lblInconfNo: TmeIWLabel;
    lblInconfSi: TmeIWLabel;
    lblIncompSentenze: TmeIWLabel;
    lblIncompNo: TmeIWLabel;
    lblIncompComunicare: TmeIWLabel;
    lblInconfComunicare: TmeIWLabel;
    lblIncompPDF: TmeIWLabel;
    lblInconfPDF: TmeIWLabel;
    lblIncompDichiara: TmeIWLabel;
    lblInconfDichiara: TmeIWLabel;
    lblInconfImpegna: TmeIWLabel;
    lblIncompImpegna: TmeIWLabel;
    cdsDichiarazione: TClientDataSet;
    btnIncompModifica: TmedpIWImageButton;
    btnIncompConferma: TmedpIWImageButton;
    btnIncompAnnulla: TmedpIWImageButton;
    btnIncompStampa: TmedpIWImageButton;
    btnInconfModifica: TmedpIWImageButton;
    btnInconfConferma: TmedpIWImageButton;
    btnInconfAnnulla: TmedpIWImageButton;
    lblInconfRinnovare: TmeIWLabel;
    lblIncompRinnovare: TmeIWLabel;
    lblIncompDichiara1: TmeIWLabel;
    lblIncompDichiara2: TmeIWLabel;
    lblInconfDichiara1: TmeIWLabel;
    lblInconfDichiara2: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    function GrigliaBeforeOperazione(Sender: TObject): Boolean;
    procedure grdIncaricoAttualeAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdEsperienzePrecedentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdTitoloStudioDataSet2Componenti(Row: Integer);
    procedure grdTitoloStudioComponenti2DataSet(Row: Integer);
    procedure grdLingueDataSet2Componenti(Row: Integer);
    procedure grdCapacitaTecnologicheDataSet2Componenti(Row: Integer);
    procedure grdCapacitaTecnologicheComponenti2DataSet(Row: Integer);
    procedure grdAltroDataSet2Componenti(Row: Integer);
    procedure grdAltroComponenti2DataSet(Row: Integer);
    procedure ModificaDichiarazioniClick(Sender: TObject);
    procedure ConfermaDichiarazioniClick(Sender: TObject);
    procedure AnnullaDichiarazioniClick(Sender: TObject);
    procedure StampaDichiarazioniClick(Sender: TObject);
    procedure chkInconfNoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkInconfSiAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    { Private declarations }
    W036DM: TW036FTraspDirigenzaDM;
    W036Esp: TW036FEsperienzeFM;
    CodeAC: String;
    NomeFile: String;
    rvSystem: TRVSystem;
    rvDWDichiarazione: TRaveDataView;
    rvProject: TRVProject;
    connDichiarazione: TRVDataSetConnection;
    rvPage: TRaveComponent;
    rvRenderPDF: TRvRenderPDF;
    procedure AbilitaComponenti;
    procedure PreparaGriglia(Griglia:TmedpIWDBGrid;DataSet:TOracleDataSet);
    procedure PreparaComponenti(Griglia:TmedpIWDBGrid);
    procedure imgInserisciIncaricoAttualeClick(Sender: TObject);
    procedure imgModificaIncaricoAttualeClick(Sender: TObject);
    procedure imgAccediIncaricoAttualeClick(Sender: TObject);
    procedure imgInserisciEsperienzePrecedentiClick(Sender: TObject);
    procedure imgModificaEsperienzePrecedentiClick(Sender: TObject);
    procedure imgAccediEsperienzePrecedentiClick(Sender: TObject);
    procedure CreaFrame(Griglia:TmedpIWDBGrid;Operazione,FN:String);
    procedure DataSet2Memo(Griglia:TmedpIWDBGrid;NomeLogico:String;r:Integer);
    procedure Memo2DataSet(Griglia:TmedpIWDBGrid;NomeLogico:String;r:Integer);
    procedure CaricaJQAutocomplete(Griglia:TmedpIWDBGrid;r:Integer);
    procedure ImpostaTestoJQ(NomeLogico:String;NomeComponente:String);
    procedure CreaClientDataset;
    procedure CaricaClientDataset;
    procedure EsecuzioneStampa;
    procedure VisualizzaStampa(NomeFile: String);
  protected
    procedure VisualizzaDipendenteCorrente; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
    procedure GetCurriculum;
    procedure AbilitaJqAutocomplete(Val:Boolean);
  end;

implementation

uses IWApplication, IWGlobal, SyncObjs;

{$R *.dfm}

function TW036FTraspDirigenza.InizializzaAccesso:Boolean;
begin
  // inizializzazioni
  Result:=True;
  CampiV430:=CampiV430 + IfThen(CampiV430 <> '',',') + 'T030.SESSO';
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
end;

procedure TW036FTraspDirigenza.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  W036DM:=TW036FTraspDirigenzaDM.Create(nil);
  W036DM.selAnagrafeW:=selAnagrafeW;

  grdTabDetail.AggiungiTab('Esperienze professionali',W036EsperienzeRG);
  grdTabDetail.AggiungiTab('Formazione',W036IstruzioneRG);
  grdTabDetail.AggiungiTab('Incompatibilità',W036IncompatibilitaRG);
  grdTabDetail.AggiungiTab('Inconferibilità',W036InconferibilitaRG);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=W036EsperienzeRG;

  PreparaGriglia(grdIncaricoAttuale,W036DM.selSG210a);
  PreparaGriglia(grdEsperienzePrecedenti,W036DM.selSG210b);
  PreparaGriglia(grdTitoloStudio,W036DM.selSG211a);
  PreparaGriglia(grdLingue,W036DM.selSG212);
  PreparaGriglia(grdCapacitaTecnologiche,W036DM.selSG211b);
  PreparaGriglia(grdAltro,W036DM.selSG211z);
end;

procedure TW036FTraspDirigenza.IWAppFormRender(Sender: TObject);
var i:Integer;
begin
  inherited;
  with W036DM do
  begin
    btnIncompStampa.Confirmation:=IfThen((selSG210a.RecordCount > 0) and selSG213.FieldByName('DATA_COMPILAZIONE').IsNull and not SolaLettura,'Attenzione! Si è certi di voler confermare la dichiarazione senza effettuare variazioni?','');
    for i:=0 to grdTabDetail.TabCount - 1 do
      grdTabDetail.TabByIndex(i).Enabled:=(    (i in [0,1])
                                           and (selSG213.State = dsBrowse))
                                          or
                                          ((i in [2,3])
                                           and (selSG213.RecordCount > 0)
                                           and (selSG210a.State = dsBrowse)
                                           and (selSG210b.State = dsBrowse)
                                           and (selSG211a.State = dsBrowse)
                                           and (selSG212.State = dsBrowse)
                                           and (selSG211b.State = dsBrowse)
                                           and (selSG211z.State = dsBrowse));
  end;
end;

procedure TW036FTraspDirigenza.VisualizzaDipendenteCorrente;
// aggiorna la visualizzazione della pianificazione per il dipendente selezionato
begin
  inherited;
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  W036DM.CaricaListaValori('EMAIL_UFFICIO');//Tale lista contiene valori legati al dipendente corrente
  GetCurriculum;
end;

procedure TW036FTraspDirigenza.GetCurriculum;
// caricamento array della pianificazione giornaliera nel periodo indicato
begin
  with W036DM do
  begin
    R180SetVariable(selSG210a,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selSG210a.Open;
    R180SetVariable(selSG210b,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selSG210b.Open;
    R180SetVariable(selSG211a,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selSG211a.Open;
    R180SetVariable(selSG212,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selSG212.Open;
    R180SetVariable(selSG211b,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selSG211b.Open;
    R180SetVariable(selSG211z,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selSG211z.Open;
    R180SetVariable(selV430a,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    try
      selV430a.Open;
    except
    end;
    R180SetVariable(selSG213,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selSG213,'DATA_VALIDITA',StrToDate(ValoreDefault('#DICHIARAZIONE_DATA_SCADENZA')) + 1);//Potrebbe dipendere dal selV430a
    selSG213.Open;
  end;
  grdIncaricoAttuale.medpAggiornaCDS;
  grdEsperienzePrecedenti.medpAggiornaCDS;
  if W036DM.EspPrecRowid <> '' then
  begin
    grdEsperienzePrecedenti.medpColumnClick(nil,W036DM.EspPrecRowid);
    W036DM.EspPrecRowid:='';
  end;
  grdTitoloStudio.medpAggiornaCDS;
  grdLingue.medpAggiornaCDS;
  grdCapacitaTecnologiche.medpAggiornaCDS;
  grdAltro.medpAggiornaCDS;
  grdTabDetail.TabByIndex(2).LinkVisible:=W036DM.AbilitaDichiarazioni('#INCOMPATIBILITA');
  grdTabDetail.TabByIndex(3).LinkVisible:=W036DM.AbilitaDichiarazioni('#INCONFERIBILITA');
  //Se necessario, creo il record per le dichiarazioni
  with W036DM.selSG213 do
    if (RecordCount = 0)
    and (grdTabDetail.TabByIndex(2).LinkVisible or grdTabDetail.TabByIndex(3).LinkVisible)
    and (Trunc(R180Sysdate(SessioneOracle)) >= GetVariable('DATA_VALIDITA'))
    and not SolaLettura then
    begin
      Append;
      BeforePost:=nil;
      AfterPost:=nil;
      Post;
      BeforePost:=W036DM.selSG210a.BeforePost;
      AfterPost:=W036DM.selSG210a.AfterPost;
    end;
  AbilitaComponenti;
end;

procedure TW036FTraspDirigenza.AbilitaComponenti;
begin
  with W036DM.selSG213 do
  begin
    dedtInconfIncarico.Enabled:=FieldByName('INCONFERIBILITA').AsString = 'S';
    if not dedtInconfIncarico.Enabled and (State = dsEdit) then
      FieldByName(dedtInconfIncarico.DataField).Clear;
    dedtInconfAmm.Enabled:=FieldByName('INCONFERIBILITA').AsString = 'S';
    if not dedtInconfAmm.Enabled and (State = dsEdit) then
      FieldByName(dedtInconfAmm.DataField).Clear;

    btnIncompModifica.Visible:=not SolaLettura and (State = dsBrowse);
    btnIncompConferma.Visible:=State = dsEdit;
    btnIncompAnnulla.Visible:=State = dsEdit;
    btnIncompStampa.Visible:=State = dsBrowse;
    btnInconfModifica.Visible:=not SolaLettura and (State = dsBrowse);
    btnInconfConferma.Visible:=State = dsEdit;
    btnInconfAnnulla.Visible:=State = dsEdit;
  end;
end;

procedure TW036FTraspDirigenza.PreparaGriglia(Griglia:TmedpIWDBGrid;DataSet:TOracleDataSet);
begin
  Griglia.medpPaginazione:=False;
  Griglia.medpDataset:=DataSet;
  DataSet.Open;
  Griglia.medpComandiCustom:=(Griglia = grdIncaricoAttuale) or (Griglia = grdEsperienzePrecedenti);
  Griglia.medpAttivaGrid(DataSet,not SolaLettura,not SolaLettura,not SolaLettura);
  PreparaComponenti(Griglia);
end;

procedure TW036FTraspDirigenza.PreparaComponenti(Griglia:TmedpIWDBGrid);
begin
  with Griglia do
  begin
    medpCancellaRigaWR102;
    medpPreparaComponentiDefault;
    if (Griglia = grdIncaricoAttuale)
    or (Griglia = grdEsperienzePrecedenti) then
    begin
      medpPreparaComponenteGenerico('R',0,4,DBG_IMG,'','ACCEDI','Accedi','','D');
      Griglia.medpCaricaCDS;//Necessario perché queste griglie hanno il medpComandiCustom
    end
    else if Griglia = grdTitoloStudio then
      medpPreparaComponenteGenerico('WR102',medpIndexColonna('TESTO'),0,DBG_MEMO,'80','','','','S')
    else if (Griglia = grdCapacitaTecnologiche)
    or (Griglia = grdAltro) then
      medpPreparaComponenteGenerico('WR102',medpIndexColonna('TESTO'),0,DBG_MEMO,'80','','','','S');
  end;
end;

function TW036FTraspDirigenza.GrigliaBeforeOperazione(Sender: TObject): Boolean;
var Operazione:String;
begin
  inherited;
  Result:=True;
  Operazione:=IfThen((Sender as TmeIWImageFile).Hint = 'Inserisci','Inserimento',IfThen((Sender as TmeIWImageFile).Hint = 'Modifica','Modifica',IfThen((Sender as TmeIWImageFile).Hint = 'Accedi','Accesso','Cancellazione')));
  if (grdTitoloStudio.medpStato <> msBrowse)
  or (grdLingue.medpStato <> msBrowse)
  or (grdCapacitaTecnologiche.medpStato <> msBrowse)
  or (grdAltro.medpStato <> msBrowse) then
  //grdIncaricoAttuale e grdEsperienzePrecedenti non sono elencate perché, visualizzando il frame, bloccano le operazioni delle altre griglie
    raise Exception.Create(Operazione + ' impossibile! E'' necessario completare oppure annullare l''operazione in corso prima di procedere!');
end;

procedure TW036FTraspDirigenza.grdIncaricoAttualeAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i:Integer;
begin
  inherited;
  with grdIncaricoAttuale do
  begin
    if not SolaLettura then
    begin
      (medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciIncaricoAttualeClick;
      (medpCompCella(0,0,0) as TmeIWImageFile).Confirmation:=IfThen((medpDataSet.RecordCount > 0) and (W036DM.ControlloCampiObbligatori(grdEsperienzePrecedenti.medpDataSet,medpDataSet) = ''),
        'Attenzione! Inserendo un nuovo Incarico attuale, quello caricato in precedenza verrà spostato tra le Esperienze precedenti. Proseguire?');
    end;
    for i:=IfThen(medpComandiInsert,1,0) to High(medpCompGriglia) do
    begin
      //Associo l'evento OnClick alle icone dei comandi
      if not SolaLettura then
        if (medpCompGriglia[i].CompColonne[0] <> nil) then
          (medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgModificaIncaricoAttualeClick;
      if (medpCompGriglia[i].CompColonne[0] <> nil) then
        (medpCompCella(i,0,4) as TmeIWImageFile).OnClick:=imgAccediIncaricoAttualeClick;
    end;
  end;
end;

procedure TW036FTraspDirigenza.imgInserisciIncaricoAttualeClick(Sender: TObject);
var CampoObbl:String;
begin
  if not GrigliaBeforeOperazione(Sender) then
    Exit;
  with grdIncaricoAttuale do
    if (medpDataSet.RecordCount > 0) then
    begin
      CampoObbl:=W036DM.ControlloCampiObbligatori(grdEsperienzePrecedenti.medpDataSet,medpDataSet);
      W036DM.DataOldIncAtt:=medpDataSet.FieldByName('DECORRENZA').AsDateTime;
    end;
  if CampoObbl <> '' then
    raise exception.Create('Compilare il campo "' + CampoObbl + '" per l''"Incarico attuale" già presente, prima di inserirne uno nuovo!');
  CreaFrame(grdIncaricoAttuale,'I',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW036FTraspDirigenza.imgModificaIncaricoAttualeClick(Sender: TObject);
begin
  if not GrigliaBeforeOperazione(Sender) then
    Exit;
  CreaFrame(grdIncaricoAttuale,'M',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW036FTraspDirigenza.imgAccediIncaricoAttualeClick(Sender: TObject);
begin
  if not GrigliaBeforeOperazione(Sender) then
    Exit;
  CreaFrame(grdIncaricoAttuale,'A',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW036FTraspDirigenza.grdEsperienzePrecedentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i:Integer;
begin
  inherited;
  with grdEsperienzePrecedenti do
  begin
    if not SolaLettura then
      (medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciEsperienzePrecedentiClick;
    for i:=IfThen(medpComandiInsert,1,0) to High(medpCompGriglia) do
    begin
      //Associo l'evento OnClick alle icone dei comandi
      if not SolaLettura then
        if (medpCompGriglia[i].CompColonne[0] <> nil) then
          (medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgModificaEsperienzePrecedentiClick;
      if (medpCompGriglia[i].CompColonne[0] <> nil) then
        (medpCompCella(i,0,4) as TmeIWImageFile).OnClick:=imgAccediEsperienzePrecedentiClick;
    end;
  end;
end;

procedure TW036FTraspDirigenza.imgInserisciEsperienzePrecedentiClick(Sender: TObject);
begin
  if not GrigliaBeforeOperazione(Sender) then
    Exit;
  CreaFrame(grdEsperienzePrecedenti,'I',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW036FTraspDirigenza.imgModificaEsperienzePrecedentiClick(Sender: TObject);
begin
  if not GrigliaBeforeOperazione(Sender) then
    Exit;
  CreaFrame(grdEsperienzePrecedenti,'M',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW036FTraspDirigenza.imgAccediEsperienzePrecedentiClick(Sender: TObject);
begin
  if not GrigliaBeforeOperazione(Sender) then
    Exit;
  CreaFrame(grdEsperienzePrecedenti,'A',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW036FTraspDirigenza.grdTitoloStudioDataSet2Componenti(Row: Integer);
begin
  DataSet2Memo(grdTitoloStudio,'TESTO',Row);
  CaricaJQAutocomplete(grdTitoloStudio,Row);
end;

procedure TW036FTraspDirigenza.grdTitoloStudioComponenti2DataSet(Row: Integer);
begin
  Memo2DataSet(grdTitoloStudio,'TESTO',Row);
end;

procedure TW036FTraspDirigenza.grdLingueDataSet2Componenti(Row: Integer);
begin
  CaricaJQAutocomplete(grdLingue,Row);
end;

procedure TW036FTraspDirigenza.grdCapacitaTecnologicheDataSet2Componenti(Row: Integer);
begin
  DataSet2Memo(grdCapacitaTecnologiche,'TESTO',Row);
end;

procedure TW036FTraspDirigenza.grdCapacitaTecnologicheComponenti2DataSet(Row: Integer);
begin
  Memo2DataSet(grdCapacitaTecnologiche,'TESTO',Row);
end;

procedure TW036FTraspDirigenza.grdAltroDataSet2Componenti(Row: Integer);
begin
  DataSet2Memo(grdAltro,'TESTO',Row);
end;

procedure TW036FTraspDirigenza.grdAltroComponenti2DataSet(Row: Integer);
begin
  Memo2DataSet(grdAltro,'TESTO',Row);
end;

procedure TW036FTraspDirigenza.CreaFrame(Griglia:TmedpIWDBGrid;Operazione,FN:String);
begin
  Griglia.medpColumnClick(nil,FN);
  //Apro frame di gestione dati
  W036Esp:=TW036FEsperienzeFM.Create(Self);
  CaricaJQAutocomplete(Griglia,-1);
  W036Esp.evtAbilitaJQ:=AbilitaJqAutocomplete;
  W036Esp.ReadOnly:=SolaLettura;
  W036Esp.W036DM2:=W036DM;
  W036Esp.DataSetEsp:=(Griglia.medpDataSet as TOracleDataSet);
  W036Esp.AzioneRichiamo:=Operazione;
  W036Esp.Apri;
  W036Esp.Visualizza;
end;

procedure TW036FTraspDirigenza.DataSet2Memo(Griglia:TmedpIWDBGrid;NomeLogico:String;r:Integer);
begin
  with Griglia do
    if medpStato = msEdit then
      (medpCompCella(r,medpIndexColonna(NomeLogico),0) as TmeIWMemo).Lines.Text:=medpValoreColonna(r,NomeLogico);
end;

procedure TW036FTraspDirigenza.Memo2DataSet(Griglia:TmedpIWDBGrid;NomeLogico:String;r:Integer);
begin
  with Griglia do
    medpDataSet.FieldByName(NomeLogico).AsString:=Copy(R180SostituisciCaratteriSpeciali(Trim((medpCompCella(r,medpIndexColonna(NomeLogico),0) as TmeIWMemo).Lines.Text)),1,1000);
end;

procedure TW036FTraspDirigenza.ModificaDichiarazioniClick(Sender: TObject);
begin
  if W036DM.selSG210a.RecordCount <= 0 then
    raise exception.Create('Prima di modificare, è necessario compilare la sezione "Incarico attuale"');
  W036DM.selSG213.Edit;
  W036DM.selSG213INCONFERIBILITAChange(nil);
  AbilitaComponenti;
end;

procedure TW036FTraspDirigenza.ConfermaDichiarazioniClick(Sender: TObject);
var StampaAutomatica:Boolean;
begin
  { TODO : TEST IW 15 }
  with W036DM.selSG213 do
    StampaAutomatica:=grdTabDetail.TabByIndex(2).LinkVisible and
                      (    FieldByName('DATA_COMPILAZIONE').IsNull
                       or (FieldByName('SENTENZA_CONDANNA').AsString <> FieldByName('SENTENZA_CONDANNA').OldValue)
                       or (FieldByName('INCOMPATIBILITA').AsString <> FieldByName('INCOMPATIBILITA').OldValue));
  W036DM.selSG213.Post;
  AbilitaComponenti;
  if StampaAutomatica then
    StampaDichiarazioniClick(nil);
end;

procedure TW036FTraspDirigenza.AnnullaDichiarazioniClick(Sender: TObject);
begin
  W036DM.selSG213.Cancel;
  AbilitaComponenti;
end;

procedure TW036FTraspDirigenza.StampaDichiarazioniClick(Sender: TObject);
begin
  if W036DM.selSG210a.RecordCount <= 0 then
    raise exception.Create('Prima di stampare, è necessario compilare la sezione "Incarico attuale"');
  //Imposto la data compilazione in risposta al Confirmation, se non ero già passato dal pulsante Modifica
  with W036DM.selSG213 do
    if FieldByName('DATA_COMPILAZIONE').IsNull and not SolaLettura then
    begin
      Edit;
      Post;//Imposta la data compilazione
    end;
  CreaClientDataset;
  CaricaClientDataset;
  try
    EsecuzioneStampa;
    VisualizzaStampa(NomeFile);
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(E.Message, ERRORE);
      abort;
    end;
  end;
  cdsDichiarazione.Close;
end;

procedure TW036FTraspDirigenza.chkInconfNoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  AbilitaComponenti;
end;

procedure TW036FTraspDirigenza.chkInconfSiAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  AbilitaComponenti;
end;

procedure TW036FTraspDirigenza.CaricaJQAutocomplete(Griglia:TmedpIWDBGrid;r:Integer);
var i,j:Integer;
    NomeComponente:String;
begin
  CodeAC:='';
  jQAutocomplete.Enabled:=True;
  jQAutocomplete.OnReady.Clear;
  with Griglia,medpDataSet do
    for i:=0 to FieldCount - 1 do
      //Componenti creati nel frame
      if r = -1 then
      begin
        NomeComponente:='';
        for j:=0 to W036Esp.ComponentCount - 1 do
          if W036Esp.Components[j] is TmeIWDBEdit then
            if (W036Esp.Components[j] as TmeIWDBEdit).DataField = Fields[i].FieldName then
              NomeComponente:=(W036Esp.Components[j] as TmeIWDBEdit).HTMLName;
        if NomeComponente <> '' then
          ImpostaTestoJQ(Fields[i].FieldName,NomeComponente);
      end
      //Componenti creati nella griglia
      else if medpCompCella(r,medpIndexColonna(Fields[i].FieldName),0) is TmeIWEdit then
        ImpostaTestoJQ(Fields[i].FieldName,(medpCompCella(r,medpIndexColonna(Fields[i].FieldName),0) as TmeIWEdit).HTMLName);
  jQAutocomplete.OnReady.Add(CodeAC);
end;

procedure TW036FTraspDirigenza.ImpostaTestoJQ(NomeLogico:String;NomeComponente:String);
var Elementi:String;
    Lista:TStringList;
    i:Integer;
begin
  Lista:=W036DM.RecuperaLista(NomeLogico);
  if Lista = nil then
    exit;
  //Ricarica la Lista se l'elenco dei valori si basa su quelli finora inseriti dall'utente
  if VarToStr(W036DM.selSG215.Lookup('NOME_LOGICO',NomeLogico,'NOME_CAMPO')) = NomeLogico then
    W036DM.CaricaListaValori(NomeLogico);
  // prepara autocomplete
  if Lista.Count > 0 then
  begin
    (*//Non usare perché non mantiene le virgole interne al testo delle singole opzioni:
    Elementi:='''' + StringReplace(C190EscapeJS(Lista.CommaText),',',''',''',[rfReplaceAll]) + '''';
    //Eventuale work-around in aggiunta, che però lascerebbe sempre "sporca" la StringList...
    Elementi:=StringReplace(Elementi,'#comma-to-save#',',',[rfReplaceAll]);
    //...dato che in CaricaListaValori bisognerebbe prevedere:
    Valore:=StringReplace(Valore,',','#comma-to-save#',[rfReplaceAll]);*)

    //Ciclo su Lista per mantenere le virgole interne al testo delle singole opzioni:
    for i:=0 to Lista.Count - 1 do
      Elementi:=Elementi + IfThen(Elementi <> '',''',''') + C190EscapeJS(Lista[i]);
    Elementi:='''' + Elementi + '''';
    CodeAC:=CodeAC + CRLF +
            'var elementi = [' + Elementi + ']; ' + CRLF +
            '$("#' + NomeComponente + '").autocomplete({ ' + CRLF +
            '  source: elementi, ' + CRLF +
            '  delay: 0,' + CRLF +
            '  minLength: 0' + CRLF +
            '}).focus(function(){ ' + CRLF +
            '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
            '}); ';
  end;
end;

procedure TW036FTraspDirigenza.AbilitaJqAutocomplete(Val:Boolean);
begin
  jQAutocomplete.OnReady.Clear;
  jQAutocomplete.OnReady.Add(IfThen(Val,CodeAC));
end;

procedure TW036FTraspDirigenza.CreaClientDataset;
begin
  with cdsDichiarazione do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Nominativo',ftString,61,False);
    FieldDefs.Add('Servizio',ftString,500,False);
    FieldDefs.Add('Qualifica',ftString,500,False);
    FieldDefs.Add('Ente',ftString,500,False);
    FieldDefs.Add('Incarico',ftString,500,False);
    FieldDefs.Add('Condanna',ftString,1,False);
    FieldDefs.Add('Incompatibilita',ftString,1,False);
    FieldDefs.Add('Inconferibilita',ftString,1,False);
    FieldDefs.Add('DataCompilazione',ftString,10,False);
    IndexDefs.Clear;
    CreateDataSet;
    LogChanges:=False;
  end;
end;

procedure TW036FTraspDirigenza.CaricaClientDataset;
begin
  with W036DM do
  begin
    cdsDichiarazione.Append;
    cdsDichiarazione.FieldByName('Nominativo').AsString:=selAnagrafeW.FieldByName('COGNOME').AsString + ' ' + selAnagrafeW.FieldByName('NOME').AsString;
    cdsDichiarazione.FieldByName('Servizio').AsString:=selSG210a.FieldByName('UNITA_ORGANIZZATIVA').AsString;
    cdsDichiarazione.FieldByName('Qualifica').AsString:=selSG210a.FieldByName('QUALIFICA').AsString;
    cdsDichiarazione.FieldByName('Ente').AsString:=selSG210a.FieldByName('AMMINISTRAZIONE').AsString;
    cdsDichiarazione.FieldByName('Incarico').AsString:=ValoreDefault('#DICHIARAZIONE_INCARICO');
    if not selSG213.FieldByName('DATA_COMPILAZIONE').IsNull then //In caso di stampa in SolaLettura di una dichiarazione non ancora compilata
    begin
      cdsDichiarazione.FieldByName('Condanna').AsString:=selSG213.FieldByName('SENTENZA_CONDANNA').AsString;
      cdsDichiarazione.FieldByName('Incompatibilita').AsString:=selSG213.FieldByName('INCOMPATIBILITA').AsString;
      cdsDichiarazione.FieldByName('Inconferibilita').AsString:=selSG213.FieldByName('INCONFERIBILITA').AsString;
      cdsDichiarazione.FieldByName('DataCompilazione').AsString:=FormatDateTime('dd/mm/yyyy',selSG213.FieldByName('DATA_COMPILAZIONE').AsDateTime);
    end;
    cdsDichiarazione.Post;
  end;
end;

procedure TW036FTraspDirigenza.EsecuzioneStampa;
var
  rvComp: TRaveComponent;
  dconnDichiarazione: TRaveDataConnection;
  L: TStringList;
  ODS: TOracleDataSet;
  F: Real;
  ImgTop,ImgAlt: Extended;
  Immagine:Boolean;
begin
  try
    NomeFile:='';
    CSStampa.Enter;
    rvSystem:=TRVSystem.Create(Self);
    rvProject:=TRVProject.Create(Self);
    connDichiarazione:=TRVDataSetConnection.Create(Self);
    rvRenderPDF:=TRvRenderPDF.Create(Self);
    L:=TStringList.Create;
    try
      rvProject.Engine:=rvSystem;
      rvRenderPDF.Active:=True;
      rvProject.ProjectFile:=gServerController.ContentPath + 'report\W036Dichiarazione.rav';
      connDichiarazione.Name:='connDichiarazione';
      connDichiarazione.DataSet:=cdsDichiarazione;
      connDichiarazione.RuntimeVisibility:=RpCon.rtNone;
      rvProject.Open;
      rvProject.GetReportList(L,True);
      rvProject.SelectReport(L[0],True);
      // Impostazioni dei campi della Dichiarazione
      rvDWDichiarazione:=(rvProject.ProjMan.FindRaveComponent('dwDichiarazione',nil) as TRaveDataView);
      dconnDichiarazione:=CreateDataCon(connDichiarazione);
      rvDWDichiarazione.ConnectionName:=dconnDichiarazione.Name;
      rvDWDichiarazione.DataCon:=dconnDichiarazione;
      CreateFields(rvDWDichiarazione,nil,nil,True);

      rvPage:=rvProject.ProjMan.FindRaveComponent('W036.Page',nil);
      // Impostazione logo
      Immagine:=False;
      rvComp:=rvProject.ProjMan.FindRaveComponent('bmpLogo',rvPage);
      (rvComp as TRaveBitmap).Height:=0;
      (rvComp as TRaveBitmap).Width:=0;
      F:=0.010416667; // valore fisso da pixel(X) a inch[in] (http://www.unitconversion.org/unit_converter/typography.html)
      try
        ODS:=TOracleDataSet.Create(nil);
        try
          ODS.Session:=SessioneOracle;
          ODS.SQL.Add('SELECT IMMAGINE FROM T004_IMMAGINI WHERE TIPO = ''CARTELLINO''');
          ODS.Open;
          if ODS.RecordCount = 1 then
          begin
            (rvComp as TRaveBitmap).Image.Assign(TBlobField(ODS.FieldByName('IMMAGINE')));
            (rvComp as TRaveBitmap).Width:=100 * F;//100 = Valore fisso preso dall'impostazione del logo per le valutazioni di ASL_CN1
            (rvComp as TRaveBitmap).Height:=43 * F;// 43 = Valore fisso preso dall'impostazione del logo per le valutazioni di ASL_CN1
            ImgTop:=(rvComp as TRaveBitmap).Top;
            ImgAlt:=(rvComp as TRaveBitmap).Height;
            rvComp:=rvProject.ProjMan.FindRaveComponent('bndTitolo',rvPage);
            (rvComp as TRaveContainerControl).Height:=Max((rvComp as TRaveContainerControl).Height,ImgTop + ImgAlt);
            Immagine:=True;
          end;
          ODS.Close;
        finally
          FreeAndNil(ODS);
        end;
      except
      end;
      if not Immagine then
      begin
        rvComp:=rvProject.ProjMan.FindRaveComponent('bndTitolo',rvPage);
        (rvComp as TRaveContainerControl).Height:=0;
      end;
      //Impostazione genere
      rvComp:=rvProject.ProjMan.FindRaveComponent('lblTitoloSottoscritto',rvPage);
      (rvComp as TRaveText).Text:=IfThen(selAnagrafeW.FieldByName('SESSO').AsString = 'F','La Sottoscritta','Il Sottoscritto');
      //Impostazione opzioni
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnOpzione1AB',rvPage);
      (rvComp as TRaveLine).Visible:=cdsDichiarazione.FieldByName('Condanna').AsString = 'N';
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnOpzione1BA',rvPage);
      (rvComp as TRaveLine).Visible:=cdsDichiarazione.FieldByName('Condanna').AsString = 'N';
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnOpzione2AB',rvPage);
      (rvComp as TRaveLine).Visible:=cdsDichiarazione.FieldByName('Incompatibilita').AsString = 'N';
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnOpzione2BA',rvPage);
      (rvComp as TRaveLine).Visible:=cdsDichiarazione.FieldByName('Incompatibilita').AsString = 'N';
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
    finally
      try
        L.Free;
      except
      end;
      try
        rvProject.Close;
      except
      end;
      try
        FreeAndNil(connDichiarazione);
      except
      end;
      try
        FreeAndNil(rvSystem);
      except
      end;
      try
        FreeAndNil(rvRenderPDF);
      except
      end;
      try
        FreeAndNil(rvProject);
      except
      end;
      try
        FreeAndNil(dconnDichiarazione);
      except
      end;
      CSStampa.Leave;
    end;
  except
  end;
end;

procedure TW036FTraspDirigenza.VisualizzaStampa(NomeFile: String);
begin
  if Pos(INI_PAR_NO_PDF,W000ParConfig.ParametriAvanzati) = 0 then
    VisualizzaFile(NomeFile,'Anteprima dichiarazione',nil,nil);
end;

procedure TW036FTraspDirigenza.DistruggiOggetti;
begin
  FreeAndNil(W036DM);
  grdIncaricoAttuale.medpClearCompGriglia;
  grdEsperienzePrecedenti.medpClearCompGriglia;
  grdTitoloStudio.medpClearCompGriglia;
  grdLingue.medpClearCompGriglia;
  grdCapacitaTecnologiche.medpClearCompGriglia;
  grdAltro.medpClearCompGriglia;
end;

end.
