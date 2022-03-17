create or replace function M141F_GETTOTALEKM(pID in integer, pINDKM varchar2, pSOMMA_RIENTRO varchar2) return integer is
  result integer;
/*
  Restituisce il totale dei km tra i percorsi della trasferta
  Parametri:
  pID
    id della richiesta di trasferta da considerare
  pINDKM
    T = considera le tappe, ignora l'impostazione del flag IND_KM
    S = considera solo le tappe per cui il flag IND_KM è S
    N = considera solo le tappe per cui il flag IND_KM è N (ha poco senso)
  pSOMMA_RIENTRO
    S = somma anche l'ultima tappa (il rientro) al totale km
    N = non considera nel totale km l'ultima tappa
*/
  cursor c1 is
    select m141.localita, m141.ind_km, m141.ord
    from   m141_percorso_missione m141
    where  m141.id = pID
    order by m141.ord;
  wKmTot           integer;
  wPartenza        m141_percorso_missione.localita%type;
  wDestinazione    m141_percorso_missione.localita%type;
  wLastOrd         m141_percorso_missione.ord%type;
begin
  wKmTot:=0;

  -- numero d'ordine dell'ultima tappa (rientro)
  select max(ord)
  into   wLastOrd
  from   m141_percorso_missione m141
  where  m141.id = pID;
  
  -- ciclo sulle localita del percorso
  for t1 in c1 loop
    if t1.ord = 1 then
      -- imposta la localita di partenza
      wPartenza:=t1.localita;
    else
      -- in base al flag di ind. km valuta se calcolare i km della tratta
      if (pINDKM = 'T') or (pINDKM = t1.ind_km) then
        -- somma la tratta (considera l'ultima tappa solo se richiesto)
        if (t1.ord < wLastOrd) or (pSOMMA_RIENTRO = 'S') then
          wDestinazione:=t1.localita;
          wKmTot:=wKmTot + m041f_getdistanza('',wPartenza,'',wDestinazione);
        end if;
      end if;
      
      -- la destinazione di questa tratta diventa la partenza della prossima tappa
      wPartenza:=wDestinazione;
    end if;
  end loop;
  
  result:=wKmTot;
  return result;
end;
/