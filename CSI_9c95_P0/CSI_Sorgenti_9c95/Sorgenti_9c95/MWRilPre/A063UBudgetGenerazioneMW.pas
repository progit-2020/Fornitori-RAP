unit A063UBudgetGenerazioneMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, CheckLst,
  Datasnap.DBClient, Oracle, OracleData, Variants, StrUtils, Math,
  A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia,
  A029UBudgetDtM1, C180FunzioniGenerali;

type
  T063Dlg = procedure(msg,Chiave:String) of object;
  T063ClearKeys = procedure of object;

  TA063FBudgetGenerazioneMW = class(TR005FDataModuleMW)
    selT713: TOracleDataSet;
    delT714: TOracleQuery;
    insT714: TOracleQuery;
    updT714: TOracleQuery;
    selT714: TOracleDataSet;
    cdsDip: TClientDataSet;
    cdsAnom: TClientDataSet;
    selaT713: TOracleDataSet;
    selbV430: TOracleDataSet;
    selT071: TOracleDataSet;
    insT713: TOracleQuery;
    selbT713: TOracleDataSet;
    selV430: TOracleDataSet;
    selaV430: TOracleDataSet;
    selT275: TOracleDataSet;
    selT275CODICE: TStringField;
    selT275DESCRIZIONE: TStringField;
    selT275ORDINE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FiltroAnagrafeUtente:TStringList;
    A029FBudgetDtM1: TA029FBudgetDtM1;
  public
    { Public declarations }
    ListaGruppi,ListaGruppiSel:TStringList;
    bAssegnaBudget,bCalcolaFruito,bRiportaResiduo,bControlloFiltriAnagrafe,bDuplicaGruppi:Boolean;
    xOreImporti,AMeseBudget,DaMeseFruito,AMeseFruito,DaMeseResiduo,AMeseResiduo,nAnno,nAnnoDup:Integer;
    evtRichiesta:T063Dlg;
    evtClearKeys:T063ClearKeys;
    procedure EseguiFiltroAnagrafeUtente(pAnno,pDaMese,pAMese:Integer);
    procedure StruttureDisponibili(pAnno,pDaMese,pAMese:Integer;TipoBS:String);
    procedure Controlli;
    procedure Domande;
    procedure AssegnazioneBudgetMensile(GruppoSel:String);
    procedure CalcoloBudgetMensile(CodGruppo,Tipo:String;DecIni,DecFin,DecMax:TDateTime;OreTot:String;ImpTot:Real;AggOre,AggImp:Boolean);
    procedure CalcoloFruitoMensile(GruppoSel:String;Data:TDateTime);
    procedure RiportoResiduoMensile(GruppoSel:String;Data:TDateTime);
    procedure ControlloFiltriAnagrafe_1;
    procedure ControlloFiltriAnagrafe_2;
    procedure DuplicazioneGruppi(GruppoSel:String);
    procedure PulisciVariabili;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA063FBudgetGenerazioneMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  cdsDip.CreateDataSet;
  cdsAnom.CreateDataSet;
  ListaGruppi:=TStringList.Create;
  ListaGruppiSel:=TStringList.Create;
  FiltroAnagrafeUtente:=TStringList.Create;
  A029FBudgetDtM1:=TA029FBudgetDtM1.Create(nil);
  selT275.Open;
end;

procedure TA063FBudgetGenerazioneMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  A029FBudgetDtM1.Free;
  FiltroAnagrafeUtente.Free;
  ListaGruppiSel.Free;
  ListaGruppi.Free;
end;

procedure TA063FBudgetGenerazioneMW.EseguiFiltroAnagrafeUtente(pAnno,pDaMese,pAMese:Integer);
var S:String;
    i:Integer;
