unit W010URichiestaAssenze;

interface

uses
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, W000UMessaggi,
  A004UGiustifAssPresMW, W010URichiestaAssenzeDM, W010UCalcoloCompetenzeFM,
  W010UCancPeriodoFM, R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase,
  C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb, R600,
  B021UUtils,
  IWApplication, IWAppForm, SysUtils, Classes,
  Controls, IWCompLabel, DatiBloccati,
  IWControl, IWHTMLControls, IWCompListbox, IWCompEdit,
  Oracle, OracleData, IWCompCheckbox, Variants, IWBaseLayoutComponent,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, StrUtils,
  Forms, IWVCLBaseContainer, IWContainer, DB, IWCompMemo,
  RpCon, RpConDS, RpSystem, RpDefine, RpRave, RVCsStd, RVData,
  RvDirectDataView, RpRender, RpRenderPDF, RVClass, RVProj, DBClient,
  Math, IWDBGrids,medpIWDBGrid, meIWComboBox, meIWLabel, meIWImageFile,
  meIWCheckBox, meIWEdit, meIWMemo, meIWGrid, meIWButton, meIWRadioGroup,
  IWCompExtCtrls, IWCompGrids, IWCompButton, Menus, IWVCLComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, meIWLink,
  medpIWImageButton, W005UCartellinoFM;

type
  TRecordRichiesta = record
    TipoRichiesta,
    Operazione,
    NumeroOre,
    AOre: String;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    CSITipoMG: String;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    NumOrdFam: Integer;
    Assenza: Boolean;
    IdRevocato:Integer;
  end;

  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
  end;

  TW010FRichiestaAssenze = class(TR013FIterBase)
    cdsAutorizzazione: TClientDataSet;
    cdsAutorizzazionePROGRESSIVO: TIntegerField;
    cdsAutorizzazioneNOMINATIVO: TStringField;
    cdsAutorizzazioneMATRICOLA: TStringField;
    cdsAutorizzazioneSESSO: TStringField;
    cdsAutorizzazioneCAUSALE: TStringField;
    cdsAutorizzazioneD_CAUSALE: TStringField;
    cdsAutorizzazioneTIPOGIUST: TStringField;
    cdsAutorizzazioneDAL: TDateField;
    cdsAutorizzazioneAL: TDateField;
    cdsAutorizzazioneNUMEROORE: TStringField;
    cdsAutorizzazioneAORE: TStringField;
    cdsAutorizzazioneRESPONSABILE: TStringField;
    cdsAutorizzazioneD_RESPONSABILE: TStringField;
    cdsAutorizzazioneC_OGGETTO: TStringField;
    cdsAutorizzazioneC_DATA_FIRMA: TStringField;
    cdsAutorizzazioneC_TESTO: TStringField;
    dsrT050: TDataSource;
    cdsT050: TClientDataSet;
    cmbAccorpCausali: TmeIWComboBox;
    lblLegenda1: TmeIWLabel;
    lblLegenda2: TmeIWLabel;
    chkNoteIns: TmeIWCheckBox;
    edtOre: TmeIWEdit;
    edtAOre: TmeIWEdit;
    edtDal: TmeIWEdit;
    edtAl: TmeIWEdit;
    lblDal: TmeIWLabel;
    lblAl: TmeIWLabel;
    memNoteIns: TmeIWMemo;
    lblRiepAl: TmeIWLabel;
    edtRiepAl: TmeIWEdit;
    lblCausale: TmeIWLabel;
    btnInserisci: TmeIWButton;
    btnNascondiRiepilogo: TmeIWButton;
    btnVisualizzaRiepilogo: TmeIWButton;
    grdRiepilogo: TmeIWGrid;
    lblGiustificativo: TmeIWLabel;
    cmbCausaliDisponibili: TmeIWComboBox;
    lblFamiliari: TmeIWLabel;
    cmbFamiliari: TmeIWComboBox;
    rgpTipo: TmeIWRadioGroup;
    lblLegenda3: TmeIWLabel;
    btnImporta: TmeIWButton;
    edtPeriodoDalAl: TmeIWEdit;
    lblPeriodoDalAl: TmeIWLabel;
    btnCartellino: TmeIWImageFile;
    rgpTipoMG: TmeIWRadioGroup;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnInserisciClick(Sender: TObject);
    procedure btnVisualizzaRiepilogoClick(Sender: TObject);
    procedure grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure IWAppFormRender(Sender: TObject);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure chkAutorizzazioneAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnStampaRicevutaClick(Sender: TObject);
    procedure cdsAutorizzazioneCalcFields(DataSet: TDataSet);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure chkNoteInsAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnAnnullaClick(Sender: TObject);
    procedure grdRichiesteBeforeCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure cmbAccorpCausaliChange(Sender: TObject);
    procedure btnNascondiRiepilogoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure btnImportaClick(Sender: TObject);
    procedure edtPeriodoDalAlAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnCartellinoClick(Sender: TObject);
  private
    Dal,Al:TDateTime;
    R600DtM:TR600DtM1;
    ListaCausali,ListaFamiliari:TStringList;
    C,TG:String;
    DataCorr: TDateTime;
    Giustif: TGiustificativo;
    Minuti,AMinuti,GiorniRichiesti,GiorniIgnorati,GiorniInseriti:Integer;
    TotCompetenze:Real;
    Autorizza: TAutorizza;
    SegnalazioneCertStruttPubblica,SaltaControlli,
    CausaleSuccessiva,
    ShowAvvertimenti,
    AutorizzazioniDaConfermare: Boolean;
    RecordRichiesta: TRecordRichiesta;
    ElencoCausali,CausaleOriginale: String;
    StileCella1,StileCella2: String;
    AnomaliaAss: Byte; // cfr. R600.AnomaliaAssenze
    //rave report
    rvSystem:TRVSystem;
    rvDWDettaglio:TRaveDataView;
    rvProject:TRVProject;
    rvPage:TRaveComponent;
    rvRenderPDF:TRvRenderPDF;
    connDettaglio:TRVDataSetConnection;
    ScalaStampa:Real;
    W005FM: TW005FCartellinoFM;
    W010CalcoloCompetenzeFM: TW010FCalcoloCompetenzeFM;
    W010CancPeriodoFM: TW010FCancPeriodoFM;
    //A004MW: TA004FGiustifAssPresMW;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    CallBackNameCausaleChange: String;
    GestioneTipoMezzaGiornata: Boolean;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    procedure GetAccorpamentiDisponibili;
    procedure GetCausaliDisponibili;
    procedure GetFamiliari;
    procedure CreaR600;
    procedure RichiestaDaDefInConteggi(const RigaId: String; Includi: Boolean);
    procedure actIns0;
    procedure actIns1;
    procedure actIns2;
    procedure actInsRichiesta;
    procedure ConfermaInsRichiesta;
    procedure AnnullaInsRichiesta;
    procedure actDefRichiesta;
    procedure actCtrlRipristinoRich;
    procedure AutorizzazioneOK;
    procedure TrasformaComponenti(const FN:String; DaTestoAControlli:Boolean);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgRevocaClick(Sender: TObject);
    procedure actInsRevoca(const PTipoRichiesta: String; const PDal, PAl: TDateTime);
    procedure imgCancPeriodoClick(Sender: TObject);
    procedure imgDefinisciClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgConfermaDefClick(Sender: TObject);
    procedure imgIterClick(Sender: TObject);
    procedure imgAllegClick(Sender: TObject); // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2
    procedure imgDettaglioClick(Sender: TObject);
    procedure imgCartellinoClick(Sender: TObject);
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure W010AutorizzaTutto(Sender: TObject; var Ok: Boolean);
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    procedure OnCausaleChange(EventParams: TStringList);
    procedure AbilitaTipoMG(const PCausale: String; const PMezzaGiornata: Boolean);
    procedure OnTipoGiustChange(EventParams: TStringList);
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  protected
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    W010DM: TW010FRichiestaAssenzeDM;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
    function  InizializzaAccesso: Boolean; override;
  end;

const
  PAR_CODCAUS_CALLBACK = 'codcausale';
  PAR_MG_CALLBACK      = 'mg';

implementation

uses W001UIrisWebDtM, IWGlobal, SyncObjs;

{$R *.DFM}

function TW010FRichiestaAssenze.InizializzaAccesso:Boolean;
begin
  Result:=True;
  Dal:=ParametriForm.Dal;
  Al:=ParametriForm.Al;
  GetDipendentiDisponibili(Al);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  if WR000DM.Responsabile then
  begin
    // nasconde i componenti "causali disponibili" e "causali assenza"
    // NOTA: questi componenti vengono comunque utilizzati nel calcolo del riepilogo
    lblGiustificativo.Visible:=False;
    cmbCausaliDisponibili.Visible:=False;
    cmbAccorpCausali.Visible:=False;
    lblFamiliari.Visible:=False;
    cmbFamiliari.Visible:=False;

    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;
  end;

  // reimposta i filtri per questo iter su C018
  if WR000DM.Responsabile then
  begin
    // autorizzazione
    // in caso di acquisizione automatica assenze su IrisWin modifica i filtri
    if Parametri.CampiRiferimento.C90_W010AcquisizioneAuto = 'S' then
    begin
      // richieste da autorizzare considerano anche quelle autorizzate ma non ancora elaborate
      C018.FiltroRichiesta[trDaAutorizzare]:=Format('(%s) or (T_ITER.ELABORATO = ''N'' and (T851.STATO = ''N'' or T851.LIVELLO = I096F_ULTIMOLIV_OBB(:ITER, T850.COD_ITER)))',[C018.FiltroRichiesta[trDaAutorizzare]]);
      // richieste autorizzate / negate considerano solo quelle già elaborate
      C018.FiltroRichiesta[trAutorizzate]:=Format('(%s) and (T_ITER.ELABORATO <> ''N'' or T851.LIVELLO <> I096F_ULTIMOLIV_OBB(:ITER, T850.COD_ITER))',[C018.FiltroRichiesta[trAutorizzate]]);
      C018.FiltroRichiesta[trNegate]:=Format('(%s) and (T_ITER.ELABORATO <> ''N'' or T851.LIVELLO <> I096F_ULTIMOLIV_OBB(:ITER, T850.COD_ITER))',[C018.FiltroRichiesta[trNegate]]);
    end
    else
    begin
      // AOSTA_REGIONE - chiamata 75937.ini
      // richieste da autorizzare considerano solo quelle da elaborare
      // in modo da escludere le richieste (preventive o definitive)
      // con revoca autorizzata, per le quali l'iter non può proseguire
      C018.FiltroRichiesta[trDaAutorizzare]:=Format('(%s) and (T_ITER.ELABORATO = ''N'')',[C018.FiltroRichiesta[trDaAutorizzare]]);
      // AOSTA_REGIONE - chiamata 75937.fine
    end;
  end
  else
  begin
    // richiesta
    C018.FiltroRichiesta[trDaAutorizzare]:='decode(T850.TIPO_RICHIESTA,''P'',T851P.STATO,T850.STATO) is null';
  end;

  if WR000DM.Responsabile then
  begin
    medpAutorizzaMultiplo:=True;
    OnAutorizzaTutto:=W010AutorizzaTutto;
  end;

  // visualizza i dati del dipendente selezionato
  VisualizzaDipendenteCorrente;
end;

procedure TW010FRichiestaAssenze.IWAppFormCreate(Sender: TObject);
var
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  Q: TOracleQuery;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
begin
  Tag:=IfThen(WR000DM.Responsabile,407,406);
  inherited;
  W010DM:=TW010FRichiestaAssenzeDM.Create(Self);

  Iter:=ITER_GIUSTIF;
  if WR000DM.Responsabile then
  begin
    Self.HelpKeyWord:='W010P1';
    C018.PreparaDataSetIter(W010DM.selT050,tiAutorizzazione);
    btnCartellino.Visible:=False;
  end
  else
  begin
    Self.HelpKeyWord:=IfThen(C018.EsisteAutorizzIntermedia,'W010P2','W010P0');
    C018.PreparaDataSetIter(W010DM.selT050,tiRichiesta);
  end;
  C018.Periodo.SetVuoto;

  Dal:=Parametri.DataLavoro;
  Al:=Parametri.DataLavoro;
  WR000DM.selT265.Filtered:=True;  //Filtro Dizionario
  WR000DM.selT275.Filtered:=True;  //Filtro Dizionario

  // inserimento nuove richieste
  btnInserisci.Visible:=(not SolaLettura) and
                        (not WR000DM.Responsabile);
  edtDal.Visible:=not WR000DM.Responsabile;
  edtAl.Visible:=not WR000DM.Responsabile;
  lblDal.Visible:=not WR000DM.Responsabile;
  lblAl.Visible:=not WR000DM.Responsabile;
  rgpTipo.Visible:=not WR000DM.Responsabile;
  rgpTipoMG.Visible:=not WR000DM.Responsabile;
  edtOre.Visible:=not WR000DM.Responsabile;
  edtAOre.Visible:=not WR000DM.Responsabile;
  chkNoteIns.Visible:=not WR000DM.Responsabile;
  memNoteIns.Visible:=not WR000DM.Responsabile;
  if memNoteIns.Visible then
    memNoteIns.Css:='invisibile';

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  // registra funzione di callback
  CallBackNameCausaleChange:=UpperCase(Self.Name) + '.OnCausaleChange';
  GGetWebApplicationThreadVar.RegisterCallBack(CallBackNameCausaleChange,OnCausaleChange);
  GGetWebApplicationThreadVar.RegisterCallBack('W010_OnTipoGiustChange',OnTipoGiustChange);
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

  // causali di assenza e familiari
  WR000DM.selT265.Open;
  WR000DM.selT275.Open;
  ListaCausali:=TStringList.Create;
  // TORINO_ASLTO1 - chiamata <79586>.ini
  // la lista causali è inconsistente con i valori della combobox
  // il problema è legato alle causali con nome uguale ma case diverso
  ListaCausali.Duplicates:=dupIgnore; // ribadisce il valore di default: ignora i valori duplicati (non ci possono essere)
  ListaCausali.CaseSensitive:=True; // ignora i duplicati ma valuta il case sensitive
  // TORINO_ASLTO1 - chiamata <79586>.ini
  ListaCausali.Sorted:=True;
  GetAccorpamentiDisponibili;
  GetCausaliDisponibili;
  ListaFamiliari:=TStringList.Create;
  ListaFamiliari.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  edtRiepAl.Text:=DateToStr(Parametri.DataLavoro);

  // gestione tabella
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdRichieste.medpDataSet:=W010DM.selT050;
  grdRichieste.medpTestoNoRecord:='Nessuna richiesta';

  with WR000DM do
  begin
    selT265.Tag:=selT265.Tag + 1;
    selT275.Tag:=selT275.Tag + 1;
    selT257.Tag:=selT257.Tag + 1;
    selSG101.Tag:=selSG101.Tag + 1;
    selSG101Causali.Tag:=selSG101Causali.Tag + 1;
  end;

  // TORINO_ASLTO2 - 2013/044 - R600 utilizzato per controlli causali concatenate
  // crea oggetto R600 sempre
  CreaR600;
  // TORINO_ASLTO2.fine

  // inizializzazioni dati richiesta
  RecordRichiesta.TipoRichiesta:='';
  RecordRichiesta.Operazione:='I';
  RecordRichiesta.IdRevocato:=-1;

  AutorizzazioniDaConfermare:=False;

  (*
  if Parametri.CampiRiferimento.C90_W010AcquisizioneAuto = 'S' then
  begin
    A004MW:=TA004FGiustifAssPresMW.Create(Self);
    A004MW.Chiamante:='W010';
  end;
  *)

  lblPeriodoDalAl.Visible:=False;
  edtPeriodoDalAl.Visible:=False;

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  // visualizzazione e posizionamento del radiogroup tipo mezza giornata
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.ReadBuffer:=2;
    Q.SQL.Add('select sum(nvl(CSI_MAX_MGMAT,0) + nvl(CSI_MAX_MGPOM,0)) MAX_MG_TOT ');
    Q.SQL.Add('from   T265_CAUASSENZE ');
    Q.Execute;
    GestioneTipoMezzaGiornata:=Q.FieldAsInteger(0) > 0;
  finally
    FreeAndNil(Q);
  end;
  rgpTipoMG.Visible:=GestioneTipoMezzaGiornata and (not WR000DM.Responsabile);
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
end;

procedure TW010FRichiestaAssenze.RefreshPage;
begin
  WR000DM.Responsabile:=Tag = 407;
  // TORINO_ASLTO2 - 2013/044 - R600 utilizzato per controlli causali concatenate
  //FreeAndNil(R600DtM);
  // TORINO_ASLTO2.fine
  if not AutorizzazioniDaConfermare then // COMO_HSANNA - commessa 2011/178 - riesame del 15.05.2013
    VisualizzaDipendenteCorrente;
end;

procedure TW010FRichiestaAssenze.IWAppFormRender(Sender: TObject);
var
  Caus: String;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  LFattoreCorrezioneLeft: Integer;
  JsCode: String;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
begin
  inherited;
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;

  // autorizza / nega tutto
  if medpAutorizzaMultiplo then
  begin
    if btnTuttiSi.Visible then
      btnTuttiSi.Visible:=(W010DM.selT050.RecordCount > 0);
    btnTuttiNo.Visible:=btnTuttiSi.Visible;
  end;

  // acquisizione giustificativi
  // abilitata solo per le richieste da autorizzare se il corrispondente parametro aziendale è attivo
  btnImporta.Visible:=(Parametri.CampiRiferimento.C90_W010AcquisizioneAuto = 'S') and
                      (WR000DM.Responsabile) and // bugfix - SGIULIANOMILANESE_COMUNE - chiamata <76351>
                      (W010DM.selT050.RecordCount > 0) and
                      (C018.TipoRichiesteSel = [trDaAutorizzare]);

  // abilitazioni tipo fruizione causale
  if (not MsgBox.IsActive) and
     (not WR000DM.Responsabile) then
  begin
    Caus:=Trim(Copy(cmbCausaliDisponibili.Text,1,5));
    AddToInitProc('CausaleCambiata("' + Caus + '");');
  end;

  // note inserimento
  if chkNoteIns.Checked then
    memNoteIns.Css:='textarea_note inser';

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  if (GestioneTipoMezzaGiornata) and
     (rgpTipo.Visible) then
  begin
    // sposta il radiogroup del tipo mezza giornata in corrispondenza del radiobutton "mezza giornata"
    LFattoreCorrezioneLeft:=-7;
    JsCode:=Format('try { '#13#10 +
                   '  var p = $("#%s"); '#13#10 +
                   '  if (p.length > 0) { '#13#10 +
                   '    var offset = p.offset(); '#13#10 +
                   '    if (offset !== undefined) { '#13#10 +
                   '      $("#%s").offset({ left: offset.left + %d}); '#13#10 +
                   '    } '#13#10 +
                   '  } '#13#10 +
                   '} '#13#10 +
                   'catch (err) { '#13#10 +
                   '  try { console.log("spostamento radiogroup mezza giornata: " + err.message); } catch(err2) {} '#13#10 +
                   '} ',
                   [rgpTipo.HTMLName + '_INPUT_2',rgpTipoMG.HTMLName,LFattoreCorrezioneLeft]);
    AddToInitProc(JsCode);
  end;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
end;

procedure TW010FRichiestaAssenze.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    // chiusura frame cancellazione periodo
    if AComponent = W010CancPeriodoFM then
    begin
      try
        W010CancPeriodoFM:=nil;
        // aggiorna visualizzazione
        VisualizzaDipendenteCorrente;
      except
      end;
    end
    // chiusura frame calcolo competenze
    else if AComponent = W010CalcoloCompetenzeFM then
    begin
      try
        W010CalcoloCompetenzeFM:=nil;
      except
      end;
    end
    else if AComponent = W005FM then
    begin
      // chiusura frame cartellino
      try
        W005FM:=nil;
        // riapplica il filtro dizionario
        WR000DM.selT265.Filtered:=True;
        WR000DM.selT275.Filtered:=True;
      except
      end;
    end;

  end;
end;

procedure TW010FRichiestaAssenze.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  // COMO_HSANNA - commessa 2011/178 - riesame del 15.05.2013.ini
  // conferma nel caso di autorizzazioni pendenti da confermare
  if (Parametri.CampiRiferimento.C90_W010AcquisizioneAuto = 'S') and
     (AutorizzazioniDaConfermare) then
  begin
    Conferma:='Attenzione!'#13#10 +
              'Sono presenti autorizzazioni da confermare.'#13#10 +
              'Le modifiche non verrano perse, ma sarà necessario confermarle la volta successiva.'#13#10 +
              'Uscire comunque?';
  end;
  // COMO_HSANNA - commessa 2011/178 - riesame del 15.05.2013.fine
