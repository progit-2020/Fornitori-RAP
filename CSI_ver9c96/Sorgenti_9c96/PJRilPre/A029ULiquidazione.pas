unit A029ULiquidazione;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, R450, C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia, OracleData,
  Oracle,  Variants, Math, A075UFineAnnoDtM1, RegistrazioneLog,
  A029UBudgetDtM1,A000UMessaggi;

type
  TA029FLiquidazione = class(TDataModule)
    Q071Liq: TOracleDataSet;
    Q130: TOracleDataSet;
    Q071LiqPROGRESSIVO: TFloatField;
    Q071LiqDATA: TDateTimeField;
    Q071LiqMAGGIORAZIONE: TFloatField;
    Q071LiqCODFASCIA: TStringField;
    Q071LiqORESTRAORDLIQ: TStringField;
    Q071LiqLIQUIDNELMESE: TStringField;
    selLiquidato: TOracleQuery;
    procedure A029FLiquidazioneCreate(Sender: TObject);
    procedure A029FLiquidazioneDestroy(Sender: TObject);
  private
    function CercaFasciaLiq(Maggiorazione,NumFascia,MeseC,M,Liquidato:Integer; CodFascia:String):Integer;
  public
    A029FBudgetDtM1: TA029FBudgetDtM1;
    LiqT070,LiqT071Anno,LiqT071Mese,LiqT075Anno,LiqT075Mese:Integer;
    LiqT074Anno,LiqT074Mese(*,ResoT074Mese*):Integer;
    AssT071Anno,AssT071Mese:Integer;
    (*ResoT074Mese è stato sostituito da R450DtM.GetOreCausLiqSenzaLimiti*)
    R450DtM:TR450DtM1;
    procedure Liquidazione(const PModalitaSimulazione: Boolean; Data:TDateTime; Progressivo,Maggiorazione,Liquidato:Integer; CodFascia:String);
    function LimiteIndividualeStraordinario(Prog,Liquidato,LiquidatoMM,CompLiquidato:Integer; Data:TDateTime): String;
    procedure GetOreLiquidate(Prog:Integer; Data:TDateTime);
    procedure AggiornaResiduiBancaOre(P,Anno,Ore:Integer);
    procedure AggiornaResiduiSuccessivi(Progressivo,Anno:Integer);
  end;

(* Caratto 07/05/2013. Rimozione variabile globale
var
  A029FLiquidazione: TA029FLiquidazione;
*)
implementation

{$R *.DFM}

