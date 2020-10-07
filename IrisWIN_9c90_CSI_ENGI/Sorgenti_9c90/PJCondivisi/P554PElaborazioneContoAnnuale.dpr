program P554PElaborazioneContoAnnuale;

uses
  Forms,
  R004UGESTSTORICODTM in '..\REPOSITARY\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  P554UElaborazioneContoAnnualeDtM in 'P554UElaborazioneContoAnnualeDtM.pas' {P554FElaborazioneContoAnnualeDtM: TDataModule},
  P554UElaborazioneContoAnnuale in 'P554UElaborazioneContoAnnuale.pas' {P554FElaborazioneContoAnnuale},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  P554UImpostazioni in 'P554UImpostazioni.pas' {P554FImpostazioni};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TP554FElaborazioneContoAnnualeDtM, P554FElaborazioneContoAnnualeDtM);
  Application.CreateForm(TP554FElaborazioneContoAnnuale, P554FElaborazioneContoAnnuale);
  Application.Run;
end.
