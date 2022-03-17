unit Ac08URegistraIndFunzioneMW;

interface

uses
  R005UDataModuleMW, DB, OracleData, Classes, Oracle, SysUtils, StrUtils, Variants, Math,
  A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali, QueryStorico, R500Lin, Rp502Pro, DatiBloccati;

type
  TAc08Dlg = procedure(Msg:String) of object;

  TAc08FRegistraIndFunzioneMW = class(TR005FDataModuleMW)
    delCSI006: TOracleQuery;
    selCSI004: TOracleDataSet;
    selCSI005: TOracleDataSet;
    selCSI006ID: TOracleQuery;
    selCSI006: TOracleDataSet;
    selCSI007: TOracleDataSet;
    selT162: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    dCorr:TDateTime;
    QSIndFunz:TQueryStorico;
    R502ProDtM1:TR502ProDtM1;
    selDatiBloccati: TDatiBloccati;
    Ac08OreIndFascia:array[1..28] of integer;
    //Ac08PuntoNominale:Integer;
    function GetTimbratureEffettive:String;
    function GetGiustificativi:String;
    procedure GestioneAnomalie(sMsgAnomalia:String);
    procedure CalcolaOreIndFunzione;
  public
    Operazione:String;
    evtRichiesta: TAc08Dlg;
    dDallaData,dAllaData:TDateTime;
    procedure Controlli;
    procedure Domande;
    procedure InizioElaborazione;
    procedure ElaboraDipendente;
    procedure FineElaborazione;
  end;

implementation

{$R *.dfm}


procedure TAc08FRegistraIndFunzioneMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  selDatiBloccati.TipoLog:='';
end;

procedure TAc08FRegistraIndFunzioneMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selDatiBloccati);
  inherited;
end;

procedure TAc08FRegistraIndFunzioneMW.Controlli;
begin
  if dDallaData > dAllaData then
    raise Exception.Create(A000MSG_ERR_DATE_INVERTITE);
  if FormatDateTime('mm/yyyy',dDallaData) <> FormatDateTime('mm/yyyy',dAllaData) then
    raise Exception.Create(A000MSG_Ac08_ERR_DATE_STESSO_MESE);
  if Operazione = '' then
    raise Exception.Create(A000MSG_Ac08_ERR_NO_OPERAZIONE);
end;

procedure TAc08FRegistraIndFunzioneMW.Domande;
begin
  if SelAnagrafe.RecordCount = 0 then
    raise Exception.Create(A000MSG_ERR_NO_DIP);
  if Assigned(evtRichiesta) then
    evtRichiesta(Format(A000MSG_Ac08_DLG_FMT_ELABORAZIONE,[IfThen(Operazione = 'I','il calcolo','l''annullamento'),IntToStr(SelAnagrafe.RecordCount),DateToStr(dDallaData),DateToStr(dAllaData)]));
end;

procedure TAc08FRegistraIndFunzioneMW.InizioElaborazione;
begin
  RegistraMsg.IniziaMessaggio(NomeOwner);
  if Operazione = 'C' then
    exit;
  R502ProDtM1:=TR502ProDtM1.Create(nil);
  R502ProDtM1.PeriodoConteggi(dDallaData,dAllaData);
  R502ProDtM1.Conteggi('APERTURA',0,dDallaData);
  QSIndFunz:=TQueryStorico.Create(nil);
end;

