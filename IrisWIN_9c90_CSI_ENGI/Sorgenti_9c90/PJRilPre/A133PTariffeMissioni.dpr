program A133PTariffeMissioni;

uses
  Forms,
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A133UTariffeMissioniDtM in 'A133UTariffeMissioniDtM.pas' {A133FTariffeMissioniDtM: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A133UTariffeMIssioni in 'A133UTariffeMIssioni.pas' {A133FTariffeMissioni},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A133UTariffeMissioniMW in '..\MWRilPre\A133UTariffeMissioniMW.pas' {A133FTariffeMissioniMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA133FTariffeMissioni, A133FTariffeMissioni);
  Application.CreateForm(TA133FTariffeMissioniDtM, A133FTariffeMissioniDtM);
  Application.Run;
end.
