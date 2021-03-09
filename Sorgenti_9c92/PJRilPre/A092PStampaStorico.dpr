program A092PStampaStorico;

uses
  Forms,
  MidasLib,
  A092UStampaStorico in 'A092UStampaStorico.pas' {A092FStampaStorico},
  A092UStampaStoricoDtM1 in 'A092UStampaStoricoDtM1.pas' {A092FStampaStoricoDtM1: TDataModule},
  A092UStampa in 'A092UStampa.pas' {A092FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A092UStampaStoricoMW in '..\MWRilPre\A092UStampaStoricoMW.pas' {A092FStampaStoricoMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA092FStampaStorico, A092FStampaStorico);
  Application.CreateForm(TA092FStampaStoricoDtM1, A092FStampaStoricoDtM1);
  Application.Run;
end.
