unit A134UAllineamentoClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali,
  Buttons, ExtCtrls, StdCtrls, ShellAPI, ComCtrls;

type
  TA134FAllineamentoClient = class(TForm)
    RdGrpApplicativi: TRadioGroup;
    Panel1: TPanel;
    BtnCreaB012: TSpeedButton;
    BtnCopiaFile: TSpeedButton;
    BtnCollegamento: TButton;
    procedure BtnCopiaFileClick(Sender: TObject);
    procedure RdGrpApplicativiClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnCreaB012Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCollegamentoClick(Sender: TObject);
  private
    { Private declarations }
    ServerPath,SelAppl:String;
  public
    { Public declarations }
  end;

var
  A134FAllineamentoClient: TA134FAllineamentoClient;
  procedure OpenA134FAllineamentoClient;

implementation

uses A134UAllineamentoClientDtm, ShlObj, ActiveX, ComObj, Registry;

{$R *.dfm}

procedure OpenA134FAllineamentoClient;
begin
  A134FAllineamentoClient:=TA134FAllineamentoClient.Create(nil);
  A134FAllineamentoClientDtm:=TA134FAllineamentoClientDtm.Create(nil);
  try
    A134FAllineamentoClient.ShowModal;
  finally
    FreeAndNil(A134FAllineamentoClient);
    FreeAndNil(A134FAllineamentoClientDtm);
  end;
end;

procedure TA134FAllineamentoClient.FormCreate(Sender: TObject);
begin
  if UpperCase(Parametri.Applicazione) = 'RILPRE' then
    RdGrpApplicativi.ItemIndex:=0
  else if UpperCase(Parametri.Applicazione) = 'PAGHE' then
    RdGrpApplicativi.ItemIndex:=1
  else if UpperCase(Parametri.Applicazione) = 'STAGIU' then
    RdGrpApplicativi.ItemIndex:=2
  else if UpperCase(Parametri.Applicazione) = 'MISTRA' then
    RdGrpApplicativi.ItemIndex:=3
  else
    RdGrpApplicativi.ItemIndex:=0;
end;

