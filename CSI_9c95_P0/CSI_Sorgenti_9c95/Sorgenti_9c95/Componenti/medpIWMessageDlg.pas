unit medpIWMessageDlg;

interface

uses
  C190FunzioniGeneraliWeb,
  SysUtils, Classes, IWAppForm, IWControl, IWCompButton, IWFont, IWTypes,
  Controls, Graphics, TypInfo, IWForm, IWCompJQueryWidget,
  meIWGrid, meIWButton, IWCompExtCtrls;

type
  TmeIWMsgDlgType = (mtWarning, mtError, mtInformation, mtConfirmation, mtCustom);
  TmeIWMsgDlgBtn = (mbOK, mbCancel, mbIgnore, mbRetry, mbAbort, mbYes, mbNo, mbAll, mbNoToAll, mbYesToAll);
  TmeIWMsgDlgBtns = set of TmeIWMsgDlgBtn;
  TmeIWModalResult = Low(Integer)..High(Integer); //(mrNone, mrOK, mrCancel, mrAbort, mrRetry, mrIgnore, mrYes, mrNo, mrAll, mrNoToAll, mrYesToAll);
  TmeIWModalResultEvent = procedure(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String) of object;
  TmeIWMessage = record
    Text: String;
    Tipo: TmeIWMsgDlgType;
    Title: String;
    Buttons: TmeIWMsgDlgBtns;
    OnResult: TmeIWModalResultEvent;
  end;
  TMBElementText = class(TPersistent)
  private
    FBtnTxtNo,
    FBtnTxtOK,
    FBtnTxtAbort,
    FBtnTxtYesToAll,
    FBtnTxtRetry,
    FBtnTxtAll,
    FBtnTxtCancel,
    FBtnTxtYes,
    FBtnTxtNoToAll,
    FBtnTxtIgnore: String;
  public
  published
    property BtnTxtOK: String read FBtnTxtOK write FBtnTxtOK;
    property BtnTxtCancel: String read FBtnTxtCancel write FBtnTxtCancel;
    property BtnTxtAbort: String read FBtnTxtAbort write FBtnTxtAbort;
    property BtnTxtRetry: String read FBtnTxtRetry write FBtnTxtRetry;
    property BtnTxtIgnore: String read FBtnTxtIgnore write FBtnTxtIgnore;
    property BtnTxtYes: String read FBtnTxtYes write FBtnTxtYes;
    property BtnTxtNo: String read FBtnTxtNo write FBtnTxtNo;
    property BtnTxtAll: String read FBtnTxtAll write FBtnTxtAll;
    property BtnTxtNoToAll: String read FBtnTxtNoToAll write FBtnTxtNoToAll;
    property BtnTxtYesToAll: String read FBtnTxtYesToAll write FBtnTxtYesToAll;
  end;

  TmedpIWMessageDlg = class(TComponent)
  private
    FTitle,
    FText: String;
    FModalResult: TmeIWModalResult;
    FOnResult: TmeIWModalResultEvent;
    FButtons: TmeIWMsgDlgBtns;
    FDlgType: TmeIWMsgDlgType;
    FDefButton: TmeIWMsgDlgBtn;
    FTextIsHTML: Boolean;
    FKeyID: String;
    lstControlli:TStringList;
    jqMsg: TIWJQueryWidget;
    procedure SetDlgType(const Value: TmeIWMsgDlgType);
    function ContaPulsanti: Integer;
    procedure Execute;
    function LarghezzaFinestra(Msg: String): Integer;
  protected
    FActive: Boolean;
    FElementText: TMBElementText;
    MultipleMessages: Array of TmeIWMessage;
    currentMessage:Integer;
    procedure Loaded; override;
    procedure DoResultNotify;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function  WebMessageDlg(const PMessaggio: String; PDlgType: TmeIWMsgDlgType;
      PButtons: TmeIWMsgDlgBtns; POnResult: TmeIWModalResultEvent; const PKeyID: String;
      const PTitle: String = ''; const PDefButton: TmeIWMsgDlgBtn = mbOk): TmeIWModalResult;
    function  MessageBox(const PMessaggio: String; const PTipo: String;
      const PTitolo: String = ''; const PKeyID: String = ''): TmeIWModalResult;
    procedure ShowMessages();
    procedure AddMessage(PText: String; const PTipo: TmeIWMsgDlgType = mtInformation; const Buttons: TmeIWMsgDlgBtns = [mbOk]; const OnResult: TmeIWModalResultEvent =nil; const Title: String = '');
    function  KeyValue(const PKeyID: String): TmeIWModalResult;
    function  KeyExists(const PKeyID: String): Boolean;
    procedure ClearKeys;
    property  ModalResult: TmeIWModalResult read FModalResult write FModalResult;
  published
    property Title: String read FTitle write FTitle;
    property Text: String read FText write FText;
    property Buttons: TmeIWMsgDlgBtns read FButtons write FButtons;
    property DefButton: TmeIWMsgDlgBtn read FDefButton write FDefButton;
    property DlgType: TmeIWMsgDlgType read FDlgType write SetDlgType;
    property OnResult: TmeIWModalResultEvent read FOnResult write FOnResult;
    property TextIsHTML: Boolean read FTextIsHTML write FTextIsHTML;
    property ElementText: TMBElementText read FElementText write FElementText;
    property IsActive: Boolean read FActive;
  end;

  TmeIWGridMessaggio = class(TmeIWGrid)
    grdPulsanti: TmeIWGrid;
    btn1: TmeIWButton;
    btn2: TmeIWButton;
    btn3: TmeIWButton;
    btn4: TmeIWButton;
    procedure btnClick(Sender: TObject);
  private
    FBtnIndex: Integer;
    FBtnDefault: TmeIWButton;
  public
    DlgComponent: TmedpIWMessageDlg;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure AddButton(const PCaption: String; const PDefault: Boolean);
    function  GetDefaultButton: TmeIWButton;
  end;

