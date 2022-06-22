UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '6.0.7',PATCHDB = 0 WHERE AZIENDA = :AZIENDA;

DROP PROCEDURE ESPORTADIPENDENTE;
DROP TABLE I500EXP;
DROP TABLE T030EXP;
DROP TABLE T430EXP;
DROP TABLE T080EXP;
DROP TABLE T040EXP;
DROP TABLE T100EXP;
DROP TABLE T070EXP;
DROP TABLE T071EXP;
DROP TABLE T072EXP;
DROP TABLE T073EXP;
DROP TABLE T074EXP;
DROP TABLE T075EXP;
DROP TABLE T076EXP;
DROP TABLE T130EXP;
DROP TABLE T131EXP;
DROP TABLE T020EXP;
DROP TABLE T220EXP;
DROP TABLE T221EXP;
DROP TABLE T260EXP;
DROP TABLE T262EXP;
DROP TABLE T263EXP;
DROP TABLE T264EXP;
DROP TABLE T265EXP;
DROP TABLE T270EXP;
DROP TABLE T275EXP;
DROP TABLE T276EXP;
DROP TABLE T277EXP;
DROP TABLE T025EXP;
DROP TABLE T160EXP;
DROP TABLE T162EXP;
DROP TABLE T164EXP;
DROP TABLE T171EXP;
DROP TABLE T350EXP;
DROP TABLE T360EXP;
DROP TABLE T370EXP;
DROP TABLE T380EXP;
DROP TABLE T670EXP;
DROP TABLE T680EXP;
DROP TABLE T690EXP;
DROP TABLE T692EXP;

alter table T265_CAUASSENZE add ABBATTE_STRIND varchar2(1) default 'N';

comment on column P602_770REGOLE.FORMATO_ANNOMESE
  is 'Indica se il campo prevede la sdoppiatura del dato anno/mese o cassa previdenziale su due record (N/S/P)';

delete from MONDOEDP.I073_FILTROFUNZIONI where TAG in (401,412,415) and APPLICAZIONE <> 'FUNWEB';

alter table MONDOEDP.I090_ENTI add TSAUSILIARIO varchar2(20);

alter table T020_ORARI add TIMBRATURAMENSA_INTERNA varchar2(1) default 'N';

--Dati storicizzati-
declare 
  cursor c1 is select NOMECAMPO from I500_DATILIBERI t where STORICO = 'S';
  i integer;
  CURSORE_DINAMICO integer;
  RIS_CURS integer;
  ESPRESSIONE varchar2(1000);
begin
  for t1 in c1 loop
    ESPRESSIONE:='ALTER TABLE I501' || t1.NOMECAMPO ||' ADD DECORRENZA_FINE DATE';
    CURSORE_DINAMICO:=dbms_sql.open_cursor;
    begin
      dbms_sql.parse(CURSORE_DINAMICO,ESPRESSIONE,dbms_sql.native);
      RIS_CURS:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO);
    exception
      when others then null;
    end;
    dbms_sql.close_cursor(CURSORE_DINAMICO);
    ESPRESSIONE:=    
    'update I501'|| t1.NOMECAMPO ||' I501 set' ||
    ' DECORRENZA_FINE = '||
    ' (select min(DECORRENZA) - 1 from I501'|| t1.NOMECAMPO ||' where CODICE = I501.CODICE and DECORRENZA > I501.DECORRENZA)' ||
    ' where '||
    ' DECORRENZA < (select max(DECORRENZA) from I501' || t1.NOMECAMPO ||' where CODICE = I501.CODICE)';
    CURSORE_DINAMICO:=dbms_sql.open_cursor;
    begin
      dbms_sql.parse(CURSORE_DINAMICO,ESPRESSIONE,dbms_sql.native);
      RIS_CURS:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO);
    exception
      when others then null;
    end;
    dbms_sql.close_cursor(CURSORE_DINAMICO);
    ESPRESSIONE:=    
    'update I501' || t1.NOMECAMPO ||' I501 set' ||
    ' DECORRENZA_FINE = TO_DATE(''31123999'',''DDMMYYYY'')' ||
    ' where ' ||
    ' DECORRENZA = (select max(DECORRENZA) from I501'|| t1.NOMECAMPO ||' where CODICE = I501.CODICE)';
    CURSORE_DINAMICO:=dbms_sql.open_cursor;
    begin
      dbms_sql.parse(CURSORE_DINAMICO,ESPRESSIONE,dbms_sql.native);
      RIS_CURS:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO);
    exception
      when others then null;
    end;
    dbms_sql.close_cursor(CURSORE_DINAMICO);
  end loop;
