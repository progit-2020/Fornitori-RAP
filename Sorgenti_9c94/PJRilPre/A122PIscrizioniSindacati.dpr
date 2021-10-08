program A122PIscrizioniSindacati;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A122UIscrizioniSindacati in 'A122UIscrizioniSindacati.pas' {A122FIscrizioniSindacati},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A122UIscrizioniSindacatiDtM in 'A122UIscrizioniSindacatiDtM.pas' {A122FIscrizioniSindacatiDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A122UIscrizioniSindacaliMW in '..\MWRilPre\A122UIscrizioniSindacaliMW.pas' {A122FIscrizioniSindacaliMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA122FIscrizioniSindacati, A122FIscrizioniSindacati);
  Application.CreateForm(TA122FIscrizioniSindacatiDtM, A122FIscrizioniSindacatiDtM);
  Application.Run;
end.
