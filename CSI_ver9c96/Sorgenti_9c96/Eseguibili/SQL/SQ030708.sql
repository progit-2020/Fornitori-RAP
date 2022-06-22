--------------------------------------
-- CREAZIONE TABELLA PIANTA ORGANICA
--------------------------------------
-- Create table
create table SG504_PIANTAORGANICA
(
  DATA                  DATE not null,
  ATTO                  VARCHAR2(100) not null,
  ID_PIANTA             NUMBER not null,
  NUMERO_POSTI          NUMBER(10,2) default 0,
  PARTTIME              NUMBER(8) default 0,
  NOTE                  VARCHAR2(1000),
  STRUTTURA_DEFAULT     VARCHAR2(1) default 'N',
  STRUTTURA_RIFERIMENTO NUMBER
)
tablespace LAVORO
  pctfree 10
  pctused 70
  initrans 1
  maxtrans 255
  storage
  (
    initial 40K
    next 64K
    minextents 1
    pctincrease 0
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG504_PIANTAORGANICA
  add constraint SG504_PK primary key (ID_PIANTA)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 40K
    next 32K
    minextents 1
    pctincrease 0
  );
-- Create/Recreate indexes 
create unique index T500_UK_ID_PIANTA on SG504_PIANTAORGANICA (ATTO,DATA)
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 40K
    next 32K
    minextents 1
    pctincrease 0
  );

--------------------------------------
-- CREAZIONE TABELLA PIANTA DETTAGLIO
--------------------------------------
-- Create table
create table SG505_PIANTADETTAGLIO
(
  ID_PIANTA    NUMBER not null,
  TIPO         NUMBER not null,
  NUMERO_POSTI NUMBER(8)
)
tablespace LAVORO
  pctfree 10
  pctused 70
  initrans 1
  maxtrans 255
  storage
  (
    initial 40K
    next 64K
    minextents 1
    pctincrease 0
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG505_PIANTADETTAGLIO
  add constraint SG505_PK primary key (ID_PIANTA,TIPO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 40K
    next 32K
    minextents 1
    pctincrease 0
  );

------------------------------------------
-- CREAZIONE TABELLA PIANTA DISTRIBUZIONE
------------------------------------------
-- Create table
create table SG506_PIANTADISTRIBUZIONE
(
  ID_PIANTA    NUMBER not null,
  ID_RAMO      NUMBER not null,
  ID_PADRE     NUMBER not null,
  LIVELLO      NUMBER not null,
  NOME_CAMPO   VARCHAR2(20) not null,
  VALORE_CAMPO VARCHAR2(80) not null,
  NUMERO_POSTI NUMBER(10,2) not null,
  NUMERO_CALCOLATI NUMBER(10,2) not null,
  PERCORSO VARCHAR2(1000) not null
)
tablespace LAVORO
  pctfree 10
  pctused 70
  initrans 1
  maxtrans 255
  storage
  (
    initial 180K
    next 128K
    minextents 1
    pctincrease 0
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG506_PIANTADISTRIBUZIONE
  add constraint SG506_PK primary key (ID_RAMO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 40K
    next 32K
    minextents 1
    pctincrease 0
  );
-- Create/Recreate indexes 
create unique index SG506_IDX on SG506_PIANTADISTRIBUZIONE (ID_PIANTA,ID_PADRE,LIVELLO,NOME_CAMPO,VALORE_CAMPO)
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10K
    next 186K
    minextents 1
    maxextents 121
    pctincrease 50
  );

------------------------------------------
-- CREAZIONE TABELLA PIANTA TIPI MOVIMENTO
------------------------------------------
-- Create table
create table SG507_TIPOMOVIMENTO
(
  CODICE      NUMBER not null,
  DESCRIZIONE VARCHAR2(40)
)
tablespace LAVORO
  pctfree 10
  pctused 70
  initrans 1
  maxtrans 255
  storage
  (
    initial 50K
    next 32K
    minextents 1
    pctincrease 0
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG507_TIPOMOVIMENTO
  add constraint SG507_PK primary key (CODICE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 40K
    next 32K
    minextents 1
    pctincrease 0
  );

------------------------------------------
-- CREAZIONE SEQUENZA X ID_PIANTA SU SG504
------------------------------------------
-- Create sequence 
create sequence SG504_ID_PIANTA
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

------------------------------------------
-- CREAZIONE SEQUENZA X ID_RAMO SU SG506
------------------------------------------
-- Create sequence 
create sequence SG506_ID_RAMO
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

------------------------------------------
-- CREAZIONE SEQUENZA X CODICE SU SG507
------------------------------------------
-- Create sequence 
create sequence SG507_CODICE
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

