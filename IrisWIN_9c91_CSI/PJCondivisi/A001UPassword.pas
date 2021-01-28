unit A001UPassWord;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, DB, Registry, OracleData, OracleCI, StrUtils,
  A000UCostanti, A000USessione, A000Versione, A000UInterfaccia, A000UMessaggi,
  (*A008UAzOper,*)A008UcambioPassword,
  C180FunzioniGenerali, L021Call, Variants;

type
  TA001FPassWord = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Azienda: TEdit;
    Utente: TEdit;
    Password: TEdit;
    Label4: TLabel;
    cmbDatabase: TComboBox;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbDatabaseKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    NoCaricaDatabaseRegistro:Boolean;
    NoSalvaDatabaseRegistro:Boolean;
  end;

var
  A001FPassWord: TA001FPassWord;

implementation

uses A001UPassWordDtM1;

{$R *.DFM}

procedure TA001FPassWord.FormCreate(Sender: TObject);
begin
  NoCaricaDatabaseRegistro:=False;
  NoSalvaDatabaseRegistro:=False;
end;

procedure TA001FPassWord.BitBtn1Click(Sender: TObject);
{Controllo accesso}
var //F:TSearchRec;
    Sysdate:TDateTime;
    Registro:TRegistry;
    AuthDom:Boolean;
    S:String;
