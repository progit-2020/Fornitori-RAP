program Ac05PImportRimborsi;

uses
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  Ac05UImportRimborsi in 'Ac05UImportRimborsi.pas' {Ac05FImportRimborsi},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  Ac05UImportRimborsiDM in 'Ac05UImportRimborsiDM.pas' {Ac05FImportRimborsiDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAc05FImportRimborsi, Ac05FImportRimborsi);
  Application.Run;
end.
