unit W040UUploadDocumenti;

interface

uses
  A118UPubblicazioneDocumentiMW,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  A000UInterfaccia, IWApplication, W000UMessaggi,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.IOUtils, System.Classes, Vcl.Graphics, StrUtils, Oracle,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R010UPaginaWeb, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompEdit, medpIWMultiColumnComboBox,
  IWAdvTreeView, meTIWAdvTreeView, IWCompTreeview, meIWTreeView,
  IWCompCheckbox, meIWCheckBox, IWCompMemo, meIWMemo, IWCompListbox,
  meIWListbox, meIWList, medpIWMessageDlg, IWCompFileUploader, meIWFileUploader;

type
  TW040FUploadDocumenti = class(TR010FPaginaWeb)
    lblTipologie: TmeIWLabel;
    cmbTipologie: TMedpIWMultiColumnComboBox;
    lblDescTipologia: TmeIWLabel;
    btnHdnUpload: TmeIWButton;
    trvCartelle: TmeIWTreeView;
    lblFile: TmeIWLabel;
    lblDestinazione: TmeIWLabel;
    lstFile: TmeIWList;
    lblInfoFile: TmeIWLabel;
    IWFile: TmeIWFileUploader;
    procedure IWAppFormCreate(Sender: TObject);
    procedure cmbTipologieAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure btnHdnUploadClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure IWAppFormAfterRender(Sender: TObject);
  private
    A118MW: TA118FPubblicazioneDocumentiMW;
    procedure PopolaDestinazione;
    procedure ItemClick(Sender: TObject);
    procedure ScorriPath(const PDirNameCompleto: String; PLiv: Integer; PParentItem: TIWTreeViewItem);
    procedure EstraiStrutture;
    procedure ElencaFile(const PDirNameCompleto: String);
    function  IsFormatoFileOk(const PNomeFile: String; var RElencoValori, RErrMsg: String): Boolean;
    procedure OnConfermaUpload(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure Upload(const PPathFileDest: String);
  protected
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso: Boolean; override;
  end;

implementation

{$R *.dfm}

{ TW040FUploadDocumenti }

function TW040FUploadDocumenti.InizializzaAccesso: Boolean;
var
  S: String;
begin
  Result:=True;

  // seleziona la prima tipologia disponibile
  if cmbTipologie.Items.Count > 0 then
  begin
    cmbTipologie.ItemIndex:=0;
    cmbTipologie.Text:=cmbTipologie.Items[0].RowData[0];
    S:=Format('processAjaxEvent("onChange", %sIWCL,"%s.DoAsyncChange",true,null,true); ',
              [cmbTipologie.HTMLName,cmbTipologie.HTMLName]);
    AddToInitProc(S);
  end;
end;

procedure TW040FUploadDocumenti.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 15 }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    inherited;
    RimuoviNotifiche;
  end;
end;

procedure TW040FUploadDocumenti.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  A118MW:=TA118FPubblicazioneDocumentiMW.Create(nil);
  EstraiStrutture;
end;

procedure TW040FUploadDocumenti.IWAppFormRender(Sender: TObject);
var
  IWT: TIWTreeViewItem;
  ResponseFunc: String;
begin
  inherited;

  // evidenzia l'item selezionato nel treeview
  IWT:=trvCartelle.Selected;
  if Assigned(IWT) then
  begin
    // evidenza l'item selezionato
    ResponseFunc:=Format('$elem = jQuery.root.find("#%s"); ' +
                         'if ($elem.length) { ' +
                         '  $elem.toggleClass("trvChecked",%s); ' +
                         '} ',[IWT.Name,'true']);
    AddToInitProc(ResponseFunc);
  end;
end;

procedure TW040FUploadDocumenti.cmbTipologieAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
var
  S: String;
