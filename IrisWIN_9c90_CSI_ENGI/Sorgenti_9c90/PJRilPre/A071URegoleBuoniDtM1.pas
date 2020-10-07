unit A071URegoleBuoniDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants,A000UMessaggi;

type
  TA071FRegoleBuoniDtM1 = class(TDataModule)
    DSource: TDataSource;
    QTabs: TOracleDataSet;
    QSource: TOracleDataSet;
    Q670: TOracleDataSet;
    Q670CODICE: TStringField;
    Q670PASTO_TICKET: TStringField;
    Q670ASSENZA: TStringField;
    Q670PRESENZA: TStringField;
    Q670OREMINIME: TDateTimeField;
    Q670CAUS_TICKET: TStringField;
    Q670DA1: TDateTimeField;
    Q670A1: TDateTimeField;
    Q670DA2: TDateTimeField;
    Q670A2: TDateTimeField;
    Q670D_Codice: TStringField;
    Q670NONLAVORATIVO: TStringField;
    Q670FORZAMATURAZIONE: TStringField;
    Q670INIBMATURAZIONE: TStringField;
    Q670ORARISPEZZATI: TStringField;
    Q265: TOracleDataSet;
    Q275: TOracleDataSet;
    Q305: TOracleDataSet;
    Q670INTERVALLOMIN: TStringField;
    Q670INTERVALLOMAX: TStringField;
    Q670MESE_ASSENZE: TIntegerField;
    Q670ORE_MATTINA: TStringField;
    Q670ORE_POMERIGGIO: TStringField;
    Q670CONGUAGLIO_MAX: TIntegerField;
    Q670PERIODICITA_ACQUISTO: TStringField;
    Q670ACQUISTO_TEORICO: TStringField;
    Q670HHMIN_ACQUISTO: TStringField;
    Q670ASSENZE_ACQUISTO: TStringField;
    Q670MEDIAMAX_ACQUISTO: TIntegerField;
    Q670MEDIAMIN_ACQUISTO: TIntegerField;
    Q670ACCESSI_MENSA: TStringField;
    Q670ACQUISTO_MINIMO: TIntegerField;
    Q670RESTITUZIONE_MAX: TIntegerField;
    Q670PAUSA_MENSA: TStringField;
    Q670MISSIONI: TStringField;
    Q670DEBITO_GIORN_MIN: TStringField;
    Q670GIORNI_FISSI: TStringField;
    Q670ECCEDENZA_MIN: TStringField;
    Q670NUM_MAX_BUONI: TIntegerField;
    Q670CONGUAGLIO_PREC_MAX: TIntegerField;
    Q670RESIDUO_PRECEDENTE: TDateTimeField;
    Q670OREMIN_NETTOPM: TStringField;
    Q670INIZIO_POMERIGGIO: TStringField;
    Q670PAUSA_MENSA_GESTITA: TStringField;
    Q670OREMINIME_FASCE: TStringField;
    Q670INTERVALLO_EFFETTIVO: TStringField;
    Q670FASCIA1_ESCLUSIVA: TStringField;
    Q670REGOLA_SUCCESSIVA: TStringField;
    Q670D_RegolaSuccessiva: TStringField;
    selT670lkp: TOracleDataSet;
    dsrT670lkp: TDataSource;
    Q670FASCE_MATPOM_PMT: TStringField;
    Q670REGOLA_RIENTRO_POMERIDIANO: TStringField;
    Q670RIENTRO_MASSIMO_PM: TStringField;
    Q670ESTENDI_INTERVALLO_PMT: TStringField;
    Q670ASSENZE_TOLL_PERC: TStringField;
    Q670PERC_TOLL_ASSENZE: TFloatField;
    Q670OREMINIME_SECONDOBUONO: TStringField;
    Q670DA3: TStringField;
    Q670A3: TStringField;
    Q670OREMINIME_FASCIA3: TStringField;
    Q670GGLAV_SEMPRE_CALENDARIO: TStringField;
    Q670GGLAV_NOPIANIF_CALENDARIO: TStringField;
    Q670ASSENZE_DIMINUZIONE_INCLUSE: TStringField;
    Q670INTERVALLO_INTERNO_PMT: TStringField;
    Q670CONSIDERA_GGSUCC: TStringField;
    Q670ORARI_INIBITI: TStringField;
    selT020: TOracleDataSet;
    procedure Q670OREMINIMEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure A071FRegoleBuoniDtM1Create(Sender: TObject);
    procedure Q670NewRecord(DataSet: TDataSet);
    procedure BDEQ670OREMINIMESetText(Sender: TField; const Text: String);
    procedure Q670AfterCancel(DataSet: TDataSet);
    procedure Q670AfterPost(DataSet: TDataSet);
    procedure Q670AfterDelete(DataSet: TDataSet);
    procedure Q670BeforePost(DataSet: TDataSet);
    procedure Q670BeforeDelete(DataSet: TDataSet);
    procedure Q670INTERVALLOMINValidate(Sender: TField);
    procedure Q670AfterScroll(DataSet: TDataSet);
    procedure Q670DEBITO_GIORN_MINValidate(Sender: TField);
    procedure Q670ECCEDENZA_MINValidate(Sender: TField);
    procedure Q670A2GetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    procedure GetPeriodicitaAcquisto;
  public
    { Public declarations }
  end;

