program A128PPianPrestazioniAggiuntive;

uses
  Forms,
  A128UPianPrestazioniAggiuntiveDtm in 'A128UPianPrestazioniAggiuntiveDtm.pas' {A128FPianPrestazioniAggiuntiveDtm: TDataModule},
  A128UPianPrestazioniAggiuntive in 'A128UPianPrestazioniAggiuntive.pas' {A128FPianPrestazioniAggiuntive},
  A128UInserimento in 'A128UInserimento.pas' {A128FInserimento},
  A128UDialogStampa in 'A128UDialogStampa.pas' {A128FDialogStampa},
  A128UStampa in 'A128UStampa.pas' {A128FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A128UAcqFilePrestazioniAggiuntive in 'A128UAcqFilePrestazioniAggiuntive.pas' {A128FAcqFilePrestazioniAggiuntive},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A128UPianPrestazioniAggiuntiveMW in '..\MWRilPre\A128UPianPrestazioniAggiuntiveMW.pas' {A128FPianPrestazioniAggiuntiveMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA128FPianPrestazioniAggiuntive, A128FPianPrestazioniAggiuntive);
  Application.CreateForm(TA128FPianPrestazioniAggiuntiveDtm, A128FPianPrestazioniAggiuntiveDtm);
  Application.CreateForm(TA128FAcqFilePrestazioniAggiuntive, A128FAcqFilePrestazioniAggiuntive);
  Application.Run;
end.
