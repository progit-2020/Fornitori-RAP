UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '6.0.2' WHERE AZIENDA = :AZIENDA;

ALTER TABLE T910_RIEPILOGO ADD TOTRIEPILOGO VARCHAR2(1) DEFAULT 'N';
UPDATE T910_RIEPILOGO SET TOTRIEPILOGO = TOTGENERALI WHERE TOTGENERALI <> 'N';
UPDATE T910_RIEPILOGO SET TOTGENERALI = 'N';
ALTER TABLE T762_INCENTIVIMATURATI MODIFY TIPOQUOTA DEFAULT NULL;
ALTER TABLE T044_STORICOGIUSTIFICATIVI ADD DATA_CEDOLINO DATE;
comment on column T044_STORICOGIUSTIFICATIVI.DATA_CEDOLINO
  is 'Data del cedolino in cui l''assenza è stata elaborata';

ALTER TABLE T025_CONTMENSILI ADD RECUPERODEBITO_TIPO VARCHAR2(1) DEFAULT '0';

ALTER TABLE P500_CUDSETUP ADD SEDE_INPS VARCHAR2(6);
ALTER TABLE P500_CUDSETUP ADD COD_FISCALE_MITT_EMENS VARCHAR2(16);
ALTER TABLE P500_CUDSETUP ADD CODICE_ISTAT_EMENS VARCHAR2(5);
comment on column P500_CUDSETUP.SEDE_INPS
  is 'Codice sede INPS destinataria del flusso EMens';
comment on column P500_CUDSETUP.COD_FISCALE_MITT_EMENS
  is 'Codice fiscale del soggetto abilitato alla trasmissione del flusso EMens';
comment on column P500_CUDSETUP.CODICE_ISTAT_EMENS
  is 'Codice ISTAT dell''azienda';

ALTER TABLE P430_ANAGRAFICO ADD COD_EMENSTIPOASS VARCHAR2(5);
ALTER TABLE P430_ANAGRAFICO ADD COD_EMENSTIPOCESS VARCHAR2(5);
ALTER TABLE P430_ANAGRAFICO ADD COD_TIPORAPP_COCOCO VARCHAR2(5);
ALTER TABLE P430_ANAGRAFICO ADD COD_TIPOATT_COCOCO VARCHAR2(5);
ALTER TABLE P430_ANAGRAFICO ADD COD_ALTRAASS_COCOCO VARCHAR2(5);
comment on column P430_ANAGRAFICO.COD_EMENSTIPOASS
  is 'Codice tipo assunzione per flusso EMens';
comment on column P430_ANAGRAFICO.COD_EMENSTIPOCESS
  is 'Codice tipo cessazione per flusso EMens';
comment on column P430_ANAGRAFICO.COD_TIPORAPP_COCOCO
  is 'Codice tipo rapporto Co.Co.Co.';
comment on column P430_ANAGRAFICO.COD_TIPOATT_COCOCO
  is 'Codice tipo attività Co.Co.Co.';
comment on column P430_ANAGRAFICO.COD_ALTRAASS_COCOCO
  is 'Codice Altra assicurazione Co.Co.Co.';

INSERT INTO M049_TIPOPAGAMENTO VALUES ('DEBIT', 'IMPORTO A DEBITO CALCOLATO DAL PROGRAMMA', 'S');

ALTER TABLE P090_CODICIINPS ADD COD_EMENSTIPOCONTR VARCHAR2(5);
comment on column P090_CODICIINPS.COD_EMENSTIPOCONTR
  is 'Codice tipo contribuzione per flusso EMens';

ALTER TABLE P096_INQUADRINPS ADD COD_TIPOORARIO_PARTTIMEV VARCHAR2(5);
ALTER TABLE P096_INQUADRINPS ADD COD_TIPOORARIO_PARTTIMEM VARCHAR2(5);
comment on column P096_INQUADRINPS.COD_TIPOORARIO_PARTTIME
  is 'Codice tipo orario da utilizzarsi per i dipendenti a part-time orizzontale';
comment on column P096_INQUADRINPS.COD_TIPOORARIO_PARTTIMEV
  is 'Codice tipo orario da utilizzarsi per i dipendenti a part-time verticale';
