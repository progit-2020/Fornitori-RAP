unit W028UChiamateReperibili;

interface

uses
  R010UPaginaWeb, R012UWebAnagrafico, USelI010,
  W028UChiamateReperibiliDM, W002UModificaDatiDM, W002UModificaDatiFM,
  WC002UDatiAnagraficiFM, A000UCostanti, A000USessione,A000UInterfaccia,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, IWApplication,
  StrUtils, Math, OracleData, Oracle, DB, SysUtils,
  Classes,Graphics,Controls,IWTemplateProcessorHTML,IWCompLabel,
  IWControl,IWHTMLControls,IWCompEdit,IWCompButton,
  IWCompListbox,Variants,IWBaseLayoutComponent,
  IWBaseContainerLayout,IWContainerLayout,IWVCLBaseControl,IWBaseControl,
  IWBaseHTMLControl,Forms, IWVCLComponent, IWDBGrids, medpIWDBGrid, DBClient,
  meTIWAdvRadioGroup, meIWEdit, meIWButton, meIWLabel,
  meIWComboBox, meIWText, meIWMemo, meIWGrid,
  IWCompExtCtrls, IWCompGrids, meIWImageFile, meIWLink, meIWRadioGroup;

type
  TDipendenti = record
    Value:String;
    Visible:Boolean;
    Progressivo:String;
    Matricola:String;
    Cognome:String;
    Nome:String;
    Nominativo:String;
    Turno:String;
    Descrizione:String;
    Dalle:String;
    Alle:String;
    DataTurno:TDateTime;
    Priorita:Integer;
    TollChiamataInizio:String;
    TollChiamataFine:String;
    DatiVisArr: array of TDati;
    DatoLibero1Valore:String;
    DatoLibero2Valore:string;
  end;

  TRecordChiamata = record
    Operazione:String;
    Data:TDateTime;
    Operatore:String;
    ProgReper:Integer;
    Esito:String;
    Note:String;
    DataTurno: TDateTime;
    Turno: String;
  end;

  TW028FChiamateReperibili = class(TR012FWebAnagrafico)
    dsrT390: TDataSource;
    cdsT390: TClientDataSet;
    grdChiamate:TmedpIWDBGrid;
    edtDal: TmeIWEdit;
    edtAl: TmeIWEdit;
    rgpTipoEsito: TmeIWRadioGroup;
    rgpTipoUtente: TmeIWRadioGroup;
    btnEsegui: TmeIWButton;
    lblPeriodoDal: TmeIWLabel;
    lblPeriodoAl: TmeIWLabel;
    cmbFiltroDato1: TmeIWComboBox;
    cmbFiltroDato2: TmeIWComboBox;
    lblFiltroDato1: TmeIWLabel;
    lblFiltroDato2: TmeIWLabel;
    lblLegendaFiltri: TmeIWLabel;
    procedure IWAppFormCreate(Sender:TObject);
    procedure imgModificaClick(Sender:TObject);
    procedure imgConfermaClick(Sender:TObject);
    procedure imgAnnullaClick(Sender:TObject);
    procedure grdChiamateRenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer);
    procedure grdChiamateAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure rgpTipoEsitoClick(Sender: TObject);
    procedure rgpTipoUtenteClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure cmbFiltroDato1Change(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure IWAppFormAfterRender(Sender: TObject);
  private
    Dal,Al:TDateTime;
    DatoLibero1,DatoLibero1Desc,DatoLibero2,DatoLibero2Desc: String;
    CodLen1, CodLen2: Integer;
    ColInfoDip,ColSchedaAnag: Integer;
    RecordChiamata:TRecordChiamata;
    ArrDipendenti: array of TDipendenti;
    StileCella1,StileCella2,StileCella3: String;
    W028DM: TW028FChiamateReperibiliDM;
    W002ModDatiDM: TW002FModificaDatiDM;
    W028ModDatiFM: TW002FModificaDatiFM;
    WC002FM: TWC002FDatiAnagraficiFM;
    DatiAnag: TDatiAnag;
    procedure SetDatoLibero(const PDato: String; var RDatoV430, RDatoDescV430: String; var RCodLen: Integer;
      PLabelFiltro: TmeIWLabel; PComboFiltro: TmeIWComboBox);
    function  ArrDipendentiGetIndex(const Codice:String;p,r:Integer):Integer;
    function  ArrDipendentiGetDesc(const Codice:String;p,r:Integer):String;
    function  ArrDipendentiGetText(const PIndex: Integer): String;
    procedure GetDatiTabellari;
    procedure AggiornaFiltro;
    procedure TrasformaComponenti(const FN:String);
    procedure imgInserisciClick(Sender:TObject);
    function  ModificheRiga(const FN:String):Boolean;
    function  ImpostaPeriodo:Boolean;
    function  ControlliOK(const FN:String):Boolean;
    procedure actInserimentoOK;
    procedure actVariazioneOK;
    procedure DBGridColumnClick(ASender:TObject; const AValue:string);
    procedure CreaComponentiRiga(R:Integer);
    procedure dcmbDipendentiChange(Sender:TObject);
    procedure PreparaDatiAnag(const PIndex: Integer);
    procedure imgSchedaAnagraficaClick(Sender:TObject);
    procedure imgModificaDatiClick(Sender: TObject);
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

// MONDOEDP - commessa MAN/02 SVILUPPO#119.ini
{
const
  TOLLERANZA_E = 0; // minuti di tolleranza in entrata sul turno (al momento è 0)
  TOLLERANZA_U = 0; // minuti di tolleranza in uscita dal turno (al momento è 0)
}
// MONDOEDP - commessa MAN/02 SVILUPPO#119.fine

implementation

uses W001UIrisWebDtM;

{$R *.DFM}

function TW028FChiamateReperibili.InizializzaAccesso:Boolean;
var
  Filtro:String;
begin
  // controlli sui parametri
  Result:=False;
  if (Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 = '') and
     (Parametri.CampiRiferimento.C29_ChiamateRepFiltro2 <> '') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' stato specificato il dato aziendale "Reperibilità: Filtro 2"' + CRLF +
                               'senza specificare il parametro "Reperibilità: Filtro 1".' + CRLF +
                               'Per accedere alla funzione "' + medpNomeFunzione + '" è necessario correggere questa impostazione.');
    Exit;
  end
  else if (Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 <> '') and
          (Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 = Parametri.CampiRiferimento.C29_ChiamateRepFiltro2) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Il dato aziendale "Reperibilità: Filtro 1"' + CRLF +
                               'è uguale al dato "Reperibilità: Filtro 2".' + CRLF +
                               'Per accedere alla funzione "' + medpNomeFunzione + '" è necessario correggere questa impostazione.');
    Exit;
  end;

  // inizializzazioni
  Result:=True;
  if ParametriForm.Al = DATE_NULL then
  begin
    Dal:=Date;
    Al:=Date;
  end
  else
  begin
    Dal:=ParametriForm.Dal;
    Al:=ParametriForm.Al;
  end;
  // visualizza periodo
  edtDal.Text:=DateToStr(Dal);
  edtAl.Text:=DateToStr(Al);
  with W028DM.selT390 do
  begin
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('DATAINIZIO',Dal);
    SetVariable('DATAFINE',Al);
    Filtro:='';
    if rgpTipoUtente.ItemIndex = 0 then
      Filtro:=Filtro + ' AND T390.UTENTE = ''' + Parametri.Operatore + '''';
    if rgpTipoEsito.ItemIndex = 0 then
      Filtro:=Filtro + ' AND T390.ESITO = ''S'''
    else if rgpTipoEsito.ItemIndex = 1 then
      Filtro:=Filtro + ' AND T390.ESITO = ''N'''
    else if rgpTipoEsito.ItemIndex = 2 then
      Filtro:=Filtro + ' AND T390.ESITO = ''A''';
    SetVariable('FILTRO',Filtro);
    Close;
    Open;
  end;

  // filtro dipendenti
  lblLegendaFiltri.Caption:='Filtro dipendenti';
  cmbFiltroDato1.ItemIndex:=0;
  cmbFiltroDato2.ItemIndex:=0;

  with grdChiamate do
  begin
    medpCreaCDS;
    medpEliminaColonne;
    medpAggiungiColonna('DBG_COMANDI','','',nil);
    medpAggiungiColonna('DATA','Data','',nil);
    medpAggiungiColonna('OPERATORE','Operatore','',nil);
    medpColonna('OPERATORE').Visible:=rgpTipoUtente.ItemIndex = 1;
    medpAggiungiColonna('DIPENDENTE','Dipendente','',nil);
    medpAggiungiColonna('D_SCHEDAANAG','','',nil);
    medpAggiungiColonna('D_INFO','Informazioni','',nil);
    medpAggiungiColonna('D_ESITO','Esito','',nil);
    medpAggiungiColonna('NOTE','Note','',nil);
    // nascoste (servono per estrarre info turno)
    medpAggiungiColonna('PROGRESSIVO_REPER','Progressivo','',nil);
    medpAggiungiColonna('TURNO','Turno','',nil);
    medpColonna('PROGRESSIVO_REPER').Visible:=False;;
    medpColonna('TURNO').Visible:=False;;
    medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
    medpInizializzaCompGriglia;

    // indici utilizzati nella gestione
    ColSchedaAnag:=medpIndexColonna('D_SCHEDAANAG');
    ColInfoDip:=medpIndexColonna('D_INFO');

    if not SolaLettura then
    begin
      medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','MODIFICA','null','','S');
      medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','ANNULLA','null','','S');
      medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','CONFERMA','null','','D');
      //Riga di inserimento
      medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','null','','S');
      medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','null','','S');
      medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','null','','D');

      // scheda anagrafica e modifica dati anagrafici
      // riga di inserimento
      medpPreparaComponenteGenerico('I',ColSchedaAnag,0,DBG_IMG,'','SCHANAGR','null','','',True); // non impostare a False l'ultimo parametro
      if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        medpPreparaComponenteGenerico('I',ColSchedaAnag,1,DBG_IMG,'','MODIFICA','Modifica i dati anagrafici','','S');
      // righe di dettaglio
      medpPreparaComponenteGenerico('R',ColSchedaAnag,0,DBG_IMG,'','SCHANAGR','null','','',True); // non impostare a False l'ultimo parametro
      if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        medpPreparaComponenteGenerico('R',ColSchedaAnag,1,DBG_IMG,'','MODIFICA','Modifica i dati anagrafici','','S');
    end;
    medpCaricaCDS;
  end;
  GetDatiTabellari;

  // inizializza struttura dati per aggiornamento
  RecordChiamata.Operazione:='';
  RecordChiamata.Data:=0;
  RecordChiamata.Operatore:='';
  RecordChiamata.ProgReper:=0;
  RecordChiamata.Esito:='';
  RecordChiamata.Note:='';
  RecordChiamata.DataTurno:=0;
  RecordChiamata.Turno:='';
