unit P655UDatiINPDAPMMMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData, C180FunzioniGenerali,
  A000UInterfaccia, Variants, A000UMessaggi, A000UCostanti, Math;

type
  TP655FDatiINPDAPMMMW = class(TR005FDataModuleMW)
    P663: TOracleDataSet;
    P663PROGRESSIVO: TFloatField;
    P663PARTE: TStringField;
    P663NUMERO: TStringField;
    P663PROGRESSIVO_NUMERO: TFloatField;
    P663TIPO_RECORD: TStringField;
    P663VALORE: TStringField;
    P663D_DESCRIZIONE: TStringField;
    P663ID_FLUSSO: TFloatField;
    selP660: TOracleDataSet;
    D663: TDataSource;
    selP050: TOracleDataSet;
    selP500: TOracleDataSet;
    selP663: TOracleDataSet;
    selbP660: TOracleDataSet;
    selaP660: TOracleDataSet;
    selbP663: TOracleDataSet;
    procedure P663CalcFields(DataSet: TDataSet);
    procedure P663ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure P663BeforePost(DataSet: TDataSet);
    procedure P663BeforeInsert(DataSet: TDataSet);
    procedure P663BeforeEdit(DataSet: TDataSet);
    procedure P663AfterPost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    FSelP662_Funzioni: TOracleDataset;
    sP655SqlText,sP655SqlText1,sP655SqlText2,sP655SqlTextOld: String;
    function FormattaDato(sCodArrotondamento, sFormato, sParte, sNumero: String;
      var sDatoINPDAPMM: String): String;
    function ModificaQueryParte: String;
    function ModificaQueryNumeri: String;
    function ModificaQueryProgressivi: String;
  public
    PartiSelezionate, DatiSelezionati, ProgrSelezionati: String;
    procedure ModificaQuery(NomeFlusso: String; TipoDati, TipoRecord: Integer);
    function ElencoProgrChecklist(TipoDati: Integer): TElencoValoriCheckList;
    function ElencoPartiChecklist(NomeFlusso: String): TElencoValoriCheckList;
    function ElencoNumeriChecklist(NomeFlusso: String): TElencoValoriCheckList;
    procedure ReimpostaDatasetCollegati(NomeFlusso:String);
    function MessaggioCancellazione(var NumDip:String): String;
    procedure FiltraP660(TipoDati: Integer);
    procedure P662BeforeDelete;
    procedure P663NewRecord(tipoDati: Integer);
    procedure ImpostaSelP660(NomeFlusso: String);
    function ImpostaValore(Parte, Numero, ValoreInput: String;var ValoreFormattato: String): String;
    procedure LeggoDettaglioINPDAPMM(NomeFlusso: String; TipoDati,TipoRecord: Integer);
    property SelP662_Funzioni: TOracleDataset read FSelP662_Funzioni write FSelP662_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TP655FDatiINPDAPMMMW.ImpostaSelP660(NomeFlusso:String);
begin
  selP660.SetVariable('DataElaborazione', R180FineMese(Parametri.DataLavoro));
  selP660.SetVariable('NOMEFLUSSO',NomeFlusso);
  selP660.Close;
  selP660.Open;
end;

procedure TP655FDatiINPDAPMMMW.LeggoDettaglioINPDAPMM(NomeFlusso:String; TipoDati, TipoRecord: Integer);
//Leggo il dettaglio dei dati del INPDAPMM
begin
  if (TipoDati = 0) and (selAnagrafe = nil) then
    Exit;
  P663.Close;
  P663.SetVariable('IdINPDAPMM', FSelP662_Funzioni.FieldByName('ID_FLUSSO').AsInteger);
  P663.SetVariable('DataElaborazione', FSelP662_Funzioni.FieldByName('DATA_FINE_PERIODO').AsDateTime);
  if TipoDati = 0 then
    P663.SetVariable('Progressivo', selAnagrafe.FieldByName('PROGRESSIVO').AsInteger)
  else
    P663.SetVariable('Progressivo',-1);
  P663.SetVariable('NOMEFLUSSO',NomeFlusso);
  case TipoRecord of
    0:P663.SetVariable('TipoRecord', 'M');
    1:P663.SetVariable('TipoRecord', 'A');
    2:P663.SetVariable('TipoRecord', 'E');
  end;
  P663.Open;
