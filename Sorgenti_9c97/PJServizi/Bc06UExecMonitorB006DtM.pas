unit Bc06UExecMonitorB006DtM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, OracleData, System.StrUtils, Oracle,
  Variants, System.Generics.Collections, Vcl.Controls, Vcl.ExtCtrls,
  Bc06UClassi, C180FunzioniGenerali, R004UGestStoricoDTM,
  A000USessione, A000UInterfaccia, A000UCostanti, C017UEMailDtM, RegistrazioneLog,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP, IdMessage,
  IdAttachmentMemory, Datasnap.DBClient,

  Vcl.Forms, Dialogs, Math;

type
  TBc06FExecMonitorB006DtM = class(TDataModule)
    insI192: TOracleQuery;
    selI192: TOracleDataSet;
    cdsInfoControlli: TClientDataSet;
    cdsInfoControlliID: TIntegerField;
    cdsInfoControlliSERVIZIO: TStringField;
    cdsInfoControlliDATABASE: TStringField;
    cdsInfoControlliINTERVALLO: TStringField;
    cdsInfoControlliESITO_CONTROLLO: TIntegerField;
    cdsInfoControlliD_ESITO_CONTROLLO: TStringField;
    cdsInfoControlliDATA_ULT_CONTROLLO: TStringField;
    cdsInfoControlliDESC_ESITO_CONTROLLO: TStringField;
    cdsInfoControlliF_Utente: TBooleanField;
    cdsInfoControlliF_DataI: TDateTimeField;
    cdsInfoControlliF_DataF: TDateField;
    cdsInfoControlliF_Tipo: TIntegerField;
    cdsInfoControlliF_Azienda: TIntegerField;
    cdsInfoControlliLstAziende: TStringField;
    selI190: TOracleDataSet;
    selI190ID: TIntegerField;
    selI190SERVIZIO: TStringField;
    selI190INTERVALLO_MONITOR: TStringField;
    selI190EMAIL_SMTP_HOST: TStringField;
    selI190EMAIL_SMTP_PORT: TIntegerField;
    selI190EMAIL_SMTP_USERNAME: TStringField;
    selI190EMAIL_SMTP_PASSWORD: TStringField;
    selI190EMAIL_AUTH_TYPE: TStringField;
    selI190D_EMAIL_SMTP_PASSWORD: TStringField;
    selI191: TOracleDataSet;
    selI191ID: TIntegerField;
    selI191DATABASE_NAME: TStringField;
    selI191CONNESSIONE_PWD: TStringField;
    selI191QUERY_SERVIZIO_CONNESSO: TStringField;
    selI191QUERY_MSG1: TStringField;
    selI191QUERY_MSG2: TStringField;
    selI191NO_MONITOR_DALLE: TStringField;
    selI191NO_MONITOR_ALLE: TStringField;
    selI191MSG_ELABORAZIONI_GG: TIntegerField;
    selI191MSG_ELABORAZIONI_RIGHE: TIntegerField;
    selI191EMAIL_MITTENTE: TStringField;
    selI191EMAIL_DESTINATARI: TStringField;
    selI191EMAIL_DESTINATARI_CC: TStringField;
    selI191D_CONNESSIONE_PWD: TStringField;
    selI191D_CONNESSIONE_PWD_DECRYPT: TStringField;
    selI191MONITOR_BC06SRV: TStringField;
    cdsInfoControlliMONITOR_BC06SRV: TStringField;
    procedure ApriSelI191; //override;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selI190AfterScroll(DataSet: TDataSet);
    procedure selI190CalcFields(DataSet: TDataSet);
    procedure selI190BeforeInsert(DataSet: TDataSet);
    procedure selI191CalcFields(DataSet: TDataSet);
    procedure selI191NewRecord(DataSet: TDataSet);
    procedure selI191BeforePost(DataSet: TDataSet);
    procedure selI191AfterPost(DataSet: TDataSet);
    procedure selI191BeforeInsert(DataSet: TDataSet);
    procedure selI191MSG_ELABORAZIONI_GGValidate(Sender: TField);
    procedure selI191MSG_ELABORAZIONI_RIGHEValidate(Sender: TField);
    procedure selI191NO_MONITOR_ALLEValidate(Sender: TField);
    procedure selI191NO_MONITOR_DALLEValidate(Sender: TField);
    procedure selI191MONITOR_BC06SRVValidate(Sender: TField);

  private
    MySMTP:TIdSMTP;
    MyOpenSSL:TIdSSLIOHandlerSocketOpenSSL;
    //LocalOracleAliasList:TStringList;
    SessioneOracleI191:TOracleSession;//Bc06SessioneOracle
    function CheckConfIstanza(ConfIstanza:TConfIstanza):String;
    function CheckPeriodoNoMonitor(ConfIstanza:TConfIstanza):Boolean;
    function GetTipoCriptazione(ConfServizio:TConfServizio):TIdSSLVersion;
    function InviaMailNotifica(pConfServizio:TConfServizio;
                               pConfIstanza:TConfIstanza;
                               pEsitoControllo:TEsitoControllo):String;
    function TestQuery(SQL:String;TQSessioneOracle:TOracleSession):String;

    procedure ConnettiSMTP(ConfServizio:TConfServizio);
    procedure EseguiSqlEstraiLog(SQL:String; ListaLog:TStringList; ConfIstanza:TConfIstanza; pFiltroU: String);
    procedure EseguiSqlEstraiAziende(ListaAziende:TStringList; ConfIstanza:TConfIstanza);
    function EffettuaControllo(ConfIstanza:TConfIstanza; pFiltroU:String):TEsitoControllo;

  public
    MonitorAttivo:Boolean;
    Configurazione:TConfGenerale; // Contiene una mappa ID Servizio -> TConfServizio
    MsgControlli:TObjectDictionary<Integer,TMsgControlloIstanza>; // Mappa num. riga cdsInfoControlli -> TMsgControlloIstanza
    ListaEmailAuthType:TStringList;
    LocalOracleAliasList:TStringList;
    SessioneOracleBc06:TOracleSession;
    RegistraMsg:TRegistraMsg;
    TipoModulo: String;
    function ConnettiDataBase(Alias:String):Boolean;
    function  ControlloConnessioneDatabase:Boolean;
    procedure selI190BeforePost(DataSet: TDataSet);
    function CheckOrarioValido(Orario:String):Boolean; // Usata anche da Bc06UMonitorB006DtM
    function CreaSessioneOracle(Database,Password:String):TOracleSession; // Crea una nuova sessione con utente MONDOEDP
    function GestisciNotificheMail(ConfServizio:TConfServizio;
                                   ConfIstanza:TConfIstanza;
                                   EsitoControllo:TEsitoControllo):String;
    function LanciaControllo(pConfServizio:TConfServizio;pConfIstanza:TConfIstanza;optFiltroU: string = ''): TStringList;
    function RegistraLogEsito(EsitoControllo:TEsitoControllo):String;

    procedure LeggiConfigurazione;

  const
    ModuloClientServer = 'CS';
    ModuloServizio =    'SRV';
  end;

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
      (Components[i] as TOracleQuery).Session:=SessioneOracleBc06;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracleBc06;
    end;

  TipoModulo:=ModuloClientServer; //Client-Server -> Saranno controllati tutti i DB
  RegistraMsg:=TRegistraMsg.Create(SessioneOracleBc06);

  MySMTP:=nil;

  LocalOracleAliasList:=TStringList.Create;
  LocalOracleAliasList.Assign(Oracle.OracleAliasList);
  LocalOracleAliasList.CaseSensitive:=False;

  ListaEmailAuthType:=TStringList.Create;
  ListaEmailAuthType.Add('No autenticazione');
  ListaEmailAuthType.Add('TLSv1_1');
  ListaEmailAuthType.Add('TLSv1_2');
  ListaEmailAuthType.Add('SSLv2');
  ListaEmailAuthType.Add('SSLv23');
  ListaEmailAuthType.Add('SSLv3');

  Configurazione:=nil;
  MsgControlli:=nil;
  cdsInfoControlli.CreateDataSet;
