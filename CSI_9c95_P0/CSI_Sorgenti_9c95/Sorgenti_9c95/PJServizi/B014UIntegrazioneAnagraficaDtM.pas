unit B014UIntegrazioneAnagraficaDtM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, C180FunzioniGenerali, Oracle, OracleData, Db, DBClient, comctrls,
  Variants, IdBaseComponent, IdComponent, IdTCPConnection, Provider,
  IdTCPClient, IdFTP, IdFTPCommon, IdAntiFreezeBase, IdAntiFreeze, Math,
  (*A000UInterfaccia,*) A000Versione, A000UCostanti, A000USessione, A001UPasswordDtM1,
  A136UComposizioneRelazioneMW, C004UParamForm, RegistrazioneLog,
  Clipbrd, IdExplicitTLSClientServerBase, OracleMonitor, IniFiles;

type
  TStrutturaFissa = record
    NomeStruttura,
    Ente,
    Sequenza,
    Data,
    Utente,
    Chiave,
    Decorrenza,
    Scadenza,
    Dato,
    Valore:String;
  end;

  TB014FIntegrazioneAnagraficaDtM = class(TDataModule)
    Timer1: TTimer;
    selI090: TOracleDataSet;
    selIA110: TOracleDataSet;
    selIA100: TOracleDataSet;
    selDatiInput: TOracleDataSet;
    insT030: TOracleQuery;
    SessioneAzienda: TOracleSession;
    scrCreazioneStorico: TOracleQuery;
    scrAllineaPeriodiStorici: TOracleQuery;
    scrAggiornamento: TOracleQuery;
    insIA000: TOracleQuery;
    delDatiInput: TOracleQuery;
    selIA190: TOracleDataSet;
    scrB014Personalizzata: TOracleQuery;
    insDatiInput: TOracleQuery;
    crtDatiInput: TOracleQuery;
    selIA110NomeDato: TOracleDataSet;
    SessioneLock: TOracleSession;
    IdFTP: TIdFTP;
    selIA120: TOracleDataSet;
    selDatiOutput: TOracleDataSet;
    insDatiOutput: TOracleQuery;
    ScriptBeforeAfter: TOracleScript;
    selCols: TOracleDataSet;
    delI030: TOracleQuery;
    selIA140: TOracleDataSet;
    selStruttura: TOracleDataSet;
    selDecStruttura: TOracleDataSet;
    selCntDec: TOracleDataSet;
    insT030NoTrigger: TOracleQuery;
    delT030NoTrigger: TOracleQuery;
    selTabStorica: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    StrutturaFissa: TStrutturaFissa;
    ProgCorr,RigheElaborate:Integer;
    DecorrenzaCorr:TDateTime;
    ValoreCorr:String;
    AllineamentoStorici,DaStoricizzare:Boolean;
    //lstLog:TStringList;
    //lstB014:TStringList;
    lstROWID:TStringList;
    lstColSize:TStringList;
    DatiNonStorici:TStringList;
    //SessioneIWB014:TSessioneIrisWIN;  // daniloc - spostato in public (gestione log su db)
    A136:TA136FComposizioneRelazioneMW;
    //procedure RegistraLogMessaggi(S:String);
    //procedure ScritturaFileLog;
    procedure GetParametriFunzione;
    procedure GetStrutturaFissa;
    procedure ImportazioneFile;
    procedure MigrazioneFileSuTabella(NomeFile:String);
    procedure ConnessioneAzienda;
    procedure GetDatiStruttura(Where:String);
    procedure ElaborazioneDati;
    procedure AggiornamentoDato(Dato,Valore:String);
    procedure RegistraLog(Dato,Valore,Stato,Messaggio,TestoSQL:String);
    procedure EliminazioneDatiElaborati;
    procedure ScriptInserimentoOutput;
    procedure EstrazioneDatiOutput;
    procedure ScritturaDatiOutputTabella;
    procedure ScritturaDatiOutputFile;
    procedure ScriviFile(Riga:String);
  public
    { Public declarations }
    RigheLog:Integer;
    AvvioAutomatico:Boolean;
    StatusBar:TStatusBar;
    //FileLog:String;
    //SessioneOracleB014,SOB014Interna: TOracleSession;
    SessioneIWB014:TSessioneIrisWIN;
    procedure ConnettiDataBase(Alias:String);
    procedure GetStruttureDaElaborare;
    procedure ElaborazioneStrutture(Strutture:String; Where:String='');
  end;

var
  B014FIntegrazioneAnagraficaDtM: TB014FIntegrazioneAnagraficaDtM;

implementation

uses Ac05UImportRimborsiDM;

{$R *.DFM}

procedure TB014FIntegrazioneAnagraficaDtM.DataModuleCreate(Sender: TObject);
begin
  //@Param
  SessioneIWB014:=A000SessioneIrisWIN;
  if Self.Owner <> nil then
    if Self.Owner is TSessioneIrisWIN then
      SessioneIWB014:=Self.Owner as TSessioneIrisWIN;
  //@Param
  //@Param SessioneOracleB014:=TOracleSession.Create(nil);
  //@Param SOB014Interna:=SessioneOracleB014;
  //lstLog:=TStringList.Create;
  //lstB014:=TStringList.Create;
  lstROWID:=TStringList.Create;
  lstColSize:=TStringList.Create;
  DatiNonStorici:=TStringList.Create;
  StatusBar:=nil;
end;

procedure TB014FIntegrazioneAnagraficaDtM.ConnettiDataBase(Alias:String);
var A001:TA001FPasswordDtM1;
    i:Integer;
begin
  try
    //FileLog:=ExtractFilePath(Application.ExeName) + 'B014_' + Alias + '.log';
    //Collegamento sull'utente MONDOEDP
    SessioneIWB014.Parametri.Applicazione:='RILPRE';
    SessioneIWB014.Parametri.DataBase:=Alias;//R180GetRegistro(HKEY_LOCAL_MACHINE,'B014','Database','IRIS');
    A001:=TA001FPasswordDtM1.Create(SessioneIWB014);
    try
      A001.InizializzazioneSessione(Alias);
      A001.QI090.SearchRecord('UTENTE','MONDOEDP',[srFromBeginning]);
      A001.RegistraInibizioni;
    finally
      FreeAndNil(A001);
    end;
    if not SessioneIWB014.SessioneOracle.Connected then
    begin
      //@Parametri A000ParamDBOracle(SessioneIWB014.SessioneOracle);
      A000ParamDBOracleMultiThread(SessioneIWB014);
    end;
    for i:=0 to Self.ComponentCount - 1 do
    begin
      if (Components[i] is TOracleQuery) and ((Components[i] as TOracleQuery).Session = nil) then
        (Components[i] as TOracleQuery).Session:=SessioneIWB014.SessioneOracle;
      if (Components[i] is TOracleDataSet) and ((Components[i] as TOracleDataSet).Session = nil) then
        (Components[i] as TOracleDataSet).Session:=SessioneIWB014.SessioneOracle;
    end;
    GetParametriFunzione;
    selI090.Open;
    (*if (AvvioAutomatico or (UpperCase(ExtractFileName(Application.ExeName)) = 'B014PINTEGRAZIONEANAGRAFICASRV.EXE')) then
    begin
      Timer1.Enabled:=True;
      Timer1Timer(nil);
    end;*)
  except
    on E:Exception do
    begin
      //RegistraLogMessaggi(E.Message);
      //ScritturaFileLog;
      TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A',E.Message);
    end;
  end;
end;

procedure TB014FIntegrazioneAnagraficaDtM.GetParametriFunzione;
var C004:TC004FParamForm;
begin
  C004:=CreaC004(SessioneIWB014.SessioneOracle,'B014',-1,False);
  AvvioAutomatico:=C004.GetParametro('AVVIO','S') = 'S';
  RigheLog:=StrToIntDef(C004.GetParametro('RIGHELOG','-1'),-1);
  FreeAndNil(C004);
end;

procedure TB014FIntegrazioneAnagraficaDtM.GetStruttureDaElaborare;
{ Funzione richiamata dal servizio }
var
  S:String;
begin
  A000SettaVariabiliAmbiente;
  //Verifica della connessione a MONDOEDP
  if SessioneIWB014.SessioneOracle.CheckConnection(False) = ccError then
    ConnettiDataBase(SessioneIWB014.Parametri.Database);
  if not SessioneIWB014.SessioneOracle.Connected then
    ConnettiDataBase(SessioneIWB014.Parametri.Database);
  if not SessioneIWB014.SessioneOracle.Connected then exit;
  try
    selIA190.SetVariable('ORA',R180OreMinuti(Now));
    selIA190.Close;
    selIA190.Open;
    S:='';
    while not selIA190.Eof do
    begin
      if S <> '' then
        S:=S + ',';
      S:=S + selIA190.FieldByName('STRUTTURE').AsString;
      selIA190.Next;
    end;
    if S <> '' then
      ElaborazioneStrutture(S);
  except
    on E:Exception do
    begin
      //RegistraLogMessaggi(E.Message);
      //ScritturaFileLog;
      TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A',E.Message);
    end;
  end;
end;

procedure TB014FIntegrazioneAnagraficaDtM.Timer1Timer(Sender: TObject);
var
  S:String;
begin
  A000SettaVariabiliAmbiente;
  //Verifica della connessione a MONDOEDP
  if SessioneIWB014.SessioneOracle.CheckConnection(False) = ccError then
    ConnettiDataBase(SessioneIWB014.Parametri.Database);
  if not SessioneIWB014.SessioneOracle.Connected then
    ConnettiDataBase(SessioneIWB014.Parametri.Database);
  try
    selIA190.SetVariable('ORA',R180OreMinuti(Now));
    selIA190.Close;
    selIA190.Open;
    S:='';
    while not selIA190.Eof do
    begin
      if S <> '' then
        S:=S + ',';
      S:=S + selIA190.FieldByName('STRUTTURE').AsString;
      selIA190.Next;
    end;
    if S <> '' then
      ElaborazioneStrutture(S);
  except
    on E:Exception do
    begin
      //RegistraLogMessaggi(E.Message);
      //ScritturaFileLog;
      TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A',E.Message);
    end;
  end;
end;

procedure TB014FIntegrazioneAnagraficaDtM.ElaborazioneStrutture(Strutture:String; Where:String='');
{Scorrimento sulla definizione delle strutture e sulle aziende}
type
  TDecPilota = record
    IniDec,
    FinDec:TDateTime;
  end;
  TDecRel = record
    Decorrenza: TDateTime;
  end;
var lst:TStringList;
    h,i,j,k:Integer;
    DecPilota: array of TDecPilota;
    NomeCampoDecorrenza,Azienda,Struttura,TabColPartenza,TabPartenza,ColPartenza,SLRColPilota,SLRColPilotata1,SLRColPilotata2,TableSpace,Decorrenze:String;
    DataDa,DataA,DecNuovaRel,DecFine:TDateTime;
    NumLivelli,VersioneDB:integer;
    selI090a:TOracleDataSet;
    CDSApp:TClientDataSet;
    recDecRel: array of TDecRel;
    IniFile: TIniFile;
    Ac05DM:TAc05FImportRimborsiDM;
    FileTemp:String;
