unit P130UPagamentiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData;

type
  TP130FPagamentiMW = class(TR005FDataModuleMW)
  private
    { Private declarations }
  public
    { Public declarations }
    selP130: TOracleDataSet;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
