program P150PSetup;

uses
  Forms,
  MidasLib,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  P150USetup in 'P150USetup.pas' {P150FSetup},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  P150USetupDtM in 'P150USetupDtM.pas' {P150FSetupDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P150USetupMW in '..\MWCondivisi\P150USetupMW.pas' {P150FSetupMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TP150FSetup, P150FSetup);
  Application.CreateForm(TP150FSetupDtM, P150FSetupDtM);
  Application.Run;
end.
