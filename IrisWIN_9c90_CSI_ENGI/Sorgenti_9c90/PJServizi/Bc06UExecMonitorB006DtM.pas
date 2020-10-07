unit Bc06UExecMonitorB006DtM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, OracleData, System.StrUtils, Oracle,
  Bc06UClassi, C180FunzioniGenerali, A000UInterfaccia, A000UCostanti, C017UEMailDtM,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP, IdMessage,
  IdAttachmentMemory;

type
  TBc06FExecMonitorB006DtM = class(TDataModule)
    insI192: TOracleQuery;
    selI192: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    MySMTP:TIdSMTP;
    MyOpenSSL:TIdSSLIOHandlerSocketOpenSSL;
    function CheckConfIstanza(ConfIstanza:TConfIstanza):String;
    function CheckPeriodoNoMonitor(ConfIstanza:TConfIstanza):Boolean;
    procedure EseguiSqlEstraiLog(SQL:String; ListaLog:TStringList; ConfIstanza:TConfIstanza);
    function GetTipoCriptazione(ConfServizio:TConfServizio):TIdSSLVersion;
    procedure ConnettiSMTP(ConfServizio:TConfServizio);
  public
    Bc06SessioneOracle:TOracleSession;
    function CheckOrarioValido(Orario:String):Boolean; // Usata anche da Bc06UMonitorB006DtM
    function CreaSessioneOracle(Database,Password:String):TOracleSession; // Crea una nuova sessione con utente MONDOEDP
    function EffettuaControllo(ConfIstanza:TConfIstanza):TEsitoControllo;
    function RegistraLogEsito(EsitoControllo:TEsitoControllo):String;
    function GestisciNotificheMail(ConfServizio:TConfServizio;
                                   ConfIstanza:TConfIstanza;
                                   EsitoControllo:TEsitoControllo):String;
    function InviaMailNotifica(ConfServizio:TConfServizio;
                               ConfIstanza:TConfIstanza;
                               EsitoControllo:TEsitoControllo):String;
  end;

var
  Bc06FExecMonitorB006DtM: TBc06FExecMonitorB006DtM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TBc06FExecMonitorB006DtM.DataModuleCreate(Sender: TObject);
var
  i:Integer;
begin
  // La sessione Oracle DEVE essere già inizializzata, non si scappa. Viene istanziata
  // all'avvio ed è collegata al DB di configurazione e log (non quelli da controllare)
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  MySMTP:=nil;
end;

function TBc06FExecMonitorB006DtM.CheckOrarioValido(Orario:String):Boolean;
begin
  Result:=False;
  try
    Result:=OreMinutiValidate(Orario);
    if Result then
    begin
      // La stringa è nel formato hh.mm. mm sappiamo già essere un numero < 60.
      // hh è un numero < 24 ?
      Result:=StrToInt(Copy(Orario,1,2)) < 24; // Se hh non è numerico salto nell'except
    end;
  except
    on E:Exception do
    begin
      Result:=False;
    end;
  end;
end;

function TBc06FExecMonitorB006DtM.CreaSessioneOracle(Database,Password:String):TOracleSession;
var
  NuovaSessione:TOracleSession;
begin
  NuovaSessione:=TOracleSession.Create(nil);
  try
    NuovaSessione.LogonUserName:=R180Decripta(DB_LOGON_USERNAME,SALT_CRIPTA);
    if Length(Password) > 0 then
      NuovaSessione.LogonPassword:=R180Decripta(Password,SALT_CRIPTA)
    else
      NuovaSessione.LogonPassword:=A000PasswordFissa;
    NuovaSessione.LogonDatabase:=DataBase;
    NuovaSessione.Preferences.UseOci7:=False;
    Result:=NuovaSessione;
  except
    on E:Exception do
    begin
      FreeAndNil(NuovaSessione);
      raise Exception.Create('Errore durante la creazione della sessione Oracle: ' + E.Message);
    end;
  end;
end;

