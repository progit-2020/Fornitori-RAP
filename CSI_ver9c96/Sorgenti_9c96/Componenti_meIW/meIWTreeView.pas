unit meIWTreeView;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompTreeview;

type
  TmeIWTreeView = class(TIWTreeView)
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

{ TmeIWTreeView }

constructor TmeIWTreeView.Create(AOwner: TComponent);
begin
  inherited;
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
