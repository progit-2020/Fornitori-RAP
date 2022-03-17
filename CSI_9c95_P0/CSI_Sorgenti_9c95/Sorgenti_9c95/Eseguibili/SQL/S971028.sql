CREATE TABLE T190_INTPAGHE (
  CODICE VARCHAR2(5) NOT NULL,
  P010 VARCHAR2(6),
  P020 VARCHAR2(6),
  P030 VARCHAR2(6),
  P060 VARCHAR2(6),
  P090 VARCHAR2(6),
  P100 VARCHAR2(6),
  P110 VARCHAR2(6),
  P120 VARCHAR2(6),
  P130 VARCHAR2(6),
  P140 VARCHAR2(6),
  P150 VARCHAR2(6),
  P170 VARCHAR2(6),
  P200 VARCHAR2(6),
  P230 VARCHAR2(6),
  P260 VARCHAR2(6),
  P270 VARCHAR2(6),
  P280 VARCHAR2(6),
  P290 VARCHAR2(6),
  F010 VARCHAR2(1),
  F020 VARCHAR2(1),
  F030 VARCHAR2(1),
  F060 VARCHAR2(1),
  F090 VARCHAR2(1),
  F100 VARCHAR2(1),
  F110 VARCHAR2(1),
  F120 VARCHAR2(1),
  F130 VARCHAR2(1),
  F140 VARCHAR2(1),
  F150 VARCHAR2(1),
  F170 VARCHAR2(1),
  F200 VARCHAR2(1),
  F230 VARCHAR2(1),
  F260 VARCHAR2(1),
  F270 VARCHAR2(1),
  F280 VARCHAR2(1),
  F290 VARCHAR2(1),
  GIORNI VARCHAR2(4),
  ORE VARCHAR2(4),
  NUMERO VARCHAR2(4),
  PRIMARY KEY (CODICE) USING INDEX TABLESPACE INDICI
)
  TABLESPACE LAVORO;


CREATE TABLE T191_PARPAGHE (
  CODICE VARCHAR2(5) NOT NULL,
  DESCRIZIONE VARCHAR2(40),
  ENTE VARCHAR2(7),
  DATA VARCHAR2(7),
  MATRICOLA VARCHAR2(7),
  BADGE VARCHAR2(7),
  CODINTERNO VARCHAR2(7),
  CODPAGHE VARCHAR2(7),
  SEGNO VARCHAR2(7),
  VALORE VARCHAR2(7),
  MISURA VARCHAR2(7),
  DEFAULTENTE VARCHAR2(20),
  TABELLAENTE VARCHAR2(50),
  CAMPOENTE VARCHAR2(30),
  NOMEFILE VARCHAR2(80),
  DATAFILE VARCHAR2(10),
  MESEANNO VARCHAR2(10),
  PRIMARY KEY (CODICE) USING INDEX TABLESPACE INDICI
)
  TABLESPACE LAVORO;


CREATE TABLE MONDOEDP.T340_TURNIREPERIB (
  PROGRESSIVO NUMBER(38, 2) NOT NULL,
  ANNO NUMBER(38, 2) NOT NULL,
  MESE NUMBER(38, 2) NOT NULL,
  TURNIINTERI NUMBER(38, 2),
  TURNIORE VARCHAR2(7),
  OREMAGG VARCHAR2(7),
  ORENONMAGG VARCHAR2(7),
  FLAGPAGHE VARCHAR2(1),
  PRIMARY KEY(PROGRESSIVO,ANNO,MESE) USING INDEX TABLESPACE INDICI
)
  TABLESPACE LAVORO;


  ALTER TABLE T270_RAGGRPRESENZE ADD INDPRESENZA VARCHAR2(1);


  ALTER TABLE T275_CAUPRESENZE ADD LIQUIDABILE VARCHAR2(1);
