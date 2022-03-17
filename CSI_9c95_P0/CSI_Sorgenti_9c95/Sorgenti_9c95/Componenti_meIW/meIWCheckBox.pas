unit meIWCheckBox;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompCheckbox, IWDsnPaint,
  IWDsnPaintHandlers, IWTypes, IWRenderContext, IWXMLTag, Vcl.Menus;

type
  TmeIWCheckBox = class(TIWCheckBox)
  private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);

  public
    medpTag: TObject;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;

implementation

constructor TmeIWCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Css:='intestazione';
  Cursor:=crDefault;
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

function TmeIWCheckBox.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeIWCheckBox.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;


function TmeIWCheckBox.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
begin
  Result:=inherited;
  RenderAsyncPropertyAsString('css', Result, css, false);
end;

destructor TmeIWCheckBox.Destroy;
begin
  if Assigned(medpTag) then
    try FreeAndNil(medpTag); except end;
  inherited Destroy;
end;

end.
