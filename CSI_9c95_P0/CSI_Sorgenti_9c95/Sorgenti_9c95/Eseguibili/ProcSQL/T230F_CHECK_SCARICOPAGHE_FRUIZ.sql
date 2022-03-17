create or replace function T230F_CHECK_SCARICOPAGHE_FRUIZ(P_CAUSALE in varchar2, P_DATA in date, P_TIPOGIUST in varchar2) return varchar2 as
  result varchar2(1);
begin
  select decode(P_TIPOGIUST,
                'N',nvl(SCARICOPAGHE_FRUIZ_ORE,'S'),
                'D',nvl(SCARICOPAGHE_FRUIZ_ORE,'S'),
                'I',nvl(SCARICOPAGHE_FRUIZ_GG,'S'),
                'M',nvl(SCARICOPAGHE_FRUIZ_GG,'S'),
                'S')
  into result              
  from VT230_CAUASSENZE_PARSTO T230
  where T230.CODICE = P_CAUSALE
  and P_DATA between T230.DECORRENZA and DECORRENZA_FINE;
  
  return result;
exception
  when others then
    return 'S';  
end;
/