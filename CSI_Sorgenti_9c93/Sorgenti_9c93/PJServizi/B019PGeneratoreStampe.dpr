program B019PGeneratoreStampe;

uses
  Forms,
  HTMLHelpViewer,
  MidasLib,
  OracleMonitor,
  B019UGeneratoreStampe in 'B019UGeneratoreStampe.pas' {B019FGeneratoreStampe},
  B019UGeneratoreStampeDTM in 'B019UGeneratoreStampeDTM.pas' {B019FGeneratoreStampeDtM: TDataModule},
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  B019USchedulazione in 'B019USchedulazione.pas' {B019FSchedulazione},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'Help/IrisWIN_accessori.chm';
  Application.CreateForm(TB019FGeneratoreStampeDtM, B019FGeneratoreStampeDtM);
  Application.CreateForm(TB019FGeneratoreStampe, B019FGeneratoreStampe);
  Application.Run;
end.
