update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.7',PATCHDB = 2 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);
	
create table MONDOEDP.I076_REGOLE_ACCESSO
(
  azienda      VARCHAR2(30) not null,
  profilo      VARCHAR2(20) not null,
  applicazione VARCHAR2(6) not null,
  tag          NUMBER(8) default 451 not null,
  ip           VARCHAR2(15) not null,
  consentito   VARCHAR2(1) default 'S' not null,
  ip_esterno   VARCHAR2(1) default 'S'
) tablespace LAVORO;

comment on column MONDOEDP.I076_REGOLE_ACCESSO.azienda
  is 'Codice dell''azienda di riferimento su I090';
comment on column MONDOEDP.I076_REGOLE_ACCESSO.profilo
  is 'Codice del filtro funzioni I073.PROFILO';
comment on column MONDOEDP.I076_REGOLE_ACCESSO.applicazione
  is 'Codice dell''applicazione di riferimento';
comment on column MONDOEDP.I076_REGOLE_ACCESSO.tag
  is 'Tag della funzione di riferimento';
comment on column MONDOEDP.I076_REGOLE_ACCESSO.ip
  is 'Indirizzo IP da consentire o bloccare. E'' possibile utilizzare l''asterisco come carattere jolly, oltre al valore convenzionale ''unknown'' per gestire il caso di IP non reperito';
comment on column MONDOEDP.I076_REGOLE_ACCESSO.consentito
  is 'Indica se l''IP indicato è abilitato o meno all''accesso alla funzione indicata dal TAG. S=IP abilitato,N=IP non abilitato';
comment on column MONDOEDP.I076_REGOLE_ACCESSO.ip_esterno
  is 'S=ip con cui il client esce in internet, N=ip con cui il client è riconosciuto dal web server nella intranet';

alter table MONDOEDP.I076_REGOLE_ACCESSO
  add constraint I076_PK primary key (AZIENDA, PROFILO, APPLICAZIONE, TAG, IP)
  using index tablespace INDICI;
alter table MONDOEDP.I076_REGOLE_ACCESSO
  add constraint I076_FK_I073 foreign key (AZIENDA, PROFILO, APPLICAZIONE, TAG)
  references MONDOEDP.I073_FILTROFUNZIONI (AZIENDA, PROFILO, APPLICAZIONE, TAG) on delete cascade;
