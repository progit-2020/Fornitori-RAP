unit A137UStampaSpeseAccesso;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, Variants, Math, QRExport,
  QRWebFilt, QRPDFFilt;

type
  TA137FStampaSpeseAccesso = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRBDettaglio: TQRBand;
    QRBIntestazione: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLAzienda: TQRLabel;
    LPeriodo: TQRLabel;
    QRLabel4: TQRLabel;
    QRBndTotGen: TQRBand;
    QRLabel16: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRExpr1: TQRExpr;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SettaDataset;
  end;

var
  A137FStampaSpeseAccesso: TA137FStampaSpeseAccesso;

implementation

uses A137UCalcoloSpeseAccesso;

{$R *.DFM}

{ TA137FStampaSpeseAccesso }

procedure TA137FStampaSpeseAccesso.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA137FStampaSpeseAccesso.SettaDataset;
begin
  with A137FCalcoloSpeseAccesso.A137FCalcoloSpeseAccessoMW do
  begin
    RepR.DataSet:=TabellaStampa;
    QRDBText3.DataSet:=TabellaStampa;
    QRDBText4.DataSet:=TabellaStampa;
    QRDBText2.DataSet:=TabellaStampa;
    QRDBText6.DataSet:=TabellaStampa;
    QRDBText1.DataSet:=TabellaStampa;
  end;
end;

end.
