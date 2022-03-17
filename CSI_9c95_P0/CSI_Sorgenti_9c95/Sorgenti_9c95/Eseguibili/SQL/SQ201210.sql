update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.9',PATCHDB = 1 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table T230_CAUASSENZE_PARSTO add RENDICONTA_PROGETTI varchar2(1) default 'N';
comment on column T230_CAUASSENZE_PARSTO.RENDICONTA_PROGETTI is 'S=Le ore fruite sono da considerare ai fini della rendicontazione progetti';
alter table T235_CAUPRESENZE_PARSTO add RENDICONTA_PROGETTI varchar2(1) default 'N';
comment on column T235_CAUPRESENZE_PARSTO.RENDICONTA_PROGETTI is 'S=Le ore fruite sono da considerare ai fini della rendicontazione progetti';

comment on column T750_PROGETTI_RENDICONTO.CAUASSPRES_INCLUSE is 'obsoleto';

update T230_CAUASSENZE_PARSTO T230
set RENDICONTA_PROGETTI = 'S'
where exists (select 1 
              from T265_CAUASSENZE T265 
              where T265.ID = T230.ID 
              and instr(','||(select max(CAUASSPRES_INCLUSE) from T750_PROGETTI_RENDICONTO where trunc(SYSDATE) between DECORRENZA and DECORRENZA_FINE)||',',','||T265.CODICE||',') > 0);

update T235_CAUPRESENZE_PARSTO T235
set RENDICONTA_PROGETTI = 'S'
where exists (select 1 
              from T275_CAUPRESENZE T275 
              where T275.ID = T235.ID 
              and instr(','||(select max(CAUASSPRES_INCLUSE) from T750_PROGETTI_RENDICONTO where trunc(SYSDATE) between DECORRENZA and DECORRENZA_FINE)||',',','||T275.CODICE||',') > 0);

insert into T001_PARAMETRIFUNZIONI
select PROG, NOME, VALORE, NULL, -1
from T001_PARAMETRIFUNZIONI 
where PROG = 'Ac04'
and NOME = 'PartnerName'
and UTENTE = (select UTENTE from MONDOEDP.I070_UTENTI where PROGRESSIVO = 0);