unit A088UDatiLiberiIterMissioniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData,
  A000UInterfaccia, A000UMessaggi, A000UCostanti, Oracle,
  C180FunzioniGenerali, Math, Data.DB, A000USessione, Variants;

type
  TA088FDatiLiberiIterMissioniMW = class(TR005FDataModuleMW)
    selT430Colonne: TOracleDataSet;
    selT002: TOracleDataSet;
    procedure selT002FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    FSelM024: TOracleDataSet;
    FSelM025: TOracleDataSet;
  public
    procedure SelM024NewRecord;
    procedure SelM024BeforeEdit;
    procedure SelM024BeforePost;
    procedure SelM024BeforeDelete;
    procedure SelM025BeforePost;
    procedure SelM025NewRecord(Codice: String);
    procedure SelM025BeforeDelete;
    property Selm024_Funzioni: TOracleDataset read FSelM024 write FSelM024;
    property Selm025_Funzioni: TOracleDataset read FSelM025 write FSelM025;
  end;

implementation

{$R *.dfm}

// ###################################################
// ##########    GESTIONE TABELLA MASTER    ##########
// ###################################################
procedure TA088FDatiLiberiIterMissioniMW.SelM024NewRecord;
begin
  FSelM024.FieldByName('ORDINE').AsInteger:=1;
  FSelM024.FieldByName('MIN_FASE_VISIBILE').AsInteger:=0;
  FSelM024.FieldByName('MAX_FASE_VISIBILE').AsInteger:=0;
  FSelM024.FieldByName('MIN_FASE_MODIFICA').AsInteger:=0;
  FSelM024.FieldByName('MAX_FASE_MODIFICA').AsInteger:=0;
end;

procedure TA088FDatiLiberiIterMissioniMW.SelM024BeforeEdit;
begin
  if FSelM024.FieldByName('ORDINE').AsInteger = 0 then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A088_ERR_CATEGORIA_EDIT));
end;

procedure TA088FDatiLiberiIterMissioniMW.SelM024BeforePost;
var
  Codice, Descrizione: String;
begin
  // codice deve essere valorizzato
  Codice:=FSelM024.FieldByName('CODICE').AsString.Trim;
  if Codice = '' then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A088_ERR_CODICE_CAT_NULLO));

  // descrizione deve essere valorizzata
  Descrizione:=FSelM024.FieldByName('DESCRIZIONE').AsString.Trim;
  if Descrizione = '' then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_DESC_CAT_NULLA),[Codice]));

  // ordine > 0 per le categorie modificabili
  if FSelM024.FieldByName('ORDINE').AsInteger = 0 then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_ORDINE),[Descrizione]));

  // controlli sui limiti di visibilità e modifica per le fasi
  if FSelM024.FieldByName('MIN_FASE_VISIBILE').Value = null then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_LIMITE_FASE_NULL),[FSelM024.FieldByName('MIN_FASE_VISIBILE').DisplayLabel,Descrizione]));

  if FSelM024.FieldByName('MAX_FASE_VISIBILE').Value = null then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_LIMITE_FASE_NULL),[FSelM024.FieldByName('MAX_FASE_VISIBILE').DisplayLabel,Descrizione]));

  if FSelM024.FieldByName('MIN_FASE_MODIFICA').Value = null then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_LIMITE_FASE_NULL),[FSelM024.FieldByName('MIN_FASE_MODIFICA').DisplayLabel,Descrizione]));

  if FSelM024.FieldByName('MAX_FASE_MODIFICA').Value = null then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_LIMITE_FASE_NULL),[FSelM024.FieldByName('MAX_FASE_MODIFICA').DisplayLabel,Descrizione]));
end;

procedure TA088FDatiLiberiIterMissioniMW.SelM024BeforeDelete;
begin
  // le categorie di sistema (ordine 0) non sono eliminabili
  if FSelM024.FieldByName('ORDINE').AsInteger = 0 then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_DEL_CAT0),[FSelM024.FieldByName('DESCRIZIONE').AsString]));

  // controlla esistenza record figli
  FSelM025.Refresh;
  if FSelM025.RecordCount > 0 then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_DEL_CAT),[FSelM024.FieldByName('DESCRIZIONE').AsString]));
end;

// ###################################################
// ##########    GESTIONE TABELLA DETAIL    ##########
// ###################################################

procedure TA088FDatiLiberiIterMissioniMW.SelM025BeforeDelete;
// Controlli per cancellazione record
var
  Q: TOracleQuery;
  CodCategoria, DescCategoria: String;
