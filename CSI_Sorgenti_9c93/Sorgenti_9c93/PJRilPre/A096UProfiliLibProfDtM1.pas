unit A096UProfiliLibProfDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  A000UCostanti, A000USessione, A000UInterfaccia, Db, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants, A096UProfiliLibProfMW;

type
  TA096FProfiliLibProfDtM1 = class(TDataModule)
    D311: TDataSource;
    Q310: TOracleDataSet;
    Q311: TOracleDataSet;
    Q311CODICE: TStringField;
    Q311GIORNO: TIntegerField;
    Q311DALLE: TStringField;
    Q311ALLE: TStringField;
    Q311CAUSALE: TStringField;
    Q311D_CAUSALE: TStringField;
    Q311D_GIORNO: TStringField;
    Q310CODICE: TStringField;
    Q310DESCRIZIONE: TStringField;
    procedure A054FCicliTurniDtM1Create(Sender: TObject);
    procedure Q310AfterDelete(DataSet: TDataSet);
    procedure Q310AfterPost(DataSet: TDataSet);
    procedure Q310AfterScroll(DataSet: TDataSet);
    procedure Q310BeforeDelete(DataSet: TDataSet);
    procedure Q310BeforePost(DataSet: TDataSet);
    procedure Q311AfterDelete(DataSet: TDataSet);
    procedure Q311AfterPost(DataSet: TDataSet);
    procedure Q311BeforeDelete(DataSet: TDataSet);
    procedure Q311BeforePost(DataSet: TDataSet);
    procedure Q311CalcFields(DataSet: TDataSet);
    procedure Q311NewRecord(DataSet: TDataSet);
    procedure Q311DALLEValidate(Sender: TField);
    procedure Q311CAUSALEValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    A096MW: TA096FProfiliLibProfMW;
  end;

var
  A096FProfiliLibProfDtM1: TA096FProfiliLibProfDtM1;

implementation

{$R *.DFM}

procedure TA096FProfiliLibProfDtM1.A054FCicliTurniDtM1Create(Sender: TObject);
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
  A096MW:=TA096FProfiliLibProfMW.Create(Self);
  A096MW.selT310:=Q310;
  A096MW.selT311:=Q311;
  Q310.Open;
end;

procedure TA096FProfiliLibProfDtM1.Q310AfterDelete(DataSet: TDataSet);
begin
  try
    //SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TA096FProfiliLibProfDtM1.Q310AfterPost(DataSet: TDataSet);
begin
  try
    //SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TA096FProfiliLibProfDtM1.Q310AfterScroll(DataSet: TDataSet);
begin
  A096MW.selT310AfterScroll;
end;

procedure TA096FProfiliLibProfDtM1.Q310BeforeDelete(DataSet: TDataSet);
begin
  A096MW.selT310BeforeDelete;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA096FProfiliLibProfDtM1.Q310BeforePost(DataSet: TDataSet);
begin
  A096MW.selT310BeforePost;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA096FProfiliLibProfDtM1.Q311AfterDelete(DataSet: TDataSet);
begin
  try
    //SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TA096FProfiliLibProfDtM1.Q311AfterPost(DataSet: TDataSet);
begin
  try
    //SessioneOracle.Commit;
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    SessioneOracle.Rollback;
    raise;
  end;
end;

procedure TA096FProfiliLibProfDtM1.Q311BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA096FProfiliLibProfDtM1.Q311BeforePost(DataSet: TDataSet);
begin
  A096MW.selT311BeforePost;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA096FProfiliLibProfDtM1.Q311CalcFields(DataSet: TDataSet);
begin
  A096MW.selT311CalcFields;
end;

procedure TA096FProfiliLibProfDtM1.Q311NewRecord(DataSet: TDataSet);
begin
  A096MW.selT311NewRecord;
end;

procedure TA096FProfiliLibProfDtM1.Q311DALLEValidate(Sender: TField);
begin
  A096MW.selT311DALLEValidate(Sender);
end;

procedure TA096FProfiliLibProfDtM1.Q311CAUSALEValidate(Sender: TField);
begin
  A096MW.selT311CAUSALEValidate(Sender);
end;

end.
