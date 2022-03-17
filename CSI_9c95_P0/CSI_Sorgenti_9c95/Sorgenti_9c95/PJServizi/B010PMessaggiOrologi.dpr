program B010PMessaggiOrologi;

uses
  Forms,
  HTMLHelpViewer,
  MidasLib,
  B010UMessaggiOrologi in 'B010UMessaggiOrologi.pas' {B010FMessaggiOrologi},
  B010UMessaggiOrologiDTM1 in 'B010UMessaggiOrologiDTM1.pas' {B010FMessaggiOrologiDTM1: TDataModule},
  R001UGestTab in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  B010USchedulazione in 'B010USchedulazione.pas' {B010FSchedulazione};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'Help/IrisWIN_accessori.chm';
  Application.CreateForm(TB010FMessaggiOrologiDTM1, B010FMessaggiOrologiDTM1);
  Application.CreateForm(TB010FMessaggiOrologi, B010FMessaggiOrologi);
  Application.Run;
end.
