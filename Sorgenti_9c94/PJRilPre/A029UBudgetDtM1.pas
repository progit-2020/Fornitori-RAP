unit A029UBudgetDtM1;

interface

uses
  //OracleMonitor,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Math,
  A000UCostanti, A000USessione, A000UInterfaccia, Db, C180FunzioniGenerali, R450, OracleData,
  Oracle, Variants, StrUtils, DBClient;

type
  TProgMesi = record
    Mese: Integer;
    Prog: Integer;
  end;

  TCtrlLiq = record
    Causale: String;      // causale
    Maggiorazione: Real;  // fascia di maggiorazione
    Ore: Integer;         // ore espresse in minuti per la fascia di maggiorazione
    Monetizzazione: Real; // monetizzazione della causale (tariffa_liq)
    Importo: Real;        // importo = ore * monetizzazione
  end;

  TA029FBudgetDtM1 = class(TDataModule)
    QDip: TOracleDataSet;
    upd070: TOracleQuery;
    updT070a: TOracleQuery;
    selT713: TOracleDataSet;
    Q430: TOracleQuery;
    selT714: TOracleDataSet;
    selbT713: TOracleDataSet;
    cdsBudget: TClientDataSet;
    selaV430: TOracleDataSet;
    selBudget1: TOracleQuery;
    selBudget2: TOracleQuery;
    selBudget3: TOracleQuery;
    selBudget4: TOracleQuery;
    selBudget5: TOracleQuery;
    selBudget2Imp: TOracleQuery;
    selBudget7: TOracleQuery;
    selBudget8: TOracleQuery;
    selBudget4Imp: TOracleQuery;
    selBudget5Imp: TOracleQuery;
    selBudget8Imp: TOracleQuery;
    selCtrlBudget: TOracleQuery;
    selBudget7Imp: TOracleQuery;
    procedure A029FBudgetDtM1Create(Sender: TObject);
    procedure A029FBudgetDtM1Destroy(Sender: TObject);
  private
    ProgMesi: array of TProgMesi;
    CtrlLiqArr: array of TCtrlLiq;
    //function GetResiduoLiquidabile:Integer; // funzione commentata poiché non utilizzata
  public
    OreBudgetDisponibile: Integer;
    OreBudgetLiquidato,
    LiqFuoriBudget,
    OreEccedenti: Integer;
    ImpBudgetDisponibile,
    ImpBudgetLiquidato:Real;
    R450DtM:TR450DtM1;
    function  ControllaBudget(const PInterattivo: Boolean; Prog:Integer; Data:TDateTime; POreLiq:Integer; PImpLiq: Real): Boolean;
    function VisualizzaBudget(Prog:Integer; Data:TDateTime) :String;
    procedure PutLiquidatoFuoriBudget(Prog:Integer; Data:TDateTime; Liquidato:Integer);
    procedure PutMaxLiquidatoFuoriBudget(Prog:Integer; Data:TDateTime; MaxLiquidato:Integer);
    procedure GetRaggruppamentiBudget(Prog:Integer; Data:TDateTime; var CodGruppo,FiltroAnagrafe:String);
    procedure PreparaAggiornaFruitoBudget(Data:TDateTime; ElencoTipi:String);
    procedure AggiornaFruitoBudget(Data:TDateTime; Tipo,CodGruppo,FiltroAnagrafe,TipoAggiornamento:String; ForzaQuery:Boolean = True);
    function  GetSituazioneBudget(Data,DIni:TDateTime; Tipo,FiltroAnagrafe:String; var OreFruito:Integer; var ImpFruito:Real; ForzaQuery:Boolean = True):Boolean;
    procedure CtrlLiqClear;
    function  CtrlLiqAdd(const PCausale: String; const PMaggiorazione: Real; const POre: Integer): Integer;
    function  CtrlLiqGetImporto(const PProg: Integer; const PData: TDateTime): Real;
    function  CtrlLiqGetDettaglio: String;
  end;

(* Caratto 07/05/2013. Rimozione variabile globale
var
  A029FBudgetDtM1: TA029FBudgetDtM1;
*)
const
  TIPOLIQ       = '#LIQ#';
  TIPOECC       = '#ECC#';
  TIPOBANCAORE  = '#B.O#';

implementation

{$R *.DFM}

(*
SQL per calcolare lo straordinario liquidato nel CONTRATTO/REPARTO del mese
SELECT MINUTIORE(SUM(OREMINUTI(LIQUIDNELMESE)))
FROM T071_SCHEDAFASCE T071,T430_STORICO T430
WHERE
T071.PROGRESSIVO = T430.PROGRESSIVO AND
TO_DATE('31121999','DDMMYYYY') BETWEEN DATADECORRENZA AND DATAFINE AND
CONTRATTO = '4' AND
REPARTO = '00000' AND
DATA = TO_DATE('01122000','DDMMYYYY')
*)

procedure TA029FBudgetDtM1.A029FBudgetDtM1Create(Sender: TObject);
var i:Integer;
    s:String;
