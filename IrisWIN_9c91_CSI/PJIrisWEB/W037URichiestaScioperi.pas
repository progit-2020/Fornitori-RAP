unit W037URichiestaScioperi;

interface

uses
  W037URichiestaScioperiDM, W005UCartellinoFM,
  R013UIterBase, A000UInterfaccia, A000UCostanti, W000UMessaggi,
  C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb, Math, StrUtils,
  Winapi.Windows, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompGrids, IWDBGrids,
  medpIWDBGrid, IWCompLabel, meIWLabel, IWCompExtCtrls, meIWImageFile,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, OracleData, DataSnap.DBClient,
  IWApplication, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWRegion, IWCompEdit, meIWEdit,
  medpIWMultiColumnComboBox, Oracle, Data.DB, meIWGrid, meIWCheckBox, meIWImage;

type
  TRichiesta = record
    Id: Integer;               // T250 - id richiesta ufficiale T850
    IdT250: Integer;           // T250 - id evento sciopero
    Data: TDateTime;           // T250 - data evento sciopero
    Progressivo: Integer;      // T251 - progressivo richiedente
    Minimo: Integer;           // T251 - numero minimo dip.
    NumDipInServizio: Integer; // calcolato - numero dip. in servizio alla data dell'evento
  end;

  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
  end;

  TEventoSciopero = record
    Id: Integer;
    Data: TDateTime;
    SelezioneAnagrafica: String;
  end;

  TW037FRichiestaScioperi = class(TR013FIterBase)
    rgnDettaglio: TmeIWRegion;
    tpDettaglio: TIWTemplateProcessorHTML;
    grdDipendenti: TmedpIWDBGrid;
    edtNumDipInServizio: TmeIWEdit;
    lblNumDipInServizio: TmeIWLabel;
    lblNumDipScioperanti: TmeIWLabel;
    edtNumDipScioperanti: TmeIWEdit;
    lblNumDipAssenti: TmeIWLabel;
    edtNumDipAssenti: TmeIWEdit;
    pmnDipendenti: TPopupMenu;
    MenuItem1: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure cmbEventoChange(Sender: TObject; Index: Integer);
    procedure grdDipendentiRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure IWAppFormRender(Sender: TObject);
    procedure grdDipendentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure mnuEsportaCsvClick(Sender: TObject);
  private
    Al: TDateTime;
    Richiesta: TRichiesta;
    Autorizza: TAutorizza;
    procedure grdRichiesteColumnClick(ASender: TObject; const AValue: String);
    procedure imgIterClick(Sender: TObject);
    procedure imgDettaglioGGClick(Sender: TObject);
    procedure imgInserisciClick(Sender: TObject);
    procedure imgModificaClick(Sender: TObject);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgChiudiRichiestaClick(Sender: TObject);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure GeneraDettaglioRichiesta;
    function  CtrlRichiesta(const FN: String): Boolean;
    procedure AnnullaInsRichiesta;
    procedure ConfermaInsRichiesta;
    procedure actInsRichiesta;
    procedure actModRichiesta(const FN: String);
    procedure actCancRichiesta(const FN: String);
    procedure actChiudiRichiesta(const FN: String);
    procedure TrasformaComponenti(const FN: String);
    procedure AutorizzazioneOK;
    function  CtrlDipendentiOK: Boolean;
    procedure TrasformaComponentiDip(const FN: String; DaTestoAControlli: Boolean);
    procedure SalvaDettaglioRichiesta;
    function  ContaDipInServizio: Integer;
    function  EsisteIntersezioneSelezioni(PEvento: TEventoSciopero; var RNumDipComuni: Integer): Boolean;
    procedure PopolaComboEventi(PCmb: TMedpIWMultiColumnComboBox);
    procedure chkScioperoAsyncClick(Sender: TObject; EventParams: TStringList);
  protected
    function  GetInfoFunzione: String; override;
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure RefreshPage; override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure DistruggiOggetti; override;
  public
    W037DM: TW037FRichiestaScioperiDM;
    function InizializzaAccesso: Boolean; override;
    procedure OnTabChanging(var AllowChange: Boolean; var Conferma: String); override;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
  end;

const
  // indice colonna per combobox di scelta eventi di sciopero
  W037_CMBEVENTO_COL_DATA   = 0; // colonna per data evento sciopero
  W037_CMBEVENTO_COL_ID     = 1; // colonna per ID evento sciopero

  // valori di TIPO_RICHIESTA
  W037_TR_P: String         = 'P'; // notifica provvisoria (bozza)
  W037_TR_D: String         = 'D'; // notifica definitiva (richiesta effettuata)
  W037_TR_E: String         = 'E'; // richiesta elaborata

  // valori di STATO
  W037_STATO_R: String      = 'R'; // richiesta da autorizzare
  W037_STATO_A: String      = 'A'; // richiesta autorizzata o giustificativo effettivo

implementation

{$R *.dfm}

function TW037FRichiestaScioperi.InizializzaAccesso: Boolean;
begin
  // controllo accesso funzione
  if not WR000DM.Responsabile and Parametri.InibizioneIndividuale then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_W037_ERR_FMT_ACCESSO),[medpNomeFunzione]));

  // imposta parametri
  Al:=ParametriForm.Al;

  // forza il filtro in servizio sulla selezione anagrafica principale,
  // indipendentemente dall'impostazione del flag "Visualizza cessati" in W002FAnagrafeElenco
  if VarToStr(WR000DM.selAnagrafe.GetVariable('FILTRO_IN_SERVIZIO')) = '' then
  begin
    selAnagrafeW.SetVariable('FILTRO_IN_SERVIZIO',IfThen(SelezionePeriodica,FILTRO_IN_SERVIZIO_PERIODICA,FILTRO_IN_SERVIZIO));
  end;

  if WR000DM.Responsabile then
  begin
    // l'elenco dei dipendenti disponibili serve solo lato autorizzatore
    GetDipendentiDisponibili(Al);
    selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;
  end
  else
  begin
    // nel caso di richiedente la scelta dei dipendenti è inibita (nascosta)
    cmbDipendentiDisponibili.Visible:=False;
    lnkDipendente.Visible:=False;
  end;

  // per il responsabile esclude sempre le richieste con TIPO_RICHIESTA = 'P' = notifica provvisoria
  if WR000DM.Responsabile then
  begin
    W037DM.selT251.Filter:=Format('TIPO_RICHIESTA <> ''%s''',[W037_TR_P]);
  end;

  // visualizza i dati del dipendente (richiedente) selezionato
  VisualizzaDipendenteCorrente;

  Result:=True;
end;

