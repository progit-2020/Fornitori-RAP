unit W022UDettaglioValutazioni;

interface

uses
  DBClient, Classes, SysUtils, IWTemplateProcessorHTML, IWForm, IWAppForm,
  IWCompLabel, IWHTMLControls, Controls, IWControl,
  IWCompEdit, IWCompButton, IWCompCheckbox, Math, StrUtils,
  DB, Oracle, OracleData, Graphics, WC012UVisualizzaFileFM,
  IWBaseControl, Variants, RpCon, RpConDS, RpSystem, RpDefine,
  RpRave, RVCsStd, RVCsData, RVData, RvDirectDataView, RpRender, RpRenderPDF,
  RVClass, RVProj, RVCsDraw, RegistrazioneLog,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWVCLBaseControl, IWBaseHTMLControl, IWCompListbox,
  A000UInterfaccia, A000USessione, A000UCostanti,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPaginaWeb,
  W022USchedaValutazioniDtM,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWRegion, Forms,
  IWVCLComponent, R012UWebAnagrafico, MConnect, IWHTML40Container,
  IWDBGrids, IWDBStdCtrls, IWCompMemo, ActnList,
  medpIWDBGrid, W022ULegendaPunteggiFM, meIWGrid,
  medpIWTabControl, meIWLabel, meIWDBEdit, meIWCheckBox,
  IWCompExtCtrls, IWCompGrids, meIWImageFile, meIWLink, meIWComboBox,
  meIWDBLabel, meIWDBLookupComboBox, meIWButton,
  medpIWMultiColumnComboBox, IWCompJQueryWidget, meIWMemo, meIWEdit, meIWRegion;

type
  TW022FDettaglioValutazioni = class(TR012FWebAnagrafico)
    DCOMConnection1: TDCOMConnection;
    btnModifica: TmeIWButton;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    btnModificaDettaglio: TmeIWButton;
    btnConfermaDettaglio: TmeIWButton;
    btnAnnullaDettaglio: TmeIWButton;
    cdsRiepilogo: TClientDataSet;
    cdsDettaglio: TClientDataSet;
    btnInserisciDettaglio: TmeIWButton;
    btnCancellaDettaglio: TmeIWButton;
    dgrdDettaglio: TmedpIWDBGrid;
    dsrQ711: TDataSource;
    cdsQ711: TClientDataSet;
    tpGenerale: TIWTemplateProcessorHTML;
    tpValutazioniComplessive: TIWTemplateProcessorHTML;
    tpObiettiviPianificati: TIWTemplateProcessorHTML;
    tpProposteFormative: TIWTemplateProcessorHTML;
    tpCommentiValutato: TIWTemplateProcessorHTML;
    tbValutazioni: TmedpIWTabControl;
    lnkIstrVal: TmeIWLink;
    btnStampa: TmeIWButton;
    chkLegendaPunteggi: TmeIWCheckBox;
    JQuery: TIWJQueryWidget;
    tpNote: TIWTemplateProcessorHTML;
    W022GeneraleRG: TmeIWRegion;
    lblData: TmeIWLabel;
    lblDataCompilazione: TmeIWLabel;
    dedtDataCompilazione: TmeIWDBEdit;
    lblPunteggioFinalePesato: TmeIWLabel;
    dedtPunteggioFinalePesato: TmeIWDBEdit;
    lblValutatore: TmeIWLabel;
    dedtAnno: TmeIWDBEdit;
    dlblStatoScheda: TmeIWDBLabel;
    lblValutato: TmeIWLabel;
    dlblValutato: TmeIWLabel;
    cmbValutatore: TmeIWComboBox;
    chkValutabile: TmeIWCheckBox;
    btnAvanzaStato: TmeIWButton;
    btnRetrocediStato: TmeIWButton;
    btnChiudiScheda: TmeIWButton;
    btnRiapriScheda: TmeIWButton;
    lblStatoScheda: TmeIWLabel;
    btnBloccaScheda: TmeIWButton;
    btnSbloccaScheda: TmeIWButton;
    dedtDal: TmeIWDBEdit;
    dedtAl: TmeIWDBEdit;
    W022ValutazioniComplessiveRG: TmeIWRegion;
    lblValutazioniComplessive: TmeIWLabel;
    dmemValutazioniComplessive: TmeIWMemo;
    W022ObiettiviPianificatiRG: TmeIWRegion;
    lblObiettiviPianificati: TmeIWLabel;
    dedtImportoIncentivo: TmeIWDBEdit;
    dedtOrarioNegoziato: TmeIWDBEdit;
    lblImportoIncentivo: TmeIWLabel;
    lblOrarioNegoziato: TmeIWLabel;
    lblAccettazioneObiettivi: TmeIWLabel;
    chkAccettazioneObiettiviSi: TmeIWCheckBox;
    chkAccettazioneObiettiviNo: TmeIWCheckBox;
    grdRiepilogoIncentivi: TmeIWGrid;
    lblGruppoIncentivi: TmeIWLabel;
    dmemObiettiviPianificati: TmeIWMemo;
    W022ProposteFormativeRG: TmeIWRegion;
    lblProposteFormative: TmeIWLabel;
    dcmbProposteFormative1: TmeIWDBLookupComboBox;
    lblProposteFormative11: TmeIWLabel;
    lblProposteFormative12: TmeIWLabel;
    lblProposteFormative21: TmeIWLabel;
    lblProposteFormative22: TmeIWLabel;
    dcmbProposteFormative2: TmeIWDBLookupComboBox;
    lblProposteFormative31: TmeIWLabel;
    lblProposteFormative32: TmeIWLabel;
    dcmbProposteFormative3: TmeIWDBLookupComboBox;
    dmemProposteFormative: TmeIWMemo;
    W022CommentiValutatoRG: TmeIWRegion;
    lblCommentiValutato: TmeIWLabel;
    lblAccettazioneValutato: TmeIWLabel;
    chkAccettazioneValutatoSi: TmeIWCheckBox;
    chkAccettazioneValutatoNo: TmeIWCheckBox;
    dmemCommentiValutato: TmeIWMemo;
    W022NoteRG: TmeIWRegion;
    lblNote: TmeIWLabel;
    dmemNote: TmeIWMemo;
    lblProtocollo1: TmeIWLabel;
    lblProtocollo2: TmeIWLabel;
    lblProtocollo3: TmeIWLabel;
    btnModificaProtocollo: TmeIWButton;
    btnConfermaProtocollo: TmeIWButton;
    btnAnnullaProtocollo: TmeIWButton;
    edtNumeroProtocollo: TmeIWEdit;
    edtAnnoProtocollo: TmeIWEdit;
    edtDataProtocollo: TmeIWEdit;
    W022ValutazioneIntermediaRG: TmeIWRegion;
    lblValutazioneIntermedia: TmeIWLabel;
    lblEsitoValutazioneIntermedia: TmeIWLabel;
    chkEsitoValutazioneIntermediaP: TmeIWCheckBox;
    chkEsitoValutazioneIntermediaN: TmeIWCheckBox;
    dmemValutazioneIntermedia: TmeIWMemo;
    tpValutazioneIntermedia: TIWTemplateProcessorHTML;
    dmemStoriaValutazioneIntermedia: TmeIWMemo;
    dlblMessaggioValidazione: TmeIWDBLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnModificaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnInserisciDettaglioClick(Sender: TObject);
    procedure btnModificaDettaglioClick(Sender: TObject);
    procedure btnCancellaDettaglioClick(Sender: TObject);
    procedure btnConfermaDettaglioClick(Sender: TObject);
    procedure btnAnnullaDettaglioClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure dgrdDettaglioRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure lnkLegendaPunteggiClick(Sender: TObject);
    procedure lnkIstrValClick(Sender: TObject);
    procedure chkAccettazioneValutatoSiClick(Sender: TObject);
    procedure chkAccettazioneValutatoNoClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure chkValutabileClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure chkAccettazioneObiettiviSiClick(Sender: TObject);
    procedure chkAccettazioneObiettiviNoClick(Sender: TObject);
    procedure grdRiepilogoIncentiviRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnAvanzaStatoClick(Sender: TObject);
    procedure btnChiudiSchedaClick(Sender: TObject);
    procedure dgrdDettaglioAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure btnBloccaSchedaClick(Sender: TObject);
    procedure btnModificaProtocolloClick(Sender: TObject);
    procedure btnConfermaProtocolloClick(Sender: TObject);
    procedure btnAnnullaProtocolloClick(Sender: TObject);
    procedure chkEsitoValutazioneIntermediaPClick(Sender: TObject);
    procedure chkEsitoValutazioneIntermediaNClick(Sender: TObject);
  private
    RigaInserita: String;
    ModificaTestata,ModificaDettaglio,InserisciDettaglio,ModificaProtocollo: Boolean;
    lstComp: array of TIWCustomControl;
    rvSystem: TRVSystem;
    rvDWRiepilogo,rvDWDettaglio: TRaveDataView;
    rvProject: TRVProject;
    rvPage: TRaveComponent;
    rvRenderPDF: TRvRenderPDF;
    connRiepilogo,connDettaglio: TRVDataSetConnection;
    W022LegendaPunteggiFM: TW022FLegendaPunteggiFM;
    Fase1StampaDirigenzaConObiettivi,Fase2StampaDirigenzaConObiettivi: Boolean;
    NValutatori: Integer;
    StilePuntCmb,StilePuntEdt,StileNote: String;
    procedure mccbPunteggioAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure VisualizzaNote(Sender: TObject);
    procedure chkGiudicabileAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkGiudicabileClick(Sender: TObject);
    procedure VisualizzaPunteggi(Sender: TObject);
    procedure imgNoteClick(Sender: TObject);
    procedure AbilitazioneControlli;
    procedure ImpostaTabs;
    procedure ControllaLunghezzaCampo(Caratteri, Totale: Integer; EtichettaCampo: String; Blocca: Boolean; var Msg: String);
    procedure CaricaCampiDescrittivi;
    procedure ConfermaTestata;
    procedure RecuperaTipoStampa;
    procedure CreaClientDataset;
    procedure CaricaClientDataset;
    function RecuperaLegendaPunteggi: String;
    procedure EsecuzioneStampa;
    procedure VisualizzaStampa(NomeFile: String);
    procedure CreaColonne;
    procedure dgrdDettaglio2ColumnsClick(ASender: TObject; const AValue: string);
    procedure CreaComponenti;
    procedure ImpostaValutatore;
    procedure AssegnaValutatore;
    procedure AggiornaDataCompilazione;
    procedure DistruggiComponenti;
    procedure AggiornaQtaAssegnate;
    function ControlliAccettazioneObiettivi: String;
    function PunteggiVuoti(Chiusura: Boolean): Boolean;
    function NotePunteggiVuote: Boolean;
  protected
  public
    sTipoVal3, Abilitazione, NomeFile: String;
    NoteValidaRichiesto:Boolean;
    W022DtM2: TW022FSchedaValutazioniDtM;
    function InizializzaAccesso: Boolean; override;
  end;

implementation

{$R *.dfm}

uses IWApplication, IWGlobal, SyncObjs, W022UImpostaNoteFM;

procedure TW022FDettaglioValutazioni.IWAppFormCreate(Sender: TObject);
begin
  if WR000DM.SoloStampa then
    Tag:=443
  else if WR000DM.TipoValutazione = 'V' then
    Tag:=423
  else
    Tag:=424;
  sTipoVal3:=WR000DM.TipoValutazione;
  inherited;
  medpModale:=True;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  dgrdDettaglio.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  SetLength(lstComp,0);
  ModificaDettaglio:=False;
  InserisciDettaglio:=False;
  ModificaTestata:=False;
  ModificaProtocollo:=False;
  NoteValidaRichiesto:=False;

  tbValutazioni.AggiungiTab('Generale',W022GeneraleRG);
  tbValutazioni.AggiungiTab('Valutazione intermedia',W022ValutazioneIntermediaRG);
  tbValutazioni.AggiungiTab('Valutazioni complessive',W022ValutazioniComplessiveRG);
  tbValutazioni.AggiungiTab('Obiettivi pianificati',W022ObiettiviPianificatiRG);
  tbValutazioni.AggiungiTab('Proposte formative',W022ProposteFormativeRG);
  tbValutazioni.AggiungiTab('Commenti valutato',W022CommentiValutatoRG);
  tbValutazioni.AggiungiTab('Note',W022NoteRG);
  tbValutazioni.ActiveTab:=W022GeneraleRG;
end;

// procedure TW022FDettaglioValutazioni.OpenPage;
function TW022FDettaglioValutazioni.InizializzaAccesso: Boolean;
begin
  Result:=True;
  if sTipoVal3 = 'V' then
    Title:='(W022) Dettaglio scheda di valutazione'
  else
    Title:='(W022) Dettaglio scheda di autovalutazione';
  dgrdDettaglio.ExtraTagParams.Text:='summary=elementi della scheda di valutazione' +
                                     IfThen(W022DtM2.Q710.FieldByName('DATA').AsDateTime = EncodeDate(R180Anno(W022DtM2.Q710.FieldByName('DATA').AsDateTime),12,31),
                                            ' per l''anno ' + FormatDateTime('yyyy',W022DtM2.Q710.FieldByName('DATA').AsDateTime),
                                            ' al ' + FormatDateTime('dd/mm/yyyy',W022DtM2.Q710.FieldByName('DATA').AsDateTime));
  W022DtM2.AccettazioneObiettivi:='';
  W022DtM2.EsitoValutazioneIntermedia:='';

  // I riferimenti al DtM non devono essere fatti dall'Object Inspector, ma da codice,
  // perché quando creo 2 form con il relativo DtM, IW punta sempre e solo al primo DtM
  dlblMessaggioValidazione.DataSource:=W022DtM2.D710;
  dedtAnno.DataSource:=W022DtM2.D710;
  dedtPunteggioFinalePesato.DataSource:=W022DtM2.D710;
  dedtDataCompilazione.DataSource:=W022DtM2.D710;
  dlblStatoScheda.DataSource:=W022DtM2.D710;
  dedtDal.DataSource:=W022DtM2.D710;
  dedtAl.DataSource:=W022DtM2.D710;
  CaricaCampiDescrittivi;
  dedtImportoIncentivo.DataSource:=W022DtM2.D710;
  dedtOrarioNegoziato.DataSource:=W022DtM2.D710;
  dcmbProposteFormative1.DataSource:=W022DtM2.D710;
  dcmbProposteFormative1.ListSource:=W022DtM2.dFormaz;
  dcmbProposteFormative2.DataSource:=W022DtM2.D710;
  dcmbProposteFormative2.ListSource:=W022DtM2.dFormaz;
  dcmbProposteFormative3.DataSource:=W022DtM2.D710;
  dcmbProposteFormative3.ListSource:=W022DtM2.dFormaz;

  ImpostaValutatore;
  with W022DtM2 do
  begin
    RecuperaGruppoIncentivi(Q710.FieldByName('DATA').AsDateTime,Q710.FieldByName('PROGRESSIVO').AsInteger);
    lblGruppoIncentivi.Caption:='Gruppo: ' + GruppoIncentivi.Codice + ' ' + GruppoIncentivi.Descrizione;
    grdRiepilogoIncentivi.RowCount:=2;
    grdRiepilogoIncentivi.ColumnCount:=4;
    grdRiepilogoIncentivi.Cell[0,0].Text:='Quota massima';
    grdRiepilogoIncentivi.Cell[0,1].Text:='Ore minime';
    grdRiepilogoIncentivi.Cell[0,2].Text:='Tot. quota assegnata';
    grdRiepilogoIncentivi.Cell[0,3].Text:='Tot. ore assegnate';
    grdRiepilogoIncentivi.Cell[0,0].Width:='25%';
    grdRiepilogoIncentivi.Cell[0,1].Width:='25%';
    grdRiepilogoIncentivi.Cell[0,2].Width:='25%';
    grdRiepilogoIncentivi.Cell[0,3].Width:='25%';
    grdRiepilogoIncentivi.Cell[1,0].Text:=Format('%-9.2n',[GruppoIncentivi.ImpMax]);
    grdRiepilogoIncentivi.Cell[1,1].Text:=GruppoIncentivi.OreMin;
    AggiornaQtaAssegnate;
  end;

  AbilitazioneControlli;
  RecuperaTipoStampa;
  ImpostaTabs;
  W022DtM2.Azione:='';

  dgrdDettaglio.medpPaginazione:=False; // Non gestire la paginazione!
  dgrdDettaglio.medpDataSet:=W022DtM2.Q711;
  CreaColonne;
end;

procedure TW022FDettaglioValutazioni.AggiornaQtaAssegnate;
begin
  with W022DtM2 do
  begin
    if ModificaTestata then
    begin
      grdRiepilogoIncentivi.Cell[1,2].Text:=Format('%-9.2n + %-9.2n',[GruppoIncentivi.ImpAssegnato,Q710.FieldByName('IMPORTO_INCENTIVO').AsFloat]);
      grdRiepilogoIncentivi.Cell[1,3].Text:=GruppoIncentivi.OreAssegnate + ' + ' + R180MinutiOre(R180OreMinutiExt(Q710.FieldByName('ORE_INCENTIVO').AsString));
    end
    else
    begin
      grdRiepilogoIncentivi.Cell[1,2].Text:=Format('%-9.2n',[GruppoIncentivi.ImpAssegnato + Q710.FieldByName('IMPORTO_INCENTIVO').AsFloat]);
      grdRiepilogoIncentivi.Cell[1,3].Text:=R180MinutiOre(R180OreMinutiExt(GruppoIncentivi.OreAssegnate) + R180OreMinutiExt(Q710.FieldByName('ORE_INCENTIVO').AsString));
    end;
  end;
end;

procedure TW022FDettaglioValutazioni.IWAppFormDestroy(Sender: TObject);
begin
  DistruggiComponenti;
  inherited;
end;

procedure TW022FDettaglioValutazioni.IWAppFormRender(Sender: TObject);
begin
  inherited;
  W022DtM2.Accesso:='S';
  dlblMessaggioValidazione.Visible:=dlblMessaggioValidazione.DataSource.DataSet.FieldByName(dlblMessaggioValidazione.DataField).AsString <> '';
  lblData.Caption:=W022DtM2.RecuperaEtichetta('ANNO_VALUTAZIONE_C') + ':';
  lblValutato.Caption:=W022DtM2.RecuperaEtichetta('VALUTATO_C') + ':';
  lblValutatore.Caption:=W022DtM2.RecuperaEtichetta('VALUTATORE_C') + ':';
  lblPunteggioFinalePesato.Caption:=W022DtM2.RecuperaEtichetta('PUNTEGGIO_FINALE_SCHEDA_C') + ':';
  lblValutazioneIntermedia.Caption:=W022DtM2.RecuperaEtichetta('VALUTAZIONE_INTERMEDIA_C') + ':';
  lblValutazioniComplessive.Caption:=W022DtM2.RecuperaEtichetta('VALUTAZIONI_COMPLESSIVE_C') + ':';
  lblObiettiviPianificati.Caption:=W022DtM2.RecuperaEtichetta('OBIETTIVI_PIANIFICATI_C') + ':';
  lblProposteFormative.Caption:=W022DtM2.RecuperaEtichetta('PROPOSTE_FORMATIVE_C') + ':';
  lblAccettazioneValutato.Caption:='Accettazione da parte del ' + W022DtM2.RecuperaEtichetta('VALUTATO_C','L') + ':';
  lblCommentiValutato.Caption:=W022DtM2.RecuperaEtichetta('COMMENTI_VALUTATO_C') + ':';
  lblNote.Caption:=W022DtM2.RecuperaEtichetta('NOTE_C') + ':';
end;

procedure TW022FDettaglioValutazioni.lnkIstrValClick(Sender: TObject);
var
  URLDoc: String;
begin
  URLDoc:=ExtractFileName(W022DtM2.selSG741.FieldByName('PATH_ISTRUZIONI').AsString);
  VisualizzaFile(URLDoc,'Istruzioni per il valutatore',nil,nil,fdGlobal);
end;

procedure TW022FDettaglioValutazioni.lnkLegendaPunteggiClick(Sender: TObject);
begin
  inherited;
  W022LegendaPunteggiFM:=TW022FLegendaPunteggiFM.Create(Self);
  W022LegendaPunteggiFM.DataSetLegenda:=W022DtM2.selSG730;
  W022LegendaPunteggiFM.Visualizza;
end;

procedure TW022FDettaglioValutazioni.ImpostaValutatore;
var
  DValutatore, UltimoProgValutatore: String;
begin
  with W022DtM2 do
  begin
    UltimoProgValutatore:=Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString;
    while Pos(',',UltimoProgValutatore) > 0 do
      UltimoProgValutatore:=Copy(UltimoProgValutatore,Pos(',',UltimoProgValutatore) + 1);
    ValutatoreOld:=UltimoProgValutatore;
    ValutatoreNew:=ValutatoreOld;
    R180SetVariable(selI071,'AZIENDA',Parametri.Azienda);
    R180SetVariable(selI071,'PROGRESSIVO',-1);
    R180SetVariable(selI071,'DATA',Q710.FieldByName('DATA').AsDateTime);
    selI071.Open;
    selI071.First;
    cmbValutatore.Items.Clear;
    while not selI071.Eof do
    begin
      if (Pos(',' + selSG741.FieldByName('CODICE').AsString + '.',',' + selI071.FieldByName('S710_STATI_ABILITATI').AsString + ',') > 0)
      and not selI071.FieldByName('FILTRO_ANAGRAFE').IsNull then
      begin
        cmbValutatore.Items.Add(selI071.FieldByName('MATRICOLA_NOMINATIVO').AsString);
        if selI071.FieldByName('PROGRESSIVO').AsInteger = StrToIntDef(UltimoProgValutatore, -1) then
          DValutatore:=selI071.FieldByName('MATRICOLA_NOMINATIVO').AsString;
      end;
      selI071.Next;
    end;
    cmbValutatore.ItemIndex:=R180IndexOf(cmbValutatore.Items,DValutatore,100);
  end;
end;

procedure TW022FDettaglioValutazioni.AssegnaValutatore;
begin
  if (Parametri.S710_SupervisoreValut = 'N') and not R180InConcat(IntToStr(Parametri.ProgressivoOper),W022DtM2.Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString) then
  begin
    btnModificaClick(nil);
    btnConfermaClick(nil);
  end;
end;

procedure TW022FDettaglioValutazioni.AggiornaDataCompilazione;
begin
  if (W022DtM2.selSG741.FieldByName('AGGIORNA_DATA_COMPILAZIONE').AsString = 'S')
  and (W022DtM2.Q710.FieldByName('DATA_COMPILAZIONE').AsDateTime <> Date) then
  begin
    btnModificaClick(nil);
    btnConfermaClick(nil);
  end;
end;

procedure TW022FDettaglioValutazioni.CreaColonne;
begin
  dgrdDettaglio.medpBrowse:=True;

  dgrdDettaglio.medpCreaCDS;
  dgrdDettaglio.medpEliminaColonne;
  dgrdDettaglio.medpAggiungiColonna('COD_AREA','Cod. area','',nil);
  dgrdDettaglio.medpAggiungiColonna('D_AREA','Descrizione area','',nil);
  dgrdDettaglio.medpAggiungiColonna('CF_PERC_AREA','Peso % area','',nil);
  dgrdDettaglio.medpAggiungiColonna('CF_PUNTEGGIO_AREA','Punt. area','',nil);
  dgrdDettaglio.medpAggiungiColonna('COD_VALUTAZIONE','Cod. elem.','',nil);
  dgrdDettaglio.medpAggiungiColonna('D_VALUTAZIONE','Descrizione elem.','',nil);
  dgrdDettaglio.medpAggiungiColonna('CF_PERC_VALUTAZIONE','Peso % elem.','',nil);
  dgrdDettaglio.medpAggiungiColonna('SOGLIA_PUNTEGGIO','Soglia','',nil);
  dgrdDettaglio.medpAggiungiColonna('VALUTABILE','Valutabile','',nil);
  dgrdDettaglio.medpAggiungiColonna('GIUDICABILE','Giudicabile','',nil);
  dgrdDettaglio.medpAggiungiColonna('D_PUNTEGGIO','Punt. elem.','',nil);
  dgrdDettaglio.medpAggiungiColonna('NOTE_PUNTEGGIO','Note punt.','',nil);
  dgrdDettaglio.medpAggiungiColonna('CF_PUNTEGGIO_PESATO','Punt. pesato elem.','',nil);
  dgrdDettaglio.medpAggiungiRowClick('DBG_ROWID',dgrdDettaglio2ColumnsClick);
  (dgrdDettaglio.Columns.Items[1] as TIWDBGridColumn).Width:='300';
  (dgrdDettaglio.Columns.Items[1] as TIWDBGridColumn).Wrap:=True;
  (dgrdDettaglio.Columns.Items[2] as TIWDBGridColumn).Visible:=R180InConcat('1',W022DtM2.selSG741.FieldByName('CAMPI_OPZIONALI_COMPILAZIONE').AsString);
  (dgrdDettaglio.Columns.Items[3] as TIWDBGridColumn).Visible:=R180InConcat('2',W022DtM2.selSG741.FieldByName('CAMPI_OPZIONALI_COMPILAZIONE').AsString);
  (dgrdDettaglio.Columns.Items[5] as TIWDBGridColumn).Width:='1000';
  (dgrdDettaglio.Columns.Items[5] as TIWDBGridColumn).Wrap:=True;
  (dgrdDettaglio.Columns.Items[6] as TIWDBGridColumn).Visible:=R180InConcat('3',W022DtM2.selSG741.FieldByName('CAMPI_OPZIONALI_COMPILAZIONE').AsString);
  (dgrdDettaglio.Columns.Items[7] as TIWDBGridColumn).Visible:=W022DtM2.VisColSogliaPunteggio;
  (dgrdDettaglio.Columns.Items[8] as TIWDBGridColumn).Visible:=W022DtM2.VisColItemValutabile;
  (dgrdDettaglio.Columns.Items[9] as TIWDBGridColumn).Visible:=R180InConcat('5',W022DtM2.selSG741.FieldByName('CAMPI_OPZIONALI_COMPILAZIONE').AsString);
  (dgrdDettaglio.Columns.Items[11] as TIWDBGridColumn).Visible:=W022DtM2.VisColNotePunteggio;
  (dgrdDettaglio.Columns.Items[12] as TIWDBGridColumn).Visible:=R180InConcat('4',W022DtM2.selSG741.FieldByName('CAMPI_OPZIONALI_COMPILAZIONE').AsString);

  dgrdDettaglio.medpInizializzaCompGriglia;
  dgrdDettaglio.medpPreparaComponenteGenerico('R',dgrdDettaglio.medpIndexColonna('GIUDICABILE'),0,DBG_CHK,'','','','');
  dgrdDettaglio.medpPreparaComponenteGenerico('R',dgrdDettaglio.medpIndexColonna('NOTE_PUNTEGGIO'),0,DBG_IMG,'','ELENCO','','');
  dgrdDettaglio.medpCaricaCDS;
