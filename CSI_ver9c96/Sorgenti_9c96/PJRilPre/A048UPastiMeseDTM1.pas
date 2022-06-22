unit A048UPastiMeseDTM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia,C700USelezioneAnagrafe, RegistrazioneLog,
  OracleData, Oracle, C180FunzioniGenerali, Variants,
  DatiBloccati;

type
  TA048FPastiMeseDtM1 = class(TDataModule)
    Q410: TOracleDataSet;
    Q410PROGRESSIVO: TFloatField;
    Q410ANNO: TFloatField;
    Q410MESE: TFloatField;
    Q410CALCMESE: TStringField;
    Q410PASTI: TFloatField;
    Q410PASTI2: TIntegerField;
    Q410CAUSALE: TStringField;
    procedure A036TurniRepDTM1Create(Sender: TObject);
    procedure A036TurniRepDTM1Destroy(Sender: TObject);
    procedure Q410CalcFields(DataSet: TDataSet);
    procedure Q410BeforeDelete(DataSet: TDataSet);
    procedure Q410BeforePost(DataSet: TDataSet);
    procedure Q410AfterDelete(DataSet: TDataSet);
    procedure Q410NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    selDatiBloccati:TDatiBloccati;
    procedure SettaProgressivo;
  end;

var
  A048FPastiMeseDtM1: TA048FPastiMeseDtM1;

implementation

uses A048UPastiMese;

{$R *.DFM}

procedure TA048FPastiMeseDtM1.A036TurniRepDTM1Create(Sender: TObject);
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
  selDatiBloccati:=TDatiBloccati.Create(Self);
  selDatiBloccati.TipoLog:='M';
  A048FPastiMese.DButton.DataSet:=Q410;
end;

procedure TA048FPastiMeseDtM1.SettaProgressivo;
begin
  Q410.Close;
  Q410.SetVariable('Progressivo',C700Progressivo);
  Q410.Open;
end;

procedure TA048FPastiMeseDtM1.Q410CalcFields(DataSet: TDataSet);
begin
  case Q410Mese.AsInteger of
    1: Q410CalcMese.Value := 'Gennaio';
    2: Q410CalcMese.Value := 'Febbraio';
    3: Q410CalcMese.Value := 'Marzo';
    4: Q410CalcMese.Value := 'Aprile';
    5: Q410CalcMese.Value := 'Maggio';
    6: Q410CalcMese.Value := 'Giugno';
    7: Q410CalcMese.Value := 'Luglio';
    8: Q410CalcMese.Value := 'Agosto';
    9: Q410CalcMese.Value := 'Settembre';
    10: Q410CalcMese.Value := 'Ottobre';
    11: Q410CalcMese.Value := 'Novembre';
    12: Q410CalcMese.Value := 'Dicembre';
  end;
end;

procedure TA048FPastiMeseDtM1.Q410BeforeDelete(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(C700Progressivo,Encodedate(StrToInt(Q410.FieldByName('Anno').AsString),StrToInt(Q410.FieldByName('Mese').AsString),1),'T410') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA048FPastiMeseDtM1.Q410BeforePost(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(C700Progressivo,Encodedate(StrToInt(Q410.FieldByName('Anno').AsString),StrToInt(Q410.FieldByName('Mese').AsString),1),'T410') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  if QueryPK1.EsisteChiave('T410_PASTI',Q410.RowId,Q410.State,['PROGRESSIVO','ANNO','MESE','CAUSALE'],[Q410Progressivo.AsString,Q410Anno.AsString,Q410Mese.AsString,Q410Causale.AsString]) then
    raise Exception.Create('Elemento già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA048FPastiMeseDtM1.Q410AfterDelete(DataSet: TDataSet);
var A,M:Word;
begin
  RegistraLog.RegistraOperazione;
  A:=Q410.FieldByName('Anno').AsInteger;
  M:=Q410.FieldByName('Mese').AsInteger;
  Q410.Refresh;
  Q410.Locate('Anno;Mese',VarArrayOf([A,M]),[]);
end;

procedure TA048FPastiMeseDtM1.Q410NewRecord(DataSet: TDataSet);
begin
  Q410.FieldByName('Progressivo').AsInteger:=C700Progressivo;
end;

procedure TA048FPastiMeseDtM1.A036TurniRepDTM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(selDatiBloccati);
end;

end.
