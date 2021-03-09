unit P050UArrotondamentiValuteDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData, A000UCostanti, A000USessione,A000UInterfaccia, R004UGestStoricoDtM, Variants, P050UArrotondamentiMW;

type
  TP050FArrotondamentiValuteDtM = class(TR004FGestStoricoDtM)
    Q050: TOracleDataSet;
    Q050COD_ARROTONDAMENTO: TStringField;
    Q050COD_VALUTA: TStringField;
    Q050DECORRENZA: TDateTimeField;
    Q050DESCRIZIONE: TStringField;
    Q050VALORE: TFloatField;
    Q050TIPO: TStringField;
    Q050DES_VALUTA: TStringField;
    Q050DECORRENZA_FINE: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure Q050CalcFields(DataSet: TDataSet);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure Q050DECORRENZAChange(Sender: TField);
  private
  public
  end;

var
  P050FArrotondamentiValuteDtM: TP050FArrotondamentiValuteDtM;

implementation

uses P050UArrotondamentiValute, P050UArrotondamentiDtM;

{$R *.DFM}

procedure TP050FArrotondamentiValuteDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=P050FArrotondamentiValute.InterfacciaR004;
  InizializzaDataSet(Q050,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);
  P050FArrotondamentiDtM.P050FArrotondamentiMW.Q050:=Q050;
  P050FArrotondamentiValute.DButton.DataSet:=Q050;
  Q050.SetVariable('COD_ARROTONDAMENTO', P050FArrotondamentiValute.Cod);
  Q050.Open;
end;

procedure TP050FArrotondamentiValuteDtM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  P050FArrotondamentiDtM.P050FArrotondamentiMW.OnNewRecord;
end;

procedure TP050FArrotondamentiValuteDtM.Q050CalcFields(DataSet: TDataSet);
begin
  inherited;
  P050FArrotondamentiDtM.P050FArrotondamentiMW.CalcFields;
end;

procedure TP050FArrotondamentiValuteDtM.Q050DECORRENZAChange(Sender: TField);
begin
  inherited;
  P050FArrotondamentiDtM.P050FArrotondamentiMW.P050DecorrenzaChange;
end;

procedure TP050FArrotondamentiValuteDtM.BeforePost(DataSet: TDataSet);
begin
  P050FArrotondamentiDtM.P050FArrotondamentiMW.BeforePost;
  inherited;
end;

end.