end;

procedure TW022FDettaglioValutazioni.btnModificaClick(Sender: TObject);
var
  ProgValutatori,Msg: String;
begin
  inherited;
  if W022DtM2.SchedeCollegateChiuse(Msg) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Impossibile modificare la scheda!' + CRLF + Msg);
    exit;
  end;
  W022DtM2.Azione:='M';
  W022DtM2.EsitoValutazioneIntermedia:=W022DtM2.Q710.FieldByName('ESITO_VALUTAZIONE_INTERMEDIA').AsString;
  ModificaTestata:=True;
  AggiornaQtaAssegnate;
  AbilitazioneControlli;
  W022DtM2.Q710.Edit;
  if W022DtM2.selSG741.FieldByName('AGGIORNA_DATA_COMPILAZIONE').AsString = 'S' then
    W022DtM2.Q710.FieldByName('DATA_COMPILAZIONE').AsDateTime:=Date;
  ProgValutatori:=W022DtM2.Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString;
  if (Parametri.S710_SupervisoreValut = 'N') and not R180InConcat(IntToStr(Parametri.ProgressivoOper),ProgValutatori) then
  begin
    ProgValutatori:=ProgValutatori + IfThen(ProgValutatori <> '',',') + IntToStr(Parametri.ProgressivoOper);
    W022DtM2.Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString:=ProgValutatori;
    ImpostaValutatore;
  end;
end;

procedure TW022FDettaglioValutazioni.btnConfermaClick(Sender: TObject);
begin
  inherited;
  //W022DtM2.ControllaCommentiValutato;
  if R180In(W022DtM2.AccettazioneObiettivi,['','tolto']) then
    ConfermaTestata
  else if W022DtM2.AccettazioneObiettivi = 'S' then
    Messaggio('Richiesta conferma','Attenzione! Se si accettano gli obiettivi non sarà più possibile modificare la scheda fino all''inizio del periodo di compilazione. Proseguire?',ConfermaTestata,nil)
  else if W022DtM2.AccettazioneObiettivi = 'N' then
    Messaggio('Richiesta conferma','Attenzione! Se si rifiutano gli obiettivi la scheda verrà chiusa e non sarà più possibile modificarla. Proseguire?',ConfermaTestata,nil);
end;

procedure TW022FDettaglioValutazioni.ConfermaTestata;
var
  s,Msg: String;
