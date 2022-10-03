unit B021UAnaOpeFSEDM;

interface

uses
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} A000UCostanti, A000USessione, C180FunzioniGenerali,
  C200UWebServicesTypes, B021UUtils, System.SysUtils, System.Classes,
  R014URestDM, Oracle, Data.DB, OracleData,
  Variants, Winapi.Windows, System.DateUtils;

type
  TB021FAnaOpeFSEDM = class(TR014FRestDM)
    selIA110: TOracleDataSet;
    selAnag: TOracleDataSet;
  private
    // parametri per elaborazione
    FTipo: String;
    FTime: String;
    FAuth: String;
    FDataInizio: TDateTime;
    FDataFine: TDateTime;
    // altri dati
    StrutturaB014: String;
    Tabella: String;
    ElencoCampi: String;
    procedure LeggiStrutturaB014;
    function GetAnagrafiche: TJSONObject;
//    function B021DateToStr(const PData: TDateTime): String; inline;
    function B021TryStrToDate(const PDataStr: String; var RData: TDateTime): Boolean; inline;
  protected
    function ControlloParametri(var RErrMsg: String): Boolean; override;
    function ControlloAutenticazione(var RErrAuth: String): TInfoAutenticazione; override;
  public
    function GetDato: TJSONObject; override;
  end;

const
  // indica se il servizio richiede o meno l'autenticazione via token + time
  AUTENTICAZIONE_RICHIESTA  = False;

  // nomi dei parametri utilizzati
  PAR_TIME                  = 'time';
  PAR_AUTH                  = 'auth';
  PAR_TIPO                  = 'tipo';
  PAR_DATA_INIZIO           = 'inizio';
  PAR_DATA_FINE             = 'fine';

  // il valore del parametro Tipo determina anche la struttura B014 di riferimento
  TIPO_WS_ATTIVI            = 'WS_ATTIVI';        // elenco del personale attivo
  TIPO_WS_VARIATO           = 'WS_VARIATO';       // elenco del personale interessato da variazioni nella giornata
  TIPO_WS_RANGE_VARIAZ      = 'WS_RANGE_VARIAZ';  // elenco del personale interessato da variazioni nel periodo inizio - fine indicato

implementation

{$R *.dfm}

// metodi interni

//function TB021FAnaOpeFSEDM.B021DateToStr(const PData: TDateTime): String;
//// formato data: yyyymmdd
//begin
//  Result:=DateToStr(PData,TB021FUtils.CreateFormatSettingsAostaAsl);
//end;

function TB021FAnaOpeFSEDM.B021TryStrToDate(const PDataStr: String; var RData: TDateTime): Boolean;
// formato data: yyyymmdd
var
  LAnnoStr,LMeseStr,LGiornoStr: String;
  LAnnoInt,LMeseInt,LGiornoInt: Integer;
begin
  //Result:=False;

  LAnnoStr:=PDataStr.Substring(0,4);
  LMeseStr:=PDataStr.Substring(4,2);
  LGiornoStr:=PDataStr.Substring(6,2);

  Result:=TryStrToInt(LAnnoStr,LAnnoInt) and
          TryStrToInt(LMeseStr,LMeseInt) and
          TryStrToInt(LGiornoStr,LGiornoInt) and
          TryEncodeDate(LAnnoInt,LMeseInt,LGiornoInt,RData);
end;

procedure TB021FAnaOpeFSEDM.LeggiStrutturaB014;
// legge le informazioni della struttura B014
// e valorizza queste variabili:
// - Tabella:     nome tabella / vista di riferimento da cui leggere i record
// - ElencoCampi: elenco dei campi da estrarre da Tabella
var
  Intestazione, T, Campo, NomeDato, CampoFmt: String;
const
  NOME_PROC = 'LeggiStrutturaB014';
