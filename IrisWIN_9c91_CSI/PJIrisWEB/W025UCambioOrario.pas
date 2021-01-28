unit W025UCambioOrario;

interface

uses
  R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase,
  C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  A000UCostanti, A000USessione, A000UInterfaccia, meIWComboBox, meIWCheckBox,
  DatiBloccati, Rp502Pro, WC001ULegendaCalendarioFM, W025UCambioOrarioDM,
  IWApplication, IWAppForm, SysUtils, Classes, meIWGrid,
  Controls, IWControl, IWCompListbox, meIWEdit,
  meIWButton, OracleData, Variants, IWVCLBaseControl,
  Forms, IWVCLBaseContainer, IWContainer, DB, meIWMemo,
  StrUtils, DBClient, Math, IWDBGrids, medpIWDBGrid,
  meIWLink, IWCompGrids, IWCompExtCtrls, meIWImageFile, meIWLabel, Menus,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWBaseControl, IWBaseHTMLControl,
  IWHTMLControls, IWCompLabel, IWCompButton;

type

  TDatiRichiesta = record
    Note:String;
  end;

  TW025FCambioOrario = class(TR013FIterBase)
    dsrT085: TDataSource;
    cdsT085: TClientDataSet;
    lnkLegendaColoriGiorni: TmeIWLink;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure rgpVisualizzazioneClick(Sender: TObject);
    function FormattaDatiT280: String;
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure lnkLegendaColoriGiorniClick(Sender: TObject);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    Operazione: String;
    TCO,CssEdit,CssCombo:String;
    vData,GiornoOriginale:TDateTime;
    ColCFData,ColCFOrario,ColCFDataInver,ColCFOrarioInver,ColSoloNote,ColDbgIter:Integer;
    R502ProDtM1:TR502ProDtM1;
    StileCella1,StileCella2,StileCella3,StileCella4,StileCella5: String;
    DatiRichiesta:TDatiRichiesta;
    WC001FLegendaCalendarioFM: TWC001FLegendaCalendarioFM;
    W025DM:TW025FCambioOrarioDM;
    procedure actCancRichiesta(FN: String);
    procedure actInsRichiesta(FN: String);
    procedure ConfermaInsRichiesta;
    procedure AnnullaInsRichiesta;
    //procedure actModRichiesta(FN: String);
    procedure AutorizzazioneOK(RowidT085,Aut: String);
    procedure CreaComponentiRiga(FN: String);
    procedure DistruggiComponentiRiga(FN: String);
    procedure imgModificaClick(Sender:TObject);
    procedure imgInserisciClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgCancellaClick(Sender: TObject);
    procedure TrasformaComponenti(FN:String);
    function ControlliOK(FN: String): Boolean;
    procedure AggiornamentoCalendarioIndividuale(Prog:Integer; DataO,DataR:TDateTime);
    procedure AggiornamentoPianificazioneOrari(Prog:Integer; DataO,DataR:TDateTime; OrarioO,OrarioR:String);
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure RicavaGiorni(Data: TDateTime; var Giorni: TStringList);
    procedure RicavaOrario(Prog:Integer; Data: TDateTime; ElencoOrariDisponibili: Boolean; OrarioO:String; var Orari: TStringList);
    function RicavaDescrizioneOrario(Orario: String; Data: TDateTime): String;
    function RicavaTipoGiorno(Prog:Integer; Data: TDateTime): String;
    function RicavaColoreGiorno(Prog: Integer; Data: TDateTime; Stile: String): String;
    procedure cmbGiornoChange(Sender: TObject);
    procedure CampoGiornoSubmit(Sender: TObject);
    procedure AggiornaClick(Sender:TObject);
    procedure chkSoloNoteClick(Sender:TObject);
    procedure imgIterClick(Sender: TObject);
    procedure W025AutorizzaTutti(Sender: TObject; var Ok: Boolean);
  protected
    procedure GetDipendentiDisponibili(Data: TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses W001UIrisWebDtM, SyncObjs;

{$R *.DFM}

function TW025FCambioOrario.InizializzaAccesso:Boolean;
begin
  // controlli sui parametri aziendali
  Result:=False;
  if Parametri.CampiRiferimento.C90_WebTipoCambioOrario = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Per accedere alla funzione "' + medpNomeFunzione + '"' + CRLF +
                               'è necessario impostare il seguente dato aziendale del gruppo IrisWEB: ' + CRLF +
                               'Web: Tipologia cambio orario!');
    Exit;
  end;

  // inizializzazioni
  Result:=True;
  vData:=ParametriForm.Al;
  GetDipendentiDisponibili(vData);
  selAnagrafeW.SearchRecord('PROGRESSIVO', ParametriForm.Progressivo, [srFromBeginning]);

  if WR000DM.Responsabile then
  begin
    //seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;

    medpAutorizzaMultiplo:=True;
    OnAutorizzaTutto:=W025AutorizzaTutti;
  end;

  VisualizzaDipendenteCorrente;
end;

procedure TW025FCambioOrario.IWAppFormCreate(Sender: TObject);
begin
  //Tipo cambio orario: I=Inversione giorno, C=Cambio orario, E=Inversione giorno e cambio orario
  TCO:=Parametri.CampiRiferimento.C90_WebTipoCambioOrario;
  Tag:=IfThen(WR000DM.Responsabile,431,430);
  inherited;
  W025DM:=TW025FCambioOrarioDM.Create(nil);
  Iter:=ITER_ORARIGG;
  if WR000DM.Responsabile then
    C018.PreparaDataSetIter(W025DM.selT085,tiAutorizzazione)
  else
    C018.PreparaDataSetIter(W025DM.selT085,tiRichiesta);
  Self.HelpKeyWord:=IfThen(WR000DM.Responsabile,'W025P1','W025P0');
  vData:=Parametri.DataLavoro;
  with WR000DM do
    selT020.Tag:=selT020.Tag + 1;

  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdRichieste.medpDataSet:=W025DM.selT085;
end;

procedure TW025FCambioOrario.IWAppFormRender(Sender: TObject);
begin
  inherited;
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;
  //autorizza / nega tutto
  if btnTuttiSi.Visible then
      btnTuttiSi.Visible:=(W025DM.selT085.RecordCount > 1);
  btnTuttiNo.Visible:=btnTuttiSi.Visible;
end;

procedure TW025FCambioOrario.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  with W025DM.selT085 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      GGetWebApplicationThreadVar.ShowMessage('La richiesta da visualizzare non è più disponibile!');
      Exit;
    end;
  end;
  VisualizzaDettagli(Sender);
end;

procedure TW025FCambioOrario.lnkLegendaColoriGiorniClick(Sender: TObject);
begin
  WC001FLegendaCalendarioFM:=TWC001FLegendaCalendarioFM.Create(Self);
end;

procedure TW025FCambioOrario.GetDipendentiDisponibili(Data: TDateTime);
begin
  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;
end;

procedure TW025FCambioOrario.VisualizzaDipendenteCorrente;
var
  FiltroAnag: String;
