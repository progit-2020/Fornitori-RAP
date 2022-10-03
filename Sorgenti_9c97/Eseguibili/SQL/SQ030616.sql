UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.5.1' WHERE AZIENDA = :AZIENDA;

ALTER TABLE T130_RESIDANNOPREC ADD BANCA_ORE VARCHAR2(7);

ALTER TABLE T025_CONTMENSILI ADD BANCAORE_RESID VARCHAR2(1) DEFAULT 'N';

ALTER TABLE I010_CAMPIANAGRAFICI MODIFY VAL_DEFAULT VARCHAR2(50);

ALTER TABLE T909_DATICALCOLATI MODIFY ESPRESSIONE VARCHAR2(2000);
ALTER TABLE T914_SERBATOIFILTRO MODIFY FILTRO VARCHAR2(2000);
UPDATE T931_TRACCIATOESTRAZIONISTAMPE SET SOMMA_RICORRENZE = 'CUMULA STORICO' WHERE SOMMA_RICORRENZE = 'SOMMA SE TOT = 0';

CREATE OR REPLACE FUNCTION MINUTIORE (MINUTI IN INTEGER) RETURN VARCHAR2 AS
  HH VARCHAR2(20);
BEGIN
  HH:=NULL;
  IF MINUTI IS NOT NULL THEN
    HH:=TRUNC(ABS(MINUTI)/60) || '.' || LPAD(MOD(ABS(MINUTI),60),2,'0');
    IF MINUTI < 0 THEN
      HH:='-' || HH;
    END IF;
  END IF;
  RETURN HH; 
END;
/

RENAME T020_OLD TO T020_2117;
RENAME T020_ORARI TO T020_OLD;
ALTER TABLE T020_OLD DROP PRIMARY KEY;
UPDATE T020_OLD SET perlav = 'L' WHERE perlav IS NULL AND tipoora = 'D';

create table T020_ORARI
(
  CODICE                VARCHAR2(5) not null,
  DECORRENZA            DATE,
  DESCRIZIONE           VARCHAR2(40),
  TIPOORA               VARCHAR2(1) DEFAULT 'A' not null ,
  PERLAV                VARCHAR2(2) DEFAULT 'C' not null ,
  TIPOFLE               VARCHAR2(1) DEFAULT 'A',
  OBBLFAC               VARCHAR2(1) DEFAULT 'O',
  ORETEOR               VARCHAR2(5),
  OREMIN                VARCHAR2(5),
  OREMAX                VARCHAR2(5),
  COMPDETR              VARCHAR2(1) DEFAULT 'N',
  ARRFUOENT             VARCHAR2(5),
  ARRFUOUSC             VARCHAR2(5),
  ARRPOS                VARCHAR2(5),
  ARRNEG                VARCHAR2(5),
  TOLLPRES              VARCHAR2(5),
  MMINDPRES             VARCHAR2(5),
  FLAGPRES              VARCHAR2(1) DEFAULT 'N',
  COMPNOT               VARCHAR2(1) DEFAULT 'E',
  MMINDMPRES            VARCHAR2(5),
  FLAGMPRES             VARCHAR2(1) DEFAULT 'N',
  FRAZDEB               VARCHAR2(1) DEFAULT 'N',
  NOTTEENTRATA          VARCHAR2(1) DEFAULT 'N',
  MIN_USCITA_NOTTE      VARCHAR2(5),
  INDFESTIVA            VARCHAR2(1) DEFAULT 'N',
  OREINDFEST            VARCHAR2(5),
  INDTURNO              VARCHAR2(1) DEFAULT 'N',
  MATURA_RIPCOM         VARCHAR2(1) DEFAULT 'N',
  TIPOMENSA             VARCHAR2(1) DEFAULT 'Z' not null,
  CAUOBFAC              VARCHAR2(1) DEFAULT 'F',
  MMMINIMI              VARCHAR2(5),
  MINPERCORR            VARCHAR2(5),
  TIMBRATURAMENSA       VARCHAR2(1) DEFAULT 'N',
  INTERSEZIONEMENSA     VARCHAR2(1) DEFAULT 'N',
  PAUSAMENSA_AUTOMATICA VARCHAR2(5),
  PM_AUTO_URIT          VARCHAR2(1) DEFAULT 'N',
  DETRAUTCONT           VARCHAR2(1) DEFAULT 'S',
  RIENTRO_MINIMO        VARCHAR2(5),
  COMPFASCIA            VARCHAR2(1) DEFAULT '1' not null,
  TUTTOCOMP             VARCHAR2(1) DEFAULT 'N',
  MINSCOSTR             VARCHAR2(5),
  ORAMAX_COMPENSABILE   VARCHAR2(5),
  ARRSCOSTR             VARCHAR2(5),
  ARRSCOSTR_COMP        VARCHAR2(1) DEFAULT 'S',
  COMPLIQ               VARCHAR2(1) DEFAULT 'N',
  MINIMISTR             VARCHAR2(5),
  ARRIVRANG             VARCHAR2(5),
  MINGIOSTR             VARCHAR2(5),
  ARROTGIOR             VARCHAR2(5),
  MAXGIOSTR             VARCHAR2(5),
  INTERUSC              VARCHAR2(5),
  STR_DOPO_HHMAX        VARCHAR2(1) DEFAULT 'N',
  INDPRESSTR            VARCHAR2(1) DEFAULT '2',
  INDFESTSTR            VARCHAR2(1) DEFAULT '2',
  INDNOTSTR             VARCHAR2(1) DEFAULT '2'
) 
STORAGE (INITIAL 128K NEXT 128K PCTINCREASE 0) 
TABLESPACE LAVORO;

