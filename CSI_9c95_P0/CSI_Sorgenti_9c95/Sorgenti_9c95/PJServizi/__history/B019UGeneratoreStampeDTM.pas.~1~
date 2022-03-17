unit B019UGeneratoreStampeDTM;

interface

uses
  Windows, Messages, SysUtils, StrUtils,Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData, A000Versione, A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali,
  (*Midaslib,*) Crtl, dbclient, ExtCtrls, ComCtrls, A001UPasswordDtM1, StdCtrls, C004UParamForm, Variants,
  C700USelezioneAnagrafe, QueryPK, RegistrazioneLog, MConnect, ActiveX, ShellAPI;

type
  TB019FGeneratoreStampeDtM = class(TDataModule)
    selT925: TOracleDataSet;
    selAnagrafe: TOracleDataSet;
    selT925DATADD: TStringField;
    selT925DATAMM: TStringField;
    selT925DATAYY: TStringField;
    selT925DATAHH: TStringField;
    Timer1: TTimer;
    selT003: TOracleDataSet;
    selT925GIORNO: TStringField;
    selT925D_GIORNO: TStringField;
    selI090: TOracleDataSet;
    selT926: TOracleDataSet;
    selT925ID: TIntegerField;
    selT926ID: TIntegerField;
    selT926CODICE_STAMPA: TStringField;
    selT926SELEZIONE: TStringField;
    selT926DAL: TStringField;
    selT926AL: TStringField;
    selT926NOME_FILE: TStringField;
    selT926ROTTURA: TStringField;
    selT925MaxID: TOracleQuery;
    selT910: TOracleDataSet;
    selT003Nome: TOracleDataSet;
    selCols: TOracleDataSet;
    selDalAlFile: TOracleDataSet;
    selT926NOME_LOG: TStringField;
    A077DCom: TDCOMConnection;
    selT926SEMAFORO: TStringField;
    selT926INTESTAZIONE_LOG: TStringField;
    selT926DETTAGLIO_LOG: TStringField;
    P077DCom: TDCOMConnection;
    selT926CMD_AFTER: TStringField;
    selT912: TOracleDataSet;
    selT925FUNZIONE_GG: TStringField;
    selT925FunzioneGG: TOracleDataSet;
    selT925DESCRIZIONE: TStringField;
    selSqlAfter: TOracleQuery;
    selT926SQL_AFTER: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT925BeforePost(DataSet: TDataSet);
    procedure selT925DATAHHValidate(Sender: TField);
    procedure selT925DATADDValidate(Sender: TField);
    procedure selT925DATAMMValidate(Sender: TField);
    procedure DataModuleDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure selT925GIORNOValidate(Sender: TField);
    procedure selT925CalcFields(DataSet: TDataSet);
    procedure selT925AfterScroll(DataSet: TDataSet);
    procedure selT926NewRecord(DataSet: TDataSet);
    procedure selT925BeforeDelete(DataSet: TDataSet);
    procedure selT926BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    //lstLog:TStringList;
    SelezioneAnagrafica,Rottura:String;
    procedure PreparaFiltroAnagr;
  public
    { Public declarations }
    SessioneIWB019:TSessioneIrisWIN;
    C004:TC004FParamForm;
    StatusBar:TStatusBar;
    //FileLog:String;
    Res:Integer;
    procedure ConnettiDataBase(DB,Azienda:String);
    procedure AperturaTabelleSessioneOracle;
    //procedure SalvaLog;
    procedure Elaborazione(Singola:Boolean);
    //procedure ScriviLog(S:String);
  end;

var
  B019FGeneratoreStampeDtM: TB019FGeneratoreStampeDtM;

implementation

{$R *.DFM}

procedure TB019FGeneratoreStampeDtM.DataModuleCreate(Sender: TObject);
begin
  SessioneIWB019:=A000SessioneIrisWIN;
  if Self.Owner <> nil then
    if Self.Owner is TSessioneIrisWIN then
      SessioneIWB019:=Self.Owner as TSessioneIrisWIN;
  //lstLog:=TStringList.Create;
end;

procedure TB019FGeneratoreStampeDtM.ConnettiDataBase(DB,Azienda:String);
var i:Integer;
    A001:TA001FPasswordDtM1;