const
  GRD_MSGBOX_NAME = 'medpMsgContainer';

implementation

uses IWApplication, A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali,WR010UBase;

constructor TmedpIWMessageDlg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if Assigned(AOwner) and (not (AOwner is TWR010FBase)) then
    raise Exception.Create('IWMessageDlg: questo componente può essere utilizzato solo in un form di tipo TWR010FBase!');

  setLength(MultipleMessages,0);
  currentMessage:=0;

  // imposta proprietà iniziali
  FActive:=False;

  // caption pulsanti dialog
  FElementText:=TMBElementText.Create;
  FElementText.FBtnTxtOK:=A000TraduzioneStringhe(A000MSG_MSG_OK);
  FElementText.FBtnTxtCancel:=A000TraduzioneStringhe(A000MSG_MSG_ANNULLA);
  FElementText.FBtnTxtAbort:=A000TraduzioneStringhe(A000MSG_MSG_TERMINA);
  FElementText.FBtnTxtRetry:=A000TraduzioneStringhe(A000MSG_MSG_RIPROVA);
  FElementText.FBtnTxtIgnore:=A000TraduzioneStringhe(A000MSG_MSG_IGNORA);
  FElementText.FBtnTxtYes:=A000TraduzioneStringhe(A000MSG_MSG_SI);
  FElementText.FBtnTxtNo:=A000TraduzioneStringhe(A000MSG_MSG_NO);
  FElementText.FBtnTxtAll:=A000TraduzioneStringhe(A000MSG_MSG_TUTTI);
  FElementText.FBtnTxtNoToAll:=A000TraduzioneStringhe(A000MSG_MSG_NOTUTTI);
  FElementText.FBtnTxtYesToAll:=A000TraduzioneStringhe(A000MSG_MSG_SITUTTI);

  // impostazioni di default del dialog
  DlgType:=mtCustom;
  FButtons:=[mbYes,mbNo];
  FDefButton:=mbNo;

  // dati di supporto
  jQMsg:=TIWJQueryWidget.Create(AOwner);
  lstControlli:=TStringList.Create;
end;

destructor TmedpIWMessageDlg.Destroy;
begin
  FreeAndNil(FElementText);
  FreeAndNil(lstControlli);
  FreeAndNil(jQMsg);
  setLength(MultipleMessages,0);
  inherited Destroy;