ALTER TABLE T020_ORARI ADD CONSTRAINT T020_PK PRIMARY KEY(CODICE,DECORRENZA) 
USING INDEX 
STORAGE (INITIAL 32K NEXT 32K PCTINCREASE 0) 
TABLESPACE INDICI;

INSERT INTO T020_ORARI 
(codice, 
decorrenza, 
descrizione, 
tipoora, 
perlav, 
tipofle, 
obblfac, 
oreteor, 
oremin, 
oremax, 
compdetr, 
arrfuoent, 
arrfuousc, 
arrpos, 
arrneg, 
tollpres, 
mmindpres, 
flagpres, 
compnot, 
mmindmpres, 
flagmpres, 
frazdeb, 
notteentrata, 
min_uscita_notte, 
indfestiva, 
oreindfest, 
indturno, 
matura_ripcom, 
tipomensa, 
cauobfac, 
mmminimi, 
minpercorr, 
timbraturamensa, 
intersezionemensa, 
pausamensa_automatica, 
pm_auto_urit, 
detrautcont, 
rientro_minimo, 
compfascia, 
tuttocomp, 
minscostr, 
oramax_compensabile, 
arrscostr, 
arrscostr_comp, 
compliq, 
minimistr, 
arrivrang, 
mingiostr, 
arrotgior, 
maxgiostr, 
interusc, 
str_dopo_hhmax, 
indpresstr, 
indfeststr, 
indnotstr)
SELECT 
codice,
to_date('01011900','ddmmyyyy'),
descrizione,
tipoora,
perlav,
tipofle,
obblfac1,
decode(tipoora,'C',to_char(oreteor,'hh24.mi'),'E',null,to_char(hmteorici,'hh24.mi')) oreteor,
to_char(oremin,'hh24.mi'),
to_char(oremax,'hh24.mi'),
compdetr,
minutiore(arrfuoent),
minutiore(arrfuousc),
minutiore(arrpos),
minutiore(arrneg),
minutiore(tollpres),
to_char(mmindpres,'hh24.mi'),
flagpres,
compnot,
to_char(mmindmpres,'hh24.mi'),
flagmpres,
frazdeb,
notteentrata,
min_uscita_notte,
indfestiva,
to_char(oreindfest,'hh24.mi'),
indturno,
matura_ripcom,
decode(pausamensa,'N','Z',tipomensa),
cauobfac,
minutiore(mmminimi),
minutiore(minpercorr),
timbraturamensa,
intersezionemensa,
minutiore(pausamensa_automatica),
pm_auto_urit,
detrautcont,
rientro_minimo,
compfascia,
tuttocomp,
minutiore(minscostr),
oramax_compensabile,
minutiore(arrscostr),
arrscostr_comp,
compliq,
minutiore(minimistr),
minutiore(arrivrang),
minutiore(mingiostr),
minutiore(arrotgior),
to_char(maxgiostr,'hh24.mi'),
minutiore(interusc),
str_dopo_hhmax,
indpresstr,
indfeststr,
indnotstr
FROM T020_OLD;  

