program A048PPastiMese;

uses
  Forms,
  A048UPastiMeseDTM1 in 'A048UPastiMeseDTM1.pas' {A048FPastiMeseDtM1: TDataModule},
  A048UPastiMese in 'A048UPastiMese.pas' {A048FPastiMese},
  R001UGestTab in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA048FPastiMese, A048FPastiMese);
  Application.CreateForm(TA048FPastiMeseDtM1, A048FPastiMeseDtM1);
  Application.Run;
end.
