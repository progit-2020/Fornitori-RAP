unit WC026UAllegatiIterFM;

{ DONE : TEST IW 15 }
{ Nuovo file uploader }

interface

uses
  A000UInterfaccia, A000UMessaggi, W000UMessaggi,
  WR200UBaseFM, WC027UDocumentiManagerDM, R010UPaginaWeb,
  C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  Oracle, OracleData, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.IOUtils, System.Variants, System.Classes, Vcl.Graphics, meIWLink,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IWCompGrids, IWDBGrids, medpIWDBGrid,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  meIWButton, Data.DB, Datasnap.DBClient, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWImageFile, Math, meIWFileUploader, meIWEdit,
  IWCompLabel, meIWLabel;

type
  TAbilitazioni = record
    Inserimento: Boolean;
    Modifica: Boolean;
    Cancellazione: Boolean;
    Info: String;
  end;

  TInfoAllegati = record
    EsistonoModifiche: Boolean;
    HintImmagine: String;
    GestAllegati: String;
    NumAllegati: Integer;
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
    procedure btnChiudiClick(Sender: TObject);
    procedure grdAllegatiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdAllegatiRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
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
  private
    iIWFile: Integer;
    IterMaxAllegati: Integer;
    IterMaxDimAllegatoMB: Integer;
    procedure PopolaDati;
    procedure lnkDownloadAllegatoClick(Sender: TObject);
  public
    C018: TC018FIterAutDM;
    WC027DM: TWC027FDocumentiManagerDM;
    InfoAllegati: TInfoAllegati;
    Abilitazioni: TAbilitazioni;
    procedure Visualizza;
    procedure ReleaseOggetti; override;
  end;

implementation

uses
  IWApplication, IWGlobal, IWAppForm;

{$R *.dfm}

procedure TWC026FAllegatiIterFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;

  // controllo abilitazione modulo
  if not (WR000DM.ModuliAccessori.IsAbilitato(Parametri.Azienda,'PUBBL_DOCUMENTI_ESTERNI')) then
    raise Exception.Create('Funzione non disponibile: modulo Pubblicazione documenti esterni non abilitato!');

  // crea datamodulo di servizio per allegati
  WC027DM:=TWC027FDocumentiManagerDM.Create(Self);

  InfoAllegati.EsistonoModifiche:=False;
  InfoAllegati.HintImmagine:='';
  InfoAllegati.GestAllegati:='N';
  InfoAllegati.NumAllegati:=0;

  // variabili integer relative ai parametri aziendali
  IterMaxAllegati:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxAllegati,999);
  if IterMaxAllegati < 0 then
    IterMaxAllegati:=999;
  IterMaxDimAllegatoMB:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB,5);
end;

procedure TWC026FAllegatiIterFM.ReleaseOggetti;
begin
  // distrugge datamodulo di servizio per allegati
  C018.selT853_T960.Close;
  FreeAndNil(WC027DM);
end;

procedure TWC026FAllegatiIterFM.Visualizza;
var
  Titolo: String;
begin
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
  (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(JQuery,700,-1,EM2PIXEL * 24,Titolo,'#' + Name,True,True,-1,'','',btnChiudi.HTMLName);
end;

procedure TWC026FAllegatiIterFM.PopolaDati;
begin
  // effettua lettura allegati da db
  InfoAllegati.HintImmagine:=C018.LeggiAllegati;
  InfoAllegati.GestAllegati:=C018.GetCondizioneAllegati;
  InfoAllegati.NumAllegati:=C018.selT853_T960.RecordCount;

  // copia i dati sul clientdataset per la gestione inline nella grid
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
  Id: Integer;
  Doc: TDocumento;
  NomeFile, FileTemp: String;
begin
  // estrae id richiesta dal tag del componente
  Id:=(Sender as TmeIWLink).Tag;

  // se l'id è indicato, estrae informazioni del documento
  if Id > 0 then
  begin
    // estrae info documento da db
    Doc:=WC027DM.GetById(Id);
    try
      if Doc <> nil then
      begin
        try
          // se il file non esiste dà segnalazione
          if (Doc.Blob = nil) or (Doc.Blob.IsNull) then
          begin
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_WC026_ERR_DOC_INESISTENTE));
            Exit;
          end;

          // estrae nome file
          NomeFile:=Doc.GetNomeFileCompleto;

          // file temporaneo in cui salvare il blob
          { DONE : TEST IW 15 }
          //FileTemp:=gSC.UserCacheDir + NomeFile;
          FileTemp:=GGetWebApplicationThreadVar.UserCacheDir + NomeFile;

          if TFile.Exists(FileTemp) then
            TFile.Delete(FileTemp);

          // salva il blob in un file temporaneo
          Doc.Blob.SaveToFile(FileTemp);

          // invia il file al browser
          GGetWebApplicationThreadVar.SendFile(FileTemp,True,'application/x-download',NomeFile);
        except
          on E: Exception do
          begin
            GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_WC026_ERR_FMT_DOC_DOWNLOAD,[E.Message]));
            Exit;
          end;
        end;
      end;
    finally
      FreeAndNil(Doc);
    end;
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
  i, IdDoc: Integer;
  FN, Errore: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdAllegati.medpRigaDiCompGriglia(FN);

  try
    // estrae id documento da cancellare
    IdDoc:=grdAllegati.medpValoreColonna(i,'ID_T960').ToInteger;
    try
      // elimina il riferimento all'allegato dalla tabella T853
      C018.delT853.SetVariable('ID',C018.Id);
      C018.delT853.SetVariable('ID_T960',IdDoc);
      C018.delT853.Execute;

      // elimina il documento da db
      if not WC027DM.Delete(IdDoc,Errore) then
        raise Exception.Create(Errore);

      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        raise;
      end;
    end;
  finally
    // imposta il flag di modifica allegati e aggiorna visualizzazione
    InfoAllegati.EsistonoModifiche:=True;
    PopolaDati;
  end;
