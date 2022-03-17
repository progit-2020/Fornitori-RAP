program B010PMessaggiOrologiSrv;

uses
  SvcMgr,
  MidasLib,
  B010UMessaggiOrologiSrv in 'B010UMessaggiOrologiSrv.pas' {B010FMessaggiOrologiSrv: TService},
  B010UMessaggiOrologiDTM1 in 'B010UMessaggiOrologiDTM1.pas' {B010FMessaggiOrologiDTM1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TB010FMessaggiOrologiSrv, B010FMessaggiOrologiSrv);
  Application.Run;
end.