procedure TW037FRichiestaScioperi.IWAppFormCreate(Sender: TObject);
begin
  Tag:=IfThen(WR000DM.Responsabile,429,428);
  inherited;

  // apre dataset condiviso delle assenze per lookup
  WR000DM.selT265.Close;
  WR000DM.selT265.Filtered:=False;
  WR000DM.selT265.Open;

  // crea il datamodule di supporto
  W037DM:=TW037FRichiestaScioperiDM.Create(Self);

  // predispone l'iter degli scioperi
  Iter:=ITER_SCIOPERI;
  if WR000DM.Responsabile then
  begin
    Self.HelpKeyWord:='W037P1';
    C018.PreparaDataSetIter(W037DM.selT251,tiAutorizzazione);
  end
  else
  begin
    Self.HelpKeyWord:='W037P0';
    C018.PreparaDataSetIter(W037DM.selT251,tiRichiesta);
  end;
  C018.Periodo.SetVuoto;

  // region di dettaglio
  // a) dettaglio evento di sciopero
  //
  // b) tabella dei dipendenti (no paginazione)
  // apertura dataset dell'elenco dipendenti con dati fittizi
  with W037DM.selT252 do
  begin
    Close;
    SetVariable('ID',0);
    SetVariable('PROGRESSIVO',0);
    Open;
  end;
  grdDipendenti.medpTestoNoRecord:=A000TraduzioneStringhe(A000MSG_W037_MSG_NO_DIPENDENTI);
  grdDipendenti.medpAttivaGrid(W037DM.selT252,True,False,False);
  grdDipendenti.medpPreparaComponenteGenerico('R',grdDipendenti.medpIndexColonna('TIMBRATURE'),0,DBG_IMG,'','DETTAGLIO','','','');

  with WR000DM do
  begin
    selT265.Tag:=selT265.Tag + 1;
  end;
end;

procedure TW037FRichiestaScioperi.IWAppFormRender(Sender: TObject);
begin
  inherited;
  // se la tabella non è in browse blocca la gestione dei filtri
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;
end;

procedure TW037FRichiestaScioperi.mnuEsportaCsvClick(Sender: TObject);
begin
  InviaFile('ElencoDipendenti.xls',grdDipendenti.ToCsv);
end;

procedure TW037FRichiestaScioperi.RefreshPage;
// rimuove il filtro dizionario dal dataset selT265 condiviso
begin
  WR000DM.Responsabile:=Tag = 429;
  WR000DM.selT265.Filtered:=False;
  VisualizzaDipendenteCorrente;
end;

procedure TW037FRichiestaScioperi.OnTabChanging(var AllowChange: Boolean;
  var Conferma: String);
begin
  AllowChange:=grdRichieste.medpStato = msBrowse;
end;

procedure TW037FRichiestaScioperi.OnTabClosing(var AllowClose: Boolean;
  var Conferma: String);
begin
  if grdRichieste.medpStato <> msBrowse then
  begin
    case grdRichieste.medpStato of
      msInsert:
        Conferma:=A000TraduzioneStringhe(A000MSG_R013_MSG_RICHIESTA_SALVA_INS);
      msEdit:
        Conferma:=A000TraduzioneStringhe(A000MSG_R013_MSG_RICHIESTA_SALVA_MOD);
    end;
    Conferma:=Conferma + CRLF + A000TraduzioneStringhe(A000MSG_R013_MSG_USCIRE_COMUNQUE);
  end;
end;

function TW037FRichiestaScioperi.GetInfoFunzione: String;
begin
  if WR000DM.Responsabile then
    Result:=inherited
  else
    Result:='matricola: ' + Parametri.MatricolaOper;
end;

procedure TW037FRichiestaScioperi.GetDipendentiDisponibili(Data: TDateTime);
begin
  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;
end;

procedure TW037FRichiestaScioperi.VisualizzaDipendenteCorrente;
var
  FiltroAnag: String;
begin
  inherited;
  Log('Traccia','VisualizzaDipendenteCorrente - inizio');

  if WR000DM.Responsabile then
  begin
    FiltroAnag:=IfThen(TuttiDipSelezionato,
                       WR000DM.FiltroRicerca,
                       'and T030.PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
  end
  else
  begin
    // richiedente: sole richieste effettuate dall'operatore
    FiltroAnag:='and T030.PROGRESSIVO = ' + Parametri.ProgressivoOper.ToString;
  end;

  with W037DM.selT251 do
  begin
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG',FiltroAnag);
    SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    R013Open(W037DM.selT251);
  end;
  Log('Traccia','VisualizzaDipendenteCorrente: dataset aperto');

  // tabella delle richieste
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdRichieste.medpAttivaGrid(W037DM.selT251,False,False,False);

  grdRichieste.medpEliminaColonne;
  if WR000DM.Responsabile then
  begin
    // elenco colonne
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizz.','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiColonna('ID','ID','',nil);
    grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
    if (C018.EsisteAutorizzIntermedia) or
       (C018.Revocabile) then
      grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','STATO','',nil);
    grdRichieste.medpAggiungiColonna('DATA','Data sciopero','',nil);
    grdRichieste.medpAggiungiColonna('CAUSALE','Causale','',nil);
    grdRichieste.medpAggiungiColonna('D_CAUSALE','Causale','',nil);
    grdRichieste.medpAggiungiColonna('TIPOGIUST','Tipo giust.','',nil);
    grdRichieste.medpAggiungiColonna('DAORE','Dalle','',nil);
    grdRichieste.medpAggiungiColonna('AORE','Alle','',nil);
    grdRichieste.medpAggiungiColonna('MINIMO','Contingente minimo','',nil);
    grdRichieste.medpAggiungiColonna('SELEZIONE_ANAGRAFICA','Selezione anagrafica','',nil);

    // visibilità colonne
    grdRichieste.medpColonna('ID').Visible:=False;
    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('CAUSALE').Visible:=False;
  end
  else
  begin
    // elenco colonne
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('ID','ID','',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
    grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Stato','',nil);
    grdRichieste.medpAggiungiColonna('DATA','Data sciopero','',nil);
    grdRichieste.medpAggiungiColonna('CAUSALE','Causale','',nil);
    grdRichieste.medpAggiungiColonna('D_CAUSALE','Desc. causale','',nil);
    grdRichieste.medpAggiungiColonna('TIPOGIUST','Tipo giust.','',nil);
    grdRichieste.medpAggiungiColonna('DAORE','Dalle','',nil);
    grdRichieste.medpAggiungiColonna('AORE','Alle','',nil);
    grdRichieste.medpAggiungiColonna('MINIMO','Contingente minimo','',nil);
    grdRichieste.medpAggiungiColonna('SELEZIONE_ANAGRAFICA','Selezione anagrafica','',nil);
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Aut.','',nil);
    grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
  end;
  // visibilità colonne
  grdRichieste.medpColonna('ID').Visible:=False;
  grdRichieste.medpColonna('CAUSALE').Visible:=False;
  grdRichieste.medpColonna('D_CAUSALE').Visible:=False;
  grdRichieste.medpColonna('TIPOGIUST').Visible:=False;
  grdRichieste.medpColonna('DAORE').Visible:=False;
  grdRichieste.medpColonna('AORE').Visible:=False;
  // operazioni conclusive sulla tabella
  grdRichieste.medpAggiungiRowClick('DBG_ROWID',grdRichiesteColumnClick);
  grdRichieste.medpInizializzaCompGriglia;

  if WR000DM.Responsabile then
  begin
    // autorizzazione
    if not SolaLettura then
    begin
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_CHK,'','Si','','');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_CHK,'','No','','');
    end;
  end
  else
  begin
    // richiesta
    if not SolaLettura then
    begin
      // riga inserimento
      grdRichieste.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','Inserisce una nuova richiesta','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','Annulla l''inserimento della richiesta','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','Conferma l''inserimento della nuova richiesta','','D');

      // righe dettaglio
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la richiesta',A000TraduzioneStringhe(A000MSG_W037_MSG_CONFERMA_CANC),'S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','Modifica la richiesta','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','Annulla la modifica della richiesta','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','Conferma la modifica della richiesta','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,4,DBG_IMG,'','DEFINISCI','Chiude la richiesta','Chiudere l''iter della richiesta selezionata?'#13#10'Attenzione! Questa procedura è irreversibile.','D');
    end;
    grdRichieste.medpColonna('DBG_COMANDI').Visible:=Length(grdRichieste.medpDescCompGriglia.Riga[0]) > 0;
  end;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
  grdRichieste.medpCaricaCDS;

  // reset valori
  Al:=Parametri.DataLavoro;
  ParametriForm.Al:=Parametri.DataLavoro;

  Log('Traccia','VisualizzaDipendenteCorrente - fine');
