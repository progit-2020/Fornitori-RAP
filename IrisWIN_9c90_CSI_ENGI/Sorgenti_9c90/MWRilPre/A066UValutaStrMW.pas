unit A066UValutaStrMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB, Oracle, StrUtils, A000USessione, A000UInterfaccia;

type
  TA066FValutaStrMW = class(TR005FDataModuleMW)
    QFasce: TOracleDataSet;
    QLookup: TOracleDataSet;
    selLivello: TOracleDataSet;
    dsrLivello: TDataSource;
    selT275: TOracleDataSet;
    dsrT275: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT275AfterOpen(DataSet: TDataSet);

  private

  public
    selT730: TOracleDataSet;
//    selLivello: TOracleDataSet;
//    dsrLivello: TDataSource;
    LivelloFiltro: String;
    CausaleFiltro: String;
    procedure BeforePost(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet);
    procedure selT730MAGGIORAZIONEValidate(Sender: TField);
    procedure selT730AfterOpen(DataSet: TDataSet);
    procedure FiltraDati(const PLivello, PCausale: String);
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA066FValutaStrMW.selT275AfterOpen(DataSet: TDataSet);
begin
  inherited;
  selT275.FieldByName('CODICE').DisplayWidth:=7;
end;

procedure TA066FValutaStrMW.selT730AfterOpen(DataSet: TDataSet);
begin

  inherited;

  selT730.FieldByName('LIVELLO').Visible:=False;
  selT730.FieldByName('DECORRENZA').Visible:=False;
  selT730.FieldByName('DECORRENZA_FINE').Visible:=False;

end;



procedure TA066FValutaStrMW.selT730MAGGIORAZIONEValidate(Sender: TField);
begin
  inherited;
  if selT730.FieldByName('MAGGIORAZIONE').AsInteger < 0 then
    raise Exception.Create('La fascia di maggiorazione non può essere negativa!');
end;

procedure TA066FValutaStrMW.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  if LivelloFiltro <> '' then
    selT730.FieldByName('LIVELLO').AsString:=LivelloFiltro;
  if CausaleFiltro <> '' then
    selT730.FieldByName('CAUSALE').AsString:=CausaleFiltro;
  selT730.FieldByName('TARIFFA_LIQ').AsFloat:=0;
  selT730.FieldByName('TARIFFA_MAT').AsFloat:=0;
end;

procedure TA066FValutaStrMW.BeforePost(DataSet: TDataSet);
begin
  if selT730.FieldByName('MAGGIORAZIONE').IsNull then
    raise Exception.Create('Indicare la fascia di maggiorazione!');
  inherited;
end;

procedure TA066FValutaStrMW.DataModuleCreate(Sender: TObject);
begin
  inherited;


  if A000LookupTabella(Parametri.CampiRiferimento.C2_Livello,selLivello) then
  begin
    if selLivello.VariableIndex('DECORRENZA') >= 0 then
      selLivello.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
      selLivello.Open;
      selT275.Open;
  end;
end;

procedure TA066FValutaStrMW.FiltraDati(const PLivello, PCausale: String);
// applica filtro lato client su dataset
var
  Filtro: String;
begin

  selT730.Filtered:=False;
  Filtro:='';

  LivelloFiltro:=PLivello;
  if PLivello <> '' then
  begin
    Filtro:=Format('(LIVELLO = ''%s'')',[PLivello]);
  end;
  CausaleFiltro:=PCausale;
  if PCausale <> '' then
  begin
    Filtro:=Filtro + IfThen(Filtro <> '',' and ') + Format('(CAUSALE = ''%s'')',[PCausale]);
  end;
  selT730.Filter:=Filtro;
  selT730.Filtered:=Filtro <> '';
end;


end.
