unit C190FunzioniGeneraliWeb;

interface

uses
  SysUtils, StrUtils, Math, Classes, Controls, IWDBGrids, Windows, PsAPI,
  IWCompGrids, IWControl, IWCompExtCtrls, IWCompJQueryWidget,
  IWCompListbox,IWCompGridCommon,IWCompCheckbox,IWCompEdit,
  IWTypes,IWAppForm,IWCompLabel,IWBaseHTMLControl,IWApplication,
  IWCompMemo,
  {$IFNDEF WEBSVC}
  meTIWAdvRadioGroup, meTIWAdvCheckGroup, meIWLabel, meIWLink, meIWEdit, meIWComboBox, medpIWTabControl,
  meIWCheckBox, meIWMemo, meIWImageFile, meIWButton, meIWFileUploader, meIWText,MedpIWMultiColumnComboBox,DBXJSON,
  meIWRadioGroup, meIWGrid, OracleData,
  {$ENDIF}
  ActnList, Db, A000UCostanti, C180FunzioniGenerali, System.JSON;

type
  TProcPaginazione = procedure(DBG_ROWID:String = '') of object;

const
  // pulsanti della sezione di intestazione
  filebtnIndietro           = 'img\btnIndietro.png';
  filebtnChiudiSchede       = 'img\btnChiudiSchede.png';
  filebtnEsci               = 'img\btnEsci.png';
  filebtnIC                 = 'img\btnIC.png';
  filebtnIW                 = 'img\btnIW.png';
  filebtnInfoCookies        = 'img\btnInfoCookies.png';
  filebtnHelp               = 'img\btnHelp.png';
  filebtnSceltaRapida       = 'img\btnSceltaRapida.png';

  // navigatorbar per le tabelle
  filebtnPrimo              = 'img\btnPrimo.png';
  filebtnPrimoDisab         = 'img\btnPrimo_Disabled.png';
  filebtnPrec               = 'img\btnPrecedente.png';
  filebtnPrecDisab          = 'img\btnPrecedente_Disabled.png';
  filebtnSucc               = 'img\btnSuccessivo.png';
  filebtnSuccDisab          = 'img\btnSuccessivo_Disabled.png';
  filebtnUltimo             = 'img\btnUltimo.png';
  filebtnUltimoDisab        = 'img\btnUltimo_Disabled.png';

  // pulsanti di azione per le tabelle
  fileImgInserisci          = 'img\btnInserisci2.png';
  fileImgModifica           = 'img\btnModifica2.png';
  fileImgCancella           = 'img\btnElimina2.png';
  fileImgConferma           = 'img\btnConferma2.png';
  fileImgAnnulla            = 'img\btnAnnulla2.png';
  fileImgStampa             = 'img\btnStampa22.png';
  fileImgSalva              = 'img\btnSalva2.png';
  fileImgDefinisci          = 'img\btnDefinisci2.png';
  fileImgRevoca             = 'img\btnRevoca2.png';
  fileImgCancPeriodo        = 'img\btnCancPeriodo.png';
  fileImgRefresh            = 'img\btnAggiorna2.png';
  fileImgSchedaAnagrafica   = 'img\btnSchedaAnagrafica2.png';
  fileImgCambiaDato         = 'img\btnCambiaDatoGriglia.png';
  fileImgDuplica            = 'img\btnCopia2.png';
  fileImgInvisibile         = 'img\space.gif';
  fileImgDettaglio          = 'img\btnConteggi2.png';
  fileImgElenco             = 'img\btnElenco2.png';
  fileImgAllegati           = 'img\btnAttachment2.png';
  fileImgAllegatiHighlight  = 'img\btnAttachment2Highlight.png';
  fileImgAllegatiObblig     = 'img\btnAttachment2Obblig.png';
  fileImgElencoHighlight    = 'img\btnElenco2Highlight.png';
  fileImgAccedi             = 'img\btnAccedi2.png';
  fileImgSelAnagrafe        = 'img\btnC700SelezioneAnagrafe2.png';
  fileImgPuntini            = 'img\btnPuntini.png';
  fileImgInvia              = 'img\btnInviaMessaggio2.png';
  fileImgOperatori          = 'img\btnOperatori.png';
  fileImgOperatoriDisab     = 'img\btnOperatori_Disabled.png';
  fileImgBloccaRiepiloghi   = 'img\btnBloccaRiepiloghi.png';
  fileImgSbloccaRiepiloghi  = 'img\btnSbloccaRiepiloghi.png';
  fileImgImporta            = 'img\btnImport.png';
  fileImgRiapri             = 'img\btnRiapri.png';

  // icone per treeview
  fileImgFolderClosed       = 'img\folder_closed.png';
  fileImgFolderOpen         = 'img\folder_open.png';

  // selezione anagrafica
  FILTRO_IN_SERVIZIO = 'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO)';
  FILTRO_IN_SERVIZIO_PERIODICA = 'AND :DATALAVORO >= T430INIZIO AND :DATADAL <= NVL(LAST_DAY(T430FINE),:DATADAL)';

  EM2PIXEL = 16;

  // formattazione per i nomi degli elementi di ogni riga
  // (es. 'chkSi001', 'chkSi002')
  ROW_ELEM_INDEX_LENGTH     = 3;        // numero di cifre che compongono l'indice dell'elemento (001, 002, ...)
  ROW_ELEM_NAME_FMT         = '%s%.3d'; // formato nomi impostati al volo (ricopiare la cifra sopra)

  //CDATATag = '<![CDATA[%s]]>';

  DBG_BTN       = 'DBG_BTN';
  DBG_CHK       = 'DBG_CHK';
  DBG_CMB       = 'DBG_CMB';
  DBG_CMB_COUR  = 'DBG_CMB_COUR';
  DBG_EDT       = 'DBG_EDT';
  DBG_FPK       = 'DBG_FPK';
  DBG_IMG       = 'DBG_IMG';
  DBG_LBL       = 'DBG_LBL';
  DBG_LNK       = 'DBG_LNK';
  DBG_MECMB     = 'DBG_MECMB';
  DBG_MEMO      = 'DBG_MEMO';
  DBG_MEMO_COUR = 'DBG_MEMO_COUR';
  DBG_RGP       = 'DBG_RGP';
  DBG_TXT       = 'DBG_TXT'; // TmeIWText (per introdurre html impostando RawText = True)

  // costanti per dettagli richiesta
  DBG_ITER        = 'DBG_ITER';
  DBG_ALLEG       = 'DBG_ALLEGATI';
  DBG_ALLEG_TITLE = 'Allegati';

  HTML_PIPE     = '&#124;';
  HTML_DASH     = '&ndash;';

