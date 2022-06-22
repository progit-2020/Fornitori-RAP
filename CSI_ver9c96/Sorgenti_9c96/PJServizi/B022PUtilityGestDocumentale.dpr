program B022PUtilityGestDocumentale;

uses
  Forms,
  HtmlHelpViewer,
  MidasLib,
  OracleMonitor,
  A000UInterfaccia,
  B022UUtilityGestDocumentaleDM in 'B022UUtilityGestDocumentaleDM.pas' {B022FUtilityGestDocumentaleDM: TDataModule},
  B022UUtilityGestDocumentale in 'B022UUtilityGestDocumentale.pas' {B022FUtilityGestDocumentale},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  B022UUtilityGestDocumentaleMW in '..\MWCondivisi\B022UUtilityGestDocumentaleMW.pas' {B022FUtilityGestDocumentaleMW: TDataModule};

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Parametri.Applicazione:='RILPRE';
  //Application.Title := '';
  Application.Title := 'Utility gestione documentale';
  Application.HelpFile := 'Help\IrisWin_accessori.chm';
  Application.CreateForm(TB022FUtilityGestDocumentaleDM, B022FUtilityGestDocumentaleDM);
  Application.CreateForm(TB022FUtilityGestDocumentale, B022FUtilityGestDocumentale);
  if Parametri.Azienda = '' then
    Application.Terminate
  else
    Application.Run;
end.