end;

function TBc06FExecMonitorB006DtM.ConnettiDataBase(Alias:String): Boolean;
begin
  selI190.Session:=SessioneOracleBc06;
  selI191.Session:=SessioneOracleBc06;
  selI192.Session:=SessioneOracleBc06;
  insI192.Session:=SessioneOracleBc06;

  if not SessioneOracleBc06.Connected then
  begin
    SessioneOracleBc06.LogonDatabase:=Alias;
    A000LogonDBOracle(SessioneOracleBc06);
  end;

  Result:=SessioneOracleBc06.Connected;

  try
    LeggiConfigurazione;
  except
    on E:Exception do
    begin
      RegistraMsg.SessioneOracleApp:=SessioneOracleBc06;
      RegistraMsg.IniziaMessaggio('Bc06');
      RegistraMsg.InserisciMessaggio('A',E.Message);
      Result:=False;
    end;
  end;
end;

function TBc06FExecMonitorB006DtM.ControlloConnessioneDatabase:Boolean;
begin
  try
    if not SessioneOracleBc06.Connected then
    begin
      try
        SessioneOracleBc06.LogOn;
      except
        on E:Exception do
          RegistraMsg.InserisciMessaggio('A',E.Message);
      end;
    end;

    case SessioneOracleBc06.CheckConnection(True) of
      ccError:
      begin
        RegistraMsg.InserisciMessaggio('A','[' + SessioneOracleBc06.LogonDatabase + '] Connessione con Oracle non esistente');
        try
          SessioneOracleBc06.LogOff;
          SessioneOracleBc06.LogOn;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A',E.Message);
        end;
      end;
      ccReconnected:
      begin
      end;
    end;
  except
  end;

  Result:=SessioneOracleBc06.Connected;
  if Result then
  try
    LeggiConfigurazione;
  except
    on E:Exception do
    begin
      RegistraMsg.SessioneOracleApp:=SessioneOracleBc06;
      RegistraMsg.IniziaMessaggio('Bc06');
      RegistraMsg.InserisciMessaggio('A',E.Message);
      Result:=False;
    end;
  end;
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

procedure TBc06FExecMonitorB006DtM.EseguiSqlEstraiAziende(ListaAziende:TStringList; ConfIstanza:TConfIstanza);
var
  OracleQuery:TOracleQuery;
  SQL: string;
