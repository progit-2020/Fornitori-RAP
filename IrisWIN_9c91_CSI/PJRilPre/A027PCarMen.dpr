program A027PCarMen;

uses
  Forms,
  A027UCarMen in 'A027UCarMen.pas' {A027FCarMen},
  A027UStampaTimb in 'A027UStampaTimb.pas' {A027StampaTimb},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R400UCartellinoDtM in '..\MWRilPre\R400UCartellinoDtM.pas' {R400FCartellinoDtM: TDataModule},
  A027UStampaTesto in 'A027UStampaTesto.pas' {A027FStampaTesto},
  A027UCostanti in '..\Copy\A027UCostanti.pas',
  A027UCarMenDtM in 'A027UCarMenDtM.pas' {A027FCarMenDtM: TDataModule},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A027UStraoAutorizzato in 'A027UStraoAutorizzato.pas' {A027FStraoAutorizzato},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  Application.Initialize;
  Application.CreateForm(TA027FCarMen, A027FCarMen);
  Application.Run;
end.
