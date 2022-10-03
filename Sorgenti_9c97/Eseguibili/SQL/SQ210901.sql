update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.9',PATCHDB = 4 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

delete from mondoedp.i073_filtrofunzioni where applicazione in ('PAGHE','STAGIU');
delete from mondoedp.i073_filtrofunzioni where tag in (444,445) and applicazione <> 'FUNWEB';

create table T962_TIPO_DOCUMENTI
(
  CODICE            varchar2(10) not null,
  DESCRIZIONE       varchar2(80),
  CODICE_DEFAULT    varchar2(1) default 'N' not null,
  EMAIL             varchar2(2000),
  ORDINE            number,
  VERSIONABILE      varchar2(1) default 'N',
  UM                varchar2(1),
  QUANTITA          number(3),
  SCRIPT_TICKET_PDF varchar2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T962_TIPO_DOCUMENTI.CODICE_DEFAULT
  is 'Indica se la tipologia è quella di default. S=tipologia di default,N=tipologia non di default';
comment on column T962_TIPO_DOCUMENTI.ORDINE
  is 'Ordine della tipologia nella selezione';
comment on column T962_TIPO_DOCUMENTI.VERSIONABILE
  is 'Indica se il tipo di documento è versionabile S/N';
comment on column T962_TIPO_DOCUMENTI.UM
  is 'UnitÃ  di misura della quantitÃ : D=giorni;, W=settimane, M=mesi, Y=anni';
comment on column T962_TIPO_DOCUMENTI.QUANTITA
  is 'Numero di UM entro cui non si deve ripetere un documento della tipologia';
comment on column T962_TIPO_DOCUMENTI.SCRIPT_TICKET_PDF
  is 'Script SQL eseguito per estrarre le righe da inserire nel ticket inserito ad inizio pagine nel pdf, variabili IN: P_PROGRESSIVO:INTEGER, P_DATA:DATE, P_ID:INTEGER, variabili OUT: RESULT';

alter table T962_TIPO_DOCUMENTI
  add constraint T962_PK primary key (CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T962_TIPO_DOCUMENTI
  add constraint T962_UQ unique (DESCRIZIONE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T963_UFFICIO_DOCUMENTI
(
  CODICE         varchar2(10) not null,
  DESCRIZIONE    varchar2(80),
  CODICE_DEFAULT varchar2(1) default 'N' not null,
  EMAIL          varchar2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T963_UFFICIO_DOCUMENTI.CODICE_DEFAULT
  is 'Indica se l''ufficio è quello di default. S=ufficio di default,N=ufficio non di default';

alter table T963_UFFICIO_DOCUMENTI
  add constraint T963_PK primary key (CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
  
alter table T963_UFFICIO_DOCUMENTI
  add constraint T963_UQ unique (DESCRIZIONE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);	
	
alter table T265_CAUASSENZE add ESTENDE_MALATTIA varchar2(1) default 'N';
comment on column T265_CAUASSENZE.ESTENDE_MALATTIA 
	is 'S=le giornate intere giustificate con questa causale estendono il periodo mobile della malattia retrocedendo la data di inizio cumulo';