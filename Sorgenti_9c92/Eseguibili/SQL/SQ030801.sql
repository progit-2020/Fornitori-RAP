UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.5.2' WHERE AZIENDA = :AZIENDA;

UPDATE T021_FASCEORARI SET NUMTURNO = NULL WHERE CODICE IN (SELECT CODICE FROM T020_ORARI WHERE TIPOORA <> 'E');

ALTER TABLE T265_CAUASSENZE ADD FRUIZ_MIN VARCHAR2(5);
ALTER TABLE T265_CAUASSENZE ADD FRUIZ_ARR VARCHAR2(5);
ALTER TABLE T265_CAUASSENZE ADD FRUIZ_MAX_DEBITO VARCHAR2(1) DEFAULT 'N';

COMMENT ON COLUMN T042_PERIODIASSENZA.FLAG IS
  'Stato periodo assenza in funzione stipendi: N=Non considerare, P=Periodo elaborato dal precalcolo, C=Periodo chiuso';

CREATE INDEX T042_IDX ON T042_PERIODIASSENZA (PROGRESSIVO,CAUSALE,DAL) 
STORAGE (PCTINCREASE 0 INITIAL 64K NEXT 1M) TABLESPACE INDICI;

ALTER TABLE P430_ANAGRAFICO ADD DECORRENZA_FINE DATE;

UPDATE P430_ANAGRAFICO P430 SET 
  DECORRENZA_FINE = 
  (SELECT MIN(DECORRENZA) - 1 FROM P430_ANAGRAFICO WHERE PROGRESSIVO = P430.PROGRESSIVO AND DECORRENZA > P430.DECORRENZA)
WHERE 
  DECORRENZA < (SELECT MAX(DECORRENZA) FROM P430_ANAGRAFICO WHERE PROGRESSIVO = P430.PROGRESSIVO);

UPDATE P430_ANAGRAFICO P430 SET 
  DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
WHERE 
  DECORRENZA = (SELECT MAX(DECORRENZA) FROM P430_ANAGRAFICO WHERE PROGRESSIVO = P430.PROGRESSIVO);

ALTER TABLE I010_CAMPIANAGRAFICI ADD APPLICAZIONE VARCHAR2(6) DEFAULT '*';

ALTER TABLE I010_CAMPIANAGRAFICI DROP PRIMARY KEY;
ALTER TABLE I010_CAMPIANAGRAFICI ADD CONSTRAINT I010_PK  PRIMARY KEY(NOME_CAMPO,APPLICAZIONE)
  USING INDEX TABLESPACE INDICI STORAGE (INITIAL 32K NEXT 32K PCTINCREASE 0);

DROP INDEX I010_NOME_LOGICO;
DROP INDEX P003_IDX2;

ALTER TABLE I010_CAMPIANAGRAFICI ADD CONSTRAINT I010_NOME_LOGICO UNIQUE(NOME_LOGICO,APPLICAZIONE)
  USING INDEX TABLESPACE INDICI STORAGE (INITIAL 32K NEXT 32K PCTINCREASE 0);

CREATE TABLE P001_TABP430
(COLONNA_P430 VARCHAR2(80),
 TABELLA VARCHAR2(80),
 COLONNA_TABELLA VARCHAR2(80)
)
TABLESPACE LAVORO 
STORAGE (INITIAL 32K NEXT 32K PCTINCREASE 0);

ALTER TABLE P001_TABP430 ADD CONSTRAINT P001_PK PRIMARY KEY (COLONNA_P430)
USING INDEX TABLESPACE INDICI STORAGE(INITIAL 16K NEXT 16K PCTINCREASE 0);

insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_POSIZIONE_ECONOMICA', 'VP220_LIVELLI', 'COD_POSIZIONE_ECONOMICA');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_PARTTIME', 'P040_PARTTIME', 'COD_PARTTIME');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_PAGAMENTO', 'P130_PAGAMENTI', 'COD_PAGAMENTO');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_BANCA', 'P010_BANCHE', 'COD_BANCA');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_STATOCIVILE', 'P020_STATOCIVILE', 'COD_STATOCIVILE');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_NAZIONALITA', 'P120_NAZIONALITA', 'COD_NAZIONALITA');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_NAZIONALITAESTERE', 'P121_NAZIONALITAESTERE', 'COD_NAZIONALITAESTERE');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_CAUSALEIRPEF', 'P080_CAUSALIIRPEF', 'COD_CAUSALEIRPEF');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_REGIONE_IRPEF', 'T482_REGIONI', 'COD_REGIONE');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_CONTRATTO', 'VP210_CONTRATTI', 'COD_CONTRATTO');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_VALUTA_STAMPA', 'VP030_VALUTE', 'COD_VALUTA_STAMPA');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_TABELLAANF', 'VP236_TABELLEANF', 'COD_TABELLAANF');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_PARAMETRISTIPENDI', 'VP212_PARAMETRISTIPENDI', 'COD_PARAMETRISTIPENDI');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_CODICEINPS', 'VP090_CODICIINPS', 'COD_CODICEINPS');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_CODICEINAIL', 'VP092_CODICIINAIL', 'COD_CODICEINAIL');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_TIPOASSOGGETTAMENTO', 'VP240_TIPIASSOGGETTAMENTI', 'COD_TIPOASSOGGETTAMENTO');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_INQUADRINPDAP', 'VP094_INQUADRINPDAP', 'COD_INQUADRINPDAP');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_INQUADRINPS', 'VP096_INQUADRINPS', 'COD_INQUADRINPS');
insert into P001_TABP430 (COLONNA_P430, TABELLA, COLONNA_TABELLA)
values ('COD_DEDUZIONEIRPEF', 'VP082_DEDUZIONIIRPEF', 'COD_DEDUZIONEIRPEF');

comment on column T044_STORICOGIUSTIFICATIVI.FLAG
  is 'NULL se mai elaborato da Paghe, P se Precalcolato, T se calcolata Tredicesima, C se Chiuso';

ALTER TABLE P430_ANAGRAFICO ADD PERC_IRPEF_EXTRA27 NUMBER;
ALTER TABLE P430_ANAGRAFICO ADD PERC_IRPEF_MASSIMA_EXTRA27 VARCHAR2(1) DEFAULT 'N';
COMMENT ON COLUMN P430_ANAGRAFICO.PERC_IRPEF_MANUALE IS
  '% IRPEF manuale fissa per cedolini normali e tredicesima; (opzionale)';
COMMENT ON COLUMN P430_ANAGRAFICO.PERC_IRPEF_EXTRA27 IS
  '% IRPEF manuale fissa per cedolini extra 27; (opzionale)';
COMMENT ON COLUMN P430_ANAGRAFICO.PERC_IRPEF_MASSIMA_EXTRA27 IS
  '% IRPEF massima dell''anno per cedolini extra 27 (S/N)';

/*
Raggruppamenti assoggettamenti
*/
CREATE TABLE P202_RAGGRUPPAMENTOASSOGG (
  COD_RAGGRUPPAMENTO_ASSOGG VARCHAR2(5),
  DESCRIZIONE VARCHAR2(40) NOT NULL,
  BLOCCATO VARCHAR2(1) DEFAULT 'N' NOT NULL,
  CONSTRAINT P202_PK PRIMARY KEY (COD_RAGGRUPPAMENTO_ASSOGG)
  USING INDEX STORAGE (pctincrease 0 initial 512K next 128K)
  TABLESPACE INDICI pctfree 10
)
STORAGE (pctincrease 0 initial 512K next 128K)
TABLESPACE LAVORO pctfree 10 pctused 40;

COMMENT ON COLUMN P202_RAGGRUPPAMENTOASSOGG.BLOCCATO IS
  'Assoggettamento bloccato per le voci bloccate (S/N)';

ALTER TABLE P200_VOCI ADD COD_RAGGRUPPAMENTO_ASSOGG VARCHAR2(5);
COMMENT ON COLUMN P200_VOCI.COD_RAGGRUPPAMENTO_ASSOGG IS
  'Codice di raggruppamento per le voci di assoggettamento';
ALTER TABLE P200_VOCI ADD CONSTRAINT P200_FK_P202
  FOREIGN KEY (COD_RAGGRUPPAMENTO_ASSOGG) REFERENCES P202_RAGGRUPPAMENTOASSOGG;
  
ALTER TABLE T265_CAUASSENZE ADD FLESSIBILITA_ORARIO VARCHAR2(1) DEFAULT 'N';

ALTER TABLE T275_CAUPRESENZE ADD FLESSIBILITA_ORARIO VARCHAR2(1) DEFAULT 'N';
