DROP INDEX T040_CAUSALE;
ALTER TABLE T040_GIUSTIFICATIVI DROP CONSTRAINT T040PK;
alter table T040_GIUSTIFICATIVI
  add constraint T040_PK primary key (PROGRESSIVO,DATA,CAUSALE,PROGRCAUSALE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10M
    next 5M
    minextents 1
    pctincrease 0
  );

ALTER TABLE T040_GIUSTIFICATIVI ADD DATANAS DATE;
-- Create/Recreate indexes 
create index T040_DATANAS on T040_GIUSTIFICATIVI (progressivo,data,causale,datanas)
  tablespace INDICI
  pctfree 10
  storage
  (
    initial 10M
    next 5M
    minextents 1
    pctincrease 0
  );

ALTER TABLE T265_CAUASSENZE ADD CUMULO_FAMILIARI VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE ADD FRUIZIONE_FAMILIARI VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE ADD OFFSET_FRUIZIONE NUMBER(3);

-- Create table 
create table T375_ACCESSIMENSA
(
  PROGRESSIVO number,
  DATA date,
  CAUSALE varchar2(5) default '*',
  ACCESSI number(3)
)
  tablespace LAVORO
  pctfree 10
  pctused 70
  storage
  (
    initial 512K
    next 256K
    minextents 1
    pctincrease 0
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table T375_ACCESSIMENSA
  add constraint T375_PK primary key (progressivo,data,causale)
  using index 
  tablespace INDICI
  pctfree 10
  storage
  (
    initial 512K
    next 256K
    minextents 1
    pctincrease 0
  );

/*
Familiari dipendente
Integrità referenziali: T030_ANAGRAFICO
*/

CREATE TABLE SG101_FAMILIARI (
  PROGRESSIVO NUMBER,  
  NUMORD NUMBER NOT NULL,  
  DECORRENZA DATE,
  COGNOME VARCHAR2 (30),
  NOME VARCHAR2 (30),
  COMNAS VARCHAR2 (6),
  /*Data di nascita (obbligatoria per i figli)*/
  DATANAS DATE,
  /*Grado di parentela:
      CG=Coniuge
      FG=Figlio
      GT=Genitore
      FR=Fratello
      AL=Altro familiare*/
  GRADOPAR VARCHAR2(2) DEFAULT 'FG',
  /*Tipo detrazione:
      ND=Nessuna Detrazione
      DC=Detrazione per Coniuge
      DF=Detrazione per Figli
      DA=Detrazione per Altro familiare*/
  TIPO_DETRAZIONE VARCHAR2(2) DEFAULT 'ND',
  PERC_CARICO NUMBER DEFAULT 0,
  /*Ulteriore detrazione per figlio infratreenne (S/N)  (chiedere solo se si tratta di figlio) */
  ULT_DETR_FIGLIO VARCHAR2(1) DEFAULT 'N',
  DATAMAT DATE,
  DATASEP DATE
)
STORAGE (PCTINCREASE 0 initial 512K next 128K) 
TABLESPACE LAVORO pctfree 10 pctused 40;

alter table SG101_FAMILIARI
  add constraint SG101_PK primary key (PROGRESSIVO,NUMORD,DECORRENZA)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    pctincrease 0
  );

ALTER TABLE SG101_FAMILIARI ADD CONSTRAINT SG101_FK_T030
  FOREIGN KEY (PROGRESSIVO) REFERENCES T030_ANAGRAFICO;

