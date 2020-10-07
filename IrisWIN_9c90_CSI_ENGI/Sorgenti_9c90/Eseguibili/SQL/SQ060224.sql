UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '6.0.6' WHERE AZIENDA = :AZIENDA;

--*************************GESTIONE FORMAZIONE INIZIO************************
alter table SG650_CORSIECM drop constraint SG650_PK cascade;

create table SG650_TESTATACORSI
(
  CODICE               VARCHAR2(15) not null,
  DECORRENZA           DATE not null,
  TITOLO_CORSO         VARCHAR2(500) not null,
  EDIZIONE             VARCHAR2(5) not null,
  DATA_INIZIO          DATE,
  DATA_FINE            DATE,
  DURATA_GG            NUMBER(5,2),
  DURATA_HH            VARCHAR2(7),
  NUMERO_DELIBERA      VARCHAR2(20),
  DATA_DELIBERA        DATE,
  PROFILO_CORSO        VARCHAR2(500),
  PROFILO_CREDITI      VARCHAR2(5),
  TIPO_CORSO           VARCHAR2(5),
  EVENTO_PROGETTO      VARCHAR2(1) default 'E' not null,
  NUMERO_CREDITI       NUMBER(3) default 0 not null,
  GG_MIN               NUMBER(3),
  HH_MIN               VARCHAR2(7),
  MAX_PARTECIPANTI     NUMBER(4),
  MAX_ISCRITTI         NUMBER(4),
  FLAG_INTERNO         VARCHAR2(1) default 'S' not null,
  LUOGO_CORSO          VARCHAR2(15),
  METODO_CORSO         VARCHAR2(15),
  ENTE_ORGANIZZATORE   VARCHAR2(15),
  TIPO_AGGIORNAMENTO   VARCHAR2(15),
  NOTE                 VARCHAR2(500),
  LINK_PROGRAMMA_CORSO VARCHAR2(200)
)
tablespace LAVORO
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
   next 10M
    minextents 1
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table SG650_TESTATACORSI
  add constraint SG650_PK primary key (CODICE, DECORRENZA)
  using index 
  tablespace LAVORO
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
   next 10M
    minextents 1   
  );

alter table SG650_TESTATACORSI
  add constraint SG650_UI unique (CODICE, EDIZIONE)
  using index 
  tablespace LAVORO
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
   next 10M
    minextents 1
  );

create table SG657_CODPROFILICREDITI
(
  CODICE      varchar2(5),
  DESCRIZIONE varchar2(100)
)
tablespace LAVORO
  storage
  (
    initial 64K
    next 5M
    minextents 1
  );

alter table SG657_CODPROFILICREDITI
  add constraint SG657_PK primary key (CODICE);

alter table SG650_TESTATACORSI
  add constraint SG650_FK_SG657 foreign key (PROFILO_CREDITI)
  references sg657_codprofilicrediti (CODICE);

create table SG658_CODTIPOCORSO
(
  CODICE      varchar2(5),
  DESCRIZIONE varchar2(100)
)
tablespace LAVORO
  storage
  (
    initial 64K
    next 5M
    minextents 1
  );

alter table SG658_CODTIPOCORSO
  add constraint SG658_PK primary key (CODICE);

alter table SG650_TESTATACORSI
  add constraint SG650_FK_SG658 foreign key (TIPO_CORSO)
  references SG658_CODTIPOCORSO (CODICE);

create table SG659_GIORNATECORSI
(
  COD_CORSO  varchar2(15),
  NUMERO_GIORNO number(2),
  DESCRIZIONE   varchar2(100),
  ORE_GIORNO    varchar2(7),
  ORE_MINIME    varchar2(7)
)
tablespace LAVORO
  storage
  (
    initial 64K
    next 10M
    minextents 1
  );

alter table SG659_GIORNATECORSI
  add constraint SG659_PK primary key (COD_CORSO, NUMERO_GIORNO);

create table SG660_CALENDARIOCORSI
(
  cod_corso     varchar2(15),
  decorrenza    date,
  numero_giorno number(2),
  data_giorno   date
)
tablespace LAVORO
  storage
  (
    initial 64K
    next 10M
    minextents 1
  );

