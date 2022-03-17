unit B021UTimbratureConteggiateDM;

interface

uses
  System.SysUtils, System.Classes, R014URestDM, Oracle, Data.DB, OracleData,
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} C200UWebServicesUtils, B021UUtils, B021UIrisRestSvcDM,
  Rp502Pro, R500Lin, A000USessione, System.Math, C180FunzioniGenerali;

type
  // classe per modellare ogni singola timbrature da esportare
  TTimbraturaCont = class(TPersistent)
  private
    FMatricola: String;
    FBadge: Integer;
    FData: TDateTime;
    FEntrata: String;
    FUscita: String;
    FTipo: String;
    FCausale: String;
    FDescCausale: String;
    FNote: String;
  public
    constructor Create;
  end;

  // classe per modellare il risultato finale contenente l'array di timbrature
  TTimbratureCont = class(TPersistent)
  private
    FDataInizio,
    FDataFine: TDateTime;
    FTimbratureCont: array of TTimbraturaCont;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddTimbratura(T: TTimbraturaCont);
  end;

  TB021FTimbratureConteggiateDM = class(TR014FRestDM)
    selT030: TOracleDataSet;
  private
    Matricola: String;
    Inizio: TDateTime;
    Fine: TDateTime;
    function GetTimbratureCont(PMatricole: String; PInizio, PFine: TDateTime): TJSONObject;
    function GetFiltroMatricole(PMatricole: String): String;
  protected
    function ConvertJSON(PObj: TPersistent): TJSONObject; override;
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function GetDato: TJSONObject; override;
  end;

implementation

{$R *.dfm}

{ TTimbraturaCont }

constructor TTimbraturaCont.Create;
begin
  inherited;
  FMatricola:='';
  FBadge:=0;
  FData:=0;
  FEntrata:='';
  FUscita:='';
  FTipo:='';
  FCausale:='';
  FDescCausale:='';
  FNote:='';
end;

{ TTimbratureCont }

constructor TTimbratureCont.Create;
begin
  SetLength(FTimbratureCont,0);
end;

destructor TTimbratureCont.Destroy;
begin
  SetLength(FTimbratureCont,0);
  inherited;
end;

procedure TTimbratureCont.AddTimbratura(T: TTimbraturaCont);
begin
  SetLength(FTimbratureCont,Length(FTimbratureCont) + 1);
  FTimbratureCont[High(FTimbratureCont)]:=T;
end;

//**********************************************************

function TB021FTimbratureConteggiateDM.GetFiltroMatricole(PMatricole: String): String;
// estrae filtro SQL in base alle matricole indicate
// parametri:
//   PMatricole: String
//     valori ammessi:
//     *                           = tutte le anagrafiche dei turnisti
//     [matricola]                 = singola anagrafica
begin
  if PMatricole = '*' then
  begin
    // * = tutte le anagrafiche dei turnisti
    // il filtro è già operato sul dataset
    Result:='';
  end
  else
  begin
    // matricola singola
    Result:=Format('and    T030.MATRICOLA = ''%s''',[PMatricole]);
  end;
end;

function TB021FTimbratureConteggiateDM.ControlloParametri(var RErrMsg: String): Boolean;
var
  TempStr: String;
begin
  RErrMsg:='';

  if Operazione = OPER_READ then
  begin
    Result:=False;

    // controllo parametri get
    Matricola:=GetParam('matricola');

    TempStr:=GetParam('inizio');
    if not ConvertiStrDate(TempStr,Inizio) then
    begin
      RErrMsg:='Parametro data inizio non valido: ' + TempStr;
      Exit;
    end;

    TempStr:=GetParam('fine');
    if not ConvertiStrDate(TempStr,Fine) then
    begin
      RErrMsg:='Parametro data fine non valido: ' + TempStr;
      Exit;
    end;

    if Fine < Inizio then
    begin
      RErrMsg:='Parametro data fine (' + ConvertiDateStr(Fine) + ') precedente a parametro data inizio (' + ConvertiDateStr(Inizio) + ')';
      Exit;
    end;
  end;

  // controlli ok
  Result:=True;
end;

