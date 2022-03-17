unit A040UPianifRepDtM2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ComCtrls, R004UGESTSTORICODTM, DB, DBClient, Oracle, OracleData,
  A000UCostanti, A000USessione, A000UInterfaccia, USelI010, QueryStorico,
  C180FunzioniGenerali, C700USelezioneAnagrafe, Math, StrUtils;

type
  TTipoStampa = (tsTabellone,
                 tsProspettoDip,
                 tsProspettoRaggr);

  TDettaglioCella = (dtCodice,
                     dtOrario,
                     dtDatoLibero,
                     dtCausAss,
                     dtSiglaAss);

  TSetDettaglioCella = set of TDettaglioCella;

  TTurno = record
    Codice,               // cod. turno
    Descrizione,          // desc. turno
    OraInizio,            // ora inizio turno
    OraFine,              // ora fine turno
    OraInizioNoSep,       // ora inizio turno (formato hhmm)
    OraFineNoSep: String; // ora fine turno   (formato hhmm)
  end;

  TCella = record
    T1,               // codice turno 1
    T2,               // codice turno 2
    T3,               // codice turno 2
    DL,               // dato libero pianificato
    Ass,              // codice causale assenza / sigla per assenza
    Testo: String;    // testo formattato
    MaxLen: Integer;  // numero di caratteri della riga più lunga nella cella
  end;

  TA040FPianifRepDtM2 = class(TR004FGestStoricoDtM)
    cdsPianif: TClientDataSet;
    selT380: TOracleDataSet;
    selT350: TOracleDataSet;
    selT040: TOracleDataSet;
    selT267: TOracleDataSet;
    selT265: TOracleDataSet;
    cdsLegenda: TClientDataSet;
    cdsLegendaCODTURNO: TStringField;
    cdsLegendaDESCTURNO: TStringField;
    cdsLegendaCODCAUS: TStringField;
    cdsLegendaDESCCAUS: TStringField;
    selV010: TOracleDataSet;
    cdsTotPianif: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure selT380FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    // variabili private per le property
    FTipoStampa: TTipoStampa;
    FTipologiaTurno: String; // R = reperibilità, G = guardia
    FDataInizio,
    FDataFine: TDateTime; 
    FElencoTurni,
    FElencoOrari,
    FNomeCampoRaggr,
    FNomeLogicoRaggr,
    FTabellaCampoRaggr,
    FTipoCampoRaggr,
    FNomeCampoDett,
    FNomeLogicoDett,
    FTabellaCampoDett,
    FTipoCampoDett,
    FSiglaAssenza: String;
    FIncludiNonPianificati: Boolean;
    FLengthCampoRaggr,
    FLengthCampoDett,
    FLengthCampoDettStr: Integer;
    FVisualizzaLegenda: Boolean;
    FDettaglioCella: TSetDettaglioCella;
    // altre variabili
    ArrTurni: array of TTurno;
    ElencoTurniArr: array of String;
    ListLegendaCausAss,
    ListLegendaTurni: TStringList;
    FSessioneOracle: TOracleSession;
    selI010: TselI010;
    PBarOffset,PBarLimit: Integer;
    // metodi get/set per proprietà
    function  GetTipoStampa: TTipoStampa;
    procedure SetTipoStampa(Val: TTipoStampa);
    function  GetTipologiaTurno: String;
    procedure SetTipologiaTurno(const Val: String);
    function  GetDataInizio: TDateTime;
    procedure SetDataInizio(Val: TDateTime);
    function  GetDataFine: TDateTime;
    procedure SetDataFine(Val: TDateTime);
    function  GetElencoTurni: String;
    procedure SetElencoTurni(const Val: String);
    function  GetElencoOrari: String;
    procedure SetElencoOrari(const Val: String);
    function  GetIncludiNonPianificati: Boolean;
    procedure SetIncludiNonPianificati(Val: Boolean);
    function  GetNomeCampoRaggr: String;
    procedure SetNomeCampoRaggr(const Val: String);
    function  GetNomeLogicoRaggr: String;
    function  GetTabellaCampoRaggr: String;
    function  GetTipoCampoRaggr: String;
    function  GetLengthCampoRaggr: Integer;
    function  GetNomeCampoDett: String;
    procedure SetNomeCampoDett(const Val: String);
    function  GetNomeLogicoDett: String;
    function  GetTabellaCampoDett: String;
    function  GetTipoCampoDett: String;
    function  GetSiglaAssenza: String;
    procedure SetSiglaAssenza(const Val: String);
    function  GetLengthCampoDett: Integer;
    function  GetLengthCampoDettStr: Integer;
    function  GetDettaglioCella: TSetDettaglioCella;
    procedure SetDettaglioCella(Val: TSetDettaglioCella);
    function  GetVisualizzaLegenda: Boolean;
    procedure SetVisualizzaLegenda(Val: Boolean);
    // gestione progressbar
    {$IFNDEF IRISWEB}
    procedure AzzeraProgresso;
    procedure AggiornaProgresso(Attuale, Totale: Integer);
    procedure LimiteProgresso(Val: Integer);
    procedure SettaProgresso;
    {$ENDIF}
    // gestione dati turni
    procedure GetDatiTurni;
    function  _ArrTurniGetIndex(const Codice: String; p,r:Integer): Integer;
    function  GetTurno(const Codice: String): TTurno;
    // gestione assenze e pianificazioni
    function  IsGiornataAssenza(D: TDateTime; var Causale: String): Boolean;
    procedure LegendaAdd(const Tipo: String; const Chiave: String);
    procedure ApriDatasetPianificazioni;
    // gestione client dataset

    function  ComponiCellaTabellone: TCella;
    procedure CreaFieldRaggruppamento(cds: TClientDataset);
    function  GetNomeCampo(D: TDateTime): String;
    procedure CreaTabellone;
    procedure CreaLegenda;
    procedure CreaProspDip;
    procedure CreaProspRaggr;
  public
    {$IFNDEF IRISWEB}
    PBar: TProgressBar;
    {$ENDIF}
    // gestione client dataset
    function  IsFestivo(const PData: TDateTime): Boolean;
    procedure PreparaDati;
    // proprietà
    property TipoStampa: TTipoStampa read GetTipoStampa write SetTipoStampa;
    property TipologiaTurno: String read GetTipologiaTurno write SetTipologiaTurno;
    property DataInizio: TDateTime read GetDataInizio write SetDataInizio;
    property DataFine: TDateTime read GetDataFine write SetDataFine;
    property ElencoTurni: String read GetElencoTurni write SetElencoTurni;
    property ElencoOrari: String read GetElencoOrari write SetElencoOrari; 
    property IncludiNonPianificati: Boolean read GetIncludiNonPianificati write SetIncludiNonPianificati;
    property NomeCampoRaggr: String read GetNomeCampoRaggr write SetNomeCampoRaggr;
    property NomeLogicoRaggr: String read GetNomeLogicoRaggr;
    property TabellaCampoRaggr: String read GetTabellaCampoRaggr;
    property TipoCampoRaggr: String read GetTipoCampoRaggr;
    property LengthCampoRaggr: Integer read GetLengthCampoRaggr;
    property NomeCampoDett: String read GetNomeCampoDett write SetNomeCampoDett;
    property NomeLogicoDett: String read GetNomeLogicoDett;
    property TabellaCampoDett: String read GetTabellaCampoDett;
    property TipoCampoDett: String read GetTipoCampoDett;
    property LengthCampoDett: Integer read GetLengthCampoDett;
    property LengthCampoDettStr: Integer read GetLengthCampoDettStr;
    property SiglaAssenza: String read GetSiglaAssenza write SetSiglaAssenza;
    property DettaglioCella: TSetDettaglioCella read GetDettaglioCella write SetDettaglioCella;
    property VisualizzaLegenda: Boolean read GetVisualizzaLegenda write SetVisualizzaLegenda;
  end;

var
  A040FPianifRepDtM2: TA040FPianifRepDtM2;

const
  // tag per la stampa
  // *************************************************************
  // *                  I M P O R T A N T E !                    *
  // *************************************************************
  // * Fatta eccezione per il TAG_NO_PRINT (valore negativo),    *
  // * se è necessario dichiarare altri tag per la stampa        *
  // * utilizzare sempre multipli di 2                           *
  // *************************************************************
  TAG_NO_PRINT:            Integer = -1;
  TAG_EVIDENZIA_FESTIVI: Integer = 2;
  TAG_NO_RIPROPORZIONA:    Integer = 4;

  // lunghezza massima campo di raggruppamento
  MAXWIDTH_CAMPORAGGR: Integer = 30;

implementation

uses A040UPianifRepDtM1;

{$R *.dfm}

procedure TA040FPianifRepDtM2.DataModuleCreate(Sender: TObject);
{ E' possibile specificare come Sender una variabile di tipo TOracleSession,
  che sarà utilizzata come sessione oracle per il dataset e }
