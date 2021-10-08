unit meIWButton;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  IWDsnPaint, IWDsnPaintHandlers, IWRenderContext, IWScriptEvents;

type
  TmeIWButton = class(TIWButton)
  private
    { Private declarations }
  protected
    FDownloadButton: Boolean;
    procedure HookEvents(AContext: TIWPageContext40;AScriptEvents: TIWScriptEvents); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    property medpDownloadButton: Boolean read FDownloadButton write FDownloadButton;
  end;

implementation

constructor TmeIWButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Css:='pulsante';
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

{ DONE : TEST IW 14 OK }
procedure TmeIWButton.HookEvents(AContext: TIWPageContext40;
  AScriptEvents: TIWScriptEvents);
var
  sClick: String;
begin
  inherited;

  if FDownloadButton then
  begin
    sClick:=AScriptEvents.Values['OnClick'];
    if sClick = '' then
    begin
      sClick:=' ReleaseLock(); GActivateLock=false; return true;';
      AScriptEvents.Values['OnClick']:=sClick;
    end
    else
    begin
      if Pos('ReleaseLock();',sClick) = 0 then
      begin
        sClick:=' ReleaseLock(); GActivateLock=false; ' + sClick;
        AScriptEvents.Values['OnClick']:=sClick;
      end;
    end;
  end;
end;

end.