procedure TA029FLiquidazione.A029FLiquidazioneCreate(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  A029FBudgetDtM1:=TA029FBudgetDtM1.Create(nil);
end;

procedure TA029FLiquidazione.GetOreLiquidate(Prog:Integer; Data:TDateTime);
begin
  LiqT070:=0;
  LiqT071Anno:=0;
  LiqT071Mese:=0;
  LiqT074Anno:=0;
  LiqT074Mese:=0;
  //ResoT074Mese:=0;
  LiqT075Anno:=0;
  LiqT075Mese:=0;
  AssT071Anno:=0;
  AssT071Mese:=0;
  with selLiquidato do
  begin
    SetVariable('Progressivo',Prog);
    SetVariable('Data1',EncodeDate(R180Anno(Data),1,1));
    SetVariable('Data2',EncodeDate(R180Anno(Data),12,31));
    SetVariable('Data',Data);
    Execute;
    LiqT070:=GetVariable('COMPLIQUIDATOANNO');       //Banca ore
    LiqT071Anno:=GetVariable('LIQUIDATOANNO');       //Straordinario
    LiqT071Mese:=GetVariable('LIQUIDATOMESE');
    LiqT074Anno:=GetVariable('CAUSLIQUIDATOANNO');   //Causali di presenza incluse/escluse
    LiqT074Mese:=GetVariable('CAUSLIQUIDATOMESE');
    //ResoT074Mese:=GetVariable('CAUSRESOMESE');
    LiqT075Anno:=GetVariable('STRAORDESTERNOANNO');
    LiqT075Mese:=GetVariable('STRAORDESTERNOMESE');
    AssT071Anno:=GetVariable('CAUSASSESTANNO');      //Causali di assestamento
    AssT071Mese:=0;//GetVariable('CAUSASSESTMESE');  //Alberto 09/05/2009: le ore di assestamento non partecipano ai controlli mensili
  end;
  //Se viene gestita la banca ore limitata al max straord.liquidabile annuale,
  //il controllo della liquidazione viene fatto sul valore maggiore tra la banca ore maturata
  //e quella liquidata
  //if (R450DtM.BancaOre = 'S') and (R450DtM.BancaOreLimitataStrLiquidabile = 'S') then
  if (R450DtM.BancaOre = 'S') and (R450DtM.BancaOreLimitataStrLiquidabile = 'S') and (R450DtM.BancaOreContrLiquidaz = 'M') then
    LiqT070:=Max(R450DtM.BancaOreAnno,LiqT070);
end;

function TA029FLiquidazione.LimiteIndividualeStraordinario(Prog,Liquidato,LiquidatoMM,CompLiquidato:Integer; Data:TDateTime): String;
{Controllo il supero dei tetti individuali annuali e mensili}
var
  BancaOreLiq,
  GiaLiq,
  Straord,
  StraordMax: Integer;
begin
  Result:='';
  GetOreLiquidate(Prog,Data);
  //Controllo disponibilità annuale
  //Se viene gestita la banca ore limitata al max straord.liquidabile annuale,
  //nel controllo della liquidazione entrando già il valore della banca ore maturata
  //non si considera più quella liquidata
  if (R450DtM.BancaOre = 'S') and (R450DtM.BancaOreLimitataStrLiquidabile = 'S') and (R450DtM.BancaOreContrLiquidaz = 'M') then
    BancaOreLiq:=0
  else
    BancaOreLiq:=CompLiquidato;

  GiaLiq:=LiqT070 + LiqT071Anno + LiqT074Anno + AssT071Anno;
  Straord:=Liquidato + BancaOreLiq + GiaLiq;
  StraordMax:=R450DtM.EccAutAnno['LIQUIDABILE'] + R450DtM.EccAutAnno['CAUSALIZZATO'];
  if Straord > StraordMax then
  begin
    Result:=Result +
            Format(A000MSG_A029_ERR_FMT_DISP_ANN,[R180MinutiOre(Straord),  R180MinutiOre(StraordMax),R180MinutiOre(StraordMax - GiaLiq)])
            + CRLF + CRLF;
  end;
  //Controllo disponibilità mensile
  //if (Liquidato + LiqT071Mese + LiqT074Mese + AssT071Mese - LiqT075Mese - R450DtM.OreCausLiqSenzaLimiti) > R450DtM.StrAutMen then
  GiaLiq:=LiqT071Mese + LiqT074Mese + AssT071Mese;
  Straord:=LiquidatoMM + GiaLiq;
  StraordMax:=R450DtM.StrAutMen + LiqT075Mese + R450DtM.OreCausLiqSenzaLimiti;
  if Straord > StraordMax then
  begin
    Result:=Result +
            Format(A000MSG_A029_ERR_FMT_DISP_MENS,[R180MinutiOre(Straord),  R180MinutiOre(StraordMax),R180MinutiOre(StraordMax - GiaLiq)])
            + CRLF + CRLF;
  end;
end;

procedure TA029FLiquidazione.Liquidazione(const PModalitaSimulazione: Boolean; Data:TDateTime; Progressivo,Maggiorazione,Liquidato:Integer; CodFascia:String);
{Liquida le ore specificate nella fascia con maggiorazione specificata;
Se Maggiorazione = -1 significa aggiornamento automatico con questo criterio:
se Liquidato > 0 (liqidazione) parto da Gennaio e dalle fasce + alte,
se Liquidato < 0 (storno) parto dal mese corrente e dalle fasce + basse}
var Anno,M,Mese1,Mese2,(*MeseC,*)G,NumFascia:Word;
    AInizio,MInizio,GInizio:Word;
    MeseC,Incremento,Indice:ShortInt;
    Liquidabile,Tot(*,OrigLiq*):Integer;
begin
  //OrigLiq:=0;
  DecodeDate(Data,Anno,M,G);
  DecodeDate(R450DtM.selT430.FieldByName('Inizio').AsDateTime,AInizio,MInizio,GInizio);
  if Liquidato > 0 then
  begin
    if (Anno = AInizio) then
      Mese1:=MInizio
    else
      Mese1:=1;
    Mese2:=M;
    Incremento:=1;
  end
  else
  begin
    Mese1:=M;
    if (Anno = AInizio) then
      Mese2:=MInizio
    else
      Mese2:=1;
    Incremento:= -1;
  end;
  //Alberto 5/9/2000: liquidazione non distribuita
  R450DtM.Anno400:=Anno;
  R450DtM.Mese400:=M;
  R450DtM.progress400:=Progressivo;
  R450DtM.TipoConteggio;
  if R450DtM.LiquidazioneDistribuita = 'N' then
  begin
    Mese1:=M;
    Mese2:=M;
  end;
  NumFascia:=1;

  if PModalitaSimulazione then
  begin
    A029FBudgetDtM1.CtrlLiqClear;
  end
  else
  begin
    RegistraLog.SettaProprieta('M','T071_SCHEDAFASCE',Copy(Name,1,4),nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(Progressivo),'');
    RegistraLog.InserisciDato('DATA',DateToStr(Data),'');
  end;

  // ciclo sui mesi
  while Liquidato <> 0 do
  begin
    MeseC:=Mese1 - Incremento;
    Tot:=0;
    repeat
      inc(MeseC,Incremento);
      //Richiamo i conteggi precedenti
      R450DtM.ConteggiMese('Generico',Anno,MeseC,Progressivo);
      //Se non esiste la scheda o comunque non ci sono fasce passo al mese successivo
      if (R450DtM.NFasceMese = 0) or (R450DtM.ttrovscheda[MeseC] = 0) then
        Continue;
      Q071Liq.Close;
      Q071Liq.SetVariable('Data',EncodeDate(Anno,MeseC,1));
      //Apro la query solo se posso fare la liquidazione
      Liquidabile:=CercaFasciaLiq(Maggiorazione,NumFascia,MeseC,M,Liquidato,CodFascia);
      if Liquidabile <> 0 then
      begin
        Tot:=Tot + Liquidabile;
        Q071Liq.Edit;
        Q071Liq.FieldByName('OreStraordLiq').AsString:=R180MinutiOre(R180OreMinutiExt(Q071Liq.FieldByName('OreStraordLiq').AsString) + Liquidabile);
        // in modalità simulazione non salva i log
        if not PModalitaSimulazione then
          RegistraLog.InserisciDato('ORESTRAORDLIQ(' + Q071Liq.FieldByName('CODFASCIA').AsString + ')',
                                    Q071Liq.FieldByName('OreStraordLiq').OldValue,
                                    Q071Liq.FieldByName('OreStraordLiq').Value);
        Q071Liq.Post;
        Liquidato:=Liquidato - Liquidabile;

        // in modalità simulazione non effettua la commit
        SessioneOracle.ApplyUpdates([Q071Liq],not PModalitaSimulazione);
      end;
      //Se ho finito la liquidazione esco dal ciclo dei mesi
      if Liquidato = 0 then
        Break;
    until MeseC = Mese2;

    //Per liquidazione automatica scrivo il liquidato in LIQUIDNELMESE
    if (Maggiorazione = -1) and (Tot <> 0) then
    begin
      with Q071Liq do
      begin
        if Tot > 0 then
          Indice:=R450DtM.NFasceMese - NumFascia + 1
        else
          Indice:=NumFascia;
        Close;
        SetVariable('Data',EncodeDate(Anno,M,1));
        SetVariable('Maggiorazione',R450DtM.tmaggioraz[Indice]);
        SetVariable('CodFascia',R450DtM.tfasce[Indice]);
        Open;
        // in modalità simulazione carica la struttura dati per calcolare l'importo corrispondente
        if PModalitaSimulazione then
        begin
          A029FBudgetDtM1.CtrlLiqAdd(TIPOLIQ,Q071Liq.FieldByName('MAGGIORAZIONE').AsInteger,Tot);
        end;
        Edit;
        FieldByName('LiquidNelMese').AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName('LiquidNelMese').AsString) + Tot);
        // in modalità simulazione non salva i log
        if not PModalitaSimulazione then
          RegistraLog.InserisciDato('LIQUIDNELMESE(' + FieldByName('CODFASCIA').AsString + ')',
                                    FieldByName('LiquidNelMese').OldValue,
                                    FieldByName('LiquidNelMese').Value);
        Post;
        // in modalità simulazione non effettua la commit
        SessioneOracle.ApplyUpdates([Q071Liq],not PModalitaSimulazione);
      end;
    end;
    if (Liquidato < 0) then
    begin
      if ((Maggiorazione = -1) and (NumFascia = R450DtM.NFasceMese)) or
         (Maggiorazione >= 0) then
        Liquidato:=0;
    end;
    //Incremento la fascia
    if Maggiorazione = -1 then
      inc(NumFascia);
  end;

  if PModalitaSimulazione then
  begin
    // rollback delle operazioni simulate
    SessioneOracle.Rollback;
  end
  else
  begin
    // salva i log dopo la commit della liquidazione
    RegistraLog.RegistraOperazione;

    // aggiorna i residui
    AggiornaResiduiSuccessivi(Progressivo,Anno);
  end;
