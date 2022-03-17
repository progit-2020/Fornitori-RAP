program A035PParScarico;

uses
  Forms,
  A035UParScarico in 'A035UParScarico.pas' {A035FParScarico},
  A035UParScaricoDTM1 in 'A035UParScaricoDTM1.pas' {A035FParScaricoDTM1: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}


begin
  Application.Initialize;
  Application.CreateForm(TA035FParScarico, A035FParScarico);
  Application.CreateForm(TA035FParScaricoDTM1, A035FParScaricoDTM1);
  Application.Run;
end.
