create or replace procedure T040P_ALLINEA_CONGPARENTALI (
-- Gestisce il caricamento automatico o la cancellazione, di maternità facoltativa nel caso della sequenza di settimane così articolata:
-- almeno 1 giorno di maternità facoltativa (primo periodo) / qualsiasi giustificativo a giornata intera non escluso da assenza(secondo periodo) / almeno 1 giorno di maternità facoltativa;
-- viene inserita o cancellata maternità facoltativa nei giorni non lavorativi vuoti a fine del primo e del secondo periodo
  P_PROGRESSIVO           in integer,   -- progressivo dipendente
  P_DATA                  in date,      -- data inserimento/cancellazione
  P_CAUSALE               in varchar2,  -- causale inserimento/cancellazione
  P_OPERAZIONE            in varchar2   -- operazione I=Inserimento; C=Cancellazione
) as
  wCauGest varchar2(10);  --indica il tipo di causale e di conseguenza il tipo di gestione tra GIUST(giustificativi a giornata intera non esclusi dalle assenze),
                          --MAT.FAC.(maternita facoltativa) e ALTRO(altre assenze)
  wNumFigli number;       -- numero figli negli ultimi 8 anni che hanno diritto alla facoltativa
  wFacPrec date;          -- data ultimo giorno di maternità facoltativa precedente
  wFacSucc date;          -- data primo giorno di maternità facoltativa successivo
  wDataNasPrec date;      -- data di nascita da inserire in automatico
  wDataNasSucc date;      -- data di nascita da inserire in automatico
  WCauPrec T265_CAUASSENZE.CODICE%TYPE; -- causale di maternità facoltativa da inserire in automatico da periodo prtecedente
  WCauSucc T265_CAUASSENZE.CODICE%TYPE; -- causale di maternità facoltativa da inserire in automatico da periodo successivo
  wApplicaAut boolean;    -- indica se applicare o meno l'automatismo di inserimento maternità facoltativa nei giorni non lavorativi vuoti
  wPeriodoSucc boolean;   -- serve per poter eseguire la sistemazione dell'eventuale periodo di maternità successivo
  wDataElab date;         -- data di elaborazione

cursor cV010(DAL date, AL date) is
  select V010.DATA,V010.LAVORATIVO,V010.FESTIVO,V010.NUMGIORNI,V010.DATA - trunc(V010.DATA,'IW') + 1 GGSET,nvl(T265.ESCLUSIONE,'S') ESCLUSIONE,T260.CODINTERNO,
    decode(instr(usr_const.cRMAFA,nvl(T260.CODICE,'*')||','),0,'N','S') MATFAC,T040.DATANAS,sum(decode(T040.TIPOGIUST,'I',1,'M',0.5,0)) NGIOR
    from V010_CALENDARI V010, T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGGRASSENZE T260,T430_STORICO T430
    where V010.PROGRESSIVO = P_PROGRESSIVO and V010.DATA between DAL + 1 and AL - 1
    and V010.PROGRESSIVO = T040.PROGRESSIVO(+) and V010.DATA = T040.DATA(+) and T040.TIPOGIUST(+) in ('I','M')
    and T040.CAUSALE = T265.CODICE(+) and T265.CODRAGGR = T260.CODICE(+)
    and V010.PROGRESSIVO = T430.PROGRESSIVO and V010.DATA between T430.DATADECORRENZA and T430.DATAFINE
  group by V010.DATA,V010.LAVORATIVO,V010.FESTIVO,V010.NUMGIORNI,V010.DATA - trunc(V010.DATA,'IW') + 1 ,nvl(T265.ESCLUSIONE,'S') ,T260.CODINTERNO,
    decode(instr(usr_const.cRMAFA,nvl(T260.CODICE,'*')||','),0,'N','S') ,T040.DATANAS
  order by V010.DATA;

