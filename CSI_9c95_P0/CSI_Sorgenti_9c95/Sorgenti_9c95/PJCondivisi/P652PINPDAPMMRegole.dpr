program P652PINPDAPMMRegole;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  P652UINPDAPMMRegole in 'P652UINPDAPMMRegole.pas' {P652FINPDAPMMRegole},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  P652UINPDAPMMRegoleDtM in 'P652UINPDAPMMRegoleDtM.pas' {P652FINPDAPMMRegoleDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P652UINPDAPMMRegoleMW in '..\MWCondivisi\P652UINPDAPMMRegoleMW.pas' {P652FINPDAPMMRegoleMW: TDataModule},
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WP652UINPDAPMMRegoleDM in '..\PJCloudCondivisi\WP652UINPDAPMMRegoleDM.pas' {WP652FINPDAPMMRegoleDM: TIWUserSessionBase};

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.CreateForm(TP652FINPDAPMMRegole, P652FINPDAPMMRegole);
  // P652FINPDAPMMRegole.sPb_NomeFlusso:='DMA';
  Application.CreateForm(TP652FINPDAPMMRegoleDtM, P652FINPDAPMMRegoleDtM);
  Application.Run;

end.
