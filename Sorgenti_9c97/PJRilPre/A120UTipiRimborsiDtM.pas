unit A120UTipiRimborsiDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGestStoricoDtM, DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  Variants, C180FunzioniGenerali, A120UTipiRimborsiMW;

type
  TA120FTIPIRIMBORSIDTM = class(TR004FGestStoricoDtM)
    M020: TOracleDataSet;
    M020CODICE: TStringField;
    M020DESCRIZIONE: TStringField;
    M020CODICEVOCEPAGHE: TStringField;
    M020SCARICOPAGHE: TStringField;
    M020ESISTENZAINDENNITASUPPL: TStringField;
    M020CODICEVOCEPAGHEINDENNITASUPPL: TStringField;
    M020SCARICOPAGHEINDENNITASUPPL: TStringField;
    M020PERCINDENNITASUPPL: TFloatField;
    M020ARROTINDENNITASUPPL: TStringField;
    M020CalcArrotIndennitaSuppl: TStringField;
    M020FLAG_ANTICIPO: TStringField;
    M020TIPO: TStringField;
    M020TIPO_QUANTITA: TStringField;
    M020PERC_ANTICIPO: TFloatField;
    M020NOTE_FISSE: TStringField;
    M020FLAG_MOTIVAZIONE: TStringField;
    M020FLAG_TARGA: TStringField;
    M020FLAG_MEZZO_PROPRIO: TStringField;
    M020FLAG_NON_RIMBORSABILE: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure DataModuleCreate(Sender: TObject);
    procedure M020CalcFields(DataSet: TDataSet);
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure M020AfterScroll(DataSet: TDataSet);
  public
    A120FTipiRimborsiMW: TA120FTipiRimborsiMW;
  end;

var
  A120FTIPIRIMBORSIDTM: TA120FTIPIRIMBORSIDTM;

implementation

USES A120UTipiRimborsi;

{$R *.DFM}

procedure TA120FTIPIRIMBORSIDTM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(M020,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePostNoStorico,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnTranslateMessage]);
  A120FTipiRimborsiMW:=TA120FTipiRimborsiMW.Create(Self);
  A120FTipiRimborsiMW.selM020_Funzioni:=M020;
  M020.Open;
  A120FTipiRimborsi.dgrdTipiExcelImp.DataSource:=A120FTipiRimborsiMW.dsrCSI003;
end;

procedure TA120FTIPIRIMBORSIDTM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A120FTipiRimborsiMW.selM020AfterDelete;
end;

procedure TA120FTIPIRIMBORSIDTM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A120FTipiRimborsiMW.selM020AfterPost;
end;

procedure TA120FTIPIRIMBORSIDTM.M020AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A120FTipiRimborsiMW.selM020AfterScroll;
end;

procedure TA120FTIPIRIMBORSIDTM.M020CalcFields(DataSet: TDataSet);
begin
  inherited;
  A120FTipiRimborsiMW.selM020CalcFields;
end;

procedure TA120FTIPIRIMBORSIDTM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A120FTipiRimborsiMW.selM020BeforeDelete;
end;

procedure TA120FTIPIRIMBORSIDTM.BeforePostNoStorico(DataSet: TDataSet);
var CampoCodPaghe, Msg:String;
begin
  inherited;
  A120FTipiRimborsiMW.Ins:=Dataset.State = dsInsert;
  //Controllo voci paghe
  CampoCodPaghe:='CODICEVOCEPAGHE';
  Msg:=A120FTipiRimborsiMW.VerificaVociPaghe(CampoCodPaghe);
  if Msg <> '' then
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Abort
    else
      A120FTipiRimborsiMW.InserisciVocePaghe(CampoCodPaghe);

  CampoCodPaghe:='CODICEVOCEPAGHEINDENNITASUPPL';
  Msg:=A120FTipiRimborsiMW.VerificaVociPaghe(CampoCodPaghe);
  if Msg <> '' then
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Abort
    else
      A120FTipiRimborsiMW.InserisciVocePaghe(CampoCodPaghe);
end;

procedure TA120FTIPIRIMBORSIDTM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A120FTipiRimborsiMW);
  inherited;
end;

end.
