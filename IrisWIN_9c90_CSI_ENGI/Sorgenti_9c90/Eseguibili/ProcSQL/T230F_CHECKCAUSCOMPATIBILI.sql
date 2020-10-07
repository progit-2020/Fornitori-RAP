create or replace function T230F_CHECKCAUSCOMPATIBILI(P_DATA in date, P_CAUSALE1 in varchar2, P_CAUSALE2 in varchar2) return varchar2 as
  cursor c1 is
    select STATO_COMPATIBILITA,INTERSEZ_LISTE(P_CAUSALE2,CAUSALI_COMPATIBILI) INTERSEZ
    from VT230_CAUASSENZE_PARSTO 
    where CODICE = P_CAUSALE1 
    and P_DATA between DECORRENZA and DECORRENZA_FINE
    and STATO_COMPATIBILITA <> 'D'
    union
    select STATO_COMPATIBILITA,INTERSEZ_LISTE(P_CAUSALE1,CAUSALI_COMPATIBILI) INTERSEZ
    from VT230_CAUASSENZE_PARSTO 
    where CODICE = P_CAUSALE2 
    and P_DATA between DECORRENZA and DECORRENZA_FINE
    and STATO_COMPATIBILITA <> 'D';
  
  result varchar2(1);
  
begin  
  result:='S';

  for t1 in c1 loop
    if t1.STATO_COMPATIBILITA = 'C' and t1.INTERSEZ is null then
      result:='N';
      exit;
    elsif t1.STATO_COMPATIBILITA = 'I' and t1.INTERSEZ is not null then
      result:='N';
      exit;
    end if;  
  end loop;  
  
  return result;
end;
/