end;

procedure TW028FChiamateReperibili.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 15 }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    inherited;
    RimuoviNotifiche;
  end;
end;

procedure TW028FChiamateReperibili.IWAppFormCreate(Sender:TObject);
var
  Dati,FiltroRicerca: String;
begin
  inherited;

  // colonne di V430 da estrarre oltre a quelle standard
  CampiV430:='V430.T430BADGE,V430.T430TELEFONO,V430.T430INDIRIZZO,V430.T430CAP,V430.T430D_COMUNE,V430.T430D_PROVINCIA';

  // datamodule principale
  W028DM:=TW028FChiamateReperibiliDM.Create(Self);

  // datamodule di supporto per modifica dati anagrafici
  W002ModDatiDM:=TW002FModificaDatiDM.Create(Self);
  W002ModDatiDM.IntegraCampiV430RepVis(CampiV430);

  // elenco dati da visualizzare e da modificare per la reperibilità
  DatiAnag.Modificato:=False;
  DatiAnag.Progressivo:=0;
  DatiAnag.Decorrenza:=DATE_NULL;
  DatiAnag.Nominativo:='';

  // imposta filtri iniziali
  rgpTipoUtente.Items.Clear;
  rgpTipoUtente.Items.Add(Parametri.Operatore);
  rgpTipoUtente.Items.Add('Tutti');
  FiltroRicerca:=WR000DM.FiltroRicerca;
  FiltroRicerca:=StringReplace(FiltroRicerca,':DATALAVORO','T390.DATA',[rfReplaceAll,rfIgnoreCase]);
  FiltroRicerca:=StringReplace(FiltroRicerca,':DATADAL','T390.DATA',[rfReplaceAll,rfIgnoreCase]);
  W028DM.selT390.SetVariable('FILTRORICERCA',FiltroRicerca);

  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdChiamate.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdChiamate.medpDataSet:=W028DM.selT390;

  // filtro per dato 1
  DatoLibero1:='';
  DatoLibero1Desc:='';
  CodLen1:=0;
  SetDatoLibero(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,
                DatoLibero1,DatoLibero1Desc,CodLen1,lblFiltroDato1,cmbFiltroDato1);

  // filtro per dato 2
  DatoLibero2:='';
  DatoLibero2Desc:='';
  CodLen2:=0;
  SetDatoLibero(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2,
                DatoLibero2,DatoLibero2Desc,CodLen2,lblFiltroDato2,cmbFiltroDato2);

  // nasconde il groupbox del filtro dati se non sono presenti
  if not (lblFiltroDato1.Visible or lblFiltroDato2.Visible) then
    JavascriptBottom.Add('document.getElementById("filtroDati").className = "invisibile";');

  // imposta variabili dataset
  Dati:='';
  if DatoLibero1 <> '' then
    Dati:=DatoLibero1 + ',' + DatoLibero1Desc + IfThen(DatoLibero1Desc <> '',',');
  if DatoLibero2 <> '' then
    Dati:=Dati + DatoLibero2 + ',' + DatoLibero2Desc + IfThen(DatoLibero2Desc <> '',',');

  // dati personalizzati per le info sul dipendente
  W002ModDatiDM.IntegraCampiV430RepVis(Dati);
  if (Dati <> '') and (RightStr(Dati,1) <> ',') then
    Dati:=Dati + ',';

  // imposta variabili per dataset principale
  W028DM.selT380.SetVariable('DATALAVORO',Parametri.DataLavoro);
  W028DM.selT380.SetVariable('DATI',Dati);
  // MONDOEDP - commessa MAN/02 SVILUPPO#119.ini
  //W028DM.selT380.SetVariable('TOLLERANZA_E',TOLLERANZA_E);
  //W028DM.selT380.SetVariable('TOLLERANZA_U',TOLLERANZA_U);
  // MONDOEDP - commessa MAN/02 SVILUPPO#119.fine
end;

