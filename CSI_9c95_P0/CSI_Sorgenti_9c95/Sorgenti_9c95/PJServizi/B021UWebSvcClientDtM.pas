unit B021UWebSvcClientDtM;

interface

uses
  SysUtils, StrUtils, Windows, Classes, Variants,
  IdHTTP, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} Oracle, OracleData,
  A000UCostanti, A000USessione, A000UInterfaccia, {C200UWebServicesUtils, }B021UUtils,
  C180FunzioniGenerali, RegistrazioneLog, DB, DateUtils, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient;

type
  TRecordT040 = record
    Operazione:String;
    Progressivo:Integer;
    Causale:String;
    Data:TDateTime;
    ProgrCausale:Integer;
    TipoGiust:String;
    Dalle:String;
    Alle:String;
    DataFamiliare:TDateTime;
    Anomalia:String;
    Richiesta:Boolean; // COMO_HSANNA - commessa 2013/012
  end;

  TB021FWebSvcClientDtM = class(TDataModule)
    scrGetDati: TOracleQuery;
    insUSR_T040_TRACE_FALLIMENTI: TOracleQuery;
    selT430: TOracleDataSet;
    selT265Richiesta: TOracleDataSet;
    IdHTTP1: TIdHTTP;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    RegistraMsg:TRegistraMsg;
    lstRecordT040:array of TRecordT040;
    B021Progressivo:Integer;
    B021Matricola,B021Causale,B021Dalle,B021Alle,B021TipoGiust,B021Anomalia,B021Richiesta:String;
    B021Dal,B021Al,B021Data,B021DataFamiliare:TDateTime;
    function Parametri:TParametri;
    function ValutaExprSQL(ExprDati:String):String;
    function InserisciGiustificativo(PostData:String):String;
    function CancellaGiustificativo(PostData:String):String;
    procedure SalvaRecordT040;
    function LeggiTurniPianificati:String;
  public
    Autorizzatore:String;
    EsistonoMsgAnomalie:Boolean;
    function  EsisteRecordT040:Boolean;
    procedure ResetRecordT040;
    function  RegistraAnomaliaT040(POperazione:String; Var_TipoCaus:Integer; PProg: Integer;
      PData: TDateTime; PCaus, PTipoGiust: String; PAnomalia: String; Chiamante:String):Boolean;
    function  RegistraRecordT040(POperazione:String; Q040:TOracleDataSet; Var_TipoCaus:Integer; Chiamante:String):Boolean;
    function  RegistraRecordT050(POperazione:String; Var_TipoCaus:Integer; PProg: Integer;
      PData:TDateTime; PCaus,PTipoGiust,PNumeroOre,PAOre:String; PDataFamiliare: TDateTime; PRichiesta: Boolean; Chiamante:String):Boolean;
    function EseguiMetodoRest(Url, PFormat, PMetodo, PRequest: String): String;
  end;

implementation

{$R *.dfm}

procedure TB021FWebSvcClientDtM.DataModuleCreate(Sender: TObject);
var
  OS:TOracleSession;
  FiltroAnag: String;
begin
  if (Owner <> nil) and (Owner is TOracleSession) then
    OS:=TOracleSession(Owner)
  else if (Owner <> nil) and (Owner is TSessioneIrisWIN) then
    OS:=TSessioneIrisWIN(Owner).SessioneOracle
  else
    OS:=SessioneOracle;
  RegistraMsg:=TRegistraMsg.Create(nil);
  RegistraMsg.SessioneOracleApp:=OS;
  scrGetDati.Session:=OS;
  insUSR_T040_TRACE_FALLIMENTI.Session:=OS;

  FiltroAnag:=Format('and exists (select ''x'' from T430_STORICO where PROGRESSIVO = T430.PROGRESSIVO and %s = ''S'')',[FIRLAB_DATO_LIBERO_TURNI]);
  selT430.Session:=OS;
  selT430.SetVariable('FILTRO',FiltroAnag);

  selT265Richiesta.Session:=OS;
  EsistonoMsgAnomalie:=False;
end;

