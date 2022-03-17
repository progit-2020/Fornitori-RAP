unit WC026UAllegatiIterFM;

{ DONE : TEST IW 15 }
{ Nuovo file uploader }

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000UMessaggi,
  W000UMessaggi,
  WR200UBaseFM,
  C021UDocumentiManagerDM,
  R010UPaginaWeb,
  C018UIterAutDM,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  Oracle, OracleData, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.IOUtils, System.Variants, System.Classes, Vcl.Graphics, meIWLink,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IWCompGrids, IWDBGrids, medpIWDBGrid,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  meIWButton, Data.DB, Datasnap.DBClient, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWImageFile, Math, meIWFileUploader, meIWEdit,
  IWCompLabel, meIWLabel, IWCompCheckbox, meIWCheckBox,
  System.StrUtils;

type
  TOnClose = procedure of object;
  TAbilitazioni = record
    Inserimento: Boolean;
    Modifica: Boolean;
    Cancellazione: Boolean;
    Info: String;
  end;

  TInfoAllegati = record
    AllegatiModificati: Boolean;
    AllegatiCancellati: Boolean;
    ElencoAllegatiInseriti: String;
    HintImmagine: String;
    GestAllegati: String;
    NumAllegati: Integer;
    procedure Clear; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    function EsistonoModifiche: Boolean;{$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    function AllegatiInseriti: Boolean; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    function IdInAllegatiInseriti(const PId: Integer): Boolean; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    procedure AggiungiAdAllegatiInseriti(const PId: Integer); {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    procedure RimuoviDaAllegatiInseriti(const PId: Integer); {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
  end;

  TWC026FAllegatiIterFM = class(TWR200FBaseFM)
    cdsAllegati: TClientDataSet;
    cdsAllegatiC_NOME_FILE: TStringField;
    cdsAllegatiC_DIMENSIONE: TStringField;
    cdsAllegatiNOTE: TStringField;
    cdsAllegatiID: TFloatField;
    cdsAllegatiID_T960: TFloatField;
    cdsAllegatiNOME_FILE: TStringField;
    cdsAllegatiEXT_FILE: TStringField;
    cdsAllegatiDIMENSIONE: TFloatField;
    btnChiudi: TmeIWButton;
    grdAllegati: TmedpIWDBGrid;
    lblInfo: TmeIWLabel;
    chkConfermaAllegatiOriginali: TmeIWCheckBox;
    procedure btnChiudiClick(Sender: TObject);
    procedure grdAllegatiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdAllegatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    function grdAllegatiBeforeInserisci(Sender: TObject): Boolean;
    procedure grdAllegatiConferma(Sender: TObject);
    procedure grdAllegatiCancella(Sender: TObject);
    procedure cdsAllegatiAfterCancel(DataSet: TDataSet);
    procedure cdsAllegatiAfterPost(DataSet: TDataSet);
    procedure cdsAllegatiBeforeEdit(DataSet: TDataSet);
    procedure cdsAllegatiBeforeInsert(DataSet: TDataSet);
    procedure cdsAllegatiCalcFields(DataSet: TDataSet);
    procedure cdsAllegatiNewRecord(DataSet: TDataSet);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure chkConfermaAllegatiOriginaliAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    iIWFile: Integer;
    IterMaxAllegati: Integer;
    IterMaxDimAllegatoMB: Integer;
    procedure PopolaDati;
    procedure lnkDownloadAllegatoClick(Sender: TObject);
    procedure GestioneConfermaAllegatiInseriti; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
  public
    C018: TC018FIterAutDM;
    C021DM: TC021FDocumentiManagerDM;
    InfoAllegati: TInfoAllegati;
    Abilitazioni: TAbilitazioni;
    procedure Visualizza;
    procedure ReleaseOggetti; override;
    procedure AssegnaFiltroEstensioni(Sender: TObject);
  end;

implementation

uses
  IWApplication, IWGlobal, IWAppForm;

{$R *.dfm}

procedure TWC026FAllegatiIterFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;

  // controllo abilitazione modulo
  if FALSE then//not (WR000DM.ModuliAccessori.IsAbilitato(Parametri.Azienda,'PUBBL_DOCUMENTI_ESTERNI')) then
    raise Exception.Create('Funzione non disponibile: modulo Pubblicazione documenti esterni non abilitato!');

  // checkbox di conferma allegati conformi agli originali
  chkConfermaAllegatiOriginali.Caption:=A000TraduzioneStringhe(A000MSG_WC026_MSG_CONFERMA_ALLEG_ORIGINALI);
  chkConfermaAllegatiOriginali.Visible:=False;
  btnChiudi.Enabled:=True;

  // crea datamodulo di servizio per allegati
  C021DM:=TC021FDocumentiManagerDM.Create(Self);
  C021DM.Maschera:=(Self.Parent as TR010FPaginaWeb).medpCodiceForm;

  // resetta informazioni allegati
  InfoAllegati.Clear;
end;

procedure TWC026FAllegatiIterFM.ReleaseOggetti;
begin
  try C018.selT853_T960.Close; except end;
  // distrugge datamodulo di servizio per allegati
  //FreeAndNil(C021DM);//il free viene già fatto da Self.Free in quanto è il C021DM è creato specificando l'owner = Self
end;

procedure TWC026FAllegatiIterFM.Visualizza;
var
  Titolo: String;
begin
  // variabili integer relative ai parametri aziendali
  IterMaxAllegati:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxAllegati,999);
  if IterMaxAllegati < 0 then
    IterMaxAllegati:=999;
  if C018.Iter = ITER_MISSIONI then
    IterMaxAllegati:=StrToIntDef(Parametri.CampiRiferimento.C8_W032MaxAllegati,IterMaxAllegati);

  IterMaxDimAllegatoMB:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB,5);

  // popolamento allegati
  PopolaDati;

  // indicazione per utente
  if Abilitazioni.Modifica then
  begin
    if IterMaxAllegati = 1 then
      lblInfo.Caption:=Format(A000TraduzioneStringhe(A000MSG_WC026_MSG_FMT_INFO_ALLEGATI_1),[IterMaxDimAllegatoMB])
    else
      lblInfo.Caption:=Format(A000TraduzioneStringhe(A000MSG_WC026_MSG_FMT_INFO_ALLEGATI_N),[IterMaxAllegati,IterMaxDimAllegatoMB]);
  end
  else
  begin
    lblInfo.Caption:=Format(A000TraduzioneStringhe(A000MSG_WC026_MSG_FMT_INFO_ABIL_ALLEGATI),[Abilitazioni.Info]);
  end;

  // visualizzazione del frame
  grdAllegati.Caption:=Format(A000TraduzioneStringhe(A000MSG_WC026_MSG_RICHIESTA) + ' %d',[C018.Id]);
  Titolo:=Format(A000TraduzioneStringhe(A000MSG_WC026_MSG_FMT_ALLEGATI_ITER),[C018.DescIter,C018.DescCodIter]);
  (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(JQuery,700,-1,EM2PIXEL * 24,Titolo,'#' + Name,False,True,-1,'','',btnChiudi.HTMLName);
end;

procedure TWC026FAllegatiIterFM.PopolaDati;
begin
  // effettua lettura allegati da db
  InfoAllegati.HintImmagine:=C018.LeggiAllegati;
  InfoAllegati.GestAllegati:=C018.GetCondizioneAllegati;
  InfoAllegati.NumAllegati:=C018.selT853_T960.RecordCount;

  // copia i dati sul clientdataset per la gestione inline nella grid
  if (cdsAllegati.Active) and (cdsAllegati.State <> dsBrowse) then
    cdsAllegati.Cancel;
  cdsAllegati.EmptyDataSet;
  C018.selT853_T960.First;
  while not C018.selT853_T960.Eof do
  begin
    cdsAllegati.Append;
    cdsAllegati.FieldByName('ID').AsFloat:=C018.selT853_T960.FieldByName('ID').AsFloat;
    cdsAllegati.FieldByName('ID_T960').AsFloat:=C018.selT853_T960.FieldByName('ID_T960').AsFloat;
    cdsAllegati.FieldByName('NOME_FILE').AsString:=C018.selT853_T960.FieldByName('NOME_FILE').AsString;
    cdsAllegati.FieldByName('EXT_FILE').AsString:=C018.selT853_T960.FieldByName('EXT_FILE').AsString;
    cdsAllegati.FieldByName('DIMENSIONE').AsFloat:=C018.selT853_T960.FieldByName('DIMENSIONE').AsFloat;
    cdsAllegati.FieldByName('NOTE').AsString:=C018.selT853_T960.FieldByName('NOTE').AsString;
    cdsAllegati.Post;

    C018.selT853_T960.Next;
  end;

  // imposta la tabella degli allegati
  grdAllegati.medpPaginazione:=True;
  grdAllegati.medpRighePagina:=99999;
  grdAllegati.medpTestoNoRecord:='Nessun allegato';
  grdAllegati.medpAttivaGrid(cdsAllegati,Abilitazioni.Modifica,Abilitazioni.Inserimento,Abilitazioni.Cancellazione);
  grdAllegati.medpPreparaComponentiDefault;
  iIWFile:=grdAllegati.medpIndexColonna('C_NOME_FILE');
  grdAllegati.medpPreparaComponenteGenerico('WR102',iIWFile,0,DBG_FPK,'','','','','C');
  grdAllegati.medpPreparaComponenteGenerico('WR102-R',iIWFile,0,DBG_LNK,'','','','','');
  grdAllegati.medpCaricaCDS;

  if Parametri.CampiRiferimento.C90_IterEstensioneAllegato <> '' then
    grdAllegati.OnInserisci:=AssegnaFiltroEstensioni;
end;

procedure TWC026FAllegatiIterFM.AssegnaFiltroEstensioni(Sender: TObject);
var
  LIWFile: TmeIWFileUploader;
begin
	LIWFile:=(grdAllegati.medpCompCella(0,iIWFile,0) as TmeIWFileUploader);
  LIWFile.AllowedExtensions:=Parametri.CampiRiferimento.C90_IterEstensioneAllegato;
end;

procedure TWC026FAllegatiIterFM.btnChiudiClick(Sender: TObject);
begin
  ReleaseOggetti;
  Free;
end;

// #################### G E S T I O N E   D O C U M E N T I ####################

procedure TWC026FAllegatiIterFM.lnkDownloadAllegatoClick(Sender: TObject);
// effettua il download dell'allegato
var
  LId: Integer;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
begin
  // estrae id richiesta dal tag del componente
  LId:=(Sender as TmeIWLink).Tag;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  // estrae il file con i metadati associati
  A000SessioneWEB.AnnullaTimeOut;
  try
    LResCtrl:=C021DM.GetById(LId,True,LDoc);

    if not LResCtrl.Ok then
    begin
      MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
      Exit;
    end;

    // invia il file al browser
    GGetWebApplicationThreadVar.SendFile(LDoc.FilePath,True,'application/x-download',LDoc.GetNomeFileCompleto);
  finally
    FreeAndNil(LDoc);
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

// ################ G E S T I O N E   C L I E N T D A T A S E T ################

procedure TWC026FAllegatiIterFM.cdsAllegatiAfterCancel(DataSet: TDataSet);
begin
  cdsAllegati.FieldByName('C_NOME_FILE').ReadOnly:=False;
  cdsAllegati.FieldByName('C_DIMENSIONE').ReadOnly:=False;
end;

procedure TWC026FAllegatiIterFM.cdsAllegatiAfterPost(DataSet: TDataSet);
begin
  cdsAllegati.FieldByName('C_NOME_FILE').ReadOnly:=False;
  cdsAllegati.FieldByName('C_DIMENSIONE').ReadOnly:=False;
end;

procedure TWC026FAllegatiIterFM.cdsAllegatiBeforeEdit(DataSet: TDataSet);
begin
  cdsAllegati.FieldByName('C_NOME_FILE').ReadOnly:=True;
  cdsAllegati.FieldByName('C_DIMENSIONE').ReadOnly:=True;
end;

procedure TWC026FAllegatiIterFM.cdsAllegatiBeforeInsert(DataSet: TDataSet);
begin
  cdsAllegati.FieldByName('C_NOME_FILE').ReadOnly:=False;
  cdsAllegati.FieldByName('C_DIMENSIONE').ReadOnly:=True;
end;

procedure TWC026FAllegatiIterFM.cdsAllegatiCalcFields(DataSet: TDataSet);
begin
  // nome file completo
  if not cdsAllegati.FieldByName('C_NOME_FILE').ReadOnly then
  begin
    if cdsAllegati.FieldByName('NOME_FILE').AsString.Trim = '' then
      cdsAllegati.FieldByName('C_NOME_FILE').AsString:=''
    else
      cdsAllegati.FieldByName('C_NOME_FILE').AsString:=Format('%s.%s',[cdsAllegati.FieldByName('NOME_FILE').AsString,cdsAllegati.FieldByName('EXT_FILE').AsString]);
  end;

  // dimensione del file
  if not cdsAllegati.FieldByName('C_DIMENSIONE').ReadOnly then
  begin
    cdsAllegati.FieldByName('C_DIMENSIONE').AsString:=R180GetFileSizeStr(cdsAllegati.FieldByName('DIMENSIONE').AsInteger);
  end;
end;

procedure TWC026FAllegatiIterFM.cdsAllegatiNewRecord(DataSet: TDataSet);
begin
  // imposta valori di default per il nuovo allegato
  cdsAllegati.FieldByName('ID').AsInteger:=C018.Id;
end;

procedure TWC026FAllegatiIterFM.chkConfermaAllegatiOriginaliAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  btnChiudi.Enabled:=chkConfermaAllegatiOriginali.Checked;
end;

// ###################### G E S T I O N E   T A B E L L A ######################

procedure TWC026FAllegatiIterFM.grdAllegatiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
  ExtFile: String;
  IWC: TIWCustomControl;
  IWLnk: TmeIWLink;
  IWImg: TmeIWImageFile;
begin
  // gestione riga inserimento
  if grdAllegati.medpRigaInserimento then
  begin
    // abilita il submit dei file sull'immagine di conferma
    IWImg:=(grdAllegati.medpCompCella(0,0,2) as TmeIWImageFile);
    { DONE : TEST IW 15 }
    //IWImg.DontSubmitFiles:=False;
  end;

  for i:=IfThen(grdAllegati.medpRigaInserimento,1,0) to High(grdAllegati.medpCompGriglia) do
  begin
    // link per download documento
    IWC:=grdAllegati.medpCompCella(i,iIWFile,0);
    if IWC <> nil then
    begin
      if IWC is TmeIWLink then
      begin
        ExtFile:=grdAllegati.medpValoreColonna(i,'EXT_FILE');
        IWLnk:=TmeIWLink(IWC);
        IWLnk.Css:='link file_ext';
        { DONE : TEST IW 15 }
        //IWLnk.DontSubmitFiles:=True;
        IWLnk.ExtraTagParams.Add(Format('data-file-ext=%s',[ExtFile]));
        IWLnk.Hint:=Format('Download del file (%s)',[grdAllegati.medpValoreColonna(i,'C_DIMENSIONE')]);
        IWLnk.medpDownloadButton:=True;
        IWLnk.Tag:=grdAllegati.medpValoreColonna(i,'ID_T960').ToInteger;
        IWLnk.Text:=grdAllegati.medpValoreColonna(i,'C_NOME_FILE');
        IWLnk.OnClick:=lnkDownloadAllegatoClick;
      end;
    end;
  end;
end;

function TWC026FAllegatiIterFM.grdAllegatiBeforeInserisci(Sender: TObject): Boolean;
begin
  // controllo max allegati
  Result:=True;
  if grdAllegati.medpDataSet.RecordCount >= IterMaxAllegati then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_WC026_ERR_FMT_MAX_ALLEGATI),[IterMaxAllegati]));
