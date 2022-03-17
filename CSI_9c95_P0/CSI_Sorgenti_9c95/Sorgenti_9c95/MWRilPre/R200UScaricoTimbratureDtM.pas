 (*
-  Gestito SessioneOracleB006 invece di SessioneOracle
-  Spaccato il Create in Create + ConnettiDataBase
-  try except sugli accessi ai files
-  modificato il nome dei files (Alias + nomefile)
-  Gestito A023FAllTimb con variabile locale anzichè con variabile globale
*)
unit R200UScaricoTimbratureDtM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000Versione, A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali, Oracle,
  OracleData, Stdctrls, Variants, DateUtils, ExtCtrls, RegistrazioneLog,
  System.IOUtils, System.Types;

type
  TPosizione = record
    Posiz,Lung:Integer;
  end;

  TMappa = record
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    Chiave,                   // dato parametrico per associazione con dipendente
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    Badge,EdBadge,
    Anno,Mese,Giorno,
    Ore,Minuti,Secondi,
    Verso,
    Rilevatore,
    Causale:TPosizione;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    UtilizzaChiave: Boolean;  // indica se la parametrizzazione utilizza il dato chiave in alternativa al badge
    ExprChiave: String;       // espressione SQL per determinare il progressivo utilizzando la chiave alternativa
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
  end;

  TR200FScaricoTimbratureDtM = class(TDataModule)
    DI100: TDataSource;
    QI100: TOracleDataSet;
    QI090: TOracleDataSet;
    QI101: TOracleQuery;
    DbScarico: TOracleSession;
    Q100: TOracleQuery;
    Q370: TOracleQuery;
    Q430: TOracleDataSet;
    Q361: TOracleDataSet;
    selI102: TOracleDataSet;
    dsrI102: TDataSource;
    selI102ORA: TStringField;
    scrTIMB_TRIGGER_BEFORE: TOracleQuery;
    scrTIMB_TRIGGER_AFTER: TOracleQuery;
    selI102MODULO: TStringField;
    QI100SCARICO: TStringField;
    QI100NOMEFILE: TStringField;
    QI100TCP: TStringField;
    QI100IPADDRESS: TStringField;
    QI100CORRENTE: TStringField;
    QI100BADGE: TStringField;
    QI100EDBADGE: TStringField;
    QI100ANNO: TStringField;
    QI100MESE: TStringField;
    QI100GIORNO: TStringField;
    QI100ORE: TStringField;
    QI100MINUTI: TStringField;
    QI100SECONDI: TStringField;
    QI100RILEVATORE: TStringField;
    QI100CAUSALE: TStringField;
    QI100VERSO: TStringField;
    QI100ENTRATA: TStringField;
    QI100USCITA: TStringField;
    QI100TIPOSCARICO: TStringField;
    QI100TRIGGER_BEFORE: TStringField;
    QI100TRIGGER_AFTER: TStringField;
    QI100AZIENDE: TStringField;
    QI100FUNZIONE: TStringField;
    QI100TIMB_NONTOLL_GGPREC: TIntegerField;
    QI100TIMB_NONTOLL_GGSUCC: TIntegerField;
    QI100TIMB_NONTOLL_LOG: TStringField;
    QI100TIMB_NONTOLL_REG: TStringField;
    Q103: TOracleQuery;
    QI100OFFSET_ANNO: TIntegerField;
    QI100CHIAVE: TStringField;
    QI100EXPR_CHIAVE: TStringField;
    selChiave: TOracleDataSet;
    //selLog: TOracleDataSet;
    procedure selI102NewRecord(DataSet: TDataSet);
    procedure R200FScaricoTimbratureDtMCreate(Sender: TObject);
    procedure R200FScaricoTimbratureDtMDestroy(Sender: TObject);
    procedure selI102ORAValidate(Sender: TField);
    procedure Q100BeforeQuery(Sender: TOracleQuery);
    procedure Q100AfterQuery(Sender: TOracleQuery);
  private
    Mappa:TMappa;
    Residui:Boolean;
    ScaricoDating:Boolean;
    TimbDating:String;
    NumeroRighe,NumeroRigheDoppie:Integer;
    StrLogTemp:TStringList;
    NFCorrente,NFAppoggio,NFScartate,NFCopia,NFAnomalie:String;
    TFCorrente,TFAppoggio,TFScartate,TFAnomalie:TextFile;
    procedure CicloScarico;
    procedure EstraiMappatura;
    procedure ScaricaRiga(S:String);
    procedure ConvertiRigaDating(S:String);
    procedure EstraiTimbrature;
    procedure AllineaTimbrature;
    procedure RegistraTimbIrregolari(S:String);
    procedure GestioneParametrizzazione;
  public
    Anomalie,ScaricoAutomatico:Boolean;
    DataI,DataF,DataIRecupero,DataFRecupero:TDateTime;
    LMessaggi,LProg:TStringList;
    NFRecupero:String;
    LScarico,LAzienda,LBadge,LRiga:TLabel;
    ScrollBox:TScrollBox;
    SessioneOracleB006,SOB006Interna: TOracleSession;
    RegistraMsg:TRegistraMsg;
    procedure ConnettiDataBase(Alias:String);
    function ControlloConnessioneDatabase:Boolean;
    procedure Scarico(Unico,Automatico:Boolean);
  end;

// AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
// variabile globale da rimuovere
//var
//  R200FScaricoTimbratureDtM: TR200FScaricoTimbratureDtM;
// AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine

implementation

uses A023UAllTimbMW, A060UTimbIrregolariMW;

{$R *.DFM}

procedure TR200FScaricoTimbratureDtM.R200FScaricoTimbratureDtMCreate(Sender: TObject);
begin
  SessioneOracleB006:=TOracleSession.Create(Self);
  SOB006Interna:=SessioneOracleB006;
  LAzienda:=nil;
  LBadge:=nil;
  LRiga:=nil;
  ScrollBox:=nil;
  ScaricoDating:=False;
  NFRecupero:='';  //Usato dalla A032 per gestire lo scarico di files precedenti
  StrLogTemp:=TStringList.Create;
  LMessaggi:=TStringList.Create;
  QI100.Filter:='CORRENTE = ''S''';
  QI100.Filtered:=True;
  //non viene usato RegistraMsg di SessioneIrisWIN per consentirne il funzionamento anche col B006
  //RegistraMsg:=TRegistraMsg.Create(Self);
  RegistraMsg:=TRegistraMsg.Create(SessioneOracleB006);
end;