{$IFNDEF WEBSVC}
procedure C190PulisciIWGrid(Comp:TIWGrid;const ResetCell:boolean=False);
function  C190GetMainOwner(Comp: TComponent): TIWAppForm;

// creazione componenti visuali
function  C190DBGridCreaComandi(POwner:TComponent; PParent: TWinControl; const FN:String; const sComandi,sHint,sConfirmation:String):TmeIWImageFile;
function  C190DBGridCreaButton(POwner:TComponent; PParent: TWinControl; const FN,sCaption: String; const StileCss: String = ''):TmeIWButton;
function  C190DBGridCreaChkBox(POwner:TComponent; PParent: TWinControl; const FN:String; const sCaption: String):TmeIWCheckBox;
function  C190DBGridCreaCombo(POwner:TComponent; PParent: TWinControl; const FN:String; const StileCss,sHint:String):TmeIWComboBox;
function  C190DBGridCreaEdit(POwner:TComponent; PParent: TWinControl; const FN:String; StileCss:String; const sHint:String):TmeIWEdit;
{ DONE : TEST IW 15 }
//function  C190DBGridCreaFilePicker(POwner:TComponent; PParent: TWinControl; const FN:String; const StileCss,sHint:String; const PSizeInput:Integer):TmeIWFile;
function  C190DBGridCreaFileUploader(POwner:TComponent; PParent: TWinControl; const FN:String; const sHint:String):TmeIWFileUploader;
function  C190DBGridCreaLabel(POwner:TComponent; PParent: TWinControl; const FN:String):TmeIWLabel;
function  C190DBGridCreaLink(POwner:TComponent; PParent: TWinControl; const FN:String; const StileCss: String; const sCaption: String):TmeIWLink;
function  C190DBGridCreaMemo(POwner:TComponent; PParent: TWinControl; const FN:String; const StileCss:String):TmeIWMemo;
function  C190DBGridCreaMedpMultiColCombo(POwner:TComponent; PParent: TWinControl; const FN:String; const StileCss,Elementi:String):TMedpIWMultiColumnComboBox;
function  C190DBGridCreaRadioGroup(POwner:TComponent; PParent: TWinControl; const FN:String; const Elementi,StileCss,sHint:String):TmeTIWAdvRadioGroup;
function  C190DBGridCreaText(POwner:TComponent; PParent: TWinControl; const FN:String; const StileCss:String):TmeIWText;
function  C190GetMemoriaUsata: Cardinal; // Cardinal: intero positivo [0..2^32 -1]
function  C190RenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer; const Intestazione,RigheAlterne:Boolean; const EvidenziaRigaSel:Boolean = True): Boolean;
procedure C190AbilitaComponente(Comp:TIWCustomControl; const PAbilita:Boolean; const PIdx: Integer = -1);
procedure C190PutCheckList(S:String; L:Word; CL:TmeTIWAdvCheckGroup; Separator:char=',');
function  C190GetCheckList(L:Word; CL:TmeTIWAdvCheckGroup; Separator:char=','):String;
function  C190EscapeJS(const S: String): String;
function  C190GetCssWidthChr(Size:Integer):String;
function  C190ConvertiSimboliHtml(const S: String): String;
function  C190PeriodoStr(const PInizio, PFine: TDateTime): String;
function  C190CreaNomeComponente(Nome:String; Proprietario:TComponent):String;
function  C190EditMaskToCss(Mask:String):String;
procedure C190AggiornaToolBar(ToolBarGrid:TIWGrid;ActionList:TActionList);
procedure C190AbilitaToolBar(ToolBarGrid:TIWGrid;Abilitazione:Boolean;ActionList:TActionList);
procedure C190VisualizzaGroupBox(JQuery:TIWJQuerywidget;Nome:String;Visualizza:Boolean);
procedure C190VisualizzaGroupBoxAsync(Nome:String;Visualizza:Boolean);
procedure C190Comp2JsonString(Sender: TComponent; var Json: TJSONObject; NomeComp:String = '');
procedure C190CaricaMepdMulticolumnComboBox(Combo:TMedpIWMultiColumnComboBox;ODS:TOracleDataset;const CampoCod: String = 'CODICE'; const CampoDesc: String = 'DESCRIZIONE');
function  C190IncludeEndingSlash(URL:String): String;
{$ENDIF}

implementation

{$IFNDEF WEBSVC}
uses A000UInterfaccia, A000UMessaggi;

procedure C190PulisciIWGrid(Comp:TIWGrid;const ResetCell:boolean=False);
var
  i,j:Integer;
  IWC:TIWCustomControl;
begin
  if Comp = nil then
    exit;
  for i:=0 to Comp.RowCount - 1 do
    for j:=0 to Comp.ColumnCount - 1 do
    begin
      if Comp.Cell[i,j].Control <> nil then
      begin
        if Comp.Cell[i,j].Control is TIWGrid then
          C190PulisciIWGrid(TIWGrid(Comp.Cell[i,j].Control));

        IWC:=Comp.Cell[i,j].Control;
        Comp.Cell[i,j].Control:=nil;
        FreeAndNil(IWC);
      end;
      if ResetCell then
      begin
        Comp.Cell[i,j].Css:='';
        Comp.Cell[i,j].Clickable:=False;
        Comp.Cell[i,j].Text:='';
      end;
    end;
  Comp.Clear;
end;

function C190GetMainOwner(Comp: TComponent): TIWAppForm;
begin
  if Comp = nil then
    Result:=nil
  else if Comp.Owner = nil then
    Result:=nil
  else if Comp.Owner is TIWAppForm then
    Result:=TIWAppForm(Comp.Owner)
  else
    Result:=C190GetMainOwner(Comp.Owner);
