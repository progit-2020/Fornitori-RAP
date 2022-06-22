unit A110UParametriConteggioDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Math,
  Oracle, Db, OracleData, A000UCostanti, A000USessione,A000UInterfaccia, R004UGestStoricoDtM,
  C180FunzioniGenerali, Variants,  DBClient,
  A110USoglieRimborsiPasto, A110UParametriConteggioMW;

type
  TA110FParametriConteggioDtM = class(TR004FGestStoricoDtM)
    M010: TOracleDataSet;
    M010CalcArrotTariffaDopoRiduzione: TStringField;
    M010CalcArrotImportiDatiPaghe: TStringField;
    M010DECORRENZA: TDateTimeField;
    M010DESCRIZIONE: TStringField;
    M010OREMINIMEPERINDENNITA: TStringField;
    M010LIMITEORERETRIBUITEINTERE: TStringField;
    M010ARROTONDAMENTOORE: TFloatField;
    M010PERCRETRIBSUPEROORE: TFloatField;
    M010MAXGIORNIRETRMESE: TFloatField;
    COD: TFloatField;
    M010ARROTTARIFFADOPORIDUZIONE: TStringField;
    M010ARROTTOTIMPORTIDATIPAGHE: TStringField;
    M010TIPO: TStringField;
    M010RIDUZIONE_PASTO: TStringField;
    M010PERCRETRIBPASTO: TFloatField;
    M010CODICE: TStringField;
    M010TIPO_MISSIONE: TStringField;
    M010TARIFFAINDENNITA: TFloatField;
    M010TIPO_TARIFFA: TStringField;
    M010CODVOCEPAGHESUPHH: TStringField;
    M010CODVOCEPAGHESUPGG: TStringField;
    M010ORERIMBORSOPASTO: TStringField;
    M010TARIFFARIMBORSOPASTO: TFloatField;
    M010ORERIMBORSOPASTO2: TStringField;
    M010TARIFFARIMBORSOPASTO2: TFloatField;
    M010desc_tipomissione: TStringField;
    M010desc_codice: TStringField;
    M010CODVOCEPAGHEINTERA: TStringField;
    M010CODVOCEPAGHESUPHHGG: TStringField;
    M010CODICI_INDENNITAKM: TStringField;
    M010CODICI_RIMBORSI: TStringField;
    M010MAXMESIRIMB: TFloatField;
    M010DATARIF_VOCEPAGHE: TStringField;
    M010IND_DA_TAB_TARIFFE: TStringField;
    M010CAUSALE_MISSIONE: TStringField;
    dscCdsDistM013: TDataSource;
    cdsDistM013: TClientDataSet;
    M010GIUSTIF_HHMAX: TStringField;
    M010GIUSTIF_COPRE_DEBITOGG: TStringField;
    M010CalcCausale: TStringField;
    M010TIPO_RIMBORSOPASTO: TStringField;
    M010RIMB_KM_AUTO: TStringField;
    M010IND_KM_AUTO: TStringField;
    M010DESC_IND_KM_AUTO: TStringField;
    M010RIMB_KM_AUTO_MINIMO: TIntegerField;
    M010CODRIMBORSOPASTO: TStringField;
    procedure BeforePost(DataSet: TDataSet);override;
    procedure AfterPost(DataSet: TDataSet);override;
    procedure DataModuleCreate(Sender: TObject);
    procedure M010CalcFields(DataSet: TDataSet);
//    procedure M010OREMINIMEPERINDENNITAValidate(Sender: TField);
//    procedure M010LIMITEORERETRIBUITEINTEREValidate(Sender: TField);
//    procedure M010ARROTONDAMENTOOREValidate(Sender: TField);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure M010AfterScroll(DataSet: TDataSet);
    procedure M010AfterOpen(DataSet: TDataSet);
    procedure M010GIUSTIF_HHMAXValidate(Sender: TField);
  private
    function DataDecorrenzaSoglieRimborsiInput: String;
  public
    A110FParametriConteggioMW: TA110FParametriConteggioMW;
  end;

var
  A110FParametriConteggioDtM: TA110FParametriConteggioDtM;

implementation

uses A110UParametriConteggio;

{$R *.DFM}

