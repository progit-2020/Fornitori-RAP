create or replace function T851F_MAXLIV_AUTORIZZATO(P_AZIENDA in varchar2, P_ITER in varchar2, P_ID in integer) return integer as
  result integer;
begin
  select nvl(max(I096.LIVELLO),-1) LIVELLO into result
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
  and T851.STATO is not null;
  return result;
end;
/
