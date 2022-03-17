unit RegistrazioneLog;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Math, Classes, Graphics, Controls,
  Forms, Dialogs, Db, Oracle, OracleData, Variants, C180FunzioniGenerali,
  A000UCostanti, A000USessione, System.SyncObjs, medpBackupOldValue;

type
  TSchede = record
    Cod,Desc:String;
  end;

  TForeignKeyRef = record
    Tab,Col,
    TabRef,ColRef,ColSel:String;
  end;

  TRegistraLog = class(TOracleQuery)
  private
    SeqI000:TOracleQuery;
    InsI001:TOracleDataSet;
    SelForeignKey:TOracleDataSet;
    LogAbilitato,UltimaRegistrazione:Boolean;
    FTabella:String;
    FMaschera:String;
    FID:LongInt;
    function SessioneOracle:TOracleSession;
    function Parametri:TParametri;
    function GetOldValue(DataSet:TDataSet;NomeCampo:String):Variant;
  public
    ID:LongInt;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure SettaProprieta(Operazione,Tabella,Maschera:String; ODS:TDataSet; Resetta:Boolean);
    procedure RegistraOperazione{(Commit:Boolean = True)};
    procedure InserisciDato(Colonna,Valore_Old,Valore_New:String);
  end;

  // gestione informazioni visualizzabili come dettaglio dei messaggi
  TMsgInfo = (miData, miAzienda, miMessaggio);
  TMsgInfoSet = set of TMsgInfo;

  TRegistraMsg = class(TOracleQuery)
  private
    PrimaVolta:Boolean;
    SeqI005:TOracleQuery;
    InsI006:TOracleQuery;
    delI005:TOracleQuery;
    FSessioneOracleApp:TOracleSession;
    function Parametri:TParametri;
    procedure setSessioneOracleApp(const Value: TOracleSession);
  public
    selI005:TOracleDataSet;
    ID:LongInt;
    ContieneTipoA,ContieneTipoI,ContieneTipoB: Boolean;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure IniziaMessaggio(Maschera:String);
    procedure InserisciMessaggio(Tipo,Msg:String; Azienda:String = ''; Prog:Integer = 0);
    procedure InserisciMessaggioList(Tipo:String; Msg:TStrings; Azienda:String = ''; Prog:Integer = -1);
    procedure LeggiMessaggi(Id: LongInt; Tipo: String = ''); overload;
    procedure LeggiMessaggi(Maschera: String; Tipo: String=''; LastIdOnly: Boolean = False); overload;
    procedure GetListaMessaggi(Lista:TStrings; MaxElementi:Integer = -1;
      SeparatoreID:String = ''; MsgInfoSet: TMsgInfoSet = [miData, miAzienda, miMessaggio]);
    property SessioneOracleApp:TOracleSession read FSessioneOracleApp write setSessioneOracleApp;
  end;

  const ForeignKeyRef:array[0..0] of TForeignKeyRef = (
    (Tab:'P442_CEDOLINOVOCI';Col:'ID_CEDOLINO';TabRef:'P441_CEDOLINO';ColRef:'ID_CEDOLINO';ColSel:'PROGRESSIVO,DATA_CEDOLINO,DATA_RETRIBUZIONE,TIPO_CEDOLINO')
    );

procedure Register;

implementation

uses A000UInterfaccia;

procedure Register;
begin
  RegisterComponents('Samples', [TRegistraLog]);
end;

constructor TRegistraLog.Create(AOwner:TComponent);
var
  TempHost,TempIP,Err: String;
begin
  inherited Create(AOwner);
  // commessa MAN/02 - svil.82.ini
  //SQL.Add('INSERT /*+ APPEND */ INTO I000_LOGINFO (ID,OPERATORE,MASCHERA,TABELLA,OPERAZIONE)');
  //SQL.Add('VALUES (:ID,:OPERATORE,:MASCHERA,:TABELLA,:OPERAZIONE)');
  SQL.Add('INSERT /*+ APPEND */ INTO I000_LOGINFO (ID,OPERATORE,MASCHERA,TABELLA,OPERAZIONE,HOSTNAME,HOSTIPADDRESS)');
  SQL.Add('VALUES (:ID,:OPERATORE,:MASCHERA,:TABELLA,:OPERAZIONE,:HOSTNAME,:HOSTIPADDRESS)');
  // commessa MAN/02 - svil.82.fine
  DeclareVariable('ID',otInteger);
  DeclareVariable('OPERATORE',otString);
  DeclareVariable('MASCHERA',otString);
  DeclareVariable('TABELLA',otString);
  DeclareVariable('OPERAZIONE',otString);

  // commessa MAN/02 - svil.82.ini
  DeclareVariable('HOSTNAME',otString);
  DeclareVariable('HOSTIPADDRESS',otString);
  if not R180GetIPFromHost(TempHost,TempIP,Err) then
  begin
    TempHost:='localhost';
    TempIP:='127.0.0.1';
  end;
  SetVariable('HOSTNAME',TempHost);
  SetVariable('HOSTIPADDRESS',TempIP);
  // commessa MAN/02 - svil.82.fine

  SeqI000:=TOracleQuery.Create(nil);
  SeqI000.SQL.Add('SELECT I000_ID.NEXTVAL FROM DUAL');

  InsI001:=TOracleDataSet.Create(nil);
  InsI001.CachedUpdates:=True;
  InsI001.SQL.Add('SELECT T1.*,ROWID FROM I001_LOGDATI T1 WHERE ID < 0');

  SelForeignKey:=TOracleDataSet.Create(nil);
  UltimaRegistrazione:=False;
