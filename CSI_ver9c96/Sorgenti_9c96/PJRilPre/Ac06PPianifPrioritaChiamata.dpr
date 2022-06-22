program Ac06PPianifPrioritaChiamata;

uses
  Forms,
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  Ac06UPianifPrioritaChiamataMW in '..\MWRilPre\Ac06UPianifPrioritaChiamataMW.pas' {Ac06FPianifPrioritaChiamataMW: TDataModule},
  Ac06UPianifPrioritaChiamata in 'Ac06UPianifPrioritaChiamata.pas' {Ac06FPianifPrioritaChiamata},
  Ac06UPianifPrioritaChiamataDM in 'Ac06UPianifPrioritaChiamataDM.pas' {Ac06FPianifPrioritaChiamataDM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TAc06FPianifPrioritaChiamata, Ac06FPianifPrioritaChiamata);
  Application.CreateForm(TAc06FPianifPrioritaChiamataDM, Ac06FPianifPrioritaChiamataDM);
  Application.Run;
end.