begin
  inherited;
  Operazione:='';
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  //apertura dataset delle richieste cambi orari
  with W025DM.selT085 do
  begin
    Close;
    //filtro in base alla selezione anagrafica
    FiltroAnag:=IfThen(TuttiDipSelezionato,
                       WR000DM.FiltroRicerca,
                       FiltroSingoloAnagrafico
                       );
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG',FiltroAnag);
    SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    R013Open(W025DM.selT085);
  end;
  grdRichieste.medpCreaCDS;
  grdRichieste.medpEliminaColonne;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizzazione','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Data rich.','',nil);
    if C018.EsisteAutorizzIntermedia or C018.Revocabile then
      grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('CF_DATA',IfThen(TCO = 'C','Giorno','Primo giorno'),'',nil);
    grdRichieste.medpAggiungiColonna('CF_ORARIO','Orario' + IfThen(TCO = 'C',' originale'),'',nil);
    if TCO <> 'C' then
      grdRichieste.medpAggiungiColonna('CF_DATA_INVER','Secondo giorno','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORARIO_INVER','Orario' + IfThen(TCO <> 'I',' richiesto'),'',nil);
    grdRichieste.medpAggiungiColonna('MESSAGGI','Messaggi','',nil);
    grdRichieste.medpAggiungiColonna('DESC_SOLO_NOTE','Solo note','',nil);
    grdRichieste.medpAggiungiColonna('TIPOGIORNO','','',nil);
    grdRichieste.medpAggiungiColonna('TIPOGIORNO_INVER','','',nil);
    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('TIPOGIORNO').Visible:=False;
    grdRichieste.medpColonna('TIPOGIORNO_INVER').Visible:=False;
  end
  else
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Data rich.','',nil);
    if C018.EsisteAutorizzIntermedia or C018.Revocabile then
      grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('CF_DATA',IfThen(TCO = 'C','Giorno','Primo giorno'),'',nil);
    grdRichieste.medpAggiungiColonna('CF_ORARIO','Orario' + IfThen(TCO = 'C',' originale'),'',nil);
    if TCO <> 'C' then
      grdRichieste.medpAggiungiColonna('CF_DATA_INVER','Secondo giorno','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORARIO_INVER','Orario' + IfThen(TCO <> 'I',' richiesto'),'',nil);
    grdRichieste.medpAggiungiColonna('DESC_SOLO_NOTE','Solo note','',nil);
    grdRichieste.medpAggiungiColonna('TIPOGIORNO','','',nil);
    grdRichieste.medpAggiungiColonna('TIPOGIORNO_INVER','','',nil);
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizzazione','',nil);
    grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    //grdRichieste.medpAggiungiColonna('DATA_AUTORIZZAZIONE','Data aut.','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpColonna('TIPOGIORNO').Visible:=False;
    grdRichieste.medpColonna('TIPOGIORNO_INVER').Visible:=False;
  end;
  ColCFData:=grdRichieste.medpIndexColonna('CF_DATA');
  ColCFOrario:=grdRichieste.medpIndexColonna('CF_ORARIO');
  ColCFDataInver:=grdRichieste.medpIndexColonna('CF_DATA_INVER');
  ColCFOrarioInver:=grdRichieste.medpIndexColonna('CF_ORARIO_INVER');
  ColSoloNote:=grdRichieste.medpIndexColonna('DESC_SOLO_NOTE');//ColOrarioRich + 2;
  ColDbgIter:=grdRichieste.medpIndexColonna(DBG_ITER);
  grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdRichieste.medpInizializzaCompGriglia;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
  if (not SolaLettura) then
  begin
    if not WR000DM.Responsabile then
    begin
      //Riga inserimento
      grdRichieste.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','null','','D');
      //Riga
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','null','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','','D');
    end
    else
    begin
      //Riga
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','MODIFICA','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','ANNULLA','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','CONFERMA','null','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',1,0,DBG_CHK,'','Si','','');
      grdRichieste.medpPreparaComponenteGenerico('R',1,1,DBG_CHK,'','No','','');
    end;
  end;
  grdRichieste.medpCaricaCDS;
end;

procedure TW025FCambioOrario.RefreshPage;
begin
  WR000DM.Responsabile:=Tag = 431;
  VisualizzaDipendenteCorrente;
end;

procedure TW025FCambioOrario.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i,j: Integer;
  ListaOrari:TStringList;
  S,Orario: String;
  RI:String;
  IWImg: TmeIWImageFile;
