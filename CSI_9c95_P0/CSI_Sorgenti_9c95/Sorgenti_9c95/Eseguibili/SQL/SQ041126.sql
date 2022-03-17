UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '6.0.1' WHERE AZIENDA = :AZIENDA;

create table P447_CEDOLINOPARK
(
  COD_CEDOLINOPARK VARCHAR2(10) not null,
  DESCRIZIONE      VARCHAR2(80)
)
tablespace LAVORO
pctfree 10 pctused 40 initrans 1 maxtrans 255 noparallel
storage (initial 32K next 10M minextents 1 pctincrease 0);
alter table P447_CEDOLINOPARK
  add constraint P447_PK primary key (COD_CEDOLINOPARK)
  using index tablespace INDICI pctfree 10 initrans 2  maxtrans 255
  storage (initial 32K next 10M minextents 1);

create table P448_CEDOLINOPARKVOCI
(
  COD_CEDOLINOPARK      VARCHAR2(5) not null,
  PROGRESSIVO           NUMBER not null,
  TIPO_RECORD           VARCHAR2(1),
  COD_CONTRATTO         VARCHAR2(5),
  COD_VOCE              VARCHAR2(5),
  COD_VOCE_SPECIALE     VARCHAR2(5),
  ID_VOCE               NUMBER default 0,
  QUANTITA              VARCHAR2(10),
  DATOBASE              VARCHAR2(15),
  IMPORTO               NUMBER,
  IMPORTO_INTERO        NUMBER,
  DATA_COMPETENZA_QUOTE DATE,
  DATA_COMPETENZA_DA    DATE,
  DATA_COMPETENZA_A     DATE,
  ECCEZIONI             VARCHAR2(5),
  ID_VOCE_PROGRAMMATA   NUMBER,
  STATO                 VARCHAR2(2) default 'DI' not null
)
tablespace LAVORO
  pctfree 10 pctused 40 initrans 1 maxtrans 255 noparallel
  storage (initial 32K next 10M minextents 1);
comment on column P448_CEDOLINOPARKVOCI.TIPO_RECORD
  is 'Tipo record: A=Automatico, M=Manuale';
comment on column P448_CEDOLINOPARKVOCI.QUANTITA
  is 'Ore / Giorni / % / Quantità';
comment on column P448_CEDOLINOPARKVOCI.DATOBASE
  is 'Valore da stampare nella colonna Dato base. Può essere importo unitario,imponibile o altro';
comment on column P448_CEDOLINOPARKVOCI.IMPORTO_INTERO
  is 'Importo della voce prima della riduzione per Part-time e per assunzione/cessazione oppure importo prima dell''arrotondamento del calcolo';
comment on column P448_CEDOLINOPARKVOCI.DATA_COMPETENZA_QUOTE
  is 'Anno e mese di competenza per il calcolo delle quote';
comment on column P448_CEDOLINOPARKVOCI.DATA_COMPETENZA_DA
  is 'Inizio periodo di competenza per la voce';
comment on column P448_CEDOLINOPARKVOCI.DATA_COMPETENZA_A
  is 'Fine periodo di competenza per la voce';
comment on column P448_CEDOLINOPARKVOCI.ECCEZIONI
  is 'Eccezioni di calcolo a cui sottoporre la voce';
comment on column P448_CEDOLINOPARKVOCI.STATO
  is 'Stato del dato: DI=Da importare, IM=Importato su cedolino';
alter table P448_CEDOLINOPARKVOCI
  add constraint P448_FK_P200 foreign key (ID_VOCE)
  references P200_VOCI (ID_VOCE);
alter table P448_CEDOLINOPARKVOCI
  add constraint P448_FK_P447 foreign key (COD_CEDOLINOPARK)
  references P447_CEDOLINOPARK (COD_CEDOLINOPARK) on delete cascade;

DROP table P446_CEDOLINOTEMPVOCI;
DROP table P445_CEDOLINOTEMP;
create table P445_CEDOLINOTEMP
(
  PROGRESSIVO        NUMBER not null,
  DATA_CEDOLINO      DATE not null,
  DATA_RETRIBUZIONE  DATE not null,
  TIPO_CEDOLINO      VARCHAR2(2) not null,
  DATA_EMISSIONE     DATE,
  ID_CEDOLINO        NUMBER not null,
  CHIUSO             VARCHAR2(1) default 'N',
  PROGRESSIVO_MESE   NUMBER,
  COD_VALUTA_STAMPA  VARCHAR2(10),
  COD_PAGAMENTO      VARCHAR2(5),
  PERC_IRPEF_MANUALE NUMBER,
  NOTE               LONG
)
tablespace LAVORO
  pctfree 10 pctused 40 initrans 1 maxtrans 255 noparallel
  storage (initial 32K next 1M minextents 1);
-- Add comments to the columns 
comment on column P445_CEDOLINOTEMP.DATA_CEDOLINO
  is 'Anno e mese di paga (cassa)';
comment on column P445_CEDOLINOTEMP.DATA_RETRIBUZIONE
  is 'Anno e mese di retribuzione';
comment on column P445_CEDOLINOTEMP.TIPO_CEDOLINO
  is 'Tipo cedolino: NR=Normale, TR=Tredicesima, EX=Extra 27, RP=Rapporto di lavoro precedente';
comment on column P445_CEDOLINOTEMP.DATA_EMISSIONE
  is 'Data di emissione del cedolino (se assente il cedolino non è stato emesso)';
comment on column P445_CEDOLINOTEMP.CHIUSO
  is 'Chiuso (S/N) se il cedolino è stato chiuso';
comment on column P445_CEDOLINOTEMP.PROGRESSIVO_MESE
  is 'Per la gestione dei cedolini vidimati che devono contenere il numero progressivo';
comment on column P445_CEDOLINOTEMP.COD_VALUTA_STAMPA
  is 'Valuta del netto del cedolino';
comment on column P445_CEDOLINOTEMP.COD_PAGAMENTO
  is 'Codice pagamento';
comment on column P445_CEDOLINOTEMP.PERC_IRPEF_MANUALE
  is '% IRPEF manuale fissa: (opzionale)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P445_CEDOLINOTEMP
  add constraint P445_PK primary key (ID_CEDOLINO)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 2M minextents 1);
alter table P445_CEDOLINOTEMP
  add constraint P445_FK_P130 foreign key (COD_PAGAMENTO)
  references P130_PAGAMENTI (COD_PAGAMENTO);
alter table P445_CEDOLINOTEMP
  add constraint P445_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);
-- Create/Recreate indexes 
create index P445_PROG_DATA_CEDOLINO on P445_CEDOLINOTEMP (PROGRESSIVO, DATA_CEDOLINO)
  tablespace INDICI
  pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 2M minextents 1);

create table P446_CEDOLINOTEMPVOCI
(
  ID_CEDOLINO           NUMBER,
  TIPO_RECORD           VARCHAR2(1),
  COD_CONTRATTO         VARCHAR2(5),
  COD_VOCE              VARCHAR2(5),
  COD_VOCE_SPECIALE     VARCHAR2(5),
  ID_VOCE               NUMBER default 0,
  QUANTITA              VARCHAR2(10),
  DATOBASE              VARCHAR2(15),
  IMPORTO               NUMBER,
  IMPORTO_INTERO        NUMBER,
  ORIGINE               VARCHAR2(1),
  DATA_COMPETENZA_QUOTE DATE,
  DATA_COMPETENZA_DA    DATE,
  DATA_COMPETENZA_A     DATE,
  ECCEZIONI             VARCHAR2(5),
  ID_VOCE_PROGRAMMATA   NUMBER
)
tablespace LAVORO
  pctfree 10 pctused 40 initrans 1 maxtrans 255 noparallel
  storage (initial 32K next 10M minextents 1);
