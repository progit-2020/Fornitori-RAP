unit A119UPartecipazioneScioperiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB,
  A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali, A004UGiustifAssPresMW,
  Oracle, StrUtils, Variants, DatiBloccati, Generics.Collections, Generics.Defaults,
  System.Math;

type
  TDatiGiust = record
    Causale: String;
    DataInizio: TDateTime;
    DataFine: TDateTime;
    TipoGiust: String;
    Dalle: String;
    Alle: String;
  end;

  TAnomalieInfo = record
    IdRichiesta: Integer;
    Progressivo: Integer;
    Anomalia: String;
  end;

  TA119FPartecipazioneScioperiMW = class(TR005FDataModuleMW)
    selT265: TOracleDataSet;
    dsrT265: TDataSource;
    selFiltroAnagrafe: TOracleDataSet;
    selT251Count: TOracleQuery;
    selT250Data: TOracleQuery;
    selT251: TOracleDataSet;
    dsrT251: TDataSource;
    selT251MATRICOLA: TStringField;
    selT251NOMINATIVO: TStringField;
    selT251AUTORIZZATO: TStringField;
    selT251TIPO_RICHIESTA: TStringField;
    selT251BLOCCATO: TStringField;
    selT252: TOracleDataSet;
    selT252MATRICOLA: TStringField;
    selT252NOMINATIVO: TStringField;
    selT252SCIOPERA: TStringField;
    dsrT252: TDataSource;
    T250P_ANNULLA_RICHIESTA: TOracleQuery;
    selT251ID: TFloatField;
    selT251DATA: TDateTimeField;
    selT251PROGRESSIVO: TFloatField;
    selDatiGiust: TOracleDataSet;
    selT252PROGRESSIVO: TFloatField;
    selT251D_AUTORIZZATO: TStringField;
    selT251D_BLOCCATO: TStringField;
    selT252D_SCIOPERA: TStringField;
    updT850: TOracleQuery;
    selT040Canc: TOracleDataSet;
    selT251D_TIPO_RICHIESTA: TStringField;
    selT251D_ESITO_IMPORTAZIONE: TStringField;
    selT252D_ANOMALIE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT251CalcFields(DataSet: TDataSet);
    procedure selT252CalcFields(DataSet: TDataSet);
  private
    FSelT250_Funzioni: TOracleDataset;
    selDatiBloccati: TDatiBloccati;
    A004MW: TA004FGiustifAssPresMW;
    //FDsrT250_Funzioni: TDataSource;
    function CheckSelezioneAnagrafica(const PFiltroSelAnagrafe: String;
      var RErrMsg: String): Boolean;
    function EsistonoRichiesteAssociate(const PIDEvento: Integer): Boolean;
    function CheckDataUnivoca(const PDataEvento: TDateTime; const PRowId: String): Boolean;
    procedure EliminaGiustificativi(const PId: Integer);
    function EsistonoRiepiloghiBloccatiT040(const PInizioMese: TDateTime;
      var RErrMsg: String): Boolean;
    function GetDatiGiustT250(const PIdT251: Integer): TDatiGiust;
    function EsistonoAnomalieImportazione(PId: Integer): Boolean;
    function EsisteAnomaliaImportazione(const PId, PProg: Integer;
      var RAnomalia: String): Boolean;
  public
    ListaAnomalie: TList<TAnomalieInfo>;
    procedure selT250AfterScroll(DataSet: TDataSet);
    procedure selT250BeforePost(DataSet: TDataSet);
    procedure selT250NewRecord(DataSet: TDataSet);
    procedure selT250BeforeDelete(DataSet: TDataSet);
    procedure selT250BeforeEdit(DataSet: TDataSet);
    //procedure dsrT250StateChange(Sender: TObject);
    procedure CaricaDettaglioRichiesta(const PIdT250: Integer);
    procedure FiltraNotifiche(const PIdxAutorizzate: Integer; const PIdxBloccate: Integer);
    procedure CaricaDettaglioDipendenti(const PId: Integer; const PSoloScioperanti: Boolean = False);
    procedure BloccaRiepiloghiT250(const PProg: Integer; const PData: TDateTime);
    procedure SbloccaRiepiloghiT250(const PProg: Integer; const PData: TDateTime);
    procedure AnnullaAutorizzazione(const PId, PProgRichiedente: Integer; const PData: TDateTime);
    procedure PulisciAnomalieImportazione;
    procedure ImportaGiustificativi(const PId: Integer; const PProgRichiedente: Integer);
    property selT250_Funzioni: TOracleDataset read FSelT250_Funzioni write FSelT250_Funzioni;
    //property dsrT250_Funzioni: TDataSource read FDsrT250_Funzioni write FDsrT250_Funzioni;
  end;

