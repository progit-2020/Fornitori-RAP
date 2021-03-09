unit W022USchedaValutazioniDtM;

interface

uses
  DBClient, SysUtils, StrUtils, Classes, IWApplication,
  Db, OracleData, Oracle, Variants, C180FunzioniGenerali, IWInit,
  A000UCostanti, A000USessione, A000UInterfaccia, QueryStorico, USelI010, Math;

type
  TGruppoIncentivi = record
    Codice:String;
    Descrizione:String;
    OreMin:String;
    ImpMax:Real;
    OreAssegnate:String;
    ImpAssegnato:Real;
  end;

  TW022FSchedaValutazioniDtM = class(TDataModule)
    D710: TDataSource;
    selT030: TOracleDataSet;
    Q710: TOracleDataSet;
    Q710DATA: TDateTimeField;
    Q710PROGRESSIVO: TIntegerField;
    Q710D_VALUTATORE: TStringField;
    Q710VALUTAZIONE_COMPLESSIVE: TStringField;
    Q710OBIETTIVI_AZIONI: TStringField;
    Q710PROPOSTE_FORMATIVE: TStringField;
    Q710COMMENTI_VALUTATO: TStringField;
    Q710TIPO_VALUTAZIONE: TStringField;
    Q710DATA_COMPILAZIONE: TDateTimeField;
    Q710CHIUSO: TStringField;
    Q710DATA_CHIUSURA: TDateTimeField;
    Q710PUNTEGGIO_FINALE_PESATO: TFloatField;
    selSG701: TOracleDataSet;
    selSG711: TOracleDataSet;
    Q711: TOracleDataSet;
    Q711DATA: TDateTimeField;
    Q711PROGRESSIVO: TIntegerField;
    Q711COD_AREA: TStringField;
    Q711D_AREA: TStringField;
    Q711PERC_AREA: TFloatField;
    Q711PUNTEGGIO_AREA: TFloatField;
    Q711COD_VALUTAZIONE: TStringField;
    Q711D_VALUTAZIONE: TStringField;
    Q711VALUTABILE: TStringField;
    Q711PUNTEGGIO: TFloatField;
    Q711TIPO_VALUTAZIONE: TStringField;
    selSG700: TOracleDataSet;
    selSG730: TOracleDataSet;
    D711: TDataSource;
    Q711SG711_ROWID: TStringField;
    insSG711: TOracleQuery;
    delSG711: TOracleQuery;
    MesiLavorati: TOracleQuery;
    selSG741: TOracleDataSet;
    selSG720: TOracleDataSet;
    selSQL: TOracleDataSet;
    D010: TDataSource;
    Q710STATO_SCHEDA: TStringField;
    Q711DESC_VALUTAZIONE_AGG: TStringField;
    Q711VALUTAZIONE_ORIGINALE: TStringField;
    ElementiPersonalizzati: TOracleQuery;
    Q710ACCETTAZIONE_VALUTATO: TStringField;
    Q710PROPOSTE_FORMATIVE_1: TStringField;
    Q710PROPOSTE_FORMATIVE_2: TStringField;
    Q710PROPOSTE_FORMATIVE_3: TStringField;
    selFormaz: TOracleDataSet;
    selFormazCODICE: TStringField;
    selFormazDESCRIZIONE: TStringField;
    selFormazORDINE: TFloatField;
    dFormaz: TDataSource;
    Q711COD_PUNTEGGIO: TStringField;
    selT430a: TOracleDataSet;
    CambioValutatore: TOracleQuery;
    cdsRiepilogoSchede: TClientDataSet;
    selRiepilogoSchede: TOracleDataSet;
    Q710VALUTABILE: TStringField;
    updSG710: TOracleQuery;
    updSG711: TOracleQuery;
    selPeriodoSchede: TOracleDataSet;
    selSG710: TOracleDataSet;
    Q710IMPORTO_INCENTIVO: TFloatField;
    Q710ACCETTAZIONE_OBIETTIVI: TStringField;
    Q711PERC_VALUTAZIONE: TFloatField;
    Q711SOGLIA_PUNTEGGIO: TStringField;
    Q710ORE_INCENTIVO: TStringField;
    selSG767: TOracleDataSet;
    selSG745: TOracleDataSet;
    selV430a: TOracleDataSet;
    cdsRegole: TClientDataSet;
    Q710STATO_AVANZAMENTO: TIntegerField;
    selSG746: TOracleDataSet;
    selI072: TOracleDataSet;
    Q710PROGRESSIVI_VALUTATORI: TStringField;
    selV430b: TOracleDataSet;
    Q711STATO_AVANZAMENTO: TIntegerField;
    insSG710: TOracleQuery;
    insaSG711: TOracleQuery;
    selSG745a: TOracleDataSet;
    Q711PUNTEGGI_ABILITATI: TStringField;
    selSG711a: TOracleDataSet;
    Q711D_PUNTEGGIO: TStringField;
    selQ710: TClientDataSet;
    selSchedeCollegateAperte: TOracleDataSet;
    selSG711b: TOracleDataSet;
    selSchedeCollegateChiuse: TOracleDataSet;
    updSG711a: TOracleQuery;
    Q711ELEMENTI_ABILITATI: TStringField;
    Q710MODIFICA_SUBITO: TStringField;
    Q711PUNTEGGIO_PESATO: TFloatField;
    selSG742: TOracleDataSet;
    Q711NOTE_PUNTEGGIO: TStringField;
    cdsNoteItem: TClientDataSet;
    Q710NOTE: TStringField;
    selSchedeAnno: TOracleDataSet;
    selSG710b: TOracleQuery;
    RuoloCessato: TOracleDataSet;
    selI071: TOracleDataSet;
    Q710CODREGOLA: TStringField;
    PeriodoScheda: TOracleQuery;
    updSG710a: TOracleQuery;
    Q710DAL: TDateTimeField;
    Q710AL: TDateTimeField;
    Q710NUMERO_PROTOCOLLO: TIntegerField;
    Q710ANNO_PROTOCOLLO: TIntegerField;
    Q710DATA_PROTOCOLLO: TDateTimeField;
    Q710TIPO_PROTOCOLLO: TStringField;
    Q710VALUTAZIONE_INTERMEDIA: TStringField;
    Q710ESITO_VALUTAZIONE_INTERMEDIA: TStringField;
    Q710STORIA_VALUTAZIONE_INTERMEDIA: TStringField;
    selStoriaValInterm: TOracleQuery;
    Q711CF_PERC_AREA: TFloatField;
    Q711CF_PUNTEGGIO_AREA: TFloatField;
    Q711CF_PERC_VALUTAZIONE: TFloatField;
    Q711CF_PUNTEGGIO_PESATO: TFloatField;
    insSG710auto: TOracleQuery;
    insSG711auto: TOracleQuery;
    Q711GIUDICABILE: TStringField;
    cdsNoteValida: TClientDataSet;
    Q710MESSAGGIO_VALIDAZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure Q710NewRecord(DataSet: TDataSet);
    procedure Q710AfterScroll(DataSet: TDataSet);
    procedure Q710CalcFields(DataSet: TDataSet);
    procedure Q710DATAGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure Q710BeforeDelete(DataSet: TDataSet);
    procedure Q710BeforePost(DataSet: TDataSet);
    procedure Q710AfterPost(DataSet: TDataSet);
    procedure Q711CalcFields(DataSet: TDataSet);
    procedure Q711BeforePost(DataSet: TDataSet);
    procedure Q710PostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure Q710IMPORTO_INCENTIVOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure Q710IMPORTO_INCENTIVOSetText(Sender: TField; const Text: string);
    procedure Q710ORE_INCENTIVOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure Q710ORE_INCENTIVOSetText(Sender: TField; const Text: string);
  private
    { Private declarations }
    PeriodoValutazioneCambiato: Boolean;
  public
    { Public declarations }
    CampiDaEstrarre:String;
    selAnagrafeW022:TOracleDataSet;
    sTipoVal2: String;
    DataLavoro2: TDateTime;
    SoloStampa2: Boolean;
    Azione,Accesso: String;
    TotPerc: Real;
    DataRif: TDateTime;
    ScalaPnt: String;
    selI010:TselI010;
    QSGruppoValutatore:TQueryStorico;
    ValutatoreOld,ValutatoreNew:String;
    AccettazioneObiettivi,EsitoValutazioneIntermedia:String;
    VisColSogliaPunteggio,VisColItemValutabile,VisColNotePunteggio:Boolean;
    GruppoIncentivi:TGruppoIncentivi;
    vSchedeCollegateAperte:Boolean;
    CercaValutatore:Boolean;
    procedure CalcolaTotali(AggiornaPFP:Boolean);
    procedure EstraiAreeValutazione(var ValLiv1,ValLiv2,ValLiv3,ValLiv4: String;Data:TDateTime);
    procedure CaricaCDS;
    procedure RecuperaGruppoIncentivi(Data:TDateTime;Prog:Integer);
    procedure ControllaCommentiValutato;
    procedure ControllaValutazioneIntermedia;
    procedure RecuperaRegole(Data:TDateTime; Progressivo:Integer; Codice:String);
    procedure RecuperaAbilitazioneScheda(DataScheda,Data:TDateTime;Prog:Integer;TipoVal:String;CercaValutatore:Boolean);
    procedure EliminaValidazioni;
    function MotivoSchedaMancante(Data:TDateTime;Prog:Integer;TipoVal:String):String;
    function SchedeCollegateAperte(var Msg:String): Boolean;
    function SchedeCollegateChiuse(var Msg:String): Boolean;
    function AnomaliaRangePesoArea(var Msg:String): Boolean;
    function ProprietaArea(CodArea:String;Data:TDateTime;Campo:String):String;
    function RecuperaEtichetta(NomeCampo:String;Formato:String = ''):String;
    function FPeriodoOKCompilazione(Stato:Integer;TipoVal:String;var DataDa,DataA:TDateTime):Boolean;
    function FPeriodoOKObiettivi(EsisteFaseAssegnazionePreventivaObiettivi:Boolean):Boolean;
    procedure InviaEMail(Operazione:String;StatoPartenza:Integer);
  end;

const
  OpzioneFirma6: String = '#FIRMA_6#';
  CodNewItem: String = '00001';

implementation

{$R *.dfm}

