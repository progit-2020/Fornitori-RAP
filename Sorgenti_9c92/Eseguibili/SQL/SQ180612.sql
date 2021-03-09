update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.8',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

-- Inserimento interrogazione di servizio CA_Aspettative_Tab3
declare
  i integer;
begin
  select COUNT(*) into i from t002_querypersonalizzate t where t.nome = 'CA_Aspettative_Tab3';
  if not i > 0 then
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', -9, 'N', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', -4, 'CHKINTESTAZIONE(N)CHKNORITORNOACAPO(N)', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', -2, 'Stringa,Sostituzione', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', -1, '"2017","''Codice1'',''Codice2'',''CodiceN''"', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', 0, 'SELECT T430.QUALIFICAMINIST,T470.DESCRIZIONE,T030.SESSO,COUNT(*) NUMDIP', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', 1, '  FROM T030_ANAGRAFICO T030, T430_STORICO T430, T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T470_QUALIFICAMINIST T470', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', 2, 'WHERE T030.PROGRESSIVO = T430.PROGRESSIVO AND T030.PROGRESSIVO = T040.PROGRESSIVO', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', 3, '  AND T040.DATA = TO_DATE(''3112''||:AnnoElaborazione,''DDMMYYYY'') AND T040.TIPOGIUST = ''I''', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', 4, '  AND T040.DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', 5, '  AND T040.DATA BETWEEN T430.INIZIO AND NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY''))-1', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', 6, '  AND T430.QUALIFICAMINIST = T470.CODICE AND TO_DATE(''3112''||:AnnoElaborazione,''DDMMYYYY'') BETWEEN T470.DECORRENZA AND T470.DECORRENZA_FINE', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', 7, '  AND T265.CODICE = T040.CAUSALE ', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', 8, '  AND (T265.RAGGRSTAT = ''L'' or T265.CODICE in (:ElencoCausali))', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', 9, 'GROUP BY T430.QUALIFICAMINIST,T470.DESCRIZIONE,T030.SESSO', 'RILPRE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('CA_Aspettative_Tab3', 10, 'ORDER BY T430.QUALIFICAMINIST,T030.SESSO', 'RILPRE');
  end if;
end;
/

create sequence T265_ID minvalue 1 maxvalue 999999999999999999999999999 start with 1 increment by 1 nocache;

alter table T265_CAUASSENZE add ID number(8);

declare
  cursor c1 is select CODICE from T265_CAUASSENZE where ID is null order by 1;
begin
  for t1 in c1 loop
    update T265_CAUASSENZE
    set ID = T265_ID.nextval
    where CODICE = t1.CODICE;
  end loop;
  commit;
end;  
/

alter table T265_CAUASSENZE add constraint T265_UQ unique (ID) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T230_CAUASSENZE_PARSTO (
  ID number(8),
  DECORRENZA date, 
  DECORRENZA_FINE date,
  DESCRIZIONE varchar2(80),
  VALORGIOR varchar2(1) default 'D',
  VALORGIOR_COMP varchar2(1) default '-',
  VALORGIOR_ORE varchar2(5),
  VALORGIOR_ORECOMP varchar2(5),
  VALORGIOR_ORE_PROPPT varchar2(1) default 'N',
  CAUSALI_COMPATIBILI varchar2(2000),
  STATO_COMPATIBILITA varchar2(1) default 'D',
  HMASSENZA varchar2(5) ,
  HMASSENZA_PROPPT varchar2(1) default 'N',
  CAUSALI_CHECKCOMPETENZE varchar2(100)
) 
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T230_CAUASSENZE_PARSTO add constraint T230_PK primary key (ID,DECORRENZA) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T230_CAUASSENZE_PARSTO add constraint T230_FK_T265 foreign key (ID) references T265_CAUASSENZE (ID) on delete cascade;
create index T230_CDF on T230_CAUASSENZE_PARSTO (ID,DECORRENZA,DECORRENZA_FINE) tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column T230_CAUASSENZE_PARSTO.ID is 'T265.ID';
comment on column T230_CAUASSENZE_PARSTO.DESCRIZIONE is 'Descrizione della singola storicizzazione per uso interno';
comment on column T230_CAUASSENZE_PARSTO.VALORGIOR is 'Valorizzazione oraria in caso di fruizione a giornata intera/mezza: A=Monte ore sett./gg.lav., B=Ore teoriche dell''orario, C=Monte ore sett./6, D=Ore teoriche da anagrafico, E=Ore del debito giornaliero, F=Ore fissate';
comment on column T230_CAUASSENZE_PARSTO.VALORGIOR_COMP is 'Quantità da abbattere dalle competenze se fruizione a giornata intera/mezza: -=T230.VALORGIOR, altri valori come T230.VALORGIOR';
comment on column T230_CAUASSENZE_PARSTO.VALORGIOR_ORE is 'Valorizzazione oraria se furizione a giornata intera/mezza nel caso che VALORGIOR = F';
comment on column T230_CAUASSENZE_PARSTO.VALORGIOR_ORECOMP is 'Valorizzazione oraria se furizione a giornata intera/mezza nel caso che VALORGIOR_COMP = F';
comment on column T230_CAUASSENZE_PARSTO.VALORGIOR_ORE_PROPPT is 'S=la quantità oraria specificata in VALORGIOR_ORE/COMP viene proporzionata in base al part-time se attivato il proporzionamento delle competenze';
comment on column T230_CAUASSENZE_PARSTO.CAUSALI_COMPATIBILI is 'Elenco causali compatibili nello stesso giorno, in base al parametro STATO_COMPATIBILITA. null=nessuna causale';
comment on column T230_CAUASSENZE_PARSTO.STATO_COMPATIBILITA is 'D=Disattivo, C=Compatibile, I=Incompatibile';
comment on column T230_CAUASSENZE_PARSTO.CAUSALI_CHECKCOMPETENZE is 'Elenco di causali di cui controllare la disponibilità di competenza prima di eseguire l''inserimento  effettivo';
comment on column T230_CAUASSENZE_PARSTO.HMASSENZA is 'Numero di ore da considerare per considerare la fruizione di una giornata intera';
comment on column T230_CAUASSENZE_PARSTO.HMASSENZA_PROPPT is 'S=la quantità oraria specificata in HMASSENZA viene proporzionata in base al part-time se attivato il proporzionamento delle competenze';