end;

procedure TW037FRichiestaScioperi.chkAutorizzazioneClick(Sender: TObject);
begin
  Autorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  Autorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  Autorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  // verifica presenza record
  with W037DM.selT251 do
  begin
    Refresh;
    if not SearchRecord('ROWID',Autorizza.RowId,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICHIESTA_ND_AUT),INFORMA);
      Exit;
    end;
  end;
  grdRichiesteColumnClick(Sender,Autorizza.Rowid);
  AutorizzazioneOK;
end;

procedure TW037FRichiestaScioperi.AutorizzazioneOK;
// imposta lo stato di autorizzazione indicato
var
  Aut,Resp: String;
begin
  Aut:='';
  Resp:='';

  // autorizzazione richiesta
  with W037DM.selT251 do
  begin
    // imposta i dati di autorizzazione
    Refresh; //sostituire con Refreshrecord??
    if not SearchRecord('ROWID',Autorizza.Rowid,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICHIESTA_MODIFICATA_AUT),INFORMA);
      Exit;
    end;
    Resp:=Parametri.Operatore;
    if Autorizza.Checked and (Autorizza.Caption = 'Si') then
      // autorizzazione SI
      Aut:=C018SI
    else if Autorizza.Checked and (Autorizza.Caption = 'No') then
      // autorizzazione NO
      Aut:=C018NO
    else if not Autorizza.Checked then
      // autorizzazione non impostata
      Aut:='';
    // salva i dati di autorizzazione
    try
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Resp,'','');
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione);
      SessioneOracle.Commit;
    except
      on E: Exception do
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_R013_ERR_FMT_AUT_FALLITA),[E.Message,E.ClassName]),ESCLAMA);
    end;
    VisualizzaDipendenteCorrente;
  end;
end;

function TW037FRichiestaScioperi.EsisteIntersezioneSelezioni(PEvento: TEventoSciopero; var RNumDipComuni: Integer): Boolean;
// restituisce True se esiste almeno un dipendente in comune fra la selezione anagrafica
// indicata nell'evento di sciopero e quella del responsabile di struttura attualmente loggato
// parametri:
// - RNumDipComuni: se l'evento ha una selezione anagrafica viene valorizzato
//                  con il numero di dipendenti in comune fra le due selezioni
//                  altrimenti vale -1
var
  FiltroAnag: String;
