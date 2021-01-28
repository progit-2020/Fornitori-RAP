program S720PProfiliAree;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  S720UProfiliAree in 'S720UProfiliAree.pas' {S720FProfiliAree},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  S720UProfiliAreeDtM in 'S720UProfiliAreeDtM.pas' {S720FProfiliAreeDtM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TS720FProfiliAree, S720FProfiliAree);
  Application.CreateForm(TS720FProfiliAreeDtM, S720FProfiliAreeDtM);
  Application.Run;
end.
