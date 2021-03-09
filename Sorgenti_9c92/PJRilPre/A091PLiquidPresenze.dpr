program A091PLiquidPresenze;

uses
  Forms,
  MidasLib,
  A091ULiquidPresenze in 'A091ULiquidPresenze.pas' {A091FLiquidPresenze},
  A091ULiquidPresenzeDtM1 in 'A091ULiquidPresenzeDtM1.pas' {A091FLiquidPresenzeDtM1: TDataModule},
  A091UStampa in 'A091UStampa.pas' {A091FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A091UAnnullaLiquidazione in 'A091UAnnullaLiquidazione.pas' {A091FAnnullaLiquidazione},
  A029UBudgetDtM1 in 'A029UBudgetDtM1.pas' {A029FBudgetDtM1: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A091ULiquidPresenzeMW in '..\MWRilPre\A091ULiquidPresenzeMW.pas' {A091FLiquidPresenzeMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TA091FLiquidPresenze, A091FLiquidPresenze);
  Application.CreateForm(TA091FLiquidPresenzeDtM1, A091FLiquidPresenzeDtM1);
  Application.CreateForm(TA091FAnnullaLiquidazione, A091FAnnullaLiquidazione);
  Application.Run;
end.
