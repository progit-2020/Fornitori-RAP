create or replace function INTERSEZ_LISTE(LISTA1 in varchar2, LISTA2 in varchar2) return varchar2 as
  result varchar2(4000);
  l1 varchar2(4000);
  l2 varchar2(4000);
  i integer;
  num1 integer;
  item1 varchar2(100);
/*date 2 liste di valori separati da virgla, restituisce l'elenco degli elementi che appartengono a entrambe le liste*/  
begin
  result:=null;
  l1:=','||LISTA1||',';
  l1:=replace(l1,',,',',');

  l2:=','||LISTA2||',';
  l2:=replace(l2,',,',',');
  
  num1:=length(l1) - length(replace(l1,',','')) - 1;
  if num1 is null then
    num1:=0;
  end if;
  
  for i in 1..num1 loop
    item1:=substr(l1,instr(l1,',',1,i) + 1,instr(l1,',',1,i+1) - instr(l1,',',1,i) - 1);
    if instr(l2,','||item1||',') > 0 then
      if result is not null then
        result:=result||',';
      end if;
      result:=result||item1;
    end if;
  end loop;
  
  return result;
end;
/