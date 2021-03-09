unit P690UStampa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R002UQREP, QRPDFFilt, QRExport, QRWebFilt, QRCtrls, QuickRpt,
  ExtCtrls, DB;

type
  TP690FStampa = class(TR002FQRep)
    qrbFondo: TQRBand;
    qrdbTxtCodFondo: TQRDBText;
    qrbRisorseGen: TQRSubDetail;
    qrbRisorseGenInt: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel1: TQRLabel;
    qrdbTxtRisDesc: TQRDBText;
    qrdbtxtMacroCateg: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    qrdbtxtDescFondo: TQRDBText;
    qrdbTxtRisCodVoce: TQRDBText;
    QRLabel7: TQRLabel;
    qrbDestinGen: TQRSubDetail;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    qrbDestinGenInt: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    qrbRisorseDett: TQRChildBand;
    QRDBText5: TQRDBText;
    qrdbTxtRisTotImp: TQRDBText;
    qrdbTxtRisImp: TQRDBText;
    qrbDestinDett: TQRChildBand;
    QRDBText8: TQRDBText;
    qrdbTxtDestImp: TQRDBText;
    QRLabel8: TQRLabel;
    qrdbTxtDecorrenza: TQRDBText;
    qrdbTxtScadenza: TQRDBText;
    QRLabel9: TQRLabel;
    qrdbTxtDataCostituz: TQRDBText;
    qrlDataCostituz: TQRLabel;
    QRDBText6: TQRDBText;
    qrdbTxtRisTipo: TQRDBText;
    QRDBText1: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText7: TQRDBText;
    qrlblUltMonit: TQRLabel;
    QRDBText11: TQRDBText;
    qrbRisorseGenTot: TQRBand;
    QRLabel17: TQRLabel;
    qrbDestinGenTot: TQRBand;
    QRLabel18: TQRLabel;
    qrlTotRisorse: TQRLabel;
    qrlTotSpeso: TQRLabel;
    qrlRisDetImp: TQRLabel;
    qrlDestDetImp: TQRLabel;
    qrdbTxtMoltiplicatore: TQRDBText;
    qrdbtxtDatoBase: TQRDBText;
    qrdbtxtQuantita: TQRDBText;
    qrlRisDetMolt: TQRLabel;
    qrlRisDetDato: TQRLabel;
    qrlRisDetQuant: TQRLabel;
    qrlTotResiduo: TQRLabel;
    QRLabel19: TQRLabel;
    qrsRis1: TQRShape;
    qrsRis2: TQRShape;
    qrsDest2: TQRShape;
    qrsDest1: TQRShape;
    procedure qrbRisorseGenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbRisorseGenAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure qrbDestinGenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbDestinGenAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure qrlTotRisorsePrint(sender: TObject; var Value: string);
    procedure qrlTotSpesoPrint(sender: TObject; var Value: string);
    procedure qrbRisorseDettBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbDestinDettBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbRisorseGenIntBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbDestinGenIntBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtQuantitaPrint(sender: TObject; var Value: string);
    procedure qrdbtxtDatoBasePrint(sender: TObject; var Value: string);
    procedure qrdbTxtMoltiplicatorePrint(sender: TObject; var Value: string);
    procedure qrdbTxtRisImpPrint(sender: TObject; var Value: string);
    procedure qrdbTxtDestImpPrint(sender: TObject; var Value: string);
    procedure qrlDataCostituzPrint(sender: TObject; var Value: string);
    procedure qrlTotResiduoPrint(sender: TObject; var Value: string);
    procedure qrbFondoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrlblUltMonitPrint(sender: TObject; var Value: string);
  private
    { Private declarations }
    SalvaRisGen,SalvaDestGen:String;
  public
    { Public declarations }
  end;

var
  P690FStampa: TP690FStampa;

implementation

uses P690UStampaFondiDtM, P690UStampaFondi;

{$R *.dfm}

procedure TP690FStampa.qrbDestinDettBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PrintBand:=P690FStampaFondiDtM.TabStampaDest.FieldByName('CODDET').AsString <> '';
end;

procedure TP690FStampa.qrbDestinGenAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  inherited;
  SalvaDestGen:=P690FStampaFondiDtM.TabStampaDest.FieldByName('CODGEN').AsString;
end;

