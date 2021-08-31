program A119PPartecipazioneScioperi;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A119UPartecipazioneScioperi in 'A119UPartecipazioneScioperi.pas' {A119FPartecipazioneScioperi},
  A119UPartecipazioneScioperiDM in 'A119UPartecipazioneScioperiDM.pas' {A119FPartecipazioneScioperiDM: TDataModule},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A119UPartecipazioneScioperiMW in '..\MWRilPre\A119UPartecipazioneScioperiMW.pas' {A119FPartecipazioneScioperiMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TA119FPartecipazioneScioperi, A119FPartecipazioneScioperi);
  Application.CreateForm(TA119FPartecipazioneScioperiDM, A119FPartecipazioneScioperiDM);
  Application.Run;
end.