procedure TAc08FRegistraIndFunzioneMW.ElaboraDipendente;
var CodContratto,CodIndFunz,CodFascia,FasceEsaminate,
    OreCalc,DisCalc,OreRecA,DisRecA,IndRecA:String;
    IDRegola,CSI006ID,i,OreIndFunz,ResiduoDisagioSerale:Integer;
    bIns:Boolean;
  procedure VerificaEsisteRegolaContratto;
  begin
    R180SetVariable(selCSI004,'CONTRATTO',CodContratto);
    R180SetVariable(selCSI004,'DATA',dCorr);
    selCSI004.Open;
    //IDRegola:=VarToStr(selCSI004.Lookup('CODICE',CodIndFunz,'ID'));
    //if IDRegola <> '' then
    if not selCSI004.SearchRecord('CODICE',CodIndFunz,[srfromBeginning]) then
      raise exception.Create(Format(A000MSG_Ac08_ERR_FMT_NO_REGOLA_CONTRATTO,[CodContratto,Parametri.CampiRiferimento.C3_Indennita_Funzione,CodIndFunz]));
    IDRegola:=selCSI004.FieldByName('ID').AsInteger;
  end;
  procedure AggiornaDatiTestata;
  begin
    selCSI006.Edit;
    selCSI006.FieldByName('TIMBRATURE').AsString:=GetTimbratureEffettive;
    selCSI006.FieldByName('GIUSTIFICATIVI').AsString:=GetGiustificativi;
    selCSI006.FieldByName('ORARIO').AsString:=R502ProDtM1.c_orario;
    selCSI006.FieldByName('ORE_ASSENZA').AsString:=R180MinutiOre(R502ProDtM1.minassenze);
    selCSI006.FieldByName('ORE_RESE').AsString:=R180MinutiOre(R502ProDtM1.OreReseTotali);
    selCSI006.Post;
  end;
  procedure AssegnaDatiDettaglio;
  begin
    selCSI007.Edit;
    selCSI007.FieldByName('ORE').AsString:=OreCalc;
    selCSI007.FieldByName('DISAGIO_SERALE').AsString:=DisCalc;
    selCSI007.FieldByName('INDFUNZIONE').AsString:=CodIndFunz;
    selCSI007.Post;
  end;
  procedure InserisciDettaglio;
  var nRec:Integer;
  begin
    for nRec:=1 to 2 do
    begin
      selCSI007.Append;
      selCSI007.FieldByName('ID').AsInteger:=CSI006ID;
      selCSI007.FieldByName('TIPO_RECORD').AsString:=IfThen(nRec = 1,'A','M');
      selCSI007.FieldByName('FASCIA').AsString:=CodFascia;
      selCSI007.FieldByName('INDFUNZIONE').AsString:=CodIndFunz;
      selCSI007.Post;
      AssegnaDatiDettaglio;
    end;
    if VarToStr(selCSI005.Lookup('FASCIA',CodFascia,'FASCIA')) <> CodFascia then
      GestioneAnomalie('Anomalia non bloccante: ' + Format(A000MSG_Ac08_ERR_FMT_NO_REGOLA_FASCIA,[CodFascia,CodContratto,Parametri.CampiRiferimento.C3_Indennita_Funzione,CodIndFunz]));
  end;
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(dDallaData),'CSI006') then
  begin
    RegistraMsg.InserisciMessaggio('B',selDatiBloccati.MessaggioLog,'',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    exit;
  end;
  if Operazione = 'C' then
  begin
    //cancello dati precedentemente registrati
    delCSI006.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    delCSI006.SetVariable('PeriodoDa',dDallaData);
    delCSI006.SetVariable('PeriodoA',dAllaData);
    delCSI006.Execute;
    SessioneOracle.Commit;
    exit;
  end;
  QSIndFunz.Session:=SessioneOracle;
  QSIndFunz.GetDatiStorici('T430CONTRATTO,T430IPRESENZA,T430' + Parametri.CampiRiferimento.C3_Indennita_Funzione,SelAnagrafe.FieldByName('Progressivo').AsInteger,dDallaData,dAllaData);
  dCorr:=dDallaData;
  while dCorr <= dAllaData do
  begin
    QSIndFunz.LocDatoStorico(dCorr); //Leggo i dati storici giorno per giorno
    CodContratto:=Trim(QSIndFunz.FieldByName('T430CONTRATTO').AsString);
    CodIndFunz:=Trim(QSIndFunz.FieldByName('T430' + Parametri.CampiRiferimento.C3_Indennita_Funzione).AsString);
    try
      //verifico se erano già stati registrati dei dati
      selCSI006.Close;
      selCSI006.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      selCSI006.SetVariable('Data',dCorr);
      selCSI006.Open;
      //Leggo regole di calcolo dell'indennità di presenza di tipo = 'I'
      R180SetVariable(selT162,'IPRESENZA',QSIndFunz.FieldByName('T430IPRESENZA').AsString);
      selT162.Open;
      if selT162.RecordCount = 0 then
        raise exception.Create(A000MSG_Ac08_ERR_NO_INDPRES_ANAG);
      if CodIndFunz = '' then
        raise exception.Create(Format(A000MSG_Ac08_ERR_FMT_NO_INDFUNZIONE_ANAG,[Parametri.CampiRiferimento.C3_Indennita_Funzione]));
      //Alberto 08/02/2019: la regola è sempre da leggere
      //if selCSI006.RecordCount > 0 then
      VerificaEsisteRegolaContratto;
      selCSI007.Close;
      selCSI007.SetVariable('ID',selCSI006.FieldByName('ID').AsInteger);
      selCSI007.Open;
      //conteggi giornalieri
      R502ProDtM1.Conteggi('Cartolina',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,dCorr);
      CalcolaOreIndFunzione;

      bIns:=False;
      for i:=1 to R502ProDtM1.n_fasce do
        //if R502ProDtM1.tminlav[i] > 0 then
        if Ac08OreIndFascia[i] > 0 then
        begin
          bIns:=True;
          Break;
        end;
      if bIns or (selCSI006.RecordCount > 0) then
      begin
        //Alberto 08/02/2019: la regola è già stata letta
        //if selCSI006.RecordCount = 0 then
        //  VerificaEsisteRegolaContratto;
        R180SetVariable(selCSI005,'ID',IDRegola);
        selCSI005.Open;
        if bIns and (selCSI006.RecordCount > 0) then
        begin
          //modifica
          AggiornaDatiTestata;
          //esamino il dettaglio
          CSI006ID:=selCSI006.FieldByName('ID').AsInteger;
          FasceEsaminate:='';
          ResiduoDisagioSerale:=R502ProDtM1.DisagioSerale;
          for i:=R502ProDtM1.n_fasce downto 1 do
          begin
            //OreIndFunz:=R502ProDtM1.tminlav[i];
            OreIndFunz:=Ac08OreIndFascia[i];
            if OreIndFunz > 0 then
            begin
              CodFascia:=R502ProDtM1.tfasceorarie[i].tcodfasc;
              FasceEsaminate:=FasceEsaminate + IfThen(FasceEsaminate <> '',',') + CodFascia;
              OreCalc:=R180MinutiOre(OreIndFunz);
              DisCalc:=R180MinutiOre(Min(OreIndFunz,ResiduoDisagioSerale));
              ResiduoDisagioSerale:=ResiduoDisagioSerale - Min(OreIndFunz,ResiduoDisagioSerale);
              if not selCSI007.SearchRecord('TIPO_RECORD;FASCIA',VarArrayOf(['A',CodFascia]),[srFromBeginning]) then
                InserisciDettaglio
              else
              begin
                OreRecA:=selCSI007.FieldByName('ORE').AsString;
                DisRecA:=selCSI007.FieldByName('DISAGIO_SERALE').AsString;
                IndRecA:=selCSI007.FieldByName('INDFUNZIONE').AsString;
                if (OreRecA <> OreCalc)
                or (DisRecA <> DisCalc)
                or (IndRecA <> CodIndFunz) then
                begin
                  AssegnaDatiDettaglio;//aggiorno dati record automatico
                  if not selCSI007.SearchRecord('TIPO_RECORD;FASCIA;ORE;DISAGIO_SERALE;INDFUNZIONE',
                                                VarArrayOf(['M',
                                                            CodFascia,
                                                            OreRecA,
                                                            DisRecA,
                                                            IndRecA]),[srFromBeginning]) then
                  begin
                    selCSI007.SearchRecord('TIPO_RECORD;FASCIA',VarArrayOf(['M',CodFascia]),[srFromBeginning]);
                    while selCSI007.SearchRecord('TIPO_RECORD;FASCIA',VarArrayOf(['M',CodFascia]),[]) do
                      selCSI007.Delete; //cancello tutti i record manuali successivi al primo
                    GestioneAnomalie(Format(A000MSG_Ac08_MSG_FMT_DATI_CANCELLATI,['per la fascia ' + CodFascia]));
                    selCSI007.SearchRecord('TIPO_RECORD;FASCIA',VarArrayOf(['M',CodFascia]),[srFromBeginning]);
                  end;
                  AssegnaDatiDettaglio; //aggiorno dati record manuale rimasto
                end;
              end;
            end;
          end;
          //scorro i vecchi record di fasce da cancellare
          selCSI007.First;
          while not selCSI007.Eof do
          begin
            //segnalo l'anomalia solo se i record manuali erano diversi da quello automatico
            if selCSI007.FieldByName('TIPO_RECORD').AsString = 'A' then
              if not R180InConcat(selCSI007.FieldByName('FASCIA').AsString,FasceEsaminate) then
                if VarToStr(selCSI007.Lookup('TIPO_RECORD;FASCIA;ORE;DISAGIO_SERALE;INDFUNZIONE',
                                             VarArrayOf(['M',
                                                         selCSI007.FieldByName('FASCIA').AsString,
                                                         selCSI007.FieldByName('ORE').AsString,
                                                         selCSI007.FieldByName('DISAGIO_SERALE').AsString,
                                                         selCSI007.FieldByName('INDFUNZIONE').AsString]),
                                             'TIPO_RECORD')) = '' then
                  GestioneAnomalie(Format(A000MSG_Ac08_MSG_FMT_DATI_CANCELLATI,['per la fascia ' + selCSI007.FieldByName('FASCIA').AsString]));
            selCSI007.Next;
          end;
          //cancello i vecchi record (automatici e manuali)
          selCSI007.Last;
          while not selCSI007.Bof do
          begin
            if not R180InConcat(selCSI007.FieldByName('FASCIA').AsString,FasceEsaminate) then
              selCSI007.Delete
            else
              selCSI007.Prior;
          end;
        end
        else if selCSI006.RecordCount > 0 then  //and not bIns
        begin
          //cancellazione
          while not selCSI007.Eof do
          begin
            if selCSI007.FieldByName('TIPO_RECORD').AsString = 'M' then
              if VarToStr(selCSI007.Lookup('TIPO_RECORD;FASCIA;ORE;DISAGIO_SERALE;INDFUNZIONE',
                                           VarArrayOf(['A',
                                                       selCSI007.FieldByName('FASCIA').AsString,
                                                       selCSI007.FieldByName('ORE').AsString,
                                                       selCSI007.FieldByName('DISAGIO_SERALE').AsString,
                                                       selCSI007.FieldByName('INDFUNZIONE').AsString]),
                                           'TIPO_RECORD')) = '' then
                raise exception.Create(' ');//testo fittizio per cancellare E forzare registrazione anomalia
            selCSI007.Next;
          end;
          raise exception.Create('');//testo vuoto per cancellare SENZA forzare registrazione anomalia
        end
        else //bIns and (selCSI006.RecordCount = 0)
        begin
          //inserimento
          //Prelevo nuova sequenza per inserimento
          selCSI006ID.ClearVariables;
          selCSI006ID.Execute;
          CSI006ID:=selCSI006ID.GetVariable('New_ID');
          // e registra su CSI006 e CSI007.
          selCSI006.Append;
          selCSI006.FieldByName('ID').AsInteger:=CSI006ID;
          selCSI006.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('Progressivo').AsInteger;
          selCSI006.FieldByName('DATA').AsDateTime:=dCorr;
          selCSI006.Post;
          AggiornaDatiTestata;
          ResiduoDisagioSerale:=R502ProDtM1.DisagioSerale;
          for i:=R502ProDtM1.n_fasce downto 1 do
          begin
            //OreIndFunz:=R502ProDtM1.tminlav[i];
            OreIndFunz:=Ac08OreIndFascia[i];
            if OreIndFunz > 0 then
            begin
              CodFascia:=R502ProDtM1.tfasceorarie[i].tcodfasc;
              OreCalc:=R180MinutiOre(OreIndFunz);
              DisCalc:=R180MinutiOre(Min(OreIndFunz,ResiduoDisagioSerale));
              ResiduoDisagioSerale:=ResiduoDisagioSerale - Min(OreIndFunz,ResiduoDisagioSerale);
              InserisciDettaglio;
            end;
          end;
        end;
        SessioneOracle.Commit;
      end;
    except
      on E:Exception do
      begin
        SessioneOracle.Rollback;
        if selCSI006.RecordCount > 0 then
        begin
          //cancello dati precedentemente registrati
          delCSI006.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
          delCSI006.SetVariable('PeriodoDa',dCorr);
          delCSI006.SetVariable('PeriodoA',dCorr);
          delCSI006.Execute;
        end;
        if E.Message <> '' then
          GestioneAnomalie(Trim(E.Message + IfThen(selCSI006.RecordCount > 0,' ' + Format(A000MSG_Ac08_MSG_FMT_DATI_CANCELLATI,['']))));
        SessioneOracle.Commit;
      end;
    end;
    dCorr:=dCorr + 1;
  end;
end;

procedure TAc08FRegistraIndFunzioneMW.CalcolaOreIndFunzione;
{Calcolo copiato da TR400FCartellinoDtM.x145_rpggIndTurnoI per conteggiare l'indennità oraria per Comune di Torino}
var i,j,k,fm:Integer;
    (*ITIOreTimbLorde,*)ITIDebito,ITIOreTimb,ITIGGPres,ITIOreFT,ITIOreAss,IndiceTurnoPrec:Integer;
    ITICauAss,ITIRaggrCauPres:String;
    App,DetrazAssenze:Integer;
    T1,T2,cT1,cT2:Integer;
    T162Assenze,T162AssenzeAbilitate,T162PianifNO:String;
    T162OffsetMetaDebito,T162OffsetGGPrec:Integer;
begin
  with R502ProDtM1 do
  begin
    cT1:=c_turni1;
    cT2:=c_turni2;
    if cT1 >= 0 then
      cT1:=ValNumT021['NUMTURNO',TF_PUNTI_NOMINALI,c_turni1];
    if cT2 >= 0 then
      cT2:=ValNumT021['NUMTURNO',TF_PUNTI_NOMINALI,c_turni2];
    T1:=Max(n_turno1,cT1);
    T2:=Max(n_turno2,cT2);
  end;
  T162OffsetGGPrec:=-1;
  if (selT162.FindField('OFFSET_GGPREC') <> nil) and (not selT162.FieldByName('OFFSET_GGPREC').IsNull) then T162OffsetGGPrec:=R180OreMinutiExt(selT162.FieldByName('OFFSET_GGPREC').AsString);
  T162PianifNO:='S';
  if selT162.FindField('PIANIF_NOOP') <> nil then T162PianifNO:=selT162.FieldByName('PIANIF_NOOP').AsString;
  if T162PianifNO = 'S' then
  begin
    T1:=IfThen(R502ProDtM1.TurnoProvv1 in [1..4],R502ProDtM1.TurnoProvv1,T1);
    T2:=IfThen(R502ProDtM1.TurnoProvv2 in [1..4],R502ProDtM1.TurnoProvv2,T2);
  end;
  for j:=1 to High(Ac08OreIndFascia) do
    Ac08OreIndFascia[j]:=0;

  //Lettura dei parametri per il riconoscimento giornaliero
  (*Alberto 08/02/2019: Questi parametri sono stati trasferiti da T162 a CSI004, utilizzando un solo parametro ASSENZE_TOLLERATE
  T162Assenze:=selT162.FieldByName('ASSENZE').AsString; //Assenze da conteggiare
  T162AssenzeAbilitate:=selT162.FieldByName('ASSENZE_ABILITATE').AsString; //Assenze tollerate
  *)
  T162Assenze:=selCSI004.FieldByName('ASSENZE_TOLLERATE').AsString;//selCSI004.FieldByName('ASSENZE_CONTEGGIATE').AsString;
  T162AssenzeAbilitate:=selCSI004.FieldByName('ASSENZE_TOLLERATE').AsString;

  T162OffsetMetaDebito:=30;
  if selT162.FindField('OFFSET_METADEBITO') <> nil then T162OffsetMetaDebito:=selT162.FieldByName('OFFSET_METADEBITO').AsInteger;
  ITIOreAss:=0;
  with TStringList.Create do
  try
    CommaText:=T162Assenze;
    for j:=0 to Count - 1 do
    begin
      if not R180InConcat(Strings[j],T162AssenzeAbilitate) then
        inc(ITIOreAss,R502ProDtM1.RiepAssenza[Strings[j],'HHRESE']);
    end;
  finally
    Free;
  end;
  (*Alberto 24/01/2011: riduco la decurtazione da assenze (cfr. chiamata ID 57354)
    DetrazTotLav contiene le detrazioni delle ore rese dovute agli arrotondamenti dell'eccedenza giornaliera
    Non considero DetrazTotLav nelle assenze che vanno ad abbassare le ore da timbratura*)
  DetrazAssenze:=R502ProDtM1.minassenze - min(R502ProDtM1.DetrazTotLav,R502ProDtM1.minassenze);
  //ITIOreTimb:=min(R502ProDtM1.totlav - DetrazAssenze,ITIOreTimbLorde) (*+ ITIOreAss*);
  ITIOreTimb:=R502ProDtM1.debitogg;//Vogliono così!
  ITIOreFT:=R502ProDtM1.totlav;
  ITIDebito:=R502ProDtM1.debitogg;
  ITIGGPres:=R502ProDtM1.ggpresenza;
  ITICauAss:='';
  for j:=1 to R502ProDtM1.n_riepasse do
    if not R180InConcat(R502ProDtM1.triepgiusasse[j].tcausasse,T162AssenzeAbilitate) then
      dec(ITIOreTimb,R502ProDtM1.triepgiusasse[j].tminresasse);
  for j:=0 to High(R502ProDtM1.GiustificativiDelGiorno) do
    if R180InConcat(R502ProDtM1.GiustificativiDelGiorno[0].tcausgius,T162AssenzeAbilitate) then
      ITICauAss:=ITICAuAss + IfThen(j > 0,',','') + R502ProDtM1.GiustificativiDelGiorno[0].tcausgius;
  //Verifica che il turno effettuato risponda ai requisiti necessari
  if (T1 + T2 > 0) and True(*((ITIDebito / 2 + T162OffsetMetaDebito) < ITIOreTimb)*) and
     ((ITIGGPres = 1) or ((ITIGGPres = 0) or (ITICauAss <> ''))) then
  begin
    DetrazAssenze:=min(R502ProDtM1.DetrazTotLav,ITIOreAss);
    inc(ITIOreTimb,ITIOreAss - DetrazAssenze);
  end
  else
  begin
    ITIOreTimb:=0;
    ITIOreFT:=0;
  end;
  //Calcolo delle ore rese in fasce
  K:=min(min(ITIOreTimb,ITIDebito),ITIOreFT);
  for j:=R502ProDtM1.n_fasce downto 1 do
  begin
    App:=max(0,min(R502ProDtM1.tminlav[j] - R502ProDtM1.tminstrgio[j],K));
    Ac08OreIndFascia[j]:=App;
    dec(k,App);
  end;
  (*Arrotondamento alla mezz'ora per difetto: il resto viene riportato sulla fascia precedente*)
  for j:=High(Ac08OreIndFascia) downto 2 do
  begin
    inc(Ac08OreIndFascia[j - 1],Ac08OreIndFascia[j] mod 30);
    dec(Ac08OreIndFascia[j],Ac08OreIndFascia[j] mod 30);
  end;
  //Cumulo le ore sulla stessa fascia, in modo da non dover gestire la registrazione su CSI007 di fasce uguali
  for j:=R502ProDtM1.n_fasce downto 2 do
  begin
    //OreIndFunz:=R502ProDtM1.tminlav[i];
    for k:=j - 1 downto 1 do
    begin
      if R502ProDtM1.tfasceorarie[j].tcodfasc = R502ProDtM1.tfasceorarie[k].tcodfasc then
      begin
        inc(Ac08OreIndFascia[k],Ac08OreIndFascia[j]);
        Ac08OreIndFascia[j]:=0;
        Break;
      end;
    end;
  end;
end;

procedure TAc08FRegistraIndFunzioneMW.FineElaborazione;
begin
  if Operazione = 'C' then
    exit;
  QSIndFunz.Free;
  FreeAndNil(R502ProDtM1);
end;

function TAc08FRegistraIndFunzioneMW.GetTimbratureEffettive:String;
{Timbrature lette da T100_TIMBRATURE}
var i:Integer;
    S:String;
begin
  Result:='';
  with R502ProDtM1 do
    for i:=0 to High(TimbratureDelGiorno) do
      if TimbratureDelGiorno[i].tversotimb <> '' then
      begin
        if Result <> '' then
          Result:=Result + ' ';
        S:=TimbratureDelGiorno[i].tversotimb + R180MinutiOre(TimbratureDelGiorno[i].toratimb);
        Delete(S,Pos('.',S),1);
        Result:=Result + S;
        if TimbratureDelGiorno[i].tcaustimb <> '' then
          Result:=Result + '-' + TimbratureDelGiorno[i].tcaustimb;
      end;
end;

function TAc08FRegistraIndFunzioneMW.GetGiustificativi:String;
{Giustificativi letti da T040_GIUSTIFICATIVI}
var i:Integer;
    S:String;
begin
  Result:='';
  with R502ProDtM1 do
    for i:=0 to High(GiustificativiDelGiorno) do
      if GiustificativiDelGiorno[i].tcausgius <> '' then
      begin
        case GiustificativiDelGiorno[i].ttipogius of
          'I':S:='GG:' + GiustificativiDelGiorno[i].tcausgius;
          'M':S:='MG:' + GiustificativiDelGiorno[i].tcausgius;
          'N':begin
              S:=R180MinutiOre(GiustificativiDelGiorno[i].tdallegius);
              Delete(S,Pos('.',S),1);
              S:=S + ':' + GiustificativiDelGiorno[i].tcausgius;
              end;
          'D':begin
              S:=R180MinutiOre(GiustificativiDelGiorno[i].tdallegius);
              Delete(S,Pos('.',S),1);
              S:=S + '-' + R180MinutiOre(GiustificativiDelGiorno[i].tallegius);
              Delete(S,Pos('.',S),1);
              S:=S + ':' + GiustificativiDelGiorno[i].tcausgius;
              end;
        end;
        if Result <> '' then
          Result:=Result + ' ';
        Result:=Result + S;
      end;
end;

procedure TAc08FRegistraIndFunzioneMW.GestioneAnomalie(sMsgAnomalia:String);
begin
  RegistraMsg.InserisciMessaggio('A','Data: ' + DateToStr(dCorr) + '. ' + sMsgAnomalia,'',SelAnagrafe.FieldByName('Progressivo').AsInteger);
end;

end.
