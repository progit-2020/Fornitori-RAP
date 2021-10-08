unit meIWGrid;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids,
  IWCompGridCommon, Db,Menus;

type
  TmeIWGrid = class(TIWGrid)
  private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
    procedure _medpFreeControls(Comp: TIWGrid);
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ToCsv: String;
    procedure medpClearComp;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;

implementation

constructor TmeIWGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BorderSize:=0;
  BorderStyle:=tfVoid;
  Caption:='';
  CellPadding:=0;
  CellRenderOptions:=[];
  CellSpacing:=0;
  Css:='grid';
  Font.Enabled:=False;
  Lines:=tlNone;
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
  FContextMenu:=nil;
  { DONE : TEST IW 14 OK }
  HeaderRowCount:=0;
end;

destructor TmeIWGrid.Destroy;
begin
  medpClearComp;
  inherited Destroy;
end;

function TmeIWGrid.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeIWGrid.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

function TmeIWGrid.ToCsv: String;
var
  Riga: String;
  i, r: Integer;
begin
  Result:='';
  Riga:='';

  // intestazione
  for i:=0 to ColumnCount - 1 do
    Riga:=Riga + '"' + Trim((Cell[0,i].Text)) + '"' + #9;
  Result:=Result + Riga + #13#10;

  // dettagli
  for r:=1 to RowCount - 1 do
  begin
    Riga:='';
    for i:=0 to ColumnCount - 1 do
      Riga:=Riga + '"' + Trim(Cell[r,i].Text) + '"' + #9;
    Result:=Result + Riga + #13#10;
  end;
end;

procedure TmeIWGrid.medpClearComp;
begin
  _medpFreeControls(Self);
end;

procedure TmeIWGrid._medpFreeControls(Comp: TIWGrid);
var
  i,j:Integer;
  IWC:TIWCustomControl;
begin
  for i:=0 to Comp.RowCount - 1 do
  begin
    for j:=0 to Comp.ColumnCount - 1 do
    begin
      if Comp.Cell[i,j].Control <> nil then
      begin
        if Comp.Cell[i,j].Control is TIWGrid then
          _medpFreeControls(TIWGrid(Comp.Cell[i,j].Control));

        IWC:=Comp.Cell[i,j].Control;
        Comp.Cell[i,j].Control:=nil;
        FreeAndNil(IWC);
      end;
    end;
  end;
  Comp.Clear;
end;

end.
