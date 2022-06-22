program A086PMotivazioniRichieste;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A086UMotivazioniRichieste in 'A086UMotivazioniRichieste.pas' {A086FMotivazioniRichieste},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A086UMotivazioniRichiesteDtM in 'A086UMotivazioniRichiesteDtM.pas' {A086FMotivazioniRichiesteDtM: TDataModule},
  A086UMotivazioniRichiesteMW in '..\MWRilPre\A086UMotivazioniRichiesteMW.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TA086FMotivazioniRichieste, A086FMotivazioniRichieste);
  Application.CreateForm(TA086FMotivazioniRichiesteDtM, A086FMotivazioniRichiesteDtM);
  Application.Run;
end.
