unit W004UReperibilita;

interface

uses
  W002UModificaDatiDM, W002UModificaDatiFM,
  WC002UDatiAnagraficiFM, R010UPaginaWeb, IWApplication,
  A000USessione, A000UInterfaccia, A000UMessaggi, A000UCostanti,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  DatiBloccati, Math, StrUtils, Oracle, OracleData, DB, DBClient,
  Classes, Graphics, Controls, SysUtils, IWControl, IWHTMLControls, IWCompEdit,
  IWCompListbox, IWCompCheckbox, Variants, IWVCLBaseControl, Forms,
  medpIWMultiColumnComboBox, IWDBGrids, meIWGrid, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, meIWLink, meIWLabel, meIWComboBox,
  meIWCheckBox, meIWButton, meIWEdit, IWCompExtCtrls, IWCompGrids,
  meIWImageFile, IWAdvRadioGroup, meTIWAdvRadioGroup, IWCompButton,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompLabel, IWBaseControl,
  IWBaseHTMLControl, medpIWTabControl, IWHTMLContainer, IWHTML40Container,
  IWRegion, meIWRegion, W004UReperibilitaDM, W004UModificaTabelloneFM,
  W004ULegendaColoriFM, W000UMessaggi;

const
  NRIGHEBLOCCATE = 1;
  NCOLONNEBLOCCATE = 3;

type
  TW004FReperibilita = class(TR010FPaginaWeb)
    lnkDipendentiDisponibili: TmeIWLink;
    cmbDipendentiDisponibili: TmeIWComboBox;
    lblPeriodoDal: TmeIWLabel;
    edtPeriodoDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtPeriodoAl: TmeIWEdit;
    btnEsegui: TmeIWButton;
    chkNonContDipPian: TmeIWCheckBox;
    rgpTipologia: TmeTIWAdvRadioGroup;
    lblPeriodo: TmeIWLabel;
    rgpOrdinamento: TmeTIWAdvRadioGroup;
    W004DettaglioRG: TmeIWRegion;
    grdReperibilita: TmedpIWDBGrid;
    dsrT380: TDataSource;
    cdsT380: TClientDataSet;
    tpProspetto: TIWTemplateProcessorHTML;
    DLista: TDataSource;
    W004ProspettoRG: TmeIWRegion;
    grdProspetto: TmedpIWDBGrid;
    tpDettaglio: TIWTemplateProcessorHTML;
    tabReperibilita: TmedpIWTabControl;
    lnkLegendaColoriGiorni: TmeIWLink;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure lnkDipendentiDisponibiliClick(Sender: TObject);
    procedure rgpTipologiaClick(Sender: TObject);
    procedure grdReperibilitaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdReperibilitaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure cmbTurnoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure IWAppFormAfterRender(Sender: TObject);
    procedure grdProspettoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdProspettoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure IWAppFormRender(Sender: TObject);
    procedure lnkTurnoClick(Sender: TObject);
    procedure lnkLegendaColoriGiorniClick(Sender: TObject);
    procedure tabReperibilitaTabControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure tabReperibilitaTabControlChange(Sender: TObject);
  private
    Dal,Al:TDateTime;
    selAnagrafe:TOracleDataSet;
    StileCella1,
    StileCella2,
    DatoLibero1,
    DatoLibero1Desc,
    DatoLibero2,
    DatoLibero2Desc: String;
    // variabili per controlli
    ErrMessage: String;
    ErrBloccante:Boolean;
    M,T1,T2,T3,DL: String;
    P1,P2,P3: Integer;
    T1a,T2a,T3a: String;
    Progressivo: Integer;
    Data: TDateTime;
    // variabili generali
    Tipologia: String;
    Operazione: String;
    ColSchedaAnag{,ColInfoDip}: Integer;
    WC002FDatiAnagraficiFM: TWC002FDatiAnagraficiFM;
    W002ModDatiDM: TW002FModificaDatiDM;
    W002ModDatiFM: TW002FModificaDatiFM;
    DatiAnag: TDatiAnag;
    W004DM: TW004FReperibilitaDM;
    W004FModTabFM: TW004FModificaTabelloneFM;
    W004FLegendaColoriFM: TW004FLegendaColoriFM;
    FiltroDip:String;
    MaxLenTurno: Integer;
    OldTabIndex:Integer;
    procedure GetDatiLiberi;
    procedure GetDipendentiDisponibili;
    procedure TrasformaComponenti(const FN:String);
    procedure TrasformaComponentiInserimento;
    procedure CaricaTurniDettaglio;
    procedure CaricaTurniTabellone;
    procedure CaricaListaTabellone;
    procedure VisualizzaGrigliaTabellone;
    function  ModificheRiga(const FN: String): Boolean;
    function  ControlliOK(const FN:String): Boolean;
    procedure TurniIntersecati(T1, T2:String);
    procedure TurniIntersecatiTipologieDiverse(T1,T2:String; DataRif:TDateTime);
    function  RaggruppamentiAbilitati(Prog:Integer; DataRif:TDateTime): Boolean;
    function  GiornataAssenza(Data:TDateTime; Progressivo: Integer): Boolean;
    function  TurnoNonInserito(C1,C2,C3:String; Data:TDateTime; Prog:Integer):Boolean;
    procedure actInsVar0;
    procedure actInsVar1;
    procedure actInsVar2;
    procedure actInsVar3;
    procedure actInsVar4;
    procedure actInsVar5;
    procedure actInsVar6;
    procedure actInsVar7;
    procedure actInsVar8;
    procedure actInsVar9;
    procedure actInsVar10;
    procedure actInsVar11;
    procedure actInsVar12;
    procedure actInsVar13;
    procedure actInserimentoOK;
    procedure actVariazioneOK;
    procedure actCancellazioneOK(FN:String);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgModificaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgInserisciClick(Sender: TObject);
    procedure imgConfermaInserimentoClick(Sender: TObject);
    procedure ControlloVincoliIndividuali(TurnoVincoli:String);
    procedure imgModificaDatiClick(Sender: TObject);
    function  GetInfoDip: String;
    procedure PreparaDatiAnag;
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    function  GetProgressivo: Integer; override;
    function  GetInfoFunzione: String; override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    grdModifica: TmedpIWDBGrid;
    DatoLiberoCodLen: Integer;
    lstDatoLibero,lstTurniDisponibili:TStringList;
    function  InizializzaAccesso:Boolean; override;
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure OnTabChanging(var AllowChange: Boolean; var Conferma: String); override;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
    procedure GetTurniPianificati;
    procedure Cancellazione(FN: String);
    procedure Inserimento;
    procedure Modifica(FN: String);
  end;

implementation

uses W001UIrisWebDtM;

{$R *.DFM}

procedure TW004FReperibilita.IWAppFormCreate(Sender: TObject);
var
  S: String;
begin
  inherited;
  AddScrollBarManager('divscrollable');
  // SAVONA_ASL2  - commessa 2013/056 - SVILUPPO 2.ini
  W002ModDatiDM:=TW002FModificaDatiDM.Create(Self);
  // SAVONA_ASL2  - commessa 2013/056 - SVILUPPO 2.fine

  // verifica le abilitazioni della funzione (W002) Scheda anagrafica (tag 412)
  if A000GetInibizioni('Tag','412') <> 'N' then
    lnkDipendentiDisponibili.OnClick:=lnkDipendentiDisponibiliClick
  else
    lnkDipendentiDisponibili.OnClick:=nil;

  W004DM:=TW004FReperibilitaDM.Create(Self);

  // inizializzazione dati
  Dal:=R180InizioMese(Parametri.DataLavoro);
  Al:=R180FineMese(Parametri.DataLavoro);
  edtPeriodoDal.Text:=DateToStr(Dal);
  edtPeriodoAl.Text:=DateToStr(Al);
  selAnagrafe:=TOracleDataSet.Create(Self);
  selAnagrafe.Session:=WR000DM.selAnagrafe.Session;
  selAnagrafe.SQL.Assign(WR000DM.selAnagrafe.SQL);
  selAnagrafe.SQL[0]:='SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE FROM';
  selAnagrafe.Variables.Assign(WR000DM.selAnagrafe.Variables);

  // inizializzazione griglia di inserimento
  lstDatoLibero:=TStringList.Create;
  lstDatoLibero.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  lstTurniDisponibili:=TStringList.Create;
  if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
  begin
    // reperimento dato libero e popolamento combobox relativa
    lstDatoLibero.Clear;
    with WR000DM do
    begin
      if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,selDatoLibero) then
      begin
        lstDatoLibero.Add('');
        if selDatoLibero.VariableIndex('DECORRENZA') >= 0 then
          selDatoLibero.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
        with selDatoLibero do
        begin
          Open;
          First;
          DatoLiberoCodLen:=0;
          while not Eof do
          begin
            if Length(FieldByName('CODICE').AsString) > DatoLiberoCodLen then
              DatoLiberoCodLen:=Length(FieldByName('CODICE').AsString);
            Next;
          end;
          First;
          // ciclo di popolamento della combo
          while not Eof do
          begin
            S:=Format('%-*s - %s',[DatoLiberoCodLen,FieldByName('CODICE').AsString,
               FieldByName('DESCRIZIONE').AsString]);
            lstDatoLibero.Values[S]:=FieldByName('CODICE').AsString;
            Next;
          end;
          Close;
        end;
      end;
    end;
  end;

  // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
  // elenco dati da visualizzare e da modificare per la reperibilità
  DatiAnag.Modificato:=False;
  DatiAnag.Progressivo:=0;
  DatiAnag.Decorrenza:=DATE_NULL;
  DatiAnag.Nominativo:='';
  // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine

  // estrae i dati liberi da visualizzare (chiamate in reperibilità)
  GetDatiLiberi;

  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdReperibilita.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdReperibilita.medpDataSet:=W004DM.selT380;
  grdModifica:=grdReperibilita;

  with WR000DM do
    selT350.Tag:=selT350.Tag + 1;

  tabReperibilita.AggiungiTab(A000TraduzioneStringhe(A000MSG_W004_MSG_LBL_DETTAGLIO), W004DettaglioRG);
  tabReperibilita.AggiungiTab(A000TraduzioneStringhe(A000MSG_W004_MSG_LBL_PROSPETTO), W004ProspettoRG);
  tabReperibilita.ActiveTab:=W004DettaglioRG;
  OldTabIndex:=0;

  grdProspetto.medpPaginazione:=False;
  grdProspetto.medpDataSet:=W004DM.cdsLista;
  grdProspetto.medpTestoNoRecord:='Nessun record';

  GetDipendentiDisponibili;
  rgpTipologia.ItemIndex:=0;
  rgpTipologiaClick(rgpTipologia);
end;

procedure TW004FReperibilita.IWAppFormRender(Sender: TObject);
begin
  inherited;
  rgpOrdinamento.Enabled:=tabReperibilita.ActiveTab = W004DettaglioRG;
  lnkLegendaColoriGiorni.Visible:=tabReperibilita.ActiveTab <> W004DettaglioRG;
  if tabReperibilita.ActiveTab = W004DettaglioRG then
    grdModifica:=grdReperibilita;
end;

function TW004FReperibilita.InizializzaAccesso:Boolean;
var
  StrRicercaAnag:string;
begin
  Result:=True;
  if ParametriForm.Chiamante = 'W030' then
  begin
    Dal:=ParametriForm.Dal;
    Al:=ParametriForm.Al;
    Progressivo:=ParametriForm.Progressivo;
    with selAnagrafe do
    begin
      selAnagrafe.SearchRecord('PROGRESSIVO',Progressivo,[srFromBeginning]);
      StrRicercaAnag:=Format('%-8s %s %s',[FieldByName('MATRICOLA').AsString,FieldByName('COGNOME').AsString,FieldByName('NOME').AsString]);
      StrRicercaAnag:=StrRicercaAnag + '=' + FieldByName('MATRICOLA').AsString;
      cmbDipendentiDisponibili.ItemIndex:=cmbDipendentiDisponibili.Items.IndexOf(StrRicercaAnag);
    end;
  end;
end;

procedure TW004FReperibilita.RefreshPage;
begin
  //btnEseguiClick(nil);
end;

procedure TW004FReperibilita.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 15 }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    inherited;
    RimuoviNotifiche;
  end;
end;

procedure TW004FReperibilita.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    // chiusura frame modifica dati
    if AComponent = W002ModDatiFM then
    begin
      // se la stringa di update è valorizzata, aggiorna i dati anagrafici
      DatiAnag.Modificato:=W002ModDatiFM.UpdateString <> '';
      if DatiAnag.Modificato then
      begin
        // salva info decorrenza
        DatiAnag.Decorrenza:=W002ModDatiFM.Decorrenza;

        // prepara update
        with W002ModDatiDM.updDatiAnag do
        begin
          SetVariable('PROGRESSIVO',W002ModDatiFM.Progressivo);
          SetVariable('DECORRENZA',W002ModDatiFM.Decorrenza);
          SetVariable('SET_VALORI',W002ModDatiFM.UpdateString);
        end;
      end;
      W002ModDatiFM:=nil;
    end;
  end;
