unit A145UComVisiteFiscaliMW;

interface

uses
  Variants,System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData, USelI010, A000UInterfaccia,
  Math,C180FunzioniGenerali, Datasnap.DBClient, QueryStorico, A000UMessaggi,
  Oracle, StrUtils, R600;

type
  TStoriaDip = record
    Operazione,
    Inizio,
    Fine,
    Giorni,
    TipoEsenzione:String;
    bottom: Boolean;
  end;

  TArrayStoriaDip = Array of TStoriaDip;

  TDatiElab = record
    DataElaborazione: TDateTime;
    DataDa,DataA: TDateTime;
    bAggiorna,
    bPeriodiComunicati,
    bNumProt,
    bLuogo,
    bProl,
    bEsenzioneAutomatica,
    bFiltroDataComun,
    bSoloCont: Boolean;
    sNumProt,
    sLuogo,
    sDato1,
    sDato2,
    sFirma,
    sMedicineLegali,
    sMaxGiorniContinuativi,
    sMesiVerificaEventi,
    sNumeroMinimoEventi: String;
    iTipoStampa: Integer;
    ListaDettaglio:TStringList;
    ListaCausali: TStringList;
    Operazione: String;
  end;

  TA145FComVisiteFiscaliMW = class(TR005FDataModuleMW)
    selT485: TOracleDataSet;
    selT047UltimaCom: TOracleDataSet;
    selT047CompensaIns: TOracleDataSet;
    selT047CancInterne: TOracleDataSet;
    selT047Add: TOracleDataSet;
    selT047PAnnullato: TOracleDataSet;
    selT047UnificaPeriodi: TOracleDataSet;
    selT047PeriodoSucc: TOracleDataSet;
    selT047: TOracleDataSet;
    selT047TIPO_EVENTO: TStringField;
    selT047PROGRESSIVO: TFloatField;
    selT047OPERAZIONE: TStringField;
    selT047DATA_INIZIO_ASSENZA: TDateTimeField;
    selT047DATA_FINE_ASSENZA: TDateTimeField;
    selT047NUOVA_DATA_FINE: TDateTimeField;
    selT047DATA_REGISTRAZIONE: TDateTimeField;
    selT047DATA_PRIMA_COMUNICAZIONE: TDateTimeField;
    selT047DATA_REGIS_PROLUNGAMENTO: TDateTimeField;
    selT047DATA_COMUN_PROLUNGAMENTO: TDateTimeField;
    selT047COD_COMUNE: TStringField;
    selT047INDIRIZZO: TStringField;
    selT047CAP: TStringField;
    selT047TELEFONO: TStringField;
    selT047PROGNOSI: TIntegerField;
    selT047PROGNOSI_PRIMA: TIntegerField;
    selT047PROGNOSI_PROL: TIntegerField;
    selT047CITTA: TStringField;
    selT047PROVINCIA: TStringField;
    selT047MEDICINA_LEGALE: TStringField;
    selT047TIPO_ESENZIONE: TStringField;
    selT047DATA_ESENZIONE: TDateTimeField;
    selT047OPERATORE: TStringField;
    selT047NOTE: TStringField;
    TabellaStampa: TClientDataSet;
    selV430: TOracleDataSet;
    selCercaMedLeg: TOracleDataSet;
    selMedLegali: TOracleDataSet;
    updT047: TOracleQuery;
    selV430MedLeg: TOracleDataSet;
    selT040: TOracleDataSet;
    prcGetInizioAssenza: TOracleQuery;
    selT047Canc: TOracleDataSet;
    selT047Esen: TOracleDataSet;
    selT265: TOracleDataSet;
    TabellaEsenzioni: TClientDataSet;
    GetCalendario: TOracleQuery;
    selT047Esenzioni: TOracleDataSet;
    selT047Prog: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT047PAnnullatoAfterPost(DataSet: TDataSet);
    procedure selT047PAnnullatoBeforePost(DataSet: TDataSet);
    procedure selT047AfterPost(DataSet: TDataSet);
    procedure selT047BeforePost(DataSet: TDataSet);
    procedure selT047CalcFields(DataSet: TDataSet);
    procedure TabellaEsenzioniBeforePost(DataSet: TDataSet);
    procedure TabellaEsenzioniFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TabellaEsenzioniAfterPost(DataSet: TDataSet);
  private
    R600DtM:TR600DtM1;
    CodComuneDom,ComuneDom,CapDom,ProvDom,IndirizzoDom,MedLegCod: String;
    EsenzioneAutomatica: Boolean;
    GiorniAssenza,EventiAssenza,GiorniEsenzione,EventiEsenzione: Integer;
    ModifInCorso: Boolean;
    function InsRecord(Esenzioni: Boolean): Boolean;
    procedure GetEventiMalattia;
    procedure CompensaPeriodiIns;
    procedure EstraiDatiDomicilio(Progressivo: Integer; DataLimite: TDateTime);
    procedure EstraiMedicinaLegale(Progressivo: Integer; DataLimite: TDateTime);
    function ConcatenaDatiDomicilio: String;
    procedure AggiornaEsenzioniCanc;
    function getGiornoNonLavEsenzioni: Boolean;
  public
    DatiElab: TDatiElab;
    DataLimiteEventiAssenza: TDateTime;
    selI010:TselI010;
    C004_SALVA_OPZIONI:Boolean;
    itemIndexFiltroEsenzioni:Integer;
    ConfermaBeforePostEsenzioni : TProc<String>;
    AfterPostEsenzioni: TProc;
    procedure CompensaPeriodi;
    procedure UnificaPeriodi;
    procedure OttimizzaPeriodi;
    procedure InizioElaborazione(Esenzioni:Boolean);
    procedure ElaboraElemento(Esenzioni:Boolean);
    procedure CreaTabellaStampa;
    procedure AggiornaDataComunicazione;
    procedure ImpostaCampiSelAnagrafe;
    procedure AnnullaDataComunicazione(DataUltimaComunicazione: TDateTime);
    function GetUltimaComunicazione: TDateTime;
    procedure getLstCampiAnagrafici(var LstCampiAnagrafici: TStringList);
    function MessaggioNessunPeriodo(PeriodiComunicati: Boolean): String;
    procedure CreaTabellaEsenzioni;
    function StoriaDipendente(Progressivo: Integer): TArrayStoriaDip;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
procedure TA145FComVisiteFiscaliMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  C004_SALVA_OPZIONI:=False;
  selT485.Open;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  selT047Add.Open;
  selMedLegali.Open;
  DatiElab.ListaDettaglio:=TStringList.Create;
  DatiElab.ListaCausali:=TStringList.Create;
  selT265.Open;
  // carica lista delle causali rilevanti per le visite fiscali
  selT265.First;
  while not selT265.Eof do
  begin
    DatiElab.ListaCausali.Add(selT265.FieldByName('CODICE').AsString);
    selT265.Next;
  end;
  // apre dataset
  R600DtM:=TR600Dtm1.Create(Self);
end;

procedure TA145FComVisiteFiscaliMW.AnnullaDataComunicazione(DataUltimaComunicazione: TDateTime);
// pulisce la data di comunicazione per il record attualmente attivo
// v. ciclo di annullamento nella procedura btnEseguiClick
begin
  with selT047PAnnullato do
  begin
    // determina quale data di comunicazione occorre annullare
    if FieldByName('DATA_COMUN_PROLUNGAMENTO').AsDateTime = DataUltimaComunicazione then
    begin
      // annulla data di comunicazione prolungamento
      Edit;
      FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
      Post;
    end
    else
    begin
      // annulla data di prima comunicazione
      Edit;
      FieldByName('DATA_PRIMA_COMUNICAZIONE').Value:=null;
      Post;

      // se il periodo prima dell'annullamento risultava prolungato, annulla il prolungamento
      if not FieldByName('NUOVA_DATA_FINE').IsNull then
      begin
        // aggiorna la data di fine con la data del prolungamento
        Edit;
        FieldByName('DATA_FINE_ASSENZA').AsDateTime:=FieldByName('NUOVA_DATA_FINE').AsDateTime;
        FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracle);
        FieldByName('NUOVA_DATA_FINE').Value:=null;
        FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
        Post;
      end;
    end;

    // commit
    try SessioneOracle.Commit; except end;
  end; // => with A145FComunicazioneVisiteFiscaliDtM
end;

procedure TA145FComVisiteFiscaliMW.CreaTabellaStampa;
var
  i,Len: Integer;
  Name: String;
