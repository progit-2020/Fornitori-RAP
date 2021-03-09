update MONDOEDP.I090_ENTI set VERSIONEDB = '8.3',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table T825_LIQUIDINDANNUO modify RESIDUABILE default null;
alter table T825_LIQUIDINDANNUO add RESIDUABILE_TEORICO varchar2(7);

alter table SG095_PROVVEDIMENTODETT
  add constraint SG095_FK_SG100 foreign key (PROGRESSIVO, NOMECAMPO, DATADECOR, DATAREGISTR)
  references SG100_PROVVEDIMENTO (PROGRESSIVO, NOMECAMPO, DATADECOR, DATAREGISTR) on delete cascade;

/*Gestione iter autorizzativi multipli*/
drop table MONDOEDP.I094_LIVELLI_ITER_AUT;
drop table MONDOEDP.I093_ITER_AUT;

create table MONDOEDP.I093_BASE_ITER_AUT(
AZIENDA varchar2(30),
ITER varchar2(30),
REVOCABILE varchar2(1) default 'N',
MAIL_OGGETTO_DIP varchar2(2000),
MAIL_CORPO_DIP varchar2(2000),
MAIL_OGGETTO_RESP varchar2(2000),
MAIL_CORPO_RESP varchar2(2000),
EXPR_PERIODO_VISUAL varchar2(2000)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column MONDOEDP.I093_BASE_ITER_AUT.ITER is 'Identificativo interno degli iter autorizzativi disponibili';
comment on column MONDOEDP.I093_BASE_ITER_AUT.REVOCABILE is 'S=attivazione della gestione revoche delle richieste(se prevista), N=disattivazione della gestione revoche';
comment on column MONDOEDP.I093_BASE_ITER_AUT.MAIL_OGGETTO_DIP is 'Espressione SQL per generare l''oggetto della mail verso il richiedente';
comment on column MONDOEDP.I093_BASE_ITER_AUT.MAIL_CORPO_DIP is 'Espressione SQL per generare il testo della mail verso il richiedente';
comment on column MONDOEDP.I093_BASE_ITER_AUT.MAIL_OGGETTO_RESP is 'Espressione SQL per generare l''oggetto della mail verso il responsabile';
comment on column MONDOEDP.I093_BASE_ITER_AUT.MAIL_CORPO_RESP is 'Espressione SQL per generare il testo della mail verso il responsabile';
comment on column MONDOEDP.I093_BASE_ITER_AUT.EXPR_PERIODO_VISUAL is 'Espressione SQL per restituire 2 date (data1,data2) riferite a sysdate usate dall''applicativo per proporre il periodo di visualizzazione delle richieste';

alter table MONDOEDP.I093_BASE_ITER_AUT add constraint I093_PK primary key (AZIENDA, ITER) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table MONDOEDP.I094_CHKDATI_ITER_AUT(
AZIENDA varchar2(30),
ITER varchar2(30),
RIEPILOGO varchar2(5), 
STATO varchar2(1),
EXPR_DATA varchar2(2000)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column MONDOEDP.I094_CHKDATI_ITER_AUT.ITER is 'Deve corrispondere a I093.ITER';
comment on column MONDOEDP.I094_CHKDATI_ITER_AUT.RIEPILOGO is 'Identificativo interno del riepilogo che si vuole controllare. I codici corrispondono a quelli usati nella T280.';
comment on column MONDOEDP.I094_CHKDATI_ITER_AUT.STATO is 'La richiesta viene considerata valida se il riepilogo sulla T280 è nella stessa condizione indicata da STATO';
comment on column MONDOEDP.I094_CHKDATI_ITER_AUT.EXPR_DATA is 'Data a cui verificare il riepilogo, potendosi riferire anche ai campi della tabella delle richieste';

alter table MONDOEDP.I094_CHKDATI_ITER_AUT add constraint I094_PK primary key (AZIENDA, ITER, RIEPILOGO, STATO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table MONDOEDP.I094_CHKDATI_ITER_AUT
  add constraint I094_FK_I093 foreign key (AZIENDA, ITER)
  references MONDOEDP.I093_BASE_ITER_AUT (AZIENDA, ITER) on delete cascade/*--NOLOG--*/;

create table MONDOEDP.I095_ITER_AUT(
  AZIENDA varchar2(30),
  ITER varchar2(10),
  COD_ITER varchar2(20),
  FILTRO_RICHIESTA varchar2(2000),
  CONDIZ_AUTORIZZ_AUTOMATICA varchar2(2000),
  MAX_LIV_AUTORIZZ_AUTOMATICA number(2) default -1
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;

comment on column MONDOEDP.I095_ITER_AUT.ITER is 'Deve corrispondere a I093.ITER';
comment on column MONDOEDP.I095_ITER_AUT.COD_ITER is 'Codice dell''iter di cui esprimere le caratteristiche';
comment on column MONDOEDP.I095_ITER_AUT.FILTRO_RICHIESTA is 'Espressione SQL che attiva questo COD_ITER se verificata dai dati della richiesta';
comment on column MONDOEDP.I095_ITER_AUT.CONDIZ_AUTORIZZ_AUTOMATICA is 'Espressione SQL che attiva l''autorizzazione automatica se verificata';
comment on column MONDOEDP.I095_ITER_AUT.MAX_LIV_AUTORIZZ_AUTOMATICA is 'Massimo livello che può essere autorizzato automaticamente';

alter table MONDOEDP.I095_ITER_AUT add constraint I095_PK primary key (AZIENDA,ITER,COD_ITER) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;

create table MONDOEDP.I096_LIVELLI_ITER_AUT(
AZIENDA varchar2(30),
ITER varchar2(10),
COD_ITER varchar2(20),
LIVELLO number(2),
DESC_LIVELLO varchar2(40),
FASE number(2) default 0,
OBBLIGATORIO varchar2(1) default 'S',
AVVISO varchar2(1) default 'N',
VALORI_POSSIBILI varchar2(100) default 'S,N',
AUTORIZZ_INTERMEDIA varchar2(1),
DATI_MODIFICABILI varchar2(1) default 'N',
INVIO_EMAIL varchar2(1) default 'N',
CONDIZ_AUTORIZZ_AUTOMATICA varchar2(2000),
SCRIPT_AUTORIZZ varchar2(2000)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;

alter table MONDOEDP.I096_LIVELLI_ITER_AUT add constraint I096_PK primary key (AZIENDA,ITER,COD_ITER,LIVELLO) using index tablespace INDICI/*--NOLOG--*/;

comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.ITER is 'Deve corrispondere a I093.ITER';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.COD_ITER is 'Codice Iter di cui si vuole definire i livelli di autorizzazione';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.LIVELLO is 'Numero di livello di autorizzazione = 1..9';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.DESC_LIVELLO is 'Descrizione del significato del livello';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.FASE is 'Numero indicante la fase applicativa a cui corrisponde il livello. Significativo solo per ITER_MISSIONI';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.OBBLIGATORIO is 'S=autorizzazione obbligatoria, N=autorizzazione facoltativa';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.AVVISO is 'Non usato. S=dare l''avviso al livello successivo che manca autorizzazione se non obbligatoria, N=non viene dato alcun avviso al livello successivo';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.VALORI_POSSIBILI is 'Elenco valori disponibili in fase di autorizzazione. per esempio S,N';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.AUTORIZZ_INTERMEDIA is 'Valore che indica un''autorizzazione intermedia, da completare successivamente dall''applicativo specifico. Non ancora visibile dal livello successivo';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.DATI_MODIFICABILI is 'S=chi ha accesso a questo livello di autorizzazione può modificare i dati, se previsti, nella tabella T852';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.INVIO_EMAIL is 'N=disattivo, R=solo verso Richiedente, A=solo verso autorizzatore, E=verso Richiedente e Autorizzatore';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.CONDIZ_AUTORIZZ_AUTOMATICA is 'Espressione SQL che attiva l''autorizzazione automatica per questo livello se verificata';
comment on column MONDOEDP.I096_LIVELLI_ITER_AUT.SCRIPT_AUTORIZZ is 'Comando SQL che viene eseguito quando il livello viene autorizzato';

alter table MONDOEDP.I096_LIVELLI_ITER_AUT
  add constraint I096_FK_I095 foreign key (AZIENDA, ITER, COD_ITER)
  references MONDOEDP.I095_ITER_AUT (AZIENDA, ITER, COD_ITER) on delete cascade/*--NOLOG--*/;

create table MONDOEDP.I097_VALIDITA_ITER_AUT (
  AZIENDA varchar2(30),
  ITER varchar2(10),
  COD_ITER varchar2(20),
  NUM_CONDIZ number(2),
  CONDIZ_VALIDITA varchar2(2000),
  MESSAGGIO varchar2(2000),
  BLOCCANTE varchar2(1) default 'S'
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column MONDOEDP.I097_VALIDITA_ITER_AUT.ITER is 'Deve corrispondere a I093.ITER';
comment on column MONDOEDP.I097_VALIDITA_ITER_AUT.COD_ITER is 'Codice Iter di cui si vuole definire le espressioni di controllo';
comment on column MONDOEDP.I097_VALIDITA_ITER_AUT.NUM_CONDIZ is 'Numerazione interna delle espressioni';
comment on column MONDOEDP.I097_VALIDITA_ITER_AUT.CONDIZ_VALIDITA is 'Espressione SQL determina la validità della richiesta';
comment on column MONDOEDP.I097_VALIDITA_ITER_AUT.MESSAGGIO is 'Espressione SQL determina il messggio da visualizzare nel caso che CONDIZ_VALIDITA non sia verificata';
comment on column MONDOEDP.I097_VALIDITA_ITER_AUT.BLOCCANTE is 'S=se CONDIZ_VALIDITA non è verificata la richiesta viene inserita, N=se CONDIZ_VALIDITA non è verificata viene chiesto se inserire la richiesta';

alter table MONDOEDP.I097_VALIDITA_ITER_AUT add constraint I097_PK primary key (AZIENDA, ITER, COD_ITER, NUM_CONDIZ) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table MONDOEDP.I097_VALIDITA_ITER_AUT
  add constraint I097_FK_I095 foreign key (AZIENDA, ITER, COD_ITER)
  references MONDOEDP.I095_ITER_AUT (AZIENDA, ITER, COD_ITER) on delete cascade/*--NOLOG--*/;

drop table T850_ITER_AUTORIZZAZIONI/*--NOLOG--*/;
create table T850_ITER_RICHIESTE
(
  ID                  NUMBER(38) not null,
  ITER                VARCHAR2(10) not null,
  COD_ITER            VARCHAR2(20),
  DATA                DATE,
  NOTE                VARCHAR2(2000),
  STATO               VARCHAR2(1),
  TIPO_RICHIESTA      VARCHAR2(1),
  AUTORIZZ_AUTOMATICA VARCHAR2(1),
  ID_REVOCA           NUMBER(38),
  ID_REVOCATO         NUMBER(38)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T850_ITER_RICHIESTE.ID is 'ID della richiesta a cui si riferisce la richiesta';
comment on column T850_ITER_RICHIESTE.ITER is 'Identificativo interno dell''iter a cui si riferisce la richiesta';
comment on column T850_ITER_RICHIESTE.COD_ITER is 'Codice dell''iter a cui si riferisce la richiesta';
comment on column T850_ITER_RICHIESTE.DATA is 'Data della richiesta';
comment on column T850_ITER_RICHIESTE.NOTE is 'Note relative alla richiesta';
comment on column T850_ITER_RICHIESTE.STATO is 'Stato dell''autorizzazione finale (S,N)';
comment on column T850_ITER_RICHIESTE.TIPO_RICHIESTA is 'Flag a disposizione della specifica funzione che gestisce l''iter';
comment on column T850_ITER_RICHIESTE.AUTORIZZ_AUTOMATICA is 'S=richiesta che è stata autorizzata automaticamente fino all''ultimo livello obbligatorio';
comment on column T850_ITER_RICHIESTE.ID_REVOCA is 'ID della richiesta che revoca l''attuale';
comment on column T850_ITER_RICHIESTE.ID_REVOCATO is 'ID della richiesta da revocare; se not null indica che la richiesta corrente è una revoca';

alter table T850_ITER_RICHIESTE add constraint T850_PK primary key (ID)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create index T850I_ITER_ID on T850_ITER_RICHIESTE(ITER,ID) tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T851_ITER_AUTORIZZAZIONI
(
  ID                  NUMBER(38) not null,
  LIVELLO             NUMBER(2) not null,
  DATA                DATE,
  RESPONSABILE        VARCHAR2(30),
  NOTE                VARCHAR2(2000),
  STATO               VARCHAR2(1),
  AUTORIZZ_AUTOMATICA VARCHAR2(1)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T851_ITER_AUTORIZZAZIONI.ID is 'ID della richiesta a cui si riferisce l''autorizzazione';
comment on column T851_ITER_AUTORIZZAZIONI.LIVELLO is 'Numero di livello di autorizzazione = 1..9.';
comment on column T851_ITER_AUTORIZZAZIONI.DATA is 'Data dell''autorizzazione';
comment on column T851_ITER_AUTORIZZAZIONI.RESPONSABILE is 'Responsabile che autorizza';
comment on column T851_ITER_AUTORIZZAZIONI.NOTE is 'Note relative all''autorizzazione';
comment on column T851_ITER_AUTORIZZAZIONI.STATO is 'Stato dell''autorizzazione (S, N, ...)';
comment on column T851_ITER_AUTORIZZAZIONI.AUTORIZZ_AUTOMATICA is 'S=livello autorizzato automaticamente';

alter table T851_ITER_AUTORIZZAZIONI add constraint T851_PK primary key (ID, LIVELLO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T851_ITER_AUTORIZZAZIONI
  add constraint T850_FK_T851 foreign key (ID)
  references T850_ITER_RICHIESTE (ID) on delete cascade;

create table T852_ITER_DATI_AUTORIZZATORI(
ID number(38),
LIVELLO number(2),
DATA date,
DATO varchar2(30),
VALORE varchar2(100)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T852_ITER_DATI_AUTORIZZATORI add constraint T852_PK primary key (ID,LIVELLO,DATO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
comment on column T852_ITER_DATI_AUTORIZZATORI.ID is 'ID della richiesta a cui si riferiscono i dati';
comment on column T852_ITER_DATI_AUTORIZZATORI.LIVELLO is 'Livello di autorizzazione al quale sono stati registrati i dati';
comment on column T852_ITER_DATI_AUTORIZZATORI.DATA is 'Data della registrazione dei dati';
comment on column T852_ITER_DATI_AUTORIZZATORI.DATO is 'Nome del dato di cui l''autorizzatore specifica il valore';
comment on column T852_ITER_DATI_AUTORIZZATORI.VALORE is 'Valore del dato specificato dall''autorizzatore';

alter table T852_ITER_DATI_AUTORIZZATORI
  add constraint T850_FK_T852 foreign key (ID)
  references T850_ITER_RICHIESTE (ID) on delete cascade;

create index T180I_PROG_DALAL_RIEP on T180_DATIBLOCCATI(PROGRESSIVO,DAL,AL,RIEPILOGO) tablespace indici storage (initial 256K next 256K pctincrease 0);
create bitmap index T280I_FLAG on T280_MESSAGGIWEB(FLAG) tablespace INDICI storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;
create index T280I_FLAG on T280_MESSAGGIWEB(FLAG) tablespace INDICI storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;

alter table T105_RICHIESTETIMBRATURE add ID number(38);
comment on column T105_RICHIESTETIMBRATURE.ID is 'ID dell''iter autorizzativo';
alter table T065_RICHIESTESTRAORDINARI add ID number(38);
comment on column T065_RICHIESTESTRAORDINARI.ID is 'ID dell''iter autorizzativo';
alter table T085_RICHIESTECAMBIORARI add ID number(38);
comment on column T085_RICHIESTECAMBIORARI.ID is 'ID dell''iter autorizzativo';
alter table T326_RICHIESTESTR_SPEZ add ID_T850 number(38);
comment on column T326_RICHIESTESTR_SPEZ.ID_T850 is 'ID dell''iter autorizzativo';

drop index T050_IDRICH;
alter table T085_RICHIESTECAMBIORARI drop primary key;
drop index T085_PK;
create index T085I_DATA on T085_RICHIESTECAMBIORARI(DATA) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index T085I_PROGRESSIVO_DATA on T085_RICHIESTECAMBIORARI(PROGRESSIVO,DATA) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index T326I_ID_T850 on T326_RICHIESTESTR_SPEZ(ID_T850) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
drop index T325_ID_RETTIFICA;
alter table T325_RICHIESTESTR_GG drop column ID_RETTIFICA;

rename T050_ID to T850_ID;

declare 
  cursor ct050 is select rowid from t050_richiesteassenza where id is null order by data_richiesta;
  cursor ct065 is select rowid from t065_richiestestraordinari where id is null order by data_richiesta;
  cursor ct085 is select rowid from t085_richiestecambiorari where id is null order by data_richiesta;
  cursor ct105 is select rowid from t105_richiestetimbrature where id is null order by data_richiesta;
begin
  for t1 in ct050 loop
    update t050_richiesteassenza
    set id = t850_id.nextval
    where rowid = t1.rowid;
    commit;
   end loop;
  for t1 in ct065 loop
    update t065_richiestestraordinari
    set id = t850_id.nextval
    where rowid = t1.rowid;
    commit;
  end loop;
  for t1 in ct085 loop
    update t085_richiestecambiorari
    set id = t850_id.nextval
    where rowid = t1.rowid;
    commit;
  end loop;
  for t1 in ct105 loop
    update t105_richiestetimbrature
    set id = t850_id.nextval
    where rowid = t1.rowid;
    commit;
  end loop;
end;
/

--rinumerazione iter T325
delete from T325_RICHIESTESTR_GG where STATO = 'I';

declare 
  cursor ct326T is select rowid from t326_richiestestr_spez where id_t850 is null;
  cursor ct326EU is select distinct id from t326_richiestestr_spez where id_t850 is null;
  w_dato   varchar2(200);
  new_id   number;
begin
  -- determina tipo spezzoni utilizzati nelle richieste ecced. gg.
  begin
    select dato into w_dato 
    from   mondoedp.i091_datiente 
    where  azienda = :AZIENDA
    and    tipo = 'C90_W026SPEZZONI';
  exception
    when no_data_found then
      w_dato:='';
  end;

  if w_dato = 'T' then
    
    for t1 in ct326T loop
      update t326_richiestestr_spez
      set id_t850 = t850_id.nextval
      where rowid = t1.rowid;
      commit;
    end loop;

    insert into T850_ITER_RICHIESTE (ITER,COD_ITER,ID,DATA,NOTE,TIPO_RICHIESTA,STATO)
    select 'T325','DEFAULT',T326.ID_T850,T325.DATA_RICHIESTA,T325.NOTE1,T325.STATO,T326.AUTORIZZAZIONE
    from T325_RICHIESTESTR_GG T325, T326_RICHIESTESTR_SPEZ T326 where T325.ID = T326.ID;
    
    insert into T851_ITER_AUTORIZZAZIONI (ID,LIVELLO,DATA,RESPONSABILE,NOTE,STATO)
    select T326.ID_T850,1,T325.DATA_AUTORIZZAZIONE, T325.RESPONSABILE,T325.NOTE2,T326.AUTORIZZAZIONE
    from   T325_RICHIESTESTR_GG T325, T326_RICHIESTESTR_SPEZ T326 
    where  T325.ID = T326.ID;
    
  elsif w_dato = 'EU' then 
  
    for t1 in ct326EU loop
      select t850_id.nextval into new_id from dual;
      update t326_richiestestr_spez
      set id_t850 = new_id
      where id = t1.id;
      commit;
    end loop;

    insert into T850_ITER_RICHIESTE (ITER,COD_ITER,ID,DATA,NOTE,TIPO_RICHIESTA,STATO)
    select 'T325' ITER, 'DEFAULT' COD_ITER, T326.ID_T850, T325.DATA_RICHIESTA,T325.NOTE1,T325.STATO,decode(MAX(t326.AUTORIZZAZIONE),null,null,'S')
    from   T325_RICHIESTESTR_GG T325, T326_RICHIESTESTR_SPEZ T326 
    where  T325.ID = T326.ID
    group by 1, 2, ID_T850, DATA_RICHIESTA, NOTE1, STATO;

    insert into T851_ITER_AUTORIZZAZIONI (ID,LIVELLO,DATA,RESPONSABILE,NOTE,STATO)
    select T326.ID_T850,1,T325.DATA_AUTORIZZAZIONE, T325.RESPONSABILE,T325.NOTE2,decode(MAX(T326.AUTORIZZAZIONE),null,null,'S')
    from   T325_RICHIESTESTR_GG T325, T326_RICHIESTESTR_SPEZ T326 
    where  T325.ID = T326.ID
    and   (T326.AUTORIZZAZIONE is not null or T325.NOTE2 is not null)
    group by ID_T850, 2, DATA_AUTORIZZAZIONE, responsabile, note2;
  end if;
end;
/

alter table T050_RICHIESTEASSENZA add constraint T050_PK primary key (ID) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T085_RICHIESTECAMBIORARI add constraint T085_PK primary key (ID) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T105_RICHIESTETIMBRATURE add constraint T105_PK primary key (ID) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T065_RICHIESTESTRAORDINARI drop primary key;
drop index T065_PK;
alter table T065_RICHIESTESTRAORDINARI add constraint T065_PK primary key (ID) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create unique index T065I_PROG_DATA_IDCONG on T065_RICHIESTESTRAORDINARI (PROGRESSIVO,DATA,ID_CONGUAGLIO) tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column T050_RICHIESTEASSENZA.AUTORIZZAZIONE is 'obsoleto';
comment on column T050_RICHIESTEASSENZA.RESPONSABILE is 'obsoleto';
comment on column T050_RICHIESTEASSENZA.NOTE1 is 'obsoleto';
comment on column T050_RICHIESTEASSENZA.NOTE2 is 'obsoleto';
comment on column T050_RICHIESTEASSENZA.DATA_RICHIESTA is 'obsoleto';
comment on column T050_RICHIESTEASSENZA.DATA_AUTORIZZAZIONE is 'obsoleto';
comment on column T050_RICHIESTEASSENZA.TIPO_RICHIESTA is 'obsoleto';
comment on column T050_RICHIESTEASSENZA.AUTORIZZ_PREV is 'obsoleto';
comment on column T050_RICHIESTEASSENZA.DATA_AUTORIZZ_PREV is 'obsoleto';
comment on column T050_RICHIESTEASSENZA.ID_REVOCA is 'obsoleto';
comment on column T050_RICHIESTEASSENZA.AUTORIZZ_AUTOMATICA is 'obsoleto';

comment on column T105_RICHIESTETIMBRATURE.AUTORIZZAZIONE is 'obsoleto';
comment on column T105_RICHIESTETIMBRATURE.RESPONSABILE is 'obsoleto';
comment on column T105_RICHIESTETIMBRATURE.NOTE1 is 'obsoleto';
comment on column T105_RICHIESTETIMBRATURE.NOTE2 is 'obsoleto';
comment on column T105_RICHIESTETIMBRATURE.DATA_RICHIESTA is 'obsoleto';
comment on column T105_RICHIESTETIMBRATURE.DATA_AUTORIZZAZIONE is 'obsoleto';
comment on column T105_RICHIESTETIMBRATURE.AUTORIZZ_AUTOMATICA is 'obsoleto';
comment on column T105_RICHIESTETIMBRATURE.CAUSALE_RICH is 'obsoleto';

comment on column T085_RICHIESTECAMBIORARI.DATA_RICHIESTA is 'obsoleto'; 
comment on column T085_RICHIESTECAMBIORARI.TIPO_RICHIESTA is 'obsoleto';
comment on column T085_RICHIESTECAMBIORARI.NOTE_RICHIESTA is 'obsoleto';
comment on column T085_RICHIESTECAMBIORARI.AUTORIZZAZIONE is 'obsoleto';
comment on column T085_RICHIESTECAMBIORARI.RESPONSABILE is 'obsoleto';
comment on column T085_RICHIESTECAMBIORARI.DATA_AUTORIZZAZIONE is 'obsoleto';
comment on column T085_RICHIESTECAMBIORARI.NOTE_AUTORIZ is 'obsoleto';

comment on column T065_RICHIESTESTRAORDINARI.STATO is 'obsoleto';
comment on column T065_RICHIESTESTRAORDINARI.DATA_RICHIESTA is 'obsoleto';
comment on column T065_RICHIESTESTRAORDINARI.NOTE_RICHIESTA is 'obsoleto'; 
comment on column T065_RICHIESTESTRAORDINARI.RESPONSABILE is 'obsoleto'; 
comment on column T065_RICHIESTESTRAORDINARI.DATA_AUTORIZZAZIONE is 'obsoleto';
comment on column T065_RICHIESTESTRAORDINARI.NOTE_AUTORIZ is 'obsoleto';
comment on column T065_RICHIESTESTRAORDINARI.VALIDATORE is 'obsoleto';
comment on column T065_RICHIESTESTRAORDINARI.DATA_VALIDAZIONE is 'obsoleto';
comment on column T065_RICHIESTESTRAORDINARI.NOTE_VALID is 'obsoleto';
comment on column T065_RICHIESTESTRAORDINARI.ORE_ECCED_AUTORIZ is 'obsoleto';
comment on column T065_RICHIESTESTRAORDINARI.ORE_COMP_AUTORIZ is 'obsoleto';
comment on column T065_RICHIESTESTRAORDINARI.ORE_LIQ_AUTORIZ is 'obsoleto'; 
comment on column T065_RICHIESTESTRAORDINARI.ORE_ECCED_VALID is 'obsoleto';  
comment on column T065_RICHIESTESTRAORDINARI.ORE_COMP_VALID is 'obsoleto';  
comment on column T065_RICHIESTESTRAORDINARI.ORE_LIQ_VALID is 'obsoleto';

comment on column T325_RICHIESTESTR_GG.STATO is 'obsoleto';
comment on column T325_RICHIESTESTR_GG.DATA_RICHIESTA is 'obsoleto';
comment on column T325_RICHIESTESTR_GG.NOTE1 is 'obsoleto';
comment on column T325_RICHIESTESTR_GG.NOTE2 is 'obsoleto';
comment on column T325_RICHIESTESTR_GG.RESPONSABILE is 'obsoleto';
comment on column T325_RICHIESTESTR_GG.DATA_AUTORIZZAZIONE is 'obsoleto';
comment on column T326_RICHIESTESTR_SPEZ.AUTORIZZAZIONE is 'obsoleto';

-- ITER T050 --
--creazione dati di base
insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
select AZIENDA, 'DEFAULT', 'T050', 'DEFAULT', 1, 'F' from MONDOEDP.I090_ENTI;

insert into MONDOEDP.I093_BASE_ITER_AUT (AZIENDA, ITER, REVOCABILE) 
select I090.AZIENDA, 'T050', decode(I091.DATO,'S','S','N') 
from MONDOEDP.I090_ENTI I090, MONDOEDP.I091_DATIENTE I091
where I090.AZIENDA = I091.AZIENDA(+)
and I091.TIPO(+) = 'C90_T050REVOCHE';
  
--creazione cod.iter DEFAULT
insert into MONDOEDP.I095_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, FILTRO_RICHIESTA, CONDIZ_AUTORIZZ_AUTOMATICA, MAX_LIV_AUTORIZZ_AUTOMATICA) 
select 
  AZIENDA, 'T050', 'DEFAULT', null, 
  decode(I090.AZIENDA,'RAVDA','decode(:TIPOGIUST,''D'',:DAL + OREMINUTI(:NUMEROORE)/1440,:DAL) < sysdate or :TIPOGIUST = ''I''',null), 
  decode(I090.AZIENDA,'RAVDA',1,-1)
from MONDOEDP.I090_ENTI I090;

--creazione livelli per cod.iter DEFAULT
insert into MONDOEDP.I096_LIVELLI_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, LIVELLO, OBBLIGATORIO, AVVISO, VALORI_POSSIBILI, AUTORIZZ_INTERMEDIA, DATI_MODIFICABILI, INVIO_EMAIL) 
select AZIENDA, 'T050', 'DEFAULT', 1, 'S', null, decode(I090.AZIENDA,'RAVDA','X,N','S,N'), decode(I090.AZIENDA,'RAVDA','X',null), 'N', 'N'
from MONDOEDP.I090_ENTI I090;

insert into MONDOEDP.I096_LIVELLI_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, LIVELLO, OBBLIGATORIO, AVVISO, VALORI_POSSIBILI, AUTORIZZ_INTERMEDIA, DATI_MODIFICABILI, INVIO_EMAIL) 
select AZIENDA, 'T050', 'DEFAULT', 2, 'S', null, 'S,N', null, 'N', 'N'
from MONDOEDP.I090_ENTI I090 where AZIENDA = 'RAVDA';

update MONDOEDP.I096_LIVELLI_ITER_AUT I096
  set INVIO_EMAIL = 
    (select nvl(decode(I091A.DATO,'S',decode(I091B.DATO,'S','E','R'),decode(I091B.DATO,'S','A','N')),'N')
        from MONDOEDP.I091_DATIENTE I091A, MONDOEDP.I091_DATIENTE I091B
        where I091A.AZIENDA = I096.AZIENDA and I091A.TIPO = 'C90_EMAIL_W010DIP'
        and I091B.AZIENDA = I091A.AZIENDA and I091B.TIPO = 'C90_EMAIL_W010RESP')
where ITER = 'T050';

insert into MONDOEDP.I097_VALIDITA_ITER_AUT 
  (AZIENDA,ITER,COD_ITER,NUM_CONDIZ,CONDIZ_VALIDITA,MESSAGGIO)
select 
  AZIENDA,'T050','DEFAULT',1,'trunc(sysdate) - :DAL <= '||max(WEB_ITERASS_GGPREC),'''Il periodo non può essere antecedente ai '||max(WEB_ITERASS_GGPREC)||' giorni.'''
from MONDOEDP.I071_PERMESSI where WEB_ITERASS_GGPREC >= 0 group by AZIENDA;

insert into MONDOEDP.I097_VALIDITA_ITER_AUT 
  (AZIENDA,ITER,COD_ITER,NUM_CONDIZ,CONDIZ_VALIDITA,MESSAGGIO)
select 
  AZIENDA,'T050','DEFAULT',2,':AL - trunc(sysdate) <= '||max(WEB_ITERASS_GGSUCC),'''Il periodo non può essere successivo ai '||max(WEB_ITERASS_GGSUCC)||' giorni.'''
from MONDOEDP.I071_PERMESSI where WEB_ITERASS_GGSUCC >= 0 group by AZIENDA;

--conversione richieste
declare 
  w_username varchar2(30);
begin
  select username into w_username from user_users;

  --inserimento richieste
  insert into T850_ITER_RICHIESTE (ITER,COD_ITER,ID,DATA,NOTE,TIPO_RICHIESTA,AUTORIZZ_AUTOMATICA,ID_REVOCA,ID_REVOCATO,STATO)
  select 'T050','DEFAULT',T050A.ID,T050A.DATA_RICHIESTA,T050A.NOTE1,T050A.TIPO_RICHIESTA,T050A.AUTORIZZ_AUTOMATICA,T050A.ID_REVOCA,T050B.ID ID_REVOCATO,T050A.AUTORIZZAZIONE
  from T050_RICHIESTEASSENZA T050A, T050_RICHIESTEASSENZA T050B
  where T050A.ID is not null
  and T050A.ID = T050B.ID_REVOCA(+);

  --inserimento autorizzazioni
  if w_username = 'RAVDA' then
    --inserimento autorizzazioni preventive  già esistenti (di 1 livello)
    insert into T851_ITER_AUTORIZZAZIONI (ID,LIVELLO,DATA,RESPONSABILE,NOTE,STATO)
    select T050A.ID,1,T050A.DATA_AUTORIZZ_PREV,T050A.RESPONSABILE,T050A.NOTE2,decode(T050A.AUTORIZZ_PREV,'S',decode(TIPO_RICHIESTA,'P','X','S'),T050A.AUTORIZZ_PREV)
    from T050_RICHIESTEASSENZA T050A
    where T050A.ID is not null
    and AUTORIZZ_PREV is not null;
    --inserimento autorizzazioni automatiche di 1 livello (subito definitive)
    insert into T851_ITER_AUTORIZZAZIONI (ID,LIVELLO,DATA,RESPONSABILE,NOTE,STATO,AUTORIZZ_AUTOMATICA)
    select T050A.ID,1,null,'(automatico)',null,'S','S'
    from T050_RICHIESTEASSENZA T050A
    where T050A.ID is not null
    and AUTORIZZ_PREV is null 
    and TIPO_RICHIESTA <> 'P';
    --valorizzazione autorizz_automatica al livello 0 per le richieste nate subito definitive
    update T850_ITER_RICHIESTE T850
    set AUTORIZZ_AUTOMATICA = 'S'
    where ITER = 'T050' and exists (select ID from T851_ITER_AUTORIZZAZIONI where ID = T850.ID and LIVELLO = 1 and AUTORIZZ_AUTOMATICA = 'S');
    --valorizzazione stato al livello 0 per le richieste negate al 1 livello (preventive)
    update T850_ITER_RICHIESTE T850
    set STATO = 'N'
    where ITER = 'T050' and STATO is null and exists (select ID from T851_ITER_AUTORIZZAZIONI where ID = T850.ID and LIVELLO = 1 and STATO = 'N');
    --inserimento autorizzazioni  già esistenti (di 2 livello se esiste autorizz_prev)
    insert into T851_ITER_AUTORIZZAZIONI (ID,LIVELLO,DATA,RESPONSABILE,NOTE,STATO)
    select T050A.ID,2,T050A.DATA_AUTORIZZAZIONE,T050A.RESPONSABILE,T050A.NOTE2,T050A.AUTORIZZAZIONE
    from T050_RICHIESTEASSENZA T050A
    where T050A.ID is not null
    and (T050A.AUTORIZZAZIONE is not null or T050A.NOTE2 is not null);
  else
    insert into T851_ITER_AUTORIZZAZIONI (ID,LIVELLO,DATA,RESPONSABILE,NOTE,STATO)
    select T050A.ID,1,T050A.DATA_AUTORIZZAZIONE,T050A.RESPONSABILE,T050A.NOTE2,T050A.AUTORIZZAZIONE
    from T050_RICHIESTEASSENZA T050A
    where T050A.ID is not null
    and (T050A.AUTORIZZAZIONE is not null or T050A.NOTE2 is not null);
  end if;
end;  
/

-- ITER T105 --
--creazione dati di base
insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
select AZIENDA, 'DEFAULT', 'T105', 'DEFAULT', 1, 'F' from MONDOEDP.I090_ENTI;

insert into MONDOEDP.I093_BASE_ITER_AUT (AZIENDA, ITER, REVOCABILE) 
select I090.AZIENDA, 'T105', 'N' from MONDOEDP.I090_ENTI I090;
  
--creazione cod.iter DEFAULT
insert into MONDOEDP.I095_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, FILTRO_RICHIESTA, CONDIZ_AUTORIZZ_AUTOMATICA, MAX_LIV_AUTORIZZ_AUTOMATICA) 
select 
  I090.AZIENDA, 'T105', 'DEFAULT', null, 
  decode(I091.DATO,'S','(:OPERAZIONE = ''M'') and (:VERSO <> :VERSO_ORIG) and (nvl(:CAUSALE,'' '') = nvl(:CAUSALE_ORIG,'' ''))',null), 
  -1
from MONDOEDP.I090_ENTI I090, MONDOEDP.I091_DATIENTE I091
where I090.AZIENDA = I091.AZIENDA(+)
and I091.TIPO(+) = 'C90_W018AUTORIZZAUTO_VERSO';

--creazione livelli per cod.iter DEFAULT
insert into MONDOEDP.I096_LIVELLI_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, LIVELLO, OBBLIGATORIO, AVVISO, VALORI_POSSIBILI, AUTORIZZ_INTERMEDIA, DATI_MODIFICABILI, INVIO_EMAIL) 
select AZIENDA, 'T105', 'DEFAULT', 1, 'S', null, 'S,N', null, 'S', 'N'
from MONDOEDP.I090_ENTI I090;

update MONDOEDP.I096_LIVELLI_ITER_AUT I096
  set INVIO_EMAIL = 
    (select nvl(decode(I091A.DATO,'S',decode(I091B.DATO,'S','E','R'),decode(I091B.DATO,'S','A','N')),'N')
        from MONDOEDP.I091_DATIENTE I091A, MONDOEDP.I091_DATIENTE I091B
        where I091A.AZIENDA = I096.AZIENDA and I091A.TIPO = 'C90_EMAIL_W018DIP'
        and I091B.AZIENDA = I091A.AZIENDA and I091B.TIPO = 'C90_EMAIL_W018RESP')
where ITER = 'T105';

insert into MONDOEDP.I097_VALIDITA_ITER_AUT 
  (AZIENDA,ITER,COD_ITER,NUM_CONDIZ,CONDIZ_VALIDITA,MESSAGGIO)
select 
  AZIENDA,'T105','DEFAULT',1,'trunc(sysdate) - :DATA <= '||max(WEB_ITERTIMB_GGPREC),'''La data non può essere antecedente ai '||max(WEB_ITERTIMB_GGPREC)||' giorni.'''
from MONDOEDP.I071_PERMESSI where WEB_ITERTIMB_GGPREC >= 0 group by AZIENDA;

--Solo per MILANO_HSACCO
/*
insert into MONDOEDP.I097_VALIDITA_ITER_AUT 
  (AZIENDA,ITER,COD_ITER,NUM_CONDIZ,CONDIZ_VALIDITA,MESSAGGIO)
select 
  AZIENDA,'T105','DEFAULT',2,'3 > (select count(distinct DATA) TOT from T105_RICHIESTETIMBRATURE where PROGRESSIVO = :PROGRESSIVO and trunc(DATA,''MM'') = trunc(:DATA,''MM'') and :DATA <> DATA and OPERAZIONE = ''I'')','Non si possono inserire timbrature per più di di 3 giorni nell''arco del mese.'
from MONDOEDP.I090_ENTI;
*/

--conversione richieste
--inserimento richieste
insert into T850_ITER_RICHIESTE (ITER,COD_ITER,ID,DATA,NOTE,TIPO_RICHIESTA,AUTORIZZ_AUTOMATICA,ID_REVOCA,ID_REVOCATO,STATO)
select 'T105','DEFAULT',T105.ID,T105.DATA_RICHIESTA,T105.NOTE1,'D',T105.AUTORIZZ_AUTOMATICA,null,null,T105.AUTORIZZAZIONE
from T105_RICHIESTETIMBRATURE T105;

--inserimento autorizzazioni
insert into T851_ITER_AUTORIZZAZIONI (ID,LIVELLO,DATA,RESPONSABILE,NOTE,STATO)
select T105.ID,1,T105.DATA_AUTORIZZAZIONE,T105.RESPONSABILE,T105.NOTE2,T105.AUTORIZZAZIONE
from T105_RICHIESTETIMBRATURE T105
where (T105.AUTORIZZAZIONE is not null or T105.NOTE2 is not null);

-- ITER T085 --
--creazione dati di base
insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
select AZIENDA, 'DEFAULT', 'T085', 'DEFAULT', 1, 'F' from MONDOEDP.I090_ENTI;

insert into MONDOEDP.I093_BASE_ITER_AUT (AZIENDA, ITER, REVOCABILE) 
select I090.AZIENDA, 'T085', 'N' from MONDOEDP.I090_ENTI I090;
  
--creazione cod.iter DEFAULT
insert into MONDOEDP.I095_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, FILTRO_RICHIESTA, CONDIZ_AUTORIZZ_AUTOMATICA, MAX_LIV_AUTORIZZ_AUTOMATICA) 
select 
  I090.AZIENDA, 'T085', 'DEFAULT', null, null, -1 from MONDOEDP.I090_ENTI I090;

--creazione livelli per cod.iter DEFAULT
insert into MONDOEDP.I096_LIVELLI_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, LIVELLO, OBBLIGATORIO, AVVISO, VALORI_POSSIBILI, AUTORIZZ_INTERMEDIA, DATI_MODIFICABILI, INVIO_EMAIL) 
select AZIENDA, 'T085', 'DEFAULT', 1, 'S', null, 'S,N', null, 'S', 'N'
from MONDOEDP.I090_ENTI I090;

--conversione richieste
--inserimento richieste
insert into T850_ITER_RICHIESTE (ITER,COD_ITER,ID,DATA,NOTE,TIPO_RICHIESTA,AUTORIZZ_AUTOMATICA,ID_REVOCA,ID_REVOCATO,STATO)
select 'T085','DEFAULT',T085.ID,T085.DATA_RICHIESTA,T085.NOTE_RICHIESTA,T085.TIPO_RICHIESTA,null,null,null,T085.AUTORIZZAZIONE
from T085_RICHIESTECAMBIORARI T085;

--inserimento autorizzazioni
insert into T851_ITER_AUTORIZZAZIONI (ID,LIVELLO,DATA,RESPONSABILE,NOTE,STATO)
select T085.ID,1,T085.DATA_AUTORIZZAZIONE,T085.RESPONSABILE,T085.NOTE_AUTORIZ,T085.AUTORIZZAZIONE
from T085_RICHIESTECAMBIORARI T085 where (T085.AUTORIZZAZIONE is not null or T085.NOTE_AUTORIZ is not null);

-- ITER T065 --
--creazione dati di base
insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
select AZIENDA, 'DEFAULT', 'T065', 'DEFAULT', 1, 'F' from MONDOEDP.I090_ENTI;

insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
select AZIENDA, 'DEFAULT', 'T065', 'VALIDAZIONE', 1, 'F' 
from MONDOEDP.I090_ENTI where AZIENDA = 'RAVDA';
insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
select AZIENDA, 'DEFAULT', 'T065', 'VALIDAZIONE', 2, 'F' 
from MONDOEDP.I090_ENTI where AZIENDA = 'RAVDA';

insert into MONDOEDP.I093_BASE_ITER_AUT (AZIENDA, ITER, REVOCABILE) 
select I090.AZIENDA, 'T065', 'N' from MONDOEDP.I090_ENTI I090;
  
--creazione cod.iter DEFAULT
insert into MONDOEDP.I095_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, FILTRO_RICHIESTA, CONDIZ_AUTORIZZ_AUTOMATICA, MAX_LIV_AUTORIZZ_AUTOMATICA) 
select 
  I090.AZIENDA, 'T065', 'DEFAULT', null, null, -1 from MONDOEDP.I090_ENTI I090;

insert into MONDOEDP.I095_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, FILTRO_RICHIESTA, CONDIZ_AUTORIZZ_AUTOMATICA, MAX_LIV_AUTORIZZ_AUTOMATICA) 
select 
  I090.AZIENDA, 'T065', 'VALIDAZIONE', 'USR_T065F_VALIDAZIONE(:PROGRESSIVO,:DATA) = ''S''', null, -1 
from MONDOEDP.I090_ENTI I090 where AZIENDA = 'RAVDA';

--creazione livelli per cod.iter DEFAULT
insert into MONDOEDP.I096_LIVELLI_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, LIVELLO, OBBLIGATORIO, AVVISO, VALORI_POSSIBILI, AUTORIZZ_INTERMEDIA, DATI_MODIFICABILI, INVIO_EMAIL, CONDIZ_AUTORIZZ_AUTOMATICA, FASE) 
select AZIENDA, 'T065', 'DEFAULT', 1, 'S', null, 'S', null, 'S', 'N','oreminuti(:ORE_ECCEDENTI) = 0', 2
from MONDOEDP.I090_ENTI I090;

insert into MONDOEDP.I096_LIVELLI_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, LIVELLO, OBBLIGATORIO, AVVISO, VALORI_POSSIBILI, AUTORIZZ_INTERMEDIA, DATI_MODIFICABILI, INVIO_EMAIL, FASE) 
select AZIENDA, 'T065', 'VALIDAZIONE', 1, 'N', null, 'S', null, 'S', 'N', 1
from MONDOEDP.I090_ENTI I090 where AZIENDA = 'RAVDA';

