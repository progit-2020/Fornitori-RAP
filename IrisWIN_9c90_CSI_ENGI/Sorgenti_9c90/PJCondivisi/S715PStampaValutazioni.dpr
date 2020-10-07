program S715PStampaValutazioni;

uses
  Forms,
  MidasLib,
  S715UDialogStampa in 'S715UDialogStampa.pas' {S715FDialogStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  S715UStampaValutazioni in 'S715UStampaValutazioni.pas' {S715FStampaValutazioni},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  S715UStampaValutazioniDtM in 'S715UStampaValutazioniDtM.pas' {S715FStampaValutazioniDtM: TDataModule},
  S715UProtocolloService in 'S715UProtocolloService.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  S715UStampaValutazioniMW in '..\MWCondivisi\S715UStampaValutazioniMW.pas' {S715FStampaValutazioniMW: TDataModule},
  A000UCostanti in '..\Copy\A000UCostanti.pas';

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.CreateForm(TS715FDialogStampa, S715FDialogStampa);
  //17/02/2015 Remmati per eliminare memoryleak sempre esisti!!!
  //Application.CreateForm(TR004FGestStoricoDtM, R004FGestStoricoDtM);
  //Application.CreateForm(TR002FQRep, R002FQRep);
  Application.CreateForm(TS715FStampaValutazioniDtM, S715FStampaValutazioniDtM);
  Application.Run;
end.