begin
  if grdRichieste.medpRigaInserimento and (not SolaLettura) then
  begin
    if StileCella1 = '' then
    begin
      with (grdRichieste.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        StileCella1:=Cell[0,0].Css;
        StileCella2:=Cell[0,2].Css;
      end;
    end;
    //Riga di inserimento
    (grdRichieste.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
    (grdRichieste.medpCompCella(0,0,1)as TmeIWImageFile).OnClick:=imgAnnullaClick;
    (grdRichieste.medpCompCella(0,0,2)as TmeIWImageFile).OnClick:=imgConfermaClick;
    with (grdRichieste.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,1].Css:='invisibile';
      Cell[0,2].Css:='invisibile';
    end;
  end;
  //Righe dati
  for i:=IfThen(grdRichieste.medpRigaInserimento,1,0) to High(grdRichieste.medpCompGriglia) do
  begin
    C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
    C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
    // dettaglio iter
    IWImg:=TmeIWImageFile(grdRichieste.medpCompCella(i,DBG_ITER,0));
    IWImg.OnClick:=imgIterClick;
    IWImg.Hint:=C018.LeggiNoteComplete;
    IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    // dettaglio allegati
    if C018.EsisteGestioneAllegati then
    begin
      IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
      //***if C018.SetIconaAllegati(IWImg) then
      //***  IWImg.OnClick:=imgAllegClick;
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    if not SolaLettura then
    begin
      //Tolgo i componenti se non ci sono le condizioni per l'autorizzazione
      if WR000DM.Responsabile and (grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE') <> '') then
      begin
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[1]);
      end;
      //Tolgo i componenti se non ci sono le condizioni per la cancellazione
      if (not WR000DM.Responsabile) and (grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE') <> '') then
      begin
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      end;
      //Associo l'evento OnClick alle icone dei comandi
      if (not WR000DM.Responsabile) and (grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil) then
      begin
        if StileCella1 = '' then
        begin
          with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
          begin
            StileCella1:=Cell[0,0].Css;
            StileCella2:=Cell[0,1].Css;
          end;
        end;
        (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCancellaClick;
        (grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModificaClick;
        (grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaClick;
        (grdRichieste.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgConfermaClick;
        with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
        begin
          Cell[0,1].Css:='invisibile';
          Cell[0,2].Css:='invisibile';
          Cell[0,3].Css:='invisibile';
        end;
      end;
      //Associo l'evento OnClick alle icone dei comandi e al checkbox di autorizzazione SI/NO
      if WR000DM.Responsabile and (grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil) then
      begin
        if StileCella1 = '' then
        begin
          with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
          begin
            StileCella1:=Cell[0,0].Css;
            StileCella2:=Cell[0,2].Css;
          end;
        end;
        (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgModificaClick;
        (grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
        (grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgConfermaClick;
        with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
        begin
          Cell[0,0].Css:='invisibile';
          Cell[0,1].Css:='invisibile';
          Cell[0,2].Css:='invisibile';
        end;
        C018.SetValoriAut(grdRichieste,i,1,0,1,chkAutorizzazioneClick);
      end;
    end;
  end;
  //controllo se segnalare situazioni anomale
  RI:=cdsT085.FieldByName('DBG_ROWID').AsString;
  cdsT085.First;
  while not cdsT085.Eof do
  begin
    S:='';
    if (WR000DM.Responsabile)
    and (cdsT085.FieldByName('AUTORIZZAZIONE').AsString = '')
    and (cdsT085.FieldByName('SOLO_NOTE').AsString = 'N') then
    begin
      if cdsT085.FieldByName('DATA').AsString <> '' then
      begin
        ListaOrari:=TStringList.Create;
        RicavaOrario(cdsT085.FieldByName('PROGRESSIVO').AsInteger,cdsT085.FieldByName('DATA').AsDateTime,False,'',ListaOrari);
        for j:=0 to ListaOrari.Count - 1 do
          Orario:=Copy(ListaOrari[j],1,Pos(' ',ListaOrari[j]) - 1);
        ListaOrari.Free;
        if Orario <> cdsT085.FieldByName('ORARIO').AsString then
          S:='Orario ' + IfThen(TCO = 'C','originale','del primo giorno') + ' attuale (' + Orario + ') differente da quello presente in fase di richiesta (' + cdsT085.FieldByName('ORARIO').AsString + ')';
      end;
      if (cdsT085.FieldByName('DATA_INVER').AsString <> '')
      and (cdsT085.FieldByName('TIPO_RICHIESTA').AsString = 'I') then
      begin
        ListaOrari:=TStringList.Create;
        RicavaOrario(cdsT085.FieldByName('PROGRESSIVO').AsInteger,cdsT085.FieldByName('DATA_INVER').AsDateTime,False,'',ListaOrari);
        for j:=0 to ListaOrari.Count - 1 do
          Orario:=Copy(ListaOrari[j],1,Pos(' ',ListaOrari[j]) - 1);
        ListaOrari.Free;
        if (Orario <> cdsT085.FieldByName('ORARIO_INVER').AsString) then
          S:=S + IfThen(S <> '',CRLF,'') +
             'Orario del secondo giorno attuale (' + Orario + ') differente da quello presente in fase di richiesta (' + cdsT085.FieldByName('ORARIO_INVER').AsString + ')';
      end;
      cdsT085.Edit;
      cdsT085.FieldByName('Messaggi').AsString:=S;
      cdsT085.Post;
    end;
    cdsT085.Next;
  end;
  cdsT085.First;
  cdsT085.Locate('DBG_ROWID',RI,[]);
end;

procedure TW025FCambioOrario.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  inherited;

  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdRichieste.medpNumColonna(AColumn);

  if (ARow = 0) and (TCO <> 'C') then
  begin
    if grdRichieste.medpColonna(NumColonna).DataField = 'CF_DATA' then
      ACell.Hint:='Primo giorno del periodo in ordine cronologico';
    if grdRichieste.medpColonna(NumColonna).DataField = 'CF_DATA_INVER' then
      ACell.Hint:='Secondo giorno del periodo in ordine cronologico';
  end;

  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0)
  and (grdRichieste.medpColonna(NumColonna).DataField = 'D_AUTORIZZAZIONE') then
    ACell.Css:=ACell.Css + ' align_center font_grassetto';

  if  (   (not grdRichieste.medpRigaInserimento and (ARow > 0))
       or (grdRichieste.medpRigaInserimento and (ARow > 1)))
  and (Length(grdRichieste.medpCompGriglia) > 0)
  and (   (grdRichieste.medpColonna(NumColonna).DataField = 'CF_DATA')
       or (    (grdRichieste.medpColonna(NumColonna).DataField = 'CF_DATA_INVER')
           and (grdRichieste.medpValoreColonna(ARow - 1,'CF_DATA_INVER') <> ''))) then
  begin
    ACell.Css:='bg_white ' + grdRichieste.Css;
    if grdRichieste.medpValoreColonna(ARow - 1,IfThen(grdRichieste.medpColonna(NumColonna).DataField = 'CF_DATA','TIPOGIORNO','TIPOGIORNO_INVER')) = 'T' then
      ACell.Css:='bg_aqua ' + grdRichieste.Css
    else if grdRichieste.medpValoreColonna(ARow - 1,IfThen(grdRichieste.medpColonna(NumColonna).DataField = 'CF_DATA','TIPOGIORNO','TIPOGIORNO_INVER')) = 'F' then
      ACell.Css:='bg_giallo ' + grdRichieste.Css
    else if grdRichieste.medpValoreColonna(ARow - 1,IfThen(grdRichieste.medpColonna(NumColonna).DataField = 'CF_DATA','TIPOGIORNO','TIPOGIORNO_INVER')) = 'N' then
      ACell.Css:='bg_lime ' + grdRichieste.Css;
    if Copy(grdRichieste.medpValoreColonna(ARow - 1,grdRichieste.medpColonna(NumColonna).DataField),4) <> '' then
      ACell.Css:=ACell.Css + ' ' + IfThen(R180NomeGiorno(StrToDate(Copy(grdRichieste.medpValoreColonna(ARow - 1, grdRichieste.medpColonna(NumColonna).DataField),4))) = 'Domenica','font_rosso','');
  end;
  ACell.Wrap:=True;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdRichieste.medpCompGriglia) + 1)
  and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TW025FCambioOrario.DBGridColumnClick(ASender: TObject; const AValue: string);
begin
  inherited;
  cdsT085.Locate('DBG_ROWID',AValue,[]);
end;

procedure TW025FCambioOrario.CreaComponentiRiga(FN: String);
var
  i,j: Integer;
  ListaOrari,ListaGiorni: TStringList;
  S: String;
  Data: TDateTime;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  if Operazione = 'I' then
  begin
    //giorno originale
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
    grdRichieste.medpPreparaComponenteGenerico('C',0,1,DBG_IMG,'','AGGIORNA','null','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColCFData,grdRichieste.Componenti);
    with (grdRichieste.medpCompCella(i,ColCFData,0) as TmeIWEdit) do
    begin
      CssEdit:=Css;
      Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
      OnSubmit:=CampoGiornoSubmit;
      Css:=RicavaColoreGiorno(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Parametri.DataLavoro,CssEdit);
      GiornoOriginale:=Parametri.DataLavoro;
      //ScriptEvents.HookEvent('onBlur','return SubmitClickConfirm(''' + UpperCase(Name) + ''', '''', true, '''')');
    end;
    (grdRichieste.medpCompCella(i,ColCFData,1) as TmeIWImageFile).OnClick:=AggiornaClick;
    //orario originale
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'','','','','S',True);
    grdRichieste.medpCreaComponenteGenerico(i,ColCFOrario,grdRichieste.Componenti);
    with (grdRichieste.medpCompCella(i,ColCFOrario,0) as TmeIWLabel) do
    begin
      ListaOrari:=TStringList.Create;
      RicavaOrario(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Parametri.DataLavoro,False,'',ListaOrari);
      for j:=0 to ListaOrari.Count - 1 do
        Caption:=ListaOrari[j];
      ListaOrari.Free;
    end;
    //giorno richiesto
    if TCO <> 'C' then
    begin
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'15','','','','S',True);
      grdRichieste.medpCreaComponenteGenerico(i,ColCFDataInver,grdRichieste.Componenti);
      with (grdRichieste.medpCompCella(i,ColCFDataInver,0) as TmeIWComboBox) do
      begin
        CssCombo:=Css;
        Items.BeginUpdate;
        ListaGiorni:=TStringList.Create;
        RicavaGiorni(Parametri.DataLavoro,ListaGiorni);
        for j:=0 to ListaGiorni.Count - 1 do
          Items.Add(ListaGiorni[j]);
        ListaGiorni.Free;
        Items.EndUpdate;
        ItemIndex:=0;
        OnChange:=cmbGiornoChange;
        Css:=RicavaColoreGiorno(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Parametri.DataLavoro + IfThen(TCO = 'E',0,1),CssCombo);
      end;
    end;
    //orario richiesto
    if TCO <> 'I' then
    begin
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'30','','','','S',True);
      grdRichieste.medpCreaComponenteGenerico(i,ColCFOrarioInver,grdRichieste.Componenti);
      with (grdRichieste.medpCompCella(i,ColCFOrarioInver,0) as TmeIWComboBox) do
      begin
        Items.BeginUpdate;
        if TCO = 'C' then
          Data:=Parametri.DataLavoro
        else
          try
            Data:=StrToDate(Copy((grdRichieste.medpCompCella(i,ColCFDataInver,0) as TmeIWComboBox).Text,5));
          except
          end;
        ListaOrari:=TStringList.Create;
        RicavaOrario(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,True,(grdRichieste.medpCompCella(i,ColCFOrario,0) as TmeIWLabel).Caption,ListaOrari);
        for j:=0 to ListaOrari.Count - 1 do
          Items.Add(ListaOrari[j]);
        ListaOrari.Free;
        ListaOrari:=TStringList.Create;
        RicavaOrario(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,False,'',ListaOrari);
        for j:=0 to ListaOrari.Count - 1 do
          S:=ListaOrari[j];
        ListaOrari.Free;
        Items.EndUpdate;
        ItemIndex:=max(0,Items.IndexOf(S));
      end;
    end
    else
    begin
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'','','','','S',True);
      grdRichieste.medpCreaComponenteGenerico(i,ColCFOrarioInver,grdRichieste.Componenti);
      with (grdRichieste.medpCompCella(i,ColCFOrarioInver,0) as TmeIWLabel) do
      begin
        ListaOrari:=TStringList.Create;
        RicavaOrario(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Parametri.DataLavoro + 1,False,'',ListaOrari);
        for j:=0 to ListaOrari.Count - 1 do
          Caption:=ListaOrari[j];
        ListaOrari.Free;
      end;
    end;
    //solo note
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColSoloNote,grdRichieste.Componenti);
    (grdRichieste.medpCompCella(i,ColSoloNote,0) as TmeIWCheckBox).OnClick:=chkSoloNoteClick;
    //note di inserimento
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'20','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColDbgIter,grdRichieste.Componenti);
  end;
end;

procedure TW025FCambioOrario.DistruggiComponentiRiga(FN: String);
var
  i:Integer;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  if Operazione = 'I' then
  begin
    //giorno originale
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColCFData]);
    //orario originale
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColCFOrario]);
    if TCO <> 'C' then
    begin
      //giorno richiesto
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColCFDataInver]);
    end;
    //orario richiesto
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColCFOrarioInver]);
    //solo note
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColSoloNote]);
    //note in inserimento
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColDbgIter]);
  end;
