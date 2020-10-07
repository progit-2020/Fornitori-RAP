unit W005UCartellinoDtm;

interface

uses
  SysUtils, Classes, DB, OracleData,
  Graphics, SyncObjs, Oracle,
  A000UInterfaccia;

type
  TW005FCartellinoDtm = class(TDataModule)
    selT100: TOracleDataSet;
    selT040: TOracleDataSet;
    selV010: TOracleDataSet;
    selT080: TOracleDataSet;
    Timbrature: TOracleQuery;
    selT050: TOracleDataSet;
    T010F_GGSIGNIFICATIVO: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}


procedure TW005FCartellinoDtm.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
 except
 end;
end;

end.