end;

procedure TW004FReperibilita.GetDatiLiberi;
// estrae gli eventuali liberi impostati a livello aziendale
// legati al filtro chiamate in reperibilità
var
  Tabella,Codice,Storico: String;
begin
  DatoLibero1:='';
  DatoLibero1Desc:='';
  DatoLibero2:='';
  DatoLibero2Desc:='';

  // dato libero 1 da riportare in tabella
  if Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 <> '' then
  begin
    DatoLibero1:=Format('T430%s',[Parametri.CampiRiferimento.C29_ChiamateRepFiltro1]);
    A000GetTabella(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,Tabella,Codice,Storico);
    if (Tabella <> '') and (Tabella <> 'T430_STORICO') then
      DatoLibero1Desc:=Format('T430D_%s',[Parametri.CampiRiferimento.C29_ChiamateRepFiltro1]);
  end;

  // dato libero 2 per filtro chiamate in reperibilità
  if Parametri.CampiRiferimento.C29_ChiamateRepFiltro2 <> '' then
  begin
    DatoLibero2:=Format('T430%s',[Parametri.CampiRiferimento.C29_ChiamateRepFiltro2]);
    A000GetTabella(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2,Tabella,Codice,Storico);
    if (Tabella <> '') and (Tabella <> 'T430_STORICO') then
      DatoLibero2Desc:=Format('T430D_%s',[Parametri.CampiRiferimento.C29_ChiamateRepFiltro2]);
  end;
end;

procedure TW004FReperibilita.GetTurniPianificati;
// popola la tabella della reperibilita
var
  Dati:String;
begin
  Operazione:='';
  grdReperibilita.medpBrowse:=True;

  Dati:='';
  if DatoLibero1 <> '' then
  begin
    Dati:=Dati + Format('%s,',[DatoLibero1]);
    if DatoLibero1Desc <> '' then
      Dati:=Dati + Format('%s,',[DatoLibero1Desc]);
  end;
  if DatoLibero2 <> '' then
  begin
    Dati:=Dati + Format('%s,',[DatoLibero2]);
    if DatoLibero2Desc <> '' then
      Dati:=Dati + Format('%s,',[DatoLibero2Desc]);
  end;

  // SAVONA_ASL2  - commessa 2013/056 - SVILUPPO 2.ini
  W002ModDatiDM.IntegraCampiV430RepVis(Dati);
  if (Dati <> '') and (RightStr(Dati,1) <> ',') then
    Dati:=Dati + ',';
  // SAVONA_ASL2  - commessa 2013/056 - SVILUPPO 2.fine

  // lettura turni pianificati
  with W004DM.selT380 do
  begin
    SetVariable('DL',Dati);
    SetVariable('FILTRO',WR000DM.FiltroRicerca);
    SetVariable('DAL',Dal);
    SetVariable('DATALAVORO',Al);
    SetVariable('TIPOLOGIA',Tipologia);
    if rgpOrdinamento.ItemIndex = 0 then
      SetVariable('ORDINE','T030.COGNOME,T030.NOME,MATRICOLA,DATA')
    else
      SetVariable('ORDINE','DATA,T030.COGNOME,T030.NOME,MATRICOLA');
    Close;
    Open;
  end;

  if tabReperibilita.ActiveTab = W004DettaglioRG then
    CaricaTurniDettaglio
  else
    CaricaTurniTabellone;
end;

procedure TW004FReperibilita.CaricaTurniDettaglio;
begin
  with grdReperibilita do
  begin
    medpCreaCDS;
    medpEliminaColonne;
    medpAggiungiColonna('DBG_COMANDI','','',nil);
    medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    medpAggiungiColonna('T030NOMINATIVO','Nominativo','',nil);
    //medpAggiungiColonna('T430BADGE','Badge','',nil); // daniloc - attività per SAVONA_ASL2 2012/120 varie 1  - 24.09.2012

    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
    // modifica dati anagrafici
    if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
      medpAggiungiColonna('D_SCHEDAANAG','','',nil);

    // info dipendente (dati liberi di filtro / dati liberi da visualizzare)
    if (DatoLibero1 <> '') or (DatoLibero2 <> '') or (Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '') then
      medpAggiungiColonna('D_INFO','Informazioni','',nil);
    {
    if DatoLibero1 <> '' then
      medpAggiungiColonna(IfThen(DatoLibero1Desc <> '',DatoLibero1Desc,DatoLibero1),R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1),'',nil);
    if DatoLibero2 <> '' then
      medpAggiungiColonna(IfThen(DatoLibero2Desc <> '',DatoLibero2Desc,DatoLibero2),R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2),'',nil);
    }
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine
    medpAggiungiColonna('DATA','Data','',nil);
    medpAggiungiColonna('DATA_GIORNO','gg','',nil); // daniloc. 07.02.2011 (campo DATA_GIORNO sul dataset)
    medpAggiungiColonna('TURNO1','Turno 1','',nil);
    medpColonna('TURNO1').Visible:=False;
    medpAggiungiColonna('C_TURNO1','Turno 1','',nil);
    medpAggiungiColonna('PRIORITA1','Priorità 1','',nil);
    medpColonna('PRIORITA1').Visible:=Tipologia = 'R'; // solo per reperibilità
    medpAggiungiColonna('TURNO2','Turno 2','',nil);
    medpColonna('TURNO2').Visible:=False;
    medpAggiungiColonna('C_TURNO2','Turno 2','',nil);
    medpAggiungiColonna('PRIORITA2','Priorità 2','',nil);
    medpColonna('PRIORITA2').Visible:=Tipologia = 'R'; // solo per reperibilità
    medpAggiungiColonna('TURNO3','Turno 3','',nil);
    medpColonna('TURNO3').Visible:=False;
    medpAggiungiColonna('C_TURNO3','Turno 3','',nil);
    medpAggiungiColonna('PRIORITA3','Priorità 3','',nil);
    medpColonna('PRIORITA3').Visible:=Tipologia = 'R'; // solo per reperibilità
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    begin
      medpAggiungiColonna('DATOLIBERO',R180Capitalize(Parametri.CampiRiferimento.C3_DatoPianificabile),'',nil);
    end;
    medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
    medpInizializzaCompGriglia;

    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
    // indici utilizzati nella gestione
    ColSchedaAnag:=medpIndexColonna('D_SCHEDAANAG');
    //ColInfoDip:=medpIndexColonna('D_INFO');
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine

    if not SolaLettura then
    begin
      medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null','S');
      medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','null','','D');
      medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
      medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','','D');
      //Riga di inserimento
      medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','null','','S');
      medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','null','','S');
      medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','null','','D');

      // scheda anagrafica e modifica dati anagrafici
      if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
      begin
        {
        // riga di inserimento
        medpPreparaComponenteGenerico('I',ColSchedaAnag,0,DBG_IMG,'','MODIFICA','Modifica i dati anagrafici','','S',True); // mantenere parametro Grid = True
        }
        // righe di dettaglio
        medpPreparaComponenteGenerico('R',ColSchedaAnag,0,DBG_IMG,'','MODIFICA','Modifica i dati anagrafici','','S',True); // mantenere parametro Grid = True
       end;
    end;
    medpCaricaCDS;
  end;
end;

procedure TW004FReperibilita.CaricaTurniTabellone;
begin
  FiltroDip:=selAnagrafe.SubstitutedSql;
  CaricaListaTabellone;
  VisualizzaGrigliaTabellone;
end;

procedure TW004FReperibilita.CaricaListaTabellone;
var i,n,LenTurno,I1,F1:Integer;
    Data:TDateTime;
  function CheckDatoBloccato(Progressivo:Integer; Data:TDateTime):Boolean;
  begin
    Result:=False;
    with W004DM.selT180 do
    begin
      if SearchRecord('PROGRESSIVO',Progressivo,[srFromBeginning]) then
      repeat
        if R180Between(Data,FieldByName('DAL').AsDateTime,FieldByName('AL').AsDateTime) then
        begin
          Result:=True;
          Break;
        end;
      until not SearchRecord('PROGRESSIVO',Progressivo,[]);
    end;
  end;