end;

function C190DBGridCreaComandi(POwner:TComponent; PParent: TWinControl; const FN:String; const sComandi,sHint,sConfirmation: String):TmeIWImageFile;
begin
  Result:=TmeIWImageFile.Create(POwner);
  with Result do
  begin
    { DONE : TEST IW 15 }
    {DontSubmitFiles:=True;}
    Parent:=PParent;
    FriendlyName:=FN;
    Css:='icona';
    if sHint <> 'null' then
      Hint:=sHint;
    if sConfirmation <> 'null' then
      Confirmation:=sConfirmation;
    if sComandi = 'CANCELLA' then
    begin
      ImageFile.FileName:=fileImgCancella;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_CANCELLA);
      if sConfirmation = 'null' then
        Confirmation:='Eliminare la riga selezionata?';
    end
    else if sComandi = 'MODIFICA' then
    begin
      ImageFile.FileName:=fileImgModifica;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_MODIFICA);
    end
    else if sComandi = 'ANNULLA' then
    begin
      ImageFile.FileName:=fileImgAnnulla;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_ANNULLA);
    end
    else if sComandi = 'CONFERMA' then
    begin
      ImageFile.FileName:=fileImgConferma;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_APPLICA);
    end
    else if sComandi = 'INVISIBILE' then
    begin
      ImageFile.FileName:=fileImgInvisibile;
    end
    else if sComandi = 'INSERISCI' then
    begin
      ImageFile.FileName:=fileImgInserisci;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_INSERISCI);
    end
    else if sComandi = 'STAMPA' then
    begin
      ImageFile.FileName:=fileImgStampa;
      if sHint = 'null' then
        Hint:='Stampa autorizzazione';
    end
    else if sComandi = 'SALVA' then
    begin
      ImageFile.FileName:=fileImgSalva;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_SALVAFILE);
    end
    else if sComandi = 'SCHANAGR' then
    begin
      ImageFile.FileName:=fileImgSchedaAnagrafica;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_SCHEDAANAGRAFICA);
    end
    else if sComandi = 'DEFINISCI' then
    begin
      ImageFile.FileName:=fileImgDefinisci;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_DEFINISCI);
    end
    else if sComandi = 'REVOCA' then
    begin
      ImageFile.FileName:=fileImgRevoca;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_REVOCA);
    end
    else if sComandi = 'CANCPERIODO' then
    begin
      ImageFile.FileName:=fileImgCancPeriodo;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_CANCELLAPERIODO);
    end
    else if sComandi = 'AGGIORNA' then
    begin
      ImageFile.FileName:=fileImgRefresh;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_AGGIORNA);
    end
    else if sComandi = 'CAMBIADATO' then
    begin
      ImageFile.FileName:=fileImgCambiaDato;
    end
    else if sComandi = 'DUPLICA' then
    begin
      ImageFile.FileName:=fileImgDuplica;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_DUPLICA);
    end
    else if sComandi = 'ELENCO' then
    begin
      ImageFile.FileName:=fileImgElenco;
      if sHint = 'null' then
        Hint:='';
    end
    else if sComandi = 'ALLEGATI' then
    begin
      ImageFile.FileName:=fileImgAllegati;
      if sHint = 'null' then
        Hint:='';
    end
    else if sComandi = 'ACCEDI' then
    begin
      ImageFile.FileName:=fileImgAccedi;
      if sHint = 'null' then
        Hint:='';
    end
    else if sComandi = 'DETTAGLIO' then
    begin
      ImageFile.FileName:=fileImgDettaglio;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_DETTAGLIO);
    end
    else if sComandi = 'SELANAGRAFE' then
    begin
      ImageFile.FileName:=fileImgSelAnagrafe;
      if sHint = 'null' then
        Hint:='';
    end
    else if sComandi = 'PUNTINI' then
    begin
      ImageFile.FileName:=fileImgPuntini;
      if sHint = 'null' then
        Hint:='';
    end
    else if sComandi = 'INVIA' then
    begin
      ImageFile.FileName:=fileImgInvia;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_INVIA);
    end
    else if sComandi = 'BLOCCA_RIEP' then
    begin
      ImageFile.FileName:=fileImgBloccaRiepiloghi;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_BLOCCA);
    end
    else if sComandi = 'SBLOCCA_RIEP' then
    begin
      ImageFile.FileName:=fileImgSbloccaRiepiloghi;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_SBLOCCA);
    end
    else if sComandi = 'IMPORTA' then
    begin
      ImageFile.FileName:=fileImgImporta;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_IMPORTA);
    end
    else if sComandi = 'RIAPRI' then
    begin
      ImageFile.FileName:=fileImgRiapri;
      if sHint = 'null' then
        Hint:=A000TraduzioneStringhe(A000MSG_MSG_DEFINISCI);
    end;
  end;
end;

function C190DBGridCreaButton(POwner:TComponent; PParent: TWinControl; const FN,sCaption: String; const StileCss: String = ''):TmeIWButton;
begin
  Result:=TmeIWButton.Create(POwner);
  with Result do
  begin
    Parent:=PParent;
    Caption:=sCaption;
    Css:=IfThen(StileCss = '','pulsante',StileCss);
    FriendlyName:=FN;
  end;
end;

function C190DBGridCreaChkBox(POwner:TComponent; PParent: TWinControl; const FN:String; const sCaption: String):TmeIWCheckBox;
begin
  Result:=TmeIWCheckBox.Create(POwner);
  with Result do
  begin
    Parent:=PParent;
    FriendlyName:=FN;
    Caption:=sCaption;
    Css:='comandi';
  end;
end;

function C190DBGridCreaCombo(POwner:TComponent; PParent: TWinControl; const FN:String; const StileCss,sHint:String):TmeIWComboBox;
begin
  Result:=TmeIWComboBox.Create(POwner);
  with Result do
  begin
    Parent:=PParent;
    Css:=StileCss;
    FriendlyName:=FN;
    Hint:=sHint;
    Items.CaseSensitive:=True;
  end;
end;

