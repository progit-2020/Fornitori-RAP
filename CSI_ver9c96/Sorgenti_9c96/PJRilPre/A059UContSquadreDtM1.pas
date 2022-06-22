unit A059UContSquadreDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, OracleData, Oracle,  Variants,
  A059UContSquadraMW;

type
  TA059FContSquadreDtM1 = class(TDataModule)
    Q080: TOracleDataSet;
    Q081: TOracleDataSet;
    Q040: TOracleDataSet;
    Q041: TOracleDataSet;
    Q600Squadre: TOracleDataSet;
    Q601: TOracleDataSet;
    Q601SQUADRA: TStringField;
    Q601CODICE: TStringField;
    Q600SquadreCODICE: TStringField;
    Q600SquadreDESCRIZIONE: TStringField;
    QT021: TOracleDataSet;
    Q600SquadreFESMIN1: TIntegerField;
    Q600SquadreFESMAX1: TIntegerField;
    Q600SquadreFESMIN2: TIntegerField;
    Q600SquadreFESMAX2: TIntegerField;
    Q600SquadreFESMIN3: TIntegerField;
    Q600SquadreFESMAX3: TIntegerField;
    Q600SquadreFESMIN4: TIntegerField;
    Q600SquadreFESMAX4: TIntegerField;
    Q600SquadreTOTMIN1: TIntegerField;
    Q600SquadreTOTMAX1: TIntegerField;
    Q600SquadreTOTMIN2: TIntegerField;
    Q600SquadreTOTMAX2: TIntegerField;
    Q600SquadreTOTMIN4: TIntegerField;
    Q600SquadreTOTMAX4: TIntegerField;
    Q600SquadreTOTMIN3: TIntegerField;
    Q600SquadreTOTMAX3: TIntegerField;
    Q601MIN1: TIntegerField;
    Q601MAX1: TIntegerField;
    Q601MIN2: TIntegerField;
    Q601MAX2: TIntegerField;
    Q601MIN3: TIntegerField;
    Q601MAX3: TIntegerField;
    Q601MIN4: TIntegerField;
    Q601MAX4: TIntegerField;
    procedure A059FContSquadreDtM1Create(Sender: TObject);
    procedure D600DataChange(Sender: TObject; Field: TField);
    procedure A059FContSquadreDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    A059MW: TA059FContSquadraMW;
  end;

var
  A059FContSquadreDtM1: TA059FContSquadreDtM1;

implementation

uses A059UContSquadre;

{$R *.DFM}

procedure TA059FContSquadreDtM1.A059FContSquadreDtM1Create(Sender: TObject);
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
  A059MW:=TA059FContSquadraMW.Create(Self);
  QT021.Open;
  with A059FContSquadre do
  begin
    cmbDaSquadra.KeyValue:=A059MW.Q600.FieldByName('Codice').AsString;
    cmbASquadra.KeyValue:=A059MW.Q600.FieldByName('Codice').AsString;
    DataInizio:=Parametri.DataLavoro;
    DataFine:=Parametri.DataLavoro;
    LDaData.Caption:=FormatDateTime('dd mmmm yyyy',Parametri.DataLavoro);
    LAData.Caption:=FormatDateTime('dd mmmm yyyy',Parametri.DataLavoro);
  end;
end;

procedure TA059FContSquadreDtM1.D600DataChange(Sender: TObject;
  Field: TField);
begin
  if Sender = A059MW.D600 then
    A059FContSquadre.LSquadra1.Visible:=A059FContSquadre.cmbDaSquadra.KeyValue <> ''
  else
    A059FContSquadre.LSquadra2.Visible:=A059FContSquadre.cmbASquadra.KeyValue <> '';
end;

procedure TA059FContSquadreDtM1.A059FContSquadreDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

end.
