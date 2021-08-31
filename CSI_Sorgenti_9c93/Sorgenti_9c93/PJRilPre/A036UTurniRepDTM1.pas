unit A036UTurniRepDTM1;

interface

uses
  Classes, Forms, DB, OracleData, Oracle,
  A000USessione, A000UInterfaccia, C180FunzioniGenerali, A036UTurniRepMW;

type
  TA036FTurniRepDTM1 = class(TDataModule)
    selT340: TOracleDataSet;
    selT340PROGRESSIVO: TFloatField;
    selT340ANNO: TFloatField;
    selT340MESE: TFloatField;
    selT340TURNIINTERI: TFloatField;
    selT340TURNIORE: TStringField;
    selT340OREMAGG: TStringField;
    selT340ORENONMAGG: TStringField;
    selT340CALCMESE: TStringField;
    selT340VP_TURNO: TStringField;
    selT340VP_ORE: TStringField;
    selT340VP_MAGGIORATE: TStringField;
    selT340VP_NONMAGGIORATE: TStringField;
    selT340GETTONE_CHIAMATA: TIntegerField;
    selT340VP_GETTONE_CHIAMATA: TStringField;
    selT340TURNI_OLTREMAX: TIntegerField;
    selT340VP_TURNI_OLTREMAX: TStringField;
    procedure A036TurniRepDTM1Create(Sender: TObject);
    procedure A036TurniRepDTM1Destroy(Sender: TObject);
    procedure selT340CalcFields(DataSet: TDataSet);
    procedure selT340NewRecord(DataSet: TDataSet);
    procedure selT340BeforePost(DataSet: TDataSet);
    procedure selT340BeforeDelete(DataSet: TDataSet);
    procedure selT340AfterDelete(DataSet: TDataSet);
    procedure ValidaOre(Sender: TField);
    procedure ValidaVoce(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    A036MW: TA036FTurniRepMW;
  end;

var
  A036FTurniRepDTM1: TA036FTurniRepDTM1;

implementation

{$R *.DFM}

procedure TA036FTurniRepDTM1.A036TurniRepDTM1Create(Sender: TObject);
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
  A036MW:=TA036FTurniRepMW.Create(Self);
  A036MW.selT340:=selT340;
end;

procedure TA036FTurniRepDTM1.A036TurniRepDTM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA036FTurniRepDTM1.selT340CalcFields(DataSet: TDataSet);
begin
  A036MW.OnCalcFields;
end;

procedure TA036FTurniRepDTM1.selT340NewRecord(DataSet: TDataSet);
begin
  A036MW.OnNewRecord;
end;

procedure TA036FTurniRepDTM1.selT340BeforePost(DataSet: TDataSet);
begin
  A036MW.BeforePost;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA036FTurniRepDTM1.selT340BeforeDelete(DataSet: TDataSet);
begin
  A036MW.BeforeDelete;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA036FTurniRepDTM1.selT340AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  A036MW.AfterDelete;
end;

procedure TA036FTurniRepDTM1.ValidaOre(Sender: TField);
begin
  A036MW.selT340ValidaOre(Sender);
end;

procedure TA036FTurniRepDTM1.ValidaVoce(Sender: TField);
begin
  A036MW.selT340ValidaVoce(Sender);
end;

end.
