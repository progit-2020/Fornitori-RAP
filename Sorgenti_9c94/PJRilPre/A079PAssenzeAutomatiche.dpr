program A079PAssenzeAutomatiche;

uses
  Forms,
  A076UIndGruppoDtM1 in 'A076UIndGruppoDtM1.pas' {A076FIndGruppoDtM1: TDataModule},
  R001UGestTab in 'REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A076UIndGruppo in 'A076UIndGruppo.pas' {A076FIndGruppo};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA076FIndGruppoDtM1, A076FIndGruppoDtM1);
  Application.CreateForm(TA076FIndGruppo, A076FIndGruppo);
  Application.Run;
end.