procedure TR200FScaricoTimbratureDtM.ConnettiDataBase(Alias:String);
begin
  NFCorrente:=ExtractFilePath(Application.ExeName) + 'Archivi\Temp\' + Alias + 'TimbrCor';
  NFAppoggio:=ExtractFilePath(Application.ExeName) + 'Archivi\Temp\' + Alias + 'TimbrApp';
  NFScartate:=ExtractFilePath(Application.ExeName) + 'Archivi\Temp\' + Alias + 'TimbrIrr';
  QI100.Session:=SessioneOracleB006;
  QI090.Session:=SessioneOracleB006;
  QI101.Session:=SessioneOracleB006;
  selI102.Session:=SessioneOracleB006;

  if not SessioneOracleB006.Connected then
  begin
    SessioneOracleB006.LogonDatabase:=Alias;
    A000LogonDBOracle(SessioneOracleB006);
  end;
  try
    QI100.Open;
    selI102.Open;
    QI090.Open;
    NFCopia:=ExtractFilePath(QI100.FieldByName('NomeFile').AsString) + 'TB' + FormatDateTime('yymmdd',Date) + '.';
  except
    on E:Exception do
      RegistraMsg.InserisciMessaggio('A',E.Message);
  end;
end;

function TR200FScaricoTimbratureDtM.ControlloConnessioneDatabase:Boolean;
begin
  try
    if not SessioneOracleB006.Connected then
    begin
      try
        {$IFDEF IRISWEB}
          SessioneOracleB006.ThreadSafe:=True;
        {$ENDIF}
        SessioneOracleB006.LogOn;
        QI100.Open;
        QI090.Open;
        selI102.Open;
        NFCopia:=ExtractFilePath(QI100.FieldByName('NomeFile').AsString) + 'TB' + FormatDateTime('yymmdd',Date) + '.';
      except
        on E:Exception do
          RegistraMsg.InserisciMessaggio('A',E.Message);
      end;
    end;

    case SessioneOracleB006.CheckConnection(True) of
      ccError:
      begin
        RegistraMsg.InserisciMessaggio('A','[' + SessioneOracleB006.LogonDatabase + '] Connessione con Oracle non esistente');
        try
          SessioneOracleB006.LogOff;
          SessioneOracleB006.LogOn;
          QI100.Open;
          QI090.Open;
          selI102.Open;
          NFCopia:=ExtractFilePath(QI100.FieldByName('NomeFile').AsString) + 'TB' + FormatDateTime('yymmdd',Date) + '.';
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A',E.Message);
        end;
      end;
      ccReconnected:
      begin
        QI100.Open;
        QI090.Open;
        selI102.Open;
        NFCopia:=ExtractFilePath(QI100.FieldByName('NomeFile').AsString) + 'TB' + FormatDateTime('yymmdd',Date) + '.';
      end;
    end;
  except
  end;

  Result:=SessioneOracleB006.Connected;
end;

procedure TR200FScaricoTimbratureDtM.Scarico(Unico,Automatico:Boolean);
{Scarico gestendo la multiaziendalità}
var ModuloDisabilitato:Boolean;
    A060MW:TA060FTimbIrregolariMW;
begin
  A000SettaVariabiliAmbiente;
  ScaricoAutomatico:=Automatico;
  //RegistraMsg.Session:=SessioneOracleB006;
  RegistraMsg.SessioneOracleApp:=SessioneOracleB006;
  if not ControlloConnessioneDatabase then
    exit;
  RegistraMsg.IniziaMessaggio(IfThen(ScaricoAutomatico,'B006','A032'));
  RegistraMsg.InserisciMessaggio('I','INIZIO ACQUISIZIONE TIMBRATURE');
  if Automatico then
  begin
    ModuloDisabilitato:=True;
    QI090.First;
    while not QI090.Eof do
    begin
      if A000ModuloAbilitato(QI090.Session,'ACQUISIZIONE_TIMBRATURE_SCHEDULATA',QI090.FieldByName('AZIENDA').AsString) then
      begin
        ModuloDisabilitato:=False;
        Break;
      end;
      QI090.Next;
    end;
    if ModuloDisabilitato then
    begin
      RegistraMsg.InserisciMessaggio('A','MODULO DISABILITATO PER TUTTE LE AZIENDE');
      RegistraMsg.InserisciMessaggio('I','FINE ACQUISIZIONE TIMBRATURE');
      exit;
    end;
    QI090.First;
  end;

  if not Unico then
    QI100.First;
  //Ciclo sulle parametrizzazioni
  repeat
    if Unico or (QI100.FieldByName('CORRENTE').AsString = 'S') then
    try
      GestioneParametrizzazione;
    except
      on E:Exception do
        if not(E is EAbort) then
          RegistraMsg.InserisciMessaggio('A',E.Message);
    end;
    if not Unico then
      QI100.Next;
  until Unico or QI100.Eof;

  if Automatico then
  begin
    A060MW:=TA060FTimbIrregolariMW.Create(SessioneOracleB006);
    try
      with A060MW do
      begin
        RegistraMsgA060:=RegistraMsg;
        DaData:=R180AddMesi(R180InizioMese(Date),-1);
        AData:=Date;
        try
          Scarico;
        except
          on E:Exception do
            if not(E is EAbort) then
              RegistraMsg.InserisciMessaggio('A',E.Message);
        end;
      end;
    finally
      FreeAndNil(A060MW);
    end;
  end;
  RegistraMsg.InserisciMessaggio('I','FINE ACQUISIZIONE TIMBRATURE');
end;

procedure TR200FScaricoTimbratureDtM.GestioneParametrizzazione;
var
  NB:Integer;
  LNomeFileOrig: String;
  LNomeFileRinom: String;
  LFileArr: TStringDynArray;
  LNomeFileAnomalie: string;
  LFAnomalie: string;