cursor cV010a(DAL date, AL date) is
  select V010.DATA,V010.LAVORATIVO,V010.FESTIVO,V010.NUMGIORNI,V010.DATA - trunc(V010.DATA,'IW') + 1 GGSET,T040.CAUSALE,T260.CODINTERNO,
    decode(instr(usr_const.cRMAFA,nvl(T260.CODICE,'*')||','),0,'N','S') MATFAC,T040.DATANAS,sum(decode(T040.TIPOGIUST,'I',1,'M',0.5,0)) NGIOR
    from V010_CALENDARI V010, T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGGRASSENZE T260
    where V010.PROGRESSIVO = P_PROGRESSIVO and V010.DATA between DAL + 1 and AL - 1
    and V010.PROGRESSIVO = T040.PROGRESSIVO(+) and V010.DATA = T040.DATA(+) and T040.TIPOGIUST(+) in ('I','M')
    and T040.CAUSALE = T265.CODICE(+) and T265.CODRAGGR = T260.CODICE(+)
  group by V010.DATA,V010.LAVORATIVO,V010.FESTIVO,V010.NUMGIORNI,V010.DATA - trunc(V010.DATA,'IW') + 1,T040.CAUSALE,T260.CODINTERNO,
    decode(instr(usr_const.cRMAFA,nvl(T260.CODICE,'*')||','),0,'N','S'),T040.DATANAS
  order by V010.DATA desc;

