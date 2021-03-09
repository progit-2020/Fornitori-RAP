unit C023UInfoDati;

interface

uses
  A000UCostanti,
  A000USessione,
  A093UOperazioniMW,
  A087UImpAttestatiMalMW,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Data.DB, Vcl.Menus, Vcl.ComCtrls, C018UIterAutDM,
  Vcl.DBGrids, FunzioniGenerali,
  A023UTimbratureDtm1, IOUtils, shellAPI,
  Datasnap.DBClient, C180FunzioniGenerali, System.DateUtils,
  System.StrUtils;

type
  TC023FInfoDati = class(TForm)
    pMnuDocumenti: TPopupMenu;
    Apri1: TMenuItem;
    Salva1: TMenuItem;
    dlgFileSave: TSaveDialog;
    dsrDocumentiInfo: TDataSource;
    tabMain: TPageControl;
    tabInfoRichiesta: TTabSheet;
    tabInfoCertificatoINPS: TTabSheet;
    tabLog: TTabSheet;
    grpInfoRichiedente: TGroupBox;
    lblIDRichiesta: TLabel;
    lblDataRichiesta: TLabel;
    lblCodiceIter: TLabel;
    lblRichiedente: TLabel;
    lblNoteRichiedente: TLabel;
    lblIDRichiestaValue: TLabel;
    lblDataRichiestaValue: TLabel;
    lblCodiceIterValue: TLabel;
    lblRichiedenteValue: TLabel;
    lblNoteRichiedenteValue: TLabel;
    grpInfoAutorizzatore: TGroupBox;
    lblDataAutorizzazione: TLabel;
    lblAutorizzatore: TLabel;
    lblNoteAutorizzatore: TLabel;
    lblDataAutorizzazioneValue: TLabel;
    lblAutorizzatoreValue: TLabel;
    lblNoteAutorizzatoreValue: TLabel;
    grpInfoRevoca: TGroupBox;
    lblIDRevoca: TLabel;
    lblDataRevoca: TLabel;
    lblNoteRevoca: TLabel;
    lblIDRevocaValue: TLabel;
    lblDataRevocaValue: TLabel;
    lblNoteRevocaValue: TLabel;
    dgrdDocumenti: TDBGrid;
    dgrdLogOperazioni: TDBGrid;
    dsrI000: TDataSource;
    lblInfoCertINPS: TLabel;
    lblInfoLog: TLabel;
    dsrT048: TDataSource;
    grdCertINPS: TStringGrid;
    Carica1: TMenuItem;
    Elimina1: TMenuItem;
    OpenDlg: TOpenDialog;
    N1: TMenuItem;
    procedure Salva1Click(Sender: TObject);
    procedure Apri1Click(Sender: TObject);
    procedure tabMainChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Carica1Click(Sender: TObject);
    procedure pMnuDocumentiPopup(Sender: TObject);
    procedure Elimina1Click(Sender: TObject);
  private
    FLogCaricato: Boolean;
    FA087MW: TA087FImpAttestatiMalMW;
    FA093MW: TA093FOperazioniMW;
    FEsisteIndiceI000: Boolean;
    FDatiGiust: TGiustificativi;
    FDatiTimb: TTimbrature;
    FC018IterInfo: TC018IterInfo;
    FDataSetIter: TDataSet;
    procedure CaricaInfoCertificatoINPS(PIdCertificato: String);
    procedure CaricaInfoRichiesta(IDRichiesta: Integer);
    procedure CaricaInfoLog;
  public
    C018: TC018FIterAutDM;
    procedure MostraInfoGiust(PDatiGiust: TGiustificativi);
    procedure MostraInfoTimb(PDatiTimb: TTimbrature);
    procedure MostraInfoRichiesta(PIdRichiesta: Integer);  overload;
    procedure MostraInfoRichiesta(PDataSetIter: TDataSet); overload;
  end;

implementation

uses
  A000UInterfaccia, A000UMessaggi, Oracle, C021UDocumentiManagerDM;

{$R *.dfm}

procedure TC023FInfoDati.FormCreate(Sender: TObject);
begin
  FLogCaricato:=False;
  FA093MW:=TA093FOperazioniMW.Create(nil);
  FEsisteIndiceI000:=FA093MW.EsisteIndiceI000;
  FDatiGiust.Clear;
  FDatiTimb.Clear;
  FDataSetIter:=nil;