begin
  // se l'evento non è definito per una selezione anagrafica specifica restituisce True
  // e imposta RNumDipComuni = -1
  Result:=PEvento.SelezioneAnagrafica = '';
  RNumDipComuni:=-1;

  if PEvento.SelezioneAnagrafica <> '' then
  begin
    // estrae i dipendenti del responsabile di struttura in servizio alla data dell'evento
    GetDipendentiDisponibili(PEvento.Data);

    // valuta la selezione anagrafica associata all'evento per estrarre i progressivi
    // che possono partecipare allo sciopero
    // IMPORTANTE: esclude il personale esterno!
    FiltroAnag:='AND T030.TIPO_PERSONALE = ''I'' AND ' + PEvento.SelezioneAnagrafica;
    with WR000DM.selAnagEventoSciopero do
    begin
      Close;
      SetVariable('DATALAVORO',PEvento.Data);
      SetVariable('FILTRO',FiltroAnag);
      SetVariable('FILTRO_IN_SERVIZIO',FILTRO_IN_SERVIZIO);
      Open;
    end;

    // valuta se esiste almeno un dipendente in comune nelle due selezioni anagrafiche
    RNumDipComuni:=0;
    selAnagrafeW.First;
    while not selAnagrafeW.Eof do
    begin
      if WR000DM.selAnagEventoSciopero.SearchRecord('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
      begin
        Result:=True;
        inc(RNumDipComuni);
      end;
      selAnagrafeW.Next;
    end;
  end;
end;

procedure TW037FRichiestaScioperi.PopolaComboEventi(PCmb: TMedpIWMultiColumnComboBox);
// determina carica l'elenco degli eventi selezionabili nella combobox di selezione
var
  Elemento: String;
  LEvento: TEventoSciopero;
  Aggiungi: Boolean;
  LTemp: Integer;
begin
  PCmb.Items.Clear;

  with W037DM.selT250 do
  begin
    Close;
    SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
    Open;
    while not Eof do
    begin
      // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3 - riesame del 29.04.2014.ini
      // vengono inseriti i soli eventi per cui la selezione anagrafica è coerente
      // con quella del responsabile (cioè vuota oppure con almeno un dipendente in comune)

      // salva i dati dell'evento di sciopero in una variabile di supporto
      LEvento.Id:=FieldByName('ID').AsInteger;
      LEvento.Data:=FieldByName('DATA').AsDateTime;
      LEvento.SelezioneAnagrafica:=FieldByName('SELEZIONE_ANAGRAFICA').AsString;

      // aggiunge l'evento alla lista solo se la selezione anagrafica per l'evento di sciopero
      // selezionato è vuota oppure interseca la selezione del responsabile di struttura
      // nota: entrambe le selezioni vengono effettuate alla data dell'evento
      Aggiungi:=(LEvento.SelezioneAnagrafica = '') or
                 EsisteIntersezioneSelezioni(LEvento,LTemp);

      // valuta se è necessario aggiungere l'evento
      if Aggiungi then
      begin
        Elemento:=Format('%s;%s',[FormatDateTime('dd/mm/yyyy',FieldByName('DATA').AsDateTime),FieldByName('ID').AsString]);
        PCmb.AddRow(Elemento);
      end;
      // EMPOLI_ASL11 - ccmmessa 2013/040 SVILUPPO#3 - riesame del 29.04.2014.fine
      Next;
    end;
  end;
end;

procedure TW037FRichiestaScioperi.cmbEventoChange(Sender: TObject;
  Index: Integer);
// l'evento change si scatena solo in fase di inserimento di una nuova richiesta
// in quanto il componente è abilitato solo in questa fase
var
  LEvento: TEventoSciopero;
  IWCmb: TMedpIWMultiColumnComboBox;
  NumDip: Integer;
begin
  if grdRichieste.medpStato <> msInsert then
    Exit;

  IWCmb:=(Sender as TMedpIWMultiColumnComboBox);
  if IWCmb.ItemIndex > -1 then
  begin
    with W037DM.selT250 do
    begin
      if not SearchRecord('ID',IWCmb.Items[IWCmb.ItemIndex].RowData[W037_CMBEVENTO_COL_ID],[srFromBeginning]) then
        Exit;

      // salva i dati dell'evento di sciopero in una variabile di supporto
      LEvento.Id:=FieldByName('ID').AsInteger;
      LEvento.Data:=FieldByName('DATA').AsDateTime;
      LEvento.SelezioneAnagrafica:=FieldByName('SELEZIONE_ANAGRAFICA').AsString;
    end;

    // se la selezione anagrafica dell'evento è vuota i dipendenti disponibili
    // sono tutti quelli in servizio alla data dell'evento
    if LEvento.SelezioneAnagrafica = '' then
    begin
      // estrae i dipendenti in servizio alla data evento
      GetDipendentiDisponibili(LEvento.Data);
      NumDip:=selAnagrafeW.RecordCount;
    end
    else
    begin
      // determina i dipendenti in comune fra le due selezioni
      EsisteIntersezioneSelezioni(LEvento,NumDip);
    end;

    // visualizza dipendenti
    edtNumDipInServizio.Text:=NumDip.ToString;
    edtNumDipScioperanti.Text:='';
    edtNumDipAssenti.Text:='';
  end;
end;

procedure TW037FRichiestaScioperi.grdRichiesteColumnClick(ASender: TObject; const AValue: String);
var
  Id, IdRiga, Prog,
  ContaAssenti, ContaScioperanti: Integer;
begin
  rgnDettaglio.Visible:=False;

  // prova la locate prima con rowid, quindi con id richiesta
  if not grdRichieste.medpClientDataSet.Locate('DBG_ROWID',AValue,[]) then
  begin
    if TryStrToInt(AValue,IdRiga) then
    begin
      if not grdRichieste.medpClientDataSet.Locate('ID',IdRiga,[]) then
        Exit;
    end
    else
      Exit;
  end;

  rgnDettaglio.Visible:=True;

  // estrae nominativo dipendente se <Tutti i dipendenti>
  if TuttiDipSelezionato then
  begin
    selAnagrafeW.SearchRecord('MATRICOLA',grdRichieste.medpClientDataSet.FieldByName('MATRICOLA').AsString,[srFromBeginning]);
    lnkDipendente.Caption:=FormattaInfoDipendenteCorrente;
  end;

  Id:=-1;
  Prog:=0;
  if grdRichieste.medpStato <> msInsert then
  begin
    // posizionamento su dataset legato alla tabella
    if W037DM.selT251.SearchRecord('ROWID',grdRichieste.medpClientDataSet.FieldByName('DBG_ROWID').AsString,[srFromBeginning]) then
    begin
      Id:=W037DM.selT251.FieldByName('ID').AsInteger;
      Prog:=W037DM.selT251.FieldByName('PROGRESSIVO').AsInteger;
    end;
  end;

  // apre il dataset dei dipendenti (in inserimento imposta variabili in modo da ottenere 0 record)
  with W037DM.selT252 do
  begin
    Close;
    SetVariable('ID',Id);
    SetVariable('PROGRESSIVO',Prog);
    Open;
  end;
  grdDipendenti.medpCaricaCDS;
  grdDipendenti.medpNascondiComandi;

  // visualizza informazioni sui dipendenti in servizio, scioperanti e assenti
  with W037DM.selT252 do
  begin
    edtNumDipInServizio.Text:=RecordCount.ToString;
    ContaAssenti:=0;
    ContaScioperanti:=0;
    First;
    while not Eof do
    begin
      if not FieldByName('CAUSALE').IsNull then
      begin
        // causale di assenza indicata -> assente
        inc(ContaAssenti);
      end
      else if FieldByName('SCIOPERA').AsString = 'S' then
      begin
        // causale di assenza non indicata e flag sciopero attivo -> scioperante
        inc(ContaScioperanti);
      end;
      Next;
    end;
    First;
    edtNumDipScioperanti.Text:=ContaScioperanti.ToString;
    edtNumDipAssenti.Text:=ContaAssenti.ToString;
  end;
end;

procedure TW037FRichiestaScioperi.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i, LivAut: Integer;
  HintDesc, Revocabile, TR: String;
  VisAutorizza, StatoNegato, VisCanc, VisMod, VisChiudi, BloccoRiep: Boolean;
  IWImg: TmeIWImageFile;
const
  FUNZIONE = 'grdRichiesteAfterCaricaCDS';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  if WR000DM.Responsabile then
  begin
    // autorizzazione
    for i:=0 to High(grdRichieste.medpCompGriglia) do
    begin
      BloccoRiep:=WR000DM.selDatiBloccati.DatoBloccato(grdRichieste.medpValoreColonna(i,'PROGRESSIVO').ToInteger,R180InizioMese(StrToDate(grdRichieste.medpValoreColonna(i,'DATA'))),'T250');
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
        IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
        //***IWImg.OnClick:=imgAllegClick;
        IWImg.Hint:=C018.LeggiAllegati;
        if C018.EsisteGestioneAllegatiCodIter then
        begin
          if WR000DM.Responsabile then
          begin
            // responsabile: se la richiesta non ha allegati -> icona nascosta
            if not C018.IDContieneAllegati then
              IWImg.Css:='invisibile';
          end
          else
          begin
            // dipendente: se la richiesta non prevede allegati -> icona nascosta
            if C018.GetCondizioneAllegati = 'N' then
              IWImg.Css:='invisibile';
          end;
        end
        else
        begin
          IWImg.Css:='invisibile';
        end;
        IWImg.ImageFile.FileName:=IfThen(C018.IDContieneAllegati,fileImgAllegatiHighlight,fileImgAllegati);
      end;
      // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
      LivAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);
      VisAutorizza:=(not SolaLettura) and
                    (grdRichieste.medpValoreColonna(i,'ID_REVOCA') = '') and
                    (grdRichieste.medpValoreColonna(i,'AUTORIZZ_AUTOMATICA') <> 'S') and
                    (LivAut > 0) and
                    (not BloccoRiep);
      if not VisAutorizza then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
        C018.SetValoriAut(grdRichieste,i,0,0,1,chkAutorizzazioneClick);
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
        IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
        //***IWImg.OnClick:=imgAllegClick;
        IWImg.Hint:=C018.LeggiAllegati;
        if C018.EsisteGestioneAllegatiCodIter then
        begin
          if WR000DM.Responsabile then
          begin
            // responsabile: se la richiesta non ha allegati -> icona nascosta
            if not C018.IDContieneAllegati then
              IWImg.Css:='invisibile';
          end
          else
          begin
            // dipendente: se la richiesta non prevede allegati -> icona nascosta
            if C018.GetCondizioneAllegati = 'N' then
              IWImg.Css:='invisibile';
          end;
        end
        else
        begin
          IWImg.Css:='invisibile';
        end;
        IWImg.ImageFile.FileName:=IfThen(C018.IDContieneAllegati,fileImgAllegatiHighlight,fileImgAllegati);
      end;
      // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
      HintDesc:=' del ' + grdRichieste.medpValoreColonna(i,'DATA_RICHIESTA') +
                ' per il giorno ' + grdRichieste.medpValoreColonna(i,'DATA');

      Revocabile:=grdRichieste.medpValoreColonna(i,'REVOCABILE');
      TR:=grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA');
      StatoNegato:=C018.StatoNegato(grdRichieste.medpValoreColonna(i,'AUTORIZZ_UTILE'));
      BloccoRiep:=WR000DM.selDatiBloccati.DatoBloccato(grdRichieste.medpValoreColonna(i,'PROGRESSIVO').ToInteger,R180InizioMese(StrToDate(grdRichieste.medpValoreColonna(i,'DATA'))),'T250');
      // cancellazione consentita se tipo richiesta = 'P' e richiesta cancellabile (revocabile = 'CANC')
      VisCanc:=(TR = W037_TR_P) and (Revocabile = 'CANC') and (not BloccoRiep);
      // modifica consentita se tipo richiesta = 'P'  e stato non negato
      VisMod:=(TR = W037_TR_P) and (not StatoNegato) and (not BloccoRiep);
      // chiusura consentita se tipo richiesta = P
      VisChiudi:=(TR = W037_TR_P) and (not BloccoRiep);
      if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
      begin
        // cancella
        if not VisCanc then
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css:='invisibile';
        with (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile) do
        begin
          Hint:=Hint + HintDesc;
          OnClick:=imgCancellaClick;
        end;
        // modifica
        if not VisMod then
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:='invisibile';
        with (grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile) do
        begin
          Hint:=Hint + HintDesc;
          OnClick:=imgModificaClick;
        end;
        // annulla
        (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:='invisibile';
        with (grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile) do
        begin
          Hint:=Hint + HintDesc;
          OnClick:=imgAnnullaClick;
        end;
        // applica
        (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,3].Css:='invisibile';
        with (grdRichieste.medpCompCella(i,0,3) as TmeIWImageFile) do
        begin
          Hint:=Hint + HintDesc;
          OnClick:=imgConfermaClick;
        end;
        // chiusura richiesta
        if not VisChiudi then
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,4].Css:='invisibile';
        with (grdRichieste.medpCompCella(i,0,4) as TmeIWImageFile) do
        begin
          Hint:=Hint + HintDesc;
          OnClick:=imgChiudiRichiestaClick;
        end;
      end;
    end;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW037FRichiestaScioperi.TrasformaComponenti(const FN: String);