begin
  RegistraMsg.InserisciMessaggio('I','Parametrizzazione ' + QI100.FieldByName('SCARICO').AsString);
  if NFRecupero = '' then
    LNomeFileOrig:=QI100.FieldByName('NomeFile').AsString
  else
    LNomeFileOrig:=NFRecupero;
  if ScrollBox <> nil then
  begin
    LScarico.Caption:=QI100.FieldByName('SCARICO').AsString;
    ScrollBox.Repaint;
  end;

  // identificazione scarico Dating
  try
    ScaricoDating:=QI100.FieldByName('TipoScarico').AsString = '1';
  except
    ScaricoDating:=False;
  end;

  // legge mappatura file
  EstraiMappatura;

  if QI100.FieldByName('TCP').AsString = 'S' then
    exit;//Trasferimento file da Unix a PC con FTP

  //Nome file per anomalie durante inserimento, che può contenere caratteri jolly e su cui ciclare alla fine dell'acquisizione
  LNomeFileAnomalie:=R180GetFilePath(LNomeFileOrig) + '\Anomalie_' + R180GetFileName(LNomeFileOrig);

  // il nome file può essere un file singolo o un pattern che identifica più file
  // estrae l'elenco dei file che corrispondono al pattern indicato
  LFileArr:=TDirectory.GetFiles(TPath.GetDirectoryName(LNomeFileOrig),TPath.GetFileName(LNomeFileOrig),TSearchOption.soTopDirectoryOnly);

  // registra nel log l'assenza di file da acquisire
  if Length(LFileArr) = 0 then
    RegistraMsg.InserisciMessaggio('I',Format('Nessun file da acquisire: %s',[LNomeFileOrig]));

  for LNomeFileOrig in LFileArr do
  begin
    RegistraMsg.InserisciMessaggio('I',Format('File da acquisire: %s - timestamp: %s',[LNomeFileOrig, FormatDateTime('dd/mm/yyyy hh.nn',TFile.GetLastWriteTime(LNomeFileOrig))]));

    NFCopia:=ExtractFilePath(LNomeFileOrig) + 'TB' + FormatDateTime('yymmdd',Date) + '.';

    //Cancello i files temporanei utilizzati nell'acquisizione
    DeleteFile(NFAppoggio);
    DeleteFile(NFCorrente);
    DeleteFile(NFScartate);
    //Nome file per anomalie durante inserimento, riferito al singolo LNomeFileOrig
    NFAnomalie:=R180GetFilePath(LNomeFileOrig) + '\Anomalie_' + R180GetFileName(LNomeFileOrig);
    //Alberto 30/03/2006: se il file non esiste esco subito senza segnalare nulla
    if FileExists(LNomeFileOrig) then
    begin
      try
        QI090.Refresh;
        QI090.First;
      except
        on E:Exception do
        begin
          RegistraMsg.InserisciMessaggio('A',E.Message);
          abort;
        end;
      end;

      // rinomina file su stessa cartella
      LNomeFileRinom:=LNomeFileOrig + '.medp';
      //Alberto 17/10/2018: se il file .medp esiste ancora, vuol dire che non è stato elaborato dalla precedente acquisizione,
      //per cui salto l'eleaborazione del file originale e vado avanti provando ad elaborare il .medp.
      if not FileExists(LNomeFileRinom) then
      begin
        if not RenameFile(LNomeFileOrig,LNomeFileRinom) then
        begin
          RegistraMsg.InserisciMessaggio('A','Impossibile rinominare il file ' + LNomeFileOrig + ' in ' + LNomeFileRinom);
          Continue; //+++ Abort;
        end;
      end;
      // sposta il file sotto "Archivi\Temp"
      if not RenameFile(LNomeFileRinom,NFCorrente) then
      begin
        RegistraMsg.InserisciMessaggio('A','Impossibile spostare il file ' + LNomeFileRinom + ' in ' + NFCorrente);
        Continue; //+++ Abort;
      end;

      for NB:=0 to 999 do
      begin
        if CopyFile(PChar(NFCorrente),PChar(NFCopia + Format('%3.3d',[NB])),True) then
          Break;
      end;
      if NB = 1000 then
      begin
        if not CopyFile(PChar(NFCorrente),PChar(NFCopia + '999'),False) then
        begin
          RegistraMsg.InserisciMessaggio('A','Impossibile copiare il file ' + NFCorrente + ' in ' + NFCopia + '999');
          Continue; //+++ Abort;
        end;
      end;
      Anomalie:=False;
      EstraiTimbrature;
    end
    else
    begin
      RegistraMsg.InserisciMessaggio('A','File inesistente: ' + LNomeFileOrig);
    end;
  end;

  // fine parametrizzazione
  RegistraMsg.InserisciMessaggio('I','Fine parametrizzazione ' + QI100.FieldByName('SCARICO').AsString);

  // gestione file anomalie.inizio
  LFileArr:=TDirectory.GetFiles(TPath.GetDirectoryName(LNomeFileAnomalie),TPath.GetFileName(LNomeFileAnomalie),TSearchOption.soTopDirectoryOnly);
  for LFAnomalie in LFileArr do
  begin
    NFAnomalie:=LFAnomalie;

    if not FileExists(NFAnomalie) then
      Continue //+++ Abort
    else
    begin
      try AssignFile(TFAnomalie,NFAnomalie); except end;
      try Reset(TFAnomalie); except end;
      Anomalie:=not Eof(TFAnomalie);
      CloseFile(TFAnomalie);
      if not Anomalie then
      begin
        DeleteFile(NFAnomalie);
        Continue; //+++ Abort;
      end;
    end;
    try
      QI090.Open;
      QI090.Refresh;
      QI090.First;
    except
      Abort;
    end;
    if not RenameFile(NFAnomalie,NFCorrente) then
    begin
      RegistraMsg.InserisciMessaggio('A','Impossibile rinominare il file ' + NFAnomalie + ' in ' + NFCorrente);
      Continue; //+++ Abort;
    end;
    EstraiTimbrature;
    //Alberto: verificare cosa capita se si deve scriovere ancora Anomalie_<file>
  end;
  // gestione file anomalie.fine
end;