begin
  // se necessario svuota dataset
  if TabellaStampa.Active then
    TabellaStampa.EmptyDataSet;
  TabellaStampa.Close;

  // definizione dei campi del dataset
  with TabellaStampa.FieldDefs do
  begin
    Clear;
    Add('MedLegDesc',ftString,60,False);
    Add('Cognome',ftString,30,False);
    Add('Nome',ftString,30,False);
    Add('Progressivo',ftInteger,0,False);
    Add('DataInizioAssenza',ftDate,0,False);
    Add('Operazione',ftString,1,False);
    Add('MedLegCod',ftString,10,False);
    Add('MedLegIndirizzo',ftString,40,False);
    Add('MedLegComune',ftString,40,False);
    Add('MedLegCap',ftString,5,False);
    Add('MedLegTel',ftString,15,False);
    Add('MedLegEmail',ftString,40,False);
    Add('Matricola',ftString,10,False);
    Add('NomeCognome',ftString,60,False);
    Add('TipoEvento',ftString,2,False);
    Add('DataFineAssenza',ftDate,0,False);
    Add('Prognosi',ftInteger,0,False);
    Add('PrognosiPrima',ftInteger,0,False);
    Add('PrognosiProl',ftInteger,0,False);
    Add('NuovaDataFine',ftDate,0,False);
    Add('DataRegistrazione',ftDateTime,0,False); // anche ore-min
    Add('DataPrimaComunicazione',ftDate,0,False);
    Add('DataRegisProlungamento',ftDateTime,0,False); // anche ore-min
    Add('DataComunProlungamento',ftDate,0,False);
    Add('Comune',ftString,40,False);
    Add('Provincia',ftString,2,False);
    Add('Indirizzo',ftString,80,False);
    Add('Cap',ftString,5,False);
    Add('Telefono',ftString,15,False);
    Add('C_Domicilio',ftString,150,False);
    Add('NumAssenze',ftInteger,0,False);
    Add('GiorniAssenza',ftInteger,0,False);
    Add('TipoEsenzione',ftString,50,False);
    Add('DataEsenzione',ftDateTime,0,False);
    Add('Operatore',ftString,20,False);
    Add('Note',ftString,2000,False);
    // campi sel\ezionati dall'utente
    for i:=0 to DatiElab.ListaDettaglio.Count - 1 do
    begin
      Len:=Length(DatiElab.ListaDettaglio.Strings[i]);
      Name:='A_' + Copy(DatiElab.ListaDettaglio.Strings[i],1,Len);
      Add(Name,ftString,100,False);
    end;
  end;

  // definizione di un indice
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario','MedLegDesc;Cognome;Nome;Progressivo;DataInizioAssenza;Operazione',[]);
  TabellaStampa.IndexDefs[0].DescFields:='Operazione';
  TabellaStampa.IndexName:='Primario';

  // crea il dataset
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA145FComVisiteFiscaliMW.CompensaPeriodi;
// compensazione dei periodi di inserimento con le cancellazioni interne e viceversa.
// (per ora compensa solo gli inserimenti)
begin
  CompensaPeriodiIns;
  //CompensaPeriodiCan;
end;

procedure TA145FComVisiteFiscaliMW.CompensaPeriodiIns;
// Compensa i periodi di inserimento dopo le operazioni di annullamento di comunicazioni
var
  InizioUguale,FineUguale: Boolean;
  ContinuaCancInterne: Boolean;
  InsPrimoPeriodo: Boolean;
  InizioINS,FineINS: TDateTime;
  DataInizioAssenzaTemp,DataFineAssenzaTemp,DataPrimaComunicazioneTemp: TDateTime;
begin
  // ciclo sui periodi di inserimento non ancora comunicati (normali / prolungati)
  // per verificare se esistono cancellazioni interne che li compensano in parte o interamente
  selT047CompensaIns.Close;
  selT047CompensaIns.Open;
  while not selT047CompensaIns.Eof do
  begin
    ContinuaCancInterne:=True;

    while ContinuaCancInterne do
    begin
      // verifica il tipo di inserimento che si sta considerando: primo periodo o prolungato
      InsPrimoPeriodo:=selT047CompensaIns.FieldByName('NUOVA_DATA_FINE').IsNull;

      // imposta gli estremi del periodo
      if InsPrimoPeriodo then
      begin
        InizioINS:=selT047CompensaIns.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime;
        FineINS:=selT047CompensaIns.FieldByName('DATA_FINE_ASSENZA').AsDateTime;
      end
      else
      begin
        InizioINS:=selT047CompensaIns.FieldByName('DATA_FINE_ASSENZA').AsDateTime + 1;
        FineINS:=selT047CompensaIns.FieldByName('NUOVA_DATA_FINE').AsDateTime;
      end;

      // estrae il primo periodo di cancellazione interno all'inserimento in ordine di data_inizio
      selT047CancInterne.Close;
      selT047CancInterne.SetVariable('PROGRESSIVO',selT047CompensaIns.FieldByName('PROGRESSIVO').AsInteger);
      selT047CancInterne.SetVariable('DATA_INIZIO_ASSENZA',InizioINS);
      selT047CancInterne.SetVariable('DATA_FINE_ASSENZA',FineINS);
      selT047CancInterne.Open;
      if selT047CancInterne.RecordCount = 0 then
        Break; // passa al movimento di inserimento successivo

      { Sono considerati 4 casi per la cancellazione interna all'inserimento
        1. periodo cancellazione esattamente = all'inserimento
        2. inizio cancellazione = inizio inserimento
        3. fine cancellazione = fine inserimento
        4. cancellazione strettamente interna all'inserimento }
      selT047CancInterne.First;
      InizioUguale:=(InizioINS = selT047CancInterne.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime);
      FineUguale:=(FineINS = selT047CancInterne.FieldByName('DATA_FINE_ASSENZA').AsDateTime);

      if InizioUguale and FineUguale then
      begin
        // caso 1. i periodi si compensano a vicenda

        // elimina il periodo di cancellazione
        selT047CancInterne.Delete;

        // elimina il periodo di inserimento / annulla il prolungamento
        if InsPrimoPeriodo then
          selT047CompensaIns.Delete
        else
        begin
          selT047CompensaIns.Edit;
          selT047CompensaIns.FieldByName('NUOVA_DATA_FINE').Value:=null;
          selT047CompensaIns.FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
          selT047CompensaIns.Post;
        end;

        // passa al prossimo periodo di inserimento
        ContinuaCancInterne:=False;
      end
      else if InizioUguale then
      begin
        // l'inserimento viene ridimensionato e la cancellazione eliminata
        if InsPrimoPeriodo then
        begin
          selT047CompensaIns.Edit;
          selT047CompensaIns.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=selT047CancInterne.FieldByName('DATA_FINE_ASSENZA').AsDateTime + 1;
          selT047CompensaIns.FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracle);
          selT047CompensaIns.Post;
        end
        else
        begin
          // divide il periodo di inserimento in due parti
          // 1. la parte di prolungamento diventa un periodo normale
          with selT047CompensaIns do
          begin
            DataInizioAssenzaTemp:=FieldByName('DATA_INIZIO_ASSENZA').AsDateTime;
            DataFineAssenzaTemp:=FieldByName('DATA_FINE_ASSENZA').AsDateTime;
            DataPrimaComunicazioneTemp:=FieldByName('DATA_PRIMA_COMUNICAZIONE').AsDateTime;

            Edit;
            FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=selT047CancInterne.FieldByName('DATA_FINE_ASSENZA').AsDateTime + 1;
            FieldByName('DATA_FINE_ASSENZA').Value:=selT047CompensaIns.FieldByName('NUOVA_DATA_FINE').Value;
            FieldByName('NUOVA_DATA_FINE').Value:=null;
            FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracle);
            FieldByName('DATA_PRIMA_COMUNICAZIONE').Value:=null;
            FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
            FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
            Post;
          end;

          // 2. crea un inserimento del periodo di prima comunicazione
          //   (che non sarà più considerato nei calcoli di compensazione)
          with selT047Add do
          begin
            Append;
            FieldByName('TIPO_EVENTO').Value:=selT047CompensaIns.FieldByName('TIPO_EVENTO').Value;
            FieldByName('PROGRESSIVO').Value:=selT047CompensaIns.FieldByName('PROGRESSIVO').Value;
            FieldByName('OPERAZIONE').Value:=selT047CompensaIns.FieldByName('OPERAZIONE').Value;
            FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataInizioAssenzaTemp;
            FieldByName('DATA_FINE_ASSENZA').AsDateTime:=DataFineAssenzaTemp;
            FieldByName('NUOVA_DATA_FINE').Value:=null;
            FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracle);
            FieldByName('DATA_PRIMA_COMUNICAZIONE').AsDateTime:=DataPrimaComunicazioneTemp;
            FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
            FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
            FieldByName('COD_COMUNE').Value:=selT047CompensaIns.FieldByName('COD_COMUNE').Value;
            FieldByName('INDIRIZZO').Value:=selT047CompensaIns.FieldByName('INDIRIZZO').Value;
            FieldByName('CAP').Value:=selT047CompensaIns.FieldByName('CAP').Value;
            FieldByName('TELEFONO').Value:=selT047CompensaIns.FieldByName('TELEFONO').Value;
            Post;
          end;
        end;

        // elimina il periodo di cancellazione
        selT047CancInterne.Delete;

        // considera ancora il periodo ridimensionato
        ContinuaCancInterne:=True;
      end
      else if FineUguale then
      begin
        // l'inserimento viene ridimensionato e la cancellazione eliminata
        selT047CompensaIns.Edit;
        if InsPrimoPeriodo then
        begin
          selT047CompensaIns.FieldByName('DATA_FINE_ASSENZA').AsDateTime:=selT047CancInterne.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime - 1;
          selT047CompensaIns.FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracle);
        end
        else
        begin
          selT047CompensaIns.FieldByName('NUOVA_DATA_FINE').AsDateTime:=selT047CancInterne.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime - 1;
          selT047CompensaIns.FieldByName('DATA_REGIS_PROLUNGAMENTO').AsDateTime:=R180SysDate(SessioneOracle);
        end;
        selT047CompensaIns.Post;

        // elimina il periodo di cancellazione
        selT047CancInterne.Delete;

        // passa al prossimo inserimento
        ContinuaCancInterne:=False;
      end
      else
      begin
        // divide il periodo di inserimento in due parti

        // 1. l'inserimento viene ridimensionato
        with selT047CompensaIns do
        begin
          // salva impostazioni per l'inserimento
          DataInizioAssenzaTemp:=FieldByName('DATA_INIZIO_ASSENZA').AsDateTime;
          DataFineAssenzaTemp:=FieldByName('DATA_FINE_ASSENZA').AsDateTime;
          DataPrimaComunicazioneTemp:=FieldByName('DATA_PRIMA_COMUNICAZIONE').AsDateTime;

          Edit;
          if InsPrimoPeriodo then
          begin
            // la data di inizio assenza viene spostata in avanti
            FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=selT047CancInterne.FieldByName('DATA_FINE_ASSENZA').AsDateTime + 1;
            FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracle);
          end
          else
          begin
            // la parte di prolungamento diventa un periodo normale
            FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=selT047CancInterne.FieldByName('DATA_FINE_ASSENZA').AsDateTime + 1;
            FieldByName('DATA_FINE_ASSENZA').Value:=FieldByName('NUOVA_DATA_FINE').Value;
            FieldByName('NUOVA_DATA_FINE').Value:=null;
            FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracle);
            FieldByName('DATA_PRIMA_COMUNICAZIONE').Value:=null;
            FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
            FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
          end;
          Post;
        end;

        // 2. crea un inserimento precedente alla cancellazione
        //   (che non sarà più considerato per successive compensazioni)
        with selT047Add do
        begin
          Append;
          FieldByName('TIPO_EVENTO').Value:=selT047CompensaIns.FieldByName('TIPO_EVENTO').Value;
          FieldByName('PROGRESSIVO').Value:=selT047CompensaIns.FieldByName('PROGRESSIVO').Value;
          FieldByName('OPERAZIONE').Value:=selT047CompensaIns.FieldByName('OPERAZIONE').Value;
          FieldByName('DATA_INIZIO_ASSENZA').AsDateTime:=DataInizioAssenzaTemp;
          if InsPrimoPeriodo then
          begin
            FieldByName('DATA_FINE_ASSENZA').AsDateTime:=selT047CancInterne.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime - 1;
            FieldByName('NUOVA_DATA_FINE').Value:=null;
            FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracle);
            FieldByName('DATA_PRIMA_COMUNICAZIONE').Value:=null;
            FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=null;
            FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
          end
          else
          begin
            FieldByName('DATA_FINE_ASSENZA').AsDateTime:=DataFineAssenzaTemp;
            FieldByName('NUOVA_DATA_FINE').AsDateTime:=selT047CancInterne.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime - 1;
            FieldByName('DATA_REGISTRAZIONE').AsDateTime:=R180SysDate(SessioneOracle);
            FieldByName('DATA_PRIMA_COMUNICAZIONE').Value:=DataPrimaComunicazioneTemp;
            FieldByName('DATA_REGIS_PROLUNGAMENTO').Value:=R180SysDate(SessioneOracle);
            FieldByName('DATA_COMUN_PROLUNGAMENTO').Value:=null;
          end;
          FieldByName('COD_COMUNE').Value:=selT047CompensaIns.FieldByName('COD_COMUNE').Value;
          FieldByName('INDIRIZZO').Value:=selT047CompensaIns.FieldByName('INDIRIZZO').Value;
          FieldByName('CAP').Value:=selT047CompensaIns.FieldByName('CAP').Value;
          FieldByName('TELEFONO').Value:=selT047CompensaIns.FieldByName('TELEFONO').Value;
          Post;
        end;

        // elimina il periodo di cancellazione
        selT047CancInterne.Delete;

        // considera ancora il periodo ridimensionato
        ContinuaCancInterne:=True;
      end;
    end;

    selT047CompensaIns.Next;
  end; // ==> while selT047CompensaIns (inserimenti non comunicati)

  // commit delle operazioni
  try SessioneOracle.Commit; except end;
