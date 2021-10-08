unit A100UCheckRimborsiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData,
  A000UCostanti, A000UInterfaccia, C180FunzioniGenerali, System.StrUtils, System.Variants, Oracle,
  Datasnap.DBClient;

type
  TA100FCheckRimborsiMW = class(TR005FDataModuleMW)
    selM040CheckRimb: TOracleDataSet;
    dsrM040CheckRimb: TDataSource;
    selM170: TOracleDataSet;
    selM170CODICE: TStringField;
    selM170DESCRIZIONE: TStringField;
    selM170TARGA: TStringField;
    dsrM170: TDataSource;
    selM175: TOracleDataSet;
    selM175CODICE: TStringField;
    selM175DESCRIZIONE: TStringField;
    selM175VALORE: TStringField;
    dsrM175: TDataSource;
    dsrM051: TDataSource;
    selM051: TOracleDataSet;
    selM052: TOracleDataSet;
    dsrM052: TDataSource;
    selM051PROGRESSIVO: TFloatField;
    selM051MESESCARICO: TDateTimeField;
    selM051MESECOMPETENZA: TDateTimeField;
    selM051DATADA: TDateTimeField;
    selM051ORADA: TStringField;
    selM051CODICERIMBORSOSPESE: TStringField;
    selM051PROGRIMBORSO: TFloatField;
    selM051DATARIMBORSO: TDateTimeField;
    selM051TIPORIMBORSO: TStringField;
    selM051STATO: TStringField;
    selM051NOTE: TStringField;
    selM052PROGRESSIVO: TFloatField;
    selM052MESESCARICO: TDateTimeField;
    selM052MESECOMPETENZA: TDateTimeField;
    selM052DATADA: TDateTimeField;
    selM052ORADA: TStringField;
    selM052CODICEINDENNITAKM: TStringField;
    selM052KMPERCORSI: TFloatField;
    selM052ID_MISSIONE: TIntegerField;
    selM052STATO: TStringField;
    selM052NOTE: TStringField;
    selM052KMPERCORSI_ORIGINALI: TFloatField;
    selM051IMPORTO: TFloatField;
    selM051IMPORTO_VALEST2: TFloatField;
    selM051IMPORTO_ORIGINALE: TFloatField;
    selM040CheckRimbNOMINATIVO: TStringField;
    selM040CheckRimbMATRICOLA: TStringField;
    selM040CheckRimbPROGRESSIVO: TFloatField;
    selM040CheckRimbMESESCARICO: TDateTimeField;
    selM040CheckRimbMESECOMPETENZA: TDateTimeField;
    selM040CheckRimbDATADA: TDateTimeField;
    selM040CheckRimbORADA: TStringField;
    selM040CheckRimbPROTOCOLLO: TStringField;
    selM040CheckRimbTIPOREGISTRAZIONE: TStringField;
    selM040CheckRimbDATAA: TDateTimeField;
    selM040CheckRimbORAA: TStringField;
    selM040CheckRimbDURATA: TStringField;
    selM040CheckRimbCOMMESSA: TStringField;
    selM040CheckRimbSTATO: TStringField;
    selM040CheckRimbFLAG_DESTINAZIONE: TStringField;
    selM040CheckRimbFLAG_ISPETTIVA: TStringField;
    selM040CheckRimbTOTALEGG: TFloatField;
    selM040CheckRimbID_MISSIONE: TIntegerField;
    selM052IMPORTOINDENNITA: TFloatField;
    updM050: TOracleQuery;
    selM052IMPORTO: TFloatField;
    selM052ARROTONDAMENTO: TStringField;
    selM051DESCRIZIONE: TStringField;
    selM052DESCRIZIONE: TStringField;
    selP050: TOracleDataSet;
    selP050COD_ARROTONDAMENTO: TStringField;
    selP050COD_VALUTA: TStringField;
    selP050DECORRENZA: TDateTimeField;
    selP050DESCRIZIONE: TStringField;
    selP050VALORE: TFloatField;
    selP050TIPO: TStringField;
    selM040CheckRimbPARTENZA: TStringField;
    selM040CheckRimbD_PARTENZA: TStringField;
    selM040CheckRimbDESTINAZIONE: TStringField;
    selM040CheckRimbD_DESTINAZIONE: TStringField;
    selM040CheckRimbD_RESIDENZA: TStringField;
    cdsStato: TClientDataSet;
    cdsStatoCODICE: TStringField;
    cdsStatoDESCRIZIONE: TStringField;
    selM051D_STATO: TStringField;
    selM052D_STATO: TStringField;
    selM040CheckRimbD_FLAG_DESTINAZIONE: TStringField;
    selM040CheckRimbD_FLAG_ISPETTIVA: TStringField;
    selM040CheckRimbD_STATO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selM040CheckRimbAfterScroll(DataSet: TDataSet);
    procedure selM040CheckRimbAfterOpen(DataSet: TDataSet);
    procedure selM040CheckRimbAfterRefresh(DataSet: TDataSet);
    procedure selM051BeforePost(DataSet: TDataSet);
    procedure selM051BeforeInsert(DataSet: TDataSet);
    procedure selM051BeforeDelete(DataSet: TDataSet);
    procedure selM052BeforeDelete(DataSet: TDataSet);
    procedure selM052BeforeInsert(DataSet: TDataSet);
    procedure selM051AfterPost(DataSet: TDataSet);
    procedure selM052BeforePost(DataSet: TDataSet);
    procedure selM052AfterPost(DataSet: TDataSet);
  private
    ImportoVariatoM051: Boolean;
    KmVariatiM052: Boolean;
  public
    selM040CheckRimb_Funzioni: TOracleDataSet;
    procedure AggiornaDatasetDetail;
    procedure FiltraMissioni(const PDataInizio, PDataFine: String; const PIdxRimborsi, PIdxStato: Integer);
  end;

