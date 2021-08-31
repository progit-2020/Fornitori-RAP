program A065PStampaBudget;

uses
  Forms,
  A065UStampaBudget in 'A065UStampaBudget.pas' {A065FStampaBudget},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A065UStampaBudgetDtM in 'A065UStampaBudgetDtM.pas' {A065FStampaBudgetDtM: TDataModule},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  A065UStampa in 'A065UStampa.pas' {A065FStampa};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA065FStampaBudget, A065FStampaBudget);
  Application.CreateForm(TA065FStampaBudgetDtM, A065FStampaBudgetDtM);
  Application.Run;
end.
