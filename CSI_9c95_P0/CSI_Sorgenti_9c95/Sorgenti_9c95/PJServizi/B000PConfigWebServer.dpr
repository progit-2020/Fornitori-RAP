program B000PConfigWebServer;

uses
  Forms,
  HtmlHelpViewer,
  B000UConfigWebServer in 'B000UConfigWebServer.pas' {B000FConfigWebServer},
  B000UConfigWebServerDM in 'B000UConfigWebServerDM.pas' {B000FConfigWebServerDM: TDataModule},
  A000UCostanti in '..\Copy\A000UCostanti.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.HelpFile := 'Help\IrisWIN_accessori.chm';
  Application.CreateForm(TB000FConfigWebServer, B000FConfigWebServer);
  Application.CreateForm(TB000FConfigWebServerDM, B000FConfigWebServerDM);
  Application.Run;
end.
