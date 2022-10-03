create or replace procedure I093P_AGGIORNA_ITER(P_AZIENDA in varchar2, P_ITER in varchar2) as
begin
  begin
    --sel093
    insert into MONDOEDP.I093_BASE_ITER_AUT 
      (AZIENDA, ITER, REVOCABILE) 
      select P_AZIENDA, P_ITER, 'N' from dual where not exists (select 'x' from MONDOEDP.I093_BASE_ITER_AUT where AZIENDA = P_AZIENDA AND ITER = P_ITER);
    --sel095
    insert into MONDOEDP.I095_ITER_AUT I095 
      (AZIENDA, ITER, COD_ITER) 
      select P_AZIENDA, P_ITER, 'DEFAULT' from dual where not exists (select 'x' from MONDOEDP.I095_ITER_AUT where AZIENDA = P_AZIENDA AND ITER = P_ITER);
    --sel096
    insert into MONDOEDP.I096_LIVELLI_ITER_AUT 
      (AZIENDA, ITER, COD_ITER, LIVELLO, OBBLIGATORIO, AVVISO, VALORI_POSSIBILI, DATI_MODIFICABILI, INVIO_EMAIL) 
      select AZIENDA, ITER, COD_ITER, 1, 'S', 'N', 'S,N', 'N', 'N' from 
      (
        select AZIENDA,ITER,COD_ITER from MONDOEDP.I095_ITER_AUT minus
        select AZIENDA,ITER,COD_ITER from MONDOEDP.I096_LIVELLI_ITER_AUT
      );
  exception
    when others then  
      null;
  end;    
  
  commit;
end;
/