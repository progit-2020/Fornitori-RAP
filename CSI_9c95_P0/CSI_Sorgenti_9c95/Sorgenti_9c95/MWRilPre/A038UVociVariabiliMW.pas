unit A038UVociVariabiliMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData,A000UInterfaccia,C180FunzioniGenerali,
  A000UCostanti, A000USessione;

type
  TA038FVociVariabiliMW = class(TR005FDataModuleMW)
    VociPaghe: TOracleDataSet;
    selT195Cassa: TOracleDataSet;
    selT195: TOracleDataSet;
    selT195MATRICOLA: TStringField;
    selT195NOMINATIVO: TStringField;
    selT195PROGRESSIVO: TFloatField;
    selT195DATARIF: TDateTimeField;
    selT195VOCEPAGHE: TStringField;
    selT195VALORE: TFloatField;
    selT195IMPORTO: TFloatField;
    selT195UM: TStringField;
    selT195COD_INTERNO: TStringField;
    selT195D_CODICE: TStringField;
    selT195DATA_CASSA: TDateTimeField;
    selT195DAL: TDateTimeField;
    selT195AL: TDateTimeField;
    selT195OPERAZIONE: TStringField;
    dsrT195: TDataSource;
    procedure selT195AfterPost(DataSet: TDataSet);
    procedure selT195BeforeDelete(DataSet: TDataSet);
    procedure selT195BeforeInsert(DataSet: TDataSet);
    procedure selT195BeforePost(DataSet: TDataSet);
    procedure selT195CalcFields(DataSet: TDataSet);
    procedure selT195FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT195VALOREGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure dsrT195StateChange(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure selT195AfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    OnFilterRecord : TOnFilterRecord;
    OnStateChange: TprocObject;
    procedure CodInternoGetText(Sender: TField; var Text: String; DisplayText: Boolean);end;
implementation

{$R *.dfm}

procedure TA038FVociVariabiliMW.CodInternoGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
var i:Integer;
begin
  Text:=Sender.AsString;
  for i:=1 to High(VettConst) do
    if Sender.AsString = VettConst[i].CodInt then
    begin
      Text:=Text + ' ' + VettConst[i].Descrizione;
      Break;
    end;
end;

procedure TA038FVociVariabiliMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT195.ClearVariables;
  selT195.SetVariable('QVISTAORACLE',StringReplace(QVistaOracle,':DataLavoro','LAST_DAY(T195.DATARIF)',[rfReplaceAll, rfIgnoreCase]));
  if Trim(Parametri.Inibizioni.Text) <> '' then
    selT195.SetVariable('Filtro_Anagrafe','AND ' + StringReplace(Parametri.Inibizioni.Text,':DataLavoro','LAST_DAY(T195.DATARIF)',[rfReplaceAll, rfIgnoreCase]));
  selT195.SetVariable('ORDERBY','ORDER BY COGNOME,MATRICOLA,DATARIF,VOCEPAGHE,DATA_CASSA');
end;

procedure TA038FVociVariabiliMW.dsrT195StateChange(Sender: TObject);
begin
  inherited;
  if Assigned(OnStateChange) then
    OnStateChange(Sender);
end;

procedure TA038FVociVariabiliMW.selT195AfterDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TA038FVociVariabiliMW.selT195AfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TA038FVociVariabiliMW.selT195BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TA038FVociVariabiliMW.selT195BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TA038FVociVariabiliMW.selT195BeforePost(DataSet: TDataSet);
begin
  inherited;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  end;
end;

procedure TA038FVociVariabiliMW.selT195CalcFields(DataSet: TDataSet);
var
  i: Integer;
begin
  inherited;
  selT195.FieldByName('D_CODICE').AsString:='';
  for i:=1 to High(VettConst) do
    if selT195.FieldByName('COD_INTERNO').AsString = VettConst[i].CodInt then
    begin
      selT195.FieldByName('D_CODICE').AsString:=VettConst[i].Descrizione;
      Break;
    end;
end;

procedure TA038FVociVariabiliMW.selT195FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  if Assigned (OnFilterRecord) then
    OnFilterRecord(Dataset,Accept);
end;

procedure TA038FVociVariabiliMW.selT195VALOREGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text:=Sender.AsString;
  if Sender.DataSet.FieldByName('UM').AsString = 'H' then
    Text:=R180MinutiOre(Sender.AsInteger);
end;
end.