procedure TP690FStampa.qrbDestinGenBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PrintBand:=SalvaDestGen <> P690FStampaFondiDtM.TabStampaDest.FieldByName('CODGEN').AsString;
  qrsDest1.Enabled:=(SalvaDestGen = '') or (P690FStampaFondi.chkDettDestinazioni.Checked);
end;

procedure TP690FStampa.qrbDestinGenIntBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  qrlDestDetImp.Enabled:=P690FStampaFondi.chkDettDestinazioni.Checked;
end;

procedure TP690FStampa.qrbFondoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  SalvaRisGen:='';
  SalvaDestGen:='';
end;

procedure TP690FStampa.qrbRisorseDettBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PrintBand:=P690FStampaFondiDtM.TabStampaRis.FieldByName('CODDET').AsString <> '';
end;

procedure TP690FStampa.qrbRisorseGenAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  inherited;
  SalvaRisGen:=P690FStampaFondiDtM.TabStampaRis.FieldByName('CODGEN').AsString;
end;

procedure TP690FStampa.qrbRisorseGenBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PrintBand:=SalvaRisGen <> P690FStampaFondiDtM.TabStampaRis.FieldByName('CODGEN').AsString;
  qrsRis1.Enabled:=(SalvaRisGen = '') or (P690FStampaFondi.chkDettRisorse.Checked);
end;

procedure TP690FStampa.qrbRisorseGenIntBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  qrlRisDetImp.Enabled:=P690FStampaFondi.chkDettRisorse.Checked;
  qrlRisDetMolt.Enabled:=P690FStampaFondi.chkDettRisorse.Checked;
  qrlRisDetDato.Enabled:=P690FStampaFondi.chkDettRisorse.Checked;
  qrlRisDetQuant.Enabled:=P690FStampaFondi.chkDettRisorse.Checked;
end;

procedure TP690FStampa.qrdbtxtDatoBasePrint(sender: TObject; var Value: string);
begin
  inherited;
  if StrToFloatDef(Value,0) = 0 then
    Value:='';
end;

procedure TP690FStampa.qrdbtxtQuantitaPrint(sender: TObject; var Value: string);
begin
  inherited;
  if StrToFloatDef(Value,0) = 0 then
    Value:='';
end;

procedure TP690FStampa.qrdbTxtRisImpPrint(sender: TObject; var Value: string);
begin
  inherited;
  if StrToFloatDef(StringReplace(Value,'.','',[rfReplaceAll]),0) = 0 then
    Value:='';
end;

procedure TP690FStampa.qrdbTxtDestImpPrint(sender: TObject; var Value: string);
begin
  inherited;
  if StrToFloatDef(StringReplace(Value,'.','',[rfReplaceAll]),0) = 0 then
    Value:='';
end;

procedure TP690FStampa.qrdbTxtMoltiplicatorePrint(sender: TObject; var Value: string);
begin
  inherited;
  if StrToFloatDef(Value,0) = 0 then
    Value:='';
end;

procedure TP690FStampa.qrlblUltMonitPrint(sender: TObject; var Value: string);
begin
  inherited;
  if P690FStampaFondiDtM.selP688.FieldByName('DATA_ULTIMO_MONIT').AsString = '01/01/1900' then
    Value:='';
end;

procedure TP690FStampa.qrlDataCostituzPrint(sender: TObject; var Value: string);
begin
  inherited;
  if P690FStampaFondiDtM.selP688.FieldByName('DATA_COSTITUZ').AsString = '01/01/1900' then
    Value:='';
end;

procedure TP690FStampa.qrlTotResiduoPrint(sender: TObject; var Value: string);
begin
  inherited;
  Value:=Format('%15.0n',[P690FStampaFondiDtM.selP688.FieldByName('TOT_RESIDUO').AsFloat]);
end;

procedure TP690FStampa.qrlTotRisorsePrint(sender: TObject; var Value: string);
begin
  inherited;
  Value:=Format('%15.0n',[P690FStampaFondiDtM.selP688.FieldByName('TOT_RISORSE').AsFloat]);
end;

procedure TP690FStampa.qrlTotSpesoPrint(sender: TObject; var Value: string);
begin
  inherited;
  Value:=Format('%15.0n',[P690FStampaFondiDtM.selP688.FieldByName('TOT_SPESO').AsFloat]);
end;

end.
