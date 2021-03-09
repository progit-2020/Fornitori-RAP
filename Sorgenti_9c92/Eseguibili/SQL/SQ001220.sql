-- Create table 
create table T026_SALDIABBATTUTI
(
  CODICE varchar2(5) not null,
  ANNO_RIF number(4) not null,
  MESE_RIF number(2) not null,
  MESE_ABBATT number(2) not null
)
  tablespace LAVORO
  pctfree 10
  pctused 70
  storage
  (
    initial 256K
    next 256K
    minextents 1
    pctincrease 0
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table T026_SALDIABBATTUTI
  add constraint T026_PK primary key (codice,anno_rif,mese_rif)
  using index 
  tablespace INDICI
  pctfree 10
  storage
  (
    initial 256K
    next 256K
    minextents 1
    pctincrease 0
  );
alter table T026_SALDIABBATTUTI
  add constraint T026_FK_T025 foreign key (codice)
  references t025_contmensili (codice) on delete cascade;
  
alter table T760_REGOLEINCENTIVI
  add FRANCHIGIA_ASSENZE number(3);
alter table T760_REGOLEINCENTIVI
  add TIPO varchar2(1) default 'A';

alter table T025_CONTMENSILI 
  add RECUPERO_SERBATOI varchar2(1) default 'G';

-- Create table 
create table T003_SELEZIONIANAGRAFE
(
  NOME VARCHAR2(20) not null,
  POSIZIONE NUMBER(3) not null,
  RIGA VARCHAR2(2000) not null
)
  tablespace LAVORO
  pctfree 10
  pctused 80
  initrans 1
  maxtrans 255
  storage
  (
    initial 256K
    next 256K
    minextents 1
    pctincrease 0
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table T003_SELEZIONIANAGRAFE
  add constraint T003_PK primary key (NOME,POSIZIONE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 256K
    minextents 1
    pctincrease 0
  );
  
