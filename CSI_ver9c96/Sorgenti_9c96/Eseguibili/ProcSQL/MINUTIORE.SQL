create or replace function MINUTIORE (MINUTI in integer) return varchar2 as
  hh varchar2(20);
begin
  hh:=null;
  if MINUTI is not null then
    hh:=trunc(abs(MINUTI)/60) || '.' || lpad(mod(abs(MINUTI),60),2,'0');
    if length(hh) < 5 then
      hh:='0'||hh;
    end if;  
    if MINUTI < 0 then
      hh:='-' || hh;
    end if;
  end if;
  return hh;
end;
/
