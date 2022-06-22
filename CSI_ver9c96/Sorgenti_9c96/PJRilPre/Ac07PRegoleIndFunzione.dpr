program Ac07PRegoleIndFunzione;

uses
  Forms,
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  Ac07URegoleIndFunzioneDM in 'Ac07URegoleIndFunzioneDM.pas' {Ac07FRegoleIndFunzioneDM: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  Ac07URegoleIndFunzione in 'Ac07URegoleIndFunzione.pas' {Ac07FRegoleIndFunzione},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  Ac07URegoleIndFunzioneMW in '..\MWRilPre\Ac07URegoleIndFunzioneMW.pas' {Ac07FRegoleIndFunzioneMW: TDataModule},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TAc07FRegoleIndFunzione, Ac07FRegoleIndFunzione);
  Application.CreateForm(TAc07FRegoleIndFunzioneDM, Ac07FRegoleIndFunzioneDM);
  Application.Run;
end.
