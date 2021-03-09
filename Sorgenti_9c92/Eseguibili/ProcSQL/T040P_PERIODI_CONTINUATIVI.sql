create or replace procedure T040P_PERIODI_CONTINUATIVI(
/*
  Questa procedure estrae i dati dei periodi continuativi di fruizione
  all'interno del periodo di cumulo per una specifica causale 
  (e relative causali nel cumulo / raggruppamento)
  fino ad una data di riferimento.

  Al momento è propedeutica ai calcoli effettuati dalla procedure
  T265P_COMP_CONGPARENTALI, quindi qualsiasi altro utilizzo è da
  considerarsi improprio, a meno di eventuali "aggiustamenti".

  I dati restituiti sono:
  - P_GG_FRUITI
      numero totale di giorni fruiti per tutte le causali nel cumulo / raggruppamento
  - P_OFFSET30
      totale degli offset su 30gg per tutte le causali nel cumulo / raggruppamento
      l'offset rispetto a 30 gg è calcolato per ogni mese in questo modo:
      * gennaio  = [31 - 30] =  1,
      * febbraio = [28 - 30] = -2 oppure
                   [29 - 30] = -1 per gli anni bisestili
      * aprile   = [30 - 30] =  0
      ...
  - P_MAX_MESI_CONT      
      numero massimo di mesi di fruizione continuativa all'interno del periodo
  
  Concetto di "mese continuativo":
    il mese è considerato continuativo se il periodo di assenza dura almeno 
    fino al giorno prima del mese successivo all’inizio del periodo stesso)
*/ 
  P_CONIUGE          in  varchar2,  -- 'N' = conteggi per dipendente, 'S' = conteggi per coniuge
  P_PROGRESSIVO      in  integer,   -- progressivo dipendente o coniuge 
  P_PROGRESSIVO_CNG  in  integer,   -- progressivo coniuge
  P_DATA_RIF         in  date,      -- data di riferimento per il conteggio delle fruizioni
  P_CAUSALE          in  varchar2,  -- causale da considerare
  P_DATANAS_FAM      in  date,      -- data di nascita familiare di riferimento (oppure null)
  P_INIZIO_CUMULO    in  date,      -- data di inizio cumulo
  P_FINE_CUMULO      in  date,      -- data di fine cumulo
  
  P_GG_FRUITI        out integer,   -- giorni fruiti all'interno del periodo (v. nota)
  P_OFFSET30         out integer,   -- tot. degli offset su 30gg
  P_MAX_MESI_CONT    out integer    -- max mesi di fruizione continuativa
) is
  
  type rcur is ref cursor;
  rc               rcur;

  wCurData         date;
  wData            date;
  wDataRif         date;
  wDataPrec        date;
  wDataIni         date;
  wDataFine        date;
  wMesiCont        integer;
  wEsisteDataRif   integer;
  wCausCumulo      T265_CAUASSENZE.CODCAU1%TYPE;
  wCodRaggr        T265_CAUASSENZE.CODRAGGR%TYPE;
  wElenco          varchar2(2000);
