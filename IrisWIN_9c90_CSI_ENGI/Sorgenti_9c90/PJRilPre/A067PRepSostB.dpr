program A067PRepSostB;

uses
  Forms,
  A067URepSostB in 'A067URepSostB.pas' {A067FRepSostB},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A067URepSostBMW in '..\MWRilPre\A067URepSostBMW.pas' {A067FRepSostBMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA067FRepSostB, A067FRepSostB);
  Application.Run;
end.