begin
  FiltroAnagrafeUtente.Text:=Parametri.Inibizioni.Text;
  //Tolgo il filtro sui dipendenti non cessati dal filtro anagrafe dell'utente (sia con la AND che senza); utile solo per IrisWin
  for i:=FiltroAnagrafeUtente.Count - 1 downto 0 do
    if Pos(Format(QDipInServizio,[IntToStr(Parametri.ValiditaCessati)]),FiltroAnagrafeUtente.Strings[i]) > 0 then
      FiltroAnagrafeUtente.Delete(i);
  FiltroAnagrafeUtente.Text:=Trim(FiltroAnagrafeUtente.Text);
  if FiltroAnagrafeUtente.Text <> '' then
  begin
    if (pAnno > 0) and (pDaMese > 0) and (pAMese > 0) and
       (   (selV430.GetVariable('C700DATADAL') <> EncodeDate(pAnno,pDaMese,1))
        or (selV430.GetVariable('DATALAVORO') <> R180FineMese(EncodeDate(pAnno,pAMese,1)))) then
    begin
      selV430.Close;
      S:=StringReplace(QVistaOracle,
                       ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                       ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                       [rfIgnoreCase]);
      S:=StringReplace(S,
                       ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                       ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                       [rfIgnoreCase]);
      selV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
      selV430.SetVariable('C700DATADAL',EncodeDate(pAnno,pDaMese,1));
      selV430.SetVariable('DATALAVORO',R180FineMese(EncodeDate(pAnno,pAMese,1)));
      selV430.SetVariable('FILTRO',FiltroAnagrafeUtente.Text);
      if Pos(':NOME_UTENTE',FiltroAnagrafeUtente.Text) > 0  then
      begin
        try
          selV430.DeleteVariable('NOME_UTENTE');
        except
        end;
        selV430.DeclareVariable('NOME_UTENTE',otString);
        selV430.SetVariable('NOME_UTENTE',Parametri.Operatore);
      end;
      selV430.Open;
    end;
  end;
end;

procedure TA063FBudgetGenerazioneMW.StruttureDisponibili(pAnno,pDaMese,pAMese:Integer;TipoBS:String);
//Estrazione delle strutture disponibili per l'operatore (FiltroAnagrafe e anno)
var i: Integer;
    FiltroOk: Boolean;
    s,s2,FiltroOld: String;
