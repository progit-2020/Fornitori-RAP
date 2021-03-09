program A071PRegoleBuoni;

uses
  Forms,
  A071URegoleBuoni in 'A071URegoleBuoni.pas' {A071FRegoleBuoni},
  A071URegoleBuoniDtM1 in 'A071URegoleBuoniDtM1.pas' {A071FRegoleBuoniDtM1: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA071FRegoleBuoni, A071FRegoleBuoni);
  Application.CreateForm(TA071FRegoleBuoniDtM1, A071FRegoleBuoniDtM1);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.Run;
end.