end;

// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
procedure TW010FRichiestaAssenze.AbilitaTipoMG(const PCausale: String; const PMezzaGiornata: Boolean);
var
  LAbilitaTipoMG: Boolean;
  LFruizMaxMattine, LFruizMaxPomeriggi: Integer;
  LClassName, LJsCode: String;
begin
  // abilitazione tipo mezza giornata
  LAbilitaTipoMG:=False;
  if PMezzaGiornata then
  begin
    // giustificativo di assenza a mezza giornata
    // abilita l'indicazione della tipologia di mezza giornata
    // solo se la causale prevede fruizioni mattine + pomeriggi > 0
    if PCausale <> '' then
    begin
      LFruizMaxMattine:=StrToIntDef(VarToStr(WR000DM.selT265.Lookup('CODICE',PCausale,'CSI_MAX_MGMAT')),0);
      LFruizMaxPomeriggi:=StrToIntDef(VarToStr(WR000DM.selT265.Lookup('CODICE',PCausale,'CSI_MAX_MGPOM')),0);
      LAbilitaTipoMG:=(LFruizMaxMattine + LFruizMaxPomeriggi) > 0;
    end;
  end;

  // imposta la classe per il componente radiogroup in modo da renderlo visibile o meno
  if (GestioneTipoMezzaGiornata) and
     (not WR000DM.Responsabile) then
  begin
    LClassName:=IfThen(LAbilitaTipoMG,'intestazione','nascosto');
    rgpTipoMG.Css:=LClassName;
    if GGetWebApplicationThreadVar.IsCallBack then
    begin
      LJsCode:=Format('document.getElementById("%s").className = ''%s'';',[rgpTipoMG.HTMLName,LClassName]);
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(LJsCode);
    end;
  end;
end;
// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
procedure TW010FRichiestaAssenze.OnCausaleChange(EventParams: TStringList);
var
  LCodCaus: String;
  LMezzaGiornata: Boolean;
begin
  // estrae codice causale selezionata
  LCodCaus:=EventParams.Values[PAR_CODCAUS_CALLBACK];
  // valuta se è selezionato il tipo "mezza giornata"
  // rgpTipoGiust.ItemIndex non è attendibile qui
  LMezzaGiornata:=EventParams.Values[PAR_MG_CALLBACK].ToUpper = 'S';

  AbilitaTipoMG(LCodCaus,LMezzaGiornata);
end;
// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
procedure TW010FRichiestaAssenze.OnTipoGiustChange(EventParams: TStringList);
var
  LCodCaus: String;
  LMezzaGiornata: Boolean;
begin
  // codice causale selezionata
  LCodCaus:=EventParams.Values[PAR_CODCAUS_CALLBACK];
  // valuta se è selezionato il tipo "mezza giornata"
  // rgpTipoGiust.ItemIndex non è attendibile qui
  LMezzaGiornata:=EventParams.Values[PAR_MG_CALLBACK].ToUpper = 'S';

  AbilitaTipoMG(LCodCaus,LMezzaGiornata);
end;
// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

procedure TW010FRichiestaAssenze.CreaR600;
// Crea e imposta l'oggetto R600
begin
  Log('Traccia','CreaR600 - inizio');
  R600DtM:=TR600DtM1.Create(Self);
  //R600DtM.VisualizzaAnomalie:=False;
  //R600DtM.AnomalieBloccanti:=True;
  R600DtM.IterAutorizzativo:=True;
  Log('Traccia','CreaR600 - fine');
end;

procedure TW010FRichiestaAssenze.GetAccorpamentiDisponibili;
var CodDescAccorp:String;
begin
  with WR000DM do
  begin
    selT257.SetVariable('INDATA',Parametri.DataLavoro);
    selT257.Close;
    selT257.Open;
    if selT257.RecordCount > 0 then
    begin
      cmbAccorpCausali.Visible:=True;
      cmbAccorpCausali.Items.Add('');
      while not selT257.Eof do
      begin
        CodDescAccorp:=Format('%-5s %s',[selT257.FieldByName('COD_CODICIACCORPCAUSALI').AsString,
                                       selT257.FieldByName('DESCRIZIONE').AsString]);
        if cmbAccorpCausali.Items.IndexOf(CodDescAccorp) < 0 then
          cmbAccorpCausali.Items.Add(CodDescAccorp);
        selT257.Next;
      end;
      if (Parametri.CampiRiferimento.C90_W010CausPres = 'S') and (selT275.RecordCount > 0) then
        cmbAccorpCausali.Items.Add(Format('%-5s %s',['','Causali di presenza']));
      cmbAccorpCausali.ItemIndex:=0;
    end
    else
      cmbAccorpCausali.Visible:=False;
  end;
end;

procedure TW010FRichiestaAssenze.GetCausaliDisponibili;
{ Popola la combo delle causali disponibili e in più prepara un array associativo
  in javascript per abilitare / disabilitare i radiobutton di scelta del tipo
  di fruizione (giornata, mezza gg.,...)
  L'array è del tipo
    arrCausFruiz["CAUSALE_1"] = bbbb;
    arrCausFruiz["CAUSALE_2"] = bbbb;
    arrCausFruiz["CAUSALE_3"] = bbbb;
    ...

  bbbb è una stringa di 4 cifre binarie che indicano il tipo di fruizione
       abilitato (0 = disabilitato, 1 = abilitato).

  pos. 1: fruizione a giornata
  pos. 2: fruizione a mezza giornata
  pos. 3: fruizione a num. ore
  pos. 4: fruizione di tipo da ore - a ore
}
var
  Codice,JsCodeFruiz,FruizG,FruizMG,FruizN,FruizD,JsCodeFam,Fam,JsCodeTipo: String;