begin
  inherited;

  // verifica che il codice non sia utilizzato
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.SQL.Add('select count(*) from M175_RICHIESTE_MOTIVAZIONI');
    Q.SQL.Add('where  CODICE = ''' + FselM025.FieldByName('CODICE').AsString + '''');
    Q.Execute;
    if Q.FieldAsInteger(0) > 0 then
    begin
      CodCategoria:=FselM025.FieldByName('CATEGORIA').AsString;
      if CodCategoria = MISSIONE_COD_CAT_ESTERO_MOTIVAZIONI then
        DescCategoria:=A000MSG_A088_MSG_MOTIVAZIONE
      else if CodCategoria = MISSIONE_COD_CAT_ESTERO_IPOTESI then
        DescCategoria:=A000MSG_A088_MSG_IPOTESI
      else if CodCategoria = MISSIONE_COD_CAT_DATI_LIBERI then
        DescCategoria:=A000MSG_A088_MSG_DATO_LIBERO;

      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_DELETE),[DescCategoria]));
    end;
  finally
    Q.Free;
  end;
end;

procedure TA088FDatiLiberiIterMissioniMW.SelM025NewRecord(Codice: String);
begin
  FSelM025.FieldByName('CATEGORIA').AsString:=Codice;
  FSelM025.FieldByName('OBBLIGATORIO').AsString:='N';
  FSelM025.FieldByName('RIGHE').AsInteger:=1;
  FSelM025.FieldByName('FORMATO').AsString:='S';
  FSelM025.FieldByName('LUNG_MAX').AsInteger:=0;
  FSelM025.FieldByName('ELENCO_FISSO').AsString:='N';
end;

procedure TA088FDatiLiberiIterMissioniMW.selM025BeforePost;
var
  Codice, Descrizione: String;
begin
  // codice deve essere valorizzato
  Codice:=FSelM025.FieldByName('CODICE').AsString.Trim;
  if Codice = '' then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A088_ERR_CODICE_NULLO));

  // descrizione deve essere valorizzata
  Descrizione:=FSelM025.FieldByName('DESCRIZIONE').AsString.Trim;
  if Descrizione = '' then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_DESC_NULLA),[Codice]));

  // obbligatorio: S/N
  if (FSelM025.FieldByName('OBBLIGATORIO').AsString <> 'S') and
     (FSelM025.FieldByName('OBBLIGATORIO').AsString <> 'N') then
  begin
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_OBBLIGATORIO),[Descrizione]));
  end;

  // controlli particolari per dati liberi
  // elenco valori indicato ma è presente un solo valore
  if (FSelM025.FieldByName('VALORI').AsString.Trim <> '')and
     (FSelM025.FieldByName('VALORI').AsString.IndexOf(',') < 0) then
  begin
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_VALORI),[Descrizione]));
  end;

  // formato del dato: S / N / D / M
  if (FSelM025.FieldByName('FORMATO').AsString <> 'S') and
     (FSelM025.FieldByName('FORMATO').AsString <> 'N') and
     (FSelM025.FieldByName('FORMATO').AsString <> 'D') and
     (FSelM025.FieldByName('FORMATO').AsString <> 'M') then
  begin
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_FORMATO),[Descrizione]));
  end;

  // controlli in base al formato
  if FSelM025.FieldByName('FORMATO').AsString = 'S' then
  begin
    // righe: 1 <= r <= 9
    if not R180Between(FSelM025.FieldByName('RIGHE').AsInteger,1,9) then
    begin
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_RIGHE),[Descrizione]));
    end;

    // lunghezza 0 <= L <= 9999
    if not R180Between(FSelM025.FieldByName('LUNG_MAX').AsInteger,0,9999) then
    begin
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_LUNG_MAX),[Descrizione]));
    end;
  end
  else
  begin
    // se formato non-stringa imposta valori di default
    FSelM025.FieldByName('RIGHE').AsInteger:=1;
    FSelM025.FieldByName('LUNG_MAX').AsInteger:=0;
  end;

  // verifica selezione valori da elenco
  if (FSelM025.FieldByName('VALORI').AsString <> '') or
     (FSelM025.FieldByName('DATO_ANAGRAFICO').AsString <> '') or
     (FSelM025.FieldByName('QUERY_VALORE').AsString <> '') then
  begin
    // valore selezionato da un elenco

    // consente selezione di uno solo dei 3 serbatoio
    if (IfThen(FSelM025.FieldByName('VALORI').AsString <> '',1,0) +
        IfThen(FSelM025.FieldByName('DATO_ANAGRAFICO').AsString <> '',1,0) +
        IfThen(FSelM025.FieldByName('QUERY_VALORE').AsString <> '',1,0)) > 1 then
    begin
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_SELEZIONE_VALORI),
                                    [Descrizione,
                                     FSelM025.FieldByName('VALORI').DisplayLabel,
                                     FSelM025.FieldByName('DATO_ANAGRAFICO').DisplayLabel,
                                     FSelM025.FieldByName('QUERY_VALORE').DisplayLabel]));
    end;

    // controlla valore di elenco fisso
    if (FSelM025.FieldByName('ELENCO_FISSO').AsString <> 'S') and
       (FSelM025.FieldByName('ELENCO_FISSO').AsString <> 'N') then
    begin
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_ELENCO_FISSO),[Descrizione]));
    end;

    // imposta numero di righe default = 1
    FSelM025.FieldByName('RIGHE').AsInteger:=1;
  end
  else
  begin
    // valore libero

    // imposta elenco fisso a N
    FSelM025.FieldByName('ELENCO_FISSO').AsString:='N';
  end;
end;

// ###################################################
// ##########      DATASET DI SUPPORTO      ##########
// ###################################################

procedure TA088FDatiLiberiIterMissioniMW.selT002FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',DataSet.FieldByName('NOME').AsString);
end;

end.
