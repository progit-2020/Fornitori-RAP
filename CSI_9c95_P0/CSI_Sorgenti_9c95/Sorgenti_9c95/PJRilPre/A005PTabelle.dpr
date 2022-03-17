program A005PTabelle;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A005UTabelle in 'A005UTabelle.pas' {A005FTabelle},
  A005UTabelleDtM1 in 'A005UTabelleDtM1.pas' {A005FTabelleDtM1: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA005FTabelle, A005FTabelle);
  Application.CreateForm(TA005FTabelleDtM1, A005FTabelleDtM1);
  Application.Run;
end.
