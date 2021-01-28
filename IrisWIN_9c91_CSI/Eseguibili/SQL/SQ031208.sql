-- CREAZIONE TABELLA PER LA STAMPA DELLA PIANTA ORGANICA
create table SG508_STAMPAPIANTA
(
  CODICE              VARCHAR2(10) not null,
  DESCRIZIONE         VARCHAR2(40),
  STRUTTURA           NUMBER not null,
  FLAG_TOTALE         VARCHAR2(1) not null,
  FONTNAME            VARCHAR2(30) not null,
  FONTSIZE            NUMBER(2) not null,
  ORIENTAMENTO_PAGINA NUMBER(1) not null,
  FORMATO_PAGINA      NUMBER(2) not null,
  FLAG_PERCENTUALIZZAPT VARCHAR2(1) not null
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  noparallel
  storage
  (
    initial 10K
    next 32K
    minextents 1
    pctincrease 0
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG508_STAMPAPIANTA
  add constraint SG508_PK primary key (CODICE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10K
    next 32K
    minextents 1
    maxextents 121
    pctincrease 0
  );
-- CREAZIONE TABELLA PER IL DETTAGLIO DI STAMPA DELLA PIANTA ORGANICA
create table SG509_DETTAGLIOSTAMPA
(
  CODICE_STAMPA      VARCHAR2(10) not null,
  ID_PIANTA          NUMBER not null,
  ID_RAMO            NUMBER not null,
  ID_PADRE           NUMBER not null,
  NOME_CAMPO         VARCHAR2(20) not null,
  DESCRIZIONE_STAMPA VARCHAR2(20),
  LIVELLO            NUMBER not null,
  TIPO_CAMPO         VARCHAR2(1) not null,
  VALORI             VARCHAR2(1000),
  FLAG_STAMPA        VARCHAR2(1) default 'N' not null,
  DIMENSIONE_CAMPO   NUMBER default 0 not null,
  FLAG_TOTALIZZA     VARCHAR2(1) default 'N' not null
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  noparallel
  storage
  (
    initial 10K
    next 32K
    minextents 1
    pctincrease 0
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG509_DETTAGLIOSTAMPA
  add constraint SG509_PK primary key (TIPO_CAMPO,LIVELLO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10K
    next 32K
    minextents 1
    pctincrease 0
  );
