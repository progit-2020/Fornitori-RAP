unit meIWDBGrid;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, IWCompGridCommon, Db,Menus;

type
  TmeIWDBGrid = class(TIWDBGrid)
  private
    FContextMenu: TPopupMenu;
    FFixedColumns: Integer;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreateImplicitColumns;
    function  ToCsv: String;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
    property medpFixedColumns: Integer read FFixedColumns write FFixedColumns;
  end;

implementation

constructor TmeIWDBGrid.Create(AOwner: TComponent);
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
  medpFixedColumns:=0;
  FContextMenu:=nil;
  { DONE : TEST IW 14 OK }
  HeaderRowCount:=0;
end;

//bug 12.2.6. se cambia datasource non rilegge il campo ma tiene il puntatore al vecchio campo
procedure TmeIWDBGrid.CreateImplicitColumns;
var i :Integer;
fieldName : String;
begin
  if Columns.Count = 0 then
    inherited
  else
  begin
    for i := 0 to Columns.Count - 1 do
    begin
      fieldName:=TIWDBGridColumn(Columns.Items[i]).DataField;
      TIWDBGridColumn(Columns.Items[i]).DataField:='';
      TIWDBGridColumn(Columns.Items[i]).DataField:=fieldName;
      fieldName:=TIWDBGridColumn(Columns.Items[i]).LinkField;
      TIWDBGridColumn(Columns.Items[i]).LinkField:='';
      TIWDBGridColumn(Columns.Items[i]).LinkField:=fieldName;
    end;
  end;
end;

function TmeIWDBGrid.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;


procedure TmeIWDBGrid.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

function TmeIWDBGrid.ToCsv: String;
var
  DS: TDataSet;
  Riga: String;
  BM: TBookMark;
  i: Integer;
begin
  Result:='';

  // utilizza il dataset collegato via datasource alla grid
  DS:=DataSource.DataSet;
  if not Assigned(DS) then
    raise Exception.Create(Format('dataset della tabella %s non assegnato',[Name]));

  // intestazione
  Riga:='';
  for i:=0 to DS.FieldCount - 1 do
    if DS.Fields[i].Visible then
      Riga:=Riga + Format('"%s"',[Trim(Uppercase(DS.Fields[i].FieldName))]) + #9;
  Result:=Result + Riga + #13#10;

  // dettaglio
  BM:=DS.Bookmark;
  try
    DS.First;
    while not DS.Eof do
    begin
      Riga:='';
      for i:=0 to DS.FieldCount - 1 do
        if DS.Fields[i].Visible then
          Riga:=Riga + Format('"%s"',[Trim(DS.Fields[i].AsString)]) + #9;

      Result:=Result + Riga + #13#10;
      DS.Next;
    end;

    // riposizionamento cursore
    if DS.BookmarkValid(BM) then
      DS.GotoBookmark(BM);
  finally
    DS.FreeBookmark(BM);
  end;
end;

end.
