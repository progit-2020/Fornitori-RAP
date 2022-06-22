unit A053USquadreDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali,  Variants;

type
  TA053FSquadreDtM1 = class(TDataModule)
    D601: TDataSource;
    Q600: TOracleDataSet;
    Q600CODICE: TStringField;
    Q600DESCRIZIONE: TStringField;
    Q600DESCRIZIONELUNGA: TStringField;
    Q601: TOracleDataSet;
    Q640: TOracleDataSet;
    Q601AggiornaSquadra: TOracleQuery;
    Q601CancellaSquadra: TOracleQuery;
    Q601SQUADRA: TStringField;
    Q601CODICE: TStringField;
    Q601TURNAZ: TStringField;
    Q601ORARIO: TStringField;
    Q601OTTIMALE1FR: TIntegerField;
    Q601OTTIMALE1FS: TIntegerField;
    Q601OTTIMALE2FR: TIntegerField;
    Q601OTTIMALE2FS: TIntegerField;
    Q601OTTIMALE3FR: TIntegerField;
    Q601OTTIMALE3FS: TIntegerField;
    Q601PROFILO: TStringField;
    Q602: TOracleDataSet;
    Q600FESMIN1: TIntegerField;
    Q600FESMIN2: TIntegerField;
    Q600FESMIN3: TIntegerField;
    Q600FESMIN4: TIntegerField;
    Q600FESMAX1: TIntegerField;
    Q600FESMAX2: TIntegerField;
    Q600FESMAX3: TIntegerField;
    Q600FESMAX4: TIntegerField;
    Q600TOTMIN1: TIntegerField;
    Q600TOTMAX1: TIntegerField;
    Q600TOTMIN2: TIntegerField;
    Q600TOTMAX2: TIntegerField;
    Q600TOTMIN3: TIntegerField;
    Q600TOTMAX3: TIntegerField;
    Q600TOTMIN4: TIntegerField;
    Q600TOTMAX4: TIntegerField;
    Q601MIN1: TIntegerField;
    Q601MAX1: TIntegerField;
    Q601MIN2: TIntegerField;
    Q601MAX2: TIntegerField;
    Q601MIN3: TIntegerField;
    Q601MAX3: TIntegerField;
    Q601MIN4: TIntegerField;
    Q601MAX4: TIntegerField;
    Q601FESMIN1: TIntegerField;
    Q601FESMAX1: TIntegerField;
    Q601FESMIN2: TIntegerField;
    Q601FESMAX2: TIntegerField;
    Q601FESMIN3: TIntegerField;
    Q601FESMAX3: TIntegerField;
    Q601FESMIN4: TIntegerField;
    Q601FESMAX4: TIntegerField;
    selT265: TOracleDataSet;
    DT265: TDataSource;
    Q600CAUS_RIPOSO: TStringField;
    Q600MIN_IND1: TIntegerField;
    Q600MIN_IND2: TIntegerField;
    Q600MIN_IND3: TIntegerField;
    Q600MIN_IND4: TIntegerField;
    Q600MIN_FESTIVITA_MESE: TIntegerField;
    Q600PERIODO_MATUR_IND: TIntegerField;
    Q600PRIORITA_MINMAX: TStringField;
    procedure A053FSquadreDtM1Create(Sender: TObject);
    procedure A053FSquadreDtM1Destroy(Sender: TObject);
    procedure Q600AfterPost(DataSet: TDataSet);
    procedure Q600AfterCancel(DataSet: TDataSet);
    procedure Q601NewRecord(DataSet: TDataSet);
    procedure Q600AfterDelete(DataSet: TDataSet);
    procedure Q600BeforeInsert(DataSet: TDataSet);
    procedure Q600BeforePost(DataSet: TDataSet);
    procedure BDEQ601TURNAZValidate(Sender: TField);
    procedure Q600BeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A053FSquadreDtM1: TA053FSquadreDtM1;

implementation

{$R *.DFM}

procedure TA053FSquadreDtM1.A053FSquadreDtM1Create(Sender: TObject);
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
  Q600.Open;
  Q640.Open;
  Q602.Open;  
end;

procedure TA053FSquadreDtM1.Q600AfterPost(DataSet: TDataSet);
begin
  try
    SessioneOracle.ApplyUpdates([Q600],True);
    SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TA053FSquadreDtM1.Q600AfterCancel(DataSet: TDataSet);
begin
  Q600.CancelUpdates;
end;

procedure TA053FSquadreDtM1.Q601NewRecord(DataSet: TDataSet);
begin
  Q601Squadra.AsString:=Q600Codice.AsString;
end;

procedure TA053FSquadreDtM1.Q600BeforeDelete(DataSet: TDataSet);
begin
  with Q601CancellaSquadra do
    begin
    SetVariable('Squadra',Q600Codice.AsString);
    Execute;
    end;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA053FSquadreDtM1.Q600AfterDelete(DataSet: TDataSet);
begin
  try
    SessioneOracle.ApplyUpdates([Q600],True);
    SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TA053FSquadreDtM1.BDEQ601TURNAZValidate(Sender: TField);
{Controllo sul campo Turnazione}
begin
  if Sender.IsNull then exit;
  if Q640.Lookup('Codice',Sender.AsString,'Codice') = Null then
    raise Exception.Create('Turnazione non valida!');
end;

procedure TA053FSquadreDtM1.Q600BeforeInsert(DataSet: TDataSet);
begin
  Q601.Close;
end;

procedure TA053FSquadreDtM1.Q600BeforePost(DataSet: TDataSet);
var i:Integer;
    TempStr:String;
{Gestisco il cambiamento di codice squadra: lo rifletto sui tipi operatore}
begin
  if (QueryPK1.EsisteChiave('T600_SQUADRE',Q600.RowId,Q600.State,['CODICE'],[Q600Codice.AsString])) then
    raise Exception.Create('Codice già esistente!');
  if Q600.State = dsEdit then
    if Q600Codice.Value <> Q600Codice.medpOldValue then
      with Q601AggiornaSquadra do
        begin
        SetVariable('Squadra',Q600Codice.Value);
        SetVariable('Squadra_Old',Q600Codice.medpOldValue);
        try
          Execute;
        except
          SessioneOracle.Rollback;
          raise;
        end;
        end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
  //=====================================================================
  //COTROLLO CHE IL CAMPO "PRIORITA_MINMAX" SIA VALORIZZATO CORRETTAMENTE
  //=====================================================================
  TempStr:=Copy(Q600.FieldByName('PRIORITA_MINMAX').AsString,1,4);
  i:=1;
  While i <= Length(TempStr) do
  begin
    if (Copy(TempStr,i,1) <> '1') and (Copy(TempStr,i,1) <> '2') and
       (Copy(TempStr,i,1) <> '3') and (Copy(TempStr,i,1) <> '4') then
    begin
      TempStr:=StringReplace(TempStr,Copy(TempStr,i,1),'',[rfReplaceAll]);
      i:=0;
    end;
    Inc(i);
  end;
  i:=1;
  repeat
    if Pos(IntToStr(i),TempStr) <= 0 then
      TempStr:=TempStr + IntToStr(i);
    Inc(i);
  until Length(TempStr) >= 4 ;
  Q600.FieldByName('PRIORITA_MINMAX').AsString:=TempStr;
end;

procedure TA053FSquadreDtM1.A053FSquadreDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

end.
