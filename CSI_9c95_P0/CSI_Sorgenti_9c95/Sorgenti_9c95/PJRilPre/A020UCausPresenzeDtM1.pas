unit A020UCausPresenzeDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, A000UMessaggi, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants, A020UCausPresenzeMW, A020UCausPresenzeStoricoMW,
  System.Generics.Collections;

type
  TA020FCausPresenzeDtM1 = class(TDataModule)
    selT275: TOracleDataSet;
    selT275Codice: TStringField;
    selT275Descrizione: TStringField;
    selT275CodRaggr: TStringField;
    selT275TipoConteggio: TStringField;
    selT275RipFasce: TStringField;
    selT275OreNormali: TStringField;
    selT275Arrotondamento: TFloatField;
    selT275Stampe: TStringField;
    selT275Scostamento: TDateTimeField;
    selT275VocePaghe1: TStringField;
    selT275VocePaghe2: TStringField;
    selT275VocePaghe3: TStringField;
    selT275VocePaghe4: TStringField;
    selT275LIQUIDABILE: TStringField;
    selT275D_CodRaggr: TStringField;
    selT275DETREPERIB: TStringField;
    selT275RIPLIQ: TStringField;
    selT275MATURAMENSA: TStringField;
    selT275SIGLA: TStringField;
    selT275PIANIFREP: TStringField;
    selT275LFSCAVMEZ: TStringField;
    selT275MAXMINUTI: TIntegerField;
    selT275VOCEPAGHELIQ1: TStringField;
    selT275VOCEPAGHELIQ2: TStringField;
    selT275VOCEPAGHELIQ3: TStringField;
    selT275VOCEPAGHELIQ4: TStringField;
    selT275ABBATTE_BUDGET: TStringField;
    selT275RESIDUABILE: TStringField;
    selT275MINMINUTI: TIntegerField;
    selT275TIPO_MINMINIMI: TStringField;
    selT275TIPO_NONAUTORIZZATE: TStringField;
    selT275TIPO_U_NONAUTORIZZATE: TStringField;
    selT275GETTONE_TIPO_ORESUP: TStringField;
    selT275GETTONE_ORE: TStringField;
    selT275GETTONE_INDENNITA: TStringField;
    selT275GETTONE_SPEZZONI: TStringField;
    selT275GETTONE_TIPO_OREINF: TStringField;
    selT275LIMITE_DEBITOGG: TStringField;
    selT275SENZA_FLESSIBILITA: TStringField;
    selT275NO_LIMITE_MENSILE_LIQ: TStringField;
    selT275SCOST_PUNTI_NOMINALI: TStringField;
    selT275STACCO_MINIMO_SCOST: TStringField;
    selT275NO_ECCEDENZA_IN_FASCIA: TStringField;
    selT275LINK_ASSENZA: TStringField;
    selT275D_LINK_ASSENZA: TStringField;
    selT275COMPETENZE_AUTOGIUST: TStringField;
    selT275ESCLUSIONE_FASCIA_OBB: TStringField;
    selT275FLESSIBILITA_ORARIO: TStringField;
    selT275SOGLIA_FASCE_OBBLFAC: TIntegerField;
    selT275RESIDUO_LIQUIDABILE: TStringField;
    selT275CAUS_FUORI_TURNO: TStringField;
    selT275PERC_INAIL: TStringField;
    selT275GETTONE_DALLE: TStringField;
    selT275GETTONE_ALLE: TStringField;
    selT275TIMB_PM: TStringField;
    selT275INCLUDI_INDTURNO: TStringField;
    selT275ARROT_RIEPGG: TStringField;
    selT275ARROT_RIEPGG_ORENORM: TStringField;
    selT275ARROT_RIEPGG_FASCE: TStringField;
    selT275E_IN_FLESSIBILITA: TStringField;
    selT275AUTOGIUST_DALLEALLE: TStringField;
    selT275UM_INSERIMENTO_H: TStringField;
    selT275UM_INSERIMENTO_D: TStringField;
    selT275COMP_CAUS_OREMAX: TStringField;
    selT275AUTOCOMPLETAMENTO_UE: TStringField;
    selT275TIPO_RICHIESTA_WEB: TStringField;
    selT275CONSIDERA_SCELTA_ORARIO: TStringField;
    selT275FLEX_TIMBR_CAUS: TStringField;
    selT275INCLUSIONE_SALDI_CAUSALI: TStringField;
    selT275FORZA_NOTTE_SPEZZATA: TStringField;
    selT275CAUSALIZZA_TIMB_INTERSECANTI: TStringField;
    selT275TIMB_PM_DETRAZ: TStringField;
    selT275PERIODICITA_ABBATTIMENTO: TIntegerField;
    selT275GIUST_DAA_TIMB: TStringField;
    selT275CUMULA_RICHIESTE_WEB: TStringField;
    selT275INTERSEZIONE_TIMBRATURE: TStringField;
    selT275SEMPRE_APPOGGIATA: TStringField;
    selT275NO_ECCED_IN_FASCIA_CONS_ASS: TStringField;
    selT275CAUSCOMP_DEBITOGG: TStringField;
    selT275ID: TIntegerField;
    procedure selT275ScostamentoGetText(Sender: TField; var Text: string;DisplayText: Boolean);
    procedure BDET275ArrotondamentoValidate(Sender: TField);
    procedure selT275BeforePost(DataSet: TDataSet);
    procedure BDET275ScostamentoSetText(Sender: TField; const Text: string);
    procedure A020FCausPresenzeDtM1Create(Sender: TObject);
    procedure BDET275CodiceValidate(Sender: TField);
    procedure A020FCausPresenzeDtM1Destroy(Sender: TObject);
    procedure selT275BeforeDelete(DataSet: TDataSet);
    procedure selT275AfterPost(DataSet: TDataSet);
    procedure selT275AfterDelete(DataSet: TDataSet);
    procedure selT275AfterScroll(DataSet: TDataSet);
    procedure selT275AfterCancel(DataSet: TDataSet);
    procedure selT275FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT275RESIDUABILEValidate(Sender: TField);
    procedure selT275GETTONE_OREValidate(Sender: TField);
    procedure selT275CodRaggrChange(Sender: TField);
  private
    procedure ShowMessage(Msg: String);
    procedure ControlloVociPagheBeforeDelete(Msg: String);
    procedure ControlloVociPagheBeforePost(Msg: String);
    procedure CheckGrdTipoGiorno(TipoGiorno: String);
  public
    A020MW:TA020FCausPresenzeMW;
    A020StoricoMW:TA020FCausPresenzeStoricoMW;    
    procedure SvuotaGrigliaDatiStoriciz;
    procedure PreparaDataSetParamStorici;
    procedure AggiornaGrigliaDatiStoriciz(DataPeriodo:TDateTime);
  end;

