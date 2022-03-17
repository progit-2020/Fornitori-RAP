program A076PIndGruppo;

uses
  Forms,
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A076UIndGruppoDtM1 in 'A076UIndGruppoDtM1.pas' {A076FIndGruppoDtM1: TDataModule},
  A076UIndGruppo in 'A076UIndGruppo.pas' {A076FIndGruppo},
  A076UIndGruppoMW in '..\MWRilPre\A076UIndGruppoMW.pas' {A076FIndGRuppoMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA076FIndGruppo, A076FIndGruppo);
  Application.CreateForm(TA076FIndGruppoDtM1, A076FIndGruppoDtM1);
  Application.Run;
end.
