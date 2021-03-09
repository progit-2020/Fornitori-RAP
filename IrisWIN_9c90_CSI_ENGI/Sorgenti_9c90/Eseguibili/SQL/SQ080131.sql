UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '7.2',PATCHDB = 0 WHERE AZIENDA = :AZIENDA;

CREATE TABLE T196_FILTROSCARICOPAGHE (
  CODICE VARCHAR2(5),
  TIPO VARCHAR2(1),
  CODVOCE VARCHAR2(6)
) TABLESPACE LAVORO STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

ALTER TABLE T196_FILTROSCARICOPAGHE ADD CONSTRAINT T196_PK PRIMARY KEY (CODICE,TIPO,CODVOCE)
USING INDEX TABLESPACE INDICI STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

COMMENT ON COLUMN T196_FILTROSCARICOPAGHE.TIPO IS 'I=CODICE INTERNO - V=CODICE VOCE';

alter table MONDOEDP.I080_MODULI add AZIENDA varchar2(30) default 'AZIN';

ALTER TABLE MONDOEDP.I071_PERMESSI DROP PRIMARY KEY;
DROP INDEX MONDOEDP.I071_PK;
ALTER TABLE MONDOEDP.I071_PERMESSI ADD AZIENDA VARCHAR2(30) DEFAULT 'AZIN';
ALTER TABLE MONDOEDP.I071_PERMESSI ADD CONSTRAINT I071_PK PRIMARY KEY (AZIENDA,PROFILO)
USING INDEX TABLESPACE INDICI storage (initial 256K next 256K pctincrease 0);

ALTER TABLE MONDOEDP.I072_FILTROANAGRAFE DROP PRIMARY KEY;
DROP INDEX MONDOEDP.I072_PK;
ALTER TABLE MONDOEDP.I072_FILTROANAGRAFE ADD AZIENDA VARCHAR2(30) DEFAULT 'AZIN';
ALTER TABLE MONDOEDP.I072_FILTROANAGRAFE ADD CONSTRAINT I072_PK PRIMARY KEY (AZIENDA,PROFILO,PROGRESSIVO)
USING INDEX TABLESPACE INDICI storage (initial 256K next 256K pctincrease 0);

ALTER TABLE MONDOEDP.I073_FILTROFUNZIONI DROP PRIMARY KEY;
DROP INDEX MONDOEDP.I073_PK;
ALTER TABLE MONDOEDP.I073_FILTROFUNZIONI ADD AZIENDA VARCHAR2(30) DEFAULT 'AZIN';
ALTER TABLE MONDOEDP.I073_FILTROFUNZIONI ADD CONSTRAINT I073_PK PRIMARY KEY (AZIENDA,PROFILO,APPLICAZIONE,TAG)
USING INDEX TABLESPACE INDICI storage (initial 256K next 256K pctincrease 0);

ALTER TABLE MONDOEDP.I074_FILTRODIZIONARIO DROP PRIMARY KEY;
DROP INDEX MONDOEDP.I074_PK;
ALTER TABLE MONDOEDP.I074_FILTRODIZIONARIO ADD AZIENDA VARCHAR2(30) DEFAULT 'AZIN';
ALTER TABLE MONDOEDP.I074_FILTRODIZIONARIO ADD CONSTRAINT I074_PK PRIMARY KEY (AZIENDA,PROFILO,TABELLA,CODICE)
USING INDEX TABLESPACE INDICI storage (initial 256K next 256K pctincrease 0);

DECLARE
  CURSOR C1 IS 
    SELECT I090.*
      FROM MONDOEDP.I090_ENTI I090 WHERE AZIENDA <> 'AZIN';
  CURSOR CI071 IS 
    SELECT I071.*
      FROM MONDOEDP.I071_PERMESSI I071 WHERE AZIENDA = 'AZIN';
  CURSOR CI072 IS 
    SELECT I072.*
      FROM MONDOEDP.I072_FILTROANAGRAFE I072 WHERE AZIENDA = 'AZIN';
  CURSOR CI073 IS 
    SELECT I073.*
      FROM MONDOEDP.I073_FILTROFUNZIONI I073 WHERE AZIENDA = 'AZIN';      
  CURSOR CI074 IS 
    SELECT I074.* 
      FROM MONDOEDP.I074_FILTRODIZIONARIO I074 WHERE AZIENDA = 'AZIN';            
  N INTEGER;
