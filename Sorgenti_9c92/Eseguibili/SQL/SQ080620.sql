UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '7.3',PATCHDB = 0 WHERE AZIENDA = :AZIENDA;

--Pezzo già presente sulla 7.2 -- Inizio
create table T030_NOTRIGGER
(
  PROGRESSIVO NUMBER(8),
  ISTANTE     DATE
) tablespace LAVORO;

create table i020_dati_allineamento
(TIPO    VARCHAR2(1),
 TABELLA VARCHAR2(30),
 COLONNA VARCHAR2(100),
 VALORE  VARCHAR2(100)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column i020_dati_allineamento.TIPO is 'D=Dato storico - R=Relazione anagrafica';
comment on column i020_dati_allineamento.TABELLA is 'Tabella di riferimento';
comment on column i020_dati_allineamento.COLONNA is 'Colonna oggetto di storicizzazione';
comment on column i020_dati_allineamento.VALORE is 'Valore oggetto di storicizzazione';
--Pezzo già presente sulla 7.2 -- Fine

DECLARE
  --
  CURSORE_DINAMICO_ALTER_T430     INTEGER;
  CURS_ALTER_T430                 INTEGER;
  --
  CURSOR CUR_I500 IS
    SELECT NOMECAMPO
    FROM   I500_DATILIBERI
    WHERE  STORICO = 'S';
  --
  ESPRESSIONE                 VARCHAR2(500) :='';
BEGIN
  FOR REC_I500 IN CUR_I500 LOOP
    ESPRESSIONE:='alter table T430_STORICO modify '||REC_I500.NOMECAMPO||' null';
    CURSORE_DINAMICO_ALTER_T430:=DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(CURSORE_DINAMICO_ALTER_T430,ESPRESSIONE,DBMS_SQL.NATIVE);
    CURS_ALTER_T430:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_ALTER_T430);
    DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_ALTER_T430);
  END LOOP;
END;
/

alter table T430_STORICO modify QUALIFICAMINIST varchar2(20);
alter table T470_QUALIFICAMINIST modify CODICE varchar2(20);

DROP index P663_ID_FLUSSO;

DROP index P662_NOME_DATA;

