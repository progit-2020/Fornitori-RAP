unit C019UDistanziometro;

interface

uses IdHttp, IdURI,
     StrUtils, System.SysUtils,
     DBXJson, System.JSON;

type
  TTipoServizio = (tsGoogleXml,
                   tsGoogleJson,
                   tsViaMichelinRest
                  );

  TC019FDistanziometro = class
  private
    class function ParseResultGoogleJson(const PStringaJson: string;
      var RDistanza: Integer; var RErrMsg: String): Boolean; static;
  public
    class function GetDistanza(const PPartenza, PDestinazione: String;
      var RErrore: String; const PTipoServizio: TTipoServizio = tsGoogleJson): Integer; static;
    class function FormattaLocalita(const PNomeLocalita, PCap, PProvincia: String;
      const PTipoServizio: TTipoServizio = tsGoogleJson): String; static;
  end;

const
  GOOGLE_MAPS_DIST_WS_URL          = 'http://maps.googleapis.com/maps/api/distancematrix/';
  GOOGLE_MAPS_DIST_WS_URL_SSL      = 'https://maps.googleapis.com/maps/api/distancematrix/';
  GOOGLE_MAPS_DIST_WS_OUTPUT_JSON  = 'json';
  GOOGLE_MAPS_DIST_WS_OUTPUT_XML   = 'xml';
  GOOGLE_MAPS_DIST_WS_PAR_SENSOR   = 'false';
  GOOGLE_MAPS_DIST_WS_PAR_LANGUAGE = 'it-IT';
  GOOGLE_MAPS_DIST_WS_STATUS_OK    = 'OK';

implementation

// formatta la località di partenza / arrivo
// per il servizio
class function TC019FDistanziometro.FormattaLocalita(const PNomeLocalita, PCap,
  PProvincia: String; const PTipoServizio: TTipoServizio = tsGoogleJson): String;
begin
  // prepara url per chiamata al webservice relativo
  // N.B.: al momento è implementata la sola chiamata al webservice di google
  //       con output in formato json
  case PTipoServizio of
    tsGoogleXml,tsGoogleJson:
      begin
        // webservice di google, output json / xml
        if (PProvincia = '') or (PProvincia = 'EE') then
        begin
          // gestione località estera: utilizza località e cap
          Result:=PNomeLocalita + IfThen(PCap <> '',',' + PCap);
        end
        else
        begin
          // gestione località italiana: località, cap e sigla 'IT' fissa
          Result:=PNomeLocalita + IfThen(PCap <> '',',' + PCap) + ',IT';
        end;
      end;
    tsViaMichelinRest:
      begin
        raise Exception.Create('Non implementato');
      end;
  end;
end;

// estrae la distanza espressa in metri fra due località
// parametri
//   PPartenza
//     nome descrittivo della località di partenza (es. Villafalletto)
//   PDestinazione
//     nome descrittivo della località di destinazione (es. Alba)
//   RErrore
//     restituisce eventualmente il dettaglio dell'errore
//   PTipoServizio
//     tipologia di webservice da utilizzare per la chiamata
//     default: tsGoogleJson
//     NOTA: al momento l'unica chiamata implementata è con tsGoogleJson
// restituisce
//   N > 0: indica il numero di metri fra la località PPartenza e PDestinazione
//   0    : indica un errore nella funzione (viene valorizzata la variabile RErrore
//          con il dettaglio del problema riscontrato)
class function TC019FDistanziometro.GetDistanza(const PPartenza, PDestinazione: String;
  var RErrore: String; const PTipoServizio: TTipoServizio = tsGoogleJson): Integer;
var
  ResWS, Url, ParUrl, LPartenza, LDestinazione: String;
  Ok: Boolean;
  Dist: Integer;
  IdHttp: TIdHTTP;
