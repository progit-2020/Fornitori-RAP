unit A001UPassWordDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Oracle, OracleData, Variants, ActiveX, StrUtils,
  A000UCostanti, A000USessione, A000Versione, A001USSPIValidatePassword, A001UActiveDs_TLB, A001UADsHlp,
  C180FunzioniGenerali, L021Call, RegolePassword, OracleCI;

type
  TA001FPassWordDtM1 = class(TDataModule)
    QI090: TOracleDataSet;
    QI091: TOracleDataSet;
    QI092: TOracleDataSet;
    QI070: TOracleDataSet;
    QI071: TOracleDataSet;
    QI072: TOracleDataSet;
    OperSQL: TOracleQuery;
    I070Count: TOracleDataSet;
    QI073: TOracleDataSet;
    QI074: TOracleDataSet;
    selI070Utenti: TOracleDataSet;
    scrAllineamentoVersione: TOracleScript;
    selI080: TOracleDataSet;
    selT033: TOracleDataSet;
    QI060: TOracleDataSet;
    selI061: TOracleDataSet;
    selTablespace: TOracleDataSet;
    selDistAzienda: TOracleDataSet;
    selP210: TOracleDataSet;
    procedure A001FPassWordDtM1Create(Sender: TObject);
    procedure A001FPassWordDtM1Destroy(Sender: TObject);
    procedure QI073AfterOpen(DataSet: TDataSet);
    procedure QI074AfterOpen(DataSet: TDataSet);
    procedure ImpostaParametriStandard;
  private
    SessioneIWA001:TSessioneIrisWIN;
    function GetCodContrattoVoci:String;
    procedure Log(Tipo,S:String);
  public
    SessioneMondoEDP:TOracleSession;
    EseguiCheckConnection: Boolean;
    procedure RegistraInibizioni;
    procedure InizializzazioneSessione(DB:String);
    function TestDBAlias(NomeAlias:string):boolean;
    function RegistraInibizioniInfo(NomeProfilo:String = ''):boolean;    
    function AutenticazioneDominio(const DomainName, UserName, Password:String; TipoAutenticazione:String = 'NTLM'; LDAP_DN:String = ''):Boolean;
  end;

var
  A001FPassWordDtM1: TA001FPassWordDtM1;

implementation

{$R *.DFM}

uses A000UInterfaccia{$IFDEF IRISWEB}{$IFNDEF WEBSVC},IWApplication,WR010UBase{$ENDIF}{$ENDIF};

procedure TA001FPassWordDtM1.A001FPassWordDtM1Create(Sender: TObject);
begin
  SessioneIWA001:=A000SessioneIrisWIN;
  if Self.Owner <> nil then
    if Self.Owner is TSessioneIrisWIN then
      SessioneIWA001:=Self.Owner as TSessioneIrisWIN;
  ForceDirectories(ExtractFilePath(Application.ExeName) + 'Archivi\Temp');
  QI073.SetVariable('Applicazione',SessioneIWA001.Parametri.Applicazione);
  SessioneMondoEDP:=nil;
  EseguiCheckConnection:=True;
end;

function TA001FPassWordDtM1.TestDBAlias(NomeAlias:string):boolean;
//Verifica l'esistenza dell'alias inserito
var
  i:integer;
  StrOracleAliasList:TStringList;
begin
  StrOracleAliasList:=OracleAliasList;
  //Se la StringList risulta vuota restituisco True(comse se l'alias esistesse)
  if (StrOracleAliasList = nil) or (StrOracleAliasList.Count <= 0) then
  begin
    Result:=True;
    Exit;
  end;
  //Verifico se l'alias � presente all'interno del TNSNAMES
  Result:=StrOracleAliasList.IndexOf(NomeAlias) >= 0;
  //Se no
  //Verifico l'esistenza dell'alias NomeAlias + '.' all'interno del TNSNAMES
  if not Result then
  begin
    i:=0;
    while (i < StrOracleAliasList.Count - 1) and
          (StrOracleAliasList[i].IndexOf(NomeAlias + '.') < 0) do
    begin
      inc(i);
    end;
    Result:=StrOracleAliasList[i].IndexOf(NomeAlias + '.') >= 0;
  end;
end;