const
  // valori di TIPO_RICHIESTA
  A119_TR_D = 'D'; // richiesta
  A119_TR_E = 'E'; // elaborata
  A119_TR_A = 'A'; // annullata

implementation

{$R *.dfm}

procedure TA119FPartecipazioneScioperiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT265.Open;
  selDatiBloccati:=TDatiBloccati.Create(nil);
  selT251.FieldByName('ID').Visible:=DebugHook <> 0;
  ListaAnomalie:=TList<TAnomalieInfo>.Create;
end;

procedure TA119FPartecipazioneScioperiMW.DataModuleDestroy(Sender: TObject);
begin
  try selT265.CloseAll; except end;
  try FreeAndNil(selDatiBloccati); except end;
  try FreeAndNil(ListaAnomalie); except end;
  inherited;
end;

function TA119FPartecipazioneScioperiMW.CheckDataUnivoca(const PDataEvento: TDateTime; const PRowId: String): Boolean;
// controlla se la data evento in fase di inserimento / modifica è univoca
// è infatti presente un indice unique su db
// in fase di inserimento PRowId = ''
begin
  with selT250Data do
  begin
    try
      ClearVariables;
      SetVariable('DATA_EVENTO',PDataEvento);
      if PRowId <> '' then
        SetVariable('CONTROLLO_EDIT',Format('and ROWID <> %s',[PRowId.QuotedString]));
      Execute;
      Result:=FieldAsInteger(0) = 0;
    except
      Result:=False;
    end;
  end;
end;

function TA119FPartecipazioneScioperiMW.CheckSelezioneAnagrafica(const PFiltroSelAnagrafe: String;
  var RErrMsg: String): Boolean;
// test del filtro anagrafe
begin
  RErrMsg:='';
  Result:=True;

  if PFiltroSelAnagrafe.Trim = '' then
    Exit;

  // test del filtro di selezione anagrafica
  selFiltroAnagrafe.SQL.Text:=QVistaOracle;
  selFiltroAnagrafe.SQL.Insert(0,'SELECT MATRICOLA, COGNOME, NOME, T430INIZIO, T430FINE FROM');
  selFiltroAnagrafe.SQL.Add(Format('AND (%s)',[PFiltroSelAnagrafe]));
  selFiltroAnagrafe.DeclareVariable('DataLavoro',otDate);
  selFiltroAnagrafe.SetVariable('DataLavoro',Parametri.DataLavoro);
  selFiltroAnagrafe.Close;
  try
    selFiltroAnagrafe.ExecSQL;
  except
    on E: Exception do
    begin
      Result:=False;
      RErrMsg:=Format('%s (%s)',[E.Message,E.ClassName]);
    end;
  end;
end;

procedure TA119FPartecipazioneScioperiMW.selT250NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('TIPOGIUST').AsString:='I';
  DataSet.FieldByName('GG_NOTIFICA').AsInteger:=0;
end;

procedure TA119FPartecipazioneScioperiMW.selT250AfterScroll(DataSet: TDataSet);
begin
  // spostandosi su un evento nasconde i campi di esito dell'importazione
  selT251.FieldByName('D_ESITO_IMPORTAZIONE').Visible:=False;
  selT252.FieldByName('D_ANOMALIE').Visible:=False;
end;

procedure TA119FPartecipazioneScioperiMW.selT250BeforeDelete(DataSet: TDataSet);
// impedisce cancellazione di un evento con richieste associate
begin
  if EsistonoRichiesteAssociate(selT250_Funzioni.FieldByName('ID').AsInteger) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A119_ERR_CANC));
end;

procedure TA119FPartecipazioneScioperiMW.selT250BeforeEdit(DataSet: TDataSet);
// impedisce modifica di un evento con richieste associate
begin
  if EsistonoRichiesteAssociate(selT250_Funzioni.FieldByName('ID').AsInteger) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A119_ERR_MOD));
end;

procedure TA119FPartecipazioneScioperiMW.selT250BeforePost(DataSet: TDataSet);
var
  LTipoGiust, LCausale, Errore: String;
  PulisciDaOre, PulisciAOre: Boolean;
