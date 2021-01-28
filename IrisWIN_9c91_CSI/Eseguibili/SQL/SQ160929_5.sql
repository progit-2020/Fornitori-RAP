update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.7',PATCHDB = 5 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);
  
alter table MONDOEDP.I070_UTENTI add T030_PROGRESSIVO number(8);
comment on column MONDOEDP.I070_UTENTI.T030_PROGRESSIVO is 'Progressivo del dipendente a cui è associato l''operatore';
