update MONDOEDP.I090_ENTI set VERSIONEDB = '9.4',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table MONDOEDP.I095_ITER_AUT add MAX_LIV_NOTE_MODIFICABILI number(2) default 0/*--NOLOG--*/;
comment on column MONDOEDP.I095_ITER_AUT.MAX_LIV_NOTE_MODIFICABILI is 'Indica il livello oltre il quale, se esiste l''autorizzazione, le note della richiesta non sono più modificabili. -1=sono sempre modificabili';

update MONDOEDP.I095_ITER_AUT set MAX_LIV_NOTE_MODIFICABILI = -1 where :AZIENDA = 'AZIN';

alter table MONDOEDP.I073_FILTROFUNZIONI add ACCESSO_BROWSE varchar2(1) default 'S';
comment on column MONDOEDP.I073_FILTROFUNZIONI.ACCESSO_BROWSE is 'S=accesso alla pagina sul frame di browse, N=accesso alla pagina sul frame di dettaglio se disponibile';

alter table MONDOEDP.I073_FILTROFUNZIONI add RIGHE_PAGINA number(4) default 0;
comment on column MONDOEDP.I073_FILTROFUNZIONI.RIGHE_PAGINA is 'Righe max da visualizzare nella griglia: -1=senza limite, 0=parametro aziendale, >0=limite puntuale';

alter table T350_REGREPERIB add TOLL_CHIAMATA_INIZIO varchar2(5) default '00.00';
comment on column T350_REGREPERIB.TOLL_CHIAMATA_INIZIO is 'Minuti di tolleranza espressi in hh.mm entro cui il turno è già visibile alle chiamate su web se sysdate < OraInizio';

alter table T350_REGREPERIB add TOLL_CHIAMATA_FINE varchar2(5) default '00.00';
comment on column T350_REGREPERIB.TOLL_CHIAMATA_FINE is 'Minuti di tolleranza espressi in hh.mm entro cui il turno non è più visibile se sysdate < Ora Fine';

alter table SG742_ETICHETTE_VALUTAZIONI drop column DESCRIZIONE /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI add PATH_INFORMAZIONI VARCHAR2(1000);
alter table SG741_REGOLE_VALUTAZIONI add INVIO_EMAIL VARCHAR2(1) DEFAULT 'N';

delete from T913_SERBATOIKEY where codice = '_ASSPRES' and dato = 'Assenza:data familiare';

