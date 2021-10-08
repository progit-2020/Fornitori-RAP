unit meIWLabel;

interface

uses
  SysUtils, StrUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel,IWRenderContext, IWXMLTag, IWHTMLTag,
  IWDsnPaint, IWDsnPaintHandlers, IWColor, Graphics, IWApplication, Menus;

type
  TmeIWLabel = class(TIWLabel)
  private
    FEnabled: boolean;
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
    function get_Css: string;
    procedure setCss(const Value: string);
  protected
    procedure SetEnabled(Value: Boolean); override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property Enabled: boolean read FEnabled write SetEnabled;
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
    property Css: string read get_Css write setCss;
  end;

implementation

constructor TmeIWLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Css:='intestazione';
  Enabled:=True;
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

function TmeIWLabel.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var js: String;
begin
  Result:=inherited;
  js:=Format('$("#%s").toggleClass("lblDisabled",%s); ',[HTMLName,IfThen(Enabled,'false','true')]);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(js);
end;

function TmeIWLabel.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result:=inherited;
  Css:=Css.Replace('lblDisabled','',[rfReplaceAll]).Trim + IfThen(not Enabled,' lblDisabled');
end;

procedure TmeIWLabel.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
    invalidate;
  FEnabled:=Value;
end;

function TmeIWLabel.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

function TmeIWLabel.get_Css: string;
begin
  Result:=inherited get_Css;
end;

procedure TmeIWLabel.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

procedure TmeIWLabel.setCss(const Value: string);
begin
  inherited set_Css(Value);
  invalidate;
end;

end.
