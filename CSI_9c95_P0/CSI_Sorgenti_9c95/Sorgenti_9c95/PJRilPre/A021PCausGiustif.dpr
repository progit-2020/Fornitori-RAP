program A021PCausGiustif;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A021UCausGiustif in 'A021UCausGiustif.pas' {A021FCausGiustif},
  A021UCausGiustifDtM1 in 'A021UCausGiustifDtM1.pas' {A021FCausGiustifDtM1: TDataModule},
  A021UAssestAnnuo in 'A021UAssestAnnuo.pas' {A021FAssestAnnuo},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA021FCausGiustif, A021FCausGiustif);
  Application.CreateForm(TA021FCausGiustifDtM1, A021FCausGiustifDtM1);
  Application.Run;
end.