end;

procedure TC023FInfoDati.FormDestroy(Sender: TObject);
begin
  try FreeAndNil(FA093MW); except end;
  try FreeAndNil(FA087MW); except end;
  if FC018IterInfo <> nil then
    try FreeAndNil(FC018IterInfo); except end;
end;

procedure TC023FInfoDati.MostraInfoGiust(PDatiGiust: TGiustificativi);
begin
  FDatiGiust:=PDatiGiust;

  Screen.Cursor:=crHourGlass;
  try
    // imposta visibilità dei tab
    tabInfoRichiesta.TabVisible:=PDatiGiust.IdRichiesta > 0;
    tabInfoCertificatoINPS.TabVisible:=PDatiGiust.IdCertificato <> '';
    tabLog.TabVisible:=True;

    if PDatiGiust.IdRichiesta > 0 then
    begin
      CaricaInfoRichiesta(PDatiGiust.IdRichiesta);
      tabMain.ActivePage:=tabInfoRichiesta;
    end
    else if PDatiGiust.IdCertificato <> '' then
    begin
      CaricaInfoCertificatoINPS(PDatiGiust.IdCertificato);
      tabMain.ActivePage:=tabInfoCertificatoINPS;
      Height:=420;
    end
    else
    begin
      CaricaInfoLog;
      tabMain.ActivePage:=tabLog;
      Height:=370;
    end;
  finally
    Screen.Cursor:=crDefault;
    ShowModal;
  end;
end;

procedure TC023FInfoDati.MostraInfoTimb(PDatiTimb: TTimbrature);
begin
  FDatiTimb:=PDatiTimb;

  Screen.Cursor:=crHourGlass;
  try
    // imposta visibilità dei tab
    tabInfoRichiesta.TabVisible:=PDatiTimb.IdRichiesta > 0;
    tabInfoCertificatoINPS.TabVisible:=False;
    tabLog.TabVisible:=True;

    if PDatiTimb.IdRichiesta > 0 then
    begin
      CaricaInfoRichiesta(PDatiTimb.IdRichiesta);
      tabMain.ActivePage:=tabInfoRichiesta;
    end
    else
    begin
      CaricaInfoLog;
      tabMain.ActivePage:=tabLog;
      Height:=370;
    end;
  finally
    Screen.Cursor:=crDefault;
    ShowModal;
  end;
end;

procedure TC023FInfoDati.pMnuDocumentiPopup(Sender: TObject);
var IterMaxAllegati: integer;
begin
  Apri1.Visible:=dgrdDocumenti.DataSource.DataSet.RecordCount>0;
  Salva1.Visible:=Apri1.Visible;

  Carica1.Visible:=(FDataSetIter <> nil) and (FDataSetIter.Active) and (not SolaLettura);
  Elimina1.Visible:=(Carica1.Visible) and (Apri1.Visible);
  N1.Visible:=(Carica1.Visible) and (Apri1.Visible);

  if Elimina1.Visible then
    Elimina1.Enabled:=dgrdDocumenti.DataSource.DataSet.FieldByName('ALLEGATO_BACKOFFICE').AsString = 'S';

  if Carica1.Visible then
  begin
    IterMaxAllegati:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxAllegati,999);
    if IterMaxAllegati < 0 then
      IterMaxAllegati:=999;
    Carica1.Enabled:=dgrdDocumenti.DataSource.DataSet.RecordCount < IterMaxAllegati;
  end;
end;

procedure TC023FInfoDati.MostraInfoRichiesta(PIdRichiesta: Integer);
begin
  if PIdRichiesta = 0 then
  begin
    R180MessageBox('L''identificativo della richiesta non è valido',ESCLAMA);
    Exit;
  end;

  Screen.Cursor:=crHourGlass;
  try
    // imposta visibilità dei tab
    tabInfoRichiesta.TabVisible:=True;
    tabInfoCertificatoINPS.TabVisible:=False;
    tabLog.TabVisible:=False;

    CaricaInfoRichiesta(PIdRichiesta);
    tabMain.ActivePage:=tabInfoRichiesta;
  finally
    Screen.Cursor:=crDefault;
    ShowModal;
  end;
