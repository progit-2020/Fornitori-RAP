unit R003UGeneratoreStampeMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB, C180FunzioniGenerali,
  A000UInterfaccia, A000USessione, Oracle, QRCtrls, Variants,QueryStorico, P999UGenerale, Generics.Collections,
  A000UMessaggi, StrUtils, Math,
  Vcl.StdCtrls, Vcl.CheckLst, Vcl.Controls, Cestino;

type
  TEvDataset = procedure (DataSet: TDataSet) of object;
  
  TCodiciTabCollegate = record
    idSerbatoio: Integer;
    Codice: String;
  end;

  TVariazioniFormato = record
    Dato:String;
    Colonna:String;
    Formati:String;
  end;

  TOpzioniAvanzate = record
    Opzione:String;
  end;

  TLabelDati = record
    X: Integer;
    Y: Integer;
    W: Integer;
    H: Integer;
    Totale: Integer;
    Banda: String;
    Nome: String;
    Capt: String;
  end;

  TTabelleCollegate = record
    M:Byte;                //ID da 1 in avanti
    Esiste:Boolean;        //True se è presente almeno un dato in DatiStampa
    Totalizzato:Boolean;   //True se almeno un dato è totalizzato
    DaTotalizzare:Boolean; //True se richiesto il totale di tutti i dati numerici
    Ordinato:Boolean;      //I dati sono ordinatiin base a NomeKey
    NomeKey:String;        //Nome del campo chiave nella tabella T920_xxx. Se vuoto non viene considerato
    KeyTotale:String;      //Nome del campo chiave nella tabella T920_xxx per i totali. Se vuoto non viene considerato
    Join:String;           //Stringa di Join con la tabelle madre T920
    Progressivo:String;    //Nome del campo indicante il Progressivo
    Data: array [1..2] of String; //Nome del campo indicante la data di riferimento per le stampe con periodi storici
    DettaglioPeriodico:String; //G-M-A: indica la precisione del dato: Giornaliera, Mensile o Annuale
    DatiNecessari:String;  //Elenco dei dati necessari da includere comunque, anche se non esplicitamente richiesti
    DatiDalAl:String;     //Elenco dei campi data selezionabili per effettuare il filtro dal..al
    OQIns:TOracleQuery;
    InsDaSelect:Boolean;   //Se true, l'inserimento dei dati avviene con una Select costruita in OQIns
  end;

  TValore = class
    Key:String;     //Chiave di cumulo
    KeyTot:String;  //Chiave per i totali
    Val:String;     //Valore effettivo
    NumOrd:Integer; //Contatore dei dati significativi
  end;

  TKeyCumulo = record
    Nome:String;
    Totale:Boolean;
  end;

  TOrdinamento = record
    Nome:String;
    Rottura:Boolean;
    Discendente:Boolean;
  end;

  TRiep = record
    N:Word;     //ID dato
    R:Word;     //ID della routine di estrazione del dato
    W:Word;     //Lunghezza di default
    T:Byte;     //0 = totalizzabile; 1 = non totalizzabile
    F:Byte;     //0 = Alfanum; 1 = numerico; 2 = Ore.Minuti; 3 = data; 4 = dati particolari(Riepilogo ore cauaslizzate, Riepilogo ore assenza)
    M:Byte;     //0 = Singolo; n = Molteplice
    X:Byte;     //ID Serbatoio (Consuntivi orari,Indennità/Varie,Riepilogo pres./ass.)
    KC:Byte;     //0 = Non è chiave di cumulo; 1 = Può essere chiave di cumulo
    Fex:String; //S = esiste il formato; N = non esiste il formato
    D:String;   //Descrizione del dato
    Fmt:String; //Formato corrente
    Cont:Byte;  //0 = No contatore; 1 = Si contatore
    Calcolato:Boolean;
    CDCPerc:Boolean; //True se deve essere percentualizzato sul Centro di Costo
    ConvValuta:Boolean; // True se il dato può essere convertito in valuta diversa
    Ripetuto:Boolean;  //Se dato anagrafico che deve essere ripetuto nel dettaglio
  end;

  TSerbatoi = record
    X:Byte;  //ID serbatoio
    N:Word;  //ID di partenza dei dati del sebatoio
    R:Word;  //ID della routine di estrazione del dato (default)
    M:Byte;  //ID della tabella collegata(default)
    Nome:String;
    Tabelle:String;                //Tabelle/Viste da cui prendere l'elenco delle colonne
    lst:TStringList;               //Lista dei dati disponibili
    Multiplo:Boolean;              //Se True il dato è multiplo e permette la definizione della chiave di cumulo
    KeyCumulo:array of TKeyCumulo; //Campi che definiscono il cumulo. Il valore viene registrato nel campo TabelleCollegate.NomeKey
    FiltroTxt:String;              //Filtro impostato dall'utente e registrato sul database
    Filtro:String;                 //Filtro analizzato ed effettivamente usato nelle query
    Esclusivo:Boolean;             //Se True e se il serbatoio è vuoto, non viene selezionato il dipendente anche se ci sono dati in altri serbatoi
    DatoDalAl:String;              //Campo scleto per effettuare il filtro dal..al
    ODS:TOracleDataSet;            //Query relativa alla tabella. Viene letta applicando il filtro relativo
    ODSValido:Boolean;             //In fase di estrazione, indica se ci sono ancora dati validi da leggere
    Applicazione:String;           //RILPRE,STAGIU,MISSIONI
  end;

  TStampaRiep = record
    N:Word;     //Puntatore al vettore Dati
    TC:Integer; //Puntatore al vettore TabelleCollegate
    W:Word;     //Lunghezza di default
    T:Byte;     //0 = totalizzabile; 1 = non totalizzabile
    F:Byte;     //0 = Alfanum; 1 = numerico; 2 = Ore.Minuti; 3 = data
    D:String;   //Nome del dato (Identificatore)
    TP,TG,TSG:Real;
    NumOrdP,NumOrdG:Integer;
    QI,QD,QT,QS:TQRLabel;
    {$IFNDEF IRISWEB}   //tempdario conditional define per far si che vi sia errore in compilazione se usato da web (TLabel)
    Lbl:TLabel;
    {$ENDIF}
    V,VP,VT:TList;
  end;

  TArraySerbatoi = array of TSerbatoi;
  TArrayRiep     = array of TRiep;
  TArrayStampaRiep = array of TStampaRiep;

  TR003FGeneratoreStampeMW = class(TR005FDataModuleMW)
    selCols: TOracleDataSet;
    QCols: TOracleDataSet;
    selT909: TOracleDataSet;
    selT909APPLICAZIONE: TStringField;
    selT909CODICE_STAMPA: TStringField;
    selT909ID_SERBATOIO: TIntegerField;
    selT909D_SERBATOIO: TStringField;
    selT909NOME: TStringField;
    selT909TIPO: TStringField;
    selT909ESPRESSIONE: TStringField;
    selDatoCalcolatoUsato: TOracleQuery;
    selT002: TOracleDataSet;
    dsrT002: TDataSource;
    Ins920: TOracleQuery;
    DatiAnagrafici: TOracleDataSet;
    selCDCPerc: TOracleDataSet;
    selP270: TOracleDataSet;
    selaP232: TOracleDataSet;
    Q914: TOracleDataSet;
    Q913: TOracleDataSet;
    Q912: TOracleDataSet;
    Q911: TOracleDataSet;
    Q275: TOracleDataSet;
    Q265: TOracleDataSet;
    Q210: TOracleDataSet;
    Q915: TOracleDataSet;
    Del911: TOracleQuery;
    Del912: TOracleQuery;
    del913: TOracleQuery;
    Del914: TOracleQuery;
    Del915: TOracleQuery;
    Ins911: TOracleQuery;
    Ins912: TOracleQuery;
    Ins913: TOracleQuery;
    Ins915: TOracleQuery;
    Ins914: TOracleQuery;
    OperSql: TOracleQuery;
    selUserSource: TOracleDataSet;
    selUserSourceLines: TOracleDataSet;
    OracleScript: TOracleScript;
    selT910Codice: TOracleDataSet;
    updNomeDatoCalcolato: TOracleQuery;
    generaNomeTab: TOracleDataSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure selT909NewRecord(DataSet: TDataSet);
    procedure selT909CalcFields(DataSet: TDataSet);
    procedure selT909BeforeDelete(DataSet: TDataSet);
    procedure selT909AfterPost(DataSet: TDataSet);
    procedure selT910CodiceFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT002FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    FSelT910_Funzioni: TOracleDataset;
    PeriodoProva:TPeriodoProva;
    procedure ElaboraFiltro(SerbID:Word; var C:Integer);
    function GetP430PercIrpefTassSep(P: Integer; Dal, Al,Data: TDateTime): Real;
    function EsisteOrdinamento(Val: String): Boolean;
    function KeyCumuloPresente(idSerbatoio: Integer; Val: String): Boolean;
  protected
    procedure CaricaSerbatoi; virtual; abstract;
    procedure CaricaTabelleCollegate; virtual; abstract;
  public
    modAreaStampa,modOrdinamento,modFiltro,modDettaglioSerbatoio:Boolean;
    DaData,AData:TDateTime;
    PeriodiStorici,CDCPercentualizzati, EsistonoDatiDaProporzionare: Boolean;
    lstOperatoriSQL:TStringList;
    lstFunzioniSQL:TStringList;
    Serbatoi: TArraySerbatoi;
    Dati:TArrayRiep;
    DatiStampa:TArrayStampaRiep;
    Ordinamento:array of TOrdinamento;
    TabelleCollegate:array of TTabelleCollegate;
    OpzioniAvanzate: array of TOpzioniAvanzate;
    VariazioniFormato:array of TVariazioniFormato;
    function getListFormato: TStringList;
    function getListFormatoGiust: TStringList;
    function getListFormatoTimb: TStringList;
    function getListPresCaus: TStringList;
    function getListAssCaus: TStringList;
    function getListOre: TStringList;
    function getListF0: TStringList;
    function getListF1: TStringList;
    function getListF2: TStringList;
    function getListF3: TStringList;
    function IsDatoGiustificativi(Dato: TRiep): Boolean;
    function IsDatoTimbr(Dato: TRiep): Boolean;
    function IsDatoPresCaus(Dato: TRiep): Boolean;
    function IsDatoAssCaus(Dato: TRiep): Boolean;
    function IsDatoOre(Dato: TRiep): Boolean;
    function IsDatoF0(Dato: TRiep): Boolean;
    function IsDatoF1(Dato: TRiep): Boolean;
    function IsDatoF2(Dato: TRiep): Boolean;
    function IsDatoF3(Dato: TRiep): Boolean;
    function VerificaFormatoGiust(var S: String): String;
    function VerificaFormatoTimbr(S: String): String;
    procedure VerificaFormatoCaus(var S: String);
    procedure CaricaDati(bDatiCalcolati: Boolean);
    procedure CaricaDatiDiStampa(aCompIntestazione: array of String;aCompDettaglio: array of String);
    procedure InizializzaVariabili(Libera: Boolean);
    procedure InserisciT920(Data: TDateTime);
    procedure ElencoDatiCalcolati;
    procedure InizializzaTotali(Tipo: Byte);
    function EsplodiEspressione(IDSerbatoio: Integer; Testo: String): String;
    function GetDato(D: String; Ident: Boolean): Integer;
    procedure RiempiSerbatoio(var Serbatoio: TSerbatoi; CdcTab, CdcCod: String);
    function EsisteDatoStampa(S: String): Integer;
    procedure LetturaChiaviCumulo;
    procedure LetturaFiltriSerbatoi;
    procedure LetturaOrdinamento;
    procedure RimuoviOrdinamentoByIndice(idx: Integer);
    procedure RimuoviKeyCumuloByIndice(idSerbatoio, idx: Integer);
    function AggiungiOrdinamento(val: String): Boolean;
    function LetturaLabelDati: TList<TLabelDati>;
    procedure ResetOrdinamentoeCumulo;
    procedure ResetDati;
    function IdxTabelleCollegateDaSerbatoi(idx: Byte): Integer;
    function getElencoFiltri: TStringList;
    procedure AperturaCodiciSerbatoi;
    function IsCodiceSerbatoioChecked(IdSerbatoio:Integer; Codice: String): Boolean;
    function AggiungiDettaglioSerbatoio(idxSerbatoio: Integer;Val: String): Boolean;
    function getRiepilogoKeyCumulo: TStringList;
    procedure SelT910NewRecord;
    procedure SelT910BeforePost(lstLabelDati: TList<TLabelDati>; lstCodiciTabCollegate: TList<TCodiciTabCollegate>; Impostazioni: String);
    procedure DeleteTabelle(Codice: String);
    procedure CancellaT910;
    procedure DuplicaStampa(SQLStampa: TStringList; CopiaSu: String;lstCodiciTabCollegate: TList<TCodiciTabCollegate>);
    function EseguiDuplicaStampa(StrSQL: TStringList): TStringList;
    function VerificaNomeDuplica(NomeStampa: String): String;
    procedure selT909VerificaNome(Dataset: TOracleDataset);
    procedure selT909CampiCalcolati(DataSet: TDataSet);
    procedure selT909ControlliBeforeDelete(Nome: String);
    procedure selT909ImpostaNewRecord(DataSet: TDataSet);
    function getCodiceFunzione(Funzione: String): TStringList;
    procedure setFiltroInutilizzati(DataSet: TOracleDataset; attivo: Boolean);
    function ImportaStampa(NomeFileStampa: String): TStringList;
    function CreaNomeTabella(InNome: String; DaData, AData: TDateTime): String;
    function SQLInterrogazioniServizio(DaData, AData: TDateTime): String;
    property SelT910_Funzioni: TOracleDataset read FSelT910_Funzioni write FSelT910_Funzioni;
  end;