function C190DBGridCreaEdit(POwner:TComponent; PParent:TWinControl; const FN:String; StileCss:String; const sHint:String):TmeIWEdit;
begin
  Result:=TmeIWEdit.Create(POwner);
  with Result do
  begin
    Parent:=PParent;
    if Pos('align_center',StileCss) > 0 then
    begin
      StileCss:=StringReplace(StileCss,'align_center','',[rfReplaceAll]);
      Alignment:=taCenter;
    end
    else if Pos('align_right',StileCss) > 0 then
    begin
      StileCss:=StringReplace(StileCss,'align_right','',[rfReplaceAll]);
      Alignment:=taRightJustify;
    end;
    Css:=StileCss;
    FriendlyName:=FN;
    Hint:=sHint;
    if R180CercaParolaIntera('input_data_dmy',Css,'') > 0 then
      MaxLength:=10
    else if R180CercaParolaIntera('input_hour_hhmm',Css,'') > 0 then
      MaxLength:=5;
    NonEditableAsLabel:=False;
    Text:='';
  end;
end;

{ DONE : TEST IW 15 }
{function C190DBGridCreaFilePicker(POwner:TComponent; PParent: TWinControl; const FN:String; const StileCss,sHint:String; const PSizeInput:Integer):TmeIWFile;
begin
  Result:=TmeIWFile.Create(POwner);
  with Result do
  begin
    Parent:=PParent;
    Css:=StileCss;
    FriendlyName:=FN;
    Hint:=sHint;
    RenderSize:=False;
    with StyleRenderOptions do
    begin
      RenderAbsolute:=False;
      RenderFont:=False;
      RenderPosition:=False;
      RenderSize:=False;
      RenderZIndex:=False;
    end;
  end;
end;}

function C190DBGridCreaFileUploader(POwner:TComponent; PParent: TWinControl; const FN:String; const sHint:String):TmeIWFileUploader;
begin
  Result:=TmeIWFileUploader.Create(POwner,True);
  with Result do
  begin
    Parent:=PParent;
    FriendlyName:=FN;
    Hint:=sHint;
    MedpIncludiPulsanteUpload:=False;
    Width:=250;
    with StyleRenderOptions do
    begin
      RenderAbsolute:=False;
      RenderBorder:=False;
      RenderFont:=False;
      RenderPadding:=False;
      RenderPosition:=False;
      RenderSize:=True;
      RenderStatus:=False;
      RenderVisibility:=False;
      RenderZIndex:=False;
    end;
  end;
end;

function C190DBGridCreaLabel(POwner:TComponent; PParent:TWinControl; const FN:String):TmeIWLabel;
begin
  Result:=TmeIWLabel.Create(POwner);
  with Result do
  begin
    Parent:=PParent;
    Font.Enabled:=False;
    RenderSize:=False;
    Css:='descrizione'; //label con font nero nella grid
    FriendlyName:=FN;
  end;
end;

function C190DBGridCreaLink(POwner:TComponent; PParent: TWinControl; const FN:String; const StileCss: String; const sCaption: String):TmeIWLink;
begin
  Result:=TmeIWLink.Create(POwner);
  with Result do
  begin
    Parent:=PParent;
    Caption:=sCaption;
    Css:='link ' + StileCss;
    FriendlyName:=FN;
  end;
end;

function C190DBGridCreaMemo(POwner:TComponent; PParent: TWinControl; const FN:String; const StileCss:String):TmeIWMemo;
begin
  Result:=TmeIWMemo.Create(POwner);
  with Result do
  begin
    Parent:=PParent;
    Css:='gridtextarea ' + StileCss;
    Font.Enabled:=False;
    FriendlyName:=FN;
    RenderSize:=False;
  end;
end;

function C190DBGridCreaMedpMultiColCombo(POwner:TComponent; PParent: TWinControl; const FN:String; const StileCss,Elementi:String):TMedpIWMultiColumnComboBox;
begin
  Result:=TMedpIWMultiColumnComboBox.Create(POwner);
  with Result do
  begin
    Parent:=PParent;
    Css:='medpMultiColumnCombo';
    CssInputText:=StileCss;
    // stile default per input nella multicolumn
    if not CssInputText.Contains('medpMultiColumnComboBoxInput') then
      CssInputText:='medpMultiColumnComboBoxInput ' + CssInputText;
    ColCount:=StrToInt(Elementi);
    FriendlyName:=FN;
  end;
end;
function C190DBGridCreaRadioGroup(POwner:TComponent; PParent: TWinControl; const FN:String; const Elementi,StileCss,sHint:String):TmeTIWAdvRadioGroup;
var
  i:Integer;
  VettCaption:array of String;
begin
  Result:=TmeTIWAdvRadioGroup.Create(POwner);
  with TStringList.Create do
  try
    StrictDelimiter:=True;
    DelimitedText:=IfThen(Elementi = '',' ',Elementi);
    SetLength(VettCaption,Count);
    for i:=0 to Count - 1 do
      VettCaption[i]:=Trim(Strings[i]);
  finally
    Free;
  end;
  with Result do
  begin
    Parent:=PParent;
    Css:='gridComandi ' + StileCss;
    FriendlyName:=FN;
    if sHint <> '' then
      Hint:=sHint;
    Columns:=Length(VettCaption);
    Layout:=glHorizontal;
    for i:=0 to High(VettCaption) do
      Items.Add(VettCaption[i]);
    ItemIndex:=0;
  end;
end;

function C190DBGridCreaText(POwner:TComponent; PParent: TWinControl; const FN:String; const StileCss:String):TmeIWText;
begin
  Result:=TmeIWText.Create(POwner);
  with Result do
  begin
    Parent:=PParent;
    Font.Enabled:=False;
    RenderSize:=False;
    with StyleRenderOptions do
    begin
      RenderAbsolute:=False;
      RenderFont:=False;
      RenderPosition:=False;
      RenderSize:=False;
      RenderZIndex:=False;
    end;
    WantReturns:=False;
  end;
end;

