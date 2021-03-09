program A121POrganizzSindacali;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A121UOrganizzSindacali in 'A121UOrganizzSindacali.pas' {A121FOrganizzSindacali},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A121URecapitiSindacati in 'A121URecapitiSindacati.pas' {A121FRecapitiSindacati},
  A121UOrganizzSindacaliDtM in 'A121UOrganizzSindacaliDtM.pas' {A121FOrganizzSindacaliDtM: TDataModule},
  A121URecapitiSindacatiDtM in 'A121URecapitiSindacatiDtM.pas' {A121FRecapitiSindacatiDtM: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A121URecapitiSindacaliMW in '..\MWRilPre\A121URecapitiSindacaliMW.pas' {A121FRecapitiSindacaliMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA121FOrganizzSindacali, A121FOrganizzSindacali);
  Application.CreateForm(TA121FOrganizzSindacaliDtM, A121FOrganizzSindacaliDtM);
  Application.Run;
end.
