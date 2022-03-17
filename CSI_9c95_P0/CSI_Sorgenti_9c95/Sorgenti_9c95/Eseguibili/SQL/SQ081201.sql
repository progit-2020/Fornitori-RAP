UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '7.4',PATCHDB = 0 WHERE AZIENDA = :AZIENDA;

update T265_CAUASSENZE set codcau3 = null where trim(codcau3) is null and length(codcau3) > 0;

alter table T926_STAMPESCHEDULATE add SEMAFORO varchar2(200);
alter table T926_STAMPESCHEDULATE add INTESTAZIONE_LOG varchar2(1000);
alter table T926_STAMPESCHEDULATE add DETTAGLIO_LOG varchar2(1000);
alter table T926_STAMPESCHEDULATE add CMD_AFTER varchar2(1000);

alter table T910_RIEPILOGO add FILTRO_INSERVIZIO varchar2(1) default 'T';
comment on column T910_RIEPILOGO.FILTRO_INSERVIZIO is 'T=Tutti - 0=Nessun giorno di servizio - 1=Almeno un giorno di servizio';
alter table T910_RIEPILOGO modify TABELLA_GENERATA varchar2(100);

ALTER TABLE T762_INCENTIVIMATURATI DROP PRIMARY KEY;
DROP INDEX T762_PK;
alter table T762_INCENTIVIMATURATI 
  add constraint T762_PK primary key (PROGRESSIVO, ANNO, MESE, TIPOQUOTA, TIPOIMPORTO)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

ALTER TABLE T769_INCENTIVIASSENZE DROP PRIMARY KEY;
DROP INDEX T769_PK;
alter table T769_INCENTIVIASSENZE
  add constraint T769_PK primary key (DATO1, DATO2, DATO3, DECORRENZA, COD_TIPOACCORPCAUSALI, COD_CODICIACCORPCAUSALI,CAUSALE)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

ALTER TABLE T760_REGOLEINCENTIVI ADD QUOTA_SCARICOPAGHE VARCHAR2(1) DEFAULT '3';
comment on column T760_REGOLEINCENTIVI.QUOTA_SCARICOPAGHE is 'Tipologia di importo quote da scaricare alle Paghe';

alter table P266_MODONAOSI add IMPONIBILE number default 0 not null;
comment on column P266_MODONAOSI.IMPONIBILE  is 'Imponibile lordo';

alter table P266_MODONAOSI add ALIQUOTA number default 0 not null;
comment on column P266_MODONAOSI.ALIQUOTA  is 'Percentuale applicata';

alter table T670_REGOLEBUONI add PAUSA_MENSA_GESTITA varchar2(1) default 'N';
comment on column T670_REGOLEBUONI.PAUSA_MENSA_GESTITA is 'S=Matura solo se i conteggi hanno gestito la pausa mensa';

alter table T670_REGOLEBUONI add OREMINIME_FASCE varchar2(1) default 'N';
update T670_REGOLEBUONI set OREMINIME_FASCE = 'S';
comment on column T670_REGOLEBUONI.PAUSA_MENSA_GESTITA is 'S=Le ore minime si riferiscono alle 2 fasce indicate - N=Le ore minime si riferiscono a tutto il giorno anche se sono specificate le 2 fasce';

alter table T265_CAUASSENZE modify CODCAU1 varchar2(1000);
alter table T265_CAUASSENZE modify CODCAU2 varchar2(1000);

ALTER TABLE T265_CAUASSENZE ADD PERIODO_LUNGO VARCHAR2(1) DEFAULT 'N';
comment on column T265_CAUASSENZE.PERIODO_LUNGO is 'Identifica lunghi periodi di assenza';

alter table SG710_TESTATA_VALUTAZIONI
add (CHIUSO VARCHAR2(1) default 'N',
     DATA_CHIUSURA DATE);

alter table SG705_VALUTATORI
  ADD DATO2 VARCHAR2(80) default ' ' not null;

alter table SG705_VALUTATORI
  DROP constraint SG705_PK;
  
alter table SG705_VALUTATORI
  add constraint SG705_PK primary key (DATO, DATO2, DECORRENZA);

create table SG740_REGOLE_VALUTAZIONI
(DECORRENZA         DATE not null,
 DECORRENZA_FINE    DATE,
 COD_TIPI_RAPPORTO  VARCHAR2(400),
 GIORNI_MINIMI      NUMBER(3),
 DATO_STAMPA_1      VARCHAR2(30),
 DATO_STAMPA_2      VARCHAR2(30),
 DATO_STAMPA_3      VARCHAR2(30),
 DATO_STAMPA_4      VARCHAR2(30),
 DATO_STAMPA_5      VARCHAR2(30))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG740_REGOLE_VALUTAZIONI add constraint SG740_PK primary key (DECORRENZA)  
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

