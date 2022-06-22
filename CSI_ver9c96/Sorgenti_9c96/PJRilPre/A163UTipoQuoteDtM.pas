unit A163UTipoQuoteDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, C180FunzioniGenerali,
  A163UTipoQuoteMW;

type
  TA163FTipoQuoteDtM = class(TR004FGestStoricoDtM)
    selT765: TOracleDataSet;
    selT765CODICE: TStringField;
    selT765DESCRIZIONE: TStringField;
    selT765TIPOQUOTA: TStringField;
    selT765D_TIPOQUOTA: TStringField;
    selT765DECORRENZA: TDateTimeField;
    selT765CAUSALE_ASSESTAMENTO: TStringField;
    selT765VP_INTERA: TStringField;
    selT765VP_PROPORZIONATA: TStringField;
    selT765VP_NETTA: TStringField;
    selT765VP_NETTARISP: TStringField;
    selT765VP_RISPARMIO: TStringField;
    selT765VP_NORISPARMIO: TStringField;
    selT765VP_QUANTITATIVA: TStringField;
    selT765ACCONTI: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT765CalcFields(DataSet: TDataSet);
    procedure selT765AfterScroll(DataSet: TDataSet);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    A163FTipoQuoteMW: TA163FTipoQuoteMW;
  end;

var
  A163FTipoQuoteDtM: TA163FTipoQuoteDtM;

implementation

uses A163UTipoQuote;

{$R *.dfm}

procedure TA163FTipoQuoteDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A163FTipoQuote.InterfacciaR004;
  InizializzaDataSet(selT765,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);

  A163FTipoQuoteMW:=TA163FTipoQuoteMW.Create(Self);
  A163FTipoQuoteMW.selT765:=selT765;
end;

procedure TA163FTipoQuoteDtM.BeforePost(DataSet: TDataSet);
var Msg:String;
begin
  Msg:=A163FTipoQuoteMW.BeforePost;
  if Msg <> '' then
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Abort;

  Msg:=A163FTipoQuoteMW.VerificaVociPaghe;

  if Msg <> '' then
  begin
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Abort
    else
      A163FTipoQuoteMW.ValutaInserimentoVocePaghe;
  end;
  inherited;
end;

procedure TA163FTipoQuoteDtM.selT765AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A163FTipoQuote.drdgTipologiaChange(nil);
end;

procedure TA163FTipoQuoteDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A163FTipoQuoteMW.BeforeDelete(DataSet);
end;

procedure TA163FTipoQuoteDtM.selT765CalcFields(DataSet: TDataSet);
begin
  inherited;
  A163FTipoQuoteMW.selT765CalcFields(DataSet);
end;

end.
