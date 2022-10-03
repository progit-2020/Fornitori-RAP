unit meIWDBLookupComboBox;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompListbox, IWDBStdCtrls,
  IWDsnPaint, IWDsnPaintHandlers, IWRenderContext, IWXMLTag, IWHTMLTag, Menus;

type
  TmeIWDBLookupComboBox = class(TIWDBLookupComboBox)
  private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  public
    constructor Create(AOwner: TComponent); override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;

implementation

constructor TmeIWDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //Caratto 24/04/2014 bugfix render size (prima a true e poi false se no non recepisce)
  RenderSize:=True;
  RenderSize:=False;
  UseSize:=False;
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
  NoSelectionText:=' ';
  AutoEditable:=True;
  NonEditableAsLabel:=False;
end;

(*06/07/2012 Caratto - BugFix - il componente parte editabile anche se il dataset è in browse*)
function TmeIWDBLookupComboBox.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
begin
  EditingChanged;
  result:=inherited RenderAsync(AContext);
end;

function TmeIWDBLookupComboBox.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  EditingChanged;
  result:=inherited RenderHTML(AContext);
end;
(* bugfix.end *)

function TmeIWDBLookupComboBox.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeIWDBLookupComboBox.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

initialization


end.
