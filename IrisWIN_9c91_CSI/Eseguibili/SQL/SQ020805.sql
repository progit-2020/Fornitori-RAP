/*declare
  cursor c1 is 
    select distinct profilo from i073_filtrofunzioni;
  cursor c2(prof varchar2) is 
    select distinct profilo from i073_filtrofunzioni where
      profilo > prof;
  n integer;
begin
  for t1 in c1 loop
    for t2 in c2(t1.profilo) loop
      n:=99;
      select count(*) into n from (
        select applicazione,tag,inibizione from i073_filtrofunzioni where 
          profilo = t1.profilo
        minus
        select applicazione,tag,inibizione from i073_filtrofunzioni where 
          profilo = t2.profilo
      );
      if n = 0 then
        update i070_utenti set filtro_funzioni = t1.profilo where filtro_funzioni = t2.profilo;
        delete from i073_filtrofunzioni where profilo = t2.profilo;
        commit;
      end if;
    end loop;
  end loop;
end OTTIMIZZA_PROFILI_FUNZIONI;
/*/

UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.4.4' WHERE AZIENDA = :AZIENDA;

ALTER TABLE P150_SETUP ADD COD_COMUNE_INAIL VARCHAR2(4);

ALTER TABLE T025_CONTMENSILI MODIFY MESISALDOPREC NUMBER(2) DEFAULT -1;
ALTER TABLE T025_CONTMENSILI MODIFY RECUPERO_SERBATOI DEFAULT 'G';
ALTER TABLE T025_CONTMENSILI ADD PERIODICITA_ABBATTIMENTO VARCHAR2(1) DEFAULT 'F';
ALTER TABLE T025_CONTMENSILI ADD ABBATTIMENTO_MOBILE_MAX VARCHAR2(7) DEFAULT '9999.59';
ALTER TABLE T025_CONTMENSILI ADD ABBATTIMENTO_MOBILE_SALDI VARCHAR2(2);
ALTER TABLE T025_CONTMENSILI ADD CAUSALI_COMPENSABILI VARCHAR2(100);
UPDATE T025_CONTMENSILI SET MESISALDOPREC = -1 WHERE MESISALDOPREC IS NULL OR MESISALDOPREC = 0;
UPDATE T025_CONTMENSILI SET NOTTEENTRATA = RECUPERODEBITO;
UPDATE T025_CONTMENSILI SET RECUPERODEBITO = NULL;
ALTER TABLE T025_CONTMENSILI MODIFY RECUPERODEBITO NUMBER(2);
UPDATE T025_CONTMENSILI SET RECUPERODEBITO = DECODE(NOTTEENTRATA,'S',1,-1);

ALTER TABLE T275_CAUPRESENZE ADD RESIDUABILE VARCHAR2(7) DEFAULT '00.00';

ALTER TABLE T291_PARMESSAGGI ADD NUM_RIPET_MSG NUMBER DEFAULT 0;
ALTER TABLE T291_PARMESSAGGI ADD NUM_GGVAL_MSG NUMBER DEFAULT 0;
ALTER TABLE T291_PARMESSAGGI ADD NUM_MMIND_CONS NUMBER DEFAULT 0;

create table T290_MESSAGGIOROLOGI
(
  DATADD            VARCHAR2(2),
  DATAMM            VARCHAR2(2),
  DATAYY            VARCHAR2(4),
  DATAHH            VARCHAR2(5),
  PARAMETRIZZAZIONE VARCHAR2(200),
  GIORNO            VARCHAR2(1)
)
tablespace LAVORO
  pctfree 10 pctused 40 initrans 1 maxtrans 255
  storage (initial 32K next 32K minextents 1 pctincrease 0);
  
