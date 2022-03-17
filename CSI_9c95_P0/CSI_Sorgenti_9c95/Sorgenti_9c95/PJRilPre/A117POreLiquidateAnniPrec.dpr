program A117POreLiquidateAnniPrec;

uses
  Forms,
  A117UOreLiquidateAnniPrec in 'A117UOreLiquidateAnniPrec.pas' {A117FOreLiquidateAnniPrec},
  A117UOreLiquidateAnniPrecDtM in 'A117UOreLiquidateAnniPrecDtM.pas' {A117FOreLiquidateAnniPrecDtM: TDataModule},
  R001UGestTab in '..\Repositary\R001UGestTab.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A117UOreLiquidateAnniPrecMW in '..\MWRilPre\A117UOreLiquidateAnniPrecMW.pas' {A117FOreLiquidateAnniPrecMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA117FOreLiquidateAnniPrec, A117FOreLiquidateAnniPrec);
  Application.CreateForm(TA117FOreLiquidateAnniPrecDtM, A117FOreLiquidateAnniPrecDtM);
  Application.Run;
end.
