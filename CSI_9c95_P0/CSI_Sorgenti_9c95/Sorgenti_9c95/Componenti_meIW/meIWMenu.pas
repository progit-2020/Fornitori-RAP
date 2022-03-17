unit meIWMenu;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompMenu;

type
  TmeIWMenu = class(TIWMenu)
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


{ TmeIWMenu }

constructor TmeIWMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  with StyleRenderOptions do
  begin
    RenderPadding:=False;
  end;
end;

end.
