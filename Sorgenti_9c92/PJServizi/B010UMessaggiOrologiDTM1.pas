unit B010UMessaggiOrologiDTM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData, A000Versione, A000UCostanti, A000USessione, (*A000UInterfaccia,*) C180FunzioniGenerali,
  (*Midaslib,*) Crtl, dbclient, ExtCtrls, ComCtrls, A001UPasswordDtM1, StdCtrls, C004UParamForm, Variants,
  R110UCreazioneFileMessaggi, RegistrazioneLog, QueryPK, Math;

type
  TB010FMessaggiOrologiDTM1 = class(TDataModule)
    selT290: TOracleDataSet;
    selT430: TOracleDataSet;
    selT291: TOracleDataSet;
    selT291CODICE: TStringField;
    selT291DESCRIZIONE: TStringField;
    selT291TIPO_FILE: TStringField;
    selT291NOME_FILE: TStringField;
    selT291DATA_FILE: TStringField;
    selT291DEFAULT_FILE: TStringField;
    selT292: TOracleDataSet;
    QSQL: TOracleQuery;
    selT291NUM_RIPET_MSG: TFloatField;
    selT291NUM_GGVAL_MSG: TFloatField;
    selT291NUM_MMIND_CONS: TFloatField;
    selT290DATADD: TStringField;
    selT290DATAMM: TStringField;
    selT290DATAYY: TStringField;
    selT290DATAHH: TStringField;
    selT290PARAMETRIZZAZIONE: TStringField;
    Timer1: TTimer;
    selT003: TOracleDataSet;
    selT291FILTRO_ANAGR: TStringField;
    selT290GIORNO: TStringField;
    selT290D_GIORNO: TStringField;
    selT291TIPO_FILTRO: TStringField;
    selT002: TOracleDataSet;
    selT291TIPO_REGISTRAZIONE: TStringField;
    selT291REGISTRA_MSG: TStringField;
    selT299: TOracleDataSet;
    delStruttura: TOracleQuery;
    selT291NUM_MMIND_VALID: TIntegerField;
    SessioneOracleB010: TOracleSession;
    selI090: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT290BeforePost(DataSet: TDataSet);
    procedure selT290DATAHHValidate(Sender: TField);
    procedure selT290DATADDValidate(Sender: TField);
    procedure selT290DATAMMValidate(Sender: TField);
    procedure DataModuleDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure selT290GIORNOValidate(Sender: TField);
    procedure selT290CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    lstAnagrafe:TStringList;
    ModalitaT299:Boolean;
    DatoSelT292DC:String;
    R110FCreazioneFileMessaggi:TR110FCreazioneFileMessaggi;
    A001DtM1:TA001FPasswordDtM1;
    procedure CancellazioneDatiScaduti;
    procedure PreparaT292;
    procedure PreparaFiltroAnagr;
    procedure Elaborazione(B010Parametrizzazione:String);
    procedure CreazioneR110;
    procedure DistruzioneR110;
  public
    { Public declarations }
    SessioneIWB010,SessioneIWR110:TSessioneIrisWIN;
    C004:TC004FParamForm;
    StatusBar:TStatusBar;
    //FileLog:String;
    procedure ConnettiDataBase(Alias:String);
    procedure AperturaTabelleSessioneOracle;
    //procedure ScriviLog(S:String);
    //procedure SalvaLog;
  end;

var
  B010FMessaggiOrologiDTM1: TB010FMessaggiOrologiDTM1;

implementation

{$R *.DFM}