end;

procedure TC023FInfoDati.MostraInfoRichiesta(PDataSetIter: TDataSet);
begin
  if (not PDataSetIter.Active) or (PDataSetIter.RecordCount = 0) or (PDataSetIter.FieldByName('T850ID').AsInteger = 0) then
  begin
    R180MessageBox('L''identificativo della richiesta non è valido',ESCLAMA);
    Exit;
  end;
  FDataSetIter:=PDataSetIter;
  MostraInfoRichiesta(PDataSetIter.FieldByName('T850ID').AsInteger);
end;

procedure TC023FInfoDati.Carica1Click(Sender: TObject);
var
  IterMaxAllegati, IterMaxDimAllegatoMB: integer;
  Myfile:string;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
  LDimMB: Double;
  C021DM: TC021FDocumentiManagerDM;
begin
  IterMaxAllegati:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxAllegati,999);
  if IterMaxAllegati < 0 then
    IterMaxAllegati:=999;

  //Controllo che non si superi il nr max di allegati (dovrebbe essere impedito già a monte non abilitanto la funzione)
  if dgrdDocumenti.DataSource.DataSet.RecordCount >= IterMaxAllegati then
    raise Exception.Create('Numero massimo di allegati raggiunto. Impossibile proseguire.');

  IterMaxDimAllegatoMB:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB,5);

  OpenDlg.Filter:='Tutti|*.*';
  if OpenDlg.Execute then
    Myfile:=OpenDlg.FileName;
  if not FileExists(Myfile) then
    exit;

  C018.Iter:=FC018IterInfo.Iter;
  C021DM:=TC021FDocumentiManagerDM.Create(Self);
  C021DM.Maschera:='A176';
  C021DM.CancellaFileTemp:=False;
  try
    // crea oggetto documento
    LDoc:=TDocumento.Create;
    LDoc.SetNomeFileCompleto(TPath.GetFileNameWithoutExtension(Myfile));
    LDoc.ExtFile:=TPath.GetExtension(Myfile);
    LDoc.Progressivo:=FDataSetIter.FieldByName('PROGRESSIVO').AsInteger;
    LDoc.Tipologia:=DOC_TIPOL_ITER;
    LDoc.Ufficio:=DOC_UFFICIO_PREDEF;
    LDoc.PeriodoDal:=FDataSetIter.FieldByName(C018.Periodo.ColonnaDal.Replace('T_ITER.',C018.Iter,[rfIgnoreCase])).AsDateTime;
    LDoc.PeriodoAl:=FDataSetIter.FieldByName(C018.Periodo.ColonnaAl.Replace('T_ITER.',C018.Iter,[rfIgnoreCase])).AsDateTime;
    LDoc.PathStorage:=Parametri.CampiRiferimento.C90_PathAllegati;
    LDoc.Provenienza:=DOC_PROVENIENZA_INTERNA;

    // imposta proprietà documento
    LDoc.Dimensione:=R180GetFileSize(Myfile);
    // controllo dimensione file
    LDimMB:=LDoc.Dimensione / BYTES_MB;
    if LDimMB > IterMaxDimAllegatoMB then
    begin
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_DIM_ALLEGATO),[IterMaxDimAllegatoMB,LDimMB]));
    end;

    if LDoc.PathStorage = 'DB' then
    begin
      LDoc.Blob:=TLOBLocator.CreateTemporary(SessioneOracle,otBLOB,True);
      LDoc.Blob.Tag:=Integer(btFree); // indica che il blob è da distruggere dal distruttore di TDocumento
      LDoc.Blob.LoadFromFile(Myfile);
    end;

    LDoc.Note:='Caricato da back office'; //cdsAllegati.FieldByName('NOTE').AsString;

    LDoc.CFFamiliare:='';
    if FC018IterInfo.Iter = ITER_GIUSTIF then
      if not FDataSetIter.FieldByName('T050DATANAS').IsNull then
        LDoc.CFFamiliare:=C018.GetCFFamiliare(LDoc.Progressivo, FDataSetIter.FieldByName('T050DATANAS').AsDateTime);

    // operazioni su database
    try
      // salvataggio del documento
      LDoc.TempFile:=Myfile;
      LResCtrl:=C021DM.Save(LDoc);
      if not LResCtrl.Ok then
        raise Exception.Create(LResCtrl.Messaggio);

      // inserisce il riferimento all'allegato su T853
      C018.insT853.SetVariable('ID', FC018IterInfo.IDRichiesta);      //4899
      C018.insT853.SetVariable('ID_T960', LDoc.Id); //2491
      C018.insT853.Execute;

      SessioneOracle.Commit;

    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        raise;
      end;
    end;
  finally
    if Assigned(LDoc) then
      try FreeAndNil(LDoc); except end;

    if Assigned(C021DM) then
      try FreeAndNil(C021DM); except end;

    FC018IterInfo.Allegati.Refresh;
  end;
