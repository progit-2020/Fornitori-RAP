program B027PTest;

uses
  Vcl.Forms,
  Midaslib,
  B027UTest in 'B027UTest.pas' {B027FTest};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TB027FTest, B027FTest);
  Application.Run;
end.