function TB021FWebSvcClientDtM.Parametri:TParametri;
begin
  if Owner is TSessioneIrisWin then
    Result:=TSessioneIrisWin(Owner).Parametri
  else
    Result:=A000UInterfaccia.Parametri;
end;

//Inserimento giustificativi//
procedure TB021FWebSvcClientDtM.ResetRecordT040;
begin
  SetLength(lstRecordT040,0);
end;

function TB021FWebSvcClientDtM.EsisteRecordT040:Boolean;
begin
  Result:=Length(lstRecordT040) > 0;
end;

// commessa 2011/178.ini
function TB021FWebSvcClientDtM.RegistraAnomaliaT040(POperazione:String; Var_TipoCaus:Integer; PProg: Integer;
  PData: TDateTime; PCaus, PTipoGiust: String; PAnomalia: String; Chiamante:String):Boolean;
// POperazione =
//   'I': inserimento
//   'C': cancellazione
var i:Integer;
    Esegui:Boolean;
begin
  Result:=False;
  if (Var_TipoCaus = 1) and
     (Parametri.CampiRiferimento.C30_WebSrv_A004_URL <> '') and
     (Parametri.CampiRiferimento.C30_WebSrv_A004_Dati <> '') then
  begin
    Esegui:=False;
    R180SetVariable(selT430,'PROGRESSIVO',PProg);
    with selT430 do
    begin
      Open;
      if RecordCount > 0 then
        Esegui:=True;
    end;
    if not Esegui then
      exit;
    SetLength(lstRecordT040,Length(lstRecordT040) + 1);
    i:=High(lstRecordT040);
    lstRecordt040[i].Operazione:=POperazione;
    lstRecordT040[i].Progressivo:=PProg;
    lstRecordT040[i].Causale:=PCaus;
    lstRecordT040[i].ProgrCausale:=0; //???
    lstRecordT040[i].Data:=PData;
    lstRecordT040[i].Dalle:='';
    lstRecordT040[i].Alle:='';
    lstRecordT040[i].TipoGiust:=PTipoGiust;
    lstRecordT040[i].DataFamiliare:=0;
    lstRecordT040[i].Anomalia:=PAnomalia;
    lstRecordT040[i].Richiesta:=False;
    Result:=True;
  end;
end;
// commessa 2011/178.fine

function TB021FWebSvcClientDtM.RegistraRecordT040(POperazione:String; Q040:TOracleDataSet; Var_TipoCaus:Integer; Chiamante:String):Boolean;
// Registrazione dei giustificativi inseriti per successiva comunicazione al web service (Firlab)
// POperazione =
//   'I': inserimento
//   'C': cancellazione
var i:Integer;
    Esegui:Boolean;
begin
  Result:=False;
  if (Var_TipoCaus = 1) and
     (Parametri.CampiRiferimento.C30_WebSrv_A004_URL <> '') and
     (Parametri.CampiRiferimento.C30_WebSrv_A004_Dati <> '') then
  begin
    Esegui:=False;
    R180SetVariable(selT430,'PROGRESSIVO',Q040.FieldByName('Progressivo').AsInteger);
    with selT430 do
    begin
      Open;
      if RecordCount > 0 then
        Esegui:=True;
    end;
    if not Esegui then
      exit;
    SetLength(lstRecordT040,Length(lstRecordT040) + 1);
    i:=High(lstRecordT040);
    lstRecordT040[i].Operazione:=POperazione;
    lstRecordT040[i].Progressivo:=Q040.FieldByName('Progressivo').AsInteger;
    lstRecordT040[i].Causale:=Q040.FieldByName('Causale').AsString;
    lstRecordT040[i].ProgrCausale:=Q040.FieldByName('ProgrCausale').AsInteger;
    lstRecordT040[i].Data:=Q040.FieldByName('Data').AsDateTime;
    lstRecordT040[i].Dalle:='';
    lstRecordT040[i].Alle:='';
    if not Q040.FieldByName('DaOre').IsNull then
      lstRecordT040[i].Dalle:=R180MinutiOre(R180OreMinuti(Q040.FieldByName('DaOre').AsDateTime));
    if not Q040.FieldByName('AOre').IsNull then
      lstRecordT040[i].Alle:=R180MinutiOre(R180OreMinuti(Q040.FieldByName('AOre').AsDateTime));
    lstRecordT040[i].TipoGiust:=Q040.FieldByName('Tipogiust').AsString;
    lstRecordT040[i].DataFamiliare:=Q040.FieldByName('DataNas').AsDateTime;
    lstRecordT040[i].Anomalia:='';
    lstRecordT040[i].Richiesta:=False;
    Result:=True;
  end;
