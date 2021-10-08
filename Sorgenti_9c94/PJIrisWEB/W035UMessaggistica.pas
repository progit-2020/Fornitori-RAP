unit W035UMessaggistica;

{ DONE : TEST IW 15 }

interface

uses
  W035UMessaggisticaDM, W000UMessaggi,
  WC013UCheckListFM, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPaginaWeb,
  medpIWDBGrid, medpIWC700NavigatorBar, IWApplication,
  Oracle, OracleData, Windows, StrUtils, Math, SysUtils, Classes, Controls,
  Forms, IWVCLComponent, IWBaseLayoutComponent, IWHTMLTag,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, meIWLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWCompText, meIWText, IWCompEdit,
  meIWEdit, meIWImageFile, IWCompMemo, meIWMemo,
  IWCompGrids, IWDBGrids, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWRegion, IWCompButton, meIWButton,
  DB, DBClient, meIWCheckBox, meIWGrid, IWCompExtCtrls, meIWRadioGroup,
  IWCompListbox, meIWComboBox, Variants, IWCompCheckbox, medpIWTabControl,
  IWCompJQueryWidget, Menus, IWDBStdCtrls, meIWDBMemo, medpIWImageButton,
  IWCompFileUploader, meIWFileUploader;

type
  TModalitaGestione = (mgLettura,mgInvio);

  TDataSetAfterScroll = procedure(DataSet: TDataSet) of object;

  TDestinatario = record
    Progressivo: Integer;
    Matricola: String;
    Cognome: String;
    Nome: String;
    DataLettura: TDateTime;
    DataRicezione: TDateTime; // EMPOLI_ASL11 - commessa 2013/040 - riesame del 10/05/2013
  end;

  TDestArr = array of TDestinatario;

  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  TDestOperatore = record
    Utente: String;           // operatore win
    DataLettura: TDateTime;   // data lettura messaggio (usato dal destinatario)
    DataRicezione: TDateTime; // data ricezione messaggio
  end;
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  TDestOperatoreArr = array of TDestOperatore;

  TAllegato = record
    Flag: String;
    NomeFile: String;
    ExtFile: String;
    DimFile: Int64;
    DimFileStr: String;
  end;

  TAllegatiArr = array of TAllegato;

  TStatoLettura = (slNonLetto,slLettoParzialmente,slLetto);

  TStatoRicezione = (srNonRicevuto,srRicevutoParzialmente,srRicevuto);

  TDatiModalita = record
    // bookmark sul record selezionato
    selTabella_Bookmark: TBookmark;
    // checkbox selezione stato
    chkStatoSospeso_Checked: Boolean;
    chkStatoInviato_Checked: Boolean;
    chkStatoCancellato_Checked: Boolean;
    chkStatoTutti_Checked: Boolean;
    // periodo invio dal - al
    edtPeriodoDal_Text: String;
    edtPeriodoAl_Text: String;
    // in lettura filtra sui messaggi da leggere
    rgpFiltroDaLeggere_ItemIndex: Integer;
    // filtri selezione anagrafica e mittente
    cmbFiltroSelezione_ItemIndex: Integer;
    cmbFiltroMittente_ItemIndex: Integer;
    // ricerca per oggetto e/o testo
    edtRicerca_Text: String;
  end;

  TDatiModalitaArr = array[0..1] of TDatiModalita;

  TMessaggio = class(TObject)
  private
    FErrMsg: String;
    FID: Integer;
    FOggetto: String;
    FTesto: String;
    FLetturaObbligatoria: String; // MONDOEDP - commessa MAN/07 SVILUPPO#57
    FStato: String;
    FEditAsNew: Boolean;
    FModificato: Boolean;
    FDataInvio: TDateTime;
    FIDOriginale: Integer;
    // destinatari
    FSelezioneAnagrafica: String;
    FDestLetti: Integer;
    FDestRicevuti: Integer;
    FDestTot: Integer;
    FDestArr: TDestArr;
    FDestOperatoreArr: TDestOperatoreArr; // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1
    FDestModificati: Boolean;
    FStatoLettura: TStatoLettura;
    FStatoRicezione: TStatoRicezione;
    // allegati
    FAllegatiArr,FAllegatiCopyArr: TAllegatiArr;
    FAllegModificati: Boolean;
    function  GetStatoLettura: TStatoLettura;
    function  GetStatoRicezione: TStatoRicezione;
    procedure SetOggetto(const Value: String);
    procedure SetTesto(const Value: String);
    procedure Clear;
    procedure SetLetturaObbligatoria(const Value: String); // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  public
    constructor Create;
    destructor Destroy; override;
    procedure ClearDestinatari;
    function  AddDestinatario(const PProg: Integer; const PMatricola, PCognome, PNome: String;
      const PDataLettura, PDataRicezione: TDateTime): Integer;
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    procedure ClearDestinatariOperatori;
    function  AddDestinatarioOperatore(const PUtente: String; const PDataLettura, PDataRicezione: TDateTime): Integer;
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
    procedure ClearAllegati;
    function  EsisteAllegato(const PNomeFile: String): Boolean;
    function  AddAllegato(const PFlag, PNomeFile: String; const PDimFile: Int64 = 0): Integer;
    property ID: Integer read FID write FID;
    property Stato: String read FStato write FStato;
    property EditAsNew: Boolean read FEditAsNew write FEditAsNew;
    property DataInvio: TDateTime read FDataInvio write FDataInvio;
    property Oggetto: String read FOggetto write SetOggetto;
    property Testo: String read FTesto write SetTesto;
    property LetturaObbligatoria: String read FLetturaObbligatoria write SetLetturaObbligatoria; // MONDOEDP - commessa MAN/07 SVILUPPO#57
    property Modificato: Boolean read FModificato write FModificato;
    property IDOriginale: Integer read FIDOriginale write FIDOriginale;
    property SelezioneAnagrafica: String read FSelezioneAnagrafica write FSelezioneAnagrafica;
    property DestArr: TDestArr read FDestArr write FDestArr;
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    property DestOperatoreArr: TDestOperatoreArr read FDestOperatoreArr write FDestOperatoreArr;
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
    property DestLetti: Integer read FDestLetti write FDestLetti;
    property DestRicevuti: Integer read FDestRicevuti write FDestRicevuti;
    property DestTot: Integer read FDestTot write FDestTot;
    property DestModificati: Boolean read FDestModificati write FDestModificati;
    property StatoLettura: TStatoLettura read GetStatoLettura write FStatoLettura;
    property StatoRicezione: TStatoRicezione read GetStatoRicezione write FStatoRicezione;
    property AllegatiArr: TAllegatiArr read FAllegatiArr write FAllegatiArr;
    property AllegatiCopyArr: TAllegatiArr read FAllegatiCopyArr write FAllegatiCopyArr;
    property AllegModificati: Boolean read FAllegModificati write FAllegModificati;
    property ErrMsg: String read FErrMsg write FErrMsg;
  end;

  TW035FMessaggistica = class(TR010FPaginaWeb)
    tabMessaggi: TmedpIWTabControl;
    rgnDati: TmeIWRegion;
    tpDati: TIWTemplateProcessorHTML;
    lblDettaglio: TmeIWLabel;
    lblDestinatari: TmeIWLabel;
    lblOggetto: TmeIWLabel;
    lblTesto: TmeIWLabel;
    lblAllegati: TmeIWLabel;
    grdAllegati: TmeIWGrid;
    btnHdnUpload: TmeIWButton;
    edtOggetto: TmeIWEdit;
    edtDestinatari: TmeIWEdit;
    btnDestinatari: TmeIWButton;
    memTesto: TmeIWMemo;
    lblFiltro: TmeIWLabel;
    rgpFiltroDaLeggere: TmeIWRadioGroup;
    chkStatoSospeso: TmeIWCheckBox;
    chkStatoCancellato: TmeIWCheckBox;
    chkStatoTutti: TmeIWCheckBox;
    chkStatoInviato: TmeIWCheckBox;
    edtPeriodoDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtPeriodoAl: TmeIWEdit;
    lblFiltroSelezione: TmeIWLabel;
    cmbFiltroSelezione: TmeIWComboBox;
    btnFiltra: TmeIWButton;
    lblFiltroMittente: TmeIWLabel;
    cmbFiltroMittente: TmeIWComboBox;
    edtRicerca: TmeIWEdit;
    grdMessaggi: TmedpIWDBGrid;
    lblPeriodoDal: TmeIWLabel;
    rgnDestinatari: TmeIWRegion;
    tpDestinatari: TIWTemplateProcessorHTML;
    grdDestinatari: TmedpIWDBGrid;
    rgpFiltroDest: TmeIWRadioGroup;
    jqDestinatari: TIWJQueryWidget;
    cdsDestinatari: TClientDataSet;
    cdsDestinatariPROGRESSIVO: TIntegerField;
    cdsDestinatariMATRICOLA: TStringField;
    cdsDestinatariCOGNOME: TStringField;
    cdsDestinatariNOME: TStringField;
    cdsDestinatariDATA_LETTURA: TDateTimeField;
    edtSelezione: TmeIWEdit;
    btnChiudiDest: TmeIWButton;
    lblFiltroDest: TmeIWLabel;
    lblNoAllegati: TmeIWLabel;
    pmnTabella: TPopupMenu;
    mnuEsportaCsv: TMenuItem;
    jqDettaglio: TIWJQueryWidget;
    cdsDestinatariDATA_RICEZIONE: TDateTimeField;
    pmnDestinatari: TPopupMenu;
    mnuDestCsv: TMenuItem;
    cdsDestinatariUTENTE: TStringField;
    edtIDOriginale: TmeIWEdit;
    rgnElenco: TmeIWRegion;
    grdElenco: TmedpIWDBGrid;
    btnChiudiElenco: TmeIWButton;
    jqElenco: TIWJQueryWidget;
    tpElenco: TIWTemplateProcessorHTML;
    memElencoTesto: TmeIWDBMemo;
    btnRispondi: TmedpIWImageButton;
    btnStorico: TmedpIWImageButton;
    imgScegliDestOperatori: TmeIWImageFile;
    chkLetturaObbligatoria: TmeIWCheckBox;
    IWFile: TmeIWFileUploader;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdMessaggiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdMessaggimedpStatoChange;
    procedure btnHdnUploadClick(Sender: TObject);
    procedure grdDestinatariRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure rgpFiltroDestClick(Sender: TObject);
    procedure edtRicercaSubmit(Sender: TObject);
    procedure cmbFiltroMittenteChange(Sender: TObject);
    procedure cmbFiltroSelezioneChange(Sender: TObject);
    procedure btnFiltraClick(Sender: TObject);
    procedure chkStatoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkStatoTuttiAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure grdMessaggiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure rgpFiltroDaLeggereClick(Sender: TObject);
    procedure tabMessaggiTabControlChange(Sender: TObject);
    procedure btnDestinatariClick(Sender: TObject);
    procedure btnChiudiDestClick(Sender: TObject);
    procedure IWAppFormAfterRender(Sender: TObject);
    procedure grdMessaggiInserisci(Sender: TObject);
    procedure grdMessaggiModifica(Sender: TObject);
    procedure grdMessaggiCancella(Sender: TObject);
    procedure grdMessaggiConferma(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure mnuEsportaCsvClick(Sender: TObject);
    procedure mnuDestCsvClick(Sender: TObject);
    procedure btnRispondiClick(Sender: TObject);
    procedure btnStoricoClick(Sender: TObject);
    procedure btnChiudiElencoClick(Sender: TObject);
    procedure grdElencoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdMessaggiAnnulla(Sender: TObject);
    procedure imgScegliDestOperatoriClick(Sender: TObject);
    procedure tabMessaggiTabControlChanging(Sender: TObject;
      var AllowChange: Boolean);
  private
    FModalita: TModalitaGestione;
    FDatiModalitaArr: TDatiModalitaArr;
    // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.ini
    VisualizzaRicevente: Boolean;  // indica se è attiva la gestione del dato "ricevente"
    // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.fine
    selTabella: TOracleDataset;
    W035DM: TW035FMessaggisticaDM;
    grdC700: TmedpIWC700NavigatorBar;
    WC013FM: TWC013FCheckListFM;
    LstOperatori: TStringList;
    Msg: TMessaggio;
    iChkLetto: Integer;
    jChkLetto: Integer;
    // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.ini
    iEdtRicevente: Integer;
    jEdtRicevente: Integer;
    // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.fine
    iImgInvia: Integer;
    jImgInvia: Integer;
    iImgSalvaInvia: Integer;
    jImgSalvaInvia: Integer;
    CookieDettName: String; // nome del cookie per il dettaglio (espanso / chiuso)
    ModalitaRisposta: Boolean;
    // tab index
    TAB_IDX_LETTURA,
    TAB_IDX_INVIO: Integer;
    procedure SetModalita(const Value: TModalitaGestione);
    procedure ImpostaVisibilitaElementi;
    function  GetNewID: Integer;
    function  Controlla(const PAzione: String; var ErrMsg: String): Boolean;
    function  Salva(var ErrMsg: String): Boolean;
    function  Invia(var ErrMsg: String; const PNotifica: Boolean): Boolean;
    function  Elimina(var ErrMsg: String; const PNotifica: Boolean): Boolean;
    procedure VisualizzaInvio(const FN: String; const PShow: Boolean);
    function  ImpostaStatoLettura(const PLetto: Boolean; var ErrMsg: String): Boolean;
    function  ImpostaStatoRicezione(var ErrMsg: String): Boolean;
    procedure OnSelezioneAnagrafica;
    procedure OnSelezioneOperatori(Sender: TObject; Result:Boolean); // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1
    procedure AggiornaDestinatari(const PSoloFiltro: Boolean = False);
    procedure AggiornaUI;
    procedure AbilitaUI;
    procedure AggiornaMessaggi(const PRicaricaComboFiltri: Boolean);
    procedure PulisciFiltriModalita;
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    procedure InizializzaFiltriModalita;
    procedure SalvaFiltriModalita;
    procedure RipristinaFiltriModalita;
    procedure RipristinaBookmarkModalita;
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
    procedure ReimpostaComboFiltri;
    function  GetFiltroMessaggi: String;
    function  CreaAllegatoCheck(const PIndice: Integer): TmeIWCheckBox;
    function  CreaAllegatoLink(const PIndice: Integer): TmeIWLink;
    procedure lnkAllegatoClick(Sender: TObject);
    procedure chkAllegatoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgInviaClick(Sender: TObject);
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    procedure imgConfermaInviaClick(Sender: TObject);
    //procedure imgLetturaClick(Sender: TObject);
    procedure imgLetturaAsyncClick(Sender: TObject; EventParams: TStringList);
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
    // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.ini
    procedure edtRiceventeSubmit(Sender: TObject);
    procedure edtRiceventeAsyncClick(Sender: TObject; EventParams: TStringList);
    // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.fine
    procedure EspandiDettaglio;
    //procedure RiduciDettaglio;
  protected
    procedure RefreshPage; override;
    function  GetInfoFunzione: String; override;
    procedure DistruggiOggetti; override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    property  Modalita: TModalitaGestione read FModalita write SetModalita;
    function  InizializzaAccesso: Boolean; override;
    procedure ClearMessaggio;
    procedure LeggiMessaggio;
    procedure CtrlImpostaStatoRicezione(EventParams: TStringList);
  end;

const
  // cookie
  ID_DETTAGLIO                     = 'w035Dettaglio';
  COOKIE_DETTAGLIO_FMT             = 'w035Dettaglio_%s_idx';

  // stati del messaggio (dominio di valori da tabella db)
  STATO_MSG_SOSPESO                 = 'S';
  STATO_MSG_CANCELLATO              = 'C';
  STATO_MSG_INVIATO                 = 'I';

  // item del filtro messaggi
  ITEM_DA_LEGGERE                   = 0;
  ITEM_LETTI                        = 1;
  ITEM_TUTTI                        = 2;
  ITEM_CANCELLATI                   = 3;

  // flag per allegati (utilizzato internamente a questa unit)
  FLAG_ALLEG_NUOVO                  = 'N';
  FLAG_ALLEG_SALVATO                = 'S';
  FLAG_ALLEG_CANC_NUOVO             = 'CN';
  FLAG_ALLEG_CANC_SALVATO           = 'CS';

  // azioni di controllo
  AZIONE_INVIA                      = 'I';
  AZIONE_SALVA                      = 'S';

  LIMITE_CARATTERI_TESTO            = 100;    // limite di caratteri per il testo da visualizzare in tabella
  LIMITE_RIGHE_TESTO                = 4;      // limite di ritorni a capo per il testo da visualizzare in tabella
  LIMITE_CARATTERI_DESTINATARI      = 20;     // limite di caratteri per i destinatari nell'elenco
  LIMITE_DESTINATARI_VISUALIZZATI   = 2;      // limite di destinatari visualizzati in modo esplicito

  // prefisso da impostare sull'oggetto per la risposta
  PREFISSO_OGGETTO_RISPOSTA         = 'Re: ';

  // css personalizzati
  // righe messaggi in tabella
  CSS_MSG_RICEVUTO_DALEGGERE        = 'msg_ric_daLeggere';
  CSS_MSG_INVIATO_DALEGGERE         = 'msg_inv_daLeggere';
  CSS_MSG_INVIATO_LETTO             = 'msg_inv_lettoTutti';
  CSS_MSG_INVIATO_LETTOPARZIALMENTE = 'msg_inv_lettoParz';
  CSS_MSG_CANCELLATO                = 'msg_canc';

  // righe messaggi inviati / ricevuti nello storico
  CSS_RIGA_INVIATO                  = 'w035_riga_inviato';
  CSS_RIGA_RICEVUTO                 = 'w035_riga_ricevuto';

implementation

uses IWGlobal;

{$R *.dfm}

function TW035FMessaggistica.InizializzaAccesso: Boolean;
// questa maschera è richiamabile con il parametro
// MODALITA
// - I = messaggi inviati (possibile solo se l'accesso alla maschera è completo)
// - L = messaggi ricevuti
begin
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  // l'assunto non è più valido: anche l'operatore iriswin può ricevere messaggi
  {
  // la combinazione "Operatore IrisWin" e "Sola lettura" è incompatibile
  // perché non è consentito a questo tipo di operatore ricevere messaggi
  if (SolaLettura) and (WR000DM.TipoUtente = 'Supervisore') then
  begin
    Result:=False;
    Exit;
  end;
  }
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  // impostazione tab (modalità operativa)
  tabMessaggi.HasFiller:=True;
  TAB_IDX_LETTURA:=tabMessaggi.AggiungiTab(Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_MESSAGGI_RICEVUTI),['']),rgnDati);
  TAB_IDX_INVIO:=tabMessaggi.AggiungiTab(A000TraduzioneStringhe(A000MSG_W035_MSG_MESSAGGI_INVIATI),rgnDati);
  InizializzaFiltriModalita;

  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  // l'assunto non è più valido: anche l'operatore iriswin può ricevere messaggi
  {
  // ricezione messaggi: solo se operatore web
  tabMessaggi.TabByIndex(TAB_IDX_LETTURA).Visible:=(WR000DM.TipoUtente = 'Dipendente');
  }
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  // invio messaggi: solo se funzione in scrittura
  tabMessaggi.TabByIndex(TAB_IDX_INVIO).Visible:=not SolaLettura;

  // inizializza i filtri
  PulisciFiltriModalita;

  if SolaLettura then
  begin
    tabMessaggi.ActiveTabIndex:=TAB_IDX_LETTURA;
  end
  else
  begin
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    // gli operatori win possono anche ricevere, per cui la vista di default è sui messaggi ricevuti
    //if (WR000DM.TipoUtente = 'Supervisore') or (GetParam('MODALITA') = 'I') then
    if GetParam('MODALITA') = 'I' then
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
      tabMessaggi.ActiveTabIndex:=TAB_IDX_INVIO
    else
      tabMessaggi.ActiveTabIndex:=TAB_IDX_LETTURA
  end;

  // inizializzazione ok
  Result:=True;
