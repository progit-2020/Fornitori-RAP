unit A006UModelliOrarioDtM1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UInterfaccia, C180FunzioniGenerali,
  Oracle, A000UCostanti, A000USessione, A000UMessaggi, DBClient, A006UModelliOrarioMW;

type
  TA006FModelliOrarioDtM1 = class(TR004FGestStoricoDtM)
    selT020: TOracleDataSet;
    selT020CODICE: TStringField;
    selT020DECORRENZA: TDateTimeField;
    selT020DESCRIZIONE: TStringField;
    selT020TIPOORA: TStringField;
    selT020PERLAV: TStringField;
    selT020TIPOFLE: TStringField;
    selT020OBBLFAC: TStringField;
    selT020ORETEOR: TStringField;
    selT020OREMIN: TStringField;
    selT020OREMAX: TStringField;
    selT020COMPDETR: TStringField;
    selT020ARRFUOENT: TStringField;
    selT020ARRFUOUSC: TStringField;
    selT020ARRPOS: TStringField;
    selT020ARRNEG: TStringField;
    selT020TOLLPRES: TStringField;
    selT020MMINDPRES: TStringField;
    selT020FLAGPRES: TStringField;
    selT020COMPNOT: TStringField;
    selT020MMINDMPRES: TStringField;
    selT020FLAGMPRES: TStringField;
    selT020FRAZDEB: TStringField;
    selT020NOTTEENTRATA: TStringField;
    selT020MIN_USCITA_NOTTE: TStringField;
    selT020INDFESTIVA: TStringField;
    selT020OREINDFEST: TStringField;
    selT020INDTURNO: TStringField;
    selT020MATURA_RIPCOM: TStringField;
    selT020TIPOMENSA: TStringField;
    selT020CAUOBFAC: TStringField;
    selT020MMMINIMI: TStringField;
    selT020MINPERCORR: TStringField;
    selT020TIMBRATURAMENSA: TStringField;
    selT020INTERSEZIONEMENSA: TStringField;
    selT020PAUSAMENSA_AUTOMATICA: TStringField;
    selT020PM_AUTO_URIT: TStringField;
    selT020DETRAUTCONT: TStringField;
    selT020RIENTRO_MINIMO: TStringField;
    selT020COMPFASCIA: TStringField;
    selT020TUTTOCOMP: TStringField;
    selT020MINSCOSTR: TStringField;
    selT020ORAMAX_COMPENSABILE: TStringField;
    selT020ARRSCOSTR: TStringField;
    selT020ARRSCOSTR_COMP: TStringField;
    selT020COMPLIQ: TStringField;
    selT020MINIMISTR: TStringField;
    selT020ARRIVRANG: TStringField;
    selT020MINGIOSTR: TStringField;
    selT020ARROTGIOR: TStringField;
    selT020MAXGIOSTR: TStringField;
    selT020INTERUSC: TStringField;
    selT020STR_DOPO_HHMAX: TStringField;
    selT020INDPRESSTR: TStringField;
    selT020INDFESTSTR: TStringField;
    selT020INDNOTSTR: TStringField;
    selT020CARENZA_OBB_NO_LIQ: TStringField;
    selT020RICALCOLO_DEBITO_GG: TStringField;
    selT020RICALCOLO_MIN: TStringField;
    selT020RICALCOLO_MAX: TStringField;
    selT020ARR_ECCED_LIQ: TStringField;
    selT020PAUSAMENSA_ESTERNA: TStringField;
    selT020REGOLE_PROFILO: TStringField;
    selT020ECC_COMP_CAUSALIZZATA: TStringField;
    selT020STRRIPFASCE: TStringField;
    selT020COPERTURA_CARENZA: TStringField;
    selT020ARR_ECCED_FASCE: TStringField;
    selT020ARROT_COMP: TStringField;
    selT020ARR_TIMB_INTERNE: TStringField;
    selT020ARR_ECC_FASCE_COMP: TStringField;
    selT020PM_RECUP_USCITA: TStringField;
    selT020TIMBRATURAMENSA_INTERNA: TStringField;
    selT020PMT_TIMB_AUTORIZZATE: TStringField;
    selT020PMA_PRESERVA_TIMBINFASCIA: TStringField;
    selT020SCOSTGG_MIN_SOGLIA: TStringField;
    selT020PMT_TOLLERANZA: TStringField;
    selT020DEBITO_RIPCOM: TStringField;
    selT020TIMBRATURAMENSA_DETRAZIONE: TStringField;
    selT020PMT_TIMB_MATURAMENSA: TStringField;
    selT020PMT_SOLO_TIMBMENSA: TStringField;
    selT020TIMBRATURAMENSA_DETRTOT: TStringField;
    selT020PM_OREMINIME_INF: TStringField;
    selT020PM_STACCO_INF: TStringField;
    selT020MINIMISTR_COMP: TStringField;
    selT020CAUSALE_FASCE: TStringField;
    selT020RICALCOLO_SPOSTA_PN: TStringField;
    selT020RICALCOLO_OFF_NOTIMB: TStringField;
    selT020PMT_LIMITE_FLEX: TStringField;
    selT020RICALCOLO_DEB_MIN: TStringField;
    selT020RICALCOLO_DEB_MAX: TStringField;
    selT020RICALCOLO_CAUS_NEG: TStringField;
    selT020RICALCOLO_CAUS_POS: TStringField;
    selT020TIMBRATURAMENSA_FLEX: TStringField;
    selT020XPARAM: TStringField;
    selT020SPEZZNONCAUS_SCARTOECC: TStringField;
    selT020FLEXDOPOMEZZANOTTE: TStringField;
    selT020INTERSEZ_AUTOGIUST: TStringField;
    selT020RIPCOM_GGNONLAV: TStringField;
    selT020PMT_NOTIMBCONSECUTIVE: TStringField;
    selT020PMT_USCITARIT: TStringField;
    selT020CAUSALI_ECCEDENZA: TStringField;
    selT020ARRSCOSTR_SOTTOSOGLIA: TStringField;
    selT020RIENTRO_POMERIDIANO: TStringField;
    selT020FESTLAV_LIQ: TStringField;
    selT020FESTLAV_CMP_LIQ: TStringField;
    selT020FESTLAV_CMP_LIQ_TURN: TStringField;
    selT020CAUSALE_DISABIL_BLOCCANTE: TStringField;
    selT020FASCIA_NOTTFEST_COMPLETA: TStringField;
    selT020INDFESTIVA_USA_NOTTE_COMPLETA: TStringField;
    selT020MAXSCOSTR: TStringField;
    selT020POSTICIPA_CAUS_TIMB_INTERSEC: TStringField;
    selT020ANOM_BLOCC_23LIV: TStringField;
    selT020CAUSALI_ECCCOMP: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure ValidateOreMinuti(Sender: TField);
    procedure selT020AfterScroll(DataSet: TDataSet);
    procedure selT020AfterCancel(DataSet: TDataSet);
    procedure selT020FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    procedure InizializzaGrdFasce;
    function T020FieldValue(Field: String):String;
    function GetCmbTipoMensaValue:String;
    function IsStoricoOttimizzato:Boolean;
  public
    A006MW: TA006FModelliOrarioMW;
  end;

