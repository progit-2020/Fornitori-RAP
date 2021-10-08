program A019PRaggrGiustif;

uses
  Forms,
  A019URaggrGiustif in 'A019URaggrGiustif.pas' {A019FRaggrGiustif},
  A019URaggrGiustifDtM1 in 'A019URaggrGiustifDtM1.pas' {A019FRaggrGiustifDtM1: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA019FRaggrGiustif, A019FRaggrGiustif);
  Application.CreateForm(TA019FRaggrGiustifDtM1, A019FRaggrGiustifDtM1);
  Application.Run;
end.
