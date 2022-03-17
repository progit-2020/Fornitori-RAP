create or replace function T851F_FASE_CORRENTE(P_AZIENDA in varchar2, P_ITER in varchar2, P_COD_ITER in varchar2, P_ID in integer) return integer as
  result integer;
begin
  result:=-1;
  if P_ITER not in ('M140','T065') then
    return result;  
  end if;
  
  select nvl(max(T1.FASE),-1) into result from 
    (
    select I096.LIVELLO,I096.FASE
    from  MONDOEDP.I096_LIVELLI_ITER_AUT I096
    where 1=1
    and I096.AZIENDA = P_AZIENDA
    and I096.ITER = P_ITER
    and I096.COD_ITER = P_COD_ITER
    and I096.OBBLIGATORIO = 'S'
    ) T1,
    (
    select nvl(max(I096.LIVELLO),-1) LIVELLO
    from 
      MONDOEDP.I096_LIVELLI_ITER_AUT I096, 
      T851_ITER_AUTORIZZAZIONI T851
    where 1=1
    and I096.AZIENDA = P_AZIENDA
    and I096.ITER = P_ITER
    and I096.COD_ITER = P_COD_ITER
    and I096.OBBLIGATORIO = 'S'
    and T851.ID = P_ID
    and T851.LIVELLO = I096.LIVELLO
    and T851.STATO = 'S'
    ) T2
  where T1.LIVELLO = T2.LIVELLO;
  
  return result;
end;
/
