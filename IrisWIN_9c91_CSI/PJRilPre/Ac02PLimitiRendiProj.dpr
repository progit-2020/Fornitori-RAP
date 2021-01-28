program Ac02PLimitiRendiProj;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  Ac02ULimitiRendiProj in 'Ac02ULimitiRendiProj.pas' {Ac02FLimitiRendiProj},
  Ac02ULimitiRendiProjDtM in 'Ac02ULimitiRendiProjDtM.pas' {Ac02FLimitiRendiProjDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  Ac02ULimitiRendiProjMW in '..\MWRilPre\Ac02ULimitiRendiProjMW.pas' {Ac02FLimitiRendiProjMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TAc02FLimitiRendiProj, Ac02FLimitiRendiProj);
  Application.CreateForm(TAc02FLimitiRendiProjDtM, Ac02FLimitiRendiProjDtM);
  Application.Run;
end.
