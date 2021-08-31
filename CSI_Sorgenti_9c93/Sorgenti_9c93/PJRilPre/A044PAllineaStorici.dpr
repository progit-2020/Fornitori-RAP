program A044PAllineaStorici;

uses
  Forms,
  A044UAllineaStoriciDtM1 in 'A044UAllineaStoriciDtM1.pas' {A044FAllineaStoriciDtM1: TDataModule},
  A044UAllineaStorici in 'A044UAllineaStorici.pas' {A044FAllineaStorici},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A044UAllineaStoriciMW in '..\MWRilPre\A044UAllineaStoriciMW.pas' {A044FAllineaStoriciMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA044FAllineaStorici, A044FAllineaStorici);
  Application.CreateForm(TA044FAllineaStoriciDtM1, A044FAllineaStoriciDtM1);
  Application.Run;
end.
