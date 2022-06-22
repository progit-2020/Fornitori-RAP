unit B021UAnagraficoDM;

interface

uses
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} A000UCostanti, A000USessione, C180FunzioniGenerali,
  R014URestDM, B021UIrisRestSvcDM, B021UUtils, Oracle, DB, OracleData,
  SysUtils, Variants, Classes;

type
  TStorico = record
    Campo,
    CampoSel,
    Alias: String;
  end;

  TDataStorica = record
    Campo: String;
    Alias: String;
    Formato: String;
  end;

  TB021FAnagraficoDM = class(TR014FRestDM)
    selIA110: TOracleDataSet;
    selT030: TOracleDataSet;
    selInizio: TOracleDataSet;
    selCampoT430: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    ElencoT030,
    ElencoT430Storico: String;
    GestInizio: Boolean;
    Decorrenza,
    Scadenza: TDataStorica;
    ArrStorico: array of TStorico;
    procedure LeggiStrutture;
    function GestStorico(PProg: Integer): TJSONArray;
    function GetAnagrafiche(Matricole:String): TJSONObject;
    function GetFiltroMatricole(PMatricole: String): String;
  protected
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function GetDato: TJSONObject; override;
  end;

const
  STRUTTURA_ANAG = 'FIRLAB'; // nome della struttura di integrazione anagrafica che specifica i dati da estrarre

  // nomi dei parametri utilizzati
  PAR_MATRICOLE  = 'matricole';

implementation

{$R *.dfm}

procedure TB021FAnagraficoDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ElencoT030:='';
  ElencoT430Storico:='';
  GestInizio:=False;
end;

procedure TB021FAnagraficoDM.LeggiStrutture;
// estrae i dati della struttura denominata FIRLAB, che rappresentano i dati anagrafici
// da esporre nell'output del servizio in get
var
  Intestazione, Tabella, Campo, NomeDato, CampoFmt: String;
  i: Integer;
const
  NOME_PROC = 'LeggiStrutture';
begin
  Log(NOME_PROC,'inizio lettura delle strutture B014');

  SetLength(ArrStorico,0);
  // lettura strutture
  selIA110.Close;
  selIA110.SetVariable('AZIENDA',(Self.Owner as TSessioneIrisWIN).Parametri.Azienda);
  selIA110.SetVariable('NOME_STRUTTURA',STRUTTURA_ANAG);

  Log(NOME_PROC,Format('apertura dataset per azienda %s, struttura %s',[(Self.Owner as TSessioneIrisWIN).Parametri.Azienda,STRUTTURA_ANAG]));
  selIA110.Open;
  Log(NOME_PROC,Format('apertura dataset riuscita: %d record',[selIA110.RecordCount]));
  if selIA110.RecordCount = 0 then
    raise EB021InvalidStructure.Create('Struttura dati anagrafici non presente');
  while not selIA110.Eof do
  begin
    Intestazione:=selIA110.FieldByName('INTESTAZIONE').AsString;
    NomeDato:=selIA110.FieldByName('NOME_DATO').AsString;
    if (Intestazione = 'CHIAVE') or (Intestazione = '') then
    begin
      Tabella:=selIA110.FieldByName('TABELLA').AsString;
      Campo:=selIA110.FieldByName('CAMPO').AsString;
      if (selIA110.FieldByName('TIPO_DATO').AsString = 'D') and
         (not selIA110.FieldByName('FMT_DATA').IsNull) then
        CampoFmt:=Format('TO_CHAR(%s,''%s'') %s',[Campo,selIA110.FieldByName('FMT_DATA').AsString,Campo])
      else
        CampoFmt:=Campo;
    end
    else if Intestazione = 'DECORRENZA' then
    begin
      Tabella:='T430_STORICO';
      Campo:='DATADECORRENZA';
      CampoFmt:=Campo;
      Decorrenza.Campo:=Campo;
      Decorrenza.Alias:=NomeDato;
      Decorrenza.Formato:=selIA110.FieldByName('FMT_DATA').AsString;
    end
    else if Intestazione = 'SCADENZA' then
    begin
      Tabella:='T430_STORICO';
      Campo:='DATAFINE';
      CampoFmt:=Campo;
      Scadenza.Campo:=Campo;
      Scadenza.Alias:=NomeDato;
      Scadenza.Formato:=selIA110.FieldByName('FMT_DATA').AsString;
    end;

    if Tabella = 'T030_ANAGRAFICO' then
    begin
      ElencoT030:=ElencoT030 + CampoFmt + ','
    end
    else if Tabella = 'T430_STORICO' then
    begin
      if (selIA110.FieldByName('STORICO').AsString = 'N') and (Campo <> Decorrenza.Campo) and (Campo <> Scadenza.Campo) then
        ElencoT030:=ElencoT030 + CampoFmt + ','
      else
      begin
        // il dato "INIZIO" è trattato in modo separato
        if Campo = 'INIZIO' then
          GestInizio:=True
        else
        begin
          if (Campo <> Decorrenza.Campo) and (Campo <> Scadenza.Campo) then
          begin
            SetLength(ArrStorico,Length(ArrStorico) + 1);
            i:=High(ArrStorico);
            ArrStorico[i].Campo:=Campo;
            ArrStorico[i].CampoSel:=CampoFmt;
            ArrStorico[i].Alias:=NomeDato;
          end;
          ElencoT430Storico:=ElencoT430Storico + CampoFmt + ',';
        end;
      end;
    end;
    selIA110.Next;
  end;

  if ElencoT030 <> '' then
  begin
    if R180CercaParolaIntera('PROGRESSIVO',UpperCase(ElencoT030),',') > 0 then
      ElencoT030:=Copy(ElencoT030,1,Length(ElencoT030) - 1)
    else
      ElencoT030:=ElencoT030 + 'T030.PROGRESSIVO';
  end;
  if ElencoT430Storico <> '' then
    ElencoT430Storico:=Copy(ElencoT430Storico,1,Length(ElencoT430Storico) - 1);
