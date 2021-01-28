program A136PRelazioniAnagrafe;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A136URelazioniAnagrafe in 'A136URelazioniAnagrafe.pas' {A136FRelazioniAnagrafe},
  A136URelazioniAnagrafeDtM in 'A136URelazioniAnagrafeDtM.pas' {A136FRelazioniAnagrafeDtM: TDataModule},
  A136UComposizioneRelazione in 'A136UComposizioneRelazione.pas' {A136FComposizioneRelazione},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A136UStampaRelazioni in 'A136UStampaRelazioni.pas' {A136FStampaRelazioni},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A136URelazioniAnagrafeMW in '..\MWRilPre\A136URelazioniAnagrafeMW.pas' {A136FRelazioniAnagrafeMW: TDataModule},
  A136UComposizioneRelazioneMW in '..\MWRilPre\A136UComposizioneRelazioneMW.pas' {A136FComposizioneRelazioneDtM: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA136FRelazioniAnagrafe, A136FRelazioniAnagrafe);
  Application.CreateForm(TA136FRelazioniAnagrafeDtM, A136FRelazioniAnagrafeDtM);
  Application.CreateForm(TA136FStampaRelazioni, A136FStampaRelazioni);
  Application.CreateForm(TA136FComposizioneRelazioneMW, A136FComposizioneRelazioneMW);
  Application.Run;
end.