end;

procedure TW025FCambioOrario.CampoGiornoSubmit(Sender: TObject);
var
  i,j: Integer;
  Data: TDateTime;
  S: String;
  ListaOrari,ListaGiorni: TStringList;
begin
  inherited;
  i:=grdRichieste.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  //Controllo che il valore sia stato inserito nel formato corretto
  try
    try
      Data:=StrToDate((Sender as TmeIWEdit).Text);
    except
      raise exception.Create('Indicare il ' + IfThen(TCO <> 'C','primo ') + 'giorno nel formato GG/MM/AAAA');
    end;
  except
    on E: exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage(E.Message);
      (Sender as TmeIWEdit).SetFocus;
      Exit;
    end;
  end;
  GiornoOriginale:=Data;
  (Sender as TmeIWEdit).Css:=RicavaColoreGiorno(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,CssEdit);
  //aggiorno l'orario
  with (grdRichieste.medpCompCella(i,ColCFOrario,0) as TmeIWLabel) do
  begin
    ListaOrari:=TStringList.Create;
    RicavaOrario(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,False,'',ListaOrari);
    for j:=0 to ListaOrari.Count - 1 do
      Caption:=ListaOrari[j];
    ListaOrari.Free;
  end;
  //aggiorno i giorni richiedibili
  if TCO <> 'C' then
  begin
    with (grdRichieste.medpCompCella(i,ColCFDataInver,0) as TmeIWComboBox) do
    begin
      S:=Text;
      Items.Clear;
      Items.BeginUpdate;
      ListaGiorni:=TStringList.Create;
      RicavaGiorni(Data,ListaGiorni);
      for j:=0 to ListaGiorni.Count - 1 do
        Items.Add(ListaGiorni[j]);
      ListaGiorni.Free;
      Items.EndUpdate;
      ItemIndex:=max(0,Items.IndexOf(S));
      cmbGiornoChange((grdRichieste.medpCompCella(i,ColCFDataInver,0) as TmeIWComboBox));
    end;
  end;
  //aggiorno l'orario richiesto
  if TCO = 'C' then
  begin
    with (grdRichieste.medpCompCella(i,ColCFOrarioInver,0) as TmeIWComboBox) do
    begin
      Items.BeginUpdate;
      Items.Clear;
      ListaOrari:=TStringList.Create;
      RicavaOrario(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,True,(grdRichieste.medpCompCella(i,ColCFOrario,0) as TmeIWLabel).Caption,ListaOrari);
      for j:=0 to ListaOrari.Count - 1 do
        Items.Add(ListaOrari[j]);
      ListaOrari.Free;
      ListaOrari:=TStringList.Create;
      RicavaOrario(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,False,'',ListaOrari);
      for j:=0 to ListaOrari.Count - 1 do
        S:=ListaOrari[j];
      ListaOrari.Free;
      Items.EndUpdate;
      ItemIndex:=max(0,Items.IndexOf(S));
    end;
  end;
end;

procedure TW025FCambioOrario.AggiornaClick(Sender:TObject);
begin
  CampoGiornoSubmit((grdRichieste.medpCompCella(0,ColCFData,0) as TmeIWEdit));
end;

procedure TW025FCambioOrario.chkSoloNoteClick(Sender:TObject);
begin
  if (Sender as TmeIWCheckBox).Checked then
  begin
    StileCella3:=(grdRichieste.medpCompGriglia[0].CompColonne[ColCFOrarioInver - IfThen(TCO <> 'C',2,1)] as TmeIWGrid).Cell[0,0].Css;
    if TCO <> 'C' then
      StileCella4:=(grdRichieste.medpCompGriglia[0].CompColonne[ColCFOrarioInver - 1] as TmeIWGrid).Cell[0,0].Css;
    StileCella5:=(grdRichieste.medpCompGriglia[0].CompColonne[ColCFOrarioInver] as TmeIWGrid).Cell[0,0].Css;
    (grdRichieste.medpCompGriglia[0].CompColonne[ColCFOrarioInver - IfThen(TCO <> 'C',2,1)] as TmeIWGrid).Cell[0,0].Css:='invisibile';
    if TCO <> 'C' then
      (grdRichieste.medpCompGriglia[0].CompColonne[ColCFOrarioInver - 1] as TmeIWGrid).Cell[0,0].Css:='invisibile';
    (grdRichieste.medpCompGriglia[0].CompColonne[ColCFOrarioInver] as TmeIWGrid).Cell[0,0].Css:='invisibile';
  end
  else
  begin
    (grdRichieste.medpCompGriglia[0].CompColonne[ColCFOrarioInver - IfThen(TCO <> 'C',2,1)] as TmeIWGrid).Cell[0,0].Css:=StileCella3;
    if TCO <> 'C' then
      (grdRichieste.medpCompGriglia[0].CompColonne[ColCFOrarioInver - 1] as TmeIWGrid).Cell[0,0].Css:=StileCella4;
    (grdRichieste.medpCompGriglia[0].CompColonne[ColCFOrarioInver] as TmeIWGrid).Cell[0,0].Css:=StileCella5;
  end;
end;

procedure TW025FCambioOrario.cmbGiornoChange(Sender: TObject);
var
  i,j: Integer;
  S: String;
  Data: TDateTime;
  ListaOrari: TStringList;
begin
  i:=grdRichieste.medpRigaDiCompGriglia((Sender as TmeIWComboBox).FriendlyName);
  if TCO = 'I' then
  begin
    with (grdRichieste.medpCompCella(i,ColCFOrarioInver,0) as TmeIWLabel) do
    begin
      Caption:='';
    end;
  end;
  try
    Data:=StrToDate(Copy((Sender as TmeIWComboBox).Text,5));
  except
    abort;
  end;
  (Sender as TmeIWComboBox).Css:=RicavaColoreGiorno(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,CssCombo);
  //aggiorno l'orario richiesto
  if TCO <> 'I' then
  begin
    with (grdRichieste.medpCompCella(i,ColCFOrarioInver,0) as TmeIWComboBox) do
    begin
      Items.BeginUpdate;
      Items.Clear;
      ListaOrari:=TStringList.Create;
      RicavaOrario(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,True,(grdRichieste.medpCompCella(i,ColCFOrario,0) as TmeIWLabel).Caption,ListaOrari);
      for j:=0 to ListaOrari.Count - 1 do
        Items.Add(ListaOrari[j]);
      ListaOrari.Free;
      ListaOrari:=TStringList.Create;
      RicavaOrario(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,False,'',ListaOrari);
      for j:=0 to ListaOrari.Count - 1 do
        S:=ListaOrari[j];
      ListaOrari.Free;
      Items.EndUpdate;
      ItemIndex:=max(0,Items.IndexOf(S));
    end;
  end
  else
  begin
    with (grdRichieste.medpCompCella(i,ColCFOrarioInver,0) as TmeIWLabel) do
    begin
      ListaOrari:=TStringList.Create;
      RicavaOrario(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,False,'',ListaOrari);
      for j:=0 to ListaOrari.Count - 1 do
        Caption:=ListaOrari[j];
      ListaOrari.Free;
    end;
  end;
