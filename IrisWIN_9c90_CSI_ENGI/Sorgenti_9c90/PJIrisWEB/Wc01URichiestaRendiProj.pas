unit Wc01URichiestaRendiProj;

interface

uses
  IWApplication, IWAppForm, SysUtils, Classes, Graphics, ActiveX,
  R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase, medpIWMultiColumnComboBox,
  Controls, IWCompLabel, IWControl, IWCompListbox, IWCompEdit, meIWEdit, meIWMemo,
  IWCompButton, OracleData, IWCompCheckbox, Variants,  IWVCLBaseControl,
  Forms, IWVCLBaseContainer, IWContainer, DB, StrUtils, DBClient, Math, ActnList,
  IWDBGrids, medpIWDBGrid, A000UCostanti, A000USessione, A000UInterfaccia,
  C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb, meIWComboBox,
  R450, Wc01URichiestaRendiProjDM, meIWGrid, meIWLabel, meIWButton,
  IWCompGrids, IWCompExtCtrls, meIWImageFile, meIWLink, Menus, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, meIWCheckBox,
  IWTemplateProcessorHTML, IWBaseControl, IWBaseHTMLControl, IWHTMLControls,
  IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion, medpIWTabControl,
  Wc01UModificaTabelloneFM, Rp502Pro, Datasnap.Win.MConnect, W000UMessaggi;

const
  NRIGHEBLOCCATE = 1;
  NCOLONNEBLOCCATE = 8;