procedure TW022FSchedaValutazioniDtM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
 try
  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      try (Components[i] as TOracleQuery).Session:=SessioneOracle; except end
    else if Components[i] is TOracleDataSet then
      try (Components[i] as TOracleDataSet).Session:=SessioneOracle; except end;
  end;
  QSGruppoValutatore:=TQueryStorico.Create(nil);
  QSGruppoValutatore.Session:=SessioneOracle;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','TABLE_NAME NOT IN (''T030_ANAGRAFICO'',''T480_COMUNI'')','NOME_LOGICO');
  selI010.Close;
  selI010.SQL.Insert(0,'SELECT ''' + OpzioneFirma6 + ''' NOME_CAMPO, ''' + OpzioneFirma6 + ''' NOME_LOGICO, 9999 POSIZIONE FROM DUAL UNION ');
  selI010.Open;
  D010.DataSet:=selI010;
  selFormaz.Open;
  cdsRegole.CreateDataSet;
  cdsNoteItem.CreateDataSet;
  cdsNoteValida.CreateDataSet;
 except
 end;
end;

procedure TW022FSchedaValutazioniDtM.DataModuleDestroy(Sender: TObject);
begin
 try
  if GGetWebApplicationThreadVar = nil then
    exit;
  FreeAndNil(QSGruppoValutatore);
  FreeAndNil(selI010);
 except
 end;
end;

procedure TW022FSchedaValutazioniDtM.Q710NewRecord(DataSet: TDataSet);
begin
  if  (not SelAnagrafeW022.FieldByName('T430FINE').IsNull)
  and (SelAnagrafeW022.FieldByName('T430FINE').AsDateTime < DataLavoro2)
  and (SelAnagrafeW022.FieldByName('T430FINE').AsDateTime >= EncodeDate(R180Anno(DataLavoro2),1,1)) then
    DataRif:=SelAnagrafeW022.FieldByName('T430FINE').AsDateTime
  else
    DataRif:=DataLavoro2;
  Q710.FieldByName('DATA').AsDateTime:=DataLavoro2;
  RecuperaRegole(DataRif,SelAnagrafeW022.FieldByName('PROGRESSIVO').AsInteger,'');
  Q710.FieldByName('CODREGOLA').AsString:=selSG741.FieldByName('CODICE').AsString;
  selSG746.First;
  Q710.FieldByName('STATO_AVANZAMENTO').AsInteger:=selSG746.FieldByName('CODICE').AsInteger;
  Q710.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafeW022.FieldByName('PROGRESSIVO').AsInteger;
  if Parametri.S710_SupervisoreValut = 'N' then
    Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString:=IntToStr(Parametri.ProgressivoOper)
  else if sTipoVal2 = 'A' then
    Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString:=IntToStr(Q710.FieldByName('PROGRESSIVO').AsInteger)
  else
  begin
    RecuperaAbilitazioneScheda(Q710.FieldByName('DATA').AsDateTime,DataRif,Q710.FieldByName('PROGRESSIVO').AsInteger,sTipoVal2,CercaValutatore);
    Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString:=VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([DataRif,Q710.FieldByName('PROGRESSIVO').AsInteger]),'PROGRESSIVO_VALUTATORE'));
  end;
  if (StrToIntDef(Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString,0) <= 0)
  and ((Parametri.S710_SupervisoreValut = 'N') or CercaValutatore) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Inserimento inibito: Non è possibile recuperare il ' + RecuperaEtichetta('VALUTATORE_C','L') + '!');
    Abort;
  end;
  if (sTipoVal2 <> 'A') and R180InConcat(Q710.FieldByName('PROGRESSIVO').AsString,Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Inserimento inibito: Il ' + RecuperaEtichetta('VALUTATO_C','L') + ' e il ' + RecuperaEtichetta('VALUTATORE_C','L') + ' corrispondono! In caso di normale autovalutazione utilizzare l''apposita funzione.');
    Abort;
  end;
  Q710.FieldByName('VALUTAZIONE_COMPLESSIVE').AsString:=selSG741.FieldByName('TESTO_VALUTAZIONI_COMPLESSIVE').AsString;
  Q710.FieldByName('TIPO_VALUTAZIONE').AsString:=sTipoVal2;
  Q710.FieldByName('DATA_COMPILAZIONE').AsDateTime:=Date;
  //Periodo di valutazione
  PeriodoScheda.SetVariable('DATA_MAX',Q710.FieldByName('DATA').AsDateTime);
  PeriodoScheda.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
  PeriodoScheda.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
  PeriodoScheda.Execute;
  if (VarToStr(PeriodoScheda.GetVariable('DAL')) = '') or (VarToStr(PeriodoScheda.GetVariable('AL')) = '') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Inserimento inibito: Il periodo di valutazione ' + FormatDateTime('dd/mm/yyyy',PeriodoScheda.GetVariable('DATA_MIN')) + ' - ' + FormatDateTime('dd/mm/yyyy',PeriodoScheda.GetVariable('DATA_MAX')) + ' è esterno al periodo di rapporto!');
    Abort;
  end;
  Q710.FieldByName('DAL').AsDateTime:=PeriodoScheda.GetVariable('DAL');
  Q710.FieldByName('AL').AsDateTime:=PeriodoScheda.GetVariable('AL');
  if VarToStr(PeriodoScheda.GetVariable('DATA_INT')) <> '' then
  begin
    if PeriodoScheda.GetVariable('CHIUSO') = 'S' then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Inserimento inibito: La scheda intersecata del ' + FormatDateTime('dd/mm/yyyy',PeriodoScheda.GetVariable('DATA_INT')) + ' è già stata chiusa!');
      Abort;
    end;
    if Q710.FieldByName('DATA').AsDateTime >= PeriodoScheda.GetVariable('AL_INT') then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Inserimento inibito: La scheda intersecata del ' + FormatDateTime('dd/mm/yyyy',PeriodoScheda.GetVariable('DATA_INT')) + ' rimarrebbe senza periodo di valutazione!');
      Abort;
    end;
  end;
  QSGruppoValutatore.LocDatoStorico(DataRif);
end;

procedure TW022FSchedaValutazioniDtM.Q710ORE_INCENTIVOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:=''
  else Text:=Sender.AsString;
end;

procedure TW022FSchedaValutazioniDtM.Q710ORE_INCENTIVOSetText(Sender: TField;
  const Text: string);
begin
  if Text = '' then
    Sender.Clear
  else
    try
      Sender.AsString:=R180MinutiOre(R180OreMinutiExt(Text));
    except
      GGetWebApplicationThreadVar.ShowMessage('L''"Orario annuale negoziato" ' + Text + ' non è consentito! Inserire un valore orario nel formato hh.mi!');
      Abort;
    end;
end;

procedure TW022FSchedaValutazioniDtM.Q710PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  Azione:='';
  if Pos('ORA-00001',E.Message) > 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Esiste già una ' + IfThen(sTipoVal2 = 'A','autovalutazione','valutazione') +
                               ' del dipendente selezionato' +
                               IfThen(Q710.FieldByName('DATA').AsDateTime = EncodeDate(R180Anno(Q710.FieldByName('DATA').AsDateTime),12,31),' per l''anno ' + FormatDateTime('yyyy',Q710.FieldByName('DATA').AsDateTime),' in data ' + FormatDateTime('dd/mm/yyyy',Q710.FieldByName('DATA').AsDateTime)) + '!');
    Abort;
  end;
end;

procedure TW022FSchedaValutazioniDtM.Q710AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if  (not SelAnagrafeW022.FieldByName('T430FINE').IsNull)
  and (SelAnagrafeW022.FieldByName('T430FINE').AsDateTime < Q710.FieldByName('DATA').AsDateTime)
  and (SelAnagrafeW022.FieldByName('T430FINE').AsDateTime >= EncodeDate(R180Anno(Q710.FieldByName('DATA').AsDateTime),1,1)) then
    DataRif:=SelAnagrafeW022.FieldByName('T430FINE').AsDateTime
  else
    DataRif:=Q710.FieldByName('DATA').AsDateTime;
  RecuperaRegole(DataRif,Q710.FieldByName('PROGRESSIVO').AsInteger,Q710.FieldByName('CODREGOLA').AsString);
  //Mi posiziono sul periodo storico corretto per estrarre il valore del campo di riferimento
  ScalaPnt:='*';
  QSGruppoValutatore.LocDatoStorico(DataRif);
  if Parametri.CampiRiferimento.C21_ValutazioniPnt1 <> '' then
    ScalaPnt:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniPnt1).AsString;
  with selSG730 do
  begin
    Close;
    SetVariable('DATA_VAL',DataRif);
    SetVariable('DATO1',ScalaPnt);
    Open;
    if (RecordCount = 0) and (ScalaPnt <> '*') then
    begin
      ScalaPnt:='*';
      Close;
      SetVariable('DATO1',ScalaPnt);
      Open;
    end;
  end;
  //Carico i record di dettaglio
  VisColSogliaPunteggio:=False;
  VisColItemValutabile:=False;
  VisColNotePunteggio:=False;
  with Q711 do
  begin
    Close;
    SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    Open;
  end;
end;

procedure TW022FSchedaValutazioniDtM.Q710CalcFields(DataSet: TDataSet);
var ProgValutatori,DValutatore,MessNoValida:String;
    ProgValutatore,Prog:Integer;
begin
  inherited;
  if  (not SelAnagrafeW022.FieldByName('T430FINE').IsNull)
  and (SelAnagrafeW022.FieldByName('T430FINE').AsDateTime < Q710.FieldByName('DATA').AsDateTime)
  and (SelAnagrafeW022.FieldByName('T430FINE').AsDateTime >= EncodeDate(R180Anno(Q710.FieldByName('DATA').AsDateTime),1,1)) then
    DataRif:=SelAnagrafeW022.FieldByName('T430FINE').AsDateTime
  else
    DataRif:=Q710.FieldByName('DATA').AsDateTime;
  Prog:=Q710.FieldByName('PROGRESSIVO').AsInteger;
  RecuperaRegole(DataRif,Prog,Q710.FieldByName('CODREGOLA').AsString);
  RecuperaAbilitazioneScheda(Q710.FieldByName('DATA').AsDateTime,DataRif,Prog,Q710.FieldByName('TIPO_VALUTAZIONE').AsString,False);
  //Verifico la presa visione dello stato precedente
  if VarToStr(selSG746.Lookup('CODICE',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'MODIFICABILE')) = 'S' then
    Q710.FieldByName('MODIFICA_SUBITO').AsString:='S'
  else
  begin
    R180SetVariable(selSG745a,'DATA',Q710.FieldByName('DATA').AsDateTime);
    R180SetVariable(selSG745a,'PROGRESSIVO',Prog);
    R180SetVariable(selSG745a,'TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    R180SetVariable(selSG745a,'STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger - 1);
    selSG745a.Open;
    Q710.FieldByName('MODIFICA_SUBITO').AsString:=selSG745a.FieldByName('PRESA_VISIONE').AsString;
  end;
  //Stato della scheda
  Q710.FieldByName('STATO_SCHEDA').AsString:=IfThen(selSG741.FieldByName('CODICE').IsNull,'Non valutabile: Regole non trovate',
                                             IfThen(not SoloStampa2 and (VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([DataRif,Prog]),'STAMPA_ABILITATA')) = 'N'),'Non disponibile: Altro ' + RecuperaEtichetta('VALUTATORE_C','L'),
                                             IfThen(Q710.FieldByName('VALUTABILE').AsString = 'N','Non valutabile: Impostato dall''ufficio',
                                             IfThen(Q710.FieldByName('CHIUSO').AsString = 'S','Scheda definitiva',
                                             IfThen(Q710.FieldByName('CHIUSO').AsString = 'B','Scheda bloccata',
                                             IfThen((Q710.FieldByName('TIPO_VALUTAZIONE').AsString = 'A') and (VarToStr(selSG746.Lookup('CREA_AUTOVALUTAZIONE','S','CREA_AUTOVALUTAZIONE')) = 'S'),'Scheda provvisoria',
                                             VarToStr(selSG746.Lookup('CODICE',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'DESCRIZIONE')) + IfThen(Q710.FieldByName('MODIFICA_SUBITO').AsString <> 'S',' (in attesa di presa visione del dipendente)')))))));
  Q710.FieldByName('D_VALUTATORE').AsString:='';
  //Valutatore
  ProgValutatori:=Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString + ',';
  while Pos(',',ProgValutatori) > 0 do
  begin
    ProgValutatore:=StrToIntDef(Copy(ProgValutatori,1,Pos(',',ProgValutatori) - 1),-1);
    if ProgValutatore <= 0 then
      DValutatore:=RecuperaEtichetta('VALUTATORE_C') + ' non impostato'
    else
    begin
      R180SetVariable(selT030,'PROGRESSIVO',ProgValutatore);
      selT030.Open;
      if selT030.RecordCount > 0 then
        DValutatore:=Format('%-8s %s',[selT030.FieldByName('MATRICOLA').AsString,selT030.FieldByName('NOMINATIVO').AsString])
      else
        DValutatore:=RecuperaEtichetta('VALUTATORE_C') + ' non presente in anagrafica';
    end;
    Q710.FieldByName('D_VALUTATORE').AsString:=Q710.FieldByName('D_VALUTATORE').AsString + IfThen(not Q710.FieldByName('D_VALUTATORE').IsNull,CRLF) + DValutatore;
    ProgValutatori:=Copy(ProgValutatori,Pos(',',ProgValutatori) + 1);
  end;
  selStoriaValInterm.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
  selStoriaValInterm.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
  selStoriaValInterm.SetVariable('TIPO',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
  selStoriaValInterm.SetVariable('STATO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
  selStoriaValInterm.Execute;
  Q710.FieldByName('STORIA_VALUTAZIONE_INTERMEDIA').AsString:=VarToStr(selStoriaValInterm.Field(0));
  MessNoValida:='';
  R180SetVariable(selSG745,'DATA',Q710.FieldByName('DATA').AsDateTime);
  R180SetVariable(selSG745,'PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
  R180SetVariable(selSG745,'TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
  R180SetVariable(selSG745,'STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1);
  selSG745.Open;
  if selSG745.SearchRecord('TIPO_CONSEGNA','VS',[srFromBeginning]) then
  begin
    R180SetVariable(selT030,'PROGRESSIVO',selSG745.FieldByName('PROG_UTENTE').AsInteger);
    selT030.Open;
    if selT030.RecordCount > 0 then
      DValutatore:=Format('%s (%s)',[selT030.FieldByName('NOMINATIVO').AsString,selT030.FieldByName('MATRICOLA').AsString])
    else
      DValutatore:=selSG745.FieldByName('UTENTE').AsString;
    MessNoValida:=MessNoValida + 'Scheda respinta il ' + FormatDateTime('dd/mm/yyyy hh:nn',selSG745.FieldByName('DATA_CONSEGNA').AsDateTime)
                               + ' da ' + DValutatore
                               + IfThen(Trim(selSG745.FieldByName('MOTIVAZIONE').AsString) <> '',' con la seguente motivazione: ' + CRLF + selSG745.FieldByName('MOTIVAZIONE').AsString);
  end;
  if Parametri.S710_ValidaStato = 'S' then
  begin
    R180SetVariable(selSG745,'STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    selSG745.Open;
    if selSG745.SearchRecord('TIPO_CONSEGNA','VS',[srFromBeginning]) then
    begin
      R180SetVariable(selT030,'PROGRESSIVO',selSG745.FieldByName('PROG_UTENTE').AsInteger);
      selT030.Open;
      if selT030.RecordCount > 0 then
        DValutatore:=Format('%s (%s)',[selT030.FieldByName('NOMINATIVO').AsString,selT030.FieldByName('MATRICOLA').AsString])
      else
        DValutatore:=selSG745.FieldByName('UTENTE').AsString;
      MessNoValida:=MessNoValida + 'In precedenza (' + FormatDateTime('dd/mm/yyyy hh:nn',selSG745.FieldByName('DATA_CONSEGNA').AsDateTime)
                                 + ') la scheda era stata respinta da ' + DValutatore
                                 + IfThen(Trim(selSG745.FieldByName('MOTIVAZIONE').AsString) <> '',' per il seguente motivo: ' + CRLF + selSG745.FieldByName('MOTIVAZIONE').AsString);
    end;
  end;
  Q710.FieldByName('MESSAGGIO_VALIDAZIONE').AsString:=MessNoValida;
end;

procedure TW022FSchedaValutazioniDtM.Q710DATAGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    Text:=''
  else if Sender.AsDateTime = EncodeDate(R180Anno(Sender.AsDateTime),12,31) then
    Text:=FormatDateTime('yyyy',Sender.AsDateTime)
  else
    Text:=FormatDateTime('dd/mm/yyyy',Sender.AsDateTime);
end;

procedure TW022FSchedaValutazioniDtM.Q710IMPORTO_INCENTIVOGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:=''
  else Text:=R180FormattaNumero(Sender.AsString,'M=N,D=2,0=S,SD=,');
end;

procedure TW022FSchedaValutazioniDtM.Q710IMPORTO_INCENTIVOSetText(
  Sender: TField; const Text: string);
var S:String;
begin
  if Text = '' then
    Sender.Clear
  else
    try
      S:=StringReplace(Text,'.',',',[rfReplaceAll]);
      Sender.AsFloat:=R180Arrotonda(StrToFloat(S),0.01,'P');
    except
      GGetWebApplicationThreadVar.ShowMessage('La "Quota annuale retribuzione risultato" ' + Text + ' non è consentita! Inserire un importo con al massimo 2 cifre decimali separate dalla virgola!');
      Abort;
    end;
end;

procedure TW022FSchedaValutazioniDtM.Q710BeforeDelete(DataSet: TDataSet);
begin
  Azione:='D';
  delSG711.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
  delSG711.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
  delSG711.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
  delSG711.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
  delSG711.Execute;
  with selSG745 do
  begin
    //Cancello sia le prese visioni che eventuali rifiuti del validatore
    Close;
    SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    Open;
    Last;
    while not Bof do
      Delete;
    //Inserisco l'eventuale rifiuto del validatore
    if (Q710.FieldByName('STATO_AVANZAMENTO').AsInteger > 1)
    and (Parametri.S710_ValidaStato = 'S') then
    begin
      Insert;
      FieldByName('TIPO_CONSEGNA').AsString:='VS';
      FieldByName('DATA').AsDateTime:=Q710.FieldByName('DATA').AsDateTime;
      FieldByName('PROGRESSIVO').AsInteger:=Q710.FieldByName('PROGRESSIVO').AsInteger;
      FieldByName('TIPO_VALUTAZIONE').AsString:=Q710.FieldByName('TIPO_VALUTAZIONE').AsString;
      FieldByName('STATO_AVANZAMENTO').AsInteger:=Q710.FieldByName('STATO_AVANZAMENTO').AsInteger;
      FieldByName('UTENTE').AsString:=Parametri.Operatore;
      FieldByName('PROG_UTENTE').AsInteger:=Parametri.ProgressivoOper;
      FieldByName('DATA_CONSEGNA').AsDateTime:=R180Sysdate(SessioneOracle);
      FieldByName('ESITO').AsString:='N';
      FieldByName('MOTIVAZIONE').AsString:=cdsNoteValida.FieldByName('MOTIVAZIONE').AsString;
      Post;
    end;
  end;
  SessioneOracle.Commit;
end;

procedure TW022FSchedaValutazioniDtM.Q710BeforePost(DataSet: TDataSet);
var
  GgDiff,GgMinimi: Integer;
  CodTipiRapp: String;
begin
  inherited;
  if Azione = 'I' then
  begin
    //Verifico se il dipendente non è valutabile
    GgMinimi:=selSG741.FieldByName('GIORNI_MINIMI').AsInteger;
    CodTipiRapp:='''' + StringReplace(selSG741.FieldByName('COD_TIPI_RAPPORTO').AsString,',',''',''',[rfReplaceAll]) + '''';
    with MesiLavorati do
    begin
      SetVariable('DATA_RIF',DataRif);
      SetVariable('CODICI_TIPO_RAPPORTO','AND TIPORAPPORTO IN (' + CodTipiRapp + ')');
      SetVariable('PROGR',Q710.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('SALTA_ASSENZE','N');
      Execute;
      if VarToStr(GetVariable('GG_DIFF')) = '' then
        GgDiff:=0
      else
        GgDiff:=GetVariable('GG_DIFF');
      if GgDiff < GgMinimi then
      begin
        if selSG741.FieldByName('VALUTA_CESSATI_RUOLO').AsString = 'S' then
        begin
          R180SetVariable(RuoloCessato,'DATA_RIF',DataRif);
          R180SetVariable(RuoloCessato,'PROGR',Q710.FieldByName('PROGRESSIVO').AsInteger);
          R180SetVariable(RuoloCessato,'CODICI_TIPO_RAPPORTO','AND TIPORAPPORTO IN (' + CodTipiRapp + ')');
          RuoloCessato.Open;
        end;
        if (selSG741.FieldByName('VALUTA_CESSATI_RUOLO').AsString = 'N')
        or (RuoloCessato.RecordCount = 0) then
        begin
          GGetWebApplicationThreadVar.ShowMessage('Dipendente non valutabile! Periodo di lavoro inferiore ai ' + IntToStr(GgMinimi) + ' giorni alla data ' + FormatDateTime('dd/mm/yyyy',DataRif) + ' per i tipi rapporto previsti per la valutazione!');
          Abort;
        end;
      end;
    end;
  end;
  Q710.FieldByName('VALUTAZIONE_INTERMEDIA').AsString:=R180SostituisciCaratteriSpeciali(Trim(Q710.FieldByName('VALUTAZIONE_INTERMEDIA').AsString));
  Q710.FieldByName('VALUTAZIONE_COMPLESSIVE').AsString:=R180SostituisciCaratteriSpeciali(Trim(Q710.FieldByName('VALUTAZIONE_COMPLESSIVE').AsString));
  Q710.FieldByName('OBIETTIVI_AZIONI').AsString:=R180SostituisciCaratteriSpeciali(Trim(Q710.FieldByName('OBIETTIVI_AZIONI').AsString));
  Q710.FieldByName('PROPOSTE_FORMATIVE').AsString:=R180SostituisciCaratteriSpeciali(Trim(Q710.FieldByName('PROPOSTE_FORMATIVE').AsString));
  Q710.FieldByName('COMMENTI_VALUTATO').AsString:=R180SostituisciCaratteriSpeciali(Trim(Q710.FieldByName('COMMENTI_VALUTATO').AsString));
  Q710.FieldByName('NOTE').AsString:=R180SostituisciCaratteriSpeciali(Trim(Q710.FieldByName('NOTE').AsString));
  //Se è stato indicato che il dipendente non è valutabile, svuoto la scheda tranne Valutazioni complessive e le Note
  if Q710.FieldByName('VALUTABILE').AsString = 'N' then
  begin
    Q710.FieldByName('VALUTAZIONE_INTERMEDIA').AsString:='';
    Q710.FieldByName('ESITO_VALUTAZIONE_INTERMEDIA').AsString:='';
    Q710.FieldByName('OBIETTIVI_AZIONI').AsString:='';
    Q710.FieldByName('IMPORTO_INCENTIVO').AsString:='';
    Q710.FieldByName('ORE_INCENTIVO').AsString:='';
    Q710.FieldByName('ACCETTAZIONE_OBIETTIVI').AsString:='';
    Q710.FieldByName('PROPOSTE_FORMATIVE').AsString:='';
    Q710.FieldByName('PROPOSTE_FORMATIVE_1').AsString:='';
    Q710.FieldByName('PROPOSTE_FORMATIVE_2').AsString:='';
    Q710.FieldByName('PROPOSTE_FORMATIVE_3').AsString:='';
    Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString:='S';
    Q710.FieldByName('COMMENTI_VALUTATO').AsString:='';
    //continua nell'AfterPost
  end
  else
  begin
    //Controllo se devono specificare la proposta formativa
    if (   (Q710.FieldByName('PROPOSTE_FORMATIVE_1').AsString = 'Z')
        or (Q710.FieldByName('PROPOSTE_FORMATIVE_2').AsString = 'Z')
        or (Q710.FieldByName('PROPOSTE_FORMATIVE_3').AsString = 'Z'))
    and (Trim(Q710.FieldByName('PROPOSTE_FORMATIVE').AsString) = '') then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Specificare la proposta formativa in "' + RecuperaEtichetta('PROPOSTE_FORMATIVE_C') + '"!');
      Abort;
    end;
    //Svuoto i commenti del valutato se non sono più abilitati
    ControllaCommentiValutato;
    //Svuoto le valutazioni complessive se non sono abilitate
    if Pos('P1',selSG741.FieldByName('PAGINE_ABILITATE').AsString) = 0 then
      Q710.FieldByName('VALUTAZIONE_COMPLESSIVE').AsString:='';
    //Svuoto gli obiettivi pianificati se non sono abilitati
    if Pos('P2',selSG741.FieldByName('PAGINE_ABILITATE').AsString) = 0 then
      Q710.FieldByName('OBIETTIVI_AZIONI').AsString:='';
    //Controllo valori negativi
    if (Q710.FieldByName('IMPORTO_INCENTIVO').AsFloat < 0) or (R180OreMinutiExt(Q710.FieldByName('ORE_INCENTIVO').AsString) < 0) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Sono stati indicati valori negativi nella pagina "' + RecuperaEtichetta('OBIETTIVI_PIANIFICATI_C') + '". Correggere la situazione!');
      Abort;
    end;
    //Svuoto le proposte formative se non sono abilitate
    if Pos('P3',selSG741.FieldByName('PAGINE_ABILITATE').AsString) = 0 then
      Q710.FieldByName('PROPOSTE_FORMATIVE').AsString:='';
    //Svuoto le aree formative se non sono abilitate
    if selSG741.FieldByName('ABILITA_AREE_FORMATIVE').AsString = 'N' then
    begin
      Q710.FieldByName('PROPOSTE_FORMATIVE_1').AsString:='';
      Q710.FieldByName('PROPOSTE_FORMATIVE_2').AsString:='';
      Q710.FieldByName('PROPOSTE_FORMATIVE_3').AsString:='';
    end;
    //Gestisco l'accettazione degli obiettivi
    if AccettazioneObiettivi <> '' then
      Q710.FieldByName('ACCETTAZIONE_OBIETTIVI').AsString:=IfThen(AccettazioneObiettivi = 'tolto','',AccettazioneObiettivi);
    //Svuoto le note se non sono abilitate
    if Pos('P5',selSG741.FieldByName('PAGINE_ABILITATE').AsString) = 0 then
      Q710.FieldByName('NOTE').AsString:='';
    //Svuoto la valutazione intermedia se non sono abilitate
    if Pos('P0',selSG741.FieldByName('PAGINE_ABILITATE').AsString) = 0 then
    begin
      Q710.FieldByName('VALUTAZIONE_INTERMEDIA').AsString:='';
      Q710.FieldByName('ESITO_VALUTAZIONE_INTERMEDIA').AsString:='';
    end
    else if EsitoValutazioneIntermedia <> '' then
      Q710.FieldByName('ESITO_VALUTAZIONE_INTERMEDIA').AsString:=IfThen(EsitoValutazioneIntermedia = 'tolto','',EsitoValutazioneIntermedia);
    if (Q710.FieldByName('ESITO_VALUTAZIONE_INTERMEDIA').AsString = 'N')
    and (Trim(Q710.FieldByName('VALUTAZIONE_INTERMEDIA').AsString) = '') then
    begin
      GGetWebApplicationThreadVar.ShowMessage('In caso di valutazione negativa, è necessario compilare il campo "' + RecuperaEtichetta('VALUTAZIONE_INTERMEDIA_C') + '"!');
      Abort;
    end;
    if (Q710.FieldByName('ESITO_VALUTAZIONE_INTERMEDIA').AsString = '')
    and (Trim(Q710.FieldByName('VALUTAZIONE_INTERMEDIA').AsString) <> '') then
    begin
      GGetWebApplicationThreadVar.ShowMessage('In caso di compilazione del campo "' + RecuperaEtichetta('VALUTAZIONE_INTERMEDIA_C') + '", è necessario specificare se la valutazione si ritiene positiva o negativa, selezionando l''apposito campo!');
      Abort;
    end;
  end;
  { TODO : TEST IW 15 }
  PeriodoValutazioneCambiato:=(Q710.State = dsEdit) and 
                              ((Q710.FieldByName('DAL').AsDateTime <> Q710.FieldByName('DAL').OldValue) or (Q710.FieldByName('AL').AsDateTime <> Q710.FieldByName('AL').OldValue));
end;

procedure TW022FSchedaValutazioniDtM.ControllaCommentiValutato;
begin
  if (Pos('P4',selSG741.FieldByName('PAGINE_ABILITATE').AsString) = 0)
  or not (   (selSG741.FieldByName('ABILITA_COMMENTI_VALUTATO').AsString = '1')
          or (    (selSG741.FieldByName('ABILITA_COMMENTI_VALUTATO').AsString = '3')
              and (Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString = 'S'))
          or (    (selSG741.FieldByName('ABILITA_COMMENTI_VALUTATO').AsString = '4')
              and (Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString = 'N'))) then
    Q710.FieldByName('COMMENTI_VALUTATO').AsString:='';
  if (Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString = 'N')
  and (selSG741.FieldByName('ABILITA_COMMENTI_VALUTATO').AsString = '4')
  and (Trim(Q710.FieldByName('COMMENTI_VALUTATO').AsString) = '') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Per il tipo di scheda corrente, in caso di difformità di giudizio e/o non accettazione da parte del ' + RecuperaEtichetta('VALUTATO_C','L') + ', è necessario compilare il campo "' + RecuperaEtichetta('COMMENTI_VALUTATO_C') + '"!');
    Abort;
  end;
end;

procedure TW022FSchedaValutazioniDtM.ControllaValutazioneIntermedia;
begin
  if (Q710.FieldByName('ESITO_VALUTAZIONE_INTERMEDIA').AsString = '')
  and (VarToStr(selSG746.Lookup('CODICE',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'VAL_INTERM_OBBLIGATORIA')) = 'S') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' obbligatorio specificare se la valutazione si ritiene positiva o negativa, nella pagina "' + RecuperaEtichetta('VALUTAZIONE_INTERMEDIA_C') + '"!');
    Abort;
  end;
end;

procedure TW022FSchedaValutazioniDtM.Q710AfterPost(DataSet: TDataSet);
var
  ValLiv1,ValLiv2,ValLiv3,ValLiv4,RIP,CodNewItemDisp:String;
  i,IPMin:Integer;
  ElementoInserito:Boolean;
  DataInt:TDateTime;
begin
  inherited;
  if Azione = 'D' then
    exit;
  //Se sono in fase di inserimento...
  if Azione = 'I' then
  begin
    ValLiv1:='';
    ValLiv2:='';
    ValLiv3:='';
    ValLiv4:='';
    //Mi posiziono sul periodo storico corretto per estrarre i valori dei campi di riferimento
    if QSGruppoValutatore.LocDatoStorico(DataRif) then
    begin
      if Parametri.CampiRiferimento.C21_ValutazioniLiv1 <> '' then
        ValLiv1:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv1).AsString;
      if Parametri.CampiRiferimento.C21_ValutazioniLiv2 <> '' then
        ValLiv2:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv2).AsString;
      if Parametri.CampiRiferimento.C21_ValutazioniLiv3 <> '' then
        ValLiv3:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv3).AsString;
      if Parametri.CampiRiferimento.C21_ValutazioniLiv4 <> '' then
        ValLiv4:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv4).AsString;
    end;
    EstraiAreeValutazione(ValLiv1,ValLiv2,ValLiv3,ValLiv4,DataRif);
    while not selSG720.Eof do
    begin
      if ProprietaArea(selSG720.FieldByName('COD_AREA').AsString,DataRif,'LINK_CONVOGLIA') = 'S' then
      begin
        //Inserisco un elemento di valutazione che rappresenta tutti quelli convogliati nell'area
        insSG711.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
        insSG711.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
        insSG711.SetVariable('COD_AREA',selSG720.FieldByName('COD_AREA').AsString);
        insSG711.SetVariable('COD_VALUTAZIONE',selSG720.FieldByName('COD_AREA').AsString);
        insSG711.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
        insSG711.SetVariable('DESC_VALUTAZIONE_AGG','');
        insSG711.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
        insSG711.SetVariable('PERC_VALUTAZIONE',100);
        insSG711.Execute;
      end
      else
      begin
        //Filtro gli elementi di valutazione in base all'area di valutazione
        R180SetVariable(selSG700,'COD_AREA',selSG720.FieldByName('COD_AREA').AsString);
        R180SetVariable(selSG700,'DATA',DataRif);
        selSG700.Open;
        selSG700.First;
        //Scorro gli elementi di valutazione
        while not selSG700.Eof do
        begin
          //Inserisco il dettaglio con gli elementi di valutazione
          insSG711.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
          insSG711.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
          insSG711.SetVariable('COD_AREA',selSG700.FieldByName('COD_AREA').AsString);
          insSG711.SetVariable('COD_VALUTAZIONE',selSG700.FieldByName('COD_VALUTAZIONE').AsString);
          insSG711.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
          insSG711.SetVariable('DESC_VALUTAZIONE_AGG','');
          insSG711.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
          insSG711.SetVariable('PERC_VALUTAZIONE',selSG700.FieldByName('PESO_PERCENTUALE').AsFloat);
          insSG711.Execute;
          selSG700.Next;
        end;
        if ProprietaArea(selSG720.FieldByName('COD_AREA').AsString,DataRif,'ITEM_PERSONALIZZATI') = 'S' then
        begin
          RIP:=ProprietaArea(selSG720.FieldByName('COD_AREA').AsString,DataRif,'RANGE_ITEM_PERSONALIZZATI');
          IPMin:=StrToIntDef(Copy(RIP,1,Pos('#',RIP) - 1),0);
          //Inserisco gli elementi personalizzati minimi. Se l'area non ha elementi fissi, allora ne inserisco almeno 1.
          if (IPMin > 0) or (selSG700.RecordCount = 0) then
          begin
            CodNewItemDisp:=CodNewItem;
            i:=0;
            repeat
              //Inserisco il dettaglio con gli elementi di valutazione
              insSG711.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
              insSG711.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
              insSG711.SetVariable('COD_AREA',selSG720.FieldByName('COD_AREA').AsString);
              insSG711.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
              insSG711.SetVariable('DESC_VALUTAZIONE_AGG',ProprietaArea(selSG720.FieldByName('COD_AREA').AsString,DataRif,'TESTO_ITEM_PERSONALIZZATI'));
              insSG711.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
              insSG711.SetVariable('PERC_VALUTAZIONE',IfThen(ProprietaArea(selSG720.FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA_BASE_100') = 'S',100,selSG701.FieldByName('PESO_PERCENTUALE').AsFloat));
              ElementoInserito:=False;
              repeat
                try
                  insSG711.SetVariable('COD_VALUTAZIONE',CodNewItemDisp);
                  insSG711.Execute;
                  ElementoInserito:=True;
                except
                  CodNewItemDisp:=StringReplace(Format('%5s',[IntToStr(StrToInt(CodNewItemDisp) + 1)]),' ','0',[rfReplaceAll]);
                end;
              until ElementoInserito;
              inc(i);
            until i >= IPMin;
          end;
        end;
      end;
      selSG720.Next;
    end;
    SessioneOracle.Commit;
    //Aggiorno il periodo di valutazione della scheda intersecata (per tutti gli stati avanzamento)
    if VarToStr(PeriodoScheda.GetVariable('DATA_INT')) <> '' then
    begin
      DataInt:=PeriodoScheda.GetVariable('DATA_INT');
      PeriodoScheda.SetVariable('DATA_MAX',PeriodoScheda.GetVariable('AL_INT'));//Estratta nell'OnNewRecord
      PeriodoScheda.Execute;
      updSG710a.SetVariable('DATA',DataInt);
      updSG710a.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
      updSG710a.SetVariable('TIPO_VAL',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
      updSG710a.SetVariable('DAL',PeriodoScheda.GetVariable('DAL'));
      updSG710a.SetVariable('AL',PeriodoScheda.GetVariable('AL'));
      updSG710a.Execute;
      SessioneOracle.Commit;
    end;
    VisColSogliaPunteggio:=False;
    VisColItemValutabile:=False;
    VisColNotePunteggio:=False;
    Q711.Refresh;
  end;
  if PeriodoValutazioneCambiato then
  begin
    //Aggiorno il periodo di valutazione della scheda corrente (per tutti gli stati avanzamento)
    updSG710a.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    updSG710a.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    updSG710a.SetVariable('TIPO_VAL',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    updSG710a.SetVariable('DAL',Q710.FieldByName('DAL').AsDateTime);
    updSG710a.SetVariable('AL',Q710.FieldByName('AL').AsDateTime);
    updSG710a.Execute;
    SessioneOracle.Commit;
    Q710.RefreshRecord;
    PeriodoValutazioneCambiato:=False;
  end;
  //Se è stato indicato che il dipendente non è valutabile...
  if Q710.FieldByName('VALUTABILE').AsString = 'N' then
  begin
    //...azzero i punteggi e...
    updSG711.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    updSG711.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    updSG711.SetVariable('TIPO_VAL',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    updSG711.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    updSG711.Execute;
  end;
  //Se è stato indicato che il dipendente non è valutabile...
  if (Q710.FieldByName('VALUTABILE').AsString = 'N')
  //o se il dirigente non ha accettato gli obiettivi...
  or (Q710.FieldByName('ACCETTAZIONE_OBIETTIVI').AsString = 'N') then
  begin
    //...chiudo la scheda...
    updSG710.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    updSG710.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    updSG710.SetVariable('TIPO_VAL',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    updSG710.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    updSG710.SetVariable('CHIUSO','S');
    updSG710.SetVariable('AGGIORNA',selSG741.FieldByName('AGGIORNA_DATA_COMPILAZIONE').AsString);//selSG741 impostato nel BeforePostNoStorico
    updSG710.Execute;
    SessioneOracle.Commit;
    Q710.RefreshRecord;
    VisColSogliaPunteggio:=False;
    VisColItemValutabile:=False;
    VisColNotePunteggio:=False;
    Q711.Refresh;
  end;
end;

procedure TW022FSchedaValutazioniDtM.Q711BeforePost(DataSet: TDataSet);
begin
  //Se annullo volontariamente la percentuale dell'elemento, allora non è valutabile...
  //AsCurrency perché AsFloat rimane sporco quando si usa R180Arrotonda con 5 cifre decimali
  if Q711.FieldByName('PERC_VALUTAZIONE').AsCurrency = 0 then
  begin
    if (ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'PESO_ITEM_MODIFICABILE') = 'S') then
      Q711.FieldByName('VALUTABILE').AsString:='N';
  end
  //Se imposto la percentuale, ma non posso intervenire sul flag Valutabile, allora forzo il valore
  else if ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'ITEM_TUTTI_VALUTABILI') = 'S' then
    Q711.FieldByName('VALUTABILE').AsString:='S';
  //Se l'elemento non è valutabile è non posso assegnarvi un punteggio, lo svuoto, se assegnato precedentemente
  if (Q711.FieldByName('VALUTABILE').AsString = 'N')
  and (ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'PUNTEGGI_SOLO_ITEM_VALUTABILI') = 'S') then
  begin
    Q711.FieldByName('PUNTEGGIO').AsString:='';
    Q711.FieldByName('COD_PUNTEGGIO').AsString:='';
    Q711.FieldByName('NOTE_PUNTEGGIO').AsString:='';
  end;
  Q711.FieldByName('NOTE_PUNTEGGIO').AsString:=Trim(Q711.FieldByName('NOTE_PUNTEGGIO').AsString);
end;

procedure TW022FSchedaValutazioniDtM.Q711CalcFields(DataSet: TDataSet);
begin
  inherited;
  Q711.FieldByName('VALUTAZIONE_ORIGINALE').AsString:=IfThen(Q711.FieldByName('DESC_VALUTAZIONE_AGG').IsNull,'S','N');
  if Q711.FieldByName('VALUTAZIONE_ORIGINALE').AsString = 'N' then
    Q711.FieldByName('D_VALUTAZIONE').AsString:=Q711.FieldByName('DESC_VALUTAZIONE_AGG').AsString
  else
  begin
    R180SetVariable(selSG700,'COD_AREA',Q711.FieldByName('COD_AREA').AsString);
    R180SetVariable(selSG700,'DATA',DataRif);
    selSG700.Open;
    selSG700.First;
    if ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'LINK_CONVOGLIA') = 'S' then
      while not selSG700.Eof do
      begin
        if not R180InConcat(selSG700.FieldByName('DESCRIZIONE').AsString,StringReplace(Q711.FieldByName('D_VALUTAZIONE').AsString,CRLF,',',[rfReplaceAll])) then
          Q711.FieldByName('D_VALUTAZIONE').AsString:=Q711.FieldByName('D_VALUTAZIONE').AsString + IfThen(not Q711.FieldByName('D_VALUTAZIONE').IsNull,CRLF) + selSG700.FieldByName('DESCRIZIONE').AsString;
        selSG700.Next;
      end
    else
      Q711.FieldByName('D_VALUTAZIONE').AsString:=VarToStr(selSG700.Lookup('COD_VALUTAZIONE',Q711.FieldByName('COD_VALUTAZIONE').AsString,'DESCRIZIONE'));
  end;
  Q711.FieldByName('D_AREA').AsString:=ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'DESCRIZIONE');
  with selSG711 do
  begin
    Close;
    SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('COD_AREA',Q711.FieldByName('COD_AREA').AsString);
    SetVariable('TIPO_VALUTAZIONE',Q711.FieldByName('TIPO_VALUTAZIONE').AsString);
    SetVariable('STATO_AVANZAMENTO',Q711.FieldByName('STATO_AVANZAMENTO').AsInteger);
    Open;
    //Calcolo il peso dell'area
    if ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA_BASE_100') = 'S' then
      Q711.FieldByName('PERC_AREA').AsFloat:=StrToFloatDef(ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA'),0)
    else
      while not Eof do
      begin
        Q711.FieldByName('PERC_AREA').AsFloat:=Q711.FieldByName('PERC_AREA').AsFloat + FieldByName('PERC_VALUTAZIONE').AsFloat;
        Next;
      end;
    //Calcolo il peso dell'elemento e il punteggio dell'area
    First;
    while not Eof do
    begin
      Q711.FieldByName('PUNTEGGIO_AREA').AsFloat:=Q711.FieldByName('PUNTEGGIO_AREA').AsFloat + FieldByName('PUNTEGGIO_PESATO').AsFloat;
      Next;
    end;
  end;
  if ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'PUNTEGGI_CON_SOGLIA') = 'S' then
    VisColSogliaPunteggio:=True;
  if ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'ITEM_TUTTI_VALUTABILI') <> 'S' then
    VisColItemValutabile:=True;
  if VarToStr(selSG730.Lookup('GIUSTIFICA','S','GIUSTIFICA')) = 'S' then
    VisColNotePunteggio:=True;
  Q711.FieldByName('PUNTEGGI_ABILITATI').AsString:=IfThen((sTipoVal2 = 'A') and (VarToStr(selSG746.Lookup('CREA_AUTOVALUTAZIONE','S','CREA_AUTOVALUTAZIONE')) = 'S'),'S',ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'PUNTEGGI_ABILITATI'));
  Q711.FieldByName('ELEMENTI_ABILITATI').AsString:=IfThen((sTipoVal2 = 'A') and (VarToStr(selSG746.Lookup('CREA_AUTOVALUTAZIONE','S','CREA_AUTOVALUTAZIONE')) = 'S'),'N',ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'ELEMENTI_ABILITATI'));
  Q711.FieldByName('D_PUNTEGGIO').AsString:=IfThen((VarToStr(selSG730.Lookup('CODICE',Q711.FieldByName('COD_PUNTEGGIO').AsString,'ITEM_GIUDICABILE')) = 'N') or (ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'PUNTEGGI_CON_PERCENTUALE') = 'N'),Q711.FieldByName('COD_PUNTEGGIO').AsString,Q711.FieldByName('PUNTEGGIO').AsString);
  Q711.FieldByName('CF_PERC_AREA').AsFloat:=R180Arrotonda(Q711.FieldByName('PERC_AREA').AsFloat,0.001,'P');
  Q711.FieldByName('CF_PUNTEGGIO_AREA').AsFloat:=R180Arrotonda(Q711.FieldByName('PUNTEGGIO_AREA').AsFloat,0.001,'P');
  Q711.FieldByName('CF_PERC_VALUTAZIONE').AsFloat:=R180Arrotonda(Q711.FieldByName('PERC_VALUTAZIONE').AsFloat,0.001,'P');
  Q711.FieldByName('CF_PUNTEGGIO_PESATO').AsFloat:=R180Arrotonda(Q711.FieldByName('PUNTEGGIO_PESATO').AsFloat,0.001,'P');
