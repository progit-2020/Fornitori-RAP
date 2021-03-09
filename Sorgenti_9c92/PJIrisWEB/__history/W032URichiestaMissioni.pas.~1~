unit W032URichiestaMissioni;

interface

uses
  W032URichiestaMissioniDM, W032UMotivazioneFM, W032UPercorsoFM,
  R012UWebAnagrafico, R013UIterBase, C018UIterAutDM, QueryStorico,
  A000UInterfaccia, A000UCostanti, A000UMessaggi, A000USessione,
  W000UMessaggi, IWApplication,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, WC012UVisualizzaFileFM,
  meIWEdit, meTIWAdvRadioGroup, meTIWAdvCheckGroup, meIWRegion, meIWButton,
  meIWComboBox, meIWImageFile, meIWLabel, meIWGrid, IWCompMemo, meIWMemo,
  Oracle, OracleData, Math, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, ActnList, IWTemplateProcessorHTML, IWCompLabel,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompEdit, IWAdvRadioGroup, IWCompCheckbox, DB, DBClient, IWDBGrids,
  IWCompListBox, medpIWDBGrid, StrUtils, medpIWTabControl, IWVCLBaseContainer,
  IWContainer, IWRegion, IWAdvCheckGroup,
  meIWCheckBox, IWCompButton, IWCompGrids, IWCompExtCtrls, meIWLink,
  IWHTMLContainer, IWHTML40Container, Menus, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWHTMLControls, IOUtils, medpIWMultiColumnComboBox, System.Generics.Collections,
  medpIWMessageDlg;

type
  TRecordAnticipo = record
    Codice: String;
    Quantita: Currency;
    Note: String;
  end;

  TRecordDettaglioGG = record
    Tipo: String;
    Data: TDateTime;
    Dalle: String;
    Alle: String;
    Note: String;
  end;

  TRecordRimborso = record
    Codice: String;
    IndennitaKm: String;     // dato calcolato in base a "Codice"
    DataRimborso: TDateTime;
    IdRimborso: Integer;
    KmPercorsi: double;
    CodValuta: String;
    Rimborso,
    RimborsoVar: currency;
    Note,
    FileAllegato: String;
  end;

  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
  end;

  TRegolaM010 = record
    Codice: String;
    Descrizione: String;
    AbilRimb: String;
    AbilIndKm: String;
    RimbKmAuto: String;
    IndKmAuto: String;
    TipoRegistrazione: String;
    ArrotTariffaDopoRiduzione: String;
  end;

  TDatiMezzo = class(TPersistent)
  private
    Riga: Integer;
    FlagAnticipo: String;
    FlagMotivazione: String;
    FlagTarga: String;
    FlagMezzoProprio: String;
  end;

  TDatoPersonalizzato = class
  private
    Codice: String;                     // codice del dato personalizzato da M025_MOTIVAZIONI
    Descrizione: String;                // descrizione del dato personalizzato
    Obbligatorio: Boolean;              // indica se la valorizzazione del dato personalizzato è obbligatoria
    Formato: String;                    // formato del dato (S = stringa, N = numerico, D = data)
    LungMax: Integer;                   // lunghezza max del dato (se Formato = S / N)
    DatoAnagrafico: String;             // dato anagrafico associato, se presente
    QueryValore: String;                // codice dell'interrogazione di servizio da usare per reperire l'elenco dei valori
    ValoreDefault: String;              // valore di default da impostare in inserimento
    Elenco: Boolean;                    // indica se il dato è selezionabile da elenco oppure no
    ElencoTabellare: Boolean;           // indica se il dato anagrafico associato / query valore è tabellare o meno
    LungCodice: Integer;                // in caso di elenco tabellare, indica la lunghezza del codice
    ElencoFisso: String;                // indica se l'elenco dei valori è fisso o è possibile indicare un valore libero (S/N)
    CodCategoria: String;               // codice categoria di riferimento su M024_CATEG_DATI_LIBERI
    AbilitaModifica: Boolean;           // indica se è abilitata la modifica dati per l'autorizzatore
    ValoreStr: String;                  // valore del dato espresso in formato string
  end;

  TRichiesta = record
    ProtocolloManuale: String;          // S/N
    Protocollo: String;                 // numero di protocollo (solo se inserito manualmente)
    FlagDestinazione: String;
    FlagIspettiva: String;
    Partenza: String;                   // codice località partenza
    ElencoDestinazioni: String;         // elenco codici località destinazione separati da virgola
    Rientro: String;                    // codice località rientro
    FlagPercorso: String;
    OraDa: String;
    OraA: String;
    DatiPers: TDictionary<String,TDatoPersonalizzato>;
    DataDa: TDateTime;
    DataA: TDateTime;
    Delegato: String;
    TipoRegistrazione: String;
    PercorsoTesto: String;
  end;

  TW032FRichiestaMissioni = class(TR013FIterBase)
    dsrM140: TDataSource;
    cdsM140: TClientDataSet;
    rgDettaglio: TmeIWRegion;
    tabMissioni: TmedpIWTabControl;
    tpAnticipi: TIWTemplateProcessorHTML;
    cgpMotivEstero: TmeTIWAdvCheckGroup;
    cgpIpotesiEstero: TmeTIWAdvCheckGroup;
    dsrM160: TDataSource;
    cdsM160: TClientDataSet;
    tpDettaglio: TIWTemplateProcessorHTML;
    rgAnticipi: TmeIWRegion;
    rgpAccredito: TmeTIWAdvRadioGroup;
    chkDelegato: TmeIWCheckBox;
    edtCercaDelegato: TmeIWEdit;
    lblDelegato: TmeIWLabel;
    cmbDelegato: TmeIWComboBox;
    btnCercaDelegato: TmeIWButton;
    grdAnticipi: TmedpIWDBGrid;
    grdMezzi: TmeIWGrid;
    lblNoteMezzoProprio: TmeIWLabel;
    rgRimborsi: TmeIWRegion;
    tpRimborsi: TIWTemplateProcessorHTML;
    grdRimborsi: TmedpIWDBGrid;
    dsrM150: TDataSource;
    cdsM150: TClientDataSet;
    lblAutRimborsi: TmeIWLabel;
    lblRespRimborsi: TmeIWLabel;
    rgDettaglioGG: TmeIWRegion;
    grdDettaglioGG: TmedpIWDBGrid;
    cdsM143: TClientDataSet;
    dsrM143: TDataSource;
    tpDettaglioGG: TIWTemplateProcessorHTML;
    lblDatiObbligatori: TmeIWLabel;
    grdDati: TmeIWGrid;
    lnkDocumento: TmeIWLink;
    lblMezzi: TmeIWLabel;
    lblTotAnticipi: TmeIWLabel;
    procedure IWAppFormRender(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure lnkDocumentoClick(Sender: TObject);
    procedure rgpTipoRichiesteClick(selCountDatiPers: TObject);
    procedure tabMissioniTabControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure tabMissioniTabControlChange(Sender: TObject);
    // richiesta missione
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    // anticipi
    procedure grdAnticipiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdAnticipiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure btnCercaDelegatoClick(Sender: TObject);
    procedure edtCercaDelegatoSubmit(Sender: TObject);
    procedure chkDelegatoClick(Sender: TObject);
    procedure rgpAccreditoClick(Sender: TObject);
    // rimborsi
    procedure grdRimborsiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRimborsiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    // servizi attivi
    procedure grdDettaglioGGRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdDettaglioGGAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdDatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdMezziRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    Richiesta: TRichiesta;
    RecordAnticipo: TRecordAnticipo;
    RecordDettaglioGG: TRecordDettaglioGG;
    RecordRimborso: TRecordRimborso;
    ListaAnticipi,ListaRimborsi,ListaValute,ListaTipiRegistrazione: TStringList;
    Autorizza: TAutorizza;
    RegolaM010: TRegolaM010;
    CssIniCgp,CodRimborsoPastoM020,CodAnticipoPastoM020,MsgAnt,MsgRimb: String;
    RegoleTrovate, GestAnticipi: Boolean;
    W032MotivazioneFM: TW032FMotivazioneFM;
    W032PercorsoFM: TW032FPercorsoFM;
    imgApplica,
    imgConfermaAnt,
    imgConfermaDettGG,
    imgConfermaRimb: TmeIWImageFile;
    FiltroUserM020: Boolean;
    CtrlValiditaPeriodo: Boolean;
    OldId: Integer;
    QSCodRegole: TQueryStorico;
    ForzaRefreshListe: Boolean;
    EsistonoDatiPersonalizzati: Boolean;
    procedure GetRichiesteMissioni;
    procedure PopolaMezzi;
    procedure CaricaListe;
    procedure CaricaListaTipiRegistrazione;
    procedure PopolaDatiPersonalizzati;
    procedure cmbFlagDestinazioneChange(Sender: TObject);
    // richiesta missione
    procedure CleanRecordRichiesta;
    function  RicalcoloTipoMissione(const PForzaImpostazioneTipoCompatibile: Boolean; var RErrMsg: String): Boolean;
    procedure DBGridColumnClick(ASender:TObject; const AValue:string);
    procedure TrasformaComponenti(const FN:String);
    function  CtrlSalvaDatiPersonalizzati(var RErrMsg: String): Boolean;
    function  ControlliOK(const FN: String):Boolean;
    procedure imgInserisciClick(Sender: TObject);
    procedure imgModificaClick(Sender:TObject);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgAnnullaMissioneClick(Sender: TObject);
    procedure imgChiudiMissioneClick(Sender: TObject);
    procedure imgRiapriMissioneClick(Sender: TObject);
    procedure imgIterClick(Sender: TObject);
    procedure imgAllegClick(Sender: TObject); // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2
    procedure imgPercorsoClick(Sender: TObject);
    procedure chkProtocolloManualeAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure actInsRichiesta;
    procedure ConfermaInsRichiesta;
    procedure AnnullaInsRichiesta;
    procedure actModRichiesta(const FN: String);
    procedure actCancRichiesta(const FN: String);
    // autorizzazione missione
    procedure TrasformaComponentiAut(const FN: String);
    function  ControlliAutOK(const FN: String): Boolean;
    procedure actModDatiAut(const FN: String);
    procedure imgModificaDatiAutClick(Sender: TObject);
    procedure imgConfermaDatiAutClick(Sender: TObject);
    procedure imgAnnullaDatiAutClick(Sender: TObject);
    // anticipi
    procedure DBGridColumnClickAnt(ASender:TObject; const AValue:string);
    procedure TrasformaComponentiAnt(const FN:String);
    function  CtrlAnticipoOK(const FN: String): Boolean;
    procedure imgInsAnticipoClick(Sender: TObject);
    procedure imgModAnticipoClick(Sender: TObject);
    procedure imgCanAnticipoClick(Sender: TObject);
    procedure imgAnnullaAnticipoClick(Sender: TObject);
    procedure imgApplicaAnticipoClick(Sender: TObject);
    procedure actInsAnticipo;
    procedure actModAnticipo(const FN: String);
    // rimborsi
    procedure DBGridColumnClickRimb(ASender:TObject; const AValue:string);
    procedure TrasformaComponentiRimb(const FN:String);
    function  CtrlRimborsoOK(const FN: String): Boolean;
    function  CtrlSommaIndKmOK: Boolean;
    procedure imgInsRimborsoClick(Sender: TObject);
    procedure imgModRimborsoClick(Sender: TObject);
    procedure imgCanRimborsoClick(Sender: TObject);
    procedure imgAnnullaRimborsoClick(Sender: TObject);
    procedure imgApplicaRimborsoClick(Sender: TObject);
    procedure actInsRimborso;
    procedure actModRimborso(const FN: String);
    // servizi attivi
    procedure DBGridColumnClickDettaglioGG(ASender:TObject; const AValue:string);
    procedure TrasformaComponentiDettaglioGG(const FN:String);
    function  CtrlDettaglioGGOK(const FN: String): Boolean;
    procedure imgInsDettaglioGGClick(Sender: TObject);
    procedure imgModDettaglioGGClick(Sender: TObject);
    procedure imgCanDettaglioGGClick(Sender: TObject);
    procedure imgAnnullaDettaglioGGClick(Sender: TObject);
    procedure imgApplicaDettaglioGGClick(Sender: TObject);
    procedure actInsDettaglioGG;
    procedure actModDettaglioGG(const FN: String);
    procedure CancellaServiziAttivi;
    procedure cmbVoceAnticipoChange(Sender: TObject);
    procedure cmbVoceRimborsoChange(Sender: TObject);
    procedure chkMezzoClick(Sender: TObject);
    procedure cmbIspettivaChange(Sender: TObject);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure AutorizzazioneOK;
    procedure GestioneFasi(const PFasePrima, PFaseDopo: Integer; const PRiapriMissione: Boolean = False);
    procedure LeggiRegolaMissione(Data:TDateTime;VisualizzaMessaggio:Boolean = True);
    procedure PosizionamentoMultiColumnText(PCmb: TMedpIWMultiColumnComboBox;
      const PValore: String; const PCodLen: Integer);
    procedure CleanMezziTrasporto;
    procedure EseguiChiusuraMissione;
    procedure OnConfermaChiusuraMissione(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  protected
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    W032DM: TW032FRichiestaMissioniDM;
    function  InizializzaAccesso:Boolean; override;
    procedure OnTabChanging(var AllowChange: Boolean; var Conferma: String); override;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
    procedure ConfermaAnnullaMissione(const PMotivazione: String); // richiamata da frame di conferma
    procedure ConfermaPercorso(PPercorsoInfo: TPercorsoInfo); // richiamata da frame di percorso
    procedure AnnullaPercorso; // richiamata da frame di percorso
  end;

const
  MAX_RIMBORSI_PASTO_GG          = 2;
  MAX_LENGTH_ELENCO_DESTINAZIONI = 30;

implementation

uses W001UIrisWebDtM, IWGlobal;

{$R *.dfm}

function TW032FRichiestaMissioni.InizializzaAccesso:Boolean;
begin
  Result:=True;
  GetDipendentiDisponibili(C018.Periodo.Fine);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  // carica grid mezzi trasporto
  PopolaMezzi;

  if WR000DM.Responsabile then
  begin
    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;
  end;

  // aggiorna visualizzazione
  VisualizzaDipendenteCorrente;
end;

procedure TW032FRichiestaMissioni.IWAppFormCreate(Sender: TObject);
var
  URLDoc, DatiPersonalizzati: String;
begin
  Tag:=IfThen(WR000DM.Responsabile,441,440);
  inherited;

  AddScrollBarManager('divscrollable');
  // visualizzazione link a eventuale documento informativo
  URLDoc:=ExtractFileName(Parametri.CampiRiferimento.C8_W032DocumentoMissioni).Trim;
  { DONE : TEST IW 15 }
//  lnkDocumento.Visible:=(UrlDoc <> '') and (TFile.Exists(gSC.FilesDir + URLDoc));
  lnkDocumento.Visible:=(UrlDoc <> '') and (TFile.Exists(TA000FInterfaccia(gSC).MEDPFilesDir + URLDoc));

  // inizializzazione dati record richiesta
  CleanRecordRichiesta;

  W032DM:=TW032FRichiestaMissioniDM.Create(Self);

  // individua su M025 i dati personalizzati da estrarre nella selezione anagrafica
  W032DM.selM025DatiAnagPers.Close;
  W032DM.selM025DatiAnagPers.Open;
  while not W032DM.selM025DatiAnagPers.Eof do
  begin
    DatiPersonalizzati:=DatiPersonalizzati + Format(',V430.T430%s',[W032DM.selM025DatiAnagPers.FieldByName('DATO_ANAGRAFICO').AsString]);
    W032DM.selM025DatiAnagPers.Next;
  end;
  W032DM.selM025DatiAnagPers.Close;

  // elenco campi da includere nella query anagrafica
  CampiV430:='V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430COMUNE,V430.T430D_COMUNE,V430.T430COMUNE_DOM_BASE,V430.T430D_COMUNE_DOM_BASE' + DatiPersonalizzati;

  // verifica la presenza della function personalizzata USR_M020M021F_FILTROITER
  // per il filtro dei codici rimborso / anticipo
  try
    W032DM.selFiltroM020.Execute;
    FiltroUserM020:=W032DM.selFiltroM020.FieldAsInteger(0) = 1;
  except
    FiltroUserM020:=False;
  end;

  // VARESE_PROVINCIA
  // verifica la presenza della function personalizzata USR_M140F_PERIODO_VALIDO
  // per il controllo di coerenza con le timbrature
  try
    W032DM.selValiditaPeriodo.Execute;
    CtrlValiditaPeriodo:=W032DM.selValiditaPeriodo.FieldAsInteger(0) = 1;
  except
    CtrlValiditaPeriodo:=False;
  end;

  // verifica presenza di codici di anticipo
  try
    W032DM.selCountAnticipi.Execute;
    GestAnticipi:=W032DM.selCountAnticipi.FieldAsInteger(0) > 0;
  except
    GestAnticipi:=False;
  end;

  // controllo esistenza dati personalizzati per le missioni web
  try
    W032DM.selCountDatiPers.Execute;
    EsistonoDatiPersonalizzati:=W032DM.selCountDatiPers.FieldAsInteger(0) > 0;
  except
    EsistonoDatiPersonalizzati:=False;
  end;

  Iter:=ITER_MISSIONI;
  W032DM.C018:=C018;
  if WR000DM.Responsabile then
    C018.PreparaDataSetIter(W032DM.selM140,tiAutorizzazione)
  else
    C018.PreparaDataSetIter(W032DM.selM140,tiRichiesta);
  C018.Periodo.SetVuoto;
  // TORINO_REGIONE
  // per il dipendente il filtro "da autorizzare" viene inteso come
  // trasferta da autorizzare (per i rimborsi esiste invece un filtro specifico)
  if not WR000DM.Responsabile then
  begin
    // AOSTA_REGIONE - chiamata 91877.ini
    // esclude le richieste negate in modo esplicito
    {
    C018.FiltroRichiesta[trDaAutorizzare]:=Format('T851F_FASE_CORRENTE(''%s'',''%s'',T850.COD_ITER,T850.ID) in (%d,%d)',
                                                  [Parametri.Azienda,C018.Iter,M140FASE_INIZIALE,M140FASE_CASSA]);
    }
    C018.FiltroRichiesta[trDaAutorizzare]:=Format('(nvl(T850.STATO,''X'') <> ''%s'') and (T851F_FASE_CORRENTE(''%s'',''%s'',T850.COD_ITER,T850.ID) in (%d,%d))',
                                                  [C018NO,Parametri.Azienda,C018.Iter,M140FASE_INIZIALE,M140FASE_CASSA]);
    // AOSTA_REGIONE - chiamata 91877.fine
    C018.FiltroRichiesta[trAutorizzate]:=Format('T851F_FASE_CORRENTE(''%s'',''%s'',T850.COD_ITER,T850.ID) not in (%d,%d)',
                                                [Parametri.Azienda,C018.Iter,M140FASE_INIZIALE,M140FASE_CASSA]);
  end;

  // impostazione tab
  tabMissioni.HasFiller:=True;
  tabMissioni.AggiungiTab('Dettaglio richiesta',rgDettaglio);
  if GestAnticipi then
    tabMissioni.AggiungiTab('Anticipi',rgAnticipi)
  else
    rgAnticipi.Visible:=False;
  tabMissioni.AggiungiTab('Rimborsi',rgRimborsi);
  tabMissioni.AggiungiTab('Servizi attivi',rgDettaglioGG);
  tabMissioni.ActiveTab:=rgDettaglio;

  // tabella richieste
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdRichieste.medpDataSet:=W032DM.selM140;
  grdRichieste.medpTestoNoRecord:='Nessuna richiesta';

  // tabella anticipi (no paginazione)
  grdAnticipi.medpDataSet:=W032DM.selM160;
  grdAnticipi.medpTestoNoRecord:='Nessun anticipo';

  // tabella dettaglio giornaliero (no paginazione)
  grdDettaglioGG.medpDataSet:=W032DM.selM143;
  grdDettaglioGG.medpTestoNoRecord:='Nessun servizio attivo';

  // tabella rimborsi (no paginazione)
  grdRimborsi.medpDataSet:=W032DM.selM150;
  grdRimborsi.medpTestoNoRecord:='Nessun rimborso';

  CssIniCgp:=cgpMotivEstero.Css;

  QSCodRegole:=TQueryStorico.Create(nil);
  QSCodRegole.Session:=SessioneOracle;
  RegolaM010.Codice:='';
  RegolaM010.Descrizione:='';
  RegolaM010.AbilRimb:='';
  RegolaM010.AbilIndKm:='';
  RegolaM010.TipoRegistrazione:='';
  RegolaM010.ArrotTariffaDopoRiduzione:='';

  imgConfermaAnt:=nil;
  imgConfermaRimb:=nil;

  // inizializzazione variabili
  OldId:=-1;
  ForzaRefreshListe:=False;

  // stringlist
  ListaAnticipi:=TStringList.Create;
  ListaRimborsi:=TStringList.Create;
  ListaValute:=TStringList.Create;

  // lista tipologie missione: inizialmente carica tutte le liste
  ListaTipiRegistrazione:=TStringList.Create;
  CaricaListaTipiRegistrazione;
end;

procedure TW032FRichiestaMissioni.IWAppFormRender(Sender: TObject);
var
  Cod: String;
begin
  inherited;
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;
  if tabMissioni.ActiveTab = rgDettaglio then
  begin
    lblMezzi.Enabled:=True;
  end
  else if tabMissioni.ActiveTab = rgAnticipi then
  begin
    // visibilità radiogroup delegato
    if (chkDelegato.Css = 'invisibile') and (rgpAccredito.Css = 'invisibile') then
    begin
      C190VisualizzaGroupBox(jqTemp,'w032Delegato',False);
    end;

    Cod:='$(".ui-autocomplete-input").css("width","24em");';
    if jQAutocomplete.OnReady.IndexOf(Cod) < 0 then
      jQAutocomplete.OnReady.Add(Cod);
  end;
  (*Se si vuole attivare un log su questa pagina
    per poi successivamente utilizzare InserisciMessaggio RegistraMsg.InserisciMessaggio()*)
  try
    if RegistraMsg.ID = -1 then
      RegistraMsg.IniziaMessaggio(medpCodiceForm);
  except
  end;
end;

procedure TW032FRichiestaMissioni.OnTabChanging(var AllowChange: Boolean; var Conferma: String);
begin
  AllowChange:=grdRichieste.medpStato = msBrowse;
end;

procedure TW032FRichiestaMissioni.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  if grdRichieste.medpStato <> msBrowse then
  begin
    case grdRichieste.medpStato of
      msInsert:
        Conferma:='Attenzione! La richiesta in fase di inserimento non è stata confermata.';
      msEdit:
        Conferma:='Attenzione! Sono presenti modifiche in corso non salvate che verranno perse.';
    end;
    Conferma:=Conferma + CRLF + 'Uscire comunque dalla funzione?';
  end;
end;

procedure TW032FRichiestaMissioni.RefreshPage;
begin
  WR000DM.Responsabile:=Tag = 441;
  // aggiorna visualizzazione
  if grdRichieste.medpStato = msBrowse then
    VisualizzaDipendenteCorrente;
end;

procedure TW032FRichiestaMissioni.rgpAccreditoClick(Sender: TObject);
begin
  chkDelegato.Enabled:=rgpAccredito.ItemIndex = 1;
  if not chkDelegato.Enabled then
  begin
    chkDelegato.Checked:=False;
    chkDelegatoClick(chkDelegato);
  end;
end;

procedure TW032FRichiestaMissioni.rgpTipoRichiesteClick(selCountDatiPers: TObject);
begin
  VisualizzaDipendenteCorrente;
end;

procedure TW032FRichiestaMissioni.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;
end;

procedure TW032FRichiestaMissioni.VisualizzaDipendenteCorrente;
begin
  inherited;
  GetRichiesteMissioni;
end;

procedure TW032FRichiestaMissioni.CleanRecordRichiesta;
// pulisce i dati della richiesta
begin
  Richiesta.FlagDestinazione:='';
  Richiesta.FlagIspettiva:='';
  Richiesta.Partenza:='';
  Richiesta.ElencoDestinazioni:='';
  Richiesta.Rientro:='';
  Richiesta.FlagPercorso:='';
  if Richiesta.DatiPers <> nil then
    FreeAndNil(Richiesta.DatiPers);
  Richiesta.DatiPers:=TDictionary<String,TDatoPersonalizzato>.Create;
  Richiesta.DataDa:=DATE_NULL;
  Richiesta.DataA:=DATE_NULL;
  Richiesta.OraDa:='';
  Richiesta.OraA:='';
  Richiesta.Delegato:='';
  Richiesta.TipoRegistrazione:='';
  Richiesta.PercorsoTesto:='';
end;

// AOSTA_REGIONE.ini
function TW032FRichiestaMissioni.RicalcoloTipoMissione(const PForzaImpostazioneTipoCompatibile: Boolean; var RErrMsg: String): Boolean;
// verifica ed eventualmente imposta il tipo missione verificando se è compatibile
// con le regole definite nella function personalizzata M011F_FILTROITER,
// (che verifica i dati presenti sul database)
// restituisce
//   True   se il tipo registrazione attualmente impostato è compatibile oppure
//          se ne è stato impostato uno automaticamente
//   False  se il tipo registrazione non è compatibile o se non esistono tipi compatibili
// casistiche considerate:
//   - se il filtro restituisce un resultset vuoto
//     -> restituisce False
//   - altrimenti
//     - se il tiporegistrazione è nullo:
//       -> imposta il primo codice disponibile (primo in ordine alfabetico)
//          e restituisce True
//     - se il tiporegistrazione è già impostato:
//       - se il tiporegistrazione è nel filtro
//         -> restituisce True
//       - se il tiporegistrazione non è nel filtro ->
//         valorizza messaggio di errore
//         - se PForzaImpostazioneTipoCompatibile = True
//           -> restituisce True
//         - se PForzaImpostazioneTipoCompatibile = False
//           -> restituisce False
var
  TipoRegistrazione, NewTipo: String;
  OldCommitOnPost: Boolean;
begin
  RErrMsg:='';
  NewTipo:='';

  // salva proprietà dataset missioni
  OldCommitOnPost:=W032DM.selM140.CommitOnPost;

  with W032DM.selM011 do
  begin
    try
      Close;
      SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
      Filtered:=True;
      Open;
      if RecordCount = 0 then
      begin
        // il filtro è vuoto -> restituisce False
        RErrMsg:='Nessun tipo missione previsto in base ai dati della richiesta!';
        //Verifico se è stato applicato il filtro dizionario
        Filtered:=False;
        if RecordCount > 0 then
          RErrMsg:=RErrMsg + CRLF + 'Verificare anche il Filtro dizionario.';
        Result:=False;
      end
      else
      begin
        TipoRegistrazione:=W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString;
        if TipoRegistrazione = '' then
        begin
          // tipo registrazione nullo -> imposta il primo codice disponibile nel filtro
          First;
          NewTipo:=FieldByName('CODICE').AsString;
          Result:=True;
        end
        else
        begin
          // tipo registrazione impostato: lo cerca nel filtro
          if SearchRecord('CODICE',TipoRegistrazione,[srFromBeginning]) then
          begin
            // se il tipo è presente nel filtro restituisce True
            Result:=True;
          end
          else
          begin
            // se PForzaImpostazioneTipoCompatibile restituisce True, altrimenti False
            // in ogni caso valorizza il messaggio di errore
            Result:=PForzaImpostazioneTipoCompatibile;
            RErrMsg:=Format('Il tipo missione indicato (%s)'#13#10'non è compatibile con i dati della missione.',
                            [VarToStr(W032DM.selM011Lookup.Lookup('CODICE',TipoRegistrazione,'DESCRIZIONE'))]);
            if PForzaImpostazioneTipoCompatibile then
            begin
              First;
              NewTipo:=FieldByName('CODICE').AsString;
              RErrMsg:=RErrMsg + Format(#13#10'E'' stata impostata automaticamente una tipologia'#13#10'di missione compatibile (%s).'#13#10'Si prega di controllare i dati della richiesta n. %s.',
                                        [VarToStr(W032DM.selM011Lookup.Lookup('CODICE',NewTipo,'DESCRIZIONE')),
                                         W032DM.selM140.FieldByName('PROTOCOLLO').AsString]);
            end;
          end;
        end;
      end;

      // update del tipo registrazione se necessario
      if (NewTipo <> '') and
         (NewTipo <> TipoRegistrazione) then
      begin
        // esegue update senza committare
        W032DM.selM140.CommitOnPost:=False;
        W032DM.selM140.Edit;
        W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString:=NewTipo;
        W032DM.selM140.Post;
      end;
    except
      on E: Exception do
      begin
        RErrMsg:=E.Message;
        Result:=False;
      end;
    end;
  end;

  // ripristina commitonpost
  W032DM.selM140.CommitOnPost:=OldCommitOnPost;
end;
// AOSTA_REGIONE.fine

procedure TW032FRichiestaMissioni.LeggiRegolaMissione(Data:TDateTime;VisualizzaMessaggio:Boolean = True);
var
  DatoRegola,CodiceRegole,TipoRegistrazione,Est,Isp:string;
begin
  with W032DM do
  begin
    if grdRichieste.medpStato = msInsert then
    begin
      Est:=Richiesta.FlagDestinazione;
      Isp:=Richiesta.FlagIspettiva;
    end
    else
    begin
      Est:=selM140.FieldByName('FLAG_DESTINAZIONE').AsString;
      Isp:=selM140.FieldByName('FLAG_ISPETTIVA').AsString;
    end;
    Est:=IfThen(Est = 'E','S','N');

    RegoleTrovate:=True;
    CodiceRegole:='';
    TipoRegistrazione:='';
    try
      DatoRegola:='T430' + Parametri.CampiRiferimento.C8_Missione;
      QSCodRegole.GetDatiStorici(DatoRegola,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,Data);
      if QSCodRegole.LocDatoStorico(Data) then
        CodiceRegole:=QSCodRegole.FieldByName(DatoRegola).AsString;

      // estrae tipo missione da tabella di decodifica
      // in base a flag estero + flag ispettiva
      if (Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S') and
         (grdRichieste.medpStato in [msEdit,msInsert]) then
      begin
        // tipo registrazione
        TipoRegistrazione:=Richiesta.TipoRegistrazione;
      end
      // TORINO_REGIONE - chiamata 75475.ini
      //else if grdRichieste.medpStato <> msInsert then
      else if grdRichieste.medpStato = msBrowse then
      // TORINO_REGIONE - chiamata 75475.fine
      begin
        // in caso di browse rilegge il parametro da tabella
        // se si tratta di insert o update viene invece rideterminato dalla M012
        TipoRegistrazione:=selM140.FieldByName('TIPOREGISTRAZIONE').AsString;
      end;

      // AOSTA_REGIONE.ini
      // il tipo registrazione è ora determinato in base alla function M011F_FILTROITER
      with selM011 do
      begin
        ListaTipiRegistrazione.Clear;
        Close;
        ClearVariables;
        SetVariable('REGOLA',CodiceRegole);
        if grdRichieste.medpStato <> msInsert then
          SetVariable('ID',selM140.FieldByName('ID').AsInteger);
        Filtered:=True;
        try
          Open;
          while not Eof do
          begin
            if (TipoRegistrazione = '') and (RecNo = 1) then
              TipoRegistrazione:=FieldByName('CODICE').AsString;
            ListaTipiRegistrazione.Add(Format('%s=%s',[FieldByName('DESCRIZIONE').AsString,FieldByName('CODICE').AsString]));
            Next;
          end;
        except
          on E: EOracleError do
          begin
            MsgBox.MessageBox(Format('%s',[E.Message]),ERRORE);
          end;
          on E: Exception do
            raise;
        end;
      end;
      // AOSTA_REGIONE.fine

      if (CodiceRegole <> '') and (TipoRegistrazione <> '') then
      begin
        if (selM010.GetVariable('DECORRENZA') <> Data) or
           (selM010.GetVariable('TIPOREGISTRAZIONE') <> TipoRegistrazione) or
           (selM010.GetVariable('CODICE') <> CodiceRegole) then
        begin
          selM010.Close;
          selM010.SetVariable('DECORRENZA',Data);
          selM010.SetVariable('TIPOREGISTRAZIONE',TipoRegistrazione);
          selM010.SetVariable('CODICE',CodiceRegole);
          selM010.Open;
        end;
      end;
    except
      on E: Exception do
      begin
        MsgBox.MessageBox('Errore durante la lettura delle regole della missione:' + CRLF +
                          '(' + E.ClassName + ') ' + E.Message + CRLF + CRLF +
                          'Informazioni per verifica anomalia' + CRLF +
                          'Codice regola (' + Parametri.CampiRiferimento.C8_Missione + '): ' + CodiceRegole + CRLF +
                          'Tipo missione: ' + TipoRegistrazione + CRLF +
                          'Data riferimento: ' + FormatDateTime('dd/mm/yyyy',Data) + CRLF +
                          'Si prega di contattare l''ufficio competente.',ERRORE);
        Exit;
      end;
    end;

    // gestione regola non trovata:
    // non si controlla se si è in fase di inserimento perchè i dati della missione non sono ancora stati registrati
    if (grdRichieste.medpStato <> msInsert) or (TipoRegistrazione <> '') then
    begin
      if (not selM010.Active) or (selM010.Active and (selM010.RecordCount = 0)) then
      begin
        if VisualizzaMessaggio then
        begin
          MsgBox.MessageBox('Regole della missione non trovate' + IfThen(WR000DM.Responsabile,' per il dipendente e la tipologia di trasferta') +
                            ' in data ' + DateToStr(Data) + '.' + CRLF +
                            'Codice regola (' + Parametri.CampiRiferimento.C8_Missione + '): ' + IfThen(CodiceRegole = '<non trovato>','',CodiceRegole) + CRLF +
                            'Tipo missione: ' + IfThen(TipoRegistrazione = '','<non trovato>',TipoRegistrazione) + CRLF +
                            'Data riferimento: ' + FormatDateTime('dd/mm/yyyy',Data) + CRLF +
                            'Si prega di contattare l''ufficio competente.',ERRORE);
        end;
        RegoleTrovate:=False;
      end
      else
      begin
        // imposta dati regola
        RegolaM010.Codice:=CodiceRegole;
        RegolaM010.Descrizione:=selM010.FieldByName('DESCRIZIONE').AsString;
        RegolaM010.AbilRimb:=selM010.FieldByName('CODICI_RIMBORSI').AsString;
        RegolaM010.AbilIndKm:=selM010.FieldByName('CODICI_INDENNITAKM').AsString;
        RegolaM010.RimbKmAuto:=selM010.FieldByName('RIMB_KM_AUTO').AsString;
        RegolaM010.IndKmAuto:=selM010.FieldByName('IND_KM_AUTO').AsString;
        RegolaM010.TipoRegistrazione:=TipoRegistrazione;
        RegolaM010.ArrotTariffaDopoRiduzione:=selM010.FieldByName('ARROTTARIFFADOPORIDUZIONE').AsString;
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.lnkDocumentoClick(Sender: TObject);
var
  URLDoc: String;
begin
  URLDoc:=ExtractFileName(Parametri.CampiRiferimento.C8_W032DocumentoMissioni);
  VisualizzaFile(URLDoc,'Richiesta trasferte - documento informativo',nil,nil,fdGlobal);
end;

procedure TW032FRichiestaMissioni.tabMissioniTabControlChange(Sender: TObject);
begin
  ForzaRefreshListe:=False;
  if tabMissioni.ActiveTab = rgAnticipi then
  begin
    // se si passa al tab anticipi forza la rilettura delle liste
    // dei codici di anticipo selezionabili
    ForzaRefreshListe:=True;
    CaricaListe;
  end
  else if tabMissioni.ActiveTab = rgRimborsi then
  begin
    // se si passa al tab rimborsi forza la rilettura delle liste
    // dei codici di rimborso selezionabili
    ForzaRefreshListe:=True;
    CaricaListe;

    // se necessario visualizza label di autorizzazione rimborsi
    if lblAutRimborsi.Caption <> '' then
    begin
      AddToInitProc('$("#T032AutRimborsi").show();');
    end;
  end
end;

procedure TW032FRichiestaMissioni.tabMissioniTabControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange:=(grdAnticipi.medpStato = msBrowse) and
               (grdRimborsi.medpStato = msBrowse);
end;

procedure TW032FRichiestaMissioni.chkMezzoClick(Sender: TObject);
var
  i,j: Integer;
  Abilita: Boolean;
  DatiMezzo: TDatiMezzo;
  IWG: TmeIWGrid;
  IWEdt: TmeIWEdit;
  IWRadio: TmeTIWAdvRadioGroup;
  IWCmb: TmeIWComboBox;
begin
  // mezzo con FLAG_MOTIVAZIONE = 'S' e/o FLAG_TARGA = 'S'
  Abilita:=(Sender as TmeIWCheckBox).Checked;
  DatiMezzo:=((Sender as TmeIWCheckBox).medpTag as TDatiMezzo);
  i:=DatiMezzo.Riga;

  // abilita campo motivazione e/o targa
  if grdMezzi.Cell[i,0].Control is TmeIWGrid then
  begin
    IWG:=TmeIWGrid(grdMezzi.Cell[i,0].Control);
    for j:=1 to IWG.ColumnCount - 1 do
    begin
      if IWG.Cell[0,j].Control <> nil then
      begin
        IWEdt:=(IWG.Cell[0,j].Control as TmeIWEdit);
        if ((DatiMezzo.FlagMotivazione = 'S') and
            ((IWEdt.medpTag as TDatiMezzo).FlagMotivazione = 'S')) or
           ((DatiMezzo.FlagTarga = 'S') and
            ((IWEdt.medpTag as TDatiMezzo).FlagTarga = 'S')) then
        begin
          AbilitazioneComponente(IWEdt,Abilita);
          if not Abilita then
            IWEdt.Text:='';
          // se l'edit è relativo alla motivazione imposta il watermark
          if ((IWEdt.medpTag as TDatiMezzo).FlagMotivazione = 'S') and
             (Abilita) then
          begin
            IWEdt.medpWatermark:='Specificare...';
          end;
          // se l'edit è relativo a un mezzo con flag_targa, propone l'ultima targa utilizzata
          if ((IWEdt.medpTag as TDatiMezzo).FlagTarga = 'S') and
             (Abilita) and
             (IWEdt.Text = '') then
          begin
            // estrae la targa indicata nell'ultima richiesta in cui si utilizza un automezzo
            // nota: viene distinto l'automezzo proprio da quello di servizio
            with W032DM.selM170Targa do
            begin
              Close;
              SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
              SetVariable('FLAG_TIPO',M020TIPO_MEZZO);
              SetVariable('FLAG_MEZZO_PROPRIO',DatiMezzo.FlagMezzoProprio);
              Open;
              if RecordCount > 0 then
                IWEdt.Text:=FieldByName('TARGA').AsString;
              Close;
            end;
          end;
        end;
      end;
    end;
  end;

  // verifica se automezzo proprio
  if DatiMezzo.FlagMezzoProprio = 'S' then
  begin
    // verifica se occorre visualizzare o meno la riga successiva
    // con il radiogroup per la corresponsione delle spese viaggio
    with W032DM do
    begin
      if grdRichieste.medpStato = msBrowse then
      begin
        Abilita:=Abilita and (selM140.FieldByName('FLAG_ISPETTIVA').AsString = 'N');
      end
      else
      begin
        i:=grdRichieste.medpRigaDiCompGriglia(cdsM140.FieldByName('DBG_ROWID').AsString);
        IWCmb:=(grdRichieste.medpCompCella(i,'C_ISPETTIVA',0) as TmeIWComboBox);
        // se il componente non è creato significa che non si è abilitati alla modifica -> legge valore dal dataset
        if IWCmb = nil then
          Abilita:=Abilita and (selM140.FieldByName('FLAG_ISPETTIVA').AsString = 'N')
        else
          Abilita:=Abilita and (IWCmb.Items.ValueFromIndex[IWCmb.ItemIndex] = 'N');
      end;

      // applica visualizzazione su riga succ.
      i:=DatiMezzo.Riga + 1;
      IWRadio:=(grdMezzi.Cell[i,0].Control as TmeTIWAdvRadioGroup);
      IWRadio.Css:=IfThen(Abilita,'intestazione width60chr','invisibile');
      if not Abilita then
        IWRadio.ItemIndex:=1;
    end; // end with
  end;
end;

procedure TW032FRichiestaMissioni.cmbIspettivaChange(Sender: TObject);
var
  i: Integer;
  Ispettiva,Abilita: Boolean;
  DatiMezzo: TDatiMezzo;
  IWG: TmeIWGrid;
begin
  Ispettiva:=(Sender as TmeIWComboBox).Items.ValueFromIndex[(Sender as TmeIWComboBox).ItemIndex] = 'S';

  // abilitazione per mezzi trasporto
  Abilita:=not Ispettiva;
  for i:=0 to grdMezzi.RowCount - 1 do
  begin
    if (grdMezzi.Cell[i,0].Control is TmeIWGrid) then
    begin
      IWG:=(grdMezzi.Cell[i,0].Control as TmeIWGrid);
      DatiMezzo:=((IWG.Cell[0,0].Control as TmeIWCheckBox).medpTag as TDatiMezzo);
      // corresponsione spese di viaggio
      if (DatiMezzo <> nil) and
         (DatiMezzo.FlagMezzoProprio = 'S') then
      begin
        Abilita:=Abilita and ((IWG.Cell[0,0].Control as TmeIWCheckBox).Checked);
        if grdMezzi.Cell[i + 1,0].Control is TmeTIWAdvRadioGroup then
        begin
          with (grdMezzi.Cell[i + 1,0].Control as TmeTIWAdvRadioGroup) do
          begin
            Css:=IfThen(Abilita,'intestazione width60chr','invisibile');
            if not Abilita then
              ItemIndex:=1;
          end;
        end;
        Break;
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.PopolaMezzi;
// popola la tabella dei mezzi di trasporto
var
  i,c: Integer;
  IWC: TIWCustomControl;
  TB: TmeIWGrid;
  E1,E2: String;
begin
  with W032DM.selM020Mezzi do
  begin
    Close;
    Open;

    grdMezzi.RowCount:=RecordCount;
    i:=-1;
    while not Eof do
    begin
      inc(i);

      TB:=TmeIWGrid.Create(Self);
      TB.Parent:=Self;
      TB.Css:='';
      TB.ExtraTagParams.Add('style=width: auto');
      TB.RowCount:=1;
      TB.ColumnCount:=1 + IfThen(FieldByName('FLAG_MOTIVAZIONE').AsString = 'S',1,0) +
                          IfThen(FieldByName('FLAG_TARGA').AsString = 'S',1,0);

      // checkbox per selezione mezzo di trasporto
      c:=0;
      IWC:=C190DBGridCreaChkBox(Self,Self,FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString);
      IWC.Css:='intestazione';
      if (FieldByName('FLAG_TARGA').AsString = 'S') or
         (FieldByName('FLAG_MOTIVAZIONE').AsString = 'S') then
      begin
        with (IWC as TmeIWCheckBox) do
        begin
          if medpTag = nil then
            medpTag:=TDatiMezzo.Create;
          with (medpTag as TDatiMezzo) do
          begin
            Riga:=i;
            FlagAnticipo:=FieldByName('FLAG_ANTICIPO').AsString;
            FlagMotivazione:=FieldByName('FLAG_MOTIVAZIONE').AsString;
            FlagTarga:=FieldByName('FLAG_TARGA').AsString;
            FlagMezzoProprio:=FieldByName('FLAG_MEZZO_PROPRIO').AsString;
          end;
          OnClick:=chkMezzoClick;
        end;
      end;
      TB.Cell[0,c].Control:=IWC;

      // edit per eventuale motivazione
      if FieldByName('FLAG_MOTIVAZIONE').AsString = 'S' then
      begin
        inc(c);
        TB.Cell[0,c].Text:=' - Motivazione: ';
        IWC:=C190DBGridCreaEdit(Self,Self,FieldByName('CODICE').AsString,'width30chr','');
        with (IWC as TmeIWEdit) do
        begin
          MaxLength:=2000;
          medpTag:=TDatiMezzo.Create;
          with (medpTag as TDatiMezzo) do
          begin
            FlagAnticipo:=FieldByName('FLAG_ANTICIPO').AsString;
            // per l'edit indica solo il flag motivazione
            FlagMotivazione:=FieldByName('FLAG_MOTIVAZIONE').AsString;
          end;
        end;
        TB.Cell[0,c].Control:=IWC;
      end;

      // edit per eventuale targa
      if FieldByName('FLAG_TARGA').AsString = 'S' then
      begin
        inc(c);
        TB.Cell[0,c].Text:=' - ' + IfThen(FieldByName('FLAG_MEZZO_PROPRIO').AsString = 'S','(**) ') + 'Targa n.: ';
        IWC:=C190DBGridCreaEdit(Self,Self,FieldByName('CODICE').AsString,'input10 maiuscolo','');
        with (IWC as TmeIWEdit) do
        begin
          MaxLength:=15;
          medpTag:=TDatiMezzo.Create;
          with (medpTag as TDatiMezzo) do
          begin
            FlagAnticipo:=FieldByName('FLAG_ANTICIPO').AsString;
            // per l'edit indica il flag targa + mezzo proprio
            FlagTarga:=FieldByName('FLAG_TARGA').AsString;
            FlagMezzoProprio:=FieldByName('FLAG_MEZZO_PROPRIO').AsString;
          end;
        end;
        TB.Cell[0,c].Control:=IWC;
      end;
      grdMezzi.Cell[i,0].Control:=TB;

      // se automezzo proprio e visita non ispettiva crea nuova riga con radiogroup
      // per scegliere se corresponsione spese viaggio
      if FieldByName('FLAG_MEZZO_PROPRIO').AsString = 'S' then
      begin
        inc(i);
        grdMezzi.RowCount:=grdMezzi.RowCount + 1;
        // radiogroup per scelta corresp. spese viaggio
        E1:='Verificata in via preventiva la sussistenza dei presupposti all''utilizzo del mezzo proprio,<br/>' +
            '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;se ne autorizza l''uso e la successiva corresponsione delle spese di viaggio.';
        E2:='Si autorizza l''uso del mezzo proprio senza corresponsione delle spese di viaggio';
        grdMezzi.Cell[i,0].Css:='padding_sx_20px';
        grdMezzi.Cell[i,0].Control:=C190DBGridCreaRadioGroup(Self,Self,FieldByName('CODICE').AsString,Format('"%s" %s',[E1,E2]),'invisibile','');
        with (grdMezzi.Cell[i,0].Control as TmeTIWAdvRadioGroup) do
        begin
          Layout:=glVertical;
          Columns:=1;
        end;
      end;
      Next;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.CaricaListaTipiRegistrazione;
// ricarica la lista dei tipi registrazione senza filtrare i codici con la function M011F_FILTROITER
begin
  with W032DM.selM011 do
  begin
    ListaTipiRegistrazione.Clear;
    Close;
    ClearVariables;
    Filtered:=True;
    try
      Open;
      while not Eof do
      begin
        ListaTipiRegistrazione.Add(Format('%s=%s',[FieldByName('DESCRIZIONE').AsString,FieldByName('CODICE').AsString]));
        Next;
      end;
    except
      on E: EOracleError do
      begin
        // errore nella function M011F_FILTROITER
        MsgBox.MessageBox(Format('%s',[E.Message]),ERRORE);
        Exit;
      end;
      on E: Exception do
        raise;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.CaricaListe;
var
  FiltroCodici,
  ElencoRimb,
  FiltroIndKm,
  ElencoIndKm,
  FiltroM020: String;
  Id: Integer;
begin
  Id:=W032DM.selM140.FieldByName('ID').AsInteger;
  FiltroM020:='and    exists (select ''X'' from dual where USR_M020M021F_FILTROITER(' + IntToStr(Id) + ',''%s'',CODICE) = ''S'')';

  // codici di rimborsi (e anticipi) abilitati
  if RegolaM010.AbilRimb = '' then
    FiltroCodici:=''
  else
  begin
    ElencoRimb:=StringReplace(RegolaM010.AbilRimb,',',''',''',[rfReplaceAll]);
    FiltroCodici:=Format('and CODICE in (''%s'')',[ElencoRimb]);
  end;

  // lista voci anticipo
  with W032DM.selM020Anticipi do
  begin
    if (ForzaRefreshListe) or
       (not Active) or
       (VarToStr(GetVariable('FILTRO_CODICI')) <> FiltroCodici) or
       (OldId <> Id) then
    begin
      CodAnticipoPastoM020:='';
      ListaAnticipi.Clear;
      Close;
      SetVariable('FILTRO_CODICI',FiltroCodici);
      if FiltroUserM020 then
        SetVariable('FILTRO',Format(FiltroM020,['M020A']));
      Filtered:=True;
      Open;
      while not Eof do
      begin
        ListaAnticipi.Add(FieldByName('DESCRIZIONE').AsString + '=' + FieldByName('CODICE').AsString);
        if FieldByName('TIPO').AsString = M020TIPO_PASTO then
          CodAnticipoPastoM020:=FieldByName('CODICE').AsString;
        Next;
      end;
    end;
  end;

  // codici di indennità km abilitate
  if RegolaM010.AbilIndKm = '' then
    FiltroIndKm:=''
  else
  begin
    ElencoIndKm:=StringReplace(RegolaM010.AbilIndKm,',',''',''',[rfReplaceAll]);
    FiltroIndKm:=Format('and CODICE in (''%s'')',[ElencoIndKm]);
  end;

  // lista voci rimborsi e indennità km
  if (ForzaRefreshListe) or
     (not W032DM.selM020Rimborsi.Active) or
     (OldId <> Id) or
     (VarToStr(W032DM.selM020Rimborsi.GetVariable('FILTRO_CODICI')) <> FiltroCodici) or
     (not W032DM.selM021.Active) or
     // CUNEO_ASLCN1 - chiamata 90231.ini
     // bugfix: i dati vengono estratti alla data di fine missione
     //(VarToDateTime(W032DM.selM021.GetVariable('DATA')) <> Parametri.DataLavoro) or
     (VarToDateTime(W032DM.selM021.GetVariable('DATA')) <> W032DM.selM140.FieldByName('DATAA').AsDateTime) or
     // CUNEO_ASLCN1 - chiamata 90231.fine
     (VarToStr(W032DM.selM021.GetVariable('FILTRO_CODICI')) <> FiltroIndKm) then
  begin
    ListaRimborsi.Clear;
    CodRimborsoPastoM020:='';
    // lista voci rimborso
    with W032DM.selM020Rimborsi do
    begin
      Close;
      SetVariable('FILTRO_CODICI',FiltroCodici);
      if FiltroUserM020 then
        SetVariable('FILTRO',Format(FiltroM020,['M020R']));
      Filtered:=True;
      Open;
      while not Eof do
      begin
        ListaRimborsi.Add(FieldByName('DESCRIZIONE').AsString + '=' + FieldByName('CODICE').AsString);
        if FieldByName('TIPO').AsString = M020TIPO_PASTO then
          CodRimborsoPastoM020:=FieldByName('CODICE').AsString;
        Next;
      end;
    end;

    // indennità km (caricate solo se è stato selezionato come mezzo di trasporto "automezzo proprio")
    with W032DM.selM021 do
    begin
      Close;
      // CUNEO_ASLCN1 - chiamata 90231.ini
      // bugfix: i dati vengono estratti alla data di fine missione
      //SetVariable('DATA',Parametri.DataLavoro);
      SetVariable('DATA',W032DM.selM140.FieldByName('DATAA').AsDateTime);
      // CUNEO_ASLCN1 - chiamata 90231.fine
      SetVariable('FILTRO_CODICI',FiltroIndKm);
      if FiltroUserM020 then
        SetVariable('FILTRO',Format(FiltroM020,['M021']));
      Open;

      // in caso di gestione dei rimborsi km automatici, effettua queste considerazioni:
      // - se è stato indicato il codice di indennità automatica, e questo è presente nella
      //   lista dei rimborsi filtrati in base alla regola e al filtro dizionario, utilizza questo
      // - altrimenti si utilizza il primo codice di indennità km disponibile (v. ciclo successivo)
      W032DM.RimbAutomatico.Abilitato:=(RegolaM010.RimbKmAuto = 'S');

      if (W032DM.RimbAutomatico.Abilitato) and
         (RecordCount > 0) and
         (SearchRecord('CODICE',RegolaM010.IndKmAuto,[srFromBeginning])) then
      begin
        W032DM.RimbAutomatico.CodIndKM:=FieldByName('CODICE').AsString;
      end
      else
      begin
        W032DM.RimbAutomatico.CodIndKM:='';
      end;

      First;
      while not Eof do
      begin
        // in caso di gestione dei rimborsi km automatici, se non è indicato
        // un codice valido si utilizza il primo codice di indennità km disponibile
        if (W032DM.RimbAutomatico.Abilitato) and
           (W032DM.RimbAutomatico.CodIndKM = '') and
           (RecNo = 1) then
        begin
          W032DM.RimbAutomatico.CodIndKM:=FieldByName('CODICE').AsString;
        end;

        // il codice di indennità automatica non viene visualizzato nella lista
        if VarToStr(W032DM.selM150.Lookup('CODICE;AUTOMATICO',VarArrayOf([FieldByName('CODICE').AsString,'S']),'CODICE')) = '' then
          ListaRimborsi.Add(FieldByName('DESCRIZIONE').AsString + '=' + FieldByName('CODICE').AsString);

        Next;
      end;
    end;
  end;

  // lista valute
  with W032DM.selP030 do
  begin
    if (ForzaRefreshListe) or
       (not Active) or
       (VarToDateTime(GetVariable('DATA')) <> Parametri.DataLavoro) then
    begin
      ListaValute.Clear;
      Close;
      SetVariable('DATA',Parametri.DataLavoro);
      Open;
      while not Eof do
      begin
        // in caso di gestione dei rimborsi km automatici,
        // viene utilizzato il primo codice di valuta
        if W032DM.RimbAutomatico.Abilitato then
        begin
          if RecNo = 1 then
            W032DM.RimbAutomatico.CodValuta:=FieldByName('COD_VALUTA').AsString;
        end;
        ListaValute.Add(FieldByName('DESCRIZIONE').AsString + '=' + FieldByName('COD_VALUTA').AsString);
        Next;
      end;
    end;
  end;

  OldId:=Id;
end;

procedure TW032FRichiestaMissioni.PopolaDatiPersonalizzati;
// popola i dati personalizzati delle missioni:
// - il checkgroup delle motivazioni per le trasferte estere
// - il checkgroup delle ipotesi per le trasferte estere
// - la tabella dei dati personalizzati
var
  Codice, Descrizione, Categoria, CategoriaPrec, Valori, DatoAnagrafico, QueryValore, ElencoFisso,
  Tabella, TabCodice, TabStorico, WidthCss, HintCampo, StileCampo, S,
  ValoreDefault, TestoSQLQueryValore, Valore: String;
  Formato: Char;
  r, LungMax, FaseCorr, FaseLiv, MinFaseMod, MaxFaseMod, Righe, Prog: Integer;
  Obbligatorio, PrimaRottura, Elenco, ElencoTabellare, AbilRiga: Boolean;
  DatoPers: TDatoPersonalizzato;
  IWLbl: TmeIWLabel;
  IWC: TIWCustomControl;
  IWCmb: TMedpIWMultiColumnComboBox;
  DSValori: TOracleDataSet;
const
  DATI_PERS_MAXWIDTH_CHAR = 40;   // num. max di caratteri per la width del dato personalizzato (la max-length rimane invariata!)
  DATI_PERS_MAXLENGTH     = 2000; // num. max di caratteri su database per i dati personalizzati
begin
  // checkgroup motivazioni e ipotesi trasf. estere
  cgpMotivEstero.Items.Clear;
  cgpIpotesiEstero.Items.Clear;

  // fase corrente della richiesta e fase del livello attuale
  if grdRichieste.medpStato = msInsert then
  begin
    FaseLiv:=M140FASE_INIZIALE;
    FaseCorr:=M140FASE_INIZIALE;
  end
  else
  begin
    FaseLiv:=C018.FaseLivello[W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger];
    FaseCorr:=W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger;
  end;

  // tabella dei dati personalizzati
  grdDati.RowCount:=1;
  r:=0;
  CategoriaPrec:='';
  PrimaRottura:=True;

  W032DM.selM025.Close;
  W032DM.selM025.Open;
  while not W032DM.selM025.Eof do
  begin
    Codice:=W032DM.selM025.FieldByName('CODICE').AsString;
    Descrizione:=W032DM.selM025.FieldByName('DESCRIZIONE').AsString;
    Categoria:=W032DM.selM025.FieldByName('CATEGORIA').AsString;

    // categorie speciali non modificabili
    if Categoria = MISSIONE_COD_CAT_ESTERO_MOTIVAZIONI then
    begin
      // motivazioni trasferte estere
      cgpMotivEstero.Items.Add(Descrizione);
      cgpMotivEstero.Values.Add(Codice);
    end
    else if Categoria = MISSIONE_COD_CAT_ESTERO_IPOTESI then
    begin
      // ipotesi trasferte estere
      cgpIpotesiEstero.Items.Add(Descrizione);
      cgpIpotesiEstero.Values.Add(Codice);
    end
    else
    begin
      // dati personalizzati
      DSValori:=nil;

      // controllo visibilità (per ora legata a categoria)
      if R180Between(FaseLiv,W032DM.selM025.FieldByName('MIN_FASE_VISIBILE_CAT').AsInteger,W032DM.selM025.FieldByName('MAX_FASE_VISIBILE_CAT').AsInteger) then
      begin
        // gestione rottura di categoria
        if Categoria <> CategoriaPrec then
        begin
          // 1/3 bordo superiore (esclude prima rottura di categoria)
          if not PrimaRottura then
          begin
            grdDati.Cell[r,0].Css:='riga_bianca bordo_top_categoria';
            grdDati.Cell[r,0].Text:='';
            grdDati.Cell[r,1].Css:='riga_bianca bordo_top_categoria';
            grdDati.Cell[r,1].Text:=' ';
            grdDati.RowCount:=grdDati.RowCount + 1;
            inc(r);
          end;

          // 2/3 riga di descrizione della categoria
          grdDati.Cell[r,0].Css:='riga_categoria';
          grdDati.Cell[r,0].Text:='<div style="position:relative; height:100%;">&nbsp;<span style="position:absolute; left:0; top:0; width:100%; height:100%;">' + W032DM.selM025.FieldByName('DESCRIZIONE_CAT').AsString + '</span></div>';
          grdDati.Cell[r,0].RawText:=True;
          grdDati.Cell[r,1].Css:='riga_categoria';
          grdDati.Cell[r,1].Text:=' ';
          grdDati.RowCount:=grdDati.RowCount + 1;
          inc(r);

          // 3/3 bordo inferiore
          grdDati.Cell[r,0].Css:='riga_bianca bordo_sx_categoria lineHeight0_5em';
          grdDati.Cell[r,0].Text:='';
          grdDati.Cell[r,1].Css:='riga_bianca bordo_dx_categoria lineHeight0_5em';
          grdDati.Cell[r,1].Text:=' ';
          grdDati.RowCount:=grdDati.RowCount + 1;
          inc(r);

          PrimaRottura:=False;
        end;

        // informazioni sul dato
        Valori:=W032DM.selM025.FieldByName('VALORI').AsString;
        Obbligatorio:=W032DM.selM025.FieldByName('OBBLIGATORIO').AsString = 'S';
        Righe:=W032DM.selM025.FieldByName('RIGHE').AsInteger;
        Formato:=R180CarattereDef(W032DM.selM025.FieldByName('FORMATO').AsString);
        LungMax:=W032DM.selM025.FieldByName('LUNG_MAX').AsInteger;
        DatoAnagrafico:=W032DM.selM025.FieldByName('DATO_ANAGRAFICO').AsString;
        QueryValore:=W032DM.selM025.FieldByName('QUERY_VALORE').AsString;
        ElencoFisso:=W032DM.selM025.FieldByName('ELENCO_FISSO').AsString;
        ValoreDefault:=W032DM.selM025.FieldByName('VALORE_DEFAULT').AsString;
        Elenco:=(QueryValore <> '') or (DatoAnagrafico <> '') or (Valori <> '');

        // cerca di capire se il dato è tabellare (codice + descrizione) o meno
        ElencoTabellare:=False;
        if QueryValore <> '' then
        begin
          // elenco valori estratto da interrogazione di servizio
          W032DM.selQueryValore.SetVariable('NOME',QueryValore);
          try
            W032DM.selQueryValore.Execute;
            TestoSQLQueryValore:=W032DM.selQueryValore.FieldAsString(0);
          except
            TestoSQLQueryValore:='';
          end;

          if TestoSQLQueryValore <> '' then
          begin
            // crea e imposta proprietà dataset
            DSValori:=TOracleDataSet.Create(Self);
            DSValori.Session:=SessioneOracle;
            DSValori.ReadBuffer:=50;
            DSValori.ReadOnly:=True;

            // imposta testo e variabili sql
            DSValori.Close;
            DSValori.SQL.Text:=TestoSQLQueryValore;
            // gestione variabili
            DSValori.ClearVariables;
            DSValori.DeleteVariables;
            // :PROGRESSIVO = progressivo del dipendente
            if R180CercaParolaIntera(':PROGRESSIVO',TestoSQLQueryValore.ToUpper,',;()=<>|!/+-*') > 0 then
            begin
              DSValori.DeclareVariable('PROGRESSIVO',otInteger);
              // bugfix.ini
              // inserimento: utilizza il dipendente selezionato in selAnagrafeW
              // modifica:    utilizza il dipendente indicato nella richiesta
              if grdRichieste.medpStato = msInsert then
                Prog:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger
              else
                Prog:=W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger;
              // bugfix.fine
              DSValori.SetVariable('PROGRESSIVO',Prog);
            end;
            try
              DSValori.Open;
              ElencoTabellare:=DSValori.FieldCount > 1;
            except
              raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_W032_ERR_FMT_QUERY_VALORE),
                                            [W032DM.selM025.FieldByName('DESCRIZIONE').AsString,QueryValore]));
            end;
          end;
        end
        else if DatoAnagrafico <> '' then
        begin
          // elenco valori estratto da dato personalizzato anagrafico
          A000GetTabella(DatoAnagrafico,Tabella,TabCodice,TabStorico);
          ElencoTabellare:=(Tabella <> '') and (Tabella.ToUpper <> 'T430_STORICO');
        end;

        // imposta l'oggetto da associare all'elemento dell'interfaccia come medpTag
        if Formato = 'M' then
        begin
          DatoPers:=nil;
        end
        else
        begin
          DatoPers:=TDatoPersonalizzato.Create;
          DatoPers.Codice:=Codice;
          DatoPers.Descrizione:=Descrizione;
          DatoPers.Obbligatorio:=Obbligatorio;
          DatoPers.Formato:=Formato;
          DatoPers.LungMax:=LungMax;
          DatoPers.DatoAnagrafico:=DatoAnagrafico;
          DatoPers.QueryValore:=QueryValore;
          DatoPers.Elenco:=Elenco;
          DatoPers.ElencoTabellare:=ElencoTabellare;
          DatoPers.LungCodice:=0;
          DatoPers.ElencoFisso:=ElencoFisso;
          DatoPers.ValoreDefault:=ValoreDefault;
          DatoPers.CodCategoria:=Categoria;
          // abilitazione alla modifica
          MinFaseMod:=W032DM.selM025.FieldByName('MIN_FASE_MODIFICA_CAT').AsInteger;
          MaxFaseMod:=W032DM.selM025.FieldByName('MAX_FASE_MODIFICA_CAT').AsInteger;
          HintCampo:='';
          DatoPers.AbilitaModifica:=R180Between(FaseLiv,MinFaseMod,MaxFaseMod);
          if DatoPers.AbilitaModifica then
            HintCampo:=HintCampo + Format('modifica abilitata in fase FL %d (range modifica: [%d..%d])<br>',[FaseLiv,MinFaseMod,MaxFaseMod])
          else
            HintCampo:=HintCampo + Format('<span class=''font_rosso''>modifica inibita in fase FL %d (range modifica: [%d..%d])</span><br>',[FaseLiv,W032DM.selM025.FieldByName('MIN_FASE_MODIFICA_CAT').AsInteger,W032DM.selM025.FieldByName('MAX_FASE_MODIFICA_CAT').AsInteger]);
          // bugfix.ini
          // disabilita comunque la modifica dalla fase cassa in poi
          if (FaseLiv > M140FASE_INIZIALE) and (FaseCorr >= M140FASE_CASSA) then // Alberto 23/03/2015
          begin
            DatoPers.AbilitaModifica:=False;
            HintCampo:=HintCampo + Format('<span class=''font_rosso''>dati non modificabili nella fase corrente: %d</span><br>',[FaseCorr]);
          end;
          // bugfix.fine
          DatoPers.ValoreStr:='';
        end;

        // imposta stili campo in base al formato
        WidthCss:=C190GetCssWidthChr(IfThen(LungMax = 0,DATI_PERS_MAXWIDTH_CHAR,LungMax));
        case Formato of
          // messaggio
          'M': begin
                 StileCampo:='';
                 HintCampo:='formato: messaggio';
               end;
          // stringa
          'S': begin
                 StileCampo:=WidthCss + IfThen(Righe > 1,Format(' height%d',[Righe]));
                 HintCampo:=HintCampo + 'formato: alfanumerico' + Format(' (%d righe) (max %d caratteri)',[Righe,IfThen(LungMax = 0,2000,LungMax)]);
               end;
          // numero
          'N': begin
                 case LungMax of
                       0: StileCampo:='input_num_generic';                        // 0   : input_num_generic  (cifre intere, 2 decimali)
                    1..5: StileCampo:='input_num_' + StringOfChar('n',LungMax);   // 1..5: input_num_n..nnnnn (n cifre intere, 0 decimali)
                 else     StileCampo:='input_integer';                            // >5  : input_integer      (cifre intere, 0 decimali), limitato da codice
                 end;
                 StileCampo:=WidthCss + ' ' + StileCampo;
                 HintCampo:=HintCampo + 'formato: numerico ' + IfThen(LungMax = 0,'decimale',Format('intero (max %d cifre)',[LungMax]));
               end;
          // data dd/mm/yyyy
          'D': begin
                 StileCampo:='input_data_dmy';
                 HintCampo:=HintCampo + 'formato: data (gg/mm/aaaa)';
               end;
        else
          raise Exception.Create(Format('Formato del dato personalizzato non previsto: %s',[Formato]));
        end;
        HintCampo:=HintCampo + '<br>';

        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
        if Formato = 'M' then
        begin
          // il formato messaggio non prevede componenti di input
          IWC:=nil;
        end
        else if Elenco then
        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
        begin
          // dato selezionabile da un elenco fisso: combobox con elenco di valori
          IWC:=C190DBGridCreaMedpMultiColCombo(Self,Self,DatoPers.Descrizione,WidthCss + IfThen(ElencoTabellare,' fontcourier'),'1');
          IWCmb:=(IWC as TMedpIWMultiColumnComboBox);
          IWCmb.medpTag:=DatoPers;
          IWCmb.ColCount:=1;
          IWCmb.CodeColumn:=0;
          if ElencoTabellare then
            IWCmb.CssPopup:='fontcourier';
          IWCmb.CustomElement:=(not ElencoTabellare) and (ElencoFisso = 'N');

          if QueryValore <> '' then
          begin
            // gestione query valore
            if TestoSQLQueryValore = '' then
            begin
              HintCampo:=HintCampo + Format('tipo: query_valore [%s] [NON INDICATA]',[QueryValore]);
            end
            else
            begin
              HintCampo:=HintCampo + Format('tipo: query_valore [%s] [%s]',[QueryValore,IfThen(ElencoTabellare,'tabellare','semplice')]);
              // popola multicolumn con valori
              // nota: il dataset è già stato aperto per determinare se il dato è tabellare
              if (DSValori <> nil) and (DSValori.Active) then
              begin
                // determina lunghezza codice se dato tabellare
                if ElencoTabellare then
                begin
                  DatoPers.LungCodice:=DSValori.Fields[0].Size;
                  // se DOA non riesce a capire la lunghezza del codice ci pensiamo noi
                  // con il vecchio metodo della nonna
                  if DatoPers.LungCodice = 0 then
                  begin
                    DSValori.First;
                    while not DSValori.Eof do
                    begin
                      if DSValori.Fields[0].AsString.Length > DatoPers.LungCodice then
                        DatoPers.LungCodice:=DSValori.Fields[0].AsString.Length;
                      DSValori.Next;
                    end;
                  end;
                  HintCampo:=HintCampo + Format(', lung. codice = %d',[DatoPers.LungCodice]);
                end;
                // popolamento combobox
                DSValori.First;
                while not DSValori.Eof do
                begin
                  if ElencoTabellare then
                    IWCmb.AddRow(Format('%-*s - %s',[DatoPers.LungCodice,DSValori.Fields[0].AsString,DSValori.Fields[1].AsString]))
                  else
                    IWCmb.AddRow(DSValori.Fields[0].AsString);
                  DSValori.Next;
                end;
              end;
            end;
          end
          else if DatoAnagrafico <> '' then
          begin
            // dato anagrafico
            HintCampo:=HintCampo + Format('tipo: dato_anagrafico [%s] [%s]',[DatoAnagrafico,IfThen(ElencoTabellare,'tabellare','semplice')]);

            // se è indicato il dato anagrafico estrae l'elenco di valori in base a questo
            if A000LookupTabella(DatoAnagrafico,WR000DM.selDatoLibero) then
            begin
              // popola multicolumn con valori
              if WR000DM.selDatoLibero.VariableIndex('DECORRENZA') >= 0 then
                WR000DM.selDatoLibero.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
              WR000DM.selDatoLibero.Open;
              if ElencoTabellare then
              begin
                DatoPers.LungCodice:=WR000DM.selDatoLibero.Fields[0].Size;
                HintCampo:=HintCampo + Format(', lung. codice = %d',[DatoPers.LungCodice]);
              end;
              WR000DM.selDatoLibero.First;
              // ciclo di popolamento della combo
              while not WR000DM.selDatoLibero.Eof do
              begin
                if ElencoTabellare then
                  IWCmb.AddRow(Format('%-*s - %s',[DatoPers.LungCodice,WR000DM.selDatoLibero.FieldByName('CODICE').AsString,WR000DM.selDatoLibero.FieldByName('DESCRIZIONE').AsString]))
                else
                  IWCmb.AddRow(WR000DM.selDatoLibero.FieldByName('CODICE').AsString);
                WR000DM.selDatoLibero.Next;
              end;
              WR000DM.selDatoLibero.Close;
            end;
          end
          else
          begin
            // elenco di valori fissi
            HintCampo:=HintCampo + 'tipo: elenco valori fissi';

            // popola multicolumn con valori
            for S in Valori.Split([',']) do
              IWCmb.AddRow(S);
          end;
          HintCampo:=HintCampo + Format('<br>valore default: %s<br>custom element: %s',[IfThen(DatoPers.ValoreDefault = '','[non definito]',DatoPers.ValoreDefault),IfThen(IWCmb.CustomElement,'sì','no')]);
          IWCmb.ItemIndex:=0; // seleziona il primo elemento

          // se è presente un solo elemento nella combobox, questa viene eliminata
          // e sostituita da un edit
          if IWCmb.Items.Count = 1 then
          begin
            // salva il valore del dato e distrugge la combobox
            Valore:=IWCmb.Text;
            IWCmb.medpTag:=nil; // pulisce il puntatore all'oggetto medpTag in modo che non venga distrutto dalla free successiva
            FreeAndNil(IWC);
            IWCmb:=nil; // pulisce il puntatore

            // crea un edit
            IWC:=C190DBGridCreaEdit(Self,Self,DatoPers.Descrizione,StileCampo,'');
            with (IWC as TmeIWEdit) do
            begin
              // maxlength per campi alfanumerici
              // non impostare per campi numerici: problemi con il plugin autonumeric!
              if DatoPers.Formato = 'S' then
                MaxLength:=IfThen(LungMax = 0,DATI_PERS_MAXLENGTH,LungMax);
              medpTag:=DatoPers;
              Text:=Valore;
            end;
          end;
        end
        else
        begin
          // dato personalizzato: edit / memo
          HintCampo:=HintCampo + 'tipo: dato personalizzato';
          if Righe = 1 then
          begin
            // 1 riga: crea un edit
            IWC:=C190DBGridCreaEdit(Self,Self,DatoPers.Descrizione,StileCampo,'');
            with (IWC as TmeIWEdit) do
            begin
              // maxlength per campi alfanumerici
              // non impostare per campi numerici: problemi con il plugin autonumeric!
              if DatoPers.Formato = 'S' then
                MaxLength:=IfThen(LungMax = 0,DATI_PERS_MAXLENGTH,LungMax);
              medpTag:=DatoPers;
            end;
          end
          else
          begin
            // n>1 righe: crea un memo
            IWC:=TmeIWMemo.Create(Self);
            with (IWC as TmeIWMemo) do
            begin
              Parent:=rgDettaglio; // bug TIWMemo -> non impostare il Parent = Self (form): per funzionare deve essere impostata = alla region di dettaglio
              Css:=StileCampo;
              Font.Enabled:=False;
              FriendlyName:=DatoPers.Descrizione;
              medpTag:=DatoPers;
              RenderSize:=False;
              Tag:=1;
            end;
          end;
          HintCampo:=HintCampo + Format('<br>valore default: %s',[IfThen(DatoPers.ValoreDefault = '','[non definito]',DatoPers.ValoreDefault)]);
        end;

        // imposta label e css per cella sx
        IWLbl:=C190DBGridCreaLabel(Self,Self,Codice);
        IWLbl.Caption:=IfThen(Obbligatorio,'(*) ') + W032DM.selM025.FieldByName('DESCRIZIONE').AsString;
        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
        //IWLbl.Css:='intestazione';
        if Formato = 'M' then
        begin
          // formato messaggio
          IWLbl.Css:='messaggio';
          IWLbl.ExtraTagParams.Add('style=position: absolute');
        end
        else
        begin
          // altri formati
          IWLbl.Css:='intestazione';
        end;
        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
        IWLbl.ForControl:=IWC;
        {$WARN SYMBOL_PLATFORM OFF}
        IWLbl.Hint:=IfThen(DebugHook <> 0,'<html>' + HintCampo);
        IWLbl.ShowHint:=(DebugHook <> 0);
        {$WARN SYMBOL_PLATFORM ON}

        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
        if Formato <> 'M' then
        begin
          // abilitazione dei componenti nella riga
          AbilRiga:=(grdRichieste.medpStato <> msBrowse) and DatoPers.AbilitaModifica;

          AbilitazioneComponente(IWLbl,AbilRiga);
          AbilitazioneComponente(IWC,AbilRiga);
        end;
        // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine

        // imposta tabella
        // cella sx: label con nome dato
        // cella dx: input per il dato
        // 1/2. nome del dato
        grdDati.Cell[r,0].Css:='intestazione align_top bordo_sx_categoria';
        grdDati.Cell[r,0].Control:=IWLbl;
        grdDati.Cell[r,0].Text:='';

        // 2/2. imposta componente e css per cella dx
        grdDati.Cell[r,1].Css:='bordo_dx_categoria';
        grdDati.Cell[r,1].Control:=IWC;

        // salva categoria precedente
        CategoriaPrec:=Categoria;

        // aggiunge una riga alla tabella
        grdDati.RowCount:=grdDati.RowCount + 1;
        inc(r);
      end;
    end;

    W032DM.selM025.Next;
  end;

  // visibilità tabella
  grdDati.Visible:=(grdDati.RowCount > 1);

  // gestione tabella dati personalizzati
  if grdDati.RowCount > 1 then
  begin
    // ultima riga con bordo top per chiudere la tabella
    grdDati.Cell[grdDati.RowCount - 1,0].Css:='bordo_top_categoria';
    grdDati.Cell[grdDati.RowCount - 1,1].Css:='bordo_top_categoria';
  end;
end;

procedure TW032FRichiestaMissioni.GetRichiesteMissioni;
var
  FiltroAnag: String;
  VisTab,Accept: Boolean;
  i: Integer;
begin
  grdRichieste.medpStato:=msBrowse;
  grdRichieste.medpBrowse:=True;

  // determina filtri
  FiltroAnag:=IfThen(TuttiDipSelezionato,WR000DM.FiltroRicerca,FiltroSingoloAnagrafico);

  // forza richiamo per comportamento non standard
  CorrezionePeriodo;

  with W032DM.selM140 do
  begin
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG',FiltroAnag);
    SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    Filtered:=False;
    R013Open(W032DM.selM140);
    C018.lstIdFiltrati.Clear;
    while not Eof do
    begin
      Accept:=True;
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      if (FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0) and
         (FieldByName('TIPO_RICHIESTA').AsString < '4') and  //<> '4'
         (FieldByName('FASE_CORRENTE').AsInteger = M140FASE_CASSA) and
         (C018.FaseLivello[FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger] > FieldByName('FASE_CORRENTE').AsInteger) then
        Accept:=False
      else if FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger = 0 then
        Accept:=((trAutorizzate in C018.TipoRichiesteSel) and (Trim(FieldByName('F1_STATO').AsString) <> ''))
                or
                ((trDaAutorizzare in C018.TipoRichiesteSel) and (Trim(FieldByName('F1_STATO').AsString) = ''))
                or
               (not ([trDaAutorizzare,trAutorizzate] <= C018.TipoRichiesteSel));
      if Accept then
        C018.lstIdFiltrati.Add(FieldByName('ID').AsString);
      Next;
    end;
    // filtra dataset in base alle fasi autorizzative accessibili dai responsabili
    // e in base ai check di autorizzazione
    Filtered:=True;
    First;
  end;

  // imposta tabella richieste
  grdRichieste.medpCreaCDS;
  grdRichieste.medpEliminaColonne;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Aut.','',nil);
    if C018.IterModificaValori then
      grdRichieste.medpAggiungiColonna('DBG_COMANDI','Modifica','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
  end
  else
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
  end;
  grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
  grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
  grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
  grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
  if Parametri.CampiRiferimento.C8_W032ProtocolloManuale = 'S' then
    grdRichieste.medpAggiungiColonna('C_PROTOCOLLO_MANUALE','Aut. cartacea','',nil);
  grdRichieste.medpAggiungiColonna('PROTOCOLLO','Numero','',nil);
  grdRichieste.medpAggiungiColonna('C_RIMBORSI','Rimborsi','',nil);
  grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Stato','',nil);
  grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
  grdRichieste.medpAggiungiColonna('FLAG_DESTINAZIONE','Destinazione','',nil);
  grdRichieste.medpColonna('FLAG_DESTINAZIONE').Visible:=False;
  grdRichieste.medpAggiungiColonna('C_DESTINAZIONE','Destinazione','',nil);
  grdRichieste.medpAggiungiColonna('FLAG_ISPETTIVA','Ispettiva','',nil);
  grdRichieste.medpColonna('FLAG_ISPETTIVA').Visible:=False;
  grdRichieste.medpAggiungiColonna('C_ISPETTIVA','Ispettiva','',nil);
  // VARESE_PROVINCIA
  if Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S' then
    grdRichieste.medpAggiungiColonna('C_TIPOREGISTRAZIONE','Tipo','',nil);
  grdRichieste.medpAggiungiColonna('DATADA','Data inizio','',nil);
  grdRichieste.medpAggiungiColonna('ORADA','Dalle','',nil);
  grdRichieste.medpAggiungiColonna('DATAA','Data fine','',nil);
  grdRichieste.medpAggiungiColonna('ORAA','Alle','',nil);
  grdRichieste.medpAggiungiColonna('C_PERCORSO','Percorso','',nil);
  grdRichieste.medpAggiungiColonna('MISSIONE_RIAPERTA','Riaperta','',nil);
  grdRichieste.medpColonna('MISSIONE_RIAPERTA').Visible:=False;
  if not WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('F1_STATO','Aut.','',nil);
    grdRichieste.medpAggiungiColonna('F1_RESP','Responsabile','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
  end;
  grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdRichieste.medpInizializzaCompGriglia;
  if not SolaLettura then
  begin
    if WR000DM.Responsabile then
    begin
      // autorizzazione
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_CHK,'','Si','','');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_CHK,'','No','','');
      // modifica dati
      if C018.IterModificaValori then
      begin
        i:=grdRichieste.medpIndexColonna('DBG_COMANDI');
        grdRichieste.medpPreparaComponenteGenerico('R',i,0,DBG_IMG,'','MODIFICA','Modifica la richiesta','','C');
        grdRichieste.medpPreparaComponenteGenerico('R',i,1,DBG_IMG,'','ANNULLA','Annulla la modifica della richiesta','','S');
        grdRichieste.medpPreparaComponenteGenerico('R',i,2,DBG_IMG,'','CONFERMA','Conferma la modifica della richiesta','','D');
      end;
    end
    else
    begin
      // riga inserimento
      grdRichieste.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','Inserisce una nuova richiesta di trasferta','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','Annulla l''inserimento della richiesta di trasferta','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','Conferma l''inserimento della nuova richiesta di trasferta','','D');
      // righe dettaglio
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la richiesta di trasferta','Eliminare la richiesta selezionata?','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','Modifica la richiesta','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','Annulla la modifica della richiesta','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','Conferma la modifica della richiesta','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,4,DBG_IMG,'','REVOCA','Annulla la richiesta di missione','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,5,DBG_IMG,'','DEFINISCI','Chiude la richiesta','Chiudere l''iter della richiesta selezionata?'#13#10'Attenzione! Questa procedura è irreversibile.','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,6,DBG_IMG,'','RIAPRI','Riapre la richiesta','Riaprire l''iter della richiesta selezionata?'#13#10'Attenzione! Questa procedura è irreversibile.','D');

      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
      // per le richieste prepara il link al percorso trasferta in inserimento
      grdRichieste.medpPreparaComponenteGenerico('I',grdRichieste.medpIndexColonna('C_PERCORSO'),0,DBG_LNK,'','','Indicazione percorso trasferta','','');
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
    end;

    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
    // il percorso trasferta è ora un link sempre attivo
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('C_PERCORSO'),0,DBG_LNK,'','','Indicazione percorso trasferta','','');
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
  end;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('C_RIMBORSI'),0,DBG_LBL,'','','','','',False);
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

  // imposta tabella anticipi
  W032DM.selM160.Open; // apertura dataset fittizia per creazione cds
  with grdAnticipi do
  begin
    medpCreaCDS;
    medpEliminaColonne;
    medpAggiungiColonna('DBG_COMANDI','','',nil);
    medpAggiungiColonna('CODICE','Codice','',nil);
    medpColonna('CODICE').Visible:=False;
    medpAggiungiColonna('C_DESCRIZIONE','Voce richiesta','',nil);
    medpAggiungiColonna('C_TIPO_QUANTITA','T','',nil);
    medpColonna('C_TIPO_QUANTITA').Visible:=False;
    medpAggiungiColonna('QUANTITA','Quantità','',nil);
    medpAggiungiColonna('C_PERC_ANTICIPO','% spettante','',nil);
    medpAggiungiColonna('NOTE','Note del richiedente','',nil);
    medpAggiungiColonna('C_NOTE_FISSE','Note aziendali','',nil);
    medpInizializzaCompGriglia;
    if (not SolaLettura) and
       (not WR000DM.Responsabile) then
    begin
      // riga inserimento
      medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','Inserisce una nuova richiesta di anticipo','','S');
      medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','Annulla l''inserimento della richiesta di anticipo','','S');
      medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','Conferma l''inserimento della richiesta di anticipo','','D');
      // righe dettaglio
      medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la richiesta di anticipo','Eliminare la voce di anticipo selezionata?','S');
      medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','Modifica la richiesta di anticipo','','D');
      medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','Annulla la modifica della richiesta di anticipo','','S');
      medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','Conferma la modifica della richiesta di anticipo','','D');
    end;
  end;

  // imposta tabella dettaglio giornaliero
  W032DM.selM143.Open; // apertura dataset fittizia per creazione cds
  with grdDettaglioGG do
  begin
    medpCreaCDS;
    medpEliminaColonne;
    medpAggiungiColonna('DBG_COMANDI','','',nil);
    medpAggiungiColonna('DATA','Data','',nil);
    medpAggiungiColonna('TIPO','Tipo','',nil); // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1
    medpAggiungiColonna('DALLE','Ora inizio','',nil);
    medpAggiungiColonna('ALLE','Ora fine','',nil);
    medpAggiungiColonna('NOTE','Note attività','',nil);
    medpInizializzaCompGriglia;
    if (not SolaLettura) and
       (not WR000DM.Responsabile) then
    begin
      // riga inserimento
      medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','Inserisce un nuovo servizio','','S');
      medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','Annulla l''inserimento del servizio','','S');
      medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','Conferma l''inserimento del servizio','','D');
      // righe dettaglio
      medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina il servizio','','S');
      medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','Modifica il servizio','','D');
      medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','Annulla la modifica del servizio','','S');
      medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','Conferma la modifica del servizio','','D');
    end;
  end;

  // imposta tabella rimborsi
  W032DM.selM150.Open; // apertura dataset fittizia per creazione cds
  with grdRimborsi do
  begin
    medpCreaCDS;
    medpEliminaColonne;
    medpAggiungiColonna('DBG_COMANDI','','',nil);
    medpAggiungiColonna('INDENNITA_KM','Ind. Km','',nil);
    medpColonna('INDENNITA_KM').Visible:=False;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
    medpAggiungiColonna('DATA_RIMBORSO','Data rimborso','',nil);
    medpColonna('DATA_RIMBORSO').Visible:=(Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S');
    medpAggiungiColonna('ID_RIMBORSO','(**)ID rimb.','',nil);
    {$WARN SYMBOL_PLATFORM OFF}
    medpColonna('ID_RIMBORSO').Visible:=(DebugHook <> 0) and (Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S');
    {$WARN SYMBOL_PLATFORM ON}
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
    medpAggiungiColonna('CODICE','Codice','',nil);
    medpColonna('CODICE').Visible:=False;
    medpAggiungiColonna('C_DESCRIZIONE','Voce richiesta','',nil);
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.ini
    medpAggiungiColonna('C_TIPO_QUANTITA','T','',nil);
    medpColonna('C_TIPO_QUANTITA').Visible:=False;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.fine
    medpAggiungiColonna('KMPERCORSI','Km percorsi','',nil);
    medpAggiungiColonna('KMPERCORSI_VARIATO','Km autorizzati','',nil);
    medpAggiungiColonna('COD_VALUTA','Valuta','',nil);
    medpAggiungiColonna('RIMBORSO','Rimborso richiesto','',nil);
    medpAggiungiColonna('RIMBORSO_VARIATO','Rimborso autorizzato','',nil);
    medpAggiungiColonna('NOTE','Note','',nil);
    medpInizializzaCompGriglia;
    if (not SolaLettura) and
       (not WR000DM.Responsabile) then
    begin
      // riga inserimento
      medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','Inserisce un nuovo rimborso','','S');
      medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','Annulla l''inserimento del rimborso','','S');
      medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','Conferma l''inserimento del rimborso','','D');
      // righe dettaglio
      medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la richiesta di rimborso','Eliminare la voce di rimborso selezionata?','S');
      medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','Modifica la richiesta di rimborso','','D');
      medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','Annulla la modifica della richiesta di rimborso','','S');
      medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','Conferma la modifica della richiesta di rimborso','','D');
    end;
  end;

  // carica i dati delle richieste
  grdRichieste.medpCaricaCDS;

  // nasconde i tab di dettaglio se non ci sono record da autorizzare
  VisTab:=(not WR000DM.Responsabile) or (W032DM.selM140.RecordCount > 0);
  tabMissioni.Tabs[rgDettaglio].Visible:=VisTab;
  if GestAnticipi then
    tabMissioni.Tabs[rgAnticipi].Visible:=VisTab;
  tabMissioni.Tabs[rgDettaglioGG].Visible:=VisTab and (not Parametri.ModuloInstallato['TORINO_CSI']);
  tabMissioni.Tabs[rgRimborsi].Visible:=VisTab;
  tabMissioni.Visible:=VisTab;
  if VisTab then
    tabMissioni.ActiveTab:=rgDettaglio; // ripristina visibilità tab
end;

procedure TW032FRichiestaMissioni.grdMezziRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if not C190RenderCell(ACell,ARow,AColumn,False,False,False) then
    Exit;
end;

//##########################//
//### GESTIONE RICHIESTE ###//
//##########################//

procedure TW032FRichiestaMissioni.PosizionamentoMultiColumnText(PCmb: TMedpIWMultiColumnComboBox; const PValore: String; const PCodLen: Integer);
var
  i: Integer;
begin
  // se il valore è vuoto termina subito impostando Text =''
  if PValore.Trim = '' then
  begin
    // imposta il testo vuoto
    PCmb.Text:='';
  end
  else
  begin
    // effettua ricerca parziale per valore (primi caratteri del testo)
    for i:=0 to PCmb.Items.Count - 1 do
    begin
      if PValore = PCmb.Items[i].RowData[0].Substring(0,PCodLen).Trim then
      begin
        PCmb.ItemIndex:=i;
        Break;
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.CleanMezziTrasporto;
// pulizia grid mezzi di trasporto
var
  i: Integer;
  IWC: TIWCustomControl;
  IWG: TmeIWGrid;
  IWChk: TmeIWCheckBox;
begin
  for i:=0 to grdMezzi.RowCount - 1 do
  begin
    IWC:=grdMezzi.Cell[i,0].Control;
    if Assigned(IWC) then
    begin
      if IWC is TmeIWGrid then
      begin
        IWG:=(IWC as TmeIWGrid);

        // checkbox di selezione del mezzo
        IWChk:=(IWG.Cell[0,0].Control as TmeIWCheckBox);
        IWChk.Checked:=False;
        if @IWChk.OnClick <> nil then
          IWChk.OnClick(IWChk);

        // esamina colonne aggiuntive: targa e motivazione
        if IWG.ColumnCount > 1 then
        begin
          // gestione targa
          IWC:=IWG.Cell[0,1].Control;
          if Assigned(IWC) then
          begin
            AbilitazioneComponente(IWC,False);
            if IWC is TmeIWEdit then
              TmeIWEdit(IWC).Text:='';
          end;
          // gestione motivazione
          if (IWG.ColumnCount > 2) then
          begin
            IWC:=IWG.Cell[0,2].Control;
            if Assigned(IWC) then
            begin
              AbilitazioneComponente(IWC,False);
              if IWC is TmeIWEdit then
                TmeIWEdit(IWC).Text:='';
            end;
          end;
        end
        else if IWC is TmeTIWAdvRadioGroup then
        begin
          (IWC as TmeTIWAdvRadioGroup).ItemIndex:=1;
        end;
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.DBGridColumnClick(ASender:TObject; const AValue:string);
var
  LCheckEstero,Campo,S,Codice,ValoreDatoPers: String;
  i,j,IdRiga,FaseCorr: Integer;
  DatiMezzo: TDatiMezzo;
  IWC: TIWCustomControl;
  IWChk: TmeIWCheckBox;
  IWEdt: TmeIWEdit;
  IWCmb: TMedpIWMultiColumnComboBox;
  DatoPers: TDatoPersonalizzato;
begin
  // prova la locate prima con rowid, quindi con id richiesta
  if not cdsM140.Locate('DBG_ROWID',AValue,[]) then
  begin
    if TryStrToInt(AValue,IdRiga) then
    begin
      if not cdsM140.Locate('ID',IdRiga,[]) then
        Exit;
    end
    else
      Exit;
  end;

  // pulizia grid mezzi trasporto
  CleanMezziTrasporto;

  // posizionamento dataset
  W032DM.selM140.SearchRecord('ROWID',cdsM140.FieldByName('DBG_ROWID').AsString,[srFromBeginning]);

  // carica grid dei dati personalizzati + checkgroup motivazioni e ipotesi trasferte estere
  PopolaDatiPersonalizzati;

  if AValue = '*' then
  begin
    // pulizia dati per inserimento
    CleanRecordRichiesta;

    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    // tappe percorso
    // apre il dataset in modo che sia inizialmente vuoto se non ci sono modifiche in corso
    if not W032DM.selM141.UpdatesPending then
    begin
      W032DM.selM141.Close;
      W032DM.selM141.SetVariable('ID',-1);
      W032DM.selM141.Open;
    end;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

    tabMissioni.Tabs[rgDettaglio].Caption:='Dettaglio trasferta';
    if GestAnticipi then
      tabMissioni.Tabs[rgAnticipi].Caption:='Anticipi';
    tabMissioni.Tabs[rgDettaglioGG].Caption:='Servizi attivi';
    tabMissioni.Tabs[rgRimborsi].Caption:='Rimborsi';

    // pulizia checkbox motivazioni e ipotesi trasferta estera
    cgpMotivEstero.Css:='invisibile';
    cgpIpotesiEstero.Css:='invisibile';
    for i:=0 to cgpMotivEstero.Items.Count - 1 do
      cgpMotivEstero.IsChecked[i]:=False;
    for i:=0 to cgpIpotesiEstero.Items.Count - 1 do
      cgpIpotesiEstero.IsChecked[i]:=False;

    // pulizia dei valori nei dati personalizzati
    for i:=0 to grdDati.RowCount - 1 do
    begin
      // componente di input
      IWC:=grdDati.Cell[i,1].Control;
      if Assigned(IWC) then
      begin
        if IWC is TmeIWEdit then
        begin
          DatoPers:=(TmeIWEdit(IWC).medpTag as TDatoPersonalizzato);
          if DatoPers.ValoreDefault <> '' then
          begin
            // se il valore di default è indicato utilizza questo in ogni caso
            TmeIWEdit(IWC).Text:=DatoPers.ValoreDefault;
          end
          else
          begin
            // valore di default non indicato
            // verifica del caso particolare per cui il dato personalizzato è selezionabile da elenco
            // ma l'elenco ha un solo valore possibile
            if not DatoPers.Elenco then
              TmeIWEdit(IWC).Clear;
          end;
        end
        else if IWC is TmeIWMemo then
        begin
          DatoPers:=(TmeIWMemo(IWC).medpTag as TDatoPersonalizzato);
          if DatoPers.ValoreDefault <> '' then
          begin
            // se il valore di default è indicato utilizza questo in ogni caso
            TmeIWMemo(IWC).Text:=DatoPers.ValoreDefault;
          end
          else
          begin
            // valore di default non indicato
            TmeIWMemo(IWC).Clear;
          end;
        end
        else if IWC is TMedpIWMultiColumnComboBox then
        begin
          IWCmb:=TMedpIWMultiColumnComboBox(IWC);
          DatoPers:=(IWCmb.medpTag as TDatoPersonalizzato);

          // gestione del valore di default
          if DatoPers.ValoreDefault <> '' then
          begin
            // se il valore di default è indicato utilizza questo in ogni caso
            IWCmb.Text:=DatoPers.ValoreDefault;
            // correzione per sincronizzare il Text nel caso di CustomElement non consentito
            if (not IWCmb.CustomElement) and (IWCmb.Text <> '') and (IWCmb.ItemIndex = -1) then
              IWCmb.Text:='';
          end
          else
          begin
            // valore di default non indicato
            IWCmb.Text:='';
              
            // verifica casi particolari di query valore / dato anagrafico personalizzato
            if DatoPers.QueryValore <> '' then
            begin
              // query valore con un solo elemento disponibile: lo seleziona
              if IWCmb.Items.Count = 1 then
                IWCmb.ItemIndex:=0;
            end
            else if DatoPers.DatoAnagrafico <> '' then
            begin
              // dato anagrafico: propone il valore del dato anagrafico attualmente associato al dipendente
              if selAnagrafeW.FindField('T430' + DatoPers.DatoAnagrafico) <> nil then
              begin
                try
                  ValoreDatoPers:=selAnagrafeW.FieldByName('T430' + DatoPers.DatoAnagrafico).AsString;
                  if DatoPers.ElencoTabellare then
                    PosizionamentoMultiColumnText(IWCmb,ValoreDatoPers,DatoPers.LungCodice)
                  else
                    IWCmb.Text:=ValoreDatoPers;
                except
                  // errore nella selezione del dato personalizzato: che fare?
                end;
              end;
            end;
          end;
        end;
      end;
    end;

    //inizializzazione dataset di dettaglio
    W032DM.selM143.Close;
    W032DM.selM143.SetVariable('ID',-1);
    W032DM.selM143.Open;

    // rimborsi
    W032DM.selM150.Close;
    W032DM.selM150.SetVariable('ID',-1);
    W032DM.selM150.Open;

    // anticipi
    W032DM.selM160.Close;
    W032DM.selM160.SetVariable('ID',-1);
    W032DM.selM160.Open;

    // mezzi
    W032DM.selM170.Close;
    W032DM.selM170.SetVariable('ID',-1);
    W032DM.selM170.Open;

    // motivazioni
    W032DM.selM175.Close;
    W032DM.selM175.SetVariable('ID',-1);
    W032DM.selM175.Open;

    FaseCorr:=M140FASE_INIZIALE;
  end
  else
  begin
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    // gestione del percorso: partenza, destinazione e rientro
    // il percorso prevede destinazioni multiple ed è ora salvato su M141
    Richiesta.Partenza:=W032DM.selM140.FieldByName('PARTENZA').AsString;
    Richiesta.ElencoDestinazioni:=W032DM.selM140.FieldByName('ELENCO_DESTINAZIONI').AsString;
    Richiesta.Rientro:=W032DM.selM140.FieldByName('RIENTRO').AsString;
    Richiesta.PercorsoTesto:=W032DM.selM140.FieldByName('C_PERCORSO').AsString;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
    Richiesta.TipoRegistrazione:=W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString;

    // estrae la regola da utilizzare
    LeggiRegolaMissione(W032DM.selM140.FieldByName('DATAA').AsDateTime,False);
    if not RegoleTrovate then
    begin
      // errore bloccante: disabilita tutto
      // dettaglio
      rgDettaglio.medpDisabilitaComponenti;
      // anticipi
      if GestAnticipi then
      begin
        tabMissioni.Tabs[rgAnticipi].Enabled:=False;
        rgAnticipi.medpDisabilitaComponenti;
        grdAnticipi.medpNascondiComandi;
      end;
      // rimborsi
      tabMissioni.Tabs[rgRimborsi].Enabled:=False;
      rgRimborsi.medpDisabilitaComponenti;
      grdRimborsi.medpNascondiComandi;
      // servizi attivi
      tabMissioni.Tabs[rgDettaglioGG].Enabled:=False;
      rgDettaglioGG.medpDisabilitaComponenti;
      grdDettaglioGG.medpNascondiComandi;
    end;

    FaseCorr:=W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger;
    C018.Id:=W032DM.selM140.FieldByName('ID').AsInteger;
    C018.CodIter:=W032DM.selM140.FieldByName('COD_ITER').AsString;

    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    // apre il dataset delle tappe del percorso
    W032DM.selM141.Close;
    W032DM.selM141.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
    W032DM.selM141.Open;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

    // mezzi di trasporto
    W032DM.selM170.Close;
    W032DM.selM170.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
    W032DM.selM170.Open;
    while not W032DM.selM170.Eof do
    begin
      for i:=0 to grdMezzi.RowCount - 1 do
      begin
        if grdMezzi.Cell[i,0].Control is TmeIWGrid then
        begin
          // checkbox
          IWChk:=((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,0].Control as TmeIWCheckBox);
          if IWChk.FriendlyName = W032DM.selM170.FieldByName('CODICE').AsString then
          begin
            IWChk.Checked:=True;
            if @IWChk.OnClick <> nil then
              IWChk.OnClick(IWChk);
            // campo targa / motivazione
            for j:=1 to (grdMezzi.Cell[i,0].Control as TmeIWGrid).ColumnCount - 1 do
            begin
              if (grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,j].Control <> nil then
              begin
                DatiMezzo:=(((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,j].Control as TmeIWEdit).medpTag as TDatiMezzo);
                Campo:=IfThen(DatiMezzo.FlagTarga = 'S','TARGA','MOTIVAZIONE');

                // targa / motivazione
                IWEdt:=((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,j].Control as TmeIWEdit);
                AbilitazioneComponente(IWEdt,True);
                IWEdt.Text:=W032DM.selM170.FieldByName(Campo).AsString;

                // gestione radiogroup spese viaggio
                if (DatiMezzo.FlagMezzoProprio = 'S') and
                   (W032DM.selM140.FieldByName('FLAG_ISPETTIVA').AsString = 'N') then
                begin
                  (grdMezzi.Cell[i + 1,0].Control as TmeTIWAdvRadioGroup).ItemIndex:=IfThen(W032DM.selM170.FieldByName('CORRESPONSIONE_SPESE').AsString = 'S',0,1);
                end;
              end;
            end;
            Break;
          end;
        end;
      end;
      W032DM.selM170.Next;
    end;

    CaricaListe;

    // motivazioni per trasferta estera e dati personalizzati
    if (W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString = 'E') or
       (EsistonoDatiPersonalizzati) then
    begin
      W032DM.selM175.Close;
      W032DM.selM175.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
      W032DM.selM175.Open;
    end;

    // gestione motivazioni e ipotesi trasferte estere
    if W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString = 'E' then
    begin
      LCheckEstero:='';
      // non riapre il dataset selM175
      if W032DM.selM175.RecordCount > 0 then
      begin
        W032DM.selM175.First;
        while not W032DM.selM175.Eof do
        begin
          LCheckEstero:=LCheckEstero + W032DM.selM175.FieldByName('CODICE').AsString + ',';
          W032DM.selM175.Next;
        end;
        LCheckEstero:=Copy(LCheckEstero,1,Length(LCheckEstero) - 1);
        for Codice in LCheckEstero.Split([',']) do
        begin
          for j:=0 to cgpMotivEstero.Values.Count - 1 do
          begin
            if Codice = Trim(Copy(cgpMotivEstero.Values[j],1,5)) then
            begin
              cgpMotivEstero.IsChecked[j]:=True;
              Break;
            end;
          end;
          for j:=0 to cgpIpotesiEstero.Values.Count - 1 do
          begin
            if Codice = Trim(Copy(cgpIpotesiEstero.Values[j],1,5)) then
            begin
              cgpIpotesiEstero.IsChecked[j]:=True;
              Break;
            end;
          end;
        end;
      end;
      cgpMotivEstero.Css:=CssIniCgp;
      cgpIpotesiEstero.Css:=CssIniCgp;
    end
    else
    begin
      cgpMotivEstero.Css:='invisibile';
      cgpIpotesiEstero.Css:='invisibile';
    end;

    // popolamento dati personalizzati
    if EsistonoDatiPersonalizzati then
    begin
      for i:=0 to grdDati.RowCount - 1 do
      begin
        // componente di input
        IWC:=grdDati.Cell[i,1].Control;
        if Assigned(IWC) then
        begin
          if IWC is TmeIWEdit then
          begin
            // valore libero (su una riga)
            DatoPers:=((IWC as TmeIWEdit).medpTag as TDatoPersonalizzato);
            if W032DM.selM175.SearchRecord('CODICE',DatoPers.Codice,[srFromBeginning]) then
              TmeIWEdit(IWC).Text:=W032DM.selM175.FieldByName('VALORE').AsString
            else
              TmeIWEdit(IWC).Clear;
          end
          else if IWC is TmeIWMemo then
          begin
            // valore libero (su più righe)
            DatoPers:=(TmeIWMemo(IWC).medpTag as TDatoPersonalizzato);
            if W032DM.selM175.SearchRecord('CODICE',DatoPers.Codice,[srFromBeginning]) then
              TmeIWMemo(IWC).Text:=W032DM.selM175.FieldByName('VALORE').AsString
            else
              TmeIWMemo(IWC).Clear;
          end
          else if IWC is TMedpIWMultiColumnComboBox then
          begin
            // lista di valori
            IWCmb:=TMedpIWMultiColumnComboBox(IWC);
            DatoPers:=(IWCmb.medpTag as TDatoPersonalizzato);
            if W032DM.selM175.SearchRecord('CODICE',DatoPers.Codice,[srFromBeginning]) then
            begin
              if DatoPers.ElencoTabellare then
                PosizionamentoMultiColumnText(IWCmb,W032DM.selM175.FieldByName('VALORE').AsString,DatoPers.LungCodice)
              else
                IWCmb.Text:=W032DM.selM175.FieldByName('VALORE').AsString;
            end
            else
            begin
              // codice non presente su M175
              IWCmb.Text:='';
            end;
          end;
        end;
      end;
    end;

    // dati anticipo
    if W032DM.selM140.FieldByName('FLAG_TIPOACCREDITO').AsString = '1' then
      rgpAccredito.ItemIndex:=0
    else if W032DM.selM140.FieldByName('FLAG_TIPOACCREDITO').AsString = '2' then
      rgpAccredito.ItemIndex:=1;

    // delegato
    lblDelegato.Visible:=False;
    edtCercaDelegato.Visible:=False;
    cmbDelegato.Visible:=False;
    btnCercaDelegato.Visible:=False;
    chkDelegato.Checked:=not W032DM.selM140.FieldByName('DELEGATO').IsNull;
    chkDelegatoClick(nil);
    if chkDelegato.Checked then
    begin
      edtCercaDelegato.Text:=W032DM.selM140.FieldByName('DELEGATO').AsString; // matricola delegato
      if not W032DM.selM140.FieldByName('DELEGATO').IsNull then
      begin
        btnCercaDelegato.Caption:='Cerca delegato';
        btnCercaDelegatoClick(nil); // ricerca per matricola
      end;
    end;

    // anticipi
    if not W032DM.selM160.UpdatesPending then
    begin
      W032DM.selM160.Close;
      W032DM.selM160.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
      W032DM.selM160.Open;
      if GestAnticipi then
        tabMissioni.Tabs[rgAnticipi].Caption:=Format('Anticipi <span class="contatore_apice">%d</span>',[W032DM.selM160.RecordCount]);
    end;
    grdAnticipi.medpCaricaCDS;

    // dettaglio giornaliero
    if not W032DM.selM143.UpdatesPending then
    begin
      W032DM.selM143.Close;
      W032DM.selM143.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
      W032DM.selM143.Open;
    end;
    if W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger >= M140FASE_CASSA then
      tabMissioni.Tabs[rgDettaglioGG].Caption:=Format('Servizi attivi <span class="contatore_apice">%d</span>',[W032DM.selM143.RecordCount])
    else
      tabMissioni.Tabs[rgDettaglioGG].Caption:='Servizi attivi';
    grdDettaglioGG.medpCaricaCDS;

    // rimborsi
    // 1. stato autorizzazione
    if W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger >= M140FASE_CASSA then
    begin
      S:=W032DM.selM140.FieldByName('F4_STATO').AsString;
      if S = 'S' then
        lblAutRimborsi.Caption:='Autorizzato'
      else if S = 'N' then
        lblAutRimborsi.Caption:='Non autorizzato'
      else
        lblAutRimborsi.Caption:='';
      if W032DM.selM140.FieldByName('F4_RESP').AsString = '(automatico)' then
        lblRespRimborsi.Caption:='automaticamente'
      else
        lblRespRimborsi.Caption:=Format('(%s)',[W032DM.selM140.FieldByName('F4_RESP').AsString]);
    end
    else
    begin
      lblAutRimborsi.Caption:='';
      lblRespRimborsi.Caption:='';
    end;
    // 2. tabella rimborsi
    if W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger >= M140FASE_CASSA then
    begin
      // rimborsi abilitati: riporta conteggio record
      if not W032DM.selM150.UpdatesPending then
      begin
        W032DM.selM150.Close;
        W032DM.selM150.SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
        W032DM.selM150.Open;
        tabMissioni.Tabs[rgRimborsi].Caption:=Format('Rimborsi <span class="contatore_apice">%d</span>',[W032DM.selM150.RecordCount]);
      end;
    end
    else
    begin
      // rimborsi non abilitati: non riporta conteggio record
      tabMissioni.Tabs[rgRimborsi].Caption:='Rimborsi';
    end;
    grdRimborsi.medpCaricaCDS;
  end;

  // abilitazioni dei tab e dei campi
  //***rgDettaglio.medpDisabilitaComponenti;
  for j:=0 to rgDettaglio.ControlCount - 1 do
  begin
    if (rgDettaglio.Controls[j] is TIWCustomControl) then
    begin
      IWC:=TIWCustomControl(rgDettaglio.Controls[j]);
      if not ((IWC = grdDati) or (IWC.Tag = 1)) then
        AbilitazioneComponente(IWC,False);
    end;
  end;

  // tab anticipi
  if GestAnticipi then
  begin
    tabMissioni.Tabs[rgAnticipi].Enabled:=WR000DM.Responsabile or (AValue <> '*');
    rgAnticipi.medpDisabilitaComponenti;
    grdAnticipi.medpNascondiComandi;
  end;
  // tab rimborsi
  // visibile solo da M140FASE_CASSA, anche per autorizzatore
  tabMissioni.Tabs[rgRimborsi].Enabled:={WR000DM.Responsabile or} (FaseCorr >= M140FASE_CASSA);
  rgRimborsi.medpDisabilitaComponenti;
  grdRimborsi.medpNascondiComandi;
  // tab servizi attivi
  // visibile solo da M140FASE_CASSA, anche per autorizzatore
  tabMissioni.Tabs[rgDettaglioGG].Enabled:={WR000DM.Responsabile or} (FaseCorr >= M140FASE_CASSA);
  rgDettaglioGG.medpDisabilitaComponenti;
  grdDettaglioGG.medpNascondiComandi;
end;

procedure TW032FRichiestaMissioni.TrasformaComponenti(const FN:String);
// trasforma i componenti della riga indicata da text a control e viceversa per la grid
var
  DaTestoAControlli,AbilitaDett:Boolean;
  i,c,j,FaseCorr:Integer;
  IWC: TIWCustomControl;
  IWEdt: TmeIWEdit;
  IWLnk: TmeIWLink;
  IWCmb: TmeIWComboBox;
  IWChk: TmeIWCheckBox;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  DaTestoAControlli:=grdRichieste.medpStato <> msBrowse;

  // gestione icone comandi
  with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
  begin
    Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile','align_left');
    if i = 0 then
    begin
      // riga di inserimento
      Cell[0,1].Css:=IfThen(DaTestoAControlli,'align_left','invisibile');
      Cell[0,2].Css:=IfThen(DaTestoAControlli,'align_right','invisibile');
    end
    else
    begin
      // righe di dettaglio
      Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile','align_right');
      Cell[0,2].Css:=IfThen(DaTestoAControlli,'align_left','invisibile');
      Cell[0,3].Css:=IfThen(DaTestoAControlli,'align_right','invisibile');
      Cell[0,4].Css:=IfThen(DaTestoAControlli,'invisibile','align_left');
      Cell[0,5].Css:=IfThen(DaTestoAControlli,'invisibile','align_right');
    end;
  end;

  // abilitazione componenti dettaglio richiesta/anticipo
  AbilitaDett:=False;
  FaseCorr:=M140FASE_INIZIALE; // inizializzazione
  if DaTestoAControlli then
  begin
    FaseCorr:=StrToIntDef(grdRichieste.medpValoreColonna(i,'FASE_CORRENTE'),-1);
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
    // impedisce modifica dettaglio per missione riaperta
    //if (grdRichieste.medpStato = msInsert) or (FaseCorr < M140FASE_CASSA) then
    if ((grdRichieste.medpStato = msInsert) or (FaseCorr < M140FASE_CASSA)) and
       (grdRichieste.medpValoreColonna(i,'MISSIONE_RIAPERTA') <> 'S') then
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine
    begin
      // abilita modifica dettaglio richiesta
      AbilitaDett:=True;
      // esclude la tabella dei dati personalizzati, in quanto già gestita in precedenza
      //rgDettaglio.medpAbilitaComponenti;
      for j:=0 to rgDettaglio.ControlCount - 1 do
      begin
        if (rgDettaglio.Controls[j] is TIWCustomControl) then
        begin
          IWC:=TIWCustomControl(rgDettaglio.Controls[j]);
          if not ((IWC = grdDati) or (IWC.Tag = 1)) then
            AbilitazioneComponente(IWC,AbilitaDett);
        end;
      end;
    end;
    if grdRichieste.medpStato = msEdit then
    begin
      if FaseCorr < M140FASE_CASSA then
      begin
        rgAnticipi.medpAbilitaComponenti;
        grdAnticipi.medpVisualizzaComandi;
        rgpAccreditoClick(rgpAccredito);
      end
      else if FaseCorr = M140FASE_CASSA then (* esiste autorizzazione alla trasferta *)
      begin
        // rimborsi
        rgRimborsi.medpAbilitaComponenti;
        grdRimborsi.medpVisualizzaComandi;
        // servizi attivi
        rgDettaglioGG.medpAbilitaComponenti;
        grdDettaglioGG.medpVisualizzaComandi;
      end;
    end;
  end
  else
  begin
    // dettaglio
    rgDettaglio.medpDisabilitaComponenti;
    // anticipi
    rgAnticipi.medpDisabilitaComponenti;
    grdAnticipi.medpNascondiComandi;
    // rimborsi
    rgRimborsi.medpDisabilitaComponenti;
    grdRimborsi.medpNascondiComandi;
    // servizi attivi
    rgDettaglioGG.medpDisabilitaComponenti;
    grdDettaglioGG.medpNascondiComandi;
  end;

  if DaTestoAControlli then
  begin
    // flag destinazione e flag ispettiva determinano il cod_iter,
    // pertanto possono essere modificati solo in fase di inserimento
    // oppure in modifica se non ci sono anticipi e non ci sono autorizzazioni
    if (grdRichieste.medpStato = msInsert) or ((W032DM.selM160.RecordCount = 0) and (FaseCorr < M140FASE_AUTORIZZAZIONE)) then
    begin
      // protocollo manuale
      if Parametri.CampiRiferimento.C8_W032ProtocolloManuale = 'S' then
      begin
        // checkbox protocollo manuale
        grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','','','');
        c:=grdRichieste.medpIndexColonna('C_PROTOCOLLO_MANUALE');
        grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
        IWChk:=(grdRichieste.medpCompCella(i,c,0) as TmeIWCheckBox);
        IWChk.Name:='chkProtocolloManuale';
        if grdRichieste.medpStato = msInsert then
          IWChk.Checked:=False // default = no
        else
          IWChk.Checked:=grdRichieste.medpValoreColonna(i,'PROTOCOLLO_MANUALE') = 'S';
        IWChk.OnAsyncClick:=chkProtocolloManualeAsyncClick;

        // edit numero protocollo
        grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'10','','','','S');
        c:=grdRichieste.medpIndexColonna('PROTOCOLLO');
        grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
        IWEdt:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit);
        IWEdt.Name:='edtProtocollo';
        C190AbilitaComponente(IWEdt,IWChk.Checked);
        if grdRichieste.medpStato = msEdit then
          IWEdt.Text:=grdRichieste.medpValoreColonna(i,'PROTOCOLLO');
      end;

      // flag destinazione (estero,regione,fuori regione)
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'12','','','','S');
      c:=grdRichieste.medpIndexColonna('C_DESTINAZIONE');
      grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
      IWCmb:=(grdRichieste.medpCompCella(i,c,0) as TmeIWComboBox);
      IWCmb.ItemsHaveValues:=True;
      IWCmb.Items.Add('Regione=R');
      IWCmb.Items.Add('Fuori regione=I');
      IWCmb.Items.Add('Estero=E');
      if grdRichieste.medpStato = msInsert then
        IWCmb.ItemIndex:=0 // default = in regione
      else
        IWCmb.ItemIndex:=max(0,R180IndexFromValue(IWCmb.Items,grdRichieste.medpValoreColonna(i,'FLAG_DESTINAZIONE')));
      IWCmb.OnChange:=cmbFlagDestinazioneChange;
      IWCmb.SetFocus;

      // flag ispettiva
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'2','','','','S');
      c:=grdRichieste.medpIndexColonna('C_ISPETTIVA');
      grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
      IWCmb:=(grdRichieste.medpCompCella(i,c,0) as TmeIWComboBox);
      IWCmb.ItemsHaveValues:=True;
      IWCmb.Items.Add('Sì=S');
      IWCmb.Items.Add('No=N');
      if grdRichieste.medpStato = msInsert then
        IWCmb.ItemIndex:=1 // default = "Non ispettiva"
      else
        IWCmb.ItemIndex:=R180IndexOf(IWCmb.Items,grdRichieste.medpValoreColonna(i,'FLAG_ISPETTIVA'),1);
      IWCmb.OnChange:=cmbIspettivaChange;
    end;

    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
    // impedisce modifica periodo per missione riaperta
    //if AbilitaDett or (R180Between(grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA'),'0','3')) then
    if (AbilitaDett or (R180Between(grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA'),'0','3'))) and
       (grdRichieste.medpValoreColonna(i,'MISSIONE_RIAPERTA') <> 'S') then
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine
    begin
      // data inizio
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
      c:=grdRichieste.medpIndexColonna('DATADA');
      grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
      IWEdt:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit);
      IWEdt.Css:='input_data_dmy dal';
      if grdRichieste.medpStato = msEdit then
        IWEdt.Text:=grdRichieste.medpValoreColonna(i,'DATADA');

      // data fine
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
      c:=grdRichieste.medpIndexColonna('DATAA');
      grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
      IWEdt:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit);
      IWEdt.Css:='input_data_dmy al';
      if grdRichieste.medpStato = msEdit then
        IWEdt.Text:=grdRichieste.medpValoreColonna(i,'DATAA');

      // ora inizio
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
      c:=grdRichieste.medpIndexColonna('ORADA');
      grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
      IWEdt:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit);
      if grdRichieste.medpStato = msEdit then
        IWEdt.Text:=grdRichieste.medpValoreColonna(i,'ORADA');

      // ora fine
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
      c:=grdRichieste.medpIndexColonna('ORAA');
      grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
      IWEdt:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit);
      if grdRichieste.medpStato = msEdit then
        IWEdt.Text:=grdRichieste.medpValoreColonna(i,'ORAA');

      if AbilitaDett then //Non consentita la modifica dopo la prima autorizzazione
      begin
        // tipo missione (parametrizzato a livello aziendale)
        if Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S' then
        begin
          // nota: cfr. OnRenderCell -> la combobox viene nascosta in alcuni casi
          grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'20','','','','S');
          c:=grdRichieste.medpIndexColonna('C_TIPOREGISTRAZIONE');
          grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
          IWCmb:=(grdRichieste.medpCompCella(i,c,0) as TmeIWComboBox);
          IWCmb.ItemsHaveValues:=True;
          IWCmb.Items.Assign(ListaTipiRegistrazione);
          IWCmb.Items.Insert(0,'=');
          if grdRichieste.medpStato = msInsert then
            IWCmb.ItemIndex:=0
          else if grdRichieste.medpStato = msEdit then
            IWCmb.ItemIndex:=max(0,R180IndexFromValue(IWCmb.Items,grdRichieste.medpValoreColonna(i,'TIPOREGISTRAZIONE')));
        end;
      end;
    end;

    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
    // il link per il percorso è sempre visibile
    IWLnk:=(grdRichieste.medpCompCella(i,'C_PERCORSO',0) as TmeIWLink);
    if IWLnk <> nil then
    begin
      if IWLnk.Text = '' then
        IWLnk.Text:='Indicare il percorso';
      // Tag: indica se il percorso è abilitato alla modifica
      //   0 = modifica non abilitata (solo visualizzazione)
      //   1 = modifica abilitata
      IWLnk.Tag:=IfThen(AbilitaDett,1,0);
      IWLnk.OnClick:=imgPercorsoClick;
    end;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
  end
  else
  begin
    if grdRichieste.medpValoreColonna(i,'REVOCABILE') = 'CANC' then
    begin
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('FLAG_DESTINAZIONE')]);
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('FLAG_ISPETTIVA')]);
    end;
    if AbilitaDett then
    begin
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('DATADA')]);
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('DATAA')]);
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('ORADA')]);
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('ORAA')]);
      if Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S' then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_TIPOREGISTRAZIONE')]);
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
      //FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')]);
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
    end;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')]);
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine
  end;
end;

procedure TW032FRichiestaMissioni.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i,c,FaseCorr,FaseLiv,LivAut,CountM143M150: Integer;
  HintDesc,HintDataDesc,Revocabile,TR,StatoRimborsi,StatoM040,MissioneRiaperta: String;
  VisAutorizza,VisAnnulla,VisChiudi,VisRiapri,StatoNegato,VisIconaModificaDatiAut: Boolean;
  IWG: TmeIWGrid;
  IWImg: TmeIWImageFile;
  IWLnk: TmeIWLink;
  procedure ImpostaColRimborsi(const PFase: Integer);
  var
    MeseScarico: String;
    IWLbl: TmeIWLabel;
  begin
    with W032DM.M150F_FILTRORIMBORSI do
    begin
      SetVariable('ID',C018.Id);
      Execute;
      StatoRimborsi:=VarToStr(GetVariable('RESULT'));
      MeseScarico:='';
      if (StatoRimborsi = 'L') and (GetVariable('MESESCARICO') <> null) then
        MeseScarico:=FormatDateTime('mm/yyyy',GetVariable('MESESCARICO'));
    end;

    // imposta colonna "Rimborsi"
    IWLbl:=(grdRichieste.medpCompCella(i,'C_RIMBORSI',0) as TmeIWLabel);
    if StatoRimborsi = 'N' then        // N = nessun rimborso
    begin
      // modifica.ini - daniloc 27.06.2012
      // v. chiamata <68205> (si vuole la dicitura "Liquidati" anche per rimborsi = 0)
      //Css:='invisibile'
      if PFase < M140FASE_CASSA then
        IWLbl.Css:='invisibile'
      else
      begin
        IWLbl.Css:='';
        IWLbl.Caption:='Nessuno';
      end;
      // modifica.fine
    end
    else
    begin
      IWLbl.Css:='';
      if StatoRimborsi = 'A' then      // A = rimborsi da autorizzare
        IWLbl.Caption:='Da autorizzare'
      else if StatoRimborsi = 'D' then // D = rimborsi da liquidare
        IWLbl.Caption:='Da liquidare'
      else if StatoRimborsi = 'L' then // L = rimborsi liquidati
        IWLbl.Caption:='Liquidati' + IfThen(MeseScarico <> '',Format('(%s)',[MeseScarico]));
    end;
  end;
begin
  if WR000DM.Responsabile then
  begin
    // autorizzazione
    for i:=0 to High(grdRichieste.medpCompGriglia) do
    begin
      // iter autorizzativo
      C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
      C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));

      // dettaglio iter
      IWImg:=(grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile);
      IWImg.OnClick:=imgIterClick;
      IWImg.Hint:=C018.LeggiNoteComplete;
      IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);

      // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
      // dettaglio allegati
      if C018.EsisteGestioneAllegati then
      begin
        //Alberto 20/02/2019.Inizio
        (*Attenzione!
          C018.SetIconaAllegati effettua spostamenti sul dataset selTabellaIter (selM140)
          e in questo caso (W032) scatena l'evento onCalcField che cambia i dati di C018
          Per mantenere la situazione uniforme ci si sposta subito sul record di selM140 corrispondente all'id corrente
          in modo che il contesto C018 non si disallinei
        *)
        if W032DM.selM140.SearchRecord('ROWID',IWImg.FriendlyName,[srFromBeginning]) then
        //Alberto 20/02/2019.Fine
        begin
          IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
          if C018.SetIconaAllegati(IWImg) then
            IWImg.OnClick:=imgAllegClick;
        end;
      end;
      // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
      // percorso trasferta
      IWLnk:=(grdRichieste.medpCompCella(i,'C_PERCORSO',0) as TmeIWLink);
      if IWLnk <> nil then
      begin
        IWLnk.OnClick:=imgPercorsoClick;
        IWLnk.Tag:=0; // indica che il percorso non è abilitato alla modifica (impostato in trasformacomponenti)
        IWLnk.Text:=grdRichieste.medpValoreColonna(i,'C_PERCORSO');
      end;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine

      LivAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);
      VisAutorizza:=(not SolaLettura) and
                    (grdRichieste.medpValoreColonna(i,'ID_REVOCA') = '') and
                    (grdRichieste.medpValoreColonna(i,'AUTORIZZ_AUTOMATICA') <> 'S') and
                    (LivAut > 0);

      // imposta la fase, utilizzata successivamente
      FaseCorr:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'FASE_CORRENTE')),-1);
      FaseLiv:=C018.FaseLivello[LivAut];

      // imposta colonna "Rimborsi" e valorizza StatoM040
      ImpostaColRimborsi(FaseCorr);

      // se la missione è già stata caricata ed è in stato D = da liquidare
      // non consente la modifica dell'autorizzazione
      if VisAutorizza then
      begin
        if (grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE') = C018SI) and (StatoRimborsi = 'L') then
        begin
          VisAutorizza:=False;
        end
        else if (FaseCorr = M140FASE_RIMBORSI) and (FaseLiv <= M140FASE_RIMBORSI) and (StatoRimborsi = 'D') then
        begin
          VisAutorizza:=False;
        end
        // VARESE_PROVINCIA - chiamata 82392.ini
        // inibire la possibilità di modificare l'autorizzazione nel caso in cui
        // a) la richiesta è annullata <=> TIPO_RICHIESTA = 'A' oppure
        // b) la missione è chiusa <=> TIPO_RICHIESTA = '6'
        else if grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA') = 'A' then
        begin
          // richiesta annullata
          VisAutorizza:=False;
        end
        else if grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA') = '6' then
        begin
          // richiesta chiusa (già importati i rimborsi su win)
          VisAutorizza:=False;
        end;
        // VARESE_PROVINCIA - chiamata 82392.fine
      end;

      if not VisAutorizza then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
        C018.SetValoriAut(grdRichieste,i,0,0,1,chkAutorizzazioneClick);

      // gestione modifica valori da parte dell'autorizzatore
      if C018.IterModificaValori then
      begin
        // estrae indice colonna
        c:=grdRichieste.medpIndexColonna('DBG_COMANDI');

        // 1. verifica modifica valori al livello corrente
        VisIconaModificaDatiAut:=C018.ModificaValori(LivAut);

        // 2. verifica esistenza dati personalizzati modificabili
        if VisIconaModificaDatiAut then
        begin
          // modifica possibile se ci sono dati personalizzati visibili alla fase del livello corrente
          with W032DM.selM025 do
          begin
            Filtered:=False;
            try
              Filter:=Format('(CATEGORIA <> ''%s'') and (CATEGORIA <> ''%s'') and (%s >= MIN_FASE_MODIFICA_CAT) and (%s <= MAX_FASE_MODIFICA_CAT)',
                             [MISSIONE_COD_CAT_ESTERO_MOTIVAZIONI,MISSIONE_COD_CAT_ESTERO_IPOTESI,FaseLiv.ToString,FaseLiv.ToString]);
              Filtered:=True;
              VisIconaModificaDatiAut:=(RecordCount > 0);
            except
            end;
            Filtered:=False;
          end;
        end;

        // colonna per modifica dati in fase di autorizzazione
        if VisIconaModificaDatiAut then
        begin
          // modifica
          with (grdRichieste.medpCompCella(i,c,0) as TmeIWImageFile) do
          begin
            Hint:='Modifica dati richiesta';
            OnClick:=imgModificaDatiAutClick;
          end;
          // annulla
          with (grdRichieste.medpCompCella(i,c,1) as TmeIWImageFile) do
          begin
            Hint:='Annulla modifica dati richiesta';
            OnClick:=imgAnnullaDatiAutClick;
          end;
          // applica
          with (grdRichieste.medpCompCella(i,c,2) as TmeIWImageFile) do
          begin
            Hint:='Conferma modifica dati richiesta';
            OnClick:=imgConfermaDatiAutClick;
          end;
        end;

        // gestione visibilità icona di modifica
        with (grdRichieste.medpCompGriglia[i].CompColonne[c] as TmeIWGrid) do
        begin
          // consente modifica dati se è abilitata al livello della richiesta
          if not VisIconaModificaDatiAut then
            Cell[0,0].Css:='invisibile';
          Cell[0,1].Css:='invisibile';
          Cell[0,2].Css:='invisibile';
        end;
      end;
    end;
  end
  else
  begin
    // richiesta
    if grdRichieste.medpRigaInserimento then
    begin
      (grdRichieste.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
      (grdRichieste.medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
      (grdRichieste.medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgConfermaClick;
      with (grdRichieste.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:='invisibile';
      end;
    end;
    for i:=IfThen(grdRichieste.medpRigaInserimento,1,0) to High(grdRichieste.medpCompGriglia) do
    begin
      // iter autorizzativo
      C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
      C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));

      // dettaglio iter
      IWImg:=(grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile);
      IWImg.OnClick:=imgIterClick;
      IWImg.Hint:=C018.LeggiNoteComplete;
      IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);

      // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
      // dettaglio allegati
      if C018.EsisteGestioneAllegati then
      begin
        //Alberto 20/02/2019.Inizio
        (*Attenzione!
          C018.SetIconaAllegati effettua spostamenti sul dataset selTabellaIter (selM140)
          e in questo caso (W032) scatena l'evento onCalcField che cambia i dati di C018
          Per mantenere la situazione uniforme ci si sposta subito sul record di selM140 corrispondente all'id corrente
          in modo che il contesto C018 non si disallinei
        *)
        if W032DM.selM140.SearchRecord('ROWID',IWImg.FriendlyName,[srFromBeginning]) then
        //Alberto 20/02/2019.Fine
        begin
          IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
          if C018.SetIconaAllegati(IWImg) then
            IWImg.OnClick:=imgAllegClick;
        end;
      end;
      // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
      // percorso trasferta
      IWLnk:=(grdRichieste.medpCompCella(i,'C_PERCORSO',0) as TmeIWLink);
      if IWLnk <> nil then
      begin
        IWLnk.OnClick:=imgPercorsoClick;
        IWLnk.Tag:=0; // indica che il percorso non è abilitato alla modifica (impostato in trasformacomponenti)
        IWLnk.Text:=grdRichieste.medpValoreColonna(i,'C_PERCORSO');
      end;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine

      // imposta la variabile fase, utilizzata successivamente
      FaseCorr:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'FASE_CORRENTE')),-1);

      // imposta colonna "Rimborsi"
      ImpostaColRimborsi(FaseCorr);

      // stato della missione collegata (se esistente)
      StatoM040:='';
      W032DM.selM040.SetVariable('ID',C018.Id);
      W032DM.selM040.Execute;
      if W032DM.selM040.RowCount > 0 then
        StatoM040:=W032DM.selM040.FieldAsString(0);

      if (grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil) then
      begin
        case FaseCorr of
          M140FASE_INIZIALE..M140FASE_AUTORIZZAZIONE:
            HintDesc:=' di trasferta/anticipi';
          M140FASE_CASSA:
            HintDesc:=' di rimborsi';
          else
            HintDesc:='';
        end;
        HintDataDesc:=Format(' del %s',[grdRichieste.medpValoreColonna(i,'DATADA')]);
        HintDesc:=HintDesc + HintDataDesc;
        // cancella
        with (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile) do
        begin
          Hint:=Hint + HintDesc;
          OnClick:=imgCancellaClick;
        end;
        // modifica
        with (grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile) do
        begin
           Hint:=Hint + HintDesc;
          OnClick:=imgModificaClick;
        end;
        // annulla
        with (grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile) do
        begin
          Hint:=Hint + HintDesc;
          OnClick:=imgAnnullaClick;
        end;
        // applica
        with (grdRichieste.medpCompCella(i,0,3) as TmeIWImageFile) do
        begin
          Hint:=Hint + HintDesc;
          OnClick:=imgConfermaClick;
        end;
        // annulla missione
        with (grdRichieste.medpCompCella(i,0,4) as TmeIWImageFile) do
        begin
          Hint:=Hint + HintDataDesc;
          OnClick:=imgAnnullaMissioneClick;
        end;
        // chiusura missione
        with (grdRichieste.medpCompCella(i,0,5) as TmeIWImageFile) do
        begin
          Hint:=Hint + HintDataDesc;
          OnClick:=imgChiudiMissioneClick;
        end;
        // riapertura missione
        with (grdRichieste.medpCompCella(i,0,6) as TmeIWImageFile) do
        begin
          Hint:=Hint + HintDataDesc;
          OnClick:=imgRiapriMissioneClick;
        end;

        // abilitazione azioni
        IWG:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
        Revocabile:=grdRichieste.medpValoreColonna(i,'REVOCABILE');
        TR:=grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA');
        StatoNegato:=C018.StatoNegato(grdRichieste.medpValoreColonna(i,'AUTORIZZ_UTILE'));
        MissioneRiaperta:=grdRichieste.medpValoreColonna(i,'MISSIONE_RIAPERTA');

        // conta i rimborsi + dettagli gg legati alla richiesta
        // NOTA: le indennità km automatiche sono escluse dal totale
        W032DM.selCountM143M150.SetVariable('ID',C018.Id);
        W032DM.selCountM143M150.Execute;
        CountM143M150:=W032DM.selCountM143M150.FieldAsInteger(0);

        // cancellazione
        if (Revocabile <> 'CANC') or
           (CountM143M150 > 0) or
           ((FaseCorr = M140FASE_CASSA) and (TR >= '4')) or  // controllo aggiunto 21.08.2012
            (FaseCorr > M140FASE_CASSA) then                 // controllo aggiunto 21.08.2012
        begin
          IWG.Cell[0,0].Css:='invisibile';
        end;

        // modifica impedita se esiste una autorizzazione negata
        if (StatoNegato) or
           ((FaseCorr = M140FASE_AUTORIZZAZIONE) or (FaseCorr > M140FASE_CASSA)) or
           ((FaseCorr = M140FASE_CASSA) and (TR >= '4')) then
        begin
          IWG.Cell[0,1].Css:='invisibile';
        end;
        IWG.Cell[0,2].Css:='invisibile';
        IWG.Cell[0,3].Css:='invisibile';

        // annullamento, chiusura missione e riapertura missione
        if StatoNegato then
        begin
          // impediti se esiste autorizzazione negativa
          IWG.Cell[0,4].Css:='invisibile';
          IWG.Cell[0,5].Css:='invisibile';
          IWG.Cell[0,6].Css:='invisibile';
        end
        else
        begin
          // annullamento missione
          VisAnnulla:=(FaseCorr >= M140FASE_CASSA) and (FaseCorr < M140FASE_RIMBORSI) and
                      (CountM143M150 = 0) and
                      (TR <> '6') and
                      (TR <> 'A');
          if not VisAnnulla then
          begin
            IWG.Cell[0,4].Css:='invisibile';
          end;
          // chiusura richiesta rimborsi
          // (TIPO_RICHIESTA = '') se esiste già autorizzazione a fase 1
          VisChiudi:=(FaseCorr >= M140FASE_CASSA) and
                     (FaseCorr < M140FASE_RIMBORSI) and
                     (TR < '4');
          if not VisChiudi then
          begin
            IWG.Cell[0,5].Css:='invisibile';
          end;
          // riapertura missione per rimborsi
          // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
          // la riapertura della missione è ora determinata dal relativo flag
          {
          // *** per il momento si valuta lo stato della missione su M040
          //     verificando che sia D = da liquidare oppure L = liquidata
          VisRiapri:=(Parametri.CampiRiferimento.C8_W032RiapriMissione = 'S') and
                     ((StatoM040 = 'D') or (StatoM040 = 'L')) and
                     (FaseCorr >= M140FASE_RIMBORSI);
          }
          VisRiapri:=MissioneRiaperta = 'S';
          // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
          if not VisRiapri then
          begin
            IWG.Cell[0,6].Css:='invisibile';
          end;
        end;
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo,Valore: String;
  IWLnk: TmeIWLink;
begin
  if not grdRichieste.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  NumColonna:=grdRichieste.medpNumColonna(AColumn);

  // contenuti allineati al centro
  Campo:=grdRichieste.medpColonna(NumColonna).DataField;
  if (Campo <> 'C_PERCORSO') and
     (Campo <> 'D_RESPONSABILE') then
  begin
    ACell.Css:=ACell.Css + ' align_center';
  end;

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow - 1 <= High(grdRichieste.medpCompGriglia)) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
    ACell.Text:='';

    if Campo = 'C_TIPOREGISTRAZIONE' then
    begin
      if (ACell.Control <> nil) and
         (ACell.Control is TmeIWComboBox) then
      begin
        // AOSTA_REGIONE - chiamata 82254.ini
        // mantiene visibile la combobox di selezione tipo missione solo se
        // sono presenti almeno 2 elementi fra cui scegliere
        // (si noti che l'elemento 0 è quello vuoto)
        // altrimenti visualizza il valore nel testo della cella e nasconde la combobox
        if (ACell.Control as TmeIWComboBox).Items.Count <= 2 then
        begin
          (ACell.Control as TmeIWComboBox).Css:='invisibile';
          ACell.Text:=grdRichieste.medpValoreColonna(ARow - 1,Campo);
        end;
        // AOSTA_REGIONE - chiamata 82254.fine
      end;
    end
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    else if Campo = 'C_PERCORSO' then
    begin
      // descrizione percorso limitata a MAX_LENGTH_ELENCO_DESTINAZIONI caratteri
      // il percorso completo è comunque riportato nell'hint
      if ACell.Control = nil then
      begin
        ACell.Hint:='';
        if ACell.Text.Length > MAX_LENGTH_ELENCO_DESTINAZIONI then
        begin
          ACell.Hint:=ACell.Text;
          ACell.Text:=ACell.Text.Substring(0,MAX_LENGTH_ELENCO_DESTINAZIONI) + '...';
        end;
      end
      else if ACell.Control is TmeIWLink then
      begin
        IWLnk:=TmeIWLink(ACell.Control);
        IWLnk.Hint:='';
        if Length(IWLnk.Text) > MAX_LENGTH_ELENCO_DESTINAZIONI then
        begin
          IWLnk.Hint:=IWLnk.Text;
          IWLnk.Text:=Copy(IWLnk.Text,1,MAX_LENGTH_ELENCO_DESTINAZIONI) + '...';
        end;
      end;
    end;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
  end;

  // impostazione css particolari
  if (ARow > 0) and (ARow - 1 <= High(grdRichieste.medpCompGriglia)) then
  begin
    // richieste annullate: colore font grigio
    if grdRichieste.medpValoreColonna(ARow - 1,'TIPO_RICHIESTA') = 'A' then
      ACell.Css:=ACell.Css + ' font_grigio';

    if (ACell.Control = nil) then
    begin
      // autorizzazione fase 1 / fase 4
      if (Campo = 'F1_STATO') or (Campo = 'F4_STATO') then
      begin
        Valore:=grdRichieste.medpValoreColonna(ARow - 1,Campo);
        ACell.Css:=ACell.Css + ' font_grassetto align_center' +
                   IfThen(Valore = C018NO,' font_rosso');
        if Valore = '' then
          ACell.Text:=''
        else if Valore = C018NO then
          ACell.Text:='No'
        else
          ACell.Text:='Si';
      end
      else if Campo = 'D_TIPO_RICHIESTA' then
      begin
        ACell.Text:=ACell.Text.Replace('TR:','<abbr title="Tipo richiesta">TR</abbr>:',[])
                    .Replace('FC:','<abbr title="Fase corrente">FC</abbr>:',[])
                    .Replace('FL:','<abbr title="Fase livello">FL</abbr>:',[]);
        ACell.RawText:=True;
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.chkProtocolloManualeAsyncClick(Sender: TObject; EventParams: TStringList);
var
  LIWC: TComponent;
begin
  LIWC:=Self.FindComponent('edtProtocollo');

  if Assigned(LIWC) then
  begin
    C190AbilitaComponente((LIWC as TmeIWEdit),(Sender as TmeIWCheckBox).Checked);
    //(LIWC as TmeIWEdit).Invalidate;
  end;
end;

procedure TW032FRichiestaMissioni.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_DISPONIBILE4));
    Exit;
  end;
  VisualizzaDettagli(Sender);
end;

// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
procedure TW032FRichiestaMissioni.imgAllegClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_DISPONIBILE4),ESCLAMA);
    Exit;
  end;
  VisualizzaAllegati(Sender);
end;
// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

// CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.ini
procedure TW032FRichiestaMissioni.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    // imposta a nil il puntatore al frame del percorso quando ne viene effettuata la free
    if AComponent = W032PercorsoFM then
    begin
      W032PercorsoFM:=nil;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.imgPercorsoClick(Sender: TObject);
// apre il frame di gestione del percorso della trasferta
var
  FN: String;
  AbilitaModifica: Boolean;
begin
  FN:=(Sender as TmeIWLink).FriendlyName;
  AbilitaModifica:=(Sender as TmeIWLink).Tag = 1;

  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);

  // verifica esistenza richiesta
  if grdRichieste.medpStato = msEdit then
  begin
    if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_DISPONIBILE4),ESCLAMA);
      Exit;
    end;
  end;

  // crea frame gestione percorso
  try
    W032PercorsoFM:=TW032FPercorsoFM.Create(Self);
    FreeNotification(W032PercorsoFM);
    W032PercorsoFM.AbilitaModifica:=AbilitaModifica;
    W032PercorsoFM.W032DM:=W032DM;
    W032PercorsoFM.Inserimento:=grdRichieste.medpStato = msInsert;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    // la destinazione è ora multipla, su tabella M141
    W032PercorsoFM.PercorsoInfo.Partenza.CodLocalita:=Richiesta.Partenza;
    W032PercorsoFM.PercorsoInfo.ElencoDestinazioni:=Richiesta.ElencoDestinazioni;
    W032PercorsoFM.PercorsoInfo.Rientro.CodLocalita:=Richiesta.Rientro;
    W032PercorsoFM.PercorsoInfo.FlagDestinazione:=Richiesta.FlagDestinazione;
    W032PercorsoFM.PercorsoInfo.FlagPercorso:=Richiesta.FlagPercorso;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
    W032PercorsoFM.Visualizza;
  except
    on E: Exception do
    begin
      W032PercorsoFM:=nil;
      MsgBox.MessageBox(Format('Errore durante l''apertura dell''editor del percorso trasferta:'#13#10'%s (%s)',
                               [E.Message,E.ClassName]),ESCLAMA);
    end;
  end;
end;

procedure TW032FRichiestaMissioni.ConfermaPercorso(PPercorsoInfo: TPercorsoInfo);
// conferma i dati del percorso della trasferta
var
  r, idx: Integer;
  IWCmb: TmeIWComboBox;
begin
  Richiesta.Partenza:=PPercorsoInfo.Partenza.CodLocalita;
  // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
  // la destinazione è ora multipla, su tabella M141
  // Richiesta.Destinazione:=PPercorsoInfo.Destinazione;
  Richiesta.ElencoDestinazioni:=PPercorsoInfo.ElencoDestinazioni;
  // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
  Richiesta.Rientro:=PPercorsoInfo.Rientro.CodLocalita;
  Richiesta.FlagDestinazione:=PPercorsoInfo.FlagDestinazione;
  Richiesta.FlagPercorso:=PPercorsoInfo.FlagPercorso;

  // aggiorna la vista
  if grdRichieste.medpStato <> msBrowse then
  begin
    // determina la riga da aggiornare
    if grdRichieste.medpStato = msInsert then
      r:=0
    else
      r:=grdRichieste.medpRigaDiCompGriglia(W032DM.selM140.RowId);

    // 1. flag destinazione
    // itemindex della combobox flag destinazione
    if Richiesta.FlagDestinazione = 'R' then
      idx:=0
    else if Richiesta.FlagDestinazione = 'I' then
      idx:=1
    else if Richiesta.FlagDestinazione = 'E' then
      idx:=2
    else
      idx:=-1;
    // aggiorna il flag destinazione in tabella
    try
      if idx > -1 then
      begin
        IWCmb:=(grdRichieste.medpCompCella(r,'C_DESTINAZIONE',0) as TmeIWComboBox);
        if Assigned(IWCmb) then
        begin
          IWCmb.ItemIndex:=idx;
          cmbFlagDestinazioneChange(IWCmb);
        end;
      end;
    except
      // nessuna modifica se ci sono errori
    end;

    // 2. percorso
    try
      (grdRichieste.medpCompCella(r,'C_PERCORSO',0) as TmeIWLink).Text:=PPercorsoInfo.Testo;
    except
      // nessuna modifica se ci sono errori
    end;
  end;
end;

// CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
procedure TW032FRichiestaMissioni.AnnullaPercorso;
// annulla le modifiche ai dati del percorso della trasferta,
// ripristinando la situazione originale
var
  r: Integer;
begin
  // AOSTA_REGIONE - chiamata 88372.ini
  // bugfix: in fase di inserimento l'annullamento del percorso
  // deve pulire i relativi dati del record Richiesta
  if grdRichieste.medpStato = msInsert then
  begin
    Richiesta.Partenza:='';
    Richiesta.ElencoDestinazioni:='';
    Richiesta.Rientro:='';
    Richiesta.FlagDestinazione:='';
    Richiesta.FlagPercorso:='';
  end;
  // AOSTA_REGIONE - chiamata 88372.fine

  // aggiorna la vista
  if grdRichieste.medpStato <> msBrowse then
  begin
    // determina la riga da aggiornare
    if grdRichieste.medpStato = msInsert then
      r:=0
    else
      r:=grdRichieste.medpRigaDiCompGriglia(W032DM.selM140.RowId);

    // ripristina il percorso
    try
      (grdRichieste.medpCompCella(r,'C_PERCORSO',0) as TmeIWLink).Text:=IfThen(Richiesta.PercorsoTesto = '','Indicare il percorso',Richiesta.PercorsoTesto);
    except
      // nessuna modifica se ci sono errori
    end;
  end;
end;
// CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

function TW032FRichiestaMissioni.CtrlSalvaDatiPersonalizzati(var RErrMsg: String): Boolean;
// funzione di controllo dei dati personalizzati
// - verifica i dati (obbligatorietà, formato, ecc...)
// - memorizza le informazioni nella struttura dati TRichiesta passata come parametro
// restituisce True se i controlli sono andati a buon fine, False altrimenti
var
  i: Integer;
  Valore: String;
  IWC: TIWCustomControl;
  IWCmb: TMedpIWMultiColumnComboBox;
  DatoPers: TDatoPersonalizzato;
begin
  Result:=False;
  if Richiesta.DatiPers <> nil then
    FreeAndNil(Richiesta.DatiPers);
  Richiesta.DatiPers:=TDictionary<String,TDatoPersonalizzato>.Create;
  RErrMsg:='';

  for i:=0 to grdDati.RowCount - 1 do
  begin
    // estrae il componente di input da analizzare
    IWC:=grdDati.Cell[i,1].Control;
    if Assigned(IWC) then
    begin
      DatoPers:=nil;
      if IWC is TmeIWEdit then
      begin
        // valore libero (su una righe)
        Valore:=Trim((IWC as TmeIWEdit).Text);
        DatoPers:=((IWC as TmeIWEdit).medpTag as TDatoPersonalizzato);
        DatoPers.ValoreStr:=Valore;
        if DatoPers.Obbligatorio then
        begin
          if Valore = '' then
          begin
            RErrMsg:=Format('L''indicazione del dato %s è obbligatoria!',[DatoPers.Descrizione]);
            IWC.SetFocus;
            Exit;
          end;
        end;
        if (DatoPers.LungMax > 0) and
           (Valore.Length > DatoPers.LungMax) then
        begin
          RErrMsg:=Format('Il dato %s può contenere al massimo %d caratteri!'#13#10'(lunghezza corrente: %d)',[DatoPers.Descrizione,DatoPers.LungMax,Valore.Length]);
          IWC.SetFocus;
          Exit;
        end;
      end
      else if IWC is TmeIWMemo then
      begin
        // valore libero (su più righe)
        Valore:=Trim((IWC as TmeIWMemo).Text);
        DatoPers:=((IWC as TmeIWMemo).medpTag as TDatoPersonalizzato);
        DatoPers.ValoreStr:=Valore;
        if DatoPers.Obbligatorio then
        begin
          if Valore = '' then
          begin
            RErrMsg:=Format('L''indicazione del dato %s è obbligatoria!',[DatoPers.Descrizione]);
            IWC.SetFocus;
            Exit;
          end;
        end;
        if (DatoPers.LungMax > 0) and
           (Valore.Length > DatoPers.LungMax) then
        begin
          RErrMsg:=Format('Il dato %s può contenere al massimo %d caratteri!'#13#10'(lunghezza corrente: %d)',[DatoPers.Descrizione,DatoPers.LungMax,Valore.Length]);
          IWC.SetFocus;
          Exit;
        end;
      end
      else if IWC is TMedpIWMultiColumnComboBox then
      begin
        // combo di selezione valori
        IWCmb:=(IWC as TMedpIWMultiColumnComboBox);
        DatoPers:=(IWCmb.medpTag as TDatoPersonalizzato);

        // salva il valore
        if DatoPers.ElencoTabellare then
          Valore:=IWCmb.Text.Substring(0,DatoPers.LungCodice).Trim
        else
          Valore:=IWCmb.Text.Trim;
        DatoPers.ValoreStr:=Valore;

        // controllo dato obbligatorio
        if DatoPers.Obbligatorio then
        begin
          if Valore = '' then
          begin
            RErrMsg:=Format('E'' necessario selezionare un valore per il dato %s!',[DatoPers.Descrizione]);
            IWC.SetFocus;
            Exit;
          end;
        end;
      end;

      // aggiunge le meta informazioni al dictionary dei dati personalizzati
      if DatoPers <> nil then
      begin
        Richiesta.DatiPers.Add(DatoPers.Codice,DatoPers);
      end;
    end;
  end;

  // controlli ok
  Result:=True;
end;

function TW032FRichiestaMissioni.ControlliOK(const FN: String):Boolean;
var
  i,j,MezziSel,OraDaTemp,OraATemp: Integer;
  IWC: TIWCustomControl;
  Valore, NomeMezzo, ErroreMezzoAmmi, ErroreDatiPersonalizzati: String;
  DatiMezzo: TDatiMezzo;
  PeriodoVariato, Ok: Boolean;
begin
  Result:=False;
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  if (grdRichieste.medpStato <> msInsert) and (not R180Between(grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA'),'0','3')) then
  begin
    // se richiesta in fase >= 1 i controlli non devono essere effettuati
    Result:=True;
    Exit;
  end;

  // flag destinazione + ispettiva
  // modifica per ricalcolo coditer.ini
  if grdRichieste.medpStato in [msInsert,msEdit] then
  begin
    // protocollo manuale
    if Parametri.CampiRiferimento.C8_W032ProtocolloManuale = 'S' then
    begin
      // checkbox protocollo manuale
      IWC:=grdRichieste.medpCompCella(i,'C_PROTOCOLLO_MANUALE',0);
      if Assigned(IWC) then
      begin
        Richiesta.ProtocolloManuale:=IfThen((IWC as TmeIWCheckBox).Checked,'S','N');
      end
      else
      begin
        Richiesta.ProtocolloManuale:=W032DM.selM140.FieldByName('PROTOCOLLO_MANUALE').AsString;
      end;

      // numero di protocollo
      Richiesta.Protocollo:='';
      if Richiesta.ProtocolloManuale = 'S' then
      begin
        IWC:=grdRichieste.medpCompCella(i,'PROTOCOLLO',0);
        if Assigned(IWC) then
        begin
          Richiesta.Protocollo:=Trim((IWC as TmeIWEdit).Text);
          if Richiesta.Protocollo = '' then
          begin
            MsgBox.MessageBox('Indicare il numero di protocollo!',INFORMA);
            ActiveControl:=IWC;
            Exit;
          end;
        end;
      end;
    end
    else
    begin
      Richiesta.ProtocolloManuale:='N';
      Richiesta.Protocollo:='';
    end;

    IWC:=grdRichieste.medpCompCella(i,'C_DESTINAZIONE',0);
    if Assigned(IWC) then
    begin
      case (IWC as TmeIWComboBox).ItemIndex of
        0: Richiesta.FlagDestinazione:='R';
        1: Richiesta.FlagDestinazione:='I';
        2: Richiesta.FlagDestinazione:='E';
      end;
    end
    else
    begin
      Richiesta.FlagDestinazione:=W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString;
    end;

    IWC:=grdRichieste.medpCompCella(i,'C_ISPETTIVA',0);
    if IWC <> nil then
    begin
      Richiesta.FlagIspettiva:=(IWC as TmeIWComboBox).Items.ValueFromIndex[(IWC as TmeIWComboBox).ItemIndex];
    end
    else
    begin
      Richiesta.FlagIspettiva:=W032DM.selM140.FieldByName('FLAG_ISPETTIVA').AsString;
    end;
  end;
  // modifica per ricalcolo coditer.fine

  // data inizio
  IWC:=grdRichieste.medpCompCella(i,'DATADA',0);
  Valore:=(IWC as TmeIWEdit).Text;
  if Valore = '' then
  begin
    MsgBox.MessageBox('Indicare la data di inizio della trasferta!',INFORMA);
    ActiveControl:=IWC;
    Exit;
  end;
  if not TryStrToDateTime(Valore,Richiesta.DataDa) then
  begin
    MsgBox.MessageBox('La data di inizio della trasferta non è valida!',INFORMA);
    ActiveControl:=IWC;
    Exit;
  end;

  // data fine
  IWC:=grdRichieste.medpCompCella(i,'DATAA',0);
  Valore:=(IWC as TmeIWEdit).Text;
  if Valore = '' then
  begin
    MsgBox.MessageBox('Indicare la data di fine della trasferta!',INFORMA);
    ActiveControl:=IWC;
    Exit;
  end;
  if not TryStrToDateTime(Valore,Richiesta.DataA) then
  begin
    MsgBox.MessageBox('La data di fine della trasferta non è valida!',INFORMA);
    ActiveControl:=IWC;
    Exit;
  end;

  // coerenza periodo
  if Richiesta.DataDa > Richiesta.DataA then
  begin
    MsgBox.MessageBox('Il periodo della trasferta non è valido!',INFORMA);
    ActiveControl:=IWC;
    Exit;
  end;

  // ora inizio
  IWC:=grdRichieste.medpCompCella(i,'ORADA',0);
  Valore:=(IWC as TmeIWEdit).Text;
  if Valore = '' then
  begin
    MsgBox.MessageBox('Indicare l''ora di inizio della trasferta!',INFORMA);
    ActiveControl:=IWC;
    Exit;
  end;
  try
    R180OraValidate(Valore);
  except
    on E:Exception do
    begin
      MsgBox.MessageBox(E.Message,INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;
  end;
  Richiesta.OraDa:=Valore;

  // ora fine
  IWC:=grdRichieste.medpCompCella(i,'ORAA',0);
  Valore:=(IWC as TmeIWEdit).Text;
  if Valore = '' then
  begin
    MsgBox.MessageBox('Indicare l''ora di fine della trasferta!',INFORMA);
    ActiveControl:=IWC;
    Exit;
  end;
  try
    R180OraValidate(Valore);
  except
    on E:Exception do
    begin
      MsgBox.MessageBox(E.Message,INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;
  end;
  Richiesta.OraA:=Valore;

  // verifica richiesta duplicata
  if grdRichieste.medpStato in [msInsert,msEdit] then
  begin
    with W032DM.selM040PK do
    begin
      SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      if grdRichieste.medpStato in [msEdit] then
        SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger)
      else
        SetVariable('ID',-1);
      SetVariable('DATADA',Richiesta.DataDa);
      SetVariable('ORADA',Richiesta.OraDa);
      SetVariable('PARTENZA',Richiesta.Partenza);
      SetVariable('ELENCO_DEST',Richiesta.ElencoDestinazioni);
      SetVariable('RIENTRO',Richiesta.Rientro);
      Execute;
      if FieldAsInteger(0) > 0 then
      begin
        MsgBox.MessageBox('Esiste già una missione con stessa data e ora di partenza e stesso percorso!',INFORMA);
        Exit;
      end;
    end;
  end;

  // coerenza ora inizio - fine se la trasferta è in giornata
  OraDaTemp:=R180OreMinutiExt(Richiesta.OraDa);
  OraATemp:=R180OreMinutiExt(Richiesta.OraA);
  if (Richiesta.DataDa = Richiesta.DataA) and
     (OraDaTemp > OraATemp) then
  begin
    MsgBox.MessageBox('Il periodo orario della trasferta non è corretto!',INFORMA);
    ActiveControl:=IWC;
    Exit;
  end;

  // controlli in fase di modifica
  if grdRichieste.medpStato = msEdit then
  begin
    // in fase di modifica imposta anche il tipo registrazione, in modo che se si saltano
    // i controlli successivi sia correttamente impostato per l'update
    Richiesta.TipoRegistrazione:=W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString;

    PeriodoVariato:=(Richiesta.DataDa <> W032DM.selM140.FieldByName('DATADA').AsDateTime) or
                    (Richiesta.OraDa <> W032DM.selM140.FieldByName('ORADA').AsString) or
                    (Richiesta.DataA <> W032DM.selM140.FieldByName('DATAA').AsDateTime) or
                    (Richiesta.OraA <> W032DM.selM140.FieldByName('ORAA').AsString);

    // controlli in caso di periodo missione modificato
    if PeriodoVariato then
    begin
      try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; ControlliOK.PeriodoVariato',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
      // se i rimborsi sono dettagliati impedisce conferma se sono presenti rimborsi
      // con date successive alla nuova data di fine missione
      if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
      begin
        with W032DM.selM150 do
        begin
          Filtered:=False;
          Filter:=Format('DATA_RIMBORSO > %s',[FloatToStr(Richiesta.DataA)]);
          Filtered:=True;
          Ok:=RecordCount = 0;
          Filtered:=False;
          if not Ok then
          begin
            Valore:='Impossibile confermare la modifica al periodo della missione,' + CRLF +
                    'in quanto sono presenti rimborsi con date successive' + CRLF +
                    'alla fine della trasferta.';
            MsgBox.MessageBox(Valore,INFORMA);
            Exit;
          end;
        end;
      end;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

      // se ci sono servizi attivi avvisa che saranno rimossi
      if W032DM.selM143.RecordCount > 0 then
      begin
        if W032DM.selM143.GetVariable('ID') <> W032DM.selM140.FieldByName('ID').Value then
        begin
          try RegistraMsg.InserisciMessaggio('I',Format('I servizi attivi non sono allineati con la trasferta. M143.ID = %s; M140.ID = %s',[VarToStr(W032DM.selM143.GetVariable('ID')),W032DM.selM140.FieldByName('ID').AsString]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
          MsgBox.MessageBox('I servizi attivi non sono allineati con la trasferta. Annullare l''operazione!',INFORMA);
          Exit;
        end;
        Valore:='Attenzione!' + CRLF +
                'Il periodo della missione è stato modificato.' + CRLF +
                'I servizi attivi caricati saranno cancellati,' + CRLF +
                'e sarà necessario reinserirli.' + CRLF +
                'Vuoi continuare?';
        Messaggio('Conferma modifica periodo',Valore,CancellaServiziAttivi,nil);
        Exit;
      end;
    end;

    // se è attivo il controllo di validità verifica coerenza periodo con timbrature
    if CtrlValiditaPeriodo then
    begin
      with W032DM.USR_M140F_MSG_PERIODO_INVALIDO do
      begin
        SetVariable('PROGRESSIVO',W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger);
        SetVariable('DATADA',Richiesta.DataDa);
        SetVariable('ORADA',Richiesta.OraDa);
        SetVariable('DATAA',Richiesta.DataA);
        SetVariable('ORAA',Richiesta.OraA);
        Execute;
        Valore:=VarToStr(GetVariable('RESULT'));
        if Valore <> '' then
        begin
          MsgBox.MessageBox(Valore,INFORMA);
          Exit;
        end;
      end;
    end;
  end;

  // se fase >= 0 salta i controlli su altri dati (non sono più modificabili)
  if StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'FASE_CORRENTE')),-1) >= 0 then
  begin
    Result:=True;
    Exit;
  end;

  // tipo missione (tipo registrazione) - SOLO se parametrizzato (VARESE_PROVINCIA)
  if Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S' then
  begin
    IWC:=grdRichieste.medpCompCella(i,'C_TIPOREGISTRAZIONE',0);
    // se non sono presenti elementi consente comunque il salvataggio del tipo missione vuoto
    if ((IWC as TmeIWComboBox).ItemIndex = 0) and ((IWC as TmeIWComboBox).Items.Count > 1) then
    begin
      // se esiste un solo elemento selezionabile (oltre all'elemento vuoto) lo seleziona automaticamente
      if (IWC as TmeIWComboBox).Items.Count = 2 then
      begin
        (IWC as TmeIWComboBox).ItemIndex:=1;
      end
      else
      begin
        MsgBox.MessageBox('Indicare il tipo di trasferta!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end;
    Richiesta.TipoRegistrazione:=(IWC as TmeIWComboBox).Items.ValueFromIndex[(IWC as TmeIWComboBox).ItemIndex];
  end;

  // salva i dati del percorso
  if W032PercorsoFM <> nil then
  begin
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    // la destinazione è ora multipla, su tabella M141
    Richiesta.Partenza:=W032PercorsoFM.PercorsoInfo.Partenza.CodLocalita;
    //Richiesta.Destinazione:=W032PercorsoFM.PercorsoInfo.Destinazione;
    Richiesta.ElencoDestinazioni:=W032PercorsoFM.PercorsoInfo.ElencoDestinazioni;
    Richiesta.Rientro:=W032PercorsoFM.PercorsoInfo.Rientro.CodLocalita;
    Richiesta.PercorsoTesto:=W032PercorsoFM.PercorsoInfo.Testo;
    Richiesta.FlagDestinazione:=W032PercorsoFM.PercorsoInfo.FlagDestinazione;
    Richiesta.FlagPercorso:=W032PercorsoFM.PercorsoInfo.FlagPercorso;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
  end;

  // destinazione obbligatoria
  if Richiesta.ElencoDestinazioni = '' then
  begin
    MsgBox.MessageBox('Indicare almeno una destinazione nel percorso della trasferta!',INFORMA);
    Exit;
  end;

  // controllo dati personalizzati
  if not CtrlSalvaDatiPersonalizzati(ErroreDatiPersonalizzati) then
  begin
    MsgBox.MessageBox(ErroreDatiPersonalizzati,INFORMA);
    Exit;
  end;

  // AOSTA_REGIONE.fine
  // mezzi di trasporto: verifica targa, motivazione...
  MezziSel:=0;
  for i:=0 to grdMezzi.RowCount - 1 do
  begin
    if (grdMezzi.Cell[i,0].Control is TmeIWGrid) and
       (((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,0].Control as TmeIWCheckBox).Checked) then
    begin
      MezziSel:=MezziSel + 1;
      for j:=1 to (grdMezzi.Cell[i,0].Control as TmeIWGrid).ColumnCount - 1 do
      begin
        IWC:=(grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,j].Control;
        if Assigned(IWC) then
        begin
          DatiMezzo:=((IWC as TmeIWEdit).medpTag as TDatiMezzo);
          if DatiMezzo <> nil then
          begin
            Valore:=Trim((IWC as TmeIWEdit).Text);
            NomeMezzo:=((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,0].Control as TmeIWCheckBox).Caption;
            if (DatiMezzo.FlagMotivazione = 'S') and
               ((Valore = '') or (Valore = (IWC as TmeIWEdit).medpWatermark)) then
            begin
              IWC.SetFocus;
              MsgBox.MessageBox(Format('Indicare la motivazione per l''utilizzo del mezzo di trasporto %s!',[NomeMezzo]),INFORMA);
              Exit;
            end
            else if (DatiMezzo.FlagTarga = 'S') and (Valore = '') then
            begin
              IWC.SetFocus;
              MsgBox.MessageBox(Format('Indicare la targa del mezzo di trasporto %s!',[NomeMezzo]),INFORMA);
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;
  if MezziSel = 0 then
  begin
    MsgBox.MessageBox('E'' necessario selezionare almeno un mezzo di trasporto!',INFORMA);
    Exit;
  end;

  // controlli specifici per CUNEO_ASLCN1.ini
  if Parametri.RagioneSociale = 'Azienda Sanitaria Locale CN1' then
  begin
    // per le trasferte con partenza dal domicilio, verifica che non sia selezionato
    // il mezzo di servizio (identificato con FLAG_TARGA = 'S' and FLAG_MEZZO_PROPRIO <> 'S')
    ErroreMezzoAmmi:='';
    if Richiesta.FlagPercorso = M140FLAG_PERCORSO_DOMICILIO then
    begin
      // verifica i mezzi di trasporto selezionati
      for i:=0 to grdMezzi.RowCount - 1 do
      begin
        if (grdMezzi.Cell[i,0].Control is TmeIWGrid) and
           (((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,0].Control as TmeIWCheckBox).Checked) then
        begin
          for j:=1 to (grdMezzi.Cell[i,0].Control as TmeIWGrid).ColumnCount - 1 do
          begin
            IWC:=(grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,j].Control;
            if Assigned(IWC) then
            begin
              DatiMezzo:=((IWC as TmeIWEdit).medpTag as TDatiMezzo);
              if DatiMezzo <> nil then
              begin
                if (DatiMezzo.FlagTarga = 'S') and (DatiMezzo.FlagMezzoProprio <> 'S') then
                begin
                  ErroreMezzoAmmi:=Format('Non è consentito selezionare il mezzo %s per le trasferte dal domicilio!',
                                          [(((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,0].Control as TmeIWCheckBox).Caption)]);
                  Break;
                end;
              end;
            end;
          end;
        end;
      end;
      // errore bloccante se è selezionato il mezzo dell'amministrazione
      if ErroreMezzoAmmi <> '' then
      begin
        MsgBox.MessageBox(ErroreMezzoAmmi,INFORMA);
        Exit;
      end;
    end;
  end;
  // controlli specifici per CUNEO_ASLCN1.fine

  // tab anticipi
  if GestAnticipi then
  begin
    if tabMissioni.Tabs[rgAnticipi].Enabled then
    begin
      // controllo delegato
      if chkDelegato.Checked then
      begin
        if edtCercaDelegato.Visible then
        begin
          MsgBox.MessageBox('E'' necessario cercare il delegato utilizzando l''apposito pulsante!',INFORMA);
          ActiveControl:=edtCercaDelegato;
          Exit;
        end;
        if (cmbDelegato.Items.Count > 1) and
           (cmbDelegato.ItemIndex = 0) then
        begin
          MsgBox.MessageBox('Selezionare il nominativo del delegato dalla lista!',INFORMA);
          ActiveControl:=cmbDelegato;
          Exit;
        end;
        Richiesta.Delegato:=Trim(Copy(cmbDelegato.Text,1,8))
      end
      else
        Richiesta.Delegato:='';
    end;
  end;
  Result:=True;
end;

procedure TW032FRichiestaMissioni.CancellaServiziAttivi;
// cancellazione M143 in seguito a richiesta dopo variazione periodo missione
begin
  try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; CancellaServiziAttivi',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
  // cancella i servizi attivi
  with W032DM.selM143 do
  begin
    First;
    while not Eof do
      Delete;
  end;

  // aggiorna visualizzazione
  grdDettaglioGG.medpCaricaCDS;

  // rieffettua conferma missione
  if imgApplica <> nil then
    imgApplica.OnClick(imgApplica);
end;

procedure TW032FRichiestaMissioni.imgInserisciClick(Sender: TObject);
var
  FN: string;
  i: Integer;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato <> msBrowse then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione di ' +
                      IfThen(grdRichieste.medpStato = msInsert,'inserimento','variazione') +
                      ' in corso prima di procedere!',INFORMA,'Operazione in corso');
    Exit;
  end;

  //Alberto 27/01/2015
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    if grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')] <> nil then
    begin
      if grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')] is TmeIWLink then
        (grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')] as TmeIWLink).OnClick:=nil;
    end;
  end;

  // pulisce i dati
  CleanRecordRichiesta;

  // carica la lista dei tipi registrazione, senza applicare la function M011F_FILTROITER
  CaricaListaTipiRegistrazione;

  grdRichieste.medpStato:=msInsert;
  DBGridColumnClick(Sender,FN);
  tabMissioni.ActiveTab:=rgDettaglio;
  grdRichieste.medpBrowse:=False;
  TrasformaComponenti(FN);
end;

procedure TW032FRichiestaMissioni.imgModificaClick(Sender:TObject);
var
  FN, Errore, DebugMsg: string;
  i:Integer;
begin
  // modifica
  if grdRichieste.medpStato <> msBrowse then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione di ' +
                      IfThen(grdRichieste.medpStato = msInsert,'inserimento','variazione') +
                      ' in corso prima di procedere!',INFORMA,'Operazione in corso');
    Exit;
  end;

  //Alberto 27/01/2015
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    if grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')] <> nil then
    begin
      if grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')] is TmeIWLink then
        (grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_PERCORSO')] as TmeIWLink).OnClick:=nil;
    end;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // verifica presenza richiesta
  W032DM.selM140.Refresh; //sostituire con Refreshrecord?? nooooooo
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox('La richiesta da modificare non è più disponibile!',INFORMA,'Richiesta eliminata');
    Exit;
  end;

  // porta la riga in modifica: trasforma i componenti
  grdRichieste.medpStato:=msEdit;
  DBGridColumnClick(Sender,FN);
  grdRichieste.medpBrowse:=False;
  TrasformaComponenti(FN);

  // se è attiva la gestione automatica del rimborso km e la fase è > M140FASE_CASSA,
  // inserisce o aggiorna il record di rimborso corrispondente
  if (W032DM.RimbAutomatico.Abilitato) and
     (W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger >= M140FASE_CASSA) then
  begin
    if W032DM.CaricaRimborsoAutomatico(RegolaM010.Codice,DebugMsg,Errore) then
    begin
      // rimborso caricato: refresh del dataset e della relativa grid
      W032DM.selM150.Refresh;
      grdRimborsi.medpCaricaCDS;
      tabMissioni.Tabs[rgRimborsi].Caption:=Format('Rimborsi <span class="contatore_apice">%d</span>',[W032DM.selM150.RecordCount]);
    end
    else
    begin
      // rimborso non caricato
      if Errore <> '' then
        GGetWebApplicationThreadVar.ShowMessage('Errore durante l''impostazione del rimborso automatico:'#13#10 + Errore);
    end;
    DebugClear;
    DebugAdd(DebugMsg);
  end
  else
  begin
    // messaggio debug
    DebugAdd(Format('Caricamento indennità km automatica non abilitato su regola (%s) %s, con tipo missione %s',[Parametri.CampiRiferimento.C8_Missione,RegolaM010.Codice,RegolaM010.TipoRegistrazione]));
  end;

  // selezione automatica tab se fase = M140FASE_CASSA
  if (W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger = M140FASE_CASSA) and
     ((tabMissioni.ActiveTab = rgDettaglio) or (tabMissioni.ActiveTab = rgAnticipi)) then
  begin
    tabMissioni.ActiveTab:=rgRimborsi;
  end;
end;

procedure TW032FRichiestaMissioni.imgCancellaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  // verifica presenza richiesta
  W032DM.selM140.Refresh;
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox('La richiesta da cancellare non è più disponibile!',INFORMA,'Richiesta eliminata');
    Exit;
  end;

  DBGridColumnClick(Sender,FN);
  actCancRichiesta(FN);
end;

procedure TW032FRichiestaMissioni.imgAnnullaClick(Sender: TObject);
// annulla le modifiche apportate nei componenti editabili
var
  OldId: Integer;
begin
  // salva id richiesta per successivo riposizionamento
  OldId:=W032DM.selM140.FieldByName('ID').AsInteger;

  // se ci sono operazioni pendenti, annulla eventuali modifiche non salvate
  if grdRichieste.medpStato <> msBrowse then
  begin
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
    if W032DM.selM141.UpdatesPending then
      W032DM.selM141.CancelUpdates;
    // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

    // voci di anticipo
    if W032DM.selM160.UpdatesPending then
      W032DM.selM160.CancelUpdates;

    // dettaglio giornaliero
    if W032DM.selM143.UpdatesPending then
      W032DM.selM143.CancelUpdates;

    // dati rimborso
    if W032DM.selM150.UpdatesPending then
      W032DM.selM150.CancelUpdates;
  end;

  // aggiorna visualizzazione
  VisualizzaDipendenteCorrente;

  // posizionamento sulla richiesta
  DBGridColumnClick(nil,OldId.ToString);
end;

procedure TW032FRichiestaMissioni.imgConfermaClick(Sender: TObject);
var
  FN, MsgErr: String;
  i, FaseCorr: Integer;
begin
  imgApplica:=(Sender as TmeIWImageFile);
  FN:=imgApplica.FriendlyName;

  if (grdRichieste.medpStato = msEdit) then
  begin
    // se il record non esiste -> errore
    if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      grdRichieste.medpStato:=msBrowse;
      TrasformaComponenti(FN);
      MsgBox.MessageBox('Attenzione! La richiesta non è più disponibile:' + CRLF +
                        'potrebbe essere stata eliminata nel frattempo.',INFORMA);
      Exit;
    end;
  end;

  try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgConfermaClick.%s',[W032DM.selM140.FieldByName('ID').AsInteger,IfThen(grdRichieste.medpStato = msInsert,'Insert','Edit')]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;

  // effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;

  // se la tabella degli anticipi è in modifica effettua controlli e conferma
  if grdAnticipi.medpStato <> msBrowse then
  begin
    if Assigned(imgConfermaAnt) then
    begin
      imgConfermaAnt.OnClick(imgConfermaAnt);
      // se ci sono errori in fase di conferma lo stato non viene impostato a msBrowse
      if grdAnticipi.medpStato <> msBrowse then
        Exit;
    end
    else
    begin
      MsgBox.MessageBox('La pagina degli Anticipi è in modifica.'#13#10'Chiudere le modifiche prima di confermare l''intera missione.',ESCLAMA);
      Exit;
    end;
  end
  else
  begin
    //se anticipi non ancora confermati ed è presente l'anticipo pasto, verifica il limite in base al periodo della trasferta
    i:=grdRichieste.medpRigaDiCompGriglia(FN);
    FaseCorr:=StrToIntDef(grdRichieste.medpValoreColonna(i,'FASE_CORRENTE'),-1);
    if (FaseCorr < M140FASE_CASSA) and (W032DM.selM160.SearchRecord('CODICE',CodAnticipoPastoM020,[srFromBeginning])) then
    begin
      // bugfix: se il record è appena stato inserito (Rowid è vuoto) il controllo è già
      //         stato effettuato e non è più necessario
      if W032DM.selM160.RowId <> '' then
      begin
        // effettua controlli bloccanti
        if not CtrlAnticipoOK(W032DM.selM160.Rowid) then
          Exit;

        actModAnticipo(W032DM.selM160.Rowid);
      end;
    end;
  end;

  // se la tabella dei dettagli gg è in modifica effettua controlli e conferma
  if grdDettaglioGG.medpStato <> msBrowse then
  begin
    if Assigned(imgConfermaDettGG) then
    begin
      imgConfermaDettGG.OnClick(imgConfermaDettGG);
      // se ci sono errori in fase di conferma lo stato non viene impostato a msBrowse
      if grdDettaglioGG.medpStato <> msBrowse then
        Exit;
    end
    else
    begin
      MsgBox.MessageBox('La pagina di Servizi attivi è in modifica. Chiudere le modifiche prima di confermare l''intera missione.',ESCLAMA);
      Exit;
    end;
  end;

  // se la tabella dei rimborsi è in modifica effettua controlli e conferma
  if grdRimborsi.medpStato <> msBrowse then
  begin
    // la grid dei rimborsi è in modifica
    if Assigned(imgConfermaRimb) then
    begin
      imgConfermaRimb.OnClick(imgConfermaRimb);
      // se ci sono errori in fase di conferma lo stato non viene impostato a msBrowse
      if grdRimborsi.medpStato <> msBrowse then
        Exit;
    end
    else
    begin
      MsgBox.MessageBox('La pagina dei Rimborsi è in modifica. Chiudere le modifiche prima di confermare l''intera missione.',ESCLAMA);
      Exit;
    end;
  end
  else
  begin
    // la grid dei rimborsi è in modalità browse

    // 1. se è presente il rimborso pasto verifica il limite in base al periodo della trasferta
    if W032DM.selM150.SearchRecord('CODICE',CodRimborsoPastoM020,[srFromBeginning]) then
    begin
      // bugfix: se il record è appena stato inserito (Rowid è vuoto) il controllo è già
      //         stato effettuato e non è più necessario
      //if W032DM.selM150.RowId <> '' then
      begin
        // effettua controlli bloccanti
        if not CtrlRimborsoOK(W032DM.selM150.Rowid) then
          Exit;

        actModRimborso(W032DM.selM150.Rowid);
      end;
    end;
  end;

  // se sono indicate indennità km verifica che la somma sia >= 0
  if not CtrlSommaIndKmOK then
  begin
    MsgBox.MessageBox('La somma dei km richiesti come rimborso non può essere inferiore a 0!',ESCLAMA);
    Exit;
  end;

  // inserimento / aggiornamento
  if grdRichieste.medpStato = msInsert then
    actInsRichiesta
  else
    actModRichiesta(FN);

  // viene eseguita la function oracle personalizzata M140F_CHECKRICHIESTA
  // se il risultato non è nullo, significa che sono presenti errori (non bloccanti):
  // in questo caso visualizzare il messaggio a video un msgbox
  try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgConfermaClick.M140F_CHECKRICHIESTA non bloccante',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
  with W032DM.M140F_CHECKRICHIESTA do
  begin
    try
      SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
      SetVariable('LIVELLO',W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger);
      SetVariable('FASE',W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger);
      SetVariable('CHIUSURA','N');
      Execute;
      MsgErr:=VarToStr(GetVariable('RESULT'));
    except
      on E: Exception do
      begin
        MsgErr:=Format('%s (%s)',[E.Message,E.ClassName]);
      end;
    end;
    if MsgErr <> '' then
    begin
      MsgErr:=Format('Avviso:'#13#10'%s',[MsgErr]);
      MsgBox.MessageBox(MsgErr,INFORMA);
      Exit;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.imgAnnullaMissioneClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // se il record non esiste -> errore
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    grdRichieste.medpStato:=msBrowse;
    TrasformaComponenti(FN);
    MsgBox.MessageBox('Attenzione! La richiesta non è più disponibile:' + CRLF +
                      'potrebbe essere stata eliminata nel frattempo.',INFORMA);
    Exit;
  end;

  // crea frame per conferma annullamento
  W032MotivazioneFM:=TW032FMotivazioneFM.Create(Self);
  W032MotivazioneFM.W032DM:=W032DM;
  W032MotivazioneFM.Visualizza;
end;

procedure TW032FRichiestaMissioni.ConfermaAnnullaMissione(const PMotivazione: String);
begin
  // - se esiste missione su M040 si deve impostare lo stato su 'Da liquidare',
  //   e trasferire gli Anticipi (M060) sui Rimborsi (M050) in modo che passino gli addebiti sullo stipendio
  // - se gli anticipi sono erogati con assegno bancario, è possibile effettuare una restituzione
  //   (lo fa la cassa economale?); in tal caso si deve cambiare lo stato della missione in 'Liquidata'
  //   in modo che non passi più alle paghe;

  // chiude l'iter della richiesta
  with W032DM.selM140 do
  begin
    // salva la motivazione di annullamento
    Edit;
    FieldByName('ANNULLAMENTO').AsString:=PMotivazione;
    Post;

    C018.Id:=FieldByName('ID').AsInteger;
    C018.CodIter:=FieldByName('COD_ITER').AsString;
    C018.InsUltimeAutorizzazioni(C018.LivMaxAut + 1,C018SI,'(automatico)','S','Annullamento richiesta: ' + PMotivazione,True);
    C018.SetTipoRichiesta('A'); // A = annullata
    SessioneOracle.Commit;
  end;

  // esegue procedura m050p_carica_rimborsi_daiter
  with W032DM.M050P_CARICA_RIMBORSI_DAITER do
  begin
    SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
    try
      Execute;
    except
      on E: Exception do
      begin
        Log(ERRORE,'Errore durante annullamento missione',E);
        MsgBox.MessageBox('Errore durante l''annullamento della missione:' + CRLF + E.Message,ESCLAMA);
      end;
    end;
  end;

  // elimina la missione se non ci sono anticipi
  try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; ConfermaAnnullaMissione.delM040',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
  W032DM.delM040.SetVariable('ANNULLAMENTO','S');
  W032DM.delM040.SetVariable('ID',C018.Id);
  W032DM.delM040.Execute;
  SessioneOracle.Commit;

  VisualizzaDipendenteCorrente;
end;

procedure TW032FRichiestaMissioni.imgChiudiMissioneClick(Sender: TObject);
var
  //F1,F2,
  LContaM143: Integer;
  FN: String;
  LErrChiusura: String;
  LErrBloccante: Boolean;
const
  ERRORE_NON_BLOCCANTE = '<NON_BLOCCANTE>';
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // se il record non esiste -> errore
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    grdRichieste.medpStato:=msBrowse;
    TrasformaComponenti(FN);
    MsgBox.MessageBox('Attenzione! La richiesta non è più disponibile:' + CRLF +
                      'potrebbe essere stata eliminata nel frattempo.',INFORMA);
    Exit;
  end;
  DBGridColumnClick(Sender,FN);

  // imposta id e codice struttura su C018
  C018.Id:=W032DM.selM140.FieldByName('ID').AsInteger;
  C018.CodIter:=W032DM.selM140.FieldByName('COD_ITER').AsString;
  try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgChiudiMissioneClick; C8_W032DettaglioGG = %s',[C018.Id,Parametri.CampiRiferimento.C8_W032DettaglioGG]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;

  // AOSTA_REGIONE - chiamata 88372.ini
  // il controllo dettagli giornalieri viene effettuato solo in funzione del parametro aziendale
  // il conteggio dei record avviene ora direttamente con una query su db, senza utilizzare il dataset
  if (Parametri.CampiRiferimento.C8_W032DettaglioGG = 'S'){ and
     (tabMissioni.Tabs[rgDettaglioGG].Visible)} then
  begin
    // conta i servizi attivi con una query
    try
      try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgChiudiMissioneClick.selCountM143',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
      W032DM.selCountM143.SetVariable('ID',C018.Id);
      W032DM.selCountM143.Execute;
      LContaM143:=W032DM.selCountM143.FieldAsInteger(0);
    except
      LContaM143:=0;
    end;

    // impedisce l'avanzamento se non sono presenti record di dettaglio gg
    if LContaM143 = 0 then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('Attenzione!'#13#10'E'' necessario specificare i servizi attivi!',INFORMA);
      Exit;
    end;
  end;
  // AOSTA_REGIONE - chiamata 88372.fine

  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.ini
  // viene eseguita la function oracle personalizzata M140F_CHECKRICHIESTA
  // se il risultato non è nullo, significa che sono presenti errori:
  // in questo caso visualizzare il messaggio a video con msgbox e impedire la chiusura
  try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgChiudiMissioneClick.M140F_CHECKRICHIESTA bloccante',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
  with W032DM.M140F_CHECKRICHIESTA do
  begin
    try
      SetVariable('ID',C018.Id);
      SetVariable('LIVELLO',W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger);
      SetVariable('FASE',W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger);
      SetVariable('CHIUSURA','S');
      Execute;
      LErrChiusura:=VarToStr(GetVariable('RESULT'));
    except
      on E: Exception do
      begin
        LErrChiusura:=Format('%s (%s)',[E.Message,E.ClassName]);
      end;
    end;

    // se il risultato della function non è vuoto significa che sono presenti errori
    if LErrChiusura <> '' then
    begin
      // valuta se l'errore bloccante oppure non
      LErrBloccante:=not LErrChiusura.Contains(ERRORE_NON_BLOCCANTE);

      if LErrBloccante then
      begin
        LErrChiusura:=Format('Attenzione!'#13#10'Il seguente errore impedisce la chiusura della missione:'#13#10'%s',[LErrChiusura]);
        MsgBox.MessageBox(LErrChiusura,ESCLAMA,'Errore chiusura missione');
        Exit;
      end
      else
      begin
        // errore non bloccante: visualizza messagebox di conferma
        LErrChiusura:=Format('Attenzione!'#13#10'%s'#13#10'Confermi la chiusura della missione?',[LErrChiusura.Replace(ERRORE_NON_BLOCCANTE,'',[]).Trim]);
        MsgBox.WebMessageDlg(LErrChiusura,mtConfirmation,[mbYes,mbNo],OnConfermaChiusuraMissione,'','Avviso chiusura missione');
        Exit;
      end;
    end;
  end;
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.fine

  // rende effettiva la chiusura della missione
  EseguiChiusuraMissione;
end;

procedure TW032FRichiestaMissioni.OnConfermaChiusuraMissione(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
// risposta del messaggio modale di conferma chiusura missione
begin
  case Res of
    mrYes:
      begin
        EseguiChiusuraMissione;
        MsgBox.ClearKeys;
      end;
    mrNo:
      MsgBox.ClearKeys;
  end;
end;

procedure TW032FRichiestaMissioni.EseguiChiusuraMissione;
var
  F1: Integer;
  F2: Integer;
begin
  // se non ci sono rimborsi + dettagli chiude automaticamente l'iter
  // effettuando l'importazione su Iriswin
  if W032DM.selM150.RecordCount + W032DM.selM143.RecordCount = 0 then
  begin
    try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; EseguiChiusuraMissione.TipoRichiesta = 5; selM150 + selM143 = 0',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
    C018.SetTipoRichiesta('5');

    // chiude l'iter della richiesta
    F1:=W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger;
    C018.InsUltimeAutorizzazioni(C018.LivMaxAut + 1,C018SI,'(automatico)','S','Chiusura richiesta',True);
    F2:=C018.FaseCorrente;
    if F2 > F1 then
      GestioneFasi(F1,F2);

    // esegue procedura m050p_carica_rimborsi_daiter
    with W032DM.M050P_CARICA_RIMBORSI_DAITER do
    begin
      SetVariable('ID',C018.Id);
      try
        Execute;
      except
        on E: Exception do
        begin
          Log(ERRORE,'Errore durante chiusura missione',E);
          MsgBox.MessageBox('Si è verificato un errore durante la chiusura della missione.' + CRLF + E.Message,ESCLAMA);
        end;
      end;
    end;
    SessioneOracle.Commit;
  end
  else
  begin
    try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; EseguiChiusuraMissione.TipoRichiesta = 4; selM150 + selM143 <> 0',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
    C018.SetTipoRichiesta('4');
    SessioneOracle.Commit;
  end;

  // aggiorna visualizzazione
  VisualizzaDipendenteCorrente;

  // tenta posizionamento sulla richiesta chiusa
  DBGridColumnClick(nil,C018.Id.ToString);
end;

procedure TW032FRichiestaMissioni.imgRiapriMissioneClick(Sender: TObject);
var
  FN: String;
  L, F1, F2, OldId: Integer;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  try RegistraMsg.InserisciMessaggio('I',Format('ROWID = %s; imgRiapriMissioneClick',[FN]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;

  // se il record non esiste -> errore
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    grdRichieste.medpStato:=msBrowse;
    TrasformaComponenti(FN);
    MsgBox.MessageBox('Attenzione! La richiesta non è più disponibile:'#13#10'potrebbe essere stata eliminata nel frattempo.',INFORMA);
    Exit;
  end;
  DBGridColumnClick(Sender,FN);

  C018.Id:=W032DM.selM140.FieldByName('ID').AsInteger;
  C018.CodIter:=W032DM.selM140.FieldByName('COD_ITER').AsString;
  OldId:=C018.Id;

  try
    // fase prima delle operazioni
    F1:=W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger;

    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1 - riesame del 28/10/2014.ini
    //Alberto 06/11/2014: forzo la fase a M140FASE_RIMBORSI per impedire la cancellazione e limitare alla riapertura dei rimborsi
    if F1 > M140FASE_RIMBORSI then
      F1:=M140FASE_RIMBORSI;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1 - riesame del 28/10/2014.fine

    // rimuove autorizzazioni fino al livello della fase rimborsi (incluso)
    // se ci sono più livelli per la fase rimborsi si considera il minore
    for L:=C018.LivMaxAut downto C018.LivelliFase[M140FASE_RIMBORSI].Min do
    begin
      C018.SetStato('',L);
      C018.SetAutorizzAutomatica('',L);
    end;
    C018.SetAutorizzAutomatica('',0);  //Resetto flag di autorizzazioen automatica sulla T850

    // riporta tipo_richiesta a '0', in modo che il dipendente possa modificare i rimborsi
    C018.SetTipoRichiesta('0');

    // fase dopo le operazioni
    F2:=C018.FaseCorrente;

    // operazioni se la fase finale è minore di quella iniziale (dovrebbe sempre verificarsi questa situazione)
    if F2 < F1 then
    begin
      try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; imgRiapriMissioneClick.GestioneFasi;',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
      GestioneFasi(F1,F2,True);
    end;

    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
    // imposta il flag di missione riaperta a 'N'
    W032DM.updM140Riapri.SetVariable('ID',C018.Id);
    W032DM.updM140Riapri.SetVariable('MISSIONE_RIAPERTA','N');
    W032DM.updM140Riapri.Execute;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine

    SessioneOracle.Commit;
  except
    // rollback? no, per via delle sessioni oracle condivise
  end;

  // rilegge i dati
  VisualizzaDipendenteCorrente;

  // posizionamento sulla richiesta
  DBGridColumnClick(nil,OldId.ToString);
end;

procedure TW032FRichiestaMissioni.actInsRichiesta;
var
  LErrMsg: String;
// inserimento richiesta missione
begin
  LeggiRegolaMissione(Richiesta.DataA);
  (*se non esistono le regole si esce senza registrare la richiesta*)
  if not RegoleTrovate then
    exit;
  //Eseguo la append se sono in browse: può capitare di essere già in dsInsert per via di chiamata precedente fallita a causa di protocollo non univoco
  if W032DM.selM140.State = dsBrowse then
    W032DM.selM140.Append;

  W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString:=IfThen(Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S',Richiesta.TipoRegistrazione,RegolaM010.TipoRegistrazione);
  // verifica gestione manuale del protocollo
  if Parametri.CampiRiferimento.C8_W032ProtocolloManuale = 'S' then
  begin
    W032DM.selM140.FieldByName('PROTOCOLLO_MANUALE').AsString:=Richiesta.ProtocolloManuale;
    if Richiesta.ProtocolloManuale = 'S' then
    begin
      W032DM.selM140.FieldByName('PROTOCOLLO').AsString:=Richiesta.Protocollo;
    end;
  end;
  W032DM.selM140.FieldByName('FLAG_DESTINAZIONE').AsString:=Richiesta.FlagDestinazione;
  W032DM.selM140.FieldByName('FLAG_ISPETTIVA').AsString:=Richiesta.FlagIspettiva;
  // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
  // il percorso prevede destinazioni multiple ed è ora salvato su M141
  {
  W032DM.selM140.FieldByName('PARTENZA').AsString:=Richiesta.Partenza;
  W032DM.selM140.FieldByName('DESTINAZIONE').AsString:=Richiesta.ElencoDestinazioni;
  W032DM.selM140.FieldByName('RIENTRO').AsString:=Richiesta.Rientro;
  }
  W032DM.selM140.FieldByName('FLAG_PERCORSO').AsString:=Richiesta.FlagPercorso;
  // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
  W032DM.selM140.FieldByName('DATADA').AsDateTime:=Richiesta.DataDa;
  W032DM.selM140.FieldByName('DATAA').AsDateTime:=Richiesta.DataA;
  W032DM.selM140.FieldByName('ORADA').AsString:=Richiesta.OraDa;
  W032DM.selM140.FieldByName('ORAA').AsString:=Richiesta.OraA;
  W032DM.selM140.FieldByName('FLAG_TIPOACCREDITO').AsString:='1'; // default tipo accredito anticipi

  // verifica protocollo univoco M140 + M040
  // in inserimento imposta un id fittizio
  if not W032DM.CtrlProtocolloUnivoco(W032DM.selM140.FieldByName('ID').AsInteger,W032DM.selM140.FieldByName('PROTOCOLLO').AsString,LErrMsg) then
  begin
    MsgBox.MessageBox(LErrMsg, ESCLAMA);
    Exit;
  end;

  // verifica condizioni di validità
  if not C018.WarningRichiesta then
  begin
    Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaInsRichiesta,AnnullaInsRichiesta);
    Exit;
  end;

  ConfermaInsRichiesta;
end;

procedure TW032FRichiestaMissioni.ConfermaInsRichiesta;
var
  i,j,IdIns,F1,F2: Integer;
  Campo, Codice, Valore, ErrMsg: String;
  DatiMezzo: TDatiMezzo;
  IWG: TmeIWGrid;
  IWEdt: TmeIWEdit;
begin
  with W032DM do
  begin
    try
      F1:=0;
      C018.InsRichiesta('0','','');
      if C018.MessaggioOperazione <> '' then
      begin
        selM140.Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end;
      //Alberto 08/02/2012: registro i dati originali del periodo e della data
      C018.Id:=selM140.FieldByName('ID').AsInteger;
      C018.SetDatoAutorizzatore('DATADA',selM140.FieldByName('DATADA').AsString,0);
      C018.SetDatoAutorizzatore('DATAA',selM140.FieldByName('DATAA').AsString,0);
      C018.SetDatoAutorizzatore('ORADA',selM140.FieldByName('ORADA').AsString,0);
      C018.SetDatoAutorizzatore('ORAA',selM140.FieldByName('ORAA').AsString,0);
      F2:=C018.FaseCorrente;
      (*
      if F2 > F1 then
        GestioneFasi(F1,F2);
      *)
      IdIns:=C018.Id;

      // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
      // M141: destinazioni
      // imposta gli ID sul dataset selM141
      selM141.First;
      while not selM141.Eof do
      begin
        selM141.Edit;
        selM141.FieldByName('ID').AsInteger:=C018.Id;
        selM141.Post;
        selM141.Next;
      end;
      // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

      // M170: mezzi di trasporto
      if not selM170.Active then
      begin
        selM170.SetVariable('ID',IdIns);
        selM170.Open;
      end;
      for i:=0 to grdMezzi.RowCount - 1 do
      begin
        if grdMezzi.Cell[i,0].Control is TmeIWGrid then
        begin
          IWG:=(grdMezzi.Cell[i,0].Control as TmeIWGrid);
          if (IWG.Cell[0,0].Control as TmeIWCheckBox).Checked then
          begin
            selM170.Append;
            selM170.FieldByName('ID').AsInteger:=IdIns;
            selM170.FieldByName('CODICE').AsString:=(IWG.Cell[0,0].Control as TmeIWCheckBox).FriendlyName;
            for j:=1 to (grdMezzi.Cell[i,0].Control as TmeIWGrid).ColumnCount - 1 do
            begin
              if IWG.Cell[0,j].Control <> nil then
              begin
                IWEdt:=(IWG.Cell[0,j].Control as TmeIWEdit);
                DatiMezzo:=(IWEdt.medpTag as TDatiMezzo);
                Campo:=IfThen(DatiMezzo.FlagTarga = 'S','TARGA','MOTIVAZIONE');
                selM170.FieldByName(Campo).AsString:=IWEdt.Text;
                // gestione radiogroup spese viaggio
                if (DatiMezzo.FlagMezzoProprio = 'S') and
                   (selM140.FieldByName('FLAG_ISPETTIVA').AsString = 'N') then
                begin
                  selM170.FieldByName('CORRESPONSIONE_SPESE').AsString:=IfThen((grdMezzi.Cell[i + 1,0].Control as TmeTIWAdvRadioGroup).ItemIndex = 0,'S','N');
                end;
              end;
            end;
            selM170.Post;
          end;
        end;
      end;

      // M175: motivazioni per trasferta estera e dati personalizzati
      if (selM140.FieldByName('FLAG_DESTINAZIONE').AsString = 'E') or
         (EsistonoDatiPersonalizzati) then                                     // AOSTA_REGIONE - gestione dati personalizzati
      begin
        if not selM175.Active then
        begin
          selM175.SetVariable('ID',IdIns);
          selM175.Open;
        end;
        // gestione dei dati personalizzati su M175
        if EsistonoDatiPersonalizzati then
        begin
          // dati personalizzati: verifica indicazione dei dati obbligatori
          for Codice in Richiesta.DatiPers.Keys do
          begin
            Valore:=Richiesta.DatiPers[Codice].ValoreStr;
            if Valore <> '' then
            begin
              selM175.Append;
              selM175.FieldByName('ID').AsInteger:=IdIns;
              selM175.FieldByName('CODICE').AsString:=Codice;
              selM175.FieldByName('VALORE').AsString:=Valore;
              selM175.Post;
            end;
          end;
        end;

        // motivazioni per trasferta estera
        if selM140.FieldByName('FLAG_DESTINAZIONE').AsString = 'E' then
        begin
          for i:=0 to cgpMotivEstero.Items.Count - 1 do
          begin
            if cgpMotivEstero.IsChecked[i] then
            begin
              selM175.Append;
              selM175.FieldByName('ID').AsInteger:=IdIns;
              selM175.FieldByName('CODICE').AsString:=cgpMotivEstero.Values[i];
              selM175.Post;
            end;
          end;
          for i:=0 to cgpIpotesiEstero.Items.Count - 1 do
          begin
            if cgpIpotesiEstero.IsChecked[i] then
            begin
              selM175.Append;
              selM175.FieldByName('ID').AsInteger:=IdIns;
              selM175.FieldByName('CODICE').AsString:=cgpIpotesiEstero.Values[i];
              selM175.Post;
            end;
          end;
        end;
      end;

      // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
      // applica e committa su db le modifiche legate al percorso
      // questa operazione è da eseguire prima del ricalcolo del tipo missione
      SessioneOracle.ApplyUpdates([W032DM.selM141],True);
      // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

      // determina i tipi registrazione disponibili in base a M011F_FILTROITER
      // e imposta il primo tipo registrazione disponibile (ordine alfabetico)
      if not RicalcoloTipoMissione(True,ErrMsg) then
      begin
        // impossibile determinare un tipo missione in base alle regole definite dall'utente
        // eliminazione della richiesta appena inserita

        // elimina il record di testata della richiesta
        C018.CodIter:=selM140.FieldByName('COD_ITER').AsString;
        C018.Id:=selM140.FieldByName('ID').AsInteger;
        C018.EliminaIter;

        // elimina fisicamente il record su M040
        try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; ConfermaInsRichiesta.delM040',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
        delM040.SetVariable('ANNULLAMENTO','N');
        delM040.SetVariable('ID',C018.Id);
        delM040.Execute;

        MsgBox.MessageBox('Impossibile confermare la richiesta!'#13#10 +
                          'Non è possibile determinare il tipo missione'#13#10 +
                          'in base ai dati inseriti.'#13#10 +
                          'Per ulteriori informazioni contattare l''ufficio competente',ESCLAMA);

        //si esce subito per lasciare la riga di richiesta ancora pendente con i dati inseriti dall'utente;
        //riconfermando, se il tipo viene trovato, la richiesta viene registrata normalmente.
        SessioneOracle.Commit;
        Exit;
      end;

      // se richiesto esplicitamente tramite parametro aziendale
      // consente la valutazione delle condizioni di autorizzazione automatica
      // anche sui dati nelle tabelle figlie di M140
      if Parametri.CampiRiferimento.C8_W032UpdRichiesta = 'S' then
      begin
        if F2 < M140FASE_AUTORIZZAZIONE then
        begin
          W032DM.selM140.Edit;
          C018.UpdRichiesta('0');
          F2:=C018.FaseCorrente;
        end;
      end;

      // gestione fasi
      if F2 > F1 then
      begin
        try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; ConfermaInsRichiesta.GestioneFasi;',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
        GestioneFasi(F1,F2);
      end;

      // commit
      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        (*
        // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
        // annulla le modifiche legate al percorso
        SessioneOracle.CancelUpdates([W032DM.selM141]);
        // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
        *)
        selM140.Cancel;
        MsgBox.MessageBox('Errore durante l''inserimento della richiesta:'#13#10 +
                          E.Message + IfThen(E.ClassName <> 'Exception',#13#10'Tipo: ' + E.ClassName),ESCLAMA);
        Exit;
      end;
    end;

    C018.Periodo.Estendi(selM140.FieldByName('DATADA').AsDateTime,selM140.FieldByName('DATAA').AsDateTime);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    C018.StrutturaSel:=C018STRUTTURA_TUTTE;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
  end; // end with W032DM

  // rilegge i dati
  VisualizzaDipendenteCorrente;

  // posizionamento su riga appena inserita
  DBGridColumnClick(nil,IntToStr(IdIns));
end;

procedure TW032FRichiestaMissioni.AnnullaInsRichiesta;
begin
  W032DM.selM140.Cancel;
  VisualizzaDipendenteCorrente;
end;

procedure TW032FRichiestaMissioni.actModRichiesta(const FN: String);
// modifica richiesta missione
var
  i,j,IdMod: Integer;
  Campo, Codice, Valore, ErrRicalcoloTipoMissione: String;
  DatiMezzo: TDatiMezzo;
  FaseCorrente,F1,F2:Integer;
  LErrMsg: String;
begin
  LeggiRegolaMissione(Richiesta.DataA);

  // se non esistono le regole si esce senza registrare la richiesta
  if not RegoleTrovate then
    exit;

  with W032DM.selM140 do
  begin
    IdMod:=FieldByName('ID').AsInteger;
    FaseCorrente:=FieldByName('FASE_CORRENTE').AsInteger;

    // parte 1. aggiornamento M140
    if FaseCorrente < M140FASE_AUTORIZZAZIONE then
    begin
      Edit;
      // imposta sempre tiporegistrazione
      // potrebbe essere stato modificato per effetto di variazioni di flag_estero / ispettiva
      FieldByName('TIPOREGISTRAZIONE').AsString:=IfThen(Parametri.CampiRiferimento.C8_W032RichiediTipoMissione = 'S',Richiesta.TipoRegistrazione,RegolaM010.TipoRegistrazione);
      FieldByName('FLAG_ISPETTIVA').AsString:=Richiesta.FlagIspettiva;
      FieldByName('FLAG_DESTINAZIONE').AsString:=Richiesta.FlagDestinazione;
      // verifica gestione manuale del protocollo
      if Parametri.CampiRiferimento.C8_W032ProtocolloManuale = 'S' then
      begin
        FieldByName('PROTOCOLLO_MANUALE').AsString:=Richiesta.ProtocolloManuale;
        if Richiesta.ProtocolloManuale = 'S' then
        begin
          FieldByName('PROTOCOLLO').AsString:=Richiesta.Protocollo;
        end;
      end;
      // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
      // il percorso prevede destinazioni multiple ed è ora salvato su M141
      {
      FieldByName('PARTENZA').AsString:=Richiesta.Partenza;
      FieldByName('DESTINAZIONE').AsString:=Richiesta.Destinazione;
      FieldByName('RIENTRO').AsString:=Richiesta.Rientro;
      }
      FieldByName('FLAG_PERCORSO').AsString:=Richiesta.FlagPercorso;
      // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
      FieldByName('DATADA').AsDateTime:=Richiesta.DataDa;
      FieldByName('DATAA').AsDateTime:=Richiesta.DataA;
      FieldByName('ORADA').AsString:=Richiesta.OraDa;
      FieldByName('ORAA').AsString:=Richiesta.OraA;

      // verifica protocollo univoco M140 + M040
      // in inserimento imposta un id fittizio
      if not W032DM.CtrlProtocolloUnivoco(FieldByName('ID').AsInteger,FieldByName('PROTOCOLLO').AsString,LErrMsg) then
      begin
        MsgBox.MessageBox(LErrMsg, ESCLAMA);
        Exit;
      end;

      F1:=0;
      C018.CodIter:='';
      C018.UpdRichiesta('0');
      if C018.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end;
      //Alberto 08/02/2012: registro i dati originali del periodo e della data
      C018.Id:=IdMod;
      C018.SetDatoAutorizzatore('DATADA',FieldByName('DATADA').AsString,0);
      C018.SetDatoAutorizzatore('DATAA',FieldByName('DATAA').AsString,0);
      C018.SetDatoAutorizzatore('ORADA',FieldByName('ORADA').AsString,0);
      C018.SetDatoAutorizzatore('ORAA',FieldByName('ORAA').AsString,0);
      F2:=C018.FaseCorrente;
      if F2 > F1 then
      begin
        try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; actModRichiesta.GestioneFasi;',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
        GestioneFasi(F1,F2);
      end;

      //Alberto 08/02/2012: registro i dati originali del periodo e della data se richiesta ancora da autorizzare
      C018.Id:=IdMod;
      C018.SetDatoAutorizzatore('DATADA',FieldByName('DATADA').AsString,0);
      C018.SetDatoAutorizzatore('DATAA',FieldByName('DATAA').AsString,0);
      C018.SetDatoAutorizzatore('ORADA',FieldByName('ORADA').AsString,0);
      C018.SetDatoAutorizzatore('ORAA',FieldByName('ORAA').AsString,0);
    end
    else if R180Between(FieldByName('TIPO_RICHIESTA').AsString,'0','3') then
    begin
      Edit;
      FieldByName('DATADA').AsDateTime:=Richiesta.DataDa;
      FieldByName('DATAA').AsDateTime:=Richiesta.DataA;
      FieldByName('ORADA').AsString:=Richiesta.OraDa;
      FieldByName('ORAA').AsString:=Richiesta.OraA;
      Post;
    end;

    // parte 2. gestione tabelle figlie
    try
      // 2a. dati modificabili in fase iniziale (M140FASE_INIZIALE = -1)
      if FaseCorrente < 0 then
      begin
        // 1/2. mezzi di trasporto: tabella M170
        W032DM.selM170.Refresh; // AOSTA_REGIONE - refresh per via della gestione del filtro tipi missione
        if W032DM.selM170.RecordCount > 0 then
        begin
          W032DM.selM170.Last;
          while not W032DM.selM170.Bof do
            W032DM.selM170.Delete;
        end;
        for i:=0 to grdMezzi.RowCount - 1 do
        begin
          if grdMezzi.Cell[i,0].Control is TmeIWGrid then
          begin
            if ((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,0].Control as TmeIWCheckBox).Checked then
            begin
              W032DM.selM170.Append;
              W032DM.selM170.FieldByName('ID').AsInteger:=IdMod;
              W032DM.selM170.FieldByName('CODICE').AsString:=((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,0].Control as TmeIWCheckBox).FriendlyName;
              if grdMezzi.Cell[i,0].Control is TmeIWGrid then
              begin
                for j:=1 to (grdMezzi.Cell[i,0].Control as TmeIWGrid).ColumnCount - 1 do
                begin
                  if (grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,j].Control <> nil then
                  begin
                    DatiMezzo:=(((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,j].Control as TmeIWEdit).medpTag as TDatiMezzo);
                    Campo:=IfThen(DatiMezzo.FlagTarga = 'S','TARGA','MOTIVAZIONE');
                    W032DM.selM170.FieldByName(Campo).AsString:=((grdMezzi.Cell[i,0].Control as TmeIWGrid).Cell[0,j].Control as TmeIWEdit).Text;
                    // gestione radiogroup spese viaggio
                    if (Datimezzo.FlagMezzoProprio = 'S') and
                       (FieldByName('FLAG_ISPETTIVA').AsString = 'N') then
                    begin
                      W032DM.selM170.FieldByName('CORRESPONSIONE_SPESE').AsString:=IfThen((grdMezzi.Cell[i + 1,0].Control as TmeTIWAdvRadioGroup).ItemIndex = 0,'S','N');
                    end;
                  end;
                end;
              end;
              W032DM.selM170.Post;
            end;
          end;
        end;

        // 2/2. dati personalizzati: tabella M175
        // refresh e cancellazione dati
        if not W032DM.selM175.Active then
        begin
          W032DM.selM175.SetVariable('ID',IdMod);
          W032DM.selM175.Open;
        end;
        if W032DM.selM175.RecordCount > 0 then
        begin
          W032DM.selM175.Last;
          while not W032DM.selM175.Bof do
            W032DM.selM175.Delete;
        end;
        // inserimento dati
        if EsistonoDatiPersonalizzati then
        begin
          for Codice in Richiesta.DatiPers.Keys do
          begin
            Valore:=Richiesta.DatiPers[Codice].ValoreStr;
            if Valore <> '' then
            begin
              W032DM.selM175.Append;
              W032DM.selM175.FieldByName('ID').AsInteger:=IdMod;
              W032DM.selM175.FieldByName('CODICE').AsString:=Codice;
              W032DM.selM175.FieldByName('VALORE').AsString:=Valore;
              W032DM.selM175.Post;
            end;
          end;
        end;
        if FieldByName('FLAG_DESTINAZIONE').AsString = 'E' then
        begin
          for i:=0 to cgpMotivEstero.Items.Count - 1 do
          begin
            if cgpMotivEstero.IsChecked[i] then
            begin
              W032DM.selM175.Append;
              W032DM.selM175.FieldByName('ID').AsInteger:=IdMod;
              W032DM.selM175.FieldByName('CODICE').AsString:=cgpMotivEstero.Values[i];
              W032DM.selM175.Post;
            end;
          end;
          for i:=0 to cgpIpotesiEstero.Items.Count - 1 do
          begin
            if cgpIpotesiEstero.IsChecked[i] then
            begin
              W032DM.selM175.Append;
              W032DM.selM175.FieldByName('ID').AsInteger:=IdMod;
              W032DM.selM175.FieldByName('CODICE').AsString:=cgpIpotesiEstero.Values[i];
              W032DM.selM175.Post;
            end;
          end;
        end;
      end;

      // 2b. dati degli anticipi
      if GestAnticipi then
      begin
        // aggiorna sulla richiesta i dati legati agli anticipi
        if tabMissioni.Tabs[rgAnticipi].Enabled then
        begin
          Edit;
          if rgpAccredito.ItemIndex = 0 then
          begin
            FieldByName('FLAG_TIPOACCREDITO').AsString:='1';
            FieldByName('DELEGATO').AsString:='';
          end
          else if rgpAccredito.ItemIndex = 1 then
          begin
            FieldByName('FLAG_TIPOACCREDITO').AsString:='2';
            if chkDelegato.Checked then
              FieldByName('DELEGATO').AsString:=Richiesta.Delegato;
          end;
          Post;
        end;
      end;

      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
      // imposta il valore di ID_RIMBORSO sul dataset riferito a M150
      // in modo da attribuire valori da 0 in su
      if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
      begin
        //*** ...
      end;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

      // applica le modifiche su db
      SessioneOracle.ApplyUpdates([W032DM.selM150,W032DM.selM160,W032DM.selM143,W032DM.selM141],True);

      // ridetermina i tipi registrazione disponibili in base a M011F_FILTROITER
      // e verifica la compatibilità del tipo registrazione già impostato
      // se questo non è compatibile fornisce un avviso al cliente
      if not RicalcoloTipoMissione(True,ErrRicalcoloTipoMissione) then
        raise Exception.Create(ErrRicalcoloTipoMissione);

      // se richiesto esplicitamente tramite parametro aziendale
      // consente la valutazione delle condizioni di autorizzazione automatica
      // anche sui dati nelle tabelle figlie di M140
      if Parametri.CampiRiferimento.C8_W032UpdRichiesta = 'S' then
      begin
        if (FaseCorrente < M140FASE_AUTORIZZAZIONE) and (F2 < M140FASE_AUTORIZZAZIONE) then
        begin
          W032DM.selM140.Edit;
          F1:=0;
          C018.UpdRichiesta('0');
          F2:=C018.FaseCorrente;
          if F2 > F1 then
          begin
            try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; actModRichiesta.GestioneFasi;',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
            GestioneFasi(F1,F2);
          end;
        end;
      end;

      // commit
      SessioneOracle.Commit;

      // mostra eventuale messaggio di errore nel ricalcolo del tipo missione
      if ErrRicalcoloTipoMissione <> '' then
        GGetWebApplicationThreadVar.ShowMessage(ErrRicalcoloTipoMissione);
    except
      on E: Exception do
      begin
        MsgBox.MessageBox('Errore durante la modifica della richiesta:'#13#10 + E.Message +
                          IfThen(E.ClassName <> 'Exception',#13#10'Tipo: ' + E.ClassName),
                          ERRORE,'Errore modifica');
        Exit;
      end;
    end;
  end;

  // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
  // è necessario riaprire il dataset delle richieste per ricalcolare il percorso
  W032DM.selM140.Close;
  W032DM.selM140.Open;
  // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

  // rilegge i dati
  grdRichieste.medpCaricaCDS;

  // posizionamento su riga appena modificata
  DBGridColumnClick(nil,IdMod.ToString);
end;

procedure TW032FRichiestaMissioni.actCancRichiesta(const FN: String);
// cancellazione richiesta missione
begin
  with W032DM do
  begin
    // elimina il record di testata della richiesta
    C018.CodIter:=selM140.FieldByName('COD_ITER').AsString;
    C018.Id:=selM140.FieldByName('ID').AsInteger;
    C018.EliminaIter;

    // elimina la missione
    try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; actCancRichiesta.delM040',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
    delM040.SetVariable('ANNULLAMENTO','N');
    delM040.SetVariable('ID',C018.Id);
    delM040.Execute;

    SessioneOracle.Commit;
  end;

  VisualizzaDipendenteCorrente;
end;

//#########################//
//### GESTIONE ANTICIPI ###//
//#########################//

procedure TW032FRichiestaMissioni.DBGridColumnClickAnt(ASender:TObject; const AValue:string);
var
  TmpRecNo: Integer;
begin
  // in caso di UpdatesPending, AValue è numerico ed è = al RecNo del dataset
  if TryStrToInt(AValue,TmpRecNo) then
  begin
    cdsM160.RecNo:=TmpRecNo + IfThen(grdAnticipi.medpRigaInserimento,1); // riga inserimento
    W032DM.selM160.SearchRecord('CODICE',cdsM160.FieldByName('CODICE').AsString,[srFromBeginning]);
  end
  else
  begin
    if cdsM160.Locate('DBG_ROWID',AValue,[]) then
      W032DM.selM160.SearchRecord('ROWID',cdsM160.FieldByName('DBG_ROWID').AsString,[srFromBeginning]);
  end;
end;

procedure TW032FRichiestaMissioni.TrasformaComponentiAnt(const FN:String);
var
  i,c:Integer;
  T: String;
  V: double;
  IWCmb: TmeIWComboBox;
begin
  i:=grdAnticipi.medpRigaDiCompGriglia(FN);

  // gestione icone comandi
  with (grdAnticipi.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
  begin
    Cell[0,0].Css:=IfThen(grdAnticipi.medpStato <> msBrowse,'invisibile','align_left');
    if i = 0 then
    begin
      // riga di inserimento
      Cell[0,1].Css:=IfThen(grdAnticipi.medpStato <> msBrowse,'align_left','invisibile');
      Cell[0,2].Css:=IfThen(grdAnticipi.medpStato <> msBrowse,'align_right','invisibile');
      if grdAnticipi.medpStato <> msBrowse then
        imgConfermaAnt:=(Cell[0,2].Control as TmeIWImageFile);
    end
    else
    begin
      // dettaglio
      Cell[0,1].Css:=IfThen(grdAnticipi.medpStato <> msBrowse,'invisibile','align_right');
      Cell[0,2].Css:=IfThen(grdAnticipi.medpStato <> msBrowse,'align_left','invisibile');
      Cell[0,3].Css:=IfThen(grdAnticipi.medpStato <> msBrowse,'align_right','invisibile');
      if grdAnticipi.medpStato <> msBrowse then
        imgConfermaAnt:=(Cell[0,3].Control as TmeIWImageFile);
    end;
  end;

  IWCmb:=nil;
  with grdAnticipi do
  begin
    if medpStato <> msBrowse then
    begin
      // voce richiesta
      if medpStato = msInsert then
      begin
        medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'40','','','','S');
        c:=medpIndexColonna('C_DESCRIZIONE');
        medpCreaComponenteGenerico(i,c,Componenti);
        IWCmb:=(medpCompCella(i,c,0) as TmeIWComboBox);
        with IWCmb do
        begin
          FriendlyName:=FN;
          ItemsHaveValues:=True;
          Items.Assign(ListaAnticipi);
          Items.Insert(0,'=');
          if medpStato = msInsert then
            ItemIndex:=0
          else if medpStato = msEdit then
            ItemIndex:=Items.IndexOfName(medpValoreColonna(i,'C_DESCRIZIONE'));
          OnChange:=cmbVoceAnticipoChange;
        end;
      end;

      // percentuale
      medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'3','','','','S');
      c:=medpIndexColonna('C_PERC_ANTICIPO');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompGriglia[i].CompColonne[c] as TmeIWLabel) do
      begin
        Caption:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',grdAnticipi.medpValoreColonna(i,'CODICE'),'PERC_ANTICIPO'));
        if Caption <> '' then
          Caption:=Caption + '%';
      end;
      // note fisse
      medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'20','','','','S');
      c:=medpIndexColonna('C_NOTE_FISSE');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompGriglia[i].CompColonne[c] as TmeIWLabel) do
      begin
        Caption:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',grdAnticipi.medpValoreColonna(i,'CODICE'),'NOTE_FISSE'));
      end;
      // quantità
      medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'','','','','S');
      medpPreparaComponenteGenerico('C',0,1,DBG_CHK,'','','','','S');
      medpPreparaComponenteGenerico('C',0,2,DBG_EDT,'5','','','','S');
      medpPreparaComponenteGenerico('C',0,3,DBG_EDT,'7','','','','D');
      c:=medpIndexColonna('QUANTITA');
      medpCreaComponenteGenerico(i,c,Componenti);
      T:=medpValoreColonna(i,'C_TIPO_QUANTITA');
      with (medpCompGriglia[i].CompColonne[c] as TmeIWGrid) do
      begin
        Cell[0,0].Css:=IfThen((T <> '') and (T <> 'F'),'','invisibile');
        Cell[0,1].Css:=IfThen(T = 'F','','invisibile');
        Cell[0,2].Css:=IfThen(T = 'Q','','invisibile');
        Cell[0,3].Css:=IfThen(T = 'I','','invisibile');
      end;
      if medpStato = msInsert then
      begin
        cmbVoceAnticipoChange(IWCmb);
      end
      else if medpStato = msEdit then
      begin
        V:=StrToFloat(medpValoreColonna(i,'QUANTITA'));
        if T = 'F' then
        begin
          // F = flag
          (medpCompCella(i,c,0) as TmeIWLabel).Caption:='';
          (medpCompCella(i,c,1) as TmeIWCheckBox).Checked:=(V = 1);
        end
        else if T = 'Q' then
        begin
          // Q = quantità
          (medpCompCella(i,c,0) as TmeIWLabel).Caption:='n.';
          (medpCompCella(i,c,2) as TmeIWEdit).Text:=IntToStr(Trunc(V));
        end
        else if T = 'I' then
        begin
          // I = importo
          (medpCompCella(i,c,0) as TmeIWLabel).Caption:='€';
          (medpCompCella(i,c,3) as TmeIWEdit).Text:=FloatToStr(V);
        end;
      end;

      // note
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'30','','','','S');
      c:=medpIndexColonna('NOTE');
      medpCreaComponenteGenerico(i,c,Componenti);
    end
    else
    begin
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_DESCRIZIONE')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('QUANTITA')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('NOTE')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_PERC_ANTICIPO')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_NOTE_FISSE')]);
    end;
  end;
end;

procedure TW032FRichiestaMissioni.grdAnticipiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i:Integer;
  LSomma: Currency;
begin
  if (not SolaLettura) and
     (not WR000DM.Responsabile) then
  begin
    if grdAnticipi.medpRigaInserimento then
    begin
      (grdAnticipi.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInsAnticipoClick;
      (grdAnticipi.medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaAnticipoClick;
      (grdAnticipi.medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgApplicaAnticipoClick;
      with (grdAnticipi.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:='invisibile';
      end;
    end;
    for i:=IfThen(grdAnticipi.medpRigaInserimento,1,0) to High(grdAnticipi.medpCompGriglia) do
    begin
      if (grdAnticipi.medpCompGriglia[i].CompColonne[0] <> nil) then
      begin
        (grdAnticipi.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCanAnticipoClick;
        (grdAnticipi.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModAnticipoClick;
        (grdAnticipi.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaAnticipoClick;
        (grdAnticipi.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgApplicaAnticipoClick;
        with (grdAnticipi.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
        begin
          Cell[0,2].Css:='invisibile';
          Cell[0,3].Css:='invisibile';
        end;
      end;
    end;
  end;

  // calcola totale anticipi richiesti (espressi in valuta)
  if grdAnticipi.medpStato = msBrowse then
  begin
    // somma solo le quantità espresse in importo (flag TIPO_QUANTITA = 'I')
    LSomma:=0;
    with W032DM.selM160 do
    begin
      First;
      while not Eof do
      begin
        if FieldByName('C_TIPO_QUANTITA').AsString = 'I' then
          LSomma:=LSomma + FieldByName('QUANTITA').AsCurrency;
        Next;
      end;
    end;
    lblTotAnticipi.Caption:='Totale anticipi: € ' + CurrToStr(LSomma);
  end;
end;

procedure TW032FRichiestaMissioni.grdAnticipiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  T,Campo,Prefisso: String;
begin
  if not grdAnticipi.medpRenderCell(ACell,ARow,AColumn,True,False,False) then
    Exit;

  if ARow > 0 then
  begin
    NumColonna:=grdAnticipi.medpNumColonna(AColumn);
    Campo:=grdAnticipi.medpColonna(NumColonna).DataField;
    if (Campo = 'QUANTITA') or
       (Campo = 'C_PERC_ANTICIPO') then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end;

    // assegnazione componenti alle celle
    if (ARow <= High(grdAnticipi.medpCompGriglia) + 1) and (grdAnticipi.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
    begin
      ACell.Control:=grdAnticipi.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
      ACell.Text:='';
    end;

    if (ARow <= High(grdAnticipi.medpCompGriglia) + 1) and (ACell.Control = nil) then
    begin
      if Campo = 'QUANTITA' then
      begin
        // quantità
        Prefisso:='';
        T:=grdAnticipi.medpValoreColonna(ARow - 1,'C_TIPO_QUANTITA');
        if T = 'Q' then
          Prefisso:='n. '
        else if T = 'I' then
          Prefisso:='€ ';
        // modifica la dicitura
        if T = 'F' then
          ACell.Text:=IfThen(ACell.Text = '1','Sì','No') // flag visualizzato come Sì/No
        else
          ACell.Text:=Prefisso + ACell.Text;
      end
      else if Campo = 'C_PERC_ANTICIPO' then
      begin
        // % spettante di anticipo
        // se dato vuoto prova a fare lookup
        if ACell.Text = '' then
          ACell.Text:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',grdAnticipi.medpValoreColonna(ARow - 1,'CODICE'),'PERC_ANTICIPO'));
        if ACell.Text <> '' then
          ACell.Text:=ACell.Text + '%';
      end
      else if Campo = 'C_NOTE_FISSE' then
      begin
        // note fisse
        // se dato vuoto prova a fare lookup
        if ACell.Text = '' then
          ACell.Text:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',grdAnticipi.medpValoreColonna(ARow - 1,'CODICE'),'NOTE_FISSE'));
      end;
    end;
  end;
end;

function TW032FRichiestaMissioni.CtrlAnticipoOK(const FN: String): Boolean;
var
  i,c,QtaInt: Integer;
  IWC: TIWCustomControl;
  Voce, T, TipoArr: String;
  Arr: double;
  Limite: Currency;
begin
  Result:=False;
  MsgAnt:='';
  i:=grdAnticipi.medpRigaDiCompGriglia(FN);

  IWC:=nil;
  if grdAnticipi.medpStato = msInsert then
  begin
    c:=grdAnticipi.medpIndexColonna('C_DESCRIZIONE');
    IWC:=grdAnticipi.medpCompCella(i,c,0);
    RecordAnticipo.Codice:=(IWC as TmeIWComboBox).Items.ValueFromIndex[(IWC as TmeIWComboBox).ItemIndex];
    T:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',RecordAnticipo.Codice,'TIPO_QUANTITA'));
    Voce:=(IWC as TmeIWComboBox).Items.Names[(IWC as TmeIWComboBox).ItemIndex];
  end
  else
  begin
    RecordAnticipo.Codice:=grdAnticipi.medpValoreColonna(i,'CODICE');
    T:=grdAnticipi.medpValoreColonna(i,'C_TIPO_QUANTITA');
    Voce:=grdAnticipi.medpValoreColonna(i,'C_DESCRIZIONE');
  end;

  if RecordAnticipo.Codice = '' then
  begin
    MsgBox.MessageBox('Non è stata selezionata nessuna voce di anticipo.',INFORMA);
    exit;
  end;

  // quantità
  if grdAnticipi.medpStato <> msBrowse then
  begin
    c:=grdAnticipi.medpIndexColonna('QUANTITA');
    if T = 'F' then
    begin
      // flag: 0 = deselezionato, 1 = selezionato
      IWC:=grdAnticipi.medpCompCella(i,c,1);
      RecordAnticipo.Quantita:=IfThen((IWC as TmeIWCheckBox).Checked,1,0)
    end
    else if T = 'Q' then
    begin
      // quantità espressa in numero intero
      IWC:=grdAnticipi.medpCompCella(i,c,2);
      if not TryStrToInt((IWC as TmeIWEdit).Text,QtaInt) then
      begin
        MsgBox.MessageBox(Format('La quantità indicata per la voce di anticipo "%s"'#13#10'non è valida!'#13#10'Indicare un valore intero positivo.',[Voce]),INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
      RecordAnticipo.Quantita:=QtaInt;
    end
    else if T = 'I' then
    begin
      // quantità espressa in importo
      IWC:=grdAnticipi.medpCompCella(i,c,3);
      if not TryStrToCurr((IWC as TmeIWEdit).Text,RecordAnticipo.Quantita) then
      begin
        MsgBox.MessageBox(Format('La quantità indicata per la voce di anticipo'#13#10'"%s" non è valida!',[Voce]),INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end;
  end
  else
    RecordAnticipo.Quantita:=StrToFloat(grdAnticipi.medpValoreColonna(i,'QUANTITA'));

  // se si tratta di anticipo pasto, limita il numero di pasti secondo le impostazioni
  if RecordAnticipo.Codice = CodAnticipoPastoM020 then
  begin
    with W032DM.M013F_CALC_RIMB_PASTO do
    begin
      SetVariable('TIPORISULTATO',IfThen(T = 'I','I','N'));
      SetVariable('CODICE',RegolaM010.Codice);
      SetVariable('TIPOREGISTRAZIONE',RegolaM010.TipoRegistrazione);
      SetVariable('DATADA',Richiesta.DataDa);
      SetVariable('DATAA',Richiesta.DataA);
      SetVariable('ORADA',Richiesta.OraDa);
      SetVariable('ORAA',Richiesta.OraA);
      Execute;
      Limite:=StrToCurr(VarToStr(GetVariable('RESULT')));
    end;
    if Limite > -1 then
    begin
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
      // arrotondamento limite
      if Limite > 0 then
      begin
        Arr:=1;
        TipoArr:='P';
        W032DM.P050.Close;
        W032DM.P050.SetVariable('CODICE',RegolaM010.ArrotTariffaDopoRiduzione);
        W032DM.P050.SetVariable('DECORRENZA',Richiesta.DataA);
        W032DM.P050.Open;
        W032DM.P050.First;
        if not W032DM.P050.Eof then
        begin
          Arr:=W032DM.P050.FieldByName('VALORE').AsFloat;
          TipoArr:=W032DM.P050.FieldByName('TIPO').AsString;
        end;
        Limite:=R180Arrotonda(Limite,Arr,TipoArr);
      end;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

      // verifica sforamento limite
      if RecordAnticipo.Quantita > Limite then
      begin
        RecordAnticipo.Quantita:=Limite;
        if T = 'I' then
          MsgAnt:='La quantità richiesta per l''anticipo pasto è stata limitata a ' + CurrToStr(Limite)
        else
          MsgAnt:='Il numero di pasti richiesti per l''anticipo è stato limitato a ' + IntToStr(Trunc(Limite));
        MsgAnt:=MsgAnt + ', in base alle regole definite per la missione';
      end;
    end;
  end;

  if RecordAnticipo.Quantita = 0 then
  begin
    if T = 'F' then
      MsgBox.MessageBox('Se si desidera includere la voce di anticipo' + CRLF +
                        '"' + Voce + '"' + CRLF +
                        'è necessario spuntare la casella di selezione.',INFORMA)
    else
      MsgBox.MessageBox('La quantità relativa alla voce di anticipo' + CRLF +
                        '"' + Voce + '"' + CRLF +
                        'deve essere maggiore di 0.',INFORMA);
    if Assigned(IWC) then
      ActiveControl:=IWC;
    Exit;
  end;

  // note
  IWC:=grdAnticipi.medpCompCella(i,'NOTE',0);
  RecordAnticipo.Note:=Trim((IWC as TmeIWEdit).Text);

  // chiave duplicata
  if (grdAnticipi.medpStato = msInsert) and
     (W032DM.selM160.SearchRecord('CODICE',RecordAnticipo.Codice,[srFromBeginning])) then
  begin
    MsgBox.MessageBox(Format('La voce di anticipo'#13#10'"%s"'#13#10'è già presente nella tabella!',[Voce]),INFORMA);
    Exit;
  end;

  Result:=True;
end;

procedure TW032FRichiestaMissioni.imgInsAnticipoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClickAnt(Sender,FN);
  grdAnticipi.medpStato:=msInsert;
  grdAnticipi.medpBrowse:=False;
  TrasformaComponentiAnt(FN);
end;

procedure TW032FRichiestaMissioni.imgModAnticipoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClickAnt(Sender,FN);
  grdAnticipi.medpStato:=msEdit;
  grdAnticipi.medpBrowse:=False;
  TrasformaComponentiAnt(FN);
end;

procedure TW032FRichiestaMissioni.imgCanAnticipoClick(Sender: TObject);
var
  FN: String;
  NumR: Integer;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  with W032DM.selM160 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
      Delete
    else if TryStrToInt(FN,NumR) then
    begin
      // caso di inserimenti con cached updates
      // 1 <= NumR <= RecordCount
      First;
      MoveBy(NumR - 1);
      Delete;
    end;
  end;
  grdAnticipi.medpCaricaCDS;
end;

procedure TW032FRichiestaMissioni.imgAnnullaAnticipoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdAnticipi.medpStato:=msBrowse;
  TrasformaComponentiAnt(FN);
  grdAnticipi.medpBrowse:=True;
end;

procedure TW032FRichiestaMissioni.imgApplicaAnticipoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // effettua controlli e aggiorna periodo della missione
  // per effettuare il controllo anticipi in modo corretto
  if not ControlliOK(W032DM.selM140.RowId) then
    Exit;

  W032DM.selM140.Edit;
  W032DM.selM140.FieldByName('DATADA').AsDateTime:=Richiesta.DataDa;
  W032DM.selM140.FieldByName('DATAA').AsDateTime:=Richiesta.DataA;
  W032DM.selM140.FieldByName('ORADA').AsString:=Richiesta.OraDa;
  W032DM.selM140.FieldByName('ORAA').AsString:=Richiesta.OraA;
  W032DM.selM140.Post;

  // effettua controlli bloccanti
  if not CtrlAnticipoOK(FN) then
    Exit;

  // inserimento / aggiornamento
  if grdAnticipi.medpStato = msInsert then
    actInsAnticipo
  else
    actModAnticipo(FN);
end;

procedure TW032FRichiestaMissioni.actInsAnticipo;
begin
  // aggiornamento dataset (cached updates)
  with W032DM.selM160 do
  begin
    Append;
    FieldByName('ID').AsInteger:=W032DM.selM140.FieldByName('ID').AsInteger;
    FieldByName('CODICE').AsString:=RecordAnticipo.Codice;
    FieldByName('QUANTITA').AsFloat:=RecordAnticipo.Quantita;
    FieldByName('NOTE').AsString:=RecordAnticipo.Note;
    try
      Post;
      grdAnticipi.medpCaricaCDS;
      if MsgAnt <> '' then
        MessaggioStatus(INFORMA,MsgAnt,15000);
    except
      on E: Exception do
        MsgBox.MessageBox('Errore durante l''inserimento della richiesta di anticipo:' + CRLF +
                          'Errore: ' + E.Message + CRLF +
                          'Tipo: ' + E.ClassName,ESCLAMA);
    end;
  end;
end;

procedure TW032FRichiestaMissioni.actModAnticipo(const FN: String);
begin
  // aggiornamento dataset (cached updates)
  with W032DM.selM160 do
  begin
    Edit;
    FieldByName('QUANTITA').AsFloat:=RecordAnticipo.Quantita;
    FieldByName('NOTE').AsString:=RecordAnticipo.Note;
    try
      Post;
      grdAnticipi.medpCaricaCDS;
      if MsgAnt <> '' then
        MessaggioStatus(INFORMA,MsgAnt,15000);
    except
      on E: Exception do
      begin
        MsgBox.MessageBox('Errore durante aggiornamento voce anticipo:' + CRLF +
                          'Errore: ' + E.Message + CRLF +
                          'Tipo: ' + E.ClassName,ESCLAMA);
        Exit;
      end;
    end;
  end;
end;

//######################################//
//### GESTIONE DETTAGLIO GIORNALIERO ###//
//######################################//

procedure TW032FRichiestaMissioni.DBGridColumnClickDettaglioGG(ASender:TObject; const AValue:string);
var
  TmpRecNo: Integer;
begin
  // in caso di UpdatesPending, AValue è numerico ed è il recno del dataset
  if TryStrToInt(AValue,TmpRecNo) then
  begin
    cdsM143.RecNo:=TmpRecNo + IfThen(grdDettaglioGG.medpRigaInserimento,1);
    W032DM.selM143.SearchRecord('DATA;DALLE',VarArrayOf([cdsM143.FieldByName('DATA').AsDateTime,cdsM143.FieldByName('DALLE').AsString]),[srFromBeginning]);
  end
  else
  begin
    if cdsM143.Locate('DBG_ROWID',AValue,[]) then
      W032DM.selM143.SearchRecord('ROWID',cdsM143.FieldByName('DBG_ROWID').AsString,[srFromBeginning]);
  end;
end;

procedure TW032FRichiestaMissioni.TrasformaComponentiDettaglioGG(const FN:String);
var
  i,c: Integer;
  IWEdtData,IWEdtDalle: TmeIWEdit;
  IWRgpTipo: TmeTIWAdvRadioGroup; // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1
  IWMemNote: TmeIWMemo;
begin
  i:=grdDettaglioGG.medpRigaDiCompGriglia(FN);

  // gestione icone comandi
  with (grdDettaglioGG.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
  begin
    Cell[0,0].Css:=IfThen(grdDettaglioGG.medpStato <> msBrowse,'invisibile','align_left');
    if i = 0 then
    begin
      // riga di inserimento
      Cell[0,1].Css:=IfThen(grdDettaglioGG.medpStato <> msBrowse,'align_left','invisibile');
      Cell[0,2].Css:=IfThen(grdDettaglioGG.medpStato <> msBrowse,'align_right','invisibile');
      if grdDettaglioGG.medpStato <> msBrowse then
        imgConfermaDettGG:=(Cell[0,2].Control as TmeIWImageFile);
    end
    else
    begin
      // dettaglio
      Cell[0,1].Css:=IfThen(grdDettaglioGG.medpStato <> msBrowse,'invisibile','align_right');
      Cell[0,2].Css:=IfThen(grdDettaglioGG.medpStato <> msBrowse,'align_left','invisibile');
      Cell[0,3].Css:=IfThen(grdDettaglioGG.medpStato <> msBrowse,'align_right','invisibile');
      if grdDettaglioGG.medpStato <> msBrowse then
        imgConfermaDettGG:=(Cell[0,3].Control as TmeIWImageFile);
    end;
  end;

  with grdDettaglioGG do
  if medpStato <> msBrowse then
  begin
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
    // tipo
    medpPreparaComponenteGenerico('C',0,0,DBG_RGP,'20','Servizio attivo,Ore viaggio','Tipo','','S');
    c:=medpIndexColonna('TIPO');
    medpCreaComponenteGenerico(i,c,Componenti);
    IWRgpTipo:=(medpCompCella(i,c,0) as TmeTIWAdvRadioGroup);
    with IWRgpTipo do
    begin
      Columns:=1;
      Layout:=glVertical;
      if medpStato = msInsert then
        ItemIndex:=0
      else
        ItemIndex:=IfThen(medpValoreColonna(i,'TIPO') = 'S',0,1);
    end;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine

    { // proposta data / ora in inserimento è commentata per ora
    if medpStato = msInsert then
    begin
      // determina data e ora da proporre in inserimento
      if (not W032DM.selM143.Active) or
         (W032DM.selM143.RecordCount = 0) then
      begin
        MaxData:=W032DM.selM140.FieldByName('DATADA').AsDateTime;
        MaxOra:=R180OreMinutiExt(W032DM.selM140.FieldByName('ORADA').AsString);
      end
      else
      begin
        BM:=W032DM.selM143.GetBookMark;
        try
          W032DM.selM143.Last;
          MaxData:=W032DM.selM143.FieldByName('DATA').AsDateTime;
          MaxOra:=R180OreMinutiExt(W032DM.selM143.FieldByName('ALLE').AsString);
          W032DM.selM143.GotoBookMark(BM);
        finally
          W032DM.selM143.FreeBookMark(BM);
        end;
      end;

      DataIns:=DateToStr(MaxData);
      if (MaxData = W032DM.selM140.FieldByName('DATAA').AsDateTime) and
         (MaxOra = R180OreMinutiExt(W032DM.selM140.FieldByName('ORAA').AsString)) then
      begin
        DalleIns:='';
        AlleIns:='';
      end
      else
      begin
        DalleIns:=R180MinutiOre(MaxOra);
        if W032DM.selM140.FieldByName('DATADA').AsDateTime = W032DM.selM140.FieldByName('DATAA').AsDateTime then
          AlleIns:=R180MinutiOre(Min(MaxOra + 60,R180OreMinutiExt(W032DM.selM140.FieldByName('ORAA').AsString)))
        else
          AlleIns:=R180MinutiOre(MaxOra + 60);
      end;
    end;
    }

    // data servizio
    medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
    c:=medpIndexColonna('DATA');
    medpCreaComponenteGenerico(i,c,Componenti);
    IWEdtData:=(medpCompCella(i,c,0) as TmeIWEdit);
    with IWEdtData do
    begin
      if medpStato = msInsert then
        Text:={DataIns}IfThen(W032DM.selM140.FieldByName('DATADA').AsDateTime = W032DM.selM140.FieldByName('DATAA').AsDateTime,W032DM.selM140.FieldByName('DATADA').AsString,'')
      else
        Text:=medpValoreColonna(i,'DATA');
    end;

    // dalle
    medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
    c:=medpIndexColonna('DALLE');
    medpCreaComponenteGenerico(i,c,Componenti);
    IWEdtDalle:=(medpCompCella(i,c,0) as TmeIWEdit);
    with IWEdtDalle do
    begin
      if medpStato = msInsert then
        Text:='' {DalleIns}
      else
        Text:=medpValoreColonna(i,'DALLE');
    end;

    // alle
    medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
    c:=medpIndexColonna('ALLE');
    medpCreaComponenteGenerico(i,c,Componenti);
    with (medpCompCella(i,c,0) as TmeIWEdit) do
    begin
      if medpStato = msInsert then
        Text:=''
      else
        Text:=medpValoreColonna(i,'ALLE');
    end;

    // note
    medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'40','','','','S');
    c:=medpIndexColonna('NOTE');
    medpCreaComponenteGenerico(i,c,Componenti);
    IWMemNote:=(medpCompCella(i,c,0) as TmeIWMemo);
    with IWMemNote do
    begin
      if medpStato = msInsert then
        Text:=''
      else
        Text:=medpValoreColonna(i,'NOTE');
    end;

    // imposta focus
    if medpStato = msInsert then
    begin
      if IWEdtData.Text = '' then
        ActiveControl:=IWEdtData
      else
        ActiveControl:=IWEdtDalle;
    end
    else if medpStato = msEdit then
      ActiveControl:=IWMemNote;
  end
  else
  begin
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
    FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('TIPO')]);
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine
    FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('DATA')]);
    FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('DALLE')]);
    FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('ALLE')]);
    FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('NOTE')]);
  end;
end;

procedure TW032FRichiestaMissioni.grdDatiRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  inherited;
  //
end;

procedure TW032FRichiestaMissioni.grdDettaglioGGAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i:Integer;
begin
  if (not SolaLettura) and
     (not WR000DM.Responsabile) then
  begin
    if grdDettaglioGG.medpRigaInserimento then
    begin
      (grdDettaglioGG.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInsDettaglioGGClick;
      (grdDettaglioGG.medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaDettaglioGGClick;
      (grdDettaglioGG.medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgApplicaDettaglioGGClick;
      with (grdDettaglioGG.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:='invisibile';
      end;
    end;
    for i:=IfThen(grdDettaglioGG.medpRigaInserimento,1,0) to High(grdDettaglioGG.medpCompGriglia) do
    begin
      if (grdDettaglioGG.medpCompGriglia[i].CompColonne[0] <> nil) then
      begin
        (grdDettaglioGG.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCanDettaglioGGClick;
        (grdDettaglioGG.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModDettaglioGGClick;
        (grdDettaglioGG.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaDettaglioGGClick;
        (grdDettaglioGG.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgApplicaDettaglioGGClick;
        with (grdDettaglioGG.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
        begin
          Cell[0,2].Css:='invisibile';
          Cell[0,3].Css:='invisibile';
        end;
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.grdDettaglioGGRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
begin
  if not grdDettaglioGG.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  NumColonna:=grdDettaglioGG.medpNumColonna(AColumn);
  Campo:=grdDettaglioGG.medpColonna(NumColonna).DataField;

  // width delle colonne
  if ARow = 0 then
  begin
    // riga di intestazione: larghezza colonne
    if Campo = 'NOTE' then
      ACell.Css:=ACell.Css + ' width55chr';
  end
  else
  begin
    // assegnazione componenti alle celle
    if (ARow <= High(grdDettaglioGG.medpCompGriglia) + 1) and (grdDettaglioGG.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
    begin
      ACell.Control:=grdDettaglioGG.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
      ACell.Text:='';
    end;

    // stili per celle
    if (Campo = 'TIPO') or (Campo = 'DATA') or (Campo = 'DALLE') or (Campo = 'ALLE') then
      ACell.Css:=ACell.Css + ' align_center';

    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
    // decodifiche dati
    if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (ACell.Text <> '') then
    begin
      if Campo = 'TIPO' then
      begin
        ACell.Text:=IfThen(ACell.Text = 'S','Servizio attivo','Viaggio');
      end;
    end;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine
  end;
end;

function TW032FRichiestaMissioni.CtrlDettaglioGGOK(const FN: String): Boolean;
var
  i,c: Integer;
  TempStr, Msg, TipoDesc: String;
  DalleMin,AlleMin,DalleTemp,AlleTemp,OldRecNo: Integer;
  IWC: TIWCustomControl;
begin
  Result:=False;

  with grdDettaglioGG do
  begin
    i:=medpRigaDiCompGriglia(FN);

    // data di riferimento
    c:=medpIndexColonna('DATA');
    IWC:=medpCompCella(i,c,0);
    RecordDettaglioGG.Data:=0;
    if (IWC as TmeIWEdit).Text <> '' then
    begin
      if not TryStrToDateTime((IWC as TmeIWEdit).Text,RecordDettaglioGG.Data) then
      begin
        MsgBox.MessageBox('La data del dettaglio non è valida!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
      if (RecordDettaglioGG.Data < W032DM.selM140.FieldByName('DATADA').AsDateTime) or
         (RecordDettaglioGG.Data > W032DM.selM140.FieldByName('DATAA').AsDateTime) then
      begin
        MsgBox.MessageBox('La data deve essere compresa nel periodo della missione!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end;

    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
    // tipo
    IWC:=medpCompCella(i,'TIPO',0);
    RecordDettaglioGG.Tipo:=IfThen((IWC as TTIWAdvRadioGroup).ItemIndex = 0,'S','V');
    // controllo commentato a seguito della richiesta dello stesso cliente - daniloc. 29/10/2014
    {
    // se la missione è di un solo giorno verifica presenza della sola tipologia = servizio
    if (W032DM.selM140.FieldByName('DATADA').AsDateTime = W032DM.selM140.FieldByName('DATAA').AsDateTime) and
       (RecordDettaglioGG.Tipo <> 'S') then
    begin
      MsgBox.MessageBox('Non è consentito indicare ore di viaggio per una missione di un giorno solo!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;
    }
    TipoDesc:=IfThen(RecordDettaglioGG.Tipo = 'S','servizio attivo','viaggio');
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine

    // dalle
    c:=medpIndexColonna('DALLE');
    IWC:=medpCompCella(i,c,0);
    TempStr:=(IWC as TmeIWEdit).Text;
    if TempStr = '' then
    begin
      MsgBox.MessageBox(Format('Indicare l''ora di inizio del %s!',[TipoDesc]),INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;
    try
      R180OraValidate(TempStr);
    except
      on E:Exception do
      begin
        MsgBox.MessageBox(E.Message,INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end;
    // controlla ora inizio per il primo giorno della missione
    DalleTemp:=R180OreMinutiExt(TempStr);
    if (RecordDettaglioGG.Data = W032DM.selM140.FieldByName('DATADA').AsDateTime) and
       (DalleTemp < R180OreMinutiExt(W032DM.selM140.FieldByName('ORADA').AsString)) then
    begin
      MsgBox.MessageBox(Format('L''ora di inizio del %s non può essere precedente all''inizio della missione!',[TipoDesc]),INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;
    RecordDettaglioGG.Dalle:=TempStr;

    // alle
    c:=medpIndexColonna('ALLE');
    IWC:=medpCompCella(i,c,0);
    TempStr:=(IWC as TmeIWEdit).Text;
    if TempStr = '' then
    begin
      MsgBox.MessageBox(Format('Indicare l''ora di fine del %s!',[TipoDesc]),INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;
    try
      R180OraValidate(TempStr);
    except
      on E:Exception do
      begin
        MsgBox.MessageBox(E.Message,INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end;
    // controlla ora fine per l'ultimo giorno della missione
    AlleTemp:=R180OreMinutiExt(TempStr);
    if (RecordDettaglioGG.Data = W032DM.selM140.FieldByName('DATAA').AsDateTime) and
       (AlleTemp > R180OreMinutiExt(W032DM.selM140.FieldByName('ORAA').AsString)) then
    begin
      MsgBox.MessageBox(Format('L''ora di fine del %s non può essere successiva alla fine della missione!',[TipoDesc]),INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;
    RecordDettaglioGG.Alle:=TempStr;

    // coerenza dalle-alle
    if DalleTemp > AlleTemp then
    begin
      MsgBox.MessageBox(Format('Il periodo di % non è corretto!',[TipoDesc]),INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;

    // controlli complessivi sulla tabella
    // - intersezione periodi dalle - alle
    // - presenza di una sola tipologia (servizio / viaggio) al giorno
    if W032DM.selM143.RecordCount > 0 then
    begin
      Msg:='';
      // salva recno iniziale per riposizionamento successivo
      if medpStato = msInsert then
        OldRecNo:=-1
      else
        OldRecNo:=W032DM.selM143.RecNo;
      // ciclo di controlli
      try
        W032DM.selM143.First;
        while not W032DM.selM143.Eof do
        begin
          if (W032DM.selM143.RecNo <> OldRecNo) and
             (RecordDettaglioGG.Data = W032DM.selM143.FieldByName('DATA').AsDateTime)then
          begin
            // 1. verifica intersezione periodi [dalle - alle]
            DalleMin:=R180OreMinutiExt(W032DM.selM143.FieldByName('DALLE').AsString);
            AlleMin:=R180OreMinutiExt(W032DM.selM143.FieldByName('ALLE').AsString);
            if Min(AlleMin,AlleTemp) > Max(DalleMin,DalleTemp) then
            begin
              Msg:=Format('Il periodo di %s indicato interseca'#13#10'un periodo già esistente [%s - %s]',
                          [TipoDesc,
                           W032DM.selM143.FieldByName('DALLE').AsString,
                           W032DM.selM143.FieldByName('ALLE').AsString]);
              Break;
            end;

            // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
            // controllo commentato a seguito della richiesta dello stesso cliente - daniloc. 26/09/2014
            {
            // 2. verifica presenza di una sola tipologia al giorno (servizio / viaggio)
            if W032DM.selM143.FieldByName('TIPO').AsString <> RecordDettaglioGG.Tipo then
            begin
              Msg:='Non è consentito inserire ore di servizio attivo'#13#10'e di viaggio nello stesso giorno!';
              Break;
            end;
            }
            // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine
          end;
          W032DM.selM143.Next;
        end;
      finally
        // posizionamento su record inizialmente selezionato
        if OldRecNo <> -1 then
          W032DM.selM143.RecNo:=OldRecNo;
      end;
      // segnala eventuale anomalia
      if Msg <> '' then
      begin
        MsgBox.MessageBox(Msg,INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end;

    // note del servizio attivo (non obbligatorie)
    c:=medpIndexColonna('NOTE');
    IWC:=medpCompCella(i,c,0);
    RecordDettaglioGG.Note:=Trim((IWC as TmeIWMemo).Text);
  end;

  // controlli ok
  Result:=True;
end;

procedure TW032FRichiestaMissioni.imgInsDettaglioGGClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClickDettaglioGG(Sender,FN);
  grdDettaglioGG.medpStato:=msInsert;
  grdDettaglioGG.medpBrowse:=False;
  TrasformaComponentiDettaglioGG(FN);
end;

procedure TW032FRichiestaMissioni.imgModDettaglioGGClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClickDettaglioGG(Sender,FN);
  grdDettaglioGG.medpStato:=msEdit;
  grdDettaglioGG.medpBrowse:=False;
  TrasformaComponentiDettaglioGG(FN);
end;

procedure TW032FRichiestaMissioni.imgCanDettaglioGGClick(Sender: TObject);
var
  FN: String;
  NumR: Integer;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  with W032DM.selM143 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
      Delete
    else if TryStrToInt(FN,NumR) then
    begin
      // caso di inserimenti con cached updates
      // 1 <= NumR <= RecordCount
      First;
      MoveBy(NumR - 1);
      Delete;
    end;
  end;
  grdDettaglioGG.medpCaricaCDS;
end;

procedure TW032FRichiestaMissioni.imgAnnullaDettaglioGGClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdDettaglioGG.medpStato:=msBrowse;
  TrasformaComponentiDettaglioGG(FN);
  grdDettaglioGG.medpBrowse:=True;
end;

procedure TW032FRichiestaMissioni.imgApplicaDettaglioGGClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // effettua controlli e aggiorna periodo della missione
  // per effettuare il controllo dei servizi attivi in modo corretto
  if not ControlliOK(W032DM.selM140.RowId) then
    Exit;

  W032DM.selM140.Edit;
  W032DM.selM140.FieldByName('DATADA').AsDateTime:=Richiesta.DataDa;
  W032DM.selM140.FieldByName('DATAA').AsDateTime:=Richiesta.DataA;
  W032DM.selM140.FieldByName('ORADA').AsString:=Richiesta.OraDa;
  W032DM.selM140.FieldByName('ORAA').AsString:=Richiesta.OraA;
  W032DM.selM140.Post;

  // effettua controlli bloccanti
  if not CtrlDettaglioGGOK(FN) then
    Exit;

  // inserimento / aggiornamento
  if grdDettaglioGG.medpStato = msInsert then
    actInsDettaglioGG
  else
    actModDettaglioGG(FN);
end;

procedure TW032FRichiestaMissioni.actInsDettaglioGG;
begin
  // aggiornamento dataset (cached updates)
  with W032DM.selM143 do
  begin
    Append;
    FieldByName('ID').AsInteger:=W032DM.selM140.FieldByName('ID').AsInteger;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
    FieldByName('TIPO').AsString:=RecordDettaglioGG.Tipo;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine
    FieldByName('DATA').AsDateTime:=RecordDettaglioGG.Data;
    FieldByName('DALLE').AsString:=RecordDettaglioGG.Dalle;
    FieldByName('ALLE').AsString:=RecordDettaglioGG.Alle;
    FieldByName('NOTE').AsString:=RecordDettaglioGG.Note;
    try
      Post;
      grdDettaglioGG.medpCaricaCDS;
    except
      on E: Exception do
      begin
        MsgBox.MessageBox(Format('Errore durante l''inserimento del dettaglio di %s:'#13#10 +
                                 'Errore: %s'#13#10'Tipo: %s',
                                 [IfThen(RecordDettaglioGG.Tipo = 'S','servizio','viaggio'),E.Message,E.ClassName]),ESCLAMA);
        Exit;
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.actModDettaglioGG(const FN: String);
begin
  // aggiornamento dataset (cached updates)
  with W032DM.selM143 do
  begin
    Edit;
    FieldByName('ID').AsInteger:=W032DM.selM140.FieldByName('ID').AsInteger;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
    FieldByName('TIPO').AsString:=RecordDettaglioGG.Tipo;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine
    FieldByName('DATA').AsDateTime:=RecordDettaglioGG.Data;
    FieldByName('DALLE').AsString:=RecordDettaglioGG.Dalle;
    FieldByName('ALLE').AsString:=RecordDettaglioGG.Alle;
    FieldByName('NOTE').AsString:=RecordDettaglioGG.Note;
    try
      Post;
      grdDettaglioGG.medpCaricaCDS;
    except
      on E: Exception do
      begin
        MsgBox.MessageBox(Format('Errore durante l''aggiornamento del dettaglio di %s.' + CRLF +
                                 'Errore: %s'#13#10'Tipo: %s',
                                 [IfThen(RecordDettaglioGG.Tipo = 'S','servizio','viaggio'),E.Message,E.ClassName]),ESCLAMA);
        Exit;
      end;
    end;
  end;
end;


//######################################//
//###       GESTIONE RIMBORSI        ###//
//######################################//

procedure TW032FRichiestaMissioni.DBGridColumnClickRimb(ASender:TObject; const AValue:string);
var
  TmpRecNo: Integer;
begin
  // in caso di updatespending AValue è numerico ed è il recno del dataset
  if TryStrToInt(AValue,TmpRecNo) then
  begin
    cdsM150.RecNo:=TmpRecNo + IfThen(grdRimborsi.medpRigaInserimento,1); // riga inserimento
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
    //W032DM.selM150.SearchRecord('INDENNITA_KM;CODICE',VarArrayOf([cdsM150.FieldByName('INDENNITA_KM').AsString,cdsM150.FieldByName('CODICE').AsString]),[srFromBeginning]);
    W032DM.selM150.SearchRecord('INDENNITA_KM;CODICE;ID_RIMBORSO',VarArrayOf([cdsM150.FieldByName('INDENNITA_KM').AsString,cdsM150.FieldByName('CODICE').AsString,cdsM150.FieldByName('ID_RIMBORSO').AsInteger]),[srFromBeginning]);
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
  end
  else
  begin
    if cdsM150.Locate('DBG_ROWID',AValue,[]) then
      W032DM.selM150.SearchRecord('ROWID',cdsM150.FieldByName('DBG_ROWID').AsString,[srFromBeginning]);
  end;
end;

procedure TW032FRichiestaMissioni.TrasformaComponentiRimb(const FN:String);
var
  i,c,k:Integer;
  IndKm,NewIns,Found: Boolean;
  IWCmb: TmeIWComboBox;
begin
  i:=grdRimborsi.medpRigaDiCompGriglia(FN);

  // gestione icone comandi
  with (grdRimborsi.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
  begin
    Cell[0,0].Css:=IfThen(grdRimborsi.medpStato <> msBrowse,'invisibile','align_left');
    if i = 0 then
    begin
      // riga di inserimento
      Cell[0,1].Css:=IfThen(grdRimborsi.medpStato <> msBrowse,'align_left','invisibile');
      Cell[0,2].Css:=IfThen(grdRimborsi.medpStato <> msBrowse,'align_right','invisibile');
      if grdRimborsi.medpStato <> msBrowse then
        imgConfermaRimb:=(Cell[0,2].Control as TmeIWImageFile);
    end
    else
    begin
      // dettaglio
      Cell[0,1].Css:=IfThen(grdRimborsi.medpStato <> msBrowse,'invisibile','align_right');
      Cell[0,2].Css:=IfThen(grdRimborsi.medpStato <> msBrowse,'align_left','invisibile');
      Cell[0,3].Css:=IfThen(grdRimborsi.medpStato <> msBrowse,'align_right','invisibile');
      if grdRimborsi.medpStato <> msBrowse then
        imgConfermaRimb:=(Cell[0,3].Control as TmeIWImageFile);
    end;
  end;

  IWCmb:=nil;
  with grdRimborsi do
  begin
    if medpStato <> msBrowse then
    begin
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
      // data rimborso
      if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
      begin
        if medpStato = msInsert then
        begin
          medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','');
          c:=medpIndexColonna('DATA_RIMBORSO');
          medpCreaComponenteGenerico(i,c,Componenti);
          with (medpCompCella(i,c,0) as TmeIWEdit) do
          begin
            // se la missione è di un giorno solo, propone questo in inserimento
            if W032DM.selM140.FieldByName('DATADA').AsDateTime = W032DM.selM140.FieldByName('DATAA').AsDateTime then
              Text:=W032DM.selM140.FieldByName('DATADA').AsString;
            if Text = '' then
              ActiveControl:=(medpCompCella(i,c,0) as TmeIWEdit);
          end;
        end;
      end;

      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
      // voce di rimborso
      if medpStato = msInsert then
      begin
        medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'40','','','','S');
        c:=medpIndexColonna('C_DESCRIZIONE');
        medpCreaComponenteGenerico(i,c,Componenti);
        IWCmb:=(medpCompCella(i,c,0) as TmeIWComboBox);
        with IWCmb do
        begin
          FriendlyName:=FN;
          ItemsHaveValues:=True;
          Items.Assign(ListaRimborsi);
          Items.Insert(0,'=');
          if medpStato = msInsert then
            ItemIndex:=0
          else if medpStato = msEdit then
            ItemIndex:=Items.IndexOfName(medpValoreColonna(i,'DESCRIZIONE'));
          OnChange:=cmbVoceRimborsoChange;
        end;
        IndKm:=W032DM.selM021.SearchRecord('CODICE',IWCmb.Text,[srFromBeginning]);
      end
      else
      begin
        IndKm:=medpValoreColonna(i,'INDENNITA_KM') = 'S';
      end;

      NewIns:=(medpStato = msInsert) and (IWCmb.Text = '');

      // km percorsi
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'5','','','','S');
      c:=medpIndexColonna('KMPERCORSI');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        if (NewIns) or (not IndKm) then
          Css:='invisibile'
        else
          ActiveControl:=(medpCompCella(i,c,0) as TmeIWEdit);
        Text:=medpValoreColonna(i,'KMPERCORSI');
      end;

      // valuta
      medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'15','','','','S');
      c:=medpIndexColonna('COD_VALUTA');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWComboBox) do
      begin
        if NewIns or IndKm then
          Css:='invisibile';
        FriendlyName:=FN;
        ItemsHaveValues:=True;
        Items.Assign(ListaValute);
        if medpStato = msInsert then
          ItemIndex:=0
        else if medpStato = msEdit then
        begin
          // bugfix.ini - daniloc 20.05.2014
          // comportamento modificato da IW nella patch 12.2.29 - la seguente riga non è più esatta
          // ItemIndex:=Items.IndexOfName(medpValoreColonna(i,'COD_VALUTA'));
          for k:=0 to Items.Count do
          begin
            if medpValoreColonna(i,'COD_VALUTA') = Items.ValueFromIndex[k] then
            begin
              Found:=True;
              Break;
            end;
          end;
          if Found then
            ItemIndex:=k;
          // bugfix.fine
        end;
        RequireSelection:=Items.Count > 0;
      end;

      // rimborso
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'5','','','','S');
      c:=medpIndexColonna('RIMBORSO');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        if NewIns or IndKm then
          Css:='invisibile'
        else
          ActiveControl:=(medpCompCella(i,c,0) as TmeIWEdit);
        Text:=medpValoreColonna(i,'RIMBORSO');
      end;

      // note
      {
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'30','','','','S');
      c:=medpIndexColonna('NOTE');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        Text:=medpValoreColonna(i,'NOTE');
      end;
      }
      //Visualizzazione delle note fisse
      medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'50','','','','S');
      c:=medpIndexColonna('NOTE');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWLabel) do
      begin
        Text:=medpValoreColonna(i,'NOTE');
      end;

      // file picker
      {medpPreparaComponenteGenerico('C',0,0,DBG_FPK,'30','','','','S');
      c:=medpIndexColonna('FILE_ALLEGATO');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWFile) do
      begin
        Text:=medpValoreColonna(i,'FILE_ALLEGATO'); // non funziona...
      end;
      }
    end
    else
    begin
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_DESCRIZIONE')]);
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
      if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
        FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('DATA_RIMBORSO')]);
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('KMPERCORSI')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('COD_VALUTA')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('RIMBORSO')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('NOTE')]);
    end;
  end;
end;

procedure TW032FRichiestaMissioni.grdRimborsiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i:Integer;
  IWG: TmeIWGrid;
begin
  if (not SolaLettura) and
     (not WR000DM.Responsabile) then
  begin
    if grdRimborsi.medpRigaInserimento then
    begin
      (grdRimborsi.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInsRimborsoClick;
      (grdRimborsi.medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaRimborsoClick;
      (grdRimborsi.medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgApplicaRimborsoClick;
      with (grdRimborsi.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        // nasconde pulsante di inserimento se non ci sono rimborsi selezionabili
        if ListaRimborsi.Count = 0 then
        begin
          Cell[0,0].Css:='invisibile';
        end;
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:='invisibile';
      end;
    end;

    // righe di dettaglio
    for i:=IfThen(grdRimborsi.medpRigaInserimento,1,0) to High(grdRimborsi.medpCompGriglia) do
    begin
      if (grdRimborsi.medpCompGriglia[i].CompColonne[0] <> nil) then
      begin
        (grdRimborsi.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCanRimborsoClick;
        (grdRimborsi.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModRimborsoClick;
        (grdRimborsi.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaRimborsoClick;
        (grdRimborsi.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgApplicaRimborsoClick;
        IWG:=(grdRimborsi.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
        // il rimborso automatico non è cancellabile né modificabile
        if grdRimborsi.medpValoreColonna(i,'AUTOMATICO') = 'S' then
        begin
          IWG.Cell[0,0].Css:='invisibile';
          IWG.Cell[0,1].Css:='invisibile';
        end;
        // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
        // i rimborsi esistenti sono cancellabili / modificabili solo se STATO is null
        // (non modificabili se vale A,S,I).
        if R180In(grdRimborsi.medpValoreColonna(i,'STATO'),['A','S','I']) then
        begin
          IWG.Cell[0,0].Css:='invisibile';
          IWG.Cell[0,1].Css:='invisibile';
        end;
        // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine
        IWG.Cell[0,2].Css:='invisibile';
        IWG.Cell[0,3].Css:='invisibile';
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.grdRimborsiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  IndKM: Boolean;
  Campo: String;
begin
  if not grdRimborsi.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  if ARow = 0 then
  begin
    // sostituzione spazio -> CRLF su intestazione
    ACell.RawText:=True;
    ACell.Text:=StringReplace(ACell.Text,' ','<br/>',[]);
  end
  else
  begin
    NumColonna:=grdRimborsi.medpNumColonna(AColumn);
    Campo:=grdRimborsi.medpColonna(NumColonna).DataField;

    // assegnazione componenti alle celle
    if (ARow <= High(grdRimborsi.medpCompGriglia) + 1) and (grdRimborsi.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
    begin
      ACell.Control:=grdRimborsi.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
      ACell.Text:='';
    end;

    if (ARow <= High(grdRimborsi.medpCompGriglia) + 1) and (ACell.Control = nil) then
    begin
      // campi con valori allineati al centro
      if (Campo = 'INDENNITA_KM') or
         (Campo = 'KMPERCORSI') or
         (Campo = 'COD_VALUTA') then
      begin
        ACell.Css:=ACell.Css + ' align_center';
      end
      else if (Campo = 'RIMBORSO') or
              (Campo = 'RIMBORSO_VARIATO') then
      begin
        ACell.Css:=ACell.Css + ' align_right';
      end;

      // in base al tipo di rimborso nasconde eventuali informazioni non coerenti
      if (Campo = 'KMPERCORSI') or
         (Campo = 'COD_VALUTA') or
         (Campo = 'RIMBORSO') or
         (Campo = 'RIMBORSO_VARIATO') then
      begin
        IndKM:=W032DM.selM021.SearchRecord('CODICE',grdRimborsi.medpValoreColonna(ARow - 1,'CODICE'),[srFromBeginning]);
        if (Campo = 'KMPERCORSI') and (not IndKM) then
          ACell.Text:='';
        //else if ((Campo = 'COD_VALUTA') or (Campo = 'RIMBORSO') or (Campo = 'RIMBORSO_VARIATO')) and (IndKM) then
        //  ACell.Text:='';
      end;
    end;
  end;
end;

function TW032FRichiestaMissioni.CtrlRimborsoOK(const FN: String): Boolean;
var
  i,x,c: Integer;
  IWC: TIWCustomControl;
  IndKm: Boolean;
  TipoArr,Voce,DescValutaTemp,T: String;
  Arr: double;
  Importo,Limite,SommaRimbPasto: Currency;
  BM: TBookmark;
begin
  Result:=False;
  MsgRimb:='';
  i:=grdRimborsi.medpRigaDiCompGriglia(FN);
  IWC:=nil;

  // codice
  if grdRimborsi.medpStato = msInsert then
  begin
    IWC:=grdRimborsi.medpCompCella(i,'C_DESCRIZIONE',0);
    RecordRimborso.Codice:=(IWC as TmeIWComboBox).Items.ValueFromIndex[(IWC as TmeIWComboBox).ItemIndex];
    if RecordRimborso.Codice = '' then
    begin
      MsgBox.MessageBox('Selezionare una voce di rimborso tra quelle disponibili!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.ini
    T:=VarToStr(W032DM.selM020Rimborsi.Lookup('CODICE',RecordRimborso.Codice,'TIPO_QUANTITA'));
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.fine
    Voce:=(IWC as TmeIWComboBox).Items.Names[(IWC as TmeIWComboBox).ItemIndex];
  end
  else
  begin
    if (FN = '') and (W032DM.selM150.UpdatesPending) then
    begin
      // dati in cache -> utilizza campi del dataset selM150
      RecordRimborso.Codice:=W032DM.selM150.FieldByName('CODICE').AsString;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.ini
      T:=W032DM.selM150.FieldByName('C_TIPO_QUANTITA').AsString;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.fine
      Voce:=RecordRimborso.Codice;
      for x:=0 to ListaRimborsi.Count - 1 do
      begin
        if RecordRimborso.Codice = ListaRimborsi.ValueFromIndex[x] then
        begin
          Voce:=ListaRimborsi.Names[x];
          Break;
        end;
      end;
    end
    else
    begin
      RecordRimborso.Codice:=grdRimborsi.medpValoreColonna(i,'CODICE');
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.ini
      T:=grdRimborsi.medpValoreColonna(i,'C_TIPO_QUANTITA');
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.fine
      Voce:=grdRimborsi.medpValoreColonna(i,'C_DESCRIZIONE');
    end;
  end;
  RecordRimborso.IndennitaKm:=IfThen(W032DM.selM021.SearchRecord('CODICE',RecordRimborso.Codice,[srFromBeginning]),'S','N');

  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
  RecordRimborso.DataRimborso:=DATE_NULL;
  RecordRimborso.IdRimborso:=0;
  if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
  begin
    // id rimborso
    if (FN = '') and (W032DM.selM150.UpdatesPending) then
    begin
      // dati in cache -> utilizza campi del dataset selM150
      RecordRimborso.IdRimborso:=W032DM.selM150.FieldByName('ID_RIMBORSO').AsInteger;
    end
    else
    begin
      RecordRimborso.IdRimborso:=StrToIntDef(grdRimborsi.medpValoreColonna(i,'ID_RIMBORSO'),-1);
    end;

    // data rimborso  (solo in inserimento)
    if grdRimborsi.medpStato = msInsert then
    begin
      IWC:=grdRimborsi.medpCompCella(i,'DATA_RIMBORSO',0);
      // verifica che la data rimborso sia indicata
      if (IWC as TmeIWEdit).Text = '' then
      begin
        MsgBox.MessageBox('E'' necessario indicare la data del rimborso!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
      // verifica che la data rimborso sia valida
      if not TryStrToDateTime((IWC as TmeIWEdit).Text,RecordRimborso.DataRimborso) then
      begin
        MsgBox.MessageBox('La data del rimborso non è valida!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
      // verifica che la data rimborso sia compresa nel periodo della missione
      if (RecordRimborso.DataRimborso < Richiesta.DataDa) or
         (RecordRimborso.DataRimborso > Richiesta.DataA) then
      begin
        MsgBox.MessageBox('La data del rimborso non può essere esterna al periodo della missione!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end
    else
    begin
      if (FN = '') and (W032DM.selM150.UpdatesPending) then
      begin
        // dati in cache -> utilizza campi del dataset selM150
        RecordRimborso.DataRimborso:=W032DM.selM150.FieldByName('DATA_RIMBORSO').AsDateTime;
      end
      else
      begin
        RecordRimborso.DataRimborso:=StrToDate(grdRimborsi.medpValoreColonna(i,'DATA_RIMBORSO'));
      end;
    end;
  end;
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

  IndKm:=W032DM.selM021.SearchRecord('CODICE',RecordRimborso.Codice,[srFromBeginning]);
  if IndKM then
  begin
    // gestione indennità km
    // nessun controllo necessario -> termina subito restituendo False
    if grdRimborsi.medpStato = msBrowse then
      Exit;

    // km percorsi
    IWC:=grdRimborsi.medpCompCella(i,'KMPERCORSI',0);
    if not TryStrToFloat((IWC as TmeIWEdit).Text,RecordRimborso.KmPercorsi) then
    begin
      MsgBox.MessageBox('Indicare i km percorsi!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;

    // importo indennità km
    W032DM.selM021.SearchRecord('CODICE',RecordRimborso.Codice,[srFromBeginning]);
    Importo:=RecordRimborso.KmPercorsi * W032DM.selM021.FieldByName('IMPORTO').AsFloat;
    Arr:=1;
    TipoArr:='P';
    W032DM.P050.Close;
    W032DM.P050.SetVariable('CODICE',W032DM.selM021.FieldByName('ARROTONDAMENTO').AsString);
    W032DM.P050.SetVariable('DECORRENZA',Richiesta.DataA);
    W032DM.P050.Open;
    W032DM.P050.First;
    if not W032DM.P050.Eof then
    begin
      Arr:=W032DM.P050.FieldByName('VALORE').AsFloat;
      TipoArr:=W032DM.P050.FieldByName('TIPO').AsString;
    end;

    RecordRimborso.Rimborso:=R180Arrotonda(Importo,Arr,TipoArr);
    RecordRimborso.CodValuta:=ListaValute.ValueFromIndex[0]; //*** a caso!!!
  end
  else
  begin
    // gestione rimborso
    // valuta
    if grdRimborsi.medpStato <> msBrowse then
    begin
      IWC:=grdRimborsi.medpCompCella(i,'COD_VALUTA',0);
      if (IWC as TmeIWComboBox).ItemIndex < 0 then
      begin
        MsgBox.MessageBox('Selezionare la valuta dall''elenco!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
      RecordRimborso.CodValuta:=(IWC as TmeIWComboBox).Items.ValueFromIndex[(IWC as TmeIWComboBox).ItemIndex];
      DescValutaTemp:=(IWC as TmeIWComboBox).Text;
    end
    else
    begin
      if (FN = '') and (W032DM.selM150.UpdatesPending) then
      begin
        // dati in cache -> utilizza campi del dataset selM150
        RecordRimborso.CodValuta:=W032DM.selM150.FieldByName('COD_VALUTA').AsString;
        DescValutaTemp:=RecordRimborso.CodValuta;
      end
      else
      begin
        RecordRimborso.CodValuta:=grdRimborsi.medpValoreColonna(i,'COD_VALUTA');
        DescValutaTemp:=RecordRimborso.CodValuta;
      end;
    end;

    // importo rimborso
    if grdRimborsi.medpStato <> msBrowse then
    begin
      IWC:=grdRimborsi.medpCompCella(i,'RIMBORSO',0);
      if not TryStrToCurr((IWC as TmeIWEdit).Text,RecordRimborso.Rimborso) then
      begin
        MsgBox.MessageBox('Indicare il valore del rimborso!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end
    else
    begin
      if (FN = '') and (W032DM.selM150.UpdatesPending) then
      begin
        // dati in cache -> utilizza campi del dataset selM150
        RecordRimborso.Rimborso:=W032DM.selM150.FieldByName('RIMBORSO').AsFloat;
      end
      else
      begin
        RecordRimborso.Rimborso:=StrToFloat(grdRimborsi.medpValoreColonna(i,'RIMBORSO'));
      end;
    end;

    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.ini
    // nel caso di tipo quantità F (flag) l'importo del rimborso può essere solo 0 oppure 1
    if T = 'F' then
    begin
      // flag: 0 / 1
      if not ((RecordRimborso.Rimborso = 0) or
              (RecordRimborso.Rimborso = 1)) then
      begin
        MsgBox.MessageBox(Format('La quantità indicata per la voce di rimborso "%s"'#13#10'non è valida!'#13#10'Indicare 0 oppure 1.',[Voce]),INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3 - riesame del 29/07/2014.fine

    // se si tratta di rimborso pasto, limita il numero di pasti secondo le impostazioni
    if RecordRimborso.Codice = CodRimborsoPastoM020 then
    begin
      // imposta variabili fisse per calcolo limite
      with W032DM.M013F_CALC_RIMB_PASTO do
      begin
        SetVariable('TIPORISULTATO','I');
        SetVariable('CODICE',RegolaM010.Codice);
        SetVariable('TIPOREGISTRAZIONE',W032DM.selM140.FieldByName('TIPOREGISTRAZIONE').AsString);
      end;

      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
      if RecordRimborso.DataRimborso = DATE_NULL then
      begin
        // rimborso pasto indicato complessivamente: calcola limite su tutta la durata della missione
        with W032DM.M013F_CALC_RIMB_PASTO do
        begin
          SetVariable('DATADA',Richiesta.DataDa);
          SetVariable('DATAA',Richiesta.DataA);
          SetVariable('ORADA',Richiesta.OraDa);
          SetVariable('ORAA',Richiesta.OraA);
          Execute;
          Limite:=StrToCurr(VarToStr(GetVariable('RESULT')));
        end;

        // verifica sforamento limite rimborso pasto
        if Limite > -1 then
        begin
          // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
          // arrotondamento limite
          if Limite > 0 then
          begin
            Arr:=1;
            TipoArr:='P';
            W032DM.P050.Close;
            W032DM.P050.SetVariable('CODICE',RegolaM010.ArrotTariffaDopoRiduzione);
            W032DM.P050.SetVariable('DECORRENZA',Richiesta.DataA);
            W032DM.P050.Open;
            W032DM.P050.First;
            if not W032DM.P050.Eof then
            begin
              Arr:=W032DM.P050.FieldByName('VALORE').AsFloat;
              TipoArr:=W032DM.P050.FieldByName('TIPO').AsString;
            end;
            Limite:=R180Arrotonda(Limite,Arr,TipoArr);
          end;
          // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

          if RecordRimborso.Rimborso > Limite then
          begin
            RecordRimborso.Rimborso:=Limite;
            MsgRimb:=Format('La quantit&agrave; richiesta per il rimborso pasto &egrave; stata limitata a <b>%s %n</b><br>in base alle regole definite per la missione.',
                            [DescValutaTemp,RecordRimborso.Rimborso]);

            // se il rimborso è limitato a 0 non ne consente l'inserimento
            if RecordRimborso.Rimborso = 0 then
            begin
              MsgRimb:=MsgRimb + #13#10'Il rimborso non può essere inserito!';
              MsgBox.TextIsHTML:=True;
              MsgBox.MessageBox(MsgRimb,INFORMA);
              MsgBox.TextIsHTML:=False;
              if Assigned(IWC) then
              begin
                (IWC as TmeIWEdit).Text:='0';
                ActiveControl:=IWC;
              end;
              Exit;
            end;
          end;
        end;
      end
      else
      begin
        // effettua controlli nel caso in cui la data rimborso è valorizzata
        with W032DM.selM150 do
        begin
          // salva bookmark per successivo riposizionamento
          BM:=GetBookmark;
          try { TODO : TEST IW 15 }
            // filtra i rimborsi pasto presenti alla data del rimborso attuale
            Filter:=Format('(DATA_RIMBORSO = %s) and (CODICE = ''%s'')',[FloatToStr(RecordRimborso.DataRimborso),CodRimborsoPastoM020]);
            Filtered:=True;
            
            // in fase di inserimento verifica che non sia presente più di un codice rimborso pasto
            // CodRimborsoPastoM020 per la data del rimborso corrente
            if (grdRimborsi.medpStato = msInsert) and
               (RecordCount >= MAX_RIMBORSI_PASTO_GG) then
            begin
              Filtered:=False;
              if BookmarkValid(BM) then
                GotoBookmark(BM);              
              MsgBox.MessageBox(Format('Non è consentito indicare più di %d rimborsi pasto al giorno!',[MAX_RIMBORSI_PASTO_GG]),INFORMA);
              Exit;
            end;
            
            // somma tutti i rimborsi pasto, compreso quello corrente
            SommaRimbPasto:=0;
            First;
            while not Eof do
            begin
              if FieldByName('ID_RIMBORSO').AsInteger <> RecordRimborso.IdRimborso then
                SommaRimbPasto:=SommaRimbPasto + FieldByName('RIMBORSO').AsFloat;
              Next;
            end;
            // aggiunge il rimborso corrente
            SommaRimbPasto:=SommaRimbPasto + RecordRimborso.Rimborso;
            
            // rimuove filtro temporaneo e riposiziona bookmark
            Filtered:=False;
            if BookmarkValid(BM) then
              GotoBookmark(BM);
		      finally
		        // Da qui in poi il bookmark non serve più.
            FreeBookmark(BM);
		      end;

          // verifica che il totale non sfori il limite calcolato da W032DM.M013F_CALC_RIMB_PASTO
          with W032DM.M013F_CALC_RIMB_PASTO do
          begin
            SetVariable('DATADA',RecordRimborso.DataRimborso);
            SetVariable('DATAA',RecordRimborso.DataRimborso);
            if Richiesta.DataDa = Richiesta.DataA then
            begin
              // missione di un solo giorno
              // [inizio missione - fine missione]
              SetVariable('ORADA',Richiesta.OraDa);
              SetVariable('ORAA',Richiesta.OraA);
            end
            else if RecordRimborso.DataRimborso = Richiesta.DataDa then
            begin
              // rimborso pasto nel giorno di inizio missione
              // [inizio missione - 23.59]
              SetVariable('ORADA',Richiesta.OraDa);
              SetVariable('ORAA','23.59');
            end
            else if RecordRimborso.DataRimborso = Richiesta.DataDa then
            begin
              // rimborso pasto nel giorno di fine missione
              // [00.00 - fine missione]
              SetVariable('ORADA','00.00');
              SetVariable('ORAA',Richiesta.OraA);
            end
            else
            begin
              // rimborso pasto in un giorno intermedio
              // [00.00 - 23.59]
              SetVariable('ORADA','00.00');
              SetVariable('ORAA','23.59');
            end;
            Execute;
            Limite:=GetVariable('RESULT');
          end;

          // verifica sforamento limite rimborso pasto
          if Limite > -1 then
          begin
            // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
            // arrotondamento limite
            if Limite > 0 then
            begin
              Arr:=1;
              TipoArr:='P';
              W032DM.P050.Close;
              W032DM.P050.SetVariable('CODICE',RegolaM010.ArrotTariffaDopoRiduzione);
              W032DM.P050.SetVariable('DECORRENZA',RecordRimborso.DataRimborso);
              W032DM.P050.Open;
              W032DM.P050.First;
              if not W032DM.P050.Eof then
              begin
                Arr:=W032DM.P050.FieldByName('VALORE').AsFloat;
                TipoArr:=W032DM.P050.FieldByName('TIPO').AsString;
              end;
              Limite:=R180Arrotonda(Limite,Arr,TipoArr);
            end;
            // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

            if SommaRimbPasto > Limite then
            begin
              RecordRimborso.Rimborso:=(Limite - (SommaRimbPasto - RecordRimborso.Rimborso)); // RecordRimborso.Rimborso + Limite - SommaRimbPasto
              MsgRimb:=Format('La quantit&agrave; richiesta per il rimborso pasto<br>del <b>%s</b> &egrave; stata limitata a <b>%s %n</b><br>in base alle regole definite per la missione.',
                              [DateToStr(RecordRimborso.DataRimborso),DescValutaTemp,RecordRimborso.Rimborso]);

              // se il rimborso è limitato a 0 non ne consente l'inserimento
              if RecordRimborso.Rimborso = 0 then
              begin
                MsgRimb:=MsgRimb + '<br>Il rimborso non pu&ograve; essere inserito';
                MsgBox.TextIsHTML:=True;
                MsgBox.MessageBox(MsgRimb,INFORMA);
                MsgBox.TextIsHTML:=False;
                (IWC as TmeIWEdit).Text:='0';
                ActiveControl:=IWC;
                Exit;
              end;
            end;
          end;
        end;
      end;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
    end;

    RecordRimborso.KmPercorsi:=0;
  end;

  RecordRimborso.Note:='';
  RecordRimborso.FileAllegato:='';

  if FN <> '' then
  begin
    // note
    {
    c:=grdRimborsi.medpIndexColonna('NOTE');
    IWC:=grdRimborsi.medpCompCella(i,c,0);
    RecordRimborso.Note:=(IWC as TmeIWEdit).Text;
    }
    // note fisse
    c:=grdRimborsi.medpIndexColonna('NOTE');
    IWC:=grdRimborsi.medpCompCella(i,c,0);
    RecordRimborso.Note:=(IWC as TmeIWLabel).Text;

    // file allegato
    {
    c:=grdRimborsi.medpIndexColonna('FILE_ALLEGATO');
    IWC:=grdRimborsi.medpCompCella(i,c,0);
    if Trim((IWC as TmeIWFile).Filename) = '' then
    begin
      MsgBox.MessageBox('Indicare il file del giustificativo di spesa!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;
    RecordRimborso.FileAllegato:=Trim((IWC as TmeIWFile).Filename);
    }
  end;

  // verifica duplicazione di chiave
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
  if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
  begin
    // data rimborso: gestita
    // previsti codici di rimborso uguali, anche sulla stessa data
    // nessun controllo!
  end
  else
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
  begin
    // data rimborso: non gestita
    // previsto un solo codice di rimborso per richiesta
    // nota: in modifica il codice non è modificabile
    if (grdRimborsi.medpStato = msInsert) and
       (W032DM.selM150.SearchRecord('CODICE',RecordRimborso.Codice,[srFromBeginning])) then
    begin
      MsgBox.MessageBox(Format('La voce di rimborso'#13#10'"%s"'#13#10'è già presente nella tabella!',[Voce]),INFORMA);
      Exit;
    end;
  end;

  Result:=True;
end;

function TW032FRichiestaMissioni.CtrlSommaIndKmOK: Boolean;
// verifica che la somma dei km richiesti come indennità sia >= 0
var
  OldFiltered: Boolean;
  TotKm: Integer;
begin
  with W032DM.selM150 do
  begin
    // filtra il dataset dei rimborsi in modo da considerare solo
    // le voci di indennità chilometrica
    OldFiltered:=Filtered;
    try
      Filtered:=False;
      Filter:='INDENNITA_KM = ''S''';
      Filtered:=True;

      // ciclo sulle indennità per calcolare la somma
      TotKm:=0;
      First;
      while not Eof do
      begin
        TotKm:=TotKm + FieldByName('KMPERCORSI').AsInteger;
        Next;
      end;
      Filtered:=OldFiltered;
    except
      TotKm:=0;
    end;
  end;

  // richieste indennità ok se il totale dei km è >= 0
  Result:=TotKm >= 0;
end;

procedure TW032FRichiestaMissioni.imgInsRimborsoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClickRimb(Sender,FN);
  grdRimborsi.medpStato:=msInsert;
  grdRimborsi.medpBrowse:=False;
  TrasformaComponentiRimb(FN);
end;

procedure TW032FRichiestaMissioni.imgModRimborsoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClickRimb(Sender,FN);
  grdRimborsi.medpStato:=msEdit;
  grdRimborsi.medpBrowse:=False;
  TrasformaComponentiRimb(FN);
end;

procedure TW032FRichiestaMissioni.imgCanRimborsoClick(Sender: TObject);
var
  FN: String;
  NumR: Integer;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  with W032DM.selM150 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
      Delete
    else if TryStrToInt(FN,NumR) then
    begin
      // caso di inserimenti con cached updates
      // 1 <= NumR <= RecordCount
      First;
      MoveBy(NumR - 1);
      Delete;
    end;
  end;
  grdRimborsi.medpCaricaCDS;
end;

procedure TW032FRichiestaMissioni.imgAnnullaRimborsoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdRimborsi.medpStato:=msBrowse;
  TrasformaComponentiRimb(FN);
  grdRimborsi.medpBrowse:=True;
end;

procedure TW032FRichiestaMissioni.imgApplicaRimborsoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // effettua controlli e aggiorna periodo della missione
  // per effettuare il controllo rimborsi in modo corretto
  if not ControlliOK(W032DM.selM140.RowId) then
    Exit;

  W032DM.selM140.Edit;
  W032DM.selM140.FieldByName('DATADA').AsDateTime:=Richiesta.DataDa;
  W032DM.selM140.FieldByName('DATAA').AsDateTime:=Richiesta.DataA;
  W032DM.selM140.FieldByName('ORADA').AsString:=Richiesta.OraDa;
  W032DM.selM140.FieldByName('ORAA').AsString:=Richiesta.OraA;
  W032DM.selM140.Post;

  // effettua controlli bloccanti
  if not CtrlRimborsoOK(FN) then
    Exit;

  // inserimento / aggiornamento
  if grdRimborsi.medpStato = msInsert then
    actInsRimborso
  else
    actModRimborso(FN);
end;

procedure TW032FRichiestaMissioni.actInsRimborso;
// effettua l'inserimento della voce di rimborso
var
  IdRimbMax: Integer;
begin
  // aggiornamento dataset (cached updates)
  with W032DM.selM150 do
  begin
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
    IdRimbMax:=-1;
    if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
    begin
      // cerca il max ID_RIMBORSO per ID + INDENNITA_KM + CODICE
      if RecordCount > 0 then
      begin
        Filter:=Format('(ID = %s) and (INDENNITA_KM = ''%s'') and (CODICE = ''%s'')',
                       [W032DM.selM140.FieldByName('ID').AsString,
                        RecordRimborso.IndennitaKm,
                        RecordRimborso.Codice]);
        Filtered:=True;
        First;
        while not Eof do
        begin
          if FieldByName('ID_RIMBORSO').AsInteger > IdRimbMax then
            IdRimbMax:=FieldByName('ID_RIMBORSO').AsInteger;
          Next;
        end;
        Filtered:=False;
      end;
    end;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine

    Append;
    FieldByName('ID').AsInteger:=W032DM.selM140.FieldByName('ID').AsInteger;
    FieldByName('CODICE').AsString:=RecordRimborso.Codice;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
    if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
    begin
      FieldByName('DATA_RIMBORSO').AsDateTime:=RecordRimborso.DataRimborso;
      FieldByName('ID_RIMBORSO').AsInteger:=IdRimbMax + 1;
    end;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
    FieldByName('KMPERCORSI').AsFloat:=RecordRimborso.KmPercorsi;
    FieldByName('INDENNITA_KM').AsString:=RecordRimborso.IndennitaKm;
    FieldByName('COD_VALUTA').AsString:=RecordRimborso.CodValuta;
    FieldByName('RIMBORSO').AsFloat:=RecordRimborso.Rimborso;
    FieldByName('NOTE').AsString:=RecordRimborso.Note;
    FieldByName('FILE_ALLEGATO').AsString:=RecordRimborso.FileAllegato;
    try
      Post;
      grdRimborsi.medpCaricaCDS;
      if MsgRimb <> '' then
      begin
        //MessaggioStatus(INFORMA,MsgRimb,15000);
        MsgBox.TextIsHTML:=True;
        MsgBox.MessageBox(MsgRimb,INFORMA);
        MsgBox.TextIsHTML:=False;
      end;
    except
      on E: Exception do
      begin
        MsgBox.MessageBox('Errore durante l''inserimento della voce di rimborso:' + CRLF +
                          'Errore: ' + E.Message + CRLF +
                          'Tipo: ' + E.ClassName,ESCLAMA);
        Exit;
      end;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.actModRimborso(const FN: String);
begin
  // aggiornamento dataset (cached updates)
  with W032DM.selM150 do
  begin
    Edit;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.ini
    if Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S' then
      FieldByName('DATA_RIMBORSO').AsDateTime:=RecordRimborso.DataRimborso
    else
      FieldByName('DATA_RIMBORSO').Value:=null;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#3.fine
    FieldByName('KMPERCORSI').AsFloat:=RecordRimborso.KmPercorsi;
    FieldByName('COD_VALUTA').AsString:=RecordRimborso.CodValuta;
    FieldByName('NOTE').AsString:=RecordRimborso.Note;
    FieldByName('FILE_ALLEGATO').AsString:=RecordRimborso.FileAllegato;
    FieldByName('RIMBORSO').AsFloat:=RecordRimborso.Rimborso;
    try
      Post;
      grdRimborsi.medpCaricaCDS;
      if MsgRimb <> '' then
      begin
        MsgBox.TextIsHTML:=True;
        MsgBox.MessageBox(MsgRimb,INFORMA);
        MsgBox.TextIsHTML:=False;
      end;
    except
      on E: Exception do
      begin
        MsgBox.MessageBox('Errore durante l''aggiornamento della voce di rimborso:' + CRLF +
                          'Errore: ' + E.Message + CRLF +
                          'Tipo: ' + E.ClassName,ESCLAMA);
        Exit;
      end;
    end;
  end;
end;

//######################################//

procedure TW032FRichiestaMissioni.edtCercaDelegatoSubmit(Sender: TObject);
begin
  btnCercaDelegatoClick(btnCercaDelegato);
end;

procedure TW032FRichiestaMissioni.chkDelegatoClick(Sender: TObject);
begin
  lblDelegato.Visible:=chkDelegato.Checked;
  edtCercaDelegato.Visible:=chkDelegato.Checked;
  if not edtCercaDelegato.Visible then
    edtCercaDelegato.Text:='';
  cmbDelegato.Visible:=False;
  cmbDelegato.ItemIndex:=0;
  btnCercaDelegato.Visible:=chkDelegato.Checked;
  if not chkDelegato.Checked then
  begin
    lblDelegato.Caption:='Cerca delegato per cognome / matricola:';
    lblDelegato.ForControl:=edtCercaDelegato;
    btnCercaDelegato.Caption:='Cerca delegato';
  end;
end;

procedure TW032FRichiestaMissioni.cmbFlagDestinazioneChange(Sender: TObject);
var
  i: Integer;
begin
  if (Sender as TmeIWComboBox).ItemIndex = 2 then
  begin
    // estero
    cgpMotivEstero.Css:=CssIniCgp;
    cgpIpotesiEstero.Css:=CssIniCgp;
  end
  else
  begin
    // Italia
    cgpMotivEstero.Css:='invisibile';
    cgpIpotesiEstero.Css:='invisibile';
    for i:=0 to cgpMotivEstero.Items.Count - 1 do
      cgpMotivEstero.IsChecked[i]:=False;
    for i:=0 to cgpIpotesiEstero.Items.Count - 1 do
      cgpIpotesiEstero.IsChecked[i]:=False;
  end;
end;

procedure TW032FRichiestaMissioni.cmbVoceAnticipoChange(Sender: TObject);
var
  Codice,TipoQta: String;
  V: double;
  i,c: Integer;
begin
  Codice:=(Sender as TmeIWComboBox).Items.ValueFromIndex[(Sender as TmeIWComboBox).ItemIndex];

  if Codice = '' then
    TipoQta:=''
  else
    TipoQta:=W032DM.selM020Anticipi.Lookup('CODICE',Codice,'TIPO_QUANTITA');

  with grdAnticipi do
  begin
    i:=medpRigaDiCompGriglia((Sender as TmeIWComboBox).FriendlyName);

    // quantità
    c:=medpIndexColonna('QUANTITA');
    with (medpCompGriglia[i].CompColonne[c] as TmeIWGrid) do
    begin
      if TipoQta = '' then
      begin
        Cell[0,0].Css:='invisibile';
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:='invisibile';
        Cell[0,3].Css:='invisibile';
      end
      else
      begin
        Cell[0,0].Css:=IfThen(TipoQta <> 'F','','invisibile');
        Cell[0,1].Css:=IfThen(TipoQta = 'F','','invisibile');
        Cell[0,2].Css:=IfThen(TipoQta = 'Q','','invisibile');
        Cell[0,3].Css:=IfThen(TipoQta = 'I','','invisibile');
      end;
    end;

    if TipoQta <> '' then
    begin
      V:=0;
      if medpStato = msEdit then
        V:=StrToFloat(medpValoreColonna(i,'QUANTITA'));
      if TipoQta = 'F' then
      begin
        // F = flag
        (medpCompCella(i,c,0) as TmeIWLabel).Caption:='';
        (medpCompCella(i,c,1) as TmeIWCheckBox).Checked:=(V = 1)
      end
      else if TipoQta = 'Q' then
      begin
        // Q = quantità
        (medpCompCella(i,c,0) as TmeIWLabel).Caption:='n.';
        (medpCompCella(i,c,2) as TmeIWEdit).Text:=IntToStr(Trunc(V))
      end
      else if TipoQta = 'I' then
      begin
        // I = importo
        (medpCompCella(i,c,0) as TmeIWLabel).Caption:='€';
        (medpCompCella(i,c,3) as TmeIWEdit).Text:=FloatToStr(V);
      end;
    end;

    c:=medpIndexColonna('C_PERC_ANTICIPO');
    (medpCompCella(i,c,0) as TmeIWLabel).Caption:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',Codice,'PERC_ANTICIPO'));
    if (medpCompCella(i,c,0) as TmeIWLabel).Caption <> '' then
      (medpCompCella(i,c,0) as TmeIWLabel).Caption:=(medpCompCella(i,c,0) as TmeIWLabel).Caption + '%';
    c:=medpIndexColonna('C_NOTE_FISSE');
    (medpCompCella(i,c,0) as TmeIWLabel).Caption:=VarToStr(W032DM.selM020Anticipi.Lookup('CODICE',Codice,'NOTE_FISSE'));
  end;
end;

procedure TW032FRichiestaMissioni.cmbVoceRimborsoChange(Sender: TObject);
var
  Codice: String;
  IndKm: Boolean;
  i,c: Integer;
  IWEdtKm,IWEdtRimb: TmeIWEdit;
  IWCmbVal: TmeIWComboBox;
begin
  Codice:=(Sender as TmeIWComboBox).Items.Valuefromindex[(Sender as TmeIWComboBox).ItemIndex];
  IndKm:=False;
  if Codice <> '' then
    IndKm:=W032DM.selM021.SearchRecord('CODICE',Codice,[srFromBeginning]);

  with grdRimborsi do
  begin
    i:=medpRigaDiCompGriglia((Sender as TmeIWComboBox).FriendlyName);

    // visibilità campo "km percorsi"
    c:=medpIndexColonna('KMPERCORSI');
    IWEdtKm:=(medpCompGriglia[i].CompColonne[c] as TmeIWEdit);
    if Codice = '' then
      IWEdtKm.Css:='invisibile'
    else
      IWEdtKm.Css:=IfThen(IndKm,'width5chr','invisibile');

    // visibilità campo "valuta"
    c:=medpIndexColonna('COD_VALUTA');
    IWCmbVal:=(medpCompGriglia[i].CompColonne[c] as TmeIWComboBox);
    if Codice = '' then
      IWCmbVal.Css:='invisibile'
    else
      IWCmbVal.Css:=IfThen(IndKm,'invisibile','width15chr');

    // visibilità campo "rimborso"
    c:=medpIndexColonna('RIMBORSO');
    IWEdtRimb:=(medpCompGriglia[i].CompColonne[c] as TmeIWEdit);
    if Codice = '' then
      IWEdtRimb.Css:='invisibile'
    else
      IWEdtRimb.Css:=IfThen(IndKm,'invisibile','width5chr');

    //Scrivo le note fisse relative alla voce di rimborso scelta
    c:=medpIndexColonna('NOTE');
    (medpCompGriglia[i].CompColonne[c] as TmeIWLabel).Text:=VarToStr(W032DM.selM020Rimborsi.Lookup('CODICE',Codice,'NOTE_FISSE'));

    if Codice <> '' then
    begin
      if IndKm then
        ActiveControl:=IWEdtKm
      else
        ActiveControl:=IWEdtRimb;
    end;
  end;
end;

procedure TW032FRichiestaMissioni.btnCercaDelegatoClick(Sender: TObject);
var
  Cerca: Boolean;
begin
  Cerca:=btnCercaDelegato.Caption = 'Cerca delegato';
  if Cerca then
  begin
    if Trim(edtCercaDelegato.Text) = '' then
    begin
      MsgBox.MessageBox('Indicare la matricola del delegato, oppure il cognome o parte di esso',INFORMA);
      ActiveControl:=edtCercaDelegato;
      Exit;
    end;
    cmbDelegato.Items.Clear;
    with W032DM.selNomeDelegato do
    begin
      Filter:='';
      Filtered:=False;
      Close;
      SetVariable('MATRICOLA',IfThen(Sender = nil,'S','N'));
      SetVariable('VALORE',edtCercaDelegato.Text);
      if not WR000DM.Responsabile then
      begin
        Filter:='PROGRESSIVO <> ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString;
        Filtered:=True;
      end;
      Open;
      if RecordCount = 0 then
      begin
        MsgBox.MessageBox('Nessun dipendente trovato',INFORMA);
        ActiveControl:=edtCercaDelegato;
        Exit;
      end
      else
      begin
        cmbDelegato.Items.Add('Selezionare il delegato');
        while not Eof do
        begin
          cmbDelegato.Items.Add(Format('%-8s %s %s',[FieldByName('MATRICOLA').AsString,
                                                     FieldByName('COGNOME').AsString,
                                                     FieldByName('NOME').AsString]));
          Next;
        end;
        cmbDelegato.ItemIndex:=IfThen(RecordCount = 1,1,0);
      end;
      Close;
    end;
  end;

  // switch funzione pulsante
  lblDelegato.Caption:=IfThen(Cerca,'Nominativo:','Cerca delegato per cognome / matricola:');
  if Cerca then
    lblDelegato.ForControl:=cmbDelegato
  else
    lblDelegato.ForControl:=edtCercaDelegato;
  edtCercaDelegato.Visible:=not Cerca;
  cmbDelegato.Visible:=Cerca;
  btnCercaDelegato.Caption:=IfThen(Cerca,'Pulisci','Cerca delegato');
end;

//#########################//
//###   AUTORIZZAZIONE  ###//
//#########################//

procedure TW032FRichiestaMissioni.chkAutorizzazioneClick(Sender: TObject);
begin
  Autorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  Autorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  Autorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  // verifica presenza record
  W032DM.selM140.Refresh;
  if not W032DM.selM140.SearchRecord('ROWID',Autorizza.RowId,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox('Attenzione! La richiesta da autorizzare non è più disponibile!',INFORMA);
    Exit;
  end;
  DBGridColumnClick(Sender,Autorizza.Rowid);
  AutorizzazioneOK;
end;

procedure TW032FRichiestaMissioni.GestioneFasi(const PFasePrima, PFaseDopo: Integer; const PRiapriMissione: Boolean = False);
// procedura eseguita a seguito di un'autorizzazione per la gestione delle fasi
// a partire dalla fase di partenza fino a quella finale
// parametri
//   PFasePrima:
//     fase iniziale
//   PFaseDopo
//     fase finale
//   PRiapriMissione
//     indicare True nel caso particolare di richiamo dalla funzione di riapertura missione
//     (attiva solo per effetto di parametrizzazione a livello aziendale)
var
  F,Ini,IdRich: Integer;
  Avanzamento: Boolean;
  function Continua(const F: Integer): Boolean;
  begin
    if Avanzamento then
      Result:=F <= PFaseDopo
    else
      Result:=F >= PFaseDopo;
  end;
begin
  Avanzamento:=PFasePrima < PFaseDopo;
  Ini:=PFasePrima + IfThen(Avanzamento,1,-1);
  IdRich:=W032DM.selM140.FieldByName('ID').AsInteger;
  try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.Inizio %d - %d',[IdRich,PFasePrima,PFaseDopo]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger); except end;

  F:=Ini;
  while Continua(F) do
  begin
    try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.Fase %d',[IdRich,F]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger); except end;
    case F of
      M140FASE_AUTORIZZAZIONE:
        // fase 1
        // missioni e anticipi autorizzati e non più modificabili; non si possono ancora importare su M040
        begin
          // nessuna operazione
        end;
      M140FASE_AGVIAGGIO:
        // fase 2
        // missioni e anticipi visibili alla fase di importazione (cassa economale)
        begin
          if Avanzamento then
          begin
            // nessuna operazione
          end
          else
          begin
            // cancella missione da M040
            try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.delM040',[IdRich]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger); except end;
            W032DM.delM040.SetVariable('ANNULLAMENTO','N');
            W032DM.delM040.SetVariable('ID',IdRich);
            W032DM.delM040.Execute;
            // cancella anticipi da M060
            W032DM.delM060.SetVariable('ID',IdRich);
            W032DM.delM060.Execute;
            SessioneOracle.Commit;
          end;
        end;
      M140FASE_CASSA:
        // fase 3
        begin
          if Avanzamento then
          begin
            // (TORINO_REGIONE: normalmente lo fa applicativo cassa economale del csi)
            // inserimento missione su M040
            try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.M040P_CARICA_MISSIONE_DAITER',[IdRich]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger); except end;
            W032DM.M040P_CARICA_MISSIONE_DAITER.SetVariable('ID',IdRich);
            W032DM.M040P_CARICA_MISSIONE_DAITER.Execute;
            // inserimento anticipi su M060
            try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.M060P_CARICA_ANTICIPI_DAITER',[IdRich]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger); except end;
            W032DM.M060P_CARICA_ANTICIPI_DAITER.SetVariable('ID',IdRich);
            W032DM.M060P_CARICA_ANTICIPI_DAITER.Execute;
            SessioneOracle.Commit;
          end
          else
          begin
            // annulla stato dei rimborsi richiesti su M150 (solo quelli con stato <> 'I' (inserito))
            W032DM.updM150.SetVariable('ID',IdRich);
            W032DM.updM150.SetVariable('SETVALORI','STATO = null');
            W032DM.updM150.Execute;
            // riporta la missione in stato 'S' (sospeso) se era ancora 'D' (da liquidare)
            W032DM.updM040Stato.SetVariable('ID',IdRich);
            W032DM.updM040Stato.Execute;
            SessioneOracle.Commit;
          end;
        end;
      M140FASE_RIMBORSI:
        // fase 4
        // rimborsi già autorizzati ma in attesa di validazione da uff.missioni
        begin
          if Avanzamento then
          begin
            // imposta stato dei rimborsi richiesti = 'A' (autorizzato) su M150 (solo quelli con stato <> 'I' (inserito))
            W032DM.updM150.SetVariable('ID',IdRich);
            W032DM.updM150.SetVariable('SETVALORI','STATO = ''A'''); // 'A' = Autorizzato
            W032DM.updM150.Execute;
            SessioneOracle.Commit;
          end
          else
          begin
            // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
            // valuta se si tratta di una riapertura della richiesta
            if PRiapriMissione then
            begin
              // nessuna operazione
            end
            else
            // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine
            begin
              // cancella i rimborsi da M050 / M052
              // cancella i servizi attivi da M043
              // cancella eventuali giustificativi legati alla richiesta
              // riporta la missione in stato Sospeso
              try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.delRimborsi',[IdRich]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger); except end;
              W032DM.delRimborsi.SetVariable('ID',IdRich);
              W032DM.delRimborsi.Execute;
              SessioneOracle.Commit;
            end;
          end;
        end;
      M140FASE_CHIUSURA:
        // fase 5
        // rimborsi validati da uff.missioni importati su M050
        begin
          if Avanzamento then
          begin
            // inserimento rimborsi su:
            // - M050
            // - M051 (dettaglio)
            // - M052 (indennità km)
            // inserimento servizi attivi su M043
            try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; GestioneFasi.M050P_CARICA_RIMBORSI_DAITER',[IdRich]),Parametri.Azienda,W032DM.selM140.FieldByName('PROGRESSIVO').AsInteger); except end;
            W032DM.M050P_CARICA_RIMBORSI_DAITER.SetVariable('ID',IdRich);
            W032DM.M050P_CARICA_RIMBORSI_DAITER.Execute;
            SessioneOracle.Commit;
          end
          else
          begin
            // non previsto
          end;
        end;
    end;

    if Avanzamento then
      inc(F)
    else
      dec(F);
  end;
end;

procedure TW032FRichiestaMissioni.AutorizzazioneOK;
var
  Aut,Resp,NewTipoRich,MsgErr: String;
  F1,F2:Integer;
  FaseRimborsi: Boolean;
begin
  Aut:='';
  Resp:='';

  // autorizzazione richiesta
  with W032DM.selM140 do
  begin
    // imposta i dati di autorizzazione
    Refresh; //sostituire con Refreshrecord??
    if not SearchRecord('ROWID',Autorizza.Rowid,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('Attenzione! La richiesta da autorizzare è stata modificata nel frattempo.' + CRLF +
                        'Verificarne nuovamente i dati prima di procedere!',INFORMA);
      Exit;
    end;
    Resp:=Parametri.Operatore;
    if Autorizza.Checked and (Autorizza.Caption = 'Si') then
    begin
      // autorizzazione SI
      Aut:=C018SI;

      // in caso di autorizzazione viene eseguita la function oracle personalizzata M140F_CHECKRICHIESTA
      // se il risultato non è nullo, significa che sono presenti errori (non bloccanti):
      // in questo caso visualizzare il messaggio a video un msgbox
      try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; AutorizzazioneOK.M140F_CHECKRICHIESTA non bloccante',[W032DM.selM140.FieldByName('ID').AsInteger]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
      with W032DM.M140F_CHECKRICHIESTA do
      begin
        try
          SetVariable('ID',W032DM.selM140.FieldByName('ID').AsInteger);
          SetVariable('LIVELLO',W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger);
          SetVariable('FASE',W032DM.selM140.FieldByName('FASE_CORRENTE').AsInteger);
          SetVariable('CHIUSURA','N');
          Execute;
          MsgErr:=VarToStr(GetVariable('RESULT'));
        except
          on E: Exception do
          begin
            MsgErr:=Format('%s (%s)',[E.Message,E.ClassName]);
          end;
        end;
        if MsgErr <> '' then
        begin
          MsgErr:=Format('Avviso:'#13#10'%s',[MsgErr]);
          MsgBox.AddMessage(MsgErr);
        end;
      end;
    end
    else if Autorizza.Checked and (Autorizza.Caption = 'No') then
    begin
      // autorizzazione NO
      Aut:=C018NO;
    end
    else if not Autorizza.Checked then
    begin
      // autorizzazione non impostata
      Aut:='';
    end;

    // salva i dati di autorizzazione
    try
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      F1:=FieldByName('FASE_CORRENTE').AsInteger;

      try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; AutorizzazioneOK.InsAutorizzazione',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
      // se il responsabile dei rimborsi nega la richiesta
      // lo stato deve essere impostato a null
      FaseRimborsi:=(FieldByName('TIPO_RICHIESTA').AsString = '4') and (F1 = M140FASE_CASSA);
      FaseRimborsi:=FaseRimborsi or ((Aut = C018NO) and (FieldByName('TIPO_RICHIESTA').AsString = '5') and (F1 = M140FASE_RIMBORSI));
      try RegistraMsg.InserisciMessaggio('I',Format('ID = %d; AutorizzazioneOK.FaseRimborsi=%s: TIPO_RICHIESTA=%s, F1=%s, Aut=%s',
                                                    [W032DM.selM140.FieldByName('ID').AsInteger,
                                                     IfThen(FaseRimborsi,'True','False'),
                                                     FieldByName('TIPO_RICHIESTA').AsString,
                                                     F1.ToString,
                                                     Aut]),
                                         Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger); except end;
      if FaseRimborsi and (Aut = C018NO) then
        Aut:='';
      C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Resp,'','');
      F2:=C018.FaseCorrente;

      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione)
      else
      begin
        RegistraLog.SettaProprieta('M','M140_RICHIESTE_MISSIONI','W032',nil,True);
        RegistraLog.InserisciDato('ID',FieldByName('ID').AsString,'');
        RegistraLog.InserisciDato('PROGRESSIVO',FieldByName('PROGRESSIVO').AsString,'');
        RegistraLog.InserisciDato('FASERIMBORSI',IfThen(FaseRimborsi,'True','False'),'');
        RegistraLog.InserisciDato('AUT',Aut,'');
        RegistraLog.InserisciDato('TIPO_RICHIESTA',FieldByName('TIPO_RICHIESTA').AsString,'');
        RegistraLog.InserisciDato('F1',F1.ToString,'');
        RegistraLog.InserisciDato('F2',F2.ToString,'');
        RegistraLog.RegistraOperazione;
        GestioneFasi(F1,F2);
        if FaseRimborsi then
        begin
          // attualmente tipo richiesta = '4'
          // se autorizzazione SI -> tipo richiesta avanza a '5'
          // altrimenti -> riporta tipo_richiesta a '0', in modo che il dipendente possa modificare i rimborsi
          NewTipoRich:=IfThen(Aut = C018SI,'5','0');
          C018.SetTipoRichiesta(NewTipoRich);
          if (Aut = C018SI) and (F2 = M140FASE_RIMBORSI) and (NewTipoRich = '5') then
            GestioneFasi(M140FASE_RIMBORSI,M140FASE_CHIUSURA);
        end;
        SessioneOracle.Commit;
      end;
    except
      on E: Exception do
        MsgBox.AddMessage('Impostazione dell''autorizzazione fallita!' + CRLF +
                          'Errore: ' + E.Message + CRLF +
                          IfThen(E.ClassName <> 'Exception',#13#10'Tipo: ' + E.ClassName),mtWarning);
    end;
    MsgBox.ShowMessages;
    VisualizzaDipendenteCorrente;
  end;
end;

procedure TW032FRichiestaMissioni.TrasformaComponentiAut(const FN: String);
var
  DaTestoAControlli:Boolean;
  i,c:Integer;
  IWC: TIWCustomControl;
  IWLbl: TIWCustomControl;
  DatoPers: TDatoPersonalizzato;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  c:=grdRichieste.medpIndexColonna('DBG_COMANDI');

  DaTestoAControlli:=grdRichieste.medpStato <> msBrowse;

  // abilitazione checbox di autorizzazione
  if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
  begin
    (grdRichieste.medpCompCella(i,0,0) as TmeIWCheckBox).Enabled:=not DaTestoAControlli;
    (grdRichieste.medpCompCella(i,0,1) as TmeIWCheckBox).Enabled:=not DaTestoAControlli;
  end;

  // gestione icone comandi
  with (grdRichieste.medpCompGriglia[i].CompColonne[c] as TmeIWGrid) do
  begin
    Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile','align_left');
    Cell[0,1].Css:=IfThen(DaTestoAControlli,'align_left','invisibile');
    Cell[0,2].Css:=IfThen(DaTestoAControlli,'align_right','invisibile');
  end;

  if DaTestoAControlli then
  begin
    // tabella dei dati personalizzati
    for i:=0 to grdDati.RowCount - 1 do
    begin
      // abilitazione del componente
      IWLbl:=grdDati.Cell[i,0].Control;
      IWC:=grdDati.Cell[i,1].Control;
      if (IWLbl <> nil) and (IWC <> nil) then
      begin
        if IWC is TmeIWEdit then
          DatoPers:=(TmeIWEdit(IWC).medpTag as TDatoPersonalizzato)
        else if IWC is TmeIWMemo then
          DatoPers:=(TmeIWMemo(IWC).medpTag as TDatoPersonalizzato)
        else if IWC is TMedpIWMultiColumnComboBox then
          DatoPers:=(TMedpIWMultiColumnComboBox(IWC).medpTag as TDatoPersonalizzato)
        else
          DatoPers:=nil;

        // abilitazione del singolo componente
        if DatoPers <> nil then
        begin
          AbilitazioneComponente(IWLbl,DatoPers.AbilitaModifica);
          AbilitazioneComponente(IWC,DatoPers.AbilitaModifica);
        end;
      end;
    end;
  end
  else
  begin
    // tabella dei dati personalizzati
    AbilitazioneComponente(grdDati,False);
  end;
end;

function TW032FRichiestaMissioni.ControlliAutOK(const FN: String): Boolean;
// effettua controlli sui dati modificabili in fase di autorizzazione
var
  ErroreDatiPersonalizzati: String;
begin
  Result:=False;

  // controllo dati personalizzati
  if not CtrlSalvaDatiPersonalizzati(ErroreDatiPersonalizzati) then
  begin
    MsgBox.MessageBox(ErroreDatiPersonalizzati,INFORMA);
    Exit;
  end;

  Result:=True;
end;

procedure TW032FRichiestaMissioni.actModDatiAut(const FN: String);
// conferma la modifica ai dati in fase di autorizzazione
var
  IdMod, FaseLiv: Integer;
  Codice, Valore: String;
begin
  IdMod:=W032DM.selM140.FieldByName('ID').AsInteger;
  FaseLiv:=C018.FaseLivello[W032DM.selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger];

  if EsistonoDatiPersonalizzati then
  begin
    // filtro dataset selM025 per estrarre i codici per cui la categoria è visibile e modificabile
    W032DM.selM025.Filtered:=False;
    W032DM.selM025.Filter:=Format('(%s >= MIN_FASE_VISIBILE_CAT) and (%s <= MAX_FASE_VISIBILE_CAT) and (%s >= MIN_FASE_MODIFICA_CAT) and (%s <= MAX_FASE_MODIFICA_CAT)',[FaseLiv.ToString,FaseLiv.ToString,FaseLiv.ToString,FaseLiv.ToString]);
    W032DM.selM025.Filtered:=True;
    try
      for Codice in Richiesta.DatiPers.Keys do
      begin
        // se il codice è tra quelli modificabili gestisce i dati su M175
        if W032DM.selM025.SearchRecord('CODICE',Codice,[srFromBeginning]) then
        begin
          Valore:=Richiesta.DatiPers[Codice].ValoreStr;

          if W032DM.selM175.SearchRecord('CODICE',Codice,[srFromBeginning]) then
          begin
            // record presente su M175
            //   se il valore è vuoto elimina il record
            //   altrimenti aggiorna il valore
            if Valore = '' then
            begin
              // cancellazione dato
              W032DM.selM175.Delete;
            end
            else
            begin
              // update dato
              W032DM.selM175.Edit;
              W032DM.selM175.FieldByName('VALORE').AsString:=Valore;
              W032DM.selM175.Post;
            end;
          end
          else
          begin
            // record non presente su M175
            //   se il valore è vuoto non effettua nessuna operazione
            //   altrimenti inserisce un nuovo record
            if Valore = '' then
            begin
              // nessuna operazione necessaria
            end
            else
            begin
              // inserimento nuovo dato
              W032DM.selM175.Append;
              W032DM.selM175.FieldByName('ID').AsInteger:=IdMod;
              W032DM.selM175.FieldByName('CODICE').AsString:=Codice;
              W032DM.selM175.FieldByName('VALORE').AsString:=Valore;
              W032DM.selM175.Post;
            end;
          end;
        end;
      end;
    finally
      W032DM.selM025.Filtered:=False;
      W032DM.selM025.Filter:='';
    end;
  end;

  // rilegge i dati
  grdRichieste.medpCaricaCDS;

  // posizionamento su riga appena modificata
  DBGridColumnClick(nil,IdMod.ToString);
end;

procedure TW032FRichiestaMissioni.imgModificaDatiAutClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // verifica presenza richiesta
  W032DM.selM140.Refresh;
  if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox('La richiesta da modificare non è più disponibile!',INFORMA,'Richiesta eliminata');
    Exit;
  end;

  // porta la riga in modifica: trasforma i componenti
  DBGridColumnClick(Sender,FN);
  grdRichieste.medpStato:=msEdit;
  grdRichieste.medpBrowse:=False;
  TrasformaComponentiAut(FN);
end;

procedure TW032FRichiestaMissioni.imgConfermaDatiAutClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if (grdRichieste.medpStato = msEdit) then
  begin
    // se il record non esiste -> errore
    if not W032DM.selM140.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      grdRichieste.medpStato:=msBrowse;
      TrasformaComponenti(FN);
      MsgBox.MessageBox('Attenzione! La richiesta non è più disponibile:'#13#10'potrebbe essere stata eliminata nel frattempo.',INFORMA);
      Exit;
    end;
  end;

  // effettua controlli bloccanti sui dati personalizzati
  if not ControlliAutOK(FN) then
    Exit;

  // conferma modifica dati
  actModDatiAut(FN);
end;

procedure TW032FRichiestaMissioni.imgAnnullaDatiAutClick(Sender: TObject);
var
  OldId: Integer;
begin
  // salva id richiesta per successivo riposizionamento
  OldId:=W032DM.selM140.FieldByName('ID').AsInteger;

  // aggiorna visualizzazione
  VisualizzaDipendenteCorrente;

  // posizionamento sulla richiesta
  DBGridColumnClick(nil,OldId.ToString);
end;

procedure TW032FRichiestaMissioni.DistruggiOggetti;
begin
  FreeAndNil(Richiesta.DatiPers);
  FreeAndNil(QSCodRegole);
  FreeAndNil(W032DM);
  FreeAndNil(ListaAnticipi);
  FreeAndNil(ListaRimborsi);
  FreeAndNil(ListaValute);
  FreeAndNil(ListaTipiRegistrazione);
end;

end.
