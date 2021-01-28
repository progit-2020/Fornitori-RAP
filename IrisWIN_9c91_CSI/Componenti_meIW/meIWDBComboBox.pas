unit meIWDBComboBox;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompListbox, IWDBStdCtrls,
  IWDsnPaint, IWDsnPaintHandlers, Vcl.Menus;

type
  TmeIWDBComboBox = class(TIWDBComboBox)
   private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    { Protected declarations }
    procedure CheckData; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
 end;


implementation

constructor TmeIWDBComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
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
  UseSize:=False;
  AutoEditable:=True;
  NonEditableAsLabel:=False;
  FContextMenu:=nil;
end;

function TmeIWDBComboBox.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeIWDBComboBox.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

(*06/07/2012 Caratto - BugFix - il componente parte editabile anche se il dataset è in browse*)
procedure TmeIWDBComboBox.CheckData;
begin
  EditingChanged;
  inherited;
end;
(* bugfix.end *)
initialization


end.
