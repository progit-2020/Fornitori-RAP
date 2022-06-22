program A036PTurniRep;

uses
  Forms,
  A036UTurniRepDTM1 in 'A036UTurniRepDTM1.pas' {A036FTurniRepDTM1: TDataModule},
  A036UTurniRep in 'A036UTurniRep.pas' {A036FTurniRep},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A036UTurniRepMW in '..\MWRilPre\A036UTurniRepMW.pas' {A036FTurniRepMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA036FTurniRep, A036FTurniRep);
  Application.CreateForm(TA036FTurniRepDTM1, A036FTurniRepDTM1);
  Application.Run;
end.