procedure TA001FPasswordDtM1.InizializzazioneSessione(DB:String);
var i:Integer;
begin
  {$IFNDEF IRISWEB}R180SetOracleInstantClient;{$ENDIF}
  if SessioneMondoEDP = nil then
  begin
    SessioneMondoEDP:=TOracleSession.Create(nil);
    {$IFNDEF IRISWEB}SessioneMondoEDP.Preferences.UseOCI7:=True;{$ENDIF}
    {$IFDEF IRISWEB}SessioneMondoEDP.Preferences.UseOCI7:=False;{$ENDIF}
    SessioneMondoEDP.NullValue:=nvNull;
    SessioneMondoEDP.Preferences.ZeroDateIsNull:=False;
    SessioneMondoEDP.Preferences.TrimStringFields:=False;
    SessioneMondoEDP.Cursor:=crSQLWait;
    {$IFDEF IRISWEB}SessioneMondoEDP.ThreadSafe:=True;{$ENDIF}

    if (SessioneIWA001 <> nil) and (SessioneIWA001.Name = 'B021') then
    begin
      SessioneMondoEDP.Preferences.UseOCI7:=False;
      SessioneMondoEDP.ThreadSafe:=False;//!!!!!!!!!
      SessioneMondoEDP.Pooling:=spInternal;
    end;

    SessioneMondoEDP.Name:='SessioneMondoEDPA001';
  end;
  if SessioneMondoEDP.LogonDataBase <> DB then
  begin
    SessioneMondoEDP.Logoff;
    SessioneMondoEDP.LogonDataBase:=DB;
    SessioneMondoEDP.LogonUsername:='MONDOEDP';
    SessioneMondoEDP.LogonPassword:=A000GetPassword;
  end;
  if (SessioneIWA001.Name = 'B021') and (not SessioneMondoEDP.Connected) then
  try
    SessioneMondoEDP.LogOn;
  except
    SessioneMondoEDP.LogonPassword:=A000PasswordFissa;
    SessioneMondoEDP.LogOn;
  end
  else if (SessioneIWA001.Name <> 'B021') and
          ((EseguiCheckConnection and (SessioneMondoEDP.CheckConnection(True) = ccError)) or
           ((not EseguiCheckConnection) and (not SessioneMondoEDP.Connected)))
  then
  begin
    SessioneMondoEDP.LogonDataBase:=DB;
    SessioneMondoEDP.LogonUsername:='MONDOEDP';
    SessioneMondoEDP.LogonPassword:=A000GetPassword;
    try
      SessioneMondoEDP.Logon;
    except

      on E:Exception do
      begin
        {$IFDEF IRISWEB}{$IFNDEF WEBSVC}W000RegistraLog('Errore','A001:(1)' + E.Message);{$ENDIF}{$ENDIF}
        SessioneMondoEDP.LogonPassword:=A000PasswordFissa;
        try
          SessioneMondoEDP.Logon;
        except
          on E:Exception do
          begin
            {$IFDEF IRISWEB}{$IFNDEF WEBSVC}W000RegistraLog('Errore','A001:(2)' + E.Message);{$ENDIF}{$ENDIF}
            raise;
          end;
        end;
      end;
    end;
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      try (Components[i] as TOracleQuery).Session:=SessioneMondoEDP; except {$IFDEF IRISWEB}{$IFNDEF WEBSVC}on E:Exception do begin W000RegistraLog('Errore','A001:(251)' + E.Message); end;{$ENDIF}{$ENDIF} end;
    if Components[i] is TOracleDataSet then
      try (Components[i] as TOracleDataSet).Session:=SessioneMondoEDP; except {$IFDEF IRISWEB}{$IFNDEF WEBSVC}on E:Exception do begin W000RegistraLog('Errore','A001:(252)' + E.Message); end;{$ENDIF}{$ENDIF} end;
    if Components[i] is TOracleScript then
      try (Components[i] as TOracleScript).Session:=SessioneMondoEDP; except {$IFDEF IRISWEB}{$IFNDEF WEBSVC}on E:Exception do begin W000RegistraLog('Errore','A001:(253)' + E.Message); end;{$ENDIF}{$ENDIF} end;
  end;
  SessioneIWA001.Parametri.PasswordMondoEDP:=SessioneMondoEDP.LogonPassword;
  SessioneIWA001.Parametri.Database:=SessioneMondoEDP.LogonDatabase;
  selI070Utenti.Open;
  if selI070Utenti.FieldByName('NUM').AsInteger = 0 then
  begin
    QI070.SQL.Text:=StringReplace(QI070.SQL.Text,'I070_UTENTI','I070_OPERATORI',[rfReplaceAll,rfIgnoreCase]);
    I070Count.SQL.Text:='SELECT 0 FROM DUAL';
  end;
  I070Count.Open;
  //Controllo se esiste azienda AZIN
  with QI090 do
    begin
    SetVariable('Azienda','AZIN');
    Open;
    if RecordCount = 0 then
      with OperSQL do
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO I090_ENTI (AZIENDA,UTENTE,PAROLACHIAVE,STORIAINTERVENTO,TSLAVORO,TSINDICI) ' +
                'VALUES (''AZIN'',''MONDOEDP'',''' + R180Cripta(A000PasswordFissa,21041974) + ''',''N'',''LAVORO'',''INDICI'')');
        try
          Execute;
          SessioneMondoEDP.Commit;
        except
          SessioneMondoEDP.RollBack;
        end;
      end;
    end;
  //Controllo se esiste operatore SYSMAN
  with QI070 do
    begin
    Close;
    SetVariable('Azienda','AZIN');
    SetVariable('Utente','SYSMAN');
    Open;
    if RecordCount = 0 then
      with OperSQL do
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO I070_UTENTI (AZIENDA,UTENTE,PROGRESSIVO,PASSWD,OCCUPATO,INTEGRAZIONEANAGRAFE,SBLOCCO) ' +
                'VALUES (''AZIN'',''SYSMAN'',0,''' + R180CriptaI070('LEADER') + ''',''N'',''S'',''N'')');
        if selI070Utenti.FieldByName('NUM').AsInteger = 0 then
          SQL.Text:=StringReplace(SQL.Text,'I070_UTENTI','I070_OPERATORI',[rfReplaceAll,rfIgnoreCase]);
        try
          Execute;
          SessioneMondoEDP.Commit;
        except
          SessioneMondoEDP.RollBack;
        end;
      end;
    end;
end;

procedure TA001FPassWordDtM1.ImpostaParametriStandard;
  function CheckOracleHint(S:String; Condiz:String = ''):String;
  begin
    if (Condiz <> '') and (UpperCase(Copy(S,Length(S) - Length(Condiz) + 1,Length(Condiz))) <> UpperCase(Condiz)) then
    begin
      Result:='';
      exit;
    end;
    if UpperCase(Copy(S,Length(S) - 2,3)) = '+NC' then
      S:=Copy(S,1,Length(S) - 3);
    Result:=S;
    if Pos('/*+',S) <> 1 then
      Result:=''
    else if Pos('*/',S) <> Length(S) - 1 then
      Result:=''
    else
    begin
      S:=StringReplace(S,'/*+','',[]);
      S:=StringReplace(S,'*/','',[]);
      if (Pos('/*+',S) > 0) or (Pos('*/',S) > 0) then
        Result:='';
    end;
  end;
begin
  Log('Traccia','ImpostaParametriStandard.Inizio');
  SessioneIWA001.Parametri.Azienda:=QI090.FieldByName('Azienda').AsString;
  SessioneIWA001.Parametri.DAzienda:=QI090.FieldByName('Descrizione').AsString;
  SessioneIWA001.Parametri.Alias:=QI090.FieldByName('Alias').AsString;
  SessioneIWA001.Parametri.Username:=QI090.FieldByName('Utente').AsString;
  SessioneIWA001.Parametri.Password:=QI090.FieldByName('ParolaChiave').AsString;
  SessioneIWA001.Parametri.CodiceIntegrazione:=QI090.FieldByName('Codice_Integrazione').AsString;
  SessioneIWA001.Parametri.TSLavoro:=QI090.FieldByName('TSLavoro').AsString;
  SessioneIWA001.Parametri.TSIndici:=QI090.FieldByName('TSIndici').AsString;
  SessioneIWA001.Parametri.TSAusiliario:='';
  SessioneIWA001.Parametri.CodContrattoVoci:=GetCodContrattoVoci;
  try SessioneIWA001.Parametri.TSAusiliario:=Trim(QI090.FieldByName('TSAusiliario').AsString); except end;
  if SessioneIWA001.Parametri.TSAusiliario = '' then
    SessioneIWA001.Parametri.TSAusiliario:=SessioneIWA001.Parametri.TSLavoro;
  try SessioneIWA001.Parametri.LogTabelle:=QI090.FieldByName('StoriaIntervento').AsString; except end;
  try SessioneIWA001.Parametri.TimbOrig_Verso:=QI090.FieldByName('TimbOrig_Verso').AsString; except end;
  try SessioneIWA001.Parametri.TimbOrig_Causale:=QI090.FieldByName('TimbOrig_Causale').AsString; except end;
  try SessioneIWA001.Parametri.LunghezzaPassword:=QI090.FieldByName('Lung_Password').AsInteger; except end;
  try SessioneIWA001.Parametri.ValiditaPassword:=QI090.FieldByName('Valid_Password').AsInteger; except end;
  //Regole robustezza password
  SessioneIWA001.Parametri.RegolePassword.PasswordI060:=Parametri.ProfiloWEB <> '';
  try SessioneIWA001.Parametri.RegolePassword.Lunghezza:=QI090.FieldByName('Lung_Password').AsInteger; except end;
  try SessioneIWA001.Parametri.RegolePassword.MesiValidita:=QI090.FieldByName('Valid_Password').AsInteger; except end;
  try SessioneIWA001.Parametri.RegolePassword.Cifre:=QI090.FieldByName('Password_Cifre').AsInteger; except end;
  try SessioneIWA001.Parametri.RegolePassword.Maiuscole:=QI090.FieldByName('Password_Maiuscole').AsInteger; except end;
  try SessioneIWA001.Parametri.RegolePassword.CarSpeciali:=QI090.FieldByName('Password_CarSpeciali').AsInteger; except end;

  try SessioneIWA001.Parametri.GruppoBadge:=QI090.FieldByName('GRUPPO_BADGE').AsString; except end;
  try SessioneIWA001.Parametri.ValiditaUtente:=QI090.FieldByName('VALID_UTENTE').AsInteger; except end;
  try SessioneIWA001.Parametri.RagioneSociale:=R180Decripta(QI090.FieldByName('Ragione_Sociale').AsString,14091943); except end;
  try SessioneIWA001.Parametri.VersioneDB:=QI090.FieldByName('VersioneDB').AsString; except end;
  try SessioneIWA001.Parametri.BuildDB:=QI090.FieldByName('PatchDB').AsString; except end;
  if SessioneIWA001.Parametri.RagioneSociale = 'MONDOEDP' then
    SessioneIWA001.Parametri.RagioneSociale:=SessioneIWA001.Parametri.DAzienda
  else if Trim(SessioneIWA001.Parametri.RagioneSociale) = '' then
    SessioneIWA001.Parametri.RagioneSociale:='VERSIONE NON AUTORIZZATA';
  //Permessi
  try
    QI071.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
    QI071.Open;
    SessioneIWA001.Parametri.AggiornamentoBaseDati:=QI071.FieldByName('CANCELLAZIONE_DATI').AsString;
  except
    SessioneIWA001.Parametri.AggiornamentoBaseDati:='S';
  end;
  //Nel caso di uso del B005, leggo solamente l'abilitazione alla funzione tramite il flag CANCELLAZIONE_DATI, quindi esco perch� i parametri potrebbero non pi� validi con l'aggiornamento
  if Copy(ExtractFileName(Application.ExeName),1,4) = 'B005' then
  begin
    QI071.Close;
    exit;
  end;
  try SessioneIWA001.Parametri.CancellaTimbrature:=QI071.FieldByName('CANCELLA_TIMBRATURE').AsString; except end;
  try SessioneIWA001.Parametri.T100_CancTimbOrig:=QI071.FieldByName('T100_CANC_ORIGINALI').AsString; except end;
  try SessioneIWA001.Parametri.InserisciTimbrature:=QI071.FieldByName('INSERISCI_TIMBRATURE').AsString; except end;
  try SessioneIWA001.Parametri.AbilitaSchedeChiuse:=QI071.FieldByName('ABILITA_SCHEDE_CHIUSE').AsString; except end;
  try SessioneIWA001.Parametri.T100_Ora:=QI071.FieldByName('T100_ORA').AsString; except end;
  try SessioneIWA001.Parametri.T100_Rilevatore:=QI071.FieldByName('T100_RILEVATORE').AsString; except end;
  try SessioneIWA001.Parametri.T100_Causale:=QI071.FieldByName('T100_CAUSALE').AsString; except end;
  try SessioneIWA001.Parametri.A029_Saldi:=QI071.FieldByName('A029_SALDI').AsString; except end;
  try SessioneIWA001.Parametri.A029_Indennita:=QI071.FieldByName('A029_INDENNITA').AsString; except end;
  try SessioneIWA001.Parametri.A029_Straordinario:=QI071.FieldByName('A029_STRAORDINARIO').AsString; except end;
  try SessioneIWA001.Parametri.A029_CauPresenza:=QI071.FieldByName('A029_CAUPRESENZA').AsString; except end;
  try SessioneIWA001.Parametri.LiquidazioneForzata:=QI071.FieldByName('LIQUIDAZIONE_FORZATA').AsString; except end;
  try SessioneIWA001.Parametri.InserimentoMatricole:=QI071.FieldByName('INSERIMENTO_MATRICOLE').AsString; except end;
  try SessioneIWA001.Parametri.Storicizzazione:=QI071.FieldByName('STORICIZZAZIONE').AsString; except end;
  try SessioneIWA001.Parametri.EliminaStorici:=QI071.FieldByName('ELIMINA_STORICI').AsString; except end;
  try SessioneIWA001.Parametri.DefTipoPersonale:=QI071.FieldByName('DEF_TIPO_PERSONALE').AsString; except end;
  try SessioneIWA001.Parametri.ModPersonaleEsterno:=QI071.FieldByName('MOD_PERSONALE_ESTERNO').AsString; except end;
  try SessioneIWA001.Parametri.RipristinoTimbOri:=QI071.FieldByName('RIPRISTINO_TIMB_ORI').AsString; except end;
  try SessioneIWA001.Parametri.MonitorIntegrAnagra:=QI071.FieldByName('MONITOR_INTEGRANAGRA').AsString; except end;
  try SessioneIWA001.Parametri.Layout:=QI071.FieldByName('LAYOUT').AsString; except end;
  try SessioneIWA001.Parametri.A037_EliminaDataCassa:=QI071.FieldByName('ELIMINA_DATA_CASSA').AsString; except end;
  try SessioneIWA001.Parametri.A037_RicreaScaricoPaghe:=QI071.FieldByName('RICREA_SCARICO_PAGHE').AsString; except end;
  try SessioneIWA001.Parametri.C700_SalvaSelezioni:=QI071.FieldByName('C700_SALVASELEZIONI').AsString; except end;
  try SessioneIWA001.Parametri.DatiC700:=QI071.FieldByName('DATIC700').AsString; except end;
  if SessioneIWA001.Parametri.DatiC700 = '' then
    SessioneIWA001.Parametri.DatiC700:='MATRICOLA,T430BADGE,COGNOME,NOME';
  try SessioneIWA001.Parametri.A058_PianifOperativa:=QI071.FieldByName('A058_OPERATIVA').AsString; except end;
  try SessioneIWA001.Parametri.A058_PianifNonOperativa:=QI071.FieldByName('A058_NONOPERATIVA').AsString; except end;
  try SessioneIWA001.Parametri.A094_Mese:=QI071.FieldByName('A094_MESE').AsString; except end;
  try SessioneIWA001.Parametri.A094_Anno:=QI071.FieldByName('A094_ANNO').AsString; except end;
  try SessioneIWA001.Parametri.A094_Raggr:=QI071.FieldByName('A094_RAGGR').AsString; except end;
  try SessioneIWA001.Parametri.A131_AnticipiGestibili:=QI071.FieldByName('A131_ANTICIPIGESTIBILI').AsString; except end;
  try SessioneIWA001.Parametri.A139_ServiziComandati:=QI071.FieldByName('SERVIZI_COMANDATI').AsString; except end;
  try SessioneIWA001.Parametri.A139_ServiziBlocco:=QI071.FieldByName('SERVIZI_BLOCCO').AsString; except end;
  try SessioneIWA001.Parametri.A139_ServiziSblocco:=QI071.FieldByName('SERVIZI_SBLOCCO').AsString; except end;
  try SessioneIWA001.Parametri.S710_SupervisoreValut:=QI071.FieldByName('S710_SUPERVISOREVALUT').AsString; except end;
  try SessioneIWA001.Parametri.S710_ValidaStato:=QI071.FieldByName('S710_VALIDA_STATO').AsString; except end;
  try SessioneIWA001.Parametri.S710_ModValutatore:=QI071.FieldByName('S710_MOD_VALUTATORE').AsString; except end;
  try SessioneIWA001.Parametri.T040_Validazione:=QI071.FieldByName('T040_VALIDAZIONE').AsString; except end;
  try SessioneIWA001.Parametri.WEBIterAssGGPrec:=QI071.FieldByName('WEB_ITERASS_GGPREC').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBIterAssGGSucc:=QI071.FieldByName('WEB_ITERASS_GGSUCC').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBIterTimbGGPrec:=QI071.FieldByName('WEB_ITERTIMB_GGPREC').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBCartelliniDataMin:=QI071.FieldByName('WEB_CARTELLINI_DATAMIN').AsDateTime; except end;
  try SessioneIWA001.Parametri.WEBCartelliniMMPrec:=QI071.FieldByName('WEB_CARTELLINI_MMPREC').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBCartelliniMMSucc:=QI071.FieldByName('WEB_CARTELLINI_MMSUCC').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBCartelliniChiusi:=QI071.FieldByName('WEB_CARTELLINI_CHIUSI').AsString; except end;
  try SessioneIWA001.Parametri.WEBCedoliniDataMin:=QI071.FieldByName('WEB_CEDOLINI_DATAMIN').AsDateTime; except end;
  try SessioneIWA001.Parametri.WEBCedoliniMMPrec:=QI071.FieldByName('WEB_CEDOLINI_MMPREC').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBCedoliniGGEmiss:=QI071.FieldByName('WEB_CEDOLINI_GGEMISS').AsInteger; except end;
  try SessioneIWA001.Parametri.WEBCedoliniFilePDF:=QI071.FieldByName('WEB_CEDOLINI_FILEPDF').AsString; except end;
  try SessioneIWA001.Parametri.ModificaDatiProtetti:=QI071.FieldByName('MODIFICA_DATI_PROTETTI').AsString = 'S'; except end;
  try SessioneIWA001.Parametri.WEBRichiestaConsegnaCed:=QI071.FieldByName('WEB_RICHIESTA_CONSEGNA_CED').AsString; except end;
  try SessioneIWA001.Parametri.WEBRichiestaConsegnaVal:=QI071.FieldByName('WEB_RICHIESTA_CONSEGNA_VAL').AsString; except end;
  try SessioneIWA001.Parametri.WEBNotificaAnomalie:=QI071.FieldByName('WEB_NOTIFICA_ANOMALIE').AsString except end;
  QI071.Close;
  //Filtro Funzioni
  QI073.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
  try
    QI073.Open;
  except
  end;
  QI073.Close;

  //Filtro Dizionario
  QI074.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
  try
    QI074.Open;
  except
  end;
  QI074.Close;

  //Alberto 05/04/2005: il layout deve essere letto sull'azienda di lavoro, e non su MONDOEDP!!!!!!!!
  //(Parametri.Layout viene valorizzato dall'applicativo, su A002UAnagrafeDTM1 e su W001ULogin)
  //T033_LAYOUT di qualsiasi altro utente deve essere disponibile in lettura a MONDOEDP
  //Imposto layout della scheda anagrafica
  A000GetLayout(SessioneIWA001,SessioneMondoEDP);
  selT033.Close;
  //Registro i dati dell'ente
  try
    with QI091 do
    begin
      Close;
      SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
      Open;
      SessioneIWA001.Parametri.CampiRiferimento.C0_DecorrenzaNonBollanti:=VarToStr(Lookup('Tipo','C0_DECORRENZANONBOLLANTI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C1_CedoliniConValuta:=VarToStr(Lookup('Tipo','C1_CEDOLINICONVALUTA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_Budget:=VarToStr(Lookup('Tipo','C2_BUDGET','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_Livello:=VarToStr(Lookup('Tipo','C2_LIVELLO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_Capitolo:=VarToStr(Lookup('Tipo','C2_CAPITOLO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_Articolo:=VarToStr(Lookup('Tipo','C2_ARTICOLO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_Costo_Orario:=VarToStr(Lookup('Tipo','C2_COSTO_ORARIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_WebSrv_Bilancio:=VarToStr(Lookup('Tipo','C2_WEBSRV_BILANCIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C2_Facoltativo:=VarToStr(Lookup('Tipo','C2_FACOLTATIVO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C3_IndPres:=VarToStr(Lookup('Tipo','C3_INDPRES','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C3_IndPres2:=VarToStr(Lookup('Tipo','C3_INDPRES2','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C3_DatoPianificabile:=VarToStr(Lookup('Tipo','C3_DATOPIANIFICABILE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C3_DettGG_TipoI:=VarToStr(Lookup('Tipo','C3_DETTGG_TIPOI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C3_RiepTurni_IndPres:=VarToStr(Lookup('Tipo','C3_RIEPTURNI_INDPRES','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C3_Indennita_Funzione:=VarToStr(Lookup('Tipo','C3_INDENNITA_FUNZIONE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C4_BuoniMensa:=VarToStr(Lookup('Tipo','C4_BUONIMENSA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C5_IntegrazAnag:=VarToStr(Lookup('Tipo','C5_INTEGRAZANAG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C5_Office:=VarToStr(Lookup('Tipo','C5_OFFICE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C6_InizioProva:=VarToStr(Lookup('Tipo','C6_INIZIOPROVA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C6_DurataProva:=VarToStr(Lookup('Tipo','C6_DURATAPROVA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C7_DATO1:=VarToStr(Lookup('Tipo','C7_DATO1','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C7_DATO2:=VarToStr(Lookup('Tipo','C7_DATO2','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C7_DATO3:=VarToStr(Lookup('Tipo','C7_DATO3','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_Missione:=VarToStr(Lookup('Tipo','C8_MISSIONE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_MissioneCommessa:=VarToStr(Lookup('Tipo','C8_MISSIONECOMMESSA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_Sede:=VarToStr(Lookup('Tipo','C8_SEDE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_GestioneMensile:=VarToStr(Lookup('Tipo','C8_GESTIONEMENSILE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_ProtocolloObbligatorio:=VarToStr(Lookup('Tipo','C8_PROTOCOLLO_OBBLIGATORIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032RichiediTipoMissione:=VarToStr(Lookup('Tipo','C8_W032_RICHIEDI_TIPOMISSIONE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032DettaglioGG:=VarToStr(Lookup('Tipo','C8_W032_DETTAGLIOGG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032DocumentoMissioni:=VarToStr(Lookup('Tipo','C8_W032_DOCUMENTO_MISSIONI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032RimborsiDett:=VarToStr(Lookup('Tipo','C8_W032_RIMBORSIDETT','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032RiapriMissione:=VarToStr(Lookup('Tipo','C8_W032_RIAPRI_MISSIONE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032TappeSoloSuDistanziometro:=VarToStr(Lookup('Tipo','C8_W032_TAPPE_SOLO_SU_DISTANZIOMETRO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032MessaggioTappeInesistenti:=VarToStr(Lookup('Tipo','C8_W032_MESSAGGIO_TAPPE_INESISTENTI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032UpdRichiesta:=VarToStr(Lookup('Tipo','C8_W032_UPDRICHIESTA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032ProtocolloManuale:=VarToStr(Lookup('Tipo','C8_W032_PROTOCOLLO_MANUALE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C8_W032MaxAllegati:=VarToStr(QI091.Lookup('Tipo','C8_W032_MAX_ALLEGATI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C9_ScaricoPaghe:=VarToStr(Lookup('Tipo','C9_SCARICOPAGHE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C10_FormazioneProfiloCrediti:=VarToStr(Lookup('Tipo','C10_FORMAZPROFCRED','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C10_FormazioneProfiloCorso:=VarToStr(Lookup('Tipo','C10_FORMAZPROFCORSO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrariProg:=VarToStr(Lookup('Tipo','C11_PIANIFORARIPROG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrari_DebGG:=VarToStr(Lookup('Tipo','C11_PIANIFORARI_DEBGG','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrari_DebGG = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrari_DebGG:='MODELLO ORARIO';
      SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrari_NO_CopiaGiustif:=VarToStr(Lookup('Tipo','C11_PIANIFORARI_NO_COPIAGIUSTIF','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrari_NO_CopiaGiustif = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C11_PianifOrari_NO_CopiaGiustif:='NO';
      SessioneIWA001.Parametri.CampiRiferimento.C12_PreferenzeDestinazione:=VarToStr(Lookup('Tipo','C12_PREFERENZADEST','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C12_PreferenzeCompetenza:=VarToStr(Lookup('Tipo','C12_PREFERENZACOMP','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C13_CdcPercentualizzati:=VarToStr(Lookup('Tipo','C13_CDC_PERCENT','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C14_ProvvSede:=VarToStr(Lookup('Tipo','C14_PROVVSEDE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C15_LimitiMensCaus:=VarToStr(Lookup('Tipo','C15_LIMITIMENSCAUS','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C16_InsRiposi:=VarToStr(Lookup('Tipo','C16_INSRIPOSI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C17_PostiLetto:=VarToStr(Lookup('Tipo','C17_POSTILETTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C18_AccessiMensa:=VarToStr(Lookup('Tipo','C18_ACCESSIMENSA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C19_StoriaInizioFine:=VarToStr(Lookup('Tipo','C19_STORIAINIZIOFINE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C20_IncaricoUnitaOrg:=VarToStr(Lookup('Tipo','C20_INCARICOUNITAORG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniLiv1:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_LIV1','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniLiv2:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_LIV2','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniLiv3:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_LIV3','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniLiv4:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_LIV4','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniRsp1:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_RSP1','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniRsp2:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_RSP2','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C21_ValutazioniPnt1:=VarToStr(Lookup('Tipo','C21_VALUTAZIONI_PNT1','Dato'));
      (*SessioneIWA001.Parametri.CampiRiferimento.C22_PianServLiv1:=VarToStr(Lookup('Tipo','C22_PIANSERV_LIV1','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C22_PianServLiv2:=VarToStr(Lookup('Tipo','C22_PIANSERV_LIV2','Dato'));*)
      SessioneIWA001.Parametri.CampiRiferimento.C23_ContrCompetenze:=VarToStr(Lookup('Tipo','C23_CONTR_COMPETENZE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C23_InsNegCatena:=VarToStr(Lookup('Tipo','C23_INSNEG_CATENA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C23_VMHFruizGG:=VarToStr(Lookup('Tipo','C23_VMH_FRUIZGG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C23_VMHCumuloTriennio:=VarToStr(Lookup('Tipo','C23_VMH_CUMULO_TRIENNIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C24_AziendaTipoBudget:=VarToStr(Lookup('Tipo','C24_AZIENDABUDGET','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C25_TimbIrr_Auto:=VarToStr(Lookup('Tipo','C25_TIMBIRR_AUTO','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C25_TimbIrr_Auto = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C25_TimbIrr_Auto:='N';
      SessioneIWA001.Parametri.CampiRiferimento.C26_HintT030V430:=CheckOracleHint(VarToStr(Lookup('Tipo','C26_HINTT030V430','Dato')));
      SessioneIWA001.Parametri.CampiRiferimento.C26_HintT030V430_NC:=CheckOracleHint(VarToStr(Lookup('Tipo','C26_HINTT030V430','Dato')),'+NC');
      SessioneIWA001.Parametri.CampiRiferimento.C26_V430Materializzata:=VarToStr(Lookup('Tipo','C26_V430MATERIALIZZATA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C27_TablespaceFree:=VarToStr(Lookup('Tipo','C27_TABLESPACE_FREE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C28_CancellaAnnoLog:=VarToStr(Lookup('Tipo','C28_CANCELLA_ANNO_LOG','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C28_CancellaAnnoLog = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C28_CancellaAnnoLog:='99';
      SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepFiltro1:=VarToStr(Lookup('Tipo','C29_CHIAMATEREP_FILTRO1','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepFiltro2:=VarToStr(Lookup('Tipo','C29_CHIAMATEREP_FILTRO2','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepDatiVis:=VarToStr(Lookup('Tipo','C29_CHIAMATEREP_DATIVIS','Dato'));
      // dati modificabili solo se esistono dati visualizzati
      if SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
        SessioneIWA001.Parametri.CampiRiferimento.C29_ChiamateRepDatiModif:=VarToStr(Lookup('Tipo','C29_CHIAMATEREP_DATIMODIF','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_A004_URL:=VarToStr(Lookup('Tipo','C30_WEBSRV_A004_URL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_A004_Dati:=VarToStr(Lookup('Tipo','C30_WEBSRV_A004_DATI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_B021_URL:=VarToStr(QI091.Lookup('Tipo','C30_WEBSRV_B021_URL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_A025_URL_GET:=VarToStr(Lookup('Tipo','C30_WEBSRV_A025_URL_GET','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_A025_URL_PUT:=VarToStr(Lookup('Tipo','C30_WEBSRV_A025_URL_PUT','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_B021_TOKEN:=VarToStr(Lookup('Tipo','C30_WEBSRV_B021_TOKEN','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_B021_PASSPHRASE:=R180Decripta(VarToStr(Lookup('Tipo','C30_WEBSRV_B021_PASSPHRASE','Dato')),I091CryptKey);
      SessioneIWA001.Parametri.CampiRiferimento.C30_WebSrv_B021_TIMEOUT:=VarToStr(Lookup('Tipo','C30_WEBSRV_B021_TIMEOUT','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C31_NoteGiustificativi:=VarToStr(Lookup('Tipo','C31_NOTEGIUSTIFICATIVI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C31_Giustif_GGMG:=VarToStr(Lookup('Tipo','C31_GIUSTIF_GGMG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C32_GestMensile:=VarToStr(Lookup('Tipo','C32_GESTMENSILE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C33_Link_I070_T030:=VarToStr(Lookup('Tipo','C33_LINK_I070_T030','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C35_ResiduiTriggerBefore:=VarToStr(Lookup('Tipo','C35_RESIDUI_TRIGGER_BEFORE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C35_ResiduiTriggerAfter:=VarToStr(Lookup('Tipo','C35_RESIDUI_TRIGGER_AFTER','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C37_NumColAltriProg:=VarToStr(Lookup('Tipo','C37_NUM_COL_ALTRI_PROG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C37_SoloAttRend:=VarToStr(Lookup('Tipo','C37_SOLO_ATT_REND','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C37_TipoTempo:=VarToStr(Lookup('Tipo','C37_TIPO_TEMPO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C37_SezGiustRitardi:=VarToStr(Lookup('Tipo','C37_SEZ_GIUST_RITARDI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C37_CUP:=VarToStr(Lookup('Tipo','C37_CUP','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C37_Logo:=VarToStr(Lookup('Tipo','C37_LOGO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_WebAutorizCurric:=VarToStr(Lookup('Tipo','C90_WEBAUTORIZCURRIC','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailW010Uff:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_W010UFF','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailW018Uff:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_W018UFF','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailSMTPHost:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_SMTPHOST','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailUserName:=VarToStr(QI091.LookUp('Tipo','C90_EMAIL_USERNAME','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailHeloName:=VarToStr(QI091.LookUp('Tipo','C90_EMAIL_HELONAME','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailPassWord:=R180Decripta(VarToStr(QI091.LookUp('Tipo','C90_EMAIL_PASSWORD','Dato')),30011945);
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailPort:=VarToStr(QI091.LookUp('Tipo','C90_EMAIL_PORT','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailRespOttimizzata:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_OTTIMIZZATA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailRespGGReinvio:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_GG_REINVIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailRespOggetto:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_OGGETTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailRespTesto:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_TESTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailSenderIndirizzo:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_SENDER_INDIRIZZO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailAuthType:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_AUTHTYPE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EMailUseTLS:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_USETLS','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_WebRighePag:=VarToStr(QI091.Lookup('Tipo','C90_WEBRIGHEPAG','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_WebTipoCambioOrario:=VarToStr(QI091.Lookup('Tipo','C90_WEBTIPOCAMBIOORARIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_WebSettCambioOrario:=VarToStr(QI091.Lookup('Tipo','C90_WEBSETTCAMBIOORARIO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W003MsgAccesso:=VarToStr(QI091.Lookup('Tipo','C90_W003MSGACCESSO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W005Settimane:=VarToStr(QI091.Lookup('Tipo','C90_W005SETTIMANE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W005Riepilogo:=VarToStr(QI091.Lookup('Tipo','C90_W005RIEPILOGO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W009PathPdf:=VarToStr(QI091.Lookup('Tipo','C90_W009PATH_PDF','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W009FilePdf:=VarToStr(QI091.Lookup('Tipo','C90_W009FILE_PDF','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W010CausPres:=VarToStr(QI091.Lookup('Tipo','C90_W010CAUS_PRES','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W024MMIndietro:=VarToStr(QI091.Lookup('Tipo','C90_W024MMINDIETRO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W024AggScheda:=VarToStr(QI091.Lookup('Tipo','C90_W024AGGSCHEDA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026CausE:=VarToStr(QI091.Lookup('Tipo','C90_W026CAUS_E','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026CausU:=VarToStr(QI091.Lookup('Tipo','C90_W026CAUS_U','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026TipoRichiesta:=VarToStr(QI091.Lookup('Tipo','C90_W026TIPO_RICHIESTA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026Spezzoni:=VarToStr(QI091.Lookup('Tipo','C90_W026SPEZZONI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026TipoAutorizzazione:=VarToStr(QI091.Lookup('Tipo','C90_W026TIPO_AUTORIZZAZIONE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026TipoStraord:=VarToStr(QI091.Lookup('Tipo','C90_W026TIPO_STRAORD','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026UtilizzoDal:=VarToStr(QI091.Lookup('Tipo','C90_W026UTILIZZO_DAL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026UtilizzoAl:=VarToStr(QI091.Lookup('Tipo','C90_W026UTILIZZO_AL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026EccedGGTutta:=VarToStr(QI091.Lookup('Tipo','C90_W026ECCEDGG_TUTTA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026CheckSaldoDisponibile:=VarToStr(QI091.Lookup('Tipo','C90_W026CHECKSALDODISPONIBILE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026MMIndietroDal:=VarToStr(QI091.Lookup('Tipo','C90_W026MMINDIETRODAL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026MMIndietroAl:=VarToStr(QI091.Lookup('Tipo','C90_W026MMINDIETROAL','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026Arrotondamento:=VarToStr(QI091.Lookup('Tipo','C90_W026ARROTONDAMENTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026SpezzoneMinimo:=VarToStr(QI091.Lookup('Tipo','C90_W026SPEZZONEMINIMO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026EccedOltreDebito:=VarToStr(QI091.Lookup('Tipo','C90_W026ECCEDOLTREDEBITO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni:='N';//VarToStr(QI091.Lookup('Tipo','C90_W026CONFERMA_AUTORIZZAZIONI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_NomeProfiloDelega:=VarToStr(QI091.Lookup('Tipo','C90_NOMEPROFILODELEGA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_EmailThread:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_THREAD','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_Lingua:=VarToStr(QI091.Lookup('Tipo','C90_LINGUA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W010AcquisizioneAuto:=VarToStr(QI091.Lookup('Tipo','C90_W010ACQUISIZIONE_AUTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_W018AcquisizioneAuto:=VarToStr(QI091.Lookup('Tipo','C90_W018ACQUISIZIONE_AUTO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_MessaggisticaReply:=VarToStr(QI091.Lookup('Tipo','C90_MESSAGGISTICA_REPLY','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_FiltroDeleghe:=VarToStr(QI091.Lookup('Tipo','C90_FILTRO_DELEGHE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_MessaggisticaObbligoLettura:=VarToStr(QI091.Lookup('Tipo','C90_MESSAGGISTICA_OBBLIGOLETTURA','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_CronologiaNote:=VarToStr(QI091.Lookup('Tipo','C90_CRONOLOGIA_NOTE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_PathAllegati:=VarToStr(QI091.Lookup('Tipo','C90_PATH_ALLEGATI','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C90_PathAllegati = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C90_PathAllegati:='DB';
      SessioneIWA001.Parametri.CampiRiferimento.C90_IterMaxAllegati:=VarToStr(QI091.Lookup('Tipo','C90_ITER_MAX_ALLEGATI','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB:=VarToStr(QI091.Lookup('Tipo','C90_ITER_MAX_DIM_ALLEGATO_MB','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_IterEstensioneAllegato:=VarToStr(QI091.Lookup('Tipo','C90_ITER_ESTENSIONE_ALLEGATO','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_CancellaAnnoAllegatiIter:=VarToStr(Lookup('Tipo','C90_CANCELLA_ANNO_ALLEGATI_ITER','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C90_CancellaAnnoAllegatiIter = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C90_CancellaAnnoAllegatiIter:='99';
      SessioneIWA001.Parametri.CampiRiferimento.C90_PreavvisoDelAllegati:=VarToStr(Lookup('Tipo','C90_GG_PREAVVISO_CANCELLA_ALLEGATI','Dato'));
      if SessioneIWA001.Parametri.CampiRiferimento.C90_PreavvisoDelAllegati = '' then
        SessioneIWA001.Parametri.CampiRiferimento.C90_PreavvisoDelAllegati:='30';
      SessioneIWA001.Parametri.CampiRiferimento.C90_WC38Tolleranza_E:=VarToStr(QI091.Lookup('Tipo','C90_WC38TOLLERANZA_E','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_WC38Tolleranza_U:=VarToStr(QI091.Lookup('Tipo','C90_WC38TOLLERANZA_U','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_WC38Rilevatore:=VarToStr(QI091.Lookup('Tipo','C90_WC38RILEVATORE','Dato'));
      SessioneIWA001.Parametri.CampiRiferimento.C90_WC38TimbCausalizzabile:=VarToStr(QI091.Lookup('Tipo','C90_W038TIMBCAUSALIZZABILE','Dato'));
      try
        SessioneIWA001.Parametri.CampiRiferimento.C99_DecorrenzaTAS000000233536:=StrToDate(VarToStr(QI091.Lookup('Tipo','C99_DECORRENZA_TAS000000233536','Dato')));
      except
        SessioneIWA001.Parametri.CampiRiferimento.C99_DecorrenzaTAS000000233536:=DATE_MAX;
      end;
      try
        SessioneIWA001.Parametri.CampiRiferimento.C99_DecorrenzaTAS000000240638:=StrToDate(VarToStr(QI091.Lookup('Tipo','C99_DECORRENZA_TAS000000240638','Dato')));
      except
        SessioneIWA001.Parametri.CampiRiferimento.C99_DecorrenzaTAS000000240638:=DATE_MAX;
      end;
      Close;
    end;
  except
  end;
  //Registro le tabelle su cui � attivato il Log
  try
    with QI092 do
    begin
      Close;
      SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
      Open;
      SessioneIWA001.Parametri.NomiTabelleLog.Clear;
      while not Eof do
      begin
        SessioneIWA001.Parametri.NomiTabelleLog.Add(FieldByName('SCHEDA').AsString);
        Next;
      end;
      Close;
    end;
  except
  end;
  //Registro versione oracle in uso
  with TOracleQuery.Create(Self) do
  try
    Session:=SessioneMondoEDP;
    SQL.Text:='select version from v$instance';
    try
      Execute;
      SessioneIWA001.Parametri.VersioneOracle:=StrToIntDef(Copy(FieldAsString(0),1,Pos('.',FieldAsString(0))-1),0);
    except
      SessioneIWA001.Parametri.VersioneOracle:=0;
    end;
  finally
    Free;
  end;
  Log('Traccia','ImpostaParametriStandard.Fine');
end;

function TA001FPassWordDtM1.GetCodContrattoVoci:String;
begin
  Result:='EDP';
  try
    selP210.SetVariable('SCHEMA',SessioneIWA001.Parametri.Username);
    selP210.Open;
    if not selP210.Eof then
    begin
      if selP210.RecordCount = 1 then
        Result:=selP210.FieldByName('COD_CONTRATTO').AsString
      else if selP210.SearchRecord('COD_CONTRATTO','EDP',[srFromBeginning]) then
        Result:='EDP'
      else if selP210.SearchRecord('COD_CONTRATTO','EDPEL',[srFromBeginning]) then
        Result:='EDPEL';
    end;
  except
  end;
  selP210.Close;
end;

procedure TA001FPassWordDtM1.RegistraInibizioni;
var
  Riga: String;
begin
  SessioneIWA001.Parametri.Inibizioni.Clear;
  SessioneIWA001.Parametri.OperBloc:=I070Count.Fields[0].AsInteger > 0;
  SessioneIWA001.Parametri.Operatore:=QI070.FieldByName('Utente').AsString;
  SessioneIWA001.Parametri.Azienda:=QI090.FieldByName('Azienda').AsString;
  SessioneIWA001.Parametri.PassOper:=R180DecriptaI070(QI070.FieldByName('PassWD').AsString);
  SessioneIWA001.Parametri.ProgOper:=QI070.FieldByName('Progressivo').AsInteger;
  SessioneIWA001.Parametri.TipoOperatore:='I070';
  try SessioneIWA001.Parametri.IntegrazioneAnagrafe:=QI070.FieldByName('IntegrazioneAnagrafe').AsString; except end;
  try SessioneIWA001.Parametri.ValiditaCessati:=QI070.FieldByName('Validita_cessati').AsInteger; except end;

  QI071.SetVariable('PROFILO',QI070.FieldByName('PERMESSI').AsString);
  QI071.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
  QI072.SetVariable('PROFILO',QI070.FieldByName('FILTRO_ANAGRAFE').AsString);
  QI072.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
  QI073.SetVariable('PROFILO',QI070.FieldByName('FILTRO_FUNZIONI').AsString);
  QI073.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
  QI074.SetVariable('PROFILO',QI070.FieldByName('FILTRO_DIZIONARIO').AsString);
  QI074.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);

  //Filtro Anagrafe
  try
    QI072.Open;
    with QI072 do
    begin
      First;
      while not Eof do
      begin
        Riga:=FieldByName('Filtro').AsString;
        // sostituzione variabile :NOME_UTENTE
        Riga:=StringReplace(Riga,':NOME_UTENTE','''' + Parametri.Operatore + '''',[rfReplaceAll,rfIgnoreCase]);
        if (Pos('--',Riga) > 0) and (R180NumOccorrenzeCar(Copy(Riga,1,Pos('--',Riga) - 1),'''') mod 2 = 0) then
          Riga:=Copy(Riga,1,Pos('--',Riga) - 1);
        SessioneIWA001.Parametri.Inibizioni.Add(Riga);
        Next;
      end;
      SessioneIWA001.Parametri.Inibizioni.Text:=Trim(SessioneIWA001.Parametri.Inibizioni.Text);
      if SessioneIWA001.Parametri.Inibizioni.Text <> '' then
        SessioneIWA001.Parametri.Inibizioni.Text:='(' + SessioneIWA001.Parametri.Inibizioni.Text + ')';
    end;
    QI072.Close;
  except
  end;
  //Imposta SessioneIWA001.Parametri standard
  ImpostaParametriStandard;
