unit A091ULiquidPresenzeDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs,DB, A000UCostanti, A000USessione,A000UInterfaccia,
  C180FunzioniGenerali, Oracle, OracleData, (*Midaslib,*) Crtl, DBClient,
  Variants, A091ULiquidPresenzeMW;

type
  TA091FLiquidPresenzeDtM1 = class(TDataModule)
    procedure A091FDtM1Create(Sender: TObject);
    procedure A091FDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A091FLiquidPresenzeMW: TA091FLiquidPresenzeMW;
  end;

var
  A091FLiquidPresenzeDtM1: TA091FLiquidPresenzeDtM1;

implementation

uses A091ULiquidPresenze;

{$R *.DFM}

procedure TA091FLiquidPresenzeDtM1.A091FDtM1Create(Sender: TObject);
{Preparo le query Mensili}
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
  A091FLiquidPresenzeMW:=TA091FLiquidPresenzeMW.Create(Self);
end;

procedure TA091FLiquidPresenzeDtM1.A091FDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  FreeAndNil(A091FLiquidPresenzeMW);
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  end;
end;

end.
