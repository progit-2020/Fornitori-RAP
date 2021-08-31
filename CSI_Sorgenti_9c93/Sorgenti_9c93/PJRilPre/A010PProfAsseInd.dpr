program A010PProfAsseInd;

uses
  Forms,
  A010UProfAsseInd in 'A010UProfAsseInd.pas' {A010FProfAsseInd},
  A010UProfAsseIndDtM1 in 'A010UProfAsseIndDtM1.pas' {A010FProfAsseIndDtM1: TDataModule},
  R001UGestTab in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.CreateForm(TA010FProfAsseInd, A010FProfAsseInd);
  Application.CreateForm(TA010FProfAsseIndDtM1, A010FProfAsseIndDtM1);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.Run;
end.
