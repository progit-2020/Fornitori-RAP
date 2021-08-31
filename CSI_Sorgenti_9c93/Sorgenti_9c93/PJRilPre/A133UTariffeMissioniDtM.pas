unit A133UTariffeMissioniDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UCostanti,  A000UInterfaccia,
  C180FunzioniGenerali, Oracle, A133UTariffeMissioniMW;

type
  TA133FTariffeMissioniDtM = class(TR004FGestStoricoDtM)
    selM065: TOracleDataSet;
    selM065CODICE: TStringField;
    selM065COD_TARIFFA: TStringField;
    selM065DESCRIZIONE: TStringField;
    selM065IND_GIORNALIERA: TFloatField;
    selM065desc_trasferta: TStringField;
    selM065DECORRENZA: TDateTimeField;
    M066: TOracleDataSet;
    selM065VOCEPAGHE_ESENTE: TStringField;
    selM065VOCEPAGHE_ASSOG: TStringField;
    selM065DECORRENZA_FINE: TDateTimeField;
    procedure BeforePost(DataSet: TDataSet); Override;
    procedure AfterPost(DataSet: TDataSet); Override;
    procedure selM065AfterScroll(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforeInsert(DataSet: TDataSet); Override;
  private
    Storicizza: boolean;
  public
    A133FTariffeMissioniMW: TA133FTariffeMissioniMW;
  end;

var
  A133FTariffeMissioniDtM: TA133FTariffeMissioniDtM;

implementation

uses A133UTariffeMissioni;

{$R *.dfm}

procedure TA133FTariffeMissioniDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A133FTariffeMissioni.InterfacciaR004;
  InizializzaDataSet(selM065,[evBeforeEdit,
                             evBeforeInsert,
                             evBeforePost,
                             evBeforeDelete,
                             evAfterDelete,
                             evAfterPost,
                             evOnTranslateMessage]);

  A133FTariffeMissioniMW:=TA133FTariffeMissioniMW.Create(Self);
  A133FTariffeMissioniMW.selM065_Funzioni:=selM065;
  //va impostato a readonly per evitare l'autoedit della tabella figlio (operare con la toolbar apposita)
  A133FTariffeMissioniMW.selM066.ReadOnly:=True;
  selM065.FieldByName('desc_trasferta').LookupDataSet:=A133FTariffeMissioniMW.QSource;
  selM065.Open;
  A133FTariffeMissioni.DButton.DataSet:=selM065;

  A133FTariffeMissioniMW.TrovaCodice(A133FTariffeMissioni.ProgDip);
end;

procedure TA133FTariffeMissioniDtM.selM065AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A133FTariffeMissioniMW.RelazionaM066;
end;

procedure TA133FTariffeMissioniDtM.BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  A133FTariffeMissioniMW.selM065BeforeInsert;
end;

procedure TA133FTariffeMissioniDtM.AfterPost(DataSet: TDataSet);
//var OldCodice: String;
begin
  A133FTariffeMissioniMW.selM065AfterPost(Storicizza);
  inherited;
end;

procedure TA133FTariffeMissioniDtM.BeforePost(DataSet: TDataSet);
var CampoCodPaghe, Msg: String;
begin
  A133FTariffeMissioniMW.selM065BeforePost;

  //====================
  //CONTROLLO VOCI PAGHE
  //====================
  CampoCodPaghe:='VOCEPAGHE_ESENTE';
  Msg:=A133FTariffeMissioniMW.VerificaVociPaghe(CampoCodPaghe);
  if Msg <> '' then
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Abort
    else
      A133FTariffeMissioniMW.InserisciVocePaghe(CampoCodPaghe);

  CampoCodPaghe:='VOCEPAGHE_ASSOG';
  Msg:=A133FTariffeMissioniMW.VerificaVociPaghe(CampoCodPaghe);
  if Msg <> '' then
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Abort
    else
      A133FTariffeMissioniMW.InserisciVocePaghe(CampoCodPaghe);

  Storicizza:=InterfacciaR004.StoricizzazioneInCorso;
  inherited;
end;

procedure TA133FTariffeMissioniDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A133FTariffeMissioniMW);
  inherited;
  selM065.Close;
end;

end.
