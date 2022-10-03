update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.9',PATCHDB = 5 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

ALTER TABLE T750_PROGETTI_RENDICONTO ADD CUP VARCHAR2(15);
comment on column T750_PROGETTI_RENDICONTO.CUP is 'Codice unico del progetto di investimento pubblico';

alter table T926_STAMPESCHEDULATE add ORDINE number(4);