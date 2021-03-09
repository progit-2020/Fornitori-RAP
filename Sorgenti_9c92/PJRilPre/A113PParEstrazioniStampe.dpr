program A113PParEstrazioniStampe;

uses
  Forms,
  MidasLib,
  A113UParEstrazioniStampe in 'A113UParEstrazioniStampe.pas' {A113FParEstrazioniStampe},
  A113UParEstrazioniStampeDTM1 in 'A113UParEstrazioniStampeDTM1.pas' {A113FParEstrazioniStampeDTM1: TDataModule},
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA113FParEstrazioniStampeDTM1, A113FParEstrazioniStampeDTM1);
  Application.CreateForm(TA113FParEstrazioniStampe, A113FParEstrazioniStampe);
  Application.Run;
end.
