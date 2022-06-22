unit A095UStRiasStrDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs,DB, A000UCostanti, A000USessione,A000UInterfaccia,
  C180FunzioniGenerali, Oracle, OracleData,
  Crtl, DBClient, Variants,
  A095UStRiasStrMW;

type
  TA095FStRiasStrDtM1 = class(TDataModule)
    procedure A095FDtM1Create(Sender: TObject);
    procedure A095FDtM1Destroy(Sender: TObject);
  private
  public
    A095FStRiasStrMW: TA095FStRiasStrMW;
  end;

var
  A095FStRiasStrDtM1: TA095FStRiasStrDtM1;

implementation

uses A095UStRiasStr;

{$R *.DFM}

procedure TA095FStRiasStrDtM1.A095FDtM1Create(Sender: TObject);
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
  A095FStRiasStrMW:=TA095FStRiasStrMW.Create(Self);
end;

procedure TA095FStRiasStrDtM1.A095FDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  end;
  //Caratto 07/05/2013 rimozione variabili globali
//  A029FBudgetDtM1.Free;
end;

end.
