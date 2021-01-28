create or replace function T265F_CAUSALI_CUMULATE(P_CAUSALE in varchar2) return varchar2 as
  cursor c1 is
    select CODICE from 
    T265_CAUASSENZE 
    where CODICE <> P_CAUSALE
    and CODRAGGR = (select CODRAGGR from T265_CAUASSENZE where CODICE = P_CAUSALE);
  result varchar2(2000);
begin
  result:=null;
  select min(CODCAU2) into result from T265_CAUASSENZE
  where CODICE = P_CAUSALE;
  
  for t1 in c1 loop
    result:=result||','||t1.CODICE;
  end loop;

  if substr(result,1,1) = ',' then
    result:=substr(result,2,length(result));
  end if;
  
  return result;
end;
/