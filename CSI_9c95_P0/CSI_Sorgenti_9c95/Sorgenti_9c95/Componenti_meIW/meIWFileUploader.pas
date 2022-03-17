unit meIWFileUploader;

interface

uses Classes,System.IOUtils,IWControl,IWCompFileUploader,IWHTMLTag,
     IWRenderContext,meIWButton,StrUtils,SysUtils;

{type TmeIWFileUploaderTextStrings = class(TIWFileUploaderTextStrings)
  FMEdpNessunFileText:String;
  FMEdpFileGiaEsistenteText:String;
  FMEdpDefaultMaxSizeNonImpostataText:String;
  public
    property MEdpNessunFileText:String read FMEdpNessunFileText write FMEdpNessunFileText;
    property MEdpFileGiaEsistenteText:String read FMEdpFileGiaEsistenteText write FMEdpFileGiaEsistenteText;
    property MEdpDefaultMaxSizeNonImpostataText:String read FMEdpDefaultMaxSizeNonImpostataText write FMEdpDefaultMaxSizeNonImpostataText;
end;}

type TmeIWFileUploader = class(TIWFileUploader)
  private
    FAutoUpload:Boolean;
    FNomeFile,FDirectoryFile:String;
    NomeFileTemp,DirectoryFileTemp:String;
    FMEdpIncludiPulsanteUpload,FMEdpPulsanteEnabled,
      FMEdpPulsanteVisible,FMEdpRipristinaAlRender:Boolean;
    FMEdpCaptionPulsanteUpload,FMEdpCssPulsanteUpload:String;
    DefaultMaxFileSize,FMEdpMaxFileSize:Int64;
    FMEdpPulsanteAzioneDopoUpload: TmeIWButton;
    FMEdpOnAsyncUploadSuccess,FMEdpOnAsyncUploadError:TIWAsyncEvent;
    FMEdpOnAsyncUploadCompleted: TUploadCompleteEvent;
    DirectoryTemporaneaUpload:String;
    procedure InternalOnAsyncUploadCompleted(Sender: TObject; var DestPath, FileName: string; var SaveFile: Boolean; var Overwrite: Boolean);
    procedure InternalOnAsyncUploadSuccess(Sender: TObject; EventParams: TStringList);
    procedure InternalOnAsyncUploadError(Sender: TObject; EventParams: TStringList);
    procedure SetMEdpPulsanteEnabled(const Value: Boolean);
    procedure SetMEdpPulsanteVisible(const Value: Boolean);
    procedure SetMEdpMaxFileSize(const Value: Int64);
    procedure EseguiSubmitOnClickPulsanteAzione;
    function GetFakeOnAsyncUploadCompleted:TUploadCompleteEvent;
    function GetFakeOnAsyncUploadSuccess:TIWAsyncEvent;
    function GetFakeOnAsyncUploadError:TIWAsyncEvent;
    function GetFakeMaxFileSize:Int64;
    procedure SetAutoUpload(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; AutoUpload: Boolean); reintroduce; overload;
    procedure ImpostaDefaultMaxFileSize(NuovaSize:Int64;Procedi:Boolean);
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function GetPathCompletoFile:String;
    function IsPresenteFileUploadato:Boolean;
    procedure SaveToFile(const ASourceFileName: string; const ADestFileName: TFileName; AOverwrite: Boolean);
    procedure SalvaSuFile(const PathDest:String; const Sovrascrivi:Boolean = False);
    procedure Ripristina;
    property NomeFile:String read FNomeFile;
    property DirectoryFile:String read FDirectoryFile;
  published
    // Eventi
    property OnAsyncUploadCompleted: TUploadCompleteEvent read GetFakeOnAsyncUploadCompleted; // Ridefinita per poterla bloccare
    property MEdpOnAsyncUploadCompleted: TUploadCompleteEvent read FMEdpOnAsyncUploadCompleted write FMEdpOnAsyncUploadCompleted;
    property OnAsyncUploadSuccess: TIWAsyncEvent read GetFakeOnAsyncUploadSuccess;  // Ridefinita per poterla bloccare
    property MEdpOnAsyncUploadSuccess: TIWAsyncEvent read FMEdpOnAsyncUploadSuccess write FMEdpOnAsyncUploadSuccess;
    property OnAsyncUploadError: TIWAsyncEvent read GetFakeOnAsyncUploadError;  // Ridefinita per poterla bloccare
    property MEdpOnAsyncUploadError: TIWAsyncEvent read FMEdpOnAsyncUploadError write FMEdpOnAsyncUploadError;
    // Campi
    property AutoUpload: boolean read FAutoUpload write SetAutoUpload default False;
    property MEdpCaptionPulsanteUpload: String read FMEdpCaptionPulsanteUpload write FMEdpCaptionPulsanteUpload;
    property MEdpCssPulsanteUpload: String read FMEdpCssPulsanteUpload write FMEdpCssPulsanteUpload;
    property MEdpIncludiPulsanteUpload: Boolean read FMEdpIncludiPulsanteUpload write FMEdpIncludiPulsanteUpload;
    property MEdpPulsanteAzioneDopoUpload: TmeIWButton read FMEdpPulsanteAzioneDopoUpload write FMEdpPulsanteAzioneDopoUpload;
    property MEdpPulsanteEnabled: Boolean read FMEdpPulsanteEnabled write SetMEdpPulsanteEnabled;
    property MEdpPulsanteVisible: Boolean read FMEdpPulsanteVisible write SetMEdpPulsanteVisible;
    property MaxFileSize: Int64 read GetFakeMaxFileSize; // Per bloccare quella della superclasse
    property MEdpMaxFileSize:Int64 read FMEdpMaxFileSize write SetMEdpMaxFileSize;
    property MEdpRipristinaAlRender:Boolean read FMEdpRipristinaAlRender write FMEdpRipristinaAlRender;

