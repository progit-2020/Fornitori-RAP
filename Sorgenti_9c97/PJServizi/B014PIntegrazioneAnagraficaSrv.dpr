program B014PIntegrazioneAnagraficaSrv;

uses
  SvcMgr,
  MidasLib,
  B014UIntegrazioneAnagraficaSrv in 'B014UIntegrazioneAnagraficaSrv.pas' {B014FIntegrazioneAnagraficaSrv: TService},
  B014UIntegrazioneAnagraficaDtM in 'B014UIntegrazioneAnagraficaDtM.pas' {B014FIntegrazioneAnagraficaDtM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TB014FIntegrazioneAnagraficaSrv, B014FIntegrazioneAnagraficaSrv);
  Application.Run;
end.