end;

function TB021FAnagraficoDM.GestStorico(PProg: Integer): TJSONArray;
// popola array json con dati storici del progressivo indicato
var
  Alias, ValoreOld: String;
  locDecorrenza,locScadenza: TDateTime;
  hobj: TJSONObject;
  i: Integer;
begin
  Result:=nil;

  // gestione particolare del dato INIZIO (inizio rapporto)
  if GestInizio then
  begin
    Result:=TJSONArray.Create;
    selInizio.SetVariable('PROGRESSIVO',PProg);
    selInizio.Open;
    while not selInizio.Eof do
    begin
      Alias:=VarToStr(selIA110.Lookup('CAMPO','INIZIO','NOME_DATO'));
      hObj:=TJSONObject.Create;
      hObj.AddPair('field',TJsonString.Create(Alias));
      hObj.AddPair('value',TJsonString.Create(''));
      if selInizio.FieldByName('INIZIO').IsNull then
        hObj.AddPair(Decorrenza.Alias,TJsonString.Create(''))
      else
        hObj.AddPair(Decorrenza.Alias,TJsonString.Create(FormatDateTime(Decorrenza.Formato,selInizio.FieldByName('INIZIO').AsDateTime)));
      if selInizio.FieldByName('FINE').IsNull then
        hObj.AddPair(Scadenza.Alias,TJsonString.Create(''))
      else
        hObj.AddPair(Scadenza.Alias,TJsonString.Create(FormatDateTime(Scadenza.Formato,selInizio.FieldByName('FINE').AsDateTime)));
      Result.Add(hObj);
      selInizio.Next;
    end;
    selInizio.Close;
  end;

  // gestione dei dati storicizzati su T430_STORICO
  if ElencoT430Storico <> '' then
  begin
    if Result = nil then
      Result:=TJSONArray.Create;
    for i:=0 to High(ArrStorico) do
    begin
      selCampoT430.SetVariable('CAMPO',ArrStorico[i].Campo);
      selCampoT430.SetVariable('PROGRESSIVO',PProg);
      selCampoT430.Open;
      ValoreOld:='ValoreOld';
      while not selCampoT430.Eof do
      try
        if selCampoT430.Fields[0].AsString <> ValoreOld then
        begin
          if ValoreOld <> 'ValoreOld' then
          begin
            hObj:=TJSONObject.Create;
            hObj.AddPair('field',TJsonString.Create(ArrStorico[i].Alias));
            hObj.AddPair('value',TJsonString.Create(ValoreOld));
            hObj.AddPair(Decorrenza.Alias,TJsonString.Create(FormatDateTime(Decorrenza.Formato,locDecorrenza)));
            hObj.AddPair(Scadenza.Alias,TJsonString.Create(FormatDateTime(Scadenza.Formato,locScadenza)));
            Result.Add(hObj);
          end;
          ValoreOld:=selCampoT430.Fields[0].AsString;
          locDecorrenza:=selCampoT430.Fields[1].AsDateTime;
          locScadenza:=selCampoT430.Fields[2].AsDateTime;
        end
        else
          locScadenza:=selCampoT430.Fields[2].AsDateTime;
        (*
        hObj:=TJSONObject.Create;
        hObj.AddPair('field',TJsonString.Create(ArrStorico[i].Alias));
        hObj.AddPair('value',TJsonString.Create(selCampoT430.Fields[0].AsString));
        hObj.AddPair(Decorrenza.Alias,TJsonString.Create(FormatDateTime(Decorrenza.Formato,selCampoT430.Fields[1].AsDateTime)));
        hObj.AddPair(Scadenza.Alias,TJsonString.Create(FormatDateTime(Scadenza.Formato,selCampoT430.Fields[2].AsDateTime)));
        Result.Add(hObj);
        *)
      finally
        selCampoT430.Next;
      end;
      if ValoreOld <> 'ValoreOld' then
      begin
        hObj:=TJSONObject.Create;
        hObj.AddPair('field',TJsonString.Create(ArrStorico[i].Alias));
        hObj.AddPair('value',TJsonString.Create(ValoreOld));
        hObj.AddPair(Decorrenza.Alias,TJsonString.Create(FormatDateTime(Decorrenza.Formato,locDecorrenza)));
        hObj.AddPair(Scadenza.Alias,TJsonString.Create(FormatDateTime(Scadenza.Formato,locScadenza)));
        Result.Add(hObj);
      end;

      selCampoT430.Close;
    end;
  end;
