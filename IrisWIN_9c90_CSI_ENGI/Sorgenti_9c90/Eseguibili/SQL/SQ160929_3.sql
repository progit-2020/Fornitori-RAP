update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.7',PATCHDB = 3 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

create table CSI003_COD_RIMB_VIAGGIO
(cod_rimborso     VARCHAR2(5),
 rimborso_agenzia VARCHAR2(100))
tablespace LAVORO;

create sequence CSI_IMP_EXCEL_ID
minvalue 1 maxvalue 9999999999999999999999999999
start with 1 increment by 1 nocache;

alter table T670_REGOLEBUONI add ESTENDI_INTERVALLO_PMT varchar2(1);
comment on column T670_REGOLEBUONI.ESTENDI_INTERVALLO_PMT is 'S=la detrazione calcolata per la PMT altera lo spezzone del pomeriggio o del mattino';

