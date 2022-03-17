unit A074UStampaAcquisti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R002UQREP, QRExport, QRCtrls, QuickRpt, ExtCtrls, Variants, QRWebFilt,
  QRPDFFilt;

type
  TTotali = record
    B,T,
    ResB,ResT,RecB,RecT,
    ResB_Prec,ResT_Prec,RecB_Prec,RecT_Prec:Integer;
  end;

  TA074FStampaAcquisti = class(TR002FQRep)
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    lblMese: TQRLabel;
    QRGroup1: TQRGroup;
    QRBand1: TQRBand;
    LRagg: TQRLabel;
    QRDBText7: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel16: TQRLabel;
    qlblBuoniGrp: TQRLabel;
    qlblTicketGrp: TQRLabel;
    qlblBuoniSum: TQRLabel;
    qlblTicketSum: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    qlblBuoniResGrp: TQRLabel;
    qlblTicketResGrp: TQRLabel;
    qlblBuoniResSum: TQRLabel;
    qlblTicketResSum: TQRLabel;
    qlblBuoniResDet: TQRLabel;
    qlblBuoniDet: TQRLabel;
    qlblTicketResDet: TQRLabel;
    qlblTicketDet: TQRLabel;
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRDBText4Print(sender: TObject; var Value: String);
    procedure QRDBText8Print(sender: TObject; var Value: String);
  private
    { Private declarations }
    Totali:array[1..2] of TTotali;
  public
    { Public declarations }
  end;

var
  A074FStampaAcquisti: TA074FStampaAcquisti;

implementation

uses A074URiepilogoBuoni;

{$R *.DFM}

procedure TA074FStampaAcquisti.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Totali[1].B:=0;
  Totali[1].T:=0;
  Totali[1].ResB:=0;
  Totali[1].ResT:=0;
  Totali[1].RecB:=0;
  Totali[1].RecT:=0;
  Totali[1].ResB_Prec:=0;
  Totali[1].ResT_Prec:=0;
  Totali[1].RecB_Prec:=0;
  Totali[1].RecT_Prec:=0;
end;

procedure TA074FStampaAcquisti.QRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Totali[2].B:=0;
  Totali[2].T:=0;
  Totali[2].ResB:=0;
  Totali[2].ResT:=0;
  Totali[2].RecB:=0;
  Totali[2].RecT:=0;
  Totali[2].ResB_Prec:=0;
  Totali[2].ResT_Prec:=0;
  Totali[2].RecB_Prec:=0;
  Totali[2].RecT_Prec:=0;
end;

procedure TA074FStampaAcquisti.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var S:String;
begin
  qlblTicketDet.Caption:='';
  qlblBuoniDet.Caption:='';
  qlblTicketResDet.Caption:='';
  qlblBuoniResDet.Caption:='';
  with QRep.DataSet do
  begin
    inc(Totali[1].B,FieldByName('BUONI').AsInteger);
    inc(Totali[2].B,FieldByName('BUONI').AsInteger);
    inc(Totali[1].T,FieldByName('TICKET').AsInteger);
    inc(Totali[2].T,FieldByName('TICKET').AsInteger);
    if FieldByName('TIPO').AsString = 'B' then
    begin
      inc(Totali[1].ResB,FieldByName('ResiduoAtt').AsInteger);
      inc(Totali[2].ResB,FieldByName('ResiduoAtt').AsInteger);
      inc(Totali[1].ResB_Prec,FieldByName('ResiduoPrec').AsInteger);
      inc(Totali[2].ResB_Prec,FieldByName('ResiduoPrec').AsInteger);
      inc(Totali[1].RecB,FieldByName('RecuperoAtt').AsInteger);
      inc(Totali[2].RecB,FieldByName('RecuperoAtt').AsInteger);
      inc(Totali[1].RecB_Prec,FieldByName('RecuperoPrec').AsInteger);
      inc(Totali[2].RecB_Prec,FieldByName('RecuperoPrec').AsInteger);
      qlblBuoniDet.Caption:=FieldByName('BUONI').AsString;
      if FieldByName('RecuperoAtt').AsInteger <> 0 then
      begin
        S:=FieldByName('RecuperoAtt').AsString;
        if FieldByName('RecuperoPrec').AsInteger > 0 then
          S:=S + '/' + FieldByName('RecuperoPrec').AsString;
        qlblBuoniDet.Caption:=Format('%s(%s)',[qlblBuoniDet.Caption,S]);
      end;
      qlblBuoniResDet.Caption:=FieldByName('ResiduoAtt').AsString;
      if FieldByName('ResiduoPrec').AsInteger > 0 then
        qlblBuoniResDet.Caption:=qlblBuoniResDet.Caption + '/' + FieldByName('ResiduoPrec').AsString;
    end
    else
    begin
      inc(Totali[1].ResT,FieldByName('ResiduoAtt').AsInteger);
      inc(Totali[2].ResT,FieldByName('ResiduoAtt').AsInteger);
      inc(Totali[1].ResT_Prec,FieldByName('ResiduoPrec').AsInteger);
      inc(Totali[2].ResT_Prec,FieldByName('ResiduoPrec').AsInteger);
      inc(Totali[1].RecT,FieldByName('RecuperoAtt').AsInteger);
      inc(Totali[2].RecT,FieldByName('RecuperoAtt').AsInteger);
      inc(Totali[1].RecT_Prec,FieldByName('RecuperoPrec').AsInteger);
      inc(Totali[2].RecT_Prec,FieldByName('RecuperoPrec').AsInteger);
      qlblTicketDet.Caption:=FieldByName('TICKET').AsString;
      if FieldByName('RecuperoAtt').AsInteger <> 0 then
      begin
        S:=FieldByName('RecuperoAtt').AsString;
        if FieldByName('RecuperoPrec').AsInteger > 0 then
          S:=S + '/' + FieldByName('RecuperoPrec').AsString;
        qlblTicketDet.Caption:=Format('%s(%s)',[qlblTicketDet.Caption,S]);
      end;
      qlblTicketResDet.Caption:=FieldByName('ResiduoAtt').AsString;
      if FieldByName('ResiduoPrec').AsInteger > 0 then
        qlblTicketResDet.Caption:=qlblBuoniResDet.Caption + '/' + FieldByName('ResiduoPrec').AsString;
    end;
  end;
  PrintBand:=A074FRiepilogoBuoni.chkAcqDatiIndividuali.Checked;