begin
{$IFNDEF IRISWEB}
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  {$ENDIF}
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  //Dichiaro la DataLavoro per i componenti che usano la QVistaOracle
  selBudget2.DeclareVariable('DataLavoro',otDate);
  selBudget3.DeclareVariable('DataLavoro',otDate);
  selBudget4.DeclareVariable('DataLavoro',otDate);
  selBudget5.DeclareVariable('DataLavoro',otDate);
  selBudget7.DeclareVariable('DataLavoro',otDate);
  selBudget8.DeclareVariable('DataLavoro',otDate);
  selBudget2Imp.DeclareVariable('DataLavoro',otDate);
  selBudget4Imp.DeclareVariable('DataLavoro',otDate);
  selBudget5Imp.DeclareVariable('DataLavoro',otDate);
  selBudget7Imp.DeclareVariable('DataLavoro',otDate);
  selBudget8Imp.DeclareVariable('DataLavoro',otDate);

  with Q430 do
  begin
    DeleteVariables;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) N_TROV FROM T430_STORICO T430, :QVISTA');
    SQL.Add('AND :FILTRO_ANAGRAFE_SUB');
    SQL.Add('AND :DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE');
    SQL.Add(':JOIN_V430');
    SQL.Add('AND T430.PROGRESSIVO = :PROGRESSIVO');
    DeclareVariable('FILTRO_ANAGRAFE_SUB',otSubst);
    DeclareVariable('DATA',otDate);
    DeclareVariable('DataLavoro',otDate);
    DeclareVariable('PROGRESSIVO',otInteger);
    DeclareVariable('QVISTA',otSubst);
    DeclareVariable('JOIN_V430',otSubst);
  end;
  with selaV430 do
  begin
    S:=StringReplace(QVistaOracle,
                     ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                     ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                     [rfIgnoreCase]);
    S:=StringReplace(S,
                     ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                     ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                     [rfIgnoreCase]);
    selaV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
  end;
end;

procedure TA029FBudgetDtM1.GetRaggruppamentiBudget(Prog:Integer; Data:TDateTime; var CodGruppo,FiltroAnagrafe:String);
var Filtro:String;
begin
  CodGruppo:='';
  FiltroAnagrafe:='';
  //Ricerca dei gruppi e dei relativi filtri anagrafe ad una certa data
  with selT713 do
  begin
    if Data <> GetVariable('DATA') then
    begin
      Close;
      SetVariable('DATA',Data);
      Open;
    end;
    First;
    while not Eof do
    begin
      //Ricerca del gruppo e del relativo filtro anagrafe in cui è compreso il dipendente
      with Q430 do
      begin
        if (selT713.FieldByName('FILTRO_ANAGRAFE').AsString <> GetVariable('FILTRO_ANAGRAFE_SUB'))
        or (Prog <> GetVariable('PROGRESSIVO'))
        or (Data <> GetVariable('DATA')) then
        begin
          //Ottimizzazione per effettuare filtro solo su T430 + T030
          Filtro:=selT713.FieldByName('FILTRO_ANAGRAFE').AsString;
          ClearVariables;
          if (Pos('P430',UpperCase(Filtro)) = 0) and (Pos('T430D_',UpperCase(Filtro)) = 0) then
          begin
            Filtro:=StringReplace(Filtro,'V430.','',[rfReplaceAll,rfIgnoreCase]);
            Filtro:=StringReplace(Filtro,'T430','T430.',[rfReplaceAll,rfIgnoreCase]);
            SetVariable('QVISTA','T030_ANAGRAFICO T030 WHERE T030.PROGRESSIVO = T430.PROGRESSIVO');
            SetVariable('JOIN_V430','AND :DATALAVORO = :DATALAVORO');
          end
          else
          begin
            SetVariable('QVISTA',QVistaOracle);
            SetVariable('JOIN_V430','AND T430.PROGRESSIVO = V430.T430PROGRESSIVO');
          end;

          //SetVariable('FILTRO_ANAGRAFE_SUB',selT713.FieldByName('FILTRO_ANAGRAFE').AsString);
          SetVariable('FILTRO_ANAGRAFE_SUB',Filtro);
          SetVariable('PROGRESSIVO',Prog);
          SetVariable('DATA',Data);
          SetVariable('DataLavoro',Data);
          Execute;
        end;
        if Field(0) > 0 then
        begin
          CodGruppo:=selT713.FieldByName('CODGRUPPO').AsString;
          FiltroAnagrafe:=selT713.FieldByName('FILTRO_ANAGRAFE').AsString;
          Break;
        end;
      end;
      Next;
    end;
  end;
end;

procedure TA029FBudgetDtM1.PreparaAggiornaFruitoBudget(Data:TDateTime; ElencoTipi:String);
//Danilo Agosto 20/01/2011: Al momento ElencoTipi vale solo #LIQ# ma in futuro potrebbe risultare utile
var S,Tipo:String;
begin
  if Data <> selT713.GetVariable('DATA') then
  begin
    selT713.Close;
    selT713.SetVariable('DATA',Data);
    selT713.Open;
  end;
  selT713.First;
  while not selT713.Eof do
  begin
    S:=ElencoTipi + ',';
    while Pos(',',S) > 0 do
    begin
      Tipo:=Copy(S,1,Pos(',',S) - 1);
      AggiornaFruitoBudget(Data,Tipo,selT713.FieldByName('CODGRUPPO').AsString,selT713.FieldByName('FILTRO_ANAGRAFE').AsString,IfThen(Tipo = TIPOLIQ,'E','O'),False);
      S:=Copy(S,Pos(',',S) + 1);
    end;
    selT713.Next;
  end;
end;

procedure TA029FBudgetDtM1.AggiornaFruitoBudget(Data:TDateTime; Tipo,CodGruppo,FiltroAnagrafe,TipoAggiornamento:String; ForzaQuery:Boolean = True);
//Data è sempre a inizio mese
var
  OreFruite:Integer;
  ImpFruito:Real;
  DIni:TDateTime;