end;

function TA145FComVisiteFiscaliMW.GetUltimaComunicazione: TDateTime;
var
  ComunPrima,ComunProlungamento: TDateTime;
begin
  with selT047UltimaCom do
  begin
    Close;
    Open;
    ComunPrima:=Fields[0].AsDateTime;
    ComunProlungamento:=Fields[1].AsDateTime;
    Result:=Max(ComunPrima,ComunProlungamento);
  end;
end;

procedure TA145FComVisiteFiscaliMW.selT047AfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TA145FComVisiteFiscaliMW.selT047BeforePost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('M','T047_VISITEFISCALI',NomeOwner,selT047,True);
end;

procedure TA145FComVisiteFiscaliMW.selT047CalcFields(DataSet: TDataSet);
begin
  inherited;
  if selT047.FieldByName('NUOVA_DATA_FINE').IsNull then
  begin
    selT047.FieldByName('PROGNOSI').AsInteger:=Trunc(selT047.FieldByName('DATA_FINE_ASSENZA').AsDateTime - selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime + 1);
    selT047.FieldByName('PROGNOSI_PRIMA').Value:=selT047.FieldByName('PROGNOSI').Value;
    selT047.FieldByName('PROGNOSI_PROL').Value:=null;
  end
  else
  begin
    selT047.FieldByName('PROGNOSI').AsInteger:=Trunc(selT047.FieldByName('NUOVA_DATA_FINE').AsDateTime - selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime + 1);
    selT047.FieldByName('PROGNOSI_PRIMA').AsInteger:=Trunc(selT047.FieldByName('DATA_FINE_ASSENZA').AsDateTime - selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime + 1);
    selT047.FieldByName('PROGNOSI_PROL').AsInteger:=Trunc(selT047.FieldByName('NUOVA_DATA_FINE').AsDateTime - selT047.FieldByName('DATA_FINE_ASSENZA').AsDateTime);
  end;
end;

procedure TA145FComVisiteFiscaliMW.AggiornaDataComunicazione;
// Aggiorna la data di comunicazione (prima comunicazione oppure prolungamento)
// direttamente sulla tabella T047_VISITEFISCALI, quindi COMMITTA SUBITO
begin
  with selT047 do
  begin
    if FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull then
    begin
      // aggiorna data prima comunicazione
      Edit;
      FieldByName('DATA_PRIMA_COMUNICAZIONE').AsDateTime:=DatiElab.DataElaborazione;
      Post;
    end
    else
    begin
      // aggiorna data comunicazione prolungamento
      Edit;
      FieldByName('DATA_COMUN_PROLUNGAMENTO').AsDateTime:=DatiElab.DataElaborazione;
      Post;
    end;

    // commit
    try SessioneOracle.Commit; except end;
  end; // ==> with A145FComunicazioneVisiteFiscaliDtM
end;

