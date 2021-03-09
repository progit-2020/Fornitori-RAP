create or replace function T012F_DATI(p_PROGRESSIVO IN integer,p_DATA IN DATE, p_DATO in varchar2) return varchar2 as
 result varchar2(2);
begin
  result:=null; 
  if p_DATO = 'FESTIVO' then
    select FESTIVO into result from T012_CALENDINDIVID WHERE PROGRESSIVO = p_PROGRESSIVO and DATA = p_DATA;
  elsif p_DATO = 'LAVORATIVO' then
    select LAVORATIVO into result from T012_CALENDINDIVID WHERE PROGRESSIVO = p_PROGRESSIVO and DATA = p_DATA;
  elsif p_DATO = 'NUMGIORNI' then
    select NUMGIORNI into result from T012_CALENDINDIVID WHERE PROGRESSIVO = p_PROGRESSIVO and DATA = p_DATA;
  end if;
  return result;
exception
  when no_data_found then
   return null;
end;
/