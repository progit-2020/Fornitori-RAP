unit P032UCambiMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, A000UMessaggi;

type
  TP032FCambiMW = class(TR005FDataModuleMW)
    selP030: TOracleDataSet;
    selP030COD_VALUTA: TStringField;
    selP030DESCRIZIONE: TStringField;
    dsrP030: TDataSource;
  private
    { Private declarations }
  public
    selP032: TOracleDataSet;
    procedure P032DECORRENZAChange;
    procedure P032AfterScroll;
    procedure P032CalcFields;
    procedure BeforePost;
  end;

implementation

{$R *.dfm}

procedure TP032FCambiMW.P032DECORRENZAChange;
begin
  if (not selP032.FieldByName('DECORRENZA').IsNull) then
  begin
    selP030.Close;
    selP030.SetVariable('DECORRENZA',selP032.FieldByName('DECORRENZA').AsDateTime);
    selP030.Open;
  end;
end;

procedure TP032FCambiMW.P032AfterScroll;
begin
  P032DECORRENZAChange;
end;

procedure TP032FCambiMW.BeforePost;
begin
  inherited;
  if selP032.FieldByName('COEFF_CALCOLI').AsFloat <= 0 then
    raise exception.Create(A000MSG_P032_ERR_COEFF_INVALIDO);  //'Impostare un coefficiente di cambio significativo'
end;

procedure TP032FCambiMW.P032CalcFields;
begin
  P032DECORRENZAChange;
  if not selP030.Active then
    Exit;
  selP032.FieldByName('Desc_Valuta1').AsString:=VarToStr(selP030.Lookup('COD_VALUTA',selP032.FieldByName('COD_VALUTA1').AsString,'DESCRIZIONE'));
  selP032.FieldByName('Desc_Valuta2').AsString:=VarToStr(selP030.Lookup('COD_VALUTA',selP032.FieldByName('COD_VALUTA2').AsString,'DESCRIZIONE'));
end;

end.