procedure TR200FScaricoTimbratureDtM.EstraiTimbrature;
var S:String;
begin
  //Inizio corpo
  with QI090 do
  begin
    while not Eof do
    begin
      //Ignoro l'azienda, se non prevista nella parametrizzazione di scarico
      if (Trim(QI100.FieldByName('AZIENDE').AsString) <> '')  and
         (Pos(',' + FieldByName('Azienda').AsString + ',',',' + QI100.FieldByName('AZIENDE').AsString + ',') = 0) then
      begin
        Next;
        Continue;
      end;
      RegistraMsg.InserisciMessaggio('I','  Azienda: ' + FieldByName('Azienda').AsString,FieldByName('Azienda').AsString);
      Q100.Close;
      Q430.Close;
      selChiave.Close; // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6
      if ScaricoAutomatico and not A000ModuloAbilitato(QI090.Session,'ACQUISIZIONE_TIMBRATURE_SCHEDULATA',QI090.FieldByName('AZIENDA').AsString) then
      begin
        RegistraMsg.InserisciMessaggio('A','MODULO DISABILITATO',FieldByName('Azienda').AsString);
        Next;
        Continue;
      end;
      if (not FieldByName('VERSIONEDB').IsNull) and (FieldByName('VERSIONEDB').AsString <> VersionePA) then
      begin
        RegistraMsg.InserisciMessaggio('A',Format('  La versione del database (%s) non corrisponde alla versione del prodotto(%s). Si consiglia di aggiornare l''applicativo!',[FieldByName('VERSIONEDB').AsString,VersionePA]),FieldByName('Azienda').AsString);
      end;
      //Setto le impostazioni del database in oggetto
      try
        DbScarico.LogOff;
      except
      end;
      DbScarico.LogonDatabase:=SessioneOracleB006.LogonDatabase;
      DbScarico.LogonUserName:=FieldByName('UTENTE').AsString;
      DbScarico.LogonPassword:=R180Decripta(FieldByName('PAROLACHIAVE').AsString,21041974);
      try
        DbScarico.Logon;
      except
        on E:Exception do
        begin
          RegistraMsg.InserisciMessaggio('A',E.Message,FieldByName('Azienda').AsString);
          Next;
          Continue;
        end;
      end;
      Q361.Close;
      Q361.Open;  //Leggo gli orologi
      if ScrollBox <> nil then
      begin
        LAzienda.Caption:=FieldByName('Azienda').AsString;
        LRiga.Caption:='0';
        ScrollBox.RePaint;
      end;
      NumeroRighe:=0;
      NumeroRigheDoppie:=0;
      //Inizializzo i file sequenziali
      try AssignFile(TFCorrente,NFCorrente); except end;
      try AssignFile(TFAppoggio,NFAppoggio); except end;
      try AssignFile(TFScartate,NFScartate); except end;
      try AssignFile(TFAnomalie,NFAnomalie); except end;
      Residui:=False;
      try Reset(TFCorrente); except end;
      try ReWrite(TFAppoggio); except end;
      try ReWrite(TFScartate); except end;
      //Verifio se il file Anomalie_<file> esiste, per andare in append o inizializzarlo
      if FileExists(NFAnomalie) then
        System.Append(TFAnomalie)
      else
        ReWrite(TFAnomalie);
      //Leggo il file sequenziale e scarico le timbrature corrispondenti su Q100
      CicloScarico;
      //Chiudo i file sequenziali e copio il residuo sull'originale
      //per scaricarlo sulla prossima azienda o per renderlo disponibile
      try CloseFile(TFCorrente); except end;
      try CloseFile(TFAppoggio); except end;
      try CloseFile(TFScartate); except end;
      try CloseFile(TFAnomalie); except end;
      RegistraMsg.InserisciMessaggio('I','    Righe elaborate: ' + IntToStr(NumeroRighe),FieldByName('Azienda').AsString);
      if NumeroRigheDoppie > 0 then
        RegistraMsg.InserisciMessaggio('I','    Righe duplicate: ' + IntToStr(NumeroRigheDoppie),FieldByName('Azienda').AsString);
      if not CopyFile(PChar(NFAppoggio),PChar(NFCorrente),False) then
      begin
        RegistraMsg.InserisciMessaggio('A','  Impossibile copiare il file ' + NFAppoggio + ' in ' + NFCorrente + '. Elaborazione interrotta.',FieldByName('Azienda').AsString);
        Break;
      end;
      if not Residui then
        Break;
      Next;
    end;
  end;
  //Se ci sono residui registro le timbr.irregolari sulla tabella I101_TimbIrregolari
  S:='';
  if Residui then
  begin
    NumeroRighe:=0;
    NumeroRigheDoppie:=0;
    try AssignFile(TFScartate,NFScartate); except end;
    try Reset(TFScartate); except end;
    while not Eof(TFScartate) do
    begin
      inc(NumeroRighe);
      Readln(TFScartate,S);
      RegistraTimbIrregolari(S);
    end;
    try CloseFile(TFScartate); except end;
    RegistraMsg.InserisciMessaggio('I','Timbrature irregolari: ' + IntToStr(NumeroRighe));
  end;
  //Cancello il file di appoggio, le timbrature correnti, e le timbrature originali
  DeleteFile(NFAppoggio);
  DeleteFile(NFCorrente);
  DeleteFile(NFScartate);
end;

procedure TR200FScaricoTimbratureDtM.EstraiMappatura;
{Legge la mappatura da QI100 e la esplode su Mappa}
var
  P:Integer;
begin
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
  // Chiave: dato parametrico per associazione con dipendente
  P:=Pos(',',QI100.FieldByname('Chiave').AsString);
  Mappa.Chiave.Posiz:=StrToIntDef(Copy(QI100.FieldByname('Chiave').AsString,1,P - 1),0);
  Mappa.Chiave.Lung:=StrToIntDef(Copy(QI100.FieldByname('Chiave').AsString,P + 1,8),0);
  // dati per la chiave in alternativa al badge
  Mappa.UtilizzaChiave:=(Mappa.Chiave.Posiz <> 0) and (Mappa.Chiave.Lung <> 0);
  Mappa.ExprChiave:=IfThen(Mappa.UtilizzaChiave,QI100.FieldByname('Expr_Chiave').AsString,'');
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
  //Badge
  P:=Pos(',',QI100.FieldByname('Badge').AsString);
  Mappa.Badge.Posiz:=StrToIntDef(Copy(QI100.FieldByname('Badge').AsString,1,P - 1),0);
  Mappa.Badge.Lung:=StrToIntDef(Copy(QI100.FieldByname('Badge').AsString,P + 1,8),0);
  //Ediz.Badge
  P:=Pos(',',QI100.FieldByname('EdBadge').AsString);
  Mappa.EdBadge.Posiz:=StrToIntDef(Copy(QI100.FieldByname('EdBadge').AsString,1,P - 1),0);
  Mappa.EdBadge.Lung:=StrToIntDef(Copy(QI100.FieldByname('EdBadge').AsString,P + 1,8),0);
  //Anno
  P:=Pos(',',QI100.FieldByname('Anno').AsString);
  Mappa.Anno.Posiz:=StrToIntDef(Copy(QI100.FieldByname('Anno').AsString,1,P - 1),0);
  Mappa.Anno.Lung:=StrToIntDef(Copy(QI100.FieldByname('Anno').AsString,P + 1,8),0);
  //Mese
  P:=Pos(',',QI100.FieldByname('Mese').AsString);
  Mappa.Mese.Posiz:=StrToIntDef(Copy(QI100.FieldByname('Mese').AsString,1,P - 1),0);
  Mappa.Mese.Lung:=StrToIntDef(Copy(QI100.FieldByname('Mese').AsString,P + 1,8),0);
  //Giorno
  P:=Pos(',',QI100.FieldByname('Giorno').AsString);
  Mappa.Giorno.Posiz:=StrToIntDef(Copy(QI100.FieldByname('Giorno').AsString,1,P - 1),0);
  Mappa.Giorno.Lung:=StrToIntDef(Copy(QI100.FieldByname('Giorno').AsString,P + 1,8),0);
  //Ore
  P:=Pos(',',QI100.FieldByname('Ore').AsString);
  Mappa.Ore.Posiz:=StrToIntDef(Copy(QI100.FieldByname('Ore').AsString,1,P - 1),0);
  Mappa.Ore.Lung:=StrToIntDef(Copy(QI100.FieldByname('Ore').AsString,P + 1,8),0);
  //Minuti
  P:=Pos(',',QI100.FieldByname('Minuti').AsString);
  Mappa.Minuti.Posiz:=StrToIntDef(Copy(QI100.FieldByname('Minuti').AsString,1,P - 1),0);
  Mappa.Minuti.Lung:=StrToIntDef(Copy(QI100.FieldByname('Minuti').AsString,P + 1,8),0);
  //Secondi
  P:=Pos(',',QI100.FieldByname('Secondi').AsString);
  Mappa.Secondi.Posiz:=StrToIntDef(Copy(QI100.FieldByname('Secondi').AsString,1,P - 1),0);
  Mappa.Secondi.Lung:=StrToIntDef(Copy(QI100.FieldByname('Secondi').AsString,P + 1,8),0);
  //Verso
  P:=Pos(',',QI100.FieldByname('Verso').AsString);
  Mappa.Verso.Posiz:=StrToIntDef(Copy(QI100.FieldByname('Verso').AsString,1,P - 1),0);
  Mappa.Verso.Lung:=StrToIntDef(Copy(QI100.FieldByname('Verso').AsString,P + 1,8),0);
  //Rilevatore
  P:=Pos(',',QI100.FieldByname('Rilevatore').AsString);
  Mappa.Rilevatore.Posiz:=StrToIntDef(Copy(QI100.FieldByname('Rilevatore').AsString,1,P - 1),0);
  Mappa.Rilevatore.Lung:=StrToIntDef(Copy(QI100.FieldByname('Rilevatore').AsString,P + 1,8),0);
  //Causale
  P:=Pos(',',QI100.FieldByname('Causale').AsString);
  Mappa.Causale.Posiz:=StrToIntDef(Copy(QI100.FieldByname('Causale').AsString,1,P - 1),0);
  Mappa.Causale.Lung:=StrToIntDef(Copy(QI100.FieldByname('Causale').AsString,P + 1,8),0);
