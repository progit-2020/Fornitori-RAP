unit W010UCalcoloCompetenzeFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, A000UInterfaccia, C190FunzioniGeneraliWeb,
  R010UPaginaWeb, IWCompMemo, IWCompJQueryWidget,
  meIWLabel, meIWButton, meIWMemo;

type
  TW010FCalcoloCompetenzeFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQCalcoloCompetenze: TIWJQueryWidget;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    btnChiudi: TmeIWButton;
    lblCompLordeAC: TmeIWLabel;
    lblAbbattiAssCess: TmeIWLabel;
    lblDecurtazNonMatura: TmeIWLabel;
    lblVarCompManuale: TmeIWLabel;
    lblVarPartTime: TmeIWLabel;
    lblCompNetteAC: TmeIWLabel;
    lblCompLordeACVal: TmeIWLabel;
    lblAbbattiAssCessVal: TmeIWLabel;
    lblDecurtazNonMaturaVal: TmeIWLabel;
    lblVarCompManualeVal: TmeIWLabel;
    lblVarPartTimeVal: TmeIWLabel;
    lblCompNetteACVal: TmeIWLabel;
    lblPartTime: TmeIWLabel;
    memPartTimeVal: TmeIWMemo;
    lblFruizMinimaAC: TmeIWLabel;
    lblFruizMinimaACVal: TmeIWLabel;
    lblProfiloAssenze: TmeIWLabel;
    lblProfiloAssenzeVal: TmeIWLabel;
    lblPeriodoCumulo: TmeIWLabel;
    lblPeriodoCumuloVal: TmeIWLabel;
    lblVarPeriodiRapporto: TmeIWLabel;
    lblVarPeriodiRapportoVal: TmeIWLabel;
    lblVarAbilitazioneAnagrafica: TmeIWLabel;
    lblVarAbilitazioneAnagraficaVal: TmeIWLabel;
    lblVarFruizMMInteri: TmeIWLabel;
    lblVarMaxIndividuale: TmeIWLabel;
    lblVarFruizMMContinuativi: TmeIWLabel;
    lblVarFruizMMContinuativiVal: TmeIWLabel;
    lblVarMaxIndividualeVal: TmeIWLabel;
    lblVarFruizMMInteriVal: TmeIWLabel;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  public
    TipoCumulo: Char;
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

procedure TW010FCalcoloCompetenzeFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

procedure TW010FCalcoloCompetenzeFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
end;

procedure TW010FCalcoloCompetenzeFM.Visualizza;
begin
  // visibilità variazioni alle competenze per tipo cumulo 'F'
  if TipoCumulo = 'F' then
    (Self.Parent as TR010FPaginaWeb).AddToInitProc('$(".cumuloF").show();');
  (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(jQCalcoloCompetenze,Self.Width + 50,-1,EM2PIXEL * 22,A000TraduzioneStringhe('Dettaglio del calcolo competenze'),'#' + Name,True,True,-1,'','',btnChiudi.HTMLName);
end;

end.