program A018PRaggrPres;

uses
  Forms,
  R001UGestTab in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A018URaggrPres in 'A018URaggrPres.pas' {A018FRaggrPres},
  A018URaggrPresDtM1 in 'A018URaggrPresDtM1.pas' {A018FRaggrPresDtM1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA018FRaggrPres, A018FRaggrPres);
  Application.CreateForm(TA018FRaggrPresDtM1, A018FRaggrPresDtM1);
  Application.Run;
end.