alter table SG660_CALENDARIOCORSI
  add constraint SG660_PK primary key (COD_CORSO, DECORRENZA, NUMERO_GIORNO, DATA_GIORNO);

alter table SG655_PROFILICREDITI drop constraint SG655_PK cascade;
rename SG655_PROFILICREDITI to SG655_PROFILICREDITI_OLD;


-- Create table
create table SG655_PROFILICREDITI
(
  CODICE          VARCHAR2(80) not null,
  ANNO            NUMBER(4) not null,
  DESCRIZIONE     VARCHAR2(40),
  NUMERO_CREDITI  NUMBER(4),
  ASSENZE         VARCHAR2(500),
  PRESENZE        VARCHAR2(500),
  MINIMO          NUMBER(4),
  MASSIMO         NUMBER(4),
  PROFILO_CREDITI VARCHAR2(5) not null
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 5M
    minextents 1
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table SG655_PROFILICREDITI
  add constraint SG655_PK primary key (CODICE, PROFILO_CREDITI, ANNO)
  using index 
  tablespace LAVORO
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 5M
    minextents 1
  );

alter table SG656_RESIDUOCREDITI drop constraint SG656_PK cascade;
rename SG656_RESIDUOCREDITI to SG656_RESIDUOCREDITI_OLD;

-- Create table
create table SG656_RESIDUOCREDITI
(
  PROGRESSIVO     NUMBER(8) not null,
  ANNO            NUMBER(4) not null,
  PROFILO_CREDITI VARCHAR2(5) not null,
  CREDITI         NUMBER(8)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 80K
    next 10M
    minextents 1
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table SG656_RESIDUOCREDITI
  add constraint SG656_PK primary key (PROGRESSIVO, ANNO, PROFILO_CREDITI)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 10M
    minextents 1
  );

alter table SG651_PIANIFICAZIONECORSI drop constraint SG651_PK cascade;
rename SG651_PIANIFICAZIONECORSI to SG651_PIANIFICAZIONECORSI_OLD;

-- Create table
create table SG651_PIANIFICAZIONECORSI
(
  COD_CORSO           VARCHAR2(15) not null,
  DECORRENZA          DATE not null,
  PROGRESSIVO         NUMBER not null,
  NUMERO_GIORNO       NUMBER(2) not null,
  DATA_CORSO          DATE not null,
  ORA_INIZIO          VARCHAR2(5),
  ORA_FINE            VARCHAR2(5),
  DURATA_CORSO        VARCHAR2(7),
  NOTE                VARCHAR2(300),
  TIPO_RECORD         VARCHAR2(1),
  ORIGINE             VARCHAR2(1),
  STATO               VARCHAR2(1),
  DATA_ISCRIZIONE     DATE,
  OPERATORE_ISCRIZIONE     varchar2(30),
  DATA_AUTORIZZAZIONE      date,
  OPERATORE_AUTORIZZAZIONE varchar2(30),
  DATA_VALIDAZIONE         date,
  OPERATORE_VALIDAZIONE    varchar2(30)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 10M
    minextents 1
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table SG651_PIANIFICAZIONECORSI
  add constraint SG651_PK primary key (COD_CORSO, DECORRENZA, PROGRESSIVO, NUMERO_GIORNO, DATA_CORSO)
  using index 
  tablespace LAVORO
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 10M
    minextents 1
  );

-- Create table
create table SG662_COSTICORSI
(
  COD_CORSO  VARCHAR2(15) not null,
  DECORRENZA DATE not null,
  CODTIPOCOSTO VARCHAR2(15) not null,
  COSTO      NUMBER not null,
  TIPO_COSTO VARCHAR2(1) not null
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 5M
    minextents 1
  );

-- Add comments to the columns 
comment on column SG662_COSTICORSI.TIPO_COSTO
  is 'Indivividuale/Generale';

-- Create/Recreate primary, unique and foreign key constraints 
alter table SG662_COSTICORSI
  add constraint SG662_PK primary key (COD_CORSO, DECORRENZA, CODTIPOCOSTO, TIPO_COSTO)
  using index 
  tablespace LAVORO
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 5M
    minextents 1
  );