end;

procedure TP655FDatiINPDAPMMMW.P662BeforeDelete;
begin
  if FSelP662_Funzioni.FieldByName('CHIUSO').AsString = 'S' then
    raise Exception.Create(A000MSG_P655_ERR_CHIUSO);
end;

procedure TP655FDatiINPDAPMMMW.P663AfterPost(DataSet: TDataSet);
var
  sParte,sNumero:String;
  iProgressivoNumero: Integer;
begin
  sParte:=P663.FieldByName('PARTE').AsString;
  sNumero:=P663.FieldByName('NUMERO').AsString;
  iProgressivoNumero:=P663.FieldByName('PROGRESSIVO_NUMERO').AsInteger;
  P663.Refresh;
  P663.SearchRecord('PARTE;NUMERO;PROGRESSIVO_NUMERO',VarArrayOf([sParte, sNumero, iProgressivoNumero]),[srFromBeginning]);
end;

procedure TP655FDatiINPDAPMMMW.P663ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  case Action of
    'D':RegistraLog.SettaProprieta('C',R180Query2NomeTabella(Sender),NomeOwner,Sender,True);
    'I':RegistraLog.SettaProprieta('I',R180Query2NomeTabella(Sender),NomeOwner,Sender,True);
    'U':RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Sender),NomeOwner,Sender,True);
  end;
  if Action in ['D','I','U'] then
    RegistraLog.RegistraOperazione;
end;

procedure TP655FDatiINPDAPMMMW.P663BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  P663.FieldByName('PARTE').ReadOnly:=True;
  P663.FieldByName('NUMERO').ReadOnly:=True;
end;

procedure TP655FDatiINPDAPMMMW.P663BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  P663.FieldByName('PARTE').ReadOnly:=False;
  P663.FieldByName('NUMERO').ReadOnly:=False;
end;

procedure TP655FDatiINPDAPMMMW.P663BeforePost(DataSet: TDataSet);
begin
  if not selP660.SearchRecord('PARTE',P663.FieldByName('PARTE').AsString,[srFromBeginning]) then
    raise exception.Create(A000MSG_P655_ERR_PARTE);
  if not selP660.SearchRecord('NUMERO',P663.FieldByName('NUMERO').AsString,[srFromBeginning]) then
    raise exception.Create(A000MSG_P655_ERR_NUMERO);
end;

procedure TP655FDatiINPDAPMMMW.P663CalcFields(DataSet: TDataSet);
begin
  inherited;
  if selP660.SearchRecord('PARTE;NUMERO',VarArrayOf([P663.FieldByName('PARTE').AsString,P663.FieldByName('NUMERO').AsString]),[srFromBeginning]) then
    P663.FieldByName('D_DESCRIZIONE').AsString:=selP660.FieldByName('DESCRIZIONE').AsString;
end;

procedure TP655FDatiINPDAPMMMW.P663NewRecord(tipoDati:Integer);
begin
  P663.FieldByName('ID_FLUSSO').AsInteger:=FSelP662_Funzioni.FieldByName('ID_FLUSSO').AsInteger;
  if tipoDati = 0 then
    P663.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger
  else
    P663.FieldByName('PROGRESSIVO').AsInteger:=-1;
  P663.FieldByName('TIPO_RECORD').AsString:='M';
  P663.FieldByName('PROGRESSIVO_NUMERO').AsInteger:=1;
end;

function TP655FDatiINPDAPMMMW.FormattaDato(sCodArrotondamento, sFormato, sParte, sNumero:String; var sDatoINPDAPMM:String):String;
var
  DataFinePeriodo: TDateTime;
  DataFineAnno: TDateTime;