end;

procedure TWC026FAllegatiIterFM.grdAllegatiCancella(Sender: TObject);
// operazioni in fase di cancellazione dell'allegato
var
  i, LIdDoc: Integer;
  FN : String;
  LResCtrl: TResCtrl;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdAllegati.medpRigaDiCompGriglia(FN);

  try
    // estrae id documento da cancellare
    LIdDoc:=grdAllegati.medpValoreColonna(i,'ID_T960').ToInteger;
    try
      // elimina il riferimento all'allegato dalla tabella T853
      C018.delT853.SetVariable('ID',C018.Id);
      C018.delT853.SetVariable('ID_T960',LIdDoc);
      C018.delT853.Execute;

      //Log.ini
      RegistraLog.SettaProprieta('C', 'T960_DOCUMENTI_INFO',C021DM.Maschera, C018.selTabellaIter, True);
      RegistraLog.InserisciDato('ID_ALLEGATO', LIdDoc.ToString, '');
      RegistraLog.InserisciDato('NOME_FILE', grdAllegati.medpValoreColonna(i,'NOME_FILE'), '');
      RegistraLog.InserisciDato('EXT_FILE', grdAllegati.medpValoreColonna(i,'EXT_FILE'), '');
      if grdAllegati.medpValoreColonna(i,'NOTE') <> '' then
        RegistraLog.InserisciDato('NOTE', grdAllegati.medpValoreColonna(i,'NOTE'), '');
      RegistraLog.RegistraOperazione;
      //Log.Fine

      // elimina il documento da db
      LResCtrl:=C021DM.Delete(LIdDoc);
      if not LResCtrl.Ok then
        raise Exception.Create(LResCtrl.Messaggio);

      SessioneOracle.Commit;

      // l'allegato è stato effettivamente cancellato se
      //   a. il suo id non compare nell'elenco di quelli inseriti
      //   b. il suo id non compare nel dataset iniziale
      if InfoAllegati.IdInAllegatiInseriti(LIdDoc) then
      begin
        // se l'id è nell'elenco di quelli inseriti lo elimina
        InfoAllegati.RimuoviDaAllegatiInseriti(LIdDoc);
        GestioneConfermaAllegatiInseriti;
      end
      else
      begin
        // altrimenti se l'id compare nel dataset iniziale imposta il flag di eliminazione
        InfoAllegati.AllegatiCancellati:=not VarIsNull(C018.selT853_T960.Lookup('ID_T960',LIdDoc,'ID_T960'));
      end;
    except
      on E: Exception do
      begin
        //Eseguo rollback solo se la sessione db è usata solo da me
        if SessioneOracle.Tag = 1 then
          SessioneOracle.Rollback
        else
          SessioneOracle.Commit;
        raise;
      end;
    end;
  finally
    //aggiorna visualizzazione
    PopolaDati;

  end;