begin
  if CodGruppo <> '' then
  begin
    //Ricerca dei tipi e delle relative decorrenze per un gruppo ad una certa data
    selbT713.Close;
    selbT713.SetVariable('CODGRUPPO',CodGruppo);
    selbT713.SetVariable('TIPO',Tipo);
    selbT713.SetVariable('DATA',Data);
    selbT713.Open;
    if not selbT713.Eof then
    begin
      DIni:=IfThen(Tipo = TIPOECC,selbT713.FieldByName('DECORRENZA').AsDateTime,Data);
      GetSituazioneBudget(Data,DIni,Tipo,FiltroAnagrafe,OreFruite,ImpFruito,ForzaQuery);

      //Ricerca del mese nel dettaglio
      selT714.Close;
      selT714.SetVariable('CODGRUPPO',CodGruppo);
      selT714.SetVariable('TIPO',Tipo);
      selT714.SetVariable('DECORRENZA',selbT713.FieldByName('DECORRENZA').AsDateTime);
      selT714.SetVariable('MESE',R180Mese(Data));
      selT714.Open;
      if selT714.RecordCount > 0 then
      begin
        selT714.Edit;
        if TipoAggiornamento <> 'I' then
          selT714.FieldByName('ORE_FRUITO').AsString:=R180MinutiOre(OreFruite);
        if TipoAggiornamento <> 'O' then
          selT714.FieldByName('IMPORTO_FRUITO').AsString:=FloatToStr(ImpFruito);
        selT714.Post;
      end;
    end;
  end;
end;

function TA029FBudgetDtM1.GetSituazioneBudget(Data,DIni:TDateTime; Tipo,FiltroAnagrafe:String; var OreFruito:Integer; var ImpFruito:Real; ForzaQuery:Boolean = True):Boolean;
// IMPORTANTE:
//   i dataset di appoggio per i calcoli del budget utilizzano tutti le variabili ORE / IMPORTO
//   per favore mantenere questo standard se si aggiungono o se si modificano i conteggi
var
  CreaR450Dtm,AbbattiOre,ProgMeseTrov:Boolean;
  DataMin,DataMax,DataCorr:TDateTime;
  i,j,k:Integer;
  ListaProg:String;
  OreEccProg,OreLiqProg:Integer;
