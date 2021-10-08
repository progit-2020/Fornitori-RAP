program B019PGeneratoreStampeSrv;

uses
  SvcMgr,
  MidasLib,
  B019UGeneratoreStampeSrv in 'B019UGeneratoreStampeSrv.pas' {B019FGeneratoreStampeSrv: TService},
  B019UGeneratoreStampeDTM in 'B019UGeneratoreStampeDTM.pas' {B019FGeneratoreStampeDtM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TB019FGeneratoreStampeSrv, B019FGeneratoreStampeSrv);
  Application.Run;
end.
