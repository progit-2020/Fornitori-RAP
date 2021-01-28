unit A021UAssestAnnuo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  t_lstSerbatoi = record
    Cod,Desc:String;
  end;

  TA021FAssestAnnuo = class(TForm)
    chkAssestAnnuo: TCheckBox;
    lstSerbatoi: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    procedure lstSerbatoiDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lstSerbatoiStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure lstSerbatoiDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lstSerbatoiDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure chkAssestAnnuoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ItemDrag:Integer;
  public
    { Public declarations }
  end;

const d_lstSerbatoi:array[0..3] of t_lstSerbatoi =
    ((Cod:'CP';Desc:'Compensabile anno prec.'),
     (Cod:'LP';Desc:'Liquidabile anno prec.'),
     (Cod:'CA';Desc:'Compensabile anno att.'),
     (Cod:'LA';Desc:'Liquidabile anno att.'));

var
  A021FAssestAnnuo: TA021FAssestAnnuo;

implementation

{$R *.dfm}

procedure TA021FAssestAnnuo.FormShow(Sender: TObject);
begin
 ItemDrag:=-1;
 lstSerbatoi.Enabled:=chkAssestAnnuo.Checked;
end;

procedure TA021FAssestAnnuo.lstSerbatoiDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var i:Integer;
    S:String;
begin
  S:='';
  for i:=0 to High(d_lstSerbatoi) do
    if lstSerbatoi.Items[Index] = d_lstSerbatoi[i].Cod then
      S:=d_lstSerbatoi[i].Desc;
  if S <> '' then
    lstSerbatoi.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,S);
end;

procedure TA021FAssestAnnuo.lstSerbatoiStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  if lstSerbatoi.ItemIndex >= 0 then
    ItemDrag:=lstSerbatoi.ItemIndex
  else
    ItemDrag:=-1;
end;

procedure TA021FAssestAnnuo.lstSerbatoiDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=ItemDrag >= 0;
end;

procedure TA021FAssestAnnuo.lstSerbatoiDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var S:String;
    ItemPos:Integer;
begin
  if ItemDrag < 0 then exit;
  if lstSerbatoi.ItemAtPos(Point(X,Y),True) < 0 then exit;
  ItemPos:=lstSerbatoi.ItemAtPos(Point(X,Y),True);
  if ItemPos <> ItemDrag then
  begin
    S:=lstSerbatoi.Items[ItemDrag];
    lstSerbatoi.Items[ItemDrag]:=lstSerbatoi.Items[ItemPos];
    lstSerbatoi.Items[ItemPos]:=S;
  end;
end;

procedure TA021FAssestAnnuo.chkAssestAnnuoClick(Sender: TObject);
begin
  lstSerbatoi.Enabled:=chkAssestAnnuo.Checked;
end;

end.
