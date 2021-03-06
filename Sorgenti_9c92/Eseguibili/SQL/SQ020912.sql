UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.4.5' WHERE AZIENDA = :AZIENDA;

ALTER TABLE T260_RAGGRASSENZE MODIFY CODINTERNO DEFAULT 'Z';
ALTER TABLE T260_RAGGRASSENZE MODIFY CONTASOLARE DEFAULT 'N';
ALTER TABLE T260_RAGGRASSENZE MODIFY RESIDUABILE DEFAULT 'N';

ALTER TABLE T080_PIANIFORARI ADD DATOLIBERO VARCHAR2(20);

ALTER TABLE T380_PIANIFREPERIB ADD DATOLIBERO VARCHAR2(20);

UPDATE T072_SCHEDAINDPRES SET INDPRES = REPLACE(INDPRES,'.',',');
UPDATE T262_PROFASSANN SET 
    COMPETENZA1 = REPLACE(COMPETENZA1,'.',','),
    COMPETENZA2 = REPLACE(COMPETENZA2,'.',','),
    COMPETENZA3 = REPLACE(COMPETENZA3,'.',','),
    COMPETENZA4 = REPLACE(COMPETENZA4,'.',','),
    COMPETENZA5 = REPLACE(COMPETENZA5,'.',','),
    COMPETENZA6 = REPLACE(COMPETENZA6,'.',',')
  WHERE UMISURA = 'G';
UPDATE T263_PROFASSIND SET 
    COMPETENZA1 = REPLACE(COMPETENZA1,'.',','),
    COMPETENZA2 = REPLACE(COMPETENZA2,'.',','),
    COMPETENZA3 = REPLACE(COMPETENZA3,'.',','),
    COMPETENZA4 = REPLACE(COMPETENZA4,'.',','),
    COMPETENZA5 = REPLACE(COMPETENZA5,'.',','),
    COMPETENZA6 = REPLACE(COMPETENZA6,'.',','),
    DECURTAZIONE = REPLACE(DECURTAZIONE,'.',',')
  WHERE UMISURA = 'G';
DECLARE
  CURSOR C1 IS 
    SELECT T264.ROWID,T264.PROGRESSIVO,T264.ANNO,T264.CODRAGGR,T260.CONTASOLARE,T265.UMISURA UMT265,T263.UMISURA UMT263 FROM 
      T264_RESIDASSANN T264,
      T260_RAGGRASSENZE T260,
      T265_CAUASSENZE T265,
      T263_PROFASSIND T263
    WHERE
      T264.CODRAGGR = T260.CODICE AND
      T265.CODICE = (SELECT MIN(CODICE) FROM T265_CAUASSENZE WHERE CODRAGGR = T264.CODRAGGR) AND
      T264.CODRAGGR = T263.CODRAGGR(+) AND
      T264.ANNO = T263.ANNO(+) AND
      T264.PROGRESSIVO = T263.PROGRESSIVO(+);
  UM VARCHAR2(1);
  BEGIN 
    FOR T1 IN C1 LOOP
      UM:=NULL;
      IF T1.CONTASOLARE = 'N' THEN
        UM:=T1.UMT265;
      ELSIF NOT (T1.UMT263 IS NULL) THEN
        UM:=T1.UMT263;
      ELSE
        BEGIN
          SELECT UMISURA INTO UM FROM T262_PROFASSANN WHERE
            ANNO = T1.ANNO - 1 AND
            CODRAGGR = T1.CODRAGGR AND
            CODPROFILO = (SELECT PASSENZE FROM T430_STORICO WHERE 
                          PROGRESSIVO = T1.PROGRESSIVO AND (TO_DATE('0101'||LPAD(T1.ANNO,4,'0'),'DDMMYYYY') - 1) BETWEEN DATADECORRENZA AND DATAFINE);
        EXCEPTION
          WHEN OTHERS THEN
            UM:=T1.UMT265;
        END;  
      END IF;
      IF UM = 'G' THEN
        UPDATE T264_RESIDASSANN SET 
          RESIDUO1 = REPLACE(RESIDUO1,'.',','),
          RESIDUO2 = REPLACE(RESIDUO2,'.',','),
          RESIDUO3 = REPLACE(RESIDUO3,'.',','),
          RESIDUO4 = REPLACE(RESIDUO4,'.',','),
          RESIDUO5 = REPLACE(RESIDUO5,'.',','),
          RESIDUO6 = REPLACE(RESIDUO6,'.',',')
        WHERE PROGRESSIVO = T1.PROGRESSIVO AND
              ANNO = T1.ANNO AND
              CODRAGGR = T1.CODRAGGR;
        COMMIT;
      END IF;
    END LOOP;
  END;
