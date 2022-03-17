CREATE OR REPLACE FUNCTION M150F_FILTRORIMBORSI(pID IN NUMBER)
RETURN varchar2 IS
/*
  Restituisce:
  N = nessun rimborso
  A = rimborsi da autorizzare
  D = rimborsi da liquidare
  L = rimborsi liquidati
*/
  wStatoM150 varchar2(4);
  wStatoM040 varchar2(1);
  wTipoRich varchar2(1);
  wContaRimb integer;
BEGIN
  -- determina il numero di rimborsi richiesti per la missione
  select count(*), max(T850.TIPO_RICHIESTA),max(nvl(M150.STATO,'null'))
  into   wContaRimb, wTipoRich,wStatoM150
  from   T850_ITER_RICHIESTE T850, M150_RICHIESTE_RIMBORSI M150
  where  T850.ITER = 'M140'
  and    T850.ID = pID
  and    M150.ID = T850.ID
  and    nvl(M150.STATO,'A') <> 'N';
  
  if (wContaRimb = 0) or (wTipoRich between '0' and '3') then
    return 'N';
  end if;
  
  if wStatoM150 = 'null' then
    return 'A'; -- da autorizzare
  else 
    select max(STATO)
    into   wStatoM040
    from   M040_MISSIONI M040 
    where  ID_MISSIONE = pID;
    if wStatoM040 = 'L' then
      return 'L'; -- liquidati
    else
      return 'D'; -- da liquidare
    end if;
  end if;
EXCEPTION
  when others then
    return 'N';
END M150F_FILTRORIMBORSI;
/