ALTER TABLE T070_SCHEDARIEPIL MODIFY DEBITOORARIO DEFAULT '00.00';
ALTER TABLE T070_SCHEDARIEPIL MODIFY DEBITOPO DEFAULT '00.00';
ALTER TABLE T070_SCHEDARIEPIL MODIFY TIPOPO DEFAULT '0';
ALTER TABLE T070_SCHEDARIEPIL MODIFY OREECCEDCOMP DEFAULT '00.00';
ALTER TABLE T070_SCHEDARIEPIL MODIFY OREASSENZE DEFAULT '00.00';
ALTER TABLE T070_SCHEDARIEPIL MODIFY RECANNOCORR DEFAULT '00.00';
ALTER TABLE T070_SCHEDARIEPIL MODIFY RECANNOPREC DEFAULT '00.00';
ALTER TABLE T070_SCHEDARIEPIL MODIFY RECLIQCORR DEFAULT '00.00';
ALTER TABLE T070_SCHEDARIEPIL MODIFY RECLIQPREC DEFAULT '00.00';
ALTER TABLE T070_SCHEDARIEPIL MODIFY SCOSTNEG DEFAULT '-000.00';
ALTER TABLE T070_SCHEDARIEPIL MODIFY RIPCOM DEFAULT '00.00';
ALTER TABLE T070_SCHEDARIEPIL MODIFY ABBRIPCOM DEFAULT '00.00';
ALTER TABLE T070_SCHEDARIEPIL MODIFY ORECOMP_LIQUIDATE DEFAULT '00.00';
ALTER TABLE T071_SCHEDAFASCE MODIFY ORELAVORATE DEFAULT '00.00';
ALTER TABLE T071_SCHEDAFASCE MODIFY OREECCEDGIORN DEFAULT '00.00';
ALTER TABLE T071_SCHEDAFASCE MODIFY ORESTRAORDLIQ DEFAULT '00.00';
ALTER TABLE T071_SCHEDAFASCE MODIFY ORE1ASSEST DEFAULT '00.00';
ALTER TABLE T071_SCHEDAFASCE MODIFY ORE2ASSEST DEFAULT '00.00';

create table T131_RESIDPRESENZE
(
  PROGRESSIVO number(8),
  ANNO        number(4),
  CAUSALE     varchar2(5),
  ORE_FASCIA1 varchar2(8) default '00.00',
  ORE_FASCIA2 varchar2(8) default '00.00',
  ORE_FASCIA3 varchar2(8) default '00.00',
  ORE_FASCIA4 varchar2(8) default '00.00',
  ORE_FASCIA5 varchar2(8) default '00.00',
  ORE_FASCIA6 varchar2(8) default '00.00'
)
tablespace LAVORO
  pctfree 10 pctused 70 
  storage (initial 32K next 256K minextents 1 pctincrease 0);

alter table T131_RESIDPRESENZE
  add constraint T131_PK primary key (PROGRESSIVO,ANNO,CAUSALE)
  using index 
  tablespace INDICI
  pctfree 10
  storage (initial 32K next 256K minextents 1 pctincrease 0);

ALTER TABLE T670_REGOLEBUONI ADD DEBITO_GIORN_MIN VARCHAR2(5) DEFAULT '00.00';
ALTER TABLE T670_REGOLEBUONI ADD GIORNI_FISSI     VARCHAR2(7);
ALTER TABLE T670_REGOLEBUONI ADD ECCEDENZA_MIN    VARCHAR2(5) DEFAULT '00.00';
ALTER TABLE T670_REGOLEBUONI ADD NUM_MAX_BUONI    NUMBER(2) DEFAULT 0;

ALTER TABLE T291_PARMESSAGGI ADD FILTRO_ANAGR VARCHAR2(20);

ALTER TABLE T020_ORARI ADD PAUSAMENSA_AUTOMATICA NUMBER(4);

ALTER TABLE T950_STAMPACARTELLINO ADD ANOMALIE2 VARCHAR2(150);
ALTER TABLE T950_STAMPACARTELLINO ADD ANOMALIE3 VARCHAR2(30);

ALTER TABLE T265_CAUASSENZE ADD UM_INSERIMENTO VARCHAR2(1) DEFAULT 'E';
ALTER TABLE T670_REGOLEBUONI MODIFY MISSIONI DEFAULT 'S';