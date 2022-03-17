unit A054UCicliTurniDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  A000UCostanti, A000USessione,A000UInterfaccia, A054UCicliTurniMW, Db, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali,  Variants;

type
  TA054FCicliTurniDtM1 = class(TDataModule)
    Q610: TOracleDataSet;
    Q610CODICE: TStringField;
    Q610DESCRIZIONE: TStringField;
    procedure A054FCicliTurniDtM1Create(Sender: TObject);
    procedure A054FCicliTurniDtM1Destroy(Sender: TObject);
    procedure Q610AfterCancel(DataSet: TDataSet);
    procedure Q610AfterDelete(DataSet: TDataSet);
    procedure Q610AfterPost(DataSet: TDataSet);
    procedure Q610BeforeInsert(DataSet: TDataSet);
    procedure Q610BeforePost(DataSet: TDataSet);
    procedure Q610BeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    A054MW: TA054FCicliTurniMW;
  end;

var
  A054FCicliTurniDtM1: TA054FCicliTurniDtM1;

implementation

uses A054UCicliTurni;

{$R *.DFM}

procedure TA054FCicliTurniDtM1.A054FCicliTurniDtM1Create(Sender: TObject);
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
  A054MW:=TA054FCicliTurniMW.Create(Self);
  A054MW.Q610:=Q610;
  Q610.Open;
end;

procedure TA054FCicliTurniDtM1.A054FCicliTurniDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA054FCicliTurniDtM1.Q610AfterCancel(DataSet: TDataSet);
begin
  Q610.CancelUpdates;
end;

procedure TA054FCicliTurniDtM1.Q610BeforeDelete(DataSet: TDataSet);
begin
  A054MW.BeforeDelete;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA054FCicliTurniDtM1.Q610AfterDelete(DataSet: TDataSet);
begin
  try
    SessioneOracle.ApplyUpdates([Q610],True);
    SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TA054FCicliTurniDtM1.Q610AfterPost(DataSet: TDataSet);
begin
  try
    SessioneOracle.ApplyUpdates([Q610],True);
    SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TA054FCicliTurniDtM1.Q610BeforeInsert(DataSet: TDataSet);
begin
  A054MW.BeforeInsert;
end;

procedure TA054FCicliTurniDtM1.Q610BeforePost(DataSet: TDataSet);
begin
  A054MW.BeforePost;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

end.