function TBc06FExecMonitorB006DtM.CheckConfIstanza(ConfIstanza:TConfIstanza):String;
begin
  Result:='';
  if Trim(ConfIstanza.DataBase) = '' then
    Result:='Database non specificato.'
  else if Oracle.OracleAliasList.IndexOf(ConfIstanza.DataBase) = -1 then
    Result:='Database inesistente.'
  else if Trim(ConfIstanza.QueryServizioConnesso) = '' then
    Result:='Query per il controllo del servizio non specificata.'
  else if ((ConfIstanza.NoMonitorDalle = '') and (ConfIstanza.NoMonitorAlle <> '') or
           (ConfIstanza.NoMonitorDalle <> '') and (ConfIstanza.NoMonitorAlle = '')) then
    Result:='Orari di esclusione controllo (no monitor) non valorizzati correttamente.'
  else if ((ConfIstanza.NoMonitorDalle <> '') and (ConfIstanza.NoMonitorAlle <> '')) and
          (not CheckOrarioValido(ConfIstanza.NoMonitorDalle) or not CheckOrarioValido(ConfIstanza.NoMonitorAlle)) then
    Result:='Orari di esclusione controllo (no monitor) non validi.';
end;

{ Verifica se procedere al controllo in base agli orari specificati in NoMonitorDalle e NoMonitorAlle.
  Ritorna true se il l'ora attuale è esterna all'intervallo (controllo da eseguire), false altrimenti
  (controllo da saltare) }
function TBc06FExecMonitorB006DtM.CheckPeriodoNoMonitor(ConfIstanza:TConfIstanza):Boolean;
var
  NoMonDalleMin,NoMonAlleMin,NowMin:Integer; // in minuti
begin
  // I parametri sono già consistenti
  Result:=True;
  if ConfIstanza.NoMonitorDalle = '' then // Nessun intervallo specificato
    Exit;

  NoMonDalleMin:=R180OreMinuti(ConfIstanza.NoMonitorDalle);
  NoMonAlleMin:=R180OreMinuti(ConfIstanza.NoMonitorAlle);
  if NoMonDalleMin = NoMonAlleMin then
  begin
    // Lo leggo come: escludi controlli dall'ora x fino alla stessa ora del giorno successivo.
    // Ovvero sempre.
    Result:=False;
  end
  else if NoMonDalleMin < NoMonAlleMin then
  begin
    // L'intervallo è nello stesso giorno.
    NowMin:=R180OreMinuti(Time);
    Result:=(NowMin < NoMonDalleMin) or (NowMin > NoMonAlleMin);
  end
  else
  begin
    // L'ora di fine si riferisce a domani.
    NowMin:=R180OreMinuti(Time);
    Result:=(NowMin > NoMonAlleMin) and (NowMin < NoMonDalleMin);
  end;
end;



{ Esegue la query SQL e popola ListaLog con i risultati. }
procedure TBc06FExecMonitorB006DtM.EseguiSqlEstraiLog(SQL:String; ListaLog:TStringList; ConfIstanza:TConfIstanza);
var
  OracleQuery:TOracleQuery;
  NumRigheEstratte:Integer;
  EstraiTutto:Boolean;
