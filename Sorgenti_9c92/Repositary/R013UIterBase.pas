unit R013UIterBase;

interface

uses
  R010UPaginaWeb, R012UWebAnagrafico,
  A000UInterfaccia, A000UCostanti, A000USessione, A000UMessaggi,
  C018UIterAutDM, WC018URiepilogoIterFM, WC026UAllegatiIterFM, WC027UDocumentiManagerDM,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  Variants, StrUtils, Math, meIWLabel, meIWEdit, meIWButton, meIWGrid, meIWCheckBox,
  SysUtils, IWAppForm,IWControl,IWHTMLControls, DB, OracleData, IWApplication,
  IWTemplateProcessorHTML, Classes, ActnList, Menus, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWCompLabel, Controls, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWCompCheckbox, meTIWAdvRadioGroup,
  IWAdvRadioGroup, meIWLink, IWCompGrids, IWDBGrids, medpIWDBGrid, IWCompButton,
  IWCompExtCtrls, meIWImageFile, Vcl.Graphics, meIWImage, meIWComboBox;

type
  TProcObject = procedure(Sender: TObject) of object;

  TProcObjectBool = procedure(Sender: TObject; var Ok: Boolean) of object;

  TR013FIterBase = class(TR012FWebAnagrafico)
    pmnTabella: TPopupMenu;
    mnuEsportaCsv: TMenuItem;
    grdRichieste: TmedpIWDBGrid;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure mnuEsportaCsvClick(Sender: TObject);
  private
    FIter: String;
    FOnApplicaFiltro: TProcObject;
    FOnModificaTutto: TProcObject;
    FOnConfermaTutto: TProcObjectBool;
    FOnAnnullaTutto: TProcObject;
    FOnAutorizzaTutto: TProcObjectBool;
    ChkArr: array of TmeIWCheckBox;
    chkVisto,
    chkNoVisto,
    chkLastClicked: TmeIWCheckBox;
    OldPeriodoDal,
    OldPeriodoAl: String;
    FVisti: Boolean;
    FBloccaGestione: Boolean;
    FEditMultiplo: Boolean;
    FAutorizzaMultiplo: Boolean;
    FInModificaTutti: Boolean;
    FInAutorizzaTutti: Boolean;
    OperazioneOK: Boolean;
    FNumCheck: Integer;
    function  GetIter: String;
    procedure SetIter(const Val: String);
    function  GetEditMultiplo: Boolean;
    procedure SetEditMultiplo(const Val: Boolean);
    function  GetAutorizzaMultiplo: Boolean;
    procedure SetAutorizzaMultiplo(const Val: Boolean);
    function  IndexOfCheck(const PTipo: TTipoRichieste): Integer;
    function  EsisteCheck(const PTipo: TTipoRichieste): Boolean;
    function  AddCheck(const PTipo: TTipoRichieste): Boolean;
    function  GetBloccaGestione: Boolean;
    procedure SetBloccaGestione(const Val: Boolean);
    procedure GestioneErrore(E: Exception; const PNomeProc: String; const PFase: String = '');
    procedure OnTipoRichiesteClick(Sender: TObject);
    procedure OnTipoRichiesteAsyncClick(Sender: TObject; EventParams: TStringList);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    procedure OnStrutturaAsyncChange(Sender: TObject; EventParams: TStringList);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    procedure GestCambioPeriodo;
    procedure OnPeriodoClick(Sender: TObject);
    procedure OnPeriodoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure OnVistoAsyncClick(Sender: TObject; EventParams: TStringList);
    function  GetInModificaTutti: Boolean;
    procedure SetInModificaTutti(const Val: Boolean);
    function  GetInAutorizzaTutti: Boolean;
    procedure SetInAutorizzaTutti(const Val: Boolean);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    procedure PreparaFiltroStruttura;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
  protected
    lblFiltroVis: TmeIWLabel;
    grdFiltroVis: TmeIWGrid;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    lblFiltroStruttura: TmeIWLabel;
    cmbFiltroStruttura: TmeIWComboBox;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    lblPeriodo: TmeIWLabel;
    rgpPeriodo: TmeTIWAdvRadioGroup;
    lblPeriodoDal: TmeIWLabel;
    edtPeriodoDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtPeriodoAl: TmeIWEdit;
    chkFiltroAllegati: TmeIWCheckBox;
    btnFiltra: TmeIWButton;
    btnModificaTutti: TmeIWButton;
    btnAnnullaTutti: TmeIWButton;
    btnTuttiSi: TmeIWButton;
    btnTuttiNo: TmeIWButton;
    WC018Esiste: Integer;
    WC018: TWC018FRiepilogoIterFM;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    WC026: TWC026FAllegatiIterFM;
    //WC027DM: TWC027FDocumentiManagerDM;
    ImgAllegati: TmeIWImageFile;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    function  GetInfoFunzione: String; override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure DistruggiOggetti; override;
    procedure IterBaseApplicaFiltro(Sender: TObject);
    procedure IterBaseModificaTutto(Sender: TObject);
    procedure IterBaseConfermaTutto(Sender: Tobject);
    procedure IterBaseAnnullaTutto(Sender: TObject);
    procedure IterBaseAutorizzaTutto(Sender: TObject);
    procedure CorrezionePeriodo;
    procedure R013Open(PDataset: TDataSet; PInfoDebug: Boolean = False);
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure DisponiFiltriVis;
    procedure AggiornaFiltriVis;
    procedure VisualizzaDettagli(Sender:TObject);
    procedure VisualizzaAllegati(Sender: TObject);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    C018:TC018FIterAutDM;
    property Iter: String read GetIter write SetIter;
    property BloccaGestione: Boolean read GetBloccaGestione write SetBloccaGestione;
    property InModificaTutti: Boolean read GetInModificaTutti write SetInModificaTutti;
    property InAutorizzaTutti: Boolean read GetInAutorizzaTutti write SetInAutorizzaTutti;
  published
    property medpEditMultiplo: Boolean read GetEditMultiplo write SetEditMultiplo;
    property medpAutorizzaMultiplo: Boolean read GetAutorizzaMultiplo write SetAutorizzaMultiplo;
    property OnApplicaFiltro: TProcObject read FOnApplicaFiltro write FOnApplicaFiltro;
    property OnModificaTutto: TProcObject read FOnModificaTutto write FOnModificaTutto;
    property OnConfermaTutto: TProcObjectBool read FOnConfermaTutto write FOnConfermaTutto;
    property OnAnnullaTutto: TProcObject read FOnAnnullaTutto write FOnAnnullaTutto;
    property OnAutorizzaTutto: TProcObjectBool read FOnAutorizzaTutto write FOnAutorizzaTutto;
  end;

const
  SOGLIA_ELEMENTI_RIGAUNICA    = 5; // soglia oltre la quale le tipologie specifiche vengono inserite su una riga dedicata
  SOGLIA_ELEMENTI_RIGADEDICATA = 5; // soglia oltre la quale viene inserita una ulteriore riga, in presenza di riga dedicata per tipologie specifiche
  CAMBIOPERIODO_ASYNC = True;       // indica se il radiogroup del periodo deve utilizzare il metodo asincrono
  CHKSI_NAME = 'chkSi';
  CHKNO_NAME = 'chkNo';

implementation

{$R *.dfm}

