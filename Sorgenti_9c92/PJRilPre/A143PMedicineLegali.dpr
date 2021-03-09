program A143PMedicineLegali;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A143UMedicineLegali in 'A143UMedicineLegali.pas' {A143FMedicineLegali},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A143UMedicineLegaliDtM in 'A143UMedicineLegaliDtM.pas' {A143FMedicineLegaliDtm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA143FMedicineLegali, A143FMedicineLegali);
  Application.CreateForm(TA143FMedicineLegaliDtm, A143FMedicineLegaliDtm);
  Application.Run;
end.
