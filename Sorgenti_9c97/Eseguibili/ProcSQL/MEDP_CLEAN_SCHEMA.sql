create or replace procedure MEDP_CLEAN_SCHEMA as
--job per eseguire mensilmente MEDP_CLEAN_SCHEMA
  cursor crsT280 is 
    select distinct trunc(DATA,'mm') DATA from T280_MESSAGGIWEB 
    where DATA < add_months(trunc(sysdate,'mm'),-24) 
    order by 1;

  cursor crsI000_1MM is
    select ID from I000_LOGINFO 
    where MASCHERA in ('A167','WA167')
    and DATA < add_months(trunc(sysdate,'mm'),-1)
    order by 1;

  cursor crsI000_3MM is
    select ID from I000_LOGINFO 
    where MASCHERA in ('A027','WA027','W009')
    and TABELLA = 'T070_SCHEDARIEPIL'
    and DATA < add_months(trunc(sysdate,'mm'),-3)
    order by 1;

  cursor crsI000_2AA is--???
    select ID from I000_LOGINFO 
    where MASCHERA in ('W032')
    and DATA < add_months(trunc(sysdate,'mm'),24)
    order by 1;
  
  cursor crsI005_1MM is
    select distinct trunc(DATA,'mm') DATA from MONDOEDP.I005_MSGINFO 
    where MASCHERA in ('B027','B028') and DATA < add_months(trunc(sysdate),-1) 
    order by 1;

  cursor crsI005_3MM is
    select distinct trunc(DATA,'mm') DATA from MONDOEDP.I005_MSGINFO 
    where MASCHERA like 'W0%' and DATA < add_months(trunc(sysdate),-3) 
    order by 1;

  cursor crsI005_AA is
    select distinct trunc(DATA,'mm') DATA from MONDOEDP.I005_MSGINFO 
    where DATA < add_months(trunc(sysdate),-12) 
    order by 1;

  cursor crsTS is 
    select distinct TSLAVORO TS from MONDOEDP.I090_ENTI 
    union select distinct TSINDICI from MONDOEDP.I090_ENTI
    union select distinct TSAUSILIARIO from MONDOEDP.I090_ENTI;
      
  wUserName varchar2(30);     
begin
  ------------------------
  --Pulizia recycle bin --
  ------------------------
  /*
  for TS in crsTS loop
    begin
      execute immediate 'purge tablespace '||TS.TS;
    exception when others then null; end;
  end loop;
  */

  ---------------------------
  -- Delete vecchi records --
  ---------------------------
  select USERNAME into wUserName 
  from USER_USERS;
  
  if wUserName = 'MONDOEDP' then
    --cancellazione forzata dei log di integrazione anagrafica precedenti ai 12 mesi
    /*
    execute immediate 'delete from MONDOEDP.IA000_LOGINTEGRAZIONE where DATA_ELABORAZIONE < add_months(trunc(sysdate,''mm''),-24)';
    commit;
    */
    
    --cancellazione forzata dei messaggi delle elaborazioni
    for I005 in crsI005_1MM loop
      delete from MONDOEDP.I005_MSGINFO 
      where trunc(DATA,'mm') = I005.DATA
      and MASCHERA in ('B027','B028');
      commit;
    end loop;  
  
    for I005 in crsI005_3MM loop
      delete from MONDOEDP.I005_MSGINFO 
      where trunc(DATA,'mm') = I005.DATA
      and MASCHERA like 'W0%';
      commit;
    end loop;  

    for I005 in crsI005_AA loop
      delete from MONDOEDP.I005_MSGINFO 
      where trunc(DATA,'mm') = I005.DATA;
      commit;
    end loop;  
  end if;  

  /*
  --cancellazione forzata dei messaggi web precedenti ai 24 mesi
  for T280 in crsT280 loop
    delete from T280_MESSAGGIWEB where trunc(DATA,'mm') = T280.DATA;
    commit;
  end loop;  
  
  --cancellazione forzata dei certificati INPS più vecchi di un anno
  delete from T960_DOCUMENTI_INFO T960
  where trunc(T960.DATA_CREAZIONE) < add_months(trunc(sysdate,'mm'),-12)
  and T960.TIPOLOGIA = 'MEDP_INPS';
  commit;
  
  --cancellazione forzata dei log di stampa del cartellino più vecchi di 3 mesi
  for I000 in crsI000_3MM loop
    delete from I000_LOGINFO 
    where ID = i000.ID;
    commit;
  end loop;  
  */

  --cancellazione forzata dei log degli incentivi più vecchi di 1 mese
  for I000 in crsI000_1MM loop
    delete from I000_LOGINFO 
    where ID = i000.ID;
    commit;
  end loop;
  
  ------------
  -- Shrink --
  ------------
  /*
  if wUserName = 'MONDOEDP' then
    begin 
      execute immediate 'alter table MONDOEDP.IA000_LOGINTEGRAZIONE enable row movement';
      execute immediate 'alter table MONDOEDP.IA000_LOGINTEGRAZIONE shrink space cascade';
    exception when others then null; end;
    begin
      execute immediate 'alter table IA000_LOGINTEGRAZIONE disable row movement';
    exception when others then null; end;

    if to_char(sysdate,'hh24.mi') <= '04.00' then
      begin
        execute immediate 'alter table MONDOEDP.I005_MSGINFO enable row movement';
        execute immediate 'alter table MONDOEDP.I005_MSGINFO shrink space cascade';
      exception when others then null; end;
      begin
        execute immediate 'alter table MONDOEDP.I005_MSGINFO disable row movement';
      exception when others then null; end;
      
      begin
        execute immediate 'alter table MONDOEDP.I006_MSGDATI enable row movement';
        execute immediate 'alter table MONDOEDP.I006_MSGDATI shrink space cascade';
      exception when others then null; end;
      begin
        execute immediate 'alter table MONDOEDP.I006_MSGDATI disable row movement';
      exception when others then null; end;
    end if;  
  end if;   

  begin 
    execute immediate 'alter table T280_MESSAGGIWEB enable row movement';
    execute immediate 'alter table T280_MESSAGGIWEB shrink space cascade';
  exception when others then null; end;
  begin
    execute immediate 'alter table T280_MESSAGGIWEB disable row movement';
  exception when others then null; end;

  if to_char(sysdate,'hh24.mi') <= '04.00' then
    begin 
      execute immediate 'alter table I000_BACKUP enable row movement';
      execute immediate 'alter table I000_BACKUP shrink space cascade';
    exception when others then null; end;
    begin
      execute immediate 'alter table I000_BACKUP disable row movement';
    exception when others then null; end;
    
    begin    
      execute immediate 'alter table I001_BACKUP enable row movement';
      execute immediate 'alter table I001_BACKUP shrink space cascade';
    exception when others then null; end;
    begin
      execute immediate 'alter table I001_BACKUP disable row movement';
    exception when others then null; end;

    begin
      execute immediate 'alter table I000_LOGINFO enable row movement';
      execute immediate 'alter table I000_LOGINFO shrink space cascade';
    exception when others then null; end;
    begin
      execute immediate 'alter table I000_LOGINFO disable row movement';
    exception when others then null; end;

    begin    
      execute immediate 'alter table I001_LOGDATI enable row movement';
      execute immediate 'alter table I001_LOGDATI shrink space cascade';
    exception when others then null; end;
    begin
      execute immediate 'alter table I001_LOGDATI disable row movement';
    exception when others then null; end;
  end if;  
  */
end;
/