var
  DaTestoAControlli :Boolean;
  i,c: Integer;
  IWCmb: TMedpIWMultiColumnComboBox;
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
      Cell[0,4].Css:=IfThen(DaTestoAControlli,'invisibile','align_right');
    end;
  end;

  if DaTestoAControlli then
  begin
    // dataset -> componenti
    with grdRichieste do
    begin
      if medpStato = msInsert then
      begin
        // data evento
        medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'5','2','null','','');
        c:=medpIndexColonna('DATA');
        medpCreaComponenteGenerico(i,c,Componenti);
        IWCmb:=(medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox);
        with IWCmb do
        begin
          // imposta proprietà per corretta visualizzazione
          CodeColumn:=0;
          ColCount:=2;
          CssInputText:='medpMultiColumnComboBoxInput width10chr';
          CustomElement:=False;
          LookupColumn:=0;
          PopUpWidth:=10;
          // carica item degli eventi
          PopolaComboEventi(IWCmb);
          OnChange:=cmbEventoChange;
          if Items.Count = 1 then
          begin
            ItemIndex:=0;
            // bugfix: forza richiamo evento onchange
            cmbEventoChange(IWCmb,ItemIndex);
          end;
        end;
      end;

      // minimo
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'','','','','S');
      c:=medpIndexColonna('MINIMO');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        Css:='input_num_nnnn width3chr';
        if medpStato = msEdit then
          Text:=medpValoreColonna(i,'MINIMO');
      end;
    end;

    // gestione region di dettaglio
    if grdRichieste.medpStato = msEdit then
    begin
      //rgnDettaglio.medpAbilitaComponenti;
      grdDipendenti.medpVisualizzaComandi;
    end;
  end
  else
  begin
    // gestione tabella richieste
    with grdRichieste do
    begin
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('DATA')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('MINIMO')]);
    end;

    // gestione region di dettaglio
    //rgnDettaglio.medpDisabilitaComponenti;
    grdDipendenti.medpNascondiComandi;
  end;
end;

procedure TW037FRichiestaScioperi.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  NomeCampo: String;
begin
  if not grdRichieste.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  NumColonna:=grdRichieste.medpNumColonna(AColumn);

  // allineamento contenuti
  NomeCampo:=grdRichieste.medpColonna(NumColonna).DataField.ToUpper;

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow - 1 <= High(grdRichieste.medpCompGriglia)) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
    ACell.Text:='';
  end;

  // decodifiche dati
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (ACell.Text <> '') then
  begin
    if NomeCampo = 'TIPOGIUST' then
    begin
      if ACell.Text = 'I' then
        ACell.Text:='Giornata'
      else if ACell.Text = 'M' then
        ACell.Text:='Mezza giornata'
      else if ACell.Text = 'N' then
        ACell.Text:='Numero ore'
      else if ACell.Text = 'M' then
        ACell.Text:='Da ore - a ore';
    end
    else if NomeCampo = 'D_AUTORIZZAZIONE' then
    begin
      ACell.Css:=ACell.Css + ' font_grassetto align_center' +
                 IfThen(grdRichieste.medpValoreColonna(ARow - 1,'AUTORIZZ_UTILE') = C018NO,' font_rosso');
    end
  end;
end;

procedure TW037FRichiestaScioperi.GeneraDettaglioRichiesta;
// procedure che genera il dettaglio della richiesta dopo l'avvenuto
// inserimento della richiesta su T251
var
  LEvento: TEventoSciopero;
begin
  with W037DM do
  begin
    if not selT250.SearchRecord('ID',selT251.FieldByName('ID_T250').AsInteger,[srFromBeginning]) then
      Exit;

    // salva i dati dell'evento di sciopero in una variabile di supporto
    LEvento.Id:=selT250.FieldByName('ID').AsInteger;
    LEvento.Data:=selT250.FieldByName('DATA').AsDateTime;
    LEvento.SelezioneAnagrafica:=selT250.FieldByName('SELEZIONE_ANAGRAFICA').AsString;

    // estrae i dipendenti in servizio alla data dell'evento scelto
    //*** potrebbe essere non necessario
    GetDipendentiDisponibili(LEvento.Data);

    // se è specificata una selezione anagrafica per l'evento di sciopero selezionato
    // la interseca alla selezione del responsabile di struttura
    if LEvento.SelezioneAnagrafica <> '' then
    begin
      // valuta la selezione anagrafica associata all'evento per estrarre i progressivi
      // che possono partecipare allo sciopero
      with WR000DM.selAnagEventoSciopero do
      begin
        SetVariable('DATALAVORO',LEvento.Data);
        SetVariable('FILTRO','AND ' + LEvento.SelezioneAnagrafica);
        SetVariable('FILTRO_IN_SERVIZIO',FILTRO_IN_SERVIZIO);
        Open;
      end;
    end;

    // ciclo sui dipendenti del responsabile di struttura
    // se necessario interseca i dipendenti della selezione anagrafica associata all'evento di sciopero selezionato
    selAnagrafeW.First;
    while not selAnagrafeW.Eof do
    begin
      if (LEvento.SelezioneAnagrafica = '') or
         (WR000DM.selAnagEventoSciopero.SearchRecord('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning])) then
      begin
        // inserimento del dipendente sulla T282
        with selT252 do
        begin
          Append;
          FieldByName('ID').AsInteger:=selT251.FieldByName('ID').AsInteger;
          FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
          FieldByName('SCIOPERA').AsString:='N';
          Post;
        end;
      end;
      selAnagrafeW.Next;
    end;
    selAnagrafeW.First;

    // effettua insert e committa su T252
    SessioneOracle.ApplyUpdates([selT252],True);

    // chiude dataset di supporto
    if LEvento.SelezioneAnagrafica <> '' then
    begin
      WR000DM.selAnagEventoSciopero.CloseAll;
    end;
  end;
end;

procedure TW037FRichiestaScioperi.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato = msBrowse then
    grdRichiesteColumnClick(Sender,FN);
  with W037DM.selT251 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W037_MSG_RICH_NON_DISPONIBILE4),ESCLAMA);
      Exit;
    end;
  end;
  VisualizzaDettagli(Sender);
end;

procedure TW037FRichiestaScioperi.imgDettaglioGGClick(Sender: TObject);
var
  i: Integer;
  FN: String;
  W005FM: TW005FCartellinoFM;
