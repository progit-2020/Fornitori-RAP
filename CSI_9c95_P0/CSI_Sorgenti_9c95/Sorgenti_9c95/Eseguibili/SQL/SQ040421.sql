UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.5.6' WHERE AZIENDA = :AZIENDA;

ALTER TABLE T041_PROVVISORIO ADD FLAGAGG VARCHAR2(1) DEFAULT 'N' NOT NULL;
alter table T041_PROVVISORIO drop primary key;
alter table T041_PROVVISORIO
  add constraint T041_PK primary key (PROGRESSIVO,DATA,CAUSALE,FLAGAGG)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 32K
    next 256K
    minextents 1
  );
ALTER TABLE T081_PROVVISORIO ADD FLAGAGG VARCHAR2(1) DEFAULT 'N' NOT NULL;
alter table T081_PROVVISORIO drop primary key;
alter table T081_PROVVISORIO
  add constraint T081_PK primary key (PROGRESSIVO,DATA,FLAGAGG)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 32K
    next 256K 
    minextents 1
  );
alter table I071_PERMESSI add A058_OPERATIVA varchar2(1) default 'S';
alter table I071_PERMESSI add A058_NONOPERATIVA varchar2(1) default 'S';
INSERT INTO MONDOEDP.I091_DATIENTE (SELECT AZIENDA,'C11_PIANIFORARIPROG', 'N' FROM I090_ENTI);

COMMENT ON COLUMN P430_ANAGRAFICO.TIPO_DIPENDENTE IS
  'Tipo dipendente: RU=A ruolo, IN=Incaricato, ER=Erede, BO=Borsista, CO=Co.Co.Co., LU=L.S.U., LA=Lav.autonomo';

alter table SG508_STAMPAPIANTA modify DESCRIZIONE VARCHAR2(80);
alter table SG506_PIANTADISTRIBUZIONE add INIZIO date;
alter table SG506_PIANTADISTRIBUZIONE add FINE date;
UPDATE sg506_piantadistribuzione A SET A.INIZIO =(select DATA from sg504_piantaorganica WHERE ID_PIANTA = A.ID_PIANTA AND STRUTTURA_DEFAULT='S');
UPDATE sg506_piantadistribuzione A SET FINE = to_date('31123999','ddmmyyyy') where INIZIO is not null;

create table sg651_pianificazionecorsi_new as select * from sg651_pianificazionecorsi;
truncate table sg651_pianificazionecorsi;
alter table SG651_PIANIFICAZIONECORSI modify DURATA_CORSO varchar2(7);
insert into sg651_pianificazionecorsi (select progressivo,cod_corso,data_corso,ora_inizio,ora_fine,to_char(durata_corso,'hh24.MI'),numero_crediti,tipo_partecipazione,note,tipo_record from sg651_pianificazionecorsi_new);
drop table sg651_pianificazionecorsi_new;


create table T050_RICHIESTEASSENZA
(
  PROGRESSIVO    NUMBER(8),
  CAUSALE        VARCHAR2(5),
  TIPOGIUST      VARCHAR2(1),
  DAL            DATE,
  AL             DATE,
  NUMEROORE      VARCHAR2(5),
  DATANAS        DATE,
  AUTORIZZAZIONE VARCHAR2(1),
  RESPONSABILE   VARCHAR2(20)
)
tablespace LAVORO
  pctfree 10
  pctused 80
  initrans 1
  maxtrans 255
  storage
  ( initial 32K  next 256k minextents 1);

comment on column T050_RICHIESTEASSENZA.TIPOGIUST
  is 'I = Giornata intera - M = Mezza giornata - N = Numero ore';

comment on column T050_RICHIESTEASSENZA.AUTORIZZAZIONE
  is 'S = Autorizzato - N = Non autorizzato - '''' = Da esaminare';

alter table T162_INDENNITA add ARROTONDAMENTO varchar2(1) default 'D';

create table T330_REG_ATT_AGGIUNTIVE
(
  CODICE           VARCHAR2(5) not null,
  DESCRIZIONE      VARCHAR2(40),
  ORAINIZIO        DATE not null,
  ORAFINE          DATE not null
)
tablespace LAVORO
  pctfree 10
  pctused 60
  initrans 1
  maxtrans 255
  storage
  (
    initial 12K
    next 32k
    minextents 1
  );
alter table T330_REG_ATT_AGGIUNTIVE
  add primary key (CODICE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 12K
    next 12K
    minextents 1
  );

create table T332_PIAN_ATT_AGGIUNTIVE
(
  DATA        DATE not null,
  PROGRESSIVO NUMBER(38,2) not null,
  TURNO1      VARCHAR2(5),
  TURNO2      VARCHAR2(5)
)
tablespace LAVORO
  pctfree 5
  pctused 80
  initrans 1
  maxtrans 255
  storage
  (
    initial 32K
    next 256K
    minextents 1
  );
alter table T332_PIAN_ATT_AGGIUNTIVE
  add primary key (DATA,PROGRESSIVO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 32K
    next 128K
    minextents 1
  );
  
ALTER TABLE MONDOEDP.I070_UTENTI MODIFY PASSWD VARCHAR2(40);  
ALTER TABLE MONDOEDP.I070_UTENTI ADD DATA_PW DATE;
UPDATE MONDOEDP.I070_UTENTI SET DATA_PW = TRUNC(SYSDATE);  

ALTER TABLE MONDOEDP.I060_LOGIN_DIPENDENTE ADD DATA_PW DATE;
ALTER TABLE MONDOEDP.I060_LOGIN_DIPENDENTE ADD PERMESSI VARCHAR2(20);
ALTER TABLE MONDOEDP.I060_LOGIN_DIPENDENTE ADD FILTRO_DIZIONARIO VARCHAR2(20);
UPDATE MONDOEDP.I060_LOGIN_DIPENDENTE SET DATA_PW = TRUNC(SYSDATE);  

ALTER TABLE MONDOEDP.I090_ENTI ADD LUNG_PASSWORD NUMBER(2) DEFAULT 0;
ALTER TABLE MONDOEDP.I090_ENTI ADD VALID_PASSWORD NUMBER(3) DEFAULT 0;

UPDATE T275_CAUPRESENZE SET PIANIFREP = 'N' WHERE CODICE IN 
(SELECT CODICE FROM T270_RAGGRPRESENZE WHERE CODINTERNO NOT IN ('C','G'))
AND PIANIFREP <> 'N';