end;

function TRegistraLog.SessioneOracle:TOracleSession;
begin
  if Owner is TOracleSession then
    Result:=TOracleSession(Owner)
  else if Owner is TSessioneIrisWin then
    Result:=TSessioneIrisWin(Owner).SessioneOracle
  else
    Result:=A000UInterfaccia.SessioneOracle;
end;

function TRegistraLog.Parametri:TParametri;
begin
  if Owner is TSessioneIrisWin then
    Result:=TSessioneIrisWin(Owner).Parametri
  else if (Owner is (TOracleSession)) and (TOracleSession(Owner).Owner is TSessioneIrisWin) then
    Result:=TSessioneIrisWin(TOracleSession(Owner).Owner).Parametri
  else
    Result:=A000UInterfaccia.Parametri;
end;

function TRegistraLog.GetOldValue(DataSet:TDataSet;NomeCampo:String):Variant;
{Usato per accedere agli OldValue, gestendo il caso in cui il dataset.State = dsInsert.
 In tal caso, con D10.2.3 OldValue rimane unAssigned.
 In questo contesto di RegistraLog, ci si aspetta che OldValue venga chiamato solo quando Operazione = 'M',
 che normalmente coincide con dataset.State = dsEdit.
 Eccezione nota: A023 che registra operazione = 'M' con dataset.State = dsInsert nella gestione della timbratura Originale -> Manuale}
var
  DataSetOldValues:TmedpBackupOldValue;
  RegistraMsgLog:TRegistraMsg;
  I:Integer;
  Trovato:Boolean;
  S:String;
begin
  Result:=null;
  Trovato:=False;
  DataSetOldValues:=nil;
  if DataSet.State = dsInsert then
  begin
    // E' stato previsto un medpBackupOldValue con i vecchi valori?
    for I:=0 to (DataSet.ComponentCount - 1) do
    begin
      if DataSet.Components[I] is TmedpBackupOldValue then
      begin
        DataSetOldValues:=(DataSet.Components[I] as TmedpBackupOldValue);
        if DataSetOldValues.Active and
           (DataSetOldValues.RecordCount > 0) and
           (DataSetOldValues.FindField(NomeCampo) <> nil) then
          begin
            Result:=DataSetOldValues.FieldByName(NomeCampo).Value;
            Trovato:=True;
            Break;
          end;
      end;
    end;
  end
  else
  begin
    Result:=DataSet.FieldByName(NomeCampo).medpOldValue;
    Trovato:=True;
  end;

  if not Trovato then
  begin
    RegistraMsgLog:=TRegistraMsg.Create(Session);
    try
      if DataSetOldValues = nil then
        S:='Dataset OldValues = nil'
      else if not DataSetOldValues.Active then
        S:='DataSet OldValues.Active = False'
      else if DataSetOldValues.RecordCount = 0 then
        S:='DataSet OldValues.RecordCount = 0'
      else if DataSetOldValues.FindField(NomeCampo) = nil then
        S:='DataSet OldValues.FindField(NomeCampo) = nil'
      else
        S:='Errore sconosciuto';

      RegistraMsgLog.IniziaMessaggio(FMaschera);
      RegistraMsgLog.InserisciMessaggio(
        'A',
        Format('TRegistraLog.GetOldValue: Maschera=%s, Tabella=%s, ID=%d, Colonna=%s, Valore_New=%s - %s',
               [FMaschera,
                FTabella,
                FID,
                AggiungiApice(NomeCampo),
                AggiungiApice(DataSet.FieldByName(NomeCampo).AsString),
                S]),
        '',
        0
      );
    finally
      FreeAndNil(RegistraMsgLog);
    end;
  end;
end;

procedure TRegistraLog.SettaProprieta(Operazione,Tabella,Maschera:String; ODS:TDataSet; Resetta:Boolean);
var i:Integer;
    D:TDateTime;
    S,OldValore:String;
