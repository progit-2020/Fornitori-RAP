program Ac01PProgettiRendiProj;

uses
  Forms,
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  Ac01UProgettiRendiProjDtM in 'Ac01UProgettiRendiProjDtM.pas' {Ac01FProgettiRendiProjDtM: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  Ac01UProgettiRendiProj in 'Ac01UProgettiRendiProj.pas' {Ac01FProgettiRendiProj},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  Ac01UProgettiRendiProjMW in '..\MWRilPre\Ac01UProgettiRendiProjMW.pas' {Ac01FProgettiRendiProjMW: TDataModule},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame},
  Ac01UPropIndRendiProj in 'Ac01UPropIndRendiProj.pas' {Ac01FPropIndRendiProj},
  Ac01UReportingPeriodRendiProj in 'Ac01UReportingPeriodRendiProj.pas' {Ac01FReportingPeriodRendiProj};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TAc01FProgettiRendiProj, Ac01FProgettiRendiProj);
  Application.CreateForm(TAc01FProgettiRendiProjDtM, Ac01FProgettiRendiProjDtM);
  Application.Run;
end.
