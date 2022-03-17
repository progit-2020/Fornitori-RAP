create or replace function T180F_STATORIEPILOGO(P_RIEPILOGO in varchar2, P_PROGRESSIVO in integer, P_DATA in date) return varchar2 as
  result varchar2(1);
begin
  result:='A';

  select nvl(max(STATO),'A') into result 
  from T180_DATIBLOCCATI T180
  where T180.PROGRESSIVO = P_PROGRESSIVO
  and T180.RIEPILOGO = P_RIEPILOGO
  and P_DATA between T180.DAL and T180.AL;
  
  return result;
end;
/