end;

resourcestring
  MEDP_IT_RSFU_DragText = 'Trascinare qui i file da caricare';
  MEDP_IT_RSFU_UploadButtonText = 'Sfoglia...';
  MEDP_IT_RSFU_CancelButtonText = 'Annulla';
  MEDP_IT_RSFU_RemoveButtonText = 'Rimuovi';
  MEDP_IT_RSFU_UploadErrorText = 'Upload fallito';
  MEDP_IT_RSFU_MultipleFileDropNotAllowedText = 'È possibile trascinare un file solo';
  MEDP_IT_RSFU_OfTotalText = 'di';
  MEDP_IT_RSFU_TypeErrorText = '{file} ha estensione non valida. Sono consentiti solo i file {extensions}.';
  MEDP_IT_RSFU_SizeErrorText = '{file} è troppo grande, la dimensione massima consentita è {sizeLimit}.';
  MEDP_IT_RSFU_MinSizeErrorText = '{file} è troppo piccolo, la dimensione minima consentita è {minSizeLimit}.';
  MEDP_IT_RSFU_EmptyErrorText = '{file} è vuoto, ripetere la selezione escludendo questo file.';
  MEDP_IT_RSFU_NoFilesErrorText = 'Nessun file da caricare.';
  MEDP_IT_RSFU_OnLeaveWarningText = 'È in corso il caricamento dei file, se si abbandona ora la procedura di upload sarà annullata.';

  MEDP_IT_RSFU_ErroreSalvaNoFile = 'Nessun file da salvare';
  MEDP_IT_RSFU_ErroreSalvaFileEsiste = 'Il file %s esiste già.';

  MEDP_IT_RSFU_INT_MaxSizeDefNotSet = 'Errore interno del componente meIWFileUploader - dimensione default massima file non impostata!';
  MEDP_IT_RSFU_INT_TempDirCreateFail = 'Errore interno del componente meIWFileUploader - impossibile creare la directory temporanea %s: %s';
  MEDP_IT_RSFU_INT_NonUsare = 'Errore interno del componente meIWFileUploader - non utilizzare il metodo %s, usare SalvaSuFile()';

implementation

uses IWApplication;

constructor TmeIWFileUploader.Create(AOwner: TComponent);
var
  DataOra:TDateTime;
  NuovaDirTemp:String;
  NuovaDirTempSuffisso:Integer;
