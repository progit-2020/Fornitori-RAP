CREATE TABLE T061_PLUSORAANNUO (
  ANNO NUMBER(38, 2) NOT NULL,
  CODICE VARCHAR2(5) NOT NULL,
  TIPOPO VARCHAR2(1),
  TIPODEBITO VARCHAR2(1),
  ORE1 VARCHAR2(5),
  ORE2 VARCHAR2(5),
  ORE3 VARCHAR2(5),
  ORE4 VARCHAR2(5),
  ORE5 VARCHAR2(5),
  ORE6 VARCHAR2(5),
  ORE7 VARCHAR2(5),
  ORE8 VARCHAR2(5),
  ORE9 VARCHAR2(5),
  ORE10 VARCHAR2(5),
  ORE11 VARCHAR2(5),
  ORE12 VARCHAR2(5),
  TIPOGEST1 VARCHAR2(1),
  TIPOGEST2 VARCHAR2(1),
  TIPOGEST3 VARCHAR2(1),
  TIPOGEST4 VARCHAR2(1),
  TIPOGEST5 VARCHAR2(1),
  TIPOGEST6 VARCHAR2(1),
  TIPOGEST7 VARCHAR2(1),
  TIPOGEST8 VARCHAR2(1),
  TIPOGEST9 VARCHAR2(1),
  TIPOGEST10 VARCHAR2(1),
  TIPOGEST11 VARCHAR2(1),
  TIPOGEST12 VARCHAR2(1),
  PRIMARY KEY (ANNO,CODICE) USING INDEX TABLESPACE INDICI
)
  TABLESPACE LAVORO;

INSERT INTO T061_PLUSORAANNUO 
SELECT 
  ANNO,CODICE,TIPOPO,
  TIPODEBITO,
  ORE1,  ORE2,  ORE3,  ORE4,  ORE5,  ORE6,
  ORE7,  ORE8,  ORE9,  ORE10,  ORE11,  ORE12,
  TIPOGEST1,  TIPOGEST2,  TIPOGEST3,
  TIPOGEST4,  TIPOGEST5,  TIPOGEST6,
  TIPOGEST7,  TIPOGEST8,  TIPOGEST9,
  TIPOGEST10,  TIPOGEST11,  TIPOGEST12
FROM T060_PLUSORARIO;

DROP TABLE T060_PLUSORARIO;

