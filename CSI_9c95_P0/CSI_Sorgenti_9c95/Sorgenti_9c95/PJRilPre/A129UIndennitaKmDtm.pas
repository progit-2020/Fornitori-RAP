unit A129UIndennitaKmDtm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData,  C180FunzioniGenerali,
  A129UIndennitaKmMW;

type
  TA129FIndennitaKmDtm = class(TR004FGestStoricoDtM)
    SelM021: TOracleDataSet;
    SelM021CODICE: TStringField;
    SelM021DESCRIZIONE: TStringField;
    SelM021DECORRENZA: TDateTimeField;
    SelM021IMPORTO: TFloatField;
    SelM021ARROTONDAMENTO: TStringField;
    SelM021descarrotondamento: TStringField;
    SelM021CODVOCEPAGHE: TStringField;
    SelM021DECORRENZA_FINE: TDateTimeField;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure DataModuleCreate(Sender: TObject);
    procedure SelM021CalcFields(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  public
    A129FIndennitaKmMW: TA129FIndennitaKmMW;
  end;

var
  A129FIndennitaKmDtm: TA129FIndennitaKmDtm;

implementation

uses A129UIndennitaKm;

{$R *.dfm}

procedure TA129FIndennitaKmDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A129FIndennitaKm.InterfacciaR004;
  InizializzaDataSet(SelM021,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);
  A129FIndennitaKmMW:=TA129FIndennitaKmMW.Create(Self);
  A129FIndennitaKmMW.selM021_Funzioni:=SelM021;
  SelM021.FieldByName('descarrotondamento').LookupDataSet:=A129FIndennitaKmMW.selP050;

  A129FIndennitaKm.DButton.DataSet:=SelM021;
  SelM021.Open;
end;

procedure TA129FIndennitaKmDtm.SelM021CalcFields(DataSet: TDataSet);
begin
  A129FIndennitaKmMW.selM021CalcFields;
end;

procedure TA129FIndennitaKmDtm.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A129FIndennitaKmMW);
  SelM021.Close;
end;

procedure TA129FIndennitaKmDtm.BeforePost(DataSet: TDataSet);
var CampoCodPaghe,Msg:String;
begin
  //Controllo voci paghe
  CampoCodPaghe:='CODVOCEPAGHE';
  Msg:=A129FIndennitaKmMW.VerificaVociPaghe(CampoCodPaghe);
  if Msg <> '' then
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Abort
    else
      A129FIndennitaKmMW.InserisciVocePaghe(CampoCodPaghe);
  inherited;
end;

end.
