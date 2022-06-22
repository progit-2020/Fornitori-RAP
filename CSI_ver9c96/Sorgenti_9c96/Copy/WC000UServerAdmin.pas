unit WC000UServerAdmin;

{ DONE : TEST IW 14 OK }

interface

uses
  Classes, SysUtils, HttpApp, IW.Content.Base, IWApplication,
  XMLIntf, XMLDoc, IWGlobal, IW.Http.Request, IW.Http.Reply, ActiveX, DateUtils,
  Oracle, Math, System.SyncObjs, System.Contnrs, StrUtils, A000UCostanti;

type

  TTipoSessione = (tsLogin,tsLavoro);

  TIWURLMonitorResponder = class(TContentBase)
  private
    function GetSessions(AResponse: THttpReply): Boolean;
    procedure DropSession(ID: String);
    procedure DropAllSessionExpired;
    function GetErrorResult(E: Exception): string;
    function MemoryUsed: cardinal;
    function GetDatiSessioneOracleLavoro(PSession: TIWApplication; var ROracleSid, ROracleUsername: string; var RSessionIndex: Integer; var RConnected: Boolean): Boolean;
    function getSessioniConnesse(const PTipo: TTipoSessione): Integer;
  protected
    function Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean; override;
  public
    constructor Create; override;
  end;

const
  URL_PATH = 'IWMonitor';
  ACTION_DROP = 'drop';
  ACTION_DROP_ALL_EXPIRED = 'drop_all_expired';

implementation

uses
  A000UInterfaccia, IWMimeTypes;

constructor TIWURLMonitorResponder.Create;
begin
  inherited;
  FileMustExist:=False;
  RequiresSession:=False;
  RequiresSessionStart:=False;
  CanStartSession:=False;
end;

function TIWURLMonitorResponder.MemoryUsed: cardinal;
var
    st: TMemoryManagerState;
    sb: TSmallBlockTypeState;
begin
  GetMemoryManagerState(st);
  result:=st.TotalAllocatedMediumBlockSize + st.TotalAllocatedLargeBlockSize;
  for sb in st.SmallBlockTypeStates do
    result:=result + sb.UseableBlockSize * sb.AllocatedBlockCount;
  result:=result div 1048576; //da bytes a Mega
end;

function TIWURLMonitorResponder.GetDatiSessioneOracleLavoro(PSession: TIWApplication;
  var ROracleSid, ROracleUsername: string; var RSessionIndex: Integer; var RConnected: Boolean): Boolean;
// estrae i dati della sessione oracle assegnata all'utente
var
  UOS: TOracleSession;
  i: Integer;
