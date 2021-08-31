create or replace function T851F_AVVISO_LIVPREC(p_AZIENDA in varchar2, p_PROFILO in varchar2, p_ITER in varchar2, p_COD_ITER in varchar2, p_ID in integer) return varchar2 as
  w_LIVELLO integer;
  i integer;
  result varchar2(1);
  
  cursor c1 is   
    select T851.LIVELLO,T851.STATO
    from MONDOEDP.I096_LIVELLI_ITER_AUT I096,T851_ITER_AUTORIZZAZIONI T851 
    where I096.AZIENDA = p_AZIENDA 
    and I096.ITER = p_ITER
    and I096.COD_ITER = p_COD_ITER
    and I096.AVVISO = 'S'
    and I096.LIVELLO < w_LIVELLO
    and I096.LIVELLO > (select nvl(max(LIVELLO),0) 
                        from MONDOEDP.I096_LIVELLI_ITER_AUT 
                        where I096.AZIENDA = AZIENDA 
                        and I096.ITER = ITER
                        and I096.COD_ITER = COD_ITER
                        and OBBLIGATORIO = 'S'
                        and LIVELLO < w_LIVELLO)
    and T851.ID(+) = p_ID
    and T851.LIVELLO(+) = I096.LIVELLO
    order by I096.LIVELLO;
    
begin
  result:='N';

  select count(*) into i 
  from MONDOEDP.I096_LIVELLI_ITER_AUT I096 
  where I096.AZIENDA = p_AZIENDA 
  and I096.ITER = p_ITER
  and I096.COD_ITER = p_COD_ITER
  and i096.AVVISO = 'S';
  if i = 0 then
    return result;
  end if;
  
  w_LIVELLO:=T851F_LIVELLO_AUTORIZZABILE(p_AZIENDA, p_PROFILO, p_ITER, p_COD_ITER, p_ID);
  for t1 in c1 loop
    if t1.STATO is null then
      result:='S';
      exit;
    end if;
  end loop;
  
  return result;
end;
/