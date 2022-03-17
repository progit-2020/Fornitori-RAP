unit meTIWFilePicker;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWTMSCtrls, IWHTMLTag, IWTMSBase,
  IWMarkupLanguageTag;

type
  TmeTIWFilePicker = class(TTIWFilePicker)
  private
    FSizeInput:Integer;
  public
    medpTag: TObject;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag; override;
  published
    property SizeInput: Integer read FSizeInput write FSizeInput;
  end;

implementation

constructor TmeTIWFilePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SizeInput:=0;
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
  end;
end;

destructor TmeTIWFilePicker.Destroy;
begin
  FreeAndNil(medpTag);
  inherited Destroy;
end;

function TmeTIWFilePicker.RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag;
var
  HTMLText:string;
  Index1, Index2:Integer;
  Part1, Part2:string;
begin
  Result:=inherited;

  if FSizeInput <> 0 then
  begin
    HTMLText:=Result.Contents[0].Render;
    Index1:=Pos('style="', HTMLText);
    Index2:=Pos('type="file"', HTMLText);
    Part1:=Copy(HTMLText,0,Index1 - 1);
    Part2:=Copy(HTMLText,Index2,Length(HTMLText)  - Index2 + 1);
    TIWTextElement(Result.Contents[0]).Text:=Part1 + ' size="' + IntToStr(FSizeInput) + '" ' + Part2;
  end;
end;

end.