end;

procedure TR200FScaricoTimbratureDtM.CicloScarico;
{Leggo il file sequenziale e scarico le timbrature corrispondenti su Q100}
var S:String;
    Progressione:Integer;
begin
  LProg:=TStringList.Create;
  DataI:=EncodeDate(3999,12,31);
  DataF:=EncodeDate(1900,1,1);
  Progressione:=0;
  //Conversione del file dating nel formato standard
  if (ScaricoDating) and not (Anomalie)  then
  begin
    TimbDating:='';
    while not Eof(TFCorrente) do
    begin
      Readln(TFCorrente,S);
      ConvertiRigaDating(S);
    end;
    if TimbDating <> '' then Writeln(TFAppoggio,TimbDating);
    //Copia file di appoggio su file corrente
    CloseFile(TFCorrente);
    CloseFile(TFAppoggio);
    CopyFile(PChar(NFAppoggio),PChar(NFCorrente),False);
    Reset(TFCorrente);
    ReWrite(TFAppoggio);
    ScaricoDating:=False;
  end;
  //Scarico standard
  while not Eof(TFCorrente) do
  begin
    inc(Progressione);
    if ScrollBox <> nil then
    begin
      LRiga.Caption:=IntToStr(Progressione);
      ScrollBox.RePaint;
    end;
    Readln(TFCorrente,S);
    ScaricaRiga(S);
  end;
  try
    DbScarico.Commit;
    AllineaTimbrature;
  except
  end;
  LProg.Free;
end;

procedure TR200FScaricoTimbratureDtM.ScaricaRiga(S:String);
{Esamina la riga letta dal file seq. e la scrive su Q100/Q361 oppure
la registra su NFAppoggio}
var A,M,G,H,N,Sec:Integer;
    Badge,EdBadge,Causale,Chiave,Prog:String; // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6
    Pres,Mensa,Inserimento,TimbrRegistrata:Boolean;
    IData,IBadge,IEdBadge,IOra,IVerso,IRilev,ICausale,ITimb,
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    // IFunzione non è mai valorizzato, ma veniva scritto nel file delle timbr. irregolari!!!
    // ho provveduto a commentarlo
    // aggiunto IChiave per gestione chiave alternativa
    {IFunzione}IChiave:String;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    InizioToll,FineToll,DataOraTimb:TDateTime;
    Lst: TStringList; // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6
    procedure InsTimb(Q:TOracleQuery);
    //Inserimento timbrature di presenza o di mensa
    begin
      with Q do
      begin
        // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
        //SetVariable('Progressivo',Q430.FieldByName('Progressivo').AsInteger);
        if Mappa.UtilizzaChiave then
        begin
          // utilizza il dataset legato alla chiave alternativa
          SetVariable('Progressivo',selChiave.FieldByName('Progressivo').AsInteger);
        end
        else
        begin
          // utilizza il dataset legato al badge
          SetVariable('Progressivo',Q430.FieldByName('Progressivo').AsInteger);
        end;
        // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine

        SetVariable('Data',EncodeDate(A,M,G));
        SetVariable('Ora',EncodeDate(1900,1,1) + EncodeTime(H,N,Sec,0));
        //Verso già letto e trasformato precedentemente
        SetVariable('Verso',IVerso);
        //Estraggo Rilevatore
        SetVariable('Rilevatore',Trim(IRilev));
        if Trim(IRilev) = '' then
          SetVariable('Flag','I')
        else
          SetVariable('Flag','O');
        try
          if StrToInt(Causale) = 0 then
            Causale:='';
        except
        end;
        SetVariable('Causale',Trim(Causale));
        if ScrollBox <> nil then
        begin
          // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
          // indicazione chiave alternativa al badge
          LBadge.Caption:=IfThen(Chiave <> '',Chiave,Badge);
          ScrollBox.RePaint;
          // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
        end;
        if Q = Q100 then
        begin
          //Timbrature di presenza: la doppia timbratura viene scartata
          try
            Execute;
            DbScarico.Commit;
            inc(NumeroRighe);
          except
            on E:Exception do
            begin
              if not(E is EAbort) and (Pos('ORA-00001',E.Message) = 0) and (Pos('ORA-06510',E.Message) = 0) then
              begin
                // registra anomalia
                RegistraMsg.InserisciMessaggio('A',E.Message);
                Writeln(TFAnomalie,S);
              end
              else if Pos('ORA-00001',E.Message) > 0 then
              begin
                // incrementa il numero di righe duplicate
                inc(NumeroRigheDoppie);
              end;
            end;
          end;
        end
        else if Q = Q103 then
        begin
          //Timbrature di presenza: la doppia timbratura viene scartata
          try
            Execute;
            DbScarico.Commit;
          except
            on E:Exception do
            begin
              if not(E is EAbort) and (Pos('ORA-00001',E.Message) = 0) and (Pos('ORA-06510',E.Message) = 0) then
              begin
                RegistraMsg.InserisciMessaggio('A',E.Message);
                Writeln(TFAnomalie,S);
              end;
            end
          end;
        end
        else
        //Timbrature di mensa: la doppia timbratura viene inserita con i secondi alterati
        begin
          Inserimento:=False;
          repeat
            try
              Execute;
              DbScarico.Commit;
              Inserimento:=True;
              inc(NumeroRighe);
            except
              on E:Exception do
              begin
                if not(E is EAbort) and (Pos('ORA-00001',E.Message) > 0) or (Pos('ORA-06510',E.Message) > 0) then
                begin
                  if (Mappa.Secondi.Posiz <> 99) or (Mappa.Secondi.Lung <> 99) then
                    Break;  //Alberto 4/9/98: esco subito dal ciclo per evitare timbrature doppie (La Spezia)
                  Inserimento:=Sec = 59;
                  if Sec < 59 then inc(Sec);
                  SetVariable('Ora',EncodeDate(1900,1,1) + EncodeTime(H,N,Sec,0));
                end
                else
                begin
                  Inserimento:=True;
                  RegistraMsg.InserisciMessaggio('A',E.Message);
                  Writeln(TFAnomalie,S);
                end;
              end;
            end;
          until Inserimento;
        end;
      end;
    end;