end;

procedure TA029FLiquidazione.AggiornaResiduiSuccessivi(Progressivo,Anno:Integer);
{Aggiorno i residui per gli anni successivi, se ci sono}
var AnnoPrec:Integer;
    A075:TA075FFineAnnoDtM1;
begin
  AnnoPrec:=Anno;
  with TOracleDataset.Create(Self) do
  try
    Session:=Q130.Session;
    SQL.Add('SELECT ANNO FROM T130_RESIDANNOPREC WHERE ');
    SQL.Add('PROGRESSIVO = ' + IntToStr(Progressivo) + ' AND ANNO > ' + IntToStr(Anno));
    SQL.Add('ORDER BY ANNO');
    Open;
    A075:=nil;
    while not Eof do
    begin
      inc(AnnoPrec);
      if (FieldByName('ANNO').AsInteger = AnnoPrec) then
      begin
        if A075 = nil then
          Application.CreateForm(TA075FFineAnnoDtM1, A075);
        try
          A075.A075MW.GeneraResiduiOre(Progressivo,IntToStr(AnnoPrec),True);
        except
          Break;
        end;
      end
      else
        Break;
      Next;
    end;
    if A075 <> nil then
      FreeAndNil(A075);
  finally
    Free;
  end;
end;

procedure TA029FLiquidazione.AggiornaResiduiBancaOre(P,Anno,Ore:Integer);
begin
  //Aggiorno i residui
  with Q130 do
  begin
    SetVariable('Progressivo',P);
    SetVariable('Anno',Anno + 1);
    Open;
    if RecordCount > 0 then
    begin
      Edit;
      FieldByName('SaldoOreLav').AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName('SaldoOreLav').AsString) - Ore);
      FieldByName('OreCompensabili').AsString:=R180MinutiOre(Max(0,R180OreMinutiExt(FieldByName('OreCompensabili').AsString) - Ore));
      FieldByName('Banca_Ore').AsString:=R180MinutiOre(Max(0,R180OreMinutiExt(FieldByName('Banca_Ore').AsString) - Ore));
      Post;
      SessioneOracle.ApplyUpdates([Q130],True);
    end;
    Close;
  end;
