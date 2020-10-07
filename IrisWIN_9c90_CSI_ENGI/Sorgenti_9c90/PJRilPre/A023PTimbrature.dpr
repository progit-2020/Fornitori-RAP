program A023PTimbrature;

uses
  {$IFDEF DEBUG} OracleMonitor, {$ENDIF DEBUG}
  Forms,
  A023UTimbrature in 'A023UTimbrature.pas' {A023FTimbrature},
  A023UTimbratureDtM1 in 'A023UTimbratureDtM1.pas' {A023FTimbratureDtM1: TDataModule},
  A023UGestTimbra in 'A023UGestTimbra.pas' {A023FGestTimbra},
  A023UGestGiustif in 'A023UGestGiustif.pas' {A023FGestGiustif},
  A023UAnomalie in 'A023UAnomalie.pas' {A023FAnomalie},
  A023UTimbMese in 'A023UTimbMese.pas' {A023FTimbMese},
  A023UCorrezione in 'A023UCorrezione.pas' {A023FCorrezione},
  A023UCancTimbRiscaricate in 'A023UCancTimbRiscaricate.pas' {A023FCancTimbRiscaricate},
  TABELLE99 in '..\Repositary\TABELLE99.pas' {FrmTabelle99},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A023UCaricaTimbRich in 'A023UCaricaTimbRich.pas' {A023FCaricaTimbRich},
  A023UGestMese in 'A023UGestMese.pas' {A023FGestMese},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A023UTimbratureMW in '..\MWRilPre\A023UTimbratureMW.pas' {A023FTimbratureMW: TDataModule},
  A023URipristinoTimbOrig in 'A023URipristinoTimbOrig.pas' {A023FRipristinoTimbOrig},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  A023UValidaAssenze in 'A023UValidaAssenze.pas' {A023FValidaAssenze},
  A023UAllTimbUguali in 'A023UAllTimbUguali.pas' {A023FAllTimbUguali},
  A023UAllTimbMW in '..\MWRilPre\A023UAllTimbMW.pas' {A023FAllTimbMW: TDataModule},
  A000UGestioneTimbraGiustMW in '..\MWRilPre\A000UGestioneTimbraGiustMW.pas' {A000FGestioneTimbraGiustMW: TDataModule};

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.CreateForm(TA023FTimbrature, A023FTimbrature);
  Application.CreateForm(TA023FTimbratureDtM1, A023FTimbratureDtM1);
  Application.CreateForm(TA023FValidaAssenze, A023FValidaAssenze);
  Application.CreateForm(TA023FAllTimbUguali, A023FAllTimbUguali);
  Application.CreateForm(TA023FAllTimbMW, A023FAllTimbMW);
  Application.Run;
end.
