unit A042UStampaGrafico;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Series, A000UCostanti, A000USessione,A000UInterfaccia,
  DBChart, GanttCh, QrTee, Chart, TeEngine, TeeProcs, Variants;

type
  TA042FStampaGrafico = class(TQuickRep)
    QRDettaglio: TQRBand;
    QRChart1: TQRChart;
    QRDBChart1: TQRDBChart;
    Series1: TGanttSeries;
    Series2: TGanttSeries;
    Series3: TGanttSeries;
    QRDBChart2: TQRDBChart;
    QRLegenda: TQRChart;
    Series4: TGanttSeries;
    QRLabel1: TQRLabel;
    QRBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRLblAzienda: TQRLabel;
    QRLblTitolo: TQRLabel;
    QRImage1: TQRImage;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRImage2: TQRImage;
    QRLabel4: TQRLabel;
    QRImage3: TQRImage;
    QRLabel5: TQRLabel;
    QRLblIntestazione: TQRLabel;
    QRLblPagina: TQRLabel;
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  A042FStampaGrafico: TA042FStampaGrafico;

implementation

uses A042UGrafico;

{$R *.DFM}

constructor TA042FStampaGrafico.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.useQR5Justification:=True;
end;

procedure TA042FStampaGrafico.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLblAzienda.Caption:=Parametri.RagioneSociale;
end;

end.