begin
  //Dati usati da GetOldValue
  FTabella:=Tabella;
  FMaschera:=Maschera;
  FID:=IfThen(Resetta,-1,ID);

  if SeqI000.Session = nil then
    SeqI000.Session:=SessioneOracle;
  if InsI001.Session = nil then
    InsI001.Session:=SessioneOracle;
  if SelForeignKey.Session = nil then
    SelForeignKey.Session:=SessioneOracle;
  if (not Resetta) and (not UltimaRegistrazione) then
    Resetta:=True;
  {Maschera: R250 -> A103}
  if Maschera = 'R250' then
    Maschera:='A103';
  LogAbilitato:=(Operazione = 'A') or ((Parametri.LogTabelle = 'S') and (Parametri.NomiTabelleLog.IndexOf(Maschera) >= 0));
  if not LogAbilitato then
    exit;
  // disabilita scrittura log se l'operazione di modifica non coinvolge nessuna colonna
  if (Operazione = 'M') and (ODS <> nil) then
  begin
    LogAbilitato:=False;
    for i:=0 to ODS.FieldCount - 1 do
    begin
      if (ODS.Fields[i].FieldKind = fkData) and not(ODS.Fields[i] is TBlobField) then
      begin
        if ODS.Fields[i].Value <> GetOldValue(ODS,ODS.Fields[i].FieldName) then
        begin
          LogAbilitato:=True;
          Break;
        end;
      end;
    end;
  end;
  // estrazione nuovo id
  if Resetta then
  begin
    InsI001.Close;
    InsI001.Open;
    if LogAbilitato then
    begin
      SeqI000.Execute;
      ID:=SeqI000.FieldAsInteger(0);
      UltimaRegistrazione:=True;
    end;
  end;
  if not LogAbilitato then
    exit;
  SetVariable('ID',ID);
  SetVariable('OPERATORE',UpperCase(Parametri.Operatore));
  SetVariable('MASCHERA',Uppercase(Maschera));
  SetVariable('TABELLA',UpperCase(Tabella));
  SetVariable('OPERAZIONE',UpperCase(Operazione));
  FID:=ID; //usato da GetOldValue
  // se è indicato un dataset inserisce automaticamente le informazioni sulla I001
  if ODS <> nil then
  begin
    for i:=0 to ODS.FieldCount - 1 do
    begin
      if (ODS.Fields[i].FieldKind = fkData) and not(ODS.Fields[i] is TBlobField) then
      begin
        S:=UpperCase(ODS.Fields[i].FieldName);
        if (Operazione = 'I') and (not ODS.Fields[i].IsNull) then
          InserisciDato(S,'',ODS.Fields[i].AsString)  //ODS.Fields[i].Value
        else if (Operazione = 'C') and (not ODS.Fields[i].IsNull) then
          InserisciDato(S,ODS.Fields[i].AsString,'')  //ODS.Fields[i].Value
        else if (Operazione = 'M') and ((not ODS.Fields[i].IsNull) or (GetOldValue(ODS,ODS.Fields[i].FieldName) <> Null)) then
        begin
          if GetOldValue(ODS,ODS.Fields[i].FieldName) = ODS.Fields[i].Value then  //VarToStr(ODS.Fields[i].OldValue)
            InserisciDato(S,ODS.Fields[i].AsString,'')  //ODS.Fields[i].Value
          else
          begin
            if VarIsType(GetOldValue(ODS,ODS.Fields[i].FieldName),varDate) then
            begin
              D:=R180VarToDateTime(GetOldValue(ODS,ODS.Fields[i].FieldName));
              OldValore:=DateTimeToStr(D);  { DONE : TEST IW 15 prima qui era DateToStr e ignorava la parte frazionaria }
            end
            else
              OldValore:=VarToStr(GetOldValue(ODS,ODS.Fields[i].FieldName));
            InserisciDato(S,OldValore,IfThen(ODS.Fields[i].IsNull,'null',ODS.Fields[i].AsString));
          end;
        end;
      end;
    end;
  end;
end;

procedure TRegistraLog.InserisciDato(Colonna,Valore_Old,Valore_New:String);
  function InserisciForeignKey(Tabella:String):Boolean;
  var i,j:Integer;
  begin
    Result:=False;
    for i:=0 to High(ForeignKeyRef) do
    begin
      if (Tabella = ForeignKeyRef[i].Tab) and (Colonna = ForeignKeyRef[i].Col) then
      begin
        Result:=True;
        Break;
      end;
    end;
    if Result then
    begin
      SelForeignKey.Close;
      SelForeignKey.SQL.Text:=Format('select %s from %s where %s = ''%s''',[ForeignKeyRef[i].ColSel,ForeignKeyRef[i].TabRef,ForeignKeyRef[i].ColRef,IfThen(Valore_Old <> '',Valore_Old,Valore_New)]);
      try
        SelForeignKey.Open;
        if SelForeignKey.RecordCount > 0 then
        begin
          for j:=0 to SelForeignKey.FieldCount - 1 do
          begin
            if UpperCase(SelForeignKey.Fields[j].FieldName) <> ForeignKeyRef[i].Col then
              InserisciDato(UpperCase(SelForeignKey.Fields[j].FieldName),IfThen(Valore_Old <> '',SelForeignKey.Fields[j].AsString,''),IfThen(Valore_Old = '',SelForeignKey.Fields[j].AsString,''));
          end;
        end
        else
          Result:=False;
      except
        Result:=False;
      end;
    end
  end;
