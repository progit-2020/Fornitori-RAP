program A046PTerMensa;

uses
  Forms,
  A046UTerMensa in 'A046UTerMensa.pas' {A046FTerMensa},
  A046UTerMensaDTM1 in 'A046UTerMensaDTM1.pas' {A046FTerMensaDTM1: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  C013UCheckList in '..\Copy\C013UCheckList.pas' {C013FCheckList};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA046FTerMensa, A046FTerMensa);
  Application.CreateForm(TA046FTerMensaDTM1, A046FTerMensaDTM1);
  Application.CreateForm(TC013FCheckList, C013FCheckList);
  Application.Run;
end.
