
program A137PCalcoloSpeseAccesso;

uses
  Forms,
  MidasLib,
  A137UCalcoloSpeseAccesso in 'A137UCalcoloSpeseAccesso.pas' {A137FCalcoloSpeseAccesso},
  A137UStampaSpeseAccesso in 'A137UStampaSpeseAccesso.pas' {A137FStampaSpeseAccesso},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A137UCalcoloSpeseAccessoMW in '..\MWRilPre\A137UCalcoloSpeseAccessoMW.pas' {A137FCalcoloSpeseAccessoMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA137FCalcoloSpeseAccesso, A137FCalcoloSpeseAccesso);
  Application.Run;
end.