begin
  with W022DtM2 do
  begin
    if (Q710.FieldByName('TIPO_VALUTAZIONE').AsString = 'V')
    and (VarToStr(selI071.Lookup('MATRICOLA_NOMINATIVO', cmbValutatore.Text,'PROGRESSIVO')) = '') then
    begin
      MsgBox.MessageBox('Scegliere un ' + RecuperaEtichetta('VALUTATORE_C','L') + ' valido dalla lista!', ERRORE);
      abort;
    end;
    // Periodo di valutazione
    if Q710.FieldByName('DAL').IsNull or Q710.FieldByName('AL').IsNull then
    begin
      MsgBox.MessageBox('Indicare le date di inizio e fine periodo di valutazione!', ERRORE);
      abort;
    end;
    if Q710.FieldByName('DAL').AsDateTime > Q710.FieldByName('AL').AsDateTime then
    begin
      MsgBox.MessageBox('Indicare in ordine cronologico le date di inizio e fine periodo di valutazione!', ERRORE);
      abort;
    end;
    selSchedeAnno.Close;
    selSchedeAnno.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    selSchedeAnno.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    selSchedeAnno.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    selSchedeAnno.SetVariable('DATA_RICH',Q710.FieldByName('DATA').AsDateTime);
    selSchedeAnno.Open;
    if selSchedeAnno.RecordCount >= 2 then // Se oltre a quella corrente esiste anche un'altra scheda...
    begin
      selSchedeAnno.Next; // ..mi posiziono sulla scheda successiva
      if Q710.FieldByName('DAL').AsDateTime <= selSchedeAnno.FieldByName('DATA').AsDateTime then
      begin
        MsgBox.MessageBox('La data di inizio periodo di valutazione (' + FormatDateTime('dd/mm/yyyy', Q710.FieldByName('DAL').AsDateTime) + ') deve essere successiva alla data della scheda precedente (' + FormatDateTime('dd/mm/yyyy',selSchedeAnno.FieldByName('DATA').AsDateTime) + ')!',ERRORE);
        abort;
      end;
    end;
    if R180Anno(Q710.FieldByName('DAL').AsDateTime) <> R180Anno(Q710.FieldByName('DATA').AsDateTime) then
    begin
      MsgBox.MessageBox('La data di inizio periodo di valutazione (' + FormatDateTime('dd/mm/yyyy', Q710.FieldByName('DAL').AsDateTime) + ') non può essere esterna all''anno della scheda (' + FormatDateTime('yyyy',Q710.FieldByName('DATA').AsDateTime) + ')!', ERRORE);
      abort;
    end;
    if Q710.FieldByName('AL').AsDateTime > Q710.FieldByName('DATA').AsDateTime then
    begin
      MsgBox.MessageBox('La data di fine periodo di valutazione (' + FormatDateTime('dd/mm/yyyy', Q710.FieldByName('AL').AsDateTime) + ') non può essere successiva alla data della scheda (' + FormatDateTime('dd/mm/yyyy', Q710.FieldByName('DATA').AsDateTime) + ')!',ERRORE);
      abort;
    end;
    // Controllo lunghezza campi descrittivi
    ControllaLunghezzaCampo(Length(Trim(dmemValutazioneIntermedia.Text)),Q710.FieldByName('VALUTAZIONE_INTERMEDIA').Size,'VALUTAZIONE_INTERMEDIA_C',True,Msg);
    ControllaLunghezzaCampo(Length(Trim(dmemValutazioniComplessive.Text)),Q710.FieldByName('VALUTAZIONE_COMPLESSIVE').Size,'VALUTAZIONI_COMPLESSIVE_C',True,Msg);
    ControllaLunghezzaCampo(Length(Trim(dmemObiettiviPianificati.Text)),Q710.FieldByName('OBIETTIVI_AZIONI').Size,'OBIETTIVI_PIANIFICATI_C',True,Msg);
    ControllaLunghezzaCampo(Length(Trim(dmemProposteFormative.Text)),Q710.FieldByName('PROPOSTE_FORMATIVE').Size,'PROPOSTE_FORMATIVE_C',True,Msg);
    ControllaLunghezzaCampo(Length(Trim(dmemCommentiValutato.Text)),Q710.FieldByName('COMMENTI_VALUTATO').Size,'COMMENTI_VALUTATO_C',True,Msg);
    ControllaLunghezzaCampo(Length(Trim(dmemNote.Text)),Q710.FieldByName('NOTE').Size,'NOTE_C',True,Msg);
    // Assegnazione campi descrittivi
    Q710.FieldByName('VALUTAZIONE_INTERMEDIA').AsString:=Trim(dmemValutazioneIntermedia.Text);
    Q710.FieldByName('VALUTAZIONE_COMPLESSIVE').AsString:=Trim(dmemValutazioniComplessive.Text);
    Q710.FieldByName('OBIETTIVI_AZIONI').AsString:=Trim(dmemObiettiviPianificati.Text);
    Q710.FieldByName('PROPOSTE_FORMATIVE').AsString:=Trim(dmemProposteFormative.Text);
    Q710.FieldByName('COMMENTI_VALUTATO').AsString:=Trim(dmemCommentiValutato.Text);
    Q710.FieldByName('NOTE').AsString:=Trim(dmemNote.Text);
    // Aggiorno l'elenco dei valutatori della scheda
    if Q710.FieldByName('TIPO_VALUTAZIONE').AsString = 'V' then
    begin
      ValutatoreNew:=VarToStr(selI071.Lookup('MATRICOLA_NOMINATIVO',cmbValutatore.Text,'PROGRESSIVO'));
      if ValutatoreNew <> ValutatoreOld then
      begin
        s:=Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString;
        if R180InConcat(ValutatoreNew, s) then
          s:=StringReplace(',' + s + ',', ',' + ValutatoreOld + ',', ',',[rfReplaceAll])
        else
          s:=StringReplace(',' + s + ',', ',' + ValutatoreOld + ',',',' + ValutatoreNew + ',',[rfReplaceAll]);
        s:=Copy(s,2,Length(s) - 2);
        Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString:=s;
      end;
    end;
    Q710.Post;
    Q710.RefreshRecord; // Se Oracle sostituisce qualche carattere speciale, devo aggiornare i campi descrittivi di testata prima di effettuare un altro Post
    CalcolaTotali(True);
    if (Azione = 'M')
    and (ValutatoreNew <> '')
    and (ValutatoreOld <> '') //<--non registro il legame se c'è stata l'assegnazione manuale del valutatore dopo che il Supervisore ha creato la scheda senza CercaValutatore
    and (ValutatoreOld <> ValutatoreNew) then
    begin
      selSG710b.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
      selSG710b.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
      selSG710b.SetVariable('TIPO',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
      selSG710b.Execute;
      // Se ho cambiato il valutatore aggiorno l'assegnazione eccezionale
      CambioValutatore.SetVariable('PROGRESSIVO_VALUTATO',Q710.FieldByName('PROGRESSIVO').AsInteger);
      CambioValutatore.SetVariable('DINI',selSG710b.Field(0));
      CambioValutatore.SetVariable('DFIN',Q710.FieldByName('DATA').AsDateTime);
      CambioValutatore.SetVariable('PROGRESSIVO_VALUTATORE_NEW',StrToInt(ValutatoreNew));
      CambioValutatore.Execute;
      RegistraLog.SettaProprieta('I', 'SG706_VALUTATORI_DIPENDENTE',medpCodiceForm,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',ValutatoreNew);
      RegistraLog.InserisciDato('DECORRENZA','',FormatDateTime('dd/mm/yyyy',selSG710b.Field(0)));
      RegistraLog.InserisciDato('DECORRENZA_FINE','',FormatDateTime('dd/mm/yyyy',Q710.FieldByName('DATA').AsDateTime));
      RegistraLog.InserisciDato('PROGRESSIVO_VALUTATO','',Q710.FieldByName('PROGRESSIVO').AsString);
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
      Q710CalcFields(nil);
      if Parametri.S710_SupervisoreValut <> 'S' then
        ClosePage
      else
        ValutatoreOld:=ValutatoreNew;
    end;
    CaricaCampiDescrittivi;
  end;
  ModificaTestata:=False;
  AggiornaQtaAssegnate;
  dgrdDettaglio.medpCaricaCDS;
  AbilitazioneControlli;
end;

procedure TW022FDettaglioValutazioni.btnAnnullaClick(Sender: TObject);
begin
  inherited;
  W022DtM2.Q710.RefreshRecord;
  CaricaCampiDescrittivi;
  ModificaTestata:=False;
  AggiornaQtaAssegnate;
  AbilitazioneControlli;
  ImpostaValutatore;
end;

procedure TW022FDettaglioValutazioni.btnInserisciDettaglioClick(Sender: TObject);
var
  Data: TDateTime;
  Progressivo,StatoAvanzamento,IPMax: Integer;
  TipoValutazione,CodArea,DescArea,SG711Rowid: String;
  PercArea,PunteggioArea,ResiduoPercArea: Real;
  CodNewItemDisp,RIP,Msg: String;
begin
  inherited;
  with W022DtM2 do
  begin
    if SchedeCollegateChiuse(Msg) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Impossibile modificare la scheda!' + CRLF + Msg);
      exit;
    end;
    CodArea:=Q711.FieldByName('COD_AREA').AsString;
    ElementiPersonalizzati.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    ElementiPersonalizzati.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    ElementiPersonalizzati.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    ElementiPersonalizzati.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    ElementiPersonalizzati.SetVariable('COD_AREA',CodArea);
    ElementiPersonalizzati.Execute;
    RIP:=ProprietaArea(CodArea,DataRif,'RANGE_ITEM_PERSONALIZZATI');
    IPMax:=StrToIntDef(Copy(RIP,Pos('#',RIP) + 1),0);
    if (ElementiPersonalizzati.FieldAsInteger(0) + 1) > IPMax then
    begin
      MsgBox.MessageBox('Impossibile inserire un nuovo elemento personalizzato per l''area ' + CodArea + ': il limite massimo è stato impostato a ' + IntToStr(IPMax) + '!', ERRORE);
      abort;
    end;
    Data:=Q711.FieldByName('DATA').AsDateTime;
    Progressivo:=Q711.FieldByName('PROGRESSIVO').AsInteger;
    DescArea:=Q711.FieldByName('D_AREA').AsString;
    PercArea:=Q711.FieldByName('PERC_AREA').AsFloat;
    PunteggioArea:=Q711.FieldByName('PUNTEGGIO_AREA').AsFloat;
    TipoValutazione:=Q711.FieldByName('TIPO_VALUTAZIONE').AsString;
    StatoAvanzamento:=Q711.FieldByName('STATO_AVANZAMENTO').AsInteger;
    CodNewItemDisp:=CodNewItem;
    while VarToStr(Q711.Lookup('COD_AREA;COD_VALUTAZIONE',VarArrayOf([CodArea,CodNewItemDisp]),'COD_VALUTAZIONE')) = CodNewItemDisp do
      CodNewItemDisp:=StringReplace(Format('%5s',[IntToStr(StrToInt(CodNewItemDisp) + 1)]),' ','0',[rfReplaceAll]);
    Q711.Append;
    Q711.FieldByName('DATA').AsDateTime:=Data;
    Q711.FieldByName('PROGRESSIVO').AsInteger:=Progressivo;
    Q711.FieldByName('STATO_AVANZAMENTO').AsInteger:=StatoAvanzamento;
    Q711.FieldByName('COD_AREA').AsString:=CodArea;
    Q711.FieldByName('D_AREA').AsString:=DescArea;
    Q711.FieldByName('PERC_AREA').AsFloat:=PercArea;
    Q711.FieldByName('PUNTEGGIO_AREA').AsFloat:=PunteggioArea;
    Q711.FieldByName('COD_VALUTAZIONE').AsString:=CodNewItemDisp;
    Q711.FieldByName('VALUTABILE').AsString:='S';
    Q711.FieldByName('TIPO_VALUTAZIONE').AsString:=TipoValutazione;
    Q711.FieldByName('DESC_VALUTAZIONE_AGG').AsString:=ProprietaArea(CodArea,DataRif,'TESTO_ITEM_PERSONALIZZATI');
    Q711.FieldByName('VALUTAZIONE_ORIGINALE').AsString:='N';
    if ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA_BASE_100') = 'S' then
    begin
      ResiduoPercArea:=100;
      selSG711.First; //già aperto nel Q711CalcFields con le variabili aggiornate dopo l'Append
      while not selSG711.Eof do
      begin
        ResiduoPercArea:=Max(ResiduoPercArea - selSG711.FieldByName('PERC_VALUTAZIONE').AsFloat,0);
        selSG711.Next;
      end;
    end
    else
      ResiduoPercArea:=0;
    Q711.FieldByName('PERC_VALUTAZIONE').AsFloat:=R180Arrotonda(ResiduoPercArea,0.00001,'P');
    Q711.Post;
    SessioneOracle.ApplyUpdates([Q711],True); //Se non eseguo l'ApplyUpdates non mi viene resituito il RowID, fondamentale per i posizionamenti successivi
    SG711Rowid:=Q711.Rowid;
    Q711.Refresh;
    Q711.SearchRecord('ROWID',SG711Rowid,[srFromBeginning]);
    RigaInserita:=SG711Rowid; //Salvo il RowID che potrei successivamente usare per cancellare il record in fase di annullamento
  end;
  dgrdDettaglio.medpCaricaCDS(SG711Rowid);
  dgrdDettaglio.RowClick:=False;
  CreaComponenti;
  InserisciDettaglio:=True;
  AbilitazioneControlli;
end;

procedure TW022FDettaglioValutazioni.btnModificaDettaglioClick(Sender: TObject);
var
  Msg: String;
begin
  inherited;
  if W022DtM2.SchedeCollegateChiuse(Msg) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Impossibile modificare la scheda!' + CRLF + Msg);
    exit;
  end;
  dgrdDettaglio.RowClick:=False;
  ModificaDettaglio:=True;
  CreaComponenti;
  AbilitazioneControlli;
end;

procedure TW022FDettaglioValutazioni.btnCancellaDettaglioClick(Sender: TObject);
var
  RIP,Msg: String;
  IPMin: Integer;
begin
  with W022DtM2 do
  begin
    if SchedeCollegateChiuse(Msg) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Impossibile modificare la scheda!' + CRLF + Msg);
      exit;
    end;
    ElementiPersonalizzati.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    ElementiPersonalizzati.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    ElementiPersonalizzati.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    ElementiPersonalizzati.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    ElementiPersonalizzati.SetVariable('COD_AREA',Q711.FieldByName('COD_AREA').AsString);
    ElementiPersonalizzati.Execute;
    RIP:=ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'RANGE_ITEM_PERSONALIZZATI');
    IPMin:=StrToIntDef(Copy(RIP,1,Pos('#',RIP) - 1),0);
    if (ElementiPersonalizzati.FieldAsInteger(0) - 1) < IPMin then
    begin
      MsgBox.MessageBox('L''area ' + Q711.FieldByName('COD_AREA').AsString + ' deve prevedere almeno ' + IntToStr(IPMin) + ' element' + IfThen(IPMin = 1,'o','i') + ' personalizzat' + IfThen(IPMin = 1,'o','i') + '!',ERRORE);
      abort;
    end;
    Q711.Delete;
    SessioneOracle.ApplyUpdates([Q711],True);
    AssegnaValutatore;
    AggiornaDataCompilazione;
    CalcolaTotali(True);
    dgrdDettaglio.medpCaricaCDS;
    AbilitazioneControlli;
    if TotPerc <> 100 then
      MsgBox.MessageBox('Attenzione! Il totale del peso percentuale delle aree di valutazione deve essere 100! (Attuale: ' + FloatToStr(TotPerc) + ')',ESCLAMA)
    else if AnomaliaRangePesoArea(Msg) then
      GGetWebApplicationThreadVar.ShowMessage(Msg);
  end;
end;

procedure TW022FDettaglioValutazioni.btnConfermaDettaglioClick(Sender: TObject);
var
  i,c: Integer;
  RigaInvalida, ItemPersonalizzato, ItemGiudicabile: Boolean;
  SG711Rowid, MessaggioErrore, Msg: String;
  EsisteFaseAssegnazionePreventivaObiettivi,FaseAssegnazionePreventivaObiettiviTerminata: Boolean;
begin
  inherited;
  with W022DtM2 do
  begin
    EsisteFaseAssegnazionePreventivaObiettivi:=(selSG741.FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S');
    FaseAssegnazionePreventivaObiettiviTerminata:=not EsisteFaseAssegnazionePreventivaObiettivi or not Q710.FieldByName('ACCETTAZIONE_OBIETTIVI').IsNull;
    vSchedeCollegateAperte:=SchedeCollegateAperte(Msg);
  end;
  with W022DtM2.Q711 do
  begin
    DisableControls;
    RigaInvalida:=False;
    SG711Rowid:=Rowid;
    First;
    for i:=0 to RecordCount - 1 do
    begin
      Edit;
      ItemPersonalizzato:=FieldByName('VALUTAZIONE_ORIGINALE').AsString = 'N';
      // codice elemento
      c:=dgrdDettaglio.medpIndexColonna('COD_VALUTAZIONE');
      if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
        FieldByName('COD_VALUTAZIONE').AsString:=Trim((dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit).Text);
      // descrizione elemento
      c:=dgrdDettaglio.medpIndexColonna('D_VALUTAZIONE');
      if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
        FieldByName('DESC_VALUTAZIONE_AGG').AsString:=Copy(R180SostituisciCaratteriSpeciali(Trim((dgrdDettaglio.medpCompCella(i,c,0) as TmeIWMemo).Lines.Text)),1,1000);
      // peso percentuale elemento
      c:=dgrdDettaglio.medpIndexColonna('CF_PERC_VALUTAZIONE');
      if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
        FieldByName('PERC_VALUTAZIONE').AsFloat:=StrToFloatDef(Trim(VarToStr((dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit).Text)),0);
      // soglia raggiungimento
      c:=dgrdDettaglio.medpIndexColonna('SOGLIA_PUNTEGGIO');
      if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
        FieldByName('SOGLIA_PUNTEGGIO').AsString:=Trim(VarToStr((dgrdDettaglio.medpCompCella(i,c,0) as TmedpIWMultiColumnComboBox).Text));
      // valutabile
      c:=dgrdDettaglio.medpIndexColonna('VALUTABILE');
      if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
        FieldByName('VALUTABILE').AsString:=VarToStr((dgrdDettaglio.medpCompCella(i,c,0) as TmeIWComboBox).Text);
      // giudicabile
      ItemGiudicabile:=True;
      c:=dgrdDettaglio.medpIndexColonna('GIUDICABILE');
      if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
        ItemGiudicabile:=(dgrdDettaglio.medpCompCella(i,c,0) as TmeIWCheckBox).Checked;
      // punteggio
      c:=dgrdDettaglio.medpIndexColonna('D_PUNTEGGIO');
      if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
      begin
        if not ItemGiudicabile then
        begin
          FieldByName('COD_PUNTEGGIO').AsString:=VarToStr(W022DtM2.selSG730.Lookup('ITEM_GIUDICABILE','N','CODICE'));
          FieldByName('PUNTEGGIO').AsString:=VarToStr(W022DtM2.selSG730.Lookup('ITEM_GIUDICABILE','N','PUNTEGGIO'));
        end
        else if dgrdDettaglio.medpCompCella(i,c,0) is TmedpIWMultiColumnComboBox then
        begin
          FieldByName('COD_PUNTEGGIO').AsString:=Trim(VarToStr((dgrdDettaglio.medpCompCella(i,c,0) as TmedpIWMultiColumnComboBox).Text));
          FieldByName('PUNTEGGIO').AsString:=VarToStr(W022DtM2.selSG730.Lookup('CODICE',FieldByName('COD_PUNTEGGIO').AsString,'PUNTEGGIO'));
        end
        else
          try
            FieldByName('COD_PUNTEGGIO').AsString:='';
            FieldByName('PUNTEGGIO').AsFloat:=StrToFloat(Trim(VarToStr((dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit).Text)));
          except
            FieldByName('PUNTEGGIO').AsString:=''; // Il punteggio impostato a zero deve essere considerato diversamente da vuoto
          end;
      end;
      // note punteggio
      c:=dgrdDettaglio.medpIndexColonna('NOTE_PUNTEGGIO');
      if not((dgrdDettaglio.medpCompCella(i,c,0) <> nil) and ((dgrdDettaglio.medpCompCella(i,c,0) as TmeIWImageFile).Css <> 'invisibile')) then
        FieldByName('NOTE_PUNTEGGIO').AsString:='';
      try
        // lunghezza descrizione item
        c:=dgrdDettaglio.medpIndexColonna('D_VALUTAZIONE');
        if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
        begin
          ControllaLunghezzaCampo(Length(Trim((dgrdDettaglio.medpCompCella(i,c,0) as TmeIWMemo).Lines.Text)),FieldByName('DESC_VALUTAZIONE_AGG').Size,'DESCRIZIONE_ITEM_C',False,Msg);
          if Msg <> '' then
          begin
            MessaggioErrore:=MessaggioErrore + IfThen(MessaggioErrore <> '',CRLF) + Msg;
            abort;
          end;
        end;
        // validità soglia
        c:=dgrdDettaglio.medpIndexColonna('SOGLIA_PUNTEGGIO');
        if (FieldByName('SOGLIA_PUNTEGGIO').AsString <> '') and
          (VarToStr(W022DtM2.selSG730.Lookup('CODICE',FieldByName('SOGLIA_PUNTEGGIO').AsString,'CODICE')) = '') then
        begin
          (dgrdDettaglio.medpCompCella(i,c,0) as TmedpIWMultiColumnComboBox).Text:='';
          MessaggioErrore:=MessaggioErrore + IfThen(MessaggioErrore <> '',CRLF) + 'Il valore "' + FieldByName('SOGLIA_PUNTEGGIO').AsString + '" indicato in "' + W022DtM2.RecuperaEtichetta('SOGLIA_PUNTEGGIO_ITEM_C') + '" non è consentito! Selezionare un valore dalla lista!';
          abort;
        end;
        // validità peso percentuale elemento
        //AsCurrency perché AsFloat rimane sporco quando si usa R180Arrotonda con 5 cifre decimali
        if (FieldByName('PERC_VALUTAZIONE').AsCurrency < 0) or
          (FieldByName('PERC_VALUTAZIONE').AsCurrency > 100) then
        begin
          MessaggioErrore:=MessaggioErrore + IfThen(MessaggioErrore <> '',CRLF) + 'Il valore "' + FieldByName('PERC_VALUTAZIONE').AsString + '" indicato in "' + W022DtM2.RecuperaEtichetta('PESO_ITEM_C') + '" non è consentito! Indicare un valore percentuale tra 0 e 100!';
          abort;
        end;
        // Valorizzazione della soglia
        c:=dgrdDettaglio.medpIndexColonna('SOGLIA_PUNTEGGIO');
        //AsCurrency perché AsFloat rimane sporco quando si usa R180Arrotonda con 5 cifre decimali
        if (FieldByName('PERC_VALUTAZIONE').AsCurrency > 0) and FieldByName('SOGLIA_PUNTEGGIO').IsNull and (dgrdDettaglio.medpCompCella(i,c,0) <> nil) then
        begin
          MessaggioErrore:=MessaggioErrore + IfThen(MessaggioErrore <> '',CRLF) + 'E'' necessario indicare un valore in "' + W022DtM2.RecuperaEtichetta('SOGLIA_PUNTEGGIO_ITEM_C') + '"! Selezionare un valore dalla lista!';
          abort;
        end;
        // Validità del punteggio
        c:=dgrdDettaglio.medpIndexColonna('D_PUNTEGGIO');
        if (FieldByName('COD_PUNTEGGIO').AsString <> '') and (VarToStr(W022DtM2.selSG730.Lookup('CODICE',FieldByName('COD_PUNTEGGIO').AsString, 'CODICE')) = '') then
        begin
          (dgrdDettaglio.medpCompCella(i,c,0) as TmedpIWMultiColumnComboBox).Text:='';
          MessaggioErrore:=MessaggioErrore + IfThen(MessaggioErrore <> '',CRLF) + 'Il valore "' + FieldByName('COD_PUNTEGGIO').AsString + '" indicato in "' + W022DtM2.RecuperaEtichetta('PUNTEGGIO_ITEM_C') + '" non è consentito! Selezionare un valore dalla lista!';
          abort;
        end
        else if FieldByName('COD_PUNTEGGIO').IsNull and ((FieldByName('PUNTEGGIO').AsFloat < 0) or (FieldByName('PUNTEGGIO').AsFloat > 100)) then
        begin
          MessaggioErrore:=MessaggioErrore + IfThen(MessaggioErrore <> '',CRLF) + 'Il valore "' + FieldByName('PUNTEGGIO').AsString + '" indicato in "' + W022DtM2.RecuperaEtichetta('PUNTEGGIO_ITEM_C') + '" non è consentito! Indicare un valore percentuale tra 0 e 100!';
          abort;
        end;
        // Validità del codice dell'elemento personalizzato
        R180SetVariable(W022DtM2.selSG700,'COD_AREA',FieldByName('COD_AREA').AsString);
        R180SetVariable(W022DtM2.selSG700,'DATA',W022DtM2.DataRif);
        W022DtM2.selSG700.Open;
        if (FieldByName('COD_VALUTAZIONE').AsString = '') or (ItemPersonalizzato and W022DtM2.selSG700.SearchRecord('COD_VALUTAZIONE',FieldByName('COD_VALUTAZIONE').AsString,[srFromBeginning])) then
        begin
          MessaggioErrore:=MessaggioErrore + IfThen(MessaggioErrore <> '',CRLF) + 'Il valore "' + IfThen(FieldByName('COD_VALUTAZIONE').AsString = '','vuoto',FieldByName('COD_VALUTAZIONE').AsString) + '" indicato in "' + W022DtM2.RecuperaEtichetta('CODICE_ITEM_C') + '" non è consentito!';
          abort;
        end;
        // Valorizzazione della descrizione dell'elemento personalizzato
        if ItemPersonalizzato and (FieldByName('DESC_VALUTAZIONE_AGG').AsString = '') then
        begin
          MessaggioErrore:=MessaggioErrore + IfThen(MessaggioErrore <> '',CRLF) + 'Compilare il campo "' + W022DtM2.RecuperaEtichetta('DESCRIZIONE_ITEM_C') + '"!';
          abort;
        end;
        Post; //L'ApplyUpdates o il CancelUpdates vanno fatti successivamente, perché i record appena modificati possono non essere confermati
      except
        on E:Exception do
        begin
          // Duplicazione di record
          if Pos('ORA-00001', E.Message) > 0 then
            MessaggioErrore:=MessaggioErrore + IfThen(MessaggioErrore <> '',CRLF) + 'Il "' + W022DtM2.RecuperaEtichetta('CODICE_ITEM_C') + '" indicato è già presente nella scheda!';
          MessaggioErrore:=MessaggioErrore + ' (' + W022DtM2.RecuperaEtichetta('CODICE_AREA_C') + ': ' + FieldByName('COD_AREA').AsString + '; ' + W022DtM2.RecuperaEtichetta('CODICE_ITEM_C') + ': ' + FieldByName('COD_VALUTAZIONE').AsString + ')';
          Cancel; //L'ApplyUpdates o il CancelUpdates vanno fatti successivamente, perché i record appena modificati possono non essere confermati
          RigaInvalida:=True;
          SG711Rowid:=Rowid;
        end;
      end;
      Next;
    end;

    Refresh;
    SearchRecord('ROWID',SG711Rowid,[srFromBeginning]);
    dgrdDettaglio.medpClientDataSet.Locate('DBG_ROWID',SG711Rowid,[]);
    EnableControls;

    if RigaInvalida then
    begin
      GGetWebApplicationThreadVar.ShowMessage(MessaggioErrore);
      exit;
    end;

    DistruggiComponenti;
    dgrdDettaglio.RowClick:=True;
    ModificaDettaglio:=False;
    InserisciDettaglio:=False;
    AbilitazioneControlli;

    RecuperaTipoStampa;
    ImpostaTabs;

    SessioneOracle.ApplyUpdates([W022DtM2.Q711],True);
    AssegnaValutatore;
    AggiornaDataCompilazione;
    W022DtM2.CalcolaTotali(True);
    dgrdDettaglio.medpCaricaCDS(SG711Rowid);
    if FaseAssegnazionePreventivaObiettiviTerminata and PunteggiVuoti(False) then
      MsgBox.MessageBox('Attenzione! Non per tutti gli elementi valutabili è stato indicato il punteggio!',ESCLAMA)
    else if FaseAssegnazionePreventivaObiettiviTerminata and NotePunteggiVuote then
      MsgBox.MessageBox('Attenzione! Non sono state indicate le note per tutti i punteggi che le prevedono!',ESCLAMA);
    if W022DtM2.TotPerc <> 100 then
      MsgBox.MessageBox('Attenzione! Il totale del peso percentuale delle aree di valutazione deve essere 100! (Attuale: ' + FloatToStr(W022DtM2.TotPerc) + ')',ESCLAMA)
    else if W022DtM2.AnomaliaRangePesoArea(Msg) then
      GGetWebApplicationThreadVar.ShowMessage('Attenzione!' + CRLF + Msg);
  end;
end;

procedure TW022FDettaglioValutazioni.btnModificaProtocolloClick(Sender: TObject);
begin
  inherited;
  ModificaProtocollo:=True;
  AbilitazioneControlli;
end;

procedure TW022FDettaglioValutazioni.btnConfermaProtocolloClick(Sender: TObject);
var NumProtocollo,AnnoProtocollo:Integer;
    DataProtocollo:TDateTime;
begin
  inherited;
  with W022DtM2 do
  begin
    if Trim(edtNumeroProtocollo.Text) <> '' then
      try
        NumProtocollo:=StrToInt(Trim(edtNumeroProtocollo.Text));
      except
        MsgBox.MessageBox('Il numero di protocollo ' + edtNumeroProtocollo.Text + ' non è consentito!',ERRORE);
        Abort;
      end;
    if Trim(edtAnnoProtocollo.Text) <> '' then
      try
        AnnoProtocollo:=StrToInt(Trim(edtAnnoProtocollo.Text));
      except
        MsgBox.MessageBox('L''anno del protocollo ' + edtAnnoProtocollo.Text + ' non è consentito!',ERRORE);
        Abort;
      end;
    if Trim(edtDataProtocollo.Text) <> '' then
      try
        DataProtocollo:=StrToDateTime(Trim(edtDataProtocollo.Text));
      except
        MsgBox.MessageBox('La data del protocollo ' + edtDataProtocollo.Text + ' non è consentita!',ERRORE);
        Abort;
      end;
    if ((Trim(edtNumeroProtocollo.Text) <> '') or (Trim(edtAnnoProtocollo.Text) <> '') or (Trim(edtDataProtocollo.Text) <> ''))
    and ((Trim(edtNumeroProtocollo.Text) = '') or (Trim(edtAnnoProtocollo.Text) = '') or (Trim(edtDataProtocollo.Text) = '')) then
    begin
      MsgBox.MessageBox('I dati del protocollo devono essere tutti valorizzati oppure tutti lasciati vuoti!',ERRORE);
      Abort;
    end;
    Q710.Edit;
    if Trim(edtNumeroProtocollo.Text) = '' then
      Q710.FieldByName('NUMERO_PROTOCOLLO').Clear
    else
      Q710.FieldByName('NUMERO_PROTOCOLLO').AsInteger:=StrToInt(Trim(edtNumeroProtocollo.Text));
    if Trim(edtAnnoProtocollo.Text) = '' then
      Q710.FieldByName('ANNO_PROTOCOLLO').Clear
    else
      Q710.FieldByName('ANNO_PROTOCOLLO').AsInteger:=StrToInt(Trim(edtAnnoProtocollo.Text));
    if Trim(edtDataProtocollo.Text) = '' then
      Q710.FieldByName('DATA_PROTOCOLLO').Clear
    else
      Q710.FieldByName('DATA_PROTOCOLLO').AsDateTime:=StrToDateTime(Trim(edtDataProtocollo.Text));
    Q710.Post;
  end;
  ModificaProtocollo:=False;
  AbilitazioneControlli;
end;

procedure TW022FDettaglioValutazioni.btnAnnullaProtocolloClick(Sender: TObject);
begin
  inherited;
  ModificaProtocollo:=False;
  AbilitazioneControlli;
end;

function TW022FDettaglioValutazioni.PunteggiVuoti(Chiusura: Boolean): Boolean;
var
  SG711Rowid: String;
begin
  Result:=False;
  with W022DtM2.Q711 do
  begin
    SG711Rowid:=Rowid;
    DisableControls;
    First;
    while not Eof do
    begin
      if (FieldByName('VALUTABILE').AsString = 'S') and (Chiusura or (FieldByName('PUNTEGGI_ABILITATI').AsString = 'S')) and FieldByName('COD_PUNTEGGIO').IsNull and FieldByName('PUNTEGGIO').IsNull then
      begin
        Result:=True;
        Break;
      end;
      Next;
    end;
    SearchRecord('ROWID',SG711Rowid,[srFromBeginning]);
    EnableControls;
  end;
end;

function TW022FDettaglioValutazioni.NotePunteggiVuote: Boolean;
var
  SG711Rowid: String;
begin
  Result:=False;
  with W022DtM2.Q711 do
  begin
    SG711Rowid:=Rowid;
    DisableControls;
    First;
    while not Eof do
    begin
      if (VarToStr(W022DtM2.selSG730.Lookup('CODICE',FieldByName('COD_PUNTEGGIO').AsString,'GIUSTIFICA')) = 'S') and FieldByName('NOTE_PUNTEGGIO').IsNull then
      begin
        Result:=True;
        Break;
      end;
      Next;
    end;
    SearchRecord('ROWID',SG711Rowid,[srFromBeginning]);
    EnableControls;
  end;
end;

procedure TW022FDettaglioValutazioni.btnAnnullaDettaglioClick(Sender: TObject);
var
  SG711Rowid: String;
begin
  inherited;
  //Annullo tutte le modifiche fatte sul dataset
  SessioneOracle.CancelUpdates([W022DtM2.Q711]);
  //Se annullo l'inserimento, cancello l'elemento personalizzato che ho appena inserito
  if InserisciDettaglio and W022DtM2.Q711.SearchRecord('SG711_ROWID',RigaInserita,[srFromBeginning]) then
  begin
    W022DtM2.Q711.Delete;
    SessioneOracle.ApplyUpdates([W022DtM2.Q711],True);
  end;
  dgrdDettaglio.RowClick:=True;
  ModificaDettaglio:=False;
  InserisciDettaglio:=False;
  SG711Rowid:=W022DtM2.Q711.Rowid;
  W022DtM2.Q711.Refresh;
  W022DtM2.Q711.SearchRecord('ROWID',SG711Rowid,[srFromBeginning]);
  AbilitazioneControlli;
  DistruggiComponenti;
  dgrdDettaglio.medpCaricaCDS(SG711Rowid);
end;

procedure TW022FDettaglioValutazioni.btnAvanzaStatoClick(Sender: TObject);
var
  Msg: String;
  W022Note: TW022FImpostaNoteFM;
begin
  with W022DtM2 do
  begin
    if Sender = btnAvanzaStato then
    begin
      CalcolaTotali(False);
      dgrdDettaglio.medpCaricaCDS;
      if TotPerc <> 100 then
      begin
        MsgBox.MessageBox('Impossibile avanzare la scheda allo stato successivo!' + CRLF + 'Il totale del peso percentuale delle aree di valutazione deve essere 100! (Attuale: ' + FloatToStr(TotPerc) + ')',ERRORE);
        abort;
      end
      else if AnomaliaRangePesoArea(Msg) then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Impossibile avanzare la scheda allo stato successivo!' + CRLF + Msg);
        exit;
      end
      else if SchedeCollegateChiuse(Msg) then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Impossibile avanzare la scheda allo stato successivo!' + CRLF + Msg);
        exit;
      end
      else if PunteggiVuoti(False) then
      begin
        MsgBox.MessageBox('Impossibile avanzare la scheda allo stato successivo!' + CRLF + 'Non per tutti gli elementi valutabili è stato indicato il punteggio!',ERRORE);
        abort;
      end
      else if NotePunteggiVuote then
      begin
        MsgBox.MessageBox('Impossibile avanzare la scheda allo stato successivo!' + CRLF + 'Non sono state indicate le note per tutti i punteggi che le prevedono!',ERRORE);
        abort;
      end;
      ControllaValutazioneIntermedia;
      AssegnaValutatore;
      EliminaValidazioni;
      CalcolaTotali(True);
      // Aggiorno eventualmente la data di compilazione
      updSG710.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
      updSG710.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
      updSG710.SetVariable('TIPO_VAL',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
      updSG710.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      updSG710.SetVariable('CHIUSO','N');
      updSG710.SetVariable('AGGIORNA',selSG741.FieldByName('AGGIORNA_DATA_COMPILAZIONE').AsString);
      updSG710.Execute;
      SessioneOracle.Commit;
      // Duplico la scheda
      insSG710.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
      insSG710.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
      insSG710.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
      insSG710.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      insSG710.Execute;
      insaSG711.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
      insaSG711.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
      insaSG711.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
      insaSG711.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      insaSG711.Execute;
      InviaEMail('A',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    end
    else
    begin
      if (Parametri.S710_ValidaStato = 'S') and not NoteValidaRichiesto then
      begin
        NoteValidaRichiesto:=True;
        with selSG745 do
        begin
          Close;
          SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
          SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
          SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
          SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
          Open;
        end;
        cdsNoteValida.EmptyDataSet;
        cdsNoteValida.Append;
        cdsNoteValida.FieldByName('MOTIVAZIONE').AsString:=VarToStr(selSG745.Lookup('TIPO_CONSEGNA','VS','MOTIVAZIONE'));
        cdsNoteValida.Post;
        W022Note:=TW022FImpostaNoteFM.Create(Self);
        W022Note.W022DtM3:=W022DtM2;
        W022Note.grdNote.medpDataSet:=cdsNoteValida;
        W022Note.ReadOnly:=False;
        W022Note.Apri;
        W022Note.Visualizza;
        exit;
      end;
      NoteValidaRichiesto:=False;
      Q710.Delete;
    end;
    SessioneOracle.Commit;
    Q710.Close;
    Q710.Open;
    if cdsRegole.Locate('DATA;PROGRESSIVO',VarArrayOf([DataRif,Q710.FieldByName('PROGRESSIVO').AsInteger]),[]) then
    begin
      cdsRegole.Edit;
      cdsRegole.FieldByName('STAMPA_ABILITATA').AsString:='';
      cdsRegole.FieldByName('STATO_ABILITATO').AsString:='';
      cdsRegole.Post;
    end;
    RecuperaAbilitazioneScheda(Q710.FieldByName('DATA').AsDateTime,DataRif,Q710.FieldByName('PROGRESSIVO').AsInteger,Q710.FieldByName('TIPO_VALUTAZIONE').AsString,False);
    dgrdDettaglio.medpCaricaCDS;
    CaricaCampiDescrittivi;
    ImpostaValutatore;
    AbilitazioneControlli;
  end;
end;

procedure TW022FDettaglioValutazioni.btnBloccaSchedaClick(Sender: TObject);
begin
  inherited;
  with W022DtM2 do
  begin
    // Blocco/Sblocco la scheda
    updSG710.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    updSG710.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    updSG710.SetVariable('TIPO_VAL',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    updSG710.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    updSG710.SetVariable('CHIUSO',IfThen(Sender = btnBloccaScheda,'B','N'));
    updSG710.SetVariable('AGGIORNA','N');
    updSG710.Execute;
    SessioneOracle.Commit;
    Q710.Close;
    Q710.Open;
    AbilitazioneControlli;
  end;
end;

procedure TW022FDettaglioValutazioni.btnChiudiSchedaClick(Sender: TObject);
var
  Msg: String;
  BM: TBookMark;
begin
  inherited;
  with W022DtM2 do
  begin
    if Sender = btnChiudiScheda then
    begin
      if SchedeCollegateChiuse(Msg) then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Impossibile chiudere la scheda!' + CRLF + Msg);
        exit;
      end;
      vSchedeCollegateAperte:=SchedeCollegateAperte(Msg);
      // Aggiorno i punteggi degli elementi collegati
      with Q711 do
      begin
        DisableControls;
        BM:=GetBookMark;
		try { TODO : TEST IW 15 }
          First;
          while not Eof do
          begin
            Edit;
            Post;
            Next;
          end;
          GotoBookMark(BM);
		finally
          FreeBookMark(BM);
		end;
        EnableControls;
      end;
      SessioneOracle.ApplyUpdates([Q711],True);
      CalcolaTotali(True);
      dgrdDettaglio.medpCaricaCDS;
      // Controllo se è possibile chiudere la scheda
      if Q710.FieldByName('VALUTABILE').AsString = 'S' then
      begin
        if TotPerc <> 100 then
        begin
          MsgBox.MessageBox('Impossibile chiudere la scheda!' + CRLF + 'Il totale del peso percentuale delle aree di valutazione deve essere 100! (Attuale: ' + FloatToStr(TotPerc) + ')',ERRORE);
          abort;
        end;
        if AnomaliaRangePesoArea(Msg) then
        begin
          GGetWebApplicationThreadVar.ShowMessage('Impossibile chiudere la scheda!' + CRLF + Msg);
          exit;
        end;
        if VarToStr(Q711.Lookup('VALUTABILE','S','VALUTABILE')) = '' then
        begin
          MsgBox.MessageBox('Impossibile chiudere la scheda!' + CRLF + 'Nessun elemento valutabile!',ERRORE);
          abort;
        end
        else if SchedeCollegateAperte(Msg) then
        begin
          GGetWebApplicationThreadVar.ShowMessage('Impossibile chiudere la scheda!' + CRLF + Msg);
          exit;
        end
        else if PunteggiVuoti(True) then
        begin
          MsgBox.MessageBox('Impossibile chiudere la scheda!' + CRLF + 'Non per tutti gli elementi valutabili è stato indicato il punteggio!',ERRORE);
          abort;
        end
        else if NotePunteggiVuote then
        begin
          MsgBox.MessageBox('Impossibile chiudere la scheda!' + CRLF + 'Non sono state indicate le note per tutti i punteggi che le prevedono!',ERRORE);
          abort;
        end;
        // Se la scheda prevede la sezione delle Proposte formative e si vuole almeno un'area formativa compilata, verifico che non siano tutte vuote
        if (Q710.FieldByName('TIPO_VALUTAZIONE').AsString = 'V') and
           (Pos('P3', selSG741.FieldByName('PAGINE_ABILITATE').AsString) > 0) and
           (selSG741.FieldByName('AREA_FORMATIVA_OBBLIGATORIA').AsString = 'S') and
           Q710.FieldByName('PROPOSTE_FORMATIVE_1').IsNull and
           Q710.FieldByName('PROPOSTE_FORMATIVE_2').IsNull and
           Q710.FieldByName('PROPOSTE_FORMATIVE_3').IsNull then
        begin
          MsgBox.MessageBox('Impossibile chiudere la scheda!' + CRLF + 'Indicare almeno un''area formativa!',ERRORE);
          abort;
        end;
        ControllaValutazioneIntermedia;
      end;
      AssegnaValutatore;
      EliminaValidazioni;
      // Chiudo la scheda
      updSG710.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
      updSG710.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
      updSG710.SetVariable('TIPO_VAL',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
      updSG710.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      updSG710.SetVariable('CHIUSO','S');
      updSG710.SetVariable('AGGIORNA',selSG741.FieldByName('AGGIORNA_DATA_COMPILAZIONE').AsString);
      updSG710.Execute; // Una chiusura parallela viene effettuata anche in TW022FSchedaValutazioniDtM.Q710AfterPost
      InviaEMail('C',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    end
    else
    begin
      if SchedeCollegateChiuse(Msg) then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Impossibile riaprire la scheda!' + CRLF + Msg);
        exit;
      end;
      // Riapro la scheda
      updSG710.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
      updSG710.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
      updSG710.SetVariable('TIPO_VAL',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
      updSG710.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      updSG710.SetVariable('CHIUSO','N');
      updSG710.SetVariable('AGGIORNA','N');
      updSG710.Execute;
      // Svuoto gli elementi dipendenti dai collegati
      updSG711a.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
      updSG711a.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
      updSG711a.SetVariable('TIPO_VAL',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
      updSG711a.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      updSG711a.Execute;
    end;
    SessioneOracle.Commit;
    Q710.Close;
    Q710.Open;
    CalcolaTotali(True);
  end;
  dgrdDettaglio.medpCaricaCDS;
  AbilitazioneControlli;
end;

procedure TW022FDettaglioValutazioni.dgrdDettaglioRenderCell(ACell: TIWGridCell; const ARow,AColumn: Integer);
var
  NumColonna: Integer;
begin
  inherited;

  if not dgrdDettaglio.medpRenderCell(ACell,ARow,AColumn,True,True) then
    exit;
  if ARow = 0 then
  begin
    if dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('COD_AREA') then
      ACell.Text:=W022DtM2.RecuperaEtichetta('CODICE_AREA_C')
    else if dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('D_AREA') then
      ACell.Text:=W022DtM2.RecuperaEtichetta('DESCRIZIONE_AREA_C')
    else if dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('CF_PERC_AREA') then
      ACell.Text:=W022DtM2.RecuperaEtichetta('PESO_AREA_C')
    else if dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('CF_PUNTEGGIO_AREA') then
      ACell.Text:=W022DtM2.RecuperaEtichetta('PUNTEGGIO_AREA_C')
    else if dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('COD_VALUTAZIONE') then
      ACell.Text:=W022DtM2.RecuperaEtichetta('CODICE_ITEM_C')
    else if dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('D_VALUTAZIONE') then
      ACell.Text:=W022DtM2.RecuperaEtichetta('DESCRIZIONE_ITEM_C')
    else if dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('CF_PERC_VALUTAZIONE') then
      ACell.Text:=W022DtM2.RecuperaEtichetta('PESO_ITEM_C')
    else if dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('SOGLIA_PUNTEGGIO') then
      ACell.Text:=W022DtM2.RecuperaEtichetta('SOGLIA_PUNTEGGIO_ITEM_C')
    else if dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('VALUTABILE') then
      ACell.Text:=W022DtM2.RecuperaEtichetta('ITEM_VALUTABILE_C')
    else if dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('D_PUNTEGGIO') then
      ACell.Text:=W022DtM2.RecuperaEtichetta('PUNTEGGIO_ITEM_C')
    else if dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('NOTE_PUNTEGGIO') then
      ACell.Text:=W022DtM2.RecuperaEtichetta('NOTE_PUNTEGGIO_C')
    else if dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('CF_PUNTEGGIO_PESATO') then
      ACell.Text:=W022DtM2.RecuperaEtichetta('PUNTEGGIO_PESATO_ITEM_C');
  end;

  if AColumn = 3 then
    ACell.Css:=IfThen(W022DtM2.selSG730.FieldByName('CALCOLO_PFP').AsString = 'S',ACell.Css,'invisibile');

  if (ARow <> 0) and ((AColumn = 4) or (AColumn = 5)) and (dgrdDettaglio.medpValoreColonna(ARow - 1,'VALUTAZIONE_ORIGINALE') = 'N') then
    ACell.Css:='riga_evidenziata';

  if (ARow = 0) and (dgrdDettaglio.medpNumColonna(AColumn) = dgrdDettaglio.medpIndexColonna('D_PUNTEGGIO')) then
  begin
    ACell.Control:=C190DBGridCreaLink(Self.Owner,(Self.Parent as TWinControl),'legenda','',ACell.Text);
    ACell.Text:='';
    (ACell.Control as TmeIWLink).OnClick:=lnkLegendaPunteggiClick;
  end;
  if (ARow > 0) and not R180In(dgrdDettaglio.medpNumColonna(AColumn),[dgrdDettaglio.medpIndexColonna('D_AREA'),dgrdDettaglio.medpIndexColonna('D_VALUTAZIONE')]) then
    ACell.Css:=ACell.Css + ' align_center';

  // assegnazione componenti alle celle
  NumColonna:=dgrdDettaglio.medpNumColonna(AColumn);
  if (ARow > 0) and (ARow - 1 <= High(dgrdDettaglio.medpCompGriglia)) and (dgrdDettaglio.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    if (NumColonna = dgrdDettaglio.medpIndexColonna('D_PUNTEGGIO'))
    and (dgrdDettaglio.medpCompGriglia[ARow - 1].CompColonne[dgrdDettaglio.medpIndexColonna('GIUDICABILE')] <> nil)
    and not ((dgrdDettaglio.medpCompGriglia[ARow - 1].CompColonne[dgrdDettaglio.medpIndexColonna('GIUDICABILE')]) as TmeIWCheckBox).Checked then
      ACell.Text:=VarToStr(W022DtM2.selSG730.Lookup('ITEM_GIUDICABILE','N','CODICE'))
    else
      ACell.Text:='';
    ACell.Control:=dgrdDettaglio.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

end;

procedure TW022FDettaglioValutazioni.dgrdDettaglio2ColumnsClick(ASender: TObject; const AValue: string);
begin
  dgrdDettaglio.medpClientDataSet.Locate('DBG_ROWID',AValue,[]);
  W022DtM2.Q711.SearchRecord('SG711_ROWID',AValue,[srFromBeginning]);
  AbilitazioneControlli;
end;

procedure TW022FDettaglioValutazioni.dgrdDettaglioAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i,c: Integer;
begin
  // Righe dati
  for i:=0 to High(dgrdDettaglio.medpCompGriglia) do
  begin
    // giudicabile
    c:=dgrdDettaglio.medpIndexColonna('GIUDICABILE');
    if not R180InConcat('5',W022DtM2.selSG741.FieldByName('CAMPI_OPZIONALI_COMPILAZIONE').AsString)
    or ((dgrdDettaglio.medpValoreColonna(i,'VALUTABILE') = 'N') and (W022DtM2.ProprietaArea(dgrdDettaglio.medpValoreColonna(i,'COD_AREA'),W022DtM2.DataRif,'PUNTEGGI_SOLO_ITEM_VALUTABILI') = 'S')) then
      FreeAndNil(dgrdDettaglio.medpCompGriglia[i].CompColonne[c])
    else
      with (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWCheckBox) do
      begin
        Checked:=(dgrdDettaglio.medpValoreColonna(i,'D_PUNTEGGIO') = '') or (dgrdDettaglio.medpValoreColonna(i,'D_PUNTEGGIO') <> VarToStr(W022DtM2.selSG730.Lookup('ITEM_GIUDICABILE','N','CODICE')));
        Enabled:=False;
      end;
    // note punteggio
    c:=dgrdDettaglio.medpIndexColonna('NOTE_PUNTEGGIO');
    if StileNote = '' then
      StileNote:=(dgrdDettaglio.medpCompCella(i,c,0) as TmeIWImageFile).Css;
    if VarToStr(W022DtM2.selSG730.Lookup('GIUSTIFICA','S','GIUSTIFICA')) <> 'S' then
      FreeAndNil(dgrdDettaglio.medpCompGriglia[i].CompColonne[c])
    else
      with (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWImageFile) do
      begin
        OnClick:=imgNoteClick;
        Hint:=StringReplace(VarToStr(W022DtM2.Q711.Lookup('COD_AREA;COD_VALUTAZIONE',VarArrayOf([dgrdDettaglio.medpValoreColonna(i,'COD_AREA'),dgrdDettaglio.medpValoreColonna(i, 'COD_VALUTAZIONE')]),'NOTE_PUNTEGGIO')),CRLF,' ',[rfReplaceAll]);
        ImageFile.FileName:=IfThen(Hint <> '',fileImgElencoHighlight,fileImgElenco);
        if VarToStr(W022DtM2.selSG730.Lookup('CODICE',dgrdDettaglio.medpValoreColonna(i,'COD_PUNTEGGIO'),'GIUSTIFICA')) <> 'S' then
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWImageFile).Css:='invisibile';
      end;
  end;
end;

procedure TW022FDettaglioValutazioni.CreaComponenti;
var
  i,c: Integer;
  EsisteFaseAssegnazionePreventivaObiettivi,FaseAssegnazionePreventivaObiettiviTerminata: Boolean;
begin
  with W022DtM2 do
  begin
    EsisteFaseAssegnazionePreventivaObiettivi:=selSG741.FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S';
    FaseAssegnazionePreventivaObiettiviTerminata:=not EsisteFaseAssegnazionePreventivaObiettivi or not Q710.FieldByName('ACCETTAZIONE_OBIETTIVI').IsNull;
  end;
  for i:=0 to High(dgrdDettaglio.medpCompGriglia) do
  begin
    if not EsisteFaseAssegnazionePreventivaObiettivi or not FaseAssegnazionePreventivaObiettiviTerminata then
    begin
      if dgrdDettaglio.medpValoreColonna(i,'ELEMENTI_ABILITATI') = 'S' then
      begin
        if dgrdDettaglio.medpValoreColonna(i,'VALUTAZIONE_ORIGINALE') = 'N' then
        begin
          // codice elemento
          c:=dgrdDettaglio.medpIndexColonna('COD_VALUTAZIONE');
          dgrdDettaglio.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'5','','','');
          dgrdDettaglio.medpCreaComponenteGenerico(i,c,dgrdDettaglio.Componenti);
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit).Text:=dgrdDettaglio.medpValoreColonna(i,'COD_VALUTAZIONE');
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit).MaxLength:=5;
          // descrizione elemento
          c:=dgrdDettaglio.medpIndexColonna('D_VALUTAZIONE');
          dgrdDettaglio.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO_COUR,'100%','','','','S');
          dgrdDettaglio.medpCreaComponenteGenerico(i,c,dgrdDettaglio.Componenti);
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWMemo).Lines.Text:=dgrdDettaglio.medpValoreColonna(i,'DESC_VALUTAZIONE_AGG');
        end;
        if W022DtM2.ProprietaArea(dgrdDettaglio.medpValoreColonna(i,'COD_AREA'),W022DtM2.DataRif,'PESO_ITEM_MODIFICABILE') = 'S' then
        begin
          // peso percentuale elemento
          c:=dgrdDettaglio.medpIndexColonna('CF_PERC_VALUTAZIONE');
          dgrdDettaglio.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'5','','','');
          dgrdDettaglio.medpCreaComponenteGenerico(i,c,dgrdDettaglio.Componenti);
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit).Text:=dgrdDettaglio.medpValoreColonna(i,'CF_PERC_VALUTAZIONE');
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit).MaxLength:=6;
        end;
        if W022DtM2.ProprietaArea(dgrdDettaglio.medpValoreColonna(i,'COD_AREA'),W022DtM2.DataRif,'PUNTEGGI_CON_SOGLIA') = 'S' then
        begin
          // soglia raggiungimento
          c:=dgrdDettaglio.medpIndexColonna('SOGLIA_PUNTEGGIO');
          dgrdDettaglio.medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'5','2','','','',False);
          dgrdDettaglio.medpCreaComponenteGenerico(i,c,dgrdDettaglio.Componenti);
          with (dgrdDettaglio.medpCompCella(i,c,0) as TmedpIWMultiColumnComboBox) do
          begin
            PopUpWidth:=10;
            PopUpHeight:=10;
            W022DtM2.selSG730.First;
            while not W022DtM2.selSG730.Eof do
            begin
              if W022DtM2.selSG730.FieldByName('ITEM_GIUDICABILE').AsString = 'S' then
                AddRow(Format('%s;%s',[W022DtM2.selSG730.FieldByName('CODICE').AsString,W022DtM2.selSG730.FieldByName('DESCRIZIONE').AsString]));
              W022DtM2.selSG730.Next;
            end;
            Text:=dgrdDettaglio.medpValoreColonna(i,'SOGLIA_PUNTEGGIO');
            NonEditableAsLabel:=False;
            Enabled:=Abilitazione = 'S';
          end;
        end;
        if W022DtM2.ProprietaArea(dgrdDettaglio.medpValoreColonna(i,'COD_AREA'),W022DtM2.DataRif,'ITEM_TUTTI_VALUTABILI') = 'N' then
        begin
          // valutabile
          c:=dgrdDettaglio.medpIndexColonna('VALUTABILE');
          dgrdDettaglio.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'2','','','','');
          dgrdDettaglio.medpCreaComponenteGenerico(i,c,dgrdDettaglio.Componenti);
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWComboBox).Items.Clear;
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWComboBox).Items.Add('S');
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWComboBox).Items.Add('N');
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWComboBox).ItemIndex:=(dgrdDettaglio.medpCompCella(i,c,0) as TmeIWComboBox).Items.IndexOf(dgrdDettaglio.medpValoreColonna(i,'VALUTABILE'));
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWComboBox).RenderSize:=False;
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWComboBox).UseSize:=False;
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWComboBox).Font.Enabled:=False;
        end;
      end;
    end;
    if FaseAssegnazionePreventivaObiettiviTerminata then
    begin
      if (dgrdDettaglio.medpValoreColonna(i,'PUNTEGGI_ABILITATI') = 'S') and
        ((dgrdDettaglio.medpValoreColonna(i,'VALUTABILE') = 'S') or (W022DtM2.ProprietaArea(dgrdDettaglio.medpValoreColonna(i,'COD_AREA'),W022DtM2.DataRif,'PUNTEGGI_SOLO_ITEM_VALUTABILI') = 'N')) then
      begin
        // punteggio
        c:=dgrdDettaglio.medpIndexColonna('D_PUNTEGGIO');
        if W022DtM2.ProprietaArea(dgrdDettaglio.medpValoreColonna(i,'COD_AREA'),W022DtM2.DataRif,'PUNTEGGI_CON_PERCENTUALE') = 'S' then
        begin
          // percentuale
          dgrdDettaglio.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'5','','','');
          dgrdDettaglio.medpCreaComponenteGenerico(i,c,dgrdDettaglio.Componenti);
          if StilePuntEdt = '' then
            StilePuntEdt:=(dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit).Css;
          if (dgrdDettaglio.medpValoreColonna(i,'D_PUNTEGGIO') <> '')
          and (dgrdDettaglio.medpValoreColonna(i,'D_PUNTEGGIO') = VarToStr(W022DtM2.selSG730.Lookup('ITEM_GIUDICABILE','N','CODICE'))) then
            (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit).Css:='invisibile'
          else
            (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit).Text:=dgrdDettaglio.medpValoreColonna(i,'D_PUNTEGGIO');
          (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit).MaxLength:=5;
        end
        else
        begin
          // lista codici
          dgrdDettaglio.medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'5','2','','','',False);
          dgrdDettaglio.medpCreaComponenteGenerico(i,c,dgrdDettaglio.Componenti);
          with (dgrdDettaglio.medpCompCella(i,c,0) as TmedpIWMultiColumnComboBox) do
          begin
            PopUpWidth:=10;
            PopUpHeight:=10;
            W022DtM2.selSG730.First;
            while not W022DtM2.selSG730.Eof do
            begin
              if W022DtM2.selSG730.FieldByName('ITEM_GIUDICABILE').AsString = 'S' then
                AddRow(Format('%s;%s',[W022DtM2.selSG730.FieldByName('CODICE').AsString,W022DtM2.selSG730.FieldByName('DESCRIZIONE').AsString]));
              W022DtM2.selSG730.Next;
            end;
            if StilePuntCmb = '' then
              StilePuntCmb:=Css;
            if (dgrdDettaglio.medpValoreColonna(i,'D_PUNTEGGIO') <> '')
            and (dgrdDettaglio.medpValoreColonna(i,'D_PUNTEGGIO') = VarToStr(W022DtM2.selSG730.Lookup('ITEM_GIUDICABILE','N','CODICE'))) then
              Css:='invisibile'
            else
              Text:=dgrdDettaglio.medpValoreColonna(i,'D_PUNTEGGIO');
            NonEditableAsLabel:=False;
            Enabled:=Abilitazione = 'S';
            OnAsyncChange:=mccbPunteggioAsyncChange;
          end;
        end;
        // giudicabile
        c:=dgrdDettaglio.medpIndexColonna('GIUDICABILE');
        if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
          with dgrdDettaglio.medpCompCella(i,c,0) as TmeIWCheckBox do
          begin
            Enabled:=True;
            if dgrdDettaglio.medpCompCella(i,dgrdDettaglio.medpIndexColonna('D_PUNTEGGIO'),0) <> nil then
            begin
              if dgrdDettaglio.medpCompCella(i,dgrdDettaglio.medpIndexColonna('D_PUNTEGGIO'),0) is TmedpIWMultiColumnComboBox then
                OnClick:=chkGiudicabileClick
              else
                OnAsyncClick:=chkGiudicabileAsyncClick;
            end;
          end;
      end;
    end;
  end;
