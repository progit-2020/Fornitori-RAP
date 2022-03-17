program B007PManipolazioneDati;

uses
  Forms,
  HtmlHelpViewer,
  MidasLib,
  A000UInterfaccia,
  B007UManipolazioneDatiDtM1 in 'B007UManipolazioneDatiDtM1.pas' {B007FManipolazioneDatiDtM1: TDataModule},
  B007UManipolazioneDati in 'B007UManipolazioneDati.pas' {B007FManipolazioneDati},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  B007UManipolazioneDatiMW in '..\MWCondivisi\B007UManipolazioneDatiMW.pas' {B007FManipolazioneDatiMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  B022UUtilityGestDocumentaleMW in '..\MWCondivisi\B022UUtilityGestDocumentaleMW.pas' {B022FUtilityGestDocumentaleMW: TDataModule};

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.Title := 'Manipolazione dati';
  Application.HelpFile := 'Help\IrisWin_accessori.chm';
  Application.CreateForm(TB007FManipolazioneDatiDtM1, B007FManipolazioneDatiDtM1);
  Application.CreateForm(TB007FManipolazioneDati, B007FManipolazioneDati);
  if Parametri.Azienda = '' then
    Application.Terminate
  else
    Application.Run;
end.
