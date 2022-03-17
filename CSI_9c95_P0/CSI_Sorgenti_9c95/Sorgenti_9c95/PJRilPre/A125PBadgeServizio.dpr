program A125PBadgeServizio;

uses
  Forms,
  A125UBadgeServizio in 'A125UBadgeServizio.pas' {A125FBadgeServizio},
  A125UBadgeServizioDtM in 'A125UBadgeServizioDtM.pas' {A125FBadgeServizioDtM: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A125UBadgeServizioMW in '..\MWRilPre\A125UBadgeServizioMW.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA125FBadgeServizio, A125FBadgeServizio);
  Application.CreateForm(TA125FBadgeServizioDtM, A125FBadgeServizioDtM);
  Application.Run;
end.
