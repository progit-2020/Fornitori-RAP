UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.5.1' WHERE AZIENDA = :AZIENDA;

alter table T275_CAUPRESENZE
  add constraint T275_FK_T265 foreign key (LINK_ASSENZA)
  references T265_CAUASSENZE (CODICE);

ALTER TABLE T275_CAUPRESENZE ADD COMPETENZE_AUTOGIUST VARCHAR2(1) DEFAULT 'N';

ALTER TABLE T275_CAUPRESENZE ADD ESCLUSIONE_FASCIA_OBB VARCHAR2(1) DEFAULT 'N';

ALTER TABLE T070_SCHEDARIEPIL ADD CARENZA_OBBLIGATORIA VARCHAR2(7);

ALTER TABLE T020_ORARI ADD RICALCOLO_DEBITO_GG VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T020_ORARI ADD RICALCOLO_MIN VARCHAR2(5);
ALTER TABLE T020_ORARI ADD RICALCOLO_MAX VARCHAR2(5);

alter table T026_SALDIABBATTUTI
  drop constraint T026_FK_T025;
  
ALTER TABLE T025_CONTMENSILI DROP PRIMARY KEY;
DROP TABLE T025_OLD;
RENAME T025_CONTMENSILI TO T025_OLD;

create table T025_CONTMENSILI
(
  CODICE                    VARCHAR2(5) not null,
  DESCRIZIONE               VARCHAR2(40),
  CARTELLINO                VARCHAR2(1) default 'M',
  ISTITUTI                  VARCHAR2(1) default 'M',
  NOTTEENTRATA              VARCHAR2(1),
  CONTEGGIO                 NUMBER(2) default 1,
  SCOSTSETT                 VARCHAR2(6),
  COMPPREC                  NUMBER(1) default 1,
  LIQPREC                   NUMBER(1) default 2,
  COMPATT                   NUMBER(1) default 3,
  LIQATT                    NUMBER(1) default 0,
  MESISALDOPREC             NUMBER(2) default -1,
  INDENNITA                 VARCHAR2(1) default '0',
  INDPRESENZA               VARCHAR2(1) default '0',
  RECUPERODEBITO            NUMBER(2),
  LIQUIDDISTRIBUITA         VARCHAR2(1) default 'S',
  TIPOLIMITECOMPA           VARCHAR2(1) default 'N',
  LIMITECOMPA               VARCHAR2(6),
  RECUPERO_SERBATOI         VARCHAR2(1) default 'G',
  BANCAORE                  VARCHAR2(1) default 'N',
  ABBATTIMENTO_LIQUIDABILE  VARCHAR2(1) default '0',
  RECUPERODEBITO_MAX        VARCHAR2(7) default '9999.59',
  PERIODICITA_ABBATTIMENTO  VARCHAR2(1) default 'F',
  ABBATTIMENTO_MOBILE_MAX   VARCHAR2(7) default '9999.59',
  ABBATTIMENTO_MOBILE_SALDI VARCHAR2(2),
  CAUSALI_COMPENSABILI      VARCHAR2(100),
  LIMITE_MM_ECCLIQ_TIPO     VARCHAR2(2) default 'CL',
  LIMITE_MM_ECCLIQ_DEFAULT  VARCHAR2(1) default 'N',
  LIMITE_MM_ECCRES_TIPO     VARCHAR2(2) default 'CL',
  LIMITE_MM_ECCRES_DEFAULT  VARCHAR2(1) default 'N',
  TRASF_SUPERO_LIQANN       VARCHAR2(1) default 'N',
  SOGLIA_COMP_LIQ           VARCHAR2(7) default '9999.59',
  COMPENSABILE_MINIMO       VARCHAR2(7),
  SALDO_NEGATIVO_MINIMO     VARCHAR2(7),
  BANCAORE_RESID            VARCHAR2(1) default 'N'
)
tablespace LAVORO 
pctfree 10 pctused 40 initrans 1 maxtrans 255
storage (initial 32K next 32K minextents 1 pctincrease 0);

alter table T025_CONTMENSILI
  add constraint T025_PK primary key (CODICE)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 10K next 10K minextents 1 pctincrease 0);

INSERT INTO T025_CONTMENSILI
(codice,descrizione,cartellino,istituti,notteentrata,conteggio, 
 scostsett,compprec,liqprec,compatt,liqatt,mesisaldoprec,indennita, 
 indpresenza,recuperodebito,liquiddistribuita,tipolimitecompa,
 limitecompa,recupero_serbatoi,bancaore,abbattimento_liquidabile, 
 recuperodebito_max,periodicita_abbattimento,abbattimento_mobile_max, 
 abbattimento_mobile_saldi,causali_compensabili,
 limite_mm_eccliq_tipo,limite_mm_eccliq_default,limite_mm_eccres_tipo, 
 limite_mm_eccres_default,trasf_supero_liqann,soglia_comp_liq, 
 saldo_negativo_minimo,bancaore_resid)
SELECT 
 codice,descrizione,cartellino,istituti,notteentrata,conteggio, 
 scostsett,compprec,liqprec,compatt,liqatt,mesisaldoprec,indennita, 
 indpresenza,recuperodebito,liquiddistribuita,tipolimitecompa,
 limitecompa,recupero_serbatoi,bancaore,abbattimento_liquidabile, 
 recuperodebito_max,periodicita_abbattimento,abbattimento_mobile_max, 
 abbattimento_mobile_saldi,causali_compensabili,
 limite_mm_eccliq_tipo,limite_mm_eccliq_default,limite_mm_eccres_tipo, 
 limite_mm_eccres_default,trasf_supero_liqann,soglia_comp_liq, 
 saldo_negativo_minimo,bancaore_resid
FROM T025_OLD;

alter table T026_SALDIABBATTUTI
  add constraint T026_FK_T025 foreign key (codice)
  references t025_contmensili (codice) on delete cascade;
  
ALTER TABLE T200_CONTRATTI ADD MAXRESIDUABILE VARCHAR2(7) DEFAULT '9999.59';

ALTER TABLE T020_ORARI ADD ARR_ECCED_LIQ VARCHAR2(5);
