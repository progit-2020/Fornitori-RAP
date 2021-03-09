program B005PAggIris;

uses
  Forms,
  HTMLHelpViewer,
  MidasLib,
  OracleMonitor,
  B005UAggIris in 'B005UAggIris.pas' {B005FAggIris},
  B005UAggIrisDtM1 in 'B005UAggIrisDtM1.pas' {B005FAggIrisDtM1: TDataModule},
  B005UInvioEMail in 'B005UInvioEMail.pas' {B005FInvioEMail};

{$R *.RES}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Aggiornamento base dati';
  Application.HelpFile := 'Help\IrisWIN_accessori.chm';
  Application.CreateForm(TB005FAggIris, B005FAggIris);
  Application.CreateForm(TB005FAggIrisDtM1, B005FAggIrisDtM1);
  Application.Run;
end.
