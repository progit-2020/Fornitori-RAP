program B006PScaricoAuto;

uses
  Forms,
  HtmlHelpViewer,
  MidasLib,
  B006UScaricoAuto in 'B006UScaricoAuto.pas' {B006FScaricoAuto},
  A023UAllTimbMW in '..\MWRilPre\A023UAllTimbMW.pas' {A023FAllTimb: TDataModule},
  B006UPianificazioneScarichi in 'B006UPianificazioneScarichi.pas' {B006FPianificazioneScarichi},
  R200UScaricoTimbratureDtM in '..\MWRilPre\R200UScaricoTimbratureDtM.pas' {R200FScaricoTimbratureDtM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'Help\IrisWIN_accessori.chm';
  Application.CreateForm(TB006FScaricoAuto, B006FScaricoAuto);
  Application.CreateForm(TB006FPianificazioneScarichi, B006FPianificazioneScarichi);
  // rimozione variabile globale R200FScaricoTimbratureDtM.ini
  // datamodule creato nell'evento oncreate della form
  //Application.CreateForm(TR200FScaricoTimbratureDtM, R200FScaricoTimbratureDtM);
  // rimozione variabile globale R200FScaricoTimbratureDtM.fine
  Application.Run;
end.
