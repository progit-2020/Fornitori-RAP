create or replace procedure T961P_STORICIZZAZIONE is
/*
begin
  sys.dbms_job.submit(job       => :job,
                      what      => 'begin
  T961P_STORICIZZAZIONE;
end;',
                      next_date => to_date('04-08-2021 01:00:00',
                                           'dd-mm-yyyy hh24:mi:ss'),
                      interval  => 'trunc(sysdate) + 1 + 1/24');
  commit;
end;
/

*/
  W_ANNI      integer;
  W_ELIMINATI varchar2(2) := '--'; --stringa di riconoscimento dei documenti eliminati
begin
  W_ANNI := -1;
  begin
    select nvl(DATO,-1)
      into W_ANNI
      from MONDOEDP.I091_DATIENTE
     where TIPO = 'C90_CANCELLA_ANNO_ALLEGATI_ITER'
       and AZIENDA = I090F_GETAZIENDACORRENTE;
  exception
    when NO_DATA_FOUND then
      null;
  end;

  if W_ANNI > -1 then
  
    --elimina gli allegati
    delete from T961_DOCUMENTI_FILE
     where ID in (select ID
                    from T960_DOCUMENTI_INFO
                   where TIPOLOGIA = 'ITER'
                     and DATA_CREAZIONE <=
                         add_months(trunc(sysdate, 'yyyy'), -12 * W_ANNI)
                     and PATH_STORAGE <> W_ELIMINATI);
  
    --aggiorna il path nelle info dei documenti eliminati
    update T960_DOCUMENTI_INFO
       set PATH_STORAGE = W_ELIMINATI
     where TIPOLOGIA = 'ITER'
       and DATA_CREAZIONE <=
           add_months(trunc(sysdate, 'yyyy'), -12 * W_ANNI);
  end if;
end;
/