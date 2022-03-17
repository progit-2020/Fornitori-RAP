program B021PTest;

uses
  Forms,
  B021UTest in 'B021UTest.pas' {B021FTest};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TB021FTest, B021FTest);
  Application.Run;
end.
