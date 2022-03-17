alter table T750_PROGETTI_RENDICONTO drop column REPORTING_PERIOD;

create table T756_REPORTING_RENDICONTO
(ID_T750          number(38)    not null, /*T750.id*/
 CODICE           varchar2(5)   not null,
 DECORRENZA       date,
 DECORRENZA_FINE  date)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T756_REPORTING_RENDICONTO.ID_T750 is 'T750.id';
comment on column T756_REPORTING_RENDICONTO.CODICE is 'Codice del reporting period';
comment on column T756_REPORTING_RENDICONTO.DECORRENZA is 'Inizio del reporting period';
comment on column T756_REPORTING_RENDICONTO.DECORRENZA_FINE is 'Fine del reporting period';

alter table T756_REPORTING_RENDICONTO add constraint T756_PK primary key (ID_T750,CODICE) using index
tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T756_REPORTING_RENDICONTO 
add constraint T756_FK_T750 foreign key (ID_T750) 
references T750_PROGETTI_RENDICONTO (ID) on delete cascade;