ALTER TABLE T670_REGOLEBUONI ADD RESIDUO_PRECEDENTE DATE;       

ALTER TABLE T021_FASCEORARI DISABLE CONSTRAINT T021_FK_T020;
UPDATE T020_ORARI SET CODICE = LTRIM(RTRIM(CODICE));
UPDATE T021_FASCEORARI SET CODICE = LTRIM(RTRIM(CODICE));
ALTER TABLE T021_FASCEORARI ENABLE CONSTRAINT T021_FK_T020;

UPDATE T221_PROFILISETTIMANA SET 
  LUNEDI = LTRIM(RTRIM(LUNEDI)),
  MARTEDI = LTRIM(RTRIM(MARTEDI)),
  MERCOLEDI = LTRIM(RTRIM(MERCOLEDI)),
  GIOVEDI = LTRIM(RTRIM(GIOVEDI)),
  VENERDI = LTRIM(RTRIM(VENERDI)),
  SABATO = LTRIM(RTRIM(SABATO)),
  DOMENICA = LTRIM(RTRIM(DOMENICA)),
  NONLAV = LTRIM(RTRIM(NONLAV)),
  FESTIVO = LTRIM(RTRIM(FESTIVO));
  
UPDATE T080_PIANIFORARI SET 
  ORARIO = RTRIM(LTRIM(ORARIO)) 
WHERE DATA >= TO_DATE('01012003','DDMMYYYY') AND INSTR(ORARIO,' ') > 0;

UPDATE T611_CICLIGIORNALIERI SET 
  ORARIO = RTRIM(LTRIM(ORARIO));

create table T240_ORGANIZZAZIONISINDACALI
(
  CODICE                VARCHAR2(10) not null,
  DECORRENZA            DATE not null,
  DESCRIZIONE           VARCHAR2(40),
  COD_MINISTERIALE      VARCHAR2(2),
  FILTRO                VARCHAR2(500),
  RAGGRUPPAMENTO        VARCHAR2(1) DEFAULT 'N',
  SINDACATI_RAGGRUPPATI VARCHAR2(200),
  RSU                   VARCHAR2(1) DEFAULT 'N'
)
tablespace LAVORO 
pctfree 10 pctused 40 initrans 1 maxtrans 255 noparallel
storage (initial 32K next 128K minextents 1 pctincrease 0);

alter table T240_ORGANIZZAZIONISINDACALI
  add constraint T240_PK primary key (CODICE,DECORRENZA)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 128K minextents 1 pctincrease 0);


create table T241_RECAPITISINDACATI
(
  CODICE           VARCHAR2(10) not null,
  DECORRENZA       DATE not null,
  TIPO_RECAPITO    VARCHAR2(2) not null,
  PROG_RECAPITO    NUMBER(2) default 0 not null,
  DESCRIZIONE      VARCHAR2(40),
  INDIRIZZO        VARCHAR2(50),
  CAP              VARCHAR2(5),
  COMUNE           VARCHAR2(6), 
  TELEFONO         VARCHAR2(15),
  FAX              VARCHAR2(15),
  COGNOME          VARCHAR2(20),
  NOME             VARCHAR2(20),
  TELEFONO_CASA    VARCHAR2(15),
  TELEFONO_UFFICIO VARCHAR2(15),
  CELLULARE        VARCHAR2(15),
  EMAIL            VARCHAR2(40)
)
tablespace LAVORO 
pctfree 10 pctused 40 initrans 1 maxtrans 255 noparallel
storage (initial 32K next 128K minextents 1 pctincrease 0);

alter table T241_RECAPITISINDACATI
  add constraint T241_PK primary key (CODICE,DECORRENZA,TIPO_RECAPITO,PROG_RECAPITO)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 128K minextents 1 pctincrease 0);

COMMENT ON COLUMN T241_RECAPITISINDACATI.TIPO_RECAPITO IS
  'A = Aziendale - P = Provinciale - R = Regionale - N = Nazionale - G = Generico';