begin
  if (pAnno > 0) and (pDaMese > 0) and (pAMese > 0) then
  begin
    for i:=0 to ListaGruppiSel.Count - 1 do
      s2:=s2 + IfThen(s2 <> '',',') + Copy(ListaGruppiSel[i],1,22);
    s2:=',' + s2 + ',';
    selT713.Close;
    selT713.SetVariable('ANNO',pAnno);
    selT713.SetVariable('TIPO',TipoBS);
    selT713.Open;
    ListaGruppi.Clear;
    FiltroOld:='*';
    while not selT713.Eof do
    begin
      FiltroOk:=False;
      if (FiltroAnagrafeUtente.Text <> '')
      and (selT713.FieldByName('FILTRO_ANAGRAFE').AsString <> FiltroOld) then
      begin
        if selV430.Active and (selV430.RecordCount > 0) then
        begin
          selaV430.Close;
          S:=StringReplace(QVistaOracle,
                           ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                           ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                           [rfIgnoreCase]);
          S:=StringReplace(S,
                           ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                           ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                           [rfIgnoreCase]);
          selaV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
          selaV430.SetVariable('C700DATADAL',EncodeDate(pAnno,pDaMese,1));
          selaV430.SetVariable('DATALAVORO',R180FineMese(EncodeDate(pAnno,pAMese,1)));
          selaV430.SetVariable('FILTRO',selT713.FieldByName('FILTRO_ANAGRAFE').AsString);
          selaV430.Open;
          while not selaV430.Eof do
          begin
            if selV430.SearchRecord('PROGRESSIVO',selaV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
            begin
              FiltroOk:=True;
              Break;
            end;
            selaV430.Next;
          end;
        end;
        FiltroOld:=selT713.FieldByName('FILTRO_ANAGRAFE').AsString;
      end
      else
        FiltroOk:=True;
      if FiltroOk then
        ListaGruppi.Add(Trim(Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').AsString, selT713.FieldByName('TIPO').AsString, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime), selT713.FieldByName('DESCRIZIONE').AsString])));
      selT713.Next;
    end;
    ListaGruppiSel.Clear;
    for i:=0 to ListaGruppi.Count - 1 do
      if Pos(',' + Copy(ListaGruppi[i],1,22) + ',',s2) > 0 then
        ListaGruppiSel.Add(ListaGruppi[i]);
  end;
end;

procedure TA063FBudgetGenerazioneMW.Controlli;
begin
  if bCalcolaFruito and (DaMeseFruito > AMeseFruito) then
    raise exception.create(A000MSG_A063_ERR_PERIODO_CALCOLO_FRUITO);
  if bRiportaResiduo and (DaMeseResiduo > AMeseResiduo) then
    raise exception.create(A000MSG_A063_ERR_PERIODO_RIPORTO_RESIDUO);
  if not bControlloFiltriAnagrafe and (ListaGruppiSel.Count = 0) then
    raise exception.create(A000MSG_A063_ERR_NO_BUDGET);
  if bDuplicaGruppi and (nAnno = nAnnoDup) then
    raise exception.create(A000MSG_A063_ERR_ANNO_DUPLICAZIONE);
end;

procedure TA063FBudgetGenerazioneMW.Domande;
var msg:String;
begin
  if bAssegnaBudget then
    msg:=A000MSG_A063_DLG_ASSEGNA_BUDGET
  else if bCalcolaFruito then
  begin
    if bRiportaResiduo then
      msg:=A000MSG_A063_DLG_CALCOLA_E_RIPORTA
    else
      msg:=A000MSG_A063_DLG_CALCOLA_FRUITO;
  end
  else if bRiportaResiduo then
    msg:=A000MSG_A063_DLG_RIPORTA_RESIDUO
  else if bControlloFiltriAnagrafe then
    msg:=Format(A000MSG_A063_DLG_FMT_CONTROLLO_FA,[IntToStr(nAnno)])
  else if bDuplicaGruppi then
    msg:=Format(A000MSG_A063_DLG_FMT_DUPLICA_GRUPPI,[IntToStr(nAnnoDup)]);
  if Assigned(evtRichiesta) then
    evtRichiesta(msg,'ConfermaElab');
end;

procedure TA063FBudgetGenerazioneMW.AssegnazioneBudgetMensile(GruppoSel:String);
var CodGruppo,Tipo:String;
    Decorrenza,Data:TDateTime;
begin
  Data:=EncodeDate(nAnno,AMeseBudget,1);
  //Prelevo i dati della chiave
  CodGruppo:=Trim(Copy(GruppoSel,1,10));
  Tipo:=Trim(Copy(GruppoSel,12,5));
  Decorrenza:=EncodeDate(StrToInt(Trim(Copy(GruppoSel,24,4))),StrToInt(Trim(Copy(GruppoSel,18,2))),1);
  //Controllo che la chiave esista (ancora)
  if not selT713.SearchRecord('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([CodGruppo,Tipo,Decorrenza]),[srFromBeginning]) then
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A063_MSG_FMT_GRUPPO,[CodGruppo,Tipo,Copy(GruppoSel,18,10)]) + A000MSG_A063_ERR_NO_TROV_BUDGET,'')
  else
  begin
    //Controllo che il mese massimo di generazione sia compreso nel periodo del budget selezionato
    if (Data < selT713.FieldByName('DECORRENZA').AsDateTime)
    or (Data > selT713.FieldByName('DECORRENZA_FINE').AsDateTime) then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A063_MSG_FMT_GRUPPO,[CodGruppo,Tipo,Copy(GruppoSel,18,10)]) + Format(A000MSG_A063_ERR_FMT_MESE_ESTERNO,[FormatDateTime('mm',Data)]),'')
    else
      CalcoloBudgetMensile(CodGruppo,Tipo,Decorrenza,selT713.FieldByName('DECORRENZA_FINE').AsDateTime,Data,selT713.FieldByName('ORE').AsString,selT713.FieldByName('IMPORTO').AsFloat,xOreImporti <> 1,xOreImporti <> 0);
  end;
end;

procedure TA063FBudgetGenerazioneMW.CalcoloBudgetMensile(CodGruppo,Tipo:String;DecIni,DecFin,DecMax:TDateTime;OreTot:String;ImpTot:Real;AggOre,AggImp:Boolean);
var j,NMesi,RigaMese:Integer;
    G,M,A,G2,M2,A2,G3,M3,A3:Word;
    OreMese:String;
    ImpMese:Real;
