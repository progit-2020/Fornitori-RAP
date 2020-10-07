program A120PTipiRimborsi;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A120UTipiRimborsi in 'A120UTipiRimborsi.pas' {A120FTIPIRIMBORSI},
  A120UTipiRimborsiDtM in 'A120UTipiRimborsiDtM.pas' {A120FTIPIRIMBORSIDTM: TDataModule},
  R004UGestStoricoDTM in '..\REPOSITARY\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A120UTipiRimborsiMW in '..\MWRilPre\A120UTipiRimborsiMW.pas' {A120FTipiRimborsiMW: TDataModule};

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.CreateForm(TA120FTIPIRIMBORSI, A120FTIPIRIMBORSI);
  Application.CreateForm(TA120FTIPIRIMBORSIDTM, A120FTIPIRIMBORSIDTM);
  Application.Run;
end.
