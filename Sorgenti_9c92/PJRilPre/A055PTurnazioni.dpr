program A055PTurnazioni;

uses
  Forms,
  A055UTurnazioni in 'A055UTurnazioni.pas' {A055FTurnazioni},
  A055UTurnazioniDtM1 in 'A055UTurnazioniDtM1.pas' {A055FTurnazioniDtM1: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A055UTurnazioniMW in '..\MWRilPre\A055UTurnazioniMW.pas' {A055FTurnazioniMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA055FTurnazioni, A055FTurnazioni);
  Application.CreateForm(TA055FTurnazioniDtM1, A055FTurnazioniDtM1);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.Run;
end.