comment on column P096_INQUADRINPS.COD_TIPOORARIO_PARTTIMEM
  is 'Codice tipo orario da utilizzarsi per i dipendenti a part-time misto';

-- Create table
create table P660_FLUSSIREGOLE
(
  NOME_FLUSSO               VARCHAR2(10),    
  DECORRENZA                DATE not null,
  PARTE                     VARCHAR2(5) not null,
  NUMERO                    VARCHAR2(4) not null,
  DESCRIZIONE               VARCHAR2(200),
  TIPO_RECORD               VARCHAR2(1),
  SEZIONE_FILE              VARCHAR2(2),
  NUMERO_FILE               VARCHAR2(3),
  FORMATO_FILE              VARCHAR2(5),
  LUNGHEZZA_FILE            NUMBER,
  FORMATO_ANNOMESE          VARCHAR2(1) default 'N' not null,
  NUMERICO                  VARCHAR2(1) default 'S',
  COD_ARROTONDAMENTO        VARCHAR2(5),
  FORMATO                   VARCHAR2(11),
  OMETTI_VUOTO              VARCHAR2(1) default 'S',
  TIPO_DATO                 VARCHAR2(1) default 'I',
  REGOLA_CALCOLO_AUTOMATICA VARCHAR2(2000),
  REGOLA_CALCOLO_MANUALE    VARCHAR2(2000),
  REGOLA_MODIFICABILE       VARCHAR2(1) default 'N',
  COMMENTO                  VARCHAR2(300),
  FL_NUMERO_TREDICESIMA     VARCHAR2(4),
  FL_NUMERO_ARRCORR         VARCHAR2(4),
  FL_NUMERO_ARRPREC         VARCHAR2(4)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 536K
    minextents 1
  );
-- Add comments to the columns 
comment on column P660_FLUSSIREGOLE.NOME_FLUSSO
  is 'Identificativo del flusso';
comment on column P660_FLUSSIREGOLE.PARTE
  is 'Parte o sezione del flusso';
comment on column P660_FLUSSIREGOLE.NUMERO
  is 'Numero del dato o codice interno del flusso';
comment on column P660_FLUSSIREGOLE.TIPO_RECORD
  is 'Tipo record del file di esportazione';
comment on column P660_FLUSSIREGOLE.SEZIONE_FILE
  is 'Sezione sul file di esportazione';
comment on column P660_FLUSSIREGOLE.NUMERO_FILE
  is 'Numero sul file di esportazione';
comment on column P660_FLUSSIREGOLE.FORMATO_FILE
  is 'Formato dati per il file di esportazione';
comment on column P660_FLUSSIREGOLE.LUNGHEZZA_FILE
  is 'Lunghezza dati per il file di esportazione';
comment on column P660_FLUSSIREGOLE.FORMATO_ANNOMESE
  is 'Indica se il campo prevede la sdoppiatura del dato anno/mese su due record (S/N)';
comment on column P660_FLUSSIREGOLE.NUMERICO
  is 'Dato numerico (S/N)';
comment on column P660_FLUSSIREGOLE.COD_ARROTONDAMENTO
  is 'Codice arrotondamento. Richiesto solo se dato numerico';
comment on column P660_FLUSSIREGOLE.FORMATO
  is 'Formato di stampa. Richiesto solo se dato numerico';
comment on column P660_FLUSSIREGOLE.OMETTI_VUOTO
  is 'Ometti se dato non significativo';
comment on column P660_FLUSSIREGOLE.TIPO_DATO
  is 'Tipo dato: I=Individuale, R=Riepilogativo';
comment on column P660_FLUSSIREGOLE.REGOLA_CALCOLO_AUTOMATICA
  is 'Query o nome campo per estrazione dato prevista di default';
comment on column P660_FLUSSIREGOLE.REGOLA_CALCOLO_MANUALE
  is 'Query o nome campo per estrazione dato modificata dall''utente';
comment on column P660_FLUSSIREGOLE.REGOLA_MODIFICABILE
  is 'Query o nome campo per estrazione dato modificabile dall''utente';
comment on column P660_FLUSSIREGOLE.FL_NUMERO_TREDICESIMA
  is 'Fluper: numero del dato sostitutivo in caso di tredicesima';