//Formattazione del dato se numerico
begin
  Result:='';

  if sCodArrotondamento <> '' then
  begin
    if not FSelP662_Funzioni.FieldByName('DATA_FINE_PERIODO').IsNull then
      DataFinePeriodo:=FSelP662_Funzioni.FieldByName('DATA_FINE_PERIODO').AsDateTime
    else
      DataFinePeriodo:=R180FineMese(Parametri.DataLavoro);

    DataFineAnno:=EncodeDate(R180Anno(DataFinePeriodo), 12, 31);

    if (selP050.GetVariable('CodValuta') <> selP500.FieldByName('COD_VALUTA').AsString) or
       (selP050.GetVariable('CodArrotondamento') <> sCodArrotondamento) or
       (selP050.GetVariable('Decorrenza') <> DataFineAnno) then
    begin
      selP050.SetVariable('CodValuta',selP500.FieldByName('COD_VALUTA').AsString);
      selP050.SetVariable('CodArrotondamento',sCodArrotondamento);
      selP050.SetVariable('Decorrenza',DataFineAnno);
      selP050.Close;
      selP050.Open;
      if selP050.Eof then
      begin
        //Non esiste l'arrotondamento
        Result:=A000MSG_P655_ERR_ARROTONDAMENTO;
        Exit;
      end;
    end;
    //Arrotondamento
    if sDatoINPDAPMM <> '' then
      sDatoINPDAPMM:=FloatToStr(R180Arrotonda(StrToFloat(sDatoINPDAPMM),selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString));
  end;
  sDatoINPDAPMM:=R180FormattaNumero(sDatoINPDAPMM,sFormato);
end;

function TP655FDatiINPDAPMMMW.ImpostaValore(Parte, Numero,ValoreInput: String; var ValoreFormattato:String):String;
begin
  Result:='';
  ValoreFormattato:='';
  if Trim(ValoreInput) <> '' then
  begin
    selP660.SearchRecord('PARTE;NUMERO',VarArrayOf([Parte,Numero]),[srFromBeginning]);
    if selP660.FieldByName('NUMERICO').AsString = 'S' then
    begin
      ValoreFormattato:=StringReplace(ValoreInput,'.','',[rfReplaceAll]);
      Result:=FormattaDato(selP660.FieldByName('COD_ARROTONDAMENTO').AsString, selP660.FieldByName('FORMATO').AsString,
                           Parte, Numero, ValoreFormattato);
    end
    else
      ValoreFormattato:=ValoreInput;
  end;
end;

procedure TP655FDatiINPDAPMMMW.FiltraP660(TipoDati: Integer);
begin
  selP660.Filtered:=False;
  selP660.Filter:='';
  if TipoDati = 0 then
    selP660.Filter:='TIPO_DATO = ''I'''
  else
    selP660.Filter:='TIPO_DATO = ''R''';
  selP660.Filtered:=True;
end;

function TP655FDatiINPDAPMMMW.MessaggioCancellazione(var NumDip:String): String;
begin
  selP663.Close;
  selP663.SetVariable('IdFlusso', FSelP662_Funzioni.FieldByName('ID_FLUSSO').AsInteger);
  selP663.Open;
  NumDip:=selP663.FieldByName('NUMDIP').AsString;
  Result:=Format(A000MSG_P655_DLG_FMT_CANCELLA,[NumDip])
end;

procedure TP655FDatiINPDAPMMMW.ReimpostaDatasetCollegati(NomeFlusso: String);
var
  DataFinePeriodo: TDateTime;