begin
  LTipoGiust:=selT250_Funzioni.FieldByName('TIPOGIUST').AsString;

  // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3 - riesame del 15/04/2014.ini
  // data obbligatoria
  if selT250_Funzioni.FieldByName('DATA').IsNull then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A119_ERR_DATA_OBBL));

  if not CheckDataUnivoca(selT250_Funzioni.FieldByName('DATA').AsDateTime,IfThen(selT250_Funzioni.State = dsEdit,selT250_Funzioni.RowId)) then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A119_ERR_FMT_DATA_ESISTENTE),[selT250_Funzioni.FieldByName('DATA').AsString]));

  // se è stata scelta una causale, controlla che tipogiust sia coerente con la modalità di fruizione
  if not selT250_Funzioni.FieldByName('CAUSALE').IsNull then
  begin
    LCausale:=selT250_Funzioni.FieldByName('CAUSALE').AsString;
    if selT265.SearchRecord('CODICE',LCausale,[srFromBeginning]) then
    begin
      if (LTipoGiust = 'I') and (selT265.FieldByName('UM_INSERIMENTO').AsString = 'N') then
        raise Exception.Create(A000TraduzioneStringhe(Format(A000MSG_A119_ERR_FMT_CAUS_TIPOFRUIZ,[LCausale,'a giornata intera'])));
      if (LTipoGiust = 'M') and (selT265.FieldByName('UM_INSERIMENTO_MG').AsString = 'N') then
        raise Exception.Create(A000TraduzioneStringhe(Format(A000MSG_A119_ERR_FMT_CAUS_TIPOFRUIZ,[LCausale,'a mezza giornata'])));
      if (LTipoGiust = 'N') and (selT265.FieldByName('UM_INSERIMENTO_H').AsString = 'N') then
        raise Exception.Create(A000TraduzioneStringhe(Format(A000MSG_A119_ERR_FMT_CAUS_TIPOFRUIZ,[LCausale,'a numero ore'])));
      if (LTipoGiust = 'D') and (selT265.FieldByName('UM_INSERIMENTO_D').AsString = 'N') then
        raise Exception.Create(A000TraduzioneStringhe(Format(A000MSG_A119_ERR_FMT_CAUS_TIPOFRUIZ,[LCausale,'da ore a ore'])));
    end;
  end;
  // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3 - riesame del 15/04/2014.fine

  // verifica necessità di pulire i campi da ore - a ore
  PulisciDaOre:=(LTipoGiust = 'I');
  PulisciAOre:=(LTipoGiust <> 'D');
  if PulisciDaOre then
    selT250_Funzioni.FieldByName('DAORE').Clear;
  if PulisciAOre then
    selT250_Funzioni.FieldByName('AORE').Clear;

  // se tipo giust. a numero ore oppure da ore - a ore il dato "da ore" è obbligatorio
  if ((LTipoGiust = 'N') or (LTipoGiust = 'D')) and
     (selT250_Funzioni.FieldByName('DAORE').IsNull) then
  begin
    selT250_Funzioni.FieldByName('DAORE').FocusControl;
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A119_ERR_DAORE_OBBL));
  end;

  // se tipo giust. da ore a ore il dato "a ore" è obbligatorio
  if (LTipoGiust = 'D') and (selT250_Funzioni.FieldByName('AORE').IsNull) then
  begin
    selT250_Funzioni.FieldByName('DAORE').FocusControl;
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A119_ERR_AORE_OBBL));
  end;

  // verifica correttezza selezione anagrafica
  if selT250_Funzioni.FieldByName('SELEZIONE_ANAGRAFICA').AsString.Trim <> '' then
  begin
    if not CheckSelezioneAnagrafica(selT250_Funzioni.FieldByName('SELEZIONE_ANAGRAFICA').AsString,Errore) then
    begin
      selT250_Funzioni.FieldByName('SELEZIONE_ANAGRAFICA').FocusControl;
      raise Exception.Create(A000TraduzioneStringhe(Format(A000MSG_A119_ERR_FMT_SELANAGRAFE,[Errore])));
    end;
  end;
end;

{
procedure TA119FPartecipazioneScioperiMW.dsrT250StateChange(Sender: TObject);
begin
  //
end;
}

procedure TA119FPartecipazioneScioperiMW.selT251CalcFields(DataSet: TDataSet);
var
  Anom: Boolean;
  Esito: String;
