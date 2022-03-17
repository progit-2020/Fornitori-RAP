program P686PCalcoloFondi;

uses
  Forms,
  P686UCalcoloFondi in 'P686UCalcoloFondi.pas' {P686FCalcoloFondi},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  P686UCalcoloFondiDtM in 'P686UCalcoloFondiDtM.pas' {P686FCalcoloFondiDtM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TP686FCalcoloFondi, P686FCalcoloFondi);
  Application.CreateForm(TP686FCalcoloFondiDtM, P686FCalcoloFondiDtM);
  Application.Run;
end.
