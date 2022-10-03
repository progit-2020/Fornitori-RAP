program A030PResidui;

uses
  Forms,
  A030UResidui in 'A030UResidui.pas' {A030FResidui},
  A030UResiduiDtM1 in 'A030UResiduiDtM1.pas' {A030FResiduiDtM1: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A030UResiduiMW in '..\MWRilPre\A030UResiduiMW.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA030FResidui, A030FResidui);
  Application.CreateForm(TA030FResiduiDtM1, A030FResiduiDtM1);
  Application.Run;
end.
