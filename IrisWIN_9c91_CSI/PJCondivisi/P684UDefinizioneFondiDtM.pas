unit P684UDefinizioneFondiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, Oracle, OracleData, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia;

type
  TP684FDefinizioneFondiDtM = class(TR004FGestStoricoDtM)
    selP684: TOracleDataSet;
    dsrP684Ricerca: TDataSource;
    selP684Ricerca: TOracleDataSet;
    dsrP684Dec: TDataSource;
    selP684Dec: TOracleDataSet;
    selP684COD_FONDO: TStringField;
    selP684DECORRENZA_DA: TDateTimeField;
    selP684DECORRENZA_A: TDateTimeField;
    selP684DESCRIZIONE: TStringField;
    selP684COD_MACROCATEG: TStringField;
    selP684COD_RAGGR: TStringField;
    selP684DATA_COSTITUZ: TDateTimeField;
    selP684FILTRO_DIPENDENTI: TStringField;
    selP684DATA_ULTIMO_MONIT: TDateTimeField;
    selP680: TOracleDataSet;
    dsrP680: TDataSource;
    selP682: TOracleDataSet;
    dsrP682: TDataSource;
    selP686: TOracleDataSet;
    dsrP686: TDataSource;
    selP686COD_FONDO: TStringField;
    selP686DECORRENZA_DA: TDateTimeField;
    selP686CLASS_VOCE: TStringField;
    selP686COD_VOCE_GEN: TStringField;
    selP686DESCRIZIONE: TStringField;
    selP686TIPO_VOCE: TStringField;
    selP686ORDINE_STAMPA: TFloatField;
    selP688R: TOracleDataSet;
    dsrP688R: TDataSource;
    selP688RCOD_FONDO: TStringField;
    selP688RDECORRENZA_DA: TDateTimeField;
    selP688RCLASS_VOCE: TStringField;
    selP688RCOD_VOCE_GEN: TStringField;
    selP688RCOD_VOCE_DET: TStringField;
    selP688RDESCRIZIONE: TStringField;
    selP688RDATA_RIFERIMENTO: TDateTimeField;
    selP688RQUANTITA: TFloatField;
    selP688RDATOBASE: TFloatField;
    selP688RMOLTIPLICATORE: TFloatField;
    selP688RIMPORTO: TFloatField;
    selP688RCOD_ARROTONDAMENTO: TStringField;
    selP688RFILTRO_DIPENDENTI: TStringField;
    selP688RCODICI_ACCORPAMENTOVOCI: TStringField;
    selP686Tipo: TOracleDataSet;
    dsrP050: TDataSource;
    selP215: TOracleDataSet;
    selP684Controllo: TOracleQuery;
    selP688Tot: TOracleQuery;
    selP688D: TOracleDataSet;
    StringField10: TStringField;
    DateTimeField3: TDateTimeField;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    DateTimeField4: TDateTimeField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    FloatField9: TFloatField;
    StringField15: TStringField;
    StringField16: TStringField;
    StringField17: TStringField;
    dsrP688D: TDataSource;
    selP688RDescVoceGen: TStringField;
    selP688DDescVoceGen: TStringField;
    selP500: TOracleDataSet;
    selP050: TOracleDataSet;
    selP690: TOracleDataSet;
    selP200: TOracleDataSet;
    selP690COD_FONDO: TStringField;
    selP690DECORRENZA_DA: TDateTimeField;
    selP690CLASS_VOCE: TStringField;
    selP690COD_VOCE_GEN: TStringField;
    selP690COD_VOCE_DET: TStringField;
    selP690DATA_RETRIBUZIONE: TDateTimeField;
    selP690COD_CONTRATTO: TStringField;
    selP690COD_VOCE: TStringField;
    selP690IMPORTO: TFloatField;
    selP690Descrizione: TStringField;
    selP210: TOracleDataSet;
    selP210COD_CONTRATTO: TStringField;
    selP210DESCRIZIONE: TStringField;
    selP690A: TOracleDataSet;
    dsrP690A: TDataSource;
    selP686Importo: TFloatField;
    ScriptSQL: TOracleScript;
    procedure DataModuleCreate(Sender: TObject);
    procedure selP684AfterScroll(DataSet: TDataSet);
    procedure selP688RBeforePost(DataSet: TDataSet);
    procedure selP688RAfterScroll(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selP688DAfterScroll(DataSet: TDataSet);
    procedure selP686NewRecord(DataSet: TDataSet);
    procedure selP688RNewRecord(DataSet: TDataSet);
    procedure selP688DNewRecord(DataSet: TDataSet);
    procedure selP688DBeforePost(DataSet: TDataSet);
    procedure selP688DAfterPost(DataSet: TDataSet);
    procedure selP688DAfterDelete(DataSet: TDataSet);
    procedure selP688DBeforeDelete(DataSet: TDataSet);
    procedure selP690CalcFields(DataSet: TDataSet);
    procedure selP690NewRecord(DataSet: TDataSet);
    procedure selP690BeforePost(DataSet: TDataSet);
    procedure selP690DATA_RETRIBUZIONEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure selP690DATA_RETRIBUZIONESetText(Sender: TField;
      const Text: string);
    procedure selP690ACalcFields(DataSet: TDataSet);
    procedure selP686CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P684FDefinizioneFondiDtM: TP684FDefinizioneFondiDtM;

implementation

uses P684UDefinizioneFondi, P684UDettaglioRisorse, P684UDettaglioDestin,
  P684UGenerale;

{$R *.dfm}

procedure TP684FDefinizioneFondiDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if selP684.FieldByName('DECORRENZA_DA').IsNull then
  begin
    P684FDefinizioneFondi.dedtDecorrenza.SetFocus;
    raise exception.Create('Specificare la data di decorrenza!');
  end;
  if selP684.FieldByName('DECORRENZA_A').IsNull then
  begin
    P684FDefinizioneFondi.dedtScadenza.SetFocus;
    raise exception.Create('Specificare la data di scadenza!');
  end;
  if selP684.FieldByName('COD_FONDO').IsNull then
  begin
    P684FDefinizioneFondi.dedtCodFondo.SetFocus;
    raise exception.Create('Specificare il codice fondo!');
  end;
  if selP684.FieldByName('DECORRENZA_A').AsDateTime < selP684.FieldByName('DECORRENZA_DA').AsDateTime then
  begin
    P684FDefinizioneFondi.dedtScadenza.SetFocus;
    raise exception.Create('La scadenza deve essere maggiore o uguale della decorrenza!');
  end;
  //Controllo intersezione decorrenze
  selP684Controllo.SetVariable('COD',selP684.FieldByName('COD_FONDO').AsString);
  selP684Controllo.SetVariable('DEC',selP684.FieldByName('DECORRENZA_DA').AsDateTime);
  selP684Controllo.SetVariable('FINE',selP684.FieldByName('DECORRENZA_A').AsDateTime);
  if selP684.State = dsInsert then
    selP684Controllo.SetVariable('RIGA','0')
  else
    selP684Controllo.SetVariable('RIGA',selP684.RowId);
  selP684Controllo.Execute;
  if StrToIntDef(VarToStr(selP684Controllo.Field(0)),0) > 0 then
  begin
    P684FDefinizioneFondi.dedtDecorrenza.SetFocus;
    raise exception.Create('Attenzione: periodi intersecanti! Specificare una nuova validità!');
  end;
end;

procedure TP684FDefinizioneFondiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selP684,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selP684.AfterScroll:=nil;
  selP684.Open;
  selP684.AfterScroll:=selP684AfterScroll;
  selP680.Open;
  selP682.Open;
  ScriptSQL.Session:=SessioneOracle;
end;

procedure TP684FDefinizioneFondiDtM.selP684AfterScroll(DataSet: TDataSet);
begin
  inherited;
  P684FDefinizioneFondi.dcmbMacroCategCloseUp(nil);
  P684FDefinizioneFondi.dcmbRaggrCloseUp(nil);
  selP500.Close;
  selP500.SetVariable('Anno',R180Anno(selP684.FieldByName('DECORRENZA_DA').AsDateTime));
  selP500.Open;
  selP050.Close;
  selP050.SetVariable('CODVALUTA',selP500.FieldByName('COD_VALUTA').AsString);
  selP050.SetVariable('DECORRENZA',selP684.FieldByName('DECORRENZA_DA').AsDateTime);
  selP050.Open;
  selP688Tot.SetVariable('COD',selP684.FieldByName('COD_FONDO').AsString);
  selP688Tot.SetVariable('DEC',selP684.FieldByName('DECORRENZA_DA').AsDateTime);
  selP688Tot.SetVariable('FILTRO',' ');
  selP688Tot.Execute;
  P684FDefinizioneFondi.edtTotRisorse.Text:=Format('%15.0n',[StrToFloatDef(VarToStr(selP688Tot.Field(0)),0)]);
  P684FDefinizioneFondi.edtTotSpeso.Text:=Format('%15.0n',[StrToFloatDef(VarToStr(selP688Tot.Field(1)),0)]);
  P684FDefinizioneFondi.edtTotResiduo.Text:=Format('%15.0n',[StrToFloatDef(VarToStr(selP688Tot.Field(2)),0)]);
end;

procedure TP684FDefinizioneFondiDtM.selP686CalcFields(DataSet: TDataSet);
begin
  inherited;
  if selP686.FieldByName('CLASS_VOCE').AsString = 'R' then
  begin
    selP688Tot.SetVariable('COD',selP686.FieldByName('COD_FONDO').AsString);
    selP688Tot.SetVariable('DEC',selP686.FieldByName('DECORRENZA_DA').AsDateTime);
    selP688Tot.SetVariable('FILTRO',' AND CLASS_VOCE =''R'' AND COD_VOCE_GEN = ''' + selP686.FieldByName('COD_VOCE_GEN').AsString + '''');
    selP688Tot.Execute;
    selP686.FieldByName('IMPORTO').AsFloat:=StrToFloatDef(VarToStr(selP688Tot.Field(0)),0);
  end
  else
  begin
    selP688Tot.SetVariable('COD',selP686.FieldByName('COD_FONDO').AsString);
    selP688Tot.SetVariable('DEC',selP686.FieldByName('DECORRENZA_DA').AsDateTime);
    selP688Tot.SetVariable('FILTRO',' AND CLASS_VOCE =''D'' AND COD_VOCE_GEN = ''' + selP686.FieldByName('COD_VOCE_GEN').AsString + '''');
    selP688Tot.Execute;
    selP686.FieldByName('IMPORTO').AsFloat:=StrToFloatDef(VarToStr(selP688Tot.Field(1)),0);
  end;
end;

procedure TP684FDefinizioneFondiDtM.selP686NewRecord(DataSet: TDataSet);
begin
  inherited;
  if P684FGenerale <> nil then
  begin
    selP686.FieldByName('COD_FONDO').AsString:=P684FGenerale.FondoElab;
    selP686.FieldByName('DECORRENZA_DA').AsDateTime:=P684FGenerale.DataElab;
    selP686.FieldByName('CLASS_VOCE').AsString:=P684FGenerale.TipoElab;
  end;
end;

procedure TP684FDefinizioneFondiDtM.selP688DAfterDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TP684FDefinizioneFondiDtM.selP688DAfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TP684FDefinizioneFondiDtM.selP688DAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if P684FDettaglioDestin <> nil then
    P684FDettaglioDestin.dcmbCodVoceGenCloseUp(nil);
end;

procedure TP684FDefinizioneFondiDtM.selP688DBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TP684FDefinizioneFondiDtM.selP688DBeforePost(DataSet: TDataSet);
begin
  inherited;
  if selP688D.FieldByName('COD_ARROTONDAMENTO').AsString = '' then
    R180MessageBox('Attenzione: il codice Arrotondamento non è stato indicato. Il dato viene comunque salvato',INFORMA)
  else
  begin
    if selP050.SearchRecord('Cod_Arrotondamento',selP688D.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
      (selP688D.FieldByName('IMPORTO').AsFloat <> 0) then
      selP688D.FieldByName('IMPORTO').AsFloat:=
        R180Arrotonda(selP688D.FieldByName('IMPORTO').AsFloat,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
  end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TP684FDefinizioneFondiDtM.selP688DNewRecord(DataSet: TDataSet);
begin
  inherited;
  if P684FDettaglioDestin <> nil then
  begin
    selP688D.FieldByName('COD_FONDO').AsString:=P684FDettaglioDestin.FondoElab;
    selP688D.FieldByName('DECORRENZA_DA').AsDateTime:=P684FDettaglioDestin.DataElab;
    selP688D.FieldByName('CLASS_VOCE').AsString:='D';
  end;
end;

procedure TP684FDefinizioneFondiDtM.selP688RAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if P684FDettaglioRisorse <> nil then
  begin
    P684FDettaglioRisorse.dcmbCodVoceGenCloseUp(nil);
    P684FDettaglioRisorse.dedtImporto.ReadOnly:=False;
    if (not selP688R.FieldByName('QUANTITA').IsNull) or (not selP688R.FieldByName('DATOBASE').IsNull) or
       (not selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
      P684FDettaglioRisorse.dedtImporto.ReadOnly:=True;
  end;
end;

procedure TP684FDefinizioneFondiDtM.selP688RBeforePost(DataSet: TDataSet);
begin
  inherited;
  if P684FDettaglioRisorse = nil then
    Exit;
  if ((not selP688R.FieldByName('QUANTITA').IsNull) or (not selP688R.FieldByName('MOLTIPLICATORE').IsNull)) and
      (selP688R.FieldByName('DATOBASE').IsNull) then
  begin
    P684FDettaglioRisorse.dedtDatoBase.SetFocus;
    raise exception.Create('Specificare il dato base!');
  end;
  if ((not selP688R.FieldByName('QUANTITA').IsNull) or (not selP688R.FieldByName('DATOBASE').IsNull)) and
      (selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
  begin
    P684FDettaglioRisorse.dedtMoltiplicatore.SetFocus;
    raise exception.Create('Specificare il moltiplicatore!');
  end;
  if ((not selP688R.FieldByName('DATOBASE').IsNull) or (not selP688R.FieldByName('MOLTIPLICATORE').IsNull)) and
      (selP688R.FieldByName('QUANTITA').IsNull) then
  begin
    P684FDettaglioRisorse.dedtQuantita.SetFocus;
    raise exception.Create('Specificare la quantità!');
  end;
  if (not selP688R.FieldByName('QUANTITA').IsNull) or (not selP688R.FieldByName('DATOBASE').IsNull) or
     (not selP688R.FieldByName('MOLTIPLICATORE').IsNull) then
    selP688R.FieldByName('IMPORTO').AsFloat:=selP688R.FieldByName('QUANTITA').AsFloat *
     selP688R.FieldByName('DATOBASE').AsFloat * selP688R.FieldByName('MOLTIPLICATORE').AsFloat;
  if selP688R.FieldByName('COD_ARROTONDAMENTO').AsString = '' then
    R180MessageBox('Attenzione: il codice Arrotondamento non è stato indicato. Il dato viene comunque salvato',INFORMA)
  else
  begin
    if selP050.SearchRecord('Cod_Arrotondamento',selP688R.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
      (selP688R.FieldByName('IMPORTO').AsFloat <> 0) then
      selP688R.FieldByName('IMPORTO').AsFloat:=
        R180Arrotonda(selP688R.FieldByName('IMPORTO').AsFloat,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
  end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TP684FDefinizioneFondiDtM.selP688RNewRecord(DataSet: TDataSet);
begin
  inherited;
  if P684FDettaglioRisorse <> nil then
  begin
    selP688R.FieldByName('COD_FONDO').AsString:=P684FDettaglioRisorse.FondoElab;
    selP688R.FieldByName('DECORRENZA_DA').AsDateTime:=P684FDettaglioRisorse.DataElab;
    selP688R.FieldByName('CLASS_VOCE').AsString:='R';
  end;
end;

procedure TP684FDefinizioneFondiDtM.selP690ACalcFields(DataSet: TDataSet);
begin
  inherited;
  if selP690A.FindField('DESCRIZIONE') <> nil then
  begin
    selP200.Close;
    selP200.SetVariable('CODCONTR',selP690A.FieldByName('COD_CONTRATTO').AsString);
    selP200.SetVariable('CODVOCE',selP690A.FieldByName('COD_VOCE').AsString);
    selP200.SetVariable('DEC',StrToDate(VarToStr(selP690A.GetVariable('DEC'))));
    selP200.Open;
    if selP200.RecordCount > 0 then
      selP690A.FieldByName('Descrizione').AsString:=selP200.FieldByName('DESCRIZIONE').AsString
    else
      selP690A.FieldByName('Descrizione').AsString:='';
  end;
end;

procedure TP684FDefinizioneFondiDtM.selP690BeforePost(DataSet: TDataSet);
begin
  inherited;
  if selP690.FieldByName('DATA_RETRIBUZIONE').IsNull then
    raise exception.Create('Specificare data retribuzione!');
  if selP690.FieldByName('COD_CONTRATTO').IsNull then
    raise exception.Create('Specificare codice contratto!');
  if selP690.FieldByName('COD_VOCE').IsNull then
    raise exception.Create('Specificare codice voce!');
end;

procedure TP684FDefinizioneFondiDtM.selP690CalcFields(DataSet: TDataSet);
begin
  inherited;
  selP200.Close;
  selP200.SetVariable('CODCONTR',selP690.FieldByName('COD_CONTRATTO').AsString);
  selP200.SetVariable('CODVOCE',selP690.FieldByName('COD_VOCE').AsString);
  selP200.SetVariable('DEC',selP690.FieldByName('DECORRENZA_DA').AsDateTime);
  selP200.Open;
  if selP200.RecordCount > 0 then
    selP690.FieldByName('Descrizione').AsString:=selP200.FieldByName('DESCRIZIONE').AsString
  else
    selP690.FieldByName('Descrizione').AsString:='';
end;

procedure TP684FDefinizioneFondiDtM.selP690DATA_RETRIBUZIONEGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    Text:=''
  else
    Text:=FormatDateTime('mm/yyyy',Sender.AsDateTime);
end;

procedure TP684FDefinizioneFondiDtM.selP690DATA_RETRIBUZIONESetText(
  Sender: TField; const Text: string);
begin
  inherited;
  if Trim(Text) <> '/' then
    Sender.AsString:=FormatDateTime('dd/mm/yyyy',R180FineMese(StrToDate('01/' + Text)))
  else
    Sender.Clear;
end;

procedure TP684FDefinizioneFondiDtM.selP690NewRecord(DataSet: TDataSet);
begin
  inherited;
  selP690.FieldByName('COD_FONDO').AsString:=selP688D.FieldByName('COD_FONDO').AsString;
  selP690.FieldByName('DECORRENZA_DA').AsDateTime:=selP688D.FieldByName('DECORRENZA_DA').AsDateTime;
  selP690.FieldByName('CLASS_VOCE').AsString:='D';
  selP690.FieldByName('COD_VOCE_GEN').AsString:=selP688D.FieldByName('COD_VOCE_GEN').AsString;
  selP690.FieldByName('COD_VOCE_DET').AsString:=selP688D.FieldByName('COD_VOCE_DET').AsString;
end;

end.
