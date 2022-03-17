unit meIWText;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompText,
  IWDsnPaint, IWDsnPaintHandlers;

type
  TmeIWText = class(TIWText)
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


{ TmeIWText }

constructor TmeIWText.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  with StyleRenderOptions do
  begin
    RenderPadding:=False;
  end;
end;

initialization


end.
