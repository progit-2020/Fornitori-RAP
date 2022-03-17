unit B021UMancopPersMMDM;

interface

uses
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} A000UCostanti, A000USessione, C180FunzioniGenerali,
  C200UWebServicesTypes, B021UUtils, System.SysUtils, System.Classes,
  R014URestDM, Oracle, Data.DB, OracleData;

type
  TB021FMancopPersMMDM = class(TR014FRestDM)
    selMancopPersMM: TOracleDataSet;
    scrUSR_MCP_PERSMM: TOracleQuery;
  private
    FMese: TDateTime;
    FUtente: String;
    FPassword: String;
    function B021DateToStr(const PData: TDateTime): String; inline;
    function B021DateTimeToStr(const PData: TDateTime): String; inline;
    function B021TryStrToDate(const PDataStr: String; var RData: TDateTime): Boolean; inline;
    function GetDatiPersonale: TJSONObject;
  protected
    function ControlloParametri(var RErrMsg: String): Boolean; override;
    function ControlloAutenticazione(var RErrAuth: String): TInfoAutenticazione; override;
    function GetResultOnError(PException: Exception): TJSONObject; override;
  public
    function GetDato: TJSONObject; override;
  end;

const
  // esito richiamo
  ESITO_OK                 = 'OK';                // metodo eseguito correttamente
  ESITO_AUTH_ERR           = 'AUTH-ERR';          // errore di autenticazione
  ESITO_DATA_ERR           = 'DATA-ERR';          // impossibile estrarre i dati richiesti

  // nomi dei parametri utilizzati
  PAR_MESE                 = 'mese';
  PAR_UTENTE               = 'utente';
  PAR_PASSWORD             = 'password';
  MAX_LEN_UTENTE           = 11;
  MAX_LEN_PASSWORD         = 15;

  UTENTE                   = 'MANCOP';
  PASSWORD                 = 'MEDP';

implementation

{$R *.dfm}

// metodi interni

function TB021FMancopPersMMDM.B021DateToStr(const PData: TDateTime): String;
begin
  Result:=DateToStr(PData,CreateFormatSettingsMonzaHSGerardo);
end;

function TB021FMancopPersMMDM.B021DateTimeToStr(const PData: TDateTime): String;
begin
  Result:=DateTimeToStr(PData,CreateFormatSettingsMonzaHSGerardo);
end;

function TB021FMancopPersMMDM.B021TryStrToDate(const PDataStr: String; var RData: TDateTime): Boolean;
begin
  Result:=TryStrToDate(PDataStr,RData,CreateFormatSettingsMonzaHSGerardo);
end;

function TB021FMancopPersMMDM.GetDatiPersonale: TJSONObject;
// servizio mensile
var
  ResArr: TJSONArray;
  LElement: TJSONObject;
  LEsitoStr: TJSONString;
  LTimestampPair: TJSONPair;
  LMesePair: TJSONPair;
const
  NOME_PROC = 'GetDatiPersonale';
begin
  Result:=TJSONObject.Create;

  // info generiche
  LTimestampPair:=TJSONPair.Create('timestamp',TJSONString.Create(B021DateTimeToStr(Now)));
  LMesePair:=TJSONPair.Create('mese',TJSONString.Create(B021DateToStr(FMese)));

  // array dei dipendenti
  ResArr:=TJSONArray.Create;

  if DatiAuth.Autenticato then
  begin
    // ciclo sui record presenti nella tabella di riferimento
    selMancopPersMM.Close;
    // apertura dataset protetta per verificare eventuali errori
    try
      // LMese...
      //Procedura per popolare la tabella di riferimento
      scrUSR_MCP_PERSMM.SetVariable('DATA',FMese);
      scrUSR_MCP_PERSMM.Execute;
      //lettura dati aggiornati a FMese
      selMancopPersMM.SetVariable('DATA',FMese);
      selMancopPersMM.Open;
      Log(NOME_PROC,Format('%d anagrafiche estratte',[selMancopPersMM.RecordCount]));
      if selMancopPersMM.RecordCount = 0 then
        raise Exception.Create('nessun dato disponibile');
      while not selMancopPersMM.Eof do
      begin
        // elemento con i dati delle malattie
        LElement:=TJSONObject.Create;
        LElement.AddPair('matricola',TJSONString.Create(selMancopPersMM.FieldByName('MATRICOLA').AsString));
        if selMancopPersMM.FieldByName('INIZIO').IsNull then
          LElement.AddPair('inizio',TJSONNull.Create)
        else
          LElement.AddPair('inizio',TJSONString.Create(B021DateToStr(selMancopPersMM.FieldByName('INIZIO').AsDateTime)));
        LElement.AddPair('reparto',TJSONString.Create(selMancopPersMM.FieldByName('REPARTO').AsString));
        LElement.AddPair('ggmala',TJSONNumber.Create((selMancopPersMM.FieldByName('GGMALA').AsInteger)));
        LElement.AddPair('tipologia',TJSONString.Create(selMancopPersMM.FieldByName('TIPOLOGIA').AsString));

        ResArr.AddElement(LElement);
        selMancopPersMM.Next;
      end;
      // esito ok
      LEsitoStr:=TJSONString.Create(ESITO_OK);
    except
      on E: Exception do
      begin
        Log(NOME_PROC,Format('  errore durante l''estrazione dei dati anagrafici: %s',[E.Message]));
        LEsitoStr:=TJSONString.Create(ESITO_DATA_ERR);
      end;
    end;
    selMancopPersMM.Close;
  end
  else
  begin
    // errore di autenticazione
    LEsitoStr:=TJSONString.Create(ESITO_AUTH_ERR);
  end;

  // crea il risultato
  Result.AddPair(LTimestampPair);
  Result.AddPair('esito',LEsitoStr);
  Result.AddPair(LMesePair);
  Result.AddPair('mancop_persmm',ResArr);
