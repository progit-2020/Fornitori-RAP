UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.5.9' WHERE AZIENDA = :AZIENDA;

-- Create table
create table SG110_CURRICULUM
(
  PROGRESSIVO        NUMBER(38,2) not null,
  DATA_REGISTRAZIONE DATE not null,
  TIPOESPERIENZA     VARCHAR2(20) not null,
  DETTAGLIOESPERIENZA VARCHAR2(20) not null,
  INCLUDI_STAMPA     VARCHAR2(1) not null,
  LUOGO_ESPERIENZA   VARCHAR2(200) not null,
  INIZIO_ESPERIENZA  DATE not null,
  FINE_ESPERIENZA    DATE not null,
  DESCRIZIONE        VARCHAR2(1000),
  ORIGINE            VARCHAR2(1) default 'O' not null,
  STATO              VARCHAR2(1) default 'I' not null
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 32K
    next 256K
    minextents 1
  );
-- Add comments to the columns 
comment on column SG110_CURRICULUM.PROGRESSIVO
  is 'Progressivo del dipendente';
comment on column SG110_CURRICULUM.DATA_REGISTRAZIONE
  is 'Data di registrazione del record';
comment on column SG110_CURRICULUM.TIPOESPERIENZA
  is 'Codice della tipologia di esperienza';
comment on column SG110_CURRICULUM.DETTAGLIOESPERIENZA
  is 'Codice del dettaglio tipologia esperienza';
comment on column SG110_CURRICULUM.INCLUDI_STAMPA
  is 'Se S il record viene visualizzato in stampa';
comment on column SG110_CURRICULUM.LUOGO_ESPERIENZA
  is 'Luogo dell''esperienza curricolare';
comment on column SG110_CURRICULUM.INIZIO_ESPERIENZA
  is 'Data di inizio esperienza';
comment on column SG110_CURRICULUM.FINE_ESPERIENZA
  is 'Data di fine esperienza';
comment on column SG110_CURRICULUM.DESCRIZIONE
  is 'Descrizione esperienza';
comment on column SG110_CURRICULUM.ORIGINE
  is 'Indica se il record è stato inserito dal web e quindi dal dipendente(D) o dagli operatori dello stato giuridico(O)';
comment on column SG110_CURRICULUM.STATO
  is 'Indica se il record inserito online è stato validato dagli operatori oppure no e assume i seguenti valori R(Richiesta dal Web), I(Inserito dal programma), C(Cancellato logicamente dal programma)';

-- Create/Recreate primary, unique and foreign key constraints 
alter table SG110_CURRICULUM
  add constraint SG110_PK primary key (PROGRESSIVO,DATA_REGISTRAZIONE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 32K
    next 128K
    minextents 1
  );

-- Aggiornamento tabella ECM 
alter table SG651_PIANIFICAZIONECORSI add ORIGINE varchar2(1) default 'O' not null;
-- Aggiunta commento alla tabella ECM 
comment on column SG651_PIANIFICAZIONECORSI.ORIGINE
  is 'Indica se il record è stato inserito dal web e quindi dal dipendente(D) o dagli operatori dello stato giuridico(O)';
-- Add/modify columns 
alter table SG651_PIANIFICAZIONECORSI add STATO varchar2(1) default 'I' not null;
-- Add comments to the columns 
comment on column SG651_PIANIFICAZIONECORSI.STATO
  is 'Indica se il record inserito online è stato validato dagli operatori oppure no e assume i seguenti valori R(Richiesta dal Web), I(Inserito dal programma), C(Cancellato logicamente dal programma)';