end;

procedure TmedpIWMessageDlg.Loaded;
begin
  inherited;
end;

procedure TmedpIWMessageDlg.SetDlgType(const Value: TmeIWMsgDlgType);
begin
  FDlgType:=Value;

  // imposta il titolo di default in base al tipo di dialog indicato
  if FTitle = '' then
  begin
    case FDlgType of
      mtWarning:       FTitle:=A000TraduzioneStringhe(A000MSG_MSG_AVVISO);
      mtError:         FTitle:=A000TraduzioneStringhe(A000MSG_MSG_ERRORE);
      mtInformation:   FTitle:=A000TraduzioneStringhe(A000MSG_MSG_INFORMAZIONE);
      mtConfirmation:  FTitle:=A000TraduzioneStringhe(A000MSG_MSG_CONFERMA);
    else
    end;
  end;
end;

function TmedpIWMessageDlg.ContaPulsanti: Integer;
// restituisce il numero di pulsanti attualmente presenti
var
  Element: TmeIWMsgDlgBtn;
begin
  Result:=0;
  for Element:=Low(TmeIWMsgDlgBtn) to High(TmeIWMsgDlgBtn) do
  begin
    if Element in Buttons then
      Result:=Result + 1;
  end;
end;

procedure TmedpIWMessageDlg.Execute;
var
  grd: TmeIWGridMessaggio;
  CodOpen: String;
begin
  if FActive then
    raise Exception.Create('MessageBox già attivo!');
  grd:=TmeIWGridMessaggio.Create((Owner as TIWAppForm));
  with grd do
  begin
    Name:=GRD_MSGBOX_NAME;
    DlgComponent:=Self;

    // testo messaggio
    Cell[0,0].RawText:=TextIsHTML;
    //if TextIsHTML then
    //  Cell[0,0].Text:=grd.TextToHTML(FText,True,False)
    //else
      Cell[0,0].Text:=FText;

    // icona tipo messaggio
    case FDlgType of
      mtWarning:       Cell[0,0].Css:='medpMsg warning';
      mtError:         Cell[0,0].Css:='medpMsg error';
      mtInformation:   Cell[0,0].Css:='medpMsg information';
      mtConfirmation:  Cell[0,0].Css:='medpMsg confirmation';
      //mtCustom:        if FCustomImageURL <> '' then
      //                   imgIcon.ImageFile.URL:=FCustomImageURL;
      else;
    end;

    // l'aggiunta dei pulsanti è ordinata come in win
    // (si noti che AddButton è chiamata in ordine inverso)
    if mbIgnore in FButtons then
      AddButton(FElementText.FBtnTxtIgnore,mbIgnore = FDefButton);
    if mbAbort in FButtons then
      AddButton(FElementText.FBtnTxtAbort,mbAbort = FDefButton);
    if mbRetry in FButtons then
      AddButton(FElementText.FBtnTxtRetry,mbRetry = FDefButton);
    if mbCancel in FButtons then
      AddButton(FElementText.FBtnTxtCancel,mbCancel = FDefButton);
    if mbNo in FButtons then
      AddButton(FElementText.FBtnTxtNo,mbNo = FDefButton);
    if mbNoToAll in FButtons then
      AddButton(FElementText.FBtnTxtNoToAll,mbNoToAll = FDefButton);
    if mbAll in FButtons then
      AddButton(FElementText.FBtnTxtAll,mbAll = FDefButton);
    if mbYesToAll in FButtons then
      AddButton(FElementText.FBtnTxtYesToAll,mbYesToAll = FDefButton);
    if mbYes in FButtons then
      AddButton(FElementText.FBtnTxtYes,mbYes = FDefButton);
    if mbOK in FButtons then
      AddButton(FElementText.FBtnTxtOk,mbOK = FDefButton);

    Visible:=True;

    // pulsante di default
    // il SetFocus di intraweb non funziona (il codice generato è giusto a dire il vero,
    // ma la modal dialog jquery ui fa qualche scherzo...
    // come metodi alternativi ho provato il focus nella open della dialog,
    // ma non funziona perché poi in qualche modo viene scavalcato (lo prende e lo perde subito)...
    // allora si utilizza il metodo html5 con attributo autofocus
    // che fatica.. se qualcuno trova un metodo migliore e retrocompatibile lo usi!
    if GetDefaultButton = nil then
      CodOpen:=''
    else
    begin
      //CoddOpen:=Format('$("#%s").focus(); ',[GetDefaultButton.HTMLName]); // non va
      CodOpen:=Format('$("#%s").attr("autofocus","autofocus"); ',[GetDefaultButton.HTMLName]);
    end;

    // visualizza messagebox
    (*Massimo 25/10/2013 Gestione larghezza dinamica del messaggio
    (Self.Owner as TWR010FBase).VisualizzaJQMessaggio(jQMsg,400,-1,EM2PIXEL * 30,FTitle,'#msgDialog',False,True,-1,'',CodOpen);
    *)
    (Self.Owner as TWR010FBase).VisualizzaJQMessaggio(jQMsg,LarghezzaFinestra(FText),-1,EM2PIXEL * 30,FTitle,'#msgDialog',False,True,-1,'',CodOpen);
   end;
  FActive:=True;
