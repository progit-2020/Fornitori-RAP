update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.8',PATCHDB = 1 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);
  
alter table T020_ORARI add FASCIA_NOTTFEST_COMPLETA varchar2(1) default 'N';
comment on column T020_ORARI.FASCIA_NOTTFEST_COMPLETA is 'S=la fascia notturna viene considerata festiva se lo spezzone di uscita è successivo ad un giorno festivo, o lo spezzone di entrata precede un giorno festivo';

--Priorità di chiamata in Reperibilità
--INIZIO
create table T381_PIANIF_PRIORITACHIAMATA
(
  PROGRESSIVO          NUMBER(38) not null,
  DATA                 DATE not null,
  PRIORITA             NUMBER(1) not null
)
tablespace LAVORO
storage  (initial 256K next 256K pctincrease 0);

comment on column T381_PIANIF_PRIORITACHIAMATA.PROGRESSIVO is 'Progressivo dell''anagrafico a cui si riferisce l''informazione';
comment on column T381_PIANIF_PRIORITACHIAMATA.DATA is 'Data da cui far partire il ciclo di priorità di chiamata';
comment on column T381_PIANIF_PRIORITACHIAMATA.PRIORITA is 'Numero 1..3 di priorità di chiamata da cui partire per sviluppare il ciclo di assegnazione';

