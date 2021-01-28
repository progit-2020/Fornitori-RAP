alter table sg710_testata_valutazioni add codregola varchar2(5);

ALTER TABLE I071_PERMESSI ADD WEB_RICHIESTA_CONSEGNA_CED VARCHAR2(1) DEFAULT 'N';
ALTER TABLE I071_PERMESSI ADD WEB_RICHIESTA_CONSEGNA_VAL VARCHAR2(1) DEFAULT 'N';
Comment on column I071_PERMESSI.WEB_RICHIESTA_CONSEGNA_CED is 'S=Chiede conferma presa visione cedolino e CUD, N=Non chiede conferma presa visione cedolino e CUD';
Comment on column I071_PERMESSI.WEB_RICHIESTA_CONSEGNA_VAL is 'S=Chiede conferma presa visione scheda di valutazione, N=Non chiede conferma presa visione scheda di valutazione';

alter table SG664_DOCENTI modify tipo VARCHAR2(2);
comment on column SG664_DOCENTI.tipo
  is 'R=Responsabile Scientifico, RE=Relatore, D=Docente, T=Tutor, A=Altro';

--Forzo la richiesta di ricezione del pdf a tutti i profili da dipendente (Permessi impostati e Filtro anagrafe vuoto)
declare
  cursor c1 is
    select distinct azienda, permessi
    from i061_profili_dipendente
    where permessi is not null
    and filtro_anagrafe is null
    order by 1,2;
begin
  for r1 in c1 loop
    update i071_permessi
    set web_richiesta_consegna_ced = 'S',
        web_richiesta_consegna_val = 'S'
    where azienda = r1.azienda
    and profilo = r1.permessi;
  end loop;
end;
/

alter table sg710_testata_valutazioni add dal date;
alter table sg710_testata_valutazioni add al date;

declare
  cursor c1 is
    select distinct progressivo, data, tipo_valutazione
    from sg710_testata_valutazioni
    order by progressivo, data, tipo_valutazione;
  w_dal_min date;
  w_dal date;
  w_al date;
begin
  for r1 in c1 loop
    --Inizio MINIMO per la scheda attuale (inizio anno o giorno successivo alla data della scheda precedente)
    select nvl(max(data) + 1,trunc(r1.data,'y'))
    into w_dal_min
    from sg710_testata_valutazioni
    where data between trunc(r1.data,'y') and r1.data - 1
    and progressivo = r1.progressivo
    and tipo_valutazione = r1.tipo_valutazione;
    --Inizio e Fine periodo scheda attuale (inizio/fine rapporto se interni a inizio MINIMO/fine MASSIMA)
    SELECT MIN(GREATEST(DATADECORRENZA,INIZIO,w_dal_min)), 
           MAX(LEAST(DATAFINE,NVL(FINE,TO_DATE('31123999','DDMMYYYY')),r1.data))
    INTO   w_dal, w_al
    FROM   T430_STORICO
    WHERE  PROGRESSIVO = r1.progressivo
    AND    NVL(INIZIO,TO_DATE('31123999','DDMMYYYY')) <= r1.data
    AND    NVL(FINE,TO_DATE('31123999','DDMMYYYY')) >= w_dal_min
    AND    DATADECORRENZA <= r1.data
    AND    DATAFINE >= w_dal_min;
    --Aggiorno il periodo su tutti gli stati della scheda
    UPDATE SG710_TESTATA_VALUTAZIONI
    SET DAL = w_dal, AL = w_al
    WHERE DATA = r1.data
    AND PROGRESSIVO = r1.progressivo
    AND TIPO_VALUTAZIONE = r1.tipo_valutazione;
  end loop;
end;
/