const
  FUNZIONE = 'imgDettaglioGGClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  //grdRichiesteColumnClick(Sender,FN);
  i:=grdDipendenti.medpRigaDiCompGriglia(FN);

  W005FM:=TW005FCartellinoFM.Create(Self);
  W005FM.Progressivo:=grdDipendenti.medpValoreColonna(i,'PROGRESSIVO').ToInteger;
  W005FM.Dal:=W037DM.selT251.FieldByName('DATA').AsDateTime;
  W005FM.Al:=W005FM.Dal;
  W005FM.Visualizza;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW037FRichiestaScioperi.imgInserisciClick(Sender: TObject);
// prepara la grid per l'inserimento di una nuova richiesta
var
  FN: string;
const
  FUNZIONE = 'imgInserisciClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato <> msBrowse then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_R013_ERR_COMPLETA_OPERAZIONE));
    Exit;
  end;

  // pulisce info richiesta per inserimento
  Richiesta.Id:=0;
  Richiesta.IdT250:=0;
  Richiesta.Data:=DATE_NULL;
  Richiesta.Progressivo:=0;
  Richiesta.Minimo:=0;
  Richiesta.NumDipInServizio:=0;

  // pulisce la region di dettaglio
  edtNumDipInServizio.Clear;
  edtNumDipScioperanti.Clear;
  edtNumDipAssenti.Clear;

  // imposta la grid per l'inserimento di un nuovo record
  grdRichieste.medpStato:=msInsert;
  grdRichiesteColumnClick(Sender,FN);
  grdRichieste.medpBrowse:=False;
  TrasformaComponenti(FN);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW037FRichiestaScioperi.imgModificaClick(Sender:TObject);
// prepara la grid per la modifica della richiesta selezionata
var
  FN: string;
  i: Integer;
begin
  if grdRichieste.medpStato <> msBrowse then
  begin
    MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_R013_ERR_FMT_COMPLETA_OPERAZIONE),
                             [IfThen(grdRichieste.medpStato = msInsert,'inserimento','variazione')]),
                      INFORMA,'Operazione in corso');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;

  with W037DM.selT251 do
  begin
    // verifica presenza richiesta
    Refresh;
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICHIESTA_ND_MOD),INFORMA,'Richiesta eliminata');
      Exit;
    end;
  end;

  // porta la riga in modifica: trasforma i componenti
  grdRichiesteColumnClick(Sender,FN);
  grdRichieste.medpStato:=msEdit;
  grdRichieste.medpBrowse:=False;
  TrasformaComponenti(FN);

  // porta la tabella di dettaglio in modifica
  grdDipendenti.medpStato:=msEdit;
  grdDipendenti.medpBrowse:=False;
  grdDipendenti.medpColonna('DBG_COMANDI').Visible:=False;
  if R180In(W037DM.selT251.FieldByName('TIPO_RICHIESTA').AsString,[W037_TR_P,W037_TR_D]) then
  begin
    for i:=0 to High(grdDipendenti.medpCompGriglia) do
    begin
      TrasformaComponentiDip(grdDipendenti.medpValoreColonna(i,'DBG_ROWID'),True);
    end;
  end;
end;

procedure TW037FRichiestaScioperi.imgCancellaClick(Sender: TObject);
// effettua la cancellazione della richiesta selezionata
const
  FUNZIONE = 'imgCancellaClick';
var
  FN: String;
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  with W037DM.selT251 do
  begin
    Refresh;
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W037_MSG_RICH_NON_DISPONIBILE),ESCLAMA);
      Exit;
    end;
    grdRichiesteColumnClick(Sender,FN);
    actCancRichiesta(FN);
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW037FRichiestaScioperi.imgConfermaClick(Sender: TObject);
// conferma inserimento oppure modifica di una richiesta
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdRichieste.medpStato = msEdit then
  begin
    // se il record non esiste -> errore
    if not W037DM.selT251.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      grdRichieste.medpStato:=msBrowse;
      TrasformaComponenti(FN);
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICHIESTA_ND),INFORMA);
      Exit;
    end;
  end;

  // controlli per inserimento o aggiornamento richiesta
  if not CtrlRichiesta(FN) then
    Exit;

  // effettua controlli sulla tabella dei dipendenti e conferma
  if not CtrlDipendentiOK then
    Exit;

  if grdRichieste.medpStato = msInsert then
    actInsRichiesta
  else if grdRichieste.medpStato = msEdit then
    actModRichiesta(FN);
end;

procedure TW037FRichiestaScioperi.imgAnnullaClick(Sender: TObject);
// ricarica la tabella e la riporta in browse
begin
  VisualizzaDipendenteCorrente;
end;

procedure TW037FRichiestaScioperi.imgChiudiRichiestaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // se il record non esiste -> errore
  if not W037DM.selT251.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    grdRichieste.medpStato:=msBrowse;
    TrasformaComponenti(FN);
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_MSG_RICHIESTA_ND),INFORMA);
    Exit;
  end;
  grdRichiesteColumnClick(Sender,FN);
  actChiudiRichiesta(FN);
end;

function TW037FRichiestaScioperi.CtrlRichiesta(const FN: String): Boolean;
// effettua i controlli in fase di inserimento o di modifica di una richiesta
// restituisce True se i dati sono corretti, False altrimenti
var
  i: Integer;
  IWC: TIWCustomControl;
  Valore: String;
  idx: Integer;
begin
  Result:=False;
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  // evento di sciopero
  if grdRichieste.medpStato = msInsert then
  begin
    // gestione inserimento
    IWC:=grdRichieste.medpCompCella(i,'DATA',0);
    idx:=(IWC as TMedpIWMultiColumnComboBox).ItemIndex;
    if idx < 0 then
    begin
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W037_MSG_SELEZIONARE_EVENTO),INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;
    Richiesta.Id:=0;
    Valore:=(IWC as TMedpIWMultiColumnComboBox).Items[idx].RowData[W037_CMBEVENTO_COL_ID];
    Richiesta.IdT250:=Valore.ToInteger;
    Valore:=(IWC as TMedpIWMultiColumnComboBox).Text;
    Richiesta.Data:=StrToDate(Valore);
  end
  else
  begin
    // gestione modifica
    Richiesta.Id:=grdRichieste.medpValoreColonna(i,'ID').ToInteger;
    Richiesta.IdT250:=grdRichieste.medpValoreColonna(i,'ID_T250').ToInteger;
    Richiesta.Data:=StrToDate(grdRichieste.medpValoreColonna(i,'DATA'));
  end;

  // progressivo richiedente
  if grdRichieste.medpStato = msInsert then
    Richiesta.Progressivo:=Parametri.ProgressivoOper
  else
    Richiesta.Progressivo:=grdRichieste.medpValoreColonna(i,'PROGRESSIVO').ToInteger;

  // controllo blocco riepiloghi in inserimento
  // nota: modifica e cancellazione sono inibite a monte
  if grdRichieste.medpStato = msInsert then
  begin
    if WR000DM.selDatiBloccati.DatoBloccato(Richiesta.Progressivo,R180InizioMese(Richiesta.Data),'T250') then
    begin
      MsgBox.MessageBox(A000MSG_W037_ERR_FMT_INS_RICH_ANNULLATO,INFORMA);
      Exit;
    end;
  end;

  // numero dipendenti in servizio
  if not TryStrToInt(edtNumDipInServizio.Text,Richiesta.NumDipInServizio) then
  begin
    Richiesta.NumDipInServizio:=selAnagrafeW.RecordCount;
  end;

  // numero minimo di dipendenti in servizio
  IWC:=grdRichieste.medpCompCella(i,'MINIMO',0);
  Valore:=(IWC as TmeIWEdit).Text;
  if Valore = '' then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W037_ERR_MINIMO_NON_INDICATO),INFORMA);
    IWC.SetFocus;
    Exit;
  end;
  // controllo valore formalmente corretto
  if not TryStrToInt(Valore,Richiesta.Minimo) then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W037_ERR_MINIMO_ERRATO),INFORMA);
    IWC.SetFocus;
    Exit;
  end;
  // controllo minimo dipendenti positivo
  if Richiesta.Minimo < 0 then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W037_ERR_MINIMO_ZERO),INFORMA);
    IWC.SetFocus;
    Exit;
  end;
  // controllo minimo dipendenti <= dipendenti in servizio
  if Richiesta.Minimo > Richiesta.NumDipInServizio then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W037_ERR_MINIMO_DIP_SERV),INFORMA);
    IWC.SetFocus;
    Exit;
  end;

  Result:=True;
