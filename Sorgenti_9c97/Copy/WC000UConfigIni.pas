unit WC000UConfigIni;

{ DONE : TEST IW 15 }

interface

uses
  Classes, SysUtils, HttpApp, IW.Content.Base, IWApplication,
  XMLIntf, XMLDoc, IWGlobal, IW.Http.Request, IW.Http.Reply, ActiveX, DateUtils,
  A000UCostanti, Math, StrUtils, System.SyncObjs;

type
  TIWURLConfigIniResponder = class(TContentBase)
  private
    function GetConfigurazione(AResponse: THttpReply): Boolean;
    function GetErrorResult(E: Exception): String;
    function UpdateConfigurazione: Boolean;
  protected
    function Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean; override;
  public
    constructor Create; override;
  end;

const
  URL_PATH = 'IWConfig';
  ACTION_UPDATE = 'updateConfig';

implementation

uses
  A000UInterfaccia, IWMimeTypes;

constructor TIWURLConfigIniResponder.Create;
begin
  inherited;
  FileMustExist:=False;
  RequiresSession:=False;
  RequiresSessionStart:=False;
  CanStartSession:=False;
end;

function TIWURLConfigIniResponder.GetConfigurazione(AResponse: THttpReply): Boolean;
var
  Html,EccIgnorate,IWELPurgeAfterDays: String;
  MyServerController:TA000FInterfaccia;
  IWELAttivato,IWELCustomFile:Boolean;

