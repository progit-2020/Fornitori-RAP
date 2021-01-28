program A033PStampaAnomalie;

uses
  Forms,
  MidasLib,
  A033UStampaAnomalie in 'A033UStampaAnomalie.pas' {A033FStampaAnomalie},
  A033UStampaAnomalieDtM1 in 'A033UStampaAnomalieDtM1.pas' {A033FStampaAnomalieDtM1: TDataModule},
  A033UStampaAnomalieQR in 'A033UStampaAnomalieQR.pas' {A033FStampaAnomalieQR},
  A033UElenco in 'A033UElenco.pas' {A033FElenco},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A033UStampaAnomalieMW in '..\MWRilPre\A033UStampaAnomalieMW.pas' {A033FStampaAnomalieMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA033FStampaAnomalie, A033FStampaAnomalie);
  Application.CreateForm(TA033FStampaAnomalieDtM1, A033FStampaAnomalieDtM1);
  Application.Run;
end.
