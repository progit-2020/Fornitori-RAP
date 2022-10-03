unit medpBackupOldValue;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TmedpBackupOldValue = class(TClientDataSet)
  private
    fDataSet:TDataSet;
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent; DataSet:TDataSet); overload;
    procedure SetDataSet(NewDataSet:TDataSet);
    procedure CreaStruttura;
    procedure Aggiorna;
    procedure Reimposta;
    property DataSet:TDataSet read fDataSet write SetDataSet;
  published
    { Published declarations }
  end;

implementation

constructor TmedpBackupOldValue.Create(AOwner: TComponent; DataSet:TDataSet);
begin
  inherited Create(AOwner);
  Self.fDataSet:=DataSet;
end;

procedure TmedpBackupOldValue.SetDataSet(NewDataSet:TDataSet);
begin
  if Self.Active then
  begin
    Self.EmptyDataSet;
    Self.Close;
  end;
  Self.FieldDefs.Clear;
  fDataSet:=NewDataSet;
end;

procedure TmedpBackupOldValue.CreaStruttura;
var
  I:Integer;
  CurrentFieldDef,NewFieldDef:TFieldDef;
begin
  if not Assigned(fDataSet) then
    raise Exception.Create('[TmedpBackupOldValue]: DataSet non definito');

  Self.Reimposta;
  for I:=0 to (fDataSet.FieldDefList.Count - 1) do
  begin
    CurrentFieldDef:=fDataSet.FieldDefList[I];
    NewFieldDef:=Self.FieldDefs.AddFieldDef;
    NewFieldDef.Name:=CurrentFieldDef.Name;
    NewFieldDef.DataType:=CurrentFieldDef.DataType;
    NewFieldDef.Size:=CurrentFieldDef.Size;
  end;
  Self.CreateDataSet;
  Self.LogChanges:=False;
end;

procedure TmedpBackupOldValue.Aggiorna;
var
  I:Integer;
  CurrentFieldDef:TFieldDef;
begin
  if not Assigned(fDataSet) then
    raise Exception.Create('[TmedpBackupOldValue]: DataSet non definito');

  if fDataSet.State <> dsInsert then
  begin
    Self.EmptyDataSet;
    Self.Insert;
    for I:=0 to (fDataSet.FieldDefList.Count - 1) do
    begin
      CurrentFieldDef:=fDataSet.FieldDefList[I];
      if (fDataSet.FindField(CurrentFieldDef.Name) <> nil) and
         (fDataSet.FieldByName(CurrentFieldDef.Name).FieldKind in [fkData, fkInternalCalc]) then
            Self.FieldByName(CurrentFieldDef.Name).Value:=fDataSet.FieldByName(CurrentFieldDef.Name).Value;
    end;
    Self.Post;
  end;
end;

procedure TmedpBackupOldValue.Reimposta;
begin
  if Self.Active then
  begin
    Self.EmptyDataSet;
    Self.Close;
  end;
  Self.FieldDefs.Clear;
end;

end.
