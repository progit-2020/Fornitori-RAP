create or replace function M140F_GETDESTINAZIONI_DESC(pID in integer) return varchar2 is
  result varchar2(2000);
/*
  Restituisce l'elenco delle descrizioni delle destinazioni della trasferta, separate da virgola
*/
  cursor c1 is
    select m141.localita
    from   m141_percorso_missione m141
    where  m141.id = pID
    and    m141.ord > 1
    and    m141.ord < (select max(ord)
                       from   m141_percorso_missione
                       where  id = m141.id)
    order by m141.ord;
begin
  result:='';
  for t1 in c1 loop
    result:=result || m041f_getdesclocalita(t1.localita) || ',';
  end loop;

  if length(result) > 0 then
    result:=substr(result,1,length(result) - 1);
  end if;

  return result;
exception
  when others then
    result:='Errore: ' || sqlerrm;
    return result;
end;
/