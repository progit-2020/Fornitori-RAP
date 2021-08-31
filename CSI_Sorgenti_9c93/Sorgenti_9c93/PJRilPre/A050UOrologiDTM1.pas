unit A050UOrologiDTM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali,  Variants,A000UMessaggi;

type
  TA050FOrologiDtM1 = class(TDataModule)
    D305: TDataSource;
    Q361: TOracleDataSet;
    Q361CODICE: TStringField;
    Q361DESCRIZIONE: TStringField;
    Q361FUNZIONE: TStringField;
    Q361CAUSMENSA: TStringField;
    Q305: TOracleDataSet;
    Q361VERSO: TStringField;
    Q361POSTAZIONE: TStringField;
    Q361INDIRIZZO_TERMINALE: TStringField;
    Q361INDIRIZZO_IP: TStringField;
    Q361RICEZIONE_MESSAG: TStringField;
    Q361APPLICA_PERCORRENZA_PM: TStringField;
    Q361TIPO_LOCALITA: TStringField;
    Q361COD_LOCALITA: TStringField;
    Q361INDIRIZZO: TStringField;
    SelLocalita: TOracleDataSet;
    DSelLocalita: TDataSource;
    Q361D_LOCALITA: TStringField;
    Q361SCARICO: TStringField;
    Q361RILEVATORE: TStringField;
    dsrI100: TDataSource;
    selI100: TOracleDataSet;
    ControlloRilev: TOracleQuery;
    procedure Q361AfterScroll(DataSet: TDataSet);
    procedure A050FOrologiDtM1Create(Sender: TObject);
    procedure A050FOrologiDtM1Destroy(Sender: TObject);
    procedure Q361AfterPost(DataSet: TDataSet);
    procedure Q361AfterCancel(DataSet: TDataSet);
    procedure Q361AfterDelete(DataSet: TDataSet);
    procedure Q361NewRecord(DataSet: TDataSet);
    procedure Q361BeforePost(DataSet: TDataSet);
    procedure Q361BeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A050FOrologiDtM1: TA050FOrologiDtM1;

implementation
uses A050UOrologi;
{$R *.DFM}


//------------------------------------------------------------------------------
procedure TA050FOrologiDtM1.A050FOrologiDtM1Create(Sender: TObject);
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
  A050FOrologi.DButton.DataSet:=Q361;
  selLocalita.Open;
  Q305.Open;
  selI100.Open;
  Q361.Open;
end;

//------------------------------------------------------------------------------
procedure TA050FOrologiDtM1.A050FOrologiDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

//------------------------------------------------------------------------------
procedure TA050FOrologiDtM1.Q361AfterPost(DataSet: TDataSet);
var S:String;
begin
  S:=Q361.FieldByName('Codice').AsString;
  SessioneOracle.ApplyUpdates([Q361],True);
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
  Q361.Close;
  Q361.Open;
  Q361.Locate('Codice',S,[]);
end;

//------------------------------------------------------------------------------
procedure TA050FOrologiDtM1.Q361AfterCancel(DataSet: TDataSet);
begin
  Q361.CancelUpdates;
end;

//------------------------------------------------------------------------------
procedure TA050FOrologiDtM1.Q361AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([Q361],True);
  RegistraLog.RegistraOperazione;
end;

//------------------------------------------------------------------------------
procedure TA050FOrologiDtM1.Q361NewRecord(DataSet: TDataSet);
begin
  Q361Funzione.Value := 'P';
end;

procedure TA050FOrologiDtM1.Q361BeforePost(DataSet: TDataSet);
begin
  if  (Q361.FieldByName('COD_LOCALITA').AsString <> '')
  and (Q361.FieldByName('TIPO_LOCALITA').IsNull) then
  begin
    ShowMessage('Selezionare prima il tipo della località!');
    Abort;
  end;
  if QueryPK1.EsisteChiave('T361_OROLOGI',Q361.RowId,Q361.State,['CODICE'],[Q361Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  if (not Q361.FieldByName('RILEVATORE').IsNull) and (Trim(Q361.FieldByName('RILEVATORE').AsString) <> '') then
  begin //Verifico se esiste un altro orologio con lo stesso rilevatore
    ControlloRilev.SetVariable('CODICE',Q361.FieldByName('CODICE').AsString);
    ControlloRilev.SetVariable('RILEV',Q361.FieldByName('RILEVATORE').AsString);
    ControlloRilev.Execute;
    if ControlloRilev.RowsProcessed > 0 then
    begin
      if (VarToStr(ControlloRilev.Field(0)) = '') or (VarToStr(ControlloRilev.Field(0)) = Q361.FieldByName('SCARICO').AsString) then
      begin
        A050FOrologi.dedtRilevatore.SetFocus;
        raise exception.Create(Format(A000MSG_A050_ERR_FMT_OROLOGIO_DUPL,[VarToStr(ControlloRilev.Field(1))]));
      end;
      if (VarToStr(ControlloRilev.Field(0)) <> '') and (Q361.FieldByName('SCARICO').IsNull or (Q361.FieldByName('SCARICO').AsString = '')) then
      begin
        A050FOrologi.dcmbScarico.SetFocus;

        raise exception.Create(Format(A000MSG_A050_ERR_FMT_SCARICO,[VarToStr(ControlloRilev.Field(1)),VarToStr(ControlloRilev.Field(0))]));
      end;
    end;
  end
  else
    Q361.FieldByName('SCARICO').AsString:='';  //se il rilev. è nullo pulisco lo scarico
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA050FOrologiDtM1.Q361BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA050FOrologiDtM1.Q361AfterScroll(DataSet: TDataSet);
begin
  A050FOrologi.DBEDescr.Hint:=Q361.FieldByName('DESCRIZIONE').AsString;
end;

end.
