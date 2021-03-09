UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '7.0',PATCHDB = 0 WHERE AZIENDA = :AZIENDA;

comment on column SG506_PIANTADISTRIBUZIONE.NUMERO_CALCOLATI
  is 'Non utilizzato';
comment on column SG506_PIANTADISTRIBUZIONE.NUMERO_PERCENTUALE
  is 'Non utilizzato';
CREATE TABLE SG506_20070710 AS SELECT * FROM SG506_PIANTADISTRIBUZIONE;
UPDATE SG506_PIANTADISTRIBUZIONE T SET T.NUMERO_CALCOLATI = 0, T.NUMERO_PERCENTUALE = 0;
DECLARE
  CURSOR C1 IS SELECT SG506.*,SG506.ROWID FROM SG506_PIANTADISTRIBUZIONE SG506;
  LIV INTEGER;
BEGIN
  FOR T1 IN C1 LOOP
    SELECT MAX(LIVELLO) INTO LIV FROM SG506_PIANTADISTRIBUZIONE
     WHERE ID_PIANTA = (SELECT STRUTTURA_RIFERIMENTO FROM SG504_PIANTAORGANICA
                         WHERE ID_PIANTA = T1.ID_PIANTA);
    UPDATE SG506_PIANTADISTRIBUZIONE SET NUMERO_POSTI = 0
     WHERE ROWID = T1.ROWID
       AND LIVELLO <> LIV;
    COMMIT;
  END LOOP;
END;
/

