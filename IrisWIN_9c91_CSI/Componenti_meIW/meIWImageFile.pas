unit meIWImageFile;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompExtCtrls, IWTypes,
  IWRenderContext,IWScriptEvents, Menus;

type
  TmeIWImageFile = class(TIWImageFile)
  private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    FDownloadButton: Boolean;
    procedure HookEvents(AContext: TIWPageContext40; AScriptEvents: TIWScriptEvents); override;
  public
    medpTag: TObject;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property medpDownloadButton: Boolean read FDownloadButton write FDownloadButton;
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;

implementation

constructor TmeIWImageFile.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Font.Enabled:=False;
  RenderSize:=False;
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
end;

destructor TmeIWImageFile.Destroy;
begin
  if Assigned(medpTag) then
  begin
    FreeAndNil(medpTag);
  end;
  inherited;
end;

{ DONE : TEST IW 14 OK }
procedure TmeIWImageFile.HookEvents(AContext: TIWPageContext40;
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

function TmeIWImageFile.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeIWImageFile.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

end.
