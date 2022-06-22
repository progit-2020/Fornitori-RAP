unit meIWDBCheckBox;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompCheckbox, IWDBStdCtrls,
  IWDsnPaint, IWDsnPaintHandlers, IWRenderContext, IWXMLTag, Vcl.Menus;

type
  TmeIWDBCheckBox = class(TIWDBCheckBox)
  private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    procedure CheckData; override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;


implementation

constructor TmeIWDBCheckBox.Create(AOwner: TComponent);
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
  AutoEditable:=True;
end;

function TmeIWDBCheckBox.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeIWDBCheckBox.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

function TmeIWDBCheckBox.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
begin
  Result:=inherited;
  RenderAsyncPropertyAsString('css', Result, css, false);
end;

(*06/07/2012 Caratto - BugFix - il componente parte editabile anche se il dataset è in browse*)
procedure TmeIWDBCheckBox.CheckData;
begin
  EditingChanged;
  inherited;
end;
(* bugfix.end *)

initialization


end.
