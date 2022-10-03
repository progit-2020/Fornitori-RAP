unit meIWDBRadioGroup;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompExtCtrls, IWDBExtCtrls,
  IWDsnPaint, IWDsnPaintHandlers,Menus;

type
  TmeIWDBRadioGroup = class(TIWDBRadioGroup)
  private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;

implementation

constructor TmeIWDBRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Css:='intestazione';
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
  AutoEditable:=True;
end;

function TmeIWDBRadioGroup.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeIWDBRadioGroup.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

initialization

end.
