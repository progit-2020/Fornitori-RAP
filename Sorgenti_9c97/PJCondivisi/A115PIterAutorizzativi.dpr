program A115PIterAutorizzativi;

uses
  Vcl.Forms,
  MidasLib,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A115UIterAutorizzativi in 'A115UIterAutorizzativi.pas' {A115FIterAutorizzativi},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A115UIterAutorizzativiDM in 'A115UIterAutorizzativiDM.pas' {A115FIterAutorizzativiDM: TDataModule},
  A115UIterCondizValidita in 'A115UIterCondizValidita.pas' {A115FIterCondizValidita},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A115UIterAutorizzativiMW in '..\MWCondivisi\A115UIterAutorizzativiMW.pas' {A115FIterAutorizzativiMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA115FIterAutorizzativi, A115FIterAutorizzativi);
  Application.CreateForm(TA115FIterAutorizzativiDM, A115FIterAutorizzativiDM);
  Application.CreateForm(TA115FIterAutorizzativiMW, A115FIterAutorizzativiMW);
  Application.Run;
end.
