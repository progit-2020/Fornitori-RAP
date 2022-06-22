unit A121URecapitiSindacaliMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Oracle, Data.DB,
  OracleData, A000UInterfaccia, A000UCostanti, C180FunzioniGenerali;

type
  TA121RefreshVar = procedure of Object;

  TA121FRecapitiSindacaliMW = class(TR005FDataModuleMW)
    selRaggruppatoIn: TOracleDataSet;
    selRaggruppamenti: TOracleDataSet;
    delCollegateOrg: TOracleQuery;
    delCollegate: TOracleQuery;
    ControlloRaggruppamento: TOracleQuery;
    ControlloCompetenze: TOracleQuery;
    ControlloRSU: TOracleQuery;
    selT200: TOracleDataSet;
    selT200CODICE: TStringField;
    selT200DESCRIZIONE: TStringField;
    selT200TIPO: TStringField;
    dsrT480: TDataSource;
    selT480: TOracleDataSet;
    selT240A: TOracleDataSet;
    dsrT265: TDataSource;
    selT265: TOracleDataSet;
    selT245: TOracleDataSet;
    selT245CODICE: TStringField;
    selT245DESCRIZIONE: TStringField;
    dsrT245: TDataSource;
    selT241: TOracleDataSet;
    selT241CODICE: TStringField;
    selT241DECORRENZA: TDateTimeField;
    selT241TIPO_RECAPITO: TStringField;
    selT241PROG_RECAPITO: TIntegerField;
    selT241DESCRIZIONE: TStringField;
    selT241INDIRIZZO: TStringField;
    selT241Citta: TStringField;
    selT241Provincia: TStringField;
    selT241COMUNE: TStringField;
    selT241CAP: TStringField;
    selT241TELEFONO: TStringField;
    selT241FAX: TStringField;
    selT241COGNOME: TStringField;
    selT241NOME: TStringField;
    selT241TELEFONO_CASA: TStringField;
    selT241TELEFONO_UFFICIO: TStringField;
    selT241CELLULARE: TStringField;
    selT241EMAIL: TStringField;
    dsrT241: TDataSource;
    selT242: TOracleDataSet;
    selT242CODICE: TStringField;
    selT242CONTRATTO: TStringField;
    selT242DESC_CONTRATTO: TStringField;
    selT242TIPO: TStringField;
    selT242DESC_TIPO: TStringField;
    selT242DECORRENZA: TDateTimeField;
    selT242SCADENZA: TDateTimeField;
    selT242COMPETENZA: TStringField;
    selT242FRUITO: TStringField;
    selT242RESIDUO: TStringField;
    selT242AREA_SINDACALE: TStringField;
    selT242ANNO: TStringField;
    dsrT242: TDataSource;
    selT241MaxProg: TOracleQuery;
    selT480CODICE: TStringField;
    selT480CITTA: TStringField;
    selT480CAP: TStringField;
    selT480PROVINCIA: TStringField;
    selT480CODCATASTALE: TStringField;
    procedure selT242COMPETENZAValidate(Sender: TField);
    procedure selT242BeforePost(DataSet: TDataSet);
    procedure selT242ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selT242CalcFields(DataSet: TDataSet);
    procedure selT242NewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT242SCADENZAValidate(Sender: TField);
  private
    { Private declarations }
  public
    selT240: TOracleDataSet;
    ListaSindacati: TStringList;
    RqStoriciPrec, RqStoriciSucc: Boolean;
    AggiornaVariabiliMW: TA121RefreshVar;
    procedure AfterScroll;
    procedure BeforePost;
    procedure FieldCODICEValidate;
    procedure FieldRSUValidate;
    procedure FieldRAGGRUPPAMENTOValidate;
    procedure PreparaListaSindacati;
    procedure CancellaCollegate;
    procedure SelT241BeforePost;
    procedure FiltraAnnoCorrente(RqAnnoCorrente: Boolean);
    const
      D_TipoRecapito:array[0..4] of TItemsValues = ((Item:'Aziendale';  Value:'A'),
                                                   (Item:'Provinciale'; Value:'P'),
                                                   (Item:'Regionale';   Value:'R'),
                                                   (Item:'Nazionale';   Value:'N'),
                                                   (Item:'Generico';    Value:'G'));
      D_TipoContratto:array[0..1] of TItemsValues = ((Item:'Individuale';  Value:'I'),
                                                    (Item:'Collettivo';    Value:'C'));
  end;