begin
  wDataElab:=P_DATA;
  /*9c.8(1) TAS000000207545: prima si riconsoce la MAT.FAC. e dopo il GIUST generico*/
  select max('MAT.FAC.') into wCauGest from T265_CAUASSENZE T265, T260_RAGGRASSENZE T260
    where P_CAUSALE = T265.CODICE and T265.CODRAGGR = T260.CODICE and instr(usr_const.cRMAFA,T260.CODICE||',') > 0;
  if wCauGest is null then
    select max('GIUST') into wCauGest from T265_CAUASSENZE T265, T260_RAGGRASSENZE T260
      where P_CAUSALE = T265.CODICE and T265.ESCLUSIONE = 'N' and T265.CODRAGGR = T260.CODICE and T260.CODINTERNO <> 'H';
  end if;
  /*prima del TAS000000207545: si riconsoceva la MAT.FAC. dopo il GIUST generico, ma così facendo la causale di MAT.FAC. veniva riconosciuta come GIUST
  if wCauGest is null then
    select max('MAT.FAC.') into wCauGest from T265_CAUASSENZE T265, T260_RAGGRASSENZE T260
      where P_CAUSALE = T265.CODICE and T265.CODRAGGR = T260.CODICE and instr(usr_const.cRMAFA,T260.CODICE||',') > 0;
  end if;
  */
  if wCauGest is null then
    wCauGest:='ALTRO';
  end if;
  if wCauGest =  'GIUST' then
    select count(*) into wNumFigli from SG101_FAMILIARI SG101 where SG101.PROGRESSIVO = P_PROGRESSIVO and SG101.GRADOPAR = 'FG' and trunc(SG101.DATANAS) >= Add_months(wDataElab, -96);
  end if;
  if wCauGest = 'MAT.FAC.' or wNumFigli > 0 then
    wPeriodoSucc:=True;
    <<CICLO_PERIODI>>
    -- Determino data fine del periodo di maternità facoltativa precedente escludendo i giorni forzati automaticamente
    select max(DATA),max(T040.DATANAS),max(T040.CAUSALE) into wFacPrec, wDataNasPrec, WCauPrec from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGGRASSENZE T260 where T040.PROGRESSIVO = P_PROGRESSIVO and T040.DATA < wDataElab
      and T040.TIPOGIUST = 'I' and nvl(T040.STAMPA,'x') <> '0' and T040.CAUSALE = T265.CODICE and T265.CODRAGGR = T260.CODICE and instr(usr_const.cRMAFA,T260.CODICE||',') > 0;
    -- Determino data inizio del periodo di maternità facoltativa successivo escludendo i giorni forzati automaticamente
    select min(DATA),min(T040.DATANAS),min(T040.CAUSALE) into wFacSucc, wDataNasSucc, WCauSucc from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGGRASSENZE T260 where T040.PROGRESSIVO = P_PROGRESSIVO and T040.DATA >= wDataElab
      and T040.TIPOGIUST = 'I' and nvl(T040.STAMPA,'x') <> '0' and T040.CAUSALE = T265.CODICE and T265.CODRAGGR = T260.CODICE and instr(usr_const.cRMAFA,T260.CODICE||',') > 0;
    -- Esistono le condizioni di inserimento automatico se nel periodo tra fine/inizio della maternità facoltativa trovo solo ferie o causali equiparate nei giorni
    -- lavorativi e giorni non lavorativi vuoti o con causali di riposo
    wApplicaAut:=True;
    /* Introdotta a seguito di segnalazione per gestire forzatura su alternanza maternità-ferie che poi è risultato da non gestire
    if wFacPrec is not null and wFacSucc is null then
       wFacSucc:=wDataElab;
    end if;*/
    for tV010 in cV010(wFacPrec,wFacSucc) loop
      -- Se si tratta di giorno lavorativo senza causale di ferie o assenze equiparate e maternità, oppure si tratta di mezza giornata di assenza
      -- le condizioni per l'automatismo decadono
      if (tV010.LAVORATIVO = 'S' and tV010.FESTIVO = 'N' and tV010.ESCLUSIONE = 'S' and tV010.MATFAC = 'N') or tV010.NGIOR = 0.5  then
        wApplicaAut:=False;
        exit;
      end if;
    end loop;
    -- Operazione di inserimento
    if P_OPERAZIONE = 'I' then
      -- Se esistono le condizioni di inserimento automatico
      if wApplicaAut = True then
        -- Inserisco maternità facoltativa nei giorni non lavorativi successivi alla fine del primo periodo di maternità
        for tV010 in cV010(wFacPrec,wFacSucc) loop
          if (tV010.LAVORATIVO = 'N' or tV010.FESTIVO = 'S') and (tV010.CODINTERNO is null or tV010.CODINTERNO = 'H') then
            insert into T040_GIUSTIFICATIVI
              (progressivo, data, causale, progrcausale, tipogiust, stampa, datanas)
            values
              (P_PROGRESSIVO, tV010.DATA, nvl(WCauSucc,WCauPrec), 1, 'I', '0', nvl(wDataNasSucc,wDataNasPrec));
           else
            exit;
          end if;
        end loop;
        -- Ciclando all'indietro inserisco maternità facoltativa nei giorni non lavorativi precedenti all'inizio del secondo periodo di maternità
        for tV010 in cV010a(wFacPrec,wFacSucc) loop
          if (tV010.LAVORATIVO = 'N' or tV010.FESTIVO = 'S') and (tV010.CAUSALE is null or tV010.CODINTERNO = 'H') then
            insert into T040_GIUSTIFICATIVI
              (progressivo, data, causale, progrcausale, tipogiust, stampa, datanas)
            values
              (P_PROGRESSIVO, tV010.DATA, nvl(WCauSucc,WCauPrec), 1, 'I', '0', nvl(wDataNasSucc,wDataNasPrec));
           else
            exit;
          end if;
        end loop;
      end if;
    -- Operazione di cancellazione
    elsif P_OPERAZIONE = 'C' then
      if wFacSucc is null then
        wApplicaAut:=False;
        wFacSucc:=wDataElab - 1;
      end if;
      -- Se non esistono le condizioni di inserimento automatico
      if wApplicaAut = False then
        -- Cancello le maternità facoltative inserite automaticamente tra il promo e secondo periodo di maternità
        delete T040_GIUSTIFICATIVI T040 where T040.PROGRESSIVO = P_PROGRESSIVO
          and T040.DATA between wFacPrec and wFacSucc and T040.STAMPA = '0'
          and exists (select 'x' from T265_CAUASSENZE T265, T260_RAGGRASSENZE T260 where T040.CAUSALE = T265.CODICE and T265.CODRAGGR = T260.CODICE and instr(usr_const.cRMAFA,T260.CODICE||',') > 0 );
      end if;
    end if;
    -- Per gestire il caso in cui l'inserimento del giorno creasse amche un ponte per il periodo di maternità successivo non consecutivo, sposto la data di controllo wDataElab
    -- su inizio del periodo di maternità facoltativa successivo NON CONSECUTIVO escludendo i giorni forzati automaticamente
    select nvl(min(DATA),wDataElab) into wDataElab from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGGRASSENZE T260 where T040.PROGRESSIVO = P_PROGRESSIVO and T040.DATA > wDataElab
      and T040.TIPOGIUST = 'I' and nvl(T040.STAMPA,'x') <> '0' and T040.CAUSALE = T265.CODICE and T265.CODRAGGR = T260.CODICE and instr(usr_const.cRMAFA,T260.CODICE||',') > 0;
    if wPeriodoSucc and wDataElab > P_DATA + 1 then
      wPeriodoSucc:=False;
      goto CICLO_PERIODI;
    end if;
  end if;
end;
/
