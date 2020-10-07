unit A044UAllineaStoriciDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, Oracle, OracleData, Variants,
  A044UAllineaStoriciMW;

type
  TA044FAllineaStoriciDtM1 = class(TDataModule)
    procedure A044FAllineaStoriciDtM1Create(Sender: TObject);
    procedure A044FAllineaStoriciDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    A044FAllineaStoriciMW: TA044FAllineaStoriciMW;
  end;

var
  A044FAllineaStoriciDtM1: TA044FAllineaStoriciDtM1;

implementation

{$R *.DFM}

procedure TA044FAllineaStoriciDtM1.A044FAllineaStoriciDtM1Create(
  Sender: TObject);
var i:Integer;
begin
  if Self.Owner is TOracleSession then
  begin
    for i:=0 to Self.ComponentCount - 1 do
    begin
      if Components[i] is TOracleQuery then
        (Components[i] as TOracleQuery).Session:=(Self.Owner as TOracleSession);
      if Components[i] is TOracleDataSet then
        (Components[i] as TOracleDataSet).Session:=(Self.Owner as TOracleSession);
    end;
    //Crea Middleware passando la connessione. Usato da crezione da P300
    A044FAllineaStoriciMW:=TA044FAllineaStoriciMW.Create(Self.Owner as TOracleSession);
  end
  else
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
    A044FAllineaStoriciMW:=TA044FAllineaStoriciMW.Create(Self);
  end;
end;

procedure TA044FAllineaStoriciDtM1.A044FAllineaStoriciDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(A044FAllineaStoriciMW);
end;


end.
