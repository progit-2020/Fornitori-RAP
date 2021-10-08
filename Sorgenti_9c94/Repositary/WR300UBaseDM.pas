unit WR300UBaseDM;
{
  This is a DataModule where you can add components or declare fields that are specific to
  ONE user. Instead of creating global variables, it is better to use this datamodule. You can then
  access the it using UserSession.
}
interface

uses
  IWUserSessionBase, SysUtils, Classes, DB, Oracle, OracleData,
  A000UInterfaccia,medpIWMessageDlg,WR010UBase,IWApplication;

type
  TWR300FBaseDM = class(TIWUserSessionBase)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWR300FBaseDM.IWUserSessionBaseCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleDataSet then
    begin
      if TOracleDataSet(Components[i]).Session = nil then
        TOracleDataSet(Components[i]).Session:=SessioneOracle
    end
    else if Components[i] is TOracleQuery then
    begin
      if TOracleQuery(Components[i]).Session = nil then
        TOracleQuery(Components[i]).Session:=SessioneOracle
    end
    else if Components[i] is TOracleScript then
    begin
      if TOracleScript(Components[i]).Session = nil then
        TOracleScript(Components[i]).Session:=SessioneOracle;
    end;
  end;
end;

procedure TWR300FBaseDM.IWUserSessionBaseDestroy(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleDataSet then
      TOracleDataSet(Components[i]).CloseAll
    else if Components[i] is TOracleQuery then
      TOracleQuery(Components[i]).Close;
  end;
end;

end.
