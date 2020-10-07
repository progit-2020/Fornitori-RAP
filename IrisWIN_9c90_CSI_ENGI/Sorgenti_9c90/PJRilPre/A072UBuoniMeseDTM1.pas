unit A072UBuoniMeseDTM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia,C700USelezioneAnagrafe, RegistrazioneLog,
  OracleData, Oracle, C180FunzioniGenerali, Variants,
  DatiBloccati;

type
  TA072FBuoniMeseDtM1 = class(TDataModule)
    Q680: TOracleDataSet;
    Q680CALCMESE: TStringField;
    Q680PROGRESSIVO: TIntegerField;
    Q680ANNO: TIntegerField;
    Q680MESE: TIntegerField;
    Q680BUONIPASTO: TIntegerField;
    Q680VARBUONIPASTO: TIntegerField;
    Q680TICKET: TIntegerField;
    Q680VARTICKET: TIntegerField;
    Q680NOTE: TStringField;
    procedure A048FPastiMeseDTM1Create(Sender: TObject);
    procedure A048FPastiMeseDTM1Destroy(Sender: TObject);
    procedure Q680CalcFields(DataSet: TDataSet);
    procedure Q680BeforePost(DataSet: TDataSet);
    procedure Q680BeforeDelete(DataSet: TDataSet);
    procedure Q680AfterPost(DataSet: TDataSet);
    procedure Q680NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    selDatiBloccati:TDatiBloccati;
    procedure SettaProgressivo;
  end;

var
  A072FBuoniMeseDtM1: TA072FBuoniMeseDtM1;

implementation

uses A072UBuoniMese;

{$R *.DFM}

//------------------------------------------------------------------------------
procedure TA072FBuoniMeseDtM1.A048FPastiMeseDTM1Create(Sender: TObject);
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
  A072FBuoniMese.DButton.DataSet:=Q680;
end;

procedure TA072FBuoniMeseDtM1.SettaProgressivo;
begin
  with Q680 do
    begin
    DisableControls;
    Close;
    SetVariable('Progressivo',C700Progressivo);
    Open;
    EnableControls;
    end;
end;

//------------------------------------------------------------------------------
procedure TA072FBuoniMeseDtM1.A048FPastiMeseDTM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(selDatiBloccati);
end;

procedure TA072FBuoniMeseDtM1.Q680CalcFields(DataSet: TDataSet);
begin
  case Q680Mese.AsInteger of
    1: Q680CalcMese.Value:='Gennaio';
    2: Q680CalcMese.Value:='Febbraio';
    3: Q680CalcMese.Value:='Marzo';
    4: Q680CalcMese.Value:='Aprile';
    5: Q680CalcMese.Value:='Maggio';
    6: Q680CalcMese.Value:='Giugno';
    7: Q680CalcMese.Value:='Luglio';
    8: Q680CalcMese.Value:='Agosto';
    9: Q680CalcMese.Value:='Settembre';
    10: Q680CalcMese.Value:='Ottobre';
    11: Q680CalcMese.Value:='Novembre';
    12: Q680CalcMese.Value:='Dicembre';
  end;
end;

procedure TA072FBuoniMeseDtM1.Q680BeforePost(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(C700Progressivo,Encodedate(StrToInt(Q680.FieldByName('Anno').AsString),StrToInt(Q680.FieldByName('Mese').AsString),1),'T680') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  if QueryPK1.EsisteChiave('T680_BUONIMENSILI',Q680.RowId,Q680.State,['PROGRESSIVO','ANNO','MESE'],[Q680Progressivo.AsString,Q680Anno.AsString,Q680Mese.AsString]) then
    raise Exception.Create('Elemento già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA072FBuoniMeseDtM1.Q680BeforeDelete(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(C700Progressivo,Encodedate(StrToInt(Q680.FieldByName('Anno').AsString),StrToInt(Q680.FieldByName('Mese').AsString),1),'T680') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA072FBuoniMeseDtM1.Q680AfterPost(DataSet: TDataSet);
var A,M:Word;
begin
  RegistraLog.RegistraOperazione;
  A:=Q680.FieldByName('Anno').AsInteger;
  M:=Q680.FieldByName('Mese').AsInteger;
  Q680.Refresh;
  Q680.Locate('Anno;Mese',VarArrayOf([A,M]),[]);
end;

procedure TA072FBuoniMeseDtM1.Q680NewRecord(DataSet: TDataSet);
begin
  Q680.FieldByName('Progressivo').AsInteger:=C700Progressivo;
end;

end.
