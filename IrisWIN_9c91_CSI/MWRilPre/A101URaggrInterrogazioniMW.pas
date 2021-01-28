unit A101URaggrInterrogazioniMW;

interface

uses
  R005UDataModuleMW, System.Classes, Data.DB, SysUtils, OracleData, Oracle, C180FunzioniGenerali,
  A000USessione;

type
  TA101FRaggrInterrogazioniMW = class(TR005FDataModuleMW)
    selT002: TOracleDataSet;
    seqT005: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT002FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetSeqT005:integer;
  end;

var
  A101FRaggrInterrogazioniMW: TA101FRaggrInterrogazioniMW;

implementation

{$R *.dfm}

procedure TA101FRaggrInterrogazioniMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT002.Open;
end;

function TA101FRaggrInterrogazioniMW.GetSeqT005:integer;
begin
  seqT005.ClearVariables;
  seqT005.Execute;
  Result:=seqT005.GetVariable('T005ID');
end;

procedure TA101FRaggrInterrogazioniMW.selT002FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',DataSet.FieldByName('NOME').AsString);
end;

end.