/
UPDATE T265_CAUASSENZE SET 
    COMPETENZA1 = REPLACE(COMPETENZA1,'.',','),
    COMPETENZA2 = REPLACE(COMPETENZA2,'.',','),
    COMPETENZA3 = REPLACE(COMPETENZA3,'.',','),
    COMPETENZA4 = REPLACE(COMPETENZA4,'.',','),
    COMPETENZA5 = REPLACE(COMPETENZA5,'.',','),
    COMPETENZA6 = REPLACE(COMPETENZA6,'.',',')
  WHERE UMISURA = 'G';
UPDATE T265_CAUASSENZE SET GMAXUNITARIO = REPLACE(GMAXUNITARIO,'.',',');

SELECT CODICE FROM T191_PARPAGHE WHERE PRECISIONE = '2' AND TIPOFILE <> 'T';

ALTER TABLE T670_REGOLEBUONI MODIFY PASTO_TICKET DEFAULT 'B';
ALTER TABLE T670_REGOLEBUONI MODIFY NONLAVORATIVO DEFAULT 'N';
ALTER TABLE T670_REGOLEBUONI MODIFY ORARISPEZZATI DEFAULT 'N';
ALTER TABLE T670_REGOLEBUONI MODIFY OREMINIME DEFAULT TO_DATE('01011900','DDMMYYYY');
ALTER TABLE T670_REGOLEBUONI MODIFY MISSIONI DEFAULT 'N';
ALTER TABLE T670_REGOLEBUONI MODIFY ACCESSI_MENSA DEFAULT 'N';
UPDATE T670_REGOLEBUONI SET MISSIONI = DECODE(MISSIONI,'S','N','N','S'), ACCESSI_MENSA = DECODE(ACCESSI_MENSA,'S','N','N','S');

ALTER TABLE T910_RIEPILOGO ADD STAMPA_TITOLO VARCHAR2(1) DEFAULT 'S';
ALTER TABLE T910_RIEPILOGO ADD STAMPA_AZIENDA VARCHAR2(1) DEFAULT 'S';
ALTER TABLE T910_RIEPILOGO ADD STAMPA_PERIODO VARCHAR2(1) DEFAULT 'S';
ALTER TABLE T910_RIEPILOGO ADD STAMPA_NUMPAG VARCHAR2(1) DEFAULT 'S';
ALTER TABLE T910_RIEPILOGO ADD STAMPA_DATA VARCHAR2(1) DEFAULT 'S';
ALTER TABLE T910_RIEPILOGO ADD FORMATO_PAGINA VARCHAR2(3);
ALTER TABLE T910_RIEPILOGO ADD ORIENTAMENTO_PAGINA VARCHAR2(1);

create table T277_CAUFASCEABILITATE
(
  CODICE      VARCHAR2(5) not null,
  TIPO_GIORNO VARCHAR2(1) not null,
  DALLE       VARCHAR2(5) not null,
  ALLE        VARCHAR2(5)
)
tablespace LAVORO
  pctfree 10 pctused 70
  storage (initial 32K next 64K minextents 1 pctincrease 0);