begin
  inherited;
  // esito dell'importazione giust. a livello globale (della richiesta)
  // ok:     "Effettuata"
  // errori: "Non effettuata"
  Anom:=EsistonoAnomalieImportazione(selT251.FieldByName('ID').AsInteger);
  if Anom then
  begin
    // se ci sono anomalie indica l'esito negativo
    Esito:='Non effettuata';
  end
  else
  begin
    // se la richiesta è in stato E = elaborata indica che è stata effettuata
    // altrimenti non è ancora stata importata
    Esito:=IfThen(selT251.FieldByName('TIPO_RICHIESTA').AsString = A119_TR_E,'Effettuata','');
  end;
  selT251.FieldByName('D_ESITO_IMPORTAZIONE').AsString:=Esito;
end;

procedure TA119FPartecipazioneScioperiMW.selT252CalcFields(DataSet: TDataSet);
var
  LId, LProg: Integer;
  DescAnom: String;
begin
  inherited;
  // anomalie importazione a livello dettagliato (per dipendente)
  LId:=StrToInt(VarToStr(selT252.GetVariable('ID')));
  LProg:=selT252.FieldByName('PROGRESSIVO').AsInteger;

  // se il dipendente effettua sciopero controlla anomalie
  if selT252.FieldByName('SCIOPERA').AsString = 'S' then
  begin
    if EsisteAnomaliaImportazione(LId,LProg,DescAnom) then
      selT252.FieldByName('D_ANOMALIE').AsString:=DescAnom;
  end;
end;

function TA119FPartecipazioneScioperiMW.EsistonoRichiesteAssociate(const PIDEvento: Integer): Boolean;
// restituisce True se per l'evento indicato esistono delle richieste associate, oppure False altrimenti
begin
  selT251Count.Close;
  selT251Count.SetVariable('ID',PIDEvento);
  selT251Count.Execute;
  Result:=selT251Count.FieldAsInteger(0) > 0;
end;

procedure TA119FPartecipazioneScioperiMW.FiltraNotifiche(const PIdxAutorizzate,
  PIdxBloccate: Integer);
// filtra le notifiche in base ai parametri
// PIdxAutorizzate
// - 0 = si
// - 1 = no
// - 2 = tutte
// PIdxBloccate
// - 0 = si
// - 1 = no
// - 2 = tutte
var
  LFiltro,LFiltroAut,LFiltroBloc: String;
begin
  // filtro richieste autorizzate
  case PIdxAutorizzate of
    0: LFiltroAut:='(AUTORIZZATO = ''S'')';
    1: LFiltroAut:='(AUTORIZZATO = ''N'')';
    2: LFiltroAut:='';
  end;
  LFiltro:=LFiltroAut;

  // filtro richieste bloccate (riepiloghi)
  case PIdxBloccate of
    0: LFiltroBloc:='(BLOCCATO = ''S'')';
    1: LFiltroBloc:='(BLOCCATO = ''N'')';
    2: LFiltroBloc:='';
  end;
  LFiltro:=LFiltro + IfThen(((LFiltro <> '') and (LFiltroBloc <> '')),' AND ') + LFiltroBloc;

  // imposta il filtro sul dataset corrispondente
  selT251.Filtered:=False;
  selT251.Filter:=LFiltro;
  selT251.Filtered:=True;
end;

procedure TA119FPartecipazioneScioperiMW.CaricaDettaglioRichiesta(const PIdT250: Integer);
// apre il dataset di dettaglio della richiesta selT251 in base all'id dell'evento di sciopero
begin
  selT251.DisableControls;
  selT251.Close;
  selT251.SetVariable('ID_T250',PIdT250);
  selT251.Open;
  selT251.EnableControls;
end;

function TA119FPartecipazioneScioperiMW.GetDatiGiustT250(const PIdT251: Integer): TDatiGiust;
// estrae i dati del giustificativo dello sciopero dalla tabella T250,
// in base all'ID richiesta indicato
begin
  with selDatiGiust do
  begin
    Close;
    SetVariable('ID',PIdT251);
    Open;
    if selDatiGiust.RecordCount = 0 then
      raise Exception.Create(Format('Evento di sciopero non presente: ID %d',[PIdT251]));

    // imposta dati per gestione giustificativi
    Result.DataInizio:=FieldByName('DATA').AsDateTime;
    Result.DataFine:=FieldByName('DATA').AsDateTime;
    Result.Causale:=FieldByName('CAUSALE').AsString;
    Result.TipoGiust:=FieldByName('TIPOGIUST').AsString;
    Result.Dalle:=FieldByName('DAORE').AsString;
    Result.Alle:=FieldByName('AORE').AsString;

    Close;
  end;