end;

function TmedpIWMessageDlg.LarghezzaFinestra(Msg: String):Integer;
var widthMsg: Integer;
const
  MIN_WIDTH: Integer = 400;
  MAX_WIDTH: Integer = 550;
  IMG_WIDTH: Integer = 100;
begin
  widthMsg:=(Length(Msg)*2) + IMG_WIDTH;
  Result:=widthMsg;
  if widthMsg > MAX_WIDTH then
    Result:=MAX_WIDTH
  else if widthMsg < MIN_WIDTH then
    Result:=MIN_WIDTH
end;

// dialog per messagebox
function TmedpIWMessageDlg.WebMessageDlg(const PMessaggio: String; PDlgType: TmeIWMsgDlgType;
  PButtons: TmeIWMsgDlgBtns; POnResult: TmeIWModalResultEvent; const PKeyID: String;
  const PTitle: String = ''; const PDefButton: TmeIWMsgDlgBtn = mbOk): TmeIWModalResult;
begin
  if PButtons = [] then
    raise Exception.Create('IWMessageDlg: specificare almeno un pulsante di azione!');
  if ContaPulsanti > 4 then
    raise Exception.Create('IWMessageDlg: specificare al massimo 4 pulsanti di azione!');
  Self.Title:=PTitle;
  Self.Text:=PMessaggio;
  Self.DlgType:=PDlgType;
  Self.Buttons:=PButtons;
  Self.DefButton:=PDefButton;
  Self.OnResult:=POnResult;
  Self.FKeyID:=PKeyID;
  Self.Execute;

  if ThreadElaborazione <> nil then
  begin
    if ThreadElaborazione.Stato = teTimeout then
      raise EThreadElaborazioneException.Create('impossibile visualizzare messaggio: timeout!');
    
    // sospende il thread in attesa dell'utente
    ThreadElaborazione.MedpSuspend;

    // una volta che il thread è ripreso, restituisce la risposta dell'utente
    // (disponibile nella corrispondente property del thread)
    Result:=ThreadElaborazione.RispostaMsg;
  end
  else
  begin
    Result:=mrNone;
  end;
end;

function TmedpIWMessageDlg.MessageBox(const PMessaggio: String; const PTipo: String;
  const PTitolo: String = ''; const PKeyID: String = ''): TmeIWModalResult;
// shortcut per procedura WebMessageDlg
// cfr. C180FunzioniGenerali - procedure R180MessageBox
var
  // dettagli dialog
  LDlgType: TmeIWMsgDlgType;
  LButtons: TmeIWMsgDlgBtns;
  LDefaultBtn: TmeIWMsgDlgBtn;
  // variabili di supporto per controllo messaggio web
  Element: medpIWMessageDlg.TmeIWMsgDlgBtn;
  NumBtn: Integer;