begin
  Result:=False;
  if (PSession = nil) or (PSession.Data = nil) then
    Exit;

  CSSessioniOracle.Enter;
  try
    // salva sessione oracle in variabile di appoggio
    UOS:=(PSession.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle;

    // estrae dati sessione
    ROracleSid:='';//UOS.AUDSID;//non threadsafe!

    ROracleUsername:=UOS.LogonUsername;

    RConnected:=UOS.Connected;

    // estrae indice sessione oracle all'interno della struttura dati
    RSessionIndex:=-1;
    for i:=0 to lstSessioniOracle.Count - 1 do
    begin
      if lstSessioniOracle[i] = UOS then
      begin
        RSessionIndex:=i;
        Break;
      end;
    end;
  finally
    CSSessioniOracle.Leave;
  end;

  Result:=True;
end;

function TIWURLMonitorResponder.getSessioniConnesse(const PTipo: TTipoSessione): Integer;
var
  i: Integer;
  CS: TMedpCriticalSection;
  lstSessioni: TObjectList;
begin
  case PTipo of
    tsLogin:  CS:=CSSessioneMondoEDP;
    tsLavoro: CS:=CSSessioniOracle;
  else
    raise Exception.Create('Tipologia di sessione invalida!');
  end;
  // estrae indice sessione oracle all'interno della struttura dati
  CS.Enter;
  try
    Result:=0;

    // determina lista da scorrere
    case PTipo of
      tsLogin:  lstSessioni:=lstSessioniMondoEDP;
      tsLavoro: lstSessioni:=lstSessioniOracle;
    else
      raise Exception.Create('Tipologia di sessione invalida!');
    end;

    for i:=0 to lstSessioni.Count - 1 do
    begin
      if (lstSessioni[i] as TOracleSession).Connected then
        Result:=Result + 1;
    end;
  finally
    CS.Leave;
  end;
end;

function TIWURLMonitorResponder.GetSessions(AResponse: THttpReply): Boolean;
var
  i, SIndex, MinutiScadenza, UpTimeGG, MaxSess: Integer;
  Session: TIWApplication;
  Html,StileRiga,SSid,SLogonUsername,InfoSessione,ColoreConnect,ScadenzaStr,
  UpTime, NomeFormAttiva, LinkTermina, LinkTerminaAllExpiredSession: String;
  SConnected: Boolean;
  ScadenzaDate,DateNow: TDateTime;
  MemPerSessione: Cardinal;
  lst:TList;
begin
  DateNow:=Now;

  // tempo di attività server
  UpTimeGG:=DaysBetween(gSC.StartDateTime,DateNow);
  UpTime:=UpTimeGG.ToString + IfThen(UpTimeGG = 1,' giorno, ',' giorni, ') +
          FormatDateTime('hh:nn:ss',DateNow - gSC.StartDateTime);

  LinkTerminaAllExpiredSession:=Format('<a href="?%s=%s&%s=%s">Termina tutte le sessioni scadute</a>',[URL_RESPONDER_PARAM_ID,URL_RESPONDER_VALUE_ID,URL_RESPONDER_PARAM_ACTION,ACTION_DROP_ALL_EXPIRED]);

  CSNumSessioni.Enter;
  try
    MaxSess:=W000NumMaxSessioni;
  finally
    CSNumSessioni.Leave;
  end;

  lst:=GSessions.LockList;
  with lst do
  begin
    if Count = 0 then // con IW 14 è impossibile, ma per sicurezza il controllo lo eseguiamo comunque
      MemPerSessione:=0
    else
      MemPerSessione:=Trunc(MemoryUsed / Count);
    try
      Html:='<html><head>' +
            Format('<title>%s server monitor</title>',[gSC.AppName]) +
            '<meta http-equiv="refresh" content="60">' +

            // stili utilizzati
            '<style>' +
            ' body { font-family: Arial; font-size: 12px; } ' +
            ' abbr { border-bottom: 1px dotted black; } ' +
            ' th { background-color: #DDEBF4; } '+
            '.riquadro { border: 1px solid #AAAAAA; border-radius: 4px; margin-bottom: 1em; } ' +
            '.riquadro_titolo { border-bottom: 1px dashed #CCCCCC; padding: 4px 8px; font-size: 16px; font-weight: bold; width: auto; background-color: #E0F0FF; } '+
            '.riquadro_corpo { padding: 6px 8px; background-color: #FAFAFA;} ' +
            '.tabella { font-size: 12px; border-collapse: collapse; padding: 0; border-spacing: 0;} ' +
            '.tabella th, .tabella td { border: 1px solid #CCCCCC; padding: 3px 5px; } ' +
            '.tabella.oracle { width: 20%; } ' +
            '.tabella.web { width: 95%; } ' +
            '.centra { text-align: center; } ' +
            '.fontSmall { font-size: 10px; } ' +
            '.fontCourier { font-family: "Courier New", Courier, monospace; } ' +
            '.rigaPari { background-color: #FFFFFF; } ' +
            '.rigaDispari { background-color: #EFEFEF; } ' +
            '</style>' +
            '</head>' +

            // body
            '<body>' +
            Format('<h1><a href="$/start">%s</a> server monitor</h1>',[gSC.AppName]) +
            Format('<h3>Dati aggiornati alle %s</h3>',[FormatDateTime('dd/mm/yyyy hhhh:nn:ss',DateNow)]) +

            // dati generici sul server
            '<div class="riquadro">' +
            '<div class="riquadro_titolo">Informazioni server</div>' +
            '<div class="riquadro_corpo">' +
            Format('<p>Versione Intraweb: %s</p>',[gSC.Version]) +
            Format('<p>Tempo di attivit&agrave;: %s (dal %s)</p>',[UpTime,FormatDateTime('dd/mm/yyyy hhhh:nn:ss',gSC.StartDateTime)]) +
            Format('<p>Memoria in uso: %d Mb (&#126; %d Mb / sessione)</p>',[MemoryUsed,MemPerSessione]) +
            Format('<p>Num. sessioni web (picco): %d</p>',[MaxSess]) +
            '</div></div>' +

            // dati delle sessioni oracle
            '<div class="riquadro">' +
            '<div class="riquadro_titolo">Sessioni oracle</div>' +
            '<div class="riquadro_corpo">' +
            '<table class="tabella oracle"><thead>' +
            '<th>Tipologia</th>' +
            '<th>Connesse / Istanziate</th>' +
            '</thead><tbody>' +
            Format('<tr class="rigaPari"><td>%s</td><td class="centra">%d / %d</td></tr>',['SOA000RegistraMsg',IfThen((SOA000RegistraMSG <> nil) and (SOA000RegistraMSG.Connected),1,0),IfThen(SOA000RegistraMSG <> nil,1,0)]) +
            Format('<tr class="rigaDispari"><td>%s</td><td class="centra">%d / %d</td></tr>',['Login',getSessioniConnesse(tsLogin),lstSessioniMondoEDP.Count]) +
            Format('<tr class="rigaPari"><td>%s</td><td class="centra">%d / %d</td></tr>',['Lavoro',getSessioniConnesse(tsLavoro),lstSessioniOracle.Count]) +
            '</tbody></table>' +
            '</div></div>' +

            // dati delle sessioni web
            '<div class="riquadro">' +
            Format('<div class="riquadro_titolo">Sessioni web attive: %d - %s</div>',[Count,LinkTerminaAllExpiredSession]) +
            '<div class="riquadro_corpo">' +
            '<table class="tabella sessioni"><thead>' +
            '<th>&nbsp;</th>' +
            '<th>Session ID</th>' +
            '<th>Funzione attiva</th>' +
            '<th>Active form count</th>' +
            '<th>IP</th>' +
            '<th>Last access</th>' +
            '<th>Timeout (min)</th>' +
            '<th>Scadenza (min)</th>' +
            '<th>Sessione lavoro</th>' +
            '<th>Browser</th>' +
            '</thead><tbody>';
      for i:=0 to Count - 1 do
      begin
        Session:=(TObject(Items[i]) as TIWApplication);
        LinkTermina:=Format('<a href="?%s=%s&%s=%s&%s=%s">Termina</a>',[URL_RESPONDER_PARAM_ID,URL_RESPONDER_VALUE_ID,URL_RESPONDER_PARAM_ACTION,ACTION_DROP,URL_RESPONDER_PARAM_SID,Session.AppID]);
        // estrae i dati della sessione oracle usata dall'utente se presenti
        GetDatiSessioneOracleLavoro(Session,SSid,SLogonUsername,SIndex,SConnected);
        if SIndex <> -1 then
        begin
          InfoSessione:=Format('Indice: %d - %s<br/>AudSID: %s',[SIndex,SLogonUsername,SSid]);
          ColoreConnect:=IfThen(SConnected,'#008800','#FF0000');
        end
        else
        begin
          InfoSessione:='nessuna';
          ColoreConnect:='#000000';
        end;
        InfoSessione:=Format('<span style="color: %s">%s</span>',[ColoreConnect,InfoSessione]);

        ScadenzaDate:=IncMinute(Session.LastAccess, Session.SessionTimeOut);
        StileRiga:='style="' +
                   Format('background-color: %s; ',[IfThen(i mod 2 = 0,'#FFFFFF','#EFEFEF')]) +
                   Format('color: %s; ',[IfThen(DateNow > ScadenzaDate,'#FF0000','#000000')]) +
                   Format('font-weight: %s; ',[IfThen(DateNow > ScadenzaDate,'bold','normal')])+
                   '"';
        // calcola i minuti alla scadenza (in valore assoluto)
        MinutiScadenza:=Max(0,MinutesBetween(DateNow,ScadenzaDate));
        if MinutiScadenza = 0 then
          ScadenzaStr:='< 1'
        else
        begin
          // verifica se la scadenza è già passata o meno (i minuti sono in valore assoluto)
          if DateNow > ScadenzaDate then
            ScadenzaStr:='scaduta'
          else
            ScadenzaStr:=IntToStr(MinutiScadenza);
        end;

        // nome funzione attiva
        if Session.ActiveForm = nil then
          NomeFormAttiva:=''
        else
          NomeFormAttiva:=Session.ActiveForm.Name;

        Html:=Html +
              Format('<tr %s>',[stileRiga]) +
              Format('<td class="centra">%s</td>',[LinkTermina]) +
              Format('<td class="fontCourier"> %s</td>',[Session.AppID]) +
              Format('<td> %s</td>',[NomeFormAttiva]) +
              Format('<td class="centra"> %d</td>',[Session.ActiveFormCount]) +
              Format('<td> %s</td>',[Session.IP]) +
              Format('<td class="centra"> %s</td>',[DateTimeToStr(Session.LastAccess)]) +
              Format('<td class="centra"> %d</td>',[Session.SessionTimeOut]) +
              Format('<td class="centra"> %s</td>',[ScadenzaStr]) +
              Format('<td class="fontSmall"> %s</td>',[InfoSessione]) +
              Format('<td><abbr title="%s">%s %d</abbr></td>',[Session.Browser.UserAgent,Session.Browser.BrowserName,Session.Browser.MajorVersion]) +
              '</tr>' + #13#10;
      end;
      Html:=Html + '</tbody></table>';
      Html:=Html + '</div></div>' +
            '</body></html>';
    finally
      GSessions.UnLockList(lst);
    end;
    AResponse.ContentType:= 'text/html';
    AResponse.WriteString(Html);
  end;
  Result:= True;
end;

procedure TIWURLMonitorResponder.DropSession(ID: String);
begin
  GSessions.Terminate(ID);
end;

procedure TIWURLMonitorResponder.DropAllSessionExpired;
  //GSessions.Terminate(ID);
var
  i, MinutiScadenza: Integer;
  Session: TIWApplication;
  ScadenzaDate, DateNow: TDateTime;
  lst:TList;
  lstExpSessions:TStringList;
begin
  DateNow:=Now;
  lstExpSessions:=TStringList.Create;
  try
    lst:=GSessions.LockList;
    with lst do
    begin
      try
        //Ricerca delle sessioni scadute
        for i:=0 to lst.Count - 1 do
        begin
          Session:=(TObject(Items[i]) as TIWApplication);
          ScadenzaDate:=IncMinute(Session.LastAccess, Session.SessionTimeOut);
          // calcola i minuti alla scadenza (in valore assoluto)
          MinutiScadenza:=Max(0,MinutesBetween(DateNow,ScadenzaDate));
          if (MinutiScadenza = 0) or (DateNow > ScadenzaDate) then
          begin
            //DropSession(Session.AppID);
            lstExpSessions.Add(Session.AppID);
          end;
        end;
      finally
        GSessions.UnLockList(lst);
      end;

      //DropSession delle sessioni scadute
      for i:=0 to lstExpSessions.Count - 1 do
      begin
        try
          DropSession(lstExpSessions[i]);
        except
        end;
      end;
    end;
  finally
    FreeAndNil(lstExpSessions);
  end;
end;


function TIWURLMonitorResponder.GetErrorResult(E: Exception): string;
begin
  Result:=URL_RESPONDER_ERROR_RESP + E.ClassName + ': ' + E.Message;
end;

function TIWURLMonitorResponder.Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean;
var
  Id,Action,SessionId: string;
begin
  Result:= True;
  aReply.ContentType:=MIME_HTML;
  try
    with ARequest.QueryFields do
    begin
      id:=Values[URL_RESPONDER_PARAM_ID];
      action:=Values[URL_RESPONDER_PARAM_ACTION];
      SessionId:=Values[URL_RESPONDER_PARAM_SID];
    end;
    if SameText(id,URL_RESPONDER_VALUE_ID) then
    begin
      // id valido
      if SameText(action, ACTION_DROP)  then
      begin
        // termina sessione
        DropSession(SessionId);
        Result:=GetSessions(aReply);
      end
      else if SameText(action, ACTION_DROP_ALL_EXPIRED)  then
      begin
        // termina sessione
        DropAllSessionExpired;
        Result:=GetSessions(aReply);
      end

      else
        Result:=GetSessions(aReply);
    end
    else
      raise Exception.Create('Non abilitato');
  except
    on E:Exception do
      aReply.WriteString(GetErrorResult(E));
  end;
end;

initialization

finalization

end.
