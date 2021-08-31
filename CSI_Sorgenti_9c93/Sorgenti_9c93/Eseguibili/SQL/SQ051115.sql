UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '6.0.5' WHERE AZIENDA = :AZIENDA;

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

alter table MONDOEDP.I074_FILTRODIZIONARIO add abilitato varchar2(1) default 'S';

comment on column P212_PARAMETRISTIPENDI.TIPO_ABBATTIMENTO13A
  is 'Tipo abbatimento 13a in caso di assenza: C=Complessivo mese se percentualizzando i giorni di assenza i giorni utili non superano la meta'' dei giorni contrattuali, A=Complessivo anno i giorni di assenza vengono totalizzati nell''''anno al fine di abbattere i ratei quando raggiungono la meta'' dei giorni contrattuali, R=Rapportato ai giorni di assenza';

alter table P010_BANCHE drop constraint P010_FK_T480;

alter table T220_PROFILIORARI add DECORRENZA date;
UPDATE T220_PROFILIORARI SET DECORRENZA = TO_DATE('01011900','ddmmyyyy');
alter table T220_PROFILIORARI modify DECORRENZA not null;

-- Create/Recreate primary, unique and foreign key constraints 
alter table T220_PROFILIORARI drop primary key;
alter table T220_PROFILIORARI
  add constraint T220_PK primary key (CODICE, DECORRENZA)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 12K
    minextents 1
  );

alter table T221_PROFILISETTIMANA add DECORRENZA date;
UPDATE T221_PROFILISETTIMANA SET DECORRENZA = TO_DATE('01011900','ddmmyyyy');
alter table T221_PROFILISETTIMANA modify DECORRENZA not null;

update T430_STORICO set PORARIO = '*' where PORARIO IS NULL;
alter table T430_STORICO modify PORARIO DEFAULT '*' not null;

-- Create/Recreate primary, unique and foreign key constraints 
alter table T221_PROFILISETTIMANA drop primary key;
alter table T221_PROFILISETTIMANA
  add constraint T221_PK primary key (CODICE,DECORRENZA,PROGRESSIVO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 32K
    minextents 1
  );

DELETE FROM T221_PROFILISETTIMANA T221 WHERE NOT EXISTS
(SELECT 'X' FROM T220_PROFILIORARI WHERE CODICE=T221.CODICE AND DECORRENZA=T221.DECORRENZA);
alter table T221_PROFILISETTIMANA
  add constraint T221_FK_T220 foreign key (CODICE, DECORRENZA)
  references T220_PROFILIORARI (CODICE, DECORRENZA) on delete cascade;

INSERT INTO T220_PROFILIORARI (CODICE,DECORRENZA) VALUES ('*',TO_DATE('01011900','ddmmyyyy'));

ALTER TABLE T262_PROFASSANN ADD FRUIZ_ANNO_MINIMA VARCHAR2(7);
COMMENT ON COLUMN T262_PROFASSANN.FRUIZ_ANNO_MINIMA IS 'Fruizione minima anno corrente';
ALTER TABLE T262_PROFASSANN ADD FRUIZ_ANNO_CONTINUATIVA VARCHAR2(1) DEFAULT 'N';
COMMENT ON COLUMN T262_PROFASSANN.FRUIZ_ANNO_CONTINUATIVA IS 'S/N Indica se la Fruizione minima anno corrente è continuativa o meno';

ALTER TABLE T025_CONTMENSILI ADD BANCA_ORE_MENS_ARR VARCHAR2(5);
COMMENT ON COLUMN T025_CONTMENSILI.BANCA_ORE_MENS_ARR IS 'Arrotondamento della banca ore maturata mensilmente (liquidabmese)';
ALTER TABLE T025_CONTMENSILI ADD SALDO_NEGATIVO_MINIMO_TIPO VARCHAR2(1) DEFAULT '0';
COMMENT ON COLUMN T025_CONTMENSILI.SALDO_NEGATIVO_MINIMO_TIPO IS '0=Nessuno - 1=Fisso - 2=LiquidabileMensile+BancaOre';
UPDATE T025_CONTMENSILI SET SALDO_NEGATIVO_MINIMO_TIPO = '1' WHERE OREMINUTI(SALDO_NEGATIVO_MINIMO) < 0;
UPDATE T025_CONTMENSILI SET ABBATT_MOBILE_RIFERIMENTO = DECODE(ABBATT_MOBILE_RIFERIMENTO,'M','0','A','1',ABBATT_MOBILE_RIFERIMENTO);
COMMENT ON COLUMN T025_CONTMENSILI.ABBATT_MOBILE_RIFERIMENTO IS '0=Mensile - 1=Min(Mensile,Annuale) - 2=Annuale';
ALTER TABLE T025_CONTMENSILI ADD ARRREC_SCOSTNEG VARCHAR2(5);
COMMENT ON COLUMN T025_CONTMENSILI.ARRREC_SCOSTNEG IS 'Arrotondamento del recupero degli scostamenti negativi sul liquidabile mensile';

alter table P200_VOCI modify NOTE varchar2(2000);

ALTER TABLE T162_INDENNITA ADD ASSENZE_ABILITATE VARCHAR2(200);
COMMENT ON COLUMN T162_INDENNITA.ASSENZE_ABILITATE IS 'Elenco assenze che consentono la maturazione dell''indennità';
UPDATE T162_INDENNITA SET ARROTONDAMENTO='E' WHERE TIPO='B';

ALTER TABLE T265_CAUASSENZE ADD PROPORZIONA_ABILITAZIONE VARCHAR2(1) DEFAULT 'N';
COMMENT ON COLUMN T265_CAUASSENZE.PROPORZIONA_ABILITAZIONE IS 'Proporzionamento competenze in base a abilitazione causale su scheda anagrafica';

alter table M010_PARAMETRICONTEGGIO add CODICI_INDENNITAKM varchar2(500);
alter table M010_PARAMETRICONTEGGIO add CODICI_RIMBORSI varchar2(500);
-- Add comments to the columns 
comment on column M010_PARAMETRICONTEGGIO.CODICI_INDENNITAKM
  is 'indennità chilometriche associate alla tipologia di missione';
comment on column M010_PARAMETRICONTEGGIO.CODICI_RIMBORSI
  is 'rimborsi associati alla tipologia di missione';

--------------------------------------- STATO GIURIDICO ------------------------
ALTER TABLE SG100_PROVVEDIMENTO ADD TIPO_PROVV VARCHAR2(1) DEFAULT 'S';  
COMMENT ON COLUMN SG100_PROVVEDIMENTO.TIPO_PROVV IS 'Tipo: S-Provvedimento Storico, A-Provvedimento Assenza, I-Incarico';
ALTER TABLE SG100_PROVVEDIMENTO ADD DATAFINE DATE;
COMMENT ON COLUMN SG100_PROVVEDIMENTO.DATAFINE IS 'Data fine provvedimento/incarico';
ALTER TABLE SG100_PROVVEDIMENTO ADD SEDE VARCHAR2(80);
COMMENT ON COLUMN SG100_PROVVEDIMENTO.SEDE IS 'Sede incarico';
-- Create table
create table SG105_TIPOINCARICHI
( CODICE   VARCHAR2(10) not null,
  DESCRIZIONE   VARCHAR2(2000))
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  ( initial 8K minextents 1);
-- Add comments to the columns 
comment on column SG105_TIPOINCARICHI.CODICE  is 'Codice tipologia incarico';
comment on column SG105_TIPOINCARICHI.DESCRIZIONE is 'Descrizione tipologia incarico';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG105_TIPOINCARICHI
  add constraint SG105_PK primary key (CODICE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  ( initial 64K minextents 1);
RENAME SG103_CURRICULUM TO SG103_OLD;    
ALTER TABLE SG103_OLD DROP CONSTRAINT SG103_PK;
RENAME SG502_TITOLI TO SG502_OLD;   
ALTER TABLE SG502_OLD DROP CONSTRAINT SG502_PK;
RENAME SG503_DOCUMENTI TO SG103_TIPODOCUMENTI;  
ALTER TABLE SG103_TIPODOCUMENTI DROP CONSTRAINT SG503_PK;
alter table SG103_TIPODOCUMENTI
  add constraint SG103_PK primary key (CODICE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  ( initial 12K minextents 1);
RENAME SG501_CAUSALI TO SG104_TIPOMOTIVAZIONI;  
ALTER TABLE SG104_TIPOMOTIVAZIONI DROP CONSTRAINT SG501_PK;
alter table SG104_TIPOMOTIVAZIONI 
  add constraint SG104_PK primary key (CODICE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  ( initial 12K  minextents 1);

INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA, TIPO)
SELECT AZIENDA, 'C14_PROVVSEDE' FROM MONDOEDP.I090_ENTI;

CREATE TABLE SG100_20060201 AS SELECT * FROM SG100_PROVVEDIMENTO;
UPDATE SG100_PROVVEDIMENTO SG100 
SET DATAFINE = 
  (SELECT MIN(DATADECOR) - 1 FROM SG100_PROVVEDIMENTO WHERE PROGRESSIVO = SG100.PROGRESSIVO
   AND NOMECAMPO = SG100.NOMECAMPO AND DATADECOR > SG100.DATADECOR)
WHERE DATADECOR < 
  (SELECT MAX(DATADECOR) FROM SG100_PROVVEDIMENTO WHERE PROGRESSIVO = SG100.PROGRESSIVO 
        AND NOMECAMPO = SG100.NOMECAMPO);
UPDATE SG100_PROVVEDIMENTO SG100 
SET DATAFINE = TO_DATE('31123999','DDMMYYYY')
WHERE DATADECOR = 
  (SELECT MAX(DATADECOR) FROM SG100_PROVVEDIMENTO WHERE PROGRESSIVO = SG100.PROGRESSIVO
        AND NOMECAMPO = SG100.NOMECAMPO);

ALTER TABLE I010_CAMPIANAGRAFICI ADD PROVVEDIMENTO VARCHAR2(1) DEFAULT 'N';
UPDATE I010_CAMPIANAGRAFICI SET PROVVEDIMENTO = 'S'
WHERE NOME_CAMPO IN (SELECT NOMECAMPO FROM SG500_DATILIBERI WHERE RIFPROVVED = 'S');

ALTER TABLE T248_PERMESSISINDACALI ADD TIPO_PERMESSO VARCHAR2(1);
COMMENT ON COLUMN T248_PERMESSISINDACALI.TIPO_PERMESSO IS 'Tipologia di permesso a Giornate (I) / Mezze giornate (M) / Num.Ore (N) / Da Ore - A Ore (D)';
ALTER TABLE T248_PERMESSISINDACALI ADD PROG_PERMESSO NUMBER;
COMMENT ON COLUMN T248_PERMESSISINDACALI.PROG_PERMESSO IS 'Progressivo interno';
UPDATE T248_PERMESSISINDACALI SET TIPO_PERMESSO = 'D' WHERE ALLE IS NOT NULL;
UPDATE T248_PERMESSISINDACALI SET TIPO_PERMESSO = 'N' WHERE ALLE IS NULL;
UPDATE T248_PERMESSISINDACALI SET PROG_PERMESSO = 0;
ALTER TABLE T248_PERMESSISINDACALI DROP CONSTRAINT T248_PK;
alter table T248_PERMESSISINDACALI
  add constraint T248_PK primary key (PROGRESSIVO, DATA, ABBATTE_COMPETENZE, COD_SINDACATO, COD_ORGANISMO, STATO, PROG_PERMESSO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (initial 160K  minextents 1);

RENAME T820_LIMITIIND TO T820_604;
ALTER TABLE T820_604 DROP PRIMARY KEY;

create table T820_LIMITIIND(
PROGRESSIVO number(8),
ANNO number(4),
MESE number(2),
DAL  number(2) DEFAULT 1,
AL   number(2) DEFAULT 31,
CAUSALE varchar2(5) DEFAULT '* L',
LIQUIDABILE varchar2(1) default 'S',
ORE_TEORICHE varchar2(7),
ORE varchar2(7))
tablespace LAVORO 
  pctfree 10 pctused 40 initrans 1 maxtrans 255
  storage (initial 8K next 128K minextents 1);

alter table T820_LIMITIIND
  add constraint T820_PK primary key (PROGRESSIVO,ANNO,MESE,DAL,CAUSALE)
  using index 
  tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 8K next 128K minextents 1);

COMMENT ON COLUMN T820_LIMITIIND.CAUSALE IS '(* L)-Liquidabile non causalizzato, (* B)-Banca ore non causalizzata';
COMMENT ON COLUMN T820_LIMITIIND.LIQUIDABILE IS '(S)-Limite riferito al liquidabile, (N)-Limite riferito al residuabile/banca ore';

INSERT INTO T820_LIMITIIND
  (PROGRESSIVO,ANNO,MESE,DAL,AL,CAUSALE,LIQUIDABILE,ORE_TEORICHE,ORE)
SELECT 
  PROGRESSIVO,ANNO,MESE,1,31,'* L','S',LIQUIDABILE_TEORICO,LIQUIDABILE FROM T820_604;

INSERT INTO T820_LIMITIIND
  (PROGRESSIVO,ANNO,MESE,DAL,AL,CAUSALE,LIQUIDABILE,ORE_TEORICHE,ORE)
SELECT 
  PROGRESSIVO,ANNO,MESE,1,31,'* B','N',RESIDUABILE_TEORICO,RESIDUABILE FROM T820_604;

insert into mondoedp.i091_datiente (AZIENDA,TIPO,DATO)
select azienda,'C15_LIMITIMENSCAUS','N' from mondoedp.i090_enti;

alter table T361_OROLOGI modify DESCRIZIONE varchar2(100);

alter table T191_PARPAGHE add TIPODATA_FILE varchar2(1) DEFAULT 'C';

ALTER TABLE T074_CAUSPRESFASCE MODIFY OREPRESENZA VARCHAR2(7);

INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA,TIPO,DATO)
SELECT AZIENDA,'C8_GESTIONEMENSILE','S' FROM MONDOEDP.I090_ENTI;
INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA,TIPO,DATO)
SELECT AZIENDA,'C90_WEBAUTORIZCURRIC','S' FROM MONDOEDP.I090_ENTI;
--------------------------------------- INCENTIVI ------------------------
create table T769_INCENTIVIASSENZE
(
  DATO1             VARCHAR2(20) default ' ' not null,
  DATO2             VARCHAR2(20) default ' ' not null,
  DATO3             VARCHAR2(20) default ' ' not null,
  DECORRENZA        DATE not null,
  CAUSALE           VARCHAR2(5) not null,
  PERC_ABBATTIMENTO NUMBER(5,2) default 100 not null,
  PERC_ABB_FRANCHIGIA NUMBER(5,2) default 100 not null
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 12K
    minextents 1
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table T769_INCENTIVIASSENZE
  add constraint T769_PK primary key (DATO1,DATO2,DATO3,DECORRENZA,CAUSALE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 12K
    minextents 1
  );
  
UPDATE T265_CAUASSENZE SET CUMULO_FAMILIARI = 'N' WHERE TIPOCUMULO NOT IN ('F','G');
UPDATE T265_CAUASSENZE SET FRUIZIONE_FAMILIARI = 'N' WHERE FRUIZIONE = 'N';

-- Create table
create table M042_LOCALITA
(
  CODICE      varchar2(6),
  DESCRIZIONE varchar2(30)
)
tablespace LAVORO
  storage
  (
    initial 64K
    minextents 1
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table M042_LOCALITA
  add constraint M042_PK primary key (CODICE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
  );

-- Create table
create table M041_DISTANZE
(
  TIPO1    	     VARCHAR2(1) not null,
  LOCALITA1          VARCHAR2(6) not null,
  TIPO2		     VARCHAR2(1) not null,
  LOCALITA2          VARCHAR2(6) not null,
  CHILOMETRI         NUMBER default 0 not null
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
  );
-- Add comments to the columns 
comment on column M041_DISTANZE.TIPO1
  is 'Indica se la prima localita corrisponde ad un comune C oppure ad una localita personalizzata P';
comment on column M041_DISTANZE.LOCALITA1
  is 'codice istat del comune o codice della localita';
comment on column M041_DISTANZE.TIPO2
  is 'Indica se la seconda localita corrisponde ad un comune C oppure ad una localita personalizzata P';
comment on column M041_DISTANZE.LOCALITA2
  is 'codice istat del comune o codice della localita';
comment on column M041_DISTANZE.CHILOMETRI
  is 'numero dei chilometri';

-- Create/Recreate primary, unique and foreign key constraints 
alter table M041_DISTANZE
  add constraint M041_PK primary key (TIPO1, LOCALITA1, TIPO2, LOCALITA2)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
  );

------------------------ REGOLE INSERIMENTO RIPOSI ----------------
INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA, TIPO)
SELECT AZIENDA, 'C16_INSRIPOSI' FROM MONDOEDP.I090_ENTI;

create table T267_REGOLERIPOSI
(CODICE varchar2(20) not null,
DESCRIZIONE varchar2(60),
TIPO_CAUSALE varchar2(1) DEFAULT 'R' not null,  
RIPOSO_ORDINARIO VARCHAR2(5) not null,
RIPOSO_COMPENSATIVO VARCHAR2(5) not null,
RIPOSO_MESEPREC VARCHAR2(5) not null,
CANCELLAZIONE_CAUSALE VARCHAR2(1) DEFAULT 'S', 
PERSONALE_NON_TURNISTA VARCHAR2(1) DEFAULT 'N', 
SMONTO_NOTTE VARCHAR2(1) DEFAULT 'N', 
LIMITE_SALDO VARCHAR2(1) DEFAULT 'N', 
GGNONLAV_CON_TIMBRATURE VARCHAR2(1) DEFAULT 'N', 
SOLO_SE_NON_REPERIBILE VARCHAR2(1) DEFAULT 'N', 
DOMENICA_GIUSTIFICATA VARCHAR2(1) DEFAULT 'N', 
GGNONLAV_GIUSTIFICATO VARCHAR2(1) DEFAULT 'N', 
GGCALEND_GIUSTIFICATO VARCHAR2(1) DEFAULT 'N', 
CAUS_PRESENZA_TOLLERATE VARCHAR2(2000),
CAUS_ASSENZA_NONTOLLERATE VARCHAR2(2000))
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  ( initial 96K minextents 1);

-- Create/Recreate primary, unique and foreign key constraints 
alter table T267_REGOLERIPOSI
  add constraint T267_PK primary key (CODICE,TIPO_CAUSALE,RIPOSO_ORDINARIO,RIPOSO_COMPENSATIVO,RIPOSO_MESEPREC)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (initial 64K  minextents 1);

SELECT PROG, PROGOPERATORE, NOME, VALORE 
FROM T001_PARAMETRIFUNZIONI 
WHERE PROG = 'A041'
ORDER BY PROG, PROGOPERATORE;