begin
  Log('Traccia','GetCausaliDisponibili - inizio');
  ListaCausali.Clear;
  cmbCausaliDisponibili.Items.Clear;

  // aggiunge l'item vuoto
  ListaCausali.Add('');
  cmbCausaliDisponibili.Items.Add('');

  // popolamento combo
  with WR000DM.selT265 do
  begin
    //Close;
    Open;
    First;

    // prepara un array associativo (in javascript) per abilitare / disabilitare
    // i radiobutton di scelta del tipo di fruizione (giornata, mezza gg.,...)
    JsCodeFruiz:=IfThen(RecordCount = 0,'','var arrCausFruiz = { ');
    JsCodeFam:=IfThen(RecordCount = 0,'','var arrCausFam = { ');
    JsCodeTipo:=IfThen(RecordCount = 0,'','var arrCausTipo = { ');

    while not Eof do
    begin
      // salva dati in variabili di appoggio
      Codice:=FieldByName('CODICE').AsString;
      //Filtro le causali se l'accorpamento è valorizzato
      WR000DM.selT257.First;
      if (Trim(cmbAccorpCausali.Text) = '') or
         WR000DM.selT257.Locate('COD_CODICIACCORPCAUSALI;COD_CAUSALE',
         VarArrayOf([Trim(copy(cmbAccorpCausali.Text,1,5)),Codice]),[]) then
      begin
        FruizG:=IfThen(FieldByName('UM_INSERIMENTO').AsString = 'S','1','0');
        FruizMG:=IfThen(FieldByName('UM_INSERIMENTO_MG').AsString = 'S','1','0');
        FruizN:=IfThen(FieldByName('UM_INSERIMENTO_H').AsString = 'S','1','0');
        FruizD:=IfThen(FieldByName('UM_INSERIMENTO_D').AsString = 'S','1','0');
        Fam:=IfThen((R180CarattereDef(FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D']) or
                    (R180CarattereDef(FieldByName('FRUIZIONE_FAMILIARI').AsString,1,'N') in ['S','D']),'1','0');

        cmbCausaliDisponibili.Items.Add(StringReplace(Format('%-5s %s',[Codice,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
        ListaCausali.Add(Codice);

        // aggiunge elemento all'array javascript
        if JsCodeFruiz <> 'var arrCausFruiz = { ' then
        begin
          JsCodeFruiz:=JsCodeFruiz + ', ';
          JsCodeFam:=JsCodeFam + ', ';
          JsCodeTipo:=JsCodeTipo + ', ';
        end;
        JsCodeFruiz:=JsCodeFruiz + '"' + Codice + '":"' + FruizG + FruizMG + FruizN + FruizD + '"';
        JsCodeFam:=JsCodeFam + '"' + Codice + '":"' + Fam + '"';
        JsCodeTipo:=JsCodeTipo + '"' + Codice + '":"A"';
      end;
      Next;
    end;
  end;

  with WR000DM.selT275 do
  begin
    //Close;
    Open;
    First;
    if Parametri.CampiRiferimento.C90_W010CausPres = 'S' then
    begin
      // prepara un array associativo (in javascript) per abilitare / disabilitare
      // i radiobutton di scelta del tipo di fruizione (giornata, mezza gg.,...)
      if JsCodeFruiz = '' then
        JsCodeFruiz:=IfThen(RecordCount = 0,'','var arrCausFruiz = { ');
      if JsCodeFam = '' then
        JsCodeFam:=IfThen(RecordCount = 0,'','var arrCausFam = { ');
      if JsCodeTipo = '' then
        JsCodeTipo:=IfThen(RecordCount = 0,'','var arrCausTipo = { ');

      while not Eof do
      begin
        // salva dati in variabili di appoggio
        Codice:=FieldByName('CODICE').AsString;
        //Filtro le causali se l'accorpamento è valorizzato o se non sono fruibili
        WR000DM.selT257.First;
        if  (   (Trim(cmbAccorpCausali.Text) = '')
             or (Trim(cmbAccorpCausali.Text) = 'Causali di presenza'))
        and (   (FieldByName('UM_INSERIMENTO_H').AsString = 'S')
             or (FieldByName('UM_INSERIMENTO_D').AsString = 'S')) then
        begin
          FruizG:='0';
          FruizMG:='0';
          FruizN:=IfThen(FieldByName('UM_INSERIMENTO_H').AsString = 'S','1','0');
          FruizD:=IfThen(FieldByName('UM_INSERIMENTO_D').AsString = 'S','1','0');
          Fam:='0';

          cmbCausaliDisponibili.Items.Add(StringReplace(Format('%-5s %s',[Codice,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
          ListaCausali.Add(Codice);

          // aggiunge elemento all'array javascript
          if JsCodeFruiz <> 'var arrCausFruiz = { ' then
          begin
            JsCodeFruiz:=JsCodeFruiz + ', ';
            JsCodeFam:=JsCodeFam + ', ';
            JsCodeTipo:=JsCodeTipo + ', ';
          end;
          JsCodeFruiz:=JsCodeFruiz + '"' + Codice + '":"' + FruizG + FruizMG + FruizN + FruizD + '"';
          JsCodeFam:=JsCodeFam + '"' + Codice + '":"' + Fam + '"';
          JsCodeTipo:=JsCodeTipo + '"' + Codice + '":"P"';
        end;
        Next;
      end;
    end;
  end;
  cmbCausaliDisponibili.ItemIndex:=0;

  Log('Traccia','GetCausaliDisponibili: popolamento ok');

  if JsCodeFruiz = '' then
    Exit;

  // imposta il javascript da includere nel documento
  with Javascript do
  begin
    Add(Copy(JsCodeFruiz,1,Length(JsCodeFruiz)) + ' };');
    Add(Copy(JsCodeFam,1,Length(JsCodeFam)) + ' };');
    Add(Copy(JsCodeTipo,1,Length(JsCodeTipo)) + ' };');
    Add(' ');
    Add('function CausaleCambiata(CodCausale) { ');
    Add('  CodCausale = trim(CodCausale); ');
    Add('  try { ');
    Add('    try { ');
    Add('      var lblFamiliariElem = FindElem("LBLFAMILIARI"); ');
    Add('      var cmbFamiliariElem = FindElem("CMBFAMILIARI"); ');
    Add('      var GestFam = "0"; ');
    Add('      if (CodCausale != "") { ');
    Add('        GestFam = arrCausFam[CodCausale]; ');
    Add('      } ');
    Add('      cmbFamiliariElem.style.visibility = (GestFam == "1") ? "visible" : "hidden";');
    Add('      lblFamiliariElem.style.visibility = (GestFam == "1") ? "visible" : "hidden";');
    Add('    } ');
    Add('    catch(err) { ');
    Add('      //alert("Errore: " + err.message + "\n" + err.description); ');
    Add('    } ');
    Add('    // inizializzazione variabili di appoggio ');
    Add('    var edtOreElem = FindElem("EDTORE"); ');
    Add('    var edtAOreElem = FindElem("EDTAORE"); ');
    Add('    var btnInserisciElem = FindElem("BTNINSERISCI"); ');
    Add('    var Fruizioni = "1111"; ');
    Add('    if (CodCausale != "") { ');
    Add('      Fruizioni = arrCausFruiz[CodCausale]; ');
    Add('    } ');
    Add('    // creazione array di puntatori agli input di tipo radiobutton');
    Add('    numElem = 4; ');
    Add('    var arrRbTipo = new Array(numElem); ');
    Add('    for (i = 0; i < numElem; i++) { ');
    Add('      arrRbTipo[i] = FindElem("RGPTIPO_INPUT_" + (i + 1)); ');
    Add('    } ');
    Add('    // anomalia se nessun tipo fruizione è abilitato');
    Add('    window.status = (Fruizioni == "0000") ? "La causale selezionata non ha tipologie di fruizione abilitate!" : ""');
    Add('    // abilitazioni dei radiobutton per il tipo fruizione ');
    Add('    var indexChecked = -1; ');
    Add('    var firstEnabled = -1; ');
    Add('    for (i = numElem - 1; i >= 0; i--) { ');
    Add('      if (Fruizioni.substr(i,1) == "0") { ');
    Add('        arrRbTipo[i].style.visibility = "hidden"; ');
    Add('        arrRbTipo[i].nextSibling.style.visibility = "hidden"; ');
    Add('        if (arrRbTipo[i].checked) { ');
    Add('          arrRbTipo[i].checked = false; ');
    Add('          indexChecked = -1; ');
    Add('        } ');
    Add('      } ');
    Add('      else { ');
    Add('        firstEnabled = i; ');
    Add('        arrRbTipo[i].style.visibility = "visible"; ');
    Add('        arrRbTipo[i].nextSibling.style.visibility = "visible"; ');
    Add('      } ');
    Add('      if (arrRbTipo[i].checked) ');
    Add('        indexChecked = i; ');
    Add('    } ');
    Add('    // verifica se dopo il ciclo nessun radiobutton risulta selezionato ');
    Add('    if (indexChecked == -1) { ');
    Add('      // seleziona il primo radiobutton abilitato (se presente)');
    Add('      if (firstEnabled > -1) { ');
    Add('        indexChecked = firstEnabled; ');
    Add('        arrRbTipo[indexChecked].checked = true; ');
    Add('      } ');
    Add('    } ');
    Add('    // gestione disabilitazione pulsanti (caso di nessuna fruizione possibile) ');
    Add('    if (btnInserisciElem != null) ');
    Add('      btnInserisciElem.disabled = (firstEnabled == -1); ');
    Add('    // abilitazioni campi da ore / a ore ');
    Add('    edtOreElem.style.visibility = (indexChecked <= 1) ? "hidden" : "visible"; ');
    Add('    edtAOreElem.style.visibility = (indexChecked < 3) ? "hidden" : "visible"; ');
    Add('    if (indexChecked <= 1) ');
    Add('      edtOreElem.value = ""; ');
    Add('    if (indexChecked < 3) ');
    Add('      edtAOreElem.value = ""; ');
    Add('    try { ');
    Add('      var lblDalElem = FindElem("LBLDAL"); ');
    Add('      var edtDalElem = FindElem("EDTDAL"); ');
    Add('      var lblAlElem = FindElem("LBLAL"); ');
    Add('      var edtAlElem = FindElem("EDTAL"); ');
//    Add('      var lblRiepAlElem = FindElem("LBLRIEPAL"); ');
//    Add('      var edtRiepAlElem = FindElem("EDTRIEPAL"); ');
    Add('      var btnVisualizzaRiepilogoElem = FindElem("BTNVISUALIZZARIEPILOGO"); ');
    Add('      var TipoCaus; ');
    Add('      if (CodCausale != "") { ');
    Add('        TipoCaus = arrCausTipo[CodCausale]; ');
    Add('      } ');
    if (not Parametri.ModuloInstallato['TORINO_CSI_PRV'])  then
    begin
      Add('      lblDalElem.style.visibility = (TipoCaus == "A") ? "visible" : "hidden";');
      Add('      edtDalElem.style.visibility = (TipoCaus == "A") ? "visible" : "hidden";');
      Add('      lblAlElem.innerText = (TipoCaus == "A") ? "al" : "Data";');
    end
    else
    begin
      Add('      lblDalElem.style.visibility = (TipoCaus == "A" || CodCausale == "AUTST") ? "visible" : "hidden";');
      Add('      edtDalElem.style.visibility = (TipoCaus == "A" || CodCausale == "AUTST") ? "visible" : "hidden";');
      Add('      lblAlElem.innerText = (TipoCaus == "A" || CodCausale == "AUTST") ? "al" : "Data";');
    end;
//    Add('      edtAlElem.title = (TipoCaus == "A") ? "Data di fine per la richiesta di giustificativo in inserimento. Formato ddmmyyyy" : "Data per la richiesta di giustificativo in inserimento. Formato ddmmyyyy";');
//    Add('      lblRiepAlElem.style.visibility = (TipoCaus == "A") ? "visible" : "hidden";');
//    Add('      edtRiepAlElem.style.visibility = (TipoCaus == "A") ? "visible" : "hidden";');
    Add('      btnVisualizzaRiepilogoElem.style.visibility = (TipoCaus == "A") ? "visible" : "hidden";');
    Add('    } ');
    Add('    catch(err) { ');
    Add('      alert("Errore: " + err.message + "\n" + err.description); ');
    Add('    } ');
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    // richiama funzione delphi in async per gestione tipologia mezza giornata
    Add('    var MG = ((FindElem("RGPTIPO_INPUT_2").checked)? "S" : "N"); ');
    Add('    executeAjaxEvent("&' + PAR_CODCAUS_CALLBACK + '=" + encodeURI(CodCausale) + "&' + PAR_MG_CALLBACK + '=" + MG,null,"' + CallBackNameCausaleChange + '",false,null,false); ');
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    Add('  } ');
    Add('  catch(err) { ');
    Add('    alert("Errore: " + err.message + "\n" + err.description); ');
    Add('  } ');
    Add('} ');
  end;
  Log('Traccia','GetCausaliDisponibili - fine');
end;

procedure TW010FRichiestaAssenze.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;
  //CSS per quantità oraria nel caso di richiesta straordinario mensile: può essere una quantità > 24 ore.
  if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and
     (not WR000DM.Responsabile) and
     (cmbCausaliDisponibili.Items.Count = 2) and
     (Copy(cmbCausaliDisponibili.Items[1],1,5) = TO_CSI_AUT_STR) then
  begin
    edtOre.Css:='input_hour_hhhhmm2 width5chr';
    edtOre.MaxLength:=7;
    edtDal.ReadOnly:=True;
    edtAl.ReadOnly:=True;
    lblPeriodoDalAl.Visible:=True;
    edtPeriodoDalAl.Visible:=True;
    if cmbCausaliDisponibili.Items.Count = 2 then
      cmbCausaliDisponibili.ItemIndex:=1;
  end;
end;

procedure TW010FRichiestaAssenze.VisualizzaDipendenteCorrente;
var
  FiltroAnag: String;
  //Q: TOracleQuery;
begin
  inherited;
  Log('Traccia','VisualizzaDipendenteCorrente - inizio');
  // salva parametri form
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  // apertura dataset delle richieste assenza
  WR000DM.selT265.Filtered:=True;
  WR000DM.selT265.Open;
  WR000DM.selT275.Filtered:=True;
  WR000DM.selT275.Open;
  with W010DM.selT050 do
  begin
    // determina filtri
    FiltroAnag:=IfThen(TuttiDipSelezionato,
                       WR000DM.FiltroRicerca,
                       'and T030.PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString);

    // forza richiamo per comportamento non standard
    CorrezionePeriodo;

    // impostazione variabili per filtro richieste
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG',FiltroAnag);
    SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    R013Open(W010DM.selT050);
  end;
  Log('Traccia','VisualizzaDipendenteCorrente: dataset aperto');

  // estrae i familiari per il dipendente corrente
  if not TuttiDipSelezionato then
    GetFamiliari;

  // pulizia campi
  if not edtPeriodoDalAl.Visible then
  begin
    edtDal.Text:='';
    edtAl.Text:='';
  end;
  edtOre.Text:='';
  edtAOre.Text:='';
  rgpTipo.ItemIndex:=0;
  //cmbCausaliDisponibili.ItemIndex:=0;
  cmbFamiliari.ItemIndex:=0;

  btnNascondiRiepilogoAsyncClick(nil,nil);

  (*Alberto 10/03/2015: Si lascia l'impostazione precedente
  chkNoteIns.Checked:=False;
  memNoteIns.Css:='invisibile';
  *)
  memNoteIns.Text:='';

  grdRichieste.medpCreaCDS;
  grdRichieste.medpEliminaColonne;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizz.','',nil);
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    if C018.UtilizzoAvviso then
      grdRichieste.medpAggiungiColonna('D_VISTI_PREC','Visti prec.','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiColonna('D_CARTELLINO','Cartellino','',nil);
    with WR000DM.selT265 do
    begin
      Filter:='(TIPOCUMULO <> ''H'') and (NO_SUPERO_COMPETENZE_WEB = ''N'')';
      ShowAvvertimenti:=RecordCount > 0;
      Filter:='';
    end;
    if ShowAvvertimenti then
      grdRichieste.medpAggiungiColonna('D_AVVERTIMENTI','Avvertimenti','',nil);
    grdRichieste.medpAggiungiColonna('ID','ID','',nil);
    if (trTutte in C018.TipoRichiesteSel) or
       (trAutorizzate in C018.TipoRichiesteSel) or
       (trNegate in C018.TipoRichiesteSel) or
       (trRevocate in C018.TipoRichiesteSel) then
      grdRichieste.medpAggiungiColonna('D_ELABORATO','Elab.','',nil);
    grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
    if (C018.EsisteAutorizzIntermedia) or
       (C018.Revocabile) then
      grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('DAL','Dal','',nil);
    grdRichieste.medpAggiungiColonna('AL','Al','',nil);
    grdRichieste.medpAggiungiColonna('D_CAUSALE_2','Causale','',nil);
    grdRichieste.medpAggiungiColonna('TIPOGIUST','Tipo','',nil);
    grdRichieste.medpAggiungiColonna('D_TIPOGIUST','Tipo','',nil);
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    grdRichieste.medpAggiungiColonna('D_CSI_TIPO_MG','Mezza gg.','',nil);
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    grdRichieste.medpAggiungiColonna('NUMEROORE','Ore','',nil);
    grdRichieste.medpAggiungiColonna('AORE','Ore','',nil);
    grdRichieste.medpAggiungiColonna('D_DAORE_AORE','Ore','',nil);
    if C018.EsisteAutorizzIntermedia then
      grdRichieste.medpAggiungiColonna('D_DAORE_AORE_PREV','Ore prev.','',nil);
    grdRichieste.medpAggiungiColonna('DATANAS','Familiare','',nil);
    grdRichieste.medpColonna('ID').Visible:=False;
    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('TIPOGIUST').Visible:=False;
    grdRichieste.medpColonna('NUMEROORE').Visible:=False;
    grdRichieste.medpColonna('AORE').Visible:=False;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    grdRichieste.medpColonna('D_CSI_TIPO_MG').Visible:=GestioneTipoMezzaGiornata;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  end
  else
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('ID','ID','',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
    if (C018.EsisteAutorizzIntermedia) or
       (C018.Revocabile) then
      grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('DAL','Dal','',nil);
    grdRichieste.medpAggiungiColonna('AL','Al','',nil);
    grdRichieste.medpAggiungiColonna('D_CAUSALE_2','Causale','',nil);
    grdRichieste.medpAggiungiColonna('TIPOGIUST','Tipo','',nil);
    grdRichieste.medpAggiungiColonna('D_TIPOGIUST','Tipo','',nil);
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    grdRichieste.medpAggiungiColonna('D_CSI_TIPO_MG','Mezza gg.','',nil);
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    grdRichieste.medpAggiungiColonna('NUMEROORE','Ore','',nil);
    grdRichieste.medpAggiungiColonna('AORE','Ore','',nil);
    grdRichieste.medpAggiungiColonna('D_DAORE_AORE','Ore','',nil);
    if (C018.EsisteAutorizzIntermedia) and
       (C018.TipoRichiesteSel <> [trDaDefinire]) then
      grdRichieste.medpAggiungiColonna('D_DAORE_AORE_PREV','Ore prev.','',nil);
    grdRichieste.medpAggiungiColonna('DATANAS','Familiare','',nil);
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Aut.','',nil);
    if (trTutte in C018.TipoRichiesteSel) or
       (trAutorizzate in C018.TipoRichiesteSel) or
       (trNegate in C018.TipoRichiesteSel) or
       (trRevocate in C018.TipoRichiesteSel) then
      grdRichieste.medpAggiungiColonna('D_ELABORATO','Elab.','',nil);
    grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiColonna('D_CARTELLINO','Cartellino','',nil);
    grdRichieste.medpColonna('ID').Visible:=False;
    grdRichieste.medpColonna('TIPOGIUST').Visible:=False;
    grdRichieste.medpColonna('NUMEROORE').Visible:=False;
    grdRichieste.medpColonna('AORE').Visible:=False;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    grdRichieste.medpColonna('D_CSI_TIPO_MG').Visible:=GestioneTipoMezzaGiornata;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  end;
  grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdRichieste.medpInizializzaCompGriglia;
  if WR000DM.Responsabile then
  begin
    // autorizzazione
    if not SolaLettura then
    begin
      if C018.TipoRichiesteSel <> [trDaDefinire] then
      begin
        grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_CHK,'','Si','','');
        grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_CHK,'','No','','');
      end;
      grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','STAMPA','null','','',False);
    end;
    // visti precedenti
    if C018.UtilizzoAvviso then
      grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('D_VISTI_PREC'),0,DBG_LBL,'','','','','',False);
    // supero competenze
    if ShowAvvertimenti then
      grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('D_AVVERTIMENTI'),0,DBG_LBL,'','','','','',False);
    // icona stampa
    grdRichieste.medpColonna('DBG_COMANDI').Visible:=(trAutorizzate in C018.TipoRichiesteSel);// and (not SolaLettura);
    if C018.TipoRichiesteSel <= [trAutorizzate,trNegate,trRevocate,trTutte] then
      grdRichieste.medpColonna('D_ELABORATO').Visible:=(C018.TipoRichiesteSel <= [trAutorizzate,trNegate,trRevocate,trTutte]) and (not SolaLettura);
  end
  else
  begin
    // richiesta
    if not SolaLettura then
    begin
      // cancellazione + definizione e revoca richieste
      if C018.EsisteAutorizzIntermedia then
      begin
        grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la richiesta',A000TraduzioneStringhe(A000MSG_W010_MSG_CONFERMA_CANC),'S');
        grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','DEFINISCI','null','','S');
        grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','REVOCA','Revoca la richiesta',A000TraduzioneStringhe(A000MSG_W010_MSG_CONFERMA_REVOCA),'S');
        grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CANCPERIODO','Cancella periodo','','D');
        grdRichieste.medpPreparaComponenteGenerico('R',0,4,DBG_IMG,'','ANNULLA','Annulla la definizione della richiesta','','S');
        grdRichieste.medpPreparaComponenteGenerico('R',0,5,DBG_IMG,'','CONFERMA','Rende definitiva la richiesta',A000TraduzioneStringhe(A000MSG_W010_MSG_RICHIESTA_DEFINITIVA),'D');
      end
      else
      begin
        grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la richiesta',A000TraduzioneStringhe(A000MSG_W010_MSG_CONFERMA_CANC));
        grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','REVOCA','Revoca la richiesta',A000TraduzioneStringhe(A000MSG_W010_MSG_CONFERMA_REVOCA),'S');
        grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','CANCPERIODO','Cancella periodo','','D');
      end;
    end;
    grdRichieste.medpColonna('DBG_COMANDI').Visible:=Length(grdRichieste.medpDescCompGriglia.Riga[0]) > 0;
  end;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
  //cartellino
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('D_CARTELLINO'),0,DBG_IMG,'','DETTAGLIO','','','C');
  grdRichieste.medpCaricaCDS;

  //Carico i valori ricevuti evitando il DBClick
  if (Dal <> Parametri.DataLavoro) and
     (Al <> Parametri.DataLavoro) then
  begin
    edtDal.Text:=DateToStr(Dal);
    edtAl.Text:=DateToStr(Al);
  end;
  //edtRiepAl.Text:=DateToStr(ParametriForm.Al);

  if (ParametriForm.Causale <> '') and (ListaCausali.IndexOf(ParametriForm.Causale) > 0) then
    cmbCausaliDisponibili.ItemIndex:=ListaCausali.IndexOf(ParametriForm.Causale);

  //Reset Valori
  Dal:=Parametri.DataLavoro;
  Al:=Parametri.DataLavoro;
  ParametriForm.Dal:=Parametri.DataLavoro;
  ParametriForm.Al:=Parametri.DataLavoro;
  ParametriForm.Causale:='';

  AutorizzazioniDaConfermare:=False;

  Log('Traccia','VisualizzaDipendenteCorrente - fine');
end;

procedure TW010FRichiestaAssenze.GetFamiliari;
var
  Codice, Descrizione, FiltroCausAbil: String;
begin
  Log('Traccia','GetFamiliari - inizio');
  cmbFamiliari.ItemsHaveValues:=True;
  cmbFamiliari.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  cmbFamiliari.Items.Clear;
  ListaFamiliari.Clear;
  cmbFamiliari.Items.Add(NAME_VALUE_SEPARATOR);
  ListaFamiliari.Add(NAME_VALUE_SEPARATOR);

  // filtra i dataset dei familiari escludendo quelli senza causali abilitate
  FiltroCausAbil:='and    CAUSALI_ABILITATE is not null';

  with WR000DM do
  begin
    R180SetVariable(selSG101,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selSG101,'FILTRO',FiltroCausAbil);
    selSG101.Open;
    selSG101.First;
    while not selSG101.Eof do
    begin
      Codice:=IntToStr(selSG101.FieldByName('NUMORD').AsInteger);
      Descrizione:='(' + selSG101.FieldByName('GRADOPAR').AsString + ') ' +
                   FormatDateTime('dd/mm/yyyy hh.mm',selSG101.FieldByName('DATA').AsDateTime) +
                   ' ' + selSG101.FieldByName('NOME').AsString;
      cmbFamiliari.Items.Values[Descrizione]:=Codice;
      ListaFamiliari.Values[selSG101.FieldByName('DATA').AsString]:=Codice;
      selSG101.Next;
    end;

    // dataset familiari per abil. causali
    R180SetVariable(selSG101Causali,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selSG101Causali,'FILTRO',FiltroCausAbil);
    selSG101Causali.Open;
    selSG101Causali.First;
  end;
  Log('Traccia','GetFamiliari - fine');
end;

procedure TW010FRichiestaAssenze.imgCancellaClick(Sender: TObject);
var
  FN,Messaggio,TipoRichOrig: String;
  IdRichAnnullata: Integer;
  //D: TDateTime;
begin
  Log('Traccia','imgCancellaClick - inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  Messaggio:='';
  IdRichAnnullata:=0;
  with W010DM.selT050 do
  begin
    // verifica presenza richiesta
    Refresh;
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_DISPONIBILE),ESCLAMA);
      Exit;
    end;

    // COMO_HSANNA - commessa 2013/012
    // serve per sucessiva valutazione
    RecordRichiesta.Assenza:=VarToStr(WR000DM.selT265.Lookup('Codice',C,'Codice')) = C;

    DBGridColumnClick(Sender,FN);
    // se richiesta definitiva derivante da preventiva -> riporta in stato preventivo
    TipoRichOrig:=FieldByName('TIPO_RICHIESTA').AsString;
    if (FieldByName('TIPO_RICHIESTA').AsString = 'D') and
       (FieldByName('AUTORIZZ_PREV').AsString = 'S') and
       (*C018Begin - Se non è autorizzazione automatica vuol dire che c'è stata una autorizzazione intermedia*)
       (FieldByName('AUTORIZZ_AUTOM_PREV').AsString <> 'S')
       (*C018End*)
    then
    begin
      Log('Traccia','imgCancellaClick: impostazione stato richiesta preventiva');
      // modifica il tipo della richiesta da "Definitiva" a "Preventiva"
      RefreshRecord;
      Edit;
      FieldByName('NUMEROORE').AsString:=FieldByName('NUMEROORE_PREV').AsString;
      FieldByName('AORE').AsString:=FieldByName('AORE_PREV').AsString;
      FieldByName('NUMEROORE_PREV').Value:=null;
      FieldByName('AORE_PREV').Value:=null;
      Post;
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      C018.SetTipoRichiesta('P');
      C018.SetStato(C018.ValAutIntermedia,C018.LivAutIntermedia);
      SessioneOracle.Commit;
      C018.MailAnnullamentoPerAutorizzatore;
      // aggiornamento record
      RefreshOptions:=[roAllFields];//Serve per aggiornare i campi in join con la T050
      RefreshRecord;
      RefreshOptions:=[];//Si annullano le opzioni di refresh perchè danno problemi col RefreshRecord usato nella Delete
      Messaggio:=A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_ANNULLATA);
      IdRichAnnullata:=FieldByName('ID').AsInteger;
    end
    else
    begin
      // cancellazione della richiesta

      // elimina la richiesta
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      C018.EliminaIter;
      SessioneOracle.Commit;
      Log('Traccia','imgCancellaClick: richiesta eliminata');
    end;
  end;

  // aggiorna visualizzazione
  if Messaggio <> '' then
    C018.IncludiTipoRichieste(trDaDefinire);
  VisualizzaDipendenteCorrente;

  // posizionamento su riga appena inserita
  if IdRichAnnullata > 0 then
    DBGridColumnClick(nil,IntToStr(IdRichAnnullata));
  if Messaggio <> '' then
    MsgBox.MessageBox(Messaggio,INFORMA);
  Log('Traccia','imgCancellaClick - fine');
end;

// empoli - commessa 2012/102.ini
procedure TW010FRichiestaAssenze.imgRevocaClick(Sender: TObject);
var
  FN: String;
begin
  Log('Traccia','imgRevocaClick - inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);
  with W010DM.selT050 do
  begin
    // verifica presenza richiesta
    Refresh;
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_DISPONIBILE2),ESCLAMA);
      Exit;
    end;
  end;
  actInsRevoca('R',W010DM.selT050.FieldByName('DAL').AsDateTime,W010DM.selT050.FieldByName('AL').AsDateTime);
end;

procedure TW010FRichiestaAssenze.actInsRevoca(const PTipoRichiesta: String;
  const PDal, PAl: TDateTime);
// inserisce una richiesta di revoca oppure di cancellazione periodo
// PTipoRichiesta:
//   'R' -> revoca
//   'C' -> cancellazione periodo
// FN:
//   rowid del record della richiesta da rettificare
// PDal e PAl: periodo di revoca
//   'R' -> sono uguali al periodo originale
//   'C' -> sono quelli inseriti dall'utente, interni al periodo originale
var
  DataNasOrig, MeseBlocco: TDateTime;
  TipoRichOrig,CausOrig,TGOrig,NumOreOrig,AOreOrig,
  NumOrePrevOrig,AOrePrevOrig: String;
begin
  with W010DM.selT050 do
  begin
    // verifica blocco dati
    WR000DM.selDatiBloccati.Close;
    MeseBlocco:=WR000DM.selDatiBloccati.MeseBloccoRiepiloghi(FieldByName('DAL').AsDateTime);
    while MeseBlocco <= WR000DM.selDatiBloccati.MeseBloccoRiepiloghi(FieldByName('AL').AsDateTime) do
    begin
      if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,MeseBlocco,'T040') then
      begin
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_INS_REVOC_ANNULLATO),ESCLAMA);
        Exit;
      end;
      MeseBlocco:=R180AddMesi(MeseBlocco,1);
    end;

    // salva i dati in variabili di appoggio
    RecordRichiesta.TipoRichiesta:=PTipoRichiesta;
    RecordRichiesta.IdRevocato:=FieldByName('ID').AsInteger;
    TipoRichOrig:=FieldByName('TIPO_RICHIESTA').AsString;
    CausOrig:=FieldByName('CAUSALE').AsString;
    TGOrig:=FieldByName('TIPOGIUST').AsString;
    NumOreOrig:=FieldByName('NUMEROORE').AsString;
    AOreOrig:=FieldByName('AORE').AsString;
    NumOrePrevOrig:=FieldByName('NUMEROORE_PREV').AsString;
    AOrePrevOrig:=FieldByName('AORE_PREV').AsString;
    if FieldByName('DATANAS').IsNull then
      DataNasOrig:=0
    else
      DataNasOrig:=FieldByName('DATANAS').AsDateTime;

    // inserisce la richiesta di revoca
    Append;
    FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    FieldByName('DAL').AsDateTime:=PDal;
    FieldByName('AL').AsDateTime:=PAl;
    FieldByName('CAUSALE').AsString:=CausOrig;
    FieldByName('TIPOGIUST').AsString:=TGOrig;
    FieldByName('NUMEROORE').AsString:=NumOreOrig;
    FieldByName('AORE').AsString:=AOreOrig;
    FieldByName('NUMEROORE_PREV').AsString:=NumOrePrevOrig;
    FieldByName('AORE_PREV').AsString:=AOrePrevOrig;
    if DataNasOrig = 0 then
      FieldByName('DATANAS').Value:=null
    else
      FieldByName('DATANAS').AsDateTime:=DataNasOrig;
  end;

  // MONDOEDP - commessa MAN/07 SVILUPPO#62.ini
  // imposta le note per valutazione condizioni validità
  C018.Note:=Trim(memNoteIns.Text);
  // MONDOEDP - commessa MAN/07 SVILUPPO#62.fine

  if not C018.WarningRichiesta(PTipoRichiesta) then
    Messaggio('Conferma',Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_C018_CONTINUA),[C018.MessaggioOperazione]),ConfermaInsRichiesta,AnnullaInsRichiesta)
  else
    ConfermaInsRichiesta;
end;

procedure TW010FRichiestaAssenze.imgCancPeriodoClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if not W010DM.selT050.SearchRecord('ROWID',FN,[srFromBeginning]) then
    Exit;
  DBGridColumnClick(Sender,FN);

  // crea frame per conferma annullamento
  if Assigned(W010CancPeriodoFM) then
    FreeAndNil(W010CancPeriodoFM);
  W010CancPeriodoFM:=TW010FCancPeriodoFM.Create(Self);
  FreeNotification(W010CancPeriodoFM);
  W010CancPeriodoFM.W010DM:=W010DM;
  W010CancPeriodoFM.C018:=C018;
  W010CancPeriodoFM.IdOrig:=W010DM.selT050.FieldByName('ID').AsInteger;
  W010CancPeriodoFM.Visualizza;
end;
// empoli - commessa 2012/102.fine

procedure TW010FRichiestaAssenze.TrasformaComponenti(const FN:String; DaTestoAControlli:Boolean);
// Trasforma i componenti della riga indicata da text a control e viceversa
// per la tabella delle assenze
var
  i,idxOre: Integer;
  TipoGiust: String;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  with (grdRichieste.medpCompgriglia[i].CompColonne[0] as TmeIWGrid) do
  begin
    // icone di azione
    Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
    Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
    Cell[0,2].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
    Cell[0,3].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
    // annulla e conferma
    Cell[0,4].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
    Cell[0,5].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
  end;

  if DaTestoAControlli then
  begin
    // numero ore / da ore - a ore
    idxOre:=grdRichieste.medpIndexColonna('D_DAORE_AORE');
    TipoGiust:=grdRichieste.medpValoreColonna(i,'TIPOGIUST');
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
    if TipoGiust = 'D' then
    begin
      grdRichieste.medpPreparaComponenteGenerico('C',0,1,DBG_LBL,'','','','','S');
      grdRichieste.medpPreparaComponenteGenerico('C',0,2,DBG_EDT,'ORA2','','','','S');
    end;
    grdRichieste.medpCreaComponenteGenerico(i,idxOre,grdRichieste.Componenti);

    (grdRichieste.medpCompCella(i,idxOre,0) as TmeIWEdit).Text:=grdRichieste.medpValoreColonna(i,'NUMEROORE');
    if TipoGiust = 'D' then
    begin
      (grdRichieste.medpCompCella(i,idxOre,1) as TmeIWLabel).Caption:='-';
      (grdRichieste.medpCompCella(i,idxOre,2) as TmeIWEdit).Text:=grdRichieste.medpValoreColonna(i,'AORE');
    end;
  end
  else
  begin
    idxOre:=grdRichieste.medpIndexColonna('D_DAORE_AORE');
    FreeAndNil(grdRichieste.medpCompgriglia[i].CompColonne[idxOre]);
  end;
end;

procedure TW010FRichiestaAssenze.imgDefinisciClick(Sender: TObject);
// Definizione della richiesta preventiva
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if RecordRichiesta.Operazione = 'D' then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_ANNULLA_OPERAZIONE),INFORMA);
    Exit;
  end;

  DBGridColumnClick(Sender,FN);

  RecordRichiesta.TipoRichiesta:='';
  RecordRichiesta.Operazione:='D';
  RecordRichiesta.IdRevocato:=-1;
  grdRichieste.medpBrowse:=False;
  TrasformaComponenti(FN,True);