procedure TB010FMessaggiOrologiDTM1.DataModuleCreate(Sender: TObject);
begin
  SessioneIWB010:=A000SessioneIrisWIN;
  if Self.Owner <> nil then
    if Self.Owner is TSessioneIrisWIN then
      SessioneIWB010:=Self.Owner as TSessioneIrisWIN;

  SessioneIWR110:=TSessioneIrisWIN.Create(nil);
  FreeAndNil(SessioneIWR110.SessioneOracle);
  SessioneIWR110.SessioneOracle:=SessioneOracleB010;
  SessioneIWR110.QueryPK1.Session:=SessioneIWR110.SessioneOracle;
  SessioneIWR110.RegistraLog.Session:=SessioneIWR110.SessioneOracle;
  FreeAndNil(TRegistraMsg(SessioneIWR110.RegistraMsg));
  SessioneIWR110.RegistraMsg:=SessioneIWB010.RegistraMsg;

  lstAnagrafe:=TStringList.Create;
  lstAnagrafe.Add('select T030.*, V430.*');
  lstAnagrafe.Add('from T030_ANAGRAFICO T030, V430_STORICO V430,T480_COMUNI T480');
  lstAnagrafe.Add('where');
  lstAnagrafe.Add('  T030.PROGRESSIVO = T430PROGRESSIVO AND');
  lstAnagrafe.Add('  T030.COMUNENAS = T480.CODICE(+) AND');
  lstAnagrafe.Add('  :DATALAVORO BETWEEN T430DATADECORRENZA and T430DATAFINE and');
  lstAnagrafe.Add('      EXISTS');
  lstAnagrafe.Add('      (select ''x'' from T430_STORICO where');
  lstAnagrafe.Add('         PROGRESSIVO = T430PROGRESSIVO AND');
  lstAnagrafe.Add('         :DATALAVORO BETWEEN INIZIO AND NVL(FINE,TO_DATE(''31123999'',''DDMMYYYY'')))');
end;

procedure TB010FMessaggiOrologiDTM1.ConnettiDataBase(Alias:String);
var i:Integer;
begin
  Timer1.Enabled:=False;
  SessioneIWB010.Parametri.Applicazione:='RILPRE';
  A001DtM1:=TA001FPasswordDtM1.Create(SessioneIWB010);
  try
    A001DtM1.InizializzazioneSessione(Alias);
    A001DtM1.QI090.SearchRecord('UTENTE','MONDOEDP',[srFromBeginning]);
    A001DtM1.RegistraInibizioni;
  except
  end;
  FreeAndNil(A001DtM1);
  ModalitaT299:=False;
  SessioneOracleB010.LogonDataBase:=Alias;
  //FileLog:=ExtractFilePath(Application.ExeName) + 'B010_' + Alias + '.log';
  if (not SessioneIWB010.SessioneOracle.Connected) or
     (SessioneIWB010.SessioneOracle.LogonDataBase <> Alias) then
    try
      A000ParamDBOracleMultiThread(SessioneIWB010);
    except
    end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if (Components[i] is TOracleQuery) and ((Components[i] as TOracleQuery).Session = nil) then
      (Components[i] as TOracleQuery).Session:=SessioneIWB010.SessioneOracle;
    if (Components[i] is TOracleDataSet) and ((Components[i] as TOracleDataSet).Session = nil) then
      (Components[i] as TOracleDataSet).Session:=SessioneIWB010.SessioneOracle;
  end;
  try
    AperturaTabelleSessioneOracle;
    selT290.Open;
    C004:=CreaC004(SessioneIWB010.SessioneOracle,'B010',SessioneIWB010.Parametri.ProgOper,False);
  except
  end;
end;

procedure TB010FMessaggiOrologiDTM1.CreazioneR110;
begin
  //R110FCreazioneFileMessaggi:=TR110FCreazioneFileMessaggi.Create(SessioneIWB010);
  R110FCreazioneFileMessaggi:=TR110FCreazioneFileMessaggi.Create(SessioneIWR110);
  with R110FCreazioneFileMessaggi do
  begin
    SelT292:=TClientDataSet.Create(nil);
    SelT292.FieldDefs.Add('CODICE',ftString,5);
    SelT292.FieldDefs.Add('TIPO_RECORD',ftString,2);
    SelT292.FieldDefs.Add('NUMERO_RECORD',ftInteger);
    SelT292.FieldDefs.Add('TIPO',ftString,2);
    SelT292.FieldDefs.Add('POSIZIONE',ftInteger);
    SelT292.FieldDefs.Add('LUNGHEZZA',ftInteger);
    SelT292.FieldDefs.Add('NOME_COLONNA',ftString,20);
    SelT292.FieldDefs.Add('FORMATO',ftString,20);
    SelT292.FieldDefs.Add('VALORE_DEFAULT',ftString,80);
    SelT292.FieldDefs.Add('CODICE_DATO',ftString,80);
    SelT292.FieldDefs.Add('CHIAVE',ftString,1);
  end;
end;