end;

// COMO_HSANNA - commessa 2013/012.ini
function TB021FWebSvcClientDtM.RegistraRecordT050(POperazione:String; Var_TipoCaus:Integer; PProg: Integer;
  PData:TDateTime; PCaus,PTipoGiust,PNumeroOre,PAOre:String; PDataFamiliare: TDateTime; PRichiesta: Boolean; Chiamante:String):Boolean;
// Registrazione delle richieste di giustificativo per successiva comunicazione al web service (Firlab)
// POperazione =
//   'I': inserimento
//   'C': cancellazione
var i:Integer;
    Esegui:Boolean;
    Causale:String;
begin
  Result:=False;
  if (Var_TipoCaus = 1) and
     (Parametri.CampiRiferimento.C30_WebSrv_A004_URL <> '') and
     (Parametri.CampiRiferimento.C30_WebSrv_A004_Dati <> '') then
  begin
    Esegui:=False;
    R180SetVariable(selT430,'PROGRESSIVO',PProg);
    with selT430 do
    begin
      Open;
      if RecordCount > 0 then
        Esegui:=True;
    end;
    if not Esegui then
      exit;
    SetLength(lstRecordT040,Length(lstRecordT040) + 1);
    i:=High(lstRecordT040);
    lstRecordT040[i].Operazione:=POperazione;
    lstRecordT040[i].Progressivo:=PProg;
    // COMO_HSANNA - commessa 2011/178 - SVILUPPO 2.ini
    // nel caso di inserimento o cancellazione di una richiesta,
    // non è più utilizzato il parametro authorized true/false
    // in caso di richiesta, il codice della causale è decodificato con un altro
    //lstRecordT040[i].Causale:=PCaus;
    if PRichiesta then
    begin
      // richiesta -> codice causale decodificato
      selT265Richiesta.Open;
      Causale:=VarToStr(selT265Richiesta.Lookup('CODICE',PCaus,'CODICE_RICHIESTA'));
      // se non è presente la decodifica, utilizza la causale stessa
      if Causale = '' then
        Causale:=PCaus;
      PRichiesta:=Causale = PCaus;
    end
    else
    begin
      // giustificativo reale -> codice causale stesso
      Causale:=PCaus;
    end;
    lstRecordT040[i].Causale:=Causale;
    // COMO_HSANNA - commessa 2011/178 - SVILUPPO 2.fine
    lstRecordT040[i].ProgrCausale:=0; //???
    lstRecordT040[i].Data:=PData;
    lstRecordT040[i].Dalle:=PNumeroOre;
    lstRecordT040[i].Alle:=PAOre;
    lstRecordT040[i].TipoGiust:=PTipoGiust;
    lstRecordT040[i].DataFamiliare:=PDataFamiliare;
    lstRecordT040[i].Anomalia:='';
    // COMO_HSANNA - commessa 2011/178 - SVILUPPO 2.ini
    // il parametro richiesta viene settato sempre a false <=> authorized sempre true
    lstRecordT040[i].Richiesta:=PRichiesta;
    //lstRecordT040[i].Richiesta:=False;
    // COMO_HSANNA - commessa 2011/178 - SVILUPPO 2.fine
    Result:=True;
  end;
end;
// COMO_HSANNA - commessa 2013/012.fine

