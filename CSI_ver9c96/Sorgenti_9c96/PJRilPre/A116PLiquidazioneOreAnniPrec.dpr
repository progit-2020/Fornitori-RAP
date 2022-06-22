program A116PLiquidazioneOreAnniPrec;

uses
  Forms,
  MidasLib,
  A116ULiquidazioneOreAnniPrec in 'A116ULiquidazioneOreAnniPrec.pas' {A116FLiquidazioneOreAnniPrec},
  A116UStampa in 'A116UStampa.pas' {A116FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A116ULiquidazioneOreAnniPrecMW in '..\MWRilPre\A116ULiquidazioneOreAnniPrecMW.pas' {A116FLiquidazioneOreAnniPrecMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA116FLiquidazioneOreAnniPrec, A116FLiquidazioneOreAnniPrec);
  Application.Run;
end.