end;

function TB021FAnagraficoDM.GetFiltroMatricole(PMatricole: String): String;
// estrae filtro SQL in base alle matricole indicate
// parametri:
//   PMatricole: String
//     valori ammessi:
//     *                           = tutte le anagrafiche dei turnisti
//     -                           = tutte le anagrafiche dei turnisti da allineare
//     [matricola]                 = singola anagrafica
//     [matr1][,matr2]...[,matrN]  = numero finito di anagrafiche specificate individualmente
begin
  if PMatricole = '*' then
  begin
    // * = tutte le anagrafiche dei turnisti
    Result:='exists (select ''x'' from VT430_B021 where PROGRESSIVO = T430.PROGRESSIVO)';
  end
  else if PMatricole = '-' then
  begin
    // - = tutte le anagrafiche dei turnisti da allineare
    Result:='exists (select ''x'' from VT430_B021 where PROGRESSIVO = T430.PROGRESSIVO)';
  end
  else
  begin
    if Pos(',',PMatricole) > 0 then
    begin
      // elenco di matricole separate da virgola
      PMatricole:='''' + StringReplace(PMatricole,',',''',''',[rfReplaceAll]) + '''';
      Result:=Format('T030.MATRICOLA IN (%s) and exists (select ''x'' from VT430_B021 where PROGRESSIVO = T430.PROGRESSIVO)',[PMatricole]);
    end
    else
    begin
      // matricola singola
      Result:=Format('T030.MATRICOLA = ''%s'' and exists (select ''x'' from VT430_B021 where PROGRESSIVO = T430.PROGRESSIVO)',[PMatricole]);
    end;
  end;
end;

function TB021FAnagraficoDM.GetAnagrafiche(Matricole: String): TJSONObject;
var
  i:Integer;
  Alias: String;
  ResArr,HistoryArr: TJSONArray;
  Element: TJSONObject;
const
  NOME_PROC = 'GetAnagrafiche';
begin
  Log(NOME_PROC,Format('estrazione dati matricole [%s]',[Matricole]));

  // dati di T030_ANAGRAFICO + dati non storici di T430_STORICO
  if ElencoT030 = '' then
  begin
    Log(NOME_PROC,'struttura [FIRLAB] priva di dati');
    raise EB021InvalidStructure.Create('Struttura [FIRLAB]: nessun dato da estrarre');
  end
  else
  begin
    ResArr:=TJSONArray.Create;
    selT030.Close;
    selT030.SetVariable('ELENCO_CAMPI',ElencoT030);
    selT030.SetVariable('FILTRO_ANAG',GetFiltroMatricole(Matricole));
    R180SetReadBuffer(selT030);
    selT030.Open;
    Log(NOME_PROC,Format('%d anagrafiche estratte',[selT030.RecordCount]));
    while not selT030.Eof do
    begin
      Element:=TJSONObject.Create;

      // dati non storici
      for i:=0 to selT030.FieldCount - 1 do
      begin
        Alias:=VarToStr(selIA110.Lookup('CAMPO',selT030.Fields[i].FieldName,'NOME_DATO'));
        Element.AddPair(Alias,TJsonString.Create(selT030.Fields[i].AsString));
      end;

      // dati storici
      HistoryArr:=GestStorico(selT030.FieldByName('PROGRESSIVO').AsInteger);
      if HistoryArr <> nil then
        Element.AddPair('history',HistoryArr);

      ResArr.Add(Element);
      selT030.Next;
    end;
    selT030.Close;
    Result:=TJSONObject.Create(TJSONPair.Create('anagrafiche',ResArr));
  end;
  selIA110.Close;
  SetLength(ArrStorico,0);
end;

// metodi da implementare

function TB021FAnagraficoDM.ControlloParametri(var RErrMsg: String): Boolean;
// controllo parametri
begin
  RErrMsg:='';
  Result:=True;
end;

function TB021FAnagraficoDM.GetDato: TJSONObject;
// l'estrazione dei dati anagrafici utilizza la struttura di integrazione
// anagrafica denominata FIRLAB
var
  Matr: String;
begin
  Matr:=GetParam('matricole');

  LeggiStrutture;
  Result:=GetAnagrafiche(Matr);
end;

end.
