program A147PRepVincoliIndividuali;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A147URepVincoliIndividuali in 'A147URepVincoliIndividuali.pas' {A147FRepVincoliIndividuali},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A147URepVincoliIndividualiDtM in 'A147URepVincoliIndividualiDtM.pas' {A147FRepVincoliIndividualiDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A147URepVincoliIndividualiMW in '..\MWRilPre\A147URepVincoliIndividualiMW.pas' {A147FRepVincoliIndividualiMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA147FRepVincoliIndividuali, A147FRepVincoliIndividuali);
  Application.CreateForm(TA147FRepVincoliIndividualiDtM, A147FRepVincoliIndividualiDtM);
  Application.Run;
end.