begin
  OracleQuery:=TOracleQuery.Create(nil);
  try
    try
      OracleQuery.Session:=Bc06SessioneOracle;
      if SQL <> '' then
      begin
        OracleQuery.SQL.Text:=SQL;
        OracleQuery.ReadBuffer:=5000;
        if Pos(':' + NOME_VAR_MSG_ELABORAZIONI_GG,SQL) > 1 then
        begin
          OracleQuery.DeclareVariable(NOME_VAR_MSG_ELABORAZIONI_GG,otInteger);
          OracleQuery.SetVariable(NOME_VAR_MSG_ELABORAZIONI_GG,ConfIstanza.MsgElaborazioniGG);
        end;
        if Pos(':' + NOME_VAR_MSG_ELABORAZIONI_RIGHE,SQL) > 0 then
        begin
          OracleQuery.DeclareVariable(NOME_VAR_MSG_ELABORAZIONI_RIGHE,otInteger);
          if ConfIstanza.MsgElaborazioniRighe <= -1 then
            OracleQuery.SetVariable(NOME_VAR_MSG_ELABORAZIONI_RIGHE,99999999)
          else
            OracleQuery.SetVariable(NOME_VAR_MSG_ELABORAZIONI_RIGHE,ConfIstanza.MsgElaborazioniRighe);
        end;
        try
          RegistraMsg.InserisciMessaggio('I',Format('[%s] Esecuzione query estrazione msg: %s',
                                                    [ConfIstanza.DataBase,SQL]));
          OracleQuery.Execute;
          RegistraMsg.InserisciMessaggio('I',Format('[%s] Query eseguita',[ConfIstanza.DataBase]));
        except
          on E:Exception do
          begin
            RegistraMsg.InserisciMessaggio('A',Format('[%s] Errore durante l''esecuzione della query: %s',[ConfIstanza.DataBase,E.Message]));
            ListaLog.Add(Format('Impossibile eseguire la query di estrazione' + CRLF + '%s' + CRLF + '%s',
                                [SQL,E.Message]));
            Exit;
          end;
        end;

        RegistraMsg.InserisciMessaggio('I',Format('[%s] Estrazione dei messaggi... (MSG_ELABORAZIONI_RIGHE=%d)',
                                                  [ConfIstanza.DataBase,ConfIstanza.MsgElaborazioniRighe]));
        EstraiTutto:=(ConfIstanza.MsgElaborazioniRighe = -1);
        NumRigheEstratte:=0;
        // Estraggo la prima colonna, considerando l'eventuale limite di righe
        while (OracleQuery.Eof = False) and (EstraiTutto or (NumRigheEstratte < ConfIstanza.MsgElaborazioniRighe)) do
        begin
          ListaLog.Add(OracleQuery.FieldAsString(0));
          OracleQuery.Next;
          Inc(NumRigheEstratte);
        end;
        RegistraMsg.InserisciMessaggio('I',Format('[%s] OK',[ConfIstanza.DataBase]));
      end;
    except
     on E:Exception do
      begin
        // Errore inatteso durante l'estrazione.
        RegistraMsg.InserisciMessaggio('A',Format('[%s] Errore durante l''estrazione: %s',[ConfIstanza.Database,E.Message]));
        ListaLog.Text:=Format('Errore durante l''estrazione dei log (query 1): %s',[E.Message]);
      end;
    end;
  finally
    FreeAndNil(OracleQuery);
  end;
end;

function TBc06FExecMonitorB006DtM.EffettuaControllo(ConfIstanza:TConfIstanza):TEsitoControllo;
var
  CheckStr,TestoMsg:String;
  Continua:Boolean;
  OracleQuery:TOracleQuery;