create table T021_FASCEORARI
(
  CODICE       VARCHAR2(5) not null,
  DECORRENZA   DATE,
  TIPO_FASCIA  VARCHAR2(3),
  ENTRATA      VARCHAR2(5),
  USCITA       VARCHAR2(5),
  MMANTICIPO   VARCHAR2(5),
  MMANTICIPOU  VARCHAR2(5),
  TOLLERANZA   VARCHAR2(5),
  TOLLERANZAU  VARCHAR2(5),
  ARRFLESFASC  VARCHAR2(5),
  ARRFLESFASCU VARCHAR2(5),
  MMRITARDO    VARCHAR2(5),
  MMRITARDOU   VARCHAR2(5),
  MMARROTOND   VARCHAR2(5),
  MMARROTONDU  VARCHAR2(5),
  ARRRITARDO   VARCHAR2(5),
  ARRUSCANT    VARCHAR2(5),
  SCOST_PUNTI_NOMINALI_E VARCHAR2(5),
  SCOST_PUNTI_NOMINALI_U VARCHAR2(5),
  MMFLEX       VARCHAR2(5),
  ORETEOTUR    VARCHAR2(5),
  SIGLATURNI   VARCHAR2(2),
  NUMTURNO     NUMBER(1),
  OREMINIME    VARCHAR2(5)
)
STORAGE (INITIAL 64K NEXT 64K PCTINCREASE 0) 
TABLESPACE LAVORO;

ALTER TABLE T021_FASCEORARI ADD CONSTRAINT T021_PK PRIMARY KEY(CODICE,DECORRENZA,TIPO_FASCIA,ENTRATA,USCITA) 
USING INDEX 
STORAGE (INITIAL 32K NEXT 32K PCTINCREASE 0) 
TABLESPACE INDICI;

alter table T021_FASCEORARI
  add constraint T021_FK_T020 foreign key (CODICE,DECORRENZA)
  references T020_ORARI (CODICE,DECORRENZA) on delete cascade;

COMMENT ON COLUMN T021_FASCEORARI.TIPO_FASCIA IS
  'PN=Punti Nominali - PMA=Pausa Mensa Automatica - PMT=Pausa Mensa Timbrata - STR=Straordinario ';

INSERT INTO T021_FASCEORARI 
  (CODICE,DECORRENZA,TIPO_FASCIA,ENTRATA,USCITA,MMANTICIPO,MMANTICIPOU,TOLLERANZA,TOLLERANZAU,
   ARRFLESFASC,ARRFLESFASCU,MMRITARDO,MMRITARDOU,MMARROTOND,MMARROTONDU,ARRRITARDO,ARRUSCANT,
   SCOST_PUNTI_NOMINALI_E,SCOST_PUNTI_NOMINALI_U,MMFLEX,ORETEOTUR,SIGLATURNI,NUMTURNO)
SELECT 
  codice,
  to_date('01011900','ddmmyyyy'),
  'PN' tipo_fascia,
  to_char(ENTRATA1,'hh24.mi'),
  decode(uscita1,null,'00.00',to_char(uscita1,'hh24.mi')) uscita,
  minutiore(MMANTICIPO1),minutiore(MMANTICIPOU1),
  minutiore(TOLLERANZA1),minutiore(TOLLERANZAU1),
  minutiore(ARRFLESFASC1),minutiore(ARRFLESFASCU1),
  minutiore(MMRITARDO1),minutiore(MMRITARDOU1),
  minutiore(MMARROTOND1),minutiore(MMARROTONDU1),
  minutiore(ARRRITARDO1),minutiore(ARRUSCANT1),
  minutiore(SCOST_PUNTI_NOMINALI),minutiore(SCOST_PUNTI_NOMINALI),
  decode(tipoora,'E',minutiore(mmflturno),minutiore(MMENT1)) mmflex,
  to_char(ORETEOTUR1,'hh24.mi'),
  SIGLATURNI1,NUMTURNO1
FROM T020_OLD
WHERE ENTRATA1 IS NOT NULL;