procedure TW028FChiamateReperibili.IWAppFormRender(Sender: TObject);
begin
  inherited;
  // dipendenti disponibili
  AbilitazioneComponente(cmbDipendentiDisponibili,grdChiamate.medpStato = msBrowse);
  // filtri di visualizzazione
  AbilitazioneComponente(rgpTipoUtente,grdChiamate.medpStato = msBrowse);
  AbilitazioneComponente(rgpTipoEsito,grdChiamate.medpStato = msBrowse);
  // periodo
  AbilitazioneComponente(edtDal,grdChiamate.medpStato = msBrowse);
  AbilitazioneComponente(edtAl,grdChiamate.medpStato = msBrowse);
  AbilitazioneComponente(btnEsegui,grdChiamate.medpStato = msBrowse);

  // filtro dati liberi per inserimento
  AbilitazioneComponente(cmbFiltroDato1,grdChiamate.medpStato = msInsert);
  AbilitazioneComponente(cmbFiltroDato2,grdChiamate.medpStato = msInsert);
end;

procedure TW028FChiamateReperibili.SetDatoLibero(const PDato: String;
  var RDatoV430, RDatoDescV430: String; var RCodLen: Integer;
  PLabelFiltro: TmeIWLabel; PComboFiltro: TmeIWComboBox);
var
  Descr,Tabella,Codice,Storico: String;
begin
  // filtro per dato 1
  PLabelFiltro.Visible:=PDato <> '';
  PComboFiltro.Visible:=PLabelFiltro.Visible;
  if PDato <> '' then
  begin
    RDatoV430:=Format('T430%s',[PDato]);
    A000GetTabella(PDato,Tabella,Codice,Storico);
    if (Tabella <> '') and (Tabella <> 'T430_STORICO') then
      RDatoDescV430:=Format('T430D_%s',[PDato]);

    // impostazione interfaccia
    PLabelFiltro.Caption:=R180Capitalize(PDato);
    PComboFiltro.Items.Clear;
    PComboFiltro.ItemsHaveValues:=RDatoDescV430 <> '';
    PComboFiltro.Items.Add('=');
    RCodLen:=0;
    with WR000DM.selDistAnagrafe do
    begin
      Close;
      if Parametri.CampiRiferimento.C26_HintT030V430 <> '' then
        SQL.Text:=StringReplace(SQL.Text,'SELECT DISTINCT',Format('SELECT %s DISTINCT',[Parametri.CampiRiferimento.C26_HintT030V430]),[rfIgnoreCase]);
      SetVariable('DATALAVORO',Parametri.DataLavoro);
      SetVariable('CAMPO',RDatoV430 + ' CODICE' + IfThen(RDatoDescV430 <> '',',' + RDatoDescV430 + ' DESCRIZIONE'));
      if Parametri.Inibizioni.Text <> '' then
        SetVariable('FILTRO',' AND ' + Parametri.Inibizioni.Text);
      Open;
      // ciclo di popolamento della combo
      while not Eof do
      begin
        if not FieldByName('CODICE').IsNull then
        begin
          if Length(FieldByName('CODICE').AsString) > RCodLen then
            RCodLen:=Length(FieldByName('CODICE').AsString);
          if RDatoDescV430 <> '' then
            Descr:=Format('%-*s - %s',[RCodLen,FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString])
          else
            Descr:=FieldByName('CODICE').AsString;
          PComboFiltro.Items.Add(Format('%s=%s',[Descr,FieldByName('CODICE').AsString]));
        end;
        Next;
      end;
      Close;
    end;
    PComboFiltro.ItemIndex:=0;
  end;
end;

procedure TW028FChiamateReperibili.RefreshPage;
begin
  InizializzaAccesso;
end;

function TW028FChiamateReperibili.ImpostaPeriodo:Boolean;
begin
  Result:=True;
  // data iniziale
  if not TryStrToDate(edtDal.Text,Dal) then
  begin
    Result:=False;
    MsgBox.MessageBox('La data di inizio periodo non è valida',INFORMA);
    edtDal.SetFocus;
    Exit;
  end;
  // data finale
  if not TryStrToDate(edtAl.Text,Al) then
  begin
    Result:=False;
    MsgBox.MessageBox('La data di fine periodo non è valida',INFORMA);
    edtAl.SetFocus;
    Exit;
  end;
  // controllo consecutività periodo
  if Dal > Al then
  begin
    Result:=False;
    MsgBox.MessageBox('Il periodo indicato non è valido',INFORMA);
    edtDal.SetFocus;
    Exit;
  end;
  ParametriForm.Dal:=Dal;
  ParametriForm.Al:=Al;
end;

procedure TW028FChiamateReperibili.btnEseguiClick(Sender: TObject);
begin
  // aggiorna la visualizzazione in base al periodo indicato
  if not ImpostaPeriodo then
    Exit;
  InizializzaAccesso;
end;

procedure TW028FChiamateReperibili.PreparaDatiAnag(const PIndex: Integer);
// prepara il clientdataset per la modifica dei dati anagrafici del dipendente
var
  i: Integer;
begin
  // verifica se è necessario effettuare il popolamento del clientdataset
  if (PIndex <= 0) or (Parametri.CampiRiferimento.C29_ChiamateRepDatiModif = '') then
    Exit;

  // imposta il clientdataset con i valori attuali dei campi da modificare
  for i:=0 to High(ArrDipendenti[PIndex].DatiVisArr) do
  begin
    if W002ModDatiDM.cdsDatiAnag.Locate('CAMPO',ArrDipendenti[PIndex].DatiVisArr[i].CampoV430,[]) then
    begin
      W002ModDatiDM.cdsDatiAnag.Edit;
      W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE').AsString:=ArrDipendenti[PIndex].DatiVisArr[i].Valore;
      W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE_OLD').AsString:=W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE').AsString;
      W002ModDatiDM.cdsDatiAnag.Post;
    end;
  end;
end;

procedure TW028FChiamateReperibili.imgModificaDatiClick(Sender: TObject);
var
  r, idx: Integer;
  Codice, ProgStr, FN: String;
  IWC: TmeIWComboBox;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // estrae dati dipendente e indice array per modifica
  with grdChiamate do
  begin
    r:=medpRigaDiCompGriglia(FN);
    if RecordChiamata.Operazione = 'I' then
    begin
      IWC:=(medpCompCella(r,'DIPENDENTE',0) as TmeIWComboBox);
      Codice:=IWC.Items.ValueFromIndex[IWC.ItemIndex];
      ProgStr:=Copy(Codice,1,Pos('_',Codice) - 1);
      DatiAnag.Nominativo:=Trim(Copy(IWC.Text,1,19)); // parte del nominativo: primi 19 caratteri
    end
    else
    begin
      ProgStr:=medpValoreColonna(r,'PROGRESSIVO_REPER');
      Codice:=Format('%s_%s',[ProgStr,medpValoreColonna(r,'TURNO')]);
      DatiAnag.Nominativo:=medpValoreColonna(r,'DIPENDENTE');
    end;
  end;
  DatiAnag.Progressivo:=StrToIntDef(ProgStr,0);

  // prepara il clientdataset con i dati del dipendente selezionato
  idx:=ArrDipendentiGetIndex(Codice,0,High(ArrDipendenti));
  PreparaDatiAnag(idx);

  // apre il form di modifica dati anagrafici
  if idx > 0 then
  begin
    W028ModDatiFM:=TW002FModificaDatiFM.Create(Self);
    W028ModDatiFM.W002ModDatiDM:=W002ModDatiDM;
    W028ModDatiFM.Progressivo:=DatiAnag.Progressivo;
    W028ModDatiFM.Nominativo:=DatiAnag.Nominativo;
    W028ModDatiFM.ArrIndex:=idx;
    W028ModDatiFM.Visualizza;
  end;
