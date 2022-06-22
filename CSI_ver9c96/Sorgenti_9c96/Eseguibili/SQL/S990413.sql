ALTER TABLE T190_INTPAGHE ADD P240 VARCHAR2(6);
ALTER TABLE T190_INTPAGHE ADD F240 VARCHAR2(1);
UPDATE T190_INTPAGHE SET F240 = 'N',F180 = 'N';

CREATE TABLE T760_REGOLEINCENTIVI (
  QUALIFICA VARCHAR2(20),
  REPARTO VARCHAR2(20),
  LIVELLO VARCHAR2(20),
  ELENCOLIV VARCHAR2(100),
  ASSENZE VARCHAR2(200),
  VOCEPAGHE VARCHAR2(6))
TABLESPACE LAVORO;

CREATE TABLE T761_INCENTIVI (
  ANNO NUMBER,
  QUALIFICA VARCHAR2(20),
  REPARTO VARCHAR2(20),
  QUOTA NUMBER,
  VOCEPAGHE VARCHAR2(6),
  CONSTRAINT T761_PK PRIMARY KEY (ANNO,QUALIFICA,REPARTO) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;

CREATE TABLE T762_INCENTIVIMATURATI (
  PROGRESSIVO NUMBER,
  ANNO NUMBER,
  MESE NUMBER,
  QUOTA NUMBER,
  VARIAZIONI NUMBER,
  FLAG VARCHAR2(1),
  CONSTRAINT T762_PK PRIMARY KEY (PROGRESSIVO,ANNO,MESE) USING INDEX TABLESPACE INDICI)
TABLESPACE LAVORO;