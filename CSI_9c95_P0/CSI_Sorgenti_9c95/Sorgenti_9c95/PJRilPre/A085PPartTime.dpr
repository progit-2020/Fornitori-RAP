program A085PPartTime;

uses
  Forms,
  A085UPartTimeDtM1 in 'A085UPartTimeDtM1.pas' {A085FPartTimeDtM1: TDataModule},
  A085UPartTime in 'A085UPartTime.pas' {A085FPartTime},
  R001UGestTab in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA085FPartTime, A085FPartTime);
  Application.CreateForm(TA085FPartTimeDtM1, A085FPartTimeDtM1);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.Run;
end.