begin
  // descrizione tipologia
  if cmbTipologie.ItemIndex = -1 then
    lblDescTipologia.Caption:=''
  else
    lblDescTipologia.Caption:=cmbTipologie.Items[cmbTipologie.ItemIndex].RowData[1];

  // popola treeview destinazione
  A118MW.Codice:=cmbTipologie.Text;
  PopolaDestinazione;

  // full submit
  S:=Format('SubmitClick("%s","",true); ',[cmbTipologie.HTMLName]);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(S);
end;

procedure TW040FUploadDocumenti.DistruggiOggetti;
begin
  try FreeAndNil(A118MW); except end;
end;

procedure TW040FUploadDocumenti.EstraiStrutture;
// estrae i dati principali delle tipologie di documento
begin
  Log('Traccia','EstraiStrutture.ini');

  // estrazione delle tipologie di documento (non considera i filtri di visualizzazione)
  with A118MW.selI200 do
  begin
    First;
    while not Eof do
    begin
      cmbTipologie.AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
  Log('Traccia','EstraiStrutture.fine');
end;

procedure TW040FUploadDocumenti.PopolaDestinazione;
var
  RootDirectory: String;
  LivObj: TLivello;
begin
  // pulisce l'interfaccia
  trvCartelle.ClearAll;
  trvCartelle.TreeViewImages.ClosedFolderImage.Filename:=fileImgFolderClosed;
  trvCartelle.TreeViewImages.OpenFolderImage.Filename:=fileImgFolderOpen;
  trvCartelle.TreeViewImages.DocumentImage.Filename:=fileImgFolderOpen;
  lstFile.Items.Clear;
  lblInfoFile.Caption:='';
  { DONE : TEST IW 15 }
  //btnUpload.Enabled:=False;
  IWFile.MEdpPulsanteEnabled:=False;

  // percorre la struttura delle directory a partire dalla directory root
  // (se non è indicata esplicitamente utilizza la directory predefinita sul webserver)
  RootDirectory:=A118MW.RootDir;
  if not TDirectory.Exists(RootDirectory) then
  begin
    MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W040_ERR_FMT_BASE_DIR),[RootDirectory]),ERRORE);
    Log('Errore',Format('PopolaDestinazione: directory base inesistente: "%s"',[RootDirectory]));
    Exit;
  end;

  // scorre le cartelle per popolare i dati di destinazione
  ScorriPath(RootDirectory,-1,nil);

  // seleziona il primo nodo del treeview
  if trvCartelle.Items.Count > 0 then
  begin
    trvCartelle.Selected:=trvCartelle.Items[0];
    ItemClick(trvCartelle.Selected);
  end;

  // imposta indicazioni su estensione
  LivObj:=A118MW.Livello[A118MW.LivFile];
  if LivObj.ExtI201 = ESTENSIONE_QUALSIASI then
    lblInfoFile.Caption:=''
  else
    lblInfoFile.Caption:=Format('Il file deve avere estensione %s',[LivObj.ExtI201]);

  // abilita l'upload
  //btnUpload.Enabled:=True;
  IWFile.MEdpPulsanteEnabled:=True;
end;

procedure TW040FUploadDocumenti.ScorriPath(const PDirNameCompleto: String; PLiv: Integer; PParentItem: TIWTreeViewItem);
// questa procedura utilizza chiamate ricorsive per attraversare le strutture
// delle directory, per cui vengono utilizzati i puntatori per mantenere
// minimo l'utilizzo dello stack.
{$WARN SYMBOL_PLATFORM OFF}
var
  SearchRec: ^TSearchRec;
  FileName: PString;
  NumFile: Integer;
  IsFile,FolderOK: Boolean;
  DirName,ErrMatchNome,ErrFolder: String;
  LivObj: TLivello;
