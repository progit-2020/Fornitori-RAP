program A164PQuoteIncentivi;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A164UQuoteIncentivi in 'A164UQuoteIncentivi.pas' {A164FQuoteIncentivi},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A164UQuoteIncentiviDtM in 'A164UQuoteIncentiviDtM.pas' {A164FQuoteIncentiviDtM: TDataModule},
  A164UAggGlobale in 'A164UAggGlobale.pas' {A164FAggGlobale},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A164UQuoteIncentiviMW in '..\MWRilPre\A164UQuoteIncentiviMW.pas' {A164FQuoteIncentiviMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.CreateForm(TA164FQuoteIncentivi, A164FQuoteIncentivi);
  Application.CreateForm(TA164FQuoteIncentiviDtM, A164FQuoteIncentiviDtM);
  Application.Run;
end.
