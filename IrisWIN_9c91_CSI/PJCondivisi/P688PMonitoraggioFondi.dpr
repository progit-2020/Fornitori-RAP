program P688PMonitoraggioFondi;

uses
  Forms,
  P688UMonitoraggioFondi in 'P688UMonitoraggioFondi.pas' {P688FMonitoraggioFondi},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  P688UMonitoraggioFondiDtM in 'P688UMonitoraggioFondiDtM.pas' {P688FMonitoraggioFondiDtM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TP688FMonitoraggioFondi, P688FMonitoraggioFondi);
  Application.CreateForm(TP688FMonitoraggioFondiDtM, P688FMonitoraggioFondiDtM);
  Application.Run;
end.
