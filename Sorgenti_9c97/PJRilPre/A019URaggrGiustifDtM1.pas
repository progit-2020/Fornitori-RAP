unit A019URaggrGiustifDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  Variants;

type
  TA019FRaggrGiustifDtM1 = class(TDataModule)
    T300: TOracleDataSet;
    T300Codice: TStringField;
    T300Descrizione: TStringField;
    T300CodInterno: TStringField;
    procedure T300NewRecord(DataSet: TDataSet);
    procedure A019FRaggrGiustifDtM1Create(Sender: TObject);
    procedure A019FRaggrGiustifDtM1Destroy(Sender: TObject);
    procedure T300BeforePost(DataSet: TDataSet);
    procedure T300BeforeDelete(DataSet: TDataSet);
    procedure T300AfterPost(DataSet: TDataSet);
    procedure T300AfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A019FRaggrGiustifDtM1: TA019FRaggrGiustifDtM1;

implementation

uses A019URaggrGiustif;

{$R *.DFM}

procedure TA019FRaggrGiustifDtM1.A019FRaggrGiustifDtM1Create(
  Sender: TObject);
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
  T300.Open;
end;

procedure TA019FRaggrGiustifDtM1.T300NewRecord(DataSet: TDataSet);
begin
  T300.FieldByName('CodInterno').AsString:='Z';
end;

procedure TA019FRaggrGiustifDtM1.A019FRaggrGiustifDtM1Destroy(
  Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA019FRaggrGiustifDtM1.T300BeforePost(DataSet: TDataSet);
begin
  if QueryPK1.EsisteChiave('T300_RAGGRGIUSTIF',T300.RowId,T300.State,['CODICE'],[T300Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','T300_RAGGRGIUSTIF',Copy(Name,1,4),T300,True);
    dsEdit:RegistraLog.SettaProprieta('M','T300_RAGGRGIUSTIF',Copy(Name,1,4),T300,True);
  end;
end;

procedure TA019FRaggrGiustifDtM1.T300BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C','T300_RAGGRGIUSTIF',Copy(Name,1,4),T300,True);
end;

procedure TA019FRaggrGiustifDtM1.T300AfterPost(DataSet: TDataSet);
var S:String;
begin
  RegistraLog.RegistraOperazione;
  with DataSet do
    begin
    S:=FieldByName('CODICE').AsString;
    DisableControls;
    Refresh;
    Locate('CODICE',S,[]);
    EnableControls;
    end;
end;

procedure TA019FRaggrGiustifDtM1.T300AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

end.