end;
{ DONE : TEST IW 15 }
procedure TWC026FAllegatiIterFM.grdAllegatiConferma(Sender: TObject);
// operazioni in fase di conferma dell'allegato (inserimento / modifica)
var
  i: Integer;
  LDimMB: Double;
  FN: String;
  LIWFile: TmeIWFileUploader;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
const
  BYTES_KB = 1024;
  BYTES_MB = 1024 * BYTES_KB;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdAllegati.medpRigaDiCompGriglia(FN);
  LDoc:=nil;

  try
    if grdAllegati.medpStato = msInsert then
    begin
      // inserimento nuovo allegato

      // gestione oggetto IWFile
      LIWFile:=(grdAllegati.medpCompCella(i,iIWFile,0) as TmeIWFileUploader);

      if not LIWFile.IsPresenteFileUploadato then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_WC026_ERR_SELEZIONARE_DOC));

      // crea oggetto documento
      LDoc:=TDocumento.Create;
      LDoc.SetNomeFileCompleto(LIWFile.NomeFile);
      LDoc.Progressivo:=C018.selTabellaIter.FieldByName('PROGRESSIVO').AsInteger;
      LDoc.Tipologia:=DOC_TIPOL_ITER;
      LDoc.Ufficio:=DOC_UFFICIO_PREDEF;
      LDoc.PeriodoDal:=C018.selTabellaIter.FieldByName(C018.Periodo.ColonnaDal.Replace('T_ITER.','',[rfIgnoreCase])).AsDateTime;
      LDoc.PeriodoAl:=C018.selTabellaIter.FieldByName(C018.Periodo.ColonnaAl.Replace('T_ITER.','',[rfIgnoreCase])).AsDateTime;
      LDoc.PathStorage:=Parametri.CampiRiferimento.C90_PathAllegati;
      LDoc.Provenienza:=DOC_PROVENIENZA_INTERNA;

      // se esiste già un file temporaneo con lo stesso nome lo cancella
      if TFile.Exists(LDoc.TempFile) then
        TFile.Delete(LDoc.TempFile);

      // effettua upload
      try
        LIWFile.SalvaSuFile(LDoc.TempFile);
        LIWFile.Ripristina;
      except
        on E: Exception do
        begin
          LIWFile.Ripristina;
          raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_WC026_ERR_FMT_DOC_UPLOAD),[E.Message]));
        end;
      end;

      // imposta proprietà documento
      LDoc.Dimensione:=R180GetFileSize(LDoc.TempFile);

      // controllo dimensione file
      LDimMB:=LDoc.Dimensione / BYTES_MB;
      if LDimMB > IterMaxDimAllegatoMB then
      begin
        // cancella file temporaneo
        try
          TFile.Delete(LDoc.TempFile);
        except
        end;
        // solleva eccezione
        raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_DIM_ALLEGATO),[IterMaxDimAllegatoMB,LDimMB]));
      end;

      if LDoc.PathStorage = 'DB' then
      begin
        LDoc.Blob:=TLOBLocator.CreateTemporary(SessioneOracle,otBLOB,True);
        LDoc.Blob.Tag:=Integer(btFree); // indica che il blob è da distruggere dal distruttore di TDocumento
        LDoc.Blob.LoadFromFile(LDoc.TempFile);
      end;
    end
    else
    begin
      // modifica dell'allegato (solo metadati)

      // estrae i metadati associati al documento
      LResCtrl:=C021DM.GetById(grdAllegati.medpValoreColonna(i,'ID_T960').ToInteger,False,LDoc);
      if not LResCtrl.Ok then
        raise Exception.Create(LResCtrl.Messaggio);
    end;

    // effettua operazioni standard di conferma
    grdAllegati.medpConferma(i);

    LDoc.Note:=cdsAllegati.FieldByName('NOTE').AsString;

    LDoc.CFFamiliare:='';
    if C018.Iter = ITER_GIUSTIF then
      if not C018.selTabellaIter.FieldByName('DATANAS').IsNull then
        LDoc.CFFamiliare:=C018.GetCFFamiliare(LDoc.Progressivo, C018.selTabellaIter.FieldByName('DATANAS').AsDateTime);

    // operazioni su database
    try
      // salvataggio del documento
      LResCtrl:=C021DM.Save(LDoc);
      if not LResCtrl.Ok then
        raise Exception.Create(LResCtrl.Messaggio);

      // in caso di inserimento, inserisce il riferimento all'allegato su T853
      if grdAllegati.medpStato = msInsert then
      begin
        C018.insT853.SetVariable('ID',C018.Id);
        C018.insT853.SetVariable('ID_T960',LDoc.Id);
        C018.insT853.Execute;

        //Log.ini
        RegistraLog.SettaProprieta('I', 'T960_DOCUMENTI_INFO',C021DM.Maschera, C018.selTabellaIter, True);
        RegistraLog.InserisciDato('ID_ALLEGATO', '', IntToStr(LDoc.Id));
        RegistraLog.InserisciDato('NOME_FILE', '', LDoc.NomeFile);
        RegistraLog.InserisciDato('EXT_FILE', '', LDoc.ExtFile);
        if LDoc.Note <> '' then
          RegistraLog.InserisciDato('NOTE', '', LDoc.Note);
        RegistraLog.RegistraOperazione;
        //Log.fine
      end;

      // commit operazione
      SessioneOracle.Commit;

      // segnala la modifica
      if grdAllegati.medpStato = msInsert then
      begin
        // l'allegato è stato inserito
        InfoAllegati.AggiungiAdAllegatiInseriti(LDoc.Id);

        // in caso di inserimento nuovi allegati si richiede la conferma di conformità all'originale
        GestioneConfermaAllegatiInseriti;
      end
      else
      begin
        // in alternativa l'allegato si considera modificato
        InfoAllegati.AllegatiModificati:=True;
      end;
    except
      on E: Exception do
      begin
        //Eseguo rollback solo se la sessione db è usata solo da me
        if SessioneOracle.Tag = 1 then
          SessioneOracle.Rollback
        else
          SessioneOracle.Commit;
        raise;
      end;
    end;
  finally
    // distrugge oggetto di supporto
    if Assigned(LDoc) then
      try FreeAndNil(LDoc); except end;

    // aggiorna visualizzazione
    PopolaDati;
  end;