begin
  //Estraggo il budget mensile
  selT714.Close;
  selT714.SetVariable('CODGRUPPO',CodGruppo);
  selT714.SetVariable('TIPO',Tipo);
  selT714.SetVariable('DECORRENZA',DecIni);
  selT714.Open;
  //Calcolo le ore e l'importo da assegnare fino al mese massimo di assegnazione
  DecodeDate(DecIni,A,M,G);
  DecodeDate(DecFin,A2,M2,G2);
  DecodeDate(DecMax,A3,M3,G3);
  NMesi:=M3 - M + 1;
  //Cancello i mesi antecedenti al periodo (nel caso di modifica del periodo del budget)
  for j:=1 to M - 1 do
  begin
    delT714.SetVariable('CODGRUPPO',CodGruppo);
    delT714.SetVariable('TIPO',Tipo);
    delT714.SetVariable('DECORRENZA',DecIni);
    delT714.SetVariable('MESE',j);
    delT714.Execute;
  end;
  //Ciclo fino alla fine del periodo del budget
  while EncodeDate(A,M,1) <= EncodeDate(A2,M2,1) do
  begin
    RigaMese:=M - R180Mese(DecIni) + 1;
    OreMese:=R180MinutiOre(R180OreMinutiExt(OreTot) div NMesi);
    ImpMese:=R180Arrotonda(ImpTot / NMesi,0.01,'P');
    if RigaMese = NMesi then
    begin
      if Tipo = '#ECC#' then
      begin
        OreMese:=OreTot;
        ImpMese:=ImpTot;
      end
      else
      begin
        OreMese:=R180MinutiOre(R180OreMinutiExt(OreTot) - (R180OreMinutiExt(OreMese) * (NMesi - 1)));
        ImpMese:=ImpTot - (ImpMese * (NMesi - 1));
      end;
    end
    else if Tipo = '#ECC#' then
    begin
      OreMese:=R180MinutiOre(R180OreMinutiExt(OreMese) * RigaMese);
      ImpMese:=ImpMese * RigaMese;
    end;
    if M > M3 then
    begin
      if Tipo = '#ECC#' then
      begin
        OreMese:=OreTot;
        ImpMese:=ImpTot;
      end
      else
      begin
        OreMese:='00.00';
        ImpMese:=0;
      end;
    end;
    //Se non trovo il mese lo creo (nel caso di modifica del periodo del budget)
    if not selT714.SearchRecord('MESE',VarArrayOf([M]),[srFromBeginning]) then
    begin
      insT714.SetVariable('CODGRUPPO',CodGruppo);
      insT714.SetVariable('TIPO',Tipo);
      insT714.SetVariable('DECORRENZA',DecIni);
      insT714.SetVariable('MESE',M);
      insT714.SetVariable('ORE',IfThen(AggOre,OreMese,'00.00'));
      insT714.SetVariable('IMPORTO',IfThen(AggImp,ImpMese,0));
      insT714.SetVariable('ORE_FRUITO','00.00');
      insT714.SetVariable('IMPORTO_FRUITO',0);
      insT714.Execute;
    end
    //altrimenti lo aggiorno
    else
    begin
      updT714.SetVariable('CODGRUPPO',CodGruppo);
      updT714.SetVariable('TIPO',Tipo);
      updT714.SetVariable('DECORRENZA',DecIni);
      updT714.SetVariable('MESE',M);
      updT714.SetVariable('ORE',IfThen(AggOre,QuotedStr(OreMese),'ORE'));
      updT714.SetVariable('IMPORTO',IfThen(AggImp,StringReplace(FloatToStr(ImpMese),',','.',[rfReplaceAll]),'IMPORTO'));
      updT714.Execute;
    end;
    inc(M);
    //Gestisco il passaggio all'anno successivo (per non far andare in errore la EncodeDate del ciclo)
    if M = 13 then
    begin
      M:=1;
      inc(A);
    end;
  end;
  //Cancello i mesi successivi al periodo (nel caso di modifica del periodo del budget)
  for j:=M2 + 1 to 12 do
  begin
    delT714.SetVariable('CODGRUPPO',CodGruppo);
    delT714.SetVariable('TIPO',Tipo);
    delT714.SetVariable('DECORRENZA',DecIni);
    delT714.SetVariable('MESE',j);
    delT714.Execute;
  end;
end;