begin
  if not FSelP662_Funzioni.FieldByName('DATA_FINE_PERIODO').IsNull then
    DataFinePeriodo:=FSelP662_Funzioni.FieldByName('DATA_FINE_PERIODO').AsDateTime
  else
    DataFinePeriodo:=R180FineMese(Parametri.DataLavoro);

  if selP660.GetVariable('DataElaborazione') <> DataFinePeriodo then
  begin
    selP660.SetVariable('DataElaborazione', DataFinePeriodo);
    selP660.SetVariable('NOMEFLUSSO',NomeFlusso);
    selP660.Close;
    selP660.Open;
    //Lettura record di setup
    selP500.SetVariable('Anno',R180Anno(DataFinePeriodo));
    selP500.Close;
    selP500.Open;
  end;
end;

function TP655FDatiINPDAPMMMW.ElencoProgrChecklist(TipoDati: Integer): TElencoValoriCheckList;
var
  sCodice: String;
begin
  Result:=TElencoValoriChecklist.Create;
  if (selbP663.GetVariable('ID_FLUSSO') <> FSelP662_Funzioni.FieldByName('ID_FLUSSO').AsInteger)
  or (selbP663.GetVariable('PROGRESSIVO') <> IfThen(TipoDati = 0,selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,-1)) then
  begin
    selbP663.SetVariable('ID_FLUSSO',FSelP662_Funzioni.FieldByName('ID_FLUSSO').AsInteger);
    selbP663.SetVariable('PROGRESSIVO', IfThen(TipoDati = 0,selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,-1));
    selbP663.Close;
    selbP663.Open;
  end
  else
  begin
    selbP663.Refresh; //caratto 13/03/2015 refresh perchè se no nuovi valori inseriti in P663 non vengono proposti in elenco. Non ha mai funzionato
    selbP663.First;
  end;
  while not selbP663.Eof do
  begin
    sCodice:=selbP663.FieldByName('PROGRESSIVO_NUMERO').AsString;
    Result.lstCodice.add(sCodice);
    Result.lstDescrizione.Add(Format('%-5s %s',[sCodice,selbP663.FieldByName('DESCRIZIONE').AsString]));
    selbP663.Next;
  end;
end;

procedure TP655FDatiINPDAPMMMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  //Spezzo l'SQL originale tra prima del ORDER BY e dal ORDER BY in poi
  sP655SqlText:=UpperCase(P663.Sql.Text);
  sP655SqlText1:=Copy(sP655SqlText, 1, Pos('ORDER', sP655SqlText) - 1);
  sP655SqlText2:=Copy(sP655SqlText, Pos('ORDER', sP655SqlText), Length(sP655SqlText));
end;

function TP655FDatiINPDAPMMMW.ElencoNumeriChecklist(NomeFlusso: String): TElencoValoriCheckList;
var
  DataFinePeriodo: TDateTime;
  sParte: string;
  sNumero: string;
  sCodice: string;
begin
  Result:=TElencoValoriChecklist.Create;
  Result.lstCodice.StrictDelimiter:=True;
  if not FSelP662_Funzioni.FieldByName('DATA_FINE_PERIODO').IsNull then
    DataFinePeriodo:=FSelP662_Funzioni.FieldByName('DATA_FINE_PERIODO').AsDateTime
  else
    DataFinePeriodo:=Parametri.DataLavoro;
  if selaP660.GetVariable('DataElaborazione') <> DataFinePeriodo then
  begin
    selaP660.SetVariable('DataElaborazione',DataFinePeriodo);
    selaP660.SetVariable('NOMEFLUSSO', NomeFlusso);
    selaP660.Close;
    selaP660.Open;
  end
  else
  begin
    selaP660.Refresh; //caratto 13/03/2015 refresh perchè se no nuovi valori inseriti in P663 non vengono proposti in elenco. Non ha mai funzionato
    selaP660.First;
  end;

  while not selaP660.Eof do
  begin
    sParte:=Format('%-5s',[selaP660.FieldByName('PARTE').AsString]);
    sNumero:=Format('%-4s',[selaP660.FieldByName('NUMERO').AsString]);
    sCodice:=sParte + ' ' + sNumero;
    Result.lstCodice.Add(Trim(sCodice));
    Result.lstDescrizione.Add(sCodice+' '+Format('%s',[selaP660.FieldByName('DESCRIZIONE').AsString]));
    selaP660.Next;
  end;
