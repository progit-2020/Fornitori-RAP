program B021PIrisRestSvc;

{$APPTYPE GUI}

uses
  Forms,
  OracleMonitor,
  R014URestDM in '..\Repositary\R014URestDM.pas' {R014FRestDM: TDataModule},
  B021UForm in 'B021UForm.pas' {B021FForm},
  B021UIrisRestSvcDM in 'B021UIrisRestSvcDM.pas' {B021FIrisRestSvcDM: TDataModule},
  B021UListener in 'B021UListener.pas' {B021FListener: TWebModule},
  B021UCustomConverter in 'B021UCustomConverter.pas',
  B021UUtils in 'B021UUtils.pas',
  B021UAnagraficoDM in 'B021UAnagraficoDM.pas' {B021FAnagraficoDM: TDataModule},
  B021UTurniDM in 'B021UTurniDM.pas' {B021FTurniDM: TDataModule},
  B021UConteggiDM in 'B021UConteggiDM.pas' {B021FConteggiDM: TDataModule},
  B021UAssenzeDM in 'B021UAssenzeDM.pas' {B021FAssenzeDM: TDataModule},
  B021UGiustificativiDM in 'B021UGiustificativiDM.pas' {B021FGiustificativiDM: TDataModule},
  B021UControlliGeneraliDM in 'B021UControlliGeneraliDM.pas' {B021FControlliGeneraliDM: TDataModule},
  B021UDizionarioDM in 'B021UDizionarioDM.pas' {B021FDizionarioDM: TDataModule},
  B021UTimbratureConteggiateDM in 'B021UTimbratureConteggiateDM.pas' {B021FTimbratureConteggiateDM: TDataModule},
  B021UTimbratureDM in 'B021UTimbratureDM.pas' {B021FTimbratureDM: TDataModule},
  B021UAnaOpeFSEDM in 'B021UAnaOpeFSEDM.pas' {B021FAnaOpeFSEDM: TDataModule},
  B021UMancopPersMMDM in 'B021UMancopPersMMDM.pas' {B021FMancopPersMMDM: TDataModule},
  B021UMancopPersGGDM in 'B021UMancopPersGGDM.pas' {B021FMancopPersGGDM: TDataModule},
  C200UWebServicesUtils in '..\Copy\C200UWebServicesUtils.pas',
  B021UC021DocumentoBlobDM in 'B021UC021DocumentoBlobDM.pas' {B021FC021DocumentoBlobDM: TDataModule},
  C021UDocumentiManagerDM in '..\Copy\C021UDocumentiManagerDM.pas' {C021FDocumentiManagerDM: TDataModule},
  B021UC021DocumentoBlobTicketDM in 'B021UC021DocumentoBlobTicketDM.pas' {B021FC021DocumentoBlobTicketDM: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  // verificare che le uniche 2 Form create siano
  // - TB021FForm
  // - TB021FListener
  Application.CreateForm(TB021FForm, B021FForm);
  Application.CreateForm(TB021FListener, B021FListener);
  Application.Run;
end.

