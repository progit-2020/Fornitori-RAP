program A145PComunicazioneVisiteFiscali;

uses
  Forms,
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A145UComunicazioneVisiteFiscaliDtM in 'A145UComunicazioneVisiteFiscaliDtM.pas' {A145FComunicazioneVisiteFiscaliDtm: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A145UStampaComunicazioneVisiteFiscali in 'A145UStampaComunicazioneVisiteFiscali.pas' {A145FStampaComunicazioneVisiteFiscali},
  A145UComunicazioneVisiteFiscali in 'A145UComunicazioneVisiteFiscali.pas' {A145FComunicazioneVisiteFiscali},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  A145UStampaIndividuale in 'A145UStampaIndividuale.pas' {A145FStampaIndividuale},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A145UEsenzioni in 'A145UEsenzioni.pas' {A145FEsenzioni},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A145UComVisiteFiscaliMW in '..\MWRilPre\A145UComVisiteFiscaliMW.pas' {A145FComVisiteFiscaliMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TA145FComunicazioneVisiteFiscali, A145FComunicazioneVisiteFiscali);
  Application.CreateForm(TA145FComunicazioneVisiteFiscaliDtm, A145FComunicazioneVisiteFiscaliDtm);
  Application.Run;
end.