begin
  Log(NOME_PROC,Format('Struttura %s: inizio lettura',[StrutturaB014]));

  // lettura struttura anagrafica
  selIA110.Close;
  selIA110.SetVariable('AZIENDA',TSessioneIrisWIN(Self.Owner).Parametri.Azienda);
  selIA110.SetVariable('NOME_STRUTTURA',StrutturaB014);
  Log(NOME_PROC,Format('apertura dataset per azienda [%s], struttura [%s]',[TSessioneIrisWIN(Self.Owner).Parametri.Azienda,StrutturaB014]));
  try
    selIA110.Open;
  except
    on E: Exception do
    begin
      Log(NOME_PROC,Format('struttura [%s] definita in modo errato: %s',[StrutturaB014,E.Message]));
      raise EB021InvalidStructure.CreateFmt('Struttura [%s]: errore nell''impostazione: %s',[StrutturaB014,E.Message]);
    end;
  end;
  // se non ci sono record la struttura non è presente
  if selIA110.RecordCount = 0 then
  begin
    Log(NOME_PROC,Format('struttura [%s] non presente',[StrutturaB014]));
    raise EB021InvalidStructure.CreateFmt('Struttura [%s]: inesistente',[StrutturaB014]);
  end;
  Log(NOME_PROC,Format('la struttura contiene %d record',[selIA110.RecordCount]));
  while not selIA110.Eof do
  begin
    Intestazione:=selIA110.FieldByName('INTESTAZIONE').AsString;
    NomeDato:=selIA110.FieldByName('NOME_DATO').AsString;
    T:=selIA110.FieldByName('TABELLA').AsString;
    if Tabella = '' then
      Tabella:=T
    else if T <> Tabella then
      raise EB021InvalidStructure.CreateFmt('Struttura [%s]: previsto l''utilizzo di una singola tabella / vista di riferimento',[StrutturaB014]);

    // nome del campo
    Campo:=selIA110.FieldByName('CAMPO').AsString;

    // i campi con posizione non indicata vengono esclusi
    if not selIA110.FieldByName('POS_DATO').IsNull then
    begin
      // formattazione del campo data
      if (selIA110.FieldByName('TIPO_DATO').AsString = 'D') and
         (not selIA110.FieldByName('FMT_DATA').IsNull) then
        CampoFmt:=Format('to_char(%s,''%s'') %s',[Campo,selIA110.FieldByName('FMT_DATA').AsString,Campo])
      else
        CampoFmt:=Campo;

      // elenco dei campi da selezionare
      ElencoCampi:=ElencoCampi + CampoFmt + ',';
    end;
    selIA110.Next;
  end;

  if ElencoCampi <> '' then
    ElencoCampi:=ElencoCampi.SubString(0,ElencoCampi.Length - 1);
  Log(NOME_PROC,Format('Struttura %s: fine lettura',[StrutturaB014]));
end;

function TB021FAnaOpeFSEDM.GetAnagrafiche: TJSONObject;
// estrae l'elenco delle anagrafiche da restituire in un oggetto json
var
  i:Integer;
  LAlias, LTipoDato, LNumAnagStr: String;
  LField: TField;
  ResArr: TJSONArray;
  Element: TJSONObject;
const
  NOME_PROC = 'GetAnagrafiche';