end;

procedure TW035FMessaggistica.RefreshPage;
begin
  // operazione inutile
  {
  // reimposta la query di conteggio dei messaggi da leggere
  with WR000DM.selT282Count do
  begin
    // ripristino la modalità threaded (inutile - cfr. W002UAnagrafeElenco.pas)
    Threaded:=False;
    OnThreadExecuted:=nil;
    OnThreadError:=nil;
    SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
  end;
  }

  AggiornaMessaggi(True);
end;

procedure TW035FMessaggistica.IWAppFormCreate(Sender: TObject);
var
  Js, CallBackName: String;
begin
  inherited;

  // datamodule e variabili di supporto
  W035DM:=TW035FMessaggisticaDM.Create(Self);
  Msg:=TMessaggio.Create;

  // bookmark per riposizionarsi nel passaggio da un tab all'altro
  selTabella:=nil;

  // clientdataset destinatari
  cdsDestinatari.Close;
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  //cdsDestinatari.IndexDefs.Add('Nominativo','COGNOME;NOME;MATRICOLA',[]);
  cdsDestinatari.IndexDefs.Add('Nominativo','UTENTE;COGNOME;NOME;MATRICOLA',[]);
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
  cdsDestinatari.IndexName:='Nominativo';
  cdsDestinatari.CreateDataSet;
  cdsDestinatari.LogChanges:=False;
  cdsDestinatari.Open;

  // tabella destinatari
  grdDestinatari.medpDataset:=cdsDestinatari;
  grdDestinatari.medpTestoNoRecord:='Nessun destinatario';
  grdDestinatari.medpRowSelect:=False;
  grdDestinatari.medpAttivaGrid(cdsDestinatari,False,False);

  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  // tabella destinatari
  W035DM.selElencoMsg.Open;
  grdElenco.medpDataset:=W035DM.selElencoMsg;
  grdElenco.medpRowIDField:='ID';
  grdElenco.medpTestoNoRecord:='Nessun messaggio';
  grdElenco.medpRowSelect:=True;
  grdElenco.medpAttivaGrid(W035DM.selElencoMsg,False,False);

  memElencoTesto.DataSource:=grdElenco.DataSource;
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  // estrae lista operatori win
  LstOperatori:=TStringList.Create;
  with W035DM.selOperatori do
  begin
    Close;
    SetVariable('TAG',Self.Tag);
    Open;
    while not Eof do
    begin
      LstOperatori.Add(FieldByName('UTENTE').AsString);
      Next;
    end;
    Close;
  end;

  // navigator C700 per selezione destinatari web
  if (not Parametri.InibizioneIndividuale) or
     (WR000DM.TipoUtente = 'Supervisore') then
  begin
    grdC700:=TmedpIWC700NavigatorBar.Create(Self);
    grdC700.Parent:=rgnDati;
    grdC700.Css:=grdC700.Css + ' floatLeft';
    grdC700.AggiornaAnagr:=OnSelezioneAnagrafica;
    grdC700.CreaSelezioneIniziale(True);
    grdC700.AttivaBrowse:=False;
    grdC700.AttivaEredita:=False;
    grdC700.AttivaLabel:=False;
  end;

  // imposta ed abilita jquery plugin per dettaglio e watermark
  CallBackName:=UpperCase(Self.Name) + '.CtrlImpostaStatoRicezione';
  GGetWebApplicationThreadVar.RegisterCallBack(CallBackName,CtrlImpostaStatoRicezione);
  Js:='try { ' + CRLF +
      '  var cName = "%s"; ' + CRLF +
      '  $("#%s").accordion({ ' + CRLF +
      '    heightStyle: "content", ' + CRLF +
      '    clearStyle: true, ' + CRLF +
      '    collapsible: true, ' + CRLF +
      '    activate: function (event, ui) { ' + CRLF +
      '      /* -1 se nessuno aperto, oppure >=0 */ ' + CRLF +
      '      $.cookie(cName, ui.newHeader.index(), { expires: 2, path: "/" }); ' + CRLF +
      '      if (ui.newHeader.index() >= 0) { ' + CRLF +
      '        processAjaxEvent("",null,"%s",false,null,false); ' + CRLF +
      '      } ' + CRLF +
      '    }, ' + CRLF +
      '    active: ($.cookie(cName) == null) ? false : ($.cookie(cName) == "-1") ? false : parseInt($.cookie(cName)) ' + CRLF +
      '  }); ' + CRLF +
      '} ' + CRLF +
      'catch (err) { ' + CRLF +
      '  gestioneErrori(err.message + "|" + "jqDettaglio" + "|0","",0); ' + CRLF +
      '} ';
  CookieDettName:=Format(COOKIE_DETTAGLIO_FMT,[GGetWebApplicationThreadVar.AppID]);
  jqDettaglio.OnReady.Text:=Format(Js,[CookieDettName,ID_DETTAGLIO,CallBackName]);
  jqWatermark.Enabled:=True;

  // evita submit
  { DONE : TEST IW 15 }
  {btnDestinatari.DontSubmitFiles:=True;
  btnFiltra.DontSubmitFiles:=True;
  edtRicerca.DontSubmitFiles:=True;}

  { daniloc: query threaded non funzionano su ISAPI dll
  // conteggio messaggi da leggere
  // la query non è "threaded", pertanto sarà eseguita immediatamente
  // reimposta proprietà (l'oggetto è condiviso)
  with WR000DM.selT282Count do
  begin
    Threaded:=False;
    OnThreadExecuted:=nil;
    OnThreadError:=nil;
  end;
  }

  // inizializzazione variabili
  iChkLetto:=0;
  jChkLetto:=0;
  // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.ini
  iEdtRicevente:=0;
  jEdtRicevente:=0;
  // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.fine
  iImgInvia:=0;
  jImgInvia:=0;

  // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  chkLetturaObbligatoria.Visible:=Parametri.CampiRiferimento.C90_MessaggisticaObbligoLettura = 'S';
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
end;

procedure TW035FMessaggistica.IWAppFormRender(Sender: TObject);
var
  Js: String;
begin
  inherited;

  // visibilità groupbox filtro destinatari nella region relativa
  if rgnDestinatari.Visible then
  begin
    Js:='var w035dest = document.getElementById("w035_dest"); ' +
        'if (w035dest) { ' +
        '  w035dest.className = "groupbox fs100 %s"; ' +
        '} ';
    AddToInitProc(Format(Js,[IfThen(rgpFiltroDest.Visible,'','invisibile')]));
  end;
end;

{ DONE : TEST IW 15 }
procedure TW035FMessaggistica.IWAppFormAfterRender(Sender: TObject);
begin
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    inherited;
    RimuoviNotifiche;
  end;
end;

function TW035FMessaggistica.GetInfoFunzione: String;
begin
  Result:='';
end;

procedure TW035FMessaggistica.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    // chiusura frame cancellazione periodo
    if AComponent = WC013FM then
    begin
      WC013FM:=nil;
    end;
  end;
end;

procedure TW035FMessaggistica.SetModalita(const Value: TModalitaGestione);
var
  OldAfterScroll: TDataSetAfterScroll;