begin
  SQL:='select AZIENDA from MONDOEDP.I090_ENTI union select ''<TUTTE>'' from dual';

  OracleQuery:=TOracleQuery.Create(nil);
  ListaAziende.Clear;
  try
    try
      OracleQuery.Session:=SessioneOracleI191;

      OracleQuery.SQL.Text:=SQL;
      OracleQuery.ReadBuffer:=5000;

      try
        RegistraMsg.InserisciMessaggio('I',Format('[%s] Esecuzione query estrazione aziende: %s',
                                                  [ConfIstanza.DataBase,SQL]));
        OracleQuery.Execute;
        RegistraMsg.InserisciMessaggio('I',Format('[%s] Query eseguita',[ConfIstanza.DataBase]));
      except
        on E:Exception do
        begin
          RegistraMsg.InserisciMessaggio('A',Format('[%s] Errore durante l''esecuzione della query: %s',[ConfIstanza.DataBase,E.Message]));
          Exit;
        end;
      end;

      RegistraMsg.InserisciMessaggio('I',Format('[%s] Estrazione dei messaggi... (MSG_ELABORAZIONI_RIGHE=%d)',
                                                [ConfIstanza.DataBase,ConfIstanza.MsgElaborazioniRighe]));
      // Estraggo la prima colonna, considerando l'eventuale limite di righe
      ListaAziende.Clear;
      while not OracleQuery.Eof do
      begin
        ListaAziende.Add(OracleQuery.FieldAsString(0));
        OracleQuery.Next;
      end;
      RegistraMsg.InserisciMessaggio('I',Format('[%s] OK',[ConfIstanza.DataBase]));

    except
     on E:Exception do
      begin
        // Errore inatteso durante l'estrazione.
        RegistraMsg.InserisciMessaggio('A',Format('[%s] Errore durante l''estrazione: %s',[ConfIstanza.Database,E.Message]));
        ListaAziende.Clear;
      end;
    end;
  finally
    FreeAndNil(OracleQuery);
  end;
end;

{ Esegue la query SQL e popola ListaLog con i risultati. }
procedure TBc06FExecMonitorB006DtM.EseguiSqlEstraiLog(SQL:String; ListaLog:TStringList; ConfIstanza:TConfIstanza; pFiltroU: String);
var
  OracleQuery:TOracleQuery;
  NumRigheEstratte:Integer;
  EstraiTutto:Boolean;
begin
  OracleQuery:=TOracleQuery.Create(nil);
  try
    try
      OracleQuery.Session:=SessioneOracleI191;
      if SQL <> '' then
      begin
        OracleQuery.SQL.Text:=SQL;
        OracleQuery.ReadBuffer:=5000;
        if Pos(':' + NOME_VAR_MSG_ELABORAZIONI_GG,SQL) > 0 then
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
        if Pos(':' + NOME_VAR_MSG_FILTRO_UTENTE,SQL) > 0 then
        begin
          OracleQuery.DeclareVariable(NOME_VAR_MSG_FILTRO_UTENTE, otSubst);
          OracleQuery.SetVariable(NOME_VAR_MSG_FILTRO_UTENTE, pFiltroU);
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

function TBc06FExecMonitorB006DtM.EffettuaControllo(ConfIstanza:TConfIstanza; pFiltroU:String):TEsitoControllo;
var
  CheckStr,TestoMsg:String;
  Continua:Boolean;
  OracleQuery:TOracleQuery;
begin
  RegistraMsg.InserisciMessaggio('I',Format('[%s] Esecuzione controllo...',[ConfIstanza.DataBase]));

  try
    if SessioneOracleI191 <> nil then
    begin
      SessioneOracleI191.LogOff;
      FreeAndNil(SessioneOracleI191);
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
      SessioneOracleI191:=CreaSessioneOracle(ConfIstanza.DataBase,ConfIstanza.Password);
      try
        SessioneOracleI191.LogOn;
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
        OracleQuery.Session:=SessioneOracleI191;
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
        EseguiSqlEstraiLog(ConfIstanza.QueryMsg1,Result.Msg1,ConfIstanza,pFiltroU);

        RegistraMsg.InserisciMessaggio('I',Format('[%s] Lettura messaggi 2...',[ConfIstanza.DataBase]));
        EseguiSqlEstraiLog(ConfIstanza.QueryMsg2,Result.Msg2,ConfIstanza,pFiltroU);

        EseguiSqlEstraiAziende(Result.LstAziende,ConfIstanza);
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

  if SessioneOracleI191 <> nil then
  begin
    try
      if SessioneOracleI191.Connected then
        SessioneOracleI191.LogOff;
      FreeAndNil(SessioneOracleI191);
    except

    end;
  end;
  SessioneOracleI191:=nil;

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
    SessioneOracleBc06.Commit;
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

procedure TBc06FExecMonitorB006DtM.ApriSelI191;
begin
  selI191.Close;
  selI191.SetVariable('ID',selI190.FieldByName('ID').AsInteger);
  selI191.Open;
end;

procedure TBc06FExecMonitorB006DtM.selI190AfterScroll(DataSet: TDataSet);
begin
  if not selI190.Active then
    Exit;
  ApriSelI191;
end;

procedure TBc06FExecMonitorB006DtM.selI190BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if (selI190.RecordCount > 0) then
    Abort;
end;

procedure TBc06FExecMonitorB006DtM.selI190BeforePost(DataSet: TDataSet);
begin
  if (selI190.FieldByName('EMAIL_AUTH_TYPE').AsString <> '') and
     (ListaEmailAuthType.IndexOf(selI190.FieldByName('EMAIL_AUTH_TYPE').AsString) = -1) then
    raise Exception.Create('Tipo autenticazione email non valido.');
end;

procedure TBc06FExecMonitorB006DtM.selI190CalcFields(DataSet: TDataSet);
begin
  selI190.FieldByName('D_EMAIL_SMTP_PASSWORD').AsString:=R180Decripta(selI190.FieldByName('EMAIL_SMTP_PASSWORD').AsString,SALT_CRIPTA);
