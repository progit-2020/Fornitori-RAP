unit W004ULegendaColoriFM;

interface

uses
  R010UPaginaWeb,
  SysUtils, Classes, Controls, Forms, IWAppForm,
  IWVCLBaseContainer, IWContainer, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  IWHTMLContainer, IWHTML40Container,
  meIWButton, meIWGrid, IWCompJQueryWidget, IWCompGrids,
  C190FunzioniGeneraliWeb, A000UInterfaccia, W000UMessaggi;

type
  TW004FLegendaColoriFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQLegendaColori: TIWJQueryWidget;
    grdLegenda: TmeIWGrid;
    btnChiudi: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

implementation

{$R *.dfm}

procedure TW004FLegendaColoriFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=TIWAppForm(Self.Owner);

  grdLegenda.StyleRenderOptions.RenderSize:=True;
  grdLegenda.StyleRenderOptions.RenderPosition:=True;
  grdLegenda.StyleRenderOptions.RenderFont:=True;
  grdLegenda.StyleRenderOptions.RenderZIndex:=True;
  grdLegenda.StyleRenderOptions.RenderVisibility:=True;
  grdLegenda.StyleRenderOptions.RenderStatus:=True;
  grdLegenda.StyleRenderOptions.RenderAbsolute:=True;

  btnChiudi.StyleRenderOptions.RenderSize:=True;
  btnChiudi.StyleRenderOptions.RenderPosition:=True;
  btnChiudi.StyleRenderOptions.RenderFont:=True;
  btnChiudi.StyleRenderOptions.RenderZIndex:=True;
  btnChiudi.StyleRenderOptions.RenderVisibility:=True;
  btnChiudi.StyleRenderOptions.RenderStatus:=True;
  btnChiudi.StyleRenderOptions.RenderAbsolute:=True;

  grdLegenda.ColumnCount:=2;
  grdLegenda.RowCount:=4;

  grdLegenda.Cell[0,0].Css:='bg_nonlavorativo';
  grdLegenda.Cell[0,1].Text:='Giorno non lavorativo';

  grdLegenda.Cell[1,0].Text:='<div style="position:relative; height:100%; width:100%; min-width:6em;">&nbsp;<span style="position:absolute; left:90%; top:0px; width:5%; height:100%; background-color:#FF0000;">&nbsp;</span></div>';
  grdLegenda.Cell[1,1].Text:='Presenza assenza a giornata intera';

  grdLegenda.Cell[2,0].Text:='<div style="position:relative; height:100%; width:100%; min-width:6em;">&nbsp;<span style="position:absolute; left:95%; top:0px; width:5%; height:100%; background-color:#0000FF;">&nbsp;</span></div>';
  grdLegenda.Cell[2,1].Text:='Presenza timbrature di reperibilità';

  grdLegenda.Cell[3,0].Text:='<div style="position:relative; height:100%; width:100%; min-width:6em;">&nbsp;<span style="position:absolute; left:95%; top:0px; width:5%; height:100%; background-color:#00FF00;">&nbsp;</span></div>';
  grdLegenda.Cell[3,1].Text:='Presenza timbrature non di reperibilità';

  TR010FPaginaWeb(Self.Parent).VisualizzajQMessaggio(jQLegendaColori,Self.Width + 5,Self.Height + 30,EM2PIXEL*30,
                                                     A000TraduzioneStringhe(A000MSG_W004_MSG_LEGENDA_COLORI),'#' + Name,
                                                     False,False);
end;

procedure TW004FLegendaColoriFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

end.