insert into MONDOEDP.I096_LIVELLI_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, LIVELLO, OBBLIGATORIO, AVVISO, VALORI_POSSIBILI, AUTORIZZ_INTERMEDIA, DATI_MODIFICABILI, INVIO_EMAIL, CONDIZ_AUTORIZZ_AUTOMATICA, FASE) 
select AZIENDA, 'T065', 'VALIDAZIONE', 2, 'S', null, 'S', null, 'S', 'N','oreminuti(:ORE_ECCEDENTI) = 0', 2
from MONDOEDP.I090_ENTI I090 where AZIENDA = 'RAVDA';

--conversione richieste
DECLARE
  cursor ct065 is select * from t065_richiestestraordinari order by data_richiesta;
  VALIDAZIONE VARCHAR2(1);
BEGIN
  for t1 in ct065 loop
    VALIDAZIONE:='N';
/*
    if :AZIENDA = 'RAVDA' then
      BEGIN
        SELECT NVL(VALIDAZ_STRAORD,'N')
        INTO VALIDAZIONE
        FROM T430_STORICO
        WHERE PROGRESSIVO = T1.PROGRESSIVO
        AND LAST_DAY(T1.DATA) BETWEEN DATADECORRENZA AND DATAFINE;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          VALIDAZIONE:='N';
      END;
    end if;
*/
    --inserimento richieste
    insert into T850_ITER_RICHIESTE (ITER,COD_ITER,ID,DATA,NOTE,TIPO_RICHIESTA,AUTORIZZ_AUTOMATICA,ID_REVOCA,ID_REVOCATO,STATO)
    values ('T065',decode(VALIDAZIONE,'S','VALIDAZIONE','DEFAULT'),T1.ID,T1.DATA_RICHIESTA,T1.NOTE_RICHIESTA,T1.STATO,decode(T1.NOTE_AUTORIZ,'AUTORIZZAZIONE AUTOMATICA: ZERO ORE RICHIESTE','S',null),null,null,decode(T1.STATO,'S','S',null));
    --inserimento validazioni (sempre a livello 1)
    if T1.VALIDATORE is not null or T1.NOTE_VALID is not null then
      insert into T851_ITER_AUTORIZZAZIONI (ID,LIVELLO,DATA,RESPONSABILE,NOTE,STATO)
      values (T1.ID,1,T1.DATA_VALIDAZIONE,T1.VALIDATORE,T1.NOTE_VALID,'S');
      insert into T852_ITER_DATI_AUTORIZZATORI (ID,LIVELLO,DATO,VALORE,DATA)
      values (T1.ID,1,'ORE_ECCEDENTI',T1.ORE_ECCED_VALID,T1.DATA_VALIDAZIONE);
      insert into T852_ITER_DATI_AUTORIZZATORI (ID,LIVELLO,DATO,VALORE,DATA)
      values (T1.ID,1,'ORE_DACOMPENSARE',T1.ORE_COMP_VALID,T1.DATA_VALIDAZIONE);
      insert into T852_ITER_DATI_AUTORIZZATORI (ID,LIVELLO,DATO,VALORE,DATA)
      values (T1.ID,1,'ORE_DALIQUIDARE',T1.ORE_LIQ_VALID,T1.DATA_VALIDAZIONE);
    end if;
    --inserimento autorizzazioni
    if T1.RESPONSABILE is not null then
      insert into T851_ITER_AUTORIZZAZIONI (ID,LIVELLO,DATA,RESPONSABILE,NOTE,STATO,AUTORIZZ_AUTOMATICA)
      values (T1.ID,decode(VALIDAZIONE,'S',2,1),T1.DATA_AUTORIZZAZIONE,T1.RESPONSABILE,T1.NOTE_AUTORIZ,decode(T1.STATO,'S','S',null),decode(T1.NOTE_AUTORIZ,'AUTORIZZAZIONE AUTOMATICA: ZERO ORE RICHIESTE','S',null));
      insert into T852_ITER_DATI_AUTORIZZATORI (ID,LIVELLO,DATO,VALORE,DATA)
      values (T1.ID,decode(VALIDAZIONE,'S',2,1),'ORE_ECCEDENTI',T1.ORE_ECCED_AUTORIZ,T1.DATA_AUTORIZZAZIONE);
      insert into T852_ITER_DATI_AUTORIZZATORI (ID,LIVELLO,DATO,VALORE,DATA)
      values (T1.ID,decode(VALIDAZIONE,'S',2,1),'ORE_DACOMPENSARE',T1.ORE_COMP_AUTORIZ,T1.DATA_AUTORIZZAZIONE);
      insert into T852_ITER_DATI_AUTORIZZATORI (ID,LIVELLO,DATO,VALORE,DATA)
      values (T1.ID,decode(VALIDAZIONE,'S',2,1),'ORE_DALIQUIDARE',T1.ORE_LIQ_AUTORIZ,T1.DATA_AUTORIZZAZIONE);
    end if;
    commit;
  end loop;
