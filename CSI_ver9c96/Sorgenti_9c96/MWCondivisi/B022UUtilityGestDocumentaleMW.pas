unit B022UUtilityGestDocumentaleMW;

interface

uses
  System.SysUtils, System.Classes, A000UCostanti, A000UInterfaccia, R005UDataModuleMW,
  OracleData, C180FunzioniGenerali, C021UDocumentiManagerDM, Data.DB, IOUtils,
  System.Types, Variants, System.Generics.Collections, Oracle, A000UMessaggi;

type
  TProgressBarMW = procedure of object;

  TB022Documento = class
    NomeFile:String;
    NomeFileNuovo:String;
    Path:String;
    Progressivo:Integer;
    NomeDip,CognomeDip:String;
    DimensioneByte:Integer;
  end;

  TB022TipoNomeFileOutput = (tnfoOriginale,tnfoPredefinito,tnfoTagNomeFile);

  TB022DocumentiSearchConfig = class  // Usato della fase di scansione e preparazione lista documenti
    FFormatoNomeFile,FSeparatore:String;
    IndiciTag:TDictionary<String,Integer>;
    TipoNomeFileOutput:TB022TipoNomeFileOutput;
    NomeFileOutputPredef:String;
  private
    procedure SetFormatoNomeFile(const Value: String);
    procedure SetSeparatore(const Value: String);
    public
      constructor Create;
      procedure PreparaIndiciTag;
      destructor Destroy; override;
      property FormatoNomeFile:String read FFormatoNomeFile write SetFormatoNomeFile;
      property Separatore:String read FSeparatore write SetSeparatore;
  end;

  TB022RisultatoSearch = class
    ListaDocumenti:TObjectList<TB022Documento>; // Elenco dei documenti (completi di metadati) che possono essere importati
    ListaFileIgnorati:TStringList; // Lista di nomi di file che sono stati ignorati (no progressivo, parse nome fallito, ecc.)
    public
      constructor Create;
      destructor Destroy; override;
  end;

  TB022DocumentiImportConfig = class  // Usato della fase di importazione
    Tipologia:String;
    Sovrascrivi: Boolean; // Elimina il documento esistente dalla tipologia prima di importare
    UfficioRiferimento:String;
    PeriodoDal,PeriodoAl:String; // Data in formato DD/MM/YYYY oppure NULL
    Note:String;
    AccessoPortale:String;
  end;

  TB022FUtilityGestDocumentaleMW = class(TR005FDataModuleMW)
    seqT960: TOracleQuery;
    insT960: TOracleQuery;
    selT960ByProgTipol: TOracleDataSet;
    selT962: TOracleDataSet;
    dsrT962: TDataSource;
    selT963: TOracleDataSet;
    dsrT963: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
    selT960_Funzioni: TOracleDataSet;
    selT960PathStorage_Funzioni: TOracleDataSet;
    ProgressBar: TProgressBarMW;
    C021DM: TC021FDocumentiManagerDM;
    CodTipologiaDefault,CodUfficioDefault:String;
    IterMaxDimAllegatoMB:Integer;
    ElencoDocumentiImport:TB022RisultatoSearch;
    DataInizioStr,DataFineStr:String;
    procedure ElaborazioneRecords(TipoElaborazione: Integer; PathStorage: String);
    procedure selT960BeforePost;
    procedure selT960AfterPost;
    procedure selT960CalcFields;
    function AnalizzaDocumentiImport(Path,Filtro:String;
                                 ADSelAnagrafe:TOracleDataSet;
                                 SearchConfig:TB022DocumentiSearchConfig):TB022RisultatoSearch;
    procedure ImportaDocumento(B022Doc:TB022Documento; ConfigImport:TB022DocumentiImportConfig);
    procedure Controlli(DataVuota,DataDal,DataAl:String);
    const
      FORMATO_NOME_FILE_OUT_ORIG = 'O'; // Originale, come file in ingresso
      FORMATO_NOME_FILE_OUT_PRED=  'P'; // Predefinito, specificato dall'utente
      FORMATO_NOME_FILE_OUT_TAG =  'T'; // Tag <NOME_DEL_FILE>
  end;

const
  TAG_MATRICOLA:String = '<MATRICOLA>';
  TAG_CODICE_FISCALE: String = '<CODICE_FISCALE>';
  TAG_NOME_DEL_FILE: String = '<NOME_DEL_FILE>';