end;
/

alter table T220_PROFILIORARI add DECORRENZA_FINE date;
update T220_PROFILIORARI t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from T220_PROFILIORARI where CODICE = t.CODICE and DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from T220_PROFILIORARI where CODICE = t.CODICE);
update T220_PROFILIORARI t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from T220_PROFILIORARI where CODICE = t.CODICE);

alter table M021_TIPIINDENNITAKM add DECORRENZA_FINE date;
update M021_TIPIINDENNITAKM t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from M021_TIPIINDENNITAKM where CODICE = t.CODICE and DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from M021_TIPIINDENNITAKM where CODICE = t.CODICE);
update M021_TIPIINDENNITAKM t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from M021_TIPIINDENNITAKM where CODICE = t.CODICE);
    
alter table SG650_TESTATACORSI add DECORRENZA_FINE date;
update SG650_TESTATACORSI t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from SG650_TESTATACORSI where CODICE = t.CODICE and DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from SG650_TESTATACORSI where CODICE = t.CODICE);
update SG650_TESTATACORSI t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from SG650_TESTATACORSI where CODICE = t.CODICE);

alter table MONDOEDP.I074_FILTRODIZIONARIO modify CODICE VARCHAR2(40);

ALTER TABLE T430_STORICO MODIFY EDBADGE VARCHAR2(15);

alter index SG650_PK rebuild tablespace INDICI;
alter index SG650_UI rebuild tablespace INDICI;
alter index SG651_PK rebuild tablespace INDICI;
alter index SG655_PK rebuild tablespace INDICI;
alter index SG657_PK rebuild tablespace INDICI;
alter index SG658_PK rebuild tablespace INDICI;
alter index SG659_PK rebuild tablespace INDICI;
alter index SG660_PK rebuild tablespace INDICI;
alter index SG662_PK rebuild tablespace INDICI;
alter index SG663_PK rebuild tablespace INDICI;
alter index SG664_PK rebuild tablespace INDICI;
alter index SG665_PK rebuild tablespace INDICI;
alter index SG666_PK rebuild tablespace INDICI;

--- Sostituzione dei campi LONG con VARCHAR2 ---
--P441_CEDOLINO
create table P441_TEMP (RI varchar2(40),NOTE_TEMP VARCHAR2(2000));
declare
  cursor c1 is select NOTE,rowid from P441_CEDOLINO;
begin
  for t1 in c1 loop
    insert into P441_TEMP (RI,NOTE_TEMP) values (t1.rowid,t1.NOTE);
    commit;
  end loop;
end;
/
update P441_CEDOLINO set NOTE = null;
alter table P441_CEDOLINO modify NOTE VARCHAR2(2000);
declare
  cursor c1 is select NOTE_TEMP,RI from P441_TEMP;
begin
  for t1 in c1 loop
    update P441_CEDOLINO set NOTE = t1.NOTE_TEMP where rowid = t1.RI;
    commit;
  end loop;
end;
/
drop table P441_TEMP;

--P445_CEDOLINOTEMP
create table P445_TEMP (RI varchar2(40),NOTE_TEMP VARCHAR2(2000));
declare
  cursor c1 is select NOTE,rowid from P445_CEDOLINOTEMP;
begin
  for t1 in c1 loop
    insert into P445_TEMP (RI,NOTE_TEMP) values (t1.rowid,t1.NOTE);
    commit;
  end loop;
end;
/
update P445_CEDOLINOTEMP set NOTE = null;
alter table P445_CEDOLINOTEMP modify NOTE VARCHAR2(2000);
declare
  cursor c1 is select NOTE_TEMP,RI from P445_TEMP;
begin
  for t1 in c1 loop
    update P445_CEDOLINOTEMP set NOTE = t1.NOTE_TEMP where rowid = t1.RI;
    commit;
  end loop;
end;
/
drop table P445_TEMP;

--P504_CUDTESTATE
create table P504_TEMP (RI varchar2(40),ANNOTAZIONI_TEMP VARCHAR2(2000));
declare
  cursor c1 is select ANNOTAZIONI,rowid from P504_CUDTESTATE;