-- Add comments to the columns 
comment on column P446_CEDOLINOTEMPVOCI.TIPO_RECORD
  is 'Tipo record: A=Automatico, M=Manuale';
comment on column P446_CEDOLINOTEMPVOCI.QUANTITA
  is 'Ore / Giorni / % / Quantità';
comment on column P446_CEDOLINOTEMPVOCI.DATOBASE
  is 'Valore da stampare nella colonna Dato base. Può essere importo unitario,imponibile o altro';
comment on column P446_CEDOLINOTEMPVOCI.IMPORTO_INTERO
  is 'Importo della voce prima della riduzione per Part-time e per assunzione/cessazione oppure importo prima dell''arrotondamento del calcolo';
comment on column P446_CEDOLINOTEMPVOCI.ORIGINE
  is 'Origine della voce: I=Voce iniziale (es. Straordinario), A=Voce di Assenza (per entrambi i tipi gli importi possono essere calcolati dal precalcolo), P=Voce creata in fase di precalcolo (es. Stipendio), C=Voce creata in fase di calcolo (es. ritenute, detr.coniuge a carico autom.)';
comment on column P446_CEDOLINOTEMPVOCI.DATA_COMPETENZA_QUOTE
  is 'Anno e mese di competenza per il calcolo delle quote';
comment on column P446_CEDOLINOTEMPVOCI.DATA_COMPETENZA_DA
  is 'Inizio periodo di competenza per la voce';
comment on column P446_CEDOLINOTEMPVOCI.DATA_COMPETENZA_A
  is 'Fine periodo di competenza per la voce';
comment on column P446_CEDOLINOTEMPVOCI.ECCEZIONI
  is 'Eccezioni di calcolo a cui sottoporre la voce';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P446_CEDOLINOTEMPVOCI
  add constraint P446_FK_P200 foreign key (ID_VOCE)
  references P200_VOCI (ID_VOCE);
alter table P446_CEDOLINOTEMPVOCI
  add constraint P446_FK_P445 foreign key (ID_CEDOLINO)
  references P445_CEDOLINOTEMP (ID_CEDOLINO) on delete cascade;
-- Create/Recreate indexes 
create index P446_ID_CEDOLINO on P446_CEDOLINOTEMPVOCI (ID_CEDOLINO)
  tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage(initial 32K next 10M minextents 1);
create index P446_ID_VOCE_PROGRAMMATA on P446_CEDOLINOTEMPVOCI (ID_VOCE_PROGRAMMATA)
  tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage(initial 32K next 10M minextents 1);


ALTER TABLE T350_REGREPERIB ADD DETRAZ_MENSA VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T380_PIANIFREPERIB ADD TURNO3 VARCHAR2(5);
UPDATE T021_FASCEORARI SET OREMINIME = NULL WHERE TIPO_FASCIA = 'PMT';
ALTER TABLE T020_ORARI ADD ARR_ECC_FASCE_COMP VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T020_ORARI ADD PM_RECUP_USCITA VARCHAR2(5);
ALTER TABLE T200_CONTRATTI ADD ARR_INDTURNO_PAL VARCHAR2(5);

ALTER TABLE P430_ANAGRAFICO ADD CIN_EUROPA VARCHAR2(2);
ALTER TABLE P430_ANAGRAFICO ADD CIN_ITALIA VARCHAR2(1);
comment on column P430_ANAGRAFICO.CIN_EUROPA
  is 'Codice di controllo del codice IBAN per i pagamenti esteri';
comment on column P430_ANAGRAFICO.CIN_ITALIA
  is 'Codice di controllo del codice BBAN per i pagamenti nazionali';

ALTER TABLE P500_CUDSETUP ADD COD_COMUNE VARCHAR2(4);
ALTER TABLE P500_CUDSETUP ADD CODICE_FORNITURA_DMA VARCHAR2(5);
ALTER TABLE P500_CUDSETUP ADD TIPO_FORNITORE_DMA VARCHAR2(2);
ALTER TABLE P500_CUDSETUP ADD CODICE_INPDAP_DMA VARCHAR2(5);
ALTER TABLE P500_CUDSETUP ADD CODICE_MEF_DMA VARCHAR2(7);
ALTER TABLE P500_CUDSETUP ADD CODICE_ATECO_DMA VARCHAR2(5);
ALTER TABLE P500_CUDSETUP ADD CODICE_FORMA_GIUR_DMA VARCHAR2(2);
ALTER TABLE P500_CUDSETUP ADD COD_FISCALE_SW_DMA VARCHAR2(11);
ALTER TABLE P500_CUDSETUP ADD FIRMA_DENUNCIA_DMA VARCHAR2(1) DEFAULT '0' NOT NULL;
comment on column P500_CUDSETUP.FIRMA_ORGANO_CONTROLLO
  is 'Indica se prevista firma da parte di organi di controllo (0/1)';
comment on column P500_CUDSETUP.COD_COMUNE
  is 'Codice catastale (Belfiore) del comune dell''ente';
comment on column P500_CUDSETUP.CODICE_FORNITURA_DMA
  is 'Codice fornitura D.M.A.';
comment on column P500_CUDSETUP.TIPO_FORNITORE_DMA
  is 'Tipo fornitore D.M.A.';
comment on column P500_CUDSETUP.CODICE_INPDAP_DMA
  is 'Codice indentificativo assegnato all''ente dall''INPDAP';
comment on column P500_CUDSETUP.CODICE_MEF_DMA
  is 'Codice attribuito alle Ammistrazioni statali gestite dal Service personale tesoro del Ministero dell''Economia e delle finanza';
comment on column P500_CUDSETUP.CODICE_ATECO_DMA
  is 'Codice ATECO dell''ente';
comment on column P500_CUDSETUP.CODICE_FORMA_GIUR_DMA
  is 'Codice forma giuridica dell''ente per modello D.M.A.';
comment on column P500_CUDSETUP.COD_FISCALE_SW_DMA
  is 'Codice fiscale del produttore del software per modello D.M.A.';
comment on column P500_CUDSETUP.FIRMA_DENUNCIA_DMA
  is 'Indica se prevista firma del modello D.M.A (0/1)';

alter table P254_VOCIPROGRAMMATE add DATA_SCADENZA_AMM date;
alter table P254_VOCIPROGRAMMATE add COD_GESTASSIC_AMM varchar2(5);
alter table P254_VOCIPROGRAMMATE add COD_PIANO_AMM varchar2(5);
alter table P254_VOCIPROGRAMMATE add TIPO_OPER_AMM varchar2(5);
comment on column P254_VOCIPROGRAMMATE.DATA_SCADENZA_AMM
  is 'Data di scadenza del piano di ammortamento';
comment on column P254_VOCIPROGRAMMATE.COD_GESTASSIC_AMM
  is 'Codice gestione assicurativa del piano di ammortamento';
