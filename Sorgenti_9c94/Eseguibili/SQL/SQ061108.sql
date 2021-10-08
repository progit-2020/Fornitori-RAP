UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '6.0.8',PATCHDB = 0 WHERE AZIENDA = :AZIENDA;

drop table I070_OPERATORI;
drop table I071_INIBIZIONI;
drop table I72_INIBFUNZ;

create table T100_SALVA_CAMBIOORA
(
  PROGRESSIVO NUMBER(38,2) not null,
  DATA        DATE not null,
  ORA         DATE not null,
  VERSO       VARCHAR2(1) not null,
  FLAG        VARCHAR2(1) not null,
  RILEVATORE  VARCHAR2(2),
  CAUSALE     VARCHAR2(5),
  ID_RIGA VARCHAR2(40)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

create table SG103_TIPODOCUMENTI
(
  CODICE      VARCHAR2(5) not null,
  DESCRIZIONE VARCHAR2(40)
)
tablespace LAVORO
  storage
  (initial 256K next 256K pctincrease 0);

alter table SG103_TIPODOCUMENTI
  add constraint SG103_PK primary key (CODICE)
  using index 
  tablespace INDICI
  storage
  (initial 256K next 256K pctincrease 0);

create table SG104_TIPOMOTIVAZIONI
(
  CODICE      VARCHAR2(5) not null,
  DESCRIZIONE VARCHAR2(40)
)
tablespace LAVORO
  storage
   (initial 256K next 256K pctincrease 0);

alter table SG104_TIPOMOTIVAZIONI
  add constraint SG104_PK primary key (CODICE)
  using index 
  tablespace INDICI
  storage
  (initial 256K next 256K pctincrease 0);

comment on column P430_ANAGRAFICO.DETRAZ_REDDITI_MIN_INDET
  is 'Detrazione minima annuale garantita per contratto a tempo indeterminato';
comment on column P430_ANAGRAFICO.DETRAZ_REDDITI_MIN_DET
  is 'Detrazione minima annuale garantita per contratto a tempo determinato';

ALTER TABLE P660_FLUSSIREGOLE MODIFY REGOLA_CALCOLO_MANUALE VARCHAR2(3000);
ALTER TABLE P660_FLUSSIREGOLE MODIFY REGOLA_CALCOLO_AUTOMATICA VARCHAR2(3000);

-- Add/modify columns 
alter table M010_PARAMETRICONTEGGIO add DATARIF_VOCEPAGHE varchar2(1) default 'S';
-- Add comments to the columns 
comment on column M010_PARAMETRICONTEGGIO.DATARIF_VOCEPAGHE
  is 'S=Data Scarico - M=Data Missione';

-- Add/modify columns 
alter table MONDOEDP.I090_ENTI add PATHALLCLIENT varchar2(200);
-- Add comments to the columns 
comment on column MONDOEDP.I090_ENTI.PATHALLCLIENT
  is 'Path B011AllineamentoServer.exe';

drop procedure REGISTRAVOCIVARIABILI;

update mondoedp.t035_progressivo set properatori = (select max(progressivo) from mondoedp.i070_utenti);

alter table M010_PARAMETRICONTEGGIO add DATARIF_VOCEPAGHE varchar2(1) default 'S';
comment on column M010_PARAMETRICONTEGGIO.DATARIF_VOCEPAGHE is 'S=Data Scarico - M=Data Missione'; 

alter table SG665_ENTECORSI add RAGGRUPPAMENTO varchar2(5);
comment on column SG665_ENTECORSI.RAGGRUPPAMENTO is 'Ente-Università-Privati-ecc';

create table SG667_RAGGRENTE 
(CODICE varchar2(5),
 DESCRIZIONE varchar2(40)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG667_RAGGRENTE add constraint SG667_PK primary key (CODICE) 
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

UPDATE MONDOEDP.I073_FILTROFUNZIONI I073
SET INIBIZIONE = 'S'
WHERE APPLICAZIONE = 'STAGIU' AND TAG IN (322,323,312)
AND EXISTS (SELECT * FROM MONDOEDP.I073_FILTROFUNZIONI 
                       WHERE PROFILO = I073.PROFILO 
                            AND APPLICAZIONE = I073.APPLICAZIONE 
                            AND TAG = 312 AND INIBIZIONE = 'S');

UPDATE I000_LOGINFO SET MASCHERA = 'S201' WHERE MASCHERA = 'S653';

ALTER TABLE P502_CUDREGOLE MODIFY NUMERO VARCHAR2(4);
ALTER TABLE P505_CUDDATI MODIFY NUMERO VARCHAR2(4);
ALTER TABLE P602_770REGOLE MODIFY (NUMERO VARCHAR2(4),NUMERO_CUD VARCHAR2(4));
ALTER TABLE P605_770DATIINDIVIDUALI MODIFY NUMERO VARCHAR2(4);

create table T691_MAGAZZINOBUONI (
  DATA_ACQUISTO date,
  DATA_SCADENZA date,
  BUONIPASTO number(8),
  TICKET number(8)
) 
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
  
alter table T691_MAGAZZINOBUONI add constraint T691_PK primary key (DATA_ACQUISTO) 
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T690_ACQUISTOBUONI add DATA_SCADENZA date;

alter table T360_TERMENSA add CODICE varchar2(20);
update T360_TERMENSA set CODICE = '<UNICA>';
alter table T360_TERMENSA add constraint T360_PK primary key (CODICE) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T360_TERMENSA add ALIMENTA_BUONIPASTO varchar2(1) default 'N';
alter table T360_TERMENSA add MATURA_BUONO varchar2(1) default 'N';
alter table T360_TERMENSA add MATURA_BUONO_INTERO varchar2(1) default 'N';
alter table T360_TERMENSA modify MENSA_STIMBRATA_INTERO default 'N';
alter table T360_TERMENSA modify MENSA_NON_STIMBRATA_INTERO default 'N';
alter table T360_TERMENSA modify TIMBANTECENTRATA_INTERO default 'N';
alter table T360_TERMENSA modify TIMBDOPOUSCITA_INTERO default 'N';
alter table T360_TERMENSA modify CONTROLLOPRESENZA_INTERO default 'N';
alter table T360_TERMENSA modify ORARIOSPEZZATO_INTERO default 'N';
alter table T360_TERMENSA modify PAUSAMENSAGESTITA_INTERO default 'N';
alter table T360_TERMENSA modify PRESENZAMINIMA_INTERO default 'N';
alter table T360_TERMENSA modify INTERVALLO_INTERO default 'N';
alter table T360_TERMENSA modify ORE_MINIME_INTERO default 'N';
alter table T360_TERMENSA modify NUMTIMBPASTO default '1';
alter table T360_TERMENSA modify CONTROLLOPRESENZA default 'S';
alter table T360_TERMENSA modify MENSA_STIMBRATA default 'N';
alter table T360_TERMENSA modify MENSA_NON_STIMBRATA default 'N';
alter table T360_TERMENSA modify TIMBDOPOUSCITA default 'N';
alter table T360_TERMENSA modify TIMBANTECENTRATA default 'N';
alter table T360_TERMENSA modify CAUSALE default 'N';
alter table T360_TERMENSA modify PAUSAMENSAGESTITA default 'N';
alter table T360_TERMENSA modify PRESENZAMINIMA default 'N';
alter table T360_TERMENSA modify ORARIOSPEZZATO default 'N';
alter table T360_TERMENSA modify INTERVALLO default '00.00';

alter table T360_TERMENSA add MENSA_DALLE varchar2(5) default '00.00';
alter table T360_TERMENSA add MENSA_ALLE varchar2(5) default '23.59';
alter table T360_TERMENSA add INTERVALLO_PM_INTERO varchar2(1) default 'N';

alter table T670_REGOLEBUONI add OREMIN_NETTOPM varchar2(1) default 'N';
alter table T670_REGOLEBUONI add INIZIO_POMERIGGIO varchar2(5) default '00.00';

alter table T025_CONTMENSILI add ABBATT_RIF_LIQUIDABILE varchar2(1) default 'S';
alter table T025_CONTMENSILI add ABBATT_RIF_COMPENSABILE varchar2(1) default 'S';

alter table MONDOEDP.I100_PARSCARICO add FUNZIONE varchar2(1) default 'E';
comment on column MONDOEDP.I100_PARSCARICO.FUNZIONE is 'E=Entrambi - P=Presenza - M=Mensa';
alter table MONDOEDP.I101_TIMBIRREGOLARI add FUNZIONE varchar2(1) default 'E';
comment on column MONDOEDP.I101_TIMBIRREGOLARI.FUNZIONE is 'E=Entrambi - P=Presenza - M=Mensa';

alter table T275_CAUPRESENZE add GETTONE_DALLE varchar2(5) default '00.00';
alter table T275_CAUPRESENZE add GETTONE_ALLE varchar2(5) default '00.00';

ALTER TABLE P258_ADDIZIONALIIRPEF ADD IMPONIBILE NUMBER DEFAULT 0 NOT NULL;
COMMENT ON COLUMN P258_ADDIZIONALIIRPEF.IMPONIBILE IS 'Reddito imponibile';
UPDATE P258_ADDIZIONALIIRPEF SET IMPONIBILE=0 WHERE IMPONIBILE IS NULL;
ALTER TABLE P258_ADDIZIONALIIRPEF ADD IMPONIBILE_CALCOLATO NUMBER DEFAULT 0 NOT NULL;
COMMENT ON COLUMN P258_ADDIZIONALIIRPEF.IMPONIBILE_CALCOLATO IS 'Reddito imponibile calcolato dal cedolino aperto';
UPDATE P258_ADDIZIONALIIRPEF SET IMPONIBILE_CALCOLATO=0 WHERE IMPONIBILE_CALCOLATO IS NULL;
ALTER TABLE P258_ADDIZIONALIIRPEF ADD MESE_INIZIALE NUMBER(2);
COMMENT ON COLUMN P258_ADDIZIONALIIRPEF.MESE_INIZIALE IS 'Mese iniziale della rateizzazione';
UPDATE P258_ADDIZIONALIIRPEF SET MESE_INIZIALE=1 WHERE MESE_INIZIALE IS NULL;
ALTER TABLE P258_ADDIZIONALIIRPEF MODIFY MESE_INIZIALE NOT NULL;
ALTER TABLE P258_ADDIZIONALIIRPEF ADD TIPO_VERSAMENTO VARCHAR2(1);
COMMENT ON COLUMN P258_ADDIZIONALIIRPEF.TIPO_VERSAMENTO IS 'Tipo versamento: S=Saldo, A=Acconto';
UPDATE P258_ADDIZIONALIIRPEF SET TIPO_VERSAMENTO='S' WHERE TIPO_VERSAMENTO IS NULL;
ALTER TABLE P258_ADDIZIONALIIRPEF MODIFY TIPO_VERSAMENTO NOT NULL;
COMMENT ON COLUMN P258_ADDIZIONALIIRPEF.NUMERO_RATE IS 'Numero rate mensili';
ALTER TABLE P258_ADDIZIONALIIRPEF MODIFY NUMERO_RATE DEFAULT NULL;
ALTER TABLE P258_ADDIZIONALIIRPEF DROP CONSTRAINT P258_PK CASCADE;
ALTER TABLE P258_ADDIZIONALIIRPEF
  ADD CONSTRAINT P258_PK PRIMARY KEY (PROGRESSIVO, ANNO, TIPO_ADDIZIONALE, TIPO_VERSAMENTO)
  USING INDEX TABLESPACE INDICI PCTFREE 10 INITRANS 2 MAXTRANS 255
  STORAGE
  (
    INITIAL 1056K
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  );

alter table P500_CUDSETUP add ID_ABBONATO_POSTEL varchar2(8);
comment on column P500_CUDSETUP.ID_ABBONATO_POSTEL
  is 'ID assegnato da Postel per identificare il cliente abbonato';
alter table P500_CUDSETUP add TIPOLOGIA_INVIO_POSTEL varchar2(2);
comment on column P500_CUDSETUP.TIPOLOGIA_INVIO_POSTEL
  is 'Modalità di spedizione delle buste (es. posta ordinaria, prioritaria, raccomandata)';
alter table P500_CUDSETUP add COLORE_POSTEL varchar2(3);
comment on column P500_CUDSETUP.COLORE_POSTEL
  is 'Colore dell''intestazione (indirizzo) delle buste'; 
alter table P500_CUDSETUP add PROCEDURA_POSTEL varchar2(12);
comment on column P500_CUDSETUP.PROCEDURA_POSTEL
  is 'Fornito da Postel, identifica la procedura'; 
alter table P500_CUDSETUP add TRATTAMENTO_POSTEL varchar2(2);
comment on column P500_CUDSETUP.TRATTAMENTO_POSTEL
  is 'Uso che deve fare Postel dei dati ricevuti (es. archiviazione, solo stampa, invio)'; 
alter table P500_CUDSETUP add CENTRO_COSTO_POSTEL varchar2(8);
comment on column P500_CUDSETUP.CENTRO_COSTO_POSTEL
  is 'Centro di costo da far comparire sulla fattura che Postel invia all''abbonato'; 


alter table M010_PARAMETRICONTEGGIO add IND_DA_TAB_TARIFFE varchar2(1) default 'N';
comment on column M010_PARAMETRICONTEGGIO.IND_DA_TAB_TARIFFE
  is 'valori S/N etichettato "Indennità da tabella tariffe".  Se attivo non richiedere i dati relativi alla riduzione delle indennità.
';

alter table M040_MISSIONI add COD_TARIFFA varchar2(10);
alter table M040_MISSIONI add COD_RIDUZIONE varchar2(5);
alter table M060_ANTICIPI add ITA_EST varchar2(1) default 'I';

create table M065_TARIFFE_INDENNITA
(
  CODICE           VARCHAR2(80) not null,
  COD_TARIFFA      VARCHAR2(10) not null,
  DECORRENZA       DATE not null,
  DECORRENZA_FINE  DATE,	
  DESCRIZIONE      VARCHAR2(40),
  IND_GIORNALIERA  NUMBER,
  VOCEPAGHE_ESENTE VARCHAR2(6),
  VOCEPAGHE_ASSOG  VARCHAR2(6)
)
tablespace LAVORO
  storage
  ( initial 256K next 256K pctincrease 0 );
comment on column M065_TARIFFE_INDENNITA.CODICE
  is 'Codice del dato libero che rappresenta la categoria economica';
alter table M065_TARIFFE_INDENNITA
  add constraint M065_PK primary key (CODICE, COD_TARIFFA, DECORRENZA)
  using index 
  tablespace INDICI
  storage
  ( initial 256K next 256K pctincrease 0 );


create table M066_RIDUZIONI
(
  CODICE              VARCHAR2(80) not null,
  COD_TARIFFA         VARCHAR2(10) not null,
  DECORRENZA          DATE not null,
  COD_RIDUZIONE       VARCHAR2(5) not null,
  DESCRIZIONE         VARCHAR2(40),
  PERC_RIDUZIONE      NUMBER,
  QUOTA_ESENTE        NUMBER,
  COEFF_MAGGIORAZIONE NUMBER
)
tablespace LAVORO
  storage
  ( initial 256K next 256K pctincrease 0 );
alter table M066_RIDUZIONI
  add constraint M066_PK primary key (CODICE, COD_TARIFFA, DECORRENZA, COD_RIDUZIONE)
  using index 
  tablespace INDICI
  storage
  ( initial 256K next 256K pctincrease 0 );

alter table T267_REGOLERIPOSI add RIPOSO_LAVORATO varchar2(5);

ALTER TABLE SG510_DATISTAMPAPIANTA MODIFY NOME_DATO VARCHAR2(50);

select max(length(PERCORSO)) from SG506_PIANTADISTRIBUZIONE;

alter table SG650_TESTATACORSI add DEFINITIVO varchar2(1) default 'S';
alter table SG664_DOCENTI add TIPO varchar2(1) default 'D';
comment on column SG664_DOCENTI.TIPO is 'R=Responsabile Scientifico - D=Docente - T=Tutor - A=Altro';
alter table SG664_DOCENTI add ATTIVO varchar2(1) default 'S';
comment on column SG664_DOCENTI.ATTIVO is 'S=Attivo - N=Supplente';
