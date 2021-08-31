program S735PPunteggiFasceIncentivi;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  S735UPunteggiFasceIncentiviDtM in 'S735UPunteggiFasceIncentiviDtM.pas' {S735FPunteggiFasceIncentiviDtM: TDataModule},
  S735UPunteggiFasceIncentivi in 'S735UPunteggiFasceIncentivi.pas' {S735FPunteggiFasceIncentivi},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  S735UPunteggiFasceIncentiviMW in '..\MWCondivisi\S735UPunteggiFasceIncentiviMW.pas' {S735FPunteggiFasceIncentiviMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TS735FPunteggiFasceIncentivi, S735FPunteggiFasceIncentivi);
  Application.CreateForm(TS735FPunteggiFasceIncentiviDtM, S735FPunteggiFasceIncentiviDtM);
  Application.Run;
end.
