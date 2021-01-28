create or replace function T430F_CHECKIND_PLURIMENS(pPROGRESSIVO in integer, pDAL in date, pAL in date, pINDENNITA in varchar2) return varchar2 as
  n1 integer;
  n2 integer;
begin
  select (pAL - pDAL + 1) - nvl(sum(fine - inizio + 1),0) into n1 from
    (select distinct greatest(inizio,pDAL) inizio,least(nvl(fine,pAL),pAL) fine
     from t430_storico where progressivo = pPROGRESSIVO
     and inizio <= pAL and nvl(fine,pAL) >= pDAL);
  if n1 > 0 then
    return 'NO_SERVIZIO';
  end if;
  
  select count(*) into n2 from t430_storico where progressivo = pPROGRESSIVO
  and datadecorrenza <= pAL 
  and datafine >= pDAL
  and nvl(ipresenza,'*') not in  
    (select codice from t160_profiliindennita 
     --where indennita in (select codice from t162_indennita where nmesi_equiturni = 2)
     where indennita = pINDENNITA
     );
  if n2 > 0 then
    return 'NO_INDENNITA';
  end if;
  
  return null;
end;
/