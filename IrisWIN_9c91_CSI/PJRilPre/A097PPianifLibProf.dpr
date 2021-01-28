program A097PPianifLibProf;

uses
  Forms,
  A097UPianifLibProf in 'A097UPianifLibProf.pas' {A097FPianifLibProf},
  A097UPianifLibProfDtM1 in 'A097UPianifLibProfDtM1.pas' {A097FPianifLibProfDtM1: TDataModule},
  A097UStampaLibProf in 'A097UStampaLibProf.pas' {A097FStampaLibProf},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A097UPianifLibProfMW in '..\MWRilPre\A097UPianifLibProfMW.pas' {A097FPianifLibProfMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA097FPianifLibProf, A097FPianifLibProf);
  Application.CreateForm(TA097FPianifLibProfDtM1, A097FPianifLibProfDtM1);
  Application.Run;
end.
