program A167PRegistraIncentivi;

uses
  Forms,
  A167URegistraIncentivi in 'A167URegistraIncentivi.pas' {A167FRegistraIncentivi},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A167URegistraIncentiviDtM in 'A167URegistraIncentiviDtM.pas' {A167FRegistraIncentiviDtM: TDataModule},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  A167UStampaIncentivi in 'A167UStampaIncentivi.pas' {A167FStampaIncentivi},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A167URegistraIncentiviMW in '..\MWRilPre\A167URegistraIncentiviMW.pas' {A167FRegistraIncentiviMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.CreateForm(TA167FRegistraIncentivi, A167FRegistraIncentivi);
  Application.CreateForm(TA167FRegistraIncentiviDtM, A167FRegistraIncentiviDtM);
  Application.Run;
end.
