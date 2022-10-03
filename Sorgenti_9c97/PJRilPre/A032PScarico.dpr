program A032PScarico;

uses
  Forms,
  A000UInterfaccia,
  A000USessione,
  A032UScarico in 'A032UScarico.pas' {A032FScarico},
  R200UScaricoTimbratureDtM in '..\MWRilPre\R200UScaricoTimbratureDtM.pas' {R200FScaricoTimbratureDtM: TDataModule};

{$R *.RES}

begin
  // memory leak
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;

  Application.Initialize;

  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  Application.CreateForm(TA032FScarico, A032FScarico);
  A032FScarico.R200DM.SessioneOracleB006:=SessioneOracle;
  A032FScarico.R200DM.ConnettiDataBase(SessioneOracle.LogonDatabase);

  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  // datamodule creato nell'evento oncreate della form
  //Application.CreateForm(TR200FScaricoTimbratureDtM, R200FScaricoTimbratureDtM);
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  Application.Run;
end.