begin
  RegistraMsg.InserisciMessaggio('I',Format('[%s] Esecuzione controllo...',[ConfIstanza.DataBase]));

  try
    if Bc06SessioneOracle <> nil then
    begin
      Bc06SessioneOracle.LogOff;
      FreeAndNil(Bc06SessioneOracle);
    end;
  except
  end;

  OracleQuery:=nil;
  Result:=TEsitoControllo.Create;
  Result.Servizio:=ConfIstanza.Servizio;
  Result.Database:=ConfIstanza.DataBase;
  Result.Esito:=ESITO_ERRORE_GENERICO;
  Result.DescrEsito:='Errore generico';
  Continua:=True;
  try
    RegistraMsg.InserisciMessaggio('I',Format('[%s] Controllo validità configurazione',[ConfIstanza.DataBase]));
    CheckStr:=CheckConfIstanza(ConfIstanza);
    if CheckStr <> '' then
    begin
      Result.Esito:=ESITO_ERRORE_GENERICO;
      Result.DescrEsito:='Configurazione non valida: ' + CheckStr;
      Continua:=False;
    end;

    if Continua then
    begin
      if ConfIstanza.NoMonitorDalle <> '' then
        TestoMsg:=Format('Controllo intervallo di esclusione (%s - %s)...',
                          [ConfIstanza.NoMonitorDalle,ConfIstanza.NoMonitorAlle])
      else
        TestoMsg:='Nessun intervallo di esclusione specificato.';
      RegistraMsg.InserisciMessaggio('I',Format('[%s] %s',[ConfIstanza.DataBase,TestoMsg]));

      if not CheckPeriodoNoMonitor(ConfIstanza) then
      begin
        // Interno ad intervallo di esclusione
        Result.Esito:=ESITO_CONTROLLO_SALTATO; // Uso questo esito per indicare di non aggiornare i risultati
        Result.DescrEsito:='Controllo saltato per intervallo no monitor';
        Continua:=False;
      end;
    end;

    if Continua then
    begin
      // Tento di collegarmi al DB
      RegistraMsg.InserisciMessaggio('I',Format('[%s] Tentativo di connessione a %s...',[ConfIstanza.DataBase, ConfIstanza.DataBase]));
      Bc06SessioneOracle:=CreaSessioneOracle(ConfIstanza.DataBase,ConfIstanza.Password);
      try
        Bc06SessioneOracle.LogOn;
        RegistraMsg.InserisciMessaggio('I',Format('[%s] Connesso',[ConfIstanza.DataBase]));
      except
        on E:Exception do
        begin
          Result.Esito:=ESITO_DB_IRRAGGIUNGIBILE;
          Result.DescrEsito:=Format('Database %s non raggiungibile: %s',[ConfIstanza.DataBase,E.Message]);
          Continua:=False;
        end;
      end;

      if Continua then
      begin
        // Connesso al DB
        OracleQuery:=TOracleQuery.Create(nil);
        OracleQuery.Session:=Bc06SessioneOracle;
        OracleQuery.SQL.Text:=ConfIstanza.QueryServizioConnesso;
        OracleQuery.ReadBuffer:=5000;
        try
          RegistraMsg.InserisciMessaggio('I',Format('[%s] Esecuzione query servizio connesso: %s',
                                                    [ConfIstanza.DataBase,ConfIstanza.QueryServizioConnesso]));
          // Eseguo la query per lo stato del servizio
          OracleQuery.Execute;
          RegistraMsg.InserisciMessaggio('I',Format('[%s] Query eseguita correttamente',[ConfIstanza.DataBase]));
          if OracleQuery.RowCount = 0 then
          begin
            Result.Esito:=ESITO_SERVIZIO_SCOLLEGATO;
            Result.DescrEsito:=Format('Database %s: Servizio %s non connesso',
                                       [ConfIstanza.DataBase,ConfIstanza.Servizio]);
          end
          else
          begin
            Result.Esito:=ESITO_OK;
            Result.DescrEsito:='Servizio attivo';
          end;
        except
          on E:Exception do
          begin
            Result.Esito:=ESITO_ERRORE_SQL_SERVIZIO;
            Result.DescrEsito:='Query connessione non valida: ' + E.Message;
          end;
        end;

        // Indifferentemente dal risultato, eseguiamo le query per estrarre le info dai log
        RegistraMsg.InserisciMessaggio('I',Format('[%s] Lettura messaggi 1...',[ConfIstanza.DataBase]));
        EseguiSqlEstraiLog(ConfIstanza.QueryMsg1,Result.Msg1,ConfIstanza);

        RegistraMsg.InserisciMessaggio('I',Format('[%s] Lettura messaggi 2...',[ConfIstanza.DataBase]));
        EseguiSqlEstraiLog(ConfIstanza.QueryMsg2,Result.Msg2,ConfIstanza);
      end;
    end;
  except
    on Exc:Exception do
    begin
      RegistraMsg.InserisciMessaggio('A',Format('[%s] Errore imprevisto durante il controllo: %s',
                                                [ConfIstanza.DataBase,Exc.Message]));
      Result.Esito:=ESITO_ERRORE_GENERICO;
      Result.DescrEsito:=Exc.Message;
    end;
  end;

  RegistraMsg.InserisciMessaggio('I',Format('[%s] Pulizia e chiusura sessione...',
                                            [ConfIstanza.DataBase]));

  // L'intera operazione è protetta da try. Questo codice sarà eseguito sempre.
  if OracleQuery <> nil then
  begin
    try
      try OracleQuery.Close except end;
      FreeAndNil(OracleQuery);
    except

    end;
  end;

  if Bc06SessioneOracle <> nil then
  begin
    try
      if Bc06SessioneOracle.Connected then
        Bc06SessioneOracle.LogOff;
      FreeAndNil(Bc06SessioneOracle);
    except

    end;
  end;
  Bc06SessioneOracle:=nil;

  TestoMsg:=IfThen(R180In(Result.Esito,[ESITO_OK,ESITO_CONTROLLO_SALTATO]),'I','A');
  RegistraMsg.InserisciMessaggio(TestoMsg,Format('[%s] Fine controllo su %s/%s. Codice di ritorno: %d - Descrizione: %s',
                                                 [ConfIstanza.DataBase,
                                                  ConfIstanza.Servizio,
                                                  ConfIstanza.DataBase,
                                                  Result.Esito,Result.
                                                  DescrEsito]));
