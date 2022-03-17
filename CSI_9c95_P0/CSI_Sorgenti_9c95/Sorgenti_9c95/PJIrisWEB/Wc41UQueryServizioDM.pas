unit Wc41UQueryServizioDM;

interface

uses
  System.SysUtils, System.Classes, StrUtils, Oracle, OracleData, A000UInterfaccia,
  A062UQueryServizioMW, Data.DB, A000USessione;

type
  TWc41FQueryServizioDM = class(TDataModule)
    selT002: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT002FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    procedure Wc41C700MergeSelAnagrafe(ODS:TOracleDataSet);
  public
    { Public declarations }
    Progressivo:Integer;
    TuttiDipSelezionato:Boolean;
    A062MW:TA062FQueryServizioMW;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWc41FQueryServizioDM.DataModuleCreate(Sender: TObject);
var
  i:integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;
  A062MW:=TA062FQueryServizioMW.Create(Self);
  A062MW.Wc41MergeSelAnagrafe:=Wc41C700MergeSelAnagrafe;
  A062MW.SelAnagrafe:=nil;
 except
 end;
end;

procedure TWc41FQueryServizioDM.DataModuleDestroy(Sender: TObject);
begin
 try
  FreeAndNil(A062MW);
 except
 end;
end;

procedure TWc41FQueryServizioDM.Wc41C700MergeSelAnagrafe(ODS:TOracleDataSet);
var FiltroAnag:String;
begin
  if ODS.VariableIndex('C700SelAnagrafe') = -1 then
    exit;
  FiltroAnag:=IfThen(TuttiDipSelezionato,
                     WR000DM.FiltroRicerca,
                     'and T030.PROGRESSIVO = ' + Progressivo.ToString);
  ODS.SetVariable('C700SelAnagrafe',QVistaOracle + ' ' + FiltroAnag);
  if ODS.VariableIndex('DataLavoro') = -1 then
    ODS.DeclareAndSet('DataLavoro',otDate,Parametri.DataLavoro);
end;

procedure TWc41FQueryServizioDM.selT002FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',DataSet.FieldByName('NOME').AsString);
end;

end.
