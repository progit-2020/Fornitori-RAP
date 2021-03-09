program A104PStampaMissioni;

uses
  Forms,
  MidasLib,
  A104UDialogStampa in 'A104UDialogStampa.pas' {A104FDialogStampa},
  R004UGestStoricoDTM in '..\REPOSITARY\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A104UStampaMissioniDtM1 in 'A104UStampaMissioniDtM1.pas' {A104FStampaMissioniDtM1: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A104UStampaMissioni in 'A104UStampaMissioni.pas' {A104FStampaMissioni: TQuickRep},
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA104FDialogStampa, A104FDialogStampa);
  Application.CreateForm(TA104FStampaMissioniDtM1, A104FStampaMissioniDtM1);
  Application.Run;
end.