comment on column P660_FLUSSIREGOLE.FL_NUMERO_ARRCORR
  is 'Fluper: numero del dato sostitutivo in caso di arretrati anno corrente';
comment on column P660_FLUSSIREGOLE.FL_NUMERO_ARRPREC
  is 'Fluper: numero del dato sostitutivo in caso di arretrati anno precedente';
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table P660_FLUSSIREGOLE
  add constraint P660_PK primary key (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );

-- Create table
create table P662_FLUSSITESTATE
(
  NOME_FLUSSO       VARCHAR2(10),
  DATA_FINE_PERIODO DATE not null,
  ID_FLUSSO         NUMBER not null,
  CHIUSO            VARCHAR2(1) default 'N',
  DATA_CHIUSURA     DATE
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );
-- Add comments to the columns 
comment on column P662_FLUSSITESTATE.NOME_FLUSSO
  is 'Identificativo del flusso';
comment on column P662_FLUSSITESTATE.DATA_FINE_PERIODO
  is 'Anno e mese di fine periodo elaborato';
comment on column P662_FLUSSITESTATE.CHIUSO
  is 'Chiuso (S/N)';
comment on column P662_FLUSSITESTATE.DATA_CHIUSURA
  is 'Data chiusura del flusso';

-- Create/Recreate primary, unique and foreign key constraints 
alter table P662_FLUSSITESTATE
  add constraint P662_PK primary key (ID_FLUSSO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );

-- Create table
create table P663_FLUSSIDATIINDIVIDUALI
(
  ID_FLUSSO          NUMBER not null,
  PROGRESSIVO        NUMBER not null,
  PARTE              VARCHAR2(5) not null,
  NUMERO             VARCHAR2(4) not null,
  PROGRESSIVO_NUMERO NUMBER default 1 not null,
  TIPO_RECORD        VARCHAR2(1) not null,
  VALORE             VARCHAR2(40)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );
-- Add comments to the columns 
comment on column P663_FLUSSIDATIINDIVIDUALI.PROGRESSIVO
  is 'Progressivo del dipendente, impostato a -1 per i dati riepilogativi';
comment on column P663_FLUSSIDATIINDIVIDUALI.PARTE
  is 'Parte o sezione del flusso';
comment on column P663_FLUSSIDATIINDIVIDUALI.NUMERO
  is 'Numero del dato o codice interno del flusso';
comment on column P663_FLUSSIDATIINDIVIDUALI.PROGRESSIVO_NUMERO
  is 'Progressivo per i campi molteplici';
comment on column P663_FLUSSIDATIINDIVIDUALI.TIPO_RECORD
  is 'Tipo record: A=Automatico; M=Manuale';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P663_FLUSSIDATIINDIVIDUALI
  add constraint P663_PK primary key (ID_FLUSSO, PROGRESSIVO, PARTE, NUMERO, PROGRESSIVO_NUMERO, TIPO_RECORD)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );
alter table P663_FLUSSIDATIINDIVIDUALI
  add constraint P663_FK_P662 foreign key (ID_FLUSSO)
  references P662_FLUSSITESTATE (ID_FLUSSO) on delete cascade;

DROP TABLE P652_INPDAPMMREGOLE;
DROP TABLE P655_INPDAPMMDATIINDIVIDUALI;
DROP TABLE P654_INPDAPMMTESTATE;
DROP SEQUENCE P655_ID_INPDAPMM;

-- Create sequence 
create sequence P663_ID_FLUSSO minvalue 1 maxvalue 999999999999999999999999999 start with 1 increment by 1 nocache;


-- Create table
create table P670_XMLREGOLE
(
  NOME_FLUSSO               VARCHAR2(10) not null,
  DECORRENZA                DATE not null,
  NUMERO                    VARCHAR2(4) not null,
  ELEMENTO                  VARCHAR2(80) not null,
  DESCRIZIONE               VARCHAR2(200),
  NUMERO_PADRE              VARCHAR2(4),
  FORMATO_FILE              VARCHAR2(5),
  NUMERICO                  VARCHAR2(1) default 'S',
  COD_ARROTONDAMENTO        VARCHAR2(5),
  FORMATO                   VARCHAR2(11),
  OMETTI_VUOTO              VARCHAR2(1) default 'S',
  REGOLA_CALCOLO_AUTOMATICA VARCHAR2(2000),
  REGOLA_CALCOLO_MANUALE    VARCHAR2(2000),
  REGOLA_MODIFICABILE       VARCHAR2(1) default 'N',
  COMMENTO                  VARCHAR2(300)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );
