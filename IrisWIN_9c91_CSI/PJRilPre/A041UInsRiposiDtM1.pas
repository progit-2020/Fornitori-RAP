unit A041UInsRiposiDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe, C004UParamForm, C180FunzioniGenerali,
  OracleData, Oracle, Variants,A041UInsRiposiMW;

type
  TA041FInsRiposiDtM1 = class(TDataModule)
    procedure A041FInsRiposiDtM1Create(Sender: TObject);
    procedure A041FInsRiposiDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
//    DataFiltro:TDateTime;
    A041FInsRiposiMW:TA041FInsRiposiMW;
  end;

var
  A041FInsRiposiDtM1: TA041FInsRiposiDtM1;

implementation

uses A041UInsRiposi;

{$R *.DFM}

procedure TA041FInsRiposiDtM1.A041FInsRiposiDtM1Create(
  Sender: TObject);
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
  A041FInsRiposiMW:=TA041FInsRiposiMW.Create(Self);
end;

procedure TA041FInsRiposiDtM1.A041FInsRiposiDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  FreeAndNil(A041FInsRiposiMW);
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

end.
