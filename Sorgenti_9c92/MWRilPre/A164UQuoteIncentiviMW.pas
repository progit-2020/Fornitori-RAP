unit A164UQuoteIncentiviMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, A000USessione,
  Data.DB, C180FunzioniGenerali, Oracle, Variants, A000UMessaggi, A000UInterfaccia;

type
   TAggGlobale = record
     sDecorrenza: String;
     sTipoQuota:String;
     TipoVariazione:Integer;
     sPercentuale: String;
     sImporto: String;
   end;

  TA164FQuoteIncentiviMW = class(TR005FDataModuleMW)
    selDato1: TOracleDataSet;
    selDato2: TOracleDataSet;
    selDato3: TOracleDataSet;
    selT765: TOracleDataSet;
    selT765CODICE: TStringField;
    selT765DESCRIZIONE: TStringField;
    selT765TIPOQUOTA: TStringField;
    selT265: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    selP030: TOracleDataSet;
    selP150: TOracleDataSet;
    selSQL: TOracleQuery;
    selT770A: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    FSelT770_Funzioni: TOracleDataset;
    procedure ImpostaDecorrenza(Query: TOracleDataSet; Decorrenza: TDateTime);
  public
    procedure selT770CalcFields;
    procedure SelT770AfterScroll;
    procedure ImpostaDecorrenzaDatasetLookup;
    function SelT770BeforePost: String;
    function getCaptionImporto: String;
    function getTipoQuotaByCod(Cod: String): String;
    function AggGlobaleStep1: boolean;
    function AggGlobaleStep2(AggGlobale: TAggGlobale): Boolean;
    function AggGlobaleStep3(AggGlobale: TAggGlobale): Boolean;
    function AggGlobaleStep4(AggGlobale: TAggGlobale): Boolean;
    function AggGlobaleStep5: Boolean;
    procedure CaricamentoDati(Query: TOracleDataSet; ParametriDato: String; Decorrenza: TDateTime);
    property selT770_Funzioni: TOracleDataset read FSelT770_Funzioni write FSelT770_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
procedure TA164FQuoteIncentiviMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT265.Open;
end;

procedure TA164FQuoteIncentiviMW.CaricamentoDati(Query: TOracleDataSet; ParametriDato:String; Decorrenza: TDateTime);
begin
  if A000LookupTabella(ParametriDato,Query) then
  begin
    ImpostaDecorrenza(Query,Decorrenza);
  end;
end;

procedure TA164FQuoteIncentiviMW.ImpostaDecorrenza(Query: TOracleDataSet; Decorrenza: TDateTime);
begin
  if Query.VariableIndex('DECORRENZA') >= 0 then
    Query.SetVariable('DECORRENZA',Decorrenza);
  Query.Close;
  Query.Open;
end;

procedure TA164FQuoteIncentiviMW.selT770CalcFields;
begin
  if R180OreMinutiExt(FselT770_Funzioni.FieldByName('NUM_ORE').AsString) = 0 then
    FselT770_Funzioni.FieldByName('TOTNETTO').AsFloat:=R180Arrotonda(
      FselT770_Funzioni.FieldByName('IMPORTO').AsFloat * FselT770_Funzioni.FieldByName('VALUT_STRUTTURALE').AsFloat / 100 ,0.00001,'P')
  else
    FselT770_Funzioni.FieldByName('TOTNETTO').AsFloat:=R180Arrotonda(
      FselT770_Funzioni.FieldByName('IMPORTO').AsFloat * R180OreMinutiExt(FselT770_Funzioni.FieldByName('NUM_ORE').AsString) / 60 *
      FselT770_Funzioni.FieldByName('VALUT_STRUTTURALE').AsFloat / 100 ,0.00001,'P');
end;

function TA164FQuoteIncentiviMW.getTipoQuotaByCod(Cod: String): String;
begin
  Result:='';
  if selT765.SearchRecord('CODICE',Cod,[srFromBeginning]) then
    Result:=selT765.FieldByName('TIPOQUOTA').AsString;
end;


function TA164FQuoteIncentiviMW.getCaptionImporto: String;
begin
  selP150.SetVariable('Decorrenza',FselT770_Funzioni.FieldByName('Decorrenza').AsDateTime);
  selP150.Close;
  selP150.Open;
  selP030.SetVariable('Cod_Valuta',selP150.FieldByName('COD_VALUTA_BASE').AsString);
  selP150.Close;
  selP030.SetVariable('Decorrenza',FselT770_Funzioni.FieldByName('Decorrenza').AsDateTime);
  selP030.Close;
  selP030.Open;

  Result:='Importo (' + selP030.FieldByName('ABBREVIAZIONE').AsString + ')';
  selP030.Close;
