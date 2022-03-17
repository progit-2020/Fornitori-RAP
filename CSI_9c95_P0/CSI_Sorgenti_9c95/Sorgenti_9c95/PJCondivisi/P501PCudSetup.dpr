program P501PCudSetup;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  P501UCudSetup in 'P501UCudSetup.pas' {P501FCudSetup},
  P501UCudSetupDtM in 'P501UCudSetupDtM.pas' {P501FCudSetupDtM: TDataModule},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P501UCudSetupMW in '..\MWCondivisi\P501UCudSetupMW.pas' {P501FCudSetupMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TP501FCudSetup, P501FCudSetup);
  Application.CreateForm(TP501FCudSetupDtM, P501FCudSetupDtM);
  Application.CreateForm(TR004FGestStoricoDtM, R004FGestStoricoDtM);
  Application.Run;
end.
