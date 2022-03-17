program B014PIntegrazioneAnagrafica;

uses
  Forms,
  HtmlHelpViewer,
  MidasLib,
  B014UIntegrazioneAnagraficaDtM in 'B014UIntegrazioneAnagraficaDtM.pas' {B014FIntegrazioneAnagraficaDtM: TDataModule},
  B014UIntegrazioneAnagrafica in 'B014UIntegrazioneAnagrafica.pas' {B014FIntegrazioneAnagrafica},
  B014UMonitorIntegrazioneDtM in 'B014UMonitorIntegrazioneDtM.pas' {B014FMonitorIntegrazioneDtM: TDataModule},
  B014UViewMemo in 'B014UViewMemo.pas' {B014FViewMemo},
  B014UCopiaSchedulazione in 'B014UCopiaSchedulazione.pas' {B014FCopiaSchedulazione},
  B014UBrowseStruttura in 'B014UBrowseStruttura.pas' {B014FBrowseStruttura},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'Help\IrisWIN_Accessori.chm';
  Application.CreateForm(TB014FIntegrazioneAnagrafica, B014FIntegrazioneAnagrafica);
  Application.CreateForm(TB014FIntegrazioneAnagraficaDtM, B014FIntegrazioneAnagraficaDtM);
  Application.CreateForm(TB014FMonitorIntegrazioneDtM, B014FMonitorIntegrazioneDtM);
  Application.Run;
end.
