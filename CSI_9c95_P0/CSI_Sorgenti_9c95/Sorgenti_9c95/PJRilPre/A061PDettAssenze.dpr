program A061PDettAssenze;

uses
  Forms,
  MidasLib,
  A061UDettAssenze in 'A061UDettAssenze.pas' {A061FDettAssenze},
  A061UStampa in 'A061UStampa.pas' {A061FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A061UDettAssenzeMW in '..\MWRilPre\A061UDettAssenzeMW.pas' {A061FDettAssenzaMW: TDataModule},
  C020UVisualizzaDataSet in '..\Copy\C020UVisualizzaDataSet.pas' {C020FVisualizzaDataSet},
  R600 in '..\MWRilPre\R600.pas' {R600DtM1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA061FDettAssenze, A061FDettAssenze);
  Application.Run;
end.