begin
  IData:='        ';
  IBadge:='               ';
  IEdBadge:='  ';
  IOra:='      ';
  IVerso:=' ';
  IRilev:='  ';
  ICausale:='     ';
  IChiave:=StringOfChar(' ',20); // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6
  try
    //Estraggo Rilevatore  //il codice orologio iniziale può anche essere di 10
    IRilev:=Copy(S,Mappa.Rilevatore.Posiz,Mappa.Rilevatore.Lung);
    IRilev:=R180DimLung(IRilev,Mappa.Rilevatore.Lung);
    if Q361.SearchRecord('Rilevatore',Trim(IRilev),[srFromBeginning]) then
    begin
      if (Q361.FieldByName('Scarico').IsNull or (Q361.FieldByName('Scarico').AsString = '')) then
        IRilev:=Q361.FieldByName('CODICE').AsString
      else if Q361.SearchRecord('Rilevatore;Scarico',VarArrayOf([Trim(IRilev),QI100.FieldByName('SCARICO').AsString]),[srFromBeginning]) then
        IRilev:=Q361.FieldByName('CODICE').AsString;
    end;
    //Estraggo Causale
    Causale:=Copy(S,Mappa.Causale.Posiz,Mappa.Causale.Lung);
    ICausale:=Copy(Causale + '     ',1,5);
    //Estraggo verso
    IVerso:=Copy(S,Mappa.Verso.Posiz,Mappa.Verso.Lung);
    if IVerso = QI100.FieldByName('Entrata').AsString then
      IVerso:='E'
    else
      IVerso:='U';
    //Verifico se il verso è fissato all'orologio
    if Q361.Locate('Codice',Trim(IRilev),[]) then
    begin
      if Q361.FieldByName('Verso').AsString = 'E' then
        IVerso:='E'
      else if Q361.FieldByName('Verso').AsString = 'U' then
        IVerso:='U';
    end;
    //Estraggo data per sapere a quale storico mi riferisco
    A:=StrToIntDef(Copy(S,Mappa.Anno.Posiz,Mappa.Anno.Lung),0);
    //Gestione anno 2/4 cifre
    if A < 100 then
    begin
      if A <= 50 then
        A:=A + 2000
      else
        A:=A + 1900;
    end;
    M:=StrToIntDef(Copy(S,Mappa.Mese.Posiz,Mappa.Mese.Lung),0);
    G:=StrToIntDef(Copy(S,Mappa.Giorno.Posiz,Mappa.Giorno.Lung),0);
    try
      IData:=FormatDateTime('yyyymmdd',EncodeDate(A,M,G));
    except
      IData:='19800101';
    end;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    // gestione chiave alternativa al badge
    if Mappa.UtilizzaChiave then
    begin
      Chiave:=Copy(S,Mappa.Chiave.Posiz,Mappa.Chiave.Lung);
      IChiave:=R180RPad(Chiave,20,' ');

      // pulisce info badge
      Badge:='';
      EdBadge:='';
    end
    else
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    begin
      //Estraggo Badge
      Badge:=Copy(S,Mappa.Badge.Posiz,Mappa.Badge.Lung);
      IBadge:=(IBadge + Badge);
      IBadge:=Copy(IBadge,Length(IBadge) - 14,15);
      //Estraggo Edizione Badge
      if Mappa.Edbadge.Lung > 0 then
      begin
        EdBadge:=Copy(S,Mappa.EdBadge.Posiz,Mappa.EdBadge.Lung);
        IEdBadge:=Copy(EdBadge + '  ',1,2);
      end
      else
      begin
        EdBadge:='';
      end;

      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
      // pulisce info chiave
      Chiave:='';
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    end;

    //Estraggo Ora timbratura
    H:=StrToIntDef(Copy(S,Mappa.Ore.Posiz,Mappa.Ore.Lung),0);
    N:=StrToIntDef(Copy(S,Mappa.Minuti.Posiz,Mappa.Minuti.Lung),0);
    Sec:=0;
    if (Mappa.Secondi.Posiz > 0) and (Mappa.Secondi.Lung > 0) and
       (Mappa.Secondi.Posiz < 99) and (Mappa.Secondi.Lung < 99) then
      Sec:=StrToIntDef(Copy(S,Mappa.Secondi.Posiz,Mappa.Secondi.Lung),0);
    try
      IOra:=FormatDateTime('hhnnss',EncodeTime(H,N,Sec,0));
    except
      IOra:='000000';
    end;

    DataOraTimb:=EncodeDate(A,M,G) + EncodeTime(H,N,Sec,0);
    if NFRecupero <> '' then
    begin
      if not R180Between(DataOraTimb,DataIRecupero,DataFRecupero) then
      begin
        RegistraMsg.InserisciMessaggio('A','Timbratura del ' + FormatDateTime('DD/MM/YYYY',EncodeDate(A,M,G)) + ' esterna al periodo indicato.');
        Abort;
      end;
    end;

    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    if Mappa.UtilizzaChiave then
    begin
      // estrazione del progressivo data la chiave alternativa al badge
      Lst:=TStringList.Create;
      try
        Lst:=FindVariables(Mappa.ExprChiave,False); // non considera i duplicati
        Lst.CaseSensitive:=False;
        with selChiave do
        begin
          // se l'espressione contiene la variabile :DATA la dichiara
          if (Lst.IndexOf('Data') > -1) and
             (VariableIndex('Data') = -1) then
          begin
            DeclareVariable('Data',otDate);
          end;
          Close;
          SQL.Text:=Mappa.ExprChiave;

          // imposta le variabili
          SetVariable('Chiave',Chiave);
          if VariableIndex('Data') > -1 then
            SetVariable('Data',EncodeDate(A,M,G));
          try
            Open;
          except
            on E:Exception do
            begin
              RegistraMsg.InserisciMessaggio('A',E.Message);
              Writeln(TFAnomalie,S);
              exit;
            end;
          end;

          if RecordCount = 0 then
            //Se non esiste il movimento storico registro la timbratura sui
            //residui e passo alla successiva
            Abort;
        end;
      finally
        FreeAndNil(Lst);
      end;
    end
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    else
    begin
      // estrazione del progressivo per associazione con badge
      with Q430 do
      begin
        Close;
        SetVariable('Data',EncodeDate(A,M,G));
        SetVariable('DataOra',EncodeDateTime(A,M,G,H,N,Sec,0));
        SetVariable('Badge',FloatToStr(StrToFloat(Badge))); // daniloc. 13.01.2014 - verificare: la variabile Badge è numerica!
        try
          Open;
        except
          on E:Exception do
          begin
            RegistraMsg.InserisciMessaggio('A',E.Message);
            Writeln(TFAnomalie,S);
            exit;
          end;
        end;
        if RecordCount = 0 then
          //Se non esiste il movimento storico registro la timbratura sui
          //residui e passo alla successiva
          Abort;
      end;
      //Controllo l'edizione del badge se significativa e se il badge non è di servizio EDBADGE='BS'
      if (Edbadge <> '') and (Q430.FieldByName('EdBadge').AsString <> 'BS') then
      begin
        with TStringList.Create do
        try
          Clear;
          CommaText:=Q430.FieldByName('EdBadge').AsString;
          if IndexOf(Trim(EdBadge)) < 0 then
            Abort;
        finally
          Free; // memory leak
        end;
      end;
    end;
