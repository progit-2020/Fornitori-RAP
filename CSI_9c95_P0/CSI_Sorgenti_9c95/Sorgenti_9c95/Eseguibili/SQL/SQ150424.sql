update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.5',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);
	
update T082_PAR_PIANIFORARI
   set ord_vis = 'N'
 where trim(ord_vis) = 'C';
alter table T082_PAR_PIANIFORARI modify ord_vis VARCHAR2(20);
alter table T082_PAR_PIANIFORARI modify ord_vis default 'N';
comment on column T082_PAR_PIANIFORARI.ord_vis
  is 'N=Cognome, S=Operatore, T=Turno di partenza, P=Turno pianificato, O=Orario pianificato';

update T082_PAR_PIANIFORARI
   set ord_stampa = 'N'
 where trim(ord_stampa) = 'C';  
alter table T082_PAR_PIANIFORARI modify ord_stampa VARCHAR2(20);
alter table T082_PAR_PIANIFORARI modify ord_stampa default 'N';
comment on column T082_PAR_PIANIFORARI.ord_stampa
  is 'N=Cognome, S=Squadra/Operatore, T=Turno di partenza, P=Turno pianificato, O=Orario pianificato';

alter table m024_categ_dati_liberi modify min_fase_visibile default -1;
alter table m024_categ_dati_liberi modify max_fase_visibile default 9;

alter table m024_categ_dati_liberi modify min_fase_modifica default -1;
alter table m024_categ_dati_liberi modify max_fase_modifica default 0;

update m024_categ_dati_liberi set min_fase_visibile = nvl(min_fase_visibile,-1);
update m024_categ_dati_liberi set max_fase_visibile = nvl(max_fase_visibile,9);
update m024_categ_dati_liberi set min_fase_modifica = nvl(min_fase_modifica,-1);
update m024_categ_dati_liberi set max_fase_modifica = nvl(max_fase_modifica,0);

comment on column m024_categ_dati_liberi.min_fase_visibile is 'Fase a partire dalla quale la categoria di dati liberi è visibile. -1=visibile in inserimento richiesta, 0=visibile in richiesta esistente, >0=fasi associate ai livelli di autorizzazione';
comment on column m024_categ_dati_liberi.max_fase_visibile is 'Ultima fase in cui la categoria di dati liberi è visibile. -1=visibile in inserimento richiesta, 0=visibile in richiesta esistente, >0=fasi associate ai livelli di autorizzazione';
comment on column m024_categ_dati_liberi.min_fase_modifica is 'Fase a partire dalla quale la categoria di dati liberi è modificabile. -1=visibile in inserimento richiesta, 0=visibile in richiesta esistente, >0=fasi associate ai livelli di autorizzazione';
comment on column m024_categ_dati_liberi.max_fase_modifica is 'Ultima fase in cui la categoria di dati liberi è modificabile. -1=visibile in inserimento richiesta, 0=visibile in richiesta esistente, >0=fasi associate ai livelli di autorizzazione';
comment on column mondoedp.i096_livelli_iter_aut.fase is 'Numero indicante la fase applicativa a cui corrisponde il livello. Significativo solo per gli Iter delle Missioni e dello Straordinario mensile';

ALTER TABLE T750_PROGETTI_RENDICONTO ADD (REPORTING_PERIOD VARCHAR2(5), PARTNER_NUMBER VARCHAR2(5), NOMINATIVO_RESP VARCHAR2(61));

comment on column T750_PROGETTI_RENDICONTO.REPORTING_PERIOD is 'Reporting period del progetto';
comment on column T750_PROGETTI_RENDICONTO.PARTNER_NUMBER is 'Partner number del progetto';
comment on column T750_PROGETTI_RENDICONTO.NOMINATIVO_RESP is 'Nominativo del responsabile del progetto';

create table T754_PROPRIETA_IND_RENDICONTO
(ID_T750          number(38)    not null, /*T750.id*/
 PROGRESSIVO      number(8)     not null,
 SERVIZIO         varchar2(50),
 FUNZIONE         varchar2(50))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T754_PROPRIETA_IND_RENDICONTO.ID_T750 is 'T750.id';
comment on column T754_PROPRIETA_IND_RENDICONTO.PROGRESSIVO is 'Progressivo del dipendente';
comment on column T754_PROPRIETA_IND_RENDICONTO.SERVIZIO is 'Servizio del dipendente per il progetto';
comment on column T754_PROPRIETA_IND_RENDICONTO.FUNZIONE is 'Funzione del dipendente per il progetto';

alter table T754_PROPRIETA_IND_RENDICONTO add constraint T754_PK primary key (ID_T750,PROGRESSIVO) using index
tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T754_PROPRIETA_IND_RENDICONTO 
add constraint T754_FK_T750 foreign key (ID_T750) 
references T750_PROGETTI_RENDICONTO (ID) on delete cascade;

update MONDOEDP.I073_FILTROFUNZIONI
set   TAG = 100001, FUNZIONE = 'OpenAc01FProgettiRendiProj'
where TAG = 147 and FUNZIONE = 'OpenA155FProgettiRendiProj';
update MONDOEDP.I073_FILTROFUNZIONI
set   TAG = 100002, FUNZIONE = 'OpenAc02FLimitiRendiProj'
where TAG = 148 and FUNZIONE = 'OpenA156FLimitiRendiProj';
update MONDOEDP.I073_FILTROFUNZIONI
set   TAG = 100401, FUNZIONE = 'OpenWc01RichiestaRendiProj'
where TAG = 447 and FUNZIONE = 'OpenW039RichiestaRendiProj';
update MONDOEDP.I073_FILTROFUNZIONI
set   TAG = 100402, FUNZIONE = 'OpenWc01RichiestaRendiProj'
where TAG = 448 and FUNZIONE = 'OpenW039RichiestaRendiProj';

comment on column T040_GIUSTIFICATIVI.stampa
  is 'A=inseriti dal processo di autogiustificazione, B=giustificativo automatico abbattimento banca ore, 0=Inserimento automatico maternità facoltativa nei non lavorativi della successione:Facoltativa-Ferie-Facoltativa';
