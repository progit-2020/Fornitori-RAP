unit A017URaggrAsseDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  Variants;

type
  TA017FRaggrAsseDtM1 = class(TDataModule)
    T260: TOracleDataSet;
    T260Codice: TStringField;
    T260Descrizione: TStringField;
    T260CodInterno: TStringField;
    T260ContASolare: TStringField;
    T260Residuabile: TStringField;
    T260MAXRESIDUO: TStringField;
    T260RAGGRUPPAMENTO_RESIDUO: TStringField;
    selT260: TOracleDataSet;
    dsrT260: TDataSource;
    T260RAGGR_RESIDUO_PREC: TStringField;
    T260CUMULA_RAGGR_BASE: TStringField;
    selTipiResiduiAC: TOracleDataSet;
    dsrTipiResiduiAC: TDataSource;
    T260MAXRESIDUO_CORR: TStringField;
    T260MAXRESIDUO_PREC: TStringField;
    procedure T260NewRecord(DataSet: TDataSet);
    procedure A017FRaggrAsseDtM1Create(Sender: TObject);
    procedure A017FRaggrAsseDtM1Destroy(Sender: TObject);
    procedure T260BeforeDelete(DataSet: TDataSet);
    procedure T260BeforePost(DataSet: TDataSet);
    procedure T260AfterPost(DataSet: TDataSet);
    procedure T260AfterDelete(DataSet: TDataSet);
    procedure T260FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    VecchioCodiceDizionario:String;
  public
    { Public declarations }
  end;

var
  A017FRaggrAsseDtM1: TA017FRaggrAsseDtM1;

implementation

uses A017URaggrAsse;

{$R *.DFM}

procedure TA017FRaggrAsseDtM1.A017FRaggrAsseDtM1Create(Sender: TObject);
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
  T260.Open;
  selT260.Open;
  selTipiResiduiAC.Open;
end;

procedure TA017FRaggrAsseDtM1.T260NewRecord(DataSet: TDataSet);
{Inizializzo a N il Cont. Anno solare e Residuabile}
begin
  T260.FieldByName('ContASolare').AsString:='N';
  T260.FieldByName('Residuabile').AsString:='N';
  T260.FieldByName('CodInterno').AsString:='Z';
end;

procedure TA017FRaggrAsseDtM1.A017FRaggrAsseDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA017FRaggrAsseDtM1.T260BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C','T260_RAGGRASSENZE',Copy(Name,1,4),T260,True);
  A000AggiornaFiltroDizionario('RAGGRUPPAMENTI ASSENZA',DataSet.FieldByName('CODICE').AsString,'');
end;

procedure TA017FRaggrAsseDtM1.T260BeforePost(DataSet: TDataSet);
begin
  if DataSet.State = dsEdit then
    VecchioCodiceDizionario:=VarToStr(DataSet.FieldByName('CODICE').medpOldValue)
  else
    VecchioCodiceDizionario:='';
  if QueryPK1.EsisteChiave('T260_RAGGRASSENZE',T260.RowId,T260.State,['CODICE'],[T260Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','T260_RAGGRASSENZE',Copy(Name,1,4),T260,True);
    dsEdit:RegistraLog.SettaProprieta('M','T260_RAGGRASSENZE',Copy(Name,1,4),T260,True);
  end;
end;

procedure TA017FRaggrAsseDtM1.T260AfterPost(DataSet: TDataSet);
var S:String;
begin
  RegistraLog.RegistraOperazione;
  with T260 do
  begin
    S:=FieldByName('CODICE').AsString;
    A000AggiornaFiltroDizionario('RAGGRUPPAMENTI ASSENZA',VecchioCodiceDizionario,S);
    DisableControls;
    Refresh;
    EnableControls;
    Locate('Codice',S,[]);
  end;
  selT260.Refresh;
end;

procedure TA017FRaggrAsseDtM1.T260AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  selT260.Refresh;
end;

procedure TA017FRaggrAsseDtM1.T260FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('RAGGRUPPAMENTI ASSENZA',DataSet.FieldByName('CODICE').AsString);
end;

end.
