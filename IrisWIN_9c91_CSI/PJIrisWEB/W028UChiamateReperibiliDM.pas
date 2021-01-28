unit W028UChiamateReperibiliDM;

interface

uses
  A000UCostanti, A000USessione, A000UInterfaccia, SysUtils, Classes, DB, Oracle, OracleData,
  DBClient;

type
  TW028FChiamateReperibiliDM = class(TDataModule)
    selT380: TOracleDataSet;
    selT390: TOracleDataSet;
    selT390DATA: TDateTimeField;
    selT390UTENTE: TStringField;
    selT390PROGRESSIVO_REPER: TFloatField;
    selT390ESITO: TStringField;
    selT390NOTE: TStringField;
    selT390DATA_TURNO: TDateTimeField;
    selT390TURNO: TStringField;
    selT390D_SCHEDAANAG: TStringField;
    selT390D_INFO: TStringField;
    selT390OPERATORE: TStringField;
    selT390DIPENDENTE: TStringField;
    selT390D_ESITO: TStringField;
    selT390MATRICOLA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT390AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TW028FChiamateReperibiliDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;

  // imposta costante QVistaOracle
  selT380.SetVariable('QVISTAORACLE',QVistaOracle);
 except
 end;
end;

procedure TW028FChiamateReperibiliDM.selT390AfterOpen(DataSet: TDataSet);
begin
  (selT390.FieldByName('DATA') as TDateTimeField).DisplayFormat:='dd/mm/yyyy hhhh.nn';
end;

end.
