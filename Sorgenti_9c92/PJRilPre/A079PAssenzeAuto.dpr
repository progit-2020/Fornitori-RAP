program A079PAssenzeAuto;

uses
  Forms,
  A079UAssenzeAuto in 'A079UAssenzeAuto.pas' {A079FAssenzeAuto},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A079UAssenzeAutoMW in '..\MWRilPre\A079UAssenzeAutoMW.pas' {A079FAssenzeAutoMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA079FAssenzeAuto, A079FAssenzeAuto);
  Application.Run;
end.