END;
/

-- ITER M140 --
--creazione dati di base
insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
select AZIENDA, 'DEFAULT', 'M140', 'DEFAULT', 1, 'F' from MONDOEDP.I090_ENTI;

insert into MONDOEDP.I093_BASE_ITER_AUT (AZIENDA, ITER, REVOCABILE) 
select I090.AZIENDA, 'M140', 'N' from MONDOEDP.I090_ENTI I090;
  
--creazione cod.iter DEFAULT
insert into MONDOEDP.I095_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, FILTRO_RICHIESTA, CONDIZ_AUTORIZZ_AUTOMATICA, MAX_LIV_AUTORIZZ_AUTOMATICA) 
select 
  I090.AZIENDA, 'M140', 'DEFAULT', null, null, -1
from MONDOEDP.I090_ENTI I090;

--creazione livelli per cod.iter DEFAULT
insert into MONDOEDP.I096_LIVELLI_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, LIVELLO, OBBLIGATORIO, AVVISO, VALORI_POSSIBILI, AUTORIZZ_INTERMEDIA, DATI_MODIFICABILI, INVIO_EMAIL) 
select AZIENDA, 'M140', 'DEFAULT', 1, 'S', null, 'S,N', null, 'N', 'N'
from MONDOEDP.I090_ENTI I090;

