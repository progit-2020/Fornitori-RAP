unit meIWDBText;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompText, IWDBStdCtrls,
  IWDsnPaint, IWDsnPaintHandlers;

type
  TmeIWDBText = class(TIWDBText)
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


{ TmeIWDBText }

constructor TmeIWDBText.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  with StyleRenderOptions do
  begin
    RenderAbsolute:=False;
    RenderFont:=False;
    RenderPosition:=False;
    RenderSize:=False;
    RenderStatus:=True;
    RenderVisibility:=True;
    RenderZIndex:=False;
    RenderPadding:=False;
    { DONE : TEST IW 14 OK }
    RenderBorder:=False;
  end;
end;

initialization


end.
