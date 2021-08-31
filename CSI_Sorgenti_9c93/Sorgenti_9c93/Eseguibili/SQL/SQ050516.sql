UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '6.0.3' WHERE AZIENDA = :AZIENDA;

ALTER TABLE T025_CONTMENSILI ADD TIPOLIMITECOMPP VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T070_SCHEDARIEPIL ADD FESTIVINTERA_VAR NUMBER;
ALTER TABLE T070_SCHEDARIEPIL ADD FESTIVRIDOTTA_VAR NUMBER;
ALTER TABLE T070_SCHEDARIEPIL ADD INDTURNONUM_VAR NUMBER(2,0);
ALTER TABLE T070_SCHEDARIEPIL ADD INDTURNOORE_VAR VARCHAR2(6);

ALTER TABLE P193_VOCIVARIABILIINPUT ADD DATA_REGISTRAZIONE DATE;
comment on column P193_VOCIVARIABILIINPUT.DATA_REGISTRAZIONE
  is 'Data e ora di importazione voce';

alter table M011_TIPOMISSIONE DROP CONSTRAINT PK_M011;
alter table M011_TIPOMISSIONE
  add constraint M011_PK primary key (CODICE)
  using index  tablespace INDICI pctfree 10 initrans 2 maxtrans 255 storage
  (initial 16K next 16K minextents 1 pctincrease 0);

alter table M021_TIPIINDENNITAKM drop constraint PK_M021;
alter table M021_TIPIINDENNITAKM 
 add constraint M021_PK primary key (CODICE, DECORRENZA)
  using index  tablespace INDICI pctfree 10 initrans 2 maxtrans 255 storage
  (initial 16K next 16K minextents 1 pctincrease 0);

alter table M049_TIPOPAGAMENTO drop constraint PK_M049;
alter table M049_TIPOPAGAMENTO
  add constraint M049_PK primary key (CODICE)
  using index  tablespace INDICI pctfree 10 initrans 2 maxtrans 255 storage
  (initial 16K next 16K minextents 1 pctincrease 0);

alter table M051_DETTAGLIORIMBORSO drop constraint PK_M051;
alter table M051_DETTAGLIORIMBORSO
  add constraint M051_PK primary key (PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA, CODICERIMBORSOSPESE, DATARIMBORSO, PROGRIMBORSO)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255 storage
  (initial 16K next 256K minextents 1 pctincrease 0);

alter table M052_INDENNITAKM drop constraint PK_M052;
alter table M052_INDENNITAKM
  add constraint M052_PK primary key (PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA, CODICEINDENNITAKM)
  using index tablespace INDICI pctfree 10 initrans 2 maxtrans 255 storage
  (initial 16K next 256K minextents 1 pctincrease 0);

drop index SG506_IDX;
create unique index SG506_IDX on SG506_PIANTADISTRIBUZIONE (ID_PIANTA,ID_PADRE,LIVELLO,NOME_CAMPO,VALORE_CAMPO)
  tablespace INDICI pctfree 10 initrans 2 maxtrans 255 storage
  (initial 10K next 256K minextents 1 pctincrease 0);

alter table SG500_DATILIBERI modify INIZIOVALID null;

alter table SG508_STAMPAPIANTA modify ORDINAMENTO null;
update SG508_STAMPAPIANTA set ORDINAMENTO = NULL;
alter table SG508_STAMPAPIANTA modify ORDINAMENTO varchar2(20) default null;
update SG508_STAMPAPIANTA set ORDINAMENTO = 'COGNOME';

create table SG510_DATISTAMPAPIANTA
(
  CODICE_STAMPA     VARCHAR2(10) not null,
  NOME_DATO         VARCHAR2(20) not null,
  POSIZIONE_STAMPA  NUMBER(2) default 99 not null,
  DIMENSIONE_STAMPA NUMBER(3) default 20 not null
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 10K
    minextents 1
  );

alter table SG510_DATISTAMPAPIANTA
  add constraint SG510_PK primary key (CODICE_STAMPA, NOME_DATO)
  using index 
  tablespace LAVORO
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10K
    minextents 1
  );

declare 
  cursor c1 is select codice from sg508_stampapianta;
begin
  for t1 in c1 loop
    insert into sg510_datistampapianta values (t1.codice,'MATRICOLA',1,10);
    insert into sg510_datistampapianta values (t1.codice,'COGNOME',2,20);
    insert into sg510_datistampapianta values (t1.codice,'NOME',3,20);        
  end loop;
end;