end;

procedure TW010FRichiestaAssenze.imgAnnullaClick(Sender: TObject);
begin
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

procedure TW010FRichiestaAssenze.imgConfermaDefClick(Sender: TObject);
var
  FN: String;
  i, c: Integer;
begin
  // effettua controlli bloccanti
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  // verifica presenza record
  if not W010DM.selT050.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_DISPONIBILE3),ESCLAMA);
    Exit;
  end;

  DBGridColumnClick(Sender,FN);

  // imposta variabili per inserimento / aggiornamento
  c:=grdRichieste.medpIndexColonna('D_DAORE_AORE');
  RecordRichiesta.NumeroOre:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit).Text;
  if grdRichieste.medpValoreColonna(i,'TIPOGIUST') = 'D' then
    RecordRichiesta.AOre:=(grdRichieste.medpCompCella(i,c,2) as TmeIWEdit).Text;

  // definizione richiesta
  btnInserisciClick(nil);
end;

procedure TW010FRichiestaAssenze.imgDettaglioClick(Sender: TObject);
var idx: Integer;
begin
  idx:=StrToInt((Sender as TmeIWImageFile).FriendlyName);
  W010CalcoloCompetenzeFM:=TW010FCalcoloCompetenzeFM.Create(Self);
  FreeNotification(W010CalcoloCompetenzeFM);
  with W010CalcoloCompetenzeFM do
  begin
    TipoCumulo:=R600DtM.TipoCumulo; // AOSTA_REGIONE - commessa 2012/152
    lblProfiloAssenzeVal.Caption:=R600DtM.RiepilogoAssenze[idx].ProfiloAssenze;
    lblPeriodoCumuloVal.Caption:=R600DtM.RiepilogoAssenze[idx].PeriodoCumulo;
    lblCompLordeACVal.Caption:=R600DtM.RiepilogoAssenze[idx].CompLordeAC;
    lblVarPeriodiRapportoVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarPeriodiRapporto;
    lblAbbattiAssCessVal.Caption:=R600DtM.RiepilogoAssenze[idx].AbbattiAssCess;
    lblDecurtazNonMaturaVal.Caption:=R600DtM.RiepilogoAssenze[idx].DecurtazNonMatura;
    lblVarPartTimeVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarPartTime;
    lblVarAbilitazioneAnagraficaVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarAbilitazioneAnagrafica;
    // AOSTA_REGIONE - commessa 2012/152.ini
    lblVarFruizMMInteriVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarFruizMMInteri;
    lblVarMaxIndividualeVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarMaxIndividuale;
    lblVarFruizMMContinuativiVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarFruizMMContinuativi;
    // AOSTA_REGIONE - commessa 2012/152.fine
    lblVarCompManualeVal.Caption:=R600DtM.RiepilogoAssenze[idx].VarCompManuale;
    lblCompNetteACVal.Caption:=R600DtM.RiepilogoAssenze[idx].CompNetteAC;
    memPartTimeVal.Lines.Text:=R600DtM.RiepilogoAssenze[idx].PartTime;
    lblFruizMinimaAC.Caption:=R600DtM.RiepilogoAssenze[idx].TitoloFruizMinimaAC;
    lblFruizMinimaACVal.Caption:=R600DtM.RiepilogoAssenze[idx].FruizMinimaAC;
    Visualizza;
  end;
end;

procedure TW010FRichiestaAssenze.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  with W010DM.selT050 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_DISPONIBILE4),ESCLAMA);
      Exit;
    end;
  end;
  VisualizzaDettagli(Sender);
end;

// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
procedure TW010FRichiestaAssenze.imgAllegClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  with W010DM.selT050 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_DISPONIBILE4),ESCLAMA);
      Exit;
    end;
  end;
  VisualizzaAllegati(Sender);
end;
// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

procedure TW010FRichiestaAssenze.RichiestaDaDefInConteggi(const RigaId: String; Includi: Boolean);
// Permette di escludere la richiesta preventiva in fase di definizione
// dai conteggi, impostando un tipo richiesta fittizio.
// In caso di errore nei conteggi deve essere ripristinata, mi raccomando!
begin
  with W010DM do
  begin
    // verifica presenza record
    if not selT050.SearchRecord('ROWID',RigaId,[srFromBeginning]) then
    begin
      Log('Errore','Richiesta da definire non più disponibile');
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_DISPONIBILE3),ESCLAMA);
      Exit;
    end;

    // modifica tipo richiesta
    C018.Id:=selT050.FieldByName('ID').AsInteger;
    C018.SetTipoRichiesta(IfThen(Includi,'P','X'));
    SessioneOracle.Commit;

    // aggiorna il record del dataset
    selT050.RefreshOptions:=[roAllFields];//Serve per aggiornare i campi in join con la T050
    selT050.RefreshRecord;
    selT050.RefreshOptions:=[];//Si annullano le opzioni di refresh perchè danno problemi col RefreshRecord usato nella Delete
  end;
end;

procedure TW010FRichiestaAssenze.btnImportaClick(Sender: TObject);
var
  Errore,Msg,ElencoRichieste,CampoIdRel,IdRich: String;
  NumScartate,ContaElementi,NumRichieste: Integer;
  Ok,AvvisoRiesegui: Boolean;
begin
  AutorizzazioniDaConfermare:=False;

  // determina l'elenco delle richieste attualmente presenti nel dataset
  W010DM.selT050.Refresh; // aggiorna elenco richieste
  if W010DM.selT050.RecordCount = 0 then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_NESSUNA_RICHIESTA_DA_IMPORTARE),INFORMA);
    Exit;
  end;

  {
   /* richiesta definitiva o revoca o cancellazione con autorizzazione impostata */
   (t850.tipo_richiesta in ('D','R','C') and t850.stato in ('S','N')) or
   /* qualsiasi richiesta con revoca / cancellazione autorizzata */
   (t850r.stato = 'S') or
   /* richiesta preventiva negata */
   (t850.tipo_richiesta = 'P' and t850.stato = 'N')
  }

  with W010DM.selT050 do
  begin
    ElencoRichieste:='';
    ContaElementi:=0;
    AvvisoRiesegui:=RecordCount > ORACLE_MAX_IN_VALUES;
    First;
    while not Eof do
    begin
      // ogni record può aggiungere all'elenco "IN" fino a due richieste
      // pertanto se il conteggio arriva a MAX - 1 interrompe il ciclo
      if ContaElementi + 1 >= ORACLE_MAX_IN_VALUES then
        Break;

      // aggiunge l'id della richiesta attuale all'elenco delle richieste da considerare
      IdRich:=FieldByName('ID').AsString;
      if R180CercaParolaIntera(IdRich,ElencoRichieste,',') = 0 then
      begin
        inc(ContaElementi);
        ElencoRichieste:=ElencoRichieste + IdRich + ',';
      end;

      // SGIULIANOMILANESE_COMUNE - chiamata <80446>.ini
      // include anche la relativa revoca / richiesta, indipendentemente dallo stato
      // di autorizzazione, al fine di elaborare correttamente le richieste revocate
      // la query del dataset A004MW.selT050 si occuperà poi di filtrare in modo corretto
      // le sole richieste realmente da elaborare
      CampoIdRel:=IfThen(FieldByName('TIPO_RICHIESTA').AsString = 'R','ID_REVOCATO','ID_REVOCA');
      if not FieldByName(CampoIdRel).IsNull then
      begin
        IdRich:=FieldByName(CampoIdRel).AsString;
        if R180CercaParolaIntera(IdRich,ElencoRichieste,',') = 0 then
        begin
          ElencoRichieste:=ElencoRichieste + IdRich + ',';
          inc(ContaElementi);
        end;
      end;
      // SGIULIANOMILANESE_COMUNE - chiamata <80446>.fine

      Next;
    end;
  end;
  ElencoRichieste:=Copy(ElencoRichieste,1,Length(ElencoRichieste) - 1);

  // sfrutta il dataset della A004, impostando un C700SelAnagrafe fittizio
  // e filtrando le richieste solo per ID
  // commessa MAN/02 - SVILUPPO 90.ini
  // nota: il dataset viene ora filtrato in base al proprio filtro dizionario
  //       questa modifica non dovrebbe causare effetti collaterali per cui si mantiene
  //       il filtro del dataset
  // commessa MAN/02 - SVILUPPO 90.fine
  (*
  with A004MW.selT050 do
  begin
    Close;
    SetVariable('C700SELANAGRAFE','t030_anagrafico t030 where 1=1');
    SetVariable('FILTRO_RICHIESTE',Format('and t050.id in (%s)',[ElencoRichieste]));
    Open;
    if RecordCount = 0 then
    begin
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_NESSUNA_RICHIESTA_DA_IMPORTARE),INFORMA);
      Exit;
    end;
  end;
  Ok:=A004MW.AcquisizioneRichiesteWeb(False,False,Errore,NumScartate,True);
  *)
  Ok:=R600DtM.AcquisizioneRichiesteAuto(ElencoRichieste,Errore,NumScartate,NumRichieste);
  if NumRichieste = 0 then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_NESSUNA_RICHIESTA_DA_IMPORTARE),INFORMA);
    Exit;
  end;

  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  // messaggio di fine elaborazione
  if Ok then
  begin
    // elaborazione ok / warning
    if Errore = '' then
      Msg:=A000TraduzioneStringhe(A000MSG_MSG_ELAB_OK)
    else
      Msg:=Format(A000TraduzioneStringhe(A000MSG_MSG_ELAB_WARNING),[Errore]);

    if NumScartate > 0 then
      Msg:=Msg + CRLF + A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_GIA_IMPORTATE);
    MsgBox.AddMessage(Msg);
  end
  else
  begin
    // anomalie durante elaborazione
    MsgBox.AddMessage(A000TraduzioneStringhe(A000MSG_MSG_ELAB_ERRORE) + CRLF +
                      A000TraduzioneStringhe(A000MSG_W010_MSG_CONSULTA_NOTIFICHE_ELAB));
  end;

  // richieste > del limite della in di oracle
  if AvvisoRiesegui then
    MsgBox.AddMessage(A000TraduzioneStringhe(A000MSG_W010_MSG_RIESEGUI_IMPORTAZIONE));

  MsgBox.ShowMessages;
end;

procedure TW010FRichiestaAssenze.btnInserisciClick(Sender: TObject);
var
  Trovato,FamPresente: Boolean;
  DaOre, AOre, i, j: Integer;
  CausInizio: String;
  MeseBlocco: TDateTime;
begin
  Log('Traccia','btnInserisciClick - inizio');
  AnomaliaAss:=0;
  RecordRichiesta.TipoRichiesta:='';
  if Sender = btnInserisci then
  begin
    RecordRichiesta.Operazione:='I';
    i:=0;
  end
  else
  begin
    RecordRichiesta.Operazione:='D';
    i:=grdRichieste.medpRigaDiCompGriglia(cdsT050.FieldByName('DBG_ROWID').AsString);
  end;
  RecordRichiesta.IdRevocato:=-1;
  Log('Traccia','btnInserisciClick: operazione = ' + RecordRichiesta.Operazione);

  WR000DM.selDatiBloccati.Close;

  // causale
  if RecordRichiesta.Operazione = 'I' then
  begin
    if cmbCausaliDisponibili.ItemIndex = 0 then
    begin
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_ERR_INS_GIUSTIF),INFORMA);
      cmbCausaliDisponibili.SetFocus;
      Exit;
    end;
    C:=Trim(Copy(StringReplace(cmbCausaliDisponibili.Text,SPAZIO,' ',[rfReplaceAll]),1,5));
  end
  else
  begin
    C:=Trim(Copy(StringReplace(grdRichieste.medpValoreColonna(i,'CAUSALE'),SPAZIO,' ',[rfReplaceAll]),1,5));
  end;
  Minuti:=0;
  AMinuti:=0;

  RecordRichiesta.Assenza:=VarToStr(WR000DM.selT265.Lookup('Codice',C,'Codice')) = C;

  // periodo dal - al
  if RecordRichiesta.Operazione = 'I' then
  begin
    if RecordRichiesta.Assenza or ((Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (C = TO_CSI_AUT_STR)) then
    begin
      try
        Dal:=StrToDate(edtDal.Text);
      except
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO),INFORMA);
        edtDal.SetFocus;
        Exit;
      end;
    end;
    try
      Al:=StrToDate(edtAl.Text);
      //Per le causali di presenza è possibile specificare solo un giorno, eccetto che per TORINO_CSI con la causale AUTST
      if (not RecordRichiesta.Assenza) and ((not Parametri.ModuloInstallato['TORINO_CSI_PRV']) or (C <> TO_CSI_AUT_STR)) then
        Dal:=Al;
    except
      MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W010_ERR_FMT_DATA_FINE),
                        [IfThen(RecordRichiesta.Assenza,A000TraduzioneStringhe(A000MSG_W010_ERR_FMT_DATA_FINE_OPT1),
                                                        A000TraduzioneStringhe(A000MSG_W010_ERR_FMT_DATA_FINE_OPT2))]),INFORMA);
      edtAl.SetFocus;
      Exit;
    end;
    if Al - Dal > 366 then
    begin
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_DATE_STESSO_ANNO),INFORMA);
      edtAl.SetFocus;
      Exit;
    end;
    if (Dal > Al) then
    begin
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_DATA_FINE_MAGG_INIZIO),INFORMA);
      edtDal.SetFocus;
      Exit;
    end;
  end
  else
  begin
    // periodo dal - al
    Dal:=StrToDate(grdRichieste.medpValoreColonna(i,'DAL'));
    Al:=StrToDate(grdRichieste.medpValoreColonna(i,'AL'));
  end;

  // imposta variabile Giustif
  Giustif.Inserimento:=True;
  if RecordRichiesta.Operazione = 'I' then
  begin
    case rgpTipo.ItemIndex of
      0: TG:='I';
      1: TG:='M';
      2: TG:='N';
      3: TG:='D';
    else
      begin
        Log('Errore','Inserimento richiesta: tipo giustificativo nullo! rgpTipo.ItemIndex = ' + IntToStr(rgpTipo.ItemIndex));
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_TIPO_FRUIZIONE),INFORMA);
        rgpTipo.SetFocus;
        Exit;
      end;
    end;
    RecordRichiesta.NumeroOre:=edtOre.Text;
    RecordRichiesta.AOre:=edtAOre.Text;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    RecordRichiesta.CSITipoMG:='';
    if GestioneTipoMezzaGiornata then
    begin
      if not rgpTipoMG.Css.Contains('nascosto') then
      begin
        case rgpTipoMG.ItemIndex of
          0: RecordRichiesta.CSITipoMG:='M';
          1: RecordRichiesta.CSITipoMG:='P';
        else
        end;
      end;
    end;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  end
  else
  begin
    TG:=grdRichieste.medpValoreColonna(i,'TIPOGIUST');
    if TG = '' then
    begin
      Log('Errore','Definizione richiesta: tipo giustificativo nullo! ID = ' + grdRichieste.medpValoreColonna(i,'ID'));
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_TIPO_FRUIZIONE2),INFORMA);
      rgpTipo.SetFocus;
      Exit;
    end;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    RecordRichiesta.CSITipoMG:=grdRichieste.medpValoreColonna(i,'CSI_TIPO_MG');
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  end;

  Giustif.DaOre:=IfThen(Trim(RecordRichiesta.NumeroOre) = '','.',RecordRichiesta.NumeroOre);
  Giustif.AOre:=IfThen(Trim(RecordRichiesta.AOre) = '','.',RecordRichiesta.AOre);
  Giustif.Modo:=R180CarattereDef(TG,1,#0);
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  Giustif.CSITipoMG:=RecordRichiesta.CSITipoMG;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  Giustif.Causale:=C;

  // controlli per giustificativo a ore
  if (TG = 'N') and (Trim(RecordRichiesta.NumeroOre) = '') then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_MSG_NUM_ORE_FRUIZIONE),INFORMA);
    if RecordRichiesta.Operazione = 'I' then
      edtOre.SetFocus;
    Exit;
  end;
  if (TG = 'D') and ((Trim(RecordRichiesta.NumeroOre) = '') or (Trim(RecordRichiesta.AOre) = '')) then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_MSG_DURATA_FRUIZIONE),INFORMA);
    if RecordRichiesta.Operazione = 'I' then
      edtAOre.SetFocus;
    Exit;
  end;

  // validità dati da ore - a ore
  if Trim(RecordRichiesta.NumeroOre) <> '' then
  begin
    try
      if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (C = TO_CSI_AUT_STR) then
        OreMinutiValidate(RecordRichiesta.NumeroOre)
      else
        R180OraValidate(RecordRichiesta.NumeroOre);
    except
      on E:Exception do
      begin
        MsgBox.MessageBox(E.Message,INFORMA);
        if RecordRichiesta.Operazione = 'I' then
          edtOre.SetFocus;
        Exit;
      end;
    end;
  end;
  if Trim(RecordRichiesta.AOre) <> '' then
  begin
    try
      R180OraValidate(RecordRichiesta.AOre);
    except
      on E:Exception do
      begin
        MsgBox.MessageBox(E.Message,INFORMA);
        if RecordRichiesta.Operazione = 'I' then
          edtAOre.SetFocus;
        Exit;
      end;
    end;
  end;

  // controlla periodo da ore - a ore
  DaOre:=R180OreMinutiExt(RecordRichiesta.NumeroOre);
  AOre:=R180OreMinutiExt(RecordRichiesta.AOre);

  // è consentito il periodo hh.mm - 00.00
  if (TG = 'D') and (DaOre > AOre) and (AOre <> 0) then
  begin
    MsgBox.MessageBox('L''ora finale deve essere successiva all''ora iniziale!',INFORMA);
    Exit;
  end;
  if TG <> 'I' then
    Minuti:=DaOre;
  if TG = 'D' then
    AMinuti:=AOre;
  if (TG = 'N') and (Minuti = 0) then
    Exit;
  if (TG = 'D') and (Minuti = AMinuti) and (AMinuti <> 0) then
    Exit;

  // verifica blocco dati
  //for j:=R180Mese(Dal) to R180Mese(Al) do
  MeseBlocco:=WR000DM.selDatiBloccati.MeseBloccoRiepiloghi(Dal);
  while MeseBlocco <= WR000DM.selDatiBloccati.MeseBloccoRiepiloghi(Al) do
  begin
    if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,MeseBlocco,'T040') then
    begin
      MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W010_MSG_INS_RICH_ANNULLATO),
                               [IfThen(RecordRichiesta.Operazione = 'I',
                                       A000TraduzioneStringhe(A000MSG_W010_MSG_INS_RICH_ANNULLATO_OPT1),
                                       A000TraduzioneStringhe(A000MSG_W010_MSG_INS_RICH_ANNULLATO_OPT2))]),INFORMA);
      Exit;
    end;
    MeseBlocco:=R180AddMesi(MeseBlocco,1);
  end;

  // controllo inizio catena.ini - TORINO_ASLTO2 - 2013/044 - INT_TECN 4
  // l'operazione di inserimento è consentita solo se la causale è a inizio catena
  if (RecordRichiesta.Operazione = 'I') and (RecordRichiesta.Assenza) then
  begin
    //CCNL 2018 - non lascio inserire un periodo di più giorni per i permessi per visite mediche, altrimenti non funziona bene il controllo sulle competenze alternative
    if (Dal <> Al) then
    begin
      if (R600DtM.GetValStrT230(C,'CAUSALI_CHECKCOMPETENZE',Dal) <> '') or
         (R600DtM.GetValStrT230(C,'CAUSALI_CHECKCOMPETENZE',Al) <> '') or
         (R600DtM.GetValStrT230(C,'CAUSALE_FRUIZORE',Dal) <> '') or
         (R600DtM.GetValStrT230(C,'CAUSALE_FRUIZORE',Al) <> '') or
         (R600DtM.GetValStrT230(C,'CAUSALE_HMASSENZA',Dal) <> '') or
         (R600DtM.GetValStrT230(C,'CAUSALE_HMASSENZA',Al) <> '')
      then
      begin
        //Segnalazione bloccante
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_A004_ERR_GGCONSECUTIVI),INFORMA);
        Exit;
      end;
    end;

    if (Parametri.CampiRiferimento.C23_InsNegCatena = 'S') and
       (not R600DtM.IsInizioCatenaCausAss(C,CausInizio)) then
    begin
      MsgBox.MessageBox(A000TraduzioneStringhe(Format(A000MSG_W010_MSG_FMT_RICH_INIZIOCATENA,[C,CausInizio])),INFORMA);
      Exit;
    end;
  end;
  // controllo inizio catena.fine

  // familiare di riferimento
  RecordRichiesta.NumOrdFam:=-1;
  if RecordRichiesta.Assenza then
    with WR000DM do
    begin
      selT265.SearchRecord('CODICE',C,[srFromBeginning]);
      if ((R180CarattereDef(selT265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D']) or
          (R180CarattereDef(selT265.FieldByName('FRUIZIONE_FAMILIARI').AsString,1,'N') in ['S','D'])) then
      begin
        if RecordRichiesta.Operazione = 'I' then
          FamPresente:=cmbFamiliari.ItemIndex > 0
        else
          FamPresente:=grdRichieste.medpValoreColonna(i,'DATANAS') <> '';
        if not FamPresente then
        begin
          MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_MSG_SPECIFIC_FAMILIARE_RIF),INFORMA);
          if RecordRichiesta.Operazione = 'I' then
            cmbFamiliari.SetFocus;
          Exit;
        end;

        // ciclo sulle decorrenze del familiare per verifica abilitazioni causale
        // all'inizio del periodo (bloccante)
        Trovato:=False;
        if RecordRichiesta.Operazione = 'I' then
          RecordRichiesta.NumOrdFam:=StrToInt(cmbFamiliari.Items.ValueFromIndex[cmbFamiliari.ItemIndex])
        else
          RecordRichiesta.NumOrdFam:=StrToInt(ListaFamiliari.ValueFromIndex[ListaFamiliari.IndexOfName(grdRichieste.medpValoreColonna(i,'DATANAS'))]);
        if selSG101Causali.SearchRecord('NUMORD',RecordRichiesta.NumOrdFam,[srFromBeginning]) then
        begin
          repeat
            if (Dal >= selSG101Causali.FieldByName('DECORRENZA').AsDateTime) and
               (Dal <= selSG101Causali.FieldByName('DECORRENZA_FINE').AsDateTime) then
            begin
              Trovato:=(Pos('<*>',selSG101Causali.FieldByName('CAUSALI_ABILITATE').AsString) > 0) or
                       (Pos('<' + C + '>',selSG101Causali.FieldByName('CAUSALI_ABILITATE').AsString) > 0);
              Break;
            end;
          until not selSG101Causali.SearchRecord('NUMORD',RecordRichiesta.NumOrdFam,[]);
        end;
        if not Trovato then
        begin
          MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_CAUS_FAMILIARE),[C]),INFORMA);
          if RecordRichiesta.Operazione = 'I' then
            cmbFamiliari.SetFocus;
          Exit;
        end;

        // posizionamento sul record del familiare
        selSG101.SearchRecord('NUMORD',RecordRichiesta.NumOrdFam,[srFromBeginning]);

        // ciclo sulle decorrenze del familiare per verifica abilitazioni causale
        // alla fine del periodo (non bloccante)
        if Al <> Dal then
        begin
          Trovato:=False;
          if selSG101Causali.SearchRecord('NUMORD',RecordRichiesta.NumOrdFam,[srFromBeginning]) then
          begin
            repeat
              if (Al >= selSG101Causali.FieldByName('DECORRENZA').AsDateTime) and
                 (Al <= selSG101Causali.FieldByName('DECORRENZA_FINE').AsDateTime) then
              begin
                Trovato:=(Pos('<*>',selSG101Causali.FielDByName('CAUSALI_ABILITATE').AsString) > 0) or
                         (Pos('<' + C + '>',selSG101Causali.FieldByName('CAUSALI_ABILITATE').AsString) > 0);
                Break;
              end;
            until not selSG101Causali.SearchRecord('NUMORD',RecordRichiesta.NumOrdFam,[]);
          end;

          if not Trovato then
          begin
            Messaggio('Conferma',Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_CAUS_FAMILIARE2),[C]),actIns0,nil);
            Exit;
          end;
        end;
      end;
    end;

  // fase successiva di controllo
  actIns0;
  Log('Traccia','btnInserisciClick - fine');