comment on column P254_VOCIPROGRAMMATE.COD_PIANO_AMM
  is 'Codice tipo contributo del piano di ammortamento';
comment on column P254_VOCIPROGRAMMATE.TIPO_OPER_AMM
  is 'Tipologia operazione del piano di ammortamento';

/*
Regole per calcolo della fornitura mensile all'INPDAP
Integrità referenziali:
*/
DROP TABLE P652_INPDAPMMREGOLE;
CREATE TABLE P652_INPDAPMMREGOLE (
  DECORRENZA DATE,
  PARTE VARCHAR2(5),
  NUMERO VARCHAR2(4),
  DESCRIZIONE VARCHAR2(200),
  TIPO_RECORD VARCHAR2(1),
  SEZIONE_FILE VARCHAR2(2),
  NUMERO_FILE VARCHAR2(3),
  FORMATO_FILE VARCHAR2(5),
  FORMATO_ANNOMESE VARCHAR2(1) DEFAULT 'N' NOT NULL,
  NUMERICO VARCHAR2(1) DEFAULT 'S',
  COD_ARROTONDAMENTO VARCHAR2(5),
  FORMATO VARCHAR2(11),
  OMETTI_VUOTO VARCHAR2(1) DEFAULT 'S',
  TIPO_DATO VARCHAR2(1) DEFAULT 'I',
  REGOLA_CALCOLO_AUTOMATICA VARCHAR2(1500),
  REGOLA_CALCOLO_MANUALE VARCHAR2(1500),
  REGOLA_MODIFICABILE VARCHAR2(1) DEFAULT 'N',
  COMMENTO VARCHAR2(300),
  CONSTRAINT P652_PK PRIMARY KEY (DECORRENZA,PARTE,NUMERO)
  USING INDEX STORAGE (pctincrease 0 initial 16K next 512K)
  TABLESPACE INDICI pctfree 10
)
STORAGE (pctincrease 0 initial 16K next 512K)
TABLESPACE LAVORO pctfree 10 pctused 40;

COMMENT ON COLUMN P652_INPDAPMMREGOLE.PARTE IS
  'Parte o sezione del DMA';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.NUMERO IS
  'Numero del dato o codice interno del DMA';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.TIPO_RECORD IS
  'Tipo record del file di esportazione';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.SEZIONE_FILE IS
  'Sezione sul file di esportazione';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.NUMERO_FILE IS
  'Numero sul file di esportazione';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.FORMATO_FILE IS
  'Formato dati per il file di esportazione';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.FORMATO_ANNOMESE IS
  'Indica se il campo prevede la sdoppiatura del dato anno/mese su due record (S/N)';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.NUMERICO IS
  'Dato numerico (S/N)';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.COD_ARROTONDAMENTO IS
  'Codice arrotondamento. Richiesto solo se dato numerico';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.FORMATO IS
  'Formato di stampa. Richiesto solo se dato numerico';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.OMETTI_VUOTO IS
  'Ometti se dato non significativo';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.TIPO_DATO IS
  'Tipo dato: I=Individuale, R=Riepilogativo';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.REGOLA_CALCOLO_AUTOMATICA IS
  'Query per estrazione dato prevista di default';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.REGOLA_CALCOLO_MANUALE IS
  'Query per estrazione dato modificata dall''utente';
COMMENT ON COLUMN P652_INPDAPMMREGOLE.REGOLA_MODIFICABILE IS
  'Query per estrazione dato modificabile dall''utente';


COMMENT ON COLUMN P655_INPDAPMMDATIINDIVIDUALI.PROGRESSIVO IS
  'Progressivo deldipendente, impostato a -1 per i dati riepilogativi';

comment on column P430_ANAGRAFICO.REDDITO_DETRAZ_FIGLI_ALTRI IS 
  'Reddito annuale per calcolo deduzioni per oneri di famiglia; (opzionale)';

ALTER TABLE SG500_DATILIBERI MODIFY RIFPROVVED DEFAULT 'N';
ALTER TABLE SG500_DATILIBERI MODIFY ARCHIVIO VARCHAR2(50);
ALTER TABLE SG500_DATILIBERI MODIFY NOMECAMPO VARCHAR2(50);
ALTER TABLE SG500_DATILIBERI MODIFY VARIABILE VARCHAR2(50);

DROP table P094_INQUADRINPDAP;
create table P094_INQUADRINPDAP
(
  COD_INQUADRINPDAP          VARCHAR2(10) not null,
  DECORRENZA                 DATE not null,
  DESCRIZIONE                VARCHAR2(80),
  COD_GESTASSIC              VARCHAR2(40),
  COD_TIPOIMPIEGO_INDET      VARCHAR2(5),
  COD_TIPOIMPIEGO_DET        VARCHAR2(5),
  COD_TIPOSERVIZIO_ORDINARIO VARCHAR2(5),
  COD_TIPOSERVIZIO_PARTTIME  VARCHAR2(5),
  COD_MAGGIORAZIONI          VARCHAR2(40)
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

comment on column P094_INQUADRINPDAP.COD_GESTASSIC
  is 'Elenco gestioni assicurative coperte (campo multiplo con virgola per separatore)';
comment on column P094_INQUADRINPDAP.COD_TIPOIMPIEGO_INDET
  is 'Codice tipo impiego da utilizzarsi per i dipendenti assunti a tempo indeterminato';
comment on column P094_INQUADRINPDAP.COD_TIPOIMPIEGO_DET
  is 'Codice tipo impiego da utilizzarsi per i dipendenti assunti a tempo determinato';
comment on column P094_INQUADRINPDAP.COD_TIPOSERVIZIO_ORDINARIO
  is 'Codice tipo servizio da utilizzarsi per i dipendenti a tempo pieno';
comment on column P094_INQUADRINPDAP.COD_TIPOSERVIZIO_PARTTIME
  is 'Codice tipo servizio da utilizzarsi per i dipendenti a part-time';
comment on column P094_INQUADRINPDAP.COD_MAGGIORAZIONI
  is 'Elenco maggiorazioni (campo multiplo con virgola per separatore)';

alter table P094_INQUADRINPDAP
  add constraint P094_PK primary key (COD_INQUADRINPDAP, DECORRENZA)
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

ALTER TABLE P206_ASSENZEINPDAP ADD COD_CAUSASOSPENSIONE VARCHAR2(5);
ALTER TABLE P206_ASSENZEINPDAP ADD PERC_ASP_SINDACALE NUMBER;

comment on column P206_ASSENZEINPDAP.COD_CAUSASOSPENSIONE
  is 'Codice causa di sospensione del servizio';
comment on column P206_ASSENZEINPDAP.PERC_ASP_SINDACALE
  is 'Percentuale aspettativa sindacale';

insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA)
values ('PO_ANOMALIE_PERCORSO', 0, '  SELECT SG506.ID_RAMO, SG506.ID_padre, SG506.PERCORSO');
insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA)
values ('PO_ANOMALIE_PERCORSO', 1, '    FROM SG506_piantadistribuzione SG506');
insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA)
values ('PO_ANOMALIE_PERCORSO', 2, '   WHERE exists');
insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA)
values ('PO_ANOMALIE_PERCORSO', 3, '        (select ''X'' from sg506_piantadistribuzione SG506b');
insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA)
values ('PO_ANOMALIE_PERCORSO', 4, '          where SG506b.PERCORSO <> substr(SG506.percorso,1,length(SG506b.PERCORSO))');
insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA)
values ('PO_ANOMALIE_PERCORSO', 5, '            and SG506b.id_ramo = SG506.id_padre)');

