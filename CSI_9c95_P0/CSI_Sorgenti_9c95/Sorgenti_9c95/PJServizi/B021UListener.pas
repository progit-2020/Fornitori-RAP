unit B021UListener;

interface

uses
  SysUtils, Classes, HTTPApp, DSHTTP, DSHTTPCommon, DSHTTPWebBroker, DSServer,
  DSCommonServer, IdContext, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdTCPServer, IdCmdTCPServer, DSTCPServerTransport
  {$IFNDEF VER210}, IPPeerCommon, IPPeerServer, Data.DBXTransport{$ENDIF};

type
  TB021FListener = class(TWebModule)
    DSServer1: TDSServer;
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure WebModule2DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B021FListener: TB021FListener;

implementation

uses WebReq, B021UIrisRestSvcDM;

{$R *.dfm}

procedure TB021FListener.WebModule2DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content:='<html><heading/><body>DataSnap Server</body></html>';
end;

procedure TB021FListener.WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
//var
//  SC: Integer;
//  OldReason: String;
begin
  // Sender = B021FListener
  {
  if (Response.StatusCode = 500) and (Copy(Response.ReasonString,1,3) = 'ERR') then
  begin
    if TryStrToInt(Copy(Response.ReasonString,4,3),SC) then
    begin
      OldReason:=Copy(Response.ReasonString,8);
      Response.StatusCode:=SC;
      Response.ReasonString:=OldReason;
    end;
  end;
  }

  // sovrascrive il content-type (che contrariamente a quanto atteso vale sempre text/html)
  Response.ContentType:='application/json';
end;

procedure TB021FListener.DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass:=B021UIrisRestSvcDM.TB021FIrisRestSvcDM;
end;

initialization
  WebRequestHandler.WebModuleClass:=TB021FListener;

end.