const
  STATO_RIMB_N = 'N'; // N = da verificare
  STATO_RIMB_V = 'V'; // V = verificato

implementation

{$R *.dfm}

procedure TA100FCheckRimborsiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;

  // clientdataset per descrizione stato
  with cdsStato do
  begin
    Append;
    FieldByName('CODICE').AsString:=STATO_RIMB_N;
    FieldByName('DESCRIZIONE').AsString:='Da verificare';
    Post;
  end;
  with cdsStato do
  begin
    Append;
    FieldByName('CODICE').AsString:=STATO_RIMB_V;
    FieldByName('DESCRIZIONE').AsString:='Verificato';
    Post;
  end;
end;

procedure TA100FCheckRimborsiMW.DataModuleDestroy(Sender: TObject);
begin
  //
  inherited;
end;

procedure TA100FCheckRimborsiMW.FiltraMissioni(const PDataInizio, PDataFine: String;
  const PIdxRimborsi, PIdxStato: Integer);
// determina e applica i filtri sql all'elenco delle missioni
// parametri
//   PDataInizio
//     data inizio periodo in formato dd/mm/yyyy
//   PDataFine
//     data fine periodo in formato dd/mm/yyyy
//   PIdxRimborsi
//     itemindex del radiogroup dei rimborsi
//   PIdxStato
//     itemindex del radiogroup dello stato
var
  Const_Filtro_Rimb, Const_Filtro_Stato: String;
  FiltroPeriodo, FiltroRimb, FiltroStato, Filtro: String;
  Inizio, Fine: TDateTime;
const
  FUNC_CONTA_RIMB = 'M051M052F_COUNT(M040.PROGRESSIVO,M040.MESESCARICO,M040.MESECOMPETENZA,M040.DATADA,M040.ORADA,%s)';
