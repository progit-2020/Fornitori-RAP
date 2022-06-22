unit A051UTimbOrigDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, Oracle, OracleData, (*Midaslib,*) Crtl,
  DBClient, Variants, A051UTimbOrigMW;

type
  TA051FTimbOrigDtM1 = class(TDataModule)
    D010: TDataSource;
    QTimbrature: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    procedure A051FTimbOrigDtM1Create(Sender: TObject);
    procedure A051FTimbOrigDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    A051MW: TA051FTimbOrigMW;
    procedure CreaTabellaStampa;
  end;

var
  A051FTimbOrigDtM1: TA051FTimbOrigDtM1;

implementation

uses  A051UTimbOrig;

{$R *.DFM}

procedure TA051FTimbOrigDtM1.A051FTimbOrigDtM1Create(Sender: TObject);
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
  CreaTabellaStampa;
  A051MW:=TA051FTimbOrigMW.Create(Self);
  D010.DataSet:=A051MW.selI010;
end;

procedure TA051FTimbOrigDtM1.CreaTabellaStampa;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Gruppo',ftString,50,False);
  TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Data',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('Cognome',ftString,30,False);
  TabellaStampa.FieldDefs.Add('Nome',ftString,30,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftString,6,False);
  TabellaStampa.FieldDefs.Add('Badge',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Timb1',ftString,126,False);
  TabellaStampa.FieldDefs.Add('Timb2',ftString,126,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Gruppo;Cognome;Nome;Matricola;Progressivo;Data'),[ixUnique]);
  TabellaStampa.IndexName:='Primario';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA051FTimbOrigDtM1.A051FTimbOrigDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  TabellaStampa.Close;
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

end.