type
  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
  end;

  TWc01FRichiestaRendiProj = class(TR013FIterBase)
    dsrT755: TDataSource;
    cdsT755: TClientDataSet;
    lblMessaggio: TmeIWLabel;
    tabRichiestaRendiProj: TmedpIWTabControl;
    Wc01RichiesteRG: TmeIWRegion;
    Wc01ProspettoRG: TmeIWRegion;
    grdProspetto: TmedpIWDBGrid;
    tpProspetto: TIWTemplateProcessorHTML;
    DLista: TDataSource;
    tpRichieste: TIWTemplateProcessorHTML;
    grdRiepilogo: TmeIWGrid;
    btnConfermaPianificazione: TmeIWButton;
    btnVisRich: TmeIWButton;
    cmbFiltroProgetti: TmeIWComboBox;
    lblFiltroProgetti: TmeIWLabel;
    btnStampa: TmeIWButton;
    DCOMConnection1: TDCOMConnection;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure grdProspettoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdProspettoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure edtRichiestaAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure btnVisRichClick(Sender: TObject);
    procedure btnConfermaPianificazioneClick(Sender: TObject);
    procedure grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure cmbFiltroProgettiChange(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
  private
    DataRif:TDateTime;
    RigheAutorizzabili:Integer;
    TotOre1,TotOre2,TotOre3:Integer;
    ColOre:Integer;
    //MinTotAnnuoComp,MinTotAnnuoLiq,MinTotAutComp,MinTotAutLiq,MinTotInAttAutComp,MinTotInAttAutLiq,MinResiduiComp,MinResiduiLiq: Integer;
    Wc01DM: TWc01FRichiestaRendiProjDM;
    Wc01FModTabFM: TWc01FModificaTabelloneFM;
    R502ProDtM1:TR502ProDtM1;
    Autorizza: TAutorizza;
    FNVisRich,IdT750,FiltroProgetto:String;
    StileCella1,StileCella2: String;
    Operazione: String;
    procedure RecuperaListaFiltroProgetti;
    function AssegnaCodIterMancanti:Boolean;
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure imgIterClick(Sender: TObject);
    procedure AutorizzazioneOK(RowidT755:String;Aut:String);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgModificaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure TrasformaComponenti(FN:String);
    function  ControlliOK(FN: String): Boolean;
    procedure ControllaLimiteOreRichiedibili(MinLav,MinRichReg,TotMinRichOld,TotMinRichNew:Integer;Data:TDateTime);
    procedure actModRichiesta(FN:String);
    procedure Wc01AutorizzaTutti(Sender: TObject; var Ok: Boolean);
    procedure ElaboraProspetto;
    procedure CaricaLista;
    procedure VisualizzaGriglia;
    procedure CancellaRecord;
    procedure ModificaRecord(Ore:String);
    procedure InserisciRecord(Ore:String;IdTask:Integer;Data:TDateTime);
    //procedure ImpostaGrigliaRiepilogo;
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
  public
    function InizializzaAccesso:Boolean; override;
    procedure RicaricaProspetto;
  end;

implementation

uses W001UIrisWebDtM, SyncObjs;

{$R *.DFM}

function TWc01FRichiestaRendiProj.InizializzaAccesso:Boolean;
begin
  Result:=True;
  DataRif:=Parametri.DataLavoro;
  CampiV430:=CampiV430 + IfThen(CampiV430 <> '',',') + 'V430.T430INIZIO,V430.T430FINE';
  GetDipendentiDisponibili(DataRif);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
  if WR000DM.Responsabile then
    cmbDipendentiDisponibili.ItemIndex:=0;

  if WR000DM.Responsabile then
  begin
    medpAutorizzaMultiplo:=True;
    OnAutorizzaTutto:=Wc01AutorizzaTutti;
  end;

  VisualizzaDipendenteCorrente;
end;

procedure TWc01FRichiestaRendiProj.IWAppFormCreate(Sender: TObject);
begin
  Tag:=IfThen(WR000DM.Responsabile,100402,100401);
  inherited;
  Wc01DM:=TWc01FRichiestaRendiProjDM.Create(nil);
  Iter:=ITER_RENDI_PROJ;
  Wc01DM.C018:=C018;
  if WR000DM.Responsabile then
    C018.PreparaDataSetIter(Wc01DM.selT755,tiAutorizzazione)
  else
    C018.PreparaDataSetIter(Wc01DM.selT755,tiRichiesta);
  DataRif:=Parametri.DataLavoro;

  Self.HelpKeyWord:=IfThen(WR000DM.Responsabile,'Wc01P1','Wc01P0');

  cmbFiltroProgetti.Items.Add('<Tutti> = ########'); //tutti i progetti
  cmbFiltroProgetti.ItemIndex:=0;

  btnConfermaPianificazione.Visible:=not WR000DM.Responsabile and not SolaLettura;

  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdRichieste.medpDataSet:=Wc01DM.selT755;

  tabRichiestaRendiProj.AggiungiTab(A000TraduzioneStringhe('Richieste'), Wc01RichiesteRG);
  tabRichiestaRendiProj.AggiungiTab(A000TraduzioneStringhe('Prospetto'), Wc01ProspettoRG);
  if WR000DM.Responsabile then
    tabRichiestaRendiProj.ActiveTab:=Wc01RichiesteRG
  else
    tabRichiestaRendiProj.ActiveTab:=Wc01ProspettoRG;
  tabRichiestaRendiProj.TabByIndex(0).Visible:=WR000DM.Responsabile;
  tabRichiestaRendiProj.TabByIndex(1).Visible:=not WR000DM.Responsabile;
  tabRichiestaRendiProj.TabByIndex(0).LinkVisible:=False;
  tabRichiestaRendiProj.TabByIndex(1).LinkVisible:=False;

  grdRichieste.Parent:=Wc01RichiesteRG;

  grdProspetto.medpPaginazione:=False;
  grdProspetto.medpDataSet:=Wc01DM.cdsLista;
  grdProspetto.medpTestoNoRecord:='Nessun record';

  if not WR000DM.Responsabile then
    R502ProDtM1:=TR502ProDtM1.Create(Self);
end;

procedure TWc01FRichiestaRendiProj.IWAppFormRender(Sender: TObject);
begin
  inherited;
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;
end;

procedure TWc01FRichiestaRendiProj.RefreshPage;
begin
  WR000DM.Responsabile:=Tag = 100402;
  VisualizzaDipendenteCorrente;
end;

procedure TWc01FRichiestaRendiProj.DistruggiOggetti;
begin
  FreeAndNil(Wc01DM);
end;

procedure TWc01FRichiestaRendiProj.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  if R502ProDtM1 <> nil then
    FreeAndNil(R502ProDtM1);
end;

procedure TWc01FRichiestaRendiProj.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;
end;

procedure TWc01FRichiestaRendiProj.RecuperaListaFiltroProgetti;
var i,n,OldProg:Integer;
    ListaProj:String;
begin
  IdT750:=cmbFiltroProgetti.Items.ValueFromIndex[cmbFiltroProgetti.ItemIndex];
  cmbFiltroProgetti.Items.Clear;
  cmbFiltroProgetti.Items.Add('<Tutti> = ###########'); //tutti i progetti
  ListaProj:=',';
  if TuttiDipSelezionato then
  begin
    OldProg:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    n:=selAnagrafeW.RecordCount - 1;
    selAnagrafeW.First;
  end
  else
    n:=0;
  for i:=0 to n do
    with Wc01DM.selT750 do
    begin
      R180SetVariable(Wc01DM.selT750,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      R180SetVariable(Wc01DM.selT750,'DAL',Wc01DM.Dal);
      R180SetVariable(Wc01DM.selT750,'AL',Wc01DM.Al);
      Filtered:=True;//Filtro dizionario
      Open;
      First;
      while not Eof do
      begin
        if not R180InConcat(FieldByName('ID_T750').AsString,ListaProj) then
        begin
          cmbFiltroProgetti.Items.Add(Format('%-20s %s-%s %s = %s',[FieldByName('C_PROGETTO').AsString,FieldByName('DEC_PROGETTO').AsString,FieldByName('SCA_PROGETTO').AsString,FieldByName('D_PROGETTO').AsString,FieldByName('ID_T750').AsString]));
          ListaProj:=ListaProj + FieldByName('ID_T750').AsString + ',';
        end;
        Next;
      end;
      if TuttiDipSelezionato then
        selAnagrafeW.Next;
    end;
  if TuttiDipSelezionato then
    selAnagrafeW.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
  //Cerco l'itemindex dopo aver caricato tutti i progetti con la proprietà Sort attivata sulla combo
  cmbFiltroProgetti.ItemIndex:=0;
  for i:=0 to cmbFiltroProgetti.Items.Count - 1 do
    if cmbFiltroProgetti.Items.ValueFromIndex[i] = IdT750 then
    begin
      cmbFiltroProgetti.ItemIndex:=i;
      Break;
    end;
end;

procedure TWc01FRichiestaRendiProj.cmbFiltroProgettiChange(Sender: TObject);
begin
  VisualizzaDipendenteCorrente;
end;

procedure TWc01FRichiestaRendiProj.RicaricaProspetto;
begin
  VisualizzaDipendenteCorrente;
end;

procedure TWc01FRichiestaRendiProj.VisualizzaDipendenteCorrente;
var FiltroAnag:String;
    i:Integer;
begin
  inherited;
  Operazione:='';
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  lblMessaggio.Caption:='';
  // apertura dataset delle richieste straordinari
  with Wc01DM.selT755 do
  begin
    (*grdRiepilogo.Visible:=WR000DM.Responsabile;
    if grdRiepilogo.Visible then
      ImpostaGrigliaRiepilogo;*)

    // filtro periodo
    if not WR000DM.Responsabile and (C018.Periodo.Fine > R180AddMesi(C018.Periodo.Inizio,1) - 1) then
    begin
      GGetWebApplicationThreadVar.ShowMessage(A000MSG_Wc01_MSG_PERIODO_MAGGIORE_1_MESE);
      Exit;
    end;
    CorrezionePeriodo;
    R180SetVariable(Wc01DM.selT755,'FILTRO_PERIODO',C018.Periodo.Filtro);
    Wc01DM.Dal:=C018.Periodo.Inizio;
    Wc01DM.Al:=C018.Periodo.Fine;
    if C018.Periodo.Inizio = DATE_MIN {EncodeDate(1900,1,1)} then   // utilizzo costante
      edtPeriodoDal.Text:='';
    if C018.Periodo.Fine = DATE_MAX {EncodeDate(3999,12,31)} then  // utilizzo costante
      edtPeriodoAl.Text:='';

    RecuperaListaFiltroProgetti;

    FiltroProgetto:=',-1';//nel caso in cui non ci siano progetti nell'elenco
    if cmbFiltroProgetti.ItemIndex = 0 then
      for i:=1 to cmbFiltroProgetti.Items.Count - 1 do
        FiltroProgetto:=FiltroProgetto + ',' + cmbFiltroProgetti.Items.ValueFromIndex[i]
    else
      FiltroProgetto:=',' + cmbFiltroProgetti.Items.ValueFromIndex[cmbFiltroProgetti.ItemIndex];
    FiltroProgetto:=Trim(Copy(FiltroProgetto,2));
    R180SetVariable(Wc01DM.selT755,'FILTRO_PROGETTO','and T_ITER.ID_T752 in (select id from t752_task_rendiconto where id_t751 in (select id from t751_attivita_rendiconto where id_t750 in (' + FiltroProgetto + ')))');

    R180SetVariable(Wc01DM.selT753,'DAL',Wc01DM.Dal);
    R180SetVariable(Wc01DM.selT753,'AL',Wc01DM.Al);
    R180SetVariable(Wc01DM.selT753,'FILTRO_PROGETTO',FiltroProgetto);
    Wc01DM.selT753.Filtered:=False;
    Wc01DM.selT753.Open;//Aprire prima del R013Open perché serve in CalcFields

    // filtro in base alla selezione anagrafica
    FiltroAnag:=IfThen(TuttiDipSelezionato,
                       WR000DM.FiltroRicerca,
                       FiltroSingoloAnagrafico
                       );
    // inizializzazione variabili
    R180SetVariable(Wc01DM.selT755,'DATALAVORO',Parametri.DataLavoro);
    R180SetVariable(Wc01DM.selT755,'FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    R180SetVariable(Wc01DM.selT755,'FILTRO_ANAG',FiltroAnag);

    // proseguo con l'apertura ufficiale del dataset
    R013Open(Wc01DM.selT755); //*** //Open;
    if (not WR000DM.Responsabile) and AssegnaCodIterMancanti then
      Refresh;
    RigheAutorizzabili:=0;
    First;
  end;

  btnStampa.Visible:=not TuttiDipSelezionato and (cmbFiltroProgetti.ItemIndex > 0) and (C018.FiltroRichieste = '');

  if WR000DM.Responsabile then
  begin
    //Creazione ClientDataSet con stessa struttura del DataSet di partenza
    grdRichieste.medpCreaCDS;
    //Impostazione delle colonne da visualizzare sulla DBGrid
    grdRichieste.medpEliminaColonne;
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizzazione','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
    grdRichieste.medpAggiungiColonna('DATA','Data','',nil);
    grdRichieste.medpAggiungiColonna('ID_T752','Id','',nil);
    grdRichieste.medpAggiungiColonna('CF_C_PROGETTO','Progetto','',nil);
    grdRichieste.medpAggiungiColonna('CF_C_ATTIVITA','Attività','',nil);
    grdRichieste.medpAggiungiColonna('CF_C_TASK','Task','',nil);
    grdRichieste.medpAggiungiColonna('ORE','Ore da autorizzare','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_AUTORIZ','Ore ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);

    (*grdRichieste.medpAggiungiColonna('CF_ORE_LIMITE_MESE','Limite ore compensabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_AUT_MESE','Ore compensate','',nil);
    grdRichieste.medpAggiungiColonna('CF_RES_ORE_MESE','Residuo','',nil);
    grdRichieste.medpAggiungiColonna('CF_RIEP_ORE_MESE','Riepilogo','',nil);*)

    grdRichieste.medpColonna('DBG_COMANDI').Visible:=C018.IterModificaValori;
    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('ID_T752').Visible:=False;
    grdRichieste.medpColonna('ORE').Visible:=C018.IterModificaValori;

    (*grdRichieste.medpColonna('CF_ORE_LIMITE_MESE').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_AUT_MESE').Visible:=False;
    grdRichieste.medpColonna('CF_RES_ORE_MESE').Visible:=False;*)

    grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
    grdRichieste.medpInizializzaCompGriglia;
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
    if not SolaLettura then
    begin
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','null','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',1,0,DBG_CHK,'','Si','','');
      grdRichieste.medpPreparaComponenteGenerico('R',1,1,DBG_CHK,'','No','','');
    end;
    grdRichieste.medpCaricaCDS;
  end
  else
    ElaboraProspetto;
end;

function TWc01FRichiestaRendiProj.AssegnaCodIterMancanti:Boolean;
begin
  Result:=False;
  with Wc01DM.selT755 do
  begin
    while not Eof do
    begin
      if FieldByName('COD_ITER').IsNull then
      begin
        C018.SetCodIter;
        if C018.CodIter <> '' then
        begin
          SessioneOracle.Commit;
          Result:=True;
        end;
      end;
      Next;
    end;
    First;
  end;
end;

procedure TWc01FRichiestaRendiProj.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i,LivelloAutorizzazione: Integer;
    DRich:TDateTime;
    FreeComp:Boolean;
    OldProg,OldIdT752:String;
begin
  OldProg:='';
  OldIdT752:='';
  //Righe dati
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
    C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
    with (grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile) do
    begin
      OnClick:=imgIterClick;
      Hint:=C018.LeggiNoteComplete;
      ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);
    end;
    if not SolaLettura then
    begin
      with Wc01DM.selT753 do
      begin
        LivelloAutorizzazione:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);
        DRich:=StrToDate(grdRichieste.medpValoreColonna(i,'DATA'));
        if (OldProg <> grdRichieste.medpValoreColonna(i,'PROGRESSIVO'))
        or (OldIdT752 <> grdRichieste.medpValoreColonna(i,'ID_T752')) then
        begin
          Filtered:=False;
          Filter:='(PROGRESSIVO = ' + grdRichieste.medpValoreColonna(i,'PROGRESSIVO') + ') AND (ID_T752 = ' + grdRichieste.medpValoreColonna(i,'ID_T752') + ')';
          Filtered:=True;
          OldProg:=grdRichieste.medpValoreColonna(i,'PROGRESSIVO');
          OldIdT752:=grdRichieste.medpValoreColonna(i,'ID_T752');
        end;
        First;
        FreeComp:=True;
        while not Eof do
        begin
          if (DRich >= FieldByName('D_INI').AsDateTime)
          and (DRich <= FieldByName('D_FIN').AsDateTime)
          and (   FieldByName('CHIUSURA_DAL').IsNull
               or (DRich < FieldByName('CHIUSURA_DAL').AsDateTime)
               or (DRich > FieldByName('CHIUSURA_AL').AsDateTime)) then
          begin
            FreeComp:=False;
            Break;
          end;
          Next;
        end;
      end;
      if FreeComp then
      begin
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);//comandi
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[1]);//autorizzazione
      end
      else if not C018.ModificaValori(LivelloAutorizzazione) then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);//comandi
      // Associo l'evento OnClick all'icona di modifica
      if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
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
        (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:='invisibile';
        (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,3].Css:='invisibile';
      end;
      // Associo l'evento OnClick al checkbox di autorizzazione
      if grdRichieste.medpCompGriglia[i].CompColonne[1] <> nil then
      begin
        C018.SetValoriAut(grdRichieste,i,1,0,1,chkAutorizzazioneClick);
      end;
    end;
  end;
  Wc01DM.selT753.Filtered:=False;
end;

procedure TWc01FRichiestaRendiProj.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna:Integer;
    //S:String;
begin
  inherited;
  NumColonna:=grdRichieste.medpNumColonna(AColumn);
  if not grdRichieste.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (grdRichieste.medpColonna(NumColonna).DataField = 'D_AUTORIZZAZIONE') then
    ACell.CSS:=ACell.CSS + ' align_center font_grassetto';
  ACell.Wrap:=ARow <> 1;

  (*//Formatto il titolo dei riepiloghi
  if (ARow = 0) and (grdRichieste.medpColonna(NumColonna).DataField = 'CF_RIEP_ORE_MESE') then
  begin
    ACell.Css:=ACell.Css + ' align_center elencoOre';
    ACell.RawText:=True;
    ACell.Text:=ACell.Text + '<div align="center">' +
                             '<span>Limite</span>' +
                             '<span>Fruito</span>' +
                             '<span>Residuo</span>' +
                             '</div>';
  end;

  //Formatto il riepilogo delle ore
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (grdRichieste.medpColonna(NumColonna).DataField = 'CF_RIEP_ORE_MESE') then
  begin
    S:=grdRichieste.medpValoreColonna(ARow - 1,'CF_Riep_Ore_Mese');
    if S <> '' then
    begin
      ACell.Css:=ACell.Css + ' align_center elencoOre';
      ACell.RawText:=True;
      ACell.Text:='<div align="center">';
      ACell.Text:=ACell.Text + '<span>' + Copy(S,1,Pos(' ',S) - 1) + '</span>';
      S:=Copy(S,Pos(' ',S) + 1);
      ACell.Text:=ACell.Text + '<span>' + Copy(S,1,Pos(' ',S) - 1) + '</span>';
      S:=Copy(S,Pos(' ',S) + 1);
      ACell.Text:=ACell.Text + '<span' + IfThen(R180OreMinutiExt(grdRichieste.medpValoreColonna(ARow - 1,'CF_Ore_Aut_Mese')) > R180OreMinutiExt(grdRichieste.medpValoreColonna(ARow - 1,'CF_Ore_Limite_Mese')),' class="riga_evidenziata"') + '>' + S + '</span>';
      ACell.Text:=ACell.Text + '</div>';
    end;
  end;*)

  if Copy(grdRichieste.medpColonna(NumColonna).DataField,1,5) = 'CF_C_' then
    if ARow > 0 then
      ACell.Hint:=grdRichieste.medpValoreColonna(ARow - 1,'CF_D_' + Copy(grdRichieste.medpColonna(NumColonna).DataField,6));
  if ACell.Hint <> '' then
    ACell.Css:=ACell.Css + ' tooltipHtml';
  //Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdRichieste.medpCompGriglia) + 1) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWc01FRichiestaRendiProj.DBGridColumnClick(ASender: TObject; const AValue: string);
var IdRiga: Integer;
begin
  inherited;
  if (Operazione = 'M') then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_R013_ERR_FMT_COMPLETA_OPERAZIONE,['variazione']));
    exit;
  end;
  cdsT755.Locate('DBG_ROWID',AValue,[]);
  // prova la locate prima con rowid, quindi con id richiesta
  if not cdsT755.Locate('DBG_ROWID',AValue,[]) then
  begin
    if TryStrToInt(AValue,IdRiga) then
    begin
      if not cdsT755.Locate('ID',IdRiga,[]) then
        Exit;
    end
    else
      Exit;
  end;