alter table T277_CAUFASCEABILITATE
  add constraint T277_PK primary key (CODICE,TIPO_GIORNO,DALLE)
  using index 
  tablespace INDICI
  pctfree 10
  storage (initial 320K next 64K minextents 1 pctincrease 0);

ALTER TABLE T025_CONTMENSILI MODIFY CARTELLINO DEFAULT 'M';
ALTER TABLE T025_CONTMENSILI MODIFY ISTITUTI DEFAULT 'M';
ALTER TABLE T025_CONTMENSILI MODIFY CONTEGGIO DEFAULT 1;
ALTER TABLE T025_CONTMENSILI MODIFY COMPPREC DEFAULT 1;
ALTER TABLE T025_CONTMENSILI MODIFY LIQPREC DEFAULT 2;
ALTER TABLE T025_CONTMENSILI MODIFY COMPATT DEFAULT 3;
ALTER TABLE T025_CONTMENSILI MODIFY LIQATT DEFAULT 0;
ALTER TABLE T025_CONTMENSILI MODIFY INDENNITA DEFAULT '0';
ALTER TABLE T025_CONTMENSILI MODIFY INDPRESENZA DEFAULT '0';
ALTER TABLE T025_CONTMENSILI MODIFY LIQUIDDISTRIBUITA DEFAULT 'S';

create table T164_ASSOCIAZIONIINDENNITA
(
  CODICE      VARCHAR2(5) not null,
  DECORRENZA  DATE not null,
  ESPRESSIONE VARCHAR2(1000)
)
tablespace LAVORO
  pctfree 10 pctused 70
  storage (initial 32K next 64K minextents 1 pctincrease 0);

alter table T164_ASSOCIAZIONIINDENNITA
  add constraint T164_PK primary key (CODICE,DECORRENZA)
  using index 
  tablespace INDICI
  pctfree 10
  storage (initial 320K next 64K minextents 1 pctincrease 0);

ALTER TABLE T350_REGREPERIB ADD VP_TURNO VARCHAR2(6) DEFAULT '<SI>' not null;
ALTER TABLE T350_REGREPERIB ADD VP_ORE VARCHAR2(6) DEFAULT '<SI>' not null;
ALTER TABLE T350_REGREPERIB ADD VP_MAGGIORATE VARCHAR2(6) DEFAULT '<SI>' not null;
ALTER TABLE T350_REGREPERIB ADD VP_NONMAGGIORATE VARCHAR2(6) DEFAULT '<SI>' not null;
ALTER TABLE T350_REGREPERIB ADD TURNO_INTERO VARCHAR2(5);

ALTER TABLE T340_TURNIREPERIB DROP CONSTRAINT T340_PK;
RENAME T340_TURNIREPERIB TO T340_TURNIREPERIB_OLD;

CREATE TABLE T340_TURNIREPERIB AS 
SELECT * FROM T340_TURNIREPERIB_OLD;

ALTER TABLE T340_TURNIREPERIB ADD VP_TURNO VARCHAR2(6) DEFAULT '<SI>' not null;
ALTER TABLE T340_TURNIREPERIB ADD VP_ORE VARCHAR2(6) DEFAULT '<SI>' not null;
ALTER TABLE T340_TURNIREPERIB ADD VP_MAGGIORATE VARCHAR2(6) DEFAULT '<SI>' not null;
ALTER TABLE T340_TURNIREPERIB ADD VP_NONMAGGIORATE VARCHAR2(6) DEFAULT '<SI>' not null;

alter table T340_TURNIREPERIB
  add constraint T340_PK primary key (PROGRESSIVO,ANNO,MESE,VP_TURNO,VP_ORE,VP_MAGGIORATE,VP_NONMAGGIORATE)
  using index 
  tablespace INDICI
  pctfree 10
  storage (initial 32K next 256K minextents 1 pctincrease 0);

