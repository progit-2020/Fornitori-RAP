CREATE TABLE T670_REGOLEBUONI (
  CODICE VARCHAR2(20),
  PASTO_TICKET VARCHAR2(1),
  ASSENZA VARCHAR2(120),
  PRESENZA VARCHAR2(120),
  OREMINIME DATE,
  NONLAVORATIVO VARCHAR2(1),
  CAUS_TICKET VARCHAR2(120),
  DA1 DATE,
  A1 DATE,
  DA2 DATE,
  A2 DATE,
  CONSTRAINT T670_PK PRIMARY KEY (CODICE)
    USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

CREATE TABLE T680_BUONIMENSILI(
  PROGRESSIVO NUMBER(8),
  ANNO NUMBER(4),
  MESE NUMBER(2),
  BUONIPASTO NUMBER(3),
  VARBUONIPASTO NUMBER(3),
  TICKET NUMBER(3),
  VARTICKET NUMBER(3),
  CONSTRAINT T680_PK PRIMARY KEY (PROGRESSIVO,ANNO,MESE)
    USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

CREATE TABLE T690_ACQUISTOBUONI(
  PROGRESSIVO NUMBER(8),
  DATA DATE,
  BUONIPASTO NUMBER(3),
  TICKET NUMBER(3),
  CONSTRAINT T690_PK PRIMARY KEY (PROGRESSIVO,DATA)
    USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

