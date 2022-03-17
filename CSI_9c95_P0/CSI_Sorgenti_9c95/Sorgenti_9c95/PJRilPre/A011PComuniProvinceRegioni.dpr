program A011PComuniProvinceRegioni;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A011UComuniProvinceRegioni in 'A011UComuniProvinceRegioni.pas' {A011FComuniProvinceRegioni},
  A011UComuniProvinceRegioniDtM in 'A011UComuniProvinceRegioniDtM.pas' {A011FComuniProvinceRegioniDtM: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A011UEntiLocaliMW in '..\MWRilPre\A011UEntiLocaliMW.pas' {A011FEntiLocaliMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA011FComuniProvinceRegioni, A011FComuniProvinceRegioni);
  Application.CreateForm(TA011FComuniProvinceRegioniDtM, A011FComuniProvinceRegioniDtM);
  Application.Run;
end.
