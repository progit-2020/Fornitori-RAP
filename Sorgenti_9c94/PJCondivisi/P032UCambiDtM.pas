unit P032UCambiDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData,  A000UCostanti, A000USessione, A000UInterfaccia, R004UGestStoricoDtM, Variants,
  P032UCambiMW;

type
  TP032FCambiDtM = class(TR004FGestStoricoDtM)
    selP032: TOracleDataSet;
    selP032COD_VALUTA1: TStringField;
    selP032COD_VALUTA2: TStringField;
    selP032DECORRENZA: TDateTimeField;
    selP032COEFF_CALCOLI: TFloatField;
    selP032DECORRENZA_FINE: TDateTimeField;
    selP032D_CodVal2: TStringField;
    selP032D_CodVal1: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selP032DECORRENZAChange(Sender: TField);
    procedure selP032AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    procedure BeforePost(DataSet: TDataSet); override;
  public
    P032FCambiMW: TP032FCambiMW;
  end;

var
  P032FCambiDtM: TP032FCambiDtM;

implementation

uses P032UCambi;

{$R *.DFM}

procedure TP032FCambiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=P032FCambi.InterfacciaR004;
  InizializzaDataSet(selP032,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);
  P032FCambiMW:=TP032FCambiMW.Create(Self);
  P032FCambiMW.selP032:=selP032;
  selP032.FieldByName('D_CodVal1').LookupDataSet:=P032FCambiMW.selP030;
  selP032.FieldByName('D_CodVal2').LookupDataSet:=P032FCambiMW.selP030;
  P032FCambi.DButton.DataSet:=selP032;
  selP032.Open;
end;

procedure TP032FCambiDtM.selP032DECORRENZAChange(Sender: TField);
begin
  P032FCambiMW.P032DECORRENZAChange;
end;

procedure TP032FCambiDtM.selP032AfterScroll(DataSet: TDataSet);
begin
  P032FCambiMW.P032AfterScroll;
end;

procedure TP032FCambiDtM.BeforePost(DataSet: TDataSet);
begin
  P032FCambiMW.BeforePost;
  inherited;
end;

end.