end;

function TBc06FExecMonitorB006DtM.RegistraLogEsito(EsitoControllo:TEsitoControllo):String;
begin
  // Loggo le informazioni sullo stato su I192. Il log avviene sul db di default,
  // non su quello su cui ho effettuato il controllo.
  RegistraMsg.InserisciMessaggio('I',Format('[%s] Salvataggio su I192...',[EsitoControllo.Database]));
  Result:='';
  try
    insI192.ClearVariables;
    insI192.SetVariable('SERVIZIO',EsitoControllo.Servizio);
    insI192.SetVariable('DATABASE_NAME',EsitoControllo.DataBase);
    insI192.SetVariable('OPERATORE', Parametri.Operatore);
    insI192.SetVariable('HOSTNAME', Parametri.HostName);
    insI192.SetVariable('HOSTIPADDRESS', Parametri.HostIPAddress);
    insI192.SetVariable('STATO',IntToStr(EsitoControllo.Esito));
    insI192.SetVariable('MSG',EsitoControllo.DescrEsito);
    insI192.Execute;
    SessioneOracle.Commit;
    Result:='OK';
    RegistraMsg.InserisciMessaggio('I',Format('[%s] Salvataggio effettuato con successo',[EsitoControllo.Database]));
  except
    on Exc:Exception do
    begin
      Result:=Exc.Message;
      RegistraMsg.InserisciMessaggio('A',Format('[%s] Salvataggio fallito: %s',[EsitoControllo.Database,Exc.Message]));
    end;
  end;
end;

{ In base all'esito del controllo e allo storico dei controlli passati, invia una mail di notifica
  se necessario. }
function TBc06FExecMonitorB006DtM.GestisciNotificheMail(ConfServizio:TConfServizio;
                                                        ConfIstanza:TConfIstanza;
                                                        EsitoControllo:TEsitoControllo):String;

begin
  Result:='Errore generico';
  try
    try
      //if EsitoControllo.Esito = ESITO_CONTROLLO_SALTATO then
      if not R180In(EsitoControllo.Esito,[ESITO_OK,ESITO_DB_IRRAGGIUNGIBILE,ESITO_SERVIZIO_SCOLLEGATO]) then
      begin
        Result:='';
        RegistraMsg.InserisciMessaggio('I',Format('[%s] %s, non è necessario inviare alcun messaggio',[EsitoControllo.Database,EsitoControllo.DescrEsito]));
        Exit; // Nessun messaggio
      end;
      if Trim(ConfIstanza.EMailMittente) = '' then
      begin
        Result:='Mail mittente non impostato';
        RegistraMsg.InserisciMessaggio('A',Format('[%s] Mail mittente non impostato',[EsitoControllo.Database]));
        Exit;
      end;
      if (Trim(ConfIstanza.EMailDestinatari) = '') and (Trim(ConfIstanza.EMailDestinatariCC) = '') then
      begin
        RegistraMsg.InserisciMessaggio('A',Format('[%s] Nessuna mail destinatari impostata',[EsitoControllo.Database]));
        Result:='Nessun destinatario specificato.';
        Exit;
      end;
      if Trim(ConfServizio.SMTPHost) = '' then
      begin
        RegistraMsg.InserisciMessaggio('A',Format('[%s] Server di posta non impostato',[EsitoControllo.Database]));
        Result:='Server di posta non impostato';
        Exit;
      end;


      selI192.Close;
      //Leggo solo gli ultimi 5 records, in realtà mi basta l'ultimo
      selI192.ReadBuffer:=5;
      selI192.ClearVariables;
      selI192.SetVariable('SERVIZIO',EsitoControllo.Servizio);
      selI192.SetVariable('DATABASE',EsitoControllo.Database);
      selI192.Open;
      if selI192.RecordCount > 0 then
      begin
        // Che risultato aveva restituito l'ultimo controllo?
        if selI192.FieldByName('STATO').AsInteger <> EsitoControllo.Esito then
        begin
          // Stato cambiato. Può essere che si è passati da OK ad uno stato di errore, o che
          // l'errore sia cambiato (es. da "query non valida" a "servizio scollegato")
          ConnettiSMTP(ConfServizio);
          Result:=InviaMailNotifica(ConfServizio,ConfIstanza,EsitoControllo);
        end
        else
        begin
          // Nessun invio necessario.
          RegistraMsg.InserisciMessaggio('I',Format('[%s] Nessun cambiamento allo stato del servizio, nessuna mail inviata',
                                                    [ConfIstanza.Database]));
          Result:='';
        end;
      end
      else
      begin
        ConnettiSMTP(ConfServizio);
        Result:=InviaMailNotifica(ConfServizio,ConfIstanza,EsitoControllo);
      end;
    except
      on E:Exception do
      begin
        RegistraMsg.InserisciMessaggio('A',Format('[%s] Errore durante la gestione delle notifiche mail: %s',
                                                   [EsitoControllo.Database,E.Message]));
        Result:=Format('Gestione notifica mail fallita: %s',[E.Message]);
      end;
    end;
  finally
    if MySMTP <> nil then
    begin
      MySMTP.Disconnect;
      FreeAndNil(MySMTP);
    end;
    selI192.Close;
    selI192.ClearVariables;
  end;
