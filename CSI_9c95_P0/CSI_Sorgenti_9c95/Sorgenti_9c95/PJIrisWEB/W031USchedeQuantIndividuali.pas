unit W031USchedeQuantIndividuali;

interface

uses
  R010UPaginaWeb, R012UWebAnagrafico,
  A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali,
  C190FunzioniGeneraliWeb, USelI010, WC012UVisualizzaFileFM,
  WC002UDatiAnagraficiFM, W031ULegendaFlexFM, W031USchedeQuantPosizionatiFM,
  Classes,Graphics,Controls,SysUtils,
  IWTemplateProcessorHTML, meIWLabel, meIWEdit, meIWMemo,
  IWControl, IWHTMLControls, meIWButton,
  OracleData, IWCompListbox,IWCompCheckbox,Variants,IWBaseLayoutComponent,
  IWBaseContainerLayout,IWContainerLayout,IWVCLBaseControl,IWBaseControl,
  IWBaseHTMLControl,Forms,IWHTMLContainer,IWRegion,IWVCLComponent,
  IWHTML40Container,Math,StrUtils,Oracle,DB,
  RpCon,RpConDS,RpSystem,RpDefine,RpRave,RVCsStd,RVCsData,RVData,
  RvDirectDataView,RpRender,RpRenderPDF,RVClass,RVProj,RVCsDraw,
  ActnList,Menus,IWCompMenu,IWDBGrids,medpIWDBGrid,DBClient,
  IWVCLBaseContainer, IWContainer, meIWGrid,medpIWTabControl, meIWCheckBox,
  meIWRadioGroup, meIWLink, meIWComboBox, meIWRegion, System.SyncObjs,
  IWCompExtCtrls, meIWImageFile, IWCompButton, IWCompLabel, IWCompGrids;

type
  TDipendenti = record
    Progressivo:String;
    Matricola:String;
    Cognome:String;
    Nome:String;
    Text:String;
  end;

  TRecordChiamata = record
    Operazione:String;
    Data:TDateTime;
    Operatore:String;
    ProgReper:Integer;
    Esito:String;
    Note:String;
  end;

  TW031FSchedeQuantIndividuali = class(TR012FWebAnagrafico)
    dsrT768:TDataSource;
    cdsT768:TClientDataSet;
    selT767Dati:TOracleDataSet;
    selT767:TOracleDataSet;
    selT768Tot:TOracleDataSet;
    tbSchede:TmedpIWTabControl;
    selT760:TOracleDataSet;
    dsrT767:TDataSource;
    chkSupervisore:TmeIWCheckBox;
    selT770:TOracleDataSet;
    dsrT770:TDataSource;
    dsrSG715:TDataSource;
    selSG715:TOracleDataSet;
    selT768:TOracleDataSet;
    lblGruppo: TmeIWLabel;
    lblQuota: TmeIWLabel;
    lblAnno: TmeIWLabel;
    lblNumDip: TmeIWLabel;
    btnApplica: TmeIWButton;
    lnkIstruzioni: TmeIWLink;
    grdRiepilogo: TmeIWGrid;
    cmbSupervisore: TmeIWComboBox;
    cmbGruppo: TmeIWComboBox;
    cmbQuota: TmeIWComboBox;
    cmbAnno: TmeIWComboBox;
    W031SchedeIndividualiRG: TmeIWRegion;
    grdSchedeDip: TmedpIWDBGrid;
    btnModifica: TmeIWButton;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    btnStampa: TmeIWButton;
    lnkLegendaFlex: TmeIWLink;
    rgpTipoSchede: TmeIWRadioGroup;
    lblVisualizzazione: TmeIWLabel;
    tpSchedeIndividuali: TIWTemplateProcessorHTML;
    W031QuoteQualitativeRG: TmeIWRegion;
    grdQuoteQual: TmeIWGrid;
    tpQuoteQualitative: TIWTemplateProcessorHTML;
    selValutatori: TOracleDataSet;
    CambioValutatore: TOracleQuery;
    procedure IWAppFormCreate(Sender:TObject);
    procedure grdSchedeDipRenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer);
    procedure selT767DatiFilterRecord(DataSet:TDataSet; var Accept:Boolean);
    procedure chkSupervisoreClick(Sender:TObject);
    procedure selT768ApplyRecord(Sender:TOracleDataSet; Action:Char; var Applied:Boolean; var NewRowId:string);
    procedure btnVisualizzaClick(Sender:TObject);
    procedure grdSchedeDipAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure btnApplicaClick(Sender: TObject);
    procedure btnModificaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure rgpTipoSchedeClick(Sender: TObject);
    procedure lnkIstruzioniClick(Sender: TObject);
    procedure lnkLegendaFlexClick(Sender: TObject);
    procedure grdQuoteQualRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure cmbQuotaChange(Sender: TObject);
    procedure cmbGruppoChange(Sender: TObject);
    procedure cmbAnnoChange(Sender: TObject);
    procedure selT767AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    RecordChiamata:TRecordChiamata;
    ArrDipendenti: array of TDipendenti;
    WC002FDatiAnagraficiFM:TWC002FDatiAnagraficiFM;
    ValutatoreCambiato,Anom:Boolean;
    Tipo,MatrStampa:String;
    TotaleOreAccett:Integer;
    TotaleAccett:Real;
    rvSystem:TRVSystem;
    rvDWDettaglio:TRaveDataView;
    rvProject:TRVProject;
    rvPage:TRaveComponent;
    rvRenderPDF:TRvRenderPDF;
    connDettaglio:TRVDataSetConnection;
    W031LegendaFlexFM:TW031FLegendaFlexFM;
    W031SchedeQuantPosizionatiFM:TW031FSchedeQuantPosizionatiFM;
    selI010:TselI010;
    function SupervisoreOK:Boolean;
    function ModificheRiga(FN:String):Boolean;
    procedure TrasformaComponenti(FN:String);
    procedure actVariazioneOK;
    procedure DBGridColumnClick(ASender:TObject; const AValue:string);
    procedure CreaComponentiGriglia;
    procedure imgStampaIndClick(Sender:TObject);
    procedure imgSchedaAnagraficaClick(Sender:TObject);
    procedure chkControlloClick(Sender:TObject);
    procedure GetQuoteQual;
    procedure StampaIndividuale(Definitiva:Boolean);
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
    procedure actStampaDef;
    procedure actStampaProvv;
    procedure GetGruppi;
    procedure GetSchedeDip;
  end;

implementation

uses IWApplication,IWGlobal;
{$R *.DFM}