end;

procedure TW028FChiamateReperibili.cmbFiltroDato1Change(Sender: TObject);
begin
  AggiornaFiltro;
end;

procedure TW028FChiamateReperibili.GetDatiTabellari;
// Popolamento strutture dati di supporto per i dati tabellari
// utilizzati nelle chiamate (dipendenti)
var
  i,j,Priorita: Integer;
  Campo: String;
  function Distribuisci(Cognome,Nome: String; const LMax: Integer): String;
  var
    Diff,LCognome,LNome: Integer;
  begin
    LCognome:=Length(Cognome);
    LNome:=Length(Nome);
    Diff:=LMax - LCognome - LNome;
    if Diff < 0 then
    begin
      if LCognome > LNome then
        Cognome:=Copy(Cognome,1,LCognome - Diff)
      else
        Nome:=Copy(Nome,1,LNome - Diff);
    end;
    Result:=Cognome + ' ' + Nome;
  end;
begin
  // array per i dipendenti reperibili
  with W028DM.selT380 do
  begin
    Close;
    SetVariable('DATA',Date);
    SetVariable('ORA',R180OreMinuti(Now));
    Open;
    SetLength(ArrDipendenti,RecordCount + 1);
    i:=1;
    while not Eof do
    begin
      if (DatoLibero1 = '') and (DatoLibero2 = '') then
        ArrDipendenti[i].Visible:=True
      else
      begin
        if DatoLibero1 <> '' then
          ArrDipendenti[i].Visible:=(cmbFiltroDato1.Text = '') or (FieldByName(DatoLibero1).AsString = Copy(cmbFiltroDato1.Text,1,CodLen1));
        if DatoLibero2 <> '' then
          ArrDipendenti[i].Visible:=ArrDipendenti[i].Visible and
                                    ((cmbFiltroDato2.Text = '') or (FieldByName(DatoLibero2).AsString = Copy(cmbFiltroDato2.Text,1,CodLen2)));
      end;
      ArrDipendenti[i].Value:=Format('%s_%s',[FieldByName('PROGRESSIVO').AsString,FieldByName('TURNO').AsString]);
      ArrDipendenti[i].Progressivo:=FieldByName('PROGRESSIVO').AsString;
      ArrDipendenti[i].Matricola:=FieldByName('MATRICOLA').AsString;
      ArrDipendenti[i].Cognome:=FieldByName('COGNOME').AsString;
      ArrDipendenti[i].Nome:=FieldByName('NOME').AsString;
      ArrDipendenti[i].Nominativo:=Distribuisci(ArrDipendenti[i].Cognome,ArrDipendenti[i].Nome,19);
      ArrDipendenti[i].Descrizione:=FieldByName('DESCRIZIONE').AsString;
      ArrDipendenti[i].Turno:=FieldByName('TURNO').AsString;
      ArrDipendenti[i].Dalle:=FieldByName('DALLE').AsString;
      ArrDipendenti[i].Alle:=FieldByName('ALLE').AsString;
      ArrDipendenti[i].DataTurno:=FieldByName('DATA_TURNO').AsDateTime;
      if FieldByName('TURNO').AsString = FieldByName('TURNO1').AsString then
        Priorita:=FieldByName('PRIORITA1').AsInteger
      else if FieldByName('TURNO').AsString = FieldByName('TURNO2').AsString then
        Priorita:=FieldByName('PRIORITA2').AsInteger
      else if FieldByName('TURNO').AsString = FieldByName('TURNO3').AsString then
        Priorita:=FieldByName('PRIORITA3').AsInteger
      else
        Priorita:=0;
      ArrDipendenti[i].Priorita:=Priorita;
      // MONDOEDP - commessa MAN/02 SVILUPPO#119.ini
      ArrDipendenti[i].TollChiamataInizio:=FieldByName('TOLL_CHIAMATA_INIZIO').AsString;
      ArrDipendenti[i].TollChiamataFine:=FieldByName('TOLL_CHIAMATA_FINE').AsString;
      // MONDOEDP - commessa MAN/02 SVILUPPO#119.fine

      // SAVONA_ASL2  - commessa 2013/056 - SVILUPPO 2.ini
      // gestione dati parametrizzati
      if Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
      begin
        // dati da visualizzare
        SetLength(ArrDipendenti[i].DatiVisArr,W002ModDatiDM.LstDatiVis.Count);
        for j:=0 to W002ModDatiDM.LstDatiVis.Count - 1 do
        begin
          Campo:=Format('T430%s',[W002ModDatiDM.LstDatiVis[j]]);
          ArrDipendenti[i].DatiVisArr[j].CampoV430:=Campo;
          ArrDipendenti[i].DatiVisArr[j].Dato:=R180Capitalize(W002ModDatiDM.LstDatiVis[j]);
          ArrDipendenti[i].DatiVisArr[j].Valore:=FieldByName(Campo).AsString;
          if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif = '' then
            ArrDipendenti[i].DatiVisArr[j].Modificabile:=False
          else
            ArrDipendenti[i].DatiVisArr[j].Modificabile:=W002ModDatiDM.LstDatiModif.IndexOf(W002ModDatiDM.LstDatiVis[j]) > -1;
        end;
      end;
      // SAVONA_ASL2  - commessa 2013/056 - SVILUPPO 2.fine

      // dato libero 1
      if DatoLibero1 = '' then
        ArrDipendenti[i].DatoLibero1Valore:=''
      else
        ArrDipendenti[i].DatoLibero1Valore:=FieldByName(DatoLibero1).AsString + IfThen(DatoLibero1Desc <> '',' - ' + FieldByName(DatoLibero1Desc).AsString);

      // dato libero 2
      if DatoLibero2 = '' then
        ArrDipendenti[i].DatoLibero2Valore:=''
      else
        ArrDipendenti[i].DatoLibero2Valore:=FieldByName(DatoLibero2).AsString + IfThen(DatoLibero2Desc <> '',' - ' + FieldByName(DatoLibero2Desc).AsString);

      Next;
      i:=i + 1;
    end;
    Close;
  end;
end;

procedure TW028FChiamateReperibili.AggiornaFiltro;
var
  IWC: TmeIWComboBox;
  Descrizione: String;
  i: Integer;
begin
  GetDatiTabellari;

  // aggiornamento combobox
  if RecordChiamata.Operazione = 'I' then
  begin
    IWC:=(FindComponent('cmbDipendenteIns') as TmeIWComboBox);
    with IWC do
    begin
      Items.Clear;
      for i:=1 to High(ArrDipendenti) do
      begin
        if ArrDipendenti[i].Visible then
        begin
          Descrizione:=Format('%-19s %s-%s ',[ArrDipendenti[i].Nominativo,ArrDipendenti[i].Dalle,ArrDipendenti[i].Alle]);
          if ArrDipendenti[i].Priorita <> 0 then
            Descrizione:=Descrizione + Format('(%d)',[ArrDipendenti[i].Priorita]);
          Items.Add(Descrizione + '=' + ArrDipendenti[i].Value);
        end;
      end;
      lblLegendaFiltri.Caption:=Format('Filtro dipendenti (%d disponibili)',[Items.Count]);
      Items.Insert(0,IfThen(Items.Count = 0,'Nessun dipendente trovato=','Selezionare il dipendente='));
      ItemIndex:=IfThen(Items.Count = 2,1,0); // se c'è un solo dipendente lo seleziona
      dcmbDipendentiChange(IWC);
    end;
  end;