begin
  with W004DM do
  begin
    (*
    selT011.Close;
    selT040.Close;
    selT100.Close;
    selT180.Close;
    *)
    if Pos(':DATALAVORO',UpperCase(FiltroDip)) > 0 then
    begin
      if selT040.VariableIndex('DATALAVORO') = -1 then
      begin
        selT011.DeclareVariable('DATALAVORO',otDate);
        selT040.DeclareVariable('DATALAVORO',otDate);
        selT100.DeclareVariable('DATALAVORO',otDate);
        selT180.DeclareVariable('DATALAVORO',otDate);
      end;
      selT011.SetVariable('DATALAVORO',Parametri.DataLavoro);
      selT040.SetVariable('DATALAVORO',Parametri.DataLavoro);
      selT100.SetVariable('DATALAVORO',Parametri.DataLavoro);
      selT180.SetVariable('DATALAVORO',Parametri.DataLavoro);
    end
    else if selT040.VariableIndex('DATALAVORO') > -1 then
    begin
      selT011.DeleteVariable('DATALAVORO');
      selT040.DeleteVariable('DATALAVORO');
      selT100.DeleteVariable('DATALAVORO');
      selT180.DeleteVariable('DATALAVORO');
    end;
    R180SetVariable(selT011,'FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    R180SetVariable(selT011,'DAL',Dal);
    R180SetVariable(selT011,'AL',Al);
    selT011.Open;
    selT011.First;
    R180SetVariable(selT040,'FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    R180SetVariable(selT040,'DAL',Dal);
    R180SetVariable(selT040,'AL',Al);
    R180SetVariable(selT040,'PRESENZE',Parametri.CampiRiferimento.C90_W010CausPres);
    selT040.Open;
    selT040.First;
    R180SetVariable(selT100,'FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    R180SetVariable(selT100,'DAL',Dal);
    R180SetVariable(selT100,'AL',Al);
    selT100.Open;
    selT100.First;
    R180SetVariable(selT180,'FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    R180SetVariable(selT180,'DAL',R180InizioMese(Dal));
    R180SetVariable(selT180,'AL',R180FineMese(Al));
    selT180.Open;
    selT180.First;

    cdsLista.Close;
    cdsLista.FieldDefs.Clear;
    cdsLista.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsLista.FieldDefs.Add('COGNOME',ftString,30,False);
    cdsLista.FieldDefs.Add('NOME',ftString,30,False);
    cdsLista.FieldDefs.Add('NOMINATIVO',ftString,200,False);
    cdsLista.FieldDefs.Add('DATO_RAGGR',ftString,200,False);
    cdsLista.FieldDefs.Add('ORDINE',ftInteger,0,False);
    cdsLista.FieldDefs.Add('TOT_TURNI',ftInteger,0,False);
    cdsLista.FieldDefs.Add('TOT_MINUTI',ftInteger,0,False);
    cdsLista.FieldDefs.Add('TOTALI',ftString,30,False);
    for i:=0 to Trunc(Al - Dal) do
      cdsLista.FieldDefs.Add(FormatDateTime('yyyymmdd',Dal + i),ftDate,0,False);
    cdsLista.CreateDataSet;
    cdsLista.LogChanges:=False;
    cdsLista.IndexDefs.Clear;
    cdsLista.IndexDefs.Add('Ricerca',('DATO_RAGGR;ORDINE;COGNOME;NOME;PROGRESSIVO'),[]);
    cdsLista.IndexName:='Ricerca';

    cdsListaTimb.Close;
    cdsListaTimb.FieldDefs.Clear;
    cdsListaTimb.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsListaTimb.FieldDefs.Add('DATA',ftDate,0,False);
    cdsListaTimb.FieldDefs.Add('LAVORATIVO',ftString,1,False);
    cdsListaTimb.FieldDefs.Add('MODIFICABILE',ftString,1,False);
    cdsListaTimb.FieldDefs.Add('TIMBRATURE',ftString,1,False);
    cdsListaTimb.FieldDefs.Add('GIUSTIF_GG',ftString,1,False);
    cdsListaTimb.CreateDataSet;
    cdsListaTimb.LogChanges:=False;

    cdsListaTurni.Close;
    cdsListaTurni.FieldDefs.Clear;
    cdsListaTurni.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsListaTurni.FieldDefs.Add('DATA',ftDate,0,False);
    cdsListaTurni.FieldDefs.Add('NUMERO',ftInteger,0,False);
    cdsListaTurni.FieldDefs.Add('TURNO',ftString,5,False);
    cdsListaTurni.FieldDefs.Add('PRIORITA',ftString,1,False);
    cdsListaTurni.CreateDataSet;
    cdsListaTurni.LogChanges:=False;

    MaxLenTurno:=0;
    selAnagrafe.First;
    while not selAnagrafe.Eof do
    begin
      cdsLista.Append;
      cdsLista.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
      cdsLista.FieldByName('COGNOME').AsString:=selAnagrafe.FieldByName('COGNOME').AsString;
      cdsLista.FieldByName('NOME').AsString:=selAnagrafe.FieldByName('NOME').AsString;
      cdsLista.FieldByName('NOMINATIVO').AsString:=cdsLista.FieldByName('COGNOME').AsString + ' ' + cdsLista.FieldByName('NOME').AsString;
      cdsLista.FieldByName('ORDINE').AsInteger:=9999;
      cdsLista.FieldByName('TOT_TURNI').AsInteger:=0;
      cdsLista.FieldByName('TOT_MINUTI').AsInteger:=0;
      cdsLista.FieldByName('TOTALI').AsString:='Turni: ' + cdsLista.FieldByName('TOT_TURNI').AsString + CRLF + 'Ore: ' + R180MinutiOre(cdsLista.FieldByName('TOT_MINUTI').AsInteger);
      cdsLista.Post;
      for i:=0 to Trunc(Al - Dal) do
      begin
        Data:=Dal + i;
        cdsListaTimb.Append;
        cdsListaTimb.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
        cdsListaTimb.FieldByName('DATA').AsDateTime:=Data;
        (*
        T010F_GGLAVORATIVO.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        T010F_GGLAVORATIVO.SetVariable('DATA',Data);
        T010F_GGLAVORATIVO.Execute;
        cdsListaTimb.FieldByName('LAVORATIVO').AsString:=VarToStr(T010F_GGLAVORATIVO.GetVariable('LAVORATIVO'));
        *)
        cdsListaTimb.FieldByName('LAVORATIVO').AsString:=VarToStr(selT011.Lookup('PROGRESSIVO;DATA',VarArrayOf([selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data]),'LAVORATIVO'));
        (*
        WR000DM.selDatiBloccati.Close;
        cdsListaTimb.FieldByName('MODIFICABILE').AsString:=IfThen(SolaLettura or WR000DM.selDatiBloccati.DatoBloccato(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(Data),'T380'),'N','S');
        *)
        cdsListaTimb.FieldByName('MODIFICABILE').AsString:=IfThen(SolaLettura or CheckDatoBloccato(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(Data)),'N','S');
        //Presenza timbrature
        cdsListaTimb.FieldByName('TIMBRATURE').AsString:=IfThen(StrToIntDef(VarToStr(selT100.Lookup('PROGRESSIVO;DATA',VarArrayOf([selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data]),'N_TIMB_REP')),0) > 0,'R',
                                                         IfThen(StrToIntDef(VarToStr(selT100.Lookup('PROGRESSIVO;DATA',VarArrayOf([selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data]),'N_TIMB')),0) > 0,'S','N'));
        //Giustificativo a giornata intera
        cdsListaTimb.FieldByName('GIUSTIF_GG').AsString:=IfThen(VarToStr(selT040.Lookup('PROGRESSIVO;DATA;TIPOGIUST',VarArrayOf([selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data,'I']),'TIPOGIUST')) = 'I','S','N');
        cdsListaTimb.Post;
        //Cerco i turni del dipendente
        selT380.Filter:='(PROGRESSIVO = ' + IntToStr(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger) + ') AND (DATA = ' + FloatToStr(Data) + ')';
        selT380.Filtered:=True;
        selT380.First;
        if selT380.RecordCount = 0 then
        begin
          if cdsListaTimb.FieldByName('MODIFICABILE').AsString = 'S' then
          begin
            cdsListaTurni.Append;
            cdsListaTurni.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
            cdsListaTurni.FieldByName('DATA').AsDateTime:=Data;
            cdsListaTurni.FieldByName('NUMERO').AsInteger:=1;
            cdsListaTurni.FieldByName('TURNO').AsString:='_';
            cdsListaTurni.FieldByName('PRIORITA').AsString:='';
            cdsListaTurni.Post;
          end;
        end
        else
          while not selT380.Eof do
          begin
            for n:=1 to 3 do
            begin
              cdsListaTurni.Append;
              cdsListaTurni.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
              cdsListaTurni.FieldByName('DATA').AsDateTime:=Data;
              cdsListaTurni.FieldByName('NUMERO').AsInteger:=n;
              cdsListaTurni.FieldByName('TURNO').AsString:=selT380.FieldByName('TURNO' + IntToStr(n)).AsString;
              cdsListaTurni.FieldByName('PRIORITA').AsString:=IfThen(Tipologia = 'R',selT380.FieldByName('PRIORITA' + IntToStr(n)).AsString);
              cdsListaTurni.Post;
              LenTurno:=Length(cdsListaTurni.FieldByName('TURNO').AsString + cdsListaTurni.FieldByName('PRIORITA').AsString);
              MaxLenTurno:=Max(MaxLenTurno,LenTurno);
              if Trim(cdsListaTurni.FieldByName('TURNO').AsString) <> '' then
              begin
                cdsLista.Locate('PROGRESSIVO',cdsListaTurni.FieldByName('PROGRESSIVO').AsInteger,[]);//Mi riposiziono per sicurezza a causa dell'indice
                cdsLista.Edit;
                cdsLista.FieldByName('TOT_TURNI').AsInteger:=cdsLista.FieldByName('TOT_TURNI').AsInteger + 1;
                I1:=WR000DM.selT350.Lookup('CODICE',cdsListaTurni.FieldByName('TURNO').AsString,'INIZIO');
                F1:=WR000DM.selT350.Lookup('CODICE',cdsListaTurni.FieldByName('TURNO').AsString,'FINE');
                if F1 <= I1 then
                  inc(F1,1440);
                cdsLista.FieldByName('TOT_MINUTI').AsInteger:=cdsLista.FieldByName('TOT_MINUTI').AsInteger + F1 - I1;
                cdsLista.FieldByName('TOTALI').AsString:='Turni: ' + cdsLista.FieldByName('TOT_TURNI').AsString + CRLF + 'Ore: ' + R180MinutiOre(cdsLista.FieldByName('TOT_MINUTI').AsInteger);
                cdsLista.Post;
              end;
            end;
            selT380.Next;
          end;
        selT380.Filtered:=False;
      end;
      selAnagrafe.Next;
    end;
    if not selAnagrafe.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]) then
      selAnagrafe.First;
  end;
end;

procedure TW004FReperibilita.VisualizzaGrigliaTabellone;
var i:Integer;
    Data:TDateTime;
begin
  grdProspetto.Summary:=grdProspetto.Caption;
  with W004DM do
  begin
    if cdsLista.RecordCount > 0 then
    begin
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
      grdProspetto.medpRighePagina:=GetRighePaginaTabella;
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
    end;
    grdProspetto.medpCreaCDS;
    grdProspetto.medpEliminaColonne;
    for i:=0 to cdsLista.FieldDefs.Count - 1 do
      if not R180In(cdsLista.FieldDefs[i].Name,['DATO_RAGGR','ORDINE','COGNOME','NOME','TOT_TURNI','TOT_MINUTI']) then
      begin
        if cdsLista.FieldDefs[i].Name = 'PROGRESSIVO' then
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Progressivo','',nil)
        else if cdsLista.FieldDefs[i].Name = 'NOMINATIVO' then
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Nominativo','',nil)
        else if cdsLista.FieldDefs[i].Name = 'TOTALI' then
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Totali','',nil)
        else
        begin
          Data:=EncodeDate(StrToInt(Copy(cdsLista.FieldDefs[i].Name,1,4)),StrToInt(Copy(cdsLista.FieldDefs[i].Name,5,2)),StrToInt(Copy(cdsLista.FieldDefs[i].Name,7,2)));
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,FormatDateTime('dd/mm/yyyy',Data),'',nil);
        end;
      end;
  end;
  grdProspetto.medpColonna('PROGRESSIVO').Visible:=False;
  grdProspetto.medpInizializzaCompGriglia;
  grdProspetto.medpCaricaCDS;
end;

procedure TW004FReperibilita.cmbTurnoAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with (Sender as TMedpIWMultiColumnComboBox) do
  begin
    Hint:=Items[Index].RowData[1];
  end;
end;

procedure TW004FReperibilita.TrasformaComponenti(const FN: String);
// Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdReperibilita
var
  DaTestoAControlli:Boolean;
  i,j,c:Integer;
begin
  with grdReperibilita do
  begin
    i:=medpRigaDiCompGriglia(FN);
    c:=medpIndexColonna('C_TURNO1');
    DaTestoAControlli:=medpCompGriglia[i].CompColonne[c] = nil;

    with (medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
      Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
      Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
      Cell[0,3].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
    end;

    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
    // modifica dati
    if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
    begin
      with (medpCompGriglia[i].CompColonne[ColSchedaAnag] as TmeIWGrid) do
      begin
        if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
          Cell[0,0].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
      end;
    end;
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine

    if DaTestoAControlli then
    begin
      // data
      c:=medpIndexColonna('DATA');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      (medpCompCella(i,c,0) as TmeIWEdit).Text:=medpValoreColonna(i,'DATA');
      // turno 1
      c:=medpIndexColonna('C_TURNO1');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        //PopUpWidth:=25;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to lstTurniDisponibili.Count - 1 do
          AddRow(lstTurniDisponibili[j]);
        Text:=medpValoreColonna(i,'TURNO1');
        //OnAsyncChange:=cmbTurnoAsyncChange;
      end;
      // priorità chiamata turno 1
      c:=medpIndexColonna('PRIORITA1');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        Text:=medpValoreColonna(i,'PRIORITA1');
        MaxLength:=1;
      end;
      // turno 2
      c:=medpIndexColonna('C_TURNO2');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        //PopUpWidth:=25;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to lstTurniDisponibili.Count - 1 do
          AddRow(lstTurniDisponibili[j]);
        Text:=medpValoreColonna(i,'TURNO2');
      end;
      // priorità chiamata turno 2
      c:=medpIndexColonna('PRIORITA2');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        Text:=medpValoreColonna(i,'PRIORITA2');
        MaxLength:=1;
      end;
      // turno 3
      c:=medpIndexColonna('C_TURNO3');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        //PopUpWidth:=25;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to lstTurniDisponibili.Count - 1 do
          AddRow(lstTurniDisponibili[j]);
        Text:=medpValoreColonna(i,'TURNO3');
      end;
      // priorità chiamata turno 3
      c:=medpIndexColonna('PRIORITA3');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(i,c,Componenti);
      with (medpCompCella(i,c,0) as TmeIWEdit) do
      begin
        Text:=medpValoreColonna(i,'PRIORITA3');
        MaxLength:=1;
      end;
      // dato libero
      if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      begin
        // dato libero
        c:=medpIndexColonna('DATOLIBERO');
        medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'20','','','','S');
        medpCreaComponenteGenerico(i,c,Componenti);
        with (medpCompCella(i,c,0) as TmeIWComboBox) do
        begin
          ItemsHaveValues:=True;
          Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
          Items.Assign(lstDatoLibero);
          ItemIndex:=R180IndexOf(Items,medpValoreColonna(i,'DATOLIBERO'),DatoLiberoCodLen);
        end;
      end;
    end
    else
    begin
      // data
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('DATA')]);
      // turno 1
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_TURNO1')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('PRIORITA1')]);
      // turno 2
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_TURNO2')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('PRIORITA2')]);
      // turno 3
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('C_TURNO3')]);
      FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('PRIORITA3')]);
      // dato libero
      if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
        FreeAndNil(medpCompGriglia[i].CompColonne[medpIndexColonna('DATOLIBERO')]);
    end;
    medpBrowse:=not DaTestoAControlli;
  end;
end;

procedure TW004FReperibilita.actCancellazioneOK(FN:String);
begin
  // cancellazione record
  with W004DM.selT380 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      // controllo dato bloccato
      WR000DM.selDatiBloccati.Close;
      if WR000DM.selDatiBloccati.DatoBloccato(FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(FieldByName('DATA').AsDateTime),'T380') then
      begin
        MsgBox.MessageBox('Cancellazione non consentita: ' + WR000DM.selDatiBloccati.MessaggioLog,ESCLAMA);
        Exit;
      end;

      RegistraLog.SettaProprieta('C','T380_PIANIFREPERIB',medpCodiceForm,W004DM.selT380,True);
      Delete;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    end;
  end;
  //GetTurniPianificati;
  if (grdModifica <> grdReperibilita) and (W004FModTabFM <> nil) then
    W004FModTabFM.AfterCancellazione
  else
    GetTurniPianificati;
end;

function TW004FReperibilita.GetInfoDip: String;
var
  i, ProgCorr: Integer;
  Dato, DatoT430, DatoFmt: String;
  IsProgModif, IsDatoModificabile: Boolean;
