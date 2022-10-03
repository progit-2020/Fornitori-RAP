program A148PProfiliImportazioneCertificatiINPS;

uses
  Forms,
  A148UProfiliImportazioneCertificatiINPS in 'A148UProfiliImportazioneCertificatiINPS.pas' {A148FProfiliImportazioneCertificatiINPS},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A148UProfiliImportazioneCertificatiINPSMW in '..\MWRilPre\A148UProfiliImportazioneCertificatiINPSMW.pas' {A148FProfiliImportazioneCertificatiINPSMW: TDataModule},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A148UProfiliImportazioneCertificatiINPSDtm in 'A148UProfiliImportazioneCertificatiINPSDtm.pas' {A148FProfiliImportazioneCertificatiINPSDtm: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA148FProfiliImportazioneCertificatiINPS, A148FProfiliImportazioneCertificatiINPS);
  Application.CreateForm(TA148FProfiliImportazioneCertificatiINPSDtm, A148FProfiliImportazioneCertificatiINPSDtm);
  Application.CreateForm(TA148FProfiliImportazioneCertificatiINPSMW, A148FProfiliImportazioneCertificatiINPSMW);
  Application.Run;
end.