-- Tabelle per esportazione dati per Contabilita' 
create table P590_CONTABREGOLE
(
  CONTO                   VARCHAR2(60) not null,
  DECORRENZA              DATE not null,
  DECORRENZA_FINE         DATE,
  DESCRIZIONE             VARCHAR2(200),
  DARE_AVERE              VARCHAR2(1) not null,
  COD_ARROTONDAMENTO      VARCHAR2(5),
  CODICI_ACCORPAMENTOVOCI VARCHAR2(100) not null,
  CAMBIO_SEGNO            VARCHAR2(1) default 'N' not null,
  FILTRO_DIPENDENTI       VARCHAR2(100),
  FILTRO_DATA_COMPETENZA  VARCHAR2(2) default 'TT' not null,
  ID_CONTO                VARCHAR2(60) not null
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
-- Add comments to the columns 
comment on column P590_CONTABREGOLE.DARE_AVERE
  is 'Dare o Avere (D/A)';
comment on column P590_CONTABREGOLE.COD_ARROTONDAMENTO
  is 'Codice arrotondamento';
comment on column P590_CONTABREGOLE.CODICI_ACCORPAMENTOVOCI
  is 'Accorpamento voci da inserire nel conto';
comment on column P590_CONTABREGOLE.CAMBIO_SEGNO
  is 'Cambio del segno dell''importo (S/N)';
comment on column P590_CONTABREGOLE.FILTRO_DIPENDENTI
  is 'Filtro dipendenti da inserire nel conto';
comment on column P590_CONTABREGOLE.FILTRO_DATA_COMPETENZA
  is 'Data competenza delle voci da inserire nel conto: TT=Qualsiasi, AC=Anno corrente, AP=Anni precedenti';
comment on column P590_CONTABREGOLE.ID_CONTO
  is 'Identificativo del conto sulla procedura di contabilita''';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P590_CONTABREGOLE 
  add constraint P590_PK primary key (CONTO, DECORRENZA, DARE_AVERE, CODICI_ACCORPAMENTOVOCI, CAMBIO_SEGNO, FILTRO_DIPENDENTI, FILTRO_DATA_COMPETENZA)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table P592_CONTABTESTATE
(
  DATA_FINE_MESE DATE not null,
  ID_CONTAB      NUMBER not null,
  CHIUSO         VARCHAR2(1) default 'N',
  DATA_CHIUSURA  DATE
) tablespace LAVORO storage (initial 16K next 64K pctincrease 0);
-- Add comments to the columns 
comment on column P592_CONTABTESTATE.DATA_FINE_MESE
  is 'Data di fine mese elaborato';
comment on column P592_CONTABTESTATE.CHIUSO
  is 'Chiuso (S/N)';
comment on column P592_CONTABTESTATE.DATA_CHIUSURA
  is 'Data chiusura del flusso';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P592_CONTABTESTATE
  add constraint P592_PK primary key (ID_CONTAB)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table P593_CONTABDATIINDIVIDUALI
(
  ID_CONTAB   	NUMBER not null,
  PROGRESSIVO 	NUMBER not null,
  CONTO       	VARCHAR2(60) not null,
  TIPO_RECORD 	VARCHAR2(1) not null,
  IMPORTO_DARE	NUMBER default 0 not null,
  IMPORTO_AVERE	NUMBER default 0 not null
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
-- Add comments to the columns 
comment on column P593_CONTABDATIINDIVIDUALI.PROGRESSIVO
  is 'Progressivo del dipendente, impostato a -1 per i dati riepilogativi';
comment on column P593_CONTABDATIINDIVIDUALI.CONTO
  is 'Numero conto in prima nota';
comment on column P593_CONTABDATIINDIVIDUALI.TIPO_RECORD
  is 'Tipo record: A=Automatico; M=Manuale';
comment on column P593_CONTABDATIINDIVIDUALI.IMPORTO_DARE 
  is 'Importo Dare del conto';
comment on column P593_CONTABDATIINDIVIDUALI.IMPORTO_AVERE 
  is 'Importo Avere del conto';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P593_CONTABDATIINDIVIDUALI
  add constraint P593_PK primary key (ID_CONTAB, PROGRESSIVO, CONTO, TIPO_RECORD)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table P593_CONTABDATIINDIVIDUALI
  add constraint P593_FK_P592 foreign key (ID_CONTAB)
  references P592_CONTABTESTATE (ID_CONTAB) on delete cascade;

create sequence P593_ID_CONTAB minvalue 1 start with 1 increment by 1 nocache;

create table P551_CONTOANNFILE
( ANNO        NUMBER(4) not null,
  COD_TABELLA VARCHAR2(10) not null,
  NUM_CAMPO   NUMBER(3) not null,
  DESCRIZIONE VARCHAR2(200),
  TIPO_CAMPO  VARCHAR2(10) default 'FILLER' not null,
  FORMATO     VARCHAR2(5) default 'N' not null,
  FORMULA     VARCHAR2(200),
  LUNGHEZZA   NUMBER(3) not null)
tablespace LAVORO
  storage (initial 256K next 256K pctincrease 0);
-- Add comments to the columns 
comment on column P551_CONTOANNFILE.NUM_CAMPO
  is 'Posizione progressiva del campo all''interno del record';
comment on column P551_CONTOANNFILE.TIPO_CAMPO
  is 'Tipologia del campo: ''REGIONE''=Codice regione, ''AZIENDA''=Codice azienda, ''CXXX''=Colonna della tabella, ''FORMULA''=Formula, ''FILLER''=Filler, ecc...';
comment on column P551_CONTOANNFILE.FORMATO
  is 'Formato del campo: ''X''=Alfanumerico, ''N''=Numerico';
comment on column P551_CONTOANNFILE.FORMULA
  is 'Formula del tipo CXXX+CXXX+CXXX se tipologia del campo=''FORMULA''';
comment on column P551_CONTOANNFILE.LUNGHEZZA
  is 'Lunghezza fissa del campo';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P551_CONTOANNFILE
  add constraint P551_PK primary key (ANNO, COD_TABELLA, NUM_CAMPO)
  using index 
  tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);

create table SG450_POSTILETTO (
  CODICE varchar2(20),
  DECORRENZA DATE,
  DECORRENZA_FINE DATE,
  POSTI_LETTO_DH number(3),
  POSTI_LETTO number(3),
  COORDINATORI  number(3)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG450_POSTILETTO add constraint SG450_PK primary key (CODICE,DECORRENZA)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

ALTER TABLE P092_CODICIINAIL ADD ORE_SETTIMANA NUMBER(5,2);
ALTER TABLE P092_CODICIINAIL ADD RETR_MINIMALE_GG NUMBER;
ALTER TABLE P092_CODICIINAIL ADD COD_ACCORP_RETR_TABELL VARCHAR2(20);
ALTER TABLE P092_CODICIINAIL ADD COD_ACCORP_STR VARCHAR2(20);
comment on column P092_CODICIINAIL.ORE_SETTIMANA
  is 'Ore lavorative della settimana (opzionale)';
comment on column P092_CODICIINAIL.RETR_MINIMALE_GG
  is 'Retribuzione minimale giornaliera (opzionale)';
comment on column P092_CODICIINAIL.COD_ACCORP_RETR_TABELL
  is 'Accorpamento voci per calcolo della retribuzione oraria tabellare (opzionale)';
comment on column P092_CODICIINAIL.COD_ACCORP_STR
  is 'Accorpamento voci per calcolo delle ore di straordinario (opzionale)';
comment on column P092_CODICIINAIL.RAPPORTO_GIORNI
  is '(Non utilizzato)';

create table SG404_TIPOPRESCRIZIONI
( CODICE      VARCHAR2(5) not null,
  DESCRIZIONE VARCHAR2(2000) )
tablespace LAVORO
storage (initial 256K next 256K pctincrease 0);
comment on column SG404_TIPOPRESCRIZIONI.CODICE
  is 'Codice';
comment on column SG404_TIPOPRESCRIZIONI.DESCRIZIONE
  is 'Descrizione';
alter table SG404_TIPOPRESCRIZIONI
  add constraint SG404_PK primary key (CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table SG403_DETTAGLIORISCHI add OGGETTO VARCHAR2(500);
alter table SG403_DETTAGLIORISCHI add PRESCRIZIONE VARCHAR2(5);
alter table SG403_DETTAGLIORISCHI add DATA_ESITO DATE;
UPDATE SG403_DETTAGLIORISCHI SET ESITO_VISITA = 'ID' WHERE ESITO_VISITA = 'IDONEO';
UPDATE SG403_DETTAGLIORISCHI SET ESITO_VISITA = 'NI' WHERE ESITO_VISITA = 'NON IDONEO';
UPDATE SG403_DETTAGLIORISCHI SET OGGETTO = ESITO_VISITA;
UPDATE SG403_DETTAGLIORISCHI SET ESITO_VISITA = '';
alter table SG403_DETTAGLIORISCHI modify ESITO_VISITA VARCHAR2(2);
UPDATE SG403_DETTAGLIORISCHI SET ESITO_VISITA = OGGETTO;
UPDATE SG403_DETTAGLIORISCHI SET OGGETTO = '';
comment on column SG403_DETTAGLIORISCHI.OGGETTO
  is 'Oggetto visita';
comment on column SG403_DETTAGLIORISCHI.PRESCRIZIONE
  is 'Codice prescrizione';
comment on column SG403_DETTAGLIORISCHI.ESITO_VISITA
  is 'Esito visita (ID=Idoneo, ND=Non Idoneo)';
comment on column SG403_DETTAGLIORISCHI.DATA_ESITO
  is 'Data esito visita';

insert into p452_datimensilidesc  (cod_campo, descrizione, tipo_dato, numero_decimali, valori_previsti, origine) values ('RI13A', 'Ratei manuali annuali di tredicesima' , 'N', 2, null, 'A');

alter table P430_ANAGRAFICO add TIPO_MASSIMALE_CONTR VARCHAR2(1) default 'N';
comment on column P430_ANAGRAFICO.TIPO_MASSIMALE_CONTR 
  is 'Tipo massimale contributivo: N=Nessuno; I=Nuovo iscritto a forme pensionistiche obbligatorie; D=Direttore';
update P430_ANAGRAFICO SET TIPO_MASSIMALE_CONTR= 'N';

alter table T760_REGOLEINCENTIVI modify ASSENZE_TOLLERATE_FRANCHIGIA VARCHAR2(2000);
alter table T760_REGOLEINCENTIVI modify TIPO DEFAULT 'C';
alter table T760_REGOLEINCENTIVI add DECORRENZA DATE;
update T760_REGOLEINCENTIVI set DECORRENZA = TO_DATE('01011900','DDMMYYYY');
alter table T760_REGOLEINCENTIVI 
  add constraint T760_PK primary key (DECORRENZA)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
comment on column T760_REGOLEINCENTIVI.QUALIFICA
  is 'Non utilizzato';
comment on column T760_REGOLEINCENTIVI.REPARTO
  is 'Non utilizzato';
comment on column T760_REGOLEINCENTIVI.LIVELLO
  is 'Non utilizzato';
comment on column T760_REGOLEINCENTIVI.ELENCOLIV
  is 'Livelli validi';
comment on column T760_REGOLEINCENTIVI.ASSENZE
  is 'Assenze tollerate';
comment on column T760_REGOLEINCENTIVI.VOCEPAGHE
  is 'Non utilizzato';
comment on column T760_REGOLEINCENTIVI.FRANCHIGIA_ASSENZE
  is 'Giorni di franchigia';
comment on column T760_REGOLEINCENTIVI.TIPO
  is 'Tipo di calcolo ';
comment on column T760_REGOLEINCENTIVI.ABBATTIMENTO_MAX
  is 'Abbattimento massimo';
comment on column T760_REGOLEINCENTIVI.ASSENZE_TOLLERATE_FRANCHIGIA
  is 'Assenze tollerate franchigia';
comment on column T760_REGOLEINCENTIVI.GESTIONE_FRANCHIGIA
  is 'Gestione franchigia';
comment on column T760_REGOLEINCENTIVI.PROPORZIONE_INCENTIVI
  is 'Proporzione incentivi';
comment on column T760_REGOLEINCENTIVI.DECORRENZA
  is 'Decorrenza';

-- Create table
create table P042_ENTIIRPEF
(
  ANNO                           NUMBER(4) not null,
  TIPO_ADDIZIONALE               VARCHAR2(1) default 'R' not null,
  COD_ENTE                       VARCHAR2(6) not null,
  RITENUTA_SCAGLIONI             VARCHAR2(1) default 'N',
  RITENUTA_PERC                  NUMBER default 0 not null,
  RITENUTA_PROGRESSIVA_SCAGLIONI VARCHAR2(1) default 'N'
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
-- Add comments to the columns 
comment on column P042_ENTIIRPEF.TIPO_ADDIZIONALE
  is 'Tipo addizionale: C=Comunale; P=Provinciale; R=Regionale';
comment on column P042_ENTIIRPEF.COD_ENTE
  is 'Codice del comune, provincia o regione';
comment on column P042_ENTIIRPEF.RITENUTA_SCAGLIONI
  is 'La ritenuta dipende da scaglioni (S/N)';
comment on column P042_ENTIIRPEF.RITENUTA_PERC
  is 'Percentuale ritenuta se indipendente da scaglioni. In alternativa al seguente';
comment on column P042_ENTIIRPEF.RITENUTA_PROGRESSIVA_SCAGLIONI
  is 'Ritenuta su scaglioni applicata progressivamente (S/N)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P042_ENTIIRPEF
  add constraint P042_PK primary key (TIPO_ADDIZIONALE, COD_ENTE, ANNO)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
-- Create table
create table P044_ENTIIRPEFFASCE
(
  ANNO             NUMBER(4) not null,
  TIPO_ADDIZIONALE VARCHAR2(1) default 'R' not null,
  COD_ENTE         VARCHAR2(6) not null,
  IMPORTO_DA       NUMBER not null,
  IMPORTO_A        NUMBER not null,
  PERC             NUMBER not null
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
-- Add comments to the columns 
comment on column P044_ENTIIRPEFFASCE.TIPO_ADDIZIONALE
  is 'Tipo addizionale: C=Comunale; P=Provinciale; R=Regionale';
comment on column P044_ENTIIRPEFFASCE.COD_ENTE
  is 'Codice del comune, provincia o regione';
comment on column P044_ENTIIRPEFFASCE.IMPORTO_DA
  is 'Importo iniziale scaglione';
comment on column P044_ENTIIRPEFFASCE.IMPORTO_A
  is 'Importo finale scaglione (=0 sull''ultimo scaglione)';
comment on column P044_ENTIIRPEFFASCE.PERC
  is 'Percentuale dello scaglione';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P044_ENTIIRPEFFASCE
  add constraint P044_PK primary key (ANNO, TIPO_ADDIZIONALE, COD_ENTE, IMPORTO_DA)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table P044_ENTIIRPEFFASCE
  add constraint P044_FK_P042 foreign key (ANNO, TIPO_ADDIZIONALE, COD_ENTE)
  references P042_ENTIIRPEF (ANNO, TIPO_ADDIZIONALE, COD_ENTE) on delete cascade;
update mondoedp.i073_filtrofunzioni set funzione = 'OpenP042FEntiIRPEF' where funzione = 'OpenP014FComuniIRPEF';
delete p233_scaglionifasce where ID_SCAGLIONE not in(select ID_SCAGLIONE from p232_scaglioni);
drop table p014_comuniirpef;
drop table p016_provinceirpef;
drop table p018_regioniirpef;
 
-- Modifiche tabella parametrizzazione scarico paghe 
alter table T191_PARPAGHE add TIPO_PARAMETRIZZAZIONE varchar2(10);
UPDATE T191_PARPAGHE SET TIPO_PARAMETRIZZAZIONE = 'PAGHE';
alter table T191_PARPAGHE modify TIPO_PARAMETRIZZAZIONE not null;
alter table T191_PARPAGHE
  drop constraint T191_PK cascade;
alter table T191_PARPAGHE
  add constraint T191_PK primary key (TIPO_PARAMETRIZZAZIONE, CODICE)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T192_PARPAGHEDATI add TIPO_PARAMETRIZZAZIONE varchar2(10);
UPDATE T192_PARPAGHEDATI SET TIPO_PARAMETRIZZAZIONE = 'PAGHE' where 
  TIPO_PARAMETRIZZAZIONE is null;
alter table T192_PARPAGHEDATI modify TIPO_PARAMETRIZZAZIONE not null;
alter table T192_PARPAGHEDATI
  drop constraint T192_PK cascade;
alter table T192_PARPAGHEDATI
  add constraint T192_PK primary key (TIPO_PARAMETRIZZAZIONE, CODICE, POS)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column P212_PARAMETRISTIPENDI.TIPO_RIDUZIONE_STIPENDIO
  is 'Tipo riduzione stipendio per assunzione/cessazione: GCN=Giorni del mese da contratto; GCL=Giorni del mese da calendario (Non utilizzato)';

DELETE from p450_datimensili t where t.cod_campo='RIDAC';

DELETE from p452_datimensilidesc t where t.cod_campo='RIDAC';

ALTER TABLE P212_PARAMETRISTIPENDI add DATA_DOM_ADDIZ_COM VARCHAR2(5) default '01/01' not null;
COMMENT on column P212_PARAMETRISTIPENDI.DATA_DOM_ADDIZ_COM
  is 'Data del domicilio fiscale per addizionale comunale';

ALTER TABLE P212_PARAMETRISTIPENDI add DATA_DOM_ADDIZ_PROV VARCHAR2(5) default '31/12' not null;
COMMENT on column P212_PARAMETRISTIPENDI.DATA_DOM_ADDIZ_PROV
  is 'Data del domicilio fiscale per addizionale provinciale';

ALTER TABLE P212_PARAMETRISTIPENDI add DATA_DOM_ADDIZ_REG VARCHAR2(5) default '31/12' not null;
COMMENT on column P212_PARAMETRISTIPENDI.DATA_DOM_ADDIZ_REG
  is 'Data del domicilio fiscale per addizionale regionale';

ALTER TABLE P212_PARAMETRISTIPENDI add GIORNI_DECORR_VAR_DOM NUMBER(2) default 60;
COMMENT on column P212_PARAMETRISTIPENDI.GIORNI_DECORR_VAR_DOM
  is 'Numero giorni ritardo per decorrenza variazioni domicilio fiscale';

alter table T020_ORARI add SCOSTGG_MIN_SOGLIA varchar2(5);
comment on column T020_ORARI.SCOSTGG_MIN_SOGLIA is 'Ore minime oltre il debito gg sotto le quali lo scostamento viene perso';
comment on column T020_ORARI.MINSCOSTR is 'Soglia oltre il debito gg di distinzione tra ore compensabili e liquidabili';

create table T266_DETTAGLIOCUMULO
(CODICE varchar2(5),
 ID varchar2(5),
 NUMGG number(4,1),
 CAUSALI varchar2(500)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T266_DETTAGLIOCUMULO add constraint T266_PK primary key (CODICE, ID) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

insert into T266_DETTAGLIOCUMULO (CODICE, ID, NUMGG, CAUSALI)
select CODICE, '0', NULL, ASSTOLL from T265_CAUASSENZE where TIPOCUMULO = 'M' and ASSTOLL is not null;

RENAME T043_RIEPILOGOASSENZE TO T043_OLD;
ALTER TABLE T043_OLD DROP CONSTRAINT T043_PK;
create table T043_ASSENZEMENSILI
( PROGRESSIVO               NUMBER(8) not null,
  DATA_FINE_PERIODO         DATE not null,
  COD_TIPOACCORPAMENTOASS   VARCHAR2(5) not null,
  COD_CODICIACCORPAMENTOASS VARCHAR2(5) not null,
  FRUITO                    NUMBER(8,2) not null)
tablespace LAVORO
storage (initial 256K next 256K pctincrease 0);
-- Add comments to the columns 
comment on column T043_ASSENZEMENSILI.DATA_FINE_PERIODO
  is 'Anno e mese di fine periodo elaborato';
comment on column T043_ASSENZEMENSILI.COD_TIPOACCORPAMENTOASS
  is 'Tipo di accorpamento assenza (es. Tabella 11 conto annuale)';
comment on column T043_ASSENZEMENSILI.COD_CODICIACCORPAMENTOASS
  is 'Codice del raggruppamento assenze nell''ambito del tipo accorpamento';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T043_ASSENZEMENSILI
  add constraint T043_PK primary key (PROGRESSIVO, DATA_FINE_PERIODO, COD_TIPOACCORPAMENTOASS, COD_CODICIACCORPAMENTOASS)
  using index 
  tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);

alter table MONDOEDP.I101_TIMBIRREGOLARI add SCARICO varchar2(20);
comment on column MONDOEDP.I101_TIMBIRREGOLARI.SCARICO is 'nome della parametrizzazione utilizzata nello scarico';

comment on column T262_PROFASSANN.FRUIZ_ANNO_CONTINUATIVA is '(non usata) s/n indica se la fruizione minima anno corrente è continuativa o meno';
alter table  T262_PROFASSANN add FRUIZ_MINIMA_DAL DATE;
comment on column T262_PROFASSANN.FRUIZ_MINIMA_DAL is 'decorrenza della fruizione minima';

create table T103_TIMBRATURE_SCARTATE
(
  PROGRESSIVO NUMBER(38,2) not null,
  DATA        DATE not null,
  ORA         DATE not null,
  VERSO       VARCHAR2(1) not null,
  FLAG        VARCHAR2(1) not null,
  RILEVATORE  VARCHAR2(2),
  CAUSALE     VARCHAR2(5)
)
tablespace LAVORO storage (initial 256K next 256K);

COMMENT on column P232_SCAGLIONI.TIPO_APPLICAZIONE
  is 'Tipo applicazione: P=Al raggiungimento progressivo della soglia; Q=Al raggiungimento progressivo della soglia con massimali; M=Rapporto mensile; N=Non parametrizzabile';

ALTER TABLE P232_SCAGLIONI add MASSIMALE1 number default 0;
ALTER TABLE P232_SCAGLIONI add MASSIMALE2 number default 0;
COMMENT on column P232_SCAGLIONI.MASSIMALE1
  is 'Massimale 1';
COMMENT on column P232_SCAGLIONI.MASSIMALE2
  is 'Massimale 2';
UPDATE p210_contratti t set t.descrizione='Contratto sanità e parasubordinati' WHERE T.COD_CONTRATTO='EDP';

INSERT INTO p210_contratti (cod_contratto, decorrenza, descrizione, note, decorrenza_fine) VALUES ('EDPSC', TO_DATE('01011900','DDMMYYYY'), 'Contratto sanitari convenzionati', '', TO_DATE('31123999','DDMMYYYY'));

DELETE p212_parametristipendi t WHERE T.COD_PARAMETRISTIPENDI<>'EDP';

UPDATE p212_parametristipendi t SET T.DESCRIZIONE='Area contrattuale sanità' WHERE T.COD_PARAMETRISTIPENDI='EDP';

INSERT INTO P212_PARAMETRISTIPENDI select 'EDPSC', decorrenza, 'Area contrattuale sanitari convenzionati', data_approvazione, data_applicazione, data_scadenza, 0, 0, giorni_mese, domenica_influente, sabato_influente, settimane_anno, tipo_riduzione_stipendio, conguaglio, tredicesima, tipo_maturazione13a, tipo_calcolo_importo13a, note, giorno_calcolo13a, mesi_posticipo13a, includi_13a, tipo_abbattimento13a, 0, tipo_arrotondamento_gginps, mens_reddito_no_tax, decorrenza_fine, data_dom_addiz_com, data_dom_addiz_prov, data_dom_addiz_reg, giorni_decorr_var_dom  from p212_parametristipendi T WHERE T.COD_PARAMETRISTIPENDI='EDP';

UPDATE p200_voci t SET T.PROGRAMMATA='S' WHERE T.COD_VOCE='10500' AND T.COD_VOCE_SPECIALE='BASE';

-- Add comments to the columns 
COMMENT on column P070_MISUREQUANTITA.TIPO
  is 'Tipo quantità: OC=Ore in Centesimi; OS=Ore in Sessantesimi; OT=Ore da setup; GG=Giorni; QM=Quantità mensile; AL=Altro';

-- Gestione voci a quantità mensile
create table P460_QUANTMENSILI
(
  PROGRESSIVO        NUMBER not null,
  DATA_COMPETENZA    DATE not null,
  COD_MISURAQUANTITA VARCHAR2(5) not null,
  ORIGINE            VARCHAR2(1) not null,
  TIPO_RECORD        VARCHAR2(1) not null,
  QUANTITA           NUMBER not null,
  FLAG               VARCHAR2(1),
  DATA_CEDOLINO      DATE
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
-- Add comments to the columns 
comment on column P460_QUANTMENSILI.ORIGINE
  is 'Origine della quantita'': I=Quantita'' inserita manualmente (es. Ore lavorate da guardia medica), R=Quantita'' da elaborazione file (es. Numero assistiti)';
comment on column P460_QUANTMENSILI.TIPO_RECORD
  is 'Tipo record: A=Automatico; M=Manuale';
comment on column P460_QUANTMENSILI.FLAG
  is 'NULL se mai elaborato da Paghe, C se Chiuso';
comment on column P460_QUANTMENSILI.DATA_CEDOLINO
  is 'Data del cedolino in cui la quantita'' e'' stata elaborata';
-- Create/Recreate indexes 
create index P460_IND1 on P460_QUANTMENSILI (PROGRESSIVO, DATA_COMPETENZA, COD_MISURAQUANTITA, ORIGINE, TIPO_RECORD)
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

UPDATE p500_cudsetup t SET T.TIPO_FORNITORE='01';

UPDATE p602_770regole t SET T.OMETTI_VUOTO='S' WHERE T.PARTE='A' AND T.ANNO=2006 AND NUMERO IN('014','015','016');

alter table T020_ORARI add PMT_TOLLERANZA varchar2(5);
update T020_ORARI set MINPERCORR = null where TIPOMENSA not in ('D','E','F');

alter table T193_VOCIPAGHE_PARAMETRI add ARROTONDAMENTO number(8,3);
comment on column T193_VOCIPAGHE_PARAMETRI.ARROTONDAMENTO is 'Arrotondamento da applicare alla quantita. Esempio: 10 oppure -0,5';

ALTER TABLE T600_SQUADRE DROP PRIMARY KEY;
RENAME T600_SQUADRE TO T600_OLD;

CREATE TABLE T600_SQUADRE
(
  CODICE           VARCHAR2(5) NOT NULL,
  DESCRIZIONE      VARCHAR2(40),
  DESCRIZIONELUNGA VARCHAR2(80),
  TOTMIN1          NUMBER(3),
  TOTMAX1          NUMBER(3),
  TOTMIN2          NUMBER(3),
  TOTMAX2          NUMBER(3),
  TOTMIN3          NUMBER(3),
  TOTMAX3          NUMBER(3),
  TOTMIN4          NUMBER(3),
  TOTMAX4          NUMBER(3),
  FESMIN1          NUMBER(3),
  FESMAX1          NUMBER(3),
  FESMIN2          NUMBER(3),
  FESMAX2          NUMBER(3),
  FESMIN3          NUMBER(3),
  FESMAX3          NUMBER(3),
  FESMIN4          NUMBER(3),
  FESMAX4          NUMBER(3)) 
TABLESPACE LAVORO 
STORAGE(
  INITIAL 256K 
  NEXT 256K  
  PCTINCREASE 0);

ALTER TABLE T600_SQUADRE ADD CONSTRAINT T600_PK PRIMARY KEY (CODICE)
  USING INDEX TABLESPACE INDICI STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

INSERT INTO T600_SQUADRE 
(CODICE,DESCRIZIONE,DESCRIZIONELUNGA,TOTMIN1,TOTMAX1,TOTMIN2,TOTMAX2,TOTMIN3,TOTMAX3,TOTMIN4,TOTMAX4)
SELECT CODICE,DESCRIZIONE,DESCRIZIONELUNGA,TOTMIN1,TOTMAX1,TOTMIN2,TOTMAX2,TOTMIN3,TOTMAX3,TOTMIN4,TOTMAX4 
FROM T600_OLD;


ALTER TABLE T601_TIPIOPERATORE DROP PRIMARY KEY;
RENAME T601_TIPIOPERATORE TO T601_OLD;

CREATE TABLE T601_TIPIOPERATORE
(
  SQUADRA     VARCHAR2(5) NOT NULL,
  CODICE      VARCHAR2(5) NOT NULL,
  MIN1        NUMBER(3),
  MAX1        NUMBER(3),
  MIN2        NUMBER(3),
  MAX2        NUMBER(3),
  MIN3        NUMBER(3),
  MAX3        NUMBER(3),
  MIN4        NUMBER(3),
  MAX4        NUMBER(3),
  FESMIN1     NUMBER(3),
  FESMAX1     NUMBER(3),
  FESMIN2     NUMBER(3),
  FESMAX2     NUMBER(3),
  FESMIN3     NUMBER(3),
  FESMAX3     NUMBER(3),
  FESMIN4     NUMBER(3),
  FESMAX4     NUMBER(3),
  OTTIMALE1FR NUMBER(3),
  OTTIMALE1FS NUMBER(3),
  OTTIMALE2FR NUMBER(3),
  OTTIMALE2FS NUMBER(3),
  OTTIMALE3FR NUMBER(3),
  OTTIMALE3FS NUMBER(3),
  TURNAZ      VARCHAR2(5),
  ORARIO      VARCHAR2(5),
  PROFILO     VARCHAR2(5)) 
TABLESPACE LAVORO 
STORAGE (
    INITIAL 256K 
       NEXT 256K 
PCTINCREASE 0);

ALTER TABLE T601_TIPIOPERATORE ADD CONSTRAINT T601_PK PRIMARY KEY (SQUADRA, CODICE)
  USING INDEX TABLESPACE INDICI STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

INSERT INTO T601_TIPIOPERATORE 
  (SQUADRA,CODICE,MIN1,MAX1,MIN2,MAX2,MIN3,MAX3,MIN4,MAX4,OTTIMALE1FR,OTTIMALE1FS,OTTIMALE2FR,OTTIMALE2FS,OTTIMALE3FR,OTTIMALE3FS,TURNAZ,ORARIO,PROFILO)
SELECT  SQUADRA,CODICE,MIN1,MAX1,MIN2,MAX2,MIN3,MAX3,MIN4,MAX4,OTTIMALE1FR,OTTIMALE1FS,OTTIMALE2FR,OTTIMALE2FS,OTTIMALE3FR,OTTIMALE3FS,TURNAZ,ORARIO,PROFILO
FROM T601_OLD;