BEGIN
  FOR T1 IN C1 LOOP
    SELECT COUNT(*) INTO N FROM MONDOEDP.I071_PERMESSI WHERE AZIENDA = T1.AZIENDA;
    IF N = 0 THEN
      FOR T2 IN CI071 LOOP
        BEGIN
          INSERT INTO MONDOEDP.I071_PERMESSI
          (A029_CAUPRESENZA,A029_INDENNITA,A029_SALDI,A029_STRAORDINARIO,A058_NONOPERATIVA,A058_OPERATIVA,A094_ANNO,A094_MESE,A094_RAGGR,A131_ANTICIPIGESTIBILI,ABILITA_SCHEDE_CHIUSE,AZIENDA,C700_SALVASELEZIONI,CANCELLAZIONE_DATI,CANCELLA_TIMBRATURE,DEF_TIPO_PERSONALE,ELIMINA_DATA_CASSA,INSERIMENTO_MATRICOLE,LAYOUT,LIQUIDAZIONE_FORZATA,MOD_PERSONALE_ESTERNO,MONITOR_INTEGRANAGRA,PROFILO,RICREA_SCARICO_PAGHE,RIPRISTINO_TIMB_ORI,STORICIZZAZIONE,T100_CAUSALE,T100_ORA,T100_RILEVATORE)  
          VALUES
          (T2.A029_CAUPRESENZA,T2.A029_INDENNITA,T2.A029_SALDI,T2.A029_STRAORDINARIO,T2.A058_NONOPERATIVA,T2.A058_OPERATIVA,T2.A094_ANNO,T2.A094_MESE,T2.A094_RAGGR,T2.A131_ANTICIPIGESTIBILI,T2.ABILITA_SCHEDE_CHIUSE,       T1.AZIENDA,       T2.C700_SALVASELEZIONI,       T2.CANCELLAZIONE_DATI,       T2.CANCELLA_TIMBRATURE,       T2.DEF_TIPO_PERSONALE,       T2.ELIMINA_DATA_CASSA,       T2.INSERIMENTO_MATRICOLE,       T2.LAYOUT,       T2.LIQUIDAZIONE_FORZATA,       T2.MOD_PERSONALE_ESTERNO,       T2.MONITOR_INTEGRANAGRA,T2.PROFILO,T2.RICREA_SCARICO_PAGHE,T2.RIPRISTINO_TIMB_ORI,T2.STORICIZZAZIONE,T2.T100_CAUSALE,T2.T100_ORA,T2.T100_RILEVATORE);
        EXCEPTION
        WHEN OTHERS THEN
          NULL;
        END;
      END LOOP;
      COMMIT;
    END IF;

    SELECT COUNT(*) INTO N FROM MONDOEDP.I072_FILTROANAGRAFE WHERE AZIENDA = T1.AZIENDA;
    IF N = 0 THEN
      FOR T2 IN CI072 LOOP
        BEGIN
          INSERT INTO MONDOEDP.I072_FILTROANAGRAFE(PROFILO,PROGRESSIVO,FILTRO,AZIENDA)
          VALUES(T2.PROFILO,T2.PROGRESSIVO,T2.FILTRO,T1.AZIENDA);
        EXCEPTION
        WHEN OTHERS THEN
          NULL;
        END;
      END LOOP;
      COMMIT;
    END IF;

    SELECT COUNT(*) INTO N FROM MONDOEDP.I073_FILTROFUNZIONI WHERE AZIENDA = T1.AZIENDA;
    IF N = 0 THEN
      FOR T2 IN CI073 LOOP
        BEGIN
          INSERT INTO MONDOEDP.I073_FILTROFUNZIONI(PROFILO,APPLICAZIONE,TAG,FUNZIONE,GRUPPO,DESCRIZIONE,INIBIZIONE,AZIENDA)
          VALUES(T2.PROFILO,T2.APPLICAZIONE,T2.TAG,T2.FUNZIONE,T2.GRUPPO,T2.DESCRIZIONE,T2.INIBIZIONE,T1.AZIENDA);
        EXCEPTION
        WHEN OTHERS THEN
          NULL;
        END;
      END LOOP;
      COMMIT;
    END IF;
    
    SELECT COUNT(*) INTO N FROM MONDOEDP.I074_FILTRODIZIONARIO WHERE AZIENDA = T1.AZIENDA;
    IF N = 0 THEN
      FOR T2 IN CI074 LOOP
        BEGIN
          INSERT INTO MONDOEDP.I074_FILTRODIZIONARIO(PROFILO,TABELLA,CODICE,ABILITATO,AZIENDA)
          VALUES(T2.PROFILO,T2.TABELLA,T2.CODICE,T2.ABILITATO,T1.AZIENDA);
        EXCEPTION
        WHEN OTHERS THEN
          NULL;
        END;           
      END LOOP;
      COMMIT;
    END IF;
    
  END LOOP;