begin
  for t1 in c1 loop
    insert into P504_TEMP (RI,ANNOTAZIONI_TEMP) values (t1.rowid,t1.ANNOTAZIONI);
    commit;
  end loop;
end;
/
update P504_CUDTESTATE set ANNOTAZIONI = null;
alter table P504_CUDTESTATE modify ANNOTAZIONI VARCHAR2(2000);
declare
  cursor c1 is select ANNOTAZIONI_TEMP,RI from P504_TEMP;
begin
  for t1 in c1 loop
    update P504_CUDTESTATE set ANNOTAZIONI = t1.ANNOTAZIONI_TEMP where rowid = t1.RI;
    commit;
  end loop;
end;
/
drop table P504_TEMP;

--T900_STAMPABASE
alter table T900_STAMPABASE drop primary key;

create table T901_STAMPABASE_DATI (
  CODICEINTERNO varchar2(6),
  NOMESTAMPA varchar2(10),
  NUMRIGA number(3),
  RIGA VARCHAR2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T901_STAMPABASE_DATI add constraint T901_PK primary key (CODICEINTERNO,NOMESTAMPA,NUMRIGA)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

declare
  cursor c1 is select * from T900_STAMPABASE;
  t1 c1%ROWTYPE;
  i1 integer;
  i2 integer;
  nr integer;
  s varchar2(2000);
begin
  OPEN c1;
  loop
    begin
      FETCH c1 INTO t1;
      exit when c1%NOTFOUND;
      nr:=0;
      i1:=0;
      i2:=instr(t1.settaggi,chr(10));
      if i2 = 0 then
        i2:=length(t1.settaggi);
      end if;
      begin
        loop
          s:=substr(t1.settaggi,i1,i2 - i1);
          insert into T901_STAMPABASE_DATI 
            (CODICEINTERNO,NOMESTAMPA,NUMRIGA,RIGA)
          values
            (T1.CODICEINTERNO,T1.NOMESTAMPA,nr,s);
          if i2 = length(t1.settaggi) then
            exit;
          end if;
          nr:=nr + 1;
          i1:=i2 + 1;
          i2:=i1 - 1 + instr(substr(t1.settaggi,i1,length(t1.settaggi)),chr(10));
          if i2 = 0 then
            i2:=length(t1.settaggi);
          end if;
        end loop;
      exception
        when others then null;
      end; 
      commit;
    exception
      when others then null;
    end;
  end loop;
  close c1;
end;
/

rename T900_STAMPABASE to T900_606;
create table T900_STAMPABASE tablespace LAVORO storage (initial 256K next 256K pctincrease 0) as 
  select CODICEINTERNO,NOMESTAMPA,DESCRIZIONE from T900_606;

alter table T900_STAMPABASE add constraint T900_PK primary key (CODICEINTERNO,NOMESTAMPA)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T901_STAMPABASE_DATI add 
  constraint T901_FK_T900 foreign key (CODICEINTERNO,NOMESTAMPA)
  references T900_STAMPABASE (CODICEINTERNO,NOMESTAMPA) on delete cascade;

--T950_STAMPACARTELLINO
alter table T950_STAMPACARTELLINO drop primary key;

create table T951_STAMPACARTELLINO_DATI (
  CODICE varchar2(5),
  NUMRIGA number(3),
  RIGA VARCHAR2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T951_STAMPACARTELLINO_DATI add constraint T951_PK primary key (CODICE,NUMRIGA)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

declare
  cursor c1 is select * from T950_STAMPACARTELLINO;
  i1 integer;
  i2 integer;
  nr integer;
  s varchar2(2000);
begin
  for t1 in c1 loop
    nr:=0;
    i1:=0;
    i2:=instr(t1.INTESTAZIONE,chr(10));
    if i2 = 0 then
      i2:=length(t1.INTESTAZIONE);
    end if;
    begin
      loop
        s:=substr(t1.INTESTAZIONE,i1,i2 - i1);
        insert into T951_STAMPACARTELLINO_DATI 
          (CODICE,NUMRIGA,RIGA)
        values
          (t1.CODICE,nr,s);
        if i2 = length(t1.INTESTAZIONE) then
          exit;
        end if;
        nr:=nr + 1;
        i1:=i2 + 1;
        i2:=i1 - 1 + instr(substr(t1.INTESTAZIONE,i1,length(t1.INTESTAZIONE)),chr(10));
        if i2 = 0 then
          i2:=length(t1.INTESTAZIONE);
        end if;
      end loop;
    exception
      when others then null;
    end; 
    commit;
  end loop;
end;
/

rename T950_STAMPACARTELLINO to T950_606;
create table T950_STAMPACARTELLINO tablespace LAVORO storage (initial 256K next 256K pctincrease 0) as 
  select 
  codice, 
  descrizione, 
  separarighe, 
  separadati, 
  anomalia, 
  festivo, 
  nonlav, 
  grassetto, 
  ragione_sociale, 
  data_stampa, 
  num_pagine, 
  margine_sup, 
  logo_larghezza, 
  anomalie2, 
  anomalie3, 
  orientamento  
  from T950_606;

alter table T950_STAMPACARTELLINO add constraint T950_PK primary key (CODICE)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T951_STAMPACARTELLINO_DATI add 
  constraint T951_FK_T950 foreign key (CODICE)
  references T950_STAMPACARTELLINO (CODICE) on delete cascade;

alter table T950_STAMPACARTELLINO modify SEPARARIGHE default 'N';
alter table T950_STAMPACARTELLINO modify SEPARADATI default 'N';
alter table T950_STAMPACARTELLINO modify FESTIVO default 'S';
alter table T950_STAMPACARTELLINO modify NONLAV default 'N';
alter table T950_STAMPACARTELLINO modify GRASSETTO default 'N';
alter table T950_STAMPACARTELLINO modify RAGIONE_SOCIALE default 'S';
alter table T950_STAMPACARTELLINO modify NUM_PAGINE default 'S';
alter table T950_STAMPACARTELLINO modify DATA_STAMPA default '"Stampa del" dd/mm/yyyy hh.nn';
alter table T950_STAMPACARTELLINO modify ORIENTAMENTO default 'V';

drop procedure COPIA_CARTELLINO;

--T004_IMMAGINI
alter table T004_IMMAGINI modify IMMAGINE blob;

alter table T004_IMMAGINI drop primary key;

alter table T004_IMMAGINI add constraint T004_PK primary key (TIPO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);


--SG509_DETTAGLIOSTAMPA
alter table SG509_DETTAGLIOSTAMPA drop primary key;

create table SG511_STAMPAVALORI (
  CODICE_STAMPA varchar2(10),
  TIPO_CAMPO varchar2(1),
  LIVELLO number,
  NUMRIGA number(8),
  RIGA varchar2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG511_STAMPAVALORI add constraint SG611_PK primary key (CODICE_STAMPA,TIPO_CAMPO,LIVELLO,NUMRIGA)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

declare
  cursor c1 is select * from SG509_DETTAGLIOSTAMPA;
  i1 integer;
  i2 integer;
  nr integer;
  s varchar2(2000);
begin
  for t1 in c1 loop
    nr:=0;
    i1:=1;

    begin 
      loop
        s:=substr(t1.valori,i1,2000);
        if s is not null then
          insert into SG511_STAMPAVALORI 
            (CODICE_STAMPA,TIPO_CAMPO,LIVELLO,NUMRIGA,RIGA)
          values
            (t1.CODICE_STAMPA,t1.TIPO_CAMPO,t1.LIVELLO,nr,s);
        end if;
        i1:=i1 + 2000;
        if (s is null) or (i1 > length(t1.valori)) then
          exit;
        end if;
        nr:=nr + 1;
      end loop;
    exception
      when others then null;
    end; 
    commit;
  end loop;
end;
/

rename SG509_DETTAGLIOSTAMPA to SG509_606;
create table SG509_DETTAGLIOSTAMPA
(
  CODICE_STAMPA      VARCHAR2(10) not null,
  ID_PIANTA          NUMBER not null,
  ID_RAMO            NUMBER not null,
  ID_PADRE           NUMBER not null,
  NOME_CAMPO         VARCHAR2(20) not null,
  DESCRIZIONE_STAMPA VARCHAR2(20),
  LIVELLO            NUMBER not null,
  TIPO_CAMPO         VARCHAR2(1) not null,
  FLAG_STAMPA        VARCHAR2(1) default 'N' not null,
  DIMENSIONE_CAMPO   NUMBER default 0 not null,
  FLAG_TOTALIZZA     VARCHAR2(1) default 'N' not null,
  FONT_STYLE         VARCHAR2(30),
  FONT_NAME          VARCHAR2(30),
  FONT_SIZE          NUMBER(2),
  FONT_COLOR         NUMBER,
  TABULAZIONE        NUMBER default 0 not null,
  FLAG_SALTOPAGINA   VARCHAR2(1) default 'N' not null
)
tablespace LAVORO storage (initial 256K next 256k pctincrease 0);
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG509_DETTAGLIOSTAMPA
  add constraint SG509_PK primary key (CODICE_STAMPA, TIPO_CAMPO, LIVELLO)
  using index tablespace INDICI storage (initial 256K next 256k pctincrease 0);

insert into SG509_DETTAGLIOSTAMPA
  select CODICE_STAMPA, ID_PIANTA, ID_RAMO, ID_PADRE, NOME_CAMPO, DESCRIZIONE_STAMPA, LIVELLO, TIPO_CAMPO, FLAG_STAMPA, DIMENSIONE_CAMPO, FLAG_TOTALIZZA, FONT_STYLE, FONT_NAME, FONT_SIZE,  FONT_COLOR, TABULAZIONE, FLAG_SALTOPAGINA
  from SG509_606;

insert into MONDOEDP.I070_UTENTI 
  (AZIENDA,UTENTE,PROGRESSIVO,PASSWD,OCCUPATO,SBLOCCO,PERMESSI,FILTRO_FUNZIONI)
select 'AZIN','MONDOEDP',MAX(T2.PROGRESSIVO) + 1,'4F4A5952515D','N','S',MAX(T1.PERMESSI),MAX(T1.FILTRO_FUNZIONI)
from MONDOEDP.I070_UTENTI T1, MONDOEDP.I070_UTENTI T2
where T1.UTENTE = 'SYSMAN' and T2.AZIENDA = 'AZIN';

insert into T002_QUERYPERSONALIZZATE (NOME,POSIZ,RIGA)
values ('_T030_T430',0,'SELECT *');
insert into T002_QUERYPERSONALIZZATE (NOME,POSIZ,RIGA)
values ('_T030_T430',1,'FROM T030_ANAGRAFICO T030, T430_STORICO T430');
insert into T002_QUERYPERSONALIZZATE (NOME,POSIZ,RIGA)
values ('_T030_T430',2,'WHERE T030.PROGRESSIVO = T430.PROGRESSIVO');
insert into T002_QUERYPERSONALIZZATE (NOME,POSIZ,RIGA)
values ('_T030_T430',3,'AND T030.MATRICOLA LIKE ''%'' || :MATRICOLA || ''%''');
insert into T002_QUERYPERSONALIZZATE (NOME,POSIZ,RIGA)
values ('_T030_T430',4,'AND NVL(T030.COGNOME,'' '') LIKE ''%'' || :XCOGNOME || ''%''');
insert into T002_QUERYPERSONALIZZATE (NOME,POSIZ,RIGA)
values ('_T030_T430',5,'AND NVL(T030.NOME,'' '') LIKE ''%'' || :XNOME || ''%''');
insert into T002_QUERYPERSONALIZZATE (NOME,POSIZ,RIGA)
values ('_T030_T430',6,'AND NVL(TO_CHAR(T430.BADGE),'' '') LIKE ''%'' || :XBADGE || ''%''');
insert into T002_QUERYPERSONALIZZATE (NOME,POSIZ,RIGA)
values ('_T030_T430',7,'ORDER BY T030.MATRICOLA, T430.DATADECORRENZA');

drop view VSG664_DOCENTIFORMAZIONE;

alter table T305_CAUGIUSTIF add ABBATTE_ECC_GIORN varchar2(1) default 'N';

-- CONTO ANNUALE
create table P552_CONTOANNREGOLE
(
  ANNO                      NUMBER(4) not null,
  COD_TABELLA               VARCHAR2(10) not null,
  RIGA                      NUMBER(3) not null,
  COLONNA                   NUMBER(3) not null,
  DESCRIZIONE               VARCHAR2(200),
  TIPO_TABELLA_RIGHE        VARCHAR2(1),
  COD_ARROTONDAMENTO        VARCHAR2(5),
  VALORE_COSTANTE           VARCHAR2(100),
  CODICI_ACCORPAMENTOVOCI   VARCHAR2(50),
  REGOLA_CALCOLO_AUTOMATICA VARCHAR2(1500),
  REGOLA_CALCOLO_MANUALE    VARCHAR2(1500),
  REGOLA_MODIFICABILE       VARCHAR2(1) default 'S',
  NUMERO_TREDCORR           VARCHAR2(15),
  NUMERO_TREDPREC           VARCHAR2(15),
  NUMERO_ARRCORR            VARCHAR2(15),
  NUMERO_ARRPREC            VARCHAR2(15),
  DATA_ACCORPAMENTO         VARCHAR2(2) default 'NA'
)
tablespace LAVORO
  storage
  (initial 256K next 256K pctincrease 0);
 
comment on column P552_CONTOANNREGOLE.TIPO_TABELLA_RIGHE
  is 'Tipologia righe tabella: 0=Qualifica ministeriale, 1=Altro dato libero, 2=Accorpamento voci';
comment on column P552_CONTOANNREGOLE.COD_ARROTONDAMENTO
  is 'Codice arrotondamento';
comment on column P552_CONTOANNREGOLE.VALORE_COSTANTE
  is 'Nome del dato libero per testata / codice della riga / parametro per query su colonna';
comment on column P552_CONTOANNREGOLE.CODICI_ACCORPAMENTOVOCI
  is 'Accorpamento voci se la Tipologia righe tabella = Accorpamento voci';
comment on column P552_CONTOANNREGOLE.REGOLA_CALCOLO_AUTOMATICA
  is 'Query per estrazione dato prevista di default';
comment on column P552_CONTOANNREGOLE.REGOLA_CALCOLO_MANUALE
  is 'Query per estrazione dato modificata dall''utente';
comment on column P552_CONTOANNREGOLE.REGOLA_MODIFICABILE
  is 'Query per estrazione dato modificabile dall''utente';
comment on column P552_CONTOANNREGOLE.NUMERO_TREDCORR
  is 'Codice tabella e numero della riga o colonna sostitutiva in caso di tredicesima anno corrente; gestire ''Non conteggiare''';
comment on column P552_CONTOANNREGOLE.NUMERO_TREDPREC
  is 'Codice tabella e numero della riga o colonna sostitutiva in caso di tredicesima anno precedente; gestire ''Non conteggiare''';
comment on column P552_CONTOANNREGOLE.NUMERO_ARRCORR
  is 'Codice tabella e numero della riga o colonna sostitutiva in caso di arretrati anno corrente; gestire ''Non conteggiare''';
comment on column P552_CONTOANNREGOLE.NUMERO_ARRPREC
  is 'Codice tabella e numero della riga o colonna sostitutiva in caso di arretrati anno precedente; gestire ''Non conteggiare''';
comment on column P552_CONTOANNREGOLE.DATA_ACCORPAMENTO
  is 'Modalità di accorpamento: NA=nessun accorpamento; DC=data cedolino; DR=data retribuzione; CM=data competenza';
 
alter table P552_CONTOANNREGOLE
  add constraint P552_PK primary key (ANNO, COD_TABELLA, RIGA, COLONNA)
  using index 
  tablespace INDICI
  storage
  (initial 256K next 256K pctincrease 0);

create table P554_CONTOANNTESTATE
(
  ANNO          NUMBER(4) not null,
  COD_TABELLA   VARCHAR2(10) not null,
  ID_CONTOANN   NUMBER not null,
  CHIUSO        VARCHAR2(1) default 'N',
  DATA_CHIUSURA DATE
)
tablespace LAVORO
  storage
  (initial 256K next 256K pctincrease 0);
 
comment on column P554_CONTOANNTESTATE.CHIUSO
  is 'Chiuso (S/N)';
comment on column P554_CONTOANNTESTATE.DATA_CHIUSURA
  is 'Data chiusura della tabella del conto annuale: impostata alla data del sistema';
 
alter table P554_CONTOANNTESTATE
  add constraint P554_PK primary key (ID_CONTOANN)
  using index 
  tablespace INDICI
  storage
  (initial 256K next 256K pctincrease 0);
 
create table P555_CONTOANNDATIINDIVIDUALI
(
  ID_CONTOANN NUMBER not null,
  PROGRESSIVO NUMBER not null,
  RIGA        NUMBER(3) not null,
  COLONNA     NUMBER(3) not null,
  VALORE      NUMBER
)
tablespace LAVORO
  storage
  (initial 256K next 256K pctincrease 0);

alter table P555_CONTOANNDATIINDIVIDUALI
  add constraint P555_PK primary key (ID_CONTOANN, PROGRESSIVO, RIGA, COLONNA)
  using index 
  tablespace INDICI
  storage
  (initial 256K next 256K pctincrease 0);
alter table P555_CONTOANNDATIINDIVIDUALI
  add constraint P555_FK_P554 foreign key (ID_CONTOANN)
  references P554_CONTOANNTESTATE (ID_CONTOANN) on delete cascade;

create sequence P555_ID_CONTOANN
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

comment on column P040_PARTTIME.TIPO
  is 'Tipo part-time: O=Orizzontale; V=Verticale; C=Ciclico';

UPDATE T292_PARMESSAGGIDATI SET VALORE_DEFAULT = 'SALDOTOT' 
WHERE VALORE_DEFAULT = 'SALDOAACOR' AND TIPO = 'VL';
UPDATE T292_PARMESSAGGIDATI SET VALORE_DEFAULT = 'SALDOTOTNEG' 
WHERE VALORE_DEFAULT = 'SALDOAANEG' AND TIPO = 'VL';

create index SG506_IDX_PERCORSO on SG506_PIANTADISTRIBUZIONE (PERCORSO)
  tablespace INDICI
  storage
  (initial 256K next 256K pctincrease 0);

UPDATE T020_ORARI SET FLAGPRES=' ' WHERE MMINDPRES IS NOT NULL AND (FLAGPRES = 'N' OR FLAGPRES IS NULL);

drop index MONDOEDP.I060_IDX_UTENTE;
alter table MONDOEDP.I060_LOGIN_DIPENDENTE drop primary key;
alter table MONDOEDP.I060_LOGIN_DIPENDENTE add constraint I060_PK primary key (AZIENDA,NOME_UTENTE)
using index tablespace INDICI storage (initial 265k next 265k pctincrease 0);

alter table T025_CONTMENSILI add BANCA_ORE_ABBATTIBILE varchar2(1) default 'N';

alter table T760_REGOLEINCENTIVI modify ASSENZE VARCHAR2(2000);

alter table P090_CODICIINPS add DECORRENZA_FINE date;
update P090_CODICIINPS t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from P090_CODICIINPS where COD_CODICEINPS = t.COD_CODICEINPS and DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from P090_CODICIINPS where COD_CODICEINPS = t.COD_CODICEINPS);
update P090_CODICIINPS t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from P090_CODICIINPS where COD_CODICEINPS = t.COD_CODICEINPS);


alter table P092_CODICIINAIL add DECORRENZA_FINE date;
update P092_CODICIINAIL t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from P092_CODICIINAIL where COD_CODICEINAIL = t.COD_CODICEINAIL and DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from P092_CODICIINAIL where COD_CODICEINAIL = t.COD_CODICEINAIL);
update P092_CODICIINAIL t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from P092_CODICIINAIL where COD_CODICEINAIL = t.COD_CODICEINAIL);