end;

function TA001FPassWordDtM1.RegistraInibizioniInfo(NomeProfilo:String = ''):boolean;
var
  Riga: String;
begin
  Log('Traccia','RegistraInibizioniInfo.Inizio');
  QI071.Close;
  QI072.Close;
  QI073.Close;
  QI074.Close;

  SessioneIWA001.Parametri.Inibizioni.Clear;
  SessioneIWA001.Parametri.Operatore:=QI060.FieldByName('Nome_Utente').AsString;
  SessioneIWA001.Parametri.Azienda:=QI090.FieldByName('Azienda').AsString;
  SessioneIWA001.Parametri.PassOper:=R180Decripta(QI060.FieldByName('PassWord').AsString,30011945);
  SessioneIWA001.Parametri.ProfiloWEB:='';
  SessioneIWA001.Parametri.TipoOperatore:='I060';

  selI061.Close;
  selI061.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
  selI061.SetVariable('NOME_UTENTE',SessioneIWA001.Parametri.Operatore);
  selI061.Open;

  Result:=True;
  if (selI061.SearchRecord('NOME_PROFILO',NomeProfilo,[srFromBeginning])) or (selI061.RecordCount = 1) then
  begin
    SessioneIWA001.Parametri.ProfiloWEB:=selI061.FieldByName('NOME_PROFILO').AsString;
    SessioneIWA001.Parametri.ProfiloFiltroFunzioni:=selI061.FieldByName('FILTRO_FUNZIONI').AsString;

    // MONZA_HSGERARDO - chiamata 88132.ini
    // salva il nome del delegante, se presente
    SessioneIWA001.Parametri.ProfiloWEBDelegatoDa:=selI061.FieldByName('DELEGATO_DA').AsString;
    // MONZA_HSGERARDO - chiamata 88132.fine

    QI071.SetVariable('PROFILO',selI061.FieldByName('PERMESSI').AsString);
    QI071.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
    QI072.SetVariable('PROFILO',selI061.FieldByName('FILTRO_ANAGRAFE').AsString);
    QI072.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
    QI073.SetVariable('PROFILO',selI061.FieldByName('FILTRO_FUNZIONI').AsString);
    QI073.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
    QI074.SetVariable('PROFILO',selI061.FieldByName('FILTRO_DIZIONARIO').AsString);
    QI074.SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
    Parametri.ProfiloWebIterAutorizzativi:=selI061.FieldByName('ITER_AUTORIZZATIVI').AsString;
  end
  else
  begin
    Result:=False;
    exit;
  end;

  //Filtro Anagrafe
  QI072.Open;
  with QI072 do
  begin
    First;
    if RecordCount > 0 then
    begin
      while not Eof do
      begin
        Riga:=Trim(FieldByName('Filtro').AsString);
        // sostituzione variabile :NOME_UTENTE
        if selI061.FieldByName('DELEGATO_DA').IsNull then
          Riga:=StringReplace(Riga,':NOME_UTENTE','''' + Parametri.Operatore + '''',[rfReplaceAll,rfIgnoreCase])
        else
          Riga:=StringReplace(Riga,':NOME_UTENTE','''' + selI061.FieldByName('DELEGATO_DA').AsString + '''',[rfReplaceAll,rfIgnoreCase]);
        if (Pos('--',Riga) > 0) and (R180NumOccorrenzeCar(Copy(Riga,1,Pos('--',Riga) - 1),'''') mod 2 = 0) then
          Riga:=Copy(Riga,1,Pos('--',Riga) - 1);
        if Trim(Riga) <> '' then
          SessioneIWA001.Parametri.Inibizioni.Add(Riga);
        Next;
      end;
      SessioneIWA001.Parametri.Inibizioni.Text:=Trim(SessioneIWA001.Parametri.Inibizioni.Text);
      if SessioneIWA001.Parametri.Inibizioni.Text <> '' then
        SessioneIWA001.Parametri.Inibizioni.Text:='(' + SessioneIWA001.Parametri.Inibizioni.Text + ')';
    end
    else
    begin
      SessioneIWA001.Parametri.InibizioneIndividuale:=True;
      SessioneIWA001.Parametri.Inibizioni.Add('(MATRICOLA = ''' + QI060.FieldByName('MATRICOLA').AsString + ''')');
    end;
  end;
  QI072.Close;

  //Imposta SessioneIWA001.Parametri standard
  ImpostaParametriStandard;
  Log('Traccia','RegistraInibizioniInfo.Fine');
end;

procedure TA001FPassWordDtM1.QI073AfterOpen(DataSet: TDataSet);
{Registro le inibizioni sulle funzioni}
  function ModuloEsistente(T:Integer):Boolean;
  var i:Integer;
  begin
    Result:=False;
    for i:=1 to High(FunzioniDisponibili) do
      //if ((FunzioniDisponibili[i].A = SessioneIWA001.Parametri.Applicazione) or (FunzioniDisponibili[i].M = 'IRIS_WEB')) and
      if (FunzioniDisponibili[i].T = T) and
         ((FunzioniDisponibili[i].M = 'IRIS_WEB') or L021VerificaApplicazione(Parametri.Applicazione,i))
      then
      begin
        if (Trim(FunzioniDisponibili[i].M) = '')  //non � modulo accessorio
           or
           //funzioni comuni (iris e web): verifico esistenza modulo accessorio (IRIS_WEB, MONITORAGGIO_LOG)
            (R180In(FunzioniDisponibili[i].A,['IRIS','FUNWEB']) and
             selI080.SearchRecord('MODULO',R180Cripta(FunzioniDisponibili[i].M,14091943),[srFromBeginning]))
           or
           //funzioni specifiche: verifico essitenza modulo accessorio per l'applicativo di riferimento
           ((FunzioniDisponibili[i].A <> 'FUNWEB') and (FunzioniDisponibili[i].A <> 'IRIS') and
            selI080.SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(FunzioniDisponibili[i].A,14091943),R180Cripta(FunzioniDisponibili[i].M,14091943)]),[srFromBeginning])) then
        begin
          Result:=True;
          {$IFDEF IRISWEB}{$IFNDEF WEBPJ}
            //Funzioni di IrisWEB + Cartoline Mensa e Buoni Pasto
            if (FunzioniDisponibili[i].M <> 'IRIS_WEB') and (not R180In(T,[28,36])) then
              Result:=False;//Continue;
          {$ENDIF}{$ENDIF}
        end
        else if (T = 137) and (FunzioniDisponibili[i].S = 'A071') then
        begin
          Result:=selI080.SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(FunzioniDisponibili[i].A,14091943),R180Cripta('CONTEGGIO_PASTI',14091943)]),[srFromBeginning]);
        end;
        Break;
      end;
  end;
begin
  with selI080 do
  begin
    SetVariable('AZIENDA',SessioneIWA001.Parametri.Azienda);
    Open;

    Parametri.ModuliInstallati:='';
    First;
    while not Eof do
    begin
      if R180Decripta(FieldByName('APPLICAZIONE').AsString,14091943) = IfThen(Parametri.Applicazione <> '',Parametri.Applicazione,'RILPRE') then
        Parametri.ModuliInstallati:=Parametri.ModuliInstallati + R180Decripta(FieldByName('MODULO').AsString,14091943) + #13#10;
      Next;
    end;
  end;

  with QI073 do
  begin
    Filtered:=False;
    //Filter:='GRUPPO <> ''Funzioni WEB''';
    Filter:='(TAG = 100) or (TAG = 83) or (TAG = 87)';
    Filtered:=True;
    if (RecordCount = 0) and (SessioneIWA001.Parametri.Applicazione <> '') and (SessioneIWA001.Parametri.Operatore = 'SYSMAN') then
    begin
      SetLength(SessioneIWA001.Parametri.AbilitazioniFunzioni,3);
      with SessioneIWA001.Parametri.AbilitazioniFunzioni[0] do
      begin
        Funzione:='OpenA008Operatori';
        Descrizione:='Aziende/Operatori';
        Tag:=100;
        Inibizione:='S';
        // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.ini
        AccessoBrowse:='S';
        RighePagina:=0;
        // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.fine
      end;
      with SessioneIWA001.Parametri.AbilitazioniFunzioni[1] do
      begin
        Funzione:='OpenWA180';
        Descrizione:='Operatori';
        Tag:=83;
        Inibizione:='S';
        // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.ini
        AccessoBrowse:='S';
        RighePagina:=0;
        // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.fine
      end;
      with SessioneIWA001.Parametri.AbilitazioniFunzioni[2] do
      begin
        Funzione:='OpenWA184';
        Descrizione:='Filtro funzioni';
        Tag:=87;
        Inibizione:='S';
        // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.ini
        AccessoBrowse:='S';
        RighePagina:=0;
        // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.fine
      end;
      Filtered:=False;
    end
    else
    begin
      Filtered:=False;
      First;
      SetLength(SessioneIWA001.Parametri.AbilitazioniFunzioni,0);
      while not Eof do
      begin
        if ModuloEsistente(FieldByName('Tag').AsInteger) then
        begin
          SetLength(SessioneIWA001.Parametri.AbilitazioniFunzioni,High(SessioneIWA001.Parametri.AbilitazioniFunzioni) + 2);
          with SessioneIWA001.Parametri.AbilitazioniFunzioni[High(SessioneIWA001.Parametri.AbilitazioniFunzioni)] do
          begin
            Funzione:=UpperCase(FieldByName('Funzione').AsString);
            Descrizione:=UpperCase(FieldByName('Descrizione').AsString);
            Tag:=FieldByName('Tag').AsInteger;
            Inibizione:=R180CarattereDef(FieldByName('Inibizione').AsString,1,'N');
            // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.ini
            AccessoBrowse:=FieldByName('ACCESSO_BROWSE').AsString;
            RighePagina:=FieldByName('RIGHE_PAGINA').AsInteger;
            // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.fine
          end;
        end;
        Next;
      end;
    end;
  end;
end;

procedure TA001FPassWordDtM1.QI074AfterOpen(DataSet: TDataSet);
begin
  SetLength(SessioneIWA001.Parametri.FiltroDizionario,0);
  with QI074 do
    while not Eof do
    begin
      SetLength(SessioneIWA001.Parametri.FiltroDizionario,High(SessioneIWA001.Parametri.FiltroDizionario) + 2);
      with SessioneIWA001.Parametri.FiltroDizionario[High(SessioneIWA001.Parametri.FiltroDizionario)] do
      begin
        Tabella:=FieldByName('TABELLA').AsString;
        Codice:=FieldByName('CODICE').AsString;
        Abilitato:=FieldByName('ABILITATO').AsString = 'S';
        Cestino:=False;
      end;
      Next;
    end;
end;

function TA001FPassWordDtM1.AutenticazioneDominio(const DomainName, UserName, Password:String; TipoAutenticazione:String = 'NTLM'; LDAP_DN:String = ''):Boolean;
var AdsOO:Integer;
    Obj:IADs;
    dom:IADsContainer;
    lUser:String;
begin
  // originale
  Result:=False;
  if TipoAutenticazione = 'NTLM' then
    Result:=SSPLogonUser(DomainName, UserName, Password)
  else if TipoAutenticazione = 'AD' then
  begin
     if (not IsLibrary) then
       CoInitialize(nil);
     try
       ADsOO:=ADsOpenObject('WinNT://'+DomainName,UserName,Password,ADS_SECURE_AUTHENTICATION,IADs,Obj);
       Result:=Succeeded(ADsOO);
     except
       Result:=False;
     end;
     if (not IsLibrary) then
       CoUninitialize;
  end
  else if TipoAutenticazione = 'LDAP' then
  begin
     if (not IsLibrary) then
       CoInitialize(nil);
     try
       if Pos(':nome_utente',LDAP_DN.ToLower) = 0 then
         ADsOO:=ADsOpenObject('LDAP://' + DomainName,UserName,Password,ADS_SECURE_AUTHENTICATION,IADs,dom)
       else
       begin
         lUser:=StringReplace(LDAP_DN,':nome_utente',UserName,[rfIgnoreCase]);
         ADsOO:=ADsOpenObject('LDAP://' + DomainName,lUser,Password,0,IADs,dom)
       end;
       Result:=ADsOO = S_OK;
     except
       Result:=False;
     end;
     if (not IsLibrary) then
       CoUninitialize;
  end;
end;

procedure TA001FPassWordDtM1.Log(Tipo,S:String);
begin
  {$IFDEF IRISWEB}{$IFNDEF WEBSVC}
  if GGetWebApplicationThreadVar.ActiveForm <> nil then
    (GGetWebApplicationThreadVar.ActiveForm as TWR010FBase).Log(Tipo,S);
  {$ENDIF}{$ENDIF}
end;

procedure TA001FPassWordDtM1.A001FPassWordDtM1Destroy(Sender: TObject);
begin
  QI090.Close;
  QI070.Close;
  QI071.Close;
  QI072.Close;
  QI073.Close;
  QI074.Close;
  I070Count.Close;
  //SessioneMondoEDP.LogOff;
  try
    if (SessioneMondoEDP <> nil) and (SessioneMondoEDP.Name = 'SessioneMondoEDPA001') then
    begin
      SessioneMondoEDP.LogOff;
      FreeAndNil(SessioneMondoEDP);
    end;
  except
  end;
end;

end.