-- Create table
create table SG663_CODTIPOCOSTO
(
  CODICE      VARCHAR2(15) not null,
  DESCRIZIONE VARCHAR2(40)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 5M
    minextents 1
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table SG663_CODTIPOCOSTO
  add constraint SG663_PK primary key (CODICE)
  using index 
  tablespace LAVORO
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 5M
    minextents 1
  );


-- Create table
create table SG664_DOCENTI
(
  COD_CORSO      VARCHAR2(15) not null,
  DECORRENZA     DATE not null,
  PROGRESSIVO    NUMBER(8) not null,
  ORE_DOCENZA    VARCHAR2(7),
  NUMERO_CREDITI NUMBER(3) default 0 not null
)
tablespace LAVORO
  storage
  (
    initial 64K
   next 10M
    minextents 1
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table SG664_DOCENTI
  add constraint SG664_PK primary key (COD_CORSO, DECORRENZA, PROGRESSIVO);

-- Add/modify columns 
truncate table T932_LOG;
alter table T932_LOG modify DESCRIZIONE varchar2(1000);

create table SG665_ENTECORSI
(
  CODICE      varchar2(15),
  DESCRIZIONE varchar2(100)
)
tablespace LAVORO
  storage
  (
    initial 64K
    next 5M
    minextents 1
  );
alter table SG665_ENTECORSI
  add constraint SG665_PK primary key (CODICE);

create table SG666_TIPOAGGIORNAMENTOCORSI
(
  CODICE      varchar2(15),
  DESCRIZIONE varchar2(100)
)
tablespace LAVORO
  storage
  (
    initial 64K
    next 5M
    minextents 1
  );
alter table SG666_TIPOAGGIORNAMENTOCORSI
  add constraint SG666_PK primary key (CODICE);

--Aggiornamento dati del generatore di stampe
update t911_datiriepilogo set nome = 
decode(upper(nome),
       'CF_DATA_CORSO','CF_Data_partecipazione',
       'CF_DURATA_CORSO','CF_Durata_partecipazione',
       'CF_NUMERO_CREDITI','CF_Crediti',
       'CF_NOTE','CF_Note_partecipazione',
       'CF_TITOLO_CORSO','CF_Titolo',
       'CF_METODO_CORSO','CF_Metodo',
       'CF_D_METODO_CORSO','CF_D_Metodo',
       'CF_NOTE_CORSO','CF_Note',
       'CF_PROFILO','CF_Profilo_Crediti',
       nome)
where substr(nome,1,3) = 'CF_';

update t912_sortriepilogo set nome = 
decode(upper(nome),
       'CF_DATA_CORSO','CF_Data_partecipazione',
       'CF_DURATA_CORSO','CF_Durata_partecipazione',
       'CF_NUMERO_CREDITI','CF_Crediti',
       'CF_NOTE','CF_Note_partecipazione',
       'CF_TITOLO_CORSO','CF_Titolo',
       'CF_METODO_CORSO','CF_Metodo',
       'CF_D_METODO_CORSO','CF_D_Metodo',
       'CF_NOTE_CORSO','CF_Note',
       'CF_PROFILO','CF_Profilo_Crediti',
       nome)
where substr(nome,1,3) = 'CF_';

update t913_serbatoikey set dato = 
decode(upper(dato),
       'CF_DATA_CORSO','CF_Data_partecipazione',
       'CF_DURATA_CORSO','CF_Durata_partecipazione',
       'CF_NUMERO_CREDITI','CF_Crediti',
       'CF_NOTE','CF_Note_partecipazione',
       'CF_TITOLO_CORSO','CF_Titolo',
       'CF_METODO_CORSO','CF_Metodo',
       'CF_D_METODO_CORSO','CF_D_Metodo',
       'CF_NOTE_CORSO','CF_Note',
       'CF_PROFILO','CF_Profilo_Crediti',
       dato)
where substr(dato,1,3) = 'CF_';

update t914_serbatoifiltro set filtro = 
  replace(filtro,'CF_Data_corso','CF_Data_partecipazione')
where id_serbatoio = 10 and instr(filtro,'CF_Data_corso') > 0;

update t914_serbatoifiltro set filtro = 
  replace(filtro,'CF_Durata_corso','CF_Durata_partecipazione')
where id_serbatoio = 10 and instr(filtro,'CF_Durata_corso') > 0;

update t914_serbatoifiltro set filtro = 
  replace(filtro,'CF_Numero_crediti','CF_Crediti')
where id_serbatoio = 10 and instr(filtro,'CF_Numero_crediti') > 0;

update t914_serbatoifiltro set filtro = 
  replace(filtro,'CF_Note','CF_Note_partecipazione')
where id_serbatoio = 10 and instr(filtro,'CF_Note') > 0;

update t914_serbatoifiltro set filtro = 
  replace(filtro,'CF_Titolo_corso','CF_Titolo')
where id_serbatoio = 10 and instr(filtro,'CF_Titolo_corso') > 0;

update t914_serbatoifiltro set filtro = 
  replace(filtro,'CF_Metodo_corso','CF_Metodo')
where id_serbatoio = 10 and instr(filtro,'CF_Metodo_corso') > 0;

update t914_serbatoifiltro set filtro = 
  replace(filtro,'CF_D_Metodo_corso','CF_D_Metodo')
where id_serbatoio = 10 and instr(filtro,'CF_D_Metodo_corso') > 0;

update t914_serbatoifiltro set filtro = 
  replace(filtro,'CF_Note_corso','CF_Note')
where id_serbatoio = 10 and instr(filtro,'CF_Note_corso') > 0;

update t914_serbatoifiltro set filtro = 
  replace(filtro,'CF_Profilo','CF_Profilo_crediti')
where id_serbatoio = 10 and instr(filtro,'CF_Profilo') > 0;

INSERT INTO MONDOEDP.I091_DATIENTE (SELECT AZIENDA,'C10_FORMAZPROFCORSO', '' FROM MONDOEDP.I090_ENTI);

UPDATE MONDOEDP.I091_DATIENTE SET TIPO='C10_FORMAZPROFCRED' WHERE TIPO='C10_CREDITIFORMATIVI';

--*************************GESTIONE FORMAZIONE FINE**************************


DECLARE
 CURSOR C1 IS
   SELECT DISTINCT PROFILO FROM MONDOEDP.I073_FILTROFUNZIONI;
BEGIN
  FOR T1 IN C1 LOOP
    INSERT INTO MONDOEDP.I073_FILTROFUNZIONI VALUES (T1.PROFILO, 'FUNWEB', 415, 'OpenW007GestioneSicurezza', 'Funzioni WEB', 'Gestione sicurezza', 'S');
  END LOOP;
END;
/

alter table t909_daticalcolati modify codice_stampa varchar2(20);
alter table t910_riepilogo modify codice varchar2(20);
alter table t911_datiriepilogo modify codice varchar2(20);
alter table t912_sortriepilogo modify codice varchar2(20);
alter table t913_serbatoikey modify codice varchar2(20);
alter table t914_serbatoifiltro modify codice varchar2(20);
alter table t915_codiciselezionati modify codice varchar2(20);

create index P441_COD_PROGR on P448_CEDOLINOPARKVOCI (COD_CEDOLINOPARK,PROGRESSIVO) tablespace INDICI
  STORAGE (pctincrease 0 initial 64K next 10M);

alter table P252_VOCIAGGIUNTIVEIMPORTI modify DESCRIZIONE VARCHAR2(100);

alter table P252_VOCIAGGIUNTIVEIMPORTI
  drop constraint P252_PK cascade;
alter table P252_VOCIAGGIUNTIVEIMPORTI
  add constraint P252_PK primary key (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, COD_VOCE, COD_VOCE_SPECIALE)
  using index tablespace INDICI
  STORAGE (pctincrease 0 initial 32K next 64K);

--*************************INCENTIVI ABBATTIMENTI************************
-- Create table
create table T763_INCENTIVIABBATTIMENTI
(
  PROGRESSIVO                                       NUMBER not null,
  ANNO                                                       NUMBER not null,
  MESE                                                       NUMBER not null,
  TIPOQUOTA                                            VARCHAR2(5) not null,
  TIPOABBATTIMENTO                             VARCHAR2(40) not null,
  MESEAPPLICAZIONEABBATTIMENTO  DATE,
  QUOTAABBATTIMENTO                         NUMBER
)
STORAGE (INITIAL 1M NEXT 10M PCTINCREASE 0) 
TABLESPACE LAVORO;
-- Create/Recreate primary, unique and foreign key constraints 
alter table T763_INCENTIVIABBATTIMENTI
  add constraint T763_PK primary key (PROGRESSIVO, ANNO, MESE, TIPOQUOTA, TIPOABBATTIMENTO)
  using index 
STORAGE (INITIAL 1M NEXT 10M PCTINCREASE 0) 
TABLESPACE INDICI;
comment on column T763_INCENTIVIABBATTIMENTI.TIPOABBATTIMENTO
  is 'AS=Assenze, GS=Giorni di servizio, PT=Part-time';


--*************************INCENTIVI ABBATTIMENTI FINE********************

ALTER TABLE T332_PIAN_ATT_AGGIUNTIVE DROP PRIMARY KEY;
ALTER TABLE T332_PIAN_ATT_AGGIUNTIVE ADD CONSTRAINT T332_PK PRIMARY KEY
(PROGRESSIVO, DATA) USING INDEX TABLESPACE INDICI
  PCTFREE 10 STORAGE (INITIAL 16K NEXT 512K MINEXTENTS 1);

ALTER TABLE T380_PIANIFREPERIB DROP PRIMARY KEY;
ALTER TABLE T380_PIANIFREPERIB ADD CONSTRAINT T380_PK PRIMARY KEY
(PROGRESSIVO, DATA) USING INDEX TABLESPACE INDICI
  PCTFREE 10 STORAGE (INITIAL 16K NEXT 2M MINEXTENTS 1);
CREATE INDEX T380_IDX ON T380_PIANIFREPERIB (DATA,PROGRESSIVO)
TABLESPACE INDICI PCTFREE 10 STORAGE (INITIAL 16K NEXT 2M MINEXTENTS 1);



--*************************INSERIMENTO AUTOMATICO RIPOSI ********************

ALTER TABLE T267_REGOLERIPOSI
ADD GGFEST_GIUSTIFICATO VARCHAR2(1) DEFAULT 'N';

ALTER TABLE T267_REGOLERIPOSI
  DROP CONSTRAINT T267_PK;

alter table T267_REGOLERIPOSI
  add constraint T267_PK primary key (CODICE,TIPO_CAUSALE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (initial 64K  minextents 1);

ALTER TABLE T267_REGOLERIPOSI MODIFY RIPOSO_ORDINARIO NULL;
ALTER TABLE T267_REGOLERIPOSI MODIFY RIPOSO_COMPENSATIVO NULL;
ALTER TABLE T267_REGOLERIPOSI MODIFY RIPOSO_MESEPREC NULL;

ALTER TABLE T265_CAUASSENZE ADD CP_DOMENICHE VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE ADD CP_PIANIFREPER VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T265_CAUASSENZE ADD CP_FESTGIUSTIF VARCHAR2(1) DEFAULT 'S';
comment on column T265_CAUASSENZE.CP_DOMENICHE
  is 'In caso di TipoCumulo=P, indica la considerazione o meno delle domeniche lavorate. Valori ammessi (S/N).';
comment on column T265_CAUASSENZE.CP_PIANIFREPER
  is 'In caso di TipoCumulo=P, indica la considerazione o meno delle festivit… e/o domeniche reperibili. Valori ammessi (S/N).';
comment on column T265_CAUASSENZE.CP_FESTGIUSTIF 
  is 'In caso di TipoCumulo=P, indica la considerazione o meno delle festivit… gi… giustificate. Valori ammessi (S/N).';

--*************************STAMPA ATTESTATI CORSI ********************

UPDATE SG500_DATILIBERI SET NOMECAMPO = 'CF_D_METODO' WHERE NOMECAMPO = 'CF_D_METODO_CORSO';
UPDATE SG500_DATILIBERI SET NOMECAMPO = 'CF_METODO' WHERE NOMECAMPO = 'CF_METODO_CORSO';
UPDATE SG500_DATILIBERI SET NOMECAMPO = 'CF_TITOLO' WHERE NOMECAMPO = 'CF_TITOLO_CORSO';
UPDATE SG500_DATILIBERI SET NOMECAMPO = 'CF_INIZIO' WHERE NOMECAMPO = 'CF_DATA_CORSO';
UPDATE SG500_DATILIBERI SET NOMECAMPO = 'CF_CREDITI' WHERE NOMECAMPO = 'CF_NUMERO_CREDITI';
UPDATE SG500_DATILIBERI SET NOMECAMPO = 'CF_FLAG_INTERNO' WHERE NOMECAMPO = 'CF_STATO';
DELETE FROM SG500_DATILIBERI WHERE NOMECAMPO = 'CF_TIPO_PARTECIPAZIONE';
DELETE FROM SG500_DATILIBERI WHERE NOMECAMPO = 'CF_D_TIPO_PARTECIPAZIONE';
DELETE FROM SG500_DATILIBERI WHERE NOMECAMPO = 'CF_NOTE_CORSO';
DELETE FROM SG500_DATILIBERI WHERE NOMECAMPO = 'CF_ORA_FINE';
DELETE FROM SG500_DATILIBERI WHERE NOMECAMPO = 'CF_ORA_INIZIO';
DELETE FROM SG500_DATILIBERI WHERE NOMECAMPO = 'CF_TIPO_RECORD';

--************************INCENTIVI****************************

alter table T769_INCENTIVIASSENZE add FORZA_ABB_GGINT varchar2(1);
alter table T769_INCENTIVIASSENZE modify FORZA_ABB_GGINT default 'N';
comment on column T769_INCENTIVIASSENZE.FORZA_ABB_GGINT
  is 'S= SI N=NO';
alter table T775_QUOTEINDIVIDUALI add SALTAPROVA varchar2(1) default 'N';

--************************FINE INCENTIVI***********************

comment on column P272_RETRIBUZIONE_CONTRATTUALE.TIPO_VOCE
  is 'Tipo voce: E=voce di posizione economica, P=voce programmata';
UPDATE P272_RETRIBUZIONE_CONTRATTUALE SET TIPO_VOCE = 'E' WHERE TIPO_VOCE = 'A';

-- Esempio indice su T430STORICO.BADGE 
-- create index T430_BADGE on T430_STORICO (BADGE) tablespace INDICI pctfree 10
--  initrans 2 maxtrans 255 storage (initial 64K next 32K );

ALTER TABLE T025_CONTMENSILI ADD PA_LIMITE VARCHAR2(7);
comment on column T025_CONTMENSILI.PA_LIMITE is 'Ore massime residuabili';
ALTER TABLE T025_CONTMENSILI ADD PA_LIMITESALDOATT VARCHAR2(1) DEFAULT 'N';
comment on column T025_CONTMENSILI.PA_LIMITESALDOATT is 'S=il limite si riferisce solo al saldo attuale, N=il limite si riferisce al saldo complessivo';
ALTER TABLE T025_CONTMENSILI ADD PA_AZZERAMENTOPERIODICO VARCHAR2(1) DEFAULT 'N';
comment on column T025_CONTMENSILI.PA_LIMITESALDOATT is 'Gestione dell''azzeramento periodico a fine anno S/N';
ALTER TABLE T025_CONTMENSILI ADD PA_TIPORESIDUO VARCHAR2(1) DEFAULT '0';
comment on column T025_CONTMENSILI.PA_LIMITESALDOATT is '0=Liq+Comp 1=Liq 2=Comp';

ALTER TABLE MONDOEDP.I090_ENTI ADD PATCHDB NUMBER(2) DEFAULT 0;

ALTER TABLE P442_CEDOLINOVOCI ADD RATE_RESIDUE NUMBER DEFAULT NULL;
COMMENT ON COLUMN P442_CEDOLINOVOCI.RATE_RESIDUE IS
  'Numero rate residue';
ALTER TABLE P442_CEDOLINOVOCI ADD DESCRIZIONE_VOCE_SOST VARCHAR2(40) DEFAULT NULL;
COMMENT ON COLUMN P442_CEDOLINOVOCI.DESCRIZIONE_VOCE_SOST IS
  'Se significativo sostituisce la descrizione della voce nella stampa del cedolino';
ALTER TABLE P446_CEDOLINOTEMPVOCI ADD RATE_RESIDUE NUMBER DEFAULT NULL;
COMMENT ON COLUMN P446_CEDOLINOTEMPVOCI.RATE_RESIDUE IS
  'Numero rate residue';
ALTER TABLE P446_CEDOLINOTEMPVOCI ADD DESCRIZIONE_VOCE_SOST VARCHAR2(40) DEFAULT NULL;
COMMENT ON COLUMN P446_CEDOLINOTEMPVOCI.DESCRIZIONE_VOCE_SOST IS
  'Se significativo sostituisce la descrizione della voce nella stampa del cedolino';

ALTER TABLE P193_VOCIVARIABILIINPUT ADD DESCRIZIONE_VOCE_SOST VARCHAR2(40) DEFAULT NULL;
COMMENT ON COLUMN P193_VOCIVARIABILIINPUT.DESCRIZIONE_VOCE_SOST IS
  'Se significativo sostituisce la descrizione della voce nella stampa del cedolino';

ALTER TABLE P264_MOD730IMPORTI ADD IMPORTO_MANUALE NUMBER DEFAULT NULL;
COMMENT ON COLUMN P264_MOD730IMPORTI.IMPORTO_MANUALE IS
  'Importo dovuto forzato manualmente';
ALTER TABLE P264_MOD730IMPORTI ADD ATTRIBUZIONE_DIMESSI VARCHAR2(1) DEFAULT 'N';
COMMENT ON COLUMN P264_MOD730IMPORTI.ATTRIBUZIONE_DIMESSI IS
  'Attribuzione dell''importo in caso di dipendente dimesso (S/N)';

--fluper
alter table P663_FLUSSIDATIINDIVIDUALI modify VALORE VARCHAR2(300);

INSERT INTO t002_querypersonalizzate (nome, posiz, riga)
VALUES ('A075',0,'SELECT I070.AZIENDA, I070.UTENTE, T001.NOME PARAMETRO, T001.VALORE');

INSERT INTO t002_querypersonalizzate (nome, posiz, riga)
VALUES ('A075',1,'FROM T001_PARAMETRIFUNZIONI T001, I070_UTENTI I070');

INSERT INTO t002_querypersonalizzate (nome, posiz, riga)
VALUES ('A075',2,'WHERE T001.PROGOPERATORE = I070.PROGRESSIVO');

INSERT INTO t002_querypersonalizzate (nome, posiz, riga)
VALUES ('A075',3,'AND T001.PROG = ''A075''');

INSERT INTO t002_querypersonalizzate (nome, posiz, riga)
VALUES ('A075',4,'AND T001.NOME = ''AZZERAMENTOPERIODICO''');

INSERT INTO t002_querypersonalizzate (nome, posiz, riga)
VALUES ('A075',5,'AND UTENTE LIKE ''%'' || :UTENTE || ''%''');

INSERT INTO t002_querypersonalizzate (nome, posiz, riga)
VALUES ('A041',0,'SELECT I070.AZIENDA, I070.UTENTE, T001.NOME PARAMETRO, T001.VALORE');

INSERT INTO t002_querypersonalizzate (nome, posiz, riga)
VALUES ('A041',1,'FROM T001_PARAMETRIFUNZIONI T001, I070_UTENTI I070');

INSERT INTO t002_querypersonalizzate (nome, posiz, riga)
VALUES ('A041',2,'WHERE T001.PROGOPERATORE = I070.PROGRESSIVO');

INSERT INTO t002_querypersonalizzate (nome, posiz, riga)
VALUES ('A041',3,'AND T001.PROG = ''A041''');

INSERT INTO t002_querypersonalizzate (nome, posiz, riga)
VALUES ('A041',4,'AND UTENTE LIKE ''%'' || :UTENTE || ''%''');

DELETE FROM I073_FILTROFUNZIONI WHERE TAG IN (401,412,415) AND APPLICAZIONE <> 'FUNWEB';
