update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.8',PATCHDB = 3 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

create table I051_SQL_CUSTOM (
  NOME varchar2(100),
  DESCRIZIONE varchar2(1000),
  TIMESTAMP date default sysdate not null,
  NUMORD number(8),
  ATTIVO varchar2(1) default 'S' not null,
  SCRIPT_SQL clob not null,
  DATA_ESECUZIONE date,
  ESITO_ESECUZIONE varchar2(4000)
) 
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column I051_SQL_CUSTOM.NOME is 'Nome dello script';
comment on column I051_SQL_CUSTOM.DESCRIZIONE is 'Descrizione dello script';
comment on column I051_SQL_CUSTOM.TIMESTAMP is 'Timestamp creazione/ultimo aggiornamento di questo record';
comment on column I051_SQL_CUSTOM.NUMORD is 'Ordine di esecuzione. Se non specificato gli script saranno eseguiti per ultimi';
comment on column I051_SQL_CUSTOM.ATTIVO is 'Indica lo lo script sarà eseguito (S=esegui, N=non eseguire)';
comment on column I051_SQL_CUSTOM.SCRIPT_SQL is 'Script da eseguire';
comment on column I051_SQL_CUSTOM.DATA_ESECUZIONE is 'Data e ora dell''ultima esecuzione';
comment on column I051_SQL_CUSTOM.ESITO_ESECUZIONE is 'Esito ultima esecuzione';

alter table I051_SQL_CUSTOM add constraint I051_PK primary key (NOME) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create or replace procedure MEDP_CLEAN_SCHEMA as
begin
	null;
end;
/
	
declare
  --elenco job da eliminare
  cursor c1 is
    select JOB from user_jobs
    where WHAT like '%MEDP_CLEAN_SCHEMA%' or WHAT like '%T960P_DEL_MEDP_INPS%';
  w_job integer;
begin
  --eliminazione job
  for t1 in c1 loop
    DBMS_JOB.REMOVE(t1.JOB);
  end loop;
  
  --ricreazione job MEDP_CLEAN_SCHEMA
  sys.dbms_job.submit
    (job => w_job,
     what => 'begin MEDP_CLEAN_SCHEMA; end;',
     next_date => add_months(trunc(sysdate,'mm'),1) + (1/24),
     interval => 'add_months(trunc(sysdate,''mm''),1) + (1/24)'
    );
  commit;
end;
/