COMMENT ON COLUMN P193_VOCIVARIABILIINPUT.STATO IS
  'Stato del dato: PA=Prima acquisizione, AD=Acquisizione definitiva, AN=Scartato per anomalia';

ALTER TABLE P655_INPDAPMMDATIINDIVIDUALI MODIFY NUMERO VARCHAR2(4);
COMMENT ON COLUMN P655_INPDAPMMDATIINDIVIDUALI.PARTE IS
  'Parte o sezione della dichiarazione mensile INPDAP';
COMMENT ON COLUMN P655_INPDAPMMDATIINDIVIDUALI.NUMERO IS
  'Numero del dato o codice interno della dichiarazione mensile INPDAP';

COMMENT ON COLUMN P442_CEDOLINOVOCI.ORIGINE IS
  'Origine della voce: I=Voce iniziale (es. Straordinario), A=Voce di Assenza (per entrambi i tipi gli importi possono essere calcolati dal precalcolo), P=Voce creata in fase di precalcolo (es. Stipendio), C=Voce creata in fase di calcolo (es. ritenute, detr.coniuge a carico autom.), R=Voce da rilevazione presenze, G=Voce da conguaglio retroattivo';

UPDATE SG500_DATILIBERI 
       SET ARCHIVIO = 'V430_STORICO', 
               NOMECAMPO = 'T430' || NOMECAMPO
WHERE ARCHIVIO = 'T430_STORICO';
COMMIT;

alter table T041_PROVVISORIO add PROGRCAUSALE NUMBER(38,2) default 0;
alter table T025_CONTMENSILI modify RECUPERODEBITO default -1;

ALTER TABLE T950_STAMPACARTELLINO ADD ORIENTAMENTO VARCHAR2(1) DEFAULT 'V';
COMMENT ON COLUMN T950_STAMPACARTELLINO.ORIENTAMENTO IS
  'Orientamento pagina: O=Orizzontale, V=Verticale';

ALTER TABLE P092_CODICIINAIL MODIFY TIPO_APPLICAZIONE VARCHAR2(1) DEFAULT 'G';
COMMENT ON COLUMN P092_CODICIINAIL.TIPO_APPLICAZIONE IS
  'Tipo applicazione minimale/massimale: G=Giornaliera, M=Mensile';

ALTER TABLE P448_CEDOLINOPARKVOCI MODIFY COD_CEDOLINOPARK VARCHAR2(10);

ALTER TABLE T265_CAUASSENZE ADD PERC_INAIL NUMBER(5,2);
ALTER TABLE T275_CAUPRESENZE ADD PERC_INAIL VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T070_SCHEDARIEPIL ADD ORE_INAIL VARCHAR2(6);

--MISSIONI--
-- Create table
create table M021_TIPIINDENNITAKM
(
  CODICE          varchar2(5),
  DESCRIZIONE     varchar2(40),
  DECORRENZA      date,
  IMPORTO         number,
  CODVOCEPAGHE varchar2(6),
  ARROTONDAMENTO  varchar2(5)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 16K
    minextents 1
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table M021_TIPIINDENNITAKM
  add constraint PK_M021 primary key (CODICE, DECORRENZA);

-- popolo la tabella M021_TIPIINDENNITAKM
declare cursor c1 is 
  select decorrenza, indennitakmnelcomune, arrotimportikmnelcomune, indennitakmfuoricomune, arrotimportikmfuoricomune
    from m010_parametriconteggio;
  indincommis varchar2(6);
  indincomfor varchar2(6);
  indfucommis varchar2(6);
  indfucomfor varchar2(6);
  conta integer;
  CURSOR C2 IS
    -- MISSIONI NEL COMUNE
    select VOCE_PAGHE, count(*) as CONTA
      from t190_interfacciapaghe
      where codinterno = '408'
        and VOCE_PAGHE is not null
      group by VOCE_PAGHE
      order by 2 desc;
    -- MISSIONI FUORI COMUNE
  CURSOR C3 IS
    select VOCE_PAGHE, count(*) as CONTA
      from t190_interfacciapaghe
      where codinterno = '410'
        and VOCE_PAGHE is not null
      group by VOCE_PAGHE
      order by 2 desc;
    -- FORMAZIONE NEL COMUNE
  CURSOR C4 IS
    select VOCE_PAGHE, count(*) as CONTA
      from t190_interfacciapaghe
      where codinterno = '420'
        and VOCE_PAGHE is not null
      group by VOCE_PAGHE
      order by 2 desc;
    -- FORMAZIONE FUORI COMUNE
  CURSOR C5 IS
    select VOCE_PAGHE, count(*) as CONTA
      from t190_interfacciapaghe
      where codinterno = '422'
        and VOCE_PAGHE is not null
      group by VOCE_PAGHE
      order by 2 desc;
begin
  indincommis:='';
  indincomfor:='';
  indfucommis:='';
  indfucomfor:='';
  open C2;
  FETCH c2 into indincommis, conta;
  close C2;
  open C3;
  FETCH c3 into indfucommis, conta;
  close C3;
  open C4;
  FETCH c4 into indincomfor, conta;
  close C4;
  open C5;
  FETCH c5 into indfucomfor, conta;
  close C5;
  for t1 in c1 loop
    INSERT INTO M021_TIPIINDENNITAKM 
    (codice, descrizione, decorrenza, importo, codvocepaghe, arrotondamento)
    VALUES
    ('INCOM', 'Indennità km nel comune per missione', t1.decorrenza, t1.indennitakmnelcomune, indincommis, t1.arrotimportikmnelcomune); 
    INSERT INTO M021_TIPIINDENNITAKM 
    (codice, descrizione, decorrenza, importo, codvocepaghe, arrotondamento)
    VALUES
    ('FCOMM', 'Indennità km fuori comune per missione', t1.decorrenza, t1.indennitakmnelcomune, indfucommis, t1.arrotimportikmnelcomune); 
    INSERT INTO M021_TIPIINDENNITAKM 
    (codice, descrizione, decorrenza, importo, codvocepaghe, arrotondamento)
    VALUES
    ('INCOF', 'Indennità km nel comune per formazione', t1.decorrenza, t1.indennitakmfuoricomune, indincomfor, t1.arrotimportikmfuoricomune); 
    INSERT INTO M021_TIPIINDENNITAKM 
    (codice, descrizione, decorrenza, importo, codvocepaghe, arrotondamento)
    VALUES
    ('FCOMF', 'Indennità km fuori comune per formazione', t1.decorrenza, t1.indennitakmfuoricomune, indfucomfor, t1.arrotimportikmfuoricomune); 
  end loop;
end;
/

-- Create table
create table M052_INDENNITAKM
(
  PROGRESSIVO       NUMBER not null,
  MESESCARICO       DATE not null,
  MESECOMPETENZA    DATE not null,
  DATADA            DATE not null,
  ORADA             VARCHAR2(5) not null,
  CODICEINDENNITAKM VARCHAR2(5) not null,
  KMPERCORSI        NUMBER,
  IMPORTOINDENNITA  NUMBER
)
tablespace LAVORO
  pctfree 10
  pctused 60
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 256K
    minextents 1
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table M052_INDENNITAKM
  add constraint PK_M052 primary key (PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA, CODICEINDENNITAKM)
  using index 
  tablespace LAVORO
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    next 256K
    minextents 1
  );

