ALTER TABLE T670_REGOLEBUONI ADD FORZAMATURAZIONE VARCHAR2(120);
ALTER TABLE T670_REGOLEBUONI ADD INIBMATURAZIONE VARCHAR2(120);

CREATE TABLE T910_RIEPILOGO (
  CODICE VARCHAR2 (10),
  TITOLO VARCHAR2(80),
  TIPO VARCHAR2 (1),
  SEPARAH VARCHAR2(1),
  SEPARAV VARCHAR2(1),
  TOTALI VARCHAR2(1),
  FONTNAME VARCHAR2(30),
  FONTSIZE NUMBER(2),
  SALTOPAGINA VARCHAR2(1),
  ASSENZE VARCHAR2(255),
  FILTRO LONG,
  CONSTRAINT T910_PK PRIMARY KEY (CODICE) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

CREATE TABLE T911_DATIRIEPILOGO (
  CODICE VARCHAR2 (10),
  NOME VARCHAR2(40),
  CAPTION VARCHAR2(40),
  BANDA VARCHAR2(1),
  TOTALE VARCHAR2(1),
  POST NUMBER(8),
  POSL NUMBER(8),
  LUNG NUMBER(8),
  ALT NUMBER(8),
  CONSTRAINT T911_PK PRIMARY KEY (CODICE,NOME) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

CREATE TABLE T912_SORTRIEPILOGO (
  CODICE VARCHAR2 (10),
  POS NUMBER(2),
  NOME VARCHAR2(40),
  TIPO VARCHAR2(1),
  ROTTKEY VARCHAR2(1),
  CONSTRAINT T912_PK PRIMARY KEY (CODICE,POS) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;