end;

function TA119FPartecipazioneScioperiMW.EsistonoRiepiloghiBloccatiT040(const PInizioMese: TDateTime; var RErrMsg: String): Boolean;
// effettua ciclo su dataset selT252
// restituisce True se almeno uno dei dipendenti oggetti dello sciopero ha il
// blocco riepiloghi attivo su T040 per il mese indicato, oppure False altrimenti
// la variabile ErrMsg viene valorizzata con il testo dell'errore da visualizzare
var
  ContaErr: Integer;
  ErrBlocco: Boolean;
  ErrBloccoDesc: String;
begin
  // controllo riepiloghi T040 sbloccati per tutti i dipendenti oggetto di inserimento
  ContaErr:=0;
  ErrBloccoDesc:='';
  selT252.First;
  while not selT252.Eof do
  begin
    ErrBlocco:=selDatiBloccati.CheckDatoBloccato(selT252.FieldByName('PROGRESSIVO').AsInteger,PInizioMese,'T040');
    if ErrBlocco then
    begin
      inc(ContaErr);
      ErrBloccoDesc:=ErrBloccoDesc + Format('%d. %s',[ContaErr,selT252.FieldByName('NOMINATIVO').AsString]) + #13#10;
    end;
    selT252.Next;
  end;

  // imposta la variabile con l'eventuale descrizione dell'errore
  if ContaErr = 0 then
    RErrMsg:=''
  else
    RErrMsg:=Format(A000TraduzioneStringhe(A000MSG_A119_ERR_FMT_BLOCCO_RIEP),
                   [R180NomeMeseAnno(PInizioMese),ErrBloccoDesc]);

  // imposta valore da restituire
  Result:=ContaErr > 0;
end;

procedure TA119FPartecipazioneScioperiMW.CaricaDettaglioDipendenti(const PId: Integer; const PSoloScioperanti: Boolean = False);
// apre il dataset di dettaglio dei dipendenti selT252 in base all'id della richiesta selezionata
// se PSoloScioperanti è True, estrae i soli record per cui SCIOPERA = 'S'
// altrimenti estrae tutti i record
begin
  selT252.DisableControls;
  selT252.ClearVariables;
  selT252.Close;
  selT252.SetVariable('ID',PId);
  if PSoloScioperanti then
    selT252.SetVariable('FILTRO_SCIOPERA','and SCIOPERA = ''S''');
  selT252.Open;
  selT252.EnableControls;
end;

procedure TA119FPartecipazioneScioperiMW.BloccaRiepiloghiT250(const PProg: Integer; const PData: TDateTime);
// blocca i riepiloghi per il progressivo e il mese indicati
var
  InizioMese: TDateTime;
begin
  InizioMese:=R180InizioMese(PData);
  selDatiBloccati.BloccaRiepilogo(PProg,InizioMese,InizioMese,'T250');
end;

procedure TA119FPartecipazioneScioperiMW.SbloccaRiepiloghiT250(const PProg: Integer; const PData: TDateTime);
// sblocca i riepiloghi per il progressivo e il mese indicati
var
  InizioMese: TDateTime;
begin
  InizioMese:=R180InizioMese(PData);
  selDatiBloccati.SbloccaRiepilogo(PProg,InizioMese,InizioMese,'T250');
end;

procedure TA119FPartecipazioneScioperiMW.AnnullaAutorizzazione(const PId, PProgRichiedente: Integer;
  const PData: TDateTime);
// effettua l'annullamento dell'autorizzazione della richiesta, rendendola nuovamente
// modificabile dal responsabile di struttura
//var
//  TR: String;
begin
  try
    // 1. cancella i giustificativi
    EliminaGiustificativi(PId);

    // 2. annullamento dell'autorizzazione tramite procedure apposita
    with T250P_ANNULLA_RICHIESTA do
    begin
      SetVariable('ID',PId);
      SetVariable('LIVELLO',null);
      SetVariable('RESPONSABILE',null);
      SetVariable('STATO','N');
      SetVariable('AUTORIZZ_AUTOMATICA','');
      Execute;
    end;

    // 3. sblocco riepiloghi T250
    SbloccaRiepiloghiT250(PProgRichiedente,PData);
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TA119FPartecipazioneScioperiMW.PulisciAnomalieImportazione;
// pulisce l'array di anomalie di importazione
begin
  ListaAnomalie.Clear;