//============================================================================
//SE CAMPO FUNZIONE E' <> "E" LE TIMBR SONO O TUTTE "P"(PRESENZA) O "M"(MENSA)
//============================================================================
    Pres:=True; //per default sono timbrature di presenza
    Mensa:=False;
    if QI100.FieldByName('FUNZIONE').AsString = 'E' then
    begin
      if Q361.Locate('Codice',Trim(IRilev),[]) then
      begin
        if Q361.FieldByName('Funzione').AsString = 'M' then
        //Timbratura solo di mensa
        begin
          Pres:=False;
          Mensa:=True;
        end
        else
        //Timbratura sia di Presenza che di mensa
        if Q361.FieldByName('Funzione').AsString = 'E' then
        begin
          if Q361.FieldByName('CausMensa').IsNull then
            Mensa:=True
          else if Trim(Causale) = Q361.FieldByName('CausMensa').AsString then
          begin
            Pres:=False;
            Mensa:=True;
          end
          else
          begin
            Pres:=True;
            Mensa:=False;
          end;
        end;
      end;
    end
    else
    begin
      if QI100.FieldByName('FUNZIONE').AsString = 'P' then
      begin
        Pres:=True;
        Mensa:=False;
      end;
      if QI100.FieldByName('FUNZIONE').AsString = 'M' then
      begin
        Pres:=False;
        Mensa:=True;
      end;
    end;
    TimbrRegistrata:=False;
    if (QI100.FieldByName('TIMB_NONTOLL_GGPREC').AsInteger >= 0) then
      InizioToll:=Trunc(R180SysDate(SessioneOracleB006)-QI100.FieldByName('TIMB_NONTOLL_GGPREC').AsInteger)
    else
      InizioToll:=EncodeDate(1900,1,1);
    if (QI100.FieldByName('TIMB_NONTOLL_GGSUCC').AsInteger >= 0) then
      FineToll:=Trunc(R180SysDate(SessioneOracleB006)+QI100.FieldByName('TIMB_NONTOLL_GGSUCC').AsInteger)
    else
      FineToll:=EncodeDate(3999,12,31);
    if (EncodeDate(A,M,G) < InizioToll) or (EncodeDate(A,M,G) > FineToll) then
    begin
      if QI100.FieldByName('TIMB_NONTOLL_LOG').AsString = 'S' then
      begin
        if QI100.FieldByName('TIMB_NONTOLL_REG').AsString = 'S' then
          RegistraMsg.InserisciMessaggio('A','Timbratura del '+FormatDateTime('DD/MM/YYYY',EncodeDate(A,M,G))+' esterna al periodo tollerato. Salvata su T103_TIMBRATURE_SCARTATE')
        else
          RegistraMsg.InserisciMessaggio('A','Timbratura del '+FormatDateTime('DD/MM/YYYY',EncodeDate(A,M,G))+' esterna al periodo tollerato.');
      end;
      if QI100.FieldByName('TIMB_NONTOLL_REG').AsString = 'S' then
      begin
        InsTimb(Q103);
        TimbrRegistrata:=True;
      end;
    end;
    if not TimbrRegistrata then
    begin
      if Pres then
      begin
        InsTimb(Q100);

        //Registro dati per allineamento timbrature successivo
        // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
        // gestione del dataset specifico nel caso di chiave alternativa al badge
        {
        if LProg.IndexOf(Q430.FieldByName('Progressivo').AsString) = -1 then
          LProg.Add(Q430.FieldByName('Progressivo').AsString);
        }
        if Mappa.UtilizzaChiave then
          Prog:=selChiave.FieldByName('Progressivo').AsString
        else
          Prog:=Q430.FieldByName('Progressivo').AsString;
        if LProg.IndexOf(Prog) = -1 then
          LProg.Add(Prog);
        // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
        if EncodeDate(A,M,G) < DataI then
          DataI:=EncodeDate(A,M,G);
        if EncodeDate(A,M,G) > DataF then
          DataF:=EncodeDate(A,M,G);
      end;
      if Mensa then
        InsTimb(Q370);
    end;
  except
    Residui:=True;
    Writeln(TFAppoggio,S);
    //Timbrature irregolari: il file utile è quello scritto dall'ultima Azienda che elabora questa parametrizzazione
    ITimb:=Format('%s\>%s\>%s\>%s\>%s\>%s\>%s\>%s\>',[IData,IBadge,IEdbadge,IOra,IVerso,IRilev,ICausale,IChiave]);
    Writeln(TFScartate,ITimb);
  end;
end;

procedure TR200FScaricoTimbratureDtM.ConvertiRigaDating(S:String);
{Esamina la riga letta dal file seq. e la riscrive togliendo la doppia riga
per la causale}
var A:Integer;
    Causale,AnnoNew,IVerso,ICausale:String;
    Uscita:Boolean;
begin
  try
    Uscita:=False;
    //Estraggo verso
    IVerso:=Copy(S,Mappa.Verso.Posiz,Mappa.Verso.Lung);
    //Gestione Scarico Dating: la causale è presente sulla riga successiva
    //con il verso = '2' (0 = E; 1 = U)
    if (TimbDating <> '') and (IVerso <> QI100.FieldByName('Entrata').AsString) and (IVerso <> QI100.FieldByName('Uscita').AsString) then
    begin
      //Estraggo Causale con le stesse coordinate del Badge
      Causale:=Copy(S,Mappa.Badge.Posiz,Mappa.Badge.Lung);
      ICausale:=Copy(Causale + '     ',1,Mappa.Badge.Lung);
      TimbDating:=TimbDating + ICausale;
      Uscita:=True;
    end;
    if TimbDating <> '' then
    begin
      Writeln(TFAppoggio,TimbDating);
      TimbDating:='';
      if Uscita then
        exit;
    end;
    //Estraggo la data ed aumento l'anno di 80: l'anno è di due cifre - 80 (es. 1996 --> 16)
    A:=StrToIntDef(Copy(S,Mappa.Anno.Posiz,Mappa.Anno.Lung),0);
    Delete(S,Mappa.Anno.Posiz,Mappa.Anno.Lung);
    AnnoNew:=Copy(IntToStr(A + QI100.FieldByName('Offset_Anno').AsInteger),3,2);
    Insert(AnnoNew,S,Mappa.Anno.Posiz);
    TimbDating:=S;
  except
  end;
end;

procedure TR200FScaricoTimbratureDtM.AllineaTimbrature;
var i:Integer;
    A023:TA023FAllTimbMW;
begin
  A023:=TA023FAllTimbMW.Create(nil);
  with A023 do
  begin
    try
      Q100.Session:=DbScarico;
      Q100Upd.Session:=DbScarico;
      for i:=0 to LProg.Count - 1 do
        Allinea(StrToInt(LProg[i]),DataI,DataF);
    finally
      Free;
    end;
  end;
