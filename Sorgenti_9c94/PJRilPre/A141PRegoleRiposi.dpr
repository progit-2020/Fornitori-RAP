program A141PRegoleRiposi;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A141URegoleRiposi in 'A141URegoleRiposi.pas' {A141FRegoleRiposi},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A141URegoleRiposiDtM in 'A141URegoleRiposiDtM.pas' {A141FRegoleRiposiDtM: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA141FRegoleRiposi, A141FRegoleRiposi);
  Application.CreateForm(TA141FRegoleRiposiDtM, A141FRegoleRiposiDtM);
  Application.Run;
end.
