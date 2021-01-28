unit A005UTabelleDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants;

type
  TA005FTabelleDtM1 = class(TDataModule)
    Q500: TOracleDataSet;
    Tabella: TOracleDataSet;
    procedure A005FTabelleDtM1Create(Sender: TObject);
    procedure A005FTabelleDtM1Destroy(Sender: TObject);
    procedure BDETabellaAfterPost(DataSet: TDataSet);
    procedure BDETabellaBeforePost(DataSet: TDataSet);
    procedure BDETabellaAfterDelete(DataSet: TDataSet);
    procedure BDETabellaBeforeDelete(DataSet: TDataSet);
    procedure TabellaAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A005FTabelleDtM1: TA005FTabelleDtM1;

implementation

uses A005UTabelle;

{$R *.DFM}

procedure TA005FTabelleDtM1.A005FTabelleDtM1Create(Sender: TObject);
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
end;

procedure TA005FTabelleDtM1.A005FTabelleDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA005FTabelleDtM1.BDETabellaBeforePost(DataSet: TDataSet);
begin
  if QueryPK1.EsisteChiave(A005FTabelle.TabelleDatiLiberi[A005FTabelle.TabControl1.TabIndex].NomeTabelle,Tabella.RowID,Tabella.State,['CODICE'],[Tabella.FieldByName('CODICE').AsString]) then
    raise Exception.Create('Codice già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180EstraiNomeTabella(Tabella.SQL.Text),Copy(Name,1,4),Tabella,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180EstraiNomeTabella(Tabella.SQL.Text),Copy(Name,1,4),Tabella,True);
  end;
end;

procedure TA005FTabelleDtM1.BDETabellaAfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;


procedure TA005FTabelleDtM1.BDETabellaBeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180EstraiNomeTabella(Tabella.SQL.Text),Copy(Name,1,4),Tabella,True);
end;

procedure TA005FTabelleDtM1.BDETabellaAfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA005FTabelleDtM1.TabellaAfterOpen(DataSet: TDataSet);
begin
  if DataSet.FindField('DEBITOGGQM') <> nil then
    TStringField(DataSet.FieldByName('DEBITOGGQM')).EditMask:='!90:00;1;_';
end;

end.
