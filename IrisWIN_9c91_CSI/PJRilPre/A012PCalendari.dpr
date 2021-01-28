program A012PCalendari;

uses
  Forms,
  A012UCalendari in 'A012UCalendari.Pas' {A012FCalendari},
  A012UCalendariDtM1 in 'A012UCalendariDtM1.pas' {A012FCalendariDtM1: TDataModule},
  A012USviluppo in 'A012USviluppo.pas' {A012FSviluppo},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA012FCalendari, A012FCalendari);
  Application.CreateForm(TA012FCalendariDtM1, A012FCalendariDtM1);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.Run;
end.
