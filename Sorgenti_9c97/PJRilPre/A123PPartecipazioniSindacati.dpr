program A123PPartecipazioniSindacati;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A123UPartecipazioniSindacati in 'A123UPartecipazioniSindacati.pas' {A123FPartecipazioniSindacati},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A123UPartecipazioniSindacatiDtM in 'A123UPartecipazioniSindacatiDtM.pas' {A123FPartecipazioniSindacatiDtM: TDataModule},
  A123UVisualizzazione in 'A123UVisualizzazione.pas' {A123FVisualizzazione},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A123UPartecipazioniSindacatiMW in '..\MWRilPre\A123UPartecipazioniSindacatiMW.pas' {A123FPartecipazioniSindacatiMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA123FPartecipazioniSindacati, A123FPartecipazioniSindacati);
  Application.CreateForm(TA123FPartecipazioniSindacatiDtM, A123FPartecipazioniSindacatiDtM);
  Application.Run;
end.
