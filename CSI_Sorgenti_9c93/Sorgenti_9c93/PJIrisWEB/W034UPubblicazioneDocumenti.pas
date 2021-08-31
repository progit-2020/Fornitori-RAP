unit W034UPubblicazioneDocumenti;

interface

uses
  A000UInterfaccia, A000UCostanti, A000USessione, W000UMessaggi,
  R010UPaginaWeb, A118UPubblicazioneDocumentiMW, W034UPubblicazioneDocumentiDM,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, StrUtils, Math,
  Windows, IWGlobal, Oracle, OracleData, DB, DBClient, IWApplication,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IWVCLComponent, IWBaseLayoutComponent, meIWMemo,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, meIWLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWCompEdit,
  IWCompGrids, IWDBGrids, meIWDBGrid, IWCompButton,
  meIWImageFile, IWCompMemo, medpIWDBGrid, IWLayoutMgrForm, IWLayoutMgrHTML,
  meIWButton, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IW.Browser.InternetExplorer, IWCompCheckbox, meIWCheckBox,
  meIWGrid, meIWComboBox, ActnList, Menus, IWCompMenu, medpIWMultiColumnComboBox,
  System.IOUtils;

type
  TFiltroDocumenti = record
    FLabel: TmeIWLabel;
    FCombo: TmeIWComboBox;
  end;

  TW034FPubblicazioneDocumenti = class(TR010FPaginaWeb)
    lblTipologie: TmeIWLabel;
    lblDescTipologia: TmeIWLabel;
    memDettaglio: TmeIWMemo;
    grdDocumenti: TmedpIWDBGrid;
    ajnCarica: TIWAJAXNotifier;
    ajnPopola: TIWAJAXNotifier;
    ajnVisualizza: TIWAJAXNotifier;
    lnkVisualizza: TmeIWLink;
    chkDettaglio: TmeIWCheckBox;
    grdFiltroDocumenti: TmeIWGrid;
    lblFiltroDocumenti: TmeIWLabel;
    cmbTipologie: TMedpIWMultiColumnComboBox;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdDocumentiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdDocumentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure ajnCaricaNotify(Sender: TObject);
    procedure ajnPopolaNotify(Sender: TObject);
    procedure ajnVisualizzaNotify(Sender: TObject);
    procedure lnkVisualizzaClick(Sender: TObject);
    procedure grdFiltroDocumentiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure IWAppFormRender(Sender: TObject);
    procedure cmbTipologieAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure chkDettaglioAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    A118MW: TA118FPubblicazioneDocumentiMW;
    W034DM: TW034FPubblicazioneDocumentiDM;
    StatoElab: String;
    FiltroDocArr: array of TFiltroDocumenti;
    procedure cmbFiltroDocumentiChange(Sender: TObject);
    procedure MessaggioPopup(const Testo: String);
    procedure EstraiStrutture;
    procedure CaricaDatiStruttura;
    procedure AddToDataset(const PLiv: Integer);
    procedure PopolaTabella;
    procedure ClearFiltri;
    procedure GestioneFiltri;
    procedure ScorriPath(const PDirNameCompleto: String; PLiv: Integer);
    procedure imgSalvaClick(Sender: TObject);
    //procedure imgVisualizzaClick(Sender: TObject);
  protected
    function  GetInfoFunzione: String; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso: Boolean; override;
  end;

const
  // campi di appoggio
  CAMPO_NOME_DOCUMENTO = '_NOME_DOCUMENTO';
  CAMPO_PATH_DOCUMENTO = '_PATH_DOCUMENTO';
  CAMPO_EXT_DOCUMENTO  = '_EXT_DOCUMENTO';

implementation

{$R *.dfm}

function TW034FPubblicazioneDocumenti.InizializzaAccesso:Boolean;
var
  S: string;
begin
  Result:=True;
  EstraiStrutture;

  // EMPOLI_ASL11 - chiamata 82749.ini
  // proporre il primo elemento anche se esistono più tipologie visibili
  {
  // se esiste una sola tipologia visibile, la seleziona automaticamente
  if cmbTipologie.Items.Count = 1 then
  }
  if cmbTipologie.Items.Count > 0 then
  // EMPOLI_ASL11 - chiamata 82749.fine
  begin
    cmbTipologie.ItemIndex:=0;
    cmbTipologie.Text:=cmbTipologie.Items[0].RowData[0];
    S:=Format('processAjaxEvent("onChange", %sIWCL,"%s.DoAsyncChange",true,null,true); ',
              [cmbTipologie.HTMLName,cmbTipologie.HTMLName]);
    AddToInitProc(S);
  end;