end;

procedure TW022FDettaglioValutazioni.chkAccettazioneObiettiviNoClick(Sender: TObject);
var
  Msg: String;
begin
  Msg:=ControlliAccettazioneObiettivi;
  if Msg <> '' then
  begin
    chkAccettazioneObiettiviNo.Checked:=False;
    MsgBox.MessageBox(Msg,ERRORE);
    abort;
  end;
  if chkAccettazioneObiettiviNo.Checked and chkAccettazioneObiettiviSi.Checked then
    chkAccettazioneObiettiviSi.Checked:=False;
  W022DtM2.AccettazioneObiettivi:=IfThen(chkAccettazioneObiettiviSi.Checked,'S',IfThen(chkAccettazioneObiettiviNo.Checked,'N','tolto'));
  if chkAccettazioneObiettiviNo.Checked then
    chkAccettazioneValutatoNoClick(nil)
  else
    chkAccettazioneValutatoSiClick(nil);
end;

procedure TW022FDettaglioValutazioni.chkAccettazioneObiettiviSiClick(Sender: TObject);
var
  Msg: String;
begin
  Msg:=ControlliAccettazioneObiettivi;
  if Msg <> '' then
  begin
    chkAccettazioneObiettiviSi.Checked:=False;
    MsgBox.MessageBox(Msg,ERRORE);
    abort;
  end;
  if chkAccettazioneObiettiviSi.Checked and chkAccettazioneObiettiviNo.Checked then
    chkAccettazioneObiettiviNo.Checked:=False;
  W022DtM2.AccettazioneObiettivi:=IfThen(chkAccettazioneObiettiviSi.Checked,'S',IfThen(chkAccettazioneObiettiviNo.Checked,'N','tolto'));
  chkAccettazioneValutatoSiClick(nil);
end;

function TW022FDettaglioValutazioni.ControlliAccettazioneObiettivi: String;
var
  Importo,Ore,Rapporto: Real;
  ImportoDisponibile: Real;
  OreMancanti,Msg: String;
begin
  Result:='';
  Rapporto:=0;
  W022DtM2.CalcolaTotali(False);
  if W022DtM2.TotPerc <> 100 then
    Result:='Attenzione! Non è possibile accettare gli obiettivi perché la somma dei pesi percentuali delle aree di valutazione è diversa da 100! (Attuale: ' + FloatToStr(W022DtM2.TotPerc) + ')'
  else if W022DtM2.AnomaliaRangePesoArea(Msg) then
    Result:='Attenzione! Non è possibile accettare gli obiettivi!' + CRLF + Msg
  else if dedtImportoIncentivo.Text = '' then
    Result:='Attenzione! Non è possibile accettare gli obiettivi perché non è stato compilato il campo "' + lblImportoIncentivo.Caption + '"!'
  else if dedtOrarioNegoziato.Text = '' then
    Result:='Attenzione! Non è possibile accettare gli obiettivi perché non è stato compilato il campo "' + lblOrarioNegoziato.Caption + '"!'
  else
  begin
    try
      Importo:=StrToFloat(dedtImportoIncentivo.Text);
      Ore:=R180OreMinutiExt(dedtOrarioNegoziato.Text) / 60;
      Rapporto:=R180Arrotonda(Importo / Ore, 0.01, 'P');
      if (Rapporto < 45) or (Rapporto > 75) then
        raise Exception.Create('');
    except
      Result:='Il rapporto tra il campo "' + lblImportoIncentivo.Caption + '" e il campo "' + lblOrarioNegoziato.Caption + '" deve essere compreso tra 45 e 75! (Attuale: ' + FloatToStr(Rapporto) + ')';
    end;
    if (Result = '') and ((Importo < 0) or (Ore < 0)) then
      Result:='Attenzione! Non è possibile accettare gli obiettivi perché sono stati indicati valori negativi!';
  end;
  if (Result = '') and (chkAccettazioneObiettiviSi.Checked or chkAccettazioneObiettiviNo.Checked) then
  begin
    OreMancanti:=R180MinutiOre(R180OreMinutiExt(W022DtM2.GruppoIncentivi.OreMin) - R180OreMinutiExt(W022DtM2.GruppoIncentivi.OreAssegnate) - R180OreMinutiExt(W022DtM2.Q710.FieldByName('ORE_INCENTIVO').AsString));
    ImportoDisponibile:=W022DtM2.GruppoIncentivi.ImpMax - W022DtM2.GruppoIncentivi.ImpAssegnato - W022DtM2.Q710.FieldByName('IMPORTO_INCENTIVO').AsFloat;
    if R180OreMinutiExt(OreMancanti) > 0 then
      Result:='Attenzione! Non è possibile accettare gli obiettivi perché non sono ancora state raggiunte le ore minime da assegnare al gruppo! (Ore mancanti: ' + OreMancanti + ')'
    else if ImportoDisponibile < 0 then
      Result:='Attenzione! Non è possibile accettare gli obiettivi perché è stato sorpassato l''importo massimo da assegnare al gruppo! (Quota eccedente: ' + Trim(R180Formatta(Abs(ImportoDisponibile),8,2)) + ')';
  end;
end;

procedure TW022FDettaglioValutazioni.chkAccettazioneValutatoNoClick(Sender: TObject);
begin
  chkAccettazioneValutatoSi.Checked:=False;
  chkAccettazioneValutatoNo.Checked:=True;
  W022DtM2.Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString:='N';
  AbilitazioneControlli;
end;

procedure TW022FDettaglioValutazioni.chkAccettazioneValutatoSiClick(Sender: TObject);
begin
  chkAccettazioneValutatoSi.Checked:=True;
  chkAccettazioneValutatoNo.Checked:=False;
  W022DtM2.Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString:='S';
  AbilitazioneControlli;
end;

procedure TW022FDettaglioValutazioni.chkEsitoValutazioneIntermediaNClick(Sender: TObject);
begin
  if chkEsitoValutazioneIntermediaN.Checked and chkEsitoValutazioneIntermediaP.Checked then
    chkEsitoValutazioneIntermediaP.Checked:=False;
  W022DtM2.EsitoValutazioneIntermedia:=IfThen(chkEsitoValutazioneIntermediaP.Checked,'P',IfThen(chkEsitoValutazioneIntermediaN.Checked,'N','tolto'));
end;

procedure TW022FDettaglioValutazioni.chkEsitoValutazioneIntermediaPClick(Sender: TObject);
begin
  if chkEsitoValutazioneIntermediaP.Checked and chkEsitoValutazioneIntermediaN.Checked then
    chkEsitoValutazioneIntermediaN.Checked:=False;
  W022DtM2.EsitoValutazioneIntermedia:=IfThen(chkEsitoValutazioneIntermediaP.Checked,'P',IfThen(chkEsitoValutazioneIntermediaN.Checked,'N','tolto'));
end;

procedure TW022FDettaglioValutazioni.grdRiepilogoIncentiviRenderCell(ACell: TIWGridCell; const ARow,AColumn: Integer);
begin
  if not RenderCell(ACell,ARow,AColumn,True,True) then
    exit;
  if (ARow > 0) and (AColumn in [2,3]) then
    ACell.Css:='riga_colorata';

  // assegnazione stili
  if (ARow > 0) and (AColumn = 2) and (Pos('+',ACell.Text) = 0) and (StrToFloatDef(StringReplace(grdRiepilogoIncentivi.Cell[1,2].Text,'.','',[rfReplaceAll]), 0) > W022DtM2.GruppoIncentivi.ImpMax) then
    ACell.Css:=ACell.Css + ' font_grassetto font_rosso';
  if (ARow > 0) and (AColumn = 3) and (Pos('+',ACell.Text) = 0) and (R180OreMinutiExt(grdRiepilogoIncentivi.Cell[1,3].Text) < R180OreMinutiExt(W022DtM2.GruppoIncentivi.OreMin)) then
    ACell.Css:=ACell.Css + ' font_grassetto font_rosso';
end;

procedure TW022FDettaglioValutazioni.chkValutabileClick(Sender: TObject);
begin
  W022DtM2.Q710.FieldByName('VALUTABILE').AsString:=IfThen(chkValutabile.Checked,'S','N');
  if not chkValutabile.Checked then
    MsgBox.MessageBox('Attenzione! Rendendo non valutabile il dipendente, la scheda sarà svuotata in tutte le sue parti, tranne le pagine ' + W022DtM2.RecuperaEtichetta('VALUTAZIONI_COMPLESSIVE_C') + ' e ' + W022DtM2.RecuperaEtichetta('NOTE_C') + '!',INFORMA);
end;

procedure TW022FDettaglioValutazioni.DistruggiComponenti;
var
  i: Integer;
begin
  for i:=0 to High(dgrdDettaglio.medpCompGriglia) do
  begin
    FreeAndNil(dgrdDettaglio.medpCompGriglia[i].CompColonne[4]);
    FreeAndNil(dgrdDettaglio.medpCompGriglia[i].CompColonne[5]);
    FreeAndNil(dgrdDettaglio.medpCompGriglia[i].CompColonne[6]);
    FreeAndNil(dgrdDettaglio.medpCompGriglia[i].CompColonne[7]);
    FreeAndNil(dgrdDettaglio.medpCompGriglia[i].CompColonne[8]);
    FreeAndNil(dgrdDettaglio.medpCompGriglia[i].CompColonne[9]);
    FreeAndNil(dgrdDettaglio.medpCompGriglia[i].CompColonne[10]);
    FreeAndNil(dgrdDettaglio.medpCompGriglia[i].CompColonne[11]);
  end;
end;

procedure TW022FDettaglioValutazioni.mccbPunteggioAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  VisualizzaNote(Sender);
end;

procedure TW022FDettaglioValutazioni.VisualizzaNote(Sender: TObject);
var
  i,c: Integer;
begin
  c:=dgrdDettaglio.medpIndexColonna('NOTE_PUNTEGGIO');
  for i:=0 to High(dgrdDettaglio.medpCompGriglia) do
    if dgrdDettaglio.medpCompGriglia[i].CompColonne[c] <> nil then
      with (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWImageFile) do
        if FriendlyName = (Sender as TmedpIWMultiColumnComboBox).FriendlyName then
        begin
          Css:=IfThen(   (VarToStr(W022DtM2.selSG730.Lookup('CODICE',(Sender as TmedpIWMultiColumnComboBox).Text,'GIUSTIFICA')) = 'S')
                      or (    (dgrdDettaglio.medpCompCella(i,dgrdDettaglio.medpIndexColonna('GIUDICABILE'),0) <> nil)
                          and not (dgrdDettaglio.medpCompCella(i,dgrdDettaglio.medpIndexColonna('GIUDICABILE'),0) as TmeIWCheckBox).Checked),
                      StileNote,'invisibile');
          DoRefreshControl:=True;
          Break;
        end;
end;

procedure TW022FDettaglioValutazioni.chkGiudicabileAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  VisualizzaPunteggi(Sender);
end;

procedure TW022FDettaglioValutazioni.chkGiudicabileClick(Sender: TObject);
begin
  VisualizzaPunteggi(Sender);
end;

procedure TW022FDettaglioValutazioni.VisualizzaPunteggi(Sender: TObject);
var
  i,c: Integer;
begin
  c:=dgrdDettaglio.medpIndexColonna('D_PUNTEGGIO');
  for i:=0 to High(dgrdDettaglio.medpCompGriglia) do
    if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
      if dgrdDettaglio.medpCompCella(i,c,0) is TmedpIWMultiColumnComboBox then
      begin
        with (dgrdDettaglio.medpCompCella(i,c,0) as TmedpIWMultiColumnComboBox) do
          if FriendlyName = (Sender as TmeIWCheckBox).FriendlyName then
          begin
            Css:=IfThen((Sender as TmeIWCheckBox).Checked,StilePuntCmb,'invisibile');
            DoRefreshControl:=True;
            VisualizzaNote(dgrdDettaglio.medpCompCella(i,c,0) as TmedpIWMultiColumnComboBox);
            Break;
          end;
      end
      else
        with (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit) do
          if FriendlyName = (Sender as TmeIWCheckBox).FriendlyName then
          begin
            Css:=IfThen((Sender as TmeIWCheckBox).Checked,StilePuntEdt,'invisibile');
            DoRefreshControl:=True;
            dgrdDettaglio.DoRefreshControl;
            //TODO! L'async non fa scattare il RenderCell, quindi come impostare il testo della cella col codice Non giudicabile?
            Break;
          end;
