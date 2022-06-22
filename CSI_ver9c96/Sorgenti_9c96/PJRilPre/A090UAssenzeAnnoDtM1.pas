unit A090UAssenzeAnnoDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, Oracle, OracleData,
  (*Midaslib,*) Crtl, DBClient, Variants, A090UAssenzeAnnoMW;

type
  TA090FAssenzeAnnoDtM1 = class(TDataModule)
    D010: TDataSource;
    QPresenze: TOracleDataSet;
    QPresenzePROGRESSIVO: TFloatField;
    QPresenzeDATA: TDateTimeField;
    QGiustificativiAssenza: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    procedure A090FAssenzeAnnoDtM1Create(Sender: TObject);
    procedure A090FAssenzeAnnoDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    A090MW: TA090FAssenzeAnnoMW;
    procedure CreaTabellaStampa;
  end;

var
  A090FAssenzeAnnoDtM1: TA090FAssenzeAnnoDtM1;

implementation

uses A090UAssenzeAnno;

{$R *.DFM}

procedure TA090FAssenzeAnnoDtM1.A090FAssenzeAnnoDtM1Create(Sender: TObject);
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
  A090MW:=TA090FAssenzeAnnoMW.Create(Self);
  D010.DataSet:=A090MW.selI010;
end;

procedure TA090FAssenzeAnnoDtM1.CreaTabellaStampa;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Ordine',ftInteger,0,True);
  TabellaStampa.FieldDefs.Add('Cognome',ftString,30,False);
  TabellaStampa.FieldDefs.Add('Progressivo',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Mese',ftString,2,False);
  TabellaStampa.FieldDefs.Add('Situazione1',ftString,187,False);
  TabellaStampa.FieldDefs.Add('Situazione2',ftString,187,False);
  TabellaStampa.FieldDefs.Add('Situazione3',ftString,187,False);
  TabellaStampa.FieldDefs.Add('Situazione4',ftString,187,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario','Ordine;Cognome;Progressivo;Mese',[ixUnique]);
  TabellaStampa.IndexName:='Primario';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA090FAssenzeAnnoDtM1.A090FAssenzeAnnoDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  TabellaStampa.Close;
end;

end.