alter table P094_INQUADRINPDAP add DECORRENZA_FINE date;
update P094_INQUADRINPDAP t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from P094_INQUADRINPDAP where COD_INQUADRINPDAP = t.COD_INQUADRINPDAP and DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from P094_INQUADRINPDAP where COD_INQUADRINPDAP = t.COD_INQUADRINPDAP);
update P094_INQUADRINPDAP t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from P094_INQUADRINPDAP where COD_INQUADRINPDAP = t.COD_INQUADRINPDAP);

alter table P096_INQUADRINPS add DECORRENZA_FINE date;
update P096_INQUADRINPS t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from P096_INQUADRINPS where COD_INQUADRINPS = t.COD_INQUADRINPS and DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from P096_INQUADRINPS where COD_INQUADRINPS = t.COD_INQUADRINPS);
update P096_INQUADRINPS t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from P096_INQUADRINPS where COD_INQUADRINPS = t.COD_INQUADRINPS);

alter table P210_CONTRATTI add DECORRENZA_FINE date;
update P210_CONTRATTI t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from P210_CONTRATTI where COD_CONTRATTO = t.COD_CONTRATTO and DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from P210_CONTRATTI where COD_CONTRATTO = t.COD_CONTRATTO);
update P210_CONTRATTI t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from P210_CONTRATTI where COD_CONTRATTO = t.COD_CONTRATTO);

