unit meIWProgressBar;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompProgressBar,
  IWDsnPaint, IWDsnPaintHandlers;

type
  TmeIWProgressBar = class(TIWProgressBar)
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


{ TmeIWProgressBar }

constructor TmeIWProgressBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  with StyleRenderOptions do
  begin
    RenderPadding:=False;
  end;
end;

initialization


end.