-- Create table
create table M011_TIPOMISSIONE
(
  CODICE      VARCHAR2(5) not null,
  DESCRIZIONE VARCHAR2(40),
  SELEZIONATO VARCHAR2(1) default 'N' not null
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 16K
    minextents 1
  );

INSERT INTO M011_TIPOMISSIONE (CODICE, DESCRIZIONE, SELEZIONATO) VALUES ('MITA','MISSIONE IN ITALIA','S');
INSERT INTO M011_TIPOMISSIONE (CODICE, DESCRIZIONE, SELEZIONATO) VALUES ('FITA','FORMAZIONE IN ITALIA','N');

-- Create/Recreate primary, unique and foreign key constraints 
alter table M011_TIPOMISSIONE
  add constraint PK_M011 primary key (CODICE)
  using index 
  tablespace LAVORO
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    next 16K
    minextents 1
  );

drop table M010_PARAMETRI600;
create table M010_PARAMETRI600 as select * from M010_PARAMETRICONTEGGIO;
DROP table M010_PARAMETRICONTEGGIO;
-- Create table
create table M010_PARAMETRICONTEGGIO
(
  DECORRENZA                DATE not null,
  CODICE                    VARCHAR2(80) not null,
  TIPO_MISSIONE             VARCHAR2(5) not null,
  DESCRIZIONE               VARCHAR2(40),
  OREMINIMEPERINDENNITA     VARCHAR2(5),
  LIMITEORERETRIBUITEINTERE VARCHAR2(6),
  ARROTONDAMENTOORE         NUMBER,
  PERCRETRIBSUPEROORE       NUMBER,
  MAXGIORNIRETRMESE         NUMBER,
  PERCRETRIBSUPEROGG        NUMBER,
  ARROTTARIFFADOPORIDUZIONE VARCHAR2(5),
  ARROTTOTIMPORTIDATIPAGHE  VARCHAR2(5),
  TIPO                      VARCHAR2(1) not null,
  RIDUZIONE_PASTO           VARCHAR2(1)  default 'N' not null,
  PERCRETRIBPASTO           NUMBER,
  TARIFFAINDENNITA          NUMBER default 0,
  TIPO_TARIFFA              VARCHAR2(1) default 'O',
  CODVOCEPAGHEINTERA        VARCHAR2(6),
  CODVOCEPAGHESUPHH         VARCHAR2(6),
  CODVOCEPAGHESUPGG         VARCHAR2(6),
  CODVOCEPAGHESUPHHGG       VARCHAR2(6),
  CODRIMBORSOPASTO          VARCHAR2(5),
  ORERIMBORSOPASTO          VARCHAR2(5),
  TARIFFARIMBORSOPASTO      NUMBER,
  ORERIMBORSOPASTO2         VARCHAR2(5),
  TARIFFARIMBORSOPASTO2     NUMBER
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 16K
    minextents 1
    pctincrease 50
  );
-- Add comments to the columns 
comment on column M010_PARAMETRICONTEGGIO.CODICE
  is 'Codice del dato libero che rappresenta la categoria economica';
comment on column M010_PARAMETRICONTEGGIO.TIPO_MISSIONE
  is 'Indica se si tratta di misisone in italia, missione all''estero, formazione ecc...';
comment on column M010_PARAMETRICONTEGGIO.TARIFFAINDENNITA
  is 'Tariffa di indennità intera';
comment on column M010_PARAMETRICONTEGGIO.TIPO_TARIFFA
  is 'O=indica che la tariffa intera è oraria  G=indica che la tariffa è giornaliera';
comment on column M010_PARAMETRICONTEGGIO.CODVOCEPAGHEINTERA
  is 'codice voce paghe per indennità intera';
comment on column M010_PARAMETRICONTEGGIO.CODVOCEPAGHESUPHH
  is 'codice voce paghe al supero ore';
comment on column M010_PARAMETRICONTEGGIO.CODVOCEPAGHESUPGG
  is 'codice voce paghe al supero giorni nel mese';
comment on column M010_PARAMETRICONTEGGIO.CODVOCEPAGHESUPHHGG
  is 'codice voce paghe al supero ore e giorni nel mese';
comment on column M010_PARAMETRICONTEGGIO.CODRIMBORSOPASTO
  is 'codice che indica il rimborso del pasto';
comment on column M010_PARAMETRICONTEGGIO.ORERIMBORSOPASTO
  is 'ore dopo cui viene riconosciuto il primo rimborso pasto';
comment on column M010_PARAMETRICONTEGGIO.TARIFFARIMBORSOPASTO
  is 'importo massimo spettante per il primo rimborso pasto';
comment on column M010_PARAMETRICONTEGGIO.ORERIMBORSOPASTO2
  is 'ore dopo cui viene riconosciuto il secondo rimborso pasto';
comment on column M010_PARAMETRICONTEGGIO.TARIFFARIMBORSOPASTO2
  is 'importo massimo spettante per il secondo rimborso pasto';
-- Create/Recreate primary, unique and foreign key constraints 
alter table M010_PARAMETRICONTEGGIO
  add constraint M010_PK primary key (CODICE, TIPO_MISSIONE, DECORRENZA)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    next 16K
    minextents 1
  );

-- popolo la tabella M010_PARAMETRICONTEGGIO con i dati contenuti nella tabella delle tariffe
declare 
  cursor c1 is 
  select codice, decorrenza, descrizione, tariffaorariaindtrasferta, codicerimborso, orerimborso, tariffarimborso, 
         orerimborso2, tariffarimborso2
    from m030_tariffaoraria
   order by codice, decorrenza;
  cursor c2 is 
  select decorrenza, descrizione, oreminimeperindennita, limiteoreretribuiteintere, arrotondamentoore, 
         percretribsuperoore, maxgiorniretrmese, percretribsuperogg, arrottariffadoporiduzione, 
         arrottotimportidatipaghe, indennitakmnelcomune, arrotimportikmnelcomune, indennitakmfuoricomune, 
         arrotimportikmfuoricomune, tipo, riduzione_pasto, percretribpasto
    from M010_PARAMETRI600
   order by decorrenza desc;
begin
  for t1 in c1 LOOP
    for t2 in c2 LOOP
      insert into m010_parametriconteggio
      (decorrenza, descrizione, oreminimeperindennita, limiteoreretribuiteintere, arrotondamentoore, 
        percretribsuperoore, maxgiorniretrmese, percretribsuperogg, arrottariffadoporiduzione, 
        arrottotimportidatipaghe, tipo, riduzione_pasto, percretribpasto, codice, tipo_missione, 
        tariffaindennita, tipo_tariffa, codrimborsopasto, orerimborsopasto, tariffarimborsopasto, 
        orerimborsopasto2, tariffarimborsopasto2)
       VALUES
       (T1.DECORRENZA,T1.DESCRIZIONE,t2.oreminimeperindennita,t2.limiteoreretribuiteintere,t2.arrotondamentoore,
        t2.percretribsuperoore, t2.maxgiorniretrmese, t2.percretribsuperogg, t2.arrottariffadoporiduzione, 
        t2.arrottotimportidatipaghe, t2.tipo, t2.riduzione_pasto, t2.percretribpasto, t1.codice, 'MITA', 
        t1.tariffaorariaindtrasferta, 'O', t1.codicerimborso, t1.orerimborso, t1.tariffarimborso, 
        t1.orerimborso2, t1.tariffarimborso2);
        EXIT;
    END LOOP;
  END LOOP;