end;

procedure TC023FInfoDati.CaricaInfoCertificatoINPS(PIdCertificato: String);
var
  LField: TField;
  i: Integer;
  r: Integer;
begin
  if FA087MW = nil then
    FA087MW:=TA087FImpAttestatiMalMW.Create(nil);

  FA087MW.selT048Info.Close;
  FA087MW.selT048Info.SetVariable('ID_CERTIFICATO',PIdCertificato);
  FA087MW.selT048Info.Open;
  dsrT048.DataSet:=FA087MW.selT048Info;
  if FA087MW.selT048Info.RecordCount = 0 then
    lblInfoCertINPS.Caption:=Format('Certificato %s non presente in archivio',[PIdCertificato]);

  grdCertINPS.Visible:=FA087MW.selT048Info.RecordCount > 0;
  if grdCertINPS.Visible then
  begin
    grdCertINPS.ColWidths[0]:=130;
    grdCertINPS.ColWidths[1]:=300;
    r:=0;
    for i:=0 to FA087MW.selT048Info.Fields.Count - 1 do
    begin
      LField:=FA087MW.selT048Info.Fields[i];
      if LField.Visible then
      begin
        grdCertINPS.RowCount:=r + 1;
        grdCertINPS.RowHeights[r]:=20;
        grdCertINPS.Cells[0,r]:=LField.DisplayLabel;
        grdCertINPS.Cells[1,r]:=LField.AsString;
        inc(r);
      end;
    end;
  end;

  lblInfoCertINPS.Visible:=FA087MW.selT048Info.RecordCount = 0;
end;

procedure TC023FInfoDati.CaricaInfoRichiesta(IDRichiesta:integer);
begin
  if FC018IterInfo = nil then
    FC018IterInfo:=TC018IterInfo.Create;
  FC018IterInfo.IDRichiesta:=IDRichiesta;
  //Informazioni richiedente
  lblIDRichiestaValue.Caption:=FC018IterInfo.IDRichiesta.ToString;
  lblDataRichiestaValue.Caption:=FC018IterInfo.DataRichiesta.toString('dd/mm/yyyy hh.mm');
  lblCodiceIterValue.Caption:=FC018IterInfo.CodIter;
  lblRichiedenteValue.Caption:=FC018IterInfo.Richiedente;
  lblNoteRichiedenteValue.Caption:=FC018IterInfo.NoteRichiesta;
  //Informazioni autorizzatore
  lblDataAutorizzazioneValue.Caption:=IfThen(FC018IterInfo.DataAutorizzazione = DATE_NULL,'',FC018IterInfo.DataAutorizzazione.toString('dd/mm/yyyy hh.mm'));
  lblAutorizzatoreValue.Caption:=FC018IterInfo.Autorizzatore;
  lblNoteAutorizzatoreValue.Caption:=FC018IterInfo.NoteAutorizzatore;
  //Informazioni revoca
  grpInfoRevoca.Visible:=FC018IterInfo.IDRevoca > 0;
  //Se grpInfoRevoca non è visibile, scalo alla form la sua altezza
  if not grpInfoRevoca.Visible then
  begin
    Height:=Height - grpInfoRevoca.Height;
  end;
  lblIDRevocaValue.Caption:=FC018IterInfo.IDRevoca.ToString;
  lblDataRevocaValue.Caption:=FC018IterInfo.DataRevoca.ToString('dd/mm/yyyy hh.mm');
  lblNoteRevocaValue.Caption:=FC018IterInfo.NoteRevoca;
  //Eventuali allegati relativi all'iter richiesta
  dsrDocumentiInfo.DataSet:=FC018IterInfo.Allegati;
  dgrdDocumenti.DataSource:=dsrDocumentiInfo;
  dgrdDocumenti.Visible:=FC018IterInfo.EsisteGestioneAlleagati;
  //Se dgrdDocumenti non è visibile, scalo alla form la sua altezza
  if not dgrdDocumenti.Visible then
  begin
    Height:=Height - dgrdDocumenti.Height;
  end;
