unit W032URichiestaMissioniDM;

interface

uses
  C018UIterAutDM, C180FunzioniGenerali, W000UMessaggi,
  SysUtils, Classes, DB, Oracle, OracleData, StrUtils, Math, Variants;

type
  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.ini
  // dettaglio per rimborso automatico
  TRimbAutomatico = record
    Abilitato: Boolean; // True: rimborso automatico abilitato, False: non abilitato
    CodIndKM: String;   // codice indennità km da impostare su rimborso automatico
    CodValuta: String;  // codice valuta per il valore del rimborso
  end;
  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.ini

  TLocalita = record
    Tipo: String;
    CodLocalita: String;
    DescLocalita: String;
    class operator Equal(ALeftOp, ARightOp: TLocalita): Boolean;
    class operator NotEqual(ALeftOp, ARightOp: TLocalita): Boolean;
  end;

  TComune = record
    Codice: String;
    Citta: String;
    CodProvincia: String;
    CodRegione: String;
  end;

  TTappa = record
    Ord: Integer;
    Localita: String;
    IndKm: String;
    TipoLocalita: String;
    DescLocalita: String;
    Distanza: Integer;
  end;

  TPercorsoInfo = record
    Partenza: TLocalita;
    DestinazioneArr: array of TLocalita;
    ElencoDestinazioni: String;
    ElencoDestinazioniDesc: String;
    Rientro: TLocalita;
    Testo: String;
    FlagDestinazione: String;
    FlagPercorso: String;
  end;

  TW032FRichiestaMissioniDM = class(TDataModule)
    selM020Mezzi: TOracleDataSet;
    selM140: TOracleDataSet;
    selM140ID: TFloatField;
    selM140PROGRESSIVO: TIntegerField;
    selM140DATA_RICHIESTA: TDateTimeField;
    selM140FLAG_ISPETTIVA: TStringField;
    selM140DATADA: TDateTimeField;
    selM140DATAA: TDateTimeField;
    selM140ORADA: TStringField;
    selM140ORAA: TStringField;
    selM140FLAG_TIPOACCREDITO: TStringField;
    selM140DELEGATO: TStringField;
    selM140MATRICOLA: TStringField;
    selM140NOMINATIVO: TStringField;
    selM140SESSO: TStringField;
    selM140NOMINATIVO_RESP: TStringField;
    selM140D_AUTORIZZAZIONE: TStringField;
    selM020Anticipi: TOracleDataSet;
    selM025: TOracleDataSet;
    selM175: TOracleDataSet;
    selM160: TOracleDataSet;
    selM170: TOracleDataSet;
    selM150: TOracleDataSet;
    selM020Rimborsi: TOracleDataSet;
    selM021: TOracleDataSet;
    selP030: TOracleDataSet;
    selM150ID: TFloatField;
    selM150INDENNITA_KM: TStringField;
    selM150CODICE: TStringField;
    selM150KMPERCORSI: TFloatField;
    selM150COD_VALUTA: TStringField;
    selM150RIMBORSO: TFloatField;
    selM150RIMBORSO_VARIATO: TFloatField;
    selM150NOTE: TStringField;
    selM150FILE_ALLEGATO: TStringField;
    selM150C_DESCRIZIONE: TStringField;
    selM160ID: TFloatField;
    selM160CODICE: TStringField;
    selM160QUANTITA: TFloatField;
    selM160NOTE: TStringField;
    selM160C_DESCRIZIONE: TStringField;
    selM160C_TIPO_QUANTITA: TStringField;
    selM160C_PERC_ANTICIPO: TFloatField;
    selM160C_NOTE_FISSE: TStringField;
    selM010: TOracleDataSet;
    selNomeDelegato: TOracleDataSet;
    selM140AUTORIZZ_AUTOMATICA: TStringField;
    selM140COD_ITER: TStringField;
    selM140LIVELLO_AUTORIZZAZIONE: TFloatField;
    selM140AUTORIZZAZIONE: TStringField;
    selM140ID_REVOCA: TFloatField;
    selM140ID_REVOCATO: TFloatField;
    selM140TIPO_RICHIESTA: TStringField;
    selM140REVOCABILE: TStringField;
    selM140AUTORIZZ_AUTOM_PREV: TStringField;
    selM140AUTORIZZ_PREV: TStringField;
    selM140RESPONSABILE_PREV: TStringField;
    selM140AUTORIZZ_UTILE: TStringField;
    selM140AUTORIZZ_REVOCA: TStringField;
    selM140D_TIPO_RICHIESTA: TStringField;
    selM140D_RESPONSABILE: TStringField;
    selM140FASE_CORRENTE: TFloatField;
    selM140PROTOCOLLO: TStringField;
    M040P_CARICA_MISSIONE_DAITER: TOracleQuery;
    M060P_CARICA_ANTICIPI_DAITER: TOracleQuery;
    M050P_CARICA_RIMBORSI_DAITER: TOracleQuery;
    delM040: TOracleQuery;
    delM060: TOracleQuery;
    delRimborsi: TOracleQuery;
    selM140F1_RESP: TStringField;
    selM140F1_STATO: TStringField;
    selM140F4_RESP: TStringField;
    selM140F4_STATO: TStringField;
    selM140TIPOREGISTRAZIONE: TStringField;
    selM140FLAG_DESTINAZIONE: TStringField;
    P050: TOracleDataSet;
    P050COD_ARROTONDAMENTO: TStringField;
    P050COD_VALUTA: TStringField;
    P050DECORRENZA: TDateTimeField;
    P050DESCRIZIONE: TStringField;
    P050VALORE: TFloatField;
    P050TIPO: TStringField;
    selM140C_DESTINAZIONE: TStringField;
    selM140C_ISPETTIVA: TStringField;
    M013F_CALC_RIMB_PASTO: TOracleQuery;
    selCountM143M150: TOracleQuery;
    selM150STATO: TStringField;
    updM150: TOracleQuery;
    selM040: TOracleQuery;
    selT106: TOracleDataSet;
    selM140ANNULLAMENTO: TStringField;
    selM150KMPERCORSI_VARIATO: TFloatField;
    selM150DATA_RIMBORSO: TDateTimeField;
    selM140C_RIMBORSI: TStringField;
    M150F_FILTRORIMBORSI: TOracleQuery;
    selM011: TOracleDataSet;
    selM143: TOracleDataSet;
    selM143DATA: TDateTimeField;
    selM143DALLE: TStringField;
    selM143ALLE: TStringField;
    selM143NOTE: TStringField;
    selM143ID: TFloatField;
    selFiltroM020: TOracleQuery;
    selQueryValore: TOracleQuery;
    USR_M140F_MSG_PERIODO_INVALIDO: TOracleQuery;
    selCountAnticipi: TOracleQuery;
    selM140C_TIPOREGISTRAZIONE: TStringField;
    selM041Localita: TOracleDataSet;
    selM041: TOracleDataSet;
    selM140PARTENZA: TStringField;
    selM140RIENTRO: TStringField;
    selM140C_PERCORSO: TStringField;
    M150P_INDKM_AUTO: TOracleQuery;
    selP150: TOracleQuery;
    selM150AUTOMATICO: TStringField;
    selT480ComuneDest: TOracleQuery;
    selCountDatiPers: TOracleQuery;
    selDatoSede: TOracleQuery;
    selM011Lookup: TOracleDataSet;
    selM170Targa: TOracleDataSet;
    selM143TIPO: TStringField;
    selM150ID_RIMBORSO: TIntegerField;
    selM150C_TIPO_QUANTITA: TStringField;
    M140F_CHECKRICHIESTA: TOracleQuery;
    selM141: TOracleDataSet;
    selM141ORD: TIntegerField;
    selM141LOCALITA: TStringField;
    selM141IND_KM: TStringField;
    selM140FLAG_PERCORSO: TStringField;
    selM141TIPO_LOCALITA: TStringField;
    selM141D_LOCALITA: TStringField;
    selM141D_ORD: TStringField;
    selM141C_DISTANZA: TFloatField;
    selM141ID: TFloatField;
    selM140ELENCO_DESTINAZIONI: TStringField;
    selM040PK: TOracleQuery;
    selM025DatiAnagPers: TOracleDataSet;
    selValiditaPeriodo: TOracleQuery;
    updM040Stato: TOracleQuery;
    selCountM143: TOracleQuery;
    selM140MISSIONE_RIAPERTA: TStringField;
    updM140Riapri: TOracleQuery;
    selM140PROTOCOLLO_MANUALE: TStringField;
    selM140C_PROTOCOLLO_MANUALE: TStringField;
    selProtocolloUnique: TOracleQuery;
    procedure selM140AfterOpen(DataSet: TDataSet);
    procedure selM140CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure selM020AnticipiFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selM150CalcFields(DataSet: TDataSet);
    procedure selM160CalcFields(DataSet: TDataSet);
    procedure selM020RimborsiFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selM160ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selM140FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selM011FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selM140BeforePost(DataSet: TDataSet);
    procedure selM140AfterPost(DataSet: TDataSet);
    procedure selM141CalcFields(DataSet: TDataSet);
    procedure selM141ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure selM143ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selM150ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selM170ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selM175ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure delM040AfterQuery(Sender: TOracleQuery);
    procedure delM040BeforeQuery(Sender: TOracleQuery);
  private
    RegistraM140: Boolean;
    function ConvertActionToOperazione(Action: Char): String;
  public
    C018:TC018FIterAutDM;
    // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.ini
    // codice dell'indennità km da utilizzare per i rimborsi automatici
    RimbAutomatico: TRimbAutomatico;
    // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.fine
    function GetLocalita(const PTipo, PCodLocalita, PDescLocalita: String): TLocalita;
    function GetDistanzaM041_2P(const PTipoA, PLocalitaA, PTipoB, PLocalitaB: String): Integer; overload;
    function GetDistanzaM041_2P(const PLocalitaA, PLocalitaB: TLocalita): Integer; overload;
    function GetDistanzaM041_3P(const PTipoA, PLocalitaA, PTipoB, PLocalitaB, PTipoC, PLocalitaC: String): Integer;
    function CaricaRimborsoAutomatico(const PCodRegola: String; var RDebugMsg, RErrMsg: String): Boolean;
    function CtrlProtocolloUnivoco(const PId: Integer; const PProtocollo: String; out RErrMsg: String): Boolean;
  end;

