unit W004UReperibilitaDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, OracleData,
  Oracle, A000USessione, A000UInterfaccia;

type
  TW004FReperibilitaDM = class(TDataModule)
    cdsListaTimb: TClientDataSet;
    cdsLista: TClientDataSet;
    cdsListaPag: TClientDataSet;
    selT040: TOracleDataSet;
    selT100: TOracleDataSet;
    T010F_GGLAVORATIVO: TOracleQuery;
    cdsListaTurni: TClientDataSet;
    selT380: TOracleDataSet;
    dsrT380Tab: TDataSource;
    cdsT380Tab: TClientDataSet;
    selT380Controllo: TOracleDataSet;
    selT385: TOracleDataSet;
    selT380a: TOracleDataSet;
    selT350Opposto: TOracleDataSet;
    insT380: TOracleQuery;
    selT040Assenza: TOracleDataSet;
    selT430Contratto: TOracleDataSet;
    selT270: TOracleDataSet;
    selT011: TOracleDataSet;
    selT180: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  W004FReperibilitaDM: TW004FReperibilitaDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TW004FReperibilitaDM.DataModuleCreate(Sender: TObject);
var i:Integer;
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
  selT380.SetVariable('QVISTAORACLE',StringReplace(QVistaOracle,':DataLavoro','T380.DATA',[rfReplaceAll, rfIgnoreCase]));
 except
 end;
end;

end.
