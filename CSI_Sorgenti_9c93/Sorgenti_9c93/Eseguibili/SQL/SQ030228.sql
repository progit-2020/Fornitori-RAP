-- INTEGRAZIONE ANAGRAFICA --

ALTER TABLE MONDOEDP.I090_ENTI ADD CODICE_INTEGRAZIONE VARCHAR2(30);

CREATE TABLE MONDOEDP.IA100_STRUTTUREINPUT (
  NOME_STRUTTURA VARCHAR2(200),
  TIPO_STRUTTURA VARCHAR2(1),
  NOME_FILE VARCHAR2(200),
  FTP_HOST VARCHAR2(20),
  FTP_USER VARCHAR2(20),
  FTP_PASSWORD VARCHAR2(20),
  FTP_PORT NUMBER(8) DEFAULT 21,
  LOG_ERRORE VARCHAR2(1) DEFAULT 'S',
  LOG_ESEGUITO VARCHAR2(1) DEFAULT 'N',
  RESET_DATI VARCHAR2(1) DEFAULT 'N',
  CANCELLAZIONE VARCHAR2(1) DEFAULT 'S',
  B014PERSONALIZZATA VARCHAR2(1) DEFAULT 'N'
)
STORAGE (INITIAL 32K NEXT 32K PCTINCREASE 0)
PCTFREE 10 PCTUSED 70 TABLESPACE LAVORO;

ALTER TABLE MONDOEDP.IA100_STRUTTUREINPUT ADD CONSTRAINT IA100_PK PRIMARY KEY (NOME_STRUTTURA)
USING INDEX STORAGE (INITIAL 32K NEXT 32K PCTINCREASE 0) TABLESPACE INDICI;
    
CREATE TABLE MONDOEDP.IA110_DETTAGLIODATI (
  NOME_STRUTTURA VARCHAR2(200),
  AZIENDA VARCHAR2(30) DEFAULT '*',
  INTESTAZIONE VARCHAR2(40),
  TABELLA VARCHAR2(80),
  CAMPO VARCHAR2(80),
  POS_DATO NUMBER(4),
  LUNG_DATO NUMBER(4),
  NOME_DATO VARCHAR2(40) NOT NULL,
  TIPO_DATO VARCHAR2(1) DEFAULT 'A',
  FMT_DATA VARCHAR2(20),
  STORICO VARCHAR2(1) DEFAULT 'N',
  VIRTUALE VARCHAR2(1) DEFAULT 'N'
)
STORAGE (INITIAL 32K NEXT 64K PCTINCREASE 0)
PCTFREE 10 PCTUSED 70 TABLESPACE LAVORO;

CREATE TABLE MONDOEDP.IA000_LOGINTEGRAZIONE (
  DATA_ELABORAZIONE DATE,
  STRUTTURA VARCHAR2(200),
  AZIENDA VARCHAR2(30),
  ENTE VARCHAR2(30),
  DATA_REGISTRAZIONE DATE,
  ID NUMBER,
  UTENTE VARCHAR2(30),
  CHIAVE VARCHAR2(80),
  DECORRENZA DATE,
  SCADENZA DATE,
  STATO VARCHAR2(1),
  DATO VARCHAR2(80),
  VALORE VARCHAR2(500),
  MESSAGGIO VARCHAR2(500),
  TESTO_SQL VARCHAR2(1000)
)
STORAGE (INITIAL 32K NEXT 2M PCTINCREASE 0)
PCTFREE 10 PCTUSED 80 TABLESPACE LAVORO;

CREATE TABLE MONDOEDP.IA190_SCHEDULAZIONE (
  ORA VARCHAR2(5),
  STRUTTURE VARCHAR2(2000)
)
STORAGE (INITIAL 32K NEXT 32K PCTINCREASE 0)
PCTFREE 10 PCTUSED 50 TABLESPACE LAVORO;

INSERT INTO MONDOEDP.IA100_STRUTTUREINPUT 
  (NOME_STRUTTURA, TIPO_STRUTTURA, NOME_FILE, 
   FTP_HOST, FTP_USER, FTP_PASSWORD, FTP_PORT, 
   LOG_ERRORE, CANCELLAZIONE, B014PERSONALIZZATA)
SELECT
  'IA_PAGHE','F',FILEIN,
  IPADDRESS,USERID,PASSWORD,PORTA,
  'S','S','S' 
FROM IA001_PARAMETRI;

INSERT INTO MONDOEDP.IA110_DETTAGLIODATI
  (NOME_STRUTTURA,AZIENDA,INTESTAZIONE,
   TABELLA,CAMPO,POS_DATO,LUNG_DATO,NOME_DATO,
   VIRTUALE,TIPO_DATO,FMT_DATA,
   STORICO)
