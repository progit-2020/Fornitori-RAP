unit B021UForm;

interface

uses
  SysUtils, Classes, Forms,
  IdHTTPWebBrokerBridge, Web.HTTPApp, Vcl.Controls, Vcl.StdCtrls,
  ShellAPI, Winapi.Windows, System.UITypes, System.IOUtils;

type
  TB021FForm = class(TForm)
    grpInfoServer: TGroupBox;
    lblPortaServer: TLabel;
    edtPortaServer: TEdit;
    grpGestServer: TGroupBox;
    btnStart: TButton;
    btnStop: TButton;
    lblStatoServer: TLabel;
    edtStatoServer: TEdit;
    grpGestClient: TGroupBox;
    btnRunClient: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnRunClientClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    FClientPath: String;
    procedure AggiornaInterfacciaServer;
  end;

var
  B021FForm: TB021FForm;

const
  B021_TEST_CLIENT = 'B021PTest.exe';

implementation

{ TODO : TEST IW 14 }
// uses SockApp;

{$R *.dfm}

procedure TB021FForm.FormShow(Sender: TObject);
begin
  //Fatto come wizard di DataSnap REST server in XE4: non serve più l'app debugger
  FServer:=TIdHTTPWebBrokerBridge.Create(Self);
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort:=StrToIntDef(edtPortaServer.Text,8080);//8080;
    FServer.Active:=True;
  end;

  edtPortaServer.Text:=Format('%d',[FServer.DefaultPort]);
  AggiornaInterfacciaServer;

  // determina posizione client di test
  FClientPath:=TPath.Combine(TPath.GetDirectoryName(GetModuleName(0)),B021_TEST_CLIENT);
  btnRunClient.Enabled:=TFile.Exists(FClientPath);
end;

procedure TB021FForm.AggiornaInterfacciaServer;
begin
  if FServer.Active then
    edtStatoServer.Text:='Running'
  else
    edtStatoServer.Text:='Stopped';
  btnStart.Enabled:=not FServer.Active;
  btnStop.Enabled:=FServer.Active;
end;

procedure TB021FForm.btnRunClientClick(Sender: TObject);
begin
  // esegue client
  if TFile.Exists(FClientPath) then
    ShellExecute(0,'open',PChar(FClientPath),'',nil,SW_SHOWNORMAL);
end;

procedure TB021FForm.btnStartClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    FServer.Bindings.Clear;
    FServer.DefaultPort:=StrToIntDef(edtPortaServer.Text,8080);//8080;
    FServer.Active:=True;
  finally
    AggiornaInterfacciaServer;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TB021FForm.btnStopClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    FServer.Active:=False;
  finally
    AggiornaInterfacciaServer;
    Screen.Cursor:=crDefault;
  end;
end;

initialization
  { TODO : TEST IW 14 }
  // TWebAppSockObjectFactory.Create('TWSRest')

end.