-- ITER T325 --
--creazione dati di base
insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
select AZIENDA, 'DEFAULT', 'T325', 'DEFAULT', 1, 'F' from MONDOEDP.I090_ENTI;

insert into MONDOEDP.I093_BASE_ITER_AUT (AZIENDA, ITER, REVOCABILE) 
select I090.AZIENDA, 'T325', 'N' from MONDOEDP.I090_ENTI I090;
  
--creazione cod.iter DEFAULT
insert into MONDOEDP.I095_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, FILTRO_RICHIESTA, CONDIZ_AUTORIZZ_AUTOMATICA, MAX_LIV_AUTORIZZ_AUTOMATICA) 
select 
  I090.AZIENDA, 'T325', 'DEFAULT', null, null, -1 from MONDOEDP.I090_ENTI I090;

--creazione livelli per cod.iter DEFAULT
insert into MONDOEDP.I096_LIVELLI_ITER_AUT 
  (AZIENDA, ITER, COD_ITER, LIVELLO, OBBLIGATORIO, AVVISO, VALORI_POSSIBILI, AUTORIZZ_INTERMEDIA, DATI_MODIFICABILI, INVIO_EMAIL) 
select AZIENDA, 'T325', 'DEFAULT', 1, 'S', null, 'S,N', null, 'S', 'N'
from MONDOEDP.I090_ENTI I090;


