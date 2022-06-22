program A049PStampaPasti;

uses
  Forms,
  MidasLib,
  A049UDialogStampa in 'A049UDialogStampa.pas' {A049FDialogStampa},
  A049UStampa in 'A049UStampa.pas' {A049FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A049UStampaPastiMW in '..\MWRilPre\A049UStampaPastiMW.pas' {A049FStampaPastiMW: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A049UStampaPastiDtM1 in 'A049UStampaPastiDtM1.pas' {A049FStampaPastiDtM1: TDataModule},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA049FDialogStampa, A049FDialogStampa);
  Application.CreateForm(TA049FStampaPastiDtM1, A049FStampaPastiDtM1);
  Application.Run;
end.
