program A013PCalendIndiv;

uses
  Forms,
  A013UCalendIndiv in 'A013UCalendIndiv.pas' {A013FCalendIndiv},
  A013USviluppoIndiv in 'A013USviluppoIndiv.pas' {A013FSviluppoIndiv},
  TABELLE99 in '..\Repositary\TABELLE99.pas' {FrmTabelle99},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A013UCalendIndivMW in '..\MWRilPre\A013UCalendIndivMW.pas' {A013FCalendIndivMW: TDataModule},
  A013UCalendIndivDtM1 in 'A013UCalendIndivDtM1.pas' {A013FCalendIndivDtM1: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA013FCalendIndiv, A013FCalendIndiv);
  Application.CreateForm(TA013FCalendIndivDtM1, A013FCalendIndivDtM1);
  Application.Run;
end.
