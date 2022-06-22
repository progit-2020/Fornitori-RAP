create or replace function M140F_GETRIENTRO(pID in integer) return varchar2 is
  result varchar2(200);
/*
  Restituisce la località di rientro della richiesta di trasferta
*/
begin
  select m141.localita
  into   result
  from   m141_percorso_missione m141
  where  m141.id = pID
  and    m141.ord = (select max(ord)
                     from   m141_percorso_missione
                     where  id = m141.id);

  return result;
exception
  when NO_DATA_FOUND then
    result:='<non indicata>';
    return result;
end;
/