procedure TA110FParametriConteggioDtM.DataModuleCreate(Sender: TObject);
//var C,S,T,Storico: String;
begin
  inherited;
  InterfacciaR004:=A110FParametriConteggio.InterfacciaR004;
  InizializzaDataSet(M010,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);

  A110FParametriConteggioMW:=TA110FParametriConteggioMW.Create(Self);
  A110FParametriConteggioMW.selM010_Funzioni:=M010;
  A110FParametriConteggioMW.DataSogliaRimborsiInput:=DataDecorrenzaSoglieRimborsiInput;

  M010.FieldByName('desc_codice').LookupDataSet:=A110FParametriConteggioMW.QSource;
  M010.FieldByName('desc_tipomissione').LookupDataSet:=A110FParametriConteggioMW.selM011;
  // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
  // descrizione codice indennità km automatico
  M010.FieldByName('DESC_IND_KM_AUTO').LookupDataSet:=A110FParametriConteggioMW.selM021;
  // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.fine

  (*
  if T <> 'T430_STORICO' then
  begin
    S:='SELECT CODICE, DESCRIZIONE FROM ' + T + ' ORDER BY CODICE';
  end
  else
  begin
    S:='SELECT DISTINCT ' + C + ' CODICE, '''' DESCRIZIONE FROM T430_STORICO';
  end;
  *)
//----------------------------------------------------------------
  A110FParametriConteggio.DButton.DataSet:=M010;
  M010.Open;
end;

procedure TA110FParametriConteggioDtM.FiltroDizionario(DataSet: TDataSet;
  var Accept: Boolean);
begin
  A110FParametriConteggioMW.FiltroDizionarioM010(DataSet,Accept);
end;

procedure TA110FParametriConteggioDtM.M010CalcFields(DataSet: TDataSet);
begin
  inherited;
  A110FParametriConteggioMW.M010CalcFields(DataSet);
end;

procedure TA110FParametriConteggioDtM.M010GIUSTIF_HHMAXValidate(Sender: TField);
begin
  if not Sender.IsNull then
    R180OraValidate(Sender.AsString);
end;
(* Caratto 09/10/2013 Mai richiamate
procedure TA110FParametriConteggioDtM.M010OREMINIMEPERINDENNITAValidate(
  Sender: TField);
begin
  if not Sender.IsNull then
    R180OraValidate(Sender.AsString);
end;

procedure TA110FParametriConteggioDtM.M010LIMITEORERETRIBUITEINTEREValidate(
  Sender: TField);
begin
  if not Sender.IsNull then
    R180OraValidate(Sender.AsString);
end;

procedure TA110FParametriConteggioDtM.M010ARROTONDAMENTOOREValidate(
  Sender: TField);
begin
  inherited;
  if (60 mod sender.AsInteger) <> 0 then
    raise Exception.Create('L''arrotondamento ore deve essere un divisore di 60.');
end;
*)
procedure TA110FParametriConteggioDtM.M010AfterOpen(DataSet: TDataSet);
begin
  inherited;
  A110FParametriConteggioMW.OpenselM013;
end;

procedure TA110FParametriConteggioDtM.M010AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if A110FParametriConteggioMW.IsCausalePresenza then
    A110FParametriConteggio.RGCausali.ItemIndex:=0
  else
    A110FParametriConteggio.RGCausali.ItemIndex:=1;

  //A110FParametriConteggio.RGCausaliClick(nil);

  // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
  // filtra dataset per indennità km automatica
  A110FParametriConteggioMW.OpenselM021RimbAuto;
  // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.fine

  A110FParametriConteggioMW.OpenselM013;
end;

procedure TA110FParametriConteggioDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A110FParametriConteggioMW);
  M010.Close;
end;

procedure TA110FParametriConteggioDtM.BeforePost(DataSet: TDataSet);
var msg:String;
begin
  Msg:=A110FParametriConteggioMW.ControlliFormali;
  if Msg <> '' then
  begin
    raise Exception.Create(Msg);
  end;
  //Controllo voci paghe
  Msg:=A110FParametriConteggioMW.VerificaVociPaghe('CODVOCEPAGHEINTERA');
  if Msg <> '' then
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Abort
    else
      A110FParametriConteggioMW.InserisciVocePaghe('CODVOCEPAGHEINTERA');

  Msg:=A110FParametriConteggioMW.VerificaVociPaghe('CODVOCEPAGHESUPHH');
  if Msg <> '' then
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Abort
    else
      A110FParametriConteggioMW.InserisciVocePaghe('CODVOCEPAGHESUPHH');

  Msg:=A110FParametriConteggioMW.VerificaVociPaghe('CODVOCEPAGHESUPGG');
  if Msg <> '' then
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Abort
    else
      A110FParametriConteggioMW.InserisciVocePaghe('CODVOCEPAGHESUPGG');

  msg:=A110FParametriConteggioMW.VerificaVociPaghe('CODVOCEPAGHESUPHHGG');
  if Msg <> '' then
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Abort
    else
      A110FParametriConteggioMW.InserisciVocePaghe('CODVOCEPAGHESUPHHGG');

  Msg:=A110FParametriConteggioMW.VerificaAltreRegole;
  if Msg <> '' then
  begin
    if mrYes <> R180MessageBox(msg,'DOMANDA') then
      Abort;
  end;

  A110FParametriConteggioMW.ImpostaCampiGiustif(A110FParametriConteggio.Assenza);
  inherited;
end;

procedure TA110FParametriConteggioDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A110FParametriConteggioMW.M010AfterPost;
end;

function TA110FParametriConteggioDtM.DataDecorrenzaSoglieRimborsiInput: String;
begin
  Result:=A110FSoglieRimborsiPasto.edtDecorrenza.Text;
end;

end.
