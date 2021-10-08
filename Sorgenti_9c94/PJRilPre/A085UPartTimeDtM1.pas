unit A085UPartTimeDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   Db, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants;

type
  TA085FPartTimeDtM1 = class(TDataModule)
    Q460: TOracleDataSet;
    Q460CODICE: TStringField;
    Q460DESCRIZIONE: TStringField;
    Q460PIANTA: TFloatField;
    Q460TIPO: TStringField;
    Q460INDPRES: TFloatField;
    Q460INCENTIVI: TFloatField;
    Q460ASSENZEGG: TFloatField;
    Q460ASSENZEHH: TFloatField;
    Q460INDFEST: TFloatField;
    Q460DESCRIZIONE_ESTESA: TStringField;
    Q460DEBITO_AGG: TFloatField;
    Q460HHGIORNALIERE: TFloatField;
    procedure A076FIndGruppoDtM1Create(Sender: TObject);
    procedure Q460AfterCancel(DataSet: TDataSet);
    procedure Q460AfterDelete(DataSet: TDataSet);
    procedure Q460AfterPost(DataSet: TDataSet);
    procedure Q460NewRecord(DataSet: TDataSet);
    procedure A085FPartTimeDtM1Destroy(Sender: TObject);
    procedure Q460BeforePost(DataSet: TDataSet);
    procedure Q460BeforeDelete(DataSet: TDataSet);
    procedure Q460PIANTAValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A085FPartTimeDtM1: TA085FPartTimeDtM1;

implementation

uses A085UPartTime;

{$R *.DFM}

procedure TA085FPartTimeDtM1.A076FIndGruppoDtM1Create(Sender: TObject);
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
  Q460.Open;
end;

procedure TA085FPartTimeDtM1.Q460AfterCancel(DataSet: TDataSet);
begin
  Q460.CancelUpdates;
end;

procedure TA085FPartTimeDtM1.Q460AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([Q460],True);
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
end;

procedure TA085FPartTimeDtM1.Q460AfterPost(DataSet: TDataSet);
var S:String;
begin
  S:=Q460.FieldByName('CODICE').AsString;
  SessioneOracle.ApplyUpdates([Q460],True);
  RegistraLog.RegistraOperazione;
  Q460.Close;
  Q460.Open;
  Q460.Locate('Codice',S,[]);
end;

procedure TA085FPartTimeDtM1.Q460NewRecord(DataSet: TDataSet);
begin
  Q460.FieldByName('TIPO').AsString:='O';
end;

procedure TA085FPartTimeDtM1.A085FPartTimeDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA085FPartTimeDtM1.Q460BeforePost(DataSet: TDataSet);
begin
  if QueryPK1.EsisteChiave('T460_PARTTIME',Q460.RowId,Q460.State,['CODICE'],[Q460Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA085FPartTimeDtM1.Q460BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA085FPartTimeDtM1.Q460PIANTAValidate(Sender: TField);
begin
  if Q460PIANTA.IsNull then
    exit;
  if Q460INDPRES.IsNull then
    if Q460TIPO.AsString = 'O' then
      Q460INDPRES.AsFloat:=Q460PIANTA.AsFloat
    else
      Q460INDPRES.AsInteger:=100;
  if Q460INDFEST.IsNull then
    if Q460TIPO.AsString = 'O' then
      Q460INDFEST.AsFloat:=Q460PIANTA.AsFloat
    else
      Q460INDFEST.AsInteger:=100;
  if Q460INCENTIVI.IsNull then
    Q460INCENTIVI.AsFloat:=Q460PIANTA.AsFloat;
  if Q460ASSENZEGG.IsNull then
    Q460ASSENZEGG.AsFloat:=Q460PIANTA.AsFloat;
  if Q460ASSENZEHH.IsNull then
    Q460ASSENZEHH.AsFloat:=Q460PIANTA.AsFloat;
end;

end.