begin
  Result:=False;
  OreFruito:=0;
  ImpFruito:=0;
  if Trim(FiltroAnagrafe) = '' then
    exit;
  Data:=R180InizioMese(Data);
  if cdsBudget.Active then
    cdsBudget.EmptyDataSet
  else
    cdsBudget.CreateDataSet;
  cdsBudget.LogChanges:=False;
  //Calcolo della situazione del budget per un certo gruppo (identificato dal filtro anagrafe) ad una certa data
  if Tipo = TIPOLIQ then
  //Ore liquidabili
  begin
    // budget disponibile manuale (ore + importo)
    with selBudget1 do
    begin
      if (GetVariable('Data') <> Data)
      or (GetVariable('Filtro_Anagrafe_Str') <> FiltroAnagrafe)
      or ForzaQuery then
      begin
        ClearVariables; //pulisce anche le variabili di output
        SetVariable('Data',Data);
        SetVariable('Filtro_Anagrafe_Str',FiltroAnagrafe);
        Execute;
      end;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='ORE_BUDGET';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('ORE'),'0'));
      cdsBudget.Post;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='IMP_BUDGET';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('IMPORTO'),'0'));
      cdsBudget.Post;
    end;
    // ore straordinario liquidato
    with selBudget2 do
    begin
      if (GetVariable('Data') <> Data)
      or (GetVariable('Filtro_Anagrafe_Sub') <> FiltroAnagrafe)
      or ForzaQuery then
      begin
        ClearVariables;
        SetVariable('Data',Data);
        SetVariable('DataLavoro',R180FineMese(Data));
        SetVariable('Filtro_Anagrafe_Sub',FiltroAnagrafe);
        SetVariable('QVistaOracle',QVistaOracle);
        Execute;
      end;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='LIQUIDNELMESE';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('ORE'),'0'));
      cdsBudget.Post;
    end;
    // importo fruito delle ore liquidate
    with selBudget2Imp do
    begin
      if (GetVariable('Data') <> Data)
      or (GetVariable('Filtro_Anagrafe_Sub') <> FiltroAnagrafe)
      or ForzaQuery then
      begin
        ClearVariables;
        SetVariable('Data',Data);
        SetVariable('DataLavoro',R180FineMese(Data));
        SetVariable('Filtro_Anagrafe_Sub',FiltroAnagrafe);
        SetVariable('QVistaOracle',QVistaOracle);
        SetVariable('Livello',IfThen(Parametri.CampiRiferimento.C2_Livello <> '','T430' + Parametri.CampiRiferimento.C2_Livello,''' '''));
        Execute;
      end;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='IMP_LIQUIDNELMESE';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('IMPORTO'),'0'));
      cdsBudget.Post;
    end;
    // straordinario Liquidato fuori budget (ore / importo????)
    with selBudget3 do
    begin
      if (GetVariable('Data') <> Data)
      or (GetVariable('Filtro_Anagrafe_Sub') <> FiltroAnagrafe)
      or ForzaQuery then
      begin
        ClearVariables;
        SetVariable('Data',Data);
        SetVariable('DataLavoro',R180FineMese(Data));
        SetVariable('Filtro_Anagrafe_Sub',FiltroAnagrafe);
        SetVariable('QVistaOracle',QVistaOracle);
        Execute;
      end;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='LIQ_FUORI_BUDGET';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('ORE'),'0'));
      cdsBudget.Post;
    end;
    // ore riepiloghi di presenza liquidati
    with selBudget4 do
    begin
      if (GetVariable('Data') <> Data)
      or (GetVariable('Filtro_Anagrafe_Sub') <> FiltroAnagrafe)
      or ForzaQuery then
      begin
        ClearVariables;
        SetVariable('Data',Data);
        SetVariable('DataLavoro',R180FineMese(Data));
        SetVariable('Filtro_Anagrafe_Sub',FiltroAnagrafe);
        SetVariable('QVistaOracle',QVistaOracle);
        Execute;
      end;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='LIQUIDORECAUS';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('ORE'),'0'));
      cdsBudget.Post;
    end;
    // importo riepiloghi di presenza liquidati
    with selBudget4Imp do
    begin
      if (GetVariable('Data') <> Data)
      or (GetVariable('Filtro_Anagrafe_Sub') <> FiltroAnagrafe)
      or ForzaQuery then
      begin
        ClearVariables;
        SetVariable('Data',Data);
        SetVariable('DataLavoro',R180FineMese(Data));
        SetVariable('Filtro_Anagrafe_Sub',FiltroAnagrafe);
        SetVariable('QVistaOracle',QVistaOracle);
        SetVariable('Livello',IfThen(Parametri.CampiRiferimento.C2_Livello <> '','T430' + Parametri.CampiRiferimento.C2_Livello,''' '''));
        Execute;
      end;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='IMP_LIQUIDORECAUS';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('IMPORTO'),'0'));
      cdsBudget.Post;
    end;
    // ore riepiloghi di presenza maturati
    with selBudget5 do
    begin
      if (GetVariable('Data') <> Data)
      or (GetVariable('Filtro_Anagrafe_Sub') <> FiltroAnagrafe)
      or ForzaQuery then
      begin
        ClearVariables;
        SetVariable('Data',Data);
        SetVariable('DataLavoro',R180FineMese(Data));
        SetVariable('Filtro_Anagrafe_Sub',FiltroAnagrafe);
        SetVariable('QVistaOracle',QVistaOracle);
        Execute;
      end;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='ORECAUSMATURATE';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('ORE'),'0'));
      cdsBudget.Post;
    end;
    // importi riepiloghi di presenza maturati
    with selBudget5Imp do
    begin
      if (GetVariable('Data') <> Data)
      or (GetVariable('Filtro_Anagrafe_Sub') <> FiltroAnagrafe)
      or ForzaQuery then
      begin
        ClearVariables;
        SetVariable('Data',Data);
        SetVariable('DataLavoro',R180FineMese(Data));
        SetVariable('Filtro_Anagrafe_Sub',FiltroAnagrafe);
        SetVariable('QVistaOracle',QVistaOracle);
        SetVariable('Livello',IfThen(Parametri.CampiRiferimento.C2_Livello <> '','T430' + Parametri.CampiRiferimento.C2_Livello,''' '''));
        Execute;
      end;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='IMP_ORECAUSMATURATE';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('IMPORTO'),'0'));
      cdsBudget.Post;
    end;

    // valorizzazione variabili
    OreBudgetDisponibile:=0;
    OreBudgetLiquidato:=0;
    LiqFuoriBudget:=0;
    ImpBudgetDisponibile:=0;
    ImpBudgetLiquidato:=0;
    with cdsBudget do
    begin
      // ore
      if Locate('Tipo','ORE_BUDGET',[]) then
      begin
        Result:=True;
        // budget disponibile: ore
        OreBudgetDisponibile:=FieldByName('ORE').AsInteger;

        // budget liquidato: ore
        if Locate('Tipo','LIQUIDNELMESE',[]) then
          OreBudgetLiquidato:=FieldByName('ORE').AsInteger;
        if Locate('Tipo','LIQ_FUORI_BUDGET',[]) then
        begin
          LiqFuoriBudget:=FieldByName('ORE').AsInteger;
          if FieldByName('ORE').AsInteger > 0 then
            OreBudgetLiquidato:=OreBudgetLiquidato - FieldByName('ORE').AsInteger;
        end;
        if Locate('Tipo','LIQUIDORECAUS',[]) then
          OreBudgetLiquidato:=OreBudgetLiquidato + FieldByName('ORE').AsInteger;
        if Locate('Tipo','ORECAUSMATURATE',[]) then
          OreBudgetLiquidato:=OreBudgetLiquidato + FieldByName('ORE').AsInteger;
      end;
      OreFruito:=OreBudgetLiquidato;

      // budget disponibile: importo
      if Locate('Tipo','IMP_BUDGET',[]) then
        ImpBudgetDisponibile:=FieldByName('ORE').AsFloat;

      // budget liquidato: importo
      if Locate('Tipo','IMP_LIQUIDNELMESE',[]) then
        ImpBudgetLiquidato:=FieldByName('ORE').AsFloat;
      if Locate('Tipo','IMP_LIQUIDORECAUS',[]) then
        ImpBudgetLiquidato:=ImpBudgetLiquidato + FieldByName('ORE').AsFloat;
      if Locate('Tipo','IMP_ORECAUSMATURATE',[]) then
        ImpBudgetLiquidato:=ImpBudgetLiquidato + FieldByName('ORE').AsFloat;
      ImpFruito:=ImpBudgetLiquidato;
    end
  end
  else if Tipo = TIPOBANCAORE then
  //Banca ore
  begin
    //ore fruite in Banca ore
    with selBudget7 do
    begin
      if (GetVariable('Data') <> Data)
      or (GetVariable('Filtro_Anagrafe_Sub') <> FiltroAnagrafe)
      or ForzaQuery then
      begin
        ClearVariables; //pulisce anche le variabili di output
        SetVariable('Data',Data);
        SetVariable('DataLavoro',R180FineMese(Data));
        SetVariable('Filtro_Anagrafe_Sub',FiltroAnagrafe);
        SetVariable('QVistaOracle',QVistaOracle);
        Execute;
      end;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='BANCAORE';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('ORE'),'0'));
      cdsBudget.Post;
    end;
    // importo fruito della banca ore maturata
    with selBudget7Imp do
    begin
      if (GetVariable('Data') <> Data)
      or (GetVariable('Filtro_Anagrafe_Sub') <> FiltroAnagrafe)
      or ForzaQuery then
      begin
        ClearVariables;
        SetVariable('Data',Data);
        SetVariable('DataLavoro',R180FineMese(Data));
        SetVariable('Filtro_Anagrafe_Sub',FiltroAnagrafe);
        SetVariable('QVistaOracle',QVistaOracle);
        SetVariable('Livello',IfThen(Parametri.CampiRiferimento.C2_Livello <> '','T430' + Parametri.CampiRiferimento.C2_Livello,''' '''));
        Execute;
      end;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='IMP_BANCAORE';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('IMPORTO'),'0'));
      cdsBudget.Post;
    end;
    with cdsBudget do
    begin
      if Locate('Tipo','BANCAORE',[]) then
        OreFruito:=FieldByName('ORE').AsInteger;
      if Locate('Tipo','IMP_BANCAORE',[]) then
        ImpFruito:=FieldByName('ORE').AsFloat;
    end;
  end
  else if Tipo = TIPOECC then
  //Ore compensabili e ore liquidabili anno corrente positive
  begin
    OreEccedenti:=0;
    //Ad ogni fine mese tra la data inizio e la data fine estraggo la distinct dei dipendenti del filtro anagrafe
    SetLength(ProgMesi,0);
    DataMin:=DIni;
    DataMax:=R180FineMese(Data);
    DataCorr:=DataMin;
    while DataCorr <= DataMax do
    begin
      with selaV430 do
      begin
        R180SetVariable(selaV430,'C700DATADAL',DataCorr);
        R180SetVariable(selaV430,'DATALAVORO',R180FineMese(DataCorr));
        R180SetVariable(selaV430,'FILTRO',FiltroAnagrafe);
        if ForzaQuery then Close;
        Open;
        First;
        while not Eof do
        begin
          SetLength(ProgMesi,Length(ProgMesi) + 1);
          ProgMesi[High(ProgMesi)].Mese:=R180Mese(DataCorr);
          ProgMesi[High(ProgMesi)].Prog:=FieldByName('PROGRESSIVO').AsInteger;
          Next;
        end;
      end;
      DataCorr:=R180FineMese(DataCorr) + 1;
    end;
    //Per ogni dipendente, partendo dall'ultima decorrenza, prelevo le sue ore, eventualmente decurtate dei mesi precedenti fuori dal gruppo
    DataMin:=EncodeDate(R180Anno(Data),1,1);
    CreaR450Dtm:=False;
    if R450DtM = nil then
    begin
      CreaR450Dtm:=True;
      R450DtM:=TR450DtM1.Create(nil);
    end;
    ListaProg:=',';
    for i:=0 to High(ProgMesi) do
    begin
      if not (Pos(',' + IntToStr(ProgMesi[i].Prog) + ',',ListaProg) > 0) then
      begin
        ListaProg:=ListaProg + IntToStr(ProgMesi[i].Prog) + ',';
        OreEccProg:=0;
        OreLiqProg:=0;
        AbbattiOre:=False;
        DataCorr:=DataMax;
        while DataCorr >= DataMin do
        begin
          ProgMeseTrov:=False;
          for j:=0 to High(ProgMesi) do
          begin
            if (ProgMesi[j].Mese = R180Mese(DataCorr))
            and (ProgMesi[j].Prog = ProgMesi[i].Prog) then
            begin
              ProgMeseTrov:=True;
              R450DtM.ConteggiMese('Generico',R180Anno(DataCorr),R180Mese(DataCorr),ProgMesi[i].Prog);
              if not AbbattiOre then
              begin
                OreEccProg:=OreEccProg + Max(0,R450DtM.salliqannoatt + R450DtM.salcompannoatt);
                //AbbattiOre:=OreEccProg > 0;
                AbbattiOre:=(OreEccProg > 0) or (R450DtM.ttrovscheda[R180Mese(DataCorr)] = 1);
              end;
              OreLiqProg:=OreLiqProg +
                          R180SommaArray(R450DtM.tLiqNelMese) + //straordinario liquidato nel mese: sempre positivo
                          R450DtM.L07.OreCompLiquidate; //banca ore liquidata nel mese: potrebbe essere negativo in caso di variazione
              for k:=0 to High(R450DtM.RiepPres) do
              begin
                if R450DtM.selT275.Lookup('CODICE',R450DtM.RiepPres[k].Causale,'ABBATTE_BUDGET') = 'L' then
                  OreLiqProg:=OreLiqProg + R180SommaArray(R450DtM.RiepPres[k].LiquidatoMese)
                else if R450DtM.selT275.Lookup('CODICE',R450DtM.RiepPres[k].Causale,'ABBATTE_BUDGET') = 'M' then
                  OreLiqProg:=OreLiqProg + R180SommaArray(R450DtM.RiepPres[k].OreReseMese);
              end;
              Break;
            end;
          end;
          if (not ProgMeseTrov)
          and AbbattiOre then
          begin
            R450DtM.ConteggiMese('Generico',R180Anno(DataCorr),R180Mese(DataCorr),ProgMesi[i].Prog);
            OreEccProg:=Max(0,OreEccProg - Max(0,R450DtM.salliqannoatt + R450DtM.salcompannoatt));
            AbbattiOre:=False;
          end;
          DataCorr:=R180InizioMese(DataCorr) - 1;
        end;
        OreEccedenti:=OreEccedenti + Max(0,OreEccProg) + Max(0,OreLiqProg);
      end;
    end;
    if CreaR450Dtm then
      FreeAndNil(R450DtM);
    cdsBudget.Append;
    cdsBudget.FieldByName('TIPO').AsString:='ORE_ECCEDENTI';
    cdsBudget.FieldByName('ORE').AsFloat:=OreEccedenti;
    cdsBudget.Post;
    with cdsBudget do
      if Locate('Tipo','ORE_ECCEDENTI',[]) then
        OreFruito:=FieldByName('ORE').AsInteger;
  end
  else
  begin
    // ore causali di presenza
    with selBudget8 do
    begin
      if (GetVariable('Data') <> Data)
      or (GetVariable('Filtro_Anagrafe_Sub') <> FiltroAnagrafe)
      or (GetVariable('Causale') <> Tipo)
      or ForzaQuery then
      begin
        ClearVariables;
        SetVariable('Data',Data);
        SetVariable('DataLavoro',R180FineMese(Data));
        SetVariable('Filtro_Anagrafe_Sub',FiltroAnagrafe);
        SetVariable('QVistaOracle',QVistaOracle);
        SetVariable('Causale',Tipo);
        Execute;
      end;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='ORECAUSALIZZATE';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('ORE'),'0'));
      cdsBudget.Post;
    end;
    with cdsBudget do
      if Locate('Tipo','ORECAUSALIZZATE',[]) then
        OreFruito:=FieldByName('ORE').AsInteger;

    // importo causali di presenza
    with selBudget8Imp do
    begin
      if (GetVariable('Data') <> Data)
      or (GetVariable('Filtro_Anagrafe_Sub') <> FiltroAnagrafe)
      or (GetVariable('Causale') <> Tipo)
      or ForzaQuery then
      begin
        ClearVariables;
        SetVariable('Data',Data);
        SetVariable('DataLavoro',R180FineMese(Data));
        SetVariable('Filtro_Anagrafe_Sub',FiltroAnagrafe);
        SetVariable('QVistaOracle',QVistaOracle);
        SetVariable('Causale',Tipo);
        Execute;
      end;
      cdsBudget.Append;
      cdsBudget.FieldByName('TIPO').AsString:='IMPCAUSALIZZATO';
      cdsBudget.FieldByName('ORE').AsFloat:=StrToFloat(VarToStrDef(GetVariable('IMPORTO'),'0'));
      cdsBudget.Post;
    end;
    with cdsBudget do
    begin
      if Locate('Tipo','IMPCAUSALIZZATO',[]) then
        ImpFruito:=FieldByName('ORE').AsFloat;
    end;
  end;
