unit A097UPianifLibProfDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StrUtils,
  Db, Variants, OracleData, Oracle, RegistrazioneLog,
  A000UCostanti, A000USessione, A000UInterfaccia,
  C180FUnzioniGenerali, C700USelezioneAnagrafe, A097UPianifLibProfMW;

type
  TA097FPianifLibProfDtM1 = class(TDataModule)
    D320: TDataSource;
    D310: TDataSource;
    Q320: TOracleDataSet;
    Q320PROGRESSIVO: TFloatField;
    Q320DATA: TDateTimeField;
    Q320DALLE: TStringField;
    Q320ALLE: TStringField;
    Q320D_GIORNO: TStringField;
    Q320D_CAUSALE: TStringField;
    Q320CAUSALE: TStringField;
    procedure A056FTurnazIndDtM1Create(Sender: TObject);
    procedure A056FTurnazIndDtM1Destroy(Sender: TObject);
    procedure D310DataChange(Sender: TObject; Field: TField);
    procedure D320StateChange(Sender: TObject);
    procedure Q320BeforeDelete(DataSet: TDataSet);
    procedure Q320AfterDelete(DataSet: TDataSet);
    procedure Q320CalcFields(DataSet: TDataSet);
    procedure Q320DALLEValidate(Sender: TField);
    procedure Q320NewRecord(DataSet: TDataSet);
    procedure Q320CAUSALEValidate(Sender: TField);
    procedure Q320BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    A097MW: TA097FPianifLibProfMW;
  end;

var
  A097FPianifLibProfDtM1: TA097FPianifLibProfDtM1;

implementation

uses A097UPianifLibProf;

{$R *.DFM}

procedure TA097FPianifLibProfDtM1.A056FTurnazIndDtM1Create(Sender: TObject);
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
  A097MW:=TA097FPianifLibProfMW.Create(Self);
  A097MW.selT320:=Q320;
  D310.DataSet:=A097MW.Q310;
end;

procedure TA097FPianifLibProfDtM1.A056FTurnazIndDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA097FPianifLibProfDtM1.D310DataChange(Sender: TObject; Field: TField);
begin
  if (A097MW.Q310.RecordCount > 0) and (Field = nil) then
    if A097FPianifLibProf.EProfilo.KeyValue <> Null then
      A097FPianifLibProf.Label6.Caption:=A097MW.Q310.FieldByName('Descrizione').AsString;
end;

procedure TA097FPianifLibProfDtM1.D320StateChange(Sender: TObject);
begin
  A097FPianifLibProf.frmToolbarFiglio.DButtonStateChange(Sender);
  A097FPianifLibProf.rgpGestioneProfilo.Enabled:=Q320.State = dsBrowse;
end;

procedure TA097FPianifLibProfDtM1.Q320AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA097FPianifLibProfDtM1.Q320BeforeDelete(DataSet: TDataSet);
begin
  A097MW.selT320BeforeDelete;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA097FPianifLibProfDtM1.Q320BeforePost(DataSet: TDataSet);
begin
  A097MW.selT320BeforePost;
  inherited;
  case DataSet.State of
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA097FPianifLibProfDtM1.Q320CalcFields(DataSet: TDataSet);
begin
  A097MW.selT320CalcFields;
end;

procedure TA097FPianifLibProfDtM1.Q320NewRecord(DataSet: TDataSet);
begin
  A097MW.selT320NewRecord;
end;

procedure TA097FPianifLibProfDtM1.Q320DALLEValidate(Sender: TField);
begin
  A097MW.selT320DALLEValidate(Sender);
end;

procedure TA097FPianifLibProfDtM1.Q320CAUSALEValidate(Sender: TField);
begin
  A097MW.selT320CAUSALEValidate(Sender);
end;

end.

