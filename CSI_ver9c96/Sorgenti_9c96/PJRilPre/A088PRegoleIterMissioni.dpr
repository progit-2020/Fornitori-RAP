program A088PRegoleIterMissioni;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A088URegoleIterMissioniDtM in 'A088URegoleIterMissioniDtM.pas' {A088FRegoleIterMissioniDtM: TDataModule},
  A088URegoleIterMissioni in 'A088URegoleIterMissioni.pas' {A088FRegoleIterMissioni};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TA088FRegoleIterMissioniDtM, A088FRegoleIterMissioniDtM);
  Application.CreateForm(TA088FRegoleIterMissioni, A088FRegoleIterMissioni);
  Application.Run;
end.
