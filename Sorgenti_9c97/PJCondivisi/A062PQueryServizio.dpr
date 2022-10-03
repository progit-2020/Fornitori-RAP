program A062PQueryServizio;

uses
  Forms,
  A062UQueryServizio in 'A062UQueryServizio.pas' {A062FQueryServizio},
  A062UQueryServizioDtM1 in 'A062UQueryServizioDtM1.pas' {A062FQueryServizioDtM1: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A062UAccessoDB in 'A062UAccessoDB.pas' {A062FAccessoDB},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A062UQueryServizioMW in '..\MWRilPre\A062UQueryServizioMW.pas' {A062FQueryServizioMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA062FQueryServizio, A062FQueryServizio);
  Application.CreateForm(TA062FQueryServizioDtM1, A062FQueryServizioDtM1);
  Application.CreateForm(TA062FAccessoDB, A062FAccessoDB);
  Application.Run;
end.