end;

{ Esegue l'SQL specificato con la sessione Oracle indicata. Ritorna '' se la query è
  stata eseguita senza problemi o il messaggio dell'eccezione in caso di errore }
function TBc06FExecMonitorB006DtM.TestQuery(SQL:String;TQSessioneOracle:TOracleSession):String;
var
  myQuery:TOracleQuery;
begin
  Result:='Errore di programma';
  myQuery:=TOracleQuery.Create(nil);
  try
    try
      myQuery.Session:=TQSessioneOracle;
      // Variabili con valori fittizzi
      myQuery.SQL.Text:=SQL;
      // Accetto solo le variabili NOME_VAR_MSG_ELABORAZIONI_GG e NOME_VAR_MSG_ELABORAZIONI_RIGHE
      if Pos(':' + NOME_VAR_MSG_ELABORAZIONI_GG,SQL) > 0 then
      begin
        myQuery.DeclareVariable(NOME_VAR_MSG_ELABORAZIONI_GG,otInteger);
        myQuery.SetVariable(NOME_VAR_MSG_ELABORAZIONI_GG,0);
      end;
      if Pos(':' + NOME_VAR_MSG_ELABORAZIONI_RIGHE,SQL) > 0 then
      begin
        myQuery.DeclareVariable(NOME_VAR_MSG_ELABORAZIONI_RIGHE,otInteger);
        myQuery.SetVariable(NOME_VAR_MSG_ELABORAZIONI_RIGHE,0);
      end;

      if Pos(':' + NOME_VAR_MSG_FILTRO_UTENTE,SQL) > 0 then
      begin
        myQuery.DeclareVariable(NOME_VAR_MSG_FILTRO_UTENTE,otSubst);
        myQuery.SetVariable(NOME_VAR_MSG_FILTRO_UTENTE,null);
      end;

      myQuery.Execute;
      Result:='';
    except
      on E:Exception do
      begin
        Result:=E.Message;
      end;
    end;
  finally
    FreeAndNil(myQuery);
  end;
end;

procedure TBc06FExecMonitorB006DtM.selI191AfterPost(DataSet: TDataSet);
begin
  DataSet.Refresh;
end;

procedure TBc06FExecMonitorB006DtM.selI191BeforeInsert(DataSet: TDataSet);
begin
  if SolaLettura then
    Abort;
end;

procedure TBc06FExecMonitorB006DtM.selI191BeforePost(DataSet: TDataSet);
var
  TestSQL,ResultTestSQL,MessaggioErrore:String;
  SessioneTest:TOracleSession;
begin
  if LocalOracleAliasList.IndexOf(selI191.FieldByName('DATABASE_NAME').AsString) = -1 then
    raise Exception.Create('Il database specificato non esiste.');
  if selI191.FieldByName('NO_MONITOR_DALLE').AsString = ORARIO_VUOTO then
    selI191.FieldByName('NO_MONITOR_DALLE').Value:=null;
  if selI191.FieldByName('NO_MONITOR_ALLE').AsString = ORARIO_VUOTO then
    selI191.FieldByName('NO_MONITOR_ALLE').Value:=null;
  if ((selI191.FieldByName('NO_MONITOR_DALLE').Value <> null) and
      (selI191.FieldByName('NO_MONITOR_ALLE').Value = null)) or
     ((selI191.FieldByName('NO_MONITOR_ALLE').Value <> null) and
      (selI191.FieldByName('NO_MONITOR_DALLE').Value = null)) then
    raise Exception.Create('Specificare correttamente l''intervallo di esclusione del controllo.');
  // Test query
  if ((Trim(selI191.FieldByName('QUERY_SERVIZIO_CONNESSO').AsString) <> '') or
     (Trim(selI191.FieldByName('QUERY_MSG1').AsString) <> '') or
     (Trim(selI191.FieldByName('QUERY_MSG2').AsString) <> '')) // almeno una delle query è diversa da '' E
     and (((selI191.State = dsEdit) and //... siamo in edit E abbiamo modificato almeno una delle query
          ((selI191.FieldByName('QUERY_SERVIZIO_CONNESSO').OldValue <> selI191.FieldByName('QUERY_SERVIZIO_CONNESSO').Value) or
           (selI191.FieldByName('QUERY_MSG1').OldValue <> selI191.FieldByName('QUERY_MSG1').Value) or
           (selI191.FieldByName('QUERY_MSG2').OldValue <> selI191.FieldByName('QUERY_MSG2').Value))
          )
          or (selI191.State = dsInsert)) //... oppure siamo in insert
     then
  begin
    if R180MessageBox('Testare le query specificate sui DB di destinazione?',DOMANDA) = mrYes then
    begin
      // CreaSessioneOracle solleva un'eccezione in caso di errore e disalloca nel caso la sessione creata
      SessioneTest:=CreaSessioneOracle(selI191.FieldByName('DATABASE_NAME').AsString,
                                                               selI191.FieldByName('CONNESSIONE_PWD').AsString);
      try
        try
          MessaggioErrore:='';
          SessioneTest.LogOn;

          // Testiamo le query...
          TestSQL:=Trim(selI191.FieldByName('QUERY_SERVIZIO_CONNESSO').AsString);
          if TestSQL <> '' then
          begin
            ResultTestSQL:=TestQuery(TestSQL,SessioneTest);
            if ResultTestSQL <> '' then
              MessaggioErrore:='Query servizio connesso: ' + ResultTestSQL;
          end;

          TestSQL:=Trim(selI191.FieldByName('QUERY_MSG1').AsString);
          if TestSQL <> '' then
          begin
            ResultTestSQL:=TestQuery(TestSQL,SessioneTest);
            if ResultTestSQL <> '' then
            begin
              if MessaggioErrore <> '' then
                MessaggioErrore:=MessaggioErrore + CRLF;
              MessaggioErrore:=MessaggioErrore + 'Query messaggi 1: ' + ResultTestSQL;
            end;
          end;

          TestSQL:=Trim(selI191.FieldByName('QUERY_MSG2').AsString);
          if TestSQL <> '' then
          begin
            ResultTestSQL:=TestQuery(TestSQL,SessioneTest);
            if ResultTestSQL <> '' then
            begin
              if MessaggioErrore <> '' then
                MessaggioErrore:=MessaggioErrore + CRLF;
              MessaggioErrore:=MessaggioErrore + 'Query messaggi 2: ' + ResultTestSQL;
            end;
          end;

          if MessaggioErrore <> '' then
          begin
            MessaggioErrore:='Si sono verificati i seguenti errori durante il test delle query:' + CRLF +
                             MessaggioErrore + CRLF +
                             'Le modifiche saranno comunque apportate.';
            R180MessageBox(MessaggioErrore,ESCLAMA);
          end
          else
          begin
            R180MessageBox('Le query sono corrette.',INFORMA);
          end;
        except
          on E:Exception do
          begin
           MessaggioErrore:='Si sono verificati i seguenti errori durante il test delle query:' + CRLF +
                             E.Message + CRLF +
                            'Le modifiche saranno comunque apportate.';
            R180MessageBox(MessaggioErrore,ESCLAMA);
          end;
        end;
      finally
        FreeAndNil(SessioneTest);
      end;
    end;
  end;
end;

procedure TBc06FExecMonitorB006DtM.selI191CalcFields(DataSet: TDataSet);
var
  MaskPwd:String;
begin
  if selI191.FieldByName('CONNESSIONE_PWD').IsNull then
    MaskPwd:='<No password>'
  else
    MaskPwd:=StringOfChar('*',selI191.FieldByName('CONNESSIONE_PWD').AsString.Length);
  selI191.FieldByName('D_CONNESSIONE_PWD').AsString:=MaskPwd;

  selI191.FieldByName('D_CONNESSIONE_PWD_DECRYPT').AsString:=R180Decripta(selI191.FieldByName('CONNESSIONE_PWD').AsString,SALT_CRIPTA);
end;

procedure TBc06FExecMonitorB006DtM.selI191MONITOR_BC06SRVValidate(Sender: TField);
begin
  If (UpperCase(Sender.AsString) <> 'S') and (UpperCase(Sender.AsString) <> 'N') then
    raise Exception.Create('Valore non valido');
end;

procedure TBc06FExecMonitorB006DtM.selI191MSG_ELABORAZIONI_GGValidate(Sender: TField);
begin
  if Sender.AsInteger < 0 then
    raise Exception.Create('Specificare un numero maggiore o uguale a 0.');
end;

procedure TBc06FExecMonitorB006DtM.selI191MSG_ELABORAZIONI_RIGHEValidate(Sender: TField);
begin
  if Sender.AsInteger < -1 then
    raise Exception.Create('Specificare un numero maggiore o uguale a -1.');
end;

procedure TBc06FExecMonitorB006DtM.selI191NewRecord(DataSet: TDataSet);
begin
  if (selI190.Active) and (selI190.RecordCount > 0) then
    selI191.FieldByName('ID').AsInteger:=selI190.FieldByName('ID').AsInteger;
end;

procedure TBc06FExecMonitorB006DtM.selI191NO_MONITOR_ALLEValidate(Sender: TField);
begin
  if (Length(Trim(Sender.AsString)) > 0) and (Sender.AsString <> ORARIO_VUOTO)  and
     (not CheckOrarioValido(Sender.AsString)) then
    raise Exception.Create('Orario non valido.');
end;

procedure TBc06FExecMonitorB006DtM.selI191NO_MONITOR_DALLEValidate(Sender: TField);
begin
  if (Length(Trim(Sender.AsString)) > 0) and (Sender.AsString <> ORARIO_VUOTO)  and
     (not CheckOrarioValido(Sender.AsString)) then
    raise Exception.Create('Orario non valido.');
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
function TBc06FExecMonitorB006DtM.InviaMailNotifica(pConfServizio:TConfServizio;
                                                    pConfIstanza:TConfIstanza;
                                                    pEsitoControllo:TEsitoControllo):String;
var
  MyMessage:TIdMessage;
  Oggetto,Testo:String;
  CurrAttach:TIdAttachmentMemory;
begin       // TODO constantizzare le stringhe di default
  RegistraMsg.InserisciMessaggio('I',Format('[%s] Inizio invio mail',[pConfIstanza.Database]));
  Result:='Errore generico';
  MyMessage:=TIdMessage.Create(nil);
  try
    try
      if pEsitoControllo.Esito = ESITO_CONTROLLO_SALTATO then
        Exit; // Nessun messaggio

      if pEsitoControllo.Esito = ESITO_OK then
      begin
        Oggetto:=Format('Servizio %s su %s regolarmente attivo',[pConfIstanza.Servizio,pConfIstanza.DataBase]);
        Testo:=Format('Si informa che il servizio %s è ora connesso al database %s.',
                      [pConfIstanza.Servizio,pConfIstanza.DataBase]);
      end
      else
      begin
        Oggetto:=Format('Errore servizio %s su %s',[pConfIstanza.Servizio,pConfIstanza.DataBase]);
        Testo:=Format('Il controllo sullo stato servizio %s sul database %s ha dato esito negativo' + CRLF + CRLF +
                      'E'' stato restituito il seguente errore: ' + CRLF + CRLF +
                      TAB + '%s (codice %d)',
                      [pConfIstanza.Servizio,pConfIstanza.DataBase,pEsitoControllo.DescrEsito,pEsitoControllo.Esito]);
      end;

      MyMessage.CharSet:='ISO-8859-15';
      MyMessage.ConvertPreamble:=True;
      MyMessage.Encoding:=meMIME;
      MyMessage.AttachmentEncoding:='MIME';
      MyMessage.UseNowForDate:=True;
      MyMessage.ContentType:='multipart/mixed';
      MyMessage.From.Address:=pConfIstanza.EMailMittente;
      MyMessage.From.Name:=Format('Bc06 %s/%s',[pConfIstanza.Servizio,pConfIstanza.DataBase]);
      MyMessage.BccList.Clear;
      MyMessage.Recipients.Clear;
      MyMessage.CCList.Clear;
      MyMessage.Recipients.EMailAddresses:=pConfIstanza.EMailDestinatari;
      MyMessage.CCList.EMailAddresses:=pConfIstanza.EMailDestinatariCC;
      MyMessage.Subject:=Oggetto;
      MyMessage.MessageParts.Clear;
      MyMessage.Body.Text:=Testo;

      if pEsitoControllo.Msg1.Count > 0 then
      begin
        CurrAttach:=TIdAttachmentMemory.Create(MyMessage.MessageParts,pEsitoControllo.Msg1.Text);
        CurrAttach.ContentType:='text/plain';
        CurrAttach.FileName:='Messaggi elaborazione 1.txt';
      end;
      if pEsitoControllo.Msg2.Count > 0 then
      begin
        CurrAttach:=TIdAttachmentMemory.Create(MyMessage.MessageParts,pEsitoControllo.Msg2.Text);
        CurrAttach.ContentType:='text/plain';
        CurrAttach.FileName:='Messaggi elaborazione 2.txt';
      end;

      RegistraMsg.InserisciMessaggio('I',Format('[%s] Invio mail, destinatari: %s / destinatari CC: %s',
                                         [pConfIstanza.Database,pConfIstanza.EMailDestinatari,pConfIstanza.EMailDestinatariCC]));
      try
        MySMTP.Send(MyMessage);
        Result:='OK';
        RegistraMsg.InserisciMessaggio('I',Format('[%s] Mail inviata correttamente',[pConfIstanza.Database]));
      except
        on E:Exception do
        begin
          RegistraMsg.InserisciMessaggio('A',Format('[%s] Errore durante l''invio della mail: %s',
                                                    [pConfIstanza.Database,E.Message]));
          raise Exception.Create(Format('impossibile inviare la mail, %s',[E.Message]));
        end;
      end;
    except
      on E:Exception do
      begin
        RegistraMsg.InserisciMessaggio('A',Format('[%s] Errore durante la composizione/invio della mail: %s',
                                                    [pConfIstanza.Database,E.Message]));
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

  if Configurazione <> nil then FreeAndNil(Configurazione);
  if MsgControlli <> nil then FreeAndNil(MsgControlli);
  FreeAndNil(LocalOracleAliasList);
  FreeAndNil(ListaEmailAuthType);
  FreeAndNil(RegistraMsg);
  inherited;
end;

function TBc06FExecMonitorB006DtM.LanciaControllo(pConfServizio:TConfServizio; pConfIstanza:TConfIstanza; optFiltroU: string = ''): TStringList;
var
  EsitoControllo:TEsitoControllo;
  MsgControlloIstanza:TMsgControlloIstanza;
  StrAppoggio:String;
begin
  { Se arrivo ad eseguire questo metodo, Configurazione,MsgControlli e cdsInfoControlli sono sicuramente già allocati.
    Configurazione e MsgControlli sono istanziati e popolati da LeggiConfigurazione(). Se si verifica
    un errore durante la loro preparazione, vengono disallocati e i puntatori impostati a nil.
    Il contenuto di cdsInfoControlli viene valorizzato dallo stesso metodo, in caso di errore il
    dataset viene svuotato.
    Quindi: a questo punto del programma Configurazione,MsgControlli e cdsInfoControlli sono sicuramente
    correttamente valorizzati.}
  RegistraMsg.SessioneOracleApp:=SessioneOracleBc06;

  Result:=TStringList.Create;
  cdsInfoControlli.Locate('ID;DATABASE',VarArrayOf([pConfIstanza.IDServizio,pConfIstanza.DataBase]),[]);

  MsgControlloIstanza:=MsgControlli.Items[cdsInfoControlli.RecNo];

  RegistraMsg.IniziaMessaggio('Bc06');
  EsitoControllo:=nil;
  Result.Add(Format('========== %s/%s ==========',
                                           [pConfIstanza.Servizio,pConfIstanza.DataBase]));
  Result.Add(Format('Avvio controllo su database %s',[pConfIstanza.DataBase]));
  RegistraMsg.InserisciMessaggio('I',Format('[%s] Avvio del controllo su %s/%s',[pConfIstanza.Database,pConfIstanza.Servizio,pConfIstanza.Database]));
  try
    { Esito controllo logga l'esito dell'operazione su EsitoControllo. In caso di errore
      questo viene gestito come errore di controllo (anche eventuali eccezioni inattese)
      e registrato su EsitoControllo. }
    Result.Add('Verifica attività e lettura log...');
    EsitoControllo:=EffettuaControllo(pConfIstanza,optFiltroU);
    if EsitoControllo.Esito <> ESITO_CONTROLLO_SALTATO then
      Result.Add('Completato.')
    else
      Result.Add('Controllo saltato come da configurazione (intervallo di esclusione).');

    { Salvo in memoria il risultato, unica eccezione: se abbiamo saltato il controllo perchè
      siamo in un intervallo di esclusione non aggiorno i risultati, ma lascio quelli già esistenti
      (il log comunque lo aggiorno sempre) }
    if EsitoControllo.Esito <> ESITO_CONTROLLO_SALTATO then
    begin
      cdsInfoControlli.Edit;
      cdsInfoControlli.FieldByName('DATA_ULT_CONTROLLO').AsString:=FormatDateTime('dd/mm/yyyy hh:nn:ss',Now);
      cdsInfoControlli.FieldByName('ESITO_CONTROLLO').AsInteger:=EsitoControllo.Esito;
      if EsitoControllo.Esito = ESITO_OK then
        StrAppoggio:='OK'
      else if EsitoControllo.Esito = ESITO_CONTROLLO_SALTATO then
        StrAppoggio:='Saltato'
      else
        StrAppoggio:='Errore';
      cdsInfoControlli.FieldByName('D_ESITO_CONTROLLO').AsString:=StrAppoggio;
      cdsInfoControlli.FieldByName('DESC_ESITO_CONTROLLO').AsString:=EsitoControllo.DescrEsito;
      cdsInfoControlli.FieldByName('LstAziende').AsString:=EsitoControllo.LstAziende.CommaText;
      cdsInfoControlli.Post;

      // Log personalizzati
      MsgControlloIstanza.Msg1.Assign(EsitoControllo.Msg1);
      MsgControlloIstanza.Msg2.Assign(EsitoControllo.Msg2);
    end;

    // Gestisco le mail di notifica
    StrAppoggio:=GestisciNotificheMail(pConfServizio,pConfIstanza,EsitoControllo);
    if StrAppoggio = 'OK' then
      Result.Add('Notifiche mail inviate correttamente')
    else if StrAppoggio <> '' then
      Result.Add(Format('Invio mail: %s',[StrAppoggio]));    // Invio mail fallito

    if not R180In(EsitoControllo.Esito,[ESITO_CONTROLLO_SALTATO,ESITO_ERRORE_GENERICO,ESITO_INDEFINITO]) then
    begin
      Result.Add('Registrazione esito controllo su I192...');
      StrAppoggio:=RegistraLogEsito(EsitoControllo);
      if StrAppoggio = 'OK' then
        Result.Add('Registrazione avvenuta correttamente.')
      else
        Result.Add(Format('Errore durante la registrazione dei log su I192: %s',[StrAppoggio]));
    end;

    If Assigned(cdsInfoControlli.AfterScroll) then
      cdsInfoControlli.AfterScroll(cdsInfoControlli);
  except
    on E:Exception do
    begin
      RegistraMsg.InserisciMessaggio('A',Format('Errore esterno al controllo: %s',
                                                [E.Message]));
      Result.Add(Format('Errore di programma: %s',[E.Message]));
    end;
  end;

  Result.Add('Controllo terminato');

  if TipoModulo = ModuloServizio then
    for StrAppoggio in Result do
      RegistraMsg.InserisciMessaggio('I', StrAppoggio);

  FreeAndNil(EsitoControllo);
  RegistraMsg.InserisciMessaggio('I',Format('[%s] Fine ' + IntToStr(pConfServizio.Istanze.Count),[pConfIstanza.DataBase]));
end;

procedure TBc06FExecMonitorB006DtM.LeggiConfigurazione;
var
  CurrServizio:TConfServizio;
  CurrIstanza:TConfIstanza;
begin
  selI190.Open;
  selI190.Refresh;
  CurrServizio:=nil;
  CurrIstanza:=nil;

  if Configurazione <> nil then
    FreeAndNil(Configurazione);
  if MsgControlli <> nil then
    FreeAndNil(MsgControlli);

  Configurazione:=TConfGenerale.Create;
  MsgControlli:=TObjectDictionary<Integer,TMsgControlloIstanza>.Create([doOwnsValues]);
  cdsInfoControlli.EmptyDataSet;
  cdsInfoControlli.DisableControls;
  try
    try
      while not selI190.Eof do
      begin
        CurrServizio:=TConfServizio.Create;
        CurrServizio.ID:=selI190.FieldByName('ID').AsInteger;
        CurrServizio.NomeServizio:=selI190.FieldByName('SERVIZIO').AsString;
        CurrServizio.Intervallo:=selI190.FieldByName('INTERVALLO_MONITOR').AsString;
        CurrServizio.IntervalloMS:=R180OreMinuti(CurrServizio.Intervallo) * 60 * 1000;
        CurrServizio.SMTPHost:=selI190.FieldByName('EMAIL_SMTP_HOST').AsString;
        CurrServizio.SMTPPort:=selI190.FieldByName('EMAIL_SMTP_PORT').AsInteger;
        CurrServizio.SMTPUserName:=selI190.FieldByName('EMAIL_SMTP_USERNAME').AsString;
        CurrServizio.SMTPPassword:=selI190.FieldByName('EMAIL_SMTP_PASSWORD').AsString;
        CurrServizio.SMTPAuthType:=selI190.FieldByName('EMAIL_AUTH_TYPE').AsString;
        // selI191 viene già aperto con l'id di selI190 dall'evento AfterScroll
        selI191.First;
        while not selI191.Eof do
        begin
          if (TipoModulo <> ModuloServizio) or (UpperCase(selI191.FieldByName('MONITOR_BC06SRV').AsString) = 'S') then
          begin
            CurrIstanza:=TConfIstanza.Create;
            CurrIstanza.Servizio:=CurrServizio.NomeServizio;
            CurrIstanza.IDServizio:=CurrServizio.ID;
            CurrIstanza.DataBase:=selI191.FieldByName('DATABASE_NAME').AsString;
            CurrIstanza.Monitor_Bc06srv:=selI191.FieldByName('MONITOR_BC06SRV').AsString;
            CurrIstanza.Password:=selI191.FieldByName('CONNESSIONE_PWD').AsString;
            CurrIstanza.QueryServizioConnesso:=selI191.FieldByName('QUERY_SERVIZIO_CONNESSO').AsString;
            CurrIstanza.QueryMsg1:=selI191.FieldByName('QUERY_MSG1').AsString;
            CurrIstanza.QueryMsg2:=selI191.FieldByName('QUERY_MSG2').AsString;
            CurrIstanza.NoMonitorDalle:=selI191.FieldByName('NO_MONITOR_DALLE').AsString;
            CurrIstanza.NoMonitorAlle:=selI191.FieldByName('NO_MONITOR_ALLE').AsString;
            CurrIstanza.MsgElaborazioniGG:=selI191.FieldByName('MSG_ELABORAZIONI_GG').AsInteger;
            CurrIstanza.MsgElaborazioniRighe:=selI191.FieldByName('MSG_ELABORAZIONI_RIGHE').AsInteger;
            CurrIstanza.EMailMittente:=selI191.FieldByName('EMAIL_MITTENTE').AsString;
            CurrIstanza.EMailDestinatari:=selI191.FieldByName('EMAIL_DESTINATARI').AsString;
            CurrIstanza.EMailDestinatariCC:=selI191.FieldByName('EMAIL_DESTINATARI_CC').AsString;

            // Per ogni istanza preparo una riga sul dataset per le info controlli...
            cdsInfoControlli.Insert;
            cdsInfoControlli.FieldByName('ID').AsInteger:=CurrServizio.ID;
            cdsInfoControlli.FieldByName('SERVIZIO').AsString:=CurrServizio.NomeServizio;
            cdsInfoControlli.FieldByName('DATABASE').AsString:=CurrIstanza.DataBase;
            cdsInfoControlli.FieldByName('MONITOR_BC06SRV').AsString:=IfThen(UpperCase(CurrIstanza.Monitor_Bc06srv)='S', 'Sì', 'No');
            cdsInfoControlli.FieldByName('INTERVALLO').AsString:=CurrServizio.Intervallo;
            cdsInfoControlli.FieldByName('ESITO_CONTROLLO').AsInteger:=ESITO_INDEFINITO;
            cdsInfoControlli.FieldByName('D_ESITO_CONTROLLO').AsString:='N/D';
            //Verifico se le query sono predisposte per inserimento del filtro utente
            cdsInfoControlli.FieldByName('F_UTENTE').AsBoolean:=(Pos(':' + NOME_VAR_MSG_FILTRO_UTENTE,selI191.FieldByName('QUERY_MSG1').AsString) > 0) or (Pos(':' + NOME_VAR_MSG_FILTRO_UTENTE,selI191.FieldByName('QUERY_MSG2').AsString) > 0);
            cdsInfoControlli.Post;

            // ... e l'oggetto per mantenere in memoria i log dell'ultimo controllo
            MsgControlli.Add(cdsInfoControlli.RecNo,TMsgControlloIstanza.Create(CurrServizio.NomeServizio,CurrIstanza.DataBase));

            CurrServizio.Istanze.Add(CurrIstanza);
            CurrIstanza:=nil;
          end;

          selI191.Next;
        end;
        Configurazione.Servizi.Add(CurrServizio.ID,CurrServizio);
        CurrServizio:=nil;
        selI190.Next;
      end;
      // Se a questo punto cdsInfoControlli è ancora vuoto significa che non abbiamo
      // neanche una istanza configurata.
      if cdsInfoControlli.RecordCount = 0 then
      begin
        //// Sollevo un'eccezione. L'except sotto la cattura e svuota tutte le strutture,
        //// in modo che risulti che non esiste alcuna configurazione valida.
        //raise Exception.Create('nessuna configurazione valida esistente.');
      end;
    except
      on Exc:Exception do
      begin
        if CurrIstanza <> nil then
          FreeAndNil(CurrIstanza);
        if CurrServizio <> nil then
          FreeAndNil(CurrServizio);
        FreeAndNil(Configurazione);
        FreeAndNil(MsgControlli);
        cdsInfoControlli.EmptyDataSet;
        raise Exception.Create('Errore durante la lettura dei parametri di configurazione: ' + Exc.Message);
      end;
    end;
  finally
    selI190.First;
    cdsInfoControlli.EnableControls;
  end;
end;

end.
