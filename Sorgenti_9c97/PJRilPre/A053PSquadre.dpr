program A053PSquadre;

uses
  Forms,
  A053USquadre in 'A053USquadre.pas' {A053FSquadre},
  A053USquadreDtM1 in 'A053USquadreDtM1.pas' {A053FSquadreDtM1: TDataModule},
  R001UGestTab in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA053FSquadre, A053FSquadre);
  Application.CreateForm(TA053FSquadreDtM1, A053FSquadreDtM1);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.Run;
end.
