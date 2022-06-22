unit A049UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, Variants, QRExport,
  QRWebFilt, QRPDFFilt;

type
  TA049FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRBDettaglio: TQRBand;
    QRBIntestazione: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText5: TQRDBText;
    QRLOrologi: TQRLabel;
    QRLAzienda: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRDBText6: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRGroup: TQRGroup;
    QRFoot: TQRBand;
    lblRaggruppamento: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    lblRaggruppamento2: TQRLabel;
    qlblPastiTot: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRBDettaglioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroupBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRFootBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    TotPasti,TotPastiCon,TotPastiInt,
    GrpPasti,GrpPastiCon,GrpPastiInt:LongInt;
  public
    { Public declarations }
    DataI,DataF : TDateTime;
    SalvaDatiPasti : Boolean;
    procedure CreaReport;
    procedure SettaDataset;
  end;

var
  A049FStampa: TA049FStampa;

implementation

uses A049UDialogStampa, A049UStampaPastiDtM1;

{$R *.DFM}

procedure TA049FStampa.CreaReport;
begin
  RepR.Preview;
end;

procedure TA049FStampa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRLTitolo.Caption := 'Riepilogo pasti dal ' + FormatDateTime('dd mmmm yyyy',DataI)+
                       ' al ' + FormatDateTime('dd mmmm yyyy',DataF);
  TotPasti:=0;
  TotPastiCon:=0;
  TotPastiInt:=0;
end;

procedure TA049FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA049FStampa.QRBDettaglioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var PastiCon,PastiInt:LongInt;
begin
  with A049FStampaPastiDtM1.A049FStampaPastiMW do
    begin
    PastiCon:=TabellaStampa.FieldByName('PastiCon').AsInteger;
    PastiInt:=TabellaStampa.FieldByName('PastiInt').AsInteger;
    PrintBand:=(PastiCon > 0) or (PastiInt > 0);
    qlblPastiTot.Caption:=IntToStr(PastiCon + PastiInt);
    if TabellaStampa.FieldByName('Causale').AsString <> '*' then
      qlblPastiTot.Caption:=Format('(%s)%s',[TabellaStampa.FieldByName('Causale').AsString,qlblPastiTot.Caption]);
    inc(TotPasti,PastiCon + PastiInt);
    inc(TotPastiCon,PastiCon);
    inc(TotPastiInt,PastiInt);
    inc(GrpPasti,PastiCon + PastiInt);
    inc(GrpPastiCon,PastiCon);
    inc(GrpPastiInt,PastiInt);
    end;
  PrintBand:=(not QRGroup.Enabled) or (A049FDialogStampa.chkDettaglio.Checked);
end;

procedure TA049FStampa.SettaDataset;
begin
  with A049FStampaPastiDtM1.A049FStampaPastiMW do
  begin
    RepR.DataSet:=TabellaStampa;
    QRDBText1.DataSet:=TabellaStampa;
    QRDBText2.DataSet:=TabellaStampa;
    QRDBText3.DataSet:=TabellaStampa;
    QRDBText4.DataSet:=TabellaStampa;
    QRDBText5.DataSet:=TabellaStampa;
    QRDBText6.DataSet:=TabellaStampa;
  end;
end;

procedure TA049FStampa.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLabel7.Caption:=IntToStr(TotPastiCon);
  QRLabel9.Caption:=IntToStr(TotPastiInt);
  QRLabel10.Caption:=IntToStr(TotPasti);
end;

procedure TA049FStampa.QRGroupBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblRaggruppamento.Caption:=Format('%s: %s',[A049FDialogStampa.dcmbRaggruppamento.Text,RepR.DataSet.FieldByName('Raggruppamento').AsString]);
  lblRaggruppamento2.Caption:=lblRaggruppamento.Caption;
  GrpPasti:=0;
  GrpPastiCon:=0;
  GrpPastiInt:=0;
end;

procedure TA049FStampa.QRFootBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLabel12.Caption:=IntToStr(GrpPastiCon);
  QRLabel13.Caption:=IntToStr(GrpPastiInt);
  QRLabel14.Caption:=IntToStr(GrpPasti);
end;

end.