alter table T381_PIANIF_PRIORITACHIAMATA
  add constraint T381_PK primary key (PROGRESSIVO, DATA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
   --Priorità di chiamata in Reperibilità
--FINE
  
comment on column T230_CAUASSENZE_PARSTO.CAUSALE_FRUIZORE is 'Causale da inserire al posto della corrente se fruizione oraria';
comment on column T230_CAUASSENZE_PARSTO.CAUSALE_HMASSENZA is 'Causale da inserire a giornata intera quando la somma delle fruizioni orarie raggiunge il valore indicato in HMASSENZA';

delete from T432_DATALAVORO where upper(UTENTE) in 
(select upper(NOME_UTENTE) from I060_LOGIN_DIPENDENTE where AZIENDA = :AZIENDA
 minus
 select upper(UTENTE) from I070_UTENTI where AZIENDA = :AZIENDA);

--Indennità di funzione
--INIZIO
create sequence CSI004_ID
minvalue 1 maxvalue 999999999999999999999999999
start with 1 increment by 1 nocache;

create table CSI004_INDFUNZIONE (
  CODICE varchar2(20), --(I,IP,E,SA,I80,IP80,E80,S80,IPPP,EPPP)
  CONTRATTO varchar2(5),
  DECORRENZA date,
  DECORRENZA_FINE date,
  ID number(38)
) tablespace LAVORO
storage (initial 256K next 256K pctincrease 0);

alter table CSI004_INDFUNZIONE 
  add constraint CSI004_PK primary key (CODICE,CONTRATTO,DECORRENZA) 
  using index tablespace INDICI 
  storage (initial 256K next 256K pctincrease 0);
alter table CSI004_INDFUNZIONE 
  add constraint CSI004_UQ unique (ID) 
  using index tablespace INDICI 
  storage (initial 256K next 256K pctincrease 0);
alter table CSI004_INDFUNZIONE
  add constraint T200_FK_CSI004 foreign key (CONTRATTO)
  references T200_CONTRATTI (CODICE);

comment on column CSI004_INDFUNZIONE.CODICE is 'Tipi di indennità di funzione: I,IP,E,SA,I80,IP80,E80,S80,IPPP,EPPP. Codificato su dato anagrafico definito nei parametri aziendali.';
comment on column CSI004_INDFUNZIONE.CONTRATTO is 'Riferito a T200.CODICE';
comment on column CSI004_INDFUNZIONE.ID is 'Generato automaticamente da CSI004_ID.NEXTVAL';
  
create table CSI005_INDFUNZIONE_FASCE (
  ID number(8),
  FASCIA varchar2(5),
  IMPORTO number,
  MAGG_DISAGIO_SERALE number
) tablespace LAVORO
storage  (initial 256K next 256K pctincrease 0);

alter table CSI005_INDFUNZIONE_FASCE 
  add constraint CSI005_PK primary key (ID,FASCIA) 
  using index tablespace INDICI 
  storage (initial 256K next 256K pctincrease 0);
alter table CSI005_INDFUNZIONE_FASCE
  add constraint CSI004_FK_CSI005 foreign key (ID)
  references CSI004_INDFUNZIONE (ID) on delete cascade;
alter table CSI005_INDFUNZIONE_FASCE
  add constraint T210_FK_CSI005 foreign key (FASCIA)
  references T210_MAGGIORAZIONI (CODICE);
  
comment on column CSI005_INDFUNZIONE_FASCE.ID is 'Riferito a CSI004.ID';
comment on column CSI005_INDFUNZIONE_FASCE.FASCIA is 'Riferito a T210.CODICE';
comment on column CSI005_INDFUNZIONE_FASCE.IMPORTO is 'Importo orario dell''indennità';
comment on column CSI005_INDFUNZIONE_FASCE.MAGG_DISAGIO_SERALE is 'Importo da aggiungere all''importo in caso di disagio serale';

create sequence CSI006_ID
minvalue 1 maxvalue 999999999999999999999999999
start with 1 increment by 1 nocache;

create table CSI006_CART_INDFUNZIONE (
  ID number(38),
  PROGRESSIVO number(38),
  DATA date,
  TIMBRATURE varchar2(1000),
  GIUSTIFICATIVI varchar2(1000),  
  ORARIO varchar2(5),
  ORE_ASSENZA  varchar2(5),
  ORE_RESE varchar2(5)
) tablespace LAVORO
storage (initial 256K next 256K pctincrease 0);

comment on column CSI006_CART_INDFUNZIONE.ID is 'Generato automaticamente da CSI006_ID.NEXTVAL';
comment on column CSI006_CART_INDFUNZIONE.PROGRESSIVO is 'Anagrafico a cui si riferisce l''indennità di funzione';
comment on column CSI006_CART_INDFUNZIONE.PROGRESSIVO is 'Data a cui si riferisce l''indennità di funzione';

alter table CSI006_CART_INDFUNZIONE 
  add constraint CSI006_PK primary key (PROGRESSIVO,DATA) 
  using index tablespace INDICI 
  storage (initial 256K next 256K pctincrease 0);
alter table CSI006_CART_INDFUNZIONE 
  add constraint CSI006_UQ unique (ID) 
  using index tablespace INDICI 
  storage (initial 256K next 256K pctincrease 0);

create table CSI007_CART_INDFUNZIONE_DETT (
  ID number(38),
  TIPO_RECORD varchar2(1),
  FASCIA varchar2(5),
  ORE varchar2(5),
  DISAGIO_SERALE varchar2(5),
  INDFUNZIONE varchar2(20)
) tablespace LAVORO
storage (initial 256K next 256K pctincrease 0);

comment on column CSI007_CART_INDFUNZIONE_DETT.ID is 'Riferito a CSI006.ID';
comment on column CSI007_CART_INDFUNZIONE_DETT.TIPO_RECORD is 'A=Automatico, M=Manuale';
comment on column CSI007_CART_INDFUNZIONE_DETT.FASCIA is 'Riferito a T210.CODICE';
comment on column CSI007_CART_INDFUNZIONE_DETT.ORE is 'Ore attribuite alla FASCIA e INDFUNZIONE';
comment on column CSI007_CART_INDFUNZIONE_DETT.DISAGIO_SERALE is 'Ore attribuite alla FASCIA e INDFUNZIONE che deveono essere maggiorate in base a CSI005.MAGG_DISAGIO_SERALE';
comment on column CSI007_CART_INDFUNZIONE_DETT.INDFUNZIONE is 'Riferito a CSI004.CODICE';

alter table CSI007_CART_INDFUNZIONE_DETT 
  add constraint CSI007_PK primary key (ID,TIPO_RECORD,FASCIA,INDFUNZIONE) 
  using index tablespace INDICI 
  storage (initial 256K next 256K pctincrease 0);
alter table CSI007_CART_INDFUNZIONE_DETT
  add constraint CSI006_FK_CSI007 foreign key (ID)
  references CSI006_CART_INDFUNZIONE (ID) on delete cascade;
alter table CSI007_CART_INDFUNZIONE_DETT
  add constraint T210_FK_CSI007 foreign key (FASCIA)
  references T210_MAGGIORAZIONI (CODICE);

alter table T021_FASCEORARI add DISAGIO_SERALE varchar2(1) default 'N';
comment on column T021_FASCEORARI.DISAGIO_SERALE is 'S=il turno è riconosciuto come disagio serale ai fini dell''indennità di funzione, applicando la maggiorazione indicata in CSI005.MAGG_DISAGIO_SERALE';

alter table T180_DATIBLOCCATI modify RIEPILOGO varchar2(6);
--Indennità di funzione
--FINE
