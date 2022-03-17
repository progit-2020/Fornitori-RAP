unit B021UServerContainer;

interface

uses System.SysUtils, System.Classes,
  Vcl.SvcMgr,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSHTTPCommon, Datasnap.DSHTTP,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSAuth, IPPeerServer,
  C180FunzioniGenerali;

type
  TB021FServerContainer = class(TService)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSHTTPService1: TDSHTTPService;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    { Private declarations }
  protected
    function DoStop: Boolean; override;
    function DoPause: Boolean; override;
    function DoContinue: Boolean; override;
    procedure DoInterrogate; override;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  B021FServerContainer: TB021FServerContainer;

implementation

uses Winapi.Windows, B021UIrisRestSvcDM;

{$R *.dfm}

procedure TB021FServerContainer.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := B021UIrisRestSvcDM.TB021FIrisRestSvcDM;
end;


procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  B021FServerContainer.Controller(CtrlCode);
end;

function TB021FServerContainer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

function TB021FServerContainer.DoContinue: Boolean;
begin
  Result := inherited;
  DSServer1.Start;
end;

procedure TB021FServerContainer.DoInterrogate;
begin
  inherited;
end;

function TB021FServerContainer.DoPause: Boolean;
begin
  DSServer1.Stop;
  Result := inherited;
end;

function TB021FServerContainer.DoStop: Boolean;
begin
  DSServer1.Stop;
  Result := inherited;
end;

procedure TB021FServerContainer.ServiceStart(Sender: TService; var Started: Boolean);
begin
  // DSServer1.AutoStart è impostato a False (necessario perchè non è possibile modificare
  // il numero di porta di ascolto del server una volta avviato, neanche arrestandolo preventivamente)
  DSHTTPService1.HttpPort:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B021','PORT','8081'),8081);
  DSServer1.Start;
end;

end.

