program A045PStatAssenze;

uses
  Forms,
  MidasLib,
  A045UStampa in 'A045UStampa.pas' {A045FStampa},
  A045UDialogStampa in 'A045UDialogStampa.pas' {A045FDialogStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A045UStatAssenzeMW in '..\MWRilPre\A045UStatAssenzeMW.pas' {A045FStatAssenzeMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA045FDialogStampa, A045FDialogStampa);
  Application.Run;
end.
