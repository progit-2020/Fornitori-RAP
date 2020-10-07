create or replace function T690F_ID_BLOCCHETTI(p_mese in date, p_progressivo in integer) return varchar2 is
  cursor c1 is
    select ID_BLOCCHETTI from T690_ACQUISTOBUONI
    where PROGRESSIVO = p_progressivo
    and trunc(DATA,'mm') = trunc(p_mese,'mm')
    and ID_BLOCCHETTI is not null;
  result varchar2(200);
begin
  result:='';
  for t1 in c1 loop
    if length(nvl(result,'*')) + length(t1.ID_BLOCCHETTI) < 200 then
      if result is not null then
        result:=result||',';
      end if;
      result:=result||t1.ID_BLOCCHETTI;
    end if;
  end loop;  
  return(result);
end;
/