var
  A020FCausPresenzeDtM1: TA020FCausPresenzeDtM1;

implementation

uses A020UCausPresenze;

{$R *.DFM}

procedure TA020FCausPresenzeDtM1.A020FCausPresenzeDtM1Create(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  A020MW:=TA020FCausPresenzeMW.Create(Self);
  A020MW.SelT275:=SelT275;
  A020MW.CheckTipoGiorno:=CheckGrdTipoGiorno;
  A020MW.ShowCustomMessage:=ShowMessage;
  A020MW.ControlloVociPagheBeforeDelete:=ControlloVociPagheBeforeDelete;
  A020MW.ControlloVociPagheBeforePost:=ControlloVociPagheBeforePost;
  A020MW.InizializzaDataSet;
  A020StoricoMW:=TA020FCausPresenzeStoricoMW.Create(Self);
  selT275.Open;
end;

procedure TA020FCausPresenzeDtM1.BDET275ArrotondamentoValidate(Sender: TField);
begin
  A020MW.ValidataArrotondamento(Sender);
end;

procedure TA020FCausPresenzeDtM1.selT275BeforePost(DataSet: TDataSet);
{Controllo che il codice non sia già usato per altre causali}
var VoceOld:String;
begin
  with A020MW do
  begin
    T275BeforePostStep1;
    // Controllo voci paghe
    // voce paghe 1
    if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHE1').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=selT275.FieldByName('VOCEPAGHE1').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHE1').AsString) then
      if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
        Abort
      else
        selControlloVociPaghe.ValutaInserimentoVocePaghe(selT275.FieldByName('VOCEPAGHE1').AsString);
    // voce paghe 2
    if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHE2').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=selT275.FieldByName('VOCEPAGHE2').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHE2').AsString) then
      if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
        Abort
      else
        selControlloVociPaghe.ValutaInserimentoVocePaghe(selT275.FieldByName('VOCEPAGHE2').AsString);
    // voce paghe 3
    if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHE3').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=selT275.FieldByName('VOCEPAGHE3').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHE3').AsString) then
      if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
        Abort
      else
        selControlloVociPaghe.ValutaInserimentoVocePaghe(selT275.FieldByName('VOCEPAGHE3').AsString);
    // voce paghe 4
    if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHE4').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=selT275.FieldByName('VOCEPAGHE4').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHE4').AsString) then
      if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
        Abort
      else
        selControlloVociPaghe.ValutaInserimentoVocePaghe(selT275.FieldByName('VOCEPAGHE4').AsString);
    // voce paghe liq. 1
    if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHELIQ1').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=selT275.FieldByName('VOCEPAGHELIQ1').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHELIQ1').AsString) then
      if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
        Abort
      else
        selControlloVociPaghe.ValutaInserimentoVocePaghe(selT275.FieldByName('VOCEPAGHELIQ1').AsString);
    // voce paghe liq. 2
    if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHELIQ2').OldValue = null) then
      VoceOld:=''
    else
      VoceOld:=selT275.FieldByName('VOCEPAGHELIQ2').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHELIQ2').AsString) then
      if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
        Abort
      else
        selControlloVociPaghe.ValutaInserimentoVocePaghe(selT275.FieldByName('VOCEPAGHELIQ2').AsString);
    // voce paghe liq. 3
    if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHELIQ3').OldValue = null) then
      VoceOld:=''
    else
      VoceOld:=selT275.FieldByName('VOCEPAGHELIQ3').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHELIQ3').AsString) then
      if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
        Abort
      else
        selControlloVociPaghe.ValutaInserimentoVocePaghe(selT275.FieldByName('VOCEPAGHELIQ3').AsString);
    // voce paghe liq. 4
    if (DataSet.State = dsInsert) or (selT275.FieldByName('VOCEPAGHELIQ4').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=selT275.FieldByName('VOCEPAGHELIQ4').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,selT275.FieldByName('VOCEPAGHELIQ4').AsString) then
      if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
        Abort
      else
        selControlloVociPaghe.ValutaInserimentoVocePaghe(selT275.FieldByName('VOCEPAGHELIQ4').AsString);
    if not selT275.FieldByName('ARROT_RIEPGG').IsNull then
      R180OraValidate(selT275.FieldByName('ARROT_RIEPGG').AsString);
    //Log
    case DataSet.State of
      dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
      dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    end;
    T275BeforePostStep2;
  end;
