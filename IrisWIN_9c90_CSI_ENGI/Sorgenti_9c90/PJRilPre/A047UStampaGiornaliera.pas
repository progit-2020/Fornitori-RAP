unit A047UStampaGiornaliera;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R002UQREP, QRExport, Qrctrls, QuickRpt, ExtCtrls, Variants, QRPDFFilt,
  QRWebFilt;

type
  TA047FStampaGiornaliera = class(TR002FQRep)
    QRGroup1: TQRGroup;
    QRBand1: TQRBand;
    qlblData: TQRLabel;
    ChildBand1: TQRChildBand;
    QRMemo1: TQRMemo;
    qlblNumPasti: TQRLabel;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    qlblTotalePasti: TQRLabel;
    ChildBand2: TQRChildBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRMemo2: TQRMemo;
    qbndCenaGG: TQRChildBand;
    qbndCenaTot: TQRChildBand;
    QRMemo3: TQRMemo;
    QRMemo4: TQRMemo;
    qlblPranzoGG: TQRLabel;
    qlblCenaGG: TQRLabel;
    qlblPranzoTot: TQRLabel;
    qlblCenaTot: TQRLabel;
    qlblTotPranziGG: TQRLabel;
    qlblTotCeneGG: TQRLabel;
    qlblTotCene: TQRLabel;
    qlblTotPranzi: TQRLabel;
    qlblIntPranzo: TQRLabel;
    qlblIntCena: TQRLabel;
    procedure QRGroup1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    NumPastiTot,SommarioPasti,
    NumPranzi,NumCene,
    SommarioPranzi,SommarioCene:Integer;
    LCausali,LCausaliCena:TStringList;
    Col,ColCena:Byte;
  public
    { Public declarations }
  end;

var
  A047FStampaGiornaliera: TA047FStampaGiornaliera;

implementation

uses A047UTimbMensaDtM1, A047UDialogStampa;

{$R *.DFM}

procedure TA047FStampaGiornaliera.FormCreate(Sender: TObject);
begin
  inherited;
  LCausali:=TStringList.Create;
  LCausaliCena:=TStringList.Create;
end;

procedure TA047FStampaGiornaliera.QRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  SommarioPasti:=0;
  SommarioPranzi:=0;
  SommarioCene:=0;
  LCausali.Clear;
  LCausaliCena.Clear;
end;

procedure TA047FStampaGiornaliera.QRGroup1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  qlblData.Caption:=FormatDateTime('dd/mm/yyyy',QRep.DataSet.FieldByName('Data').AsDateTime);
  NumPastiTot:=0;
  NumPranzi:=0;
  NumCene:=0;
  QRMemo1.Lines.Clear;
  QRMemo3.Lines.Clear;
  Col:=1;
  ColCena:=1;
end;

procedure TA047FStampaGiornaliera.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var Causale:String;
    Pasti,PastiCena:Integer;
    S:String;
begin
  Causale:=QRep.DataSet.FieldByName('Causale').AsString;
  Pasti:=QRep.DataSet.FieldByName('Pasti').AsInteger;
  PastiCena:=QRep.DataSet.FieldByName('PastiCena').AsInteger;
  inc(NumPastiTot,Pasti);
  inc(SommarioPasti,Pasti);
  if A047FDialogStampa.chkPranzoCena.Checked then
    Pasti:=Pasti - PastiCena;
  inc(NumPranzi,Pasti);
  inc(NumCene,PastiCena);
  inc(SommarioPranzi,Pasti);
  inc(SommarioCene,PastiCena);
  if Pasti > 0 then
  begin
    if Col = 1 then
      QRMemo1.Lines.Add(Format('(%-5s:%6d)',[Causale,Pasti]))
    else
    begin
      S:=QRMemo1.Lines[QRMemo1.Lines.Count - 1] + ' ' + Format('(%-5s:%6d)',[Causale,Pasti]);
      QRMemo1.Lines[QRMemo1.Lines.Count - 1]:=S;
    end;
    inc(Col);
    if Col > 5 then
      Col:=1;
    if LCausali.Values[Causale] = '' then
      LCausali.Add(Format('%s=%d',[Causale,Pasti]))
    else
      LCausali.Values[Causale]:=IntToStr(StrToInt(LCausali.Values[Causale]) + Pasti);
  end;
  if (A047FDialogStampa.chkPranzoCena.Checked) and (PastiCena > 0) then
  begin
    if ColCena = 1 then
      QRMemo3.Lines.Add(Format('(%-5s:%6d)',[Causale,PastiCena]))
    else
    begin
      S:=QRMemo3.Lines[QRMemo3.Lines.Count - 1] + ' ' + Format('(%-5s:%6d)',[Causale,PastiCena]);
      QRMemo3.Lines[QRMemo1.Lines.Count - 1]:=S;
    end;
    inc(ColCena);
    if Colcena > 5 then
      ColCena:=1;
    if LCausaliCena.Values[Causale] = '' then
      LCausaliCena.Add(Format('%s=%d',[Causale,PastiCena]))
    else
      LCausaliCena.Values[Causale]:=IntToStr(StrToInt(LCausaliCena.Values[Causale]) + PastiCena);
  end;
  PrintBand:=False;
end;

procedure TA047FStampaGiornaliera.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qlblNumPasti.Caption:=IntToStr(NumPastiTot);
  qlblTotPranziGG.Caption:=IntToStr(NumPranzi);
  qlblTotCeneGG.Caption:=IntToStr(NumCene);
end;

procedure TA047FStampaGiornaliera.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var i:Integer;
    S,S1:String;
begin
  qlblTotalePasti.Caption:='Totale accessi:' + IntToStr(SommarioPasti);
  qlblTotPranzi.Caption:=IntToStr(SommarioPranzi);
  qlblTotCene.Caption:=IntToStr(SommarioCene);
  QRMemo2.Lines.Clear;
  QRMemo4.Lines.Clear;
  Col:=1;
  ColCena:=1;
  LCausali.Sort;
  LCausaliCena.Sort;
  for i:=0 to LCausali.Count - 1 do
  begin
    S1:=Format('(%-5s:%6s)',[LCausali.Names[i],LCausali.Values[LCausali.Names[i]]]);
    if Col = 1 then
      QRMemo2.Lines.Add(S1)
    else
    begin
      S:=QRMemo2.Lines[QRMemo2.Lines.Count - 1] + ' ' + S1;
      QRMemo2.Lines[QRMemo2.Lines.Count - 1]:=S;
    end;
    inc(Col);
    if Col > 5 then
      Col:=1;
  end;
  for i:=0 to LCausaliCena.Count - 1 do
  begin
    S1:=Format('(%-5s:%6s)',[LCausaliCena.Names[i],LCausaliCena.Values[LCausaliCena.Names[i]]]);
    if ColCena = 1 then
      QRMemo4.Lines.Add(S1)
    else
    begin
      S:=QRMemo4.Lines[QRMemo4.Lines.Count - 1] + ' ' + S1;
      QRMemo4.Lines[QRMemo4.Lines.Count - 1]:=S;
    end;
    inc(ColCena);
    if ColCena > 5 then
      ColCena:=1;
  end;
end;

procedure TA047FStampaGiornaliera.FormDestroy(Sender: TObject);
begin
  LCausali.Free;
  LCausaliCena.Free;
  inherited;
end;

end.
