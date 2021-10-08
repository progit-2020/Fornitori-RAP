unit meIWEdit;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit,
  IWDsnPaint, IWDsnPaintHandlers, Menus;

type
  TmeIWEdit = class(TIWEdit)
  private
    FWatermark: String;
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  public
    medpTag: TObject;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property RenderSize default False;
    property medpWatermark: String read FWatermark write FWatermark;
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;

implementation

constructor TmeIWEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  RenderSize:=False;
  Font.Enabled:=False;
  NonEditableAsLabel:=False;
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

function TmeIWEdit.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeIWEdit.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

destructor TmeIWEdit.Destroy;
begin
  if Assigned(medpTag) then
    try FreeAndNil(medpTag); except end;
  inherited Destroy;
end;

initialization


end.
