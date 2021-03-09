create or replace function T852F_GETVALORE(pID in integer, pLIVELLO in integer, pDATO in varchar2) return varchar2 as
  result varchar2(100);
  wLIVELLO integer;
begin
  wLIVELLO:=pLIVELLO;
  if wLIVELLO = -1 then
    select max(LIVELLO) into wLIVELLO from T852_ITER_DATI_AUTORIZZATORI where ID = pID and DATO = pDATO;
  end if;
  
  select VALORE into result
  from T852_ITER_DATI_AUTORIZZATORI 
  where ID = pID
  and   LIVELLO = wLIVELLO
  and   DATO = pDATO;
  
  return result;
  
exception
  when no_data_found then
    return null;  
end;
/