{$IFNDEF IRISWEB}
var
  A006FModelliOrarioDtM1: TA006FModelliOrarioDtM1;
{$ENDIF IRISWEB}

implementation

uses A006UModelliOrario, DBGrids;

{$R *.dfm}

procedure TA006FModelliOrarioDtM1.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A006FModelliOrario.InterfacciaR004;
  InizializzaDataSet(selT020,[evBeforeInsert,
                           evBeforePost,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnNewRecord,
                           evOnTranslateMessage]);

  A006MW:=TA006FModelliOrarioMW.Create(Self);
  A006MW.selT020:=selT020;
  A006MW.evT021AfterOpen:=InizializzaGrdFasce;
  A006MW.evT020FieldValue:=T020FieldValue;
  A006MW.evGetCmbTipoMensaValue:=GetCmbTipoMensaValue;
  A006MW.evStoricoOttimizzato:=IsStoricoOttimizzato;
  selT020.Open;
end;

procedure TA006FModelliOrarioDtM1.selT020AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A006MW.SelT020fterScroll;
end;

procedure TA006FModelliOrarioDtM1.BeforePost(DataSet: TDataSet);
begin
  A006MW.ResetVariabili;
  //Conferma della registrazione se sono abilitate le modifiche sugli storici precedenti/successivi
  if (InterfacciaR004.chkStoriciPrec.Checked or InterfacciaR004.chkStoriciSucc.Checked) and
     ((A006MW.selT021PN.UpdatesPending) or (A006MW.selT021PM.UpdatesPending) or (A006MW.selT021STR.UpdatesPending)) then
    if MessageDlg(A000MSG_A006_DLG_CONFERMA_REGISTRAZIONE,mtInformation,[mbYes,mbNo],0) <> mrYes then
      Abort;

  if (A006MW.selT020.State = dsEdit) and (A006MW.selT020.FieldByName('CODICE').Value <> A006MW.selT020.FieldByName('CODICE').medpOldValue) then
    if MessageDlg(A000MSG_A006_DLG_CONFERMA_MODIFICA_COD,mtConfirmation,[mbYes,mbNo],0) <> mrYes then
      Abort;

  A006MW.SelT020BeforePost;
  inherited;
