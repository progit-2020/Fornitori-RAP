program A111PParMessaggi;

uses
  Forms,
  MidasLib,
  A111UParMessaggi in 'A111UParMessaggi.pas' {A111FParMessaggi},
  A111UParMessaggiDTM1 in 'A111UParMessaggiDTM1.pas' {A111FParMessaggiDTM1: TDataModule},
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A111UParMessaggiMW in '..\MWRilPre\A111UParMessaggiMW.pas' {A111FParMessaggiMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA111FParMessaggi, A111FParMessaggi);
  Application.CreateForm(TA111FParMessaggiDTM1, A111FParMessaggiDTM1);
  Application.Run;
end.
