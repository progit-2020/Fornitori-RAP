unit A144UComuniMedLegaliMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Oracle,
  Data.DB;

type
  TA144FComuniMedLegaliMW = class(TR005FDataModuleMW)
    selT480: TOracleDataSet;
    dscT480: TDataSource;
    selT485: TOracleDataSet;
    dscT485: TDataSource;
    selT480CODICE: TStringField;
    selT480CITTA: TStringField;
    selT480CAP: TStringField;
    selT480PROVINCIA: TStringField;
    selT480CODCATASTALE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selT486: TOracleDataSet;
    procedure BeforePostNoStorico;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA144FComuniMedLegaliMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT480.SetVariable('ORDERBY', 'ORDER BY CITTA');
  selT480.Open;
end;

procedure TA144FComuniMedLegaliMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  selT480.Close;
end;

procedure TA144FComuniMedLegaliMW.BeforePostNoStorico;
begin
  if selT486.FieldByName('MED_LEGALE').AsString = '' then
    raise Exception.Create('Selezionare la medicina legale!');

  if selT486.FieldByName('COD_COMUNE').AsString = '' then
    raise Exception.Create('Selezionare il comune da associare alla medicina legale!');

  inherited;
end;

end.