implementation

{$R *.dfm}

{ TB022DocumentiSearchConfig }

constructor TB022DocumentiSearchConfig.Create;
begin
  IndiciTag:=TDictionary<String,Integer>.Create;
end;

destructor TB022DocumentiSearchConfig.Destroy;
begin
  FreeAndNil(IndiciTag);
end;

{ TB022RisultatoSearch }

constructor TB022RisultatoSearch.Create;
begin
  ListaDocumenti:=TObjectList<TB022Documento>.Create(True);
  ListaFileIgnorati:=TStringList.Create;
end;

destructor TB022RisultatoSearch.Destroy;
begin
  FreeAndNil(ListaFileIgnorati);
  FreeAndNil(ListaDocumenti);
end;

procedure TB022DocumentiSearchConfig.SetFormatoNomeFile(const Value: String);
var
  i:Integer;
  InternoDiTag:Boolean;
  NomeUltimoTag,UltimoChar:String;
  Valido:Boolean;
begin
  if Length(Trim(Separatore)) <> 1 then
    raise Exception.Create('Separatore non valido');
  // Verifico che:
  // 1. tutti i caratteri di apertura tag abbiano il corrispettivo di chiusura subito a seguire
  // 2. che gli unici caratteri fuori dai tag siano separatori
  InternoDiTag:=False;
  Valido:=True;
  for i:=1 to Length(Value) do
  begin
    if (i = 1) and (Value[i] <> '<') then
      Valido:=False // il primo carattere deve essere '<'
    else if Value[i] = '<' then
    begin
      if not InternoDiTag then
      begin
        NomeUltimoTag:='';
        InternoDiTag:=True
      end
      else
        Valido:=False; // doppia apertura di un tag
      if Valido then
      begin
        // In aggiunta: se non è il primo carattere quello che mi precede deve essere
        // un separatore
        if (i > 1) and (UltimoChar <> FSeparatore) then
          Valido:=False;
      end;
    end
    else if Value[i] = '>' then
    begin
      if not InternoDiTag then
        Valido:=False // chiuso un tag senza l'apertura
      else if NomeUltimoTag = '' then
        Valido:=False // abbiamo chiuso un tag correttamente, ma ha nome vuoto
      else
        InternoDiTag:=False;
    end
    else
    begin
      if InternoDiTag then
        NomeUltimoTag:=NomeUltimoTag + Value[i]
      else
      begin
        if (Value[i] <> FSeparatore) then
          Valido:=False // Siamo fuori da un tag e abbiamo un carattere <> separatore
        else if UltimoChar = FSeparatore then
          Valido:=False; // Questo carattere è un separatore, ma era preceduto da un'altro separatore
      end;
    end;
    if not Valido then
      Break;
    UltimoChar:=Value[i];
  end;
  if Valido and InternoDiTag then
    Valido:=False; // un tag è rimasto aperto
  if Valido and (UltimoChar = FSeparatore) then
    Valido:=False; // L'ultimo carattere è un separatore
  if not Valido then
    raise Exception.Create('Formato nome di file non valido.');

  if Value <> FFormatoNomeFile then
    IndiciTag.Clear;
  FFormatoNomeFile:=Trim(Value);
end;

procedure TB022DocumentiSearchConfig.SetSeparatore(const Value: String);
begin
  if Length(Trim(Value)) <> 1 then
    raise Exception.Create('Separatore non valido');
  if Value <> FSeparatore then
    IndiciTag.Clear;
  FSeparatore:=Trim(Value);
end;

procedure TB022DocumentiSearchConfig.PreparaIndiciTag;
var
  i,CurrSplitIdx:Integer;
  StringBuilder:TStringBuilder;
  ConsideraSeparatore:Boolean;