var
  A071FRegoleBuoniDtM1: TA071FRegoleBuoniDtM1;

implementation

uses A071URegoleBuoni;

{$R *.DFM}

procedure TA071FRegoleBuoniDtM1.A071FRegoleBuoniDtM1Create(
  Sender: TObject);
var i:Integer;
    //S,T,C,Storico:String;
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
  A071FRegoleBuoni.lblCodice.Caption:=Parametri.CampiRiferimento.C4_BuoniMensa;
  QSource.Close;
  if A000LookupTabella(Parametri.CampiRiferimento.C4_BuoniMensa,QSource) then
  begin
    if QSource.VariableIndex('DECORRENZA') >= 0 then
      QSource.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    QSource.Open;
  end
  else
  begin
    ShowMessage(A000MSG_A071_ERR_DATO_NON_SPECIF);
    Q670.ReadOnly:=True;
  end;
  selT020.Open;
  Q265.Open;
  Q275.Open;
  Q305.Open;
  A071FRegoleBuoni.DButton.DataSet:=Q670;
  Q670.Open;
end;

procedure TA071FRegoleBuoniDtM1.Q670NewRecord(DataSet: TDataSet);
begin
  Q670.FieldByName('PASTO_TICKET').AsString:='B';
  Q670.FieldByName('NONLAVORATIVO').AsString:='N';
  Q670.FieldByName('ORARISPEZZATI').AsString:='N';
  Q670.FieldByName('OREMINIME').AsDateTime:=EncodeDate(1900,1,1);
  A071FRegoleBuoni.edtResiduoPrecedente.DateTime:=Q670.FieldByName('RESIDUO_PRECEDENTE').AsDateTime;
end;

procedure TA071FRegoleBuoniDtM1.BDEQ670OREMINIMESetText(Sender: TField;
  const Text: String);
begin
  {$I CampoOra}
end;

procedure TA071FRegoleBuoniDtM1.Q670A2GetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' 
  else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA071FRegoleBuoniDtM1.Q670AfterCancel(DataSet: TDataSet);
begin
  Q670.CancelUpdates;
  GetPeriodicitaAcquisto;
  A071FRegoleBuoni.edtResiduoPrecedente.DateTime:=Q670.FieldByName('RESIDUO_PRECEDENTE').AsDateTime;
end;

procedure TA071FRegoleBuoniDtM1.Q670AfterPost(DataSet: TDataSet);
var S:String;
begin
  S:=Q670.FieldByName('CODICE').AsString;
  SessioneOracle.ApplyUpdates([Q670],True);
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
  Q670.Locate('CODICE',S,[]);
end;

procedure TA071FRegoleBuoniDtM1.Q670AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([Q670],True);
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
end;

procedure TA071FRegoleBuoniDtM1.Q670BeforePost(DataSet: TDataSet);
var i:Integer;
    S,AssenzeRipetute:String;