end;

function TA029FLiquidazione.CercaFasciaLiq(Maggiorazione,NumFascia,MeseC,M,Liquidato:Integer; CodFascia:String):Integer;
{Ricerco la fascia da modificare}
var Indice:Byte;
begin
  Result:=0;
  if Maggiorazione = -1 then
    //Liquidazione automatica
    begin
    if Liquidato > 0 then
      Indice:=R450DtM.NFasceMese - NumFascia + 1
    else
      Indice:=NumFascia;
    if Indice > R450DtM.NFasceMese then exit;
    end
  else
    //Liquidazione di una fascia
    begin
    for Indice:=1 to R450DtM.NFasceMese do
    begin
      if (R450DtM.tmaggioraz[Indice] = Maggiorazione) and (R450DtM.tfasce[Indice] = CodFascia) then
        Break;
    end;
    if Indice > R450DtM.NFasceMese then
      exit;
    end;
  if Liquidato > 0 then
  //Liquidazione
  begin
    //Result = ancora liquidabile
    Result:=R450DtM.tstrannom[Indice] - R450DtM.tstrliq[Indice];  //voce 'Da liquidare'
    if (Result > R450DtM.tstrmese[Indice]) and (R450DtM.LiquidazioneDistribuita = 'S') then
      Result:=R450DtM.tstrmese[indice];
    //Se devo liquidare di meno di quanto disponibile riduco Result
    if Liquidato < Result then
      Result:=Liquidato;
    //Se liquido su una fascia precisa e sono sul mese corrente liquido tutto
    if (Maggiorazione > -1) and (MeseC = M) then
      Result:=Liquidato
    else
    begin
      //Altrimenti passo al mese successivo
      if Result < 0 then
      begin
        Result:=0;
        exit;
      end
    end
  end
  else
  //Storno
  begin
    if R450DtM.LiquidazioneDistribuita = 'S'then
      Result:=-R450DtM.tstrliqmm[Indice]   //voce 'Liq. del mese' in negativo
    else if Maggiorazione = -1 then
      Result:=-R450DtM.tLiqNelMese[Indice] //voce 'Liq. nel mese' in negativo
    else
      Result:=Liquidato;                    //Se sto liquidando sulla fascia e senza distribuzione,

    //Se devo stornare meno di Result riduco Result
    if Liquidato > Result then
      Result:=Liquidato;
  end;
  //Liquido se c'e' ancora del liquidabile
  if (Result <> 0) then
  begin
    with Q071Liq do
    begin
      SetVariable('Maggiorazione',R450DtM.tmaggioraz[Indice]);
      SetVariable('CodFascia',R450DtM.tfasce[Indice]);
      Open;
    end;
  end;
end;

procedure TA029FLiquidazione.A029FLiquidazioneDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).CloseAll;
    if (Self.Components[i] is TOracleQuery) then
      (Self.Components[i] as TOracleQuery).Close;
  end;
  FreeAndNil(A029FBudgetDtM1);
end;

end.
