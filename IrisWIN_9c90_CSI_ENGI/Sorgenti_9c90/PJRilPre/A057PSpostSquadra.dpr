program A057PSpostSquadra;

uses
  Forms,
  A057USpostSquadra in 'A057USpostSquadra.pas' {A057FSpostSquadra},
  A057USpostSquadraDtM1 in 'A057USpostSquadraDtM1.pas' {A057FSpostSquadraDtM1: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA057FSpostSquadra, A057FSpostSquadra);
  Application.CreateForm(TA057FSpostSquadraDtM1, A057FSpostSquadraDtM1);
  Application.Run;
end.
