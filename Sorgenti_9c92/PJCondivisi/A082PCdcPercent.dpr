program A082PCdcPercent;

uses
  Forms,
  MidasLib,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A082UCdCPercent in 'A082UCdCPercent.pas' {A082FCdcPercent},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A082UCdcPercentDtM in 'A082UCdcPercentDtM.pas' {A082FCdcPercentDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A082UCdcPercentMW in '..\MWRilPre\A082UCdcPercentMW.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA082FCdcPercent, A082FCdcPercent);
  Application.CreateForm(TA082FCdcPercentDtM, A082FCdcPercentDtM);
  Application.Run;
end.