end;

procedure TW028FChiamateReperibili.imgSchedaAnagraficaClick(Sender:TObject);
var
  Matr: String;
  x: Integer;
  IWC: TmeIWComboBox;
begin
  if RecordChiamata.Operazione = 'I' then
  begin
    IWC:=(grdChiamate.medpCompCella(0,'DIPENDENTE',0) as TmeIWComboBox);
    x:=ArrDipendentiGetIndex(IWC.Items.ValueFromIndex[IWC.ItemIndex],0,High(ArrDipendenti));
    if x > 0 then
      Matr:=ArrDipendenti[x].Matricola
    else
      Matr:='';
  end
  else
    Matr:=VarToStr(cdsT390.Lookup('DBG_ROWID',(Sender as TmeIWImageFile).FriendlyName,'MATRICOLA'));
  if Matr <> '' then
  begin
    WC002FM:=TWC002FDatiAnagraficiFM.Create(Self);
    WC002FM.ParMatricola:=Matr;
    WC002FM.AllowClick:=True;
    WC002FM.VisualizzaScheda;
  end;
end;

procedure TW028FChiamateReperibili.imgAnnullaClick(Sender:TObject);
// Annulla: annulla le modifiche apportate nei componenti editabili
begin
  DBGridColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);
  RecordChiamata.Operazione:='';
  grdChiamate.medpStato:=msBrowse;
  btnEseguiClick(Sender);
end;

procedure TW028FChiamateReperibili.imgInserisciClick(Sender:TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if (RecordChiamata.Operazione <> '') then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione di ' + IfThen(RecordChiamata.Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!',INFORMA);
    Exit;
  end;
  DBGridColumnClick(Sender,FN);

  // imposta dati per inserimento
  RecordChiamata.Operazione:='I';
  RecordChiamata.Data:=Now;
  RecordChiamata.Operatore:=Parametri.Operatore;

  // imposta tabella
  with grdChiamate do
  begin
    medpBrowse:=False;
    medpStato:=msInsert;
    //Nascondo il pulsante inserisci e visualizzo annulla/conferma
    with (medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,0].Css:='invisibile';
      Cell[0,1].Css:=StileCella1;
      Cell[0,2].Css:=StileCella2;
    end;
    with (medpCompGriglia[0].CompColonne[ColSchedaAnag] as TmeIWGrid) do
    begin
      // scheda anagrafica
      Cell[0,0].Css:=StileCella3;
      // modifica dati
      if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        Cell[0,1].Css:=StileCella1;
    end;
  end;
  GetDatiTabellari;
  CreaComponentiRiga(0);
end;

procedure TW028FChiamateReperibili.imgModificaClick(Sender:TObject);
// modifica della riga
var
  FN: String;
begin
  if (RecordChiamata.Operazione = 'I') or (RecordChiamata.Operazione = 'M') then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione di ' + IfThen(RecordChiamata.Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!',INFORMA);
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);
  RecordChiamata.Operazione:='M';
  GetDatiTabellari;
  TrasformaComponenti(FN);
  grdChiamate.medpBrowse:=False;
  grdChiamate.medpStato:=msEdit;
end;

procedure TW028FChiamateReperibili.imgConfermaClick(Sender:TObject);
// applica le modifiche
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);

  // valuta aggiornamento dati anagrafici
  // (effettuato indipendentemente dalla chiamata in reperibilità)
  if DatiAnag.Modificato then
  begin
    try
      W002ModDatiDM.updDatiAnag.Execute;
      SessioneOracle.Commit;
      Notifica('Informazione',Format('I dati anagrafici di <b>%s</b> sono stati modificati con decorrenza %s',
                                     [DatiAnag.Nominativo,DateToStr(DatiAnag.Decorrenza)]),
               '',False,False,5000);
    except
      on E: Exception do
      begin
        Notifica('Avviso',Format('Le modifiche ai dati anagrafici di <b>%s</b> non sono state aggiornate:%s%s',
                                 [DatiAnag.Nominativo,CRLF,E.Message]),
                 '',False,True);
      end;
    end;

    // pulizia info dati anagrafici
    DatiAnag.Progressivo:=0;
    DatiAnag.Decorrenza:=DATE_NULL;
    DatiAnag.Nominativo:='';
    DatiAnag.Modificato:=False;
  end;

  if (RecordChiamata.Operazione = 'M') then
  begin
    // nessuna operazione da effettuare se non sono state apportate modifiche alla riga
    if not ModificheRiga(FN) then
    begin
      RecordChiamata.Operazione:='';
      grdChiamate.medpStato:=msBrowse;
      btnEseguiClick(Sender);
      Exit;
    end;
    // se il record non esiste -> errore
    if not W028DM.selT390.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      RecordChiamata.Operazione:='';
      grdChiamate.medpStato:=msBrowse;
      MsgBox.MessageBox('Errore durante la modifica della chiamata:' + CRLF + 'il record non è più disponibile!',INFORMA);
      btnEseguiClick(Sender);
      Exit;
    end;
  end;

  // effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;

  // inserimento / aggiornamento
  if RecordChiamata.Operazione = 'I' then
    actInserimentoOK
  else
    actVariazioneOK;

  // ripristina stato browse
  RecordChiamata.Operazione:='';
  grdChiamate.medpStato:=msBrowse;
end;

procedure TW028FChiamateReperibili.CreaComponentiRiga(R:Integer);
var
  i,c:Integer;
  FN,Descrizione:String;
begin
  FN:=grdChiamate.medpValoreColonna(R,'DBG_ROWID');
  // Dipendente
  if RecordChiamata.Operazione = 'I' then
  begin
    c:=grdChiamate.medpIndexColonna('DIPENDENTE');
    grdChiamate.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'35','','','','S');
    grdChiamate.medpCreaComponenteGenerico(R,c,grdChiamate.Componenti);
    with (grdChiamate.medpCompCella(R,c,0) as TmeIWComboBox) do
    begin
      Name:='cmbDipendenteIns';
      Css:=Css + ' font_ridotto';
      FriendlyName:=FN;
      ItemsHaveValues:=True;
      Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
      for i:=1 to High(ArrDipendenti) do
      begin
        Descrizione:=Format('%-19s %s-%s ',[ArrDipendenti[i].Nominativo,ArrDipendenti[i].Dalle,ArrDipendenti[i].Alle]);
        if ArrDipendenti[i].Priorita <> 0 then
          Descrizione:=Descrizione + Format('(%d)',[ArrDipendenti[i].Priorita]);
        Items.Add(Format('%s' + NAME_VALUE_SEPARATOR + '%s',[Descrizione,ArrDipendenti[i].Value]));
      end;
      OnChange:=dcmbDipendentiChange;
      lblLegendaFiltri.Caption:=Format('Filtro dipendenti (%d disponibili)',[Items.Count]);
      Items.Insert(0,IfThen(Items.Count = 0,'Nessun dipendente trovato' + NAME_VALUE_SEPARATOR,'Selezionare il dipendente' + NAME_VALUE_SEPARATOR));
      ItemIndex:=IfThen(Items.Count = 2,1,0); // se c'è un solo dipendente lo seleziona
    end;
  end;

  // info dipendente
  grdChiamate.medpPreparaComponenteGenerico('C',0,0,DBG_TXT,'','','','','S');
  grdChiamate.medpCreaComponenteGenerico(R,ColInfoDip,grdChiamate.Componenti);
  grdChiamate.medpCompGriglia[R].CompColonne[ColInfoDip].FriendlyName:=FN;
  with (grdChiamate.medpCompCella(R,ColInfoDip,0) as TmeIWText) do
  begin
    Text:='';
  end;

  // richiama evento change per aggiornare info dipendente
  if RecordChiamata.Operazione = 'I' then
    dcmbDipendentiChange(grdChiamate.medpCompCella(R,'DIPENDENTE',0));

  // esito
  c:=grdChiamate.medpIndexColonna('D_ESITO');
  grdChiamate.medpPreparaComponenteGenerico('C',0,0,DBG_RGP,'100%','Trovato,"Non trovato",Annullato','','','');
  grdChiamate.medpCreaComponenteGenerico(R,c,grdChiamate.Componenti);
  grdChiamate.medpCompGriglia[R].CompColonne[c].FriendlyName:=FN;

  // note
  c:=grdChiamate.medpIndexColonna('NOTE');
  grdChiamate.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'40','','','','S');
  grdChiamate.medpCreaComponenteGenerico(R,c,grdChiamate.Componenti);
  grdChiamate.medpCompGriglia[R].CompColonne[c].FriendlyName:=FN;
  with (grdChiamate.medpCompCella(R,c,0) as TmeIWMemo) do
  begin
    Text:='';
  end;