begin
  if PDirNameCompleto.Trim = '' then
    Exit;
  Log('Traccia','ScorriPath.ini - livello ' + PLiv.ToString);

  // estrae il nome della directory attuale (senza path completo)
  DirName:=TA118FPubblicazioneDocumentiMW.GetFileName(PDirNameCompleto);

  // effettua controlli per i livelli definiti sulla struttura
  FolderOK:=True;
  ErrFolder:='';
  if R180Between(PLiv,0,A118MW.LivMaxDir) then
  begin
    // verifica se la cartella soddisfa i requisiti del nome e l'eventuale filtro
    LivObj:=A118MW.Livello[PLiv];
    LivObj.NomeFile:=DirName;
    FolderOK:=LivObj.MatchNome(ttSupervisore,ErrMatchNome);
    if FolderOK then
    begin
      FolderOK:=LivObj.MatchFiltro(ttSupervisore);
      if not FolderOK then
      begin
        Log('Traccia',Format('Livello %2d; directory "%s": filtro non soddisfatto',[PLiv,DirName]));
        ErrFolder:=' [ERR_FILTRO]';
      end;
    end
    else
    begin
      Log('Traccia',Format('Livello %2d; directory "%s": sintassi del nome non corrispondente',[PLiv,DirName]));
      ErrFolder:=Format(' [ERR_NOME: %s]',[ErrMatchNome]);
    end;
  end;

  // esce se la cartella non è da considerare
  if not FolderOK then
    Exit;

  // aggiunge la directory come nodo sul treeview
  PParentItem:=trvCartelle.Items.Add(PParentItem);
  PParentItem.Caption:=DirName;
  PParentItem.Hint:=PDirNameCompleto;
  PParentItem.Tag:=PLiv;
  PParentItem.OnClick:=ItemClick;

  // disabilita input/output checking
  {$I-}

  // alloca un nuovo record (SearchRec) e una nuova string (FileName)
  New(SearchRec);
  New(FileName);

  // esamina ricorsivamente le directory
  try
    NumFile:=System.SysUtils.FindFirst(PDirNameCompleto + '\*.*',System.SysUtils.faAnyFile,SearchRec^);
    inc(PLiv);
    while NumFile = 0 do
    begin
      FileName^:=IncludeTrailingPathDelimiter(PDirNameCompleto) + SearchRec^.Name;

      // verifica il tipo di file: directory oppure file
      IsFile:=((SearchRec^.Attr and System.SysUtils.faDirectory) = 0);
      if not IsFile then
      begin
        // tipo: directory
        // -> esclude le directory speciali "." e ".."
        if ((SearchRec^.Name <> '.') and (SearchRec^.Name <> '..')) then
        begin
          // -> chiamata ricorsiva
          ScorriPath(FileName^,PLiv,PParentItem);
        end;
      end;
      NumFile:=System.SysUtils.FindNext(SearchRec^);
    end;

    System.SysUtils.FindClose(SearchRec^);
  finally
    // rilascia la memoria allocata per le strutture
    System.Dispose(FileName);
    System.Dispose(SearchRec);
  end;

  Log('Traccia','ScorriPath.fine - livello ' + PLiv.ToString);
  // riabilita input/output checking
  {$I+}
{$WARN SYMBOL_PLATFORM ON}
end;

procedure TW040FUploadDocumenti.ElencaFile(const PDirNameCompleto: String);
{$WARN SYMBOL_PLATFORM OFF}
var
  SearchRec: ^TSearchRec;
  FileName: PString;
  NumFile: Integer;
  IsFile: Boolean;
  FileNameStr: String;
begin
  lstFile.Items.Clear;

  // disabilita input/output checking
  {$I-}

  // alloca un nuovo record (SearchRec) e una nuova string (FileName)
  New(SearchRec);
  New(FileName);

  // esamina i file presenti nella directory
  try
    NumFile:=System.SysUtils.FindFirst(PDirNameCompleto + '\*.*',System.SysUtils.faAnyFile,SearchRec^);
    while NumFile = 0 do
    begin
      FileName^:=IncludeTrailingPathDelimiter(PDirNameCompleto) + SearchRec^.Name;

      // verifica il tipo di file: directory oppure file
      IsFile:=((SearchRec^.Attr and System.SysUtils.faDirectory) = 0);
      if IsFile then
      begin
        // tipo: file
        FileNameStr:=ExtractFileName(FileName^);
        lstFile.Items.Add(FileNameStr);
      end;
      NumFile:=System.SysUtils.FindNext(SearchRec^);
    end;
    System.SysUtils.FindClose(SearchRec^);
  finally
    // rilascia la memoria allocata per le strutture
    System.Dispose(FileName);
    System.Dispose(SearchRec);
  end;
  // riabilita input/output checking
  {$I+}
{$WARN SYMBOL_PLATFORM OFF}
end;

