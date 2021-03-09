create table I000_LOGINFO
(
  ID number(38) not null,
  OPERATORE varchar2(20) not null,
  DATA date not null,
  MASCHERA varchar2(10),
  TABELLA varchar2(60),
  OPERAZIONE varchar2(1) not null,
  constraint I000_UQ unique (id)
  using index tablespace INDICI
  storage
  (
    initial 128K
    next 128K
    minextents 1
    pctincrease 0
  )
)
  tablespace LAVORO
  storage
  (
    initial 256K
    next 256K
    minextents 1
    pctincrease 0
  );

create table I001_LOGDATI
(
  ID number(38) not null,
  COLONNA varchar2(40) not null,
  VALORE_OLD varchar2(60),
  VALORE_NEW varchar2(60)
)
  tablespace LAVORO
  storage
  (
    initial 256K
    next 256K
    minextents 1
    pctincrease 0
  );
  
alter table I001_LOGDATI
  add constraint I001_FK_I000 foreign key (id)
  references i000_loginfo (id) on delete cascade;
  
create sequence I000_ID
minvalue 1
start with 1
increment by 1;

rename MONDOEDP.I092_LOGTABELLE to MONDOEDP.I092_LOGTABELLE_OLD;

create table MONDOEDP.I092_LOGTABELLE (
  AZIENDA varchar2(30),
  SCHEDA varchar2(10), 
  constraint I092_UQ unique (AZIENDA,SCHEDA)
  using index tablespace INDICI
  storage
  (
    initial 50K
    next 50K
    minextents 1
    pctincrease 0
  )
)
  tablespace LAVORO
  storage
  (
    initial 50K
    next 50K
    minextents 1
    pctincrease 0
  );

insert into MONDOEDP.I092_LOGTABELLE
  select distinct AZIENDA,TABELLA from MONDOEDP.I092_LOGTABELLE_OLD;

drop table MONDOEDP.I092_LOGTABELLE_OLD;