begin
  // compone l'informazione da visualizzare
  Result:='<table><tbody>';

  // gestione dati parametrizzati
  if Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
  begin
    // salva il progressivo della riga corrente
    ProgCorr:=grdReperibilita.medpClientDataSet.FieldByName('PROGRESSIVO').AsInteger;
    IsProgModif:=(DatiAnag.Modificato) and (DatiAnag.Progressivo = ProgCorr);

    // dati da visualizzare
    for i:=0 to W002ModDatiDM.LstDatiVis.Count - 1 do
    begin
      Dato:=W002ModDatiDM.LstDatiVis[i];
      DatoT430:=Format('T430%s',[Dato]);
      DatoFmt:=R180Capitalize(Dato);

      if WR000DM.cdsI010.Locate('NOME_CAMPO',DatoT430,[]) then
      begin
        // dato ok: se l'accesso è S/R lo visualizza
        if WR000DM.cdsI010.FieldByName('ACCESSO').AsString <> 'N' then
        begin
          // se il dato è nella lista dei modificabili e
          // l'accesso è S indica che il dato è modificabile
          IsDatoModificabile:=(W002ModDatiDM.LstDatiModif.IndexOf(Dato) > -1) and
                              (WR000DM.cdsI010.FieldByName('ACCESSO').AsString = 'S');
          if IsDatoModificabile then
          begin
            DatoFmt:=Format('<abbr title="Dato modificabile">%s</abbr>',[DatoFmt]);
          end;

          // se il dipendente è quello in modifica e il dato corrente è modificabile
          // legge il valore dal clientdataset
          // altrimenti visualizza il valore del dataset
          if IsProgModif and IsDatoModificabile then
          begin
            if W002ModDatiDM.cdsDatiAnag.Locate('DATO',Dato,[loCaseInsensitive]) then
              Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',[DatoFmt,W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE').AsString]);
          end
          else
          begin
            if Assigned(W004DM.selT380.FindField(DatoT430)) then
              Result:=Result + Format('<tr><td>%s:</td><td>%s</td></tr>',[DatoFmt,grdReperibilita.medpClientDataSet.FieldByName(DatoT430).AsString]);
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
                             W004DM.selT380.FieldByName(DatoLibero1).AsString]);
  end;

  // dato libero 2
  if DatoLibero2 <> '' then
  begin
    Result:=Result + Format('<tr><td>%s:</td> <td>%s</td></tr> ',
                            [R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2),
                            W004DM.selT380.FieldByName(DatoLibero2).AsString]);
  end;
  Result:=Result + '</tbody></table>';
end;

procedure TW004FReperibilita.PreparaDatiAnag;
var
  i: Integer;
  DatoT430: String;
begin
  // imposta il clientdataset con i valori attuali dei campi da modificare
  for i:=0 to W002ModDatiDM.LstDatiVis.Count - 1 do
  begin
    DatoT430:=Format('T430%s',[W002ModDatiDM.LstDatiVis[i]]);
    if W002ModDatiDM.cdsDatiAnag.Locate('CAMPO',DatoT430,[]) then
    begin
      W002ModDatiDM.cdsDatiAnag.Edit;
      W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE').AsString:=W004DM.selT380.FieldByName(DatoT430).AsString;
      W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE_OLD').AsString:=W002ModDatiDM.cdsDatiAnag.FieldByName('VALORE').AsString;
      W002ModDatiDM.cdsDatiAnag.Post;
    end;
  end;
end;

procedure TW004FReperibilita.grdProspettoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i,j,Prog:Integer;
    Data:TDateTime;
begin
  inherited;
  //Gestione dei link
  for i:=0 to High(grdProspetto.medpCompGriglia) do
    for j:=0 to High(grdProspetto.medpCompGriglia[i].CompColonne) do
      if j >= NCOLONNEBLOCCATE then
        with W004DM do
        begin
          Data:=EncodeDate(StrToInt(Copy(grdProspetto.medpColonna(j).DataField,1,4)),StrToInt(Copy(grdProspetto.medpColonna(j).DataField,5,2)),StrToInt(Copy(grdProspetto.medpColonna(j).DataField,7,2)));
          Prog:=StrToInt(grdProspetto.medpValoreColonna(i,'PROGRESSIVO'));
          cdsListaTimb.Locate('PROGRESSIVO;DATA',VarArrayOf([Prog,Data]),[]);
          cdsListaTurni.Locate('PROGRESSIVO;DATA',VarArrayOf([Prog,Data]),[]);
          //Link per TURNO modificabile, altrimenti TURNO nel testo della cella
          if cdsListaTimb.FieldByName('MODIFICABILE').AsString = 'S' then
          begin
            grdProspetto.medpPreparaComponenteGenerico('C',0,0,DBG_LNK,'','','','','S');
            grdProspetto.medpCreaComponenteGenerico(i,j,grdProspetto.Componenti);
            with (grdProspetto.medpCompCella(i,j,0) as TmeIWLink) do
            begin
              OnClick:=lnkTurnoClick;
              FriendlyName:=DateToStr(Data) + ';' + IntToStr(Prog);
              Tag:=Trunc(Data);
            end;
          end;
        end;
end;

procedure TW004FReperibilita.lnkTurnoClick(Sender: TObject);
var FN:String;
begin
  W004FModTabFM:=TW004FModificaTabelloneFM.Create(Self);
  FreeNotification(W004FModTabFM);
  with W004FModTabFM do
  begin
    W004DM_Mod:=W004DM;
    FN:=(Sender as TmeIWLink).FriendlyName;
    Data:=StrToDate(Copy(FN,1,Pos(';',FN) - 1));
    Prog:=StrToInt(Copy(FN,Pos(';',FN) + 1));
    Tipo:=Tipologia;
    CaricaGriglia;
  end;
end;

procedure TW004FReperibilita.grdProspettoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var r,c,Prog:Integer;
    Data:TDateTime;
    Timbrature,GiustifGG,Turni,Turno,Priorita,DTurno,DalleAlle,
    TestoOrig,Testo,BackgroundColor,FontWeight:String;
  function GetData(const S:String):String;
  var Spaziatura:String;
  begin
    Result:=Copy(FormatDateTime('dddd',StrToDate(S)),1,2) + '<br>';
    if R180Anno(Dal) = R180Anno(Al) then
    begin
      if R180Mese(Dal) = R180Mese(Al) then
      begin
        Spaziatura:=DupeString('&nbsp;',MaxLenTurno + 1);
        Result:=Result + Spaziatura + Copy(S,1,2) + Spaziatura;
      end
      else
      begin
        if MaxLenTurno > 3 then
          Spaziatura:=DupeString('&nbsp;',Round(((MaxLenTurno + 1) / 2)));
        Result:=Result + Spaziatura + Copy(S,1,5) + Spaziatura;
      end;
    end
    else
    begin
      if MaxLenTurno > 5 then
        Spaziatura:=DupeString('&nbsp;',Round(((MaxLenTurno + 1) / 3)));
      Result:=Result + Spaziatura + FormatDateTime('dd/mm/yy',StrToDate(S)) + Spaziatura;
    end;
  end;
begin
  inherited;
  if not grdProspetto.medpRenderCell(ACell, ARow, AColumn, True, True, False) then
    Exit;
  r:=ARow - 1;
  c:=grdProspetto.medpNumColonna(AColumn);
  if c >= NCOLONNEBLOCCATE then
    with W004DM do
    begin
      if ARow = 0 then
      begin
        Data:=StrToDate(ACell.Text);
        ACell.RawText:=True;
        ACell.Text:=GetData(ACell.Text);
        if DayOfWeek(Data) = 1 then
          ACell.Css:=ACell.Css + ' font_rosso';
      end
      else if (Length(grdProspetto.medpCompGriglia) > 0) then
      begin
        Data:=EncodeDate(StrToInt(Copy(grdProspetto.medpColonna(c).DataField,1,4)),StrToInt(Copy(grdProspetto.medpColonna(c).DataField,5,2)),StrToInt(Copy(grdProspetto.medpColonna(c).DataField,7,2)));
        Prog:=StrToInt(grdProspetto.medpValoreColonna(r,'PROGRESSIVO'));
        if cdsListaTimb.Locate('PROGRESSIVO;DATA',VarArrayOf([Prog,Data]),[]) then
        begin
          Timbrature:=cdsListaTimb.FieldByName('TIMBRATURE').AsString;
          GiustifGG:=cdsListaTimb.FieldByName('GIUSTIF_GG').AsString;
          if cdsListaTimb.FieldByName('LAVORATIVO').AsString = 'N' then
            ACell.Css:=ACell.Css + ' bg_nonlavorativo';
          //Contenitore esterno in cui inserire gli span con i colori e le causali
          TestoOrig:='<div style="position:relative; height:4em;">';
          //Testo fittizio per dimensionare la cella e far applicare gli span successivi
          TestoOrig:=TestoOrig + '&nbsp;';
          //Fascia rossa per presenza giustificativo a giornata intera
          if GiustifGG = 'S' then
            TestoOrig:=TestoOrig + '<span style="position:absolute; left:90%; top:0px; width:5%; height:100%; z-index:7; background-color:#FF0000;">&nbsp;</span>';
          //Fascia verde per presenza timbrature
          if Timbrature <> 'N' then
            TestoOrig:=TestoOrig + '<span style="position:absolute; left:95%; top:0px; width:5%; height:100%; z-index:7; background-color:' + IfThen(Timbrature = 'R','#0000FF','#00FF00') + ';">&nbsp;</span>';
          //Azzero le variabili dei turni
          Turni:='';
          ACell.Hint:=Format('%s %s %s<br>Pianificazione del %s',[VarToStr(selAnagrafe.Lookup('PROGRESSIVO',Prog,'MATRICOLA')),VarToStr(selAnagrafe.Lookup('PROGRESSIVO',Prog,'COGNOME')),VarToStr(selAnagrafe.Lookup('PROGRESSIVO',Prog,'NOME')),FormatDateTime('dd/mm/yyyy',Data)]);
          ACell.Css:=ACell.Css + ' tooltipHtml';
          //Ciclo sui turni del giorno del dipendente
          if cdsListaTurni.Locate('PROGRESSIVO;DATA',VarArrayOf([Prog,Data]),[]) then
            repeat
              Turno:=cdsListaTurni.FieldByName('TURNO').AsString;
              Priorita:='';
              DTurno:='';
              DalleAlle:='';
              if (Turno <> '') and (Turno <> '_') then
              begin
                Priorita:=cdsListaTurni.FieldByName('PRIORITA').AsString;
                DTurno:=VarToStr(WR000DM.selT350.Lookup('CODICE',Turno,'DESCRIZIONE'));
                DalleAlle:=Format('%s - %s',[R180MinutiOre(StrToIntDef(VarToStr(WR000DM.selT350.Lookup('CODICE',Turno,'INIZIO')),0)),R180MinutiOre(StrToIntDef(VarToStr(WR000DM.selT350.Lookup('CODICE',Turno,'FINE')),0))]);
                ACell.Hint:=ACell.Hint + '<br>' + Turno + IfThen(DTurno <> '',' ' + DTurno) + IfThen(DalleAlle <> '',': ' + DalleAlle);
              end;
              Turni:=Turni + Turno + IfThen(Priorita <> '',' ' + Priorita) + ',';
              BackgroundColor:='transparent';
              //Creo gli span colorati, sovrapponendo gli strati di visualizzazione
              TestoOrig:=TestoOrig + Format('<span style="position:absolute; left:%s; top:0px; width:%s; height:100%%; z-index:%s; background-color:%s;">&nbsp;</span>',
                                              ['0px',
                                               '100%',
                                               '1',
                                               BackgroundColor]);
              cdsListaTurni.Next;
            until cdsListaTurni.Eof
            or (cdsListaTurni.FieldByName('PROGRESSIVO').AsInteger <> Prog)
            or (cdsListaTurni.FieldByName('DATA').AsDateTime <> Data);
          //Testo con i turni pianificati
          Turni:=StringReplace(Copy(Turni,1,Length(Turni) - 1),',','<br>',[rfReplaceAll]);
          if Turni <> '' then
            TestoOrig:=TestoOrig + '<span style="position:absolute; left:0px; top:0px; width:100%; height:100%; z-index:8; background-color:transparent; padding-left:2px;">#TURNI#</span>';
          TestoOrig:=TestoOrig + '</div>';
          //Se la cella non contiene componenti...
          if grdProspetto.medpCompGriglia[r].CompColonne[c] = nil then
          begin
            //...gestisco tutto nel testo della cella
            ACell.RawText:=True;
            Testo:=StringReplace(TestoOrig,'#TURNI#',Turni,[rfReplaceAll]);
            ACell.Text:=Testo;
          end
          //Se la cella contiene componenti...
          else
          begin
            //...gestisco tutto nel testo dei componenti della grid della cella
            ACell.Control:=grdProspetto.medpCompGriglia[r].CompColonne[c];
            FontWeight:='normal';
            if fsBold in (grdProspetto.medpCompCella(r,c,0) as TmeIWLink).Font.Style then
              FontWeight:='bold';
            Testo:=StringReplace(TestoOrig,'#TURNI#',Format('<u style="color:blue; font-weight:%s;">%s</u>',[FontWeight,Turni]),[rfReplaceAll]);
            with (grdProspetto.medpCompCella(r,c,0) as TmeIWLink) do
            begin
              RawText:=True;
              Text:=Testo;
              Css:='';
            end;
          end;
        end;
      end;
    end;
end;

