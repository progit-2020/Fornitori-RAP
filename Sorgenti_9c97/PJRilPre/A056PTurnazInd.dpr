program A056PTurnazInd;

uses
  Forms,
  A056UTurnazInd in 'A056UTurnazInd.pas' {A056FTurnazInd},
  A056UTurnazIndDtM1 in 'A056UTurnazIndDtM1.pas' {A056FTurnazIndDtM1: TDataModule},
  A056UGrigliaCicli in 'A056UGrigliaCicli.pas' {A056FGrigliaCicli},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A056UTurnazIndMW in '..\MWRilPre\A056UTurnazIndMW.pas' {A056FTurnazIndMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA056FTurnazInd, A056FTurnazInd);
  Application.CreateForm(TA056FTurnazIndDtM1, A056FTurnazIndDtM1);
  Application.Run;
end.
