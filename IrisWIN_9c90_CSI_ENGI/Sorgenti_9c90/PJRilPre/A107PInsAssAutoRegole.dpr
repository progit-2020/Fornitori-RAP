program A107PInsAssAutoRegole;

uses
  Forms,
  A107UInsAssAutoRegole in 'A107UInsAssAutoRegole.pas' {A107FInsAssAutoRegole},
  A107UInsAssAutoRegoleDtM in 'A107UInsAssAutoRegoleDtM.pas' {A107FInsAssAutoRegoleDtM: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A107UInsAssAutoRegoleMW in '..\MWRilPre\A107UInsAssAutoRegoleMW.pas' {A107FInsAssAutoRegoleMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA107FInsAssAutoRegole, A107FInsAssAutoRegole);
  Application.CreateForm(TA107FInsAssAutoRegoleDtM, A107FInsAssAutoRegoleDtM);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.Run;
end.