create table IA140_I030 (
  STRUTTURA varchar2(80),
  PILOTATO varchar2(30),
  PILOTA varchar2(30),
  ORDINE number(4) default 0
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

DELETE P205_QUOTE T WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE='15070'
AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE' AND T.COD_VOCE_IN_QUOTA='00290';

DELETE FROM P201_ASSOGGETTAMENTI
  WHERE COD_CONTRATTO||COD_VOCE_PADRE||COD_VOCE_SPECIALE_PADRE NOT IN
  (SELECT COD_CONTRATTO||COD_VOCE||COD_VOCE_SPECIALE FROM P200_VOCI);
DELETE FROM P201_ASSOGGETTAMENTI
  WHERE COD_CONTRATTO||COD_VOCE_FIGLIO||COD_VOCE_SPECIALE_FIGLIO NOT IN
  (SELECT COD_CONTRATTO||COD_VOCE||COD_VOCE_SPECIALE FROM P200_VOCI);
DELETE FROM P205_QUOTE
  WHERE COD_CONTRATTO||COD_VOCE_DA_QUOTARE||COD_VOCE_SPECIALE_DA_QUOTARE NOT IN
  (SELECT COD_CONTRATTO||COD_VOCE||COD_VOCE_SPECIALE FROM P200_VOCI);
DELETE FROM P205_QUOTE
  WHERE COD_CONTRATTO||COD_VOCE_IN_QUOTA||COD_VOCE_SPECIALE_IN_QUOTA NOT IN
  (SELECT COD_CONTRATTO||COD_VOCE||COD_VOCE_SPECIALE FROM P200_VOCI);
DELETE FROM P216_ACCORPAMENTOVOCI
  WHERE COD_CONTRATTO||COD_VOCE||COD_VOCE_SPECIALE NOT IN
  (SELECT COD_CONTRATTO||COD_VOCE||COD_VOCE_SPECIALE FROM P200_VOCI);
DELETE FROM P232_SCAGLIONI
  WHERE COD_CONTRATTO||COD_VOCE||COD_VOCE_SPECIALE NOT IN
  (SELECT COD_CONTRATTO||COD_VOCE||COD_VOCE_SPECIALE FROM P200_VOCI);
DELETE FROM P230_MINIMALI
  WHERE COD_CONTRATTO||COD_VOCE||COD_VOCE_SPECIALE NOT IN
  (SELECT COD_CONTRATTO||COD_VOCE||COD_VOCE_SPECIALE FROM P200_VOCI);

ALTER TABLE SG650_TESTATACORSI ADD DATA_CHIUSURA DATE;
comment on column SG650_TESTATACORSI.DATA_CHIUSURA is 'Data chiusura corso';

ALTER TABLE T501_PIANIFAPPARATI DROP CONSTRAINT T501_FK_T500 ;

ALTER TABLE T501_PIANIFAPPARATI DROP COLUMN DALLE;

create table T545_TIPITURNO (
  CODICE varchar2(20)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

UPDATE P670_XMLREGOLE T SET T.OMETTI_VUOTO='N' WHERE T.NUMERO='D095';

ALTER TABLE P212_PARAMETRISTIPENDI ADD GIORNI_INPDAP NUMBER(2) DEFAULT 30 NOT NULL;
comment on column P212_PARAMETRISTIPENDI.GIORNI_INPDAP
  is 'Giorni INPDAP del mese';

comment on column P212_PARAMETRISTIPENDI.DATA_APPROVAZIONE
  is 'Data approvazione (non gestito)';
comment on column P212_PARAMETRISTIPENDI.DATA_APPLICAZIONE
  is 'Data applicazione (non gestito)';
comment on column P212_PARAMETRISTIPENDI.DATA_SCADENZA
  is 'Data scadenza (non gestito)';

alter table T020_ORARI add PMT_SOLO_TIMBMENSA varchar2(1) default 'N';
comment on column T020_ORARI.PMT_TIMB_MATURAMENSA is 'Riferito al riconoscimento dello stacco di mensa PMT: S=Gestita solo se esiste timbratura di mensa - N=Sempre gestita';

update T020_ORARI set PAUSAMENSA_AUTOMATICA = NULL where instr(PAUSAMENSA_AUTOMATICA,'0.00') > 0;
update T020_ORARI set TIMBRATURAMENSA_DETRAZIONE = NULL where instr(TIMBRATURAMENSA_DETRAZIONE,'0.00') > 0;

alter table T020_ORARI add TIMBRATURAMENSA_DETRTOT varchar2(1) default 'N';
comment on column T020_ORARI.TIMBRATURAMENSA_DETRTOT is 'Se timbratura di mensa, forza la detrazione totale anche se si usa il tipo mensa E';

update T020_ORARI set TIMBRATURAMENSA_DETRTOT = 'S' where TIPOMENSA in ('E','F') and TIMBRATURAMENSA = 'S';

alter table MONDOEDP.I060_LOGIN_DIPENDENTE add EMAIL VARCHAR2(200);

create table MONDOEDP.I061_PROFILI_DIPENDENTE
(
  AZIENDA           VARCHAR2(30) not null,
  NOME_UTENTE       VARCHAR2(30) not null,
  NOME_PROFILO       VARCHAR2(30) not null,
  INIZIO_VALIDITA DATE,
  FINE_VALIDITA DATE,
  PERMESSI          VARCHAR2(20),
  FILTRO_FUNZIONI   VARCHAR2(20),
  FILTRO_ANAGRAFE   VARCHAR2(20),
  FILTRO_DIZIONARIO VARCHAR2(20)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table MONDOEDP.I061_PROFILI_DIPENDENTE
  add constraint I061_PK primary key (AZIENDA, NOME_UTENTE, NOME_PROFILO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

DECLARE 
  CURSOR C1 IS
    SELECT  *
      FROM MONDOEDP.I060_LOGIN_DIPENDENTE;
    FILTROANAG VARCHAR2(20);
BEGIN
  -- TEST STATEMENTS HERE
  FOR T1 IN C1 LOOP
      FILTROANAG:='RESPONSABILE';
      IF T1.FILTRO_ANAGRAFE IS NULL THEN
         FILTROANAG:='DIPENDENTE';
      END IF;
      BEGIN
      INSERT INTO MONDOEDP.I061_PROFILI_DIPENDENTE(AZIENDA, NOME_UTENTE, NOME_PROFILO, PERMESSI, FILTRO_FUNZIONI, FILTRO_ANAGRAFE, FILTRO_DIZIONARIO, INIZIO_VALIDITA, FINE_VALIDITA)
      VALUES(T1.AZIENDA, T1.NOME_UTENTE, FILTROANAG, T1.PERMESSI, T1.FILTRO_FUNZIONI, T1.FILTRO_ANAGRAFE, T1.FILTRO_DIZIONARIO, TO_DATE('01/01/1900','DD/MM/YYYY'), TO_DATE('31/12/3999','DD/MM/YYYY'));
      EXCEPTION
      WHEN OTHERS THEN
        NULL;
      END;
  END LOOP; 
  COMMIT;
END;
/

COMMENT ON COLUMN P430_ANAGRAFICO.CONGUAGLIO
  IS 'Conguaglio IRPEF (C/T/S/N)';

INSERT INTO P452_DATIMENSILIDESC
SELECT 'PCITS', 'Perc. manuale IRPEF tassazione separata', 'N', 5, '', 'A' FROM DUAL
WHERE NOT EXISTS 
  (SELECT 'X' FROM P452_DATIMENSILIDESC T WHERE T.COD_CAMPO='PCITS');

update t911_datiriepilogo set caption = caption || ':' 
where caption is not null and (banda = 'I' or codice in (select codice from t910_riepilogo where tipo = 'S'));

ALTER TABLE P022_CAAF MODIFY CODICE_FISCALE VARCHAR2(16);

comment on column P212_PARAMETRISTIPENDI.TIPO_CALCOLO_IMPORTO13A
  is 'Tipo calcolo importo/metodologia di maturazione tredicesima: UM=considerando solo la retribuzione dell''ultimo mese; RM=considerando la retribuzione di tutti i mesi; UD=considerando 1/12 della retribuzione corrisposta nell''anno; MT=maturazione in 365esimi';

alter table MONDOEDP.I071_PERMESSI add DATIC700 VARCHAR2(200);
comment on column MONDOEDP.I071_PERMESSI.DATIC700 is 'Dati anagrafici da visualizzare sulla frmSelAnagrafe';

update t951_stampacartellino_dati set riga = replace(riga,'[N]Turni reperibilità','[N]Turni reperib./guardia');

alter table T020_ORARI add PM_OREMINIME_INF varchar2(5);
comment on column T020_ORARI.PM_OREMINIME_INF is 'ore minime per applicare lo stacco intermedio specificato in PM_STACCO_INF';
alter table T020_ORARI add PM_STACCO_INF varchar2(5);
comment on column T020_ORARI.PM_STACCO_INF is 'stacco mensa alternativo se le ore rese sono inferiori alle minime ma raggiungono PM_OREMINIME_INF';
CREATE TABLE SG506_20080926 AS SELECT * FROM SG506_PIANTADISTRIBUZIONE;

UPDATE SG506_PIANTADISTRIBUZIONE SET INIZIO = TO_DATE('01011900','DDMMYYYY'), FINE = TO_DATE('31123999','DDMMYYYY') WHERE INIZIO IS NULL;

ALTER TABLE SG506_PIANTADISTRIBUZIONE DROP PRIMARY KEY;
alter table SG506_PIANTADISTRIBUZIONE
  add constraint SG506_PK primary key (ID_RAMO, INIZIO)
  using index  tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);

DROP INDEX SG506_IDX;
create unique index SG506_IDX on SG506_PIANTADISTRIBUZIONE (ID_PIANTA, ID_PADRE, LIVELLO, NOME_CAMPO, VALORE_CAMPO, INIZIO)
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

----- ASSENTEISMO ------

create table T255_TIPOACCORPCAUSALI
( COD_TIPOACCORPCAUSALI VARCHAR2(5) not null,
  DESCRIZIONE              VARCHAR2(40))
 tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T255_TIPOACCORPCAUSALI
  add constraint T255_PK primary key (COD_TIPOACCORPCAUSALI)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T256_CODICIACCORPCAUSALI
( COD_TIPOACCORPCAUSALI   VARCHAR2(5) not null,
  COD_CODICIACCORPCAUSALI VARCHAR2(5) not null,
  DESCRIZIONE                VARCHAR2(80))
 tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T256_CODICIACCORPCAUSALI
  add constraint T256_PK primary key (COD_TIPOACCORPCAUSALI, COD_CODICIACCORPCAUSALI)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T256_CODICIACCORPCAUSALI
  add constraint T256_FK_T255 foreign key (COD_TIPOACCORPCAUSALI)
  references T255_TIPOACCORPCAUSALI (COD_TIPOACCORPCAUSALI) on delete cascade;

create table T257_ACCORPCAUSALI
( COD_TIPOACCORPCAUSALI   VARCHAR2(5) not null,
  COD_CODICIACCORPCAUSALI VARCHAR2(5) not null,
  COD_CAUSALE                VARCHAR2(5) not null,
  DECORRENZA                 DATE not null,
  DECORRENZA_FINE       DATE)
 tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T257_ACCORPCAUSALI
  add constraint T257_PK primary key (COD_TIPOACCORPCAUSALI, COD_CODICIACCORPCAUSALI, COD_CAUSALE, DECORRENZA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T257_ACCORPCAUSALI
  add constraint T257_FK_T256 foreign key (COD_TIPOACCORPCAUSALI, COD_CODICIACCORPCAUSALI)
  references T256_CODICIACCORPCAUSALI (COD_TIPOACCORPCAUSALI, COD_CODICIACCORPCAUSALI) on delete cascade;

create table T105_RICHIESTETIMBRATURE
(
  PROGRESSIVO    NUMBER(8),
  DATA            DATE,
  ORA VARCHAR2(5),
  VERSO VARCHAR2(1),
  CAUSALE VARCHAR2(5),
  NOTE1          VARCHAR2(1000),
  NOTE2          VARCHAR2(1000),
  OPERAZIONE VARCHAR2(1),
  VERSO_NEW VARCHAR2(1),
  CAUSALE_NEW VARCHAR2(5),
  AUTORIZZAZIONE VARCHAR2(1),
  RESPONSABILE VARCHAR2(20),
  ELABORATO      VARCHAR2(1) default 'N'
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T105_RICHIESTETIMBRATURE.NOTE1 is 'Note Richiesta';
comment on column T105_RICHIESTETIMBRATURE.NOTE2 is 'Note Autorizzazione';
comment on column T105_RICHIESTETIMBRATURE.AUTORIZZAZIONE is 'S = Autorizzato - N = Non autorizzato';
comment on column T105_RICHIESTETIMBRATURE.ELABORATO is 'S = Elaborato - N = Non elaborato';

-- Rimozione vecchio errore TFS e TFR su 00305 15075
DELETE P201_ASSOGGETTAMENTI P201 
WHERE P201.COD_CONTRATTO='EDP' 
AND P201.COD_VOCE_PADRE='00305' AND P201.COD_VOCE_SPECIALE_PADRE='15075'
AND P201.COD_VOCE_FIGLIO IN('10040','10045','10070','10075','14120') 
AND P201.COD_VOCE_SPECIALE_FIGLIO='BASE';

alter table T901_STAMPABASE_DATI disable constraint T901_FK_T900;
update t900_stampabase      SET CODICEINTERNO = 'A002' where CODICEINTERNO = 'A002F';
update  t901_stampabase_dati SET CODICEINTERNO = 'A002' where CODICEINTERNO = 'A002F';
alter table T901_STAMPABASE_DATI enable constraint T901_FK_T900;

alter table T545_TIPITURNO add DESCRIZIONE varchar2(40);
alter table T545_TIPITURNO add COMANDATO varchar2(1) default 'N';
alter table T550_APPARATI add DOTAZ_RADIO varchar2(1) default 'N';
comment on column T550_APPARATI.DOTAZ_RADIO is 'Mezzo con Radio a bordo';
alter table T502_PATTUGLIE add COMANDATO varchar2(1) default 'N';
alter table T500_PIANIFSERVIZI add STATO varchar2(1) default 'A';
comment on column T500_PIANIFSERVIZI.STATO is 'A=Aperto - C=Chiuso';

alter table T540_SERVIZI modify CODICE varchar2(10);
alter table T545_TIPITURNO modify CODICE varchar2(10);
alter table T500_PIANIFSERVIZI modify TIPO_TURNO varchar2(10);
alter table T500_PIANIFSERVIZI modify SERVIZIO varchar2(10);
alter table T500_PIANIFSERVIZI add ORDINE number(8);
alter table T520_TEMPLATE_SERVIZI modify TIPO_TURNO varchar2(10);
alter table T550_APPARATI modify CODICE varchar2(10);
alter table T501_PIANIFAPPARATI modify CODICE varchar2(10);

alter table MONDOEDP.I071_PERMESSI add SERVIZI_BLOCCO varchar2(1) default 'N';
comment on column MONDOEDP.I071_PERMESSI.SERVIZI_BLOCCO is 'S=consente di bloccare la Pianificazione dei Servizi dei vigili';
alter table MONDOEDP.I071_PERMESSI add SERVIZI_SBLOCCO varchar2(1) default 'N';
comment on column MONDOEDP.I071_PERMESSI.SERVIZI_SBLOCCO is 'S=consente di sbloccare la Pianificazione dei Servizi dei vigili';
comment on column MONDOEDP.I071_PERMESSI.SERVIZI_COMANDATI is 'C=solo servizi comandati - N=solo servizi non comandati - T=Tutti i servizi';

alter table T545_TIPITURNO add constraint T545_PK primary key (CODICE) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T530_CONFIGSERVIZI (
  DATA_PRIMOGGLAV DATE,
  DATA_PRIMOGGFES DATE,
  ALTERNANZA_GGLAV NUMBER(3),
  ALTERNANZA_GGFES NUMBER(3),
  GGCHIUSURA NUMBER(3),
  CALENDARIO VARCHAR2(5)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T021_FASCEORARI add NOTTE_USCITA varchar2(1) default 'N';

alter table MONDOEDP.I071_PERMESSI add WEB_ITERTIMB_GGPREC number(3) default -1;
alter table MONDOEDP.I071_PERMESSI add WEB_ITERASS_GGPREC number(3) default -1;
alter table MONDOEDP.I071_PERMESSI add WEB_ITERASS_GGSUCC number(3) default -1;
alter table MONDOEDP.I071_PERMESSI add WEB_CARTELLINI_DATAMIN date default to_date('01012000','ddmmyyyy');
alter table MONDOEDP.I071_PERMESSI add WEB_CARTELLINI_MMPREC number(3) default -1;
alter table MONDOEDP.I071_PERMESSI add WEB_CARTELLINI_MMSUCC number(3) default 0;
alter table MONDOEDP.I071_PERMESSI add WEB_CARTELLINI_CHIUSI varchar2(1) default 'N';
alter table MONDOEDP.I071_PERMESSI add WEB_CEDOLINI_DATAMIN date default to_date('01012000','ddmmyyyy');
alter table MONDOEDP.I071_PERMESSI add WEB_CEDOLINI_MMPREC number(3) default -1;
alter table MONDOEDP.I071_PERMESSI add WEB_CEDOLINI_GGEMISS number(2) default -1;

update MONDOEDP.I071_PERMESSI set WEB_CEDOLINI_DATAMIN = (select max(nvl(CEDOLINO_WEB_DAL,to_date('01012000','ddmmyyyy'))) from MONDOEDP.P150_SETUP);
update MONDOEDP.I071_PERMESSI set WEB_CEDOLINI_GGEMISS = (select max(nvl(CEDOLINO_WEB_GG_EMISS,0)) from MONDOEDP.P150_SETUP);

alter table T620_TURNAZIND add VERIFICA_RIPOSI VARCHAR2(1) default 'S';
alter table T620_TURNAZIND add VERIFICA_TURNI VARCHAR2(1) default 'S';
comment on column T620_TURNAZIND.VERIFICA_RIPOSI is 'N=Verifica turni impedita sui giorni di riposo';
comment on column T620_TURNAZIND.VERIFICA_TURNI is 'N=Verifica turni impedita sui giorni pianificati con turni';

ALTER TABLE P552_CONTOANNREGOLE MODIFY VALORE_COSTANTE VARCHAR2(200);

-- Imposto regola FLUPER per fine rapporto vuota se antecedente al mese
-- di elaborazione
update p660_flussiregole set 
  regola_calcolo_manuale = 
    'SELECT DECODE(SIGN(:DATAELABORAZIONE - LAST_DAY(FINE)),-1,'''',FINE)
       FROM T430_STORICO WHERE PROGRESSIVO=:PROGRESSIVO

       AND :DATAELABORAZIONE BETWEEN DATADECORRENZA AND DATAFINE',
   regola_calcolo_automatica =  
    'SELECT DECODE(SIGN(:DATAELABORAZIONE - LAST_DAY(FINE)),-1,'''',FINE)
       FROM T430_STORICO WHERE PROGRESSIVO=:PROGRESSIVO
       AND :DATAELABORAZIONE BETWEEN DATADECORRENZA AND DATAFINE'
  where nome_flusso = 'FLUPER' and parte = 'A' and numero = '023' and regola_calcolo_manuale is null;

create table T485_MEDICINELEGALI (
CODICE         varchar2(10) not null,
DESCRIZIONE    varchar2(60),
COD_COMUNE     varchar2(6),
INDIRIZZO      varchar2(40),
CAP            varchar2(5),
TELEFONO       varchar2(15),
EMAIL          varchar2(40)
)
tablespace LAVORO
storage (initial 256K next 256K pctincrease 0);

comment on table T485_MEDICINELEGALI is 'Medicine legali';
comment on column T485_MEDICINELEGALI.COD_COMUNE
  is 'Comune di ubicazione della medicina legale';

alter table T485_MEDICINELEGALI
  add constraint T485_PK primary key (CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T485_MEDICINELEGALI
  add constraint T485_FK_T480 foreign key (COD_COMUNE)
  references T480_COMUNI (CODICE) on delete cascade;

create table T486_COMUNI_MEDLEGALI (
COD_COMUNE      varchar2(6)  not null,
MED_LEGALE      varchar2(10) not null
)
tablespace LAVORO
storage (initial 256K next 256K pctincrease 0);

comment on column T486_COMUNI_MEDLEGALI.COD_COMUNE
  is 'Codice istat comune da associare alla medicina legale';
  
comment on column T486_COMUNI_MEDLEGALI.MED_LEGALE
  is 'Medicina legale associata al comune';  

alter table T486_COMUNI_MEDLEGALI
  add constraint T486_PK primary key (COD_COMUNE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
  
alter table T486_COMUNI_MEDLEGALI
  add constraint T486_FK_T480 foreign key (COD_COMUNE)
  references T480_COMUNI (CODICE) on delete cascade;

alter table T486_COMUNI_MEDLEGALI
  add constraint T486_FK_T485 foreign key (MED_LEGALE)
  references T485_MEDICINELEGALI (CODICE) on delete cascade;

create table T047_VISITEFISCALI(
TIPO_EVENTO               varchar2(2) not null,
PROGRESSIVO               number      not null,
OPERAZIONE                varchar2(1) not null,
DATA_INIZIO_ASSENZA       date        not null,
DATA_FINE_ASSENZA         date,
NUOVA_DATA_FINE           date,
DATA_REGISTRAZIONE        date,    
DATA_PRIMA_COMUNICAZIONE  date,
DATA_REGIS_PROLUNGAMENTO  date,    
DATA_COMUN_PROLUNGAMENTO  date,
COD_COMUNE                varchar2(6),
INDIRIZZO                 varchar2(40),
CAP                       varchar2(5),
TELEFONO                  varchar2(15)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T047_VISITEFISCALI.TIPO_EVENTO
  is 'Tipo di evento che ha generato la comunicazione di una visita fiscale';
comment on column T047_VISITEFISCALI.PROGRESSIVO
  is 'Progressivo dell''anagrafico per cui si comunica la visita fiscale';
comment on column T047_VISITEFISCALI.OPERAZIONE
  is 'I=Inserimento, C=Cancellazione (relativa ai dati già comunicati. Per i dati non ancora comunicati viene eliminato direttamente il record)';
comment on column T047_VISITEFISCALI.DATA_INIZIO_ASSENZA
  is 'Data di inizio del periodo di assenza';
comment on column T047_VISITEFISCALI.DATA_FINE_ASSENZA
  is 'Data di fine del periodo di assenza';
comment on column T047_VISITEFISCALI.NUOVA_DATA_FINE
  is 'Nuova data di fine assenza in seguito a prolungamento';
comment on column T047_VISITEFISCALI.DATA_REGISTRAZIONE
  is 'Data di registrazione, comprensiva di ore e minuti';
comment on column T047_VISITEFISCALI.DATA_PRIMA_COMUNICAZIONE
  is 'Data di prima comunicazione dell''evento';
comment on column T047_VISITEFISCALI.DATA_REGIS_PROLUNGAMENTO
  is 'Data di registrazione del prolungamento, comprensiva di ore e minuti';
comment on column T047_VISITEFISCALI.DATA_COMUN_PROLUNGAMENTO
  is 'Data di comunicazione del prolungamento'; 
comment on column T047_VISITEFISCALI.COD_COMUNE
  is 'Codice comune per il recapito. Dato presente solo nel caso in cui sia diverso dal domicilio (vedi P500_CUDSETUP.COM_DOM_POSTEL per l''anno di rif.)';   
comment on column T047_VISITEFISCALI.INDIRIZZO
  is 'Indirizzo per il recapito. Dato presente solo nel caso in cui sia diverso dal domicilio (vedi P500_CUDSETUP.IND_DOM_POSTEL per l''anno di rif.)';
comment on column T047_VISITEFISCALI.CAP
  is 'CAP per il recapito. Dato presente solo nel caso in cui sia diverso dal domicilio (vedi P500_CUDSETUP.CAP_DOM_POSTEL per l''anno di rif.)';

alter table T047_VISITEFISCALI
  add constraint T047_PK primary key (TIPO_EVENTO, PROGRESSIVO, OPERAZIONE, DATA_INIZIO_ASSENZA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T047_VISITEFISCALI
  add constraint T047_FK_T480 foreign key (COD_COMUNE)
  references T480_COMUNI (CODICE) on delete cascade;

alter table T047_VISITEFISCALI
  add constraint T047_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO) on delete cascade;

alter table T265_CAUASSENZE add VISITA_FISCALE varchar2(1) default 'N';
comment on column T265_CAUASSENZE.VISITA_FISCALE
  is 'S per causale di assenza da comunicare per visite fiscali, N altrimenti';

create table I021_LOG_JOB
( DATAORA         DATE,
  MESSAGGIO       VARCHAR2(4000)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

create table SG720_PROFILI_AREE
(
  DECORRENZA        DATE              not null,
  DECORRENZA_FINE   DATE                      ,
  DATO1      VARCHAR2(20) default ' ' not null,
  DATO2      VARCHAR2(20) default ' ' not null,
  DATO3      VARCHAR2(20) default ' ' not null,
  DATO4      VARCHAR2(20) default ' ' not null,
  COD_AREA   VARCHAR2(5)              not null
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG720_PROFILI_AREE
  add constraint SG720_PK primary key (DECORRENZA, DATO1, DATO2, DATO3, DATO4, COD_AREA)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG701_AREE_VALUTAZIONI
(
  COD_AREA          VARCHAR2(5)   not null,
  DECORRENZA        DATE          not null,
  DECORRENZA_FINE   DATE                  ,
  DESCRIZIONE       VARCHAR2(100) not null,
  PESO_PERCENTUALE  NUMBER(5,2)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG701_AREE_VALUTAZIONI
  add constraint SG701_PK primary key (COD_AREA, DECORRENZA)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG700_VALUTAZIONI
(
  COD_AREA         VARCHAR2(5)  not null,
  DECORRENZA       DATE         not null,
  COD_VALUTAZIONE  VARCHAR2(5)  not null,
  DESCRIZIONE      VARCHAR2(500)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);


alter table SG700_VALUTAZIONI
  add constraint SG700_PK primary key (COD_AREA, DECORRENZA, COD_VALUTAZIONE)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table SG700_VALUTAZIONI
  add constraint SG700_FK_SG701 foreign key (COD_AREA, DECORRENZA)
  references SG701_AREE_VALUTAZIONI (COD_AREA, DECORRENZA) ON DELETE CASCADE;

create table SG705_VALUTATORI
(
  DATO              VARCHAR2(80)  not null,
  PROGRESSIVO       NUMBER(8)     not null,
  DECORRENZA        DATE          not null,
  DECORRENZA_FINE   DATE                  ,
  OPERATORE         VARCHAR2(30)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG705_VALUTATORI
  add constraint SG705_PK primary key (DATO, DECORRENZA)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG706_VALUTATORI_DIPENDENTE
(
  PROGRESSIVO             NUMBER(8) not null,
  DECORRENZA              DATE      not null,
  DECORRENZA_FINE         DATE      not null,
  PROGRESSIVO_VALUTATO    NUMBER(8) not null
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG706_VALUTATORI_DIPENDENTE
  add constraint SG706_PK primary key (PROGRESSIVO, DECORRENZA, PROGRESSIVO_VALUTATO)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG710_TESTATA_VALUTAZIONI
(
  DATA                     DATE           not null,
  PROGRESSIVO              NUMBER(8)      not null,
  TIPO_VALUTAZIONE         VARCHAR2(1)    not null,
  VALUTAZIONE_COMPLESSIVE  VARCHAR2(500)          ,
  OBIETTIVI_AZIONI         VARCHAR2(500)          ,
  PROPOSTE_FORMATIVE       VARCHAR2(500)          ,
  COMMENTI_VALUTATO        VARCHAR2(500)          ,
  DATA_COMPILAZIONE        DATE                   ,
  TIPO_STAMPA              VARCHAR2(1)    default 'C' not null
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG710_TESTATA_VALUTAZIONI
  add constraint SG710_PK primary key (DATA, PROGRESSIVO, TIPO_VALUTAZIONE)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG711_VALUTAZIONI_DIPENDENTE
(
  DATA                    DATE                    not null,
  PROGRESSIVO             NUMBER(8)               not null,
  TIPO_VALUTAZIONE        VARCHAR2(1)             not null,
  COD_AREA                VARCHAR2(5)             not null,
  COD_VALUTAZIONE         VARCHAR2(5)             not null,
  VALUTABILE              VARCHAR2(1) default 'S'         ,
  PUNTEGGIO               NUMBER(8,2)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG711_VALUTAZIONI_DIPENDENTE
  add constraint SG711_PK primary key (DATA, PROGRESSIVO, TIPO_VALUTAZIONE, COD_AREA, COD_VALUTAZIONE)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG730_PUNTEGGI
(
  DECORRENZA      DATE          not null,
  DECORRENZA_FINE DATE                  ,
  PUNTEGGIO       NUMBER(8,2)   not null,
  DESCRIZIONE     VARCHAR2(200)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG730_PUNTEGGI
  add constraint SG730_PK primary key (DECORRENZA, PUNTEGGIO)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table MONDOEDP.I071_PERMESSI add S710_SUPERVISOREVALUT varchar2(1) default 'N';

alter table SG402_TESTATARISCHI add TIPO_ATTIVITA varchar2(5);
alter table SG402_TESTATARISCHI add TIPO_ESPOSIZIONE varchar2(5);

create table SG405_TIPOATTIVITA
(
  CODICE      VARCHAR2(5) not null,
  DESCRIZIONE VARCHAR2(100)
)
  tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG405_TIPOATTIVITA
  add constraint SG405_PK primary key (CODICE)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG406_TIPOESPOSIZIONE
(
  CODICE      VARCHAR2(5) not null,
  DESCRIZIONE VARCHAR2(100)
)
  tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG406_TIPOESPOSIZIONE
  add constraint SG406_PK primary key (CODICE)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T032_FOTODIPENDENTE
(
  PROGRESSIVO number(8) not null,
  FOTO BLOB
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T032_FOTODIPENDENTE
  add constraint T032_PK primary key (PROGRESSIVO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column P150_SETUP.CEDOLINO_WEB_DAL
  is 'Mese di inizio abilitazione cedolino web (non utilizzato)';
comment on column P150_SETUP.CEDOLINO_WEB_GG_EMISS
  is 'Giorni di ritardo da data emissione per web (non utilizzato)';

-- Rimozione vecchio errore TFS e TFR su 00305 15075
DELETE P201_ASSOGGETTAMENTI P201 
WHERE P201.COD_CONTRATTO='EDP' 
AND P201.COD_VOCE_PADRE IN ('00305','00307') AND P201.COD_VOCE_SPECIALE_PADRE='15075'
AND P201.COD_VOCE_FIGLIO IN('10040','10045','10070','10075','14120') 
AND P201.COD_VOCE_SPECIALE_FIGLIO='BASE';

------ Conversione INCENTIVI -------

ALTER TABLE T760_REGOLEINCENTIVI ADD PROPORZIONE_PARTTIME VARCHAR2(1) DEFAULT 'N';
comment on column T760_REGOLEINCENTIVI.PROPORZIONE_PARTTIME is 'Considera o meno il proporzionamento sulla % di part-time';
ALTER TABLE T760_REGOLEINCENTIVI ADD QUOTA_SCARICOPAGHE VARCHAR2(1) DEFAULT '3';
comment on column T760_REGOLEINCENTIVI.QUOTA_SCARICOPAGHE is 'Tipologia di importo quote da scaricare alle Paghe';
UPDATE T760_REGOLEINCENTIVI SET PROPORZIONE_PARTTIME = 'S' WHERE TIPO = 'C';
UPDATE T760_REGOLEINCENTIVI SET PROPORZIONE_PARTTIME = 'N' WHERE TIPO <> 'C';
UPDATE T760_REGOLEINCENTIVI SET PROPORZIONE_INCENTIVI = '1' WHERE TIPO <> 'C';
UPDATE T760_REGOLEINCENTIVI SET GESTIONE_FRANCHIGIA = 'A' WHERE TIPO <> 'C';
COMMIT;
comment on column T760_REGOLEINCENTIVI.ASSENZE is 'OLD: non più usato';
comment on column T760_REGOLEINCENTIVI.FRANCHIGIA_ASSENZE is 'OLD: non più usato';
comment on column T760_REGOLEINCENTIVI.ASSENZE_TOLLERATE_FRANCHIGIA is 'OLD: non più usato';
comment on column T760_REGOLEINCENTIVI.GESTIONE_FRANCHIGIA is 'OLD: non più usato';
-- Conversione regole da <INCENTIVI:REGOLE> a <INCENTIVI:DATO1>
CREATE TABLE T760_20081024 AS SELECT * FROM T760_REGOLEINCENTIVI;
DECLARE
  CURSOR C1 IS
    SELECT * FROM T760_REGOLEINCENTIVI T760;
  CURSOR C2 IS
    SELECT DISTINCT DATO1 FROM T770_QUOTE;
BEGIN
  FOR T1 IN C1 LOOP
    IF T1.LIVELLO = '<UNICA>' THEN
      FOR T2 IN C2 LOOP
        INSERT INTO T760_REGOLEINCENTIVI 
      (LIVELLO,ELENCOLIV,TIPO,ABBATTIMENTO_MAX,PROPORZIONE_INCENTIVI,PROPORZIONE_PARTTIME,DECORRENZA,
    ASSENZE,FRANCHIGIA_ASSENZE,ASSENZE_TOLLERATE_FRANCHIGIA,GESTIONE_FRANCHIGIA)
        VALUES
(T2.DATO1,T1.ELENCOLIV,T1.TIPO,T1.ABBATTIMENTO_MAX,T1.PROPORZIONE_INCENTIVI,T1.PROPORZIONE_PARTTIME,T1.DECORRENZA,         T1.ASSENZE,T1.FRANCHIGIA_ASSENZE,T1.ASSENZE_TOLLERATE_FRANCHIGIA,T1.GESTIONE_FRANCHIGIA);
      END LOOP;
    END IF;
  END LOOP;
  DELETE FROM T760_REGOLEINCENTIVI WHERE LIVELLO = '<UNICA>';
  COMMIT;
END;
/
CREATE TABLE T766_INCENTIVITIPOABBAT
( CODICE             VARCHAR2(5),
  DESCRIZIONE        VARCHAR2(40),
  RISPARMIO_BILANCIO VARCHAR2(1) default 'N')
  tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
ALTER TABLE T766_INCENTIVITIPOABBAT
  add constraint T766_PK primary key (CODICE)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

ALTER TABLE T769_INCENTIVIASSENZE ADD DECORRENZA_FINE DATE;
ALTER TABLE T769_INCENTIVIASSENZE ADD COD_TIPOACCORPCAUSALI VARCHAR2(5);
comment on column T769_INCENTIVIASSENZE.COD_TIPOACCORPCAUSALI is 'Tipo accorpamento causali assenza';
ALTER TABLE T769_INCENTIVIASSENZE ADD COD_CODICIACCORPCAUSALI VARCHAR2(5);
comment on column T769_INCENTIVIASSENZE.COD_CODICIACCORPCAUSALI is 'Codice accorpamento causali assenza';
ALTER TABLE T769_INCENTIVIASSENZE ADD FRANCHIGIA_ASSENZE NUMBER(3);
comment on column T769_INCENTIVIASSENZE.FRANCHIGIA_ASSENZE is 'Franchigia dell''accorpamento causali assenza';
ALTER TABLE T769_INCENTIVIASSENZE ADD GESTIONE_FRANCHIGIA VARCHAR2(1) DEFAULT 'R';
comment on column T769_INCENTIVIASSENZE.GESTIONE_FRANCHIGIA is 'Gestione della franchigia';
ALTER TABLE T769_INCENTIVIASSENZE ADD CONTA_FRUITO_ORE VARCHAR2(1) DEFAULT 'N';
comment on column T769_INCENTIVIASSENZE.CONTA_FRUITO_ORE is 'Considera o meno il fruito in ore';
ALTER TABLE T769_INCENTIVIASSENZE ADD TIPO_ABBATTIMENTO VARCHAR2(5);
comment on column T769_INCENTIVIASSENZE.TIPO_ABBATTIMENTO is 'Tipologia di abbattimento degli incentivi';

CREATE TABLE T769_20081024 AS SELECT * FROM T769_INCENTIVIASSENZE;
TRUNCATE TABLE T769_INCENTIVIASSENZE;
ALTER TABLE T769_INCENTIVIASSENZE DROP PRIMARY KEY;
DROP INDEX T769_PK;
alter table T769_INCENTIVIASSENZE
  add constraint T769_PK primary key (DATO1, DATO2, DATO3, DECORRENZA, COD_TIPOACCORPCAUSALI, COD_CODICIACCORPCAUSALI,CAUSALE)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

INSERT INTO T255_TIPOACCORPCAUSALI (COD_TIPOACCORPCAUSALI, DESCRIZIONE)
VALUES ('_INC', 'INCENTIVI');
INSERT INTO T256_CODICIACCORPCAUSALI (COD_TIPOACCORPCAUSALI,COD_CODICIACCORPCAUSALI,DESCRIZIONE)
VALUES ('_INC','_FRA','ASSENZE TOLLERATE NELLA FRANCHIGIA');
INSERT INTO T256_CODICIACCORPCAUSALI (COD_TIPOACCORPCAUSALI,COD_CODICIACCORPCAUSALI,DESCRIZIONE)
VALUES ('_INC','_NOT','ASSENZE NON TOLLERATE');
INSERT INTO T256_CODICIACCORPCAUSALI (COD_TIPOACCORPCAUSALI,COD_CODICIACCORPCAUSALI,DESCRIZIONE)
VALUES ('_INC','_TOLL','ASSENZE TOLLERATE');
COMMIT;

-- Creo nuovi accorpamenti assenza e relative regole per 'Assenze tollerate'
DECLARE
  CURSOR C1 IS
    SELECT LIVELLO, ASSENZE, GESTIONE_FRANCHIGIA FROM T760_REGOLEINCENTIVI T760
     WHERE DECORRENZA = (SELECT MAX(DECORRENZA) FROM T760_REGOLEINCENTIVI
                          WHERE LIVELLO = T760.LIVELLO)
       AND ASSENZE IS NOT NULL; 
  S VARCHAR2(2000);
  CAUS VARCHAR2(5);
BEGIN
  S:='';
  CAUS:='';
  SELECT ASSENZE INTO S FROM T760_REGOLEINCENTIVI WHERE ROWNUM = 1;
  WHILE S <> ' ' LOOP
    IF INSTR(S,',') > 0 THEN
      CAUS:=SUBSTR(S,1,INSTR(S,',')-1);
    ELSE
      CAUS:=S;
    END IF;
    INSERT INTO T257_ACCORPCAUSALI (cod_tipoaccorpcausali, cod_codiciaccorpcausali, cod_causale, decorrenza, decorrenza_fine)
    VALUES('_INC','_TOLL',CAUS,TO_DATE('01011900','DDMMYYYY'),TO_DATE('31123999','DDMMYYYY'));
    IF INSTR(S,',') > 0 THEN
      S:=SUBSTR(S,INSTR(S,',')+1,LENGTH(S)-INSTR(S,','));
    ELSE
      S:=' ';
    END IF;
  END LOOP;
  FOR T1 IN C1 LOOP
    INSERT INTO T769_INCENTIVIASSENZE
    (dato1, dato2, dato3, decorrenza, causale, perc_abbattimento, perc_abb_franchigia, forza_abb_ggint,
     cod_tipoaccorpcausali, cod_codiciaccorpcausali, franchigia_assenze, gestione_franchigia, conta_fruito_ore, tipo_abbattimento)
    VALUES
    (T1.LIVELLO,' ',' ',TO_DATE('01011900','DDMMYYYY'),' ',100,100,'N',
     '_INC','_TOLL',0,'Z','N',' ');
  END LOOP;
  COMMIT;
END;
/
-- Creo nuovi accorpamenti assenza e relative regole per 'Assenze tollerate nella franchigia'
DECLARE
  CURSOR C1 IS
    SELECT LIVELLO, ASSENZE_TOLLERATE_FRANCHIGIA ASSENZE, FRANCHIGIA_ASSENZE, GESTIONE_FRANCHIGIA FROM T760_REGOLEINCENTIVI T760
     WHERE DECORRENZA = (SELECT MAX(DECORRENZA) FROM T760_REGOLEINCENTIVI
                          WHERE LIVELLO = T760.LIVELLO)
       AND ASSENZE_TOLLERATE_FRANCHIGIA IS NOT NULL;
  S VARCHAR2(2000);
  CAUS VARCHAR2(5);
BEGIN
  S:='';
  CAUS:='';
  SELECT ASSENZE_TOLLERATE_FRANCHIGIA INTO S FROM T760_REGOLEINCENTIVI WHERE ROWNUM = 1;
  WHILE S <> ' ' LOOP
    IF INSTR(S,',') > 0 THEN
      CAUS:=SUBSTR(S,1,INSTR(S,',')-1);
    ELSE
      CAUS:=S;
    END IF;
    INSERT INTO T257_ACCORPCAUSALI (cod_tipoaccorpcausali, cod_codiciaccorpcausali, cod_causale, decorrenza, decorrenza_fine)
    VALUES('_INC','_FRA',CAUS,TO_DATE('01011900','DDMMYYYY'),TO_DATE('31123999','DDMMYYYY'));
    IF INSTR(S,',') > 0 THEN
      S:=SUBSTR(S,INSTR(S,',')+1,LENGTH(S)-INSTR(S,','));
    ELSE
      S:=' ';
    END IF;
  END LOOP;
  FOR T1 IN C1 LOOP
    INSERT INTO T769_INCENTIVIASSENZE
    (dato1, dato2, dato3, decorrenza, causale, perc_abbattimento, perc_abb_franchigia, forza_abb_ggint,
     cod_tipoaccorpcausali, cod_codiciaccorpcausali, franchigia_assenze, gestione_franchigia, conta_fruito_ore, tipo_abbattimento)
    VALUES
    (T1.LIVELLO,' ',' ',TO_DATE('01011900','DDMMYYYY'),' ',100,100,'N',
     '_INC','_FRA',T1.FRANCHIGIA_ASSENZE,T1.GESTIONE_FRANCHIGIA,'N',' ');
  END LOOP;
  COMMIT;
END;
/
-- Creo nuovi accorpamenti assenza e relative regole per 'Assenze NON tollerate'
DECLARE
  CURSOR C1 IS
    SELECT LIVELLO, ASSENZE_TOLLERATE_FRANCHIGIA, FRANCHIGIA_ASSENZE, GESTIONE_FRANCHIGIA FROM T760_REGOLEINCENTIVI T760
     WHERE DECORRENZA = (SELECT MAX(DECORRENZA) FROM T760_REGOLEINCENTIVI
                          WHERE LIVELLO = T760.LIVELLO);
BEGIN
  INSERT INTO T257_ACCORPCAUSALI (cod_tipoaccorpcausali, cod_codiciaccorpcausali, cod_causale, decorrenza, decorrenza_fine)
  SELECT '_INC','_NOT', CODICE, TO_DATE('01011900','DDMMYYYY'),TO_DATE('31123999','DDMMYYYY')
    FROM T265_CAUASSENZE
   WHERE CODICE NOT IN (SELECT COD_CAUSALE FROM T257_ACCORPCAUSALI);
  FOR T1 IN C1 LOOP
    IF T1.ASSENZE_TOLLERATE_FRANCHIGIA IS NOT NULL THEN
      INSERT INTO T769_INCENTIVIASSENZE
      (dato1, dato2, dato3, decorrenza, causale, perc_abbattimento, perc_abb_franchigia, forza_abb_ggint,
       cod_tipoaccorpcausali, cod_codiciaccorpcausali, franchigia_assenze, gestione_franchigia, conta_fruito_ore, tipo_abbattimento)
      VALUES
      (T1.LIVELLO,' ',' ',TO_DATE('01011900','DDMMYYYY'),' ',100,100,'N',
       '_INC','_NOT',0,T1.GESTIONE_FRANCHIGIA,'N',' ');
    ELSE
      INSERT INTO T769_INCENTIVIASSENZE
      (dato1, dato2, dato3, decorrenza, causale, perc_abbattimento, perc_abb_franchigia, forza_abb_ggint,
       cod_tipoaccorpcausali, cod_codiciaccorpcausali, franchigia_assenze, gestione_franchigia, conta_fruito_ore, tipo_abbattimento)
      VALUES
      (T1.LIVELLO,' ',' ',TO_DATE('01011900','DDMMYYYY'),' ',100,100,'N',
       '_INC','_NOT',T1.FRANCHIGIA_ASSENZE,T1.GESTIONE_FRANCHIGIA,'N',' ');
    END IF;
  END LOOP;
  COMMIT;
END;
/

DELETE FROM T256_CODICIACCORPCAUSALI WHERE COD_CODICIACCORPCAUSALI = '_TOLL';
DELETE FROM T257_ACCORPCAUSALI WHERE COD_CODICIACCORPCAUSALI = '_TOLL';
DELETE FROM T769_INCENTIVIASSENZE WHERE COD_CODICIACCORPCAUSALI = '_TOLL';
COMMIT;
UPDATE T769_INCENTIVIASSENZE SET CONTA_FRUITO_ORE = 'S';
UPDATE T769_INCENTIVIASSENZE SET DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY');
COMMIT;

ALTER TABLE T762_INCENTIVIMATURATI ADD TIPOIMPORTO VARCHAR2(5);
comment on column T762_INCENTIVIMATURATI.TIPOIMPORTO is 'Tipologia di importo (intera,proporzionata,netta)';
ALTER TABLE T762_INCENTIVIMATURATI ADD GIORNI NUMBER;
comment on column T762_INCENTIVIMATURATI.GIORNI is 'Giorni di maturazione';
comment on column T762_INCENTIVIMATURATI.FLAG is 'OLD: non più usato';
comment on column T762_INCENTIVIMATURATI.TIPO is 'Tipologia di calcolo (C o D)';
comment on column T762_INCENTIVIMATURATI.TIPOQUOTA is 'Codice quota di T765';
ALTER TABLE T762_INCENTIVIMATURATI MODIFY VARIAZIONI DEFAULT 0;
ALTER TABLE T762_INCENTIVIMATURATI MODIFY VAR_RISORSE DEFAULT 0;
CREATE TABLE T762_20081024 AS SELECT * FROM T762_INCENTIVIMATURATI;
UPDATE T762_INCENTIVIMATURATI SET TIPOIMPORTO = '3';
UPDATE T762_INCENTIVIMATURATI SET VARIAZIONI = 0 WHERE VARIAZIONI IS NULL;
UPDATE T762_INCENTIVIMATURATI SET VAR_RISORSE = 0 WHERE VAR_RISORSE IS NULL;
COMMIT;
ALTER TABLE T762_INCENTIVIMATURATI DROP PRIMARY KEY;
DROP INDEX T762_PK;
alter table T762_INCENTIVIMATURATI 
  add constraint T762_PK primary key (PROGRESSIVO, ANNO, MESE, TIPOQUOTA, TIPOIMPORTO)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

CREATE TABLE T763_20081024 AS SELECT * FROM T763_INCENTIVIABBATTIMENTI;
UPDATE T763_INCENTIVIABBATTIMENTI SET TIPOABBATTIMENTO = 'GS' WHERE TIPOABBATTIMENTO = 'LI';
COMMIT;
RENAME T761_INCENTIVI TO T761_OLD;

INSERT INTO T769_INCENTIVIASSENZE 
      (dato1, dato2, dato3, decorrenza, decorrenza_fine, causale, perc_abbattimento, perc_abb_franchigia, forza_abb_ggint,
       cod_tipoaccorpcausali, cod_codiciaccorpcausali, franchigia_assenze, gestione_franchigia, conta_fruito_ore, tipo_abbattimento)
SELECT dato1, dato2, dato3, decorrenza, to_date('31123999','ddmmyyyy'), causale, perc_abbattimento, perc_abb_franchigia, forza_abb_ggint,
       ' ', ' ', 0, 'Z', 'S', ' '
  FROM T769_20081024;
COMMIT;
UPDATE T769_INCENTIVIASSENZE SET FORZA_ABB_GGINT = 'N' WHERE FORZA_ABB_GGINT IS NULL;
COMMIT;

CREATE TABLE T195_20081024 AS SELECT * FROM T195_VOCIVARIABILI;
UPDATE MONDOEDP.I073_FILTROFUNZIONI SET FUNZIONE = 'OpenA160RegoleIncentivi' WHERE FUNZIONE = 'OpenA087RegIncent';
UPDATE MONDOEDP.I073_FILTROFUNZIONI SET FUNZIONE = 'OpenA162IncentiviAssenze' WHERE FUNZIONE = 'OpenA083IncentiviAssenze';
UPDATE MONDOEDP.I073_FILTROFUNZIONI SET FUNZIONE = 'OpenA164QuoteIncentivi' WHERE FUNZIONE = 'OpenA086QuoteIncentivi';
UPDATE MONDOEDP.I073_FILTROFUNZIONI SET FUNZIONE = 'OpenA165PenalizzIncentivi' WHERE FUNZIONE = 'OpenA119PenalizzIncentivi';
UPDATE MONDOEDP.I073_FILTROFUNZIONI SET FUNZIONE = 'OpenA166QuoteIndividuali' WHERE FUNZIONE = 'OpenA118QuoteIndividuali';
UPDATE MONDOEDP.I073_FILTROFUNZIONI SET FUNZIONE = 'OpenA167RegistraIncentivi' WHERE FUNZIONE = 'OpenA089RegistraIncentivi';
UPDATE MONDOEDP.I073_FILTROFUNZIONI SET FUNZIONE = 'OpenA168IncentiviMaturati' WHERE FUNZIONE = 'OpenA088IncentMat';
CREATE TABLE MONDOEDP.I091_20081024 AS SELECT * FROM MONDOEDP.I091_DATIENTE;
UPDATE MONDOEDP.I091_DATIENTE I091 SET DATO = (SELECT DATO FROM MONDOEDP.I091_DATIENTE WHERE AZIENDA = I091.AZIENDA AND TIPO = 'C7_REGOLE') WHERE TIPO = 'C7_DATO1' AND DATO IS NULL;
DELETE FROM MONDOEDP.I091_DATIENTE WHERE TIPO = 'C7_REGOLE';
DELETE FROM MONDOEDP.I091_DATIENTE WHERE TIPO = 'C7_DATACONVENZIONALE';

DECLARE
  CONTA INTEGER;
BEGIN
  CONTA:=0;
  SELECT COUNT(*) INTO CONTA FROM T760_REGOLEINCENTIVI;
  IF CONTA = 0 THEN
    DELETE FROM T255_TIPOACCORPCAUSALI WHERE COD_TIPOACCORPCAUSALI = '_INC';
    DELETE FROM T256_CODICIACCORPCAUSALI WHERE COD_TIPOACCORPCAUSALI = '_INC';
    DELETE FROM T257_ACCORPCAUSALI WHERE COD_TIPOACCORPCAUSALI = '_INC';
    COMMIT;
  END IF;
END;
/
------ Fine Conversione INCENTIVI -------

update T265_CAUASSENZE set codcau3 = null where trim(codcau3) is null and length(codcau3) > 0;
alter table T265_CAUASSENZE add SCARICOPAGHE_UM_PROP varchar2(1) default 'N';
comment on column T265_CAUASSENZE.SCARICOPAGHE_UM_PROP is 'S=Scarico paghe (cod.int.170) con unità di misura della causale e proporzionata in base a RETRIBUZIONE1';
comment on column T265_CAUASSENZE.CODCAU3 is 'Causale da usare nei primi 10 giorni del periodo al posto CODICE per L133';
comment on column T265_CAUASSENZE.CODCAU2 is 'Elenco delle causali da compongono il periodo consecutivo insieme a CODICE';

alter table P150_SETUP add ULTIMO_ANNO_RECUP number(4);
comment on column P150_SETUP.ULTIMO_ANNO_RECUP
  is 'Ultimo anno di cui sono stati recuperati i cedolini';
update P150_SETUP set ULTIMO_ANNO_RECUP = 
  (SELECT NVL(MAX(TO_CHAR(T.DATA_COMPETENZA_A,'YYYY')),2004) ULTIMO_ANNO_RECUP FROM P442_CEDOLINOVOCI T WHERE T.ORIGINE='E');

create table T925_SCHEDULAZIONI
(
  ID NUMBER(8),
  DATADD            varchar2(2),
  DATAMM           varchar2(2),
  DATAYY            varchar2(4),
  DATAHH           varchar2(5),
  GIORNO            varchar2(1)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

create table T926_STAMPESCHEDULATE
(
  ID NUMBER(8),
  APPLICAZIONE varchar2(6),
  CODICE_STAMPA varchar2(20),
  SELEZIONE varchar2(20),
  DAL varchar2(100)  ,
  AL varchar2(100),
  NOME_FILE varchar2(200),
  NOME_LOG varchar2(200),
  ROTTURA varchar2(100)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T926_STAMPESCHEDULATE modify DAL default 'trunc(trunc(SYSDATE),''mm'')';
alter table T926_STAMPESCHEDULATE modify AL default 'last_day(trunc(SYSDATE))';
alter table T926_STAMPESCHEDULATE modify ROTTURA default 'MATRICOLA';

alter table T926_STAMPESCHEDULATE add SEMAFORO varchar2(200);
alter table T926_STAMPESCHEDULATE add INTESTAZIONE_LOG varchar2(1000);
alter table T926_STAMPESCHEDULATE add DETTAGLIO_LOG varchar2(1000);
alter table T926_STAMPESCHEDULATE add CMD_AFTER varchar2(1000);

alter table T910_RIEPILOGO add FILTRO_INSERVIZIO varchar2(1) default 'T';
comment on column T910_RIEPILOGO.FILTRO_INSERVIZIO is 'T=Tutti - 0=Nessun giorno di servizio - 1=Almeno un giorno di servizio';
alter table T910_RIEPILOGO modify TABELLA_GENERATA varchar2(100);
