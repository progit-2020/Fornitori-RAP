program A072PBuoniMese;

uses
  Forms,
  A072UBuoniMeseDTM1 in 'A072UBuoniMeseDTM1.pas' {A072FBuoniMeseDtM1: TDataModule},
  A072UBuoniMese in 'A072UBuoniMese.pas' {A072FBuoniMese},
  R001UGestTab in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA072FBuoniMese, A072FBuoniMese);
  Application.CreateForm(TA072FBuoniMeseDtM1, A072FBuoniMeseDtM1);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.Run;
end.
