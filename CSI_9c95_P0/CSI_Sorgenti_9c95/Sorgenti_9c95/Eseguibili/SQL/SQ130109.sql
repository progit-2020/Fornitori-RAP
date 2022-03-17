update MONDOEDP.I090_ENTI set VERSIONEDB = '8.7',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table T002_QUERYPERSONALIZZATE modify RIGA varchar2(2000);

alter table I101_TIMBIRREGOLARI modify FUNZIONE default 'P';

alter table MONDOEDP.I005_MSGINFO add PROFILO varchar2(30);
comment on column MONDOEDP.I005_MSGINFO.PROFILO is 'I061.PROFILO dell''utente connesso';

create sequence T722_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

create table T721_EVENTI_STR (
  CODICE varchar2(10),
  DESCRIZIONE varchar2(50)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T721_EVENTI_STR add constraint T721_PK primary key (CODICE) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T722_PERIODI_EVENTI_STR (
  CODICE varchar2(10),
  DAL date,
  AL date,
  ID number(8),
  ORE_TOTALI varchar2(7),
  ORE_INDIV  varchar2(7),
  CAUSALE_STR varchar2(5), -->T275
  CAUSALE_REC_DOMENICA varchar2(5) -->T265
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T722_PERIODI_EVENTI_STR add constraint T722_PK primary key (CODICE,DAL) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create unique index T722I_ID on T722_PERIODI_EVENTI_STR (ID) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T722_PERIODI_EVENTI_STR add constraint T722_FK_T721 foreign key (CODICE) references T721_EVENTI_STR (CODICE);

comment on column MONDOEDP.I005_MSGINFO.PROFILO is 'I061.PROFILO dell''utente connesso';

alter table T284_DESTINATARI add DATA_RICEZIONE date;
comment on column T284_DESTINATARI.DATA_LETTURA is 'Data di lettura del messaggio da parte del destinatario. Utilizzabile da parte del destinatario';
comment on column T284_DESTINATARI.DATA_RICEZIONE is 'Data di ricezione del messaggio da parte del destinatario. E'' visibile al mittente.';

alter table T265_CAUASSENZE add VARCOMP_FRUIZMMINTERI varchar2(1) default 'N';
comment on column T265_CAUASSENZE.VARCOMP_FRUIZMMINTERI is 'S=le comeptenze giornaliere vengono aumentate algebricamente se ci sono fruizioni su mesi interi diversi da 30gg';
alter table T265_CAUASSENZE add VARCOMP_FRUIZMMCONT number(3);
comment on column T265_CAUASSENZE.VARCOMP_FRUIZMMCONT is 'gg da aggiungere alle comeptenze se è verificata una fruizione di n mesi continuativi specificati in MMCONT_VARCOMP. Non si considerano le fruizioni del coniuge.';
alter table T265_CAUASSENZE add MMCONT_VARCOMP  number(3);
comment on column T265_CAUASSENZE.MMCONT_VARCOMP is 'num mesi che, se fruiti continuativamente, danno diritto alle competenze specificate in VARCOMP_FRUIZMMCONT';
alter table T265_CAUASSENZE add COMPINDIV_CONIUGE_ESISTENTE number(3);
comment on column T265_CAUASSENZE.COMPINDIV_CONIUGE_ESISTENTE is 'competenze individuali max se esiste il coniuge';

alter table M040_MISSIONI modify DESTINAZIONE varchar2(200);
UPDATE P605_770DATIINDIVIDUALI T SET T.PROGRESSIVO=T.PROGRESSIVO - 1000 WHERE T.PROGRESSIVO < 0;

-- Creazione nuova tabella Regole Sostituzioni

create table P228_SOSTITUZREGOLE
( cod_categ_convenz_tit       VARCHAR2(5) not null,
  cod_categ_convenz_sost      VARCHAR2(5) not null,
  cod_contratto               VARCHAR2(5) not null,
  cod_posizione_economica_rif VARCHAR2(5) not null,
  cod_voce_rif                VARCHAR2(5) not null,
  cod_voce_speciale_rif       VARCHAR2(5) not null,
  cod_voce_sost               VARCHAR2(5) not null,
  cod_voce_speciale_sost      VARCHAR2(5) not null,
  decorrenza                  DATE not null,
  decorrenza_fine             DATE,
  cod_voce_tit                VARCHAR2(5),
  cod_voce_speciale_tit       VARCHAR2(5),
  mese01_perc                 NUMBER not null,
  mese02_perc                 NUMBER not null,
  mese03_perc                 NUMBER not null,
  mese04_perc                 NUMBER not null,
  mese05_perc                 NUMBER not null,
  mese06_perc                 NUMBER not null,
  mese07_perc                 NUMBER not null,
  mese08_perc                 NUMBER not null,
  mese09_perc                 NUMBER not null,
  mese10_perc                 NUMBER not null,
  mese11_perc                 NUMBER not null,
  mese12_perc                 NUMBER not null)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column P228_SOSTITUZREGOLE.cod_categ_convenz_tit is 'Codice categoria convenzionato ENPAM del titolare';
comment on column P228_SOSTITUZREGOLE.cod_categ_convenz_sost is 'Codice categoria convenzionato ENPAM del sostituto';
comment on column P228_SOSTITUZREGOLE.cod_posizione_economica_rif is 'Codice posizione economica di riferimento per voce da ripartire';
comment on column P228_SOSTITUZREGOLE.cod_voce_rif is 'Codice voce di riferimento da ripartire';
comment on column P228_SOSTITUZREGOLE.cod_voce_speciale_rif is 'Codice voce speciale di riferimento da ripartire';
comment on column P228_SOSTITUZREGOLE.cod_voce_sost is 'Codice voce per sostituto';
comment on column P228_SOSTITUZREGOLE.cod_voce_speciale_sost is 'Codice voce speciale per sostituto';
comment on column P228_SOSTITUZREGOLE.cod_voce_tit is 'Codice voce per titolare; se assente coincide con quella del sostituto cambiata di segno';
comment on column P228_SOSTITUZREGOLE.cod_voce_speciale_tit is 'Codice voce speciale per titolare; se assente coincide con quella del sostituto cambiata di segno';
comment on column P228_SOSTITUZREGOLE.mese01_perc is 'Percentuale spettante al sostituto mese 01';
comment on column P228_SOSTITUZREGOLE.mese02_perc is 'Percentuale spettante al sostituto mese 02';
comment on column P228_SOSTITUZREGOLE.mese03_perc is 'Percentuale spettante al sostituto mese 03';
comment on column P228_SOSTITUZREGOLE.mese04_perc is 'Percentuale spettante al sostituto mese 04';
comment on column P228_SOSTITUZREGOLE.mese05_perc is 'Percentuale spettante al sostituto mese 05';
comment on column P228_SOSTITUZREGOLE.mese06_perc is 'Percentuale spettante al sostituto mese 06';
comment on column P228_SOSTITUZREGOLE.mese07_perc is 'Percentuale spettante al sostituto mese 07';
comment on column P228_SOSTITUZREGOLE.mese08_perc is 'Percentuale spettante al sostituto mese 08';
comment on column P228_SOSTITUZREGOLE.mese09_perc is 'Percentuale spettante al sostituto mese 09';
comment on column P228_SOSTITUZREGOLE.mese10_perc is 'Percentuale spettante al sostituto mese 10';
comment on column P228_SOSTITUZREGOLE.mese11_perc is 'Percentuale spettante al sostituto mese 11';
comment on column P228_SOSTITUZREGOLE.mese12_perc is 'Percentuale spettante al sostituto mese 12';

alter table P228_SOSTITUZREGOLE
  add constraint P228_PK primary key (COD_CATEG_CONVENZ_TIT, COD_CATEG_CONVENZ_SOST, COD_CONTRATTO, COD_POSIZIONE_ECONOMICA_RIF, COD_VOCE_RIF, COD_VOCE_SPECIALE_RIF, COD_VOCE_SOST, COD_VOCE_SPECIALE_SOST, DECORRENZA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

-- Creazione nuova tabella Sostituzioni
create table P462_SOSTITUZ
( progressivo_tit  NUMBER not null,
  progressivo_sost NUMBER not null,
  data_sost_da     DATE not null,
  data_sost_a      DATE)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column P462_SOSTITUZ.progressivo_tit is 'Progressivo del titolare';
comment on column P462_SOSTITUZ.progressivo_sost is 'Progressivo del sostituto';
comment on column P462_SOSTITUZ.data_sost_da is 'Data inizio sostituzione';
comment on column P462_SOSTITUZ.data_sost_a is 'Data fine sostituzione';

alter table P462_SOSTITUZ
  add constraint P462_PK primary key (PROGRESSIVO_TIT, PROGRESSIVO_SOST, DATA_SOST_DA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table P462_SOSTITUZ
  add constraint P462_FK_T030_SOST foreign key (PROGRESSIVO_SOST) references T030_ANAGRAFICO (PROGRESSIVO);
alter table P462_SOSTITUZ
  add constraint P462_FK_T030_TIT foreign key (PROGRESSIVO_TIT) references T030_ANAGRAFICO (PROGRESSIVO);

ALTER TABLE T151_ASSENTEISMO ADD ESPORTA_XML VARCHAR2(1) DEFAULT 'N';
comment on column T151_ASSENTEISMO.ESPORTA_XML  is 'Esporta in formato xml: Si/No';

-- Creazione nuova tabella Voci Rapporti Precedenti
create table P269_RAPPORTIPRECEDENTIVOCI
( progressivo       NUMBER not null,
  data_cedolino_rp  DATE not null,
  cod_contratto     VARCHAR2(5) not null,
  cod_voce          VARCHAR2(5) not null,
  cod_voce_speciale VARCHAR2(5) not null,
  datobase          NUMBER default 0 not null,
  importo           NUMBER default 0 not null)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column P269_RAPPORTIPRECEDENTIVOCI.datobase is 'Imponibile della voce di ritenuta maturato nel rapporto precedente';
comment on column P269_RAPPORTIPRECEDENTIVOCI.importo is 'Importo della voce di ritenuta trattenuto nel rapporto precedente';

alter table P269_RAPPORTIPRECEDENTIVOCI
  add constraint P269_PK primary key (PROGRESSIVO, DATA_CEDOLINO_RP, COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table P269_RAPPORTIPRECEDENTIVOCI
  add constraint P269_FK_P268 foreign key (PROGRESSIVO, DATA_CEDOLINO_RP)
  references P268_RAPPORTIPRECEDENTI (PROGRESSIVO, DATA_CEDOLINO_RP) on delete cascade;

alter table MONDOEDP.I090_ENTI add gruppo_badge VARCHAR2(1);
comment on column MONDOEDP.I090_ENTI.gruppo_badge
  is 'Valore del raggruppamento di piu'''' aziende che condividono la numerazione dei badge';

-- Nuove colonne su configurazione dati aziendali per data versamento tributi IRPEF
alter table P500_CUDSETUP add data_vers_irpef01 date;
alter table P500_CUDSETUP add data_vers_irpef02 date;
alter table P500_CUDSETUP add data_vers_irpef03 date;
alter table P500_CUDSETUP add data_vers_irpef04 date;
alter table P500_CUDSETUP add data_vers_irpef05 date;
alter table P500_CUDSETUP add data_vers_irpef06 date;
alter table P500_CUDSETUP add data_vers_irpef07 date;
alter table P500_CUDSETUP add data_vers_irpef08 date;
alter table P500_CUDSETUP add data_vers_irpef09 date;
alter table P500_CUDSETUP add data_vers_irpef10 date;
alter table P500_CUDSETUP add data_vers_irpef11 date;
alter table P500_CUDSETUP add data_vers_irpef12 date;

comment on column P500_CUDSETUP.data_vers_irpef01
  is 'Data versamento tributi IRPEF mese 01';
comment on column P500_CUDSETUP.data_vers_irpef02
  is 'Data versamento tributi IRPEF mese 02';
comment on column P500_CUDSETUP.data_vers_irpef03
  is 'Data versamento tributi IRPEF mese 03';
comment on column P500_CUDSETUP.data_vers_irpef04
  is 'Data versamento tributi IRPEF mese 04';
comment on column P500_CUDSETUP.data_vers_irpef05
  is 'Data versamento tributi IRPEF mese 05';
comment on column P500_CUDSETUP.data_vers_irpef06
  is 'Data versamento tributi IRPEF mese 06';
comment on column P500_CUDSETUP.data_vers_irpef07
  is 'Data versamento tributi IRPEF mese 07';
comment on column P500_CUDSETUP.data_vers_irpef08
  is 'Data versamento tributi IRPEF mese 08';
comment on column P500_CUDSETUP.data_vers_irpef09
  is 'Data versamento tributi IRPEF mese 09';
comment on column P500_CUDSETUP.data_vers_irpef10
  is 'Data versamento tributi IRPEF mese 10';
comment on column P500_CUDSETUP.data_vers_irpef11
  is 'Data versamento tributi IRPEF mese 11';
comment on column P500_CUDSETUP.data_vers_irpef12
  is 'Data versamento tributi IRPEF mese 12';


alter table P602_770REGOLE modify regola_calcolo_automatica VARCHAR2(4000);
alter table P602_770REGOLE modify regola_calcolo_manuale VARCHAR2(4000);