implementation
uses R003USerbatoi;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TR003FGeneratoreStampeMW }

procedure TR003FGeneratoreStampeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  PeriodiStorici:=False;
  lstOperatoriSQL:=TStringList.Create;
  lstFunzioniSQL:=TStringList.Create;
  PeriodoProva:=TPeriodoProva.Create(nil);
  PeriodoProva.Session:=SessioneOracle;

  lstOperatoriSQL.CommaText:='OR,AND,NOT,IN,IS,NULL,BETWEEN,LIKE';
  lstFunzioniSQL.Sorted:=True;
  lstFunzioniSQL.CommaText:=':DAL,:AL,INSTR,SUBSTR,TO_CHAR,TO_DATE,TO_NUMBER,ROUND,TRUNC,LPAD,RPAD,NVL,' +
                  'DECODE,SYSDATE,CHR,ASCII,TRIM,LTRIM,RTRIM,REPLACE,LENGTH,OREMINUTI,MINUTIORE,' +
                  'ADD_MONTHS,LAST_DAY,GREATEST,LEAST,MONTHS_BETWEEN,SIGN,MOD';//,SELECT,FROM,WHERE,MAX,MIN,DUAL

  selDatoCalcolatoUsato.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  selT909.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  selT909.Open;

  selT002.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  selT002.Open;
  Q275.Open;
  Q265.Open;
  //procedure abstract virtual. viene richiamata su istanza corrente (A077MW o P077MW)
  CaricaSerbatoi;
  CaricaTabelleCollegate;

  with selUserSource do
  begin
    Open;
    while not Eof do
    begin
      if lstFunzioniSQL.IndexOf(FieldByName('NAME').AsString) = -1 then
        lstFunzioniSQL.Add(FieldByName('NAME').AsString);
      Next;
    end;
    Close;
  end;
  selT910Codice.SetVariable('APPLICAZIONE',Parametri.Applicazione);
end;

function TR003FGeneratoreStampeMW.getListFormato:TStringList;
var
  i: Integer;
begin
  Result:=TStringList.Create;
  for i:=low(DatiStampa) to High(DatiStampa) do
    Result.Add(DatiStampa[i].D);
  Result.Sort;
  Result.Insert(0,'PROGRESSIVO IN :T920');
end;

function TR003FGeneratoreStampeMW.getListFormatoGiust:TStringList;
begin
  Result:=TStringList.Create;
  Result.Add('C');
  Result.Add('D20');
end;

function TR003FGeneratoreStampeMW.getListFormatoTimb:TStringList;
begin
  Result:=TStringList.Create;
  Result.Add('T');
  Result.Add('T-CC');
  Result.Add('T-RR');
  Result.Add('TS');
  Result.Add('T-CCRR');
end;

function TR003FGeneratoreStampeMW.getListPresCaus:TStringList;
begin
  Result:=TStringList.Create;
  Result.Add('*');
  Q275.First;
  while not Q275.Eof do
  begin
    Result.Add(Q275.FieldByName('CODICE').AsString);
    Q275.Next;
  end;
end;

function TR003FGeneratoreStampeMW.getListAssCaus:TStringList;
begin
  Result:=TStringList.Create;
  Result.Add('*');
  Q265.First;
  while not Q265.Eof do
  begin
    Result.Add(Q265.FieldByName('CODICE').AsString);
    Q265.Next;
  end;
end;

function TR003FGeneratoreStampeMW.getListOre:TStringList;
begin
  Result:=TStringList.Create;
  Q210.Open;
  while not Q210.Eof do
  begin
    Result.Add(Trim(Q210.FieldByName('FASCIA').AsString));
    Q210.Next;
  end;
  Q210.Close;
end;

function TR003FGeneratoreStampeMW.getListF0:TStringList;
begin
  Result:=TStringList.Create;
  Result.Add('Mantenere ritorni a capo');
end;

function TR003FGeneratoreStampeMW.getListF1:TStringList;
begin
  Result:=TStringList.Create;
  Result.Add('m=S,d=0,0=S');
  Result.Add('m=S,d=0,0=N');
  Result.Add('m=S,d=2,0=S');
  Result.Add('m=S,d=2,0=N');
  Result.Add('m=S,d=2,0=S,sd=.');
  Result.Add('m=S,d=2,0=N,sd=.');
  Result.Add('m=N,d=2,0=S');
  Result.Add('m=N,d=2,0=N');
end;

function TR003FGeneratoreStampeMW.getListF2:TStringList;
begin
  Result:=TStringList.Create;
  Result.Add('0=S');
  Result.Add('0=N');
  Result.Add('F=C');
  Result.Add('F=M');
  Result.Add('S=,');
  Result.Add('S=:');
end;

function TR003FGeneratoreStampeMW.getListF3:TStringList;
begin
  Result:=TStringList.Create;
  Result.Add('DD/MM/YY');
  Result.Add('MM/YYYY');
  Result.Add('MM-YYYY');
  Result.Add('MM YYYY');
  Result.Add('MMM YYYY');
  Result.Add('MM/DD');
  Result.Add('MM-DD');
  Result.Add('MM DD');
  Result.Add('MM-DD DDD');
  Result.Add('MMM DD');
  Result.Add('MMM DD DDD');
  Result.Add('DD DDD');
end;

function TR003FGeneratoreStampeMW.IsDatoGiustificativi(Dato:TRiep):Boolean;
begin
  Result:=UpperCase(Dato.D) = 'GIUSTIFICATIVI';
end;

function TR003FGeneratoreStampeMW.IsDatoTimbr(Dato:TRiep):Boolean;
begin
  Result:=((UpperCase(Dato.D) = 'TIMBRATURE CONTEGGIATE') or
           (UpperCase(Dato.D) = 'TIMBRATURE EFFETTIVE'));
end;

function TR003FGeneratoreStampeMW.IsDatoPresCaus(Dato:TRiep):Boolean;
begin
  Result:=UpperCase(Dato.D) = 'ORE DI PRESENZA CAUSALIZZATE';
end;

function TR003FGeneratoreStampeMW.IsDatoAssCaus(Dato:TRiep):Boolean;
begin
  Result:=((UpperCase(Dato.D) = 'ORE DI ASSENZA CAUSALIZZATE') or
           (UpperCase(Dato.D) = 'ORE DI ASSENZA RESE'));
end;

function TR003FGeneratoreStampeMW.IsDatoOre(Dato:TRiep):Boolean;
begin
  Result:=((Copy(UpperCase(Dato.D),1,8) = 'ORE RESE') and (Length(Dato.D) = 10))  or
          ((Copy(UpperCase(Dato.D),1,15) = 'ORE LIQUIDABILI') and (Length(Dato.D) = 17)) or
          ((Copy(UpperCase(Dato.D),1,13) = 'ORE IND.TURNO') and (Length(Dato.D) = 15)) or
          ((Copy(UpperCase(Dato.D),1,17) = 'PRESENZA:ORE RESE') and (Length(Dato.D) = 19));
end;

function TR003FGeneratoreStampeMW.IsDatoF0(Dato:TRiep):Boolean;
begin
  Result:=(Dato.F = 0);
end;

function TR003FGeneratoreStampeMW.IsDatoF1(Dato:TRiep):Boolean;
begin
  Result:=(Dato.F = 1);
end;

function TR003FGeneratoreStampeMW.IsDatoF2(Dato:TRiep):Boolean;
begin
  Result:=(Dato.F = 2);
end;

function TR003FGeneratoreStampeMW.IsDatoF3(Dato:TRiep):Boolean;
begin
  Result:=((Dato.F = 3) or
           (UpperCase(Dato.D) = 'DATA CONTEGGIO'));
end;

function TR003FGeneratoreStampeMW.VerificaFormatoGiust(var S:String):String;
begin
  Result:='';
  if not(S[1] in ['C','D']) then
    Result:=A000MSG_R003_ERR_FORMATO_GIUST;
  if Trim(Copy(S,2,2)) <> '' then
  try
    StrToInt(Copy(S,2,2));
    S:=S[1] + Copy(S,2,2);
  except
    Result:=A000MSG_R003_ERR_FORMATO_DIM_GIUST;
  end;
end;

function TR003FGeneratoreStampeMW.VerificaFormatoTimbr(S:String):String;
var
  i: Integer;
