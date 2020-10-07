program A050POrologi;

uses
  Forms,
  A050UOrologi in 'A050UOrologi.pas' {A050FOrologi},
  A050UOrologiDTM1 in 'A050UOrologiDTM1.pas' {A050FOrologiDtM1: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA050FOrologi, A050FOrologi);
  Application.CreateForm(TA050FOrologiDtM1, A050FOrologiDtM1);
  Application.Run;
end.
