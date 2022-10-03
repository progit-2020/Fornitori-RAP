program A038PVociVariabili;

uses
  Forms,
  A038UVociVariabili in 'A038UVociVariabili.pas' {A038FVociVariabili},
  A038UVociVariabiliDtM1 in 'A038UVociVariabiliDtM1.pas' {A038FVociVariabiliDtM1: TDataModule},
  R002UQREP in '..\REPOSITARY\R002UQREP.pas' {R002FQRep},
  A038UStampaVoci in 'A038UStampaVoci.pas' {A038FStampaVoci},
  A038UDialogStampa in 'A038UDialogStampa.pas' {A038FDialogStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A038UDecodificaVoci in 'A038UDecodificaVoci.pas' {A038FDecodificaVoci},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A038UVociVariabiliMW in '..\MWRilPre\A038UVociVariabiliMW.pas' {A038FVociVariabiliMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA038FVociVariabili, A038FVociVariabili);
  Application.CreateForm(TA038FVociVariabiliDtM1, A038FVociVariabiliDtM1);
  Application.CreateForm(TA038FDecodificaVoci, A038FDecodificaVoci);
  Application.Run;
end.