end;



procedure TC023FInfoDati.Elimina1Click(Sender: TObject);
// operazioni in fase di cancellazione dell'allegato
var
  LIdDoc: Integer;
  LResCtrl: TResCtrl;
  C021DM: TC021FDocumentiManagerDM;
begin
  if R180MessageBox('Eliminare l''allegato selezionato?','DOMANDA') <> mrYes then
    Exit;

  //Controlla che l'allegato provenga da backoffice
  if dgrdDocumenti.DataSource.DataSet.FieldByName('ALLEGATO_BACKOFFICE').AsString <> 'S' then
    raise Exception.Create('Impossibile eliminare un allegato non caricato da back office');

  try
    // estrae id documento da cancellare
    LIdDoc:=dgrdDocumenti.DataSource.DataSet.FieldByName('ID_ALLEGATO').AsInteger;

    C021DM:=TC021FDocumentiManagerDM.Create(Self);
    C021DM.Maschera:='A176';
    C021DM.CancellaFileTemp:=False;

    try
      // elimina il riferimento all'allegato dalla tabella T853
      C018.delT853.SetVariable('ID',FC018IterInfo.IDRichiesta);
      C018.delT853.SetVariable('ID_T960',LIdDoc);
      C018.delT853.Execute;

      // elimina il documento da db
      LResCtrl:=C021DM.Delete(LIdDoc);
      if not LResCtrl.Ok then
        raise Exception.Create(LResCtrl.Messaggio);

      SessioneOracle.Commit;

      (*
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
      *)
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
    if Assigned(C021DM) then
      try FreeAndNil(C021DM); except end;

    // aggiorna visualizzazione
    FC018IterInfo.Allegati.Refresh;
  end;
end;

procedure TC023FInfoDati.CaricaInfoLog;
var
  LOra: String;
begin
  // se manca l'indice su I000 (TABELLA + PROGRESSIVO) non tenta nemmeno il caricamento dei log
  if not FEsisteIndiceI000 then
  begin
    dgrdLogOperazioni.Visible:=False;
    lblInfoLog.Caption:='Le informazioni di log non possono essere cercate: manca un indice sulla tabella!';
    lblInfoLog.Visible:=True;
    Exit;
  end;

  // se i dati dei log sono già stati caricati termina subito
  if FLogCaricato then
    Exit;

  if FDatiGiust.Progressivo <> 0 then
  begin
    // cerca log giustificativo
    FA093MW.selI000_T040.Close;
    FA093MW.selI000_T040.SetVariable('PROGRESSIVO',FDatiGiust.Progressivo);
    FA093MW.selI000_T040.SetVariable('DATA',FDatiGiust.Data);
    FA093MW.selI000_T040.SetVariable('CAUSALE',FDatiGiust.Causale);
    FA093MW.selI000_T040.SetVariable('TIPOGIUST',FDatiGiust.Tipo);
    FA093MW.selI000_T040.SetVariable('DAORE',DateTimeToStr(FDatiGiust.DaOre));
    FA093MW.selI000_T040.SetVariable('AORE',DateTimeToStr(FDatiGiust.AOre));
    FA093MW.selI000_T040.SetVariable('DATANAS',FDatiGiust.DataNas);
    FA093MW.selI000_T040.Open;
    if FA093MW.selI000_T040.RecordCount = 0 then
      lblInfoLog.Caption:='Nessun log presente per questo giustificativo';

    dgrdLogOperazioni.Visible:=FA093MW.selI000_T040.RecordCount > 0;
    lblInfoLog.Visible:=FA093MW.selI000_T040.RecordCount = 0;

    dsrI000.DataSet:=FA093MW.selI000_T040;
  end
  else if FDatiTimb.Progressivo <> 0 then
  begin
    FA093MW.selI000_T100.Close;
    FA093MW.selI000_T100.SetVariable('PROGRESSIVO',FDatiTimb.Progressivo);
    FA093MW.selI000_T100.SetVariable('DATA',FDatiTimb.Data);
    if VarIsType(FDatiTimb.Ora,varDate) then
    begin
      // trasforma l'ora in stringa, azzerandone i secondi
      // le timbrature manuali e richieste da web/app, infatti, non dispongono di questa info
      LOra:=DateTimeToStr(RecodeSecond(FDatiTimb.Ora,0))
    end
    else
      LOra:=VarToStr(FDatiTimb.Ora);
    FA093MW.selI000_T100.SetVariable('ORA',LOra);
    FA093MW.selI000_T100.SetVariable('VERSO',FDatiTimb.Verso);
    FA093MW.selI000_T100.SetVariable('FLAG',FDatiTimb.Flag);
    FA093MW.selI000_T100.Open;
    if FA093MW.selI000_T100.RecordCount = 0 then
      lblInfoLog.Caption:='Nessun log presente per questa timbratura';

    dgrdLogOperazioni.Visible:=FA093MW.selI000_T100.RecordCount > 0;
    lblInfoLog.Visible:=FA093MW.selI000_T100.RecordCount = 0;

    dsrI000.DataSet:=FA093MW.selI000_T100;
  end;

  FLogCaricato:=True;
