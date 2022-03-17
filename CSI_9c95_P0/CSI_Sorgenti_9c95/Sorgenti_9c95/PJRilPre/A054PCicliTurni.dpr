program A054PCicliTurni;

uses
  Forms,
  A054UCicliTurni in 'A054UCicliTurni.pas' {A054FCicliTurni},
  A054UCicliTurniDtM1 in 'A054UCicliTurniDtM1.pas' {A054FCicliTurniDtM1: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A054UCicliTurniMW in '..\MWRilPre\A054UCicliTurniMW.pas' {A054FCicliTurniMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA054FCicliTurni, A054FCicliTurni);
  Application.CreateForm(TA054FCicliTurniDtM1, A054FCicliTurniDtM1);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.Run;
end.