end;

procedure TW028FChiamateReperibili.dcmbDipendentiChange(Sender:TObject);
var
  r,c,x: Integer;
  IWC: TmeIWComboBox;
begin
  r:=grdChiamate.medpRigaDiCompGriglia((Sender as TmeIWComboBox).FriendlyName);
  c:=grdChiamate.medpIndexColonna('DIPENDENTE');

  // estrae info dipendente selezionato dall'array di dati
  IWC:=(grdChiamate.medpCompCella(r,c,0) as TmeIWComboBox);
  x:=ArrDipendentiGetIndex(IWC.Items.ValueFromIndex[IWC.ItemIndex],0,High(ArrDipendenti));
  if x >= 0 then
  begin
    if RecordChiamata.Operazione = 'I' then
    begin
      RecordChiamata.Turno:=ArrDipendenti[x].Turno;
      RecordChiamata.DataTurno:=ArrDipendenti[x].DataTurno;
    end;

    // aggiorna info dipendente
    with (grdChiamate.medpCompCella(r,ColInfoDip,1) as TmeIWText) do
    begin
      Text:=ArrDipendentiGetText(x);
      RawText:=True;
    end;
  end;
end;

procedure TW028FChiamateReperibili.TrasformaComponenti(const FN:String);
// Trasforma i componenti della riga indicata da text a control e
// viceversa per la grid grdChiamate
var
  DaTestoAControlli:Boolean;
  Esito:String;
  i,c:Integer;
