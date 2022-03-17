update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.9',PATCHDB = 3 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table I101_TIMBIRREGOLARI modify RILEV varchar2(10);

alter table T280_MESSAGGIWEB modify TESTO varchar2(4000);
alter table MONDOEDP.I006_MSGDATI modify MSG varchar2(4000);

alter table T326_RICHIESTESTR_SPEZ add MOTIVAZIONE varchar2(5);
comment on column T326_RICHIESTESTR_SPEZ.MOTIVAZIONE is 'T106.CODICE della motivazione di richiesta con tipo = T325';

alter table T926_STAMPESCHEDULATE modify ROTTURA default null;

delete from MONDOEDP.I091_DATIENTE where TIPO like 'C22_PIANSERV%';

alter table T926_STAMPESCHEDULATE add SQL_AFTER varchar2(1000);
comment on column T926_STAMPESCHEDULATE.SQL_AFTER is 'script pl/sql da eseguire a fine elaborazione, prima dei comandi CMD_AFTER';

alter table T020_ORARI add ANOM_BLOCC_23LIV varchar2(1000);
comment on column T020_ORARI.ANOM_BLOCC_23LIV is 'Anomalie di 2-3 livello che devono risultare anomalia bloccante per l''orario corrente';

update T020_ORARI set ANOM_BLOCC_23LIV = replace(ANOM_BLOCC_23LIV,'A','');

update MONDOEDP.I073_FILTROFUNZIONI I073
set INIBIZIONE = (select INIBIZIONE from MONDOEDP.I073_FILTROFUNZIONI where TAG = 100 and AZIENDA = I073.AZIENDA and PROFILO = I073.PROFILO and APPLICAZIONE = I073.APPLICAZIONE)
where TAG in (82,83,84,85,86,87,88,90);

comment on column T265_CAUASSENZE.RAGGRSTAT is 'Raggruppamento statistica assenze: A=Ferie, B=Permessi retribuiti, C=Malattia, D=Sciopero, E=Assenze non retribuite, F=Legge 104/1992, G=Maternità, H=Formazione, I=Art.42 c.5 dlgs 151/2001, L=Aspettative Tab. 3, M=Congedi parentali Covid, Z=Nessuno';

alter table T020_ORARI add CAUSALI_ECCCOMP varchar2(20);
comment on column T020_ORARI.CAUSALI_ECCCOMP is 'Elenco delle causali di presenza in cui riepilogare l''eccedenza giornaliera compensabile';