procedure TR013FIterBase.IWAppFormCreate(Sender: TObject);
begin
  inherited IWAppFormCreate(Sender);

  // elementi per filtro tipologia richieste
  lblFiltroVis:=TmeIWLabel.Create(Self);
  with lblFiltroVis do
  begin
    Name:='lblFiltroVis';
    Parent:=Self;
    Caption:='Filtro richieste';
  end;
  grdFiltroVis:=TmeIWGrid.Create(Self);
  with grdFiltroVis do
  begin
    Name:='grdFiltroVis';
    Parent:=Self;
    Css:='gridTrasparente';
  end;

  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  // elementi per filtro struttura
  lblFiltroStruttura:=TmeIWLabel.Create(Self);
  with lblFiltroStruttura do
  begin
    Name:='lblFiltroStruttura';
    Parent:=Self;
    Caption:='Filtro tipologia richieste';//'Filtro struttura';
  end;

  cmbFiltroStruttura:=TmeIWComboBox.Create(Self);
  with cmbFiltroStruttura do
  begin
    Name:='cmbFiltroStruttura';
    Parent:=Self;
    ItemsHaveValues:=True;
    NoSelectionText:='';
    OnAsyncChange:=OnStrutturaAsyncChange;
    OnAsyncKeyPress:=OnStrutturaAsyncChange;
  end;
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

  // elementi per filtro periodo
  lblPeriodo:=TmeIWLabel.Create(Self);
  with lblPeriodo do
  begin
    Name:='lblPeriodo';
    Parent:=Self;
    Caption:='Periodo';
  end;
  rgpPeriodo:=TmeTIWAdvRadioGroup.Create(Self);
  with rgpPeriodo do
  begin
    Name:='rgpPeriodo';
    Parent:=Self;
    Caption:='x'; // non impostare a '' -> bug del componente TMS!!!
    Columns:=2;
    Css:='groupbox noborder nolegend width20chr'; // classe noborder nasconde il bordo del groupbox
    Items.StrictDelimiter:=True;
    Items.CommaText:='giorno precedente,dal';
    if CAMBIOPERIODO_ASYNC then
      OnAsyncClick:=OnPeriodoAsyncClick
    else
      OnClick:=OnPeriodoClick;
    Visible:=False;
  end;
  edtPeriodoDal:=TmeIWEdit.Create(Self);
  with edtPeriodoDal do
  begin
    Name:='edtPeriodoDal';
    Parent:=Self;
    Css:='input_data_dmy dal';
    Hint:='Periodo di inizio delle richieste. Formato ggmmaaaa';
    Text:='';
  end;
  lblPeriodoDal:=TmeIWLabel.Create(Self);
  with lblPeriodoDal do
  begin
    Name:='lblPeriodoDal';
    Parent:=Self;
    Caption:='dal';
    ForControl:=edtPeriodoDal;
    Hint:='Formato gg mm aaaa';
  end;
  edtPeriodoAl:=TmeIWEdit.Create(Self);
  with edtPeriodoAl do
  begin
    Name:='edtPeriodoAl';
    Parent:=Self;
    Css:='input_data_dmy al';
    Hint:='Periodo di fine delle richieste. Formato ggmmaaaa';
    Text:='';
  end;
  lblPeriodoAl:=TmeIWLabel.Create(Self);
  with lblPeriodoAl do
  begin
    Name:='lblPeriodoAl';
    Parent:=Self;
    Caption:='al';
    ForControl:=edtPeriodoAl;
    Hint:='Formato gg mm aaaa';
  end;

  chkFiltroAllegati:=TmeIWCheckBox.Create(Self);
  chkFiltroAllegati.Name:='chkFiltroAllegati';
  chkFiltroAllegati.Parent:=Self;
  chkFiltroAllegati.Caption:='Solo con allegati';
  chkFiltroAllegati.Hint:='Consente di filtrare le sole richieste con allegati';

  // applica filtri
  btnFiltra:=TmeIWButton.Create(Self);
  with btnFiltra do
  begin
    Name:='btnFiltra';
    Parent:=Self;
    Caption:='Filtra';
    OnClick:=IterBaseApplicaFiltro;
  end;

  // ### autorizzazione ###
  // modifica tutto / annulla tutto
  btnModificaTutti:=TmeIWButton.Create(Self);
  with btnModificaTutti do
  begin
    Name:='btnModificaTutti';
    Parent:=Self;
    Caption:='Modifica tutto';
    OnClick:=IterBaseModificaTutto;
    Visible:=False;
  end;
  btnAnnullaTutti:=TmeIWButton.Create(Self);
  with btnAnnullaTutti do
  begin
    Name:='btnAnnullaTutti';
    Parent:=Self;
    Caption:='Annulla tutto';
    OnClick:=IterBaseAnnullaTutto;
    Visible:=False;
  end;
  // autorizza tutto / nega tutto
  btnTuttiSi:=TmeIWButton.Create(Self);
  with btnTuttiSi do
  begin
    Name:='btnTuttiSi';
    Parent:=Self;
    Caption:='Autorizza tutto';
    Confirmation:='Autorizzare tutte le richieste?';
    OnClick:=IterBaseAutorizzaTutto;
    Visible:=False;
  end;
  btnTuttiNo:=TmeIWButton.Create(Self);
  with btnTuttiNo do
  begin
    Name:='btnTuttiNo';
    Parent:=Self;
    Caption:='Nega tutto';
    Confirmation:='Negare l''autorizzazione a tutte le richieste?';
    OnClick:=IterBaseAutorizzaTutto;
    Visible:=False;
  end;

  // inizializzazioni
  SetLength(ChkArr,0);
  FNumCheck:=0;
  FVisti:=False;
  FEditMultiplo:=False;
  FAutorizzaMultiplo:=False;
  FInModificaTutti:=False;
  FInAutorizzaTutti:=False;
  FBloccaGestione:=False;
  chkLastClicked:=nil;

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  //WC027DM:=TWC027FDocumentiManagerDM.Create(TIWAppForm(Self.Owner));
  ImgAllegati:=nil;
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

  // integra info login
  LoginInfo.ProfiloIter:=Parametri.ProfiloWEBIterAutorizzativi;
end;

procedure TR013FIterBase.IWAppFormRender(Sender: TObject);
var
  JsCode: String;
begin
  inherited;

  // mantiene la coerenza fra le richieste disponibili e selezionate di C018
  // e i checkbox presenti a video
  AggiornaFiltriVis;

  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
  // imposta via javascript le altezze dei radiogroup di filtro
  // in modo che risultino tutte uguali
  JsCode:='try { '#13#10 +
          '  var grpFiltroVisH = $("#filtroVis > div.groupbox > fieldset").height(); '#13#10 +
          '  if (grpFiltroVisH > 0) { '#13#10 +
          '    $("#filtroStruttura > div.groupbox > fieldset").height(grpFiltroVisH); '#13#10 +
          '    $("#filtroPeriodo > div.groupbox > fieldset").height(grpFiltroVisH); '#13#10 +
          '    $("#pulsantiAzione").height(grpFiltroVisH); '#13#10 +
          '  } '#13#10 +
          '} '#13#10 +
          'catch(err) { '#13#10 +
          '} '#13#10;
  if rgpPeriodo.Visible then
  begin
    // aumenta la larghezza del groupbox rispetto a quella di default
    JsCode:=JsCode + #13#10 +
            'try { '#13#10 +
            '  $("#filtroPeriodo > div.groupbox").removeClass("width30chr").addClass("width47chr");'#13#10 +
            '} '#13#10 +
            'catch(err) { '#13#10 +
            '} '#13#10;
  end;
  jqTemp.OnReady.Text:=JsCode;
  C190VisualizzaGroupBox(jqTemp,'filtroStruttura',cmbFiltroStruttura.Visible);
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

  // imposta visibilità check filtro allegati
  if C018 <> nil then
    chkFiltroAllegati.Visible:=C018.EsisteGestioneAllegati;

  // daniloc.ini - 30.08.2012
  // il problema con le region è stato parzialmente risolto:
  // abbiamo scoperto che la IWRegion è un contenitore ma solo in teoria,
  // perché ogni componente al suo interno deve essere creato
  // con Parent = IWForm (o IWFrame)
  // prima impostavamo erroneamente Parent = IWRegion

  // verifica abilitazione edit multiplo
  if FEditMultiplo then
    btnModificaTutti.Visible:=not SolaLettura;

  // verifica possibilità di autorizzazione multipla
  if FAutorizzaMultiplo then
  begin
    if C018.Iter = ITER_STRMESE then
    begin
      // caso particolare straordinario mensile
      btnTuttiSi.Visible:=(not SolaLettura) and
                          (WR000DM.Responsabile) and
                          ((trDaAutorizzare in C018.TipoRichiesteSel) or
                           (trInAutorizzazione in C018.TipoRichiesteSel) or
                           (trValidate in C018.TipoRichiesteSel));
    end
    else
    begin
      // caso normale
      btnTuttiSi.Visible:=(not SolaLettura) and
                          (WR000DM.Responsabile) and
                          (C018.TipoRichiesteSel = [trDaAutorizzare]);
    end;
    btnTuttiNo.Visible:=btnTuttiSi.Visible;
  end;
