unit meIWListbox;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompListbox,
  IWDsnPaint, IWDsnPaintHandlers, Menus;

type
  TmeIWListbox = class(TIWListbox)
  private
    FContextMenu: TPopupMenu;
    function GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;

implementation

constructor TmeIWListbox.Create(AOwner: TComponent);
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

function TmeIWListbox.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeIWListbox.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;


initialization


end.