procedure TB021FWebSvcClientDtM.SalvaRecordT040;
var i:Integer;
begin
  for i:=0 to High(lstRecordT040) do
    with insUSR_T040_TRACE_FALLIMENTI do
    begin
      SetVariable('OPERAZIONE',lstRecordT040[i].Operazione);
      SetVariable('PROGRESSIVO',lstRecordT040[i].Progressivo);
      SetVariable('CAUSALE',lstRecordT040[i].Causale);
      SetVariable('DATA',lstRecordT040[i].Data);
      SetVariable('DALLE',lstRecordT040[i].Dalle);
      SetVariable('ALLE',lstRecordT040[i].Alle);
      SetVariable('TIPOGIUST',lstRecordT040[i].TipoGiust);
      SetVariable('DATAFAMILIARE',lstRecordT040[i].DataFamiliare);
      SetVariable('ANOMALIA',lstRecordT040[i].Anomalia);
      SetVariable('RICHIESTA',IfThen(lstRecordT040[i].Richiesta,'S','N'));
      Execute;
    end;
end;

function TB021FWebSvcClientDtM.InserisciGiustificativo(PostData:String):String;
var {Res,}url,MetodoStr:String;
    locMetodoRest:TMetodoRest;
begin
  Result:='';
  locMetodoRest:=mrPost;//Firlab fa così
  url:=Parametri.CampiRiferimento.C30_WebSrv_A004_URL;
  if Pos('''',url) > 0 then
    url:=ValutaExprSQL(url);
  //url:='http://62.149.218.212:8080/hsacomo/rest/justification/insertjustification/v1';//cmbServerURL.Text + edtMethodUrl.Text + edtParametri.Text;
  //url:='http://10.5.100.221:8080/hsacomo/rest/justification/insertjustification/v1';//cmbServerURL.Text + edtMethodUrl.Text + edtParametri.Text;
  (*
  PostData:='{ ' + CRLF +
              '  "idEmployee" : "2945", ' + CRLF +
              '  "justification" : "FERIE", ' + CRLF +
              '  "justificationCode" : "40101", ' + CRLF +
              '  "day" : "01-07-2012", ' + CRLF +
              '  "start" : "01-07-2012 00:00", ' + CRLF +
              '  "end" : "02-07-2012 00:00", ' + CRLF +
              '  "timePeriod" : true ' + CRLF +
              '} ';*)
  MetodoStr:='';
  if locMetodoRest = mrPost then
    MetodoStr:='POST'
  else if locMetodoRest = mrPut then
    MetodoStr:='PUT';


  //!!Chiamate di prova!!//
  //url:='http://188.10.212.66:8080/hsacomo/rest/justification/createjustification/v1';
  //locMetodoRest:=mrGet;
  //MetodoStr:='GET';

  RegistraMsg.InserisciMessaggio('I',Format('Chiamata:%s',[MetodoStr]),Parametri.Azienda,B021Progressivo);
  if locMetodoRest = mrPost then
    Result:=EseguiMetodoRest(url,'json','POST',PostData)
  else if locMetodoRest = mrPut then
    Result:=EseguiMetodoRest(url,'json','PUT',PostData)
  else if locMetodoRest = mrGet then
    Result:=EseguiMetodoRest(url,'json','GET','');

  RegistraMsg.InserisciMessaggio('I',Format('Fine inserimento giustificativo:%s',[Result]),Parametri.Azienda,B021Progressivo);
end;

function TB021FWebSvcClientDtM.CancellaGiustificativo(PostData:String):String;
var {Res,}url,MetodoStr:String;
    locMetodoRest:TMetodoRest;
begin
  Result:='';
  locMetodoRest:=mrPost;//Firlab fa così
  url:=Parametri.CampiRiferimento.C30_WebSrv_A004_URL;
  url:=StringReplace(url,'createjustifications','deletejustifications',[rfIgnoreCase]);
  if Pos('''',url) > 0 then
    url:=ValutaExprSQL(url);
  MetodoStr:='';
  if locMetodoRest = mrPost then
    MetodoStr:='POST'
  else if locMetodoRest = mrPut then
    MetodoStr:='PUT';
  RegistraMsg.InserisciMessaggio('I',Format('Chiamata:%s',[MetodoStr]),Parametri.Azienda,B021Progressivo);
  if locMetodoRest = mrPost then
    Result:=EseguiMetodoRest(url,'json','POST',PostData)
  else if locMetodoRest = mrPut then
    Result:=EseguiMetodoRest(url,'json','PUT',PostData);
  RegistraMsg.InserisciMessaggio('I',Format('Fine cancellazione giustificativo:%s',[Result]),Parametri.Azienda,B021Progressivo);
end;

function TB021FWebSvcClientDtM.LeggiTurniPianificati:String;
var {Res,}url,MetodoStr:String;
begin
  Result:='';
  //url:='http://62.149.218.212:8080/hsacomo/rest/calendar/list/v1/:MATRICOLA?start=to_char(:dal,''dd-mm-yyyy'')&end=to_char(:al,''dd-mm-yyyy'')';
  //url:='http://62.149.218.212:8080/hsacomo/rest/calendar/list/v1/'||:MATRICOLA||'?start='||to_char(:DAL'dd-mm-yyyy')||'&end='||to_char(:AL,'dd-mm-yyyy')';
  url:=Parametri.CampiRiferimento.C30_WebSrv_A025_URL_GET;
  if Pos('''',url) > 0 then
    url:=ValutaExprSQL(url);
  MetodoStr:='GET';
  RegistraMsg.InserisciMessaggio('I',Format('Chiamata:%s - Servizio:%s',[MetodoStr,url]),Parametri.Azienda,B021Progressivo);
  Result:=EseguiMetodoRest(url,'json',MetodoStr,'');
end;

function TB021FWebSvcClientDtM.ValutaExprSQL(ExprDati:String):String;
var
  ExprDatiUpper: String;
  // MONDOEDP - commessa MAN/07 SVILUPPO#52.ini
  HashStaffRoster: String;
  UnixTimeOraAttuale: Int64;
  OraAttuale: TDateTime;
  UTC:TSystemTime;
  // MONDOEDP - commessa MAN/07 SVILUPPO#52.fine
begin
  Result:='';
  ExprDatiUpper:=UpperCase(ExprDati);
  with scrGetDati do
  begin
    SQL.Clear;
    DeleteVariables;
    SQL.Add('begin');
    SQL.Add(Format('  select %s into :result from dual;',[ExprDati]));
    SQL.Add('end;');
    DeclareVariable('RESULT',otString);
    if Pos(':PROGRESSIVO',ExprDatiUpper) > 0 then
      DeclareAndSet('PROGRESSIVO',otInteger,B021Progressivo);
    if Pos(':MATRICOLA',ExprDatiUpper) > 0 then
      DeclareAndSet('MATRICOLA',otString,B021Matricola);
    if Pos(':CAUSALE',ExprDatiUpper) > 0 then
      DeclareAndSet('CAUSALE',otString,B021Causale);
    if Pos(':DATA',ExprDatiUpper) > 0 then
      DeclareAndSet('DATA',otDate,B021Data);
    if Pos(':DALLE',ExprDatiUpper) > 0 then
      DeclareAndSet('DALLE',otString,B021Dalle);
    if Pos(':ALLE',ExprDatiUpper) > 0 then
      DeclareAndSet('ALLE',otString,B021Alle);
    if (Pos(':DAL',ExprDatiUpper) > 0) and (Pos(':DAL',ExprDatiUpper) <> Pos(':DALLE',ExprDatiUpper)) then
      DeclareAndSet('DAL',otDate,B021Dal);
    if (Pos(':AL',ExprDatiUpper) > 0) and (Pos(':AL',ExprDatiUpper) <> Pos(':ALLE',ExprDatiUpper)) then
      DeclareAndSet('AL',otDate,B021Al);
    if Pos(':TIPOGIUST',ExprDatiUpper) > 0 then
      DeclareAndSet('TIPOGIUST',otString,B021TipoGiust);
    if Pos(':FAMILIARE',ExprDatiUpper) > 0 then
      DeclareAndSet('FAMILIARE',otDate,B021DataFamiliare);
    if Pos(':AUTORIZZATORE',ExprDatiUpper) > 0 then
      DeclareAndSet('AUTORIZZATORE',otString,Autorizzatore);
    if (Pos(':ANOMALIA',ExprDatiUpper) > 0) then
      DeclareAndSet('ANOMALIA',otString,B021Anomalia);
    if (Pos(':RICHIESTA',ExprDatiUpper) > 0) then
      DeclareAndSet('RICHIESTA',otString,B021Richiesta);
    // MONDOEDP - commessa MAN/07 SVILUPPO#52.ini
    // gestione autenticazione firlab
    // ora in formato unix time
    //OraAttuale:=Now;
    GetSystemTime(UTC);
    OraAttuale:=SystemTimeToDateTime(UTC);
    UnixTimeOraAttuale:=DateTimeToUnix(OraAttuale);
    if (Pos(':UNIXTIME',ExprDatiUpper) > 0) then
    begin
      // lo vogliono in formato string (cfr. documento TECH-ServiziWebREST-041013-1312-61.pdf)
      //DeclareAndSet('UNIXTIME',otInteger,UnixTimeOraAttuale);
      DeclareAndSet('UNIXTIME',otString,IntToStr(UnixTimeOraAttuale));
    end;
    // hash per staffroster = sha1(unixtime + password condivisa)
    if (Pos(':HASH_SR',ExprDatiUpper) > 0) then
    begin
      HashStaffRoster:=R180Sha1Encrypt(Format('%d%s',[UnixTimeOraAttuale,FIRLAB_SHARED_PWD]));
      DeclareAndSet('HASH_SR',otString,HashStaffRoster);
    end;
    // MONDOEDP - commessa MAN/07 SVILUPPO#52.fine
    try
      Execute;
      Result:=GetVariable('RESULT');
    except
      on E:Exception do
        raise Exception.Create('Errore nell''esecuzione di ' + ExprDati + ': ' + E.Message);
    end;
  end;
end;

function TB021FWebSvcClientDtM.EseguiMetodoRest(Url, PFormat, PMetodo, PRequest: String): String;
var
  RBody: TStringStream;
  lstString:TStringList;
  m: String;
begin
  RBody:=TStringStream.Create(AnsiString(PRequest));
  lstString:=TStringList.Create;
  try
    // per far vedere a Fiddler la richiesta
    (*
    if chkFiddler.Checked then
    begin
      IdHTTP1.ProxyParams.ProxyServer:='127.0.0.1';
      IdHTTP1.ProxyParams.ProxyPort:=8888;
    end
    else
    *)
    begin
      IdHTTP1.ProxyParams.ProxyServer:='';
      IdHTTP1.ProxyParams.ProxyPort:=0;
    end;
    if UpperCase(PMetodo) = 'GET' then
    begin
      IdHTTP1.Request.Accept:='';
      IdHTTP1.Request.ContentType:='';
    end
    else
    begin
      if PFormat = 'json' then
      begin
        //IdHTTP1.Request.Accept:='text/javascript';
        IdHTTP1.Request.Accept:='application/json';
        IdHTTP1.Request.ContentType:='application/json';
        //IdHTTP1.Request.ContentEncoding:='utf-8';
      end
      else if PFormat = 'xml' then
      begin
        IdHTTP1.Request.Accept:='text/xml';
        IdHTTP1.Request.ContentType:='text/xml';
        IdHTTP1.Request.ContentEncoding:='utf-8';
      end
      else
      begin
        IdHTTP1.Request.Accept:='text/plain';
        IdHTTP1.Request.ContentType:='text/plain';
        IdHTTP1.Request.ContentEncoding:='utf-8';
      end;
    end;

    //IdHTTP1.Request.BasicAuthentication := True;
    //IdHTTP1.Request.Authentication := TIdBasicAuthentication.Create;
    //IdHTTP1.Request.Authentication.Username := 'admin';
    //IdHTTP1.Request.Authentication.Password := 'admin';
    //Result:=IdHTTP1.Post(UrlThread,RBody);

    lstString.Add(PRequest);

    m:=UpperCase(PMetodo);
    if m = 'GET' then
      Result:=IdHTTP1.Get(Url)
    else if m = 'POST' then
      Result:=IdHTTP1.Post(Url,RBody)
    else if m = 'PUT' then
      Result:=IdHTTP1.Put(Url,RBody)
    else if m = 'DELETE' then
    begin
      IdHTTP1.Delete(Url);
      Result:=''; // non ritorna niente, inserimento di un valore vuoto
    end;
  finally
    try FreeAndNil(RBody); except end;
    try FreeAndNil(lstString); except end;
  end;
end;

procedure TB021FWebSvcClientDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(RegistraMsg);
end;

end.