alter table P212_PARAMETRISTIPENDI add DECORRENZA_FINE date;
update P212_PARAMETRISTIPENDI t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from P212_PARAMETRISTIPENDI where COD_PARAMETRISTIPENDI = t.COD_PARAMETRISTIPENDI and DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from P212_PARAMETRISTIPENDI where COD_PARAMETRISTIPENDI = t.COD_PARAMETRISTIPENDI);
update P212_PARAMETRISTIPENDI t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from P212_PARAMETRISTIPENDI where COD_PARAMETRISTIPENDI = t.COD_PARAMETRISTIPENDI);

alter table P236_TABELLEANF add DECORRENZA_FINE date;
update P236_TABELLEANF t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from P236_TABELLEANF where COD_TABELLAANF = t.COD_TABELLAANF and DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from P236_TABELLEANF where COD_TABELLAANF = t.COD_TABELLAANF);
update P236_TABELLEANF t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from P236_TABELLEANF where COD_TABELLAANF = t.COD_TABELLAANF);

alter table P240_TIPIASSOGGETTAMENTI add DECORRENZA_FINE date;
update P240_TIPIASSOGGETTAMENTI t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from P240_TIPIASSOGGETTAMENTI where COD_TIPOASSOGGETTAMENTO = t.COD_TIPOASSOGGETTAMENTO and DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from P240_TIPIASSOGGETTAMENTI where COD_TIPOASSOGGETTAMENTO = t.COD_TIPOASSOGGETTAMENTO);
update P240_TIPIASSOGGETTAMENTI t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from P240_TIPIASSOGGETTAMENTI where COD_TIPOASSOGGETTAMENTO = t.COD_TIPOASSOGGETTAMENTO);
commit;