begin
  S:='NNNNNNNNNNNN';
  with A071FRegoleBuoni.chklstMesiAcq do
    for i:=0 to Items.Count - 1 do
      if Checked[i] then
        S[i + 1]:='S';
  Q670PERIODICITA_ACQUISTO.AsString:=S;
  S:='';
  with A071FRegoleBuoni.clbGiorniFissi do
    for i:=0 to Items.Count - 1 do
      if Checked[i] then
        S:=S + IntToStr(i + 1);
  Q670GIORNI_FISSI.AsString:=S;
  Q670NUM_MAX_BUONI.AsString:=A071FRegoleBuoni.edtNumMaxBuoni.Text;
  if A071FRegoleBuoni.edtResiduoPrecedente.Date = 0 then
    Q670Residuo_Precedente.Clear
  else
    Q670Residuo_Precedente.AsDateTime:=R180InizioMese(Trunc(A071FRegoleBuoni.edtResiduoPrecedente.Date));
  if QueryPK1.EsisteChiave('T670_REGOLEBUONI',Q670.RowId,Q670.State,['CODICE'],[Q670Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  if not(Q670Da1.IsNull) and not(Q670A1.IsNull) then
    if Q670Da1.AsDateTime >= Q670A1.AsDateTime then
      raise Exception.Create('L''intervallo della 1°fascia di maturazione non è valido!');
  if not(Q670Da2.IsNull) and not(Q670A2.IsNull) then
    if Q670Da2.AsDateTime >= Q670A2.AsDateTime then
      raise Exception.Create('L''intervallo della 2°fascia di maturazione non è valido!');
  if (not Q670.FieldByName('OREMINIME_FASCIA3').IsNull and (Q670.FieldByName('DA3').IsNull or Q670.FieldByName('A3').IsNull))
  or (not Q670.FieldByName('DA3').IsNull and (Q670.FieldByName('OREMINIME_FASCIA3').IsNull or Q670.FieldByName('A3').IsNull))
  or (not Q670.FieldByName('A3').IsNull and (Q670.FieldByName('DA3').IsNull or Q670.FieldByName('OREMINIME_FASCIA3').IsNull)) then
    raise Exception.Create('I dati della 3°fascia di maturazione devono essere tutti valorizzati oppure tutti annullati!');
  if not Q670.FieldByName('DA3').IsNull and (R180OreMinuti(Q670.FieldByName('DA3').AsString) >= R180OreMinuti(Q670.FieldByName('A3').AsString)) then
    raise Exception.Create('L''intervallo della 3°fascia di maturazione non è valido!');
  if R180OreMinutiExt(Q670IntervalloMin.AsString) >
     R180OreMinutiExt(Q670IntervalloMax.AsString) then
    raise Exception.Create('I limiti dell''Intervallo Mensa non sono validi!');

  with A071FRegoleBuoni do
    if (DButton.State in [dsBrowse,dsEdit,dsInsert]) and (DA1.Field <> nil) then
      if (Q670.FieldByName('OREMINIME_FASCE').AsString = 'S') or (Q670.FieldByName('OREMINIME_FASCE').AsString = 'E') then
        if (A071FRegoleBuoni.DA1.Field.IsNull or A071FRegoleBuoni.A1.Field.IsNull) and
           (A071FRegoleBuoni.DA2.Field.IsNull or A071FRegoleBuoni.A2.Field.IsNull) then
          raise Exception.Create('Fascia/e non valorizzate.');

  AssenzeRipetute:=R180GetCsvIntersect(Q670.FieldByName('ASSENZE_TOLL_PERC').AsString,Q670.FieldByName('ASSENZA').AsString);
  if AssenzeRipetute <> '' then
    raise Exception.Create('Le seguenti causali sono state indicate sia tra le "Causali di assenza tollerate" che tra le "Causali di assenza tollerate in percentuale": ' + CRLF + AssenzeRipetute);
  if (Q670.FieldByName('ASSENZE_TOLL_PERC').AsString <> '')
  and ((Q670.FieldByName('PERC_TOLL_ASSENZE').AsFloat <= 0) or (Q670.FieldByName('PERC_TOLL_ASSENZE').AsFloat >= 100)) then
    raise Exception.Create('Indicare una percentuale valida per le causali di assenza tollerate in percentuale!');

  // verifica intersezione tra ASSENZE_DIMINUZIONE_INCLUSE e ASSENZA e ASSENZE_TOLL_PERC
  AssenzeRipetute:=R180GetCsvIntersect(Q670.FieldByName('ASSENZE_DIMINUZIONE_INCLUSE').AsString,Q670.FieldByName('ASSENZE_TOLL_PERC').AsString);
  if AssenzeRipetute <> '' then
    raise Exception.Create('Le seguenti causali sono state indicate sia tra le "Causali di assenza tollerate" che tra le "Causali di assenza che non devono diminuire le ore": ' + CRLF + AssenzeRipetute);

  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA071FRegoleBuoniDtM1.Q670BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA071FRegoleBuoniDtM1.Q670INTERVALLOMINValidate(Sender: TField);
begin
  if not Sender.IsNull then
    R180OraValidate(Sender.AsString);
end;

procedure TA071FRegoleBuoniDtM1.GetPeriodicitaAcquisto;
var i,y:Integer;
begin
  with A071FRegoleBuoni.chklstMesiAcq do
    for i:=0 to Items.Count - 1 do
      Checked[i]:=R180CarattereDef(Q670PERIODICITA_ACQUISTO.AsString,i + 1,'N') = 'S';
  with A071FRegoleBuoni.clbGiorniFissi do
  begin
    for i:=0 to Items.Count - 1 do
      Checked[i]:=False;
    for i:=0 to Items.Count - 1 do
      for y:=1 to Length(Q670GIORNI_FISSI.AsString) do
        if (i + 1) = StrToIntDef(Q670GIORNI_FISSI.AsString[y],0) then
          Checked[i]:=True;
  end;
  A071FRegoleBuoni.edtNumMaxBuoni.Text:=Q670NUM_MAX_BUONI.AsString;
end;

procedure TA071FRegoleBuoniDtM1.Q670AfterScroll(DataSet: TDataSet);
begin
  A071FRegoleBuoni.edtResiduoPrecedente.DateTime:=Q670.FieldByName('RESIDUO_PRECEDENTE').AsDateTime;
  GetPeriodicitaAcquisto;
  selT670lkp.Close;
  selT670lkp.SetVariable('CODICE',Q670.FieldByName('CODICE').AsString);
  selT670lkp.Open;
end;

procedure TA071FRegoleBuoniDtM1.Q670DEBITO_GIORN_MINValidate(Sender: TField);
begin
  if not Sender.IsNull then
    R180OraValidate(Sender.AsString);
end;

procedure TA071FRegoleBuoniDtM1.Q670ECCEDENZA_MINValidate(Sender: TField);
begin
  if not Sender.IsNull then
    R180OraValidate(Sender.AsString);
end;

procedure TA071FRegoleBuoniDtM1.Q670OREMINIMEGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

end.
