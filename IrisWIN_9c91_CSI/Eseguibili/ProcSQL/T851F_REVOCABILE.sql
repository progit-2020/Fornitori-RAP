create or replace function T851F_REVOCABILE(p_AZIENDA in varchar2, p_ITER in varchar2, p_COD_ITER in varchar2, p_ID in integer) return varchar2 as
  --w_MINLIVNEGATO integer;
  w_MINLIVNOTNULL integer;
  --w_LIVINTERMNOTNULL integer;
  w_STATO varchar2(1);
  w_AUTORIZZ_INTERMEDIA varchar2(1);
  X integer;
  result varchar2(10);
begin
  /*
  result: CANC    = la richiesta può essere cancellata
          REVOC   = la richiesta può essere revocata
          NO_CANC = la richiesta non può essere nè cancellata nè revocata
  */
  --posso cancellare
  result:='CANC';
 
  --verifico se esiste autorizzazione intermedia (preventiva) già trasformata in definitiva
  select nvl(min(T851.STATO),'N'),nvl(min(I096.AUTORIZZ_INTERMEDIA),' ')
  into w_STATO, w_AUTORIZZ_INTERMEDIA 
  from MONDOEDP.I096_LIVELLI_ITER_AUT I096, T851_ITER_AUTORIZZAZIONI T851
  where 1=1
  and T851.ID = p_ID
  and I096.AZIENDA = p_AZIENDA
  and I096.ITER = p_ITER
  and I096.COD_ITER = p_COD_ITER
  and I096.LIVELLO = T851.LIVELLO
  and I096.AUTORIZZ_INTERMEDIA is not null
  and nvl(T851.STATO,'N') <> 'N'
  and not exists
    (select 'x' 
     from T851_ITER_AUTORIZZAZIONI 
      where 1=1
      and ID = T851.ID
      and LIVELLO > T851.LIVELLO
      and STATO is not null
     ); 
     
  -- se esiste si può cancellare
  if w_STATO <> 'S' then
    select nvl(min(I096.LIVELLO),0) into w_MINLIVNOTNULL
    from MONDOEDP.I096_LIVELLI_ITER_AUT I096, T851_ITER_AUTORIZZAZIONI T851
    where 1=1
    and T851.ID = p_ID
    and I096.AZIENDA = p_AZIENDA
    and I096.ITER = p_ITER
    and I096.COD_ITER = p_COD_ITER
    and I096.LIVELLO = T851.LIVELLO
    and T851.STATO is not null; -- se esiste non si può più cancellare (anche i visti???)
 
    if w_MINLIVNOTNULL > 0 then
      --non posso cancellare
      result:='NO_CANC';
      
      if w_STATO = w_AUTORIZZ_INTERMEDIA then
        result:='REVOC';
      else  
        --verifico se posso revocare in caso di autorizzazione definitiva
        --select decode(STATO,'S','REVOC',result) into result
        select STATO into w_STATO
        from T850_ITER_RICHIESTE
        where ITER = p_ITER
        and COD_ITER = p_COD_ITER
        and ID = p_ID; 
        
        if w_STATO = 'S' then
          result:='REVOC';
        elsif w_STATO is null then
          -- estrae autorizzazione dell'ultimo livello autorizzato
          select decode(STATO,'S','REVOC',result) into result
          from T851_ITER_AUTORIZZAZIONI
          where ID = p_ID
          and LIVELLO = T851F_MAXLIV_AUTORIZZATO(p_AZIENDA, p_ITER, p_ID); 
          
          if result = 'REVOC' then
            -- consente la cancellazione se tutti i livelli hanno autorizzazione automatica
            -- e non esiste l'autorizzazione definitiva
            select count(*) into X
            from
              MONDOEDP.I096_LIVELLI_ITER_AUT I096,
              T850_ITER_RICHIESTE T850,
              T851_ITER_AUTORIZZAZIONI T851
            where 1=1
            and T850.ITER = P_ITER
            and T850.ID = P_ID
            and I096.AZIENDA = P_AZIENDA
            and I096.ITER = T850.ITER
            and I096.COD_ITER = T850.COD_ITER
            and I096.OBBLIGATORIO = 'S'
            and T851.ID = P_ID
            and T851.LIVELLO = I096.LIVELLO
            and nvl(T851.AUTORIZZ_AUTOMATICA,'N') = 'N'
            and T851.STATO is not null;
            
            if X = 0 then
              result:='CANC';
            end if;  
          end if;  
          
        end if;
      end if;
      
      /*Condizione originale di revoca al posto delle 2 precedenti
      --posso revocare solo se non esiste un livello obbligatorio negato
      select nvl(min(I096.LIVELLO),0) into w_MINLIVNEGATO
      from MONDOEDP.I096_LIVELLI_ITER_AUT I096, T851_ITER_AUTORIZZAZIONI T851
      where 1=1
      and T851.ID = p_ID
      and I096.AZIENDA = p_AZIENDA
      and I096.ITER = p_ITER
      and I096.COD_ITER = p_COD_ITER
      and I096.LIVELLO = T851.LIVELLO
      and I096.OBBLIGATORIO = 'S' 
      and T851.STATO = 'N';
 
      if w_MINLIVNEGATO = 0 then
        --posso revocare
        result:='REVOC';
      end if;
      */
    end if;
  end if;
 
  return result;
end;
/