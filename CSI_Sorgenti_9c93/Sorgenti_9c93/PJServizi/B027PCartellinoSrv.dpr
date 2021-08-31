program B027PCartellinoSrv;

uses
  SvcMgr,
  MidasLib,
  B027UCartellinoSrv in 'B027UCartellinoSrv.pas' {B027FCartellinoSrv: TService},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A027UCarMen in '..\PJRilPre\A027UCarMen.pas' {A027FCarMen},
  A027UStampaTesto in '..\PJRilPre\A027UStampaTesto.pas' {A027FStampaTesto},
  A027UStampaTimb in '..\PJRilPre\A027UStampaTimb.pas' {A027StampaTimb};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TB027FCartellinoSrv, B027FCartellinoSrv);
  Application.Run;
end.