procedure TA134FAllineamentoClient.BtnCreaB012Click(Sender: TObject);
var FTxt:TextFile;
begin
  Screen.Cursor:=crHourGlass;
  if Not (FileExists(ServerPath + SelAppl)) then
  begin
    R180MessageBox('L''applicazione selezionata non è presente sul server.','ERRORE');
    Screen.Cursor:=crDefault;
    Exit;
  end;
  if ServerPath = '' then
  begin
    R180MessageBox('Parametri non trovati per l''azienda ''' + Parametri.Azienda + '''','ERRORE');
    Screen.Cursor:=crDefault;
    Exit;
  end;
  try
    AssignFile(FTxt,R180GetFilePath(Application.ExeName) + '\B012PAllineamentoClient.ini');
    Rewrite(FTxt);
    Writeln(FTxt,'Indicare dopo la parola chiave ''@EXESERVER='' il percorso dove si trova il file di allineamento versioni lato server');
    Writeln(FTxt,'Indicare dopo la parola chiave ''@EXECLIENT='' il nome del file eseguibile che si desidera lanciare sul client dopo il controllo delle versioni');
    Writeln(FTxt,'@EXESERVER=' + ServerPath + 'B011PAllineamentoServer.exe');
    Writeln(FTxt,'@EXECLIENT=' + SelAppl);
  finally
    CloseFile(FTxt);
    Screen.Cursor:=crDefault;
  end;
  R180MessageBox('File creato nel percorso ''' + R180GetFilePath(Application.ExeName) + '''','INFORMA');
end;

procedure TA134FAllineamentoClient.FormShow(Sender: TObject);
begin
  RdGrpApplicativiClick(nil);
  with A134FAllineamentoClientDtm do
  begin
    selI090.Close;
    selI090.SetVariable('PARAZIENDA',Parametri.Azienda);
    selI090.Open;
    selI090.First;
    if (selI090.FieldByName('PATHALLCLIENT').AsString = '') or
       (selI090.RecordCount <= 0) then
    begin
      BtnCreaB012.Enabled:=False;
      BtnCopiaFile.Enabled:=False;
      R180MessageBox('Parametri non trovati per l''azienda ''' + Parametri.Azienda + '''','ERRORE');
      Exit;
    end;
    ServerPath:=selI090.FieldByName('PATHALLCLIENT').AsString;
    if ServerPath[Length(ServerPath)] <> '\' then
      ServerPath:=ServerPath + '\';
    selI090.Close;
  end;
end;

procedure TA134FAllineamentoClient.RdGrpApplicativiClick(Sender: TObject);
begin
  if RdGrpApplicativi.ItemIndex = 0 then
    SelAppl:='A002PAnagrafe.exe'
  else if RdGrpApplicativi.ItemIndex = 1 then
    SelAppl:='P000PStipendi.exe'
  else if RdGrpApplicativi.ItemIndex = 2 then
    SelAppl:='S000PStatoGiuridico.exe'
  else if RdGrpApplicativi.ItemIndex = 3 then
    SelAppl:='M000PMissioni.exe';
end;

procedure TA134FAllineamentoClient.BtnCollegamentoClick(Sender: TObject);
var MyObject  :IUnknown;
    MySLink   :IShellLink;
    MyPFile   :IPersistFile;
    FileName  :String;
    Directory :String;
    WFileName :WideString;
    S,Dato    :String;
    Registro  :TRegistry;
begin
  S:=R180EstraiPercorsoFile(Application.ExeName);
  if Copy(S,Length(S),1) <> '\' then
    S:=S + '\';
  FileName:=S + 'B012PAllineamentoClient.exe';
  MyObject:=CreateComObject(CLSID_ShellLink);
  MySLink:=MyObject as IShellLink;
  MyPFile:=MyObject as IPersistFile;
  with MySLink do begin
    SetArguments(PChar(SelAppl));
    SetPath(PChar(FileName));
    SetWorkingDirectory(PChar(ExtractFilePath(FileName)));
  end;
  Directory:='';
  Registro:=TRegistry.Create;
  try
    Registro.RootKey:=HKEY_CURRENT_USER;
    Dato:='Desktop';
    Registro.OpenKeyReadOnly('Software\MicroSoft\Windows\CurrentVersion\Explorer\Shell Folders');
    if Registro.ValueExists(Dato) then
      Directory:=Registro.ReadString(Dato);
  finally
    FreeAndNil(Registro);
  end;
  if Directory <> '' then
  begin
    WFileName:=Directory + '\' + SelAppl + '.lnk';
    MyPFile.Save(PWChar(WFileName),False);
  end;
end;

procedure TA134FAllineamentoClient.BtnCopiaFileClick(Sender: TObject);
var Msg:String;
begin
  if ServerPath = '' then
  begin
    R180MessageBox('Parametri non trovati per l''azienda ''' + Parametri.Azienda + '''','ERRORE');
    Exit;
  end;
  Screen.Cursor:=crHourGlass;
  if Not (FileExists(ServerPath + SelAppl)) then
  begin
    R180MessageBox('L''applicazione selezionata non è presente sul server.','ERRORE');
    Screen.Cursor:=crDefault;
    Exit;
  end;
  Msg:='File ' + SelAppl + ' copiato correttamente nel percorso ''' + R180GetFilePath(Application.ExeName) + '''.';
  try
    CopyFile(PChar(ServerPath + 'B012PAllineamentoClient.exe'),PChar(R180GetFilePath(Application.ExeName) + '\B012PAllineamentoClient.exe'),False);
  except
    Msg:='Errore copia del file ''' + R180GetFilePath(Application.ExeName) + SelAppl + '''.';
  end;
  Screen.Cursor:=crDefault;
  R180MessageBox(Msg,'INFORMA');
end;

end.