end;

procedure TWc01FRichiestaRendiProj.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  with Wc01DM.selT755 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      GGetWebApplicationThreadVar.ShowMessage(A000MSG_R013_MSG_RICHIESTA_ND_VIS);
      Exit;
    end;
  end;
  VisualizzaDettagli(Sender);
end;

procedure TWc01FRichiestaRendiProj.chkAutorizzazioneClick(Sender: TObject);
var //i:Integer;
    Aut:String;
begin
  Autorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  Autorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  Autorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  // verifica presenza record
  with Wc01DM.selT755 do
  begin
    Refresh;
    if not SearchRecord('ROWID',Autorizza.RowId,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      GGetWebApplicationThreadVar.ShowMessage(A000MSG_R013_MSG_RICHIESTA_ND_VIS);
      Exit;
    end;
  end;

  DBGridColumnClick(Sender,Autorizza.Rowid);

  (*i:=grdRichieste.medpRigaDiCompGriglia((Sender as TmeIWCheckBox).FriendlyName);
  if (Wc01DM.TipoRichStr <> '1') and
     ((Sender as TmeIWCheckBox).Caption = 'Si') and
     (   ((R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_ORE_COMP_AUTORIZ')) > 0) and
          (R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_RES_ORE_COMP_ANNO')) < 0))
      or ((R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_ORE_LIQ_AUTORIZ')) > 0) and
          (R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_RES_ORE_LIQ_ANNO')) < 0))) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile autorizzare la richiesta perché è stato superato il limite annuale!');
    Exit;
  end;*)
  Aut:=IfThen(not Autorizza.Checked,'',IfThen(Autorizza.Caption = 'Si',C018SI,C018NO));
  AutorizzazioneOK(Autorizza.Rowid,Aut);
end;

procedure TWc01FRichiestaRendiProj.AutorizzazioneOK(RowidT755:String;Aut:String);
var LivelloAutorizzazione:Integer;
    AutOld:String;
    updIdT752,updProg,updVar:Integer;
    updData:TDateTime;
begin
  with Wc01DM,selT755 do
  begin
    AutOld:=FieldByName('AUTORIZZAZIONE').AsString;
    updIdT752:=FieldByName('ID_T752').AsInteger;
    updProg:=FieldByName('PROGRESSIVO').AsInteger;
    updData:=FieldByName('DATA').AsDateTime;
    updVar:=R180OreMinuti(FieldByName('CF_ORE_AUTORIZ').AsString);
    // salva i dati di autorizzazione
    try
      LivelloAutorizzazione:=FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      C018.InsAutorizzazione(LivelloAutorizzazione,Aut,Parametri.Operatore,'','',True);
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione);
      SessioneOracle.Commit;

      //Quando si nega una richiesta, bisogna decurtare il fruito sulla T753
      if (Aut = C018NO) and (AutOld <> C018NO) then
      begin
        //aggiorno tabella fruizioni del dipendente
        updT753.SetVariable('ID_T752',updIdT752);
        updT753.SetVariable('PROGRESSIVO',updProg);
        updT753.SetVariable('DATA',updData);
        updT753.SetVariable('VARIAZIONE',-updVar);//valore negativo
        updT753.Execute;
        SessioneOracle.Commit;
      end
      //Quando si autorizza o si toglie la negazione ad una richiesta precedentemente negata, bisogna aumentare il fruito sulla T753
      else if (Aut <> C018NO) and (AutOld = C018NO) then
      begin
        //aggiorno tabella fruizioni del dipendente
        updT753.SetVariable('ID_T752',updIdT752);
        updT753.SetVariable('PROGRESSIVO',updProg);
        updT753.SetVariable('DATA',updData);
        updT753.SetVariable('VARIAZIONE',updVar);//valore positivo
        updT753.Execute;
        SessioneOracle.Commit;
      end;
    except
      on E: Exception do
        GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_R013_ERR_FMT_AUT_FALLITA,[E.Message,E.ClassName]));
    end;
    Close;
    VisualizzaDipendenteCorrente;
  end;
end;

procedure TWc01FRichiestaRendiProj.imgCancellaClick(Sender: TObject);
var FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if (Operazione = 'M') then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_R013_ERR_FMT_COMPLETA_OPERAZIONE,['variazione']));
    exit;
  end;
  DBGridColumnClick(Sender,FN);
  // se record non esiste -> errore grave
  if not Wc01DM.selT755.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_R013_MSG_RICHIESTA_ND);
    Exit;
  end;
  CancellaRecord;
  VisualizzaDipendenteCorrente;
end;

procedure TWc01FRichiestaRendiProj.imgModificaClick(Sender: TObject);
var FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if (Operazione = 'M') then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_R013_ERR_FMT_COMPLETA_OPERAZIONE,['variazione']));
    exit;
  end;
  DBGridColumnClick(grdRichieste,FN);
  if not Wc01DM.selT755.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_R013_MSG_RICHIESTA_ND);
    Exit;
  end;
  // porta la riga in modifica: trasforma i componenti
  Operazione:='M';
  grdRichieste.medpBrowse:=False;
  grdRichieste.medpStato:=msEdit;
  TrasformaComponenti(FN);