end;

procedure TW025FCambioOrario.RicavaOrario(Prog:Integer; Data: TDateTime; ElencoOrariDisponibili: Boolean; OrarioO:String; var Orari: TStringList);
var
  Orario,OrarioProfilo: String;
begin
  if not ElencoOrariDisponibili then
  begin
    with W025DM.selOrario do
    begin
      //Cerco l'orario pianificato, se non c'è prendo quello del profilo se non ci sono timbrature o se c'è una sola settimana
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('DATA',Data);
      SetVariable('TIPOGIORNO',RicavaTipoGiorno(Prog,Data));
      SetVariable('NUMGIORNO',IntToStr(DayOfWeek(Data - 1)));
      Execute;
      Orario:=VarToStr(GetVariable('ORARIO'));
      OrarioProfilo:=VarToStr(GetVariable('ORARIO_PROFILO'));
      //Se non ho ricavato l'orario, lo cerco tramite conteggi
      if Orario = '' then
      begin
        R502ProDtM1:=TR502ProDtM1.Create(Self);
        R502ProDtM1.PeriodoConteggi(Data,Data);
        R502ProDtM1.Conteggi('Cartolina',Prog,Data);
        if R502ProDtM1.Blocca = 0 then
          Orario:=R502ProDtM1.c_orario;
        FreeAndNil(R502ProDtM1);
      end;
      //Se i conteggi non restituiscono un orario valido, prendo quello della prima settimana del profilo
      if Orario = '' then
        Orario:=OrarioProfilo;
      Orari.Add(Format('%-5s %s',[Orario,RicavaDescrizioneOrario(Orario,Data)]));
    end;
  end
  else
  begin
    //Prelevo tutti gli orari del profilo
    with W025DM.selOrario2 do
    begin
      Close;
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('DATA',Data);
      Open;
      while not Eof do
      begin
        Orario:=Format('%-5s %s',[FieldByName('CODICE').AsString,RicavaDescrizioneOrario(FieldByName('CODICE').AsString,Data)]);
        if Orari.IndexOf(Orario) < 0 then
          Orari.Add(Orario);
        Next;
      end;
      Close;
    end;
    //Aggiungo l'orario pianificato nel giorno
    with W025DM.selT080 do
    begin
      Close;
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('DATA',Data);
      Open;
      while not Eof do
      begin
        Orario:=Format('%-5s %s',[FieldByName('ORARIO').AsString,RicavaDescrizioneOrario(FieldByName('ORARIO').AsString,Data)]);
        if Orari.IndexOf(Orario) < 0 then
          Orari.Add(Orario);
        Next;
      end;
      Close;
    end;
    //Aggiungo l'orario pianificato nel giorno originale
    if Orari.IndexOf(OrarioO) < 0 then
      Orari.Add(OrarioO);
    //Aggiungo tutti gli orari abilitati (filtro dizionario MODELLI ORARIO)
    with WR000DM.selT020 do
    begin
      Close;
      Open;
      while not Eof do
      begin
        Orario:=Format('%-5s %s',[FieldByName('CODICE').AsString,RicavaDescrizioneOrario(FieldByName('CODICE').AsString,Data)]);
        if Orari.IndexOf(Orario) < 0 then
          Orari.Add(Orario);
        Next;
      end;
      Close;
    end;
  end;
end;

function TW025FCambioOrario.RicavaDescrizioneOrario(Orario: String; Data: TDateTime): String;
begin
  Result:='';
  with W025DM.selaT020 do
  begin
    SetVariable('ORARIO',Orario);
    SetVariable('DATA',Data);
    Open;
    if not Eof then
      Result:=FieldByName('DESCRIZIONE').AsString;
    Close;
  end;
end;

function TW025FCambioOrario.RicavaTipoGiorno(Prog:Integer; Data: TDateTime): String;
begin
  Result:='';
  with W025DM.selV010 do
  begin
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('DAL',Data);
    SetVariable('AL',Data);
    Close;
    Open;
    if SearchRecord('Data',Data,[srFromBeginning]) then
      if (FieldByName('FESTIVO').AsString = 'S') and (FieldByName('LAVORATIVO').AsString <> 'S') then
        Result:='T'
      else if FieldByName('FESTIVO').AsString = 'S' then
        Result:='F'
      else if FieldByName('LAVORATIVO').AsString <> 'S' then
        Result:='N'
      else
        Result:=IntToStr(DayOfWeek(Data - 1));
  end;
end;

function TW025FCambioOrario.RicavaColoreGiorno(Prog: Integer; Data: TDateTime; Stile: String): String;
begin
  Result:='';
  with W025DM.selV010 do
  begin
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('DAL',Data);
    SetVariable('AL',Data);
    Close;
    Open;
    if SearchRecord('Data',Data,[srFromBeginning]) then
      if (FieldByName('FESTIVO').AsString = 'S') and (FieldByName('LAVORATIVO').AsString <> 'S') then
        Result:='bg_aqua'
      else if FieldByName('FESTIVO').AsString = 'S' then
        Result:='bg_giallo'
      else if FieldByName('LAVORATIVO').AsString <> 'S' then
        Result:='bg_lime'
      else
        Result:='bg_white';
  end;
  Result:=Result + ' ' + Stile;
  Result:=Result + IfThen(R180NomeGiorno(Data) = 'Domenica',' ' + 'font_rosso','');
end;

procedure TW025FCambioOrario.RicavaGiorni(Data: TDateTime; var Giorni: TStringList);
var
  d: TDateTime;
  i,Sett: Integer;
begin
  Sett:=Max(StrToIntDef(Parametri.CampiRiferimento.C90_WebSettCambioOrario,1),1);
  if (TCO = 'I') and (DayOfWeek(Data - 1) = 7) and (Sett = 1) then
    Exit;
  d:=Data + IfThen(TCO = 'E',0,1);
  for i:=1 to (7 * Sett) do
    if i >= DayOfWeek(d - 1) then
    begin
      Giorni.Add(Copy(R180NomeGiorno(d),1,3) + ' ' + FormatDateTime('dd/mm/yyyy',d));
      d:=d + 1;
    end;
end;

procedure TW025FCambioOrario.imgModificaClick(Sender:TObject);
var
  FN: String;
begin
  // modifica - applicazione modifiche
  if Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);

  // porta la riga in modifica: trasforma i componenti
  Operazione:='M';
  TrasformaComponenti(FN);
  grdRichieste.medpBrowse:=False;
  grdRichieste.medpStato:=msEdit;
end;

procedure TW025FCambioOrario.imgInserisciClick(Sender: TObject);
var
  FN: String;
begin
  if Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);

  Operazione:='I';
  grdRichieste.medpBrowse:=False;
  grdRichieste.medpStato:=msInsert;
  with (grdRichieste.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
  begin
    //Nascondo il pulsante inserisci e visualizzo annulla/conferma
    Cell[0,0].Css:='invisibile';
    Cell[0,1].Css:=StileCella1;
    Cell[0,2].Css:=StileCella2;
  end;
  CreaComponentiRiga(FN);
end;

procedure TW025FCambioOrario.imgAnnullaClick(Sender: TObject);
// Annulla: annulla le modifiche apportate nei componenti editabili
begin
  DBGridColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);
  Operazione:='';
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  grdRichieste.medpCaricaCDS;
end;