begin
  i:=grdChiamate.medpRigaDiCompGriglia(FN);
  c:=grdChiamate.medpIndexColonna('NOTE');
  DaTestoAControlli:=grdChiamate.medpCompGriglia[i].CompColonne[c] = nil;

  // immagine per cancellazione / annullamento operazione
  with (grdChiamate.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
  begin
    Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
    Cell[0,1].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
    Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
  end;

  // scheda anagrafica
  with (grdChiamate.medpCompGriglia[i].CompColonne[ColSchedaAnag] as TmeIWGrid) do
  begin
    // scheda anagrafica
    Cell[0,0].Css:=IfThen((not DaTestoAControlli) and grdChiamate.medpRigaInserimento and (i = 0),'invisibile',StileCella3);

    // modifica dati
    if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
      Cell[0,1].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
  end;

  if DaTestoAControlli then
  begin
    CreaComponentiRiga(i);
    //Impostazione item index
    Esito:=grdChiamate.medpValoreColonna(i,'D_ESITO');
    (grdChiamate.medpCompCella(i,'D_ESITO',0) as TmeTIWAdvRadioGroup).ItemIndex:=
      IfThen(Esito = 'Trovato',0,IfThen(Esito = 'Non trovato',1,2));
    (grdChiamate.medpCompCella(i,'NOTE',0) as TmeIWMemo).Text:=grdChiamate.medpValoreColonna(i,'NOTE');
  end
  else
  begin
    // Annullamento componenti
    c:=grdChiamate.medpIndexColonna('DATA');
    if grdChiamate.medpCompGriglia[i].CompColonne[c] <> nil then
      FreeAndNil(grdChiamate.medpCompGriglia[i].CompColonne[c]);
    //FreeAndNil(grdChiamate.medpCompGriglia[i].CompColonne[ColSchedaAnag]);
    FreeAndNil(grdChiamate.medpCompGriglia[i].CompColonne[ColInfoDip]);
    c:=grdChiamate.medpIndexColonna('D_ESITO');
    FreeAndNil(grdChiamate.medpCompGriglia[i].CompColonne[c]);
    c:=grdChiamate.medpIndexColonna('NOTE');
    FreeAndNil(grdChiamate.medpCompGriglia[i].CompColonne[c]);
  end;
end;

function TW028FChiamateReperibili.ModificheRiga(const FN:String):Boolean;
// Restituisce True/False a seconda che il record sia stato modificato o meno
var
  i,c,idxEsito:Integer;
  DescEsito: String;
begin
  Result:=False;
  i:=grdChiamate.medpRigaDiCompGriglia(FN);

  // indice del radiogroup "esito"
  c:=grdChiamate.medpIndexColonna('D_ESITO');
  idxEsito:=(grdChiamate.medpCompCella(i,c,0) as TmeTIWAdvRadioGroup).ItemIndex;

  // esito
  DescEsito:=VarToStr(cdsT390.Lookup('DBG_ROWID',FN,'D_ESITO'));

  if (VarToStr(cdsT390.Lookup('DBG_ROWID',FN,'DIPENDENTE')) <> grdChiamate.medpValoreColonna(i,'DIPENDENTE')) or
     ((DescEsito = 'Trovato') and
      (idxEsito <> 0)) or
     ((DescEsito = 'Non trovato') and
      (idxEsito <> 1)) or
     ((DescEsito = 'Annullato') and
      (idxEsito <> 2)) or
     (VarToStr(cdsT390.Lookup('DBG_ROWID',FN,'NOTE')) <> (grdChiamate.medpCompCella(i,'NOTE',0) as TmeIWMeMo).Text) then
    Result:=True;
end;

procedure TW028FChiamateReperibili.Notification(AComponent: TComponent; Operation: TOperation);
var
  i: Integer;
  Campo: String;
  IWC: TmeIWComboBox;
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    // chiusura frame modifica dati
    if AComponent = W028ModDatiFM then
    begin
      IWC:=nil;

      // se la stringa di update è valorizzata, aggiorna i dati anagrafici
      DatiAnag.Modificato:=W028ModDatiFM.UpdateString <> '';
      if DatiAnag.Modificato then
      begin
        // blocca la modifica del dipendente
        if RecordChiamata.Operazione = 'I' then
        begin
          IWC:=(FindComponent('cmbDipendenteIns') as TmeIWComboBox);
          if Assigned(IWC) then
            AbilitazioneComponente(IWC,False);
        end;

        // salva info decorrenza
        DatiAnag.Decorrenza:=W028ModDatiFM.Decorrenza;

        // aggiornamento array per visualizzazione
        for i:=0 to W002ModDatiDM.LstDatiVis.Count - 1 do
        begin
          Campo:=Format('T430%s',[W002ModDatiDM.LstDatiVis[i]]);
          if ArrDipendenti[W028ModDatiFM.ArrIndex].DatiVisArr[i].Modificabile then
            ArrDipendenti[W028ModDatiFM.ArrIndex].DatiVisArr[i].Valore:=VarToStr(W002ModDatiDM.cdsDatiAnag.Lookup('CAMPO',Campo,'VALORE'));
        end;

        // in caso di inserimento fa scattare l'evento onchange della combo dipendente
        // per aggiornare i valori
        if RecordChiamata.Operazione = 'I' then
        begin
          dcmbDipendentiChange(IWC);
        end;

        // prepara update
        with W002ModDatiDM.updDatiAnag do
        begin
          SetVariable('PROGRESSIVO',W028ModDatiFM.Progressivo);
          SetVariable('DECORRENZA',W028ModDatiFM.Decorrenza);
          SetVariable('SET_VALORI',W028ModDatiFM.UpdateString);
        end;
      end;
      W028ModDatiFM:=nil;
    end;
  end;
end;

function TW028FChiamateReperibili.ControlliOK(const FN:String):Boolean;
var
  i,idxEsito: Integer;
  IWC: TmeIWComboBox;
  ProgRep: String;
begin
  Result:=False;
  i:=grdChiamate.medpRigaDiCompGriglia(FN);
  with grdChiamate do
  begin
    // imposta variabili per inserimento / aggiornamento
    if RecordChiamata.Operazione = 'I' then
    begin
      IWC:=(grdChiamate.medpCompCella(i,'DIPENDENTE',0) as TmeIWComboBox);
      ProgRep:=IWC.Items.ValueFromIndex[IWC.ItemIndex];
      ProgRep:=Copy(ProgRep,1,Pos('_',ProgRep) - 1);
      RecordChiamata.ProgReper:=StrToIntDef(ProgRep,0);
    end;

    // esito
    idxEsito:=(grdChiamate.medpCompCella(i,'D_ESITO',0) as TmeTIWAdvRadioGroup).ItemIndex;
    if idxEsito = 0 then
      RecordChiamata.Esito:='S'
    else if idxEsito = 1 then
      RecordChiamata.Esito:='N'
    else
      RecordChiamata.Esito:='A';

    // note
    RecordChiamata.Note:=Trim((grdChiamate.medpCompCella(i,'NOTE',0) as TmeIWMemo).Text);

    if (RecordChiamata.Operazione = 'I') and (RecordChiamata.ProgReper = 0) then
    begin
      MsgBox.MessageBox('Indicare il dipendente reperibile che è stato chiamato!',INFORMA);
      try
        (grdChiamate.medpCompCella(i,'DIPENDENTE',0) as TmeIWComboBox).SetFocus;
      except
      end;
      Exit;
    end;
  end;
  // verifiche sulla base dati
  with WR000DM do
  begin
    // verifica chiamata già esistente (in base a inserimento / variazione)
    if RecordChiamata.Operazione = 'I' then
    begin
      if QueryPK1.EsisteChiave('T390_CHIAMATE_REPERIB','',dsInsert,['DATA','UTENTE','PROGRESSIVO_REPER'],
         [DateToStr(RecordChiamata.Data),RecordChiamata.Operatore,IntToStr(RecordChiamata.ProgReper)]) then
      begin
        MsgBox.MessageBox('Chiamata già esistente!',INFORMA);
        Exit;
      end
    end
    else
    begin
      if QueryPK1.EsisteChiave('T390_CHIAMATE_REPERIB',W028DM.selT390.RowID,dsEdit,['DATA','UTENTE','PROGRESSIVO_REPER'],
        [DateToStr(RecordChiamata.Data),RecordChiamata.Operatore,IntToStr(RecordChiamata.ProgReper)]) then
      begin
        MsgBox.MessageBox('Chiamata già esistente!',INFORMA);
        Exit;
      end
    end;
  end;
  // controlli ok
  Result:=True;
end;

procedure TW028FChiamateReperibili.actInserimentoOK;
// controlli ok -> inserimento record di pianificazione
begin
  with W028DM.selT390 do
  begin
    Append;
    FieldByName('DATA').AsDateTime:=RecordChiamata.Data;
    FieldByName('UTENTE').AsString:=RecordChiamata.Operatore;
    FieldByName('PROGRESSIVO_REPER').AsInteger:=RecordChiamata.ProgReper;
    FieldByName('ESITO').AsString:=RecordChiamata.Esito;
    FieldByName('NOTE').AsString:=RecordChiamata.Note;
    FieldByName('TURNO').AsString:=RecordChiamata.Turno;
    FieldByName('DATA_TURNO').AsDateTime:=RecordChiamata.DataTurno;
    try
      RegistraLog.SettaProprieta('I','T390_CHIAMATE_REPERIB',medpCodiceForm,nil,True);
      Post;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      on E:Exception do
        MsgBox.MessageBox('Inserimento della chiamata fallito!' + CRLF + 'Motivo: ' + E.Message,INFORMA);
    end;
  end;
  // rilegge i dati
  InizializzaAccesso;
end;

procedure TW028FChiamateReperibili.actVariazioneOK;
// controlli ok -> variazione record di pianificazione
begin
  with W028DM.selT390 do
  begin
    Edit;
    FieldByName('ESITO').AsString:=RecordChiamata.Esito;
    FieldByName('NOTE').AsString:=RecordChiamata.Note;
    try
      RegistraLog.SettaProprieta('M','T390_CHIAMATE_REPERIB',medpCodiceForm,nil,True);
      Post;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      on E:Exception do
        MsgBox.MessageBox('Variazione della chiamata fallita!' + CRLF + 'Motivo: ' + E.Message,INFORMA);
    end;
  end;
  // rilegge i dati
  InizializzaAccesso;
end;

procedure TW028FChiamateReperibili.grdChiamateAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i:Integer;
begin
  for i:=1 to High(grdChiamate.medpCompGriglia) do
    (grdChiamate.medpCompCella(i,ColSchedaAnag,0) as TmeIWImageFile).OnClick:=imgSchedaAnagraficaClick;

  if (not SolaLettura) then
  begin
    if StileCella1 = '' then
    begin
      with (grdChiamate.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        StileCella1:=Cell[0,0].Css;
        StileCella2:=Cell[0,2].Css;
      end;
      StileCella3:=(grdChiamate.medpCompGriglia[0].CompColonne[ColSchedaAnag] as TmeIWGrid).Cell[0,0].Css;
    end;

    //Riga di inserimento
    (grdChiamate.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
    (grdChiamate.medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
    (grdChiamate.medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgConfermaClick;
    with (grdChiamate.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,1].Css:='invisibile';
      Cell[0,2].Css:='invisibile';
    end;
    // scheda anagrafica e modifica dati anagrafici
    (grdChiamate.medpCompCella(0,ColSchedaAnag,0) as TmeIWImageFile).OnClick:=imgSchedaAnagraficaClick;
    if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
      (grdChiamate.medpCompCella(0,ColSchedaAnag,1) as TmeIWImageFile).OnClick:=imgModificaDatiClick;
    with (grdChiamate.medpCompGriglia[0].CompColonne[ColSchedaAnag] as TmeIWGrid) do
    begin
      Cell[0,0].Css:='invisibile';
      if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        Cell[0,1].Css:='invisibile';
    end;

    //Righe dati
    for i:=1 to High(grdChiamate.medpCompGriglia) do
    begin
      if Parametri.Operatore <> grdChiamate.medpValoreColonna(i,'UTENTE') then
      begin
        FreeAndNil(grdChiamate.medpCompGriglia[i].CompColonne[0]);
      end
      else
      begin
        //Associo l'evento OnClick alle Icone
        (grdChiamate.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgModificaClick;
        (grdChiamate.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
        (grdChiamate.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgConfermaClick;
        with (grdChiamate.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
        begin
          Cell[0,1].Css:='invisibile';
          Cell[0,2].Css:='invisibile';
        end;
        if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        begin
          (grdChiamate.medpCompCella(i,ColSchedaAnag,1) as TmeIWImageFile).OnClick:=imgModificaDatiClick;
          with (grdChiamate.medpCompGriglia[i].CompColonne[ColSchedaAnag] as TmeIWGrid) do
            Cell[0,1].Css:='invisibile';
        end;
      end;
    end;
  end;
end;

procedure TW028FChiamateReperibili.grdChiamateRenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer);
var
  NumColonna: Integer;
  NomeCampo, Val: String;
begin
  if not grdChiamate.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdChiamate.medpNumColonna(AColumn);
  NomeCampo:=grdChiamate.medpColonna(NumColonna).DataField;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdChiamate.medpCompGriglia) + 1) and (grdChiamate.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdChiamate.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  if ARow > 0 then
  begin
    if NomeCampo = 'DATA' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if NomeCampo = 'SCHANAGR' then
    begin
      {if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        Cell[0,1].Css:='invisibile';
        }
    end
    else if NomeCampo = 'D_INFO' then
    begin
      // informazioni dipendente
      ACell.Css:=ACell.Css + ' info_dipendente gridTrasparente';
      Val:=Format('%s_%s',[grdChiamate.medpValoreColonna(ARow - 1,'PROGRESSIVO_REPER'),
                           grdChiamate.medpValoreColonna(ARow - 1,'TURNO')]);
      ACell.Text:=ArrDipendentiGetDesc(Val,0,High(ArrDipendenti));
      ACell.RawText:=True;
    end
    else if NomeCampo = 'D_ESITO' then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if NomeCampo = 'NOTE' then
    begin
      if (ACell.Control = nil) and
         (Length(ACell.Text) > 40) then
      begin
        ACell.Hint:=grdChiamate.medpValoreColonna(ARow - 1,'NOTE');
        ACell.Text:=Copy(ACell.Text,1,40) + ' [...]';
      end
      else
        ACell.Hint:='';
      ACell.ShowHint:=True;
    end;
  end;
end;

function TW028FChiamateReperibili.ArrDipendentiGetDesc(const Codice:String;p,r:Integer):String;
var x:Integer;
begin
  x:=ArrDipendentiGetIndex(Codice,p,r);
  Result:=ArrDipendentiGetText(x);
end;

function TW028FChiamateReperibili.ArrDipendentiGetText(const PIndex: Integer): String;
// estrae il testo da visualizzare nella cella D_INFO
// con la tabella html contenente le informazioni del dipendente
var
  i,Priorita: Integer;
  Dato, Turno: String;
begin
  // selezionando il primo elemento (indice = 0) il testo restituito è ''
  if (PIndex <= 0) or (PIndex > High(ArrDipendenti)) then
  begin
    Result:='';
    Exit;
  end;

  // variabili di appoggio
  Priorita:=ArrDipendenti[PIndex].Priorita;
  Turno:=ArrDipendenti[PIndex].Descrizione + IfThen(Priorita <> 0,Format(' (%d)',[Priorita]));

  // compone l'informazione da visualizzare
  Result:=Format('<table><tbody>' +
                 '<tr><td>Turno:</td><td>%s</td></tr>',[Turno]);
  // MONDOEDP - commessa MAN/02 SVILUPPO#119.ini
  {
  // info su tolleranza in entrata e uscita sul turno
  if R180OreMinutiExt(ArrDipendenti[PIndex].TollChiamataInizio) > 0 then
    Result:=Result + Format('<tr><td>Tolleranza entrata:</td><td>%s</td></tr>',[ArrDipendenti[PIndex].TollChiamataInizio]);
  if R180OreMinutiExt(ArrDipendenti[PIndex].TollChiamataFine) > 0 then
    Result:=Result + Format('<tr><td>Tolleranza uscita:</td><td>%s</td></tr>',[ArrDipendenti[PIndex].TollChiamataFine]);
  }
  // MONDOEDP - commessa MAN/02 SVILUPPO#119.fine

  // gestione dati parametrizzati
  if Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
  begin
    // dati da visualizzare
    for i:=0 to W002ModDatiDM.LstDatiVis.Count - 1 do
    begin
      Dato:=ArrDipendenti[PIndex].DatiVisArr[i].Dato;
      if ArrDipendenti[PIndex].DatiVisArr[i].Modificabile then
      begin
        if WR000DM.cdsI010.Locate('NOME_CAMPO',ArrDipendenti[PIndex].DatiVisArr[i].CampoV430,[]) then
        begin
          if WR000DM.cdsI010.FieldByName('ACCESSO').AsString <> 'N' then
          begin
            if WR000DM.cdsI010.FieldByName('ACCESSO').AsString = 'S' then
              Dato:=Format('<abbr title="Dato modificabile">%s</abbr>',[Dato]);
            Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',[Dato,ArrDipendenti[PIndex].DatiVisArr[i].Valore]);
          end;
        end;
      end;
    end;
  end;

  // dato libero 1
  if DatoLibero1 <> '' then
  begin
    Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr> ',
                            [R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1),
                             ArrDipendenti[PIndex].DatoLibero1Valore]);
  end;

  // dato libero 2
  if DatoLibero2 <> '' then
  begin
    Result:=Result + Format('<tr><td>%s:</td> <td>%s</td></tr> ',
                            [R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2),
                            ArrDipendenti[PIndex].DatoLibero2Valore]);
  end;
  Result:=Result + '</tbody></table>';
end;

function TW028FChiamateReperibili.ArrDipendentiGetIndex(const Codice:String;p,r:Integer):Integer;
var
  q,Res:Integer;
begin
  Res:=-1;

  if (p < r) then
  begin
    q:=p;
    if (Codice <> ArrDipendenti[q].Value) then
      Res:=ArrDipendentiGetIndex(Codice,q + 1,r);
    if (Codice = ArrDipendenti[q].Value) then
      Res:=q;
  end
  else if p = r then
  begin
    if ArrDipendenti[p].Value = Codice then
      Res:=p
  end
  else
    Res:=-1;

  Result:=Res;
end;

procedure TW028FChiamateReperibili.DBGridColumnClick(ASender:TObject; const AValue:string);
begin
  inherited;
  cdsT390.Locate('DBG_ROWID',AValue,[]);
end;

procedure TW028FChiamateReperibili.DistruggiOggetti;
begin
  if Assigned(W028ModDatiFM) then
    try FreeAndNil(W028ModDatiFM); except end;
  FreeAndNil(W028DM);
  FreeAndNil(W002ModDatiDM);
  grdChiamate.medpClearCompGriglia;
  SetLength(ArrDipendenti,0);
end;

procedure TW028FChiamateReperibili.rgpTipoEsitoClick(Sender: TObject);
begin
  InizializzaAccesso;
end;

procedure TW028FChiamateReperibili.rgpTipoUtenteClick(Sender: TObject);
begin
  InizializzaAccesso;
end;

end.