end;

procedure TA164FQuoteIncentiviMW.SelT770AfterScroll;
begin
  //Caratto 13/11/2014 carico dati storici alla data del record corrente
  if not FSelT770_Funzioni.Eof then //refreshrecord resetterebbe EOF e i cicli vanno in loop
  begin
    ImpostaDecorrenzaDatasetLookup;
    FSelT770_Funzioni.RefreshRecord;
  end;
end;

procedure TA164FQuoteIncentiviMW.ImpostaDecorrenzaDatasetLookup;
begin
  //Caratto 13/11/2014 carico dati storici alla data del record corrente
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
    ImpostaDecorrenza(selDato1,FSelT770_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    ImpostaDecorrenza(selDato2,FSelT770_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    ImpostaDecorrenza(selDato3,FSelT770_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  selT765.SetVariable('DECORRENZA',FSelT770_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  selT765.Close;
  selT765.Open;
end;

function TA164FQuoteIncentiviMW.SelT770BeforePost: String;
begin
  Result:='';
  if Trim(FselT770_Funzioni.FieldByName('DATO1').AsString) <> '' then
  begin
    selSQL.SQL.Clear;
    selSQL.SQL.Add('SELECT COUNT(*) FROM T760_REGOLEINCENTIVI T760');
    selSQL.SQL.Add('WHERE T760.LIVELLO = ''' + FselT770_funzioni.FieldByName('DATO1').AsString + '''');
    selSQL.SQL.Add('  AND T760.DECORRENZA = (SELECT MAX(DECORRENZA) FROM T760_REGOLEINCENTIVI');
    selSQL.SQL.Add('                          WHERE LIVELLO = T760.LIVELLO');
    selSQL.SQL.Add('                            AND DECORRENZA <= TO_DATE(''' + FselT770_funzioni.FieldByName('DECORRENZA').AsString + ''',''DD/MM/YYYY''))');
    selSQL.Execute;
    if StrToIntDef(VarToStr(selSQL.Field(0)),0) = 0 then
      raise exception.Create(Format(A000MSG_A164_ERR_FMT_REGOLE_DATO,[Parametri.CampiRiferimento.C7_Dato1]));
  end;

  if FselT770_funzioni.FieldByName('PERC_INDIVIDUALE').AsFloat + FselT770_funzioni.FieldByName('PERC_STRUTTURALE').AsFloat <> 100 then
    raise exception.Create(A000MSG_A164_ERR_PCT_INCIDENZA);

   if (Trim(FselT770_funzioni.FieldByName('CODTIPOQUOTA').AsString) = '') and
      (Trim(FselT770_funzioni.FieldByName('CAUSALE').AsString) = '') then
    raise exception.Create(A000MSG_A164_ERR_QUOTA_O_CAUS);
  if FselT770_funzioni.FieldByName('DATO1').AsString = '' then
    FselT770_funzioni.FieldByName('DATO1').AsString:=' ';
  if FselT770_funzioni.FieldByName('DATO2').AsString = '' then
    FselT770_funzioni.FieldByName('DATO2').AsString:=' ';
  if FselT770_funzioni.FieldByName('DATO3').AsString = '' then
    FselT770_funzioni.FieldByName('DATO3').AsString:=' ';

  if (FselT770_funzioni.FieldByName('CODTIPOQUOTA').AsString = '') and (FselT770_funzioni.FieldByName('CAUSALE').AsString <> '') then
    FselT770_funzioni.FieldByName('CODTIPOQUOTA').AsString:=' ';
  if (FselT770_funzioni.FieldByName('CODTIPOQUOTA').AsString <> '') and (FselT770_funzioni.FieldByName('CAUSALE').AsString = '') then
    FselT770_funzioni.FieldByName('CAUSALE').AsString:=' ';
  FselT770_funzioni.FieldByName('IMPORTO').AsFloat:=R180Arrotonda(FselT770_funzioni.FieldByName('IMPORTO').AsFloat,0.00001,'P');
  if Trim(FselT770_funzioni.FieldByName('TIPO_STAMPAQUANT').AsString) = '' then
    FselT770_funzioni.FieldByName('TIPO_STAMPAQUANT').AsString:='0';

  if FselT770_funzioni.FieldByName('DECORRENZA').AsDateTime <> R180InizioMese(FselT770_funzioni.FieldByName('DECORRENZA').AsDateTime) then
    Result:=A000MSG_A164_MSG_DECORRENZA_INIZIO_MESE;
  FselT770_funzioni.FieldByName('DECORRENZA').AsDateTime:=R180InizioMese(FselT770_funzioni.FieldByName('DECORRENZA').AsDateTime);
end;

function TA164FQuoteIncentiviMW.AggGlobaleStep1: Boolean;
begin
  RegistraMsg.IniziaMessaggio(NomeOwner);
  Result:=True;
  selSQL.SQL.Clear;  //Faccio un salvataggio della tabella
  selSQL.SQL.Add('DROP TABLE BCK_T770_AGGMASSIVO');
  try
    selSQL.Execute;
  except
  end;
  selSQL.SQL.Clear;
  selSQL.SQL.Add('CREATE TABLE BCK_T770_AGGMASSIVO AS');
  selSQL.SQL.Add('SELECT * FROM T770_QUOTE');
  try
    selSQL.Execute;
  except
    on E:exception do
    begin
      RegistraMsg.InserisciMessaggio('A','Salvataggio tabella esistente fallito: ' + E.Message);
      Result:=False;
    end;
  end;
end;

function TA164FQuoteIncentiviMW.AggGlobaleStep2(AggGlobale:TAggGlobale): Boolean;
begin
  Result:=True;
  selSQL.SQL.Clear;  //Creo le decorrenze non esistenti
  selSQL.SQL.Add('INSERT INTO T770_QUOTE (DATO1,DATO2,DATO3,CODTIPOQUOTA,CAUSALE,DECORRENZA,DECORRENZA_FINE)');
  selSQL.SQL.Add('SELECT DISTINCT DATO1,DATO2,DATO3,CODTIPOQUOTA,CAUSALE,');
  selSQL.SQL.Add('       TO_DATE(''' + AggGlobale.sDecorrenza + ''',''DD/MM/YYYY'') , TO_DATE(''31/12/3999'',''DD/MM/YYYY'')');
  selSQL.SQL.Add('  FROM T770_QUOTE T770');
  selSQL.SQL.Add(' WHERE CODTIPOQUOTA = ''' + AggGlobale.sTipoQuota + '''');
  selSQL.SQL.Add('   AND NOT EXISTS ');
  selSQL.SQL.Add(' (SELECT ''X'' FROM T770_QUOTE ');
  selSQL.SQL.Add('   WHERE DATO1 = T770.DATO1 AND DATO2 = T770.DATO2 AND DATO3 = T770.DATO3 ');
  selSQL.SQL.Add('     AND CODTIPOQUOTA = T770.CODTIPOQUOTA AND CAUSALE = T770.CAUSALE ');
  selSQL.SQL.Add('     AND DECORRENZA = TO_DATE(''' + AggGlobale.sDecorrenza + ''',''DD/MM/YYYY''))');
  try
    selSQL.Execute;
  except
    on E:exception do
    begin
      RegistraMsg.InserisciMessaggio('A','Creazione decorrenze ' + AggGlobale.sDecorrenza + ' fallita: ' + E.Message);
      Result:=False;
    end;
  end;
end;

function TA164FQuoteIncentiviMW.AggGlobaleStep3(AggGlobale: TAggGlobale): Boolean;
begin
  Result:=True;
  SessioneOracle.Commit;
  selSQL.SQL.Clear;  //Aggiorno gli importi delle nuove decorrenze
  selSQL.SQL.Add('UPDATE T770_QUOTE T770 SET IMPORTO = ');
  selSQL.SQL.Add(' (SELECT IMPORTO FROM T770_QUOTE');
  selSQL.SQL.Add('   WHERE DATO1 = T770.DATO1');
  selSQL.SQL.Add('     AND DATO2 = T770.DATO2');
  selSQL.SQL.Add('     AND DATO3 = T770.DATO3');
  selSQL.SQL.Add('     AND CODTIPOQUOTA = T770.CODTIPOQUOTA');
  selSQL.SQL.Add('     AND CAUSALE = T770.CAUSALE');
  selSQL.SQL.Add('     AND DECORRENZA = (SELECT MAX(DECORRENZA) FROM T770_QUOTE');
  selSQL.SQL.Add('                        WHERE DATO1 = T770.DATO1');
  selSQL.SQL.Add('                          AND DATO2 = T770.DATO2');
  selSQL.SQL.Add('                          AND DATO3 = T770.DATO3');
  selSQL.SQL.Add('                          AND CODTIPOQUOTA = T770.CODTIPOQUOTA');
  selSQL.SQL.Add('                          AND CAUSALE = T770.CAUSALE');
  selSQL.SQL.Add('                          AND DECORRENZA < TO_DATE(''' + AggGlobale.sDecorrenza + ''',''DD/MM/YYYY'')))');
  selSQL.SQL.Add(' WHERE IMPORTO IS NULL');
  selSQL.SQL.Add('   AND CODTIPOQUOTA = ''' + AggGlobale.sTipoQuota + '''');
  selSQL.SQL.Add('   AND DECORRENZA = TO_DATE(''' + AggGlobale.sDecorrenza + ''',''DD/MM/YYYY'')');
  try
    selSQL.Execute;
  except
    on E:exception do
    begin
      RegistraMsg.InserisciMessaggio('A','Aggiornamento decorrenze ' + AggGlobale.sDecorrenza + ' fallita: ' + E.Message);
      Result:=False;
    end;
  end;
end;

function TA164FQuoteIncentiviMW.AggGlobaleStep4(AggGlobale: TAggGlobale): Boolean;
begin
  Result:=True;
  SessioneOracle.Commit;
  selSQL.SQL.Clear;  //Aggiorno le decorrenze >= con i nuovi importi
  selSQL.SQL.Add('UPDATE T770_QUOTE SET IMPORTO = ');
  if AggGlobale.TipoVariazione = 0 then
    selSQL.SQL.Add('NVL(IMPORTO,0) + ROUND(')
  else
    selSQL.SQL.Add('NVL(IMPORTO,0) - ROUND(');
  if AggGlobale.sPercentuale <> '' then
    selSQL.SQL.Add('(NVL(IMPORTO,0) * ' + StringReplace(AggGlobale.sPercentuale,',','.',[rfReplaceAll]) + ' / 100),2)')
  else
    selSQL.SQL.Add(StringReplace(AggGlobale.sImporto,',','.',[rfReplaceAll]) + ',2)');
  selSQL.SQL.Add(' WHERE CODTIPOQUOTA = ''' + AggGlobale.sTipoQuota + '''');
  selSQL.SQL.Add('   AND DECORRENZA >= TO_DATE(''' + AggGlobale.sDecorrenza + ''',''DD/MM/YYYY'')');
  try
    selSQL.Execute;
  except
    on E:exception do
    begin
      RegistraMsg.InserisciMessaggio('A','Aggiornamento importi fallita: ' + E.Message);
      Result:=False;
    end;
  end;
end;

function TA164FQuoteIncentiviMW.AggGlobaleStep5: Boolean;
begin
  Result:=true;
  SessioneOracle.Commit;
  selT770A.Close;
  selT770A.Open;
  while not selT770A.Eof do
  begin
    selSQL.SQL.Clear;  //Aggiorno-Allineo le decorrenze fine
    selSQL.SQL.Add('UPDATE T770_QUOTE');
    selSQL.SQL.Add('   SET DECORRENZA_FINE = TO_DATE(''' + selT770A.FieldByName('SCADENZA').AsString + ''',''DD/MM/YYYY'')');
    selSQL.SQL.Add(' WHERE DATO1 = ''' + selT770A.FieldByName('DATO1').AsString + '''');
    selSQL.SQL.Add('   AND DATO2 = ''' + selT770A.FieldByName('DATO2').AsString + '''');
    selSQL.SQL.Add('   AND DATO3 = ''' + selT770A.FieldByName('DATO3').AsString + '''');
    selSQL.SQL.Add('   AND CODTIPOQUOTA = ''' + selT770A.FieldByName('CODTIPOQUOTA').AsString + '''');
    selSQL.SQL.Add('   AND CAUSALE = ''' + selT770A.FieldByName('CAUSALE').AsString + '''');
    selSQL.SQL.Add('   AND DECORRENZA = TO_DATE(''' + selT770A.FieldByName('DECORRENZA').AsString + ''',''DD/MM/YYYY'')');
    try
      selSQL.Execute;
      SessioneOracle.Commit;
    except
      on E:exception do
      begin
        RegistraMsg.InserisciMessaggio('A','Allineamento scadenze fallita: ' + E.Message);
        Result:=False;
        Break;
      end;
    end;
    selT770A.Next;
  end;
end;
end.
