update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.7',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table T680_BUONIMENSILI add NOTE varchar2(2000);

alter table MONDOEDP.I071_PERMESSI add WEB_NOTIFICA_ANOMALIE VARCHAR2(1) default 'N';
comment on column MONDOEDP.I071_PERMESSI.WEB_NOTIFICA_ANOMALIE
  is 'notifica della presenza di anomalie sul cartellino all''accesso di IrisWEB - N=No, I=Informativa, D=Dettagliata';
alter table T101_ANOMALIE add NUM_ANOMALIA number(3);
comment on column T101_ANOMALIE.NUM_ANOMALIA is 'Numero dell''anomalia riscontrata';
alter table T101_ANOMALIE add UTENTE varchar2(30);
comment on column T101_ANOMALIE.UTENTE is 'Utente che ha elaborato le anomalie. Deve valere W003 se devono essere considerate dalla notifica automatica in IrisWEB';