end;

function TW022FSchedaValutazioniDtM.MotivoSchedaMancante(Data:TDateTime;Prog:Integer;TipoVal:String):String;
var GgMinimi: Integer;
  CodTipiRapp: String;
  ValLiv1,ValLiv2,ValLiv3,ValLiv4:String;
begin
  Result:='';
  DataRif:=Data;
  if QSGruppoValutatore.LocDatoStorico(Data) then
    if  (not QSGruppoValutatore.FieldByName('T430FINE').IsNull)
    and (QSGruppoValutatore.FieldByName('T430FINE').AsDateTime < Data)
    and (QSGruppoValutatore.FieldByName('T430FINE').AsDateTime >= EncodeDate(R180Anno(Data),1,1)) then
      DataRif:=QSGruppoValutatore.FieldByName('T430FINE').AsDateTime;
  RecuperaRegole(DataRif,Prog,'');
  RecuperaAbilitazioneScheda(Data,DataRif,Prog,TipoVal,False);
  //Non in servizio
  with MesiLavorati do
  begin
    SetVariable('DATA_RIF',DataRif);
    SetVariable('CODICI_TIPO_RAPPORTO','');
    SetVariable('PROGR',Prog);
    SetVariable('SALTA_ASSENZE','S');
    Execute;
    if VarToStr(GetVariable('GG_DIFF')) = '' then
    begin
      Result:='Non valutabile: Non in servizio';
      exit;
    end;
  end;
  //Regole non trovate
  if selSG741.FieldByName('CODICE').IsNull then
  begin
    Result:='Non valutabile: Regole non trovate';
    exit;
  end;
  //Tipo rapporto non valutabile o Giorni minimi non coperti
  GgMinimi:=selSG741.FieldByName('GIORNI_MINIMI').AsInteger;
  CodTipiRapp:='''' + StringReplace(selSG741.FieldByName('COD_TIPI_RAPPORTO').AsString,',',''',''',[rfReplaceAll]) + '''';
  with MesiLavorati do
  begin
    SetVariable('DATA_RIF',DataRif);
    SetVariable('CODICI_TIPO_RAPPORTO','AND TIPORAPPORTO IN (' + CodTipiRapp + ')');
    SetVariable('PROGR',Prog);
    SetVariable('SALTA_ASSENZE','N');
    Execute;
    if VarToStr(GetVariable('GG_DIFF')) = '' then
      Result:='Non valutabile: Tipo rapporto non valutabile'
    else if GetVariable('GG_DIFF') < GgMinimi then
    begin
      Result:='Non valutabile: Giorni minimi non coperti';
      if selSG741.FieldByName('VALUTA_CESSATI_RUOLO').AsString = 'S' then
      begin
        R180SetVariable(RuoloCessato,'DATA_RIF',DataRif);
        R180SetVariable(RuoloCessato,'PROGR',Prog);
        R180SetVariable(RuoloCessato,'CODICI_TIPO_RAPPORTO','AND TIPORAPPORTO IN (' + CodTipiRapp + ')');
        RuoloCessato.Open;
        if RuoloCessato.RecordCount > 0 then
          Result:='';
      end;
    end;
    if Result <> '' then
      exit;
  end;
  //Mancanza di aree di valutazione
  ValLiv1:='';
  ValLiv2:='';
  ValLiv3:='';
  ValLiv4:='';
  if QSGruppoValutatore.LocDatoStorico(DataRif) then
  begin
    if Parametri.CampiRiferimento.C21_ValutazioniLiv1 <> '' then
      ValLiv1:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv1).AsString;
    if Parametri.CampiRiferimento.C21_ValutazioniLiv2 <> '' then
      ValLiv2:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv2).AsString;
    if Parametri.CampiRiferimento.C21_ValutazioniLiv3 <> '' then
      ValLiv3:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv3).AsString;
    if Parametri.CampiRiferimento.C21_ValutazioniLiv4 <> '' then
      ValLiv4:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv4).AsString;
  end;
  EstraiAreeValutazione(ValLiv1,ValLiv2,ValLiv3,ValLiv4,DataRif);
  if selSG720.RecordCount = 0 then
  begin
    Result:='Non valutabile: Nessun elemento valutabile';
    exit;
  end;
  if not SoloStampa2 and (VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([DataRif,Prog]),'STAMPA_ABILITATA')) = 'N') then
  begin
    Result:='Non disponibile: Altro ' + RecuperaEtichetta('VALUTATORE_C','L');
    exit;
  end;
  if not SoloStampa2 and (VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([DataRif,Prog]),'STATO_ABILITATO')) = 'N') then
  begin
    Result:='Non disponibile: Inserimento non abilitato';
    exit;
  end;
  Result:='Senza scheda';
