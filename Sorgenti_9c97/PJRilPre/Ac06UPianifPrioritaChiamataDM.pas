unit Ac06UPianifPrioritaChiamataDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  OracleData, Oracle, Variants,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione,
  C180FunzioniGenerali, RegistrazioneLog, Ac06UPianifPrioritaChiamataMW;

type
  TAc06FPianifPrioritaChiamataDM = class(TDataModule)
    dsrT381: TDataSource;
    selT381: TOracleDataSet;
    selT381PROGRESSIVO: TFloatField;
    selT381DATA: TDateTimeField;
    selT381PRIORITA: TIntegerField;
    procedure Ac06FPianifPrioritaChiamataDMCreate(Sender: TObject);
    procedure Ac06FPianifPrioritaChiamataDMDestroy(Sender: TObject);
  private
  public
    Ac06MW: TAc06FPianifPrioritaChiamataMW;
  end;

var
  Ac06FPianifPrioritaChiamataDM: TAc06FPianifPrioritaChiamataDM;

implementation

uses Ac06UPianifPrioritaChiamata;

{$R *.DFM}

procedure TAc06FPianifPrioritaChiamataDM.Ac06FPianifPrioritaChiamataDMCreate(Sender: TObject);
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
  Ac06MW:=TAc06FPianifPrioritaChiamataMW.Create(Self);
  Ac06MW.selT381:=selT381;
end;

procedure TAc06FPianifPrioritaChiamataDM.Ac06FPianifPrioritaChiamataDMDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

end.
