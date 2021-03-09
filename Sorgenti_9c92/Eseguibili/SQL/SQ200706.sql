create table MONDOEDP.I190_MONITORSERVIZI
(
  id                  NUMBER(8),
  servizio            VARCHAR2(10) default 'B006' not null,
  intervallo_monitor  VARCHAR2(5) default '01.00',
  email_smtp_host     VARCHAR2(60),
  email_smtp_username VARCHAR2(60),
  email_smtp_password VARCHAR2(60),
  email_smtp_port     NUMBER(5) default 25,
  email_auth_type     VARCHAR2(20)
)
tablespace LAVORO;

comment on column MONDOEDP.I190_MONITORSERVIZI.id
  is 'I190_ID.nextval';
comment on column MONDOEDP.I190_MONITORSERVIZI.servizio
  is 'Nome del servizio da monitorare: B006=acquisizione automatica timbrature';
comment on column MONDOEDP.I190_MONITORSERVIZI.intervallo_monitor
  is 'Intervallo temporale ogni quanto effettuare il monitoraggio';

alter table MONDOEDP.I190_MONITORSERVIZI
  add constraint I190_PK primary key (SERVIZIO)
  using index 
  tablespace INDICI;
alter index MONDOEDP.I190_PK nologging;

alter table MONDOEDP.I190_MONITORSERVIZI
  add constraint I190_UQ unique (ID)
  using index 
  tablespace INDICI;
alter index MONDOEDP.I190_UQ nologging;

create table MONDOEDP.I191_MONITORSERVIZI_DB
(
  id                      NUMBER(8) not null,
  database_name           VARCHAR2(1000) not null,
  connessione_pwd         VARCHAR2(30),
  query_servizio_connesso VARCHAR2(1000),
  query_msg1              VARCHAR2(2000),
  query_msg2              VARCHAR2(2000),
  no_monitor_dalle        VARCHAR2(5),
  no_monitor_alle         VARCHAR2(5),
  msg_elaborazioni_gg     NUMBER(3) default 7,
  msg_elaborazioni_righe  NUMBER(8) default -1,
  email_mittente          VARCHAR2(1000),
  email_destinatari       VARCHAR2(1000),
  email_destinatari_cc    VARCHAR2(1000)
)
tablespace LAVORO;
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.id
  is 'I190.ID';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.database_name
  is 'Nome del database a cui connettersi per effettuare il monitoraggio del servizio';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.connessione_pwd
  is 'Password di connessione';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.query_servizio_connesso
  is 'query da eseguire per verificare se il servizio è connesso al database (per es: select * from MY_SESSIONS where upper(PROGRAM) like ''%B006PSCARICOSERVICE.EXE%'')';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.query_msg1
  is 'prima query da eseguire per estrare i messaggi delle elaborazioni';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.query_msg2
  is 'seconda query da eseguire per estrare i messaggi delle elaborazioni';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.no_monitor_dalle
  is 'Inizio della fascia oraria entro cui non effetuare il monitoraggio';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.no_monitor_alle
  is 'Fine della fascia oraria entro cui non effetuare il monitoraggio';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.msg_elaborazioni_gg
  is 'Numero gg precedenti al corrente in cui andare a leggere i messaggi delle elaborazioni riferite al servizio corrente';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.msg_elaborazioni_righe
  is 'Numero righe max dei messaggi delle elaborazioni riferite al servizio corrente da visualizzare';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.email_mittente
  is 'Indirizzo email del mittente';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.email_destinatari
  is 'Indirizzi email dei destinatari separati da ";"';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.email_destinatari_cc
  is 'Indirizzi email dei destinatari in CC separati da ";"';

alter table MONDOEDP.I191_MONITORSERVIZI_DB
  add constraint I191_PK primary key (ID, DATABASE_NAME)
  using index 
  tablespace INDICI;
alter index MONDOEDP.I191_PK nologging;

alter table MONDOEDP.I191_MONITORSERVIZI_DB
  add constraint I191_FK_I190 foreign key (ID)
  references MONDOEDP.I190_MONITORSERVIZI (ID) on delete cascade;

create table MONDOEDP.I192_MONITORSERVIZI_LOGSTATO
(
  id            NUMBER(38),
  timestamp     DATE default sysdate,
  servizio      VARCHAR2(10),
  database_name VARCHAR2(1000),
  operatore     VARCHAR2(30),
  hostname      VARCHAR2(100),
  hostipaddress VARCHAR2(100),
  stato         VARCHAR2(5),
  msg           VARCHAR2(2000)
)
tablespace LAVORO;

comment on column MONDOEDP.I192_MONITORSERVIZI_LOGSTATO.id
  is 'I192_ID.nextval';
comment on column MONDOEDP.I192_MONITORSERVIZI_LOGSTATO.servizio
  is 'Nome del servizio monitorato: B006=acquisizione automatica timbrature';
comment on column MONDOEDP.I192_MONITORSERVIZI_LOGSTATO.database_name
  is 'Nome del database di cui si è effettuata la connessione del servizio';
comment on column MONDOEDP.I192_MONITORSERVIZI_LOGSTATO.operatore
  is 'Nome dell''operatore che ha eseguito il monitoraggio';
comment on column MONDOEDP.I192_MONITORSERVIZI_LOGSTATO.hostname
  is 'Host name dell''operatore che ha eseguito il monitoraggio';
comment on column MONDOEDP.I192_MONITORSERVIZI_LOGSTATO.hostipaddress
  is 'IP dell''host name dell''operatore che ha eseguito il monitoraggio';
comment on column MONDOEDP.I192_MONITORSERVIZI_LOGSTATO.stato
  is 'Stato della connessione: 0=Connesso, 1=Database non raggiungibile, 2=Servizio non connesso';
comment on column MONDOEDP.I192_MONITORSERVIZI_LOGSTATO.msg
  is 'Messaggio descrittivo dello Stato';

create index MONDOEDP.I192I_SERVIZIO_DB_STATO on MONDOEDP.I192_MONITORSERVIZI_LOGSTATO (SERVIZIO, DATABASE_NAME, STATO)
  tablespace INDICI nologging;

create sequence MONDOEDP.I190_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

create sequence MONDOEDP.I192_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

alter table MONDOEDP.I191_MONITORSERVIZI_DB add MONITOR_BC06SRV varchar2(1) default 'S';
comment on column MONDOEDP.I191_MONITORSERVIZI_DB.MONITOR_BC06SRV IS 'N=database monitorato solo dall''applicativo desktop Bc06PMonitorB006, S=database monitorato anche dal servizio win32 Bc06FMonitorB006Srv';
