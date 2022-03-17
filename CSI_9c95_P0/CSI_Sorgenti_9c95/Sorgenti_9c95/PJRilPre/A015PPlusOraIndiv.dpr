program A015PPlusOraIndiv;

uses
  Forms,
  A015UPlusOraIndiv in 'A015UPlusOraIndiv.pas' {A015FPlusOraIndiv},
  A015UPlusOraIndivDtM1 in 'A015UPlusOraIndivDtM1.pas' {A015FPlusOraIndivDtM1: TDataModule},
  R001UGestTab in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA015FPlusOraIndiv, A015FPlusOraIndiv);
  Application.CreateForm(TA015FPlusOraIndivDtM1, A015FPlusOraIndivDtM1);
  Application.Run;
end.
