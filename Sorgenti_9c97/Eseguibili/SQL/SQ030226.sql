UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.4.9' WHERE AZIENDA = :AZIENDA;

ALTER TABLE T291_PARMESSAGGI ADD TIPO_REGISTRAZIONE VARCHAR2(1) DEFAULT 'A';

-- Crea tabella per liquidazione ore anni precedenti
create table T134_ORELIQUIDATEANNIPREC
(
  PROGRESSIVO NUMBER(38,2) not null,
  ANNO		 NUMBER(38,2) not null,
  DATA		 DATE,
  ORE_LIQUIDATE    VARCHAR2(7),
  VARIAZIONE_ORE   VARCHAR2(7),
  NOTE		 VARCHAR2(100)
)
tablespace LAVORO pctfree 10 pctused 70 initrans 1 maxtrans 255
storage (initial 32K next 32K minextents 1 pctincrease 0);

-- Create/Recreate primary, unique and foreign key constraints 
alter table T134_ORELIQUIDATEANNIPREC
  add constraint T134_PK primary key (PROGRESSIVO,ANNO,DATA)
  using index  tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 32K minextents 1 pctincrease 0);

COMMENT ON COLUMN T134_ORELIQUIDATEANNIPREC.ANNO IS
  'Anno a cui si riferiscono le ore da liquidare';
COMMENT ON COLUMN T134_ORELIQUIDATEANNIPREC.DATA IS
  'Data di cassa del cedolino su cui le ore vengono liquidate';

UPDATE T025_CONTMENSILI SET RICALCOLO_MAX_SCOSTNEG = NULL;
ALTER TABLE T025_CONTMENSILI MODIFY RICALCOLO_MAX_SCOSTNEG VARCHAR2(5);
ALTER TABLE T025_CONTMENSILI ADD RICALCOLO_MAX_SCOSTPOS VARCHAR2(5);

ALTER TABLE T910_RIEPILOGO ADD TABELLA_GENERATA VARCHAR2(40);
ALTER TABLE T909_DATICALCOLATI ADD CODICE_STAMPA VARCHAR2(10);

--Modifica definizioni variabili per certificati
ALTER TABLE SG500_DATILIBERI MODIFY DESCRIZIONE VARCHAR2(200);
UPDATE SG500_DATILIBERI SET DESCRIZIONE = '' WHERE NOMECAMPO IN('CPeriodiAssenzaPer','DPeriodiAssenzaTot');

ALTER TABLE T020_ORARI ADD SCOST_PUNTI_NOMINALI NUMBER(2);

ALTER TABLE T275_CAUPRESENZE ADD SCOST_PUNTI_NOMINALI VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T275_CAUPRESENZE ADD SENZA_FLESSIBILITA VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T275_CAUPRESENZE ADD NO_LIMITE_MENSILE_LIQ VARCHAR2(1) DEFAULT 'N';

ALTER TABLE T265_CAUASSENZE ADD NO_SUPERO_COMPETENZE VARCHAR2(1) DEFAULT 'N';

ALTER TABLE T361_OROLOGI ADD APPLICA_PERCORRENZA_PM VARCHAR2(1) DEFAULT 'S';

-- CREDITI FORMATIVI --

create table SG650_CORSIECM
(
  COD_CORSO    VARCHAR2(15) not null,
  TITOLO_CORSO VARCHAR2(300),
  FLAG_INTERNO VARCHAR2(1) default 'I',
  LUOGO_CORSO  VARCHAR2(15),
  METODO_CORSO VARCHAR2(15),
  DOCENTE      VARCHAR2(300),
  NOTE         VARCHAR2(300)
)
tablespace LAVORO pctfree 10 pctused 60 initrans 1 maxtrans 255
  storage (initial 32K next 256K minextents 1 pctincrease 0);

alter table SG650_CORSIECM
  add constraint SG650_PK primary key (COD_CORSO)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 256K minextents 1 pctincrease 0);