var
  i: Integer;
begin
  inherited;
  PBarOffset:=0;
  PBarLimit:=0;
  //selT380.SetVariable('QVISTAORACLE',StringReplace(QVistaOracle,':DataLavoro','T380.DATA',[rfReplaceAll, rfIgnoreCase]));

  // inizializzazione proprietà
  TipoStampa:=tsTabellone;
  TipologiaTurno:='R';
  DataInizio:=R180InizioMese(Parametri.DataLavoro);
  DataFine:=R180FineMese(Parametri.DataLavoro);
  ElencoTurni:='';
  IncludiNonPianificati:=True;
  NomeCampoRaggr:='';
  NomeCampoDett:='';
  SiglaAssenza:='A';
  DettaglioCella:=[];
  VisualizzaLegenda:=False;
  
  // imposta la sessione oracle in base al parametro Sender
  FSessioneOracle:=SessioneOracle;
  if Sender <> nil then
    if Sender is TOracleSession then
    begin
      FSessioneOracle:=TOracleSession(Sender);
      // reimposta la sessione oracle ai componenti oraclequery e dataset
      for i:=0 to Self.ComponentCount - 1 do
      begin
        if Components[i] is TOracleQuery then
          (Components[i] as TOracleQuery).Session:=SessioneOracle;
        if Components[i] is TOracleDataSet then
          (Components[i] as TOracleDataSet).Session:=SessioneOracle;
      end;
    end;

  // apertura dataset campi anagrafici
  selI010:=TselI010.Create(Self);
  selI010.Apri(FSessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,DATA_TYPE,DATA_LENGTH','','NOME_LOGICO');
end;

procedure TA040FPianifRepDtM2.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  SetLength(ArrTurni,0);
  SetLength(ElencoTurniArr,0);
  FreeAndNil(ListLegendaCausAss);
  FreeAndNil(ListLegendaTurni);
  FreeAndNil(selI010);
end;


//****************************************************************************//
//******************   G E S T I O N E   P R O P E R T Y   *******************//
//****************************************************************************//
function TA040FPianifRepDtM2.GetTipoStampa: TTipoStampa;
begin
  Result:=FTipoStampa;
end;

procedure TA040FPianifRepDtM2.SetTipoStampa(Val: TTipoStampa);
begin
  case Val of
    tsTabellone:
      begin
        ElencoTurni:='';
      end;
    tsProspettoDip:
      begin
        IncludiNonPianificati:=False;
        SiglaAssenza:='';
        DettaglioCella:=[];
        VisualizzaLegenda:=False;
      end;
    tsProspettoRaggr:
      begin
        IncludiNonPianificati:=False;
        SiglaAssenza:='';
        DettaglioCella:=[];
        VisualizzaLegenda:=False;
        NomeCampoDett:='';
      end;
  end;
  FTipoStampa:=Val;
end;

function TA040FPianifRepDtM2.GetTipologiaTurno: String;
begin
  Result:=FTipologiaTurno;
end;

procedure TA040FPianifRepDtM2.SetTipologiaTurno(const Val: String);
begin
  FTipologiaTurno:=Val;
end;

function TA040FPianifRepDtM2.GetDataInizio: TDateTime;
begin
  Result:=FDataInizio;
end;

procedure TA040FPianifRepDtM2.SetDataInizio(Val: TDateTime);
begin
  FDataInizio:=Val;
end;

function TA040FPianifRepDtM2.GetDataFine: TDateTime;
begin
  Result:=FDataFine;
end;

procedure TA040FPianifRepDtM2.SetDataFine(Val: TDateTime);
begin
  FDataFine:=Val;
end;

function TA040FPianifRepDtM2.GetElencoTurni: String;
begin
  Result:=FElencoTurni;
end;

procedure TA040FPianifRepDtM2.SetElencoTurni(const Val: String);
{ Imposta l'elenco dei turni da considerare, suddividendoli per comodità
  di gestione in un array
}
var
  i: Integer;
  Lista: TStringList;
begin
  // suddivide i codici e li inserisce nell'array dei turni
  if Val = '' then
  begin
    // 0 elementi
    SetLength(ElencoTurniArr,0);
  end
  else if Pos(',',Val) = 0 then
  begin
    // 1 elemento
    SetLength(ElencoTurniArr,1);
    ElencoTurniArr[0]:=Val;
  end
  else
  begin
    // n > 1 elementi
    Lista:=TStringList.Create();
    try
      Lista.CommaText:=Val;
      SetLength(ElencoTurniArr,Lista.Count);
      for i:=0 to Lista.Count - 1 do
        ElencoTurniArr[i]:=Lista[i];
    finally
      FreeAndNil(Lista);
    end;
  end;
  FElencoTurni:=Val;
end;

function TA040FPianifRepDtM2.GetElencoOrari: String;
begin
  Result:=FElencoOrari;
end;

procedure TA040FPianifRepDtM2.SetElencoOrari(const Val: String);
{ Imposta l'elenco degli orari dei turni da considerare e quindi carica l'array
  contenente l'elenco dei turni per ogni orario
}
var
  i: Integer;
  Lista: TStringList;
  F,Cod: String;
begin
  if Val = '' then
  begin
    ElencoTurni:='';
    Exit;
  end;

  // usa stringlist di appoggio per caricare array di elenco turni
  FElencoTurni:='';
  Lista:=TStringList.Create();
  R180SetVariable(selT350,'TIPOLOGIA',TipologiaTurno);
  F:='and    to_char(ORAINIZIO,''hh24.mi'') = ''%s''' + #13#10 +
     'and    to_char(ORAFINE,''hh24.mi'') = ''%s''';
  try
    Lista.CommaText:=Val;
    SetLength(ElencoTurniArr,Lista.Count);
    for i:=0 to Lista.Count - 1 do
    begin
      ElencoTurniArr[i]:='';
      R180SetVariable(selT350,'FILTRO',Format(F,[Copy(Lista[i],1,5),Copy(Lista[i],7,11)]));
      selT350.Open;
      selT350.First;
      while not selT350.Eof do
      begin
        Cod:=selT350.FieldByName('CODICE').AsString;
        ElencoTurniArr[i]:=ElencoTurniArr[i] + Cod + ',';
        if Pos(',' + Cod + ',',',' + FElencoTurni) = 0 then
          FElencoTurni:=FElencoTurni + Cod + ',';
        selT350.Next;
      end;
      ElencoTurniArr[i]:=Copy(ElencoTurniArr[i],1,Length(ElencoTurniArr[i]) - 1);
    end;
    FElencoTurni:=Copy(FElencoTurni,1,Length(FElencoTurni) - 1);
    FElencoOrari:=Val;
  finally
    FreeAndNil(Lista);
  end;
end;

function TA040FPianifRepDtM2.GetIncludiNonPianificati: Boolean;
begin
  Result:=FIncludiNonPianificati;
end;

procedure TA040FPianifRepDtM2.SetIncludiNonPianificati(Val: Boolean);
begin
  // proprietà significativa solo per tabellone mensile
  if TipoStampa = tsTabellone then
    FIncludiNonPianificati:=Val
  else
    FIncludiNonPianificati:=False;
end;

function TA040FPianifRepDtM2.GetNomeCampoRaggr: String;
begin
  Result:=FNomeCampoRaggr;
end;

procedure TA040FPianifRepDtM2.SetNomeCampoRaggr(const Val: string);
  procedure PulisciProprietaDerivate;
  begin
    FNomeCampoRaggr:='';
    FTabellaCampoRaggr:='';
    FTipoCampoRaggr:='';
    FLengthCampoRaggr:=0;
    FNomeLogicoRaggr:='';  
  end;
begin
  // pulisce informazioni su campo raggruppamento
  if Val = '' then
  begin
    PulisciProprietaDerivate;
    Exit;
  end;

  // estrae i dati collegati al campo di raggruppamento
  try
    if selI010.Active then
    begin
      if selI010.SearchRecord('NOME_CAMPO',Val,[srFromBeginning]) then
      begin
        FNomeCampoRaggr:=Val;
        FTabellaCampoRaggr:=AliasTabella(FNomeCampoRaggr);
        FTipoCampoRaggr:=selI010.FieldByName('DATA_TYPE').AsString;
        FLengthCampoRaggr:=selI010.FieldByName('DATA_LENGTH').AsInteger;
        FNomeLogicoRaggr:=selI010.FieldByName('NOME_LOGICO').AsString;
      end
      else
        raise Exception.Create('campo anagrafico inesistente!');
    end
    else
      raise Exception.Create('selI010: dataset non attivo!');
  except
    on E: Exception do
    begin
      E.Message:='Errore durante l''impostazione del campo anagrafico' + #13#10 +
                 'di raggruppamento ' + Val + #13#10 +
                 'Motivo: ' + E.Message;
      PulisciProprietaDerivate;
      raise;
    end;
  end;
end;

function TA040FPianifRepDtM2.GetNomeLogicoRaggr: String;
begin
  Result:=FNomeLogicoRaggr;
end;

function TA040FPianifRepDtM2.GetTabellaCampoRaggr: String;
begin
  Result:=FTabellaCampoRaggr;
end;

function TA040FPianifRepDtM2.GetTipoCampoRaggr: String;
begin
  Result:=FTipoCampoRaggr;
end;

function TA040FPianifRepDtM2.GetLengthCampoRaggr: Integer;
begin
  Result:=FLengthCampoRaggr;
end;

function TA040FPianifRepDtM2.GetNomeCampoDett: String;
begin
  Result:=FNomeCampoDett;
end;

procedure TA040FPianifRepDtM2.SetNomeCampoDett(const Val: string);
  procedure PulisciProprietaDerivate;
  begin
    FNomeCampoDett:='';
    FTabellaCampoDett:='';
    FTipoCampoDett:='';
    FLengthCampoDett:=0;
    FLengthCampoDettStr:=0;
    FNomeLogicoDett:='';
  end;
begin
  if (Val = '') or
     (TipoStampa <> tsProspettoDip) then
  begin
    PulisciProprietaDerivate;
    Exit;
  end;
  try
    if selI010.Active then
    begin
      if selI010.SearchRecord('NOME_CAMPO',Val,[srFromBeginning]) then
      begin
        FNomeCampoDett:=Val;
        FTabellaCampoDett:=AliasTabella(FNomeCampoDett);
        FTipoCampoDett:=selI010.FieldByName('DATA_TYPE').AsString;
        FLengthCampoDett:=selI010.FieldByName('DATA_LENGTH').AsInteger;
        if FTipoCampoDett = 'VARCHAR2' then
          FLengthCampoDettStr:=FLengthCampoDett
        else if FTipoCampoDett = 'NUMBER' then
          FLengthCampoDettStr:=10  // number: 10 caratteri max
        else if FTipoCampoDett = 'DATE' then
          FLengthCampoDettStr:=19; // date [dd/mm/yyyy hh.mm.ss]: 19 caratteri max
        FNomeLogicoDett:=selI010.FieldByName('NOME_LOGICO').AsString;
      end
      else
        raise Exception.Create('campo anagrafico inesistente!');
    end
    else
      raise Exception.Create('selI010: dataset non attivo!');
  except
    on E: Exception do
    begin
      PulisciProprietaDerivate;
      E.Message:='Errore durante l''impostazione del campo anagrafico' + #13#10 +
                 'di dettaglio ' + Val + #13#10 +
                 'Motivo: ' + E.Message;
      raise;
    end;
  end;
end;

function TA040FPianifRepDtM2.GetNomeLogicoDett: String;
begin
  Result:=FNomeLogicoDett;
end;

function TA040FPianifRepDtM2.GetTabellaCampoDett: String;
begin
  Result:=FTabellaCampoDett;
end;

function TA040FPianifRepDtM2.GetTipoCampoDett: String;
begin
  Result:=FTipoCampoDett;
end;

function TA040FPianifRepDtM2.GetLengthCampoDett: Integer;
begin
  Result:=FLengthCampoDett;
end;

function TA040FPianifRepDtM2.GetLengthCampoDettStr: Integer;
begin
  Result:=FLengthCampoDettStr;
end;

function TA040FPianifRepDtM2.GetSiglaAssenza: String;
begin
  Result:=FSiglaAssenza;
end;

procedure TA040FPianifRepDtM2.SetSiglaAssenza(const Val: String);
begin
  if TipoStampa = tsTabellone then
    FSiglaAssenza:=Val
  else
    FSiglaAssenza:='';
end;

function TA040FPianifRepDtM2.GetDettaglioCella: TSetDettaglioCella;
begin
  Result:=FDettaglioCella;
end;

procedure TA040FPianifRepDtM2.SetDettaglioCella(Val: TSetDettaglioCella);
begin
  if TipoStampa = tsTabellone then
    FDettaglioCella:=Val
  else
    FDettaglioCella:=[];
end;

function TA040FPianifRepDtM2.GetVisualizzaLegenda: Boolean;
begin
  Result:=FVisualizzaLegenda;
end;

procedure TA040FPianifRepDtM2.SetVisualizzaLegenda(Val: Boolean);
begin
  selT265.Close;
  if TipoStampa <> tsTabellone then
    Val:=False;

  // gestione liste per legenda
  if Val then
  begin
    selT265.Open;

    // crea stringlist
    if ListLegendaCausAss = nil then
    begin
      ListLegendaCausAss:=TStringList.Create;
      ListLegendaCausAss.Sorted:=True;
    end;
    if ListLegendaTurni = nil then
    begin
      ListLegendaTurni:=TStringList.Create;
      ListLegendaTurni.Sorted:=True;
    end;

    // crea clientdataset
    if not cdsLegenda.Active then
    begin
      cdsLegenda.CreateDataSet;
      cdsLegenda.LogChanges:=False;
    end;
  end
  else
  begin
    cdsLegenda.Close;
    FreeAndNil(ListLegendaCausAss);
    FreeAndNil(ListLegendaTurni);
  end;
  FVisualizzaLegenda:=Val;
end;


//****************************************************************************//
//***************   G E S T I O N E   P R O G R E S S B A R   ****************//
//****************************************************************************//

{$IFNDEF IRISWEB}
procedure TA040FPianifRepDtM2.AzzeraProgresso;
begin
  PBarOffset:=0;
  PBarLimit:=0;
  if PBar <> nil then
  begin
    PBar.Min:=0;
    PBar.Max:=100;
    PBar.Position:=0;
    PBar.Repaint;
  end;
end;

procedure TA040FPianifRepDtM2.LimiteProgresso(Val: Integer);
var
  NewLim: Integer;
begin
  NewLim:=Val;
  if PBar <> nil then
  begin
    NewLim:=min(NewLim,PBar.Max);
    NewLim:=max(NewLim,PBar.Min);
  end;
  PBarLimit:=NewLim;
end;

procedure TA040FPianifRepDtM2.AggiornaProgresso(Attuale, Totale: Integer);
var
  NewPos: Integer;
begin
  if PBar <> nil then
  begin
    if ((Totale = 0) or (Attuale = 0)) then
      NewPos:=PBarOffset
    else
      NewPos:=PBarOffset + trunc(Attuale * (PBarLimit - PBarOffset) / Totale);
    NewPos:=min(NewPos,PBar.Max);
    NewPos:=max(NewPos,PBar.Min);
    PBar.Position:=NewPos;
    PBar.Repaint;
  end;
end;

procedure TA040FPianifRepDtM2.SettaProgresso;
begin
  if PBar <> nil then
  begin
    if (PBarLimit >= PBar.Min) and
       (PBarLimit <= PBar.Max) then
    begin
      PBar.Position:=PBarLimit;
      PBar.Repaint;
      PBarOffset:=PBarLimit;
    end;
  end;
end;
{$ENDIF}

//****************************************************************************//
//*********************   G E S T I O N E   T U R N I   **********************//
//****************************************************************************//

procedure TA040FPianifRepDtM2.GetDatiTurni;
var
  i: Integer;
  Filtro,Temp: String;
begin
  if (TipoStampa = tsTabellone) and
     (not ((dtCodice in DettaglioCella) or
           (dtOrario in DettaglioCella) or
           (dtDatoLibero in DettaglioCella))) then
    Exit;

  if ElencoTurni = '' then
  begin
    Filtro:='';
    selT350.ReadBuffer:=400;
  end
  else
  begin
    Filtro:='and    CODICE %s';
    Temp:='''' + StringReplace(ElencoTurni,',',''',''',[rfReplaceAll]) + '''';
    if Pos(',',Temp) = 0 then
      Temp:='= ' + Temp
    else
      Temp:='in (' + Temp + ' )';
    Filtro:=StringReplace(Filtro,'%s',Temp,[rfReplaceAll]);
    selT350.ReadBuffer:=R180NumOccorrenzeCar(ElencoTurni,',') + 1;
  end;

  R180SetVariable(selT350,'TIPOLOGIA',TipologiaTurno);
  R180SetVariable(selT350,'FILTRO',Filtro);
  selT350.Open;
  SetLength(ArrTurni,selT350.RecordCount);
  i:=0;
  while not selT350.Eof do
  begin
    ArrTurni[i].Codice:=selT350.FieldByName('CODICE').AsString;
    ArrTurni[i].Descrizione:=selT350.FieldByName('DESCRIZIONE').AsString;
    ArrTurni[i].OraInizio:=R180MinutiOre(R180OreMinuti(selT350.FieldByName('ORAINIZIO').AsDateTime));
    ArrTurni[i].OraFine:=R180MinutiOre(R180OreMinuti(selT350.FieldByName('ORAFINE').AsDateTime));
    ArrTurni[i].OraInizioNoSep:=StringReplace(ArrTurni[i].OraInizio,'.','',[]);
    ArrTurni[i].OraFineNoSep:=StringReplace(ArrTurni[i].OraFine,'.','',[]);
    i:=i + 1;
    selT350.Next;

    {$IFNDEF IRISWEB}AggiornaProgresso(i,selT350.RecordCount);{$ENDIF}
  end;
end;

function TA040FPianifRepDtM2._ArrTurniGetIndex(const Codice: String; p,r:Integer): Integer;
{ Funzione di ricerca dicotomica per l'array dei turni }
var
  q, Res: Integer;
begin
  Res:=-1;

  if (p < r) then
  begin
    q:=(p+r) div 2;
    if (Codice < ArrTurni[q].Codice) then
      Res:=_ArrTurniGetIndex(Codice,p,q-1);
    if (Codice > ArrTurni[q].Codice) then
      Res:=_ArrTurniGetIndex(Codice,q+1,r);
    if (Codice = ArrTurni[q].Codice) then
      Res:=q;
  end
  else if p = r then
  begin
    if ArrTurni[p].Codice = Codice then
      Res:=p
  end
  else
    Res:=-1;
  Result:=Res;
end;

function TA040FPianifRepDtM2.GetTurno(const Codice: String): TTurno;
var
  i: Integer;
begin
  // record fittizio con valori nulli
  Result.Codice:=Codice;
  Result.Descrizione:='';
  Result.OraInizio:='';
  Result.OraFine:='';
  Result.OraInizioNoSep:='';
  Result.OraFineNoSep:='';

  if Codice = '' then
    Exit;

  i:=_ArrTurniGetIndex(Codice,0,High(ArrTurni));
  if i < 0 then
    Exit;

  Result:=ArrTurni[i];
end;

procedure TA040FPianifRepDtM2.FiltroDizionario(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('TURNI REPERIBILITA',DataSet.FieldByName('CODICE').AsString)
end;



//****************************************************************************//
//*******************   G E S T I O N E   A S S E N Z E   ********************//
//****************************************************************************//

function TA040FPianifRepDtM2.IsGiornataAssenza(D: TDateTime; var Causale: String): Boolean;
begin
  Result:=False;
  Causale:='';

  // verifica se nel giorno indicato esiste un giustificativo a giornata intera
  // non di riposo e non di riposo compensativo
  selT040.Open;
  if selT040.RecordCount > 0 then
  begin
    if selT040.SearchRecord('DATA',D,[srFromBeginning]) then
    begin
      Result:=True;
      Causale:=selT040.FieldByName('CAUSALE').AsString;
    end;
  end;
end;



//****************************************************************************//
//******************   C R E A Z I O N E   D A T A S E T   *******************//
//****************************************************************************//
function TA040FPianifRepDtM2.ComponiCellaTabellone: TCella;
{ Compone il dettaglio delle informazioni sul turno in base al dettagliocella }
var
  MaxLen: Integer;
  Orario,Caus: String;
  function FormattaTurno(const Turno,Priorita: String): String;
  var
    T: TTurno;
  begin
    Result:='';

    if Turno = '' then
      Exit;
    if ElencoTurni <> '' then
      if Pos(Turno,ElencoTurni) = 0 then
        Exit;

    // estrae info turno
    T:=GetTurno(Turno);
    LegendaAdd('TURNO',T.Codice);

    // 1. codice
    if dtCodice in DettaglioCella then
    begin
      MaxLen:=Max(MaxLen,Length(T.Codice + IfThen(Priorita <> '',' #' + Priorita)));
      Result:=T.Codice + IfThen(Priorita <> '',' #' + Priorita) + #13#10;
    end;

    // 2. orario nel formato hhmm-hhmm
    if dtOrario in DettaglioCella then
    begin
      Orario:=Format('%s%s%s',[T.OraInizioNoSep,#13#10,T.OraFineNoSep]);
      MaxLen:=Max(MaxLen,4); // 4: formato "hhmm"
      Result:=Result + Orario + #13#10;
    end;

    Result:=Copy(Result,1,Length(Result) - 2);
  end;
  function FormattaAssenza(const Caus: String): String;
  begin
    Result:='';
    if dtCausAss in DettaglioCella then
    begin
      LegendaAdd('CAUS',Caus);
      Result:=Caus;
    end
    else if dtSiglaAss in DettaglioCella then
    begin
      LegendaAdd('CAUS',SiglaAssenza);
      Result:=SiglaAssenza;
    end;
    MaxLen:=Max(MaxLen,Length(Result));
  end;
begin
  MaxLen:=0;
  Result.T1:='';
  Result.T2:='';
  Result.T3:='';
  Result.DL:='';
  Result.Ass:='';

  // verifica se non è richiesto nessun dettaglio
  if DettaglioCella = [] then
  begin
    Result.Testo:='';
    Exit;
  end;

  // dati turno 1
  Result.T1:=FormattaTurno(selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('PRIORITA1').AsString);
  // dati turno 2
  Result.T2:=FormattaTurno(selT380.FieldByName('TURNO2').AsString,selT380.FieldByName('PRIORITA2').AsString);
  // dati turno 3
  Result.T3:=FormattaTurno(selT380.FieldByName('TURNO3').AsString,selT380.FieldByName('PRIORITA3').AsString);
  // dato libero pianificabile
  if dtDatoLibero in DettaglioCella then
    Result.DL:=selT380.FieldByName('DATOLIBERO').AsString;
  // dati assenza
  if (dtCausAss in DettaglioCella) or
     (dtSiglaAss in DettaglioCella) then
  begin
    if IsGiornataAssenza(selT380.FieldByName('DATA').AsDateTime,Caus) then
      Result.Ass:=FormattaAssenza(Caus);
  end;

  // compone il dato
  Result.Testo:=Result.Ass;
  Result.Testo:=Result.Testo + IfThen((Result.Testo <> '') and (Result.T1 <> ''),#13#10) + Result.T1;
  Result.Testo:=Result.Testo + IfThen((Result.Testo <> '') and (Result.T2 <> ''),#13#10) + Result.T2;
  Result.Testo:=Result.Testo + IfThen((Result.Testo <> '') and (Result.T3 <> ''),#13#10) + Result.T3;
  Result.Testo:=Result.Testo + IfThen((Result.Testo <> '') and (Result.DL <> ''),#13#10) + Result.DL;
  Result.MaxLen:=MaxLen;
end;

procedure TA040FPianifRepDtM2.CreaFieldRaggruppamento(cds: TClientDataset);
begin
  if NomeCampoRaggr = '' then
    Exit;

  // determina il tipo campo
  if TipoCampoRaggr = 'VARCHAR2' then
    cds.FieldDefs.Add(NomeCampoRaggr,ftString,LengthCampoRaggr)
  else if TipoCampoRaggr = 'NUMBER' then
    cds.FieldDefs.Add(NomeCampoRaggr,ftInteger)
  else if TipoCampoRaggr = 'DATE' then
    cds.FieldDefs.Add(NomeCampoRaggr,ftDate);
end;

function TA040FPianifRepDtM2.GetNomeCampo(D: TDateTime): String;
const
  Mesi: String = 'ABCDEHLMPRST';
begin
  Result:=Format('GG_%.2d%s',[R180Giorno(D),Mesi[R180Mese(D)]]);
end;

procedure TA040FPianifRepDtM2.PreparaDati;
{ Predispone il client dataset in base ai valori attuali delle proprietà }
begin
  // controllo sul periodo
  if FDataInizio > FDataFine then
    raise Exception.Create('Il periodo indicato non è valido!');
  if R180Anno(FDataInizio) <> R180Anno(FDataFine) then
    raise Exception.Create('Le date devono essere riferite allo stesso anno!');

  // impostazioni progressbar
  {$IFNDEF IRISWEB}AzzeraProgresso;{$ENDIF}
  try
    case TipoStampa of
      tsTabellone:      CreaTabellone;
      tsProspettoDip:   CreaProspDip;
      tsProspettoRaggr: CreaProspRaggr;
    else
      raise Exception.Create('Tipologia di estrazione non supportata!');
    end;
  finally
    {$IFNDEF IRISWEB}AzzeraProgresso;{$ENDIF}
  end;
end;

procedure TA040FPianifRepDtM2.selT380FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=((selT380.FieldByName('TURNO1').IsNull) or
           (A000FiltroDizionario('TURNI REPERIBILITA',selT380.FieldByName('TURNO1').AsString))) and
          ((selT380.FieldByName('TURNO2').IsNull) or
           (A000FiltroDizionario('TURNI REPERIBILITA',selT380.FieldByName('TURNO2').AsString))) and
          ((selT380.FieldByName('TURNO3').IsNull) or
           (A000FiltroDizionario('TURNI REPERIBILITA',selT380.FieldByName('TURNO3').AsString)));
end;

procedure TA040FPianifRepDtM2.ApriDatasetPianificazioni;
// Apre il dataset delle pianificazioni in base ai filtri attualmente impostati
var
  S,Ordinamento,FiltroTurni,OuterJoin,Temp,Temp2: String;
begin
  selT380.Close;
  selT380.ClearVariables;

  // include il campo di raggruppamento nella selezione
  if NomeCampoRaggr <> '' then
  begin
    S:=selT380.SQL.Text;
    if R180InserisciColonna(S,TabellaCampoRaggr + '.' + NomeCampoRaggr) then
      selT380.SQL.Text:=S;
  end;

  // include il campo di dettaglio anagrafico nella selezione
  if NomeCampoDett <> '' then
  begin
    S:=selT380.SQL.Text;
    if R180InserisciColonna(S,TabellaCampoDett + '.' + NomeCampoDett) then
      selT380.SQL.Text:=S;
  end;

  // imposta il filtro turni (vedere anche OnFilterRecord per filtro dizionario)
  if ElencoTurni = '' then
    FiltroTurni:=''
  else
  begin
    Temp:='''' + StringReplace(ElencoTurni,',',''',''',[rfReplaceAll]) + '''';
    if Pos(',',Temp) = 0 then
      Temp:='= ' + Temp
    else
      Temp:='in (' + Temp + ')';

    // se outer join con dipendenti non pianificati si accettano anche le righe con TURNO1,TURNO2 e TURNO3 nulli
    Temp2:=IfThen(IncludiNonPianificati,' or (T380.TURNO1 is null and T380.TURNO2 is null and T380.TURNO3 is null)','');
    FiltroTurni:=Format('and    ((T380.TURNO1 %s or T380.TURNO2 %s or T380.TURNO3 %s)%s)',[Temp,Temp,Temp,Temp2]);
  end;

  // effettua una outer join se si vogliono visualizzare anche i dipendenti non pianificati nel periodo
  OuterJoin:=IfThen(IncludiNonPianificati,'(+)','');

  // applica la selezione anagrafica attuale
  C700MergeSelAnagrafe(selT380,False);
  C700MergeSettaPeriodo(selT380,DataInizio,DataFine);

  // determina ordinamento
  case TipoStampa of
    tsTabellone:      Ordinamento:='T030.PROGRESSIVO,T380.DATA';
    tsProspettoDip:   Ordinamento:='T380.DATA,T030.COGNOME,T030.NOME,T030.MATRICOLA';
    tsProspettoRaggr: Ordinamento:='T380.DATA,T030.COGNOME,T030.NOME,T030.MATRICOLA';
  end;
  if NomeCampoRaggr <> '' then
    Ordinamento:=TabellaCampoRaggr + '.' + NomeCampoRaggr + ',' + Ordinamento;

  // imposta le variabili e apre il dataset
  selT380.SetVariable('TIPOLOGIA',TipologiaTurno);
  selT380.SetVariable('DATADA',DataInizio);
  selT380.SetVariable('DATAA',DataFine);
  selT380.SetVariable('FILTRO_TURNI',FiltroTurni);
  selT380.SetVariable('OUTER_JOIN',OuterJoin);
  selT380.SetVariable('ORDINAMENTO','order by ' + Ordinamento);
  selT380.Open;

  // apre il dataset di supporto per verificare i festivi infrasettimanali
  selV010.Close;
  selV010.SetVariable('DAL',DataInizio);
  selV010.SetVariable('AL',DataFine);
  if selT380.RecordCount > 0 then
    selV010.SetVariable('PROGRESSIVO',selT380.FieldByName('PROGRESSIVO').AsInteger);
  selV010.Open;
end;

function TA040FPianifRepDtM2.IsFestivo(const PData: TDateTime): Boolean;
// determina se la data indicata è una domenica o un festivo infrasettimanale
// nota: per i festivi infrasettimanali utilizza convenzionalmente il calendario
//       del primo dipendente della selezione
begin
  Result:=(DayOfWeek(PData) = 1) or
          ((selV010.Active) and
           (selV010.SearchRecord('DATA;FESTIVO',VarArrayOf([PData,'S']),[srFromBeginning]))
          );
end;

procedure TA040FPianifRepDtM2.LegendaAdd(const Tipo: String; const Chiave: String);
var
  Valore: String;
begin
  if VisualizzaLegenda then
  begin
    if (Tipo = 'CAUS') and
       ((dtCausAss in DettaglioCella) or
        (dtSiglaAss in DettaglioCella)) then
    begin
      // codice - descrizione dell'assenza
      if dtCausAss in DettaglioCella then
        Valore:=VarToStrDef(selT265.Lookup('CODICE',Chiave,'DESCRIZIONE'),'###')
      else if dtSiglaAss in DettaglioCella then
        Valore:='ASSENZA';
      if ListLegendaCausAss.IndexOfName(Chiave) < 0 then
        ListLegendaCausAss.Add(Chiave + '=' + Valore);
    end
    else if (Tipo = 'TURNO') and
            ((dtCodice in DettaglioCella) or (TipoStampa <> tsTabellone)) then
    begin
      // codice - descrizione del turno
      Valore:=VarToStrDef(selT350.Lookup('CODICE',Chiave,'DESCRIZIONE'),'###');
      if ListLegendaTurni.IndexOfName(Chiave) < 0 then
        ListLegendaTurni.Add(Chiave + '=' + Valore);
    end;
  end;
end;

procedure TA040FPianifRepDtM2.CreaTabellone;
// Preparazione dataset per tabellone mensile per raggruppamento
// con calendario in orizzontale
var
  OldProg,MaxLengthCella: Integer;
  CampoGG,Caus,Nominativo: String;
  D,OldData: TDateTime;
  Cella: TCella;
  procedure CompletaPeriodo;
  // Completa la riga del dipendente con le eventuali giornate di assenza
  var
    D: TDateTime;
  begin
    // se i dati delle assenze non sono richiesti termina subito
    if not ((dtCausAss in DettaglioCella) or (dtSiglaAss in DettaglioCella)) then
      Exit;

    // imposta variabili per dataset assenze
    R180SetVariable(selT040,'Progressivo',OldProg);
    selT040.Open;

    // completa il periodo
    D:=DataInizio;
    cdsPianif.Edit;
    while D <= DataFine do
    begin
      CampoGG:=GetNomeCampo(D);
      if (cdsPianif.FieldByName(CampoGG).IsNull) or
         (cdsPianif.FieldByName(CampoGG).AsString = '') then
        // se la giornata è di assenza compone il dato
        if IsGiornataAssenza(D,Caus) then
        begin
          if dtCausAss in DettaglioCella then
          begin
            LegendaAdd('CAUS',Caus);
            cdsPianif.FieldByName(CampoGG).AsString:=Caus;
          end
          else if dtSiglaAss in DettaglioCella then
          begin
            LegendaAdd('CAUS',SiglaAssenza);
            cdsPianif.FieldByName(CampoGG).AsString:=SiglaAssenza;
          end;
          MaxLengthCella:=max(MaxLengthCella,Length(cdsPianif.FieldByName(CampoGG).AsString));
        end;
      D:=D + 1;
    end;
    cdsPianif.Post;
  end;
begin
  // prepara il dataset delle assenze
  if (dtCausAss in DettaglioCella) or
     (dtSiglaAss in DettaglioCella) then
  begin
    selT040.Close;
    selT040.ClearVariables;
    R180SetVariable(selT040,'DataDa',DataInizio);
    R180SetVariable(selT040,'DataA',DataFine);
  end;

  // estrae dati in array di supporto
  {$IFNDEF IRISWEB}LimiteProgresso(30);{$ENDIF}
  GetDatiTurni;
  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}

  // clear delle stringlist di legenda
  if VisualizzaLegenda then
  begin
    ListLegendaCausAss.Clear;
    ListLegendaTurni.Clear;
  end;

  // prepara il dataset di supporto
  ApriDatasetPianificazioni;

  // crea i field del client dataset
  cdsPianif.Close;
  cdsPianif.FieldDefs.Clear;
  if NomeCampoRaggr <> '' then
    CreaFieldRaggruppamento(cdsPianif);
  cdsPianif.FieldDefs.Add('PROGRESSIVO',ftInteger);
  cdsPianif.FieldDefs.Add('MATRICOLA',ftString,8);
  cdsPianif.FieldDefs.Add('COGNOME',ftString,30);
  cdsPianif.FieldDefs.Add('NOME',ftString,30);
  cdsPianif.FieldDefs.Add('NOMINATIVO',ftString,44); // [cognome] [iniz. nome] [(matr)]
  D:=DataInizio;
  while D <= DataFine do
  begin
    CampoGG:=GetNomeCampo(D);
    cdsPianif.FieldDefs.Add(CampoGG,ftString,80);
    D:=D + 1;
  end;

  // predispone indici per il dataset
  cdsPianif.IndexDefs.Clear;
  if NomeCampoRaggr = '' then
    cdsPianif.IndexDefs.Add('Primario',('COGNOME;NOME'),[])
  else
    cdsPianif.IndexDefs.Add('Primario',(NomeCampoRaggr + ';COGNOME;NOME'),[]);
  cdsPianif.IndexName:='Primario';

  // crea dataset e imposta proprietà dei field
  cdsPianif.CreateDataSet;
  cdsPianif.LogChanges:=False;
  if NomeCampoRaggr <> '' then
    cdsPianif.FieldByName(NomeCampoRaggr).Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('PROGRESSIVO').Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('MATRICOLA').Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('COGNOME').Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('NOME').Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('NOMINATIVO').DisplayLabel:='Nominativo';
  cdsPianif.FieldByName('NOMINATIVO').DisplayWidth:=13;
  D:=DataInizio;
  while D <= DataFine do
  begin
    CampoGG:=GetNomeCampo(D);
    cdsPianif.FieldByName(CampoGG).DisplayLabel:=Copy(R180NomeGiorno(D),1,2) + #13#10 +
                                                 Format('%.2d',[R180Giorno(D)]);
    cdsPianif.FieldByName(CampoGG).DisplayWidth:=5; // codice turno: 5 car., codice ass: 5 car., orario: 4 car.
    cdsPianif.FieldByName(CampoGG).Alignment:=taCenter;
    cdsPianif.FieldByName(CampoGG).Tag:=IfThen(IsFestivo(D),TAG_EVIDENZIA_FESTIVI,0); //IfThen(DayOfWeek(D) = 1,TAG_EVIDENZIA_DOMENICHE,0);
    D:=D + 1;
  end;

  // crea i field del client dataset dei totali
  cdsTotPianif.Close;
  cdsTotPianif.FieldDefs.Clear;
  if NomeCampoRaggr <> '' then
    CreaFieldRaggruppamento(cdsTotPianif);
  cdsTotPianif.FieldDefs.Add('PROGRESSIVO',ftInteger);  //fittizio ma serve a mantenere la struttura di cdsPianif
  cdsTotPianif.FieldDefs.Add('MATRICOLA',ftString,8);   //fittizio ma serve a mantenere la struttura di cdsPianif
  cdsTotPianif.FieldDefs.Add('COGNOME',ftString,30);    //fittizio ma serve a mantenere la struttura di cdsPianif
  cdsTotPianif.FieldDefs.Add('NOME',ftString,30);       //fittizio ma serve a mantenere la struttura di cdsPianif
  cdsTotPianif.FieldDefs.Add('NOMINATIVO',ftString,44); //fittizio ma serve a mantenere la struttura di cdsPianif
  D:=DataInizio;
  while D <= DataFine do
  begin
    CampoGG:=GetNomeCampo(D);
    cdsTotPianif.FieldDefs.Add(CampoGG,ftString,80);
    D:=D + 1;
  end;

  // predispone indici per il dataset dei totali
  cdsTotPianif.IndexDefs.Clear;
  cdsTotPianif.IndexName:='';
  if NomeCampoRaggr <> '' then
  begin
    cdsTotPianif.IndexDefs.Add('Primario',(NomeCampoRaggr),[]);
    cdsTotPianif.IndexName:='Primario';
  end;

  // crea dataset dei totali e imposta proprietà dei field
  cdsTotPianif.CreateDataSet;
  cdsTotPianif.LogChanges:=False;
  if NomeCampoRaggr <> '' then
    cdsTotPianif.FieldByName(NomeCampoRaggr).Tag:=TAG_NO_PRINT;
  cdsTotPianif.FieldByName('PROGRESSIVO').Tag:=TAG_NO_PRINT;
  cdsTotPianif.FieldByName('MATRICOLA').Tag:=TAG_NO_PRINT;
  cdsTotPianif.FieldByName('COGNOME').Tag:=TAG_NO_PRINT;
  cdsTotPianif.FieldByName('NOME').Tag:=TAG_NO_PRINT;
  cdsTotPianif.FieldByName('NOMINATIVO').DisplayLabel:='Tot. dip.';
  cdsTotPianif.FieldByName('NOMINATIVO').DisplayWidth:=13;
  D:=DataInizio;
  while D <= DataFine do
  begin
    CampoGG:=GetNomeCampo(D);
    cdsTotPianif.FieldByName(CampoGG).DisplayLabel:='Tot. dip. ' +
                                                    Copy(R180NomeGiorno(D),1,2) + #13#10 +
                                                    Format('%.2d',[R180Giorno(D)]);
    cdsTotPianif.FieldByName(CampoGG).DisplayWidth:=5; // codice turno: 5 car., codice ass: 5 car., orario: 4 car.
    cdsTotPianif.FieldByName(CampoGG).Alignment:=taCenter;
    D:=D + 1;
  end;

  // ciclo di inserimento nel client dataset
  {$IFNDEF IRISWEB}LimiteProgresso(100);{$ENDIF}
  cdsPianif.DisableControls;
  MaxLengthCella:=0;
  OldProg:=-1;
  OldData:=EncodeDate(1900,1,1);
  while not selT380.Eof do
  begin
    if selT380.FieldByName('PROGRESSIVO').AsInteger <> OldProg then
    begin
      if OldProg <> -1 then
        CompletaPeriodo;

      // imposta variabili dataset assenze
      if (dtCausAss in DettaglioCella) or
         (dtSiglaAss in DettaglioCella) then
      begin
        R180SetVariable(selT040,'Progressivo',selT380.FieldByName('PROGRESSIVO').AsInteger);
        selT040.Open;
      end;

      // nominativo visualizzato nel formato "[cognome] [iniziale nome]. ([matricola])"
      Nominativo:=selT380.FieldByName('COGNOME').AsString + ' ' +
                  Copy(selT380.FieldByName('NOME').AsString,1,1) + '.' + #13#10 +
                  '('+ selT380.FieldByName('MATRICOLA').AsString + ')';

      // inserisce un nuovo record
      cdsPianif.Append;
      if NomeCampoRaggr <> '' then
        cdsPianif.FieldByName(NomeCampoRaggr).Value:=selT380.FieldByName(NomeCampoRaggr).Value;
      cdsPianif.FieldByName('PROGRESSIVO').AsInteger:=selT380.FieldByName('PROGRESSIVO').AsInteger;
      cdsPianif.FieldByName('MATRICOLA').AsString:=selT380.FieldByName('MATRICOLA').AsString;
      cdsPianif.FieldByName('COGNOME').AsString:=selT380.FieldByName('COGNOME').AsString;
      cdsPianif.FieldByName('NOME').AsString:=selT380.FieldByName('NOME').AsString;
      cdsPianif.FieldByName('NOMINATIVO').AsString:=Nominativo;
    end
    else
      cdsPianif.Edit;

    // se la data è valorizzata compila la cella con i dati della pianificazione
    // il caso opposto si verifica per effetto dell'outer join
    // (che serve per avere l'elenco di tutti i progressivi)
    if not selT380.FieldByName('DATA').IsNull then
    begin
      CampoGG:=GetNomeCampo(selT380.FieldByName('DATA').AsDateTime);
      Cella:=ComponiCellaTabellone;
      cdsPianif.FieldByName(CampoGG).AsString:=Cella.Testo;
      MaxLengthCella:=max(MaxLengthCella,Cella.MaxLen);
    end;
    cdsPianif.Post;

    if (   (selT380.FieldByName('PROGRESSIVO').AsInteger <> OldProg)
        or (selT380.FieldByName('DATA').AsDateTime <> OldData))
    and not selT380.FieldByName('DATA').IsNull then
    begin
      if NomeCampoRaggr <> '' then
      begin
        if cdsTotPianif.Locate(NomeCampoRaggr,selT380.FieldByName(NomeCampoRaggr).Value,[]) then
          cdsTotPianif.Edit
        else
        begin
          cdsTotPianif.Append;
          cdsTotPianif.FieldByName(NomeCampoRaggr).Value:=selT380.FieldByName(NomeCampoRaggr).Value;
        end;
      end
      else if cdsTotPianif.RecordCount > 0 then
        cdsTotPianif.Edit
      else
        cdsTotPianif.Append;
      cdsTotPianif.FieldByName(CampoGG).AsString:=IntToStr(StrToIntDef(cdsTotPianif.FieldByName(CampoGG).AsString,0) + 1);
      cdsTotPianif.Post;
    end;

    // passa al prossimo record
    OldProg:=selT380.FieldByName('PROGRESSIVO').AsInteger;
    OldData:=selT380.FieldByName('DATA').AsDateTime;
    {$IFNDEF IRISWEB}AggiornaProgresso(selT380.RecNo,selT380.RecordCount);{$ENDIF}
    selT380.Next;
  end; //==> while not eof
  selT380.Close;

  if OldProg <> -1 then
    CompletaPeriodo;
  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}
  
  // adatta width cella tabellone in base alle informazioni contenute
  MaxLengthCella:=max(3,MaxLengthCella);
  D:=DataInizio;
  while D <= DataFine do
  begin
    CampoGG:=GetNomeCampo(D);
    cdsPianif.FieldByName(CampoGG).DisplayWidth:=MaxLengthCella;
    D:=D + 1;
  end;

  cdsPianif.First;
  cdsPianif.EnableControls;

  // se richiesto crea il clientdataset per la legenda
  if VisualizzaLegenda then
    CreaLegenda;
end;

procedure TA040FPianifRepDtM2.CreaLegenda;
// Crea il dataset per la legenda di turni e assenze
var
  i: Integer;
begin
  cdsLegenda.DisableControls;
  cdsLegenda.EmptyDataSet;

  // turni pianificati
  cdsLegenda.FieldByName('CODTURNO').Visible:=(ListLegendaTurni.Count > 0);
  cdsLegenda.FieldByName('DESCTURNO').Visible:=(ListLegendaTurni.Count > 0);
  if ListLegendaTurni.Count > 0 then
  begin
    for i:=0 to ListLegendaTurni.Count - 1 do
    begin
      cdsLegenda.Append;
      cdsLegenda.FieldByName('CODTURNO').AsString:=ListLegendaTurni.Names[i];
      cdsLegenda.FieldByName('DESCTURNO').AsString:=ListLegendaTurni.ValueFromIndex[i];
      cdsLegenda.Post;
    end;
    cdsLegenda.First;
  end;

  // causali di assenza
  cdsLegenda.FieldByName('CODCAUS').Visible:=(ListLegendaCausAss.Count > 0);
  cdsLegenda.FieldByName('DESCCAUS').Visible:=(ListLegendaCausAss.Count > 0);
  for i:=0 to ListLegendaCausAss.Count - 1 do
  begin
    if cdsLegenda.Eof then
      cdsLegenda.Append
    else
      cdsLegenda.Edit;
    cdsLegenda.FieldByName('CODCAUS').AsString:=ListLegendaCausAss.Names[i];
    cdsLegenda.FieldByName('DESCCAUS').AsString:=ListLegendaCausAss.ValueFromIndex[i];
    cdsLegenda.Post;
    cdsLegenda.Next;
  end;
  cdsLegenda.EnableControls;
  cdsLegenda.First;
end;

procedure TA040FPianifRepDtM2.CreaProspDip;
// Preparazione dataset per prospetto mensile per dipendente
//  con calendario in verticale
var
  i,p,NTurno: Integer;
  Nominativo,Dettaglio,CampoTn,ValCampoTn: String;
  T: TTurno;
  OldData: TDateTime;
  OldCampoRaggr,TempCampoRaggr: Variant;
  PrimaVolta,Rottura: Boolean;
const
  MAX_NOMINATIVI_TURNO = 6;

  procedure CompletaPeriodo(ValoreRaggr: Variant; Dal,Al: TDateTime);
  var
    D: TDateTime;
  begin
    D:=Dal;
    while D <= Al do
    begin
      cdsPianif.Append;
      if NomeCampoRaggr <> '' then
        cdsPianif.FieldByName(NomeCampoRaggr).Value:=ValoreRaggr;
      cdsPianif.FieldByName('DATA').AsDateTime:=D;
      cdsPianif.FieldByName('DD').AsString:=FormatDateTime('dd',D);
      cdsPianif.FieldByName('GG').AsString:=FormatDateTime('ddd dd',D);//Copy(R180NomeGiorno(D),1,3);
      cdsPianif.Post;
      D:=D + 1;
      {$IFNDEF IRISWEB}AggiornaProgresso(trunc(D),trunc(Al));{$ENDIF}
    end;
  end;
begin
  if ElencoTurni = '' then
    raise Exception.Create('Nessun turno specificato!');

  {$IFNDEF IRISWEB}LimiteProgresso(10);{$ENDIF}
  GetDatiTurni;
  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}

  // crea i field del client dataset
  cdsPianif.Close;
  cdsPianif.FieldDefs.Clear;
  if NomeCampoRaggr <> '' then
    CreaFieldRaggruppamento(cdsPianif);
  cdsPianif.FieldDefs.Add('DATA',ftDate);
  cdsPianif.FieldDefs.Add('DD',ftString,2);
  cdsPianif.FieldDefs.Add('GG',ftString,6{3});
  for i:=0 to High(ElencoTurniArr) do
  begin
    cdsPianif.FieldDefs.Add(Format('TURNO_%.1d',[i]),ftString,(33 + 2) * MAX_NOMINATIVI_TURNO); // nominativo = 33 caratteri * MAX_NOMINATIVI_TURNO
    if NomeCampoDett <> '' then
      cdsPianif.FieldDefs.Add(Format('TURNO_%.1d_DETT',[i]),ftString,(LengthCampoDettStr + 2) * MAX_NOMINATIVI_TURNO);
  end;

  // predispone indici per il dataset
  cdsPianif.IndexDefs.Clear;

  if NomeCampoRaggr = '' then
    cdsPianif.IndexDefs.Add('Primario','DATA',[])
  else
    cdsPianif.IndexDefs.Add('Primario',NomeCampoRaggr + ';DATA',[]);
  cdsPianif.IndexName:='Primario';

  // crea dataset e imposta proprietà dei field
  {$IFNDEF IRISWEB}LimiteProgresso(20);{$ENDIF}
  cdsPianif.CreateDataSet;
  cdsPianif.LogChanges:=False;
  if NomeCampoRaggr <> '' then
    cdsPianif.FieldByName(NomeCampoRaggr).Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('DATA').Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('DD').DisplayLabel:=' ';
  cdsPianif.FieldByName('DD').DisplayWidth:=3;
  cdsPianif.FieldByName('DD').Tag:=TAG_NO_RIPROPORZIONA + TAG_EVIDENZIA_FESTIVI;
  cdsPianif.FieldByName('GG').DisplayLabel:=' ';
  cdsPianif.FieldByName('GG').DisplayWidth:=4;
  cdsPianif.FieldByName('GG').Tag:=TAG_NO_RIPROPORZIONA + TAG_EVIDENZIA_FESTIVI;
  for i:=0 to High(ElencoTurniArr) do
  begin
    if ElencoOrari <> '' then
    begin
      // legge il primo turno nell'elenco (in ogni elemento dell'array l'orario è uguale per tutti i turni)
      p:=Pos(',',ElencoTurniArr[i]);
      if p = 0 then
        T:=GetTurno(ElencoTurniArr[i])
      else
        T:=GetTurno(Copy(ElencoTurniArr[i],1,p - 1));
      cdsPianif.FieldByName(Format('TURNO_%.1d',[i])).DisplayLabel:=Format('Turno %s - %s',[T.OraInizio,T.OraFine]);
    end
    else
    begin
      // elenco di codici turno
      T:=GetTurno(ElencoTurniArr[i]);
      cdsPianif.FieldByName(Format('TURNO_%.1d',[i])).DisplayLabel:=Format('Turno %s%s%s - %s',[T.Codice,#13#10,T.OraInizio,T.OraFine]);
    end;
    cdsPianif.FieldByName(Format('TURNO_%.1d',[i])).DisplayWidth:=33;

    if NomeCampoDett <> '' then
    begin
      cdsPianif.FieldByName(Format('TURNO_%.1d_DETT',[i])).DisplayLabel:=NomeLogicoDett;
      cdsPianif.FieldByName(Format('TURNO_%.1d_DETT',[i])).DisplayWidth:=LengthCampoDettStr;
      cdsPianif.FieldByName(Format('TURNO_%.1d_DETT',[i])).Tag:=TAG_NO_RIPROPORZIONA;
    end;
    {$IFNDEF IRISWEB}AggiornaProgresso(i,High(ElencoTurniArr));{$ENDIF}
  end;
  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}
  
  ApriDatasetPianificazioni;

  // ciclo di inserimento nel client dataset
  {$IFNDEF IRISWEB}LimiteProgresso(100);{$ENDIF}
  cdsPianif.DisableControls;
  OldData:=DataInizio - 1;
  OldCampoRaggr:=null;
  PrimaVolta:=True;
  while not selT380.Eof do
  begin
    Rottura:=PrimaVolta;
    if PrimaVolta then
    begin
      // gestione rottura per data se il 1° gg considerato è <> dal 1° gg del periodo)
      if selT380.FieldByName('DATA').AsDateTime <> OldData then
      begin
        if NomeCampoRaggr <> '' then
          TempCampoRaggr:=selT380.FieldByName(NomeCampoRaggr).Value
        else
          TempCampoRaggr:=null;
        CompletaPeriodo(TempCampoRaggr,OldData + 1,selT380.FieldByName('DATA').AsDateTime - 1);
      end;
      PrimaVolta:=False;
    end
    else
    begin
      // gestione rottura per raggruppamento
      if NomeCampoRaggr <> '' then
      begin
        if selT380.FieldByName(NomeCampoRaggr).Value <> OldCampoRaggr then
        begin
          Rottura:=True;
          CompletaPeriodo(OldCampoRaggr,OldData + 1,DataFine);
          OldCampoRaggr:=selT380.FieldByName(NomeCampoRaggr).Value;
          OldData:=DataInizio - 1;
        end;
      end;
      // gestione rottura per data
      if selT380.FieldByName('DATA').AsDateTime <> OldData then
      begin
        Rottura:=True;
        CompletaPeriodo(OldCampoRaggr,OldData + 1,selT380.FieldByName('DATA').AsDateTime - 1);
      end;
    end;

    // nominativo visualizzato nel formato "cognome + iniziale nome"
    Nominativo:=selT380.FieldByName('COGNOME').AsString + ' ' +
                Copy(selT380.FieldByName('NOME').AsString,1,1) + '.';
    // dettaglio anagrafico
    if NomeCampoDett <> '' then
      Dettaglio:=selT380.FieldByName(NomeCampoDett).AsString
    else
      Dettaglio:='';

    if Rottura then
    begin
      cdsPianif.Append;
      if NomeCampoRaggr <> '' then
        cdsPianif.FieldByName(NomeCampoRaggr).Value:=selT380.FieldByName(NomeCampoRaggr).Value;
      cdsPianif.FieldByName('DATA').AsDateTime:=selT380.FieldByName('DATA').AsDateTime;
      cdsPianif.FieldByName('DD').AsString:=FormatDateTime('dd',selT380.FieldByName('DATA').AsDateTime);
      cdsPianif.FieldByName('GG').AsString:=FormatDateTime('ddd dd',selT380.FieldByName('DATA').AsDateTime); //Copy(R180NomeGiorno(selT380.FieldByName('DATA').AsDateTime),1,3);
    end
    else
      cdsPianif.Edit;
    // verifica in quale campo inserire il nominativo
    for i:=0 to High(ElencoTurniArr) do
    begin
      if (Pos(',' + selT380.FieldByName('TURNO1').AsString + ',',',' + ElencoTurniArr[i] + ',' ) > 0) then
        NTurno:=1
      else if (Pos(',' + selT380.FieldByName('TURNO2').AsString + ',',',' + ElencoTurniArr[i] + ',' ) > 0) then
        NTurno:=2
      else if (Pos(',' + selT380.FieldByName('TURNO3').AsString + ',',',' + ElencoTurniArr[i] + ',' ) > 0) then
        NTurno:=3
      else
        NTurno:=0;
      if NTurno > 0 then
      begin
        // aggiunge il nominativo
        CampoTn:=Format('TURNO_%.1d',[i]);
        ValCampoTn:=cdsPianif.FieldByName(CampoTn).AsString;
        cdsPianif.FieldByName(CampoTn).AsString:=IfThen(ValCampoTn <> '',ValCampoTn + #13#10) +
                                                 Nominativo +
                                                 IfThen(not selT380.FieldByName('PRIORITA' + IntToStr(NTurno)).IsNull,' #' + selT380.FieldByName('PRIORITA' + IntToStr(NTurno)).AsString);
        // aggiunge il dettaglio anagrafico
        if NomeCampoDett <> '' then
        begin
          CampoTn:=CampoTn + '_DETT';
          ValCampoTn:=cdsPianif.FieldByName(CampoTn).AsString;
          cdsPianif.FieldByName(CampoTn).AsString:=IfThen(ValCampoTn <> '',ValCampoTn + #13#10) + Dettaglio;
        end;
      end;
    end;

    // salva variabili old per verifica rottura
    if NomeCampoRaggr <> '' then
      OldCampoRaggr:=selT380.FieldByName(NomeCampoRaggr).Value;
    OldData:=selT380.FieldByName('DATA').AsDateTime;

    cdsPianif.Post;
    {$IFNDEF IRISWEB}AggiornaProgresso(selT380.RecNo,selT380.RecordCount);{$ENDIF}
    selT380.Next;
  end;
  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}

  // completa il mese
  CompletaPeriodo(OldCampoRaggr,OldData + 1,DataFine);
  selT380.Close;

  cdsPianif.First;
  cdsPianif.EnableControls;
end;

procedure TA040FPianifRepDtM2.CreaProspRaggr;
// Preparazione dataset per prospetto settimanale
//  con calendario in orizzontale
var
  CampoGG,Nominativo: String;
  D: TDateTime;
  OldCampoRaggr: Variant;
  PrimaVolta,Rottura: Boolean;
begin
  if NomeCampoRaggr = '' then
    raise Exception.Create('E'' necessario indicare un campo di raggruppamento per questa stampa!');

  {$IFNDEF IRISWEB}LimiteProgresso(10);{$ENDIF}
  GetDatiTurni;
  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}

  // crea i field del client dataset
  cdsPianif.Close;
  cdsPianif.FieldDefs.Clear;
  CreaFieldRaggruppamento(cdsPianif);
  D:=DataInizio;
  while D <= DataFine do
  begin
    CampoGG:=GetNomeCampo(D);
    cdsPianif.FieldDefs.Add(CampoGG,ftString,100);
    D:=D + 1;
  end;

  // predispone indici per il dataset
  cdsPianif.IndexDefs.Clear;
  cdsPianif.IndexDefs.Add('Primario',NomeCampoRaggr,[ixPrimary]);
  cdsPianif.IndexName:='Primario';

  // apre i dataset di supporto
  ApriDatasetPianificazioni;

  // crea dataset e imposta proprietà dei field
  cdsPianif.CreateDataSet;
  cdsPianif.LogChanges:=False;
  cdsPianif.FieldByName(NomeCampoRaggr).DisplayWidth:=min(cdsPianif.FieldByName(NomeCampoRaggr).DisplayWidth,30);
  cdsPianif.FieldByName(NomeCampoRaggr).DisplayLabel:=NomeLogicoRaggr;
  D:=DataInizio;
  while D <= DataFine do
  begin
    CampoGG:=GetNomeCampo(D);
    cdsPianif.FieldByName(CampoGG).DisplayWidth:=15;
    cdsPianif.FieldByName(CampoGG).DisplayLabel:=R180NomeGiorno(D) + ' ' + FormatDateTime('dd/mm',D);
    cdsPianif.FieldByName(CampoGG).Tag:=IfThen(IsFestivo(D),TAG_EVIDENZIA_FESTIVI,0); //IfThen(DayOfWeek(D) = 1,TAG_EVIDENZIA_DOMENICHE,0);
    D:=D + 1;                                                
  end;

  // ciclo di inserimento nel client dataset
  {$IFNDEF IRISWEB}LimiteProgresso(100);{$ENDIF}
  cdsPianif.DisableControls;
  OldCampoRaggr:=null;
  PrimaVolta:=True;
  while not selT380.Eof do
  begin
    Rottura:=PrimaVolta;
    if PrimaVolta then
      PrimaVolta:=False;

    // nominativo visualizzato nel formato "cognome + iniziale nome"
    Nominativo:=selT380.FieldByName('COGNOME').AsString + ' ' +
                Copy(selT380.FieldByName('NOME').AsString,1,1) + '.' +
                IfThen(not selT380.FieldByName('PRIORITA1').IsNull,' #' + selT380.FieldByName('PRIORITA1').AsString);

    if selT380.FieldByName(NomeCampoRaggr).Value <> OldCampoRaggr then
      Rottura:=True;

    if Rottura then
    begin
      // inserisce un nuovo record
      cdsPianif.Append;
      cdsPianif.FieldByName(NomeCampoRaggr).Value:=selT380.FieldByName(NomeCampoRaggr).Value;
    end
    else
      cdsPianif.Edit;

    // imposta i dati del giorno nei relativi field
    CampoGG:=GetNomeCampo(selT380.FieldByName('DATA').AsDateTime);
    if cdsPianif.FieldByName(CampoGG).AsString = '' then
      cdsPianif.FieldByName(CampoGG).AsString:=Nominativo
    else
      cdsPianif.FieldByName(CampoGG).AsString:=cdsPianif.FieldByName(CampoGG).AsString + #13#10 + Nominativo;
    cdsPianif.Post;

    // passa al prossimo record
    OldCampoRaggr:=selT380.FieldByName(NomeCampoRaggr).Value;
    selT380.Next;
    {$IFNDEF IRISWEB}AggiornaProgresso(selT380.RecNo,selT380.RecordCount);{$ENDIF}
  end; //==> while not eof

  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}

  selT380.Close;
  cdsPianif.First;
  cdsPianif.EnableControls;
end;


end.