end;

procedure TW037FRichiestaScioperi.actInsRichiesta;
// inserimento della richiesta
const
  FUNZIONE = 'actInsRichiesta';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  // inserimento richiesta
  with W037DM.selT251 do
  begin
    Append;
    FieldByName('ID_T250').AsInteger:=Richiesta.IdT250;
    FieldByName('PROGRESSIVO').AsInteger:=Richiesta.Progressivo;
    FieldByName('MINIMO').AsInteger:=Richiesta.Minimo;
  end;

  if not C018.WarningRichiesta then
    Messaggio('Conferma',Format(A000TraduzioneStringhe(A000MSG_W037_FMT_C018_CONTINUA),[C018.MessaggioOperazione]),ConfermaInsRichiesta,AnnullaInsRichiesta)
  else
    ConfermaInsRichiesta;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW037FRichiestaScioperi.ConfermaInsRichiesta;
var
  TipoRichiesta: String;
  IdIns:Integer;
begin
  // parte 1. inserimento dati di testata della richiesta
  with W037DM.selT251 do
  begin
    try
      TipoRichiesta:=W037_TR_P;
      C018.InsRichiesta(TipoRichiesta,'','');
      IdIns:=C018.Id;
      if C018.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end;
    except
      on E: Exception do
      begin
        IdIns:=0;
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W037_FMT_INS_FALLITO),[E.Message]),ESCLAMA);
        if State <> dsBrowse then
          Cancel;
      end;
    end;
    SessioneOracle.Commit;
  end;

  // parte 2. inserimento dati di dettaglio della richiesta
  GeneraDettaglioRichiesta;

  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  // posizionamento su riga appena inserita
  grdRichiesteColumnClick(nil,IdIns.ToString);
end;

procedure TW037FRichiestaScioperi.AnnullaInsRichiesta;
begin
  W037DM.selT251.Cancel;

  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

procedure TW037FRichiestaScioperi.actModRichiesta(const FN: String);
var
  IdUpd: Integer;
begin
  // parte 1. aggiornamento dati di testata della richiesta
  with W037DM.selT251 do
  begin
    try
      Edit;
      FieldByName('MINIMO').AsInteger:=Richiesta.Minimo;

      // aggiornamento richiesta
      C018.UpdRichiesta(FieldByName('TIPO_RICHIESTA').AsString);
      IdUpd:=C018.Id;
      if C018.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end;
    except
      on E: Exception do
      begin
        IdUpd:=0;
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_R013_ERR_FMT_MOD_FALLITA),[E.Message]),ESCLAMA);
        if State <> dsBrowse then
          Cancel;
        Exit;
      end;
    end;
    SessioneOracle.Commit;
  end;

  // parte 2. aggiornamento dati di dettaglio della richiesta
  SalvaDettaglioRichiesta;

  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  // posizionamento su riga appena inserita
  grdRichiesteColumnClick(nil,IdUpd.ToString);
end;

procedure TW037FRichiestaScioperi.actCancRichiesta(const FN: String);
// effettua la cancellazione della richiesta di sciopero selezionata
const
  FUNZIONE = 'actCancRichiesta';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  with W037DM do
  begin
    try
      //elimina la richiesta
      C018.CodIter:=selT251.FieldByName('COD_ITER').AsString;
      C018.Id:=selT251.FieldByName('ID').AsInteger;
      C018.EliminaIter;
      SessioneOracle.Commit;
      Refresh;
    except
      on E: Exception do
        GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_R013_MSG_RICHIESTA_CANC_FALLITA),[E.Message,E.ClassName]));
    end;
  end;
  VisualizzaDipendenteCorrente;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW037FRichiestaScioperi.actChiudiRichiesta(const FN: String);
// inoltra la richiesta al responsabile
begin
  C018.Id:=W037DM.selT251.FieldByName('ID').AsInteger;
  C018.CodIter:=W037DM.selT251.FieldByName('COD_ITER').AsString;
  with W037DM.selT251 do
  begin
    try
      // dataset in edit per update richiesta
      Edit;

      // 1. imposta il tipo richiesta
      C018.SetTipoRichiesta(W037_TR_D);

      // 2. aggiorna richiesta per valutare autorizzazioni automatiche
      C018.UpdRichiesta(W037_TR_D);
      if C018.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end;
    except
      on E: Exception do
      begin
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_R013_ERR_FMT_CHIUSURA_FALLITA),[E.Message]),ESCLAMA);
        if State <> dsBrowse then
          Cancel;
        Exit;
      end;
    end;
    SessioneOracle.Commit;
  end;

  VisualizzaDipendenteCorrente;
  // tenta il posizionamento sulla richiesta modificata
  grdRichiesteColumnClick(nil,C018.Id.ToString);
end;


//############################################//
procedure TW037FRichiestaScioperi.TrasformaComponentiDip(const FN: String; DaTestoAControlli: Boolean);
var
  i, c: Integer;
  IsAssente: Boolean;
begin
  // pre: not SolaLettura
  i:=grdDipendenti.medpRigaDiCompGriglia(FN);

  if DaTestoAControlli then
  begin
    with grdDipendenti do
    begin
      // assenza
      IsAssente:=medpValoreColonna(i,'CAUSALE') <> '';

      c:=medpIndexColonna('SCIOPERA');
      medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWCheckBox) do
      begin
        // se dipendente è assente rimuove il flag di sciopero
        Checked:=(medpValoreColonna(i,'SCIOPERA') = 'S') and (not IsAssente);
        OnAsyncClick:=chkScioperoAsyncClick;
        // flag di sciopero: presentato se dipendente non è assente
        if IsAssente then
          Css:='invisibile';
      end;
    end;
  end
  else
  begin
    with grdDipendenti do
    begin
      // flag di sciopero
      FreeAndNil(medpCompgriglia[i].CompColonne[medpIndexColonna('SCIOPERA')]);
    end;
  end;
end;

procedure TW037FRichiestaScioperi.chkScioperoAsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  i, ContaScioperanti{ContaInServizio, ContaAssenti}: Integer;
  IWChk: TmeIWCheckBox;
  //Abilita: Boolean;
