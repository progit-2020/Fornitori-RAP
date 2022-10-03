create or replace function M140F_GETPARTENZA(pID in integer) return varchar2 is
  result varchar2(200);
/*
  Restituisce la località di partenza della trasferta
*/
begin
  select m141.localita
  into   result
  from   m141_percorso_missione m141
  where  m141.id = pID
  and    m141.ord = 1;

  return result;
exception
  when NO_DATA_FOUND then
    result:='<non indicata>';
    return result;
end;
/