begin
  IndiciTag.Clear;
  if (FFormatoNomeFile = '') or (FSeparatore = '') then
    raise Exception.Create('Separatore/formato nome di file non impostati.');
  StringBuilder:=TStringBuilder.Create;
  ConsideraSeparatore:=True;
  CurrSplitIdx:=0;
  try
    for i:=1 to Length(FFormatoNomeFile) do
    begin
      if FFormatoNomeFile[i] = '<' then
        ConsideraSeparatore:=False
      else if FFormatoNomeFile[i] = '>' then
        ConsideraSeparatore:=True;

      if (FFormatoNomeFile[i] = FSeparatore) and (ConsideraSeparatore) then
      begin
        IndiciTag.Add(StringBuilder.ToString,CurrSplitIdx);
        Inc(CurrSplitIdx);
        StringBuilder.Clear; // Svuoto il builder e non considero questo '_'
      end
      else
      begin
        // O il carattere è <> da '_' oppure è '_' e siamo all'interno di tag.
        StringBuilder.Append(FFormatoNomeFile[i]);
      end;
    end;
    if StringBuilder.Length > 0 then
      IndiciTag.Add(StringBuilder.ToString,CurrSplitIdx);
    // Devo avere solo un tag matricola o codice fiscale
    if (not IndiciTag.ContainsKey(TAG_MATRICOLA)) and (not IndiciTag.ContainsKey(TAG_CODICE_FISCALE)) then
    begin
      IndiciTag.Clear;
      raise Exception.Create('Il formato deve contenere un tag ' + TAG_MATRICOLA + ' o ' + TAG_CODICE_FISCALE + '.');
    end
    else if (IndiciTag.ContainsKey(TAG_MATRICOLA)) and (IndiciTag.ContainsKey(TAG_CODICE_FISCALE)) then
    begin
      IndiciTag.Clear;
      raise Exception.Create('Il formato deve contenere un solo tag ' + TAG_MATRICOLA + ' o ' + TAG_CODICE_FISCALE + '.');
    end;
  finally
    FreeAndNil(StringBuilder);
  end;
end;

procedure TB022FUtilityGestDocumentaleMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  // inizializzazione C021
  C021DM:=TC021FDocumentiManagerDM.Create(Owner);

  IterMaxDimAllegatoMB:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB,5);

  CodTipologiaDefault:=DOC_TIPOL_PREDEF;
  CodUfficioDefault:=DOC_UFFICIO_PREDEF;

  selT962.Filter:='CODICE <> ''' + DOC_TIPOL_ITER + '''';
  selT962.Filtered:=True;
  selT962.Open;
  selT962.First;
  while not selT962.Eof do
  begin
    // codice default
    if selT962.FieldByName('CODICE_DEFAULT').AsString = 'S' then
      CodTipologiaDefault:=selT962.FieldByName('CODICE').AsString;
    selT962.Next;
  end;
  selT962.First;

  selT963.Open;
  selT963.First;
  while not selT963.Eof do
  begin
    // codice default
    if selT963.FieldByName('CODICE_DEFAULT').AsString = 'S' then
      CodUfficioDefault:=selT963.FieldByName('CODICE').AsString;
    selT963.Next;
  end;
  selT963.First;
end;

procedure TB022FUtilityGestDocumentaleMW.ElaborazioneRecords(TipoElaborazione: Integer; PathStorage: String);
var
  LID: Integer;
  LDoc: TDocumento;
  LElaborazionePermessa: Boolean;
  LResCtrl: TResCtrl;
begin
  // inizio registrazione messaggi di elaborazione
  RegistraMsg.IniziaMessaggio('B022');

  selT960_Funzioni.First;
  while not selT960_Funzioni.Eof do
  try
    // estrazione id file
    RegistraMsg.InserisciMessaggio('I', 'File ' + selT960_Funzioni.FieldByName('INFO_FILE').AsString +
                                    ' | ID ' + selT960_Funzioni.FieldByName('ID').AsString + ' - inizio elaborazione', Parametri.Azienda,
                                    selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger);

    // controllo sull'operazione
    LElaborazionePermessa:=True;
    if (TipoElaborazione = 0) and (selT960_Funzioni.FieldByName('PATH_STORAGE').AsString <> 'DB') then
      LElaborazionePermessa:=False
    else if (TipoElaborazione = 1) and (selT960_Funzioni.FieldByName('PATH_STORAGE').AsString = 'DB') then
      LElaborazionePermessa:=False
    else if (TipoElaborazione = 2) and ((selT960_Funzioni.FieldByName('PATH_STORAGE').AsString = 'DB') or
                                        (UpperCase(selT960_Funzioni.FieldByName('PATH_STORAGE').AsString) = UpperCase(PathStorage))) then
      LElaborazionePermessa:=False;

    if not LElaborazionePermessa then
      RegistraMsg.InserisciMessaggio('A', 'File ' + selT960_Funzioni.FieldByName('INFO_FILE').AsString +
                                      ' | ID ' + selT960_Funzioni.FieldByName('ID').AsString + ' - il file non è stato spostato nella area ' +
                                      'di storage di destinazione perchè non soddisfa i criteri di selezione', Parametri.Azienda,
                                      selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger)
    else
    begin
      LID:=selT960_Funzioni.FieldByName('ID').AsInteger;
      if LID > 0 then
      begin

        // estrazione info file
        RegistraMsg.InserisciMessaggio('I', 'File ' + selT960_Funzioni.FieldByName('INFO_FILE').AsString +
                                        ' | ID ' + selT960_Funzioni.FieldByName('ID').AsString + ' - download file dalla vecchia area di storage',
                                        Parametri.Azienda, selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger);

        if (selT960_Funzioni.FieldByName('PATH_STORAGE').AsString <> 'DB') and (not C021DM.TestAccesso(selT960_Funzioni.FieldByName('PATH_STORAGE').AsString)) then
        begin
          RegistraMsg.InserisciMessaggio('A', 'File ' + selT960_Funzioni.FieldByName('INFO_FILE').AsString +
                                          ' | ID ' + selT960_Funzioni.FieldByName('ID').AsString +
                                          ' | Path ' + selT960_Funzioni.FieldByName('PATH_STORAGE').AsString + ' - vecchia area di storage non accessibile',
                                          Parametri.Azienda, selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
        end
        else
        begin
          // estrae il file con i metadati associati
          try
            try
              LResCtrl:=C021DM.GetById(LId,True,LDoc);

              if not LResCtrl.Ok then
              begin
                RegistraMsg.InserisciMessaggio('A', 'File ' + selT960_Funzioni.FieldByName('INFO_FILE').AsString +
                                                ' | ID ' + selT960_Funzioni.FieldByName('ID').AsString + ' - ' + LResCtrl.Messaggio,Parametri.Azienda,
                                                selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
                Exit;
              end;
            except
              RegistraMsg.InserisciMessaggio('A', 'File ' + selT960_Funzioni.FieldByName('INFO_FILE').AsString +
                                              ' | ID ' + selT960_Funzioni.FieldByName('ID').AsString + ' - errore durante download del file', Parametri.Azienda,
                                              selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
            end;

            try
              // impostazione nuovo path storage
              LDoc.PathStorage:=PathStorage;
              LDoc.TempFile:=LDoc.FilePath; // variabile che serve per la procedura di upload
              RegistraMsg.InserisciMessaggio('I', 'File ' + selT960_Funzioni.FieldByName('INFO_FILE').AsString +
                                              ' | ID ' + selT960_Funzioni.FieldByName('ID').AsString + ' - upload file nella nuova area ' +
                                              'di storage', Parametri.Azienda, selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger);

              LResCtrl:=C021DM.Upload(LDoc);
              if not LResCtrl.Ok then
                RegistraMsg.InserisciMessaggio('A', 'File ' + selT960_Funzioni.FieldByName('INFO_FILE').AsString +
                                                ' | ID ' + selT960_Funzioni.FieldByName('ID').AsString + ' - errore durante upload del file ' +
                                                'nella nuova area di storage', Parametri.Azienda,
                                                selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger)
              else
              begin
                //eliminazione file nel vecchio path storage
                RegistraMsg.InserisciMessaggio('I', 'File ' + selT960_Funzioni.FieldByName('INFO_FILE').AsString +
                                                ' | ID ' + selT960_Funzioni.FieldByName('ID').AsString + ' - eliminazione file dalla ' +
                                                'vecchia area di storage', Parametri.Azienda,
                                                selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
                if selT960_Funzioni.FieldByName('PATH_STORAGE').AsString = 'DB' then
                begin
                  C021DM.delT961.SetVariable('ID', LID);
                  C021DM.delT961.Execute;
                end
                else
                begin
                  // cancellazione documento via webservice B021
                  // se la provenienza del file è interna cancella per id, altrimenti per nome file
                  if selT960_Funzioni.FieldByName('PROVENIENZA').AsString = DOC_PROVENIENZA_INTERNA then
                    LResCtrl:=C021DM.DeleteJson(selT960_Funzioni.FieldByName('PATH_STORAGE').AsString,LID)
                  else
                    LResCtrl:=C021DM.DeleteJson(selT960_Funzioni.FieldByName('PATH_STORAGE').AsString,Format('%s.%s',[selT960_Funzioni.FieldByName('NOME_FILE').AsString,selT960_Funzioni.FieldByName('EXT_FILE').AsString]));
                end;
                // assegnazione path storage t960
                RegistraMsg.InserisciMessaggio('I', 'File ' + selT960_Funzioni.FieldByName('INFO_FILE').AsString +
                                                ' | ID ' + selT960_Funzioni.FieldByName('ID').AsString + ' - modifica area di storage sulla ' +
                                                'tabella T960', Parametri.Azienda, selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
                selT960_Funzioni.Edit;
                selT960_Funzioni.FieldByName('PATH_STORAGE').AsString:=PathStorage;
                selT960_Funzioni.Post;
              end;
            except
              RegistraMsg.InserisciMessaggio('A', 'File ' + selT960_Funzioni.FieldByName('INFO_FILE').AsString +
                                              ' | ID ' + selT960_Funzioni.FieldByName('ID').AsString + ' - errore durante lo spostamento ' +
                                              'del file', Parametri.Azienda, selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
            end;
          finally
            FreeAndNil(LDoc);
          end;
        end;
      end;
    end;
  finally
    RegistraMsg.InserisciMessaggio('I', 'File ' + selT960_Funzioni.FieldByName('INFO_FILE').AsString +
                                    ' | ID ' + selT960_Funzioni.FieldByName('ID').AsString + ' - fine elaborazione',
                                    Parametri.Azienda, selT960_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    selT960_Funzioni.Next;

    // gestione progress bar
    if @ProgressBar <> nil then // @ corrispondente ad assigned
      ProgressBar;
  end;
  selT960_Funzioni.Refresh;
end;

procedure TB022FUtilityGestDocumentaleMW.DataModuleDestroy(Sender: TObject);
begin
  if ElencoDocumentiImport <> nil then
    FreeAndNil(ElencoDocumentiImport);
  FreeAndNil(C021DM);
  inherited;
end;

procedure TB022FUtilityGestDocumentaleMW.selT960AfterPost;
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TB022FUtilityGestDocumentaleMW.selT960BeforePost;
begin
  RegistraLog.SettaProprieta('M',R180Query2NomeTabella(selT960_Funzioni),Copy(Name,1,4),selT960_Funzioni,True);
end;

procedure TB022FUtilityGestDocumentaleMW.selT960CalcFields;
begin
  // dimensione file
  if not (selT960_Funzioni.FieldByName('DIMENSIONE').AsString = '') then
    selT960_Funzioni.FieldByName('D_DIMENSIONE').AsString:=R180GetFileSizeStr(selT960_Funzioni.FieldByName('DIMENSIONE').AsLargeInt);
end;

function TB022FUtilityGestDocumentaleMW.AnalizzaDocumentiImport(Path,Filtro:String;
                                           ADSelAnagrafe:TOracleDataSet;
                                           SearchConfig:TB022DocumentiSearchConfig):TB022RisultatoSearch;
var
  ElencoFileInDir:TStringDynArray;
  RisultatoSearch:TB022RisultatoSearch;
  FileCorrente,TagAnagrafico,CodiceRicerca:String;
  DocumentoCorrente:TB022Documento;
  NomeFileSplittato:TArray<String>;
  i:Integer;
  OldFileMode:Byte;
  f:File of Byte;
  DipendenteTrovato:Boolean;
begin
  if not DirectoryExists(Path) then
    raise Exception.Create('Il path specificato non esiste.');
  ElencoFileInDir:=TDirectory.GetFiles(Path,Filtro,TSearchOption.soAllDirectories);
  Result:=nil;
  OldFileMode:=FileMode;
  FileMode:=0;
  RisultatoSearch:=TB022RisultatoSearch.Create;
  try
    try
      // Con cosa sto cercando il dipendente? Ho già controllato che almeno uno dei due tag siano
      // presenti in precedenza
      if SearchConfig.FormatoNomeFile.Contains(TAG_MATRICOLA) then
        TagAnagrafico:=TAG_MATRICOLA
      else
        TagAnagrafico:=TAG_CODICE_FISCALE;

      for i:=0 to (Length(ElencoFileInDir) - 1) do
      begin
        DipendenteTrovato:=False;
        FileCorrente:=ExtractFileName(ElencoFileInDir[i]);
        NomeFileSplittato:=FileCorrente.Split([SearchConfig.Separatore]);
        if Length(NomeFileSplittato) = SearchConfig.IndiciTag.Count then
        begin
          // Il nome del file è potenzialmente corretto
          // CodiceRicerca è il CF o la matricola a seconda del formato
          CodiceRicerca:=NomeFileSplittato[SearchConfig.IndiciTag.Items[TagAnagrafico]];
          // Cerchiamo il dipendente
          if TagAnagrafico = TAG_MATRICOLA then
            DipendenteTrovato:=ADSelAnagrafe.SearchRecord('MATRICOLA',CodiceRicerca,[srFromBeginning])
          else
            DipendenteTrovato:=ADSelAnagrafe.SearchRecord('CODFISCALE',CodiceRicerca,[srFromBeginning]);
          if DipendenteTrovato then
          begin
            DocumentoCorrente:=TB022Documento.Create;
            DocumentoCorrente.NomeFile:=FileCorrente;
            // Il nome nuovo del file dipende dalle impostazioni
            if SearchConfig.TipoNomeFileOutput = tnfoOriginale then // Uso il nome originale del file
              DocumentoCorrente.NomeFileNuovo:=FileCorrente
            else if SearchConfig.TipoNomeFileOutput = tnfoPredefinito then // Nome impostato dall'utente
              DocumentoCorrente.NomeFileNuovo:=SearchConfig.NomeFileOutputPredef
            else // Il nome è il valore del tag <NOME_DEL_FILE>
              DocumentoCorrente.NomeFileNuovo:=NomeFileSplittato[SearchConfig.IndiciTag.Items[TAG_NOME_DEL_FILE]];
            DocumentoCorrente.Path:=ElencoFileInDir[i];
            DocumentoCorrente.Progressivo:=ADSelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
            DocumentoCorrente.NomeDip:=ADSelAnagrafe.FieldByName('NOME').AsString;
            DocumentoCorrente.CognomeDip:=ADSelAnagrafe.FieldByName('COGNOME').AsString;
            AssignFile(f,ElencoFileInDir[i]);
            Reset(f); // Apertura
            try
              DocumentoCorrente.DimensioneByte:=FileSize(f);
            finally
              CloseFile(f);
            end;
            RisultatoSearch.ListaDocumenti.Add(DocumentoCorrente);
          end
          else
          begin
            // Non esiste un dipendente che abbia il codice indicato
            RisultatoSearch.ListaFileIgnorati.Add(FileCorrente);
          end;
        end
        else
        begin
          // Il nome del file una volta splittato non contiene lo stesso numero di elementi.
          // E' incompatibile con il formato specificato
          RisultatoSearch.ListaFileIgnorati.Add(FileCorrente);
        end;
      end;
      Result:=RisultatoSearch;
    except
      on E:Exception do
      begin
        RisultatoSearch.Free;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FileMode:=OldFileMode;
  end;
end;

procedure TB022FUtilityGestDocumentaleMW.ImportaDocumento(B022Doc:TB022Documento; ConfigImport:TB022DocumentiImportConfig);
var
  IdDocumento,NumDoc:Integer;
  Documento:TDocumento;
  ResCtrl:TResCtrl;
  PathDoc,NomeOldFile:String;
  LResCtrl:TResCtrl;
  EliminaVecchioDocumento:Boolean;
begin
  SessioneOracle.Commit;
  Documento:=TDocumento.Create;
  try
    try
      // Modalità sovrascrittura?
      EliminaVecchioDocumento:=False;
      if ConfigImport.Sovrascrivi then
      begin
        // Il dipendente ha già un documento per la tipologia indicata?
        selT960ByProgTipol.Close;
        selT960ByProgTipol.ClearVariables;
        selT960ByProgTipol.SetVariable('PROGRESSIVO',B022Doc.Progressivo);
        selT960ByProgTipol.SetVariable('TIPOLOGIA',ConfigImport.Tipologia);
        selT960ByProgTipol.Open;
        NumDoc:=selT960ByProgTipol.RecordCount;
        if NumDoc = 1 then
        begin
          // Posso eliminare il documento esistente?
          if (selT960ByProgTipol.FieldByName('NOME_UTENTE').AsString <> '') then
          begin
            RegistraMsg.InserisciMessaggio('A', Format('Errore durante l''importazione di %s: %s',[B022Doc.NomeFile,'impossibile cancellare il documento esistente perchè creato via IrisWeb.']),
                                           Parametri.Azienda, B022Doc.Progressivo);
            Exit;
          end;
          if selT960ByProgTipol.FieldByName('TIPOLOGIA').AsString = DOC_TIPOL_ITER then
          begin
            RegistraMsg.InserisciMessaggio('A', Format('Errore durante l''importazione di %s: %s',[B022Doc.NomeFile,'impossibile cancellare il documento esistente perchè associato ad una richiesta web.']),
                                           Parametri.Azienda, B022Doc.Progressivo);
            Exit;
          end;
          // Disco verde, posso cancellare.
          // L'eliminazione sarà effettuata dopo che l'importazione sarà andata a buon fine.
          EliminaVecchioDocumento:=True;
        end
        else if NumDoc > 1 then
        begin
          // Se abbiamo più di un documento per questa categoria, blocco l'importazione.
          RegistraMsg.InserisciMessaggio('A', Format('Errore durante l''importazione di %s: %s',[B022Doc.NomeFile,'esistono ' + IntToStr(NumDoc) + ' documenti per la categoria indicata, sovrascrittura annullata']),
                                             Parametri.Azienda, B022Doc.Progressivo);
          Exit;
        end;
      end;

      // Creo il record su T960_DOCUMENTI_INFO
      seqT960.Execute;
      IdDocumento:=seqT960.Field('ID');

      insT960.ClearVariables;
      insT960.SetVariable('ID',IdDocumento);
      if Parametri.TipoOperatore = 'I070' then
        insT960.SetVariable('UTENTE',Parametri.Operatore)
      else
        insT960.SetVariable('NOME_UTENTE',Parametri.Operatore);
      insT960.SetVariable('PROGRESSIVO',B022Doc.Progressivo);
      insT960.SetVariable('TIPOLOGIA',ConfigImport.Tipologia);
      insT960.SetVariable('UFFICIO',ConfigImport.UfficioRiferimento);
      insT960.SetVariable('NOME_FILE',TPath.GetFileNameWithoutExtension(B022Doc.NomeFileNuovo));
      insT960.SetVariable('EXT_FILE',TPath.GetExtension(B022Doc.NomeFile).Replace(TPath.ExtensionSeparatorChar,''));
      insT960.SetVariable('DIMENSIONE',B022Doc.DimensioneByte);
      if ConfigImport.PeriodoDal <> 'NULL' then
        insT960.SetVariable('PERIODO_DAL',Format('to_date(''%s'',''DD/MM/YYYY'')',[ConfigImport.PeriodoDal]))
      else
        insT960.SetVariable('PERIODO_DAL','NULL');
      if ConfigImport.PeriodoAl <> 'NULL' then
        insT960.SetVariable('PERIODO_AL',Format('to_date(''%s'',''DD/MM/YYYY'')',[ConfigImport.PeriodoAl]))
      else
        insT960.SetVariable('PERIODO_AL','NULL');
      insT960.SetVariable('NOTE',ConfigImport.Note);
      insT960.SetVariable('PATH_STORAGE',Parametri.CampiRiferimento.C90_PathAllegati);
      insT960.SetVariable('ACCESSO_PORTALE',ConfigImport.AccessoPortale);
      insT960.Execute;

      // Chiedo al C021DM di salvare il documento sullo storage appropriato
      Documento.Id:=IdDocumento;
      Documento.TempFile:=B022Doc.Path;
      Documento.PathStorage:=Parametri.CampiRiferimento.C90_PathAllegati;
      try
        ResCtrl:=C021DM.Upload(Documento);
        if not ResCtrl.Ok then
          raise Exception.Create('Upload documento ha ritornato il messaggio: ' + ResCtrl.Messaggio); // Lo gestisce il try...finally sotto
        if (ConfigImport.Sovrascrivi) and (EliminaVecchioDocumento) and (selT960ByProgTipol.State = dsBrowse) and
           (selT960ByProgTipol.RecordCount = 1) then // Controlli (ridondanti) di sicurezza
        begin
          // Il dataset selT960ByProgTipol è già correttamente posizionato sul documento da cancellare.
          PathDoc:=selT960ByProgTipol.FieldByName('PATH_STORAGE').AsString;
          if PathDoc <> DOC_STORAGE_DB then
          begin
            // cancellazione documento via webservice B021
            // se la provenienza del file è interna cancella per id, altrimenti per nome file
            if selT960ByProgTipol.FieldByName('PROVENIENZA').AsString = DOC_PROVENIENZA_INTERNA then
              LResCtrl:=C021DM.DeleteJson(PathDoc,selT960ByProgTipol.FieldByName('ID').AsInteger)
            else
              LResCtrl:=C021DM.DeleteJson(PathDoc,Format('%s.%s',[selT960ByProgTipol.FieldByName('NOME_FILE').AsString,selT960ByProgTipol.FieldByName('EXT_FILE').AsString]));

            if not LResCtrl.Ok then
            begin
              RegistraMsg.InserisciMessaggio('A', Format('Errore durante l''importazione di %s: %s (%s)',[B022Doc.NomeFile,'errore durante la cancellazione del documento esistente',LResCtrl.Messaggio]),
                                             Parametri.Azienda, B022Doc.Progressivo);
              Exit;
            end;
          end;
          // Possiamo cancellare il record su T960, con la foreign key su T961 sarà cancellato anche
          // il BLOB su DB se necessario.
          NomeOldFile:=Format('%s.%s',[selT960ByProgTipol.FieldByName('NOME_FILE').AsString,selT960ByProgTipol.FieldByName('EXT_FILE').AsString]);
          selT960ByProgTipol.Delete;
          RegistraMsg.InserisciMessaggio('I', Format('Il file %s è stato sovrascritto con %s durante l''importazione',[NomeOldFile,B022Doc.NomeFile]),
                                             Parametri.Azienda, B022Doc.Progressivo);
        end;
      except
        on E:Exception do
          raise Exception.Create(E.Message); // Lo gestisce il try...finally sotto
      end;

      SessioneOracle.Commit;
    except
      on E:Exception do
      begin
        SessioneOracle.Rollback;
        RegistraMsg.InserisciMessaggio('A', Format('Errore durante l''importazione di %s: %s',[B022Doc.NomeFile,E.Message]),
                                       Parametri.Azienda, B022Doc.Progressivo);
      end;
    end;
  finally
    Documento.Free;
    selT960ByProgTipol.Close;
  end;
end;

procedure TB022FUtilityGestDocumentaleMW.Controlli(DataVuota,DataDal,DataAl:String);
var
  DataInizio,DataFine:TDateTime;
begin
  // Se il path dello storage è su file system verifico che il servizio B021 risponda
  if (Parametri.CampiRiferimento.C90_PathAllegati <> 'DB') and (not C021DM.TestWebService) then
    raise Exception.Create(A000MSG_A200_ERR_B021_NON_RISPONDE);

  // Verifico la validità delle impostazioni
  if ((DataDal = DataVuota) and (DataAl <> DataVuota)) or
     ((DataDal <> DataVuota) and (DataAl = DataVuota)) then
    raise Exception.Create(A000MSG_A200_ERR_NO_DATE_PERIODO);
  // A questo punto i casi sono: o ho valorizzato entrambe le date oppure nessuna.
  DataInizioStr:='NULL';
  DataFineStr:='NULL';
  if (DataDal <> DataVuota) and (DataAl <> DataVuota) then
  begin
    try
      DataInizio:=StrToDate(DataDal); // Prendo solo la parte intera
      DataFine:=StrToDate(DataAl);
    except
      on E:EConvertError do
        raise Exception.Create(A000MSG_ERR_DATA_VALIDA);
    end;
    if (DataInizio <> DATE_NULL) or
       (DataFine <> DATE_NULL) then
    begin
      // data inizio periodo
      // controlla validità nel range convenzionale
      if (DataInizio < DATE_MIN) or (DataInizio > DATE_MAX) then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO));
      // data fine periodo
      // controlla validità nel range convenzionale
      if (DataFine < DATE_MIN) or (DataFine > DATE_MAX) then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO));
      // controlla consecutività periodo
      if DataInizio > DataFine then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO));
      DataInizioStr:=DataDal;
      DataFineStr:=DataAl;
    end;
  end;
end;

end.
