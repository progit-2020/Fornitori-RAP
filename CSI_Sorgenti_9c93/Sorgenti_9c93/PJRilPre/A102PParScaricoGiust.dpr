program A102PParScaricoGiust;

uses
  Forms,
  A102UParScaricoGiust in 'A102UParScaricoGiust.pas' {A102FParScaricoGiust},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A102UParScaricoGiustDtM in 'A102UParScaricoGiustDtM.pas' {A102FParScaricoGiustDtM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA102FParScaricoGiust, A102FParScaricoGiust);
  Application.CreateForm(TA102FParScaricoGiustDtM, A102FParScaricoGiustDtM);
  Application.Run;
end.