end;

procedure TR013FIterBase.Notification(AComponent: TComponent; Operation: TOperation);
var
  InChiusura: Boolean;
begin
  inherited Notification(AComponent, Operation);

  if Operation = opRemove then
  begin
    // chiusura frame allegati
    // questo evento viene richiamato anche dopo il destroy della form stessa
    // pertanto non bisogna aggiornare l'interfaccia in questo caso
    InChiusura:=GGetWebApplicationThreadVar.FindComponent(Name) = nil;
    if (not InChiusura) and (AComponent = WC026) then
    begin
      try
        // aggiorna interfaccia se gli allegati sono stati modificati
        if WC026.InfoAllegati.EsistonoModifiche then
        begin
          // imposta l'icona degli allegati
          if WC026.InfoAllegati.NumAllegati > 0 then
          begin
            // icona allegati gialla (evidenzia presenza allegati)
            ImgAllegati.ImageFile.FileName:=fileImgAllegatiHighlight;
          end
          else
          begin
            // se non sono presenti allegati
            // - se la richiesta ha gli allegati obbligatori imposta icona rossa (evidenzia obbligatorietà)
            // - altrimenti imposta icona grigia
            ImgAllegati.ImageFile.FileName:=IfThen(WC026.InfoAllegati.GestAllegati = 'O',fileImgAllegatiObblig,fileImgAllegati);
          end;
          ImgAllegati.Hint:=WC026.InfoAllegati.HintImmagine;
        end;
        WC026:=nil;

        // aggiorna visualizzazione
        //VisualizzaDipendenteCorrente;
      except
      end;
    end;
  end;
end;

procedure TR013FIterBase.DistruggiOggetti;
// distrugge gli oggetti creati a runtime
var
  i: Integer;
begin
  // componenti groupbox tipi richieste
  if chkVisto <> nil then
    FreeAndNil(chkVisto);
  if chkNoVisto <> nil then
    FreeAndNil(chkNoVisto);
  for i:=Low(ChkArr) to High(ChkArr) do
    FreeAndNil(ChkArr[i]);
  SetLength(ChkArr,0);
  FreeAndNil(grdFiltroVis);

  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  // componenti filtro struttura
  FreeAndNil(lblFiltroStruttura);
  FreeAndNil(cmbFiltroStruttura);
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

  // componenti filtro periodo
  FreeAndNil(lblPeriodo);
  FreeAndNil(rgpPeriodo);
  FreeAndNil(lblPeriodoDal);
  FreeAndNil(edtPeriodoDal);
  FreeAndNil(lblPeriodoAl);
  FreeAndNil(edtPeriodoAl);

  // filtro allegati
  FreeAndNil(chkFiltroAllegati);

  // pulsanti di azione
  FreeAndNil(btnFiltra);
  FreeAndNil(btnModificaTutti);
  FreeAndNil(btnAnnullaTutti);
  FreeAndNil(btnTuttiSi);
  FreeAndNil(btnTuttiNo);

  // distrugge datamodulo iter
  try FreeAndNil(C018); except end;
end;

procedure TR013FIterBase.mnuEsportaCsvClick(Sender: TObject);
begin
  InviaFile('Richieste.xls',grdRichieste.ToCsv);
end;

function TR013FIterBase.GetIter: String;
begin
  Result:=FIter;
end;

procedure TR013FIterBase.SetIter(const Val: String);
var
  ElemTipoRich: TTipoRichieste;
