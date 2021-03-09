program A172PSchedeQuantIndividuali;

uses
  Forms,
  A172USchedeQuantIndividuali in 'A172USchedeQuantIndividuali.pas' {A172FSchedeQuantIndividuali},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A172USchedeQuantIndividualiDtM in 'A172USchedeQuantIndividualiDtM.pas' {A172FSchedeQuantIndividualiDtM: TDataModule},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A172USchedeQuantObiettivi in 'A172USchedeQuantObiettivi.pas' {A172FSchedeQuantObiettivi},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A172USchedeQuantIndividualiMW in '..\MWRilPre\A172USchedeQuantIndividualiMW.pas' {A172FSchedeQuantIndividualiMW: TDataModule},
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA172FSchedeQuantIndividuali, A172FSchedeQuantIndividuali);
  Application.CreateForm(TA172FSchedeQuantIndividualiDtM, A172FSchedeQuantIndividualiDtM);
  Application.Run;
end.