end;

procedure TA074FStampaAcquisti.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var S:String;
begin
  qlblBuoniGrp.Caption:=IntToStr(Totali[1].B);
  if Totali[1].RecB + Totali[1].RecB_Prec <> 0 then
  begin
    S:=IntToStr(Totali[1].RecB);
    if Totali[1].RecB_Prec > 0 then
      S:=S + '/' + IntToStr(Totali[1].RecB_Prec);
    qlblBuoniGrp.Caption:=Format('%s(%s)',[qlblBuoniGrp.Caption,S]);
  end;
  qlblTicketGrp.Caption:=IntToStr(Totali[1].T);
  if Totali[1].RecT + Totali[1].RecT_Prec <> 0 then
  begin
    S:=IntToStr(Totali[1].RecT);
    if Totali[1].RecT_Prec > 0 then
      S:=S + '/' + IntToStr(Totali[1].RecT_Prec);
    qlblTicketGrp.Caption:=Format('%s(%s)',[qlblTicketGrp.Caption,S]);
  end;
  qlblBuoniResGrp.Caption:=IntToStr(Totali[1].ResB);
  if Totali[1].ResB_Prec > 0 then
    qlblBuoniResGrp.Caption:=qlblBuoniResGrp.Caption + '/' + IntToStr(Totali[1].ResB_Prec);
  qlblTicketResGrp.Caption:=IntToStr(Totali[1].ResT);
  if Totali[1].ResT_Prec > 0 then
    qlblTicketResGrp.Caption:=qlblTicketResGrp.Caption + '/' + IntToStr(Totali[1].ResT_Prec);
end;

procedure TA074FStampaAcquisti.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var S:String;
begin
  qlblBuoniSum.Caption:=IntToStr(Totali[2].B);
  if Totali[2].RecB + Totali[2].RecB_Prec <> 0 then
  begin
    S:=IntToStr(Totali[2].RecB);
    if Totali[2].RecB_Prec > 0 then
      S:=S + '/' + IntToStr(Totali[2].RecB_Prec);
    qlblBuoniSum.Caption:=Format('%s(%s)',[qlblBuoniSum.Caption,S]);
  end;
  qlblTicketSum.Caption:=IntToStr(Totali[2].T);
  if Totali[2].RecT + Totali[2].RecT_Prec <> 0 then
  begin
    S:=IntToStr(Totali[2].RecT);
    if Totali[2].RecT_Prec > 0 then
      S:=S + '/' + IntToStr(Totali[2].RecT_Prec);
    qlblTicketSum.Caption:=Format('%s(%s)',[qlblTicketSum.Caption,S]);
  end;
  qlblBuoniResSum.Caption:=IntToStr(Totali[2].ResB);
  if Totali[2].ResB_Prec > 0 then
    qlblBuoniResSum.Caption:=qlblBuoniResSum.Caption + '/' + IntToStr(Totali[2].ResB_Prec);
  qlblTicketResSum.Caption:=IntToStr(Totali[2].ResT);
  if Totali[2].ResT_Prec > 0 then
    qlblTicketResSum.Caption:=qlblTicketResSum.Caption + '/' + IntToStr(Totali[2].ResT_Prec);
end;

procedure TA074FStampaAcquisti.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  if QRep.DataSet.FieldByName('BRECUPERO').AsInteger <> 0 then
    Value:=Value + '(' + QRep.DataSet.FieldByName('BRECUPERO').AsString + ')';
end;

procedure TA074FStampaAcquisti.QRDBText4Print(sender: TObject;
  var Value: String);
begin
  if QRep.DataSet.FieldByName('TRECUPERO').AsInteger <> 0 then
    Value:=Value + '(' + QRep.DataSet.FieldByName('TRECUPERO').AsString + ')';
end;

procedure TA074FStampaAcquisti.QRDBText8Print(sender: TObject;
  var Value: String);
begin
  if Value = '0' then
    Value:='';
end;

end.