INSERT INTO T021_FASCEORARI
  (CODICE,DECORRENZA,TIPO_FASCIA,ENTRATA,USCITA,MMANTICIPO,MMANTICIPOU,TOLLERANZA,TOLLERANZAU,
   ARRFLESFASC,ARRFLESFASCU,MMRITARDO,MMRITARDOU,MMARROTOND,MMARROTONDU,ARRRITARDO,ARRUSCANT,
   SCOST_PUNTI_NOMINALI_E,SCOST_PUNTI_NOMINALI_U,MMFLEX,ORETEOTUR,SIGLATURNI,NUMTURNO)
SELECT 
  codice,
  to_date('01011900','ddmmyyyy'),
  'PN' tipo_fascia,
  to_char(ENTRATA2,'hh24.mi'),
  decode(uscita2,null,'00.00',to_char(uscita2,'hh24.mi')) uscita,
  minutiore(MMANTICIPO2),minutiore(MMANTICIPOU2),
  minutiore(TOLLERANZA2),minutiore(TOLLERANZAU2),
  minutiore(ARRFLESFASC2),minutiore(ARRFLESFASCU2),
  minutiore(MMRITARDO2),minutiore(MMRITARDOU2),
  minutiore(MMARROTOND2),minutiore(MMARROTONDU2),
  minutiore(ARRRITARDO2),minutiore(ARRUSCANT2),
  minutiore(SCOST_PUNTI_NOMINALI),minutiore(SCOST_PUNTI_NOMINALI),
  decode(tipoora,'E',minutiore(mmflturno),minutiore(MMENT2)) mmflex,
  to_char(ORETEOTUR2,'hh24.mi'),
  SIGLATURNI2,NUMTURNO2
FROM T020_OLD T020
WHERE ENTRATA2 IS NOT NULL AND TIPOORA <> 'C' 
AND NOT EXISTS(SELECT 'X' FROM T021_FASCEORARI WHERE CODICE = T020.CODICE AND ENTRATA = TO_CHAR(ENTRATA2,'hh24.mi') AND USCITA = TO_CHAR(USCITA2,'hh24.mi')); 

INSERT INTO T021_FASCEORARI 
  (CODICE,DECORRENZA,TIPO_FASCIA,ENTRATA,USCITA,MMANTICIPO,MMANTICIPOU,TOLLERANZA,TOLLERANZAU,
   ARRFLESFASC,ARRFLESFASCU,MMRITARDO,MMRITARDOU,MMARROTOND,MMARROTONDU,ARRRITARDO,ARRUSCANT,
   SCOST_PUNTI_NOMINALI_E,SCOST_PUNTI_NOMINALI_U,MMFLEX,ORETEOTUR,SIGLATURNI,NUMTURNO)
SELECT 
  codice,
  to_date('01011900','ddmmyyyy'),
  'PN' tipo_fascia,
  to_char(ENTRATA3,'hh24.mi'),
  decode(uscita3,null,'00.00',to_char(uscita3,'hh24.mi')) uscita,
  minutiore(MMANTICIPO3),minutiore(MMANTICIPOU3),
  minutiore(TOLLERANZA3),minutiore(TOLLERANZAU3),
  minutiore(ARRFLESFASC3),minutiore(ARRFLESFASCU3),
  minutiore(MMRITARDO3),minutiore(MMRITARDOU3),
  minutiore(MMARROTOND3),minutiore(MMARROTONDU3),
  minutiore(ARRRITARDO3),minutiore(ARRUSCANT3),
  minutiore(SCOST_PUNTI_NOMINALI),minutiore(SCOST_PUNTI_NOMINALI),
  decode(tipoora,'E',minutiore(mmflturno),null) mmflex,
  to_char(ORETEOTUR3,'hh24.mi'),
  SIGLATURNI3,NUMTURNO3
FROM T020_OLD T020
WHERE ENTRATA3 IS NOT NULL
AND NOT EXISTS(SELECT 'X' FROM T021_FASCEORARI WHERE CODICE = T020.CODICE AND ENTRATA = TO_CHAR(ENTRATA3,'hh24.mi') AND USCITA = TO_CHAR(USCITA3,'hh24.mi')); 

INSERT INTO T021_FASCEORARI 
  (CODICE,DECORRENZA,TIPO_FASCIA,ENTRATA,USCITA,MMANTICIPO,MMANTICIPOU,TOLLERANZA,TOLLERANZAU,
   ARRFLESFASC,ARRFLESFASCU,MMRITARDO,MMRITARDOU,MMARROTOND,MMARROTONDU,ARRRITARDO,ARRUSCANT,
   SCOST_PUNTI_NOMINALI_E,SCOST_PUNTI_NOMINALI_U,MMFLEX,ORETEOTUR,SIGLATURNI,NUMTURNO)