procedure TA063FBudgetGenerazioneMW.CalcoloFruitoMensile(GruppoSel:String;Data:TDateTime);
var CodGruppo,Tipo:String;
    Decorrenza:TDateTime;
begin
  //Prelevo i dati della chiave
  CodGruppo:=Trim(Copy(GruppoSel,1,10));
  Tipo:=Trim(Copy(GruppoSel,12,5));
  Decorrenza:=EncodeDate(StrToInt(Trim(Copy(GruppoSel,24,4))),StrToInt(Trim(Copy(GruppoSel,18,2))),1);
  //Controllo che la chiave esista (ancora)
  if not selT713.SearchRecord('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([CodGruppo,Tipo,Decorrenza]),[srFromBeginning]) then
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A063_MSG_FMT_GRUPPO,[CodGruppo,Tipo,Copy(GruppoSel,18,10)]) + A000MSG_A063_ERR_NO_TROV_BUDGET,'')
  else
  begin
    //Controllo che il mese per cui calcolare il fruito sia compreso nel periodo del budget selezionato
    if (Data < selT713.FieldByName('DECORRENZA').AsDateTime)
    or (Data > selT713.FieldByName('DECORRENZA_FINE').AsDateTime) then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A063_MSG_FMT_GRUPPO,[CodGruppo,Tipo,Copy(GruppoSel,18,10)]) + Format(A000MSG_A063_ERR_FMT_MESE_ESTERNO,[FormatDateTime('mm',Data)]),'')
    else if (xOreImporti <> 1)               //Allinea Ore
         or (R180In(Tipo,['#LIQ#','#B.O#'])) //Ore liquidate o banca ore
         then
      A029FBudgetDtM1.AggiornaFruitoBudget(Data,
                                           Tipo,
                                           CodGruppo,
                                           selT713.FieldByName('FILTRO_ANAGRAFE').AsString,
                                           IfThen(xOreImporti = 0,'O',IfThen(xOreImporti = 1,'I','E')),
                                           False);
  end;
end;

procedure TA063FBudgetGenerazioneMW.RiportoResiduoMensile(GruppoSel:String;Data:TDateTime);
var OreDiff,OreDiffEcc:Integer;
    CodGruppo,Tipo:String;
    Decorrenza:TDateTime;
    ImpDiff,ImpDiffEcc:Real;
    AggOre,AggImp:Boolean;
