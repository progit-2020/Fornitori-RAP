create or replace function M051M052F_COUNT(P_PROGRESSIVO in integer, P_MESESCARICO in date, P_MESECOMPETENZA in date, P_DATADA in date, P_ORADA in varchar2, P_STATO in varchar2) return integer as
  result integer;
begin
  select sum(conta) into result from 
  (
    select count(*) conta 
    from  M051_DETTAGLIORIMBORSO
    where PROGRESSIVO = P_PROGRESSIVO
    and   MESESCARICO = P_MESESCARICO
    and   MESECOMPETENZA = P_MESECOMPETENZA
    and   DATADA = P_DATADA
    and   ORADA = P_ORADA
    and   STATO = nvl(P_STATO,STATO)
    union all
    select count(*) conta
    from  M052_INDENNITAKM 
    where PROGRESSIVO = P_PROGRESSIVO
    and   MESESCARICO = P_MESESCARICO
    and   MESECOMPETENZA = P_MESECOMPETENZA
    and   DATADA = P_DATADA
    and   ORADA = P_ORADA
    and   STATO = nvl(P_STATO,STATO)
  );
                 
  return result;
end;
/