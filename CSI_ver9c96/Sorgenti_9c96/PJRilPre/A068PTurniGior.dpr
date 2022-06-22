program A068PTurniGior;

uses
  Forms,
  A068UTurniGior in 'A068UTurniGior.pas' {A068FTurniGior},
  A068UTurniGiorDtM1 in 'A068UTurniGiorDtM1.pas' {A068FTurniGiorDtM1: TDataModule},
  A068UStampa in 'A068UStampa.pas' {A068FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R002UQRep in '..\Repositary\R002UQREP.pas' {R002FQRep};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA068FTurniGior, A068FTurniGior);
  Application.CreateForm(TA068FTurniGiorDtM1, A068FTurniGiorDtM1);
  Application.Run;
end.