implementation

{$R *.dfm}

procedure TA121FRecapitiSindacaliMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ListaSindacati:=TStringList.Create;
  selT242CONTRATTO.LookupDataSet:=selT200;
  selT242DESC_CONTRATTO.LookupDataSet:=selT200;
  selT241Citta.LookupDataSet:=selT480;
  selT241Provincia.LookupDataSet:=selT480;
  selT480.SetVariable('ORDERBY', 'ORDER BY CITTA');
  selT480.Open;
  selT245.Open;
  selT265.Open;
  selT265.FieldByName('CODICE').DisplayWidth:=8;
end;

procedure TA121FRecapitiSindacaliMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ListaSindacati);
end;

procedure TA121FRecapitiSindacaliMW.AfterScroll;
begin
  selT241.Close;
  selT241.SetVariable('CODICE', selT240.FieldByName('CODICE').AsString);
  selT241.Open;
  selT242.Close;
  selT242.SetVariable('CODICE', selT240.FieldByName('CODICE').AsString);
  selT242.Open;
  //Commento già presente prima di MW
  //selT242.FieldByName('FRUITO').Visible:=selT240.FieldByName('RSU').AsString = 'N';
  //selT242.FieldByName('RESIDUO').Visible:=selT240.FieldByName('RSU').AsString = 'N';
end;

procedure TA121FRecapitiSindacaliMW.BeforePost;
var
  Elenco:TStringList;
  i:Integer;
begin
  inherited;
  if (selT240.FieldByName('RAGGRUPPAMENTO').AsString = 'S') and
     (Trim(selT240.FieldByName('SINDACATI_RAGGRUPPATI').AsString) = '') then
    raise exception.Create('Specificare i sindacati raggruppati!');
  // Controllo sull'elenco dei sindacati
  PreparaListaSindacati;
  Elenco:=TStringList.Create;
  Elenco.CommaText:=selT240.FieldByName('SINDACATI_RAGGRUPPATI').AsString;
  for i:=0 to Elenco.Count - 1 do
    if R180IndexOf(ListaSindacati,Elenco.Strings[i],Length(Elenco.Strings[i])) = -1 then
      raise exception.Create('Sindacati raggruppati non validi!');
  FreeAndNil(Elenco);
end;

procedure TA121FRecapitiSindacaliMW.FieldRSUValidate;
begin
  inherited;
  //VERIFICA se nel periodo considerato esiste già un altro sindacato come RSU
  //ControlloRSU: estrae il numero di sindacati che nel periodo considerato sono RSU
  if selT240.FieldByName('RSU').AsString = 'S' then
  begin
    AggiornaVariabiliMW;
    if RqStoriciPrec then
      ControlloRSU.SetVariable('INIZIO','N')
    else
      ControlloRSU.SetVariable('INIZIO','S');
    if RqStoriciSucc then
      ControlloRSU.SetVariable('FINE','N')
    else
      ControlloRSU.SetVariable('FINE','S');
    ControlloRSU.SetVariable('CODICE',selT240.FieldByName('CODICE').AsString);
    ControlloRSU.SetVariable('DECORRENZA',selT240.FieldByName('DECORRENZA').AsDateTime);
    ControlloRSU.Execute;
    if ControlloRSU.Field(0) > 0 then
      raise exception.Create('Non è possibile inserire più di un RSU valido nello stesso periodo!');
  end;
end;

procedure TA121FRecapitiSindacaliMW.FieldRAGGRUPPAMENTOValidate;
begin
  inherited;
  //VERIFICA se il sindacato nel periodo considerato fa già parte di altri raggruppamenti
  //ControlloRaggruppamento: estrae il numero di sindacati che nel periodo considerato
  //  contengono nei sindacati raggruppati il sindacato considerato
  if selT240.FieldByName('RAGGRUPPAMENTO').AsString = 'S' then
  begin
    AggiornaVariabiliMW;
    if RqStoriciPrec then
      ControlloRaggruppamento.SetVariable('INIZIO','N')
    else
      ControlloRaggruppamento.SetVariable('INIZIO','S');
    if RqStoriciSucc then
      ControlloRaggruppamento.SetVariable('FINE','N')
    else
      ControlloRaggruppamento.SetVariable('FINE','S');
    ControlloRaggruppamento.SetVariable('CODICE',selT240.FieldByName('CODICE').AsString);
    ControlloRaggruppamento.SetVariable('DECORRENZA',selT240.FieldByName('DECORRENZA').AsDateTime);
    ControlloRaggruppamento.Execute;
    if ControlloRaggruppamento.Field(0) > 0 then
      raise exception.Create('Questo sindacato nello stesso periodo fa già parte di un altro raggruppamento!');
  end;
