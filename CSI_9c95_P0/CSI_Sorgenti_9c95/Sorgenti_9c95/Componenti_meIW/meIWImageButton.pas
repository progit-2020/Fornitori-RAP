unit meIWImageButton;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompExtCtrls;

type
  TmeIWImageButton = class(TIWImageButton)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    constructor Create(AOwner:TComponent); override;
  published
    { Published declarations }
  end;

implementation

{ TmeIWImageButton }

constructor TmeIWImageButton.Create(AOwner: TComponent);
begin
  inherited;
  NonEditableAsLabel:=False;
  RenderSize:=False;
  StyleRenderOptions.RenderAbsolute:=False;
  StyleRenderOptions.RenderFont:=False;
  StyleRenderOptions.RenderPadding:=False;
  StyleRenderOptions.RenderPosition:=False;
  StyleRenderOptions.RenderSize:=False;
  StyleRenderOptions.RenderStatus:=False;
  StyleRenderOptions.RenderZIndex:=False;
  { DONE : TEST IW 14 OK }
  StyleRenderOptions.RenderBorder:=False;
end;

end.
