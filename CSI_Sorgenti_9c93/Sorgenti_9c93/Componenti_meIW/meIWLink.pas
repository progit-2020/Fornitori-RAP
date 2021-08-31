unit meIWLink;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls,
  IWDsnPaint, IWDsnPaintHandlers, IWRenderContext, IWScriptEvents;

type
  TmeIWLink = class(TIWLink)
  private
    { Private declarations }
  protected
    FDownloadButton: Boolean;
    procedure HookEvents(AContext: TIWPageContext40; AScriptEvents: TIWScriptEvents); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property medpDownloadButton: Boolean read FDownloadButton write FDownloadButton;
  end;


implementation

constructor TmeIWLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Css:='link';
  RenderSize:=False;
  Font.Enabled:=False;
  NonEditableAsLabel:=False;
  with StyleRenderOptions do
  begin
    RenderAbsolute:=False;
    RenderFont:=False;
    RenderPosition:=False;
    RenderSize:=False;
    RenderStatus:=True;
    RenderVisibility:=True;
    RenderZIndex:=False;
    //scommentare per versioni da 12.2.16 in poi
    RenderPadding:=False;
    { DONE : TEST IW 14 OK }
    RenderBorder:=False;
  end;
end;

procedure TmeIWLink.HookEvents(AContext: TIWPageContext40;
  AScriptEvents: TIWScriptEvents);
// l'evento OnClick corrisponde a una hookevent per l'evento OnClick
// perciò questo componente si comporta in modo differente da tutti gli altri
// Attenzione! Se si esegue 2 volte HookEvent dello stesso evento, Intraweb
// lo aggiunge una seconda volta!!
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