end;

function TA119FPartecipazioneScioperiMW.EsistonoAnomalieImportazione(PId: Integer): Boolean;
// restituisce True se esistono anomalie di importazione per la richiesta indicata
// attraverso l'ID
var
  Comparer: IComparer<TAnomalieInfo>;
  Elem: TAnomalieInfo;
  idx: Integer;
begin
  case ListaAnomalie.Count of
    0: begin
         // nessuna richiesta con anomalie
         Result:=False;
         Exit;
       end;
    1: begin
         // una richiesta con anomalie: confronta direttamente ID
         Result:=PId = ListaAnomalie[0].IdRichiesta;
       end;
  else
    // n>1 richieste con anomalie: effettua ricerca

    // prepara il comparer per ordinamento
    Comparer:=TDelegatedComparer<TAnomalieInfo>.Construct(
      function (const L, R: TAnomalieInfo): Integer
      begin
        Result:=Sign(L.IdRichiesta - R.IdRichiesta);
      end
    );

    // ordina la lista per effettuare ricerca dicotomica
    ListaAnomalie.Sort(Comparer);

    // imposta un elemento fittizio per la ricerca e quindi effettua la ricerca
    Elem.IdRichiesta:=PId;
    Result:=ListaAnomalie.BinarySearch(Elem,idx,Comparer);
  end;
end;

function TA119FPartecipazioneScioperiMW.EsisteAnomaliaImportazione(const PId, PProg: Integer; var RAnomalia: String): Boolean;
// restituisce True se esiste un'anomalia per la richiesta e il progressivo indicati
// oppure False altrimenti
// se l'anomalia è presente valorizza la descrizione in RAnomalia
var
  Elem: TAnomalieInfo;
begin
  Result:=False;
  RAnomalia:='';

  for Elem in ListaAnomalie do
  begin
   if (Elem.IdRichiesta = PId) and
      (Elem.Progressivo = PProg) then
   begin
     Result:=True;
     RAnomalia:=Elem.Anomalia;
     Break;
   end;
  end;
end;

procedure TA119FPartecipazioneScioperiMW.ImportaGiustificativi(const PId: Integer; const PProgRichiedente: Integer);
// effettua l'importazione dei giustificativi per i dipendenti compresi nella richiesta indicata
var
  Anom: TAnomalieInfo;
  Giust: TDatiGiust;
  Modo: Char;
  i, Prog: Integer;
  ErrBlocco: String;
