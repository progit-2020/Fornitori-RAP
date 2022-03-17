unit P050UArrotondamentiMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, A000UMessaggi, DB, OracleData;

type

  TP050FArrotondamentiMW = class(TR005FDataModuleMW)
    Q030: TOracleDataSet;
    Q030COD_VALUTA: TStringField;
    Q030DESCRIZIONE: TStringField;
    D030: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Q050: TOracleDataSet;
    Q050K: TOracleDataSet;
    procedure CalcFields;
    procedure BeforePost;
    procedure OnNewRecord;
    procedure P050KAfterScroll;
    procedure P050KBeforeDelete;
    procedure P050DecorrenzaChange;
  end;

implementation

uses A000UInterfaccia, C180FunzioniGenerali;

{$R *.dfm}

procedure TP050FArrotondamentiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Q030.Close;
  Q030.SetVariable('DECORRENZA',Date);
  Q030.Open;
end;

procedure TP050FArrotondamentiMW.P050KAfterScroll;
begin
  Q050.SetVariable('COD_ARROTONDAMENTO', Q050K.FieldByName('COD_ARROTONDAMENTO').AsString);
  Q050.Close;
  Q050.Open;
end;

procedure TP050FArrotondamentiMW.P050KBeforeDelete;
begin
  if Q050.RecordCount > 0 then  //Se esistono arrotondamenti legati a questo Codice --> cancellazione impossibile
    raise Exception.Create(A000MSG_P050_ERR_COD_ARROTONDAMENTO);
end;

procedure TP050FArrotondamentiMW.P050DecorrenzaChange;
begin
  if (not Q050.FieldByName('DECORRENZA').IsNull) then
  begin
    Q030.Close;
    Q030.SetVariable('DECORRENZA',Q050.FieldByName('DECORRENZA').AsDateTime);
    Q030.Open;
  end;
end;

procedure TP050FArrotondamentiMW.BeforePost;
begin
  inherited;
  if Q050.FieldByName('COD_VALUTA').AsString = '' then //Codice valuta obbligatorio
    raise Exception.Create(A000MSG_P050_ERR_COD_VALUTA);
end;

procedure TP050FArrotondamentiMW.OnNewRecord;
begin
  Q050.FieldByName('Cod_Arrotondamento').AsString:=Q050K.FieldByName('COD_ARROTONDAMENTO').AsString;
end;

procedure TP050FArrotondamentiMW.CalcFields;
begin
  inherited;
  Q030.Close;
  Q030.SetVariable('DECORRENZA',Q050.fieldbyName('DECORRENZA').AsDateTime);
  Q030.Open;
  Q050.FieldByName('DES_VALUTA').AsString:='';
  if Q030.SearchRecord('COD_VALUTA',Q050.FieldByName('COD_VALUTA').AsString,[srFromBeginning]) then
    Q050.FieldByName('DES_VALUTA').AsString:=Q030.FieldByName('DESCRIZIONE').AsString;
end;

end.
