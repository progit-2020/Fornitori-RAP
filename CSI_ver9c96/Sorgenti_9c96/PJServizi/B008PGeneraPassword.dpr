program B008PGeneraPassword;

uses
  Forms,
  B008UGeneraPassword in 'B008UGeneraPassword.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
