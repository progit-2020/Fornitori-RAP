unit R100UCreditiFormativiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls,
  R004UGESTSTORICODTM, DB, OracleData, R600, A000UInterfaccia, C180FunzioniGenerali;

type
  TCrediti = record
    nProgressivo:integer;
    sProfiloCrediti:string;
    nResAnnoPrec:Real;
    nCompAnnoCorr:Real;
    nCompMinAnnoCorr:Real;
    nCompMaxAnnoCorr:Real;
    nFruitoPeriodo:Real;
    nResAnnoCorr:Real;
    nResMinAnnoCorr:Real;
    nResMaxAnnoCorr:Real;
  end;

  TR100FCreditiFormativiDtM = class(TR004FGestStoricoDtM)
    SelSG655: TOracleDataSet;
    SelT040: TOracleDataSet;
    SelSG651: TOracleDataSet;
    SelPresenza: TOracleDataSet;
    SelT030: TOracleDataSet;
    SelT430: TOracleDataSet;
    SelSG656: TOracleDataSet;
    selSG651ContCred: TOracleDataSet;
    SelSG659: TOracleDataSet;
    SelSG659COD_CORSO: TStringField;
    SelSG659NUMERO_GIORNO: TIntegerField;
    SelSG659DESCRIZIONE: TStringField;
    SelSG659ORE_GIORNO: TStringField;
    SelSG659ORE_MINIME: TStringField;
    selSG650: TOracleDataSet;
    SelSG670: TOracleDataSet;
    SelSG664: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    R600DtM:TR600DtM1;
  public
    { Public declarations }
    CompResCrediti:TCrediti;
    procedure ConteggioCrediti(Prog:LongInt; Inizio,Fine:TDateTime; ProfiloCrediti:String);//Conteggia i crediti di tutti i corso all'interno del periodo indicato
    function ConteggioCreditiCorso(Prog:Integer; CodCorso:String):Real;//Riconosce o meno i crediti per il corso indicato
  end;

var R100FCreditiFormativiDtM: TR100FCreditiFormativiDtM;

implementation

{$R *.dfm}

procedure TR100FCreditiFormativiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  R600DtM:=TR600DtM1.Create(Self.Owner);
  CompResCrediti.nProgressivo:=0;
  CompResCrediti.nCompAnnoCorr:=0;
  CompResCrediti.nCompMinAnnoCorr:=0;
  CompResCrediti.nCompMaxAnnoCorr:=0;
  CompResCrediti.nFruitoPeriodo:=0;
  CompResCrediti.nResAnnoCorr:=0;
  CompResCrediti.nResMinAnnoCorr:=0;
  CompResCrediti.nResMaxAnnoCorr:=0;
end;

procedure TR100FCreditiFormativiDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(R600DtM);
end;

procedure TR100FCreditiFormativiDtM.ConteggioCrediti(Prog:LongInt; Inizio,Fine:TDateTime; ProfiloCrediti:String);
{Visualizzazione competenza/residui crediti formativi}
var
  a,m,g:Word;
  sAssenze, sPresenze:TStringList;
  i:integer;
  nResiduoAnnoPrec, nFruitoAC, nFruitoAP, nFruitoAS, nTotaleCreditiFruiti, nCompetenze, nCompMinAnnoCorr, nCompMaxAnnoCorr:Real;
  dDataInizio, dDataFine:TDateTime;
  sCausale:string;
  Giust:TGiustificativo;
  sUm:string;
  nOreRese:Real;
  sValoreCampo, sProfiloCrediti:string;