begin
  // controllo possibilità di selezionare un nuovo scioperante
  (*
  if (Sender as TmeIWCheckBox).Checked then
  begin
    Abilita:=True;
    if (TryStrToInt(edtNumDipInServizio.Text,ContaInServizio)) and
       (TryStrToInt(edtNumDipInServizio.Text,ContaScioperanti)) and
       (TryStrToInt(edtNumDipInServizio.Text,ContaAssenti)) then
    begin
      Abilita:=(ContaInServizio - ContaScioperanti - ContaAssenti) > Richiesta.Minimo;
    end;
    if not Abilita then
    begin
      (Sender as TmeIWCheckBox).Checked:=False;
      //?? messaggio ??
    end;
  end;
  *)

  // aggiorna il conteggio dei dipendenti scioperanti e assenti
  ContaScioperanti:=0;
  for i:=0 to High(grdDipendenti.medpCompGriglia) do
  begin
    IWChk:=(grdDipendenti.medpCompCella(i,'SCIOPERA',0) as TmeIWCheckBox);
    if Assigned(IWChk) then
    begin
      if IWChk.Checked then
        inc(ContaScioperanti);
    end;
  end;

  // aggiorna il conteggio dei dipendenti scioperanti
  edtNumDipScioperanti.Text:=ContaScioperanti.ToString;
end;

function TW037FRichiestaScioperi.ContaDipInServizio: Integer;
// restituisce il numero di dipendenti attualmente selezionati
var
  i: Integer;
  IWChk: TmeIWCheckBox;
begin
  if grdRichieste.medpStato = msBrowse then
  begin
    Result:=-1;
  end
  else
  begin
    Result:=grdDipendenti.medpDataSet.RecordCount;
    for i:=0 to High(grdDipendenti.medpCompGriglia) do
    begin
      IWChk:=(grdDipendenti.medpCompCella(i,'SCIOPERA',0) as TmeIWCheckBox);
      // decrementa il contatore dei dipendenti in servizio per i seguenti casi:
      // - se il checkbox è selezionato  -> dipendente sciopera
      // - se il checkbox è invisibile   -> dipendente è assente
      if (IWChk.Checked) or (IWChk.Css = 'invisibile') then
      begin
        dec(Result);
      end;
    end;
  end;
end;

function TW037FRichiestaScioperi.CtrlDipendentiOK: Boolean;
// funzione di controllo sui dati dei dipendenti scioperanti
var
  Conta, Diff: Integer;
begin
  Result:=False;

  if grdRichieste.medpStato = msEdit then
  begin
    // in modifica conta il numero dei dipendenti mantenuti in servizio e lo confronta
    // con il contingente minimo
    Conta:=ContaDipInServizio;
    Diff:=Conta - Richiesta.Minimo;
    if Diff < 0 then
    begin
      Diff:=Abs(Diff);
      MsgBox.MessageBox(Format(A000TraduzioneStringhe(IfThen(Richiesta.Minimo = 1,A000MSG_W037_ERR_FMT_1_DIPENDENTE_MIN,A000MSG_W037_ERR_FMT_N_DIPENDENTI_MIN)),[Richiesta.Minimo]) +
                        Format(A000TraduzioneStringhe(IfThen(Diff = 1,A000MSG_W037_ERR_FMT_1_DIP_MANCANTE,A000MSG_W037_ERR_FMT_N_DIP_MANCANTI)),[Diff]),INFORMA);
      Exit;
    end;
  end;

  Result:=True;
end;

procedure TW037FRichiestaScioperi.SalvaDettaglioRichiesta;
// aggiorna il dettaglio della richiesta
var
  i, c: Integer;
  IWChk: TmeIWCheckBox;
begin
  with grdDipendenti do
  begin
    // verifica numero minimo di dipendenti raggiunto
    c:=medpIndexColonna('SCIOPERA');
    for i:=0 to High(medpCompGriglia) do
    begin
      IWChk:=(medpCompGriglia[i].CompColonne[c] as TmeIWCheckBox);
      if Assigned(IWChk) then
      begin
        with W037DM.selT252 do
        begin
          if SearchRecord('PROGRESSIVO',medpValoreColonna(i,'PROGRESSIVO').ToInteger,[srFromBeginning]) then
          begin
            Edit;
            FieldByName('SCIOPERA').AsString:=IfThen(IWChk.Checked,'S','N');
            Post;
          end;
        end;
      end;
    end;
  end;

  // esecuzione update e commit su T252
  if W037DM.selT252.UpdatesPending then
    SessioneOracle.ApplyUpdates([W037DM.selT252],True);
end;

procedure TW037FRichiestaScioperi.grdDipendentiAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var
  i: Integer;
const
  FUNZIONE = 'grdDipendentiAfterCaricaCDS';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  // immagine per visualizzazione dettaglio giornaliero
  for i:=0 to High(grdDipendenti.medpCompGriglia) do
  begin
    with (grdDipendenti.medpCompCella(i,'TIMBRATURE',0) as TmeIWImageFile) do
    begin
      OnClick:=imgDettaglioGGClick;
    end;
  end;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW037FRichiestaScioperi.grdDipendentiRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo, Stato: String;
begin
  if not grdDipendenti.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  NumColonna:=grdDipendenti.medpNumColonna(AColumn);
  Campo:=grdDipendenti.medpColonna(NumColonna).DataField;

  // width delle colonne
  if ARow = 0 then
  begin
    // riga di intestazione: larghezza colonne
    if Campo = 'SCIOPERA' then
      ACell.Width:='5%'
    else if Campo = 'COGNOME' then
      ACell.Width:='29%'
    else if Campo = 'NOME' then
      ACell.Width:='29%'
    else if Campo = 'MATRICOLA' then
      ACell.Width:='9%'
    else if Campo = 'CAUSALE' then
      ACell.Width:='7%'
    else if Campo = 'TIMBRATURE' then
      ACell.Width:='6%'
    else if Campo = 'REPERIBILITA' then
      ACell.Width:='15%';
  end
  else
  begin
    // righe di dettaglio
    if ARow <= Length(grdDipendenti.medpCompGriglia) then
    begin
      if Campo = 'SCIOPERA' then
      begin
        ACell.Css:=ACell.Css + IfThen(ACell.Text = 'S',' fontGreen','');
        ACell.Text:=IfThen(ACell.Text = 'S','Sì','No');
      end
      else if Campo = 'CAUSALE' then
      begin
        Stato:=grdDipendenti.medpValoreColonna(ARow - 1,'STATO');
        if Stato = W037_STATO_R then
        begin
          // richiesta da autorizzare: evidenzia con colore rosa
          ACell.Css:=ACell.Css + ' bg_rosa';
        end
        else if Stato = W037_STATO_A then
        begin
          // giustificativo oppure richiesta autorizzata: evidenzia con colore rosso
          ACell.Css:=ACell.Css + ' bg_rosso';
        end;
        ACell.Hint:=VarToStr(WR000DM.selT265.Lookup('CODICE',ACell.Text,'DESCRIZIONE'));
      end
      else if Campo = 'TIMBRATURE' then
      begin
        if ACell.Text = 'S' then
        begin
          ACell.Css:=ACell.Css + ' bg_lime';
          ACell.Text:='Sì';
        end
        else
        begin
          ACell.Text:='';
        end;
      end;
    end;
  end;

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow - 1 <= High(grdDipendenti.medpCompGriglia)) and (grdDipendenti.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Control:=grdDipendenti.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
    ACell.Text:='';
  end;
end;

procedure TW037FRichiestaScioperi.DistruggiOggetti;
begin
  try FreeAndNil(W037DM); except end;

  // dataset condivisi
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT265);
  end;
end;

end.