begin
  //FileLog:=ExtractFilePath(Application.ExeName) + 'B019_' + DB + '_' + Azienda + '.log';
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if (Components[i] is TOracleQuery) and ((Components[i] as TOracleQuery).Session = nil) then
      (Components[i] as TOracleQuery).Session:=SessioneIWB019.SessioneOracle;
    if (Components[i] is TOracleDataSet) and ((Components[i] as TOracleDataSet).Session = nil) then
      (Components[i] as TOracleDataSet).Session:=SessioneIWB019.SessioneOracle;
  end;
  Timer1.Enabled:=False;
  SessioneIWB019.Parametri.Applicazione:='RILPRE';
  A001:=TA001FPasswordDtM1.Create(SessioneIWB019);
  try
    A001.InizializzazioneSessione(DB);
    A001.QI090.Close;
    A001.QI090.SetVariable('AZIENDA',Azienda);
    A001.QI090.Open;
    if A001.QI090.RecordCount = 0 then
    begin
      A001.QI090.Close;
      A001.QI090.SetVariable('AZIENDA','AZIN');
      A001.QI090.Open;
    end;
    A001.RegistraInibizioni;
  except
  end;
  FreeAndNil(A001);
  if (not SessioneIWB019.SessioneOracle.Connected) or (SessioneIWB019.SessioneOracle.LogonDataBase <> DB) or (SessioneIWB019.SessioneOracle.LogonUsername <> SessioneIWB019.Parametri.Username) then
  try
    //A000ParamDBOracle(SessioneB010);
    A000ParamDBOracleMultiThread(SessioneIWB019);
  except
  end;
  try
    AperturaTabelleSessioneOracle;
    C004:=CreaC004(SessioneIWB019.SessioneOracle,'B019',SessioneIWB019.Parametri.ProgOper,False);
  except
  end;
end;

procedure TB019FGeneratoreStampeDtM.AperturaTabelleSessioneOracle;
begin
  if not SessioneIWB019.SessioneOracle.Connected then
    exit;
  try selI090.Open; except end;
  try selT925.Open; except end;
end;

procedure TB019FGeneratoreStampeDtM.selT925AfterScroll(DataSet: TDataSet);
begin
  selT926.DisableControls;
  try
    selT926.Close;
    selT926.SetVariable('ID',selT925.FieldByName('ID').AsInteger);
    selT926.Open;
  finally
    selT926.EnableControls;
  end;
end;

procedure TB019FGeneratoreStampeDtM.selT925BeforeDelete(DataSet: TDataSet);
begin
  while not selT926.Eof do
    selT926.Delete;
end;