procedure TA145FComVisiteFiscaliMW.selT047PAnnullatoAfterPost(
  DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TA145FComVisiteFiscaliMW.selT047PAnnullatoBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('M','T047_VISITEFISCALI',NomeOwner,selT047PAnnullato,True);
end;

procedure TA145FComVisiteFiscaliMW.TabellaEsenzioniAfterPost(DataSet: TDataSet);
begin
  inherited;
  //Aggiorno T047 effettiva....
  updT047.SetVariable('PROG',TabellaEsenzioni.FieldByName('PROGRESSIVO').AsInteger);
  updT047.SetVariable('INIZIO',TabellaEsenzioni.FieldByName('DATAINIZIOASSENZA').Value);
  updT047.SetVariable('OPER',TabellaEsenzioni.FieldByName('OPERAZIONE').AsString);
  updT047.SetVariable('TIPO',TabellaEsenzioni.FieldByName('TIPOESENZIONE').AsString);
  updT047.SetVariable('OPERATORE',TabellaEsenzioni.FieldByName('OPERATORE').AsString);
  updT047.SetVariable('DATA',TabellaEsenzioni.FieldByName('DATAESENZIONE').Value);
  updT047.Execute;
  SessioneOracle.Commit;
  ModifInCorso:=False;
  if Assigned(AfterPostEsenzioni) then
    AfterPostEsenzioni;
end;

procedure TA145FComVisiteFiscaliMW.TabellaEsenzioniBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (TabellaEsenzioni.FieldByName('TIPOESENZIONE').Value = null) and
     (VarToStr(TabellaEsenzioni.FieldByName('TIPOESENZIONE').OldValue) = '') then
    Exit;
//  TabellaEsenzioni.FieldByName('TIPOESENZIONE').AsString:=UpperCase(Copy(TabellaEsenzioni.FieldByName('TIPOESENZIONE').AsString,1,1)) +
//    LowerCase(Copy(TabellaEsenzioni.FieldByName('TIPOESENZIONE').AsString,2,Length(TabellaEsenzioni.FieldByName('TIPOESENZIONE').AsString)-1));

  ModifInCorso:=True;
  if Trim(TabellaEsenzioni.FieldByName('TIPOESENZIONE').AsString) = '' then
  begin
    TabellaEsenzioni.FieldByName('DATAESENZIONE').Value:=null;
    TabellaEsenzioni.FieldByName('OPERATORE').Value:='';
  end
  else
  begin
    TabellaEsenzioni.FieldByName('DATAESENZIONE').AsDateTime:=DatiElab.DataElaborazione;
    TabellaEsenzioni.FieldByName('OPERATORE').AsString:=Parametri.Operatore;
  end;

  if getGiornoNonLavEsenzioni then
    if Assigned(ConfermaBeforePostEsenzioni) then
      ConfermaBeforePostEsenzioni(A000MSG_A145_DLG_ESENZ_NON_LAV);
end;

procedure TA145FComVisiteFiscaliMW.TabellaEsenzioniFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  if ModifInCorso then
    Exit;
  if itemIndexFiltroEsenzioni = 0 then
    Accept:=(TabellaEsenzioni.FieldByName('OPERAZIONE').AsString = 'I') and
            (TabellaEsenzioni.FieldByName('DATAESENZIONE').IsNull or
             (TabellaEsenzioni.FieldByName('DATAESENZIONE').AsDateTime = DatiElab.DataElaborazione))
  else if itemIndexFiltroEsenzioni = 2 then
    Accept:=(TabellaEsenzioni.FieldByName('OPERAZIONE').AsString = 'I') and
            ((not TabellaEsenzioni.FieldByName('DATAESENZIONE').IsNull) and (TabellaEsenzioni.FieldByName('DATAESENZIONE').AsDateTime < DatiElab.DataElaborazione))
  else if itemIndexFiltroEsenzioni = 1 then
    Accept:=(TabellaEsenzioni.FieldByName('OPERAZIONE').AsString = 'I')
  else
    Accept:=(TabellaEsenzioni.FieldByName('OPERAZIONE').AsString = 'C') and
    (TabellaEsenzioni.FieldByName('TIPOESENZIONE').IsNull or
    (TabellaEsenzioni.FieldByName('DATAESENZIONE').AsDateTime = datiElab.DataElaborazione));
end;

procedure TA145FComVisiteFiscaliMW.getLstCampiAnagrafici(var LstCampiAnagrafici:TStringList);
begin
  // popola check list dei dettagli (usando il dataset dei campi anagrafici ridefiniti)
  selI010.First;
  while not selI010.Eof do
  begin
    LstCampiAnagrafici.Add(selI010.FieldByName('NOME_LOGICO').AsString);
    selI010.Next;
  end;
end;

procedure TA145FComVisiteFiscaliMW.UnificaPeriodi;
// ciclo di unificazione dei periodi consecutivi sulla T047
var
  Progressivo: Integer;
  Operazione: String;
  DataInizio: TDateTime;
  NuovoPeriodo: Boolean;
begin
  selT047UnificaPeriodi.Open;
  while not selT047UnificaPeriodi.Eof do
  begin
    // imposta le variabili per il controllo di un periodo successivo
    Progressivo:=selT047UnificaPeriodi.FieldByName('PROGRESSIVO').AsInteger;
    Operazione:=selT047UnificaPeriodi.FieldByName('OPERAZIONE').AsString;
    if selT047UnificaPeriodi.FieldByName('NUOVA_DATA_FINE').IsNull then
      DataInizio:=selT047UnificaPeriodi.FieldByName('DATA_FINE_ASSENZA').AsDateTime + 1
    else
      DataInizio:=selT047UnificaPeriodi.FieldByName('NUOVA_DATA_FINE').AsDateTime + 1;

    // se esiste un periodo successivo consecutivo, unifica i due periodi
    with selT047PeriodoSucc do
    begin
      SetVariable('PROGRESSIVO',Progressivo);
      SetVariable('OPERAZIONE',Operazione);
      SetVariable('DATA_INIZIO',DataInizio);
      Open;
      NuovoPeriodo:=(RecordCount = 0);
      if RecordCount > 0 then
      begin
        // modifica il periodo che si sta considerando
        selT047UnificaPeriodi.Edit;
        if selT047UnificaPeriodi.FieldByName('DATA_PRIMA_COMUNICAZIONE').IsNull then
          selT047UnificaPeriodi.FieldByName('DATA_FINE_ASSENZA').Value:=FieldByName('DATA_FINE_ASSENZA').Value
        else
          selT047UnificaPeriodi.FieldByName('NUOVA_DATA_FINE').Value:=FieldByName('DATA_FINE_ASSENZA').Value;
        selT047UnificaPeriodi.Post;

        // cancella il periodo consecutivo
        Delete;
      end;
      Close;
    end;

    // considera un nuovo periodo nel caso in cui non sia avvenuta una unificazione
    // altrimenti riconsidera il periodo stesso, che è stato "allungato"
    if NuovoPeriodo then
      selT047UnificaPeriodi.Next;
  end; // end while

  selT047UnificaPeriodi.Close;

  try SessioneOracle.Commit; except end;
end;

procedure TA145FComVisiteFiscaliMW.ImpostaCampiSelAnagrafe;
var S: String;
  i:Integer;
begin
  // aggiunge nella selezione i campi di dettaglio richiesti dall'utente
  if (DatiElab.ListaDettaglio.Count > 0) then
  begin
    S:=SelAnagrafe.SQL.Text;
    for i:=0 to DatiElab.ListaDettaglio.Count - 1 do
      if Pos(DatiElab.ListaDettaglio.Strings[i],Copy(S,1,Pos('FROM',S))) <= 0 then
        R180InserisciColonna(S,AliasTabella(DatiElab.ListaDettaglio.Strings[i]) + '.' + DatiElab.ListaDettaglio.Strings[i]);
    SelAnagrafe.CloseAll;
    SelAnagrafe.SQL.Text:=S;
  end;

  // apertura dataset anagrafico
  SelAnagrafe.Open;
end;

procedure TA145FComVisiteFiscaliMW.EstraiDatiDomicilio(Progressivo: Integer; DataLimite: TDateTime);
// estrae i dati del domicilio dalla V430_STORICO, selezionando le colonne contenute in:
// ComuneDom - IndirizzoDom - CapDom - ProvDom (più CodComuneDom)
var
  s: String;
begin
  // pulizia dei dati
  CodComuneDom:='';
  ComuneDom:='';
  IndirizzoDom:='';
  CapDom:='';
  ProvDom:='';

  // estrae i dati dalla V430, gestendo le eventuali eccezioni
  selV430.Close;
  selV430.SetVariable('DATA_LIMITE',DataLimite);
  selV430.SetVariable('PROGRESSIVO',Progressivo);
  try
    selV430.Open;
    if selV430.RecordCount > 0 then
    begin
      //prelevo i dati di domicilio
      // codice comune
      CodComuneDom:=selV430.FieldByName('T430COMUNE_DOM_BASE').AsString;
      // comune
      ComuneDom:=selV430.FieldByName('T430D_COMUNE_DOM_BASE').AsString;
      // indirizzo
      IndirizzoDom:=selV430.FieldByName('T430INDIRIZZO_DOM_BASE').AsString;
      // cap
      CapDom:=selV430.FieldByName('T430CAP_DOM_BASE').AsString;
      // provincia
      ProvDom:=selV430.FieldByName('T430D_PROVINCIA_DOM_BASE').AsString;

      if (Trim(CodComuneDom) = '')
      or (Trim(ComuneDom) = '')
      or (Trim(IndirizzoDom) = '')
      or (Trim(CapDom) = '')
      or (Trim(ProvDom) = '') then
      begin
        //prelevo i dati di residenza
        // codice comune
        CodComuneDom:=selV430.FieldByName('T430COMUNE').AsString;
        // comune
        ComuneDom:=selV430.FieldByName('T430D_COMUNE').AsString;
        // indirizzo
        IndirizzoDom:=selV430.FieldByName('T430INDIRIZZO').AsString;
        // cap
        CapDom:=selV430.FieldByName('T430CAP').AsString;
        // provincia
        ProvDom:=selV430.FieldByName('T430D_PROVINCIA').AsString;
      end;
    end;
  except
    on E: Exception do
    begin
      s:=Format(A000MSG_A145_ERR_FMT_ESTR_DOM,[E.ClassName,E.Message]);
      raise Exception.Create(s);
      Abort;
    end;
  end;
end;

function TA145FComVisiteFiscaliMW.InsRecord(Esenzioni:Boolean): Boolean;
var
  i: integer;
  MedLegDesc, MedLegIndirizzo, MedLegComune,
  MedLegCap, MedLegTel, MedLegEmail: String;
  DataRif: TDateTime;
begin
  Result:=False;

  with selT047 do
  begin
    // se si tratta di prolungamento e questa operazione
    // non è da considerare, esce subito
    if (not datiElab.bProl) and
       (FieldByName('OPERAZIONE').AsString = 'I') and
       (not FieldByName('NUOVA_DATA_FINE').IsNull) then
      Exit;
  end;

  // inizializzazione variabili
  MedLegCod:='';
  CodComuneDom:='';
  ComuneDom:='';
  IndirizzoDom:='';
  CapDom:='';
  ProvDom:='';

  // dati di domicilio per visita fiscale
  // ordine:
  // 1. medicina legale specificata sul periodo
  // 2. comune domicilio specificato sul periodo -> associaz. medicina legale (se non specificata)
  // 3. medicina legale specificata sull'anagrafica
  // 4. comune domicilio dei dati Postel sull'anagrafica

  // 1. medicina legale specificata direttamente nella T047_VISITEFISCALI
  if not selT047.FieldByName('MEDICINA_LEGALE').IsNull then
  begin
    MedLegCod:=selT047.FieldByName('MEDICINA_LEGALE').AsString;
  end;

  // 2. domicilio specificato direttamente nella T047_VISITEFISCALI
  if not selT047.FieldByName('COD_COMUNE').IsNull then
  begin
    //Estraggo comunque il comune per verificare se è uguale a quello registrato sulla malattia
    if selT047.FieldByName('NUOVA_DATA_FINE').IsNull then
      DataRif:=selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime
    else
      DataRif:=selT047.FieldByName('DATA_FINE_ASSENZA').AsDateTime + 1;
    EstraiDatiDomicilio(selT047.FieldByName('PROGRESSIVO').AsInteger,DataRif);
    if (CodComuneDom = selT047.FieldByName('COD_COMUNE').AsString) {and // v. chiamata 63630
       (IndirizzoDom = selT047.FieldByName('INDIRIZZO').AsString)} then
    begin
      // se il comune alternativo (caso di certificati inps) è uguale a quello anagrafico,
      // utilizza il codice di medicina legale indicato in anagrafica (se presente)
      // Nota: vengono comunque mantenuti i dati di domicilio specificati sul certificato

      // determina data di riferimento alla quale leggere i dati
      // (data di inizio assenza / data inizio prolungamento)
      if selT047.FieldByName('NUOVA_DATA_FINE').IsNull then
        DataRif:=selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime
      else
        DataRif:=selT047.FieldByName('DATA_FINE_ASSENZA').AsDateTime + 1;

      // 3. medicina legale specificata sull'anagrafica
      EstraiMedicinaLegale(selT047.FieldByName('PROGRESSIVO').AsInteger,DataRif);
    end;
    //else
    //begin
      CodComuneDom:=selT047.FieldByName('COD_COMUNE').AsString;
      ComuneDom:=selT047.FieldByName('CITTA').AsString;
      IndirizzoDom:=selT047.FieldByName('INDIRIZZO').AsString;
      CapDom:=selT047.FieldByName('CAP').AsString;
      ProvDom:=selT047.FieldByName('PROVINCIA').AsString;
    //end;
  end;

  // 3. dati su scheda anagrafica se non indicato nulla su T047
  if (MedLegCod = '') and (CodComuneDom = '') then
  begin
    // determina data di riferimento alla quale leggere i dati
    // (data di inizio assenza / data inizio prolungamento)
    if selT047.FieldByName('NUOVA_DATA_FINE').IsNull then
      DataRif:=selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime
    else
      DataRif:=selT047.FieldByName('DATA_FINE_ASSENZA').AsDateTime + 1;

    // 3. medicina legale specificata sull'anagrafica
    EstraiMedicinaLegale(selT047.FieldByName('PROGRESSIVO').AsInteger,DataRif);

    // se necessario rilegge i nomi delle colonne che rappresentano il domicilio
    {AnnoNew:=R180Anno(selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime);
    if (not AnnoUnicoNelPeriodo) and (AnnoOld <> AnnoNew) then
    begin
      EstraiColonneDomicilioP500(AnnoNew);
      AnnoOld:=AnnoNew;
    end;}
    // legge i dati del domicilio alla data di riferimento dalla scheda anagrafica
    EstraiDatiDomicilio(selT047.FieldByName('PROGRESSIVO').AsInteger,DataRif);
  end;

  // se è specificato il comune e la medicina legale è nulla cerca l'associazione
  if (CodComuneDom <> '') and (MedLegCod = '') then
  begin
    R180SetVariable(selCercaMedLeg,'COD_COMUNE',CodComuneDom);
    selCercaMedLeg.Open;
    if selCercaMedLeg.RecordCount > 0 then
      MedLegCod:=selCercaMedLeg.FieldByName('MED_LEGALE').AsString;
  end;

  // estrazione dati della medicina legale
  if (MedLegCod <> '') and
     (selMedLegali.SearchRecord('CODICE',MedLegCod,[srFromBeginning])) then
  begin
    MedLegDesc:=selMedLegali.FieldByName('DESCRIZIONE').AsString;
    MedLegIndirizzo:=selMedLegali.FieldByName('INDIRIZZO').AsString;
    MedLegComune:=selMedLegali.FieldByName('CITTA').AsString;
    MedLegCap:=selMedLegali.FieldByName('CAP').AsString;
    MedLegTel:=selMedLegali.FieldByName('TELEFONO').AsString;
    MedLegEmail:=selMedLegali.FieldByName('EMAIL').AsString;
  end
  else
  begin
    MedLegDesc:='';
    MedLegIndirizzo:='';
    MedLegComune:='';
    MedLegCap:='';
    MedLegTel:='';
    MedLegEmail:='';
  end;

  // se è specificata una medicina legale verifica che il codice corrisponda
  if (datiElab.sMedicineLegali <> '') and (datiElab.sMedicineLegali <> MedLegCod) then
    Exit;

  // se esiste una prima comunicazione del periodo nella stessa data non inserisce il record
  if {(not chkPeriodiComunicati.Checked) and}Not datiElab.bProl and
     (DatiElab.DataElaborazione = selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').AsDateTime) then
    Exit;

  // prepara i dati da inserire nel client dataset
  TabellaStampa.Insert;
  TabellaStampa.FieldByName('Progressivo').Value:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  TabellaStampa.FieldByName('Matricola').Value:=SelAnagrafe.FieldByName('MATRICOLA').Value;
  TabellaStampa.FieldByName('Cognome').Value:=SelAnagrafe.FieldByName('COGNOME').Value;
  TabellaStampa.FieldByName('Nome').Value:=SelAnagrafe.FieldByName('NOME').Value;
  TabellaStampa.FieldByName('NomeCognome').Value:=TabellaStampa.FieldByName('Cognome').AsString + ' ' + TabellaStampa.FieldByName('Nome').AsString;
  TabellaStampa.FieldByName('TipoEvento').Value:=selT047.FieldByName('TIPO_EVENTO').Value;
  TabellaStampa.FieldByName('Operazione').Value:=selT047.FieldByName('OPERAZIONE').Value;
  TabellaStampa.FieldByName('DataInizioAssenza').value:=selT047.FieldByName('DATA_INIZIO_ASSENZA').value;
  TabellaStampa.FieldByName('DataFineAssenza').value:=selT047.FieldByName('DATA_FINE_ASSENZA').value;
  TabellaStampa.FieldByName('Prognosi').Value:=selT047.FieldByName('PROGNOSI').Value;
  TabellaStampa.FieldByName('PrognosiPrima').Value:=selT047.FieldByName('PROGNOSI_PRIMA').Value;
  TabellaStampa.FieldByName('PrognosiProl').Value:=selT047.FieldByName('PROGNOSI_PROL').Value;
  TabellaStampa.FieldByName('NuovaDataFine').value:=selT047.FieldByName('NUOVA_DATA_FINE').value;
  TabellaStampa.FieldByName('DataRegistrazione').value:=selT047.FieldByName('DATA_REGISTRAZIONE').value; // ANCHE ORE - MINUTI
  TabellaStampa.FieldByName('DataRegisProlungamento').value:=selT047.FieldByName('DATA_REGIS_PROLUNGAMENTO').value; // ANCHE ORE - MINUTI
  TabellaStampa.FieldByName('DataPrimaComunicazione').value:=selT047.FieldByName('DATA_PRIMA_COMUNICAZIONE').value;
  TabellaStampa.FieldByName('DataComunProlungamento').value:=selT047.FieldByName('DATA_COMUN_PROLUNGAMENTO').value;
  TabellaStampa.FieldByName('Telefono').Value:=selT047.FieldByName('TELEFONO').Value;
  TabellaStampa.FieldByName('Operatore').Value:=selT047.FieldByName('OPERATORE').Value;
  if DatiElab.bEsenzioneAutomatica then
  begin
    if (selT047.FieldByName('TIPO_ESENZIONE').IsNull) or ((selT047.FieldByName('TIPO_ESENZIONE').AsString = 'AUTOMATICA') and (selT047.FieldByName('DATA_ESENZIONE').AsDateTime = DatiElab.DataElaborazione)) then
    begin
      if EsenzioneAutomatica then
      begin
        TabellaStampa.FieldByName('TipoEsenzione').Value:='AUTOMATICA';
        TabellaStampa.FieldByName('DataEsenzione').AsDateTime:=datiElab.DataElaborazione;
        TabellaStampa.FieldByName('Operatore').AsString:=Parametri.Operatore;
      end
      else
      begin
        TabellaStampa.FieldByName('TipoEsenzione').Value:='';
        TabellaStampa.FieldByName('DataEsenzione').Value:=null;
        TabellaStampa.FieldByName('Operatore').Value:='';
      end;
    end
    else
    begin
      TabellaStampa.FieldByName('TipoEsenzione').Value:=selT047.FieldByName('TIPO_ESENZIONE').Value;
      if not selT047.FieldByName('DATA_ESENZIONE').IsNull then
        TabellaStampa.FieldByName('DataEsenzione').AsDateTime:=selT047.FieldByName('DATA_ESENZIONE').AsDateTime
      else
        TabellaStampa.FieldByName('DataEsenzione').Value:=null;
    end;
  end
  else
  begin
    if selT047.FieldByName('TIPO_ESENZIONE').IsNull then
    begin
      TabellaStampa.FieldByName('TipoEsenzione').Value:='';
      TabellaStampa.FieldByName('DataEsenzione').Value:=null;
      TabellaStampa.FieldByName('Operatore').Value:='';
    end
    else
    begin
      TabellaStampa.FieldByName('TipoEsenzione').Value:=selT047.FieldByName('TIPO_ESENZIONE').Value;
      if not selT047.FieldByName('DATA_ESENZIONE').IsNull then
        TabellaStampa.FieldByName('DataEsenzione').AsDateTime:=selT047.FieldByName('DATA_ESENZIONE').AsDateTime
      else
        TabellaStampa.FieldByName('DataEsenzione').Value:=null;
    end;
  end;
  TabellaStampa.FieldByName('Note').Value:=selT047.FieldByName('NOTE').Value;
  // giorni ed eventi di assenza
  TabellaStampa.FieldByName('NumAssenze').Value:=EventiAssenza;
  TabellaStampa.FieldByName('GiorniAssenza').Value:=GiorniAssenza;
  // dati di domicilio
  TabellaStampa.FieldByName('Comune').AsString:=ComuneDom;
  TabellaStampa.FieldByName('Indirizzo').AsString:=IndirizzoDom;
  TabellaStampa.FieldByName('Cap').AsString:=CapDom;
  TabellaStampa.FieldByName('Provincia').AsString:=ProvDom;
  TabellaStampa.FieldByName('C_Domicilio').AsString:=ConcatenaDatiDomicilio;
  // medicina legale
  TabellaStampa.FieldByName('MedLegCod').AsString:=MedLegCod;
  TabellaStampa.FieldByName('MedLegDesc').AsString:=MedLegDesc;
  TabellaStampa.FieldByName('MedLegIndirizzo').AsString:=MedLegIndirizzo;
  TabellaStampa.FieldByName('MedLegComune').AsString:=MedLegComune;
  TabellaStampa.FieldByName('MedLegCap').AsString:=MedLegCap;
  TabellaStampa.FieldByName('MedLegTel').AsString:=MedLegTel;
  TabellaStampa.FieldByName('MedLegEmail').AsString:=MedLegEmail;
  // dati di dettaglio selezionati dall'utente
  for i:=0 to DatiElab.ListaDettaglio.Count - 1 do
    TabellaStampa.FieldByName('A_' + DatiElab.ListaDettaglio.Strings[i]).Value:=
      Copy(SelAnagrafe.FieldByName(DatiElab.ListaDettaglio.Strings[i]).AsString,1,100);
  //Registro su tabella stampa se non gestisco esenzione automatica
  if not DatiElab.bEsenzioneAutomatica then
  begin
    TabellaStampa.Post;
    Result:=True;
  end
  else
  begin
    //Solo se sto gestendo le esenzioni registro su tabella stampa e su DB T047
    if Esenzioni then
    begin
      TabellaStampa.Post;
      Result:=True;
      //Aggiorno T047 effettiva....
      updT047.SetVariable('PROG',TabellaStampa.FieldByName('PROGRESSIVO').AsInteger);
      updT047.SetVariable('INIZIO',TabellaStampa.FieldByName('DATAINIZIOASSENZA').Value);
      updT047.SetVariable('OPER',TabellaStampa.FieldByName('OPERAZIONE').AsString);
      updT047.SetVariable('TIPO',TabellaStampa.FieldByName('TIPOESENZIONE').AsString);
      updT047.SetVariable('OPERATORE',TabellaStampa.FieldByName('OPERATORE').AsString);
      updT047.SetVariable('DATA',TabellaStampa.FieldByName('DATAESENZIONE').Value);
      updT047.Execute;
      SessioneOracle.Commit;
    end
    else
    begin
      if not EsenzioneAutomatica then
      //Registro su tabella stampa se non è esenzione AUTOMATICA
      begin
        TabellaStampa.Post;
        Result:=True;
      end
      else
        TabellaStampa.Cancel;
    end;
  end;
end;

procedure TA145FComVisiteFiscaliMW.EstraiMedicinaLegale(Progressivo: Integer; DataLimite: TDateTime);
// estrae i dati della medicina legale dalla V430_STORICO
begin
  MedLegCod:='';
  selV430MedLeg.Close;
  selV430MedLeg.SetVariable('DATA_LIMITE',DataLimite);
  selV430MedLeg.SetVariable('PROGRESSIVO',Progressivo);
  try
    selV430MedLeg.Open;
    if selV430MedLeg.RecordCount > 0 then
      MedLegCod:=selV430MedLeg.FieldByName('T430MEDICINA_LEGALE').AsString;
  except
    // nessuna operazione
  end;
end;

function TA145FComVisiteFiscaliMW.ConcatenaDatiDomicilio: String;
// concatena i dati di domicilio presenti nel client dataset:
// Indirizzo, Comune, Cap, Provincia e Telefono
var
  Domicilio,Indirizzo,Comune,Cap,Provincia,Telefono: String;
begin
  with TabellaStampa do
  begin
    Indirizzo:=Trim(FieldByName('Indirizzo').AsString);
    Comune:=FieldByName('Comune').AsString;
    Cap:=FieldByName('Cap').AsString;
    Provincia:=FieldByName('Provincia').AsString;
    Telefono:=FieldByName('Telefono').AsString;
  end;

  // concatena cap
  Comune:=IfThen(Cap = '',Comune,Cap + ' ' + Comune);

  // concatena provincia
  Comune:=Comune + IfThen(Provincia = '','',' (' + Provincia + ')');

  Comune:=Trim(Comune);

  // concatena indirizzo e comune
  if (Indirizzo <> '') and (Comune <> '') then
    Domicilio:=Indirizzo + ' - ' + Comune
  else if Indirizzo <> '' then
    Domicilio:=Indirizzo
  else
    Domicilio:=Comune;

  // concatena telefono (solo per stampa elenco)
  if datiElab.iTipoStampa = 0 then
    if Telefono <> '' then
      Domicilio:=Domicilio + IfThen(Domicilio = '','',' - ') + 'Tel. ' + Telefono;

  Result:=Domicilio;
end;

procedure TA145FComVisiteFiscaliMW.GetEventiMalattia;
// ciclo sulla T040 per formare i periodi di assenza dell'ultimo anno
var
  DataInizioAssenza,
  DataInizioAssenzaOld: TDateTime;
begin
  // apre dataset delle assenze (da data elaborazione indietro di 12 mesi)
  selT040.Close;
  selT040.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  //selT040.SetVariable('DATA_LIMITE',selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime);
  selT040.Open;

  // inizializzazione variabili
  DataInizioAssenzaOld:=EncodeDate(1799,1,1);
  GiorniAssenza:=0;
  EventiAssenza:=0;
  GiorniEsenzione:=0;
  EventiEsenzione:=0;
  // ciclo sulle assenze per estrarre i periodi continuativi
  selT040.First;
  while not selT040.Eof do
  begin
    // estrae la data di inizio assenza in base alla data e alla causale di un giorno
    prcGetInizioAssenza.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    prcGetInizioAssenza.SetVariable('DATA',selT040.FieldByName('DATA').AsDateTime);
    prcGetInizioAssenza.SetVariable('CAUSALE',selT040.FieldByName('CAUSALE').AsString);
    prcGetInizioAssenza.Execute;
    DataInizioAssenza:=prcGetInizioAssenza.GetVariable('DATA_INIZIO_ASSENZA');

    // aggiorna gli eventi e i giorni di assenza
    GiorniAssenza:=GiorniAssenza + 1;
    if DataInizioAssenza <> DataInizioAssenzaOld then
    begin
      EventiAssenza:=EventiAssenza + 1;
      if (GiorniEsenzione > 0) and (GiorniEsenzione <= StrToIntDef(DatiElab.sMaxGiorniContinuativi,0)) then
        EventiEsenzione:=EventiEsenzione + 1;
      GiorniEsenzione:=0;
    end;
    if DataInizioAssenza >= R180AddMesi(DataLimiteEventiAssenza,-StrToIntDef(DatiElab.sMesiVerificaEventi,0)) then
      GiorniEsenzione:=GiorniEsenzione + 1;
    DataInizioAssenzaOld:=DataInizioAssenza;
    selT040.Next;
  end;
  if DatiElab.bEsenzioneAutomatica then
  begin
    if EventiEsenzione >= StrToIntDef(DatiElab.sNumeroMinimoEventi,0) then
      EsenzioneAutomatica:=False
    else
      EsenzioneAutomatica:=True;
  end
  else
    EsenzioneAutomatica:=False;

  // se la data di inizio assenza è successiva o uguale a quella di elaborazione,
  // aggiunge l'evento stesso al conteggo di giorni ed eventi dell'ultimo anno
  // (fino al limite della data di elaborazione / data inizio periodo)
  {
  if (selT047.FieldByName('OPERAZIONE').AsString = 'I') and
     (selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime >= DataLimiteEventiAssenza) then
  begin
    EventiAssenza:=EventiAssenza + 1;
    //GiorniAssenza:=GiorniAssenza + selT047.FieldByName('PROGNOSI').AsInteger;
    GiorniUltimoEvento:=Trunc(DataLimiteEventiAssenza - selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime + 1);
    GiorniAssenza:=GiorniAssenza + Max(0,GiorniUltimoEvento);
  end;
  }
end;

procedure TA145FComVisiteFiscaliMW.InizioElaborazione(Esenzioni:Boolean);
begin
  // operazioni preliminari sul dataset dei giustificativi di assenza
  DataLimiteEventiAssenza:=IfThen(DatiElab.bPeriodiComunicati,DatiElab.DataDa,DatiElab.DataElaborazione);
  selT040.ClearVariables;
  selT040.SetVariable('DATA_LIMITE',DataLimiteEventiAssenza);
  selT040.SetVariable('LISTACAUSALI','''' + StringReplace(DatiElab.ListaCausali.CommaText,',',''',''',[rfReplaceAll]) + '''');

  // operazioni preliminari sul dataset delle visite fiscali
  selT047.ClearVariables;
  selT047.SetVariable('OPERAZIONE',DatiElab.Operazione);
  selT047.SetVariable('ESENZIONI',IfThen(Esenzioni,'S','N'));
  if (DatiElab.Operazione = 'I') and (not DatiElab.bProl) then
    selT047.SetVariable('PROLUNGAMENTO','NUOVA_DATA_FINE is null and'); // per escludere i periodi prolungati
  if DatiElab.bEsenzioneAutomatica then
  begin
    if not Esenzioni then
      selT047.SetVariable('PROLUNGAMENTO','(TIPO_ESENZIONE IS NULL OR TIPO_ESENZIONE = ''AUTOMATICA'') and'); // per escludere i periodi esentati
  end
  else
  begin
    if not Esenzioni then
      selT047.SetVariable('PROLUNGAMENTO','TIPO_ESENZIONE IS NULL and'); // per escludere i periodi esentati
  end;
  {if chkSoloCont.Checked then
    selT047.SetVariable('SOLO_CONT','S')
  else
    selT047.SetVariable('SOLO_CONT','N');}
  selT047.SetVariable('DATA_ELABORAZIONE',DatiElab.DataElaborazione);
  if DatiElab.bFiltroDataComun then
    selT047.SetVariable('INCLUDI_COMUNICATI','C')
  else if DatiElab.bPeriodiComunicati then
    selT047.SetVariable('INCLUDI_COMUNICATI','S')
  else
    selT047.SetVariable('INCLUDI_COMUNICATI','N');
  //selT047.SetVariable('INCLUDI_COMUNICATI',IfThen(chkPeriodiComunicati.Checked,'S','N'));
  selT047.SetVariable('DATADA',DatiElab.DataDa);
  selT047.SetVariable('DATAA',IfThen(Not Esenzioni,DatiElab.DataA,EncodeDate(3999,12,31)));
end;

procedure TA145FComVisiteFiscaliMW.ElaboraElemento(Esenzioni:Boolean);
var
  PrintRecord: Boolean;
  Inserito: Boolean;
begin
  Inserito:=False;
  // ciclo sui periodi rilevanti per le visite fiscali
  selT047.Close;
  selT047.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selT047.Open;
  selT047.First;
  while not selT047.Eof do
  begin
    // estrae num. eventi e giorni di assenza nell'ultimo anno
    GetEventiMalattia;

    PrintRecord:=True;
    if DatiElab.bSoloCont and (Not DatiElab.bFiltroDataComun) then
    begin
      {Se "Solo tipo certificato continuazione è flaggato" controllo se su T048 è presente un
      certifciato di continuazione corrispondente, se si, stampo il record altrimenti no, ma
      lascio comunque aggiornabile la data di prima comunicazione}
      with TOracleQuery.Create(Self) do
        try
          Session:=SessioneOracle;
          SQL.Add('select ''X'' ESISTE_REC');
          SQL.Add('  from T048_ATTESTATIINPS T048');
          SQL.Add(' where :PROGRESSIVO = T048.PROGRESSIVO');
          SQL.Add('   and :DATA_INIZIO_ASSENZA = T048.DATA_INIZIO_MAL');
          SQL.Add('   and T048.TIPO_CERTIFICATO = ''C''');
          DeclareVariable('PROGRESSIVO',otInteger);
          DeclareVariable('DATA_INIZIO_ASSENZA',otDate);
          SetVariable('PROGRESSIVO',selT047.FieldByName('PROGRESSIVO').AsInteger);
          SetVariable('DATA_INIZIO_ASSENZA',selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime);
          Execute;
          if selT047.FieldByName('NUOVA_DATA_FINE').IsNull or (RowCount <= 0) then
          begin
            PrintRecord:=False;
            Inserito:=True;
          end;
        finally
          Free;
        end;
    end;
    // inserisce un record nel client dataset
    if PrintRecord then
      Inserito:=InsRecord(Esenzioni);

    // aggiornamento data comunicazione (solo per record riportati in stampa)
    if Inserito and DatiElab.bAggiorna then
      AggiornaDataComunicazione;

    selT047.Next;
  end;
end;

procedure TA145FComVisiteFiscaliMW.OttimizzaPeriodi;
begin
  CompensaPeriodi;
  UnificaPeriodi;
  AggiornaEsenzioniCanc;
end;

procedure TA145FComVisiteFiscaliMW.AggiornaEsenzioniCanc;
// aggiorno tipo esenzione sulle cancellazioni
begin
  selT047Canc.Close;
  selT047Canc.Open;
  //ciclo per ogni cancellazione non comunicata con esenzione nulla
  while not selT047Canc.Eof do
  begin
    selT047Esen.Close;
    selT047Esen.SetVariable('PROG',selT047Canc.FieldByName('PROGRESSIVO').AsInteger);
    selT047Esen.SetVariable('INIZIO',selT047Canc.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime);
    selT047Esen.SetVariable('FINE',selT047Canc.FieldByName('DATA_FINE_ASSENZA').AsDateTime);
    selT047Esen.Open;
    //cerco un ins.esentato che contenga la cancellazione
    if selT047Esen.RecordCount > 0 then
    begin
      selT047Canc.Edit;
      selT047Canc.FieldByName('TIPO_ESENZIONE').AsString:=selT047Esen.FieldByName('TIPO_ESENZIONE').AsString;
      selT047Canc.Post;
      SessioneOracle.Commit;
    end;
    selT047Canc.Next;
  end;
end;

function TA145FComVisiteFiscaliMW.MessaggioNessunPeriodo(PeriodiComunicati: Boolean): String;
begin
  Result:=IfThen(PeriodiComunicati, A000MSG_A145_ERR_NO_ASSENZA, A000MSG_A145_ERR_NO_PERIODO_ASSENZA);
end;

function TA145FComVisiteFiscaliMW.getGiornoNonLavEsenzioni: Boolean;
var dFine,dCorr:TDateTime;
begin
  Result:=False;
  if (Trim(TabellaEsenzioni.FieldByName('TIPOESENZIONE').AsString) <> '') and
     (TabellaEsenzioni.FieldByName('OPERAZIONE').AsString = 'I') then
  begin
    //Controllo calendario
    dCorr:=TabellaEsenzioni.FieldByName('DATAINIZIOASSENZA').AsDateTime - 1;
    if TabellaEsenzioni.FieldByName('NUOVADATAFINE').IsNull then
      dFine:=TabellaEsenzioni.FieldByName('DATAFINEASSENZA').AsDateTime
    else
      dFine:=TabellaEsenzioni.FieldByName('NUOVADATAFINE').AsDateTime;
    dFine:=dFine+1;
    while dCorr <= dFine do
    begin
      //Recupero il calendario del dipendente
      GetCalendario.SetVariable('PROG',TabellaEsenzioni.FieldByName('PROGRESSIVO').AsInteger);
      GetCalendario.SetVariable('DATA',dCorr);
      GetCalendario.Execute;
      //Se il giorno fosse lavorativo ma è festivo ed è infrasettimanale (da lunedì a sabato)...
      if VarToStr(GetCalendario.GetVariable('LAV')) = 'N' then
      begin
        Result:=True;
        Break;
      end;
      dCorr:=dCorr + 1;
    end;
  end;
end;

procedure TA145FComVisiteFiscaliMW.CreaTabellaEsenzioni;
begin
  //Creazione tabella
  TabellaEsenzioni.Filtered:=False;
  TabellaEsenzioni.Close;
  with TabellaEsenzioni.FieldDefs do
  begin
    Clear;
    Add('Progressivo',ftInteger,0,False);
    Add('Matricola',ftString,10,False);
    Add('Cognome',ftString,30,False);
    Add('Nome',ftString,30,False);
    Add('Operazione',ftString,1,False);
    Add('DataInizioAssenza',ftDate,0,False);
    Add('DataFineAssenza',ftDate,0,False);
    Add('NuovaDataFine',ftDate,0,False);
    Add('Comune',ftString,40,False);
    Add('TipoEsenzione',ftString,50,False);
    Add('DataEsenzione',ftDateTime,0,False);
    Add('Operatore',ftString,20,False);
  end;
  TabellaEsenzioni.IndexDefs.Clear;
  TabellaEsenzioni.IndexDefs.Add('Primario','Cognome;Nome;Progressivo;DataInizioAssenza;Operazione',[ixUnique]);
  TabellaEsenzioni.IndexName:='Primario';
  TabellaEsenzioni.CreateDataSet;
  TabellaEsenzioni.LogChanges:=False;
  //Caricamento tabella
  TabellaEsenzioni.BeforePost:=nil;
  TabellaEsenzioni.AfterPost:=nil;
  TabellaStampa.First;
  while not TabellaStampa.Eof do
  begin
    TabellaEsenzioni.Insert;
    TabellaEsenzioni.FieldByName('Progressivo').Value:=TabellaStampa.FieldByName('Progressivo').Value;
    TabellaEsenzioni.FieldByName('Matricola').Value:=TabellaStampa.FieldByName('MATRICOLA').Value;
    TabellaEsenzioni.FieldByName('Cognome').Value:=TabellaStampa.FieldByName('COGNOME').Value;
    TabellaEsenzioni.FieldByName('Nome').Value:=TabellaStampa.FieldByName('NOME').Value;
    TabellaEsenzioni.FieldByName('Operazione').Value:=TabellaStampa.FieldByName('Operazione').Value;
    TabellaEsenzioni.FieldByName('DataInizioAssenza').value:=TabellaStampa.FieldByName('DATAINIZIOASSENZA').value;
    TabellaEsenzioni.FieldByName('DataFineAssenza').value:=TabellaStampa.FieldByName('DATAFINEASSENZA').value;
    TabellaEsenzioni.FieldByName('NuovaDataFine').value:=TabellaStampa.FieldByName('NUOVADATAFINE').value;
    TabellaEsenzioni.FieldByName('Comune').value:=TabellaStampa.FieldByName('Comune').value;
    TabellaEsenzioni.FieldByName('TipoEsenzione').Value:=TabellaStampa.FieldByName('TIPOESENZIONE').Value;
    if not TabellaStampa.FieldByName('DATAESENZIONE').IsNull then
      TabellaEsenzioni.FieldByName('DataEsenzione').AsDateTime:=TabellaStampa.FieldByName('DATAESENZIONE').AsDateTime
    else
      TabellaEsenzioni.FieldByName('DataEsenzione').Value:=null;
    TabellaEsenzioni.FieldByName('Operatore').Value:=TabellaStampa.FieldByName('OPERATORE').Value;
    TabellaEsenzioni.Post;
    TabellaStampa.Next;
  end;
  TabellaStampa.First;
  TabellaEsenzioni.BeforePost:=TabellaEsenzioniBeforePost;
  TabellaEsenzioni.AfterPost:=TabellaEsenzioniAfterPost;
end;

function TA145FComVisiteFiscaliMW.StoriaDipendente(Progressivo: Integer): TArrayStoriaDip;
var
  storiaDip: TStoriaDip;
  i: Integer;
  n: Real;
begin
  selT047Prog.Close;
  selT047Prog.SetVariable('PROG',Progressivo);
  selT047Prog.Open;
  R600DtM.Progressivo:=Progressivo;
  R600DtM.GetPeriodiAssenza(DatiElab.ListaCausali.CommaText);
  if selT047Prog.RecordCount > 0 then
  begin
    selT047Prog.Last;
    R600DtM.cdsPeriodiAssenza.Filter:='DATAINIZIO < ' + FloatToStr(selT047Prog.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime);
    R600DtM.cdsPeriodiAssenza.Filtered:=True;
    selT047Prog.First;
  end
  else
  begin
    R600DtM.cdsPeriodiAssenza.Filter:='';
    R600DtM.cdsPeriodiAssenza.Filtered:=False;
  end;
  SetLength(Result,selT047Prog.RecordCount + R600DtM.cdsPeriodiAssenza.RecordCount);
  i:=0;
  while not selT047Prog.Eof do
  begin
    if selT047Prog.FieldByName('OPERAZIONE').AsString = 'I' then
      storiaDip.Operazione:='Inserimento'
    else
      storiaDip.Operazione:='Cancellazione';

    storiaDip.Inizio:=selT047Prog.FieldByName('DATA_INIZIO_ASSENZA').AsString;
    storiaDip.Fine:=selT047Prog.FieldByName('DATA_FINE_ASSENZA').AsString;
    storiaDip.Giorni:=Format('%3s',[selT047Prog.FieldByName('GIORNI').AsString]);
    storiaDip.TipoEsenzione:=selT047Prog.FieldByName('TIPO_ESENZIONE').AsString;
    if selT047Prog.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime >
       R180AddMesi(DataLimiteEventiAssenza,-StrToIntDef(DatiElab.sMesiVerificaEventi,0)) then
      storiaDip.bottom:=True
    else
      storiaDip.bottom:=False;
    Result[i]:=storiaDip;
    selT047Prog.Next;
    i:=i + 1;
  end;
  R600DtM.cdsPeriodiAssenza.First;
  while not R600DtM.cdsPeriodiAssenza.Eof do
  begin
    storiaDip.Operazione:='';
    storiaDip.Inizio:=R600DtM.cdsPeriodiAssenza.FieldByName('DATAINIZIO').AsString;
    storiaDip.Fine:=R600DtM.cdsPeriodiAssenza.FieldByName('DATAFINE').AsString;
    n:=R600DtM.cdsPeriodiAssenza.FieldByName('DATAFINE').AsDateTime -
       R600DtM.cdsPeriodiAssenza.FieldByName('DATAINIZIO').AsDateTime + 1;
    storiaDip.Giorni:=Format('%3s',[FloatToStr(n)]);
    storiaDip.TipoEsenzione:='Modulo visite fiscali non ancora attivo';
    if R600DtM.cdsPeriodiAssenza.FieldByName('DATAINIZIO').AsDateTime >
       R180AddMesi(DataLimiteEventiAssenza,-StrToIntDef(DatiElab.sMesiVerificaEventi,0)) then
        storiaDip.bottom:=True
    else
      storiaDip.bottom:=False;

    Result[i]:=storiaDip;
    R600DtM.cdsPeriodiAssenza.Next;
    i:=i + 1;
  end;
end;

procedure TA145FComVisiteFiscaliMW.DataModuleDestroy(Sender: TObject);
begin
  if DatiElab.ListaDettaglio <> nil then
    FreeAndNil(DatiElab.ListaDettaglio);

  if DatiElab.ListaCausali <> nil then
    FreeAndNil(DatiElab.ListaCausali);

  FreeAndNil(selI010);
  FreeAndNil(R600DtM);
  inherited;
end;

end.
