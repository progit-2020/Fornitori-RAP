program A144PComuniMedLegali;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A144UComuniMedLegali in 'A144UComuniMedLegali.pas' {A144FComuniMedLegali},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A144UComuniMedLegaliDtm in 'A144UComuniMedLegaliDtm.pas' {A144FComuniMedLegaliDtm: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A144UComuniMedLegaliMW in '..\MWRilPre\A144UComuniMedLegaliMW.pas' {A144FComuniMedLegaliMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA144FComuniMedLegali, A144FComuniMedLegali);
  Application.CreateForm(TA144FComuniMedLegaliDtm, A144FComuniMedLegaliDtm);
  Application.Run;
end.