begin

  sAssenze:=TStringList.Create;
  sPresenze:=TStringList.Create;
  sCausale:='';
  DecodeDate(Fine,a,m,g);
  nCompetenze:=0;
  sProfiloCrediti:='';
  sValoreCampo:='';
  nCompMinAnnoCorr:=0;
  nCompMaxAnnoCorr:=0;
  nResiduoAnnoPrec:=0;

  //Leggo il residuo crediti anno precedente
  SelSG656.Close;
  SelSG656.SetVariable('progressivo',Prog);
  SelSG656.SetVariable('anno', a);
  SelSG656.Open;
  try
    nResiduoAnnoPrec:=SelSG656.FieldByName('crediti').AsFloat;
  except
  end;

  //Leggo il profilo crediti assegnato al dipendente alla DataA
  SelT430.Close;
  SelT430.SetVariable('nomecampo', Parametri.CampiRiferimento.C10_FormazioneProfiloCrediti);
  SelT430.SetVariable('Datain',Fine);
  SelT430.SetVariable('nprogressivo',Prog);
  SelT430.Open;
  try
    sValoreCampo:=SelT430.FieldByName('campo').AsString;
  except
  end;

  if sValoreCampo <> '' then
  begin
    //Leggo il monte dei crediti annui
    SelSG655.Close;
    SelSG655.SetVariable('nanno',a);
    SelSG655.SetVariable('scodice',sValoreCampo);
    SelSG655.SetVariable('ProfiloCrediti',ProfiloCrediti);
    SelSG655.Open;
    nCompetenze:=SelSG655.FieldByName('NUMERO_CREDITI').AsFloat;
    sAssenze.CommaText:=SelSG655.FieldByName('ASSENZE').AsString;
    sPresenze.CommaText:=SelSG655.FieldByName('PRESENZE').AsString;
    sProfiloCrediti:=SelSG655.FieldByName('CODICE').AsString;
    nCompMinAnnoCorr:=SelSG655.FieldByName('MINIMO').AsFloat;
    nCompMaxAnnoCorr:=SelSG655.FieldByName('MASSIMO').AsFloat;
  end;

  //Verifico che nell'anno il dipendente non abbia effettuato ASSENZE per
  //le causali indicate nel profilo...
  //PER LE CAUSALI DI ASSENZA, ESCLUDO L'ANNO IN CUI HO EFFETTUATO IL MAGGIOR
  //NUMERO DI GIORNI.
  nFruitoAC:=0;
  nFruitoAP:=0;
  nFruitoAS:=0;
  for i:=0 to sAssenze.Count - 1 do
  begin
    //Verifico il fruito nell'anno in corso...
    dDataInizio:=EncodeDate(a,1,1);
    dDataFine:=EncodeDate(a,12,31);
    Giust.Causale:=sAssenze[i];
    R600DtM.GetQuantitaAssenze(Prog,dDataInizio,dDataFine,dDataInizio,Giust,sUM,nFruitoAC,nOreRese);
    //Verifico il fruito nell'anno precedente all'anno in corso...
    dDataInizio:=EncodeDate(a-1,1,1);
    dDataFine:=EncodeDate(a-1,12,31);
    R600DtM.GetQuantitaAssenze(Prog,dDataInizio,dDataFine,dDataInizio,Giust,sUM,nFruitoAP,nOreRese);
    //Verifico il fruito nell'anno successivo all'anno in corso...
    dDataInizio:=EncodeDate(a+1,1,1);
    dDataFine:=EncodeDate(a+1,12,31);
    R600DtM.GetQuantitaAssenze(Prog,dDataInizio,dDataFine,dDataInizio,Giust,sUM,nFruitoAS,nOreRese);
    //Se il fruito nell'anno corrente è maggiore del fruito nell'anno precedente
    //ed è maggiore del fruito nell'anno successivo, allora nell'anno in corso
    //non ho diritto alla gestione dei crediti formativi...
    if (nFruitoAC > nFruitoAP) and (nFruitoAC > nFruitoAS) then
    begin
      nCompetenze:=0;
      sCausale:=sAssenze[i];
      break;
    end;
  end;

  if nCompetenze > 0 then
  begin
    //Verifico che nell'anno il dipendente non abbia effettuato PRESENZE per
    //le causali indicate nel profilo...
    //ANCHE PER LE CAUSALI DI PRESENZA, ESCLUDO L'ANNO IN CUI HO EFFETTUATO IL MAGGIOR
    //NUMERO DI GIORNI.
    nFruitoAC:=0;
    nFruitoAP:=0;
    nFruitoAS:=0;
    for i:=0 to sPresenze.Count - 1 do
    begin
      //Conto il numero di giorni nell'anno in corso in cui ho utilizzato la causale sPresenza[i]...
      //Controllo nella tabella T100_Timbrature che nella tabella T040_Giustificativi
      //Anno corrente...
      SelPresenza.Close;
      dDataInizio:=EncodeDate(a,1,1);
      dDataFine:=EncodeDate(a,12,31);
      SelPresenza.SetVariable('nProgressivo',Prog);
      SelPresenza.SetVariable('sCausale',sPresenze[i]);
      SelPresenza.SetVariable('dInizio',dDataInizio);
      SelPresenza.SetVariable('dFine',dDataFine);
      SelPresenza.Open;
      nFruitoAC:=SelPresenza.Fields[0].AsFloat;
      //Anno precedente...
      SelPresenza.Close;
      dDataInizio:=EncodeDate(a-1,1,1);
      dDataFine:=EncodeDate(a-1,12,31);
      SelPresenza.SetVariable('nProgressivo',Prog);
      SelPresenza.SetVariable('sCausale',sPresenze[i]);
      SelPresenza.SetVariable('dInizio',dDataInizio);
      SelPresenza.SetVariable('dFine',dDataFine);
      SelPresenza.Open;
      nFruitoAP:=SelPresenza.Fields[0].AsFloat;
      //Anno successivo...
      SelPresenza.Close;
      dDataInizio:=EncodeDate(a+1,1,1);
      dDataFine:=EncodeDate(a+1,12,31);
      SelPresenza.SetVariable('nProgressivo',Prog);
      SelPresenza.SetVariable('sCausale',sPresenze[i]);
      SelPresenza.SetVariable('dInizio',dDataInizio);
      SelPresenza.SetVariable('dFine',dDataFine);
      SelPresenza.Open;
      nFruitoAS:=SelPresenza.Fields[0].AsFloat;
      if (nFruitoAC > nFruitoAP) and (nFruitoAC > nFruitoAS) then
      begin
        nCompetenze:=0;
        sCausale:=sAssenze[i];
        break;
      end;
    end;
  end;

  //Adesso calcolo i crediti che ho effettivamente consumato nel periodo specificato
  //da datainizio a datafine
  nTotaleCreditiFruiti:=0;
  //Alberto: Leggere solo i corsi relativi al profilo = ProfiloCrediti
  with SelSG651 do
  begin
    Close;
    SetVariable('prog',Prog);
    SetVariable('Profilo_Crediti',ProfiloCrediti);
    SetVariable('anno',R180Anno(Fine));
    Open;
    while not Eof do
    begin
      nTotaleCreditiFruiti:=nTotaleCreditiFruiti + ConteggioCreditiCorso(Prog,FieldByName('cod_corso').AsString);
      Next;
    end;
  end;
  //Alberto: Aggiungere qui i crediti derivati dalla docenza
  with SelSG664 do
  begin
    Close;
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('PROFILO_CREDITI',ProfiloCrediti);
    SetVariable('ANNO',R180Anno(Fine));
    Open;
    nTotaleCreditiFruiti:=nTotaleCreditiFruiti + FieldByName('NUMERO_CREDITI').AsFloat;
  end;
  //Valorizzo i crediti
  CompResCrediti.nProgressivo:=Prog;
  CompResCrediti.sProfiloCrediti:=sProfiloCrediti;
  CompResCrediti.nResAnnoPrec:=nResiduoAnnoPrec;
  CompResCrediti.nCompAnnoCorr:=nCompetenze;
  CompResCrediti.nCompMinAnnoCorr:=nCompMinAnnoCorr;
  CompResCrediti.nCompMaxAnnoCorr:=nCompMaxAnnoCorr;
  if Trim(sProfiloCrediti) = '' then
    nTotaleCreditiFruiti:=0;
  CompResCrediti.nFruitoPeriodo:=nTotaleCreditiFruiti;
  CompResCrediti.nResAnnoCorr:=(nCompetenze + nResiduoAnnoPrec) - nTotaleCreditiFruiti;
  CompResCrediti.nResMinAnnoCorr:=(CompResCrediti.nCompMinAnnoCorr - nTotaleCreditiFruiti);
  CompResCrediti.nResMaxAnnoCorr:=(CompResCrediti.nCompMaxAnnoCorr - nTotaleCreditiFruiti);