-- Add comments to the columns 
comment on column P670_XMLREGOLE.NOME_FLUSSO
  is 'Identificativo del flusso';
comment on column P670_XMLREGOLE.NUMERO
  is 'Numero del dato o codice interno del flusso';
comment on column P670_XMLREGOLE.ELEMENTO
  is 'Nome dell''elemento XML';
comment on column P670_XMLREGOLE.NUMERO_PADRE
  is 'Numero del dato o codice interno del flusso del nodo padre';
comment on column P670_XMLREGOLE.FORMATO_FILE
  is 'Formato dati per il file di esportazione';
comment on column P670_XMLREGOLE.NUMERICO
  is 'Dato numerico (S/N)';
comment on column P670_XMLREGOLE.COD_ARROTONDAMENTO
  is 'Codice arrotondamento. Richiesto solo se dato numerico';
comment on column P670_XMLREGOLE.FORMATO
  is 'Formato di stampa. Richiesto solo se dato numerico';
comment on column P670_XMLREGOLE.OMETTI_VUOTO
  is 'Ometti se dato non significativo';
comment on column P670_XMLREGOLE.REGOLA_CALCOLO_AUTOMATICA
  is 'Query o nome campo per estrazione dato prevista di default';
comment on column P670_XMLREGOLE.REGOLA_CALCOLO_MANUALE
  is 'Query o nome campo per estrazione dato modificata dall''utente';
comment on column P670_XMLREGOLE.REGOLA_MODIFICABILE
  is 'Query o nome campo per estrazione dato modificabile dall''utente';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P670_XMLREGOLE
  add constraint P670_PK primary key (NOME_FLUSSO, DECORRENZA, NUMERO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );
-- Create table
create table P672_XMLTESTATE
(
  NOME_FLUSSO       VARCHAR2(10),
  DATA_FINE_PERIODO DATE not null,
  ID_FLUSSO         NUMBER not null,
  CHIUSO            VARCHAR2(1) default 'N',
  DATA_CHIUSURA     DATE
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );
-- Add comments to the columns 
comment on column P672_XMLTESTATE.NOME_FLUSSO
  is 'Identificativo del flusso';
comment on column P672_XMLTESTATE.DATA_FINE_PERIODO
  is 'Anno e mese di fine periodo elaborato';
comment on column P672_XMLTESTATE.CHIUSO
  is 'Chiuso (S/N)';
comment on column P672_XMLTESTATE.DATA_CHIUSURA
  is 'Data chiusura del flusso';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P672_XMLTESTATE
  add constraint P672_PK primary key (ID_FLUSSO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );
-- Create table
create table P673_XMLDATIINDIVIDUALI
(
  ID_FLUSSO                NUMBER not null,
  PROGRESSIVO              NUMBER not null,
  NUMERO                   VARCHAR2(4) not null,
  PROGRESSIVO_NUMERO       NUMBER default 1 not null,
  NUMERO_PADRE             VARCHAR2(4),
  PROGRESSIVO_NUMERO_PADRE NUMBER,
  TIPO_RECORD              VARCHAR2(1) not null,
  VALORE                   VARCHAR2(40)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );
-- Add comments to the columns 
comment on column P673_XMLDATIINDIVIDUALI.PROGRESSIVO
  is 'Progressivo del dipendente';
comment on column P673_XMLDATIINDIVIDUALI.NUMERO
  is 'Numero del dato o codice interno del flusso';
comment on column P673_XMLDATIINDIVIDUALI.PROGRESSIVO_NUMERO
  is 'Progressivo per i campi molteplici, univoco a parita'' di progressivo e numero';
comment on column P673_XMLDATIINDIVIDUALI.NUMERO_PADRE
  is 'Numero del dato o codice interno del flusso del nodo padre';
