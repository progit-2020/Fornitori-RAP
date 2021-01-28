program A106PDistanzeTrasferta;

uses
  Forms,
  R004UGestStoricoDTM in '..\REPOSITARY\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A106UDistanzeTrasfertaDTM in 'A106UDistanzeTrasfertaDTM.pas' {A106FDistanzeTrasfertaDTM: TDataModule},
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A106UDistanzeTrasferta in 'A106UDistanzeTrasferta.pas' {A106FDistanzeTrasferta},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A106UDistanzeTrasfertaMW in '..\MWRilPre\A106UDistanzeTrasfertaMW.pas' {A106FDistanzeTrasfertaMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  C019UDistanziometro in '..\Copy\C019UDistanziometro.pas';

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TA106FDistanzeTrasferta, A106FDistanzeTrasferta);
  Application.CreateForm(TA106FDistanzeTrasfertaDTM, A106FDistanzeTrasfertaDTM);
  Application.Run;
end.
