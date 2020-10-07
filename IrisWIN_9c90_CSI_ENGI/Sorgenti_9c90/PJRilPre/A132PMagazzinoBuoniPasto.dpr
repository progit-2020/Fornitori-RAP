program A132PMagazzinoBuoniPasto;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A132UMagazzinoBuoniPasto in 'A132UMagazzinoBuoniPasto.pas' {A132FMagazzinoBuoniPasto},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A132UMagazzinoBuoniPastoDtM in 'A132UMagazzinoBuoniPastoDtM.pas' {A132FMagazzinoBuoniPastoDtM: TDataModule},
  A132UControllo in 'A132UControllo.pas' {A132FControllo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA132FMagazzinoBuoniPastoDtM, A132FMagazzinoBuoniPastoDtM);
  Application.CreateForm(TA132FMagazzinoBuoniPasto, A132FMagazzinoBuoniPasto);
  Application.CreateForm(TA132FControllo, A132FControllo);
  Application.Run;
end.
