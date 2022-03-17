library B021PIrisRestSvc_IIS;

uses
  ActiveX,
  ComObj,
  WebBroker,
  ISAPIApp,
  ISAPIThreadPool,
  R014URestDM in '..\Repositary\R014URestDM.pas' {R014FRestDM: TDataModule},
  B021UIrisRestSvcDM in 'B021UIrisRestSvcDM.pas' {B021FIrisRestSvcDM: TDataModule},
  B021UListener in 'B021UListener.pas' {B021FListener: TWebModule};

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  CoInitFlags:=COINIT_MULTITHREADED;
  Application.Initialize;
  Application.CreateForm(TB021FListener, B021FListener);
  Application.Run;
end.

