program A031PParScarico;

uses
  Forms,
  R001UGestTab in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A031UParScarico in 'A031UParScarico.pas' {A031FParScarico},
  A031UParScaricoDtM1 in 'A031UParScaricoDtM1.pas' {A031FParScaricoDtM1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA031FParScarico, A031FParScarico);
  Application.CreateForm(TA031FParScaricoDtM1, A031FParScaricoDtM1);
  Application.Run;
end.
