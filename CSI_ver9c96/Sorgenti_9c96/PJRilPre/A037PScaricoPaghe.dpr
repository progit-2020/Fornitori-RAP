program A037PScaricoPaghe;

uses
  Forms,
  A037UScaricoPaghe in 'A037UScaricoPaghe.pas' {A037FScaricoPaghe},
  A037UScaricoPagheDtM1 in 'A037UScaricoPagheDtM1.pas' {A037FScaricoPagheDtM1: TDataModule},
  A037UFiltroCodInterni in 'A037UFiltroCodInterni.pas' {A037FFiltroCodInterni},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A037UFiltroVoci in 'A037UFiltroVoci.pas' {A037FFiltroVoci},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A037UScaricoPagheMW in '..\MWRilPre\A037UScaricoPagheMW.pas' {A037FScaricoPagheMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA037FScaricoPaghe, A037FScaricoPaghe);
  Application.CreateForm(TA037FScaricoPagheDtM1, A037FScaricoPagheDtM1);
  Application.Run;
end.