begin
  // inizializzazione variabili di ritorno
  Result:=0;
  RErrore:='';

  // controllo parametri formali
  LPartenza:=Trim(PPartenza);
  if LPartenza = '' then
  begin
    RErrore:='La località di partenza non è stata indicata!';
    Exit;
  end;

  LDestinazione:=Trim(PDestinazione);
  if LDestinazione = '' then
  begin
    RErrore:='La località di destinazione non è stata indicata!';
    Exit;
  end;

  // prepara url per chiamata al webservice relativo
  // N.B.: al momento è implementata la sola chiamata al webservice di google
  //       con output in formato json
  case PTipoServizio of
    tsGoogleXml:
      begin
        raise Exception.Create('Non implementato');
      end;
    tsGoogleJson:
      begin
        // webservice di google, output json
        Url:=GOOGLE_MAPS_DIST_WS_URL + GOOGLE_MAPS_DIST_WS_OUTPUT_JSON;
        ParUrl:=Format('?origins=%s&destinations=%s&sensor=%s&language=%s',
                       [LPartenza,LDestinazione,GOOGLE_MAPS_DIST_WS_PAR_SENSOR,GOOGLE_MAPS_DIST_WS_PAR_LANGUAGE]);
      end;
    tsViaMichelinRest:
      begin
        raise Exception.Create('Non implementato');
      end;
  end;

  // crea oggetto per effettuare chiamata a webservice
  IdHttp:=TIdHTTP.Create(nil);
  try
    try
      // richiama il webservice in base al tipo
      ResWS:=IdHttp.Get(TIdURI.URLEncode(Url + ParUrl));

      // se la chiamata è ok parsifica il risultato
      case PTipoServizio of
        tsGoogleXml:
          begin
            raise Exception.Create('Non implementato');
          end;
        tsGoogleJson:
          begin
            // webservice di google, output json
            Ok:=TC019FDistanziometro.ParseResultGoogleJson(ResWS,Dist,RErrore);
            if Ok then
              Result:=Dist;
          end;
        tsViaMichelinRest:
          begin
            raise Exception.Create('Non implementato');
          end;
      end;
    except
      on E: Exception do
      begin
        RErrore:=Format('%s (%s)',[E.Message,E.ClassName]);
      end;
    end;
  finally
    FreeAndNil(IdHttp);
  end;
end;

// metodo di servizio per effettuare il parse della stringa json di risultato
// della chiamata al webservice google distance matrix per estrarre la distanza fra 2 località
// restituisce:
//   True  se il parse è andato a buon fine
//   False altrimenti
// parametri:
//   PStringaJson
//     la stringa del risultato da parsificare
//   RDistanza
//     la distanza espressa in metri oppure 0 in caso di errore
//   RErrMsg
//     eventuale descrizione dell'errore riscontrato nel parse
class function TC019FDistanziometro.ParseResultGoogleJson(const PStringaJson: string;
  var RDistanza: Integer; var RErrMsg: String): Boolean;
var
  json: TJSONObject;
  jRowsArr,jElementsArr: TJSONArray;
  jRowObj,jElementObj,jDistanceObj: TJSONObject;
  Val: String;
begin
  // inizializzazione variabili
  RDistanza:=0;
  RErrMsg:='';
  Result:=False;

  (*
  Esempio del json restituito dal webservice di google
  {
     "destination_addresses" : [ "Cuneo CN, Italia" ],
     "origin_addresses" : [ "12023 Caraglio CN, Italia" ],
     "rows" : [
        {
           "elements" : [
              {
                 "distance" : {
                    "text" : "11,4 km",
                    "value" : 11446
                 },
                 "duration" : {
                    "text" : "19 min",
                    "value" : 1117
                 },
                 "status" : "OK"
              }
           ]
        }
     ],
     "status" : "OK"
  }
  *)

  // parsificazione del json
  json:=TJSONObject.ParseJSONValue(PStringaJson) as TJSONObject;
  try
    try
      // estrae status
      Val:=json.Get('status').JsonValue.Value;

      if Val.ToUpper = GOOGLE_MAPS_DIST_WS_STATUS_OK then
      begin
        // destination addresses
        jRowsArr:=(json.Get('rows').JsonValue as TJSONArray);

        // considera solo la row 0
        jRowObj:=(jRowsArr.Get(0) as TJSONObject);
        jElementsArr:=(jRowObj.Get('elements').JSONValue as TJSONArray);

        // considera solo l'elemento 0
        jElementObj:=(jElementsArr.Get(0) as TJSONObject);

        // se lo status è OK  estrae la distanza
        Val:=jElementObj.Get('status').JsonValue.Value;
        Result:=(Val.ToUpper = GOOGLE_MAPS_DIST_WS_STATUS_OK);
        if Result then
        begin
          jDistanceObj:=(jElementObj.Get('distance').JsonValue as TJSONObject);

          // restituisce la distanza espressa in metri
          RDistanza:=StrToIntDef(jDistanceObj.Get('value').JsonValue.Value,0);
        end
        else
        begin
          // status degli element non corretto
          RErrMsg:=Format('Elements status: %s',[Val]);
        end;
      end
      else
      begin
        // status non corretto
        RErrMsg:=Format('Service status: %s',[Val]);
      end;
    except
      on E: Exception do
      begin
        RErrMsg:=Format('%s (%s)',[E.Message,E.ClassName]);
      end;
    end;
  finally
    json.Free;
  end;
end;

initialization
  //

finalization
  //

end.