begin
  Const_Filtro_Rimb:=Format(FUNC_CONTA_RIMB,['null']);
  Const_Filtro_Rimb:=Const_Filtro_Rimb + ' %s 0';
  Const_Filtro_Stato:=Format(FUNC_CONTA_RIMB,[QuotedStr(STATO_RIMB_N)]);
  Const_Filtro_Stato:=Format('decode(%s,0,''%s'',''%s'')',[Const_Filtro_Stato,STATO_RIMB_V,STATO_RIMB_N]) + ' = ''%s''';

  // ### filtri sui campi
  // filtro periodo
  // controllo periodo
  if (PDataInizio = '') or (PDataInizio = '  /  /    ') then
    Inizio:=DATE_MIN
  else
  begin
    if not TryStrToDate(PDataInizio,Inizio) then
      raise Exception.Create('La data di inizio periodo non è valida!');
  end;
  if (PDataFine = '') or (PDataFine = '  /  /    ') then
    Fine:=DATE_MAX
  else
  begin
    if not TryStrToDate(PDataFine,Fine) then
      raise Exception.Create('La data di fine periodo non è valida!');
  end;
  if Inizio > Fine then
    raise Exception.Create('Il periodo indicato non è valido!');

  // impostazione filtro
  if (Inizio = DATE_MIN) and (Fine = DATE_MAX) then
  begin
    // periodo non indicato
    FiltroPeriodo:='';
  end
  else if Inizio = Fine then
  begin
    // periodo di un solo giorno
    FiltroPeriodo:=Format('(M040.DATADA = to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',Inizio)]);
  end
  else if Inizio = DATE_MIN then
  begin
    // periodo <= di una data
    FiltroPeriodo:=Format('(M040.DATAA <= to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',Fine)]);
  end
  else if Fine = DATE_MAX then
  begin
    // periodo >= di una data
    FiltroPeriodo:=Format('(M040.DATADA >= to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',Inizio)]);
  end
  else
  begin
    // periodo di più giorni compreso fra due date
    FiltroPeriodo:=Format('(M040.DATADA >= to_date(''%s'',''dd/mm/yyyy'') and M040.DATADA <= to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',Inizio),FormatDateTime('dd/mm/yyyy',Fine)]);
  end;
  Filtro:=FiltroPeriodo;

  // filtro stato
  // nota: si assume che gli stati siano 2: N / V
  case PIdxStato of
    0: // tutti
       begin
         FiltroStato:='';
       end;
    1: // verificati (V): tutti i record con stato 'V'
       begin
         FiltroStato:=Format(Const_Filtro_Stato,[STATO_RIMB_V]);
       end;
    2: // da verificare (N): almeno un record con stato 'N'
       begin
         FiltroStato:=Format(Const_Filtro_Stato,[STATO_RIMB_N]);
       end;
  end;
  Filtro:=Filtro + IfThen((Filtro <> '') and (FiltroStato <> ''),' and ') + FiltroStato;

  // filtro rimborsi (comprese ind. km)
  case PIdxRimborsi of
    0: // sì: almeno un rimborso
       begin
         FiltroRimb:=Format(Const_Filtro_Rimb,['>']);
       end;
    1: // no: nessun rimborso
       begin
         FiltroRimb:=Format(Const_Filtro_Rimb,['=']);
       end;
    2: // tutti: nessun filtro
       begin
         FiltroRimb:='';
       end;
  end;
  Filtro:=Filtro + IfThen((Filtro <> '') and (FiltroRimb <> ''),' and ') + FiltroRimb;

  // imposta i filtri e apre il dataset
  with selM040CheckRimb_Funzioni do
  begin
    Close;
    SetVariable('FILTRO',IfThen(Filtro <> '', ' and ' + Filtro));
    Open;
  end;
end;

procedure TA100FCheckRimborsiMW.AggiornaDatasetDetail;
// aggiorna i dataset di dettaglio in base al master
var
  Id: Integer;
begin
  inherited;

  with selM040CheckRimb_Funzioni do
  begin
    if RecordCount > 0 then
    begin
      Id:=FieldByName('ID_MISSIONE').AsInteger
    end
    else
    begin
      // imposta un id sicuramente non valido
      Id:=-1;
    end;
  end;

  // apre dataset dei rimborsi
  with selM051 do
  begin
    DisableControls;
    Close;
    SetVariable('ID',Id);
    Open;
    EnableControls;
  end;

  // apre dataset delle indennità km
  with selM052 do
  begin
    DisableControls;
    Close;
    SetVariable('ID',Id);
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    Open;
    EnableControls;
  end;

  // apre dataset dei dati liberi
  with selM175 do
  begin
    DisableControls;
    Close;
    SetVariable('ID',Id);
    Open;
    EnableControls;
  end;

  // apre dataset dei mezzi di trasporto
  with selM170 do
  begin
    DisableControls;
    Close;
    SetVariable('ID',Id);
    Open;
    EnableControls;
  end;
end;

procedure TA100FCheckRimborsiMW.selM040CheckRimbAfterOpen(DataSet: TDataSet);
begin
  AggiornaDatasetDetail;
end;

procedure TA100FCheckRimborsiMW.selM040CheckRimbAfterRefresh(DataSet: TDataSet);
begin
  AggiornaDatasetDetail;
end;

procedure TA100FCheckRimborsiMW.selM040CheckRimbAfterScroll(DataSet: TDataSet);
begin
  AggiornaDatasetDetail;
end;

// Rimborsi
procedure TA100FCheckRimborsiMW.selM051BeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA100FCheckRimborsiMW.selM051BeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA100FCheckRimborsiMW.selM051BeforePost(DataSet: TDataSet);
var
  Stato: String;