end;

procedure TW022FDettaglioValutazioni.imgNoteClick(Sender: TObject);
var
  W022Note: TW022FImpostaNoteFM;
  i,c: Integer;
  CodPunteggio:String;
begin
  with W022DtM2 do
  begin
    Q711.SearchRecord('SG711_ROWID',(Sender as TmeIWImageFile).FriendlyName,[srFromBeginning]);
    cdsNoteItem.EmptyDataSet;
    cdsNoteItem.Append;
    cdsNoteItem.FieldByName('COD_AREA').AsString:=Q711.FieldByName('COD_AREA').AsString;
    cdsNoteItem.FieldByName('D_AREA').AsString:=Q711.FieldByName('D_AREA').AsString;
    cdsNoteItem.FieldByName('COD_VALUTAZIONE').AsString:=Q711.FieldByName('COD_VALUTAZIONE').AsString;
    cdsNoteItem.FieldByName('D_VALUTAZIONE').AsString:=Q711.FieldByName('D_VALUTAZIONE').AsString;
    CodPunteggio:='';
    c:=dgrdDettaglio.medpIndexColonna('GIUDICABILE');
    for i:=0 to High(dgrdDettaglio.medpCompGriglia) do
      if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
        with dgrdDettaglio.medpCompCella(i,c,0) as TmeIWCheckBox do
          if FriendlyName = (Sender as TmeIWImageFile).FriendlyName then
          begin
            if not Checked then
              CodPunteggio:=VarToStr(selSG730.Lookup('ITEM_GIUDICABILE','N','CODICE'));
            Break;
          end;
    if CodPunteggio = '' then
    begin
      c:=dgrdDettaglio.medpIndexColonna('D_PUNTEGGIO');
      for i:=0 to High(dgrdDettaglio.medpCompGriglia) do
        if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
          if dgrdDettaglio.medpCompCella(i,c,0) is TmedpIWMultiColumnComboBox then
            with (dgrdDettaglio.medpCompCella(i,c,0) as TmedpIWMultiColumnComboBox) do
              if FriendlyName = (Sender as TmeIWImageFile).FriendlyName then
              begin
                CodPunteggio:=Text;
                Break;
              end;
    end;
    if CodPunteggio = '' then
      CodPunteggio:=Q711.FieldByName('D_PUNTEGGIO').AsString;
    cdsNoteItem.FieldByName('COD_PUNTEGGIO').AsString:=CodPunteggio;
    cdsNoteItem.FieldByName('D_PUNTEGGIO').AsString:=VarToStr(selSG730.Lookup('CODICE',CodPunteggio,'DESCRIZIONE'));
    cdsNoteItem.FieldByName('NOTE_PUNTEGGIO').AsString:=Q711.FieldByName('NOTE_PUNTEGGIO').AsString;
    cdsNoteItem.Post;
  end;
  W022Note:=TW022FImpostaNoteFM.Create(Self);
  W022Note.W022DtM3:=W022DtM2;
  W022Note.grdNote.medpDataSet:=W022DtM2.cdsNoteItem;
  W022Note.ReadOnly:=not btnConfermaDettaglio.Visible;
  W022Note.Apri;
  W022Note.ComponenteHint:=(Sender as TIWCustomControl);
  W022Note.Visualizza;
end;

procedure TW022FDettaglioValutazioni.AbilitazioneControlli;
var PeriodoOKCompilazione, PeriodoOKObiettivi,EsisteFaseAssegnazionePreventivaObiettivi,FaseAssegnazionePreventivaObiettiviTerminata,VisualizzazioneAnomala,AbilitaModificaTestata: Boolean;
    DataDaComp,DataAComp:TDateTime;
begin
  JQuery.OnReady.Clear;
  PeriodoOKCompilazione:=W022DtM2.FPeriodoOKCompilazione(W022DtM2.Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,sTipoVal3,DataDaComp,DataAComp);
  EsisteFaseAssegnazionePreventivaObiettivi:=W022DtM2.selSG741.FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S';
  PeriodoOKObiettivi:=W022DtM2.FPeriodoOKObiettivi(EsisteFaseAssegnazionePreventivaObiettivi);
  FaseAssegnazionePreventivaObiettiviTerminata:=not EsisteFaseAssegnazionePreventivaObiettivi or not W022DtM2.Q710.FieldByName('ACCETTAZIONE_OBIETTIVI').IsNull;
  VisualizzazioneAnomala:=(Parametri.S710_SupervisoreValut = 'N') and (W022DtM2.Q710.RecordCount > 0) and (W022DtM2.Q710.FieldByName('TIPO_VALUTAZIONE').AsString <> 'A') and R180InConcat(W022DtM2.Q710.FieldByName('PROGRESSIVO').AsString,W022DtM2.Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString);
  // Pulsanti di testata
  btnModifica.Visible:=not ModificaTestata;
  AbilitaModificaTestata:=(Abilitazione = 'S') and not VisualizzazioneAnomala and btnModifica.Visible and not ModificaDettaglio and not InserisciDettaglio and (W022DtM2.Q710.FieldByName('CHIUSO').AsString = 'N') and ((Parametri.S710_SupervisoreValut = 'S') or (W022DtM2.Q710.FieldByName('MODIFICA_SUBITO').AsString = 'S')) and (VarToStr(W022DtM2.cdsRegole.Lookup('DATA;PROGRESSIVO', VarArrayOf([W022DtM2.DataRif,W022DtM2.Q710.FieldByName('PROGRESSIVO').AsInteger]),'STATO_ABILITATO')) = 'S') and (PeriodoOKCompilazione or (PeriodoOKObiettivi and not FaseAssegnazionePreventivaObiettiviTerminata));
  btnModifica.Enabled:=AbilitaModificaTestata and (Parametri.S710_ValidaStato = 'N');
  btnConferma.Visible:=not btnModifica.Visible;
  btnAnnulla.Visible:=btnConferma.Visible;
  btnStampa.Visible:=btnModifica.Visible;
  btnStampa.Enabled:=btnStampa.Visible and not ModificaDettaglio and not InserisciDettaglio;
  chkLegendaPunteggi.Visible:=btnStampa.Visible;
  chkLegendaPunteggi.Enabled:=btnStampa.Enabled;
  // Dati di testata
  dedtDal.Editable:=ModificaTestata and (Parametri.S710_SupervisoreValut = 'S');
  dedtDal.Css:=StringReplace(dedtDal.Css,IfThen(dedtDal.Editable,'input10','input_data_dmy'),IfThen(dedtDal.Editable,'input_data_dmy','input10'),[rfReplaceAll]);
  (W022DtM2.Q710.FieldByName('DAL') as TDateTimeField).DisplayFormat:=IfThen(dedtDal.Editable,'dd/mm/yyyy','dd/mm');
  dedtAl.Editable:=dedtDal.Editable;
  dedtAl.Css:=dedtDal.Css;
  (W022DtM2.Q710.FieldByName('AL') as TDateTimeField).DisplayFormat:=(W022DtM2.Q710.FieldByName('DAL') as TDateTimeField).DisplayFormat;
  lblPunteggioFinalePesato.Visible:=W022DtM2.selSG730.FieldByName('CALCOLO_PFP').AsString = 'S';
  dedtPunteggioFinalePesato.Visible:=W022DtM2.selSG730.FieldByName('CALCOLO_PFP').AsString = 'S';
  if not lblPunteggioFinalePesato.Visible then
    JQuery.OnReady.Add('$(''#' + 'grpPunteggioFinalePesato' + ''').hide(); ');
  btnRetrocediStato.Visible:=((Parametri.S710_SupervisoreValut = 'S') or (Parametri.S710_ValidaStato = 'S')) and (VarToStr(W022DtM2.selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([W022DtM2.selSG741.FieldByName('CODICE').AsString,W022DtM2.Q710.FieldByName('STATO_AVANZAMENTO').AsInteger - 1]),'CODICE')) <> '') and (W022DtM2.Q710.FieldByName('CHIUSO').AsString <> 'S');
  btnRetrocediStato.Enabled:=btnRetrocediStato.Visible and AbilitaModificaTestata;
  if Parametri.S710_ValidaStato = 'S' then
    btnRetrocediStato.Confirmation:='';
  btnAvanzaStato.Visible:=(VarToStr(W022DtM2.selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([W022DtM2.selSG741.FieldByName('CODICE').AsString,W022DtM2.Q710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1]),'CODICE')) <> '') and not ((sTipoVal3 = 'A') and (VarToStr(W022DtM2.selSG746.Lookup('CREA_AUTOVALUTAZIONE','S','CREA_AUTOVALUTAZIONE')) = 'S'));
  btnAvanzaStato.Enabled:=btnAvanzaStato.Visible and AbilitaModificaTestata;
  chkValutabile.Visible:=Parametri.S710_SupervisoreValut = 'S';
  chkValutabile.Enabled:=ModificaTestata and chkValutabile.Visible;
  chkValutabile.Checked:=W022DtM2.Q710.FieldByName('VALUTABILE').AsString = 'S';
  lblValutatore.Visible:=sTipoVal3 <> 'A';
  cmbValutatore.Visible:=lblValutatore.Visible;
  cmbValutatore.Editable:=(Parametri.S710_ModValutatore = 'S') and ModificaTestata and (sTipoVal3 <> 'A');
  if not lblValutatore.Visible then
    JQuery.OnReady.Add('$(''#' + 'grpValutatore' + ''').hide(); ');
  dedtDataCompilazione.Editable:=ModificaTestata and (W022DtM2.selSG741.FieldByName('AGGIORNA_DATA_COMPILAZIONE').AsString = 'N');
  dedtDataCompilazione.Css:=StringReplace(dedtDataCompilazione.Css,IfThen(dedtDataCompilazione.Editable,'input10','input_data_dmy'),IfThen(dedtDataCompilazione.Editable,'input_data_dmy','input10'),[rfReplaceAll]);
  btnBloccaScheda.Visible:=(W022DtM2.Q710.FieldByName('CHIUSO').AsString = 'N') and (Parametri.S710_SupervisoreValut = 'S');
  btnBloccaScheda.Enabled:=btnBloccaScheda.Visible and btnModifica.Enabled;
  btnSbloccaScheda.Visible:=(W022DtM2.Q710.FieldByName('CHIUSO').AsString = 'B') and (Parametri.S710_SupervisoreValut = 'S');
  btnSbloccaScheda.Enabled:=btnSbloccaScheda.Visible;
  btnChiudiScheda.Visible:=(W022DtM2.Q710.FieldByName('CHIUSO').AsString <> 'S') and not btnAvanzaStato.Visible and (VarToStr(W022DtM2.cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([W022DtM2.DataRif,W022DtM2.Q710.FieldByName('PROGRESSIVO').AsInteger]),'STATO_ABILITATO')) = 'S');
  btnChiudiScheda.Enabled:=btnChiudiScheda.Visible and AbilitaModificaTestata and FaseAssegnazionePreventivaObiettiviTerminata and PeriodoOKCompilazione;
  btnRiapriScheda.Visible:=(W022DtM2.Q710.FieldByName('CHIUSO').AsString = 'S') and (Parametri.S710_SupervisoreValut = 'S') and W022DtM2.Q710.FieldByName('NUMERO_PROTOCOLLO').IsNull and W022DtM2.Q710.FieldByName('ANNO_PROTOCOLLO').IsNull and W022DtM2.Q710.FieldByName('DATA_PROTOCOLLO').IsNull;
  btnRiapriScheda.Enabled:=btnRiapriScheda.Visible;
  // Pagina Valutazione intermedia
  chkEsitoValutazioneIntermediaP.Enabled:=ModificaTestata and (VarToStr(W022DtM2.selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([W022DtM2.selSG741.FieldByName('CODICE').AsString,W022DtM2.Q710.FieldByName('STATO_AVANZAMENTO').AsInteger]),'VAL_INTERM_MODIFICABILE')) = 'S');
  chkEsitoValutazioneIntermediaN.Enabled:=chkEsitoValutazioneIntermediaP.Enabled;
  if not ModificaTestata then
  begin
    chkEsitoValutazioneIntermediaP.Checked:=W022DtM2.Q710.FieldByName('ESITO_VALUTAZIONE_INTERMEDIA').AsString = 'P';
    chkEsitoValutazioneIntermediaN.Checked:=W022DtM2.Q710.FieldByName('ESITO_VALUTAZIONE_INTERMEDIA').AsString = 'N';
  end;
  dmemValutazioneIntermedia.Editable:=chkEsitoValutazioneIntermediaP.Enabled;
  dmemValutazioneIntermedia.Visible:=VarToStr(W022DtM2.selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([W022DtM2.selSG741.FieldByName('CODICE').AsString,W022DtM2.Q710.FieldByName('STATO_AVANZAMENTO').AsInteger]),'VAL_INTERM_MODIFICABILE')) = 'S';
  if not dmemValutazioneIntermedia.Visible then
    JQuery.OnReady.Add('$(''#' + 'grpValutazioneIntermedia' + ''').hide(); ');
  // Pagina Valutazioni complessive
  dmemValutazioniComplessive.Editable:=ModificaTestata;
  // Pagina Obiettivi pianificati (assegnazione consuntiva)
  lblObiettiviPianificati.Visible:=not EsisteFaseAssegnazionePreventivaObiettivi;
  dmemObiettiviPianificati.Visible:=lblObiettiviPianificati.Visible;
  dmemObiettiviPianificati.Editable:=ModificaTestata and (sTipoVal3 <> 'A');
  dmemObiettiviPianificati.Css:='textarea_note' + IfThen(sTipoVal3 = 'A',' bg_grigio');
  // Pagina Obiettivi pianificati (assegnazione preventiva)
  lblAccettazioneObiettivi.Visible:=EsisteFaseAssegnazionePreventivaObiettivi;
  chkAccettazioneObiettiviSi.Visible:=lblAccettazioneObiettivi.Visible;
  chkAccettazioneObiettiviNo.Visible:=lblAccettazioneObiettivi.Visible;
  chkAccettazioneObiettiviSi.Enabled:=ModificaTestata and (sTipoVal3 <> 'A') and PeriodoOKObiettivi and (not FaseAssegnazionePreventivaObiettiviTerminata or (Parametri.S710_SupervisoreValut = 'S'));
  chkAccettazioneObiettiviNo.Enabled:=chkAccettazioneObiettiviSi.Enabled;
  if not ModificaTestata then
  begin
    chkAccettazioneObiettiviSi.Checked:=W022DtM2.Q710.FieldByName('ACCETTAZIONE_OBIETTIVI').AsString = 'S';
    chkAccettazioneObiettiviNo.Checked := W022DtM2.Q710.FieldByName('ACCETTAZIONE_OBIETTIVI').AsString = 'N';
  end;
  lblImportoIncentivo.Visible:=lblAccettazioneObiettivi.Visible;
  dedtImportoIncentivo.Visible:=lblImportoIncentivo.Visible;
  dedtImportoIncentivo.Enabled:=chkAccettazioneObiettiviSi.Enabled and not chkAccettazioneObiettiviSi.Checked and not chkAccettazioneObiettiviNo.Checked;
  lblOrarioNegoziato.Visible:=lblImportoIncentivo.Visible;
  dedtOrarioNegoziato.Visible:=lblImportoIncentivo.Visible;
  dedtOrarioNegoziato.Enabled:=dedtImportoIncentivo.Enabled;
  lblGruppoIncentivi.Visible:=lblAccettazioneObiettivi.Visible;
  grdRiepilogoIncentivi.Visible:=lblGruppoIncentivi.Visible;
  if not lblAccettazioneObiettivi.Visible then
  begin
    JQuery.OnReady.Add('$(''#' + 'grpImportoIncentivo' + ''').hide(); ');
    JQuery.OnReady.Add('$(''#' + 'grpOrarioNegoziato' + ''').hide(); ');
    JQuery.OnReady.Add('$(''#' + 'grpAccettazioneObiettivi' + ''').hide(); ');
  end;
  // Pagina Proposte formative
  dmemProposteFormative.Editable:=dmemValutazioniComplessive.Editable and (sTipoVal3 <> 'A');
  dmemProposteFormative.Css:=dmemObiettiviPianificati.Css;
  lblProposteFormative11.Visible:=W022DtM2.selSG741.FieldByName('ABILITA_AREE_FORMATIVE').AsString = 'S';
  lblProposteFormative12.Visible:=lblProposteFormative11.Visible;
  dcmbProposteFormative1.Visible:=lblProposteFormative11.Visible;
  lblProposteFormative21.Visible:=lblProposteFormative11.Visible;
  lblProposteFormative22.Visible:=lblProposteFormative11.Visible;
  dcmbProposteFormative2.Visible:=lblProposteFormative11.Visible;
  lblProposteFormative31.Visible:=lblProposteFormative11.Visible;
  lblProposteFormative32.Visible:=lblProposteFormative11.Visible;
  dcmbProposteFormative3.Visible:=lblProposteFormative11.Visible;
  dcmbProposteFormative1.Editable:=dmemProposteFormative.Editable;
  dcmbProposteFormative2.Editable:=dcmbProposteFormative1.Editable;
  dcmbProposteFormative3.Editable:=dcmbProposteFormative1.Editable;
  // Pagina Commenti valutato
  lblAccettazioneValutato.Visible:=W022DtM2.selSG741.FieldByName('ABILITA_ACCETTAZIONE_VALUTATO').AsString = 'S';
  chkAccettazioneValutatoSi.Visible:=lblAccettazioneValutato.Visible;
  chkAccettazioneValutatoNo.Visible:=lblAccettazioneValutato.Visible;
  chkAccettazioneValutatoSi.Enabled:=dmemValutazioniComplessive.Editable and FaseAssegnazionePreventivaObiettiviTerminata and (sTipoVal3 <> 'A');
  chkAccettazioneValutatoNo.Enabled:=chkAccettazioneValutatoSi.Enabled;
  if not ModificaTestata then
  begin
    chkAccettazioneValutatoSi.Checked:=W022DtM2.Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString = 'S';
    chkAccettazioneValutatoNo.Checked:=W022DtM2.Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString = 'N';
  end;
  if not lblAccettazioneValutato.Visible then
    JQuery.OnReady.Add('$(''#' + 'grpAccettazioneValutato' + ''').hide(); ');
  dmemCommentiValutato.Visible:=(W022DtM2.selSG741.FieldByName('ABILITA_COMMENTI_VALUTATO').AsString = '1') or ((W022DtM2.selSG741.FieldByName('ABILITA_COMMENTI_VALUTATO').AsString = '3') and (W022DtM2.Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString = 'S')) or ((W022DtM2.selSG741.FieldByName('ABILITA_COMMENTI_VALUTATO').AsString = '4') and (W022DtM2.Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString = 'N'));
  dmemCommentiValutato.Editable:=dmemObiettiviPianificati.Editable;
  dmemCommentiValutato.Css:=dmemObiettiviPianificati.Css;
  lblCommentiValutato.Visible:=dmemCommentiValutato.Visible;
  // Pagina Note
  dmemNote.Editable:=ModificaTestata and ((W022DtM2.selSG741.FieldByName('MODIFICA_NOTE_SUPERVISOREVALUT').AsString = 'N') or (Parametri.S710_SupervisoreValut = 'S'));
  if W022DtM2.Q710.FieldByName('CHIUSO').AsString <> 'S' then
    JQuery.OnReady.Add('$(''#' + 'grpProtocollo' + ''').hide(); ')
  else
  begin
    btnModificaProtocollo.Visible:=not ModificaProtocollo and (W022DtM2.Q710.FieldByName('TIPO_PROTOCOLLO').AsString = 'M') and (Parametri.S710_SupervisoreValut = 'S');
    btnModificaProtocollo.Enabled:=(Abilitazione = 'S') and not VisualizzazioneAnomala and btnModificaProtocollo.Visible;
    btnConfermaProtocollo.Visible:=ModificaProtocollo;
    btnAnnullaProtocollo.Visible:=btnConfermaProtocollo.Visible;
    edtNumeroProtocollo.Editable:=btnConfermaProtocollo.Visible;
    edtAnnoProtocollo.Editable:=edtNumeroProtocollo.Editable;
    edtDataProtocollo.Editable:=edtNumeroProtocollo.Editable;
    edtDataProtocollo.Css:=StringReplace(edtDataProtocollo.Css,IfThen(edtDataProtocollo.Editable,'input10','input_data_dmy'),IfThen(edtDataProtocollo.Editable,'input_data_dmy','input10'),[rfReplaceAll]);
    edtNumeroProtocollo.Text:=IfThen(W022DtM2.Q710.FieldByName('NUMERO_PROTOCOLLO').IsNull,'',IntToStr(W022DtM2.Q710.FieldByName('NUMERO_PROTOCOLLO').AsInteger));
    edtAnnoProtocollo.Text:=IfThen(W022DtM2.Q710.FieldByName('ANNO_PROTOCOLLO').IsNull,'',IntToStr(W022DtM2.Q710.FieldByName('ANNO_PROTOCOLLO').AsInteger));
    edtDataProtocollo.Text:=IfThen(W022DtM2.Q710.FieldByName('DATA_PROTOCOLLO').IsNull,'',FormatDateTime('dd/mm/yyyy',W022DtM2.Q710.FieldByName('DATA_PROTOCOLLO').AsDateTime));
  end;
  // Pulsanti di dettaglio
  btnInserisciDettaglio.Visible:=not ModificaDettaglio and not InserisciDettaglio and (W022DtM2.Q711.RecordCount > 0) and (W022DtM2.ProprietaArea(W022DtM2.Q711.FieldByName('COD_AREA').AsString,W022DtM2.DataRif, 'ITEM_PERSONALIZZATI') = 'S') and (W022DtM2.Q711.FieldByName('ELEMENTI_ABILITATI').AsString = 'S');
  btnInserisciDettaglio.Enabled:=(Abilitazione = 'S') and (Parametri.S710_ValidaStato = 'N') and not VisualizzazioneAnomala and not ModificaTestata and btnInserisciDettaglio.Visible and (W022DtM2.Q710.FieldByName('CHIUSO').AsString = 'N') and ((Parametri.S710_SupervisoreValut = 'S') or (W022DtM2.Q710.FieldByName('MODIFICA_SUBITO').AsString = 'S')) and (VarToStr(W022DtM2.cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([W022DtM2.DataRif,W022DtM2.Q710.FieldByName('PROGRESSIVO').AsInteger]),'STATO_ABILITATO')) = 'S') and ((PeriodoOKObiettivi and not FaseAssegnazionePreventivaObiettiviTerminata) or (PeriodoOKCompilazione and not EsisteFaseAssegnazionePreventivaObiettivi));
  btnModificaDettaglio.Visible:=not ModificaDettaglio and not InserisciDettaglio and (W022DtM2.Q711.RecordCount > 0);
  btnModificaDettaglio.Enabled:=(Abilitazione = 'S') and (Parametri.S710_ValidaStato = 'N') and not VisualizzazioneAnomala and not ModificaTestata and btnModificaDettaglio.Visible and (W022DtM2.Q710.FieldByName('CHIUSO').AsString = 'N') and ((Parametri.S710_SupervisoreValut = 'S') or (W022DtM2.Q710.FieldByName('MODIFICA_SUBITO').AsString = 'S')) and (VarToStr(W022DtM2.cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([W022DtM2.DataRif,W022DtM2.Q710.FieldByName('PROGRESSIVO').AsInteger]),'STATO_ABILITATO')) = 'S') and ((VarToStr(W022DtM2.Q711.Lookup('ELEMENTI_ABILITATI', 'S','ELEMENTI_ABILITATI')) = 'S') or (VarToStr(W022DtM2.Q711.Lookup('PUNTEGGI_ABILITATI', 'S', 'PUNTEGGI_ABILITATI')) = 'S')) and (PeriodoOKCompilazione or (PeriodoOKObiettivi and not FaseAssegnazionePreventivaObiettiviTerminata));
  btnCancellaDettaglio.Visible:=btnInserisciDettaglio.Visible and (W022DtM2.Q711.FieldByName('VALUTAZIONE_ORIGINALE').AsString = 'N');
  btnCancellaDettaglio.Enabled:=btnCancellaDettaglio.Visible and btnInserisciDettaglio.Enabled;
  btnConfermaDettaglio.Visible:=ModificaDettaglio or InserisciDettaglio;
  btnAnnullaDettaglio.Visible:=btnConfermaDettaglio.Visible;
end;

