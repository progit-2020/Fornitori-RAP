unit Bc06UMonitorB006DtM;

interface

uses
  System.SysUtils, System.Classes, R004UGestStoricoDTM, Data.DB, Oracle, OracleData,
  System.Generics.Collections, Vcl.ExtCtrls, Datasnap.DBClient, Vcl.Controls, Dialogs,
  Variants, A000UCostanti, A000USessione, A000UInterfaccia, Bc06UClassi,
  Bc06UExecMonitorB006DtM, C180FunzioniGenerali;


type
  TBc06FMonitorB006DtM = class(TR004FGestStoricoDtM)
    selI190: TOracleDataSet;
    selI191: TOracleDataSet;
    selI190ID: TIntegerField;
    selI190SERVIZIO: TStringField;
    selI190INTERVALLO_MONITOR: TStringField;
    dsrI191: TDataSource;
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
    cdsInfoControlli: TClientDataSet;
    cdsInfoControlliSERVIZIO: TStringField;
    cdsInfoControlliINTERVALLO: TStringField;
    cdsInfoControlliD_ESITO_CONTROLLO: TStringField;
    dsrInfoControlli: TDataSource;
    cdsInfoControlliDATABASE: TStringField;
    cdsInfoControlliID: TIntegerField;
    cdsInfoControlliDATA_ULT_CONTROLLO: TStringField;
    cdsInfoControlliDESC_ESITO_CONTROLLO: TStringField;
    cdsInfoControlliESITO_CONTROLLO: TIntegerField;
    selI190EMAIL_SMTP_HOST: TStringField;
    selI190EMAIL_SMTP_PORT: TIntegerField;
    selI190EMAIL_SMTP_USERNAME: TStringField;
    selI190EMAIL_SMTP_PASSWORD: TStringField;
    selI190EMAIL_AUTH_TYPE: TStringField;
    selI190D_EMAIL_SMTP_PASSWORD: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selI190AfterScroll(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selI191NewRecord(DataSet: TDataSet);
    procedure selI191CalcFields(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsInfoControlliAfterScroll(DataSet: TDataSet);
    procedure selI191NO_MONITOR_DALLEValidate(Sender: TField);
    procedure selI191NO_MONITOR_ALLEValidate(Sender: TField);
    procedure selI191MSG_ELABORAZIONI_GGValidate(Sender: TField);
    procedure selI191MSG_ELABORAZIONI_RIGHEValidate(Sender: TField);
    procedure selI191BeforePost(DataSet: TDataSet);
    procedure selI190BeforeInsert(DataSet: TDataSet);
    procedure selI191BeforeInsert(DataSet: TDataSet);
    procedure selI190CalcFields(DataSet: TDataSet);
    procedure selI191AfterPost(DataSet: TDataSet);
  private
    ArrayTimers: array of TTimer;
    Disposing:Boolean;
    LocalOracleAliasList:TStringList;
    procedure OnTimerTick(Sender:TObject);
    procedure LanciaControllo(ConfServizio:TConfServizio;ConfIstanza:TConfIstanza);
    function  TestQuery(SQL:String;TQSessioneOracle:TOracleSession):String;
  public
    MonitorAttivo:Boolean;
    Configurazione:TConfGenerale; // Contiene una mappa ID Servizio -> TConfServizio
    MsgControlli:TObjectDictionary<Integer,TMsgControlloIstanza>; // Mappa num. riga cdsInfoControlli -> TMsgControlloIstanza
    ListaEmailAuthType:TStringList;
    procedure LeggiConfigurazione;
    procedure StartMonitor;
    procedure StopMonitor;
    procedure ApriSelI191;
    procedure ControllaOra;
  end;

var
  Bc06FMonitorB006DtM: TBc06FMonitorB006DtM;

implementation

uses Bc06UConfigMonitorB006,Bc06UMonitorB006;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TBc06FMonitorB006DtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Disposing:=False;
  InizializzaDataSet(selI190,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);

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

  selI190.Open;
  SetLength(ArrayTimers,0);
  Configurazione:=nil;
  MsgControlli:=nil;
  cdsInfoControlli.CreateDataSet;
end;

procedure TBc06FMonitorB006DtM.selI190AfterScroll(DataSet: TDataSet);
begin
  if not selI190.Active then
    Exit;
  ApriSelI191;
  if Bc06FConfigMonitorB006 <> nil then
    Bc06FConfigMonitorB006.AbilitaComponenti;
end;

procedure TBc06FMonitorB006DtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  if (selI190.FieldByName('EMAIL_AUTH_TYPE').AsString <> '') and
     (ListaEmailAuthType.IndexOf(selI190.FieldByName('EMAIL_AUTH_TYPE').AsString) = -1) then
    raise Exception.Create('Tipo autenticazione email non valido.');
  inherited;
end;

procedure TBc06FMonitorB006DtM.selI190BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if (selI190.RecordCount > 0) then
    Abort;
end;

procedure TBc06FMonitorB006DtM.selI190CalcFields(DataSet: TDataSet);
begin
  selI190.FieldByName('D_EMAIL_SMTP_PASSWORD').AsString:=R180Decripta(selI190.FieldByName('EMAIL_SMTP_PASSWORD').AsString,SALT_CRIPTA);
end;

procedure TBc06FMonitorB006DtM.ApriSelI191;
begin
  selI191.Close;
  selI191.SetVariable('ID',selI190.FieldByName('ID').AsInteger);
  selI191.Open;
end;

procedure TBc06FMonitorB006DtM.selI191CalcFields(DataSet: TDataSet);
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

procedure TBc06FMonitorB006DtM.selI191MSG_ELABORAZIONI_GGValidate(
  Sender: TField);
begin
  if Sender.AsInteger < 0 then
    raise Exception.Create('Specificare un numero maggiore o uguale a 0.');
end;

procedure TBc06FMonitorB006DtM.selI191MSG_ELABORAZIONI_RIGHEValidate(
  Sender: TField);
begin
  if Sender.AsInteger < -1 then
    raise Exception.Create('Specificare un numero maggiore o uguale a -1.');
end;

procedure TBc06FMonitorB006DtM.selI191NewRecord(DataSet: TDataSet);
begin
  if (selI190.Active) and (selI190.RecordCount > 0) then
    selI191.FieldByName('ID').AsInteger:=selI190.FieldByName('ID').AsInteger;
end;

procedure TBc06FMonitorB006DtM.selI191NO_MONITOR_ALLEValidate(Sender: TField);
begin
  if (Length(Trim(Sender.AsString)) > 0) and (Sender.AsString <> ORARIO_VUOTO)  and
     (not Bc06FExecMonitorB006DtM.CheckOrarioValido(Sender.AsString)) then
    raise Exception.Create('Orario non valido.');
end;

procedure TBc06FMonitorB006DtM.selI191NO_MONITOR_DALLEValidate(Sender: TField);
begin
  if (Length(Trim(Sender.AsString)) > 0) and (Sender.AsString <> ORARIO_VUOTO)  and
     (not Bc06FExecMonitorB006DtM.CheckOrarioValido(Sender.AsString)) then
    raise Exception.Create('Orario non valido.');
end;


procedure TBc06FMonitorB006DtM.selI191AfterPost(DataSet: TDataSet);
begin
  DataSet.Refresh;
end;

procedure TBc06FMonitorB006DtM.selI191BeforeInsert(DataSet: TDataSet);
begin
  if SolaLettura then
    Abort;
end;

{ Esegue l'SQL specificato con la sessione Oracle indicata. Ritorna '' se la query è
  stata eseguita senza problemi o il messaggio dell'eccezione in caso di errore }
function TBc06FMonitorB006DtM.TestQuery(SQL:String;TQSessioneOracle:TOracleSession):String;
var
  TestQuery:TOracleQuery;
begin
  Result:='Errore di programma';
  TestQuery:=TOracleQuery.Create(nil);
  try
    try
      TestQuery.Session:=TQSessioneOracle;
      // Variabili con valori fittizzi
      TestQuery.SQL.Text:=SQL;
      // Accetto solo le variabili NOME_VAR_MSG_ELABORAZIONI_GG e NOME_VAR_MSG_ELABORAZIONI_RIGHE
      if Pos(':' + NOME_VAR_MSG_ELABORAZIONI_GG,SQL) > 1 then
      begin
        TestQuery.DeclareVariable(NOME_VAR_MSG_ELABORAZIONI_GG,otInteger);
        TestQuery.SetVariable(NOME_VAR_MSG_ELABORAZIONI_GG,0);
      end;
      if Pos(':' + NOME_VAR_MSG_ELABORAZIONI_RIGHE,SQL) > 1 then
      begin
        TestQuery.DeclareVariable(NOME_VAR_MSG_ELABORAZIONI_RIGHE,otInteger);
        TestQuery.SetVariable(NOME_VAR_MSG_ELABORAZIONI_RIGHE,0);
      end;
      TestQuery.Execute;
      Result:='';
    except
      on E:Exception do
      begin
        Result:=E.Message;
      end;
    end;
  finally
    FreeAndNil(TestQuery);
  end;
end;

procedure TBc06FMonitorB006DtM.selI191BeforePost(DataSet: TDataSet);
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
      SessioneTest:=Bc06FExecMonitorB006DtM.CreaSessioneOracle(selI191.FieldByName('DATABASE_NAME').AsString,
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

procedure TBc06FMonitorB006DtM.LeggiConfigurazione;
var
  CurrServizio:TConfServizio;
  CurrIstanza:TConfIstanza;
begin
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
          CurrIstanza:=TConfIstanza.Create;
          CurrIstanza.Servizio:=CurrServizio.NomeServizio;
          CurrIstanza.IDServizio:=CurrServizio.ID;
          CurrIstanza.DataBase:=selI191.FieldByName('DATABASE_NAME').AsString;
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
          cdsInfoControlli.FieldByName('INTERVALLO').AsString:=CurrServizio.Intervallo;
          cdsInfoControlli.FieldByName('ESITO_CONTROLLO').AsInteger:=ESITO_INDEFINITO;
          cdsInfoControlli.FieldByName('D_ESITO_CONTROLLO').AsString:='N/D';
          cdsInfoControlli.Post;

          // ... e l'oggetto per mantenere in memoria i log dell'ultimo controllo
          MsgControlli.Add(cdsInfoControlli.RecNo,TMsgControlloIstanza.Create(CurrServizio.NomeServizio,CurrIstanza.DataBase));

          CurrServizio.Istanze.Add(CurrIstanza);
          CurrIstanza:=nil;

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
        // Sollevo un'eccezione. L'except sotto la cattura e svuota tutte le strutture,
        // in modo che risulti che non esiste alcuna configurazione valida.
        raise Exception.Create('nessuna configurazione valida esistente.');
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

procedure TBc06FMonitorB006DtM.StartMonitor;
var
  ID,idx:Integer;
  ConfServizio:TConfServizio;
  ConfIstanza:TConfIstanza;
begin
  if MonitorAttivo then
    raise Exception.Create('Il monitoraggio è già attivo.');
  if (Configurazione = nil) or (MsgControlli = nil) or (cdsInfoControlli.RecordCount = 0) then
    raise Exception.Create('Configurazione non caricata!'); // Non deve MAI succedere

  try
    SetLength(ArrayTimers,Configurazione.Servizi.Keys.Count);
    idx:=0;
    for ID in Configurazione.Servizi.Keys do // Ciclo nei servizi
    begin
      // Istanzio i timer che lanceranno i controlli
      ConfServizio:=Configurazione.Servizi.Items[ID];
      ArrayTimers[idx]:=TTimer.Create(Self);
      ArrayTimers[idx].Interval:=ConfServizio.IntervalloMS;
      ArrayTimers[idx].Tag:=ConfServizio.ID;
      ArrayTimers[idx].OnTimer:=OnTimerTick;
      ArrayTimers[idx].Enabled:=True;
      Inc(idx);
    end;
    MonitorAttivo:=True;
  except
    on E:Exception do
    begin
      // Annullo tutto
      StopMonitor;
      raise Exception.Create('Errore durante l''avvio del monitor: ' + E.Message);
    end;
  end;
  cdsInfoControlli.EnableControls;
  Bc06FMonitorB006.AggiornaInterfaccia;  // A questo punto Bc06FMonitorB006 è già istanziato
end;

procedure TBc06FMonitorB006DtM.LanciaControllo(ConfServizio:TConfServizio;ConfIstanza:TConfIstanza);
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

  cdsInfoControlli.Locate('ID;DATABASE',VarArrayOf([ConfIstanza.IDServizio,ConfIstanza.DataBase]),[]);
  MsgControlloIstanza:=MsgControlli.Items[cdsInfoControlli.RecNo];

  RegistraMsg.IniziaMessaggio('Bc06');
  EsitoControllo:=nil;
  Bc06FMonitorB006.AggiungiLineaLog(Format('========== %s/%s ==========',
                                           [ConfIstanza.Servizio,ConfIstanza.DataBase]));
  Bc06FMonitorB006.AggiungiLineaLog(Format('Avvio controllo su database %s',[ConfIstanza.DataBase]));
  RegistraMsg.InserisciMessaggio('I',Format('[%s] Avvio del controllo su %s/%s',[ConfIstanza.Database,ConfIstanza.Servizio,ConfIstanza.Database]));
  try
    { Esito controllo logga l'esito dell'operazione su EsitoControllo. In caso di errore
      questo viene gestito come errore di controllo (anche eventuali eccezioni inattese)
      e registrato su EsitoControllo. }
    Bc06FMonitorB006.AggiungiLineaLog('Verifica attività e lettura log...');
    EsitoControllo:=Bc06FExecMonitorB006DtM.EffettuaControllo(ConfIstanza);
    if EsitoControllo.Esito <> ESITO_CONTROLLO_SALTATO then
      Bc06FMonitorB006.AggiungiLineaLog('Completato.')
    else
      Bc06FMonitorB006.AggiungiLineaLog('Controllo saltato come da configurazione (intervallo di esclusione).');

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
      cdsInfoControlli.Post;

      // Log personalizzati
      MsgControlloIstanza.Msg1.Assign(EsitoControllo.Msg1);
      MsgControlloIstanza.Msg2.Assign(EsitoControllo.Msg2);
    end;

    // Gestisco le mail di notifica
    StrAppoggio:=Bc06FExecMonitorB006DtM.GestisciNotificheMail(ConfServizio,ConfIstanza,EsitoControllo);
    if StrAppoggio = 'OK' then
      Bc06FMonitorB006.AggiungiLineaLog('Notifiche mail inviate correttamente')
    else if StrAppoggio <> '' then
    begin
      // Invio mail fallito
      Bc06FMonitorB006.AggiungiLineaLog(Format('Invio mail: %s',[StrAppoggio]));
    end;

    if not R180In(EsitoControllo.Esito,[ESITO_CONTROLLO_SALTATO,ESITO_ERRORE_GENERICO,ESITO_INDEFINITO]) then
    begin
      Bc06FMonitorB006.AggiungiLineaLog('Registrazione esito controllo su I192...');
      StrAppoggio:=Bc06FExecMonitorB006DtM.RegistraLogEsito(EsitoControllo);
      if StrAppoggio = 'OK' then
        Bc06FMonitorB006.AggiungiLineaLog('Registrazione avvenuta correttamente.')
      else
        Bc06FMonitorB006.AggiungiLineaLog(Format('Errore durante la registrazione dei log su I192: %s',[StrAppoggio]));
    end;

    cdsInfoControlli.AfterScroll(cdsInfoControlli);
  except
    on E:Exception do
    begin
      RegistraMsg.InserisciMessaggio('A',Format('Errore esterno al controllo: %s',
                                                [E.Message]));
      Bc06FMonitorB006.AggiungiLineaLog(Format('Errore di programma: %s',[E.Message]));
    end;
  end;

  Bc06FMonitorB006.AggiungiLineaLog('Controllo terminato');
  FreeAndNil(EsitoControllo);
  RegistraMsg.InserisciMessaggio('I',Format('[%s] Fine',[ConfIstanza.DataBase]));
end;

procedure TBc06FMonitorB006DtM.OnTimerTick(Sender:TObject);
var
  IDConfServizio:Integer;
  ConfServizio:TConfServizio;
  ConfIstanza:TConfIstanza;
  EsitoSummary:String;
begin
  Bc06FMonitorB006.BloccaInterfaccia;
  try
    // Svuoto il log ad ogni controllo se c'è un solo servizio da controllare oppure se abbiamo
    // raggiungo un gran numero di righe
    if ((Configurazione.Servizi <> nil) and (Configurazione.Servizi.Count = 1)) or
       (Bc06FMonitorB006.memLogControllo.Lines.Count > 5000) then
      Bc06FMonitorB006.SvuotaLog;

    IDConfServizio:=(Sender as TTimer).Tag;
    ConfServizio:=Configurazione.Servizi[IDConfServizio]; // Se ho un'eccezione significa errore del programma
    for ConfIstanza in ConfServizio.Istanze do
      LanciaControllo(ConfServizio,ConfIstanza);
  finally
    Bc06FMonitorB006.AggiornaInterfaccia;
  end;
end;

procedure TBc06FMonitorB006DtM.cdsInfoControlliAfterScroll(DataSet: TDataSet);
var
  CurrMsgControllo:TMsgControlloIstanza;
  cdsRecNo:Integer;
begin
  if (Bc06FMonitorB006 <> nil) and (cdsInfoControlli.State = dsBrowse) then
  begin
    cdsRecNo:=cdsInfoControlli.RecNo;
    if not MsgControlli.ContainsKey(cdsRecNo) then
    begin
      Bc06FMonitorB006.memMsg1.Lines.Text:='Errore di programma: log per questa istanza non trovati!';
      Bc06FMonitorB006.memMsg2.Lines.Text:='Errore di programma: log per questa istanza non trovati!';
      Exit;
    end;
    CurrMsgControllo:=MsgControlli.Items[cdsRecNo];
    Bc06FMonitorB006.memMsg1.Lines.Assign(CurrMsgControllo.Msg1);
    Bc06FMonitorB006.memMsg2.Lines.Assign(CurrMsgControllo.Msg2);
  end;
end;

procedure TBc06FMonitorB006DtM.ControllaOra;
var
  ConfServizio:TConfServizio;
  ConfIstanza:TConfIstanza;
begin
  if (Configurazione = nil) or (MsgControlli = nil) or (cdsInfoControlli.RecordCount = 0) then
    raise Exception.Create('Configurazione non caricata!'); // Non deve mai succedere

  // Svuoto il log ad ogni controllo se c'è un solo servizio da controllare oppure se abbiamo
  // raggiungo un gran numero di righe
  if ((Configurazione.Servizi <> nil) and (Configurazione.Servizi.Count = 1)) or
     (Bc06FMonitorB006.memLogControllo.Lines.Count > 5000) then
    Bc06FMonitorB006.SvuotaLog;

  // Gli errori sono gestiti internamente in LanciaControllo
  for ConfServizio in Configurazione.Servizi.Values do
  begin
    for ConfIstanza in ConfServizio.Istanze do
    begin
      LanciaControllo(ConfServizio,ConfIstanza);
    end;
  end;

end;

procedure TBc06FMonitorB006DtM.StopMonitor;
var
  CurrTimer:TTimer;
begin
  // Arresto e disalloco i timer, se presenti
  for CurrTimer in ArrayTimers do
  begin
    CurrTimer.Enabled:=False;
    CurrTimer.Free;
  end;
  SetLength(ArrayTimers,0);
  // Segnalo che il monitor è arrestato
  MonitorAttivo:=False;
  if not Disposing then
    Bc06FMonitorB006.AggiornaInterfaccia;
end;

procedure TBc06FMonitorB006DtM.DataModuleDestroy(Sender: TObject);
begin
  Disposing:=True;
  StopMonitor;
  if Configurazione <> nil then FreeAndNil(Configurazione);
  if MsgControlli <> nil then FreeAndNil(MsgControlli);
  FreeAndNil(LocalOracleAliasList);
  FreeAndNil(ListaEmailAuthType);
  inherited;
end;

end.
