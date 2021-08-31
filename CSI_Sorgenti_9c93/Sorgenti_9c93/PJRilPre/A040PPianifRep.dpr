program A040PPianifRep;

uses
  Forms,
  OracleMOnitor,
  A040UPianifRepDtM1 in 'A040UPianifRepDtM1.pas' {A040FPianifRepDtM1: TDataModule},
  A040UPianifRep in 'A040UPianifRep.pas' {A040FPianifRep},
  A040UInserimento in 'A040UInserimento.pas' {A040FInserimento},
  A040UDialogStampa in 'A040UDialogStampa.pas' {A040FDialogStampa},
  A040UStampa in 'A040UStampa.pas' {A040FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A040UPianifRepDtM2 in 'A040UPianifRepDtM2.pas' {A040FPianifRepDtM2: TDataModule},
  A040UStampa2 in 'A040UStampa2.pas' {A040FStampa2},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A040UPianifRepMW in '..\MWRilPre\A040UPianifRepMW.pas' {A040FPianifRepMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA040FPianifRep, A040FPianifRep);
  Application.CreateForm(TA040FPianifRepDtM1, A040FPianifRepDtM1);
  Application.CreateForm(TA040FPianifRepDtM2, A040FPianifRepDtM2);
  Application.CreateForm(TA040FStampa2, A040FStampa2);
  Application.Run;
end.
