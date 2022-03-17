unit meIWDBLabel;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, IWDBStdCtrls,
  IWDsnPaint, IWDsnPaintHandlers,
  IWRenderContext, IWXMLTag, IWHTMLTag,IWApplication, Strutils;

type
  TmeIWDBLabel = class(TIWDBLabel)
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
  published
    { Published declarations }
  end;


implementation

constructor TmeIWDBLabel.Create(AOwner: TComponent);
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
end;

function TmeIWDBLabel.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  js: string;
begin
  Result:=inherited;
  js:=Format('$("#%s").toggleClass("lblDisabled",%s); ',[HTMLName,IfThen(Enabled,'false','true')]);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(js);
end;

end.
