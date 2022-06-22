unit P688UMonitoraggioFondiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle;

type
  TP688FMonitoraggioFondiDtM = class(TR004FGestStoricoDtM)
    selP688: TOracleDataSet;
    dsrP688: TDataSource;
    procedure selP688AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P688FMonitoraggioFondiDtM: TP688FMonitoraggioFondiDtM;

implementation

{$R *.dfm}

procedure TP688FMonitoraggioFondiDtM.selP688AfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(selP688.FieldByName('TOT_RISORSE')).DisplayFormat:='###,###,###,##0';
  TFloatField(selP688.FieldByName('TOT_SPESO')).DisplayFormat:='###,###,###,##0';
  TFloatField(selP688.FieldByName('TOT_RESIDUO')).DisplayFormat:='###,###,###,##0';
end;

end.