end;

function TP655FDatiINPDAPMMMW.ElencoPartiChecklist(NomeFlusso: String): TElencoValoriCheckList;
var
  DataFinePeriodo: TDateTime;
  Codice: String;
  sParte: String;
begin
  Result:=TElencoValoriChecklist.Create;

  if not FSelP662_Funzioni.FieldByName('DATA_FINE_PERIODO').IsNull then
    DataFinePeriodo:=FSelP662_Funzioni.FieldByName('DATA_FINE_PERIODO').AsDateTime
  else
    DataFinePeriodo:=Parametri.DataLavoro;
  if selbP660.GetVariable('DataElaborazione') <> DataFinePeriodo then
  begin
    selbP660.SetVariable('DataElaborazione',DataFinePeriodo);
    selbP660.SetVariable('NOMEFLUSSO', NomeFlusso);
    selbP660.Close;
    selbP660.Open;
  end
  else
  begin
    selbP660.Refresh; //caratto 13/03/2015 refresh perchè se no nuovi valori inseriti in P663 non vengono proposti in elenco. Non ha mai funzionato
    selbP660.First;
  end;
  while not selbP660.Eof do
  begin
    Codice:=selbP660.FieldByName('PARTE').AsString;
    Result.lstCodice.Add(Codice);

    sParte:=Format('%-5s',[Codice]);
    Result.lstDescrizione.Add(sParte+' '+Format('%s',[selbP660.FieldByName('DESCRIZIONE').AsString]));
    selbP660.Next;
  end;
end;

function TP655FDatiINPDAPMMMW.ModificaQueryParte:String;
//Modifico la query aggiungendo il filtro sulle parti selezionate
begin
  Result:='';
  if PartiSelezionate <> '' then
    Result:=' AND P663.PARTE IN (''' + StringReplace(PartiSelezionate,',',''',''',[rfReplaceAll]) + ''')';
end;

function TP655FDatiINPDAPMMMW.ModificaQueryNumeri:String;
//Modifico la query aggiungendo il filtro sulle voci selezionate
begin
  Result:='';
  if DatiSelezionati <> '' then
    Result:=' AND RPAD(P663.PARTE,5,'' '')||'' ''||P663.NUMERO IN (''' + StringReplace(DatiSelezionati,',',''',''',[rfReplaceAll]) + ''')';
end;

function TP655FDatiINPDAPMMMW.ModificaQueryProgressivi:String;
//Modifico la query aggiungendo il filtro sui progressivi selezionati
begin
  Result:='';
  if ProgrSelezionati <> '' then
    Result:=' AND P663.PROGRESSIVO_NUMERO IN (''' + StringReplace(ProgrSelezionati,',',''',''',[rfReplaceAll]) + ''')';
end;

procedure TP655FDatiINPDAPMMMW.ModificaQuery(NomeFlusso:String; TipoDati:Integer; TipoRecord:Integer);
//Modifico la query aggiungendo il filtro sulle parti selezionate
var
  sP655SqlTextMod: String;
begin
  if sP655SqlTextOld = '' then
    sP655SqlTextOld:=sP655SqlText;
  sP655SqlTextMod:=sP655SqlText1 + ModificaQueryParte + ' ' + ModificaQueryNumeri + ' ' + ModificaQueryProgressivi + ' ' + sP655SqlText2;
  //Rileggo i dati del INPDAPMM se l'sql è stata modificata
  if sP655SqlTextMod <> sP655SqlTextOld then
  begin
    P663.SQL.Clear;
    P663.SQL.Text:=sP655SqlTextMod;
    sP655SqlTextOld:=sP655SqlTextMod;
    LeggoDettaglioINPDAPMM(NomeFlusso,TipoDati,TipoRecord);
  end;
end;
end.
