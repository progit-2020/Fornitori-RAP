unit A068UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R002UQREP, Qrctrls, quickrpt, ExtCtrls, QRExport, C700USelezioneAnagrafe, Variants,
  QRPDFFilt, QRWebFilt;

type
  TA068FStampa = class(TR002FQRep)
    QRGroup1: TQRGroup;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    LTitolo1: TQRLabel;
    DetailBand1: TQRBand;
    QRBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    Mattino: TQRMemo;
    Pomeriggio: TQRMemo;
    Notte: TQRMemo;
    Smonto: TQRMemo;
    Riposo: TQRMemo;
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    H,HB:Integer;
  public
    { Public declarations }
  end;

var
  A068FStampa: TA068FStampa;

implementation

uses A068UTurniGiorDtM1, A068UTurniGior;

{$R *.DFM}

procedure TA068FStampa.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Mattino.Lines.Clear;
  Pomeriggio.Lines.Clear;
  Notte.Lines.Clear;
  Smonto.Lines.Clear;
  Riposo.Lines.Clear;
end;

procedure TA068FStampa.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var S:String;
begin
  with A068FTurniGiorDtM1 do
  begin
    Q040.Close;
    Q040.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    Q040.Open;
    if Q040.Fields[0].AsInteger > 0 then
      exit;
    if A068FTurniGior.rgpTPianif.ItemIndex = 1 then
    begin
      Q081.Close;
      Q081.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      Q081.Open;
      selTemp:=Q081;
    end
    else
    begin
      selT080.Close;
      selT080.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      selT080.Open;
      selTemp:=selT080;
    end;

    if selTemp.RecordCount > 0 then
    begin
      S:=C700SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + Copy(C700SelAnagrafe.FieldByName('NOME').AsString,1,1) + '.';
      if selTemp.FieldByName('TURNO1').AsString = '1' then
        Mattino.Lines.Add(S);
      if selTemp.FieldByName('TURNO1').AsString = '2' then
        Pomeriggio.Lines.Add(S);
      if selTemp.FieldByName('TURNO1').AsString = '3' then
        if selTemp.FieldByName('TURNO2').AsString = '0' then
          Smonto.Lines.Add(S)
        else
          Notte.Lines.Add(S);
      if selTemp.FieldByName('TURNO1').AsString = '0' then
        Riposo.Lines.Add(S);
    end;
  end;
end;

procedure TA068FStampa.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var NL:Integer;
begin
  NL:=Mattino.Lines.Count;
  if Pomeriggio.Lines.Count > NL then
    NL:=Pomeriggio.Lines.Count;
  if Notte.Lines.Count > NL then
    NL:=Notte.Lines.Count;
  if Smonto.Lines.Count > NL then
    NL:=Smonto.Lines.Count;
  if Riposo.Lines.Count > NL then
    NL:=Riposo.Lines.Count;
  Mattino.Height:=H * NL;
  Pomeriggio.Height:=H * NL;
  Notte.Height:=H * NL;
  Smonto.Height:=H * NL;
  Riposo.Height:=H * NL;
  if Mattino.Height < HB then
    QRBand1.Height:=HB
  else
    QRBand1.Height:=Mattino.Height + 5;
end;

procedure TA068FStampa.FormCreate(Sender: TObject);
begin
  H:=Mattino.Height;
  HB:=QRBand1.Height;
end;

end.
