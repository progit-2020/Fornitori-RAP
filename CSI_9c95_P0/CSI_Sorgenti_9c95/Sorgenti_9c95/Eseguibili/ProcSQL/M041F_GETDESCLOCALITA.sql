create or replace function M041F_GETDESCLOCALITA(pLOCALITA in varchar2) return varchar2 as
  result varchar2(2000);
/*
  Decodifica il codice di località indicato utilizzando la tabella M041_DISTANZE
  Se il codice non è esistente restituisce il codice stesso
*/
begin
  select max(DESCRIZIONE)
  into   result
  from
    (
     select T480.CITTA DESCRIZIONE
     from   M041_DISTANZE M041,
            T480_COMUNI T480
     where  M041.LOCALITA1 = pLOCALITA
     and    M041.TIPO1 = 'C'
     and    M041.LOCALITA1 = T480.CODICE
     union
     select M042.DESCRIZIONE
     from   M041_DISTANZE M041,
            M042_LOCALITA M042
     where  M041.LOCALITA1 = pLOCALITA
     and    M041.TIPO1 = 'P'
     and    M041.LOCALITA1 = M042.CODICE
     union
     select T480.CITTA
     from   M041_DISTANZE M041,
            T480_COMUNI T480
     where  M041.LOCALITA2 = pLOCALITA
     and    M041.TIPO2 = 'C'
     and    M041.LOCALITA2 = T480.CODICE
     union
     select M042.DESCRIZIONE
     from   M041_DISTANZE M041,
            M042_LOCALITA M042
     where  M041.LOCALITA2 = pLOCALITA
     and    M041.TIPO2 = 'P'
     and    M041.LOCALITA2 = M042.CODICE
    );

  -- se non esiste decodifica restituisce il codice stesso
  if result is null then
    result:=pLOCALITA;
  end if;
  return result;
end;
/