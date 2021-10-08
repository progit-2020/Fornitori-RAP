create or replace function T020F_GETDECORRENZAFINE(P_CODICE in varchar2, P_DECORRENZA in date) return date is
  result date;
begin
  select nvl(min(T020.DECORRENZA) - 1,TO_DATE('31123999','DDMMYYYY')) into result
    from T020_ORARI T020
   where T020.CODICE = P_CODICE
     and T020.DECORRENZA > P_DECORRENZA;
  return(result);
end T020F_GETDECORRENZAFINE;
/