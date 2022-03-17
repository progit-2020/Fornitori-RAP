create or replace function I075F_LIVOBBPRECAUT(p_AZIENDA in varchar2, p_ITER in varchar2, p_COD_ITER in varchar2, p_ID in integer, p_PROFILO in varchar2) return varchar2 as
--restituisce 'S' se la richiesta è visibile all'autorizzatore in quanto già autorizzata precedentemente
  result varchar2(1);
  w_MIN_LIVELLO integer;
  w_LIVELLO_PREC integer;
begin
  result:='N';
  --cerco livello minimo a cui l'operatore ha accesso
  select nvl(min(I075.LIVELLO),-1) into w_MIN_LIVELLO
  from MONDOEDP.I075_ITER_AUTORIZZATIVI I075
  where 1=1
  and I075.AZIENDA = p_AZIENDA
  and I075.PROFILO = p_PROFILO
  and I075.ITER = p_ITER
  and I075.COD_ITER = p_COD_ITER
  and I075.ACCESSO <> 'N';
  
  if w_MIN_LIVELLO < 1 then
    result:='N';  --non c'è accesso
  elsif w_MIN_LIVELLO = 1 then
    result:='S';  --c'è accesso al primo livello: richieste sempre visibili
  else
    --accesso a un livello superiore al primo: verifico se il livello obbligaotorio precedente è autorizzato
    select nvl(max(LIVELLO),-1) into w_LIVELLO_PREC
    from MONDOEDP.I096_LIVELLI_ITER_AUT
    where AZIENDA = p_AZIENDA
    and ITER = p_ITER
    and COD_ITER = p_COD_ITER
    and OBBLIGATORIO = 'S'
    and LIVELLO < w_MIN_LIVELLO;
      
    if w_LIVELLO_PREC = -1 then
      result:='S';  --non esiste livello obbligatorio precedente: richieste sempre visbili (come per il primo livello)
    else
      select nvl(min(STATO),'N') into result
      from T851_ITER_AUTORIZZAZIONI
      where 1 = 1
      and ID = p_ID
      and LIVELLO = w_LIVELLO_PREC
      and STATO = 'S';
    end if;  
  end if;

  return result;
end;
/
