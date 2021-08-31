program A152PEventiStraord;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A152UEventiStraord in 'A152UEventiStraord.pas' {A152FEventiStraord},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A152UEventiStraordDtM in 'A152UEventiStraordDtM.pas' {A152FEventiStraordDtM: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA152FEventiStraord, A152FEventiStraord);
  Application.CreateForm(TA152FEventiStraordDtM, A152FEventiStraordDtM);
  Application.Run;
end.