begin
  if not LogAbilitato then
    exit;
  InserisciForeignKey(GetVariable('TABELLA'));
  InsI001.Append;
  InsI001.FieldByName('ID').AsInteger:=ID;
  InsI001.FieldByName('COLONNA').AsString:=Colonna;
  InsI001.FieldByName('VALORE_OLD').AsString:=Valore_Old;
  InsI001.FieldByName('VALORE_NEW').AsString:=Valore_New;
  InsI001.Post;
end;

procedure TRegistraLog.RegistraOperazione{(Commit:Boolean = True)};
begin
  UltimaRegistrazione:=False;
  if (*LogAbilitato and*) InsI001.Active and (InsI001.RecordCount > 0) then
  try
    Execute;
    {$IFDEF WIN32}SessioneOracle.ApplyUpdates([InsI001],False);{$ENDIF}
    InsI001.Close;
    InsI001.Open;
  except
  end;
end;

destructor TRegistraLog.Destroy;
begin
  Close;
  SeqI000.Free;
  InsI001.Close;
  InsI001.Free;
  SelForeignKey.Close;
  SelForeignKey.Free;
  inherited Destroy;
end;

constructor TRegistraMsg.Create(AOwner:TComponent);
begin
  inherited Create(nil);

  // prepara la query di inserimento della testata messaggio (I005)
  Name:='InsI005';
  SQL.Add('declare');
  SQL.Add('  :pragma');
  SQL.Add('begin');
  SQL.Add('  INSERT /*+ APPEND */ INTO MONDOEDP.I005_MSGINFO (ID,DATA,MASCHERA,AZIENDA,OPERATORE,PROFILO,HOSTNAME,HOSTIPADDRESS)');
  SQL.Add('  VALUES (:ID,sysdate,:MASCHERA,:AZIENDA,:OPERATORE,:PROFILO,:HOSTNAME,:HOSTIPADDRESS);');
  SQL.Add('  :commit');
  SQL.Add('end;');
  DeclareVariable('ID',otInteger);
  DeclareVariable('MASCHERA',otString);
  DeclareVariable('AZIENDA',otString);
  DeclareVariable('OPERATORE',otString);
  DeclareVariable('PROFILO',otString);
  DeclareVariable('HOSTNAME',otString);
  DeclareVariable('HOSTIPADDRESS',otString);
  DeclareVariable('PRAGMA',otSubst);
  DeclareVariable('COMMIT',otSubst);

  // prepara la query di estrazione di un nuovo id messaggio
  SeqI005:=TOracleQuery.Create(nil);
  SeqI005.Name:='SeqI005';
  SeqI005.SQL.Add('SELECT MONDOEDP.I005_ID.NEXTVAL FROM DUAL');

  // prepara la query di inserimento del dettaglio messaggio (I006)
  InsI006:=TOracleQuery.Create(nil);
  InsI006.Name:='InsI006';
  InsI006.SQL.Add('declare');
  InsI006.SQL.Add('  :pragma');
  InsI006.SQL.Add('begin');
  InsI006.SQL.Add('  INSERT /*+ APPEND */ INTO MONDOEDP.I006_MSGDATI (ID,AZIENDA_MSG,ID_MSG,DATA_MSG,TIPO,MSG,PROGRESSIVO)');
  InsI006.SQL.Add('  VALUES (:ID,:AZIENDA_MSG,MONDOEDP.I006_ID_MSG.nextval,sysdate,:TIPO,:MSG,:PROGRESSIVO);');
  InsI006.SQL.Add('  :commit');
  InsI006.SQL.Add('end;');
  InsI006.DeclareVariable('ID',otInteger);
  InsI006.DeclareVariable('AZIENDA_MSG',otString);
  InsI006.DeclareVariable('TIPO',otString);
  InsI006.DeclareVariable('MSG',otString);
  InsI006.DeclareVariable('PROGRESSIVO',otInteger);
  InsI006.DeclareVariable('PRAGMA',otSubst);
  InsI006.DeclareVariable('COMMIT',otSubst);

  delI005:=TOracleQuery.Create(nil);
  delI005.Name:='delI005';
  delI005.SQL.Add('declare');
  delI005.SQL.Add('  :pragma');
  delI005.SQL.Add('begin');
  delI005.SQL.Add('  delete from MONDOEDP.I005_MSGINFO');
  delI005.SQL.Add('  where DATA <= add_months(sysdate,-12) and MASCHERA = :maschera;');
  delI005.SQL.Add('  :commit');
  delI005.SQL.Add('end;');
  delI005.DeclareVariable('MASCHERA',otString);
  delI005.DeclareVariable('PRAGMA',otSubst);
  delI005.DeclareVariable('COMMIT',otSubst);

  // crea il dataset di estrazione messaggi
  selI005:=TOracleDataSet.Create(nil);
  selI005.Name:='selI005';
  selI005.ReadBuffer:=1000;
  PrimaVolta:=True;

  if AOwner <> nil then
    FSessioneOracleApp:=(AOwner as TOracleSession)
  else
    FSessioneOracleApp:=nil;
