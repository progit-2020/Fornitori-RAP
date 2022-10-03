program A073PAcquistoBuoni;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A073UAcquistoBuoni in 'A073UAcquistoBuoni.pas' {A073FAcquistoBuoni},
  A073UAcquistoBuoniDtM1 in 'A073UAcquistoBuoniDtM1.pas' {A073FAcquistoBuoniDtM1: TDataModule},
  A073UControllo in 'A073UControllo.pas' {A073FControllo},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  A073UStampaAcquisti in 'A073UStampaAcquisti.pas' {A073FStampaAcquisti},
  A073UAcquistoBuoniMW in '..\MWRilPre\A073UAcquistoBuoniMW.pas' {A073FAcquistoBuoniMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA073FAcquistoBuoni, A073FAcquistoBuoni);
  Application.CreateForm(TA073FAcquistoBuoniDtM1, A073FAcquistoBuoniDtM1);
  Application.CreateForm(TA073FStampaAcquisti, A073FStampaAcquisti);
  Application.Run;
end.
