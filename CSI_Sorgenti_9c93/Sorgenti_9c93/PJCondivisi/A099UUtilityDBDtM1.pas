unit A099UUtilityDBDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, A000UCostanti, A000USessione,A000UInterfaccia, Oracle, Variants;

type
  TA099FUtilityDBDtM1 = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A099FUtilityDBDtM1: TA099FUtilityDBDtM1;

implementation

uses A099UUtilityDB, A099UUtilityDBMW;

{$R *.DFM}

procedure TA099FUtilityDBDtM1.DataModuleCreate(Sender: TObject);
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  A099FUtilityDB.A099FUtilityDBMW:=TA099FUtilityDBMW.Create(nil);
end;

procedure TA099FUtilityDBDtM1.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A099FUtilityDB.A099FUtilityDBMW);
end;

end.
