unit A018URaggrPresDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  Variants;

type
  TA018FRaggrPresDtM1 = class(TDataModule)
    T270: TOracleDataSet;
    T270Codice: TStringField;
    T270Descrizione: TStringField;
    T270CodInterno: TStringField;
    T270IndNotturna: TStringField;
    T270IndFestiva: TStringField;
    T270INDPRESENZA: TStringField;
    procedure A018FRaggrPresDtM1Create(Sender: TObject);
    procedure A018FRaggrPresDtM1Destroy(Sender: TObject);
    procedure T270BeforeDelete(DataSet: TDataSet);
    procedure T270BeforePost(DataSet: TDataSet);
    procedure T270AfterPost(DataSet: TDataSet);
    procedure T270AfterDelete(DataSet: TDataSet);
    procedure T270FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    VecchioCodiceDizionario:String;
  public
    { Public declarations }
  end;

var
  A018FRaggrPresDtM1: TA018FRaggrPresDtM1;

implementation

uses A018URaggrPres;

{$R *.DFM}

procedure TA018FRaggrPresDtM1.A018FRaggrPresDtM1Create(Sender: TObject);
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
  T270.Open;
end;

procedure TA018FRaggrPresDtM1.A018FRaggrPresDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA018FRaggrPresDtM1.T270BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C','T270_RAGGRPRESENZE',Copy(Name,1,4),T270,True);
  A000AggiornaFiltroDizionario('RAGGRUPPAMENTI PRESENZA',DataSet.FieldByName('CODICE').AsString,'');
end;

procedure TA018FRaggrPresDtM1.T270BeforePost(DataSet: TDataSet);
begin
  if DataSet.State = dsEdit then
    VecchioCodiceDizionario:=VarToStr(DataSet.FieldByName('CODICE').medpOldValue)
  else
    VecchioCodiceDizionario:='';
  if QueryPK1.EsisteChiave('T270_RAGGRPRESENZE',T270.RowId,T270.State,['CODICE'],[T270Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','T270_RAGGRPRESENZE',Copy(Name,1,4),T270,True);
    dsEdit:RegistraLog.SettaProprieta('M','T270_RAGGRPRESENZE',Copy(Name,1,4),T270,True);
  end;
end;

procedure TA018FRaggrPresDtM1.T270AfterPost(DataSet: TDataSet);
var S:String;
begin
  RegistraLog.RegistraOperazione;
  with DataSet do
  begin
    S:=FieldByName('CODICE').AsString;
    A000AggiornaFiltroDizionario('RAGGRUPPAMENTI PRESENZA',VecchioCodiceDizionario,S);
    DisableControls;
    Refresh;
    Locate('CODICE',S,[]);
    EnableControls;
  end;
end;

procedure TA018FRaggrPresDtM1.T270AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA018FRaggrPresDtM1.T270FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('RAGGRUPPAMENTI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

end.
