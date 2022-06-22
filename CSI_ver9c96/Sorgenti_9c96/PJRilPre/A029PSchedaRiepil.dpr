program A029PSchedaRiepil;

uses
  Forms,
  A029USchedaRiepilDtM1 in 'A029USchedaRiepilDtM1.pas' {A029FSchedaRiepilDtM1: TDataModule},
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A029USchedaRiepil in 'A029USchedaRiepil.pas' {A029FSchedaRiepil},
  A029UBudgetDtM1 in 'A029UBudgetDtM1.pas' {A029FBudgetDtM1: TDataModule},
  A029ULiquidazione in 'A029ULiquidazione.pas' {A029FLiquidazione: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A029URecuperiMobili in 'A029URecuperiMobili.pas' {A029FRecuperiMobili},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A029USchedaRiepilMW in '..\MWRilPre\A029USchedaRiepilMW.pas' {A029FSchedaRiepilMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TA029FSchedaRiepil, A029FSchedaRiepil);
  Application.CreateForm(TA029FSchedaRiepilDtM1, A029FSchedaRiepilDtM1);
  Application.CreateForm(TA029FRecuperiMobili, A029FRecuperiMobili);
  Application.Run;
end.