end;

function TW022FSchedaValutazioniDtM.SchedeCollegateAperte(var Msg:String): Boolean;
var svMatricola:String;
begin
  Result:=False;
  Msg:='';
  svMatricola:='';
  with selSchedeCollegateAperte do
  begin
    Close;
    SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    //SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    SetVariable('TIPO_VALUTAZIONE','V');//Fino a diversa segnalazione, nell'autovalutazione considero i punteggi assegnati alle schede di VALUTAZIONE altrui, non di AUTOVALUTAZIONE
    SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    Open;
    if RecordCount > 0 then
    begin
      Result:=True;
      Msg:='In attesa della chiusura delle seguenti schede contenenti elementi collegati: ';
    end;
    while not Eof do
    begin
      if FieldByName('MATRICOLA').AsString <> svMatricola then
        Msg:=Msg + CRLF + Format('%s %s',[FieldByName('COGNOME').AsString,FieldByName('NOME').AsString]);
      Msg:=Msg + CRLF + Format('%4s %5s %5s %s',['',FieldByName('COD_AREA').AsString,FieldByName('COD_VALUTAZIONE').AsString,FieldByName('DESCRIZIONE').AsString]);
      svMatricola:=FieldByName('MATRICOLA').AsString;
      Next;
    end;
  end;