-- Create table
create table SG111_TIPOESPERIENZE
(
  CODICE      VARCHAR2(20) not null,
  DESCRIZIONE VARCHAR2(100),
  POSIZIONE   NUMBER
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 128K
    minextents 1
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG111_TIPOESPERIENZE
  add constraint SG111_PK primary key (CODICE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    next 32K
    minextents 1
  );
-- Add comments to the columns 
comment on column SG111_TIPOESPERIENZE.CODICE
  is 'Codice tipo esperienza';
comment on column SG111_TIPOESPERIENZE.DESCRIZIONE
  is 'Descrizione tipo esperienza';
comment on column SG111_TIPOESPERIENZE.POSIZIONE
  is 'Posizione tipo esperienza nella stampa del curriculum';

-- Create table
create table SG112_DETTAGLIOESPERIENZE
( 
  TIPOESPERIENZA  VARCHAR2(20) not null,
  CODICE          VARCHAR2(20) not null,
  DESCRIZIONE     VARCHAR2(100),
  POSIZIONE       NUMBER
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 128K
    minextents 1
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG112_DETTAGLIOESPERIENZE
  add constraint SG112_PK primary key (TIPOESPERIENZA,CODICE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    next 32K
    minextents 1
  );
-- Add comments to the columns 
comment on column SG112_DETTAGLIOESPERIENZE.TIPOESPERIENZA
  is 'Codice tipo esperienza';
comment on column SG112_DETTAGLIOESPERIENZE.CODICE
  is 'Codice dettaglio esperienza';
comment on column SG112_DETTAGLIOESPERIENZE.DESCRIZIONE
  is 'Descrizione dettaglio esperienza';
comment on column SG112_DETTAGLIOESPERIENZE.POSIZIONE
  is 'Posizione dettaglio esperienza nella stampa del curriculum';

create table SG113_PREFERENZE 
(
  PROGRESSIVO            NUMBER not null,
  DATA_REGISTRAZIONE     DATE not null,
  PREFERENZA_COMPETENZA  VARCHAR2(80),
  PREFERENZA_DESTINAZIONE  VARCHAR2(80)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 128K
    minextents 1
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG113_PREFERENZE 
  add constraint SG113_PK primary key (PROGRESSIVO,DATA_REGISTRAZIONE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    next 128K
    minextents 1
  );
-- Add comments to the columns 
comment on column SG113_PREFERENZE.PROGRESSIVO
  is 'Progressivo dipendente';
comment on column SG113_PREFERENZE.DATA_REGISTRAZIONE
  is 'Data di registrazione del record';
comment on column SG113_PREFERENZE.PREFERENZA_COMPETENZA
  is 'Dato libero che indica la competenza (profilo o qualifica) che il dipendente vorrebbe acquisire o a cui aspira';
comment on column SG113_PREFERENZE.PREFERENZA_DESTINAZIONE
  is 'Dato libero che indica la destinazione (reparto o altro dato libero) a cui il dipendente vorrebbe essere assegnato';


--Aggiunta delle righe nella tabella degli enti
INSERT INTO MONDOEDP.I091_DATIENTE (SELECT AZIENDA,'C12_PREFERENZADEST', NULL FROM I090_ENTI);
--Aggiunta delle righe nella tabella degli enti
INSERT INTO MONDOEDP.I091_DATIENTE (SELECT AZIENDA,'C12_PREFERENZECOMP', NULL FROM I090_ENTI);


DROP TABLE P272_RETRIBUZIONE_CONTRATTUALE;
/*
Storico retribuzione contrattuale del dipendente
Integrità referenziali: T030_ANAGRAFICO
*/
CREATE TABLE P272_RETRIBUZIONE_CONTRATTUALE (
  PROGRESSIVO NUMBER,
  COD_CONTRATTO VARCHAR2(5),
  COD_VOCE VARCHAR2(5),
  COD_VOCE_SPECIALE VARCHAR2(5),
  DECORRENZA_INIZIO DATE,
  DECORRENZA_FINE DATE,
  IMPORTO NUMBER,
  IMPORTO_INTERO NUMBER,
  ORIGINE VARCHAR2(1) NOT NULL,
  STATO VARCHAR2(1) DEFAULT 'A' NOT NULL,
  CONSTRAINT P272_PK PRIMARY KEY (PROGRESSIVO,COD_CONTRATTO,COD_VOCE,COD_VOCE_SPECIALE,DECORRENZA_INIZIO)
  USING INDEX STORAGE (pctincrease 0 initial 32K next 512K)
  TABLESPACE INDICI pctfree 10
)
STORAGE (pctincrease 0 initial 32K next 512K)
TABLESPACE LAVORO pctfree 10 pctused 40;

COMMENT ON COLUMN P272_RETRIBUZIONE_CONTRATTUALE.IMPORTO IS
  'Importo della voce gia'' ridotto per Part-time';
COMMENT ON COLUMN P272_RETRIBUZIONE_CONTRATTUALE.IMPORTO_INTERO IS
  'Importo della voce prima della riduzione per Part-time';
COMMENT ON COLUMN P272_RETRIBUZIONE_CONTRATTUALE.ORIGINE IS
  'Origine della voce: R=da Recupero dati, C=da Calcolo';
COMMENT ON COLUMN P272_RETRIBUZIONE_CONTRATTUALE.STATO IS
  'Stato della voce: A=Aggiornabile, B=Bloccata';

ALTER TABLE P272_RETRIBUZIONE_CONTRATTUALE ADD CONSTRAINT P272_FK_T030
  FOREIGN KEY (PROGRESSIVO) REFERENCES T030_ANAGRAFICO;

COMMENT ON COLUMN P442_CEDOLINOVOCI.ORIGINE IS
  'Origine della voce: I=Voce iniziale (es. Straordinario), A=Voce di Assenza (per entrambi i tipi gli importi possono essere calcolati dal precalcolo), P=Voce creata in fase di precalcolo (es. Stipendio); C=Voce creata in fase di calcolo (es. ritenute, detr.coniuge a carico autom.)';
  
ALTER TABLE T021_FASCEORARI ADD ORETEOTUR2 VARCHAR2(5);
  
ALTER TABLE T025_CONTMENSILI ADD ARR_SOGLIA_COMP_LIQ VARCHAR2(5);

CREATE TABLE P254_558 AS select * from p254_vociprogrammate;
DROP TABLE P254_VOCIPROGRAMMATE;
create table P254_VOCIPROGRAMMATE
(
  PROGRESSIVO       NUMBER not null,
  COD_CONTRATTO     VARCHAR2(5) not null,
  COD_VOCE          VARCHAR2(5) not null,
  COD_VOCE_SPECIALE VARCHAR2(5) not null,
  DATA_INIZIO       DATE not null,
  DATA_FINE         DATE,
  ID_VOCE_PROGRAMMATA NUMBER not null,
  ATTIVA            VARCHAR2(1) default 'S',
  SALDATA           VARCHAR2(1) default 'N',
  IMPORTO_TOTALE    NUMBER default 0 not null,
  CESSIONE_QUINTO   VARCHAR2(1) default 'N',
  IMPORTO_RATA      NUMBER default 0 not null,
  PERIODICITA_RATA  NUMBER(2) default 1 not null,
  IMPORTO_PAGATO    NUMBER default 0
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage (initial 32K  next 512K minextents 1);

-- Add comments to the columns 
comment on column P254_VOCIPROGRAMMATE.DATA_FINE
  is 'Data di scadenza non obbligatoria';
comment on column P254_VOCIPROGRAMMATE.ATTIVA
  is 'Attiva (S/N) indica se la voce programmata deve entrare nel conteggio del mese';
comment on column P254_VOCIPROGRAMMATE.SALDATA
  is 'Saldata (S/N) indica se la voce programmata è stata saldata';
comment on column P254_VOCIPROGRAMMATE.IMPORTO_TOTALE
  is 'Importo totale (=0 per voci fisse senza totali da scalare)';
comment on column P254_VOCIPROGRAMMATE.CESSIONE_QUINTO
  is 'Cessione del quinto (S/N). Se S non si richiedono i dati successivi';
comment on column P254_VOCIPROGRAMMATE.PERIODICITA_RATA
  is 'Numero mesi di differenza tra ogni rata';
comment on column P254_VOCIPROGRAMMATE.IMPORTO_PAGATO
  is 'Importo gia'' pagato da detrarre dall''importo totale';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P254_VOCIPROGRAMMATE
  add constraint P254_PK primary key (ID_VOCE_PROGRAMMATA)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage (initial 32K  next 512K minextents 1);

ALTER TABLE P254_VOCIPROGRAMMATE ADD CONSTRAINT P254_FK_T030
  FOREIGN KEY (PROGRESSIVO) REFERENCES T030_ANAGRAFICO;
-- Create sequence 
create sequence P254_ID_VOCE_PROGRAMMATA
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;
DECLARE
  CURSOR C1 IS SELECT * FROM P254_558;
  Id_Voce_prog Number;
BEGIN
  FOR T1 IN C1 LOOP
    SELECT P254_ID_VOCE_PROGRAMMATA.NEXTVAL INTO Id_Voce_prog FROM DUAL;
    INSERT INTO P254_VOCIPROGRAMMATE 
      (progressivo,cod_contratto,cod_voce,cod_voce_speciale,data_inizio,data_fine,
       id_voce_programmata,attiva,saldata,importo_totale,cessione_quinto,importo_rata,
       periodicita_rata,importo_pagato)
    VALUES
      (t1.progressivo,t1.cod_contratto,t1.cod_voce,t1.cod_voce_speciale,t1.data_inizio,t1.data_fine,
       Id_Voce_prog,t1.attiva,t1.saldata,t1.importo_totale,t1.cessione_quinto,t1.importo_rata,
       t1.periodicita_rata,t1.importo_detr);
  END LOOP;     
END;
/
ALTER TABLE P442_CEDOLINOVOCI ADD ID_VOCE_PROGRAMMATA NUMBER;
DECLARE
  CURSOR C1 IS SELECT P442.ROWID,PROGRESSIVO,COD_CONTRATTO,COD_VOCE,COD_VOCE_SPECIALE,DATA_RETRIBUZIONE 
    FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO;
  Id_Voce_prog Number;
BEGIN
  FOR T1 IN C1 LOOP
    UPDATE P442_CEDOLINOVOCI P442 SET ID_VOCE_PROGRAMMATA = 
      (SELECT ID_VOCE_PROGRAMMATA FROM P254_VOCIPROGRAMMATE P254
      WHERE T1.PROGRESSIVO = P254.PROGRESSIVO AND T1.COD_CONTRATTO = P254.COD_CONTRATTO 
        AND T1.COD_VOCE = P254.COD_VOCE AND  T1.COD_VOCE_SPECIALE = P254.COD_VOCE_SPECIALE 
        AND P254.DATA_INIZIO = 
        (SELECT MAX(DATA_INIZIO) FROM 
        P254_VOCIPROGRAMMATE P254A WHERE P254A.PROGRESSIVO = P254.PROGRESSIVO AND P254A.COD_CONTRATTO = P254.COD_CONTRATTO AND P254A.COD_VOCE = P254.COD_VOCE AND 
        P254A.COD_VOCE_SPECIALE = P254.COD_VOCE_SPECIALE AND P254A.DATA_INIZIO <= T1.DATA_RETRIBUZIONE
        )
      )
    WHERE ROWID = T1.ROWID; 
  END LOOP;     
END;
/
ALTER TABLE P232_SCAGLIONI ADD MENSILITA_ANNUE NUMBER;
comment on column P232_SCAGLIONI.MENSILITA_ANNUE
  is 'Numero mensilita'' annue';
-- Create/Recreate indexes 
create index P254_PROG_COD_VOCE on P254_VOCIPROGRAMMATE (PROGRESSIVO,COD_CONTRATTO,COD_VOCE,COD_VOCE_SPECIALE,DATA_INIZIO)
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage (initial 32K next 512K minextents 1);
-- Create/Recreate indexes 
create index P441_PROG_DATA_CEDOLINO on P441_CEDOLINO (PROGRESSIVO,DATA_CEDOLINO)
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage (initial 32K next 1M minextents 1);
-- Create/Recreate indexes 
create index P442_ID_CEDOLINO on P442_CEDOLINOVOCI (ID_CEDOLINO)
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage (initial 32K next 2M minextents 1);
create index P442_ID_VOCE_PROGRAMMATA on P442_CEDOLINOVOCI (ID_VOCE_PROGRAMMATA)
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage (initial 32K  next 2M minextents 1);

alter table t025_contmensili add riposo_nonfruito varchar2(5);

ALTER TABLE P500_CUDSETUP ADD COD_SIA VARCHAR2(5);
ALTER TABLE P500_CUDSETUP ADD COD_ABI VARCHAR2(5);
ALTER TABLE P500_CUDSETUP ADD COD_CAB VARCHAR2(5);
ALTER TABLE P500_CUDSETUP ADD CONTO_CORRENTE VARCHAR2(13);
comment on column P500_CUDSETUP.COD_SIA
  is 'Codice dell''impresa mittente assegnato dalla SIA';
comment on column P500_CUDSETUP.COD_ABI
  is 'Codice ABI della banca ordinante le disposizioni di pagamento';
comment on column P500_CUDSETUP.COD_CAB
  is 'Codice CAB della banca ordinante le disposizioni di pagamento';
comment on column P500_CUDSETUP.CONTO_CORRENTE
  is 'Numero conto corrente della banca ordinante le disposizioni di pagamento';

ALTER TABLE T050_RICHIESTEASSENZA ADD NOTE1 VARCHAR2(1000);
comment on column T050_RICHIESTEASSENZA.NOTE1 is 'Note Richiesta';
ALTER TABLE T050_RICHIESTEASSENZA ADD NOTE2 VARCHAR2(1000);
comment on column T050_RICHIESTEASSENZA.NOTE2 is 'Note Autorizzazione';
ALTER TABLE T050_RICHIESTEASSENZA ADD AORE VARCHAR2(5); 

ALTER TABLE T280_MESSAGGIWEB ADD LOG VARCHAR2(2000);
