unit A059UContSquadraMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData;

type
  TA059FContSquadraMW = class(TR005FDataModuleMW)
    D600B: TDataSource;
    Q600: TOracleDataSet;
    Q600CODICE: TStringField;
    Q600DESCRIZIONE: TStringField;
    D600: TDataSource;
    Q600B: TOracleDataSet;
    Q600BCODICE: TStringField;
    Q600BDESCRIZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TA059FContSquadraMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Q600.Open;
  Q600B.Open;
end;

end.