implementation

uses A000UCostanti, A000USessione, A000UInterfaccia;

{$R *.dfm}

procedure TW032FRichiestaMissioniDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;

  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.ini
  // apre il dataset per la ricerca delle località (percorso)
  selM041Localita.Open;

  // inizializza dati rimborso automatico
  RimbAutomatico.Abilitato:=False;
  RimbAutomatico.CodIndKM:='';
  RimbAutomatico.CodValuta:='';
  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.fine

  // AOSTA_REGIONE.ini
  // dataset utilizzato per decodifica tipo missione
  selM011Lookup.Open;
  // AOSTA_REGIONE.fine
 except
 end;
end;

procedure TW032FRichiestaMissioniDM.delM040AfterQuery(Sender: TOracleQuery);
begin
  // log solo se il record è stato effettivamente cancellato
  if delM040.RowsProcessed > 0 then
    RegistraLog.RegistraOperazione;
end;

procedure TW032FRichiestaMissioniDM.delM040BeforeQuery(Sender: TOracleQuery);
begin
  RegistraLog.SettaProprieta('C','M040_MISSIONI','W032',nil,True);
  RegistraLog.InserisciDato('ID_MISSIONE',VarToStr(delM040.GetVariable('ID')),'');
end;

procedure TW032FRichiestaMissioniDM.selM011FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('TIPOLOGIA TRASFERTA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TW032FRichiestaMissioniDM.selM020AnticipiFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('RIMBORSI MISSIONI',DataSet.FieldByName('CODICE').AsString);
end;

procedure TW032FRichiestaMissioniDM.selM020RimborsiFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('RIMBORSI MISSIONI',DataSet.FieldByName('CODICE').AsString);
end;

procedure TW032FRichiestaMissioniDM.selM140AfterOpen(DataSet: TDataSet);
begin
  (DataSet.FieldByName('DATA_RICHIESTA') as TDateTimeField).DisplayFormat:='dd/mm/yyyy hhhh.nn';
end;

procedure TW032FRichiestaMissioniDM.selM140BeforePost(DataSet: TDataSet);
// log inserimento e cancellazione gestiti a livello di C018
// la modifica viene gestita qui
begin
  RegistraM140:=DataSet.State = dsEdit;
  if DataSet.State = dsEdit then
    RegistraLog.SettaProprieta('M','M140_RICHIESTE_MISSIONI','W032',DataSet,True);
end;

procedure TW032FRichiestaMissioniDM.selM140AfterPost(DataSet: TDataSet);
// log inserimento e cancellazione gestiti a livello di C018
// la modifica viene gestita qui
begin
  if RegistraM140 then
    RegistraLog.RegistraOperazione;
end;

procedure TW032FRichiestaMissioniDM.selM140CalcFields(DataSet: TDataSet);
var
  AutorizzUtile,StatoAvanzamento,Partenza,ElencoDestinazioni,Rientro: String;
  FaseCorr,FaseLiv,FaseMinima,i: Integer;
  locLivMaxAut,locLivMaxAutNeg:Integer;
  LstDest: TStringList;
begin
  // imposta proprietà di C018 per successive operazioni
  C018.Id:=selM140.FieldByName('ID').AsInteger;
  if selM140.FieldByName('COD_ITER').AsString <> '' then
    C018.CodIter:=selM140.FieldByName('COD_ITER').AsString;

  // protocollo manuale
  selM140.FieldByName('C_PROTOCOLLO_MANUALE').AsString:=IfThen(selM140.FieldByName('PROTOCOLLO_MANUALE').AsString = 'S','Si','No');

  // destinazione
  case R180CarattereDef(selM140.FieldByName('FLAG_DESTINAZIONE').AsString) of
    'E': selM140.FieldByName('C_DESTINAZIONE').AsString:='Estero';
    'I': selM140.FieldByName('C_DESTINAZIONE').AsString:='Fuori regione';
    'R': selM140.FieldByName('C_DESTINAZIONE').AsString:='Regione';
  end;

  // ispettiva
  selM140.FieldByName('C_ISPETTIVA').AsString:=IfThen(selM140.FieldByName('FLAG_ISPETTIVA').AsString = 'S','Si','No');

  // tipo missione
  selM140.FieldByName('C_TIPOREGISTRAZIONE').AsString:=VarToStr(selM011Lookup.Lookup('CODICE',selM140.FieldByName('TIPOREGISTRAZIONE').AsString,'DESCRIZIONE'));

  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.ini
  // percorso
  // 1/3. partenza
  Partenza:=selM140.FieldByName('PARTENZA').AsString;
  if selM041Localita.SearchRecord('CODICE',Partenza,[srFromBeginning]) then
    Partenza:=selM041Localita.FieldByName('DESCRIZIONE').AsString;

  // 2/3. elenco delle destinazioni
  // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.ini
  {
  Destinazione:=FieldByName('DESTINAZIONE').AsString;
  if selM041Localita.SearchRecord('CODICE',Destinazione,[srFromBeginning]) then
    Destinazione:=selM041Localita.FieldByName('DESCRIZIONE').AsString;
  }
  // decodifica l'elenco delle destinazioni (che è separato da virgola)
  ElencoDestinazioni:=selM140.FieldByName('ELENCO_DESTINAZIONI').AsString;
  LstDest:=TStringList.Create;
  try
    LstDest.StrictDelimiter:=True;
    LstDest.CommaText:=ElencoDestinazioni;
    ElencoDestinazioni:='';
    for i:=0 to LstDest.Count - 1 do
    begin
      if selM041Localita.SearchRecord('CODICE',LstDest[i],[srFromBeginning]) then
        LstDest[i]:=selM041Localita.FieldByName('DESCRIZIONE').AsString;
    end;
    ElencoDestinazioni:=LstDest.CommaText.Replace(',',' - ',[rfReplaceAll]);
  finally
    FreeAndNil(LstDest);
  end;
  // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

  // 3/3. rientro
  Rientro:=selM140.FieldByName('RIENTRO').AsString;
  if selM041Localita.SearchRecord('CODICE',Rientro,[srFromBeginning]) then
    Rientro:=selM041Localita.FieldByName('DESCRIZIONE').AsString;

  selM140.FieldByName('C_PERCORSO').AsString:=Format('%s - %s - %s',[Partenza,ElencoDestinazioni,Rientro]);
  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.fine

  // autorizzatore
  selM140.FieldByName('D_RESPONSABILE').AsString:=selM140.FieldByName('NOMINATIVO_RESP').AsString.Trim;

  // descr. autorizzazione
  if selM140.FieldByName('AUTORIZZ_UTILE').AsString = '' then
    AutorizzUtile:=''
  else if selM140.FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
    AutorizzUtile:='No'
  else
    AutorizzUtile:='Si';
  selM140.FieldByName('D_AUTORIZZAZIONE').AsString:=AutorizzUtile;

  // fase corrente
  FaseCorr:=selM140.FieldByName('FASE_CORRENTE').AsInteger;
  if (AutorizzUtile = 'No') then
  begin
    if FaseCorr = -1 then
      FaseCorr:=1
    else
      inc(FaseCorr);
  end;

  // fase livello
  FaseLiv:=C018.FaseLivello[selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger];

  selM140.FieldByName('F1_RESP').AsString:='';
  selM140.FieldByName('F1_STATO').AsString:='';
  selM140.FieldByName('F4_RESP').AsString:='';
  selM140.FieldByName('F4_STATO').AsString:='';
  if FaseCorr >= M140FASE_AUTORIZZAZIONE then
  begin
    C018.LeggiResponsabiliFasi;
    //Leggo la fase minima prevista per questo COD_ITER:
    //può non essere la 1 (M140FASE_AUTORIZZAZIONE), in tal caso si visualizza STATO e AUTORIZZATORE della fasce minima <= M140FASE_CASSA
    FaseMinima:=M140FASE_CASSA; //Fase obbligatoria, c'è sempre
    if C018.EsisteFase[M140FASE_AGVIAGGIO] then
      FaseMinima:=M140FASE_AGVIAGGIO;
    if C018.EsisteFase[M140FASE_AUTORIZZAZIONE] then
      FaseMinima:=M140FASE_AUTORIZZAZIONE;
    selM140.FieldByName('F1_STATO').AsString:=VarToStr(C018.selT851RespFasi.Lookup('FASE',FaseMinima,'STATO'));
    if selM140.FieldByName('F1_STATO').AsString <> '' then
      selM140.FieldByName('F1_RESP').AsString:=VarToStr(C018.selT851RespFasi.Lookup('FASE',FaseMinima,'NOMINATIVO_RESP'))
    else
    begin
      selM140.FieldByName('F1_STATO').AsString:=selM140.FieldByName('D_AUTORIZZAZIONE').AsString;
      if selM140.FieldByName('F1_STATO').AsString <> '' then
        selM140.FieldByName('F1_RESP').AsString:=selM140.FieldByName('D_RESPONSABILE').AsString;
    end;
    selM140.FieldByName('F4_RESP').AsString:=VarToStr(C018.selT851RespFasi.Lookup('FASE',4,'NOMINATIVO_RESP'));
    selM140.FieldByName('F4_STATO').AsString:=VarToStr(C018.selT851RespFasi.Lookup('FASE',4,'STATO'));
    C018.selT851RespFasi.Close;
  end;

  // stato avanzamento
  if WR000DM.Responsabile then
  begin
    // autorizzazione: lo stato è determinato dal livello autorizzabile
    StatoAvanzamento:=C018.DescLivello[selM140.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger];
  end
  else
  begin
    // richiesta
    //   - se la richiesta è autorizzata (o comunque non negata)
    //       se l'ultimo livello attualmente autorizzato non è l'ultimo obbligatorio
    //         restituisce la descrizione del livello obbligatorio successivo al livello autorizzato
    //       altrimenti
    //         indica che l'iter della richiesta è concluso
    //   - se la richiesta è negata
    //       indica semplicemente questa situazione
    //Leggo nelle variabili locali per evitare esecuzioni inutili della stessa query (C018.selT851StatoLivelli)
    C018.RefreshForzato_selT851StatoLivelli:=True;
    locLivMaxAut:=C018.LivMaxAut;
    try
      C018.RefreshForzato_selT851StatoLivelli:=False;
      locLivMaxAutNeg:=C018.LivMaxAutNeg;
    finally
      C018.RefreshForzato_selT851StatoLivelli:=True;
    end;

    if locLivMaxAut >= locLivMaxAutNeg then //autorizzato
    begin
      if locLivMaxAut < C018.LivMaxObb then
        StatoAvanzamento:=C018.DescLivello[C018.LivObbSucc[locLivMaxAut]]
      else
        StatoAvanzamento:='Conclusa';
    end
    else
    begin
      StatoAvanzamento:='Negata';
    end;
  end;

  // stato avanzamento (informazioni di debug)
  {$WARN SYMBOL_PLATFORM OFF}
  if DebugHook <> 0 then
  {$WARN SYMBOL_PLATFORM ON}
  begin
    StatoAvanzamento:=Format('[TR: %s] [FC: %d] [FL: %d]'#13#10'%s',
                     [selM140.FieldByName('TIPO_RICHIESTA').AsString,
                      FaseCorr,
                      FaseLiv,
                      StatoAvanzamento]);
  end;
  selM140.FieldByName('D_TIPO_RICHIESTA').AsString:=StatoAvanzamento;
end;

procedure TW032FRichiestaMissioniDM.selM140FilterRecord(DataSet: TDataSet; var Accept: Boolean);
// esclude le richieste non ancora confermate dal dipendente (Tipo_Richiesta < 4)
// nei confronti dei responsabili che possono vedere solo le Tipo_Richieste >= 4 (fasi >= 4)
begin
  Accept:=C018.lstIdFiltrati.IndexOf(DataSet.FieldByName('ID').AsString) >= 0;
end;

function TW032FRichiestaMissioniDM.ConvertActionToOperazione(Action: Char): String;
  // converte il valore di Action (applyrecord)
  // nella corrispondente Operazione da usare in RegistraLog
begin
  case Action of
    'C': Result:='';    // Check
    'L': Result:='';    // Lock
    'I': Result:='I';   // Insert
    'U': Result:='M';   // Update
    'D': Result:='C';   // Delete
    'R': Result:='';    // Refresh
  else
    Result:='';
  end;
end;

function TW032FRichiestaMissioniDM.CtrlProtocolloUnivoco(const PId: Integer; const PProtocollo: String; out RErrMsg: String): Boolean;
// effettua query per stabilire se il protocollo indicato è univoco
// considerando i record di M040 e M140
begin
  Result:=False;
  RErrMsg:='';
  try
    selProtocolloUnique.SetVariable('ID',PId);
    selProtocolloUnique.SetVariable('PROTOCOLLO',PProtocollo);
    selProtocolloUnique.Execute;

    Result:=selProtocolloUnique.Eof;
    if not Result then
      RErrMsg:='Esiste già una missione presente con lo stesso numero di protocollo. Inserimento richiesta non consentito.';
  except
    on E: Exception do
    begin
      RErrMsg:=Format('Errore durante la verifica di univocità del numero di protocollo della richiesta:'#13#10'%s',[E.Message]);
    end;
  end;
end;

procedure TW032FRichiestaMissioniDM.selM141ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  case Action of
    'I':
      begin
        // annulla i valori dei campi fittizi affinché non siano considerati nella insert
        Sender.FieldByName('TIPO_LOCALITA').Value:=null;
        Sender.FieldByName('D_LOCALITA').Value:=null;
        Sender.FieldByName('C_DISTANZA').Value:=null;
      end;
    'U':
      begin
        // ripristina i valori dei campi fittizi affinché non vengano inclusi nella update
		{ TODO : TEST IW 15 }
        Sender.FieldByName('TIPO_LOCALITA').Value:=Sender.FieldByName('TIPO_LOCALITA').medpOldValue;
        Sender.FieldByName('D_LOCALITA').Value:=Sender.FieldByName('D_LOCALITA').medpOldValue;
        Sender.FieldByName('C_DISTANZA').Value:=Sender.FieldByName('C_DISTANZA').medpOldValue;
      end;
  end;

  // log delle modifiche
  if Action in ['I','U','D'] then
  begin
    RegistraLog.SettaProprieta(ConvertActionToOperazione(Action),'M141_PERCORSO_MISSIONE','W032',Sender,True);
    //Aggiungo il progressivo del dipendente che non è presente nella tabella
    RegistraLog.InserisciDato('PROGRESSIVO',
                              IfThen(ConvertActionToOperazione(Action) = 'I','',selM140.FieldByName('PROGRESSIVO').AsString),
                              IfThen(ConvertActionToOperazione(Action) = 'I',selM140.FieldByName('PROGRESSIVO').AsString,'')
                             );
    RegistraLog.RegistraOperazione;
  end;
end;

procedure TW032FRichiestaMissioniDM.selM141CalcFields(DataSet: TDataSet);
begin
  selM141.FieldByName('D_ORD').AsString:=Format('Tappa %d',[selM141.FieldByName('ORD').AsInteger]);
end;

procedure TW032FRichiestaMissioniDM.selM143ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  if Action in ['I','U','D'] then
  begin
    RegistraLog.SettaProprieta(ConvertActionToOperazione(Action),'M143_DETTAGLIOGG','W032',Sender,True);
    //Aggiungo il progressivo del dipendente che non è presente nella tabella
    RegistraLog.InserisciDato('PROGRESSIVO',
                              IfThen(ConvertActionToOperazione(Action) = 'I','',selM140.FieldByName('PROGRESSIVO').AsString),
                              IfThen(ConvertActionToOperazione(Action) = 'I',selM140.FieldByName('PROGRESSIVO').AsString,'')
                             );
    RegistraLog.RegistraOperazione;
  end;
end;

procedure TW032FRichiestaMissioniDM.selM150ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  if Action in ['I','U','D'] then
  begin
    RegistraLog.SettaProprieta(ConvertActionToOperazione(Action),'M150_RICHIESTE_RIMBORSI','W032',Sender,True);
    //Aggiungo il progressivo del dipendente che non è presente nella tabella
    RegistraLog.InserisciDato('PROGRESSIVO',
                              IfThen(ConvertActionToOperazione(Action) = 'I','',selM140.FieldByName('PROGRESSIVO').AsString),
                              IfThen(ConvertActionToOperazione(Action) = 'I',selM140.FieldByName('PROGRESSIVO').AsString,'')
                             );
    RegistraLog.RegistraOperazione;
  end;
end;

procedure TW032FRichiestaMissioniDM.selM150CalcFields(DataSet: TDataSet);
var
  Codice: String;
begin
  if selM150.FieldByName('CODICE').IsNull then
    Exit;
  Codice:=selM150.FieldByName('CODICE').AsString;
  if selM150.FieldByName('INDENNITA_KM').AsString = 'S' then
  begin
    // voce è indennita km -> decodifica da M021
    selM150.FieldByName('C_DESCRIZIONE').AsString:=VarToStr(selM021.Lookup('CODICE',Codice,'DESCRIZIONE'));
  end
  else if selM150.FieldByName('INDENNITA_KM').AsString = 'N' then
  begin
    // voce è un rimborso -> decodifica da M020
    if selM020Rimborsi.SearchRecord('CODICE',Codice,[srFromBeginning]) then
    begin
      selM150.FieldByName('C_DESCRIZIONE').AsString:=selM020Rimborsi.FieldByName('DESCRIZIONE').AsString;
      selM150.FieldByName('C_TIPO_QUANTITA').AsString:=selM020Rimborsi.FieldByName('TIPO_QUANTITA').AsString;
    end;
  end;
end;

procedure TW032FRichiestaMissioniDM.selM160ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  if Action in ['I','U','D'] then
  begin
    RegistraLog.SettaProprieta(ConvertActionToOperazione(Action),'M160_RICHIESTE_ANTICIPI','W032',Sender,True);
    //Aggiungo il progressivo del dipendente che non è presente nella tabella
    RegistraLog.InserisciDato('PROGRESSIVO',
                              IfThen(ConvertActionToOperazione(Action) = 'I','',selM140.FieldByName('PROGRESSIVO').AsString),
                              IfThen(ConvertActionToOperazione(Action) = 'I',selM140.FieldByName('PROGRESSIVO').AsString,'')
                             );
    RegistraLog.RegistraOperazione;
  end;
end;

procedure TW032FRichiestaMissioniDM.selM160CalcFields(DataSet: TDataSet);
var
  Codice: String;
begin
  Codice:=selM160.FieldByName('CODICE').AsString;
  if selM020Anticipi.SearchRecord('CODICE',Codice,[srFromBeginning]) then
  begin
    selM160.FieldByName('C_DESCRIZIONE').AsString:=selM020Anticipi.FieldByName('DESCRIZIONE').AsString;
    selM160.FieldByName('C_TIPO_QUANTITA').AsString:=selM020Anticipi.FieldByName('TIPO_QUANTITA').AsString;
    selM160.FieldByName('C_PERC_ANTICIPO').AsFloat:=selM020Anticipi.FieldByName('PERC_ANTICIPO').AsFloat;
    selM160.FieldByName('C_NOTE_FISSE').AsString:=selM020Anticipi.FieldByName('NOTE_FISSE').AsString;
  end;
end;

procedure TW032FRichiestaMissioniDM.selM170ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  if Action in ['I','U','D'] then
  begin
    RegistraLog.SettaProprieta(ConvertActionToOperazione(Action),'M170_RICHIESTE_MEZZI','W032',Sender,True);
    RegistraLog.InserisciDato('PROGRESSIVO',
                              IfThen(ConvertActionToOperazione(Action) = 'I','',selM140.FieldByName('PROGRESSIVO').AsString),
                              IfThen(ConvertActionToOperazione(Action) = 'I',selM140.FieldByName('PROGRESSIVO').AsString,'')
                             );
    RegistraLog.RegistraOperazione;
  end;
end;

procedure TW032FRichiestaMissioniDM.selM175ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  if Action in ['I','U','D'] then
  begin
    RegistraLog.SettaProprieta(ConvertActionToOperazione(Action),'M175_RICHIESTE_MOTIVAZIONI','W032',Sender,True);
    RegistraLog.InserisciDato('PROGRESSIVO',
                              IfThen(ConvertActionToOperazione(Action) = 'I','',selM140.FieldByName('PROGRESSIVO').AsString),
                              IfThen(ConvertActionToOperazione(Action) = 'I',selM140.FieldByName('PROGRESSIVO').AsString,'')
                             );
    RegistraLog.RegistraOperazione;
  end;
end;

function TW032FRichiestaMissioniDM.GetLocalita(const PTipo, PCodLocalita, PDescLocalita: String): TLocalita;
begin
  Result.Tipo:=PTipo;
  Result.CodLocalita:=PCodLocalita;
  Result.DescLocalita:=IfThen(PDescLocalita = '','<non indicata>',PDescLocalita);
end;

function TW032FRichiestaMissioniDM.GetDistanzaM041_2P(const PTipoA, PLocalitaA,
  PTipoB, PLocalitaB: String): Integer;
// restituisce il numero di km di distanza fra la località A e la località B
// in base a quanto definito sulla tabella M041
// NOTE
//   se le località coincidono, restituisce convenzionalmente 0
//   se la tratta [A - B] non è prevista, restituisce convenzionalmente -1
// gestisce l'indicazione o meno del tipo di località:
// - C = comune                   (decod. su T480_COMUNI)
// - P = località personalizzata  (decod. su M042_LOCALITA)
var
  Campi1,
  Campi2: String;
  Valori1,
  Valori2: Variant;
begin
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.ini
  // se le località coincidono restituisce convenzionalmente 0
  if GetLocalita(PTipoA,PLocalitaA,'') = GetLocalita(PTipoB,PLocalitaB,'') then
  begin
    Result:=0;
    Exit;
  end;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2.fine

  // se il dataset non è attivo lo apre
  if not selM041.Active then
  begin
    selM041.Close;
    selM041.Open;
  end;

  // se non è indicato il tipo non lo considera nella ricerca
  Campi1:=IfThen(PTipoA <> '','TIPO1;') + 'LOCALITA1;' + IfThen(PTipoB <> '','TIPO2;') + 'LOCALITA2';
  Campi2:=IfThen(PTipoB <> '','TIPO1;') + 'LOCALITA1;' + IfThen(PTipoA <> '','TIPO2;') + 'LOCALITA2';

  if (PTipoA <> '') and (PTipoB <> '') then
  begin
    Valori1:=VarArrayOf([PTipoA,PLocalitaA,PTipoB,PLocalitaB]);
    Valori2:=VarArrayOf([PTipoB,PLocalitaB,PTipoA,PLocalitaA]);
  end
  else if PTipoA <> '' then
  begin
    Valori1:=VarArrayOf([PTipoA,PLocalitaA,PLocalitaB]);
    Valori2:=VarArrayOf([PLocalitaB,PTipoA,PLocalitaA]);
  end
  else if PTipoB <> '' then
  begin
    Valori1:=VarArrayOf([PLocalitaA,PTipoB,PLocalitaB]);
    Valori2:=VarArrayOf([PTipoB,PLocalitaB,PLocalitaA]);
  end
  else
  begin
    Valori1:=VarArrayOf([PLocalitaA,PLocalitaB]);
    Valori2:=VarArrayOf([PLocalitaB,PLocalitaA]);
  end;

  // cerca distanza tra A e B (A -> B oppure l'equivalente B -> A)
  if selM041.SearchRecord(Campi1,Valori1,[srFromBeginning]) then
  begin
    // trovata distanza A - B
    Result:=selM041.FieldByName('CHILOMETRI').AsInteger;
  end
  else if selM041.SearchRecord(Campi2,Valori2,[srFromBeginning]) then
  begin
    // trovata distanza B - A
    Result:=selM041.FieldByName('CHILOMETRI').AsInteger;
  end
  else
  begin
    // distanza non trovata
    Result:=-1;
  end;
end;

function TW032FRichiestaMissioniDM.GetDistanzaM041_2P(const PLocalitaA, PLocalitaB: TLocalita): Integer;
// estrae il numero di km di distanza fra [A - B]
// in base a quanto definito sulla tabella M041
// NOTA
//   se la tratta non è prevista restituisce convenzionalmente -1
begin
  Result:=GetDistanzaM041_2P(PLocalitaA.Tipo,PLocalitaA.CodLocalita,
                             PLocalitaB.Tipo,PLocalitaB.CodLocalita);
end;

function TW032FRichiestaMissioniDM.GetDistanzaM041_3P(const PTipoA, PLocalitaA,
  PTipoB, PLocalitaB, PTipoC, PLocalitaC: String): Integer;
// estrae il numero di km di distanza fra [A - B] + [B - C]
// in base a quanto definito sulla tabella M041
// NOTA
//   se almeno una delle due tratte non è prevista,
//   restituisce convenzionalmente -1
var
  T1, T2: Integer;
begin
  Result:=-1;

  // calcola distanza tratta 1 [A - B]
  T1:=GetDistanzaM041_2P(PTipoA,PLocalitaA,PTipoB,PLocalitaB);
  if T1 < 0 then
    Exit;

  // calcola distanza tratta 2 [B - C]
  T2:=GetDistanzaM041_2P(PTipoB,PLocalitaB,PTipoC,PLocalitaC);
  if T2 < 0 then
    Exit;

  // risultato = tratta 1 + tratta 2
  Result:=T1 + T2;
end;

// CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.ini
// procedura per caricamento automatico dell'indennità km su M150
function TW032FRichiestaMissioniDM.CaricaRimborsoAutomatico(const PCodRegola: String; var RDebugMsg, RErrMsg: String): Boolean;
// rimosso per richiesta Nando.ini
{
var
  Riga: String;
  Stato: Integer;
}
// rimosso per richiesta Nando.fine
begin
  Result:=False;
  RDebugMsg:='';
  RErrMsg:='';

  if RimbAutomatico.Abilitato then
  begin
    RDebugMsg:='Caricamento indennità km automatica abilitato'#13#10;

    // esegue la procedure oracle M150P_INDKM_AUTO (personalizzabile) che effettua
    // il caricamento automatico del rimborso per l'indennità km indicata in RimbAutomatico.CodIndKM
    try
      with M150P_INDKM_AUTO do
      begin
        // rimosso per richiesta Nando.ini
        {
        if DebugHook <> 0 then
          Session.DBMS_Output.Enable(20000); // dimensione max buffer in byte
        }
        // rimosso per richiesta Nando.fine
        SetVariable('ID',selM140.FieldByName('ID').AsInteger);
        SetVariable('INDKM',RimbAutomatico.CodIndKM);
        SetVariable('CODREGOLA',PCodRegola);
        Execute;

        // rimosso per richiesta Nando.ini
        {
        // debug risultato procedure su dbms_output
        if DebugHook <> 0 then
        begin
          RDebugMsg:=RDebugMsg + #13#10'Output procedure oracle M150P_INDKM_AUTO:'#13#10;
          Session.DBMS_Output.Get_Line(Riga, Stato);
          while Stato = glSuccess do
          begin
            RDebugMsg:=RDebugMsg + CRLF + Riga;
            Session.DBMS_Output.Get_Line(Riga, Stato);
          end;
          Session.DBMS_Output.Disable;
        end;
        }
        // rimosso per richiesta Nando.fine
      end;
      Result:=True;
    except
      on E: Exception do
        RErrMsg:=Format('%s (%s)',[E.Message,E.ClassName]);
    end;
  end
  else
  begin
    RDebugMsg:='Caricamento indennità km automatica non attivato';
  end;
end;
// CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.fine

{TLocalita}

class operator TLocalita.Equal(ALeftOp, ARightOp: TLocalita): Boolean;
begin
  Result:=(ALeftOp.CodLocalita = ARightOp.CodLocalita) and
          ((ALeftOp.Tipo = '') or
           (ARightOp.Tipo = '') or
           (ALeftOp.Tipo = ARightOp.Tipo));
end;

class operator TLocalita.NotEqual(ALeftOp, ARightOp: TLocalita): Boolean;
begin
  Result:=(ALeftOp.CodLocalita <> ARightOp.CodLocalita) or
          ((ALeftOp.Tipo <> '') and
           (ARightOp.Tipo <> '') and
           (ALeftOp.Tipo <> ARightOp.Tipo));
end;

end.
