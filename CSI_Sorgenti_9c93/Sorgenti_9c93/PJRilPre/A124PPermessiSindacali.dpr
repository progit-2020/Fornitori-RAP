program A124PPermessiSindacali;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A124UPermessiSindacali in 'A124UPermessiSindacali.pas' {A124FPermessiSindacali},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A124UPermessiSindacaliDtM in 'A124UPermessiSindacaliDtM.pas' {A124FPermessiSindacaliDtM: TDataModule},
  A124USuperoCompetenze in 'A124USuperoCompetenze.pas' {A124FSuperoCompetenze},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A124UPermessiSindacaliMW in '..\MWRilPre\A124UPermessiSindacaliMW.pas' {A124FPermessiSindacaliMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA124FPermessiSindacali, A124FPermessiSindacali);
  Application.CreateForm(TA124FPermessiSindacaliDtM, A124FPermessiSindacaliDtM);
  Application.Run;
end.