procedure TW004FReperibilita.grdReperibilitaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
begin
  if not SolaLettura then
  begin
    with grdReperibilita do
    begin
      if StileCella1 = '' then
      begin
        with (medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
        begin
          StileCella1:=Cell[0,0].Css;
          StileCella2:=Cell[0,2].Css;
        end;
        {
        with (medpCompGriglia[0].CompColonne[ColSchedaAnag] as TmeIWGrid) do
        begin
          StileCella3:=Cell[0,0].Css;
        end;
        }
      end;
      //Riga di inserimento
      (medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
      (medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
      (medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgConfermaInserimentoClick;
      with (medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:='invisibile';
      end;

      // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
      // scheda anagrafica e modifica dati anagrafici
      {
      if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        (medpCompCella(0,ColSchedaAnag,0) as TmeIWImageFile).OnClick:=imgModificaDatiClick;
      with (medpCompGriglia[0].CompColonne[ColSchedaAnag] as TmeIWGrid) do
      begin
        if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
          Cell[0,0].Css:='invisibile';
      end;
      }
      // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini

      //Righe dati
      for i:=1 to High(medpCompGriglia) do
      begin
        // Associo l'evento OnClick alle Icone
        (medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCancellaClick;
        (medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModificaClick;
        (medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaClick;
        (medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgConfermaClick;
        with (medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
        begin
          Cell[0,2].Css:='invisibile';
          Cell[0,3].Css:='invisibile';
        end;
        // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
        if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        begin
          (medpCompCella(i,ColSchedaAnag,0) as TmeIWImageFile).OnClick:=imgModificaDatiClick;
          with (medpCompGriglia[i].CompColonne[ColSchedaAnag] as TmeIWGrid) do
            Cell[0,0].Css:='invisibile';
        end;
        // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine
      end;
    end;
  end;
end;

procedure TW004FReperibilita.grdReperibilitaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  NomeCampo,Cod: String;
begin
  if not grdReperibilita.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdReperibilita.medpNumColonna(AColumn);
  NomeCampo:=grdReperibilita.medpColonna(NumColonna).DataField;

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdReperibilita.medpCompGriglia) + 1) and (grdReperibilita.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdReperibilita.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  if ARow > 0 then
  begin
    // allineamento al centro per alcuni campi
    if (NomeCampo = 'DATA') or
       (NomeCampo = 'DATA_GIORNO') or
       (Copy(NomeCampo,1,8) = 'PRIORITA') then
      ACell.Css:=ACell.Css + ' align_center';

    if (NomeCampo = 'C_TURNO1') and
       (ACell.Control = nil) then
    begin
      Cod:=grdReperibilita.medpValoreColonna(ARow - 1,'TURNO1');
      if Cod <> '' then
        ACell.Text:=Format('%s - %s',[Cod,VarToStr(WR000DM.selT350.Lookup('CODICE',Cod,'DESCRIZIONE'))]);
    end
    else if (NomeCampo = 'C_TURNO2') and
       (ACell.Control = nil) then
    begin
      Cod:=grdReperibilita.medpValoreColonna(ARow - 1,'TURNO2');
      if Cod <> '' then
        ACell.Text:=Format('%s - %s',[Cod,VarToStr(WR000DM.selT350.Lookup('CODICE',Cod,'DESCRIZIONE'))]);
    end
    else if (NomeCampo = 'C_TURNO3') and
       (ACell.Control = nil) then
    begin
      Cod:=grdReperibilita.medpValoreColonna(ARow - 1,'TURNO3');
      if Cod <> '' then
        ACell.Text:=Format('%s - %s',[Cod,VarToStr(WR000DM.selT350.Lookup('CODICE',Cod,'DESCRIZIONE'))]);
    end
    else if (NomeCampo = 'PRIORITA2') and
            (grdReperibilita.medpValoreColonna(ARow - 1,'TURNO2') = '') then
    begin
      ACell.Text:=''
    end
    else if (NomeCampo = 'PRIORITA3') and
            (grdReperibilita.medpValoreColonna(ARow - 1,'TURNO3') = '') then
    begin
      ACell.Text:='';
    end
    else if NomeCampo = 'D_INFO' then
    begin
      ACell.Css:=ACell.Css + ' info_dipendente gridTrasparente';
      if ARow > IfThen(grdReperibilita.medpRigaInserimento,1,0) then
        ACell.Text:=GetInfoDip;
    end;
  end;
end;

procedure TW004FReperibilita.DBGridColumnClick(ASender: TObject; const AValue: string);
begin
  if grdModifica <> nil then
    grdModifica.DataSource.DataSet.Locate('DBG_ROWID',AValue,[]);
  W004DM.selT380.SearchRecord('ROWID',AValue,[srFromBeginning]);
end;

procedure TW004FReperibilita.GetDipendentiDisponibili;
// popola la combo dei dipendenti
var
  Codice, Descrizione: String;
  P: Integer;
  Trovato: Boolean;
begin;
  with selAnagrafe do
  begin
    // salva progressivo prima del loop
    if Active then
      P:=FieldByName('PROGRESSIVO').AsInteger
    else
      P:=-1;

    // riapertura dataset
    R180SetVariable(selAnagrafe,'DATALAVORO',Al);
    cmbDipendentiDisponibili.Items.Clear;
    //Close;
    Open;
    First;
    while not Eof do
    begin
      Codice:=FieldByName('MATRICOLA').AsString;
      Descrizione:=Format('%-8s %s %s',[FieldByName('MATRICOLA').AsString,FieldByName('COGNOME').AsString,FieldByName('NOME').AsString]);
      cmbDipendentiDisponibili.Items.Add(Descrizione + '=' + Codice);
      Next;
    end;

    // riposizionamento bookmark su selAnagrafe
    Trovato:=SearchRecord('PROGRESSIVO',P,[srFromBeginning]);
    if not Trovato then
      First;
  end;
  cmbDipendentiDisponibili.RequireSelection:=cmbDipendentiDisponibili.Items.Count > 0;
  if cmbDipendentiDisponibili.Items.Count > 0 then
    cmbDipendentiDisponibili.ItemIndex:=0;
end;

procedure TW004FReperibilita.btnEseguiClick(Sender: TObject);
// aggiorna la visualizzazione in base al periodo indicato
var
  c: Integer;
begin
  lstScrollBar[ScrollBarIndexOf('divscrollable')].Top:=0;
  lstScrollBar[ScrollBarIndexOf('divscrollable')].Left:=0;
  Dal:=StrToDate(edtPeriodoDal.Text);
  Al:=StrToDate(edtPeriodoAl.Text);

  if (not SolaLettura) and (Length(grdReperibilita.medpDescCompGriglia.RigaIns) > 0) then
  begin
    c:=grdReperibilita.medpIndexColonna('DATA');
    (grdReperibilita.medpCompCella(0,c,0) as TmeIWEdit).Text:=edtPeriodoDal.Text;
  end;

  GetDipendentiDisponibili;
  GetTurniPianificati;

  grdReperibilita.Visible:=True;
  if (Dal = R180InizioMese(Dal)) and (Al = R180FineMese(Dal)) then
    grdReperibilita.Caption:=IfThen(Tipologia = 'R','Reperibilità','Guardia') + ' del mese di ' + FormatDateTime('mmmm yyyy',Dal)
  else
    grdReperibilita.Caption:=Format('%s dal %s al %s',[IfThen(Tipologia = 'R','Reperibilità','Guardia'),edtPeriodoDal.Text,edtPeriodoAl.Text]);
  grdProspetto.Caption:=grdReperibilita.Caption;
end;

procedure TW004FReperibilita.imgAnnullaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // pulizia info dati anagrafici
  DatiAnag.Progressivo:=0;
  DatiAnag.Decorrenza:=DATE_NULL;
  DatiAnag.Nominativo:='';
  DatiAnag.Modificato:=False;

  grdReperibilita.medpBrowse:=True;
  if Operazione = 'I' then
    TrasformaComponentiInserimento
  else
    TrasformaComponenti(FN);

  // annullamento modifiche
  Operazione:='';
end;

procedure TW004FReperibilita.imgCancellaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if (Operazione <> '') then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione' + CRLF +
                      'di ' + IfThen(Operazione = 'I','inserimento','variazione') +
                      ' in corso prima di procedere!',INFORMA);
    Exit;
  end;
  Cancellazione(FN);
end;

procedure TW004FReperibilita.Cancellazione(FN: String);
begin
  DBGridColumnClick(nil,FN);
  // eliminazione record
  actCancellazioneOK(FN);
end;

procedure TW004FReperibilita.imgConfermaClick(Sender: TObject);
var
  FN: String;
  Ricarica: Boolean;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
  // valuta aggiornamento dati anagrafici
  // (effettuato indipendentemente dalla chiamata in reperibilità)
  Ricarica:=False;
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
    Ricarica:=True;
  end;
  // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine

  // applica le modifiche
  if not ModificheRiga(FN) then
  begin
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
    // se i dati anagrafici sono stati modificati ricarica tutto
    if Ricarica then
    begin
      GetTurniPianificati;
    end
    else
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine
    begin
      Operazione:='';
      grdReperibilita.medpBrowse:=True;
      TrasformaComponenti(FN);
    end;
    Exit;
  end;

  // se record non esiste -> errore grave
  if not W004DM.selT380.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    Operazione:='';
    grdReperibilita.medpBrowse:=True;
    TrasformaComponenti(FN);
    MsgBox.MessageBox('Si è verificato un errore durante la modifica della pianificazione:' + CRLF +
                      'il record non è più disponibile.',ESCLAMA);
    Exit;
  end;

  Modifica(FN);
end;

procedure TW004FReperibilita.Modifica(FN: String);
begin
  // effettua controlli bloccanti
  if ControlliOK(FN) then
    actInsVar0;
end;

procedure TW004FReperibilita.imgModificaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if (Operazione <> '') then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione' + CRLF +
                      'di ' + IfThen(Operazione = 'I','inserimento','variazione') +
                      ' in corso prima di procedere!',INFORMA);
    Exit;
  end;

  DBGridColumnClick(Sender,FN);

  // porta la riga in modifica: trasforma i componenti
  Operazione:='M';
  grdReperibilita.medpBrowse:=False;
  TrasformaComponenti(FN);
end;

procedure TW004FReperibilita.imgModificaDatiClick(Sender: TObject);
var
  r: Integer;
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // estrae dati dipendente e indice array per modifica
  with grdReperibilita do
  begin
    r:=medpRigaDiCompGriglia(FN);

    if Operazione = 'I' then
    begin
      DatiAnag.Nominativo:='';// T030NOMINATIVO
      //
    end
    else
    begin
      DatiAnag.Nominativo:=medpValoreColonna(r,'T030NOMINATIVO');
      DatiAnag.Progressivo:=StrToIntDef(medpValoreColonna(r,'PROGRESSIVO'),0);
    end;
  end;

  // prepara il clientdataset con i dati del dipendente selezionato
  PreparaDatiAnag;

  // apre il form di modifica dati anagrafici
  W002ModDatiFM:=TW002FModificaDatiFM.Create(Self);
  W002ModDatiFM.W002ModDatiDM:=Self.W002ModDatiDM;
  W002ModDatiFM.Progressivo:=DatiAnag.Progressivo;
  W002ModDatiFM.Nominativo:=DatiAnag.Nominativo;
  W002ModDatiFM.Visualizza;
end;

procedure TW004FReperibilita.imgInserisciClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if Operazione <> '' then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione' + CRLF +
                      'di ' + IfThen(Operazione = 'I','inserimento','variazione') +
                      ' in corso prima di procedere!',INFORMA);
    Exit;
  end;

  DBGridColumnClick(Sender,FN);

  Operazione:='I';
  grdReperibilita.medpBrowse:=False;
  TrasformaComponentiInserimento;
end;

procedure TW004FReperibilita.TrasformaComponentiInserimento;
// Creo i componenti della riga di inserimento
var
  c,j: Integer;
  DaTestoAControlli: Boolean;
begin
  with grdReperibilita do
  begin
    c:=medpIndexColonna('C_TURNO1');
    DaTestoAControlli:=medpCompGriglia[0].CompColonne[c] = nil;

    //Nascondo il pulsante inserisci
    with (medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
      Cell[0,1].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
      Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
    end;
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.ini
    {
    with (medpCompGriglia[0].CompColonne[ColSchedaAnag] as TmeIWGrid) do
    begin
      // modifica dati
      if Parametri.CampiRiferimento.C29_ChiamateRepDatiModif <> '' then
        Cell[0,0].Css:=StileCella1;
    end;
    }
    // SAVONA_ASL2 - commessa 2013/056 - SVILUPPO 2.fine
    if DaTestoAControlli then
    begin
      // matricola
      c:=medpIndexColonna('MATRICOLA');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        PopUpHeight:=15;
        ShowHint:=True;
        selAnagrafe.First;
        while not selAnagrafe.Eof do
        begin
          AddRow(selAnagrafe.FieldByName('MATRICOLA').AsString + ';' + selAnagrafe.FieldByName('COGNOME').AsString + ' ' + selAnagrafe.FieldByName('NOME').AsString);
          selAnagrafe.Next;
        end;
        if not selAnagrafe.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]) then
          selAnagrafe.First;
        Text:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
      end;
      // data
      c:=medpIndexColonna('DATA');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
      medpCreaComponenteGenerico(0,c,Componenti);
      (medpCompCella(0,c,0) as TmeIWEdit).Text:=edtPeriodoDal.Text;
      // turno 1
      c:=medpIndexColonna('C_TURNO1');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        Name:='cmbTurno1Ins';
        LookupColumn:=1;
        //PopUpWidth:=25;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to lstTurniDisponibili.Count - 1 do
          AddRow(lstTurniDisponibili[j]);
        Text:='';
      end;
      // priorità chiamata turno 1
      c:=medpIndexColonna('PRIORITA1');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TmeIWEdit) do
      begin
        MaxLength:=1;
        Text:='';
      end;
      // turno 2
      c:=medpIndexColonna('C_TURNO2');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        //PopUpWidth:=25;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to lstTurniDisponibili.Count - 1 do
          AddRow(lstTurniDisponibili[j]);
        Text:='';
      end;
      // priorità chiamata turno 2
      c:=medpIndexColonna('PRIORITA2');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TmeIWEdit) do
      begin
        MaxLength:=1;
        Text:='';
      end;

      // turno 3
      c:=medpIndexColonna('C_TURNO3');
      medpPreparaComponenteGenerico('C',0,0,DBG_MECMB,'10','2','','','S');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TMedpIWMultiColumnComboBox) do
      begin
        LookupColumn:=1;
        //PopUpWidth:=25;
        PopUpHeight:=15;
        ShowHint:=True;
        for j:=0 to lstTurniDisponibili.Count - 1 do
          AddRow(lstTurniDisponibili[j]);
        Text:='';
      end;
      // priorità chiamata turno 3
      c:=medpIndexColonna('PRIORITA3');
      medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'1','','','','');
      medpCreaComponenteGenerico(0,c,Componenti);
      with (medpCompCella(0,c,0) as TmeIWEdit) do
      begin
        MaxLength:=1;
        Text:='';
      end;

      // dato libero
      if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      begin
        c:=medpIndexColonna('DATOLIBERO');
        medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'20','','','','S');
        medpCreaComponenteGenerico(0,c,Componenti);
        with (medpCompCella(0,c,0) as TmeIWComboBox) do
        begin
          Items.Assign(lstDatoLibero);
          Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
          ItemIndex:=0;
          ItemsHaveValues:=True;
        end;
      end;
    end
    else
    begin
      // matricola
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('MATRICOLA')]);
      // data
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('DATA')]);
      // turno 1
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('C_TURNO1')]);
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('PRIORITA1')]);
      // turno 2
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('C_TURNO2')]);
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('PRIORITA2')]);
      // turno 3
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('C_TURNO3')]);
      FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('PRIORITA3')]);
      // dato libero
      if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
        FreeAndNil(medpCompGriglia[0].CompColonne[medpIndexColonna('DATOLIBERO')]);
    end;
    medpBrowse:=not DaTestoAControlli;
  end;
