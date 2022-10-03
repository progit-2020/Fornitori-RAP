program A112PInvioMessaggi;

uses
  Forms,
  MidasLib,
  A112UInvioMessaggi in 'A112UInvioMessaggi.pas' {A112FInvioMessaggi},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A112UInvioMessaggiMW in '..\MWRilPre\A112UInvioMessaggiMW.pas' {A112FInvioMessaggiMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA112FInvioMessaggi, A112FInvioMessaggi);
  Application.Run;
end.
