unit A081UTimbCausDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, Oracle,OracleData,
  (*Midaslib,*) Crtl, DBClient, Variants, A081UTimbCausMW;

type
  TA081FTimbCausDtM1 = class(TDataModule)
    D010: TDataSource;
    QGiustificativiAssenza: TOracleDataSet;
    Q265: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    procedure A081FTimbCausDtM1Create(Sender: TObject);
    procedure A081FTimbCausDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    A081MW: TA081FTimbCausMW;
    procedure CreaTabellaStampa;
  end;

var
  A081FTimbCausDtM1: TA081FTimbCausDtM1;

implementation

uses A081UTimbCaus;

{$R *.DFM}

procedure TA081FTimbCausDtM1.A081FTimbCausDtM1Create(Sender: TObject);
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
  A081MW:=TA081FTimbCausMW.Create(Self);
  D010.DataSet:=A081MW.selI010;
  Q265.Open;
end;

procedure TA081FTimbCausDtM1.CreaTabellaStampa;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Gruppo',ftString,40,False);
  TabellaStampa.FieldDefs.Add('Causale',ftString,5,False);
  TabellaStampa.FieldDefs.Add('Data',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('Cognome',ftString,60,False);
  TabellaStampa.FieldDefs.Add('Badge',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Prog',ftAutoInc,0,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Descrizione',ftString,40,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Gruppo;Causale;Data;Cognome;Badge;Prog'),[ixUnique]);
  TabellaStampa.IndexName:='Primario';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA081FTimbCausDtM1.A081FTimbCausDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  TabellaStampa.Close;
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
end;

end.