end;

procedure TW034FPubblicazioneDocumenti.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  W034DM:=TW034FPubblicazioneDocumentiDM.Create(nil);
  A118MW:=TA118FPubblicazioneDocumentiMW.Create(nil);

  // tabella richieste
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdDocumenti.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdDocumenti.medpDataSet:=W034DM.cdsFile;
  grdDocumenti.medpTestoNoRecord:='Nessun documento';
  grdDocumenti.medpRowSelect:=False;
  grdDocumenti.medpComandiCustom:=True;

  chkDettaglio.Visible:=(DebugHook <> 0) or (Parametri.Operatore = 'SYSMAN') or (Parametri.Operatore = 'MONDOEDP');
  if chkDettaglio.Visible then
  begin
    // imposta le variabili Parametri.xxx in base al dipendente attualmente selezionato
    // PRE: WR000DM.cdsAnagrafe.Active and WR000DM.cdsAnagrafe.RecordCount > 0
    //A118MW.ParOperatore:= ???
    A118MW.ParProgressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    A118MW.ParMatricola:=WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString;
  end
  else
  begin
    A118MW.ParOperatore:=Parametri.Operatore;
    A118MW.ParMatricola:=Parametri.MatricolaOper;
    A118MW.ParProgressivo:=Parametri.ProgressivoOper;
  end;
end;

procedure TW034FPubblicazioneDocumenti.IWAppFormRender(Sender: TObject);
begin
  inherited;

  // tabella filtro dati
  lblFiltroDocumenti.Visible:=grdFiltroDocumenti.ColumnCount > 1;
  grdFiltroDocumenti.Visible:=grdFiltroDocumenti.ColumnCount > 1;
  AddToInitProc(Format('document.getElementById("W034FiltroDocumenti").className = "groupbox fs100 %s"; ',
                       [IfThen(grdFiltroDocumenti.Visible,'','invisibile')]));
end;

function TW034FPubblicazioneDocumenti.GetInfoFunzione: String;
begin
  Result:=A000TraduzioneStringhe(A000MSG_W034_MSG_TIPOLOGIA_DOC) + ': ' + IfThen(cmbTipologie.Text = '','',cmbTipologie.Text);
end;

procedure TW034FPubblicazioneDocumenti.DistruggiOggetti;
begin
  try ClearFiltri; except end;
  try FreeAndNil(A118MW); except end;
  try FreeAndNil(W034DM); except end;
end;

procedure TW034FPubblicazioneDocumenti.grdDocumentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
begin
  // righe dei dati
  for i:=0 to High(grdDocumenti.medpCompGriglia) do
  begin
    // salva
    with (grdDocumenti.medpCompCella(i,0,0) as TmeIWImageFile) do
    begin
      FriendlyName:=IntToStr(i);
      OnClick:=imgSalvaClick;
      ScriptEvents.HookEvent('onClick','ReleaseLock(); GActivateLock = false; return true;');
    end;
    {
    // visualizza
    with (grdDocumenti.medpCompCella(i,0,1) as TmeIWImageFile) do
    begin
      FriendlyName:=IntToStr(i);
      OnClick:=imgVisualizzaClick;
    end;
    }
  end;
end;