end;

procedure TA029FBudgetDtM1.CtrlLiqClear;
// cancella i dati di supporto per il controllo della liquidazione
begin
  SetLength(CtrlLiqArr,0);
end;

function TA029FBudgetDtM1.CtrlLiqAdd(const PCausale: String; const PMaggiorazione: Real; const POre: Integer): Integer;
// aggiunge un elemento alla struttura dati di supporto per il controllo della liquidazione
var
  i: Integer;
begin
  i:=Length(CtrlLiqArr);
  SetLength(CtrlLiqArr,i + 1);
  CtrlLiqArr[i].Causale:=PCausale;
  CtrlLiqArr[i].Maggiorazione:=PMaggiorazione;
  CtrlLiqArr[i].Ore:=POre;
  CtrlLiqArr[i].Monetizzazione:=0;
  CtrlLiqArr[i].Importo:=0;
  Result:=i;
end;

function TA029FBudgetDtM1.CtrlLiqGetImporto(const PProg: Integer; const PData: TDateTime): Real;
// calcola l'importo delle ore liquidate in base alla monetizzazione
// impostata sulla tabella T730_VALUTAORE
var
  i: Integer;
begin
  Result:=0;
  try
    selCtrlBudget.ClearVariables;
    selCtrlBudget.SetVariable('PROGRESSIVO',PProg);
    selCtrlBudget.SetVariable('DATA',PData);
    selCtrlBudget.SetVariable('LIVELLO',Format('T430.%s',[Parametri.CampiRiferimento.C2_Livello]));
    for i:=Low(CtrlLiqArr) to High(CtrlLiqArr) do
    begin
      CtrlLiqArr[i].Monetizzazione:=0;
      CtrlLiqArr[i].Importo:=0;
      // se le ore liquidate sono 0, l'importo sarà 0 per cui si evita una query inutile
      if CtrlLiqArr[i].Ore <> 0 then
      begin
        selCtrlBudget.SetVariable('CAUSALE',CtrlLiqArr[i].Causale);
        selCtrlBudget.SetVariable('MAGGIORAZIONE',CtrlLiqArr[i].Maggiorazione);
        selCtrlBudget.SetVariable('ORE',CtrlLiqArr[i].Ore);
        selCtrlBudget.Execute;
        if not selCtrlBudget.Eof then
        begin
          CtrlLiqArr[i].Monetizzazione:=selCtrlBudget.FieldAsFloat(0);
          CtrlLiqArr[i].Importo:=selCtrlBudget.FieldAsFloat(1);
        end;
      end;
      Result:=Result + CtrlLiqArr[i].Importo;
    end;
  except
    on E: Exception do
      raise Exception.Create(Format('Si è verificato un errore in fase di controllo del budget fruito:%s%s (%s)',
                                    [CRLF,E.Message,E.ClassName]));
  end;
