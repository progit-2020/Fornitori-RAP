unit Wc38UBollatriceVirtualeDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, OracleData, Oracle, A000USessione,
  A000UInterfaccia, OracleMonitor;

type
  TWc38FBollatriceVirtualeDM = class(TDataModule)
    selT100: TOracleDataSet;
    selT100DATA: TDateTimeField;
    selT100ORA: TStringField;
    selT100VERSO: TStringField;
    selT100FLAG: TStringField;
    selT100CAUSALE: TStringField;
    selT100RILEVATORE: TStringField;
    selT100MATRICOLA: TStringField;
    selT100NOMINATIVO: TStringField;
    selT100DESC_VERSO: TStringField;
    selT100DESC_CAUSALE: TStringField;
    selT100MOTIVAZIONE: TStringField;
    selT100PROGRESSIVO: TFloatField;
    selT100NOTE: TStringField;
    insT100: TOracleQuery;
    selT361: TOracleDataSet;
    selT100DESC_RILEVATORE: TStringField;
    selVT100TimbPrec: TOracleDataSet;
    selT275Abilitate: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT275AbilitateFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWc38FBollatriceVirtualeDM.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;
  selT361.Open;
 except
 end;
end;

procedure TWc38FBollatriceVirtualeDM.selT275AbilitateFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
  if DataSet.FieldByName('TIPO').AsString = 'T275' then
    Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet.FieldByName('TIPO').AsString = 'T305' then
    Accept:=A000FiltroDizionario('CAUSALI GIUSTIFICAZIONE',DataSet.FieldByName('CODICE').AsString);
end;

end.