end;

procedure TC023FInfoDati.Apri1Click(Sender: TObject);
// apre il documento allegato utilizzando la shellexecute
var
  LId: Integer;
  LC021DM:TC021FDocumentiManagerDM;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
begin
  // estrae id allegato
  LId:=dgrdDocumenti.DataSource.DataSet.FieldByName('ID_ALLEGATO').AsInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  Screen.Cursor:=crHourGlass;
  LC021DM:=TC021FDocumentiManagerDM.Create(nil);
  try
    try
      // estrae il file con i metadati associati
      LResCtrl:=LC021DM.GetById(LId,True,LDoc);

      if not LResCtrl.Ok then
      begin
        R180MessageBox(LResCtrl.Messaggio,ESCLAMA);
        Exit;
      end;

      // apre il documento con il visualizzatore associato
      ShellExecute(0,'open',PChar(LDoc.FilePath),nil,nil,SW_SHOWNORMAL);
    except
      on E: Exception do
      begin
        R180MessageBox(Format('Errore durante l''apertura dell''allegato: %s',[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    FreeAndNil(LC021DM);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TC023FInfoDati.Salva1Click(Sender: TObject);
// effettua il download dell'allegato
var
  LId: Integer;
  LC021DM:TC021FDocumentiManagerDM;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
  LFileName: String;
begin
  // estrae id allegato
  LId:=dgrdDocumenti.DataSource.DataSet.FieldByName('ID_ALLEGATO').AsInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  Screen.Cursor:=crHourGlass;
  LC021DM:=TC021FDocumentiManagerDM.Create(nil);
  try
    try
      // estrae il file con i metadati associati
      LResCtrl:=LC021DM.GetById(LId,True,LDoc);

      if not LResCtrl.Ok then
      begin
        R180MessageBox(LResCtrl.Messaggio,ESCLAMA);
        Exit;
      end;

      // dialog per richiesta destinazione file
      {$WARN SYMBOL_PLATFORM OFF}
      dlgFileSave.Title:='Selezionare destinazione';
      dlgFileSave.FileName:=LDoc.GetNomeFileCompleto;
      if dlgFileSave.Execute then
      begin
        // il file è stato selezionato
        LFileName:=dlgFileSave.FileName;

        // cancella eventuale file già esistente
        if TFile.Exists(LFileName) then
          TFile.Delete(LFileName);

        TFile.Move(LDoc.FilePath,LFileName);
      end;
      {$WARN SYMBOL_PLATFORM ON}
    except
      on E: Exception do
      begin
        R180MessageBox(Format('Errore durante il salvataggio dell''allegato: %s',[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    FreeAndNil(LC021DM);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TC023FInfoDati.tabMainChange(Sender: TObject);
begin
  if tabMain.ActivePage = tabLog then
  begin
    Screen.Cursor:=crHourGlass;
    try
      CaricaInfoLog;
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
end;

end.