end;

procedure TA121FRecapitiSindacaliMW.FieldCODICEValidate;
begin
  inherited;
  if (Pos(' ',selT240.FieldByName('Codice').AsString) > 0) or
     (Pos(',',selT240.FieldByName('Codice').AsString) > 0) or
     (Pos('.',selT240.FieldByName('Codice').AsString) > 0) or
     (Pos(';',selT240.FieldByName('Codice').AsString) > 0) then
    raise exception.Create('Non è possibile inserire caratteri speciali nel codice!');
end;

procedure TA121FRecapitiSindacaliMW.selT242ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  //Controllo data
  if (Trim(selT242.FieldByName('SCADENZA').AsString) <> '') and
     (selT242.FieldByName('SCADENZA').AsDateTime < selT242.FieldByName('DECORRENZA').AsDateTime) then
    raise exception.Create('La data scadenza non può essere inferiore alla data decorrenza!');
  //ControlloCompetenze: a livello di codice e area sindacale estrae il numero di periodi
  //  che intersecano il periodo corrente
  if Action in ['I','U'] then
  begin
    ControlloCompetenze.SetVariable('CODICE',selT242CODICE.AsString);
    ControlloCompetenze.SetVariable('AREA',selT242AREA_SINDACALE.AsString);
    ControlloCompetenze.SetVariable('TIPO',selT242TIPO.AsString);
    ControlloCompetenze.SetVariable('DECORRENZA',selT242DECORRENZA.AsDateTime);
    if Trim(selT242SCADENZA.AsString) = '' then
      ControlloCompetenze.SetVariable('SCADENZA',StrToDate('31/12/3999'))
    else
      ControlloCompetenze.SetVariable('SCADENZA',selT242SCADENZA.AsDateTime);
    if selT242.RowId <> '' then
      ControlloCompetenze.SetVariable('NUMRIGA','AND ROWID <> ''' + selT242.RowId + '''');
    ControlloCompetenze.Execute;
    if ControlloCompetenze.Field(0) > 0 then
      raise Exception.Create('Non è possibile inserire periodi incrociati!');
  end;
  if Action in ['I','U','D'] then
  begin
    case Action of
      'I':RegistraLog.SettaProprieta('I','T242_COMPETENZESINDACATI','A121',selT242,True);
      'U':RegistraLog.SettaProprieta('M','T242_COMPETENZESINDACATI','A121',selT242,True);
      'D':RegistraLog.SettaProprieta('C','T242_COMPETENZESINDACATI','A121',selT242,True);
    end;
    RegistraLog.RegistraOperazione;
  end;
  inherited;
end;

procedure TA121FRecapitiSindacaliMW.selT242BeforePost(DataSet: TDataSet);
begin
  inherited;
  selT242.FieldByName('TIPO').AsString:=UpperCase(selT242.FieldByName('TIPO').AsString);
end;

procedure TA121FRecapitiSindacaliMW.selT242CalcFields(DataSet: TDataSet);
var i: Integer;
begin
  inherited;
  selT242.FieldByName('DESC_TIPO').AsString:='';
  for i := 0 to High(D_TipoContratto) do
    if selT242.FieldByName('TIPO').AsString = D_TipoContratto[i].Value  then
      selT242.FieldByName('DESC_TIPO').AsString:=D_TipoContratto[i].Item;
end;

procedure TA121FRecapitiSindacaliMW.selT242COMPETENZAValidate(Sender: TField);
begin
  inherited;
  if Trim(selT242.FieldByName('COMPETENZA').AsString) <> '.' then
    OreMinutiValidate(selT242.FieldByName('COMPETENZA').AsString);
end;

procedure TA121FRecapitiSindacaliMW.selT242NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT242.FieldByName('CODICE').AsString:=selT240.FieldByName('CODICE').AsString;
end;

procedure TA121FRecapitiSindacaliMW.selT242SCADENZAValidate(Sender: TField);
begin
  inherited;
  if (Trim(selT242.FieldByName('SCADENZA').AsString) <> '') and
     (selT242.FieldByName('SCADENZA').AsDateTime < selT242.FieldByName('DECORRENZA').AsDateTime) then
    raise exception.Create('La data scadenza non può essere inferiore alla data decorrenza!');
end;

procedure TA121FRecapitiSindacaliMW.PreparaListaSindacati;
var ListaRaggruppamenti:TStringList;
    ListaAppoggio:TStringList;
    s:String;
begin
  // CONTROLLO ELENCO SINDACATI:
  // selRaggruppamenti: estrae l'elenco dei sindacati (codice e sindacati raggruppati) che nel
  //   periodo considerato sono Raggruppamenti oppure RSU
  // ListaRaggruppamenti: contiene i sindacati estratti con selRaggruppamenti +
  //   il codice del sindacato corrente
  AggiornaVariabiliMW;
  ListaRaggruppamenti:=TStringList.Create;
  ListaAppoggio:=TStringList.Create;
  ListaRaggruppamenti.Clear;
  selRaggruppamenti.Close;
  if RqStoriciPrec then
    selRaggruppamenti.SetVariable('INIZIO','N')
  else
    selRaggruppamenti.SetVariable('INIZIO','S');
  if RqStoriciSucc then
    selRaggruppamenti.SetVariable('FINE','N')
  else
    selRaggruppamenti.SetVariable('FINE','S');
  selRaggruppamenti.SetVariable('CODICE',selT240.FieldByName('CODICE').AsString);
  selRaggruppamenti.SetVariable('DECORRENZA',selT240.FieldByName('DECORRENZA').AsDateTime);
  selRaggruppamenti.Open;
  selRaggruppamenti.First;
  while not selRaggruppamenti.Eof do
  begin
    ListaAppoggio.Clear;
    ListaRaggruppamenti.Add('''' + selRaggruppamenti.FieldByName('CODICE').AsString + '''');
    if selRaggruppamenti.FieldByName('SINDACATI_RAGGRUPPATI').AsString <> '' then
      ListaAppoggio.CommaText:='''' + selRaggruppamenti.FieldByName('SINDACATI_RAGGRUPPATI').AsString + '''';
    ListaRaggruppamenti.AddStrings(ListaAppoggio);
    selRaggruppamenti.Next;
  end;
  ListaRaggruppamenti.Add('''' + selT240.FieldByName('CODICE').AsString + '''');
  s:='CODICE NOT IN (' + ListaRaggruppamenti.CommaText + ')';
  FreeAndNil(ListaRaggruppamenti);
  FreeAndNil(ListaAppoggio);
  // PREPARAZIONE LISTA SINDACATI
  // selT240A: estrae l'elenco dei sindacati non presenti nella ListaRaggruppamenti
  //   prendendo in considerazione l'ultima decorrenza antecedente la decorrenza corrente
  ListaSindacati.Clear;
  with selT240A do
  begin
    SetVariable('CODICE',s);
    SetVariable('DECORRENZA',selT240.FieldByName('DECORRENZA').AsDateTime);
    Open;
    while not Eof do
    begin
      ListaSindacati.Add(Format('%-10s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    Close;
  end;
end;

procedure TA121FRecapitiSindacaliMW.CancellaCollegate;
begin
  delCollegate.SetVariable('CODICE',selT240.FieldByName('CODICE').AsString);
  delCollegate.Execute;
end;

procedure TA121FRecapitiSindacaliMW.FiltraAnnoCorrente(RqAnnoCorrente :Boolean);
var Anno:Integer;
begin
  inherited;
  Anno:=R180Anno(Parametri.DataLavoro);
  if RqAnnoCorrente then
  begin
    if not (selT242.FieldByName('SCADENZA').IsNull) then
      Anno:=R180Anno(selT242.FieldByName('SCADENZA').AsDateTime);
    selT242.Filter:='(DECORRENZA <= ' + FloatToStr(EncodeDate(Anno,12,31)) + ') AND (ANNO >= ' + IntToStr(Anno) + ')';
    selT242.Filtered:=True;
  end
  else
  begin
    selT242.Filter:='';
    selT242.Filtered:=False;
  end;
end;

procedure TA121FRecapitiSindacaliMW.SelT241BeforePost;
begin
  if (selT241.FieldByName('TIPO_RECAPITO').AsString = 'A') and
    (Trim(selT241.FieldByName('INDIRIZZO').AsString) = '') and
    (Trim(selT241.FieldByName('COMUNE').AsString) = '') then
    selT241.FieldByName('INDIRIZZO').AsString:='SEDE';
end;

end.
