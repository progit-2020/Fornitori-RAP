program A088PDatiLiberiIterMissioni;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A088UDatiLiberiIterMissioniDtM in 'A088UDatiLiberiIterMissioniDtM.pas' {A088FDatiLiberiIterMissioniDtM: TDataModule},
  A088UDatiLiberiIterMissioni in 'A088UDatiLiberiIterMissioni.pas' {A088FDatiLiberiIterMissioni},
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A088UDatiLiberiIterMissioniMW in '..\MWRilPre\A088UDatiLiberiIterMissioniMW.pas' {A088FDatiLiberiIterMissioniMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TA088FDatiLiberiIterMissioniDtM, A088FDatiLiberiIterMissioniDtM);
  Application.CreateForm(TA088FDatiLiberiIterMissioni, A088FDatiLiberiIterMissioni);
  Application.Run;
end.
