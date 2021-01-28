unit A097UStampaLibProf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R002UQREP, Qrctrls, quickrpt, ExtCtrls, QRExport, C700USelezioneAnagrafe, Variants,
  QRPDFFilt, QRWebFilt;

type
  TA097FStampaLibProf = class(TR002FQRep)
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRMemo1: TQRMemo;
    QRDBText1: TQRDBText;
    QRExpr1: TQRExpr;
    QRLabel3: TQRLabel;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A097FStampaLibProf: TA097FStampaLibProf;

implementation

uses A097UPianifLibProfDtM1;

{$R *.DFM}

procedure TA097FStampaLibProf.DetailBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRMemo1.Lines.Clear;
  with A097FPianifLibProfDtM1 do
  begin
    Q320.Close;
    Q320.SetVariable('Progressivo',C700Progressivo);
    Q320.Open;
    PrintBand:=Q320.RecordCount > 0;
    if PrintBand then
      while not Q320.Eof do
      begin
        QRMemo1.Lines.Add(Format('%s %s %s %s',[FormatDateTime('dd/mm/yyyy',Q320Data.AsDateTime),Q320Dalle.AsString,Q320Alle.AsString,Q320Causale.AsString]));
        Q320.Next;
      end;
  end;
end;

end.
