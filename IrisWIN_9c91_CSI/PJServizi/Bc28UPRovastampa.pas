unit Bc28UPRovastampa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls;

type
  TBc28FProvaStampa = class(TForm)
    QuickRep1: TQuickRep;
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Bc28FProvaStampa: TBc28FProvaStampa;

implementation

{$R *.dfm}

procedure TBc28FProvaStampa.FormCreate(Sender: TObject);
begin
  QuickRep1.useQR5Justification:=True;
end;

end.
