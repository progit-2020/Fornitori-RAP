unit meIWDBEdit;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWDBStdCtrls,
  IWDsnPaint, IWDsnPaintHandlers,IWDBCommon,DB,Menus;

type
  TmeIWDBEdit = class(TIWDBEdit)
  private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    procedure SetValue(const AValue: string); override;
    procedure CheckData; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;

implementation

constructor TmeIWDBEdit.Create(AOwner: TComponent);
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

  AutoEditable:=True;
  NonEditableAsLabel:=False;
  FContextMenu:=nil;
end;

function TmeIWDBEdit.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeIWDBEdit.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

procedure TmeIWDBEdit.SetValue(const AValue: string);
begin
  //se si passa da un campo DBEdit con date_picker (input_data_dmy) ad un altro
  //e il primo ha un evento asyncChange, capita che IW sposta tutti i campi data-aware
  //per postare sul server. in quel momento però il nuovo campo ha il mask impostato
  //e darebbe errore di data non valida bloccando l'esecuzione dell'evento async
  if (pos('input_data_dmy',css) > 0) and
     (AValue='__/__/____') then
    inherited SetValue('')
  else
    inherited;
end;

(*06/07/2012 Caratto - BugFix - il componente parte editabile anche se il dataset è in browse*)
procedure TmeIWDBEdit.CheckData;
begin
  EditingChanged;
  inherited;
end;
(* bugfix.end *)

initialization

end.
