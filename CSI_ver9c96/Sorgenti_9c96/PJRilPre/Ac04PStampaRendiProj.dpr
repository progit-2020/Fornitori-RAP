program Ac04PStampaRendiProj;

uses
  Forms,
  MidasLib,
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  Ac04UStampaRendiProjMW in '..\MWRilPre\Ac04UStampaRendiProjMW.pas' {Ac04FStampaRendiProjMW: TDataModule},
  Ac04UStampaRendiProj in 'Ac04UStampaRendiProj.pas' {Ac04FStampaRendiProj},
  Ac04UStampaRendiProjDM in 'Ac04UStampaRendiProjDM.pas' {Ac04FStampaRendiProjDM: TDataModule},
  Ac04UStampa in 'Ac04UStampa.pas' {Ac04FStampa};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TAc04FStampaRendiProj, Ac04FStampaRendiProj);
  Application.CreateForm(TAc04FStampaRendiProjDM, Ac04FStampaRendiProjDM);
  Application.Run;
end.