begin
  -- inizializza parametri output
  P_GG_FRUITI:=0;
  P_OFFSET30:=0;
  P_MAX_MESI_CONT:=0;

  -- estrae causali di cumulo per la causale indicata
  select codcau1, codraggr
  into   wCausCumulo, wCodRaggr
  from   t265_cauassenze
  where  codice = P_CAUSALE;
  
  -- elenco causali da considerare: solo causali di cumulo
  -- N.B. si ignorano volutamente le causali di inizio periodo
  wElenco:=P_CAUSALE;
  if wCausCumulo is not null then
    wElenco:=wElenco || ',' || wCausCumulo;
  end if;

  -- data di riferimento
  wDataRif:=least(P_DATA_RIF, P_FINE_CUMULO);
  wDataPrec:=null;

  wEsisteDataRif:=0;

  -- determina query giustificativi
  --   l'elenco delle causali considerate comprende:
  --   1. la causale di partenza
  --   2. le causali di inizio periodo
  --   3. le causali di cumulo 
  --   oltre a queste si considerano anche le causali facenti parte del raggruppamento
  if P_CONIUGE = 'S' and P_PROGRESSIVO_CNG = -1 then
    -- coniuge esterno
    open rc for
      select data
      from   t046_giustificativifamiliari
      where  progressivo = P_PROGRESSIVO
      and    data between P_INIZIO_CUMULO and wDataRif
      and    tipogiust = 'I'
      and    (instr(','||wElenco||',',','||causale||',') > 0 or
              causale in (select /*+ unnest */ codice from t265_cauassenze where codraggr = wCodRaggr))
      and    nvl(datanas,to_date('30121899','ddmmyyyy')) = nvl(P_DATANAS_FAM,to_date('30121899','ddmmyyyy'))
      order by data;
  else 
    -- dipendente stesso oppure coniuge interno all'azienda
    open rc for
      select data
      from   t040_giustificativi
      where  progressivo = decode(P_CONIUGE,'N',P_PROGRESSIVO,P_PROGRESSIVO_CNG)
      and    data between P_INIZIO_CUMULO and wDataRif
      and    tipogiust = 'I'
      and    (instr(','||wElenco||',',','||causale||',') > 0 or
              causale in (select /*+ unnest */ codice from t265_cauassenze where codraggr = wCodRaggr))
      and    nvl(datanas,to_date('30121899','ddmmyyyy')) = nvl(P_DATANAS_FAM,to_date('30121899','ddmmyyyy'))
      union
      select P_DATA_RIF 
      from   dual 
      where  P_CONIUGE = 'N'
      order by data;

    -- il cursore sopra definito considera eventualmente un giorno fittizio in più per il dipendente stesso
    -- per questo motivo viene determinato l'eventuale errore sui giorni fruiti
    -- che sarà rimosso al termine del ciclo
    select least(count(*),1) 
    into   wEsisteDataRif
    from   t040_giustificativi
    where  progressivo = P_PROGRESSIVO
    and    P_CONIUGE = 'N'
    and    data = P_DATA_RIF
    and    tipogiust = 'I'
    and    (instr(','||wElenco||',',','||causale||',') > 0 or
            causale in (select /*+ unnest */ codice from t265_cauassenze where codraggr = wCodRaggr))
    and    nvl(datanas,to_date('30121899','ddmmyyyy')) = nvl(P_DATANAS_FAM,to_date('30121899','ddmmyyyy'));
  end if;
  
  -- ciclo sui giustificativi
  loop
    fetch rc into wCurData;
    exit when rc%notfound;
    
    -- gestione fine periodo
    if (wDataPrec is not null) and (wCurData <> wDataPrec + 1) then
      -- il periodo è finito
      wDataPrec:=null;
      
      -- mesi di fruizione continuativa (fino al giorno successivo alla fine del periodo)
      wMesiCont:=trunc(months_between(wDataFine + 1,wDataIni));
      
      -- effettua valutazioni se esiste almeno un mese di fruizione continuativa
      if wMesiCont > 0 then
        
        -- max mesi continuativi
        if wMesiCont > P_MAX_MESI_CONT then
          P_MAX_MESI_CONT:=wMesiCont;
        end if;

        -- scostamento rispetto a 30 dei mesi gg che ricadono nella fruizione di almeno un mese consecutivo
        for i in 0..wMesiCont - 1 loop
          wData:=add_months(wDataIni,i);
          P_OFFSET30:=P_OFFSET30 + to_number(to_char(last_day(wData),'dd')) - 30;
        end loop;
      end if;
    end if;
    
    -- se si tratta di nuovo periodo, salva la data di inizio
    if wDataPrec is null then
      wDataIni:=wCurData;
    end if;

    -- incrementa il numero di giorni continuativi
    P_GG_FRUITI:=P_GG_FRUITI + 1;
      
    wDataPrec:=wCurData;
    wDataFine:=wCurData;
  end loop;

  -- valuta ultimo periodo
  if wDataPrec is not null then
      
    -- mesi di fruizione continuativa (fino al giorno successivo alla fine del periodo)
    wMesiCont:=trunc(months_between(wDataFine + 1,wDataIni));
      
    -- effettua valutazioni se esiste almeno un mese di fruizione continuativa
    if wMesiCont > 0 then
        
      -- max mesi continuativi
      if wMesiCont > P_MAX_MESI_CONT then
        P_MAX_MESI_CONT:=wMesiCont;
      end if;

      -- scostamento rispetto a 30 dei mesi gg che ricadono nella fruizione di almeno un mese consecutivo
      for i in 0..wMesiCont - 1 loop
        wData:=add_months(wDataIni,i);
        P_OFFSET30:=P_OFFSET30 + to_number(to_char(last_day(wData),'dd')) - 30;
      end loop;
    end if;
  end if;

  --Correggo i gg fruiti togliendo eventuale gg fittizio contato su P_DATA_RIF
  if (P_CONIUGE = 'N') and (wEsisteDataRif = 0) then
    P_GG_FRUITI:=P_GG_FRUITI - 1;
  end if;
end;
/