end;
/

-- AGGIORNO I CODICI PAGHE SULLA TABELLA M010_PARAMETRICONTEGGIO
declare 
  Mindint varchar2(6);
  Mindhh varchar2(6);
  Mindgg varchar2(6);
  Mindhhgg varchar2(6);
  Findint varchar2(6);
  Findhh varchar2(6);
  Findgg varchar2(6);
  Findhhgg varchar2(6);
  conta integer;
  CURSOR C2 IS
    select VOCE_PAGHE, count(*) as CONTA
      from t190_interfacciapaghe
      where codinterno = '400'
        and VOCE_PAGHE is not null
      group by VOCE_PAGHE
      order by 2 desc;
  CURSOR C3 IS
    select VOCE_PAGHE, count(*) as CONTA
      from t190_interfacciapaghe
      where codinterno = '402'
        and VOCE_PAGHE is not null
      group by VOCE_PAGHE
      order by 2 desc;
  CURSOR C4 IS
    select VOCE_PAGHE, count(*) as CONTA
      from t190_interfacciapaghe
      where codinterno = '404'
        and VOCE_PAGHE is not null
      group by VOCE_PAGHE
      order by 2 desc;
  CURSOR C5 IS
    select VOCE_PAGHE, count(*) as CONTA
      from t190_interfacciapaghe
      where codinterno = '406'
        and VOCE_PAGHE is not null
      group by VOCE_PAGHE
      order by 2 desc;
  CURSOR C6 IS
    select VOCE_PAGHE, count(*) as CONTA
      from t190_interfacciapaghe
      where codinterno = '412'
        and VOCE_PAGHE is not null
      group by VOCE_PAGHE
      order by 2 desc;
  CURSOR C7 IS
    select VOCE_PAGHE, count(*) as CONTA
      from t190_interfacciapaghe
      where codinterno = '414'
        and VOCE_PAGHE is not null
      group by VOCE_PAGHE
      order by 2 desc;
  CURSOR C8 IS
    select VOCE_PAGHE, count(*) as CONTA
      from t190_interfacciapaghe
      where codinterno = '416'
        and VOCE_PAGHE is not null
      group by VOCE_PAGHE
      order by 2 desc;
  CURSOR C9 IS
    select VOCE_PAGHE, count(*) as CONTA
      from t190_interfacciapaghe
      where codinterno = '418'
        and VOCE_PAGHE is not null
      group by VOCE_PAGHE
      order by 2 desc;
  CURSOR C10 IS
    SELECT 
      decorrenza, descrizione, oreminimeperindennita, limiteoreretribuiteintere, arrotondamentoore, percretribsuperoore, 
      maxgiorniretrmese, percretribsuperogg, arrottariffadoporiduzione, arrottotimportidatipaghe, 
      tipo, riduzione_pasto, percretribpasto, codice, tipo_missione, tariffaindennita, tipo_tariffa, codvocepagheintera, 
      codvocepaghesuphh, codvocepaghesupgg, codvocepaghesuphhgg, codrimborsopasto, orerimborsopasto, tariffarimborsopasto, 
      orerimborsopasto2, tariffarimborsopasto2
    FROM M010_PARAMETRICONTEGGIO;
begin
  Mindint:='';
  Mindhh:='';
  Mindgg:='';
  Mindhhgg:='';
  Findint:='';
  Findhh:='';
  Findgg:='';
  Findhhgg:='';
  open C2;
  FETCH c2 into Mindint, conta;
  close C2;
  open C3;
  FETCH c3 into Mindhh, conta;
  close C3;
  open C4;
  FETCH c4 into Mindgg, conta;
  close C4;
  open C5;
  FETCH c5 into Mindhhgg, conta;
  close C5;
  open C6;
  FETCH c6 into Findint, conta;
  close C6;
  open C7;
  FETCH C7 into Findhh, conta;
  close C7;
  open C8;
  FETCH c8 into Findgg, conta;
  close C8;
  open C9;
  FETCH c9 into Findhhgg, conta;
  close C9;
  update m010_parametriconteggio set codvocepagheintera=Mindint where codvocepagheintera is null;
  update m010_parametriconteggio set codvocepaghesuphh=Mindhh where codvocepaghesuphh is null;
  update m010_parametriconteggio set codvocepaghesupgg=Mindgg where codvocepaghesupgg is null;
  update m010_parametriconteggio set codvocepaghesuphhgg=Mindhhgg where codvocepaghesuphhgg is null;
  FOR T1 IN C10 LOOP
    INSERT INTO M010_PARAMETRICONTEGGIO
    (decorrenza, descrizione, oreminimeperindennita, limiteoreretribuiteintere, arrotondamentoore, percretribsuperoore, 
     maxgiorniretrmese, percretribsuperogg, arrottariffadoporiduzione, arrottotimportidatipaghe, tipo, riduzione_pasto, percretribpasto, 
     codice, tipo_missione, tariffaindennita, tipo_tariffa, codvocepagheintera, codvocepaghesuphh, codvocepaghesupgg, 
     codvocepaghesuphhgg, codrimborsopasto, orerimborsopasto, tariffarimborsopasto, orerimborsopasto2, tariffarimborsopasto2)
    VALUES
    (T1.decorrenza, T1.descrizione, T1.oreminimeperindennita, T1.limiteoreretribuiteintere, T1.arrotondamentoore, T1.percretribsuperoore, 
     T1.maxgiorniretrmese, T1.percretribsuperogg, T1.arrottariffadoporiduzione, T1.arrottotimportidatipaghe, T1.tipo, T1.riduzione_pasto, T1.percretribpasto, 
     T1.codice, 'FITA', T1.tariffaindennita, T1.tipo_tariffa, Findint, Findhh, Findgg, 
     Findhhgg, T1.codrimborsopasto, T1.orerimborsopasto, T1.tariffarimborsopasto, T1.orerimborsopasto2, T1.tariffarimborsopasto2);
  END LOOP;
End;
/

