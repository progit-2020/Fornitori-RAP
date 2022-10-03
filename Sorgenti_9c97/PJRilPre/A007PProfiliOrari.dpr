program A007PProfiliOrari;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A007UProfiliOrari in 'A007UProfiliOrari.pas' {A007FProfiliOrari},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A007UProfiliOrariDtM1 in 'A007UProfiliOrariDtM1.pas' {A007FProfiliOrariDtM1: TDataModule},
  A007USelezOrari in 'A007USelezOrari.pas' {A007FSelezOrari},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA007FProfiliOrari, A007FProfiliOrari);
  Application.CreateForm(TA007FProfiliOrariDtM1, A007FProfiliOrariDtM1);
  Application.CreateForm(TA007FSelezOrari, A007FSelezOrari);
  Application.Run;
end.
