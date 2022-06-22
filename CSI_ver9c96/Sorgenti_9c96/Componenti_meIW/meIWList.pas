unit meIWList;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls,
  IWDsnPaint, IWDsnPaintHandlers;

type
  TmeIWList = class(TIWList)
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

{ TmeIWList }

constructor TmeIWList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NonEditableAsLabel:=False;
  RenderSize:=False;
  Font.Enabled:=False;
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
