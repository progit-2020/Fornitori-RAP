unit A068UTurniGiorDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  A000UCostanti, A000USessione,A000UInterfaccia, Db, OracleData, Oracle,
  C700USelezioneAnagrafe, Variants;

type
  TA068FTurniGiorDtM1 = class(TDataModule)
    Q081: TOracleDataSet;
    Q040: TOracleDataSet;
    selT080: TOracleDataSet;
    selTemp: TOracleDataSet;
    procedure A068FTurniGiorDtM1Create(Sender: TObject);
    procedure QVistaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A068FTurniGiorDtM1: TA068FTurniGiorDtM1;

implementation

uses A068UTurniGior;

{$R *.DFM}

procedure TA068FTurniGiorDtM1.A068FTurniGiorDtM1Create(Sender: TObject);
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
  A068FTurniGior.Data:=Parametri.DataLavoro;
end;

procedure TA068FTurniGiorDtM1.QVistaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  try
    Accept:=(C700SelAnagrafe.FieldByName('T430FINE').AsDateTime >= A068FTurniGior.Data) or
            C700SelAnagrafe.FieldByName('T430FINE').IsNull or
            (C700SelAnagrafe.FieldByName('T430FINE').AsDateTime = 0);
  except
    Accept:=False;
  end;
end;

end.