begin
  Log(NOME_PROC,Format('estrazione dati anagrafici',[]));

  // dati della vista anagrafica di riferimento
  if ElencoCampi = '' then
  begin
    Log(NOME_PROC,Format('struttura [%s] priva di dati',[StrutturaB014]));
    raise EB021InvalidStructure.CreateFmt('Struttura [%s]: nessun dato da estrarre',[StrutturaB014]);
  end
  else
  begin
    Log(NOME_PROC,Format('tabella/vista di riferimento: %s',[Tabella]));
    Log(NOME_PROC,Format('elenco campi estratti: %s',[ElencoCampi]));

    ResArr:=TJSONArray.Create;

    // prepara il testo SQL per l'estrazione delle anagrafiche
    selAnag.DeleteVariables;
    selAnag.Close;
    selAnag.SQL.Text:=Format('select %s'#13#10 +
                             'from   %s',
                             [ElencoCampi,Tabella]);
    // la tipologia WS_RANGE_VARIAZ richiede un filtro specifico
    if FTipo = TIPO_WS_RANGE_VARIAZ then
    begin
      selAnag.SQL.Add('where PROGRESSIVO in ( ');
      selAnag.SQL.Add('  select PROGRESSIVO ');
      selAnag.SQL.Add('  from   USR_ANAOPE_FSE_MODIFICATE ');
      selAnag.SQL.Add('  where  DATA_MODIF between :DATA_INIZIO and :DATA_FINE ');
      selAnag.SQL.Add(') ');
      selAnag.DeclareAndSet('DATA_INIZIO',otDate,FDataInizio);
      selAnag.DeclareAndSet('DATA_FINE',otDate,FDataFine);
    end;

    // esegue query
    try
      selAnag.Open;
      Log(NOME_PROC,Format('%d anagrafiche estratte',[selAnag.RecordCount]));
      while not selAnag.Eof do
      begin
        LNumAnagStr:=Format('anagrafica %.4d/%.4d',[selAnag.RecNo,selAnag.RecordCount]);
        Log(NOME_PROC,Format('  %s: inizio',[LNumAnagStr]));
        Element:=TJSONObject.Create;

        // dati anagrafici
        for i:=0 to selAnag.FieldCount - 1 do
        begin
          LField:=selAnag.Fields[i];
          LAlias:=VarToStr(selIA110.Lookup('CAMPO',LField.FieldName,'NOME_DATO'));
          LTipoDato:=VarToStr(selIA110.Lookup('CAMPO',LField.FieldName,'TIPO_DATO'));

          Log(NOME_PROC,Format('    gestione campo %.2d/%.2d [%s] di tipo [%s]',[i + 1,selAnag.FieldCount,LAlias,LTipoDato]));
          try
            if LTipoDato = B014_TIPO_DATO_ALFANUMERICO then
              Element.AddPair(LAlias,TJsonString.Create(LField.AsString))
            else if LTipoDato = B014_TIPO_DATO_NUMERICO then
              Element.AddPair(LAlias,TJSONNumber.Create(LField.AsFloat))
            else if LTipoDato = B014_TIPO_DATO_DATA then
            begin
              // già formattato dalla select principale
              Element.AddPair(LAlias,TJSONString.Create(LField.AsString));
            end;
          except
            on E: Exception do
            begin
              Log(NOME_PROC,Format('    errore nell''esportazione del valore del campo: %s',[E.Message]));
              raise EB021InvalidStructure.CreateFmt('Struttura [%s]: problema di conversione sul campo [%s] tipo [%s]: %s',[StrutturaB014,LAlias,LTipoDato,E.Message]);
            end;
          end;
        end;

        ResArr.Add(Element);
        Log(NOME_PROC,Format('  %s: fine',[LNumAnagStr]));
        selAnag.Next;
      end;
      selAnag.Close;
      Result:=TJSONObject.Create(TJSONPair.Create('anagrafiche',ResArr));
    except
      on E: Exception do
      begin
        Log(NOME_PROC,Format('struttura [%s] errata: %s',[StrutturaB014,E.Message]));
        raise EB021InvalidStructure.CreateFmt('Struttura [%s]: errore nella definizione: %s',[StrutturaB014,E.Message]);
      end;
    end;
  end;
  selIA110.Close;
end;

function TB021FAnaOpeFSEDM.ControlloParametri(var RErrMsg: String): Boolean;
var
  LDataInizioStr: String;
  LDataFineStr: String;
  LParTimeInt64: Int64;
const
  NOME_PROC = 'ControlloParametri';
