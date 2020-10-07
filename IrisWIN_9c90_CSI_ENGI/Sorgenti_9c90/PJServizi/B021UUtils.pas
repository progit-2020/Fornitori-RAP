unit B021UUtils;

interface

uses C180FunzioniGenerali, SysUtils, DateUtils, Generics.Collections;

type

  // **************************************************
  // *      CLASSI DI ECCEZIONI PERSONALIZZATE        *
  // **************************************************

  EB021NoConnection = class(Exception)
  end;

  EB021InvalidParameter = class(Exception)
  end;

  EB021MarshallingError = class(Exception)
  end;

  EB021UnmarshallingError = class(Exception)
  end;

  EB021InvalidOperation = class(Exception)
  end;

  EB021InvalidStructure = class(Exception)
  end;

  EB021NotImplemented = class(Exception)
  end;

  EB021ExecutionError = class(Exception)
  end;

  TMetodoRest = (mrGet, mrPut, mrPost, mrDelete);

  // **************************************************
  // *               METODI DI SUPPORTO               *
  // **************************************************

  function ConvertiStrDate(const PDataStr: String; var RData: TDateTime): Boolean;
  function ConvertiDateStr(const PData: TDateTime): String;
  function ConvertiStrDateTime(const PDataStr: String; var RData: TDateTime): Boolean;
  function ConvertiDateTimeStr(const PData: TDateTime): String;
  function PulisciStringaJson(const strJson: String): String;
  function GetQuerystringParams(const PQueryString: String): TDictionary<String,String>;
  function GetLogFmt(const PClassName, PProcName, PLogInfo: String): String;

const
  FILE_LOG                   = 'B021.log';           // path file log

  OPER_CREATE                = 'C';
  OPER_READ                  = 'R';
  OPER_UPDATE                = 'U';
  OPER_DELETE                = 'D';

  FIRLAB_DATO_LIBERO_TURNI   = 'ATTIVO_TURNI';       // dato libero anagrafico che identifica i turnisti
  FIRLAB_SHARED_PWD          = 'pwdIrisRostersha1';  // password condivisa per generazione hash
  FIRLAB_DATE_FMT            = 'dd-mm-yyyy';         // formato data standard
  FIRLAB_DATETIME_FMT        = 'dd-mm-yyyy hhhh:nn'; // formato data/ora standard
  FIRLAB_TIME_FMT            = 'hhhh:nn';            // formato ora standard

  SPAZIO = #32;
  TAB    = #9;
  CR     = #13;
  LF     = #10;

implementation

function ConvertiStrDate(const PDataStr: String; var RData: TDateTime): Boolean;
// converte la data indicata come stringa nel formato TDateTime
// formati riconosciuti:
//   yyyy-mm-dd
//   dd-mm-yyyy
var
  Anno,Mese,Giorno: String;
begin
  RData:=0;

  if Trim(PDataStr) = '' then
  begin
    Result:=True;
    Exit;
  end;

  if R180IsDigit(PDataStr,5) then
  begin
    // formato dd-mm-yyyy
    Anno:=Copy(PDataStr,7,4);
    Mese:=Copy(PDataStr,4,2);
    Giorno:=Copy(PDataStr,1,2);
  end
  else
  begin
    // formato yyyy-mm-dd
    Anno:=Copy(PDataStr,1,4);
    Mese:=Copy(PDataStr,6,2);
    Giorno:=Copy(PDataStr,9,2);
  end;
  try
    RData:=EncodeDate(StrToInt(Anno),
                      StrToInt(Mese),
                      StrToInt(Giorno));
    Result:=True;
  except
    on E: EConvertError do
    begin
      RData:=0;
      Result:=False;
    end;
  end;
end;

function ConvertiDateStr(const PData: TDateTime): String;
// converte la data indicata nella rappresentazione string
// con formato standard
begin
  Result:=FormatDateTime(FIRLAB_DATE_FMT,PData);
end;

function ConvertiStrDateTime(const PDataStr: String; var RData: TDateTime): Boolean;
// converte la data/ora indicata in formato stringa nel formato TDateTime
// formato riconosciuti:
//   yyyy-mm-dd hhhh:nn
//   dd-mm-yyyy hhhh:nn
var
  DOra: TDateTime;
  Ore,Minuti: String;
begin
  Result:=False;
  RData:=0;

  if Trim(PDataStr) = '' then
  begin
    Result:=True;
    Exit;
  end;

  if not ConvertiStrDate(Copy(PDataStr,1,10),RData) then
    Exit;

  // parte relativa all'ora
  if Length(PDataStr) > 10 then
  begin
    Ore:=Copy(PDataStr,12,2);
    Minuti:=Copy(PDataStr,15,2);

    try
      DOra:=EncodeTime(StrToInt(Ore),
                       StrToInt(Minuti),
                       0,0);
    except
      on E: EConvertError do
      begin
        RData:=0;
        Exit;
      end;
    end;
    RData:=RData + DOra;
  end;
  Result:=True;
end;

function ConvertiDateTimeStr(const PData: TDateTime): String;
// converte la data/ora indicata nella rappresentazione string
// con formato standard
begin
  Result:=FormatDateTime(FIRLAB_DATETIME_FMT,PData);
end;

function PulisciStringaJson(const strJson: String): String;
// rimuove i caratteri spazio, tab, cr, lf dalla stringa in formato json
// workaround per bug riconoscimento json (delphi 2010)
var
  P: PChar;
  InTag: Boolean;
begin
  P:=PChar(strJson);
  Result:='';
  if Trim(strJson) = '' then
    exit;

  // rimozione dei tag
  InTag:=False;
  repeat
    case P^ of
      '"': begin
             InTag:=not InTag;
             Result:=Result + P^;
           end;
      SPAZIO, TAB, CR, LF:
           if InTag then
             Result:=Result + P^; // nessuna operazione
      else
        //if not InTag then
        //begin
        //  if (P^ in [#9, #32]) and
        //     ((P + 1)^ in [#10, #13, #32, #9, '"']) then
        //  else
            Result:=Result + P^;
        //end;
    end;
    Inc(P);
  until (P^ = #0);
end;

function GetQuerystringParams(const PQueryString: String): TDictionary<String,String>;
// data una querystring (che può iniziare con il carattere ? o meno)
// estrae un TDictionary contenente le coppie (parametro,valore)
var
  S, ParCoppia: String;
  KeyValueArr: TArray<String>;
const
  PAR_SEPARATOR       = '&';
  PAR_VALUE_SEPARATOR = '=';
begin
  Result:=TDictionary<String,String>.Create;

  // trim degli eventuali spazi
  S:=PQueryString.Trim;

  // elimina eventuale punto interrogativo iniziale in modo da ottenere 
  // solo l'elenco di coppie parametro / valore
  if S.StartsWith('?') then
    S:=S.Substring(1);

  // inoltre vengono riportate le coppie dei parametri in input
  for ParCoppia in S.Split([PAR_SEPARATOR]) do
  begin
    KeyValueArr:=ParCoppia.Split([PAR_VALUE_SEPARATOR]);
    Result.Add(KeyValueArr[0],KeyValueArr[1]);
  end;
end;

function GetLogFmt(const PClassName, PProcName, PLogInfo: String): String;
// formatta le informazioni per il log
begin
  Result:=Format('%s [%s.%s] %s',[FormatDateTime('dd/mm/yyyy hh.mm.ss',Now),PClassName,PProcName,PLogInfo]);
end;

end.
