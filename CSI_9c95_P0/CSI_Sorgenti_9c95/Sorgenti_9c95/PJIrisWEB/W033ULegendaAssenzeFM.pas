unit W033ULegendaAssenzeFM;

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
  TW033FLegendaAssenzeFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQLegendaAssenze: TIWJQueryWidget;
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

procedure TW033FLegendaAssenzeFM.IWFrameRegionCreate(Sender: TObject);
var StrCausale:String;
begin
  Self.Parent:=TIWAppForm(Self.Owner);

  StrCausale:=A000TraduzioneStringhe('CAUSALE');

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
  grdLegenda.RowCount:=9;

  grdLegenda.Cell[0,0].Css:='bg_nonlavorativo';
  grdLegenda.Cell[0,1].Text:='Giorno non lavorativo';

  grdLegenda.Cell[1,0].RawText:=True;
  grdLegenda.Cell[1,0].Text:='<div style="position:relative; height:100%; width:100%; min-width:6em;">&nbsp;<span style="position:absolute; left:0px; top:0px; width:100%; height:100%; background-color:#B1B1B1;">&nbsp;</span></div>';
  grdLegenda.Cell[1,1].Text:='Assenza generica a giornata';

  grdLegenda.Cell[2,0].RawText:=True;
  grdLegenda.Cell[2,0].Text:='<div style="position:relative; height:100%; width:100%; min-width:6em;">&nbsp;<span style="position:absolute; left:0px; top:0px; width:100%; height:100%; background-color:#FF0000;">' + StrCausale + '</span></div>';
  grdLegenda.Cell[2,1].Text:='Assenza a giornata intera sul cartellino';

  grdLegenda.Cell[3,0].RawText:=True;
  grdLegenda.Cell[3,0].Text:='<div style="position:relative; height:100%; width:100%; min-width:6em;">&nbsp;<span style="position:absolute; left:0px; top:0px; width:100%; height:100%; background-color:#FFAAAA;">' + StrCausale + '</span></div>';
  grdLegenda.Cell[3,1].Text:='Assenza richiesta a giornata intera';

  grdLegenda.Cell[4,0].RawText:=True;
  grdLegenda.Cell[4,0].Text:='<div style="position:relative; height:100%; width:100%; min-width:6em;">&nbsp;<span style="position:absolute; left:0px; top:0px; width:50%; height:100%; background-color:#FF0000;">' + StrCausale + '</span></div>';
  grdLegenda.Cell[4,1].Text:='Assenza a mezza giornata sul cartellino';

  grdLegenda.Cell[5,0].RawText:=True;
  grdLegenda.Cell[5,0].Text:='<div style="position:relative; height:100%; width:100%; min-width:6em;">&nbsp;<span style="position:absolute; left:0px; top:0px; width:50%; height:100%; background-color:#FFAAAA;">' + StrCausale + '</span></div>';
  grdLegenda.Cell[5,1].Text:='Assenza richiesta a mezza giornata';

  grdLegenda.Cell[6,0].RawText:=True;
  grdLegenda.Cell[6,0].Text:='<div style="position:relative; height:100%; width:100%; min-width:6em;">&nbsp;<span style="position:absolute; left:0px; top:0px; width:25%; height:100%; background-color:#FF0000;">' + StrCausale + '</span></div>';
  grdLegenda.Cell[6,1].Text:='Assenza ad ore sul cartellino';

  grdLegenda.Cell[7,0].RawText:=True;
  grdLegenda.Cell[7,0].Text:='<div style="position:relative; height:100%; width:100%; min-width:6em;">&nbsp;<span style="position:absolute; left:0px; top:0px; width:25%; height:100%; background-color:#FFAAAA;">' + StrCausale + '</span></div>';
  grdLegenda.Cell[7,1].Text:='Assenza richiesta ad ore';

  grdLegenda.Cell[8,0].RawText:=True;
  grdLegenda.Cell[8,0].Text:='<div style="position:relative; height:100%; width:100%; min-width:6em;">&nbsp;<span style="position:absolute; left:95%; top:0px; width:5%; height:100%; background-color:#00FF00;">&nbsp;</span></div>';
  grdLegenda.Cell[8,1].Text:='Presenza timbrature';

  TR010FPaginaWeb(Self.Parent).VisualizzajQMessaggio(jQLegendaAssenze,Self.Width + 5,Self.Height + 30,EM2PIXEL*30,
                                                     A000TraduzioneStringhe(A000MSG_W033_MSG_LEGENDA_ASS),'#' + Name,
                                                     False,False);
end;

procedure TW033FLegendaAssenzeFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

end.