procedure TW022FDettaglioValutazioni.ImpostaTabs;
begin
  tbValutazioni.HasFiller:=False; // Serve ad allineare i tab a destra anche in IE
  tbValutazioni.Tabs[W022ValutazioneIntermediaRG].Visible:=(Pos('P0', W022DtM2.selSG741.FieldByName('PAGINE_ABILITATE').AsString) > 0) and not Fase1StampaDirigenzaConObiettivi;
  tbValutazioni.Tabs[W022ValutazioneIntermediaRG].Caption:=W022DtM2.RecuperaEtichetta('VALUTAZIONE_INTERMEDIA_C');
  tbValutazioni.Tabs[W022ValutazioniComplessiveRG].Visible:=(Pos('P1', W022DtM2.selSG741.FieldByName('PAGINE_ABILITATE').AsString) > 0) and not Fase1StampaDirigenzaConObiettivi;
  tbValutazioni.Tabs[W022ValutazioniComplessiveRG].Caption:=W022DtM2.RecuperaEtichetta('VALUTAZIONI_COMPLESSIVE_C');
  tbValutazioni.Tabs[W022ObiettiviPianificatiRG].Visible:=(sTipoVal3 = 'V') and (Pos('P2', W022DtM2.selSG741.FieldByName('PAGINE_ABILITATE').AsString) > 0);
  tbValutazioni.Tabs[W022ObiettiviPianificatiRG].Caption:=W022DtM2.RecuperaEtichetta('OBIETTIVI_PIANIFICATI_C');
  tbValutazioni.Tabs[W022ProposteFormativeRG].Visible:=(sTipoVal3 = 'V') and (Pos('P3', W022DtM2.selSG741.FieldByName('PAGINE_ABILITATE').AsString) > 0) and not Fase1StampaDirigenzaConObiettivi;
  tbValutazioni.Tabs[W022ProposteFormativeRG].Caption:=W022DtM2.RecuperaEtichetta('PROPOSTE_FORMATIVE_C');
  tbValutazioni.Tabs[W022CommentiValutatoRG].Visible:=(sTipoVal3 = 'V') and (Pos('P4', W022DtM2.selSG741.FieldByName('PAGINE_ABILITATE').AsString) > 0);
  tbValutazioni.Tabs[W022CommentiValutatoRG].Caption:=W022DtM2.RecuperaEtichetta('COMMENTI_VALUTATO_C');
  tbValutazioni.Tabs[W022NoteRG].Visible:=(sTipoVal3 = 'V') and (Pos('P5', W022DtM2.selSG741.FieldByName('PAGINE_ABILITATE').AsString) > 0);
  tbValutazioni.Tabs[W022NoteRG].Caption:=W022DtM2.RecuperaEtichetta('NOTE_C');
end;

procedure TW022FDettaglioValutazioni.ControllaLunghezzaCampo(Caratteri,Totale: Integer; EtichettaCampo: String; Blocca: Boolean; var Msg: String);
begin
  Msg := '';
  if Caratteri > Totale then
  begin
    Msg:='E'' stato superato il limite massimo di caratteri in "' + W022DtM2.RecuperaEtichetta(EtichettaCampo) + '"! (' + IntToStr(Caratteri) + '/' + IntToStr(Totale) + ')';
    if Blocca then
    begin
      GGetWebApplicationThreadVar.ShowMessage(Msg);
      abort;
    end;
  end;
end;

procedure TW022FDettaglioValutazioni.CaricaCampiDescrittivi;
begin
  dmemValutazioneIntermedia.Text:=W022DtM2.Q710.FieldByName('VALUTAZIONE_INTERMEDIA').AsString;
  dmemStoriaValutazioneIntermedia.Text:=W022DtM2.Q710.FieldByName('STORIA_VALUTAZIONE_INTERMEDIA').AsString;
  dmemValutazioniComplessive.Text:=W022DtM2.Q710.FieldByName('VALUTAZIONE_COMPLESSIVE').AsString;
  dmemObiettiviPianificati.Text:=W022DtM2.Q710.FieldByName('OBIETTIVI_AZIONI').AsString;
  dmemProposteFormative.Text:=W022DtM2.Q710.FieldByName('PROPOSTE_FORMATIVE').AsString;
  dmemCommentiValutato.Text:=W022DtM2.Q710.FieldByName('COMMENTI_VALUTATO').AsString;
  dmemNote.Text:=W022DtM2.Q710.FieldByName('NOTE').AsString;
end;

// INIZIO GESTIONE STAMPA

procedure TW022FDettaglioValutazioni.btnStampaClick(Sender: TObject);
begin
  inherited;
  RecuperaTipoStampa;
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
  cdsRiepilogo.Close;
  cdsDettaglio.Close;
end;

procedure TW022FDettaglioValutazioni.RecuperaTipoStampa;
var
  BM: TBookMark;
  EsisteFaseAssegnazionePreventivaObiettivi,PunteggiAssegnati: Boolean;
begin
  with W022DtM2 do
  begin
    EsisteFaseAssegnazionePreventivaObiettivi:=selSG741.FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S';
    PunteggiAssegnati:=False;
    // D711.OnDataChange:=nil;
    BM:=Q711.GetBookMark;
	{ TODO : TEST IW 15 }
	try
      Q711.First;
      while not Q711.Eof do
      begin
        if not Q711.FieldByName('COD_PUNTEGGIO').IsNull or not Q711.FieldByName('PUNTEGGIO').IsNull then
        begin
          PunteggiAssegnati:=True;
          Break;
        end;
        Q711.Next;
      end;
      Q711.GotoBookMark(BM);
	finally
      Q711.FreeBookMark(BM);
	end;
    // D711.OnDataChange:=D711DataChange;
  end;
  Fase1StampaDirigenzaConObiettivi:=EsisteFaseAssegnazionePreventivaObiettivi and not PunteggiAssegnati;
  Fase2StampaDirigenzaConObiettivi:=EsisteFaseAssegnazionePreventivaObiettivi and PunteggiAssegnati;
end;

procedure TW022FDettaglioValutazioni.CreaClientDataset;
begin
  with cdsRiepilogo do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Prog_Valutato',ftString,10,False);
    FieldDefs.Add('Anno_Valutazione',ftString,4,False);
    FieldDefs.Add('Tipo_Valutazione',ftString,15,False);
    FieldDefs.Add('Periodo_Valutazione',ftString,40,False);
    FieldDefs.Add('Matr_Valutato',ftString,8,False);
    FieldDefs.Add('Nom_Valutato',ftString,61,False);
    FieldDefs.Add('Dato1_Valutato',ftString,120,False);
    FieldDefs.Add('Dato2_Valutato',ftString,120,False);
    FieldDefs.Add('Dato3_Valutato',ftString,120,False);
    FieldDefs.Add('Dato4_Valutato',ftString,120,False);
    FieldDefs.Add('Dato5_Valutato',ftString,500,False);
    FieldDefs.Add('Dato6_Valutato',ftString,120,False);
    FieldDefs.Add('Matr_Valutatore',ftString,50,False);
    FieldDefs.Add('Nom_Valutatore',ftString,310,False);
    FieldDefs.Add('Valutazione_Intermedia',ftString,4000,False);
    FieldDefs.Add('Valutazioni_Complessive',ftString,4000,False);
    FieldDefs.Add('Obiettivi_Pianificati',ftString,500,False);
    FieldDefs.Add('Importo_Incentivo',ftString,10,False);
    FieldDefs.Add('Ore_Incentivo',ftString,7,False);
    FieldDefs.Add('Accettazione_Obiettivi',ftString,2,False);
    FieldDefs.Add('Proposte_Formative',ftString,800,False);
    FieldDefs.Add('Commenti_Valutato',ftString,500,False);
    FieldDefs.Add('Note',ftString,500,False);
    FieldDefs.Add('Calcolo_PFP',ftString,1,False);
    FieldDefs.Add('Punteggio_Finale_Pesato',ftString,6,False);
    FieldDefs.Add('NumeroEAnno_Protocollo',ftString,20,False);
    FieldDefs.Add('Data_Protocollo',ftString,20,False);
    FieldDefs.Add('Legenda_Punteggi',ftString,500,False);
    FieldDefs.Add('Accettazione_Valutato',ftString,2,False);
    FieldDefs.Add('Note_Incentivo',ftString,500,False);
    FieldDefs.Add('Firma_1',ftString,50,False);
    FieldDefs.Add('Firma_2',ftString,50,False);
    FieldDefs.Add('Firma_3',ftString,50,False);
    FieldDefs.Add('Firma_4',ftString,50,False);
    FieldDefs.Add('Firma_5',ftString,50,False);
    FieldDefs.Add('Firma_6',ftString,50,False);
    IndexDefs.Clear;
    CreateDataSet;
    LogChanges:=False;
  end;
  with cdsDettaglio do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Prog_Valutato',ftString,10,False);
    FieldDefs.Add('Anno_Valutazione',ftString,4,False);
    FieldDefs.Add('Tipo_Valutazione',ftString,15,False);
    FieldDefs.Add('Cod_Area',ftString,5,False);
    FieldDefs.Add('Desc_Area',ftString,100,False);
    FieldDefs.Add('Perc_Area',ftString,7,False);
    FieldDefs.Add('Punteggio_Area',ftString,7,False);
    FieldDefs.Add('Cod_Valutazione',ftString,5,False);
    FieldDefs.Add('Desc_Valutazione',ftString,1000,False);
    FieldDefs.Add('Perc_Valutazione',ftString,7,False);
    FieldDefs.Add('Soglia_Punteggio',ftString,6,False);
    FieldDefs.Add('Valutabile',ftString,1,False);
    FieldDefs.Add('D_Punteggio',ftString,6,False);
    FieldDefs.Add('Note_Punteggio',ftString,500,False);
    FieldDefs.Add('Punteggio_Pesato',ftString,7,False);
    IndexDefs.Clear;
    CreateDataSet;
    LogChanges:=False;
  end;
end;