CREATE TABLE T060_PLUSORARIO (
  CODICE VARCHAR2(5) NOT NULL,
  DESCRIZIONE VARCHAR2(40),
  PRIMARY KEY (CODICE) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

INSERT INTO T060_PLUSORARIO (CODICE)
SELECT 
  DISTINCT(CODICE)
FROM T061_PLUSORAANNUO;

DROP TABLE T090_PLUSORAINDIV;

CREATE TABLE T090_PLUSORAINDIV (
  PROGRESSIVO NUMBER(38, 2) NOT NULL,
  ANNO NUMBER(38, 2) NOT NULL,
  TIPOPO VARCHAR2(1),
  TIPODEBITO VARCHAR2(1),
  ORE1 VARCHAR2(5),
  ORE2 VARCHAR2(5),
  ORE3 VARCHAR2(5),
  ORE4 VARCHAR2(5),
  ORE5 VARCHAR2(5),
  ORE6 VARCHAR2(5),
  ORE7 VARCHAR2(5),
  ORE8 VARCHAR2(5),
  ORE9 VARCHAR2(5),
  ORE10 VARCHAR2(5),
  ORE11 VARCHAR2(5),
  ORE12 VARCHAR2(5),
  TIPOGEST1 VARCHAR2(1),
  TIPOGEST2 VARCHAR2(1),
  TIPOGEST3 VARCHAR2(1),
  TIPOGEST4 VARCHAR2(1),
  TIPOGEST5 VARCHAR2(1),
  TIPOGEST6 VARCHAR2(1),
  TIPOGEST7 VARCHAR2(1),
  TIPOGEST8 VARCHAR2(1),
  TIPOGEST9 VARCHAR2(1),
  TIPOGEST10 VARCHAR2(1),
  TIPOGEST11 VARCHAR2(1),
  TIPOGEST12 VARCHAR2(1)
) 
  TABLESPACE LAVORO;

CREATE TABLE T950_STAMPACARTELLINO (
  CODICE VARCHAR2(5) NOT NULL,
  DESCRIZIONE VARCHAR2(40),
  INTESTAZIONE LONG,
  PRIMARY KEY (CODICE) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

ALTER TABLE T600_SQUADRE ADD DESCRIZIONELUNGA VARCHAR2(80);
ALTER TABLE T600_SQUADRE ADD TOTMIN1 VARCHAR2(3);
ALTER TABLE T600_SQUADRE ADD TOTMAX1 VARCHAR2(3);
ALTER TABLE T600_SQUADRE ADD TOTMIN2 VARCHAR2(3);
ALTER TABLE T600_SQUADRE ADD TOTMAX2 VARCHAR2(3);
ALTER TABLE T600_SQUADRE ADD TOTMIN3 VARCHAR2(3);
ALTER TABLE T600_SQUADRE ADD TOTMAX3 VARCHAR2(3);
ALTER TABLE T600_SQUADRE ADD TOTMIN4 VARCHAR2(3);
ALTER TABLE T600_SQUADRE ADD TOTMAX4 VARCHAR2(3);

CREATE TABLE T601_TIPIOPERATORE(
  SQUADRA VARCHAR2(5) NOT NULL,
  CODICE VARCHAR2(5) NOT NULL,
  MIN1 VARCHAR2(3),MAX1 VARCHAR2(3),
  MIN2 VARCHAR2(3),MAX2 VARCHAR2(3),
  MIN3 VARCHAR2(3),MAX3 VARCHAR2(3),
  MIN4 VARCHAR2(3),MAX4 VARCHAR2(3),
  TURNAZ VARCHAR2(5),
  ORARIO VARCHAR2(5),
  PRIMARY KEY (SQUADRA,CODICE) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

CREATE TABLE T610_CICLI(
  CODICE VARCHAR2(5) NOT NULL,
  DESCRIZIONE VARCHAR2(40),
  PRIMARY KEY (CODICE) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

CREATE TABLE T611_CICLIGIORNALIERI(
  CICLO VARCHAR2(5) NOT NULL,
  GIORNO NUMBER(38,2)NOT NULL,
  TURNO1 VARCHAR2(1),
  TURNO2 VARCHAR2(1),
  ORARIO VARCHAR2(5),
  CAUSALE VARCHAR2(5),
  PRIMARY KEY (CICLO,GIORNO) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

CREATE TABLE T640_TURNAZIONI(
  CODICE VARCHAR2(5) NOT NULL,
  DESCRIZIONE VARCHAR2(40),
  PRIMARY KEY (CODICE) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

CREATE TABLE T641_MOLTTURNAZIONE(
  TURNAZIONE VARCHAR2(5) NOT NULL,
  ORDINE NUMBER(38,2) NOT NULL,
  CICLO1 VARCHAR2(5),
  CICLO2 VARCHAR2(5),
  CICLO3 VARCHAR2(5),
  CICLO4 VARCHAR2(5),
  CICLO5 VARCHAR2(5),
  MULTIPLO NUMBER(38,2),
  PRIMARY KEY (TURNAZIONE,ORDINE) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

CREATE TABLE T620_TURNAZIND(
  PROGRESSIVO NUMBER(38,2) NOT NULL,
  DATA DATE NOT NULL,
  TURNAZIONE VARCHAR2(5) NOT NULL,
  PARTENZA NUMBER(38,2) NOT NULL,
  PRIMARY KEY (PROGRESSIVO,DATA) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

CREATE TABLE T630_SPOSTSQUADRA(
  PROGRESSIVO NUMBER(38,2) NOT NULL,
  DATA DATE NOT NULL,
  SQUADRA VARCHAR2(5) NOT NULL,
  ORARIO VARCHAR2(5),
  TURNO1 VARCHAR2(1),
  TURNO2 VARCHAR2(1),
  PRIMARY KEY (PROGRESSIVO,DATA,SQUADRA) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

CREATE TABLE T081_PROVVISORIO (
  PROGRESSIVO NUMBER(38, 2) NOT NULL,
  DATA DATE NOT NULL,
  ORARIO VARCHAR2(5),
  TURNO1 VARCHAR2(1),
  TURNO2 VARCHAR2(1),
  PRIMARY KEY (PROGRESSIVO,DATA) USING INDEX TABLESPACE INDICI
)
TABLESPACE LAVORO;

CREATE TABLE T041_PROVVISORIO (
  PROGRESSIVO NUMBER(38, 2) NOT NULL,
  DATA DATE NOT NULL,
  CAUSALE VARCHAR2(5) NOT NULL,
  PRIMARY KEY (PROGRESSIVO,DATA,CAUSALE) USING INDEX TABLESPACE INDICI
)
  TABLESPACE LAVORO;