procedure TB010FMessaggiOrologiDTM1.DistruzioneR110;
begin
  if R110FCreazioneFileMessaggi = nil then
    Exit;
  FreeAndNil(R110FCreazioneFileMessaggi.selT292);
  FreeAndNil(R110FCreazioneFileMessaggi);
end;

procedure TB010FMessaggiOrologiDTM1.selT290BeforePost(DataSet: TDataSet);
begin
  if (selT290.FieldByName('DATAMM').AsString <> '') and
     (selT290.FieldByName('DATADD').AsString = '') then
    raise Exception.Create('Giorno non specificato!');
  if (selT290.FieldByName('DATAYY').AsString <> '') and
     (selT290.FieldByName('DATAMM').AsString = '') then
    raise Exception.Create('Mese non specificato!');
  if selT290.FieldByName('DATAHH').AsString = '' then
    raise Exception.Create('Ora obbligatoria!');
  if (selT290.FieldByName('DATADD').AsString <> '') and
     (selT290.FieldByName('DATAMM').AsString <> '') and
     (selT290.FieldByName('DATAYY').AsString <> '') then
    try
      EncodeDate(selT290.FieldByName('DATAYY').AsInteger,selT290.FieldByName('DATAMM').AsInteger,
        selT290.FieldByName('DATADD').AsInteger);
    except
      raise Exception.Create('Data inserita non valida!');
    end;
  if (selT290.FieldByName('DATADD').AsString = '') and
     (selT290.FieldByName('DATAMM').AsString = '') and
     (selT290.FieldByName('DATAYY').AsString = '') and
     (selT290.FieldByName('DATAHH').AsString <> '') then
    if selT290.FieldByName('GIORNO').AsString = '' then
    begin
      if TQueryPK(SessioneIWB010.QueryPK1).EsisteChiave('T290_MESSAGGIOROLOGI',selT290.RowId,selT290.State,['DATAHH'],[selT290.FieldByName('DATAHH').AsString]) then
        raise Exception.Create('Ora inserita non valida: ora duplicata!');
    end
    else
      with TOracleQuery.Create(nil) do
      try
        Session:=selT290.Session;
        SQL.Clear;
        SQL.Add('SELECT COUNT(*) FROM MONDOEDP.T290_MESSAGGIOROLOGI ');
        SQL.Add('WHERE DATAHH = ''' + selT290.FieldByName('DATAHH').AsString + ''' AND ');
        SQL.Add('GIORNO = ''' + selT290.FieldByName('GIORNO').AsString + '''');
        Execute;
        if Field(0) > 1 then
          raise Exception.Create('Ora inserita non valida: ora duplicata!');
      finally
        Free;
      end;
  if (selT290.FieldByName('GIORNO').AsString <> '') and
    ((selT290.FieldByName('DATADD').AsString <> '') or
     (selT290.FieldByName('DATAMM').AsString <> '') or
     (selT290.FieldByName('DATAYY').AsString <> '')) then
    raise Exception.Create('Non è possibile indicare il giorno della settimana a fronte di una data specifica!');
end;

procedure TB010FMessaggiOrologiDTM1.Timer1Timer(Sender: TObject);
var AdessoGiorno:TDate;
    Anno,Mese,Giorno,Minuti:word;
    GiornoSett:integer;
begin
  TRegistraMsg(SessioneIWB010.RegistraMsg).IniziaMessaggio('B010');
  A000SettaVariabiliAmbiente;
  //Verifica della connessione al database
  //DataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B010','Database','IRIS');
  if SessioneIWB010.SessioneOracle.CheckConnection(False) = ccError then
  begin
    //SessioneB010.LogonDataBase:=DataBase;
    SessioneIWB010.SessioneOracle.Logon;
    AperturaTabelleSessioneOracle;
  end;
  if not SessioneIWB010.SessioneOracle.Connected then
  begin
    //SessioneB010.LogonDataBase:=DataBase;
    SessioneIWB010.SessioneOracle.Logon;
    AperturaTabelleSessioneOracle;
  end;
  AdessoGiorno:=Date;
  DecodeDate(AdessoGiorno,Anno,Mese,Giorno);
  GiornoSett:=DayOfWeek(AdessoGiorno) - 1;
  Minuti:=R180OreMinuti(Time);
  //Schedulazione messaggi
  with selT290 do
  begin
    Close;
    Open;
    First;
    while not Eof do
    begin
      if FieldByName('DATAYY').AsString <> '' then
      begin
        if (FieldByName('DATAYY').AsInteger = Anno) and
           (FieldByName('DATAMM').AsInteger = Mese) and
           (FieldByName('DATADD').AsInteger = Giorno) and
           (R180OreMinutiExt(FieldByName('DATAHH').AsString) = Minuti) then
        begin
          Elaborazione(FieldByName('PARAMETRIZZAZIONE').AsString);
          Break;
        end
      end
      else if FieldByName('DATAMM').AsString <> '' then
      begin
        if (FieldByName('DATAMM').AsInteger = Mese) and
           (FieldByName('DATADD').AsInteger = Giorno) and
           (R180OreMinutiExt(FieldByName('DATAHH').AsString) = Minuti) then
        begin
          Elaborazione(FieldByName('PARAMETRIZZAZIONE').AsString);
          Break;
        end
      end
      else if FieldByName('DATADD').AsString <> '' then
      begin
        if (FieldByName('DATADD').AsInteger = Giorno) and
           (R180OreMinutiExt(FieldByName('DATAHH').AsString) = Minuti) then
        begin
          Elaborazione(FieldByName('PARAMETRIZZAZIONE').AsString);
          Break;
        end
      end
      else if FieldByName('GIORNO').AsString <> '' then
      begin
        if (FieldByName('GIORNO').AsInteger = GiornoSett) and
           (R180OreMinutiExt(FieldByName('DATAHH').AsString) = Minuti) then
        begin
          Elaborazione(FieldByName('PARAMETRIZZAZIONE').AsString);
          Break;
        end
      end
      else if R180OreMinutiExt(FieldByName('DATAHH').AsString) = Minuti then
      begin
        Elaborazione(FieldByName('PARAMETRIZZAZIONE').AsString);
        Break;
      end;
      Next;
    end;
  end;
  //Lettura messaggi segnalati sulla T299
  with selT299 do
  try
    ModalitaT299:=True;
    Refresh;
    while not Eof do
    begin
      Elaborazione(FieldByName('PARAMETRIZZAZIONE').AsString);
      try
        Delete;
        SessioneIWB010.SessioneOracle.Commit;
      except
        Next;
      end;
    end;
  finally
    ModalitaT299:=False;
  end;
end;

procedure TB010FMessaggiOrologiDTM1.AperturaTabelleSessioneOracle;
begin
  if not SessioneIWB010.SessioneOracle.Connected then
    exit;
  selI090.Open;
  selT299.Open;
  try
    SessioneOracleB010.LogOff;
  except
  end;
  (*
  DistruzioneR110;
  CreazioneR110;
  *)
  (*selT291.Close;
  selT291.Open;
  selT299.Open;*)
end;

procedure TB010FMessaggiOrologiDTM1.Elaborazione(B010Parametrizzazione:String);
var ind:Integer;
    Azienda,Param:String;
    ListaParam(*,ListaFile*):TStringList;
  procedure LogonSessioneOracleB010(User,Password:String);
  begin
    A001DtM1:=TA001FPasswordDtM1.Create(SessioneIWR110);
    try
      A001DtM1.InizializzazioneSessione(SessioneOracleB010.LogonDataBase);
      R180SetVariable(A001DtM1.QI090,'AZIENDA',Azienda);
      A001DtM1.QI090.Open;
      A001DtM1.RegistraInibizioni;
    finally
      FreeAndNil(A001DtM1);
    end;
    if SessioneOracleB010.LogonUsername <> User then
    begin
      SessioneOracleB010.Logoff;
      SessioneOracleB010.LogonUsername:=User;
    end;
    if SessioneOracleB010.LogonPassword <> Password then
    begin
      SessioneOracleB010.Logoff;
      SessioneOracleB010.LogonPassword:=Password;
    end;
    if not SessioneOracleB010.Connected then
      SessioneOracleB010.Logon;
    DistruzioneR110;
    CreazioneR110;
    SessioneIWR110.AlterSessionSessioneOracle;
  end;
  procedure GetParametrizzazione(S:String; var Az,Par:String);
  var P:Integer;
  begin
    Az:='AZIN';
    Par:=S;
    P:=Pos('=',S);
    if P > 0 then
    begin
      Az:=Copy(S,1,P - 1);
      Par:=Copy(S,P + 1,Length(S));
    end;
  end;
begin
  ListaParam:=TStringList.Create;
  //ListaFile:=TStringList.Create;
  Screen.Cursor:=crHourGlass;
  selT291.Close;
  (*selT291.Close;
  selT291.Open;*)
  if B010Parametrizzazione <> '' then
    ListaParam.CommaText:=B010Parametrizzazione
  else
  begin
    LogonSessioneOracleB010(SessioneIWB010.SessioneOracle.LogonUsername,SessioneIWB010.SessioneOracle.LogonPassword);
    selT291.Open;
    while not selT291.Eof do
    begin
      ListaParam.Add(selT291.FieldByName('CODICE').AsString);
      selT291.Next;
    end;
  end;
  selT291.Filtered:=True;
  selI090.Refresh;
  for ind:=0 to ListaParam.Count - 1 do
  begin
    GetParametrizzazione(ListaParam.Strings[ind],Azienda,Param);
    if (VarToStr(selI090.Lookup('AZIENDA',Azienda,'VERSIONEDB')) <> '') and
       (VarToStr(selI090.Lookup('AZIENDA',Azienda,'VERSIONEDB')) <> VersionePA) then
    begin
      //R110FCreazioneFileMessaggi.LogMessaggi.Clear;
      //R110FCreazioneFileMessaggi.LogMessaggi.Add('Parametrizzazione: ' + ListaParam.Strings[ind] + ' - ' + Format('La versione del database (%s) non corrisponde alla versione del prodotto(%s). Elaborazione interrotta!',[VarToStr(selI090.Lookup('AZIENDA',Azienda,'VERSIONEDB')),VersionePA]));
      TRegistraMsg(SessioneIWB010.RegistraMsg).InserisciMessaggio('A','Parametrizzazione: ' + ListaParam.Strings[ind] + ' - ' + Format('La versione del database (%s) non corrisponde alla versione del prodotto(%s). Elaborazione interrotta!',[VarToStr(selI090.Lookup('AZIENDA',Azienda,'VERSIONEDB')),VersionePA]),Azienda);
      C004.selT001.Close;
      C004.selT001.Open;
      //SalvaLog;
      Continue;
    end;
    LogonSessioneOracleB010(VarToStr(selI090.Lookup('AZIENDA',Azienda,'UTENTE')),R180Decripta(VarToStr(selI090.Lookup('AZIENDA',Azienda,'PAROLACHIAVE')),21041974));
    selT291.Open;
    selT291.Filter:='CODICE=''' + Param + '''';
    if selT291.RecordCount = 0 then
      Continue;
    // richiamo procedura 'Creazione file messaggi'
    with R110FCreazioneFileMessaggi do
    begin
      //LogMessaggi.Clear;
      TipoFile:=selT291.FieldByName('TIPO_FILE').AsString;
      TipoScrittura:=IfThen(selT291.FieldByName('TIPO_REGISTRAZIONE').AsString = 'R',1,0);
      RegistraMSG:=selT291.FieldByName('REGISTRA_MSG').AsString;
      Skippa:=True;
      NomeFile:=R180NomeFileDatato(selT291.FieldByName('NOME_FILE').AsString,selT291.FieldByName('DATA_FILE').AsString,Date);
      Parametrizzazione:=selT291.FieldByName('CODICE').AsString + ' - ' + selT291.FieldByName('DESCRIZIONE').AsString;
      if StatusBar <> nil then
      begin
        StatusBar.SimpleText:='Elaborazione della parametrizzazione ''' + Parametrizzazione + ''' in corso...';
        StatusBar.Repaint;
      end;
      DataMessaggio:=Now;
      DataScadenza:=Trunc(DataMessaggio) + selT291.FieldByName('NUM_GGVAL_MSG').AsInteger;
      if ModalitaT299 then
        DataConsuntivo:=selT299.FieldByName('DATA').AsDateTime
      else if selT291.FieldByName('NUM_MMIND_CONS').AsInteger = -1 then
      begin
        QSQL.Sql.Clear;
        QSQL.Sql.Add('SELECT MAX(DATA) DATACONS FROM T070_SCHEDARIEPIL');
        QSQL.Execute;
        DataConsuntivo:=QSQL.Field(0);
      end
      else
        DataConsuntivo:=R180InizioMese(R180AddMesi(Date,-selT291.FieldByName('NUM_MMIND_CONS').AsInteger));
      try
        PreparaFiltroAnagr;
        PreparaT292;
        if (not ModalitaT299) and
           (DatoSelT292DC <> '') and
           (selT291.FieldByName('TIPO_FILE').AsString = 'O') and
           (selT291.FieldByName('TIPO_REGISTRAZIONE').AsString = 'A') and
           (selT291.FieldByName('NUM_MMIND_VALID').AsInteger > 0) then
          CancellazioneDatiScaduti;
        Elabora;
      except
        on E:Exception do
        begin
          //LogMessaggi.Add('Parametrizzazione: ' + Parametrizzazione + ' - ' + E.Message);
          TRegistraMsg(SessioneIWB010.RegistraMsg).InserisciMessaggio('A','Parametrizzazione: ' + Parametrizzazione + ' - ' + E.Message,Azienda);
          ErroreSuLog:=True;
        end;
      end;
    end;
    C004.selT001.Close;
    C004.selT001.Open;
    //if (not ModalitaT299) or R110FCreazioneFileMessaggi.ErroreSuLog then
    //  SalvaLog;
  end;
  selT291.Filter:='';
  selT291.Filtered:=False;
  if StatusBar <> nil then
  begin
    StatusBar.SimpleText:='';
    StatusBar.Repaint;
  end;
  Screen.Cursor:=crDefault;
  FreeAndNil(ListaParam);
end;

{
procedure TB010FMessaggiOrologiDTM1.ScriviLog(S:String);
begin
  R110FCreazioneFileMessaggi.LogMessaggi.Add(S);
end;

procedure TB010FMessaggiOrologiDTM1.SalvaLog;
var
  ListaFile:TStringList;
  i,NR:Integer;
begin
  ListaFile:=TStringList.Create;
  ListaFile.Clear;
  try
    ListaFile.LoadFromFile(FileLog);
  except
  end;
  NR:=0;
  try
    NR:=StrToIntDef(C004.GetParametro('MAXRIGHELOG','0'),0);
  except
  end;
  if NR > 0 then
    for i:=ListaFile.Count - 1 downto (NR - R110FCreazioneFileMessaggi.LogMessaggi.Count) do
      if i >= 0 then
        ListaFile.Delete(i);
  with R110FCreazioneFileMessaggi.LogMessaggi do
    for i:=0 to Count - 1 do
      ListaFile.Insert(i,Strings[i]);
  try
    ListaFile.SaveToFile(FileLog);
    FreeAndNil(ListaFile);
    R110FCreazioneFileMessaggi.LogMessaggi.Clear;
    R110FCreazioneFileMessaggi.ErroreSuLog:=False;
  except
  end;
end;
}

procedure TB010FMessaggiOrologiDTM1.CancellazioneDatiScaduti;
begin
  with delStruttura do
  try
    SetVariable('STRUTTURA',R110FCreazioneFileMessaggi.NomeFile);
    SetVariable('CAMPO',DatoSelT292DC);
    SetVariable('FORMATO',VarToStr(selT292.Lookup('NOME_COLONNA',DatoSelT292DC,'FORMATO')));
    SetVariable('SCADENZA',-selT291.FieldByName('NUM_MMIND_VALID').AsInteger);
    Execute;
    SessioneOracleB010.Commit;
  except
  end;
end;

procedure TB010FMessaggiOrologiDTM1.PreparaFiltroAnagr;
begin
  selT430.Close;
  selT430.SQL.Clear;
  selT430.DeleteVariables;
  if ModalitaT299 then
  begin
    //Selezione da T299
    selT430.DeclareVariable('DATALAVORO',otDate);
    selT430.SetVariable('DATALAVORO',Date);
    selT430.SQL.Add(lstAnagrafe.Text);
    selT430.SQL.Add('AND T030.PROGRESSIVO = ' + selT299.FieldByName('PROGRESSIVO').AsString);
  end
  else if selT291.FieldByName('TIPO_FILTRO').AsString = '0' then
  begin
    //Selezione da C700
    selT430.DeclareVariable('DATALAVORO',otDate);
    selT430.SetVariable('DATALAVORO',Date);
    selT430.SQL.Add(lstAnagrafe.Text);
    if selT291.FieldByName('FILTRO_ANAGR').AsString <> '' then
      with selT003 do
      begin
        Close;
        SetVariable('NOME',selT291.FieldByName('FILTRO_ANAGR').AsString);
        Open;
        if Copy(FieldByName('RIGA').AsString,1,5) <> 'ORDER' then
          selT430.SQL.Add(' AND ');
        while not Eof do
        begin
          selT430.SQL.Add(FieldByName('RIGA').AsString);
          Next;
        end;
      end;
  end
  else
    //Selezione da Query personalizzate
    with selT002 do
    begin
      Close;
      SetVariable('NOME',selT291.FieldByName('FILTRO_ANAGR').AsString);
      Open;
      while not Eof do
      begin
        selT430.SQL.Add(FieldByName('RIGA').AsString);
        Next;
      end;
    end;
  selT430.Open;
  R110FCreazioneFileMessaggi.SelC700:=selT430;
end;

procedure TB010FMessaggiOrologiDTM1.PreparaT292;
var OffsetMM,OffsetGG:Integer;
    D:TDateTime;
    F:String;
  function GetOffset(S,Tipo:String):Integer;
  begin
    Result:=0;
    if S = '' then exit;
    S:=UpperCase(S);
    if Copy(S,Length(S),1) = Tipo then
      Result:=StrToIntDef(Copy(S,1,Length(S) - 1),0);
  end;
begin
  with selT292 do
  begin
    Close;
    SetVariable('CODICE',selT291.FieldByName('CODICE').AsString);
    Open;
    First;
    R110FCreazioneFileMessaggi.SelT292.Close;
    R110FCreazioneFileMessaggi.SelT292.CreateDataSet;
    R110FCreazioneFileMessaggi.SelT292.LogChanges:=False;
    DatoSelT292DC:='';
    while not Eof do
    begin
      OffsetGG:=GetOffset(FieldByName('CODICE_DATO').AsString,'G');
      OffsetMM:=GetOffset(FieldByName('CODICE_DATO').AsString,'M');
      D:=0;
      //Gestire l'offset in giorni
      R110FCreazioneFileMessaggi.SelT292.Append;
      R110FCreazioneFileMessaggi.SelT292.FieldByName('CODICE').AsString:=
        FieldByName('CODICE').AsString;
      R110FCreazioneFileMessaggi.SelT292.FieldByName('TIPO_RECORD').AsString:=
        FieldByName('TIPO_RECORD').AsString;
      R110FCreazioneFileMessaggi.SelT292.FieldByName('NUMERO_RECORD').AsString:=
        FieldByName('NUMERO_RECORD').AsString;
      R110FCreazioneFileMessaggi.SelT292.FieldByName('TIPO').AsString:=
        FieldByName('TIPO').AsString;
      R110FCreazioneFileMessaggi.SelT292.FieldByName('POSIZIONE').AsString:=
        FieldByName('POSIZIONE').AsString;
      R110FCreazioneFileMessaggi.SelT292.FieldByName('LUNGHEZZA').AsString:=
        FieldByName('LUNGHEZZA').AsString;
      R110FCreazioneFileMessaggi.SelT292.FieldByName('NOME_COLONNA').AsString:=
        FieldByName('NOME_COLONNA').AsString;
      R110FCreazioneFileMessaggi.SelT292.FieldByName('FORMATO').AsString:=
        FieldByName('FORMATO').AsString;
      R110FCreazioneFileMessaggi.SelT292.FieldByName('VALORE_DEFAULT').AsString:=
        FieldByName('VALORE_DEFAULT').AsString;
      R110FCreazioneFileMessaggi.SelT292.FieldByName('CODICE_DATO').AsString:=
        FieldByName('CODICE_DATO').AsString;
      if FieldByName('TIPO').AsString = 'NR' then
        R110FCreazioneFileMessaggi.SelT292.FieldByName('VALORE_DEFAULT').AsString:=
        selT291.FieldByName('NUM_RIPET_MSG').AsString
      else if FieldByName('TIPO').AsString = 'DT' then
        D:=R180AddMesi(R110FCreazioneFileMessaggi.DataMessaggio + OffsetGG,OffsetMM)
      else if FieldByName('TIPO').AsString = 'DC' then
      begin
        D:=R180AddMesi(R110FCreazioneFileMessaggi.DataConsuntivo + OffsetGG,OffsetMM);
        DatoSelT292DC:=FieldByName('NOME_COLONNA').AsString;
      end
      else if FieldByName('TIPO').AsString = 'DS' then
        D:=R180AddMesi(Trunc(R110FCreazioneFileMessaggi.DataMessaggio) + OffsetGG,OffsetMM) + selT291.FieldByName('NUM_GGVAL_MSG').AsInteger;
      if (FieldByName('TIPO').AsString = 'DT') or (FieldByName('TIPO').AsString = 'DC') or (FieldByName('TIPO').AsString = 'DS') then
      begin
        F:=FieldByName('FORMATO').AsString;
        if Pos('31',F) > 0 then
        begin
          D:=R180FineMese(D);
          F:=StringReplace(F,'31','dd',[]);
        end;
        if F = UpperCase(F) then
          R110FCreazioneFileMessaggi.SelT292.FieldByName('VALORE_DEFAULT').AsString:=UpperCase(FormatDateTime(F,D))
        else
          R110FCreazioneFileMessaggi.SelT292.FieldByName('VALORE_DEFAULT').AsString:=FormatDateTime(F,D);
      end;
      R110FCreazioneFileMessaggi.SelT292.FieldByName('CHIAVE').AsString:=
        FieldByName('CHIAVE').AsString;
      R110FCreazioneFileMessaggi.SelT292.Post;
      Next;
    end;
  end;
end;

procedure TB010FMessaggiOrologiDTM1.selT290DATAHHValidate(Sender: TField);
begin
  R180OraValidate(selT290DATAHH.AsString);
end;

procedure TB010FMessaggiOrologiDTM1.selT290DATADDValidate(Sender: TField);
begin
  if selT290.FieldByName('DATADD').AsString <> '' then
    if selT290.FieldByName('DATAMM').AsString = '' then
    begin
      if (selT290.FieldByName('DATADD').AsInteger < 1) or
         (selT290.FieldByName('DATADD').AsInteger > 31) then
        raise Exception.Create('Giorno inserito non valido!');
    end
    else
    begin
      if (selT290.FieldByName('DATADD').AsInteger < 1) or
         (selT290.FieldByName('DATADD').AsInteger > R180GiorniMese(EncodeDate(2001,selT290.FieldByName('DATAMM').AsInteger,1))) then
        raise Exception.Create('Giorno inserito non valido!');
    end;
end;

procedure TB010FMessaggiOrologiDTM1.selT290DATAMMValidate(Sender: TField);
begin
  if (selT290.FieldByName('DATAMM').AsString <> '') and
     ((selT290.FieldByName('DATAMM').AsInteger < 1) or
     (selT290.FieldByName('DATAMM').AsInteger > 12)) then
    raise Exception.Create('Mese inserito non valido!');
end;

procedure TB010FMessaggiOrologiDTM1.selT290GIORNOValidate(Sender: TField);
begin
  if selT290GIORNO.AsString <> '' then
    if not (selT290GIORNO.AsInteger in [1..7]) then
      raise Exception.Create('Giorno della settimana non valido!');
end;

procedure TB010FMessaggiOrologiDTM1.selT290CalcFields(DataSet: TDataSet);
begin
  if selT290.FieldByName('GIORNO').AsString <> '' then
    case selT290.FieldByName('GIORNO').AsInteger of
      1: selT290.FieldByName('D_GIORNO').AsString:='Lunedì';
      2: selT290.FieldByName('D_GIORNO').AsString:='Martedì';
      3: selT290.FieldByName('D_GIORNO').AsString:='Mercoledì';
      4: selT290.FieldByName('D_GIORNO').AsString:='Giovedì';
      5: selT290.FieldByName('D_GIORNO').AsString:='Venerdì';
      6: selT290.FieldByName('D_GIORNO').AsString:='Sabato';
      7: selT290.FieldByName('D_GIORNO').AsString:='Domenica';
    end;  
end;

procedure TB010FMessaggiOrologiDTM1.DataModuleDestroy(Sender: TObject);
var i:integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  DistruzioneR110;
  SessioneIWR110.SessioneOracle:=nil;
  FreeAndNil(SessioneIWR110);
  FreeAndNil(C004);
  FreeAndNil(lstAnagrafe);
end;

end.