procedure TW025FCambioOrario.imgConfermaClick(Sender: TObject);
// Applica:  conferma i dati presenti nei componenti
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);

  if (Operazione = 'M') then
  begin
    // se il record non esiste -> errore
    if not W025DM.selT085.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      Operazione:='';
      TrasformaComponenti(FN);
      grdRichieste.medpBrowse:=True;
      grdRichieste.medpStato:=msBrowse;
      GGetWebApplicationThreadVar.ShowMessage('Errore durante la modifica del cambio orario:' + CRLF + 'il record non è più disponibile!');
      Exit;
    end;
  end;

  //effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;
  //inserimento / aggiornamento
  if Operazione = 'I' then
    actInsRichiesta(FN);
  (*
  else
    actModRichiesta(FN);*)
end;

procedure TW025FCambioOrario.imgCancellaClick(Sender: TObject);
var
  FN: String;
begin
  if Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);

  //cancellazione riga
  actCancRichiesta(FN);
end;

procedure TW025FCambioOrario.TrasformaComponenti(FN:String);
{ Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdRichieste }
var
  DaTestoAControlli:Boolean;
  i:Integer;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  DaTestoAControlli:=Operazione <> '';

  if not WR000DM.Responsabile then
  begin
    if grdRichieste.medpRigaInserimento and (i = 0) then
    begin
      with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
        Cell[0,1].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
        Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
      end;
    end
    else
    begin
      with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
        Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
        Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
        Cell[0,3].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
      end;
    end;
  end
  else
  begin
    with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
      Cell[0,1].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
      Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
    end;
  end;

  if DaTestoAControlli then
    CreaComponentiRiga(FN)
  else
    DistruggiComponentiRiga(FN);
end;

function TW025FCambioOrario.ControlliOK(FN: String): Boolean;
var
  i: Integer;
  DataOriginale,DataRichiesta: TDateTime;
  OrarioOriginale,OrarioRichiesto,TipoGO,TipoGR: String;
begin
  Result:=False;
  if Operazione = 'I' then
  begin
    i:=grdRichieste.medpRigaDiCompGriglia(FN);
    //giorno originale
    if Length((grdRichieste.medpCompCella(i,ColCFData,0) as TmeIWedit).Text) <> 10 then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Indicare il ' + IfThen(TCO <> 'C','primo ') + 'giorno nel formato GG/MM/AAAA!');
      Exit;
    end;
    try
      DataOriginale:=StrToDate((grdRichieste.medpCompCella(i,ColCFData,0) as TmeIWEdit).Text);
    except
      GGetWebApplicationThreadVar.ShowMessage('Indicare il ' + IfThen(TCO <> 'C','primo ') + 'giorno nel formato GG/MM/AAAA!');
      Exit;
    end;
    if GiornoOriginale <> DataOriginale then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Il ' + IfThen(TCO <> 'C','primo ') + 'giorno è stato modificato. Aggiornare i dati della richiesta premendo sul pulsante adiacente!');
      Exit;
    end;
    try
      WR000DM.selDatiBloccati.Close;
      if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(DataOriginale),'T080') then
        raise Exception.Create(WR000DM.selDatiBloccati.MessaggioLog);
    except
      on E: Exception do
      begin
        GGetWebApplicationThreadVar.ShowMessage(E.Message);
        grdRichieste.medpCompCella(i,ColCFData,0).SetFocus;
        Exit;
      end;
    end;
    with W025DM.selaT085 do
    begin
      SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',DataOriginale);
      Execute;
      if Field(0) > 0 then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Esiste già una richiesta in attesa di autorizzazione relativa al ' + IfThen(TCO <> 'C','primo ') + 'giorno indicato!');
        Exit;
      end;
    end;
    with W025DM.selV010 do
    begin
      SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DAL',DataOriginale);
      SetVariable('AL',DataOriginale);
      Close;
      Open;
      if SearchRecord('Data',DataOriginale,[srFromBeginning]) then
        TipoGO:=FieldByName('LAVORATIVO').AsString;
    end;
    if not (grdRichieste.medpCompCella(i,ColSoloNote,0) as TmeIWCheckBox).Checked then
    begin
      //orario originale
      OrarioOriginale:=(grdRichieste.medpCompCella(i,ColCFOrario,0) as TmeIWLabel).Caption;
      OrarioOriginale:=Copy(OrarioOriginale,1,Pos(' ',OrarioOriginale) - 1);
      if OrarioOriginale = '' then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Non è possibile recuperare l''orario ' + IfThen(TCO = 'C','originale per il giorno','per il primo giorno') + ' indicato!');
        Exit;
      end;
      //giorno richiesto
      if TCO <> 'C' then
      begin
        try
          DataRichiesta:=StrToDate(Copy((grdRichieste.medpCompCella(i,ColCFDataInver,0) as TmeIWComboBox).Text,5));
        except
          GGetWebApplicationThreadVar.ShowMessage('E'' necessario selezionare il secondo giorno');
          Exit;
        end;
        try
          WR000DM.selDatiBloccati.Close;
          if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(DataRichiesta),'T080') then
            raise Exception.Create(WR000DM.selDatiBloccati.MessaggioLog);
        except
          on E: exception do
          begin
            GGetWebApplicationThreadVar.ShowMessage(E.Message);
            grdRichieste.medpCompCella(i,ColCFDataInver,0).SetFocus;
            Exit;
          end;
        end;
        with W025DM.selaT085 do
        begin
          SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
          SetVariable('DATA',DataRichiesta);
          Execute;
          if Field(0) > 0 then
          begin
            GGetWebApplicationThreadVar.ShowMessage('Esiste già una richiesta in attesa di autorizzazione relativa al secondo giorno indicato!');
            Exit;
          end;
        end;
      end
      else
      begin
        DataRichiesta:=DataOriginale;
      end;
      with W025DM.selV010 do
      begin
        SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
        SetVariable('DAL',DataRichiesta);
        SetVariable('AL',DataRichiesta);
        Close;
        Open;
        if SearchRecord('Data',DataRichiesta,[srFromBeginning]) then
          TipoGR:=FieldByName('LAVORATIVO').AsString;
      end;
      //orario richiesto
      if TCO <> 'I' then
      begin
        OrarioRichiesto:=(grdRichieste.medpCompCella(i,ColCFOrarioInver,0) as TmeIWComboBox).Text;
        if OrarioRichiesto = '' then
        begin
          GGetWebApplicationThreadVar.ShowMessage('E'' necessario selezionare l''orario richiesto!');
          Exit;
        end;
      end
      else
        OrarioRichiesto:=(grdRichieste.medpCompCella(i,ColCFOrarioInver,0) as TmeIWLabel).Caption;
      OrarioRichiesto:=Copy(OrarioRichiesto,1,Pos(' ',OrarioRichiesto) - 1);
      if OrarioRichiesto = '' then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Non è possibile recuperare l''orario ' + IfThen(TCO <> 'I','richiesto per il giorno','per il secondo giorno') + ' indicato!');
        Exit;
      end;
      if (OrarioOriginale = OrarioRichiesto)
      and ((TCO = 'C') or (TipoGO = TipoGR)) then
      begin
        GGetWebApplicationThreadVar.ShowMessage('L''orario ' + IfThen(TCO = 'C','originale','del primo giorno') + ' e l''orario ' + IfThen(TCO <> 'I','richiesto','del secondo giorno') + ' corrispondono' + IfThen(TCO <> 'C',' e i giorni indicati sono entrambi ' + IfThen(TipoGO = 'N','non ','') + 'lavorativi','') + '!');
        Exit;
      end;
    end;
  end;
  Result:=True;
end;

