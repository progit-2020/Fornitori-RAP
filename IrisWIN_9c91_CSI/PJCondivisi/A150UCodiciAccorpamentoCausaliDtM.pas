unit A150UCodiciAccorpamentoCausaliDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A150UAccorpamentoCausaliMW;

type
  TA150FCodiciAccorpamentoCausaliDtM = class(TR004FGestStoricoDtM)
    selT257: TOracleDataSet;
    selT257COD_TIPOACCORPCAUSALI: TStringField;
    selT257COD_CODICIACCORPCAUSALI: TStringField;
    selT257COD_CAUSALE: TStringField;
    selT257DECORRENZA: TDateTimeField;
    selT257DECORRENZA_FINE: TDateTimeField;
    selT257DESCRIZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); Override;
    procedure selT257CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    A150MW: TA150FAccorpamentoCausaliMW;
  end;

var
  A150FCodiciAccorpamentoCausaliDtM: TA150FCodiciAccorpamentoCausaliDtM;

implementation

uses A150UCodiciAccorpamentoCausali;

{$R *.dfm}

procedure TA150FCodiciAccorpamentoCausaliDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A150FCodiciAccorpamentoCausali.InterfacciaR004;
  InizializzaDataSet(selT257,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);
  A150FCodiciAccorpamentoCausali.DButton.DataSet:=selT257;
  A150MW:=TA150FAccorpamentoCausaliMW.Create(Self);
end;

procedure TA150FCodiciAccorpamentoCausaliDtM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  selT257.FieldByName('COD_TIPOACCORPCAUSALI').AsString:=A150FCodiciAccorpamentoCausali.edtCodTipoAccorpCausali.Text;
  selT257.FieldByName('COD_CODICIACCORPCAUSALI').AsString:=A150FCodiciAccorpamentoCausali.edtCodCodiciAccorpCausali.Text;
end;

procedure TA150FCodiciAccorpamentoCausaliDtM.selT257CalcFields(DataSet: TDataSet);
begin
  inherited;
  selT257.FieldByName('DESCRIZIONE').AsString:=A150MW.CalcDescrizione(selT257);
end;

end.