procedure TW040FUploadDocumenti.ItemClick(Sender: TObject);
// gestione click su item del treeview
var
  IWT: TIWTreeViewItem;
  ResponseFunc,CartellaFile,Msg: String;
  Livello: Integer;
begin
  IWT:=(Sender as TIWTreeViewItem);
  Livello:=IWT.Tag;

  lstFile.Items.Clear;
  if Livello <= A118MW.LivFile - 1 then
  begin
    // async: evidenza subito l'item selezionato
    if GGetWebApplicationThreadVar.CallBackProcessing then
    begin
      ResponseFunc:=Format('$elem = jQuery.root.find("#%s"); ' +
                         'if ($elem.length) { ' +
                         '  $elem.toggleClass("trvChecked",%s); ' +
                         '} ',[IWT.Name,'true']);
      GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(ResponseFunc);
    end;

    // elenca nella listbox i file presenti nella cartella
    CartellaFile:=IWT.Hint;
    ElencaFile(CartellaFile);
  end
  else
  begin
    // async: evidenza subito l'item selezionato
    Msg:=A000TraduzioneStringhe(A000MSG_W040_ERR_LIV_FILE_ERRATO);
    if GGetWebApplicationThreadVar.CallBackProcessing then
      GGetWebApplicationThreadVar.ShowMessage(Msg)
    else
      MsgBox.MessageBox(Msg,INFORMA);
  end;
end;

function TW040FUploadDocumenti.IsFormatoFileOk(const PNomeFile: String;
  var RElencoValori, RErrMsg: String): Boolean;
var
  LivObj: TLivello;
  Nome,Valore: String;
begin
  Result:=False;
  RErrMsg:='';

  // verifica che il livello file sia definito
  if A118MW.LivFile = -1 then
  begin
    RErrMsg:='la struttura della tipologia documento non è corretta!';
    Exit;
  end;

  // filtra la struttura dei campi sul livello file
  LivObj:=A118MW.Livello[A118MW.LivFile];

  // verifica se il nome file rispecchia formalmente la struttura definita per il livello
  LivObj.NomeFile:=PNomeFile;
  Result:=LivObj.MatchNome(ttFormale,RErrMsg);

  // prepara l'elenco dei campi con i rispettivi valori riconosciuti
  RElencoValori:='<div class="grid grigliaDati spazio_top"><table><thead><th>Dato</th><th>Valore</th></thead><tbody>';
  A118MW.selI202.First;
  while not A118MW.selI202.Eof do
  begin
    Nome:=A118MW.selI202.FieldByName('CAMPO').AsString.ToUpper;
    if A118MW.IsNomeVariabile(Nome) then
    begin
      Nome:=A118MW.RemovePrefissoVariabile(Nome);
      Valore:=LivObj.GetCampo(Nome).Valore;
    end
    else
      Valore:=Nome;
    RElencoValori:=RElencoValori + Format('<tr><td>%s</td><td>%s</td></tr>',[Nome,Valore]);
    A118MW.selI202.Next;
  end;
  // estensione
  if A118MW.LivFile > 0 then
  begin
    try
      RElencoValori:=RElencoValori + Format('<tr><td>Estensione</td><td>%s</td></tr>',[LivObj.ExtFile]);
    except
    end;
  end;
  RElencoValori:=RElencoValori + '</tbody></table></div>';
end;

{ DONE : TEST IW 15 }
procedure TW040FUploadDocumenti.btnHdnUploadClick(Sender: TObject);
// upload del documento
var
  IWT: TIWTreeViewItem;
  LivelloCartella,LivelloFile: Integer;
  CartellaFile,NomeFile,TabValori,ErrFormato,PathFileDest,Msg: String;
  FileEsistente,SintassiFileOk: Boolean;