function TW031FSchedeQuantIndividuali.InizializzaAccesso:Boolean;
begin
  Result:=True;
  R180SetVariable(selT767,'ANNO',StrToIntDef(cmbAnno.Text,0));
  R180SetVariable(selT767,'GRUPPO',TrimRight(Copy(cmbGruppo.Text,1,10)));
  R180SetVariable(selT767,'QUOTA',TrimRight(Copy(cmbQuota.Text,1,5)));
  selT767.Open;
  grdRiepilogo.RowCount:=2;
  grdRiepilogo.ColumnCount:=7;
  grdRiepilogo.Cell[0,0].Text:='Tot.ore assegnate';
  grdRiepilogo.Cell[0,1].Text:='Tot.imp.assegnato';
  grdRiepilogo.Cell[0,2].Text:='Tolleranza';
  grdRiepilogo.Cell[0,3].Text:='Num.max.ore';
  grdRiepilogo.Cell[0,4].Text:='Importo max budget';
  grdRiepilogo.Cell[0,5].Text:='Tot.ore accettate';
  grdRiepilogo.Cell[0,6].Text:='Tot.imp.accettato';
  grdRiepilogo.Cell[1,0].Text:=selT767.FieldByName('NUMORE_TOTALE').AsString;
  grdRiepilogo.Cell[1,1].Text:=Format('%-15.2n',[selT767.FieldByName('IMPORTO_TOTALE').AsFloat]);
  grdRiepilogo.Cell[1,2].Text:=selT767.FieldByName('TOLLERANZA').AsString;
  if Copy(selT767.FieldByName('TOLLERANZA').AsString,1,1) = '-' then
  begin
    grdRiepilogo.Cell[1,3].Text:=R180MinutiOre(R180OreMinutiExt(selT767.FieldByName('NUMORE_TOTALE').AsString) - Trunc(R180OreMinutiExt(selT767.FieldByName('NUMORE_TOTALE').AsString) * Abs(selT767.FieldByName('TOLLERANZA').AsFloat) / 100));
    grdRiepilogo.Cell[1,4].Text:=Format('%-15.2n',[selT767.FieldByName('IMPORTO_TOTALE').AsFloat - R180Arrotonda(selT767.FieldByName('IMPORTO_TOTALE').AsFloat * Abs(selT767.FieldByName('TOLLERANZA').AsFloat) / 100,0.01,'P')]);
  end
  else
  begin
    grdRiepilogo.Cell[1,3].Text:=R180MinutiOre(R180OreMinutiExt(selT767.FieldByName('NUMORE_TOTALE').AsString) + Trunc(R180OreMinutiExt(selT767.FieldByName('NUMORE_TOTALE').AsString) * Abs(selT767.FieldByName('TOLLERANZA').AsFloat) / 100));
    grdRiepilogo.Cell[1,4].Text:=Format('%-15.2n',[selT767.FieldByName('IMPORTO_TOTALE').AsFloat + R180Arrotonda(selT767.FieldByName('IMPORTO_TOTALE').AsFloat * Abs(selT767.FieldByName('TOLLERANZA').AsFloat) / 100,0.01,'P')]);
  end;
  TotaleOreAccett:=0;
  TotaleAccett:=0;
  R180SetVariable(selT768Tot,'ANNO',StrToIntDef(cmbAnno.Text,0));
  R180SetVariable(selT768Tot,'GRUPPO',TrimRight(Copy(cmbGruppo.Text,1,10)));
  R180SetVariable(selT768Tot,'QUOTA',TrimRight(Copy(cmbQuota.Text,1,5)));
  selT768Tot.Open;
  selT768Tot.First;
  selT768.Refresh;
  while not selT768Tot.Eof do
  begin
    if selT768.SearchRecord('PROGRESSIVO',selT768Tot.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
    begin
      TotaleOreAccett:=TotaleOreAccett + R180OreMinutiExt(selT768.FieldByName('NUMORE_ACCETTATE').AsString);
      TotaleAccett:=TotaleAccett + selT768.FieldByName('TOTALE_ACCETTATO').AsFloat;
    end
    else
    begin
      TotaleOreAccett:=TotaleOreAccett + R180OreMinutiExt(selT768Tot.FieldByName('NUMORE_ACCETTATE').AsString);
      TotaleAccett:=TotaleAccett + selT768Tot.FieldByName('TOTALE_ACCETTATO').AsFloat;
    end;
    selT768Tot.Next;
  end;
  TotaleAccett:=R180Arrotonda(TotaleAccett,0.01,'P');
  grdRiepilogo.Cell[1,5].Text:=R180MinutiOre(TotaleOreAccett);
  grdRiepilogo.Cell[1,6].Text:=Format('%-15.2n',[TotaleAccett]);
  lblNumDip.Caption:='';
  if selT768Tot.RecordCount <> grdSchedeDip.medpDataSet.RecordCount then
    lblNumDip.Caption:='Dipendenti del gruppo: ' + IntToStr(selT768Tot.RecordCount) + ' - Dipendenti visualizzati: ' + IntToStr(grdSchedeDip.medpDataSet.RecordCount);
  Anom:=False;
  if (StrToFloatDef(StringReplace(grdRiepilogo.Cell[1,4].Text,'.','',[rfReplaceAll]),0) <> 0) and (R180AzzeraPrecisione(StrToFloatDef(StringReplace(grdRiepilogo.Cell[1,4].Text,'.','',[rfReplaceAll]),0) - TotaleAccett,2) < 0) then
  begin
    Anom:=True;
    GGetWebApplicationThreadVar.ShowMessage('Attenzione: totale importo ore accettate superiore all''importo totale previsto!');
    Exit;
  end;
end;

procedure TW031FSchedeQuantIndividuali.GetSchedeDip;
begin
  R180SetVariable(selT767,'ANNO',StrToIntDef(cmbAnno.Text,0));
  R180SetVariable(selT767,'GRUPPO',TrimRight(Copy(cmbGruppo.Text,1,10)));
  R180SetVariable(selT767,'QUOTA',TrimRight(Copy(cmbQuota.Text,1,5)));
  selT767.Open;
  chkSupervisore.Checked:=False;
  if selT767.FieldByName('SUPERVISIONE').AsString = 'S' then
    chkSupervisore.Checked:=True;
  chkSupervisoreClick(nil);
  cmbSupervisore.ItemIndex:=-1;
  if (not selT767.FieldByName('PROG_SUPERVISORE').IsNull) and (selT767.FieldByName('PROG_SUPERVISORE').AsInteger <> 0) then
    cmbSupervisore.ItemIndex:=R180IndexOf(cmbSupervisore.Items,VarToStr(selValutatori.Lookup('PROGRESSIVO',selT767.FieldByName('PROG_SUPERVISORE').AsInteger,'VALUTATORE')),100);
  R180SetVariable(selT768,'ANNO',StrToIntDef(cmbAnno.Text,0));
  R180SetVariable(selT768,'GRUPPO',TrimRight(Copy(cmbGruppo.Text,1,10)));
  R180SetVariable(selT768,'QUOTA',TrimRight(Copy(cmbQuota.Text,1,5)));
  R180SetVariable(selT768,'DATARIF',selT767.FieldByName('DATARIF').AsDateTime);
  if rgpTipoSchede.ItemIndex = 0 then
    R180SetVariable(selT768,'FILTRO',' AND T768.CONFERMATO = ''S''')
  else if rgpTipoSchede.ItemIndex = 1 then
    R180SetVariable(selT768,'FILTRO',' AND T768.CONFERMATO = ''N''')
  else
    R180SetVariable(selT768,'FILTRO',' ');
  selT768.Close;
  selT768.Open;
  btnModifica.Visible:=(not SolaLettura) and (selT767.FieldByName('STATO').AsString <> 'C') and (rgpTipoSchede.ItemIndex <> 0);
  btnApplica.Visible:=(not SolaLettura) and (selT767.FieldByName('STATO').AsString <> 'C');
  grdSchedeDip.medpCreaCDS;
  grdSchedeDip.medpEliminaColonne;
  grdSchedeDip.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdSchedeDip.medpAggiungiColonna('DIPENDENTE','Dipendente','',nil);
  grdSchedeDip.medpAggiungiColonna('PARTTIME','% PT','',nil);
  grdSchedeDip.medpAggiungiColonna('FLESSIBILITA','Flessibilita','',nil);
  grdSchedeDip.medpAggiungiColonna('NOTE','Casi particolari','',nil);
  grdSchedeDip.medpAggiungiColonna('NUMORE_ASSEGNATE','Ore assegnate','',nil);
  grdSchedeDip.medpAggiungiColonna('NUMORE','Ore accettate','',nil);
  grdSchedeDip.medpAggiungiColonna('IMPORTO_ORARIO','Importo orario','',nil);
  grdSchedeDip.medpAggiungiColonna('TOTALE_ACCETTATO','Importo accettato','',nil);
  grdSchedeDip.medpAggiungiColonna('OBIETTIVI','Informato su obiettivi','',nil);
  grdSchedeDip.medpAggiungiColonna('VALUTAZIONE','Accetta valutazione','',nil);
  grdSchedeDip.medpAggiungiColonna('VALUTATORE','Valutatore','',nil);
  grdSchedeDip.medpAggiungiColonna('FIRMA','Firma','',nil);
  grdSchedeDip.medpAggiungiColonna('DATO1',VarToStr(selI010.Lookup('NOME_CAMPO','T430' + Parametri.CampiRiferimento.C7_Dato1,'NOME_LOGICO')),'',nil);
  if selT768.FindField('DESC_DATO1') <> nil then
    grdSchedeDip.medpAggiungiColonna('DESC_DATO1','','',nil);
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    grdSchedeDip.medpAggiungiColonna('DATO2',VarToStr(selI010.Lookup('NOME_CAMPO','T430' + Parametri.CampiRiferimento.C7_Dato2,'NOME_LOGICO')),'',nil);
  if selT768.FindField('DESC_DATO2') <> nil then
    grdSchedeDip.medpAggiungiColonna('DESC_DATO2','','',nil);
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    grdSchedeDip.medpAggiungiColonna('DATO3',VarToStr(selI010.Lookup('NOME_CAMPO','T430' + Parametri.CampiRiferimento.C7_Dato3,'NOME_LOGICO')),'',nil);
  if selT768.FindField('DESC_DATO3') <> nil then
    grdSchedeDip.medpAggiungiColonna('DESC_DATO3','','',nil);
  grdSchedeDip.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdSchedeDip.medpInizializzaCompGriglia;
  grdSchedeDip.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','STAMPA','null','');
  grdSchedeDip.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','SCHANAGR','null','');
  grdSchedeDip.medpCaricaCDS;
  GetQuoteQual;
end;

procedure TW031FSchedeQuantIndividuali.IWAppFormCreate(Sender:TObject);
var i:Integer;
    Tab1,Tab2,Tab3,Cod1,Cod2,Cod3,Stor1,Stor2,Stor3,s:String;
begin
  inherited;
  if Parametri.CampiRiferimento.C7_Dato1 = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Dato INCENTIVI DATO1 non specificato in Aziende/Gestione moduli!');
    Exit;
  end;

  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      try (Components[i] as TOracleQuery).Session:=SessioneOracle;
      except
      end
    else if Components[i] is TOracleDataSet then
      try (Components[i] as TOracleDataSet).Session:=SessioneOracle;
      except
      end;
  end;

  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','TABLE_NAME NOT IN (''T030_ANAGRAFICO'',''T480_COMUNI'')','NOME_LOGICO');

(*  FiltroRicerca:=W001FIrisWEBDtM.FiltroRicerca;
  FiltroRicerca:=StringReplace(FiltroRicerca,':DATALAVORO',':DATARIF',[rfReplaceAll,rfIgnoreCase]);
  FiltroRicerca:=StringReplace(FiltroRicerca,':DATADAL',':DATARIF',[rfReplaceAll,rfIgnoreCase]);
  selT768.SetVariable('FILTRORICERCA',FiltroRicerca);*)
  selT768.SetVariable('FILTRORICERCA','');
  s:='';
  A000GetTabella(Parametri.CampiRiferimento.C7_Dato1,Tab1,Cod1,Stor1);
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    A000GetTabella(Parametri.CampiRiferimento.C7_Dato2,Tab2,Cod2,Stor2);
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    A000GetTabella(Parametri.CampiRiferimento.C7_Dato3,Tab3,Cod3,Stor3);
  if (Tab1 <> '') and (Tab1 <> 'T430_STORICO') then
    s:=', T430D_' + Parametri.CampiRiferimento.C7_Dato1 + ' DESC_DATO1';
  if (Tab2 <> '') and (Tab2 <> 'T430_STORICO') then
    s:=s + ', T430D_' + Parametri.CampiRiferimento.C7_Dato2 + ' DESC_DATO2';
  if (Tab3 <> '') and (Tab3 <> 'T430_STORICO') then
    s:=s + ', T430D_' + Parametri.CampiRiferimento.C7_Dato3 + ' DESC_DATO3';
  selT768.SetVariable('DESCTAB',s);

  btnConferma.Visible:=False;
  btnAnnulla.Visible:=False;
  GetGruppi;

  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdSchedeDip.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdSchedeDip.medpEditMultiplo:=True;
  grdSchedeDip.medpDataSet:=selT768;
  selT768.Tag:=selT768.Tag + 1;
  WC002FDatiAnagraficiFM:=nil;

  tbSchede.AggiungiTab('Schede individuali',W031SchedeIndividualiRG);
  tbSchede.AggiungiTab('Quote qualitative',W031QuoteQualitativeRG);
  tbSchede.ActiveTab:=W031SchedeIndividualiRG;
end;

procedure TW031FSchedeQuantIndividuali.GetGruppi;
begin
  selT767Dati.Close;
  selT767Dati.SetVariable('DATI','T767.ANNO');
  selT767Dati.Open;
  cmbAnno.Items.Clear;
  while not selT767Dati.Eof do
  begin
    cmbAnno.Items.Add(selT767Dati.FieldByName('ANNO').AsString);
    selT767Dati.Next;
  end;
  cmbAnno.ItemIndex:=R180IndexOf(cmbAnno.Items,Copy(DateToStr(Parametri.DataLavoro),7,4),4);
  selT767Dati.Close;
  selT767Dati.SetVariable('DATI','T767.ANNO, T767.CODGRUPPO, T767.DESCRIZIONE');
  selT767Dati.Open;
  selT767Dati.Filtered:=True;
  cmbGruppo.Items.Clear;
  while not selT767Dati.Eof do
  begin
    if selT767Dati.FieldByName('ANNO').AsString = cmbAnno.Text then
      cmbGruppo.Items.Add(Format('%-10s',[selT767Dati.FieldByName('CODGRUPPO').AsString]) + ' ' + selT767Dati.FieldByName('DESCRIZIONE').AsString);
    selT767Dati.Next;
  end;
  selT767Dati.Filtered:=False;
  selT767Dati.Close;
  selT767Dati.SetVariable('DATI','T767.ANNO, T767.CODTIPOQUOTA, T765.DESCRIZIONE, T765.ACCONTI');
  selT767Dati.Open;
  cmbQuota.Items.Clear;
  while not selT767Dati.Eof do
  begin
    if selT767Dati.FieldByName('ANNO').AsString = cmbAnno.Text then
      cmbQuota.Items.Add(Format('%-5s',[selT767Dati.FieldByName('CODTIPOQUOTA').AsString]) + ' ' + selT767Dati.FieldByName('DESCRIZIONE').AsString);
    selT767Dati.Next;
  end;
end;

procedure TW031FSchedeQuantIndividuali.RefreshPage;
begin
  if btnModifica.Visible then
  begin
    GetSchedeDip;
    InizializzaAccesso;
  end;
end;

procedure TW031FSchedeQuantIndividuali.btnAnnullaClick(Sender: TObject);
// Annulla: annulla le modifiche apportate nei componenti editabili
begin
  inherited;
  btnModifica.Visible:=(not SolaLettura) and (selT767.FieldByName('STATO').AsString <> 'C') and (rgpTipoSchede.ItemIndex <> 0);
  btnStampa.Visible:=True;
  btnConferma.Visible:=False;
  btnAnnulla.Visible:=False;
  cmbAnno.Enabled:=True;
  cmbQuota.Enabled:=True;
  cmbGruppo.Enabled:=True;
  rgpTipoSchede.Enabled:=True;
  chkSupervisore.Enabled:=True;
  cmbSupervisore.Enabled:=chkSupervisore.Checked;
  btnApplica.Enabled:=(not SolaLettura) and (selT767.FieldByName('STATO').AsString <> 'C');

  grdSchedeDip.medpBrowse:=True;
  RecordChiamata.Operazione:='';
  TrasformaComponenti('');
  InizializzaAccesso;
end;

procedure TW031FSchedeQuantIndividuali.btnApplicaClick(Sender: TObject);
begin
  inherited;
  if (chkSupervisore.Checked) and (Trim(cmbSupervisore.Text) = '') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Specificare il supervisore di riferimento!');
    Exit;
  end;
  selT767.Edit;
  selT767.FieldByName('SUPERVISIONE').AsString:='N';
  if chkSupervisore.Checked then
    selT767.FieldByName('SUPERVISIONE').AsString:='S';
  selT767.FieldByName('PROG_SUPERVISORE').AsInteger:=0;
  if Trim(cmbSupervisore.Text) <> '' then
    selT767.FieldByName('PROG_SUPERVISORE').AsInteger:=StrToIntDef(VarToStr(selValutatori.Lookup('VALUTATORE',cmbSupervisore.Text,'PROGRESSIVO')),0);
  try
    selT767.Post;
    SessioneOracle.Commit;
  except
    selT767.Cancel;
  end;
end;

procedure TW031FSchedeQuantIndividuali.btnConfermaClick(Sender: TObject);
begin
  inherited;
  // modifica - applicazione modifiche
  if (RecordChiamata.Operazione = 'M') then
  begin
    // nessuna operazione da effettuare se non sono state apportate modifiche alla riga
    if not ModificheRiga('') then
    begin
      btnAnnullaClick(Sender);
      Exit;
    end;
    actVariazioneOK;
    // rilegge i dati
    Anom:=False;
    InizializzaAccesso;
    if not Anom then
    begin
      SessioneOracle.ApplyUpdates([selT768],True);
      btnModifica.Visible:=(not SolaLettura) and (selT767.FieldByName('STATO').AsString <> 'C') and (rgpTipoSchede.ItemIndex <> 0);
      btnStampa.Visible:=True;
      btnConferma.Visible:=False;
      btnAnnulla.Visible:=False;
      cmbAnno.Enabled:=True;
      cmbQuota.Enabled:=True;
      cmbGruppo.Enabled:=True;
      rgpTipoSchede.Enabled:=True;
      chkSupervisore.Enabled:=True;
      cmbSupervisore.Enabled:=chkSupervisore.Checked;
      btnApplica.Enabled:=(not SolaLettura) and (selT767.FieldByName('STATO').AsString <> 'C');
      grdSchedeDip.medpBrowse:=True;
      RecordChiamata.Operazione:='';
      TrasformaComponenti('');
      GetSchedeDip;
    end
    else
      selT768.CancelUpdates;
  end;
end;

procedure TW031FSchedeQuantIndividuali.btnModificaClick(Sender: TObject);
begin
  inherited;
  if not SupervisoreOK then
    Exit;
  // modifica - applicazione modifiche
  if (RecordChiamata.Operazione = 'I') or (RecordChiamata.Operazione = 'M') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(RecordChiamata.Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;
  btnModifica.Visible:=False;
  btnStampa.Visible:=False;
  btnConferma.Visible:=True;
  btnAnnulla.Visible:=True;
  cmbAnno.Enabled:=False;
  cmbQuota.Enabled:=False;
  cmbGruppo.Enabled:=False;
  rgpTipoSchede.Enabled:=False;
  chkSupervisore.Enabled:=False;
  cmbSupervisore.Enabled:=False;
  btnApplica.Enabled:=False;

  grdSchedeDip.medpBrowse:=False;
  // porta le righe in modifica: trasforma i componenti
  RecordChiamata.Operazione:='M';
  TrasformaComponenti('S');
end;

function TW031FSchedeQuantIndividuali.SupervisoreOK:Boolean;
begin
  Result:=True;
  if ((selT767.FieldByName('SUPERVISIONE').AsString = 'S') and (not chkSupervisore.Checked)) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Attenzione: il supervisore è stato tolto! Applicare le modifiche prima di continuare!');
    Result:=False;
  end;
  if Result and ((selT767.FieldByName('SUPERVISIONE').AsString = 'N') and (chkSupervisore.Checked)) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Attenzione: è stato previsto il supervisore! Applicare le modifiche prima di continuare!');
    Result:=False;
  end;
  if Result and ((((selT767.FieldByName('PROG_SUPERVISORE').IsNull) or (selT767.FieldByName('PROG_SUPERVISORE').AsInteger = 0)) and (cmbSupervisore.ItemIndex <> -1)) or ((not selT767.FieldByName('PROG_SUPERVISORE').IsNull) and (selT767.FieldByName('PROG_SUPERVISORE').AsInteger <> 0) and ((cmbSupervisore.ItemIndex = -1) or (StrToIntDef(VarToStr(selValutatori.Lookup('VALUTATORE',cmbSupervisore.Text,'PROGRESSIVO')),0) <> selT767.FieldByName('PROG_SUPERVISORE').AsInteger)))) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Attenzione: il supervisore è cambiato! Applicare le modifiche prima di continuare!');
    Result:=False;
  end;
end;

procedure TW031FSchedeQuantIndividuali.btnStampaClick(Sender: TObject);
var
  rvComp:TRaveComponent;
  L:TStringList;
  NomeFile{,URL_Stampa}:String;
  dconnDettaglio:TRaveDataConnection;
begin
  inherited;
  if not SupervisoreOK then
    Exit;

  CSStampa.Enter;
  rvSystem:=TRVSystem.Create(Self);
  rvProject:=TRVProject.Create(Self);
  connDettaglio:=TRVDataSetConnection.Create(Self);
  rvRenderPDF:=TRvRenderPDF.Create(Self);
  L:=TStringList.Create;
  try
    rvProject.Engine:=rvSystem;
    rvRenderPDF.Active:=True;
    rvProject.ProjectFile:=gSC.ContentPath + 'report\W031StampaIncentiviQuantGruppo.rav';
    connDettaglio.Name:='connDettaglio';
    connDettaglio.DataSet:=selT768;
    connDettaglio.RuntimeVisibility:=RpCon.rtNone;
    // Posizionamento sulla matricola correntemente selezionata
    selT768.First;
    rvProject.Open;
    rvProject.GetReportList(L,True);
    rvProject.SelectReport(L[0],True);
    rvDWDettaglio:=(rvProject.ProjMan.FindRaveComponent('dwDettaglio',nil) as TRaveDataView);
    // Impostazioni dei campi di Dettaglio
    dconnDettaglio:=CreateDataCon(connDettaglio);
    rvDWDettaglio.ConnectionName:=dconnDettaglio.Name;
    rvDWDettaglio.DataCon:=dconnDettaglio;
    CreateFields(rvDWDettaglio,nil,nil,True);
    rvPage:=rvProject.ProjMan.FindRaveComponent('W031.Page',nil);
    // Impostazioni della banda bndTitolo
    rvComp:=rvProject.ProjMan.FindRaveComponent('lblAzienda',rvPage);
    (rvComp as TRaveText).Text:=Parametri.RagioneSociale;
    rvComp:=rvProject.ProjMan.FindRaveComponent('lblTitolo',rvPage);
    (rvComp as TRaveText).Text:='INCENTIVI ' + Copy(cmbQuota.Text,7,Length(cmbQuota.Text) - 6) + ' ' + cmbAnno.Text;
    rvComp:=rvProject.ProjMan.FindRaveComponent('lblGruppo',rvPage);
    (rvComp as TRaveText).Text:='GRUPPO ' + cmbGruppo.Text;
    // Impostazioni della banda bndIntestazione
    //ScalaStampa:=0.2 / 18;
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
    VisualizzaFile(NomeFile,'Anteprima stampa scheda',nil,nil);
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

procedure TW031FSchedeQuantIndividuali.GetQuoteQual;
var i:Integer;
begin
  R180SetVariable(selT770,'QUOTA',TrimRight(Copy(cmbQuota.Text,1,5)));
  R180SetVariable(selT770,'GRUPPO',TrimRight(Copy(cmbGruppo.Text,1,10)));
  R180SetVariable(selT770,'DATARIF',selT767.FieldByName('DATARIF').AsDateTime);
  R180SetVariable(selT770,'ACCONTI','''' + StringReplace(VarToStr(selT767Dati.Lookup('CODTIPOQUOTA',TrimRight(Copy(cmbQuota.Text,1,5)),'ACCONTI')),',',''',''',[rfReplaceAll]) + '''');
  selT770.Open;

  grdQuoteQual.RowCount:=selT770.RecordCount + 1;
  grdQuoteQual.ColumnCount:=7;
  grdQuoteQual.Cell[0,0].Text:='Importo';
  grdQuoteQual.Cell[0,1].Text:='Ore';
  grdQuoteQual.Cell[0,2].Text:='Quantitativo';
  grdQuoteQual.Cell[0,3].Text:='Qualitativo';
  grdQuoteQual.Cell[0,4].Text:=VarToStr(selI010.Lookup('NOME_CAMPO','T430' + Parametri.CampiRiferimento.C7_Dato1,'NOME_LOGICO'));
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    grdQuoteQual.Cell[0,5].Text:=VarToStr(selI010.Lookup('NOME_CAMPO','T430' + Parametri.CampiRiferimento.C7_Dato2,'NOME_LOGICO'))
  else
    grdQuoteQual.Cell[0,5].Text:='Dato2 non specificato';
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    grdQuoteQual.Cell[0,6].Text:=VarToStr(selI010.Lookup('NOME_CAMPO','T430' + Parametri.CampiRiferimento.C7_Dato3,'NOME_LOGICO'))
  else
    grdQuoteQual.Cell[0,6].Text:='Dato3 non specificato';
  selT770.First;
  i:=1;
  while not selT770.Eof do
  begin
    grdQuoteQual.Cell[i,0].Text:=Format('%-15.2n',[selT770.FieldByName('IMPORTO').AsFloat]);
    grdQuoteQual.Cell[i,1].Text:=selT770.FieldByName('ORE').AsString;
    grdQuoteQual.Cell[i,2].Text:=Format('%-15.2n',[selT770.FieldByName('QUANTITATIVO').AsFloat]);
    grdQuoteQual.Cell[i,3].Text:=Format('%-15.2n',[selT770.FieldByName('QUALITATIVO').AsFloat]);
    grdQuoteQual.Cell[i,4].Text:=selT770.FieldByName('DATO1').AsString + ' - ' + VarToStr(selT768.Lookup('DATO1',selT770.FieldByName('DATO1').AsString,'DESC_DATO1'));
    if Parametri.CampiRiferimento.C7_Dato2 <> '' then
      grdQuoteQual.Cell[i,5].Text:=selT770.FieldByName('DATO2').AsString + ' - ' + VarToStr(selT768.Lookup('DATO2',selT770.FieldByName('DATO2').AsString,'DESC_DATO2'));
    if Parametri.CampiRiferimento.C7_Dato3 <> '' then
      grdQuoteQual.Cell[i,6].Text:=selT770.FieldByName('DATO3').AsString + ' - ' + VarToStr(selT768.Lookup('DATO3',selT770.FieldByName('DATO3').AsString,'DESC_DATO3'));
    i:=i + 1;
    selT770.Next;
  end;
end;

procedure TW031FSchedeQuantIndividuali.cmbAnnoChange(Sender: TObject);
begin
  inherited;
  selT767Dati.Close;
  selT767Dati.SetVariable('DATI','T767.ANNO, T767.CODGRUPPO, T767.DESCRIZIONE');
  selT767Dati.Open;
  selT767Dati.Filtered:=True;
  cmbGruppo.Items.Clear;
  while not selT767Dati.Eof do
  begin
    if selT767Dati.FieldByName('ANNO').AsString = cmbAnno.Text then
      cmbGruppo.Items.Add(Format('%-10s',[selT767Dati.FieldByName('CODGRUPPO').AsString]) + ' ' + selT767Dati.FieldByName('DESCRIZIONE').AsString);
    selT767Dati.Next;
  end;
  selT767Dati.Filtered:=False;
  selT767Dati.Close;
  selT767Dati.SetVariable('DATI','T767.ANNO, T767.CODTIPOQUOTA, T765.DESCRIZIONE, T765.ACCONTI');
  selT767Dati.Open;
  cmbQuota.Items.Clear;
  while not selT767Dati.Eof do
  begin
    if selT767Dati.FieldByName('ANNO').AsString = cmbAnno.Text then
      cmbQuota.Items.Add(Format('%-5s',[selT767Dati.FieldByName('CODTIPOQUOTA').AsString]) + ' ' + selT767Dati.FieldByName('DESCRIZIONE').AsString);
    selT767Dati.Next;
  end;
  GetSchedeDip;
  InizializzaAccesso;
end;

procedure TW031FSchedeQuantIndividuali.cmbGruppoChange(Sender: TObject);
begin
  inherited;
  GetSchedeDip;
  InizializzaAccesso;
end;

procedure TW031FSchedeQuantIndividuali.cmbQuotaChange(Sender: TObject);
begin
  inherited;
  GetSchedeDip;
  InizializzaAccesso;
end;

procedure TW031FSchedeQuantIndividuali.imgSchedaAnagraficaClick(Sender:TObject);
var Matr:String;
begin
  if not SupervisoreOK then
    Exit;
  Matr:=VarToStr(cdsT768.Lookup('DBG_ROWID',(Sender as TmeIWImageFile).FriendlyName,'DIPENDENTE'));
  Matr:=Trim(Copy(Matr,Pos('(',Matr) + 1,Pos(')',Matr) - Pos('(',Matr) - 1));
  if Matr <> '' then
  begin
    WC002FDatiAnagraficiFM:=TWC002FDatiAnagraficiFM.Create(Self);
    WC002FDatiAnagraficiFM.ParMatricola:=Matr;
    WC002FDatiAnagraficiFM.VisualizzaScheda;
  end;
end;

procedure TW031FSchedeQuantIndividuali.imgStampaIndClick(Sender:TObject);
var s,Firma:String;
begin
  if not SupervisoreOK then
    Exit;
  MatrStampa:='';
  if cdsT768.Locate('DBG_ROWID',(Sender as TmeIWImageFile).FriendlyName,[]) then
  begin
    MatrStampa:=cdsT768.FieldByName('DIPENDENTE').AsString;
    MatrStampa:=Trim(Copy(MatrStampa,Pos('(',MatrStampa) + 1,Pos(')',MatrStampa) - Pos('(',MatrStampa) - 1));
    Tipo:='0';
    if selT770.SearchRecord('DATO1;DATO3',VarArrayOf([cdsT768.FieldByName('DATO1').AsString,cdsT768.FieldByName('DATO3').AsString]),[srFromBeginning]) then
      Tipo:=selT770.FieldByName('TIPO_STAMPAQUANT').AsString;
    Firma:=cdsT768.FieldByName('FIRMA').AsString;
  end;
  if Trim(MatrStampa) = '' then
    Exit;
  if Tipo = '0' then //scheda standard
  begin
    if (Firma = 'NO') then
    begin
      if (not SolaLettura) and (selT767.FieldByName('STATO').AsString <> 'C') then
      begin
        s:='Attenzione: vuoi stampare la scheda DEFINITIVA per la firma del dipendente? ' + 'La scheda definitiva verrà chiusa e non sarà più possibile modificarla.';
        Messaggio('Conferma scheda definitiva',s,actStampaDef,actStampaProvv);
        Exit;
      end
      else
        actStampaProvv;
    end
    else
      actStampaDef;
  end
  else
  begin
    W031SchedeQuantPosizionatiFM:=TW031FSchedeQuantPosizionatiFM.Create(Self);
    with W031SchedeQuantPosizionatiFM do
    begin
      Firmato:=Firma;
      Abilitazione:=IfThen(SolaLettura,'R','S');
      if (not SolaLettura) and (selT767.FieldByName('STATO').AsString = 'C') then
        Abilitazione:='R';
      TipoScheda:=Tipo;
      Anno:=cdsT768.FieldByName('ANNO').AsInteger;
      Prog:=cdsT768.FieldByName('PROGRESSIVO').AsInteger;
      if Tipo = '1' then
        Dip:=cdsT768.FieldByName('DIPENDENTE').AsString + ' - Scheda posizionati sanitari'
      else
        Dip:=cdsT768.FieldByName('DIPENDENTE').AsString + ' - Scheda posizionati amm./tecnici';

      selSG715.Close;
      selSG715.SetVariable('PROGRESSIVO',Prog);
      selSG715.SetVariable('ANNO',Anno);
      selSG715.Open;
      if selSG715.RecordCount <= 0 then
      begin
        selSG715.Insert;
        selSG715.FieldByName('PROGRESSIVO').AsInteger:=Prog;
        selSG715.FieldByName('ANNO').AsInteger:=Anno;
        selSG715.FieldByName('OBIETTIVO4').AsString:='Parte residua legata agli obiettivi di struttura ' + IntToStr(Anno);
        selSG715.FieldByName('PESO4').AsFloat:=100;
        selSG715.Post;
        SessioneOracle.Commit;
      end;
      Visualizza;
    end;
  end;
end;

procedure TW031FSchedeQuantIndividuali.actStampaDef;
var Agg:Boolean;
begin
  Agg:=False;
  if (selT768.SearchRecord('MATRICOLA',MatrStampa,[srFromBeginning])) and (selT768.FieldByName('CONFERMATO').AsString = 'N') then
  begin
    Agg:=True;
    if cdsT768.Locate('MATRICOLA',MatrStampa,[]) then
    begin
      //Controllo sul valutatore
      if (cdsT768.FieldByName('ACCETT_VALUTAZIONE').AsString = 'S') and
         (Trim(cdsT768.FieldByName('VALUTATORE').AsString) = '') then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Specificare il valutatore di riferimento!');
        Exit;
      end;
      //Controllo sul part-time
      if (cdsT768.FieldByName('PARTTIME').AsString <> '100') and
         (Pos('2',cdsT768.FieldByName('FLESSIBILITA').AsString) > 0) and
         (R180OreMinutiExt(cdsT768.FieldByName('NUMORE_ACCETTATE').AsString) <= 0) then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Specificare le ore accettate quando vengono confermati i progetti quantitativi (punto 2 della flessibilità)!');
        Exit;
      end;
      if (cdsT768.FieldByName('PARTTIME').AsString <> '100') and
         (Pos('2',cdsT768.FieldByName('FLESSIBILITA').AsString) <= 0) and
         (R180OreMinutiExt(cdsT768.FieldByName('NUMORE_ACCETTATE').AsString) > 0) then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Specificare la conferma dei progetti quantitativi (punto 2 della flessibilità) quando vengono accettate delle ore!');
        Exit;
      end;
    end;
    ValutatoreCambiato:=False;
    selT768.Edit;
    selT768.FieldByName('CONFERMATO').AsString:='S';
    selT768.Post;
    SessioneOracle.ApplyUpdates([selT768],True);
    if selT767.FieldByName('STATO').AsString = 'A' then
    begin
      selT767.Edit;
      selT767.FieldByName('STATO').AsString:='M';
      selT767.Post;
      SessioneOracle.Commit;
    end;
  end;
  StampaIndividuale(True);
  if Agg then
  begin
    selT768.Refresh;
    GetSchedeDip;
  end;
end;

procedure TW031FSchedeQuantIndividuali.actStampaProvv;
begin
  StampaIndividuale(False);
end;

procedure TW031FSchedeQuantIndividuali.StampaIndividuale(Definitiva:Boolean);
var
  rvComp:TRaveComponent;
  L:TStringList;
  NomeFile{,URL_Stampa}:String;
  dconnDettaglio:TRaveDataConnection;
  Ob2,Ob3,Ob4:Boolean;
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
    rvProject.ProjectFile:=gSC.ContentPath + 'report\W031StampaIncentiviQuantInd.rav';
    connDettaglio.Name:='connDettaglio';
    connDettaglio.DataSet:=selT768;
    connDettaglio.RuntimeVisibility:=RpCon.rtNone;
    // Posizionamento sulla matricola correntemente selezionata
    selT768.Filter:='MATRICOLA = ''' + MatrStampa + '''';
    selT768.Filtered:=True;
    rvProject.Open;
    rvProject.GetReportList(L,True);
    rvProject.SelectReport(L[0],True);
    rvDWDettaglio:=(rvProject.ProjMan.FindRaveComponent('dwDettaglio',nil) as TRaveDataView);
    // Impostazioni dei campi di Dettaglio
    dconnDettaglio:=CreateDataCon(connDettaglio);
    rvDWDettaglio.ConnectionName:=dconnDettaglio.Name;
    rvDWDettaglio.DataCon:=dconnDettaglio;
    CreateFields(rvDWDettaglio,nil,nil,True);
    rvPage:=rvProject.ProjMan.FindRaveComponent('W031.Page',nil);
    // Impostazioni della banda bndTitolo
    rvComp:=rvProject.ProjMan.FindRaveComponent('lblAzienda',rvPage);
    (rvComp as TRaveText).Text:=Parametri.RagioneSociale;
    rvComp:=rvProject.ProjMan.FindRaveComponent('lblTitolo',rvPage);
    (rvComp as TRaveText).Text:='INCENTIVI ' + Copy(cmbQuota.Text,7,Length(cmbQuota.Text) - 6) + ' ' + cmbAnno.Text;
    rvComp:=rvProject.ProjMan.FindRaveComponent('lblGruppo',rvPage);
    (rvComp as TRaveText).Text:='GRUPPO ' + cmbGruppo.Text;
    rvComp:=rvProject.ProjMan.FindRaveComponent('lblScheda',rvPage);
    if Definitiva then
      (rvComp as TRaveText).Text:='SCHEDA INDIVIDUALE DI'
    else
      (rvComp as TRaveText).Text:='SCHEDA INDIVIDUALE PROVVISORIA DI';
    // Impostazioni della banda bndDettaglio
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtDato1',rvPage);
    (rvComp as TRaveText).Text:=VarToStr(selI010.Lookup('NOME_CAMPO','T430' + Parametri.CampiRiferimento.C7_Dato1,'NOME_LOGICO'));
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtDato2',rvPage);
    (rvComp as TRaveText).Text:='';
    if Parametri.CampiRiferimento.C7_Dato2 <> '' then
      (rvComp as TRaveText).Text:=VarToStr(selI010.Lookup('NOME_CAMPO','T430' + Parametri.CampiRiferimento.C7_Dato2,'NOME_LOGICO'));
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtDato3',rvPage);
    (rvComp as TRaveText).Text:='';
    if Parametri.CampiRiferimento.C7_Dato3 <> '' then
      (rvComp as TRaveText).Text:=VarToStr(selI010.Lookup('NOME_CAMPO','T430' + Parametri.CampiRiferimento.C7_Dato3,'NOME_LOGICO'));
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtPT',rvPage);
    (rvComp as TRaveText).Visible:=selT768.FieldByName('PARTTIME').AsString <> '100';
    rvComp:=rvProject.ProjMan.FindRaveComponent('dtxtPT',rvPage);
    (rvComp as TRaveDataText).Visible:=selT768.FieldByName('PARTTIME').AsString <> '100';
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtFlex',rvPage);
    (rvComp as TRaveText).Visible:=selT768.FieldByName('FLESSIBILE').AsString <> '';
    rvComp:=rvProject.ProjMan.FindRaveComponent('dtxtFlex',rvPage);
    (rvComp as TRaveDataText).Visible:=selT768.FieldByName('FLESSIBILE').AsString <> '';
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtDescFlex',rvPage);
    (rvComp as TRaveText).Visible:=selT768.FieldByName('DESC_FLESSIBILITA').AsString <> '';
    rvComp:=rvProject.ProjMan.FindRaveComponent('memDescFlex',rvPage);
    (rvComp as TRaveMemo).Visible:=selT768.FieldByName('DESC_FLESSIBILITA').AsString <> '';
    (rvComp as TRaveMemo).Text:=StringReplace(selT768.FieldByName('DESC_FLESSIBILITA').AsString,' - ',#$D#$A,[rfReplaceAll]);
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtNote',rvPage);
    (rvComp as TRaveText).Visible:=Trim(selT768.FieldByName('NOTE').AsString) <> '';
    rvComp:=rvProject.ProjMan.FindRaveComponent('dtxtNote',rvPage);
    (rvComp as TRaveDataMemo).Visible:=Trim(selT768.FieldByName('NOTE').AsString) <> '';
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtValutatore',rvPage);
    (rvComp as TRaveText).Visible:=Trim(selT768.FieldByName('VALUTATORE').AsString) <> '';
    rvComp:=rvProject.ProjMan.FindRaveComponent('dtxtValutatore',rvPage);
    (rvComp as TRaveDataText).Visible:=Trim(selT768.FieldByName('VALUTATORE').AsString) <> '';
    rvComp:=rvProject.ProjMan.FindRaveComponent('lblObiettiviSpec',rvPage);
    (rvComp as TRaveText).Visible:=Tipo <> '0';
    rvComp:=rvProject.ProjMan.FindRaveComponent('lblPesi',rvPage);
    (rvComp as TRaveText).Visible:=Tipo <> '0';
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo1',rvPage);
    (rvComp as TRaveMemo).Visible:=Tipo <> '0';
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso1',rvPage);
    (rvComp as TRaveText).Visible:=Tipo <> '0';
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo2',rvPage);
    (rvComp as TRaveMemo).Visible:=Tipo <> '0';
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso2',rvPage);
    (rvComp as TRaveText).Visible:=Tipo <> '0';
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo3',rvPage);
    (rvComp as TRaveMemo).Visible:=Tipo <> '0';
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso3',rvPage);
    (rvComp as TRaveText).Visible:=Tipo <> '0';
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo4',rvPage);
    (rvComp as TRaveMemo).Visible:=Tipo <> '0';
    rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso4',rvPage);
    (rvComp as TRaveText).Visible:=Tipo <> '0';
    rvComp:=rvProject.ProjMan.FindRaveComponent('HLineObiettiviSpec',rvPage);
    (rvComp as TRaveHLine).Visible:=Tipo <> '0';
    if Tipo <> '0' then
    begin
      selSG715.Refresh;
      Ob2:=False;
      Ob3:=False;
      Ob4:=False;
      //Riga 1
      if Trim(selSG715.FieldByName('OBIETTIVO1').AsString) <> '' then
      begin
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo1',rvPage);
        (rvComp as TRaveMemo).Text:=selSG715.FieldByName('OBIETTIVO1').AsString;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso1',rvPage);
        (rvComp as TRaveText).Text:=selSG715.FieldByName('PESO1').AsString;
      end
      else if Trim(selSG715.FieldByName('OBIETTIVO2').AsString) <> '' then
      begin
        Ob2:=True;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo1',rvPage);
        (rvComp as TRaveMemo).Text:=selSG715.FieldByName('OBIETTIVO2').AsString;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso1',rvPage);
        (rvComp as TRaveText).Text:=selSG715.FieldByName('PESO2').AsString;
      end
      else if Trim(selSG715.FieldByName('OBIETTIVO3').AsString) <> '' then
      begin
        Ob3:=True;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo1',rvPage);
        (rvComp as TRaveMemo).Text:=selSG715.FieldByName('OBIETTIVO3').AsString;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso1',rvPage);
        (rvComp as TRaveText).Text:=selSG715.FieldByName('PESO3').AsString;
      end
      else if Trim(selSG715.FieldByName('OBIETTIVO4').AsString) <> '' then
      begin
        Ob4:=True;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo1',rvPage);
        (rvComp as TRaveMemo).Text:=selSG715.FieldByName('OBIETTIVO4').AsString;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso1',rvPage);
        (rvComp as TRaveText).Text:=selSG715.FieldByName('PESO4').AsString;
      end;
      //Riga 2
      if (not Ob2) and (Trim(selSG715.FieldByName('OBIETTIVO2').AsString) <> '') then
      begin
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo2',rvPage);
        (rvComp as TRaveMemo).Text:=selSG715.FieldByName('OBIETTIVO2').AsString;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso2',rvPage);
        (rvComp as TRaveText).Text:=selSG715.FieldByName('PESO2').AsString;
      end
      else if (not Ob3) and (Trim(selSG715.FieldByName('OBIETTIVO3').AsString) <> '') then
      begin
        Ob3:=True;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo2',rvPage);
        (rvComp as TRaveMemo).Text:=selSG715.FieldByName('OBIETTIVO3').AsString;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso2',rvPage);
        (rvComp as TRaveText).Text:=selSG715.FieldByName('PESO3').AsString;
      end
      else if (not Ob4) and (Trim(selSG715.FieldByName('OBIETTIVO4').AsString) <> '') then
      begin
        Ob4:=True;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo2',rvPage);
        (rvComp as TRaveMemo).Text:=selSG715.FieldByName('OBIETTIVO4').AsString;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso2',rvPage);
        (rvComp as TRaveText).Text:=selSG715.FieldByName('PESO4').AsString;
      end;
      //Riga 3
      if (not Ob3) and (Trim(selSG715.FieldByName('OBIETTIVO3').AsString) <> '') then
      begin
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo3',rvPage);
        (rvComp as TRaveMemo).Text:=selSG715.FieldByName('OBIETTIVO3').AsString;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso3',rvPage);
        (rvComp as TRaveText).Text:=selSG715.FieldByName('PESO3').AsString;
      end
      else if (not Ob4) and (Trim(selSG715.FieldByName('OBIETTIVO4').AsString) <> '') then
      begin
        Ob4:=True;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo3',rvPage);
        (rvComp as TRaveMemo).Text:=selSG715.FieldByName('OBIETTIVO4').AsString;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso3',rvPage);
        (rvComp as TRaveText).Text:=selSG715.FieldByName('PESO4').AsString;
      end;
      //Riga 4
      if (not Ob4) and (Trim(selSG715.FieldByName('OBIETTIVO4').AsString) <> '') then
      begin
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtObiettivo4',rvPage);
        (rvComp as TRaveMemo).Text:=selSG715.FieldByName('OBIETTIVO4').AsString;
        rvComp:=rvProject.ProjMan.FindRaveComponent('txtPeso4',rvPage);
        (rvComp as TRaveText).Text:=selSG715.FieldByName('PESO4').AsString;
      end;
    end;
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
    VisualizzaFile(NomeFile,'Anteprima stampa scheda',nil,nil);
  finally
    L.Free;
    rvProject.Close;
    FreeAndNil(dconnDettaglio);
    FreeAndNil(rvSystem);
    FreeAndNil(rvRenderPDF);
    FreeAndNil(rvProject);
    FreeAndNil(connDettaglio);
    CSStampa.Leave;
    selT768.Filter:='';
    selT768.Filtered:=False;
  end;
end;

procedure TW031FSchedeQuantIndividuali.CreaComponentiGriglia;
var i:Integer;
begin
  for i:=0 to High(grdSchedeDip.medpCompGriglia) do
  begin
    if grdSchedeDip.medpValoreColonna(i,'FIRMA') = 'NO' then
    begin
      //Flessibilità
      if grdSchedeDip.medpValoreColonna(i,'PARTTIME') <> '100' then
      begin
        grdSchedeDip.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','1','','','S');
        grdSchedeDip.medpPreparaComponenteGenerico('C',0,1,DBG_CHK,'','2','','','S');
        grdSchedeDip.medpPreparaComponenteGenerico('C',0,2,DBG_CHK,'','3','','','S');
        grdSchedeDip.medpPreparaComponenteGenerico('C',0,3,DBG_CHK,'','4','','','S');
        grdSchedeDip.medpCreaComponenteGenerico(i,3,grdSchedeDip.Componenti);
        (grdSchedeDip.medpCompCella(i,3,0) as TmeIWCheckBox).Checked:=False;
        (grdSchedeDip.medpCompCella(i,3,1) as TmeIWCheckBox).Checked:=False;
        (grdSchedeDip.medpCompCella(i,3,2) as TmeIWCheckBox).Checked:=False;
        (grdSchedeDip.medpCompCella(i,3,3) as TmeIWCheckBox).Checked:=False;

        (grdSchedeDip.medpCompCella(i,3,0) as TmeIWCheckBox).OnClick:=chkControlloClick;
        (grdSchedeDip.medpCompCella(i,3,1) as TmeIWCheckBox).OnClick:=chkControlloClick;
        (grdSchedeDip.medpCompCella(i,3,2) as TmeIWCheckBox).OnClick:=chkControlloClick;
        (grdSchedeDip.medpCompCella(i,3,3) as TmeIWCheckBox).OnClick:=chkControlloClick;
        (grdSchedeDip.medpCompCella(i,3,3) as TmeIWCheckBox).FriendlyName:=IntToStr(i);
      end;
      //Note
      grdSchedeDip.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'20','','','','S');
      grdSchedeDip.medpCreaComponenteGenerico(i,4,grdSchedeDip.Componenti);
      (grdSchedeDip.medpCompCella(i,4,0) as TmeIWMemo).Text:='';
      //Num.ore accettate
      grdSchedeDip.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'input_hour_hhhmm width4chr','','','','S');
      grdSchedeDip.medpCreaComponenteGenerico(i,6,grdSchedeDip.Componenti);
      (grdSchedeDip.medpCompCella(i,6,0) as TmeIWEdit).Text:='';
      //Informato su obiettivi
      grdSchedeDip.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','','','','S');
      grdSchedeDip.medpCreaComponenteGenerico(i,9,grdSchedeDip.Componenti);
      (grdSchedeDip.medpCompCella(i,9,0) as TmeIWCheckBox).Checked:=False;
      //(grdSchedeDip.medpCompCella(i,9,0) as TmeIWCheckBox).OnAsyncClick:=chkControlloClick;
      (grdSchedeDip.medpCompCella(i,9,0) as TmeIWCheckBox).OnClick:=chkControlloClick;
      //Accetta valutazione
      grdSchedeDip.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','','','','S');
      grdSchedeDip.medpCreaComponenteGenerico(i,10,grdSchedeDip.Componenti);
      (grdSchedeDip.medpCompCella(i,10,0) as TmeIWCheckBox).Checked:=False;
      //(grdSchedeDip.medpCompCella(i,10,0) as TmeIWCheckBox).OnAsyncClick:=chkControlloClick;
      (grdSchedeDip.medpCompCella(i,10,0) as TmeIWCheckBox).OnClick:=chkControlloClick;
      //Valutatore
      grdSchedeDip.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'20','','','','S');
      grdSchedeDip.medpCreaComponenteGenerico(i,11,grdSchedeDip.Componenti);
      with (grdSchedeDip.medpCompCella(i,11,0) as TmeIWComboBox) do
      begin
        RenderSize:=False;
        UseSize:=False;
        NoSelectionText:=' ';
        ItemsHaveValues:=False;
        Items.Clear;
        Items.Add('');
        selValutatori.First;
        while not selValutatori.Eof do
        begin
          Items.Add(selValutatori.FieldByName('VALUTATORE').AsString);
          selValutatori.Next;
        end;
        ItemIndex:=0;
      end;
    end;
  end;
end;

procedure TW031FSchedeQuantIndividuali.chkControlloClick(Sender:TObject);
//procedure TW031FSchedeQuantIndividuali.chkControlloClick(Sender: TObject; EventParams: TStringList);
var s:String;
begin //Bisogna forzare l'evento perchè altrimenti non funziona
  if ((Sender as TmeIWCheckBox).Checked) and ((Sender as TmeIWCheckBox).Text = '4') then
  begin
    s:=Trim((grdSchedeDip.medpCompCella(StrToIntDef((Sender as TmeIWCheckBox).FriendlyName,0),4,0) as TmeIWMemo).Text);
    s:=StringReplace(s,#$D + #$A,'\r\n',[rfReplaceAll]);
    if Pos('PER IL PUNTO 4 SPECIFICARE IL TIPO DI FLESSIBILITA''',s) > 0 then
      Exit;
    if s <> '' then
      //S:=S + #$D#$A;
      s:=s + '\r\n';
    s:=s + 'PER IL PUNTO 4 SPECIFICARE IL TIPO DI FLESSIBILITA''';
    (grdSchedeDip.medpCompCella(StrToIntDef((Sender as TmeIWCheckBox).FriendlyName,0),4,0) as TmeIWMemo).Text:=s;
  end;
end;

procedure TW031FSchedeQuantIndividuali.chkSupervisoreClick(Sender:TObject);
begin
  inherited;
  cmbSupervisore.Enabled:=chkSupervisore.Checked;
  if not chkSupervisore.Checked then
    cmbSupervisore.ItemIndex:=-1;
end;

procedure TW031FSchedeQuantIndividuali.TrasformaComponenti(FN:String);
// Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdPesiDip
var
  i:Integer;
begin
  // pre: not SolaLettura
  if FN = 'S' then
  begin
    CreaComponentiGriglia;
    for i:=0 to High(grdSchedeDip.medpCompGriglia) do
    begin
      if grdSchedeDip.medpValoreColonna(i,'FIRMA') = 'NO' then
      begin
        if grdSchedeDip.medpValoreColonna(i,'PARTTIME') <> '100' then
        begin
          (grdSchedeDip.medpCompCella(i,3,0) as TmeIWCheckBox).Checked:=Pos('1',grdSchedeDip.medpValoreColonna(i,'FLESSIBILITA')) > 0;
          (grdSchedeDip.medpCompCella(i,3,1) as TmeIWCheckBox).Checked:=Pos('2',grdSchedeDip.medpValoreColonna(i,'FLESSIBILITA')) > 0;
          (grdSchedeDip.medpCompCella(i,3,2) as TmeIWCheckBox).Checked:=Pos('3',grdSchedeDip.medpValoreColonna(i,'FLESSIBILITA')) > 0;
          (grdSchedeDip.medpCompCella(i,3,3) as TmeIWCheckBox).Checked:=Pos('4',grdSchedeDip.medpValoreColonna(i,'FLESSIBILITA')) > 0;
        end;
        (grdSchedeDip.medpCompCella(i,4,0) as TmeIWMemo).Text:=grdSchedeDip.medpValoreColonna(i,'NOTE');
        (grdSchedeDip.medpCompCella(i,6,0) as TmeIWEdit).Text:=grdSchedeDip.medpValoreColonna(i,'NUMORE');
        (grdSchedeDip.medpCompCella(i,9,0) as TmeIWCheckBox).Checked:=False;
        if grdSchedeDip.medpValoreColonna(i,'INF_OBIETTIVI') = 'S' then
          (grdSchedeDip.medpCompCella(i,9,0) as TmeIWCheckBox).Checked:=True;
        (grdSchedeDip.medpCompCella(i,10,0) as TmeIWCheckBox).Checked:=False;
        if grdSchedeDip.medpValoreColonna(i,'ACCETT_VALUTAZIONE') = 'S' then
          (grdSchedeDip.medpCompCella(i,10,0) as TmeIWCheckBox).Checked:=True;
        (grdSchedeDip.medpCompCella(i,11,0) as TmeIWComboBox).ItemIndex:=(grdSchedeDip.medpCompCella(i,11,0) as TmeIWComboBox).Items.IndexOf(grdSchedeDip.medpValoreColonna(i,'VALUTATORE'));
      end;
    end;
  end
  else
  begin
    // Annullamento componenti
    for i:=0 to High(grdSchedeDip.medpCompGriglia) do
    begin
      FreeAndNil(grdSchedeDip.medpCompGriglia[i].CompColonne[3]);
      FreeAndNil(grdSchedeDip.medpCompGriglia[i].CompColonne[4]);
      FreeAndNil(grdSchedeDip.medpCompGriglia[i].CompColonne[6]);
      FreeAndNil(grdSchedeDip.medpCompGriglia[i].CompColonne[9]);
      FreeAndNil(grdSchedeDip.medpCompGriglia[i].CompColonne[10]);
      FreeAndNil(grdSchedeDip.medpCompGriglia[i].CompColonne[11]);
    end;
  end;
end;

function TW031FSchedeQuantIndividuali.ModificheRiga(FN:String):Boolean;
{ Restituisce True/False a seconda che il record sia stato modificato o meno }
var i:Integer;
begin
  Result:=False;
  cdsT768.First;
  i:=0;
  while not cdsT768.Eof do
  begin
    if (cdsT768.FieldByName('FIRMA').AsString = 'NO') then
    begin
      if (cdsT768.FieldByName('PARTTIME').AsString <> '100') and
        ((((grdSchedeDip.medpCompCella(i,3,0) as TmeIWCheckBox).Checked) and (Pos('1',cdsT768.FieldByName('FLESSIBILITA').AsString) <= 0)) or
        ((not (grdSchedeDip.medpCompCella(i,3,0) as TmeIWCheckBox).Checked) and (Pos('1',cdsT768.FieldByName('FLESSIBILITA').AsString) > 0)) or
        (((grdSchedeDip.medpCompCella(i,3,1) as TmeIWCheckBox).Checked) and (Pos('2',cdsT768.FieldByName('FLESSIBILITA').AsString) <= 0)) or
        ((not (grdSchedeDip.medpCompCella(i,3,1) as TmeIWCheckBox).Checked) and (Pos('2',cdsT768.FieldByName('FLESSIBILITA').AsString) > 0)) or
        (((grdSchedeDip.medpCompCella(i,3,2) as TmeIWCheckBox).Checked) and (Pos('3',cdsT768.FieldByName('FLESSIBILITA').AsString) <= 0)) or
        ((not (grdSchedeDip.medpCompCella(i,3,2) as TmeIWCheckBox).Checked) and (Pos('3',cdsT768.FieldByName('FLESSIBILITA').AsString) > 0)) or
        (((grdSchedeDip.medpCompCella(i,3,3) as TmeIWCheckBox).Checked) and (Pos('4',cdsT768.FieldByName('FLESSIBILITA').AsString) <= 0)) or
        ((not (grdSchedeDip.medpCompCella(i,3,3) as TmeIWCheckBox).Checked) and (Pos('4',cdsT768.FieldByName('FLESSIBILITA').AsString) > 0))) then
      begin
        Result:=True;
        Break;
      end;
      if cdsT768.FieldByName('NOTE').AsString <> Trim((grdSchedeDip.medpCompCella(i,4,0) as TmeIWMemo).Text) then
      begin
        Result:=True;
        Break;
      end;
      if cdsT768.FieldByName('NUMORE').AsString <> (grdSchedeDip.medpCompCella(i,6,0) as TmeIWEdit).Text then
      begin
        Result:=True;
        Break;
      end;
      if ((cdsT768.FieldByName('INF_OBIETTIVI').AsString = 'N') and ((grdSchedeDip.medpCompCella(i,9,0) as TmeIWCheckBox).Checked)) or ((cdsT768.FieldByName('INF_OBIETTIVI').AsString = 'S') and (not (grdSchedeDip.medpCompCella(i,9,0) as TmeIWCheckBox).Checked)) then
      begin
        Result:=True;
        Break;
      end;
      if ((cdsT768.FieldByName('ACCETT_VALUTAZIONE').AsString = 'N') and ((grdSchedeDip.medpCompCella(i,10,0) as TmeIWCheckBox).Checked)) or ((cdsT768.FieldByName('ACCETT_VALUTAZIONE').AsString = 'S') and (not (grdSchedeDip.medpCompCella(i,10,0) as TmeIWCheckBox).Checked)) then
      begin
        Result:=True;
        Break;
      end;
      if cdsT768.FieldByName('VALUTATORE').AsString <> (grdSchedeDip.medpCompCella(i,11,0) as TmeIWComboBox).Text then
      begin
        Result:=True;
        Break;
      end;
    end;
    cdsT768.Next;
    i:=i + 1;
  end;
end;

procedure TW031FSchedeQuantIndividuali.actVariazioneOK;
// controlli ok -> variazione record di pianificazione
var i:Integer;
  s:String;
begin
  cdsT768.First;
  i:=0;
  ValutatoreCambiato:=False;
  while not cdsT768.Eof do
  begin
    if cdsT768.FieldByName('FIRMA').AsString = 'NO' then
    begin
      if (cdsT768.FieldByName('PARTTIME').AsString <> '100') and ((((grdSchedeDip.medpCompCella(i,3,0) as TmeIWCheckBox).Checked) and (Pos('1',cdsT768.FieldByName('FLESSIBILITA').AsString) <= 0)) or ((not (grdSchedeDip.medpCompCella(i,3,0) as TmeIWCheckBox).Checked) and (Pos('1',cdsT768.FieldByName('FLESSIBILITA').AsString) > 0)) or (((grdSchedeDip.medpCompCella(i,3,1) as TmeIWCheckBox).Checked) and (Pos('2',cdsT768.FieldByName('FLESSIBILITA').AsString) <= 0)) or ((not (grdSchedeDip.medpCompCella(i,3,1) as TmeIWCheckBox).Checked) and (Pos('2',cdsT768.FieldByName('FLESSIBILITA').AsString) > 0)) or (((grdSchedeDip.medpCompCella(i,3,2) as TmeIWCheckBox).Checked) and (Pos('3',cdsT768.FieldByName('FLESSIBILITA').AsString) <= 0)) or ((not (grdSchedeDip.medpCompCella(i,3,2) as TmeIWCheckBox).Checked) and (Pos('3',cdsT768.FieldByName('FLESSIBILITA').AsString) > 0)) or (((grdSchedeDip.medpCompCella(i,3,3) as TmeIWCheckBox).Checked) and (Pos('4',cdsT768.FieldByName('FLESSIBILITA').AsString) <= 0)) or
         ((not (grdSchedeDip.medpCompCella(i,3,3) as TmeIWCheckBox).Checked) and (Pos('4',cdsT768.FieldByName('FLESSIBILITA').AsString) > 0))) or (cdsT768.FieldByName('NOTE').AsString <> Trim((grdSchedeDip.medpCompCella(i,4,0) as TmeIWMemo).Text)) or (cdsT768.FieldByName('NUMORE').AsString <> (grdSchedeDip.medpCompCella(i,6,0) as TmeIWEdit).Text) or ((cdsT768.FieldByName('INF_OBIETTIVI').AsString = 'N') and ((grdSchedeDip.medpCompCella(i,9,0) as TmeIWCheckBox).Checked)) or ((cdsT768.FieldByName('INF_OBIETTIVI').AsString = 'S') and (not (grdSchedeDip.medpCompCella(i,9,0) as TmeIWCheckBox).Checked)) or ((cdsT768.FieldByName('ACCETT_VALUTAZIONE').AsString = 'N') and ((grdSchedeDip.medpCompCella(i,10,0) as TmeIWCheckBox).Checked)) or ((cdsT768.FieldByName('ACCETT_VALUTAZIONE').AsString = 'S') and (not (grdSchedeDip.medpCompCella(i,10,0) as TmeIWCheckBox).Checked)) or
         ((cdsT768.FieldByName('VALUTATORE').AsString <> (grdSchedeDip.medpCompCella(i,11,0) as TmeIWComboBox).Text)) then
      //forzo anche per il valutatore altrimenti non scatta l'apply record e quindi l'aggiornamento di SG706
      begin
        if selT768.SearchRecord('PROGRESSIVO',cdsT768.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
        begin
          if ((cdsT768.FieldByName('VALUTATORE').AsString <> (grdSchedeDip.medpCompCella(i,11,0) as TmeIWComboBox).Text)) then
            ValutatoreCambiato:=True;
          selT768.Edit;
          s:='';
          if selT768.FieldByName('PARTTIME').AsString <> '100' then
          begin
            if (grdSchedeDip.medpCompCella(i,3,0) as TmeIWCheckBox).Checked then
              s:='1';
            if (grdSchedeDip.medpCompCella(i,3,1) as TmeIWCheckBox).Checked then
            begin
              if Trim(s) <> '' then
                s:=s + ',';
              s:=s + '2';
            end;
            if (grdSchedeDip.medpCompCella(i,3,2) as TmeIWCheckBox).Checked then
            begin
              if Trim(s) <> '' then
                s:=s + ',';
              s:=s + '3';
            end;
            if (grdSchedeDip.medpCompCella(i,3,3) as TmeIWCheckBox).Checked then
            begin
              if Trim(s) <> '' then
                s:=s + ',';
              s:=s + '4';
            end;
          end;
          selT768.FieldByName('FLESSIBILITA').AsString:=s;
          selT768.FieldByName('NOTE').AsString:=Trim((grdSchedeDip.medpCompCella(i,4,0) as TmeIWMemo).Text);
          selT768.FieldByName('NUMORE_ACCETTATE').AsString:=(grdSchedeDip.medpCompCella(i,6,0) as TmeIWEdit).Text;
          selT768.FieldByName('TOTALE_ACCETTATO').AsFloat:=R180Arrotonda(selT768.FieldByName('IMPORTO_ORARIO').AsFloat * StrToFloatDef(StringReplace(R180Centesimi(R180OreMinutiExt(selT768.FieldByName('NUMORE_ACCETTATE').AsString)),'.',',',[rfReplaceAll]),0),0.01,'P');
          selT768.FieldByName('INF_OBIETTIVI').AsString:=IfThen((grdSchedeDip.medpCompCella(i,9,0) as TmeIWCheckBox).Checked,'S','N');
          selT768.FieldByName('ACCETT_VALUTAZIONE').AsString:=IfThen((grdSchedeDip.medpCompCella(i,10,0) as TmeIWCheckBox).Checked,'S','N');
          try
            RegistraLog.SettaProprieta('M','T768_INCQUANTINDIVIDUALI',medpCodiceForm,nil,True);
            selT768.Post;
          except
            on E:Exception do
              GGetWebApplicationThreadVar.ShowMessage('Variazione della scheda fallita!' + CRLF + 'Motivo: ' + E.Message);
          end;
        end;
      end;
    end;
    cdsT768.Next;
    i:=i + 1;
  end;
end;

procedure TW031FSchedeQuantIndividuali.grdSchedeDipAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
begin
  for i:=0 to High(grdSchedeDip.medpCompGriglia) do
  begin
    with (grdSchedeDip.medpCompCella(i,0,0) as TmeIWImageFile) do
    begin
      OnClick:=imgStampaIndClick;
      Hint:='Stampa scheda individuale';
    end;
    (grdSchedeDip.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgSchedaAnagraficaClick;
  end;
end;

procedure TW031FSchedeQuantIndividuali.grdSchedeDipRenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer);
begin
  if not RenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  ACell.Wrap:=ARow = 0;

  // assegnazione stili
  if (ARow > 0) and (AColumn = 12) and (ACell.Text = 'N') then //evidenzio Firma = 'N'
    ACell.Css:=ACell.Css + ' font_grassetto font_rosso';

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdSchedeDip.medpCompGriglia) + 1) and (grdSchedeDip.medpCompGriglia[ARow - 1].CompColonne[AColumn] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdSchedeDip.medpCompGriglia[ARow - 1].CompColonne[AColumn];
  end;
end;

procedure TW031FSchedeQuantIndividuali.grdQuoteQualRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if not RenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
end;

procedure TW031FSchedeQuantIndividuali.grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if not RenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if (ARow > 0) and (AColumn in [5,6]) then
    ACell.Css:='riga_colorata';

  // assegnazione stili
  if (ARow > 0) and (AColumn = 5) and (R180OreMinutiExt(grdRiepilogo.Cell[1,3].Text) <> 0) and (TotaleOreAccett > R180OreMinutiExt(grdRiepilogo.Cell[1,3].Text)) then
    ACell.Css:=ACell.Css + ' font_grassetto align_center font_rosso';
  if (ARow > 0) and (AColumn = 6) and (StrToFloatDef(StringReplace(grdRiepilogo.Cell[1,4].Text,'.','',[rfReplaceAll]),0) <> 0) and (R180AzzeraPrecisione(StrToFloatDef(StringReplace(grdRiepilogo.Cell[1,4].Text,'.','',[rfReplaceAll]),0) - TotaleAccett,2) < 0) then
    ACell.Css:=ACell.Css + ' font_grassetto align_center font_rosso';
end;

procedure TW031FSchedeQuantIndividuali.DBGridColumnClick(ASender:TObject; const AValue:string);
begin
  inherited;
  cdsT768.Locate('DBG_ROWID',AValue,[]);
end;

procedure TW031FSchedeQuantIndividuali.DistruggiOggetti;
begin
  selValutatori.Close;
  grdSchedeDip.medpClearCompGriglia;
  R180CloseDataSetTag0(selT768);
  SetLength(ArrDipendenti,0);
  FreeAndNil(selI010);
end;

procedure TW031FSchedeQuantIndividuali.rgpTipoSchedeClick(Sender: TObject);
begin
  inherited;
  GetSchedeDip;
  InizializzaAccesso;
end;

procedure TW031FSchedeQuantIndividuali.selT767AfterScroll(DataSet: TDataSet);
begin
  inherited;
  R180SetVariable(selValutatori,'AZIENDA',Parametri.Azienda);
  R180SetVariable(selValutatori,'DATA',EncodeDate(selT767.FieldByName('ANNO').AsInteger,12,31));
  selValutatori.Open;
  selValutatori.First;
  cmbSupervisore.Items.Clear;
  while not selValutatori.Eof do
  begin
    cmbSupervisore.Items.Add(selValutatori.FieldByName('VALUTATORE').AsString);
    selValutatori.Next;
  end;
  cmbSupervisore.ItemIndex:=-1;
end;

procedure TW031FSchedeQuantIndividuali.selT767DatiFilterRecord(DataSet:TDataSet; var Accept:Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('GRUPPI SC.QUANTITATIVE IND.',DataSet.FieldByName('CODGRUPPO').AsString)
end;

procedure TW031FSchedeQuantIndividuali.selT768ApplyRecord(Sender:TOracleDataSet; Action:Char; var Applied:Boolean; var NewRowId:string);
var i:Integer;
begin
  inherited;
  if (Action <> 'U') and (not ValutatoreCambiato) then
    Exit;
  RegistraLog.RegistraOperazione;
  if ValutatoreCambiato then
  begin
    cdsT768.First;
    i:=0;
    while not cdsT768.Eof do
    begin
      if cdsT768.FieldByName('FIRMA').AsString = 'NO' then
      begin
        if (cdsT768.FieldByName('VALUTATORE').AsString <> (grdSchedeDip.medpCompCella(i,11,0) as TmeIWComboBox).Text) then
        begin
          //Se ho cambiato il valutatore aggiorno l'assegnazione eccezionale
          CambioValutatore.SetVariable('PROGRESSIVO_VALUTATO',cdsT768.FieldByName('PROGRESSIVO').AsInteger);
          CambioValutatore.SetVariable('DINI',StrToDate('01/01/' + cmbAnno.Text));
          CambioValutatore.SetVariable('DFIN',StrToDate('31/12/' + cmbAnno.Text));
          CambioValutatore.SetVariable('PROGRESSIVO_VALUTATORE_NEW',StrToIntDef(VarToStr(selValutatori.Lookup('VALUTATORE',(grdSchedeDip.medpCompCella(i,11,0) as TmeIWComboBox).Text,'PROGRESSIVO')),0));
          try
            CambioValutatore.Execute;
            RegistraLog.SettaProprieta('I','SG706_VALUTATORI_DIPENDENTE',medpCodiceForm,nil,True);
            RegistraLog.InserisciDato('PROGRESSIVO','',VarToStr(selValutatori.Lookup('VALUTATORE',(grdSchedeDip.medpCompCella(i,11,0) as TmeIWComboBox).Text,'PROGRESSIVO')));
            RegistraLog.InserisciDato('DECORRENZA','','01/01/' + cmbAnno.Text);
            RegistraLog.InserisciDato('DECORRENZA_FINE','','31/12/' + cmbAnno.Text);
            RegistraLog.InserisciDato('PROGRESSIVO_VALUTATO','',cdsT768.FieldByName('PROGRESSIVO').AsString);
            RegistraLog.RegistraOperazione;
          except
          on E:Exception do
            GGetWebApplicationThreadVar.ShowMessage('Aggiornamento del valutatore fallito!' + CRLF + 'Motivo: ' + E.Message);
          end;
        end;
      end;
      cdsT768.Next;
      i:=i + 1;
    end;
  end;
end;

procedure TW031FSchedeQuantIndividuali.btnVisualizzaClick(Sender:TObject);
begin
  GetSchedeDip;
  InizializzaAccesso;
end;

procedure TW031FSchedeQuantIndividuali.lnkIstruzioniClick(Sender: TObject);
var URLDoc:String;
begin
  selT760.Open;
  URLDoc:=ExtractFileName(selT760.FieldByName('FILE_ISTRUZIONI').AsString);
  VisualizzaFile(URLDoc,'Istruzioni',nil,nil,fdGlobal);
  selT760.Close;
end;

procedure TW031FSchedeQuantIndividuali.lnkLegendaFlexClick(Sender: TObject);
begin
  W031LegendaFlexFM:=TW031FLegendaFlexFM.Create(Self);
  W031LegendaFlexFM.Visualizza;
end;

end.