END;
/

alter table T025_CONTMENSILI add DEBAGG_RAPP_ANNO varchar2(1) default 'N';
comment on column T025_CONTMENSILI.DEBAGG_RAPP_ANNO is 'S=Debito rapportato all''anno - N=Debito rapportato al mese'; 
alter table T025_CONTMENSILI add DEBAGG_CONSIDERA_OREPREC varchar2(1) default 'N';
comment on column T025_CONTMENSILI.DEBAGG_CONSIDERA_OREPREC is 'S=Ore prec. rendono il deb.aggiuntivo - N=Ore prec. non rendono il deb.aggiuntivo'; 

update T033_LAYOUT set CAPTION = 'Debito aggiuntivo' where CAPTION = 'Categoria di Plus orario';

alter table P500_CUDSETUP modify CODICE_ATTIVITA VARCHAR2(6);

alter table T002_QUERYPERSONALIZZATE add APPLICAZIONE varchar2(6);
update T002_QUERYPERSONALIZZATE set APPLICAZIONE = 'RILPRE' where APPLICAZIONE is null;
alter table T002_QUERYPERSONALIZZATE drop primary key;
alter table T002_QUERYPERSONALIZZATE add constraint T002_PK primary key (APPLICAZIONE,NOME,POSIZ)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
update T002_QUERYPERSONALIZZATE set APPLICAZIONE = 'PAGHE' where UPPER(NOME) LIKE 'PA_%';

alter table P030_VALUTE add DECORRENZA_FINE date;
update P030_VALUTE t set
    DECORRENZA_FINE =
    (select min(DECORRENZA) - 1 from P030_VALUTE where COD_VALUTA = t.COD_VALUTA and DECORRENZA > t.DECORRENZA)
  where
    DECORRENZA < (select max(DECORRENZA) from P030_VALUTE where COD_VALUTA = t.COD_VALUTA);
update P030_VALUTE t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where
    DECORRENZA = (select max(DECORRENZA) from P030_VALUTE where COD_VALUTA = t.COD_VALUTA);

-- Create/Recreate indexes 
create index P605_PARTE_NUMERO on P605_770DATIINDIVIDUALI (PARTE, NUMERO)
  tablespace INDICI storage (initial 256K next 512K pctincrease 0);

alter table T430_STORICO add QUALIFICAMINIST varchar2(10);
alter table T430_STORICO add TIPO_LOCALITA_DIST_LAVORO varchar2(1) default 'C';
alter table T430_STORICO add COD_LOCALITA_DIST_LAVORO varchar2(6);
create table T470_QUALIFICAMINIST (
  CODICE varchar2(10),
  DESCRIZIONE varchar2(100),
  PROGRESSIVOQM number(8),
  DEBITOGGQM varchar2(5),
  MACRO_CATEG_QM varchar2(10)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T470_QUALIFICAMINIST add constraint T470_PK primary key (CODICE) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T033_LAYOUT modify CAMPODB varchar2(40);
insert into t033_layout
  (nome, top, lft, caption, accesso, nomepagina, campodb)
select distinct 
  nome, 126, 8, 'Qualifica ministeriale', 'N', 'Presenze/Assenze', 'QUALIFICAMINIST'
from T033_LAYOUT;

insert into t033_layout
  (nome, top, lft, caption, accesso, nomepagina, campodb)
select distinct 
  nome, 163, 8, 'Tipo localit�', 'N', 'Presenze/Assenze', 'TIPO_LOCALITA_DIST_LAVORO'
from T033_LAYOUT;

insert into t033_layout
  (nome, top, lft, caption, accesso, nomepagina, campodb)
select distinct 
  nome, 171, 170, 'Localit�', 'N', 'Presenze/Assenze', 'COD_LOCALITA_DIST_LAVORO'
from T033_LAYOUT;