begin
  inherited Create(AOwner);
  FNomeFile:='';
  FDirectoryFile:='';
  NomeFileTemp:='';
  DirectoryFileTemp:='';
  AutoUpload:=False;
  inherited OnAsyncUploadCompleted:=InternalOnAsyncUploadCompleted;
  inherited OnAsyncUploadSuccess:=InternalOnAsyncUploadSuccess;
  inherited OnAsyncUploadError:=InternalOnAsyncUploadError;
  with FTextStrings do begin
    DragText := MEDP_IT_RSFU_DragText;
    UploadButtonText := MEDP_IT_RSFU_UploadButtonText;
    CancelButtonText := MEDP_IT_RSFU_CancelButtonText;
    RemoveButtonText := MEDP_IT_RSFU_RemoveButtonText;
    UploadErrorText := MEDP_IT_RSFU_UploadErrorText;
    MultipleFileDropNotAllowedText := MEDP_IT_RSFU_MultipleFileDropNotAllowedText;
    OfTotalText := MEDP_IT_RSFU_OfTotalText;
    TypeErrorText := MEDP_IT_RSFU_TypeErrorText;
    SizeErrorText := MEDP_IT_RSFU_SizeErrorText;
    EmptyErrorText := MEDP_IT_RSFU_EmptyErrorText;
    NoFilesErrorText := MEDP_IT_RSFU_NoFilesErrorText;
    MinSizeErrorText := MEDP_IT_RSFU_MinSizeErrorText;
    OnLeaveWarningText := MEDP_IT_RSFU_OnLeaveWarningText;
  end;
  CssClasses.Values['button']:='medpfileuploader-button';
  CssClasses.Values['button-hover']:='medpfileuploader-button-hover';
  CssClasses.Values['drop-area']:='medpfileuploader-drop-area';
  CssClasses.Values['drop-area-active']:='medpfileuploader-drop-area-active';
  CssClasses.Values['list']:='medpfileuploader-list';
  CssClasses.Values['upload-spinner']:='medpfileuploader-upload-spinner';
  CssClasses.Values['upload-file']:='medpfileuploader-upload-file';
  CssClasses.Values['upload-size']:='medpfileuploader-upload-size';
  CssClasses.Values['upload-listItem']:='medpfileuploader-upload-listItem';
  CssClasses.Values['upload-cancel']:='medpfileuploader-upload-cancel';
  CssClasses.Values['upload-success']:='medpfileuploader-upload-success';
  CssClasses.Values['upload-fail']:='medpfileuploader-upload-fail';
  CssClasses.Values['success-icon']:='medpfileuploader-success-icon';
  CssClasses.Values['fail-icon']:='medpfileuploader-fail-icon';
  MEdpCaptionPulsanteUpload:='Upload';
  MEdpCssPulsanteUpload:='pulsante';
  MEdpIncludiPulsanteUpload:=True;
  MEdpPulsanteVisible:=True;
  MEdpPulsanteEnabled:=True;
  MEdpRipristinaAlRender:=True;
  MEdpPulsanteAzioneDopoUpload:=nil;
  DefaultMaxFileSize:=50 * 1024 * 1024; // 50 MB
  MEdpMaxFileSize:=-1;
  DirectoryTemporaneaUpload:='';
  NuovaDirTempSuffisso:=0;
  if not (csDesigning in ComponentState) then
  begin
    try
      DataOra:=Now;
      while DirectoryTemporaneaUpload.IsEmpty do
      begin
        NuovaDirTemp:=IncludeTrailingPathDelimiter(GGetWebApplicationThreadVar.UserCacheDir) +
                      'meIWFU_' + FormatDateTime('yyyymmdd',DataOra) + '_' +
                      FormatDateTime('hhnnss',DataOra) + '_' + IntToStr(NuovaDirTempSuffisso);
        if not DirectoryExists(NuovaDirTemp) then
        begin
          MkDir(NuovaDirTemp);
          DirectoryTemporaneaUpload:=NuovaDirTemp;
        end;
        Inc(NuovaDirTempSuffisso);
      end;
    except
      on E:Exception do
        raise Exception.Create(Format(MEDP_IT_RSFU_INT_TempDirCreateFail,[NuovaDirTemp,E.Message]));
    end;
  end;
end;

constructor TmeIWFileUploader.Create(AOwner: TComponent; AutoUpload: Boolean);
begin
  Create(AOwner);
  Self.AutoUpload:=AutoUpload;