--creo iter autorizzativi per i filtri funzioni degli autorizzatori...
declare
  cursor ci073 is
    select distinct profilo
    from mondoedp.i073_filtrofunzioni a
    where azienda = :AZIENDA
    and inibizione in ('R','S')
    and tag in (407,419,427,431,433,437,441);
begin
  for ri073 in ci073 loop
    --ITER_GIUSTIF
    insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
    select azienda, ri073.profilo, 'T050', 'DEFAULT', 1, DECODE(inibizione,'S','F','R','F',inibizione) 
    from mondoedp.i073_filtrofunzioni where azienda = :AZIENDA and profilo = ri073.profilo and tag = 407;
    --ITER_TIMBR
    insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
    select azienda, ri073.profilo, 'T105', 'DEFAULT', 1, DECODE(inibizione,'S','F','R','F',inibizione) 
    from mondoedp.i073_filtrofunzioni where azienda = :AZIENDA and profilo = ri073.profilo and tag = 419;
    --ITER_ORARIGG
    insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
    select azienda, ri073.profilo, 'T085', 'DEFAULT', 1, DECODE(inibizione,'S','F','R','F',inibizione) 
    from mondoedp.i073_filtrofunzioni where azienda = :AZIENDA and profilo = ri073.profilo and tag = 431;
    --ITER_STRMESE
    insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
    select azienda, ri073.profilo, 'T065', 'DEFAULT', 1, DECODE(inibizione,'S','F','R','F',inibizione) 
    from mondoedp.i073_filtrofunzioni where azienda = :AZIENDA and profilo = ri073.profilo and tag = 427;
    insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
    select azienda, ri073.profilo, 'T065', 'VALIDAZIONE', 1, DECODE(inibizione,'S','F','R','F',inibizione) 
    from mondoedp.i073_filtrofunzioni where azienda = :AZIENDA and azienda = 'RAVDA' and profilo = ri073.profilo and tag = 437;
    insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
    select azienda, ri073.profilo, 'T065', 'VALIDAZIONE', 2, DECODE(inibizione,'S','F','R','F',inibizione) 
    from mondoedp.i073_filtrofunzioni where azienda = :AZIENDA and azienda = 'RAVDA' and profilo = ri073.profilo and tag = 427;
    --ITER_MISSIONI
    insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
    select azienda, ri073.profilo, 'M140', 'DEFAULT', 1, DECODE(inibizione,'S','F','R','F',inibizione) 
    from mondoedp.i073_filtrofunzioni where azienda = :AZIENDA and profilo = ri073.profilo and tag = 441;
    --ITER_STRGIORNO
    insert into MONDOEDP.I075_ITER_AUTORIZZATIVI (AZIENDA, PROFILO, ITER, COD_ITER, LIVELLO, ACCESSO) 
    select azienda, ri073.profilo, 'T325', 'DEFAULT', 1, DECODE(inibizione,'S','F','R','F',inibizione) 
    from mondoedp.i073_filtrofunzioni where azienda = :AZIENDA and profilo = ri073.profilo and tag = 433;
    --ASSEGNO ITER
    update mondoedp.i061_profili_dipendente 
    set iter_autorizzativi = filtro_funzioni
    where azienda = :AZIENDA
    and filtro_funzioni = ri073.profilo;
  end loop;
