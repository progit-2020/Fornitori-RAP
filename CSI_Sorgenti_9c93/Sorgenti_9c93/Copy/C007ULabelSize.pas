unit C007ULabelSize;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons, Mask, Variants;

type
  TC007FLabelSize = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Label3: TLabel;
    MaskEdit3: TMaskEdit;
    Label4: TLabel;
    MaskEdit4: TMaskEdit;
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MaskEdit3Change(Sender: TObject);
    procedure MaskEdit4Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Altezza,Larghezza,Sinistra,Alto:Integer;
  end;

var
  C007FLabelSize: TC007FLabelSize;

implementation

{$R *.DFM}

procedure TC007FLabelSize.SpinEdit1Change(Sender: TObject);
begin
  if Trim(MaskEdit1.Text) <> '' then
    Larghezza:=StrToInt(Trim(MaskEdit1.Text));
end;

procedure TC007FLabelSize.SpinEdit2Change(Sender: TObject);
begin
  if Trim(MaskEdit2.Text) <> '' then
    Altezza:=StrToInt(Trim(MaskEdit2.Text));
end;

procedure TC007FLabelSize.FormShow(Sender: TObject);
begin
  Label1.Caption:=Format('Larghezza:(%d)',[Larghezza]);
  Label2.Caption:=Format('Altezza:(%d)',[Altezza]);
  Label3.Caption:=Format('Sinistra:(%d)',[Sinistra]);
  Label4.Caption:=Format('Alto:(%d)',[Alto]);
  MaskEdit1.Text:=IntToStr(Larghezza);
  MaskEdit2.Text:=IntToStr(Altezza);
  MaskEdit3.Text:=IntToStr(Sinistra);
  MaskEdit4.Text:=IntToStr(Alto);
end;

procedure TC007FLabelSize.MaskEdit3Change(Sender: TObject);
begin
  if Trim(MaskEdit3.Text) <> '' then
    Sinistra:=StrToInt(Trim(MaskEdit3.Text));
end;

procedure TC007FLabelSize.MaskEdit4Change(Sender: TObject);
begin
  if Trim(MaskEdit4.Text) <> '' then
    Alto:=StrToInt(Trim(MaskEdit4.Text));
end;

end.
