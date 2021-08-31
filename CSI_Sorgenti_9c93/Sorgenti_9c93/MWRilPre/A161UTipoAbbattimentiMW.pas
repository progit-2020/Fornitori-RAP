unit A161UTipoAbbattimentiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData;

type
  TA161FTipoAbbattimentiMW = class(TR005FDataModuleMW)
  private
    { Private declarations }
  public
    selT766: TOracleDataSet;
  end;



implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