-- Create table
create table M049_TIPOPAGAMENTO
(
  CODICE       varchar2(5),
  DESCRIZIONE  varchar2(40),
  SOMMA        varchar2(1) default 'S'
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 16K
    minextents 1
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table M049_TIPOPAGAMENTO
  add constraint PK_M049 primary key (CODICE);

-- Create table
create table M051_DETTAGLIORIMBORSO
(
  PROGRESSIVO         NUMBER not null,
  MESESCARICO         DATE not null,
  MESECOMPETENZA      DATE not null,
  DATADA              DATE not null,
  ORADA               VARCHAR2(5) not null,
  CODICERIMBORSOSPESE VARCHAR2(5) not null,
  PROGRIMBORSO        NUMBER not null,
  DATARIMBORSO        DATE not null,
  IMPORTO             NUMBER,
  TIPORIMBORSO        VARCHAR2(5)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 256K
    minextents 1
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table M051_DETTAGLIORIMBORSO
  add constraint PK_M051 primary key (PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA, CODICERIMBORSOSPESE, DATARIMBORSO, PROGRIMBORSO)
  using index 
  tablespace LAVORO
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    next 256K
    minextents 1
  );

rename m030_tariffaoraria to m030_tariffaoraria600;

-- tabella missioni
drop table M040_MISSIONI600;
create table M040_MISSIONI600 as select * from M040_MISSIONI;
DROP TRIGGER m040_afterdelete;
DROP TRIGGER m040_afterupdate;
DROP TRIGGER ti_m050_rimborsi;
DROP table M040_MISSIONI;
-- Create table
create table M040_MISSIONI
(
  PROGRESSIVO             NUMBER not null,
  MESESCARICO             DATE not null,
  MESECOMPETENZA          DATE not null,
  DATADA                  DATE not null,
  ORADA                   VARCHAR2(5) not null,
  PROTOCOLLO              VARCHAR2(10),
  TIPOREGISTRAZIONE       VARCHAR2(5) not null,
  DATAA                   DATE,
  ORAA                    VARCHAR2(5),
  TOTALEGG                NUMBER default 0,
  DURATA                  VARCHAR2(7),
  TARIFFAINDINTERA        NUMBER default 0,
  OREINDINTERA            NUMBER default 0,
  IMPORTOINDINTERA        NUMBER default 0,
  TARIFFAINDRIDOTTAH      NUMBER default 0,
  OREINDRIDOTTAH          NUMBER default 0,
  IMPORTOINDRIDOTTAH      NUMBER default 0,
  TARIFFAINDRIDOTTAG      NUMBER default 0,
  OREINDRIDOTTAG          NUMBER default 0,
  IMPORTOINDRIDOTTAG      NUMBER default 0,
  TARIFFAINDRIDOTTAHG     NUMBER default 0,
  OREINDRIDOTTAHG         NUMBER default 0,
  IMPORTOINDRIDOTTAHG     NUMBER default 0,
  FLAG_MODIFICATO         VARCHAR2(1),
  PARTENZA                VARCHAR2(80),
  DESTINAZIONE            VARCHAR2(80),
  NOTE_RIMBORSI           VARCHAR2(240),
  COMMESSA                VARCHAR2(80)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 256K
    minextents 1
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table M040_MISSIONI
  add primary key (PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    next 256K
    minextents 1
  );

-- popolo tale tabella delle missioni importanto i dati dalla tabella rinominata
declare cursor c1 is 
  select progressivo, mesescarico, mesecompetenza, datada, orada, protocollo, tiporegistrazione, dataa, oraa, 
         totalegg, durata, tariffaindintera, oreindintera, importoindintera, tariffaindridottah, oreindridottah, 
         importoindridottah, tariffaindridottag, oreindridottag, importoindridottag, tariffaindridottahg, oreindridottahg, 
         importoindridottahg, flag_modificato, partenza, destinazione, note_rimborsi
    from M040_MISSIONI600;
  stiporeg varchar2(4);
begin
  for t1 in c1 loop
    if t1.tiporegistrazione = 'M' then
      stiporeg:='MITA';
    else
      stiporeg:='FITA';
    end if;
    INSERT INTO M040_MISSIONI 
        (progressivo, mesescarico, mesecompetenza, datada, orada, protocollo, tiporegistrazione, dataa, oraa, 
         totalegg, durata, tariffaindintera, oreindintera, importoindintera, tariffaindridottah, oreindridottah, 
         importoindridottah, tariffaindridottag, oreindridottag, importoindridottag, tariffaindridottahg, oreindridottahg, 
         importoindridottahg, flag_modificato, partenza, destinazione, note_rimborsi)
    VALUES
        (t1.progressivo, t1.mesescarico, t1.mesecompetenza, t1.datada, t1.orada, t1.protocollo, stiporeg, t1.dataa, t1.oraa, 
         t1.totalegg, t1.durata, t1.tariffaindintera, t1.oreindintera, t1.importoindintera, t1.tariffaindridottah, t1.oreindridottah, 
         t1.importoindridottah, t1.tariffaindridottag, t1.oreindridottag, t1.importoindridottag, t1.tariffaindridottahg, t1.oreindridottahg, 
         t1.importoindridottahg, t1.flag_modificato, t1.partenza, t1.destinazione, t1.note_rimborsi);
  end loop;
end;
/
-- popolo la tabella delle inennità chilometriche importanto i dati dalla tabella delle missioni rinominata
declare cursor c1 is 
  select progressivo, mesescarico, mesecompetenza, datada, orada, tiporegistrazione, tariffaindkmnelcomune, kmpercorsinelcomune, 
         importoindkmnelcomune, tariffaindkmfuoricomune, kmpercorsifuoricomune, importoindkmfuoricomune
    from M040_MISSIONI600;
begin
  for t1 in c1 loop
    if t1.tiporegistrazione = 'M' then 
      if t1.kmpercorsinelcomune > 0 then
        INSERT INTO M052_INDENNITAKM
            (progressivo, mesescarico, mesecompetenza, datada, orada, codiceindennitakm, kmpercorsi, importoindennita)
        VALUES
            (t1.progressivo, t1.mesescarico, t1.mesecompetenza, t1.datada, t1.orada, 'INCOM', T1.kmpercorsinelcomune,T1.importoindkmnelcomune);
      end if;
      if t1.kmpercorsifuoricomune> 0 then    
        INSERT INTO M052_INDENNITAKM
            (progressivo, mesescarico, mesecompetenza, datada, orada, codiceindennitakm, kmpercorsi, importoindennita)
        VALUES
            (t1.progressivo, t1.mesescarico, t1.mesecompetenza, t1.datada, t1.orada, 'FCOMM', T1.kmpercorsifuoricomune,T1.importoindkmfuoricomune);
      end if;
    else
      if t1.kmpercorsinelcomune > 0 then
        INSERT INTO M052_INDENNITAKM
            (progressivo, mesescarico, mesecompetenza, datada, orada, codiceindennitakm, kmpercorsi, importoindennita)
        VALUES
            (t1.progressivo, t1.mesescarico, t1.mesecompetenza, t1.datada, t1.orada, 'INCOF', T1.kmpercorsinelcomune,T1.importoindkmnelcomune);
      end if;
      if t1.kmpercorsifuoricomune> 0 then    
        INSERT INTO M052_INDENNITAKM
            (progressivo, mesescarico, mesecompetenza, datada, orada, codiceindennitakm, kmpercorsi, importoindennita)
        VALUES
            (t1.progressivo, t1.mesescarico, t1.mesecompetenza, t1.datada, t1.orada, 'FCOMF', T1.kmpercorsifuoricomune,T1.importoindkmfuoricomune);
      end if;
    end if;
  end loop;
end;
/
-- Add/modify columns 
alter table M050_RIMBORSI add IMPORTOCOSTORIMBORSO number default 0;
UPDATE M050_RIMBORSI SET IMPORTOCOSTORIMBORSO = IMPORTORIMBORSOSPESE;

delete from T190_INTERFACCIAPAGHE where CODINTERNO in ('410','412','414','416','418','420','422');
update T190_INTERFACCIAPAGHE set VOCE_PAGHE = NULL WHERE CODINTERNO in ('400','402','404','406','408');
update t195_vocivariabili set COD_INTERNO = '408' where COD_INTERNO IN ('410','420','422');
update t195_vocivariabili set COD_INTERNO = '400' where COD_INTERNO = '412';
update t195_vocivariabili set COD_INTERNO = '402' where COD_INTERNO = '414';
update t195_vocivariabili set COD_INTERNO = '404' where COD_INTERNO = '416';
update t195_vocivariabili set COD_INTERNO = '406' where COD_INTERNO = '418';

--INCENTIVI--
create table T765_TIPOQUOTE
(
  Codice VARCHAR2(5),
  Descrizione VARCHAR2(40),
  TipoQuota VARCHAR2(1) default 'A'
)
tablespace LAVORO pctfree 10 pctused 40 initrans 1 maxtrans 255 
storage (initial 12K next 12K pctincrease 0 minextents 1);

comment on column T765_TIPOQUOTE.TIPOQUOTA
  is 'A=Acconto; S=Saldo';

alter table T765_TIPOQUOTE
  add constraint T765_PK primary key (Codice)
  using index 
  tablespace INDICI pctfree 10 initrans 2 maxtrans 255 
  storage (initial 12K next 12K pctincrease 0 minextents 1);

create table T770_QUOTE
(
  Dato1 VARCHAR2(20),
  Dato2 VARCHAR2(20),
  Dato3 VARCHAR2(20),
  CodTipoQuota VARCHAR2(5),
  Decorrenza DATE,
  Incentivi NUMBER,
  Risorse NUMBER
)
tablespace LAVORO pctfree 10 pctused 40 initrans 1 maxtrans 255 
storage (initial 12K next 256K pctincrease 0 minextents 1);

alter table T770_QUOTE
  add constraint T770_PK primary key (Dato1,Dato2,Dato3,CodTipoQuota,Decorrenza)
  using index 
  tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 12K next 256K pctincrease 0 minextents 1);

alter table T770_QUOTE modify DATO1 default ' ';
alter table T770_QUOTE modify DATO2 default ' ';
alter table T770_QUOTE modify DATO3 default ' ';

alter table T770_QUOTE
  add constraint T770_FK_T765 foreign key (CodTipoQuota)
  references T765_TIPOQUOTE (Codice);

create table T772_PENALIZZINCENTIVI
(
  Dato1 VARCHAR2(20),
  Dato2 VARCHAR2(20),
  Dato3 VARCHAR2(20),
  Penalizzazione NUMBER(5,2)  
)
tablespace LAVORO pctfree 10 pctused 40 initrans 1 maxtrans 255 
storage (initial 12K next 256K pctincrease 0 minextents 1);

alter table T772_PENALIZZINCENTIVI modify DATO1 default ' ';
alter table T772_PENALIZZINCENTIVI modify DATO2 default ' ';
alter table T772_PENALIZZINCENTIVI modify DATO3 default ' ';

alter table T772_PENALIZZINCENTIVI
  add constraint T772_PK primary key (Dato1,Dato2,Dato3)
  using index 
  tablespace INDICI pctfree 10 initrans 2 maxtrans 255 
  storage (initial 12K next 256K pctincrease 0 minextents 1);
 
create table T775_QUOTEINDIVIDUALI
(
  Progressivo NUMBER(8),
  Decorrenza DATE,
  Scadenza DATE,
  CodTipoQuota VARCHAR2(5) ,
  Incentivi NUMBER,
  Risorse NUMBER,
  Penalizzazione NUMBER(5,2)  
)
tablespace LAVORO pctfree 10 pctused 40 initrans 1 maxtrans 255
storage (initial 12K next 256K pctincrease 0 minextents 1);

alter table T775_QUOTEINDIVIDUALI
  add constraint T775_PK primary key (Progressivo,Decorrenza,CodTipoQuota)
  using index 
  tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 12K next 256K pctincrease 0 minextents 1);