end;

function TA029FBudgetDtM1.CtrlLiqGetDettaglio: String;
// restituisce una stringa con il dettaglio della struttura dati di appoggio
// utilizzata per il calcolo della monetizzazione delle ore liquidate in base alla tariffa su T730
var
  i: Integer;
begin
  Result:='';
  for i:=Low(CtrlLiqArr) to High(CtrlLiqArr) do
  begin
    Result:=Result +
            FormatFloat('#0.##%: ',CtrlLiqArr[i].Maggiorazione) +
            R180MinutiOre(CtrlLiqArr[i].Ore) +
            ' * ' + FormatFloat('#,##0.00',CtrlLiqArr[i].Monetizzazione) +
            ' = ' + FormatFloat('#,##0.00',CtrlLiqArr[i].Importo) +
            CRLF;
  end;
end;

function TA029FBudgetDtM1.ControllaBudget(const PInterattivo: Boolean; Prog:Integer; Data:TDateTime; POreLiq:Integer; PImpLiq: Real): Boolean;
// controlla la disponibilità di ore e importo rispetto al budget
// PInterattivo = True
//   -- dà un messagebox e quindi solleva un'eccezione EAbort in modo da evitare eventuali altre operazioni
// PInterattivo = False
//    -- restituisce True / False a seconda che ci sia disponibilità o meno
//    -- se la disponibilità non è sufficiente salva il dettaglio sui messaggi delle elaborazioni
var
  S,CodGruppo,DescGruppo,FiltroAnagrafe,Dett:String;
  i,OreFruito:Integer;
  ImpFruito:Real;
  BudgetOreSforato,BudgetImpSforato: Boolean;
