unit meTIWCheckList;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWTMSCheckList,Menus;

type
  TmeTIWCheckList = class(TTIWCheckList)
  private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    { Protected declarations }
  public
    constructor Create(AOwner:TComponent); override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;

implementation

constructor TmeTIWCheckList.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FContextMenu:=nil;
end;

function TmeTIWCheckList.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeTIWCheckList.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

end.