end;

procedure TW004FReperibilita.TurniIntersecati(T1, T2:String);
// determina se due turni si intersecano
var
  I1,I2,F1,F2,F1Ori,F2Ori:Integer;
begin
  with WR000DM do
  begin
    if (T1 <> '') and (T2 <> '') then
    try
      I1:=selT350.Lookup('CODICE',T1,'INIZIO');
      F1Ori:=selT350.Lookup('CODICE',T1,'FINE');
      F1:=F1Ori;
      if F1 <= I1 then
        inc(F1,1440);
      if T2 <> '' then
      begin
        I2:=selT350.Lookup('CODICE',T2,'INIZIO');
        F2Ori:=selT350.Lookup('CODICE',T2,'FINE');
        F2:=F2Ori;
        if F2 <= I2 then
          inc(F2,1440);
        if ((I2 >= I1) and (I2 < F1)) or ((F2 > I1) and (F2 <= F1)) or
           ((I2 <= I1) and (F2 >= F1)) then
        begin
          ErrMessage:=ErrMessage +
                      'Attenzione!' + CRLF +
                      'I seguenti turni si sovrappongono:' + CRLF +
                      SPAZIO + Format('%s: %s - %s',[T1,R180MinutiOre(I1),R180MinutiOre(F1Ori)]) + CRLF +
                      SPAZIO + Format('%s: %s - %s',[T2,R180MinutiOre(I2),R180MinutiOre(F2Ori)]) + CRLF;
          Abort;
        end;
      end;
    except
      ErrMessage:=ErrMessage +
                 'Esistono pianificazioni configurate non correttamente.' + CRLF+
                 'Vuoi continuare?' + CRLF;
      Exit;
    end;
  end;
end;

procedure TW004FReperibilita.TurniIntersecatiTipologieDiverse(T1,T2:String;DataRif:TDateTime);
var I1,I2,F1,F2,F1Ori,F2Ori:Integer;
  Tipo1,Tipo2:String;
begin
  Tipo1:=IfThen(Tipologia = 'R','Guardia','Reperibilità');
  Tipo2:=IfThen(Tipologia = 'R','Reperibilità','Guardia');

  if (T1 <> '') and (T2 <> '') then
  try
    with W004DM do
    begin
      I1:=R180OreMinuti(R180VarToDateTime(selT350Opposto.Lookup('CODICE',T1,'ORAINIZIO')));
      F1Ori:=R180OreMinuti(R180VarToDateTime(selT350Opposto.Lookup('CODICE',T1,'ORAFINE')));
      F1:=F1Ori;
      if F1 <= I1 then
        inc(F1,1440);
      if T2 <> '' then
      begin
        I2:=WR000DM.selT350.Lookup('CODICE',T2,'INIZIO');
        F2Ori:=WR000DM.selT350.Lookup('CODICE',T2,'FINE');
        F2:=F2Ori;
        if F2 <= I2 then
          inc(F2,1440);
        if ((I2 >= I1) and (I2 < F1)) or ((F2 > I1) and (F2 <= F1)) or
           ((I2 <= I1) and (F2 >= F1)) then
        begin
          ErrMessage:=ErrMessage +
                      'I turni si sovrappongono tra Reperibilità e Guardia in data ' +
                      DateToStr(DataRif) + CRLF +
                      Format('%s: %s: %s - %s',[Tipo1,T1,R180MinutiOre(I1),R180MinutiOre(F1Ori)]) + CRLF +
                      Format('%s: %s: %s - %s',[Tipo2,T2,R180MinutiOre(I2),R180MinutiOre(F2Ori)]) + CRLF;
          Abort;
        end;
      end;
    end;
  except
    ErrMessage:=ErrMessage +
                'In data ' + DateToStr(DataRif) + ' esistono pianificazioni di ' +
                'reperibilità/guardia configurate non correttamente.' + CRLF +
                'Vuoi continuare?' + CRLF;
    Exit;
  end;
end;

function TW004FReperibilita.RaggruppamentiAbilitati(Prog:Integer; DataRif:TDateTime): Boolean;
// Controllo se il dipendente ha delle causali di presenza adeguate abilitate in data
var i: Integer;
begin
  Result:=False;
  with W004DM.selT430Contratto do
  begin
    Close;
    SetVariable('Progressivo',Prog);
    SetVariable('Data',DataRif);
    Open;
  end;

  with TStringList.Create do
  try
    CommaText:=W004DM.selT430Contratto.FieldByName('AbPresenza1').AsString;
    for i:=0 to Count - 1 do
      if W004DM.selT270.Locate('Codice',Strings[i],[]) then
      begin
        Result:=True;
        Break;
      end;
  finally
    Free;
  end;
end;

function TW004FReperibilita.GiornataAssenza(Data:TDateTime; Progressivo: Integer): Boolean;
// Verifica se nel giorno corrente è presente una giornata di assenza
begin
  with W004DM.selT040Assenza do
  begin
    Close;
    SetVariable('Progressivo',Progressivo);
    SetVariable('Data',Data);
    Open;
    if RecordCount > 0 then
      ErrMessage:=ErrMessage +
                  'Nel giorno ' + DateToStr(Data) + ' è presente una giornata di assenza ' +
                  FieldByName('Causale').AsString + '.' + CRLF +
                  'Vuoi continuare?' + CRLF;
    Result:=(RecordCount > 0);
  end;
end;

function TW004FReperibilita.TurnoNonInserito(C1,C2,C3:String; Data:TDateTime; Prog:Integer):Boolean;
// Verifica se lo stesso turno è già stato pianificato da un altro dipendente
begin
  with W004DM.selT380Controllo do
  begin
    Close;
    SetVariable('DATA',Data);
    SetVariable('T1',C1);
    SetVariable('T2',C2);
    SetVariable('T3',C3);
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('TIPOLOGIA', Tipologia);
    Open;
    Result:=(Fields[0].Value = 0);
    if not Result then
    begin
      if (Trim(C1) <> '') and (Trim(C2) <> '') then
        C1:=C1 + ' o ';
      C1:=C1 + C2;
      if (Trim(C1) <> '') and (Trim(C3) <> '') then
        C1:=C1 + ' o ';
      C1:=C1 + C3;
      ErrMessage:=ErrMessage +
                  'Il turno ' + C1 + ' è già stato pianificato il '+ DateToStr(Data) + '.' + CRLF +
                  'Registrarlo ugualmente?' + CRLF;
    end;
  end;
end;

// inizio flusso di controlli
procedure TW004FReperibilita.actInsVar1;
begin
  TurniIntersecati(T1, T2);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar2,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar2,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar2;
end;

procedure TW004FReperibilita.actInsVar2;
begin
  TurniIntersecati(T1, T3);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar3,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar3,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar3;
end;

procedure TW004FReperibilita.actInsVar3;
begin
  TurniIntersecati(T2, T3);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar4,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar4,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar4;
end;

procedure TW004FReperibilita.actInsVar4;
begin
  // verifica intersezione turni fra guardia e reperibilità
  with W004DM.selT380a do
  begin
    Close;
    SetVariable('PROGRESSIVO', Progressivo);
    SetVariable('DATA', Data);
    SetVariable('TIPOLOGIA', Tipologia);
    Open;
    if RecordCount > 0 then
    begin
      // prosegue con i controlli
      T1a:=FieldByName('TURNO1').AsString;
      T2a:=FieldByName('TURNO2').AsString;
      T3a:=FieldByName('TURNO3').AsString;
      actInsVar5;
    end
    else
    begin
      // esegue inserimento / variazione
      if Operazione = 'I' then
        actInserimentoOK
      else
        actVariazioneOK;
    end;
  end;
end;

procedure TW004FReperibilita.actInsVar5;
begin
  TurniIntersecatiTipologieDiverse(T1a, T1, Data);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar6,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar6,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar6;
end;

procedure TW004FReperibilita.actInsVar6;
begin
  TurniIntersecatiTipologieDiverse(T1a, T2, Data);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar7,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar7,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar7;
end;

procedure TW004FReperibilita.actInsVar7;
begin
  TurniIntersecatiTipologieDiverse(T1a, T3, Data);
  
  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar8,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar8,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar8;
end;

procedure TW004FReperibilita.actInsVar8;
begin
  TurniIntersecatiTipologieDiverse(T2a, T1, Data);
  
  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar9,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar9,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar9;
end;

procedure TW004FReperibilita.actInsVar9;
begin
  TurniIntersecatiTipologieDiverse(T2a, T2, Data);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar10,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar10,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar10;
end;

procedure TW004FReperibilita.actInsVar10;
begin
  TurniIntersecatiTipologieDiverse(T2a, T3, Data);

  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar11,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar11,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar11;
end;

procedure TW004FReperibilita.actInsVar11;
begin
  TurniIntersecatiTipologieDiverse(T3a, T1, Data);
  
  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar12,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar12,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar12;
end;

