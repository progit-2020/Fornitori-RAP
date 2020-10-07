program A087PImpAttestatiMal;

uses
  Forms,
  A087UImpAttestatiMal in 'A087UImpAttestatiMal.pas' {A087FImpAttestatiMal},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A087UImpAttestatiMalMW in '..\MWRilPre\A087UImpAttestatiMalMW.pas' {A087FImpAttestatiMalMW: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA087FImpAttestatiMal, A087FImpAttestatiMal);
  Application.Run;
end.