procedure TW022FDettaglioValutazioni.CaricaClientDataset;
var
  BM: TBookMark;
  NomeCampo,DatoStampa1,DatoStampa2,DatoStampa3,DatoStampa4,DatoStampa5,DatoStampa6: String;
  DatoValutatoFirma6: String;
  DIni5,DFin5,DIniRap,DFinRap: TDateTime;
  Valore5,Valore5Old: String;
  ProgValutatori: String;
  ProgValutatore: Integer;
  sDal,sAl,sDalAl,sPeriodo: String;
  SchedaProtocollata: Boolean;
  procedure SettaSelSQL(Dato,Valore: String);
  var
    Tabella,Codice,Storico: String;
  begin
    A000GetTabella(Dato,Tabella,Codice,Storico);
    W022DtM2.selSQL.SetVariable('FILTRO',' and ' + Codice + ' = ''' + Valore + '''');
    if W022DtM2.selSQL.VariableIndex('DECORRENZA') >= 0 then
      W022DtM2.selSQL.SetVariable('DECORRENZA',W022DtM2.Q710.FieldByName('AL').AsDateTime);
  end;

begin
  with W022DtM2 do
  begin
    cdsRiepilogo.Append;
    // Dati generici
    cdsRiepilogo.FieldByName('Anno_Valutazione').AsString:=FormatDateTime('yyyy',Q710.FieldByName('DATA').AsDateTime);
    try
      sDalAl:=RecuperaEtichetta('PERIODO_VALUTAZIONE_S');
      while Pos('#',sDalAl) > 0 do
      begin
        sPeriodo:=sPeriodo + Copy(sDalAl,1,Pos('#',sDalAl) - 1);
        sDalAl:=Copy(sDalAl,Pos('#',sDalAl));
        if Pos('#DAL',sDalAl) = 1 then
        begin
          sDal:=Copy(sDalAl,Pos('#DAL',sDalAl) + 4);
          sDal:=Copy(sDal,1,Pos('#',sDal) - 1);
          if sDal = '' then
            sPeriodo:=sPeriodo + FormatDateTime('dd/mm',Q710.FieldByName('DAL').AsDateTime)
          else
            sPeriodo:=sPeriodo + FormatDateTime(sDal,Q710.FieldByName('DAL').AsDateTime);
          sDalAl:=Copy(sDalAl,Pos('#DAL' + sDal + '#',sDalAl) + Length('#DAL' + sDal + '#'));
        end
        else if Pos('#AL',sDalAl) = 1 then
        begin
          sAl:=Copy(sDalAl,Pos('#AL',sDalAl) + 3);
          sAl:=Copy(sAl,1,Pos('#',sAl) - 1);
          if sAl = '' then
            sPeriodo:=sPeriodo + FormatDateTime('dd/mm',Q710.FieldByName('AL').AsDateTime)
          else
            sPeriodo:=sPeriodo + FormatDateTime(sAl,Q710.FieldByName('AL').AsDateTime);
          sDalAl:=Copy(sDalAl,Pos('#AL' + sAl + '#',sDalAl) + Length('#AL' + sAl + '#'));
        end
        else
        begin
          sPeriodo:=sPeriodo + Copy(sDalAl,1,1);
          sDalAl:=Copy(sDalAl,2);
        end;
      end;
      sPeriodo:=sPeriodo + sDalAl;
      cdsRiepilogo.FieldByName('Periodo_Valutazione').AsString:=sPeriodo;
    except
    end;
    cdsRiepilogo.FieldByName('Tipo_Valutazione').AsString:=IfThen(Q710.FieldByName('TIPO_VALUTAZIONE').AsString = 'V','Valutazione','Autovalutazione');
    selStoriaValInterm.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    selStoriaValInterm.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    selStoriaValInterm.SetVariable('TIPO',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    selStoriaValInterm.SetVariable('STATO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1);
    selStoriaValInterm.Execute;
    cdsRiepilogo.FieldByName('Valutazione_Intermedia').AsString:=VarToStr(selStoriaValInterm.Field(0));
    cdsRiepilogo.FieldByName('Valutazioni_Complessive').AsString:=Q710.FieldByName('VALUTAZIONE_COMPLESSIVE').AsString;
    cdsRiepilogo.FieldByName('Importo_Incentivo').AsString:=Trim(R180Formatta(Q710.FieldByName('IMPORTO_INCENTIVO').AsFloat,8,2));
    cdsRiepilogo.FieldByName('Ore_Incentivo').AsString := Q710.FieldByName('ORE_INCENTIVO').AsString;
    cdsRiepilogo.FieldByName('Accettazione_Obiettivi').AsString:=IfThen(Q710.FieldByName('ACCETTAZIONE_OBIETTIVI').AsString = 'N','NO',IfThen(Q710.FieldByName('ACCETTAZIONE_OBIETTIVI').AsString = 'S','SI',''));
    if Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi then
      cdsRiepilogo.FieldByName('Obiettivi_Pianificati').AsString:='Quota annuale retribuzione risultato (#): € ' + cdsRiepilogo.FieldByName('Importo_Incentivo').AsString + '. ' + 'Orario annuale negoziato: h ' + cdsRiepilogo.FieldByName('Ore_Incentivo').AsString + '.' + CRLF + CRLF + 'Accettazione degli obiettivi: ' + cdsRiepilogo.FieldByName ('Accettazione_Obiettivi').AsString
    else
      cdsRiepilogo.FieldByName('Obiettivi_Pianificati').AsString:=Q710.FieldByName('OBIETTIVI_AZIONI').AsString;
    cdsRiepilogo.FieldByName('Proposte_Formative').AsString:=Q710.FieldByName('PROPOSTE_FORMATIVE').AsString;
    if Q710.FieldByName('PROPOSTE_FORMATIVE_3').AsString <> '' then
      cdsRiepilogo.FieldByName('Proposte_Formative').AsString:='SPECIFICA (Valorizzazione e manutenzione delle competenze):    ' + StringReplace(VarToStr(selFormaz.Lookup('CODICE',Q710.FieldByName('PROPOSTE_FORMATIVE_3').AsString,'DESCRIZIONE')),' (specificare)','',[rfReplaceAll]) + CRLF + cdsRiepilogo.FieldByName('Proposte_Formative').AsString;
    if Q710.FieldByName('PROPOSTE_FORMATIVE_2').AsString <> '' then
      cdsRiepilogo.FieldByName('Proposte_Formative').AsString:='ORGANIZZATIVA/GESTIONALE (Competenze trasversali):             ' + StringReplace(VarToStr(selFormaz.Lookup('CODICE',Q710.FieldByName('PROPOSTE_FORMATIVE_2').AsString,'DESCRIZIONE')),' (specificare)','',[rfReplaceAll]) + CRLF + cdsRiepilogo.FieldByName('Proposte_Formative').AsString;
    if Q710.FieldByName('PROPOSTE_FORMATIVE_1').AsString <> '' then
      cdsRiepilogo.FieldByName('Proposte_Formative').AsString:='ETICA DEONTOLOGICA (Competenze comportamentali e relazionali): ' + StringReplace(VarToStr(selFormaz.Lookup('CODICE',Q710.FieldByName('PROPOSTE_FORMATIVE_1').AsString,'DESCRIZIONE')),' (specificare)','',[rfReplaceAll]) + CRLF + cdsRiepilogo.FieldByName('Proposte_Formative').AsString;
    cdsRiepilogo.FieldByName('Proposte_Formative').AsString:=Trim(cdsRiepilogo.FieldByName('Proposte_Formative').AsString);
    cdsRiepilogo.FieldByName('Commenti_Valutato').AsString:=Q710.FieldByName('COMMENTI_VALUTATO').AsString;
    cdsRiepilogo.FieldByName('Note').AsString:=Q710.FieldByName('NOTE').AsString;
    cdsRiepilogo.FieldByName('Calcolo_PFP').AsString:=selSG730.FieldByName('Calcolo_PFP').AsString;
    if (cdsRiepilogo.FieldByName('Calcolo_PFP').AsString = 'S') and not Fase1StampaDirigenzaConObiettivi then
      cdsRiepilogo.FieldByName('Punteggio_Finale_Pesato').AsString:=FloatToStr(Q710.FieldByName('PUNTEGGIO_FINALE_PESATO').AsFloat);
    if Q710.FieldByName('VALUTABILE').AsString = 'N' then
      cdsRiepilogo.FieldByName('Punteggio_Finale_Pesato').AsString:='N.V.';
    SchedaProtocollata := not W022DtM2.Q710.FieldByName('NUMERO_PROTOCOLLO').IsNull or not W022DtM2.Q710.FieldByName('ANNO_PROTOCOLLO').IsNull or not W022DtM2.Q710.FieldByName('DATA_PROTOCOLLO').IsNull;
    if SchedaProtocollata then
    begin
      cdsRiepilogo.FieldByName('NumeroEAnno_Protocollo').AsString:='n. ' + IntToStr(Q710.FieldByName('NUMERO_PROTOCOLLO').AsInteger) + '/' + IntToStr(Q710.FieldByName('ANNO_PROTOCOLLO').AsInteger);
      cdsRiepilogo.FieldByName('Data_Protocollo').AsString:='del ' + FormatDateTime('dd/mm/yyyy',Q710.FieldByName('DATA_PROTOCOLLO').AsDateTime);
    end;
    // Gestisco i caratteri speciali che farebbero andare in errore RaveReport (se non li ho già gestiti nel BeforePost)
    cdsRiepilogo.FieldByName('Valutazione_Intermedia').AsString:=R180SostituisciCaratteriSpeciali(cdsRiepilogo.FieldByName('Valutazione_Intermedia').AsString);
    cdsRiepilogo.FieldByName('Valutazioni_Complessive').AsString:=R180SostituisciCaratteriSpeciali(cdsRiepilogo.FieldByName('Valutazioni_Complessive').AsString);
    cdsRiepilogo.FieldByName('Obiettivi_Pianificati').AsString:=R180SostituisciCaratteriSpeciali(cdsRiepilogo.FieldByName('Obiettivi_Pianificati').AsString);
    cdsRiepilogo.FieldByName('Proposte_Formative').AsString:=R180SostituisciCaratteriSpeciali(cdsRiepilogo.FieldByName('Proposte_Formative').AsString);
    cdsRiepilogo.FieldByName('Commenti_Valutato').AsString:=R180SostituisciCaratteriSpeciali(cdsRiepilogo.FieldByName('Commenti_Valutato').AsString);
    cdsRiepilogo.FieldByName('Note').AsString:=R180SostituisciCaratteriSpeciali(cdsRiepilogo.FieldByName('Note').AsString);
    // Firme
    if Q710.FieldByName('TIPO_VALUTAZIONE').AsString = 'V' then
    begin
      cdsRiepilogo.FieldByName('FIRMA_1').AsString:=RecuperaEtichetta('FIRMA_1_S');
      cdsRiepilogo.FieldByName('FIRMA_2').AsString:=RecuperaEtichetta('FIRMA_2_S');
      cdsRiepilogo.FieldByName('FIRMA_3').AsString:=RecuperaEtichetta('FIRMA_3_S');
      cdsRiepilogo.FieldByName('FIRMA_4').AsString:=RecuperaEtichetta('FIRMA_4_S');
      cdsRiepilogo.FieldByName('FIRMA_5').AsString:=RecuperaEtichetta('FIRMA_5_S');
      cdsRiepilogo.FieldByName('FIRMA_6').AsString:=RecuperaEtichetta('FIRMA_6_S');
    end
    else
      cdsRiepilogo.FieldByName('FIRMA_2').AsString:='IL DIRIGENTE';
    // Dati valutato
    cdsRiepilogo.FieldByName('Prog_Valutato').AsString:=Q710.FieldByName('PROGRESSIVO').AsString;
    R180SetVariable(selT030,'PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    selT030.Open;
    cdsRiepilogo.FieldByName('Matr_Valutato').AsString:=selT030.FieldByName('MATRICOLA').AsString;
    cdsRiepilogo.FieldByName('Nom_Valutato').AsString:=selT030.FieldByName('NOMINATIVO').AsString;
    DatoStampa1:=selSG741.FieldByName('DATO_STAMPA_1').AsString;
    if selSG741.FieldByName('DESC_LUNGA_1').AsString = 'N' then
      DatoStampa2:=selSG741.FieldByName('DATO_STAMPA_2').AsString;
    DatoStampa3:=selSG741.FieldByName('DATO_STAMPA_3').AsString;
    if selSG741.FieldByName('DESC_LUNGA_3').AsString = 'N' then
      DatoStampa4:=selSG741.FieldByName('DATO_STAMPA_4').AsString;
    DatoStampa5:=selSG741.FieldByName('DATO_STAMPA_5').AsString;
    if selSG741.FieldByName('DESC_LUNGA_5').AsString = 'N' then
      DatoStampa6:=selSG741.FieldByName('DATO_STAMPA_6').AsString;
    if Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi then
    begin
      if DatoStampa1 = OpzioneFirma6 then
        DatoStampa1:='';
      if DatoStampa2 = OpzioneFirma6 then
        DatoStampa2:='';
      if DatoStampa3 = OpzioneFirma6 then
        DatoStampa3:='';
      if DatoStampa4 = OpzioneFirma6 then
        DatoStampa4:='';
      if DatoStampa5 = OpzioneFirma6 then
        DatoStampa5:='';
      if DatoStampa6 = OpzioneFirma6 then
        DatoStampa6:='';
    end;
    CampiDaEstrarre := IfThen(CampiDaEstrarre <> '',',' + CampiDaEstrarre + ',',',');
    if Pos(',' + 'T430INIZIO' + ',',',' + CampiDaEstrarre) = 0 then
      CampiDaEstrarre:=CampiDaEstrarre + 'T430INIZIO' + ',';
    if Pos(',' + 'T430FINE' + ',',',' + CampiDaEstrarre) = 0 then
      CampiDaEstrarre:=CampiDaEstrarre + 'T430FINE' + ',';
    if (DatoStampa1 <> '') and (DatoStampa1 <> OpzioneFirma6) and (Pos(',' + DatoStampa1 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + DatoStampa1 + ',';
    if (DatoStampa2 <> '') and (DatoStampa2 <> OpzioneFirma6) and (Pos(',' + DatoStampa2 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + DatoStampa2 + ',';
    if (DatoStampa3 <> '') and (DatoStampa3 <> OpzioneFirma6) and (Pos(',' + DatoStampa3 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + DatoStampa3 + ',';
    if (DatoStampa4 <> '') and (DatoStampa4 <> OpzioneFirma6) and (Pos(',' + DatoStampa4 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + DatoStampa4 + ',';
    if (DatoStampa5 <> '') and (DatoStampa5 <> OpzioneFirma6) and (Pos(',' + DatoStampa5 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + DatoStampa5 + ',';
    if (DatoStampa6 <> '') and (DatoStampa6 <> OpzioneFirma6) and (Pos(',' + DatoStampa6 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + DatoStampa6 + ',';
    if (selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString <> '') and (Pos(',' + selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString + ',';
    CampiDaEstrarre:=Copy(CampiDaEstrarre,2,Length(CampiDaEstrarre) - 2);
    QSGruppoValutatore.GetDatiStorici(CampiDaEstrarre,Q710.FieldByName('PROGRESSIVO').AsInteger,EncodeDate(1900,1,1),EncodeDate(3999,12,31));
    // Prelevo i dati anagrafici da stampare
    if QSGruppoValutatore.LocDatoStorico(Q710.FieldByName('AL').AsDateTime) then
    begin
      DatoValutatoFirma6:=RecuperaEtichetta('FIRMA_6_S') + ': ' + IfThen(cdsRiepilogo.FieldByName('FIRMA_6').AsString = '','NO','SI');
      if DatoStampa1 = OpzioneFirma6 then
        cdsRiepilogo.FieldByName('DATO1_VALUTATO').AsString:=DatoValutatoFirma6
      else if DatoStampa1 <> '' then
      begin
        cdsRiepilogo.FieldByName('DATO1_VALUTATO').AsString:=QSGruppoValutatore.FieldByName(DatoStampa1).AsString;
        NomeCampo:=IfThen(Copy(DatoStampa1,1,4) = 'T430',Copy(DatoStampa1,5),DatoStampa1);
        if A000LookupTabella(NomeCampo, selSQL) then
        begin
          SettaSelSQL(NomeCampo,cdsRiepilogo.FieldByName('DATO1_VALUTATO').AsString);
          try
            selSQL.Open;
            cdsRiepilogo.FieldByName('DATO1_VALUTATO').AsString:=cdsRiepilogo.FieldByName('DATO1_VALUTATO').AsString + '     ' + VarToStr(selSQL.Lookup('CODICE',cdsRiepilogo.FieldByName('DATO1_VALUTATO').AsString,'DESCRIZIONE'));
          except
          end;
          selSQL.Close;
        end;
      end;
      if DatoStampa2 = OpzioneFirma6 then
        cdsRiepilogo.FieldByName('DATO2_VALUTATO').AsString:=DatoValutatoFirma6
      else if DatoStampa2 <> '' then
      begin
        cdsRiepilogo.FieldByName('DATO2_VALUTATO').AsString:=QSGruppoValutatore.FieldByName(DatoStampa2).AsString;
        NomeCampo:=IfThen(Copy(DatoStampa2,1,4) = 'T430',Copy(DatoStampa2,5),DatoStampa2);
        if A000LookupTabella(NomeCampo,selSQL) then
        begin
          SettaSelSQL(NomeCampo,cdsRiepilogo.FieldByName('DATO2_VALUTATO').AsString);
          try
            selSQL.Open;
            cdsRiepilogo.FieldByName('DATO2_VALUTATO').AsString:=cdsRiepilogo.FieldByName('DATO2_VALUTATO').AsString + '     ' + VarToStr(selSQL.Lookup('CODICE',cdsRiepilogo.FieldByName('DATO2_VALUTATO').AsString,'DESCRIZIONE'));
          except
          end;
          selSQL.Close;
        end;
      end;
      if DatoStampa3 = OpzioneFirma6 then
        cdsRiepilogo.FieldByName('DATO3_VALUTATO').AsString:=DatoValutatoFirma6
      else if DatoStampa3 <> '' then
      begin
        cdsRiepilogo.FieldByName('DATO3_VALUTATO').AsString:=QSGruppoValutatore.FieldByName(DatoStampa3).AsString;
        NomeCampo:=IfThen(Copy(DatoStampa3,1,4) = 'T430',Copy(DatoStampa3,5),DatoStampa3);
        if A000LookupTabella(NomeCampo,selSQL) then
        begin
          SettaSelSQL(NomeCampo,cdsRiepilogo.FieldByName('DATO3_VALUTATO').AsString);
          try
            selSQL.Open;
            cdsRiepilogo.FieldByName('DATO3_VALUTATO').AsString:=cdsRiepilogo.FieldByName('DATO3_VALUTATO').AsString + '     ' + VarToStr(selSQL.Lookup('CODICE',cdsRiepilogo.FieldByName('DATO3_VALUTATO').AsString,'DESCRIZIONE'));
          except
          end;
          selSQL.Close;
        end;
      end;
      if DatoStampa4 = OpzioneFirma6 then
        cdsRiepilogo.FieldByName('DATO4_VALUTATO').AsString:=DatoValutatoFirma6
      else if DatoStampa4 <> '' then
      begin
        cdsRiepilogo.FieldByName('DATO4_VALUTATO').AsString:=QSGruppoValutatore.FieldByName(DatoStampa4).AsString;
        NomeCampo:=IfThen(Copy(DatoStampa4,1,4) = 'T430',Copy(DatoStampa4,5),DatoStampa4);
        if A000LookupTabella(NomeCampo,selSQL) then
        begin
          SettaSelSQL(NomeCampo,cdsRiepilogo.FieldByName('DATO4_VALUTATO').AsString);
          try
            selSQL.Open;
            cdsRiepilogo.FieldByName('DATO4_VALUTATO').AsString:=cdsRiepilogo.FieldByName('DATO4_VALUTATO').AsString + '     ' + VarToStr(selSQL.Lookup('CODICE',cdsRiepilogo.FieldByName('DATO4_VALUTATO').AsString,'DESCRIZIONE'));
          except
          end;
          selSQL.Close;
        end;
      end;
      if DatoStampa5 = OpzioneFirma6 then
        cdsRiepilogo.FieldByName('DATO5_VALUTATO').AsString:=DatoValutatoFirma6
      else if DatoStampa5 <> '' then
      begin
        Valore5Old:='#VALORE#INIZIALE#FITTIZIO#';
        while (QSGruppoValutatore.FieldByName('T430DATAFINE').AsDateTime >= Q710.FieldByName('DAL').AsDateTime) and (QSGruppoValutatore.FieldByName('T430DATADECORRENZA').AsDateTime <= Q710.FieldByName('AL').AsDateTime) do
        begin
          Valore5:=QSGruppoValutatore.FieldByName(DatoStampa5).AsString;
          NomeCampo:=IfThen(Copy(DatoStampa5,1,4) = 'T430',Copy(DatoStampa5,5),DatoStampa5);
          if A000LookupTabella(NomeCampo,selSQL) then
          begin
            SettaSelSQL(NomeCampo,Valore5);
            try
              selSQL.Open;
              Valore5:=Valore5 + '     ' + VarToStr(selSQL.Lookup('CODICE',Valore5,'DESCRIZIONE'));
            except
            end;
            selSQL.Close;
          end;
          DIniRap:=IfThen(QSGruppoValutatore.FieldByName('T430INIZIO').IsNull,EncodeDate(1900,1,1),QSGruppoValutatore.FieldByName('T430INIZIO').AsDateTime);
          DFinRap:=IfThen(QSGruppoValutatore.FieldByName('T430FINE').IsNull,EncodeDate(3999,12,31),QSGruppoValutatore.FieldByName('T430FINE').AsDateTime);
          DIni5:=Max(Q710.FieldByName('DAL').AsDateTime,Max(QSGruppoValutatore.FieldByName('T430DATADECORRENZA').AsDateTime,DIniRap));
          DFin5:=Min(Q710.FieldByName('AL').AsDateTime,Min(QSGruppoValutatore.FieldByName('T430DATAFINE').AsDateTime,DFinRap));
          if Valore5 <> Valore5Old then
          begin
            Valore5Old:=Valore5;
            cdsRiepilogo.FieldByName('DATO5_VALUTATO').AsString:=Copy(IfThen(selSG741.FieldByName('STAMPA_VARIAZIONI_5').AsString = 'S','(' + FormatDateTime('dd/mm',DIni5) + '-' + FormatDateTime('dd/mm',DFin5) + ') ') + Valore5,1,118) + IfThen(cdsRiepilogo.FieldByName('DATO5_VALUTATO').AsString <> '',CRLF) + cdsRiepilogo.FieldByName('DATO5_VALUTATO').AsString;
          end
          else
            cdsRiepilogo.FieldByName('DATO5_VALUTATO').AsString:='(' + FormatDateTime('dd/mm',DIni5) + Copy(cdsRiepilogo.FieldByName('DATO5_VALUTATO').AsString,7);
          // Esco dal ciclo se non devo stampare le variazioni, altrimenti passo alla decorrenza precedente
          if (selSG741.FieldByName('STAMPA_VARIAZIONI_5').AsString = 'N') or (QSGruppoValutatore.RecNo = 1) then
            Break
          else
            QSGruppoValutatore.Prior;
        end;
        QSGruppoValutatore.LocDatoStorico(Q710.FieldByName('AL').AsDateTime);
      end;
      if DatoStampa6 = OpzioneFirma6 then
        cdsRiepilogo.FieldByName('DATO6_VALUTATO').AsString:=DatoValutatoFirma6
      else if DatoStampa6 <> '' then
      begin
        cdsRiepilogo.FieldByName('DATO6_VALUTATO').AsString:=QSGruppoValutatore.FieldByName(DatoStampa6).AsString;
        NomeCampo:=IfThen(Copy(DatoStampa6,1,4) = 'T430',Copy(DatoStampa6,5),DatoStampa6);
        if A000LookupTabella(NomeCampo,selSQL) then
        begin
          SettaSelSQL(NomeCampo,cdsRiepilogo.FieldByName('DATO6_VALUTATO').AsString);
          try
            selSQL.Open;
            cdsRiepilogo.FieldByName('DATO6_VALUTATO').AsString:=cdsRiepilogo.FieldByName('DATO6_VALUTATO').AsString + '     ' + VarToStr(selSQL.Lookup('CODICE',cdsRiepilogo.FieldByName('DATO6_VALUTATO').AsString,'DESCRIZIONE'));
          except
          end;
          selSQL.Close;
        end;
      end;
    end;
    // Dati valutatori
    NValutatori:=0;
    ProgValutatori:=Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString + ',';
    while Pos(',',ProgValutatori) > 0 do
    begin
      inc(NValutatori);
      ProgValutatore:=StrToIntDef(Copy(ProgValutatori,1,Pos(',',ProgValutatori) - 1),-1);
      R180SetVariable(selT030,'PROGRESSIVO',ProgValutatore);
      selT030.Open;
      cdsRiepilogo.FieldByName('Matr_Valutatore').AsString:=cdsRiepilogo.FieldByName('Matr_Valutatore').AsString + IfThen(NValutatori > 1,CRLF) + selT030.FieldByName('MATRICOLA').AsString;
      cdsRiepilogo.FieldByName('Nom_Valutatore').AsString:=cdsRiepilogo.FieldByName('Nom_Valutatore').AsString + IfThen(NValutatori > 1,CRLF) + selT030.FieldByName('NOMINATIVO').AsString;
      ProgValutatori:=Copy(ProgValutatori,Pos(',',ProgValutatori) + 1);
    end;
    // Legenda punteggi di valutazione
    cdsRiepilogo.FieldByName('LEGENDA_PUNTEGGI').AsString:=RecuperaLegendaPunteggi;
    cdsRiepilogo.FieldByName('ACCETTAZIONE_VALUTATO').AsString:=IfThen(Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString = 'N','NO','SI');
    if Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi then
      cdsRiepilogo.FieldByName('NOTE_INCENTIVO').AsString:='(#) L''ammontare definitivo è subordinato a:' + CRLF +
                                                           '    - livello di raggiungimento degli obiettivi affidati alla Struttura anche in rapporto alle altre;' + CRLF +
                                                           '    - livello di raggiungimento degli obiettivi individuali prestazionali, qualitativi e comportamentali;' + CRLF +
                                                           '    - modifica in corso d''anno della dotazione organica del personale dirigente della Struttura;' + CRLF +
                                                           '    - rispetto dell''orario negoziato;' + CRLF +
                                                           '    - presenza effettiva nel periodo di riferimento.';
    cdsRiepilogo.Post;

    // D711.OnDataChange:=nil;
    BM:=Q711.GetBookMark;
    try
      Q711.First;
	  { TODO : TEST IW 15 }
      while not Q711.Eof do
      begin
        cdsDettaglio.Append;
        cdsDettaglio.FieldByName('Prog_Valutato').AsString:=Q710.FieldByName('PROGRESSIVO').AsString;
        cdsDettaglio.FieldByName('Anno_Valutazione').AsString:=FormatDateTime('yyyy',Q710.FieldByName('DATA').AsDateTime);
        cdsDettaglio.FieldByName('Tipo_Valutazione').AsString:=IfThen(Q710.FieldByName('TIPO_VALUTAZIONE').AsString = 'V','Valutazione','Autovalutazione');
        cdsDettaglio.FieldByName('Cod_Area').AsString:=Q711.FieldByName('COD_AREA').AsString;
        cdsDettaglio.FieldByName('Desc_Area').AsString:=Q711.FieldByName('D_AREA').AsString;
        cdsDettaglio.FieldByName('Perc_Area').AsString:=FloatToStr(Q711.FieldByName('CF_PERC_AREA').AsFloat);
        cdsDettaglio.FieldByName('Punteggio_Area').AsString:=FloatToStr(Q711.FieldByName('CF_PUNTEGGIO_AREA').AsFloat);
        cdsDettaglio.FieldByName('Cod_Valutazione').AsString:=Q711.FieldByName('COD_VALUTAZIONE').AsString;
        cdsDettaglio.FieldByName('Desc_Valutazione').AsString:=Q711.FieldByName('D_VALUTAZIONE').AsString + (IfThen(not Q711.FieldByName('DESC_VALUTAZIONE_AGG').IsNull and (RecuperaEtichetta('ITEM_PERSONALIZZATO_S') <> ''),' (*)'));
        if Q711.FieldByName('CF_PERC_VALUTAZIONE').AsFloat <> 0 then
          cdsDettaglio.FieldByName('Perc_Valutazione').AsString:=FloatToStr(Q711.FieldByName('CF_PERC_VALUTAZIONE').AsFloat);
        cdsDettaglio.FieldByName('Soglia_Punteggio').AsString:=Q711.FieldByName('SOGLIA_PUNTEGGIO').AsString;
        cdsDettaglio.FieldByName('Valutabile').AsString:=Q711.FieldByName('VALUTABILE').AsString;
        cdsDettaglio.FieldByName('D_Punteggio').AsString:=Q711.FieldByName('D_PUNTEGGIO').AsString;
        cdsDettaglio.FieldByName('Note_Punteggio').AsString:=Q711.FieldByName('NOTE_PUNTEGGIO').AsString;
        if Q711.FieldByName('CF_PUNTEGGIO_PESATO').AsFloat <> 0 then
          cdsDettaglio.FieldByName('Punteggio_Pesato').AsString:=FloatToStr(Q711.FieldByName('CF_PUNTEGGIO_PESATO').AsFloat);
        // Gestisco i caratteri speciali che farebbero andare in errore RaveReport (se non li ho già gestiti in fase di conferma del dettaglio)
        cdsDettaglio.FieldByName('Desc_Valutazione').AsString:=R180SostituisciCaratteriSpeciali(cdsDettaglio.FieldByName('Desc_Valutazione').AsString);
        cdsDettaglio.FieldByName('Note_Punteggio').AsString:=R180SostituisciCaratteriSpeciali(cdsDettaglio.FieldByName('Note_Punteggio').AsString);
        cdsDettaglio.Post;
        Q711.Next;
      end;
      Q711.GotoBookMark(BM);
	finally
      Q711.FreeBookMark(BM);
	end;
    // D711.OnDataChange:=D711DataChange;
  end;
end;

function TW022FDettaglioValutazioni.RecuperaLegendaPunteggi: String;
var
  lstLegendaPunteggi: TStringList;
begin
  Result:='';
  lstLegendaPunteggi:=TStringList.Create;
  with W022DtM2.selSG730 do
  begin
    lstLegendaPunteggi.Clear;
    First;
    if FieldByName('CALCOLO_PFP').AsString = 'S' then
      lstLegendaPunteggi.Add('Codice  Valore Descrizione')
    else
      lstLegendaPunteggi.Add('Codice  Descrizione');
    while not Eof do
    begin
      if FieldByName('CALCOLO_PFP').AsString = 'S' then
        lstLegendaPunteggi.Add(Format('%-5s = %6.6s %s',[FieldByName('CODICE').AsString,FormatFloat('##0.00',FieldByName('PUNTEGGIO').AsFloat),FieldByName('DESCRIZIONE').AsString]))
      else
        lstLegendaPunteggi.Add(Format('%-5s = %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
  Result:=lstLegendaPunteggi.Text;
  FreeAndNil(lstLegendaPunteggi);
end;

procedure TW022FDettaglioValutazioni.EsecuzioneStampa;
var
  rvComp: TRaveComponent;
  L: TStringList;
  TitoloDatoStampa1,TitoloDatoStampa2,TitoloDatoStampa3,TitoloDatoStampa4,TitoloDatoStampa5,TitoloDatoStampa6: String;
  dconnRiepilogo,dconnDettaglio,dconnNote: TRaveDataConnection;
  ODS: TOracleDataSet;
  F,ImgTop,ImgAlt,AltezzaAggiuntiva,AltezzaMancante,LarghezzaColonna,LarghezzaMancante: Extended;
  NVariazioni: Integer;
  Firma4: Boolean;
  StampaAreaPerc,StampaAreaPunteggio,StampaItemValutabile,StampaItemPerc,StampaItemSoglia,StampaItemPunteggio,StampaItemPunteggioPesato{,StampaColNotePunteggio}: Boolean;
begin
  try
    StampaAreaPerc:=R180InConcat('1',W022DtM2.selSG741.FieldByName('CAMPI_OPZIONALI_STAMPA').AsString);
    StampaAreaPunteggio:=R180InConcat('2',W022DtM2.selSG741.FieldByName('CAMPI_OPZIONALI_STAMPA').AsString);
    StampaItemValutabile:=W022DtM2.VisColItemValutabile;
    StampaItemPerc:=R180InConcat('3',W022DtM2.selSG741.FieldByName('CAMPI_OPZIONALI_STAMPA').AsString);
    StampaItemSoglia:=W022DtM2.VisColSogliaPunteggio;
    StampaItemPunteggio:=True;
    StampaItemPunteggioPesato:=R180InConcat('4',W022DtM2.selSG741.FieldByName('CAMPI_OPZIONALI_STAMPA').AsString);
    // StampaColNotePunteggio:=W022DtM2.VisColNotePunteggio; // inutilizzato!
    NomeFile:='';
    CSStampa.Enter;
    rvSystem:=TRVSystem.Create(Self);
    rvProject:=TRVProject.Create(Self);
    connRiepilogo:=TRVDataSetConnection.Create(Self);
    connDettaglio:=TRVDataSetConnection.Create(Self);
    rvRenderPDF:=TRvRenderPDF.Create(Self);
    L:=TStringList.Create;
    try
      rvProject.Engine:=rvSystem;
      rvRenderPDF.Active:=True;
      rvProject.ProjectFile:=gServerCOntroller.ContentPath + 'report\W022StampaValutazioni.rav';
      connRiepilogo.Name:='connRiepilogo';
      connRiepilogo.DataSet:=cdsRiepilogo;
      connRiepilogo.RuntimeVisibility:=RpCon.rtNone;
      connDettaglio.Name:='connDettaglio';
      connDettaglio.DataSet:=cdsDettaglio;
      connDettaglio.RuntimeVisibility:=RpCon.rtNone;
      rvProject.Open;
      rvProject.GetReportList(L,True);
      rvProject.SelectReport(L[0],True);
      rvDWRiepilogo:=(rvProject.ProjMan.FindRaveComponent('dwRiepilogo',nil) as TRaveDataView);
      rvDWDettaglio:=(rvProject.ProjMan.FindRaveComponent('dwDettaglio',nil) as TRaveDataView);
      // Impostazioni dei campi di Riepilogo
      dconnRiepilogo:=CreateDataCon(connRiepilogo);
      rvDWRiepilogo.ConnectionName:=dconnRiepilogo.Name;
      rvDWRiepilogo.DataCon:=dconnRiepilogo;
      CreateFields(rvDWRiepilogo,nil,nil,True);
      // Impostazioni dei campi di Dettaglio
      dconnDettaglio:=CreateDataCon(connDettaglio);
      rvDWDettaglio.ConnectionName:=dconnDettaglio.Name;
      rvDWDettaglio.DataCon:=dconnDettaglio;
      CreateFields(rvDWDettaglio,nil,nil,True);
      rvPage:=rvProject.ProjMan.FindRaveComponent('W022.Page',nil);
      // Impostazioni della banda bndTitolo
      rvComp:=rvProject.ProjMan.FindRaveComponent('lblAzienda',rvPage);
      (rvComp as TRaveText).Text:=Parametri.RagioneSociale;
      rvComp:=rvProject.ProjMan.FindRaveComponent('lblTitolo',rvPage);
      (rvComp as TRaveText).Text:='Scheda di ' + IfThen(W022DtM2.Q710.FieldByName('TIPO_VALUTAZIONE').AsString = 'A','Autovalutazione','Valutazione') + ' del ' + FormatDateTime('dd/mm/yyyy',W022DtM2.Q710.FieldByName('DATA_COMPILAZIONE').AsDateTime);
      rvComp:=rvProject.ProjMan.FindRaveComponent('lblStato',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.Q710.FieldByName('STATO_SCHEDA').AsString;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloProtocollo',rvPage);
      (rvComp as TRaveText).Visible:=Trim(cdsRiepilogo.FieldByName('NumeroEAnno_Protocollo').AsString) <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblNumeroEAnnoProtocollo',rvPage);
      (rvComp as TRaveDataText).Visible:=Trim(cdsRiepilogo.FieldByName('NumeroEAnno_Protocollo').AsString) <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblDataProtocollo',rvPage);
      (rvComp as TRaveDataText).Visible:=Trim(cdsRiepilogo.FieldByName('NumeroEAnno_Protocollo').AsString) <> '';
      // Impostazione logo
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
            (rvComp as TRaveBitmap).Width:=W022DtM2.selSG741.FieldByName('LOGO_LARGHEZZA').AsInteger * F;
            (rvComp as TRaveBitmap).Height:=W022DtM2.selSG741.FieldByName('LOGO_ALTEZZA').AsInteger * F;
            ImgTop:=(rvComp as TRaveBitmap).Top;
            ImgAlt:=(rvComp as TRaveBitmap).Height;
            rvComp:=rvProject.ProjMan.FindRaveComponent('bndTitolo',rvPage);
            (rvComp as TRaveContainerControl).Height:=Max((rvComp as TRaveContainerControl).Height,ImgTop + ImgAlt);
          end;
          ODS.Close;
        finally
          FreeAndNil(ODS);
        end;
      except
      end;
      // Impostazione anno e periodo valutazione
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloAnnoValutazione',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('ANNO_VALUTAZIONE_S','U');
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblPeriodoValutazione',rvPage);
      (rvComp as TRaveDataText).Visible:=W022DtM2.selSG741.FieldByName('STAMPA_PERIODO_VALUTAZIONE').AsString = 'S';
      // Impostazione valutato e valutatore
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloMatrValutato',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('VALUTATO_S','U');
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloMatrValutatore',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('VALUTATORE_S','U');
      // Impostazione punteggio finale pesato
      if (cdsRiepilogo.FieldByName('CALCOLO_PFP').AsString = 'S') and not (Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi) then
      begin
        rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle4',rvPage);
        (rvComp as TRaveRectangle).Visible:=True;
        rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloPunteggioFinalePesato',rvPage);
        (rvComp as TRaveText).Visible:=True;
        (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('PUNTEGGIO_FINALE_SCHEDA_S','U');
        rvComp:=rvProject.ProjMan.FindRaveComponent('dlblPunteggioFinalePesato',rvPage);
        (rvComp as TRaveDataText).Visible:=True;
        rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle6',rvPage);
        (rvComp as TRaveRectangle).Width:=4.26;
        rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle7',rvPage);
        (rvComp as TRaveRectangle).Width:=4.26;
      end
      else
      begin
        rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle4',rvPage);
        (rvComp as TRaveRectangle).Visible:=False;
        rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloPunteggioFinalePesato',rvPage);
        (rvComp as TRaveText).Visible:=False;
        rvComp:=rvProject.ProjMan.FindRaveComponent('dlblPunteggioFinalePesato',rvPage);
        (rvComp as TRaveDataText).Visible:=False;
        rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle6',rvPage);
        (rvComp as TRaveRectangle).Width:=6.16;
        rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle7',rvPage);
        (rvComp as TRaveRectangle).Width:=6.16;
      end;
      // Impostazione dei titoletti in testata
      TitoloDatoStampa1:=VarToStr(W022DtM2.selI010.Lookup('NOME_CAMPO',W022DtM2.selSG741.FieldByName('DATO_STAMPA_1').AsString,'NOME_LOGICO'));
      if W022DtM2.selSG741.FieldByName('DESC_LUNGA_1').AsString = 'N' then
        TitoloDatoStampa2:=VarToStr(W022DtM2.selI010.Lookup('NOME_CAMPO',W022DtM2.selSG741.FieldByName('DATO_STAMPA_2').AsString,'NOME_LOGICO'));
      TitoloDatoStampa3:=VarToStr(W022DtM2.selI010.Lookup('NOME_CAMPO',W022DtM2.selSG741.FieldByName('DATO_STAMPA_3').AsString,'NOME_LOGICO'));
      if W022DtM2.selSG741.FieldByName('DESC_LUNGA_3').AsString = 'N' then
        TitoloDatoStampa4:=VarToStr(W022DtM2.selI010.Lookup('NOME_CAMPO',W022DtM2.selSG741.FieldByName('DATO_STAMPA_4').AsString,'NOME_LOGICO'));
      TitoloDatoStampa5:=VarToStr(W022DtM2.selI010.Lookup('NOME_CAMPO',W022DtM2.selSG741.FieldByName('DATO_STAMPA_5').AsString,'NOME_LOGICO'));
      if W022DtM2.selSG741.FieldByName('DESC_LUNGA_5').AsString = 'N' then
        TitoloDatoStampa6:=VarToStr(W022DtM2.selI010.Lookup('NOME_CAMPO',W022DtM2.selSG741.FieldByName('DATO_STAMPA_6').AsString,'NOME_LOGICO'));
      TitoloDatoStampa1:=StringReplace(TitoloDatoStampa1,OpzioneFirma6,IfThen(Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi,'',W022DtM2.RecuperaEtichetta('FIRMA_6_S')),[rfReplaceAll]);
      TitoloDatoStampa2:=StringReplace(TitoloDatoStampa2,OpzioneFirma6,IfThen(Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi,'',W022DtM2.RecuperaEtichetta('FIRMA_6_S')),[rfReplaceAll]);
      TitoloDatoStampa3:=StringReplace(TitoloDatoStampa3,OpzioneFirma6,IfThen(Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi,'',W022DtM2.RecuperaEtichetta('FIRMA_6_S')),[rfReplaceAll]);
      TitoloDatoStampa4:=StringReplace(TitoloDatoStampa4,OpzioneFirma6,IfThen(Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi,'',W022DtM2.RecuperaEtichetta('FIRMA_6_S')),[rfReplaceAll]);
      TitoloDatoStampa5:=StringReplace(TitoloDatoStampa5,OpzioneFirma6,IfThen(Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi,'',W022DtM2.RecuperaEtichetta('FIRMA_6_S')),[rfReplaceAll]);
      TitoloDatoStampa6:=StringReplace(TitoloDatoStampa6,OpzioneFirma6,IfThen(Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi,'',W022DtM2.RecuperaEtichetta('FIRMA_6_S')),[rfReplaceAll]);
      if (TitoloDatoStampa1 <> '') and (W022DtM2.RecuperaEtichetta('DATO_STAMPA_1_S') <> '') then
        TitoloDatoStampa1:=W022DtM2.RecuperaEtichetta('DATO_STAMPA_1_S');
      if (TitoloDatoStampa2 <> '') and (W022DtM2.RecuperaEtichetta('DATO_STAMPA_2_S') <> '') then
        TitoloDatoStampa2:=W022DtM2.RecuperaEtichetta('DATO_STAMPA_2_S');
      if (TitoloDatoStampa3 <> '') and (W022DtM2.RecuperaEtichetta('DATO_STAMPA_3_S') <> '') then
        TitoloDatoStampa3:=W022DtM2.RecuperaEtichetta('DATO_STAMPA_3_S');
      if (TitoloDatoStampa4 <> '') and (W022DtM2.RecuperaEtichetta('DATO_STAMPA_4_S') <> '') then
        TitoloDatoStampa4:=W022DtM2.RecuperaEtichetta('DATO_STAMPA_4_S');
      if (TitoloDatoStampa5 <> '') and (W022DtM2.RecuperaEtichetta('DATO_STAMPA_5_S') <> '') then
        TitoloDatoStampa5:=W022DtM2.RecuperaEtichetta('DATO_STAMPA_5_S');
      if (TitoloDatoStampa6 <> '') and (W022DtM2.RecuperaEtichetta('DATO_STAMPA_6_S') <> '') then
        TitoloDatoStampa6:=W022DtM2.RecuperaEtichetta('DATO_STAMPA_6_S');
      // Imposto l'altezza della banda di testata e i titoletti dei dati anagrafici del valutato
      rvComp:=rvProject.ProjMan.FindRaveComponent('bndDatiValutato',rvPage);
      (rvComp as TRaveContainerControl).Height:=0.870;
      if (TitoloDatoStampa6 = '') and (TitoloDatoStampa5 = '') then
      begin
        (rvComp as TRaveContainerControl).Height:=0.580;
        if (TitoloDatoStampa4 = '') and (TitoloDatoStampa3 = '') then
        begin
          (rvComp as TRaveContainerControl).Height:=0.290;
          if (TitoloDatoStampa2 = '') and (TitoloDatoStampa1 = '') then
            (rvComp as TRaveContainerControl).Height:=0;
        end;
      end;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloDato1Valutato',rvPage);
      (rvComp as TRaveText).Text:=TitoloDatoStampa1;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloDato2Valutato',rvPage);
      (rvComp as TRaveText).Text:=TitoloDatoStampa2;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloDato3Valutato',rvPage);
      (rvComp as TRaveText).Text:=TitoloDatoStampa3;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloDato4Valutato',rvPage);
      (rvComp as TRaveText).Text:=TitoloDatoStampa4;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloDato5Valutato',rvPage);
      (rvComp as TRaveText).Text:=TitoloDatoStampa5;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloDato6Valutato',rvPage);
      (rvComp as TRaveText).Text:=TitoloDatoStampa6;
      with W022DtM2.selSG741 do
      begin
        // descrizione lunga primo dato
        rvComp:=rvProject.ProjMan.FindRaveComponent('dlblDato1Valutato',rvPage);
        (rvComp as TRaveDataText).Width:=IfThen(FieldByName('DESC_LUNGA_1').AsString = 'N',3.95,7.90);
        rvComp:=rvProject.ProjMan.FindRaveComponent('shpDato1',rvPage);
        (rvComp as TRaveRectangle).Width:=IfThen(FieldByName('DESC_LUNGA_1').AsString = 'N',4.03,8.06);
        if (TitoloDatoStampa1 = '') and (TitoloDatoStampa2 = '') and (TitoloDatoStampa3 = '') and (TitoloDatoStampa4 = '') and (TitoloDatoStampa5 = '') and (TitoloDatoStampa6 = '') then
          (rvComp as TRaveRectangle).BorderWidth:=1;
        rvComp:=rvProject.ProjMan.FindRaveComponent('shpDato2',rvPage);
        (rvComp as TRaveRectangle).Visible:=FieldByName('DESC_LUNGA_1').AsString = 'N';
        if (TitoloDatoStampa1 = '') and (TitoloDatoStampa2 = '') and (TitoloDatoStampa3 = '') and (TitoloDatoStampa4 = '') and (TitoloDatoStampa5 = '') and (TitoloDatoStampa6 = '') then
          (rvComp as TRaveRectangle).BorderWidth:=1;
        rvComp:=rvProject.ProjMan.FindRaveComponent('dlblDato2Valutato',rvPage);
        (rvComp as TRaveDataText).Visible:=FieldByName('DESC_LUNGA_1').AsString = 'N';
        // descrizione lunga terzo dato
        rvComp:=rvProject.ProjMan.FindRaveComponent('dlblDato3Valutato',rvPage);
        (rvComp as TRaveDataText).Width:=IfThen(FieldByName('DESC_LUNGA_3').AsString = 'N',3.95,7.90);
        rvComp:=rvProject.ProjMan.FindRaveComponent('shpDato3',rvPage);
        (rvComp as TRaveRectangle).Width:=IfThen(FieldByName('DESC_LUNGA_3').AsString = 'N',4.03,8.06);
        if (TitoloDatoStampa3 = '') and (TitoloDatoStampa4 = '') and (TitoloDatoStampa5 = '') and (TitoloDatoStampa6 = '') then
          (rvComp as TRaveRectangle).BorderWidth:=1;
        rvComp:=rvProject.ProjMan.FindRaveComponent('shpDato4',rvPage);
        (rvComp as TRaveRectangle).Visible:=FieldByName('DESC_LUNGA_3').AsString = 'N';
        if (TitoloDatoStampa3 = '') and (TitoloDatoStampa4 = '') and (TitoloDatoStampa5 = '') and (TitoloDatoStampa6 = '') then
          (rvComp as TRaveRectangle).BorderWidth:=1;
        rvComp:=rvProject.ProjMan.FindRaveComponent('dlblDato4Valutato',rvPage);
        (rvComp as TRaveDataText).Visible:=FieldByName('DESC_LUNGA_3').AsString = 'N';
        // descrizione lunga quinto dato
        rvComp:=rvProject.ProjMan.FindRaveComponent('dlblDato5Valutato',rvPage);
        (rvComp as TRaveDataMemo).Width:=IfThen(FieldByName('DESC_LUNGA_5').AsString = 'N',3.95,7.90);
        rvComp:=rvProject.ProjMan.FindRaveComponent('shpDato5',rvPage);
        (rvComp as TRaveRectangle).Width:=IfThen(FieldByName('DESC_LUNGA_5').AsString = 'N',4.03,8.06);
        if (TitoloDatoStampa5 = '') and (TitoloDatoStampa6 = '') then
          (rvComp as TRaveRectangle).BorderWidth:=1;
        rvComp:=rvProject.ProjMan.FindRaveComponent('shpDato6',rvPage);
        (rvComp as TRaveRectangle).Visible:=FieldByName('DESC_LUNGA_5').AsString = 'N';
        if (TitoloDatoStampa5 = '') and (TitoloDatoStampa6 = '') then
          (rvComp as TRaveRectangle).BorderWidth:=1;
        rvComp:=rvProject.ProjMan.FindRaveComponent('dlblDato6Valutato',rvPage);
        (rvComp as TRaveDataText).Visible:=FieldByName('DESC_LUNGA_5').AsString = 'N';
      end;
      // Posizionamento dei dati di testata in base al numero di valutatori
      if NValutatori > 1 then
      begin
        AltezzaAggiuntiva:=((NValutatori - 1) * 0.15);
        rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle1',rvPage);
        (rvComp as TRaveRectangle).Height:=(rvComp as TRaveRectangle).Height + AltezzaAggiuntiva;
        rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle6',rvPage);
        (rvComp as TRaveRectangle).Height:=(rvComp as TRaveRectangle).Height + AltezzaAggiuntiva;
        rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle4',rvPage);
        (rvComp as TRaveRectangle).Height:=(rvComp as TRaveRectangle).Height + AltezzaAggiuntiva;
      end;
      // Impostazione del dettaglio
      // Punteggio area
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloPunteggioArea',rvPage);
      (rvComp as TRaveText).Visible:=StampaAreaPunteggio;
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('PUNTEGGIO_AREA_S','U');
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblPunteggioArea',rvPage);
      (rvComp as TRaveDataText).Visible:=StampaAreaPunteggio;
      rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle5',rvPage);
      (rvComp as TRaveRectangle).Visible:=StampaAreaPunteggio;
      LarghezzaColonna:=(rvComp as TRaveRectangle).Width;
      LarghezzaMancante:=0;
      // Percentuale area
      if not StampaAreaPunteggio then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloPercArea',rvPage);
      (rvComp as TRaveText).Visible:=StampaAreaPerc;
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('PESO_AREA_S','U');
      (rvComp as TRaveText).Left:=(rvComp as TRaveText).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblPercArea',rvPage);
      (rvComp as TRaveDataText).Visible:=StampaAreaPerc;
      (rvComp as TRaveDataText).Left:=(rvComp as TRaveDataText).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle20',rvPage);
      (rvComp as TRaveRectangle).Visible:=StampaAreaPerc;
      (rvComp as TRaveRectangle).Left:=(rvComp as TRaveRectangle).Left + LarghezzaMancante;
      // Descrizione area
      if not StampaAreaPerc then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloDescArea',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('DESCRIZIONE_AREA_S','U');
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblDescArea',rvPage);
      (rvComp as TRaveDataText).Width:=(rvComp as TRaveDataText).Width + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle18',rvPage);
      (rvComp as TRaveRectangle).Width:=(rvComp as TRaveRectangle).Width + LarghezzaMancante;
      // Codice area
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloCodArea',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('CODICE_AREA_S','U');
      // Punteggio pesato elemento
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloPunteggioPesato',rvPage);
      (rvComp as TRaveText).Visible:=StampaItemPunteggioPesato;
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('PUNTEGGIO_PESATO_ITEM_S','U');
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblPunteggioPesato',rvPage);
      (rvComp as TRaveDataText).Visible:=StampaItemPunteggioPesato;
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnTitoloPunteggioPesato',rvPage);
      (rvComp as TRaveVLine).Visible:=StampaItemPunteggioPesato;
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnPunteggioPesato',rvPage);
      (rvComp as TRaveVLine).Visible:=StampaItemPunteggioPesato;
      LarghezzaMancante:=0;
      // Punteggio elemento
      if not StampaItemPunteggioPesato then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloPunteggio',rvPage);
      (rvComp as TRaveText).Visible:=StampaItemPunteggio;
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('PUNTEGGIO_ITEM_S','U');
      (rvComp as TRaveText).Left:=(rvComp as TRaveText).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblPunteggio',rvPage);
      (rvComp as TRaveDataText).Visible:=StampaItemPunteggio;
      (rvComp as TRaveDataText).Left:=(rvComp as TRaveDataText).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnTitoloPunteggio',rvPage);
      (rvComp as TRaveVLine).Visible:=StampaItemPunteggio;
      (rvComp as TRaveVLine).Left:=(rvComp as TRaveVLine).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnPunteggio',rvPage);
      (rvComp as TRaveVLine).Visible:=StampaItemPunteggio;
      (rvComp as TRaveVLine).Left:=(rvComp as TRaveVLine).Left + LarghezzaMancante;
      // Soglia elemento
      if not StampaItemPunteggio then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloSogliaPunteggio',rvPage);
      (rvComp as TRaveText).Visible:=StampaItemSoglia;
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('SOGLIA_PUNTEGGIO_ITEM_S','U');
      (rvComp as TRaveText).Left:=(rvComp as TRaveText).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblSogliaPunteggio',rvPage);
      (rvComp as TRaveDataText).Visible:=StampaItemSoglia;
      (rvComp as TRaveDataText).Left:=(rvComp as TRaveDataText).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnTitoloSogliaPunteggio',rvPage);
      (rvComp as TRaveVLine).Visible:=StampaItemSoglia;
      (rvComp as TRaveVLine).Left:=(rvComp as TRaveVLine).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnSogliaPunteggio',rvPage);
      (rvComp as TRaveVLine).Visible:=StampaItemSoglia;
      (rvComp as TRaveVLine).Left:=(rvComp as TRaveVLine).Left + LarghezzaMancante;
      // Percentuale elemento
      if not StampaItemSoglia then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloPercValutazione',rvPage);
      (rvComp as TRaveText).Visible:=StampaItemPerc;
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('PESO_ITEM_S','U');
      (rvComp as TRaveText).Left:=(rvComp as TRaveText).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblPercValutazione',rvPage);
      (rvComp as TRaveDataText).Visible:=StampaItemPerc;
      (rvComp as TRaveDataText).Left:=(rvComp as TRaveDataText).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnTitoloPercValutazione',rvPage);
      (rvComp as TRaveVLine).Visible:=StampaItemPerc;
      (rvComp as TRaveVLine).Left:=(rvComp as TRaveVLine).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnPercValutazione',rvPage);
      (rvComp as TRaveVLine).Visible:=StampaItemPerc;
      (rvComp as TRaveVLine).Left:=(rvComp as TRaveVLine).Left + LarghezzaMancante;
      // Elemento valutabile
      if not StampaItemPerc then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloValutabile',rvPage);
      (rvComp as TRaveText).Visible:=StampaItemValutabile;
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('ITEM_VALUTABILE_S','U');
      (rvComp as TRaveText).Left:=(rvComp as TRaveText).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblValutabile',rvPage);
      (rvComp as TRaveDataText).Visible:=StampaItemValutabile;
      (rvComp as TRaveDataText).Left:=(rvComp as TRaveDataText).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnTitoloValutabile',rvPage);
      (rvComp as TRaveVLine).Visible:=StampaItemValutabile;
      (rvComp as TRaveVLine).Left:=(rvComp as TRaveVLine).Left + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnValutabile',rvPage);
      (rvComp as TRaveVLine).Visible:=StampaItemValutabile;
      (rvComp as TRaveVLine).Left:=(rvComp as TRaveVLine).Left + LarghezzaMancante;
      // Descrizione elemento
      if not StampaItemValutabile then
        LarghezzaMancante:=LarghezzaMancante + LarghezzaColonna;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloDescItem',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('DESCRIZIONE_ITEM_S','U');
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblDescValutazione',rvPage);
      (rvComp as TRaveDataMemo).Width:=(rvComp as TRaveDataMemo).Width + LarghezzaMancante;
      // Note Punteggio
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloNotePunteggio',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('NOTE_PUNTEGGIO_S','U') + ':';
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblNotePunteggio',rvPage);
      (rvComp as TRaveDataMemo).Width:=(rvComp as TRaveDataMemo).Width + LarghezzaMancante;
      rvComp:=rvProject.ProjMan.FindRaveComponent('lnNotePunteggioDx',rvPage);
      (rvComp as TRaveVLine).Left:=(rvComp as TRaveVLine).Left + LarghezzaMancante;
      // Codice elemento
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloCodItem',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('CODICE_ITEM_S','U');
      // Titoli dettaglio
      if (W022DtM2.RecuperaEtichetta('CODICE_ITEM_S') = '') and
        (W022DtM2.RecuperaEtichetta('DESCRIZIONE_ITEM_S') = '') and
        (W022DtM2.RecuperaEtichetta('ITEM_VALUTABILE_S') = '') and
        (W022DtM2.RecuperaEtichetta('PESO_ITEM_S') = '') and
        (W022DtM2.RecuperaEtichetta('SOGLIA_PUNTEGGIO_ITEM_S') = '') and
        (W022DtM2.RecuperaEtichetta('PUNTEGGIO_ITEM_S') = '') and
        (W022DtM2.RecuperaEtichetta('PUNTEGGIO_PESATO_ITEM_S') = '') then
      begin
        rvComp:=rvProject.ProjMan.FindRaveComponent('Rectangle15',rvPage);
        AltezzaMancante:=(rvComp as TRaveRectangle).Height - 0.005;
        rvComp:=rvProject.ProjMan.FindRaveComponent('bndColonne',rvPage);
        (rvComp as TRaveContainerControl).Height:=(rvComp as TRaveContainerControl).Height - AltezzaMancante;
      end;
      // Impostazione dei campi descrittivi
      rvComp:=rvProject.ProjMan.FindRaveComponent('bndValutazioneIntermedia',rvPage);
      (rvComp as TRaveContainerControl).Visible:=Trim(cdsRiepilogo.FieldByName('VALUTAZIONE_INTERMEDIA').AsString) <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloValutazioneIntermedia',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('VALUTAZIONE_INTERMEDIA_S','U');
      rvComp:=rvProject.ProjMan.FindRaveComponent('bndValutazioniComplessive',rvPage);
      (rvComp as TRaveContainerControl).Visible:=(Trim(cdsRiepilogo.FieldByName('VALUTAZIONI_COMPLESSIVE').AsString) <> '') and not Fase1StampaDirigenzaConObiettivi;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloValutazioniComplessive',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('VALUTAZIONI_COMPLESSIVE_S','U');
      rvComp:=rvProject.ProjMan.FindRaveComponent('bndObiettiviPianificati',rvPage);
      (rvComp as TRaveContainerControl).Visible:=Trim(cdsRiepilogo.FieldByName('OBIETTIVI_PIANIFICATI').AsString) <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloObiettiviPianificati',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('OBIETTIVI_PIANIFICATI_S','U');
      rvComp:=rvProject.ProjMan.FindRaveComponent('bndProposteFormative',rvPage);
      (rvComp as TRaveContainerControl).Visible:=Trim(cdsRiepilogo.FieldByName('PROPOSTE_FORMATIVE').AsString) <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloProposteFormative',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('PROPOSTE_FORMATIVE_S','U');
      rvComp:=rvProject.ProjMan.FindRaveComponent('bndCommentiValutato',rvPage);
      (rvComp as TRaveContainerControl).Visible:=Trim(cdsRiepilogo.FieldByName('COMMENTI_VALUTATO').AsString) <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloCommentiValutato',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('COMMENTI_VALUTATO_S','U');
      rvComp:=rvProject.ProjMan.FindRaveComponent('bndNote',rvPage);
      (rvComp as TRaveContainerControl).Visible:=Trim(cdsRiepilogo.FieldByName('NOTE').AsString) <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloNote',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('NOTE_S','U');
      rvComp:=rvProject.ProjMan.FindRaveComponent('bndItemPersonalizzato',rvPage);
      W022DtM2.ElementiPersonalizzati.SetVariable('DATA',W022DtM2.Q710.FieldByName('DATA').AsDateTime);
      W022DtM2.ElementiPersonalizzati.SetVariable('PROGRESSIVO',W022DtM2.Q710.FieldByName('PROGRESSIVO').AsInteger);
      W022DtM2.ElementiPersonalizzati.SetVariable('TIPO_VALUTAZIONE',W022DtM2.Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
      W022DtM2.ElementiPersonalizzati.SetVariable('STATO_AVANZAMENTO',W022DtM2.Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      W022DtM2.ElementiPersonalizzati.SetVariable('COD_AREA','');
      W022DtM2.ElementiPersonalizzati.Execute;
      (rvComp as TRaveContainerControl).Visible:=(W022DtM2.ElementiPersonalizzati.FieldAsInteger(0) > 0) and (W022DtM2.RecuperaEtichetta('ITEM_PERSONALIZZATO_S') <> '');
      rvComp:=rvProject.ProjMan.FindRaveComponent('lblItemPersonalizzato',rvPage);
      (rvComp as TRaveText).Text:='(*) ' + W022DtM2.RecuperaEtichetta('ITEM_PERSONALIZZATO_S');
      rvComp:=rvProject.ProjMan.FindRaveComponent('bndNoteIncentivo',rvPage);
      (rvComp as TRaveContainerControl).Visible:=Trim(cdsRiepilogo.FieldByName('NOTE_INCENTIVO').AsString) <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('bndPunteggioFinalePesato',rvPage);
      (rvComp as TRaveContainerControl).Visible:=Fase2StampaDirigenzaConObiettivi;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblTitoloPunteggioFinalePesato2',rvPage);
      (rvComp as TRaveText).Text:=W022DtM2.RecuperaEtichetta('PUNTEGGIO_FINALE_SCHEDA_S','U') + ': ';
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblAccettazioneValutato',rvPage);
      (rvComp as TRaveText).Text:='Accettazione da parte del ' + W022DtM2.RecuperaEtichetta('VALUTATO_S','L') + ':';
      rvComp:=rvProject.ProjMan.FindRaveComponent('bndAccettazioneValutato',rvPage);
      (rvComp as TRaveContainerControl).Visible:=(W022DtM2.Q710.FieldByName('TIPO_VALUTAZIONE').AsString = 'V') and (W022DtM2.selSG741.FieldByName('ABILITA_ACCETTAZIONE_VALUTATO').AsString = 'S') and not Fase1StampaDirigenzaConObiettivi;
      // Controllo se ci sono state nell'anno variazioni che implicano il secondo valutatore
      NVariazioni:=0;
      with W022DtM2 do
        if selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString <> '' then
        begin
          R180SetVariable(selT430a,'PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
          R180SetVariable(selT430a,'DATAINI',Q710.FieldByName('DAL').AsDateTime);
          R180SetVariable(selT430a,'DATARIF',Q710.FieldByName('AL').AsDateTime);
          R180SetVariable(selT430a,'DATO',IfThen(Copy(selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString,1,4) = 'T430',Copy(selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString,5),selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString));
          selT430a.Open;
          NVariazioni:=selT430a.FieldByName('N_VARIAZIONI').AsInteger;
        end;
      // Impostazione delle firme
      rvComp:=rvProject.ProjMan.FindRaveComponent('bndFirme',rvPage);
      (rvComp as TRaveContainerControl).Height:=0;
      if (cdsRiepilogo.FieldByName('FIRMA_1').AsString <> '') or (cdsRiepilogo.FieldByName('FIRMA_2').AsString <> '') or (cdsRiepilogo.FieldByName('FIRMA_3').AsString <> '') then
        (rvComp as TRaveContainerControl).Height:=0.400;
      Firma4:=(NVariazioni > 0) or ((W022DtM2.selSG741.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString = '') and (cdsRiepilogo.FieldByName('FIRMA_4').AsString <> ''));
      if Firma4 or (cdsRiepilogo.FieldByName('FIRMA_5').AsString <> '') or (cdsRiepilogo.FieldByName('FIRMA_6').AsString <> '') then
        (rvComp as TRaveContainerControl).Height:=0.940;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblFirma1',rvPage);
      (rvComp as TRaveText).Visible:=cdsRiepilogo.FieldByName('FIRMA_1').AsString <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('shpFirma1',rvPage);
      (rvComp as TRaveHLine).Visible:=cdsRiepilogo.FieldByName('FIRMA_1').AsString <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblFirma2',rvPage);
      (rvComp as TRaveText).Visible:=cdsRiepilogo.FieldByName('FIRMA_2').AsString <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('shpFirma2',rvPage);
      (rvComp as TRaveHLine).Visible:=cdsRiepilogo.FieldByName('FIRMA_2').AsString <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblFirma3',rvPage);
      (rvComp as TRaveText).Visible:=cdsRiepilogo.FieldByName('FIRMA_3').AsString <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('shpFirma3',rvPage);
      (rvComp as TRaveHLine).Visible:=cdsRiepilogo.FieldByName('FIRMA_3').AsString <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('dlblFirma4',rvPage);
      (rvComp as TRaveDataText).Visible:=Firma4; // BugFix: Nonostante la bndFirme.Height sia impostata a 0, viene stampata la quarta firma, se valorizzata
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblFirma4',rvPage);
      (rvComp as TRaveText).Visible:=Firma4;
      rvComp:=rvProject.ProjMan.FindRaveComponent('shpFirma4',rvPage);
      (rvComp as TRaveHLine).Visible:=Firma4;
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblFirma5',rvPage);
      (rvComp as TRaveText).Visible:=cdsRiepilogo.FieldByName('FIRMA_5').AsString <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('shpFirma5',rvPage);
      (rvComp as TRaveHLine).Visible:=cdsRiepilogo.FieldByName('FIRMA_5').AsString <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('qlblFirma6',rvPage);
      (rvComp as TRaveText).Visible:=cdsRiepilogo.FieldByName('FIRMA_6').AsString <> '';
      rvComp:=rvProject.ProjMan.FindRaveComponent('shpFirma6',rvPage);
      (rvComp as TRaveHLine).Visible:=cdsRiepilogo.FieldByName('FIRMA_6').AsString <> '';
      // Impostazione della legenda dei punteggi di valutazione
      rvComp :=rvProject.ProjMan.FindRaveComponent('bndLegendaPunteggi',rvPage);
      (rvComp as TRaveContainerControl).Visible:=chkLegendaPunteggi.Checked;
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
        FreeAndNil(dconnRiepilogo);
      except
      end;
      try
        FreeAndNil(dconnDettaglio);
      except
      end;
      try
        FreeAndNil(dconnNote);
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
        FreeAndNil(connRiepilogo);
      except
      end;
      try
        FreeAndNil(connDettaglio);
      except
      end;
      CSStampa.Leave;
    end;
  except
  end;
end;

procedure TW022FDettaglioValutazioni.VisualizzaStampa(NomeFile: String);
begin
  if Pos(INI_PAR_NO_PDF,W000ParConfig.ParametriAvanzati) = 0 then
    VisualizzaFile(NomeFile,'Anteprima stampa valutazione',nil,nil);
end;

end.
