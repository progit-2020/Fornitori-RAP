unit P150USetupDtM;

interface

uses
  Windows, Messages, SysUtils, Math, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData, A000UCostanti, A000USessione,A000UInterfaccia, R004UGestStoricoDtM,
  Crtl, DBClient, Variants, C180FUNZIONIGENERALI, P150USetupMW;

type
  TP150FSetupDtM = class(TR004FGestStoricoDtM)
    selP150: TOracleDataSet;
    selP150DECORRENZA: TDateTimeField;
    selP150COD_PAGAMENTO: TStringField;
    selP150COD_VALUTA_BASE: TStringField;
    selP150COD_VALUTA_STAMPA: TStringField;
    selP150NUM_DEC_PERC: TIntegerField;
    selP150BLOCCO_DETR_IRPEF: TStringField;
    selP150NUM_DEC_QUANTITA: TIntegerField;
    selP150TIPO_ORE: TStringField;
    selP150DES_BASE: TStringField;
    selP150DES_STAMPA: TStringField;
    selP150DES_PAGAM: TStringField;
    selP150COD_COMUNE_INAIL: TStringField;
    selP150D_COMUNE_INAIL: TStringField;
    selP150ULTIMO_ANNO_RECUP: TIntegerField;
    selP150COD_VALUTA_CONT: TStringField;
    selP150DES_CONT: TStringField;
    selP150DECORRENZA_FINE: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selP150CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    P150FSetupMW: TP150FSetupMW;
  end;

var
  P150FSetupDtM: TP150FSetupDtM;

implementation

uses P150USetup;

{$R *.DFM}

procedure TP150FSetupDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=P150FSetup.InterfacciaR004;
  InizializzaDataSet(selP150,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);
  //Leggo i comuni dalla tabella locale
  P150FSetup.DButton.DataSet:=selP150;
  P150FSetupMW:=TP150FSetupMW.Create(Self);
  P150FSetupMW.selP150:=selP150;
  selP150D_COMUNE_INAIL.LookupDataSet:=P150FSetupMW.T480_COMUNI;
  selP150.Open;
end;

procedure TP150FSetupDtM.selP150CalcFields(DataSet: TDataSet);
begin
  inherited;
  P150FSetupMW.P150CalcFields;
end;

end.
