ALTER TABLE MONDOEDP.I090_ENTI ADD VERSIONEDB VARCHAR2(10);
UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.4.3' WHERE AZIENDA = :AZIENDA;

ALTER TABLE T265_CAUASSENZE MODIFY GNonLav DEFAULT 'A';
ALTER TABLE T265_CAUASSENZE MODIFY InfluCont DEFAULT 'A';
ALTER TABLE T265_CAUASSENZE MODIFY ValorGior DEFAULT 'D';
ALTER TABLE T265_CAUASSENZE MODIFY InfluenzaPO DEFAULT 'B';
ALTER TABLE T265_CAUASSENZE MODIFY GnonLav DEFAULT 'A';
ALTER TABLE T265_CAUASSENZE MODIFY IndPres DEFAULT 'B';
ALTER TABLE T265_CAUASSENZE MODIFY EccedLiq DEFAULT 'B';
ALTER TABLE T265_CAUASSENZE MODIFY RaggrStat DEFAULT 'Z';
ALTER TABLE T265_CAUASSENZE MODIFY DetReperib DEFAULT 'S';
ALTER TABLE T265_CAUASSENZE MODIFY Stampa DEFAULT 'B';
ALTER TABLE T265_CAUASSENZE MODIFY GSignific DEFAULT 'GL';
ALTER TABLE T265_CAUASSENZE MODIFY Fruibile DEFAULT 'S';
ALTER TABLE T265_CAUASSENZE MODIFY MaturFerie DEFAULT 'S';
ALTER TABLE T265_CAUASSENZE MODIFY UMisura DEFAULT 'G';
ALTER TABLE T265_CAUASSENZE MODIFY TipoCumulo DEFAULT 'H';
ALTER TABLE T265_CAUASSENZE MODIFY UMCumulo DEFAULT 'A';
ALTER TABLE T265_CAUASSENZE MODIFY Fruizione DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE MODIFY UMFruizione DEFAULT 'A';
ALTER TABLE T265_CAUASSENZE MODIFY Ricorsione DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE MODIFY CumuloGlobale DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE MODIFY ValSeTimb DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE MODIFY RecuperoFestivo DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE MODIFY Esclusione DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE MODIFY TipoRecupero DEFAULT '0';
ALTER TABLE T265_CAUASSENZE MODIFY PartTime DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE MODIFY Tipo_Proporzione DEFAULT 'C';
ALTER TABLE T265_CAUASSENZE MODIFY Proporziona_PerServ DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE MODIFY Tempo_Determinato DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE MODIFY Cumulo_Familiari DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE MODIFY Fruizione_Familiari DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE MODIFY Allunga_Prova DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE MODIFY Registra_Storico DEFAULT 'N';

ALTER TABLE T460_PARTTIME MODIFY PIANTA DEFAULT 100;
ALTER TABLE T460_PARTTIME MODIFY INDPRES DEFAULT 100;
ALTER TABLE T460_PARTTIME MODIFY INCENTIVI DEFAULT 100;
ALTER TABLE T460_PARTTIME MODIFY INDFEST DEFAULT 100;

ALTER TABLE MONDOEDP.I090_ENTI ADD RAGIONE_SOCIALE VARCHAR2(200);

create table MONDOEDP.I080_MODULI
(
  APPLICAZIONE VARCHAR2(6),
  MODULO       VARCHAR2(80)
)
tablespace LAVORO
  pctfree 10 pctused 80 initrans 1 maxtrans 255
  storage (initial 32K next 32K minextents 1 pctincrease 0);

ALTER TABLE T482_REGIONI ADD COD_IRPEF VARCHAR2(2);

UPDATE T482_REGIONI SET COD_IRPEF = SUBSTR(COD_REGIONE,1,2);
COMMIT;

ALTER TABLE T482_REGIONI MODIFY COD_IRPEF NOT NULL;

ALTER TABLE T361_OROLOGI ADD POSTAZIONE VARCHAR2(5);
ALTER TABLE T361_OROLOGI ADD INDIRIZZO_TERMINALE VARCHAR2(5);
ALTER TABLE T361_OROLOGI ADD INDIRIZZO_IP VARCHAR2(15);
ALTER TABLE T361_OROLOGI ADD RICEZIONE_MESSAG VARCHAR2(1) DEFAULT 'S' NOT NULL;

-- Create table
create table T291_PARMESSAGGI
(
  CODICE       VARCHAR2(5) not null,
  DESCRIZIONE  VARCHAR2(40),
  TIPO_FILE    VARCHAR2(1),
  NOME_FILE    VARCHAR2(80),
  DATA_FILE    VARCHAR2(10),
  DEFAULT_FILE VARCHAR2(1)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 32K
    next 32K
    minextents 1
    pctincrease 0
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table T291_PARMESSAGGI
  add constraint T291_PK primary key (CODICE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10K
    next 10K
    minextents 1
    pctincrease 0
  );


-- Create table
create table T292_PARMESSAGGIDATI
(
  CODICE         VARCHAR2(5) not null,
  TIPO_RECORD    VARCHAR2(2),
  NUMERO_RECORD  NUMBER not null,
  TIPO           VARCHAR2(2),
  POSIZIONE      NUMBER not null,
  LUNGHEZZA      NUMBER,
  NOME_COLONNA   VARCHAR2(20) not null,
  FORMATO        VARCHAR2(20),
  VALORE_DEFAULT VARCHAR2(80)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 32K
    next 64K
    minextents 1
    pctincrease 0
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table T292_PARMESSAGGIDATI
  add constraint T292_PK primary key (CODICE,NUMERO_RECORD,POSIZIONE,NOME_COLONNA)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 32K
    next 64K
    minextents 1
    pctincrease 0
  );

--PCTINCREASE = 1 per compattare gli spazi inutilizzati 
ALTER TABLESPACE LAVORO DEFAULT STORAGE (PCTINCREASE 1);
ALTER TABLESPACE INDICI DEFAULT STORAGE (PCTINCREASE 1);