program S706PValutatoriDipendente;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  S706UValutatoriDipendente in 'S706UValutatoriDipendente.pas' {S706FValutatoriDipendente},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  S706UValutatoriDipendenteDtM in 'S706UValutatoriDipendenteDtM.pas' {S706FValutatoriDipendenteDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TS706FValutatoriDipendente, S706FValutatoriDipendente);
  Application.CreateForm(TS706FValutatoriDipendenteDtM, S706FValutatoriDipendenteDtM);
  Application.Run;
end.
