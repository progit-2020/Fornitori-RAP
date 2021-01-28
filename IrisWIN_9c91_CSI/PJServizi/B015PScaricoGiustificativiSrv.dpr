program B015PScaricoGiustificativiSrv;

uses
  SvcMgr,
  MidasLib,
  B015UScaricoGiustificativiSrv in 'B015UScaricoGiustificativiSrv.pas' {B015FScaricoGiustificativiSrv: TService},
  R250UScaricoGiustificativiDtM in '..\MWRilPre\R250UScaricoGiustificativiDtM.pas' {R250FScaricoGiustificativiDtM: TDataModule},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TB015FScaricoGiustificativiSrv, B015FScaricoGiustificativiSrv);
  Application.Run;
end.
