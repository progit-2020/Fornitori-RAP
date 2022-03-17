unit meIWComboBox;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompListbox,
  IWDsnPaint, IWDsnPaintHandlers,Menus;

type
  TmeIWComboBox = class(TIWComboBox)
  private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    // v. forums.embarcadero.com (intervento di Pedro Lopes del 08.02.2012 sul topic "Speed Problem")
	{ DONE : TEST IW 14 OK }
    //IW_XIV//function RenderOnChangeIntoTag(AUserAgent: string): Boolean; override;
  public
    medpTag: TObject;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;

implementation

constructor TmeIWComboBox.Create(AOwner: TComponent);
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
  UseSize:=False;
  FContextMenu:=nil;
end;

function TmeIWComboBox.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeIWComboBox.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

{ DONE : TEST IW 14 OK }
// Su IW12 consentiva di evitare di legare sull'elemento HTML l'handler per l'evento OnChange come
// <select id="..." onchange="[handler]">. Su IW14 viene fatto comunque, ma non ha controindicazioni.
{
function TmeIWComboBox.RenderOnChangeIntoTag(AUserAgent: string): Boolean;
// v. forums.embarcadero.com (intervento di Pedro Lopes del 08.02.2012 sul topic "Speed Problem")
begin
  Result:=False;
end;
}

destructor TmeIWComboBox.Destroy;
begin
  if Assigned(medpTag) then
    try FreeAndNil(medpTag); except end;
  inherited;
end;

initialization

end.