end;

procedure TmeIWFileUploader.ImpostaDefaultMaxFileSize(NuovaSize:Int64;Procedi:Boolean);
begin
  if Procedi then
    DefaultMaxFileSize:=NuovaSize;
end;

function TmeIWFileUploader.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  js:String;
begin
  if FMEdpRipristinaAlRender then
    Ripristina;
  if MEdpMaxFileSize > -1 then
    inherited MaxFileSize:=MEdpMaxFileSize
  else
  begin
    if DefaultMaxFileSize < 0 then
      raise Exception.Create(MEDP_IT_RSFU_INT_MaxSizeDefNotSet);
    inherited MaxFileSize:=DefaultMaxFileSize;
  end;
  Result:=inherited RenderHTML(AContext);
  AContext.AddScriptFile('js/medpIWFileUploader.js');
  if FMEdpIncludiPulsanteUpload then
  begin
    js:='function create' + HTMLName + 'MEdpUploadButton(){' +
        '  var btnSettings = {' +
        '   id: "' + HTMLName + '_UploadButton",' +
        '   caption: "' + MEdpCaptionPulsanteUpload + '",' +
        '   css: "' + MEdpCssPulsanteUpload + '",' +
        '   htmlName: "' + HTMLName  + '",' +
        '   template: "<div style=''margin-top: 4px; display: block;''><button id=''{id}'' class=''{classiCss}'' onclick=''window.' + HTMLName + '_MEdpUploadButton_Obj.avviaUpload();'')>{captionPulsante}</button></div>",' +
        '   enabled: ' + IfThen(MEdpPulsanteEnabled,'true','false') + ',' +
        '   visible: ' + IfThen(MEdpPulsanteVisible,'true','false') + ',' +
        '   msgNessunFile: ' + QuotedStr(TextStrings.NoFilesErrorText) +
        '  };' +
        '  return new medpIwFu.MEdpFileUploader(btnSettings);' +
        '}';
    AContext.AddToJavaScriptOnce(js);
    AContext.AddToInitProc('window.' + HTMLName + '_MEdpUploadButton_Obj = create' + HTMLName + 'MEdpUploadButton();');
  end;
end;

procedure TmeIWFileUploader.InternalOnAsyncUploadCompleted(Sender: TObject; var DestPath, FileName: string; var SaveFile: Boolean; var Overwrite: Boolean);
begin
  // Si verifica al termine dell'upload, prima che il file venga processato da IW.
  // Non so ancora se l'upload nella sua interezza andrà a buon fine, quindi svuoto i dettagli sul file uploadato per ora.
  Ripristina;
  // Indico di salvare il file in una directory temporanea della cache utente
  DestPath:=DirectoryTemporaneaUpload;
  if Assigned(MEdpOnAsyncUploadCompleted) then // Eseguo l'handler impostato dallo sviluppatore
    MEdpOnAsyncUploadCompleted(Sender,DestPath,FileName,SaveFile,Overwrite);
  // Inizio a salvare il nome e il percorso del file in modo temporaneo.
  NomeFileTemp:=FileName;
  DirectoryFileTemp:=DestPath;
end;

procedure TmeIWFileUploader.InternalOnAsyncUploadSuccess(Sender: TObject; EventParams: TStringList);
begin
  // L'upload ha avuto successo. Posso confermare i dati temporanei come nome e percorso del file.
  FNomeFile:=NomeFileTemp;
  FDirectoryFile:=DirectoryFileTemp;
  if Assigned(MEdpOnAsyncUploadSuccess) then  // Eseguo l'handler impostato dallo sviluppatore
    MEdpOnAsyncUploadSuccess(Sender,EventParams);
  EseguiSubmitOnClickPulsanteAzione;
end;

procedure TmeIWFileUploader.InternalOnAsyncUploadError(Sender: TObject; EventParams: TStringList);
begin
  // L'upload è fallito. Svuoto i campi temporanei.
  NomeFileTemp:='';
  DirectoryFileTemp:='';
  if Assigned(MEdpOnAsyncUploadError) then  // Eseguo l'handler impostato dallo sviluppatore
    MEdpOnAsyncUploadError(Sender,EventParams);
  EseguiSubmitOnClickPulsanteAzione;