begin
  RErrMsg:='';
  Result:=False;

  // 1. se richiesto controlla i parametri per l'autenticazione (time e token sha1)
  if AUTENTICAZIONE_RICHIESTA then
  begin
    // a. time in formato unix time GMT
    FTime:=GetParam(PAR_TIME);
    Log(NOME_PROC,Format('Parametro [%s] = [%s]',[PAR_TIME,FTime]));
    if FTime.Trim = '' then
    begin
      RErrMsg:=Format('Parametro [%s] non indicato!',[PAR_TIME]);
      Exit;
    end;
    if not TryStrToInt64(FTime,LParTimeInt64) then
    begin
      RErrMsg:=Format('Parametro [%s] non valido!',[PAR_TIME]);
      Exit;
    end;

    // b. token sha1 basato sul time ricevuto + password condivisa
    FAuth:=GetParam(PAR_AUTH);
    Log(NOME_PROC,Format('Parametro [%s] = [%s]',[PAR_AUTH,FAuth]));
    if FAuth.Trim = '' then
      raise EC200AuthError.Create('Token di autenticazione non indicato!');
  end;

  // 2. tipo della richiesta
  FTipo:=GetParam(PAR_TIPO);
  Log(NOME_PROC,Format('Parametro [%s] = [%s]',[PAR_TIPO,FTipo]));

  if FTipo.Trim = '' then
  begin
    RErrMsg:=Format('Parametro [%s] non indicato',[PAR_TIPO]);
    Exit;
  end;

  if not R180In(FTipo,[TIPO_WS_ATTIVI,TIPO_WS_VARIATO,TIPO_WS_RANGE_VARIAZ]) then
  begin
    RErrMsg:=Format('Parametro [%s] non valido',[PAR_TIPO]);
    Exit;
  end;

  // il nome della struttura utilizzata è il valore del parametro FTipo
  StrutturaB014:=FTipo;
  Log(NOME_PROC,Format('--> sarà utilizzata la struttura [%s], corrispondente al parametro %s',[StrutturaB014,PAR_TIPO]));

  // per le variazioni controlla i parametri data inizio e data fine
  if FTipo = TIPO_WS_RANGE_VARIAZ then
  begin
    // data inizio
    LDataInizioStr:=GetParam(PAR_DATA_INIZIO);
    Log(NOME_PROC,Format('Parametro [%s] = [%s]',[PAR_DATA_INIZIO,LDataInizioStr]));
    if LDataInizioStr.Trim = '' then
    begin
      RErrMsg:=Format('Parametro [%s] non indicato',[PAR_DATA_INIZIO]);
      Exit;
    end;
    if not B021TryStrToDate(LDataInizioStr,FDataInizio) then
    begin
      RErrMsg:=Format('Parametro [%s] non valido',[PAR_DATA_INIZIO]);
      Exit;
    end;

    // data fine
    LDataFineStr:=GetParam(PAR_DATA_FINE);
    Log(NOME_PROC,Format('Parametro [%s] = [%s]',[PAR_DATA_FINE,LDataFineStr]));
    if LDataFineStr.Trim = '' then
    begin
      RErrMsg:=Format('Parametro [%s] non indicato',[PAR_DATA_FINE]);
      Exit;
    end;
    if not B021TryStrToDate(LDataFineStr,FDataFine) then
    begin
      RErrMsg:=Format('Parametro [%s] non valido',[PAR_DATA_FINE]);
      Exit;
    end;

    // controllo periodo
    if not R180ControllaPeriodo(FDataInizio,FDataFine,RErrMsg) then
    begin
      RErrMsg:=Format('Parametri [%s] e [%s] non coerenti: %s',[PAR_DATA_INIZIO,PAR_DATA_FINE,RErrMsg]);
      Exit;
    end;
  end;

  Result:=True;
end;

function TB021FAnaOpeFSEDM.ControlloAutenticazione(var RErrAuth: String): TInfoAutenticazione;
var
  LTimeInt64: Int64;
const
  NOME_PROC = 'ControlloAutenticazione';
begin
  Result:=nil;
  RErrAuth:='';

  // controlla i dati di autenticazione (time e token sha1)
  // solo se necessario
  if not AUTENTICAZIONE_RICHIESTA then
    Exit;

  // crea oggetto con dati di autenticazione
  Result:=TInfoAutenticazione.Create;;

  // PRE: i parametri FTime e FAuth sono impostati e formalmente corretti

  // controlla scadenza token
  LTimeInt64:=StrToInt64(FTime);
  if not IsTimeOkAostaAsl(LTimeInt64) then
  begin
    RErrAuth:='Token di autenticazione scaduto!';
    Log(NOME_PROC,Format('token di autenticazione scaduto',[]));
    Exit;
  end;

  // verifica token
  if FAuth <> GetHashAutenticazioneAostaAsl(LTimeInt64) then
  begin
    RErrAuth:='Token di autenticazione non valido!';
    Log(NOME_PROC,Format('token di autenticazione non valido',[]));
    Exit;
  end;

  // imposta i dati di autenticazione ok (utente e ruolo non sono definiti in questo contesto)
  Result.Autenticato:=True;
  Result.Utente:='';
  Result.Ruolo:='';
end;

// metodi esposti

function TB021FAnaOpeFSEDM.GetDato: TJSONObject;
begin
  LeggiStrutturaB014;
  Result:=GetAnagrafiche;
end;

end.
