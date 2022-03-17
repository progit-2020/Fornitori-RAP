program A052PParCar;

uses
  Forms,
  A052UParCar in 'A052UParCar.pas' {A052FParCar},
  A052UParCarDtM1 in 'A052UParCarDtM1.pas' {A052FParCarDtM1: TDataModule},
  A052UProprieta in 'A052UProprieta.pas' {A052FProprieta},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A052UParCarMW in '..\MWRilPre\A052UParCarMW.pas' {A052FParCarMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  A027UCostanti in '..\Copy\A027UCostanti.pas';

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TA052FParCar, A052FParCar);
  Application.CreateForm(TA052FParCarDtM1, A052FParCarDtM1);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.Run;
end.