end;
/

--abilito la funzione di autorizzazione ai validatori
update mondoedp.i073_filtrofunzioni a
set inibizione = 'S'
where azienda = :AZIENDA
and tag = 427
and exists (select 1 from mondoedp.i073_filtrofunzioni b 
            where a.azienda = b.azienda
            and a.profilo = b.profilo
            and a.applicazione = b.applicazione
            and b.tag = 437
            and b.inibizione = 'S');

/*Fine iter autorizzativi multipli*/

alter table sg095_provvedimentodett modify valore_prec varchar2(200);
alter table sg095_provvedimentodett modify valore_succ varchar2(200);

alter table T080_PIANIFORARI add MOTIVAZIONE varchar2(2);
comment on column T080_PIANIFORARI.MOTIVAZIONE is 'identificativo del motivo della pianificazione. NO=Esigenze personali: usa pianif. Non Operativa';

alter table T911_DATIRIEPILOGO modify FORMATO varchar2(2000);

alter table T914_SERBATOIFILTRO add DATO_DALAL varchar2(40);
comment on column T914_SERBATOIFILTRO.DATO_DALAL is 'Dato da usare nel filtro Dal..Al se esistono più possibilità';

create table M013_SOGLIE_RIMBORSIPASTO
(
  CODICE          varchar2(80),
  TIPO_MISSIONE   varchar2(5),
  DECORRENZA      date,
  DECORRENZA_FINE date,
  SOGLIA_GG       varchar2(5),
  RIMBORSO_MAX    number(10,2)
)
tablespace LAVORO storage (initial 64K next 256K pctincrease 0);

alter table M013_SOGLIE_RIMBORSIPASTO
  add constraint M013_PK primary key (CODICE, TIPO_MISSIONE, DECORRENZA, SOGLIA_GG) using index tablespace INDICI storage (initial 64K next 256K pctincrease 0);