function TB021FTimbratureConteggiateDM.GetTimbratureCont(PMatricole: String; PInizio, PFine: TDateTime): TJSONObject;
var
  R502ProDtM: TR502ProDtM1;
  ElencoTimb: TTimbratureCont;
  TimbCont: TTimbraturaCont;
  DataCorr: TDateTime;
  i: Integer;
  procedure SetIntestazioneTimbCont(PTimb: TTimbraturaCont);
  begin
    // PRE:
    //   1. selT030 valorizzato e posizionato sul record anagrafico corrente
    //   2. R502ProDtM impostato sui conteggi per il progressivo e la data correnti
    //   3. PTimb creato

    // dati anagrafici uguali su tutte le timbrature
    PTimb.FMatricola:=selT030.FieldByName('MATRICOLA').AsString;
    PTimb.FBadge:=selT030.FieldByName('BADGE').AsInteger;
    PTimb.FData:=R502ProDtM.datacon;

    // verifica anomalie sul giorno
    if (R502ProDtM.Blocca = 0) and (R502ProDtM.n_anom2 < 0) and (R502ProDtM.n_timbrcon = 0) then // n_anom2 vale -1 se non ci sono errori!!
    begin
      // non ci sono timbrature
      PTimb.FTipo:='0';
      PTimb.FCausale:='Assenza';
      PTimb.FDescCausale:='Timbrature mancanti';
    end
    else if (R502ProDtM.Blocca = 0) and (R502ProDtM.n_anom2 < 0) then // n_anom2 vale -1 se non ci sono errori!!
    begin
      // non ci sono anomalie di 1° e 2° livello
      PTimb.FTipo:='0';
      PTimb.FCausale:='Presenza';
      PTimb.FDescCausale:='Presenza';
    end
    else if R502ProDtM.Blocca > 0 then
    begin
      // anomalia di 1° livello
      PTimb.FTipo:='1';
      PTimb.FCausale:='Anomalia bloccante';
      PTimb.FDescCausale:=R502ProDtM.DescAnomaliaBloccante;
    end
    else if R502ProDtM.n_anom2 >= 0 then // n_anom2 vale -1 se non ci sono errori!!
    begin
      // anomalia di 2° livello
      PTimb.FTipo:='2';
      PTimb.FCausale:='Anomalia';
      PTimb.FDescCausale:=R500Lin.tdescanom2[R502ProDtM.tanom2riscontrate[0].ta2puntdesc].D;
    end;
  end;
const
  NOME_PROC = 'GetTimbratureCont';
begin

  Log(NOME_PROC,'esecuzione iniziata');

  // apre il dataset delle timbrature
  selT030.Close;
  selT030.SetVariable('FILTRO_ANAG',GetFiltroMatricole(PMatricole));
  selT030.SetVariable('INIZIO',PInizio);
  selT030.SetVariable('FINE',PFine);
  selT030.ReadBuffer:=IfThen(PMatricole = '*',1000,2);
  selT030.Open;
  Log(NOME_PROC,Format('%d anagrafiche estratte',[selT030.RecordCount]));

  A000SettaVariabiliAmbiente;
  Log(NOME_PROC,'eseguito A000SettaVariabiliAmbiente');

  // prepara l'oggetto Timbrature, che sarà poi convertito in json
  ElencoTimb:=TTimbratureCont.Create;
  try
    // indica periodo di riferimento
    ElencoTimb.FDataInizio:=PInizio;
    ElencoTimb.FDataFine:=PFine;

    while not selT030.Eof do
    begin
      // crea oggetto per conteggi
      R502ProDtM:=TR502ProDtM1.Create(SIW.SessioneOracle);
      Log(NOME_PROC,'R502ProDtM creato');
      try
        // imposta periodo per i conteggi
        R502ProDtM.PeriodoConteggi(PInizio,PFine);
        Log(NOME_PROC,Format('R502ProDtM: eseguito PeriodoConteggi(%s, %s)',[DateToStr(PInizio),DateToStr(PFine)]));

        DataCorr:=PInizio;
        while DataCorr <= PFine do
        begin

          // conteggi per il progressivo e data attuali
          R502ProDtM.Conteggi('Cartolina',selT030.FieldByName('PROGRESSIVO').AsInteger,DataCorr);
          Log(NOME_PROC,Format('R502ProDtM: eseguito Conteggi(''Cartolina'',%d,%s)',[selT030.FieldByName('PROGRESSIVO').AsInteger,DateToStr(DataCorr)]));

          Log(NOME_PROC,Format('sono presenti %d timbrature conteggiate',[R502ProDtM.n_timbrcon]));

          // COMO_HSANNA - commessa 2013/012 SVILUPPO#6 - riesame del 07.04.2014.ini
          // se l'array delle timbrature è vuoto oppure c'è un'anomalia bloccante si crea comunque
          // un elemento senza ora inizio e ora fine, con le altre informazioni valorizzate
          if (R502ProDtM.n_timbrcon = 0) or (R502ProDtM.Blocca > 0) then
          begin
            Log(NOME_PROC,'giorno vuoto o con anomalie: inserimento record con indicazioni');
            // prepara oggetto timbratura da aggiungere all'array
            TimbCont:=TTimbraturaCont.Create;
            SetIntestazioneTimbCont(TimbCont);

            // COMO_HSANNA - commessa 2013/012 SVILUPPO#6 - riesame del 14.04.2014.ini
            // in caso di mancanza di timbrature/anomalia bloccante occorre definire "start" ed "end"
            // come "00:00" invece che stringa vuota.
            TimbCont.FEntrata:='00:00';
            TimbCont.FUscita:='00:00';
            // COMO_HSANNA - commessa 2013/012 SVILUPPO#6 - riesame del 14.04.2014.fine

            // aggiunge timbratura all'array
            ElencoTimb.AddTimbratura(TimbCont);
          end
          else if (R502ProDtM.TipoDetPaumen = 'PMT') and (Length(R502ProDtM.TimbratureMensa) > 0) then
          begin
            TimbCont:=TTimbraturaCont.Create;
            SetIntestazioneTimbCont(TimbCont);
            TimbCont.FTipo:='0';
            TimbCont.FCausale:='Pausa';
            TimbCont.FDescCausale:='Pausa mensa';
            TimbCont.FEntrata:=R180MinutiOre(R502ProDtM.TimbratureMensa[0].I,':');
            TimbCont.FUscita:=R180MinutiOre(R502ProDtM.TimbratureMensa[0].F,':');
            ElencoTimb.AddTimbratura(TimbCont);
          end;

          // COMO_HSANNA - commessa 2013/012 SVILUPPO#6 - riesame del 07.04.2014.fine

          // ciclo sulle timbrature conteggiate
          for i:=1 to R502ProDtM.n_timbrcon do
          begin
            // prepara oggetto timbratura da aggiungere all'array
            TimbCont:=TTimbraturaCont.Create;
            SetIntestazioneTimbCont(TimbCont);

            // dati timbratura (formato hh:mm)
            TimbCont.FEntrata:=R180MinutiOre(R502ProDtM.ttimbraturecon[i].tminutic_e,':');
            if R502ProDtM.ttimbraturecon[i].tminutic_u < 1440 then
              TimbCont.FUscita:=R180MinutiOre(R502ProDtM.ttimbraturecon[i].tminutic_u,':')
            else
              TimbCont.FUscita:=R180MinutiOre(0,':');
            TimbCont.FNote:='';

            ElencoTimb.AddTimbratura(TimbCont);
          end;

          DataCorr:=DataCorr + 1;
        end;
        selT030.Next;
      finally
        FreeAndNil(R502ProDtM);
      end;
    end;
    Result:=ConvertJSON(ElencoTimb);
  finally
    FreeAndNil(ElencoTimb);
  end;
  Log(NOME_PROC,'esecuzione terminata');
