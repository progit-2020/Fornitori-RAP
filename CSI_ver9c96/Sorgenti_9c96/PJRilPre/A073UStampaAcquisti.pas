unit A073UStampaAcquisti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R002UQREP, QRPDFFilt, QRExport, QRWebFilt, QRCtrls, QuickRpt,
  ExtCtrls;

type
  TA073FStampaAcquisti = class(TR002FQRep)
    DetailBand1: TQRBand;
    qlblMatricola: TQRDBText;
    qlblCognome: TQRDBText;
    qlblNome: TQRDBText;
    qlblBuoniResidui: TQRDBText;
    qlblBuoniScaduti: TQRDBText;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
  private
    { Private declarations }
  public
    procedure SettaDataset;
  end;

var
  A073FStampaAcquisti: TA073FStampaAcquisti;

implementation

uses A073UAcquistoBuoniDtM1;

{$R *.dfm}

procedure TA073FStampaAcquisti.SettaDataset;
begin
  with A073FAcquistoBuoniDtM1.A073MW do
  begin
    QRep.DataSet:=BuoniPasto;
    QRep.DataSet.First;
    qlblMatricola.DataSet:=BuoniPasto;
    qlblCognome.DataSet:=BuoniPasto;
    qlblNome.DataSet:=BuoniPasto;
    qlblBuoniResidui.DataSet:=BuoniPasto;
    qlblBuoniScaduti.DataSet:=BuoniPasto;
    QRDBText1.DataSet:=BuoniPasto;
    QRDBText2.DataSet:=BuoniPasto;
  end;
end;

end.
