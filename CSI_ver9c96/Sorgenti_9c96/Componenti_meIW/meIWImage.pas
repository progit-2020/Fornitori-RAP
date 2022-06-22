unit meIWImage;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompExtCtrls,
  IWDsnPaint, IWDsnPaintHandlers;

type
  TmeIWImage = class(TIWImage)
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


{ TmeIWImage }

constructor TmeIWImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  with StyleRenderOptions do
  begin
    RenderPadding:=False;
  end;
end;

initialization


end.
