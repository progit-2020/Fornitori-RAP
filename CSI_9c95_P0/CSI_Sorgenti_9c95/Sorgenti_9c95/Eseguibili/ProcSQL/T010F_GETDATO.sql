create or replace function T010F_GETDATO(P_PROGRESSIVO in integer, P_DATA in date, P_DATO in varchar2) return varchar2 is
  F varchar2(5);
  L varchar2(5);
  MonteOre varchar2(5);
  G number;
begin
  T010P_GETDATI(P_PROGRESSIVO,P_DATA,F,L,G,MonteOre);
  if P_DATO = 'F' then
    return F;
  elsif P_DATO = 'L' then
    return L;
  elsif P_DATO = 'G' then
    return G;
  elsif P_DATO = 'H' then
    return MonteOre; 
  else
    return null;  
  end if;  
end T010F_GETDATO;
/