end;

function TB021FTimbratureConteggiateDM.ConvertJSON(PObj: TPersistent): TJSONObject;
var
  ElencoTimb: TTimbratureCont;
  TimbArr: TJSONArray;
  hObj: TJSONObject;
  Timb: TTimbraturaCont;
  i: Integer;
begin
  if not Assigned(PObj) then
  begin
    Result:=nil;
    Exit;
  end;

  ElencoTimb:=(PObj as TTimbratureCont);

  Result:=TJSONObject.Create;
  Result.AddPair('start',TJSONString.Create(ConvertiDateStr(ElencoTimb.FDataInizio)));
  Result.AddPair('end',TJSONString.Create(ConvertiDateStr(ElencoTimb.FDataFine)));
  TimbArr:=TJSONArray.Create;
  for i:=0 to High(ElencoTimb.FTimbratureCont) do
  begin
    Timb:=ElencoTimb.FTimbratureCont[i];
    hObj:=TJSONObject.Create;
    hObj.AddPair('id',TJSONString.Create(Timb.FMatricola));
    hObj.AddPair('badge',TJSONString.Create(Timb.FBadge.ToString));
    hObj.AddPair('day',TJSONString.Create(ConvertiDateStr(Timb.FData)));
    hObj.AddPair('type',TJSONString.Create(Timb.FTipo));
    hObj.AddPair('start',TJSONString.Create(Timb.FEntrata));
    hObj.AddPair('end',TJSONString.Create(Timb.FUscita));
    hObj.AddPair('cause',TJSONString.Create(Timb.FCausale));
    hObj.AddPair('description',TJSONString.Create(Timb.FDescCausale));
    hObj.AddPair('note',TJSONString.Create(Timb.FNote));

    TimbArr.Add(hObj);
  end;
  // COMO_HSANNA - commessa 2013/012 SVILUPPO#6 - riesame del 14.04.2014.ini
  //Result.AddPair('timeAttendancePeriods',TimbArr);
  Result.AddPair('timeattendanceperiods',TimbArr);
  // COMO_HSANNA - commessa 2013/012 SVILUPPO#6 - riesame del 14.04.2014.fine
end;

function TB021FTimbratureConteggiateDM.GetDato: TJSONObject;
begin
  Result:=GetTimbratureCont(Matricola,Inizio,Fine);
end;

end.
