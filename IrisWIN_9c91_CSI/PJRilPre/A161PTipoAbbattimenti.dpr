program A161PTipoAbbattimenti;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A161UTipoAbbattimenti in 'A161UTipoAbbattimenti.pas' {A161FTipoAbbattimenti},
  R004UGESTSTORICODTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A161UTipoAbbattimentiDtM in 'A161UTipoAbbattimentiDtM.pas' {A161FTipoAbbattimentiDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A161UTipoAbbattimentiMW in '..\MWRilPre\A161UTipoAbbattimentiMW.pas' {A161FTipoAbbattimentiMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA161FTipoAbbattimenti, A161FTipoAbbattimenti);
  Application.CreateForm(TA161FTipoAbbattimentiDtM, A161FTipoAbbattimentiDtM);
  Application.Run;
end.
