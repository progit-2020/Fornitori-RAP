unit meIWDBMemo;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompMemo, IWDBStdCtrls,
  IWDsnPaint, IWDsnPaintHandlers;

type
  TmeIWDBMemo = class(TIWDBMemo)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
  end;


implementation


{ TmeIWDBMemo }

constructor TmeIWDBMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoEditable:=True;
  Editable:=False;
  RenderSize:=False;
  with StyleRenderOptions do
  begin
    RenderPadding:=False;
    RenderSize:=False;
    { DONE : TEST IW 14 OK }
    RenderBorder:=False;
  end;
end;

initialization


end.
