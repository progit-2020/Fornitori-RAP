program A169PPesatureIndividuali;

uses
  Forms,
  R004UGESTSTORICODTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A169UPesatureIndividualiDtM in 'A169UPesatureIndividualiDtM.pas' {A169FPesatureIndividualiDtM: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A169UPesatureIndividuali in 'A169UPesatureIndividuali.pas' {A169FPesatureIndividuali},
  A169UCalcoloDtM in 'A169UCalcoloDtM.pas' {A169FCalcoloDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A169UPesatureIndividualiMW in '..\MWRilPre\A169UPesatureIndividualiMW.pas' {A169FPesatureIndividualiMW: TDataModule};

{$R *.res}

begin
//  {$WARN SYMBOL_PLATFORM OFF}
//  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
//  {$WARN SYMBOL_PLATFORM ON}

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA169FPesatureIndividuali, A169FPesatureIndividuali);
  Application.CreateForm(TA169FPesatureIndividualiDtM, A169FPesatureIndividualiDtM);
  Application.Run;
end.
