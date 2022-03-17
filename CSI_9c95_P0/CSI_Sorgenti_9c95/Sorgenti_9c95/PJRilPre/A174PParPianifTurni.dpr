program A174PParPianifTurni;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A174UParPianifTurni in 'A174UParPianifTurni.pas' {A174FParPianifTurni},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A174UParPianifTurniDtm in 'A174UParPianifTurniDtm.pas' {A174FParPianifTurniDtm: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  A174UParPianifTurniMW in '..\MWRilPre\A174UParPianifTurniMW.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA174FParPianifTurni, A174FParPianifTurni);
  Application.CreateForm(TA174FParPianifTurniDtm, A174FParPianifTurniDtm);
  Application.Run;
end.