procedure TW034FPubblicazioneDocumenti.grdDocumentiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
begin
  if not GGetWebApplicationThreadVar.IsCallback then
  begin
    if not grdDocumenti.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
      Exit;

    NumColonna:=grdDocumenti.medpNumColonna(AColumn);
    Campo:=grdDocumenti.medpColonna(NumColonna).DataField;

    if ARow > 0 then
    begin
      if Campo <> CAMPO_PATH_DOCUMENTO then
        ACell.Css:=ACell.Css.Replace('align_right','',[]).Replace('align_left','',[]) + ' align_center';
    end;

    // assegnazione componenti
    if (ARow > 0) and (ARow <= High(grdDocumenti.medpCompGriglia) + 1) and (grdDocumenti.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
    begin
      ACell.Text:='';
      ACell.Control:=grdDocumenti.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
    end;
  end;
end;

procedure TW034FPubblicazioneDocumenti.grdFiltroDocumentiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if not GGetWebApplicationThreadVar.IsCallback then
  begin
    RenderCell(ACell,ARow,AColumn,False,False,False);
  end;
end;

procedure TW034FPubblicazioneDocumenti.ajnCaricaNotify(Sender: TObject);
// carica la struttura dati
begin
  try
    CaricaDatiStruttura;
    ajnPopola.Notify;
  except
    on E: Exception do
    begin
      StatoElab:=Format('La tipologia di documento "%s" presenta un errore nella struttura:%s%s',[cmbTipologie.Text,CRLF,E.Message]);
      MessaggioPopup('');
      ajnVisualizza.Notify;
    end;
  end;
end;

procedure TW034FPubblicazioneDocumenti.ajnPopolaNotify(Sender: TObject);
// scorre il path e popola il clientdataset
begin
  try
    PopolaTabella;
  except
    on E: Exception do
      StatoElab:=Format('%s (%s)',[E.Message,E.ClassName]);
  end;
  if StatoElab <> '' then
    StatoElab:=Format('Errore nella visualizzazione dei documenti di tipo "%s":%s%s',[cmbTipologie.Text,CRLF,StatoElab]);
  MessaggioPopup('');
  ajnVisualizza.Notify;
end;

procedure TW034FPubblicazioneDocumenti.ajnVisualizzaNotify(Sender: TObject);
// tabella caricata: aggiorna visualizzazione
var
  S: String;
begin
  S:=Format('SubmitClick("%s","",true); ',[lnkVisualizza.HTMLName]);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(S);
end;

procedure TW034FPubblicazioneDocumenti.lnkVisualizzaClick(Sender: TObject);
// visualizza la tabella
begin
  if StatoElab = '' then
  begin
    Log('Traccia','grdDocumenti.medpCaricaCDS.ini;');
    grdDocumenti.medpCaricaCDS;
    Log('Traccia','grdDocumenti.medpCaricaCDS.fine;');

    GestioneFiltri; // bugfix - in async dà access violation se si modifica la grid

    grdDocumenti.Visible:=True;
    memDettaglio.Visible:=chkDettaglio.Checked;
  end
  else
  begin
    // errore
    MsgBox.MessageBox(StatoElab,ESCLAMA);
  end;
end;

procedure TW034FPubblicazioneDocumenti.cmbFiltroDocumentiChange(Sender: TObject);
// gestione del filtro del dataset
var
  c: Integer;
  IWCmb: TmeIWComboBox;
  Campo,Valore,Filtro: String;
begin
  W034DM.cdsFile.Filtered:=False;
  Filtro:='';
  c:=1;
  while c < grdFiltroDocumenti.ColumnCount do
  begin
    if Assigned(grdFiltroDocumenti.Cell[0,c].Control) then
    begin
      // se la combobox ha un filtro specificato, lo applica
      IWCmb:=(grdFiltroDocumenti.Cell[0,c].Control as TmeIWComboBox);
      if IWCmb.ItemIndex > 0 then
      begin
        Campo:=IWCmb.FriendlyName;
        Valore:=IWCmb.Text;
        Filtro:=Format('%s and (%s = ''%s'')',[Filtro,Campo,Valore]);
      end;
    end;
    c:=c + 2;
  end;
  if Filtro <> '' then
    Filtro:=Copy(Filtro,6);

  W034DM.cdsFile.Filter:=Filtro;
  W034DM.cdsFile.Filtered:=(Filtro <> '');
  grdDocumenti.medpCaricaCDS;
end;

procedure TW034FPubblicazioneDocumenti.cmbTipologieAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  if cmbTipologie.ItemIndex = -1 then
    lblDescTipologia.Caption:=''
  else
    lblDescTipologia.Caption:=cmbTipologie.Items[cmbTipologie.ItemIndex].RowData[1];
  grdDocumenti.Visible:=False;
  memDettaglio.Visible:=False;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('$("#W034FiltroDocumenti").fadeOut(200); ');
  grdFiltroDocumenti.Visible:=False;
  StatoElab:='';
  if chkDettaglio.Visible then
  begin
    // imposta le variabili Parametri.xxx in base al dipendente attualmente selezionato
    // PRE: WR000DM.cdsAnagrafe.Active and WR000DM.cdsAnagrafe.RecordCount > 0
    //A118MW.ParOperatore:= ???
    A118MW.ParProgressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    A118MW.ParMatricola:=WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString;
  end
  else
  begin
    A118MW.ParOperatore:=Parametri.Operatore;
    A118MW.ParMatricola:=Parametri.MatricolaOper;
    A118MW.ParProgressivo:=Parametri.ProgressivoOper;
  end;

  MessaggioPopup('Ricerca documenti in corso...');
  ajnCarica.Notify;
end;

procedure TW034FPubblicazioneDocumenti.chkDettaglioAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  // effettua una nuova ricerca dei documenti
  if cmbTipologie.ItemIndex > -1 then
    cmbTipologieAsyncChange(cmbTipologie,nil,0,'');
end;

procedure TW034FPubblicazioneDocumenti.MessaggioPopup(const Testo: String);
// imposta o nasconde un popup a scomparsa (elemento div in primo piano)
var
  SPop,Stile: String;
begin
  if GGetWebApplicationThreadVar.IsCallBack then
  begin
    if Testo = '' then
    begin
      // fadeout del messaggio
      SPop:='$("#avviso").fadeOut(400);';
    end
    else
    begin
      // fadein del messaggio
      Stile:='popup';
      if GetBrowser is TInternetExplorer then
        SPop:='$("#avviso").attr("class","").attr("class","%s")'
      else
        SPop:='$("#avviso").attr("class","").addClass("%s")';
      SPop:=SPop + '.hide().text("%s").fadeIn(800);';
      SPop:=Format(Spop,[Stile,Testo]);
    end;
    GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(SPop);
  end;
end;

procedure TW034FPubblicazioneDocumenti.EstraiStrutture;
// estrae i dati principali delle tipologie di documento
var
  Err: String;
begin
  Log('Traccia','EstraiStrutture.ini');

  // estrazione delle tipologie di documento
  with A118MW.selI200 do
  begin
    First;
    while not Eof do
    begin
      if A118MW.CheckFiltroDoc(FieldByName('FILTRO').AsString,Err) then
        cmbTipologie.AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
  Log('Traccia','EstraiStrutture.fine');
end;

procedure TW034FPubblicazioneDocumenti.CaricaDatiStruttura;
var
  CampiIndice,TipoCampoStr,Nome: String;
  CampoObj: TCampo;
  i: Integer;
begin
  Log('Traccia','CaricaDatiStruttura.ini');
  Log('Traccia',Format('Codice struttura: "%s"',[cmbTipologie.Text]));

  // imposta codice tipologia documento
  A118MW.Codice:=cmbTipologie.Text;

  // imposta la struttura del clientdataset di visualizzazione
  // aggiungendo i campi variabili della tabella I202
  Log('Traccia','Creazione struttura clientdataset.ini');
  CampiIndice:='';
  W034DM.cdsFile.Close;
  // MONDOEDP - chiamata 85032.ini
  // bugfix: è necessario rimuovere eventuali filtri già impostati
  W034DM.cdsFile.Filtered:=False;
  W034DM.cdsFile.Filter:='';
  // MONDOEDP - chiamata 85032.fine
  W034DM.cdsFile.FieldDefs.Clear;
  W034DM.cdsFile.FieldDefs.Add(CAMPO_PATH_DOCUMENTO,ftString,500,False);
  W034DM.cdsFile.FieldDefs.Add(CAMPO_NOME_DOCUMENTO,ftString,100,False);
  W034DM.cdsFile.FieldDefs.Add(CAMPO_EXT_DOCUMENTO,ftString,10,False);

  // ciclo sui dettagli
  A118MW.selI202.Filtered:=False;
  A118MW.selI202.First;
  while not A118MW.selI202.Eof do
  begin
    // utilizza la struttura dati "campo" per impostare la creazione del field sul clientdataset
    CampoObj:=TCampo.Create;
    CampoObj.Campo:=A118MW.selI202.FieldByName('CAMPO').AsString;
    CampoObj.Dal:=A118MW.selI202.FieldByName('DAL').AsInteger;
    CampoObj.Lung:=A118MW.selI202.FieldByName('LUNG').AsInteger;
    CampoObj.Visibile:=A118MW.selI202.FieldByName('VISIBILE').AsString;
    // se il campo è variabile valuta se aggiungerlo al clientdataset
    if CampoObj.Variabile then
    begin
      // se il campo è impostato come visibile e non è ancora presente nel clientdataset lo aggiunge
      if (CampoObj.Visibile = 'S') and
         (W034DM.cdsFile.FieldDefs.IndexOf(CampoObj.Campo) = -1) then
      begin
        // aggiunge il campo al dataset
        case CampoObj.TipoCampo of
          ftInteger:   TipoCampoStr:='integer';
          ftDateTime:  TipoCampoStr:='datetime';
          ftString:    TipoCampoStr:=Format('string(%d)',[CampoObj.SizeCampo]);
        else
          TipoCampoStr:='';
        end;
        Log('Traccia',Format('Campo "%s" variabile: aggiunto alla struttura [%s]',[CampoObj.Campo,TipoCampoStr]));
        W034DM.cdsFile.FieldDefs.Add(CampoObj.Campo,CampoObj.TipoCampo,CampoObj.SizeCampo,False);

        // indice per ordinamento campi data
        if (CampoObj.RifData) and (Pos(CampoObj.Campo + ';',CampiIndice) = 0) then
        begin
          CampiIndice:=CampiIndice + CampoObj.Campo + ';';
          Log('Traccia',Format('Campo "%s": aggiunto all''indice per l''ordinamento',[CampoObj.Campo]));
        end;
      end
      else
      begin
        Log('Traccia',Format('Campo "%s" variabile: già esistente',[CampoObj.Campo]));
      end;
    end
    else
    begin
      // i campi costanti non vengono aggiunti alla struttura
      Log('Traccia',Format('Campo "%s" costante: NON aggiunto alla struttura',[CampoObj.Campo]));
    end;

    A118MW.selI202.Next;
  end;
  // impostazione indice clientdataset
  W034DM.cdsFile.IndexName:='';
  W034DM.cdsFile.IndexDefs.Clear;
  if CampiIndice <> '' then
  begin
    CampiIndice:=Copy(CampiIndice,1,Length(CampiIndice) - 1);
    W034DM.cdsFile.IndexDefs.Add('DataDesc',(CampiIndice),[ixDescending]);
    W034DM.cdsFile.IndexName:='DataDesc';
  end;
  // creazione dataset
  W034DM.cdsFile.CreateDataSet;
  W034DM.cdsFile.LogChanges:=False;
  // imposta le displaylabel dei campi
  for i:=0 to W034DM.cdsFile.FieldCount - 1 do
  begin
    Nome:=W034DM.cdsFile.Fields[i].DisplayName;
    if Nome = CAMPO_NOME_DOCUMENTO then
      W034DM.cdsFile.Fields[i].DisplayLabel:='Nome documento'
    else if Nome = CAMPO_PATH_DOCUMENTO then
      W034DM.cdsFile.Fields[i].DisplayLabel:='Path documento'
    else if Nome = CAMPO_EXT_DOCUMENTO then
      W034DM.cdsFile.Fields[i].DisplayLabel:='Tipo file'
    else
      W034DM.cdsFile.Fields[i].DisplayLabel:=R180Capitalize(Nome.Replace('_',' ',[rfReplaceAll]).Trim);
  end;
  Log('Traccia','Creazione struttura clientdataset.fine');

  // imposta la tabella
  grdDocumenti.medpAttivaGrid(W034DM.cdsFile,False,False);
  grdDocumenti.medpColonna(CAMPO_NOME_DOCUMENTO).Visible:=False;
  grdDocumenti.medpColonna(CAMPO_PATH_DOCUMENTO).Visible:=chkDettaglio.Checked;
  grdDocumenti.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','SALVA','Salva il documento','','C'{'S'});
  //grdDocumenti.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','STAMPA','Visualizza il documento','','D');

  {
  A118MW.Codice:=cmbTipologie.Text;
  }
  Log('Traccia',Format('Livello max definizione directory: %d',[A118MW.LivMaxDir]));
  Log('Traccia','CaricaDatiStruttura.fine');
end;

procedure TW034FPubblicazioneDocumenti.AddToDataset(const PLiv: Integer);
// aggiunge un record al clientdataset con le informazioni sul file attualmente considerato
var
  i: Integer;
  Campo, Val: String;
  LivObj: TLivello;
begin
  LivObj:=A118MW.Livello[PLiv];

  // aggiunge un nuovo record al dataset
  W034DM.cdsFile.Append;
  // imposta i campi del record
  for i:=0 to W034DM.cdsFile.FieldDefs.Count - 1 do
  begin
    Campo:=W034DM.cdsFile.FieldDefs[i].Name;

    // valutazione campi particolari
    if Campo = CAMPO_NOME_DOCUMENTO then
    begin
      // campo speciale: nome del documento
      // il nome da visualizzare non deve essere riconducibile al file originale
      Val:=GGetWebApplicationThreadVar.AppId + FormatDateTime('_hhhhnnss',Now) + LivObj.ExtFile;
    end
    else if Campo = CAMPO_PATH_DOCUMENTO then
    begin
      // campo speciale: path + nome file
      Val:=LivObj.PathFile + LivObj.NomeFile;
    end
    else if Campo = CAMPO_EXT_DOCUMENTO then
    begin
      // campo speciale: estensione file
      Val:=LivObj.ExtFile;
    end
    else
    begin
      // campo normale
      Val:=A118MW.GetValoreCampo(Campo,PLiv,True);
    end;

    // imposta il valore del campo
    try
      W034DM.cdsFile.FieldByName(Campo).AsString:=Val;
    except
      //...
    end;
  end;
  W034DM.cdsFile.Post;
end;

procedure TW034FPubblicazioneDocumenti.PopolaTabella;
var
  RootDirectory: String;
begin
  Log('Traccia','PopolaTabella.ini');

  memDettaglio.Lines.Clear;

  // percorre la struttura delle directory a partire dalla directory root
  // (se non è indicata esplicitamente utilizza la directory predefinita sul webserver)
  RootDirectory:=A118MW.RootDir;
  if not TDirectory.Exists(RootDirectory) then
  begin
    StatoElab:='la directory base per la ricerca dei documenti è inesistente o non accessibile';
    Log('Errore',Format('PopolaTabella: directory base inesistente: "%s"',[RootDirectory]));
    Exit;
  end;

  // informazioni di dettaglio per debug
  if chkDettaglio.Checked then
  begin
    memDettaglio.Lines.Add('[Informazioni utente]');
    memDettaglio.Lines.Add('(è ridefinito con il dipendente selezionato in Elenco anagrafe)');
    memDettaglio.Lines.Add('Operatore   = ' + Parametri.Operatore);
    memDettaglio.Lines.Add('Matricola   = ' + Parametri.MatricolaOper);
    memDettaglio.Lines.Add('Progressivo = ' + IntToStr(Parametri.ProgressivoOper));
    memDettaglio.Lines.Add('');
    memDettaglio.Lines.Add('[Informazioni struttura]');
    memDettaglio.Lines.Add(Format('Livello di profondità max cartelle =  %d',[A118MW.LivMaxDir]));
    memDettaglio.Lines.Add(Format('Livello di profondità file         >= %d',[A118MW.LivFile]));
    memDettaglio.Lines.Add('');
    memDettaglio.Lines.Add('[Risultati ricerca]');
    memDettaglio.Lines.Add('Cartella base = ' + RootDirectory);
    memDettaglio.Lines.Add('Liv.  Cartella');
  end;

  ScorriPath(RootDirectory,-1);
  //GestioneFiltri; // bugfix - in async dà access violation se si modifica la grid - spostato in lnkVisualizzaClick

  Log('Traccia','PopolaTabella.fine');
end;

procedure TW034FPubblicazioneDocumenti.ClearFiltri;
var
  i: Integer;
begin
  // distrugge gli elementi di interfaccia per filtro dati
  for i:=0 to High(FiltroDocArr) do
  begin
    FreeAndNil(FiltroDocArr[i].FLabel);
    FreeAndNil(FiltroDocArr[i].FCombo);
  end;
  SetLength(FiltroDocArr,0);
end;

procedure TW034FPubblicazioneDocumenti.GestioneFiltri;
// predispone eventualmente le combobox di filtro per i campi con più valori
var
  i,c: Integer;
  Campo: String;
  ValoriMultipli: Boolean;
begin
  // distrugge gli elementi di interfaccia per filtro dati
  ClearFiltri;

  // esce subito se non ci sono record nel clientdataset
  if W034DM.cdsFile.RecordCount = 0 then
  begin
    grdFiltroDocumenti.ColumnCount:=1;
    Exit;
  end;

  // crea gli elementi di interfaccia per filtro dati
  SetLength(FiltroDocArr,W034DM.cdsFile.FieldCount);
  for i:=0 to High(FiltroDocArr) do
  begin
    // combo per filtro su valore specifico
    FiltroDocArr[i].FCombo:=TmeIWComboBox.Create(Self);
    FiltroDocArr[i].FCombo.Items.Duplicates:=dupIgnore;
    FiltroDocArr[i].FCombo.Items.Sorted:=True;
    FiltroDocArr[i].FCombo.Items.Add('');
    FiltroDocArr[i].FCombo.FriendlyName:=W034DM.cdsFile.Fields[i].FieldName;

    // label con nome campo
    FiltroDocArr[i].FLabel:=TmeIWLabel.Create(Self);
    FiltroDocArr[i].FLabel.Caption:=W034DM.cdsFile.Fields[i].DisplayLabel;
    FiltroDocArr[i].FLabel.ForControl:=FiltroDocArr[i].FCombo;
  end;

  // popolamento delle combo con i valori distinct
  W034DM.cdsFile.First;
  while not W034DM.cdsFile.Eof do
  begin
    for i:=0 to W034DM.cdsFile.FieldCount - 1 do
    begin
      Campo:=W034DM.cdsFile.Fields[i].FieldName;
      if (Campo <> CAMPO_NOME_DOCUMENTO) and
         (Campo <> CAMPO_PATH_DOCUMENTO) then
      begin
        FiltroDocArr[i].FCombo.Items.Add(W034DM.cdsFile.Fields[i].AsString);
      end;
    end;
    W034DM.cdsFile.Next;
  end;

  // seleziona primo elemento
  for i:=0 to High(FiltroDocArr) do
  begin
    FiltroDocArr[i].FCombo.ItemIndex:=0;
    FiltroDocArr[i].FCombo.OnChange:=cmbFiltroDocumentiChange;
  end;

  // popola la grid di filtro
  grdFiltroDocumenti.ColumnCount:=W034DM.cdsFile.FieldCount * 2;
  c:=0;
  for i:=0 to High(FiltroDocArr) do
  begin
    // se i valori nella combo sono almeno due diversi, visualizza la combobox
    Campo:=FiltroDocArr[i].FCombo.FriendlyName;
    if (Campo <> CAMPO_NOME_DOCUMENTO) and
       (Campo <> CAMPO_PATH_DOCUMENTO) then
    begin
      ValoriMultipli:=FiltroDocArr[i].FCombo.Items.Count > 2;
      if ValoriMultipli then
      begin
        grdFiltroDocumenti.Cell[0,c].Control:=FiltroDocArr[i].FLabel;
        grdFiltroDocumenti.Cell[0,c + 1].Control:=FiltroDocArr[i].FCombo;
        c:=c + 2;
      end;
    end;
  end;

  grdFiltroDocumenti.ColumnCount:=max(1,c);
end;

procedure TW034FPubblicazioneDocumenti.ScorriPath(const PDirNameCompleto: String; PLiv: Integer);
// questa procedura utilizza chiamate ricorsive per attraversare le strutture
// delle directory, per cui vengono utilizzati i puntatori per mantenere
// minimo l'utilizzo dello stack.
{$WARN SYMBOL_PLATFORM OFF}
var
  SearchRec: ^TSearchRec;
  FileName: PString;
  NumFile: Integer;
  IsFile,FolderOK: Boolean;
  DirName,Prefisso,ErrMatchNome,ErrFolder,ErrFile: String;
  LivObj: TLivello;
begin
  if PDirNameCompleto.Trim = '' then
    Exit;
  Log('Traccia','ScorriPath.ini - livello ' + IntTostr(PLiv));
  W034DM.cdsFile.Filtered:=False;

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
    FolderOK:=LivObj.MatchNome(ttDipendente,ErrMatchNome);
    if FolderOK then
    begin
      FolderOK:=LivObj.MatchFiltro(ttDipendente);
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

  // dettaglio dell'attraversamento della struttura
  if chkDettaglio.Checked then
  begin
    if PLiv = -1 then
    begin
      Prefisso:=Format('%3s   ',['B']);
      memDettaglio.Lines.Add(Prefisso + DirName);
    end
    else
    begin
      Prefisso:=Format('%3d    ',[PLiv]);
      Prefisso:=Prefisso + DupeString('|    ',PLiv) + '|-- ';
      memDettaglio.Lines.Add(Prefisso + DirName + ErrFolder);
    end;
  end;

  // esce se la cartella non è da considerare
  if not FolderOK then
    Exit;

  // disabilita input/output checking
  {$I-}

  // alloca un nuovo record (SearchRec) e una nuova string (FileName)
  New(SearchRec);
  New(FileName);

  // esamina i file presenti nella directory
  try
    NumFile:=SysUtils.FindFirst(PDirNameCompleto + '\*.*',SysUtils.faAnyFile,SearchRec^);
    inc(PLiv);
    while NumFile = 0 do
    begin
      FileName^:=IncludeTrailingPathDelimiter(PDirNameCompleto) + SearchRec^.Name;

      // verifica il tipo di file: directory oppure file
      IsFile:=((SearchRec^.Attr and SysUtils.faDirectory) = 0);
      if IsFile then
      begin
        // tipo: file
        // considera i file a partire dal livello in cui è indicata l'estensione nella struttura
        if PLiv >= A118MW.LivFile then
        begin
          // -> esclude i file di sistema e i volume ID (C:, D:, ecc...)
          if ((SearchRec^.Attr and SysUtils.faSysFile) = 0) then
          begin
            // anche se il livello è più alto considera sempre il livello file
            ErrFile:='';
            LivObj:=A118MW.Livello[A118MW.LivFile];
            LivObj.PathFile:=ExtractFilePath(FileName^);
            LivObj.NomeFile:=ExtractFileName(FileName^);
            if LivObj.MatchNome(ttDipendente,ErrMatchNome) then
            begin
              if LivObj.MatchFiltro(ttDipendente) then
              begin
                AddToDataset(A118MW.LivFile);
              end
              else
              begin
                Log('Traccia',Format('Livello %2d; file "%s": filtro non soddisfatto',[PLiv,LivObj.NomeFile]));
                ErrFile:=' [ERR_FILTRO]';
              end;
            end
            else
            begin
              Log('Traccia',Format('Livello %2d; file "%s": sintassi del nome non corrispondente',[PLiv,LivObj.NomeFile]));
              ErrFile:=Format(' [ERR_NOME: %s]',[ErrMatchNome]);
            end;
            if chkDettaglio.Checked then
            begin
              Prefisso:=Format('%3d    ',[LivObj.Livello]) + DupeString('|    ',PLiv) + '|-- ';
              memDettaglio.Lines.Add(Prefisso + LivObj.NomeFile + LivObj.ExtFile + ErrFile);
            end;
          end;
        end;
      end
      else
      begin
        // tipo: directory
        // -> esclude le directory speciali "." e ".."
        if ((SearchRec^.Name <> '.') and (SearchRec^.Name <> '..')) then
        begin
          // -> chiamata ricorsiva
          ScorriPath(FileName^,PLiv);
        end;
      end;
      NumFile:=SysUtils.FindNext(SearchRec^);
    end;

    SysUtils.FindClose(SearchRec^);
  finally
    // rilascia la memoria allocata per le strutture
    System.Dispose(FileName);
    System.Dispose(SearchRec);
  end;

  Log('Traccia','ScorriPath.fine - livello ' + IntTostr(PLiv));
  // riabilita input/output checking
  {$I+}
{$WARN SYMBOL_PLATFORM ON}
end;

procedure TW034FPubblicazioneDocumenti.imgSalvaClick(Sender: TObject);
var
  i,c: Integer;
  FileDoc,NomeVisual: String;
  IWC: TIWDBGridColumn;
begin
  i:=StrToInt((Sender as TmeIWImageFile).FriendlyName);
  FileDoc:=grdDocumenti.medpValoreColonna(i,CAMPO_PATH_DOCUMENTO) + grdDocumenti.medpValoreColonna(i,CAMPO_EXT_DOCUMENTO);

  // nel nome documento cerca di inserire i dati delle colonne presenti a video
  NomeVisual:='';
  for c:=0 to grdDocumenti.Columns.Count - 1 do
  begin
    IWC:=grdDocumenti.medpColonna(c);
    if Assigned(IWC) then
    begin
      if (IWC.Visible) and
         (LeftStr(IWC.DataField,4) <> 'DBG_') and
         (IWC.DataField <> CAMPO_PATH_DOCUMENTO) and
         (IWC.DataField <> CAMPO_NOME_DOCUMENTO) and
         (IWC.DataField <> CAMPO_EXT_DOCUMENTO) then
      begin
        NomeVisual:=NomeVisual + grdDocumenti.medpValoreColonna(i,IWC.DataField) + '_';
      end;
    end;
  end;
  NomeVisual:=NomeVisual + grdDocumenti.medpValoreColonna(i,CAMPO_NOME_DOCUMENTO);

  if not TFile.Exists(FileDoc) then
    GGetWebApplicationThreadVar.ShowMessage('Si è verificato un problema durante il download del file: file inesistente')
  else
    GGetWebApplicationThreadVar.SendFile(FileDoc,True,'application/x-download',NomeVisual);
end;

{
procedure TW034FPubblicazioneDocumenti.imgVisualizzaClick(Sender: TObject);
begin
  VisualizzaFile(TmeIWImageFile(Sender).FriendlyName,lblDescTipologia.Caption,nil,nil);
end;
}

end.
