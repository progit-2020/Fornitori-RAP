unit W022ULegendaPunteggiFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm, OracleData,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, R010UPAGINAWEB, IWTypes,
  C190FunzioniGeneraliWeb, IWCompJQueryWidget, IWCompGrids,
  meIWGrid, meIWButton, meIWLabel;

type
  TW022FLegendaPunteggiFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQLegendaPunteggi: TIWJQueryWidget;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    lblElencoPunteggi: TmeIWLabel;
    btnChiudi: TmeIWButton;
    grdLegenda: TmeIWGrid;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdLegendaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    { Private declarations }
  public
    DataSetLegenda:TOracleDataset;
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

procedure TW022FLegendaPunteggiFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

procedure TW022FLegendaPunteggiFM.grdLegendaRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  C190RenderCell(ACell,ARow,AColumn,True,True,False);
end;

procedure TW022FLegendaPunteggiFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=TIWAppForm(Self.Owner);
end;

procedure TW022FLegendaPunteggiFM.Visualizza;
var
  i:Integer;
begin
  with DataSetLegenda do
  begin
    First;
    grdLegenda.ColumnCount:=3;
    grdLegenda.RowCount:=DataSetLegenda.RecordCount + 1;

    grdLegenda.Cell[0,0].Text:='Codice';
    grdLegenda.Cell[0,1].Text:='Valore';
    grdLegenda.Cell[0,2].Text:='Descrizione';

    i:=1;
    while not Eof do
    begin
      grdLegenda.Cell[i,0].Text:=FieldByName('CODICE').AsString;
      if FieldByName('CALCOLO_PFP').AsString = 'S' then
        grdLegenda.Cell[i,1].Text:=FormatFloat('##0.00',FieldByName('PUNTEGGIO').AsFloat);
      grdLegenda.Cell[i,2].Text:=FieldByName('DESCRIZIONE').AsString;
      Next;
      i:=i+1;
    end;
  end;

  TR010FPaginaWeb(Self.Parent).VisualizzajQMessaggio(jQLegendaPunteggi, Self.Width + 25, -1,EM2PIXEL * 50, 'Legenda Punteggi', '#' + Name, False, True);
end;

end.