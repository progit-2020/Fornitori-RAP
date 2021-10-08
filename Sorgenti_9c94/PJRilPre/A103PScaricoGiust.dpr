program A103PScaricoGiust;

uses
  Forms,
  A103UScaricoGiust in 'A103UScaricoGiust.pas' {A103FScaricoGiust},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  R250UScaricoGiustificativiDtM in '..\MWRilPre\R250UScaricoGiustificativiDtM.pas' {R250FScaricoGiustificativiDtM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA103FScaricoGiust, A103FScaricoGiust);
  Application.Run;
end.
