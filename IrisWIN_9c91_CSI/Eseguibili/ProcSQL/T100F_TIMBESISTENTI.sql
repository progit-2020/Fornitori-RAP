create or replace function T100F_TIMBESISTENTI(P_PROGRESSIVO in integer, P_DATA in date) return varchar2 as
  result varchar2(100);
begin
  select decode(count(*),0,'N','S') into result
  from T100_TIMBRATURE 
  where PROGRESSIVO = P_PROGRESSIVO 
  and DATA = P_DATA 
  and FLAG in ('O','I');

  return result;
end;
/