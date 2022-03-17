program B006PScaricoService;

uses
  SvcMgr,
  MidasLib,
  B006UScaricoService in 'B006UScaricoService.pas' {B006FScaricoService: TService},
  R200UScaricoTimbratureDtM in '..\MWRilPre\R200UScaricoTimbratureDtM.pas' {R200FScaricoTimbratureDtM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TB006FScaricoService, B006FScaricoService);
  Application.Run;
end.