begin
  CSParConfig.Enter;
  EccIgnorate:='';
  MyServerController:=(gSC as TA000FInterfaccia);
  IWELAttivato:=MyServerController.ExceptionLogger.Enabled;
  IWELCustomFile:=(MyServerController.ExceptionLogger.FilePath <> '') or (MyServerController.ExceptionLogger.FileName <> '');
  IWELPurgeAfterDays:=IntToStr(MyServerController.ExceptionLogger.PurgeAfterDays);
  if MyServerController.ExcLoggerEccezioniIgnorate <> nil then
    EccIgnorate:=MyServerController.ExcLoggerEccezioniIgnorate.Text;
  try
    Html:='<html><head>' +
          Format('<title>Configurazione parametri %s</title>',[gSC.AppName]) +
          //'<meta http-equiv="refresh" content="60">' +
          '<style>' +
          ' body { font-family: Arial; font-size: 12px; } ' +
          ' th {background-color: #DDEBF4; } ' +
          '.tabella {font-size: 12px; border-collapse: collapse; padding: 0; border-spacing: 0;} ' +
          '.tabella th, .tabella td {border: 1px solid #CCCCCC; padding: 3px 5px;} ' +
          '.tabParametro {width: 20em;} ' +
          '.tabValore {width: 13em;} ' +
          '.tabNote {width: 30em;} ' +
          '.si {color: green; font-weight: bold;} ' +
          '.no {color: #AAAAAA;} ' +
          '.numero {text-align: right; } ' +
          '</style>' +
          '</head>' +
          '<body>' +
          Format('<h1>Parametri di configurazione %s</h1>',[gSC.AppName]) +
          Format('<p>Questa pagina visualizza il valore dei parametri di configurazione dell''applicativo web alle %s </p>',[FormatDateTime('dd/mm/yyyy hhhh:nn:ss',Now)]) +

          // link per aggiornare la configurazione
          Format(
          '<a href="?%s=%s&%s=%s">Aggiorna configurazione</a> ',[URL_RESPONDER_PARAM_ID,URL_RESPONDER_VALUE_ID,URL_RESPONDER_PARAM_ACTION,ACTION_UPDATE]) +

          // impostazioni operative
          '<h2>Impostazioni operative</h2>' +
          '<table class="tabella"><thead>' +
          '<th class="tabParametro">Parametro</th>' +
          '<th class="tabValore">Valore</th>' +
          '<th class="tabNote">Note</th>' +
          '</thead><tbody>' +
          '<tr><td>Database</td><td> ' + W000ParConfig.Database + '</td><td>&nbsp;</td></tr>'+
          '<tr><td>Azienda</td><td> ' + W000ParConfig.Azienda + '</td><td>&nbsp;</td></tr>'+
          '<tr><td>Profilo</td><td> ' + W000ParConfig.Profilo + '</td><td>&nbsp;</td></tr>'+
          '<tr><td>Timeout dipendente</td><td> ' + IntToStr(W000ParConfig.TimeoutDip) + '</td><td>Valore espresso in minuti</td></tr>'+
          '<tr><td>Timeout operatore</td><td> ' + IntToStr(W000ParConfig.TimeoutOper) + '</td><td>Valore espresso in minuti</td></tr>'+
          '<tr><td>Max sessioni web</td><td> ' + IntToStr(W000ParConfig.MaxSessioni) + '</td><td>0 = nessun limite</td></tr>'+
          '<tr><td>URL supero max sessioni</td><td> ' + W000ParConfig.UrlSuperoMaxSessioni + '</td><td></td></tr>'+
          '<tr><td>URL webservice autenticazione</td><td> ' + W000ParConfig.UrlWSAutenticazione + '</td><td>&nbsp;</td></tr>'+
          '<tr><td>URL manutenzione</td><td> ' + W000ParConfig.UrlManutenzione + '</td><td>&nbsp;</td></tr>'+
          '<tr><td>URL richiamo IrisWeb-IrisCloud</td><td> ' + W000ParConfig.UrlIrisWebCloud + '</td><td>&nbsp;</td></tr>'+
          '<tr><td>Login esterno</td><td> ' + W000ParConfig.LoginEsterno + '</td><td>&nbsp;</td></tr>'+
          '</tbody></table>' +

          // impostazioni di sistema
          '<h2>Impostazioni di sistema</h2>' +
          '<table class="tabella"><thead>' +
          '<th class="tabParametro">Parametro</th>' +
          '<th class="tabValore">Valore</th>' +
          '<th class="tabNote">Note</th>' +
          '</thead><tbody>' +
          '<tr><td>Porta</td><td class="numero"> ' + IntToStr(W000ParConfig.Port) + '</td><td>' +
            IfThen(IsLibrary,'Valore ignorato: controllare le impostazioni di IIS') + '</td></tr>'+
          '<tr><td>Cursori Login</td><td class="numero"> ' + IntToStr(W000ParConfig.CursoriLogin) + '</td><td>&nbsp;</td></tr>'+
          '<tr><td>Cursori Sessione</td><td class="numero"> ' + IntToStr(W000ParConfig.CursoriSessione) + '</td><td>&nbsp;</td></tr>'+
          '<tr><td>Max open cursors</td><td class="numero"> ' + IntToStr(W000ParConfig.MaxOpenCursors) + '</td><td>&nbsp;</td></tr>'+
          '<tr><td>Memoria max per il processo (Mb)</td><td class="numero"> ' + IntToStr(W000ParConfig.MaxWorkingMemMb) + '</td><td>' +
            IfThen(IsLibrary,'Il valore potrebbe non essere considerato',IfThen(W000ParConfig.MaxWorkingMemMb = 0,'0 = nessun limite di memoria')) + '</td></tr>'+
          '</tbody></table>' +

          // log abilitati
          '<h3>Log abilitati</h3>' +
          '<p>I valori evidenziati in verde sono quelli abilitati</p>' +
          '<table class="tabella"><thead>' +
          '<th class="tabParametro">Log</th>' +
          '</thead><tbody>' +
          '<tr><td class="' + IfThen(Pos(INI_LOG_ERRORE,W000ParConfig.LogAbilitati) > 0,'si','no') + '">' + INI_LOG_ERRORE + '</td></tr>'+
          '<tr><td class="' + IfThen(Pos(INI_LOG_MEMORIA,W000ParConfig.LogAbilitati) > 0,'si','no') + '">' + INI_LOG_MEMORIA + '</td></tr>'+
          '<tr><td class="' + IfThen(Pos(INI_LOG_SESSIONE,W000ParConfig.LogAbilitati) > 0,'si','no') + '">' + INI_LOG_SESSIONE + '</td></tr>'+
          '<tr><td class="' + IfThen(Pos(INI_LOG_ACCESSO,W000ParConfig.LogAbilitati) > 0,'si','no') + '">' + INI_LOG_ACCESSO + '</td></tr>'+
          '<tr><td class="' + IfThen(Pos(INI_LOG_TRACCIA,W000ParConfig.LogAbilitati) > 0,'si','no') + '">' + INI_LOG_TRACCIA + '</td></tr>'+
          '</tbody></table>' +

          // parametri avanzati
          '<h3>Parametri avanzati</h3>' +
          '<p>I valori evidenziati in verde sono quelli abilitati</p>' +
          '<table class="tabella"><thead>' +
          '<th class="tabParametro">Parametro</th>' +
          '</thead><tbody>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_DISABLE_CHIUSURA_BROWSER,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_DISABLE_CHIUSURA_BROWSER + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_NO_CRITICAL_SECTION_LOGIN,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_NO_CRITICAL_SECTION_LOGIN + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_NO_CRITICAL_SECTION_SESSIONE,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_NO_CRITICAL_SECTION_SESSIONE + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_NO_SHARED_LOGIN,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_NO_SHARED_LOGIN + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_NO_REGISTRA_MSG,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_NO_REGISTRA_MSG + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_RECUPERO_PASSWORD,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_RECUPERO_PASSWORD + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_NO_ABILITAZIONI,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_NO_ABILITAZIONI + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_USE_STANDARD_PRINTER + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_COMPRESSION,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_COMPRESSION + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_NO_STAMPACARTELLINO,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_NO_STAMPACARTELLINO + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_NO_STAMPACEDOLINO,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_NO_STAMPACEDOLINO + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_NO_PDF,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_NO_PDF + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_NO_COINITIALIZE + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_CAPTION_LAYOUT,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_CAPTION_LAYOUT + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_TRADUZIONE_CAPTION,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_TRADUZIONE_CAPTION + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_NO_DEL_TEMPFILE_ONCREATE,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_NO_DEL_TEMPFILE_ONCREATE + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_CACHED_FILES,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_CACHED_FILES + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_NO_UNIFIED_FILES,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_NO_UNIFIED_FILES + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_JQUERY_UNCOMPRESSED,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_JQUERY_UNCOMPRESSED + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_FILE_INLINE,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_FILE_INLINE + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_DB_STATEMENT_CACHE,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_DB_STATEMENT_CACHE + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_DB_NO_CHECK_CONNECTION + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_DB_NO_RECONNECT,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_DB_NO_RECONNECT + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_LOGOFF_DBPOOL,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_LOGOFF_DBPOOL + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_C017_V430,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_C017_V430 + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_C018_LEADING_T030,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_C018_LEADING_T030 + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_C018_NO_LEADING_T030,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_C018_NO_LEADING_T030 + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_C018_UNNEST,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_C018_UNNEST + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_C018_NO_UNNEST,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_C018_NO_UNNEST + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_T050_CANCELLAZIONE,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_T050_CANCELLAZIONE + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_RAVEREPORT_IN_MEMORIA,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_RAVEREPORT_IN_MEMORIA + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_COOKIES_ENABLE_HTTPONLY,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_COOKIES_ENABLE_HTTPONLY + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_COOKIES_ENABLE_SAMESITE_STRICT,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_COOKIES_ENABLE_SAMESITE_STRICT + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_SECURITY_ENABLE_FORM_ID_CHECK,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_SECURITY_ENABLE_FORM_ID_CHECK + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_SECURITY_ENABLE_SAME_IP_CHECK,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_SECURITY_ENABLE_SAME_IP_CHECK + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_SECURITY_ENABLE_SAME_UA_CHECK,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_SECURITY_ENABLE_SAME_UA_CHECK + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_IRISWEB_ENABLE_MULTISCHEDA,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_IRISWEB_ENABLE_MULTISCHEDA + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_PAR_SECURITY_ENABLE_XSS_PROTECTION,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_SECURITY_ENABLE_XSS_PROTECTION + '</td></tr>' +
		  '<tr><td class="' + IfThen(Pos(INI_PAR_SESSIONE_SINGOLA_PER_USR,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_PAR_SESSIONE_SINGOLA_PER_USR + '</td></tr>' +
          '</tbody></table>' +

          // com initialization
          '<p>COM Initialization: il valore evidenziato &egrave; quello utilizzato</p> ' +
          '<table class="tabella"><thead>' +
          '<th class="tabParametro">COM</th>' +
          '</thead><tbody>' +
          '<tr><td class="' + IfThen((Pos(INI_COM_NONE,W000ParConfig.ParametriAvanzati) = 0) and
                                 (Pos(INI_COM_NORMAL,W000ParConfig.ParametriAvanzati) = 0) and
                                 (Pos(INI_COM_MULTI,W000ParConfig.ParametriAvanzati) = 0),'si','no') + '">NULL</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_COM_NONE,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_COM_NONE + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_COM_NORMAL,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_COM_NORMAL + '</td></tr>' +
          '<tr><td class="' + IfThen(Pos(INI_COM_MULTI,W000ParConfig.ParametriAvanzati) > 0,'si','no') + '">' + INI_COM_MULTI + '</td></tr>' +
          '</tbody></table>' +

          // iw exception logger
          '<h2>Altro</h2>' +
          '<h3>Exception logger</h3>' +
          '<p>In caso di aggiornamento configurazione a caldo sar&agrave aggiornata solo la lista delle eccezioni ignorate (aggiunta di nuove eccezioni, non rimozione di esistenti).</p>' +
          '<table class="tabella"><thead>' +
          '<th class="tabParametro">Parametro</th>' +
          '<th class="tabValore">Valore</th>' +
          '<th class="tabNote">Note</th>' +
          '</thead><tbody>' +
          '<tr><td>Abilitato?</td><td>' + IfThen(IWELAttivato,'S&igrave;','No') + '</td><td></td></tr>' +
          '<tr><td>Percorso/Nome file</td><td>' + IfThen(IWELCustomFile,'Personalizzato','Default') + '</td><td>Default/Personalizzato, vedere configurazione per ottenere percorso/nome file</td></tr>' +
          '<tr><td>Et&agrave; minima log per eliminazione (gg)</td><td>' + IWELPurgeAfterDays + '</td><td>0 = nessuna rimozione</td></tr>' +
          '<tr><td>Eccezioni ignorate</td><td>' + EccIgnorate + '</td><td>Eccezioni caricate in lista ignore</td></tr>' +
          '</body></html>';
  finally
    CSParConfig.Leave;
  end;

  AResponse.ContentType:= 'text/html';
  AResponse.WriteString(Html);

  Result:= True;
end;

function TIWURLConfigIniResponder.GetErrorResult(E: Exception): string;
begin
  Result:=URL_RESPONDER_ERROR_RESP + E.ClassName + ': ' + E.Message;
end;

function TIWURLConfigIniResponder.Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean;
var
  Id,Action,SessionId: string;
begin
  Result:= True;
  aReply.ContentType:=MIME_HTML;
  try
    with ARequest.QueryFields do
    begin
      Id:=Values[URL_RESPONDER_PARAM_ID];
      Action:=Values[URL_RESPONDER_PARAM_ACTION];
      SessionId:=Values[URL_RESPONDER_PARAM_SID];
    end;
    if SameText(Id,URL_RESPONDER_VALUE_ID) then
    begin
      // id valido
      if SameText(Action,ACTION_UPDATE) then
      begin
        // aggiorna configurazione
        UpdateConfigurazione;
        Result:=GetConfigurazione(aReply);
      end
      else
      begin
        Result:=GetConfigurazione(aReply);
      end;
    end
    else
      raise Exception.Create('Non abilitato');
  except
    on E:Exception do
      aReply.WriteString(GetErrorResult(E));
  end;
end;

function TIWURLConfigIniResponder.UpdateConfigurazione: Boolean;
begin
  (gSC as TA000FInterfaccia).A000GetFileConfig;
  (gSC as TA000FInterfaccia).ImpostaSecurityServerController;
  (gSC as TA000FInterfaccia).ImpostaExcLoggerEccezioniIgnorate;
  Result:=True;
end;

initialization

finalization

end.
