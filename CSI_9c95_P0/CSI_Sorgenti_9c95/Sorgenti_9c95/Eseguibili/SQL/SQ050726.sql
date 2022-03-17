UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '6.0.4' WHERE AZIENDA = :AZIENDA;

-- Create table
create table P076_IMPONAOSI
(
  COD_TIPOPAG VARCHAR2(5) not null,
  DECORRENZA  DATE not null,
  ETA_DA      NUMBER default 0 not null,
  ETA_A       NUMBER not null,
  IMPORTO     NUMBER default 0 not null,
  UNATANTUM   VARCHAR2(1) default 'N' not null
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 256k
    minextents 1
  );
-- Add comments to the columns 
comment on column P076_IMPONAOSI.ETA_DA
  is 'Eta'' iniziale';
comment on column P076_IMPONAOSI.ETA_A
  is 'Eta'' finale';
comment on column P076_IMPONAOSI.IMPORTO
  is 'Importo annuale o unatantum';
comment on column P076_IMPONAOSI.UNATANTUM
  is 'Unatantum da inserire nel solo cedolino coincidente con la decorrenza';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P076_IMPONAOSI
  add constraint P076_PK primary key (COD_TIPOPAG, DECORRENZA, ETA_DA)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    next 256k
    minextents 1
  );

ALTER TABLE P430_ANAGRAFICO ADD COD_ONAOSITIPOPAG VARCHAR2(5);
comment on column P430_ANAGRAFICO.COD_ONAOSITIPOPAG
  is 'Codice tipo pagamento particolare ONAOSI';

-- Add/modify columns 
alter table SG508_STAMPAPIANTA add OMETTI_COPERTURE_TOTALI varchar2(1) default 'N' not null;

ALTER TABLE I150_PARSCARICOGIUST ADD SEPARATORE VARCHAR2(1);
COMMENT ON COLUMN I150_PARSCARICOGIUST.SEPARATORE IS 'Carattere separatore dei dati nel file di testo';
ALTER TABLE I150_PARSCARICOGIUST ADD NUMGIORNI VARCHAR2(8);
COMMENT ON COLUMN I150_PARSCARICOGIUST.NUMGIORNI IS 'Numero giorni da inserire';
ALTER TABLE I150_PARSCARICOGIUST ADD DATADA VARCHAR2(8);
COMMENT ON COLUMN I150_PARSCARICOGIUST.DATADA IS 'Data inizio da cui inserire i giustificativi';
ALTER TABLE I150_PARSCARICOGIUST ADD FORMATODATA VARCHAR2(20);
COMMENT ON COLUMN I150_PARSCARICOGIUST.FORMATODATA IS 'Formato della data di inizio da cui inserire i giustificativi';
ALTER TABLE I150_PARSCARICOGIUST ADD DESCCAUSALE VARCHAR2(1) DEFAULT 'N';
COMMENT ON COLUMN I150_PARSCARICOGIUST.DESCCAUSALE IS 'Indicatore S/N di riconoscimento della causale per descrizione';
ALTER TABLE I150_PARSCARICOGIUST ADD AZIENDA VARCHAR2(30);
COMMENT ON COLUMN I150_PARSCARICOGIUST.AZIENDA IS 'Azienda in alternativa ad AZIN su cui scaricare i giustificativi';

ALTER TABLE MONDOEDP.I102_SCARICOPIANIFICATO ADD MODULO VARCHAR2(4);
COMMENT ON COLUMN MONDOEDP.I102_SCARICOPIANIFICATO.MODULO IS 'Modulo sw a cui fanno riferimento le pianificazioni';
UPDATE MONDOEDP.I102_SCARICOPIANIFICATO SET MODULO = 'B006' WHERE :AZIENDA = 'AZIN';

ALTER TABLE P660_FLUSSIREGOLE ADD FL_NUMERO_TREDPREC VARCHAR2(4);
comment on column P660_FLUSSIREGOLE.FL_NUMERO_TREDICESIMA
  is 'Fluper: numero del dato sostitutivo in caso di tredicesima anno corrente';
comment on column P660_FLUSSIREGOLE.FL_NUMERO_TREDPREC
  is 'Fluper: numero del dato sostitutivo in caso di tredicesima anno precedente';

ALTER TABLE P254_VOCIPROGRAMMATE ADD IMPORTO_INCREMENTO_RATA NUMBER DEFAULT 1;
comment on column P254_VOCIPROGRAMMATE.IMPORTO_INCREMENTO_RATA
  is 'Importo max incremento su ultima rata';

comment on column P272_RETRIBUZIONE_CONTRATTUALE.ORIGINE
  is 'Inserimento della voce: M=manuale, C=calcolo da programma';
comment on column P272_RETRIBUZIONE_CONTRATTUALE.STATO
  is 'Stato della voce: A=Aggiornabile, B=Bloccata (non gestito)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P272_RETRIBUZIONE_CONTRATTUALE
  drop constraint P272_PK cascade;
alter table P272_RETRIBUZIONE_CONTRATTUALE
  add constraint P272_PK primary key (PROGRESSIVO, COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DECORRENZA_INIZIO, ID_VOCE_PROGRAMMATA, TIPO_VOCE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    next 256k
    minextents 1
  );

ALTER TABLE SG101_FAMILIARI ADD DATAADOZ DATE;
COMMENT ON COLUMN SG101_FAMILIARI.DATAADOZ IS 'Data di adozione';