end;

function TW022FSchedaValutazioniDtM.SchedeCollegateChiuse(var Msg:String): Boolean;
var svMatricola:String;
begin
  Result:=False;
  Msg:='';
  if Q710.FieldByName('TIPO_VALUTAZIONE').AsString = 'A' then
    exit;//Fino a diversa segnalazione, influiscono sulle schede altrui solo i punteggi assegnati alle schede di VALUTAZIONE, non di AUTOVALUTAZIONE
  svMatricola:='';
  with selSchedeCollegateChiuse do
  begin
    Close;
    SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);//Fino a diversa segnalazione, non blocco l'intervento se ho già chiuso una AUTOVALUTAZIONE collegata
    SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    Open;
    if RecordCount > 0 then
    begin
      Result:=True;
      Msg:='Sono state chiuse le seguenti schede contenenti elementi collegati: ';
    end;
    while not Eof do
    begin
      if FieldByName('MATRICOLA').AsString <> svMatricola then
        Msg:=Msg + CRLF + Format('%s %s',[FieldByName('COGNOME').AsString,FieldByName('NOME').AsString]);
      Msg:=Msg + CRLF + Format('%4s %5s %5s %s',['',FieldByName('COD_AREA').AsString,FieldByName('COD_VALUTAZIONE').AsString,FieldByName('DESCRIZIONE').AsString]);
      svMatricola:=FieldByName('MATRICOLA').AsString;
      Next;
    end;
  end;
end;

function TW022FSchedaValutazioniDtM.AnomaliaRangePesoArea(var Msg:String): Boolean;
var SG711Rowid,CodArea,RPA:String;
    TotPercArea,PAMin,PaMax:Real;
begin
  Result:=False;
  Msg:='';
  with Q711 do
  begin
    SG711Rowid:=Rowid;
    DisableControls;
    //validità peso percentuale area
    First;
    CodArea:=FieldByName('COD_AREA').AsString;
    while not Eof do
    begin
      if FieldByName('COD_AREA').AsString <> CodArea then
      begin
        TotPercArea:=R180Arrotonda(TotPercArea,0.01,'P');//Se metto 5 cifre decimali sballa i confronti con PAMin e PAMax
        if ProprietaArea(CodArea,DataRif,'PESO_ITEM_MODIFICABILE') = 'S' then
        begin
          if ProprietaArea(CodArea,DataRif,'PESO_AREA_BASE_100') = 'S' then
          begin
            PAMin:=100;
            PAMax:=PAMin;
          end
          else
          begin
            RPA:=ProprietaArea(CodArea,DataRif,'RANGE_PESO_AREA');
            PAMin:=StrToFloatDef(Copy(RPA,1,Pos('#',RPA) - 1),0);
            PAMax:=StrToFloatDef(Copy(RPA,Pos('#',RPA) + 1),0);
          end;
          if (TotPercArea < PAMin) or (TotPercArea > PAMax) then
          begin
            Msg:=Msg + IfThen(Msg <> '',CRLF) + 'La somma dei valori indicati in "' + RecuperaEtichetta('PESO_ITEM_C') + '" per l''area ' + CodArea +
                                                 IfThen(PAMin = PAMax,
                                                        ' deve risultare ' + FloatToStr(PAMin),
                                                        ' dev''essere compresa tra ' + FloatToStr(PAMin) + ' e ' + FloatToStr(PAMax)) +
                                                 '! (Attuale: ' + FloatToStr(TotPercArea) + ')';
            Result:=True;
          end;
        end;
        TotPercArea:=0;
        CodArea:=FieldByName('COD_AREA').AsString;
      end;
      TotPercArea:=R180Arrotonda(TotPercArea + FieldByName('PERC_VALUTAZIONE').AsFloat,0.00001,'P');
      Next;
    end;
    TotPercArea:=R180Arrotonda(TotPercArea,0.01,'P');//Se metto 5 cifre decimali sballa i confronti con PAMin e PAMax
    if ProprietaArea(CodArea,DataRif,'PESO_ITEM_MODIFICABILE') = 'S' then
    begin
      if ProprietaArea(CodArea,DataRif,'PESO_AREA_BASE_100') = 'S' then
      begin
        PAMin:=100;
        PAMax:=PAMin;
      end
      else
      begin
        RPA:=ProprietaArea(CodArea,DataRif,'RANGE_PESO_AREA');
        PAMin:=StrToFloatDef(Copy(RPA,1,Pos('#',RPA) - 1),0);
        PAMax:=StrToFloatDef(Copy(RPA,Pos('#',RPA) + 1),0);
      end;
      if (TotPercArea < PAMin) or (TotPercArea > PAMax) then
      begin
        Msg:=Msg + IfThen(Msg <> '',CRLF) + 'La somma dei valori indicati in "' + RecuperaEtichetta('PESO_ITEM_C') + '" per l''area ' + CodArea +
                                             IfThen(PAMin = PAMax,
                                                    ' deve risultare ' + FloatToStr(PAMin),
                                                    ' dev''essere compresa tra ' + FloatToStr(PAMin) + ' e ' + FloatToStr(PAMax)) +
                                             '! (Attuale: ' + FloatToStr(TotPercArea) + ')';
        Result:=True;
      end;
    end;
    SearchRecord('ROWID',SG711Rowid,[srFromBeginning]);
    EnableControls;
  end;
end;

procedure TW022FSchedaValutazioniDtM.CalcolaTotali(AggiornaPFP:Boolean);
var
  TotVal,TotPercArea,TotPercAreaVal,PesoItemNellArea,PercItem: Real;
  CodArea: String;
  BM: TBookMark;
  wPesoAreaBase100: Boolean;
  CodAreaLink,CodItemLink,ElencoProg,Msg:String;
  PunteggioLink:Real;
  nDip,nItemValutabili,nPrior,i:Integer;