-- Correzione scaglione INPGI 2008
update p233_scaglionifasce t set t.importo_da=39553.01
where t.importo_a=0
and t.id_scaglione=(select v.id_scaglione from p232_scaglioni v where v.cod_contratto='EDP'
and v.cod_voce='11090' and v.cod_voce_speciale='BASE'
and v.decorrenza=to_date('01012008','ddmmyyyy'));

alter table MONDOEDP.I061_PROFILI_DIPENDENTE add DELEGATO_DA varchar2(30);
comment on column MONDOEDP.I061_PROFILI_DIPENDENTE.DELEGATO_DA is 'Utente che ha delegato questo profilo';

alter table MONDOEDP.I061_PROFILI_DIPENDENTE drop primary key;
drop index MONDOEDP.I061_PK;
alter table  MONDOEDP.I061_PROFILI_DIPENDENTE add constraint I061_PK primary key (AZIENDA, NOME_UTENTE, NOME_PROFILO, INIZIO_VALIDITA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

-- Data di richiesta e di autorizzazione assenze

alter table T050_RICHIESTEASSENZA add DATA_RICHIESTA DATE;
comment on column T050_RICHIESTEASSENZA.DATA_RICHIESTA
  is 'Data della richiesta di autorizzazione assenza';

alter table T050_RICHIESTEASSENZA add DATA_AUTORIZZAZIONE DATE;
comment on column T050_RICHIESTEASSENZA.DATA_AUTORIZZAZIONE
  is 'Data di autorizzazione dell''assenza richiesta';
  
  
-- Data di richiesta e di autorizzazione omesse timbrature

alter table T105_RICHIESTETIMBRATURE add DATA_RICHIESTA DATE;
comment on column T105_RICHIESTETIMBRATURE.DATA_RICHIESTA
  is 'Data della richiesta di autorizzazione di omessa timbratura';

alter table T105_RICHIESTETIMBRATURE add DATA_AUTORIZZAZIONE DATE;
comment on column T105_RICHIESTETIMBRATURE.DATA_AUTORIZZAZIONE
  is 'Data di autorizzazione dell''omessa timbratura';

-- Esito seconda rata acconto IRPEF coniuge dichiarante
alter table P262_MOD730TESTATA add COD_ESITO_2RATA_CONIUGE VARCHAR2(5);

INSERT INTO P214_TIPOACCORPAMENTOVOCI
SELECT 'CU770', 'Accorpamento voci per modelli CUD e 770' FROM DUAL WHERE NOT EXISTS
(SELECT 'X' FROM P214_TIPOACCORPAMENTOVOCI T WHERE T.COD_TIPOACCORPAMENTOVOCI='CU770');

INSERT INTO P215_CODICIACCORPAMENTOVOCI
SELECT 'CU770', 'ENORT', 'Somme non soggette a ritenuta (lav.aut.)' FROM DUAL WHERE NOT EXISTS
(SELECT 'X' FROM P215_CODICIACCORPAMENTOVOCI T WHERE T.COD_TIPOACCORPAMENTOVOCI='CU770' AND T.COD_CODICIACCORPAMENTOVOCI='ENORT');

alter table P602_770REGOLE modify REGOLA_CALCOLO_AUTOMATICA VARCHAR2(2000);
alter table P602_770REGOLE modify REGOLA_CALCOLO_MANUALE VARCHAR2(2000);

UPDATE P660_FLUSSIREGOLE P660 
SET P660.REGOLA_CALCOLO_MANUALE=
'SELECT NVL(MAX(P663.VALORE),''1'') DATO FROM P662_FLUSSITESTATE P662, P663_FLUSSIDATIINDIVIDUALI P663
WHERE P662.ID_FLUSSO=P663.ID_FLUSSO AND P662.NOME_FLUSSO=''DMA'' AND P662.CHIUSO=''S''
AND P663.PARTE=''Z2'' AND P663.NUMERO=''005'' AND P663.TIPO_RECORD=''M'' AND P663.PROGRESSIVO_NUMERO=1
AND P662.ID_FLUSSO=
(SELECT MAX(P662A.ID_FLUSSO) FROM P662_FLUSSITESTATE P662A WHERE P662A.NOME_FLUSSO=''DMA'' AND P662A.CHIUSO=''S'')'
WHERE P660.NOME_FLUSSO='DMA' AND P660.PARTE='Z2' AND P660.NUMERO='005';

UPDATE P660_FLUSSIREGOLE P660 SET P660.REGOLA_CALCOLO_AUTOMATICA=P660.REGOLA_CALCOLO_MANUALE
WHERE P660.NOME_FLUSSO='DMA';

alter table P200_VOCI add RITENUTA_ANAGRAFICA VARCHAR2(50);
comment on column P200_VOCI.RITENUTA_ANAGRAFICA
  is 'Campo anagrafico contenente la percentuale ritenuta';

comment on column P200_VOCI.RITENUTA_MASSIMALI_SCAGLIONI
  is 'Modalita'' di calcolo: N=Percentuale fissa, S=Massimali/Scaglioni, A=Percentuale su anagrafica. Richiesto solo se Tipo = RI';

alter table T275_CAUPRESENZE add INCLUDI_INDTURNO varchar2(1) default 'N';
comment on column T275_CAUPRESENZE.INCLUDI_INDTURNO is 'S=Le ore causalizzate vengono incluse nelle indennità di turno degli enti locali - N=Le ore causalizzate non vengono incluse nell''indennità di turno';

alter table P500_CUDSETUP add WEB_STAMPA varchar2(1) default 'N';
alter table P500_CUDSETUP add WEB_ANNOTAZIONI varchar2(2000);
alter table P500_CUDSETUP add WEB_PATH_ISTRUZIONI varchar2(1000);
alter table P500_CUDSETUP add WEB_DATA_STAMPA date;
comment on column P500_CUDSETUP.WEB_STAMPA is 'Stampa del CUD da web abilitata (S/N)';
comment on column P500_CUDSETUP.WEB_DATA_STAMPA is 'Data di stampa da riportare sul CUD';
comment on column P500_CUDSETUP.WEB_ANNOTAZIONI is 'Annotazioni da stampare in calce al CUD';
comment on column P500_CUDSETUP.WEB_PATH_ISTRUZIONI is 'Percorso dell''eventuale allegato con istruzioni relative al CUD';

UPDATE p200_voci t SET T.RETRIBUZIONE_CONTRATTUALE='S' WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='00290'
AND T.COD_VOCE_SPECIALE='BASE';

ALTER TABLE T193_VOCIPAGHE_PARAMETRI MODIFY VOCE_PAGHE_CEDOLINO VARCHAR2(10);
ALTER TABLE T193_VOCIPAGHE_PARAMETRI MODIFY VOCE_PAGHE_NEGATIVA VARCHAR2(10);
ALTER TABLE T195_VOCIVARIABILI MODIFY VOCEPAGHE VARCHAR2(10);

ALTER TABLE SG301_INCTIPO ADD ORDINE_STAMPA NUMBER;
comment on column SG301_INCTIPO.ORDINE_STAMPA is 'Ordine di stampa in riepilogo';

create table SG307_INCSTAMPE
(
  CODICE                VARCHAR2(10) not null,
  DESCRIZIONE           VARCHAR2(80),
  FLAG_TOTALE           VARCHAR2(1),
  UO_STAMPA             VARCHAR2(1),
  UO_SALTOPAG           VARCHAR2(1),
  UO_FILTRO             VARCHAR2(4000),
  UO_FONTSIZE           NUMBER,
  UO_FONTNAME           VARCHAR2(30),
  UO_FONTSTYLE          VARCHAR2(30),
  UO_FONTCOLOR          NUMBER,
  TPINC_STAMPA          VARCHAR2(1),
  TPINC_SALTOPAG        VARCHAR2(1),
  TPINC_FILTRO          VARCHAR2(4000),
  TPINC_FONTSIZE        NUMBER,
  TPINC_FONTNAME        VARCHAR2(30),
  TPINC_FONTSTYLE       VARCHAR2(30),
  TPINC_FONTCOLOR       NUMBER,
  POSIZ_STAMPA          VARCHAR2(1),
  POSIZ_SALTOPAG        VARCHAR2(1),
  POSIZ_FILTRO          VARCHAR2(4000),
  POSIZ_FONTSIZE        NUMBER,
  POSIZ_FONTNAME        VARCHAR2(30),
  POSIZ_FONTSTYLE       VARCHAR2(30),
  POSIZ_FONTCOLOR       NUMBER,
  DIP_STAMPA            VARCHAR2(1),
  DIP_DATI              VARCHAR2(4000),
  DIP_FONTSIZE          NUMBER,
  DIP_FONTNAME          VARCHAR2(30),
  DIP_FONTSTYLE         VARCHAR2(30),
  DIP_FONTCOLOR         NUMBER
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG307_INCSTAMPE
  add constraint SG307_PK primary key (CODICE)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T500_PIANIFSERVIZI add ORDINE_CMD number(8);
update T500_PIANIFSERVIZI set ORDINE_CMD = ORDINE;
update T500_PIANIFSERVIZI set ORDINE_CMD = ORDINE_CMD + 100000 where COMANDATO = 'S';

INSERT INTO T545_TIPITURNO(CODICE,DESCRIZIONE,COMANDATO) VALUES('00N','Salto pagina','N');
INSERT INTO T545_TIPITURNO(CODICE,DESCRIZIONE,COMANDATO) VALUES('00C','Salto pagina','N');

alter table T540_SERVIZI add PADRE varchar2(10);
alter table T540_SERVIZI add FILTRO_ANAGRAFE varchar2(20);

CREATE TABLE T503_NOTE_SERVIZI(
         DATA DATE, 
         FILTRO_ANAGRAFE VARCHAR2(20), 
         NOTE VARCHAR2(4000))
  TABLESPACE LAVORO STORAGE(INITIAL 256K NEXT 256K PCTINCREASE 0);

ALTER TABLE T503_NOTE_SERVIZI ADD CONSTRAINT T503_PK PRIMARY KEY (DATA, FILTRO_ANAGRAFE)
  USING INDEX TABLESPACE INDICI STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

--Ricreazione tabelle Pianificazione servizi, nle caso mancassero dalle versioni precedenti
create table T500_PIANIFSERVIZI
(
  COMANDATO     VARCHAR2(1),
  TIPO_TURNO    VARCHAR2(10),
  DATA          DATE not null,
  PATTUGLIA     NUMBER(8) not null,
  SERVIZIO      VARCHAR2(10),
  DALLE         VARCHAR2(5),
  ALLE          VARCHAR2(5),
  CAUSALE       VARCHAR2(5),
  NOTE          VARCHAR2(2000),
  NOTE_SERVIZIO VARCHAR2(2000),
  STATO         VARCHAR2(1) default 'A',
  ORDINE        NUMBER(8),
  ORDINE_CMD    NUMBER(8)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column T500_PIANIFSERVIZI.COMANDATO is 'S=Servizio comandato - N=Servizio normale';
comment on column T500_PIANIFSERVIZI.PATTUGLIA is 'Progressivo automatico';
comment on column T500_PIANIFSERVIZI.STATO is 'A=Aperto - C=Chiuso';
alter table T500_PIANIFSERVIZI
  add constraint T500_PK primary key (DATA, PATTUGLIA)
  using index tablespace INDICI storage (initial 256K next 256K);

create table T501_PIANIFAPPARATI
(
  DATA      DATE not null,
  PATTUGLIA NUMBER(8) not null,
  TIPO      VARCHAR2(5) not null,
  CODICE    VARCHAR2(10) not null
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T501_PIANIFAPPARATI
  add constraint T501_PK primary key (DATA, PATTUGLIA, TIPO, CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T502_PATTUGLIE
(
  DATA        DATE not null,
  PATTUGLIA   NUMBER(8) not null,
  CAMPO1      VARCHAR2(20),
  CAMPO2      VARCHAR2(20),
  PROGRESSIVO NUMBER(8) not null,
  COMANDATO   VARCHAR2(1) default 'N'
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T502_PATTUGLIE
  add constraint T502_PK primary key (DATA, PATTUGLIA, PROGRESSIVO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T503_NOTE_SERVIZI
(
  DATA            DATE not null,
  FILTRO_ANAGRAFE VARCHAR2(20) not null,
  NOTE            VARCHAR2(4000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T503_NOTE_SERVIZI
  add constraint T503_PK primary key (DATA, FILTRO_ANAGRAFE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T520_TEMPLATE_SERVIZI
(
  DATA       DATE not null,
  TIPO_TURNO VARCHAR2(10) not null,
  COMANDATO  VARCHAR2(1),
  NOME       VARCHAR2(20) not null
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T520_TEMPLATE_SERVIZI
  add constraint T520_PK primary key (DATA, TIPO_TURNO, NOME)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T530_CONFIGSERVIZI
(
  DATA_PRIMOGGLAV  DATE,
  DATA_PRIMOGGFES  DATE,
  ALTERNANZA_GGLAV NUMBER(3),
  ALTERNANZA_GGFES NUMBER(3),
  GGCHIUSURA       NUMBER(3),
  CALENDARIO       VARCHAR2(5)
)
tablespace LAVORO storage (initial 64K pctincrease 0);

create table T540_SERVIZI
(
  CODICE          VARCHAR2(10) not null,
  DESCRIZIONE     VARCHAR2(80),
  COLORE          VARCHAR2(20) default 'clYellow',
  COLOREFONT      VARCHAR2(20) default 'clBlack',
  PADRE           VARCHAR2(10),
  FILTRO_ANAGRAFE VARCHAR2(20)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T540_SERVIZI
  add constraint T540_PK primary key (CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T545_TIPITURNO
(
  CODICE      VARCHAR2(10) not null,
  DESCRIZIONE VARCHAR2(40),
  COMANDATO   VARCHAR2(1) default 'N'
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T545_TIPITURNO
  add constraint T545_PK primary key (CODICE)
  using index tablespace INDICI storage(initial 256K next 256K pctincrease 0);

create table T550_APPARATI
(
  COD_APPARATO    VARCHAR2(5) not null,
  CODICE          VARCHAR2(10) not null,
  DECORRENZA      DATE not null,
  DECORRENZA_FINE DATE,
  DESCRIZIONE     VARCHAR2(80),
  STATO           VARCHAR2(1) default 'D',
  FILTRO1         VARCHAR2(2000),
  FILTRO2         VARCHAR2(2000),
  FILTRO_SERVIZI  VARCHAR2(2000),
  DOTAZ_RADIO     VARCHAR2(1) default 'N'
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T550_APPARATI.STATO is 'D=DISPONIBILE - O=OCCUPATO - N=NON FUNZIONANTE';
comment on column T550_APPARATI.DOTAZ_RADIO is 'Mezzo con Radio a bordo';

alter table T550_APPARATI
  add constraint T550_PK primary key (COD_APPARATO, CODICE, DECORRENZA)
  using index tablespace INDICI storage(initial 256K next 256K pctincrease 0);

create table T555_TIPOAPPARATI
(
  CODICE      VARCHAR2(5) not null,
  DESCRIZIONE VARCHAR2(40)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T555_TIPOAPPARATI
  add constraint T555_PK primary key (CODICE)
  using index tablespace INDICI storage(initial 256K next 256K pctincrease 0);

alter table T550_APPARATI
  add constraint T550_FK_T555 foreign key (COD_APPARATO) references T555_TIPOAPPARATI (CODICE);

update P201_ASSOGGETTAMENTI t set
    DECORRENZA_FINE =
    (select min(DECORRENZA) - 1 from P201_ASSOGGETTAMENTI where
     COD_CONTRATTO = t.COD_CONTRATTO and
     COD_VOCE_PADRE = t.COD_VOCE_PADRE and
     COD_VOCE_SPECIALE_PADRE = t.COD_VOCE_SPECIALE_PADRE and
     COD_VOCE_FIGLIO = t.COD_VOCE_FIGLIO and
     COD_VOCE_SPECIALE_FIGLIO = t.COD_VOCE_SPECIALE_FIGLIO and
     DECORRENZA > t.DECORRENZA)
  where
    DECORRENZA < (select max(DECORRENZA) from P201_ASSOGGETTAMENTI where
     COD_CONTRATTO = t.COD_CONTRATTO and
     COD_VOCE_PADRE = t.COD_VOCE_PADRE and
     COD_VOCE_SPECIALE_PADRE = t.COD_VOCE_SPECIALE_PADRE and
     COD_VOCE_FIGLIO = t.COD_VOCE_FIGLIO and
     COD_VOCE_SPECIALE_FIGLIO = t.COD_VOCE_SPECIALE_FIGLIO);
update P201_ASSOGGETTAMENTI t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where
    DECORRENZA = (select max(DECORRENZA) from P201_ASSOGGETTAMENTI where
     COD_CONTRATTO = t.COD_CONTRATTO and
     COD_VOCE_PADRE = t.COD_VOCE_PADRE and
     COD_VOCE_SPECIALE_PADRE = t.COD_VOCE_SPECIALE_PADRE and
     COD_VOCE_FIGLIO = t.COD_VOCE_FIGLIO and
     COD_VOCE_SPECIALE_FIGLIO = t.COD_VOCE_SPECIALE_FIGLIO);