begin
  if PTipo = INFORMA then
  begin
    // icona info + pulsante OK
    LDlgType:=mtInformation;
    LButtons:=[mbOK];
    LDefaultBtn:=mbOK;
  end
  else if PTipo = ESCLAMA then
  begin
    // icona warning + pulsante OK
    LDlgType:=mtWarning;
    LButtons:=[mbOK];
    LDefaultBtn:=mbOK;
  end
  else if PTipo = ERRORE then
  begin
    // icona errore + pulsante OK
    LDlgType:=mtError;
    LButtons:=[mbOK];
    LDefaultBtn:=mbOK;
  end
  else if PTipo = DOMANDA then
  begin
    // icona question + pulsanti Si, No
    LDlgType:=mtConfirmation;
    LButtons:=[mbYes,mbNo];
    LDefaultBtn:=mbNo;
  end
  else if PTipo = DOMANDA_ESCI then
  begin
    // icona question + pulsanti Si, No, Annulla
    LDlgType:=mtConfirmation;
    LButtons:=[mbYes,mbNo,mbCancel];
    LDefaultBtn:=mbCancel;
  end
  else if PTipo = ERR_ELAB_CONTINUA then
  begin
    // icona warning  + pulsanti Si, No, Termina
    LDlgType:=mtWarning;
    LButtons:=[mbYes,mbNo,mbAbort];
    LDefaultBtn:=mbNo;
  end
  else if PTipo = ERR_ELAB_STOP then
  begin
    // icona warning  + pulsanti Ignora, Termina then
    LDlgType:=mtWarning;
    LButtons:=[mbIgnore,mbAbort];
    LDefaultBtn:=mbIgnore;
  end
  else
    raise Exception.Create('IWMessageDlg: parametri errati per la funzione MessageBox.');

  // se l'elaborazione non è su thread separato ma l'interazione prevede
  // scelte multiple solleva un'eccezione
  // (non sarebbe gestibile)
  if ThreadElaborazione = nil then
  begin
    NumBtn:=0;
    for Element:=Low(TmeIWMsgDlgBtn) to High(TmeIWMsgDlgBtn) do
    begin
      if Element in LButtons then
      begin
        inc(NumBtn);
        // la discriminante è che i pulsanti siano 1 oppure > 1
        if NumBtn > 1 then
          Break;
      end;
    end;
    if NumBtn > 1 then
      raise Exception.Create(Format('IWMessageDlg: MessageBox non utilizzabile con scelte multiple fuori dal contesto del thread di elaborazione separato',[PTipo]));
  end;

  // messagebox bloccante per web
  Result:=MsgBox.WebMessageDlg(PMessaggio,LDlgType,LButtons,nil,PKeyID,PTitolo,LDefaultBtn);
end;

procedure TmedpIWMessageDlg.ShowMessages;
begin
  if currentMessage = Length(MultipleMessages) then
  begin
    //fine messaggi
    currentMessage:=0;
    SetLength(MultipleMessages,0);
  end
  else
  begin
    with MultipleMessages[currentMessage] do
    begin
      WebMessageDlg(Text,Tipo,Buttons,OnResult,'',Title);
    end;
    currentMessage:=currentMessage + 1;
  end;
end;

procedure TmedpIWMessageDlg.DoResultNotify;
var
  ResStr: String;
begin
  // ResStr è la rappresentazione in formato string del modalresult (es. "mrYes")
  // che viene salvata nell'array di supporto
  ResStr:=GetEnumName(TypeInfo(TmeIWModalResult),Integer(FModalResult)) ;

  lstControlli.Values[FKeyID]:=ResStr;
  jQMsg.OnReady.Clear;
  if Assigned(FOnResult) then
  begin
    // TODO: in caso di errore cosa è meglio fare?
    try
      FOnResult(Self,FModalResult,FKeyID);
    except
      on E: EAbort do;
      on E: Exception do
        raise;
    end;
  end;

  //Gestione messaggi multipli
  if Length(MultipleMessages) > 0 then
    ShowMessages;
end;

function TmedpIWMessageDlg.KeyValue(const PKeyID: String): TmeIWModalResult;
// questa funzione restituisce il valore del keyid indicato
var
  SRes: String;