create table SG651_PIANIFICAZIONECORSI
(
  PROGRESSIVO         NUMBER not null,
  COD_CORSO           VARCHAR2(15) not null,
  DATA_CORSO          DATE not null,
  ORA_INIZIO          DATE not null,
  ORA_FINE            DATE,
  DURATA_CORSO        DATE,
  NUMERO_CREDITI      NUMBER(10,2),
  TIPO_PARTECIPAZIONE VARCHAR2(15),
  NOTE                VARCHAR2(300),
  TIPO_RECORD         VARCHAR2(1) default 'M' not null
)
tablespace LAVORO pctfree 10 pctused 40 initrans 1 maxtrans 255
  storage (initial 32K next 256K minextents 1 pctincrease 0);

comment on column SG651_PIANIFICAZIONECORSI.TIPO_RECORD
  is 'M=MANUALE/A=AUTOMATICO';

alter table SG651_PIANIFICAZIONECORSI
  add constraint SG651_PK primary key (PROGRESSIVO,COD_CORSO,DATA_CORSO,ORA_INIZIO)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 256K minextents 1 pctincrease 0);

create table SG652_LUOGOCORSI
(
  CODICE      VARCHAR2(15) not null,
  DESCRIZIONE VARCHAR2(100)
)
tablespace LAVORO pctfree 10 pctused 70 initrans 1 maxtrans 255
  storage (initial 32K next 32K minextents 1 pctincrease 0);

alter table SG652_LUOGOCORSI
  add constraint SG652_PK primary key (CODICE)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 32K minextents 1 pctincrease 0);

create table SG653_METODOCORSI
(
  CODICE      VARCHAR2(15) not null,
  DESCRIZIONE VARCHAR2(100)
)
tablespace LAVORO pctfree 10 pctused 70 initrans 1 maxtrans 255
  storage (initial 32K next 32K minextents 1 pctincrease 0);

alter table SG653_METODOCORSI
  add constraint SG653_PK primary key (CODICE)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 32K minextents 1 pctincrease 0);

create table SG654_TIPOPARTECIPAZIONE
(
  CODICE      VARCHAR2(15) not null,
  DESCRIZIONE VARCHAR2(100)
)
tablespace LAVORO pctfree 10 pctused 70 initrans 1 maxtrans 255
  storage (initial 32K next 32K minextents 1 pctincrease 0);

alter table SG654_TIPOPARTECIPAZIONE
  add constraint SG654_PK primary key (CODICE)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 32K minextents 1 pctincrease 0);

-- FLUPER --

create table T930_PARESTRAZIONISTAMPE
(
  CODICE_PAR    VARCHAR2(10) not null,
  CODICE_STAMPA VARCHAR2(10) not null,
  TIPO_FILE     VARCHAR2(1) not null,
  NOME_FILE     VARCHAR2(200) not null
)
tablespace LAVORO pctfree 10 pctused 60 initrans 1 maxtrans 255
  storage (initial 32K next 64K minextents 1 pctincrease 0);

alter table T930_PARESTRAZIONISTAMPE
  add constraint T930_PK primary key (CODICE_PAR)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 32K minextents 1 pctincrease 0);

create table T931_TRACCIATOESTRAZIONISTAMPE
(
  CODICE_PAR     VARCHAR2(10) not null,
  DATO           VARCHAR2(40) not null,
  POSIZIONE      NUMBER(3),
  TIPO           VARCHAR2(20),
  VARIAZIONI_MAX NUMBER(3),
  CHIAVE         VARCHAR2(1) default 'N' not null
)
tablespace LAVORO pctfree 10 pctused 70 initrans 1 maxtrans 255
  storage (initial 32K next 64K minextents 1 pctincrease 0);

alter table T931_TRACCIATOESTRAZIONISTAMPE
  add constraint T931_PK primary key (CODICE_PAR,DATO)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 32K minextents 1 pctincrease 0);

create table T932_LOG
(
  ID          NUMBER not null,
  OPERATORE   VARCHAR2(20),
  DATA        DATE,
  DESCRIZIONE LONG,
  MASCHERA    VARCHAR2(10)
)
tablespace LAVORO pctfree 10 pctused 80 initrans 1 maxtrans 255
  storage (initial 32K next 256K minextents 1 pctincrease 0);

alter table T932_LOG
  add constraint T932_PK primary key (ID)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 256K minextents 1 pctincrease 0);

create sequence T932_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;
