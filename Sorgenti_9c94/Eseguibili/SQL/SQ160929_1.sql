update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.7',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table T265_CAUASSENZE add CSI_MAX_MG number(8);
comment on column T265_CAUASSENZE.CSI_MAX_MG is 'Numero max di mezze giornate fruibili con la causale corrente';

alter table T925_SCHEDULAZIONI add DESCRIZIONE varchar2(80);

create sequence T005_ID minvalue 1 maxvalue 999999999999999999999999999 start with 1 increment by 1 nocache;

create table T005_RAGGRQUERYPERS
(
  id          NUMBER(38) not null,
  descrizione VARCHAR2(40) not null
)
tablespace LAVORO;

comment on column T005_RAGGRQUERYPERS.id is 'T005_ID.nextval';

alter table T005_RAGGRQUERYPERS
  add constraint T005_PK primary key (ID)
  using index tablespace INDICI;
	 
alter table T005_RAGGRQUERYPERS
  add constraint T005_UQ unique (DESCRIZIONE)
  using index tablespace INDICI;
  
create table T006_ASSOCIA_QUERYPERS_RAGGR
(
  id        NUMBER(38) not null,
  cod_query VARCHAR2(30) not null
)
tablespace LAVORO;
   
comment on column T006_ASSOCIA_QUERYPERS_RAGGR.id is 'T005.ID';
  
comment on column T006_ASSOCIA_QUERYPERS_RAGGR.cod_query is 'T002.NOME';
  
alter table T006_ASSOCIA_QUERYPERS_RAGGR
  add constraint T006_PK primary key (ID, COD_QUERY)
  using index tablespace INDICI;
 
alter table T006_ASSOCIA_QUERYPERS_RAGGR
  add constraint T006_FK_T005 foreign key (ID)
  references T005_RAGGRQUERYPERS (ID);

alter table MONDOEDP.I000_LOGINFO modify MASCHERA varchar2(30);