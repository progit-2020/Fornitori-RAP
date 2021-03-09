unit A125UBadgeServizioDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe,
  RegistrazioneLog, OracleData, Oracle, QueryStorico,
  A003UDataLavoroBis, Variants, A125UBadgeServizioMW;

type
  TA125FBadgeServizioDtM = class(TDataModule)
    Q435: TOracleDataSet;
    Q435PROGRESSIVO: TIntegerField;
    Q435DECORRENZA: TDateTimeField;
    Q435SCADENZA: TDateTimeField;
    Q435BADGESERV: TFloatField;
    procedure Q435NewRecord(DataSet: TDataSet);
    procedure Q435AfterPost(DataSet: TDataSet);
    procedure Q435BeforePost(DataSet: TDataSet);
    procedure Q435BeforeDelete(DataSet: TDataSet);
    procedure Q435AfterDelete(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    A125MW:TA125FBadgeServizioMW;
  public
    { Public declarations }
    procedure SettaProgressivo;
  end;

var
  A125FBadgeServizioDtM: TA125FBadgeServizioDtM;
  Anno,Mese,Giorno:Word;

implementation

uses A125UBadgeServizio;

{$R *.DFM}

procedure TA125FBadgeServizioDtM.SettaProgressivo;
begin
  Q435.Close;
  Q435.SetVariable('Progressivo',C700Progressivo);
  Q435.Open;
end;

procedure TA125FBadgeServizioDtM.DataModuleCreate(Sender: TObject);
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
  A125MW:=TA125FBadgeServizioMW.Create(Self);
  A125MW.Q435:=Q435;
  A125FBadgeServizio.DButton.DataSet:=Q435;
  SettaProgressivo;
end;

procedure TA125FBadgeServizioDtM.Q435NewRecord(DataSet: TDataSet);
{Impostazioni nuovo record}
begin
  Q435.FieldByName('PROGRESSIVO').AsInteger:=C700Progressivo;
end;

procedure TA125FBadgeServizioDtM.Q435AfterPost(DataSet: TDataSet);
{Scarico le modifiche nella cache sul database}
begin
  try
    SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
  except
    on e: exception do
    begin
      SessioneOracle.RollBack;
      raise Exception.Create('Registrazione fallita!' +
      #$A#$D + e.Message);
    end;
  end;
  A125MW.Q435AfterPost;
end;

procedure TA125FBadgeServizioDtM.Q435BeforePost(DataSet: TDataSet);
begin
  A125MW.Q435BeforePost;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA125FBadgeServizioDtM.Q435BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA125FBadgeServizioDtM.Q435AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA125FBadgeServizioDtM.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

end.
