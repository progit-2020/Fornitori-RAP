unit A033UStampaAnomalieQR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Qrctrls, C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia,
  QRExport, Variants, QrWebFilt, QRPDFFilt;

type
  TA033FStampaAnomalieQR = class(TForm)
    QRep: TQuickRep;
    qrbDettaglio: TQRBand;
    QRDBText3: TQRDBText;
    qrbIntestazione: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    LRagg: TQRLabel;
    ERagg: TQRDBText;
    QRShape3: TQRShape;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    cdbIntestazioneRagg: TQRChildBand;
    LRaggInt: TQRLabel;
    QRDBText4: TQRDBText;
    cdbIntestazioneDipendente: TQRChildBand;
    QRShape2: TQRShape;
    QRLabel5: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    qrgRaggruppamento: TQRGroup;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure qrgRaggruppamentoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgDipendenteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cdbIntestazioneRaggBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cdbIntestazioneDipendenteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbDettaglioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgRaggruppamentoAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    iAltBandRagg: Integer;
  public
    { Public declarations }
    sIntRagg :String;
    iIntDip: Integer;
    bIntRagg, bIntDip: Boolean;
  end;

var
  A033FStampaAnomalieQR: TA033FStampaAnomalieQR;

implementation

uses A033UStampaAnomalieDtM1, A033UStampaAnomalie, A033UElenco;

{$R *.DFM}

procedure TA033FStampaAnomalieQR.cdbIntestazioneRaggBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if A033FStampaAnomalie.DBLookupCampo.Text = '' then
  begin
    PrintBand:=False;
    exit;
  end;
  if A033FStampaAnomalie.CheckBox4.Checked then
    PrintBand:=True
  else
  begin
    with A033FStampaAnomalieDtM1.A033FStampaAnomalieMW do
    begin
      sIntRagg:=TStampa.FieldByName('Raggruppamento').AsString;
    end;
    PrintBand:=bIntRagg;
  end;
end;

procedure TA033FStampaAnomalieQR.FormCreate(Sender: TObject);
begin
  QRep.useQR5Justification:=True;
end;

procedure TA033FStampaAnomalieQR.cdbIntestazioneDipendenteBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  with A033FStampaAnomalieDtM1.A033FStampaAnomalieMW do
  begin
    iIntDip:=TStampa.FieldByName('Progressivo').AsInteger;
  end;
  if A033FStampaAnomalie.CheckBox4.Checked then
    PrintBand:=True
  else
    PrintBand:=bIntDip;
end;

procedure TA033FStampaAnomalieQR.qrgRaggruppamentoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if A033FStampaAnomalie.CheckBox4.Checked then
  begin
    iAltBandRagg:=Sender.Height;
    Sender.Height:=0;
    exit;
  end;
  with A033FStampaAnomalieDtM1.A033FStampaAnomalieMW do
  begin
    if sIntRagg = TStampa.FieldByName('Raggruppamento').AsString then
      PrintBand:=False
    else
      PrintBand:=True;
  end;
  bIntRagg:=not(PrintBand);
end;

procedure TA033FStampaAnomalieQR.qrgDipendenteBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with A033FStampaAnomalieDtM1.A033FStampaAnomalieMW do
  begin
    if iIntDip = TStampa.FieldByName('Progressivo').AsInteger then
      PrintBand:=False
    else
      PrintBand:=True;
  end;
  bIntDip:=not(PrintBand);
end;

procedure TA033FStampaAnomalieQR.qrbDettaglioBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if A033FStampaAnomalie.CheckBox4.Checked then
    exit;
  bIntRagg:=True;
  bIntDip:=True;
end;

procedure TA033FStampaAnomalieQR.qrgRaggruppamentoAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if A033FStampaAnomalie.CheckBox4.Checked then
    sender.Height:=iAltBandRagg;
end;

end.

