program A160PRegoleIncentivi;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A160URegoleIncentiviDtM in 'A160URegoleIncentiviDtM.pas' {A160FRegoleIncentiviDtM: TDataModule},
  R004UGestStorico in '..\REPOSITARY\R004UGestStorico.pas' {R004FGestStorico},
  A160URegoleIncentivi in 'A160URegoleIncentivi.pas' {A160FRegoleIncentivi},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A160URegoleIncentiviMW in '..\MWRilPre\A160URegoleIncentiviMW.pas' {A160FRegoleIncentiviMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA160FRegoleIncentivi, A160FRegoleIncentivi);
  Application.CreateForm(TA160FRegoleIncentiviDtM, A160FRegoleIncentiviDtM);
  Application.Run;
end.