function C190GetMemoriaUsata: Cardinal;
// Determina l'utilizzo attuale di memoria del processo corrente espresso in byte
// -> restituisce la dimensione del working set oppure 0 in caso di problemi
// versione Alessandra Romano (trovata anche sul web facendo altre ricerche)
//var
//  pmc: TProcessMemoryCounters;
  { Note: The TProcessMemoryCounters record wraps up the Windows API
    PROCESS_MEMORY_COUNTERS structure.
    Here's the meaning of the other fields:
    PageFaultCount - the number of page faults.
    PeakWorkingSetSize - the peak working set size, in bytes.
    WorkingSetSize - the current working set size, in bytes.
    QuotaPeakPagedPoolUsage - The peak paged pool usage, in bytes.
    QuotaPagedPoolUsage - The current paged pool usage, in bytes.
    QuotaPeakNonPagedPoolUsage - The peak nonpaged pool usage, in bytes.
    QuotaNonPagedPoolUsage - The current nonpaged pool usage, in bytes.
    PagefileUsage - The current space allocated for the pagefile, in bytes.
                    Those pages may or may not be in memory.
    PeakPagefileUsage - The peak space allocated for the pagefile, in bytes.
  }
begin
  Result:=0;
  (*annullata
  try
    pmc.cb:=SizeOf(pmc);
    if GetProcessMemoryInfo(GetCurrentProcess,@pmc,SizeOf(pmc)) then
      Result:=pmc.WorkingSetSize
    else
      Result:=0;
  except
  end;
  *)
(*
//versione Pedro Lopes
var
  MemoryCounters: PPROCESS_MEMORY_COUNTERS;
begin
  try
    GetMem(MemoryCounters,SizeOf(PROCESS_MEMORY_COUNTERS));
    try
      MemoryCounters^.cb := SizeOf(PROCESS_MEMORY_COUNTERS);
      if GetProcessMemoryInfo(GetCurrentProcess,MemoryCounters,SizeOf(PROCESS_MEMORY_COUNTERS)) then
      begin
        Result:=MemoryCounters^.WorkingSetSize;
      end
      else
      begin
        Result:=0;
      end;
    finally
      FreeMem(MemoryCounters,SizeOf(PROCESS_MEMORY_COUNTERS));
    end;
  except
    Result:=Cardinal(-1); // This never happened, silent except only because isn't critical.
  end;
*)
end;

function C190RenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer; const Intestazione,RigheAlterne:Boolean; const EvidenziaRigaSel:Boolean = True): Boolean;
// Imposta la proprietà ACell.Css in funzione di queste variabili:
// - presenza della riga di intestazione
// - alternanza delle righe di dettaglio
// - riga attualmente selezionata (IWDBGrid)
var
  CssTemp:String;
begin
  // determina se la cella è TH oppure TD
  ACell.Header:=(Intestazione and (ARow = 0));

  // la classe "invisibile" prevale su qualunque altra
  if Pos('invisibile',ACell.Css) > 0 then
  begin
    ACell.Css:='invisibile';
    Result:=False;
  end
  else
  begin
    // se necessario rimuove le classi css specifiche della funzione,
    // mantenendo intatte le altri eventualmente presenti
    CssTemp:=Trim(ACell.Css);
    if (CssTemp <> '') and
       (Intestazione or RigheAlterne or EvidenziaRigaSel) then
    begin
      CssTemp:=StringReplace(CssTemp,'riga_selezionata','',[rfReplaceAll]);
      CssTemp:=StringReplace(CssTemp,'riga_intestazione','',[rfReplaceAll]);
      CssTemp:=StringReplace(CssTemp,'riga_bianca','',[rfReplaceAll]);
      CssTemp:=StringReplace(CssTemp,'riga_colorata','',[rfReplaceAll]);
    end;

    if (EvidenziaRigaSel) and
       (ACell.Grid is TIWDBGrid) and
       (TIWDBGrid(ACell.Grid).RowIsCurrent) then
    begin
      // IWDBGrid: riga selezionata
      CssTemp:=CssTemp + ' riga_selezionata';
    end
    else if Intestazione and (ARow = 0) then
    begin
      // intestazione
      CssTemp:=CssTemp + ' riga_intestazione'
    end
    else if RigheAlterne then
    begin
      // dettaglio: alternanza colore sfondo
      CssTemp:=IfThen(ARow mod 2 = 0,'riga_colorata','riga_bianca') + ' ' + CssTemp;
    end
    else
    begin
      // se non specificato un tipo riga assume come default "riga_bianca"
      if Pos('riga_',CssTemp) = 0 then
        CssTemp:='riga_bianca ' + CssTemp;
    end;

    // cella con icona dati bloccati (cella vuota, il css visualizza l'immagine)
    if Pos('datiBloccati',CssTemp) > 0 then
    begin
      ACell.Text:='&nbsp;&nbsp;&nbsp;&nbsp;';
      ACell.RawText:=True;
      ACell.Hint:='Blocco riepiloghi attivo: modifiche non consentite';
      ACell.ShowHint:=True;
    end;

    // hint della cella con testo html
    if (ACell.ShowHint) and (ACell.Hint <> '') then
    begin
      if Copy(ACell.Hint,1,6) = '<html>' then
        ACell.Hint:=C190ConvertiSimboliHtml(Copy(ACell.Hint,7,MAXINT));
    end;

    ACell.Css:=Trim(CssTemp);
    Result:=True;
  end;
end;

procedure C190AbilitaComponente(Comp:TIWCustomControl; const PAbilita:Boolean; const PIdx: Integer = -1);
// abilita / disabilita il componente specificato
// nel caso sia specificato un indice PIdx, viene disabilitato l'elemento PIdx-iesimo di un
// componente che contiene più Items, ad esempio un IWRadioGroup
var
  r,c: Integer;
  S: String;
  F: TIWAppForm;
