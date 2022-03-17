unit Ac10UFestivitaParticolariMW;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Vcl.Controls,
  R005UDataModuleMW, Data.DB, OracleData, Datasnap.DBClient,
  C180FunzioniGenerali, A000UCostanti;

type

  TAc10FFestivitaParticolariMW = class(TR005FDataModuleMW)
    selT265: TOracleDataSet;
    dsrSelT265: TDataSource;
    selT265_All: TOracleDataSet;
    dsrSelT265_All: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenSelT265(FiltroCaus:string);
    procedure OpenSelT265Ins(FFruibili,FSostituzione:string);
  end;

implementation

{$R *.dfm}

procedure TAc10FFestivitaParticolariMW.OpenSelT265Ins(FFruibili,FSostituzione:string);
var
  FSQL:string;
begin
  selT265_All.Close;
  FSQL:='';
  if not FFruibili.IsEmpty then
    FSQL:=' and T265.CODICE not in (''' + FFruibili.Replace(',',''',''') + ''')';
  if not FSostituzione.IsEmpty then
    FSQL:=FSQL + ' and T265.CODICE not in (''' + FSostituzione.Replace(',',''',''') + ''')';
  selT265_All.SetVariable('FILTROCAUS',FSQL);
  selT265_All.Open;
end;

procedure TAc10FFestivitaParticolariMW.OpenSelT265(FiltroCaus:string);
begin
  selT265.Close;
  selT265.ClearVariables;
  if not FiltroCaus.IsEmpty then
    R180SetVariable(selT265,'FILTROCAUS',' and T265.CODICE not in (''' + FiltroCaus.Replace(',',''',''') + ''')');
  selT265.Open;
end;

end.
