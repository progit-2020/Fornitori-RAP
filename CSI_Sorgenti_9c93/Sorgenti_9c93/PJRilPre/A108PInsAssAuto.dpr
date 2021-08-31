program A108PInsAssAuto;

uses
  Forms,
  A108UInsAssAuto in 'A108UInsAssAuto.pas' {A108FInsAssAuto},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A108UInsAssAutoMW in '..\MWRilPre\A108UInsAssAutoMW.pas' {A108FInsAssAutoMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA108FInsAssAuto, A108FInsAssAuto);
  Application.Run;
end.