end;

procedure TWc01FRichiestaRendiProj.imgConfermaClick(Sender: TObject);
var FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if not Wc01DM.selT755.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    Operazione:='';
    grdRichieste.medpBrowse:=True;
    grdRichieste.medpStato:=msBrowse;
    TrasformaComponenti(FN);
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_R013_MSG_RICHIESTA_ND);
    Exit;
  end;
  // effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;
  actModRichiesta(FN);
end;

procedure TWc01FRichiestaRendiProj.imgAnnullaClick(Sender: TObject);
var FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  // annullamento modifiche
  Operazione:='';
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  TrasformaComponenti(FN);
end;

procedure TWc01FRichiestaRendiProj.TrasformaComponenti(FN:String);
var DaTestoAControlli: Boolean;
    i:Integer;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  C018.CodIter:=grdRichieste.medpValoreColonna(i,'COD_ITER');

  ColOre:=grdRichieste.medpIndexColonna('CF_ORE_AUTORIZ');

  DaTestoAControlli:=grdRichieste.medpCompGriglia[i].CompColonne[ColOre] = nil;

  // Gestione icone comandi
  with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
  begin
    Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
    Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
    Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
    Cell[0,3].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
  end;

  // flag autorizzazione
  if grdRichieste.medpCompGriglia[i].CompColonne[1] <> nil then
  begin
    (grdRichieste.medpCompCella(i,1,0) as TmeIWCheckBox).Enabled:=not DaTestoAControlli;
    (grdRichieste.medpCompCella(i,1,1) as TmeIWCheckBox).Enabled:=not DaTestoAControlli;
  end;

  if DaTestoAControlli then
  begin
    // ore da autorizzare/autorizzate
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'width4chr','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColOre,grdRichieste.Componenti);
    with (grdRichieste.medpCompCella(i,ColOre,0) as TmeIWEdit) do
    begin
      Name:='edtOre';
      Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_AUTORIZ');
    end;
  end
  else
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColOre]);
end;

function TWc01FRichiestaRendiProj.ControlliOK(FN: String): Boolean;
var i,Prog,MinLav,MinRichReg,MinRichNew,TotMinRichNew,MinRichOld,TotMinRichOld:Integer;
    SOre:String;
    Data:TDateTime;
begin
  Result:=False;
  try
    i:=grdRichieste.medpRigaDiCompGriglia(FN);
    SOre:=(grdRichieste.medpCompCella(i,ColOre,0) as TmeIWEdit).Text;
    R180OraValidate(SOre);
  except
    on E:Exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage(E.Message);
      Exit;
    end;
  end;
  MinLav:=0;
  MinRichReg:=0;
  MinRichOld:=R180OreMinuti(grdRichieste.medpValoreColonna(i,'CF_ORE_AUTORIZ'));
  MinRichNew:=R180OreMinuti(SOre);
  //Ore da autorizzare maggiore di 00.00
  if MinRichNew < 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_Wc01_ORE_A_ZERO);
    Exit;
  end;
  //Non superare il limite di ore giornaliere rendicontabili
  Data:=StrToDate(grdRichieste.medpValoreColonna(i,'DATA'));
  Prog:=StrToInt(grdRichieste.medpValoreColonna(i,'PROGRESSIVO'));
  R502ProDtM1:=TR502ProDtM1.Create(Self);
  try
    R502ProDtM1.ResettaProg;
    R502ProDtM1.PeriodoConteggi(Data,Data);
    R502ProDtM1.Conteggi('Cartolina',Prog,Data);
    if R502ProDtM1.Blocca = 0 then
      MinLav:=R502ProDtM1.OreRendicontabili;
    with Wc01DM.selaT755 do
    begin
      Close;
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('DAL',Data);
      SetVariable('AL',Data);
      SetVariable('ID_T750',null);
      Open;
      if RecordCount > 0 then
        MinRichReg:=FieldByName('ORE_RICHIESTE_GG').AsInteger;
    end;
  finally
    FreeAndNil(R502ProDtM1);
  end;
  TotMinRichOld:=MinRichOld;
  TotMinRichNew:=MinRichNew;
  ControllaLimiteOreRichiedibili(MinLav,MinRichReg,TotMinRichOld,TotMinRichNew,Data);

  Result:=True;
end;

procedure TWc01FRichiestaRendiProj.ControllaLimiteOreRichiedibili(MinLav,MinRichReg,TotMinRichOld,TotMinRichNew:Integer;Data:TDateTime);
begin
  if (MinLav < (MinRichReg - TotMinRichOld + TotMinRichNew)) //ho sorpassato il limite giornaliero
  and (   (MinLav >= (MinRichReg - TotMinRichOld))           //e (       posso rientrare nel limite
       or (TotMinRichNew > 0)) then                          //   oppure posso azzerare le richieste superflue)
    raise Exception.Create(Format(A000MSG_Wc01_LIMITE_SUPERATO,[DateToStr(Data),R180MinutiOre(MinLav),R180MinutiOre(MinRichReg - TotMinRichOld + TotMinRichNew),R180MinutiOre(MinRichReg - TotMinRichOld + TotMinRichNew - MinLav)]));
end;

procedure TWc01FRichiestaRendiProj.actModRichiesta(FN:String);
var i,LivelloAutorizzazione:Integer;
    MinRichNew,MinRichOld:Integer;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  with Wc01DM,selT755 do
  begin
    MinRichOld:=R180OreMinuti(FieldByName('CF_ORE_AUTORIZ').AsString);
    MinRichNew:=R180OreMinuti((grdRichieste.medpCompCella(i,ColOre,0) as TmeIWEdit).Text);
    LivelloAutorizzazione:=FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
    C018.Id:=FieldByName('ID').AsInteger;
    C018.CodIter:=FieldByName('COD_ITER').AsString;
    C018.SetDatoAutorizzatore('ORE',(grdRichieste.medpCompCella(i,ColOre,0) as TmeIWEdit).Text,LivelloAutorizzazione);
    try
      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_R013_ERR_FMT_MOD_FALLITA,[E.Message]));
        Cancel;
      end;
    end;
    //aggiorno tabella fruizioni del dipendente
    updT753.SetVariable('ID_T752',FieldByName('ID_T752').AsInteger);
    updT753.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
    updT753.SetVariable('DATA',FieldByName('DATA').AsDateTime);
    updT753.SetVariable('VARIAZIONE',MinRichNew - MinRichOld);//valore positivo o negativo
    updT753.Execute;
    SessioneOracle.Commit;
  end;
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  VisualizzaDipendenteCorrente;
  //posizionamento su riga appena modificata
  grdRichieste.medpDataSet.Refresh;
  grdRichieste.medpDataSet.Locate('ROWID',FN,[]);
  grdRichieste.medpAggiornaCDS(False);
end;

procedure TWc01FRichiestaRendiProj.Wc01AutorizzaTutti(Sender: TObject; var Ok: Boolean); //***TWc01FRichiestaRendiProj.btnTuttiSiClick(Sender: TObject);
// Effettua l'autorizzazione positiva di tutte le richieste ancora da autorizzare visibili a video.
var
  RichChiuse,RichKO: Boolean;
  Aut,Messaggio:String;
  LivelloAutorizzazione:Integer;
  updIdT752,updProg,updVar:Integer;
  updData:TDateTime;
  OldProg,OldIdT752:String;
  function FormattaDatiRichiesta: String;
  begin
    with Wc01DM.selT755 do
    begin
      // formatta la richiesta
      Result:=Format('Richiesta effettuata da %s (%s) il %s',
                     [FieldByName('NOMINATIVO').AsString,
                      FieldByName('MATRICOLA').AsString,
                      FieldByName('DATA_RICHIESTA').AsString]) + CRLF +
              'Data: ' + FormatDateTime('mm/yyyy',FieldByName('DATA').AsDateTime) + CRLF +
              'Tipo: ' + FieldByName('Desc_Tipo').AsString;
    end;
  end;
