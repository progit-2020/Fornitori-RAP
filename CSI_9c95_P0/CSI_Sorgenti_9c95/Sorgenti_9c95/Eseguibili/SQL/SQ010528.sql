CREATE TABLE IA004_SEMAFORO (FLAG NUMBER(1)) STORAGE (PCTINCREASE 0 INITIAL 162K NEXT 16K) TABLESPACE LAVORO;
INSERT INTO IA004_SEMAFORO (FLAG) SELECT 0 FROM DUAL WHERE NOT EXISTS (SELECT 'x' FROM IA004_SEMAFORO);

CREATE TABLE IA010_PARAMETRIP00 (
  TIPO VARCHAR2(10),
  AGGIORNAMENTO_DIZIONARIO VARCHAR2(1) DEFAULT 'S',
  SEMAFORO_BLOCCATO VARCHAR2(1) DEFAULT 'S',
  AGGIORNAMENTI_MAX NUMBER(8) DEFAULT -1,
  REGISTRA_OPERAZIONI VARCHAR2(1) DEFAULT 'S'
)
STORAGE (PCTINCREASE 0 INITIAL 16K NEXT 16K)
TABLESPACE LAVORO;

INSERT INTO IA010_PARAMETRIP00 
  (AGGIORNAMENTO_DIZIONARIO,SEMAFORO_BLOCCATO,AGGIORNAMENTI_MAX,REGISTRA_OPERAZIONI)
SELECT 'S','N',-1,'N' FROM DUAL WHERE NOT EXISTS (SELECT 'x' FROM IA010_PARAMETRIP00);

CREATE TABLE IA011_DATIINTEGRATIP00 (
  POS NUMBER(3),
  PRESENZE VARCHAR2(40),
  ESTERNO VARCHAR2(40)
)
STORAGE (PCTINCREASE 0 INITIAL 32K NEXT 32K)
TABLESPACE LAVORO;

CREATE TABLE IA015_REPORTP00 (
  DATA DATE DEFAULT SYSDATE,
  OPERAZIONE VARCHAR2(1),
  MATRICOLA VARCHAR2(8),
  MESSAGGIO VARCHAR2(40),
  ERRORE VARCHAR2(255)
)
STORAGE (PCTINCREASE 0 INITIAL 32K NEXT 512K)
PCTUSED 80
TABLESPACE LAVORO;

CREATE OR REPLACE VIEW V042_PERIODIASSENZA AS
  SELECT 
  T030.MATRICOLA,
  T042.CAUSALE,T042.DAL,T042.AL,T042.TIPOGIUST,T042.DAORE,T042.AORE,T042.DATA_AGG,T042.OPERAZIONE,
  T265.VOCEPAGHE
  FROM T030_ANAGRAFICO T030, T042_PERIODIASSENZA T042, T265_CAUASSENZE T265
  WHERE 
  T030.PROGRESSIVO = T042.PROGRESSIVO AND
  T042.CAUSALE = T265.CODICE AND
  T265.VOCEPAGHE IS NOT NULL;
  
UPDATE T265_CAUASSENZE SET DETREPERIB = 'N' WHERE INFLUCONT IN ('B','D');