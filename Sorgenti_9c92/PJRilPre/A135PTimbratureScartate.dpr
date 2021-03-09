program A135PTimbratureScartate;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A135UTimbratureScartate in 'A135UTimbratureScartate.pas' {A135FTimbratureScartate},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A135UTimbratureScartateDtM in 'A135UTimbratureScartateDtM.pas' {A135FTimbratureScartateDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA135FTimbratureScartate, A135FTimbratureScartate);
  Application.CreateForm(TA135FTimbratureScartateDtM, A135FTimbratureScartateDtM);
  Application.Run;
end.
