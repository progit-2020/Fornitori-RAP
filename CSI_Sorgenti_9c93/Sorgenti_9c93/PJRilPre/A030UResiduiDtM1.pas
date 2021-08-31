unit A030UResiduiDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, OracleData, Oracle,
  A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis, A030UResiduiMW;

type
  TA030FResiduiDtM1 = class(TDataModule)
    procedure A030FResiduiDtM1Create(Sender: TObject);
    procedure A030FResiduiDtM1Destroy(Sender: TObject);
  private
    function ScegliAnnoForm(A: Word):Word;
  public
    A030MW:TA030FResiduiMW;
  end;

var
  A030FResiduiDtM1: TA030FResiduiDtM1;
  Anno:Word;

implementation

uses A030UResidui;

{$R *.DFM}

procedure TA030FResiduiDtM1.A030FResiduiDtM1Create(Sender: TObject);
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
  A030MW:=TA030FResiduiMW.Create(Self);
  A030MW.VisualizzaSceltaAnnoForm:=ScegliAnnoForm;
  A030FResidui.DButton.DataSet:=A030MW.Q130;
end;

procedure TA030FResiduiDtM1.A030FResiduiDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  if A030MW <> nil then
    FreeAndNil(A030MW);
end;

function TA030FResiduiDtM1.ScegliAnnoForm(A: Word):Word;
var M,G:Word;
begin
  DecodeDate(DataOut(Date,'Residui dell''anno','A'),A,M,G);
  Result:=A;
end;

end.
