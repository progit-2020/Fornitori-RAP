unit A073UAcquistoBuoniDtM1;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Math, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe,RegistrazioneLog,
  OracleData, Oracle, C180FunzioniGenerali,  Variants, DBClient,
  DatiBloccati, A073UAcquistoBuoniMW;

type
  TA073FAcquistoBuoniDtM1 = class(TDataModule)
    Q690: TOracleDataSet;
    Q690DATA: TDateTimeField;
    Q690PROGRESSIVO: TIntegerField;
    Q690BUONIPASTO: TIntegerField;
    Q690TICKET: TIntegerField;
    Q690BUONI_AUTO: TIntegerField;
    Q690TICKET_AUTO: TIntegerField;
    Q690BUONI_RECUPERATI: TIntegerField;
    Q690TICKET_RECUPERATI: TIntegerField;
    Q690NOTE: TStringField;
    Q690DATA_MAGAZZINO: TDateTimeField;
    Q690DATA_MAGAZZINOlk: TDateTimeField;
    Q690ID_BLOCCHETTI: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure Q690DATAValidate(Sender: TField);
    procedure A073FAcquistoBuoniDtM1Create(Sender: TObject);
    procedure Q690AfterPost(DataSet: TDataSet);
    procedure Q690NewRecord(DataSet: TDataSet);
    procedure Q690BeforePost(DataSet: TDataSet);
    procedure Q690BeforeDelete(DataSet: TDataSet);
    procedure Q690ID_BLOCCHETTIValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    A073MW:TA073FAcquistoBuoniMW;
    procedure SettaProgressivo;
  end;

var
  A073FAcquistoBuoniDtM1: TA073FAcquistoBuoniDtM1;

implementation

uses A073UAcquistoBuoni;

{$R *.DFM}

procedure TA073FAcquistoBuoniDtM1.A073FAcquistoBuoniDtM1Create(
  Sender: TObject);
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
  A073MW:=TA073FAcquistoBuoniMW.Create(nil);
  A073MW.Q690:=Q690;
  A073MW.InizializzaQ690;
end;

procedure TA073FAcquistoBuoniDtM1.SettaProgressivo;
begin
  Q690.Close;
  Q690.SetVariable('PROGRESSIVO',C700Progressivo);
  Q690.Open;
end;

procedure TA073FAcquistoBuoniDtM1.Q690AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  A073MW.Q690AfterPost;
end;

procedure TA073FAcquistoBuoniDtM1.Q690NewRecord(DataSet: TDataSet);
begin
  Q690.FieldByName('PROGRESSIVO').AsInteger:=C700Progressivo;
  Q690.FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
end;

procedure TA073FAcquistoBuoniDtM1.Q690BeforePost(DataSet: TDataSet);
var sMessaggio:String;
begin
  with A073MW do
  begin
    if selDatiBloccati.DatoBloccato(C700Progressivo,Q690.FieldByName('Data').AsDateTime,'T690') then
      raise Exception.Create(selDatiBloccati.MessaggioLog);
    sMessaggio:=Q690BeforePost;
    if sMessaggio <> '' then
      if R180MessageBox(sMessaggio,'DOMANDA') = mrNo then
        Abort;
  end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA073FAcquistoBuoniDtM1.Q690BeforeDelete(DataSet: TDataSet);
begin
  with A073MW do
    if selDatiBloccati.DatoBloccato(C700Progressivo,Q690.FieldByName('Data').AsDateTime,'T690') then
      raise Exception.Create(selDatiBloccati.MessaggioLog);
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA073FAcquistoBuoniDtM1.Q690DATAValidate(Sender: TField);
begin
  A073MW.Q690DATAValidate(Sender);
end;

procedure TA073FAcquistoBuoniDtM1.Q690ID_BLOCCHETTIValidate(Sender: TField);
begin
  A073MW.Q690ID_BLOCCHETTIValidate(Sender);
end;

procedure TA073FAcquistoBuoniDtM1.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A073MW);
end;

end.