end;

procedure TmeIWFileUploader.SetMEdpPulsanteEnabled(const Value: Boolean);
var NotificaClient:Boolean;
begin
  NotificaClient:=(MEdpPulsanteEnabled <> Value);
  FMEdpPulsanteEnabled:=Value;
  if (NotificaClient) and (not (csDesigning in ComponentState)) then
    CallJavaScriptMethod('window.' + HTMLName + '_MEdpUploadButton_Obj.impostaEnabled(' + IfThen(Value,'true','false') + ');');
end;

procedure TmeIWFileUploader.SetMEdpPulsanteVisible(const Value: Boolean);
var NotificaClient:Boolean;
begin
  NotificaClient:=(MEdpPulsanteVisible <> Value);
  FMEdpPulsanteVisible:=Value;
  if (NotificaClient) and (not (csDesigning in ComponentState)) then
    CallJavaScriptMethod('window.' + HTMLName + '_MEdpUploadButton_Obj.impostaVisible(' + IfThen(Value,'true','false') + ');');
end;

procedure TmeIWFileUploader.SetMEdpMaxFileSize(const Value: Int64);
begin
  FMEdpMaxFileSize:=Value;
end;

procedure TmeIWFileUploader.EseguiSubmitOnClickPulsanteAzione;
var
  js:String;
begin
  { Se lo sviluppatore ha impostato la proprietà MEdpPulsanteAzioneDopoUpload inviamo al client
    la richiesta di effettuare un full submit e richiedere l'esecuzione lato server del codice
    definito sull'evento OnClick di quel pulsante. }
  if Assigned(MEdpPulsanteAzioneDopoUpload) then
  begin
    js:=Format('SubmitClick("%s", "", true);',[MEdpPulsanteAzioneDopoUpload.HTMLName]);
    CallJavaScriptMethod(js);
  end;
end;

function TmeIWFileUploader.GetPathCompletoFile:String;
begin
  Result:='';
  if (NomeFile <> '') and (DirectoryFile <> '')  then
    Result:= IncludeTrailingPathDelimiter(DirectoryFile) + NomeFile;
  
end;

function TmeIWFileUploader.IsPresenteFileUploadato:Boolean;
begin
  Result:=False;
  if (NomeFile <> '') and (DirectoryFile <> '') then
  begin
    if FileExists(GetPathCompletoFile) then
      Result:=True;
  end;
end;

procedure TmeIWFileUploader.SaveToFile(const ASourceFileName: string; const ADestFileName: TFileName; AOverwrite: Boolean);
begin
  raise Exception.Create(Format(MEDP_IT_RSFU_INT_NonUsare, ['SaveToFile()']));
end;

procedure TmeIWFileUploader.SalvaSuFile(const PathDest:String; const Sovrascrivi:Boolean = False);
begin
  if not IsPresenteFileUploadato then
    raise Exception.Create(MEDP_IT_RSFU_ErroreSalvaNoFile);
  if FileExists(PathDest) then
  begin
    if Sovrascrivi then
      TFile.Delete(PathDest)
    else
      raise Exception.Create(Format(MEDP_IT_RSFU_ErroreSalvaFileEsiste,[ExtractFileName(PathDest)]));
  end;
  TFile.Copy(GetPathCompletoFile,PathDest);
end;

procedure TmeIWFileUploader.Ripristina;
begin
  FNomeFile:='';
  FDirectoryFile:='';
end;

function TmeIWFileUploader.GetFakeOnAsyncUploadCompleted:TUploadCompleteEvent;
begin
  Result:=nil;
end;

function TmeIWFileUploader.GetFakeOnAsyncUploadSuccess:TIWAsyncEvent;
begin
  Result:=nil;
end;

function TmeIWFileUploader.GetFakeOnAsyncUploadError:TIWAsyncEvent;
begin
  Result:=nil;
end;

function TmeIWFileUploader.GetFakeMaxFileSize:Int64;
begin
  Result:=Low(Int64);
end;

procedure TmeIWFileUploader.SetAutoUpload(const Value: Boolean);
begin
  Self.FAutoUpload:=Value;
  inherited AutoUpload:=Value;
end;

end.