alter table T775_QUOTEINDIVIDUALI
  add constraint T775_FK_T765 foreign key (CodTipoQuota)
  references T765_TIPOQUOTE (Codice);

ALTER TABLE T760_REGOLEINCENTIVI ADD ABBATTIMENTO_MAX NUMBER;
ALTER TABLE T760_REGOLEINCENTIVI ADD ASSENZE_TOLLERATE_FRANCHIGIA VARCHAR2(200);
ALTER TABLE T760_REGOLEINCENTIVI ADD GESTIONE_FRANCHIGIA VARCHAR2(1) DEFAULT 'R'; 
ALTER TABLE T760_REGOLEINCENTIVI ADD PROPORZIONE_INCENTIVI VARCHAR2(1) DEFAULT '0'; 

ALTER TABLE T762_INCENTIVIMATURATI ADD TIPOQUOTA VARCHAR2(1) DEFAULT 'A';
ALTER TABLE T762_INCENTIVIMATURATI MODIFY TIPOQUOTA VARCHAR2(5);
ALTER TABLE T762_INCENTIVIMATURATI ADD RISORSE NUMBER;
ALTER TABLE T762_INCENTIVIMATURATI ADD VAR_RISORSE NUMBER;
ALTER TABLE T762_INCENTIVIMATURATI DROP PRIMARY KEY;
ALTER TABLE T762_INCENTIVIMATURATI ADD CONSTRAINT T762_PK PRIMARY KEY (PROGRESSIVO,ANNO,MESE,TIPOQUOTA);

DELETE FROM MONDOEDP.I091_DATIENTE WHERE TIPO IN ('C12_PREFERENZECOMP','C3_INDPRES3','C7_PO_LIVSTRUT','C7_PO_MANSIONE');
INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA,TIPO)  SELECT AZIENDA,'C7_DATO1' FROM MONDOEDP.I090_ENTI;
INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA,TIPO)  SELECT AZIENDA,'C7_DATO2' FROM MONDOEDP.I090_ENTI;
INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA,TIPO)  SELECT AZIENDA,'C7_DATO3' FROM MONDOEDP.I090_ENTI;
INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA,TIPO)  SELECT AZIENDA,'C7_DATACONVENZIONALE' FROM MONDOEDP.I090_ENTI;

UPDATE MONDOEDP.I091_DATIENTE SET DATO =  (SELECT MAX(QUALIFICA) FROM T760_REGOLEINCENTIVI) WHERE AZIENDA = :AZIENDA AND TIPO = 'C7_DATO1';
UPDATE MONDOEDP.I091_DATIENTE SET DATO =  (SELECT MAX(REPARTO) FROM T760_REGOLEINCENTIVI) WHERE AZIENDA = :AZIENDA AND TIPO = 'C7_DATO2';
UPDATE MONDOEDP.I091_DATIENTE SET DATO =  (SELECT MAX(LIVELLO) FROM T760_REGOLEINCENTIVI) WHERE AZIENDA = :AZIENDA AND TIPO = 'C7_DATO3';

UPDATE T190_INTERFACCIAPAGHE SET VOCE_PAGHE = (SELECT MAX(VOCEPAGHE) FROM T760_REGOLEINCENTIVI) WHERE CODINTERNO = 240;

ALTER TABLE P447_CEDOLINOPARK ADD CHIUSO VARCHAR2(1) DEFAULT 'N';
ALTER TABLE P447_CEDOLINOPARK ADD DATA_RIFERIMENTO DATE DEFAULT LAST_DAY(TRUNC(SYSDATE));
ALTER TABLE P448_CEDOLINOPARKVOCI ADD ORIGINE VARCHAR2(1);


