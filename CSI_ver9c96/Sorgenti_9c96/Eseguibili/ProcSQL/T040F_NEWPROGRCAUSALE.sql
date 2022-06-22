create or replace function T040F_NEWPROGRCAUSALE(P_PROGRESSIVO in integer, P_DATA in date, P_CAUSALE in varchar2) return integer as
  result integer;
begin
  select nvl(max(PROGRCAUSALE),-1) + 1
  into result
  from T040_GIUSTIFICATIVI
  where PROGRESSIVO = P_PROGRESSIVO
  and DATA = P_DATA
  and CAUSALE = P_CAUSALE;
  
  return result;
end;
/