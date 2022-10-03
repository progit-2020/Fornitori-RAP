unit A057USpostSquadraDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  A000UCostanti, A000USessione,A000UInterfaccia, Db, OracleData, Oracle,  Variants;

type
  TA057FSpostSquadraDtM1 = class(TDataModule)
    D630: TDataSource;
    D600: TDataSource;
    D020: TDataSource;
    Q600: TOracleDataSet;
    Q020: TOracleDataSet;
    Q630: TOracleDataSet;
    Q630PROGRESSIVO: TFloatField;
    Q630DATA: TDateTimeField;
    Q630SQUADRA: TStringField;
    Q630ORARIO: TStringField;
    Q630TURNO1: TStringField;
    Q630TURNO2: TStringField;
    procedure A057FSpostSquadraDtM1Create(Sender: TObject);
    procedure A057FSpostSquadraDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A057FSpostSquadraDtM1: TA057FSpostSquadraDtM1;

implementation

uses A057USpostSquadra;

{$R *.DFM}

procedure TA057FSpostSquadraDtM1.A057FSpostSquadraDtM1Create(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  Q600.Open;
  Q020.Open;
end;

procedure TA057FSpostSquadraDtM1.A057FSpostSquadraDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

end.