comment on column P673_XMLDATIINDIVIDUALI.PROGRESSIVO_NUMERO_PADRE
  is 'Progressivo per i campi molteplici del nodo padre';
comment on column P673_XMLDATIINDIVIDUALI.TIPO_RECORD
  is 'Tipo record: A=Automatico; M=Manuale';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P673_XMLDATIINDIVIDUALI
  add constraint P673_PK primary key (ID_FLUSSO, PROGRESSIVO, NUMERO, PROGRESSIVO_NUMERO, TIPO_RECORD)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );
alter table P673_XMLDATIINDIVIDUALI
  add constraint P673_FK_P672 foreign key (ID_FLUSSO)
  references P672_XMLTESTATE (ID_FLUSSO) on delete cascade;

-- Create sequence 
create sequence P673_ID_INPS
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

-- Trasformazione tabelle variabili in tabella storicizzabile
ALTER TABLE SG500_DATILIBERI ADD DECORRENZA DATE;
UPDATE SG500_DATILIBERI SET DECORRENZA = INIZIOVALID;
COMMIT;
ALTER TABLE SG500_DATILIBERI MODIFY DECORRENZA NOT NULL;
ALTER TABLE SG500_DATILIBERI DROP CONSTRAINT SG500_PK;
alter table SG500_DATILIBERI
  add constraint SG500_PK primary key (VARIABILE, DECORRENZA)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (initial 20K  minextents 1);
comment on column SG500_DATILIBERI.INIZIOVALID is 'Non usato'; 
comment on column SG500_DATILIBERI.FINEVALID is 'Non usato'; 

ALTER TABLE T760_REGOLEINCENTIVI MODIFY ASSENZE VARCHAR2(500);

comment on column P430_ANAGRAFICO.TIPO_DIPENDENTE
  is 'Tipo dipendente: RU=Tempo indeterminato, IN=Tempo determinato, ER=Erede, BO=Borsista, CO=Parasubordinato, AS=Altro assimilato, LU=L.S.U., LA=Lav.autonomo';
comment on column P430_ANAGRAFICO.COD_TIPORAPP_COCOCO
  is 'Codice tipo rapporto lavoratore parasubordinato';
comment on column P430_ANAGRAFICO.COD_TIPOATT_COCOCO
  is 'Codice tipo attività lavoratore parasubordinato';
comment on column P430_ANAGRAFICO.COD_ALTRAASS_COCOCO
  is 'Codice Altra assicurazione lavoratore parasubordinato';

comment on column P200_VOCI.NO_CEDOLINO_NORMALE
  is 'La voce di assenza riduce i giorni delle voci in quota inserendole con competenze negative proporzionali ai giorni di assenza stessa. Richiesto solo se Tipo = AS';

alter table P660_FLUSSIREGOLE add NOME_DATO varchar2(40);
comment on column P660_FLUSSIREGOLE.NOME_DATO is 'Fluper: indica il nome del dato della V430 o il codice accorpamento a cui fa riferimento la regola';

ALTER TABLE T760_REGOLEINCENTIVI MODIFY ASSENZE VARCHAR2(700);

delete from m052_indennitakm m052 where not exists 
(select * from m040_missioni where progressivo=m052.progressivo
                               and mesescarico=m052.mesescarico
                               and mesecompetenza=m052.mesecompetenza
                               and datada=m052.datada
                               and orada=m052.orada);

alter table P660_FLUSSIREGOLE add CODICI_CAUSALI varchar2(500);
comment on column P660_FLUSSIREGOLE.CODICI_CAUSALI
  is 'Fluper: indica i codici della causali di presenza/assenza da considerare per i calcoli';

declare
  qm varchar2(20);
  CURSORE_DINAMICO INTEGER;
  CURS INTEGER;
begin
  select nomecampo into qm from i500_datiliberi where tipo = '1';
  CURSORE_DINAMICO:=DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(CURSORE_DINAMICO,'ALTER TABLE I501'||qm||' ADD DEBITOGGQM VARCHAR2(5)',DBMS_SQL.NATIVE);
  CURS:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO);
exception
  when no_data_found then null;
end;
/