begin
  // estrae dati giustificativo da T250 in base alla richiesta
  Giust:=GetDatiGiustT250(PId);

  // estrae elenco dipendenti per cui inserire giustificativo
  // (solo i dipendenti scioperanti)
  CaricaDettaglioDipendenti(PId,True);

  if selT252.RecordCount = 0 then
  begin
    // blocca riepiloghi T250
    BloccaRiepiloghiT250(PProgRichiedente,Giust.DataInizio);

    // imposta tipo richiesta = elaborata
    updT850.SetVariable('ID',PId);
    updT850.SetVariable('TIPO_RICHIESTA',A119_TR_E);
    updT850.Execute;
  end;

  // controllo riepiloghi bloccati T040 per i dipendenti che aderiscono allo sciopero
  if EsistonoRiepiloghiBloccatiT040(R180InizioMese(Giust.DataInizio),ErrBlocco) then
    raise Exception.Create(ErrBlocco);

  // crea MW per gestione giustificativi
  A004MW:=TA004FGiustifAssPresMW.Create(nil);
  try
    // indica di non eseguire la commit in fase di inserimento
    // solo se tutti gli inserimenti vanno a buon fine si committa la transazione,
    // altrimenti si effettua la rollback
    A004MW.EseguiCommit:=False;

    // controllo esistenza causale
    if not A004MW.R600DtM1.Q265.SearchRecord('CODICE',Giust.Causale,[srFromBeginning]) then
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_CAUS_ASS_INESISTENTE),[Giust.Causale]));

    A004MW.chkNuovoPeriodo:=False;
    A004MW.GestioneSingolaDM:=True;
    A004MW.AnomalieInterattive:=False;
    A004MW.R600DtM1.VisualizzaAnomalie:=False;
    A004MW.R600DtM1.AnomalieBloccanti:=True;
    A004MW.R600DtM1.AnomalieNonBloccanti:='1';

    A004MW.Var_Gestione:=0;
    A004MW.Var_TipoCaus:=1;
    A004MW.Var_TipoGiust_Count:=4;

    Modo:=R180CarattereDef(Giust.TipoGiust);
    case Modo of
      'I': A004MW.Var_TipoGiust:=0;
      'M': A004MW.Var_TipoGiust:=1;
      'N': A004MW.Var_TipoGiust:=2;
      'D': A004MW.Var_TipoGiust:=3;
    else
      raise Exception.Create(Format('Tipo giustificativo non valido: %s',[Modo]));
    end;

    A004MW.Var_DaOre:=StringReplace(Giust.Dalle,':','.',[]);
    A004MW.Var_AOre:=StringReplace(Giust.Alle,':','.',[]);
    A004MW.Var_NumGG:=0;
    A004MW.Var_DaData:=FormatDateTime('dd/mm/yyyy',Giust.DataInizio);
    A004MW.Var_AData:=FormatDateTime('dd/mm/yyyy',Giust.DataFine);
    A004MW.Var_Causale:=Giust.Causale;

    A004MW.Giustif.Causale:=Giust.Causale;
    A004MW.Giustif.Inserimento:=True;
    A004MW.Giustif.Modo:=Modo;
    A004MW.Giustif.DaOre:=A004MW.Var_DaOre;
    A004MW.Giustif.AOre:=A004MW.Var_AOre;

    A004MW.DataInizio:=Giust.DataInizio;
    A004MW.DataFine:=Giust.DataFine;
    A004MW.DataInizioOrig:=Giust.DataInizio;
    A004MW.Chiamante:='A119';

    // ciclo di inserimento giustificativi per i dipendenti che effettuano lo sciopero
    selT252.First;
    try
      while not selT252.Eof do
      begin
        // imposta dati progressivo corrente
        Prog:=selT252.FieldByName('PROGRESSIVO').AsInteger;

        // apre dataset per gestione giustificativo
        A004MW.Q040.Close;
        A004MW.Q040.SetVariable('PROGRESSIVO',Prog);
        A004MW.Q040.Open;

        // imposta variabile su middleware
        A004MW.Var_Progressivo:=Prog;

        // effettua inserimento giustificativo
        A004MW.InserisciGiustif(False,PId);

        // gestione anomalie
        if A004MW.R600DtM1.ListAnomalie.Count > 0 then
        begin
          for i:=0 to A004MW.R600DtM1.ListAnomalie.Count - 1 do
          begin
            RegistraMsg.InserisciMessaggio('A',A004MW.R600DtM1.ListAnomalie[i],'',Prog);
          end;
          raise Exception.Create(A004MW.R600DtM1.FormattaAnomaliaWeb(A004MW.R600DtM1.ListAnomalie,True,False));
        end
        else
        begin
          RegistraMsg.InserisciMessaggio('I',Format('Inserimento giustificativo',[]),'',Prog);

          // blocca riepiloghi T250
          BloccaRiepiloghiT250(PProgRichiedente,Giust.DataInizio);

          // imposta tipo richiesta = elaborata
          updT850.SetVariable('ID',PId);
          updT850.SetVariable('TIPO_RICHIESTA',A119_TR_E);
          updT850.Execute;
        end;

        selT252.Next;
      end;
    except
      on E: Exception do
      begin
        // aggiunge l'anomalia alla lista
        Anom.IdRichiesta:=PId;
        Anom.Progressivo:=Prog;
        Anom.Anomalia:=E.Message;
        ListaAnomalie.Add(Anom);

        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(A004MW);
  end;
end;

procedure TA119FPartecipazioneScioperiMW.EliminaGiustificativi(const PId: Integer);
// esegue la cancellazione dei giustificativi in base all'id della richiesta che li ha generati
var
  Giust: TDatiGiust;
  ErrBlocco: String;
  Modo: Char;
