create or replace function T235F_GETVALUE(P_CAUSALE in varchar2, P_NOME in varchar2, P_DATA in date) return varchar2 as
  result varchar2(1000);
  wStat  varchar2(1000);
begin
  result:=null;
  
  wStat:='select '||P_NOME||' from VT235_CAUPRESENZE_PARSTO T235 where T235.CODICE = :CAUSALE and :DATA between T235.DECORRENZA and T235.DECORRENZA_FINE';
  execute immediate wStat into result using P_CAUSALE,trunc(P_DATA);
  
  return result;
exception
  when others then
    return null;
end;  
/