end;

procedure TR200FScaricoTimbratureDtM.RegistraTimbIrregolari(S:String);
{Registrazione timbrature irregolari su I101_TIMBIRREGOLARI
 S = IData\>IBadge\>IEdbadge\>IOra\>IVerso\>IRilev\>ICausale\>IChiave\>
}
var
  i,A,M,G,H,N,Sec,X:Integer;
  SS:String;
  IData,IBadge,IEdbadge,IOra,IVerso,IRilev,ICausale,IChiave:String;
begin
  i:=0;
  while Pos('\>',S) > 0 do
  begin
    inc(i);
    SS:=Copy(S,1,Pos('\>',S) - 1);
    case i of
      1:IData:=SS;
      2:IBadge:=SS;
      3:IEdBadge:=SS;
      4:IOra:=SS;
      5:IVerso:=SS;
      6:IRilev:=SS;
      7:ICausale:=SS;
      8:IChiave:=SS;
    end;
    S:=Copy(S,Pos('\>',S) + 2,Length(S));
  end;

  A:=StrToIntDef(Copy(IData,1,4),0);
  M:=StrToIntDef(Copy(IData,5,2),1);
  G:=StrToIntDef(Copy(IData,7,2),1);
  H:=StrToIntDef(Copy(IOra,1,2),0);
  N:=StrToIntDef(Copy(IOra,3,2),0);
  Sec:=StrToIntDef(Copy(IOra,5,2),0);
  for X:=1 to Length(Trim(IBadge)) do
  begin
    if not R180IsDigit(Trim(IBadge),X) then
      exit;
  end;
  with QI101 do
  begin
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    // pulisce variabili per inserimento
    ClearVariables;
    SetVariable('Badge',StrToFloatDef(IBadge.Trim,0));
    SetVariable('EdBadge',IEdBadge.Trim);
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    SetVariable('Data',EncodeDate(A,M,G));
    SetVariable('Ora',EncodeDate(1900,1,1) + EncodeTime(H,N,Sec,0));
    SetVariable('Verso',IVerso);
    SetVariable('Rilev',IRilev.Trim);
    SetVariable('Causale',ICausale.Trim);
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    // estrae il dato chiave in alternativa al badge
    SetVariable('Chiave',IChiave.Trim);  // trim?? la causale non è trimmata!
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    SetVariable('Aziende',QI100.FieldByName('AZIENDE').AsString);
    SetVariable('Funzione',QI100.FieldByName('FUNZIONE').AsString);
    SetVariable('Scarico',QI100.FieldByName('SCARICO').AsString);
    Execute;
  end;
  SessioneOracleB006.Commit;
end;

procedure TR200FScaricoTimbratureDtM.selI102ORAValidate(Sender: TField);
begin
 if not Sender.IsNull then
   R180OraValidate(Sender.Asstring);
end;

procedure TR200FScaricoTimbratureDtM.Q100BeforeQuery(Sender: TOracleQuery);
{Esecuzione della procedura Oracle TIMB_TRIGGER_BEFORE prima dell'acquisizione}
var MsgOra:TDateTime;
begin
  if QI100.FieldByName('TRIGGER_BEFORE').AsString = 'S' then
    with scrTIMB_TRIGGER_BEFORE do
    try
      SetVariable('PROGRESSIVO',Sender.GetVariable('PROGRESSIVO'));
      SetVariable('DATA',Sender.GetVariable('DATA'));
      SetVariable('ORA',Sender.GetVariable('ORA'));
      SetVariable('VERSO',Sender.GetVariable('VERSO'));
      SetVariable('CAUSALE',Sender.GetVariable('CAUSALE'));
      SetVariable('RILEVATORE',Sender.GetVariable('RILEVATORE'));
      if Sender = Q100 then
        SetVariable('TABELLA','T100')
      else
        SetVariable('TABELLA','T370');
      Execute;
      //Gestione della modifica del verso
      if GetVariable('VERSO') <> Sender.GetVariable('VERSO') then
        Sender.SetVariable('VERSO',GetVariable('VERSO'));
      //Gestione della modifica della causale
      if GetVariable('CAUSALE') <> Sender.GetVariable('CAUSALE') then
        Sender.SetVariable('CAUSALE',GetVariable('CAUSALE'));
      //Gestione della modifica del rilevatore
      if GetVariable('RILEVATORE') <> Sender.GetVariable('RILEVATORE') then
        Sender.SetVariable('RILEVATORE',GetVariable('RILEVATORE'));
      //Gestione dell'annullamento dell'operazione
      if GetVariable('VALIDA') = 'N' then
      begin
        MsgOra:=Sender.GetVariable('ORA');
        RegistraMsg.InserisciMessaggio('I',Format('Timbratura annullata: %s %s%s',[VarToStr(Sender.GetVariable('DATA')),VarToStr(Sender.GetVariable('VERSO')),FormatDateTime('hh.nn.ss',MsgOra)]),QI090.FieldByName('AZIENDA').AsString,Sender.GetVariable('PROGRESSIVO'));
        Abort;
      end;
    except
      on E:Exception do
        if E is EAbort then
          raise
        else
          RegistraMsg.InserisciMessaggio('A',E.Message);
    end;
end;

procedure TR200FScaricoTimbratureDtM.Q100AfterQuery(Sender: TOracleQuery);
{Esecuzione della procedura Oracle TIMB_TRIGGER_AFTER dopo l'acquisizione}
begin
  if QI100.FieldByName('TRIGGER_AFTER').AsString = 'S' then
    with scrTIMB_TRIGGER_AFTER do
    try
      SetVariable('PROGRESSIVO',Sender.GetVariable('PROGRESSIVO'));
      SetVariable('DATA',Sender.GetVariable('DATA'));
      SetVariable('ORA',Sender.GetVariable('ORA'));
      SetVariable('VERSO',Sender.GetVariable('VERSO'));
      SetVariable('CAUSALE',Sender.GetVariable('CAUSALE'));
      SetVariable('RILEVATORE',Sender.GetVariable('RILEVATORE'));
      if Sender = Q100 then
        SetVariable('TABELLA','T100')
      else
        SetVariable('TABELLA','T370');
      Execute;
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A',E.Message);
    end;
end;

procedure TR200FScaricoTimbratureDtM.selI102NewRecord(DataSet: TDataSet);
begin
  selI102.FieldByName('MODULO').AsString:='B006';
end;

procedure TR200FScaricoTimbratureDtM.R200FScaricoTimbratureDtMDestroy(Sender: TObject);
var i:Integer;
begin
  FreeAndNil(RegistraMsg);
  FreeAndNil(LMessaggi);
  FreeAndNil(StrLogTemp);
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  end;
  try CloseFile(TFCorrente); except end;
  try CloseFile(TFAppoggio); except end;
  try CloseFile(TFScartate); except end;
  FreeAndNil(SOB006Interna);
end;

end.