begin
  OldProg:='';
  OldIdT752:='';
  Aut:=IfThen(Sender = btnTuttiSi,C018SI,C018NO);
  RichChiuse:=False;

  // autorizzazione richieste
  with Wc01DM,selT755 do
  begin
    // niente refresh: autorizza solo ciò che è visualizzato nella pagina
    First;
    while not Eof do
    begin
      try
        updIdT752:=FieldByName('ID_T752').AsInteger;
        updProg:=FieldByName('PROGRESSIVO').AsInteger;
        updData:=FieldByName('DATA').AsDateTime;
        updVar:=R180OreMinuti(FieldByName('CF_ORE_AUTORIZ').AsString);
        //Controllo se la richiesta è in un periodo chiuso...
        if (OldProg <> IntToStr(updProg))
        or (OldIdT752 <> IntToStr(updIdT752)) then
        begin
          selT753.Filtered:=False;
          selT753.Filter:='(PROGRESSIVO = ' + IntToStr(updProg) + ') AND (ID_T752 = ' + IntToStr(updIdT752) + ')';
          selT753.Filtered:=True;
          OldProg:=IntToStr(updProg);
          OldIdT752:=IntToStr(updIdT752);
        end;
        selT753.First;
        RichKO:=True;
        while not selT753.Eof do
        begin
          if (updData >= selT753.FieldByName('D_INI').AsDateTime)
          and (updData <= selT753.FieldByName('D_FIN').AsDateTime)
          and (   selT753.FieldByName('CHIUSURA_DAL').IsNull
               or (updData < selT753.FieldByName('CHIUSURA_DAL').AsDateTime)
               or (updData > selT753.FieldByName('CHIUSURA_AL').AsDateTime)) then
          begin
            RichKO:=False;
            Break;
          end;
          selT753.Next;
        end;
        //...in tal caso la escludo
        if RichKO then
          RichChiuse:=True
        else
        begin
          LivelloAutorizzazione:=FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
          C018.CodIter:=FieldByName('COD_ITER').AsString;
          C018.Id:=FieldByName('ID').AsInteger;
          try
            C018.InsAutorizzazione(LivelloAutorizzazione,Aut,Parametri.Operatore,'','',True);
            if C018.MessaggioOperazione <> '' then
              raise Exception.Create(C018.MessaggioOperazione);
            SessioneOracle.Commit;
          except
            on E: Exception do
            begin
              // messaggio bloccante
              MsgBox.MessageBox(Format(A000MSG_R013_ERR_FMT_AUT_FALLITA,[E.Message,E.ClassName]) + CRLF + CRLF +
                                FormattaDatiRichiesta,ESCLAMA);
              VisualizzaDipendenteCorrente;
              Exit;
            end;
          end;
          //Quando si nega una richiesta, bisogna decurtare il fruito sulla T753
          if Aut = C018NO then
          begin
            //aggiorno tabella fruizioni del dipendente
            updT753.SetVariable('ID_T752',updIdT752);
            updT753.SetVariable('PROGRESSIVO',updProg);
            updT753.SetVariable('DATA',updData);
            updT753.SetVariable('VARIAZIONE',-updVar);//valore negativo
            updT753.Execute;
            SessioneOracle.Commit;
          end;
        end;
      finally
        Next;
      end;
    end;
    Close;
  end;
  Wc01DM.selT753.Filtered:=False;
  VisualizzaDipendenteCorrente;
  if RichChiuse then
    Messaggio:=A000MSG_Wc01_RICHIESTE_PERIODO_CHIUSO;
  if Messaggio <> '' then
    GGetWebApplicationThreadVar.ShowMessage(Messaggio);
end;

procedure TWc01FRichiestaRendiProj.ElaboraProspetto;
begin
  CaricaLista;
  VisualizzaGriglia;
end;

procedure TWc01FRichiestaRendiProj.CaricaLista;
var i:Integer;
    Data:TDateTime;
begin
  with Wc01DM do
  begin
    cdsLista.Close;
    cdsLista.FieldDefs.Clear;
    cdsLista.FieldDefs.Add('C_PROGETTO',ftString,20,False);
    cdsLista.FieldDefs.Add('D_PROGETTO',ftString,100,False);
    cdsLista.FieldDefs.Add('C_ATTIVITA',ftString,10,False);
    cdsLista.FieldDefs.Add('D_ATTIVITA',ftString,100,False);
    cdsLista.FieldDefs.Add('C_TASK',ftString,10,False);
    cdsLista.FieldDefs.Add('D_TASK',ftString,100,False);
    cdsLista.FieldDefs.Add('ID_T752',ftInteger,0,False);
    cdsLista.FieldDefs.Add('ORE_RICHIESTE_TASK',ftString,6,False);
    for i:=0 to Trunc(Al - Dal) do
      cdsLista.FieldDefs.Add(FormatDateTime('yyyymmdd',Dal + i),ftDate,0,False);
    cdsLista.CreateDataSet;
    cdsLista.LogChanges:=False;
    cdsLista.IndexDefs.Clear;
    cdsLista.IndexDefs.Add('Ricerca',('C_PROGETTO;C_ATTIVITA;C_TASK'),[]);
    cdsLista.IndexName:='Ricerca';

    cdsListaGG.Close;
    cdsListaGG.FieldDefs.Clear;
    cdsListaGG.FieldDefs.Add('DATA',ftDate,0,False);
    cdsListaGG.FieldDefs.Add('ORE_RICHIEDIBILI',ftString,5,False);
    cdsListaGG.FieldDefs.Add('ORE_RICHIESTE_GG',ftString,5,False);
    cdsListaGG.FieldDefs.Add('ORE_RICHIESTE_PROJ',ftString,5,False);
    cdsListaGG.FieldDefs.Add('ORE_AUTORIZZATE',ftString,5,False);
    cdsListaGG.FieldDefs.Add('ID_T752_ABILITATI',ftString,1000,False);
    cdsListaGG.CreateDataSet;
    cdsListaGG.LogChanges:=False;
    cdsListaGG.IndexDefs.Clear;
    cdsListaGG.IndexDefs.Add('Ricerca',('DATA'),[]);
    cdsListaGG.IndexName:='Ricerca';

    TotOre1:=0;
    TotOre2:=0;
    TotOre3:=0;
    R502ProDtM1.ResettaProg;
    R502ProDtM1.PeriodoConteggi(Dal,Al);
    selaT755.Close;
    selaT755.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selaT755.SetVariable('DAL',Dal);
    selaT755.SetVariable('AL',Al);
    if cmbFiltroProgetti.ItemIndex > 0 then
      selaT755.SetVariable('ID_T750',cmbFiltroProgetti.Items.ValueFromIndex[cmbFiltroProgetti.ItemIndex])
    else
      selaT755.SetVariable('ID_T750',null);
    selaT755.Open;
    //Creo un record per ogni giorno
    for i:=0 to Trunc(Al - Dal) do
    begin
      Data:=Dal + i;
      cdsListaGG.Append;
      cdsListaGG.FieldByName('DATA').AsDateTime:=Data;
      R502ProDtM1.Conteggi('Cartolina',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data);
      if R502ProDtM1.Blocca = 0 then
      begin
        cdsListaGG.FieldByName('ORE_RICHIEDIBILI').AsString:=R180MinutiOre(R502ProDtM1.OreRendicontabili);
        TotOre1:=TotOre1 + R502ProDtM1.OreRendicontabili;
      end
      else
        cdsListaGG.FieldByName('ORE_RICHIEDIBILI').AsString:=R180MinutiOre(0);
      if selaT755.SearchRecord('DATA',Data,[srFromBeginning]) then
      begin
        cdsListaGG.FieldByName('ORE_RICHIESTE_GG').AsString:=R180MinutiOre(selaT755.FieldByName('ORE_RICHIESTE_GG').AsInteger);
        cdsListaGG.FieldByName('ORE_RICHIESTE_PROJ').AsString:=R180MinutiOre(selaT755.FieldByName('ORE_RICHIESTE_PROJ').AsInteger);
        cdsListaGG.FieldByName('ORE_AUTORIZZATE').AsString:=R180MinutiOre(selaT755.FieldByName('ORE_AUTORIZZATE').AsInteger);
        TotOre2:=TotOre2 + selaT755.FieldByName('ORE_RICHIESTE_GG').AsInteger;
        TotOre3:=TotOre3 + selaT755.FieldByName('ORE_RICHIESTE_PROJ').AsInteger;
      end
      else
      begin
        cdsListaGG.FieldByName('ORE_RICHIESTE_GG').AsString:=R180MinutiOre(0);
        cdsListaGG.FieldByName('ORE_RICHIESTE_PROJ').AsString:=R180MinutiOre(0);
        cdsListaGG.FieldByName('ORE_AUTORIZZATE').AsString:=R180MinutiOre(0);
      end;
      cdsListaGG.FieldByName('ID_T752_ABILITATI').AsString:=',';
      cdsListaGG.Post;
    end;
    selbT755.Close;
    selbT755.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selbT755.SetVariable('DAL',Dal);
    selbT755.SetVariable('AL',Al);
    selbT755.Open;
    //Recupero i task abilitati al dipendente
    selT753.Filter:='PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString;
    selT753.Filtered:=True;
    selT753.First;
    while not selT753.Eof do
    begin
      if not cdsLista.Locate('ID_T752',selT753.FieldByName('ID_T752').AsInteger,[]) then
      begin
        cdsLista.Append;
        cdsLista.FieldByName('C_PROGETTO').AsString:=selT753.FieldByName('C_PROGETTO').AsString;
        cdsLista.FieldByName('D_PROGETTO').AsString:=selT753.FieldByName('D_PROGETTO').AsString;
        cdsLista.FieldByName('C_ATTIVITA').AsString:=selT753.FieldByName('C_ATTIVITA').AsString;
        cdsLista.FieldByName('D_ATTIVITA').AsString:=selT753.FieldByName('D_ATTIVITA').AsString;
        cdsLista.FieldByName('C_TASK').AsString:=selT753.FieldByName('C_TASK').AsString;
        cdsLista.FieldByName('D_TASK').AsString:=selT753.FieldByName('D_TASK').AsString;
        cdsLista.FieldByName('ID_T752').AsInteger:=selT753.FieldByName('ID_T752').AsInteger;
        if selbT755.SearchRecord('ID_T752',selT753.FieldByName('ID_T752').AsInteger,[srFromBeginning]) then
          cdsLista.FieldByName('ORE_RICHIESTE_TASK').AsString:=R180MinutiOre(selbT755.FieldByName('ORE_RICHIESTE_TASK').AsInteger)
        else
          cdsLista.FieldByName('ORE_RICHIESTE_TASK').AsString:=R180MinutiOre(0);
        cdsLista.Post;
      end;
      for i:=0 to Trunc(Al - Dal) do
      begin
        Data:=Dal + i;
        if (Data >= selT753.FieldByName('D_INI').AsDateTime)
        and (Data <= selT753.FieldByName('D_FIN').AsDateTime)
        and (   (selT753.FieldByName('CHIUSURA_DAL').IsNull and selT753.FieldByName('CHIUSURA_AL').IsNull)
             or (Data < selT753.FieldByName('CHIUSURA_DAL').AsDateTime)
             or (Data > selT753.FieldByName('CHIUSURA_AL').AsDateTime)) then
        begin
          cdsListaGG.Locate('DATA',Data,[]);
          cdsListaGG.Edit;
          cdsListaGG.FieldByName('ID_T752_ABILITATI').AsString:=cdsListaGG.FieldByName('ID_T752_ABILITATI').AsString + selT753.FieldByName('ID_T752').AsString + ',';
          cdsListaGG.Post;
        end;
      end;
      selT753.Next;
    end;
  end;
  Wc01DM.selT753.Filtered:=False;
