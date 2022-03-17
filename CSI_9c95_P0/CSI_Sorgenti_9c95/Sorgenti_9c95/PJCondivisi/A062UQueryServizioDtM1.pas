unit A062UQueryServizioDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, Oracle, OracleData, Variants,
  DBClient, A062UQueryServizioMW;

type
  TA062FQueryServizioDtM1 = class(TDataModule)
    dsrT002: TDataSource;
    selT002: TOracleDataSet;
    selT002NOME: TStringField;
    procedure A062FQueryServizioDtM1Create(Sender: TObject);
    procedure A062FQueryServizioDtM1Destroy(Sender: TObject);
    procedure selT002FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    {private declarations}
  public
    A062MW:TA062FQueryServizioMW;
  end;

var
  A062FQueryServizioDtM1: TA062FQueryServizioDtM1;

implementation

uses A062UQueryServizio;

{$R *.DFM}

procedure TA062FQueryServizioDtM1.A062FQueryServizioDtM1Create(Sender: TObject);
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
  A062MW:=TA062FQueryServizioMW.Create(nil);
  A062MW.selT002:=selT002;
  selT002.SetVariable('Applicazione',Parametri.Applicazione);
  A062MW.OpenSelT002(selT002,'');
end;

procedure TA062FQueryServizioDtM1.A062FQueryServizioDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(A062MW);
end;

procedure TA062FQueryServizioDtM1.selT002FilterRecord(DataSet: TDataSet;var Accept: Boolean);
begin
  A062MW.selT002FiltraRecord(DataSet,Accept);
end;

end.