end;

procedure TW010FRichiestaAssenze.btnNascondiRiepilogoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  // 18/04/2019 - Bug IntraWEB 15.0.18:
  //con TemplateProcessor.RenderStyle = False, settare la proprietà Visible in Async non funziona
  //si usa il css "invisibile"
  grdRiepilogo.Visible:=False;
  grdRiepilogo.CSS:=grdRiepilogo.CSS + ' ' + 'invisibile';
  lblCausale.Caption:='';
  btnNascondiRiepilogo.Visible:=False;
  btnNascondiRiepilogo.CSS:=btnNascondiRiepilogo.CSS + ' ' + 'invisibile';
end;

procedure TW010FRichiestaAssenze.actIns0;
var
  FruizVincolata,FruizMin,arr,minimo,massimo:Integer;
  Msg:String;
begin
  Log('Traccia','actIns0');
  with WR000DM do
  begin
    if not RecordRichiesta.Assenza then
      selT275.SearchRecord('CODICE',C,[srFromBeginning]);
    // Controllo 'tipo giustificativo' con 'unità di misura inserimento' della causale di assenza / presenza
    // Nota: questo controllo è già fatto a monte via javascript, ma viene mantenuto per sicurezza
    if (TG = 'I') and
       (   not RecordRichiesta.Assenza
        or (selT265.FieldByName('UM_INSERIMENTO').AsString = 'N')) then
    begin
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_NO_INS_GG_INTERE));
      Exit;
    end;
    if (TG = 'M') and
       (   not RecordRichiesta.Assenza
        or (selT265.FieldByName('UM_INSERIMENTO_MG').AsString = 'N')) then
    begin
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_NO_INS_GG_MEZZE));
      Exit;
    end;
    if (TG = 'N') and
       (   (RecordRichiesta.Assenza and (selT265.FieldByName('UM_INSERIMENTO_H').AsString = 'N'))
        or (not RecordRichiesta.Assenza and (selT275.FieldByName('UM_INSERIMENTO_H').AsString = 'N'))) then
    begin
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_NO_INS_HH_NUMERO));
      Exit;
    end;
    if (TG = 'D') and
       (   (RecordRichiesta.Assenza and (selT265.FieldByName('UM_INSERIMENTO_D').AsString = 'N'))
        or (not RecordRichiesta.Assenza and (selT275.FieldByName('UM_INSERIMENTO_D').AsString = 'N'))) then
    begin
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_NO_INS_HH_DA_A));
      Exit;
    end;

    // in caso di definizione modifica la richiesta per escluderla dai controlli,
    // poiché verrebbe infatti considerata due volte
    // si tratta di un'operazione delicata ma necessaria per evitare l'ennesimo
    // ritocco sui dataset della unit R600
    if RecordRichiesta.Operazione = 'D' then
      RichiestaDaDefInConteggi(cdsT050.FieldByName('DBG_ROWID').AsString,False);

    if R600DtM = nil then
    begin
      try
        CreaR600;
      except
        on E: Exception do
        begin
          Log('Errore','actIns1;CreaR600;' + E.ClassName + '/' + E.Message);
          actCtrlRipristinoRich;
          Exit;
        end;
      end;
    end;

    if not RecordRichiesta.Assenza then
    begin
      // causale di presenza
      R600DtM.AnomaliaAssenze:=0;
      R600DtM.EsistonoAnomalieBloccanti:=False;
      R600DtM.Giustificativo:=Giustif;
      R600DtM.SettaInfo1(selAnagrafeW.FieldByName('COGNOME').AsString,selAnagrafeW.FieldByName('NOME').AsString,selAnagrafeW.FieldByName('MATRICOLA').AsString,C);
      R600DtM.CausalePresenzaAbilitata(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Al);
      if R600DtM.AnomaliaAssenze = 0 then
        R600DtM.IntersezioneGiustTimb(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Al,selT275.FieldByName('CAUSALIZZA_TIMB_INTERSECANTI').AsString <> 'S');

      arr:=R180OreMinuti(selT275.FieldByName('ARROT_RIEPGG').AsString);
      minimo:=selT275.FieldByName('MINMINUTI').AsInteger;
      massimo:=9999;
      if not selT275.FieldByName('MAXMINUTI').IsNull then
        massimo:=selT275.FieldByName('MAXMINUTI').AsInteger;
      if TG = 'D' then
        FruizVincolata:=IfThen(AMinuti = 0,1440,AMinuti) - Minuti
      else
        FruizVincolata:=Minuti;
      if FruizVincolata < minimo then
      begin
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_FRUIZ_INF_VINCOLI),INFORMA);
        if TG = 'N' then
          edtOre.Text:=R180MinutiOre(minimo)
        else
          edtAOre.Text:=R180MinutiOre(R180OreMinuti(edtOre.Text) + minimo);
        edtOre.SetFocus;
        Exit;
      end
      (*Non applicato per problemi con Aosta_Regione: il controllo viene comunque fatto dai conteggi
      else if FruizVincolata > massimo then
      begin
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_FRUIZ_SUP_VINCOLI),INFORMA);
        if TG = 'N' then
          edtOre.Text:=R180MinutiOre(massimo)
        else
          edtAOre.Text:=R180MinutiOre(R180OreMinuti(edtOre.Text) + massimo);
        edtOre.SetFocus;
        Exit;
      end
      *)
      else if FruizVincolata > Trunc(R180Arrotonda(FruizVincolata,arr,'D')) then
      begin
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_FRUIZ_ARR_VINCOLI),['(' + arr.ToString + ' min)']),INFORMA);
        if TG = 'N' then
          edtOre.Text:=R180MinutiOre(Trunc(R180Arrotonda(FruizVincolata,arr,'D')))
        else
          edtAOre.Text:=R180MinutiOre(R180OreMinuti(edtOre.Text) + Trunc(R180Arrotonda(FruizVincolata,arr,'D')));
        edtOre.SetFocus;
        Exit;
      end;

      // controlli terminati: ripristina il tipo richiesta se necessario
      actCtrlRipristinoRich;

      if R600DtM.AnomaliaAssenze <> 0 then
      begin
        Msg:=Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_INS_RICH_ANOMALIE),
                   [R600DtM.FormattaAnomaliaWeb(R600DtM.ListAnomalie,False) +
                    IfThen(R600DtM.EsistonoAnomalieBloccanti,
                    IfThen(RecordRichiesta.Operazione = 'I',
                    A000TraduzioneStringhe(A000MSG_W010_MSG_INS_RICH_ANOMALIE_OPT1),
                    A000TraduzioneStringhe(A000MSG_W010_MSG_INS_RICH_ANOMALIE_OPT2)),
                    A000TraduzioneStringhe(A000MSG_MSG_CONTINUA_ANOM))]);
        R600DtM.ListAnomalie.Clear;
        if R600DtM.EsistonoAnomalieBloccanti then
        begin
          // anomalie bloccanti -> termina comunque
          MsgBox.MessageBox(Msg,INFORMA);
        end
        else
        begin
          // richiesta di ignorare anomalia
          SaltaControlli:=True;
          if RecordRichiesta.Operazione = 'I' then
            Messaggio(A000TraduzioneStringhe(A000MSG_MSG_ANOMALIE_R600),Msg,actInsRichiesta,nil)
          else
            Messaggio(A000TraduzioneStringhe(A000MSG_MSG_ANOMALIE_R600),Msg,actDefRichiesta,nil);
        end;
        Exit;
      end;

      // ok: inserisce / definisce la richiesta
      if RecordRichiesta.Operazione = 'I' then
        actInsRichiesta
      else
        actDefRichiesta;
      Exit;
    end
    else
    begin
      // verifica vincoli sulla fruizione oraria
      if (TG = 'N') or (TG = 'D') then
      begin
        // arrotondamento, fruizione min / max
        try
          arr:=IfThen(selT265.FieldByName('FRUIZCOMPETENZE_ARR').AsString = 'N',selT265.FieldByName('FRUIZ_ARR').AsInteger,0);
          FruizMin:=IfThen(selT265.FieldByName('FRUIZCOMPETENZE_ARR').AsString = 'N',selT265.FieldByName('FRUIZ_MIN').AsInteger,0);
          if TG = 'N' then
          begin
            // num. ore
            FruizVincolata:=Minuti;
            if FruizVincolata > 0 then
            begin
              R600DtM.ControllaVincoliFruizione(Minuti,FruizMin,selT265.FieldByName('FRUIZ_MAX').AsInteger,arr,FruizVincolata);
              Minuti:=FruizVincolata;
            end
            else
              FruizVincolata:=1;
          end
          else
          begin
            // da ore - a ore
            R600DtM.ControllaVincoliFruizione(IfThen(AMinuti = 0,1440,AMinuti) - Minuti,FruizMin,selT265.FieldByName('FRUIZ_MAX').AsInteger,arr,FruizVincolata);
            if Minuti + FruizVincolata = 1440 then
              AMinuti:=0
            else
              AMinuti:=Minuti + FruizVincolata;
          end;
        except
          on E: Exception do
          begin
            actCtrlRipristinoRich;
            Log('Errore','actIns1;Controllo vincoli fruizione;' + E.ClassName + '/' + E.Message);
            Exit;
          end;
        end;

        if FruizVincolata = 0 then
        begin
          actCtrlRipristinoRich;
          MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_FRUIZ_INF_VINCOLI),INFORMA);
          if RecordRichiesta.Operazione = 'I' then
            edtOre.SetFocus;
          Exit;
        end;

        // fruizione < debito gg
        if selT265.FieldByName('FRUIZ_MAX_DEBITO').AsString = 'S' then
        begin
          try
            if TG = 'N' then
            begin
              // num. ore
              R600DtM.ControllaFruizMaxDebito(Dal,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Minuti,C,'N',R180MinutiOre(Minuti),R180MinutiOre(AMinuti),FruizVincolata);
              Minuti:=FruizVincolata;
            end
            else
            begin
              // da ore - a ore
              R600DtM.ControllaFruizMaxDebito(Dal,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,IfThen(AMinuti = 0,1440,AMinuti) - Minuti,C,'D',R180MinutiOre(Minuti),R180MinutiOre(AMinuti),FruizVincolata);
              if Minuti + FruizVincolata = 1440 then
                AMinuti:=0
              else
                AMinuti:=Minuti + FruizVincolata;
            end;
          except
            on E: Exception do
            begin
              actCtrlRipristinoRich;
              MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_CONTROLLI_INS),
                                [IfThen(RecordRichiesta.Operazione = 'I',
                                 A000TraduzioneStringhe(A000MSG_W010_ERR_CONTROLLI_INS_OPT1),
                                 A000TraduzioneStringhe(A000MSG_W010_ERR_CONTROLLI_INS_OPT2))]),ESCLAMA);
              Log('Errore','actIns1;Controllo fruizione max debito;' + E.ClassName + '/' + E.Message);
              Exit;
            end;
          end;

          if FruizVincolata = 0 then
          begin
            actCtrlRipristinoRich;
            MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_FRUIZ_ORA_MAG_VINCOLI),[DateToStr(Dal)]),INFORMA);
            if RecordRichiesta.Operazione = 'I' then
              edtOre.SetFocus;
            Exit;
          end;
        end;

        // applica eventuale arrotondamento
        RecordRichiesta.NumeroOre:=R180MinutiOre(Minuti);
        if RecordRichiesta.Operazione = 'I' then
          edtOre.Text:=RecordRichiesta.NumeroOre;
        if TG = 'D' then
        begin
          RecordRichiesta.AOre:=R180MinutiOre(AMinuti);
          if RecordRichiesta.Operazione = 'I' then
            edtAOre.Text:=RecordRichiesta.AOre;
        end;
      end;

      // decreto brunetta: segnalazione per giustificazione assenza
      SegnalazioneCertStruttPubblica:=
          (Al >= EncodeDate(2008,06,25)) and
          (not selT265.FieldByName('CODCAU3').IsNull) and
          (R600DtM.ServeCertificazionePubblica(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,C,Dal,Al));
      // decreto brunetta.fine

      // nel caso di familiare imposta la data di nascita di riferimento
      if RecordRichiesta.NumOrdFam < 0 then
        R600DtM.RiferimentoDataNascita.Data:=0
      else
        R600DtM.RiferimentoDataNascita.Data:=selSG101.FieldByName('DATA').AsDateTime;
    end; // => end with

    // calcolo periodo di fruizione, competenze e cumuli
    case R600DtM.SettaConteggi(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Dal,Al,Giustif) of
      mrAbort:
        begin
          actCtrlRipristinoRich;

          // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.ini
          // la function Anomalie non visualizza più un messaggio interattivo
          // pertanto occorre prevederlo qui (solo se VisualizzaAnomalie è True)
          Msg:=A000TraduzioneStringhe(A000MSG_A004_MSG_PRESENZA_ANOMALIE) + CRLF +
               R600DtM.FormattaAnomaliaWeb(R600DtM.ListAnomalie) +
               A000TraduzioneStringhe(A000MSG_A004_MSG_GG_STOP_INS);
          if R600DtM.VisualizzaAnomalie then
            MsgBox.MessageBox(Msg,ESCLAMA);
          // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.fine

          // annulla operazione: abort
          Abort;
        end;
    end;

    // estrae il totale competenze alla data iniziale del periodo
    TotCompetenze:=R600DtM.GetTotCompetenze;
    R600DtM.ListAnomalie.Clear;
    R600DtM.UltimaAnomalia:='';

    // inizializza variabili
    GiorniRichiesti:=Trunc(Al - Dal) + 1;
    GiorniIgnorati:=0;
    DataCorr:=Dal;

    // salva la causale di assenza originale in una variabile di appoggio
    CausaleSuccessiva:=False;
    CausaleOriginale:=C;

    // fase successiva di controlli
    SaltaControlli:=False;
    actIns1;
  end;
end;

procedure TW010FRichiestaAssenze.actIns1;
// Ciclo di controlli sul periodo di inserimento
var
  Msg,locTG,locEdtDa,locEdtA,locTGSucc,locEdtDaSucc,locEdtASucc: String;
  GiustifOriginale:TGiustificativo;
  Res: TModalResult;
