unit A084UTipoRapportoDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   Db, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FUnzioniGenerali,  Variants;

type
  TA084FTipoRapportoDtM1 = class(TDataModule)
    Q450: TOracleDataSet;
    procedure A076FIndGruppoDtM1Create(Sender: TObject);
    procedure Q450AfterCancel(DataSet: TDataSet);
    procedure Q450AfterDelete(DataSet: TDataSet);
    procedure Q450AfterPost(DataSet: TDataSet);
    procedure Q450NewRecord(DataSet: TDataSet);
    procedure A084FTipoRapportoDtM1Destroy(Sender: TObject);
    procedure Q450BeforePost(DataSet: TDataSet);
    procedure Q450BeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A084FTipoRapportoDtM1: TA084FTipoRapportoDtM1;

implementation

uses A084UTipoRapporto;

{$R *.DFM}

procedure TA084FTipoRapportoDtM1.A076FIndGruppoDtM1Create(Sender: TObject);
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
  Q450.Open;
end;

procedure TA084FTipoRapportoDtM1.Q450AfterCancel(DataSet: TDataSet);
begin
  Q450.CancelUpdates;
end;

procedure TA084FTipoRapportoDtM1.Q450AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([Q450],True);
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
end;

procedure TA084FTipoRapportoDtM1.Q450AfterPost(DataSet: TDataSet);
var S:String;
begin
  S:=Q450.FieldByName('CODICE').AsString;
  SessioneOracle.ApplyUpdates([Q450],True);
  RegistraLog.RegistraOperazione;
  Q450.Close;
  Q450.Open;
  Q450.Locate('Codice',S,[]);
end;

procedure TA084FTipoRapportoDtM1.Q450NewRecord(DataSet: TDataSet);
begin
  Q450.FieldByName('TIPO').AsString:='R';
end;

procedure TA084FTipoRapportoDtM1.A084FTipoRapportoDtM1Destroy(
  Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA084FTipoRapportoDtM1.Q450BeforePost(DataSet: TDataSet);
begin
  if QueryPK1.EsisteChiave('T450_TIPORAPPORTO',Q450.RowId,Q450.State,['CODICE'],[Q450.FieldByName('Codice').AsString]) then
    raise Exception.Create('Codice già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA084FTipoRapportoDtM1.Q450BeforeDelete(DataSet: TDataSet);
begin 
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

end.