begin
  inherited;

  // stato
  Stato:=selM051.FieldByName('STATO').AsString;
  if not R180In(Stato,[STATO_RIMB_N,STATO_RIMB_V]) then
    raise Exception.Create(Format('Il valore dello stato non è valido!'#13#10'Indicare %s oppure %s',[STATO_RIMB_N,STATO_RIMB_V]));

  // importo
  ImportoVariatoM051:=(selM051.State = dsEdit) and (selM051.FieldByName('IMPORTO').Value <> selM051.FieldByName('IMPORTO').medpOldValue);
  if (ImportoVariatoM051) and
     (selM051.FieldByName('IMPORTO_ORIGINALE').IsNull) then
  begin
    selM051.FieldByName('IMPORTO_ORIGINALE').AsVariant:=selM051.FieldByName('IMPORTO').medpOldValue;
  end;
end;

procedure TA100FCheckRimborsiMW.selM051AfterPost(DataSet: TDataSet);
var BM_M040,BM_M051:TBookmark;
begin
  inherited;

  // se l'importo è stato variato ridetermina il totale su M050
  if ImportoVariatoM051 then
  begin
    // aggiorna il totale rimborso su M050
    with updM050 do
    begin
      SetVariable('ID',StrToInt(VarToStr(selM051.GetVariable('ID'))));
      SetVariable('CODICERIMBORSOSPESE',selM051.FieldByName('CODICERIMBORSOSPESE').AsString);
      Execute;
    end;
  end;

  {$IFNDEF WEBPJ}
  // aggiorna dataset master
  // (solo in win - in iriscloud, per via dell'edit multiplo, viene eseguito solo alla fine di tutti gli update)
  BM_M040:=selM040CheckRimb_Funzioni.GetBookmark;
  BM_M051:=selM051.GetBookmark;
  try { TODO : TEST IW 15 }
    selM040CheckRimb_Funzioni.Refresh;
    selM040CheckRimb_Funzioni.GotoBookmark(BM_M040);
    selM051.GotoBookmark(BM_M051);    
  finally
    selM040CheckRimb_Funzioni.FreeBookmark(BM_M040);
    selM051.FreeBookmark(BM_M051);	
  end;
  {$ENDIF}
end;

// Indennità km
procedure TA100FCheckRimborsiMW.selM052BeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA100FCheckRimborsiMW.selM052BeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA100FCheckRimborsiMW.selM052BeforePost(DataSet: TDataSet);
var
  Stato: String;
  Importo: Currency;
  Arr: Double;
  TipoArr: String;
begin
  inherited;

  // stato
  Stato:=selM052.FieldByName('STATO').AsString;
  if not R180In(Stato,[STATO_RIMB_N,STATO_RIMB_V]) then
    raise Exception.Create(Format('Il valore dello stato non è valido!'#13#10'Indicare %s oppure %s',[STATO_RIMB_N,STATO_RIMB_V]));

  // km percorsi
  KmVariatiM052:=(selM052.State = dsEdit) and (selM052.FieldByName('KMPERCORSI').Value <> selM052.FieldByName('KMPERCORSI').medpOldValue);
  if KmVariatiM052 then
  begin
    // se il numero di km è stato variato ridetermina il totale su M050
    Importo:=selM052.FieldByName('KMPERCORSI').AsFloat * selM052.FieldByName('IMPORTO').AsFloat;
    Arr:=1;
    TipoArr:='P';
    with selP050 do
    begin
      Close;
      SetVariable('CODICE',selM052.FieldByName('ARROTONDAMENTO').AsString);
      SetVariable('DECORRENZA',selM052.FieldByName('DATADA').AsDateTime);
      Open;
      First;
      if not Eof then
      begin
        Arr:=FieldByName('VALORE').AsFloat;
        TipoArr:=FieldByName('TIPO').AsString;
      end;
      Importo:=R180Arrotonda(Importo,Arr,TipoArr);
      selM052.FieldByName('IMPORTOINDENNITA').AsFloat:=Importo;
    end;

    // salva il numero di km originali
    if selM052.FieldByName('KMPERCORSI_ORIGINALI').IsNull then
    begin
      selM052.FieldByName('KMPERCORSI_ORIGINALI').AsVariant:=selM052.FieldByName('KMPERCORSI').medpOldValue;
    end;
  end;
end;

procedure TA100FCheckRimborsiMW.selM052AfterPost(DataSet: TDataSet);
begin
  inherited;

  // aggiorna dataset master
  selM040CheckRimb_Funzioni.Refresh;
end;

end.
