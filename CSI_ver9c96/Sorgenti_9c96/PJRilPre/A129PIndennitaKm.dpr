program A129PIndennitaKm;

uses
  Forms,
  R004UGestStorico in '..\REPOSITARY\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\REPOSITARY\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A129UIndennitaKmDtm in 'A129UIndennitaKmDtm.pas' {A129FIndennitaKmDtm: TDataModule},
  A129UIndennitaKm in 'A129UIndennitaKm.pas' {A129FIndennitaKm},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A129UIndennitaKmMW in '..\MWRilPre\A129UIndennitaKmMW.pas' {A129FIndennitaKmMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA129FIndennitaKm, A129FIndennitaKm);
  Application.CreateForm(TA129FIndennitaKmDtm, A129FIndennitaKmDtm);
  Application.Run;
end.