SELECT 
  codice,
  to_date('01011900','ddmmyyyy'),
  'PN' tipo_fascia,
  to_char(ENTRATA4,'hh24.mi'),
  decode(uscita4,null,'00.00',to_char(uscita4,'hh24.mi')) uscita,
  minutiore(MMANTICIPO4),minutiore(MMANTICIPOU4),
  minutiore(TOLLERANZA4),minutiore(TOLLERANZAU4),
  minutiore(ARRFLESFASC4),minutiore(ARRFLESFASCU4),
  minutiore(MMRITARDO4),minutiore(MMRITARDOU4),
  minutiore(MMARROTOND4),minutiore(MMARROTONDU4),
  minutiore(ARRRITARDO4),minutiore(ARRUSCANT4),
  minutiore(SCOST_PUNTI_NOMINALI),minutiore(SCOST_PUNTI_NOMINALI),
  decode(tipoora,'E',minutiore(mmflturno),null) mmflex,
  to_char(ORETEOTUR4,'hh24.mi'),
  SIGLATURNI4,NUMTURNO4
FROM T020_OLD T020
WHERE ENTRATA4 IS NOT NULL
AND NOT EXISTS(SELECT 'X' FROM T021_FASCEORARI WHERE CODICE = T020.CODICE AND ENTRATA = TO_CHAR(ENTRATA4,'hh24.mi') AND USCITA = TO_CHAR(USCITA4,'hh24.mi')); 

--Pausa mensa timbrata
INSERT INTO T021_FASCEORARI (codice,decorrenza,tipo_fascia,entrata,uscita,mmarrotond,mmarrotondu,mmritardo,mmanticipou) SELECT 
 codice,
 to_date('01011900','ddmmyyyy'),
 'PMT' tipo_fascia,
 to_char(inizminimo,'hh24.mi'),
 to_char(finemax,'hh24.mi'),
 minutiore(arrotmensa),
 minutiore(arrotmensa),
 to_char(inizmax,'hh24.mi'),
 to_char(fineminimo,'hh24.mi')
FROM T020_OLD
WHERE INIZMINIMO IS NOT NULL AND PAUSAMENSA = 'S';

--inizfascia,finefascia: Pausa mensa automatica
INSERT INTO T021_FASCEORARI (codice,decorrenza,tipo_fascia,entrata,uscita,oreminime) SELECT 
 codice,
 to_date('01011900','ddmmyyyy'),
 'PMA' tipo_fascia,
 to_char(nvl(inizfascia,to_date('010119001130','ddmmyyyyhh24mi')),'hh24.mi'),
 to_char(nvl(finefascia,to_date('010119001530','ddmmyyyyhh24mi')),'hh24.mi'),
 to_char(hhmmdetraz,'hh24.mi')
FROM T020_OLD
WHERE ((INIZFASCIA IS NOT NULL) OR (hhmmdetraz IS NOT NULL) OR (PM_AUTO_URIT = 'S')) 
  AND PAUSAMENSA = 'S' AND TIPOMENSA IN ('C','D','E','F');

--iniziostr,finestr 1: 1° fascia di straordinario
INSERT INTO T021_FASCEORARI (codice,decorrenza,tipo_fascia,entrata,uscita) SELECT 
 codice,
 to_date('01011900','ddmmyyyy'),
 'STR' tipo_fascia,
 to_char(iniziostr1,'hh24.mi'),
 to_char(finestr1,'hh24.mi')
FROM T020_OLD
WHERE INIZIOSTR1 IS NOT NULL;

--iniziostr,finestr 2: 2° fascia di straordinario
INSERT INTO T021_FASCEORARI (codice,decorrenza,tipo_fascia,entrata,uscita) SELECT 
 codice,
 to_date('01011900','ddmmyyyy'),
 'STR' tipo_fascia,
 to_char(iniziostr2,'hh24.mi'),
 to_char(finestr2,'hh24.mi')
FROM T020_OLD
WHERE INIZIOSTR2 IS NOT NULL;

UPDATE MONDOEDP.I073_FILTROFUNZIONI SET FUNZIONE = 'OpenA006ModelliOrario' where tag = 103;
