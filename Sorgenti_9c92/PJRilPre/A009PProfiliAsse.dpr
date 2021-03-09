program A009PProfiliAsse;

uses
  Forms,
  A009UProfiliAsse in 'A009UProfiliAsse.pas' {A009FProfiliAsse},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A009UProfiliAsseDtM1 in 'A009UProfiliAsseDtM1.pas' {A009FProfiliAsseDtM1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA009FProfiliAsse, A009FProfiliAsse);
  Application.CreateForm(TA009FProfiliAsseDtM1, A009FProfiliAsseDtM1);
  Application.Run;
end.