end;

procedure TWC026FAllegatiIterFM.grdAllegatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
begin
  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdAllegati.medpNumColonna(AColumn);
  Campo:=grdAllegati.medpColonna(NumColonna).DataField;

  // assegnazione stili
  if (ARow > 0) and (Length(grdAllegati.medpCompGriglia) > 0) then
  begin
    if Campo = 'C_DIMENSIONE' then
    begin
      ACell.Css:=ACell.Css + ' align_right';
    end;
  end;

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdAllegati.medpCompGriglia) + 1) and (grdAllegati.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdAllegati.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
    if Campo = 'NOTE' then
    begin
      if ACell.Control is TmeIWEdit then
        TmeIWEdit(ACell.Control).Css:=TmeIWEdit(ACell.Control).Css + ' width98pc';
    end;
  end;
end;

procedure TWC026FAllegatiIterFM.GestioneConfermaAllegatiInseriti;
begin
  chkConfermaAllegatiOriginali.Visible:=InfoAllegati.AllegatiInseriti;
  C190VisualizzaElemento(JQuery,'wc026confermaOrigDiv',chkConfermaAllegatiOriginali.Visible);
  chkConfermaAllegatiOriginali.Checked:=False;
  btnChiudi.Enabled:=(not chkConfermaAllegatiOriginali.Visible) or (chkConfermaAllegatiOriginali.Checked);
end;

{ TInfoAllegati }
procedure TInfoAllegati.Clear;
begin
  AllegatiModificati:=False;
  AllegatiCancellati:=False;
  HintImmagine:='';
  GestAllegati:='N';
  NumAllegati:=0;
end;

function TInfoAllegati.EsistonoModifiche: Boolean;
begin
  Result:=AllegatiInseriti or AllegatiModificati or AllegatiCancellati;
end;

function TInfoAllegati.AllegatiInseriti: Boolean;
begin
  Result:=(ElencoAllegatiInseriti <> '');
end;

function TInfoAllegati.IdInAllegatiInseriti(const PId: Integer): Boolean;
begin
  Result:=R180InConcat(PId.ToString,ElencoAllegatiInseriti);
end;

procedure TInfoAllegati.AggiungiAdAllegatiInseriti(const PId: Integer);
begin
  if not IdInAllegatiInseriti(PId) then
    ElencoAllegatiInseriti:=ElencoAllegatiInseriti + IfThen(ElencoAllegatiInseriti <> '',',') + PId.ToString;
end;

procedure TInfoAllegati.RimuoviDaAllegatiInseriti(const PId: Integer);
var
  LList: TStringList;
  LIdx: Integer;
begin
  LList:=TStringList.Create;
  try
    LList.CommaText:=ElencoAllegatiInseriti;
    LIdx:=LList.IndexOf(PId.ToString);
    if LIdx > -1 then
    begin
      LList.Delete(LIdx);
      ElencoAllegatiInseriti:=LList.CommaText;
    end;
  finally
    FreeAndNil(LList);
  end;
end;

end.
