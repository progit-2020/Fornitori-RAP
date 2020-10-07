program Bc28PPrintServer_COM;

uses
  Forms,
  MidasLib,
  Bc28PPrintServer_COM_TLB in 'Bc28PPrintServer_COM_TLB.pas',
  Bc28UPrintServerDM in 'Bc28UPrintServerDM.pas' {Bc28PrintServer: TRemoteDataModule} {Bc28PrintServer: CoClass},
  Bc28UPRovastampa in 'Bc28UPRovastampa.pas' {Bc28FProvaStampa},
  Bc28UTest in 'Bc28UTest.pas' {Bc28FTest};

{$R *.TLB}

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TBc28FTest, Bc28FTest);
  Application.Run;
end.