begin
  if Comp is TIWLabel then
  begin
    // label: simula abilitazione via css (cfr. meIWLabel)
    with TIWLabel(Comp) do
    begin
      Enabled:=PAbilita;
    end;
  end
  else if Comp is TIWGrid then
  begin
    // grid: ciclo sui componenti relativi
    for r:=0 to TIWGrid(Comp).RowCount - 1 do
    begin
      for c:=0 to TIWGrid(Comp).ColumnCount - 1 do
      begin
        if not PAbilita then
          TIWGrid(Comp).Cell[r,c].Clickable:=False;
        if TIWGrid(Comp).Cell[r,c].Control <> nil then
          C190AbilitaComponente(TIWGrid(Comp).Cell[r,c].Control,PAbilita);
      end;
    end;
  end
  else if Comp is TIWRadioGroup then
  begin
    // radio group
    if PIdx = -1 then
    begin
      // abilita l'intero radiogroup
      with TIWRadioGroup(Comp) do
      begin
        Editable:=PAbilita;
        Enabled:=PAbilita;
      end;
    end
    else
    begin
      // abilita un singolo radiobutton
      with TIWRadioGroup(Comp) do
      begin
        if (PIdx >= 0) and (PIdx < Items.Count)  then
        begin
          if PAbilita then
            S:=''
          else
            S:=Format('  if (rbn.checked) { ' +
                      '    var rbnIdx; ' +
                      '    for (i = %d; i > 0; i--) { ' +
                      '      rbnIdx = FindElem("%s_INPUT_" + i); ' +
                      '      if (!(rbnIdx.disabled) && !(rbnIdx.checked)) { ' +
                      '        rbnIdx.checked = true; ' +
                      '        document.getElementById("%s").click(); ' +
                      '        break; ' +
                      '      } ' +
                      '    } ' +
                      '  } ',
                      [Items.Count,Comp.HTMLName,Comp.HTMLName]);
          S:=Format('var rbn = FindElem("%s_INPUT_%d"); ' +
                    'if (rbn != null) { ' +
                    // se si sta disabilitando l'elemento selezionato effettua un ciclo
                    // per identificare il primo elemento abilitato selezionabile
                    '%s ' +
                    // imposta l'abilitazione del radiobutton specificato
                    '  rbn.disabled = %s; ' +
                    '  rbn.nextSibling.disabled = rbn.disabled; ' +
                    '} ',
                    [Comp.HTMLName,PIdx + 1,S,IfThen(PAbilita,'false','true')]);

          // protegge il blocco di codice
          S:=Format('try { ' +
                    '%s ' +
                    '} ' +
                    'catch (e) { ' +
                    '  try { console.log("C190AbilitaComponente: " + e.message); } catch(err) {} ' +
                    '} ',[S]);
          try
            if GGetWebApplicationThreadVar.IsCallBack then
            begin
              GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(S);
            end
            else
            begin
              F:=C190GetMainOwner(Comp);
              if F <> nil then
                F.AddToInitProc(S);
            end;
          except
          end;
        end;
      end;
    end;
  end
  else if Comp is TIWComboBox then
  begin
    // combobox
    TIWComboBox(Comp).Enabled:=PAbilita;
  end
  else if Comp is TIWCheckBox then
  begin
    // checkbox
    TIWCheckBox(Comp).Editable:=PAbilita;
    TIWCheckBox(Comp).Enabled:=PAbilita;
  end
  else if Comp is TIWEdit then
  begin
    // edit
    TIWEdit(Comp).Editable:=PAbilita;
    TIWEdit(Comp).Enabled:=PAbilita;
  end
  else if Comp is TIWMemo then
  begin
    // memo
    TIWMemo(Comp).Editable:=PAbilita;
    TIWMemo(Comp).Enabled:=PAbilita;
  end
  else
  begin
    // altro tipo di componente
    Comp.Enabled:=PAbilita;
  end;
end;

procedure C190PutCheckList(S:String; L:Word; CL:TmeTIWAdvCheckGroup; Separator:char=',');
var Lista:TStringList;
    i,j:Integer;
begin
  for i:=0 to CL.Items.Count - 1 do
    CL.IsChecked[i]:=False;
  Lista:=TStringList.Create;
  try
    if Separator = ',' then
    begin
      Lista.StrictDelimiter:=True;
      Lista.CommaText:=S;
    end
    else
    begin
      if s <> '' then
      begin
        while Pos(Separator,s) > 0 do
        begin
          Lista.Add(Copy(s,1,Pos(Separator,s)-1));
          s:=Copy(s,Pos(Separator,s)+1,Length(s));
        end;
        Lista.Add(s);
      end;
    end;
    for i:=0 to Lista.Count - 1 do
    begin
      for j:=0 to CL.Items.Count - 1 do
      begin
        if Lista[i] = Trim(Copy(CL.Items[j],1,L)) then
        begin
          CL.IsChecked[j]:=True;
          Break;
        end;
      end;
    end;
  finally
    Lista.Free;
  end;
end;

function C190GetCheckList(L:Word; CL:TmeTIWAdvCheckGroup; Separator:char=','):String;
var i:Integer;
begin
  Result:='';
  for i:=0 to CL.Items.Count - 1 do
  begin
    if CL.IsChecked[i] then
    begin
      if Result <> '' then
        Result:=Result + Separator;
      Result:=Result + Trim(Copy(CL.Items[i],1,L));
    end;
  end;
end;