begin
  // salva l'item selezionato del treeview
  IWT:=trvCartelle.Selected;

  // verifica destinazione selezionata
  if not Assigned(IWT) then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W040_ERR_SEL_DESTINAZIONE),ESCLAMA);
    Exit;
  end;

  // determina il livello della cartella in cui sarà salvato il file
  // e di conseguenza il livello del file
  CartellaFile:=IWT.Hint;
  LivelloCartella:=IWT.Tag;
  LivelloFile:=LivelloCartella + 1;

  // l'upload non è consentito su livelli intermedi
  if LivelloFile < A118MW.LivFile then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W040_ERR_LIV_DESTINAZIONE),ESCLAMA);
    Exit;
  end;

  // verifica
  if not IWFile.IsPresenteFileUploadato then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W040_ERR_SELEZIONARE_FILE),ESCLAMA);
    Exit;
  end;

  // determina il nome del file
  NomeFile:=IWFile.NomeFile;

  // determina path file
  PathFileDest:=IncludeTrailingPathDelimiter(CartellaFile) + NomeFile;

  // se esiste già un file temporaneo con lo stesso nome chiede di sovrascriverlo
  FileEsistente:=TFile.Exists(PathFileDest);

  // verifica che il nome file sia formalmente corretto
  TabValori:='';
  ErrFormato:='';
  SintassiFileOk:=IsFormatoFileOk(NomeFile,TabValori,ErrFormato);
  if SintassiFileOk then
  begin
    // conferma upload
    Msg:=IfThen(FileEsistente,'<br/>' + A000TraduzioneStringhe(A000MSG_W040_MSG_FILE_SOVRASCRITTO));
    Msg:=Format(A000TraduzioneStringhe(A000MSG_W040_ERR_FMT_CONFERMA_UPLOAD),[NomeFile,TabValori,Msg]);
    MsgBox.TextIsHTML:=True;
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],OnConfermaUpload,PathFileDest,'Conferma upload',mbNo);
  end
  else
  begin
    // errore sintassi nome file
    Msg:=Format(A000TraduzioneStringhe(A000MSG_W040_ERR_FMT_LIV_FORMATO_FILE),[NomeFile,ErrFormato,TabValori]);
    MsgBox.TextIsHTML:=True;
    MsgBox.MessageBox(Msg,ESCLAMA);
  end;
end;

procedure TW040FUploadDocumenti.OnConfermaUpload(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
// conferma dell'upload
var
  PathFileDest,CartellaFile,NomeFile: String;
begin
  // il path del file è indicato nel keyid
  PathFileDest:=KeyID;

  if Res = mrYes then
  begin
    // effettua upload
    Upload(PathFileDest);

    // rilegge i file nella cartella
    CartellaFile:=TPath.GetDirectoryName(PathFileDest);
    NomeFile:=TPath.GetFileName(PathFileDest);
    ElencaFile(CartellaFile);

    // messaggio di avvenuto caricamento
    Notifica('Upload effettuato',Format(A000TraduzioneStringhe(A000MSG_W040_MSG_FMT_UPLOAD_OK),[NomeFile]),'',False,False,15000);
  end
  else
  begin
    { DONE : TEST IW 15 }
    // nessun upload, reimposto manualmente lo stato del file uploader
    IWFile.Ripristina;
  end;
end;

procedure TW040FUploadDocumenti.Upload(const PPathFileDest: String);
// effettua l'upload del file indicato
begin
  // se il file è già presente nella cartella lo elimina
  if TFile.Exists(PPathFileDest) then
    TFile.Delete(PPathFileDest);

  // upload
  { DONE : TEST IW 15 }
  try
    IWFile.SalvaSuFile(PPathFileDest);
    IWFile.Ripristina;
  except
    on E: Exception do
    begin
      IWFile.Ripristina;
      MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W040_ERR_FMT_DOC_UPLOAD),[E.Message]),ERRORE);
      Exit;
    end;
  end;
end;

end.
