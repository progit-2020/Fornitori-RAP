create or replace function T040F_GGASSENZA(P_PROGRESSIVO in integer, P_DATA in date, P_DATO in varchar2) return varchar2 is
/**
  Funzione per estrarre la  causale di assenza nel giorno
  Parametri:
  - P_DATO
     'STATO' -> estrae la tipologia di giustificativo:
                'A' = effettivo o autorizzato
                'R' = richiesto
     'CAUSALE' -> estrae la causale di assenza del primo giustificativo
*/
  wCausale   varchar2(5);
  wStato     varchar2(1);
begin
  wCausale:=null;
  wStato:=null;

  begin
    select CAUSALE, STATO
    into wCausale, wStato
    from (
      -- 1a) giustificativi effettivi
      select CAUSALE, 'A' STATO, 1 ORDINE
      from   T040_GIUSTIFICATIVI
      where  PROGRESSIVO = P_PROGRESSIVO
      and    DATA = P_DATA
      and    TIPOGIUST = 'I'
      union all
      -- 1b) richieste autorizzate in attesa di elaborazione
      select CAUSALE, 'A', 2
      from   VT050_RICHIESTE_SENZAREVOCA
      where  PROGRESSIVO = P_PROGRESSIVO
      and    P_DATA between DAL and AL
      and    TIPOGIUST = 'I'
      and    ELABORATO = 'N'
      and    STATO = 'S'
      union all
      -- 2) richieste da autorizzare
      select CAUSALE, 'R', 3
      from   VT050_RICHIESTE_SENZAREVOCA
      where  PROGRESSIVO = P_PROGRESSIVO
      and    P_DATA between DAL and AL
      and    TIPOGIUST = 'I'
      and    ELABORATO = 'N'
      and    STATO is null
      order by 3
    )
    where ROWNUM <= 1;
  exception
    when NO_DATA_FOUND then
      null;
  end;

  -- in base al dato richiesto restituisce il risultato
  if P_DATO = 'STATO' then
    return wStato;
  elsif P_DATO = 'CAUSALE' then
    return wCausale;
  end if;
end;