-- Create table M060_ANTICIPI --
create table M060_ANTICIPI
(
  PROGRESSIVO             NUMBER not null,
  CASSA                   VARCHAR2(10) not null,
  ANNO_MOVIMENTO          VARCHAR2(4) not null,
  NUM_MOVIMENTO           NUMBER not null,
  COD_VOCE                VARCHAR2(5) not null,
  DATA_MISSIONE           DATE not null,
  DATA_MOVIMENTO          DATE not null,
  QUANTITA                NUMBER,
  IMPORTO                 NUMBER,
  FLAG_TOTALIZZATORE      VARCHAR2(1) default 'S',
  STATO                   VARCHAR2(1) default 'S',
  DATA_IMPOSTAZIONE_STATO DATE,
  NOTE                    VARCHAR2(500)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

-- Add comments to the columns 
comment on column M060_ANTICIPI.FLAG_TOTALIZZATORE
  is 'Valori ammessi S = Si ,N = No';
comment on column M060_ANTICIPI.STATO
  is 'S=sospeso - al momento dell''emissione, P=protocollato - al momento del collegamento ad una trasferta non ancora liquidato, L=liquidato - al momento della liquidazione della trasferta a cui e'' collegato, R= recuperato - non utilizzato in nessuna trasferta e addebitato sul cedolino del dipendente';
-- Create/Recreate primary, unique and foreign key constraints 
alter table M060_ANTICIPI
  add constraint M060_PK primary key (PROGRESSIVO, CASSA, ANNO_MOVIMENTO, NUM_MOVIMENTO, COD_VOCE)
  using index tablespace INDICI storage (initial 256K next 256k pctincrease 0);

-- Alter table M040_MISSIONI --
alter table M040_MISSIONI ADD STATO VARCHAR2(1) default 'D';

-- Alter table M010_PARAMETRICONTEGGIO --
ALTER TABLE M010_PARAMETRICONTEGGIO ADD MAXMESIRIMB NUMBER DEFAULT -1;

-- Add comments to the columns 
comment on column M010_PARAMETRICONTEGGIO.MAXMESIRIMB is 'se -1 non scatta il rimborso'; 

-- Alter table I071_PERMESSI --
ALTER TABLE MONDOEDP.I071_PERMESSI ADD A131_ANTICIPIGESTIBILI VARCHAR2(15);
commit;

ALTER TABLE SG650_TESTATACORSI ADD NOTIFICATO VARCHAR2(1) DEFAULT 'N';
ALTER TABLE SG664_DOCENTI ADD TARIFFA NUMBER;
ALTER TABLE SG664_DOCENTI ADD NOTE VARCHAR2(2000);

ALTER TABLE SG500_DATILIBERI ADD VALORE_DEFAULT VARCHAR2(2000);
