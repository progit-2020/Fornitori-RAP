unit A107UInsAssAutoRegoleDtM;

interface

uses DB, Classes, OracleData, Forms, Oracle, C180FunzioniGenerali,
  A000UInterfaccia, A000USessione, A107UInsAssAutoRegoleMW;

type
  TA107FInsAssAutoRegoleDtM = class(TDataModule)
    selT045: TOracleDataSet;
    selT045CAUSALI: TStringField;
    selT045DEBITO: TStringField;
    selT045GIORNI_VUOTI: TStringField;
    selT045ORE_MAX: TStringField;
    selT045ELIMINA_GIUSTIFICATIVI: TStringField;
    procedure A107FInsAssAutoRegoleDtMCreate(Sender: TObject);
    procedure A107FInsAssAutoRegoleDtMDestroy(Sender: TObject);
    procedure selT045AfterCancel(DataSet: TDataSet);
    procedure selT045AfterPost(DataSet: TDataSet);
    procedure selT045BeforePost(DataSet: TDataSet);
    procedure selT045ORE_MAXValidate(Sender: TField);
  private
    { Private declarations }
  public
    A107MW: TA107FInsAssAutoRegoleMW;
  end;

var
  A107FInsAssAutoRegoleDtM: TA107FInsAssAutoRegoleDtM;

implementation

uses A107UInsAssAutoRegole;

{$R *.DFM}

procedure TA107FInsAssAutoRegoleDtM.A107FInsAssAutoRegoleDtMCreate(Sender: TObject);
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
  A107MW:=TA107FInsAssAutoRegoleMW.Create(Self);
  A107MW.selT045:=selT045;
  selT045.Open;
end;

procedure TA107FInsAssAutoRegoleDtM.A107FInsAssAutoRegoleDtMDestroy(Sender: TObject);
begin
  selT045.Close;
end;

procedure TA107FInsAssAutoRegoleDtM.selT045AfterCancel(DataSet: TDataSet);
begin
  with A107FInsAssAutoRegole do
    lstCausali.Items.CommaText:=selT045.FieldByName('CAUSALI').AsString;
end;

procedure TA107FInsAssAutoRegoleDtM.selT045AfterPost(DataSet: TDataSet);
begin
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
end;

procedure TA107FInsAssAutoRegoleDtM.selT045BeforePost(DataSet: TDataSet);
begin
  A107MW.BeforePost(A107FInsAssAutoRegole.lstCausali.Items.CommaText);
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA107FInsAssAutoRegoleDtM.selT045ORE_MAXValidate(Sender: TField);
begin
  A107MW.ValidaOre(Sender);
end;

end.