begin
  // estrae dati giustificativo da T250 in base alla richiesta
  Giust:=GetDatiGiustT250(PId);

  // estrae elenco dipendenti per cui inserire giustificativo
  // (solo i dipendenti scioperanti)
  CaricaDettaglioDipendenti(PId,True);

  // controllo riepiloghi bloccati T040 per i dipendenti che aderiscono allo sciopero
  if EsistonoRiepiloghiBloccatiT040(R180InizioMese(Giust.DataInizio),ErrBlocco) then
    raise Exception.Create(ErrBlocco);

  // crea MW per gestione giustificativi
  A004MW:=TA004FGiustifAssPresMW.Create(nil);
  try
    // indica di non eseguire la commit in fase di cancellazione
    // solo se tutte le cancellazioni vanno a buon fine si committa la transazione,
    // altrimenti si effettua la rollback
    A004MW.EseguiCommit:=False;

    // estrae tutti i giustificativi legati all'id richiesta indicato
    // nota: la possibilità di trovare 0 record deriva dal fatto che una richiesta
    //       può avere 0 dipendenti scioperanti
    //       pertanto non è considerata un'eccezione
    selT040Canc.Close;
    selT040Canc.SetVariable('ID',PId);
    selT040Canc.Open;
    if selT040Canc.RecordCount > 0 then
    begin
      try
        // ciclo di cancellazione giustificativi per i dipendenti che effettuano lo sciopero
        while not selT040Canc.Eof do
        begin
          // imposta variabili per cancellazione
          A004MW.chkNuovoPeriodo:=False;
          A004MW.GestioneSingolaDM:=True;
          A004MW.AnomalieInterattive:=False;
          A004MW.R600DtM1.VisualizzaAnomalie:=False;
          A004MW.R600DtM1.AnomalieBloccanti:=True;
          A004MW.R600DtM1.AnomalieNonBloccanti:='1';

          A004MW.Var_Gestione:=0;
          A004MW.Var_TipoCaus:=1;
          A004MW.Var_TipoGiust_Count:=4;

          Modo:=R180CarattereDef(selT040Canc.FieldByName('TIPOGIUST').AsString);
          case Modo of
            'I': A004MW.Var_TipoGiust:=0;
            'M': A004MW.Var_TipoGiust:=1;
            'N': A004MW.Var_TipoGiust:=2;
            'D': A004MW.Var_TipoGiust:=3;
          else
            raise Exception.Create(Format('Tipo giustificativo non valido: %s',[Modo]));
          end;

          A004MW.Var_DaOre:=FormatDateTime('hhhh.mm',selT040Canc.FieldByName('DAORE').AsDateTime);
          A004MW.Var_AOre:=FormatDateTime('hhhh.mm',selT040Canc.FieldByName('AORE').AsDateTime);
          A004MW.Var_NumGG:=0;
          A004MW.Var_DaData:=selT040Canc.FieldByName('DATA').AsString;
          A004MW.Var_AData:=A004MW.Var_DaData;
          A004MW.Var_Causale:=selT040Canc.FieldByName('CAUSALE').AsString;

          A004MW.Giustif.Causale:=A004MW.Var_Causale;
          A004MW.Giustif.Inserimento:=False;
          A004MW.Giustif.Modo:=Modo;
          A004MW.Giustif.DaOre:=A004MW.Var_DaOre;
          A004MW.Giustif.AOre:=A004MW.Var_AOre;

          A004MW.DataInizio:=StrToDate(A004MW.Var_DaData);
          A004MW.DataFine:=StrToDate(A004MW.Var_AData);
          A004MW.DataInizioOrig:=Giust.DataInizio;
          A004MW.Chiamante:='A119';

          // apre dataset per gestione giustificativo
          A004MW.Q040.Close;
          A004MW.Q040.SetVariable('PROGRESSIVO',selT040Canc.FieldByName('PROGRESSIVO').AsInteger);
          A004MW.Q040.Open;

          // effettua cancellazione
          A004MW.CancellaGiustif(False,selT040Canc.Recno = selT040Canc.RecordCount);

          // segnalazione errore
          if A004MW.ErroreCancellazione <> '' then
          begin
            raise Exception.Create(A004MW.ErroreCancellazione);
          end;

          // errore blocco riepiloghi dovrebbe essere impossibile in quanto verificato a monte
          if A004MW.DatoBloccatoCancellazione then
          begin
            raise Exception.Create(Format(A000MSG_DATIBLOCCATI_ERR_FMT_DATI_NONMODIF,[A004MW.Var_DaData,'T040']));
          end;

          selT040Canc.Next;
        end;
      except
        on E: Exception do
        begin
          raise Exception.Create(E.Message);
        end;
      end;
    end;
  finally
    selT040Canc.Close;
    FreeAndNil(A004MW);
  end;
end;

end.
