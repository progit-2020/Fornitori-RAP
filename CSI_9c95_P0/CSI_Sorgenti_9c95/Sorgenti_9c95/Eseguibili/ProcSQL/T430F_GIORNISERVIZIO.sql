create or replace function T430F_GIORNISERVIZIO(
  P_PROGRESSIVO in integer, 
  P_DAL date, 
  P_AL date, 
  P_TIPO_PERIODO in varchar2 := 'S' --S = intervalli INIZIO e FINE; M = intervalli INIZIO_IND_MAT e FINE_IND_MAT
) return integer as
  wConto integer;
  result integer;
begin
  --verifico se esistono periodi INIZIO-FINE sovrapposti
  if P_TIPO_PERIODO = 'S' then
    select count(*) into wConto 
    from T430_STORICO T430
    where PROGRESSIVO = P_PROGRESSIVO
    and    INIZIO is not null
    and    P_DAL <= nvl(FINE,P_AL)
    and    P_AL  >= INIZIO
    and exists (
      select 'x' from T430_STORICO T430B
      where T430B.PROGRESSIVO = T430.PROGRESSIVO 
      and T430B.INIZIO is not null 
      and T430.INIZIO is not null 
      and T430B.INIZIO > T430.INIZIO 
      and T430B.INIZIO <= nvl(T430.FINE,P_AL)
      );
  elsif P_TIPO_PERIODO = 'M' then
    select count(*) into wConto 
    from T430_STORICO T430
    where PROGRESSIVO = P_PROGRESSIVO
    and    INIZIO_IND_MAT is not null
    and    P_DAL <= nvl(FINE_IND_MAT,P_AL)
    and    P_AL  >= INIZIO_IND_MAT
    and exists (
      select 'x' from T430_STORICO T430B
      where T430B.PROGRESSIVO = T430.PROGRESSIVO 
      and T430B.INIZIO_IND_MAT is not null 
      and T430.INIZIO_IND_MAT is not null 
      and T430B.INIZIO_IND_MAT > T430.INIZIO_IND_MAT 
      and T430B.INIZIO_IND_MAT <= nvl(T430.FINE_IND_MAT,P_AL)
      );
  end if;

  --se esistono periodi INIZIO-FINE sovrapposti esco con -1
  if wConto > 0 then
    result:=-1;
    return result;
  end if;
    
  --calcolo dei giorni in servizio nel periodo DAL-AL
  if P_TIPO_PERIODO = 'S' then
    select nvl(sum(FINE - INIZIO + 1),0) GG_SERVIZIO  into result
    from 
    (
      select distinct
             greatest(INIZIO,P_DAL) INIZIO,
             least(nvl(FINE,P_AL),P_AL) FINE
      from   T430_STORICO
      where  PROGRESSIVO = P_PROGRESSIVO
      and    INIZIO is not null
      and    P_DAL <= nvl(FINE,P_AL)
      and    P_AL  >= INIZIO
    );
  elsif P_TIPO_PERIODO = 'M' then
    select nvl(sum(FINE_IND_MAT - INIZIO_IND_MAT + 1),0) GG_SERVIZIO  into result
    from 
    (
      select distinct
             greatest(INIZIO_IND_MAT,P_DAL) INIZIO_IND_MAT,
             least(nvl(FINE_IND_MAT,P_AL),P_AL) FINE_IND_MAT
      from   T430_STORICO
      where  PROGRESSIVO = P_PROGRESSIVO
      and    INIZIO_IND_MAT is not null
      and    P_DAL <= nvl(FINE_IND_MAT,P_AL)
      and    P_AL  >= INIZIO_IND_MAT
    );
  end if;
  
  return result;
end;
/