DECLARE 
  CURSOR C1 IS
    SELECT M010.CODICE, M010.TIPO_MISSIONE, M010.DECORRENZA, M010S.DECORRENZA - 1 SCADENZA, M010.ORERIMBORSOPASTO , M010.TARIFFARIMBORSOPASTO, 
           M010.ORERIMBORSOPASTO2, M010.TARIFFARIMBORSOPASTO2, M010.ROWID
      FROM M010_PARAMETRICONTEGGIO M010, M010_PARAMETRICONTEGGIO M010S
     WHERE M010.CODRIMBORSOPASTO IS NOT NULL
       and M010S.CODICE = M010.CODICE
       and M010S.TIPO_MISSIONE = M010.TIPO_MISSIONE
       and M010S.DECORRENZA = (select min(DECORRENZA) from M010_PARAMETRICONTEGGIO where CODICE = M010.CODICE and TIPO_MISSIONE = M010.TIPO_MISSIONE and DECORRENZA > M010.DECORRENZA)
    union   
    SELECT M010.CODICE, M010.TIPO_MISSIONE, M010.DECORRENZA, to_date('31123999','ddmmyyyy') SCADENZA, M010.ORERIMBORSOPASTO , M010.TARIFFARIMBORSOPASTO, 
           M010.ORERIMBORSOPASTO2, M010.TARIFFARIMBORSOPASTO2, M010.ROWID
      FROM M010_PARAMETRICONTEGGIO M010
     WHERE M010.CODRIMBORSOPASTO IS NOT NULL
       and M010.DECORRENZA = (select max(DECORRENZA) from M010_PARAMETRICONTEGGIO where CODICE = M010.CODICE and TIPO_MISSIONE = M010.TIPO_MISSIONE)
     ORDER BY CODICE, TIPO_MISSIONE, DECORRENZA;
BEGIN
  FOR T1 IN C1 LOOP        
      IF T1.TARIFFARIMBORSOPASTO IS NOT NULL THEN
        INSERT INTO M013_SOGLIE_RIMBORSIPASTO(CODICE,TIPO_MISSIONE,DECORRENZA,DECORRENZA_FINE,SOGLIA_GG,RIMBORSO_MAX)
        VALUES(T1.CODICE,T1.TIPO_MISSIONE,T1.DECORRENZA,T1.SCADENZA,T1.ORERIMBORSOPASTO,T1.TARIFFARIMBORSOPASTO);
      END IF;
      
      IF T1.TARIFFARIMBORSOPASTO2 IS NOT NULL THEN 
        INSERT INTO M013_SOGLIE_RIMBORSIPASTO(CODICE,TIPO_MISSIONE,DECORRENZA,DECORRENZA_FINE,SOGLIA_GG,RIMBORSO_MAX)
        VALUES(T1.CODICE,T1.TIPO_MISSIONE,T1.DECORRENZA,T1.SCADENZA,T1.ORERIMBORSOPASTO2,T1.TARIFFARIMBORSOPASTO2);      
      END IF;
      
      update M010_PARAMETRICONTEGGIO set 
        ORERIMBORSOPASTO = null,
        ORERIMBORSOPASTO2 = null,
        TARIFFARIMBORSOPASTO = null,
        TARIFFARIMBORSOPASTO2 = null
      where ROWID = T1.ROWID;
  END LOOP;
END;
/

