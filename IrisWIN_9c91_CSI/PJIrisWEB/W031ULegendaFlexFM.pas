unit W031ULegendaFlexFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm, OracleData,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, R010UPAGINAWEB, IWTypes,
  C190FunzioniGeneraliWeb, meIWButton, meIWGrid, IWCompJQueryWidget,
  IWCompGrids;

type
  TW031FLegendaFlexFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQLegendaFlex: TIWJQueryWidget;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    btnChiudi: TmeIWButton;
    grdLegenda: TmeIWGrid;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure grdLegendaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    { Private declarations }
  public
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

procedure TW031FLegendaFlexFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

procedure TW031FLegendaFlexFM.grdLegendaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  C190RenderCell(ACell,ARow,AColumn,True,True,False);
end;

procedure TW031FLegendaFlexFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=TIWAppForm(Self.Owner);
end;

procedure TW031FLegendaFlexFM.Visualizza;
begin
  grdLegenda.ColumnCount:=2;
  grdLegenda.RowCount:=5;
  grdLegenda.Cell[0,0].Text:='Codice';
  grdLegenda.Cell[0,1].Text:='Descrizione';
  grdLegenda.Cell[1,0].Text:='1';
  grdLegenda.Cell[1,1].Text:='Turnazione';
  grdLegenda.Cell[2,0].Text:='2';
  grdLegenda.Cell[2,1].Text:='Progetti quantitativi';
  grdLegenda.Cell[3,0].Text:='3';
  grdLegenda.Cell[3,1].Text:='Straordinario fino a 110 ore compreso quantitativo';
  grdLegenda.Cell[4,0].Text:='4';
  grdLegenda.Cell[4,1].Text:='Altre condizioni (specificare)';

  TR010FPaginaWeb(Self.Parent).VisualizzajQMessaggio(jQLegendaFlex, Self.Width + 25, -1,EM2PIXEL * 50, 'Legenda Flessibilità', '#' + Name, False, True);
end;

end.