begin
with A001FPassWordDtM1 do
begin
  //Se viene inserito il carattere ?, mostro l'elenco degli alias DB
  if cmbDatabase.Text = '?' then
  begin
    Application.HintHidePause:=30000;
    cmbDatabase.ShowHint:=True;
    cmbDatabase.Hint:=Format('Path TNSNAMES:' + #13#10 + '"%s"',[TNSNames]);
    cmbDatabase.Style:=csDropDown;
    cmbDatabase.Text:=R180GetRegistro(HKEY_CURRENT_USER,'A001','Database','IRIS');
    Exit;
  end;
  cmbDatabase.Text:=Trim(cmbDatabase.Text);
  if not A001FPassWordDtM1.TestDBAlias(cmbDatabase.Text) then
  begin
    R180MessageBox(Format(A000MSG_ERR_ALIAS_DB_ERRATO,[cmbDataBase.Text]),ERRORE);
    Exit;
  end;
  InizializzazioneSessione(cmbDatabase.Text);
  (*//Allineamento Ragione sociale e moduli installati dallo script _MEDPxxx.sql
  if Parametri.Applicazione <> '' then
  begin
    if FindFirst('*_MEDP' + StringReplace(Parametri.VersionePJ,'.','',[rfReplaceAll]) + '.sql',faAnyFile,F) = 0 then
    try
      Screen.Cursor:=crHourGlass;
      scrAllineamentoVersione.Lines.LoadFromFile(F.Name);
      scrAllineamentoVersione.Lines.Insert(0,'DELETE FROM I080_MODULI;');
      scrAllineamentoVersione.Execute;
      DeleteFile(F.Name);
    finally
      Screen.Cursor:=crDefault;
    end;
    FindClose(F);
  end;*)
  with QI090 do
  begin
    Close;
    SetVariable('Azienda',Azienda.Text);
    Open;
    if RecordCount = 0 then
      raise Exception.Create('Azienda inesistente!');
  end;
  with QI070 do
  begin
    Close;
    SetVariable('Azienda',Azienda.Text);
    SetVariable('Utente',Utente.Text);
    Open;
    AuthDom:=False;
    if RecordCount = 0 then
      raise Exception.Create('Utente inesistente!');
    //(*
    //Alberto: autenticazione su dominio
    if (Utente.Text <> 'SYSMAN') and (Utente.Text <> 'MONDOEDP') and (QI090.FindField('DOMINIO_USR') <> nil) and (not QI090.FieldByName('DOMINIO_USR').IsNull) then
    begin
      //CSAutenticazioneDominio.Enter;
      try
        AuthDom:=AutenticazioneDominio(QI090.FieldByName('DOMINIO_USR').AsString, Utente.Text, Password.Text, QI090.FieldByName('DOMINIO_USR_TIPO').AsString);
      finally
        //CSAutenticazioneDominio.Leave;
      end;
      if not AuthDom and ((Password.Text = '') or (R180CriptaI070(Password.Text) <> FieldByName('PassWd').AsString)) then
        raise Exception.Create('Autenticazione sul dominio fallita!');
    end
    //Fine autenticazione su dominio
    else
    //*)
    if R180CriptaI070(Password.Text) <> FieldByName('PassWd').AsString then
      raise Exception.Create('Parola chiave errata!');

    if Parametri.Applicazione <> '' then
    begin
      if (FieldByName('Occupato').Value = 'S') and (Utente.Text <> 'SYSMAN') then
      begin
        if FieldByName('Sblocco').AsString = 'N' then
          raise Exception.Create('Operatore già occupato!')
        else
        begin
          if MessageDlg('Operatore già occupato!' + #13 + 'Utilizzarlo comunque?',
             mtConfirmation, [mbYes, mbNo], 0) = mrNo then
            Abort;
        end;
      end;
    end;
  end;
  //Abilitazione funzionalità/controlli
  with selI080 do
  try
    SetVariable('AZIENDA',Azienda.Text);
    Open;
    GeneratoreDiStampe:=GeneratoreDiStampe or R180In(Parametri.Applicazione,['PAGHE','STAGIU']) or SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Parametri.Applicazione,14091943),R180Cripta('GENERATORE_STAMPE',14091943)]),[srFromBeginning]);
    IndennitaTurno:=SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Parametri.Applicazione,14091943),R180Cripta('INDENNITA_TURNO',14091943)]),[srFromBeginning]);
    IntegrazioneFTP:=SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Parametri.Applicazione,14091943),R180Cripta('INTEGRAZIONE_ANAGRAFICA_ENGISANITA',14091943)]),[srFromBeginning]);
    CheckEutron:=SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Parametri.Applicazione,14091943),R180Cripta('EUTRON',14091943)]),[srFromBeginning]);
    VersioneDimostrativa:=SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Parametri.Applicazione,14091943),R180Cripta('VERSIONE_DIMOSTRATIVA',14091943)]),[srFromBeginning]);
    CartellinoAscii:=SearchRecord('APPLICAZIONE;MODULO',VarArrayOf([R180Cripta(Parametri.Applicazione,14091943),R180Cripta('CARTELLINO_ASCII',14091943)]),[srFromBeginning]);
    Parametri.ModuliInstallati:='';
    First;
    while not Eof do
    begin
      if R180Decripta(FieldByName('APPLICAZIONE').AsString,14091943) = IfThen(Parametri.Applicazione <> '',Parametri.Applicazione,'RILPRE') then
        Parametri.ModuliInstallati:=Parametri.ModuliInstallati + R180Decripta(FieldByName('MODULO').AsString,14091943) + #13;
      Next;
    end;
  except
  end;
  //Registrazione parametri/inibizioni su tabelle in memoria
  RegistraInibizioni;
  Parametri.AuthDom:=AuthDom;
  if Parametri.AuthDom then
    Parametri.PassOper:=Password.text;

  //Verifica se il campo ACCESSO_NEGATO è N (significa che l'accesso è valido)
  if QI070.FindField('ACCESSO_NEGATO') <> nil then
  begin
    if QI070.FieldByName('ACCESSO_NEGATO').AsString = 'S' then
    begin
      ShowMessage('Attenzione! ' +#13 +
                  'L''accesso all''applicativo è momentaneamente inibito per attività di amministrazione.' + #13 +
                  'Riprovare più tardi o contattare l''amministratore dell''applicativo.');
      exit;
    end;
  end;
  //Verifica se dall'ultimo accesso sono passati "VALID_UTENTE" mesi.In tal caso nega l'accesso
  Sysdate:=Trunc(R180Sysdate(QI090.Session));
  if QI070.FindField('DATA_ACCESSO') <> nil then
  begin
    if (Utente.Text <> 'SYSMAN') and (Utente.Text <> 'MONDOEDP') then
    begin
      if (not QI070.FieldByName('DATA_ACCESSO').IsNull) and
         (QI090.FieldByName('VALID_UTENTE').AsInteger > 0) and
         (R180AddMesi(QI070.FieldByName('DATA_ACCESSO').AsDateTime,Parametri.ValiditaUtente) <= Sysdate) then
      begin
        ShowMessage('Attenzione! E'' scaduto il periodo di validità di questo operatore. Contattare l''amministratore dell''applicativo');
        exit;
      end;
    end;
  end;
  if Parametri.Applicazione <> '' then
  begin
    with OperSQL do
    begin
      SQL.Clear;
      SQL.Add(Format('UPDATE I070_UTENTI SET OCCUPATO = ''S'' WHERE AZIENDA = ''%s'' AND UTENTE = ''%s''',[Azienda.Text,Utente.Text]));
      if selI070Utenti.FieldByName('NUM').AsInteger = 0 then
        SQL.Text:=StringReplace(SQL.Text,'I070_UTENTI','I070_OPERATORI',[rfReplaceAll,rfIgnoreCase]);
      Execute;
      SessioneMondoEDP.Commit;
    end;
  end;
  //Testa il campo NUOVA_PASSWORD per vedere se l'utente deve cambiare la password
  if QI070.FindField('NUOVA_PASSWORD') <> nil then
  begin
    if (not Parametri.AuthDom) and (Parametri.Applicazione <> '') and (QI070.FieldByName('NUOVA_PASSWORD').AsString = 'S') then
    begin
      ShowMessage('Per accedere bisogna cambiare la password!');
      OpenA008GestioneSicurezza(QI090.Session,False);
    end;
    if Parametri.Applicazione <> '' then
    begin
      with OperSQL do
      begin
        SQL.Clear;
        SQL.Add(Format('UPDATE I070_UTENTI SET NUOVA_PASSWORD = ''N'', DATA_ACCESSO = TRUNC(SYSDATE) WHERE AZIENDA = ''%s'' AND UTENTE = ''%s''',[Azienda.Text,Utente.Text]));
        if selI070Utenti.FieldByName('NUM').AsInteger = 0 then
          SQL.Text:=StringReplace(SQL.Text,'I070_UTENTI','I070_OPERATORI',[rfReplaceAll,rfIgnoreCase]);
        Execute;
        SessioneMondoEDP.Commit;
      end;
    end;
  end;
  //Verifica se password scaduta
  if (not Parametri.AuthDom) and (QI070.FindField('DATA_PW') <> nil) then
  begin
    if ((Parametri.ValiditaPassword > 0) and (R180AddMesi(QI070.FieldByName('DATA_PW').AsDateTime,Parametri.ValiditaPassword) <= Sysdate)) then
    begin
      ShowMessage('La password è scaduta! Inserirne una nuova');
      OpenA008GestioneSicurezza(QI090.Session,False);
    end;
  end;
  if not NoSalvaDatabaseRegistro then
    R180PutRegistro(HKEY_CURRENT_USER,'A001','Database',cmbDatabase.Text);
  try
    Registro:=TRegistry.Create;
    try
      Registro.RootKey:=HKEY_LOCAL_MACHINE;
      Registro.OpenKey('Software\Microsoft\HTMLHelp\1.x\ItssRestrictions',True);
      Registro.WriteInteger('MaxAllowedZone',3);
    finally
      Registro.Free;
    end;
  except
  end;
  //Segnalo se lo spazio su tablespace è inferiore alla soglia minima
  if StrToIntDef(Parametri.CampiRiferimento.C27_TablespaceFree,0) > 0 then
  begin
    with A001FPassWordDtM1 do
    begin
      selTableSpace.Close;
      selTableSpace.SetVariable('TABLESPACE','''' + QI090.FieldByName('TSLAVORO').AsString + ''',''' + QI090.FieldByName('TSINDICI').AsString + '''');
      try
        selTableSpace.Open;
        while not selTableSpace.Eof do
        begin
          if selTableSpace.FieldByName('SPAZIO_LIBERO').AsFloat < StrToFloatDef(Parametri.CampiRiferimento.C27_TablespaceFree,0) then
            S:=S + IfThen(S <> '',#13) + 'Lo spazio libero sul tablespace ' + selTableSpace.FieldByName('TABLESPACE').AsString + ' è di ' + selTableSpace.FieldByName('SPAZIO_LIBERO_STRINGA').AsString + ' MB';
          selTableSpace.Next;
        end;
      except
      end;
      if S <> '' then
      begin
        S:='Attenzione:' + #13 + S + #13 + 'Si consiglia di avvisare l''amministratore di sistema';
        ShowMessage(S);
      end;
    end;
  end;
  ModalResult:=mrOk;
  end;
end;

procedure TA001FPassWord.BitBtn2Click(Sender: TObject);
{Rinuncia accesso}
begin
  Application.Terminate;
  //Close;
end;

procedure TA001FPassWord.cmbDatabaseKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = 13 then
    BitBtn1Click(Sender);
end;

procedure TA001FPassWord.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.HintHidePause:=2500;
end;

procedure TA001FPassWord.FormShow(Sender: TObject);
begin
  R180SetOracleInstantClient;
  cmbDatabase.Style:=csSimple;
  if OracleAliasList <> nil then
  begin
    cmbDatabase.Items.Assign(OracleAliasList);
  end;
  if not NoCaricaDatabaseRegistro then
    cmbDatabase.Text:=R180GetRegistro(HKEY_CURRENT_USER,'A001','Database','IRIS');
  Azienda.SetFocus;
  if Caption = '' then
    exit;
  if Pos('IRIS',UpperCase(cmbDatabase.Text)) = 0 then
    exit;
  with A001FPassWordDtM1 do  //Lorena 06/10/2010
  try
    InizializzazioneSessione(cmbDatabase.Text);
    with OperSQL do
    begin
      SQL.Clear;
      SQL.Add('SELECT I090.AZIENDA FROM MONDOEDP.I090_ENTI I090, MONDOEDP.I091_DATIENTE I091');
      SQL.Add(' WHERE I090.AZIENDA = I091.AZIENDA');
      SQL.Add('   AND I091.TIPO = ''C24_AZIENDABUDGET''');
      SQL.Add('   AND nvl(I091.DATO,''N'') = ''N''');
      Execute;
      if RowsProcessed = 1 then
      begin
        Azienda.Text:=VarToStr(Field(0));
        Utente.SetFocus;
      end;
    end;
  except
  end;
end;

end.