begin
  DescGruppo:='';
  GetRaggruppamentiBudget(Prog,Data,CodGruppo,FiltroAnagrafe);
  if not GetSituazioneBudget(Data,Data,TIPOLIQ,FiltroAnagrafe,OreFruito,ImpFruito,False) then
  begin
    Result:=True;
    Exit;
  end;

  // imposta variabili per determinare se il budget a ore / importi è stato sforato
  BudgetOreSforato:=(OreBudgetLiquidato + POreLiq) > OreBudgetDisponibile;
  BudgetImpSforato:=(ImpBudgetLiquidato + PImpLiq) > ImpBudgetDisponibile;

  // controllo ok se nessuno dei budget è sforato (ore e importi)
  Result:=not (BudgetOreSforato or BudgetImpSforato);

  // segnalazione errore
  if not Result then
  begin
    // decodifica descrizione gruppo
    selbT713.Close;
    selbT713.SetVariable('CODGRUPPO',CodGruppo);
    selbT713.SetVariable('TIPO',TIPOLIQ);
    selbT713.SetVariable('DATA',Data);
    selbT713.Open;
    DescGruppo:=VarToStr(selbT713.Lookup('TIPO',VarArrayOf([TIPOLIQ]),'DESCRIZIONE'));

    // controllo del budget a ore
    if BudgetOreSforato then
    begin
      if PInterattivo then
      begin
        // segnalazione messagebox interattivo
        S:='Disponibilità budget in ore non sufficiente!' + CRLF +
           'Cod. gruppo: ' + CodGruppo + ' ' + DescGruppo + CRLF +
           'Tipo: ' + TIPOLIQ + ' Ore liquidabili' + CRLF + CRLF +
           'Budget disponibile: ' + R180MinutiOre(OreBudgetDisponibile) + CRLF +
           'Ore totali richieste: ' + R180MinutiOre(OreBudgetLiquidato + POreLiq) + CRLF +
           'di cui:' + CRLF +
           '- già liquidate: ' + R180MinutiOre(POreLiq) + CRLF +
           '- richieste: ' + R180MinutiOre(OreBudgetLiquidato);
        raise Exception.Create(S);
        (* caratto 10/05/2013 rimozione msgbox per utilizzo anche in web
        R180MessageBox(S,ESCLAMA);
        Abort;
        *)
      end
      else
      begin
        // log nei messaggi delle elaborazioni
        RegistraMsg.InserisciMessaggio('A',Format('Disponibilità budget in ore non sufficiente: fruito (%d) + richiesto (%d) = %d > %d disponibile',
                                                  [OreBudgetLiquidato,POreLiq,OreBudgetLiquidato + POreLiq,OreBudgetDisponibile]),Parametri.Azienda,Prog);
      end;
    end;

    // controllo del budget a importi, calcolato in base alle ore divise in fasce di maggiorazione
    if BudgetImpSforato then
    begin
      if PInterattivo then
      begin
        // segnalazione messagebox interattivo
        S:='Disponibilità budget ad importo non sufficiente' + CRLF +
           'per liquidazione di ' + R180MinutiOre(POreLiq) + ' ore!' + CRLF +
           'Cod. gruppo: ' + CodGruppo + ' ' + DescGruppo + CRLF +
           'Tipo: ' + TIPOLIQ + ' Ore liquidabili' + CRLF +
           FormatFloat('Budget disponibile: #,##0.00',ImpBudgetDisponibile) + CRLF +
           FormatFloat('Importo totale richiesto: #,##0.00',ImpBudgetLiquidato + PImpLiq) + CRLF +
           'di cui:' + CRLF +
           FormatFloat('- già liquidato: #,##0.00',ImpBudgetLiquidato) + CRLF +
           FormatFloat('- richiesto: #,##0.00',PImpLiq);

        // dettaglio della monetizzazione in fasce
        Dett:=CtrlLiqGetDettaglio;
        if Dett <> '' then
        begin
          S:=S + CRLF + R180Indenta(Dett,2);
        end;
        raise Exception.Create(S);
        (* caratto 10/05/2013 rimozione msgbox per utilizzo anche in web
        R180MessageBox(S,ESCLAMA);
        Abort;
        *)
      end
      else
      begin
        // log nei messaggi delle elaborazioni
        RegistraMsg.InserisciMessaggio('A',Format('Disponibilità importo budget non sufficiente per liquidazione di %s ore',[R180MinutiOre(POreLiq)]),Parametri.Azienda,Prog);
        RegistraMsg.InserisciMessaggio('A','Riepilogo: ' +
                                           FormatFloat('fruito (#,##0.00) + ',ImpBudgetLiquidato) +
                                           FormatFloat('richiesto (#,##0.00) = ',PImpLiq) +
                                           FormatFloat('#,##0.00 > ',ImpBudgetLiquidato + PImpLiq) +
                                           FormatFloat('#,##0.00 disponibile',ImpBudgetDisponibile),
                                           Parametri.Azienda,Prog);
        // dettaglio in fasce
        for i:=Low(CtrlLiqArr) to High(CtrlLiqArr) do
        begin
          RegistraMsg.InserisciMessaggio('A',
                                         Format('Maggiorazione %s: %s ore * %s = %s',
                                                [FormatFloat('#0.##%',CtrlLiqArr[i].Maggiorazione),
                                                 R180MinutiOre(CtrlLiqArr[i].Ore),
                                                 FormatFloat('#,##0.00',CtrlLiqArr[i].Monetizzazione),
                                                 FormatFloat('#,##0.00',CtrlLiqArr[i].Importo)]),
                                         Parametri.Azienda,Prog);
        end;
      end;
    end;
  end;
