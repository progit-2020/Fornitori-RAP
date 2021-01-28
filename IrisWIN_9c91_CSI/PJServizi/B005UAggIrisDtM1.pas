unit B005UAggIrisDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, C180FunzioniGenerali, A000UCostanti, A000USessione, A000Versione, A000UInterfaccia,
  Oracle, OracleData,
  Variants, RegistrazioneLog;

type

  TB005RegistraMsg = class(TRegistraMsg)
  private
    FAbilitaScritturaDB:Boolean;
  public
    property  AbilitaScritturaDB:Boolean read FAbilitaScritturaDB write FAbilitaScritturaDB;
    procedure IniziaMessaggio(Maschera:String);
    procedure InserisciMessaggio(Tipo,Msg:String; Azienda:String = ''; Prog:Integer = 0);
  end;

  TB005FAggIrisDtM1 = class(TDataModule)
    D090: TDataSource;
    DbAggIris: TOracleSession;
    selI090: TOracleDataSet;
    DbAzienda: TOracleSession;
    SQLDml: TOracleQuery;
    Q050: TOracleDataSet;
    InsI050: TOracleQuery;
    selTableSpace: TOracleDataSet;
    ScriptSQL: TOracleScript;
    selI090AZIENDA: TStringField;
    selI090ALIAS: TStringField;
    selI090UTENTE: TStringField;
    selI090PAROLACHIAVE: TStringField;
    selI090TSLAVORO: TStringField;
    selI090TSINDICI: TStringField;
    selI090VERSIONEDB: TStringField;
    selI090Old: TOracleDataSet;
    selI090Grant: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    selInvalidi: TOracleDataSet;
    selCountP042: TOracleQuery;
    selI080: TOracleDataSet;
    selI051: TOracleDataSet;
    selI051NOME: TStringField;
    selI051DESCRIZIONE: TStringField;
    selI051TIMESTAMP: TDateTimeField;
    selI051NUMORD: TIntegerField;
    selI051ATTIVO: TStringField;
    selI051SCRIPT_SQL: TMemoField;
    selI051DATA_ESECUZIONE: TDateTimeField;
    selI051ESITO_ESECUZIONE: TStringField;
    selI091: TOracleDataSet;
    procedure DataModule2Create(Sender: TObject);
    procedure selI090AfterScroll(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Q090:TOracleDataSet;
    B005RegistraMsg:TB005RegistraMsg;
    function AggVersioneDB:string;
    function AbilitaAziendeOperatori:string;
    procedure RegistraNome(Nome:String);
    procedure GrantTabelleAziende(Utente,NomeFile:String;Registra:Boolean;TestoLog:TStrings);
    procedure RicompilaInvalidi;
    function  EsisteModulo(Applicativo,Modulo:String):Boolean;
  end;

var
  B005FAggIrisDtM1: TB005FAggIrisDtM1;

implementation

uses B005UAggIris;

{$R *.DFM}

procedure TB005FAggIrisDtM1.DataModule2Create(Sender: TObject);
var i:Integer;
begin
  if Self.Owner is TOracleSession then
  begin
    ScriptSQL.Session:=(Self.Owner as TOracleSession);
    selI090Grant.Session:=(Self.Owner as TOracleSession);
  end
  else
  begin
    while True do
    begin
      if Password(Application.Title) = -1 then
      begin
        Parametri.Azienda:='';
        Break;
      end;
      if Parametri.Azienda <> 'AZIN' then
      begin
        ShowMessage('L''azienda deve essere AZIN');
        Continue;
      end;
      if (Parametri.AggiornamentoBaseDati <> 'S') and (Parametri.Operatore <> 'MONDOEDP') and (Parametri.Operatore <> 'SYSMAN') then
      begin
        ShowMessage('L''utente deve essere amministratore di sistema');
        Continue;
      end;
      Break;
    end;
    if Parametri.Azienda = '' then
      Application.Terminate;
    A000ParamDBOracle(DbAggIris);
    try
      selI090.SetVariable('FILTRO','where nvl(AGGIORNAMENTO_ABILITATO,''S'') = ''S''');
      selI090.Open;
      Q090:=selI090;
      D090.DataSet:=selI090;
    except
      try
        selI090.SetVariable('FILTRO',null);
        selI090.Open;
        Q090:=selI090;
        D090.DataSet:=selI090;
      except
        selI090Old.Open;
        for i:=0 to selI090Old.FieldCount - 1 do
          selI090Old.Fields[i].Visible:=False;
        selI090Old.FieldByName('AZIENDA').Visible:=True;
        Q090:=selI090Old;
        D090.DataSet:=selI090Old;
      end;
    end;
    B005RegistraMsg:=TB005RegistraMsg.Create(DbAggIris);
    (*selTableSpace.Open;
    if Parametri.TSLavoro <> selTableSpace.FieldByName('TABLESPACE_NAME').AsString then
      ShowMessage('Attenzione! I tablespace registrati su I090_ENTI sono diversi da quelli realmente utilizzati!' + #13 + Parametri.TSLavoro + #13 + selTableSpace.FieldByName('TABLESPACE_NAME').AsString);*)
  end;
end;

procedure TB005RegistraMsg.IniziaMessaggio(Maschera:String);
begin
  if AbilitaScritturaDB then
    inherited;
end;

procedure TB005RegistraMsg.InserisciMessaggio(Tipo,Msg:String; Azienda:String = ''; Prog:Integer = 0);
begin
  if AbilitaScritturaDB then
    inherited;
end;

function TB005FAggIrisDtM1.AbilitaAziendeOperatori:string;
var
  updI073Operatori:TOracleQuery;
begin
  Result:='';
  updI073Operatori:=TOracleQuery.Create(nil);
  try
    try
      updI073Operatori.Session:=DbAggIris;
      updI073Operatori.SQL.Add('update MONDOEDP.I073_FILTROFUNZIONI I073');
      updI073Operatori.SQL.Add('   set I073.INIBIZIONE = ''S''');
      updI073Operatori.SQL.Add(' where I073.AZIENDA = :AZIENDA');
      updI073Operatori.SQL.Add('   and I073.PROFILO = (select I070.FILTRO_FUNZIONI');
      updI073Operatori.SQL.Add('                         from MONDOEDP.I070_UTENTI I070');
      updI073Operatori.SQL.Add('                        where I070.UTENTE = ''MONDOEDP''');
      updI073Operatori.SQL.Add('                          and I070.AZIENDA = :AZIENDA)');
      updI073Operatori.SQL.Add('   and I073.TAG in (83,84,85,86,87,88,100)');
      updI073Operatori.DeclareAndSet('AZIENDA',otString,selI090.FieldByName('AZIENDA').AsString);
      updI073Operatori.Execute;
      DbAggIris.Commit;
    except
      on e:exception do
      begin
        Result:=e.Message;
      end;
    end;
  finally
    FreeAndNil(updI073Operatori);
  end;
end;

function TB005FAggIrisDtM1.AggVersioneDB:string;
var
  updI090_AggVersioneDB:TOracleQuery;
begin
  Result:='';
  updI090_AggVersioneDB:=TOracleQuery.Create(nil);
  try
    try
      updI090_AggVersioneDB.Session:=DbAggIris;
      updI090_AggVersioneDB.SQL.Add('update MONDOEDP.I090_ENTI I090');
      updI090_AggVersioneDB.SQL.Add('   set I090.VERSIONEDB = :VERSIONEDB, PATCHDB = :PATCHDB');
      updI090_AggVersioneDB.SQL.Add(' where I090.AZIENDA = :AZIENDA');
      updI090_AggVersioneDB.DeclareAndSet('VERSIONEDB',otString,VersionePA);
      updI090_AggVersioneDB.DeclareAndSet('PATCHDB',otString,BuildPA);
      updI090_AggVersioneDB.DeclareAndSet('AZIENDA',otString,selI090.FieldByName('AZIENDA').AsString);
      updI090_AggVersioneDB.Execute;
      DbAggIris.Commit;
    except
      on e:exception do
      begin
        Result:=e.Message;
      end;
    end;
  finally
    FreeAndNil(updI090_AggVersioneDB);
  end;
end;

procedure TB005FAggIrisDtM1.RegistraNome(Nome:String);
begin
  InsI050.SetVariable('NOME',Nome);
  try
    InsI050.Execute;
    DbAzienda.Commit;
  except
  end;
end;

function TB005FAggIrisDtM1.EsisteModulo(Applicativo,Modulo:String):Boolean;
begin
  selI080.First;
  while not selI080.Eof do
  begin
    Result:=False;
    if Applicativo <> '' then
      Result:=Applicativo = R180Decripta(selI080.FieldByName('APPLICAZIONE').AsString,14091943)
    else
      Result:=True;
    if Result and (Modulo <> '') then
      Result:=Modulo = R180Decripta(selI080.FieldByName('MODULO').AsString,14091943);
    selI080.Next;
  end;
end;

procedure TB005FAggIrisDtM1.selI090AfterScroll(DataSet: TDataSet);
begin
  if DbAzienda.LogonUserName = Q090.FieldByName('UTENTE').AsString then
    exit;
  DbAzienda.LogOff;
  DbAzienda.LogonDatabase:=DbAggIris.LogonDatabase;
  DbAzienda.LogonUserName:=Q090.FieldByName('UTENTE').AsString;
  DbAzienda.LogonPassword:=R180Decripta(Q090.FieldByName('PAROLACHIAVE').AsString,21041974);
  try
    DbAzienda.Logon;
  except
    DbAzienda.LogonPassword:=A000PasswordFissa;
    DbAzienda.Logon;
  end;
  selI080.SetVariable('AZIENDA',Q090.FieldByName('AZIENDA').AsString);
  selI080.Close;
  selI080.Open;
  B005FAggIris.TSL:=Q090.FieldByName('TSLAVORO').AsString;
  B005FAggIris.TSI:=Q090.FieldByName('TSINDICI').AsString;
  if Trim(B005FAggIris.TSL) = '' then
    B005FAggIris.TSL:='LAVORO';
  if Trim(B005FAggIris.TSI) = '' then
    B005FAggIris.TSI:='INDICI';
  B005FAggIris.lblTablespaceTabelle.Caption:='Tablespace tabelle: ' + B005FAggIris.TSL;
  B005FAggIris.lblTablespaceIndici.Caption:='Tablespace indici: ' + B005FAggIris.TSI;
  selTableSpace.Open;
  if B005FAggIris.TSL <> selTableSpace.FieldByName('TABLESPACE_NAME').AsString then
    ShowMessage('Attenzione! I tablespace registrati sui Parametri Aziendali sono diversi da quelli realmente utilizzati!' + #13 +
                'Parametri aziendali: ' + B005FAggIris.TSL + #13 +
                'Utilizzato:' + selTableSpace.FieldByName('TABLESPACE_NAME').AsString + #13 +
                'Si consiglia di non eseguire gli scripts e di correggere i Parametri Aziendali.');
  selTableSpace.Close;
  B005FAggIris.GetScript;
  B005FAggIris.GetModuliDB;
  B005FAggIris.CheckAddIrpef;
  B005FAggIris.CheckSQLCustom;
end;

procedure TB005FAggIrisDtM1.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(B005RegistraMsg);
end;

procedure TB005FAggIrisDtM1.GrantTabelleAziende(Utente,NomeFile:String;Registra:Boolean;TestoLog:TStrings);
begin
  //Assegnazione dei GRANT in base all'azienda che ha eseguito gli script
  if Utente = 'MONDOEDP' then
  begin
    //esegue script scrGrantDaMedp verso ogni azienda che ricavo dalla selI090
    selI090Grant.Open;
    selI090Grant.First;
    while not selI090Grant.Eof do
    begin
      ScriptSQL.Lines.Clear;
      ScriptSQL.Output.Clear;
      ScriptSQL.Lines.Add('GRANT ALL ON I005_MSGINFO TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I006_MSGDATI  TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I005_ID TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I006_ID_MSG TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I011_DIZIONARIO_DATISCHEDA TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I015_TRADUZIONI_CAPTION TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I021_LOG_JOB TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I060_LOGIN_DIPENDENTE TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I061_PROFILI_DIPENDENTE TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I065_EXPR_ACCOUNT TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I070_UTENTI TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I071_PERMESSI TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I072_FILTROANAGRAFE TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I073_FILTROFUNZIONI TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I074_FILTRODIZIONARIO TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I075_ITER_AUTORIZZATIVI TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I076_REGOLE_ACCESSO TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I080_MODULI TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I090_ENTI TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I091_DATIENTE TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I092_LOGTABELLE TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I093_BASE_ITER_AUT TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I094_CHKDATI_ITER_AUT TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I095_ITER_AUT TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I096_LIVELLI_ITER_AUT TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I097_VALIDITA_ITER_AUT TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I100_PARSCARICO TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I101_TIMBIRREGOLARI TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I102_SCARICOPIANIFICATO TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I150_PARSCARICOGIUST TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON I300_TABLESPACE_FREESPACE TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      ScriptSQL.Lines.Add('GRANT ALL ON T035_PROGRESSIVO TO ' + selI090Grant.FieldByName('UTENTE').AsString + ';');
      if Registra then
        R180AppendFile(NomeFile,ScriptSQL.Lines.Text)
      else
      begin
        ScriptSQL.Execute;
        TestoLog.AddStrings(ScriptSQL.Output);
        ScriptSQL.Output.Clear;
      end;
      selI090Grant.Next;
    end;
    selI090Grant.Close;
  end
  else
  begin
    //esegue Grant di tutte tabelle e viste verso l'aziena MONDOEDP
    ScriptSQL.Lines.Clear;
    ScriptSQL.Lines.Add('declare');
    ScriptSQL.Lines.Add('  cursor c1 is');
    ScriptSQL.Lines.Add('    select ''grant all on ''||table_name||'' to mondoedp'' stmt');
    ScriptSQL.Lines.Add('    from');
    ScriptSQL.Lines.Add('      (select table_name from user_tables');
    ScriptSQL.Lines.Add('      union');
    ScriptSQL.Lines.Add('      select view_name from user_views');
    ScriptSQL.Lines.Add('      order by 1);');
    ScriptSQL.Lines.Add('begin');
    ScriptSQL.Lines.Add('  for t1 in c1 loop');
    ScriptSQL.Lines.Add('    begin');
    ScriptSQL.Lines.Add('      execute immediate t1.stmt;');
    ScriptSQL.Lines.Add('    exception');
    ScriptSQL.Lines.Add('      when others then null;');
    ScriptSQL.Lines.Add('    end;');
    ScriptSQL.Lines.Add('  end loop;');
    ScriptSQL.Lines.Add('end;');
    ScriptSQL.Lines.Add('/');
    if Registra then
      R180AppendFile(NomeFile,ScriptSQL.Lines.Text)
    else
    begin
      ScriptSQL.Execute;
      TestoLog.AddStrings(ScriptSQL.Output);
      ScriptSQL.Output.Clear;
    end;
  end;
end;

procedure TB005FAggIrisDtM1.RicompilaInvalidi;
var
  Invalidi:Integer;
begin
  Invalidi:=0;
  selInvalidi.Close;
  selInvalidi.Open;
  //Ricompilo finché non rimangono sempre gli stessi
  while selInvalidi.RecordCount <> Invalidi do
  begin
    Invalidi:=selInvalidi.RecordCount;
    while not selInvalidi.Eof do
    begin
      ScriptSQL.Lines.Clear;
      ScriptSQL.Output.Clear;
      ScriptSQL.Lines.Add('ALTER ' + selInvalidi.FieldByName('OBJECT_TYPE').AsString + ' ' + selInvalidi.FieldByName('OBJECT_NAME').AsString + ' COMPILE;');
      ScriptSQL.Execute;
      ScriptSQL.Output.Clear;
      selInvalidi.Next;
    end;
    selInvalidi.Close;
    selInvalidi.Open;
  end;
end;

end.