begin
  if lstControlli.IndexOfName(PKeyID) < 0 then
    Result:=mrNone
  else
  begin
    SRes:=lstControlli.Values[PKeyID];
    Result:=TmeIWModalResult(GetEnumValue(TypeInfo(TmeIWModalResult),SRes));
  end;
end;

function TmedpIWMessageDlg.KeyExists(const PKeyID: String): Boolean;
// questa funzione verifica se il keyid indicato è presente nella lista di controlli,
// restituisce:
//   True  se la condizione è verificata
//   False altrimenti
begin
  Result:=(lstControlli.IndexOfName(PKeyID) >= 0);
end;

procedure TmedpIWMessageDlg.AddMessage(PText: String; const PTipo: TmeIWMsgDlgType = mtInformation; const Buttons: TmeIWMsgDlgBtns = [mbOk]; const OnResult: TmeIWModalResultEvent =nil;const Title: String = '');
var
  i: Integer;
begin
  i:=Length(MultipleMessages);
  setLength(MultipleMessages,i + 1);

  MultipleMessages[i].Text:=PText;
  MultipleMessages[i].Tipo:=PTipo;
  MultipleMessages[i].Title:=Title;
  MultipleMessages[i].Buttons:=Buttons;
  MultipleMessages[i].OnResult:=OnResult;
end;

procedure TmedpIWMessageDlg.ClearKeys;
// pulisce la lista di controlli effettuati (chiavi)
begin
  lstControlli.Clear;
end;

// ********************************************************************** //
// *                           Grid Messaggio                           * //
// ********************************************************************** //
constructor TmeIWGridMessaggio.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // proprietà grid
  Parent:=(Owner as TIWAppForm);
  BorderSize:=0;
  ColumnCount:=4;
  RowCount:=2;
  Css:='msgDialogMain';
  Cursor:=crAuto;
  UseFrame:=True;

  // prepara i componenti che definiscono il "messagebox"
  // 1. testo messaggio
  with Cell[0,0] do
  begin
    Css:='msgDialogTesto';
    Wrap:=True;
    RawText:=True;
  end;

  // 2: pulsanti di interazione
  FBtnIndex:=0;
  grdPulsanti:=TmeIWGrid.Create(Self);
  with grdPulsanti do
  begin
    // imposta proprietà tabella pulsanti
    Name:='grdPulsanti';
    Parent:=Self.Parent; //***
    FriendlyName:='grdPulsanti';
    RowCount:=1;
    ColumnCount:=4;
    Css:='msgDialogComandiTab';
    Visible:=True;
  end;

  // inizializza puntatore a pulsante di default
  FBtnDefault:=nil;

  // crea pulsanti di interazione
  btn1:=TmeIWButton.Create(Self);
  btn1.Parent:=Self.Parent;
  btn1.Css:='pulsante msgDialogPulsante';
  btn1.OnClick:=btnClick;

  btn2:=TmeIWButton.Create(Self);
  btn2.Parent:=Self.Parent;
  btn2.Css:='pulsante msgDialogPulsante';
  btn2.OnClick:=btnClick;

  btn3:=TmeIWButton.Create(Self);
  btn3.Parent:=Self.Parent;
  btn3.Css:='pulsante msgDialogPulsante';
  btn3.OnClick:=btnClick;

  btn4:=TmeIWButton.Create(Self);
  btn4.Parent:=Self.Parent;
  btn4.Css:='pulsante msgDialogPulsante';
  btn4.OnClick:=btnClick;

  // riga per i pulsanti
  with Cell[1,0] do
  begin
    Control:=grdPulsanti;
    Cell[1,0].Css:='msgDialogComandi';
    RawText:=True;
    Text:='<hr class="gradiente">';
  end;
end;

destructor TmeIWGridMessaggio.Destroy;
// distrugge il componente, fatta eccezione per DlgComponent
// che rappresenta il puntatore al componente TmedpIWMessageDlg
// (la sua distruzione è delegata alla classe TmedpIWMessageDlg)
begin
  FreeAndNil(grdPulsanti);
  inherited Destroy;
  DlgComponent.FActive:=False;