begin
  if C018 = nil then
    C018:=TC018FIterAutDM.Create(Self);
  C018.Responsabile:=WR000DM.Responsabile;
  C018.AccessoReadOnly:=SolaLettura;
  C018.Iter:=Val;

  if WR000DM.Responsabile and C018.NoAccessoAut then
    Notifica('Autorizzazione inibita','Attenzione!'#13#10'L''autorizzazione delle richieste è inibita su tutti i livelli.','',True,False,20000);

  // prepara componenti dell'interfaccia
  FNumCheck:=0;
  for ElemTipoRich in C018.TipoRichiesteDisp do
  begin
    if AddCheck(ElemTipoRich) then
      inc(FNumCheck);
  end;

  // filtro da autorizzare: se ci sono iter con AVVISO = 'S'
  // visualizza i checkbox per gestire visibilità delle richieste "con visto" / "senza visto"
  FVisti:=False;
  if WR000DM.Responsabile and C018.UtilizzoAvviso then
  begin
    // 1. checkbox "con visto"
    chkVisto:=TmeIWCheckBox.Create(Self);
    with chkVisto do
    begin
      Name:='chkVisto';
      Parent:=Self;
      Caption:='con visto';
      Checked:=True;
      OnAsyncClick:=OnVistoAsyncClick;
    end;
    // 2. checkbox "senza visto"
    chkNoVisto:=TmeIWCheckBox.Create(Self);
    with chkNoVisto do
    begin
      Name:='chkNoVisto';
      Parent:=Self;
      Caption:='senza visto';
      Checked:=True;
      OnAsyncClick:=OnVistoAsyncClick;
    end;
    FVisti:=True;
  end;

  // associa i check alle celle della grid di filtro
  DisponiFiltriVis;

  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  // prepara la combobox del filtro struttura
  PreparaFiltroStruttura;
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

  // imposta il periodo di filtro iniziale
  edtPeriodoDal.Text:=C018.Periodo.InizioStr;
  edtPeriodoAl.Text:=C018.Periodo.FineStr;

  FIter:=Val;
end;

function TR013FIterBase.GetEditMultiplo: Boolean;
begin
  Result:=FEditMultiplo;
end;

procedure TR013FIterBase.SetEditMultiplo(const Val: Boolean);
begin
  if Val = FeditMultiplo then
    Exit;

  // se la maschera era in modifica massiva, ritorna allo stato normale
  if not Val then
    InModificaTutti:=False;

  btnModificaTutti.Visible:=Val;
  FEditMultiplo:=Val;
end;

function TR013FIterBase.GetAutorizzaMultiplo: Boolean;
begin
  Result:=FAutorizzaMultiplo;
end;

procedure TR013FIterBase.SetAutorizzaMultiplo(const Val: Boolean);
begin
  if Val = FAutorizzaMultiplo then
    Exit;

  btnTuttiSi.Visible:=Val;
  btnTuttiNo.Visible:=Val;

  FAutorizzaMultiplo:=Val;
end;

procedure TR013FIterBase.DisponiFiltriVis;
// disposizione automatica dei filtri di visualizzazione su N righe
// riga 1       : tipologie standard
// riga [2..N-1]: tipologie specifiche
// {TODO: raggruppamenti di filtri}
// riga N       : visti
var
  i,r,c,contaStd,contaAltri: Integer;
  RigaUnica: Boolean;
  TempElem: TTipoRichieste;
  function GetRowCount: Integer;
  begin
    // riga dei valori standard
    Result:=1;
    // numero di righe per i valori specifici
    if not RigaUnica then
      Result:=Result + Trunc(R180Arrotonda(contaAltri / SOGLIA_ELEMENTI_RIGADEDICATA,1,'E'));
    // riga dei visti
    if FVisti then
      inc(Result);
  end;
  function GetColCount: Integer;
  begin
    if RigaUnica then
      Result:=contaStd + contaAltri
    else
      Result:=max(contaStd,min(contaAltri,SOGLIA_ELEMENTI_RIGADEDICATA));
    if FVisti then
      Result:=max(Result,2);
  end;
begin
  // in base al TipoRichiesteEsclusivo imposta il gestore del click
  //   se esclusivo -> evento sincrono
  //   se multiplo -> evento asincrono
  for i:=Low(ChkArr) to High(ChkArr) do
  begin
    if C018.TipoRichiesteEsclusivo then
    begin
      ChkArr[i].OnClick:=OnTipoRichiesteClick;
      ChkArr[i].OnAsyncClick:=nil;
    end
    else
    begin
      ChkArr[i].OnClick:=nil;
      ChkArr[i].OnAsyncClick:=OnTipoRichiesteAsyncClick;
    end;
  end;

  // conta elementi standard e specifici
  contaStd:=0;
  contaAltri:=0;
  for TempElem in C018.TipoRichiesteDisp do
  begin
    if TempElem in TIPORICHIESTE_STANDARD then
      inc(contaStd)
    else
      inc(contaAltri);
  end;

  if contaStd + contaAltri + IfThen(FVisti,1,0) = 1 then
  begin
    // una sola scelta -> nasconde la grid di visualizzazione
    grdFiltroVis.Visible:=False;
    JavascriptBottom.Add('document.getElementById("filtroVis").className = "invisibile";');
  end
  else
  begin
    // tenta di ottimizzare la disposizione dei checkbox
    // evita di creare due righe se il totale di checkbox è al di sotto di una soglia predefinita
    RigaUnica:=(contaAltri = 0) or
               (contaStd + contaAltri <= SOGLIA_ELEMENTI_RIGAUNICA);

    grdFiltroVis.RowCount:=GetRowCount;
    grdFiltroVis.ColumnCount:=GetColCount;
    r:=-1;

    // prima riga: tipologie standard
    if contaStd > 0 then
    begin
      inc(r);
      c:=0;

      // verifica caso di riga unica
      if RigaUnica then
      begin
        for TempElem in C018.TipoRichiesteDisp do
          if not (TempElem in TIPORICHIESTE_STANDARD) then
          begin
            grdFiltroVis.Cell[r,c].Control:=ChkArr[IndexOfCheck(TempElem)];
            inc(c);
          end;
      end;

      for TempElem in C018.TipoRichiesteDisp do
      begin
        if TempElem in TIPORICHIESTE_STANDARD then
        begin
          grdFiltroVis.Cell[r,c].Control:=ChkArr[IndexOfCheck(TempElem)];
          inc(c);
        end;
      end;
    end;

    // riga successiva: tipologie specifiche dell'iter
    // viene impostata se le tipologie specifiche sono più di 2
    if not RigaUnica then
    begin
      inc(r);
      c:=0;
      for TempElem in C018.TipoRichiesteDisp do
      begin
        if not (TempElem in TIPORICHIESTE_STANDARD) then
        begin
          grdFiltroVis.Cell[r,c].Control:=ChkArr[IndexOfCheck(TempElem)];
          inc(c);
          if c >= grdFiltroVis.ColumnCount then
          begin
            inc(r);
            c:=0;
          end;
        end;
      end;
    end;

    // riga successiva: visti
    if FVisti then
    begin
      inc(r);
      c:=0;
      grdFiltroVis.Cell[r,c].Control:=chkVisto;
      inc(c);
      grdFiltroVis.Cell[r,c].Control:=chkNoVisto;
    end;
  end;
end;

procedure TR013FIterBase.AggiornaFiltriVis;
// mantiene coerenti le proprietà di C018 con i checkbox dell'interfaccia
// questa procedure è richiamata nell'evento FormRender
var
  i: Integer;
  TipoRich: TTipoRichieste;
begin
  // filtro tipologia richieste
  for i:=Low(ChkArr) to High(ChkArr) do
  begin
    TipoRich:=TTipoRichieste(ChkArr[i].Tag);
    ChkArr[i].Caption:=C018.TipoRichiestaCaption[TipoRich];
    ChkArr[i].Css:='intestazione';
    ChkArr[i].Visible:=True;
    // verifica se il checkbox è tra le tipologie di richiesta disponibili
    if not (TipoRich in C018.TipoRichiesteDisp) then
    begin
      ChkArr[i].Checked:=False;
      ChkArr[i].Visible:=False;
      ChkArr[i].Css:='invisibile'; // workaround: proprietà visible non viene applicata correttamente
    end
    // se il checkbox è selezionato ma non è tra le tipologie di richiesta attualmente selezionate, lo deseleziona
    else if (ChkArr[i].Checked) and
            (not (TipoRich in C018.TipoRichiesteSel)) then
    begin
      ChkArr[i].Checked:=False;
    end
    // se il checkbox è deselezionato ma è tra le tipologie di richiesta attualmente selezionate, lo seleziona
    else if (not ChkArr[i].Checked) and
            (TipoRich in C018.TipoRichiesteSel) then
    begin
      ChkArr[i].Checked:=True;
    end;
  end;
end;

// MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
procedure TR013FIterBase.PreparaFiltroStruttura;
// prepara la combobox del filtro struttura
var
  Codice, Descrizione: String;
  VisualizzaFiltro: Boolean;
begin
  // popola la combobox con le strutture disponibili,
  // incluso l'item speciale denominato "<Tutte>"
  cmbFiltroStruttura.Items.Clear;
  for Codice in C018.StruttureDisp.Split([',']) do
  begin
    Descrizione:=VarToStr(C018.selI095.Lookup('COD_ITER',Codice,'DESCRIZIONE'));
    if Descrizione = '' then
      Descrizione:=Codice;
    cmbFiltroStruttura.Items.Add(Format('%s=%s',[Descrizione,Codice]));
  end;
  cmbFiltroStruttura.ItemIndex:=cmbFiltroStruttura.Items.IndexOfName(C018STRUTTURA_STANDARD);

  // la combobox è visibile solo se esistono N>1 strutture
  // (il controllo è > 2 perché include la struttura speciale <Tutte>)
  // IMPORTANTE: la visibilità del groupbox che contiene gli elementi di filtro è determinata sul formrender
  VisualizzaFiltro:=cmbFiltroStruttura.Items.Count > 2;
  lblFiltroStruttura.Visible:=VisualizzaFiltro;
  cmbFiltroStruttura.Visible:=VisualizzaFiltro;
end;
// MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

procedure TR013FIterBase.VisualizzaDettagli(Sender:TObject);
// visualizza i dettagli di autorizzazione della richiesta (tabella T851)
begin
  // imposta proprietà di C018
  with C018.selTabellaIter do
  begin
    C018.CodIter:=FieldByName('COD_ITER').AsString;
    C018.Id:=FieldByName('ID').AsInteger;
  end;
  C018.LeggiIterCompleto;

  // gestione particolare per la corretta gestione del free del componente
  if WC018Esiste = 1 then
  begin
    try
      FreeAndNil(TWC018FRiepilogoIterFM(WC018));
    except
    end;
  end;

  // prepara e visualizza il frame dei dettagli di autorizzazione
  WC018:=TWC018FRiepilogoIterFM.Create(Self);
  WC018Esiste:=1;
  WC018.C018:=C018;
  C018.AccessoReadOnly:=SolaLettura;//Inizializzo per successivo controllo in TWC018FRiepilogoIterFM.PutLivello
  WC018.Livello:=IfThen(WR000DM.Responsabile,C018.selTabellaIter.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,0);
  WC018.WC018Esiste:=@WC018Esiste;
  WC018.ComponenteHint:=TIWCustomControl(Sender);
  WC018.Visualizza;
end;

procedure TR013FIterBase.VisualizzaAllegati(Sender: TObject);
// visualizza i dettagli di autorizzazione della richiesta (tabella T851)
var
  AbilMod, LRichAnnullata: Boolean;
  AutDef, AbilInfo: String;
begin
  ImgAllegati:=(Sender as TmeIWImageFile);

  // imposta proprietà di C018
  C018.CodIter:=C018.selTabellaIter.FieldByName('COD_ITER').AsString;
  C018.Id:=C018.selTabellaIter.FieldByName('ID').AsInteger;
  C018.AccessoReadOnly:=SolaLettura;

  // determina se la richiesta è annullata (basandosi su tipo richiesta)
  if C018.selTabellaIter.FindField('TIPO_RICHIESTA') <> nil then
    LRichAnnullata:=C018.selTabellaIter.FieldByName('TIPO_RICHIESTA').AsString = C018TR_ANNULLATA
  else
    LRichAnnullata:=False;

  // determina abilitazione alla modifica degli allegati
  if WR000DM.Responsabile then
  begin
    // per l'autorizzatore gli allegati non sono modificabili
    AbilMod:=False;
    AbilInfo:=A000TraduzioneStringhe(A000MSG_C018_MSG_NOABIL_ALL_AUT);
  end
  else if LRichAnnullata then
  begin
    // se la richiesta è annullata gli allegati non sono modificabili
    AbilMod:=False;
    AbilInfo:=A000TraduzioneStringhe(A000MSG_C018_MSG_NOABIL_ALL_RIC_ANNULL);
  end
  else
  begin
    // per il richiedente gli allegati sono modificabili se:
    // - la richiesta non è autorizzata
    // - la richiesta è stata autorizzata definitivamente
    //   e il flag ALLEGATI_MODIFICABILI sulla struttura vale 'S'
    AutDef:=C018.selTabellaIter.FieldByName('AUTORIZZAZIONE').AsString;
    if AutDef = '' then
    begin
      // richiesta non ancora autorizzata definitivamente
      // modifica consentita
      AbilMod:=True;
      AbilInfo:=A000TraduzioneStringhe(A000MSG_C018_MSG_NOABIL_ALL_RIC_DA_AUT);
    end
    else if C018.StatoNegato(AutDef) then
    begin
      // richiesta negata
      // modifica impedita
      AbilMod:=False;
      AbilInfo:=A000TraduzioneStringhe(A000MSG_C018_MSG_NOABIL_ALL_RIC_NEG);
    end
    else if C018.StatoAutorizzato(AutDef) then
    begin
      // richiesta autorizzata definitivamente
      // valuta il flag ALLEGATI_MODIFICABILI
      // - 'S': modifica consentita
      // - 'N': modifica impedita
      AbilMod:=(C018.GetAllegatiModificabili = 'S');
      AbilInfo:=Format(A000TraduzioneStringhe(A000MSG_C018_MSG_FMT_NOABIL_ALL_RIC_AUT),
                       [IfThen(AbilMod,'consentita','impedita')]);
    end
    else
    begin
      // situazione inconsistente
      AbilMod:=False;
      AbilInfo:='';
    end;
  end;

  // gestione frame allegati
  if Assigned(WC026) then
    FreeAndNil(WC026);
  WC026:=TWC026FAllegatiIterFM.Create(Self);
  FreeNotification(WC026);
  WC026.Abilitazioni.Inserimento:=AbilMod;
  WC026.Abilitazioni.Modifica:=AbilMod;
  WC026.Abilitazioni.Cancellazione:=AbilMod;
  WC026.Abilitazioni.Info:=AbilInfo;
  WC026.C018:=C018;
  WC026.Visualizza;
end;

function TR013FIterBase.IndexOfCheck(const PTipo: TTipoRichieste): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=Low(ChkArr) to High(ChkArr) do
  begin
    if ChkArr[i].Tag = Integer(PTipo) then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

function TR013FIterBase.EsisteCheck(const PTipo: TTipoRichieste): Boolean;
// restituisce True se è già stato creato il checkbox relativo al tipo richiesta indicato
// altrimenti restituisce False
begin
  Result:=IndexOfCheck(PTipo) > -1;
end;

function TR013FIterBase.AddCheck(const PTipo: TTipoRichieste): Boolean;
// crea e aggiunge alla relativa struttura un nuovo checkbox
// per il tipo di richiesta indicato
var
  n: Integer;
begin
  if EsisteCheck(PTipo) then
    Result:=False
  else
  begin
    n:=Length(ChkArr);
    SetLength(ChkArr,n + 1);
    ChkArr[n]:=TmeIWCheckBox.Create(Self);
    with ChkArr[n] do
    begin
      Name:=C018.TipoRichiestaNome[PTipo];
      Parent:=Self;
      Caption:=C018.TipoRichiestaCaption[PTipo];
      Checked:=PTipo in C018.TipoRichiesteDefault;
      Tag:=Integer(PTipo);
      OnAsyncClick:=OnTipoRichiesteAsyncClick;
    end;
    Result:=True;
  end;
end;

procedure TR013FIterBase.GestCambioPeriodo;
var
  Abil: Boolean;
begin
  Abil:=(rgpPeriodo.ItemIndex = 1);
  AbilitazioneComponente(lblPeriodo,Abil);
  AbilitazioneComponente(lblPeriodoDal,Abil);
  AbilitazioneComponente(edtPeriodoDal,Abil);
  AbilitazioneComponente(lblPeriodoAl,Abil);
  AbilitazioneComponente(edtPeriodoAl,Abil);

  if rgpPeriodo.ItemIndex = 0 then
  begin
    edtPeriodoDal.Text:='';
    edtPeriodoAl.Text:='';
  end
  else
  begin
    edtPeriodoDal.Text:=C018.Periodo.InizioStr;
    edtPeriodoAl.Text:=C018.Periodo.FineStr;
  end;
end;

procedure TR013FIterBase.OnPeriodoClick(Sender: TObject);
begin
  GestCambioPeriodo;
end;

procedure TR013FIterBase.OnPeriodoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  GestCambioPeriodo;
end;

procedure TR013FIterBase.OnTipoRichiesteClick(Sender: TObject);
// evento di gestione del click sui checkbox
// caso di TipoRichiesteEsclusivo = True (tipo richieste singolo)
var
  i: Integer;
  Found: Boolean;
begin
  if (Sender as TmeIWCheckBox).Checked then
  begin
    // 1. tipo richieste esclusivo: comportamento dei check = radiobutton
    C018.TipoRichiesteSel:=[TTipoRichieste((Sender as TmeIWCheckBox).Tag)];
    for i:=Low(ChkArr) to High(ChkArr) do
    begin
      if (ChkArr[i].Tag <> (Sender as TmeIWCheckBox).Tag) and
         (ChkArr[i].Checked) then
      begin
        ChkArr[i].Checked:=False;
        Break;
      end;
    end;
  end
  else
  begin
    // impedisce di deselezionare tutti i checkbox
    Found:=False;
    for i:=Low(ChkArr) to High(ChkArr) do
    begin
      if (ChkArr[i].Tag <> (Sender as TmeIWCheckBox).Tag) and
         (ChkArr[i].Checked) then
      begin
        Found:=True;
        Break;
      end;
    end;
    if not Found then
    begin
      // forza la selezione del check attuale
      (Sender as TmeIWCheckBox).Checked:=True;
    end;
  end;

  // verifica se è necessaria una correzione del periodo indicato a video
  CorrezionePeriodo;

  IterBaseApplicaFiltro(nil);
end;

procedure TR013FIterBase.OnTipoRichiesteAsyncClick(Sender: TObject; EventParams: TStringList);
// evento di gestione del click su ogni checkbox
// caso di TipoRichiesteEsclusivo = False (tipo richieste multiplo)
var
  i: Integer;
  Found,Tutte: Boolean;
  TipoCheck: TTipoRichieste;
begin
  TipoCheck:=TTipoRichieste((Sender as TmeIWCheckBox).Tag);
  if (Sender as TmeIWCheckBox).Checked then
  begin
    // checkbox selezionato
    // verifica se è stato spuntato il check "Tutte"
    // oppure se sono spuntati tutti i checkbox visibili
    Tutte:=TipoCheck = trTutte;
    if not Tutte then
    begin
      Found:=False;
      for i:=Low(ChkArr) to High(ChkArr) do
      begin
        if (ChkArr[i].Tag <> Integer(trTutte)) and
           (ChkArr[i].Visible) and
           (not ChkArr[i].Checked) then
        begin
          Found:=True;
          Break;
        end;
      end;
      if not Found then
        Tutte:=True;
    end;

    if Tutte then
    begin
      // seleziona tutti i checkbox visibili
      for i:=Low(ChkArr) to High(ChkArr) do
      begin
        if ChkArr[i].Visible then
          ChkArr[i].Checked:=True;
      end;
      C018.TipoRichiesteSel:=C018.TipoRichiesteDisp;
    end
    else
    begin
      C018.TipoRichiesteSel:=C018.TipoRichiesteSel + [TipoCheck];
    end;
  end
  else
  begin
    // checkbox deselezionato
    // 1. impedisce di deselezionare l'item "Tutte" se tutti i check sono spuntati

    // impedisce di deselezionare tutti i checkbox
    Found:=False;
    for i:=Low(ChkArr) to High(ChkArr) do
    begin
      if (ChkArr[i].Tag <> (Sender as TmeIWCheckBox).Tag) and
         (ChkArr[i].Checked) then
      begin
        Found:=True;
        Break;
      end;
    end;
    // forza la selezione del checkbox cliccato in precedenza se esistente
    // oppure impedisce di deselezionare il checkbox attuale
    if not Found then
    begin
      if Assigned(chkLastClicked) then
      begin
        // tenta di forzare il click dell'ultimo check cliccato
        chkLastClicked.Checked:=True;
        // (richieste selezionate modificate)
        C018.TipoRichiesteSel:=C018.TipoRichiesteSel - [TipoCheck] + [TTipoRichieste(chkLastClicked.Tag)];
      end
      else
      begin
        // forza la selezione del check attuale
        // (richieste selezionate non modificate)
        (Sender as TmeIWCheckBox).Checked:=True;
      end;
    end
    else if TipoCheck = trTutte then
    begin
      // impedisce di deselezionare il checkbox "Tutte" se tutti gli altri checkbox
      // sono selezionati
      (Sender as TmeIWCheckBox).Checked:=True;
    end
    else
    begin
      // se necessario deseleziona il checkbox "Tutte"
      for i:=Low(ChkArr) to High(ChkArr) do
      begin
        if (ChkArr[i].Tag = Integer(trTutte)) and
           (ChkArr[i].Visible) and
           (ChkArr[i].Checked) then
        begin
          ChkArr[i].Checked:=False;
          C018.TipoRichiesteSel:=C018.TipoRichiesteSel - [trTutte];
          Break;
        end;
      end;
      C018.TipoRichiesteSel:=C018.TipoRichiesteSel - [TipoCheck];
    end;
  end;

  // salva l'ultimo check cliccato
  chkLastClicked:=(Sender as TmeIWCheckBox);

  // verifica se è necessaria una correzione del periodo indicato a video
  CorrezionePeriodo;

  // segnalazione visiva della necessità di rieffettuare il filtro
  //GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('try { $("#' + btnFiltra.HTMLName + '").effect("pulsate",{times: 3},250); } catch(err) {}');
end;

procedure TR013FITerBase.CorrezionePeriodo;
// se necessario effettua una correzione del periodo indicato a video
var
  Ieri, ValorizzaPeriodo: String;
  IsPeriodoVuoto,
  ModelloFiltriVuoto: Boolean;
begin
  ValorizzaPeriodo:='NO';

  // indica se il periodo attualmente indicato è vuoto
  IsPeriodoVuoto:=(Trim(edtPeriodoDal.Text) = '') and (Trim(edtPeriodoAl.Text) = '');

  // indica l'impostazione delle tipologie di richiesta
  // per cui  il periodo deve essere vuoto
  // inizializzazione standard: tipo richieste selezionato = da autorizzare
  ModelloFiltriVuoto:=(C018.TipoRichiesteSel = [trDaAutorizzare]);

  // gestione iter particolari
  if C018.Iter = ITER_MISSIONI then
  begin
    // iter missioni
    ModelloFiltriVuoto:=(trDaAutorizzare in C018.TipoRichiesteSel) and
                        (not (trAutorizzate in C018.TipoRichiesteSel)) and
                        (not (trNegate in C018.TipoRichiesteSel)) and
                        (not (trAnnullate in C018.TipoRichiesteSel));
  end
  else if C018.Iter = ITER_GIUSTIF then
  begin
    // iter giustificativi
    // le richieste da definire richiedono il periodo vuoto
    ModelloFiltriVuoto:=(C018.TipoRichiesteSel <= [trDaAutorizzare,trDaDefinire]);
  end
  else if C018.Iter = ITER_STRMESE then
  begin
    // iter straordinario mensile
    if WR000DM.Responsabile then
      ModelloFiltriVuoto:=(trDaAutorizzare in C018.TipoRichiesteSel) or
                          (trInAutorizzazione in C018.TipoRichiesteSel) or
                          (trValidate in C018.TipoRichiesteSel)
    else
      ModelloFiltriVuoto:=(trRichiedibili in C018.TipoRichiesteSel);
  end;

  // gestione standard
  if ModelloFiltriVuoto and (not IsPeriodoVuoto) then
  begin
    // richieste da autorizzare con periodo impostato -> propone periodo vuoto
    ValorizzaPeriodo:='VUOTO';
  end
  else if (not ModelloFiltriVuoto) and IsPeriodoVuoto then
  begin
    // richieste non da autorizzare con periodo vuoto -> propone periodo di default
    ValorizzaPeriodo:='SI';
  end;

  // applica il periodo in base all'indicazione
  if ValorizzaPeriodo = 'VUOTO' then
  begin
    // pulisce periodo solo se non è stato ridefinito manualmente
    if C018.Periodo.Tipo <> 'M' then
    begin
      edtPeriodoDal.Clear;
      edtPeriodoAl.Clear;
    end;
  end
  else if ValorizzaPeriodo = 'SI' then
  begin
    // richieste <> da autorizzare con periodo vuoto -> propone periodo di default
    if C018.PeriodoVisual.Dal = DATE_MIN {EncodeDate(1900,1,1)} then   // utilizzo costante
      edtPeriodoDal.Text:=''
    else
      edtPeriodoDal.Text:=FormatDateTime('dd/mm/yyyy',C018.PeriodoVisual.Dal);
    if C018.PeriodoVisual.Al = DATE_MAX {EncodeDate(3999,12,31)} then  // utilizzo costante
      edtPeriodoAl.Text:=''
    else
      edtPeriodoAl.Text:=FormatDateTime('dd/mm/yyyy',C018.PeriodoVisual.Al);
    C018.Periodo.Tipo:='A';
  end;

  OldPeriodoDal:=edtPeriodoDal.Text;
  OldPeriodoAl:=edtPeriodoAl.Text;

  // caso del giorno precedente
  Ieri:=FormatDateTime('dd/mm/yyyy',Date - 1);
  if (rgpPeriodo.Visible) and (edtPeriodoDal.Text = Ieri) and (edtPeriodoAl.Text = Ieri) then
  begin
    rgpPeriodo.ItemIndex:=0;
    if CAMBIOPERIODO_ASYNC then
      rgpPeriodo.OnAsyncClick(rgpPeriodo,nil)
    else
      rgpPeriodo.OnClick(rgpPeriodo);
  end;
end;

// MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
procedure TR013FIterBase.OnStrutturaAsyncChange(Sender: TObject; EventParams: TStringList);
var
  IWCmb: TmeIWComboBox;
  Elemento: String;
begin
  IWCmb:=(Sender as TmeIWComboBox);
  Elemento:=IWCmb.Items.ValueFromIndex[IWCmb.ItemIndex];
  C018.StrutturaSel:=Elemento;
end;
// MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

procedure TR013FIterBase.OnVistoAsyncClick(Sender: TObject; EventParams: TStringList);
// gestione del click sui checkbox "Con visto" e "Senza visto"
begin
  if not (Sender as TmeIWCheckBox).Checked then
  begin
    if (Sender = chkVisto) and (not chkNoVisto.Checked) then
      chkNoVisto.Checked:=True
    else if (Sender = chkNoVisto) and (not chkVisto.Checked) then
      chkVisto.Checked:=True;
  end;
  if chkVisto.Checked and chkNoVisto.Checked then
    C018.TipoVisto:=tvTutti
  else if chkVisto.Checked then
    C018.TipoVisto:=tvVisto
  else
    C018.TipoVisto:=tvNoVisto;
end;

function TR013FIterBase.GetInModificaTutti: Boolean;
begin
  Result:=FInModificaTutti;
end;

procedure TR013FIterBase.SetInModificaTutti(const Val: Boolean);
var
  i: Integer;
begin
  if Val = FInModificaTutti then
    Exit;

  // gestione pulsante
  if Val then
  begin
    btnModificaTutti.Caption:='Conferma tutto';
    btnModificaTutti.Confirmation:=IfThen(WR000DM.Responsabile,'Confermare le autorizzazioni indicate?','Confermare le modifiche effettuate nella tabella?');
    btnModificaTutti.OnClick:=IterBaseConfermaTutto;
  end
  else
  begin
    btnModificaTutti.Caption:='Modifica tutto';
    btnModificaTutti.Confirmation:='';
    btnModificaTutti.OnClick:=IterBaseModificaTutto;
  end;
  btnAnnullaTutti.Visible:=Val;

  // abilitazione combobox dipendente
  AbilitazioneComponente(cmbDipendentiDisponibili,not Val);

  // abilitazione filtri richieste
  AbilitazioneComponente(lblFiltroVis,not Val);
  for i:=Low(ChkArr) to High(ChkArr) do
    AbilitazioneComponente(ChkArr[i],not Val);

  // abilitazione checkbox "con / senza visto"
  if Assigned(chkVisto) then
    AbilitazioneComponente(chkVisto,not Val);
  if Assigned(chkNoVisto) then
    AbilitazioneComponente(chkNoVisto,not Val);

  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  // abilitazione filtro struttura
  AbilitazioneComponente(lblFiltroStruttura,not Val);
  AbilitazioneComponente(cmbFiltroStruttura,not Val);
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

  // abilitazione periodo
  if rgpPeriodo.Visible then
    AbilitazioneComponente(rgpPeriodo,not Val);
  AbilitazioneComponente(lblPeriodo,not Val);
  AbilitazioneComponente(lblPeriodoDal,not Val);
  AbilitazioneComponente(edtPeriodoDal,not Val);
  AbilitazioneComponente(lblPeriodoAl,not Val);
  AbilitazioneComponente(edtPeriodoAl,not Val);

  AbilitazioneComponente(chkFiltroAllegati,not Val);

  // abilitazione pulsante di filtro
  AbilitazioneComponente(btnFiltra,not Val);

  FInModificaTutti:=Val;
end;

function TR013FIterBase.GetInAutorizzaTutti: Boolean;
begin
  Result:=FInAutorizzaTutti;
end;

procedure TR013FIterBase.SetInAutorizzaTutti(const Val: Boolean);
begin
  FInAutorizzaTutti:=Val;
end;

function TR013FIterBase.GetBloccaGestione: Boolean;
begin
  Result:=FBloccaGestione;
end;

procedure TR013FIterBase.SetBloccaGestione(const Val: Boolean);
// abilita i componenti di filtro in base al parametro
var
  i: Integer;
begin
  if Val = FBloccaGestione then
    Exit;

  // abilitazione cambio dipendente
  AbilitazioneComponente(cmbDipendentiDisponibili,not Val);

  // abilitazione filtri richieste
  AbilitazioneComponente(lblFiltroVis,not Val);
  for i:=Low(ChkArr) to High(ChkArr) do
    AbilitazioneComponente(ChkArr[i],not Val);

  // abilitazione checkbox "con / senza visto"
  if Assigned(chkVisto) then
    AbilitazioneComponente(chkVisto,not Val);
  if Assigned(chkNoVisto) then
    AbilitazioneComponente(chkNoVisto,not Val);

  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  // abilitazione filtro struttura
  AbilitazioneComponente(lblFiltroStruttura,not Val);
  AbilitazioneComponente(cmbFiltroStruttura,not Val);
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

  // abilitazione periodo
  if Assigned(rgpPeriodo) then
    AbilitazioneComponente(rgpPeriodo,not Val);
  AbilitazioneComponente(lblPeriodo,not Val);
  AbilitazioneComponente(lblPeriodoDal,not Val);
  AbilitazioneComponente(edtPeriodoDal,not Val);
  AbilitazioneComponente(lblPeriodoAl,not Val);
  AbilitazioneComponente(edtPeriodoAl,not Val);

  // abilitazione filtro allegati
  AbilitazioneComponente(chkFiltroAllegati,not Val);

  // abilitazione pulsante di filtro
  AbilitazioneComponente(btnFiltra,not Val);

  // abilitazione pulsanti di gestione
  AbilitazioneComponente(btnTuttiSi,not Val);
  AbilitazioneComponente(btnTuttiNo,not Val);
  AbilitazioneComponente(btnModificaTutti,not Val);
  AbilitazioneComponente(btnAnnullaTutti,not Val);

  FBloccaGestione:=Val;
end;

procedure TR013FIterBase.GestioneErrore(E: Exception; const PNomeProc: String; const PFase: String = '');
// procedura comune di gestione degli errori
var
  Fase, Tipo, Msg, Err: String;
begin
  Fase:=IfThen(Trim(PFase) = '','Si è verificato un errore:','Errore in fase di ' + PFase + ':') + CRLF;
  Msg:=E.Message;
  if (RightStr(E.Message,1) <> CR) and
     (RightStr(E.Message,1) <> LF) then
    Msg:=Msg + CRLF;
  Tipo:=IfThen(E.ClassName = 'Exception','','Tipo: ' + E.ClassName + CRLF);
  Err:=Format('Maschera: %s%s%s%s%sRiferimento errore: %s.%s',
              [Title,CRLF,Fase,Msg,Tipo,medpCodiceForm,PNomeProc]);
  raise Exception.Create(Err);
end;

procedure TR013FIterBase.GetDipendentiDisponibili(Data:TDateTime);
// le selezioni anagrafiche vengono eseguite alla data finale del periodo
// di visualizzazione attualmente indicato
// se la data fine è vuota (31/12/3999) viene utilizzata la data odierna
begin
  if (Data = DATE_MAX) and
     (C018.Periodo.Fine = Data) then
  begin
    Data:=Date;
  end;
  inherited GetDipendentiDisponibili(Data);
end;

function TR013FIterBase.GetInfoFunzione: String;
var
  PeriodoStr: String;
begin
  Result:=inherited;
  if C018 <> nil then
  begin
    PeriodoStr:=C190PeriodoStr(C018.Periodo.Inizio,C018.Periodo.Fine);
    if PeriodoStr = '' then
      PeriodoStr:=A000TraduzioneStringhe(A000MSG_MSG_COMPLETO);
    Result:=Result + '<hr>' + A000TraduzioneStringhe(A000MSG_MSG_PERIODO_RICHIESTE) + ': ' + PeriodoStr;
  end;
end;

procedure TR013FIterBase.VisualizzaDipendenteCorrente;
// ridefinisce la procedura
// per impostare alcune property di default
begin
  InModificaTutti:=False;
  InAutorizzaTutti:=False;
  inherited;
end;



// ############################################################
// #########   Aggiornamento filtro visualizzazione   #########
// ############################################################
procedure TR013FIterBase.R013Open(PDataset: TDataSet; PInfoDebug: Boolean = False);
var
  T1: TDateTime;
  S,Tempo,FiltroP: String;
  L: TStringList;
  i: Integer;
begin
  try
    // informazioni di debug
    if PInfoDebug and (PDataset is TOracleDataset) then
    begin
      S:=FormatDateTime('hhhh.nn.ss',Now) + ' - filtro ' +
         IfThen(C018.TipoRichiesteEsclusivo,'esclusivo (immediato)','multiplo (async)');
      DebugAdd(S);
      DebugAdd('----');
      DebugAdd('Filtro visualizzazione:');
      DebugAdd(VarToStr(TOracleDataset(PDataset).GetVariable('FILTRO_VISUALIZZAZIONE')));
      DebugAdd('----');
      DebugAdd('Filtro struttura:');
      DebugAdd(VarToStr(TOracleDataset(PDataset).GetVariable('FILTRO_STRUTTURA')));
      DebugAdd('----');
      DebugAdd('Filtro allegati:');
      DebugAdd(VarToStr((PDataset as TOracleDataset).GetVariable('FILTRO_ALLEGATI')));
      DebugAdd('----');
      DebugAdd('Filtro periodo ' + IfThen(C018.Periodo.Tipo = 'M','manuale','automatico') + ':');
      FiltroP:=VarToStr(TOracleDataset(PDataset).GetVariable('FILTRO_PERIODO'));
      DebugAdd(IfThen(FiltroP = '<vuoto>','',FiltroP));
      DebugAdd(IfThen(PDataset.Filtered,PDataset.Name + '.Filtered = True'));
    end;

    T1:=Now;
    // apertura dataset
    PDataset.Open;
    Tempo:=FormatDateTime('ss.zzz',Now - T1);
    if PInfoDebug then
    begin
      DebugAdd('----');
      DebugAdd('Tempo esecuzione query: ' + Tempo);
    end;
    LogConsole(Format('Tempo apertura dataset %s: %s s',[PDataset.Name,Tempo]));
  except
    on E: Exception do
    begin
      if PDataset is TOracleDataset then
      begin
        // salva il testo della query errata nei messaggi delle elaborazioni (per B000)
        Log('Errore','R013Open;inizio query ' + PDataset.Name,E);
        S:=(PDataset as TOracleDataset).SubstitutedSQL;
        L:=TStringList.Create;
        try
          L.Text:=S;
          R180SplitLines(L,[' ',','],1800);
          for i:=0 to L.Count - 1 do
            Log('Errore',L[i]);
          Log('Errore','R013Open;fine query ' + PDataset.Name,E);
        finally
          FreeAndNil(L);
          GestioneErrore(E,Format('R013Open (%s)',[PDataset.Name]),'interrogazione delle richieste');
        end;
      end
      else
      begin
        Log('Errore','R013Open',E);
        GestioneErrore(E,Format('R013Open (%s)',[PDataset.Name]),'apertura elenco richieste');
      end;
    end;
  end;
end;

procedure TR013FIterBase.IterBaseApplicaFiltro(Sender: TObject);
// procedura base per la gestione del pulsante "Filtra"
var
  DalStr,AlStr: String;
  IsGiornoPrec: Boolean;
begin
  DebugClear;

  // gestione caso particolare giorno precedente
  IsGiornoPrec:=(rgpPeriodo.Visible) and (rgpPeriodo.ItemIndex = 0);
  if IsGiornoPrec then
  begin
    // caso particolare del giorno precedente
    DalStr:=DateToStr(Date - 1);
    AlStr:=DalStr;
  end
  else
  begin
    // caso normale: periodo dal.. al..
    DalStr:=edtPeriodoDal.Text;
    AlStr:=edtPeriodoAl.Text;
  end;

  // imposta il periodo manuale
  if (DalStr <> OldPeriodoDal) or
     (AlStr <> OldPeriodoAl) then
  begin
    C018.Periodo.Tipo:='M';
  end;

  // pulisce info periodo
  C018.Periodo.SetVuoto;

  // imposta inizio periodo
  try
   C018.Periodo.InizioStr:=DalStr;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(E.Message,INFORMA);
      edtPeriodoDal.SetFocus;
      Exit;
    end;
  end;

  // imposta fine periodo
  try
    C018.Periodo.FineStr:=AlStr;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(E.Message,INFORMA);
      edtPeriodoAl.SetFocus;
      Exit;
    end;
  end;

  C018.SoloRichiesteConAllegati:=(chkFiltroAllegati.Checked);

  // se indicata, esegue la funzione di filtro definita nella unit specifica
  // altrimenti esegue la procedura VisualizzaDipendenteCorrente
  if Assigned(OnApplicaFiltro) then
  begin
    try
      OnApplicaFiltro(Sender);
    except
      on E: Exception do
        GestioneErrore(E,'OnApplicaFiltro','filtro delle richieste');
    end;
  end
  else
  begin
    // comportamento standard
    VisualizzaDipendenteCorrente;
  end;
end;

// ############################################################
// ###############   Autorizzazione richieste   ###############
// ############################################################
procedure TR013FIterBase.IterBaseModificaTutto(Sender: TObject);
// porta in modifica tutte le righe per effettuare una operazione massiva
begin
  InModificaTutti:=True;

  // se indicata, esegue la funzione di filtro definita nella unit specifica
  if Assigned(OnModificaTutto) then
  begin
    try
      OnModificaTutto(Sender);
    except
      on E: Exception do
        GestioneErrore(E,'OnModificaTutto');
    end;
  end;
  //else
    //...
end;

procedure TR013FIterBase.IterBaseConfermaTutto(Sender: TObject);
// permette la conferma massiva di tutte le autorizzazioni / richieste
begin
  if Assigned(OnConfermaTutto) then
  begin
    OperazioneOK:=False;
    try
      OnConfermaTutto(Sender,OperazioneOK);
    except
      on E: Exception do
        GestioneErrore(E,'OnConfermaTutto');
    end;
  end
  else
    OperazioneOK:=True;

  if OperazioneOK then
  begin
    InModificaTutti:=False;
    VisualizzaDipendenteCorrente;
  end;
end;

procedure TR013FIterBase.IterBaseAnnullaTutto(Sender: TObject);
// procedura di annullamento della modifica massiva
begin
  // se indicata, esegue la funzione di filtro definita nella unit specifica
  if Assigned(OnAnnullaTutto) then
  begin
    try
      OnAnnullaTutto(Sender);
    except
      on E: Exception do
        GestioneErrore(E,'OnAnnullaTutto');
    end;
  end;

  InModificaTutti:=False;
end;

procedure TR013FIterBase.IterBaseAutorizzaTutto(Sender: TObject);
// permette l'autorizzazione massiva di tutte le richieste
// (gestione dei pulsanti "Autorizza tutto" e "Nega tutto")
begin
  InAutorizzaTutti:=True;

  if Assigned(OnAutorizzaTutto) then
  begin
    OperazioneOK:=False;
    try
      OnAutorizzaTutto(Sender,OperazioneOK);
    except
      on E: Exception do
        GestioneErrore(E,'OnAutorizzaTutto','autorizzazione delle richieste');
    end;
  end
  else
    OperazioneOK:=True;

  if OperazioneOK then
    VisualizzaDipendenteCorrente;
end;

end.
