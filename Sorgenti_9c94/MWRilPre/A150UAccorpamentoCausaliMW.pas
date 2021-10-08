unit A150UAccorpamentoCausaliMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, A000UInterfaccia, A000UMessaggi;

type
  TA150FAccorpamentoCausaliMW = class(TR005FDataModuleMW)
    selT255GetTipoWEB: TOracleDataSet;
    Q257: TOracleDataSet;
    Q257DECORRENZA: TDateTimeField;
    Q257COD_CAUSALE: TStringField;
    Q257DESCRIZIONE: TStringField;
    dsrQ257: TDataSource;
    selT265: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure VerificaAccorpamentoWeb(DataSet: TDataSet);
    procedure RefreshQ257(CodTipoAccorpamento,CodCodiciAccorpamento: String);
    function CalcDescrizione(DataSet: TDataSet): String;
  end;

implementation

{$R *.dfm}

procedure TA150FAccorpamentoCausaliMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT265.Open;
end;

procedure TA150FAccorpamentoCausaliMW.RefreshQ257(CodTipoAccorpamento,CodCodiciAccorpamento: String);
begin
  Q257.Close;
  Q257.SetVariable('CodTipoAccorpCausali',CodTipoAccorpamento);
  Q257.SetVariable('CodCodiciAccorpCausali',CodCodiciAccorpamento);
  Q257.SetVariable('Decorrenza', Parametri.DataLavoro);
  Q257.Open;
end;

procedure TA150FAccorpamentoCausaliMW.VerificaAccorpamentoWeb(DataSet: TDataSet);
begin
  if DataSet.FieldByName('TIPO').AsString = 'WEB' then
  begin
    selT255GetTipoWeb.Close;
    selT255GetTipoWeb.SetVariable('COD_TIPOACCORPCAUSALI',DataSet.FieldByName('COD_TIPOACCORPCAUSALI').AsString);
    selT255GetTipoWeb.Open;
    if selT255GetTipoWeb.FieldByName('NUMWEB').AsInteger > 0 then
      raise Exception.Create(A000MSG_A150_ERR_ACCORPAMENTO_WEB);
  end;
end;

function TA150FAccorpamentoCausaliMW.CalcDescrizione(DataSet: TDataSet): String;
begin
  if selT265.SearchRecord('CODICE',DataSet.FieldByName('COD_CAUSALE').AsString,[srFromBeginning]) then
    Result:=selT265.FieldByName('DESCRIZIONE').AsString
  else
    Result:='';
end;

end.
