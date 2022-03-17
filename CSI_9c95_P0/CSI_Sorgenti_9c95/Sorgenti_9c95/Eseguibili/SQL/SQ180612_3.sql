update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.8',PATCHDB = 3 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

create sequence T275_ID minvalue 1 maxvalue 999999999999999999999999999 start with 1 increment by 1 nocache;

alter table T275_CAUPRESENZE add ID number(8);

declare
  cursor c1 is select CODICE from T275_CAUPRESENZE where ID is null order by 1;
begin
  for t1 in c1 loop
    update T275_CAUPRESENZE
    set ID = T275_ID.nextval
    where CODICE = t1.CODICE;
  end loop;
  commit;
end;  
/

alter table T275_CAUPRESENZE add constraint T275_UQ unique (ID) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T235_CAUPRESENZE_PARSTO (
  ID number(8),
  DECORRENZA date, 
  DECORRENZA_FINE date,
  DESCRIZIONE varchar2(80)
) 
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T235_CAUPRESENZE_PARSTO add constraint T235_PK primary key (ID,DECORRENZA) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T235_CAUPRESENZE_PARSTO add constraint T235_FK_T275 foreign key (ID) references T275_CAUPRESENZE (ID) on delete cascade;
create index T235_CDF on T235_CAUPRESENZE_PARSTO (ID,DECORRENZA,DECORRENZA_FINE) tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column T235_CAUPRESENZE_PARSTO.ID is 'T275.ID';
comment on column T235_CAUPRESENZE_PARSTO.DESCRIZIONE is 'Descrizione della singola storicizzazione per uso interno';

insert into T235_CAUPRESENZE_PARSTO (ID,DECORRENZA,DECORRENZA_FINE,DESCRIZIONE)
select ID,to_date('01011900','ddmmyyyy'),to_date('31123999','ddmmyyyy'),'parametri originali'
from T275_CAUPRESENZE;

update T265_CAUASSENZE set CODCAU3 = null where CODCAU3 = CODICE;
	
update T020_ORARI set XPARAM = XPARAM||'<v9c82_z148>' where XPARAM not like '%<v9c82_z148>%' and exists (select 'x' from T350_REGREPERIB where DETRAZ_MENSA = 'S');
	
alter table T021_FASCEORARI modify DISAGIO_SERALE varchar2(5) default null;
comment on column T021_FASCEORARI.DISAGIO_SERALE is 'Ore massime riconoscibili come disagio serale ai fini dell''indennità di funzione, applicando la maggiorazione indicata in CSI005.MAGG_DISAGIO_SERALE';
update T021_FASCEORARI set DISAGIO_SERALE = decode(DISAGIO_SERALE,'N',null,'S','06.00',DISAGIO_SERALE);

alter table T020_ORARI add MAXSCOSTR varchar2(5);
comment on column T020_ORARI.MAXSCOSTR is 'Limite massimo di eccedenza giornaliera consentita oltre la soglia';

alter table T670_REGOLEBUONI modify ASSENZA varchar2(2000);
comment on column T670_REGOLEBUONI.ASSENZA is 'Assenze tollerate completamente';

alter table T670_REGOLEBUONI add ASSENZE_TOLL_PERC varchar2(2000);
comment on column T670_REGOLEBUONI.ASSENZE_TOLL_PERC is 'Assenze tollerate in percenutale indicata in PERC_TOLL_ASSENZE';
alter table T670_REGOLEBUONI add PERC_TOLL_ASSENZE number(4,2);
comment on column T670_REGOLEBUONI.PERC_TOLL_ASSENZE is 'Percentuale di tolleranza delle assenze specificate in ASSENZE_TOLL_PERC';

alter table T670_REGOLEBUONI add OREMINIME_SECONDOBUONO varchar2(5);
comment on column T670_REGOLEBUONI.OREMINIME_SECONDOBUONO is 'Ore minime per la maturazione del secondo buono';

alter table T670_REGOLEBUONI add DA3 varchar2(5);
alter table T670_REGOLEBUONI add A3 varchar2(5);
alter table T670_REGOLEBUONI add OREMINIME_FASCIA3 varchar2(5);
comment on column T670_REGOLEBUONI.DA3 is 'Inizio terza fascia';
comment on column T670_REGOLEBUONI.A3 is 'Fine terza fascia';
comment on column T670_REGOLEBUONI.OREMINIME_FASCIA3 is 'Ore minime da rendere nella terza fascia';

create table CSI008_BUONIGIORNALIERI (
  progressivo   NUMBER(8) not null,
  data          DATE not null,
  buonipasto    NUMBER(1),
  ticket        NUMBER(1)
)
  tablespace LAVORO
  storage (initial 256K next 256K pctincrease 0);

alter table CSI008_BUONIGIORNALIERI
  add constraint CSI008_PK primary key (PROGRESSIVO, DATA)
  using index tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);

alter table T235_CAUPRESENZE_PARSTO add CAUSCOMP_DEBITOGG varchar2(5);
comment on column T235_CAUPRESENZE_PARSTO.CAUSCOMP_DEBITOGG is 'T275.CODICE di una causale inclusa nelle ore normali, su cui riepilogare le ore rese con la causale corrente che mancano per raggiungere il debito gg';
comment on column T275_CAUPRESENZE.CAUSCOMP_DEBITOGG is 'Obsoleto - rimpiazzato da T235.CAUSCOMP_DEBITOGG';
update T235_CAUPRESENZE_PARSTO T235 set CAUSCOMP_DEBITOGG = (select CAUSCOMP_DEBITOGG from T275_CAUPRESENZE where ID = T235.ID) where CAUSCOMP_DEBITOGG is null;

