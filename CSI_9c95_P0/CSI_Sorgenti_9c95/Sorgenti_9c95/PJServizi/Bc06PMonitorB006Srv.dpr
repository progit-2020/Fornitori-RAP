program Bc06PMonitorB006Srv;

uses
  SvcMgr,
  MidasLib,
  OracleMonitor,
  Bc06UMonitorB006Srv in 'Bc06UMonitorB006Srv.pas' {Bc06FMonitorB006Srv: TService},
  Bc06UExecMonitorB006DtM in 'Bc06UExecMonitorB006DtM.pas' {Bc06FExecMonitorB006DtM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TBc06FMonitorB006Srv, Bc06FMonitorB006Srv);
  Application.Run;
end.