create table m024_categ_dati_liberi (
  codice      varchar2(5),
  descrizione varchar2(80),
  ordine      number(4)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column m024_categ_dati_liberi.codice is 'Codice della categoria di dati liberi delle trasferte web';
comment on column m024_categ_dati_liberi.descrizione is 'Descrizione della categoria di dati liberi delle trasferte web';
comment on column m024_categ_dati_liberi.ordine is 'Ordine di visualizzazione della categoria nella pagina web di dettaglio della trasferta';

insert into m024_categ_dati_liberi (codice, descrizione, ordine) 
  select 'DET01', 'Dati liberi per trasferta', 1 from dual
  union all
  select 'EST01', 'Motivazioni per trasferta estera', 0 from dual
  union all
  select 'EST02','Ipotesi per trasferta estera', 0 from dual;

alter table M024_CATEG_DATI_LIBERI
  add constraint M024_PK primary key (codice)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table m024_categ_dati_liberi add min_fase_visibile number(2) default -1;
alter table m024_categ_dati_liberi add max_fase_visibile number(2) default 9;

alter table m024_categ_dati_liberi add min_fase_modifica number(2) default -1;
alter table m024_categ_dati_liberi add max_fase_modifica number(2) default 0;

comment on column m024_categ_dati_liberi.min_fase_visibile is 'Fase a partire dalla quale la categoria di dati liberi è visibile. -1=visibile in inserimento richiesta, 0=visibile in richiesta esistente, >0=fasi associate ai livelli di autorizzazione';
comment on column m024_categ_dati_liberi.max_fase_visibile is 'Ultima fase in cui la categoria di dati liberi è visibile. -1=visibile in inserimento richiesta, 0=visibile in richiesta esistente, >0=fasi associate ai livelli di autorizzazione';
comment on column m024_categ_dati_liberi.min_fase_modifica is 'Fase a partire dalla quale la categoria di dati liberi è modificabile. -1=visibile in inserimento richiesta, 0=visibile in richiesta esistente, >0=fasi associate ai livelli di autorizzazione';
comment on column m024_categ_dati_liberi.max_fase_modifica is 'Ultima fase in cui la categoria di dati liberi è modificabile. -1=visibile in inserimento richiesta, 0=visibile in richiesta esistente, >0=fasi associate ai livelli di autorizzazione';
comment on column mondoedp.i096_livelli_iter_aut.fase is 'Numero indicante la fase applicativa a cui corrisponde il livello. Significativo solo per gli Iter delle Missioni e dello Straordinario mensile';
  
alter table m025_motivazioni
  add constraint M025_FK_M024 foreign key (categoria)
  references m024_categ_dati_liberi (codice) on delete cascade;

create index m025i_categoria on m025_motivazioni (categoria)
tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column m025_motivazioni.valori is 'Impostato in alternativa a QUERY_VALORE e DATO_ANAGRAFICO: se nullo, il dato sarà libero in base al FORMATO. Altrimenti indicare un elenco di valori coerenti con il FORMATO, separato da virgola, che sarà visualizzato come menu a tendina';

alter table m025_motivazioni add formato varchar2(1) default 'S';
comment on column m025_motivazioni.formato is 'S=Stringa, N=Numero, D=Data, M=Messaggio'; 

alter table m025_motivazioni add lung_max number(4) default 0; 
comment on column m025_motivazioni.lung_max is 'numero di caratteri ammessi per questo dato. 0 = illimitato o definito dal tipo'; 

alter table m025_motivazioni add dato_anagrafico varchar2(30); 
comment on column m025_motivazioni.dato_anagrafico is 'Impostato in alternativa a VALORI e QUERY_VALORE: se specificato, l''elenco dei valori è dato dalla query sui valori disponibili in anagrafico per questa colonna';

alter table m025_motivazioni add query_valore varchar2(30); 
comment on column m025_motivazioni.query_valore is 'Impostato in alternativa a VALORI e DATO_ANAGRAFICO: se specificato, l''elenco dei valori è dato dalla interrogazione di servizio identificata da T002.NOME=QUERY_VALORI e APPLICAZIONE=RILPRE';

alter table m025_motivazioni add elenco_fisso varchar2(1) default 'S'; 
comment on column m025_motivazioni.elenco_fisso is 'Significativo se il dato si riferisce ad un elenco. N=è possibile scegliere solamente i valori dalla lista,S=è possibile scrivere un valore non presente nella lista';

alter table m025_motivazioni add valore_default varchar2(2000); 
comment on column m025_motivazioni.valore_default is 'Valore di default associato al dato libero da proporre in fase di inserimento della richiesta';

declare
  cursor c1(pRIGA_INI in integer, pNOME_FUNC in varchar2) is
    select text
    from   user_source
    where  name = pNOME_FUNC
    and    line > pRIGA_INI
    order by line;

  wRigaIni       integer;
  wNomeFunction  varchar2(30);
  wSqlFn         varchar2(32767);
begin
  wNomeFunction:='M140F_CHECKRICHIESTA';
  
  -- estrae il numero di riga dell'intestazione della function
  -- partendo dal presupposto che contenga la stringa "return varchar2 as"
  select nvl(min(line),1)
  into   wRigaIni
  from   user_source
  where  name = wNomeFunction
  and    lower(text) like '%return varchar2 _s%';
  
  -- prepara nuova intestazione function
  wSqlFn:='create or replace function ' || wNomeFunction ||
          ' (pID in integer, pLIVELLO in integer, pFASE in integer, pCHIUSURA in varchar2)' || 
          ' return varchar2 as '
          || chr(10);
  
  -- accoda il corpo della function
  for t1 in c1(wRigaIni,wNomeFunction) loop
    wSqlFn:=wSqlFn || t1.text;
  end loop;
  
  -- esecuzione codice
  execute immediate wSqlFn;
end;
/

delete from T774_PESATUREINDIVIDUALI where (ANNO,CODGRUPPO,CODTIPOQUOTA)
not in (select ANNO,CODGRUPPO,CODTIPOQUOTA from T773_PESATUREGRUPPO);

alter table T774_PESATUREINDIVIDUALI
  add constraint T774_FK_T773 foreign key (ANNO,CODGRUPPO,CODTIPOQUOTA)
  references T773_PESATUREGRUPPO (ANNO,CODGRUPPO,CODTIPOQUOTA) on delete cascade;

ALTER TABLE T200_CONTRATTI MODIFY MAXSTRAORD VARCHAR2(7);
alter table T001_PARAMETRIFUNZIONI modify nome VARCHAR2(100);

/* RENDICONTAZIONE PROGETTI - inizio */

create table T750_PROGETTI_RENDICONTO
(CODICE           varchar2(10)  not null,
 DECORRENZA       date          not null,
 DECORRENZA_FINE  date,
 DESCRIZIONE      varchar2(100),
 ID               number(38),
 NOTE             varchar2(4000),
 ORE_MAX          varchar2(10))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T750_PROGETTI_RENDICONTO.CODICE is 'Codice del progetto';
comment on column T750_PROGETTI_RENDICONTO.DECORRENZA is 'Inizio validità del progetto';
comment on column T750_PROGETTI_RENDICONTO.DECORRENZA_FINE is 'Fine validità del progetto';
comment on column T750_PROGETTI_RENDICONTO.DESCRIZIONE is 'Descrizione del progetto';
comment on column T750_PROGETTI_RENDICONTO.ID is 'Sequence';
comment on column T750_PROGETTI_RENDICONTO.NOTE is 'Note sul progetto';
comment on column T750_PROGETTI_RENDICONTO.ORE_MAX is 'Limite ore del progetto';

alter table T750_PROGETTI_RENDICONTO add constraint T750_PK primary key (CODICE,DECORRENZA) using index
tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T750_PROGETTI_RENDICONTO add constraint T750_ID unique (ID) using index 
tablespace INDICI storage (initial 256K next 256K minextents 1 maxextents unlimited);

create index T750I_CDF on T750_PROGETTI_RENDICONTO (CODICE,DECORRENZA,DECORRENZA_FINE) 
tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create sequence T750_ID
minvalue 1 maxvalue 999999999999999999999999999
start with 1 increment by 1
nocache;

create table T751_ATTIVITA_RENDICONTO
(ID_T750          number(38)    not null, /*T750.id*/
 CODICE           varchar2(10)  not null,
 DESCRIZIONE      varchar2(100),
 ID               number(38),
 ORE_MAX          varchar2(10))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T751_ATTIVITA_RENDICONTO.ID_T750 is 'T750.id';
comment on column T751_ATTIVITA_RENDICONTO.CODICE is 'Attività del progetto';
comment on column T751_ATTIVITA_RENDICONTO.DESCRIZIONE is 'Descrizione dell''attività';
comment on column T751_ATTIVITA_RENDICONTO.ID is 'Sequence';
comment on column T751_ATTIVITA_RENDICONTO.ORE_MAX is 'Limite ore dell''attività';

alter table T751_ATTIVITA_RENDICONTO add constraint T751_PK primary key (ID_T750,CODICE) using index
tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T751_ATTIVITA_RENDICONTO add constraint T751_ID unique (ID) using index 
tablespace INDICI storage (initial 256K next 256K minextents 1 maxextents unlimited);

alter table T751_ATTIVITA_RENDICONTO 
add constraint T751_FK_T750 foreign key (ID_T750) 
references T750_PROGETTI_RENDICONTO (ID) on delete cascade;

create sequence T751_ID
minvalue 1 maxvalue 999999999999999999999999999
start with 1 increment by 1
nocache;

create table T752_TASK_RENDICONTO
(ID_T751          number(38)    not null, /*T751.id*/
 CODICE           varchar2(10)  not null,
 DESCRIZIONE      varchar2(100),
 ID               number(38),
 ORE_MAX          varchar2(10))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T752_TASK_RENDICONTO.ID_T751 is 'T751.id';
comment on column T752_TASK_RENDICONTO.CODICE is 'Task dell''attività del progetto';
comment on column T752_TASK_RENDICONTO.DESCRIZIONE is 'Descrizione del task';
comment on column T752_TASK_RENDICONTO.ID is 'Sequence';
comment on column T752_TASK_RENDICONTO.ORE_MAX is 'Limite ore del task';

alter table T752_TASK_RENDICONTO add constraint T752_PK primary key (ID_T751,CODICE) using index
tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T752_TASK_RENDICONTO add constraint T752_ID unique (ID) using index 
tablespace INDICI storage (initial 256K next 256K minextents 1 maxextents unlimited);

alter table T752_TASK_RENDICONTO 
add constraint T752_FK_T751 foreign key (ID_T751) 
references T751_ATTIVITA_RENDICONTO (ID) on delete cascade;

create sequence T752_ID
minvalue 1 maxvalue 999999999999999999999999999
start with 1 increment by 1
nocache;

create table T753_LIMITI_IND_RENDICONTO
(ID_T752          number(38)    not null, /*T752.id*/
 PROGRESSIVO      number(8)     not null,
 DECORRENZA       date          not null,
 DECORRENZA_FINE  date,
 ORE_MAX          varchar2(10),
 ORE_FRUITO       varchar2(10))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T753_LIMITI_IND_RENDICONTO.ID_T752 is 'T752.id';
comment on column T753_LIMITI_IND_RENDICONTO.PROGRESSIVO is 'Progressivo del dipendente';
comment on column T753_LIMITI_IND_RENDICONTO.DECORRENZA is 'Inizio validità del task per il dipendente';				
comment on column T753_LIMITI_IND_RENDICONTO.DECORRENZA_FINE is 'Fine validità del task per il dipendente';				
comment on column T753_LIMITI_IND_RENDICONTO.ORE_MAX is 'Limite ore del task per dipendente';
comment on column T753_LIMITI_IND_RENDICONTO.ORE_FRUITO is 'Ore del task fruite dal dipendente';

alter table T753_LIMITI_IND_RENDICONTO add constraint T753_PK primary key (ID_T752,PROGRESSIVO,DECORRENZA) using index
tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T753_LIMITI_IND_RENDICONTO 
add constraint T753_FK_T752 foreign key (ID_T752) 
references T752_TASK_RENDICONTO (ID) on delete cascade;

create index T753I_CDF on T753_LIMITI_IND_RENDICONTO (ID_T752,PROGRESSIVO,DECORRENZA,DECORRENZA_FINE) 
tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T755_RICHIESTE_RENDICONTO
(ID               number(38)    not null, /*T850.id*/
 PROGRESSIVO      number(8),
 DATA             date,
 ID_T752          number(38),             
 ORE              varchar2(10))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T755_RICHIESTE_RENDICONTO.ID is 'Id dell''iter autorizzativo';
comment on column T755_RICHIESTE_RENDICONTO.PROGRESSIVO is 'Progressivo del dipendente che effettua la richiesta';
comment on column T755_RICHIESTE_RENDICONTO.DATA is 'Giorno per il quale è inserita la richiesta';
comment on column T755_RICHIESTE_RENDICONTO.ID_T752 is 'T752.id';
comment on column T755_RICHIESTE_RENDICONTO.ORE is 'Ore richieste';

alter table T755_RICHIESTE_RENDICONTO add constraint T755_PK primary key (ID) using index
tablespace INDICI storage (initial 256K next 256K pctincrease 0);

/* RENDICONTAZIONE PROGETTI - fine */

alter table MONDOEDP.I095_ITER_AUT add CONDIZIONE_ALLEGATI varchar2(2000);
comment on column MONDOEDP.I095_ITER_AUT.CONDIZIONE_ALLEGATI  is 'Espressione SQL che consente di attivare la gestione degli allegati per le richieste. L''espressione deve restituire un valore varchar2(1), scelto fra: N=allegati non previsti, F=allegati facoltativi, O=allegati obbligatori';

alter table MONDOEDP.I095_ITER_AUT add ALLEGATI_MODIFICABILI varchar2(1) default 'N';
comment on column MONDOEDP.I095_ITER_AUT.ALLEGATI_MODIFICABILI is 'Indica se gli allegati sono modificabili per una richiesta con iter concluso. Valori possibili: S=allegati modificabili, N=allegati non modificabili';

alter table MONDOEDP.I096_LIVELLI_ITER_AUT add ALLEGATI_OBBLIGATORI varchar2(1) default 'N';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.ALLEGATI_OBBLIGATORI  is 'Indica se la presenza di allegati è obbligatoria per l''autorizzazione. Valori possibili: S=allegati obbligatori, N=allegati non obbligatori';

alter table MONDOEDP.I096_LIVELLI_ITER_AUT add ALLEGATI_VISIBILI varchar2(1) default 'S';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.ALLEGATI_VISIBILI  is 'Indica se gli allegati sono visibili all''autorizzatore corrente. Valori possibili: S=allegati visibili, N=allegati inibiti';

create sequence T960_ID
  minvalue 1
  maxvalue 999999999999999999999999999
  start with 1
  increment by 1
  nocache;

create table T960_DOCUMENTI_INFO (
  ID              number(38)     not null,
  DATA_CREAZIONE  date           default sysdate,
  NOME_UTENTE     varchar2(30),
  UTENTE          varchar2(30),
  PROGRESSIVO     number(38),
  TIPOLOGIA       varchar2(20)   not null,
  UFFICIO         varchar2(20),
  NOME_FILE       varchar2(200)  not null,
  EXT_FILE        varchar2(20),
  DIMENSIONE      number(38),
  PERIODO_DAL     date,
  PERIODO_AL      date,
  NOTE            varchar2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T960_DOCUMENTI_INFO.ID is 'Identificativo del documento (T960_ID.next_val)';
comment on column T960_DOCUMENTI_INFO.DATA_CREAZIONE is 'Data di creazione del documento';
comment on column T960_DOCUMENTI_INFO.NOME_UTENTE is 'Utente web che ha creato il documento (I060). In alternativa a UTENTE';
comment on column T960_DOCUMENTI_INFO.UTENTE is 'Operatore win che ha creato il documento (I070). In alternativa a NOME_UTENTE';
comment on column T960_DOCUMENTI_INFO.PROGRESSIVO is 'Progressivo del dipendente a cui afferisce il documento';
comment on column T960_DOCUMENTI_INFO.TIPOLOGIA is 'Tipologia del documento: ITER=legato agli iter autorizzativi';
comment on column T960_DOCUMENTI_INFO.UFFICIO is 'Ufficio a cui afferisce il documento - non ancora usato';
comment on column T960_DOCUMENTI_INFO.NOME_FILE is 'Nome del file allegato privo di estensione';
comment on column T960_DOCUMENTI_INFO.EXT_FILE is 'Estensione del file allegato';
comment on column T960_DOCUMENTI_INFO.DIMENSIONE is 'Dimensione del file allegato espressa in byte';
comment on column T960_DOCUMENTI_INFO.PERIODO_DAL is 'Data iniziale del periodo di riferimento del documento';
comment on column T960_DOCUMENTI_INFO.PERIODO_AL is 'Data finale del periodo di riferimento del documento';
comment on column T960_DOCUMENTI_INFO.NOTE is 'Eventuali note per il documento';

alter table T960_DOCUMENTI_INFO
  add constraint T960_PK primary key (ID)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T960_DOCUMENTI_INFO
  add constraint T960_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO) on delete cascade;

create table T961_DOCUMENTI_FILE (
  ID              number(38),
  DOCUMENTO       blob
)
lob (DOCUMENTO) store as basicfile (
  tablespace LAVORO_LOB
  chunk 32K
  nocache
  nologging
  disable storage in row
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;

create table T961_DOCUMENTI_FILE (
  ID              number(38),
  DOCUMENTO       blob
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T961_DOCUMENTI_FILE.ID is 'Identificativo del documento di riferimento';
comment on column T961_DOCUMENTI_FILE.DOCUMENTO is 'File allegato: registrarlo preferibilmente su tablespace specifico LAVORO_LOB';

alter table T961_DOCUMENTI_FILE
  add constraint T961_PK primary key (ID)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T961_DOCUMENTI_FILE
  add constraint T961_FK_T960 foreign key (ID)
  references T960_DOCUMENTI_INFO (ID) on delete cascade;

create table T853_DOC_ALLEGATI (
  ID              number(38),
  ID_T960         number(38)
) 
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T853_DOC_ALLEGATI.ID is 'ID della richiesta cui si riferiscono i documenti';
comment on column T853_DOC_ALLEGATI.ID_T960 is 'ID del documento allegato';

alter table T853_DOC_ALLEGATI
  add constraint T853_PK primary key (ID, ID_T960)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T853_DOC_ALLEGATI
  add constraint T853_FK_T850 foreign key (ID)
  references T850_ITER_RICHIESTE (ID);

alter table T853_DOC_ALLEGATI
  add constraint T853_FK_T960 foreign key (ID_T960)
  references T960_DOCUMENTI_INFO (ID) on delete cascade;

insert into MONDOEDP.I091_DATIENTE (AZIENDA, TIPO, DATO) select AZIENDA,'C90_ITER_MAX_ALLEGATI', '1' from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA;
insert into MONDOEDP.I091_DATIENTE (AZIENDA, TIPO, DATO) select AZIENDA,'C90_ITER_MAX_DIM_ALLEGATO_MB', '5' from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA;