begin
  Log('Traccia','actIns1');

  // esclude la richiesta dai conteggi
  if RecordRichiesta.Operazione = 'D' then
    RichiestaDaDefInConteggi(cdsT050.FieldByName('DBG_ROWID').AsString,False);

  GiustifOriginale:=Giustif;
  while DataCorr <= Al do
  begin
    if not SaltaControlli then
    begin
      if not CausaleSuccessiva then
      begin
        if C <> CausaleOriginale then
        begin
          Giustif.Causale:=CausaleOriginale;
          R600DtM.SettaConteggi(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,DataCorr,Al,Giustif);
        end;
        C:=CausaleOriginale;
        ElencoCausali:=C;
      end
      else
      begin
        CausaleSuccessiva:=False;
        Giustif.Causale:=C;
        R600DtM.SettaConteggi(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,DataCorr,Al,Giustif);
      end;

      // controllo se posso inserire il giustificativo in questa data
      Res:=R600DtM.ControlliGenerali(DataCorr);
      if R600DtM.AnomaliaAssenze = 20 then
        AnomaliaAss:=R600DtM.AnomaliaAssenze; // EMPOLI_ASL11: se esiste anomalia imposta flag su db
      case Res of
        mrIgnore:
          begin
            // anomalie non bloccanti
            if R600DtM.AnomaliaAssenze = 0 then
            begin
              // giorno ignorato
              //if R600DtM1.GGSignific and NumGiorni then  //Lorena 27/12/2005
              //  Al:=Al + 1;
              GiorniIgnorati:=GiorniIgnorati + 1;
              DataCorr:=DataCorr + 1;
              Continue;
            end
            else
            begin
              actCtrlRipristinoRich;
              Msg:=Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_INS_RICH_ANOMALIE),
                          [R600DtM.FormattaAnomaliaWeb(R600DtM.ListAnomalie,False) +
                           A000TraduzioneStringhe(A000MSG_MSG_CONTINUA_ANOM)]);
              R600DtM.ListAnomalie.Clear;
              if R600DtM.VisualizzaAnomalie then
              begin
                // richiesta di ignorare anomalia
                SaltaControlli:=True;
                Messaggio(A000TraduzioneStringhe(A000MSG_MSG_ANOMALIE_R600),Msg,actIns1,nil);
              end;
              Exit;
            end;
          end;
        mrAbort:
          begin
            // anomalie bloccanti
            if (R600DtM.AnomaliaAssenze = 20) and (not R600DtM.Q265.FieldByName('CAUSALE_SUCCESSIVA').IsNull) then
            begin
              // causali esaurite in fasce -> verifica se esiste causale successiva
              if Pos(',' + R600DtM.Q265.FieldByName('CAUSALE_SUCCESSIVA').AsString + ',',',' + ElencoCausali + ',') = 0 then
              begin
                // rimuove l'ultima anomalia dall'elenco
                if R600DtM.ListAnomalie.Count > 0 then
                  R600DtM.ListAnomalie.Delete(R600DtM.ListAnomalie.Count - 1);
                CausaleSuccessiva:=True;
                C:=R600DtM.Q265.FieldByName('CAUSALE_SUCCESSIVA').AsString;
                ElencoCausali:=ElencoCausali + ',' + C;
                AnomaliaAss:=0;
                //TORINO_CSI: catena banca ore RECOR->1110->1100: usato per controllare supero competenze in fase di richiesta
                //Solo se fruizione oraria su un gg singolo
                if (Dal = Al) and (GiustifOriginale.Modo in ['D','N']) then
                begin
                  locTG:=Giustif.Modo;
                  locEdtDa:=Giustif.DaOre;
                  locEdtA:=Giustif.AOre;
                  if R600DtM.SuddividiFruizione(locTG,locEdtDa,locEdtA,locTGSucc,locEdtDasucc,locEdtASucc) and (locTGSucc <> '') then
                  begin
                    //Se c'è residuo ma inferiore alla fruizione richiesta, si suddivide la fruizione
                    Giustif.Modo:=locTGSucc[1];
                    Giustif.DaOre:=locEdtDaSucc;
                    Giustif.AOre:=locEdtASucc;
                    R600DtM.Giustificativo.Modo:=Giustif.Modo;
                    R600DtM.Giustificativo.DaOre:=Giustif.DaOre;
                    R600DtM.Giustificativo.AOre:=Giustif.AOre;
                    if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and
                       (C = TO_CSI_REC_SETT) and
                       (R180OreMinutiExt(locEdtDaSucc) < R180OreMinutiExt(locEdtASucc)) then
                    begin
                      //Fruizione recupero settimanale: da ricordare per successivo inserimento segnalazione per autorizzatore
                      //solo dopo InsRichiesta (ConfermaInsRichiesta)-->C018.SetDatoAutorizzatore('<Recupero settimanale>','S',0);
                    end;
                  end;
                end;
                Continue;
              end
              else
              begin
                actCtrlRipristinoRich;
                Abort;
              end;
            end
            else
            begin
              actCtrlRipristinoRich;

              // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.ini
              // la function Anomalie non visualizza più un messaggio interattivo
              // pertanto occorre prevederlo qui (solo se VisualizzaAnomalie è True)
              Msg:=A000TraduzioneStringhe(A000MSG_A004_MSG_PRESENZA_ANOMALIE) + CRLF +
                   R600DtM.FormattaAnomaliaWeb(R600DtM.ListAnomalie) +
                   IfThen(RecordRichiesta.Operazione = 'I',
                          A000TraduzioneStringhe(A000MSG_W010_MSG_INS_RICH_ANOMALIE_OPT1),
                          A000TraduzioneStringhe(A000MSG_W010_MSG_INS_RICH_ANOMALIE_OPT2));
              R600DtM.ListAnomalie.Clear;
              if R600DtM.VisualizzaAnomalie then
                MsgBox.MessageBox(Msg,ESCLAMA,A000TraduzioneStringhe(A000MSG_MSG_ANOMALIE_R600));
              // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.fine

              // annulla operazione: abort
              Abort;
            end;
          end;
      end; // ==> end case
    end; // ==> end while

    SaltaControlli:=False;
    DataCorr:=DataCorr + 1;
  end;

  // fase successiva di controlli
  Giustif:=GiustifOriginale;
  C:=CausaleOriginale;
  actIns2;
end;

procedure TW010FRichiestaAssenze.actIns2;
// Seconda parte dei controlli di inserimento
begin
  Log('Traccia','actIns2');
  // verifica risultato operazione
  if (*(R600DtM.TipoCumulo <> 'H') and (R600DtM.UMisura = 'G') and *)
     (GiorniIgnorati > 0) then
  begin
    GiorniInseriti:=GiorniRichiesti - GiorniIgnorati;
    if GiorniInseriti = 0 then
    begin
      actCtrlRipristinoRich;
      // tutti i giorni richiesti sono stati ignorati
      MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_PERIODO_GIUST_ERRATO),[IfThen(RecordRichiesta.Operazione = 'I',
                               A000TraduzioneStringhe(A000MSG_W010_MSG_INS_RICH_ANNULLATO_OPT1),
                               A000TraduzioneStringhe(A000MSG_W010_MSG_INS_RICH_ANNULLATO_OPT1))]),INFORMA);
      Exit;
    end
  end;

  actCtrlRipristinoRich; // in caso di errori nella definizione, lo stato della richiesta rimarrebbe 'X' - daniloc. 09.08.2012

  // ok: inserisce / definisce la richiesta
  if RecordRichiesta.Operazione = 'I' then
    actInsRichiesta
  else
    actDefRichiesta;
end;

procedure TW010FRichiestaAssenze.actInsRichiesta;
// inserimento della richiesta
var
  GiustTipoChar: Char;
  RichiestaDuplicata: Boolean;
begin
  Log('Traccia','actInsRichiesta');
  GiustTipoChar:=R180CarattereDef(TG,1,#0);

  if not (Parametri.ModuloInstallato['TORINO_CSI_PRV'] and (TG = 'N')(*and (C = TO_CSI_AUT_STR)*)) then
  begin
    // controllo richiesta duplicata
    with TOracleQuery.Create(GGetWebApplicationThreadVar) do
    try
      Session:=SessioneOracle;
      SQL.Add('select count(*) ');
      SQL.Add('from   VT050_RICHIESTEASSENZA T050');
      SQL.Add('where  T050.PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
      SQL.Add('and    T050.TIPO_RICHIESTA <> ''R''');
      SQL.Add('and    T050.ELABORATO <> ''E''');
      SQL.Add('and    T050.DAL = to_date(''' + FormatDateTime('dd/mm/yyyy',Dal) + ''',''dd/mm/yyyy'')');
      SQL.Add('and    T050.AL = to_date(''' + FormatDateTime('dd/mm/yyyy',Al) + ''',''dd/mm/yyyy'')');
      SQL.Add('and    T050.TIPOGIUST = ''' + TG + '''');
      SQL.Add('and    T050.CAUSALE = ''' + C + '''');
      if ((GiustTipoChar = 'M') and (R180OreMinutiExt(RecordRichiesta.NumeroOre) > 0)) then
        //Permetto mezze giornate con ore diverse
        SQL.Add('and    T050.NUMEROORE = ''' + RecordRichiesta.NumeroOre + '''')
      else if GiustTipoChar = 'D' then
      begin
        //Permetto dalle..alle diverse
        SQL.Add('and    T050.NUMEROORE = ''' + RecordRichiesta.NumeroOre + '''');
        SQL.Add('and    T050.AORE = ''' + RecordRichiesta.AOre + '''');
      end
      else if GiustTipoChar = 'N' then
      begin
        //Permetto sempre numero ore, anche se uguali
        SQL.Add('and    T050.NUMEROORE is null');
      end;
      begin
        SQL.Add('and    (T050.ID_REVOCA is null or ');
        SQL.Add('        exists (select ''X'' from VT050_RICHIESTEASSENZA ');
        SQL.Add('                where  ID = T050.ID_REVOCA ');
        SQL.Add('                and    nvl(STATO,''N'') = ''N''))');
      end;
      try
        Execute;
        RichiestaDuplicata:=(FieldAsInteger(0) > 0);
        Close;
      except
        RichiestaDuplicata:=False;
      end;
    finally
      Free;
    end;
    if RichiestaDuplicata then
    begin
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W010_ERR_RICH_ESISTENTE));
      Exit;
    end;
  end;

  // inserimento richiesta
  with W010DM.selT050 do
  begin
    Append;
    FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    FieldByName('DAL').AsDateTime:=Dal;
    FieldByName('AL').AsDateTime:=Al;
    FieldByName('CAUSALE').AsString:=C;
    FieldByName('TIPOGIUST').AsString:=TG;
    if (GiustTipoChar in ['N','D']) or
       ((GiustTipoChar = 'M') and (R180OreMinutiExt(RecordRichiesta.NumeroOre) > 0)) then
      //FieldByName('NUMEROORE').AsString:=RecordRichiesta.NumeroOre;
      FieldByName('NUMEROORE').AsString:=R180MinutiOre(R180OreMinutiExt(RecordRichiesta.NumeroOre));
    if GiustTipoChar = 'D' then
      FieldByName('AORE').AsString:=RecordRichiesta.AOre; //edtAOre.Text;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    if GiustTipoChar = 'M' then
      FieldByName('CSI_TIPO_MG').AsString:=RecordRichiesta.CSITipoMG;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    // familiare di riferimento
    if RecordRichiesta.Assenza then
    begin
      WR000DM.selT265.SearchRecord('CODICE',C,[srFromBeginning]);
      if (RecordRichiesta.NumOrdFam > -1) and
         ((R180CarattereDef(WR000DM.selT265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D']) or
          (R180CarattereDef(WR000DM.selT265.FieldByName('FRUIZIONE_FAMILIARI').AsString,1,'N') in ['S','D'])) then
        FieldByName('DATANAS').AsDateTime:=WR000DM.selSG101.FieldByName('DATA').AsDateTime;
    end;
  end;

  // MONDOEDP - commessa MAN/07 SVILUPPO#62.ini
  // imposta le note per valutazione condizioni validità
  C018.Note:=Trim(memNoteIns.Text);
  // MONDOEDP - commessa MAN/07 SVILUPPO#62.fine

  if not C018.WarningRichiesta then
    Messaggio('Conferma',Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_C018_CONTINUA),[C018.MessaggioOperazione]),ConfermaInsRichiesta,AnnullaInsRichiesta)
  else
    ConfermaInsRichiesta;
end;

procedure TW010FRichiestaAssenze.ConfermaInsRichiesta;
var
  TipoRichiesta,ErrMsg: String;
  IdIns,NumScartate,NumRichieste:Integer;
  D: TDateTime;
begin
  with W010DM.selT050 do
  begin
    try
      // EMPOLI_ASL11 - commessa 2012/102.ini
      if RecordRichiesta.TipoRichiesta <> '' then
        TipoRichiesta:=RecordRichiesta.TipoRichiesta
      //if RecordRichiesta.IdRevocato > 0 then
      //  TipoRichiesta:='R'
      // EMPOLI_ASL11 - commessa 2012/102.fine
      //Alberto 18/09/2013: aggiunto controllo seguente su LivAutIntermedia per gestire la richiesta preventiva solo sulle strutture che la definiscono
      else if C018.EsisteAutorizzIntermedia and (C018.LivAutIntermedia > 0) then
        TipoRichiesta:='P,D'
      else
        TipoRichiesta:='D';
      if RecordRichiesta.IdRevocato > 0 then
        C018.InsRichiesta(TipoRichiesta,'',IntToStr(RecordRichiesta.IdRevocato))
      else
        C018.InsRichiesta(TipoRichiesta,IfThen(chkNoteIns.Checked,Trim(memNoteIns.Text),''),'');
      IdIns:=C018.Id;
      if C018.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end;
      // EMPOLI_ASL11.ini
      // segnala anomalia su dati modificati (T852)
      if AnomaliaAss <> 0 then
        C018.SetDatoAutorizzatore('SUPERO_COMPETENZE','S',0);
      // EMPOLI_ASL11.fine
    except
      on E: Exception do
      begin
        IdIns:=0;
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_INS_FALLITO),[e.Message]),ESCLAMA);
        if State <> dsBrowse then
          Cancel;
      end;
    end;
    SessioneOracle.Commit;
  end;

  if RecordRichiesta.IdRevocato <= 0 then
  begin
    // corregge filtri visualizzazione al fine di includere la richiesta appena inserita
    C018.Periodo.Estendi(Dal,Al);
    C018.IncludiTipoRichieste(trDaAutorizzare);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    C018.StrutturaSel:=C018STRUTTURA_TUTTE;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
  end;

  //Se è prevista l'acquisizione automatica, e la richiesta è subito autorizzata automaticamente, si procede con la sua acquisizione
  if (IdIns > 0) and
     (C018.StatoRichiesta <> '') then
    R600DtM.AcquisizioneRichiesteAuto(C018.Id.ToString,ErrMsg,NumScartate,NumRichieste);

  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  // posizionamento su riga appena inserita
  DBGridColumnClick(nil,IdIns.ToString);
end;

procedure TW010FRichiestaAssenze.AnnullaInsRichiesta;
begin
  W010DM.selT050.Cancel;

  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

procedure TW010FRichiestaAssenze.actDefRichiesta;
// definizione della richiesta preventiva
var
  GiustTipoChar: Char;
  IsModificata, Ok: Boolean;
  IdDef, NumScartate, NumRichieste: Integer;
  ErrMsg: String;
begin
  Log('Traccia','actDefRichiesta');
  // TORINO_ASLTO2 - 2013/044 - R600 utilizzato per controlli causali concatenate
  {
  if R600DtM <> nil then
    FreeAndNil(R600DtM);
  }
  // TORINO_ASLTO2.fine

  // aggiorna la richiesta
  with W010DM.selT050 do
  begin
    // verifica presenza record
    // no refresh in questo caso
    if not SearchRecord('ROWID',cdsT050.FieldByName('DBG_ROWID').AsString,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_DISPONIBILE3),INFORMA);
      Exit;
    end;

    // determina se sono stati modificati dei dati
    GiustTipoChar:=R180CarattereDef(TG,1,#0);
    IsModificata:=False;
      if (GiustTipoChar in ['N','D']) or
         ((GiustTipoChar = 'M') and (R180OreMinutiExt(RecordRichiesta.NumeroOre) > 0)) then
      IsModificata:=IsModificata or (FieldByName('NUMEROORE').AsString <> RecordRichiesta.NumeroOre);
    if GiustTipoChar = 'D' then
      IsModificata:=IsModificata or (FieldByName('AORE').AsString <> RecordRichiesta.AOre);

    // aggiorna i dati della richiesta per renderla definitiva
    try
      RefreshRecord;
      Edit;
    except
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_MODIFICATA),INFORMA);
      Exit;
    end;

    // imposta tipo richiesta e salva valori richiesta preventiva
    IdDef:=FieldByName('ID').AsInteger;
    FieldByName('NUMEROORE_PREV').AsString:=FieldByName('NUMEROORE').AsString;
    FieldByName('AORE_PREV').AsString:=FieldByName('AORE').AsString;
    if IsModificata then
    begin
      // salva il nuovo orario del giustificativo
      if (GiustTipoChar in ['N','D']) or
         ((GiustTipoChar = 'M') and (R180OreMinutiExt(RecordRichiesta.NumeroOre) > 0)) then
        FieldByName('NUMEROORE').AsString:=RecordRichiesta.NumeroOre;
      if GiustTipoChar = 'D' then
        FieldByName('AORE').AsString:=RecordRichiesta.AOre;
    end;

    // post dei dati
    try
      RegistraLog.SettaProprieta('M',C018.TabellaIter,medpCodiceForm,W010DM.selT050,True);
      Post;
      RegistraLog.RegistraOperazione;
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=IdDef;
      C018.SetTipoRichiesta('D');
      C018.SetStato(C018SI,C018.LivAutIntermedia);
      // EMPOLI_ASL11: segnala anomalia su dati modificati (T852)
      if AnomaliaAss <> 0 then
        C018.SetDatoAutorizzatore('SUPERO_COMPETENZE','S',0);
      //Alberto 08/11/2018 - Orbassano_HSLuigi: Se è prevista l'acquisizione automatica, e la richiesta è subito autorizzata automaticamente, si procede con la sua acquisizione
      if (C018.StatoRichiesta <> '') then
        Ok:=R600DtM.AcquisizioneRichiesteAuto(C018.Id.ToString,ErrMsg,NumScartate,NumRichieste);
      SessioneOracle.Commit;
      RefreshOptions:=[roAllFields];
      RefreshRecord;
      RefreshOptions:=[];//Si annullano le opzioni di refresh perchè danno problemi col RefreshRecord usato nella Delete
      grdRichieste.medpAllineaRecordCDS;
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_DEF_FALLITA),[E.Message]),ESCLAMA);
      end;
    end;
  end;

  // corregge filtri visualizzazione al fine di includere la richiesta appena definita
  if IsModificata then
    C018.IncludiTipoRichieste(trDaAutorizzare)
   else
    C018.IncludiTipoRichieste(trAutorizzate);
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  // posizionamento su riga appena definita
  DBGridColumnClick(nil,IntToStr(IdDef));
end;

procedure TW010FRichiestaAssenze.actCtrlRipristinoRich;
begin
  // ripristina il tipo richiesta in modo che sia nuovamente
  // considerata nei conteggi
  if RecordRichiesta.Operazione = 'D' then
    RichiestaDaDefInConteggi(cdsT050.FieldByName('DBG_ROWID').AsString,True);
end;

procedure TW010FRichiestaAssenze.btnVisualizzaRiepilogoClick(Sender: TObject);
var G:TGiustificativo;
    i:Integer;
    Prog:Integer;
    dDataRiep:TDateTime;
    EsisteResiduo,EsisteFamiliare:Boolean;
    LRifDataNascita: TRiferimentoDataNascita;
begin
  try
    dDataRiep:=StrToDate(edtRiepAl.Text);
  except
    edtRiepAl.SetFocus;
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_DATA_RIEP));
    exit;
  end;
  Log('Traccia','btnRiepilogoClick - inizio');
  Prog:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  SetLength(R600DtM.RiepilogoAssenze,0);
  G.Inserimento:=False;
  G.Modo:='I';
  G.Causale:=Trim(Copy(StringReplace(cmbCausaliDisponibili.Text,SPAZIO,' ',[rfReplaceAll]),1,5));
  if G.Causale = '' then
  begin
    cmbCausaliDisponibili.SetFocus;
    if WR000DM.Responsabile then
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W010_MSG_SELEZIONARE_RICH_RIEP))
    else
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_CAUSALE_RIEP));
    exit;
  end;
  lblCausale.Caption:=G.Causale + ' - ' + Trim(Copy(StringReplace(cmbCausaliDisponibili.Text,SPAZIO,' ',[rfReplaceAll]),6,40));
  EsisteFamiliare:=False;
  if R600DtM = nil then
    CreaR600;
  try
    if R180CarattereDef(VarToStr(WR000DM.selT265.Lookup('Codice',G.Causale,'Cumulo_Familiari')),1,'N') in ['S','D'] then
    begin
      with R600DtM.selT040DATANAS do
      begin
        EsisteFamiliare:=True;
        Close;
        SetVariable('Progressivo',Prog);
        SetVariable('Causale',G.Causale);
        SetVariable('Data1',EncodeDate(1900,1,1));
        SetVariable('Data2',dDataRiep);
        Open;
        while not Eof do
        begin
          // csi.ini
          //R600DtM.RiepilogaAssenze(Prog,dDataRiep,G,True,FieldByName('DataNas').AsDateTime);
          R600DtM.RiferimentoDataNascita.Data:=FieldByName('DataNas').AsDateTime;
          R600DtM.GetIDFamiliare(Prog);
          R600DtM.RiepilogaAssenze(Prog,dDataRiep,G,True,R600DtM.RiferimentoDataNascita);
          // csi.fine
          Next;
        end;
        CloseAll;
      end;
    end
    else
    begin
      // csi.ini
      // (*Passo 0 perchè qui non serve questo parametro*)
      // R600DtM.RiepilogaAssenze(Prog,dDataRiep,G,False,0);
      LRifDataNascita.Esiste:=False;
      LRifDataNascita.Data:=DATE_NULL;
      LRifDataNascita.IDFamiliare:='';
      LRifDataNascita.GradoPar:='';
      LRifDataNascita.PartFruizMaternita:='';
      R600DtM.RiepilogaAssenze(Prog,dDataRiep,G,False,LRifDataNascita);
      // csi.fine
    end;
  finally
    // TORINO_ASLTO2 - 2013/044 - R600 utilizzato per controlli causali concatenate
    // FreeAndNil(R600DtM);
    // TORINO_ASLTO2.fine
  end;
  grdRiepilogo.RowCount:=0;
  grdRiepilogo.ColumnCount:=0;
  grdRiepilogo.Clear;
  grdRiepilogo.Visible:=True;
  grdRiepilogo.RowCount:=Length(R600DtM.RiepilogoAssenze) + 1;
  grdRiepilogo.ColumnCount:=12;
  grdRiepilogo.Cell[0,0].Text:='';
  grdRiepilogo.Cell[0,1].Text:='Familiare';
  grdRiepilogo.Cell[0,2].Text:='Misura';
  grdRiepilogo.Cell[0,3].Text:='Comp.prec';
  grdRiepilogo.Cell[0,4].Text:='Comp.corr';
  grdRiepilogo.Cell[0,5].Text:='Comp.totali';
  grdRiepilogo.Cell[0,6].Text:='Fruito prec.';
  grdRiepilogo.Cell[0,7].Text:='Fruito corr.';
  grdRiepilogo.Cell[0,8].Text:='Fruito tot.';
  grdRiepilogo.Cell[0,9].Text:='Fruito rich.';
  grdRiepilogo.Cell[0,10].Text:='Fruito aut.';
  grdRiepilogo.Cell[0,11].Text:='Residuo';
  EsisteResiduo:=False;
  for i:=0 to High(R600DtM.RiepilogoAssenze) do
  begin
    if R600DtM.RiepilogoAssenze[i].EsisteResiduo then
      EsisteResiduo:=True;
    grdRiepilogo.Cell[i + 1,0].Control:=TmeIWImageFile.Create(Self);
    with (grdRiepilogo.Cell[i + 1,0].Control as TmeIWImageFile) do
    begin
      Css:='icona';
      Hint:='Dettaglio del calcolo competenze';
      ImageFile.FileName:=fileImgDettaglio;
      FriendlyName:=IntToStr(i);
      OnClick:=imgDettaglioClick;
    end;
    grdRiepilogo.Cell[i + 1,0].Clickable:=True;
    with R600DtM.RiepilogoAssenze[i] do
    begin
      grdRiepilogo.Cell[i + 1,1].Text:=Familiare;
      grdRiepilogo.Cell[i + 1,2].Text:=IfThen(ArrotOre2Giorni,'Giorni',UM);
      grdRiepilogo.Cell[i + 1,3].Text:=IfThen(ArrotOre2Giorni,H_CP,CP);
      grdRiepilogo.Cell[i + 1,4].Text:=IfThen(ArrotOre2Giorni,H_CC,CC);
      grdRiepilogo.Cell[i + 1,5].Text:=IfThen(ArrotOre2Giorni,H_CT,CT);
      grdRiepilogo.Cell[i + 1,6].Text:=IfThen(ArrotOre2Giorni,H_FP,FP);
      grdRiepilogo.Cell[i + 1,7].Text:=IfThen(ArrotOre2Giorni,H_FC,FC);
      grdRiepilogo.Cell[i + 1,8].Text:=IfThen(ArrotOre2Giorni,H_FT,FT);
      grdRiepilogo.Cell[i + 1,9].Text:=IfThen(ArrotOre2Giorni,H_IterRich,IterRich);
      grdRiepilogo.Cell[i + 1,10].Text:=IfThen(ArrotOre2Giorni,H_IterAut,IterAut);
      grdRiepilogo.Cell[i + 1,11].Text:=IfThen(ArrotOre2Giorni,H_R,R);
    end;
  end;
  for i:=0 to grdRiepilogo.RowCount - 1 do
  begin
    if not EsisteFamiliare then
      grdRiepilogo.Cell[i,1].Css:='invisibile';
    if not EsisteResiduo then
    begin
      grdRiepilogo.Cell[i,3].Css:='invisibile';
      grdRiepilogo.Cell[i,4].Css:='invisibile';
      grdRiepilogo.Cell[i,6].Css:='invisibile';
      grdRiepilogo.Cell[i,7].Css:='invisibile';
    end;
  end;

  btnNascondiRiepilogo.Visible:=True;
  // 18/04/2019 - Bug IntraWEB 15.0.18:
  //con TemplateProcessor.RenderStyle = False, settare la proprietà Visible in Async non funziona
  //si usa il css "invisibile"
  grdRiepilogo.CSS:=grdRiepilogo.CSS.Replace(' invisibile','');
  btnNascondiRiepilogo.CSS:=btnNascondiRiepilogo.CSS.Replace(' invisibile','');

  Log('Traccia','btnRiepilogoClick - fine');
end;

procedure TW010FRichiestaAssenze.btnStampaRicevutaClick(Sender: TObject);
// stampa pdf della ricevuta di autorizzazione
var
  rvComp: TRaveComponent;
  L: TStringList;
  dconnDettaglio: TRaveDataConnection;
  ODS: TOracleDataSet;
  EnteIndirizzo,NomeFile: String;
begin
  Log('Traccia','StampaRicevuta - inizio');
  CSStampa.Enter;
  rvSystem:=TRVSystem.Create(Self);
  rvProject:=TRVProject.Create(Self);
  connDettaglio:=TRVDataSetConnection.Create(Self);
  rvRenderPDF:=TRvRenderPDF.Create(Self);
  L:=TStringList.Create;
  try
    cdsAutorizzazione.Open;
    cdsAutorizzazione.EmptyDataSet;

    rvProject.Engine:=RvSystem;
    rvRenderPDF.Active:=True;
    rvProject.ProjectFile:=gSC.ContentPath + 'report\W010RicevutaAutorizzazione.rav';
    connDettaglio.Name:='connDettaglio';
    connDettaglio.DataSet:=cdsAutorizzazione;
    connDettaglio.RuntimeVisibility:=RpCon.rtNone;

    with W010DM do
    begin
      if selT050.SearchRecord('ROWID',(Sender as TmeIWImageFile).FriendlyName,[srFromBeginning]) then
      begin
        // inserisce i dati nel client dataset
        with cdsAutorizzazione do
        begin
          Append;
          FieldByName('PROGRESSIVO').Value:=selT050.FieldByName('PROGRESSIVO').Value;
          FieldByName('NOMINATIVO').Value:=selT050.FieldByName('NOMINATIVO').Value;
          FieldByName('MATRICOLA').Value:=selT050.FieldByName('MATRICOLA').Value;
          FieldByName('SESSO').Value:=selT050.FieldByName('SESSO').Value;
          FieldByName('CAUSALE').Value:=selT050.FieldByName('CAUSALE').Value;
          FieldByName('TIPOGIUST').Value:=selT050.FieldByName('TIPOGIUST').Value;
          FieldByName('DAL').Value:=selT050.FieldByName('DAL').Value;
          FieldByName('AL').Value:=selT050.FieldByName('AL').Value;
          FieldByName('NUMEROORE').Value:=selT050.FieldByName('NUMEROORE').Value;
          FieldByName('AORE').Value:=selT050.FieldByName('AORE').Value;
          FieldByName('RESPONSABILE').Value:='';//selT050.FieldByName('RESPONSABILE').Value;
          FieldByName('D_CAUSALE').AsString:=Trim(selT050.FieldByName('D_CAUSALE').AsString);
          FieldByName('D_RESPONSABILE').AsString:=selT050.FieldByName('D_RESPONSABILE').AsString;
          Post;
        end;
      end;
    end;

    // Gestione stampa
    rvProject.Open;
    rvProject.GetReportList(L,True);
    rvProject.SelectReport(L[0],True);
    rvDWDettaglio:=(RVProject.ProjMan.FindRaveComponent('dwDettaglio',nil) as TRaveDataView);
    //Impostazioni dei campi di Dettaglio
    dconnDettaglio:=CreateDataCon(connDettaglio);
    rvDWDettaglio.ConnectionName:=dconnDettaglio.Name;
    rvDWDettaglio.DataCon:=dconnDettaglio;
    CreateFields(rvDWDettaglio,nil,nil,True);
    rvPage:=RVProject.ProjMan.FindRaveComponent('W010.Page',nil);

    // Impostazioni della banda bndTitolo
    // 1. Logo
    rvComp:=RVProject.ProjMan.FindRaveComponent('bmpLogo',rvPage);
    (rvComp as TRaveBitmap).Height:=0;
    (rvComp as TRaveBitmap).Width:=0;
    try
      ODS:=TOracleDataSet.Create(nil);
      try
        ODS.Session:=SessioneOracle;
        ODS.SQL.Add('SELECT IMMAGINE FROM T004_IMMAGINI WHERE TIPO = ''CARTELLINO''');
        ODS.Open;
        if ODS.RecordCount = 1 then
        begin
          (rvComp as TRaveBitmap).Image.Assign(TBlobField(ODS.FieldByName('IMMAGINE')));
          (rvComp as TRaveBitmap).Height:=0.640;
          (rvComp as TRaveBitmap).Width:=1.2;
        end;
        ODS.Close;
      finally
        FreeAndNil(ODS);
      end;
    except
      on E:Exception do
        Log('Errore','StampaRicevuta;Impostazione logo;' + E.ClassName + '/' + E.Message);
    end;
    // 2. altre informazioni di testata
    // ragione sociale
    rvComp:=RVProject.ProjMan.FindRaveComponent('lblAzienda',rvPage);
    (rvComp as TRaveText).Text:=Parametri.RagioneSociale;
    // indirizzo
    with WR000DM.selI090 do
    begin
      Close;
      SetVariable('AZIENDA',Parametri.Azienda);
      Open;
      EnteIndirizzo:=IfThen(RecordCount = 0,'',FieldByName('INDIRIZZO').AsString);
      Close;
    end;
    rvComp:=RVProject.ProjMan.FindRaveComponent('lblIndirizzo',rvPage);
    (rvComp as TRaveText).Text:=EnteIndirizzo;

    ScalaStampa:=0.2 / 18;
    //Generazione del file PDF
    rvSystem.SystemSetups:=RVSystem.SystemSetups - [ssAllowSetup];
    rvSystem.SystemOptions:=rvSystem.SystemOptions - [soShowStatus,soPreviewModal];
    rvSystem.DefaultDest:=rdFile;
    rvSystem.DoNativeOutput:=False;
    rvSystem.RenderObject:=RvRenderPDF;
    if W000ParConfig.RaveStreamMode = INI_RAVE_STREAM_MODE_TEMPFILE then
      rvSystem.SystemFiler.StreamMode:=smTempFile
    else
      rvSystem.SystemFiler.StreamMode:=smMemory;
    NomeFile:=GetNomeFile('pdf');
    rvSystem.OutputFileName:=NomeFile;
    ForceDirectories(ExtractFileDir(rvSystem.OutputFileName));
    rvProject.Execute;
    VisualizzaFile(NomeFile,A000TraduzioneStringhe(A000MSG_W010_MSG_ANTEPRIMA_STAMPA),nil,nil);
  finally
    cdsAutorizzazione.Close;
    L.Free;
    rvProject.Close;
    FreeAndNil(dconnDettaglio);
    FreeAndNil(rvSystem);
    FreeAndNil(rvRenderPDF);
    FreeAndNil(rvProject);
    FreeAndNil(connDettaglio);
    CSStampa.Leave;
  end;
  Log('Traccia','StampaRicevuta - fine');
end;

procedure TW010FRichiestaAssenze.W010AutorizzaTutto(Sender: TObject; var Ok: Boolean);
// Effettua l'autorizzazione positiva / negativa di tutte le richieste
// ancora da autorizzare visibili a video.
var
  Aut: String;
  ErrModCan: Boolean;
  function FormattaDatiRichiesta: String;
  var
    Tipo,NumOre,AOre: String;
  begin
    with W010DM.selT050 do
    begin
      NumOre:=FieldByName('NUMEROORE').AsString;
      AOre:=FieldByName('AORE').AsString;
      if FieldByName('TIPOGIUST').AsString = 'I' then
        Tipo:=A000TraduzioneStringhe(A000MSG_W010_MSG_GG_INTERA)
      else if FieldByName('TIPOGIUST').AsString = 'M' then
        Tipo:=Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_GG_MEZZA),[IfThen(NumOre <> '',' (' + NumOre + ' ore)')])
      else if FieldByName('TIPOGIUST').AsString = 'N' then
        Tipo:=Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_NUM_ORE),[NumOre])
      else if FieldByName('TIPOGIUST').AsString = 'D' then
        Tipo:=Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_DA_ORE_A_ORE),[NumOre,AOre]);

      // formatta la richiesta
      Result:=Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_RICHIESTA_ASS),[FieldByName('NOMINATIVO').AsString,
                                                                           FieldByName('MATRICOLA').AsString,
                                                                           FieldByName('DATA_RICHIESTA').AsString,
                                                                           FormatDateTime('dd/mm/yyyy',FieldByName('DAL').AsDateTime),
                                                                           FormatDateTime('dd/mm/yyyy',FieldByName('AL').AsDateTime),
                                                                           Tipo,FieldByName('CAUSALE').AsString]);
    end;
  end;