end;

{ Invia una mail ai destinatari specificati nella configurazione che riporta l'esito del
  controllo }
function TBc06FExecMonitorB006DtM.InviaMailNotifica(ConfServizio:TConfServizio;
                                                    ConfIstanza:TConfIstanza;
                                                    EsitoControllo:TEsitoControllo):String;
var
  MyMessage:TIdMessage;
  Oggetto,Testo:String;
  CurrAttach:TIdAttachmentMemory;
begin       // TODO constantizzare le stringhe di default
  RegistraMsg.InserisciMessaggio('I',Format('[%s] Inizio invio mail',[ConfIstanza.Database]));
  Result:='Errore generico';
  MyMessage:=TIdMessage.Create(nil);
  try
    try
      if EsitoControllo.Esito = ESITO_CONTROLLO_SALTATO then
        Exit; // Nessun messaggio

      if EsitoControllo.Esito = ESITO_OK then
      begin
        Oggetto:=Format('Servizio %s su %s regolarmente attivo',[ConfIstanza.Servizio,ConfIstanza.DataBase]);
        Testo:=Format('Si informa che il servizio %s è ora connesso al database %s.',
                      [ConfIstanza.Servizio,ConfIstanza.DataBase]);
      end
      else
      begin
        Oggetto:=Format('Errore servizio %s su %s',[ConfIstanza.Servizio,ConfIstanza.DataBase]);
        Testo:=Format('Il controllo sullo stato servizio %s sul database %s ha dato esito negativo' + CRLF + CRLF +
                      'E'' stato restituito il seguente errore: ' + CRLF + CRLF +
                      TAB + '%s (codice %d)',
                      [ConfIstanza.Servizio,ConfIstanza.DataBase,EsitoControllo.DescrEsito,EsitoControllo.Esito]);
      end;

      MyMessage.CharSet:='ISO-8859-15';
      MyMessage.ConvertPreamble:=True;
      MyMessage.Encoding:=meMIME;
      MyMessage.AttachmentEncoding:='MIME';
      MyMessage.UseNowForDate:=True;
      MyMessage.ContentType:='multipart/mixed';
      MyMessage.From.Address:=ConfIstanza.EMailMittente;
      MyMessage.From.Name:=Format('Bc06 %s/%s',[ConfIstanza.Servizio,ConfIstanza.DataBase]);
      MyMessage.BccList.Clear;
      MyMessage.Recipients.Clear;
      MyMessage.CCList.Clear;
      MyMessage.Recipients.EMailAddresses:=ConfIstanza.EMailDestinatari;
      MyMessage.CCList.EMailAddresses:=ConfIstanza.EMailDestinatariCC;
      MyMessage.Subject:=Oggetto;
      MyMessage.MessageParts.Clear;
      MyMessage.Body.Text:=Testo;

      if EsitoControllo.Msg1.Count > 0 then
      begin
        CurrAttach:=TIdAttachmentMemory.Create(MyMessage.MessageParts,EsitoControllo.Msg1.Text);
        CurrAttach.ContentType:='text/plain';
        CurrAttach.FileName:='Messaggi elaborazione 1.txt';
      end;
      if EsitoControllo.Msg2.Count > 0 then
      begin
        CurrAttach:=TIdAttachmentMemory.Create(MyMessage.MessageParts,EsitoControllo.Msg2.Text);
        CurrAttach.ContentType:='text/plain';
        CurrAttach.FileName:='Messaggi elaborazione 2.txt';
      end;

      RegistraMsg.InserisciMessaggio('I',Format('[%s] Invio mail, destinatari: %s / destinatari CC: %s',
                                         [ConfIstanza.Database,ConfIstanza.EMailDestinatari,ConfIstanza.EMailDestinatariCC]));
      try
        MySMTP.Send(MyMessage);
        Result:='OK';
        RegistraMsg.InserisciMessaggio('I',Format('[%s] Mail inviata correttamente',[ConfIstanza.Database]));
      except
        on E:Exception do
        begin
          RegistraMsg.InserisciMessaggio('A',Format('[%s] Errore durante l''invio della mail: %s',
                                                    [ConfIstanza.Database,E.Message]));
          raise Exception.Create(Format('impossibile inviare la mail, %s',[E.Message]));
        end;
      end;
    except
      on E:Exception do
      begin
        RegistraMsg.InserisciMessaggio('A',Format('[%s] Errore durante la composizione/invio della mail: %s',
                                                    [ConfIstanza.Database,E.Message]));
        Result:=Format('Errore durante la composizione/invio della mail di notifica: %s',[E.Message]);
      end;
    end;
  finally
    FreeAndNil(MyMessage);
  end;
