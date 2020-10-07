create or replace function T851F_STATO_INTERMEDIO(p_ITER in varchar2, p_ID in integer) return varchar2 as
  result varchar2(1);
  w_AZIENDA varchar2(30);
begin
  result:=null;
  w_AZIENDA:=T000F_GETAZIENDACORRENTE;
  select 
    decode(T851.STATO,'N','N','S','S',I096.AUTORIZZ_INTERMEDIA,'S',T851.STATO) into result
  from 
     MONDOEDP.I096_LIVELLI_ITER_AUT I096, 
     T850_ITER_RICHIESTE T850, 
     T851_ITER_AUTORIZZAZIONI T851
   where T850.ITER = p_ITER
   and T850.ID = p_ID
   and T851.ID = T850.ID
   and I096.AZIENDA = w_AZIENDA
   and I096.ITER = T850.ITER
   and I096.COD_ITER = T850.COD_ITER
   and I096.LIVELLO = T851.LIVELLO
   and I096.AUTORIZZ_INTERMEDIA is not null;
   
   return result;
exception
  when no_data_found then
    return result;
end;
/
