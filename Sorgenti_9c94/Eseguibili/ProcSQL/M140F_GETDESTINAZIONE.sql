create or replace function M140F_GETDESTINAZIONE(pID in integer) return varchar2 is
  result varchar2(200);
/*
  Restituisce la località di destinazione della trasferta
  Importante:
    in caso di trasferte con destinazioni multiple viene estratta per convenzione
    la penultima tappa, ovvero quella precedente al rientro
*/
begin
  -- estrae la penultima località del percorso
  select localita into result
  from (
    select m141.localita
    from   m141_percorso_missione m141
    where  m141.id = pID
    and    m141.ord > 1
    and    m141.ord < (select max(ord)
                       from   m141_percorso_missione
                       where  id = m141.id)
    order by m141.ord desc
  )
  where rownum = 1;

  return result;
exception
  when no_data_found then
    result:='<non indicata>';
    return result;
end;
/