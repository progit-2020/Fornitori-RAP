program A074PRiepilogoBuoni;

uses
  Forms,
  MidasLib,
  OracleMonitor,
  A074URiepilogoBuoni in 'A074URiepilogoBuoni.pas' {A074FRiepilogoBuoni},
  A074URiepilogoBuoniDtM1 in 'A074URiepilogoBuoniDtM1.pas' {A074FRiepilogoBuoniDtM1: TDataModule},
  A074UStampaBuoni in 'A074UStampaBuoni.pas' {A074FStampaBuoni},
  A074UGemeaz in 'A074UGemeaz.pas' {A074FGemeaz},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R002UQREP in '..\REPOSITARY\R002UQREP.pas' {R002FQRep},
  A074UStampaAcquisti in 'A074UStampaAcquisti.pas' {A074FStampaAcquisti},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A074URiepilogoBuoniMW in '..\MWRilPre\A074URiepilogoBuoniMW.pas' {A074FRiepilogoBuoniMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  R350UCalcoloBuoniDtM in '..\MWRilPre\R350UCalcoloBuoniDtM.pas' {R350FCalcoloBuoniDtM: TDataModule},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.CreateForm(TA074FRiepilogoBuoni, A074FRiepilogoBuoni);
  Application.CreateForm(TA074FRiepilogoBuoniDtM1, A074FRiepilogoBuoniDtM1);
  Application.Run;
end.
