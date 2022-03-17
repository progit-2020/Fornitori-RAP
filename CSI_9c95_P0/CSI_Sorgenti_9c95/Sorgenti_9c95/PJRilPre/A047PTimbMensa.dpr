program A047PTimbMensa;

uses
  Forms,
  MidasLib,
  A047UTimbMensa in 'A047UTimbMensa.pas' {A047FTimbMensa},
  A047UTimbMensaDtM1 in 'A047UTimbMensaDtM1.pas' {A047FTimbMensaDtM1: TDataModule},
  A047UGestTimbraMensa in 'A047UGestTimbraMensa.pas' {A047FGestTimbraMensa},
  A047UAnomMensa in 'A047UAnomMensa.pas' {A047FAnomMensa},
  A047UStampaTimbMensa in 'A047UStampaTimbMensa.pas' {A047FStampaTimbMensa},
  A047UDialogStampa in 'A047UDialogStampa.pas' {A047FDialogStampa},
  TABELLE99 in '..\Repositary\TABELLE99.pas' {FrmTabelle99},
  R002UQREP in '..\REPOSITARY\R002UQREP.pas' {R002FQRep},
  A047UStampaGiornaliera in 'A047UStampaGiornaliera.pas' {A047FStampaGiornaliera},
  A047UAccessoManuale in 'A047UAccessoManuale.pas' {A047FAccessoManuale},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A047URaggrStampa in 'A047URaggrStampa.pas' {A047FRaggrStampa},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A047UTimbMensaMW in '..\MWRilPre\A047UTimbMensaMW.pas' {A047FTimbMensaMW: TDataModule},
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  A000UGestioneTimbraGiustMW in '..\MWRilPre\A000UGestioneTimbraGiustMW.pas' {A000FGestioneTimbraGiustMW: TDataModule};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TA047FTimbMensa, A047FTimbMensa);
  Application.CreateForm(TA047FTimbMensaDtM1, A047FTimbMensaDtM1);
  //Application.CreateForm(TA047FRaggrStampa, A047FRaggrStampa);
  Application.Run;
end.
