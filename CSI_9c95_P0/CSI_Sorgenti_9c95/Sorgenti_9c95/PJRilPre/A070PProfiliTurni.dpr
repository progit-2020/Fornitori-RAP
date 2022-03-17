program A070PProfiliTurni;

uses
  Forms,
  R001UGestTab in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A070UProfiliTurni in 'A070UProfiliTurni.pas' {A070FProfiliTurni},
  R004UGestStoricoDTM in '..\REPOSITARY\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A070UProfiliTurniDtM1 in 'A070UProfiliTurniDtM1.pas' {A070FProfiliTurniDtM1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA070FProfiliTurniDtM1, A070FProfiliTurniDtM1);
  Application.CreateForm(TA070FProfiliTurni, A070FProfiliTurni);
  Application.Run;
end.
