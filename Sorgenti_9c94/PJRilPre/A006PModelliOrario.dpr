program A006PModelliOrario;

uses
  Forms,
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A006UModelliOrarioDtM1 in 'A006UModelliOrarioDtM1.pas' {A006FModelliOrarioDtM1: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A006UModelliOrario in 'A006UModelliOrario.pas' {A006FModelliOrario},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A006UModelliOrarioMW in '..\MWRilPre\A006UModelliOrarioMW.pas' {A006FModelliOrarioMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.CreateForm(TA006FModelliOrario, A006FModelliOrario);
  Application.CreateForm(TA006FModelliOrarioDtM1, A006FModelliOrarioDtM1);
  Application.Run;
end.
