program A004PGiustifAssPres;

uses
  Forms,
  A004UGiustifAssPres in 'A004UGiustifAssPres.pas' {A004FGiustifAssPres},
  TABELLE99 in '..\Repositary\TABELLE99.pas' {FrmTabelle99},
  R600UVisAssenzeCumulate in '..\MWRilPre\R600UVisAssenzeCumulate.pas' {R600FVisAssenzeCumulate},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A004UCaricaAssRich in 'A004UCaricaAssRich.pas' {A004FCaricaAssRich},
  A004URecapitoVisFiscali in 'A004URecapitoVisFiscali.pas' {A004FRecapitoVisFiscali},
  R600 in '..\MWRilPre\R600.pas' {R600DtM1: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A004UGiustifAssPresMW in '..\MWRilPre\A004UGiustifAssPresMW.pas' {A004FGiustifAssPresMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  C180FunzioniGenerali in '..\Copy\C180FunzioniGenerali.pas',
  R600UVisAssenze in '..\MWRilPre\R600UVisAssenze.pas' {R600FVisAssenze};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TA004FGiustifAssPres, A004FGiustifAssPres);
  Application.CreateForm(TR600FVisAssenze, R600FVisAssenze);
  Application.Run;
end.