begin
  CodGruppo:=Trim(Copy(GruppoSel,1,10));
  Tipo:=Trim(Copy(GruppoSel,12,5));
  Decorrenza:=EncodeDate(StrToInt(Trim(Copy(GruppoSel,24,4))),StrToInt(Trim(Copy(GruppoSel,18,2))),1);
  if not selT713.SearchRecord('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([CodGruppo,Tipo,Decorrenza]),[srFromBeginning]) then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A063_MSG_FMT_GRUPPO,[CodGruppo,Tipo,Copy(GruppoSel,18,10)]) + A000MSG_A063_ERR_NO_TROV_BUDGET,'')
  end
  else
  begin
    //Controllo che il mese del quale riportare il residuo sia compreso nel periodo del budget selezionato
    if (Data < selT713.FieldByName('DECORRENZA').AsDateTime)
    or (Data > selT713.FieldByName('DECORRENZA_FINE').AsDateTime) then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A063_MSG_FMT_GRUPPO,[CodGruppo,Tipo,Copy(GruppoSel,18,10)]) + Format(A000MSG_A063_ERR_FMT_MESE_ESTERNO,[FormatDateTime('mm',Data)]),'')
    else
    begin
      OreDiff:=0;
      ImpDiff:=0;
      selT714.Close;
      selT714.SetVariable('CODGRUPPO',CodGruppo);
      selT714.SetVariable('TIPO',Tipo);
      selT714.SetVariable('DECORRENZA',Decorrenza);
      selT714.Open;
      while not selT714.Eof do
      begin
        if (EncodeDate(nAnno,selT714.FieldByName('MESE').AsInteger,1) = Data)
        and (selT714.RecNo <> selT714.RecordCount) then
        begin
          if Tipo = '#ECC#' then
          begin
            AggOre:=R180OreMinutiExt(selT714.FieldByName('ORE_FRUITO').AsString) <> 0;
            OreDiff:=R180OreMinutiExt(selT713.FieldByName('ORE').AsString) - R180OreMinutiExt(selT714.FieldByName('ORE_FRUITO').AsString);
            OreDiffEcc:=0;
            AggImp:=selT714.FieldByName('IMPORTO_FRUITO').AsFloat <> 0;
            ImpDiff:=selT713.FieldByName('IMPORTO').AsFloat - selT714.FieldByName('IMPORTO_FRUITO').AsFloat;
            ImpDiffEcc:=0;
          end
          else
          begin
            OreDiff:=R180OreMinutiExt(selT714.FieldByName('ORE_FRUITO').AsString) - R180OreMinutiExt(selT714.FieldByName('ORE').AsString);
            ImpDiff:=selT714.FieldByName('IMPORTO_FRUITO').AsFloat - selT714.FieldByName('IMPORTO').AsFloat;
            if (OreDiff <> 0) or (ImpDiff <> 0) then
            begin
              updT714.SetVariable('CODGRUPPO',CodGruppo);
              updT714.SetVariable('TIPO',Tipo);
              updT714.SetVariable('DECORRENZA',Decorrenza);
              updT714.SetVariable('MESE',selT714.FieldByName('MESE').AsInteger);
              updT714.SetVariable('ORE',IfThen(xOreImporti <> 1,'ORE_FRUITO','ORE'));
              updT714.SetVariable('IMPORTO',IfThen(xOreImporti <> 0,'IMPORTO_FRUITO','IMPORTO'));
              updT714.Execute;
            end;
          end;
        end
        else if (EncodeDate(nAnno,selT714.FieldByName('MESE').AsInteger,1) > Data) then
        begin
          if Tipo = '#ECC#' then
          begin
            if selT714.RecNo = selT714.RecordCount then
            begin
              OreDiffEcc:=OreDiff;
              ImpDiffEcc:=ImpDiff;
            end
            else
            begin
              OreDiffEcc:=(OreDiff div (R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime) - R180Mese(Data))) * (selT714.FieldByName('MESE').AsInteger - R180Mese(Data));
              ImpDiffEcc:=(ImpDiff / (R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime) - R180Mese(Data))) * (selT714.FieldByName('MESE').AsInteger - R180Mese(Data));
            end;
            updT714.SetVariable('CODGRUPPO',CodGruppo);
            updT714.SetVariable('TIPO',Tipo);
            updT714.SetVariable('DECORRENZA',Decorrenza);
            updT714.SetVariable('MESE',selT714.FieldByName('MESE').AsInteger);
            updT714.SetVariable('ORE',IfThen((xOreImporti <> 1) and AggOre,QuotedStr(R180MinutiOre(OreDiffEcc)),'ORE'));
            updT714.SetVariable('IMPORTO',IfThen((xOreImporti <> 0) and AggImp,StringReplace(FloatToStr(ImpDiffEcc),',','.',[rfReplaceAll]),'IMPORTO'));
            updT714.Execute;
          end
          else
          begin
            updT714.SetVariable('CODGRUPPO',CodGruppo);
            updT714.SetVariable('TIPO',Tipo);
            updT714.SetVariable('DECORRENZA',Decorrenza);
            updT714.SetVariable('MESE',selT714.FieldByName('MESE').AsInteger);
            updT714.SetVariable('ORE',IfThen(xOreImporti <> 1,QuotedStr(R180MinutiOre(R180OreMinutiExt(selT714.FieldByName('ORE').AsString) - OreDiff)),'ORE'));
            updT714.SetVariable('IMPORTO',IfThen(xOreImporti <> 0,StringReplace(FloatToStr(selT714.FieldByName('IMPORTO').AsFloat - ImpDiff),',','.',[rfReplaceAll]),'IMPORTO'));
            updT714.Execute;
            Break;
          end;
        end;
        selT714.Next;
      end;
    end;
  end;
end;

procedure TA063FBudgetGenerazioneMW.ControlloFiltriAnagrafe_1;
var S:String;
    AggAnom:Boolean;