end;

procedure TA020FCausPresenzeDtM1.BDET275ScostamentoSetText(Sender: TField;const Text: string);
begin
  A020MW.ValidataCampoOra(Sender,Text);
end;

procedure TA020FCausPresenzeDtM1.BDET275CodiceValidate(Sender: TField);
begin
  A020MW.T275CodiceValidate;
end;

procedure TA020FCausPresenzeDtM1.A020FCausPresenzeDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  //FreeAndNil(selControlloVociPaghe); MW
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  if A020MW <> nil then
    FreeAndNil(A020MW);
end;

procedure TA020FCausPresenzeDtM1.selT275BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  A020MW.T275BeforeDelete;
end;

procedure TA020FCausPresenzeDtM1.selT275AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  A020MW.T275AfterPost;
end;

procedure TA020FCausPresenzeDtM1.selT275AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA020FCausPresenzeDtM1.selT275AfterScroll(DataSet: TDataSet);
begin
  A020MW.T275AfterScroll;
  A020FCausPresenze.cmbDecParStor.Items.Clear;
  SvuotaGrigliaDatiStoriciz;
  if (selT275.State <> dsInsert) and (not A020FCausPresenze.CopiaInCorso) and
     (selT275.RecordCount > 0) then
  begin
    PreparaDataSetParamStorici;
    AggiornaGrigliaDatiStoriciz(Parametri.DataLavoro);
  end;
end;

procedure TA020FCausPresenzeDtM1.selT275AfterCancel(DataSet: TDataSet);
begin
  A020MW.T275AfterCancel;
end;

procedure TA020FCausPresenzeDtM1.selT275FilterRecord(DataSet: TDataSet;var Accept: Boolean);
begin
  A020MW.FilterRecord(DataSet,Accept);
end;

procedure TA020FCausPresenzeDtM1.selT275RESIDUABILEValidate(Sender: TField);
begin
  OreMinutiValidate(Sender.AsString);
end;

procedure TA020FCausPresenzeDtM1.selT275GETTONE_OREValidate(Sender: TField);
begin
  R180OraValidate(Sender.AsString);
end;

procedure TA020FCausPresenzeDtM1.selT275CodRaggrChange(Sender: TField);
begin
  A020FCausPresenze.AbilitazioneControlli(Sender);
end;