end;

function TBc06FExecMonitorB006DtM.GetTipoCriptazione(ConfServizio:TConfServizio):TIdSSLVersion;
begin
  Result:=sslvTLSv1;
  if ConfServizio.SMTPAuthType = 'TLSv1_1' then
    Result:=sslvTLSv1_1
  else if ConfServizio.SMTPAuthType = 'TLSv1_2' then
    Result:=sslvTLSv1_2
  else if ConfServizio.SMTPAuthType = 'SSLv2' then
    Result:=sslvSSLv2
  else if ConfServizio.SMTPAuthType = 'SSLv23' then
    Result:=sslvSSLv23
  else if ConfServizio.SMTPAuthType = 'SSLv3' then
    Result:=sslvSSLv3;
end;

procedure TBc06FExecMonitorB006DtM.ConnettiSMTP(ConfServizio:TConfServizio);
begin
  if MySMTP <> nil then
  begin
    MySMTP.Disconnect;
    FreeAndNil(MySMTP);
  end;
  MySMTP:=TIdSMTP.Create(nil);
  MySMTP.Port:=ConfServizio.SMTPPort;
  MySMTP.Host:=ConfServizio.SMTPHost;
  MySMTP.IOHandler:=nil;
  //MySMTP.Connect;
  MySMTP.AuthType:=satDefault;
  if (ConfServizio.SMTPAuthType <> '') and
     (ConfServizio.SMTPAuthType <> 'No autenticazione') then
  begin
    MySMTP.IOHandler:=TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    with (MySMTP.IOHandler as TIdSSLIOHandlerSocketOpenSSL) do
    begin
      MySMTP.UseEhlo:=False;
      SSLOptions.Method:=GetTipoCriptazione(ConfServizio);
      SSLOptions.RootCertFile:='';
      SSLOptions.Mode:=sslmUnassigned;
      SSLOptions.VerifyMode:=[];
      SSLOptions.VerifyDepth:=0;
      ConnectTimeout:=0;
    end;
    MySMTP.UseTLS:=utUseImplicitTLS;
    if ConfServizio.SMTPPort = 587 then
      MySMTP.UseTLS:=utUseExplicitTLS;
  end;
  MySMTP.Connect;
  MySMTP.Username:=ConfServizio.SMTPUserName;
  MySMTP.Password:=R180Decripta(ConfServizio.SMTPPassword,SALT_CRIPTA);
end;

procedure TBc06FExecMonitorB006DtM.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  if MySMTP <> nil then
  begin
    MySMTP.Disconnect;
    FreeAndNil(MySMTP);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).CloseAll;
    if Self.Components[i] is TOracleQuery then
      (Self.Components[i] as TOracleQuery).Close;
  end;
end;

end.
