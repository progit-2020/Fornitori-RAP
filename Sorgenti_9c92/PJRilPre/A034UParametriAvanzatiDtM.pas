unit A034UParametriAvanzatiDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICODTM, Db, OracleData, Oracle, A000UInterfaccia, Variants,
  DBCtrls, C180FunzioniGenerali, A000UCostanti, A000USessione,
  A034UParametriAvanzatiMW,A000UMessaggi;

type
  TA034FParametriAvanzatiDtM = class(TR004FGestStoricoDtM)
    selT193: TOracleDataSet;
    selT193VOCE_PAGHE: TStringField;
    selT193VOCE_PAGHE_NEGATIVA: TStringField;
    selT193DESCRIZIONE: TStringField;
    selT193DAL: TDateTimeField;
    selT193AL: TDateTimeField;
    selT193AUTOINC_DAL: TStringField;
    selT193AUTOINC_AL: TStringField;
    selT193COD_INTERFACCIA: TStringField;
    selT193DECORRENZA: TDateTimeField;
    selT193VOCE_PAGHE_CEDOLINO: TStringField;
    selT193DESC_VPAGHE_NEGATIVA: TStringField;
    selT193DESC_VPAGHE_CEDOLINO: TStringField;
    selT195: TOracleQuery;
    selT193ARROTONDAMENTO: TFloatField;
    selT193FORMULA: TStringField;
    selT193SPOSTA_VALIMP: TStringField;
    procedure selT193DALSetText(Sender: TField; const Text: string);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure selT193DALGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    A034FParametriAvanzatiMW: TA034FParametriAvanzatiMW;
  end;

var
  A034FParametriAvanzatiDtM: TA034FParametriAvanzatiDtM;

implementation

uses A034UParametriAvanzati;

{$R *.DFM}

procedure TA034FParametriAvanzatiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A034FParametriAvanzatiMW:=TA034FParametriAvanzatiMW.Create(Self);
  InterfacciaR004:=A034FParametriAvanzati.InterfacciaR004;
  InizializzaDataSet(selT193,[evBeforeEdit,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evBeforeInsert,
                              evAfterPost,
                              evOnTranslateMessage]);
  selT193.Open;
  A034FParametriAvanzati.DButton.DataSet:=selT193;

  //Caricamento interfaccia
  if A034FParametriAvanzatiMW.ImpostaSelInterfaccia(InterfacciaR004.DataLavoro) then
  begin
    A034FParametriAvanzati.lblInterfaccia.Caption:=Parametri.CampiRiferimento.C9_ScaricoPaghe;
    selT193.FieldByName('COD_INTERFACCIA').DisplayLabel:=Parametri.CampiRiferimento.C9_ScaricoPaghe;
  end
  else
  begin
    A034FParametriAvanzati.lblInterfaccia.Caption:='<INTERFACCIA UNICA>';
    selT193.FieldByName('COD_INTERFACCIA').DisplayLabel:='Interfaccia';
  end;
  A034FParametriAvanzati.dCmbInterfaccia.ListSource:=A034FParametriAvanzatiMW.dsrInterfaccia;
end;

procedure TA034FParametriAvanzatiDtM.selT193DALGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    Text:=''
  else
    Text:=FormatDateTime('mm/yyyy',Sender.AsDateTime);
end;

procedure TA034FParametriAvanzatiDtM.BeforePost(DataSet: TDataSet);
var
  VoceOld, ErrMsg: String;
begin
  // inizio validità
  if (not selT193.FieldByName('DAL').IsNull) and
    (selT193.FieldByName('DAL').AsDateTime < selT193.FieldByName('DECORRENZA').AsDateTime) then
  begin
    selT193.FieldByName('DAL').FocusControl;
    raise exception.Create(A000MSG_A034_ERR_DATA_INIZIO_VALIDITA);
  end;
  // fine validità
  if (not selT193.FieldByName('AL').IsNull) and
    (selT193.FieldByName('AL').AsDateTime < selT193.FieldByName('DECORRENZA').AsDateTime) then
  begin
    selT193.FieldByName('AL').FocusControl;
    raise exception.Create(A000MSG_A034_ERR_DATA_FINE_VALIDITA);
  end;
  // voce paghe cedolino
  if (DataSet.State = dsInsert) or (selT193.FieldByName('VOCE_PAGHE_CEDOLINO').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=selT193.FieldByName('VOCE_PAGHE_CEDOLINO').medpOldValue;
  // formula
  if not A034FParametriAvanzatiMW.VerificaFormula(A034FParametriAvanzati.dedtFormula.Text,ErrMsg) then
  begin
    selT193.FieldByName('FORMULA').FocusControl;
    raise Exception.Create(ErrMsg);
  end;
  if not A034FParametriAvanzatiMW.selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT193.FieldByName('VOCE_PAGHE_CEDOLINO').AsString) then
    if R180MessageBox(A034FParametriAvanzatiMW.selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
    begin
      A034FParametriAvanzatiMW.selControlloVociPaghe.Storicizzazione:=False;
      Abort;
    end;
  A034FParametriAvanzatiMW.selControlloVociPaghe.Storicizzazione:=False;
  inherited;
end;

procedure TA034FParametriAvanzatiDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A034FParametriAvanzatiMW);
  inherited;
end;

procedure TA034FParametriAvanzatiDtM.selT193DALSetText(Sender: TField;
  const Text: string);
begin
  if Trim(Text) <> '/' then
    Sender.AsString:='01/' + Text;
  if Trim(Text) = '/' then
    Sender.Clear;
end;

end.
