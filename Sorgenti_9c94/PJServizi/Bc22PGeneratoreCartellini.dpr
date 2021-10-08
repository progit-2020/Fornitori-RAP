program Bc22PGeneratoreCartellini;

uses
  Vcl.Forms,
  MidasLib,
  OracleMonitor,
  Bc22UGeneratoreCartellini in 'Bc22UGeneratoreCartellini.pas' {Bc22FGeneratoreCartellini},
  Bc22UGeneratoreCartelliniMW in '..\MWCondivisi\Bc22UGeneratoreCartelliniMW.pas' {Bc22FGeneratoreCartelliniMW: TDataModule},
  C020UVisualizzaDataSet in '..\Copy\C020UVisualizzaDataSet.pas' {C020FVisualizzaDataSet},
  W009UStampaCartellinoDtm in '..\PJIrisWeb\W009UStampaCartellinoDtm.pas' {W009FStampaCartellinoDtm: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  Application.Initialize;
  Application.HelpFile := 'Help\IrisWIN_accessori.chm';
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TBc22FGeneratoreCartellini, Bc22FGeneratoreCartellini);
  Application.Run;
end.