end;

function TR100FCreditiFormativiDtM.ConteggioCreditiCorso(Prog:Integer; CodCorso:String):Real;
var GGValidi, OreMinGGCorso, HHRaggiunte, HHTot_DurataCorso:Integer;
    ProfCrediti:String;
    DataUltima:TDateTime;
begin
  result:=0;
  GGValidi:=0;
  HHRaggiunte:=0;
  HHTot_DurataCorso:=0;

  //Verifico se esistono i crediti individuali
  selSG670.Close;
  selSG670.SetVariable('COD_CORSO',CodCorso);
  selSG670.SetVariable('PROGRESSIVO',Prog);
  selSG670.Open;
  if not selSG670.Eof then
  begin
    result:=selSG670.FieldByName('CREDITI').AsFloat;
    exit;
  end;

  //Leggo la testata di CodCorso
  selSG650.Close;
  selSG650.SetVariable('CODICEIN',CodCorso);
  selSG650.Open;
  //Leggo le giornate legate al corso selezionato
  selSG659.Close;
  selSG659.SetVariable('COD_CORSO',CodCorso);
  selSG659.Open;

  //Conteggio dei crediti per ogni partecipante
  with selSG651ContCred do
  begin
    Close;
    SetVariable('CodCorso',CodCorso);
    SetVariable('Prog',Prog);
    Open;
    //Alberto 28/10/2006: leggo se esiste un profilo crediti valido
    //Leggo il profilo crediti assegnato al dipendente alla DataA
    ProfCrediti:='';
    if RecordCount > 0 then
    begin
      Last;
      DataUltima:=FieldByName('DATA_CORSO').AsDateTime;
      First;
      SelT430.Close;
      SelT430.SetVariable('nomecampo', Parametri.CampiRiferimento.C10_FormazioneProfiloCrediti);
      SelT430.SetVariable('Datain',DataUltima);
      SelT430.SetVariable('nprogressivo',Prog);
      SelT430.Open;
      if SelT430.FieldByName('campo').AsString <> '' then
      begin
        //Leggo il monte dei crediti annui
        SelSG655.Close;
        SelSG655.SetVariable('nanno',R180Anno(DataUltima));
        SelSG655.SetVariable('scodice',SelT430.FieldByName('campo').AsString);
        SelSG655.SetVariable('ProfiloCrediti',selSG650.FieldByName('PROFILO_CREDITI').AsString);
        SelSG655.Open;
        ProfCrediti:=Trim(SelSG655.FieldByName('CODICE').AsString);
      end;
    end;
    SelT430.Close;
    SelSG655.Close;
    if ProfCrediti = '' then
      exit;
    //Ricavo il numero di giorni validi (se le ore fatte nella giornata di corso
    //non sono minori delle ore minime previste per la giornata del corso)
    while not Eof do
    begin
      OreMinGGCorso:=9999;
      if selSG659.SearchRecord('NUMERO_GIORNO', FieldByName('numero_giorno').AsInteger, [srFromBeginning]) then
      begin
        inc(HHRaggiunte,R180OreMinutiExt(FieldByName('massima_durata').AsString));
        OreMinGGCorso:=R180OreMinutiExt(SelSG659ORE_MINIME.AsString);
      end;
      if R180OreMinutiExt(FieldByName('massima_durata').AsString) >= OreMinGGCorso then
        inc(GGValidi,1);
      HHTot_DurataCorso:=HHTot_DurataCorso + R180OreMinutiExt(FieldByName('massima_durata').AsString);
      Next;
    end;
    if (selSG650.FieldByName('GG_MIN').AsInteger <> 0) and (R180OreMinutiExt(selSG650.FieldByName('HH_MIN').AsString) <> 0) then
    begin
      if (GGValidi >= selSG650.FieldByName('GG_MIN').AsInteger) and (HHRaggiunte >= R180OreMinutiExt(selSG650.FieldByName('HH_MIN').AsString)) then
        result:=selSG650.FieldByName('NUMERO_CREDITI').AsFloat;
    end
    else if (selSG650.FieldByName('GG_MIN').AsInteger <> 0) and (R180OreMinutiExt(selSG650.FieldByName('HH_MIN').AsString) = 0) then
    begin
      if GGValidi >= selSG650.FieldByName('GG_MIN').AsInteger then
        result:=selSG650.FieldByName('NUMERO_CREDITI').AsFloat;
    end
    else if (selSG650.FieldByName('GG_MIN').AsInteger = 0) and (R180OreMinutiExt(selSG650.FieldByName('HH_MIN').AsString) <> 0) then
    begin
      if HHRaggiunte >= R180OreMinutiExt(selSG650.FieldByName('HH_MIN').AsString) then
        result:=selSG650.FieldByName('NUMERO_CREDITI').AsFloat;
    end
    else if HHTot_DurataCorso >= R180OreMinutiExt(selSG650.FieldByName('durata_hh').asString) then
       //se la durata di partecipazione al corso è maggiore di quella prevista...
       //cocedo i crediti...
      result:=selSG650.FieldByName('NUMERO_CREDITI').AsFloat;
  end;
end;

end.