begin
  selbV430.Close;
  S:=StringReplace(QVistaOracle,
                   ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                   ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                   [rfIgnoreCase]);
  S:=StringReplace(S,
                   ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                   ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                   [rfIgnoreCase]);
  selbV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
  selbV430.SetVariable('C700DATADAL',selaT713.FieldByName('DECORRENZA').AsDateTime);
  selbV430.SetVariable('DATALAVORO',selaT713.FieldByName('DECORRENZA_FINE').AsDateTime);
  selbV430.SetVariable('FILTRO',selaT713.FieldByName('FILTRO_ANAGRAFE').AsString);
  selbV430.Open;
  while not selbV430.Eof do
  begin
    cdsDip.Filter:='PROGRESSIVO = ' + selbV430.FieldByName('PROGRESSIVO').AsString;
    cdsDip.Filtered:=True;
    while not cdsDip.Eof do
    begin
      if (selbV430.FieldByName('DA').AsDateTime <= cdsDip.FieldByName('A').AsDateTime)
      and (selbV430.FieldByName('A').AsDateTime >= cdsDip.FieldByName('DA').AsDateTime)
      and (selaT713.FieldByName('CODGRUPPO').AsString <> cdsDip.FieldByName('CODGRUPPO').AsString) then
      begin
        AggAnom:=False;
        cdsAnom.Filter:='PROGRESSIVO = ' + selbV430.FieldByName('PROGRESSIVO').AsString +
                        ' AND CODGRUPPO1 = ''' + cdsDip.FieldByName('CODGRUPPO').AsString + '''' +
                        ' AND CODGRUPPO2 = ''' + selaT713.FieldByName('CODGRUPPO').AsString + '''';
        cdsAnom.Filtered:=True;
        while not cdsAnom.Eof do
        begin
          if selbV430.FieldByName('DA').AsDateTime = cdsAnom.FieldByName('A').AsDateTime + 1 then
          begin
            cdsAnom.Edit;
            cdsAnom.FieldByName('A').AsDateTime:=selbV430.FieldByName('A').AsDateTime;
            cdsAnom.Post;
            AggAnom:=True;
          end;
          cdsAnom.Next;
        end;
        cdsAnom.Filtered:=False;
        if not AggAnom then
        begin
          cdsAnom.Append;
          cdsAnom.FieldByName('PROGRESSIVO').AsInteger:=selbV430.FieldByName('PROGRESSIVO').AsInteger;
          cdsAnom.FieldByName('CODGRUPPO1').AsString:=cdsDip.FieldByName('CODGRUPPO').AsString;
          cdsAnom.FieldByName('CODGRUPPO2').AsString:=selaT713.FieldByName('CODGRUPPO').AsString;
          cdsAnom.FieldByName('DA').AsDateTime:=cdsDip.FieldByName('DA').AsDateTime;
          cdsAnom.FieldByName('A').AsDateTime:=cdsDip.FieldByName('A').AsDateTime;
          cdsAnom.Post;
        end;
      end;
      cdsDip.Next;
    end;
    cdsDip.Filtered:=False;
    selbV430.Next;
  end;
  selbV430.First;
  while not selbV430.Eof do
  begin
    cdsDip.Append;
    cdsDip.FieldByName('PROGRESSIVO').AsInteger:=selbV430.FieldByName('PROGRESSIVO').AsInteger;
    cdsDip.FieldByName('CODGRUPPO').AsString:=selaT713.FieldByName('CODGRUPPO').AsString;
    cdsDip.FieldByName('DA').AsDateTime:=selbV430.FieldByName('DA').AsDateTime;
    cdsDip.FieldByName('A').AsDateTime:=selbV430.FieldByName('A').AsDateTime;
    cdsDip.Post;
    selbV430.Next;
  end;
end;

procedure TA063FBudgetGenerazioneMW.ControlloFiltriAnagrafe_2;
begin
  cdsAnom.First;
  while not cdsAnom.Eof do
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A063_ERR_FMT_DIP_2_GRUPPI,
                                              [cdsAnom.FieldByName('CODGRUPPO1').AsString,
                                               cdsAnom.FieldByName('CODGRUPPO2').AsString,
                                               cdsAnom.FieldByName('DA').AsString,
                                               cdsAnom.FieldByName('A').AsString])
                                      ,Parametri.Azienda,cdsAnom.FieldByName('PROGRESSIVO').AsInteger);
    cdsAnom.Next;
  end;
end;

procedure TA063FBudgetGenerazioneMW.DuplicazioneGruppi(GruppoSel:String);
var CodGruppo,Tipo:String;
    Decorrenza,DecIniNew,DecFinNew:TDateTime;
begin
  CodGruppo:=Trim(Copy(GruppoSel,1,10));
  Tipo:=Trim(Copy(GruppoSel,12,5));
  Decorrenza:=EncodeDate(StrToInt(Trim(Copy(GruppoSel,24,4))),StrToInt(Trim(Copy(GruppoSel,18,2))),1);
  DecIniNew:=EncodeDate(nAnnoDup,StrToInt(Trim(Copy(GruppoSel,18,2))),1);
  DecFinNew:=R180FineMese(EncodeDate(nAnnoDup,StrToInt(Trim(Copy(GruppoSel,21,2))),1));
  if not selT713.SearchRecord('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([CodGruppo,Tipo,Decorrenza]),[srFromBeginning]) then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A063_MSG_FMT_GRUPPO,[CodGruppo,Tipo,Copy(GruppoSel,18,10)]) + A000MSG_A063_ERR_NO_TROV_BUDGET,'')
  end
  else
  begin
    selbT713.Close;
    selbT713.SetVariable('CODGRUPPO',CodGruppo);
    selbT713.SetVariable('DECORRENZA',DecIniNew);
    selbT713.SetVariable('DECORRENZA_FINE',DecFinNew);
    selbT713.Open;
    if selbT713.SearchRecord('TIPO',VarArrayOf([Tipo]),[srFromBeginning]) then
    begin
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A063_MSG_FMT_GRUPPO,[CodGruppo,Tipo,Copy(GruppoSel,18,6) + IntToStr(nAnnoDup)]) + A000MSG_A063_ERR_BUDGET_ESISTE,'');
      Exit;
    end
    else if (selbT713.RecordCount > 0)
    and (   (DecIniNew <> selbT713.FieldByName('DECORRENZA').AsDateTime)
         or (DecFinNew <> selbT713.FieldByName('DECORRENZA_FINE').AsDateTime)) then
    begin
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A063_MSG_FMT_GRUPPO,[CodGruppo,Tipo,Copy(GruppoSel,18,6) + IntToStr(nAnnoDup)]) + Format(A000MSG_A063_ERR_FMT_BUDGET_ESISTE_PERIODO,[selbT713.FieldByName('TIPO').AsString,FormatDateTime('mm',selbT713.FieldByName('DECORRENZA').AsDateTime),FormatDateTime('mm/yyyy',selbT713.FieldByName('DECORRENZA_FINE').AsDateTime)]),'');
      Exit;
    end;
    try
      insT713.SetVariable('CODGRUPPO',CodGruppo);
      insT713.SetVariable('TIPO',Tipo);
      insT713.SetVariable('DECORRENZA',DecIniNew);
      insT713.SetVariable('DECORRENZA_FINE',DecFinNew);
      insT713.SetVariable('ANNO',nAnnoDup);
      insT713.SetVariable('DESCRIZIONE',selT713.FieldByName('DESCRIZIONE').AsString);
      insT713.SetVariable('FILTRO_ANAGRAFE',selT713.FieldByName('FILTRO_ANAGRAFE').AsString);
      insT713.SetVariable('ORE',selT713.FieldByName('ORE').AsString);
      insT713.SetVariable('IMPORTO',selT713.FieldByName('IMPORTO').AsFloat);
      insT713.Execute;
      CalcoloBudgetMensile(CodGruppo,Tipo,DecIniNew,DecFinNew,DecFinNew,selT713.FieldByName('ORE').AsString,selT713.FieldByName('IMPORTO').AsFloat,True,True);
    except
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A063_MSG_FMT_GRUPPO,[CodGruppo,Tipo,Copy(GruppoSel,18,6) + IntToStr(nAnnoDup)]) + A000MSG_A063_ERR_INSERIMENTO,'');
    end;
  end;
end;

procedure TA063FBudgetGenerazioneMW.PulisciVariabili;
begin
  if Assigned(evtClearKeys) then
    evtClearKeys;
end;

end.