begin
  //Verifica della connessione a MONDOEDP
  if SessioneIWB014.SessioneOracle.CheckConnection(False) = ccError then
    DataModuleCreate(nil);
  if not SessioneIWB014.SessioneOracle.Connected then
    DataModuleCreate(nil);
  //lstLog.Clear;
  //RegistraLogMessaggi('Inizio Integrazione');
  TRegistraMsg(SessioneIWB014.RegistraMsg).IniziaMessaggio('B014'); // daniloc. 20.04.2010
  TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('I','Inizio Integrazione');
  try
    if SessioneLock.CheckConnection(False) = ccError then
    begin
      SessioneLock.LogonDatabase:=SessioneIWB014.SessioneOracle.LogonDatabase;
      SessioneLock.LogonPassword:=SessioneIWB014.SessioneOracle.LogonPassword;
      SessioneLock.LogonUserName:=SessioneIWB014.SessioneOracle.LogonUserName;
      SessioneLock.Logon;
    end;
    selIA100.SetVariable('STRUTTURE','''' + StringReplace(Strutture,',',''',''',[rfReplaceAll]) + '''');
    selIA100.Close;
    selIA100.Open;
  except
    on E:Exception do
    begin
      //RegistraLogMessaggi(E.Message);
      //ScritturaFileLog;
      TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A',E.Message);
      Exit;
    end;
  end;
  //Rilettura della dimensione massima del file di log
  GetParametriFunzione;
  //Scorrimento delle strutture definite in MONDOEDP.IA100_STRUTTUREDATI
  lst:=TStringList.Create;
  lst.CommaText:=Strutture;
  for i:=0 to lst.Count - 1 do
  try
    if not selIA100.SearchRecord('NOME_STRUTTURA',lst[i],[srFromBeginning]) then
      Continue;
    if StatusBar <> nil then
    begin
      StatusBar.Panels[0].Text:='Elaborazione della struttura ' + selIA100.FieldByName('NOME_STRUTTURA').AsString;
      StatusBar.Panels[1].Text:='';
      StatusBar.Repaint;
      Application.ProcessMessages;
    end;
    //RegistraLogMessaggi('  Struttura: ' + selIA100.FieldByName('NOME_STRUTTURA').AsString);
    TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('I','  Struttura: ' + selIA100.FieldByName('NOME_STRUTTURA').AsString);
    lstROWID.Clear;
    if (selIA100.FieldByName('TIPO_STRUTTURA').AsString = 'F') and
       (selIA100.FieldByName('DIREZIONE_DATI').AsString = 'I') and
       (Pos('.XLS',UpperCase(selIA100.FieldByName('NOME_FILE').AsString)) = 0) and
       (Pos('.CSV',UpperCase(selIA100.FieldByName('NOME_FILE').AsString)) = 0) then
      ImportazioneFile;
    //Scorrimento delle aziende definite in MONDOEDP.I090_ENTI
    selI090.Refresh;
    selI090.First;
    while not selI090.Eof do
    try
      if (selI090.RecordCount > 1) and (selI090.FieldByName('CODICE_INTEGRAZIONE').IsNull) then
      begin
        selI090.Next;
        Continue;
      end;
      //RegistraLogMessaggi('    Azienda: ' + selI090.FieldByName('AZIENDA').AsString);
      TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('I','    Azienda: ' + selI090.FieldByName('AZIENDA').AsString,selI090.FieldByName('AZIENDA').AsString);
      if not A000ModuloAbilitato(selI090.Session,'INTEGRAZIONE_ANAGRAFICA',selI090.FieldByName('AZIENDA').AsString) then
      begin
        //RegistraLogMessaggi('- MODULO DISABILITATO -');
        //ScritturaFileLog;
        TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','- MODULO DISABILITATO -',selI090.FieldByName('AZIENDA').AsString);
        selI090.Next;
        Continue;
      end;
      if (not selI090.FieldByName('VERSIONEDB').IsNull) and (selI090.FieldByName('VERSIONEDB').AsString <> VersionePA) then
        //RegistraLogMessaggi(Format('    La versione del database (%s) non corrisponde alla versione del prodotto(%s). Si consiglia di aggiornare l''applicativo!',[selI090.FieldByName('VERSIONEDB').AsString,VersionePA]));
        TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A',Format('    La versione del database (%s) non corrisponde alla versione del prodotto(%s). Si consiglia di aggiornare l''applicativo!',[selI090.FieldByName('VERSIONEDB').AsString,VersionePA]),selI090.FieldByName('AZIENDA').AsString);
      selIA110.SetVariable('AZIENDA',selI090.FieldByName('AZIENDA').AsString);
      selIA110.SetVariable('NOME_STRUTTURA',selIA100.FieldByName('NOME_STRUTTURA').AsString);
      selIA110.Close;
      selIA110.Open;
      GetStrutturaFissa;
      if StrutturaFissa.Chiave = '' then
      begin
        //RegistraLogMessaggi('    *** Chiave non definita');
        TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','    *** Chiave non definita',selI090.FieldByName('AZIENDA').AsString);
        selI090.Next;
        Continue;
      end;
      try
        ConnessioneAzienda;
      except
        on E:Exception do
        begin
          //RegistraLogMessaggi('    *** ' + E.Message);
          TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','    *** ' + E.Message,selI090.FieldByName('AZIENDA').AsString);
          selI090.Next;
          Continue;
        end;
      end;
      RigheElaborate:=0;
      if selIA100.FieldByName('NOME_STRUTTURA').AsString = 'IA140_I030' then
      try
        if Trim(selIA100.FieldByName('SCRIPT_BEFORE').AsString) <> '' then
        with ScriptBeforeAfter do
        begin
          Lines.Clear;
          Lines.Text:=selIA100.FieldByName('SCRIPT_BEFORE').AsString;
          Execute;
          Session.Commit;
        end;
        //Gestione dell'integrazione delle relazioni tra dati anagrafici...
        //Inizializzo i componenti del DataModulo per la composizione automatica della relazione
        A136:=TA136FComposizioneRelazioneMW.Create(SessioneAzienda);
        A136.selI030:=TOracleDataSet.Create(nil);
        try
          A136.selI030.Session:=SessioneAzienda;
          A136.selI030.SQL.Text:='SELECT T.*, T.ROWID FROM I030_RELAZIONI_ANAGRAFE T ORDER BY TABELLA, COLONNA, DECORRENZA';
          A136.insI035.Session:=SessioneAzienda;
          //Accedo alla tabella che contiene le strutture da elaborare
          selIA140.Close;
          selIA140.SetVariable('TABELLA',selIA100.FieldByName('NOME_STRUTTURA').AsString);
          selIA140.Open;
          while not selIA140.Eof do
          begin
            if StatusBar <> nil then
            begin
              StatusBar.Panels[0].Text:='Elaborazione della relazione ' + selIA140.FieldByName('PILOTA').AsString + ' --> ' + selIA140.FieldByName('PILOTATO').AsString;
              StatusBar.Panels[1].Text:='';
              StatusBar.Repaint;
              Application.ProcessMessages;
            end;
            //Cancello tutte le relazioni esistenti per campo pilotato
            delI030.SetVariable('COLONNA',selIA140.FieldByName('PILOTATO').AsString);
            delI030.Execute;
            //Riapro il DataSet con le testate delle relazioni
            A136.selI030.Close;
            A136.selI030.Open;
            //Verifico se ci sono delle storicizzazioni dei valori pilota nelle relazioni
            j:=-1;
            //Estraggo tutte le decorrenze delle storicizzazioni dei valori pilota nelle relazioni
            selDecStruttura.Close;
            selDecStruttura.SetVariable('STRUTTURA',selIA140.FieldByName('STRUTTURA').AsString);
            selDecStruttura.Open;
            //Carico l'elenco delle decorrenze nell'apposito array
            while not selDecStruttura.Eof do
            begin
              if (j = -1) or (selDecStruttura.FieldByName('DECORRENZA').AsDateTime <> DecPilota[j].IniDec) then
              begin
                inc(j);
                SetLength(DecPilota,j+1);
                DecPilota[j].IniDec:=selDecStruttura.FieldByName('DECORRENZA').AsDateTime;
                if j > 0 then
                  DecPilota[j-1].FinDec:=DecPilota[j].IniDec-1;
              end;
              selDecStruttura.Next;
            end;
            if j > -1 then
              DecPilota[j].FinDec:=EncodeDate(3999,12,31);
            for k:=0 to j do
              with A136 do
              begin
                //Inserisco la testata di una nuova relazione per Tabella/ColonnaPilotata/Decorrenza
                selI030.Refresh;
                selI030.Insert;
                selI030.FieldByName('TABELLA').AsString:='T430_STORICO';
                selI030.FieldByName('COLONNA').AsString:=selIA140.FieldByName('PILOTATO').AsString;
                selI030.FieldByName('DECORRENZA').AsDateTime:=DecPilota[k].IniDec;
                selI030.FieldByName('DECORRENZA_FINE').AsDateTime:=DecPilota[k].FinDec;
                selI030.FieldByName('ORDINE').AsString:=selIA140.FieldByName('ORDINE').AsString;
                selI030.FieldByName('TIPO').AsString:='S';
                selI030.FieldByName('TAB_ORIGINE').AsString:='T430_STORICO';
                selI030.Post;
                inc(RigheElaborate);
                //Estraggo i valori alla decorrenza in corso per effettuare gli abbinamenti
                selStruttura.Close;
                selStruttura.SetVariable('STRUTTURA',selIA140.FieldByName('STRUTTURA').AsString);
                selStruttura.SetVariable('DECORRENZA',DecPilota[k].IniDec);
                selStruttura.Open;
                //Svuoto il ClientDataSet degli abbinamenti
                cdsCampiRelazioni.EmptyDataSet;
                cdsCampiRelazioni.LogChanges:=False;
                while not selStruttura.Eof do
                begin
                  //Inserisco i valori abbinati nel ClientDataSet
                  cdsCampiRelazioni.Insert;
                  cdsCampiRelazioni.FieldByName('VALOREPILOTATO').AsString:=selStruttura.FieldByName('PILOTATO').AsString;
                  cdsCampiRelazioni.FieldByName('VALOREPILOTA').AsString:=selStruttura.FieldByName('PILOTA').AsString;
                  cdsCampiRelazioni.Post;
                  selStruttura.Next;
                end;
                //Creo l'SQL della relazione
                ColPilota:=selIA140.FieldByName('PILOTA').AsString;
                ComponiRelazione;
                //Inserisco le righe di dettaglio della relazione
                RiscriviSQLRelazione;
              end;
            //Salvo le relazioni al cambiamento di ogni dato pilotato
            SessioneAzienda.Commit;
            selIA140.Next;
          end;
        finally
          A136.selI030.Free;
          A136.Free;
          if Trim(selIA100.FieldByName('SCRIPT_AFTER').AsString) <> '' then
          with ScriptBeforeAfter do
          begin
            Lines.Clear;
            Lines.Text:=selIA100.FieldByName('SCRIPT_AFTER').AsString;
            Execute;
            Session.Commit;
          end;
        end;
      except
        on E:Exception do
          //RegistraLogMessaggi('    *** ' + E.Message);
          TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','    *** ' + E.Message,selI090.FieldByName('AZIENDA').AsString);
      end
      else if selIA100.FieldByName('NOME_STRUTTURA').AsString = 'X001_I030' then
      try
        //Prelevo i parametri di elaborazione
        IniFile:=TIniFile.Create('X001.ini');
        try
          // sezione impostazioni operative
          Azienda:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_AZIENDA,'AZIN');
          Struttura:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_STRUTTURA,'');
          TabColPartenza:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_TAB_COL_PARTENZA,'');
          SLRColPilota:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_SLR_COL_PILOTA,'');
          SLRColPilotata1:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_SLR_COL_PILOTATA1,'');
          SLRColPilotata2:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_SLR_COL_PILOTATA2,'');
          NumLivelli:=StrToIntDef(IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_NUM_LIVELLI,''),0);
          VersioneDB:=StrToIntDef(IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_VERSIONEDB,''),9);
        finally
          IniFile.Free;
        end;
        TabPartenza:=Copy(TabColPartenza,1,Pos('.',TabColPartenza) - 1);
        ColPartenza:=Copy(TabColPartenza,Pos('.',TabColPartenza) + 1);
        DataDa:=EncodeDate(1900,1,1);
        DataA:=EncodeDate(3999,12,31);
        //Eseguo lo script before
        if Trim(selIA100.FieldByName('SCRIPT_BEFORE').AsString) <> '' then
        with ScriptBeforeAfter do
        begin
          Lines.Clear;
          Lines.Text:=selIA100.FieldByName('SCRIPT_BEFORE').AsString;
          Execute;
          Session.Commit;
        end;
        //Gestione della tabella con le strutture dei Centri di Costo
        //Inizializzo i componenti del DataModulo
        A136:=TA136FComposizioneRelazioneMW.Create(SessioneAzienda);
        try
          A136.cdsStampa.Filter:='';
          A136.cdsStampa.Filtered:=False;
          CDSApp:=TClientDataSet.Create(nil);
          CDSApp.Name:='CDSApp';
          //Recupero le date decorrenza
          Decorrenze:=A136.RecuperaDecorrenzeStrutturaCDC(Struttura,DataDa,DataA);
          SetLength(recDecRel,0);
          while Pos(',',Decorrenze) > 0 do
          begin
            SetLength(recDecRel,length(recDecRel) + 1);
            recDecRel[High(recDecRel)].Decorrenza:=StrToDate(Copy(Decorrenze,1,Pos(',',Decorrenze) - 1));
            Decorrenze:=Copy(Decorrenze,Pos(',',Decorrenze) + 1);
          end;
          //Eseguo l'estrazione dei dati per ogni decorrenza che interseca il periodo
          for h:=0 to High(recDecRel) do
          begin
            if h = High(recDecRel) then
              DecFine:=EncodeDate(3999,12,31)
            else
              DecFine:=recDecRel[h + 1].Decorrenza - 1;
            //Sposto di livello la relazione "sorella" che deve diventare "figlia"
            A136.SpostaLivelloRelazione(TabPartenza,SLRColPilota,SLRColPilotata1,SLRColPilotata2,recDecRel[h].Decorrenza,DecFine,DecNuovaRel);
            //Creazione del clientdataset con la stampa delle relazioni
            A136.GestioneStampa('''S''',recDecRel[h].Decorrenza,DecFine,True,False,True,True,True,TabPartenza,ColPartenza,Struttura,NumLivelli,DecNuovaRel,SLRColPilotata1,SLRColPilotata2);
            //Assegno a tutti questi movimenti storici le stesse date decorrenza e scadenza
            with A136.cdsStampa do
            begin
              ReadOnly:=False;
              for j:=(FieldCount - 1) downto 0 do
                if (Pos('Decorrenza',Fields[j].FieldName) = 1) then
                begin
                  NomeCampoDecorrenza:=Fields[j].FieldName;
                  Break;
                end;
                while not Eof do
                begin
                  Edit;
                  FieldByName(NomeCampoDecorrenza).AsDateTime:=recDecRel[h].Decorrenza;
                  FieldByName('Scadenza').AsDateTime:=DecFine;
                  Post;
                  Next;
                end;
              ReadOnly:=True;
              First;
            end;
            //Carico il cds di appoggio con i dati estratti ad una certa decorrenza
            with TDataSetProvider.Create(nil) do
            try
              DataSet:=A136.cdsStampa;
              CDSApp.FieldDefs.Clear;
              CDSApp.IndexDefs.Clear;
              CDSApp.IndexName:='';
              CDSApp.AppendData(Data,True);
              CDSApp.LogChanges:=False;
            finally
              Free;
            end;
          end;
          //Riassegno tutti i dati estratti per ogni decorrenza al CDS principale
          A136.cdsStampa.EmptyDataSet;
          with TDataSetProvider.Create(nil) do
          try
            DataSet:=CDSApp;
            A136.cdsStampa.FieldDefs.Clear;
            A136.cdsStampa.IndexDefs.Clear;
            A136.cdsStampa.IndexName:='';
            A136.cdsStampa.Data:=Data;
            A136.cdsStampa.LogChanges:=False;
          finally
            Free;
            CDSApp.Free;
          end;
          //Visualizzo le colonne in base ai parametri impostati
          A136.VisualizzaColonne(True,False,True,True,True,True);
          //Sposto i campi per leggere gerarchicamente i dati da sinistra verso destra e ordino i dati
          A136.InvertiOrdineLetturaCampi;
          //Ordino per codici, descrizioni e decorrenza in vista dell'appiattimento dei record
          A136.ImpostaOrdinamento;
          A136.cdsStampa.IndexName:='INDICE1';
          //Aggiorno le decorrenze in base ai periodi di chiusura dei codici storicizzati manualmente
          A136.ChiusuraCodici;
          //Elimino i record presenti due volte (con date decorrenza diverse)
          A136.CancellaRecordDoppi;
          //Aggiorno le decorrenze in base al primo periodo storico di ogni codice
          A136.ImpostaPrimaDecorrenzaCodici;
          //Ordino per decorrenza, codici e descrizioni
          A136.cdsStampa.IndexName:='INDICE2';
          //Prelevo il tablespace dove creare la tabella X001_nomecampo_numlivelli
          selI090a:=TOracleDataSet.Create(nil);
          with selI090a do
          begin
            Session:=SessioneAzienda;
            SQL.Text:='select nvl(tsausiliario,tslavoro) tablespace from mondoedp.i090_enti t where t.azienda = ''' + Azienda + '''';
            Open;
            if RecordCount > 0 then
            begin
              TableSpace:=FieldByName('tablespace').AsString;
            end;
          end;
          FreeAndNil(selI090a);
          //Creo la tabella X001_nomecampo_numlivelli contenente i dati estratti
          A136.EstrazioneX001(TableSpace,ColPartenza,NumLivelli,VersioneDB);
          SessioneAzienda.Commit;
        finally
          A136.Free;
          if Trim(selIA100.FieldByName('SCRIPT_AFTER').AsString) <> '' then
          with ScriptBeforeAfter do
          begin
            Lines.Clear;
            Lines.Text:=selIA100.FieldByName('SCRIPT_AFTER').AsString;
            Execute;
            Session.Commit;
          end;
        end;
      except
        on E:Exception do
          TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','    *** ' + E.Message,selI090.FieldByName('AZIENDA').AsString);
      end
      else if selIA100.FieldByName('DIREZIONE_DATI').AsString = 'I' then
      begin
        if (selIA100.FieldByName('TIPO_STRUTTURA').AsString = 'F')
        and ((Pos('.XLS',UpperCase(selIA100.FieldByName('NOME_FILE').AsString)) > 0) or (Pos('.CSV',UpperCase(selIA100.FieldByName('NOME_FILE').AsString)) > 0))
        and (selIA110.RecordCount > 0) then
        begin
          (*Note per chiamate Excel da Servizio WIN32:
          Creare cartella
            C:\Windows\SysWOW64|SysWOW64\config\systemprofile\Desktop
          Give full permission to
            C:\Windows\System32|SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows folder. Hope it helps!
          *)
          //Importazione di un file Excel mappato (costi trasferte da Cisalpina)
          Ac05DM:=TAc05FImportRimborsiDM.Create(SessioneAzienda);
          try
            with Ac05DM do
            begin
              RegistraMsgAc05:=TRegistraMsg(SessioneIWB014.RegistraMsg);
              Filtro:=2;
              SoloDipendenti:=False;
              GetStrutture(selI090.FieldByName('AZIENDA').AsString);
              cdsIA100.Edit;
              cdsIA100.FieldByName('NOME_STRUTTURA').AsString:=StrutturaFissa.NomeStruttura;
              cdsIA100.FieldByName('CODICE_PAGAMENTO').AsString:='';//Viene poi impostato in ControlloParametri leggendolo da una riga di dettaglio della struttura
              cdsIA100.Post;
              selInputDati.Filtered:=True;
              try
                NomeFile:=Self.selIA100.FieldByName('NOME_FILE').AsString;
                try
                  ControlloParametri;
                except
                  on E:Exception do
                    TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','ControlloParametri.exception: ' + E.Message,selI090.FieldByName('AZIENDA').AsString);
                end;
                try
                  ImportazioneDati(Self.selIA100.FieldByName('RESET_DATI').AsString);
                except
                  on E:Exception do
                    TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','ImportazioneDati.exception: ' + E.Message,selI090.FieldByName('AZIENDA').AsString);
                end;
                ApriStruttura;
                if CollegaRimborsi then
                begin
                  Filtro:=0;
                  selInputDati.Filtered:=True;
                  SoloControllo:=False;
                  RispostaGen:=mrOk;//Usata solo da B014. Inserisce tutti i rimborsi non già esistenti.
                  RegistraRimborsi;
                  RigheElaborate:=nRimbCollegati;
                end;
              except
                on E:Exception do
                  TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','    *** ' + Format('%s - %s: %s (%s)',[Func_Name,Format('MEDP_ID n. %d',[selInputDati.FieldByName('MEDP_ID').AsInteger]),E.Message,E.ClassName]),selI090.FieldByName('AZIENDA').AsString,selInputDati.FieldByName('MEDP_PROGRESSIVO').AsInteger);
              end;
            end;
          finally
            FreeAndNil(Ac05DM);
            FileTemp:=R180NomeFileDatato(selIA100.FieldByName('NOME_FILE').AsString,'yyyymmddhhnnss',R180SysDate(SessioneAzienda));
            if FileExists(selIA100.FieldByName('NOME_FILE').AsString) then
            begin
              if not RenameFile(selIA100.FieldByName('NOME_FILE').AsString,FileTemp) then
                TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','    *** ' + 'Impossibile rinominare il file ' + selIA100.FieldByName('NOME_FILE').AsString + ' in ' + FileTemp,selI090.FieldByName('AZIENDA').AsString);
            end;
          end;
        end
        else
        begin
          //Gestione dati in input
          GetDatiStruttura(Where);
          //Reset della tabella di destinazione se richiesto
          if (selIA100.FieldByName('RESET_DATI').AsString = 'S') then
          begin
            selIA110.First;
            if (UpperCase(selIA110.FieldByName('TABELLA').AsString) <> 'T030_ANAGRAFICO') and
               (UpperCase(selIA110.FieldByName('TABELLA').AsString) <> 'T430_STORICO') then
            begin
              scrAggiornamento.SQL.Text:='delete from ' + selIA110.FieldByName('TABELLA').AsString;
              scrAggiornamento.DeleteVariables;
              scrAggiornamento.Execute;
            end;
          end;
          //Scorrimento dei dati della struttura
          ProgCorr:=0;
          while not selDatiInput.Eof do
          begin
            ElaborazioneDati;
            selDatiInput.Next;
            if AllineamentoStorici and selDatiInput.Eof then
            begin
              //Allineamento periodi storici
              scrAllineaPeriodiStorici.SetVariable('PROGRESSIVO',ProgCorr);
              scrAllineaPeriodiStorici.Execute;
            end;
          end;
          if not VarIsEmpty(delT030NoTrigger.GetVariable('PROGRESSIVO')) then
          begin
            try delT030NoTrigger.Execute; except end;
            delT030NoTrigger.ClearVariables;
            SessioneAzienda.Commit;
          end;
        end;
      end
      else
      begin
        //Gestione dati output
        EstrazioneDatiOutput;
      end;
      //RegistraLogMessaggi('    Righe elaborate: ' + IntToStr(RigheElaborate));
      TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('I','    Righe elaborate: ' + IntToStr(RigheElaborate),selI090.FieldByName('AZIENDA').AsString);
      selI090.Next;
    except
      on E:Exception do
      begin
        //RegistraLogMessaggi('    *** ' + E.Message);
        TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','    *** ' + E.Message,selI090.FieldByName('AZIENDA').AsString);
        selI090.Next;
      end;
    end;
    EliminazioneDatiElaborati;
    selIA100.Next;
  except
    on E:Exception do
    begin
      //RegistraLogMessaggi('  ' + E.Message);
      TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','  ' + E.Message,selI090.FieldByName('AZIENDA').AsString);
      //selIA100.Next;
    end;
  end;
  //Commit su SessioneLock per sbloccare la SELECT ... FOR UPDATE di selIA100
  SessioneLock.Commit;
  SessioneLock.LogOff;
  SessioneIWB014.SessioneOracle.Commit;
  //RegistraLogMessaggi('Fine Integrazione');
  //Scrittura del log sul file sequenziale B014.log
  //ScritturaFileLog;
  TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('I','Fine Integrazione');
  if StatusBar <> nil then
  begin
    StatusBar.Panels[0].Text:='';
    StatusBar.Panels[1].Text:='';
    StatusBar.Repaint;
  end;
end;

{
procedure TB014FIntegrazioneAnagraficaDtM.RegistraLogMessaggi(S:String);
// Registrazione su lista di stringhe (B014.LOG) del flusso dell'integrazione
begin
  lstLog.Add(FormatDateTime('dd/mm/yyyy hh.nn - ',Now) + S);
end;

procedure TB014FIntegrazioneAnagraficaDtM.ScritturaFileLog;
// Scrittura del log sul file sequenziale B014.log
var i:Integer;
begin
  if lstLog.Count > 0 then
    lstLog.Add('================');
  lstB014.Clear;
  try
    lstB014.LoadFromFile(FileLog);
  except
  end;
  if RigheLog > 0 then
    for i:=lstB014.Count - 1 downto (RigheLog - lstLog.Count) do
      if i >= 0 then
        lstB014.Delete(i);
  for i:=0 to lstLog.Count - 1 do
    lstB014.Insert(i,lstLog.Strings[i]);
  lstB014.SaveToFile(FileLog);
  lstB014.Clear;
end;
}

procedure TB014FIntegrazioneAnagraficaDtM.ConnessioneAzienda;
begin
  SessioneAzienda.Logoff;
  SessioneAzienda.LogonDataBase:=SessioneIWB014.SessioneOracle.LogonDataBase;
  SessioneAzienda.LogonUsername:=selI090.FieldByName('UTENTE').AsString;
  SessioneAzienda.LogonPassword:=R180Decripta(selI090.FieldByName('PAROLACHIAVE').AsString,21041974);
  SessioneAzienda.LogOn;
  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneAzienda;
    SQL.Add('ALTER SESSION SET NLS_TERRITORY = AMERICA');
    Execute;
    SQL.Clear;
    SQL.Add('ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"');
    Execute;
    SQL.Clear;
    SQL.Add('ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."');
    Execute;
  finally
    Free;
  end;
end;

procedure TB014FIntegrazioneAnagraficaDtM.GetStrutturaFissa;
{Lettura della struttura fissa e impostazione della query sulla relativa tabella}
begin
  StrutturaFissa.NomeStruttura:=selIA100.FieldByName('NOME_STRUTTURA').AsString;
  StrutturaFissa.Ente:='';
  StrutturaFissa.Sequenza:='';
  StrutturaFissa.Data:='';
  StrutturaFissa.Utente:='';
  StrutturaFissa.Chiave:='';
  StrutturaFissa.Decorrenza:='';
  StrutturaFissa.Scadenza:='';
  StrutturaFissa.Dato:='';
  StrutturaFissa.Valore:='';
  if selIA110.SearchRecord('INTESTAZIONE','ENTE',[srFromBeginning]) then
    StrutturaFissa.Ente:=selIA110.FieldByName('NOME_DATO').AsString;
  if selIA110.SearchRecord('INTESTAZIONE','SEQUENZA',[srFromBeginning]) then
    StrutturaFissa.Sequenza:=selIA110.FieldByName('NOME_DATO').AsString;
  if selIA110.SearchRecord('INTESTAZIONE','DATA',[srFromBeginning]) then
    StrutturaFissa.Data:=selIA110.FieldByName('NOME_DATO').AsString;
  if selIA110.SearchRecord('INTESTAZIONE','UTENTE',[srFromBeginning]) then
    StrutturaFissa.Utente:=selIA110.FieldByName('NOME_DATO').AsString;
  if selIA110.SearchRecord('INTESTAZIONE','CHIAVE',[srFromBeginning]) then
    repeat
      if StrutturaFissa.Chiave <> '' then
        StrutturaFissa.Chiave:=StrutturaFissa.Chiave + ',';
      StrutturaFissa.Chiave:=StrutturaFissa.Chiave + selIA110.FieldByName('NOME_DATO').AsString;
    until not selIA110.SearchRecord('INTESTAZIONE','CHIAVE',[]);
  if selIA110.SearchRecord('INTESTAZIONE','DECORRENZA',[srFromBeginning]) then
    StrutturaFissa.Decorrenza:=selIA110.FieldByName('NOME_DATO').AsString;
  if selIA110.SearchRecord('INTESTAZIONE','SCADENZA',[srFromBeginning]) then
    StrutturaFissa.Scadenza:=selIA110.FieldByName('NOME_DATO').AsString;
  if selIA110.SearchRecord('INTESTAZIONE','DATO',[srFromBeginning]) then
    StrutturaFissa.Dato:=selIA110.FieldByName('NOME_DATO').AsString;
  if selIA110.SearchRecord('INTESTAZIONE','VALORE',[srFromBeginning]) then
    StrutturaFissa.Valore:=selIA110.FieldByName('NOME_DATO').AsString;
  if (StrutturaFissa.Dato = '') or (StrutturaFissa.Valore = '') then
  begin
    StrutturaFissa.Dato:='';
    StrutturaFissa.Valore:='';
  end;
  if selIA100.FieldByName('TIPO_STRUTTURA').AsString = 'T' then
  begin
    ScriptInserimentoOutput;
  end;
end;

procedure TB014FIntegrazioneAnagraficaDtM.GetDatiStruttura(Where:String);
var OrderBy:String;
begin
  OrderBy:='';
  if StrutturaFissa.Sequenza <> '' then
    OrderBy:=OrderBy + StrutturaFissa.Sequenza;
  if StrutturaFissa.Data <> '' then
  begin
    if OrderBy <> '' then
      OrderBy:=OrderBy + ',';
    OrderBy:=OrderBy + StrutturaFissa.Data;
  end;
  if StrutturaFissa.Chiave <> '' then
  begin
    if OrderBy <> '' then
      OrderBy:=OrderBy + ',';
    OrderBy:=OrderBy + StrutturaFissa.Chiave;
  end;
  if StrutturaFissa.Decorrenza <> '' then
  begin
    if OrderBy <> '' then
      OrderBy:=OrderBy + ',';
    OrderBy:=OrderBy + StrutturaFissa.Decorrenza;
  end;
  //Query di lettura dei dati
  with selDatiInput do
  begin
    SQL.Clear;
    SQL.Add('SELECT T.*,ROWID FROM ' + StrutturaFissa.NomeStruttura + ' T');
    //Filtro sull'azienda corrente
    if (StrutturaFissa.Ente <> '') and (selI090.FieldByName('CODICE_INTEGRAZIONE').AsString <> '*') then
      SQL.Add(Format('WHERE NVL(%s,''*'') IN (''%s'',''*'')',[StrutturaFissa.Ente,selI090.FieldByName('CODICE_INTEGRAZIONE').AsString]));
    if Trim(Where) <> '' then
      if (StrutturaFissa.Ente <> '') and (selI090.FieldByName('CODICE_INTEGRAZIONE').AsString <> '*') then
        SQL.Add('AND (' + Where + ')')
      else
        SQL.Add('WHERE (' + Where + ')');
    //Ordinamento
    if OrderBy <> '' then
      SQL.Add('ORDER BY ' + OrderBy);
    Close;
    try
      Open;
    except
      //Se la struttura non supporta il rowid lo si ignora
      SQL[0]:=StringReplace(SQL[0],',ROWID','',[rfIgnoreCase]);
      Open;
    end;
  end;
end;

procedure TB014FIntegrazioneAnagraficaDtM.ImportazioneFile;
var NomeFile,FileTemp:String;
begin
  //Rinomina del file originale e copia nella cartella Archivi\Temp
  NomeFile:=R180EstraiNomeFile(selIA100.FieldByName('NOME_FILE').AsString);
  FileTemp:=ExtractFilePath(Application.Exename) + 'Archivi\Temp\' + NomeFile;
  if StatusBar <> nil then
  begin
    StatusBar.Panels[1].Text:='Copia del file ' + selIA100.FieldByName('NOME_FILE').AsString;
    StatusBar.Repaint;
    Application.ProcessMessages;
  end;
  if selIA100.FieldByName('FTP_HOST').IsNull then
  //Percorso in rete locale
  begin
    if not FileExists(selIA100.FieldByName('NOME_FILE').AsString) then
      //RegistraLogMessaggi('  File non esistente: ' + selIA100.FieldByName('NOME_FILE').AsString)
      TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','  File non esistente: ' + selIA100.FieldByName('NOME_FILE').AsString)
    else if not RenameFile(selIA100.FieldByName('NOME_FILE').AsString,FileTemp) then
      //RegistraLogMessaggi('  Impossibile rinominare il file ' + selIA100.FieldByName('NOME_FILE').AsString + ' in ' + FileTemp);
      TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','  Impossibile rinominare il file ' + selIA100.FieldByName('NOME_FILE').AsString + ' in ' + FileTemp);
  end
  else
  //File su Host FTP
  try
    if IdFTP.Connected then
      IdFTP.Disconnect;
    IdFTP.Host:=selIA100.FieldByName('FTP_HOST').AsString;
    if selIA100.FieldByName('FTP_PORT').IsNull then
      IdFTP.Port:=21
    else
      IdFTP.Port:=selIA100.FieldByName('FTP_PORT').AsInteger;
    IdFTP.Username:=selIA100.FieldByName('FTP_USER').AsString;
    IdFTP.Password:=selIA100.FieldByName('FTP_PASSWORD').AsString;
    IdFTP.Connect;
    if R180EstraiPercorsoFile(selIA100.FieldByName('NOME_FILE').AsString) <> '' then
      IdFTP.ChangeDir(R180EstraiPercorsoFile(selIA100.FieldByName('NOME_FILE').AsString));
    IdFTP.Rename(NomeFile,'MEDP' + NomeFile);
    IdFTP.Get('MEDP' + NomeFile,FileTemp,True);
    //IdFTP.Rename('MEDP' + NomeFile,'MEDP' + FormatDateTime('ddmmyyyyhhnn',Now) + NomeFile);
    IdFTP.Delete('MEDP' + NomeFile);
    IdFTP.Disconnect;
  except
    on E:Exception do
    begin
      //RegistraLogMessaggi('  ' + E.Message);
      TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','  ' + E.Message);
      try IdFTP.Disconnect; except end;
    end;
  end;
  try
    MigrazioneFileSuTabella(FileTemp);
  except
    on E:Exception do
      //RegistraLogMessaggi('  ' + E.Message);
      TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','  ' + E.Message);
  end;
  if not DeleteFile(FileTemp) then
    //RegistraLogMessaggi('  Impossibile cancellare il file ' + FileTemp);
    TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','  Impossibile cancellare il file ' + FileTemp);
end;

procedure TB014FIntegrazioneAnagraficaDtM.MigrazioneFileSuTabella(NomeFile:String);
{- Lettura della struttura del file
 - Creazione della tabella Oralce corrispondente
 - Caricamento dei dati da file a memoria (DatiFile)
 - Caricamento dei dati da memoria a tabella oracle}
var Riga,Colonne,CInsert,CValues,NomeSeq:String;
    SeqAuto:Integer;
    F:TextFile;
begin
  if StatusBar <> nil then
  begin
    StatusBar.Panels[1].Text:='Importazione del file ' + NomeFile + ' nella tabella ' + selIA100.FieldByName('NOME_STRUTTURA').AsString;
    StatusBar.Repaint;
    Application.ProcessMessages;
  end;
  Colonne:='';
  CInsert:='';
  CValues:='';
  NomeSeq:='';
  insDatiInput.DeleteVariables;
  with selIA110NomeDato do
  begin
    SetVariable('NOME_STRUTTURA',selIA100.FieldByName('NOME_STRUTTURA').AsString);
    Close;
    Open;
    while not Eof do
    begin
      if Colonne <> '' then
      begin
        Colonne:=Colonne + ',';
        CInsert:=CInsert + ',';
        CValues:=CValues + ',';
      end;
      Colonne:=Colonne + Format('%s VARCHAR2(%d)',[FieldByName('NOME_DATO').AsString,FieldByName('LUNG_DATO').AsInteger]);
      CInsert:=CInsert + FieldByName('NOME_DATO').AsString;
      CValues:=CValues + ':' + FieldByName('NOME_DATO').AsString;
      insDatiInput.DeclareVariable(FieldByName('NOME_DATO').AsString,otString);
      Next;
    end;
  end;
  //Script di creazione della tabella
  crtDatiInput.SQL.Clear;
  crtDatiInput.SQL.Add('CREATE TABLE ' + selIA100.FieldByName('NOME_STRUTTURA').AsString);
  crtDatiInput.SQL.Add('(' + Colonne + ')');
  crtDatiInput.SQL.Add('TABLESPACE ' + SessioneIWB014.Parametri.TSAusiliario);
  crtDatiInput.SQL.Add('PCTFREE 10 PCTUSED 80 STORAGE (INITIAL 256K NEXT 1M PCTINCREASE 0) NOPARALLEL');
  try
    crtDatiInput.Execute;
  except
    on E:Exception do
  end;
  //Script di caricamento della tabella
  insDatiInput.SQL.Clear;
  insDatiInput.SQL.Add('INSERT INTO ' + selIA100.FieldByName('NOME_STRUTTURA').AsString);
  insDatiInput.SQL.Add('(' + CInsert + ')');
  insDatiInput.SQL.Add('VALUES (' + CValues + ')');
  //Caricamento dei dati da file in memoria
  //Verifica se è richiesta la sequenza automatica
  SeqAuto:=-1;
  if (StrToIntDef(VarToStr(selIA110NomeDato.Lookup('INTESTAZIONE','SEQUENZA','POS_DATO')),0) = 0) and
     (StrToIntDef(VarToStr(selIA110NomeDato.Lookup('INTESTAZIONE','SEQUENZA','LUNG_DATO')),0) > 0) then
  with TOracleQuery.Create(nil) do
  try
    NomeSeq:=VarToStr(selIA110NomeDato.Lookup('INTESTAZIONE','SEQUENZA','NOME_DATO'));
    SeqAuto:=0;
    Session:=SessioneIWB014.SessioneOracle;
    SQL.Clear;
    SQL.Add(Format('SELECT NVL(MAX(TO_NUMBER(%s)),0) FROM %s',[NomeSeq,selIA100.FieldByName('NOME_STRUTTURA').AsString]));
    Execute;
    SeqAuto:=FieldAsInteger(0) + 1;
  finally
    Free;
  end;
  AssignFile(F,NomeFile);
  Reset(F);
  while not Eof(F) do
  begin
    Readln(F,Riga);
    selIA110NomeDato.First;
    while not selIA110NomeDato.Eof do
    begin
      //Gestione sequenza automatica
      if (SeqAuto >= 0) and (selIA110NomeDato.FieldByName('INTESTAZIONE').AsString = 'SEQUENZA') then
      begin
        insDatiInput.SetVariable(selIA110NomeDato.FieldByName('NOME_DATO').AsString,StringReplace(Format('%*d',[selIA110NomeDato.FieldByName('LUNG_DATO').AsInteger,SeqAuto]),' ','0',[rfReplaceAll]));
        inc(SeqAuto);
      end
      else
        insDatiInput.SetVariable(selIA110NomeDato.FieldByName('NOME_DATO').AsString,Copy(Riga,selIA110NomeDato.FieldByName('POS_DATO').AsInteger,selIA110NomeDato.FieldByName('LUNG_DATO').AsInteger));
      selIA110NomeDato.Next;
    end;
    try
      insDatiInput.Execute;
    except
      on E:Exception do
    end;
  end;
  CloseFile(F);
  SessioneIWB014.SessioneOracle.Commit;
end;

procedure TB014FIntegrazioneAnagraficaDtM.ElaborazioneDati;
{Elaborazione della singola riga}
var Dato,Valore:String;
begin
  inc(RigheElaborate);
  if StatusBar <> nil then
  begin
    StatusBar.Panels[1].Text:=Format('Righe elaborate: %d/%d',[RigheElaborate,selDatiInput.RecordCount]);
    StatusBar.Repaint;
    Application.ProcessMessages;
  end;
  AllineamentoStorici:=False;
  if Trim(selIA100.FieldByName('SCRIPT_BEFORE').AsString) <> '' then
  with ScriptBeforeAfter do
  begin
    Lines.Clear;
    Lines.Text:=selIA100.FieldByName('SCRIPT_BEFORE').AsString;
    Execute;
    Session.Commit;
  end;
  if StrutturaFissa.Dato <> '' then
  //Un dato per ogni riga
  begin
    Dato:=Trim(selDatiInput.FieldByName(StrutturaFissa.Dato).AsString);
    Valore:=selDatiInput.FieldByName(StrutturaFissa.Valore).AsString;
    if not selIA110.SearchRecord('NOME_DATO',Dato,[srFromBeginning]) then
    begin
      RegistraLog(Dato,Valore,'E','Dato inesistente','');
      exit;
    end;
    DaStoricizzare:=True;
    AggiornamentoDato(Dato,Valore);
  end
  else
  //Riga con più dati
  begin
    //Inizializzazione procedura di storicizzazione eventuale
    //scrCreazioneStorico, GeneraStorici devono essere fatti solo una volta per riga
    DaStoricizzare:=True;
    selIA110.First;
    while not selIA110.Eof do
    begin
      //Scorrimento dei soli dati significativi, ignorando l'intestazione
      if selIA110.FieldByName('INTESTAZIONE').AsString = '' then
      begin
        Dato:=Trim(selIA110.FieldByName('NOME_DATO').AsString);
        Valore:=selDatiInput.FieldByName(Dato).AsString;
        AggiornamentoDato(Dato,Valore);
      end;
      selIA110.Next;
    end;
  end;

  if selIA100.FieldByName('B014PERSONALIZZATA').AsString = 'S' then
  //Gestione personalizzata con procedura Oracle
  try
    scrB014Personalizzata.ClearVariables;
    scrB014Personalizzata.SetVariable('P',ProgCorr);
    scrB014Personalizzata.SetVariable('DAL',DecorrenzaCorr);
    scrB014Personalizzata.SetVariable('DATO',Dato);
    scrB014Personalizzata.SetVariable('VALORE',ValoreCorr);
    if StrutturaFissa.Sequenza <> '' then
      scrB014Personalizzata.SetVariable('SEQUENZA',selDatiInput.FieldByName(StrutturaFissa.Sequenza).AsString);
    scrB014Personalizzata.SetVariable('STRUTTURA',StrutturaFissa.NomeStruttura);
    scrB014Personalizzata.SetVariable('ROWID_RIGA',selDatiInput.RowID);
    scrB014Personalizzata.Execute;
  except
  end;
  if Trim(selIA100.FieldByName('SCRIPT_AFTER').AsString) <> '' then
  with ScriptBeforeAfter do
  begin
    Lines.Clear;
    Lines.Text:=selIA100.FieldByName('SCRIPT_AFTER').AsString;
    Execute;
    Session.Commit;
  end;
  (*if AllineamentoStorici then
  begin
    //Allineamento periodi storici
    scrAllineaPeriodiStorici.SetVariable('PROGRESSIVO',ProgCorr);
    scrAllineaPeriodiStorici.Execute;
  end;*)
  SessioneAzienda.Commit;
  //Cancellazione del dato appena gestito, se riferito ad un'azienda specifica
  if selIA100.FieldByName('CANCELLAZIONE').AsString = 'S' then
    if (selI090.RecordCount = 1) or
       ((StrutturaFissa.Ente <> '') and
        (not selDatiInput.FieldByName(StrutturaFissa.Ente).IsNull) and
        (selDatiInput.FieldByName(StrutturaFissa.Ente).AsString <> '*')) then
    try
      if selDatiInput.RowId <> '' then
      begin
        delDatiInput.SetVariable('TABELLA',selIA100.FieldByName('NOME_STRUTTURA').AsString);
        delDatiInput.SetVariable('MYROWID',selDatiInput.RowId);
        delDatiInput.Execute;
      end;
    except
    end
    else
    //Registrazione del ROWID per cancellazione successiva
    begin
      if selDatiInput.RowId <> '' then
        lstROWID.Add(selDatiInput.RowId);
    end;
  SessioneIWB014.SessioneOracle.Commit;
end;

procedure TB014FIntegrazioneAnagraficaDtM.AggiornamentoDato(Dato,Valore:String);
{selIA110 è già posizionato sul dato corretto}
var CampoChiave,Chiave,ChiaveUpd,ChiaveInsCol,ChiaveInsVal,Storicizzazione,Stato,S:String;
    ColDecorrenza,ColDecorrenzaFine:String;
    NameColSize:String;
    Dal,Al,dIstante:TDateTime;
    i:Integer;
  procedure DuplicaRecordTabStorica;
  var AV:array of Variant;
      i:Integer;
  begin
    with selTabStorica do
    begin
      SetLength(AV,FieldCount);
      for i:=0 to FieldCount - 1 do
        AV[i]:=Fields[i].Value;
      Append;
      for i:=0 to FieldCount - 1 do
        Fields[i].Value:=AV[i];
    end;
  end;
  procedure GeneraStorici;
  var DDec,DScad:TDateTime;
  begin
    DDEc:=0;
    DScad:=0;
    with selTabStorica do
    begin
      SetVariable('TABELLA',selIA110.FieldByName('TABELLA').AsString);
      SetVariable('CHIAVE',ChiaveUpd);
      SetVariable('DECORRENZA',ColDecorrenza);
      Close;
      Open;
      if (StrutturaFissa.Scadenza = '') then
      begin
        //Gestione della sola data di decorrenza:
        //Si duplica il record più prossimo indicando la nuova decorrenza
        while not Eof do
        begin
          if (FieldByName(ColDecorrenza).AsDateTime <= Dal) or (DDec = 0) then
            DDec:=FieldByName(ColDecorrenza).AsDateTime;
          if FieldByName(ColDecorrenza).AsDateTime > Dal then
            Break;
          Next;
        end;
        if DDec <> Dal then
        begin
          if (DDec > 0) and (SearchRecord(ColDecorrenza,DDec,[srFromBeginning])) then
          begin
            DuplicaRecordTabStorica;
            FieldByName(ColDecorrenza).AsDateTime:=Dal;
            Post;
          end;
        end;
        exit;
      end
      else
      begin
        //Gestione del periodo decorrenza..scadenza
        //Si spezza il record che interseca la decorrenza
        while not Eof do
        begin
          if R180Between(Dal,FieldByName(ColDecorrenza).AsDateTime,FieldByName(ColDecorrenzaFine).AsDateTime) then
          begin
            DDec:=FieldByName(ColDecorrenza).AsDateTime;
            DScad:=FieldByName(ColDecorrenzaFine).AsDateTime;
            Break;
          end;
          Next;
        end;
        if (DDec > 0) and (DDec < Dal) then
        begin
          Edit;
          FieldByName(ColDecorrenzaFine).AsDateTime:=Dal - 1;
          Post;
          DuplicaRecordTabStorica;
          FieldByName(ColDecorrenza).AsDateTime:=Dal;
          FieldByName(ColDecorrenzaFine).AsDateTime:=DScad;
          Post;
          Refresh;
        end
        else if DDec = 0 then
        begin
          //Se non trovo un record che contiene la decorrenza, cerco il primo in cui decorrenza è contenuta in dal..al e lo estendo retrocedento la decorrenza
          First;
          while not Eof do
          begin
            if R180Between(FieldByName(ColDecorrenza).AsDateTime,Dal,Al) then
            begin
              DDec:=FieldByName(ColDecorrenza).AsDateTime;
              Break;
            end;
            Next;
          end;
          if DDec > 0 then
          begin
            Edit;
            FieldByName(ColDecorrenza).AsDateTime:=Dal;
            Post;
          end;
        end;
        DDec:=0;
        DScad:=0;
        //Si spezza il record che interseca la scadenza
        while not Eof do
        begin
          //if (FieldByName(ColDecorrenza).AsDateTime <= Dal) or (DDec = 0) then
          if R180Between(Al,FieldByName(ColDecorrenza).AsDateTime,FieldByName(ColDecorrenzaFine).AsDateTime) then
          begin
            DDec:=FieldByName(ColDecorrenza).AsDateTime;
            DScad:=FieldByName(ColDecorrenzaFine).AsDateTime;
            Break;
          end;
          Next;
        end;
        if (DDec > 0) and (DScad > Al) then
        begin
          Edit;
          FieldByName(ColDecorrenzaFine).AsDateTime:=Al;
          Post;
          DuplicaRecordTabStorica;
          FieldByName(ColDecorrenza).AsDateTime:=Al + 1;
          FieldByName(ColDecorrenzaFine).AsDateTime:=DScad;
          Post;
          Refresh;
        end
        else if DDec = 0 then
        begin
          //Se non trovo un record che contiene la scadenza, cerco l'ultimo record in cui scadenza è contenuta in dal..al e lo estendo posticipando la scadenza
          Last;
          while not Bof do
          begin
            if R180Between(FieldByName(ColDecorrenzaFine).AsDateTime,Dal,Al) then
            begin
              DDec:=FieldByName(ColDecorrenza).AsDateTime;
              Break;
            end;
            Prior;
          end;
          if DDec > 0 then
          begin
            Edit;
            FieldByName(ColDecorrenzaFine).AsDateTime:=Al;
            Post;
          end;
        end;
      end;
    end;
  end;
begin
  CampoChiave:=VarToStr(selIA110.Lookup('INTESTAZIONE','CHIAVE','CAMPO'));
  ChiaveUpd:='';
  ChiaveInsCol:='';
  ChiaveInsVal:='';
  if CampoChiave <> '' then
    with TStringList.Create do
    try
      CommaText:=StrutturaFissa.Chiave;
      for i:=0 to Count - 1 do
      begin
        if Trim(Strings[i]) = '' then
          Continue;
        ChiaveUpd:=ChiaveUpd + VarToStr(selIA110.Lookup('NOME_DATO',Strings[i],'CAMPO')) + '=''' + Trim(selDatiInput.FieldByName(Strings[i]).AsString) + '''';
        ChiaveInsCol:=ChiaveInsCol + VarToStr(selIA110.Lookup('NOME_DATO',Strings[i],'CAMPO'));
        ChiaveInsVal:=ChiaveInsVal + '''' + Trim(selDatiInput.FieldByName(Strings[i]).AsString) + '''';
        if i < Count - 1 then
        begin
          ChiaveUpd:=ChiaveUpd + ' AND ';
          ChiaveInsCol:=ChiaveInsCol + ',';
          ChiaveInsVal:=ChiaveInsVal + ',';
        end;
      end;
    finally
      Free;
    end;
  if (Pos(',',StrutturaFissa.Chiave) = 0) or
     (selIA110.FieldByName('TABELLA').AsString = 'T030_ANAGRAFICO') or
     (selIA110.FieldByName('TABELLA').AsString = 'T430_STORICO') then
    Chiave:=Trim(selDatiInput.FieldByName(StrutturaFissa.Chiave).AsString);
  Storicizzazione:='';
  scrAggiornamento.SQL.Clear;
  scrAggiornamento.DeleteVariables;
  Stato:='M';
  //Gestione di VALORE
  try
    //Conversione eventuale della chiave in valore numerico (serve solo per T030+T430)
    if (Pos(',',StrutturaFissa.Chiave) = 0) and
       (VarToStr(selIA110.Lookup('INTESTAZIONE','CHIAVE','TIPO_DATO')) = 'N') then
      Chiave:=FloatToStr(StrToFloat(Chiave));
    Valore:=Trim(Valore);
    //Riconoscimento del valore nullo se tipo Data
    if (selIA110.FieldByName('TIPO_DATO').AsString) = 'D' then
    try
      Valore:=DateToStr(R180StrToDateFmt(Valore,selIA110.FieldByName('FMT_DATA').AsString));
    except
      Valore:='';
    end;
    //Conversione eventuale del valore in numerico
    if selIA110.FieldByName('TIPO_DATO').AsString = 'N' then
      Valore:=FloatToStr(StrToFloat(Valore));
    //Limitazione della dimensione in base al numero di caratteri
    //if (selIA110.FieldByName('TIPO_DATO').AsString = 'A') and (not selIA110.FieldByName('DATA_LENGTH').IsNull) then
    if selIA110.FieldByName('TIPO_DATO').AsString = 'A' then
    begin
      NameColSize:=UpperCase(selCols.Session.LogonUsername + '.' + selIA110.FieldByName('TABELLA').AsString + '.' + selIA110.FieldByName('CAMPO').AsString);
      if lstColSize.IndexOfName(NameColSize) = -1 then
      begin
        selCols.SetVariable('TABELLA',selIA110.FieldByName('TABELLA').AsString);
        selCols.SetVariable('COLONNA',selIA110.FieldByName('CAMPO').AsString);
        selCols.Close;
        selCols.Open;
        lstColSize.Add(NameColSize + '=' + selCols.FieldByName('DATA_LENGTH').AsString);
        (*if not selCols.FieldByName('DATA_LENGTH').IsNull then
          Valore:=Copy(Valore,1,selCols.FieldByName('DATA_LENGTH').AsInteger);*)
        selCols.Close;
      end;
      Valore:=Copy(Valore,1,StrToIntDef(lstColSize.Values[NameColSize],9999));
    end;
    Valore:=AggiungiApice(Valore);
  except
    on E:Exception do
    begin
      RegistraLog(Dato,Valore,'E',E.Message,'');
      exit;
    end;
  end;
  Dal:=0;
  Al:=0;
  try
    (*if Trim(selIA100.FieldByName('SCRIPT_BEFORE').AsString) <> '' then
      with ScriptBeforeAfter do
      begin
        Lines.Clear;
        Lines.Text:=selIA100.FieldByName('SCRIPT_BEFORE').AsString;
        Execute;
      end;*)
    if (selIA110.FieldByName('TABELLA').AsString = 'T030_ANAGRAFICO') or
       (selIA110.FieldByName('TABELLA').AsString = 'T430_STORICO') then
    //Dati anagrafici
    begin
      //Verifica se nuova matricola, creazione T430_STORICO al 31/12/3999
      if Chiave <> VarToStr(insT030.GetVariable('MATRICOLA')) then
      begin
        if ProgCorr > 0 then
        begin
          scrAllineaPeriodiStorici.SetVariable('PROGRESSIVO',ProgCorr);
          scrAllineaPeriodiStorici.Execute;
        end;
        insT030.SetVariable('MATRICOLA',Chiave);
        insT030.Execute;
      end;
      ProgCorr:=insT030.GetVariable('PROGRESSIVO');
      Stato:=insT030.GetVariable('STATO');
      //Se il dato è storico chiamata alla  proc. Creazione_Storico
      if (selIA110.FieldByName('TABELLA').AsString = 'T430_STORICO') and
         (selIA110.FieldByName('STORICO').AsString = 'S') and
         (StrutturaFissa.Decorrenza <> '') (*and (StrutturaFissa.Scadenza <> '')*) then
      begin
        if not selDatiInput.FieldByName(StrutturaFissa.Decorrenza).IsNull then
        try
          Dal:=R180StrToDateFmt(selDatiInput.FieldByName(StrutturaFissa.Decorrenza).AsString,VarToStr(selIA110.Lookup('INTESTAZIONE','DECORRENZA','FMT_DATA')));
        except
        end;
        if (StrutturaFissa.Scadenza <> '') and (not selDatiInput.FieldByName(StrutturaFissa.Scadenza).IsNull) then
        try
          Al:=R180StrToDateFmt(selDatiInput.FieldByName(StrutturaFissa.Scadenza).AsString,VarToStr(selIA110.Lookup('INTESTAZIONE','SCADENZA','FMT_DATA')));
        except
        end;
        scrCreazioneStorico.ClearVariables;
        if Dal > 0 then
        begin
          scrCreazioneStorico.SetVariable('PROGRESSIVO',ProgCorr);
          scrCreazioneStorico.SetVariable('DAL',Dal);
          if (Al > 0) and (Al < EncodeDate(3999,12,31)) then
            scrCreazioneStorico.SetVariable('AL',Al);
          //Se il dato è Virtuale non si esegue l'operazione
          if DaStoricizzare and (selIA110.FieldByName('VIRTUALE').AsString = 'N') then
          begin
            scrCreazioneStorico.Execute;
            DaStoricizzare:=False;
          end;
          Storicizzazione:=':DAL <= DATAFINE AND :AL >= DATADECORRENZA';
          scrAggiornamento.DeclareVariable('DAL',otDate);
          scrAggiornamento.DeclareVariable('AL',otDate);
          scrAggiornamento.SetVariable('DAL',Dal);
          if Al = 0 then
            scrAggiornamento.SetVariable('AL',EncodeDate(3999,12,31))
          else
            scrAggiornamento.SetVariable('AL',Al);
        end;
      end;
      //Riconoscimento del dato storico
      if (selIA110.FieldByName('TABELLA').AsString = 'T430_STORICO') then
      begin
        DecorrenzaCorr:=Dal;
        AllineamentoStorici:=True;
        CampoChiave:='PROGRESSIVO';
        Chiave:=IntToStr(ProgCorr);
      end;
    end
    else
    //Dati non Anagrafici
    begin
      ColDecorrenza:=VarToStr(selIA110.Lookup('INTESTAZIONE','DECORRENZA','CAMPO'));
      try
        Dal:=R180StrToDateFmt(selDatiInput.FieldByName(StrutturaFissa.Decorrenza).AsString,VarToStr(selIA110.Lookup('INTESTAZIONE','DECORRENZA','FMT_DATA')));
      except
      end;
      if StrutturaFissa.Scadenza <> '' then
      begin
        ColDecorrenzaFine:=VarToStr(selIA110.Lookup('INTESTAZIONE','SCADENZA','CAMPO'));
        try
          if selDatiInput.FieldByName(StrutturaFissa.Scadenza).IsNull then
            Al:=Encodedate(3999,12,31)
          else
            Al:=R180StrToDateFmt(selDatiInput.FieldByName(StrutturaFissa.Scadenza).AsString,VarToStr(selIA110.Lookup('INTESTAZIONE','SCADENZA','FMT_DATA')));
        except
        end;
      end;
      //Gestione della storicizzazione: i periodi storici esistenti vengono 'allargati' in modo da coprire il periodo DAL..AL che si sta elaborando
      if (selIA110.FieldByName('STORICO').AsString = 'S') and (StrutturaFissa.Decorrenza <> '') then
      begin
        scrAggiornamento.DeclareVariable('DAL',otDate);
        scrAggiornamento.SetVariable('DAL',Dal);
        Storicizzazione:=ColDecorrenza + ' >= :DAL';
        if StrutturaFissa.Scadenza <> '' then
        begin
          scrAggiornamento.DeclareVariable('AL',otDate);
          scrAggiornamento.SetVariable('AL',Al);
          Storicizzazione:=':DAL <= ' + ColDecorrenzaFine + ' AND NVL(:AL,TO_DATE(''31123999'',''DDMMYYYY'')) >= ' + ColDecorrenza;
        end;
        if DaStoricizzare then
        begin
          GeneraStorici;
          DaStoricizzare:=False;
        end;
      end;
    end;
    ValoreCorr:=Valore;
    //Update del dato
    if Valore = '' then
      Valore:='NULL'
    else
      Valore:='''' + Valore + '''';
    scrAggiornamento.SQL.Clear;
    scrAggiornamento.SQL.Add(Format('UPDATE %s SET %s = %s',[selIA110.FieldByName('TABELLA').AsString,selIA110.FieldByName('CAMPO').AsString,Valore]));
    if (CampoChiave <> '') or (Storicizzazione <> '') then
    begin
      scrAggiornamento.SQL.Add('WHERE');
      //Fitro sulla chiave (Matricola/Progressivo/Codice)
      if CampoChiave <> '' then
      begin
        if ((selIA110.FieldByName('TABELLA').AsString = 'T030_ANAGRAFICO') or (selIA110.FieldByName('TABELLA').AsString = 'T430_STORICO')) and
           (Trim(CampoChiave) <> '') and (Trim(Chiave) <> '') then
          scrAggiornamento.SQL.Add(Format('%s = ''%s''',[CampoChiave,Chiave]))
        else
          scrAggiornamento.SQL.Add(ChiaveUpd);
      end;
      if Storicizzazione <> '' then
      begin
        if CampoChiave <> '' then
          Storicizzazione:=' AND ' + Storicizzazione;
        scrAggiornamento.SQL.Add(Storicizzazione);
      end;
    end;
    //Se il dato è Virtuale non si esegue l'operazione
    if selIA110.FieldByName('VIRTUALE').AsString = 'N' then
    begin
      if (VarIsEmpty(insT030NoTrigger.GetVariable('PROGRESSIVO')) or (ProgCorr <> insT030NoTrigger.GetVariable('PROGRESSIVO'))) and
         R180In(selIA110.FieldByName('TABELLA').AsString,['T030_ANAGRAFICO','T430_STORICO']) then
      begin
        if not VarIsEmpty(delT030NoTrigger.GetVariable('PROGRESSIVO')) then
          try delT030NoTrigger.Execute; except end;
        dIstante:=Now;
        insT030NoTrigger.SetVariable('PROGRESSIVO',ProgCorr);
        insT030NoTrigger.SetVariable('dISTANTE',dIstante);
        delT030NoTrigger.SetVariable('PROGRESSIVO',ProgCorr);
        delT030NoTrigger.SetVariable('dISTANTE',dIstante);
        try insT030NoTrigger.Execute; except end;
      end;
      scrAggiornamento.Execute;
    end;
    //Inserimento di un nuovo dato
    if (scrAggiornamento.RowsProcessed = 0) and (selIA110.FieldByName('TABELLA').AsString <> 'T030_ANAGRAFICO') and (selIA110.FieldByName('TABELLA').AsString <> 'T430_STORICO') then
    begin
      scrAggiornamento.DeleteVariables;
      scrAggiornamento.SQL.Clear;
      scrAggiornamento.SQL.Add('INSERT INTO ' + selIA110.FieldByName('TABELLA').AsString);

      S:=ChiaveInsCol;
      if ColDecorrenza <> '' then
        S:=S + IfThen(S <> '',',') + ColDecorrenza;
      if ColDecorrenzaFine <> '' then
        S:=S + IfThen(S <> '',',') + ColDecorrenzaFine;
      S:=S + IfThen(S <> '',',') + selIA110.FieldByName('CAMPO').AsString;
      scrAggiornamento.SQL.Add(Format('(%s)',[S]));
      scrAggiornamento.SQL.Add('VALUES');
      S:=ChiaveInsVal;
      if ColDecorrenza <> '' then
        S:=S + IfThen(S <> '',',') + '''' + DateToStr(Dal) + '''';
      if ColDecorrenzaFine <> '' then
        S:=S + IfThen(S <> '',',') + '''' + DateToStr(Al) + '''';
      S:=S + IfThen(S <> '',',') + Valore;
      scrAggiornamento.SQL.Add(Format('(%s)',[S]));
      //Se il dato è Virtuale non si esegue l'operazione
      if selIA110.FieldByName('VIRTUALE').AsString = 'N' then
        scrAggiornamento.Execute;
      RegistraLog(Dato,Valore,'I','','');
    end
    else
      RegistraLog(Dato,Valore,Stato,'','');
  except
    on E:Exception do
    begin
      RegistraLog(Dato,Valore,'E',E.Message,scrAggiornamento.SQL.Text);
      //exit;
    end;
  end;
