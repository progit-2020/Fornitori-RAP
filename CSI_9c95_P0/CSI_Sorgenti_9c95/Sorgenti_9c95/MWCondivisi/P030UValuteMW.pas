unit P030UValuteMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, DB, OracleData;

type
  TP030FValuteMW = class(TR005FDataModuleMW)
  private
    { Private declarations }
  public
    { Public declarations }
    selP030: TOracleDataSet;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