end;

// metodi ridefiniti

function TB021FMancopPersMMDM.ControlloParametri(var RErrMsg: String): Boolean;
var
  LMeseStr: String;
const
  NOME_PROC = 'ControlloParametri';
begin
  RErrMsg:='';
  Result:=False;

  // 1. data di riferimento
  LMeseStr:=GetParam(PAR_MESE);
  Log(NOME_PROC,Format('Parametro [%s] = [%s]',[PAR_MESE,LMeseStr]));

  if LMeseStr.Trim = '' then
  begin
    RErrMsg:=Format('Parametro [%s] non indicato',[PAR_MESE]);
    Exit;
  end;

  if not B021TryStrToDate(LMeseStr,FMese) then
  begin
    RErrMsg:=Format('Parametro [%s] non valido',[PAR_MESE]);
    Exit;
  end;

  if FMese <> R180InizioMese(FMese) then
  begin
    RErrMsg:=Format('Parametro [%s] non valido: indicare il primo giorno del mese',[PAR_MESE]);
    Exit;
  end;

  // 2. dati di autenticazione
  // 2a. utente
  FUtente:=GetParam(PAR_UTENTE);
  Log(NOME_PROC,Format('Parametro [%s] = [%s]',[PAR_UTENTE,FUtente]));

  if FUtente.Trim = '' then
  begin
    RErrMsg:=Format('Parametro [%s] non indicato',[PAR_UTENTE]);
    Exit;
  end;

  if FUtente.Length > MAX_LEN_UTENTE THEN
  begin
    RErrMsg:=Format('Parametro [%s] errato: lunghezza superiore a %d caratteri',[PAR_UTENTE,MAX_LEN_UTENTE]);
    Exit;
  end;

  // 2b. password
  FPassword:=GetParam(PAR_PASSWORD);
  Log(NOME_PROC,Format('Parametro [%s] = [%s]',[PAR_PASSWORD,FPassword]));

  if FPassword.Trim = '' then
  begin
    RErrMsg:=Format('Parametro [%s] non indicato',[PAR_PASSWORD]);
    Exit;
  end;

  if FPassword.Length > MAX_LEN_PASSWORD THEN
  begin
    RErrMsg:=Format('Parametro [%s] errato: lunghezza superiore a %d caratteri',[PAR_PASSWORD,MAX_LEN_PASSWORD]);
    Exit;
  end;

  Result:=True;
end;

function TB021FMancopPersMMDM.ControlloAutenticazione(var RErrAuth: String): TInfoAutenticazione;
var
  LOk: Boolean;
const
  NOME_PROC = 'ControlloAutenticazione';
begin
  RErrAuth:='';

  // crea oggetto con dati di autenticazione
  Result:=TInfoAutenticazione.Create;;

  // verifica utente e password fissi
  LOk:=(FUtente = UTENTE) and (FPassword = PASSWORD);
  if not LOk then
  begin
    RErrAuth:='utente e/o password non validi!';
    Log(NOME_PROC,Format('utente e/o password non validi',[]));
    Exit;
  end;

  // imposta i dati di autenticazione
  Result.Autenticato:=True;
  Result.Utente:=FUtente;
  Result.Ruolo:='';
end;

function TB021FMancopPersMMDM.GetResultOnError(PException: Exception): TJSONObject;
// risultato in caso di errore
var
  LTimestampPair, LDataPair: TJSONPair;
  LEsitoStr: TJSONString;
begin
  Result:=TJSONObject.Create;

  // info generiche
  LTimestampPair:=TJSONPair.Create('timestamp',TJSONString.Create(B021DateTimeToStr(Now)));
  LDataPair:=TJSONPair.Create('mese',TJSONString.Create(B021DateToStr(FMese)));

  // distingue l'esito in base all'eccezione
  if PException is EC200AuthError then
  begin
    // esito: errore di autenticazione
    LEsitoStr:=TJSONString.Create(ESITO_AUTH_ERR);
  end
  else
  begin
    // esito: impossibile estrarre i dati
    LEsitoStr:=TJSONString.Create(ESITO_DATA_ERR);
  end;

  // crea il risultato
  Result.AddPair(LTimestampPair);
  Result.AddPair('esito',LEsitoStr);
  Result.AddPair(LDataPair);
  Result.AddPair('mancop_persmm',TJSONArray.Create);
end;

function TB021FMancopPersMMDM.GetDato: TJSONObject;
begin
  Result:=GetDatiPersonale;
end;

end.
