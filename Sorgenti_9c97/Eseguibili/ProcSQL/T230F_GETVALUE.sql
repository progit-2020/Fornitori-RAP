create or replace function T230F_GETVALUE(P_CAUSALE in varchar2, P_NOME in varchar2, P_DATA in date) return varchar2 as
  result varchar2(1000);
  wStat  varchar2(1000);
begin
  result:=null;
  
  wStat:='select '||P_NOME||' from VT230_CAUASSENZE_PARSTO T230 where T230.CODICE = :CAUSALE and :DATA between T230.DECORRENZA and T230.DECORRENZA_FINE';
  execute immediate wStat into result using P_CAUSALE,trunc(P_DATA);
  
  return result;
exception
  when others then
    return null;
end;  
/