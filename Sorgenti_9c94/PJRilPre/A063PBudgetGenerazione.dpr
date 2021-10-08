program A063PBudgetGenerazione;

uses
  Forms,
  MidasLib,
  A063UBudgetGenerazione in 'A063UBudgetGenerazione.pas' {A063FBudgetGenerazione},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A063UBudgetGenerazioneMW in '..\MWRilPre\A063UBudgetGenerazioneMW.pas' {A063FBudgetGenerazioneMW: TDataModule};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TA063FBudgetGenerazione, A063FBudgetGenerazione);
  Application.CreateForm(TR004FGestStoricoDtM, R004FGestStoricoDtM);
  Application.CreateForm(TR002FQRep, R002FQRep);
  Application.Run;
end.
