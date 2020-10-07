unit B005UAggIris;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, StrUtils, Buttons, ExtCtrls, C180FunzioniGenerali, DBCtrls, IOUtils,
  A000Versione, A000UCostanti, A000USessione, A000UInterfaccia, Grids, DBGrids, ComCtrls,
  Oracle, Variants, IdMessage, IdBaseComponent, IdComponent, C004UParamForm,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, OracleData, Data.DB, Math;

type
  TB005FAggIris = class(TForm)
    OpenDialog1: TOpenDialog;
    StatusBar: TStatusBar;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    btnEseguiScript: TBitBtn;
    btnCreazioneProcedure: TBitBtn;
    btnInvioLog: TBitBtn;
    chkRegistra: TCheckBox;
    SaveDialog1: TSaveDialog;
    chkNoStorage: TCheckBox;
    CmbMEdp: TComboBox;
    lblFileMedp: TLabel;
    ChkRagioneSociale: TCheckBox;
    lblRagSoc: TLabel;
    lblTablespaceTabelle: TLabel;
    lblTablespaceIndici: TLabel;
    GroupBox1: TGroupBox;
    Messaggi: TMemo;
    memoTrace: TMemo;
    chkRegistraSuDB: TCheckBox;
    btnScriptsProcedure: TBitBtn;
    lblAddIrpef: TLabel;
    lstStringModuliDB: TListBox;
    lststringModuliFile: TListBox;
    lblModuliDB: TLabel;
    lblModuliFile: TLabel;
    Label8: TLabel;
    btnDBMenoFile: TSpeedButton;
    btnFileMenoDB: TSpeedButton;
    btnAggVersioneDB: TBitBtn;
    btnAccessoA008: TBitBtn;
    lblScriptSQLCustom: TLabel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    lblDatabasename: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Button2: TButton;
    Button3: TButton;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    rgpTipoAggiornamento: TRadioGroup;
    procedure chkNoStorageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure btnEseguiScriptClick(Sender: TObject);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure btnCreazioneProcedureClick(Sender: TObject);
    procedure btnInvioLogClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CmbMEdpChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnScriptsProcedureClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDBMenoFileClick(Sender: TObject);
    procedure btnFileMenoDBClick(Sender: TObject);
    procedure btnAggVersioneDBClick(Sender: TObject);
    procedure btnAccessoA008Click(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
  private
    { Private declarations }
    LogInviati:Boolean;
    lstModuliDB,lstModuliFile:TStringList;
    EsistonoSQLCustom:Boolean; // Nello schema corrente sono previsti SQL custom?
    function GestioneFileLog(NomeFileLog,Nome,Azienda,VerDB:String):String;
    function EliminaStorage(S,Par:String):String;
    procedure ScriviScriptLog;
    procedure CaricaMEDP;
    procedure OperazioniScriptsProcedure(Sender: TObject);
    procedure OperazioniEseguiScript(Sender: TObject);
    procedure OperazioniCreazioneProcedure(Sender: TObject);
  public
    { Public declarations }
    TSL,TSI:String;
    procedure GetScript;
    procedure GetModuliDB;
    procedure CheckAddIrpef;
    procedure CheckSQLCustom;
  end;

var
  B005FAggIris: TB005FAggIris;

implementation

uses B005UAggIrisDtM1, B005UInvioEMail;

{$R *.DFM}

procedure TB005FAggIris.FormCreate(Sender: TObject);
begin
  LogInviati:=False;
  lstModuliDB:=TStringList.Create;
  lstModuliFile:=TStringList.Create;
  Caption:=Format('<B005> Aggiornamento base dati - versione %s(%s)',[VersionePA,BuildPA]);
end;

procedure TB005FAggIris.CaricaMEDP;
var F:TSearchRec;
begin
  if FindFirst('*_MEDP.ini',faAnyFile,F) = 0 then
  begin
    CmbMEdp.Items.Add(F.Name);
    while FindNext(F) = 0 do
      CmbMEdp.Items.Add(F.Name);
  end;
  CmbMEdp.ItemIndex:=0;
end;

procedure TB005FAggIris.FormShow(Sender: TObject);
begin
  Edit1.Text:=ExtractFilePath(Application.ExeName) + 'SQL\';
  btnAggVersioneDB.Visible:=Parametri.Operatore = 'MONDOEDP';
  btnAccessoA008.Visible:=Parametri.Operatore = 'MONDOEDP';
  lblDatabaseName.Caption:='Connessione al database: ' + B005FAggIrisDtM1.DBAggIris.LogonDatabase;
  OpenDialog1.InitialDir:=Edit1.Text;
  B005FAggIrisDtM1.Q090.Locate('Azienda','AZIN',[]);
  B005FAggIrisDtM1.selI090AfterScroll(nil);
  B005FAggIrisDtM1.Q090.AfterScroll:=B005FAggIrisDtM1.selI090AfterScroll;
  chkRegistra.Checked:=False;
  chkNoStorage.Checked:=False;
  try
    CreaC004(B005FAggIrisDtM1.DBAggIris,'B005',Parametri.Operatore);
    //try chkRegistra.Checked:=C004FParamForm.GetParametro('REGISTRA','N') = 'S'; except end;
    chkNoStorage.OnClick:=nil;
    try chkNoStorage.Checked:=C004FParamForm.GetParametro('NOSTORAGE','N') = 'S'; except end;
    chkNoStorage.OnClick:=chkNoStorageClick;
    //C004FParamForm.Cancella001;
    B005FAggIrisDtM1.DBAggIris.Commit;
  except
  end;
//==========================================================
//CARICAMENTO DEI FILE MEDP PRESENTI NELLA CARTELLA IRISWIN
//==========================================================
  CaricaMEDP;
  CmbMEdpChange(nil);
  chkRegistraSuDB.Checked:=Parametri.Operatore <> 'MONDOEDP';
//==========================================================
// GC 29/08/19 - Imposta default per selezione aggiornamento
// Azienda Selezionata. (N.B: Solo 1° volta -> ItemIndex=-1)
//==========================================================
  rgpTipoAggiornamento.ItemIndex:=0;
end;

procedure TB005FAggIris.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit1.Text:=ExtractFilePath(OpenDialog1.FileName);
    GetScript;
  end;
//==========================================================
//CARICAMENTO DEI FILE MEDP PRESENTI NELLA CARTELLA IRISWIN
//==========================================================
  CaricaMEDP;  
end;

procedure TB005FAggIris.GetScript;
var F:TSearchRec;
    i:Integer;
begin
  B005FAggIrisDtM1.Q050.Close;
  try
    B005FAggIrisDtM1.Q050.Open;
  except
  end;
  ListBox1.Items.Clear;
  ListBox2.Items.Clear;
  if FindFirst(Edit1.Text + 'SQ*.SQL',$3F,F) = 0 then
  begin
    ListBox2.Items.Add(F.Name);
    while FindNext(F) = 0 do
      ListBox2.Items.Add(F.Name);
  end;
  FindClose(F);
  if B005FAggIrisDtM1.Q050.Active then
    for i:=ListBox2.Items.Count - 1 downto 0 do
      if B005FAggIrisDtM1.Q050.SearchRecord('NOME',ListBox2.Items[i],[srFromBeginning,srIgnoreCase]) then
      begin
        ListBox1.Items.Add(ListBox2.Items[i]);
        ListBox2.Items.Delete(i);
      end;
end;

procedure TB005FAggIris.CheckAddIrpef;
var EsisteAddIrpef:Boolean;
begin
  lblAddIrpef.Visible:=False;
  EsisteAddIrpef:=Pos('ADDIRPEF',ListBox2.Items.Text.ToUpper) > 0;
  if EsisteAddIrpef and (not B005FAggIrisDtM1.EsisteModulo('STIPENDI','BASE')) then
  begin
    B005FAggIrisDtM1.selCountP042.Execute;
    if B005FAggIrisDtM1.selCountP042.FieldAsInteger(0) > 0 then
      lblAddIrpef.Visible:=True;
  end;
end;

// Richiamato manualmente allo show del form e dall'evento OnScroll del dataset selI090
procedure TB005FAggIris.CheckSQLCustom;
var
  QueryT:TOracleQuery;
begin
  B005FAggIrisDtM1.selI051.Close;
  lblScriptSQLCustom.Visible:=False;
  EsistonoSQLCustom:=False;
  // Verifico che esista la tabella I051_SQL_CUSTOM. La prima volta che la modifica verrà
  // eseguita dal cliente la tabella non sarà ancora stata creata.
  QueryT:=TOracleQuery.Create(Self);
  try
    QueryT.Session:=B005FAggIrisDtM1.DbAzienda;
    QueryT.SQL.Text:='select count(*) NUM_COLONNE from COLS where TABLE_NAME = ''I051_SQL_CUSTOM''';
    QueryT.Execute;
    if QueryT.Field('NUM_COLONNE') > 0 then
    begin
      // La tabella esiste. Posso aprire il dataset che la interroga.
      B005FAggIrisDtM1.selI051.Open;
      if B005FAggIrisDtM1.selI051.RecordCount > 0 then
      begin
        B005FAggIrisDtM1.selI051.First;
        lblScriptSQLCustom.Visible:=True;
        EsistonoSQLCustom:=True;
      end;
    end;
  finally
    FreeAndNil(QueryT);
  end;
end;

procedure TB005FAggIris.GetModuliDB;
begin
  lstModuliDB.Clear;
  with B005FAggIrisDtM1.selI080 do
  begin
    First;
    while not Eof do
    begin
      lstModuliDB.Add(Format('%s: %s',[R180Decripta(FieldByName('APPLICAZIONE').AsString,14091943),R180Decripta(FieldByName('MODULO').AsString,14091943)]));
      Next;
    end;
  end;
  lblModuliDB.Caption:=Format('Moduli esistenti (%d)',[lstModuliDB.Count]);
  lstStringModuliDB.Clear;
  lstStringModuliDB.Items.AddStrings(lstModuliDB);
  lstStringModuliFile.Clear;
  lstStringModuliFile.Items.AddStrings(lstModuliFile);
  btnDBMenoFile.Down:=False;
  btnFileMenoDB.Down:=False;
end;

procedure TB005FAggIris.ListBox1DblClick(Sender: TObject);
begin
  if ListBox1.ItemIndex = -1 then exit;
  if not Button2.Enabled then exit;
  ListBox2.Items.Add(ListBox1.Items[ListBox1.ItemIndex]);
  ListBox1.Items.Delete(ListBox1.ItemIndex);
end;

procedure TB005FAggIris.ListBox2DblClick(Sender: TObject);
begin
  if ListBox2.ItemIndex = -1 then exit;
  ListBox1.Items.Add(ListBox2.Items[ListBox2.ItemIndex]);
  ListBox2.Items.Delete(ListBox2.ItemIndex);
end;

procedure TB005FAggIris.btnScriptsProcedureClick(Sender: TObject);
begin
  // richiama  "OperazioniScriptsProcedure" passando il pulsante "btnScriptsProcedure"
  OperazioniScriptsProcedure(btnScriptsProcedure);
end;

procedure TB005FAggIris.btnEseguiScriptClick(Sender: TObject);
begin
  // richiama  "OperazioniScriptsProcedure" passando il pulsante "btnEseguiScript"
  OperazioniScriptsProcedure(btnEseguiScript);
end;

procedure TB005FAggIris.btnCreazioneProcedureClick(Sender: TObject);
begin
  // richiama  "OperazioniScriptsProcedure" passando il pulsante "btnCreazioneProcedure"
  OperazioniScriptsProcedure(btnCreazioneProcedure);
end;

procedure TB005FAggIris.btnDBMenoFileClick(Sender: TObject);
var lst1,lst2:TStringList;
    i:Integer;
begin
  if btnDBMenoFile.Down then
  begin
    lst1:=lstModuliDB;
    lst2:=lstModuliFile;
    lstStringModuliDB.Items.Clear;
    for i:=0 to lst1.Count - 1 do
      if lst2.IndexOf(lst1[i]) = -1 then
        lstStringModuliDB.Items.Add(lst1[i]);
  end
  else if not btnDBMenoFile.Down then
  begin
    lstStringModuliDB.Items.Clear;
    lstStringModuliDB.Items.AddStrings(lstModuliDB);
  end;
end;

// GC 30/08/19 - Rinominato "btnScriptsProcedureClick" in "OperazioniScriptsProcedure"
procedure TB005FAggIris.OperazioniScriptsProcedure(Sender: TObject);
var Procedura, Script, Tutti: Boolean;
begin
  // Imposto esecuzione in base al Sender ricevuto
  Script:=False;
  Procedura:=False;
  Tutti:=False;

  if Sender = btnEseguiScript then
    Script:=True;
  if Sender = btnCreazioneProcedure then
    Procedura:=True;
  if Sender = btnScriptsProcedure then
    Tutti:=True;

  // Verifico la tipologia di aggiornamento scelta
  case rgpTipoAggiornamento.ItemIndex of
    // Singola azienda selezionata
    0: begin
         if Script or Tutti then
         begin
           if MessageDlg('Si sta effettuando l''aggiornamento della base dati con il seguente file: ' + CRLF + CRLF + CmbMEdp.Text + CRLF + CRLF + 'Continuare l''aggiornamento?', mtConfirmation,[mbYes,mbNo],0) = mrNo then
             Exit;
           OperazioniEseguiScript(Sender);
         end;
         if Procedura or Tutti then
           OperazioniCreazioneProcedure(Sender);
       end;
    // Tutte le aziende gestite
    1: begin
         // chiedo conferma di proseguire con l'elaborazione di massa
         if MessageDlg('Si è scelto di effettuare l''aggiornamento su TUTTE le aziende gestite. ' + CRLF + CRLF + 'Confermare l''aggiornamento?', mtConfirmation,[mbYes,mbNo],0) = mrNo then
           Exit;
         if Script or Tutti then
         begin
           if MessageDlg('Si sta effettuando l''aggiornamento della base dati con il seguente file: ' + CRLF + CRLF + CmbMEdp.Text + CRLF + CRLF + 'Continuare l''aggiornamento?', mtConfirmation,[mbYes,mbNo],0) = mrNo then
             Exit;
         end;
         // ciclo di lettura su tutti i records del dataset e per ogni azienda richiamo la procedura di aggionamento
         with B005FAggIrisDtM1 do
         begin
           Q090.First; // mi posiziono sul primo record (che è sempre AZIN)
           while not Q090.Eof do
           begin
             StatusBar.Panels[0].Text:=Format('Inizio aggiornamento dell''azienda %s',[Q090.FieldByName('AZIENDA').AsString]);
             Self.Repaint;

             if Script or Tutti then
               OperazioniEseguiScript(btnScriptsProcedure);
             if Procedura or Tutti then
               OperazioniCreazioneProcedure(btnScriptsProcedure);

             Q090.Next;
           end;
         end;
         StatusBar.Panels[0].Text:='';
         self.Repaint;
         ShowMessage('Aggiornamento eseguito per TUTTE le aziende gestite.');
       end
  else
    // Nessuna Tipologia Aggiornamento scelta
    ShowMessage('Non è stata selezionata nessuna "Tipologia di Aggiornamento"');
  end;
end;

// GC 29/08/19 - Rinominato "btnEseguiScriptClick" in "OperazioniEseguiScript"
procedure TB005FAggIris.OperazioniEseguiScript(Sender: TObject);
var i,j:Integer;
    Azienda,VerDB,S,NomeFile,FileMEDP:String;
    Eseguito:Boolean;
    F:TSearchRec;
begin
  LogInviati:=False;
  Messaggi.Lines.Clear;
  NomeFile:='';
  Eseguito:=False;
  if not chkRegistra.Checked then //LORENA 02/05/2005
    Messaggi.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'ScriptSQL.log'); //Salvataggio del file vuoto
  Screen.Cursor:=crHourGlass;
  if chkRegistra.Checked then //LORENA 02/05/2005
  begin
    //Registra gli script su file senza eseguirli sul db
    SaveDialog1.FileName:=ExtractFilePath(Application.ExeName) + 'Archivi\Temp\' + B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString + '_SCRIPT.sql';
    if SaveDialog1.Execute then
      NomeFile:=SaveDialog1.FileName
    else
      exit;
  end;
  B005FAggIrisDtM1.B005RegistraMsg.AbilitaScritturaDB:=chkRegistraSuDB.Checked;
  B005FAggIrisDtM1.B005RegistraMsg.IniziaMessaggio('B005');
  B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('I','SCRIPTS - INIZIO AGGIORNAMENTO AZIENDA ' + B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString + ' -',B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString);
  B005FAggIrisDtM1.ScriptSQL.OutputOptions:=[ooSQL,ooData,ooFeedback,ooError];
  with B005FAggIrisDtM1 do
  begin
    GrantTabelleAziende(DbAzienda.LogonUserName,NomeFile,chkRegistra.Checked,Messaggi.Lines);
    Messaggi.Lines.Clear;
  end;
  for i:=0 to ListBox2.Items.Count - 1 do
    with B005FAggIrisDtM1.ScriptSQL do
    begin
      if B005FAggIrisDtM1.Q050.SearchRecord('NOME',ListBox2.Items[i],[srFromBeginning]) then
        Continue;
      Output.Clear;
      Lines.LoadFromFile(Edit1.Text + ListBox2.Items[i]);
      if chkRegistra.Checked then //LORENA 02/05/2005
      begin
        StatusBar.Panels[1].Text:='Esecuzione di ' + ListBox2.Items[i] + '... Non interrompere!';
        Messaggi.Lines.Add('File: ' + ListBox2.Items[i]);
      end
      else
      begin
        StatusBar.Panels[1].Text:='Esecuzione di ' + ListBox2.Items[i] + '... Non interrompere!';
        Messaggi.Lines.Add('File: ' + ListBox2.Items[i]);
        R180AppendFile(ExtractFilePath(Application.ExeName) + 'ScriptSQL.log','File: ' + ListBox2.Items[i]);
      end;
      Self.Refresh;
      for j:=0 to Lines.Count - 1 do
      begin
        S:=Lines[j];
        S:=StringReplace(S,'TABLESPACE LAVORO','TABLESPACE ' + TSL,[rfIgnoreCase]);
        S:=StringReplace(S,'TABLESPACE INDICI','TABLESPACE ' + TSI,[rfIgnoreCase]);
        S:=StringReplace(S,':AZIENDA = ''AZIN''','USER = ''MONDOEDP''',[rfIgnoreCase,rfReplaceAll]);
        S:=StringReplace(S,':AZIENDA <> ''AZIN''','USER <> ''MONDOEDP''',[rfIgnoreCase,rfReplaceAll]);
        S:=StringReplace(S,':AZIENDA','''' + B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString + '''',[rfIgnoreCase,rfReplaceAll]);
        Lines[j]:=S;
      end;
      if chkNoStorage.Checked then
      begin
        Lines.Text:=EliminaStorage(Lines.Text,'STORAGE');
        Lines.Text:=EliminaStorage(Lines.Text,'PCTFREE');
        Lines.Text:=EliminaStorage(Lines.Text,'PCTUSED');
        Lines.Text:=EliminaStorage(Lines.Text,'INITRANS');
        Lines.Text:=EliminaStorage(Lines.Text,'MAXTRANS');
      end;

      if chkRegistra.Checked then  //LORENA 02/05/2005
      begin
        R180AppendFile(NomeFile,Lines.Text);
        Eseguito:=True;
      end
      else
      begin
        //Esegue effettivamente gli script sul db
        Execute;
        if pos('addirpef',NomeFile.ToLower) = 0 then
          ScriviScriptLog;
        Messaggi.Lines.AddStrings(Output);
        Eseguito:=True;
      end;
      if Eseguito then
        B005FAggIrisDtM1.RegistraNome(ListBox2.Items[i]);  //Registro gli script eseguiti in I050
      B005FAggIrisDtM1.Q050.Refresh;
    end;
  B005FAggIrisDtM1.ScriptSQL.Output.Clear;
  with B005FAggIrisDtM1 do
  begin
    GrantTabelleAziende(DbAzienda.LogonUserName,NomeFile,chkRegistra.Checked,Messaggi.Lines);
    RicompilaInvalidi;
  end;
  if Eseguito then
    for i:=0 to ListBox2.Items.Count - 1 do
    begin
      ListBox1.Items.Add(ListBox2.Items[0]);
      ListBox2.Items.Delete(0);
    end;
  Screen.Cursor:=crDefault;
  StatusBar.Panels[1].Text:='';
  with B005FAggIrisDtM1.Q090 do
  begin
    Azienda:=FieldByName('AZIENDA').AsString;
    B005FAggIrisDtM1.Q090.AfterScroll:=nil;
    Refresh;
    SearchRecord('AZIENDA',Azienda,[srFromBeginning]);
    B005FAggIrisDtM1.Q090.AfterScroll:=B005FAggIrisDtM1.selI090AfterScroll;
    B005FAggIrisDtM1.selI090AfterScroll(nil);
    if B005FAggIrisDtM1.Q090 = B005FAggIrisDtM1.selI090 then
      VerDB:=StringReplace(FieldByName('VERSIONEDB').AsString,'.','',[rfReplaceAll])
    else
      VerDB:='';
  end;
  B005FAggIrisDtM1.ScriptSQL.Output.Clear;
  //DAVIDE: cancellazione della tabella I080_MODULI per l'azienda AZIN utente MONDOEDP
  with B005FAggIrisDtM1 do
  begin
    //if DbAzienda.LogonUserName = 'MONDOEDP' then
    begin
      ScriptSQL.Lines.Clear;
      ScriptSQL.Lines.Add('DELETE FROM MONDOEDP.I080_MODULI WHERE AZIENDA = ''' + UpperCase(Azienda) +''';');
      ScriptSQL.OutputOptions:=[ooData,ooError];
      ScriptSQL.Execute;
      ScriviScriptLog;
      Messaggi.Lines.AddStrings(ScriptSQL.Output);
      ScriptSQL.Output.Clear;
      Messaggi.Lines.Add('Disattivazione moduli...');
      ScriptSQL.Lines.Clear;
      ScriptSQL.OutputOptions:=[ooSQL,ooData,ooFeedback,ooError];
      //Eliminazione dei vecchi files MEDPxxx.sql
      if FindFirst('*_MEDP*.sql',faAnyFile,F) = 0 then
        repeat
          if Pos('_MEDP.ini',UpperCase(F.Name)) = 0 then
            DeleteFile(F.Name);
        until FindNext(F) <> 0;
      FindClose(F);

      FileMEDP:=CmbMEDP.Text;
      if Not FileExists(CmbMEDP.Text) then
        FileMEDP:='*_MEDP.ini';

      //Allineamento Ragione sociale e moduli installati dallo script _MEDPxxx.sql
      if FindFirst(FileMEDP,faAnyFile,F) = 0 then
      try
        Screen.Cursor:=crHourGlass;
        ScriptSQL.Lines.LoadFromFile(F.Name);
        for i:=0 to ScriptSQL.Lines.Count - 1 do
        begin
          ScriptSQL.Lines[i]:=StringReplace(ScriptSQL.Lines[i],'(APPLICAZIONE,MODULO) VALUES (',
                                            '(AZIENDA,APPLICAZIONE,MODULO) VALUES(''' + UpperCase(Azienda) + ''',',
                                            [rfIgnoreCase,rfReplaceAll]);
          if pos('RAGIONE_SOCIALE',ScriptSQL.Lines[i]) > 0 then
          begin
            ScriptSQL.Lines[i]:=StringReplace(ScriptSQL.Lines[i],'WHERE RAGIONE_SOCIALE IS NULL','WHERE AZIENDA = ''' + AZIENDA + '''',[rfIgnoreCase,rfReplaceAll]);
            if not ChkRagioneSociale.Checked then
              ScriptSQL.Lines[i]:='';
          end;
        end;
        //Ricerca della versione:
        if (R180Decripta(Copy(ScriptSQL.Lines[0],3,80),14091943) = VerDB) or (VerDB = '') then
        begin
          ScriptSQL.ScanVariables:=False;
          ScriptSQL.Execute;
          ScriptSQL.ScanVariables:=True;
          Messaggi.Lines.Add('Attivazione moduli...');
        end
        else
          Messaggi.Lines.Add('Attenzione! versione del MEDP.ini non corrispondente, moduli disattivati!');
        //DeleteFile(F.Name);
      finally
        Screen.Cursor:=crDefault;
      end
      else
        Messaggi.Lines.Add('Attenzione! MEDP.ini non trovato, moduli disattivati!');
    end;
    FindClose(F);

    //Applicazione password di MONDOEDP:
    with ScriptSQL do
    begin
      Lines.Clear;
      Lines.Add(Format('UPDATE I070_UTENTI SET PASSWD = ''%s'', DATA_PW = trunc(sysdate), DATA_ACCESSO = trunc(sysdate) WHERE UTENTE = ''MONDOEDP'';',[R180CriptaI070('AMLETO' + StringReplace(VersionePA,'.','',[]) + BuildPA)]));
      Execute;
    end;

    ScriptSQL.Output.Clear;
    with ScriptSQL.Lines do
    begin
      Clear;
      //Add('SELECT ''<T430COUNT><' + ScriptSQL.Session.LogonUsername + '>[' + Azienda + '](''||COUNT(DISTINCT PROGRESSIVO)||'')'' T430COUNT FROM T430_STORICO WHERE SYSDATE BETWEEN INIZIO AND NVL(FINE,SYSDATE);');
      Add('SELECT ''<T430COUNT><' + ScriptSQL.Session.LogonUsername + '>[' + Azienda + '](''||COUNT(*)||'')'' T430COUNT');
      Add('FROM T030_ANAGRAFICO T030, T430_STORICO T430');
      Add('WHERE  T030.PROGRESSIVO = T430.PROGRESSIVO');
      Add('AND    TRUNC(SYSDATE) BETWEEN T430.DATADECORRENZA AND T430.DATAFINE');
      Add('AND    TRUNC(SYSDATE) BETWEEN T430.INIZIO AND NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY''))');
      Add('AND    T030.TIPO_PERSONALE <> ''E''');
      Add('AND    (EXISTS (SELECT ''X'' FROM T100_TIMBRATURE T100');
      Add('                WHERE  T100.PROGRESSIVO = T030.PROGRESSIVO');
      Add('                AND    T100.DATA > TRUNC(SYSDATE) - 30)');
      Add('        OR');
      Add('        EXISTS (SELECT ''X'' FROM T040_GIUSTIFICATIVI T040');
      Add('                WHERE  T040.PROGRESSIVO = T030.PROGRESSIVO');
      Add('                AND    T040.DATA > TRUNC(SYSDATE) - 90)');
      Add('        OR');
      Add('        EXISTS (SELECT ''X'' FROM P441_CEDOLINO P441');
      Add('                WHERE  P441.PROGRESSIVO = T030.PROGRESSIVO');
      Add('                AND    P441.DATA_CEDOLINO > TRUNC(SYSDATE) - 60));');
    end;
    ScriptSQL.OutputOptions:=[ooData,ooError];
    ScriptSQL.Execute;
    ScriviScriptLog;
    Messaggi.Lines.AddStrings(ScriptSQL.Output);
    //
    ScriptSQL.Output.Clear;
    with ScriptSQL.Lines do
    begin
      Clear;
      //Add('SELECT ''<T430COUNT><' + ScriptSQL.Session.LogonUsername + '>[' + Azienda + '](''||COUNT(DISTINCT PROGRESSIVO)||'')'' T430COUNT FROM T430_STORICO WHERE SYSDATE BETWEEN INIZIO AND NVL(FINE,SYSDATE);');
      Add('SELECT ''<T430COUNTALL><' + ScriptSQL.Session.LogonUsername + '>[' + Azienda + '](''||COUNT(*)||'')'' T430COUNTALL');
      Add('FROM T030_ANAGRAFICO T030, T430_STORICO T430');
      Add('WHERE  T030.PROGRESSIVO = T430.PROGRESSIVO');
      Add('AND    TRUNC(SYSDATE) BETWEEN T430.DATADECORRENZA AND T430.DATAFINE');
      Add('AND    T030.TIPO_PERSONALE <> ''E''');
      Add('AND    (EXISTS (SELECT ''X'' FROM T100_TIMBRATURE T100');
      Add('                WHERE  T100.PROGRESSIVO = T030.PROGRESSIVO)');
      Add('        OR');
      Add('        EXISTS (SELECT ''X'' FROM T040_GIUSTIFICATIVI T040');
      Add('                WHERE  T040.PROGRESSIVO = T030.PROGRESSIVO))');
    end;
    ScriptSQL.OutputOptions:=[ooData,ooError];
    ScriptSQL.Execute;
    ScriviScriptLog;
    Messaggi.Lines.AddStrings(ScriptSQL.Output);
    //
    ScriptSQL.Output.Clear;
    ScriptSQL.Lines.Clear;
    ScriptSQL.Lines.Add('SELECT ''<VERSIONEDB>'' || BANNER VERSIONEDB FROM V$VERSION WHERE UPPER(BANNER) LIKE(''%ORACLE%'')');
    ScriptSQL.OutputOptions:=[ooData,ooError];
    try
      ScriptSQL.Execute;
    except end;
    ScriviScriptLog;
    Messaggi.Lines.AddStrings(ScriptSQL.Output);
    ScriptSQL.Output.Clear;
    ScriptSQL.Lines.Clear;
    ScriptSQL.Lines.Add('SELECT ''<NLS_CHARACTERSET>'' || VALUE FROM NLS_DATABASE_PARAMETERS WHERE PARAMETER = (''NLS_CHARACTERSET'');');
    ScriptSQL.OutputOptions:=[ooData,ooError];
    try
      ScriptSQL.Execute;
    except end;
    ScriviScriptLog;
    Messaggi.Lines.AddStrings(ScriptSQL.Output);
    ScriptSQL.Output.Clear;
    ScriptSQL.OutputOptions:=[ooSQL,ooData,ooFeedback,ooError];
  end;
  B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('I','SCRIPTS - FINE AGGIORNAMENTO AZIENDA ' + B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString + ' -',B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString);
  B005FAggIrisDtM1.DbAzienda.LogonUserName:='';

  if Eseguito and chkRegistra.Checked and (Sender = btnEseguiScript) then    //LORENA 02/05/2005
    ShowMessage('Script salvati in ' + NomeFile)
  else
  begin
    NomeFile:=GestioneFileLog(ExtractFilePath(Application.ExeName) + 'ScriptSQL.log','Script',Azienda,VerDB);
    memoTrace.Lines.Add(Format('%s - Scripts',[Azienda]));
    if rgpTipoAggiornamento.ItemIndex = 0 then
    begin
      if Sender = btnEseguiScript then
        ShowMessage('Aggiornamento terminato.' + #13 + 'Log salvato in ' + NomeFile);
    end;
  end;
  if rgpTipoAggiornamento.ItemIndex = 0 then
  begin
    if (Parametri.Operatore <> 'MONDOEDP') and (Sender = btnEseguiScript) then
      ShowMessage('Ricordarsi di leggere e distribuire il file contenente le note alla versione:' + #13 + ExtractFilepath(Application.ExeName) + 'Help\IrisWIN_note.doc');
  end;
end;

// GC 29/08/19 - Rinominato "btnCreazioneProcedureClick" in "OperazioniCreazioneProcedure"
procedure TB005FAggIris.OperazioniCreazioneProcedure(Sender: TObject);
var i,j:integer;
    Azienda,VerDB,NomeFile,EsitoProcCustom:String;
    Eseguito,EseguitoFase2:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  Messaggi.Lines.Clear;
  NomeFile:='';
  Eseguito:=False;
  EseguitoFase2:=False;
  B005FAggIrisDtM1.ScriptSQL.OutputOptions:=[ooSQL,ooFeedback,ooError];
  with TStringList.Create do
  try
    LoadFromFile(ExtractFilePath(Application.ExeName) + 'ProcSQL/PROCIRIS.SQL');
    if chkRegistra.Checked then //LORENA 02/05/2005
    begin
      //Registra gli script su file senza eseguirli sul db
      SaveDialog1.FileName:=ExtractFilePath(Application.ExeName) + 'Archivi\Temp\' + B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString + '_PROC.sql';
      if SaveDialog1.Execute then
        NomeFile:=SaveDialog1.FileName;
    end;
    B005FAggIrisDtM1.B005RegistraMsg.AbilitaScritturaDB:=chkRegistraSuDB.Checked;
    B005FAggIrisDtM1.B005RegistraMsg.IniziaMessaggio('B005');
    B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('I','PROC - INIZIO AGGIORNAMENTO AZIENDA ' + B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString + ' -',B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString);
    B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('I','PROC - FASE 1/2 - ESECUZIONE SCRIPT PROCEDURE STANDARD');
    for i:=0 to Count - 1 do
    begin
      if Pos('@',Strings[i]) = 1 then
      begin
        B005FAggIrisDtM1.ScriptSQL.Output.Clear;
        try
          B005FAggIrisDtM1.ScriptSQL.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'ProcSQL/' + StringReplace(StringReplace(Strings[i],'@','',[]),';','',[]));
          if chkRegistra.Checked then //LORENA 02/05/2005
          begin
            if Trim(NomeFile) <> '' then
            begin
              StatusBar.Panels[1].Text:='Esecuzione di ' + StringReplace(StringReplace(Strings[i],'@','',[]),';','',[]) + '...';
              R180AppendFile(NomeFile,B005FAggIrisDtM1.ScriptSQL.Lines.Text);
              Eseguito:=True;
            end;
          end
          else
          begin
            StatusBar.Panels[1].Text:='Esecuzione di ' + StringReplace(StringReplace(Strings[i],'@','',[]),';','',[]) + '...';
            B005FAggIrisDtM1.ScriptSQL.Execute;
            Eseguito:=True;
          end;
          if Eseguito then
          begin
            Messaggi.Lines.Add(StringReplace(StringReplace(Strings[i],'@','',[]),';','',[]));
            Messaggi.Lines.AddStrings(B005FAggIrisDtM1.ScriptSQL.Output);
            {Se riscontro un errore all'interno dello script registro su database}
            {Se trovo /*--NOLOG--*/ all'interno dello script non registro su database}
            if (pos('ORA-',B005FAggIrisDtM1.ScriptSQL.Output.Text) > 0) and
               (pos('/*--NOLOG--*/',B005FAggIrisDtM1.ScriptSQL.Output.Text) <= 0) then
            begin
              for j:=0 to B005FAggIrisDtM1.ScriptSQL.Output.Count - 1 do
              begin
                if not B005FAggIrisDtM1.ScriptSQL.Output[j].IsEmpty then
                  B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('A','PROC - ' + Copy(B005FAggIrisDtM1.ScriptSQL.Output[j],1,990),B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString);
              end;
            end;
          end;
        except
        end;
        Self.Repaint;
      end;
    end;

    B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('I','PROC - FASE 1/2 - FINE - ESECUZIONE SCRIPT PROCEDURE STANDARD');
    try
      CheckSQLCustom;
      if EsistonoSQLCustom then
      begin
        B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('I','PROC - FASE 2/2 - ESECUZIONE SCRIPT PROCEDURE PERSONALIZZATE (DB)');
        while not B005FAggIrisDtM1.selI051.Eof do
        begin
          try
            EsitoProcCustom:='';
            Messaggi.Lines.Add('Custom: ' + B005FAggIrisDtM1.selI051.FieldByName('NOME').AsString);
            B005FAggIrisDtM1.ScriptSQL.Lines.Clear;
            B005FAggIrisDtM1.ScriptSQL.Output.Clear;
            B005FAggIrisDtM1.ScriptSQL.Lines.Text:=B005FAggIrisDtM1.selI051.FieldByName('SCRIPT_SQL').AsString;
            StatusBar.Panels[1].Text:='Esecuzione script custom: ' + B005FAggIrisDtM1.selI051.FieldByName('NOME').AsString + '...';
            if chkRegistra.Checked then
              R180AppendFile(NomeFile,B005FAggIrisDtM1.ScriptSQL.Lines.Text)
            else
              B005FAggIrisDtM1.ScriptSQL.Execute;
            Messaggi.Lines.AddStrings(B005FAggIrisDtM1.ScriptSQL.Output);
            {Se riscontro un errore all'interno dello script registro su database}
            {Se trovo /*--NOLOG--*/ all'interno dello script non registro su database}
            if (pos('ORA-',B005FAggIrisDtM1.ScriptSQL.Output.Text) > 0) and
               (pos('/*--NOLOG--*/',B005FAggIrisDtM1.ScriptSQL.Output.Text) <= 0) then
            begin
              for j:=0 to B005FAggIrisDtM1.ScriptSQL.Output.Count - 1 do
              begin
                if pos('ORA-',B005FAggIrisDtM1.ScriptSQL.Output[j]) > 0 then
                  EsitoProcCustom:=B005FAggIrisDtM1.ScriptSQL.Output[j]; // ultima linea contenente un codice di errore

                if not B005FAggIrisDtM1.ScriptSQL.Output[j].IsEmpty then
                  B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('A',
                    'PROC Custom ' + B005FAggIrisDtM1.selI051.FieldByName('NOME').AsString + ' - ' + Copy(B005FAggIrisDtM1.ScriptSQL.Output[j],1,990),
                    B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString);
              end;
            end
            else
              EsitoProcCustom:='OK';
          except
            on E:Exception do
            begin
              Messaggi.Lines.Add('Errore non SQL: ' + E.Message);
              B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('A',
                'PROC Custom ' + B005FAggIrisDtM1.selI051.FieldByName('NOME').AsString  + ' - Errore esterno all''esecuzione dello script: ' + E.Message,
                B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString);
              EsitoProcCustom:='Errore esterno allo script: ' + E.Message;
            end;
          end;
          B005FAggIrisDtM1.selI051.Edit;
          B005FAggIrisDtM1.selI051.FieldByName('DATA_ESECUZIONE').AsDateTime:=Now;
          B005FAggIrisDtM1.selI051.FieldByName('ESITO_ESECUZIONE').AsString:=EsitoProcCustom;
          B005FAggIrisDtM1.selI051.Post;
          B005FAggIrisDtM1.selI051.Next;
          Application.ProcessMessages;
        end;
        B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('I','PROC - FASE 2/2 - FINE - ESECUZIONE SCRIPT PROCEDURE PERSONALIZZATE (DB)');
      end;
      EseguitoFase2:=True; // La gestione degli script è andata bene (anche nel caso di nessuno script)
    except
      on E:Exception do
      begin
        B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('A',
          'PROC Custom  - Errore generico: ' + E.Message,
          B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString);
        Messaggi.Lines.Add('Errore non SQL durante l''esecuzione degli script personalizzati: ' + E.Message);
      end;
    end;
    B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('I','PROC - FINE AGGIORNAMENTO AZIENDA ' + B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString + ' -',B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString);
    if B005FAggIrisDtM1.DbAzienda.LogonUserName <> 'MONDOEDP' then
      B005FAggIrisDtM1.GrantTabelleAziende(B005FAggIrisDtM1.DbAzienda.LogonUserName,NomeFile,chkRegistra.Checked,Messaggi.Lines);
    with B005FAggIrisDtM1 do
    begin
      //17/12/2014 - Ricompilazione degli oggetti invalidi
      ScriptSQL.Lines.Clear;
      ScriptSQL.Output.Clear;
      ScriptSQL.Lines.Add('begin');
      ScriptSQL.Lines.Add('  DBMS_UTILITY.compile_schema(''' + selI090.FieldByName('UTENTE').AsString + ''',FALSE);');
      ScriptSQL.Lines.Add('end;');
      StatusBar.Panels[1].Text:='Ricompilazione oggetti schema ' + selI090.FieldByName('UTENTE').AsString;
      Self.Repaint;
      ScriptSQL.Execute;
      Messaggi.Lines.AddStrings(B005FAggIrisDtM1.ScriptSQL.Output);
    end;
    Self.Repaint;
  finally
    Free;
    Screen.Cursor:=crDefault;
    StatusBar.Panels[1].Text:='';
  end;
  if not chkRegistra.Checked and (Eseguito and EseguitoFase2) then
    Messaggi.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'ProcSQL.log');
  Azienda:=B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString;
  if B005FAggIrisDtM1.Q090 = B005FAggIrisDtM1.selI090 then
    VerDB:=StringReplace(B005FAggIrisDtM1.Q090.FieldByName('VERSIONEDB').AsString,'.','',[rfReplaceAll])
  else
    VerDB:='';
  if Eseguito and EseguitoFase2 then
  begin
    if chkRegistra.Checked then
    begin
      if Sender = btnCreazioneProcedure then
        ShowMessage('Procedure salvate in ' + NomeFile);
    end
    else
    begin
      NomeFile:=GestioneFileLog(ExtractFilePath(Application.ExeName) + 'ProcSQL.log','Proc',Azienda,VerDB);
      memoTrace.Lines.Add(Format('%s - Procedure',[Azienda]));
      if rgpTipoAggiornamento.ItemIndex = 0 then
      begin
        if Sender = btnCreazioneProcedure then
          ShowMessage('Procedure create.' + #13 + 'Log salvato in ' + NomeFile)
        else
          ShowMessage('Scripts eseguiti e procedure create.' + #13 + 'Inviare i log ad assistenza@mondoedp.com')
      end;
    end;
  end;
end;

procedure TB005FAggIris.btnFileMenoDBClick(Sender: TObject);
var lst1,lst2:TStringList;
    i:Integer;
begin
  if btnFileMenoDB.Down then
  begin
    lst1:=lstModuliFile;
    lst2:=lstModuliDB;
    lstStringModuliFile.Items.Clear;
    for i:=0 to lst1.Count - 1 do
      if lst2.IndexOf(lst1[i]) = -1 then
        lstStringModuliFile.Items.Add(lst1[i]);
  end
  else if not btnFileMenoDB.Down then
  begin
    lstStringModuliFile.Items.Clear;
    lstStringModuliFile.Items.AddStrings(lstModuliFile);
  end;
end;

function TB005FAggIris.EliminaStorage(S,Par:String):String;
var S1,S2:String;
    P1,P2,P3,i:Integer;
    Trov:Boolean;
begin
  Result:='';
  S1:=S;
  P1:=Pos(Par,UpperCase(S1));
  while P1 > 0 do
  begin
    Trov:=False;
    P3:=0;
    Result:=Result + Copy(S1,1,P1 - 1);
    S1:=Copy(S1,P1,Length(S1));
    P1:=1;
    if Par = 'STORAGE' then
      P2:=Pos('(',S1)
    else
      P2:=Pos(' ',S1);
    if P2 > 0 then
    begin
      if Par = 'STORAGE' then
      begin
        S2:=StringReplace(Copy(S1,1,P2),' ','',[rfReplaceAll]);
        S2:=StringReplace(S2,#13,'',[rfReplaceAll]);
        S2:=StringReplace(S2,#10,'',[rfReplaceAll]);
        if UpperCase(S2) = 'STORAGE(' then
        begin
          P3:=Pos(')',S1);
          if P3 > 0 then
            Trov:=True;
        end;
      end
      else
      begin
        for i:=P2 + 1 to P2 + 10 do
          if S1[i] in [' ',';',#10,#13] then
          begin
            Trov:=True;
            if S1[i] = ';' then
              P3:=i - 1
            else if (S1[i] = #13) and (S1[i + 1] = #10)then
              P3:=i + 1
            else
              P3:=i;
            Break;
          end;
      end;
    end;
    if Trov then
      S1:=Copy(S1,P3 + 1,Length(S1))
    else
    begin
      Result:=Result + Copy(S1,1,P1 + Length(Par) - 1);
      S1:=Copy(S1,P1 + 7,Length(S1));
    end;
    P1:=Pos(Par,UpperCase(S1));
  end;
  Result:=Result + S1;
end;

procedure TB005FAggIris.ScriviScriptLog;
var
  j:integer;
begin
  with B005FAggIrisDtM1.ScriptSQL do
  begin
    j:=0;
    while j <= Output.Count - 1 do
    begin
      if (Pos('INSERT INTO T480_COMUNI',Output[j]) = 0) and (Pos('UPDATE T480_COMUNI',Output[j]) = 0) then
      begin
        R180AppendFile(ExtractFilePath(Application.ExeName) + 'ScriptSQL.log',Output[j]);
        if not Output[j].IsEmpty then
        begin
          if (pos(' ORA-', ' ' + Output[j]) > 0) then
            B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('A','SCRIPT - ' + Copy(Output[j],1,990),B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString)
          else
            B005FAggIrisDtM1.B005RegistraMsg.InserisciMessaggio('I','SCRIPT - ' + Copy(Output[j],1,990),B005FAggIrisDtM1.Q090.FieldByName('AZIENDA').AsString);
        end;
        inc(j);
      end
      else
        inc(j,4);
    end;
  end;
end;

procedure TB005FAggIris.Splitter1Moved(Sender: TObject);
begin
  Panel2.Height:=max(Panel2.Height,209);
end;

function TB005FAggIris.GestioneFilelog(NomeFileLog,Nome,Azienda,VerDB:String):String;
var FileLogIn,FileLogOut:TextFile;
    F:TSearchRec;
    S,NomeFile,FileSearch:String;
begin
  //Salvataggio di ScriptSQL (o ProcSQL) in Script_AZIENDA_xxx.log o (Proc_AZIENDA_xxx.log)
  NomeFile:=ExtractFilePath(Application.ExeName) + Format('%s_%s_%s.log',[Nome,Azienda,VerDB]);
  Result:=NomeFile;
  AssignFile(FileLogIn,NomeFileLog);
  AssignFile(FileLogOut,NomeFile);
  if (Nome = 'Proc') and TFile.Exists(NomeFile) then
    TFile.Delete(NomeFile);
  if TFile.Exists(NomeFile) then
    Append(FileLogOut)
  else
    Rewrite(FileLogOut);
  Writeln(FileLogOut,'');
  Writeln(FileLogOut,'AGGIORNAMENTO ESEGUITO IL ' + FormatDateTime('dd/mm/yyyy hh.nn',Now));
  Writeln(FileLogOut,'');
  Reset(FileLogIn);
  while not Eof(FileLogIn) do
  begin
    Readln(FileLogIn,S);
    Writeln(FileLogOut,S);
  end;
  CloseFile(FileLogIn);
  CloseFile(FileLogOut);
  DeleteFile(NomeFileLog);
  //Cancellazione degli altri files di log non corrispondenti all'ultima versione
  FileSearch:=StringReplace(NomeFile,VerDB,'*',[]);
  if FindFirst(FileSearch,$3F,F) = 0 then
  begin
    if (ExtractFilePath(Application.ExeName) + F.Name) <> NomeFile then
      DeleteFile(ExtractFilePath(Application.ExeName) + F.Name);
    while FindNext(F) = 0 do
      if (ExtractFilePath(Application.ExeName) + F.Name) <> NomeFile then
        DeleteFile(ExtractFilePath(Application.ExeName) + F.Name);
  end;
  FindClose(F);
end;

procedure TB005FAggIris.DBLookupComboBox1CloseUp(Sender: TObject);
begin
  with B005FAggIrisDtM1 do
    begin
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
    TSL:=Q090.FieldByName('TSLAVORO').AsString;
    TSI:=Q090.FieldByName('TSINDICI').AsString;
    end;
  if Trim(TSL) = '' then
    TSL:='LAVORO';
  if Trim(TSI) = '' then
    TSI:='INDICI';
  GetScript;
end;

procedure TB005FAggIris.btnAccessoA008Click(Sender: TObject);
var
  EsitoOP:string;
begin
  EsitoOP:=B005FAggIrisDtM1.AbilitaAziendeOperatori;
  if EsitoOP.IsEmpty then
  begin
    R180MessageBox('Elaborazione terminata con correttamente.',INFORMA);
  end
  else
  begin
    R180MessageBox(Format('Errore! ' + #13#10 + '"%s"',[EsitoOP]),ERRORE);
  end;
end;

procedure TB005FAggIris.btnAggVersioneDBClick(Sender: TObject);
var
  EsitoOP:string;
begin
  EsitoOP:=B005FAggIrisDtM1.AggVersioneDB;
  if EsitoOP.IsEmpty then
  begin
    B005FAggIrisDtM1.selI090.Refresh;
    R180MessageBox('Elaborazione terminata con correttamente.',INFORMA);
  end
  else
  begin
    R180MessageBox(Format('Errore! ' + #13#10 + '"%s"',[EsitoOP]),ERRORE);
  end;
end;

procedure TB005FAggIris.btnInvioLogClick(Sender: TObject);
begin
  B005FInvioEMail:=TB005FInvioEMail.Create(nil);
  try
    B005FInvioEMail.ShowModal;
    LogInviati:=True;
  finally
    B005FInvioEMail.Release;
  end;
end;

procedure TB005FAggIris.chkNoStorageClick(Sender: TObject);
begin
  if Self.Visible and chkNoStorage.Checked then
    ShowMessage('Attenzione! Si consiglia l''attivazione di questo parametro solo se autorizzati dall''amministratore del database.');
end;

procedure TB005FAggIris.CmbMEdpChange(Sender: TObject);
var FTxt:TextFile;
    Str,A,M,V:String;
    i:Integer;
begin
  lstModuliFile.Clear;
  V:='';
  if FileExists(CmbMEdp.Text) then
  begin
    AssignFile(FTxt,CmbMEdp.Text);
    Reset(FTxt);
    while Not(Eof(FTxt)) do
    begin
      Readln(FTxt,Str);
      if Pos('RAGIONE_SOCIALE',UpperCase(Str)) > 0 then
      begin
        //Ragione sociale
        Str:=Copy(Str,Pos('RAGIONE_SOCIALE = ',UpperCase(Str)) + 19,Length(Str));
        Str:=Copy(Str,1,pos(' WHERE',UpperCase(Str))-2);
        lblRagSoc.Caption:=R180Decripta(StringReplace(Str,'''''','''',[rfReplaceAll]),14091943);
        //Break;
      end
      else if Pos('INSERT INTO',UpperCase(Str)) > 0 then
      begin
        //Moduli
        Str:=Trim(Str);
        i:=Pos('VALUES (',Str);
        if i > 0 then
        begin
          Str:=Copy(Str,i + 9,Length(Str));
          i:=Pos(''',''',Str);
          A:=Copy(Str,1,i - 1);
          M:=Copy(Str,i + 3,Length(Str));
          M:=M.Replace(''');','');
          lstModuliFile.Add(Format('%s: %s',[R180Decripta(A,14091943),R180Decripta(M,14091943)]));
        end;
      end
      else
      begin
        //Versione
        Str:=Trim(Str);
        V:=R180Decripta(Copy(Str,3,Length(Str)),14091943);
      end;
    end;
    CloseFile(FTxt);
  end;
  lblModuliFile.Caption:=Format('Moduli da installare (%d)',[lstModuliFile.Count]);
  lblFileMedp.Caption:=Format('File MEDP.ini (%s)',[V]);
  lstStringModuliDB.Clear;
  lstStringModuliDB.Items.AddStrings(lstModuliDB);
  lstStringModuliFile.Clear;
  lstStringModuliFile.Items.AddStrings(lstModuliFile);
  btnDBMenoFile.Down:=False;
  btnFileMenoDB.Down:=False;
end;

procedure TB005FAggIris.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (Parametri.Operatore <> 'MONDOEDP') and (memoTrace.Lines.Count > 0) and (not LogInviati) then
    raise Exception.Create('Prima di uscire è necessario inviare i log ad assistenza@mondoedp.com!');

  C004FParamForm.PutParametro('REGISTRA',IfThen(chkRegistra.Checked,'S','N'));
  C004FParamForm.PutParametro('NOSTORAGE',IfThen(chkNoStorage.Checked,'S','N'));
  C004FParamForm.Free;
end;

procedure TB005FAggIris.FormDestroy(Sender: TObject);
begin
  FreeAndNil(lstModuliDB);
  FreeAndNil(lstModuliFile);
end;

end.