begin
  Log('Traccia','btnTuttiSiClick - inizio');
  // inizializzazione variabili
  ErrModCan:=False;
  Aut:=IfThen(Sender = btnTuttiSi,C018SI,C018NO);

  // autorizzazione richieste
  with W010DM.selT050 do
  begin
    // niente refresh: autorizza solo ciò che è visualizzato nella pagina
    First;
    while not Eof do
    begin
      try
        if (FieldByName('ELABORATO').AsString = 'N') and
           (FieldByName('ID_REVOCA').IsNull) and
           (FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
           (FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0) then
          try
            C018.CodIter:=FieldByName('COD_ITER').AsString;
            C018.Id:=FieldByName('ID').AsInteger;
            try
              C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
              if C018.MessaggioOperazione <> '' then
                raise Exception.Create(C018.MessaggioOperazione)
              else
                SessioneOracle.Commit;
            except
              on E: Exception do
              begin
                // messaggio bloccante
                MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_IMPOST_AUT_FALLITA),[E.Message,FormattaDatiRichiesta]),
                                  ESCLAMA,A000TraduzioneStringhe(A000MSG_W010_MSG_AUTO_GIUST_ERR));
                VisualizzaDipendenteCorrente;
                Exit;
              end;
            end;
          except
            // errore probabilmente dovuto a record modificato / cancellato da altro utente
            on E:Exception do
              ErrModCan:=True;
          end;
      finally
        Next;
      end;
    end;
  end;
  if ErrModCan then
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_IGNORATE));
  Log('Traccia','btnTuttiSiClick - fine');
  Ok:=True;
end;

procedure TW010FRichiestaAssenze.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i,idxStampa,idxSuperoComp,LivAut: Integer;
  DefAttiva: Boolean;
  VisAutorizza: Boolean;
  VisCancella: Boolean;
  VisDefinisci: Boolean;
  VisRevoca: Boolean;
  VisCancPeriodo: Boolean;
  VisAnnulla: Boolean;
  VisConferma: Boolean;
  ShowLegenda1,
  ShowLegenda2,
  ShowLegenda3: Boolean;
  StrTipoRichiesta: String;
  StrRevocabile: String;
  StrElaborato: String;
  IdRevoca: Integer;
  StrAutorizzazione: String;
  StrAutorizzUtile: String;
  HintDescRichiesta:String;
  DatoAutorizzatore:String;
  TmpDal,TmpAl: TDateTime;
  IWImg: TmeIWImageFile;
  IWLbl: TmeIWLabel;
begin
  ShowLegenda1:=False;
  ShowLegenda2:=False;
  ShowLegenda3:=False;
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    // variabili di appoggio per i test
    StrTipoRichiesta:=grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA');
    StrRevocabile:=grdRichieste.medpValoreColonna(i,'REVOCABILE');
    StrElaborato:=grdRichieste.medpValoreColonna(i,'ELABORATO');
    IdRevoca:=StrToIntDef(grdRichieste.medpValoreColonna(i,'ID_REVOCA'),0);
    StrAutorizzazione:=grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE');
    StrAutorizzUtile:=grdRichieste.medpValoreColonna(i,'AUTORIZZ_UTILE');

    if IdRevoca > 0 then
      ShowLegenda1:=C018.Revocabile
    else if IdRevoca < 0 then
      ShowLegenda3:=C018.Revocabile;
    if (StrTipoRichiesta = 'P') and
       (StrAutorizzUtile = C018NO) then
      ShowLegenda2:=True;
    LivAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);
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
      if C018.SetIconaAllegati(IWImg) then
        IWImg.OnClick:=imgAllegClick;
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    // dettaglio cartellino
    IWImg:=(grdRichieste.medpCompCella(i,'D_CARTELLINO',0) as TmeIWImageFile);
    IWImg.OnClick:=imgCartellinoClick;
    // visti precedenti
    if WR000DM.Responsabile and C018.UtilizzoAvviso then
    begin
      IWLbl:=(grdRichieste.medpCompCella(i,'D_VISTI_PREC',0) as TmeIWLabel);
      IWLbl.Caption:=C018.VistiPrecedenti[LivAut];
      if IWLbl.Caption = 'No' then
        IWLbl.Css:='font_rosso';
      IWLbl.Visible:=True;
    end;

    if WR000DM.Responsabile then
    begin
      // * Responsabile *
      // autorizzazione richiesta con checkbox
      VisAutorizza:=(StrElaborato = 'N') and
                    (IdRevoca = 0) and
                    (grdRichieste.medpValoreColonna(i,'AUTORIZZ_AUTOMATICA') <> 'S') and
                    (LivAut > 0); (*C018: se livello < 0 vuol dire che la richiesta fa parte del mio iter ma non posso autorizzare perchè già autorizzata successivamente*)
      if not VisAutorizza then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
      begin
        if Parametri.CampiRiferimento.C90_W010AcquisizioneAuto <> 'S' then
        begin
          // v1: onclick
          C018.SetValoriAut(grdRichieste,i,0,0,1,chkAutorizzazioneClick);
          // v1.fine
        end
        else
        begin
          // v2.ini
          // COMO_HSANNA
          // versione con onasyncclick (non aggiorna la dbgrid dopo l'operazione di autorizzazione)
          C018.SetValoriAut(grdRichieste,i,0,0,1,nil);
          with (grdRichieste.medpCompCella(i,0,0) as TmeIWCheckBox) do
          begin
            Name:=Format(ROW_ELEM_NAME_FMT,[CHKSI_NAME,i]);
            OnAsyncClick:=chkAutorizzazioneAsyncClick;
          end;
          if grdRichieste.medpCompCella(i,0,1) <> nil then
          begin
            with (grdRichieste.medpCompCella(i,0,1) as TmeIWCheckBox) do
            begin
              Name:=Format(ROW_ELEM_NAME_FMT,[CHKNO_NAME,i]);
              OnAsyncClick:=chkAutorizzazioneAsyncClick;
            end;
          end;
          // v2.fine
        end;
      end;

      // stampa autorizzazione
      idxStampa:=grdRichieste.medpIndexColonna('DBG_COMANDI');
      if (StrTipoRichiesta = 'R') or
         (StrAutorizzazione <> 'S') then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[idxStampa]);
      if grdRichieste.medpCompGriglia[i].CompColonne[idxStampa] <> nil then
        (grdRichieste.medpCompCella(i,idxStampa,0) as TmeIWImageFile).OnClick:=btnStampaRicevutaClick;

      // EMPOLI_ASL11: segnala anomalia su dati modificati (T852)
      // flag supero competenze
      if ShowAvvertimenti then
      begin
        idxSuperoComp:=grdRichieste.medpIndexColonna('D_AVVERTIMENTI');
        DatoAutorizzatore:=C018.GetDatoAutorizzatore('SUPERO_COMPETENZE').Valore;
        with (grdRichieste.medpCompCella(i,idxSuperoComp,0) as TmeIWLabel) do
        begin
          if DatoAutorizzatore = 'S' then
          begin
            Css:='font_rosso';
            Caption:='Competenze esaurite';
          end
          else
            Caption:='';
          Visible:=Caption <> '';
        end;
      end;
    end
    else
    begin
      // * Dipendente *
      VisCancella:=(StrRevocabile = 'CANC');
      DefAttiva:=(C018.EsisteAutorizzIntermedia) and
                 (StrTipoRichiesta = 'P') and
                 (grdRichieste.medpValoreColonna(i,'AUTORIZZ_PREV') = 'S') and
                 ((IdRevoca = 0) or
                  (grdRichieste.medpValoreColonna(i,'AUTORIZZ_REVOCA') = 'N'));
      VisDefinisci:=(RecordRichiesta.Operazione <> 'D') and DefAttiva;
      // revoca: rich. revocabile non elaborata
      VisRevoca:=(C018.Revocabile) and
                 (StrTipoRichiesta <> 'R') and
                 (StrTipoRichiesta <> 'C') and // empoli - commessa 2012/102
                 (StrRevocabile = 'REVOC') and
                 //(StrElaborato <> 'E') and //Alberto 13/09/2017: si lascia revocare anche una richiesta andata in errore
                 (IdRevoca = 0); // se richiesta ha cancellazioni non si può revocare
      // EMPOLI_ASL11 - commessa 2012/102.ini
      // canc. periodo: rich. definitiva autorizzata, non revocata, di lunghezza maggiore di un giorno
      TmpDal:=StrToDate(grdRichieste.medpValoreColonna(i,'DAL'));
      TmpAl:=StrToDate(grdRichieste.medpValoreColonna(i,'AL'));
      VisCancPeriodo:=(C018.Revocabile) and
                      (Pos(INI_PAR_T050_CANCELLAZIONE,W000ParConfig.ParametriAvanzati) > 0) and
                      (StrTipoRichiesta = 'D') and
                      (StrAutorizzazione = 'S') and
                      //(StrElaborato <> 'E') and //Alberto 13/09/2017: si lascia revocare anche una richiesta andata in errore
                      (IdRevoca <= 0) and // impedisce cancellazione se esiste una revoca
                      (TmpAl > TmpDal);
      // EMPOLI_ASL11 - commessa 2012/102.fine
      VisAnnulla:=(RecordRichiesta.Operazione = 'D') and DefAttiva;
      VisConferma:=VisAnnulla;

      // Gestione grid comandi
      if not (VisCancella or VisDefinisci or VisRevoca or VisCancPeriodo or VisAnnulla or VisConferma) then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
      begin
        if StileCella1 = '' then
        begin
          StileCella1:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css;
          if C018.EsisteAutorizzIntermedia then
            StileCella2:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css;
        end;
        HintDescRichiesta:=Format(A000TraduzioneStringhe(A000MSG_W010_PARAM_HINT_DESC_RICHIESTA),
                                  [grdRichieste.medpValoreColonna(i,'DATA_RICHIESTA'),
                                   grdRichieste.medpValoreColonna(i,'D_CAUSALE_2'),
                                   grdRichieste.medpValoreColonna(i,'DAL'),
                                   grdRichieste.medpValoreColonna(i,'AL')]);
        // cancella
        (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css:=IfThen(VisCancella,StileCella1,'invisibile');
        with (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile) do
        begin
          OnClick:=imgCancellaClick;
          Hint:=Hint + HintDescRichiesta;
        end;

        if C018.EsisteAutorizzIntermedia then
        begin
          // definisci (1)
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:=IfThen(VisDefinisci,StileCella1,'invisibile');
          with (grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile) do
          begin
            if grdRichieste.medpValoreColonna(i,'TIPOGIUST') = 'I' then
            begin
              Confirmation:='Rendere la richiesta definitiva?';
              OnClick:=imgConfermaDefClick;
              Hint:='Rende definitiva la richiesta' + HintDescRichiesta;
            end
            else
            begin
              Confirmation:='';
              OnClick:=imgDefinisciClick;
              Hint:='Definisce la richiesta' + HintDescRichiesta;
            end;
          end;
          // revoca (2)
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:=IfThen(VisRevoca,StileCella2,'invisibile');
          with (grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile) do
          begin
            OnClick:=imgRevocaClick;
            Hint:=Hint + HintDescRichiesta;
          end;
          // EMPOLI_ASL11 - commessa 2012/102.ini
          // cancella periodo (3)
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,3].Css:=IfThen(VisCancPeriodo,StileCella2,'invisibile');
          with (grdRichieste.medpCompCella(i,0,3) as TmeIWImageFile) do
          begin
            OnClick:=imgCancPeriodoClick;
            Hint:=Hint + HintDescRichiesta;
          end;
          // EMPOLI_ASL11 - commessa 2012/102.fine
          // annulla definizione (4)
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,4].Css:=IfThen(VisConferma,StileCella1,'invisibile');
          with (grdRichieste.medpCompCella(i,0,4) as TmeIWImageFile) do
          begin
            Confirmation:='';
            OnClick:=imgAnnullaClick;
            Hint:=Hint + HintDescRichiesta;
          end;
          // conferma definizione
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,5].Css:=IfThen(VisConferma,StileCella2,'invisibile');
          with (grdRichieste.medpCompCella(i,0,5) as TmeIWImageFile) do
          begin
            Confirmation:='Rendere la richiesta definitiva?';
            OnClick:=imgConfermaDefClick;
            Hint:=Hint + HintDescRichiesta;
          end;
        end
        else
        begin
          // revoca
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:=IfThen(VisRevoca,StileCella2,'invisibile');
          with (grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile) do
          begin
            OnClick:=imgRevocaClick;
            Hint:=Hint + HintDescRichiesta;
          end;
          // EMPOLI_ASL11 - commessa 2012/102.ini
          // cancella periodo (2)
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:=IfThen(VisCancPeriodo,StileCella2,'invisibile');
          with (grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile) do
          begin
            OnClick:=imgCancPeriodoClick;
            Hint:=Hint + HintDescRichiesta;
          end;
          // EMPOLI_ASL11 - commessa 2012/102.fine
        end;
      end;
    end;
  end;
  lblLegenda1.Visible:=ShowLegenda1;
  lblLegenda2.Visible:=ShowLegenda2;
  lblLegenda3.Visible:=ShowLegenda3;
  Log('Traccia','CaricaT050 - fine');