end;

procedure TWc01FRichiestaRendiProj.VisualizzaGriglia;
var i:Integer;
    Data:TDateTime;
begin
  with Wc01DM do
  begin
    grdProspetto.Caption:='Prospetto rendicontazione ' + C190PeriodoStr(Dal,Al);
    grdProspetto.Summary:=grdProspetto.Caption;
    if cdsLista.RecordCount > 0 then
    begin
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
      grdProspetto.medpRighePagina:=GetRighePaginaTabella;
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
    end;
    grdProspetto.medpCreaCDS;
    grdProspetto.medpEliminaColonne;
    for i:=0 to cdsLista.FieldDefs.Count - 1 do
      if cdsLista.FieldDefs[i].Name = 'ORE_RICHIESTE_TASK' then
        grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Ore','',nil)
      else if R180In(Copy(cdsLista.FieldDefs[i].Name,1,2),['C_','D_','ID']) then
      begin
        grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,IfThen(cdsLista.FieldDefs[i].Name = 'C_PROGETTO','Progetto',
                                                                    IfThen(cdsLista.FieldDefs[i].Name = 'C_ATTIVITA','Attività',
                                                                    IfThen(cdsLista.FieldDefs[i].Name = 'C_TASK','Task',
                                                                    IfThen(cdsLista.FieldDefs[i].Name = 'ID_T752','Id Task',
                                                                           'Descrizione')))),
                                         '',nil);
        if Copy(cdsLista.FieldDefs[i].Name,1,2) <> 'C_' then
          grdProspetto.medpColonna(cdsLista.FieldDefs[i].Name).Visible:=False;
      end
      else
      begin
        Data:=EncodeDate(StrToInt(Copy(cdsLista.FieldDefs[i].Name,1,4)),StrToInt(Copy(cdsLista.FieldDefs[i].Name,5,2)),StrToInt(Copy(cdsLista.FieldDefs[i].Name,7,2)));
        grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,FormatDateTime('dd/mm/yyyy',Data),'',nil);
      end;
  end;
  grdProspetto.medpInizializzaCompGriglia;
  grdProspetto.medpCaricaCDS;
end;

procedure TWc01FRichiestaRendiProj.grdProspettoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i,j,Progressivo:Integer;
    Data:TDateTime;
    IdTask,IdRich,OreRich:String;
    IdT752Abilitato:Boolean;
begin
  inherited;
  //Gestione dei link per le richieste autorizzabili
  for i:=0 to High(grdProspetto.medpCompGriglia) do
    for j:=0 to High(grdProspetto.medpCompGriglia[i].CompColonne) do
      if j >= NCOLONNEBLOCCATE then
        with Wc01DM do
        begin
          IdTask:=grdProspetto.medpValoreColonna(i,'ID_T752');
          Data:=EncodeDate(StrToInt(Copy(grdProspetto.medpColonna(j).DataField,1,4)),StrToInt(Copy(grdProspetto.medpColonna(j).DataField,5,2)),StrToInt(Copy(grdProspetto.medpColonna(j).DataField,7,2)));
          Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
          IdRich:='';
          OreRich:='_';
          if selT755.SearchRecord('ID_T752;DATA;PROGRESSIVO;AUTORIZZAZIONE',VarArrayOf([IdTask,Data,Progressivo,'S']),[srFromBeginning])
          or selT755.SearchRecord('ID_T752;DATA;PROGRESSIVO;AUTORIZZAZIONE',VarArrayOf([IdTask,Data,Progressivo,'']),[srFromBeginning]) then
          begin
            IdRich:=selT755.FieldByName('ID').AsString;
            OreRich:=IfThen(selT755.FieldByName('CF_ORE_AUTORIZ').IsNull,selT755.FieldByName('ORE').AsString,selT755.FieldByName('CF_ORE_AUTORIZ').AsString);
          end;
          //Recupero l'abilitazione al task per la data corrente
          cdsListaGG.Locate('DATA',Data,[]);
          IdT752Abilitato:=R180InConcat(IdTask,cdsListaGG.FieldByName('ID_T752_ABILITATI').AsString) and
                           ((R180OreMinuti(cdsListaGG.FieldByName('ORE_RICHIEDIBILI').AsString) - R180OreMinuti(cdsListaGG.FieldByName('ORE_AUTORIZZATE').AsString)) > 0); //ci sono ore da rendicontare
          //Creo il link
          if (IdRich <> '') //esiste già la richiesta non negata
          or (IdT752Abilitato and not SolaLettura) //posso inserire nuove richieste
          then
          begin
            grdProspetto.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
            //Creo i componenti preparati
            grdProspetto.medpCreaComponenteGenerico(i,j,grdProspetto.Componenti);
            with (grdProspetto.medpCompCella(i,j,0) as TmeIWEdit) do
            begin
              FriendlyName:=DateToStr(Data) + ';' + IdTask;//Data e IdTask servono a recuperare l'eventuale T755.id
              Tag:=Trunc(Data);
              NonEditableAsLabel:=True;
              Editable:=not SolaLettura and
                        R180InConcat(IdTask,cdsListaGG.FieldByName('ID_T752_ABILITATI').AsString) and //progetto non bloccato
                        (   (IdRich = '')                                       //richiesta inesistente
                         or (selT755.FieldByName('AUTORIZZAZIONE').IsNull and   //richiesta non ancora autorizzata...
                             selT755.FieldByName('CF_ORE_AUTORIZ').IsNull));    //...e ore non modificate dal responsabile
              if IdRich <> '' then //le note della richiesta si possono inserire solo dopo aver cliccato il btnConfermaPianificazione
              begin
                Text:=OreRich;
                OnAsyncDoubleClick:=edtRichiestaAsyncDoubleClick;
                if selT755.FieldByName('AUTORIZZAZIONE').AsString <> '' then
                  Css:=Css + ' font_grassetto';
              end;
            end;
          end;
        end;
end;

procedure TWc01FRichiestaRendiProj.grdProspettoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var r,c,Ore1,Ore2,Ore3,Progressivo:Integer;
    Data:TDateTime;
    Spaziatura,FontOre1,FontOre2,FontOre3,IdTask:String;
  function GetData(const S:String):String;
  begin
    Result:=Copy(FormatDateTime('dddd',StrToDate(S)),1,2) + '<br>';
    if R180Anno(Wc01DM.Dal) = R180Anno(Wc01DM.Al) then
    begin
      if R180Mese(Wc01DM.Dal) = R180Mese(Wc01DM.Al) then
      begin
        //Spaziatura:=DupeString('&nbsp;',MaxLenCaus + 1);
        Result:=Result + Spaziatura + Copy(S,1,2) + Spaziatura;
      end
      else
        Result:=Result + Copy(S,1,5)
    end
    else
      Result:=Result + FormatDateTime('dd/mm/yy',StrToDate(S));
  end;