begin
  Result:='';
  for i:=1 to Length(S) do
    if not(S[i] in ['T','C','R','S',' ','-','_','/','\','|',',','.',':',';','*','+']) then
    begin
      Result:=A000MSG_R003_ERR_FORMATO_TIMBR;
      Exit;
    end;
end;

procedure TR003FGeneratoreStampeMW.VerificaFormatoCaus(var S:String);
begin
  if (Copy(S,1) = '*') and (Copy(S,2) <> '*-') then
    S:='*';
end;

procedure TR003FGeneratoreStampeMW.RiempiSerbatoio(var Serbatoio : TSerbatoi; CdcTab,CdcCod: String);
var j,N, NDati:Integer;
begin
  NDati:=Length(Dati);
  //Lettura dati da DatiRiep
  for j:=0 to High(DatiRiep) do
    if DatiRiep[j].X = Serbatoio.X then
    begin
      NDati:=Length(Dati);
      SetLength(Dati,NDati + 1);
      Dati[NDati]:=DatiRiep[j];
      Serbatoio.lst.Add(DatiRiep[j].D);
      //Alberto 20/12/2011: gestione della lunghezza di codice e descrizione del centro di costo percentualizzato
      if (CdcCod <> '') and (CdcTab <> '') and (CdcTab <> 'T430_STORICO') then
        with selCols do
        begin
          if (UpperCase(Identificatore(Dati[NDati].D)) = 'CDCPERC_CODICE') and SearchRecord('COLUMN_NAME',CdcCod,[srFromBeginning]) then
            Dati[NDati].W:=FieldByName('DATA_LENGTH').AsInteger
          else if (UpperCase(Identificatore(Dati[NDati].D)) = 'CDCPERC_DESCRIZIONE') and SearchRecord('COLUMN_NAME','DESCRIZIONE',[srFromBeginning]) then
            Dati[NDati].W:=FieldByName('DATA_LENGTH').AsInteger;
        end;
      inc(NDati);
    end;
  //Lettura dati da tabelle indicate
  with TStringList.Create do
  try
    CommaText:=Serbatoio.Tabelle;
    N:=Serbatoio.N;
    for j:=0 to Count - 1 do
    with QCols do
    begin
      Close;
      SetVariable('TABLE_NAME',Strings[j]);
      Open;
      while not Eof do
      begin
        //Alberto 04/09/2006: filtro i soli dati anagrafici visibili dalla I010
        if ((Strings[j] = 'T030_ANAGRAFICO') or (Strings[j] = 'V430_STORICO')) and
           (Pos(',' + UpperCase(FieldByName('COLUMN_NAME').AsString) + ',',UpperCase(Parametri.CampiAnagraficiNonVisibili )) <> 0) and
           (FieldByName('COLUMN_NAME').AsString <> 'P430IBAN') then
        begin
          Next;
          Continue;
        end;
        SetLength(Dati,NDati + 1);
        Dati[NDati].D:=FieldByName('COLUMN_NAME').AsString;
        Dati[NDati].N:=N;
        Dati[NDati].R:=Serbatoio.R;
        Dati[NDati].X:=Serbatoio.X;
        Dati[NDati].M:=Serbatoio.M;
        Dati[NDati].T:=0;
        Dati[NDati].KC:=0;
        if FieldByName('DATA_TYPE').AsString = 'NUMBER' then
        begin
          Dati[NDati].F:=1;
          Dati[NDati].W:=8;
        end
        else if FieldByName('DATA_TYPE').AsString = 'DATE' then
        begin
          Dati[NDati].F:=3;
          Dati[NDati].W:=10;
        end
        else if FieldByName('COLUMN_NAME').AsString = 'T430ORARIO' then
        begin
          Dati[NDati].F:=2;
          Dati[NDati].W:=FieldByName('DATA_LENGTH').AsInteger;
        end
        else
        begin
          Dati[NDati].F:=0;
          Dati[NDati].W:=FieldByName('DATA_LENGTH').AsInteger;
        end;
        Serbatoio.lst.Add(FieldByName('COLUMN_NAME').AsString);
        inc(NDati);
        inc(N);
        Next;
      end;
      if Strings[j] = 'T030_ANAGRAFICO' then
      begin
        SetLength(Dati,NDati + 1);
        Dati[NDati].N:=N;
        Dati[NDati].W:=40;
        Dati[NDati].T:=1;
        Dati[NDati].F:=0;
        Dati[NDati].R:=Serbatoio.R;
        Dati[NDati].D:='CITTA';
        Dati[NDati].X:=Serbatoio.X;
        Dati[NDati].KC:=0;
        Serbatoio.lst.Add('CITTA');
        inc(NDati);
        inc(N);
        SetLength(Dati,NDati + 1);
        Dati[NDati].N:=N;
        Dati[NDati].W:=2;
        Dati[NDati].T:=1;
        Dati[NDati].F:=0;
        Dati[NDati].R:=Serbatoio.R;
        Dati[NDati].D:='PROVINCIA';
        Dati[NDati].X:=Serbatoio.X;
        Dati[NDati].KC:=0;
        Serbatoio.lst.Add('PROVINCIA');
        inc(NDati);
        inc(N);
      end;
    end;
  finally
    Free;
  end;
end;

//usata da A077,P077 (e relativi progetti cloud) e WA198
procedure TR003FGeneratoreStampeMW.selT909ControlliBeforeDelete(Nome: String);
begin
  selDatoCalcolatoUsato.SetVariable('NOME',Nome);
  selDatoCalcolatoUsato.Execute;
  if selDatoCalcolatoUsato.FieldAsInteger('COUNT') > 0 then
    raise Exception.Create(A000MSG_R003_ERR_DELETE_USATO);
end;

//usata da A077,P077 (e relativi progetti cloud) e WA198
procedure TR003FGeneratoreStampeMW.selT909ImpostaNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('APPLICAZIONE').AsString:=Parametri.Applicazione;
  DataSet.FieldByName('TIPO').AsString:='0';
end;

procedure TR003FGeneratoreStampeMW.selT909NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT909ImpostaNewRecord(DataSet);
end;


function TR003FGeneratoreStampeMW.GetDato(D:String; Ident:Boolean):Integer;
{Restituisce la posizione del dato D nell'array Dati.
 Viene testato il nome descrittivo oppure l'identificatore a seconda di Ident}
var i:Integer;
    S:String;
begin
  Result:=-1;
  for i:=0 to High(Dati) do
  begin
    if Ident then
      S:=Identificatore(Dati[i].D)
    else
      S:=Dati[i].D;
    if UpperCase(S) = UpperCase(D) then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

function TR003FGeneratoreStampeMW.EsplodiEspressione(IDSerbatoio:Integer; Testo:String):String;
var i,j,P:Integer;
    Apice,IsNum,Valido:Boolean;
    Nome,UN:String;
    function GetNome(var NC:Integer):String;
    //Estrazione nome del dato
    var j:Integer;
    begin
      j:=NC;
      Result:='';
      while (j <= Length(Testo)) and (not(Testo[j] in ['(',')',' ',#0,'.',',','|','+','*','/','-'])) do
      begin
        Result:=Result + Testo[j];
        inc(j);
      end;
      NC:=NC + Length(Result) - 1;
    end;
begin
  Result:='';
  Apice:=False;
  i:=1;
  while i <= Length(Testo) do
  begin
    if Testo[i] in ['(',')',' ',#0,'.',',','|','+','*','/','-'] then
    begin
      inc(i);
      Continue;
    end;
    if Testo[i] = '''' then
    begin
      Apice:=not Apice;
      inc(i);
      Continue;
    end;
    if Apice then
    begin
      inc(i);
      Continue;
    end;
    Nome:=GetNome(i);
    try
      StrToFloat(Nome);
      IsNum:=True;
    except
      IsNum:=False;
    end;
    UN:=UpperCase(Nome);
    //Controllo parole chiave
    if (not IsNum) and (lstFunzioniSQL.IndexOf(UN) = -1) then
    begin
      //Verifico che il dato sia presente tra tutti i dati esistenti
      P:=GetDato(Nome,True);
      if P = -1 then
        raise Exception.Create('Dato sconosciuto: [' + Nome + '] Controllare l''espressione!');
      //Verifico che il dato sia presente tra i dati del serbatoio
      Valido:=False;
      for j:=0 to Serbatoi[IDSerbatoio].lst.Count - 1 do
        if UN = UpperCase(Identificatore(Serbatoi[IDSerbatoio].lst[j])) then
        begin
          Valido:=True;
          Break;
        end;
      if not Valido then
        raise Exception.Create('Dato non esistente nel serbatoio corrente: [' + Nome + '] Controllare l''espressione!');
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + Nome;
    end;
    inc(i);
  end;
end;

//usata da A077,P077 (e relativi progetti cloud) e WA198
procedure TR003FGeneratoreStampeMW.selT002FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',DataSet.FieldByName('NOME').AsString);
end;

procedure TR003FGeneratoreStampeMW.selT909AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TR003FGeneratoreStampeMW.selT909BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  selT909ControlliBeforeDelete(selT909.FieldByName('NOME').AsString);
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TR003FGeneratoreStampeMW.selT909CalcFields(DataSet: TDataSet);
begin
  inherited;
  selT909CampiCalcolati(DataSet);
end;

procedure TR003FGeneratoreStampeMW.selT909CampiCalcolati(DataSet: TDataSet);
var
  i: Integer;
begin
  for i:=0 to High(Serbatoi) do
    if Serbatoi[i].X = DataSet.FieldByName('ID_SERBATOIO').AsInteger then
      DataSet.FieldByName('D_SERBATOIO').AsString:=Serbatoi[i].Nome;
end;

procedure TR003FGeneratoreStampeMW.ElencoDatiCalcolati;
var NDati,i,j,NDC:Integer;
    SerbAbilitato:Boolean;
begin
  //Elimino i dati calcolati letti precedentemente
  NDC:= -1;
  for i:=0 to High(Dati) do
    if Dati[i].Calcolato then
    begin
      NDC:=IfThen(NDC=-1,i,NDC);
      for j:=0 to High(Serbatoi) do
        if Serbatoi[j].lst.IndexOf(Dati[i].D) >= 0 then
          Serbatoi[j].lst.Delete(Serbatoi[j].lst.IndexOf(Dati[i].D));
    end;
  if NDC >= 0 then
    SetLength(Dati,NDC);
  //Lettura dati calcolati
  NDati:=Length(Dati);
  NDC:=9000;
  with selT909 do
  begin
    First;
    while not Eof do
    begin
      if (not FieldByName('CODICE_STAMPA').IsNull) and
         (FieldByName('CODICE_STAMPA').AsString <>  FSelT910_Funzioni.FieldByName('CODICE').AsString) then
      begin
        Next;
        Continue;
      end;
      SetLength(Dati,NDati + 1);
      SerbAbilitato:=True;
      for i:=0 to High(Serbatoi) do
        if Serbatoi[i].X = FieldByName('ID_SERBATOIO').AsInteger then
        begin
          if Pos(Parametri.Applicazione,Serbatoi[i].Applicazione) > 0 then
            Serbatoi[i].lst.Add(FieldByName('NOME').AsString)
          else
            SerbAbilitato:=False;
          Break;
        end;
      if SerbAbilitato and (i <= High(Serbatoi)) then
      begin
        Dati[NDati].N:=NDC;
        Dati[NDati].T:=0;
        Dati[NDati].Calcolato:=True;
        Dati[NDati].D:=FieldByName('NOME').AsString;
        Dati[NDati].F:=FieldByName('TIPO').AsInteger;
        Dati[NDati].Fmt:='';
        Dati[NDati].R:=Serbatoi[i].R;
        Dati[NDati].X:=Serbatoi[i].X;
        Dati[NDati].M:=Serbatoi[i].M;
        Dati[NDati].KC:=0;
        Dati[NDati].Cont:=0;
        Dati[NDati].CDCPerc:=False;
        if Dati[NDati].F in [0,1,2,3] then
          Dati[NDati].Fex:='S';
        Dati[NDati].ConvValuta:=False;
        Dati[NDati].Ripetuto:=False;
        inc(NDati);
        inc(NDC);
      end;
      Next;
    end;
  end;
end;

procedure TR003FGeneratoreStampeMW.CaricaDati(bDatiCalcolati: Boolean);
var i,NDati:Integer;
    CdcTab,CdcCod,CdcSt:String;
begin
  //Gestione centri di costo percentualizzati
  A000GetTabella(Parametri.CampiRiferimento.C13_CDCPercentualizzati,CdcTab,CdcCod,CdcSt);
  if (CdcCod <> '') and (CdcTab <> '') and (CdcTab <> 'T430_STORICO') then
  begin
    selCols.SetVariable('TABELLA',CdcTab);
    selCols.Close;
    selCols.Open;
  end;
  //Lettura serbatoi dei dati disponibili
  NDati:=0;
  for i:=0 to High(Serbatoi) do
  begin
    Serbatoi[i].lst:=TStringList.Create;
    if Pos(Parametri.Applicazione,Serbatoi[i].Applicazione) > 0 then
      RiempiSerbatoio(Serbatoi[i],CdcTab,CdcCod);
  end;
  //I dati letti fino ad ora sono nativi
  for i:=0 to High(Dati) do
    Dati[i].Calcolato:=False;
  //per IrisCloud il progetto WA198 non deve caricare i dati calcolati
  //perchè in quel caso fselT910_funzioni e nil, perdipiù i dati calcolati non sono considerati
  if bDatiCalcolati then   //Lettura dati calcolati
    ElencoDatiCalcolati;
  //Abilitazioni alla totalizzazioni e al formato
  for i:=0 to High(Dati) do
  begin
    (*if (Dati[i].M < 0) and not(Dati[i].F in [1,2]) then
      Dati[i].T:=1
    else*)
      Dati[i].T:=0;
    if Dati[i].F in [1,2,3] then
      Dati[i].Fex:='S';
  end;

end;

procedure TR003FGeneratoreStampeMW.InizializzaTotali(Tipo:Byte);
{Liberazione delle liste dei totali parziali e totali}
var i,j:Integer;
begin
  for i:=0 to High(DatiStampa) do
    case Tipo of
      0:
      begin
        DatiStampa[i].TP:=0;
        DatiStampa[i].NumOrdP:=0;
        if DatiStampa[i].VP <> nil then
        begin
          for j:=DatiStampa[i].VP.Count - 1 downto 0 do
            TValore(DatiStampa[i].VP[j]).Free;
          DatiStampa[i].VP.Clear;
          DatiStampa[i].VP.Free;
          DatiStampa[i].VP:=nil;
        end;
      end;
      1:
      begin
        DatiStampa[i].TG:=0;
        DatiStampa[i].NumOrdG:=0;
        DatiStampa[i].TSG:=0;
        if DatiStampa[i].VT <> nil then
        begin
          for j:=DatiStampa[i].VT.Count - 1 downto 0 do
            TValore(DatiStampa[i].VT[j]).Free;
          DatiStampa[i].VT.Clear;
          DatiStampa[i].VT.Free;
          DatiStampa[i].VT:=nil;
        end;
      end;
    end;
end;

function TR003FGeneratoreStampeMW.EsisteDatoStampa(S:String):Integer;
{Restituisce la posizione del dato in DatiStampa
 Il dato specificato deve essere nel formato 'Identificatore'}
var i:Integer;
begin
  Result:=-1;
  for i:=0 to High(DatiStampa) do
    if UpperCase(DatiStampa[i].D) = UpperCase(S) then
    begin
      Result:=i;
      Break;
    end;
end;

procedure TR003FGeneratoreStampeMW.CaricaDatiDiStampa(aCompIntestazione: Array of String;aCompDettaglio: Array of String);
{Caricamento in DatiStampa di tutti i dati selezionati}
var i,j,P,C:Integer;
    S:String;
begin
  InizializzaTotali(0);
  InizializzaTotali(1);
  SetLength(DatiStampa,4);
  //Il cognome lo includo sempre
  P:=GetDato('COGNOME',False);
  DatiStampa[0].N:=P;
  DatiStampa[0].D:='COGNOME';
  DatiStampa[0].W:=Dati[P].W;
  DatiStampa[0].F:=Dati[P].F;
  //Il progressivo lo includo sempre
  P:=GetDato('PROGRESSIVO',False);
  DatiStampa[1].N:=P;
  DatiStampa[1].D:='PROGRESSIVO';
  DatiStampa[1].W:=Dati[P].W;
  DatiStampa[1].F:=Dati[P].F;
  //La data di decorrenza la includo sempre
  P:=GetDato('T430DATADECORRENZA',False);
  DatiStampa[2].N:=P;
  DatiStampa[2].D:='T430DATADECORRENZA';
  DatiStampa[2].W:=Dati[P].W;
  DatiStampa[2].F:=Dati[P].F;
  //La data di fine periodo la includo sempre
  P:=GetDato('T430DATAFINE',False);
  DatiStampa[3].N:=P;
  DatiStampa[3].D:='T430DATAFINE';
  DatiStampa[3].W:=Dati[P].W;
  DatiStampa[3].F:=Dati[P].F;
  C:=4;
  //Lettura dati di ordinamento
  for i:=0 to High(Ordinamento) do
  begin
    S:=Identificatore(Ordinamento[i].Nome);
    if EsisteDatoStampa(S) = -1 then
    begin
      SetLength(DatiStampa,C + 1);
      P:=GetDato(Ordinamento[i].Nome,False);
      if P = -1 then
        raise Exception.Create('Attenzione: [' + S + '] Dato non esistente!');
      DatiStampa[C].N:=P;
      DatiStampa[C].D:=S;
      DatiStampa[C].W:=Dati[P].W;
      DatiStampa[C].F:=Dati[P].F;
      inc(C);
    end;
  end;
  //Lettura dati intestazione
  for i:=0 to High(aCompIntestazione) do
  begin
    S:=aCompIntestazione[i];
    if EsisteDatoStampa(S) = -1 then
    begin
      SetLength(DatiStampa,C + 1);
      P:=GetDato(S,True);
      if P = -1 then
        raise Exception.Create('Attenzione: [' + S + '] Dato non esistente!');
      DatiStampa[C].N:=P;
      DatiStampa[C].D:=S;
      DatiStampa[C].W:=Dati[P].W;
      DatiStampa[C].F:=Dati[P].F;
      inc(C);
    end;
  end;
  //Lettura dati dettaglio
  for i:=0 to High(aCompDettaglio) do
  begin
    S:=aCompDettaglio[i];
    if EsisteDatoStampa(S) = -1 then
    begin
      SetLength(DatiStampa,C + 1);
      P:=GetDato(S,True);
      if P = -1 then
        raise Exception.Create('Attenzione: [' + S + '] Dato non esistente!');
      DatiStampa[C].N:=P;
      DatiStampa[C].D:=S;
      DatiStampa[C].W:=Dati[P].W;
      DatiStampa[C].F:=Dati[P].F;
      inc(C);
    end;
  end;
  //Lettura dati del filtro
  for i:=0 to High(Serbatoi) do
  begin
    Serbatoi[i].Filtro:='';
    if Trim(Serbatoi[i].FiltroTxt) <> '' then
      ElaboraFiltro(i,C);
  end;
  //Lettura dei dati molteplici selezionati
  for i:=0 to High(TabelleCollegate) do
  begin
    TabelleCollegate[i].Esiste:=False;
    for j:=0 to High(DatiStampa) do
      if Dati[DatiStampa[j].N].M = TabelleCollegate[i].M then
      begin
        TabelleCollegate[i].Esiste:=True;
        Break;
      end;
  end;
  //Aggiungo gli eventuali dati necessari non specificati nella stampa
  for i:=0 to High(TabelleCollegate) do
   if TabelleCollegate[i].Esiste then
     with TStringList.Create do
     try
       CommaText:=TabelleCollegate[i].DatiNecessari;
       for j:=0 to Count - 1 do
         if EsisteDatoStampa(Strings[j]) = -1 then
         begin
           C:=Length(DatiStampa);
           SetLength(DatiStampa,C + 1);
           P:=GetDato(Strings[j],True);
           if P >= 0 then
           begin
             DatiStampa[C].N:=P;
             DatiStampa[C].D:=Strings[j];
             DatiStampa[C].W:=Dati[P].W;
             DatiStampa[C].F:=Dati[P].F;
           end;
         end;
     finally
       Free;
     end;
  //Aggiungo i dati reali referenziati dalle espressioni dei dati calcolati
  for i:=High(DatiStampa) downto 0 do
    if Dati[DatiStampa[i].N].Calcolato then
      with TStringList.Create do
      try
        for j:=0 to High(Serbatoi) do
          if Serbatoi[j].X = Dati[DatiStampa[i].N].X then
          begin
            CommaText:=EsplodiEspressione(j,VarToStr(selT909.Lookup('NOME',Dati[DatiStampa[i].N].D,'ESPRESSIONE')));
            Break;
          end;
        for j:=0 to Count - 1 do
         if EsisteDatoStampa(Strings[j]) = -1 then
         begin
           C:=Length(DatiStampa);
           SetLength(DatiStampa,C + 1);
           P:=GetDato(Strings[j],True);
           if P >= 0 then
           begin
             DatiStampa[C].N:=P;
             DatiStampa[C].D:=Strings[j];
             DatiStampa[C].W:=Dati[P].W;
             DatiStampa[C].F:=Dati[P].F;
             //Alberto 15/05/2012: il dato aggiunto viene percentualizzato allo stesso modo del dato calcolato che lo utilizza
             Dati[DatiStampa[C].N].CDCPerc:=Dati[DatiStampa[i].N].CDCPerc;
           end;
         end;
      finally
        Free;
      end;
  //CDC percentualizzato
  S:='CDCPERC_CODICE';
  if EsisteDatoStampa(S) = -1 then
  begin
    P:=GetDato(S,False);
    if P = -1 then
      raise Exception.Create('Attenzione: [' + S + '] Dato non esistente!');
    C:=Length(DatiStampa);
    SetLength(DatiStampa,C + 1);
    DatiStampa[C].N:=P;
    DatiStampa[C].D:=S;
    DatiStampa[C].W:=Dati[P].W;
    DatiStampa[C].F:=Dati[P].F;
    inc(C);
  end;
  for i:=0 to High(DatiStampa) do
  begin
    DatiStampa[i].TC:=-1;
    for j:=0 to High(TabelleCollegate) do
      if Dati[DatiStampa[i].N].M = TabelleCollegate[j].M then
      begin
        DatiStampa[i].TC:=j;
        Break;
      end;
  end;
end;

procedure TR003FGeneratoreStampeMW.ElaboraFiltro(SerbID:Word; var C:Integer);
var i,j,P:Integer;
    CampoOre,CampoData,Apice,IsNum,Valido:Boolean;
    Filtro,Testo,Nome,UN:String;
    procedure OreInMinuti(var NC:Integer);
    //Conversione Ore.Minuti in Minuuti
    var Ore:String;
        j:Integer;
    begin
      j:=NC + 1;
      Ore:='';
      while Testo[j] <> '''' do
      begin
        Ore:=Ore + Testo[j];
        inc(j);
      end;
      Filtro:=Filtro + IntToStr(R180OreMinutiExt(Ore));
      NC:=NC + Length(Ore) + 1;
    end;
    procedure CorreggiData(var NC:Integer);
    //Controllo della data
    var DD:String;
        j:Integer;
    begin
      j:=NC + 1;
      DD:='';
      while Testo[j] <> '''' do
      begin
        DD:=DD + Testo[j];
        inc(j);
      end;
      try
        Filtro:=Filtro + '''' + FormatDateTime('dd/mm/yyyy',StrToDate(DD)) + '''';
      except
        Filtro:=Filtro + '''' + DD + '''';
      end;
      NC:=NC + Length(DD) + 1;
    end;
    function GetNome(var NC:Integer):String;
    //Estrazione nome del dato
    var j:Integer;
    begin
      j:=NC;
      Result:='';
      while (j <= Length(Testo)) and not(Testo[j] in ['(',')','=','<','>',' ',#0,'.',',','|','+','*','/','-']) do
      begin
        Filtro:=Filtro + Testo[j];
        Result:=Result + Testo[j];
        inc(j);
      end;
      NC:=NC + Length(Result) - 1;
    end;
begin
  Testo:=EliminaRitornoACapo(Serbatoi[SerbID].FiltroTxt);
  Filtro:='';
  CampoOre:=False;
  CampoData:=False;
  Apice:=False;
  i:=1;
  while i <= Length(Testo) do
  begin
    if Testo[i] in ['(',')','=','<','>',' ',#0,'.',',','|','+','*','/','-'] then
    begin
      Filtro:=Filtro + Testo[i];
      inc(i);
      Continue;
    end;
    if Testo[i] = '''' then
    begin
      if CampoOre then
      begin
        OreInMinuti(i);
        CampoOre:=False;
      end
      else if CampoData then
      begin
        CorreggiData(i);
        CampoData:=False;
      end
      else
      begin
        Filtro:=Filtro + Testo[i];
        Apice:=not Apice;
      end;
      inc(i);
      Continue;
    end;
    if Apice then
    begin
      Filtro:=Filtro + Testo[i];
      inc(i);
      Continue;
    end;
    Nome:=GetNome(i);
    try
      StrToFloat(Nome);
      IsNum:=True;
    except
      IsNum:=False;
    end;
    UN:=UpperCase(Nome);
    if UN = 'NULL' then
    begin
      CampoData:=False;
      CampoOre:=False;
    end;
    //Controllo parole chiave
    if (not IsNum) and (lstOperatoriSQL.IndexOf(UN) = -1) and (lstFunzioniSQL.IndexOf(UN) = -1) then
    begin
      //Verifico che il dato sia presente tra tutti i dati esistenti
      P:=GetDato(Nome,True);
      if P = - 1 then
        raise Exception.Create('Dato sconosciuto: [' + Nome + '] Controllare l''espressione!');
      //Verifico che il dato sia presente tra i dati del serbatoio
      Valido:=False;
      for j:=0 to Serbatoi[SerbID].lst.Count - 1 do
        if UN = UpperCase(Identificatore(Serbatoi[SerbID].lst[j])) then
        begin
          Valido:=True;
          Break;
        end;
      if not Valido then
        raise Exception.Create('Dato non esistente nel serbatoio corrente: [' + Nome + '] Controllare l''espressione!');
      CampoOre:=Dati[P].F = 2;
      CampoData:=Dati[P].F = 3;
      if Dati[P].Calcolato then
      begin
        Filtro:=Copy(Filtro,1,Length(Filtro) - Length(Nome));
        i:=i + 1 - Length(Nome);
        Delete(Testo,i,Length(Nome));
        Insert(VarToStr(selT909.Lookup('NOME',Dati[P].D,'ESPRESSIONE')),Testo,i);
        dec(i);
      end
      else if EsisteDatoStampa(Nome) = -1 then
      begin
        SetLength(DatiStampa,C + 1);
        DatiStampa[C].N:=P;
        DatiStampa[C].D:=Nome;
        DatiStampa[C].W:=Dati[P].W;
        DatiStampa[C].F:=Dati[P].F;
        inc(C);
      end;
    end;
    inc(i);
  end;
  Serbatoi[SerbID].Filtro:=Filtro;
end;

procedure TR003FGeneratoreStampeMW.InserisciT920(Data: TDateTime);
var
  i,j,NV:Integer;
  FineDati:Boolean;
  {Variabili d'appoggio}
  Key, KeyTot, Val, NewD:string;
  MyQry:TOracleQuery;
  NumOrd:integer;
  {end}
begin
  Ins920.ClearVariables;
  if (EsisteDatoStampa('FINEPERIODOPROVA') >= 0) or (EsisteDatoStampa('METPERIODOPROVA') >= 0) then
    PeriodoProva.GetPeriodoProva(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,
                                 DatiAnagrafici.FieldByName('T430' + Parametri.CampiRiferimento.C6_DurataProva).AsInteger,
                                 DatiAnagrafici.FieldByName('T430' + Parametri.CampiRiferimento.C6_InizioProva).AsDateTime);
  for i:=0 to High(DatiStampa) do
  begin
    if Dati[DatiStampa[i].N].Calcolato then Continue;
    if Dati[DatiStampa[i].N].M > 0 then Continue;
    //Num record
    if UpperCase(DatiStampa[i].D) = 'NUMORDINE' then
      Ins920.SetVariable(DatiStampa[i].D,1)
    //DataDecorrenza
    else if UpperCase(DatiStampa[i].D) = 'T430DATADECORRENZA' then
      Ins920.SetVariable(DatiStampa[i].D,selAnagrafe.FieldByName('T430DATADECORRENZA').AsDateTime)
    //DataFine
    else if UpperCase(DatiStampa[i].D) = 'T430DATAFINE' then
      Ins920.SetVariable(DatiStampa[i].D,selAnagrafe.FieldByName('T430DATAFINE').AsDateTime)
    //Fine periodo di prova
    else if UpperCase(DatiStampa[i].D) = 'FINEPERIODOPROVA' then
    begin
      if PeriodoProva.FinePeriodoProva > 0 then
        Ins920.SetVariable(DatiStampa[i].D,PeriodoProva.FinePeriodoProva)
      else
        Ins920.SetVariable(DatiStampa[i].D,null)
    end
    //Metà periodo di prova
    else if UpperCase(DatiStampa[i].D) = 'METPERIODOPROVA' then
    begin
      if PeriodoProva.FinePeriodoProva > 0 then
        Ins920.SetVariable(DatiStampa[i].D,PeriodoProva.MetaPeriodoProva)
      else
        Ins920.SetVariable(DatiStampa[i].D,null)
    end
    else if UpperCase(DatiStampa[i].D) = 'CDCPERC_CODICE' then
    begin
      if CDCPercentualizzati then
        Ins920.SetVariable(DatiStampa[i].D,selAnagrafe.FieldByName('T433CODICE').AsString)
      {PS}
      else if EsistonoDatiDaProporzionare then
        Ins920.SetVariable(DatiStampa[i].D,'*')
      {PS}
      else
        Ins920.SetVariable(DatiStampa[i].D,null);
    end
    else if UpperCase(DatiStampa[i].D) = 'CDCPERC_DECOR' then
    begin
      if CDCPercentualizzati and PeriodiStorici then
        Ins920.SetVariable(DatiStampa[i].D,selAnagrafe.FieldByName('T430DATADECORRENZA').AsString)
      {PS}
      else if EsistonoDatiDaProporzionare then
        Ins920.SetVariable(DatiStampa[i].D,selAnagrafe.FieldByName('T430DATADECORRENZA').AsString)
      {PS}
      else
        Ins920.SetVariable(DatiStampa[i].D,null);
    end
    else if UpperCase(DatiStampa[i].D) = 'CDCPERC_DESCRIZIONE' then
    begin
      if CDCPercentualizzati and selCDCPerc.Active then
        Ins920.SetVariable(DatiStampa[i].D,selCDCPerc.Lookup('CODICE',selAnagrafe.FieldByName('T433CODICE').AsString,'DESCRIZIONE'))
      else
        Ins920.SetVariable(DatiStampa[i].D,null);
    end
    else if UpperCase(DatiStampa[i].D) = 'CDCPERC_PERCENTUALE' then
    begin
      if CDCPercentualizzati then
        Ins920.SetVariable(DatiStampa[i].D,selAnagrafe.FieldByName('T433PERCENTUALE').AsFloat)
      {PS}
      else if EsistonoDatiDaProporzionare then
        Ins920.SetVariable(DatiStampa[i].D,100)
      {PS}
      else
        Ins920.SetVariable(DatiStampa[i].D,null);
    end
    else if UpperCase(DatiStampa[i].D) = 'P430PERC_IRPEF_TASS_SEP' then
      Ins920.SetVariable(DatiStampa[i].D,GetP430PercIrpefTassSep(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,SelAnagrafe.FieldByName('T430DATADECORRENZA').AsDateTime,SelAnagrafe.FieldByName('T430DATAFINE').AsDateTime,Data))
    //Dati anagrafici
    else if Dati[DatiStampa[i].N].R = 1 then
    begin
      if DatiStampa[i].F in [0,1,4] then
        Ins920.SetVariable(DatiStampa[i].D,DatiAnagrafici.FieldByName(DatiStampa[i].D).AsString)
      else if DatiStampa[i].F = 2 then
        Ins920.SetVariable(DatiStampa[i].D,R180OreMinutiExt(DatiAnagrafici.FieldByName(DatiStampa[i].D).AsString))
      else if DatiStampa[i].F = 3 then
        Ins920.SetVariable(DatiStampa[i].D,DatiAnagrafici.FieldByName(DatiStampa[i].D).AsDateTime);
    end
    //Altri dati
    else if (DatiStampa[i].V.Count > 0) and (TValore(DatiStampa[i].V[0]).Val <> '***') then
    try
      Ins920.SetVariable(DatiStampa[i].D,AnsiString(TValore(DatiStampa[i].V[0]).Val));
    except
    end;
  end;
  Ins920.Execute;
  for i:=0 to High(TabelleCollegate) do
  begin
    if not TabelleCollegate[i].Esiste then Continue;
    if TabelleCollegate[i].InsDaSelect then
    begin  //Inserimento direttamente da Select
      TabelleCollegate[i].OQIns.SetVariable('PROGRESSIVO',DatiAnagrafici.FieldByName('PROGRESSIVO').AsInteger);
      if TabelleCollegate[i].OQIns.VariableIndex('DATA1') >= 0 then
        if TabelleCollegate[i].OQIns.Name = 'Ins920_1' then  //Alberto 25/01/2006: P430_Anagrafico
          TabelleCollegate[i].OQIns.SetVariable('DATA1',DaData)
        else
          TabelleCollegate[i].OQIns.SetVariable('DATA1',R180InizioMese(DaData));
      if TabelleCollegate[i].OQIns.VariableIndex('DATA2') >= 0 then
        if TabelleCollegate[i].OQIns.Name = 'Ins920_1' then  //Alberto 25/01/2006: P430_Anagrafico
          TabelleCollegate[i].OQIns.SetVariable('DATA2',AData)
        else
          TabelleCollegate[i].OQIns.SetVariable('DATA2',R180InizioMese(AData));
      TabelleCollegate[i].OQIns.Execute;
    end
    else
    begin
      TabelleCollegate[i].OQIns.ClearVariables;
      TabelleCollegate[i].OQIns.SetVariable(TabelleCollegate[i].Progressivo,DatiAnagrafici.FieldByName('PROGRESSIVO').AsInteger);
      if CDCPercentualizzati then
      begin
        TabelleCollegate[i].OQIns.SetVariable('CDCPERC_CODICE',SelAnagrafe.FieldByName('T433CODICE').AsString);
        if PeriodiStorici then
          TabelleCollegate[i].OQIns.SetVariable('CDCPERC_DECOR',SelAnagrafe.FieldByName('T430DATADECORRENZA').AsString);
      end
      {PS}
      else if EsistonoDatiDaProporzionare then
      begin
        TabelleCollegate[i].OQIns.SetVariable('CDCPERC_CODICE','*');
        TabelleCollegate[i].OQIns.SetVariable('CDCPERC_DECOR',SelAnagrafe.FieldByName('T430DATADECORRENZA').AsString);
      end;
      {PS}
      NV:=0;
      repeat
        FineDati:=True;
        for j:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[j].N].Calcolato then Continue;
          if Dati[DatiStampa[j].N].M <> TabelleCollegate[i].M then Continue;
          if DatiStampa[j].V = nil then Continue;
          if DatiStampa[j].V.Count > NV then
          begin
            FineDati:=False;
            if TabelleCollegate[i].NomeKey <> '' then
              TabelleCollegate[i].OQIns.SetVariable(TabelleCollegate[i].NomeKey,TValore(DatiStampa[j].V[NV]).Key);
            if TabelleCollegate[i].KeyTotale <> '' then
              TabelleCollegate[i].OQIns.SetVariable(TabelleCollegate[i].KeyTotale,TValore(DatiStampa[j].V[NV]).KeyTot);
            if (TValore(DatiStampa[j].V[NV]).Val = '***') or (TValore(DatiStampa[j].V[NV]).Val = '') then
              TabelleCollegate[i].OQIns.SetVariable(DatiStampa[j].D,null)
            else
            begin
              Key:=TValore(DatiStampa[j].V[NV]).Key;
              KeyTot:=TValore(DatiStampa[j].V[NV]).KeyTot;
              Val:=TValore(DatiStampa[j].V[NV]).Val;
              NumOrd:=TValore(DatiStampa[j].V[NV]).NumOrd;
              NewD:=DatiStampa[j].D;
              MyQry:=TabelleCollegate[i].OQIns;
              TabelleCollegate[i].OQIns.SetVariable(DatiStampa[j].D,AnsiString(TValore(DatiStampa[j].V[NV]).Val));
            end;
          end
          else
            Break;
        except
        end;
        if not FineDati then
          TabelleCollegate[i].OQIns.Execute;
        inc(NV);
      until FineDati;
    end;
  end;
  SessioneOracle.Commit;
end;

function TR003FGeneratoreStampeMW.GetP430PercIrpefTassSep(P:Integer; Dal,Al,Data:TDateTime):Real;
var ImponibileTassSep,Ritenuta,SogliaPrec:Real;
begin
  Result:=0;
  //Lettura di tutti gli scaglioni della ritenuta IRPEF a tassazione separata
  selaP232.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selaP232.SetVariable('Cod_Voce',VFRitenutaIRPEFTassazioneSep.CodVoce);
  selaP232.SetVariable('Cod_Voce_Speciale',VFRitenutaIRPEFTassazioneSep.CodVoceSpeciale);
  selaP232.SetVariable('Decorrenza',Data);
  selaP232.Close;
  selaP232.Open;
  if selaP232.Eof then
    exit;
  //Lettura somma dei redditi dei due anni precedenti
  selP270.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selP270.SetVariable('Anno',R180Anno(Data));
  selP270.Close;
  selP270.Open;
  ImponibileTassSep:=selP270.FieldByName('REDDITI_DUE_ANNI_PREC').AsFloat / 2;
  if ImponibileTassSep = 0 then
  begin
    Result:=selaP232.FieldByName('PERC_IMP').AsFloat;
    exit;
  end;
  //Calcolo ritenuta sulla media dei redditi dei due anni precedenti
  Ritenuta:=0;
  SogliaPrec:=0;
  //Ricerca ultimo scaglione di competenza dell'imponibile
  while (selaP232.FieldByName('IMPORTO_A').AsFloat <> 0) and
        (ImponibileTassSep > (selaP232.FieldByName('IMPORTO_A').AsFloat)) do
  begin
    Ritenuta:=Ritenuta + (selaP232.FieldByName('IMPORTO_A').AsFloat - SogliaPrec) * selaP232.FieldByName('PERC_IMP').AsFloat / 100;
    SogliaPrec:=selaP232.FieldByName('IMPORTO_A').AsFloat;
    selaP232.Next;
  end;
  //Cumulo con ultimo scaglione della ritenuta a percentuale
  Ritenuta:=Ritenuta + (ImponibileTassSep - SogliaPrec) * selaP232.FieldByName('PERC_IMP').AsFloat / 100;
  //Calcolo percentuale ritenuta media
  Result:=Ritenuta / ImponibileTassSep * 100;
end;

procedure TR003FGeneratoreStampeMW.InizializzaVariabili(Libera:Boolean);
{Liberazione delle liste dei valori di dettaglio}
var i,j:Integer;
begin
  for i:=0 to High(DatiStampa) do
  begin
    if DatiStampa[i].V <> nil then
    begin
      for j:=DatiStampa[i].V.Count - 1 downto 0 do
        TValore(DatiStampa[i].V[j]).Free;
      DatiStampa[i].V.Clear;
      if Libera then
      begin
        DatiStampa[i].V.Free;
        DatiStampa[i].V:=nil;
      end;
    end;
  end;
end;

function TR003FGeneratoreStampeMW.LetturaLabelDati: TList<TLabelDati>;
var
  lbl: TLabelDati;
  P: Integer;
begin
  Result:=TList<TLabelDati>.Create;
  Q911.Close;
  Q911.SetVariable('CODICE',SelT910_Funzioni.FieldByName('CODICE').AsString);
  Q911.Open;
  while not Q911.Eof do
  begin
    lbl.X:=Q911.FieldByName('POSL').AsInteger;
    lbl.Y:=Q911.FieldByName('POST').AsInteger;
    lbl.W:=Q911.FieldByName('LUNG').AsInteger;
    lbl.H:=Q911.FieldByName('ALT').AsInteger;
    if Q911.FieldByName('TOTALE').AsString = 'S' then
      lbl.Totale:=0
    else
      lbl.Totale:=1;
    lbl.Banda:=Q911.FieldByName('BANDA').AsString;
    lbl.Nome:=Q911.FieldByName('NOME').AsString;
    lbl.Capt:=Q911.FieldByName('CAPTION').AsString;
    Result.Add(lbl);
    P:=GetDato(lbl.Nome,False);
    if P >= 0 then
    begin
      //Impostazione del formato per DataConteggio,Giustificativi e Timbrature
      if Dati[P].Fex = 'S' then
        Dati[P].Fmt:=Q911.FieldByName('FORMATO').AsString;
      //Impostazione del contatore per i dati totalizzabili
      if Dati[P].T = 0 then
        Dati[P].Cont:=StrToInt(StringReplace(StringReplace(Q911.FieldByName('CONTATORE').AsString,'N','0',[]),'S','1',[]));
      //Impostazione Percentualizzazione per CDC per i dati numerici
      if Dati[P].F in [1,2] then
        Dati[P].CDCPerc:=Q911.FieldByName('CDC_PERCENTUALIZZATI').AsString = 'S';
      //Impostazione della conversione dela valuta
      if (Dati[P].F = 1) and (Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S') then
        Dati[P].ConvValuta:=Q911.FieldByName('CONV_VALUTA').AsString = 'S';
      //Impostazione della ripetizione dei dati anagrafici su ogni riga di dettaglio
      if Dati[P].M = 0 then
        Dati[P].Ripetuto:=Q911.FieldByName('RIPETUTO').AsString = 'S';
    end;
    Q911.Next;
  end;
  Q911.Close;
end;

procedure TR003FGeneratoreStampeMW.LetturaOrdinamento;
begin
  Q912.Close;
  Q912.SetVariable('CODICE',SelT910_Funzioni.FieldByName('CODICE').AsString);
  Q912.Open;
  while not Q912.Eof do
  begin
    SetLength(Ordinamento,Length(Ordinamento) + 1);
    Ordinamento[High(Ordinamento)].Nome:=Q912.FieldByName('NOME').AsString;
    Ordinamento[High(Ordinamento)].Rottura:=Q912.FieldByName('ROTTKEY').AsString = 'S';
    Ordinamento[High(Ordinamento)].Discendente:=Q912.FieldByName('TIPO').AsString = 'D';
    Q912.Next;
  end;
  Q912.Close;
end;

procedure TR003FGeneratoreStampeMW.LetturaChiaviCumulo;
var
  i: Integer;
  P: Integer;
begin
  //Lettura chiavi di cumulo dei serbatoi
  Q913.Close;
  Q913.SetVariable('CODICE',SelT910_Funzioni.FieldByName('CODICE').AsString);
  Q913.Open;
  while not Q913.Eof do
  begin
    for i:=0 to High(Serbatoi) do
      if Serbatoi[i].M = Q913.FieldByName('ID_SERBATOIO').AsInteger then
      begin
        P:=Length(Serbatoi[i].KeyCumulo);
        SetLength(Serbatoi[i].KeyCumulo,P + 1);
        Serbatoi[i].KeyCumulo[P].Nome:=Q913.FieldByName('DATO').AsString;
        Serbatoi[i].KeyCumulo[P].Totale:=Q913.FieldByName('TOTALE').AsString = 'S';
        Break;
      end;
    Q913.Next;
  end;
end;

procedure TR003FGeneratoreStampeMW.LetturaFiltriSerbatoi;
var
  i: Integer;
begin
  //Lettura filtri dei serbatoi
  Q914.Close;
  Q914.SetVariable('CODICE',SelT910_Funzioni.FieldByName('CODICE').AsString);
  Q914.Open;
  while not Q914.Eof do
  begin
    for i:=0 to High(Serbatoi) do
      if Serbatoi[i].M = Q914.FieldByName('ID_SERBATOIO').AsInteger then
      begin
        Serbatoi[i].Esclusivo:=Q914.FieldByName('ESCLUSIVO').AsString = 'S';
        Serbatoi[i].FiltroTxt:=Q914.FieldByName('FILTRO').AsString;
        Serbatoi[i].DatoDalAl:=Q914.FieldByName('DATO_DALAL').AsString;
        Break;
      end;
    Q914.Next;
  end;
end;

procedure TR003FGeneratoreStampeMW.AperturaCodiciSerbatoi;
begin
  Q915.Close;
  Q915.SetVariable('CODICE',SelT910_Funzioni.FieldByName('CODICE').AsString);
  Q915.Open;
end;

function TR003FGeneratoreStampeMW.IsCodiceSerbatoioChecked(IdSerbatoio:Integer;Codice:String) : Boolean;
begin
  Result:=Q915.SearchRecord('ID_SERBATOIO;DATO',VarArrayOf([IdSerbatoio,Codice]),[srFromBeginning]);
end;

procedure TR003FGeneratoreStampeMW.ResetDati;
var
  i: Integer;
begin
  for i:=1 to High(Dati) do
  begin
    Dati[i].Fmt:='';
    Dati[i].CDCPerc:=False;
    Dati[i].ConvValuta:=False;
    Dati[i].Ripetuto:=False;
  end;
end;

procedure TR003FGeneratoreStampeMW.ResetOrdinamentoeCumulo;
var
  i: Integer;
begin
  SetLength(Ordinamento,0);
  for i:=0 to High(Serbatoi) do
  begin
    SetLength(Serbatoi[i].KeyCumulo,0);
    Serbatoi[i].Esclusivo:=False;
    Serbatoi[i].DatoDalAl:='';
    Serbatoi[i].FiltroTxt:='';
  end;
end;

function TR003FGeneratoreStampeMW.EsisteOrdinamento(Val: String): Boolean;
var
  i: Integer;
begin
  Result:=False;
  for i:=Low(Ordinamento) to High(Ordinamento) do
  begin
    if Ordinamento[i].Nome = Val then
    begin
      Result:=True;
      Exit;
    end;
  end;
end;

function TR003FGeneratoreStampeMW.AggiungiOrdinamento(val:String): Boolean;
begin
  Result:=False;
  if FSelT910_Funzioni.State in [dsEdit, dsInsert] then
  begin
    if not EsisteOrdinamento(Val) then
    begin
      SetLength(Ordinamento,Length(Ordinamento) + 1);
      Ordinamento[High(Ordinamento)].Nome:=val;
      Ordinamento[High(Ordinamento)].Rottura:=False;
      Ordinamento[High(Ordinamento)].Discendente:=False;
      modOrdinamento:=True;
      Result:=True;
    end;
  end;
end;

function TR003FGeneratoreStampeMW.KeyCumuloPresente(idSerbatoio: Integer; Val:String):Boolean;
var
  i: Integer;
begin
  Result:=False;
  with serbatoi[idSerbatoio] do
  begin
    for i:=Low(KeyCumulo) to High(KeyCumulo) do
    begin
      if KeyCumulo[i].Nome = Val then
      begin
        Result:=True;
        Break;
      end;
    end;
  end;
end;

function TR003FGeneratoreStampeMW.AggiungiDettaglioSerbatoio(idxSerbatoio: Integer; Val:String):Boolean;
begin
  Result:=False;
  if FSelT910_Funzioni.State in [dsEdit, dsInsert] then
  begin
    if (not KeyCumuloPresente(idxSerbatoio, Val)) and
       (Dati[GetDato(Val,False)].KC = 1) then
    with Serbatoi[idxSerbatoio] do
    begin
      SetLength(KeyCumulo,Length(KeyCumulo) + 1);
      KeyCumulo[High(KeyCumulo)].Nome:=Val;
      KeyCumulo[High(KeyCumulo)].Totale:=False;
      modDettaglioSerbatoio:=True;
      Result:=True;
    end;
  end;
end;

procedure TR003FGeneratoreStampeMW.RimuoviOrdinamentoByIndice(idx:Integer);
var
  i: Integer;
begin
  if idx < High(Ordinamento) then
  begin
    for i:=idx +1 to High(Ordinamento) do
    begin
      Ordinamento[i - 1]:= Ordinamento[i];
    end;
  end;
  SetLength(Ordinamento,Length(Ordinamento) - 1);
  ModOrdinamento:=True;
end;

procedure TR003FGeneratoreStampeMW.RimuoviKeyCumuloByIndice(idSerbatoio,idx:Integer);
var
  i: Integer;
begin
  if idx < High(serbatoi[idSerbatoio].KeyCumulo) then
  begin
    for i:=idx + 1 to High(serbatoi[idSerbatoio].KeyCumulo) do
    begin
      serbatoi[idSerbatoio].KeyCumulo[i - 1]:=serbatoi[idSerbatoio].KeyCumulo[i];
    end;
  end;
  SetLength(serbatoi[idSerbatoio].KeyCumulo,Length(serbatoi[idSerbatoio].KeyCumulo) - 1);
  modDettaglioSerbatoio:=True;
end;

function TR003FGeneratoreStampeMW.IdxTabelleCollegateDaSerbatoi(idx:Byte):Integer;
var i:Integer;
begin
  Result:=-1;
  for i:=0 to High(TabelleCollegate) do
    if TabelleCollegate[i].M = Serbatoi[idx].M then
    begin
      Result:=i;
      Break;
    end;
end;

function TR003FGeneratoreStampeMW.getElencoFiltri:TStringList;
{Visualizzazione globale dei filtri}
var i:Integer;
begin
  Result:=TStringList.Create;
  for i:=0 to High(Serbatoi) do
  begin
    if Serbatoi[i].Esclusivo then
      Result.Add('[' + Serbatoi[i].Nome + '] Esclusivo')
    else if Trim(Serbatoi[i].FiltroTxt) <> '' then
      Result.Add('[' + Serbatoi[i].Nome + ']');
    if Trim(Serbatoi[i].FiltroTxt) <> '' then
      Result.Add(Trim(Serbatoi[i].FiltroTxt));
  end;
end;

function TR003FGeneratoreStampeMW.getRiepilogoKeyCumulo: TStringList;
var
  i,j: Integer;
begin
  Result:=TStringList.Create;
  for i:=0 to High(Serbatoi) do
  begin
    if Length(Serbatoi[i].KeyCumulo) > 0 then
    begin
      Result.Add('[' + Serbatoi[i].Nome + ']');
      for j:=0 to High(Serbatoi[i].KeyCumulo) do
      begin
        if Serbatoi[i].KeyCumulo[j].Totale then
          Result.Add(' (T)' + Serbatoi[i].KeyCumulo[j].Nome)
        else
          Result.Add('    ' + Serbatoi[i].KeyCumulo[j].Nome);
      end;
    end;
  end;
end;

procedure TR003FGeneratoreStampeMW.DeleteTabelle(Codice:String);
begin
  Del911.SetVariable('CODICE',Codice);
  Del911.Execute;
  Del912.SetVariable('CODICE',Codice);
  Del912.Execute;
  Del913.SetVariable('CODICE',Codice);
  Del913.Execute;
  Del914.SetVariable('CODICE',Codice);
  Del914.Execute;
  Del915.SetVariable('CODICE',Codice);
  Del915.Execute;
end;

procedure TR003FGeneratoreStampeMW.SelT910BeforePost(lstLabelDati: TList<TLabelDati>;lstCodiciTabCollegate: TList<TCodiciTabCollegate>; Impostazioni: String);
var
  labelDati: TLabelDati;
  Fmt: string;
  P,i,j: Integer;
  CodiciTabCollegate: TCodiciTabCollegate;
begin
  // eliminazione spazi nel codice stampa.ini - 18.05.2012 (ver. 8.5)
  // NOTA: l'agg. di versione 8.5 si occupa di modificare tutti i codici con questo criterio
  FSelT910_Funzioni.FieldByName('CODICE').AsString:=Trim(FSelT910_Funzioni.FieldByName('CODICE').AsString);
  // eliminazione spazi nel codice stampa.fine

  if QueryPK1.EsisteChiave('T910_RIEPILOGO',FSelT910_Funzioni.RowId,FSelT910_Funzioni.State,['CODICE'],[FSelT910_Funzioni.FieldByName('CODICE').AsString]) then
    raise Exception.Create(A000MSG_ERR_CODICE_ESISTENTE);

  DeleteTabelle(FSelT910_Funzioni.FieldByName('CODICE').AsString);
  Ins911.ClearVariables;
  Ins911.SetVariable('CODICE',FSelT910_Funzioni.FieldByName('CODICE').AsString);
  //Registrazione dati intestazione
  for labelDati in lstLabelDati do
  begin
    P:=GetDato(labelDati.nome,False);
    if P >= 0 then
    begin
      Ins911.SetVariable('NOME',labelDati.Nome);
      Ins911.SetVariable('CAPTION',labelDati.Capt);
      Ins911.SetVariable('TOTALE',IfThen(labelDati.Totale = 0,'S','N'));
      Ins911.SetVariable('POST',labelDati.Y);
      Ins911.SetVariable('POSL',labelDati.X);
      Ins911.SetVariable('LUNG',labelDati.W);
      Ins911.SetVariable('ALT',labelDati.H);
      Ins911.SetVariable('BANDA',labelDati.Banda);

      Ins911.SetVariable('CONTATORE',IfThen(Dati[P].Cont = 0,'N','S'));
      //Registrazione del formato per DataConteggio,Giustificativi e Timbrature
      Fmt:=IfThen(Dati[P].Fex = 'S',Dati[P].Fmt,'');
      Ins911.SetVariable('FORMATO',Copy(Fmt,1,500));
      Ins911.SetVariable('CDC_PERCENTUALIZZATI',IfThen(Dati[P].CDCPerc,'S','N'));
      Ins911.SetVariable('CONV_VALUTA',IfThen(Dati[P].ConvValuta,'S','N'));
      Ins911.SetVariable('RIPETUTO',IfThen(Dati[P].Ripetuto,'S','N'));

      try
        Ins911.Execute;
      except
      end;
    end;
  end;

  //Registrazione dati ordinamento
  Ins912.SetVariable('CODICE',FSelT910_Funzioni.FieldByName('CODICE').AsString);
  //for i:=0 to LSort.Items.Count - 1 do
  for i:=0 to High(Ordinamento) do
  begin
    Ins912.SetVariable('POS',i);
    Ins912.SetVariable('NOME',Ordinamento[i].Nome);
    if Ordinamento[i].Discendente then
      Ins912.SetVariable('TIPO','D')
    else
      Ins912.SetVariable('TIPO','C');
    if Ordinamento[i].Rottura then
      Ins912.SetVariable('ROTTKEY','S')
    else
      Ins912.SetVariable('ROTTKEY','N');
    try
      Ins912.Execute;
    except
    end;
  end;
  //Registrazione chiavi di cumulo e filtro dei serbatoi
  Ins913.SetVariable('CODICE',FSelT910_Funzioni.FieldByName('CODICE').AsString);
  Ins914.SetVariable('CODICE',FSelT910_Funzioni.FieldByName('CODICE').AsString);
  for i:=0 to High(Serbatoi) do
  begin
    Ins913.SetVariable('ID_SERBATOIO',Serbatoi[i].M);
    Ins914.SetVariable('ID_SERBATOIO',Serbatoi[i].M);
    for j:=0 to High(Serbatoi[i].KeyCumulo) do
    begin
      Ins913.SetVariable('POS',j);
      Ins913.SetVariable('DATO',Serbatoi[i].KeyCumulo[j].Nome);
      Ins913.SetVariable('TOTALE',IfThen(Serbatoi[i].KeyCumulo[j].Totale,'S','N'));
      Ins913.Execute;
    end;
    Ins914.SetVariable('ESCLUSIVO',IfThen(Serbatoi[i].Esclusivo,'S','N'));
    Ins914.SetVariable('FILTRO',Trim(Serbatoi[i].FiltroTxt));
    Ins914.SetVariable('DATO_DALAL',Trim(Serbatoi[i].DatoDalAl));
    Ins914.Execute;
  end;
  //Registrazione codici selezionati impostati sulle Check List
  Ins915.SetVariable('CODICE',FSelT910_Funzioni.FieldByName('CODICE').AsString);

  for CodiciTabCollegate  in lstCodiciTabCollegate do
  begin
    Ins915.SetVariable('ID_SERBATOIO',CodiciTabCollegate.IdSerbatoio);
    Ins915.SetVariable('DATO',CodiciTabCollegate.Codice);
    Ins915.Execute;
  end;
  //Registrazione Opzioni Avanzate
  FSelT910_Funzioni.FieldByName('IMPOSTAZIONI').AsString:=Impostazioni;

  if (FSelT910_Funzioni.State = dsEdit) and
     (FSelT910_Funzioni.FieldByName('CODICE').medpOldValue <> FSelT910_Funzioni.FieldByName('CODICE').AsString) then
  begin
    with OperSQL do
    begin
      SQL.Clear;
      SQL.Add(Format('UPDATE T909_DATICALCOLATI SET CODICE_STAMPA = ''%s'' WHERE CODICE_STAMPA = ''%s''',[FSelT910_Funzioni.FieldByName('CODICE').AsString,FSelT910_Funzioni.FieldByName('CODICE').medpOldValue]));
      Execute;
    end;
  end;
  if FSelT910_Funzioni.State = dsEdit then
  begin
    if modOrdinamento or modAreaStampa or modFiltro or modDettaglioSerbatoio then
    begin
      //RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),nil,False);
      if modOrdinamento then
        RegistraLog.InserisciDato('Ordinamento','','Modificato');
      if modAreaStampa then
        RegistraLog.InserisciDato('Area stampa','','Modificato');
      if modFiltro then
        RegistraLog.InserisciDato('Filtro','','Modificato');
      if modDettaglioSerbatoio then
        RegistraLog.InserisciDato('Dettaglio Serbatoio','','Modificato');
    end;
  end;
end;

procedure TR003FGeneratoreStampeMW.selT910CodiceFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('GENERATORE DI STAMPE',DataSet.FieldByName('CODICE').AsString);
end;

procedure TR003FGeneratoreStampeMW.SelT910NewRecord;
begin
  FSelT910_Funzioni.FieldByName('FONTNAME').AsString:='Courier New';
  FSelT910_Funzioni.FieldByName('FONTSIZE').AsInteger:=8;
  FSelT910_Funzioni.FieldByName('TIPO').AsString:='C';
  FSelT910_Funzioni.FieldByName('APPLICAZIONE').AsString:=Parametri.Applicazione;
end;

procedure TR003FGeneratoreStampeMW.CancellaT910;
var
  Cestino: TCestino;
  evAfterScroll: TEvDataset;
  TempCod: string;
begin
  Cestino:=TCestino.Create(SessioneOracle);
  try
    FSelT910_Funzioni.DisableControls;

    evAfterScroll:=FSelT910_Funzioni.AfterScroll;
    FSelT910_Funzioni.AfterScroll:=nil;
    if FSelT910_Funzioni.RecNo < FSelT910_Funzioni.RecordCount then
    begin
      FSelT910_Funzioni.Next;
      TempCod:=FSelT910_Funzioni.FieldByName('CODICE').AsString;
      FSelT910_Funzioni.Prior;
    end
    else if FSelT910_Funzioni.RecNo > 0 then
    begin
      FSelT910_Funzioni.Prior;
      TempCod:=FSelT910_Funzioni.FieldByName('CODICE').AsString;
      FSelT910_Funzioni.Next;
    end;
    FSelT910_Funzioni.AfterScroll:=evAfterScroll;

    Cestino.CancLogica(R180Query2NomeTabella(FSelT910_Funzioni),FSelT910_Funzioni.FieldByName('CODICE').AsString);
    RegistraLog.SettaProprieta('C',R180Query2NomeTabella(FSelT910_Funzioni),nomeOwner,FSelT910_Funzioni,True);
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
    FSelT910_Funzioni.Refresh;
    FSelT910_Funzioni.SearchRecord('CODICE',TempCod,[srFromBeginning]);
  finally
    FSelT910_Funzioni.EnableControls;
    Cestino.Free;
  end;
end;

function TR003FGeneratoreStampeMW.VerificaNomeDuplica(NomeStampa: String):String;
begin
  Result:='';
  if Trim(NomeStampa) = '' then
    Result:=A000MSG_R003_ERR_DUPLICA_VUOTO
  else if Length(NomeStampa) > FSelT910_Funzioni.FieldByName('CODICE').Size then
    Result:=A000MSG_R003_ERR_DUPLICA_TROPPO_LUNGO
  else if VarToStr(FSelT910_Funzioni.Lookup('CODICE',NomeStampa,'CODICE')) <> '' then
    Result:=A000MSG_R003_ERR_DUPLICA_ESISTENTE;
end;

procedure TR003FGeneratoreStampeMW.DuplicaStampa(SQLStampa:TStringList;CopiaSu:String;lstCodiciTabCollegate: TList<TCodiciTabCollegate>);
{Esportazione SQL di creazione della stampa su file sequenziale}
var Funz:TStringList;
    S,S1,S2,Nome,Tot,Fmt,Cont,CDCPerc,ConvValuta,Ripetuto :String;
    i,j,P:Integer;
    lstLabels: TList<TLabelDati>;
    lblDati:TLabelDati;
    CodiciTabCollegate: TCodiciTabCollegate;
    aCompIntestazione, aCompDettaglio: Array of String;
  procedure GetFunzioniUsate(Stringa:String);
  begin
    //Ricerca funzioni usate nel filtro
    selUserSource.First;
    while not selUserSource.Eof do
    begin
      if (Pos(selUserSource.FieldByName('NAME').AsString,Stringa) > 0) and
         (Funz.IndexOf(selUserSource.FieldByName('NAME').AsString) = -1) then
        Funz.Add(selUserSource.FieldByName('NAME').AsString);
      selUserSource.Next;
    end;
  end;
begin
  if FSelT910_Funzioni.RecordCount = 0 then
    exit;
  SQLStampa.Add('INSERT INTO T910_RIEPILOGO');
  S1:='';
  S2:='';
  if CopiaSu = '' then
  begin
    Funz:=TStringList.Create;
    selUserSource.Open;
    Nome:=FSelT910_Funzioni.FieldByName('CODICE').AsString;
  end
  else
    Nome:=CopiaSu;
  for i:=0 to FSelT910_Funzioni.FieldCount - 1 do
  begin
    if S1 <> '' then
      S1:=S1 + ',';
    S1:=S1 + FSelT910_Funzioni.Fields[i].FieldName;
    if S2 <> '' then
      S2:=S2 + ',';
    if FSelT910_Funzioni.Fields[i].DataType in [ftInteger,ftFloat] then
      S2:=S2 + FSelT910_Funzioni.Fields[i].AsString
    else
    begin
      if FSelT910_Funzioni.Fields[i].FieldName = 'APPLICAZIONE' then
        if CopiaSu <> '' then
          S:=Parametri.Applicazione
        else
          S:='<:APPLICAZIONE>'
      else if (FSelT910_Funzioni.Fields[i].FieldName = 'CODICE') then
        S:=Nome
      else if FSelT910_Funzioni.Fields[i].FieldName = 'STAMPA_BLOCCATA' then
        S:='N'
      else if FSelT910_Funzioni.Fields[i].DataType = ftDateTime then
        if FSelT910_Funzioni.Fields[i].IsNull then
          S:='NULL'
        else
        S:='TO_DATE(''' + FSelT910_Funzioni.Fields[i].AsString + ''',''DD/MM/YYYY HH24.MI.SS'')'
      else
        S:=AggiungiApiceDoppio(EliminaRitornoACapo(FSelT910_Funzioni.Fields[i].AsString));
      if FSelT910_Funzioni.Fields[i].DataType <> ftDateTime then
        S2:=S2 + '''' + S + ''''
      else
        S2:=S2 + S;
    end;
  end;
  SQLStampa.Add('(' + S1 + ')');
  SQLStampa.Add('VALUES');
  SQLStampa.Add('(' + S2 + ');');
  S1:='INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES';

  lstLabels:=LetturaLabelDati;
  for lblDati in lstLabels do
  begin
    P:=GetDato(lblDati.Nome,False);
    if P >=0 then
    begin
      SQLStampa.Add(S1);
      Tot:=IfThen(lblDati.Totale = 0,'S','N');
      //Registrazione del formato per DataConteggio,Giustificativi e Timbrature
      Fmt:=IfThen(Dati[P].Fex = 'S',Dati[P].Fmt,'');
      Cont:=IfThen(Dati[P].Cont = 0,'N','S');
      CDCPerc:=IfThen(Dati[P].CDCPerc,'S','N');
      ConvValuta:=IfThen(Dati[P].ConvValuta,'S','N');
      Ripetuto:=IfThen(Dati[P].Ripetuto,'S','N');
      S2:=Format('''%s'',''%s'',''%s'',''%s'',''%s'',%d,%d,%d,%d,''%s'',''%s'',''%s'',''%s'',''%s''',
               [Nome,
                AggiungiApiceDoppio(lblDati.Nome),
                AggiungiApiceDoppio(lblDati.Capt),
                lblDati.banda,
                Tot,
                lblDati.Y,
                lblDati.X,
                lblDati.W,
                lblDati.H,
                Fmt,
                Cont,
                CDCPerc,
                ConvValuta,
                Ripetuto]);
      SQLStampa.Add('(' + S2 + ');');
    end;
  end;

  S1:='INSERT INTO T912_SORTRIEPILOGO (CODICE,POS,NOME,TIPO,ROTTKEY) VALUES';
  for i:=0 to High(Ordinamento) do
  begin
    SQLStampa.Add(S1);
    Tot:=IfThen(Ordinamento[i].Rottura,'S','N');
    S:=IfThen(Ordinamento[i].Discendente,'D','C');
    S2:=Format('''%s'',%d,''%s'',''%s'',''%s''',[Nome,i,Ordinamento[i].Nome,S,Tot]);
    SQLStampa.Add('(' + S2 + ');');
  end;
  S1:='INSERT INTO T913_SERBATOIKEY (CODICE,ID_SERBATOIO,POS,DATO,TOTALE) VALUES';
  for i:=0 to High(Serbatoi) do
    for j:=0 to High(Serbatoi[i].KeyCumulo) do
    begin
      SQLStampa.Add(S1);
      if Serbatoi[i].KeyCumulo[j].Totale then
        Tot:='S'
      else
        Tot:='N';
      S2:=Format('''%s'',%d,''%d'',''%s'',''%s''',[Nome,Serbatoi[i].M,j,Serbatoi[i].KeyCumulo[j].Nome,Tot]);
      SQLStampa.Add('(' + S2 + ');');
    end;
  S1:='INSERT INTO T914_SERBATOIFILTRO (CODICE,ID_SERBATOIO,ESCLUSIVO,FILTRO, DATO_DALAL) VALUES';
  for i:=0 to High(Serbatoi) do
    if Trim(Serbatoi[i].FiltroTxt) <> '' then
    begin
      SQLStampa.Add(S1);
      if Serbatoi[i].Esclusivo then
        Tot:='S'
      else
        Tot:='N';
      S2:=Format('''%s'',%d,''%s'',''%s'',''%s''',[Nome,Serbatoi[i].M,Tot,AggiungiApice(Serbatoi[i].FiltroTxt),Serbatoi[i].DatoDalAl]);
      SQLStampa.Add('(' + S2 + ');');
      if CopiaSu = '' then
        //Ricerca funzioni usate nel filtro
        GetFunzioniUsate(UpperCase(Serbatoi[i].FiltroTxt));
    end;

  S1:='INSERT INTO T915_CODICISELEZIONATI (CODICE,ID_SERBATOIO,DATO) VALUES';

  for CodiciTabCollegate in lstCodiciTabCollegate do
  begin
    SQLStampa.Add(S1);
    S:=Trim(CodiciTabCollegate.Codice);
    S2:=Format('''%s'',%d,''%s''',[Nome,CodiciTabCollegate.idSerbatoio,S]);
    SQLStampa.Add('(' + S2 + ');');
  end;

  if CopiaSu = '' then
  begin
    S1:='INSERT INTO T909_DATICALCOLATI (APPLICAZIONE,NOME,ID_SERBATOIO,TIPO,ESPRESSIONE,CODICE_STAMPA) VALUES';
    with selT909 do
    begin
      try
        SetLength(aCompIntestazione,0);
        SetLength(aCompDettaglio,0);
        for lblDati in lstLabels do
        begin
          if lblDati.Banda = 'I' then
          begin
            SetLength(aCompIntestazione,Length(aCompIntestazione) + 1);
            aCompIntestazione[High(aCompIntestazione)]:=Identificatore(lblDati.Nome);
          end
          else
          begin
            SetLength(aCompDettaglio,Length(aCompDettaglio) + 1);
            aCompDettaglio[High(aCompDettaglio)]:=Identificatore(lblDati.Nome);
          end;
        end;
        CaricaDatiDiStampa(aCompIntestazione,aCompDettaglio);
      except
      end;
      for i:=Low(DatiStampa) to High(DatiStampa) do
        if (Dati[DatiStampa[i].N].Calcolato) and
           SearchRecord('NOME',DatiStampa[i].D,[srFromBeginning]) then
        begin
          S2:='DELETE FROM T909_DATICALCOLATI WHERE APPLICAZIONE = ''<:APPLICAZIONE>'' AND NOME = ''' + FieldByName('NOME').AsString + ''';';
          SQLStampa.Add(S2);
          SQLStampa.Add(S1);
          S2:=Format('''%s'',''%s'',%d,''%s'',''%s'',''%s''',
              [(*FieldByName('APPLICAZIONE').AsString,*)
              '<:APPLICAZIONE>',
              FieldByName('NOME').AsString,
              FieldByName('ID_SERBATOIO').AsInteger,
              FieldByName('TIPO').AsString,
              AggiungiApice(FieldByName('ESPRESSIONE').AsString),
              FieldByName('CODICE_STAMPA').AsString]);
          SQLStampa.Add('(' + S2 + ');');
          GetFunzioniUsate(UpperCase(FieldByName('ESPRESSIONE').AsString));
        end;
    end;
    for i:=0 to Funz.Count - 1 do
    begin
      selUserSourceLines.SetVariable('NAME',Funz[i]);
      selUserSourceLines.Close;
      selUserSourceLines.Open;
      SQLStampa.Add('CREATE OR REPLACE');
      while not selUserSourceLines.Eof do
      begin
        SQLStampa.Add(TrimRight(selUserSourceLines.FieldByName('TEXT').AsString));
        selUserSourceLines.Next;
      end;
      SQLStampa.Add('/');
      selUserSourceLines.Close;
    end;
    Funz.Free;
    selUserSource.Close;
  end;
  FreeAndNil(lstLabels);
end;

function TR003FGeneratoreStampeMW.EseguiDuplicaStampa(StrSQL: TStringList):TStringList;
begin
  Result:=TStringList.Create;
  OracleScript.Lines.Clear;
  OracleScript.Output.Clear;
  OracleScript.Lines.Assign(StrSQL);
  OracleScript.OutputOptions:=[ooError];
  OracleScript.Execute;
  OracleScript.Session.Commit;
  if OracleScript.Output.Count > 0 then
    Result.assign(OracleScript.Output);
  OracleScript.OutputOptions:=[];
  OracleScript.Lines.Clear;
end;

//procedura usata da progetti 077 e WA198 (il dataset nei primi casi è selT909 del Mw , per wa198 è seltabella)
procedure TR003FGeneratoreStampeMW.selT909VerificaNome(Dataset: TOracleDataset);
begin
  with TOracleDataSet.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Add('SELECT COUNT(*) FROM T909_DATICALCOLATI WHERE UPPER(NOME) = ''' + UpperCase(Dataset.FieldByName('NOME').AsString) + '''');
    if Dataset.State = dsEdit then
      SQL.Add('AND ROWID <> ''' + Dataset.RowID + '''');
    Open;
    if Fields[0].AsInteger > 0 then
      raise Exception.Create(Format(A000MSG_ERR_FMT_GIA_ESISTENTE,[A000MSG_MSG_NOME]));
  finally
    Free;
  end;
end;

function TR003FGeneratoreStampeMW.getCodiceFunzione(Funzione: String): TStringList;
begin
 Result:=TStringList.Create;
 selUserSourceLines.Close;
 selUserSourceLines.SetVariable('NAME',Funzione);
 selUserSourceLines.Open;
  while not selUserSourceLines.Eof do
  begin
    Result.Add(TrimRight(selUserSourceLines.FieldByName('TEXT').AsString));
    selUserSourceLines.Next;
  end;
  selUserSourceLines.Close;
  if Result.Count = 0 then
    Result.Add('<Funzione interna di Oracle: codice non disponibile>');
end;

procedure TR003FGeneratoreStampeMW.setFiltroInutilizzati(DataSet: TOracleDataset; attivo: Boolean);
var
  Filtro: string;
begin
  DataSet.Close;
  if not attivo then
    DataSet.SetVariable('FILTRO',null)
  else
  begin
    Filtro:='and nome not in (' + #13#10 +
            'select t911.nome from t910_riepilogo t910,t911_datiriepilogo t911 where' + #13#10 +
            't910.applicazione = :APPLICAZIONE and t910.codice = t911.codice' + #13#10 +
            'union' + #13#10 +
            'select t912.nome from t910_riepilogo t910,t912_sortriepilogo t912 where' + #13#10 +
            't910.applicazione = :APPLICAZIONE and t910.codice = t912.codice)' + #13#10 +
            'and not exists' + #13#10 +
            '(select ''x'' from t910_riepilogo t910,t914_serbatoifiltro t914 where' + #13#10 +
            't910.applicazione = :APPLICAZIONE and t910.codice = t914.codice and filtro like ''%''||t909.nome||''%'')';
    DataSet.SetVariable('FILTRO',Filtro);
  end;
  DataSet.Open;
end;

function TR003FGeneratoreStampeMW.ImportaStampa(NomeFileStampa: String):TStringList;
var
  i,P: Integer;
  NomeStampa,S: string;
begin
  Result:=TStringList.Create;
  NomeStampa:='';
  OracleScript.Output.Clear;
  OracleScript.Lines.Clear;
  OracleScript.Lines.LoadFromFile(NomeFileStampa);
  for i:=0 to OracleScript.Lines.Count - 1 do
  begin
    S:=(StringReplace(OracleScript.Lines[i],'<:APPLICAZIONE>',Parametri.Applicazione,[]));
    OracleScript.Lines[i]:=S;
    if NomeStampa = '' then
    begin
      P:=Pos(';',S);
      if P > 0 then
      begin
        NomeStampa:=Copy(OracleScript.Lines.Text,Pos('(''',OracleScript.Lines.Text) + 2,Length(OracleScript.Lines.Text));
        NomeStampa:=Copy(NomeStampa,1,Pos('''',NomeStampa) - 1);
      end;
    end;
  end;
  OracleScript.Execute;
  if OracleScript.Output.Count > 0 then
  begin
    Result.Assign(OracleScript.Output);
  end;
  OracleScript.Output.Clear;
  OracleScript.Lines.Clear;

  SessioneOracle.Commit;
  selT909.Refresh;
  ElencoDatiCalcolati;
  A000AggiornaFiltroDizionario('GENERATORE DI STAMPE','',NomeStampa);
  S:=FSelT910_Funzioni.FieldByName('CODICE').AsString;
  FSelT910_Funzioni.Refresh;
  FSelT910_Funzioni.SearchRecord('CODICE',S,[srFromBeginning]);
  FSelT910_Funzioni.SearchRecord('CODICE',NomeStampa,[srFromBeginning]);
end;

function TR003FGeneratoreStampeMW.CreaNomeTabella(InNome:String;DaData,AData:TDateTime):String;
var Nome:String;
begin
  Result:='';
  Nome:=InNome;
  while Copy(Nome,1,1) = '_' do
    Nome:=Copy(Nome,2,Length(Nome));

  Nome:=StringReplace(Nome,':UTENTE','''' + Parametri.Operatore + '''',[rfIgnoreCase]);
  if pos('''',Nome) <= 0 then
    Nome:='''' + Nome + '''';

  generaNomeTab.SQL.Clear;
  generaNomeTab.DeleteVariables;
  generaNomeTab.SQL.Add('SELECT ' + Nome + ' AS TABNAME FROM DUAL');
  if pos(':DAL',UpperCase(Nome)) > 0 then
  begin
    generaNomeTab.DeclareVariable(':DAL',otDate);
    generaNomeTab.SetVariable(':DAL',DaData);
  end;
  if pos(':AL',UpperCase(Nome)) > 0 then
  begin
    generaNomeTab.DeclareVariable(':AL',otDate);
    generaNomeTab.SetVariable(':AL',AData);
  end;
  generaNomeTab.Close;
  try
    generaNomeTab.Open;
    Result:=generaNomeTab.FieldByName('TABNAME').AsString.ToUpper;
  except
    on E:Exception do
      raise Exception.Create('Nome della tabella non valido!' + #13#10 + E.Message);
  end;
end;

Function TR003FGeneratoreStampeMW.SQLInterrogazioniServizio(DaData, AData: TDateTime):String;
var Select, OrderBy, Campo, Tabella:String;
  function PulisciCampo(CampoIn,BadChar:String):String;
  var i:Integer;
  begin
    Result:='';
    for i:=1 to Length(CampoIn) do
      if pos(CampoIn[i],BadChar) <= 0 then
        Result:=Result + CampoIn[i];
  end;
begin
  Result:='';
  Tabella:=CreaNomeTabella(FSelT910_Funzioni.FieldByName('TABELLA_GENERATA').AsString,DaData, AData);
  if Trim(Tabella) <> '' then
  begin
    //Costruzione Select
    if FSelT910_Funzioni.FieldByName('CODICE').AsString <> Q911.GetVariable('CODICE') then
    begin
      Q911.Close;
      Q911.SetVariable('CODICE',FSelT910_Funzioni.FieldByName('CODICE').AsString);
    end;
    Q911.Open;
    Q911.First;
    Select:='';
    while Not Q911.Eof do
    begin
      //Campo:=PulisciCampo(Q911.FieldByName('NOME').AsString,'," ');
      Campo:=Identificatore(Q911.FieldByName('NOME').AsString);
      Select:=Select + Campo;
      if Campo <> Q911.FieldByName('CAPTION').AsString then
      begin
        Campo:=PulisciCampo(Q911.FieldByName('CAPTION').AsString,',"');
        Campo:=PulisciCampo(Campo,':');
        Campo:=Trim(Campo);
        if Campo <> '' then
          Select:=Select + ' "' + Campo + '"';
      end;
      Q911.Next;
      if Not Q911.Eof then
        Select:=Select + ', ';
    end;

    //Costruzione Order BY
    if FSelT910_Funzioni.FieldByName('CODICE').AsString <> Q912.GetVariable('CODICE') then
    begin
      Q912.Close;
      Q912.SetVariable('CODICE',FSelT910_Funzioni.FieldByName('CODICE').AsString);
    end;
    Q912.Open;
    Q912.First;
    OrderBy:='';
    while Not Q912.Eof do
    begin
      //Campo:=PulisciCampo(Q912.FieldByName('NOME').AsString,'," ');
      Campo:=Identificatore(Q912.FieldByName('NOME').AsString);
      OrderBy:=OrderBy + Campo;
      Q912.Next;
      if Not Q912.Eof then
        OrderBy:=OrderBy + ', ';
    end;

    Result:='select ' + Select + #13#10 + '  from T920' + Tabella;
    if OrderBy <> '' then
      Result:=Result + #13#10 + ' order by ' + OrderBy;
  end;
end;

procedure TR003FGeneratoreStampeMW.DataModuleDestroy(Sender: TObject);
var
  i:Integer;
begin
  InizializzaVariabili(True);
  for i:=0 to High(Serbatoi) do
    Serbatoi[i].lst.Free;
  SetLength(Serbatoi,0);

  SetLength(Dati,0);
  FreeAndNil(lstOperatoriSQL);
  FreeAndNil(lstFunzioniSQL);
  FreeAndNil(PeriodoProva);
  InizializzaTotali(0);
  InizializzaTotali(1);
  SetLength(DatiStampa,0);
  SetLength(TabelleCollegate,0);
  SetLength(VariazioniFormato,0);
  SetLength(OpzioniAvanzate,0);
  inherited;
end;

end.