insert into T230_CAUASSENZE_PARSTO (ID,DECORRENZA,DECORRENZA_FINE,DESCRIZIONE,VALORGIOR,HMASSENZA)
select ID,to_date('01011900','ddmmyyyy'),to_date('31123999','ddmmyyyy'),'parametri originali',VALORGIOR,to_char(HMASSENZA,'hh24.mi')
from T265_CAUASSENZE;

alter table T460_PARTTIME add HHGIORNALIERE number default 100;
update T460_PARTTIME set HHGIORNALIERE = ASSENZEHH where TIPO = 'O';
comment on column T460_PARTTIME.HHGIORNALIERE	is 'percentuale con cui proporzionare VALORGIOR_ORE, VALORGIOR_ORECOMP, HMASSENZA definiti su T230';

alter table T230_CAUASSENZE_PARSTO add CAUSALE_VISUALCOMPETENZE varchar2(5);
comment on column T230_CAUASSENZE_PARSTO.CAUSALE_VISUALCOMPETENZE is 'causale di cui visualizzare le competenze al posto di quelle della causale corrente (deve esistere in T230.CAUSALI__CHECKCOMPETENZE)';

alter table T230_CAUASSENZE_PARSTO add SCARICOPAGHE_FRUIZ_GG varchar2(1) default 'S';
comment on column T230_CAUASSENZE_PARSTO.SCARICOPAGHE_FRUIZ_GG is 'scarico paghe per le fruizioni a giornata/mezza giornata: S=abilitato, N=disabilitato';
alter table T230_CAUASSENZE_PARSTO add SCARICOPAGHE_FRUIZ_ORE varchar2(1) default 'S';
comment on column T230_CAUASSENZE_PARSTO.SCARICOPAGHE_FRUIZ_ORE is 'scarico paghe per le fruizioni orarie: S=abilitato, N=disabilitato';

alter table T230_CAUASSENZE_PARSTO add GGPARZ_FRUIZORE varchar2(1) default 'S';
comment on column T230_CAUASSENZE_PARSTO.GGPARZ_FRUIZORE is 'Significativo se competenze a giorni: S= la fruizione ad ore viene conteggiata come gg parziale, N=la fruizione ad ore viene conteggiata solo quando la somma raggiunge la giornata intera';

alter table T230_CAUASSENZE_PARSTO add CAUSALE_FRUIZORE varchar2(5);
comment on column T230_CAUASSENZE_PARSTO.CAUSALE_FRUIZORE is 'Causale da inserire al posto della corrente se fruizione oraria';
alter table T230_CAUASSENZE_PARSTO add CAUSALE_HMASSENZA varchar2(5);
comment on column T230_CAUASSENZE_PARSTO.CAUSALE_FRUIZORE is 'Causale da inserire a giornata intera quando la somma delle fruizioni orarie raggiunge il valore indicato in HMASSENZA';
alter table T230_CAUASSENZE_PARSTO add CHECK_SOLOCOMPETENZE varchar2(1) default 'N';
comment on column T230_CAUASSENZE_PARSTO.CHECK_SOLOCOMPETENZE is 'S=in fase di inserimento si verificano solo le competenze e si saltano tutte le altre regole di conteggio';

alter table T040_GIUSTIFICATIVI add RESTO_CUMULO_HMA number(8);
comment on column T040_GIUSTIFICATIVI.RESTO_CUMULO_HMA is 'minuti di resto derivanti dal cumulo delle fruizioni orarie in giornate intere, secondo il parametro T230.HMASSENZA';

comment on column T265_CAUASSENZE.VALORGIOR is 'Obsoleto - rimpiazzato da T230.VALORGIOR';
comment on column T265_CAUASSENZE.HMASSENZA is 'Obsoleto - rimpiazzato da T230.HMASSENZA';