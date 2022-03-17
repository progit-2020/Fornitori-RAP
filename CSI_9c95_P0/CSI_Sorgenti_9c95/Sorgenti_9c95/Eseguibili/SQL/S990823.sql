CREATE TABLE T800_CAMPILIMITI (
  TIPOLIMITE VARCHAR2(1) NOT NULL,
  DATADECORR DATE NOT NULL,
  NOMECAMPO1 VARCHAR2(20),
  NOMECAMPO2 VARCHAR2(20),
  CONSTRAINT T800_PK PRIMARY KEY (TIPOLIMITE, DATADECORR) USING INDEX TABLESPACE INDICI
) TABLESPACE LAVORO;

CREATE TABLE T810_LIQUIDABILE (
  CAMPO1 VARCHAR2(50) NOT NULL,
  CAMPO2 VARCHAR2(50) NOT NULL,
  ANNO   NUMBER(4,0)  NOT NULL,
  MESE   NUMBER(2,0)  NOT NULL,
  VALORE VARCHAR2(7),
  CONSTRAINT T810_PK PRIMARY KEY (CAMPO1, CAMPO2, ANNO, MESE) USING INDEX TABLESPACE INDICI
) TABLESPACE LAVORO;

CREATE TABLE T811_RESIDUABILE (
  CAMPO1 VARCHAR2(50) NOT NULL,
  CAMPO2 VARCHAR2(50) NOT NULL,
  ANNO   NUMBER(4,0)  NOT NULL,
  MESE   NUMBER(2,0)  NOT NULL,
  VALORE VARCHAR2(7),
  CONSTRAINT T811_PK PRIMARY KEY (CAMPO1, CAMPO2, ANNO, MESE) USING INDEX TABLESPACE INDICI
) TABLESPACE LAVORO;

CREATE TABLE T820_LIMITIIND (
  PROGRESSIVO NUMBER(38,2) NOT NULL,
  ANNO        NUMBER(4,0)  NOT NULL,
  MESE        NUMBER(2,0)  NOT NULL,
  LIQUIDABILE VARCHAR2(7),
  RESIDUABILE VARCHAR2(7),
  CONSTRAINT T820_PK PRIMARY KEY (PROGRESSIVO, ANNO, MESE) USING INDEX TABLESPACE INDICI
) TABLESPACE LAVORO;

CREATE TABLE T075_STRESTERNO (
  PROGRESSIVO NUMBER(38,2) NOT NULL,
  DATA        DATE  NOT NULL,
  CENTROCOSTO VARCHAR2(50),
  ORESTRAORD  VARCHAR2(7),
  CONSTRAINT T075_PK PRIMARY KEY (PROGRESSIVO, DATA, CENTROCOSTO) USING INDEX TABLESPACE INDICI
) TABLESPACE LAVORO;

ALTER TABLE T025_CONTMENSILI ADD INDENNITA VARCHAR2(1);
ALTER TABLE T025_CONTMENSILI ADD INDPRESENZA VARCHAR2(1);

ALTER TABLE T460_PARTTIME ADD INCENTIVI NUMBER;
UPDATE T460_PARTTIME SET INCENTIVI = PIANTA;

ALTER TABLE T020_ORARI ADD INDPRESSTR VARCHAR2(1);
ALTER TABLE T020_ORARI ADD INDFESTSTR VARCHAR2(1);
ALTER TABLE T020_ORARI ADD INDNOTSTR VARCHAR2(1);
UPDATE T020_ORARI SET INDPRESSTR = 'S',INDFESTSTR = 'N',INDNOTSTR = 'N';

CREATE TABLE T195_VOCIVARIABILI (
  PROGRESSIVO NUMBER,
  DATARIF DATE,
  VOCEPAGHE VARCHAR2(6),
  VALORE NUMBER,
  CONSTRAINT T195_PK PRIMARY KEY (PROGRESSIVO, DATARIF, VOCEPAGHE) USING INDEX TABLESPACE INDICI
) TABLESPACE LAVORO;

ALTER TABLE T190_INTPAGHE ADD F080 VARCHAR2(1);
ALTER TABLE T190_INTPAGHE ADD P080 VARCHAR2(6);
ALTER TABLE T190_INTPAGHE ADD F250 VARCHAR2(1);
UPDATE T190_INTPAGHE SET F080 = 'N', F250 = 'N';

ALTER TABLE T070_SCHEDARIEPIL ADD ADDEBITOPAGHE VARCHAR2(7);
ALTER TABLE T025_CONTMENSILI ADD RECUPERODEBITO VARCHAR2(1);
UPDATE T025_CONTMENSILI SET RECUPERODEBITO = 'N',INDENNITA = '0',INDPRESENZA = '0';

CREATE TABLE T165_INDSPECIALI (
  CODICE VARCHAR2(20),
  VOCEPAGHE VARCHAR2(6),
  IMPORTO NUMBER,
  NG NUMBER(2),
  CONSTRAINT T165_PK PRIMARY KEY (CODICE) USING INDEX TABLESPACE INDICI
) TABLESPACE LAVORO;

