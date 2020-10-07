unit UInputTime;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Spin, Variants;

type
  TFInputTime = class(TForm)
    SpOre: TSpinEdit;
    LblOre: TLabel;
    LblMin: TLabel;
    LblSec: TLabel;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    SpMin: TSpinEdit;
    SpSec: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    ShowSeconds : Boolean;
    TimeIn,TimeOut : TDateTime;
    { Public declarations }
  end;

var
  FInputTime: TFInputTime;

implementation

{$R *.DFM}

//------------------------------------------------------------------------------
procedure TFInputTime.FormShow(Sender: TObject);
var HH,MM,SS,MS : Word;
begin
  timeOut := TimeIn;
  DecodeTime(TimeIn,HH,MM,SS,MS);
  SpOre.Value := HH;
  SpMin.Value := MM;
  if not(ShowSeconds) then
    begin
      SpSec.Visible := False;
      LblSec.Visible := False;
      FInputTime.Width := 194;
      BtnOk.Left := 13;
      BtnCancel.Left := 98;
    end
  else
  SpSec.Value := SS;
end;

//------------------------------------------------------------------------------
procedure TFInputTime.BtnOkClick(Sender: TObject);
begin
  if ShowSeconds then
    TimeOut := EncodeTime(SpOre.Value,SpMin.Value,SpSec.Value,00)
  else
    TimeOut := EncodeTime(SpOre.Value,SpMin.Value,00,00);
end;

end.
