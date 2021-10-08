unit A055UTurnazioniDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali,  Variants, A055UTurnazioniMW;

type
  TA055FTurnazioniDtM1 = class(TDataModule)
    Q640: TOracleDataSet;
    Q640CODICE: TStringField;
    Q640DESCRIZIONE: TStringField;
    procedure A055FTurnazioniDtM1Create(Sender: TObject);
    procedure A055FTurnazioniDtM1Destroy(Sender: TObject);
    procedure Q640AfterPost(DataSet: TDataSet);
    procedure Q640AfterCancel(DataSet: TDataSet);
    procedure Q640AfterDelete(DataSet: TDataSet);
    procedure Q640BeforeInsert(DataSet: TDataSet);
    procedure Q640BeforePost(DataSet: TDataSet);
    procedure Q640BeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    A055MW: TA055FTurnazioniMW;
  end;

var
  A055FTurnazioniDtM1: TA055FTurnazioniDtM1;

implementation

{$R *.DFM}

procedure TA055FTurnazioniDtM1.A055FTurnazioniDtM1Create(Sender: TObject);
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
  A055MW:=TA055FTurnazioniMW.Create(Self);
  A055MW.Q640:=Q640;
  Q640.Open;
end;

procedure TA055FTurnazioniDtM1.A055FTurnazioniDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA055FTurnazioniDtM1.Q640AfterPost(DataSet: TDataSet);
begin
  try
    SessioneOracle.ApplyUpdates([Q640],True);
    SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TA055FTurnazioniDtM1.Q640AfterCancel(DataSet: TDataSet);
begin
  Q640.CancelUpdates;
end;

procedure TA055FTurnazioniDtM1.Q640BeforeDelete(DataSet: TDataSet);
begin
  A055MW.BeforeDelete;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA055FTurnazioniDtM1.Q640AfterDelete(DataSet: TDataSet);
begin
  try
    SessioneOracle.ApplyUpdates([Q640],True);
    SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TA055FTurnazioniDtM1.Q640BeforeInsert(DataSet: TDataSet);
begin
  A055MW.Q641.Close;
end;

procedure TA055FTurnazioniDtM1.Q640BeforePost(DataSet: TDataSet);
{Gestisco il cambiamento di codice turnazione: lo rifletto su T641}
begin
  A055MW.BeforePost;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;


end.