create table M025_MOTIVAZIONI (
  CODICE                varchar2(5) not null,
  DESCRIZIONE           varchar2(200),
  CATEGORIA             varchar2(5)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column M025_MOTIVAZIONI.CODICE
  is 'Codice della motivazione';
comment on column M025_MOTIVAZIONI.DESCRIZIONE
  is 'Descrizione della motivazione';
comment on column M025_MOTIVAZIONI.CATEGORIA
  is 'Codice interno della categoria della motivazione';
  
alter table M025_MOTIVAZIONI 
  add constraint M025_PK primary key (CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table M140_RICHIESTE_MISSIONI (
  ID                     number(38) not null,
  PROTOCOLLO             varchar2(10),
  TIPOREGISTRAZIONE      varchar2(5),
  PROGRESSIVO            number(8) not null,
  FLAG_DESTINAZIONE      varchar2(1) default 'R' not null,
  FLAG_ISPETTIVA         varchar2(1) default 'N' not null,
  LOCALITA               varchar2(200) not null,
  DATADA                 date not null,
  DATAA                  date not null,
  ORADA                  varchar2(5) not null,
  ORAA                   varchar2(5) not null,
  MOTIVAZIONI            varchar2(2000),
  PROGETTO_EUROPEO       varchar2(2000),
  FLAG_TIPOACCREDITO     varchar2(1),
  DELEGATO               varchar2(100),
  ANNULLAMENTO           varchar2(40)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column M140_RICHIESTE_MISSIONI.ID 
  is 'Identificativo univoco della richiesta';
comment on column M140_RICHIESTE_MISSIONI.PROTOCOLLO
  is 'Numero di protocollo della richiesta';
comment on column M140_RICHIESTE_MISSIONI.TIPOREGISTRAZIONE
  is 'Codice della tipologia di trasferta';
comment on column M140_RICHIESTE_MISSIONI.PROGRESSIVO 
  is 'Progressivo del dipendente che ha effettuato la richiesta';
comment on column M140_RICHIESTE_MISSIONI.FLAG_DESTINAZIONE
  is 'R=Missione effettuata all''interno della regione,I=Missione effettuata in Italia fuori dalla regione,E=Missione effettuata all''estero';
comment on column M140_RICHIESTE_MISSIONI.FLAG_ISPETTIVA 
  is 'S=Missione ispettiva,N=Missione non ispettiva';
comment on column M140_RICHIESTE_MISSIONI.LOCALITA
  is 'Luogo di destinazione della trasferta';
comment on column M140_RICHIESTE_MISSIONI.DATADA
  is 'Data di inizio della missione';
comment on column M140_RICHIESTE_MISSIONI.DATAA
  is 'Data di fine della missione';
comment on column M140_RICHIESTE_MISSIONI.ORADA
  is 'Ora di inizio della missione';
comment on column M140_RICHIESTE_MISSIONI.ORAA
  is 'Ora di fine della missione';
comment on column M140_RICHIESTE_MISSIONI.MOTIVAZIONI
  is 'Motivazioni della missione';
comment on column M140_RICHIESTE_MISSIONI.PROGETTO_EUROPEO
  is 'Progetto per il quale si sta effettuando la trasferta';  
comment on column M140_RICHIESTE_MISSIONI.FLAG_TIPOACCREDITO 
  is '1=accredito su c/c/b oppure c/c/p 2=assegno bancario non trasf.';
comment on column M140_RICHIESTE_MISSIONI.DELEGATO 
  is 'Matricola del delegato per la riscossione dell''anticipo. Può essere valorizzato solo se FLAG_TIPOACCREDITO = 2';
comment on column M140_RICHIESTE_MISSIONI.ANNULLAMENTO
  is 'Motivazioni dell''annullamento della richiesta (valori proposti da tabella T106_MOTIVAZIONIRICHIESTE)';

alter table M140_RICHIESTE_MISSIONI 
  add constraint M140_PK primary key (ID)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create index M140_PROG
  on M140_RICHIESTE_MISSIONI (PROGRESSIVO) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create sequence M140_PROTOCOLLO
  minvalue 1
  maxvalue 999999999999999999999999999
  start with 1
  increment by 1
  nocache;

create table M170_RICHIESTE_MEZZI (
  ID                    number(38) not null,
  CODICE                varchar2(5) not null,
  MOTIVAZIONE           varchar2(2000),
  TARGA                 varchar2(15),
  CORRESPONSIONE_SPESE  varchar2(1) default 'N'
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column M170_RICHIESTE_MEZZI.ID 
  is 'Identificativo della richiesta di riferimento';
comment on column M170_RICHIESTE_MEZZI.CODICE
  is 'Codice del mezzo di trasporto';
comment on column M170_RICHIESTE_MEZZI.MOTIVAZIONE
  is 'Eventuale motivazione richiesta per alcuni codici';
comment on column M170_RICHIESTE_MEZZI.TARGA
  is 'Targa del proprio automezzo';
comment on column M170_RICHIESTE_MEZZI.CORRESPONSIONE_SPESE
  is 'Significativo solo se il relativo CODICE su M020 ha TARGA = ''S''. S=Richiesta corresponsione spese di viaggio,N=Spese viaggio non richieste';

alter table M170_RICHIESTE_MEZZI 
  add constraint M170_PK primary key (ID,CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
  
alter table M170_RICHIESTE_MEZZI
  add constraint M170_FK_M140 foreign key (ID)
  references M140_RICHIESTE_MISSIONI (ID)
  on delete cascade;
  
alter table M170_RICHIESTE_MEZZI
  add constraint M170_FK_M020 foreign key (CODICE)
  references M020_TIPIRIMBORSI (CODICE);

create table M175_RICHIESTE_MOTIVAZIONI (
  ID                    number(38) not null,
  CODICE                varchar2(5) not null
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column M175_RICHIESTE_MOTIVAZIONI.ID 
  is 'Identificativo della richiesta di riferimento';
comment on column M175_RICHIESTE_MOTIVAZIONI.CODICE
  is 'Codice della motivazione per la trasferta estera';
  
alter table M175_RICHIESTE_MOTIVAZIONI 
  add constraint M175_PK primary key (ID,CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
  
alter table M175_RICHIESTE_MOTIVAZIONI
  add constraint M175_FK_M140 foreign key (ID)
  references M140_RICHIESTE_MISSIONI (ID)
  on delete cascade;
  
alter table M175_RICHIESTE_MOTIVAZIONI
  add constraint M175_FK_M025 foreign key (CODICE)
  references M025_MOTIVAZIONI (CODICE);  

alter table M020_TIPIRIMBORSI add TIPO_QUANTITA varchar2(1) default 'I';
comment on column M020_TIPIRIMBORSI.TIPO_QUANTITA
  is 'Tipo di quantità per richieste di anticipo/rimborso. Q=Espressa in numero di unità,I=Espressa in valuta,F=Espressa in flag di tipo 0/1';

alter table M020_TIPIRIMBORSI add PERC_ANTICIPO number(5,2);
comment on column M020_TIPIRIMBORSI.PERC_ANTICIPO
  is 'Percentuale di anticipo';
  
alter table M020_TIPIRIMBORSI add NOTE_FISSE varchar2(500);
comment on column M020_TIPIRIMBORSI.NOTE_FISSE
  is 'Note fisse da proporre in fase di richiesta anticipo/rimborso';
  
alter table M020_TIPIRIMBORSI add TIPO varchar2(5);
comment on column M020_TIPIRIMBORSI.TIPO
  is 'Codice interno per identificare tipologie di rimborsi. Valori ammessi: PASTO=pasto,MEZZO=mezzo di trasporto,PEDAG=pedaggio autostradale';

update M020_TIPIRIMBORSI set TIPO = 'PASTO' where CODICE in (select CODRIMBORSOPASTO from M010_PARAMETRICONTEGGIO where CODRIMBORSOPASTO is not null);

alter table M020_TIPIRIMBORSI add FLAG_MOTIVAZIONE varchar2(1) default 'N';
comment on column M020_TIPIRIMBORSI.FLAG_MOTIVAZIONE
  is 'Significativo solo se TIPO = ''MEZZO''. S=La voce richiede una motivazione,N=La voce non prevede una motivazione';

alter table M020_TIPIRIMBORSI add FLAG_TARGA varchar2(1) default 'N';
comment on column M020_TIPIRIMBORSI.FLAG_TARGA
  is 'Significativo solo se TIPO = ''MEZZO''. S=Richiede l''indicazione della targa,N=Non richiede l''indicazione della targa';

create table M160_RICHIESTE_ANTICIPI (
  ID                    number(38) not null,
  CODICE                varchar2(5) not null,
  QUANTITA              number,
  NOTE                  varchar2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column M160_RICHIESTE_ANTICIPI.ID
  is 'Identificativo univoco della richiesta di riferimento';
comment on column M160_RICHIESTE_ANTICIPI.CODICE
  is 'Codice dell''anticipo richiesto';
comment on column M160_RICHIESTE_ANTICIPI.QUANTITA
  is 'Quantita richiesta';
comment on column M160_RICHIESTE_ANTICIPI.NOTE
  is 'Eventuali note';

alter table M160_RICHIESTE_ANTICIPI 
  add constraint M160_PK primary key (ID,CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
  
alter table M160_RICHIESTE_ANTICIPI
  add constraint M160_FK_M140 foreign key (ID)
  references M140_RICHIESTE_MISSIONI (ID)
  on delete cascade;
  
alter table M160_RICHIESTE_ANTICIPI
  add constraint M160_FK_M020 foreign key (CODICE)
  references M020_TIPIRIMBORSI (CODICE);  

create table M150_RICHIESTE_RIMBORSI (
  ID                             number(38),
  INDENNITA_KM                   varchar2(1),
  CODICE                         varchar2(5),
  KMPERCORSI                     number,
  KMPERCORSI_VARIATO             number, 
  COD_VALUTA                     varchar2(10),
  COSTO                          number,
  RIMBORSO                       number,
  RIMBORSO_VARIATO               number,
  NOTE                           varchar2(2000),
  STATO                          varchar2(1),
  FILE_ALLEGATO                  varchar2(200),
  DATA_RIMBORSO                  date
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column M150_RICHIESTE_RIMBORSI.ID
  is 'Identificativo univoco della richiesta di riferimento';
comment on column M150_RICHIESTE_RIMBORSI.INDENNITA_KM
  is 'S=La voce riguarda un''indennità chilometrica,N=La voce riguarda un rimborso';
comment on column M150_RICHIESTE_RIMBORSI.CODICE
  is 'Se INDENNITA_KM = S rappresenta il codice dell''indennità km (M021), altrimenti rappresenta il codice del rimborso (M020)';
comment on column M150_RICHIESTE_RIMBORSI.KMPERCORSI
  is 'Indica il numero di km percorsi. Significativo se INDENNITA_KM = S';
comment on column M150_RICHIESTE_RIMBORSI.KMPERCORSI_VARIATO
  is 'Numero di km percorsi eventualmente variato dall''ufficio rimborsi';
comment on column M150_RICHIESTE_RIMBORSI.COD_VALUTA
  is 'Codice della valuta in cui sono espressi i valori di questo record';
comment on column M150_RICHIESTE_RIMBORSI.RIMBORSO
  is 'Importo del rimborso al netto degli anticipi';
comment on column M150_RICHIESTE_RIMBORSI.RIMBORSO_VARIATO
  is 'Importo del rimborso eventualmente variato dall''ufficio rimborsi';    
comment on column M150_RICHIESTE_RIMBORSI.NOTE
  is 'Note eventualmente impostate dall''ufficio rimborsi';      
comment on column M150_RICHIESTE_RIMBORSI.STATO
  is 'N=Non autorizzato, A=Autorizzato, S=Elaborato sulla M050';
comment on column M150_RICHIESTE_RIMBORSI.FILE_ALLEGATO
  is 'Non usato (percorso completo del file contenente la scansione del giustificativo di spesa allegato)';
comment on column M150_RICHIESTE_RIMBORSI.DATA_RIMBORSO
  is 'Data di riferimento per il rimborso';
  
alter table M150_RICHIESTE_RIMBORSI 
  add constraint M150_PK primary key (ID, INDENNITA_KM, CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
 
alter table M150_RICHIESTE_RIMBORSI
  add constraint M150_FK_M140 foreign key (ID)
  references M140_RICHIESTE_MISSIONI (ID) 
  on delete cascade;

drop table M012_DECOD_TIPIMISSIONE/*--NOLOG--*/;
create table M012_DECOD_TIPIMISSIONE (
  REGOLA        VARCHAR2(80),
  ESTERO        VARCHAR2(1),
  ISPETTIVA     VARCHAR2(1),
  TIPO_MISSIONE VARCHAR2(5) 
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table M012_DECOD_TIPIMISSIONE 
  add constraint M012_PK primary key (REGOLA, ESTERO, ISPETTIVA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table M050_RIMBORSI add ID_MISSIONE number(8);
comment on column M050_RIMBORSI.ID_MISSIONE
  is 'M140.ID della richiesta di missione di riferimento';
alter table M052_INDENNITAKM add ID_MISSIONE number(8);
comment on column M052_INDENNITAKM.ID_MISSIONE
  is 'M140.ID della richiesta di missione di riferimento';

declare 
  cursor c1 is select distinct ID_MISSIONE from M040_MISSIONI;
  newID number(38);
begin
  update M040_MISSIONI set ID_MISSIONE = -ID_MISSIONE;
  update M060_ANTICIPI set ID_MISSIONE = -ID_MISSIONE;
  for t1 in c1 loop
    select T850_ID.nextval into newID from DUAL;
    update M040_MISSIONI set ID_MISSIONE = newID where ID_MISSIONE = t1.ID_MISSIONE;
    update M060_ANTICIPI set ID_MISSIONE = newID where ID_MISSIONE = t1.ID_MISSIONE;
  end loop;
end;
/

alter table M010_PARAMETRICONTEGGIO add GIUSTIF_HHMAX varchar2(5);
comment on column M010_PARAMETRICONTEGGIO.GIUSTIF_HHMAX is 'Durata oraria massima del giustificativo inserito automaticamente';

alter table M010_PARAMETRICONTEGGIO add GIUSTIF_COPRE_DEBITOGG varchar2(1) default 'N';
comment on column M010_PARAMETRICONTEGGIO.GIUSTIF_COPRE_DEBITOGG is 'N=nessun controllo, S=Il giustificativo automatico dalle..alle se non copre il debito gg viene inserito a giornata intera';

update M010_PARAMETRICONTEGGIO M010
set GIUSTIF_COPRE_DEBITOGG = 'S' 
where exists (select 1 from t265_cauassenze t265 where t265.codice = m010.causale_missione);

delete from MONDOEDP.I091_DATIENTE 
where AZIENDA = :AZIENDA 
and TIPO in ('C90_EMAIL_W010DIP','C90_EMAIL_W010RESP','C90_EMAIL_W018DIP','C90_EMAIL_W018RESP','C90_RICH_GIUST_PREV','C90_T050REVOCHE', 'C90_T050REVOCHE ','C90_W018AUTORIZZAUTO_VERSO','C90_WEBVALIDAZSTRAORD');

comment on column MONDOEDP.I071_PERMESSI.WEB_ITERASS_GGPREC is 'obsoleto';
comment on column MONDOEDP.I071_PERMESSI.WEB_ITERASS_GGSUCC is 'obsoleto';
comment on column MONDOEDP.I071_PERMESSI.WEB_ITERTIMB_GGPREC is 'obsoleto';

comment on column T265_CAUASSENZE.AUTORIZZ_AUTOMATICA_WEB IS 'obsoleto';
alter table T265_CAUASSENZE drop column AUTORIZZ_AUTOMATICA_WEB;/*--NOLOG--*/

comment on column T275_CAUPRESENZE.AUTORIZZ_AUTOMATICA_WEB IS 'obsoleto';
alter table T275_CAUPRESENZE drop column AUTORIZZ_AUTOMATICA_WEB;/*--NOLOG--*/


alter table SG650_TESTATACORSI add CODICE_MINISTERIALE varchar2(15);
alter table SG651_PIANIFICAZIONECORSI add ORA_INIZIO_PAUSA varchar2(5);
alter table SG651_PIANIFICAZIONECORSI add ORA_FINE_PAUSA varchar2(5);

alter table T047_VISITEFISCALI modify INDIRIZZO VARCHAR2(80);
alter table T047_VISITEFISCALI add NOTE varchar2(2000);

update I091_DATIENTE set DATO = '30' where TIPO like 'C90_WEBRIGHEPAG' and DATO is null;