unit meIWRadioButton;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompRadioButton,
  IWDsnPaint, IWDsnPaintHandlers;

type
  TmeIWRadioButton = class(TIWRadioButton)
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

{ TmeIWRadioButton }

constructor TmeIWRadioButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  with StyleRenderOptions do
  begin
    RenderPadding:=False;
  end;
end;

initialization

end.
