-- Nuove colonne per integrazione anagrafica
alter table MONDOEDP.IA110_DETTAGLIODATI add PROPRIETA varchar2(500);
alter table MONDOEDP.IA110_DETTAGLIODATI add TABELLA_DESC VARCHAR2(80);
comment on column MONDOEDP.IA110_DETTAGLIODATI.PROPRIETA is 'attributi del dato';
comment on column MONDOEDP.IA110_DETTAGLIODATI.TABELLA_DESC is 'nome della tabella che contiene le descrizioni';
-- Nuova sequenza per integrazione anagrafica
create sequence MONDOEDP.IA000_ID_LOG
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

alter table P284_IMPORTIRETR add IMPORTO NUMBER default 0 not null;
comment on column P284_IMPORTIRETR.IMPORTO
  is 'Importo della voce gia'' ridotto per Part-time';

update p042_entiirpef t set t.ritenuta_perc=1.4 where t.anno=2011 and t.tipo_addizionale='R' and t.cod_ente='08';

alter table T275_CAUPRESENZE add GIUST_DAA_TIMB varchar2(1) default 'N';
comment on column T275_CAUPRESENZE.GIUST_DAA_TIMB is 'S=il giustificativo viene considerato dai conteggi come una coppia di timbrature causalizzate';
alter table T265_CAUASSENZE add GIUST_DAA_TIMB varchar2(1) default 'N';
comment on column T265_CAUASSENZE.GIUST_DAA_TIMB is 'S=il giustificativo viene considerato dai conteggi come una coppia di timbrature causalizzate';

alter table T265_CAUASSENZE add DETREPERIB_TOTALE varchar2(1) default 'N';
comment on column T265_CAUASSENZE.DETREPERIB_TOTALE is 'S=la fruizione a gionata intera abbatte completamente il turno di reperibilità pianificato per quel giorno';
