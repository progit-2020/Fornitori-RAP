update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.6',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);
 
create table CSI010_FESTIVITA_PARTICOLARI
(
  progressivo       NUMBER default -1 not null,
  data_festivita    DATE not null,
  tipo_festivita    VARCHAR2(1) not null,
  filtro_anagra     VARCHAR2(2000) default '*' not null,
  tipo_record       VARCHAR2(1) not null,
  condizione_applic VARCHAR2(1) default 'A' not null,
  inizio_scelta     DATE,
  fine_scelta       DATE,
  flag_scelta       VARCHAR2(1) default 'S' not null,
  scelte_possibili  VARCHAR2(50),
  scelta_effettuata VARCHAR2(1),
  data_scelta       DATE,
  comp_noscelta     VARCHAR2(1) not null,
  caus_insert       VARCHAR2(5),
  caus_incomp       VARCHAR2(2000),
  caus_sostit       VARCHAR2(2000),
  comp_caussost     VARCHAR2(1)
)
tablespace LAVORO storage  (initial 256K next 256K pctincrease 0);

comment on column CSI010_FESTIVITA_PARTICOLARI.progressivo
  is 'Progressivo del dipendente -1 per dati generali';
comment on column CSI010_FESTIVITA_PARTICOLARI.tipo_festivita
  is 'Valori ammessi: A=Santo Patrono, B=Ex-festività, C=Festività in giorno di riposo';
comment on column CSI010_FESTIVITA_PARTICOLARI.filtro_anagra
  is 'Filtro anagrafico dei dipendenti che ne hanno diritto * = Tutti';
comment on column CSI010_FESTIVITA_PARTICOLARI.tipo_record
  is 'Tipo record: A=Automatico, M=Manuale';
comment on column CSI010_FESTIVITA_PARTICOLARI.condizione_applic
  is 'Condizioni di applicazione. Valori ammessi: A=Sabato e domenica/Riposo per turnista, B=Sabato e domenica per tutti, C=Solo se giorno lavorativo/Non riposo per turnista, S= Sempre senza restrizioni';
comment on column CSI010_FESTIVITA_PARTICOLARI.inizio_scelta
  is 'Data primo giorno dal quale è possibile effettuare la scelta';
comment on column CSI010_FESTIVITA_PARTICOLARI.fine_scelta
  is 'Data ultimo giorno in cui è possible effetuare la scelta';
comment on column CSI010_FESTIVITA_PARTICOLARI.flag_scelta
  is 'Valori ammessi: S=Prevista la scelta per il dipendente, N=Non prevista scelta, L=prevista scelta se non di riposo(causale o turno di riposo)';
comment on column CSI010_FESTIVITA_PARTICOLARI.scelte_possibili
  is 'Elenco valori ammessi (inserire separati dalla virgola): A=Fruizione, B=Pagamento, C=Aumenta competenza ferie';
comment on column CSI010_FESTIVITA_PARTICOLARI.scelta_effettuata
  is 'Sono ammessi valori compresi nell''''elenco del campo SCELTE_POSSIBILI';
comment on column CSI010_FESTIVITA_PARTICOLARI.data_scelta
  is 'Data registrazione ultima impostazione del valore del campo SCELTA_EFFETTUATA';
comment on column CSI010_FESTIVITA_PARTICOLARI.comp_noscelta
  is 'Comportamento in assenza di scelta. Valori ammessi: A=Fruizione, B=Pagamento, C=Aumenta competenza ferie, Z=Esclude il diritto';
comment on column CSI010_FESTIVITA_PARTICOLARI.caus_insert
  is 'Codice della causale da inserire come giustificativo di assenza a giornata intera';
comment on column CSI010_FESTIVITA_PARTICOLARI.caus_incomp
  is 'Elenco delle causali non fruibili nel giorno';
comment on column CSI010_FESTIVITA_PARTICOLARI.caus_sostit
  is 'Elenco delle causali a giornata intera che sostituiscono la causale della festività, * = Tutti i codici ad esclusione di quelli indicati nel campo CAUS_INCOMP';
comment on column CSI010_FESTIVITA_PARTICOLARI.comp_caussost
  is 'comportamento da tenere in seguito alla causale che ha sostituito la fruizione. B=Pagamento; C=Aumenta competenza ferie; Z=Esclude il diritto';

alter table CSI010_FESTIVITA_PARTICOLARI
  add constraint CSI010_PK primary key (PROGRESSIVO, DATA_FESTIVITA, TIPO_FESTIVITA, FILTRO_ANAGRA, TIPO_RECORD) using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.VISIBILE_DAL is 'Obsoleto';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.VISIBILE_AL is 'Obsoleto';
alter table MONDOEDP.I096_LIVELLI_ITER_AUT drop column VISIBILE_DAL;
alter table MONDOEDP.I096_LIVELLI_ITER_AUT drop column VISIBILE_AL;
alter table T860_ITER_STAMPACARTELLINI add DATA_PDF date;
comment on column T860_ITER_STAMPACARTELLINI.DATA_PDF is 'Data di produzione del file pdf del cartellino';

alter table T860_ITER_STAMPACARTELLINI add ESISTE_PDF varchar2(1) default 'N';
comment on column T860_ITER_STAMPACARTELLINI.ESISTE_PDF is 'S = il file pdf del cartellino è stato salvato, N = il file pdf del cartellino non è ancora stato salvato.';

alter table T750_PROGETTI_RENDICONTO modify CODICE VARCHAR2(20);
