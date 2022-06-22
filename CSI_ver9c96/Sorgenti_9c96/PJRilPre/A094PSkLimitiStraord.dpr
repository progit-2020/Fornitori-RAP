program A094PSkLimitiStraord;

uses
  Forms,
  A094USkLimitiStr in 'A094USkLimitiStr.pas' {A094FSkLimitiStr},
  A094USkLimitiStrDtM1 in 'A094USkLimitiStrDtM1.pas' {A094FSkLimitiStrDtM1: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A094USkLimitiStraordMW in '..\MWRilPre\A094USkLimitiStraordMW.pas' {A094FSkLimitiStraordMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA094FSkLimitiStr, A094FSkLimitiStr);
  Application.CreateForm(TA094FSkLimitiStrDtM1, A094FSkLimitiStrDtM1);
  Application.Run;
end.
