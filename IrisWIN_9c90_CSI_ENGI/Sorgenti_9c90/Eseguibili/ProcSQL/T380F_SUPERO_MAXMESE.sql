create or replace function T380F_SUPERO_MAXMESE(P_PROGRESSIVO in integer, P_DATA in date, P_TURNO in varchar2) return varchar2 as
  result varchar2(1);
begin
  result:='N';
  
  if P_TURNO is null then
    return result;
  end if;
    
  begin
    select decode(sign(NUMERO - PIANIF_MAX_MESE),1,'S','N')  
    into result
    from (select sum(decode(TURNO1,null,0,1)+decode(TURNO2,null,0,1)+decode(TURNO3,null,0,1)) NUMERO
          from T380_PIANIFREPERIB
          where PROGRESSIVO = P_PROGRESSIVO
          and DATA between trunc(P_DATA,'mm') and P_DATA) T380,
         (select nvl(PIANIF_MAX_MESE,999) PIANIF_MAX_MESE 
          from T350_REGREPERIB
          where CODICE = P_TURNO
          and TIPOLOGIA = 'R') T350;
  exception
    when others then 
      null;
  end;  
  
  return result;
end;
/
