unit A049UStampaPastiDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, OracleData, Oracle,
  (*Midaslib,*) Crtl, DBClient, Variants, A049UStampaPastiMW;

type
  TA049FStampaPastiDtM1 = class(TDataModule)
    procedure A049FStampaPastiDtM1Create(Sender: TObject);
    procedure A049FStampaPastiDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    A049FStampaPastiMW: TA049FStampaPastiMW;
  end;

var
  A049FStampaPastiDtM1: TA049FStampaPastiDtM1;

implementation

{$R *.DFM}

procedure TA049FStampaPastiDtM1.A049FStampaPastiDtM1Create(Sender: TObject);
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
  A049FStampaPastiMW:=TA049FStampaPastiMW.Create(Self);
end;

procedure TA049FStampaPastiDtM1.A049FStampaPastiDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(A049FStampaPastiMW);
end;

end.