end;

function TmeIWGridMessaggio.GetDefaultButton: TmeIWButton;
// restituisce il button di default attualmente impostato
begin
  Result:=FBtnDefault;
end;

procedure TmeIWGridMessaggio.AddButton(const PCaption: String; const PDefault: Boolean);
var
  btn: TmeIWButton;
  j: Integer;
begin
  FBtnIndex:=FBtnIndex + 1;
  case FBtnIndex of
    1: btn:=btn1;
    2: btn:=btn2;
    3: btn:=btn3;
    4: btn:=btn4;
    else
      Exit;
  end;
  btn.Caption:=PCaption;
  btn.Visible:=True;
  if PDefault then
  begin
    FBtnDefault:=btn;
  end;
  grdPulsanti.Cell[0,grdPulsanti.ColumnCount - FBtnIndex].Control:=btn;

  // imposta dimensione celle
  with grdPulsanti do
  begin
    for j:=0 to grdPulsanti.ColumnCount - 1 do
    begin
      Cell[0,j].Css:='';
      Cell[0,j].Width:='0';
    end;

    case FBtnIndex of
      1: begin
           Cell[0,3].Css:='cellaCentrale';
         end;
      2: begin
           Cell[0,2].Css:='cellaSx';
           Cell[0,3].Css:='cellaDx';
         end;
      3: begin
           Cell[0,1].Width:='45%';
           Cell[0,1].Css:='align_right';
           Cell[0,2].Width:='19%';
           Cell[0,2].Css:='align_center';
           Cell[0,3].Width:='35%';
           Cell[0,3].Css:='align_left';
         end;
      4: begin
           Cell[0,0].Width:='25%';
           Cell[0,0].Css:='align_right';
           Cell[0,1].Width:='25%';
           Cell[0,1].Css:='align_center';
           Cell[0,2].Width:='25%';
           Cell[0,2].Css:='align_center';
           Cell[0,3].Width:='25%';
           Cell[0,3].Css:='align_left';
         end;
    else
    end;
  end;
end;

procedure TmeIWGridMessaggio.btnClick(Sender: TObject);
var
  BtnTxt: String;
begin
  // salva la caption del pulsante premuto per il confronto
  BtnTxt:=(Sender as TmeIWButton).Caption;

  // determina il modal result
  if BtnTxt = DlgComponent.FElementText.BtnTxtOk then
    DlgComponent.ModalResult:=mrOK
  else if BtnTxt = DlgComponent.FElementText.BtnTxtCancel then
    DlgComponent.ModalResult:=mrCancel
  else if BtnTxt = DlgComponent.FElementText.BtnTxtAbort then
    DlgComponent.ModalResult:=mrAbort
  else if BtnTxt = DlgComponent.FElementText.BtnTxtRetry then
    DlgComponent.ModalResult:=mrRetry
  else if BtnTxt = DlgComponent.FElementText.BtnTxtIgnore then
    DlgComponent.ModalResult:=mrIgnore
  else if BtnTxt = DlgComponent.FElementText.BtnTxtYes then
    DlgComponent.ModalResult:=mrYes
  else if BtnTxt = DlgComponent.FElementText.BtnTxtNo then
    DlgComponent.ModalResult:=mrNo
  else if BtnTxt = DlgComponent.FElementText.BtnTxtAll then
    DlgComponent.ModalResult:=mrAll
  else if BtnTxt = DlgComponent.FElementText.BtnTxtNoToAll then
    DlgComponent.ModalResult:=mrNoToAll
  else if BtnTxt = DlgComponent.FElementText.BtnTxtYesToAll then
    DlgComponent.ModalResult:=mrYesToAll
  else
    DlgComponent.ModalResult:=mrNone;

  // distrugge grid
  Free;

  // notifica risultato
  DlgComponent.DoResultNotify;

  // gestione messagebox con thread elaborazione separato
  if ThreadElaborazione <> nil then
  begin
    ThreadElaborazione.RispostaMsg:=DlgComponent.ModalResult;
    GestioneThreadElaborazione;
  end;
end;

end.
