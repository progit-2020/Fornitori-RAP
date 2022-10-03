program P682PRaggruppamentiFondi;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  P682URaggruppamentiFondi in 'P682URaggruppamentiFondi.pas' {P682FRaggruppamentiFondi},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  P682URaggruppamentiFondiDtM in 'P682URaggruppamentiFondiDtM.pas' {P682FRaggruppamentiFondiDtM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TP682FRaggruppamentiFondi, P682FRaggruppamentiFondi);
  Application.CreateForm(TP682FRaggruppamentiFondiDtM, P682FRaggruppamentiFondiDtM);
  Application.Run;
end.