end;

procedure TW010FRichiestaAssenze.grdRichiesteBeforeCaricaCDS(Sender: TObject; DBG_ROWID: string);
begin
  Log('Traccia','CaricaT050 - inizio');
end;

procedure TW010FRichiestaAssenze.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna:Integer;
  NomeCampo, TestoApice: String;
begin
  if not grdRichieste.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdRichieste.medpNumColonna(AColumn);
  NomeCampo:=grdRichieste.medpColonna(NumColonna).DataField;

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow - 1 <= High(grdRichieste.medpCompGriglia)) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  // impostazione stili css particolari (colonne "Autorizzazione" ed "Elaborazione")
  if (ARow > 0) and (ARow - 1 <= High(grdRichieste.medpCompGriglia)) and (ACell.Control = nil) then
  begin
    if NomeCampo = 'D_TIPO_RICHIESTA' then
    begin
      ACell.RawText:=False;

      // visualizza le note come apici
      if (Pos('(1)',ACell.Text) > 0) or (Pos('(3)',ACell.Text) > 0) then
      begin
        TestoApice:=IfThen(Pos('(1)',ACell.Text) > 0,'(1)','(3)');
        ACell.Text:=StringReplace(ACell.Text,TestoApice,Format('<span class = "apice">&nbsp;%s</span>',[TestoApice]),[]);
        ACell.RawText:=True;
      end;
      if Pos('(2)',ACell.Text) > 0 then
      begin
        ACell.Text:=StringReplace(ACell.Text,'(2)','<span class = "apice">' + IfThen(ACell.RawText,'','&nbsp;') + '(2)</span>',[]);
        ACell.RawText:=True;
      end;
      // empoli - commessa 2012/102.ini
      // grassetto per revoca e cancellazione
      if R180In(grdRichieste.medpValoreColonna(ARow - 1,'TIPO_RICHIESTA'),['R','C']) then
        ACell.Css:=ACell.Css + ' font_grassetto';
      // empoli - commessa 2012/102.fine
    end
    else if NomeCampo = 'D_AUTORIZZAZIONE' then
    begin
      ACell.Css:=ACell.Css + ' font_grassetto align_center' +
                 IfThen(grdRichieste.medpValoreColonna(ARow - 1,'AUTORIZZ_UTILE') = C018NO,' font_rosso');
    end
    else if NomeCampo = 'D_ELABORATO' then
    begin
      ACell.Css:=ACell.Css + ' font_grassetto align_center' +
                 IfThen(grdRichieste.medpValoreColonna(ARow - 1,'ELABORATO') = 'E',' font_rosso');
    end
    else if ((NomeCampo = 'DAL') or
             (NomeCampo = 'AL') or
             (NomeCampo = 'D_CAUSALE_2')) then
    begin
      ACell.Css:=ACell.Css + ' font_blu';
    end;
  end;
end;

procedure TW010FRichiestaAssenze.DBGridColumnClick(ASender: TObject; const AValue: string);
var
  IdRiga: Integer;
  AbilitaRiepilogo: Boolean;
begin
  // prova la locate prima con rowid, quindi con id richiesta
  if not cdsT050.Locate('DBG_ROWID',AValue,[]) then
  begin
    if TryStrToInt(AValue,IdRiga) then
    begin
      if not cdsT050.Locate('ID',IdRiga,[]) then
        Exit;
    end
    else
      Exit;
  end;

  // causale
  cmbCausaliDisponibili.ItemIndex:=max(0,ListaCausali.IndexOf(cdsT050.FieldByName('CAUSALE').AsString));

  // estrae nominativo dipendente se <Tutti i dipendenti>
  if TuttiDipSelezionato then
  begin
    selAnagrafeW.SearchRecord('MATRICOLA',cdsT050.FieldByName('MATRICOLA').AsString,[srFromBeginning]);
    lnkDipendente.Caption:=FormattaInfoDipendenteCorrente;
    GetFamiliari;
  end;

  // familiare
  cmbFamiliari.ItemIndex:=max(0,ListaFamiliari.IndexOfName(cdsT050.FieldByName('DATANAS').AsString));

  if WR000DM.Responsabile then
  begin
    AbilitaRiepilogo:=VarToStr(WR000DM.selT265.Lookup('CODICE',cdsT050.FieldByName('CAUSALE').AsString,'CODICE')) <> '';
    lblRiepAl.Visible:=AbilitaRiepilogo;
    edtRiepAl.Visible:=AbilitaRiepilogo;
    btnVisualizzaRiepilogo.Visible:=AbilitaRiepilogo;
  end;

  // inizializzazioni dati richiesta
  RecordRichiesta.TipoRichiesta:='';
  RecordRichiesta.Operazione:='I';
  RecordRichiesta.IdRevocato:=-1;
end;

procedure TW010FRichiestaAssenze.grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  RenderCell(ACell,ARow,AColumn,True,True);
  if (ARow > 0) and (AColumn in [5,8,11]) then
    ACell.Css:=IfThen (ACell.Css = 'invisibile','invisibile','riga_colorata');
end;

procedure TW010FRichiestaAssenze.cdsAutorizzazioneCalcFields(DataSet: TDataSet);
var
  Sesso,TipoGiust,Causale,CodCaus,DesCaus,
  DalAl,NumeroOre,AOre,NumGGStr,
  Periodo_gg, Periodo_ore: String;
  NumGG: Integer;
begin
  with cdsAutorizzazione do
  begin
    // 1. imposta variabili di appoggio
    // sesso
    Sesso:=FieldByName('SESSO').AsString;
    // causale
    CodCaus:=FieldByName('CAUSALE').AsString;
    DesCaus:=FieldByName('D_CAUSALE').AsString;
    Causale:=IfThen(DesCaus <> '',DesCaus,CodCaus);
    // giorni di fruizione
    NumGG:=Trunc(FieldByName('AL').AsDateTime - FieldByName('DAL').AsDateTime) + 1;
    NumGGStr:=IntToStr(NumGG) + ' ' + IfThen(NumGG = 1,'giorno','giorni');
    DalAl:=IfThen(NumGG > 1,
                  'dal ' + FieldByName('DAL').AsString + ' al ' + FieldByName('AL').AsString,
                  'in data ' + FieldByName('DAL').AsString);
    // fruizione a ore
    NumeroOre:=FieldByName('NUMEROORE').AsString;
    AOre:=FieldByName('AORE').AsString;
    // tipo giustificativo
    TipoGiust:=FieldByName('TIPOGIUST').AsString;
    Periodo_gg:=IfThen(TipoGiust = 'M',' per mezza giornata ' + IfThen(NumeroOre <> '','(' + NumeroOre + ' ore) '),' ') + DalAl;
    if TipoGiust = 'N' then
      Periodo_ore:=' di ore ' + NumeroOre                    // numero ore
    else if TipoGiust = 'D' then
      Periodo_ore:=' dalle ' + NumeroOre + ' alle ' + AOre   // da ore - a ore
    else
      Periodo_ore:='';

    // 2. imposta i campi visualizzati in stampa
    // campo: oggetto
    FieldByName('C_OGGETTO').AsString:='OGGETTO: AUTORIZZAZIONE GIUSTIFICATIVO ' + Causale;

    // campo: testo autorizzazione
    FieldByName('C_TESTO').AsString:='Si autorizza ' + IfThen(Sesso = 'F','la','il') + ' dipendente ' +
      FieldByName('NOMINATIVO').AsString + ' (matr. ' +  FieldByName('MATRICOLA').AsString +
      ') ad usufruire di n. ' + NumGGStr + ' di ' + Causale + Periodo_gg + Periodo_ore + '.';

    // data e firma
    FieldByName('C_DATA_FIRMA').AsString:='Li ' + DateToStr(R180SysDate(SessioneOracle)) +
      ', ' + FieldByName('D_RESPONSABILE').AsString;
  end;
end;

procedure TW010FRichiestaAssenze.chkNoteInsAsyncClick(Sender: TObject; EventParams: TStringList);
var
  StrTemp: String;
begin
  if chkNoteIns.Checked then
  begin
    StrTemp:='$("#%s").attr("class","").attr("class","textarea_note inser").hide().slideDown(400).focus();'
  end
  else
  begin
    StrTemp:='$("#%s").slideUp(400);';
  end;
  StrTemp:=Format(StrTemp,[memNoteIns.HTMLName]);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(StrTemp);
end;

procedure TW010FRichiestaAssenze.cmbAccorpCausaliChange(Sender: TObject);
begin
  GetCausaliDisponibili;
end;

procedure TW010FRichiestaAssenze.chkAutorizzazioneClick(Sender: TObject);
// autorizzazione - v1
var
  AbilAut: Boolean;
begin
  Autorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  Autorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  Autorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  // verifica presenza record
  with W010DM.selT050 do
  begin
    Refresh;
    if not SearchRecord('ROWID',Autorizza.RowId,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2));
      Exit;
    end;
  end;

  DBGridColumnClick(Sender,Autorizza.Rowid);

  // verifica abilitazione all'autorizzazione
  AbilAut:=(W010DM.selT050.FieldByName('ELABORATO').AsString = 'N') and
           (W010DM.selT050.FieldByName('ID_REVOCA').AsInteger = 0) and
           (W010DM.selT050.FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
           (W010DM.selT050.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0);
  if not AbilAut then
  begin
    VisualizzaDipendenteCorrente;
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_AUT));
    Exit;
  end;

  AutorizzazioneOK;
end;

procedure TW010FRichiestaAssenze.chkAutorizzazioneAsyncClick(Sender: TObject; EventParams: TStringList);
// autorizzazione - v2
var
  AbilAut: Boolean;
  Nome,Indice,Target: String;
  IWC: TComponent;
begin
  Autorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  Autorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  Autorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  // verifica presenza record
  with W010DM.selT050 do
  begin
    Refresh;
    if not SearchRecord('ROWID',Autorizza.RowId,[srFromBeginning]) then
    begin
      // annulla l'operazione effettuata e dà una segnalazione
      (Sender as TmeIWCheckBox).Checked:=not (Sender as TmeIWCheckBox).Checked;
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2));
      Exit;
    end;
  end;

  DBGridColumnClick(Sender,Autorizza.Rowid);

  // verifica abilitazione all'autorizzazione
  AbilAut:=(W010DM.selT050.FieldByName('ELABORATO').AsString = 'N') and
           (W010DM.selT050.FieldByName('ID_REVOCA').AsInteger = 0) and
           (W010DM.selT050.FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
           (W010DM.selT050.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0);
  if not AbilAut then
  begin
    // annulla l'operazione effettuata e dà una segnalazione
    (Sender as TmeIWCheckBox).Checked:=not (Sender as TmeIWCheckBox).Checked;
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W010_MSG_RICH_NON_AUT));
    Exit;
  end;

  AutorizzazioneOK;

  // garantisce che solo uno dei check si/no sia impostato
  if Autorizza.Checked then
  begin
    // determina il nome del checkbox da TmeIWCheckBox
    Nome:=(Sender as TmeIWCheckBox).Name;
    Indice:=RightStr(Nome,ROW_ELEM_INDEX_LENGTH);
    Nome:=Copy(Nome,1,Length(Nome) - ROW_ELEM_INDEX_LENGTH);

    Target:=IfThen(Nome = CHKSI_NAME,CHKNO_NAME,CHKSI_NAME) + Indice;
    IWC:=FindComponent(Target);
    if Assigned(IWC) then
    begin
      (IWC as TmeIWCheckBox).Checked:=False;
    end;
  end;

  // indica che sono presenti autorizzazioni da confermare
  if Parametri.CampiRiferimento.C90_W010AcquisizioneAuto = 'S' then
  begin
    if Autorizza.Checked and (Autorizza.Caption = 'No') then
      AutorizzazioniDaConfermare:=True
    else if Autorizza.Checked and (Autorizza.Caption = 'Si') and (W010DM.selT050.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger = C018.LivMaxObb) then
      AutorizzazioniDaConfermare:=True;
  end;
end;

procedure TW010FRichiestaAssenze.AutorizzazioneOK;
var
  Aut,Resp: String;
begin
  Log('Traccia','AutorizzazioneOK - inizio');
  Aut:='';
  Resp:='';
  // autorizzazione richiesta
  with W010DM.selT050 do
  begin
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
      C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Resp,'','',True);
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione)
      else
        SessioneOracle.Commit;
    except
      on E: Exception do
        GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_IMP_AUTORIZ_FALLITE),[E.Message]));
    end;
    if not GGetWebApplicationThreadVar.IsCallBack then
      VisualizzaDipendenteCorrente;
  end;
  Log('Traccia','AutorizzazioneOK - fine');
end;

procedure TW010FRichiestaAssenze.btnAnnullaClick(Sender: TObject);
begin
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  RecordRichiesta.TipoRichiesta:='';
  RecordRichiesta.Operazione:='I';
  RecordRichiesta.IdRevocato:=-1;
end;

procedure TW010FRichiestaAssenze.btnCartellinoClick(Sender: TObject);
//var
  //i: Integer;
  //FN: String;
  //W005FM: TW005FCartellinoFM;
const
  FUNZIONE = 'btnCartellinoClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  W005FM:=TW005FCartellinoFM.Create(Self);
  FreeNotification(W005FM);
  W005FM.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  try
    W005FM.Dal:=StrToDate(IfThen(edtDal.Text = '',edtAl.Text,edtDal.Text));
    W005FM.Al:=StrToDate(edtAl.Text);
    if W005FM.Al < W005FM.Dal then
      Abort;
    if W005FM.Al - W005FM.Dal > 34 then
      Abort;
  except
    FreeAndNil(W005FM);
    raise Exception.Create('Il periodo specificato non è corretto!');
  end;
  W005FM.Visualizza;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW010FRichiestaAssenze.DistruggiOggetti;
begin
  try FreeAndNil(W010DM); except end;
  //try FreeAndNil(A004MW); except end;

  try FreeAndNil(W010CalcoloCompetenzeFM); except end;
  try FreeAndNil(W010CancPeriodoFM); except end;

  if R600DtM <> nil then
    try FreeAndNil(R600DtM); except end;

  // pulizia grid
  grdRichieste.medpClearCompGriglia;

  if ListaCausali <> nil then
    FreeAndNil(ListaCausali);
  if ListaFamiliari <> nil then
    FreeAndNil(ListaFamiliari);

  if (GGetWebApplicationThreadVar <> nil) and (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT265);
    R180CloseDataSetTag0(WR000DM.selT275);
    R180CloseDataSetTag0(WR000DM.selT257);
    R180CloseDataSetTag0(WR000DM.selSG101);
    R180CloseDataSetTag0(WR000DM.selSG101Causali);
  end;
end;

procedure TW010FRichiestaAssenze.edtPeriodoDalAlAsyncChange(Sender: TObject; EventParams: TStringList);
var D:TDateTime;
begin
  inherited;
  if TryStrToDate('01/' + edtPeriodoDalAl.Text,D) then
  begin
    D:=R180InizioMese(D);
    edtDal.Text:=DateToStr(R180InizioMeseSettimanale(D,False));
    edtAl.Text:=DateToStr(R180FineMeseSettimanale(D,False));
  end;
end;

procedure TW010FRichiestaAssenze.imgCartellinoClick(Sender: TObject);
var
  //i: Integer;
  FN: String;
  W005FM: TW005FCartellinoFM;
const
  FUNZIONE = 'imgCartellinoClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if not W010DM.selT050.SearchRecord('ROWID',FN,[srFromBeginning]) then
    exit;
  //grdRichiesteColumnClick(Sender,FN);
  //i:=grdRichieste.medpRigaDiCompGriglia(FN);

  W005FM:=TW005FCartellinoFM.Create(Self);
  W005FM.Progressivo:=W010DM.selT050.FieldByname('PROGRESSIVO').AsInteger;
  W005FM.Dal:=W010DM.selT050.FieldByName('DAL').AsDateTime;
  W005FM.Al:=W010DM.selT050.FieldByName('AL').AsDateTime;
  W005FM.Visualizza;
  Log('Traccia',FUNZIONE + ': fine');
end;

end.
