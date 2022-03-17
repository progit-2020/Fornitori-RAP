unit P150USetupMW;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Math, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DBClient, DB, OracleData,Provider, C180FunzioniGenerali;

type
  TP150FSetupMW = class(TR005FDataModuleMW)
    T480_COMUNI: TOracleDataSet;
    T480_COMUNICODICE: TStringField;
    T480_COMUNICITTA: TStringField;
    T480_COMUNICAP: TStringField;
    T480_COMUNIPROVINCIA: TStringField;
    T480_COMUNICODCATASTALE: TStringField;
    Q030: TOracleDataSet;
    Q030COD_VALUTA: TStringField;
    Q030DESCRIZIONE: TStringField;
    D030: TDataSource;
    Q130: TOracleDataSet;
    Q130COD_PAGAMENTO: TStringField;
    Q130DESCRIZIONE: TStringField;
    D130: TDataSource;
    D480: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    selP150: TOracleDataSet;
    procedure P150CalcFields;
  end;

implementation

{$R *.dfm}

procedure TP150FSetupMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Q030.Close;
  Q030.SetVariable('DECORRENZA',Date);
  Q030.Open;
  Q130.Open;
  T480_COMUNI.SetVariable('ORDERBY','ORDER BY CITTA');
  T480_COMUNI.Open;
end;

procedure TP150FSetupMW.P150CalcFields;
begin
  inherited;
  if IfThen(selP150.FieldByName('DECORRENZA').IsNull,EncodeDate(3999,12,31),selP150.FieldByName('DECORRENZA').AsDateTime) <> Q030.GetVariable('DECORRENZA') then
  begin
    Q030.Close;
    Q030.SetVariable('DECORRENZA',IfThen(selP150.FieldByName('DECORRENZA').IsNull,EncodeDate(3999,12,31),selP150.FieldByName('DECORRENZA').AsDateTime));
    Q030.Open;
  end;
  selP150.FieldByName('DES_PAGAM').AsString:='';
  selP150.FieldByName('DES_BASE').AsString:='';
  selP150.FieldByName('DES_STAMPA').AsString:='';
  selP150.FieldByName('DES_CONT').AsString:='';
  if Q130.SearchRecord('COD_PAGAMENTO',selP150.FieldByName('COD_PAGAMENTO').AsString,[srFromBeginning]) then
    selP150.FieldByName('DES_PAGAM').AsString:=Q130.FieldByName('DESCRIZIONE').AsString;
  if Q030.SearchRecord('COD_VALUTA',selP150.FieldByName('COD_VALUTA_BASE').AsString,[srFromBeginning]) then
    selP150.FieldByName('DES_BASE').AsString:=Q030.FieldByName('DESCRIZIONE').AsString;
  if Q030.SearchRecord('COD_VALUTA',selP150.FieldByName('COD_VALUTA_STAMPA').AsString,[srFromBeginning]) then
    selP150.FieldByName('DES_STAMPA').AsString:=Q030.FieldByName('DESCRIZIONE').AsString;
  if Q030.SearchRecord('COD_VALUTA',selP150.FieldByName('COD_VALUTA_CONT').AsString,[srFromBeginning]) then
    selP150.FieldByName('DES_CONT').AsString:=Q030.FieldByName('DESCRIZIONE').AsString;
end;

end.