begin
  FModalita:=Value;

  ModalitaRisposta:=False;

  // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.ini
  // determina se attivare o meno la gestione del dato "ricevente"
  // la gestione del ricevente è specifica per SGIULIANOMILANESE_COMUNE
  // e serve ad indicare l'operatore che prende in carico la chiamata
  // la colonna deve essere visibile solo se si verificano queste condizioni:
  // in modalità lettura: modalità di risposta attiva e utente supervisore
  // in modalità invio:   modalità di risposta attiva e sono presenti operatori disponibili a cui inviare il messaggio
  if FModalita = mgLettura then
    VisualizzaRicevente:=(Parametri.CampiRiferimento.C90_MessaggisticaReply = 'S') and
                         (WR000DM.TipoUtente = 'Supervisore')
  else
    VisualizzaRicevente:=(Parametri.CampiRiferimento.C90_MessaggisticaReply = 'S') and
                         (LstOperatori.Count > 0);
  // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.fine

  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  // pulisce i filtri quando si cambia modalità
  //PulisciFiltriModalita;
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  // imposta la visibilità dei componenti in base al tipo di accesso
  ImpostaVisibilitaElementi;

  if FModalita = mgLettura then
  begin
    // funzione in lettura: messaggi destinati all'utente / operatore
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    if WR000DM.TipoUtente = 'Supervisore' then
    begin
      // messaggi destinati all'operatore win
      selTabella:=W035DM.selT282RicevutiOper;
      selTabella.Close;
      selTabella.SetVariable('UTENTE',Parametri.Operatore);
    end
    else
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
    begin
      // messaggi destinati all'operatore win
      selTabella:=W035DM.selT282Ricevuti;
      selTabella.Close;
      selTabella.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
    end;
  end
  else
  begin
    // funzione in scrittura: messaggi inviati dall'utente
    selTabella:=W035DM.selT282Inviati;
    selTabella.Close;
    selTabella.SetVariable('MITTENTE',Parametri.Operatore);
    // GENOVA_HSMARTINO - chiamata 88109.ini
    // imposta limite destinatari visualizzati in modo esplicito
    selTabella.SetVariable('LIMITE_DEST',LIMITE_DESTINATARI_VISUALIZZATI);
    // GENOVA_HSMARTINO - chiamata 88109.fine
  end;
  selTabella.SetVariable('FILTRO_VIS',GetFiltroMessaggi);

  // disabilita afterscroll
  OldAfterScroll:=selTabella.AfterScroll;
  selTabella.AfterScroll:=nil;

  // apre dataset
  selTabella.Open;

  // imposta la tabella dei messaggi
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdMessaggi.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine

  // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  // imposta visibilità campo lettura obbligatoria
  selTabella.FieldByName('LETTURA_OBBLIGATORIA').Visible:=Parametri.CampiRiferimento.C90_MessaggisticaObbligoLettura = 'S';
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine

  grdMessaggi.medpDataset:=selTabella;
  grdMessaggi.medpTestoNoRecord:='Nessun messaggio';
  grdMessaggi.Hint:=Format('Per aprire il messaggio cliccare su %s',[lblDettaglio.Caption]);
  grdMessaggi.medpComandiCustom:=True;
  grdMessaggi.medpAttivaGrid(selTabella,FModalita = mgInvio,FModalita = mgInvio);

  if FModalita = mgLettura then
  begin
    // lettura: prevede icona azione per segnare messaggic come letto/non letto
    iChkLetto:=grdMessaggi.medpIndexColonna('DATA_LETTURA');
    jChkLetto:=0;
    grdMessaggi.medpPreparaComponenteGenerico('R',iChkLetto,jChkLetto,DBG_CHK,'','','','','C');

    // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.ini
    iEdtRicevente:=grdMessaggi.medpIndexColonna('RICEVENTE');
    jEdtRicevente:=0;
    grdMessaggi.medpPreparaComponenteGenerico('R',iEdtRicevente,jEdtRicevente,DBG_EDT,'30','','','','S');
    // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.fine
  end
  else
  begin
    // invio: prevede icona azione di invio messaggio
    { TODO : Rivedere gli indici di riga e colonna fissi, magari con un metodo di medpIWDBGrid }
    iImgInvia:=0;
    jImgInvia:=4;
    grdMessaggi.medpPreparaComponenteGenerico('R',iImgInvia,jImgInvia,DBG_IMG,'','INVIA','Invia il messaggio','Confermi l''invio del messaggio?','D');

    // inserimento: icona di conferma + invio
    { TODO : Rivedere l'indice di colonna fisso = 3, magari con un metodo di medpIWDBGrid }
    iImgSalvaInvia:=0;
    jImgSalvaInvia:=3;
    grdMessaggi.medpPreparaComponenteGenerico('I',iImgSalvaInvia,jImgSalvaInvia,DBG_IMG,'','INVIA','Invia il messaggio','Confermi l''invio del messaggio?','D');
  end;

  // imposta visibilità colonne
  grdMessaggi.medpColonna('DBG_COMANDI').Visible:=FModalita = mgInvio;
  grdMessaggi.medpColonna('D_STATO').Visible:=FModalita = mgInvio;
  grdMessaggi.medpColonna('ID').Visible:=False;
  grdMessaggi.medpColonna('STATO').Visible:=False;
  grdMessaggi.medpColonna('MITTENTE').Visible:=False;
  // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.ini
  // ricevente: campo utilizzato da SAN GIULIANO che rappresenta l'utente che prende in carico la chiamata
  grdMessaggi.medpColonna('RICEVENTE').Visible:=VisualizzaRicevente;
  // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.fine
  grdMessaggi.medpColonna('ID_ORIGINALE').Visible:=False;
  grdMessaggi.medpColonna('SELEZIONE_ANAGRAFICA').Visible:=FModalita = mgInvio;

  // ripristina afterscroll
  selTabella.AfterScroll:=OldAfterScroll;

  // legge i messaggi
  grdMessaggi.medpCaricaCDS;
  if selTabella.RecordCount = 0 then
    ClearMessaggio;
  ReimpostaComboFiltri;
end;

procedure TW035FMessaggistica.AggiornaMessaggi(const PRicaricaComboFiltri: Boolean);
// aggiornamento visualizzazione tabella messaggi
var
  OldAfterScroll: TDataSetAfterScroll;
  OldSelezione, OldMittente: String;
begin
  // nasconde pulsante storico
  btnStorico.Visible:=False;

  // disabilita afterscroll
  OldAfterScroll:=selTabella.AfterScroll;
  selTabella.AfterScroll:=nil;

  // reimposta filtro visualizzazione
  selTabella.Close;
  selTabella.SetVariable('FILTRO_VIS',GetFiltroMessaggi);
  selTabella.Open;

  // ripristina afterscroll
  selTabella.AfterScroll:=OldAfterScroll;

  // carica tabella
  grdMessaggi.medpCaricaCDS;
  if selTabella.RecordCount = 0 then
    ClearMessaggio;

  // se necessario ricarica le combobox dei filtri mittente e selezione
  if PRicaricaComboFiltri then
  begin
    // salva i valori delle combobox
    OldSelezione:=cmbFiltroSelezione.Text;
    OldMittente:=cmbFiltroMittente.Text;

    ReimpostaComboFiltri;

    // reimposta combobox
    cmbFiltroSelezione.ItemIndex:=cmbFiltroSelezione.Items.IndexOf(OldSelezione);
    cmbFiltroMittente.ItemIndex:=cmbFiltroMittente.Items.IndexOf(OldMittente);
  end;
end;

procedure TW035FMessaggistica.ReimpostaComboFiltri;
// reimposta i filtri in base al contenuto del dataset
var
  OldAfterScroll: TDataSetAfterScroll;
  OldFiltered: Boolean;
begin
 // imposta combobox per il filtro su mittente
  cmbFiltroMittente.ItemsHaveValues:=True;
  cmbFiltroMittente.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  cmbFiltroMittente.Items.Duplicates:=dupIgnore;
  cmbFiltroMittente.Items.Sorted:=True;
  cmbFiltroMittente.Items.Clear;
  cmbFiltroMittente.Items.Add('');

  // imposta combobox per il filtro sulla selezione anagrafica
  // (è usato solo in modalità completa)
  cmbFiltroSelezione.Items.Duplicates:=dupIgnore;
  cmbFiltroSelezione.Items.Sorted:=True;
  cmbFiltroSelezione.Items.Clear;
  cmbFiltroSelezione.Items.Add('');

  // ciclo di popolamento combobox per gestione filtri
  OldFiltered:=selTabella.Filtered;
  OldAfterScroll:=selTabella.AfterScroll;
  selTabella.Filtered:=False;
  selTabella.AfterScroll:=nil;
  selTabella.First;
  while not selTabella.Eof do
  begin
    // item (senza duplicati) per combobox mittenti
    cmbFiltroMittente.Items.Add(Format('%s' + NAME_VALUE_SEPARATOR + '%s',[selTabella.FieldByName('D_MITTENTE').AsString,selTabella.FieldByName('MITTENTE').AsString]));
    if FModalita = mgInvio then
    begin
      // filtro selezioni (senza duplicati)
      cmbFiltroSelezione.Items.Add(selTabella.FieldByName('SELEZIONE_ANAGRAFICA').AsString);
    end;
    selTabella.Next;
  end;

  // reimpostazione tabella
  cmbFiltroMittente.ItemIndex:=0;
  cmbFiltroSelezione.ItemIndex:=0;
  selTabella.Filtered:=OldFiltered;
  selTabella.First;
  selTabella.AfterScroll:=OldAfterScroll;

  // imposta la visibilità dei componenti in base al tipo di accesso
  ImpostaVisibilitaElementi;
end;

procedure TW035FMessaggistica.ImpostaVisibilitaElementi;
var
  EsistonoMessaggi: Boolean;
begin
  // filtri stato messaggio
  chkStatoSospeso.Visible:=FModalita = mgInvio;
  chkStatoInviato.Visible:=FModalita = mgInvio;
  chkStatoCancellato.Visible:=FModalita = mgInvio;
  chkStatoTutti.Visible:=FModalita = mgInvio;

  // destinatari
  lblDestinatari.Visible:=FModalita = mgInvio;
  if Assigned(grdC700) then
  begin
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    //grdC700.Visible:=(FModalita = mgInvio);
    grdC700.Visible:=(FModalita = mgInvio) and (not ModalitaRisposta);
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
  end;
  rgpFiltroDest.Visible:=(FModalita = mgInvio) and (grdMessaggi.medpStato <> msInsert) and (Msg.Stato <> STATO_MSG_SOSPESO);
  edtDestinatari.Visible:=FModalita = mgInvio;
  btnDestinatari.Visible:=(FModalita = mgInvio);
  grdDestinatari.Visible:=FModalita = mgInvio;

  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  // destinatari win (operatori)
  imgScegliDestOperatori.Visible:=(FModalita = mgInvio) and (not ModalitaRisposta) and (LstOperatori.Count > 0);

  EsistonoMessaggi:=(Assigned(selTabella)) and
                    (selTabella.Active) and
                    (selTabella.RecordCount > 0);
  // visibilità pulsante storico -> cfr. procedure LeggiMessaggio
  // (si basa su dati del record)
  btnRispondi.Visible:=(Parametri.CampiRiferimento.C90_MessaggisticaReply = 'S') and
                       (FModalita = mgLettura) and
                       (EsistonoMessaggi);
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  // upload allegati
  lblNoAllegati.Visible:=(grdMessaggi.medpStato = msBrowse) and (Length(Msg.AllegatiArr) = 0);
  IWFile.Visible:=(FModalita = mgInvio) and (grdMessaggi.medpStato <> msBrowse);
  IWFile.Visible:=(FModalita = mgInvio) and (grdMessaggi.medpStato <> msBrowse);

  // label per filtro periodo invio
  lblPeriodoDal.Visible:=FModalita = mgLettura;

  // filtro mittente
  lblFiltroMittente.Visible:=FModalita = mgLettura;
  cmbFiltroMittente.Visible:=FModalita = mgLettura;

  // filtro selezione
  lblFiltroSelezione.Visible:=FModalita = mgInvio;
  cmbFiltroSelezione.Visible:=FModalita = mgInvio;

  // filtro messaggi da leggere
  rgpFiltroDaLeggere.Visible:=FModalita = mgLettura;
end;

procedure TW035FMessaggistica.rgpFiltroDaLeggereClick(Sender: TObject);
begin
  if rgpFiltroDaLeggere.ItemIndex = ITEM_CANCELLATI then
  begin
    // messaggi cancellati
    // stato inviato    -> deselezionato
    // stato cancellato -> selezionato
    chkStatoCancellato.Checked:=True;
    chkStatoInviato.Checked:=False;
    chkStatoAsyncClick(chkStatoInviato,nil);
  end
  else
  begin
    // altri casi
    // stato inviato    -> selezionato
    // stato cancellato -> selezionato solo se filtro messaggi = tutti
    chkStatoCancellato.Checked:=False;//(rgpFiltroDaLeggere.ItemIndex = ITEM_TUTTI);
    chkStatoInviato.Checked:=True;
    chkStatoAsyncClick(chkStatoInviato,nil);
  end;

  AggiornaMessaggi(True);
end;

procedure TW035FMessaggistica.rgpFiltroDestClick(Sender: TObject);
// filtro destinatari
begin
  AggiornaDestinatari(True);
end;

procedure TW035FMessaggistica.edtRicercaSubmit(Sender: TObject);
// filtro su oggetto / testo
begin
  AggiornaMessaggi(False);
end;

// SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
// salva il bookmark
procedure TW035FMessaggistica.tabMessaggiTabControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  SalvaFiltriModalita;
end;
// SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini

procedure TW035FMessaggistica.tabMessaggiTabControlChange(Sender: TObject);
//
begin
  // ripristina i filtri precedentemente salvati
  RipristinaFiltriModalita;

  if tabMessaggi.ActiveTabIndex = TAB_IDX_LETTURA then
    Modalita:=mgLettura
  else
    Modalita:=mgInvio;

  // ripristina il bookmark
  RipristinaBookmarkModalita;
end;

procedure TW035FMessaggistica.AggiornaUI;
var
  i, NonLetti, NumAllegati: Integer;
  TestoTab: String;
begin
  // conteggio messaggi da leggere
  if (not WebApplication.IsCallBack) and // in async selTabella non è aggiornato
     (Modalita = mgLettura) and
     (rgpFiltroDaLeggere.ItemIndex = ITEM_DA_LEGGERE) and
     (edtPeriodoDal.Text = '') and
     (edtPeriodoAl.Text = '') and
     (cmbFiltroMittente.Text = '') and
     (cmbFiltroSelezione.Text = '') and
     ((edtRicerca.Text = '') or
      (edtRicerca.Text = edtRicerca.medpWatermark)) then
  begin
    // se la pagina è in modalità "messaggi ricevuti", il filtro è impostato su "da leggere"
    // e non ci sono altri filtri attivi, allora il numero di messaggi da leggere
    // corrisponde al recordcount del dataset (evita la query di conteggio)
    NonLetti:=selTabella.RecordCount;
  end
  else
  begin
    // esegue query di conteggio
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
    //NonLetti:=WR000DM.GetNumMsgDaLeggere;
    NonLetti:=WR000DM.GetNumMsgDaLeggere.Totali;
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
  end;

  // testo del tab
  TestoTab:=Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_MESSAGGI_RICEVUTI),
                [IfThen(NonLetti > 0,Format(' <span class="w035ContatoreMsg">%d</span>',[NonLetti]))]);
  tabMessaggi.TabByIndex(0).Caption:=TestoTab;
  // workaround - ini
  if GGetWebApplicationThreadVar.IsCallBack then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteasCData('document.getElementById(''' + tabMessaggi.TabByIndex(0).Link.HTMLName + ''').innerHTML=''' + TestoTab + ''';')
  else
    AddToInitProc('document.getElementById(''' + tabMessaggi.TabByIndex(0).Link.HTMLName + ''').innerHTML=''' + TestoTab + ''';');
  // workaround - fine

  // dati del messaggio
  edtOggetto.Text:=Msg.Oggetto;
  memTesto.Text:=Msg.Testo;
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  chkLetturaObbligatoria.Checked:=Msg.LetturaObbligatoria = 'S';
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine

  // id messaggio originale (risposte)
  edtIDOriginale.Text:=IntToStr(Msg.IDOriginale);

  // destinatari
  if FModalita = mgInvio then
  begin
    edtSelezione.Text:=IfThen(Msg.IDOriginale = 0,'',Msg.SelezioneAnagrafica);
    edtDestinatari.Text:=Trim(Msg.SelezioneAnagrafica + ' ' +
                              Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_DESTINATARI_SEL),
                                     [Msg.DestTot,Msg.DestTot - Msg.DestRicevuti]));
    AggiornaDestinatari;
  end;

  // allegati
  NumAllegati:=Length(Msg.AllegatiArr);
  grdAllegati.medpClearComp;
  grdAllegati.RowCount:=1;
  if NumAllegati > 1 then
    grdAllegati.RowCount:=NumAllegati;
  lblNoAllegati.Visible:=NumAllegati = 0;
  grdAllegati.Visible:=NumAllegati > 0;
  if NumAllegati > 0 then
  begin
    // visualizza allegati in tabella
    for i:=0 to NumAllegati - 1 do
    begin
      grdAllegati.Cell[i,0].Control:=CreaAllegatoCheck(i); // checkbox di selezione
      grdAllegati.Cell[i,1].Text:='';
      grdAllegati.Cell[i,1].Control:=CreaAllegatoLink(i);  // link per salvare allegato
    end;
  end;

  // abilitazione elementi interfaccia
  AbilitaUI;
end;

procedure TW035FMessaggistica.AbilitaUI;
var
  IsModifica: Boolean;
  r: Integer;
begin
  // reimposta la visibilita degli elementi
  ImpostaVisibilitaElementi;

  // abilita interfaccia se grid non è in browse
  IsModifica:=grdMessaggi.medpStato <> msBrowse;

  // abilitazione dettaglio in base allo stato della tabella
  edtOggetto.Enabled:=IsModifica;

  // EMPOLI_ASL11 - chiamata <78625>.ini
  // è necessario utilizzare Editable per rendere la textarea scrollabile
  //memTesto.Enabled:=IsModifica;
  memTesto.Editable:=IsModifica;
  // EMPOLI_ASL11 - chiamata <78625>.fine

  // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  chkLetturaObbligatoria.Editable:=IsModifica;
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine

  if Assigned(grdC700) then
  begin
    grdC700.AbilitaToolbar(IsModifica);
  end;

  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  if imgScegliDestOperatori.Visible then
  begin
    imgScegliDestOperatori.Enabled:=IsModifica;
    imgScegliDestOperatori.ImageFile.FileName:=IfThen(imgScegliDestOperatori.Enabled,fileImgOperatori,fileImgOperatoriDisab);
  end;
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  // allegati
  for r:=0 to grdAllegati.RowCount - 1 do
  begin
    if grdAllegati.Cell[r,0].Control <> nil then
    begin
      with (grdAllegati.Cell[r,0].Control as TmeIWCheckBox) do
      begin
        Editable:=IsModifica;
        Enabled:=IsModifica;
      end;
    end;
  end;

  // abilitazione filtri
  chkStatoSospeso.Enabled:=not IsModifica;
  chkStatoInviato.Enabled:=not IsModifica;
  chkStatoCancellato.Enabled:=not IsModifica;
  chkStatoTutti.Enabled:=not IsModifica;
  edtPeriodoDal.Enabled:=not IsModifica;
  edtPeriodoAl.Enabled:=not IsModifica;
  cmbFiltroMittente.Enabled:=not IsModifica;
  cmbFiltroSelezione.Enabled:=not IsModifica;
  edtRicerca.Enabled:=not IsModifica;
  btnFiltra.Enabled:=not IsModifica;
end;

procedure TW035FMessaggistica.ClearMessaggio;
// pulisce il messaggio e l'interfaccia
begin
  if grdMessaggi.medpStato = msBrowse then
  begin
    Msg.Clear;
    AggiornaUI;
  end;
end;

procedure TW035FMessaggistica.LeggiMessaggio;
// visualizza i dettagli del messaggio nell'interfaccia
var
  i: Integer;
  IsConcatenato: Boolean;
begin
  // pulisce dati messaggio
  Msg.Clear;

  // valorizza dati
  if (grdMessaggi.medpStato <> msInsert) and
     (selTabella.RecordCount > 0) then
  begin
    Msg.ID:=selTabella.FieldByName('ID').AsInteger;
    Msg.Stato:=selTabella.FieldByName('STATO').AsString;
    Msg.DataInvio:=selTabella.FieldByName('DATA_INVIO').AsDateTime;
    if Modalita = mgInvio then
      Msg.IDOriginale:=selTabella.FieldByName('ID_ORIGINALE').AsInteger;
    if grdMessaggi.medpStato = msBrowse then
    begin
      Msg.Oggetto:=selTabella.FieldByName('OGGETTO').AsString;
      Msg.Testo:=selTabella.FieldByName('TESTO').AsString;
      // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
      Msg.LetturaObbligatoria:=selTabella.FieldByName('LETTURA_OBBLIGATORIA').AsString;
      // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
      Msg.Modificato:=False;

      // destinatari
      if FModalita = mgInvio then
      begin
        Msg.DestLetti:=selTabella.FieldByName('D_DEST_LETTI').AsInteger;
        Msg.DestRicevuti:=selTabella.FieldByName('D_DEST_RICEVUTI').AsInteger;
        Msg.DestTot:=selTabella.FieldByName('D_DEST_TOT').AsInteger;
        Msg.SelezioneAnagrafica:=selTabella.FieldByName('SELEZIONE_ANAGRAFICA').AsString;
        Msg.ClearDestinatari;
        with W035DM.selT284 do
        begin
          First;
          while not Eof do
          begin
            Msg.AddDestinatario(FieldByName('PROGRESSIVO').AsInteger,
                                FieldByName('MATRICOLA').AsString,
                                FieldByName('COGNOME').AsString,
                                FieldByName('NOME').AsString,
                                FieldByName('DATA_LETTURA').AsDateTime,
                                FieldByName('DATA_RICEZIONE').AsDateTime);
            Next;
          end;
        end;
        // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
        Msg.ClearDestinatariOperatori;
        with W035DM.selT285 do
        begin
          First;
          while not Eof do
          begin
            Msg.AddDestinatarioOperatore(FieldByName('UTENTE').AsString,
                                         FieldByName('DATA_LETTURA').AsDateTime,
                                         FieldByName('DATA_RICEZIONE').AsDateTime);
            Next;
          end;
        end;
        // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
      end;
      Msg.DestModificati:=False;

      // elenco allegati
      Msg.ClearAllegati;
      with W035DM.selT283 do
      begin
        First;
        while not Eof do
        begin
          Msg.AddAllegato(FLAG_ALLEG_SALVATO,
                          FieldByName('NOME').AsString,
                          FieldByName('DIMENSIONE').AsLargeInt);

          Next;
        end;
      end;

      // copia l'array in un array parallelo per successivi confronti
      SetLength(Msg.FAllegatiCopyArr,Length(Msg.AllegatiArr));
      for i:=0 to High(Msg.AllegatiCopyArr) do
      begin
        // copymemory non sicura per via degli oggetti string nell'array
        //CopyMemory(@Msg.AllegatiCopyArr[i],@Msg.AllegatiArr[i],SizeOf(TAllegato));
        Msg.AllegatiCopyArr[i].Flag:=Msg.AllegatiArr[i].Flag;
        Msg.AllegatiCopyArr[i].NomeFile:=Msg.AllegatiArr[i].NomeFile;
        Msg.AllegatiCopyArr[i].ExtFile:=Msg.AllegatiArr[i].ExtFile;
        Msg.AllegatiCopyArr[i].DimFile:=Msg.AllegatiArr[i].DimFile;
        Msg.AllegatiCopyArr[i].DimFileStr:=Msg.AllegatiArr[i].DimFileStr;
      end;
    end;
  end;

  // aggiorna interfaccia
  AggiornaUI;

  // pulsante di storico messaggi
  IsConcatenato:=(not selTabella.FieldByName('ID_ORIGINALE').IsNull) or
                 (selTabella.FieldByName('D_RISPOSTE_TOT').AsInteger > 0);
  btnStorico.Visible:=(Parametri.CampiRiferimento.C90_MessaggisticaReply = 'S') and
                      (grdMessaggi.medpStato = msBrowse) and
                      (IsConcatenato);
end;

procedure TW035FMessaggistica.EspandiDettaglio;
// espande il div del dettaglio messaggio
var
  Js: String;
begin
  Js:=Format('try { jQuery.root.find("#%s").accordion("option","active",0); } catch(e) {}',[ID_DETTAGLIO]);
  if GGetWebApplicationThreadVar.IsCallBack then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Js)
  else
    AddToInitProc(Js);
end;

// procedura non utilizzata
(*
procedure TW035FMessaggistica.RiduciDettaglio;
// espande il div del dettaglio messaggio
var
  Js: String;
begin
  Js:=Format('try { jQuery.root.find("#%s").accordion("option","active",false); } catch(e) {}',[ID_DETTAGLIO]);
  if GGetWebApplicationThreadVar.IsCallBack then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Js)
  else
    AddToInitProc(Js);
end;
*)

function TW035FMessaggistica.GetNewID: Integer;
// estrae un nuovo ID messaggio dalla sequence oracle
begin
  W035DM.selT282ID.Execute;
  Result:=W035DM.selT282ID.FieldAsInteger(0);
end;

function TW035FMessaggistica.Controlla(const PAzione: String; var ErrMsg: String): Boolean;
// controlla il messaggio
// restituisce
//   True  se i controlli sono ok
//   False se i controlli non sono andati a buon fine
// parametri
//   PAzione: azione in fase di esecuzione
//     AZIONE_SALVA = salva
//     AZIONE_INVIA = invia
//   @ErrMsg
//     stringa di errore nel caso i controlli non siano andati a buon fine
var
  i,LOrig,LAttuale: Integer;
begin
  Result:=False;

  // determina se il messaggio è una risposta ad un altro messaggio
  if ModalitaRisposta then
  begin
    // messaggio di risposta
    Msg.IDOriginale:=StrToInt(edtIDOriginale.Text);
  end
  else
  begin
    // messaggio normale
    Msg.IDOriginale:=0;
  end;

  // oggetto: richiesto obbligatoriamente
  Msg.Oggetto:=Trim(edtOggetto.Text);
  if Msg.Oggetto = '' then
  begin
    ErrMsg:=A000TraduzioneStringhe(A000MSG_W035_MSG_CTRL_OGGETTO);
    Exit;
  end;

  // testo: nessun controllo
  Msg.Testo:=Trim(memTesto.Text);
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  if (ModalitaRisposta) and (Msg.Testo = '') then
  begin
    ErrMsg:=A000TraduzioneStringhe(A000MSG_W035_MSG_CTRL_TESTO);
    Exit;
  end;
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  // flag lettura obbligatoria: nessun controllo
  Msg.LetturaObbligatoria:=IfThen(chkLetturaObbligatoria.Checked,'S','N');
  // MONDOEDP - commessa MAN/07 SVILUPPO#57

  // selezione anagrafica: nessun controllo
  Msg.SelezioneAnagrafica:=edtSelezione.Text;

  // destinatari: obbligatori se azione = invio
  if PAzione = AZIONE_INVIA then
  begin
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    //if Length(Msg.DestArr) = 0 then
    if Length(Msg.DestArr) + Length(Msg.DestOperatoreArr) = 0 then
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
    begin
      ErrMsg:=A000TraduzioneStringhe(A000MSG_W035_MSG_CTRL_DESTINATARI);
      Exit;
    end;
  end;

  // allegati: determina se sono stati modificati
  Msg.AllegModificati:=False;
  LAttuale:=Length(Msg.AllegatiArr);
  LOrig:=Length(Msg.AllegatiCopyArr);
  if LAttuale > LOrig then
  begin
    // sono stati aggiunti allegati
    // se almeno uno è confermato allora indica che è avvenuta una modifica
    for i:=LOrig to LAttuale - 1 do
    begin
      if Msg.AllegatiArr[i].Flag = FLAG_ALLEG_NUOVO then
      begin
        Msg.AllegModificati:=True;
        Break;
      end;
    end;
  end
  else
  begin
    // nessun allegato aggiunto
    // se uno degli allegati originali è stato flaggato per la cancellazione
    // allora indica che è avvenuta una modifica
    for i:=0 to LAttuale - 1 do
    begin
      if Msg.AllegatiArr[i].Flag = FLAG_ALLEG_CANC_SALVATO then
      begin
        Msg.AllegModificati:=True;
        Break;
      end;
    end;
  end;

  // controlli ok
  Result:=True;
end;

function TW035FMessaggistica.Salva(var ErrMsg: String): Boolean;
// salva il messaggio nella tabella T282
var
  i, OldID: Integer;
  Blob: TLOBLocator;
  Flag, NomeFile, FilePath: String;
  DimFile: Int64;
begin
  Result:=False;
  OldID:=-1;
  try
    // dati del messaggio
    if ((grdMessaggi.medpStato = msInsert) or
        (Msg.EditAsNew))  then
    begin
      // inserimento nuovo messaggio oppure modifica di un messaggio già inviato
      OldID:=Msg.ID;
      selTabella.Append;
      Msg.ID:=GetNewID;
      Msg.Stato:=STATO_MSG_SOSPESO;
      selTabella.FieldByName('ID').AsInteger:=Msg.ID;
      selTabella.FieldByName('STATO').AsString:=Msg.Stato;
      selTabella.FieldByName('MITTENTE').AsString:=Parametri.Operatore;
      if ModalitaRisposta then
        selTabella.FieldByName('ID_ORIGINALE').AsInteger:=Msg.IDOriginale;
    end
    else
    begin
      selTabella.Edit;
    end;
    selTabella.FieldByName('OGGETTO').AsString:=Msg.Oggetto;
    selTabella.FieldByName('TESTO').AsString:=Msg.Testo;
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
    selTabella.FieldByName('LETTURA_OBBLIGATORIA').AsString:=Msg.LetturaObbligatoria;
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
    selTabella.FieldByName('SELEZIONE_ANAGRAFICA').AsString:=Msg.SelezioneAnagrafica;
    selTabella.Post;

    // destinatari messaggio
    if (Msg.DestModificati) or (Msg.EditAsNew) then
    begin
      // 1. elimina destinatari che non hanno ancora ricevuto il messaggio
      //    solo in caso di modifica
      if grdMessaggi.medpStato = msEdit then
      begin
        // se si sta modificando un messaggio già inviato
        // allora cancella i destinatari sul vecchio messaggio

        // 1a. cancella destinatari web
        if Msg.EditAsNew then
          W035DM.delT284.SetVariable('ID',OldID)
        else
          W035DM.delT284.SetVariable('ID',Msg.ID);
        W035DM.delT284.Execute;

        // 1b. cancella destinatari win
        if Msg.EditAsNew then
          W035DM.delT285.SetVariable('ID',OldID)
        else
          W035DM.delT285.SetVariable('ID',Msg.ID);
        W035DM.delT285.Execute;
      end;

      // 2a. inserisce destinatari web
      if Length(Msg.DestArr) > 0 then
      begin
        W035DM.selT284.Close;
        W035DM.selT284.Open;
        for i:=0 to High(Msg.DestArr) do
        begin
          // il progressivo potrebbe già essere presente
          // se il messaggio è in edit ed è già stato ricevuto
          if not W035DM.selT284.SearchRecord('PROGRESSIVO',Msg.DestArr[i].Progressivo,[srFromBeginning]) then
          begin
            W035DM.selT284.Append;
            W035DM.selT284.FieldByName('ID').AsInteger:=Msg.ID;
            W035DM.selT284.FieldByName('PROGRESSIVO').AsInteger:=Msg.DestArr[i].Progressivo;
            W035DM.selT284.Post;
          end;
        end;
      end;

      // 2b. inserisce destinatari win (operatori)
      if Length(Msg.DestOperatoreArr) > 0 then
      begin
        W035DM.selT285.Close;
        W035DM.selT285.Open;
        for i:=0 to High(Msg.DestOperatoreArr) do
        begin
          // il progressivo potrebbe già essere presente
          // se il messaggio è in edit ed è già stato ricevuto
          if not W035DM.selT285.SearchRecord('UTENTE',Msg.DestOperatoreArr[i].Utente,[srFromBeginning]) then
          begin
            W035DM.selT285.Append;
            W035DM.selT285.FieldByName('ID').AsInteger:=Msg.ID;
            W035DM.selT285.FieldByName('UTENTE').AsString:=Msg.DestOperatoreArr[i].Utente;
            W035DM.selT285.Post;
          end;
        end;
      end;
    end;

    // allegati messaggio
    if (Msg.AllegModificati) or (Msg.EditAsNew) then
    begin
      Blob:=TLOBLocator.CreateTemporary(SessioneOracle,otBLOB,True);
      try
        // imposta ID
        W035DM.insT283.SetVariable('ID',Msg.ID);
        W035DM.delT283.SetVariable('ID',Msg.ID);
        if Msg.EditAsNew then
        begin
          W035DM.insT283Dup.SetVariable('ID_OLD',OldID);
          W035DM.insT283Dup.SetVariable('ID_NEW',Msg.ID);
        end;

        // ciclo sugli allegati
        for i:=0 to High(Msg.AllegatiArr) do
        begin
          NomeFile:=Msg.AllegatiArr[i].NomeFile;
          Flag:=Msg.AllegatiArr[i].Flag;
          if Flag = FLAG_ALLEG_NUOVO then
          begin
            // nuovo allegato
            // 1. carica il file in un TLobLocator
            FilePath:=GGetWebApplicationThreadVar.UserCacheDir + NomeFile;
            DimFile:=R180GetFileSize(FilePath);
            Blob.LoadFromFile(FilePath);
            // 2. salva il file nel campo BLOB
            W035DM.insT283.SetVariable('NOME',NomeFile);
            W035DM.insT283.SetComplexVariable('ALLEGATO',Blob);
            W035DM.insT283.SetVariable('DIMENSIONE',DimFile);
            W035DM.insT283.Execute;
            // 3. elimina il file dal file system
            DeleteFile(FilePath);
          end
          else if Flag = FLAG_ALLEG_CANC_SALVATO then
          begin
            // allegato da cancellare
            if not Msg.EditAsNew then
            begin
              // elimina il record corrispondente
              W035DM.delT283.SetVariable('NOME',NomeFile);
              W035DM.delT283.Execute;
            end;
          end
          else if Flag = FLAG_ALLEG_SALVATO then
          begin
            if Msg.EditAsNew then
            begin
              // carica l'allegato sul nuovo messaggio
              W035DM.insT283Dup.SetVariable('NOME',NomeFile);
              W035DM.insT283Dup.Execute;
            end;
          end;
        end;
      finally
        Blob.Free;
      end;
    end;

    // operazione terminata con successo
    SessioneOracle.Commit;
    Result:=True;
  except
    on E: Exception do
    begin
      ErrMsg:=Format(A000TraduzioneStringhe(A000MSG_W035_ERR_SALVA),[E.Message]);
      SessioneOracle.Rollback;
      Exit;
    end;
  end;
end;

function TW035FMessaggistica.Invia(var ErrMsg: String; const PNotifica: Boolean): Boolean;
// effettua l'invio del messaggio ai destinatari
begin
  Result:=False;
  try
    // invio messaggio
    Msg.Stato:=STATO_MSG_INVIATO;
    Msg.DataInvio:=Now;
    selTabella.Edit;
    selTabella.FieldByName('STATO').AsString:=Msg.Stato;
    selTabella.FieldByName('DATA_INVIO').AsDateTime:=Msg.DataInvio;
    selTabella.Post;

    // operazione terminata con successo
    SessioneOracle.Commit;
    Result:=True;

    if PNotifica then
      Notifica('Messaggio inviato','Il messaggio è stato inviato','../img/mail-icon-ok.png',True,False,4000);
  except
    on E: Exception do
    begin
      ErrMsg:=Format(A000TraduzioneStringhe(A000MSG_W035_ERR_INVIO),[E.Message]);
      SessioneOracle.Rollback;
      Exit;
    end;
  end;
end;

function TW035FMessaggistica.Elimina(var ErrMsg: String; const PNotifica: Boolean): Boolean;
// se nessun destinatario ha ricevuto il messaggio lo elimina
// altrimenti imposta STATO = 'C' ed elimina i destinatari che non lo hanno ricevuto
begin
  Result:=False;
  if (Msg.Stato = STATO_MSG_SOSPESO) or (Msg.StatoRicezione = srNonRicevuto) then
  begin
    // se il messaggio è una bozza o non è ancora stato ricevuto da nessuno lo elimina direttamente
    try
      grdMessaggi.medpCancella;
      SessioneOracle.Commit;
      Result:=True;
      if PNotifica then
        Notifica(A000TraduzioneStringhe(A000MSG_W035_MSG_CANCELLATO),A000TraduzioneStringhe(A000MSG_W035_MSG_ELIMINATO),'../img/mail-icon-remove.png',False,False,4000);
    except
      on E: Exception do
      begin
        ErrMsg:=E.Message;
      end;
    end;
  end
  else
  begin
    try
      // 1. elimina destinatari che non hanno ancora ricevuto il messaggio
      W035DM.delT284.SetVariable('ID',Msg.ID);
      W035DM.delT284.Execute;

      // 2. imposta lo stato del messaggio a 'C' = cancellato
      selTabella.Edit;
      selTabella.FieldByName('STATO').AsString:=STATO_MSG_CANCELLATO;
      selTabella.Post;

      // operazione terminata con successo
      SessioneOracle.Commit;
      Result:=True;

      if PNotifica then
        Notifica(A000TraduzioneStringhe(A000MSG_W035_MSG_CANCELLATO),A000TraduzioneStringhe(A000MSG_W035_MSG_SEGNA_CANC),'../img/mail-icon-remove.png',False,False,4000);
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        ErrMsg:=E.Message;
      end;
    end;
  end;
end;

procedure TW035FMessaggistica.VisualizzaInvio(const FN: String; const PShow: Boolean);
// solo in modalità invio
// consente di visualizzare o nascondere l'immagine legata all'azione di invio messaggio
var
  r: Integer;
  IWC: TIWCustomControl;
begin
  // determina riga della struttura
  r:=grdMessaggi.medpRigaDiCompGriglia(FN);

  // estrae il puntatore all'immagine e se valido ne determina la visibilità
  if (grdMessaggi.medpRigaInserimento) and (r = 0) then
  begin
    // riga di inserimento: icona di conferma + invio
    IWC:=grdMessaggi.medpCompCella(r,iImgSalvaInvia,jImgSalvaInvia);
  end
  else
  begin
    // riga di modifica: icona di invio
    IWC:=grdMessaggi.medpCompCella(r,iImgInvia,jImgInvia);
  end;
  if Assigned(IWC) then
    IWC.Css:=IfThen(PShow,'','invisibile');
end;

procedure TW035FMessaggistica.CtrlImpostaStatoRicezione(EventParams: TStringList);
// imposta lo stato di ricezione del messaggio a "ricevuto"
var
  CookieDett,Errore: String;
  DettAperto: Boolean;
  r: Integer;
begin
  if GGetWebApplicationThreadVar.IsCallBack then
    DettAperto:=True
  else
  begin
    CookieDett:=GGetWebApplicationThreadVar.Request.CookieFields.Values[CookieDettName];
    DettAperto:=StrToIntDef(CookieDett,-1) >= 0;
  end;

  // in modalità messaggi ricevuti, se il dettaglio del messaggio è visualizzato
  //e la data di ricezione è nulla, la imposta
  if (Modalita = mgLettura) and
     (DettAperto) and
     (selTabella.Active) and
     (selTabella.RecordCount > 0) and
     (selTabella.FieldByName('DATA_RICEZIONE').IsNull) then
  begin
    if ImpostaStatoRicezione(Errore) then
    begin
      // MONDOEDP - commessa MAN/07 - SVILUPPO#51.ini
      // il flag di lettura del messaggio dipende dalla presenza di DATA_RICEZIONE
      // abilita il check in quanto il messaggio è stato "ricevuto" (il dettaglio è stato espanso)
      r:=grdMessaggi.medpRigaDiCompGriglia(selTabella.RowId);
      with (grdMessaggi.medpCompCella(r,iChkLetto,jChkLetto) as TmeIWCheckBox) do
      begin
        Enabled:=True;
        Hint:='';
      end;
    end
    else
    begin
      // errore nell'impostazione dello stato ricezione
      GGetWebApplicationThreadVar.ShowMessage(Errore);
    end;
  end;
end;

function TW035FMessaggistica.ImpostaStatoRicezione(var ErrMsg: String): Boolean;
// imposta lo stato di ricezione del messaggio a "ricevuto"
var
  updQuery: TOracleQuery;
begin
  // DATA_RICEZIONE is null     -> messaggio da ricevere
  // DATA_RICEZIONE is not null -> messaggio già ricevuto
  if selTabella.FieldByName('DATA_RICEZIONE').IsNull then
  begin
    Result:=False;

    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    if WR000DM.TipoUtente = 'Supervisore' then
    begin
      // aggiorna la data di ricezione sull'utente selezionato
      updQuery:=W035DM.updT285Ricezione;
      updQuery.SetVariable('UTENTE',selTabella.FieldByName('UTENTE').AsString);
    end
    else
    begin
      // aggiorna la data di ricezione sul progressivo selezionato
      updQuery:=W035DM.updT284Ricezione;
      updQuery.SetVariable('PROGRESSIVO',selTabella.FieldByName('PROGRESSIVO').AsInteger);
    end;

    // aggiorna data ricezione
    updQuery.SetVariable('ID',selTabella.FieldByName('ID').AsInteger);
    updQuery.SetVariable('DATA_RICEZIONE',Now);
    try
      updQuery.Execute;
      // operazione terminata con successo
      SessioneOracle.Commit;
      selTabella.RefreshRecord;
      Result:=True;
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        ErrMsg:=E.Message;
      end;
    end;
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
  end
  else
  begin
    // il messaggio è già stato contrassegnato come ricevuto
    Result:=True;
  end;
end;

function TW035FMessaggistica.ImpostaStatoLettura(const PLetto: Boolean; var ErrMsg: String): Boolean;
// segna il messaggio come letto / da leggere
var
  updQuery: TOracleQuery;
begin
  // DATA_LETTURA is null     -> messaggio da leggere
  // DATA_LETTURA is not null -> messaggio già letto

  // bugfix - 28.04.2014.ini
  // il refreshrecord non aggiorna correttamente il valore di DATA_LETTURA
  // pertanto questa ottimizzazione viene rimossa
  {
  if PLetto xor selTabella.FieldByName('DATA_LETTURA').IsNull then
  begin
    // la data di lettura è già coerente con il flag: update non necessaria
    Result:=True;
  end
  else
  }
  // bugfix - 28.04.2014.fine
  //begin
    Result:=False;

    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    if WR000DM.TipoUtente = 'Supervisore' then
    begin
      // aggiorna la data di lettura sull'utente selezionato
      updQuery:=W035DM.updT285Lettura;
      updQuery.SetVariable('UTENTE',selTabella.FieldByName('UTENTE').AsString);
    end
    else
    begin
      // aggiorna la data di lettura sul progressivo selezionato
      updQuery:=W035DM.updT284Lettura;
      updQuery.SetVariable('PROGRESSIVO',selTabella.FieldByName('PROGRESSIVO').AsInteger);
    end;
    updQuery.SetVariable('ID',selTabella.FieldByName('ID').AsInteger);
    if PLetto then
      updQuery.SetVariable('DATA_LETTURA',Now)
    else
      updQuery.SetVariable('DATA_LETTURA',null);
    try
      updQuery.Execute;
      // operazione terminata con successo
      SessioneOracle.Commit;
      selTabella.RefreshRecord; //*** sarebbe utile, ma non viene eseguita correttamente
      Result:=True;
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        ErrMsg:=E.Message;
      end;
    end;
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
  //end;
end;

// SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
// impostazione dello stato di lettura in async, senza refresh della tabella
{
procedure TW035FMessaggistica.imgLetturaClick(Sender: TObject);
// immagine di azione "segna come letto / da leggere"
var
  FN, ErrMsg: String;
  Letto: Boolean;
begin
  FN:=(Sender as TmeIWCheckBox).FriendlyName;
  Letto:=(Sender as TmeIWCheckBox).Checked;
  grdMessaggi.medpColumnClick(Sender,FN);

  // segna il messaggio come letto / da leggere
  if not ImpostaStatoLettura(Letto,ErrMsg) then
  begin
    MsgBox.MessageBox(ErrMsg,ESCLAMA);
    Exit;
  end;

  // refresh dataset
  AggiornaMessaggi(False);
end;
}

procedure TW035FMessaggistica.imgLetturaAsyncClick(Sender: TObject; EventParams: TStringList);
// immagine di azione "segna come letto / da leggere"
var
  FN, ErrMsg: String;
  Letto: Boolean;
begin
  FN:=(Sender as TmeIWCheckBox).FriendlyName;
  Letto:=(Sender as TmeIWCheckBox).Checked;
  grdMessaggi.medpColumnClick(Sender,FN);

  // segna il messaggio come letto / da leggere
  if not ImpostaStatoLettura(Letto,ErrMsg) then
  begin
    GGetWebApplicationThreadVar.ShowMessage(ErrMsg);
    Exit;
  end;

  // bugfix - non aggiornava conteggio messaggi
  AggiornaUI;
end;
// SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

// MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.ini
procedure TW035FMessaggistica.edtRiceventeAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  //
end;

procedure TW035FMessaggistica.edtRiceventeSubmit(Sender: TObject);
// input per il nome del ricevente: sul submit
var
  FN, Ricevente: String;
begin
  FN:=(Sender as TmeIWEdit).FriendlyName;
  Ricevente:=Trim((Sender as TmeIWEdit).Text);

  grdMessaggi.medpColumnClick(Sender,FN);

  if Ricevente <> selTabella.FieldByName('RICEVENTE').AsString then
  begin
    // aggiornamento
    try
      selTabella.Edit;
      selTabella.FieldByName('RICEVENTE').AsString:=Ricevente;
      selTabella.Post;
      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        MsgBox.MessageBox(Format(A000MSG_W035_ERR_FMT_SALVA_RICEVENTE,[E.Message]),ESCLAMA);
        selTabella.Cancel;
      end;
    end;
  end;
end;
// MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.ini

procedure TW035FMessaggistica.imgInviaClick(Sender: TObject);
// immagine di azione invio messaggio
var
  FN, ErrMsg: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  ErrMsg:='';
  grdMessaggi.medpColumnClick(Sender,FN);

  // controllo dei dati per l'invio
  if not Controlla(AZIONE_INVIA,ErrMsg) then
  begin
    MsgBox.MessageBox(ErrMsg,ESCLAMA);
    Exit;
  end;

  // invia il messaggio ai destinatari (modifica lo stato e la data invio)
  if not Invia(ErrMsg,True) then
  begin
    MsgBox.MessageBox(ErrMsg,ESCLAMA);
    Exit;
  end;

  AggiornaMessaggi(True);
end;

// SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
procedure TW035FMessaggistica.imgConfermaInviaClick(Sender: TObject);
var
  FN, ErrMsg: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  ErrMsg:='';
  grdMessaggi.medpColumnClick(Sender,FN);

  // controllo dei dati per l'invio
  if not Controlla(AZIONE_INVIA,ErrMsg) then
  begin
    MsgBox.MessageBox(ErrMsg,ESCLAMA);
    Exit;
  end;

  // salva il messaggio su db
  if not Salva(ErrMsg) then
  begin
    //raise Exception.Create(ErrMsg);
    MsgBox.MessageBox(ErrMsg,ESCLAMA);
    Exit;
  end;

  // invia il messaggio ai destinatari (modifica lo stato e la data invio)
  if not Invia(ErrMsg,True) then
  begin
    //raise Exception.Create(ErrMsg);
    MsgBox.MessageBox(ErrMsg,ESCLAMA);
    Exit;
  end;

  AggiornaMessaggi(True);
end;

procedure TW035FMessaggistica.btnRispondiClick(Sender: TObject);
var
  OldMittente,OldDescMittente,OldOggetto: String;
  OldId: Integer;
  IWC: TIWCustomControl;
  IWImg: TmeIWImageFile;
  DestWeb: Boolean;
  DestProg: Integer;
  DestMatr: String;
  DestCognome: String;
  DestNome: string;
begin
  // salva i dati per la risposta in variabili di appoggio
  OldMittente:=selTabella.FieldByName('MITTENTE').AsString;
  OldDescMittente:=selTabella.FieldByName('D_MITTENTE').AsString;
  OldId:=selTabella.FieldByName('ID').AsInteger;
  OldOggetto:=selTabella.FieldByName('OGGETTO').AsString;

  // modalità invio
  tabMessaggi.ActiveTabIndex:=TAB_IDX_INVIO;
  ModalitaRisposta:=True;

  // simula inserimento nuovo messaggio
  if grdMessaggi.medpRigaInserimento then
  begin
    IWC:=grdMessaggi.medpCompCella(0,0,0);
    if (Assigned(IWC)) and
       (IWC is TmeIWImageFile) then
    begin
      IWImg:=(IWC as TmeIWImageFile);
      if Assigned(@IWImg.OnClick) then
      begin
        IWImg.OnClick(IWImg);
      end;
    end;
  end;

  // imposta i dati per la risposta
  edtIDOriginale.Text:=IntToStr(OldId);
  if UpperCase(LeftStr(OldOggetto,Length(PREFISSO_OGGETTO_RISPOSTA))) = UpperCase(PREFISSO_OGGETTO_RISPOSTA) then
    edtOggetto.Text:=OldOggetto
  else
    edtOggetto.Text:=PREFISSO_OGGETTO_RISPOSTA + OldOggetto;

  // destinatario: è il mittente del messaggio originale
  // verifica se si tratta di utente web o di operatore win
  DestWeb:=False;
  DestProg:=0;
  DestMatr:='';
  DestCognome:='';
  DestNome:='';
  with W035DM.selI060 do
  begin
    try
      //SetVariable('UTENTE',OldMittente);
      R180SetVariable(W035DM.selI060,'UTENTE',OldMittente);
      Open;
      if RecordCount > 0 then
      begin
        DestWeb:=True;
        DestProg:=FieldByName('PROGRESSIVO').AsInteger;
        DestMatr:=FieldByName('MATRICOLA').AsString;
        DestCognome:=FieldByName('COGNOME').AsString;
        DestNome:=FieldByName('NOME').AsString;
      end;
    except
    end;
  end;

  if DestWeb then
    Msg.AddDestinatario(DestProg,DestMatr,DestCognome,DestNome,DATE_NULL,DATE_NULL)
  else
    Msg.AddDestinatarioOperatore(OldMittente,DATE_NULL,DATE_NULL);
  Msg.DestModificati:=True;

  // aggiorna interfaccia
  edtSelezione.Text:='';
  edtDestinatari.Text:=Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_DESTINATARI_SEL),[1,1]);
  AggiornaDestinatari;

  memTesto.SetFocus;
end;
// SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

procedure TW035FMessaggistica.btnDestinatariClick(Sender: TObject);
// visualizza dettaglio destinatari
begin
  rgnDestinatari.Visible:=True;
  VisualizzajQMessaggio(jqDestinatari,650,-1,-1,'Elenco destinatari','#' + rgnDestinatari.HTMLName,True,True,-1,'','',btnChiudiDest.HTMLName);
end;

procedure TW035FMessaggistica.btnChiudiDestClick(Sender: TObject);
// chiusura del dialog dei destinatari
begin
  rgnDestinatari.Visible:=False;
  jqDestinatari.OnReady.Clear;
end;

procedure TW035FMessaggistica.btnStoricoClick(Sender: TObject);
// PRE: la catena esiste
var
  Titolo: String;
begin
  // apre dataset per elenco messaggi legati all'id iniziale
  // (utilizza connect by prior)
  with W035DM.selElencoMsg do
  begin
    Close;
    SetVariable('ID',selTabella.FieldByName('ID').AsInteger);
    Open;
  end;

  // aggiorna tabella di elenco messaggi
  // seleziona il messaggio corrente nella tabella
  grdElenco.medpCaricaCDS(selTabella.FieldByName('ID').AsString);

  // visualizza region e attiva dialog jquery ui
  rgnElenco.Visible:=True;
  Titolo:='Storico: ' + VarToStr(W035DM.selElencoMsg.Lookup('LEVEL',1,'OGGETTO'));
  VisualizzajQMessaggio(jqElenco,650,-1,-1,Titolo,'#' + rgnElenco.HTMLName,True,True,-1,'','',btnChiudiElenco.HTMLName);
end;

procedure TW035FMessaggistica.btnChiudiElencoClick(Sender: TObject);
begin
  rgnElenco.Visible:=False;
  jqElenco.OnReady.Clear;
end;

procedure TW035FMessaggistica.btnFiltraClick(Sender: TObject);
// aggiornamento visualizzazione
begin
  AggiornaMessaggi(True);
end;

procedure TW035FMessaggistica.InizializzaFiltriModalita;
// inizializza i filtri di selezione messaggi per ogni possibile modalità di visualizzazione
var
  i: Integer;
begin
  for i:=0 to tabMessaggi.TabCount - 1 do
  begin
    with FDatiModalitaArr[i] do
    begin
      // bookmark record selezionato
      selTabella_Bookmark:=nil;
      // checkbox selezione stato
      chkStatoSospeso_Checked:=(i = TAB_IDX_INVIO);
      chkStatoInviato_Checked:=True;
      chkStatoCancellato_Checked:=False;
      chkStatoTutti_Checked:=False;
      // periodo invio dal - al
      edtPeriodoDal_Text:='';
      edtPeriodoAl_Text:='';
      // in lettura filtra sui messaggi da leggere
      if i = TAB_IDX_LETTURA then
        rgpFiltroDaLeggere.ItemIndex:=ITEM_DA_LEGGERE;
      // filtri selezione anagrafica e mittente
      cmbFiltroSelezione_ItemIndex:=0;
      cmbFiltroMittente_ItemIndex:=0;
      // ricerca per oggetto e/o testo
      edtRicerca_Text:='';
    end;
  end;
end;

procedure TW035FMessaggistica.PulisciFiltriModalita;
// ripristina i filtri iniziali
begin
  // checkbox selezione stato
  chkStatoSospeso.Checked:=FModalita = mgInvio;
  chkStatoInviato.Checked:=True;
  chkStatoCancellato.Checked:=False;
  chkStatoTutti.Checked:=False;

  // periodo invio dal - al
  edtPeriodoDal.Clear;
  edtPeriodoAl.Clear;

  // in lettura filtra sui messaggi da leggere
  if FModalita = mgLettura then
    rgpFiltroDaLeggere.ItemIndex:=ITEM_DA_LEGGERE;

  // filtri selezione anagrafica e mittente
  cmbFiltroSelezione.ItemIndex:=0;
  cmbFiltroMittente.ItemIndex:=0;

  // ricerca per oggetto e/o testo
  edtRicerca.Clear;
end;

procedure TW035FMessaggistica.SalvaFiltriModalita;
// salva le impostazioni dei filtri sulla modalità corrente
begin
  if (tabMessaggi.ActiveTabIndex < Low(FDatiModalitaArr)) or
     (tabMessaggi.ActiveTabIndex > High(FDatiModalitaArr)) then
    Exit;

  with FDatiModalitaArr[tabMessaggi.ActiveTabIndex] do
  begin
    // bookmark record selezionato
    if (Assigned(selTabella)) and (selTabella.Active) and (selTabella.RecordCount > 0) then
      selTabella_Bookmark:=selTabella.GetBookmark
    else
      selTabella_Bookmark:=nil;
    // checkbox selezione stato
    chkStatoSospeso_Checked:=chkStatoSospeso.Checked;
    chkStatoInviato_Checked:=chkStatoInviato.Checked;
    chkStatoCancellato_Checked:=chkStatoCancellato.Checked;
    chkStatoTutti_Checked:=chkStatoTutti.Checked;
    // periodo invio dal - al
    edtPeriodoDal_Text:=edtPeriodoDal.Text;
    edtPeriodoAl_Text:=edtPeriodoAl.Text;
    // in lettura filtra sui messaggi da leggere
    rgpFiltroDaLeggere_ItemIndex:=rgpFiltroDaLeggere.ItemIndex;
    // filtri selezione anagrafica e mittente
    cmbFiltroSelezione_ItemIndex:=cmbFiltroSelezione.ItemIndex;
    cmbFiltroMittente_ItemIndex:=cmbFiltroMittente.ItemIndex;
    // ricerca per oggetto e/o testo
    edtRicerca_Text:=edtRicerca.Text;
  end;
end;

procedure TW035FMessaggistica.RipristinaFiltriModalita;
// ripritina le impostazioni dei filtri per la modalità corrente
begin
  if (tabMessaggi.ActiveTabIndex < Low(FDatiModalitaArr)) or
     (tabMessaggi.ActiveTabIndex > High(FDatiModalitaArr)) then
    Exit;

  with FDatiModalitaArr[tabMessaggi.ActiveTabIndex] do
  begin
    // checkbox selezione stato
    chkStatoSospeso.Checked:=chkStatoSospeso_Checked;
    chkStatoInviato.Checked:=chkStatoInviato_Checked;
    chkStatoCancellato.Checked:=chkStatoCancellato_Checked;
    chkStatoTutti.Checked:=chkStatoTutti_Checked;
    // periodo invio dal - al
    edtPeriodoDal.Text:=edtPeriodoDal_Text;
    edtPeriodoAl.Text:=edtPeriodoAl_Text;
    // in lettura filtra sui messaggi da leggere
    rgpFiltroDaLeggere.ItemIndex:=rgpFiltroDaLeggere_ItemIndex;
    // filtri selezione anagrafica e mittente
    cmbFiltroSelezione.ItemIndex:=cmbFiltroSelezione_ItemIndex;
    cmbFiltroMittente.ItemIndex:=cmbFiltroMittente_ItemIndex;
    // ricerca per oggetto e/o testo
    edtRicerca.Text:=edtRicerca_Text;
  end;
end;

procedure TW035FMessaggistica.RipristinaBookmarkModalita;
begin
  if (tabMessaggi.ActiveTabIndex < Low(FDatiModalitaArr)) or
     (tabMessaggi.ActiveTabIndex > High(FDatiModalitaArr)) then
    Exit;

  // bookmark record selezionato
  with FDatiModalitaArr[tabMessaggi.ActiveTabIndex] do
  begin
    if Assigned(selTabella_Bookmark) and selTabella.BookmarkValid(selTabella_Bookmark) then
    begin
      selTabella.GotoBookmark(selTabella_Bookmark);
      grdMessaggi.medpClientDataSet.Locate('ID',selTabella.FieldByName('ID').AsInteger,[]);
    end;
  end;
end;

function TW035FMessaggistica.GetFiltroMessaggi: String;
// restituisce una stringa sql che rappresenta la parte di "where" valorizzata
// in base ai filtri attualmente indicati nell'interfaccia
var
  Cod,Filtro,FiltroPeriodo,FiltroStato: String;
  Inizio, Fine: TDateTime;
begin
  Result:='';

  // filtro periodo di invio
  if chkStatoInviato.Checked then
  begin
    // controllo periodo
    if edtPeriodoDal.Text = '' then
      Inizio:=DATE_MIN
    else
    begin
      if not TryStrToDate(edtPeriodoDal.Text,Inizio) then
        raise Exception.Create('La data di inizio periodo non è valida!');
    end;
    if edtPeriodoAl.Text = '' then
      Fine:=DATE_MAX
    else
    begin
      if not TryStrToDate(edtPeriodoAl.Text,Fine) then
        raise Exception.Create('La data di fine periodo non è valida!');
    end;
    if Inizio > Fine then
      raise Exception.Create('Il periodo di invio non è valido!');

    // impostazione filtro
    if (Inizio = DATE_MIN) and (Fine = DATE_MAX) then
    begin
      // periodo non indicato
      FiltroPeriodo:='';
    end
    else if Inizio = Fine then
    begin
      // periodo di un solo giorno
      FiltroPeriodo:=Format('(trunc(T282.DATA_INVIO) = to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',Inizio)]);
    end
    else if Inizio = DATE_MIN then
    begin
      // periodo <= di una data
      FiltroPeriodo:=Format('(trunc(T282.DATA_INVIO) <= to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',Fine)]);
    end
    else if Fine = DATE_MAX then
    begin
      // periodo >= di una data
      FiltroPeriodo:=Format('(trunc(T282.DATA_INVIO) >= to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',Inizio)]);
    end
    else
    begin
      // periodo di più giorni compreso fra due date
      FiltroPeriodo:=Format('(trunc(T282.DATA_INVIO) >= to_date(''%s'',''dd/mm/yyyy'') and trunc(T282.DATA_INVIO) <= to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',Inizio),FormatDateTime('dd/mm/yyyy',Fine)]);
    end;
  end
  else
  begin
    FiltroPeriodo:='';
  end;

  // filtro stato (e periodo invio)
  FiltroStato:='';
  if (not chkStatoTutti.Checked) or (FiltroPeriodo <> '') then
  begin
    // sospesi
    if chkStatoSospeso.Checked then
    begin
      Filtro:=Format('(T282.STATO = ''%s'')',[STATO_MSG_SOSPESO]);
      FiltroStato:=FiltroStato + IfThen(FiltroStato <> '',' or ') + Filtro;
    end;
    // inviati
    if chkStatoInviato.Checked then
    begin
      Filtro:=Format('(T282.STATO = ''%s'')',[STATO_MSG_INVIATO]);
      if FiltroPeriodo <> '' then
        Filtro:=Format('(%s and %s)',[Filtro,FiltroPeriodo]);
      FiltroStato:=FiltroStato + IfThen(FiltroStato <> '',' or ') + Filtro;
    end;
    // cancellati
    if chkStatoCancellato.Checked then
    begin
      Filtro:=Format('(T282.STATO = ''%s'')',[STATO_MSG_CANCELLATO]);
      FiltroStato:=FiltroStato + IfThen(FiltroStato <> '',' or ') + Filtro;
    end;
    FiltroStato:=Format('(%s)',[FiltroStato]);
  end;
  Result:=Result + IfThen((Result <> '') and (FiltroStato <> ''),' and ') + FiltroStato;

  if FModalita = mgLettura then
  begin
    // filtro da leggere / letti
    case rgpFiltroDaLeggere.ItemIndex of
      ITEM_DA_LEGGERE: // da leggere (stato = messaggi inviati)
         Filtro:='(T_DEST.DATA_LETTURA is null)';
      ITEM_LETTI:      // già letti  (stato = messaggi inviati)
         Filtro:='(T_DEST.DATA_LETTURA is not null)';
      ITEM_TUTTI:      // tutti      (stato = messaggi inviati + cancellati)
         Filtro:='';
      // EMPOLI_ASL11 - chiamata 75318.ini
      {
      ITEM_CANCELLATI: // cancellati (stato = messaggi cancellati) - esclude quelli da leggere
         Filtro:='(T_DEST.DATA_LETTURA is not null)';
      }
      ITEM_CANCELLATI: // cancellati (stato = messaggi cancellati)
         Filtro:='';
      // EMPOLI_ASL11 - chiamata 75318.fine
    end;
    Result:=Result + IfThen((Result <> '') and (Filtro <> ''),' and ') + Filtro;

    // filtro mittente
    Cod:=cmbFiltroMittente.Items.ValueFromIndex[cmbFiltroMittente.ItemIndex];
    Filtro:=IfThen(Cod <> '',Format('(T282.MITTENTE = ''%s'')',[AggiungiApice(Cod)]));
    Result:=Result + IfThen((Result <> '') and (Filtro <> ''),' and ') + Filtro;
  end
  else
  begin
    // filtro selezione anagrafica
    Cod:=cmbFiltroSelezione.Text;
    Filtro:=IfThen(Cod <> '',Format('(T282.SELEZIONE_ANAGRAFICA = ''%s'')',[Cod]));
    Result:=Result + IfThen((Result <> '') and (Filtro <> ''),' and ') + Filtro;
  end;

  // ricerca per oggetto / testo (case-insensitive)
  if (Trim(edtRicerca.Text) <> '') and (edtRicerca.Text <> edtRicerca.medpWatermark) then
  begin
    Cod:=UpperCase(AggiungiApice(Trim(edtRicerca.Text)));
    Filtro:=IfThen(Cod <> '',Format('((UPPER(T282.OGGETTO) like ''%%%s%%'') or (UPPER(T282.TESTO) like ''%%%s%%''))',[Cod,Cod]));
    Result:=Result + IfThen((Result <> '') and (Filtro <> ''),' and ') + Filtro;
  end;

  if Result <> '' then
    Result:=Format('and (%s)',[Result]);
end;

procedure TW035FMessaggistica.cmbFiltroMittenteChange(Sender: TObject);
begin
  AggiornaMessaggi(False);
end;

procedure TW035FMessaggistica.cmbFiltroSelezioneChange(Sender: TObject);
begin
  AggiornaMessaggi(False);
end;

procedure TW035FMessaggistica.grdMessaggimedpStatoChange;
begin
  AbilitaUI;
end;

procedure TW035FMessaggistica.grdMessaggiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
  Stato,LettoStr,DataRicStr: String;
  LettoDate: TDateTime;
  Ricevuto, AbilModifica, AbilElimina: Boolean;
begin
  // riga di inserimento
  if grdMessaggi.medpRigaInserimento then
  begin
    if FModalita = mgInvio then
    begin
      // conferma e invia messaggio: inizialmente nascosto
      with (grdMessaggi.medpCompCella(0,iImgSalvaInvia,jImgSalvaInvia) as TmeIWImageFile) do
      begin
        OnClick:=imgConfermaInviaClick;
        Css:='invisibile';
      end;
    end;
  end;

  // righe dei dati
  for i:=IfThen(grdMessaggi.medpRigaInserimento,1,0) to High(grdMessaggi.medpCompGriglia) do
  begin
    Stato:=grdMessaggi.medpValoreColonna(i,'STATO');
    if FModalita = mgLettura then
    begin
      // data lettura in formato stringa
      LettoStr:=grdMessaggi.medpValoreColonna(i,'DATA_LETTURA');
      if LettoStr <> '' then
      begin
        if TryStrToDateTime(LettoStr,LettoDate) then
          LettoStr:=FormatDateTime('dd/mm/yyyy hhhh.nn',LettoDate);
      end;

      // segna come letto / non letto
      with (grdMessaggi.medpCompCella(i,iChkLetto,jChkLetto) as TmeIWCheckBox) do
      begin
        Caption:=LettoStr;
        // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
        // impostazione lettura in async (senza refresh tabella)
        //OnClick:=imgLetturaClick;
        OnAsyncClick:=imgLetturaAsyncClick;
        // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
        Checked:=LettoStr <> '';
        // MONDOEDP - commessa MAN/07 - SVILUPPO#51.ini
        // abilita il check solo se il messaggio è già stato "ricevuto" (ossia se il dettaglio è stato espanso)
        //Enabled:=(Stato = STATO_MSG_INVIATO);
        DataRicStr:=grdMessaggi.medpValoreColonna(i,'DATA_RICEZIONE');
        Enabled:=(Stato = STATO_MSG_INVIATO) and (DataRicStr <> '');
        Hint:=IfThen(DataRicStr = '','Espandere il dettaglio messaggio per abilitare questo flag','');
        // MONDOEDP - commessa MAN/07 - SVILUPPO#51.fine
      end;

      // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.ini
      // ricevente
      if VisualizzaRicevente then
      begin
        with (grdMessaggi.medpCompCella(i,iEdtRicevente,jEdtRicevente) as TmeIWEdit) do
        begin
          OnAsyncClick:=edtRiceventeAsyncClick;
          Text:=grdMessaggi.medpValoreColonna(i,'RICEVENTE');
          OnSubmit:=edtRiceventeSubmit;
        end;
      end;
      // MONDOEDP - commessa MAN/07 - SVILUPPO#51 - riesame del 11.10.2013.fine
    end
    else
    begin
      // modalità messaggi inviati

      // determina se il messaggio è già stato ricevuto da qualche destinatario
      Ricevuto:=StrToIntDef(grdMessaggi.medpValoreColonna(i,'D_DEST_RICEVUTI'),0) > 0;

      // modifica disabilitato se stato "C"
      AbilModifica:=(Stato <> STATO_MSG_CANCELLATO);
      // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
      if Parametri.CampiRiferimento.C90_MessaggisticaReply = 'S' then
        AbilModifica:=AbilModifica and (not Ricevuto);
      // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
      with (grdMessaggi.medpCompCella(i,0,0) as TmeIWImageFile) do
      begin
        Css:=IfThen(AbilModifica,'','invisibile');
      end;

      // cancella disabilitato se stato = "C"
      AbilElimina:=(Stato <> STATO_MSG_CANCELLATO);
      // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
      if Parametri.CampiRiferimento.C90_MessaggisticaReply = 'S' then
        AbilElimina:=AbilElimina and (not Ricevuto);
      // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
      with (grdMessaggi.medpCompCella(i,0,1) as TmeIWImageFile) do
      begin
        Css:=IfThen(AbilElimina,'','invisibile');
      end;

      // invia messaggio
      with (grdMessaggi.medpCompCella(i,iImgInvia,jImgInvia) as TmeIWImageFile) do
      begin
        if Stato = STATO_MSG_SOSPESO then
          OnClick:=imgInviaClick;
        Css:=IfThen(Stato = STATO_MSG_SOSPESO,'','invisibile');
      end;
    end;
  end;
end;

procedure TW035FMessaggistica.grdMessaggiAnnulla(Sender: TObject);
begin
  // disattiva modalità risposta e pulisce dati
  if ModalitaRisposta then
  begin
    ModalitaRisposta:=False;

    // pulisce messaggio
    Msg.Clear;
    AggiornaUI;
  end;
end;

procedure TW035FMessaggistica.grdMessaggiInserisci(Sender: TObject);
// ridefinisce evento di inserimento record su tabella
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // visualizza icona di conferma e invio messaggio
  VisualizzaInvio(FN,True);

  // pulisce messaggio per inserimento
  Msg.Clear;
  AggiornaUI;

  // apre il dettaglio messaggio
  EspandiDettaglio;

  // focus su oggetto
  edtOggetto.SetFocus;
end;

procedure TW035FMessaggistica.grdMessaggiModifica(Sender: TObject);
// ridefinisce evento di modifica record su tabella
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // nasconde icona di invio messaggio
  VisualizzaInvio(FN,False);

  // apre il dettaglio messaggio
  EspandiDettaglio;

  // focus su oggetto
  edtOggetto.SetFocus;

  if Msg.Stato = STATO_MSG_INVIATO then
  begin
    // messaggio già inviato
    // predispone la maschera per l'inserimento di un nuovo messaggio
    // con i dati uguali al messaggio attuale
    Msg.EditAsNew:=True;
  end;
end;

procedure TW035FMessaggistica.grdMessaggiCancella(Sender: TObject);
// ridefinisce evento di cancellazione record su tabella
var
  ErrMsg: String;
begin
  // cancellazione messaggio
  if not Elimina(ErrMsg,True) then
  begin
    raise Exception.Create(ErrMsg);
  end;

  AggiornaMessaggi(True);
end;

procedure TW035FMessaggistica.grdMessaggiConferma(Sender: TObject);
// ridefinisce evento di conferma record su tabella
var
  ErrMsg: String;
  OldID: Integer;
begin
  // controllo dei dati per il salvataggio
  if not Controlla(AZIONE_SALVA,ErrMsg) then
    raise Exception.Create(ErrMsg);

  // se il messaggio è in stato inviato e non viene modificato,
  // non effettua nessuna operazione
  if Msg.EditAsNew and not (Msg.Modificato or Msg.DestModificati or Msg.AllegModificati) then
    Exit;

  // salva l'id del messaggio originale, che sarà utilizzato nel caso di modifica di un messaggio inviato
  OldID:=Msg.ID;

  // salva il messaggio su db
  if not Salva(ErrMsg) then
    raise Exception.Create(ErrMsg);

  // nel caso di modifica di un messaggio inviato
  // effettua la cancellazione del vecchio messaggio
  if Msg.EditAsNew then
  begin
    // EMPOLI_ASL11 - chiamata 75318.ini
    // forzatura necessaria per rileggere i dati del messaggio
    grdMessaggi.medpStato:=msBrowse;
    // EMPOLI_ASL11 - chiamata 75318.fine

    // posizionamento sul messaggio originale
    selTabella.SearchRecord('ID',OldId,[srFromBeginning]);

    // tenta la cancellazione del messaggio
    if not Elimina(ErrMsg,False) then
      raise Exception.Create(ErrMsg);
    Msg.EditAsNew:=False;
  end;

  // refresh visualizzazione
  AggiornaMessaggi(True);
end;

procedure TW035FMessaggistica.grdMessaggiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna, NumAllegati, NumDest, Diff: Integer;
  PercLettura: real;
  Campo, NumDestStr: String;
begin
  if not grdMessaggi.medpRenderCell(ACell,ARow,AColumn,True,True,True) then
    Exit;

  NumColonna:=grdMessaggi.medpNumColonna(AColumn);
  Campo:=grdMessaggi.medpColonna(NumColonna).DataField;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdMessaggi.medpCompGriglia) + 1) and (grdMessaggi.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdMessaggi.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  if ARow = 0 then
  begin
    // intestazione
    if Campo = 'DBG_COMANDI' then
      ACell.Text:=IfThen(FModalita = mgLettura,'Letto');
  end
  else if ARow > IfThen(grdMessaggi.medpRigaInserimento,1,0) then
  begin
    // dettaglio

    // valorizza variabili di supporto
    if FModalita = mgInvio then
    begin
      NumDest:=grdMessaggi.medpClientDataSet.FieldByName('D_DEST_TOT').AsInteger;
      NumDestStr:=A000TraduzioneStringhe(IfThen(NumDest = 1,A000MSG_W035_MSG_DESTINATARI_1,Format(A000MSG_W035_MSG_FMT_DESTINATARI,[NumDest])));
    end
    else
    begin
      NumDest:=0;
      NumDestStr:='';
    end;

    // valuta i singoli campi
    if Campo = 'DATA_INVIO' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if Campo = 'DATA_LETTURA' then
    begin
      // evidenzia stato cancellato
      if (grdMessaggi.medpClientDataSet.FieldByName('STATO').AsString = STATO_MSG_CANCELLATO) and
         (Assigned(ACell.Control)) and
         (ACell.Control is TmeIWCheckBox) then
      begin
        (ACell.Control as TmeIWCheckBox).Css:=StringReplace((ACell.Control as TmeIWCheckBox).Css,'comandi','msg_canc',[]);
      end;
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if Campo = 'DATA_RICEZIONE' then
    begin
      // data di ricezione messaggio
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if Campo = 'TESTO' then
    begin
      // se il testo supera certe soglie (lunghezza o ritorni a capo)
      // lo riduce inserendo dei puntini di sospensione
      // per evitare che la riga ecceda un'altezza accettabile
      if Length(ACell.Text) > LIMITE_CARATTERI_TESTO then
      begin
        ACell.Text:=Format('%s...',[Copy(ACell.Text,1,LIMITE_CARATTERI_TESTO)]);
      end;
      if ACell.RawText then
      begin
        ACell.Text:=Format('<div style="overflow-y: hidden; text-overflow: ellipsis; max-height: %dem;">%s</div>',[LIMITE_RIGHE_TESTO,ACell.Text]);
      end;
    end
    else if Campo = 'D_ALLEGATI' then
    begin
      NumAllegati:=StrToIntDef(ACell.Text,0);
      ACell.RawText:=NumAllegati > 0;
      ACell.Text:=IfThen(NumAllegati > 0,Format('<img class="icona" alt="Allegati" src="../img/attachment.png"> <span class="contatore_pedice">%d</span>',[NumAllegati]));
      if NumAllegati > 0 then
        ACell.Css:=ACell.Css + ' align_center';
    end
    else if Campo = 'SELEZIONE_ANAGRAFICA' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
      ACell.Text:=ACell.Text + IfThen(ACell.Text <> '',': ') + NumDestStr;
    end
    else if Campo = 'D_STATO_LETTURA' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if Campo = 'D_STATO_RICEZIONE' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
    else if Campo = 'LETTURA_OBBLIGATORIA' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
      // traduce S/N con valori in linguaggio più comprensibile
      if ACell.Text = 'S' then
        ACell.Text:='Sì'
      else if ACell.Text = 'N' then
        ACell.Text:='No';
    end
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
    // GENOVA_HSMARTINO - chiamata 88109.ini
    // visualizza elenco destinatari
    else if (Campo = 'D_DESTINATARI') and (FModalita = mgInvio) then
    begin
      Diff:=NumDest - LIMITE_DESTINATARI_VISUALIZZATI;
      if Diff > 0 then
      begin
        ACell.Text:=ACell.Text + ', ...';
      end;
      ACell.Css:=ACell.Css + ' align_center';
    end;
    // GENOVA_HSMARTINO - chiamata 88109.fine

    // evidenzia messaggi da leggere in base alla modalità
    if FModalita = mgLettura then
    begin
      if grdMessaggi.medpClientDataSet.FieldByName('DATA_LETTURA').IsNull then
        ACell.Css:=ACell.Css + ' ' + CSS_MSG_RICEVUTO_DALEGGERE;
    end
    else
    begin
      // messaggi inviati letti
      PercLettura:=grdMessaggi.medpClientDataSet.FieldByName('D_PERC_LETTURA').AsFloat;
      if PercLettura = 0 then
        ACell.Css:=ACell.Css + ' ' + CSS_MSG_INVIATO_DALEGGERE
      else if PercLettura = 1 then
        ACell.Css:=ACell.Css + ' ' + CSS_MSG_INVIATO_LETTO
      else
        ACell.Css:=ACell.Css + ' ' + CSS_MSG_INVIATO_LETTOPARZIALMENTE;
    end;
    // evidenza messaggi cancellati
    if grdMessaggi.medpClientDataSet.FieldByName('STATO').AsString = STATO_MSG_CANCELLATO then
    begin
      ACell.Css:=ACell.Css + ' ' + CSS_MSG_CANCELLATO;
    end;
  end;
end;

//############################################//
//###          GESTIONE DESTINATARI        ###//
//############################################//

procedure TW035FMessaggistica.grdDestinatariRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
begin
  if not grdDestinatari.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  NumColonna:=grdDestinatari.medpNumColonna(AColumn);
  Campo:=grdDestinatari.medpColonna(NumColonna).DataField;

  if ARow > 0 then
  begin
    if Campo = 'DATA_RICEZIONE' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end;
  end;
end;

procedure TW035FMessaggistica.OnSelezioneAnagrafica;
// procedura eseguita dopo aver confermato una selezione anagrafica
begin
  // 1. imposta struttura dati
  Msg.ClearDestinatari;
  if (Assigned(grdC700)) and (grdC700.selAnagrafe.Active) then
  begin
    Msg.SelezioneAnagrafica:=grdC700.WC700FM.C700NomeSelezioneCaricata;
    // carica clientdataset destinatari con la selezione
    with grdC700.selAnagrafe do
    begin
      First;
      while not Eof do
      begin
        Msg.AddDestinatario(FieldByName('PROGRESSIVO').AsInteger,
                            FieldByName('MATRICOLA').AsString,
                            FieldByName('COGNOME').AsString,
                            FieldByName('NOME').AsString,
                            DATE_NULL,
                            DATE_NULL);
        Next;
      end;
    end;
  end
  else
  begin
    Msg.SelezioneAnagrafica:='';
  end;
  Msg.DestModificati:=True;

  // 2. aggiorna interfaccia
  AggiornaDestinatari;
  edtSelezione.Text:=Msg.SelezioneAnagrafica;
  edtDestinatari.Text:=Trim(Msg.SelezioneAnagrafica + ' ' +
                            Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_DESTINATARI_SEL),
                                   [cdsDestinatari.RecordCount,cdsDestinatari.RecordCount]));
end;

// SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
procedure TW035FMessaggistica.imgScegliDestOperatoriClick(Sender: TObject);
var
  LstOpSel: TStringList;
  i: Integer;
begin
  WC013FM:=TWC013FCheckListFM.Create(Self);
  FreeNotification(WC013FM);

  LstOpSel:=TStringList.Create;
  try
    // carica stringlist di operatori selezionati
    for i:=0 to High(Msg.DestOperatoreArr) do
      LstOpSel.Add(Msg.DestOperatoreArr[i].Utente);

    // prepara e visualizza il frame di selezione destinatari
    with WC013FM do
    begin
      CaricaLista(LstOperatori,LstOperatori);
      ImpostaValoriSelezionati(LstOpSel);
      ResultEvent:=OnSelezioneOperatori;
      MinElem:=1;
      Visualizza(0,0,'Selezionare i destinatari');
    end;
  finally
    FreeAndNil(LstOpSel);
  end;
end;

procedure TW035FMessaggistica.OnSelezioneOperatori(Sender: TObject; Result:Boolean);
// procedura eseguita dopo aver confermato una selezione di operatori win
var
  LstDest: TStringList;
  i: Integer;
begin
  if Result then
  begin
    // 1. imposta struttura dati
    Msg.ClearDestinatariOperatori;

    LstDest:=WC013FM.LeggiValoriSelezionati;
    try
      for i:=0 to LstDest.Count - 1 do
      begin
        Msg.AddDestinatarioOperatore(LstDest[i],DATE_NULL,DATE_NULL);
      end;
      Msg.DestModificati:=True;

      // 2. aggiorna interfaccia
      AggiornaDestinatari;
      edtSelezione.Text:='';
      edtDestinatari.Text:=Format(A000TraduzioneStringhe(A000MSG_W035_MSG_FMT_DESTINATARI_SEL),
                                  [cdsDestinatari.RecordCount,cdsDestinatari.RecordCount]);
    finally
      FreeAndNil(LstDest);
    end;
  end;
end;
// SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

procedure TW035FMessaggistica.AggiornaDestinatari(const PSoloFiltro: Boolean = False);
// aggiornamento interfaccia relativa ai destinatari del messaggio
// parametri:
// - PSoloFiltro
//     True:  imposta solo il filtro del clientdataset
//     False: svuota e ricarica il clientdataset con i dati dell'array Msg.DestArr,
//            quindi imposta il filtro del clientdataset
var
  i: Integer;
  Filtro: String;
begin
  cdsDestinatari.Filtered:=False;

  // in base al parametro ricarica il clientdataset
  if not PSoloFiltro then
  begin
    cdsDestinatari.EmptyDataSet;

    // aggiunge destinatari web
    for i:=0 to High(Msg.DestArr) do
    begin
      cdsDestinatari.Append;
      cdsDestinatari.FieldByName('PROGRESSIVO').AsInteger:=Msg.DestArr[i].Progressivo;
      cdsDestinatari.FieldByName('MATRICOLA').AsString:=Msg.DestArr[i].Matricola;
      cdsDestinatari.FieldByName('COGNOME').AsString:=Msg.DestArr[i].Cognome;
      cdsDestinatari.FieldByName('NOME').AsString:=Msg.DestArr[i].Nome;
      if Msg.DestArr[i].DataLettura = DATE_NULL then
        cdsDestinatari.FieldByName('DATA_LETTURA').Value:=null
      else
        cdsDestinatari.FieldByName('DATA_LETTURA').AsDateTime:=Msg.DestArr[i].DataLettura;
      // EMPOLI_ASL11 - commessa 2013/040 - riesame del 10/05/2013.ini
      if Msg.DestArr[i].DataRicezione = DATE_NULL then
        cdsDestinatari.FieldByName('DATA_RICEZIONE').Value:=null
      else
        cdsDestinatari.FieldByName('DATA_RICEZIONE').AsDateTime:=Msg.DestArr[i].DataRicezione;
      // EMPOLI_ASL11 - commessa 2013/040 - riesame del 10/05/2013.fine
      cdsDestinatari.Post;
    end;
    // EMPOLI_ASL11 - commessa 2013/040 - riesame del 10/05/2013.ini
    //grdDestinatari.medpColonna('DATA_LETTURA').Visible:=Msg.Stato <> STATO_MSG_SOSPESO;
    grdDestinatari.medpColonna('DATA_RICEZIONE').Visible:=Msg.Stato <> STATO_MSG_SOSPESO;
    // EMPOLI_ASL11 - commessa 2013/040 - riesame del 10/05/2013.fine

    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    // aggiunge destinatari win (operatori)
    for i:=0 to High(Msg.DestOperatoreArr) do
    begin
      cdsDestinatari.Append;
      cdsDestinatari.FieldByName('UTENTE').AsString:=Msg.DestOperatoreArr[i].Utente;
      if Msg.DestOperatoreArr[i].DataLettura = DATE_NULL then
        cdsDestinatari.FieldByName('DATA_LETTURA').Value:=null
      else
        cdsDestinatari.FieldByName('DATA_LETTURA').AsDateTime:=Msg.DestOperatoreArr[i].DataLettura;
      if Msg.DestOperatoreArr[i].DataRicezione = DATE_NULL then
        cdsDestinatari.FieldByName('DATA_RICEZIONE').Value:=null
      else
        cdsDestinatari.FieldByName('DATA_RICEZIONE').AsDateTime:=Msg.DestOperatoreArr[i].DataRicezione;
      cdsDestinatari.Post;
    end;
    grdDestinatari.medpColonna('DATA_RICEZIONE').Visible:=Msg.Stato <> STATO_MSG_SOSPESO;
    // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
  end;

  // filtro dei destinatari sul clientdataset
  Filtro:='';
  if FModalita = mgInvio then
  begin
    // il filtro è significativo solo se il messaggio è già stato inviato (o cancellato dopo invio)
    rgpFiltroDest.Visible:=(grdMessaggi.medpStato <> msInsert) and (Msg.Stato <> STATO_MSG_SOSPESO);
    if rgpFiltroDest.Visible then
    begin
      case rgpFiltroDest.ItemIndex of
        0: Filtro:='';                           // tutti
        1: Filtro:='DATA_RICEZIONE is not null'; // ricevuto
        2: Filtro:='DATA_RICEZIONE is null';     // non ricevuto
      end;
    end;
  end;
  cdsDestinatari.Filter:=Filtro;
  cdsDestinatari.Filtered:=Filtro <> '';

  // aggiorna tabella destinatari
  grdDestinatari.medpCaricaCDS;
end;

//############################################//
//###           STORICO MESSAGGI           ###//
//############################################//

procedure TW035FMessaggistica.grdElencoRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  NumColonna, Liv: Integer;
  Campo, Prefisso, Stile: String;
  IsInviato: Boolean;
begin
  if not grdElenco.medpRenderCell(ACell,ARow,AColumn,True,False,True) then
    Exit;

  NumColonna:=grdElenco.medpNumColonna(AColumn);
  Campo:=grdElenco.medpColonna(NumColonna).DataField;

  if ARow > 0 then
  begin
    if Campo = 'OGGETTO' then
    begin
      ACell.RawText:=True;
      Liv:=grdElenco.medpClientDataSet.FieldByName('LEVEL').AsInteger;
      if Liv = 1 then
        Prefisso:=''
      else
      begin
        Prefisso:=Format('<span style="font-family: Courier New,Courier,mono;">%s%s%s%s</span>',[HTML_PIPE,HTML_DASH,HTML_DASH,'&nbsp;']);
      end;
      if Liv > 2 then
        Stile:=Format('style="padding-left: %dem"',[2 * (Liv - 2)]);
      ACell.Text:=Format('<span %s>%s%s</span>',[Stile,Prefisso,ACell.Text]);
    end
    else if Campo = 'DATA_INVIO' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if Campo = 'D_DESTINATARI' then
    begin
      // destinatari: tronca dopo un limite di caratteri prestabilito
      // visualizza comunque tutto l'elenco nell'hint
      ACell.ShowHint:=False;
      if Length(ACell.Text) > LIMITE_CARATTERI_DESTINATARI then
      begin
        ACell.Hint:=ACell.Text;
        ACell.ShowHint:=True;
        ACell.Text:=Format('%s...',[Copy(ACell.Text,1,LIMITE_CARATTERI_DESTINATARI)]);
      end;
    end;

    // id selezionato viene evidenziato in grassetto
    if grdElenco.medpClientDataSet.FieldByName('ID').AsInteger = selTabella.FieldByName('ID').AsInteger then
      ACell.Css:=ACell.Css + ' font_grassetto';

    // distingue messaggi ricevuti da inviati
    IsInviato:=grdElenco.medpClientDataSet.FieldByName('MITTENTE').AsString = Parametri.Operatore;
    ACell.Css:=ACell.Css + ' ' + IfThen(IsInviato,CSS_RIGA_INVIATO,CSS_RIGA_RICEVUTO);
  end;
end;

//############################################//
//###          GESTIONE ALLEGATI           ###//
//############################################//
{ DONE : TEST IW 15 }
procedure TW035FMessaggistica.btnHdnUploadClick(Sender: TObject);
var
  i,Suff: Integer;
  Att,AttName,AttExt,FilePath: String;
  Duplicato: Boolean;
begin
  if not IWFile.IsPresenteFileUploadato then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Selezionare un file da allegare al messaggio!');
    Exit;
  end;

  // determina il nome dell'allegato (per escludere duplicati)
  Att:=IWFile.NomeFile;
  AttExt:=ExtractFileExt(Att);
  AttName:=Copy(Att,1,Length(Att) - Length(AttExt));
  Suff:=2;
  Duplicato:=False;
  while Msg.EsisteAllegato(Att) do
  begin
    Duplicato:=True;
    Att:=Format('%s(%d)%s',[AttName,Suff,AttExt]);
    Suff:=Suff + 1;
  end;

  try
    // path e nome per il salvataggio su file system
    FilePath:=GGetWebApplicationThreadVar.UserCacheDir + Att{IWFile.FileName};

    // se esiste già un file con lo stesso nome lo cancella
    if FileExists(FilePath) then
      DeleteFile(FilePath);

    // effettua upload
    IWFile.SalvaSuFile(FilePath);

    // aggiorna interfaccia
    i:=Msg.AddAllegato(FLAG_ALLEG_NUOVO,Att);
    if grdAllegati.Visible then
    begin
      grdAllegati.RowCount:=grdAllegati.RowCount + 1;
    end
    else
    begin
      grdAllegati.Visible:=True;
      grdAllegati.RowCount:=1;
    end;
    grdAllegati.Cell[i,0].Control:=CreaAllegatoCheck(i); // check di selezione file
    grdAllegati.Cell[i,1].Text:='';
    grdAllegati.Cell[i,1].Control:=CreaAllegatoLink(i);  // link per salvataggio file

    // notifica allegato duplicato
    if Duplicato then
      GGetWebApplicationThreadVar.ShowMessage('Attenzione!' + CRLF +
                                 'Questo messaggio contiene già un allegato con lo stesso nome.' + CRLF +
                                 'Il nuovo file è stato rinominato in "' + Att + '".');
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(E.Message,ERRORE,'Errore upload');
    end;
  end;
end;

function TW035FMessaggistica.CreaAllegatoCheck(const PIndice: Integer): TmeIWCheckBox;
// crea e restituisce un checkbox per la selezione dell'allegato
begin
  if (PIndice < 0) or (PIndice > Length(Msg.AllegatiArr)) then
  begin
    Result:=nil;
    Exit;
  end;

  Result:=TmeIWCheckBox.Create(Self);
  with Result do
  begin
    Parent:=Self;
    Caption:='';
    Checked:=True;
    { DONE : TEST IW 15 }
    //DontSubmitFiles:=True;
    Hint:=Msg.AllegatiArr[PIndice].NomeFile;
    ShowHint:=False;
    Tag:=PIndice;
    OnAsyncClick:=chkAllegatoAsyncClick;
  end;
end;

function TW035FMessaggistica.CreaAllegatoLink(const PIndice: Integer): TmeIWLink;
// crea e restituisce un link per il salvataggio dell'allegato
begin
  if (PIndice < 0) or (PIndice > Length(Msg.AllegatiArr)) then
  begin
    Result:=nil;
    Exit;
  end;

  Result:=TmeIWLink.Create(Self);
  with Result do
  begin
    Parent:=Self;
    Text:=Format('%s (%s)',[Msg.AllegatiArr[PIndice].NomeFile,Msg.AllegatiArr[PIndice].DimFileStr]);
    Css:=Format('link file_%s',[Msg.AllegatiArr[PIndice].ExtFile]);
    { DONE : TEST IW 15 }
    //DontSubmitFiles:=True;
    Hint:=Msg.AllegatiArr[PIndice].NomeFile;
    medpDownloadButton:=True;
    if Msg.AllegatiArr[PIndice].Flag = FLAG_ALLEG_SALVATO then
      OnClick:=lnkAllegatoClick
    else
      OnClick:=nil;
  end;
end;

procedure TW035FMessaggistica.chkAllegatoAsyncClick(Sender: TObject; EventParams: TStringList);
// gestione click su checkbox di selezione allegato
var
  Indice: Integer;
begin
  // PRE: Tag è l'indice dell'elemento nell'array Msg.AllegatiArr
  Indice:=(Sender as TmeIWCheckBox).Tag;

  if (Sender as TmeIWCheckBox).Checked then
  begin
    // allegato selezionato
    Msg.AllegatiArr[Indice].Flag:=IfThen(Msg.AllegatiArr[Indice].Flag = FLAG_ALLEG_CANC_NUOVO,FLAG_ALLEG_NUOVO,FLAG_ALLEG_SALVATO);
  end
  else
  begin
    // allegato deselezionato
    Msg.AllegatiArr[Indice].Flag:=IfThen(Msg.AllegatiArr[Indice].Flag = FLAG_ALLEG_NUOVO,FLAG_ALLEG_CANC_NUOVO,FLAG_ALLEG_CANC_SALVATO);
  end;
end;

procedure TW035FMessaggistica.chkStatoAsyncClick(Sender: TObject; EventParams: TStringList);
// abilitazione filtro periodo invio
begin
  if not (chkStatoSospeso.Checked or chkStatoInviato.Checked or chkStatoCancellato.Checked) then
    (Sender as TmeIWCheckBox).Checked:=True;

  // selezione checkbox "Tutti"
  chkStatoTutti.Checked:=chkStatoSospeso.Checked and
                         chkStatoInviato.Checked and
                         chkStatoCancellato.Checked;

  // gestione check stato inviato
  edtPeriodoDal.Enabled:=chkStatoInviato.Checked;
  edtPeriodoAl.Enabled:=chkStatoInviato.Checked;
  if not edtPeriodoDal.Enabled then
    edtPeriodoDal.Clear;
  if not edtPeriodoAl.Enabled then
    edtPeriodoAl.Clear;
end;

procedure TW035FMessaggistica.chkStatoTuttiAsyncClick(Sender: TObject; EventParams: TStringList);
// filtro stato: tutti
begin
  if chkStatoTutti.Checked then
  begin
    // seleziona tutti gli stati
    chkStatoSospeso.Checked:=True;
    chkStatoInviato.Checked:=True;
    chkStatoCancellato.Checked:=True;
  end
  else
  begin
    // se tutti gli altri checkbox sono selezionati, mantiene selezionato "Tutti"
    if (chkStatoSospeso.Checked) and (chkStatoInviato.Checked) and (chkStatoCancellato.Checked) then
      chkStatoTutti.Checked:=True;
  end;
end;

procedure TW035FMessaggistica.lnkAllegatoClick(Sender: TObject);
var
  NomeFile, FilePath: String;
  Blob: TLOBLocator;
begin
  // estrae il nome del file
  NomeFile:=(Sender as TmeIWLink).Hint;

  try
    W035DM.selT283Allegato.SetVariable('ID',selTabella.FieldByName('ID').AsInteger);
    W035DM.selT283Allegato.SetVariable('NOME',NomeFile);
    W035DM.selT283Allegato.Execute;
    Blob:=W035DM.selT283Allegato.LOBField('ALLEGATO');
    if Blob.IsNull then
    begin
      MsgBox.MessageBox(Format('Il file "%s" non è presente nel database',[NomeFile]),ESCLAMA);
      Exit;
    end;
    begin
      // salva il blob in un file nella user cache
      // se un file con lo stesso nome esiste già, lo elimina
      { DONE : TEST IW 15 }
      FilePath:=GGetWebApplicationThreadVar.UserCacheDir + NomeFile;
      if FileExists(FilePath) then
        DeleteFile(FilePath);
      Blob.SaveToFile(FilePath);

      // invia il file al browser
      GGetWebApplicationThreadVar.SendFile(FilePath,True,'application/x-download',NomeFile);
    end;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox('Errore durante il download del file: ' + E.Message,ESCLAMA);
      Exit;
    end;
  end;
end;

procedure TW035FMessaggistica.mnuEsportaCsvClick(Sender: TObject);
// esportazione csv dei messaggi
var
  Nome: String;
begin
  Nome:=IfThen(Modalita = mgLettura,'Messaggi_ricevuti','Messaggi_inviati');
  Nome:=Format('%s.xls',[Nome]);
  InviaFile(Nome,grdMessaggi.ToCsv);
end;

procedure TW035FMessaggistica.mnuDestCsvClick(Sender: TObject);
// esportazione csv dei destinatari
begin
  InviaFile('Destinatari.xls',grdDestinatari.ToCsv);
end;

procedure TW035FMessaggistica.DistruggiOggetti;
// procedura distruzione oggetti creati a runtime
begin
  if Assigned(grdC700) then
    FreeAndNil(grdC700);
  FreeAndNil(Msg);
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  FreeAndNil(LstOperatori);
  if Assigned(WC013FM) then
  begin
    try
      FreeAndNil(WC013FM);
    except
    end;
  end;
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine
  FreeAndNil(W035DM);
end;

//############################################//
//###             TMessaggio               ###//
//############################################//

constructor TMessaggio.Create;
begin
  inherited;
  Clear;
end;

destructor TMessaggio.Destroy;
begin
  Clear;
  inherited;
end;

procedure TMessaggio.Clear;
// pulisce le proprietà del messaggio
begin
  FID:=0;
  FErrMsg:='';
  FOggetto:='';
  FTesto:='';
  FLetturaObbligatoria:='N'; // MONDOEDP - commessa MAN/07 SVILUPPO#57
  FModificato:=False;
  FIDOriginale:=0;
  FStato:=STATO_MSG_SOSPESO;
  FEditAsNew:=False;
  FDataInvio:=DATE_NULL;
  FSelezioneAnagrafica:='';
  FDestLetti:=0;
  FDestRicevuti:=0;
  FDestTot:=0;
  FDestModificati:=False;
  SetLength(FDestArr,0);
  SetLength(FDestOperatoreArr,0); // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1
  FAllegModificati:=False;
  SetLength(FAllegatiArr,0);
  SetLength(FAllegatiCopyArr,0);
end;

function TMessaggio.GetStatoLettura: TStatoLettura;
// estrae lo stato di lettura del messaggio in base al numero di destinatari
// totali e al numero di destinatari che hanno letto il messaggio
var
  i, NumLetti, TotDest: Integer;
begin
  // numero totale di destinatari
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  //TotDest:=Length(FDestArr);
  TotDest:=Length(FDestArr) + Length(FDestOperatoreArr);
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  // conta il numero di destinatari che hanno letto il messaggio
  // destinatari web + win
  NumLetti:=0;
  for i:=0 to High(FDestArr) do
  begin
    if FDestArr[i].DataLettura <> DATE_NULL then
      NumLetti:=NumLetti + 1;
  end;
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  for i:=0 to High(FDestOperatoreArr) do
  begin
    if FDestOperatoreArr[i].DataLettura <> DATE_NULL then
      NumLetti:=NumLetti + 1;
  end;
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  // determina lo stato di lettura del messaggio
  if NumLetti = 0 then
    Result:=slNonLetto
  else if NumLetti = TotDest then
    Result:=slLetto
  else
    Result:=slLettoParzialmente;
end;

function TMessaggio.GetStatoRicezione: TStatoRicezione;
var
  i, NumRicevuti, TotDest: Integer;
begin
  // numero totale di destinatari
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  //TotDest:=Length(FDestArr);
  TotDest:=Length(FDestArr) + Length(FDestOperatoreArr);
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  // conta il numero di destinatari che hanno ricevuto il messaggio
  NumRicevuti:=0;
  for i:=0 to High(FDestArr) do
  begin
    if FDestArr[i].DataRicezione <> DATE_NULL then
      NumRicevuti:=NumRicevuti + 1;
  end;
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  for i:=0 to High(FDestOperatoreArr) do
  begin
    if FDestOperatoreArr[i].DataRicezione <> DATE_NULL then
      NumRicevuti:=NumRicevuti + 1;
  end;
  // SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  // determina lo stato di ricezione del messaggio
  if NumRicevuti = 0 then
    Result:=srNonRicevuto
  else if NumRicevuti = TotDest then
    Result:=srRicevuto
  else
    Result:=srRicevutoParzialmente;
end;

procedure TMessaggio.SetLetturaObbligatoria(const Value: String);
begin
  if (Value <> 'S') and (Value <> 'N') then
    raise Exception.Create(Format('Valore di LETTURA_OBBLIGATORIA non valido: %s. Specificare S oppure N',[Value]));

  FLetturaObbligatoria:=Value;
end;

procedure TMessaggio.SetOggetto(const Value: String);
begin
  FModificato:=FModificato or (FOggetto <> Value);
  FOggetto:=Value;
end;

procedure TMessaggio.SetTesto(const Value: String);
begin
  FModificato:=FModificato or (FTesto <> Value);
  FTesto:=Value;
end;

procedure TMessaggio.ClearDestinatari;
begin
  SetLength(FDestArr,0);
end;

// SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
procedure TMessaggio.ClearDestinatariOperatori;
begin
  SetLength(FDestOperatoreArr,0);
end;
// SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

function TMessaggio.AddDestinatario(const PProg: Integer; const PMatricola, PCognome, PNome: String; const PDataLettura, PDataRicezione: TDateTime): Integer;
// aggiunge un nuovo destinatario web all'array
var
  x: Integer;
begin
  x:=Length(FDestArr);
  SetLength(FDestArr,x + 1);
  FDestArr[x].Progressivo:=PProg;
  FDestArr[x].Matricola:=PMatricola;
  FDestArr[x].Cognome:=PCognome;
  FDestArr[x].Nome:=PNome;
  FDestArr[x].DataLettura:=PDataLettura;
  FDestArr[x].DataRicezione:=PDataRicezione;

  Result:=x;
end;

// SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
function TMessaggio.AddDestinatarioOperatore(const PUtente: String; const PDataLettura, PDataRicezione: TDateTime): Integer;
// aggiunge un nuovo destinatario (operatore win) all'array
var
  x: Integer;
begin
  x:=Length(FDestOperatoreArr);
  SetLength(FDestOperatoreArr,x + 1);
  FDestOperatoreArr[x].Utente:=PUtente;
  FDestOperatoreArr[x].DataLettura:=PDataLettura;
  FDestOperatoreArr[x].DataRicezione:=PDataRicezione;

  Result:=x;
end;
// SGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

function TMessaggio.AddAllegato(const PFlag, PNomeFile: String; const PDimFile: Int64 = 0): Integer;
// aggiunge l'allegato al messaggio dopo l'upload
var
  x: Integer;
  DimFile: Int64;
begin
  // aggiunge elemento all'array
  x:=Length(FAllegatiArr);
  SetLength(FAllegatiArr,x + 1);

  // imposta dati dell'allegato
  FAllegatiArr[x].Flag:=PFlag;
  FAllegatiArr[x].NomeFile:=PNomeFile;
  FAllegatiArr[x].ExtFile:=StringReplace(ExtractFileExt(PNomeFile),'.','',[]);
  if PDimFile = 0 then { DONE : TEST IW 15 }
    //DimFile:=R180GetFileSize(gSC.UserCacheDir + PNomeFile)
    DimFile:=R180GetFileSize(GGetWebApplicationThreadVar.UserCacheDir + PNomeFile)
  else
    DimFile:=PDimFile;
  FAllegatiArr[x].DimFile:=DimFile;
  FAllegatiArr[x].DimFileStr:=R180GetFileSizeStr(DimFile);

  // restituisce indice
  Result:=x;
end;

procedure TMessaggio.ClearAllegati;
begin
  SetLength(FAllegatiArr,0);
  SetLength(FAllegatiCopyArr,0);
end;

function TMessaggio.EsisteAllegato(const PNomeFile: String): Boolean;
// restituisce True se il nome file è già presente nell'array degl allegati
// oppure False altrimenti
var
  i: Integer;
begin
  Result:=False;
  for i:=0 to High(FAllegatiArr) do
  begin
    if PNomeFile = FAllegatiArr[i].NomeFile then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

end.
