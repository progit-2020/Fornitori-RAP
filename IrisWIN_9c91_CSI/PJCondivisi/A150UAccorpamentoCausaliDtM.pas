unit A150UAccorpamentoCausaliDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Oracle,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  A150UAccorpamentoCausaliMW;

type
  TA150FAccorpamentoCausaliDtM = class(TR004FGestStoricoDtM)
    selT256: TOracleDataSet;
    selT255: TOracleDataSet;
    dsrT255: TDataSource;
    selT256COD_TIPOACCORPCAUSALI: TStringField;
    selT256COD_CODICIACCORPCAUSALI: TStringField;
    selT256DESCRIZIONE: TStringField;
    selT255COD_TIPOACCORPCAUSALI: TStringField;
    selT255DESCRIZIONE: TStringField;
    selT256D_TIPOACCORPCAUSALI: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT256AfterScroll(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); Override;
    procedure selT255BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    A150MW: TA150FAccorpamentoCausaliMW;
  end;

var
  A150FAccorpamentoCausaliDtM: TA150FAccorpamentoCausaliDtM;

implementation

{$R *.dfm}

procedure TA150FAccorpamentoCausaliDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT256,[evBeforeEdit,
                             evBeforeInsert,
                             evBeforePostNoStorico,
                             evBeforeDelete,
                             evAfterDelete,
                             evAfterPost,
                             evOnTranslateMessage]);
  A150MW:=TA150FAccorpamentoCausaliMW.Create(Self);
  selT256.Open;
end;

procedure TA150FAccorpamentoCausaliDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if A150MW.Q257.RecordCount > 0 then
    raise exception.Create(A000MSG_A150_ERR_CANC_ACCORPAMENTO);
end;

procedure TA150FAccorpamentoCausaliDtM.selT255BeforePost(DataSet: TDataSet);
begin
  inherited;
  A150MW.VerificaAccorpamentoWeb(DataSet);
end;

procedure TA150FAccorpamentoCausaliDtM.selT256AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A150MW.RefreshQ257(selT256.FieldByName('COD_TIPOACCORPCAUSALI').AsString,selT256.FieldByName('COD_CODICIACCORPCAUSALI').AsString);
end;

end.