end;

function TRegistraMsg.Parametri:TParametri;
begin
  if Owner is TSessioneIrisWin then
    Result:=(Owner as TSessioneIrisWin).Parametri
  else if (Owner is TOracleSession) and ((Owner as TOracleSession).Owner is TSessioneIrisWin) then
    Result:=((Owner as TOracleSession).Owner as TSessioneIrisWin).Parametri
  else
    Result:=A000UInterfaccia.Parametri;
end;

procedure TRegistraMsg.SetSessioneOracleApp(const Value: TOracleSession);
begin
  FSessioneOracleApp:=Value;
  //reimposto sessione
  Self.Session:=FSessioneOracleApp;
  SeqI005.Session:=FSessioneOracleApp;
  InsI006.Session:=FSessioneOracleApp;
  delI005.Session:=FSessioneOracleApp;
end;

procedure TRegistraMsg.IniziaMessaggio(Maschera:String);
// Assegna la sessione oracle ai componenti (sessione diversa per via di commit separate)
// e quindi estrae un nuovo id messaggio dalla sequenza
var
  TempHost, TempIP, Err: String;
begin
  {$IFDEF IRISWEB}
    {$IFDEF WEBPJ}{$ELSE}
    {$IFDEF WEBSVC}{$ELSE}
    //Si verifica SOLO per IrisWEB
    if Pos(INI_PAR_NO_REGISTRA_MSG,W000ParConfig.ParametriAvanzati{W000ParametriAvanzati}) > 0 then // gestione parametri di configurazione su file
      Exit;
    {$ENDIF WEBSVC}
    {$ENDIF WEBPJ}
  {$ENDIF IRISWEB}
  try
    if Self.Session = nil then
      Self.Session:=FSessioneOracleApp;
    if SeqI005.Session = nil then
      SeqI005.Session:=FSessioneOracleApp;
    if InsI006.Session = nil then
      InsI006.Session:=FSessioneOracleApp;
    if delI005.Session = nil then
      delI005.Session:=FSessioneOracleApp;

    (*!!!ServerVersion non è thread safe!!!
    if (Pos(' 7.',FSessioneOracleApp.ServerVersion) > 0) or
       (Pos(' 8.0',FSessioneOracleApp.ServerVersion) > 0) then
    *)
    if (Parametri <> nil) and (Parametri.VersioneOracle > 0) and (Parametri.VersioneOracle < 8) then
    begin
      SetVariable('PRAGMA',null);
      SetVariable('COMMIT',null);
      InsI006.SetVariable('PRAGMA',null);
      InsI006.SetVariable('COMMIT',null);
      delI005.SetVariable('PRAGMA',null);
      delI005.SetVariable('COMMIT',null);
    end
    else
    begin
      SetVariable('PRAGMA','pragma autonomous_transaction;');
      SetVariable('COMMIT','commit;');
      InsI006.SetVariable('PRAGMA','pragma autonomous_transaction;');
      InsI006.SetVariable('COMMIT','commit;');
      delI005.SetVariable('PRAGMA','pragma autonomous_transaction;');
      delI005.SetVariable('COMMIT','commit;');
    end;
    // estrae un nuovo id messaggio
    try
      SeqI005.Execute;
      ID:=SeqI005.FieldAsInteger(0);
      //delete from i005_msginfo where data < add_months(sysdate,-12) and maschera = :maschera
    except
      on E:Exception do
        raise Exception.Create('Gestione messaggi: errore durante il reperimento dell''identificativo messaggio' + #13#10 + E.Message);
    end;
    PrimaVolta:=True;

    // prepara l'inserimento sulla tabella I005 (testata messaggio)
    SetVariable('ID',ID);
    if Maschera = 'W000' then
    begin
      // irisweb
      SetVariable('AZIENDA','AZIN');
      SetVariable('OPERATORE','');
      SetVariable('PROFILO','');
      // N.B.: a questo punto Parametri non è ancora valorizzato,
      //       per cui i dati dell'host vengono letti sul momento
      if R180GetIPFromHost(TempHost,TempIP,Err) then
      begin
        SetVariable('HOSTNAME',TempHost);
        SetVariable('HOSTIPADDRESS',TempIP);
      end
      else
      begin
        SetVariable('HOSTNAME','localhost');
        SetVariable('HOSTIPADDRESS','127.0.0.1');
      end;
    end
    else
    begin
      SetVariable('AZIENDA',UpperCase(Parametri.Azienda));
      SetVariable('OPERATORE',UpperCase(Parametri.Operatore));
      SetVariable('PROFILO',UpperCase(Parametri.ProfiloWEB));
      SetVariable('HOSTNAME',Parametri.HostName);
      SetVariable('HOSTIPADDRESS',Parametri.HostIPAddress);
    end;
    SetVariable('MASCHERA',Maschera);

    // inizializza le variabili booleane relative al contenuto dell'id messaggio
    ContieneTipoA:=False;
    ContieneTipoI:=False;
    ContieneTipoB:=False;

    {$IFNDEF IRISWEB}
    delI005.SetVariable('MASCHERA',Maschera);
    try
      delI005.Execute;
    except
    end;
    {$ENDIF}
  except
  end;
end;

procedure TRegistraMsg.InserisciMessaggio(Tipo,Msg:String; Azienda:String = ''; Prog:Integer = 0);
// Inserisce nella tabella di log una riga con i dati indicati
// Gestisce l'eventualità che nel messaggio esistano caratteri CR o LF:
// nel caso vengono inserite più righe di dettaglio sulla tabella I006
const
  DELIM: String = #6;
begin
  {$IFDEF IRISWEB}
    {$IFDEF WEBPJ}{$ELSE}
    {$IFDEF WEBSVC}{$ELSE}
    //Si verifica SOLO per IrisWEB
    if Pos(INI_PAR_NO_REGISTRA_MSG,W000ParConfig.ParametriAvanzati{W000ParametriAvanzati}) > 0 then // gestione parametri di configurazione su file
      Exit;
    {$ENDIF WEBSVC}
    {$ENDIF WEBPJ}
  {$ENDIF IRISWEB}
  try
    if Session = nil then
    begin
      {$IFDEF IRISWEB}
      {$IFNDEF WEBSVC}
      //Può capitare Session=nil se si chiama InsericiMessaggio senza aver prima chiamato IniziaMessaggio.
      //In IrisWEB tenta di scrivere sulla RegistrasMSG dell'ActiveForm, ma in questo caso viene redirezionato
      //su A000RegistraMsg che è sempre connesso
      if Self <> A000RegistraMsg then
        A000RegistraMsg.InserisciMessaggio(Tipo,'<NO MASCHERA>' + Msg,Azienda,Prog);
      {$ENDIF WEBSVC}
      {$ENDIF IRISWEB}
      Exit;
    end;

    {$IFDEF IRISWEB}
    {$IFNDEF WEBSVC}
    // in irisweb serializza l'esecuzione delle query per via del "pragma autonomous transaction"
    // l'esecuzione di query con questo pragma da più thread possono infatti portare a deadlock
    // e conseguenti errori che causano il blocco del webserver
    CSFileLog.Enter;
    try
    {$ENDIF WEBSVC}
    {$ENDIF IRISWEB}
      // inserisce la testata del messaggio al primo inserimento del dettaglio
      if PrimaVolta then
      begin
        Execute;
        PrimaVolta:=False;
      end;

      // prepara l'inserimento sulla tabella I006 (dettaglio messaggio)
      InsI006.SetVariable('ID',ID);
      InsI006.SetVariable('TIPO',Tipo);
      InsI006.SetVariable('PROGRESSIVO',Max(0,Prog));
      if Azienda = '' then
        InsI006.SetVariable('AZIENDA_MSG',UpperCase(Parametri.Azienda))
      else
        InsI006.SetVariable('AZIENDA_MSG',UpperCase(Azienda));

      // trasforma eventuali CR e LF presenti nel messaggio in un carattere speciale
      // che verrà usato come delimitatore
      Msg:=StringReplace(Msg,#13,DELIM,[rfReplaceAll]);             // CR => DELIM
      Msg:=StringReplace(Msg,#10,DELIM,[rfReplaceAll]);             // LF => DELIM
      Msg:=StringReplace(Msg,DELIM + DELIM,DELIM,[rfReplaceAll]);   // rimuove duplicaz. di DELIM
      Msg:=StringReplace(Msg,DELIM,' ',[rfReplaceAll]);
      // SONDRIO_HVALTELLINA - chiamata 85450.ini
      // il messaggio viene troncato a 2000 caratteri
      Msg:=Copy(Msg,1,2000);
      // SONDRIO_HVALTELLINA - chiamata 85450.fine
      InsI006.SetVariable('MSG',Msg);
      InsI006.Execute;
      //InsI006.Session.Commit;

      // aggiorna variabili booleane
      if Tipo = 'A' then
        ContieneTipoA:=True
      else if Tipo = 'I' then
        ContieneTipoI:=True
      else if Tipo = 'B' then
        ContieneTipoB:=True;
    {$IFDEF IRISWEB}
    {$IFNDEF WEBSVC}
    finally
      CSFileLog.Leave;
    end;
    {$ENDIF WEBSVC}
    {$ENDIF IRISWEB}
  except
    on E:Exception do
      if Pos('ORA-06510',UpperCase(E.Message)) = 0 then
        raise; // aggiunto 12.06.2013 per rilanciare eventuali eccezioni
  end;
end;

procedure TRegistraMsg.InserisciMessaggioList(Tipo:String; Msg:TStrings; Azienda:String = ''; Prog:Integer = -1);
// Inserisce nella tabella di log una riga per ogni elemento della stringlist indicata
var
  i:Integer;
begin
  {$IFDEF IRISWEB}
    {$IFDEF WEBPJ}{$ELSE}
    {$IFDEF WEBSVC}{$ELSE}
    //Si verifica SOLO per IrisWEB
    if Pos(INI_PAR_NO_REGISTRA_MSG,W000ParConfig.ParametriAvanzati{W000ParametriAvanzati}) > 0 then // gestione parametri di configurazione su file
      Exit;
    {$ENDIF WEBSVC}
    {$ENDIF WEBPJ}
  {$ENDIF IRISWEB}
  if Msg = nil then
    Exit;
  for i:=0 to Msg.Count - 1 do
  try
    if Trim(Msg[i]) <> '' then
      InserisciMessaggio(Tipo,Msg[i],Azienda,Prog);
  except end;
end;

procedure TRegistraMsg.LeggiMessaggi(Id:LongInt; Tipo:String = '');
// Apre il dataset dei messaggi relativi all'ID specificato (eventualmente solo del tipo specificato)
// ID:   id del messaggio da considerare
// Tipo: (opzionale) tipo delle righe da estrarre (A,I,B);
//       se non è indicato viene estratto tutto
// I risultati sono ordinati in ordine cronologico (ID_MSG e DATA_MSG)
begin
  {$IFDEF IRISWEB}
    {$IFDEF WEBPJ}{$ELSE}
    {$IFDEF WEBSVC}{$ELSE}
    //Si verifica SOLO per IrisWEB
    if Pos(INI_PAR_NO_REGISTRA_MSG,W000ParConfig.ParametriAvanzati{W000ParametriAvanzati}) > 0 then // gestione parametri di configurazione su file
      Exit;
    {$ENDIF WEBSVC}
    {$ENDIF WEBPJ}
  {$ENDIF IRISWEB}

  // 1. imposta query del dataset
  selI005.DeleteVariables;
  selI005.SQL.Clear;
  selI005.SQL.Add('SELECT I005.*,I006.AZIENDA_MSG,I006.DATA_MSG,I006.TIPO,I006.MSG,I006.PROGRESSIVO');
  selI005.SQL.Add('FROM   MONDOEDP.I005_MSGINFO I005, MONDOEDP.I006_MSGDATI I006');
  selI005.SQL.Add('WHERE  I005.ID = :ID');
  if Tipo <> '' then
    selI005.SQL.Add('AND    I006.TIPO = :TIPO');
  selI005.SQL.Add('AND    I005.ID = I006.ID');
  selI005.SQL.Add('ORDER BY I006.ID_MSG, I006.DATA_MSG');
  selI005.DeclareVariable('ID',otInteger);
  if Tipo <> '' then
    selI005.DeclareVariable('TIPO',otString);

  // 2. apre il dataset
  selI005.Session:=FSessioneOracleApp;
  selI005.Close;
  selI005.SetVariable('ID',Id);
  if Tipo <> '' then
    selI005.SetVariable('TIPO',Tipo);
  selI005.Open;
end;

procedure TRegistraMsg.LeggiMessaggi(Maschera: String; Tipo: String=''; LastIdOnly: Boolean = False);
// Apre il dataset dei messaggi relativi alla maschera (funzione) indicata
// Maschera:   funzione da considerare
// LastIdOnly: se vale true, viene estratta solo l'informazione relativa all'ultimo
//             ID in archivio (quello di valore maggiore)
// I risultati sono ordinati per ID discendente e data ascendente
begin
  {$IFDEF IRISWEB}
    {$IFDEF WEBPJ}{$ELSE}
    {$IFDEF WEBSVC}{$ELSE}
    //Si verifica SOLO per IrisWEB
    if Pos(INI_PAR_NO_REGISTRA_MSG,W000ParConfig.ParametriAvanzati{W000ParametriAvanzati}) > 0 then // gestione parametri di configurazione su file
      Exit;
    {$ENDIF WEBSVC}
    {$ENDIF WEBPJ}
  {$ENDIF IRISWEB}

  // 1. imposta query
  selI005.DeleteVariables;
  selI005.SQL.Clear;
  if (Tipo = '') and (not LastIdOnly) then
    selI005.SQL.Add('SELECT * FROM (');
  selI005.SQL.Add('SELECT I005.*,I006.AZIENDA_MSG,I006.DATA_MSG,I006.TIPO,I006.MSG,I006.PROGRESSIVO');
  selI005.SQL.Add('FROM   MONDOEDP.I005_MSGINFO I005, MONDOEDP.I006_MSGDATI I006');
  if (Pos(',',Maschera) = 0) or LastIdOnly then
    selI005.SQL.Add('WHERE I005.MASCHERA = :MASCHERA')
  else
    selI005.SQL.Add('WHERE I005.MASCHERA in (:MASCHERA)');
  if Tipo <> '' then
    selI005.SQL.Add('AND    I006.TIPO = :TIPO');
  if LastIdOnly then
    selI005.SQL.Add('AND    I005.ID = (select max(ID) from MONDOEDP.I005_MSGINFO where MASCHERA = :MASCHERA)');
  selI005.SQL.Add('AND    I005.ID = I006.ID');
  selI005.SQL.Add('ORDER BY I005.ID DESC, I006.ID_MSG, I006.DATA_MSG');
  if (Tipo = '') and (not LastIdOnly) then
    selI005.SQL.Add(') WHERE ROWNUM <= 32768');
  if (Pos(',',Maschera) = 0) or LastIdOnly then
    selI005.DeclareVariable('MASCHERA',otString)
  else
    selI005.DeclareVariable('MASCHERA',otSubst);

  // 2. apre il dataset
  selI005.Session:=FSessioneOracleApp;
  selI005.Close;
  if (Pos(',',Maschera) = 0) or LastIdOnly then
    selI005.SetVariable('MASCHERA',Maschera)
  else
    selI005.SetVariable('MASCHERA','''' + StringReplace(Maschera,',',''',''',[rfReplaceAll]) + '''');
  selI005.Open;
end;

procedure TRegistraMsg.GetListaMessaggi(Lista:TStrings; MaxElementi:Integer = -1;
  SeparatoreID:String = ''; MsgInfoSet: TMsgInfoSet = [miData, miAzienda, miMessaggio]);
{ Inserisce nell'oggetto di tipo TStrings specificato i messaggi attualmente
  contenuti nel dataset selI005.
  Nota: l'oggetto TStrings risulta utile per specificare ad esempio una
        stringlist oppure anche la proprietà Memo.Lines

  Lista:         oggetto di tipo TStrings che conterrà l'elenco dei messaggi
                 sotto forma di stringa nel formato "data/ora - messaggio".
                 Importante: la lista deve già essere gestita esternamente
                 (creata / distrutta) e viene SEMPRE preventivamente svuotata
  MaxElementi:   num. massimo di messaggi da aggiungere alla lista
  SeparatoreID:  in caso di dataset contenente più id (lettura per maschera)
                 è possibile separare l'elenco dei messaggi relativi ad un id
                 con una "riga" (elemento) di separazione
  MsgInfoSet:    elenco di informazioni da visualizzare nel messaggio
                 sono disponibili i seguenti valori
                 [miData]      : data/ora del messaggio
                 [miAzienda]   : azienda
                 [miMessaggio] : testo del messaggio
}
var
  i: Integer;
  ID,OldID: LongInt;
  UsaSeparatore: Boolean;
  ElementoMsg: TMsgInfo;
  ElementoStr,Riga: String;
begin
  {$IFDEF IRISWEB}
    {$IFDEF WEBPJ}{$ELSE}
    {$IFDEF WEBSVC}{$ELSE}
    //Si verifica SOLO per IrisWEB
    if Pos(INI_PAR_NO_REGISTRA_MSG,W000ParConfig.ParametriAvanzati) > 0 then
      Exit;
    {$ENDIF WEBSVC}
    {$ENDIF WEBPJ}
  {$ENDIF IRISWEB}
  // controllo parametri
  if Lista = nil then
    Exit;

  if MsgInfoSet = [] then
    Exit;

  UsaSeparatore:=SeparatoreId <> '';

  // pulisce la lista
  Lista.BeginUpdate;
  Lista.Clear;

  // ciclo di lettura messaggi
  i:=0;
  OldID:=-1;
  selI005.First;
  while not selI005.Eof do
  begin
    i:=i + 1;
    ID:=selI005.FieldByName('ID').AsInteger;

    // gestione riga di separazione
    if (UsaSeparatore) and
       (i > 1) and
       (ID <> OldID) then
      Lista.Add(SeparatoreID);

    Riga:='';
    for ElementoMsg in MsgInfoSet do
    begin
      case ElementoMsg of
        miData:        ElementoStr:=FormatDateTime('dd/mm/yyyy hh.mm.ss',selI005.FieldByName('DATA_MSG').AsDateTime);
        miAzienda:     ElementoStr:=selI005.FieldByName('AZIENDA_MSG').AsString;
        miMessaggio:   ElementoStr:=selI005.FieldByName('MSG').AsString;
      else
        ElementoStr:='';  
      end;
      if ElementoStr <> '' then
        Riga:=Riga + ElementoStr + ' - ';
    end;

    // aggiunge la riga di dettaglio alla lista
    Lista.Add(Copy(Riga,1,Length(Riga) - 3));

    // terminazione per max num. elementi raggiunto
    if (MaxElementi >= 0) and (i >= MaxElementi) then
      Break;

    OldID:=ID;
    selI005.Next;
  end;
  Lista.EndUpdate;
end;

destructor TRegistraMsg.Destroy;
begin
  Close;
  SeqI005.Free;
  InsI006.Free;
  selI005.Free;
  delI005.Free; // scoperto da eurekalog
  inherited Destroy;
end;

end.