end;

procedure TA006FModelliOrarioDtM1.AfterPost(DataSet: TDataSet);
begin
  A006MW.SelT020AfterPostStep1;
  inherited;
  A006MW.SelT020AfterPostStep2;
end;

procedure TA006FModelliOrarioDtM1.selT020AfterCancel(DataSet: TDataSet);
begin
  A006MW.SelT020AfterCancel;
end;

procedure TA006FModelliOrarioDtM1.ValidateOreMinuti(Sender: TField);
begin
  A006MW.ValidateOreMinuti(Sender);
end;

procedure TA006FModelliOrarioDtM1.selT020FilterRecord(DataSet: TDataSet;var Accept: Boolean);
begin
  A006MW.selT020FilterRecord(DataSet,Accept);
end;

function TA006FModelliOrarioDtM1.T020FieldValue(Field: String): String;
begin
  Result:=selT020.FieldByName(Field).AsString;
end;

function TA006FModelliOrarioDtM1.GetCmbTipoMensaValue: String;
begin
  Result:=A006FModelliOrario.dcmbTipoMensa.Text;
end;

procedure TA006FModelliOrarioDtM1.InizializzaGrdFasce;
{Inizializzazione delle griglie delle fasce}
var i:Integer;
begin
  with A006FModelliOrario do
  begin
    for i:=0 to dgrdTimbrature.Columns.Count - 1 do
      if dgrdTimbrature.Columns[i].FieldName = 'TIPO_FASCIA' then
      begin
        R180SetComboItemsValues(dgrdTimbrature.Columns[i].PickList,A006Mw.D_TipoFasciaTimbrature,'V');
        Break;
      end;
    for i:=0 to dgrdPausaMensa.Columns.Count - 1 do
      if dgrdPausaMensa.Columns[i].FieldName = 'TIPO_FASCIA' then
      begin
        R180SetComboItemsValues(dgrdPausaMensa.Columns[i].PickList,A006Mw.D_TipoFasciaPausaMensa,'V');
        Break;
      end;
    for i:=0 to dgrdStraordinario.Columns.Count - 1 do
      if dgrdStraordinario.Columns[i].FieldName = 'TIPO_FASCIA' then
      begin
        R180SetComboItemsValues(dgrdStraordinario.Columns[i].PickList,A006Mw.D_TipoFasciaStraordinario,'V');
        Break;
      end;
  end;
end;

function TA006FModelliOrarioDtM1.IsStoricoOttimizzato: Boolean;
begin
  Result:=StoricoOttimizzato;
end;

end.