function C190EscapeJS(const S: String): String;
// trasforma una stringa inserendo i caratteri di escape per javascript
begin
  Result:=S;
  // backslash (primo replace)
  Result:=StringReplace(Result,'\','\\',[rfReplaceAll]);
  // caratteri CR e LF
  Result:=StringReplace(Result,LF,'\n',[rfReplaceAll]);
  Result:=StringReplace(Result,CR,'\r',[rfReplaceAll]);
  // tabulazione
  Result:=StringReplace(Result,TAB,'\t',[rfReplaceAll]);
  // apice e doppio apice
  Result:=StringReplace(Result,'''','\''',[rfReplaceAll]);
  Result:=StringReplace(Result,'"','\"',[rfReplaceAll]);
end;

function C190GetCssWidthChr(Size:Integer):String;
begin
  //Caratto 12/03/2014 aggiunta stili 1,2,3,4 chr
  if Size = 1 then
    Result:='width1chr'
  else if Size = 2 then
    Result:='width2chr'
  else if Size = 3 then
    Result:='width3chr'
  else if Size = 4 then
    Result:='width4chr'
  else if Size = 5 then
    Result:='width5chr'
  else if Size <= 7 then
    Result:='width7chr'
  else if Size <= 10 then
    Result:='width10chr'
  else if Size <= 15 then
    Result:='width15chr'
  else if Size <= 20 then
    Result:='width20chr'
  else if Size <= 25 then
    Result:='width25chr'
  else if Size <= 30 then
    Result:='width30chr'
  else if Size <= 40 then
    Result:='width40chr'
  else if Size <= 50 then
    Result:='width50chr'
  else if Size <= 60 then
    Result:='width60chr'
  else
    Result:='width70chr';
end;

function C190ConvertiSimboliHtml(const S: String): String;
// converte i caratteri speciali nella sintassi gradita a HTML
begin
  Result:=S;

  // converte CRLF
  Result:=StringReplace(Result,CRLF,'<br>',[rfReplaceAll]);

  // converte simboli speciali
  Result:=StringReplace(Result,'"','&quot;',[rfReplaceAll]);
  Result:=StringReplace(Result,'&','&amp;',[rfReplaceAll]);
  Result:=StringReplace(Result,'<','&lt;',[rfReplaceAll]);
  Result:=StringReplace(Result,'>','&gt;',[rfReplaceAll]);
  Result:=StringReplace(Result,'€','&#8364;',[rfReplaceAll]);
  Result:=StringReplace(Result,'à','&agrave;',[rfReplaceAll]);
  Result:=StringReplace(Result,'è','&egrave;',[rfReplaceAll]);
  Result:=StringReplace(Result,'ì','&igrave;',[rfReplaceAll]);
  Result:=StringReplace(Result,'ò','&ograve;',[rfReplaceAll]);
  Result:=StringReplace(Result,'ù','&ugrave;',[rfReplaceAll]);
end;

function C190PeriodoStr(const PInizio, PFine: TDateTime): String;
var
  AnnoIni, AnnoFine: Integer;
begin
  try
    if (PInizio = DATE_MIN) and (PFine = DATE_MAX) then
      Result:=''
    else if PInizio = PFine then
    begin
      Result:=DateToStr(PInizio);
      if PInizio = Date then
        Result:=A000TraduzioneStringhe(A000MSG_MSG_OGGI) + ', ' + Result
      else if PInizio = Date - 1 then
        Result:=A000TraduzioneStringhe(A000MSG_MSG_IERI) + ', ' + Result
      else if PInizio = Date + 1 then
        Result:=A000TraduzioneStringhe(A000MSG_MSG_DOMANI) + ', ' + Result
    end
    else if PInizio = DATE_MIN then
      Result:=A000TraduzioneStringhe(A000MSG_MSG_FINOAL) + ' ' + DateToStr(PFine)
    else if PFine = DATE_MAX then
      Result:=A000TraduzioneStringhe(A000MSG_MSG_DAL) + ' ' + DateToStr(PInizio)
    else
    begin
      AnnoIni:=R180Anno(PInizio);
      AnnoFine:=R180Anno(PFine);
      if (PInizio = R180InizioMese(PInizio)) and (PFine = R180FineMese(PInizio)) then
        Result:=A000TraduzioneStringhe(A000MSG_MSG_MESE) + ' ' + FormatDateTime('mmmm yyyy',PInizio)
      else if (AnnoIni = AnnoFine) and (PInizio = EncodeDate(AnnoIni,1,1)) and (PFine = EncodeDate(AnnoIni,12,31)) then
        Result:=Format('%s %d',[A000TraduzioneStringhe(A000MSG_MSG_ANNO),AnnoIni])
      else
        Result:=Format(A000TraduzioneStringhe(A000MSG_MSG_FMT_DALAL),[DateToStr(PInizio),DateToStr(PFine)]);
    end;
  except
    on E: Exception do
      Result:=E.Message;
  end;
end;

function C190CreaNomeComponente(Nome:String; Proprietario:TComponent):String;
var i:Integer;
    NomeProprietario:String;
begin
  Nome:=StringReplace(Nome,'_','',[rfReplaceAll]);
  { TODO: gestire il caso Proprietario = nil }
  NomeProprietario:=StringReplace(Proprietario.Name,'_','',[rfReplaceAll]);
  i:=0;
  while Proprietario.FindComponent(Nome + IntToStr(i) + NomeProprietario) <> nil do
    inc(i);
  Result:=Nome + IntToStr(i) + NomeProprietario;
end;

function C190EditMaskToCss(Mask:String):String;
{Cerca di abbinare un Css adatto sulla base dell'EditMask del Field. Utile, ad esempio, su WebPJ quando
si va in modifica sulla tabella di Browse e i componenti vengono generati automaticamente (non sono data-aware)}
  function CreaCssOre(valNegativi:boolean):String;
  var i:Integer;
      CssTrovato:String;
  begin
    for i:=1 to Pos(':',Mask)-2 do
      CssTrovato:=CssTrovato+'h';
    CssTrovato:='input_hour_'+CssTrovato+IfThen(valNegativi,'mm_neg','mm');
    Result:=CssTrovato;
  end;
  function CreaCssNumero(valNegativi:boolean):String;
  var i,CifreDecimali,CifreIntere:Integer;
      CssTrovato:String;
  begin
    CifreDecimali:=0;
    CifreIntere:=IfThen(Pos('.',Mask)>0,Pos('.',Mask),Pos(',',Mask));
    if CifreIntere = 0 then
      CifreIntere:=Length(Mask)-Pos(';',Mask)
    else
      CifreDecimali:=Length(Copy(Mask,CifreIntere,Pos(';',Mask)-cifreIntere-1));
      //Massimo 03/06/2013
      //CifreDecimali:=Length(Copy(Mask,CifreIntere,(Length(Mask)-Pos(';',Mask))))-2;
    for i:=1 to CifreIntere-2 do
      CssTrovato:=CssTrovato+'n';
    if CifreDecimali > 0 then
      for i:=1 to CifreDecimali do
        CssTrovato:=CssTrovato+'d';
    CssTrovato:='input_num_'+CssTrovato+IfThen(valNegativi,'_neg','');
    Result:=CssTrovato;
  end;
begin
  // Se è un campo che può avere segno -
  if (Copy(Mask,1,2) = '!#') or ((Copy(Mask,1,2) = '!-')) then
  begin
    if Pos(':',Mask) > 0 then
      Result:=CreaCssOre(true)
    else
      Result:=CreaCssNumero(true);
  end
  // Se è un campo con valori positivi, che non sia una data
  else if ((Copy(Mask,1,2) = '!9') or ((Copy(Mask,1,2) = '!0'))) and (Pos('/',Mask) = 0) then
  begin
    if Pos(':',Mask) > 0 then
      Result:=CreaCssOre(false)
    else
      Result:=CreaCssNumero(false);
  end;
end;

procedure C190AggiornaToolBar(ToolBarGrid:TIWGrid;ActionList:TActionList);
// Imposta le proprietà Visible e Enabled dei pulsanti legati alle Action delle ToolBar
var
  i, k:Integer;
  PrecCategory,NomeFile: String;
  img: TmeIWImageFile;
  act: TAction;
begin
  if ActionList.ActionCount > 0 then
    PrecCategory:=TAction(ActionList.Actions[0]).Category;

  k:=0;
  for i:=0 to ActionList.ActionCount - 1 do
  begin
    if PrecCategory <> TAction(ActionList.Actions[i]).Category  then
    begin
      k:=k + 1;
      PrecCategory:=TAction(ActionList.Actions[i]).Category;
    end;
    if k > ToolBarGrid.ColumnCount - 1 then
      Break;

    //img:=TmeIWImageFile(ToolBarGrid.Cell[0,k].Control);
    act:=TAction(ActionList.Actions[i]);

    ToolBarGrid.Cell[0,k].Visible:=act.Visible;
    //if act.Tag < 1000 then
    if ToolBarGrid.Cell[0,k].Control is TmeIWImageFile then
    begin
      if act.Visible then
      begin
        img:=TmeIWImageFile(ToolBarGrid.Cell[0,k].Control);
        img.Hint:=act.Hint;
        img.Enabled:=act.Enabled;
        NomeFile:=act.Caption + IfThen(not act.Enabled,'_Disabled') + IfThen(act.Checked,'_Checked');
        img.ImageFile.FileName:=Format('img/%s.png',[NomeFile]);
      end;
    end
    else
    begin
      if ToolBarGrid.Cell[0,k].Control <> nil then
        TIWCustomControl(ToolBarGrid.Cell[0,k].Control).Enabled:=act.Enabled;
    end;
    k:=k + 1;
  end;
end;

procedure C190AbilitaToolBar(ToolBarGrid:TIWGrid;Abilitazione:Boolean;ActionList:TActionList);
var i:Integer;
begin
  for i:=0 to ToolBarGrid.ColumnCount - 1 do
    if ToolBarGrid.Cell[0,i].Control <> nil then
      TIWControl(ToolBarGrid.Cell[0,i].Control).Enabled:=Abilitazione;
  if Abilitazione then
    if (ActionList <> nil) and (ToolBarGrid.ColumnCount > 1) then
      C190AggiornaToolBar(ToolBarGrid,ActionList);
end;

procedure C190VisualizzaGroupBoxAsync(Nome:String;Visualizza:Boolean);
var s: String;
begin
  if Visualizza then
    s:='$(''#' + Nome + ''').show(); '
  else
    s:='$(''#' + Nome + ''').hide(); ';

  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(s);
end;

procedure C190VisualizzaGroupBox(JQuery:TIWJQuerywidget;Nome:String;Visualizza:Boolean);
begin
  if Visualizza then
    JQuery.OnReady.Add('$(''#' + Nome + ''').show(); ')
  else
    JQuery.OnReady.Add('$(''#' + Nome + ''').hide(); ');
end;

procedure C190Comp2JsonString(Sender: TComponent; var Json: TJSONObject; NomeComp:String = '');
var Name,Value:String;
begin
  try
    Name:=IfThen(NomeComp = '',Sender.Name,NomeComp);
    Value:='';
    if Sender is TmedpIWTabControl then
      Value:=IntToStr((Sender as TmedpIWTabControl).ActiveTabIndex)
    else if Sender is TmeIWCheckBox then
      Value:=IfThen((Sender as TmeIWCheckBox).Checked,'S','N')
    else if Sender is TmeIWEdit then
      Value:=(Sender as TmeIWEdit).Text
    else if Sender is TmeIWComboBox then
    begin
      if (Sender as TmeIWComboBox).ItemsHaveValues then
        //Value:=TmeIWComboBox(Sender).Value
        Value:=(Sender as TmeIWComboBox).Items.Values[(Sender as TmeIWComboBox).Text]
      else
        Value:=(Sender as TmeIWComboBox).Text;
    end
    else if Sender is TmedpIWMultiColumnComboBox then
      Value:=(Sender as TmedpIWMultiColumnComboBox).Text
    else if Sender is TmeIWRadioGroup then
      Value:=IntToStr((Sender as TmeIWRadioGroup).ItemIndex)
    else if Sender is TmeTIWAdvRadioGroup then
      Value:=IntToStr((Sender as TmeTIWAdvRadioGroup).ItemIndex)
    else if Sender is TmeIWMemo then
      Value:=(Sender as TmeIWMemo).Text
    else
      raise Exception.Create(A000MSG_ERR_CREAZIONE_JSON);
  finally
  end;

  json.AddPair(Name,TJSONString.Create(StringReplace(Value,'\','\\',[rfReplaceAll])));
end;

procedure C190CaricaMepdMulticolumnComboBox(Combo:TMedpIWMultiColumnComboBox;ODS:TOracleDataset;const CampoCod: String = 'CODICE'; const CampoDesc: String = 'DESCRIZIONE');
begin
  ODS.First;
  Combo.Items.Clear;
  while not ODS.Eof do
  begin
    Combo.AddRow(ODS.FieldByName(CampoCod).AsString + ';' + ODS.FieldByName(CampoDesc).AsString );
    ODS.Next;
  end;
end;

function C190IncludeEndingSlash(URL:String):String;
begin
  if Trim(URL) = '' then
  begin
    Result:='/';
  end
  else
  begin
    Result:=URL;
    if URL[Length(URL)] <> '/' then
      Result:=Result + '/';
  end;
end;

{$ENDIF}


end.
