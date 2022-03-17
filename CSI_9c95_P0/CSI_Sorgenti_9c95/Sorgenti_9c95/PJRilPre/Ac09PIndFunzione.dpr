program Ac09PIndFunzione;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  Ac09UIndFunzione in 'Ac09UIndFunzione.pas' {Ac09FIndFunzione},
  Ac09UIndFunzioneDM in 'Ac09UIndFunzioneDM.pas' {Ac09FIndFunzioneDM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  Ac09UIndFunzioneMW in '..\MWRilPre\Ac09UIndFunzioneMW.pas' {Ac09FIndFunzioneMW: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TAc09FIndFunzioneDM, Ac09FIndFunzioneDM);
  Application.CreateForm(TAc09FIndFunzione, Ac09FIndFunzione);
  Application.Run;
end.
