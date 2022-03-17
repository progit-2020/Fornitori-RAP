program A017PRaggrAsse;

uses
  Forms,
  R001UGestTab in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A017URaggrAsse in 'A017URaggrAsse.pas' {A017FRaggrAsse},
  A017URaggrAsseDtM1 in 'A017URaggrAsseDtM1.pas' {A017FRaggrAsseDtM1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA017FRaggrAsse, A017FRaggrAsse);
  Application.CreateForm(TA017FRaggrAsseDtM1, A017FRaggrAsseDtM1);
  Application.Run;
end.