begin
  inherited;
  if not grdProspetto.medpRenderCell(ACell, ARow, AColumn, True, True, False) then
    Exit;
  r:=ARow - 1;
  c:=grdProspetto.medpNumColonna(AColumn);
  if grdProspetto.medpColonna(c).DataField = 'ORE_RICHIESTE_TASK' then
  begin
    ACell.RawText:=True;
    ACell.Hint:='Ore rendicontate task';
    if ARow = 0 then
    begin
      ACell.Text:='Ore<br>rend.';
      FontOre1:=IfThen(TotOre1 > 0,'#5F5F5F','#B1B1B1');
      FontOre2:=IfThen(TotOre2 > TotOre1,'#E10000',IfThen(TotOre2 < TotOre1,'#0080C0',IfThen(TotOre1 > 0,'#008000','#B1B1B1'(*'#82C168'*))));
      FontOre3:=IfThen(TotOre3 > TotOre1,'#E10000',IfThen(TotOre3 < TotOre1,'#0080C0',IfThen(TotOre1 > 0,'#008000','#B1B1B1'(*'#82C168'*))));
      ACell.Text:=ACell.Text + '<br><span style="font-weight:normal; color:' + FontOre1 + '">' + R180MinutiOre(TotOre1) + '</span>';
      ACell.Text:=ACell.Text + '<br><span style="font-weight:normal; color:' + FontOre2 + '">' + R180MinutiOre(TotOre2) + '</span>';
      if cmbFiltroProgetti.ItemIndex > 0 then
        ACell.Text:=ACell.Text + '<br><span style="font-weight:normal; color:' + FontOre3 + '">' + R180MinutiOre(TotOre3) + '</span>';
      ACell.Hint:=ACell.Hint + '<br>Ore rendicontabili<br>Ore rendicontate' + IfThen(cmbFiltroProgetti.ItemIndex > 0,' totali<br>Ore rendicontate progetto');
    end
    else
    begin
      Ore1:=R180OreMinuti(ACell.Text);
      FontOre1:=IfThen(Ore1 > 0,'#5F5F5F','#B1B1B1');
      ACell.Css:=ACell.Css + ' align_center';
      ACell.Text:='<span style="font-weight:normal; color:' + FontOre1 + '">' + ACell.Text + '</span>';
      ACell.Hint:=Format('Progetto: %s<br>Attività: %s<br>Task: %s<br>%s',[grdProspetto.medpValoreColonna(r,'C_PROGETTO'),grdProspetto.medpValoreColonna(r,'C_ATTIVITA'),grdProspetto.medpValoreColonna(r,'C_TASK'),ACell.Hint]);
    end;
  end
  else if c >= NCOLONNEBLOCCATE then
    with Wc01DM do
    begin
      if ARow = 0 then
      begin
        Data:=StrToDate(ACell.Text);
        if DayOfWeek(Data) = 1 then
          ACell.Css:=ACell.Css + ' font_rosso';
        ACell.RawText:=True;
        ACell.Text:=GetData(ACell.Text);
        cdsListaGG.Locate('DATA',Data,[]);
        Ore1:=R180OreMinuti(cdsListaGG.FieldByName('ORE_RICHIEDIBILI').AsString);
        Ore2:=R180OreMinuti(cdsListaGG.FieldByName('ORE_RICHIESTE_GG').AsString);
        Ore3:=R180OreMinuti(cdsListaGG.FieldByName('ORE_RICHIESTE_PROJ').AsString);
        FontOre1:=IfThen(Ore1 > 0,'#5F5F5F','#B1B1B1');
        FontOre2:=IfThen(Ore2 > Ore1,'#E10000',IfThen(Ore2 < Ore1,'#0080C0',IfThen(Ore1 > 0,'#008000','#B1B1B1'(*'#82C168'*))));
        FontOre3:=IfThen(Ore3 > Ore1,'#E10000',IfThen(Ore3 < Ore1,'#0080C0',IfThen(Ore1 > 0,'#008000','#B1B1B1'(*'#82C168'*))));
        ACell.Text:=ACell.Text + '<br><span style="font-weight:normal; color:' + FontOre1 + '">' + cdsListaGG.FieldByName('ORE_RICHIEDIBILI').AsString + '</span>';
        ACell.Text:=ACell.Text + '<br><span style="font-weight:normal; color:' + FontOre2 + '">' + cdsListaGG.FieldByName('ORE_RICHIESTE_GG').AsString + '</span>';
        if cmbFiltroProgetti.ItemIndex > 0 then
          ACell.Text:=ACell.Text + '<br><span style="font-weight:normal; color:' + FontOre3 + '">' + cdsListaGG.FieldByName('ORE_RICHIESTE_PROJ').AsString + '</span>';
        ACell.Hint:='Data<br>Ore rendicontabili<br>Ore rendicontate' + IfThen(cmbFiltroProgetti.ItemIndex > 0,' totali<br>Ore rendicontate progetto');
      end
      else
      begin
        Data:=EncodeDate(StrToInt(Copy(grdProspetto.medpColonna(c).DataField,1,4)),StrToInt(Copy(grdProspetto.medpColonna(c).DataField,5,2)),StrToInt(Copy(grdProspetto.medpColonna(c).DataField,7,2)));
        ACell.Css:=ACell.Css + ' align_center';
        ACell.Hint:=Format('Progetto: %s<br>Attività: %s<br>Task: %s<br>Data: %s',[grdProspetto.medpValoreColonna(r,'C_PROGETTO'),grdProspetto.medpValoreColonna(r,'C_ATTIVITA'),grdProspetto.medpValoreColonna(r,'C_TASK'),FormatDateTime('dd/mm/yyyy',Data)]);
        if (Length(grdProspetto.medpCompGriglia) > 0) then
          if grdProspetto.medpCompGriglia[r].CompColonne[c] <> nil then
          begin
            ACell.Control:=grdProspetto.medpCompGriglia[r].CompColonne[c];
            //Evidenzio le richieste che presentano delle note
            IdTask:=grdProspetto.medpValoreColonna(r,'ID_T752');
            Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
            if selT755.SearchRecord('ID_T752;DATA;PROGRESSIVO;AUTORIZZAZIONE',VarArrayOf([IdTask,Data,Progressivo,'S']),[srFromBeginning])
            or selT755.SearchRecord('ID_T752;DATA;PROGRESSIVO;AUTORIZZAZIONE',VarArrayOf([IdTask,Data,Progressivo,'']),[srFromBeginning]) then
            begin
              C018.CodIter:=selT755.FieldByName('COD_ITER').AsString;
              C018.Id:=selT755.FieldByName('ID').AsInteger;
              C018.LeggiNoteComplete;
              if C018.NoteIndicate then
                ACell.Css:=ACell.Css + ' bg_giallo_pastello';
            end;
          end;
      end;
    end
  else
  begin
    if Copy(grdProspetto.medpColonna(c).DataField,1,2) = 'C_' then
      if ARow > 0 then
        ACell.Hint:=grdProspetto.medpValoreColonna(r,'D_' + Copy(grdProspetto.medpColonna(c).DataField,3));
  end;
  if ACell.Hint <> '' then
    ACell.Css:=ACell.Css + ' tooltipHtml';
end;

procedure TWc01FRichiestaRendiProj.edtRichiestaAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
var s:String;
begin
  FNVisRich:=(Sender as TmeIWEdit).FriendlyName;
  S:=Format('SubmitClick("%s","",true);',[btnVisRich.HTMLName]);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(S);
end;

procedure TWc01FRichiestaRendiProj.btnVisRichClick(Sender: TObject);
var FN:String;
begin
  Wc01FModTabFM:=TWc01FModificaTabelloneFM.Create(Self);
  FreeNotification(Wc01FModTabFM);
  with Wc01FModTabFM do
  begin
    Wc01DM_Mod:=Wc01DM;
    C018_Mod:=C018;
    FN:=FNVisRich;
    Data:=StrToDate(Copy(FN,1,Pos(';',FN) - 1));
    IdTask:=Copy(FN,Pos(';',FN) + 1);
    CaricaGriglia;
  end;
end;

procedure TWc01FRichiestaRendiProj.btnConfermaPianificazioneClick(Sender: TObject);
var d,i,j,Progressivo,MinLav,MinRichReg,MinRichNew,TotMinRichNew,MinRichOld,TotMinRichOld:Integer;
    Data:TDateTime;
    IdTask:String;
    MinVar:Boolean;
begin
  inherited;
  Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  MinVar:=False;
  //Scorrimento per i controlli
  with Wc01DM do
    for d:=0 to Trunc(Al - Dal) do
    begin
      j:=NCOLONNEBLOCCATE + d;
      Data:=Dal + d;
      cdsListaGG.Locate('DATA',Data,[]);
      MinLav:=R180OreMinuti(cdsListaGG.FieldByName('ORE_RICHIEDIBILI').AsString);
      MinRichReg:=R180OreMinuti(cdsListaGG.FieldByName('ORE_RICHIESTE_GG').AsString);
      TotMinRichNew:=0;
      TotMinRichOld:=0;
      for i:=0 to High(grdProspetto.medpCompGriglia) do
        if grdProspetto.medpCompGriglia[i].CompColonne[j] <> nil then
          with (grdProspetto.medpCompCella(i,j,0) as TmeIWEdit) do
            if Editable then
            begin
              IdTask:=grdProspetto.medpValoreColonna(i,'ID_T752');
              MinRichOld:=0;
              if selT755.SearchRecord('ID_T752;DATA;PROGRESSIVO;AUTORIZZAZIONE',VarArrayOf([IdTask,Data,Progressivo,'']),[srFromBeginning]) then
              begin
                MinRichOld:=R180OreMinuti(selT755.FieldByName('ORE').AsString);
                TotMinRichOld:=TotMinRichOld + MinRichOld;
              end;
              R180OraValidate(Text);
              MinRichNew:=R180OreMinuti(Text);
              TotMinRichNew:=TotMinRichNew + MinRichNew;
              if MinRichNew <> MinRichOld then
                MinVar:=True;
            end;
      ControllaLimiteOreRichiedibili(MinLav,MinRichReg,TotMinRichOld,TotMinRichNew,Data);
    end;
  //Scorrimento per le variazioni
  if not MinVar then
    exit;
  with Wc01DM do
    for d:=0 to Trunc(Al - Dal) do
    begin
      j:=NCOLONNEBLOCCATE + d;
      Data:=Dal + d;
      for i:=0 to High(grdProspetto.medpCompGriglia) do
        if grdProspetto.medpCompGriglia[i].CompColonne[j] <> nil then
          with (grdProspetto.medpCompCella(i,j,0) as TmeIWEdit) do
            if Editable then
            begin
              MinRichNew:=R180OreMinuti(Text);
              IdTask:=grdProspetto.medpValoreColonna(i,'ID_T752');
              if selT755.SearchRecord('ID_T752;DATA;PROGRESSIVO;AUTORIZZAZIONE',VarArrayOf([IdTask,Data,Progressivo,'']),[srFromBeginning]) then
              begin
                if MinRichNew = 0 then
                  CancellaRecord
                else
                  ModificaRecord(Text);
              end
              else if MinRichNew > 0 then
                InserisciRecord(Text,StrToInt(IdTask),Data);
            end;
    end;
  VisualizzaDipendenteCorrente;