create table T242_COMPETENZESINDACATI
(
  CODICE         VARCHAR2(10) not null,
  AREA_SINDACALE VARCHAR2(20),
  DECORRENZA     DATE not null,
  SCADENZA       DATE,
  COMPETENZA     VARCHAR2(7)
)
tablespace LAVORO 
pctfree 10 pctused 40 initrans 1 maxtrans 255 noparallel
storage (initial 32K next 256K minextents 1 pctincrease 0);

alter table T242_COMPETENZESINDACATI
  add constraint T242_PK primary key (CODICE,AREA_SINDACALE,DECORRENZA)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 256K minextents 1 pctincrease 0);

create table T245_ORGANISMISINDACALI
(
  CODICE                VARCHAR2(5) not null,
  DESCRIZIONE           VARCHAR2(80)
)
tablespace LAVORO 
pctfree 10 pctused 40 initrans 1 maxtrans 255 noparallel
storage (initial 32K next 32K minextents 1 pctincrease 0);

alter table T245_ORGANISMISINDACALI
  add constraint T245_PK primary key (CODICE)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 32K minextents 1 pctincrease 0);


create table T246_ISCRIZIONISINDACATI
(
  PROGRESSIVO 		number(8) not null,
  DATA_ISCR		date not null,
  NUM_PROT_ISCR  	number(10) not null,
  DATA_DEC_ISCR		date,
  DATA_CESS 		date,
  NUM_PROT_CESS		number(10),		
  DATA_DEC_CES		date,			
  COD_SINDACATO		varchar2(10) not null	   	
)
tablespace LAVORO 
pctfree 10 pctused 40 initrans 1 maxtrans 255 noparallel
storage (initial 32K next 128K minextents 1 pctincrease 0);

alter table T246_ISCRIZIONISINDACATI
  add constraint T246_PK primary key (PROGRESSIVO, DATA_ISCR, NUM_PROT_ISCR, COD_SINDACATO)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 128K minextents 1 pctincrease 0);

create table T247_PARTECIPAZIONISINDACATI
(
  PROGRESSIVO 		number(8) not null,
  DADATA		date not null,
  ADATA	  		date,
  COD_SINDACATO		varchar2(10) not null,	   	
  COD_ORGANISMO		varchar2(5) not null
)
tablespace LAVORO 
pctfree 10 pctused 40 initrans 1 maxtrans 255 noparallel
storage (initial 32K next 128K minextents 1 pctincrease 0);

alter table T247_PARTECIPAZIONISINDACATI
  add constraint T247_PK primary key (PROGRESSIVO, DADATA, COD_SINDACATO, COD_ORGANISMO)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 128K minextents 1 pctincrease 0);

create table T248_PERMESSISINDACALI
(
 progressivo 		number(8) not null,
 data 			date not null,
 numero_prot 		varchar2(10),
 data_prot 		date,
 dalle 			varchar2(5),
 alle 			varchar2(5),
 ore 			varchar2(5),
 abbatte_competenze 	varchar2(1) default 'S',
 cod_sindacato 		varchar2(10) not null,
 cod_organismo 		varchar2(5) not null,
 stato 			varchar2(1) default 'O' not null,
 prot_modifica 		varchar2(10), 
 data_modifica 		date
)
tablespace LAVORO 
pctfree 10 pctused 40 initrans 1 maxtrans 255 noparallel
storage (initial 32K next 2M minextents 1 pctincrease 0);

alter table T248_PERMESSISINDACALI
  add constraint T248_PK primary key (PROGRESSIVO, DATA, COD_SINDACATO, COD_ORGANISMO, STATO)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 2M minextents 1 pctincrease 0);

COMMENT ON COLUMN T248_PERMESSISINDACALI.STATO IS
  'O = Originale - M = Modificato - C = Cancellato';

UPDATE T025_CONTMENSILI SET 
  TIPOLIMITECOMPA = 'H',
  LIMITECOMPA = '00.00'
WHERE TIPOLIMITECOMPA = 'T';

ALTER TABLE T020_ORARI ADD PAUSAMENSA_ESTERNA VARCHAR2(5) DEFAULT '00.00';

ALTER TABLE T070_SCHEDARIEPIL ADD OREECCEDCOMPOLTRESOGLIA VARCHAR2(6);