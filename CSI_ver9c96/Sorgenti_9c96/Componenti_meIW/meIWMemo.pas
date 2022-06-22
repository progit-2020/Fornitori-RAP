unit meIWMemo;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompMemo,
  IWDsnPaint, IWDsnPaintHandlers;

type
  TmeIWMemo = class(TIWMemo)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    medpTag: TObject;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

constructor TmeIWMemo.Create(AOwner: TComponent);
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
end;

procedure Register;
begin
  //
end;

destructor TmeIWMemo.Destroy;
begin
  if Assigned(medpTag) then
    try FreeAndNil(medpTag); except end;
  inherited;
end;

initialization


end.