procedure TW025FCambioOrario.actInsRichiesta(FN: String);
var
  i: Integer;
  TipoGO,TipoGR,OrarioO,OrarioR: String;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  with W025DM.selT085 do
  begin
    Append;
    FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    //FieldByName('DATA_RICHIESTA').AsDateTime:=Now;
    FieldByName('DATA').AsDateTime:=StrToDate((grdRichieste.medpCompCella(i,ColCFData,0) as TmeIWEdit).Text);
    TipoGO:=RicavaTipoGiorno(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA').AsDateTime);
    FieldByName('TIPOGIORNO').AsString:=IfThen(TipoGO = 'T','T',IfThen(TipoGO = 'F','F',IfThen(TipoGO = 'N','N','L')));
    if not (grdRichieste.medpCompCella(i,ColSoloNote,0) as TmeIWCheckBox).Checked then
    begin
      OrarioO:=(grdRichieste.medpCompCella(i,ColCFOrario,0) as TmeIWLabel).Caption;
      FieldByName('ORARIO').AsString:=Copy(OrarioO,1,Pos(' ',OrarioO) - 1);
      //FieldByName('TIPO_RICHIESTA').AsString:=TCO;
      if TCO <> 'C' then
        FieldByName('DATA_INVER').AsDateTime:=StrToDate(Copy((grdRichieste.medpCompCella(i,ColCFDataInver,0) as TmeIWComboBox).Text,5))
      else
        FieldByName('DATA_INVER').AsDateTime:=FieldByName('DATA').AsDateTime;
      TipoGR:=RicavaTipoGiorno(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA_INVER').AsDateTime);
      FieldByName('TIPOGIORNO_INVER').AsString:=IfThen(TipoGR = 'T','T',IfThen(TipoGR = 'F','F',IfThen(TipoGR = 'N','N','L')));
      if TCO <> 'I' then
        OrarioR:=(grdRichieste.medpCompCella(i,ColCFOrarioInver,0) as TmeIWComboBox).Text
      else
        OrarioR:=(grdRichieste.medpCompCella(i,ColCFOrarioInver,0) as TmeIWLabel).Caption;
      FieldByName('ORARIO_INVER').AsString:=Copy(OrarioR,1,Pos(' ',OrarioR) - 1);
    end;
    FieldByName('SOLO_NOTE').AsString:=IfThen((grdRichieste.medpCompCella(i,ColSoloNote,0) as TmeIWCheckBox).Checked,'S','N');
    //FieldByName('NOTE_RICHIESTA').AsString:=Trim(TIWMemo(grdRichieste.medpCompCella(i,ColNoteRic,0)).Text);
    DatiRichiesta.Note:=Trim((grdRichieste.medpCompCella(i,ColDbgIter,0) as TmeIWMemo).Text);
  end;

  // MONDOEDP - commessa MAN/07 SVILUPPO#62.ini
  // imposta le note per valutazione condizioni validità
  C018.Note:=DatiRichiesta.Note;
  // MONDOEDP - commessa MAN/07 SVILUPPO#62.fine

  if not C018.WarningRichiesta then
    Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaInsRichiesta,AnnullaInsRichiesta)
  else
    ConfermaInsRichiesta;
end;

procedure TW025FCambioOrario.ConfermaInsRichiesta;
var IdIns:String;
    Liv:Integer;
begin
  with W025DM.selT085 do
  begin
    try
      Liv:=C018.InsRichiesta(TCO,DatiRichiesta.Note,'');
      if C018.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end
      else if (Liv = C018.LivMaxObb) and (FieldByName('SOLO_NOTE').AsString = 'N') then
      begin
        AggiornamentoCalendarioIndividuale(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA').AsDateTime,FieldByName('DATA_INVER').AsDateTime);
        AggiornamentoPianificazioneOrari(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA').AsDateTime,FieldByName('DATA_INVER').AsDateTime,FieldByName('ORARIO').AsString,FieldByName('ORARIO_INVER').AsString);
      end;
      IdIns:=RowId;
      SessioneOracle.Commit;
    except
      on E:Exception do
        GGetWebApplicationThreadVar.ShowMessage('Inserimento della richiesta fallito!' + CRLF + 'Motivo: ' + E.Message);
    end;
  end;

  C018.Periodo.Estendi(W025DM.selT085.FieldByName('DATA').AsDateTime,W025DM.selT085.FieldByName('DATA').AsDateTime);
  C018.IncludiTipoRichieste(trDaAutorizzare);
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  C018.StrutturaSel:=C018STRUTTURA_TUTTE;
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

  //aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  //posizionamento su riga appena inserita
  grdRichieste.medpDataSet.Refresh;
  grdRichieste.medpDataSet.Locate('ROWID',IdIns,[]);
  grdRichieste.medpAggiornaCDS(False);
end;

procedure TW025FCambioOrario.AnnullaInsRichiesta;
begin
  W025DM.selT085.Cancel;
  //aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

(*
procedure TW025FCambioOrario.actModRichiesta(FN: String);
begin
end;
*)

procedure TW025FCambioOrario.actCancRichiesta(FN: String);
begin
  //cancellazione record
  with W025DM.selT085 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      try
        C018.CodIter:=FieldByName('COD_ITER').AsString;
        C018.Id:=FieldByName('ID').AsInteger;
        C018.EliminaIter;
        SessioneOracle.Commit;
      except
        on E:Exception do
          GGetWebApplicationThreadVar.ShowMessage('Cancellazione della richiesta fallita!' + CRLF + 'Motivo: ' + E.Message);
      end;
    end;
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW025FCambioOrario.W025AutorizzaTutti(Sender: TObject; var Ok: Boolean);  // TW025FCambioOrario.btnTuttiSiClick(Sender: TObject);
{ Effettua l'autorizzazione positiva di tutte le richieste ancora da autorizzare }
var
  ErrModCan: Boolean;
  Aut:String;
  Liv:Integer;
  function FormattaDatiRichiesta: String;
  begin
    with W025DM.selT085 do
    begin
      //formatta la richiesta
      Result:=Format('Richiesta effettuata da %s (%s) il %s',
              [FieldByName('NOMINATIVO').AsString,FieldByName('MATRICOLA').AsString,FieldByName('DATA_RICHIESTA').AsString])
              + CRLF + 'Primo giorno:   ' + FieldByName('DATA').AsString
              + CRLF + 'Orario:         ' + FieldByName('CF_Orario').AsString
              + CRLF + 'Secondo giorno: ' + IfThen(FieldByName('DATA_INVER').IsNull,'',FieldByName('DATA_INVER').AsString)
              + CRLF + 'Orario:         ' + FieldByName('CF_Orario_Inver').AsString
              + CRLF + 'Solo Note: ' + FieldByName('Desc_Solo_Note').AsString;
    end;
  end;

begin
  if Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;
  //inizializzazione variabili
  ErrModCan:=False;
  Aut:=IfThen((Sender as TmeIWButton).Name = 'btnTuttiSi',C018SI,C018NO);
  //autorizzazione richieste
  with W025DM.selT085 do
  begin
    First;
    while not Eof do
    begin
      try
        if (FieldByName('ID_REVOCA').IsNull) and
           (FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
           (FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0) then
          try
            try
              C018.CodIter:=FieldByName('COD_ITER').AsString;
              C018.Id:=FieldByName('ID').AsInteger;
              Liv:=C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
              if C018.MessaggioOperazione <> '' then
                raise Exception.Create(C018.MessaggioOperazione);
              if (Liv = C018.LivMaxObb) and (Aut = 'S') and (FieldByName('SOLO_NOTE').AsString = 'N') then
              begin
                AggiornamentoCalendarioIndividuale(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA').AsDateTime,FieldByName('DATA_INVER').AsDateTime);
                AggiornamentoPianificazioneOrari(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA').AsDateTime,FieldByName('DATA_INVER').AsDateTime,FieldByName('ORARIO').AsString,FieldByName('ORARIO_INVER').AsString);
              end;
              WR000DM.RegistraMessaggioT280(FieldByName('PROGRESSIVO').AsInteger,
                                                    IfThen(Aut = 'S','0','2'),
                                                    '<W025> ESITO ' + IfThen(Aut = 'S','POSITIVO','NEGATIVO') + ' - Richiesta cambio orario',
                                                    FormattaDatiT280,
                                                    IfThen(Aut = 'S','Autorizzato da ','Non autorizzato da ') + FieldByName('D_RESPONSABILE').AsString);
              SessioneOracle.Commit;
            except
              on E:Exception do
              begin
                //messaggio bloccante
                MsgBox.MessageBox('Autorizzazione cambio orario - Errore','Impostazione dell''autorizzazione fallita!'
                                  + CRLF + 'Motivo: ' + E.Message + CRLF + CRLF + FormattaDatiRichiesta);
                VisualizzaDipendenteCorrente;
                Exit;
              end;
            end;
          except
            //errore probabilmente dovuto a record modificato / cancellato da altro utente
            on E:Exception do
              ErrModCan:=True;
          end;
      finally
        Next;
      end;
    end;
  end;
  Ok:=True;
  if ErrModCan then
    GGetWebApplicationThreadVar.ShowMessage('Alcune richieste non sono state considerate per l''autorizzazione in quanto modificate nel frattempo o non più disponibili.');
end;

procedure TW025FCambioOrario.chkAutorizzazioneClick(Sender: TObject);
begin
  if Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;
  (Sender as TmeIWCheckBox).Checked:=True;
  AutorizzazioneOK((Sender as TmeIWCheckBox).FriendlyName,IfThen((Sender as TmeIWCheckBox).Caption = 'Si',C018SI,C018NO));
end;

procedure TW025FCambioOrario.AutorizzazioneOK(RowidT085,Aut: String);
var Liv:Integer;
begin
  with W025DM.selT085 do
  begin
    //verifica presenza record
    Refresh;
    if not SearchRecord('ROWID',RowidT085,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      GGetWebApplicationThreadVar.ShowMessage('Attenzione! La richiesta da autorizzare non è più disponibile!');
      Exit;
    end;
    //salva i dati di autorizzazione
    try
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      Liv:=C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione);
      WR000DM.RegistraMessaggioT280(FieldByName('PROGRESSIVO').AsInteger,
                                            IfThen(Aut = 'S','0','2'),
                                            '<W025> ESITO ' + IfThen(Aut = 'S','POSITIVO','NEGATIVO') + ' - Richiesta cambio orario',
                                            FormattaDatiT280,
                                            IfThen(Aut = 'S','Autorizzato da ','Non autorizzato da ') + FieldByName('D_RESPONSABILE').AsString);
      if (Liv = C018.LivMaxObb) and (Aut = 'S') and (FieldByName('SOLO_NOTE').AsString = 'N') then
      begin
        AggiornamentoCalendarioIndividuale(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA').AsDateTime,FieldByName('DATA_INVER').AsDateTime);
        AggiornamentoPianificazioneOrari(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA').AsDateTime,FieldByName('DATA_INVER').AsDateTime,FieldByName('ORARIO').AsString,FieldByName('ORARIO_INVER').AsString);
      end;
      SessioneOracle.Commit;
    except
      on E: exception do
        GGetWebApplicationThreadVar.ShowMessage
          ('Impostazione dell''autorizzazione fallita!' + CRLF + 'Motivo: ' + E.Message);
    end;
    VisualizzaDipendenteCorrente;
  end;
end;

procedure TW025FCambioOrario.AggiornamentoCalendarioIndividuale(Prog:Integer; DataO,DataR:TDateTime);
begin
  with WR000DM, W025DM do
  begin
    selV010.SetVariable('PROGRESSIVO',Prog);
    selV010.SetVariable('DAL',DataO);
    selV010.SetVariable('AL',DataR);
    selV010.Close;
    selV010.Open;
    if VarToStr(selV010.Lookup('DATA',DataO,'LAVORATIVO')) <> VarToStr(selV010.Lookup('DATA',DataR,'LAVORATIVO')) then
    begin
      //giorno originale
      selT012.Close;
      selT012.SetVariable('DATA',DataO);
      selT012.SetVariable('PROGRESSIVO',Prog);
      selT012.Open;
      if selT012.RecordCount > 0 then
        selT012.Edit
      else
        selT012.Append;
      selT012.FieldByName('PROGRESSIVO').AsInteger:=Prog;
      selT012.FieldByName('DATA').AsDateTime:=DataO;
      selT012.FieldByName('LAVORATIVO').AsString:=VarToStr(selV010.Lookup('DATA',DataR,'LAVORATIVO'));
      selT012.FieldByName('FESTIVO').AsString:=VarToStr(selV010.Lookup('DATA',DataO,'FESTIVO'));
      selT012.FieldByName('NUMGIORNI').AsInteger:=StrToInt(VarToStr(selV010.Lookup('DATA',DataO,'NUMGIORNI')));
      selT012.Post;
      //giorno richiesto
      selT012.Close;
      selT012.SetVariable('DATA',DataR);
      selT012.SetVariable('PROGRESSIVO',Prog);
      selT012.Open;
      if selT012.RecordCount > 0 then
        selT012.Edit
      else
        selT012.Append;
      selT012.FieldByName('PROGRESSIVO').AsInteger:=Prog;
      selT012.FieldByName('DATA').AsDateTime:=DataR;
      selT012.FieldByName('LAVORATIVO').AsString:=VarToStr(selV010.Lookup('DATA',DataO,'LAVORATIVO'));
      selT012.FieldByName('FESTIVO').AsString:=VarToStr(selV010.Lookup('DATA',DataR,'FESTIVO'));
      selT012.FieldByName('NUMGIORNI').AsInteger:=StrToInt(VarToStr(selV010.Lookup('DATA',DataR,'NUMGIORNI')));
      selT012.Post;
    end;
  end;
end;

procedure TW025FCambioOrario.AggiornamentoPianificazioneOrari(Prog:Integer; DataO,DataR:TDateTime; OrarioO,OrarioR:String);
begin
  with W025DM.selT080 do
  begin
    //giorno originale con orario richiesto
    Close;
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('DATA',DataO);
    Open;
    if RecordCount > 0 then
      Edit
    else
      Append;
    FieldByName('PROGRESSIVO').AsInteger:=Prog;
    FieldByName('DATA').AsDateTime:=DataO;
    FieldByName('ORARIO').AsString:=OrarioR;
    FieldByName('TURNO1').AsString:='';
    FieldByName('TURNO2').AsString:='';
    FieldByName('TURNO1EU').AsString:='';
    FieldByName('TURNO2EU').AsString:='';
    Post;
    if DataO <> DataR then
    begin
      //giorno richiesto con orario originale
      Close;
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('DATA',DataR);
      Open;
      if RecordCount > 0 then
        Edit
      else
        Append;
      FieldByName('PROGRESSIVO').AsInteger:=Prog;
      FieldByName('DATA').AsDateTime:=DataR;
      FieldByName('ORARIO').AsString:=OrarioO;
      FieldByName('TURNO1').AsString:='';
      FieldByName('TURNO2').AsString:='';
      FieldByName('TURNO1EU').AsString:='';
      FieldByName('TURNO2EU').AsString:='';
      Post;
    end;
  end;
end;

procedure TW025FCambioOrario.rgpVisualizzazioneClick(Sender: TObject);
begin
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

function TW025FCambioOrario.FormattaDatiT280: String;
begin
  with W025DM.selT085 do
  begin
    //formatta la richiesta
    Result:='Primo giorno:   ' + FieldByName('DATA').AsString + CRLF +
            'Orario:         ' + FieldByName('CF_Orario').AsString + CRLF +
            'Secondo giorno: ' + IfThen(FieldByName('DATA_INVER').IsNull,'',FieldByName('DATA_INVER').AsString) + CRLF +
            'Orario:         ' + FieldByName('CF_Orario_Inver').AsString + CRLF +
            'Solo note: ' + FieldByName('Desc_Solo_Note').AsString;
  end;
end;

procedure TW025FCambioOrario.DistruggiOggetti;
begin
  FreeAndNil(W025DM);

  if GGetWebApplicationThreadVar.Data <> nil then
    R180CloseDataSetTag0(WR000DM.selT020);
end;

end.