procedure TB019FGeneratoreStampeDtM.selT925BeforePost(DataSet: TDataSet);
begin
  if (selT925.FieldByName('DATAMM').AsString <> '') and
     (selT925.FieldByName('DATADD').AsString = '') then
    raise Exception.Create('Giorno non specificato!');
  if (selT925.FieldByName('DATAYY').AsString <> '') and
     (selT925.FieldByName('DATAMM').AsString = '') then
    raise Exception.Create('Mese non specificato!');
  if selT925.FieldByName('DATAHH').AsString = '' then
    raise Exception.Create('Ora obbligatoria!');
  if (selT925.FieldByName('DATADD').AsString <> '') and
     (selT925.FieldByName('DATAMM').AsString <> '') and
     (selT925.FieldByName('DATAYY').AsString <> '') then
    try
      EncodeDate(selT925.FieldByName('DATAYY').AsInteger,selT925.FieldByName('DATAMM').AsInteger,
        selT925.FieldByName('DATADD').AsInteger);
    except
      raise Exception.Create('Data inserita non valida!');
    end;
  if (selT925.FieldByName('DATADD').AsString = '') and
     (selT925.FieldByName('DATAMM').AsString = '') and
     (selT925.FieldByName('DATAYY').AsString = '') and
     (selT925.FieldByName('DATAHH').AsString <> '') then
    if selT925.FieldByName('GIORNO').AsString = '' then
    begin
      if TQueryPK(SessioneIWB019.QueryPK1).EsisteChiave('T290_MESSAGGIOROLOGI',selT925.RowId,selT925.State,['DATAHH'],[selT925.FieldByName('DATAHH').AsString]) then
        raise Exception.Create('Ora inserita non valida: ora duplicata!');
    end
    else
      with TOracleQuery.Create(nil) do
      try
        Session:=selT925.Session;
        SQL.Clear;
        SQL.Add('SELECT COUNT(*) FROM MONDOEDP.T290_MESSAGGIOROLOGI ');
        SQL.Add('WHERE DATAHH = ''' + selT925.FieldByName('DATAHH').AsString + ''' AND ');
        SQL.Add('GIORNO = ''' + selT925.FieldByName('GIORNO').AsString + '''');
        Execute;
        if Field(0) > 1 then
          raise Exception.Create('Ora inserita non valida: ora duplicata!');
      finally
        Free;
      end;
  if (selT925.FieldByName('GIORNO').AsString <> '') and
    ((selT925.FieldByName('DATADD').AsString <> '') or
     (selT925.FieldByName('DATAMM').AsString <> '') or
     (selT925.FieldByName('DATAYY').AsString <> '')) then
    raise Exception.Create('Non è possibile indicare il giorno della settimana a fronte di una data specifica!');
  if selT925.State = dsInsert then
  begin
    selT925MaxID.Execute;
    selT925.FieldByName('ID').AsInteger:=selT925MaxID.FieldAsInteger(0) + 1;
  end;
end;

procedure TB019FGeneratoreStampeDtM.Timer1Timer(Sender: TObject);
var AdessoGiorno:TDate;
    Anno,Mese,Giorno,Minuti:word;
    GiornoSett:integer;
begin
  A000SettaVariabiliAmbiente;
  //Verifica della connessione al database
  if SessioneIWB019.SessioneOracle.CheckConnection(False) = ccError then
  begin
    //SessioneB010.LogonDataBase:=DataBase;
    SessioneIWB019.SessioneOracle.Logon;
    AperturaTabelleSessioneOracle;
  end;
  if not SessioneIWB019.SessioneOracle.Connected then
  begin
    SessioneIWB019.SessioneOracle.Logon;
    AperturaTabelleSessioneOracle;
  end;
  //SessioneIWB019.RegistraMsg.IniziaMessaggio('B019'); // daniloc. 19.04.2010
  AdessoGiorno:=Date;
  DecodeDate(AdessoGiorno,Anno,Mese,Giorno);
  GiornoSett:=DayOfWeek(AdessoGiorno) - 1;
  Minuti:=R180OreMinuti(Time);
  //Ricerca schedulazione
  with selT925 do
  begin
    Close;
    Open;
    while not Eof do
    begin
      if FieldByName('FUNZIONE_GG').AsString <> '' then
      begin
        selT925FunzioneGG.Close;
        selT925FunzioneGG.SetVariable('FUNZIONE_GG',FieldByName('FUNZIONE_GG').AsString);
        selT925FunzioneGG.Open;
        if (selT925FunzioneGG.Fields[0].AsString = 'S') and
           (R180OreMinutiExt(FieldByName('DATAHH').AsString) = Minuti) then
        begin
          selT925FunzioneGG.Close;
          Elaborazione(False);
          Break;
        end;
        selT925FunzioneGG.Close;
      end
      else if FieldByName('DATAYY').AsString <> '' then
      begin
        if (FieldByName('DATAYY').AsInteger = Anno) and
           (FieldByName('DATAMM').AsInteger = Mese) and
           (FieldByName('DATADD').AsInteger = Giorno) and
           (R180OreMinutiExt(FieldByName('DATAHH').AsString) = Minuti) then
        begin
          Elaborazione(False);
          Break;
        end
      end
      else if FieldByName('DATAMM').AsString <> '' then
      begin
        if (FieldByName('DATAMM').AsInteger = Mese) and
           (FieldByName('DATADD').AsInteger = Giorno) and
           (R180OreMinutiExt(FieldByName('DATAHH').AsString) = Minuti) then
        begin
          Elaborazione(False);
          Break;
        end
      end
      else if FieldByName('DATADD').AsString <> '' then
      begin
        if (FieldByName('DATADD').AsInteger = Giorno) and
           (R180OreMinutiExt(FieldByName('DATAHH').AsString) = Minuti) then
        begin
          Elaborazione(False);
          Break;
        end
      end
      else if FieldByName('GIORNO').AsString <> '' then
      begin
        if (FieldByName('GIORNO').AsInteger = GiornoSett) and
           (R180OreMinutiExt(FieldByName('DATAHH').AsString) = Minuti) then
        begin
          Elaborazione(False);
          Break;
        end
      end
      else if R180OreMinutiExt(FieldByName('DATAHH').AsString) = Minuti then
      begin
        Elaborazione(False);
        Break;
      end;
      Next;
    end;
  end;
end;

procedure TB019FGeneratoreStampeDtM.Elaborazione(Singola:Boolean);
var Applicazione,NomeFile,NomeFileCorr,
    NomeLog,NomeLogCorr,SelezioneAnagraficaCorr,
    A077CodiceStampa,A077Azienda,A077Operatore,A077LogonDB:WideString;
    TestoLog,Cmd,RowIdT926:String;
    DettaglioLog:OleVariant;
    lstCmd{,lstFile}:TStringList;
    i:Integer;
    LogUnixFormat:Boolean;
    wR180SyncProcessExecResults:T180SyncProcessExecResults;
  procedure ScriviFileLog(NF,Tab:String);
  var S:String;
      Attrs:Integer;
      F:TSearchRec;
  begin
    if Trim(TestoLog) = '' then
      exit;
    if Trim(selT926.FieldByName('NOME_LOG').AsString) <> '' then
    begin
      if NomeLogCorr <> StringReplace(NomeLog,'<ROTTURA>',selAnagrafe.Fields[0].AsString,[rfReplaceAll]) then
      begin
        try
          DeleteFile(StringReplace(NomeLog,'<ROTTURA>',selAnagrafe.Fields[0].AsString,[rfReplaceAll]));
        except
        end;
        NomeLogCorr:=StringReplace(NomeLog,'<ROTTURA>',selAnagrafe.Fields[0].AsString,[rfReplaceAll]);
        ForceDirectories(ExtractFileDir(NomeLogCorr));
        if Trim(selDalAlFile.FieldByName('INTESTAZIONE_LOG').AsString) <> '' then
        begin
          S:=StringReplace(selDalAlFile.FieldByName('INTESTAZIONE_LOG').AsString,'<ROTTURA>',selAnagrafe.Fields[0].AsString,[rfReplaceAll]);
          if LogUnixFormat then
          begin
            R180AppendFileNoCR(NomeLogCorr,StringReplace(S,#13#10,#10,[rfReplaceAll]));
            R180AppendFileNoCR(NomeLogCorr,#10);
          end
          else
            R180AppendFile(NomeLogCorr,S);
        end;
      end;
      S:=StringReplace(TestoLog,'<NOME_FILE>',ExtractFileName(NF),[rfReplaceAll]);
      if Pos('<DIM_FILE>',S) > 0 then
      begin
        Attrs:=FileGetAttr(NF);
        if Attrs >= 0 then
        begin
          if FindFirst(NF, Attrs, F) = 0 then
            S:=StringReplace(S,'<DIM_FILE>',inttostr(Round(F.Size/1000)),[rfReplaceAll])
          else
            S:=StringReplace(S,'<DIM_FILE>','0',[rfReplaceAll]);
          FindClose(F);
        end;
      end;
      if LogUnixFormat then
      begin
        R180AppendFileNoCR(NomeLogCorr,StringReplace(S,#13#10,#10,[rfReplaceAll]));
        R180AppendFileNoCR(NomeLogCorr,#10);
      end
      else
        R180AppendFile(NomeLogCorr,S);
    end;
  end;
begin
  TRegistraMsg(SessioneIWB019.RegistraMsg).IniziaMessaggio('B019'); // daniloc. 19.04.2010
  if not Singola then
    selT926.First;
  while not selT926.Eof do
  try
    if (VarToStr(selI090.Lookup('AZIENDA',SessioneIWB019.Parametri.Azienda,'VERSIONEDB')) <> '') and (VarToStr(selI090.Lookup('AZIENDA',SessioneIWB019.Parametri.Azienda,'VERSIONEDB')) <> VersionePA) then
    begin
      //lstLog.Clear;
      //lstLog.Add(Format('%s - Azienda: %s - Stampa: %s - La versione del database (%s) non corrisponde alla versione del prodotto(%s). Elaborazione interrotta!',[DateTimeToStr(Now),SessioneIWB019.Parametri.Azienda,selT926.FieldByName('CODICE_STAMPA').AsString,VarToStr(selI090.Lookup('AZIENDA',SessioneIWB019.Parametri.Azienda,'VERSIONEDB')),VersionePA]));
      //lstLog.Add('');
      TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('A',Format('Azienda: %s - Stampa: %s - La versione del database (%s) non corrisponde alla versione del prodotto(%s). Elaborazione interrotta!',[SessioneIWB019.Parametri.Azienda,selT926.FieldByName('CODICE_STAMPA').AsString,VarToStr(selI090.Lookup('AZIENDA',SessioneIWB019.Parametri.Azienda,'VERSIONEDB')),VersionePA]),SessioneIWB019.Parametri.Azienda);
      C004.selT001.Close;
      C004.selT001.Open;
      //SalvaLog;
      if Singola then
        Break;
      selT926.Next;
      Continue;
    end;
    //lstLog.Add(Format('%s - Azienda: %s - Stampa: %s - Selezione: %s',[DateTimeToStr(Now),Parametri.Azienda,selT926.FieldByName('CODICE_STAMPA').AsString,selT926.FieldByName('SELEZIONE').AsString]));
    TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('I',Format('Azienda: %s - Stampa: %s - Selezione: %s',[SessioneIWB019.Parametri.Azienda,selT926.FieldByName('CODICE_STAMPA').AsString,selT926.FieldByName('SELEZIONE').AsString]),SessioneIWB019.Parametri.Azienda);
    try
      selDalAlFile.Close;
      selDalAlFile.SetVariable('DAL',selT926.FieldByName('DAL').AsString);
      selDalAlFile.SetVariable('AL',selT926.FieldByName('AL').AsString);
      if Pos('''',selT926.FieldByName('NOME_FILE').AsString) = 0 then
        selDalAlFile.SetVariable('NOME_FILE','''' + selT926.FieldByName('NOME_FILE').AsString + '''')
      else
        selDalAlFile.SetVariable('NOME_FILE',selT926.FieldByName('NOME_FILE').AsString);
      if Pos('''',selT926.FieldByName('NOME_LOG').AsString) = 0 then
        selDalAlFile.SetVariable('NOME_LOG','''' + selT926.FieldByName('NOME_LOG').AsString + '''')
      else
        selDalAlFile.SetVariable('NOME_LOG',selT926.FieldByName('NOME_LOG').AsString);
      if Pos('''',selT926.FieldByName('INTESTAZIONE_LOG').AsString) = 0 then
        selDalAlFile.SetVariable('INTESTAZIONE_LOG','''' + selT926.FieldByName('INTESTAZIONE_LOG').AsString + '''')
      else
        selDalAlFile.SetVariable('INTESTAZIONE_LOG',selT926.FieldByName('INTESTAZIONE_LOG').AsString);
      if Pos('''',selT926.FieldByName('SEMAFORO').AsString) = 0 then
        selDalAlFile.SetVariable('SEMAFORO','''' + selT926.FieldByName('SEMAFORO').AsString + '''')
      else
        selDalAlFile.SetVariable('SEMAFORO',selT926.FieldByName('SEMAFORO').AsString);
      selDalAlFile.Open;
      if Trim(selDalAlFile.FieldByName('SEMAFORO').AsString) <> '' then
      try
        DeleteFile(selDalAlFile.FieldByName('SEMAFORO').AsString);
      except
      end;
    except
      on E:Exception do
      begin
        //lstLog.Add('  ' + E.Message);
        //lstLog.Add('');
        //SalvaLog;
        TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('A','  ' + E.Message + ' (' + E.ClassName + ')',SessioneIWB019.Parametri.Azienda);
        if Singola then
          Break;
        selT926.Next;
        Continue;
      end;
    end;
    selT910.Open;
    if selT910.SearchRecord('CODICE',selT926.FieldByName('CODICE_STAMPA').AsString,[srFromBeginning]) then
    begin
      Applicazione:=selT910.FieldByName('APPLICAZIONE').AsString;
      SessioneIWB019.Parametri.Applicazione:=Applicazione;
      //SessioneIWB019.Parametri.Operatore:='SYSMAN';//???????????
    end
    else
    begin
      //lstLog.Add('  Stampa inesistente!');
      //lstLog.Add('');
      //SalvaLog;
      TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('A','  Stampa inesistente!',SessioneIWB019.Parametri.Azienda);
      if Singola then
        Break;
      selT926.Next;
      Continue;
    end;
    selT003.Close;
    selT003.SetVariable('NOME',selT926.FieldByName('SELEZIONE').AsString);
    selT003.Open;
    if (selT003.RecordCount = 0) and (not selT926.FieldByName('SELEZIONE').IsNull) then
    begin
      //lstLog.Add(Format('  Selezione %s inesistente!',[selT926.FieldByName('SELEZIONE').AsString]));
      //lstLog.Add('');
      //SalvaLog;
      TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('A',Format('  Selezione %s inesistente!',[selT926.FieldByName('SELEZIONE').AsString]),SessioneIWB019.Parametri.Azienda);
      if Singola then
        Break;
      selT926.Next;
      Continue;
    end;
    PreparaFiltroAnagr;
    NomeFile:=selDalAlFile.FieldByName('NOME_FILE').AsString;
    NomeLog:=StringReplace(selDalAlFile.FieldByName('NOME_LOG').AsString,'<UNIX>','',[]);
    LogUnixFormat:=Pos('<UNIX>',selDalAlFile.FieldByName('NOME_LOG').AsString) > 0;
    if (NomeFile = '') and (selT910.FieldByName('TABELLA_GENERATA').IsNull) then
    begin
      //lstLog.Add('  File non specificato - Tabella non specificata - Elaborazione annullata!');
      //lstLog.Add('');
      //SalvaLog;
      TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('A','  File non specificato - Tabella non specificata - Elaborazione annullata!',SessioneIWB019.Parametri.Azienda);
      if Singola then
        Break;
      selT926.Next;
      Continue;
    end;
    NomeLogCorr:='';
    while not selAnagrafe.Eof do
    begin
      if NomeFile <> '' then
      begin
        NomeFileCorr:=StringReplace(NomeFile,'<ROTTURA>',selAnagrafe.Fields[0].AsString,[rfReplaceAll]);
        //lstLog.Add(Format('  %sGenerazione file %s',[IfThen(Rottura = '','',Format('Elaborazione %s=%s - ',[Rottura,selAnagrafe.Fields[0].AsString])),NomeFileCorr]));
        TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('I',Format('  %sGenerazione file %s',[IfThen(Rottura = '','',Format('Elaborazione %s=%s - ',[Rottura,selAnagrafe.Fields[0].AsString])),NomeFileCorr]),SessioneIWB019.Parametri.Azienda);
        ForceDirectories(ExtractFileDir(NomeFileCorr));
      end
      else
      begin
        NomeFileCorr:='';
        //lstLog.Add(Format('  %sGenerazione tabella %s',[IfThen(Rottura = '','',Format('Elaborazione %s=%s - ',[Rottura,selAnagrafe.Fields[0].AsString])),selT910.FieldByName('TABELLA_GENERATA').AsString]));
        TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('I',Format('  %sGenerazione tabella %s',[IfThen(Rottura = '','',Format('Elaborazione %s=%s - ',[Rottura,selAnagrafe.Fields[0].AsString])),selT910.FieldByName('TABELLA_GENERATA').AsString]),SessioneIWB019.Parametri.Azienda);
      end;
      if Rottura = '' then
        SelezioneAnagraficaCorr:=SelezioneAnagrafica
      else
        SelezioneAnagraficaCorr:=StringReplace(SelezioneAnagrafica,'<ROTTURA>',Format('AND %s=''%s''',[Rottura,selAnagrafe.Fields[0].AsString]),[rfReplaceAll]);
      A077CodiceStampa:=selT926.FieldByName('CODICE_STAMPA').AsString;
      A077Operatore:='B019';//SessioneIWB019.Parametri.Operatore;
      A077Azienda:=SessioneIWB019.Parametri.Azienda;
      A077LogonDB:=selT925.Session.LogonDataBase;
      DettaglioLog:=selT926.FieldByName('DETTAGLIO_LOG').AsString;
      CoInitialize(nil);
      if Applicazione = 'PAGHE' then
      begin
        if not P077DCom.Connected then
          try
            P077DCom.Connected:=True;
          except
            on E:Exception do
            begin
              TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('A','  Errore durante la connessione all''oggetto COM P077: ' + E.Message + ' (' + E.ClassName + ')',SessioneIWB019.Parametri.Azienda);
              raise;
            end;
          end;
        try
          P077DCom.AppServer.CreaStampa(SelezioneAnagraficaCorr,
                                        A077CodiceStampa,
                                        NomeFileCorr,
                                        'S',
                                        A077Operatore,
                                        A077Azienda,
                                        Applicazione,
                                        A077LogonDB,
                                        selDalAlFile.FieldByName('DAL').AsDateTime,
                                        selDalAlFile.FieldByName('AL').AsDateTime,
                                        DettaglioLog);
          TestoLog:=VarToStr(DettaglioLog);
          TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('I','  Elaborazione completata.',SessioneIWB019.Parametri.Azienda);
        finally
          P077DCom.Connected:=False;
        end;
      end
      else
      begin
        if not A077DCom.Connected then
          try
            A077DCom.Connected:=True;
          except
            on E:Exception do
            begin
              TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('A','  Errore durante la connessione all''oggetto COM A077: ' + E.Message + ' (' + E.ClassName + ')',SessioneIWB019.Parametri.Azienda);
              raise;
            end;
          end;
        try
          A077DCom.AppServer.CreaStampa(SelezioneAnagraficaCorr,
                                        A077CodiceStampa,
                                        NomeFileCorr,
                                        'S',
                                        A077Operatore,
                                        A077Azienda,
                                        Applicazione,
                                        A077LogonDB,
                                        selDalAlFile.FieldByName('DAL').AsDateTime,
                                        selDalAlFile.FieldByName('AL').AsDateTime,
                                        DettaglioLog);
          TestoLog:=VarToStr(DettaglioLog);
          TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('I','  Elaborazione completata',SessioneIWB019.Parametri.Azienda);
        finally
          A077DCom.Connected:=False;
        end;
      end;
      CoUninitialize;
      ScriviFileLog(NomeFileCorr,selT910.FieldByName('TABELLA_GENERATA').AsString);
      selAnagrafe.Next;
    end;
    C004.selT001.Close;
    C004.selT001.Open;
    //lstLog.Add('');
    //SalvaLog;
    if Trim(selDalAlFile.FieldByName('SEMAFORO').AsString) <> '' then
    try
      R180AppendFile(selDalAlFile.FieldByName('SEMAFORO').AsString,'');
    except
      on E:Exception do
      begin
        //lstLog.Add('  ' + E.Message);
        //lstLog.Add('');
        //SalvaLog;
        TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('A','  ' + E.Message + ' (' + E.ClassName + ')',A077Azienda);
      end;
    end;
    (*if True then
    begin
      lstFile:=TStringList.Create;
      try
        lstFile.LoadFromFile(NomeLogCorr);
        S:=lstFile.Text;
        S:=StringReplace(S,#13#10,#10,[rfReplaceAll]);
        lstFile.Text:=S;
        R180AppendFile(NomeLogCorr + '.txt',S);
      finally
        lstFile.Free;
      end;
    end;*)
    //Esecuzione di script SQL al termine dell'elaborazione
    if Trim(selT926.FieldByName('SQL_AFTER').AsString) <> '' then
    begin
      TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('I','  Esecuzione script SQL post-elaborazione',SessioneIWB019.Parametri.Azienda);
      lstCmd:=TStringList.Create;
      try
        if Pos('declare',selSqlAfter.SQL.Text.ToLower) = 0 then
          selSqlAfter.SQL.Text:='begin' + CRLF + selT926.FieldByName('SQL_AFTER').AsString + CRLF + 'end;'
        else
          selSqlAfter.SQL.Text:=selT926.FieldByName('SQL_AFTER').AsString;

        selSqlAfter.DeleteVariables;
        lstCmd:=FindVariables(selT926.FieldByName('SQL_AFTER').AsString, False);
        if lstCmd.Count > 0 then
        begin
          if lstCmd.IndexOf('DAL') >= 0 then
          begin
            selSqlAfter.DeclareVariable('DAL',otDate);
            selSqlAfter.SetVariable('DAL',selDalAlFile.FieldByName('DAL').AsDateTime);
          end;
          if lstCmd.IndexOf('AL') >= 0 then
          begin
            selSqlAfter.DeclareVariable('AL',otDate);
            selSqlAfter.SetVariable('AL',selDalAlFile.FieldByName('AL').AsDateTime);
          end;
          if lstCmd.IndexOf('STAMPA') >= 0 then
          begin
            selSqlAfter.DeclareVariable('STAMPA',otString);
            selSqlAfter.SetVariable('STAMPA',selT926.FieldByName('CODICE_STAMPA').AsString);
          end;
        end;
        try
          selSqlAfter.Execute;
          selSqlAfter.Session.Commit;
        except
          on E:Exception do
            TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('A',Format('  Errore esecuzione script SQL post-elaborazione: [%s] %s',[selT926.FieldByName('SQL_AFTER').AsString,E.Message]),SessioneIWB019.Parametri.Azienda);
        end;
        TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('I','  Esecuzione script SQL post-elaborazione completata.',SessioneIWB019.Parametri.Azienda);
      finally
        lstCmd.Free;
      end;
    end;
    //Esecuzione comando di sistema al termine dell'elaborazione (per es. per zippare i files...)
    if Trim(selT926.FieldByName('CMD_AFTER').AsString) <> '' then
    begin
      TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('I','  Esecuzione comandi post-elaborazione',SessioneIWB019.Parametri.Azienda);
      lstCmd:=TStringList.Create;
      try
        lstCmd.Text:=selT926.FieldByName('CMD_AFTER').AsString;
        for i:=0 to lstCmd.Count - 1 do
        begin
          Cmd:=lstCmd[i];
          TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('I','  ' + i.ToString + ':' + Cmd,SessioneIWB019.Parametri.Azienda);
          if Pos('<SEMAFORO>',Cmd) > 0 then
          begin
            if Cmd[Pos('<SEMAFORO>',Cmd) + Length('<SEMAFORO>')] = '.' then
              Cmd:=StringReplace(Cmd,'<SEMAFORO>',StringReplace(selDalAlFile.FieldByName('SEMAFORO').AsString,'.' + R180EstraiExtFile(selDalAlFile.FieldByName('SEMAFORO').AsString),'',[]),[rfReplaceAll])
            else
              Cmd:=StringReplace(Cmd,'<SEMAFORO>',selDalAlFile.FieldByName('SEMAFORO').AsString,[rfReplaceAll]);
          end;
          if Pos('<NOME_FILE>',Cmd) > 0 then
          begin
            Cmd:=StringReplace(Cmd,'<NOME_FILE>',NomeFile,[]);
            if Cmd[Pos('<NOME_FILE>',Cmd) + Length('<NOME_FILE>')] = '.' then
              Cmd:=StringReplace(Cmd,'<NOME_FILE>',StringReplace(NomeFile,'.' + R180EstraiExtFile(NomeFile),'',[]),[rfReplaceAll])
            else
              Cmd:=StringReplace(Cmd,'<NOME_FILE>',NomeFile,[rfReplaceAll]);
          end;
          if Pos('<NOME_LOG>',Cmd) > 0 then
          begin
            Cmd:=StringReplace(Cmd,'<NOME_LOG>',NomeLog,[]);
            if Cmd[Pos('<NOME_LOG>',Cmd) + Length('<NOME_LOG>')] = '.' then
              Cmd:=StringReplace(Cmd,'<NOME_LOG>',StringReplace(NomeLog,'.' + R180EstraiExtFile(NomeLog),'',[]),[rfReplaceAll])
            else
              Cmd:=StringReplace(Cmd,'<NOME_LOG>',NomeLog,[rfReplaceAll]);
          end;
          Cmd:=StringReplace(Cmd,'<ROTTURA>','*',[rfReplaceAll]);
          RowIdT926:=selT926.RowId;
          try
            //ExecReturn:=ShellExecute_AndWait('open',Cmd,CmdPar,'',SW_SHOWNA,True);
            wR180SyncProcessExecResults:=R180SyncProcessExec(Cmd,'','');
            if wR180SyncProcessExecResults.CodiceUscita <> 0 then
              TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('A',Format('  Errore esecuzione comando post-elaborazione: [%s] %s',[Cmd,wR180SyncProcessExecResults.DatiStdErr]),SessioneIWB019.Parametri.Azienda);
          finally
            selT926.SearchRecord('ROWID',RowIdT926,[srFromBeginning]);
          end;
        end; // ==> end for
        TRegistraMsg(SessioneIWB019.RegistraMsg).InserisciMessaggio('I','  Esecuzione comandi post-elaborazione completata.',SessioneIWB019.Parametri.Azienda);
      finally
        lstCmd.Free;
      end;
    end;
    if Singola then
      Break;
  finally
    selT926.Next;
  end;
  if StatusBar <> nil then
  begin
    StatusBar.SimpleText:='';
    StatusBar.Repaint;
  end;
end;

procedure TB019FGeneratoreStampeDtM.PreparaFiltroAnagr;
begin
  Rottura:='';
  if selT926.FieldByName('ROTTURA').AsString = '<SALTO_PAGINA>' then
    with selT912 do
    begin
      Close;
      SetVariable('CODICE',selT910.FieldByName('CODICE').AsString);
      Open;
      while not Eof do
      begin
        Rottura:=Rottura + IfThen(Rottura = '','','||') + FieldByName('NOME').AsString;
        Next;
      end;
    end
  else
    Rottura:=Trim(selT926.FieldByName('ROTTURA').AsString);
  selAnagrafe.Close;
  selAnagrafe.SQL.Clear;
  selAnagrafe.DeleteVariables;
  //Selezione da C700
  selAnagrafe.DeclareVariable('DATALAVORO',otDate);
  selAnagrafe.SetVariable('DATALAVORO',selDalAlFile.FieldByName('AL').AsDateTime);
  selAnagrafe.SQL.Text:=QVistaOracle;
  //if not selT926.FieldByName('ROTTURA').IsNull then
  if Rottura <> '' then
    selAnagrafe.SQL.Add('<ROTTURA>');
  with selT003 do
  begin
    First;
    if Copy(FieldByName('RIGA').AsString,1,5) <> 'ORDER' then
      selAnagrafe.SQL.Add(' AND ');
    while not Eof do
    begin
      selAnagrafe.SQL.Add(FieldByName('RIGA').AsString);
      Next;
    end;
  end;
  SelezioneAnagrafica:=Format('SELECT %s FROM',[C700CampiBase + ',T430DATADECORRENZA,T430DATAFINE']) + #13#10 + selAnagrafe.SQL.Text;
  selAnagrafe.SQL.Text:=StringReplace(selAnagrafe.SQL.Text,'<ROTTURA>','',[rfReplaceAll]);
  //if not selT926.FieldByName('ROTTURA').IsNull then
  if Rottura <> '' then
    //selAnagrafe.SQL.Insert(0,Format('SELECT DISTINCT %s FROM',[selT926.FieldByName('ROTTURA').AsString]))
    selAnagrafe.SQL.Insert(0,Format('SELECT DISTINCT %s FROM',[Rottura]))
  else
    selAnagrafe.SQL.Insert(0,'SELECT DISTINCT ''X'' FROM');
  if Pos('ORDER BY',UpperCase(selAnagrafe.SQL.Text)) > 0 then
    selAnagrafe.SQL.Text:=Copy(selAnagrafe.SQL.Text,1,Pos('ORDER BY',UpperCase(selAnagrafe.SQL.Text)) - 1);
  selAnagrafe.Open;
end;

procedure TB019FGeneratoreStampeDtM.selT925DATAHHValidate(Sender: TField);
begin
  R180OraValidate(selT925DATAHH.AsString);
end;

procedure TB019FGeneratoreStampeDtM.selT925DATADDValidate(Sender: TField);
begin
  if selT925.FieldByName('DATADD').AsString <> '' then
    if selT925.FieldByName('DATAMM').AsString = '' then
    begin
      if (selT925.FieldByName('DATADD').AsInteger < 1) or
         (selT925.FieldByName('DATADD').AsInteger > 31) then
        raise Exception.Create('Giorno inserito non valido!');
    end
    else
    begin
      if (selT925.FieldByName('DATADD').AsInteger < 1) or
         (selT925.FieldByName('DATADD').AsInteger > R180GiorniMese(EncodeDate(2001,selT925.FieldByName('DATAMM').AsInteger,1))) then
        raise Exception.Create('Giorno inserito non valido!');
    end;
end;

procedure TB019FGeneratoreStampeDtM.selT925DATAMMValidate(Sender: TField);
begin
  if (selT925.FieldByName('DATAMM').AsString <> '') and
     ((selT925.FieldByName('DATAMM').AsInteger < 1) or
     (selT925.FieldByName('DATAMM').AsInteger > 12)) then
    raise Exception.Create('Mese inserito non valido!');
end;

procedure TB019FGeneratoreStampeDtM.selT925GIORNOValidate(Sender: TField);
begin
  if selT925GIORNO.AsString <> '' then
    if not (selT925GIORNO.AsInteger in [1..7]) then
      raise Exception.Create('Giorno della settimana non valido!');
end;

procedure TB019FGeneratoreStampeDtM.selT926BeforePost(DataSet: TDataSet);
begin
  if selT926.FieldByName('NOME_FILE').IsNull and (VarToStr(selT910.Lookup('CODICE',selT926.FieldByName('CODICE_STAMPA').AsString,'TABELLA_GENERATA')) = '') then
    raise Exception.Create('Impossibile utilizzare questa stampa' + #13#10 + 'E'' necessario specificare un nome di file o deve essere associata una tabella Oracle.');
end;

procedure TB019FGeneratoreStampeDtM.selT926NewRecord(DataSet: TDataSet);
begin
  selT926.FieldByName('ID').AsInteger:=selT925.FieldByName('ID').AsInteger;
end;

procedure TB019FGeneratoreStampeDtM.selT925CalcFields(DataSet: TDataSet);
begin
  if selT925.FieldByName('GIORNO').AsString <> '' then
    case selT925.FieldByName('GIORNO').AsInteger of
      1: selT925.FieldByName('D_GIORNO').AsString:='Lunedì';
      2: selT925.FieldByName('D_GIORNO').AsString:='Martedì';
      3: selT925.FieldByName('D_GIORNO').AsString:='Mercoledì';
      4: selT925.FieldByName('D_GIORNO').AsString:='Giovedì';
      5: selT925.FieldByName('D_GIORNO').AsString:='Venerdì';
      6: selT925.FieldByName('D_GIORNO').AsString:='Sabato';
      7: selT925.FieldByName('D_GIORNO').AsString:='Domenica';
    end;
end;

procedure TB019FGeneratoreStampeDtM.DataModuleDestroy(Sender: TObject);
var i:integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  FreeAndNil(C004);
  //FreeAndNil(lstLog);
end;

end.



