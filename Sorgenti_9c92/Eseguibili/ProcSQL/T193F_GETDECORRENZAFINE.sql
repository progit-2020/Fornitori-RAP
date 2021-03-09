create or replace function T193F_GETDECORRENZAFINE(P_INTERFACCIA in varchar2, P_VOCE_PAGHE in varchar2, P_DECORRENZA in date) return date is
  result date;
begin
  select nvl(min(T193.DECORRENZA)-1,to_date('31123999','DDMMYYYY')) into result
    from T193_VOCIPAGHE_PARAMETRI T193
   where T193.COD_INTERFACCIA = P_INTERFACCIA
     and T193.VOCE_PAGHE = P_VOCE_PAGHE
     and T193.DECORRENZA > P_DECORRENZA;
  return(result);
end T193F_GETDECORRENZAFINE;
/