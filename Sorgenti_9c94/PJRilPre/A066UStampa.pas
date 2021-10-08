unit A066UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R002UQREP, Qrctrls, quickrpt, ExtCtrls, QRExport, Variants, QRPDFFilt,
  QRWebFilt;

type
  TA066FStampa = class(TR002FQRep)
    LTitolo2: TQRLabel;
    QRGroup1: TQRGroup;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    LLivello: TQRLabel;
    DLivello: TQRLabel;
    QRGroup2: TQRGroup;
    ColumnHeaderBand1: TQRBand;
    LFasce: TQRLabel;
    QRLabel4: TQRLabel;
    QRBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    DFasce: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    Fasce:String;
  public
    { Public declarations }
  end;

var
  A066FStampa: TA066FStampa;

implementation

uses A066UValutaStrDtM1, A066UValutaStrMw;

{$R *.DFM}

procedure TA066FStampa.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Fasce:='';
end;

procedure TA066FStampa.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Fasce:=Fasce + Format('%-17m',[A066FValutaStrDtM1.QStampa.FieldByName('VALORE').AsFloat]);
end;

procedure TA066FStampa.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  DFasce.Caption:=Fasce;
end;

procedure TA066FStampa.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  DLivello.Caption:='';

  with A066FValutaStrDtM1.A066FValutaStrMW.QLookup do
    if Active then
      DLivello.Caption:=VarToStr(Lookup('CODICE',A066FValutaStrDtM1.QStampa.FieldByName('Livello').AsString,'DESCRIZIONE'));
end;

end.