end;

procedure TB014FIntegrazioneAnagraficaDtM.RegistraLog(Dato,Valore,Stato,Messaggio,TestoSQL:String);
{Registrazione dei log su tabella oracle IA000_LOGINTEGRAZIONE}
begin
  if (Stato = 'E') and (selIA100.FieldByName('LOG_ERRORE').AsString = 'N') then
    exit;
  if (Stato <> 'E') and (selIA100.FieldByName('LOG_ESEGUITO').AsString = 'N') then
    exit;
  with insIA000 do
  try
    ClearVariables;
    SetVariable('DATA_ELABORAZIONE',Now);
    SetVariable('STRUTTURA',selIA100.FieldByName('NOME_STRUTTURA').AsString);
    SetVariable('AZIENDA',selI090.FieldByName('AZIENDA').AsString);
    SetVariable('STATO',Stato);
    SetVariable('DATO',Dato);
    SetVariable('VALORE',Valore);
    SetVariable('MESSAGGIO',Messaggio);
    SetVariable('TESTO_SQL',TestoSQL);
    if StrutturaFissa.Ente <> '' then
      if selIA100.FieldByName('DIREZIONE_DATI').AsString = 'I' then
        SetVariable('ENTE',selDatiInput.FieldByName(StrutturaFissa.Ente).AsString)
      else
        SetVariable('ENTE',selIA120.FieldByName('AZIENDA').AsString);
    if StrutturaFissa.Data <> '' then
    try
      if selIA100.FieldByName('DIREZIONE_DATI').AsString = 'I' then
        SetVariable('DATA_REGISTRAZIONE',R180StrToDateFmt(selDatiInput.FieldByName(StrutturaFissa.Data).AsString,VarToStr(selIA110.Lookup('INTESTAZIONE','DATA','FMT_DATA'))))
      else
        SetVariable('DATA_REGISTRAZIONE',selIA120.FieldByName('DATA_REGISTRAZIONE').AsDateTime);
    except
    end;
    if StrutturaFissa.Sequenza <> '' then
      if selIA100.FieldByName('DIREZIONE_DATI').AsString = 'I' then
        SetVariable('ID',selDatiInput.FieldByName(StrutturaFissa.Sequenza).AsInteger)
      else
        SetVariable('ID',selIA120.FieldByName('ID').AsInteger);
    if StrutturaFissa.Utente <> '' then
      if selIA100.FieldByName('DIREZIONE_DATI').AsString = 'I' then
        SetVariable('UTENTE',selDatiInput.FieldByName(StrutturaFissa.Utente).AsString)
      else
        SetVariable('UTENTE',selIA120.FieldByName('MACHINE_USER').AsString);
    if StrutturaFissa.Decorrenza <> '' then
    try
      if selIA100.FieldByName('DIREZIONE_DATI').AsString = 'I' then
        SetVariable('DECORRENZA',R180StrToDateFmt(selDatiInput.FieldByName(StrutturaFissa.Decorrenza).AsString,VarToStr(selIA110.Lookup('INTESTAZIONE','DECORRENZA','FMT_DATA'))))
      else
      begin
        if selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','DECORRENZA','CAMPO'))).DataType in [ftDate,ftDateTime] then
          SetVariable('DECORRENZA',selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','DECORRENZA','CAMPO'))).AsDateTime)
        else
          SetVariable('DECORRENZA',R180StrToDateFmt(selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','DECORRENZA','CAMPO'))).AsString,VarToStr(selIA110.Lookup('INTESTAZIONE','DECORRENZA','FMT_DATA'))));
      end;
    except
    end;
    if StrutturaFissa.Scadenza <> '' then
    try
      if selIA100.FieldByName('DIREZIONE_DATI').AsString = 'I' then
        SetVariable('SCADENZA',R180StrToDateFmt(selDatiInput.FieldByName(StrutturaFissa.Scadenza).AsString,VarToStr(selIA110.Lookup('INTESTAZIONE','SCADENZA','FMT_DATA'))))
      else
      begin
        if selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','SCADENZA','CAMPO'))).DataType in [ftDate,ftDateTime] then
          SetVariable('SCADENZA',selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','SCADENZA','CAMPO'))).AsDateTime)
        else
        SetVariable('SCADENZA',R180StrToDateFmt(selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','SCADENZA','CAMPO'))).AsString,VarToStr(selIA110.Lookup('INTESTAZIONE','SCADENZA','FMT_DATA'))));
      end;
    except
    end;
    if selIA100.FieldByName('DIREZIONE_DATI').AsString = 'I' then
      //SetVariable('CHIAVE',selDatiInput.FieldByName(StrutturaFissa.Chiave).AsString)
      SetVariable('CHIAVE',selDatiInput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','CHIAVE','NOME_DATO'))).AsString)
    else
      SetVariable('CHIAVE',selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','CHIAVE','CAMPO'))).AsString);
    Execute;
  except
    on E:Exception do
    begin
      SetVariable('MESSAGGIO',E.Message);
      Execute;
    end;
  end;
end;

procedure TB014FIntegrazioneAnagraficaDtM.EliminazioneDatiElaborati;
{eliminazione dei dati della struttura già elaborati, dopo aver scorso tutte le aziende}
var i:Integer;
begin
  delDatiInput.SetVariable('TABELLA',selIA100.FieldByName('NOME_STRUTTURA').AsString);
  for i:=0 to lstROWID.Count - 1 do
  try
    delDatiInput.SetVariable('MYROWID',lstROWID[i]);
    delDatiInput.Execute;
  except
  end;
end;

//--Gestione del flusso di Output--//
procedure TB014FIntegrazioneAnagraficaDtM.ScriptInserimentoOutput;
{creazione dello script di inserimento su tabella Oracle}
var C,V:String;
begin
  C:='';
  V:='';
  insDatiOutput.DeleteVariables;
  with selIA110 do
  begin
    First;
    while not Eof do
    begin
      if (StrutturaFissa.Dato = '') or (not FieldByName('INTESTAZIONE').IsNull) then
      begin
        if C <> '' then
        begin
          C:=C + ',';
          V:=V + ',';
        end;
        C:=C + FieldByName('NOME_DATO').AsString;
        V:=V + ':' + FieldByName('NOME_DATO').AsString;
        if (FieldByName('TIPO_DATO').AsString = 'D') and (FieldByName('FMT_DATA').IsNull) then
          insDatiOutput.DeclareVariable(FieldByName('NOME_DATO').AsString,otDate)
        else
          insDatiOutput.DeclareVariable(FieldByName('NOME_DATO').AsString,otString)
      end;
      Next;
    end;
  end;
  with insDatiOutput do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO ' + StrutturaFissa.NomeStruttura);
    SQL.Add('(' + C + ')');
    SQL.Add('VALUES');
    SQL.Add('(' + V + ')');
  end;
end;

procedure TB014FIntegrazioneAnagraficaDtM.EstrazioneDatiOutput;
{Lettura dei dati modificati/inseriti registrati su IA120
 Vengono letti i dati della tabella e scritti sulla struttura specificata da IA100/IA110}
var Tabella:String;
begin
  //Impostazione eventuale collegamento FTP
  if not selIA100.FieldByName('FTP_HOST').IsNull then
  begin
    IdFTP.Host:=selIA100.FieldByName('FTP_HOST').AsString;
    if selIA100.FieldByName('FTP_PORT').IsNull then
      IdFTP.Port:=21
    else
      IdFTP.Port:=selIA100.FieldByName('FTP_PORT').AsInteger;
    IdFTP.Username:=selIA100.FieldByName('FTP_USER').AsString;
    IdFTP.Password:=selIA100.FieldByName('FTP_PASSWORD').AsString;
    if IdFTP.Connected then
      IdFTP.Disconnect;
    IdFTP.Connect;
    if R180EstraiPercorsoFile(selIA100.FieldByName('NOME_FILE').AsString) <> '' then
      IdFTP.ChangeDir(R180EstraiPercorsoFile(selIA100.FieldByName('NOME_FILE').AsString));
  end;
  with selIA120 do
  try
    SetVariable('AZIENDA',selI090.FieldByName('CODICE_INTEGRAZIONE').AsString);
    SetVariable('NOME_STRUTTURA',StrutturaFissa.NomeStruttura);
    Close;
    Open;
    while not Eof do
    begin
      inc(RigheElaborate);
      if StatusBar <> nil then
      begin
        StatusBar.Panels[1].Text:='Righe elaborate: ' + IntToStr(RigheElaborate);
        StatusBar.Repaint;
        Application.ProcessMessages;
      end;
      selDatiOutput.ClearVariables;
      Tabella:=FieldByName('USERNAME').AsString + '.' + FieldByName('TABELLA').AsString;
      if FieldByName('TABELLA').AsString = 'T430_STORICO' then
      begin
        Tabella:=FieldByName('USERNAME').AsString + '.' + 'T030_ANAGRAFICO T030,' + Tabella + ' T430';
        selDatiOutput.SetVariable('JOIN','T030.PROGRESSIVO = T430.PROGRESSIVO AND ');
        selDatiOutput.SetVariable('CAMPO','T030.PROGRESSIVO');
      end
      else
        selDatiOutput.SetVariable('CAMPO','PROGRESSIVO');
      selDatiOutput.SetVariable('TABELLA',Tabella);
      selDatiOutput.SetVariable('VALORE',FieldByName('ID_DATO').AsString);
      selDatiOutput.Close;
      selDatiOutput.Open;
      DatiNonStorici.Clear;
      while not selDatiOutput.Eof do
      begin
        if selIA100.FieldByName('TIPO_STRUTTURA').AsString = 'T' then
          ScritturaDatiOutputTabella
        else if selIA100.FieldByName('TIPO_STRUTTURA').AsString = 'F' then
          ScritturaDatiOutputFile;
        selDatiOutput.Next;
      end;
      Delete;
    end;
  except
    on E:Exception do
      //RegistraLogMessaggi('    *** ' + E.Message);
      TRegistraMsg(SessioneIWB014.RegistraMsg).InserisciMessaggio('A','    *** ' + E.Message,selI090.FieldByName('CODICE_INTEGRAZIONE').AsString);
  end;
  selDatiOutput.Close;
  selIA120.Close;
  if IdFTP.Connected then
    IdFTP.Disconnect;
end;

procedure TB014FIntegrazioneAnagraficaDtM.ScritturaDatiOutputTabella;
{Scrittura dei dati su tabella Oracle}
var FmtData,Valore,Dato:String;
    D:TDateTime;
begin
  //Scrittura dati intestazione
  with insDatiOutput do
  begin
    ClearVariables;
    if StrutturaFissa.Ente <> '' then
      SetVariable(StrutturaFissa.Ente,selIA120.FieldByName('AZIENDA').AsString);
    if StrutturaFissa.Sequenza <> '' then
      SetVariable(StrutturaFissa.Sequenza,selIA120.FieldByName('ID').AsString);
    if StrutturaFissa.Data <> '' then
    begin
      FmtData:=VarToStr(selIA110.Lookup('NOME_DATO',StrutturaFissa.Data,'FMT_DATA'));
      if FmtData = '' then
        SetVariable(StrutturaFissa.Data,selIA120.FieldByName('DATA_REGISTRAZIONE').AsDateTime)
      else
        SetVariable(StrutturaFissa.Data,FormatDateTime(FmtData,selIA120.FieldByName('DATA_REGISTRAZIONE').AsDateTime));
    end;
    if StrutturaFissa.Utente <> '' then
      SetVariable(StrutturaFissa.Utente,selIA120.FieldByName('MACHINE_USER').AsString);
    if StrutturaFissa.Chiave <> '' then
      SetVariable(StrutturaFissa.Chiave,selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','CHIAVE','CAMPO'))).AsString);
    if StrutturaFissa.Decorrenza <> '' then
    try  //Alberto 06/06/2006: gestone eccezione se non esiste la colonna Decorrenza
      D:=selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','DECORRENZA','CAMPO'))).AsDateTime;
      FmtData:=VarToStr(selIA110.Lookup('INTESTAZIONE','DECORRENZA','FMT_DATA'));
      if FmtData = '' then
        SetVariable(StrutturaFissa.Decorrenza,D)
      else
        SetVariable(StrutturaFissa.Decorrenza,FormatDateTime(FmtData,D));
    except
    end;
    if StrutturaFissa.Scadenza <> '' then
    try //Alberto 06/06/2006: gestone eccezione se non esiste la colonna Scadenza
      D:=selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','SCADENZA','CAMPO'))).AsDateTime;
      FmtData:=VarToStr(selIA110.Lookup('INTESTAZIONE','SCADENZA','FMT_DATA'));
      if D = EncodeDate(3999,12,31) then
        SetVariable(StrutturaFissa.Scadenza,null)
      else if FmtData = '' then
        SetVariable(StrutturaFissa.Scadenza,D)
      else
        SetVariable(StrutturaFissa.Scadenza,FormatDateTime(FmtData,D));
    except
    end;
  end;
  //Scrittura dati effettivi specificati su IA110
  with selIA110 do
  begin
    First;
    while not Eof do
    begin
      try
        if FieldByName('INTESTAZIONE').IsNull then
        begin
          Dato:=FieldByName('NOME_DATO').AsString;
          if (FieldByName('STORICO').AsString = 'N') and (DatiNonStorici.IndexOf(Dato) >= 0) then
          begin
            Next;
            Continue;
          end;
          if FieldByName('STORICO').AsString = 'N' then
            DatiNonStorici.Add(Dato);
          Valore:=selDatiOutput.FieldByName(FieldByName('CAMPO').AsString).AsString;
          if (FieldByName('TIPO_DATO').AsString = 'D') and (not FieldByName('FMT_DATA').IsNull) then
            Valore:=FormatDateTime(FieldByName('FMT_DATA').AsString,selDatiOutput.FieldByName(FieldByName('CAMPO').AsString).AsDateTime);
          if StrutturaFissa.Dato <> '' then
          begin
            insDatiOutput.SetVariable(StrutturaFissa.Dato,Dato);
            Dato:=StrutturaFissa.Valore;
          end;
          if (FieldByName('TIPO_DATO').AsString = 'D') and (FieldByName('FMT_DATA').IsNull) then
            insDatiOutput.SetVariable(Dato,selDatiOutput.FieldByName(FieldByName('CAMPO').AsString).AsDateTime)
          else
            insDatiOutput.SetVariable(Dato,Valore);
          //Scrittura di un dato per ogni riga
          if StrutturaFissa.Dato <> '' then
          try
            insDatiOutput.Execute;
            RegistraLog(FieldByName('NOME_DATO').AsString,Valore,'O','','');
          except
            on E:Exception do
              RegistraLog(FieldByName('NOME_DATO').AsString,Valore,'E',E.Message,insDatiOutput.SQL.Text);
          end;
        end;
      except
        on E:Exception do
          RegistraLog(Dato,Valore,'E',E.Message,'');
      end;
      Next;
    end;
    //Scrittura di più dati su una sola riga
    if StrutturaFissa.Dato = '' then
    try
      insDatiOutput.Execute;
      RegistraLog('','','O','','');
    except
      on E:Exception do
        RegistraLog('','','E',E.Message,insDatiOutput.SQL.Text);
    end;
  end;
  SessioneIWB014.SessioneOracle.Commit;
end;

procedure TB014FIntegrazioneAnagraficaDtM.ScritturaDatiOutputFile;
{Scrittura dei dati su file sequenziale}
var FmtData,Valore,Dato,Riga,RigaIntestazione:String;
    D:TDateTime;
 procedure ScriviRiga(Dato,Valore:String);
 var P,L:Word;
 begin
   P:=StrToIntDef(VarToStr(selIA110.Lookup('NOME_DATO',Dato,'POS_DATO')),0);
   L:=StrToIntDef(VarToStr(selIA110.Lookup('NOME_DATO',Dato,'LUNG_DATO')),0);
   if (P = 0) or (L = 0) then
     exit;
   if P + L > Length(Riga) then
     Riga:=R180Spaces(Riga,P + L - Length(Riga));
   Valore:=Copy(Valore,1,L);
   if VarToStr(selIA110.Lookup('NOME_DATO',Dato,'TIPO_DATO')) = 'N' then
     Valore:=StringReplace(Format('%*s',[L,Valore]),' ','0',[rfReplaceAll])
   else
     Valore:=Format('%-*s',[L,Valore]);
   Riga:=Copy(Riga,1,P - 1) + Valore + Copy(Riga,P + L,Length(Riga));
 end;
begin
  Riga:='';
  //Scrittura dati intestazione
  if StrutturaFissa.Ente <> '' then
    ScriviRiga(StrutturaFissa.Ente,selIA120.FieldByName('AZIENDA').AsString);
  if StrutturaFissa.Sequenza <> '' then
    ScriviRiga(StrutturaFissa.Sequenza,selIA120.FieldByName('ID').AsString);
  if StrutturaFissa.Data <> '' then
  begin
    FmtData:=VarToStr(selIA110.Lookup('NOME_DATO',StrutturaFissa.Data,'FMT_DATA'));
    if FmtData = '' then
      ScriviRiga(StrutturaFissa.Data,selIA120.FieldByName('DATA_REGISTRAZIONE').AsString)
    else
      ScriviRiga(StrutturaFissa.Data,FormatDateTime(FmtData,selIA120.FieldByName('DATA_REGISTRAZIONE').AsDateTime));
    end;
  if StrutturaFissa.Utente <> '' then
    ScriviRiga(StrutturaFissa.Utente,selIA120.FieldByName('MACHINE_USER').AsString);
  if StrutturaFissa.Chiave <> '' then
    ScriviRiga(StrutturaFissa.Chiave,selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','CHIAVE','CAMPO'))).AsString);
  if StrutturaFissa.Decorrenza <> '' then
  try //Alberto 06/06/2006: gestione eccezione se non esiste la colonna Decorrenza
    D:=selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','DECORRENZA','CAMPO'))).AsDateTime;
    FmtData:=VarToStr(selIA110.Lookup('INTESTAZIONE','DECORRENZA','FMT_DATA'));
    if FmtData = '' then
      ScriviRiga(StrutturaFissa.Decorrenza,DateToStr(D))
    else
      ScriviRiga(StrutturaFissa.Decorrenza,FormatDateTime(FmtData,D));
  except
  end;
  if StrutturaFissa.Scadenza <> '' then
  try //Alberto 06/06/2006: gestone eccezione se non esiste la colonna Scadenza
    D:=selDatiOutput.FieldByName(VarToStr(selIA110.Lookup('INTESTAZIONE','SCADENZA','CAMPO'))).AsDateTime;
    FmtData:=VarToStr(selIA110.Lookup('INTESTAZIONE','SCADENZA','FMT_DATA'));
    if ((D = 0) or (D = EncodeDate(3999,12,31))) then
    begin
      if FmtData = 'YYYYMMDD' then
        //Formattazione per EngiSanità
        ScriviRiga(StrutturaFissa.Scadenza,'00000000')
      else
        ScriviRiga(StrutturaFissa.Scadenza,'');
    end
    else if FmtData = '' then
      ScriviRiga(StrutturaFissa.Scadenza,DateToStr(D))
    else
      ScriviRiga(StrutturaFissa.Scadenza,FormatDateTime(FmtData,D));
  except
  end;
  RigaIntestazione:=Riga;
  //Scrittura dati effettivi specificati su IA110
  with selIA110 do
  begin
    First;
    while not Eof do
    begin
      try
        if FieldByName('INTESTAZIONE').IsNull then
        begin
          if StrutturaFissa.Dato <> '' then
            Riga:=RigaIntestazione;
          Dato:=FieldByName('NOME_DATO').AsString;
          if (FieldByName('STORICO').AsString = 'N') and (DatiNonStorici.IndexOf(Dato) >= 0) then
          begin
            Next;
            Continue;
          end;
          if FieldByName('STORICO').AsString = 'N' then
            DatiNonStorici.Add(Dato);
          Valore:=selDatiOutput.FieldByName(FieldByName('CAMPO').AsString).AsString;
          if (FieldByName('TIPO_DATO').AsString = 'D') and (not FieldByName('FMT_DATA').IsNull) then
            Valore:=FormatDateTime(FieldByName('FMT_DATA').AsString,selDatiOutput.FieldByName(FieldByName('CAMPO').AsString).AsDateTime);
          if (FieldByName('TIPO_DATO').AsString = 'D') and (FieldByName('FMT_DATA').AsString = 'YYYYMMDD') and selDatiOutput.FieldByName(FieldByName('CAMPO').AsString).IsNull then
            Valore:='00000000';
          if StrutturaFissa.Dato <> '' then
          begin
            ScriviRiga(StrutturaFissa.Dato,Dato);
            Dato:=StrutturaFissa.Valore;
          end;
          ScriviRiga(Dato,Valore);
          //Scrittura di un dato per ogni riga
          if StrutturaFissa.Dato <> '' then
          begin
            ScriviFile(Riga);
            RegistraLog(FieldByName('NOME_DATO').AsString,Valore,'O','','');
          end;
        end;
      except
        on E:Exception do
          RegistraLog(FieldByName('NOME_DATO').AsString,Valore,'E',E.Message,'');
      end;
      Next;
    end;
    //Scrittura di più dati su una sola riga
    if StrutturaFissa.Dato = '' then
    try
      ScriviFile(Riga);
      RegistraLog('','','O','','');
    except
      on E:Exception do
        RegistraLog('','','E',E.Message,'');
    end;
  end;
  SessioneIWB014.SessioneOracle.Commit;
end;

procedure TB014FIntegrazioneAnagraficaDtM.ScriviFile(Riga:String);
var SS:TStringStream;
    lst:TStringList;
begin
  if selIA100.FieldByName('FTP_HOST').IsNull then
    R180AppendFile(selIA100.FieldByName('NOME_FILE').AsString,Riga)
  else
  begin
    Riga:=Riga + #13#10;
    while True do
    try
      SS:=TStringStream.Create(Riga);
      lst:=TStringList.Create;
      try
        //Lettura semaforo
        while True do
          try
            IdFTP.List(lst,R180EstraiNomeFile(selIA100.FieldByName('NOME_FILE').AsString) + '.lck',False);
            if lst.Count = 0 then
              Abort;
            if (lst.Count > 0) and (Pos('NO SUCH FILE OR DIRECTORY',UpperCase(lst.Text)) > 0) then
              Abort;
          except
            R180AppendFile(R180EstraiNomeFile(selIA100.FieldByName('NOME_FILE').AsString) + '.lck','');
            IdFTP.Put(R180EstraiNomeFile(selIA100.FieldByName('NOME_FILE').AsString + '.lck'),selIA100.FieldByName('NOME_FILE').AsString + '.lck',False);
            Break;
          end;
        lst.Clear;
        try
          IdFTP.List(lst,R180EstraiNomeFile(selIA100.FieldByName('NOME_FILE').AsString),False);
        except
          lst.Add('*');
        end;
        if (lst.Count > 0) and (lst[0] = R180EstraiNomeFile(selIA100.FieldByName('NOME_FILE').AsString)) then
          IdFTP.Put(SS,selIA100.FieldByName('NOME_FILE').AsString,True)
        else
          IdFTP.Put(SS,selIA100.FieldByName('NOME_FILE').AsString,False);
      finally
        SS.Free;
        lst.Free;
        try IdFTP.Delete(selIA100.FieldByName('NOME_FILE').AsString + '.lck'); except end;
      end;
      Break;
    except
      if (not IdFTP.Connected) (*or IdFTP.ClosedGracefully*) then
      begin
        if IdFTP.Connected then
          IdFTP.Disconnect;
        IdFTP.Connect;
        if R180EstraiPercorsoFile(selIA100.FieldByName('NOME_FILE').AsString) <> '' then
          IdFTP.ChangeDir(R180EstraiPercorsoFile(selIA100.FieldByName('NOME_FILE').AsString));
        try IdFTP.Delete(selIA100.FieldByName('NOME_FILE').AsString + '.lck'); except end;
      end
      else
        Break;
    end;
  end;
end;

procedure TB014FIntegrazioneAnagraficaDtM.DataModuleDestroy(
  Sender: TObject);
begin
  //lstLog.Free;
  //lstB014.Free;
  lstROWID.Free;
  lstColSize.Free;
  DatiNonStorici.Free;
end;

end.

