program A043PStampaRep;

uses
  Forms,
  MidasLib,
  A043UDialogStampa in 'A043UDialogStampa.pas' {A043FDialogStampa},
  A043UStampa in 'A043UStampa.pas' {A043FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A043UStampaRepMW in '..\MWRilPre\A043UStampaRepMW.pas' {A043FStampaRepMW: TDataModule},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA043FDialogStampa, A043FDialogStampa);
  Application.Run;
end.
