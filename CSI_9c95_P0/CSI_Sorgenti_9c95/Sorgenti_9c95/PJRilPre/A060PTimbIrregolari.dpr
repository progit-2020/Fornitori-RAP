program A060PTimbIrregolari;

uses
  Forms,
  A060UTimbIrregolari in 'A060UTimbIrregolari.pas' {A060FTimbIrregolari},
  A060UTimbIrregolariDtM1 in 'A060UTimbIrregolariDtM1.pas' {A060FTimbIrregolariDtM1: TDataModule},
  A060UTimbIrregolariMW in '..\MWRilPre\A060UTimbIrregolariMW.pas' {A060FTimbIrregolariMW: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA060FTimbIrregolari, A060FTimbIrregolari);
  Application.CreateForm(TA060FTimbIrregolariDtM1, A060FTimbIrregolariDtM1);
  Application.Run;
end.