procedure TW004FReperibilita.actInsVar12;
begin
  TurniIntersecatiTipologieDiverse(T3a, T2, Data);
  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInsVar13,nil)
    else
      Messaggio('Conferma',ErrMessage,actInsVar13,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  actInsVar13;
end;

procedure TW004FReperibilita.actInsVar13;
begin
  TurniIntersecatiTipologieDiverse(T3a, T3, Data);
  if ErrMessage <> '' then
  begin
    if Operazione = 'I' then
      Messaggio('Conferma',ErrMessage,actInserimentoOK,nil)
    else
      Messaggio('Conferma',ErrMessage,actVariazioneOK,GetTurniPianificati);
    ErrMessage:='';
    Exit;
  end;

  if Operazione = 'I' then
    actInserimentoOK
  else
    actVariazioneOK;
end;

procedure TW004FReperibilita.actInserimentoOK;
// controlli ok -> inserimento record di pianificazione
begin
  if grdModifica <> grdReperibilita then
    W004DM.selT380.Delete;//Cancello il record fittizio precedentemente creato in W004FModificaTabelloneFM
  with W004DM.insT380 do
  begin
    ClearVariables;
    SetVariable('MATRICOLA',M);
    SetVariable('DATA',Data);
    SetVariable('TURNO1',T1);
    if P1 <> 0 then
      SetVariable('PRIORITA1',P1);
    SetVariable('TURNO2',T2);
    if P2 <> 0 then
      SetVariable('PRIORITA2',P2);
    SetVariable('TURNO3',T3);
    if P3 <> 0 then
      SetVariable('PRIORITA3',P3);
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      SetVariable('DATOLIBERO',DL);
    SetVariable('TIPOLOGIA',Tipologia);
    try
      Execute;
    except
      on E: Exception do
      begin
        MsgBox.MessageBox('Inserimento fallito: ' + CRLF + E.Message,ESCLAMA);
        Exit;
      end;
    end;
    RegistraLog.SettaProprieta('I','T380_PIANIFREPERIB',medpCodiceForm,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',GetVariable('PROGRESSIVO'));
    RegistraLog.InserisciDato('DATA','',DateToStr(Data));
    RegistraLog.InserisciDato('TURNO1','',T1);
    RegistraLog.InserisciDato('PRIORITA1','',IfThen(P1 = 0,'',IntToStr(P1)));
    RegistraLog.InserisciDato('TURNO2','',T2);
    RegistraLog.InserisciDato('PRIORITA2','',IfThen(P2 = 0,'',IntToStr(P2)));
    RegistraLog.InserisciDato('TURNO3','',T3);
    RegistraLog.InserisciDato('PRIORITA3','',IfThen(P3 = 0,'',IntToStr(P3)));
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      RegistraLog.InserisciDato('DATOLIBERO','',DL);
    RegistraLog.InserisciDato('TIPOLOGIA','',Tipologia);
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  end;

  // rilegge i dati
  //GetTurniPianificati;
  if (grdModifica <> grdReperibilita) and (W004FModTabFM <> nil) then
    W004FModTabFM.AfterInserimento
  else
    GetTurniPianificati;
end;

procedure TW004FReperibilita.actVariazioneOK;
// controlli ok -> variazione record di pianificazione
begin
  with W004DM.selT380 do
  begin
    Edit;
    FieldByName('DATA').AsDateTime:=Data;
    FieldByName('TURNO1').AsString:=T1;
    if P1 = 0 then
      FieldByName('PRIORITA1').AsVariant:=null
    else
      FieldByName('PRIORITA1').AsInteger:=P1;
    FieldByName('TURNO2').AsString:=T2;
    if P2 = 0 then
      FieldByName('PRIORITA2').AsVariant:=null
    else
      FieldByName('PRIORITA2').AsInteger:=P2;
    FieldByName('TURNO3').AsString:=T3;
    if P3 = 0 then
      FieldByName('PRIORITA3').AsVariant:=null
    else
      FieldByName('PRIORITA3').AsInteger:=P3;
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
      FieldByName('DATOLIBERO').AsString:=DL;
    try
      Post;
      RegistraLog.SettaProprieta('M','T380_PIANIFREPERIB',medpCodiceForm,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO',FieldByName('PROGRESSIVO').AsString,FieldByName('PROGRESSIVO').AsString);
      RegistraLog.InserisciDato('DATA',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'DATA')),FieldByName('DATA').AsString);
      RegistraLog.InserisciDato('TURNO1',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'TURNO1')),FieldByName('TURNO1').AsString);
      RegistraLog.InserisciDato('PRIORITA1',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'PRIORITA1')),FieldByName('PRIORITA1').AsString);
      RegistraLog.InserisciDato('TURNO2',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'TURNO2')),FieldByName('TURNO2').AsString);
      RegistraLog.InserisciDato('PRIORITA2',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'PRIORITA2')),FieldByName('PRIORITA2').AsString);
      RegistraLog.InserisciDato('TURNO3',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'TURNO3')),FieldByName('TURNO3').AsString);
      RegistraLog.InserisciDato('PRIORITA3',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'PRIORITA3')),FieldByName('PRIORITA3').AsString);
      if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
        RegistraLog.InserisciDato('DATOLIBERO',VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',RowID,'DATOLIBERO')),FieldByName('DATOLIBERO').AsString);
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      on E: Exception do
        MsgBox.MessageBox('Variazione fallita: ' + CRLF + E.Message,ESCLAMA);
    end;
  end;
  // rilegge i dati
  //GetTurniPianificati;
  if (grdModifica <> grdReperibilita) and (W004FModTabFM <> nil) then
    W004FModTabFM.AfterModifica
  else
    GetTurniPianificati;
end;

function TW004FReperibilita.ModificheRiga(const FN: String): Boolean;
// Restituisce True/False a seconda che il record sia stato modificato o meno
var
  i:Integer;
  IWCmb: TmeIWComboBox;
begin
  Result:=False;
  if not cdsT380.Locate('DBG_ROWID',FN,[]) then
    exit;

  with grdReperibilita do
  begin
    i:=medpRigaDiCompGriglia(FN);
    Result:=(cdsT380.FieldByName('DATA').AsString <> (medpCompCella(i,'DATA',0) as TmeIWEdit).Text) or
            (cdsT380.FieldByName('TURNO1').AsString <> (medpCompCella(i,'C_TURNO1',0) as TMedpIWMultiColumnComboBox).Text) or
            (cdsT380.FieldByName('PRIORITA1').AsString <> (medpCompCella(i,'PRIORITA1',0) as TmeIWEdit).Text) or
            (cdsT380.FieldByName('TURNO2').AsString <> (medpCompCella(i,'C_TURNO2',0) as TMedpIWMultiColumnComboBox).Text) or
            (cdsT380.FieldByName('PRIORITA2').AsString <> (medpCompCella(i,'PRIORITA2',0) as TmeIWEdit).Text) or
            (cdsT380.FieldByName('TURNO3').AsString <> (medpCompCella(i,'C_TURNO3',0) as TMedpIWMultiColumnComboBox).Text) or
            (cdsT380.FieldByName('PRIORITA3').AsString <> (medpCompCella(i,'PRIORITA3',0) as TmeIWEdit).Text);
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    begin
      IWCmb:=(medpCompCella(i,'DATOLIBERO',0) as TmeIWComboBox);
      Result:=Result or (cdsT380.FieldByName('DATOLIBERO').AsString <> IWCmb.Items.ValueFromIndex[IWCmb.ItemIndex]);
    end;
  end;
end;

function TW004FReperibilita.ControlliOK(const FN:String): Boolean;
var
  i: Integer;
  IWC: TIWCustomControl;
  Stato: TDataSetState;
  RI: String;
  function CheckTurno(LCB:TIWCustomControl):Boolean;
  var T:String;
  begin
    Result:=True;
    T:=(LCB as TMedpIWMultiColumnComboBox).Text;
    if (T <> '') and (VarToStr(WR000DM.selT350.Lookup('CODICE',T,'CODICE')) = '') then
    begin
      Result:=False;
      MsgBox.MessageBox(Format(A000MSG_ERR_FMT_NON_ESISTENTE + ' (%s)',['Turno',T]),INFORMA);
      ActiveControl:=LCB;
    end;
  end;
begin
  Result:=False;
  ErrMessage:='';
  WR000DM.selDatiBloccati.Close;

  Dal:=StrToDate(edtPeriodoDal.Text);
  Al:=StrToDate(edtPeriodoAl.Text);

  Operazione:=IfThen(FN = '*','I','M');//utile per il richiamo da W004UModificaTabelloneFM e compatibile con gestione standard
  if Operazione = 'I' then
  begin
    // imposta i dati per l'inserimento
    // matricola
    M:=Trim((grdModifica.medpCompCella(0,'MATRICOLA',0) as TMedpIWMultiColumnComboBox).Text);

    // data
    IWC:=grdModifica.medpCompCella(0,'DATA',0);
    if not TryStrToDate((IWC as TmeIWEdit).Text,Data) then
    begin
      MsgBox.MessageBox('La data specificata è errata!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;

    // turno 1 e priorità
    T1:=(grdModifica.medpCompCella(0,'C_TURNO1',0) as TMedpIWMultiColumnComboBox).Text;
    if not CheckTurno(grdModifica.medpCompCella(0,'C_TURNO1',0)) then
      exit;
    IWC:=grdModifica.medpCompCella(0,'PRIORITA1',0);
    if (IWC as TmeIWEdit).Text = '' then
      P1:=0
    else if not TryStrToInt((IWC as TmeIWEdit).Text,P1) then
    begin
      MsgBox.MessageBox('La priorità di chiamata del turno 1 deve essere compresa fra 1 e 9!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end
    else if P1 <= 0 then
    begin
      MsgBox.MessageBox('La priorità di chiamata del turno 1 deve essere compresa fra 1 e 9!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;

    // turno 2 e priorità
    T2:=(grdModifica.medpCompCella(0,'C_TURNO2',0) as TMedpIWMultiColumnComboBox).Text;
    if T2 <> '' then
    begin
      if not CheckTurno(grdModifica.medpCompCella(0,'C_TURNO2',0)) then
        exit;
      IWC:=grdModifica.medpCompCella(0,'PRIORITA2',0);
      if (IWC as TmeIWEdit).Text = '' then
        P2:=0
      else if not TryStrToInt((IWC as TmeIWEdit).Text,P2) then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 2 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end
      else if P2 <= 0 then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 2 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end
    else
      P2:=0;

    // turno 3 e priorità
    T3:=(grdModifica.medpCompCella(0,'C_TURNO3',0) as TMedpIWMultiColumnComboBox).Text;
    if T3 <> '' then
    begin
      if not CheckTurno(grdModifica.medpCompCella(0,'C_TURNO3',0)) then
        exit;
      IWC:=grdModifica.medpCompCella(0,'PRIORITA3',0);
      if (IWC as TmeIWEdit).Text = '' then
        P3:=0
      else if not TryStrToInt((IWC as TmeIWEdit).Text,P3) then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 3 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end
      else if P3 <= 0 then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 3 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end
    else
      P3:=0;

    // dato libero
    DL:='';
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    begin
      IWC:=grdModifica.medpCompCella(0,'DATOLIBERO',0);
      DL:=Trim((IWC as TmeIWComboBox).Items.ValueFromIndex[(IWC as TmeIWComboBox).ItemIndex]);
    end;
  end
  else
  begin
    // imposta i dati per la variazione
    i:=grdModifica.medpRigaDiCompGriglia(FN);
    M:=VarToStr(grdModifica.DataSource.DataSet.Lookup('DBG_ROWID',FN,'MATRICOLA'));

    // data
    IWC:=grdModifica.medpCompCella(i,'DATA',0);
    if not TryStrToDate((IWC as TmeIWEdit).Text,Data) then
    begin
      MsgBox.MessageBox('La data specificata è errata!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;

    // turno 1
    T1:=(grdModifica.medpCompCella(i,'C_TURNO1',0) as TMedpIWMultiColumnComboBox).Text;
    if not CheckTurno(grdModifica.medpCompCella(i,'C_TURNO1',0)) then
      exit;
    IWC:=grdModifica.medpCompCella(i,'PRIORITA1',0);
    if (IWC as TmeIWEdit).Text = '' then
      P1:=0
    else if not TryStrToInt((IWC as TmeIWEdit).Text,P1) then
    begin
      MsgBox.MessageBox('La priorità di chiamata del turno 1 deve essere compresa fra 1 e 9!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end
    else if P1 <= 0 then
    begin
      MsgBox.MessageBox('La priorità di chiamata del turno 1 deve essere compresa fra 1 e 9!',INFORMA);
      ActiveControl:=IWC;
      Exit;
    end;

    // turno 2
    T2:=(grdModifica.medpCompCella(i,'C_TURNO2',0) as TMedpIWMultiColumnComboBox).Text;
    if T2 <> '' then
    begin
      if not CheckTurno(grdModifica.medpCompCella(i,'C_TURNO2',0)) then
        exit;
      IWC:=grdModifica.medpCompCella(i,'PRIORITA2',0);
      if (IWC as TmeIWEdit).Text = '' then
        P2:=0
      else if not TryStrToInt((IWC as TmeIWEdit).Text,P2) then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 2 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end
      else if P2 <= 0 then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 2 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end
    else
      P2:=0;

    // turno 3
    T3:=(grdModifica.medpCompCella(i,'C_TURNO3',0) as TMedpIWMultiColumnComboBox).Text;
    if T3 <> '' then
    begin
      if not CheckTurno(grdModifica.medpCompCella(i,'C_TURNO3',0)) then
        exit;
      IWC:=grdModifica.medpCompCella(i,'PRIORITA3',0);
      if (IWC as TmeIWEdit).Text = '' then
        P3:=0
      else if not TryStrToInt((IWC as TmeIWEdit).Text,P3) then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 3 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end
      else if P3 <= 0 then
      begin
        MsgBox.MessageBox('La priorità di chiamata del turno 3 deve essere compresa fra 1 e 9!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
    end
    else
      P3:=0;

    // dato libero
    DL:='';
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    begin
      IWC:=grdModifica.medpCompCella(i,'DATOLIBERO',0);
      DL:=Trim((IWC as TmeIWComboBox).Items.ValueFromIndex[(IWC as TmeIWComboBox).ItemIndex])
    end;
  end;

  if (Data < Dal) or (Data > Al) then
  begin
    MsgBox.MessageBox('La data è esterna al periodo specificato!',INFORMA);
    Exit;
  end;
  if M = '' then
  begin
    MsgBox.MessageBox('Specificare la matricola del dipendente!',INFORMA);
    Exit;
  end;
  if T1 = '' then
  begin
    MsgBox.MessageBox('Specificare il turno 1!',INFORMA);
    Exit;
  end;
  with selAnagrafe do
  begin
    SetVariable('DATALAVORO',Data);
    if not SearchRecord('MATRICOLA',M,[srFromBeginning]) then
    begin
      MsgBox.MessageBox('La matricola indicata non è valida!',INFORMA);
      Exit;
    end;
    Progressivo:=FieldByName('PROGRESSIVO').AsInteger;
  end;
  // verifiche sulla base dati
  with WR000DM do
  begin
    // controllo raggruppamenti abilitati
    if not RaggruppamentiAbilitati(Progressivo, Data) then
    begin
      MsgBox.MessageBox('Il dipendente non ha raggruppamenti di ' +
                        IfThen(Tipologia = 'R','reperibilità','guardia') +
                        ' abilitati in data ' + DateToStr(Data) + '!',INFORMA);
      Exit;
    end;
    // verifica dato bloccato
    if WR000DM.selDatiBloccati.DatoBloccato(Progressivo,R180InizioMese(Data),'T380') then
    begin
      MsgBox.MessageBox(IfThen(Operazione = 'I','Inserimento non consentito!','Variazione non consentita!') + CRLF +
                        'Motivo: ' + WR000DM.selDatiBloccati.MessaggioLog,INFORMA);
      Exit;
    end;
    // verifica turno ripetuto
    if (T1 = T2) or
       ((T1 <> '') and (T1 = T3)) or
       ((T2 <> '') and (T2 = T3)) then
    begin
      MsgBox.MessageBox('Il dipendente non può fare due volte lo stesso turno!',INFORMA);
      Exit;
    end;
    // errore se turno 3 inserito ma turno 2 vuoto
    if (T2 = '') and (T3 <> '') then
    begin
      MsgBox.MessageBox('Pianificare prima il turno 2!',INFORMA);
      Exit;
    end;

    // verifica pianificazione già esistente (in base a inserimento / variazione)
    if Operazione = 'I' then
    begin
      if grdModifica = grdReperibilita then
      begin
        Stato:=dsInsert;
        RI:='';
      end
      else //In W004FModificaTabelloneFM creo già un record fittizio sulla tabella
      begin
        Stato:=dsEdit;
        RI:=W004DM.selT380.RowId;
      end;
      if QueryPK1.EsisteChiave('T380_PIANIFREPERIB',RI,Stato,['PROGRESSIVO','DATA','TIPOLOGIA'],[IntToStr(Progressivo),DateToStr(Data),Tipologia]) then
      begin
        MsgBox.MessageBox('Pianificazione già esistente!',INFORMA);
        Exit;
      end
    end
    else
    begin
      if QueryPK1.EsisteChiave('T380_PIANIFREPERIB',W004DM.selT380.RowId,dsEdit,['PROGRESSIVO','DATA','TIPOLOGIA'],[IntToStr(Progressivo),DateToStr(Data),Tipologia]) then
      begin
        MsgBox.MessageBox('Pianificazione già esistente!',INFORMA);
        Exit;
      end
    end;
  end;
  Result:=True;
end;

procedure TW004FReperibilita.imgConfermaInserimentoClick(Sender: TObject);
begin
  Inserimento;
end;

procedure TW004FReperibilita.Inserimento;
begin
  // controlli bloccanti sui dati
  if not ControlliOK('*') then
    Exit;

  // verifica se nella data è già indicata un'assenza
  if (GiornataAssenza(Data, Progressivo)) or
     ((not chkNonContDipPian.Checked) and
      (not TurnoNonInserito(T1,T2,T3,Data,Progressivo))) then
  begin
    ErrMessage:='Attenzione!' + CRLF + ErrMessage;
    Messaggio('Conferma',ErrMessage,actInsVar1,nil);
    ErrMessage:='';
    Exit;
  end;
  if MsgBox.IsActive then
    Exit;
  actInsVar0;
end;

procedure TW004FReperibilita.actInsVar0;
begin
  // controllo vincoli individuali
  with W004DM do
  begin
    R180SetVariable(selT385,'PROGRESSIVO',Progressivo);
    R180SetVariable(selT385,'TIPO',Tipologia);
    R180SetVariable(selT385,'DATA',Data);
    selT385.Open;
    selT385.First;
    ErrMessage:='';
    ErrBloccante:=False;
    //while (not selT385.Eof) and (not ErrBloccante) do
    begin
      ControlloVincoliIndividuali(T1);
      if not ErrBloccante then
        ControlloVincoliIndividuali(T2);
      if not ErrBloccante then
        ControlloVincoliIndividuali(T3);
      //selT385.Next;
    end;
  end;
  if ErrBloccante then
  begin
    MsgBox.MessageBox(ErrMessage,INFORMA);
    Exit;
  end
  else if ErrMessage <> '' then
  begin
    Messaggio('Conferma',ErrMessage + CRLF + 'Continuare?',actInsVar1,nil);
    ErrMessage:='';
    Exit;
  end;
  if MsgBox.IsActive then
    Exit;
  actInsVar1;
end;

procedure TW004FReperibilita.ControlloVincoliIndividuali(TurnoVincoli:String);
var Messaggio:String;
begin
  if Trim(TurnoVincoli) = '' then
    Exit;
  //Priorità: FS/PF - (1..7) - *
  //se il giorno del vincolo è FS e la data pianif. è un festivo
  with W004DM do
  begin
    if (selT385.SearchRecord('GIORNO','FS',[srFromBeginning])) and
       (selT385.FieldByName('DTFESTIVO').AsString = 'S') then
    begin
      if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
      begin
        Messaggio:='In data ' + VarToStr(selT385.GetVariable('DATA')) + ' il turno ' + TurnoVincoli + ' non è disponibile nei vincoli di pianificazione dei giorni festivi';
        if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        begin
          ErrMessage:='Attenzione:' + CRLF + Messaggio;
          ErrBloccante:=True;
        end
        else
        begin
          if ErrMessage = '' then
            ErrMessage:='Attenzione:';
          ErrMessage:=ErrMessage + CRLF + Messaggio;
        end;
      end;
      exit;
    end;
    //se il giorno del vincolo è PF e la data pianif. è un prefestivo
    if (selT385.SearchRecord('GIORNO','PF',[srFromBeginning])) and
       (selT385.FieldByName('DTPREFESTIVO').AsString = 'S') then
    begin
      if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
      begin
        Messaggio:='In data ' + VarToStr(selT385.GetVariable('DATA')) + ' il turno ' + TurnoVincoli + ' non è disponibile nei vincoli di pianificazione dei giorni prefestivi';
        if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        begin
          ErrMessage:='Attenzione:' + CRLF + Messaggio;
          ErrBloccante:=True;
        end
        else
        begin
          if ErrMessage = '' then
            ErrMessage:='Attenzione:';
          ErrMessage:=ErrMessage + CRLF + Messaggio;
        end;
      end;
      exit;
    end;
    //se il giorno del vincolo è uguale al giorno della data pianif.
    if selT385.SearchRecord('GIORNO',DayOfWeek(selT385.GetVariable('DATA') - 1),[srFromBeginning]) then
    begin
      if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
      begin
        Messaggio:='In data ' + VarToStr(selT385.GetVariable('DATA')) + ' il turno ' + TurnoVincoli + ' non è disponibile nei vincoli di pianificazione del ' + R180NomeGiorno(StrToDate(VarToStr(selT385.GetVariable('DATA'))));
        if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        begin
          ErrMessage:='Attenzione:' + CRLF + Messaggio;
          ErrBloccante:=True;
        end
        else
        begin
          if ErrMessage = '' then
            ErrMessage:='Attenzione:';
          ErrMessage:=ErrMessage + CRLF + Messaggio;
        end;
      end;
      exit;
    end;
    //se il giorno del vincolo è Tutti
    if selT385.SearchRecord('GIORNO','*',[srFromBeginning]) then
    begin
      if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and (Pos(',' + TurnoVincoli + ',',',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
      begin
        Messaggio:='In data ' + VarToStr(selT385.GetVariable('DATA')) + ' il turno ' + TurnoVincoli + ' non è disponibile nei vincoli di pianificazione generali!';
        if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        begin
          ErrMessage:='Attenzione:' + CRLF + Messaggio;
          ErrBloccante:=True;
        end
        else
        begin
          if ErrMessage = '' then
            ErrMessage:='Attenzione:';
          ErrMessage:=ErrMessage + CRLF + Messaggio;
        end;
      end;
    end;
  end;
end;

procedure TW004FReperibilita.lnkDipendentiDisponibiliClick(Sender: TObject);
var
  Matricola:String;
begin
  Matricola:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
  WC002FDatiAnagraficiFM:=TWC002FDatiAnagraficiFM.Create(Self);
  WC002FDatiAnagraficiFM.ParMatricola:=Matricola;
  WC002FDatiAnagraficiFM.AllowClick:=True;
  WC002FDatiAnagraficiFM.VisualizzaScheda;
end;

procedure TW004FReperibilita.lnkLegendaColoriGiorniClick(Sender: TObject);
begin
  W004FLegendaColoriFM:=TW004FLegendaColoriFM.Create(Self);
end;

procedure TW004FReperibilita.rgpTipologiaClick(Sender: TObject);
var
  S, Elementi: String;
begin
  Tipologia:=IfThen(rgpTipologia.ItemIndex = 0,'R','G');

  lstTurniDisponibili.Clear;
  //lstTurniDisponibili.Add(';');
  // raggruppamenti presenze
  with W004DM.selT270 do
  begin
    Close;
    if Tipologia = 'R' then
      SetVariable('CODINTERNO','C')
    else if Tipologia = 'G' then
      SetVariable('CODINTERNO','D');
    Open;
  end;

  // inizializzazione turni disponibili
  Elementi:='';
  with WR000DM.selT350 do
  begin
    Close;
    SetVariable('TIPOLOGIA',Tipologia);
    Filtered:=True;
    Open;
    First;
    while not Eof do
    begin
      S:=StringReplace(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]);
      lstTurniDisponibili.Add(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    Filtered:=False;
  end;

  with W004DM.selT350Opposto do
  begin
    Close;
    SetVariable('TIPOLOGIA',Tipologia);
    Open;
  end;

  btnEseguiClick(Sender);
end;

procedure TW004FReperibilita.tabReperibilitaTabControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  if tabReperibilita.ActiveTab <> nil then
    OldTabIndex:=tabReperibilita.ActiveTabIndex;
end;

procedure TW004FReperibilita.tabReperibilitaTabControlChange(Sender: TObject);
begin
  if OldTabIndex <> tabReperibilita.ActiveTabIndex then
  begin
    if tabReperibilita.ActiveTab = W004DettaglioRG then
      CaricaTurniDettaglio
    else
      CaricaTurniTabellone;
  end;
end;

procedure TW004FReperibilita.DistruggiOggetti;
// distrugge componenti creati dinamicamente
begin
  FreeAndNil(W004DM);
  FreeAndNil(W002ModDatiDM);
  if selAnagrafe <> nil then
    FreeAndNil(selAnagrafe);
  FreeAndNil(lstDatoLibero);
  FreeAndNil(lstTurniDisponibili);

  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT350);
  end;
end;

procedure TW004FReperibilita.OnTabChanging(var AllowChange: Boolean; var Conferma: String);
begin
  if Operazione <> '' then
    Conferma:='Attenzione! La pianificazione in fase di ' + IfThen(Operazione = 'I','inserimento','modifica') + ' non è stata confermata.' + CRLF +
              'Vuoi continuare?';
end;

procedure TW004FReperibilita.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  if Operazione <> '' then
    Conferma:='Attenzione! La pianificazione in fase di ' + IfThen(Operazione = 'I','inserimento','modifica') + ' non è stata confermata.' + CRLF +
              'Uscire comunque dalla funzione?';
end;

function TW004FReperibilita.GetProgressivo: Integer;
// il progressivo attuale è quello di selAnagrafe
begin
  Result:=-1;
  if selAnagrafe <> nil then
  begin
    try
      if selAnagrafe.Active and (selAnagrafe.RecordCount > 0) then
        Result:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    except
    end;
  end;
end;

function TW004FReperibilita.GetInfoFunzione: String;
begin
  Result:='';
  if selAnagrafe <> nil then
  begin
    try
      with selAnagrafe do
      begin
        if Active and (selAnagrafe.RecordCount > 0) then
          Result:=Format('%s: %s<br>%s: %s %s',
                         [A000TraduzioneStringhe(A000MSG_MSG_MATRICOLA),
                          FieldByName('MATRICOLA').AsString,
                          A000TraduzioneStringhe(A000MSG_MSG_NOMINATIVO),
                          FieldByName('COGNOME').AsString,
                          FieldByName('NOME').AsString]);
      end;
    except
    end;
  end;
end;

end.
