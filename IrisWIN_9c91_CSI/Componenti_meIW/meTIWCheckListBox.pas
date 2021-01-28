unit meTIWCheckListBox;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWHTMLTag, IWMarkupLanguageTag,
  IWTMSBase, IWTMSCheckList,Menus, Vcl.Graphics;

type
  TmeTIWCheckListBox = class(TTIWCheckListBox)
  private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    { Protected declarations }
  public
    function RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag; override;
    constructor Create(AOwner:TComponent); override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;

implementation

constructor TmeTIWCheckListBox.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FContextMenu:=nil;
  BGColor:=clNone;
  BGColorTo:=clNone;
  BorderColor:=clNone;
  BorderWidth:=0;
  Editable:=True;
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

function TmeTIWCheckListBox.RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag;
var
  HTMLText,Part1,Part2: String;
  Index1: Integer;
begin
  Result:=inherited;

  // rimuove il position:absolute del componente
  HTMLText:=Result.Contents[0].Render;
  Index1:=Pos(' style=" position:absolute; ',HTMLText);
  Delete(HTMLText,Index1 + 8,20);

  if (StyleRenderOptions.RenderSize = False) then
  begin
    //ATTENZIONE LASCIARE LO SPAZIO A CAUSA DI BORder-width
    Index1:=Pos(' width:',HTMLText);

    Part1:=Copy(HTMLText,0,Index1);
    Part2:=Copy(HTMLText,Index1+6, Length(HTMLText));
    Index1:=Pos(';',Part2);
    Part2:=Copy(Part2,Index1+1,Length(Part2));
    HTMLText:=Part1 +Part2;

    Index1:=Pos(' height:',HTMLText);

    Part1:=Copy(HTMLText,0,Index1);
    Part2:=Copy(HTMLText,Index1+7, Length(HTMLText));
    Index1:=Pos(';',Part2);
    Part2:=Copy(Part2,Index1+1,Length(Part2));
    HTMLText:=Part1 +Part2;

  //   width:244px; height:121px;

  end;

  TIWTextElement(Result.Contents[0]).Text:=HTMLText;
end;

function TmeTIWCheckListBox.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeTIWCheckListBox.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

end.
