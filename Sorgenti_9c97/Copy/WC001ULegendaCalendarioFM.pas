unit WC001ULegendaCalendarioFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm,
  IWVCLBaseContainer, IWContainer, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  IWHTMLContainer, IWHTML40Container,
  R010UPaginaWeb, meIWGrid, meIWButton, IWCompJQueryWidget,
  IWCompGrids, C190FunzioniGeneraliWeb, A000UInterfaccia, W000UMessaggi;

type
  TWC001FLegendaCalendarioFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQLegendaCalendario: TIWJQueryWidget;
    grdLegenda: TmeIWGrid;
    btnChiudi: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWC001FLegendaCalendarioFM.IWFrameRegionCreate(Sender: TObject);
begin
  Parent:=(Self.Owner as TIWAppForm);

  grdLegenda.ColumnCount:=2;
  grdLegenda.RowCount:=5;

  grdLegenda.Cell[0,0].Css:='bg_white';
  grdLegenda.Cell[0,1].Text:='Giorno Lavorativo';

  grdLegenda.Cell[1,0].Css:='bg_lime';
  grdLegenda.Cell[1,1].Text:='Giorno Non Lavorativo';

  grdLegenda.Cell[2,0].Css:='bg_giallo';
  grdLegenda.Cell[2,1].Text:='Giorno Festivo';

  grdLegenda.Cell[3,0].Css:='bg_aqua';
  grdLegenda.Cell[3,1].Text:='Giorno Festivo Non Lavorativo';

  grdLegenda.Cell[4,0].Css:='bg_white' + ' ' + 'font_rosso';
  grdLegenda.Cell[4,0].Text:='Giorno';
  grdLegenda.Cell[4,1].Text:='Domenica';

  (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(jQLegendaCalendario,Self.Width + 5,Self.Height + 25,EM2PIXEL*30,
                                                         A000TraduzioneStringhe(A000MSG_C001_MSG_LEGENDA_GG),
                                                         '#' + Name,True,False,-1,'','',btnChiudi.HTMLName);
end;

procedure TWC001FLegendaCalendarioFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

end.