end;

function TA029FBudgetDtM1.VisualizzaBudget(Prog:Integer; Data:TDateTime): String;
var CodGruppo,FiltroAnagrafe:String;
    OreFruito:Integer;
    ImpFruito:Real;
begin
  GetRaggruppamentiBudget(Prog,Data,CodGruppo,FiltroAnagrafe);
  if GetSituazioneBudget(Data,Data,TIPOLIQ,FiltroAnagrafe,OreFruito,ImpFruito,False) then
  begin
    Result:='Cod. gruppo: ' + CodGruppo + CRLF +
       'Tipo: ' + TIPOLIQ + CRLF + CRLF +
       'Situazione budget espressa in ore:' + CRLF +
       '- budget mensile disponibile: ' + R180MinutiOre(OreBudgetDisponibile) + CRLF +
       '- già liquidato: ' + R180MinutiOre(OreBudgetLiquidato) + CRLF +
       '- liquidato fuori budget: ' + R180MinutiOre(LiqFuoriBudget) + CRLF + CRLF +
       'Situazione budget espressa in valuta:' + CRLF +
       FormatFloat('- budget mensile disponibile: #,##0.00',ImpBudgetDisponibile) + CRLF +
       FormatFloat('- già liquidato: #,##0.00',ImpBudgetLiquidato);
  end
  else
  begin
    Result:='Non esiste il budget mensile';
  end;
  (* Caratto 10/05/2013 rimozione msgbox per utilizzo anche in web
  R180MessageBox(S,INFORMA);
  *)
end;

// non è utilizzata: verificare!
{
function TA029FBudgetDtM1.GetResiduoLiquidabile:Integer;
var i:Integer;
begin
  Result:=0;
  with R450DtM do
    for i:=1 to NFasceMese do
      //Considero il liquidato fino al mese precedente (non tolgo il liquidato nel mese)
      Result:=Result + tstrannom[i] - tstrliq[i];// + tLiqNelMese[i];
end;
}

procedure TA029FBudgetDtM1.PutLiquidatoFuoriBudget(Prog:Integer; Data:TDateTime; Liquidato:Integer);
begin
  with upd070 do
  begin
    SetVariable('Progressivo',Prog);
    SetVariable('Data',Data);
    SetVariable('Liquidato',Liquidato);
    Execute;
  end;
  //SessioneOracle.Commit;
end;

procedure TA029FBudgetDtM1.PutMaxLiquidatoFuoriBudget(Prog:Integer; Data:TDateTime; MaxLiquidato:Integer);
begin
  with updT070a do
  begin
    SetVariable('Progressivo',Prog);
    SetVariable('Data',Data);
    SetVariable('MaxLiquidato',MaxLiquidato);
    Execute;
  end;
  //SessioneOracle.Commit;
end;

procedure TA029FBudgetDtM1.A029FBudgetDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).CloseAll;
    if (Self.Components[i] is TOracleQuery) then
      (Self.Components[i] as TOracleQuery).Close;
  end;
end;

end.
