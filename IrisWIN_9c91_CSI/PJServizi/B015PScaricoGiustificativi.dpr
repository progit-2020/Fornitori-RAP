program B015PScaricoGiustificativi;

uses
  Forms,
  HtmlHelpViewer,
  MidasLib,
  B015UScaricoGiustificativi in 'B015UScaricoGiustificativi.pas' {B015FScaricoGiustificativi},
  B015UPianificazioneScarichi in 'B015UPianificazioneScarichi.pas' {B015FPianificazioneScarichi},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  R250UScaricoGiustificativiDtM in '..\MWRilPre\R250UScaricoGiustificativiDtM.pas' {R250FScaricoGiustificativiDtM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'Help\IrisWIN_accessori.chm';
  Application.CreateForm(TB015FScaricoGiustificativi, B015FScaricoGiustificativi);
  Application.CreateForm(TB015FPianificazioneScarichi, B015FPianificazioneScarichi);
  Application.CreateForm(TR250FScaricoGiustificativiDtM, R250FScaricoGiustificativiDtM);
  Application.Run;
end.