end;

procedure TWc01FRichiestaRendiProj.CancellaRecord;
var updIdT752,updProg,updVar:Integer;
    updData:TDateTime;
begin
  with Wc01DM.selT755 do
  begin
    updIdT752:=FieldByName('ID_T752').AsInteger;
    updProg:=FieldByName('PROGRESSIVO').AsInteger;
    updData:=FieldByName('DATA').AsDateTime;
    updVar:=R180OreMinuti(IfThen(FieldByName('CF_ORE_AUTORIZ').IsNull,FieldByName('ORE').AsString,FieldByName('CF_ORE_AUTORIZ').AsString));
    C018.Id:=FieldByName('ID').AsInteger;
    C018.CodIter:=FieldByName('COD_ITER').AsString;
    C018.EliminaIter;
    SessioneOracle.Commit;
    Refresh;
  end;
  with Wc01DM do
  begin
    //aggiorno tabella fruizioni del dipendente
    updT753.SetVariable('ID_T752',updIdT752);
    updT753.SetVariable('PROGRESSIVO',updProg);
    updT753.SetVariable('DATA',updData);
    updT753.SetVariable('VARIAZIONE',-updVar);//valore negativo
    updT753.Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TWc01FRichiestaRendiProj.ModificaRecord(Ore:String);
var MinRichNew,MinRichOld:Integer;
begin
  with Wc01DM,selT755 do
  begin
    MinRichOld:=R180OreMinuti(FieldByName('ORE').AsString);
    MinRichNew:=R180OreMinuti(Ore);
    Edit;
    FieldByName('ORE').AsString:=Ore;
    Post;
    SessioneOracle.Commit;
    //aggiorno tabella fruizioni del dipendente
    updT753.SetVariable('ID_T752',FieldByName('ID_T752').AsInteger);
    updT753.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
    updT753.SetVariable('DATA',FieldByName('DATA').AsDateTime);
    updT753.SetVariable('VARIAZIONE',MinRichNew - MinRichOld);//valore positivo o negativo
    updT753.Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TWc01FRichiestaRendiProj.InserisciRecord(Ore:String;IdTask:Integer;Data:TDateTime);
begin
  with Wc01DM,selT755 do
  begin
    Append;
    FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    FieldByName('DATA').AsDateTime:=Data;
    FieldByName('ID_T752').AsInteger:=IdTask;
    FieldByName('ORE').AsString:=Ore;

    //Richiamo alla gestione ereditata degli iter
    try
      C018.InsRichiesta('R','','');
      if C018.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end;
      SessioneOracle.Commit;
      C018.SetCodIter;
      SessioneOracle.Commit;
    except
      on E:Exception do
      begin
        GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_R013_MSG_RICHIESTA_INS_FALLITO,[E.Message,E.ClassName]));
        Exit;
      end;
    end;
    updT753.SetVariable('ID_T752',IdTask);
    updT753.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    updT753.SetVariable('DATA',Data);
    updT753.SetVariable('VARIAZIONE',R180OreMinuti(Ore));//valore positivo
    updT753.Execute;
    SessioneOracle.Commit;
  end;
end;

(*procedure TWc01FRichiestaRendiProj.ImpostaGrigliaRiepilogo;
begin
  grdRiepilogo.ColumnCount:=3;
  grdRiepilogo.RowCount:=2;
  grdRiepilogo.Cell[0,0].Css:='';
  grdRiepilogo.Cell[0,0].RawText:=True;
  grdRiepilogo.Cell[0,0].Text:='Progetto';
  grdRiepilogo.Cell[0,1].Css:='';
  grdRiepilogo.Cell[0,1].RawText:=True;
  grdRiepilogo.Cell[0,1].Text:='Periodo';
  grdRiepilogo.Cell[0,2].Css:='';
  grdRiepilogo.Cell[0,2].RawText:=True;
  grdRiepilogo.Cell[0,2].Text:='Totali' +
                               '<div align="center" class="width100pc">' +
                               '<span>Limite</span>' +
                               '<span>Fruito</span>' +
                               '<span>In attesa</span>' +
                               '<span>Residuo</span>' +
                               '</div>';
  grdRiepilogo.Cell[1,0].Css:='';
  grdRiepilogo.Cell[1,0].RawText:=True;
  grdRiepilogo.Cell[1,0].Text:='';
  grdRiepilogo.Cell[1,1].Css:='';
  grdRiepilogo.Cell[1,1].RawText:=True;
  grdRiepilogo.Cell[1,1].Text:='';
  grdRiepilogo.Cell[1,2].Css:='';
  grdRiepilogo.Cell[1,2].RawText:=True;
  grdRiepilogo.Cell[1,2].Text:='<div align="center" class="width100pc">' +
                               '<span>' + R180MinutiOre(MinTotAnnuoComp) + '</span>' +
                               '<span>' + R180MinutiOre(MinTotAutComp) + '</span>' +
                               '<span>' + R180MinutiOre(MinTotInAttAutComp) + '</span>' +
                               '<span' + IfThen(MinResiduiComp < 0,' class="riga_evidenziata"') + '>' + R180MinutiOre(MinResiduiComp) + '</span>' +
                               '</div>';
end;*)

procedure TWc01FRichiestaRendiProj.grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  (*if not grdRiepilogo.Visible then
    exit;
  ACell.Css:=ACell.Css + ' align_center';
  if AColumn > 0 then
    ACell.Css:=ACell.Css + ' elencoOre';
  if ARow = 0 then
    ACell.Css:=ACell.Css + ' riga_intestazione'
  else
    ACell.Css:=ACell.Css + ' riga_bianca';*)
end;

procedure TWc01FRichiestaRendiProj.btnStampaClick(Sender: TObject);
var SelezioneAnagrafica,Mat,NomeFile:String;
    OrderBy:Integer;
    DettaglioLog:OleVariant;
begin
  lblCommentoCorrente.Caption:='';
  DettaglioLog:='';
  try
    NomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(NomeFile));
    SelezioneAnagrafica:=selAnagrafeW.SubstitutedSQL;
    if not TuttiDipSelezionato then
    begin
      // 12.2.6
      //Mat:=Trim(Copy(StringReplace(cmbDipendentiDisponibili.Text,SPAZIO,' ',[rfReplaceAll]),1,8));
      Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
      OrderBy:=Pos('ORDER BY',UpperCase(SelezioneAnagrafica));
      if OrderBy = 0 then
        SelezioneAnagrafica:=SelezioneAnagrafica + ' AND T030.MATRICOLA =''' + Mat + ''''
      else
        Insert(' AND T030.MATRICOLA =''' + Mat + ''' ',SelezioneAnagrafica,OrderBy);
    end;
    if (not IsLibrary) and
       (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then
    begin
      CoInitialize(nil);
    end;
    if not DCOMConnection1.Connected then
      DCOMConnection1.Connected:=True;
    try
      DCOMConnection1.AppServer.PrintAc04(SelezioneAnagrafica,
                                          NomeFile,
                                          Parametri.Operatore,
                                          Parametri.Azienda,
                                          WR000DM.selAnagrafe.Session.LogonDataBase,
                                          '{"seAnno":"' + IntToStr(R180Anno(Wc01DM.Dal)) + '","seMese":"' + IntToStr(R180Mese(Wc01DM.Dal)) + '","clbProgetti":"' + FiltroProgetto + '"}',
                                          DettaglioLog);
    finally
      DCOMConnection1.Connected:=False;
    end;
    if FileExists(NomeFile) then
      VisualizzaFile(NomeFile,Wc01DM.selT753.FieldByName('D_PROGETTO').AsString,nil,nil)
    else
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_Wc01_ERR_TAB_NON_COMPATIBILE));
  except
    on E:Exception do
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_Wc01_PARAM_STAMPA_NON_DISPONIB),[E.message]));
  end;
end;

end.
