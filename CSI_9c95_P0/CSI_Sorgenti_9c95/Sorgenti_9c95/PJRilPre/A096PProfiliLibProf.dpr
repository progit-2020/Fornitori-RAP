program A096PProfiliLibProf;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A096UProfiliLibProf in 'A096UProfiliLibProf.pas' {A096FProfiliLibProf},
  A096UProfiliLibProfDtM1 in 'A096UProfiliLibProfDtM1.pas' {A096FProfiliLibProfDtM1: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A096UProfiliLibProfMW in '..\MWRilPre\A096UProfiliLibProfMW.pas' {A096FProfiliLibProfMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA096FProfiliLibProf, A096FProfiliLibProf);
  Application.CreateForm(TA096FProfiliLibProfDtM1, A096FProfiliLibProfDtM1);
  Application.Run;
end.