procedure TA020FCausPresenzeDtM1.selT275ScostamentoGetText(Sender: TField;var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA020FCausPresenzeDtM1.ShowMessage(Msg: String);
begin
  ShowMessage(Msg);
end;

procedure TA020FCausPresenzeDtM1.CheckGrdTipoGiorno(TipoGiorno: String);
begin
  if R180IndexOf(A020FCausPresenze.dGrdFasce.Columns[0].Picklist,TipoGiorno,1) = -1 then
    raise Exception.Create(A000MSG_A020_ERR_TIPO_GIORNO);
end;

procedure TA020FCausPresenzeDtM1.ControlloVociPagheBeforeDelete(Msg: String);
begin
  if R180MessageBox(Msg,'DOMANDA') = mrNo then
    Abort;
end;

procedure TA020FCausPresenzeDtM1.ControlloVociPagheBeforePost(Msg: String);
begin
  if R180MessageBox(Msg,'DOMANDA') = mrNo then
    Abort
  else
    A020MW.SelControlloVociPaghe.ValutaInserimentoVocePaghe(A020MW.selT276.FieldByName('VOCEPAGHE').AsString);
end;

procedure TA020FCausPresenzeDtM1.SvuotaGrigliaDatiStoriciz;
var
  I:Integer;
begin
  // Svuoto la tabella
  for I:=1 to (A020FCausPresenze.grdParamStoriciz.RowCount - 1) do
  begin
    A020FCausPresenze.grdParamStoriciz.Cells[0,I]:='';
    A020FCausPresenze.grdParamStoriciz.Cells[1,I]:='';
    A020FCausPresenze.grdParamStoriciz.Cells[2,I]:='';
    A020FCausPresenze.grdParamStoriciz.Cells[3,I]:='';
  end;
  A020FCausPresenze.grdParamStoriciz.FixedRows:=1;
  A020FCausPresenze.grdParamStoriciz.RowCount:=2;
end;

procedure TA020FCausPresenzeDtM1.PreparaDataSetParamStorici;
var
  ElencoDecorrenze:TArray<TDateTime>;
  I,IdCausale:Integer;
begin
  IdCausale:=selT275.FieldByName('ID').AsInteger;
  A020StoricoMW.Inizializza(IdCausale);
  A020StoricoMW.ApriT235;

  if A020StoricoMW.selT235.RecordCount = 0 then
  begin
    // Se per qualche motivo nella tabella dei parametri storicizzati non è presente
    // neanche un record corrispondente a questa causale, ne creiamo uno di default.
    A020StoricoMW.ChiudiT235;
    A020StoricoMW.CreaRecordVuoto(IdCausale);
    A020StoricoMW.ApriT235;
  end;

  // Controlli decorrenza parametri storicizzati
  A020StoricoMW.ElaboraArrayDecorrenze(Parametri.DataLavoro);

  A020FCausPresenze.chkVistaPeriodoCorr.Checked:=False;
  A020FCausPresenze.ToggleControlliSchedaParStor(False);
  if A020StoricoMW.selT235.RecordCount > 0 then
  begin
    // Combo date decorrenza
    ElencoDecorrenze:=A020StoricoMW.Decorrenze;
    for I:=0 to (Length(ElencoDecorrenze) - 1) do
    begin
      A020FCausPresenze.cmbDecParStor.Items.Add(DateToStr(ElencoDecorrenze[I])); // Uso il FormatSettings globale
    end;
    A020FCausPresenze.cmbDecParStor.ItemIndex:=A020StoricoMW.IndiceDecorrenzaCorrente;
  end;
  A020FCausPresenze.ToggleControlliSchedaParStor(True);
end;

// Questo metodo va necessariamente eseguito dal DM, dato che il DM è sempre in grado
// di accedere al form principale, mentre il form principale alla prima apertura
// non è ancora in grado di accedere al DM (è già instanziato, ma il richiamo avviene prima
// che l'indirizzo sia salvato nella variabile globale).
procedure TA020FCausPresenzeDtM1.AggiornaGrigliaDatiStoriciz(DataPeriodo:TDateTime);
var
  StoriaDati:TObjectList<TA020ElementoListaStorico>;
  Elemento:TA020ElementoListaStorico;
  I:Integer;
begin
  A020StoricoMW.ElaboraStoriaDati(DataPeriodo);
  StoriaDati:=A020StoricoMW.StoriaDati;
  if StoriaDati <> nil then
  begin
    A020FCausPresenze.grdParamStoriciz.RowCount:=StoriaDati.Count + 1;
    for I:=0 to (StoriaDati.Count - 1) do
    begin
      Elemento:=StoriaDati.Items[I];
      A020FCausPresenze.grdParamStoriciz.Cells[0,I+1]:=Elemento.Descrizione;
      A020FCausPresenze.grdParamStoriciz.Cells[1,I+1]:=DateToStr(Elemento.Decorrenza);
      A020FCausPresenze.grdParamStoriciz.Cells[2,I+1]:=DateToStr(Elemento.FineDecorrenza);
      A020FCausPresenze.grdParamStoriciz.Cells[3,I+1]:=Elemento.DescValoreDato;
    end;
  end;
end;

end.