SELECT 
  'IA_PAGHE','*',NULL,
  GPC_CDTAB,GPC_CDINT,NULL,NULL,GPC_TPREC,
  DECODE(GPC_CDINT,'INIZIO','S','FINE','S','N'),GPC_TPCHR,DECODE(GPC_TPCHR,'D','YYYYMMDD',NULL),
  GPC_STORIA
FROM IA002_DETTAGLIODATI
WHERE GPC_TPREC NOT IN ('GPA-CODI','GPA-CRMA') AND 
      GPC_AGGIN = '1' AND GPC_AGGOU = '0';

INSERT INTO MONDOEDP.IA110_DETTAGLIODATI
  (NOME_STRUTTURA,AZIENDA,INTESTAZIONE,TABELLA,CAMPO,POS_DATO,LUNG_DATO,NOME_DATO,
   VIRTUALE,TIPO_DATO,FMT_DATA,STORICO)
SELECT 'IA_PAGHE','*','CHIAVE','T030_ANAGRAFICO','MATRICOLA',21,8,'CHIAVE','N','N',NULL,'N'
FROM IA001_PARAMETRI
UNION
SELECT 'IA_PAGHE','*','DATA',NULL,NULL,124,12,'DATA_AGG','N','D','YYYYMMDDHHNN','N'
FROM IA001_PARAMETRI
UNION
SELECT 'IA_PAGHE','*','UTENTE',NULL,NULL,136,6,'UTENTE','N','A',NULL,'N'
FROM IA001_PARAMETRI
UNION
SELECT 'IA_PAGHE','*','SEQUENZA',NULL,NULL,0,20,'ID','N','A',NULL,'N'
FROM IA001_PARAMETRI
UNION
SELECT 'IA_PAGHE','*','DECORRENZA',NULL,NULL,101,8,'DECORRENZA','N','D','YYYYMMDD','N'
FROM IA001_PARAMETRI
UNION
SELECT 'IA_PAGHE','*','SCADENZA',NULL,NULL,109,8,'SCADENZA','N','D','YYYYMMDD','N'
FROM IA001_PARAMETRI
UNION
SELECT 'IA_PAGHE','*','DATO',NULL,NULL,1,10,'NOME_DATO','N','A',NULL,'N'
FROM IA001_PARAMETRI
UNION
SELECT 'IA_PAGHE','*','VALORE',NULL,NULL,41,60,'VALORE','N','A',NULL,'N'
FROM IA001_PARAMETRI;

RENAME IA100_STRUTTUREINPUT TO IA100_STRUTTUREDATI;
ALTER TABLE MONDOEDP.IA100_STRUTTUREDATI ADD DIREZIONE_DATI VARCHAR2(1) DEFAULT 'I';
ALTER TABLE MONDOEDP.IA110_DETTAGLIODATI ADD VIRTUALE VARCHAR2(1) DEFAULT 'N';

UPDATE MONDOEDP.IA110_DETTAGLIODATI SET VIRTUALE = DECODE(TIPO_FLUSSO,'V','S','N');

CREATE TABLE MONDOEDP.IA120_DATIOUTPUT(
  AZIENDA VARCHAR2(40),
  TABELLA VARCHAR2(80), 
  ID_DATO VARCHAR2(200), 
  DATA_REGISTRAZIONE DATE, 
  ID NUMBER,
  OS_USER VARCHAR2(80),
  MACHINE_USER VARCHAR2(80),
  USERNAME VARCHAR2(80)
)
STORAGE (INITIAL 32K NEXT 256K PCTINCREASE 0)
PCTFREE 10 PCTUSED 80 TABLESPACE LAVORO;

ALTER TABLE MONDOEDP.IA120_DATIOUTPUT ADD CONSTRAINT IA120_PK PRIMARY KEY (AZIENDA,TABELLA,ID_DATO)
USING INDEX TABLESPACE INDICI STORAGE (INITIAL 32K NEXT 128K PCTINCREASE 0);

create sequence MONDOEDP.IA120_ID
minvalue 0
start with 0
increment by 1;

CREATE TABLE MONDOEDP.IA130_TRIGGEROUTPUT(
  AZIENDA VARCHAR2(40),
  TABELLA VARCHAR2(80), 
  TRIGGER_TEXT VARCHAR2(2000) 
)
STORAGE (INITIAL 32K NEXT 64K PCTINCREASE 0)
PCTFREE 10 PCTUSED 60 TABLESPACE LAVORO;

ALTER TABLE MONDOEDP.IA130_TRIGGEROUTPUT ADD CONSTRAINT IA130_PK PRIMARY KEY (AZIENDA,TABELLA)
USING INDEX TABLESPACE INDICI STORAGE (INITIAL 32K NEXT 32K PCTINCREASE 0);