begin
  inherited;
  //D711.OnDataChange:=nil;
  CodArea:='';
  TotPercArea:=0;
  TotPerc:=0;
  TotVal:=0;
  with Q711 do
  begin
    DisableControls;
    BM:=GetBookMark;
	  try { TODO : TEST IW 15 }
      //Se non posso intervenire sui pesi, riassegno i pesi originali degli elementi
      First;
      while not Eof do
      begin
        if CodArea <> FieldByName('COD_AREA').AsString then
        begin
          //Assegno/Recupero il resto della divisione partendo dall'ultimo elemento dell'area
          nPrior:=0;
          while TotPercArea <> 0 do
          begin
            Prior;
            inc(nPrior);
            if FieldByName('VALUTABILE').AsString = 'S' then
            begin
              Edit;
              FieldByName('PERC_VALUTAZIONE').AsFloat:=R180Arrotonda(PercItem + (0.00001 * IfThen(TotPercArea < 0,-1,1)),0.00001,'P');
              Post;
              TotPercArea:=R180Arrotonda(TotPercArea + (0.00001 * IfThen(TotPercArea < 0,1,-1)),0.00001,'P');
            end;
          end;
          //Mi riposiziono sul record da analizzare
          for i:=1 to nPrior do
            Next;
        end;
        if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_ITEM_MODIFICABILE') = 'N' then
        begin
          if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_ITEM_EQUO') = 'S' then
          begin
            if CodArea <> FieldByName('COD_AREA').AsString then
            begin
              //Recupero il numero di elementi valutabili
              nItemValutabili:=0;
              selSG711.Close;
              selSG711.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
              selSG711.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
              selSG711.SetVariable('COD_AREA',FieldByName('COD_AREA').AsString);
              selSG711.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
              selSG711.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
              selSG711.Open;
              while not selSG711.Eof do
              begin
                if selSG711.FieldByName('VALUTABILE').AsString = 'S' then
                  inc(nItemValutabili);
                selSG711.Next;
              end;
              TotPercArea:=IfThen(ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA_BASE_100') = 'S',100,StrToFloatDef(ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA'),0));
              PercItem:=0;
              if nItemValutabili > 0 then
                PercItem:=R180Arrotonda(TotPercArea / nItemValutabili,0.00001,'P')
              else
                TotPercArea:=0;
            end;
            Edit;
            if FieldByName('VALUTABILE').AsString = 'S' then
            begin
              FieldByName('PERC_VALUTAZIONE').AsFloat:=R180Arrotonda(PercItem,0.00001,'P');
              TotPercArea:=R180Arrotonda(TotPercArea - PercItem,0.00001,'P');
            end
            else
              FieldByName('PERC_VALUTAZIONE').AsFloat:=0;
            Post;
          end
          else
          begin
            R180SetVariable(selSG700,'COD_AREA',FieldByName('COD_AREA').AsString);
            R180SetVariable(selSG700,'DATA',DataRif);
            selSG700.Open;
            Edit;
            FieldByName('PERC_VALUTAZIONE').AsFloat:=StrToFloatDef(VarToStr(selSG700.Lookup('COD_VALUTAZIONE',FieldByName('COD_VALUTAZIONE').AsString,'PESO_PERCENTUALE')),0);
            Post;
          end;
        end;
        CodArea:=FieldByName('COD_AREA').AsString;
        Next;
      end;
      //Assegno/Recupero il resto della divisione partendo dall'ultimo elemento dell'area
      while TotPercArea <> 0 do
      begin
        if FieldByName('VALUTABILE').AsString = 'S' then
        begin
          Edit;
          FieldByName('PERC_VALUTAZIONE').AsFloat:=R180Arrotonda(PercItem + (0.00001 * IfThen(TotPercArea < 0,-1,1)),0.00001,'P');
          Post;
          TotPercArea:=R180Arrotonda(TotPercArea + (0.00001 * IfThen(TotPercArea < 0,1,-1)),0.00001,'P');
        end;
        Prior;
      end;
      SessioneOracle.ApplyUpdates([Q711],True);
      //Se non posso intervenire sui pesi, ricalcolo i pesi degli elementi se ci sono elementi non valutabili
      CodArea:='';
      First;
      while not Eof do
      begin
        if (ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_ITEM_MODIFICABILE') = 'N')
        and (ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_ITEM_EQUO') = 'N') then
        begin
          if CodArea <> FieldByName('COD_AREA').AsString then
          begin
            TotPercArea:=0;
            TotPercAreaVal:=0;
            selSG711.Close;
            selSG711.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
            selSG711.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
            selSG711.SetVariable('COD_AREA',FieldByName('COD_AREA').AsString);
            selSG711.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
            selSG711.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
            selSG711.Open;
            while not selSG711.Eof do
            begin
              TotPercArea:=R180Arrotonda(TotPercArea + selSG711.FieldByName('PERC_VALUTAZIONE').AsFloat,0.00001,'P');
              if selSG711.FieldByName('VALUTABILE').AsString = 'S' then
                TotPercAreaVal:=R180Arrotonda(TotPercAreaVal + selSG711.FieldByName('PERC_VALUTAZIONE').AsFloat,0.00001,'P');
              selSG711.Next;
            end;
            CodArea:=FieldByName('COD_AREA').AsString;
          end;
          Edit;
          if FieldByName('VALUTABILE').AsString = 'S' then
            FieldByName('PERC_VALUTAZIONE').AsFloat:=R180Arrotonda(FieldByName('PERC_VALUTAZIONE').AsFloat * TotPercArea / TotPercAreaVal,0.00001,'P')
          else
            FieldByName('PERC_VALUTAZIONE').AsFloat:=0;
          Post;
        end;
        Next;
      end;
      SessioneOracle.ApplyUpdates([Q711],True);
      //Una volta consolidati i pesi degli elementi, calcolo i rispettivi punteggi pesati
      First;
      while not Eof do
      begin
        Edit;
        //Se ho tutte le condizioni, aggiorno i punteggi degli elementi pilotati
        if (ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'LINK_CONVOGLIA') = 'S')
        or (ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'LINK_RIPORTA') = 'S') then
        begin
          //Svuoto il punteggio
          FieldByName('PUNTEGGIO').AsString:='';
          FieldByName('COD_PUNTEGGIO').AsString:='';
          if not SchedeCollegateAperte(Msg) then
          begin
            PunteggioLink:=-1;
            ElencoProg:=',';
            nDip:=0;
            //Recupero gli elementi collegati
            R180SetVariable(selSG700,'COD_AREA',FieldByName('COD_AREA').AsString);
            R180SetVariable(selSG700,'DATA',DataRif);
            selSG700.Open;
            if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'LINK_RIPORTA') = 'S' then
            begin
              selSG700.Filtered:=False;
              selSG700.Filter:='COD_VALUTAZIONE = ''' + FieldByName('COD_VALUTAZIONE').AsString + '''';
              selSG700.Filtered:=True;
            end;
            selSG700.First;
            //Per ogni elemento collegato...
            while not selSG700.Eof do
            begin
              CodAreaLink:=selSG700.FieldByName('COD_AREA_LINK').AsString;
              CodItemLink:=selSG700.FieldByName('COD_VALUTAZIONE_LINK').AsString;
              //Gestione Tipo link Riporta
              if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'LINK_RIPORTA') = 'S' then
              begin
                //...faccio la media dei punteggi assegnati agli altri dipendenti
                //...e poi la pondero sul peso dell'elemento nell'area del dipendente corrente
                //Danilo 17/10/2012: Per coerenza dovrebbe funzionare così anche il Tipo link Convoglia, senza il selSG700.Filter, ma ad AOSTA_REGIONE vogliono diversamente
                selSG711a.Close;
                selSG711a.SetVariable('DATA',FieldByName('DATA').AsDateTime);
                //selSG711a.SetVariable('TIPO_VALUTAZIONE',FieldByName('TIPO_VALUTAZIONE').AsString);
                selSG711a.SetVariable('TIPO_VALUTAZIONE','V');//Fino a diversa segnalazione, nell'autovalutazione considero i punteggi assegnati alle schede di VALUTAZIONE altrui, non di AUTOVALUTAZIONE
                selSG711a.SetVariable('COD_AREA',CodAreaLink);
                selSG711a.SetVariable('COD_VALUTAZIONE',CodItemLink);
                selSG711a.Open;
                if not selSG711a.FieldByName('PUNTEGGIO_MEDIO').IsNull then
                (*Danilo 17/10/2012 begin
                  if ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'LINK_RIPORTA') = 'S' then*)
                    PunteggioLink:=R180Arrotonda(selSG711a.FieldByName('PUNTEGGIO_MEDIO').AsFloat,0.01,'P')
                  (*Danilo 17/10/2012 else
                  begin
                    if PunteggioLink = -1 then
                      PunteggioLink:=0;
                    PunteggioLink:=PunteggioLink + R180Arrotonda(selSG711a.FieldByName('PUNTEGGIO_MEDIO').AsFloat * selSG700.FieldByName('PESO_PERCENTUALE').AsFloat / 100,0.01,'P');
                  end;
                end;*)
              end
              //Gestione Tipo link Convoglia
              else if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'LINK_CONVOGLIA') = 'S' then
              begin
                //...sommo la ponderazione del punteggio sulle schede degli altri dipendenti
                //...e poi la divido per il numero di dipendenti trovati, senza ponderare ulteriormente
                //Danilo 17/10/2012: Per coerenza dovrebbe funzionare come il Tipo link Riporta, senza il selSG700.Filter, ma ad AOSTA_REGIONE vogliono diversamente
                selSG711b.Close;
                selSG711b.SetVariable('DATA',FieldByName('DATA').AsDateTime);
                //selSG711b.SetVariable('TIPO_VALUTAZIONE',FieldByName('TIPO_VALUTAZIONE').AsString);
                selSG711b.SetVariable('TIPO_VALUTAZIONE','V');//Fino a diversa segnalazione, nell'autovalutazione considero i punteggi assegnati alle schede di VALUTAZIONE altrui, non di AUTOVALUTAZIONE
                selSG711b.SetVariable('COD_AREA',CodAreaLink);
                selSG711b.SetVariable('COD_VALUTAZIONE',CodItemLink);
                selSG711b.Open;
                while not selSG711b.Eof do
                begin
                  if PunteggioLink = -1 then
                    PunteggioLink:=0;
                  PunteggioLink:=PunteggioLink + R180Arrotonda(selSG711b.FieldByName('RAGG').AsFloat,0.01,'P');
                  if not R180InConcat(selSG711b.FieldByName('PROGRESSIVO').AsString,ElencoProg) then
                  begin
                    ElencoProg:=ElencoProg + selSG711b.FieldByName('PROGRESSIVO').AsString + ',';
                    inc(nDip);
                  end;
                  selSG711b.Next;
                end;
              end;
              selSG700.Next;
            end;
            selSG700.Filtered:=False;
            if PunteggioLink <> -1 then
            begin
              if nDip > 0 then
                PunteggioLink:=R180Arrotonda(PunteggioLink / nDip,0.01,'P');
              FieldByName('PUNTEGGIO').AsFloat:=PunteggioLink;
            end;
          end;
        end;
      
        TotPercArea:=FieldByName('PERC_AREA').AsFloat;
        if (TotPercArea <> 0)
        and (FieldByName('VALUTABILE').AsString = 'S') then
        begin
          wPesoAreaBase100:=ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA_BASE_100') = 'S';
          PesoItemNellArea:=IfThen(wPesoAreaBase100,FieldByName('PERC_VALUTAZIONE').AsFloat,R180Arrotonda(FieldByName('PERC_VALUTAZIONE').AsFloat * 100 / TotPercArea,0.00001,'P'));
          FieldByName('PUNTEGGIO_PESATO').AsFloat:=R180Arrotonda((FieldByName('PUNTEGGIO').AsFloat * PesoItemNellArea / 100) * TotPercArea / 100,0.00001,'P');
        end
        else
          FieldByName('PUNTEGGIO_PESATO').AsFloat:=0;
        if (FieldByName('PUNTEGGIO_PESATO').AsFloat = 0)
        and FieldByName('PUNTEGGIO').IsNull then
          FieldByName('PUNTEGGIO_PESATO').AsString:='';
        Post;
        Next;
      end;
      SessioneOracle.ApplyUpdates([Q711],True);
      //Ricalcolo i totali
      First;
      CodArea:='';
      while not Eof do
      begin
        if CodArea <> FieldByName('COD_AREA').AsString then
        begin
          TotPerc:=TotPerc + FieldByName('PERC_AREA').AsFloat;
          TotVal:=TotVal + FieldByName('PUNTEGGIO_AREA').AsFloat;
          CodArea:=FieldByName('COD_AREA').AsString;
        end;
        Next;
      end;
      TotVal:=R180Arrotonda(TotVal,0.01,'P');
      GotoBookMark(BM);
	  finally
      FreeBookMark(BM);
	  end;
    EnableControls;
  end;

  if AggiornaPFP then
  begin
    Q710.Edit;
    if (selSG730.RecordCount > 0)
    and (selSG730.FieldByName('CALCOLO_PFP').AsString = 'S') then
      Q710.FieldByName('PUNTEGGIO_FINALE_PESATO').AsFloat:=TotVal
    else
      Q710.FieldByName('PUNTEGGIO_FINALE_PESATO').AsString:='';
    Q710.BeforePost:=nil;
    Q710.AfterPost:=nil;
    Q710.Post;
    Q710.BeforePost:=Q710BeforePost;
    Q710.AfterPost:=Q710AfterPost;
  end;
  //D711.OnDataChange:=D711DataChange;
end;

procedure TW022FSchedaValutazioniDtM.EstraiAreeValutazione(var ValLiv1,ValLiv2,ValLiv3,ValLiv4:String;Data:TDateTime);
begin
  inherited;
  with selSG720 do
  begin
    SetVariable('DATA',Data);
    //Svuoto le variabili da 5 a 8
    SetVariable('COND5','1=2');
    SetVariable('COND6','1=2');
    SetVariable('COND7','1=2');
    SetVariable('COND8','1=2');
    //Tutti i dati valorizzati
    Close;
    SetVariable('COND1','''' + ValLiv1 + ''' IS NOT NULL AND DATO1 = ''' + ValLiv1 + '''');
    SetVariable('COND2','''' + ValLiv2 + ''' IS NOT NULL AND DATO2 = ''' + ValLiv2 + '''');
    SetVariable('COND3','''' + ValLiv3 + ''' IS NOT NULL AND DATO3 = ''' + ValLiv3 + '''');
    SetVariable('COND4','''' + ValLiv4 + ''' IS NOT NULL AND DATO4 = ''' + ValLiv4 + '''');
    Open;
    if RecordCount > 0 then
      Exit;
    //Un dato mancante(3° o 4°)
    Close;
    SetVariable('COND1','''' + ValLiv1 + ''' IS NOT NULL AND DATO1 = ''' + ValLiv1 + '''');
    SetVariable('COND2','''' + ValLiv2 + ''' IS NOT NULL AND DATO2 = ''' + ValLiv2 + '''');
    SetVariable('COND3','DATO3 = '' ''');
    SetVariable('COND4','''' + ValLiv4 + ''' IS NOT NULL AND DATO4 = ''' + ValLiv4 + '''');
    SetVariable('COND5','''' + ValLiv1 + ''' IS NOT NULL AND DATO1 = ''' + ValLiv1 + '''');
    SetVariable('COND6','''' + ValLiv2 + ''' IS NOT NULL AND DATO2 = ''' + ValLiv2 + '''');
    SetVariable('COND7','''' + ValLiv3 + ''' IS NOT NULL AND DATO3 = ''' + ValLiv3 + '''');
    SetVariable('COND8','DATO4 = '' ''');
    Open;
    if RecordCount > 0 then
      Exit;
    //Svuoto le variabili da 5 a 8
    SetVariable('COND5','1=2');
    SetVariable('COND6','1=2');
    SetVariable('COND7','1=2');
    SetVariable('COND8','1=2');
    //Due dati mancanti(3° e 4°)
    Close;
    SetVariable('COND1','''' + ValLiv1 + ''' IS NOT NULL AND DATO1 = ''' + ValLiv1 + '''');
    SetVariable('COND2','''' + ValLiv2 + ''' IS NOT NULL AND DATO2 = ''' + ValLiv2 + '''');
    SetVariable('COND3','DATO3 = '' ''');
    SetVariable('COND4','DATO4 = '' ''');
    Open;
    if RecordCount > 0 then
      Exit;
    //Tre dati mancanti(2°, 3° e 4°)
    Close;
    SetVariable('COND1','''' + ValLiv1 + ''' IS NOT NULL AND DATO1 = ''' + ValLiv1 + '''');
    SetVariable('COND2','DATO2 = '' ''');
    SetVariable('COND3','DATO3 = '' ''');
    SetVariable('COND4','DATO4 = '' ''');
    Open;
    if RecordCount > 0 then
      Exit;
    //Tutti i dati mancanti
    Close;
    SetVariable('COND1','DATO1 = '' ''');
    SetVariable('COND2','DATO2 = '' ''');
    SetVariable('COND3','DATO3 = '' ''');
    SetVariable('COND4','DATO4 = '' ''');
    Open;
    if RecordCount > 0 then
      Exit;
  end;
end;

procedure TW022FSchedaValutazioniDtM.CaricaCDS;
var
  OldProg:Integer;
  OldArea,MotivoNV,StatoScheda:String;
begin
  with cdsRiepilogoSchede do
  begin
    if Active then
      EmptyDataSet;
    if not Active then
      CreateDataSet;
    OldProg:=SelAnagrafeW022.FieldByName('PROGRESSIVO').AsInteger;
    SelAnagrafeW022.First;
    while not SelAnagrafeW022.Eof do
    begin
      QSGruppoValutatore.GetDatiStorici(CampiDaEstrarre,SelAnagrafeW022.FieldByName('PROGRESSIVO').AsInteger,EncodeDate(1900,1,1),EncodeDate(3999,12,31));
      Append;
      FieldByName('A').AsString:='1';
      FieldByName('C').AsString:=SelAnagrafeW022.FieldByName('COGNOME').AsString + ' ' + SelAnagrafeW022.FieldByName('NOME').AsString + ' (' + SelAnagrafeW022.FieldByName('MATRICOLA').AsString + ')';//Nominativo e matricola
      Post;
      OldArea:='';
      selRiepilogoSchede.Close;
      selRiepilogoSchede.SetVariable('TIPO',sTipoVal2);
      selRiepilogoSchede.SetVariable('DATA',DataLavoro2);
      selRiepilogoSchede.SetVariable('PROGRESSIVO',SelAnagrafeW022.FieldByName('PROGRESSIVO').AsInteger);
      selRiepilogoSchede.Open;
      if selRiepilogoSchede.RecordCount = 0 then
      begin
        Edit;
        MotivoNV:=MotivoSchedaMancante(DataLavoro2,SelAnagrafeW022.FieldByName('PROGRESSIVO').AsInteger,sTipoVal2);
        FieldByName('B').AsString:=MotivoNV;//Stato scheda
        Post;
      end
      else
      begin
        RecuperaRegole(DataLavoro2,SelAnagrafeW022.FieldByName('PROGRESSIVO').AsInteger,Copy(selRiepilogoSchede.FieldByName('E').AsString,1,Pos('.',selRiepilogoSchede.FieldByName('E').AsString) - 1));
        StatoScheda:=IfThen(selRiepilogoSchede.FieldByName('G').AsString = 'N','Non valutabile: Impostato dall''ufficio',
                     IfThen(selRiepilogoSchede.FieldByName('B').AsString = 'S','Scheda definitiva',
                     VarToStr(selSG746.Lookup('CODICE',StrToIntDef(Copy(selRiepilogoSchede.FieldByName('E').AsString,Pos('.',selRiepilogoSchede.FieldByName('E').AsString) + 1),0),'DESCRIZIONE'))));
        if selSG741.FieldByName('CODICE').IsNull then
        begin
          Edit;
          FieldByName('B').AsString:=StatoScheda;//Stato scheda
          FieldByName('D').AsString:='P.F.P.: ' + 'N.V.';//Punteggio finale pesato
          Post;
        end
        else
        begin
          while not selRiepilogoSchede.Eof do
          begin
            if selRiepilogoSchede.FieldByName('A').AsString = '1' then
            begin
              Edit;
              FieldByName('B').AsString:=StatoScheda;//Stato scheda
              FieldByName('D').AsString:='P.F.P.: ' + selRiepilogoSchede.FieldByName('F').AsString;//Punteggio finale pesato
              Post;
            end
            else if selRiepilogoSchede.FieldByName('A').AsString = '2' then
            begin
              if selRiepilogoSchede.FieldByName('B').AsString <> OldArea then
              begin
                Append;
                FieldByName('A').AsString:='2';
                FieldByName('B').AsString:='Area: ' + selRiepilogoSchede.FieldByName('B').AsString;//Codice Area
                FieldByName('C').AsString:=selRiepilogoSchede.FieldByName('C').AsString;//Descrizione Area
                Post;
                OldArea:=selRiepilogoSchede.FieldByName('B').AsString;
              end;
              Append;
              FieldByName('A').AsString:='3';
              FieldByName('B').AsString:='Elem: ' + selRiepilogoSchede.FieldByName('D').AsString;//Codice Elemento
              FieldByName('C').AsString:=selRiepilogoSchede.FieldByName('E').AsString;//Descrizione Elemento
              FieldByName('D').AsString:='Punt: ' + selRiepilogoSchede.FieldByName('F').AsString;//Punteggio Elemento
              if selRiepilogoSchede.FieldByName('G').AsString = 'N' then //Valutabile
                FieldByName('D').AsString:=FieldByName('D').AsString + ' (N)';
              Post;
            end;
            selRiepilogoSchede.Next;
          end;
        end;
      end;
      Append;//Riga vuota separatrice
      Post;//Riga vuota separatrice
      SelAnagrafeW022.Next;
    end;
    SelAnagrafeW022.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
    QSGruppoValutatore.GetDatiStorici(CampiDaEstrarre,OldProg,EncodeDate(1900,1,1),EncodeDate(3999,12,31));
    //Mi riposiziono sulle regole prelevate in precedenza
    RecuperaRegole(DataRif,SelAnagrafeW022.FieldByName('PROGRESSIVO').AsInteger,Q710.FieldByName('CODREGOLA').AsString);
  end;
end;

procedure TW022FSchedaValutazioniDtM.RecuperaGruppoIncentivi(Data:TDateTime;Prog:Integer);
begin
  //Azzero il vettore
  GruppoIncentivi.Codice:='';
  GruppoIncentivi.Descrizione:='';
  GruppoIncentivi.OreMin:='00.00';
  GruppoIncentivi.ImpMax:=0;
  GruppoIncentivi.OreAssegnate:='00.00';
  GruppoIncentivi.ImpAssegnato:=0;
  with selSG767 do
  begin
    //Cerco i gruppi degli incentivi e i dipendenti assegnati
    Close;
    SetVariable('ANNO',R180Anno(Data));
    Open;
    //Se trovo il valutato..
    if SearchRecord('PROGRESSIVO',Prog,[srFromBeginning]) then
    begin
      //Prelevo i dati del gruppo
      GruppoIncentivi.Codice:=FieldByName('CODGRUPPO').AsString;
      GruppoIncentivi.Descrizione:=FieldByName('DESCRIZIONE').AsString;
      GruppoIncentivi.OreMin:=FieldByName('NUMORE_MIN_DIRIGENTI').AsString;
      GruppoIncentivi.ImpMax:=FieldByName('IMPORTO_MAX_DIRIGENTI').AsFloat;
      //Per ogni dipendente del gruppo, prelevo l'importo e le ore assegnate
      Filter:='CODGRUPPO = ''' + GruppoIncentivi.Codice + '''';
      Filtered:=True;
      First;
      while not Eof do
      begin
        if FieldByName('PROGRESSIVO').AsInteger <> Prog then
        begin
          selSG710.Close;
          selSG710.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
          selSG710.SetVariable('DATA',Data);
          selSG710.SetVariable('TIPO_VALUTAZIONE','V');
          selSG710.Open;
          if selSG710.RecordCount > 0 then
          begin
            GruppoIncentivi.OreAssegnate:=R180MinutiOre(R180OreMinutiExt(GruppoIncentivi.OreAssegnate) + R180OreMinutiExt(selSG710.FieldByName('ORE_INCENTIVO').AsString));
            GruppoIncentivi.ImpAssegnato:=GruppoIncentivi.ImpAssegnato + selSG710.FieldByName('IMPORTO_INCENTIVO').AsFloat;
          end;
        end;
        Next;
      end;
      Filter:='';
      Filtered:=False;
    end;
  end;
end;

function TW022FSchedaValutazioniDtM.ProprietaArea(CodArea:String;Data:TDateTime;Campo:String):String;
begin
  Result:='';
  R180SetVariable(selSG701,'COD_AREA',CodArea);
  R180SetVariable(selSG701,'DATA',Data);
  with selSG701 do
  begin
    Open;
    if RecordCount > 0 then
    begin
      if Campo = 'RANGE_ITEM_PERSONALIZZATI' then
        Result:=IntToStr(FieldByName('ITEM_PERSONALIZZATI_MIN').AsInteger) + '#' + IntToStr(FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger)
      else if Campo = 'ITEM_PERSONALIZZATI' then
        Result:=IfThen(FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger > 0,'S','N')
      else if Campo = 'TESTO_ITEM_PERSONALIZZATI' then
        Result:=FieldByName('TESTO_ITEM_PERSONALIZZATI').AsString
      else if Campo = 'PESO_ITEM_MODIFICABILE' then
        Result:=FieldByName('PESO_VARIABILE_ITEMS').AsString
      else if Campo = 'PESO_ITEM_EQUO' then
        Result:=FieldByName('PESO_EQUO_ITEMS').AsString
      else if Campo = 'PUNTEGGI_CON_PERCENTUALE' then
        Result:=IfThen(FieldByName('TIPO_PUNTEGGIO_ITEMS').AsString = '1','S','N')
      else if Campo = 'PUNTEGGI_CON_SOGLIA' then
        Result:=IfThen(FieldByName('TIPO_PUNTEGGIO_ITEMS').AsString = '2','S','N')
      else if Campo = 'PUNTEGGI_ABILITATI' then
        Result:=IfThen(R180InConcat(selSG741.FieldByName('CODICE').AsString + '.' + IntToStr(Q711.FieldByName('STATO_AVANZAMENTO').AsInteger),FieldByName('STATI_ABILITATI_PUNTEGGI').AsString),'S','N')
      else if Campo = 'ELEMENTI_ABILITATI' then
        Result:=IfThen(R180InConcat(selSG741.FieldByName('CODICE').AsString + '.' + IntToStr(Q711.FieldByName('STATO_AVANZAMENTO').AsInteger),FieldByName('STATI_ABILITATI_ELEMENTI').AsString),'S','N')
      else if Campo = 'DESCRIZIONE' then
        Result:=FieldByName('DESCRIZIONE').AsString
      else if Campo = 'RANGE_PESO_AREA' then
        Result:=FloatToStr(FieldByName('PESO_PERC_MIN').AsFloat) + '#' + FloatToStr(FieldByName('PESO_PERC_MAX').AsFloat)
      else if Campo = 'PESO_AREA' then
        Result:=FloatToStr(FieldByName('PESO_PERCENTUALE').AsFloat)
      else if Campo = 'ITEM_TUTTI_VALUTABILI' then
        Result:=FieldByName('ITEM_TUTTI_VALUTABILI').AsString
      else if Campo = 'PUNTEGGI_SOLO_ITEM_VALUTABILI' then
        Result:=FieldByName('PUNTEGGI_SOLO_ITEM_VALUTABILI').AsString
      else if Campo = 'LINK_CONVOGLIA' then
        Result:=IfThen(FieldByName('TIPO_LINK_ITEM').AsString = '1','S','N')
      else if Campo = 'LINK_RIPORTA' then
        Result:=IfThen(FieldByName('TIPO_LINK_ITEM').AsString = '2','S','N')
      else if Campo = 'PESO_AREA_BASE_100' then
        Result:=IfThen(FieldByName('TIPO_PESO_PERCENTUALE').AsString = '1','S','N');
    end;
  end;
end;

function TW022FSchedaValutazioniDtM.RecuperaEtichetta(NomeCampo:String;Formato:String = ''):String;
begin
  Result:='';
  if not selSG742.Active then
    exit;
  Result:=Trim(VarToStr(selSG742.Lookup('NOME_CAMPO',NomeCampo,'ETICHETTA')));
  Result:=IfThen(Formato = 'U',UpperCase(Result),IfThen(Formato = 'L',LowerCase(Result),Result));
end;

procedure TW022FSchedaValutazioniDtM.RecuperaRegole(Data:TDateTime; Progressivo:Integer; Codice:String);
begin
  if Codice = '' then
    Codice:=VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([Data,Progressivo]),'CODREGOLA'));
  if Codice = '' then
  begin
    Codice:='#NONE#';
    if (Data <> 0) and (Progressivo <> 0) then
    begin
      selSG741.Close;
      selSG741.SetVariable('CODICE','');
      selSG741.SetVariable('DATA',Data);
      selSG741.Open;
      while not selSG741.Eof do
      begin
        R180SetVariable(selV430a,'HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
        R180SetVariable(selV430a,'QVISTAORACLE',QVistaOracle);
        R180SetVariable(selV430a,'DATALAVORO',Data);
        R180SetVariable(selV430a,'FILTRO',selSG741.FieldByName('FILTRO_ANAGRAFE').AsString);
        R180SetVariable(selV430a,'PROGRESSIVO',Progressivo);
        selV430a.Open;
        if selV430a.SearchRecord('PROGRESSIVO',Progressivo,[srFromBeginning]) then
        begin
          Codice:=selSG741.FieldByName('CODICE').AsString;
          Break;
        end;
        selSG741.Next;
      end;
    end;
    cdsRegole.Append;
    cdsRegole.FieldByName('DATA').AsDateTime:=Data;
    cdsRegole.FieldByName('PROGRESSIVO').AsInteger:=Progressivo;
    cdsRegole.FieldByName('CODREGOLA').AsString:=Codice;
    cdsRegole.Post;
  end;
  //selSG741.Close;
  R180SetVariable(selSG741,'CODICE',Codice);
  R180SetVariable(selSG741,'DATA',Data);
  selSG741.Open;
  selSG741.First;
  //Recupero anche le etichette dei campi
  R180SetVariable(selSG742,'DECORRENZA',selSG741.FieldByName('DECORRENZA').AsDateTime);
  R180SetVariable(selSG742,'CODREGOLA',Codice);
  selSG742.Open;
  //Recupero anche la lista degli stati di avanzamento
  R180SetVariable(selSG746,'DATA',Data);
  R180SetVariable(selSG746,'CODREGOLA',Codice);
  selSG746.Open;
end;

procedure TW022FSchedaValutazioniDtM.RecuperaAbilitazioneScheda(DataScheda,Data:TDateTime;Prog:Integer;TipoVal:String;CercaValutatore:Boolean);
var StatoAbilitato,StampaAbilitata:Boolean;
    FA,Filtro,S:String;
    StatoScheda:Integer;
begin
(*2) sapere se l'operatore corrente può visualizzare la scheda
     perché abilitato ad almeno uno stato del codice regola del dipendente
     e perché quest'ultimo rientrava nel suo filtro anagrafe da valutatore
     (altrimenti segnalare "Non disponibile: Altro valutatore")
  3) sapere se l'operatore corrente può intervenire sulla scheda
     perché soddisfatto il punto 2
     ed è abilitato proprio allo stato attuale della scheda
     (altrimenti segnalare "Non valutabile: Stato scheda non abilitato")*)
  if CercaValutatore then
  begin
    if StrToIntDef(VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([Data,Prog]),'PROGRESSIVO_VALUTATORE')),0) <> 0 then
      exit;
  end
  else
  begin
    if VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([Data,Prog]),'STAMPA_ABILITATA')) <> '' then
      exit;
  end;
  StatoScheda:=IfThen(Q710.RecordCount > 0,Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,1);
  if SoloStampa2 then //Accesso da dipendente/responsabile
  begin
    StampaAbilitata:=not selSG741.FieldByName('CODICE').IsNull;
    StatoAbilitato:=False;
  end
  else //Accesso da valutatore/supervalutatore
  begin
    StampaAbilitata:=not selSG741.FieldByName('CODICE').IsNull and not CercaValutatore and ((TipoVal = 'A') or (Parametri.S710_SupervisoreValut = 'S'));
    StatoAbilitato:=StampaAbilitata;
    if not StampaAbilitata and not selSG741.FieldByName('CODICE').IsNull then
    begin
      //Sono sicuramente abilitato in lettura se sono intervenuto sulla scheda
      if (Q710.RecordCount > 0) and (Parametri.S710_SupervisoreValut <> 'S') then
        StampaAbilitata:=Pos(',' + IntToStr(Parametri.ProgressivoOper) + ',',',' + Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString + ',') > 0;
      //Verifico la presa visione dello stato precedente
      R180SetVariable(selSG745a,'DATA',DataScheda);
      R180SetVariable(selSG745a,'PROGRESSIVO',Prog);
      R180SetVariable(selSG745a,'TIPO_VALUTAZIONE',TipoVal);
      R180SetVariable(selSG745a,'STATO_AVANZAMENTO',StatoScheda - 1);
      selSG745a.Open;
      //Prelevo i filtri anagrafe utilizzabili dall'operatore corrente come valutatore
      R180SetVariable(selI071,'AZIENDA',Parametri.Azienda);
      R180SetVariable(selI071,'PROGRESSIVO',IfThen(CercaValutatore,-1,Parametri.ProgressivoOper));
      R180SetVariable(selI071,'DATA',Data);
      selI071.Open;
      selI071.First;
      while not selI071.Eof do
      begin
        if not StampaAbilitata then
        begin
          //Prelevo il filtro anagrafe
          FA:='';
          R180SetVariable(selI072,'AZIENDA',Parametri.Azienda);
          R180SetVariable(selI072,'FILTRO_ANAGRAFE',selI071.FieldByName('FILTRO_ANAGRAFE').AsString);
          selI072.Open;
          selI072.First;
          while not selI072.Eof do
          begin
            FA:=Trim(FA + ' ' + selI072.FieldByName('FILTRO').AsString);
            selI072.Next;
          end;
          //Gestisco l'eventuale variabile NOME_UTENTE
          FA:=StringReplace(FA,':NOME_UTENTE','''' + selI071.FieldByName('NOME_UTENTE').AsString + '''',[rfReplaceAll,rfIgnoreCase]);
          //Inserisco eventualmente la condizione per le assegnazioni eccezionali
          S:='  OR T430PROGRESSIVO IN (SELECT /*+ UNNEST */ DISTINCT SG706A.PROGRESSIVO_VALUTATO' +
                                            ' FROM SG706_VALUTATORI_DIPENDENTE SG706A, T430_STORICO T430A' +
                                            ' WHERE SG706A.PROGRESSIVO = ' + IntToStr(selI071.FieldByName('PROGRESSIVO').AsInteger) +
                                            ' AND SG706A.PROGRESSIVO_VALUTATO = T430A.PROGRESSIVO' +
                                            ' AND :DATALAVORO BETWEEN T430A.DATADECORRENZA AND T430A.DATAFINE' +
                                            ' AND LEAST(:DATALAVORO,NVL(T430A.FINE,TO_DATE(''31123999'',''DDMMYYYY''))) BETWEEN SG706A.DECORRENZA AND SG706A.DECORRENZA_FINE))' +
             ' AND T030.PROGRESSIVO <> ' + IntToStr(selI071.FieldByName('PROGRESSIVO').AsInteger) +
             ' AND T030.PROGRESSIVO NOT IN (SELECT /*+ UNNEST */ DISTINCT SG706A.PROGRESSIVO_VALUTATO' +
                                            ' FROM SG706_VALUTATORI_DIPENDENTE SG706A, T430_STORICO T430A' +
                                            ' WHERE SG706A.PROGRESSIVO <> ' + IntToStr(selI071.FieldByName('PROGRESSIVO').AsInteger) +
                                            ' AND SG706A.PROGRESSIVO_VALUTATO = T430A.PROGRESSIVO' +
                                            ' AND :DATALAVORO BETWEEN T430A.DATADECORRENZA AND T430A.DATAFINE' +
                                            ' AND LEAST(:DATALAVORO,NVL(T430A.FINE,TO_DATE(''31123999'',''DDMMYYYY''))) BETWEEN SG706A.DECORRENZA AND SG706A.DECORRENZA_FINE)';
          Filtro:=StringReplace(FA,'/*VALUTATORE*/)',S,[rfReplaceAll]);
          //Eseguo ogni filtro anagrafe trovato
          R180SetVariable(selV430b,'HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
          R180SetVariable(selV430b,'QVISTAORACLE',QVistaOracle);
          R180SetVariable(selV430b,'DATALAVORO',Data);
          R180SetVariable(selV430b,'FILTRO',Filtro);
          try
            selV430b.Open;
            if selV430b.SearchRecord('PROGRESSIVO',Prog,[srFromBeginning]) then
              StampaAbilitata:=Pos(',' + selSG741.FieldByName('CODICE').AsString + '.',',' + selI071.FieldByName('S710_STATI_ABILITATI').AsString + ',') > 0;
          except
            //Il filtro è scorretto oppure non esiste (Autovalutatore)
          end;
        end;
        StatoAbilitato:=StampaAbilitata and
                        R180InConcat(selSG741.FieldByName('CODICE').AsString + '.' + IntToStr(StatoScheda),selI071.FieldByName('S710_STATI_ABILITATI').AsString) and
                        (   (VarToStr(selSG746.Lookup('CODICE',StatoScheda,'MODIFICABILE')) = 'S')
                         or (selSG745a.FieldByName('PRESA_VISIONE').AsString = 'S'));
        if StatoAbilitato then
          Break
        else
          selI071.Next;
      end;
    end;
  end;
  if not cdsRegole.Locate('DATA;PROGRESSIVO',VarArrayOf([Data,Prog]),[]) then
  begin
    cdsRegole.Append;
    cdsRegole.FieldByName('DATA').AsDateTime:=Data;
    cdsRegole.FieldByName('PROGRESSIVO').AsInteger:=Prog;
    cdsRegole.Post;
  end;
  if cdsRegole.Locate('DATA;PROGRESSIVO',VarArrayOf([Data,Prog]),[]) then
  begin
    cdsRegole.Edit;
    cdsRegole.FieldByName('STAMPA_ABILITATA').AsString:=IfThen(StampaAbilitata,'S','N');
    cdsRegole.FieldByName('STATO_ABILITATO').AsString:=IfThen(StatoAbilitato,'S','N');
    if CercaValutatore and StatoAbilitato then
      cdsRegole.FieldByName('PROGRESSIVO_VALUTATORE').AsInteger:=selI071.FieldByName('PROGRESSIVO').AsInteger;
    cdsRegole.Post;
  end;
end;

procedure TW022FSchedaValutazioniDtM.EliminaValidazioni;
begin
  with selSG745 do
  begin
    //Cancello i rifiuti del validatore
    Close;
    SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    Open;
    while SearchRecord('TIPO_CONSEGNA','VS',[srFromBeginning]) do
      Delete;
  end;
end;

function TW022FSchedaValutazioniDtM.FPeriodoOKCompilazione(Stato:Integer;TipoVal:String;var DataDa,DataA:TDateTime):Boolean;
var StatoDa,StatoA,x:Integer;
begin
  Result:=False;
  StatoDa:=Stato;
  StatoA:=Stato;
  if (TipoVal = 'A') and (VarToStr(selSG746.Lookup('CREA_AUTOVALUTAZIONE','S','CREA_AUTOVALUTAZIONE')) = 'S') then
  begin
    //Prelevo lo stato duplicabile
    StatoDa:=selSG746.Lookup('CREA_AUTOVALUTAZIONE','S','CODICE');
    //Permetto la modifica durante lo stato duplicabile più il successivo (che di solito è quello in cui viene visualizzato) a meno che quello duplicabile sia già l'ultimo
    StatoA:=IfThen(VarToStr(selSG746.Lookup('CODICE',StatoDa + 1,'CODICE')) = '',StatoDa,StatoDa + 1);
  end;
  if VarToStr(selSG746.Lookup('CODICE',StatoDa,'DATA_DA')) = '' then
  begin
    DataDa:=EncodeDate(1900,1,1);
    DataA:=EncodeDate(1900,1,1);
  end
  else
  begin
    DataDa:=selSG746.Lookup('CODICE',StatoDa,'DATA_DA');
    DataA:=selSG746.Lookup('CODICE',StatoA,'DATA_A');
  end;
  Result:=(Parametri.S710_SupervisoreValut = 'S') or ((Trunc(R180SysDate(SessioneOracle)) >= DataDa) and (Trunc(R180SysDate(SessioneOracle)) <= DataA));
end;

function TW022FSchedaValutazioniDtM.FPeriodoOKObiettivi(EsisteFaseAssegnazionePreventivaObiettivi:Boolean):Boolean;
var DataDa,DataA:TDateTime;
begin
  if selSG741.FieldByName('DATA_DA_OBIETTIVI').IsNull then
  begin
    DataDa:=EncodeDate(1900,1,1);
    DataA:=EncodeDate(1900,1,1);
  end
  else
  begin
    DataDa:=selSG741.FieldByName('DATA_DA_OBIETTIVI').AsDateTime;
    DataA:=selSG741.FieldByName('DATA_A_OBIETTIVI').AsDateTime;
  end;
  Result:=EsisteFaseAssegnazionePreventivaObiettivi and ((Parametri.S710_SupervisoreValut = 'S') or ((Trunc(R180SysDate(SessioneOracle)) >= DataDa) and (Trunc(R180SysDate(SessioneOracle)) <= DataA)));
end;

procedure TW022FSchedaValutazioniDtM.InviaEMail(Operazione:String;StatoPartenza:Integer);
var sOggetto,sTesto: String;
    CodStampa,nTag: Integer;
begin
  if (selSG741.FieldByName('INVIO_EMAIL').AsString <> 'S')
  or (Q710.FieldByName('TIPO_VALUTAZIONE').AsString = 'A')
  or (Parametri.S710_SupervisoreValut = 'S') then
    exit;
  // Invio email al valutato se uno stato è diventato visualizzabile
  if Operazione = 'A' then //avanza stato
    CodStampa:=StrToIntDef(VarToStr(selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([selSG741.FieldByName('CODICE').AsString,StatoPartenza + 1]),'CODSTAMPA')),0)
  else if Operazione = 'C' then //chiudi scheda
    CodStampa:=StatoPartenza;
  if CodStampa <> 0 then
    try
      sOggetto:='Scheda di Valutazione: Avanzamento';
      sTesto:='La scheda di Valutazione' + IfThen(Q710.FieldByName('DATA').AsDateTime = EncodeDate(R180Anno(Q710.FieldByName('DATA').AsDateTime),12,31),
                                                  ' per l''anno ' + FormatDateTime('yyyy',Q710.FieldByName('DATA').AsDateTime),
                                                  ' al ' + FormatDateTime('dd/mm/yyyy',Q710.FieldByName('DATA').AsDateTime)) +
              ' nello stato "' + IfThen(Operazione = 'C','Scheda definitiva',VarToStr(selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([selSG741.FieldByName('CODICE').AsString,CodStampa]),'DESCRIZIONE'))) + '"' +
              ' è ora disponibile nell''area riservata di IrisWeb.';
      nTag:=443; //"Stampa scheda di valutazione" per il valutato
      WR000DM.InviaEMail(False,Q710.FieldByName('PROGRESSIVO').AsInteger,sOggetto,sTesto,nTag);
    except
    end;
end;

end.