end;

{ DONE : TEST IW 15 }
{ Adeguare per il nuovo file uploader }
procedure TWC026FAllegatiIterFM.grdAllegatiConferma(Sender: TObject);
// operazioni in fase di conferma dell'allegato (inserimento / modifica)
var
  i: Integer;
  DimMB: Double;
  FN, ErrMsg: String;
  IWFile: TmeIWFileUploader;
  Doc: TDocumento;
const
  BYTES_KB = 1024;
  BYTES_MB = 1024 * BYTES_KB;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdAllegati.medpRigaDiCompGriglia(FN);

  try
    if grdAllegati.medpStato = msInsert then
    begin
      // inserimento nuovo allegato

      // gestione oggetto IWFile
      IWFile:=(grdAllegati.medpCompCella(i,iIWFile,0) as TmeIWFileUploader);
      if not IWFile.IsPresenteFileUploadato then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_WC026_ERR_SELEZIONARE_DOC));

      // crea oggetto documento
      Doc:=TDocumento.Create;
      Doc.SetNomeFileCompleto(IWFile.NomeFile);
      Doc.Progressivo:=C018.selTabellaIter.FieldByName('PROGRESSIVO').AsInteger;
      Doc.Tipologia:=DOC_TIPOLOGIA_ITER;
      Doc.PeriodoDal:=C018.selTabellaIter.FieldByName(C018.Periodo.ColonnaDal.Replace('T_ITER.','',[rfIgnoreCase])).AsDateTime;
      Doc.PeriodoAl:=C018.selTabellaIter.FieldByName(C018.Periodo.ColonnaAl.Replace('T_ITER.','',[rfIgnoreCase])).AsDateTime;

      // se esiste già un file temporaneo con lo stesso nome lo cancella
      if TFile.Exists(Doc.TempFile) then
        TFile.Delete(Doc.TempFile);

      // effettua upload
      try
        IWFile.SalvaSuFile(Doc.TempFile);
        IWFile.Ripristina;
      except
        on E: Exception do
        begin
          IWFile.Ripristina;
          raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_WC026_ERR_FMT_DOC_UPLOAD),[E.Message]));
        end;
      end;

      // imposta proprietà documento
      Doc.Dimensione:=R180GetFileSize(Doc.TempFile);

      // controllo dimensione file
      DimMB:=Doc.Dimensione / BYTES_MB;
      if DimMB > IterMaxDimAllegatoMB then
      begin
        // cancella file temporaneo
        try
          TFile.Delete(Doc.TempFile);
        except
        end;
        // solleva eccezione
        raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_WC026_ERR_FMT_DIM_ALLEGATO),[IterMaxDimAllegatoMB,DimMB]));
      end;

      Doc.Blob:=TLOBLocator.CreateTemporary(SessioneOracle,otBLOB,True);
      Doc.Blob.Tag:=1; // indica che il blob è da distruggere, in quanto creato manualmente
      Doc.Blob.LoadFromFile(Doc.TempFile);
    end
    else
    begin
      // modifica dell'allegato (solo metadati)

      // estrae dati documento da db
      Doc:=WC027DM.GetById(grdAllegati.medpValoreColonna(i,'ID_T960').ToInteger,False);
    end;

    // effettua operazioni standard di conferma
    grdAllegati.medpConferma(i);

    Doc.Note:=cdsAllegati.FieldByName('NOTE').AsString;

    // operazioni su database
    try
      // salvataggio del documento
      if not WC027DM.Save(Doc,ErrMsg) then
        raise Exception.Create(ErrMsg);

      // in caso di inserimento, inserisce il riferimento all'allegato su T853
      if grdAllegati.medpStato = msInsert then
      begin
        C018.insT853.SetVariable('ID',C018.Id);
        C018.insT853.SetVariable('ID_T960',Doc.Id);
        C018.insT853.Execute;
      end;

      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        raise;
      end;
    end;
  finally
    // distrugge oggetto di supporto
    if Assigned(Doc) then
      try FreeAndNil(Doc); except end;

    // imposta il flag di modifica allegati e aggiorna visualizzazione
    InfoAllegati.EsistonoModifiche:=True;
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


end.