--------------------------------------- GESTIONE FORMAZIONE INIZIO ----------------------------------------------------------
alter table T030_ANAGRAFICO add TIPO_PERSONALE varchar2(1) default 'I' not null;
alter table T430_STORICO add DOCENTE varchar2(1) default 'N' not null;
DROP TABLE T430_APPOGGIO;
CREATE TABLE T430_APPOGGIO AS SELECT * FROM T430_STORICO WHERE 1<>1;
INSERT INTO T033_LAYOUT (nome, top, lft, caption, accesso, nomepagina, campodb) VALUES ('DEFAULT',9,477,'Tipo personale','N','Dati Anagrafici','TIPO_PERSONALE');
INSERT INTO T033_LAYOUT (nome, top, lft, caption, accesso, nomepagina, campodb) VALUES ('DEFAULT',222,448,'Docente','N','Dati Anagrafici','DOCENTE');

-- Add/modify columns 
alter table MONDOEDP.I071_PERMESSI add DEF_TIPO_PERSONALE varchar2(1) default 'I';
alter table MONDOEDP.I071_PERMESSI add MOD_PERSONALE_ESTERNO varchar2(1) default 'N';
--------------------------------------- GESTIONE FORMAZIONE FINE ----------------------------------------------------------

DROP TABLE T190_INTPAGHE;
CREATE TABLE T193_603_OLD AS SELECT * FROM T193_VOCIPAGHE_PARAMETRI;
DROP TABLE T193_VOCIPAGHE_PARAMETRI;
create table T193_VOCIPAGHE_PARAMETRI
(
  COD_INTERFACCIA            VARCHAR2(20) not null,   -- NUOVO
  VOCE_PAGHE          VARCHAR2(6) not null,
  DECORRENZA                    DATE not null,                   -- NUOVO 
  VOCE_PAGHE_CEDOLINO VARCHAR2(6),                 -- NUOVO fare dblookup su tab.p200_voci come in <A016> su campo Voce paghe 
  VOCE_PAGHE_NEGATIVA VARCHAR2(6),
  DESCRIZIONE         VARCHAR2(40),
  DAL                 DATE,
  AL                  DATE,
  AUTOINC_DAL         VARCHAR2(1) default 'S',
  AUTOINC_AL          VARCHAR2(1) default 'S'
)
tablespace LAVORO
  storage (initial 16K next 32K pctincrease 0 minextents 1);

-- Create/Recreate primary, unique and foreign key constraints 
alter table T193_VOCIPAGHE_PARAMETRI
  add constraint T193_PK primary key (COD_INTERFACCIA, VOCE_PAGHE, DECORRENZA)
  using index 
  tablespace INDICI
  storage (initial 16K next 32K pctincrease 0 minextents 1);

declare 
  cursor c1 is select distinct codice from t190_interfacciapaghe;
  cursor c2 is select * from t193_603_old;
begin
  for t1 in c1 loop
    for t2 in c2 loop
      insert into t193_vocipaghe_parametri
        (COD_INTERFACCIA, voce_paghe, DECORRENZA, voce_paghe_cedolino, voce_paghe_negativa, descrizione, dal, al, autoinc_dal, autoinc_al)
      values
        (t1.codice, t2.voce_paghe, to_date('01011900','ddmmyyyy'), t2.voce_paghe, t2.voce_paghe_negativa, t2.descrizione, t2.dal, t2.al, t2.autoinc_dal, t2.autoinc_al);
    end loop;
  end loop;
end;
/

ALTER TABLE P220_LIVELLI ADD DECORRENZA_FINE DATE;
UPDATE P220_LIVELLI P220 SET 
  DECORRENZA_FINE = 
  (SELECT MIN(DECORRENZA) - 1 FROM P220_LIVELLI WHERE COD_CONTRATTO = P220.COD_CONTRATTO 
   AND COD_POSIZIONE_ECONOMICA = P220.COD_POSIZIONE_ECONOMICA AND DECORRENZA > P220.DECORRENZA)
WHERE 
  DECORRENZA < (SELECT MAX(DECORRENZA) FROM P220_LIVELLI WHERE COD_CONTRATTO = P220.COD_CONTRATTO 
                AND COD_POSIZIONE_ECONOMICA = P220.COD_POSIZIONE_ECONOMICA);
UPDATE P220_LIVELLI P220 SET 
  DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
WHERE 
  DECORRENZA = (SELECT MAX(DECORRENZA) FROM P220_LIVELLI WHERE COD_CONTRATTO = P220.COD_CONTRATTO 
                AND COD_POSIZIONE_ECONOMICA = P220.COD_POSIZIONE_ECONOMICA);
DROP TABLE P430_APPOGGIO;
CREATE TABLE P430_APPOGGIO AS SELECT * FROM P430_ANAGRAFICO WHERE ROWNUM <0;
INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA,TIPO)
SELECT AZIENDA,'C13_CDC_PERCENT' FROM MONDOEDP.I090_ENTI;

create table T433_CDC_PERCENT
(
  PROGRESSIVO NUMBER(8),
  DECORRENZA DATE,
  DECORRENZA_FINE DATE,
  CODICE VARCHAR2(80),
  PERCENTUALE NUMBER(5,2)
)
tablespace LAVORO pctfree 10 pctused 40 initrans 1 maxtrans 255 
storage (initial 16K next 256K pctincrease 0 minextents 1);

alter table T433_CDC_PERCENT
  add constraint T433_PK primary key (PROGRESSIVO,DECORRENZA,CODICE)
  using index 
  tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 16K next 256K pctincrease 0 minextents 1);