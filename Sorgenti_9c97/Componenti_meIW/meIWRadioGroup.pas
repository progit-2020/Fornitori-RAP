unit meIWRadioGroup;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompExtCtrls,
  IWDsnPaint, IWDsnPaintHandlers, IWTypes;

type
  TmeIWRadioGroup = class(TIWRadioGroup)
  private
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
  published
  end;

implementation

constructor TmeIWRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Css:='intestazione';
  Cursor:=crDefault;
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

end.
