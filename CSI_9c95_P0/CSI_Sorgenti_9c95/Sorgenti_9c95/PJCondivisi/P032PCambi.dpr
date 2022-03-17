program P032PCambi;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  P032UCambi in 'P032UCambi.pas' {P032FCambi},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  P032UCambiDtM in 'P032UCambiDtM.pas' {P032FCambiDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P032UCambiMW in '..\MWCondivisi\P032UCambiMW.pas' {P032FCambiMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TP032FCambi, P032FCambi);
  Application.CreateForm(TP032FCambiDtM, P032FCambiDtM);
  Application.Run;
end.
