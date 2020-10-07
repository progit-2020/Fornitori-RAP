UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '7.7',PATCHDB = 0 WHERE AZIENDA = :AZIENDA;

alter table T001_PARAMETRIFUNZIONI modify VALORE varchar2(2000);

alter table MONDOEDP.I072_FILTROANAGRAFE modify FILTRO varchar2(2000);

alter table T030_ANAGRAFICO disable all triggers;

UPDATE T030_ANAGRAFICO SET COMUNENAS = '110001' WHERE COMUNENAS = '072005';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '110002' WHERE COMUNENAS = '072007';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '110003' WHERE COMUNENAS = '072009';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '110004' WHERE COMUNENAS = '072013';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '110005' WHERE COMUNENAS = '071030';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '110006' WHERE COMUNENAS = '072026';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '110007' WHERE COMUNENAS = '071045';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '110008' WHERE COMUNENAS = '072042';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '110009' WHERE COMUNENAS = '072045';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '110010' WHERE COMUNENAS = '071057';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109001' WHERE COMUNENAS = '044003';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109002' WHERE COMUNENAS = '044004';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109003' WHERE COMUNENAS = '044008';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109004' WHERE COMUNENAS = '044009';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109005' WHERE COMUNENAS = '044018';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109006' WHERE COMUNENAS = '044019';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109007' WHERE COMUNENAS = '044022';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109008' WHERE COMUNENAS = '044024';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109009' WHERE COMUNENAS = '044025';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109010' WHERE COMUNENAS = '044026';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109011' WHERE COMUNENAS = '044028';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109012' WHERE COMUNENAS = '044030';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109013' WHERE COMUNENAS = '044033';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109014' WHERE COMUNENAS = '044035';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109015' WHERE COMUNENAS = '044037';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109016' WHERE COMUNENAS = '044039';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109017' WHERE COMUNENAS = '044040';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109018' WHERE COMUNENAS = '044041';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109019' WHERE COMUNENAS = '044042';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109020' WHERE COMUNENAS = '044043';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109021' WHERE COMUNENAS = '044046';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109022' WHERE COMUNENAS = '044047';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109023' WHERE COMUNENAS = '044048';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109024' WHERE COMUNENAS = '044049';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109025' WHERE COMUNENAS = '044050';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109026' WHERE COMUNENAS = '044051';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109027' WHERE COMUNENAS = '044052';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109028' WHERE COMUNENAS = '044053';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109029' WHERE COMUNENAS = '044055';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109030' WHERE COMUNENAS = '044057';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109031' WHERE COMUNENAS = '044058';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109032' WHERE COMUNENAS = '044059';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109033' WHERE COMUNENAS = '044060';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109034' WHERE COMUNENAS = '044061';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109035' WHERE COMUNENAS = '044062';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109036' WHERE COMUNENAS = '044067';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109037' WHERE COMUNENAS = '044068';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109038' WHERE COMUNENAS = '044069';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109039' WHERE COMUNENAS = '044070';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '109040' WHERE COMUNENAS = '044072';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108001' WHERE COMUNENAS = '015003';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108002' WHERE COMUNENAS = '015004';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108003' WHERE COMUNENAS = '015006';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108004' WHERE COMUNENAS = '015008';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108005' WHERE COMUNENAS = '015013';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108006' WHERE COMUNENAS = '015017';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108007' WHERE COMUNENAS = '015018';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108008' WHERE COMUNENAS = '015021';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108009' WHERE COMUNENAS = '015023';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108010' WHERE COMUNENAS = '015030';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108011' WHERE COMUNENAS = '015033';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108012' WHERE COMUNENAS = '015034';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108013' WHERE COMUNENAS = '015037';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108014' WHERE COMUNENAS = '015045';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108015' WHERE COMUNENAS = '015048';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108016' WHERE COMUNENAS = '015049';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108017' WHERE COMUNENAS = '015068';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108018' WHERE COMUNENAS = '015069';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108019' WHERE COMUNENAS = '015075';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108020' WHERE COMUNENAS = '015080';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108021' WHERE COMUNENAS = '015084';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108022' WHERE COMUNENAS = '015092';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108023' WHERE COMUNENAS = '015100';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108024' WHERE COMUNENAS = '015107';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108025' WHERE COMUNENAS = '015117';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108026' WHERE COMUNENAS = '015120';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108027' WHERE COMUNENAS = '015121';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108028' WHERE COMUNENAS = '015123';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108029' WHERE COMUNENAS = '015129';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108030' WHERE COMUNENAS = '015138';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108031' WHERE COMUNENAS = '015145';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108032' WHERE COMUNENAS = '015147';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108033' WHERE COMUNENAS = '015149';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108034' WHERE COMUNENAS = '015152';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108035' WHERE COMUNENAS = '015156';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108036' WHERE COMUNENAS = '015161';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108037' WHERE COMUNENAS = '015180';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108038' WHERE COMUNENAS = '015187';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108039' WHERE COMUNENAS = '015208';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108040' WHERE COMUNENAS = '015212';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108041' WHERE COMUNENAS = '015216';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108042' WHERE COMUNENAS = '015217';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108043' WHERE COMUNENAS = '015223';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108044' WHERE COMUNENAS = '015227';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108045' WHERE COMUNENAS = '015231';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108046' WHERE COMUNENAS = '015232';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108047' WHERE COMUNENAS = '015233';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108048' WHERE COMUNENAS = '015234';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108049' WHERE COMUNENAS = '015239';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108050' WHERE COMUNENAS = '015241';

alter table T030_ANAGRAFICO disable all triggers;

UPDATE T430_STORICO SET COMUNE = '110001' WHERE COMUNE = '072005';
UPDATE T430_STORICO SET COMUNE = '110002' WHERE COMUNE = '072007';
UPDATE T430_STORICO SET COMUNE = '110003' WHERE COMUNE = '072009';
UPDATE T430_STORICO SET COMUNE = '110004' WHERE COMUNE = '072013';
UPDATE T430_STORICO SET COMUNE = '110005' WHERE COMUNE = '071030';
UPDATE T430_STORICO SET COMUNE = '110006' WHERE COMUNE = '072026';
UPDATE T430_STORICO SET COMUNE = '110007' WHERE COMUNE = '071045';
UPDATE T430_STORICO SET COMUNE = '110008' WHERE COMUNE = '072042';
UPDATE T430_STORICO SET COMUNE = '110009' WHERE COMUNE = '072045';
UPDATE T430_STORICO SET COMUNE = '110010' WHERE COMUNE = '071057';
UPDATE T430_STORICO SET COMUNE = '109001' WHERE COMUNE = '044003';
UPDATE T430_STORICO SET COMUNE = '109002' WHERE COMUNE = '044004';
UPDATE T430_STORICO SET COMUNE = '109003' WHERE COMUNE = '044008';
UPDATE T430_STORICO SET COMUNE = '109004' WHERE COMUNE = '044009';
UPDATE T430_STORICO SET COMUNE = '109005' WHERE COMUNE = '044018';
UPDATE T430_STORICO SET COMUNE = '109006' WHERE COMUNE = '044019';
UPDATE T430_STORICO SET COMUNE = '109007' WHERE COMUNE = '044022';
UPDATE T430_STORICO SET COMUNE = '109008' WHERE COMUNE = '044024';
UPDATE T430_STORICO SET COMUNE = '109009' WHERE COMUNE = '044025';
UPDATE T430_STORICO SET COMUNE = '109010' WHERE COMUNE = '044026';
UPDATE T430_STORICO SET COMUNE = '109011' WHERE COMUNE = '044028';
UPDATE T430_STORICO SET COMUNE = '109012' WHERE COMUNE = '044030';
UPDATE T430_STORICO SET COMUNE = '109013' WHERE COMUNE = '044033';
UPDATE T430_STORICO SET COMUNE = '109014' WHERE COMUNE = '044035';
UPDATE T430_STORICO SET COMUNE = '109015' WHERE COMUNE = '044037';
UPDATE T430_STORICO SET COMUNE = '109016' WHERE COMUNE = '044039';
UPDATE T430_STORICO SET COMUNE = '109017' WHERE COMUNE = '044040';
UPDATE T430_STORICO SET COMUNE = '109018' WHERE COMUNE = '044041';
UPDATE T430_STORICO SET COMUNE = '109019' WHERE COMUNE = '044042';
UPDATE T430_STORICO SET COMUNE = '109020' WHERE COMUNE = '044043';
UPDATE T430_STORICO SET COMUNE = '109021' WHERE COMUNE = '044046';
UPDATE T430_STORICO SET COMUNE = '109022' WHERE COMUNE = '044047';
UPDATE T430_STORICO SET COMUNE = '109023' WHERE COMUNE = '044048';
UPDATE T430_STORICO SET COMUNE = '109024' WHERE COMUNE = '044049';
UPDATE T430_STORICO SET COMUNE = '109025' WHERE COMUNE = '044050';
UPDATE T430_STORICO SET COMUNE = '109026' WHERE COMUNE = '044051';
UPDATE T430_STORICO SET COMUNE = '109027' WHERE COMUNE = '044052';
UPDATE T430_STORICO SET COMUNE = '109028' WHERE COMUNE = '044053';
UPDATE T430_STORICO SET COMUNE = '109029' WHERE COMUNE = '044055';
UPDATE T430_STORICO SET COMUNE = '109030' WHERE COMUNE = '044057';
UPDATE T430_STORICO SET COMUNE = '109031' WHERE COMUNE = '044058';
UPDATE T430_STORICO SET COMUNE = '109032' WHERE COMUNE = '044059';
UPDATE T430_STORICO SET COMUNE = '109033' WHERE COMUNE = '044060';
UPDATE T430_STORICO SET COMUNE = '109034' WHERE COMUNE = '044061';
UPDATE T430_STORICO SET COMUNE = '109035' WHERE COMUNE = '044062';
UPDATE T430_STORICO SET COMUNE = '109036' WHERE COMUNE = '044067';
UPDATE T430_STORICO SET COMUNE = '109037' WHERE COMUNE = '044068';
UPDATE T430_STORICO SET COMUNE = '109038' WHERE COMUNE = '044069';
UPDATE T430_STORICO SET COMUNE = '109039' WHERE COMUNE = '044070';

UPDATE T430_STORICO SET COMUNE = '109040' WHERE COMUNE = '044072';
UPDATE T430_STORICO SET COMUNE = '108001' WHERE COMUNE = '015003';
UPDATE T430_STORICO SET COMUNE = '108002' WHERE COMUNE = '015004';
UPDATE T430_STORICO SET COMUNE = '108003' WHERE COMUNE = '015006';
UPDATE T430_STORICO SET COMUNE = '108004' WHERE COMUNE = '015008';
UPDATE T430_STORICO SET COMUNE = '108005' WHERE COMUNE = '015013';
UPDATE T430_STORICO SET COMUNE = '108006' WHERE COMUNE = '015017';
UPDATE T430_STORICO SET COMUNE = '108007' WHERE COMUNE = '015018';
UPDATE T430_STORICO SET COMUNE = '108008' WHERE COMUNE = '015021';
UPDATE T430_STORICO SET COMUNE = '108009' WHERE COMUNE = '015023';
UPDATE T430_STORICO SET COMUNE = '108010' WHERE COMUNE = '015030';
UPDATE T430_STORICO SET COMUNE = '108011' WHERE COMUNE = '015033';
UPDATE T430_STORICO SET COMUNE = '108012' WHERE COMUNE = '015034';
UPDATE T430_STORICO SET COMUNE = '108013' WHERE COMUNE = '015037';
UPDATE T430_STORICO SET COMUNE = '108014' WHERE COMUNE = '015045';
UPDATE T430_STORICO SET COMUNE = '108015' WHERE COMUNE = '015048';
UPDATE T430_STORICO SET COMUNE = '108016' WHERE COMUNE = '015049';
UPDATE T430_STORICO SET COMUNE = '108017' WHERE COMUNE = '015068';
UPDATE T430_STORICO SET COMUNE = '108018' WHERE COMUNE = '015069';
UPDATE T430_STORICO SET COMUNE = '108019' WHERE COMUNE = '015075';
UPDATE T430_STORICO SET COMUNE = '108020' WHERE COMUNE = '015080';
UPDATE T430_STORICO SET COMUNE = '108021' WHERE COMUNE = '015084';
UPDATE T430_STORICO SET COMUNE = '108022' WHERE COMUNE = '015092';
UPDATE T430_STORICO SET COMUNE = '108023' WHERE COMUNE = '015100';
UPDATE T430_STORICO SET COMUNE = '108024' WHERE COMUNE = '015107';
UPDATE T430_STORICO SET COMUNE = '108025' WHERE COMUNE = '015117';
UPDATE T430_STORICO SET COMUNE = '108026' WHERE COMUNE = '015120';
UPDATE T430_STORICO SET COMUNE = '108027' WHERE COMUNE = '015121';
UPDATE T430_STORICO SET COMUNE = '108028' WHERE COMUNE = '015123';
UPDATE T430_STORICO SET COMUNE = '108029' WHERE COMUNE = '015129';
UPDATE T430_STORICO SET COMUNE = '108030' WHERE COMUNE = '015138';
UPDATE T430_STORICO SET COMUNE = '108031' WHERE COMUNE = '015145';
UPDATE T430_STORICO SET COMUNE = '108032' WHERE COMUNE = '015147';
UPDATE T430_STORICO SET COMUNE = '108033' WHERE COMUNE = '015149';
UPDATE T430_STORICO SET COMUNE = '108034' WHERE COMUNE = '015152';
UPDATE T430_STORICO SET COMUNE = '108035' WHERE COMUNE = '015156';
UPDATE T430_STORICO SET COMUNE = '108036' WHERE COMUNE = '015161';
UPDATE T430_STORICO SET COMUNE = '108037' WHERE COMUNE = '015180';
UPDATE T430_STORICO SET COMUNE = '108038' WHERE COMUNE = '015187';
UPDATE T430_STORICO SET COMUNE = '108039' WHERE COMUNE = '015208';
UPDATE T430_STORICO SET COMUNE = '108040' WHERE COMUNE = '015212';
UPDATE T430_STORICO SET COMUNE = '108041' WHERE COMUNE = '015216';
UPDATE T430_STORICO SET COMUNE = '108042' WHERE COMUNE = '015217';
UPDATE T430_STORICO SET COMUNE = '108043' WHERE COMUNE = '015223';
UPDATE T430_STORICO SET COMUNE = '108044' WHERE COMUNE = '015227';
UPDATE T430_STORICO SET COMUNE = '108045' WHERE COMUNE = '015231';
UPDATE T430_STORICO SET COMUNE = '108046' WHERE COMUNE = '015232';
UPDATE T430_STORICO SET COMUNE = '108047' WHERE COMUNE = '015233';
UPDATE T430_STORICO SET COMUNE = '108048' WHERE COMUNE = '015234';
UPDATE T430_STORICO SET COMUNE = '108049' WHERE COMUNE = '015239';
UPDATE T430_STORICO SET COMUNE = '108050' WHERE COMUNE = '015241';

UPDATE T480_COMUNI SET PROVINCIA = 'MB', CODICE = '108051' WHERE CODICE = '015039';
UPDATE T480_COMUNI SET PROVINCIA = 'MB', CODICE = '108052' WHERE CODICE = '015047';
UPDATE T480_COMUNI SET PROVINCIA = 'MB', CODICE = '108053' WHERE CODICE = '015088';
UPDATE T480_COMUNI SET PROVINCIA = 'MB', CODICE = '108054' WHERE CODICE = '015119';
UPDATE T480_COMUNI SET PROVINCIA = 'MB', CODICE = '108055' WHERE CODICE = '015186';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108051' WHERE COMUNENAS = '015039';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108052' WHERE COMUNENAS = '015047';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108053' WHERE COMUNENAS = '015088';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108054' WHERE COMUNENAS = '015119';
UPDATE T030_ANAGRAFICO SET COMUNENAS = '108055' WHERE COMUNENAS = '015186';
UPDATE T430_STORICO SET COMUNE = '108051' WHERE COMUNE = '015039';
UPDATE T430_STORICO SET COMUNE = '108052' WHERE COMUNE = '015047';
UPDATE T430_STORICO SET COMUNE = '108053' WHERE COMUNE = '015088';
UPDATE T430_STORICO SET COMUNE = '108054' WHERE COMUNE = '015119';
UPDATE T430_STORICO SET COMUNE = '108055' WHERE COMUNE = '015186';

CREATE TABLE T190_20091023 AS SELECT * FROM T190_INTERFACCIAPAGHE;
UPDATE T190_INTERFACCIAPAGHE SET UM = 'V' WHERE CODINTERNO = '240';
UPDATE T190_INTERFACCIAPAGHE SET UM = 'H' WHERE CODINTERNO = '242';
UPDATE T190_INTERFACCIAPAGHE SET UM = 'V' WHERE CODINTERNO = '244';

comment on column T105_RICHIESTETIMBRATURE.OPERAZIONE is 'Operazione richiesta: I=Inserimento, M=Modifica, C=Cancellazione';

ALTER TABLE T775_QUOTEINDIVIDUALI ADD SOSPENDI_QUOTE VARCHAR2(1) DEFAULT 'N';
comment on column T775_QUOTEINDIVIDUALI.SOSPENDI_QUOTE  is 'Sospendi maturazione quote';

UPDATE T770_QUOTE SET CAUSALE = ' ' WHERE CAUSALE IS NULL;
alter table T770_QUOTE drop primary key;
drop index T770_PK;
alter table T770_QUOTE
  add constraint T770_PK primary key (DATO1, DATO2, DATO3, DECORRENZA, CODTIPOQUOTA, CAUSALE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

CREATE TABLE T775_20091023 AS SELECT * FROM T775_QUOTEINDIVIDUALI;
declare
  cursor c1 is 
     select DISTINCT PROGRESSIVO, DECORRENZA, SCADENZA, SALTAPROVA, PENALIZZAZIONE from T775_QUOTEINDIVIDUALI
     where SALTAPROVA = 'S'
           or PENALIZZAZIONE <> 0;
begin
  for t1 in c1 loop
     INSERT INTO T775_QUOTEINDIVIDUALI (PROGRESSIVO,DECORRENZA,SCADENZA, CODTIPOQUOTA, SALTAPROVA, PENALIZZAZIONE)
     VALUES(T1.PROGRESSIVO, T1.DECORRENZA, T1.SCADENZA, ' ', T1.SALTAPROVA, T1.PENALIZZAZIONE);
     COMMIT;
  end loop;
end;
/

-- Create/Recreate indexes 
create index SG710_I1 on SG710_TESTATA_VALUTAZIONI (PROGRESSIVO)
tablespace INDICI storage (initial 256K next 256K pctincrease 0);

update p090_codiciinps t set t.cod_formeassic='IVS' where t.cod_codiceinps='249';

alter table P670_XMLREGOLE add ATTRIBUTO VARCHAR2(80);
alter table P670_XMLREGOLE add TIPO_IMPORTO VARCHAR2(1);
alter table P670_XMLREGOLE add DATO_RIEPILOGATIVO VARCHAR2(1) default 'N';
alter table P670_XMLREGOLE add DECORRENZA_FINE date;
comment on column P670_XMLREGOLE.ATTRIBUTO
  is 'Eventuale attributo fisso dell''elemento';
comment on column P670_XMLREGOLE.TIPO_IMPORTO
  is 'Tipo importo per totalizzazioni: D=Debito, C=Credito';
comment on column P670_XMLREGOLE.DATO_RIEPILOGATIVO
  is 'Dato riepilogativo aziendale (S/N)';

update p670_xmlregole t
set DECORRENZA_FINE = to_date('31123999','ddmmyyyy')
where T.Decorrenza_Fine is null;

alter table P672_XMLTESTATE add MATRICOLA_INPS VARCHAR2(20);
comment on column P672_XMLTESTATE.MATRICOLA_INPS
  is 'Matricola assegnata dall''INPS all''ente (vuoto se matricola unica per tutti i dipendenti)';

-- Add/modify columns 
alter table T044_STORICOGIUSTIFICATIVI add ID number;
alter table T044_STORICOGIUSTIFICATIVI add ORE_GG_MEDIO number;
-- Add comments to the columns 
comment on column T044_STORICOGIUSTIFICATIVI.ID
  is 'Numero di sequenza del record';
comment on column T044_STORICOGIUSTIFICATIVI.ORE_GG_MEDIO
  is 'Ore trasformate in giorni sulla base del valore medio settimanale';

create sequence T044_ID minvalue 1 start with 1 increment by 1 nocache;
-- Modify the last number 
declare
  cursor c1 is select rowid from t044_storicogiustificativi order by data_agg,data;
  IdVal integer;
begin
  IdVal:=1;
  for t1 in c1 loop
    select T044_ID.nextval into IdVal from dual;
    update t044_storicogiustificativi set id = IdVal where rowid = t1.rowid;
    commit;
  end loop; 
end;
/
-- Add/modify columns 
alter table I020_DATI_ALLINEAMENTO add DECORRENZA date;
-- Add comments to the columns 
comment on column I020_DATI_ALLINEAMENTO.TIPO
  is 'D=Dato storico, R=Relazione anagrafica, A=Trigger su variazione anagrafica';
comment on column I020_DATI_ALLINEAMENTO.DECORRENZA
  is 'Decorrenza della variazione anagrafica da cui operare le variazioni pilotate dal trigger'; 

-- Incarichi
ALTER TABLE SG303_INCINDIVIDUALI ADD DATA_VERIFICA DATE;
ALTER TABLE SG303_INCINDIVIDUALI ADD TIPOATTO_VERIF VARCHAR2(30);
ALTER TABLE SG303_INCINDIVIDUALI ADD AUTORITA_VERIF VARCHAR2(40);
ALTER TABLE SG303_INCINDIVIDUALI ADD NUMATTO_VERIF VARCHAR2(20);
ALTER TABLE SG303_INCINDIVIDUALI ADD DATAATTO_VERIF DATE;
ALTER TABLE SG303_INCINDIVIDUALI ADD DATAESEC_VERIF DATE;
ALTER TABLE SG303_INCINDIVIDUALI ADD COD_TIPOVERIF VARCHAR2(5);
ALTER TABLE SG303_INCINDIVIDUALI ADD ESITO_VERIFICA VARCHAR2(30);
ALTER TABLE SG303_INCINDIVIDUALI ADD NOTE_VERIFICA VARCHAR2(1000);
comment on column SG303_INCINDIVIDUALI.DATA_VERIFICA is 'Data in cui si è svolta la verifica dell''incarico';
comment on column SG303_INCINDIVIDUALI.TIPOATTO_VERIF is 'Tipo atto (delibera o determina) della verifica';
comment on column SG303_INCINDIVIDUALI.AUTORITA_VERIF is 'Autorità atto della verifica';
comment on column SG303_INCINDIVIDUALI.NUMATTO_VERIF is 'Num.atto della verifica';
comment on column SG303_INCINDIVIDUALI.DATAATTO_VERIF is 'Data atto della verifica';
comment on column SG303_INCINDIVIDUALI.DATAESEC_VERIF is 'Data esecutività della verifica';
comment on column SG303_INCINDIVIDUALI.COD_TIPOVERIF is 'Tipologia della verifica (quinquennale, triennale etc.)';
comment on column SG303_INCINDIVIDUALI.ESITO_VERIFICA is 'Esito della verifica (positivo, negativo etc.)';
comment on column SG303_INCINDIVIDUALI.NOTE_VERIFICA is 'Note della verifica';
create table SG308_INCINDENNITA
( PROGRESSIVO           NUMBER not null,
  DATA_VERIFICA         DATE not null,
  COD_TIPOVERIF         VARCHAR2(5) not null,
  DECORRENZA_IND    DATE,
  TIPOATTO                   VARCHAR2(30),
  AUTORITA                   VARCHAR2(40),
  NUMATTO                   VARCHAR2(20),
  DATAATTO                  DATE,
  DATAESEC                  DATE,
  NOTE                           VARCHAR2(1000) )
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column SG308_INCINDENNITA.PROGRESSIVO is 'Progressivo dipendente';
comment on column SG308_INCINDENNITA.DATA_VERIFICA is 'Data verifica dell''indennità di esclusività';
comment on column SG308_INCINDENNITA.COD_TIPOVERIF is 'Codice del tipo di verifica';
comment on column SG308_INCINDENNITA.DECORRENZA_IND is 'Data da cui decorre la maturazione dell''indennità di esclusività';
comment on column SG308_INCINDENNITA.TIPOATTO is 'Tipo atto (delibera o determina) della verifica';
comment on column SG308_INCINDENNITA.AUTORITA is 'Autorità atto della verifica';
comment on column SG308_INCINDENNITA.NUMATTO is 'Num.atto della verifica';
comment on column SG308_INCINDENNITA.DATAATTO is 'Data atto della verifica';
comment on column SG308_INCINDENNITA.DATAESEC is 'Data esecutività della verifica';
comment on column SG308_INCINDENNITA.NOTE is 'Note della verifica';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG308_INCINDENNITA
  add constraint SG308_PK primary key (PROGRESSIVO, DATA_VERIFICA, COD_TIPOVERIF)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create table SG309_INCTIPOVERIF
( CODICE           VARCHAR2(5) not null,
  DESCRIZIONE   VARCHAR2(100))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column SG309_INCTIPOVERIF.CODICE is 'Codice tipo verifica';
comment on column SG309_INCTIPOVERIF.DESCRIZIONE is 'Descrizione tipo verifica';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG309_INCTIPOVERIF
  add constraint SG309_PK primary key (CODICE)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

update p200_voci t set t.eccezioni_sensibili='a'
where t.cod_contratto='EDP' and t.cod_voce in ('11165','11175')and t.cod_voce_speciale='BASE';

DELETE P044_ENTIIRPEFFASCE P044
WHERE NOT EXISTS (SELECT * 
                  FROM P042_ENTIIRPEF
                  WHERE ANNO = P044.ANNO
                  AND TIPO_ADDIZIONALE = P044.TIPO_ADDIZIONALE
                  AND COD_ENTE = P044.COD_ENTE
                  AND RITENUTA_SCAGLIONI = 'S');

UPDATE P042_ENTIIRPEF
SET RITENUTA_PROGRESSIVA_SCAGLIONI = 'N'
WHERE RITENUTA_SCAGLIONI = 'N';

insert into p242_tipiassoggettamentivoci
select p242.id_tipoassoggettamento,'14200',p242.cod_voce_speciale
from p240_tipiassoggettamenti p240, p242_tipiassoggettamentivoci p242
where p240.id_tipoassoggettamento=p242.id_tipoassoggettamento 
and p240.cod_contratto='EDP' and p240.cod_tipoassoggettamento='IRAP'
and p242.cod_voce='10100' and p242.cod_voce_speciale='BASE' and not exists
   (select 'X' from p240_tipiassoggettamenti p240, p242_tipiassoggettamentivoci p242
    where p240.id_tipoassoggettamento=p242.id_tipoassoggettamento 
    and p240.cod_contratto='EDP' and p240.cod_tipoassoggettamento='IRAP'
    and p242.cod_voce='14200' and p242.cod_voce_speciale='BASE');

insert into p242_tipiassoggettamentivoci
select p242.id_tipoassoggettamento,'14210',p242.cod_voce_speciale
from p240_tipiassoggettamenti p240, p242_tipiassoggettamentivoci p242
where p240.id_tipoassoggettamento=p242.id_tipoassoggettamento 
and p240.cod_contratto='EDP' and p240.cod_tipoassoggettamento='IRAP'
and p242.cod_voce='10100' and p242.cod_voce_speciale='BASE' and not exists
   (select 'X' from p240_tipiassoggettamenti p240, p242_tipiassoggettamentivoci p242
    where p240.id_tipoassoggettamento=p242.id_tipoassoggettamento 
    and p240.cod_contratto='EDP' and p240.cod_tipoassoggettamento='IRAP'
    and p242.cod_voce='14210' and p242.cod_voce_speciale='BASE');    


insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 1, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 2, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 3, 'and t190.voce_paghe = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 4, 'and codinterno in (''010'',''020'',''022'',''205'',''034'',''080'',''090'',''092'',''110'',''120'',''130'',''140'',', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 5, '  ''244'',''260'',''270'',''280'',''290'',''300'',''310'',''320'',''330'',''210'',''220'',''215'',''225'',''428'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 6, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 7, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 8, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 9, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t210_maggiorazioni t210', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 10, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 11, 'and t210.pore_lav = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 12, 'and codinterno in (''030'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 13, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 14, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 15, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 16, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t210_maggiorazioni t210', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 17, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 18, 'and t210.pind_tur = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 19, 'and codinterno in (''040'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 20, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 21, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 22, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 23, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t210_maggiorazioni t210', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 24, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 25, 'and t210.pstr_nel_mese = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 26, 'and codinterno in (''060'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 27, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 28, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 29, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 30, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t210_maggiorazioni t210', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 31, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 32, 'and t210.pore_comp = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 33, 'and codinterno in (''032'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 34, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 35, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 36, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 37, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t305_caugiustif t305', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 38, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 39, 'and (t305.vocepaghe1 = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 40, ' or t305.vocepaghe2 = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 41, ' or t305.vocepaghe3 = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 42, ' or t305.vocepaghe4 = t193.voce_paghe)', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 43, 'and codinterno in (''200'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 44, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 45, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 46, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 47, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t265_cauassenze t265', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 48, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 49, 'and t265.vocepaghe = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 50, 'and codinterno in (''082'',''170'',''180'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 51, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 52, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 53, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 54, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t275_caupresenze t275', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 55, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 56, 'and (t275.vocepaghe1 = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 57, ' or t275.vocepaghe2 = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 58, ' or t275.vocepaghe3 = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 59, ' or t275.vocepaghe4 = t193.voce_paghe)', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 60, 'and codinterno in (''230'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 61, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 62, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 63, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)

values ('_VOCI_PAGHE', 64, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t275_caupresenze t275', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 65, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 66, 'and (t275.vocepagheliq1 = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 67, ' or t275.vocepagheliq2 = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 68, ' or t275.vocepagheliq3 = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 69, ' or t275.vocepagheliq4 = t193.voce_paghe)', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 70, 'and codinterno in (''160'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 71, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 72, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 73, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 74, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t276_vocipaghepresenza t276', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 75, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 76, 'and t276.vocepaghe = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 77, 'and codinterno in (''250'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 78, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 79, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 80, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 81, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t162_indennita t162', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 82, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 83, 'and t162.vocepaghe = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 84, 'and codinterno in (''150'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 85, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 86, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 87, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 88, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t765_tipoquote t765', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 89, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 90, 'and (t765.vp_intera = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 91, ' or t765.vp_proporzionata = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 92, ' or t765.vp_netta = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 93, ' or t765.vp_nettarisp = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 94, ' or t765.vp_risparmio = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 0, 'select distinct codinterno, codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 97, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 98, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 99, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 100, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t765_tipoquote t765', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 101, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 102, 'and t765.vp_quantitativa = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 103, 'and codinterno in (''242'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 104, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 105, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 106, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 107, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t360_termensa t360', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 108, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 109, 'and (t360.vocepaghe1 = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 110, '  or t360.vocepaghe2 = t193.voce_paghe)', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 111, 'and codinterno in (''100'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 112, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 113, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 114, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 115, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, m010_parametriconteggio m010', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 116, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 117, 'and (m010.codvocepagheintera = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 118, '  or m010.codvocepaghesuphh = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 119, '  or m010.codvocepaghesupgg = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 120, '  or m010.codvocepaghesuphhgg = t193.voce_paghe)', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 121, 'and codinterno in (''400'',''402'',''404'',''406'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 122, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 123, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 124, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 125, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, m021_tipiindennitakm m021', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 126, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 127, 'and m021.codvocepaghe = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 128, 'and codinterno in (''408'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 129, 'and t190.flag = ''S''', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 130, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 131, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 132, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, m020_tipirimborsi m020', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 133, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 134, 'and (m020.codicevocepaghe = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 135, '  or m020.codicevocepagheindennitasuppl = t193.voce_paghe)', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 136, 'and codinterno in (''424'',''426'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 137, 'and t190.flag = ''S'' ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 138, 'and (m020.scaricopaghe = ''S'' or m020.scaricopagheindennitasuppl = ''S'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 139, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 140, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 95, ' or t765.vp_norisparmio = t193.voce_paghe)', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 96, 'and codinterno in (''240'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 141, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, m065_tariffe_indennita m065', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 142, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 143, 'and (m065.vocepaghe_esente = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 144, '  or m065.vocepaghe_assog = t193.voce_paghe)', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 145, 'and codinterno in (''410'',''412'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 146, 'and t190.flag = ''S'' ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 147, 'union', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 148, 'select distinct codinterno, t190.codice interfaccia, t193.decorrenza, t193.voce_paghe_cedolino, t193.voce_paghe_negativa ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 149, ' from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193, t350_regreperib T350', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 150, 'where t190.codice = t193.cod_interfaccia', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 151, 'and (decode(T350.VP_TURNO,''<SI>'','''',''<NO>'','''',T350.VP_TURNO) = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 152, '  or decode(T350.VP_ORE,''<SI>'','''',''<NO>'','''',T350.VP_ORE) = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 153, '  or decode(T350.Vp_Maggiorate,''<SI>'','''',''<NO>'','''',T350.Vp_Maggiorate) = t193.voce_paghe', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 154, '  or decode(T350.Vp_Nonmaggiorate,''<SI>'','''',''<NO>'','''',T350.Vp_Nonmaggiorate) = t193.voce_paghe)', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 155, 'and codinterno in (''260'',''270'',''280'',''290'')', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 156, 'and t190.flag = ''S'' ', 'RILPRE');
insert into t002_querypersonalizzate (NOME, POSIZ, RIGA, APPLICAZIONE)
values ('_VOCI_PAGHE', 157, 'order by codinterno,interfaccia,decorrenza,voce_paghe_cedolino', 'RILPRE');

alter table I010_CAMPIANAGRAFICI modify VAL_DEFAULT VARCHAR2(1000);

alter table T032_FOTODIPENDENTE add FILE_FOTO varchar2(200);
comment on column T032_FOTODIPENDENTE.FILE_FOTO is 'percorso completo del file contenente la foto del dipendente, in alternativa alla valorizzazione della colonna FOTO';

INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA, TIPO, DATO)
SELECT AZIENDA, 'C24_AZIENDABUDGET', 'N' FROM MONDOEDP.I090_ENTI I
WHERE NOT EXISTS
(SELECT 'X' FROM MONDOEDP.I091_DATIENTE T WHERE T.AZIENDA=I.AZIENDA AND T.TIPO='C24_AZIENDABUDGET');

alter table I090_ENTI modify TSLAVORO varchar2(40);
alter table I090_ENTI modify TSINDICI varchar2(40);
alter table I090_ENTI modify TSAUSILIARIO varchar2(40);

alter table T305_CAUGIUSTIF add DATA_MIN_ASSEST date;
comment on column T305_CAUGIUSTIF.DATA_MIN_ASSEST is 'mese/anno a partire dal quale si considera la causale di assestamento sulla scheda riepilogativa, anche se la causale è stata usata precedentemente';

alter table T164_ASSOCIAZIONIINDENNITA add TIPO_ASSOCIAZIONE varchar2(1) default 'A';
comment on column T164_ASSOCIAZIONIINDENNITA.TIPO_ASSOCIAZIONE is 'A=se l''espressione verifica la condizione l''indennità è da aggiungere al profilo, E=se l''espressione non verifica la condizione l''indennità è da eliminare dal profilo';

alter table T910_RIEPILOGO add TABELLA_GENERATA_DROP varchar2(1) default 'S';
comment on column T910_RIEPILOGO.TABELLA_GENERATA_DROP is 'S=La tabella viene droppata ad ogni nuova elaborazione, N=La tabella non viene droppata ad ogni elaborazione';
alter table T910_RIEPILOGO add TABELLA_GENERATA_KEY varchar2(1000);
comment on column T910_RIEPILOGO.TABELLA_GENERATA_KEY is 'Elenco delle colonne, separate da virgola, che costituiscono chiave per l''aggiornamento della tabella';
alter table T910_RIEPILOGO add TABELLA_GENERATA_DELETE varchar2(1000);
comment on column T910_RIEPILOGO.TABELLA_GENERATA_DELETE is 'S=Condizione WHERE di cancellazione della tabella prima dell''elaborazione';

alter table T670_REGOLEBUONI add INTERVALLO_EFFETTIVO varchar2(1) default 'N';
comment on column T670_REGOLEBUONI.INTERVALLO_EFFETTIVO is 'S=la pausa mensa viene controllata considerando le timbrature effettive, N=la pausa mensa viene controllata considerando le timbrature conteggiate';
alter table T670_REGOLEBUONI add FASCIA1_ESCLUSIVA varchar2(1) default 'N';
comment on column T670_REGOLEBUONI.FASCIA1_ESCLUSIVA is 'S=le timbrature che vengono conteggiate nella prima fascia non vengono conteggiate nella seconda, N=le timbrature vengono conteggiate per la parte di effettiva intersezione con le 2 fasce';

alter table T025_CONTMENSILI add ABBATT_RIF_RECUPERO varchar2(1) default '0';
comment on column T025_CONTMENSILI.ABBATT_RIF_RECUPERO is 'Tipologia di recupero usata nell''abbattimento ore non recuperate: 0=Scostamenti negativi, 1=Saldo negativo';

alter table T670_REGOLEBUONI add REGOLA_SUCCESSIVA varchar2(20);
comment on column T670_REGOLEBUONI.REGOLA_SUCCESSIVA is 'Codice della regola da usare se il buono pasto non viene maturato con la regola principale';

alter table T195_VOCIVARIABILI add IMPORTO number;
comment on column T195_VOCIVARIABILI.IMPORTO is 'Usato solo per codice interno 242';

comment on column T020_ORARI.INDFESTIVA is 'S=Ind.festiva domenica e festivi infrasettimanali, D=Ind.festiva solo la domenica, N=Ind.festiva non attivata';

alter table T070_SCHEDARIEPIL add RIPOSI_NONFRUITI_VAR number(2);
comment on column T070_SCHEDARIEPIL.RIPOSI_NONFRUITI_VAR is 'Variazioni alle festività infrasettimanali lavorate';


alter table T330_REG_ATT_AGGIUNTIVE add CONTROLLO_PT varchar2(1) default 'N';
comment on column T330_REG_ATT_AGGIUNTIVE.CONTROLLO_PT
  is 'Segnalazione di controllo per dipendenti part-time S=Segnala, N=Nessuna segnalazione';

alter table T460_PARTTIME add DEBITO_AGG number default 100;
comment on column T460_PARTTIME.DEBITO_AGG is 'Percentuale da applicare nella proporzione del debito aggiuntivo';

create table T105_BK77 as select * from T105_RICHIESTETIMBRATURE;
alter table T105_BK77 modify ELABORATO default 'N';
comment on column T105_RICHIESTETIMBRATURE.OPERAZIONE is 'I=Inserimento,M=Modifica,C=Cancellazione';
alter table T105_RICHIESTETIMBRATURE add CAUSALE_ORIG VARCHAR2(5);
comment on column T105_RICHIESTETIMBRATURE.CAUSALE_ORIG is 'Causale originale della timbratura';
alter table T105_RICHIESTETIMBRATURE add VERSO_ORIG VARCHAR2(1);
comment on column T105_RICHIESTETIMBRATURE.VERSO_ORIG is 'Verso originale della timbratura';
alter table T105_RICHIESTETIMBRATURE add CAUSALE_RICH VARCHAR2(5);
comment on column T105_RICHIESTETIMBRATURE.CAUSALE_RICH is 'Causale richiesta dal dipendente';
update T105_RICHIESTETIMBRATURE set CAUSALE_ORIG = CAUSALE where OPERAZIONE = 'M' and CAUSALE_ORIG is null;
update T105_RICHIESTETIMBRATURE set VERSO_ORIG = VERSO where OPERAZIONE = 'M' and VERSO_ORIG is null;
update T105_RICHIESTETIMBRATURE set CAUSALE = CAUSALE_NEW where OPERAZIONE = 'M';
update T105_RICHIESTETIMBRATURE set VERSO = VERSO_NEW where OPERAZIONE = 'M';
update T105_RICHIESTETIMBRATURE set CAUSALE_RICH = CAUSALE_NEW;
comment on column T105_RICHIESTETIMBRATURE.VERSO_NEW is 'Colonna obsoleta';
comment on column T105_RICHIESTETIMBRATURE.CAUSALE_NEW is 'Colonna obsoleta';
alter table T105_RICHIESTETIMBRATURE drop column VERSO_NEW;
alter table T105_RICHIESTETIMBRATURE drop column CAUSALE_NEW;

DELETE P672_XMLTESTATE P672 WHERE P672.NOME_FLUSSO='EMENS' AND P672.CHIUSO='N'
AND TO_CHAR(P672.DATA_FINE_PERIODO,'YYYY')>='2010';

UPDATE P264_MOD730IMPORTI P264
  SET P264.IMPORTO_MANUALE=NULL, P264.IMPORTO_DOVUTO=DECODE(P264.IMPORTO_RETTIFICA,NULL,P264.IMPORTO_INIZIALE,P264.IMPORTO_RETTIFICA)
WHERE P264.ANNO=2009 AND P264.COD_TIPOIMPORTO='2ID'
AND P264.IMPORTO_MANUALE IS NOT NULL AND P264.IMPORTO_MANUALE<>0 AND P264.IMPORTO_CONG_NEG=0
AND EXISTS 
(SELECT 'X' FROM P262_MOD730TESTATA P262 WHERE P262.PROGRESSIVO=P264.PROGRESSIVO AND P262.ANNO=P264.ANNO
 AND P262.COD_ESITO_2RATA='RID20');

UPDATE P264_MOD730IMPORTI P264
  SET P264.IMPORTO_MANUALE=NULL,
P264.IMPORTO_DOVUTO=DECODE(P264.IMPORTO_RETTIFICA,NULL,P264.IMPORTO_INIZIALE,P264.IMPORTO_RETTIFICA)
WHERE P264.ANNO=2009 AND P264.COD_TIPOIMPORTO='2IC'
AND P264.IMPORTO_MANUALE IS NOT NULL AND P264.IMPORTO_MANUALE<>0 AND P264.IMPORTO_CONG_NEG=0
AND EXISTS 
(SELECT 'X' FROM P262_MOD730TESTATA P262 WHERE P262.PROGRESSIVO=P264.PROGRESSIVO AND P262.ANNO=P264.ANNO
 AND P262.COD_ESITO_2RATA_CONIUGE='RID20');

UPDATE P262_MOD730TESTATA P262
SET P262.COD_ESITO_2RATA=NULL
WHERE P262.ANNO=2009 AND P262.COD_ESITO_2RATA='RID20'
AND EXISTS 
(SELECT 'X' FROM P264_MOD730IMPORTI P264 WHERE P264.PROGRESSIVO=P262.PROGRESSIVO
AND P264.ANNO=P262.ANNO AND P264.COD_TIPOIMPORTO='2ID' AND P264.IMPORTO_CONG_NEG=0
AND NVL(P264.IMPORTO_MANUALE,0)=0);

UPDATE P262_MOD730TESTATA P262
SET P262.COD_ESITO_2RATA_CONIUGE=NULL
WHERE P262.ANNO=2009 AND P262.COD_ESITO_2RATA_CONIUGE='RID20'
AND EXISTS 
(SELECT 'X' FROM P264_MOD730IMPORTI P264 WHERE P264.PROGRESSIVO=P262.PROGRESSIVO
AND P264.ANNO=P262.ANNO AND P264.COD_TIPOIMPORTO='2IC' AND P264.IMPORTO_CONG_NEG=0
AND NVL(P264.IMPORTO_MANUALE,0)=0);

UPDATE p220_livelli t SET T.DESCRIZIONE='Dirigente tecnico/professionale (ex 10° Arch./Ing.)' 
where t.cod_posizione_economica='DR072';

UPDATE P092_CODICIINAIL T SET T.MINIMALE=NULL WHERE T.MINIMALE=0;
UPDATE P092_CODICIINAIL T SET T.MASSIMALE=NULL WHERE T.MASSIMALE=0;
UPDATE P092_CODICIINAIL T SET T.RETR_MINIMALE_GG=NULL WHERE T.RETR_MINIMALE_GG=0;

alter table MONDOEDP.I100_PARSCARICO add OFFSET_ANNO number(4);
comment on column MONDOEDP.I100_PARSCARICO.OFFSET_ANNO is 'Offset da aggiungere all''anno presente sul file per ottenere l''anno corrente. Utilizzato nello scarico dating (TIPOSCARICO=1)';
update MONDOEDP.I100_PARSCARICO set OFFSET_ANNO = 1980 where TIPOSCARICO = '1';

alter table T950_STAMPACARTELLINO add INTESTAZIONE_RIPETUTA varchar2(1) default 'N';
comment on column T950_STAMPACARTELLINO.INTESTAZIONE_RIPETUTA is 'N=L''intestazione viene stampata solo sulla prima pagina di ogni cartellino, S=L''intestazione viene ripetuta anche sulle pagine successive dello stesso cartellino';

ALTER TABLE T770_QUOTE MODIFY PERC_INDIVIDUALE DEFAULT 100;
ALTER TABLE T770_QUOTE MODIFY PERC_STRUTTURALE DEFAULT 0;

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from i500_datiliberi t where NOMECAMPO = 'INCARICO' and TABELLA = 'S';
    if i > 0 then
      EXECUTE IMMEDIATE 'DELETE I501INCARICO';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR070-074-2005-S2002'', ''Dirigente ruolo tecnico equiparato con struttura complessa (dec. 2005) - semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-011-2004'', ''Dirigente medico equiparato con struttura complessa area chirurgica (dec. 2004)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV115-110'', ''Dirigente veterinario incarico lett. c) con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-006-2004'', ''Dirigente medico incarico lett. c) con struttura complessa area medicina (dec. 2004)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV120-106-2008-S2002'', ''Dirigente veterinario equiparato con struttura complessa (dec. 2008) - semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV020-006-2009'', ''Dirigente medico ex modulo con struttura complessa area medicina (dec. 2009)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-006-2009'', ''Dirigente medico incarico lett. c) con struttura complessa area medicina (dec. 2009)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-011-2009'', ''Dirigente medico equiparato con struttura complessa area chirurgica (dec. 2009)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV120-110-2008'', ''Dirigente veterinario equiparato con struttura semplice (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR071-074-2008'', ''Dirigente ruolo tecnico < 5 anni con struttura complessa (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR070-073-2007'', ''Dirigente ruolo tecnico equiparato con struttura semplice (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV115-110-2007'', ''Dirigente veterinario incarico lett. c) con struttura semplice (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR075-055-2007'', ''Dirigente ruolo amministrativo < 5 anni con struttura semplice (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR075-050-2008'', ''Dirigente ruolo amministrativo < 5 anni con struttura complessa (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-016-2009-S2002'', ''Dirigente medico incarico lett. c) con struttura complessa area territorio (dec. 2009) - semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR015-006'', ''Dirigente ruolo sanitario incarico lett. c) con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR025-010'', ''Dirigente ruolo sanitario < 5 anni con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV020-011-2008'', ''Dirigente medico ex modulo con struttura complessa area chirurgica (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR020-010-2007'', ''Dirigente ruolo sanitario equiparato con struttura semplice (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR071-073-2007'', ''Dirigente ruolo tecnico < 5 anni con struttura semplice (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR075-050-2007-S2005'', ''Dirigente ruolo amministrativo < 5 anni con struttura complessa (dec. 2007) - semplice (dec. 2005)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-020-2008'', ''Dirigente medico equiparato con struttura semplice (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR015-010-2008'', ''Dirigente ruolo sanitario incarico lett. c) con struttura semplice (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR065-050-2008'', ''Dirigente ruolo amministrativo equiparato con struttura complessa (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR065-050-2007'', ''Dirigente ruolo amministrativo equiparato con struttura complessa (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR065-055-2008'', ''Dirigente ruolo amministrativo equiparato con struttura semplice (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR070-074-2008'', ''Dirigente ruolo tecnico equiparato con struttura complessa (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR075-055-2009'', ''Dirigente ruolo amministrativo < 5 anni con struttura semplice (dec. 2009)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR075-050-2007'', ''Dirigente ruolo amministrativo < 5 anni con struttura complessa (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-016-2008-S2002'', ''Dirigente medico incarico lett. c) con struttura complessa area territorio (dec. 2008) - semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-016-2008-S2002'', ''Dirigente medico equiparato con struttura complessa area territorio (dec. 2008) - semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-011'', ''Dirigente medico incarico lett. c) con struttura complessa area chirurgica (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV031-021'', ''Dirigente medico equiparato (legge 724/94) con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV026-021'', ''Dirigente medico incarico lett. c) (legge 724/94) con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR070-074'', ''Dirigente ruolo tecnico equiparato con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR070-073'', ''Dirigente ruolo tecnico equiparato con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR015-010'', ''Dirigente ruolo sanitario incarico lett. c) con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR065-055'', ''Dirigente ruolo amministrativo equiparato con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR060-050'', ''Dirigente ruolo amministrativo incarico lett. c) con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR020-010-2008'', ''Dirigente ruolo sanitario equiparato con struttura semplice (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-006'', ''Dirigente medico incarico lett. c) con struttura complessa area medicina (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-011'', ''Dirigente medico equiparato con struttura complessa area chirurgica (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV035-030'', ''Dirigente medico < 5 anni con incarico da equiparato (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV020-016'', ''Dirigente medico ex modulo con struttura complessa area territorio (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-020-2003'', ''Dirigente medico equiparato con struttura semplice (dec. 2003)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-011-2003'', ''Dirigente medico equiparato con struttura complessa area chirurgica (dec. 2003)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-016-2007-S2002'', ''Dirigente medico equiparato con struttura complessa area territorio (dec. 2007) - semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR020-006-2007-S2002'', ''Dirigente ruolo sanitario equiparato con struttura complessa (dec. 2007) - semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV035-020'', ''Dirigente medico < 5 anni con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-006-2008-S2002'', ''Dirigente medico incarico lett. c) con struttura complessa area medicina (dec. 2008) - semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV020-006-2008'', ''Dirigente medico ex modulo con struttura complessa area medicina (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-011-2008-S2002'', ''Dirigente medico incarico lett. c) con struttura complessa area chirurgica (dec. 2008) - semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-020-2008'', ''Dirigente medico incarico lett. c) con struttura semplice (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR025-010-2008'', ''Dirigente ruolo sanitario < 5 anni con struttura semplice (dec. 2008)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR015-010-2007'', ''Dirigente ruolo sanitario incarico lett. c) con struttura semplice (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV020-006-2004'', ''Dirigente medico ex modulo con struttura complessa area medicina (dec. 2004)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-020-2003'', ''Dirigente medico incarico lett. c) con struttura semplice (dec. 2003)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV035-020-2004'', ''Dirigente medico < 5 anni con struttura semplice (dec. 2004)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-020-2004'', ''Dirigente medico equiparato con struttura semplice (dec. 2004)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV020-011-2004'', ''Dirigente medico ex modulo con struttura complessa area chirurgica (dec. 2004)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-011-2004-S2003'', ''Dirigente medico incarico lett. c) con struttura complessa area chirurgica (dec. 2004) - semplice (dec. 2003)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR071-073-2003'', ''Dirigente ruolo tecnico < 5 anni con struttura semplice (dec. 2003)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR065-050'', ''Dirigente ruolo amministrativo equiparato con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR075-050-2006'', ''Dirigente ruolo amministrativo < 5 anni con struttura complessa (dec. 2006)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR065-050-2006'', ''Dirigente ruolo amministrativo equiparato con struttura complessa (dec. 2006)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-020-2006'', ''Dirigente medico incarico lett. c) con struttura semplice (dec. 2006)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-011-2006'', ''Dirigente medico equiparato con struttura complessa area chirurgica (dec. 2006)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-020-2007'', ''Dirigente medico equiparato con struttura semplice (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR070-073-2003'', ''Dirigente ruolo tecnico equiparato con struttura semplice (dec. 2003)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV026-041'', ''Dirigente medico incarico lett. c) (legge 724/94) con struttura complessa area chirurgica (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-020-2007'', ''Dirigente medico incarico lett. c) con struttura semplice (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV020-006-2007'', ''Dirigente medico ex modulo con struttura complessa area medicina (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR010-006'', ''Dirigente ruolo sanitario ex modulo con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-016'', ''Dirigente medico equiparato con struttura complessa area territorio (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV020-011-2007'', ''Dirigente medico ex modulo con struttura complessa area chirurgica (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-016'', ''Dirigente medico incarico lett. c) con struttura complessa area territorio (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR055-050'', ''Dirigente ruolo amministrativo ex modulo con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV110-106'', ''Dirigente veterinario ex modulo con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV115-106'', ''Dirigente veterinario incarico lett. c) con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR075-050'', ''Dirigente ruolo amministrativo < 5 anni con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR075-055'', ''Dirigente ruolo amministrativo < 5 anni con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR020-010'', ''Dirigente ruolo sanitario equiparato con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR073-074'', ''Dirigente ruolo tecnico ex modulo con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR060-055'', ''Dirigente ruolo amministrativo incarico lett. c) con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR065-050-2008-S2002'', ''Dirigente ruolo amministrativo equiparato con struttura complessa (dec. 2008) - semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-011-2007'', ''Dirigente medico incarico lett. c) con struttura complessa area chirurgica (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-016-2007'', ''Dirigente medico incarico lett. c) con struttura complessa area territorio (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-006-2007'', ''Dirigente medico equiparato con struttura complessa area medicina (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-006-2007-S2002'', ''Dirigente medico equiparato con struttura complessa area medicina (dec. 2007) - semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-006-2010'', ''Dirigente medico equiparato con struttura complessa area medicina (dec. 2010)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV120-110'', ''Dirigente veterinario equiparato con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-006-2007'', ''Dirigente medico incarico lett. c) con struttura complessa area medicina (dec. 2007)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR075-055-2005'', ''Dirigente ruolo amministrativo < 5 anni con struttura semplice (dec. 2005)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-020-2005'', ''Dirigente medico incarico lett. c) con struttura semplice (dec. 2005)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV031-021-2005'', ''Dirigente medico equiparato (legge 724/94) con struttura semplice (dec. successiva 2005)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV035-020-2005'', ''Dirigente medico < 5 anni con struttura semplice (dec. 2005)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-020-2005'', ''Dirigente medico equiparato con struttura semplice (dec. 2005)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR015-010-2005'', ''Dirigente ruolo sanitario incarico lett. c) con struttura semplice (dec. 2005)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR071-074'', ''Dirigente ruolo tecnico < 5 anni con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV020-006'', ''Dirigente medico ex modulo con struttura complessa area medicina (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV020-011'', ''Dirigente medico ex modulo con struttura complessa area chirurgica (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-020'', ''Dirigente medico equiparato con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR020-006'', ''Dirigente ruolo sanitario equiparato con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR072-073'', ''Dirigente ruolo tecnico incarico lett. c) con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR071-073'', ''Dirigente ruolo tecnico < 5 anni con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV025-020'', ''Dirigente medico incarico lett. c) con struttura semplice (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV030-006'', ''Dirigente medico equiparato con struttura complessa area medicina (dec. 2002)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''MV026-021-2005'', ''Dirigente medico incarico lett. c) (legge 724/94) con struttura semplice (dec. successiva 2005)'')';
      EXECUTE IMMEDIATE 'insert into I501INCARICO (CODICE, DESCRIZIONE)
      values (''DR072-074'', ''Dirigente ruolo tecnico incarico lett. c) con struttura complessa (dec. 2002)'')';
      EXECUTE IMMEDIATE 'DELETE P252_VOCIAGGIUNTIVEIMPORTI WHERE NOME_VOCEAGGIUNTIVA=''INCARICO''';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2007)'', ''00212'', ''BASE'', 369.4, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073-2003'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2003)'', ''00208'', ''BASE'', 67.52, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073-2003'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2003)'', ''00208'', ''BASE'', 70.93, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073-2003'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2003)'', ''00210'', ''BASE'', 21.1, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073-2003'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2003)'', ''00212'', ''BASE'', 185.6, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073-2003'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2003)'', ''00208'', ''BASE'', 42.63, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2002)'', ''00208'', ''BASE'', 203.65, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-006'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. medicina (dec. 2002)'', ''00208'', ''BASE'', 331.89, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-006'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. medicina (dec. 2002)'', ''00208'', ''BASE'', 348, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2002)'', ''00208'', ''BASE'', 250.67, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2002)'', ''00210'', ''BASE'', 20.9, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-016'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. territorio (dec. 2002)'', ''00208'', ''BASE'', 139.09, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV115-110'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. veterinario lett. c) con S.S. (dec. 2002)'', ''00212'', ''BASE'', 257.63, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-016'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. territorio (dec. 2002)'', ''00208'', ''BASE'', 101.24, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-016'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. territorio (dec. 2002)'', ''00208'', ''BASE'', 145.9, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2002)'', ''00212'', ''BASE'', 87.2, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2002)'', ''00212'', ''BASE'', 507.33, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 223.03, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 233.49, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2002)'', ''00208'', ''BASE'', 195.63, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-006'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.C. (dec. 2002)'', ''00212'', ''BASE'', 284.27, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2002)'', ''00210'', ''BASE'', 67.9, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-073'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.S. (dec. 2002)'', ''00212'', ''BASE'', 172.5, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2002)'', ''00212'', ''BASE'', 518.82, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2002)'', ''00212'', ''BASE'', 378.09, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2002)'', ''00210'', ''BASE'', 47.1, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2002)'', ''00210'', ''BASE'', 117.9, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020-2004'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2004)'', ''00212'', ''BASE'', 477.95, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-010'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 110.76, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR025-010'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 149.68, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR055-050'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 105.02, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-050'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 160.47, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-055'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 55.45, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2002)'', ''00208'', ''BASE'', 192.25, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050-2006'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2006)'', ''00208'', ''BASE'', 69.19, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2007)'', ''00208'', ''BASE'', 69.19, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2007)'', ''00212'', ''BASE'', 792.73, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-055'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 87.23, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 105.48, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073-2003'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2003)'', ''00208'', ''BASE'', 92.38, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-074'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.C. (dec. 2002)'', ''00208'', ''BASE'', 213.28, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 129.63, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073-2003'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2003)'', ''00208'', ''BASE'', 116.53, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-074'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.C. (dec. 2002)'', ''00208'', ''BASE'', 237.43, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-073'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 66.35, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR073-074'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 107.79, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2002)'', ''00208'', ''BASE'', 214.37, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050-2006'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2006)'', ''00208'', ''BASE'', 91.31, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 109.35, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055-2005'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2005)'', ''00208'', ''BASE'', 45.21, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2002)'', ''00208'', ''BASE'', 290.64, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006-2004'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2004)'', ''00208'', ''BASE'', 175.58, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 320.49, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011-2004'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2004)'', ''00208'', ''BASE'', 202.6, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-016'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. territorio (dec. 2002)'', ''00208'', ''BASE'', 232.9, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2002)'', ''00208'', ''BASE'', 433.78, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006-2004'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2004)'', ''00208'', ''BASE'', 263.68, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 460.8, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011-2004-S2003'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2004) - S.S. (dec. 2003)'', ''00208'', ''BASE'', 322.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2002)'', ''00208'', ''BASE'', 420.46, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 140.3, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020-2003'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2003)'', ''00208'', ''BASE'', 119.5, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020-2005'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2005)'', ''00208'', ''BASE'', 88.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020-2006'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2006)'', ''00208'', ''BASE'', 88.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-006'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. medicina (dec. 2002)'', ''00208'', ''BASE'', 523.09, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 550.11, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2003'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2003)'', ''00208'', ''BASE'', 482.21, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2004'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2004)'', ''00208'', ''BASE'', 380.01, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2006'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2006)'', ''00208'', ''BASE'', 175.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-016'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. territorio (dec. 2002)'', ''00208'', ''BASE'', 509.77, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 229.61, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2003'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2003)'', ''00208'', ''BASE'', 208.81, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2004'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2004)'', ''00208'', ''BASE'', 177.41, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2005'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2005)'', ''00208'', ''BASE'', 141.11, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 295.4, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020-2004'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2004)'', ''00208'', ''BASE'', 243.2, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020-2005'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2005)'', ''00208'', ''BASE'', 206.9, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV110-106'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. veterinario ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 232.9, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV115-106'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. veterinario lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 418.14, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2007)'', ''00208'', ''BASE'', 87, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2007)'', ''00208'', ''BASE'', 87, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2007)'', ''00208'', ''BASE'', 175.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2007)'', ''00208'', ''BASE'', 175.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2007)'', ''00208'', ''BASE'', 175.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2007)'', ''00208'', ''BASE'', 88.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-006-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. medicina (dec. 2007)'', ''00208'', ''BASE'', 175.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2007)'', ''00208'', ''BASE'', 88.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-010-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.S. (dec. 2007)'', ''00208'', ''BASE'', 22.66, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2008)'', ''00212'', ''BASE'', 407.69, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-010-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.S. (dec. 2008)'', ''00212'', ''BASE'', 222.88, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2008)'', ''00212'', ''BASE'', 861.92, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-055-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.S. (dec. 2008)'', ''00212'', ''BASE'', 265.06, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-074-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.C. (dec. 2008)'', ''00212'', ''BASE'', 920.78, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-074-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.C. (dec. 2008)'', ''00212'', ''BASE'', 1150.52, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2008)'', ''00212'', ''BASE'', 1109.82, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016-2009-S2002'', to_date(''01-01-2009'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2009) - S.S. (dec. 2002)'', ''00212'', ''BASE'', 460.79, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016-2009-S2002'', to_date(''01-01-2009'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2009) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 140.3, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073-2003'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2003)'', ''00208'', ''BASE'', 70.93, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050-2006'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2006)'', ''00212'', ''BASE'', 1018.51, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073-2003'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2003)'', ''00212'', ''BASE'', 531.92, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073-2003'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2003)'', ''00210'', ''BASE'', 21.1, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073-2003'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2003)'', ''00212'', ''BASE'', 391.19, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073-2003'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2003)'', ''00208'', ''BASE'', 42.63, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006-2004'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2004)'', ''00208'', ''BASE'', 80.57, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006-2004'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2004)'', ''00208'', ''BASE'', 88.59, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006-2004'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2004)'', ''00212'', ''BASE'', 115.06, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2004'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2004)'', ''00208'', ''BASE'', 186.36, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2004'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2004)'', ''00208'', ''BASE'', 204.91, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006-2004'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2004)'', ''00212'', ''BASE'', 395.15, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2004'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2004)'', ''00212'', ''BASE'', 485.18, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006-2004'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2004)'', ''00208'', ''BASE'', 80.57, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006-2004'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2004)'', ''00208'', ''BASE'', 88.59, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020-2004'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2004)'', ''00208'', ''BASE'', 36.3, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV026-041'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) (legge 724/94) con S.C. chirurgica (dec. 2002)'', ''00212'', ''BASE'', 223.86, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV026-041'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) (legge 724/94) con S.C. chirurgica (dec. 2002)'', ''00210'', ''BASE'', 34.03, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV026-041'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico lett. c) (legge 724/94) con S.C. chirurgica (dec. 2002)'', ''00210'', ''BASE'', 68.4, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV026-041'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico lett. c) (legge 724/94) con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 68.4, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2007)'', ''00212'', ''BASE'', 280.09, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2007)'', ''00212'', ''BASE'', 203.64, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-010-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.S. (dec. 2007)'', ''00212'', ''BASE'', 200.22, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV026-021'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) (legge 724/94) con S.S. (dec. 2002)'', ''00210'', ''BASE'', 15.7, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV026-021'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico lett. c) (legge 724/94) con S.S. (dec. 2002)'', ''00210'', ''BASE'', 32.57, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-055'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.S. (dec. 2002)'', ''00212'', ''BASE'', 177.83, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2002)'', ''00212'', ''BASE'', 425.75, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 375.01, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2002)'', ''00210'', ''BASE'', 67.9, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-055'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.S. (dec. 2002)'', ''00210'', ''BASE'', 7.2, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-055'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.S. (dec. 2002)'', ''00210'', ''BASE'', 18.6, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-055'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 39.69, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-010'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.S. (dec. 2002)'', ''00212'', ''BASE'', 157.78, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-010'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.S. (dec. 2002)'', ''00210'', ''BASE'', 16.23, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-010'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.S. (dec. 2002)'', ''00210'', ''BASE'', 42.43, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-010'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 42.43, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2002)'', ''00212'', ''BASE'', 172.5, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2002)'', ''00210'', ''BASE'', 13.1, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2002)'', ''00210'', ''BASE'', 34.2, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 55.73, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-074'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.C. (dec. 2002)'', ''00208'', ''BASE'', 137.77, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-074'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.C. (dec. 2002)'', ''00208'', ''BASE'', 142.88, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-006'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 244.73, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2002)'', ''00208'', ''BASE'', 238.55, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2002)'', ''00208'', ''BASE'', 245.36, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV115-106'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. veterinario lett. c) con S.C. (dec. 2002)'', ''00212'', ''BASE'', 182.95, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV115-106'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. veterinario lett. c) con S.C. (dec. 2002)'', ''00210'', ''BASE'', 60.9, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV115-106'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. veterinario lett. c) con S.C. (dec. 2002)'', ''00210'', ''BASE'', 152.4, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV115-106'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. veterinario lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 198.38, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV115-106'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. veterinario lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 236.23, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV115-106'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. veterinario lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 243.04, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV110-106'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. veterinario ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 139.09, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV110-106'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. veterinario ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 101.24, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV110-106'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. veterinario ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 145.9, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV110-106'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. veterinario ex modulo con S.C. (dec. 2002)'', ''00210'', ''BASE'', 77.72, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006-2008-S2002'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2008) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 140.3, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006-2008-S2002'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2008) - S.S. (dec. 2002)'', ''00212'', ''BASE'', 518.53, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2008)'', ''00212'', ''BASE'', 290.64, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011-2008-S2002'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2008) - S.S. (dec. 2002)'', ''00212'', ''BASE'', 635.58, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011-2008-S2002'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2008) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 140.3, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2008)'', ''00212'', ''BASE'', 368.19, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR025-010-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario < 5 anni con S.S. (dec. 2008)'', ''00212'', ''BASE'', 591.31, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2002)'', ''00210'', ''BASE'', 170.1, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2002)'', ''00212'', ''BASE'', 315.08, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-050'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 69.85, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011-2004-S2003'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2004) - S.S. (dec. 2003)'', ''00212'', ''BASE'', 453.78, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011-2004'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2004)'', ''00212'', ''BASE'', 205.09, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2002)'', ''00210'', ''BASE'', 54.3, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2002)'', ''00208'', ''BASE'', 83.21, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-050'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.C. (dec. 2002)'', ''00212'', ''BASE'', 669.67, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-050'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.C. (dec. 2002)'', ''00210'', ''BASE'', 20.9, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-050'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.C. (dec. 2002)'', ''00210'', ''BASE'', 54.3, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV115-110-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. veterinario lett. c) con S.S. (dec. 2007)'', ''00208'', ''BASE'', 88.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-006'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.C. (dec. 2002)'', ''00210'', ''BASE'', 81.06, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-006'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.C. (dec. 2002)'', ''00210'', ''BASE'', 213.51, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-030'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con inc. equiparato (dec. 2002)'', ''00212'', ''BASE'', 279.45, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-030'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con inc. equiparato (dec. 2002)'', ''00212'', ''BASE'', 197.86, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-006'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.C. (dec. 2002)'', ''00212'', ''BASE'', 284.27, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV120-110'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. veterinario equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 111.77, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2007)'', ''00212'', ''BASE'', 483.73, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV120-110'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. veterinario equiparato con S.S. (dec. 2002)'', ''00212'', ''BASE'', 257.63, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-010-2005'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.S. (dec. 2005)'', ''00212'', ''BASE'', 200.21, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV031-021'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico equiparato (legge 724/94) con S.S. (dec. 2002)'', ''00212'', ''BASE'', 202.64, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV031-021'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico equiparato (legge 724/94) con S.S. (dec. 2002)'', ''00210'', ''BASE'', 5.69, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV115-110-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. veterinario lett. c) con S.S. (dec. 2007)'', ''00212'', ''BASE'', 280.09, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2007)'', ''00208'', ''BASE'', 21.45, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2007)'', ''00212'', ''BASE'', 256.53, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2007)'', ''00212'', ''BASE'', 472.38, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2007)'', ''00208'', ''BASE'', 40.58, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-006-2007-S2002'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.C. (dec. 2007) - S.S. (dec. 2002)'', ''00212'', ''BASE'', 533.81, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-006-2007-S2002'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.C. (dec. 2007) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 153.32, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-016-2007-S2002'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. territorio (dec. 2007) - S.S. (dec. 2002)'', ''00212'', ''BASE'', 373.79, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-016-2007-S2002'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. territorio (dec. 2007) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 316.61, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-016'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. territorio (dec. 2002)'', ''00210'', ''BASE'', 70.64, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR025-010'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario < 5 anni con S.S. (dec. 2002)'', ''00210'', ''BASE'', 12.8, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR025-010'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario < 5 anni con S.S. (dec. 2002)'', ''00210'', ''BASE'', 33.3, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR025-010'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario < 5 anni con S.S. (dec. 2002)'', ''00212'', ''BASE'', 571.16, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR025-010'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario < 5 anni con S.S. (dec. 2002)'', ''00212'', ''BASE'', 441.63, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-016'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. territorio (dec. 2002)'', ''00212'', ''BASE'', 180.63, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-016'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. territorio (dec. 2002)'', ''00210'', ''BASE'', 67.9, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-073'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 44.18, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-073'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 44.9, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-074'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.C. (dec. 2002)'', ''00208'', ''BASE'', 137.77, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-074'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.C. (dec. 2002)'', ''00208'', ''BASE'', 142.88, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 80.62, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 84.03, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-016'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. territorio (dec. 2002)'', ''00210'', ''BASE'', 170.1, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-016'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. territorio (dec. 2002)'', ''00208'', ''BASE'', 237, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-016'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. territorio (dec. 2002)'', ''00208'', ''BASE'', 319.77, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-016'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. territorio (dec. 2002)'', ''00208'', ''BASE'', 334.67, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2007)'', ''00212'', ''BASE'', 320.69, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2002)'', ''00212'', ''BASE'', 180.63, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2002)'', ''00210'', ''BASE'', 67.9, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2002)'', ''00210'', ''BASE'', 170.1, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2002)'', ''00208'', ''BASE'', 200.7, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006-2009'', to_date(''01-01-2009'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2009)'', ''00212'', ''BASE'', 290.64, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006-2009'', to_date(''01-01-2009'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2009)'', ''00212'', ''BASE'', 658.83, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2009'', to_date(''01-01-2009'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2009)'', ''00212'', ''BASE'', 865.19, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV120-110-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. veterinario equiparato con S.S. (dec. 2008)'', ''00212'', ''BASE'', 457.5, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-074'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.C. (dec. 2002)'', ''00210'', ''BASE'', 68.3, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV026-021'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) (legge 724/94) con S.S. (dec. 2002)'', ''00212'', ''BASE'', 181.47, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV115-110'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. veterinario lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 22.46, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2002)'', ''00210'', ''BASE'', 54.3, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2002)'', ''00208'', ''BASE'', 83.21, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2002)'', ''00210'', ''BASE'', 7.2, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2002)'', ''00210'', ''BASE'', 18.6, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2002)'', ''00212'', ''BASE'', 315.08, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-006'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 290.16, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-006'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 291.97, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV031-021'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico equiparato (legge 724/94) con S.S. (dec. 2002)'', ''00210'', ''BASE'', 11.39, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV031-021'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico equiparato (legge 724/94) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 11.4, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055-2005'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2005)'', ''00212'', ''BASE'', 467.75, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055-2005'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2005)'', ''00208'', ''BASE'', 4.63, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020-2005'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2005)'', ''00212'', ''BASE'', 280.09, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-010-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.S. (dec. 2007)'', ''00212'', ''BASE'', 245.88, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-010-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.S. (dec. 2007)'', ''00208'', ''BASE'', 22.66, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2007)'', ''00212'', ''BASE'', 462.12, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2007)'', ''00208'', ''BASE'', 45.6, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050-2007-S2005'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2007) - S.S. (dec. 2005)'', ''00212'', ''BASE'', 1013.87, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050-2007-S2005'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2007) - S.S. (dec. 2005)'', ''00208'', ''BASE'', 95.95, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2008)'', ''00212'', ''BASE'', 457.5, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV115-110'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. veterinario lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 110.56, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV120-110'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. veterinario equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 199.87, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-030'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con inc. equiparato (dec. 2002)'', ''00208'', ''BASE'', 65.79, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR010-006'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 292.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-006'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 357.2, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-010'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 65.1, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR015-010-2005'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario lett. c) con S.S. (dec. 2005)'', ''00208'', ''BASE'', 22.67, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-006'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.C. (dec. 2002)'', ''00208'', ''BASE'', 402.86, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2004'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2004)'', ''00212'', ''BASE'', 280.09, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073-2003'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2003)'', ''00208'', ''BASE'', 67.52, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 39.69, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-006'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.C. (dec. 2002)'', ''00210'', ''BASE'', 81.06, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-006'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.C. (dec. 2002)'', ''00210'', ''BASE'', 213.51, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-006'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.C. (dec. 2002)'', ''00208'', ''BASE'', 266.6, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2002)'', ''00210'', ''BASE'', 52.2, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 88.5, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR073-074'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico ex modulo con S.C. (dec. 2002)'', ''00210'', ''BASE'', 13.1, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR073-074'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico ex modulo con S.C. (dec. 2002)'', ''00210'', ''BASE'', 34.1, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2002)'', ''00208'', ''BASE'', 258.69, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 275.24, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 285.7, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 133.42, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 164.89, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR010-006'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario ex modulo con S.C. (dec. 2002)'', ''00212'', ''BASE'', 126.49, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR010-006'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario ex modulo con S.C. (dec. 2002)'', ''00210'', ''BASE'', 64.83, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR010-006'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario ex modulo con S.C. (dec. 2002)'', ''00210'', ''BASE'', 171.08, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR010-006'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 202.3, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-055'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 68.77, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR010-006'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 247.73, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 64.14, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR010-006'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 249.54, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 68.77, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-010-2008'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.S. (dec. 2008)'', ''00212'', ''BASE'', 268.54, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-006'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.C. (dec. 2002)'', ''00208'', ''BASE'', 336.71, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-055'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 26.33, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-006'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.C. (dec. 2002)'', ''00208'', ''BASE'', 337.63, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-010'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 88.98, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-010'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 88.09, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 52.2, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2002)'', ''00210'', ''BASE'', 20.8, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020-2003'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2003)'', ''00210'', ''BASE'', 31.4, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020-2003'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2003)'', ''00212'', ''BASE'', 248.69, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006-2004'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2004)'', ''00208'', ''BASE'', 36.02, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR073-074'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 44.78, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050-2006'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2006)'', ''00212'', ''BASE'', 792.73, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020-2006'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2006)'', ''00212'', ''BASE'', 280.09, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2003'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2003)'', ''00208'', ''BASE'', 67.7, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2003'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2003)'', ''00208'', ''BASE'', 112.62, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2003'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2003)'', ''00208'', ''BASE'', 120.71, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2003'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2003)'', ''00208'', ''BASE'', 185.5, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2003'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2003)'', ''00210'', ''BASE'', 31.4, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2003'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2003)'', ''00212'', ''BASE'', 248.69, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020-2004'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2004)'', ''00208'', ''BASE'', 81.22, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006-2004'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2004)'', ''00208'', ''BASE'', 36.02, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020-2004'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2004)'', ''00208'', ''BASE'', 89.31, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2004'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2004)'', ''00208'', ''BASE'', 81.22, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2004'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2004)'', ''00208'', ''BASE'', 89.31, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2004'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2004)'', ''00208'', ''BASE'', 36.3, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011-2004-S2003'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2004) - S.S. (dec. 2003)'', ''00208'', ''BASE'', 78.4, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011-2004'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2004)'', ''00208'', ''BASE'', 47, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011-2004'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2004)'', ''00208'', ''BASE'', 105.14, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-011-2004'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. chirurgica (dec. 2004)'', ''00208'', ''BASE'', 115.6, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011-2004-S2003'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2004) - S.S. (dec. 2003)'', ''00208'', ''BASE'', 136.54, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011-2004-S2003'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2004) - S.S. (dec. 2003)'', ''00208'', ''BASE'', 147, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2002)'', ''00212'', ''BASE'', 895.45, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2002)'', ''00212'', ''BASE'', 227.89, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2002)'', ''00212'', ''BASE'', 227.89, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2002)'', ''00212'', ''BASE'', 1010.32, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2002)'', ''00212'', ''BASE'', 518.48, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2002)'', ''00212'', ''BASE'', 403.61, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV026-021-2005'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico lett. c) (legge 724/94) con S.S. (dec. succ. 2005)'', ''00212'', ''BASE'', 214.04, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-074'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.C. (dec. 2002)'', ''00212'', ''BASE'', 707.5, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-074'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.C. (dec. 2002)'', ''00210'', ''BASE'', 26.2, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-074'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.C. (dec. 2002)'', ''00210'', ''BASE'', 68.3, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-074'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 83.73, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-074'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 101.33, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-074'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 103.75, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-074'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 174.15, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-055'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.S. (dec. 2002)'', ''00212'', ''BASE'', 177.83, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-055'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.S. (dec. 2002)'', ''00210'', ''BASE'', 7.2, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-055'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.S. (dec. 2002)'', ''00210'', ''BASE'', 18.6, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-055'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 35.29, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-055'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 36.99, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050-2008-S2002'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2008) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 87.23, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2002)'', ''00210'', ''BASE'', 44.26, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2002)'', ''00210'', ''BASE'', 115.06, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV020-006'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico ex modulo con S.C. medicina (dec. 2002)'', ''00208'', ''BASE'', 151.08, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2002)'', ''00210'', ''BASE'', 67.9, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2002)'', ''00210'', ''BASE'', 170.1, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 217.1, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR025-010'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 59.12, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2002)'', ''00210'', ''BASE'', 170.1, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2002)'', ''00208'', ''BASE'', 206.12, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR025-010'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 88.74, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR025-010'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 89.55, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050-2008-S2002'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2008) - S.S. (dec. 2002)'', ''00212'', ''BASE'', 774.69, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-011-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. chirurgica (dec. 2007)'', ''00212'', ''BASE'', 600.78, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2007)'', ''00212'', ''BASE'', 425.99, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-006-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. medicina (dec. 2007)'', ''00212'', ''BASE'', 573.04, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-006-2007-S2002'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. medicina (dec. 2007) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 316.61, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-006-2007-S2002'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. medicina (dec. 2007) - S.S. (dec. 2002)'', ''00212'', ''BASE'', 431.53, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-006-2010'', to_date(''01-01-2010'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. medicina (dec. 2010)'', ''00212'', ''BASE'', 748.14, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV120-110'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. veterinario equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 103.68, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2002)'', ''00210'', ''BASE'', 20.8, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2002)'', ''00210'', ''BASE'', 52.2, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV120-110'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. veterinario equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 58.76, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-074'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.C. (dec. 2002)'', ''00208'', ''BASE'', 100.52, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2002)'', ''00212'', ''BASE'', 669.67, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2002)'', ''00210'', ''BASE'', 20.9, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2006'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2006)'', ''00212'', ''BASE'', 690.09, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 141.51, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-050'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 87.86, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR060-050'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. lett. c) con S.C. (dec. 2002)'', ''00208'', ''BASE'', 91.28, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2002)'', ''00208'', ''BASE'', 116.71, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-050'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.C. (dec. 2002)'', ''00208'', ''BASE'', 123.06, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2002)'', ''00208'', ''BASE'', 116.71, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2002)'', ''00208'', ''BASE'', 123.06, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR065-055'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 64.14, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-073'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.S. (dec. 2002)'', ''00210'', ''BASE'', 34.2, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-073'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 38.94, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2002)'', ''00210'', ''BASE'', 13.1, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2002)'', ''00210'', ''BASE'', 34.2, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-073'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 55.73, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-074'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.C. (dec. 2002)'', ''00210'', ''BASE'', 26.2, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-074'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.C. (dec. 2002)'', ''00210'', ''BASE'', 68.3, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-074'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.C. (dec. 2002)'', ''00208'', ''BASE'', 100.52, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-006'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. medicina (dec. 2002)'', ''00212'', ''BASE'', 225.05, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-006'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. medicina (dec. 2002)'', ''00210'', ''BASE'', 67.9, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-074'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.C. (dec. 2002)'', ''00212'', ''BASE'', 707.5, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV026-021'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico lett. c) (legge 724/94) con S.S. (dec. 2002)'', ''00208'', ''BASE'', 32.57, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-006'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. medicina (dec. 2002)'', ''00212'', ''BASE'', 225.05, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-006'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. medicina (dec. 2002)'', ''00210'', ''BASE'', 170.1, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV031-021-2005'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico equiparato (legge 724/94) con S.S. (dec. succ. 2005)'', ''00212'', ''BASE'', 214.04, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-006'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. medicina (dec. 2002)'', ''00208'', ''BASE'', 242.42, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-074'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.C. (dec. 2002)'', ''00210'', ''BASE'', 26.2, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2005'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2005)'', ''00208'', ''BASE'', 53.01, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2007)'', ''00212'', ''BASE'', 1018.5, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-010'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.S. (dec. 2002)'', ''00212'', ''BASE'', 157.78, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-055-2009'', to_date(''01-01-2009'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2009)'', ''00212'', ''BASE'', 512.96, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR075-050-2007'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. < 5 anni con S.C. (dec. 2007)'', ''00208'', ''BASE'', 91.32, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-074-2005-S2002'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.C. (dec. 2005) - S.S. (dec. 2002)'', ''00212'', ''BASE'', 752.29, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-074-2005-S2002'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.C. (dec. 2005) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 92.98, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-074-2005-S2002'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.C. (dec. 2005) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 98.09, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-074-2005-S2002'', to_date(''01-01-2007'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.C. (dec. 2005) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 168.49, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV120-106-2008-S2002'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. veterinario equiparato con S.C. (dec. 2008) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 199.87, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV120-106-2008-S2002'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. veterinario equiparato con S.C. (dec. 2008) - S.S. (dec. 2002)'', ''00212'', ''BASE'', 490.53, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016-2008-S2002'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2008) - S.S. (dec. 2002)'', ''00212'', ''BASE'', 460.79, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-016-2008-S2002'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.C. territorio (dec. 2008) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 140.3, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-016-2008-S2002'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. territorio (dec. 2008) - S.S. (dec. 2002)'', ''00212'', ''BASE'', 460.79, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-016-2008-S2002'', to_date(''01-01-2008'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. territorio (dec. 2008) - S.S. (dec. 2002)'', ''00208'', ''BASE'', 229.61, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR073-074'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico ex modulo con S.C. (dec. 2002)'', ''00212'', ''BASE'', 535.01, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-074'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.C. (dec. 2002)'', ''00212'', ''BASE'', 1053.83, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR071-074'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico < 5 anni con S.C. (dec. 2002)'', ''00212'', ''BASE'', 913.09, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 80.62, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR070-073'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 84.03, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR073-074'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 57.14, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR073-074'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 58.84, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR055-050'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 43.52, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR055-050'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 52.57, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR055-050'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. ex modulo con S.C. (dec. 2002)'', ''00208'', ''BASE'', 54.29, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR055-050'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. ex modulo con S.C. (dec. 2002)'', ''00212'', ''BASE'', 491.84, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR055-050'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. ex modulo con S.C. (dec. 2002)'', ''00210'', ''BASE'', 13.7, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR055-050'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo amministr. ex modulo con S.C. (dec. 2002)'', ''00210'', ''BASE'', 35.7, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 253.4, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2002)'', ''00208'', ''BASE'', 356.46, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-010'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.S. (dec. 2002)'', ''00210'', ''BASE'', 16.23, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-010'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.S. (dec. 2002)'', ''00210'', ''BASE'', 42.43, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR020-010'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. ruolo sanitario equiparato con S.S. (dec. 2002)'', ''00208'', ''BASE'', 64.3, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''DR072-073'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. ruolo tecnico lett. c) con S.S. (dec. 2002)'', ''00210'', ''BASE'', 13.1, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 88.5, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 133.42, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2002)'', ''00208'', ''BASE'', 141.51, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020'', to_date(''01-01-2002'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2002)'', ''00210'', ''BASE'', 20.8, ''SSSSSSSSSSSS'', to_date(''31-12-2002'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2002)'', ''00210'', ''BASE'', 52.2, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2003'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2003)'', ''00208'', ''BASE'', 288.56, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2003'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2003)'', ''00208'', ''BASE'', 307.11, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV025-020-2003'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico lett. c) con S.S. (dec. 2003)'', ''00208'', ''BASE'', 31.4, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2003'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2003)'', ''00210'', ''BASE'', 102.2, ''SSSSSSSSSSSS'', to_date(''31-12-2003'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2003'', to_date(''01-01-2003'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2003)'', ''00212'', ''BASE'', 382.98, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020-2005'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2005)'', ''00212'', ''BASE'', 514.25, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2005'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2005)'', ''00212'', ''BASE'', 316.39, ''SSSSSSSSSSSS'', to_date(''31-12-3999'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020-2005'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2005)'', ''00208'', ''BASE'', 44.92, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV035-020-2005'', to_date(''01-01-2006'', ''dd-mm-yyyy''), ''Dir. medico < 5 anni con S.S. (dec. 2005)'', ''00208'', ''BASE'', 53.01, ''SSSSSSSSSSSS'', to_date(''31-12-2006'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-020-2005'', to_date(''01-02-2005'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.S. (dec. 2005)'', ''00208'', ''BASE'', 44.92, ''SSSSSSSSSSSS'', to_date(''31-12-2005'', ''dd-mm-yyyy''), null)';
      EXECUTE IMMEDIATE 'insert into P252_VOCIAGGIUNTIVEIMPORTI (COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, CODICE, DECORRENZA, DESCRIZIONE, COD_VOCE, COD_VOCE_SPECIALE, IMPORTO, EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ)
      values (''EDP'', ''INCARICO'', ''MV030-011-2004'', to_date(''01-01-2004'', ''dd-mm-yyyy''), ''Dir. medico equiparato con S.C. chirurgica (dec. 2004)'', ''00208'', ''BASE'', 83.3, ''SSSSSSSSSSSS'', to_date(''31-01-2005'', ''dd-mm-yyyy''), null)';
    end if;
    DELETE P670_XMLREGOLE;
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D091', 'Contributo', 'Importo della contribuzione calcolata sull’imponibile previdenziale', 'D080', null, 'S', 'P1', null, 'S', 'SELECT NVL(SUM(PERCENTUALE),0) DATO FROM' || chr(10) || '(' || chr(10) || 'SELECT NVL(MAX(P233.PERC_IMP),0) PERCENTUALE' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441, P232_SCAGLIONI P232, P233_SCAGLIONIFASCE P233' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || 'AND P232.COD_VOCE = P442.COD_VOCE AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || 'AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO' || chr(10) || '     AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '     AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '     AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || 'AND P233.ID_SCAGLIONE = P232.ID_SCAGLIONE AND P233.IMPORTO_DA = 0' || chr(10) || 'AND CHIUSO IN (:StatoCedolini) AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(P442.COD_VOCE,6,'' '')||P442.COD_VOCE_SPECIALE IN (''11160 BASE'',''11170 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || 'SELECT NVL(MAX(P200.RITENUTA_PERC),0) PERCENTUALE ' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 , P200_VOCI P200' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND P200.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || 'AND P200.COD_VOCE = P442.COD_VOCE AND P200.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || 'AND P441.DATA_CEDOLINO BETWEEN P200.DECORRENZA AND P200.DECORRENZA_FINE' || chr(10) || 'AND CHIUSO IN (:StatoCedolini) AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(P442.COD_VOCE,6,'' '')||P442.COD_VOCE_SPECIALE IN (''11165 BASE'',''11175 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || ')', 'SELECT NVL(SUM(PERCENTUALE),0) DATO FROM' || chr(10) || '(' || chr(10) || 'SELECT NVL(MAX(P233.PERC_IMP),0) PERCENTUALE' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441, P232_SCAGLIONI P232, P233_SCAGLIONIFASCE P233' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || 'AND P232.COD_VOCE = P442.COD_VOCE AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || 'AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO' || chr(10) || '     AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '     AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '     AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || 'AND P233.ID_SCAGLIONE = P232.ID_SCAGLIONE AND P233.IMPORTO_DA = 0' || chr(10) || 'AND CHIUSO IN (:StatoCedolini) AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(P442.COD_VOCE,6,'' '')||P442.COD_VOCE_SPECIALE IN (''11160 BASE'',''11170 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || 'SELECT NVL(MAX(P200.RITENUTA_PERC),0) PERCENTUALE ' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 , P200_VOCI P200' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND P200.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || 'AND P200.COD_VOCE = P442.COD_VOCE AND P200.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || 'AND P441.DATA_CEDOLINO BETWEEN P200.DECORRENZA AND P200.DECORRENZA_FINE' || chr(10) || 'AND CHIUSO IN (:StatoCedolini) AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(P442.COD_VOCE,6,'' '')||P442.COD_VOCE_SPECIALE IN (''11165 BASE'',''11175 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || ')', 'N', null, null, 'D', 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D048', 'NumMensilita', 'Numero di mensilità retribuite nell''anno', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D048', 'NumMensilita', 'Numero di mensilità retribuite nell''anno', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D330', 'MalADebito', 'Informazioni relative alla restituzione di indennità di malattia corrisposte', 'D093', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D335', 'CausaleVersMal', 'Causale della contribuzione di malattia o della restituzione della relativa indennità', 'D330', null, 'N', null, null, 'S', 'SELECT P096.COD_QUALIFICA QUALIFICA1, P096.COD_TIPOORARIO_TEMPOPIENO QUALIFICA2, ' || chr(10) || '       P096.COD_TIPOTEMPO QUALIFICA3, ''71'' TIPOCONTRIBUZIONE,' || chr(10) || '       ''E791'' CAUSALEVERSMAL, -SUM(P442.IMPORTO) IMPORTO ' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441, P096_INQUADRINPS P096' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND P442.ID_CEDOLINO = P441.ID_CEDOLINO' || chr(10) || 'AND P096.COD_INQUADRINPS = ''IMPIND'' AND P441.DATA_CEDOLINO BETWEEN P096.DECORRENZA AND P096.DECORRENZA_FINE' || chr(10) || 'AND P441.CHIUSO IN (:StatoCedolini) AND P441.DATA_CEDOLINO BETWEEN :DataDa AND :DataA' || chr(10) || 'AND P442.COD_VOCE = :CodVoce AND P442.COD_VOCE_SPECIALE = :CodVoceSpeciale AND P442.TIPO_RECORD = ''M''' || chr(10) || 'GROUP BY P096.COD_QUALIFICA, P096.COD_TIPOORARIO_TEMPOPIENO, P096.COD_TIPOTEMPO' || chr(10) || 'HAVING SUM(P442.IMPORTO) < 0', 'SELECT P096.COD_QUALIFICA QUALIFICA1, P096.COD_TIPOORARIO_TEMPOPIENO QUALIFICA2, ' || chr(10) || '       P096.COD_TIPOTEMPO QUALIFICA3, ''71'' TIPOCONTRIBUZIONE,' || chr(10) || '       ''E791'' CAUSALEVERSMAL, -SUM(P442.IMPORTO) IMPORTO ' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441, P096_INQUADRINPS P096' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND P442.ID_CEDOLINO = P441.ID_CEDOLINO' || chr(10) || 'AND P096.COD_INQUADRINPS = ''IMPIND'' AND P441.DATA_CEDOLINO BETWEEN P096.DECORRENZA AND P096.DECORRENZA_FINE' || chr(10) || 'AND P441.CHIUSO IN (:StatoCedolini) AND P441.DATA_CEDOLINO BETWEEN :DataDa AND :DataA' || chr(10) || 'AND P442.COD_VOCE = :CodVoce AND P442.COD_VOCE_SPECIALE = :CodVoceSpeciale AND P442.TIPO_RECORD = ''M''' || chr(10) || 'GROUP BY P096.COD_QUALIFICA, P096.COD_TIPOORARIO_TEMPOPIENO, P096.COD_TIPOTEMPO' || chr(10) || 'HAVING SUM(P442.IMPORTO) < 0', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D340', 'ImportoVersMal', 'Importo della contribuzione o della restituzione dell’indennità di malattia', 'D330', null, 'S', 'P1', null, 'S', null, null, 'N', null, null, 'D', 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D360', 'CausaleRecMal', 'Causale del recupero dell’indennità di malattia', 'D355', null, 'N', null, null, 'S', 'SELECT P096.COD_QUALIFICA QUALIFICA1, P096.COD_TIPOORARIO_TEMPOPIENO QUALIFICA2, ' || chr(10) || '       P096.COD_TIPOTEMPO QUALIFICA3, ''71'' TIPOCONTRIBUZIONE,' || chr(10) || '       ''S110'' CAUSALERECMAL, SUM(P442.IMPORTO) IMPORTO ' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441, P096_INQUADRINPS P096' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND P442.ID_CEDOLINO = P441.ID_CEDOLINO' || chr(10) || 'AND P096.COD_INQUADRINPS = ''IMPIND'' AND P441.DATA_CEDOLINO BETWEEN P096.DECORRENZA AND P096.DECORRENZA_FINE' || chr(10) || 'AND P441.CHIUSO IN (:StatoCedolini) AND P441.DATA_CEDOLINO BETWEEN :DataDa AND :DataA' || chr(10) || 'AND P442.COD_VOCE = :CodVoce AND P442.COD_VOCE_SPECIALE = :CodVoceSpeciale AND P442.TIPO_RECORD = ''M''' || chr(10) || 'GROUP BY P096.COD_QUALIFICA, P096.COD_TIPOORARIO_TEMPOPIENO, P096.COD_TIPOTEMPO' || chr(10) || 'HAVING SUM(P442.IMPORTO) > 0', 'SELECT P096.COD_QUALIFICA QUALIFICA1, P096.COD_TIPOORARIO_TEMPOPIENO QUALIFICA2, ' || chr(10) || '       P096.COD_TIPOTEMPO QUALIFICA3, ''71'' TIPOCONTRIBUZIONE,' || chr(10) || '       ''S110'' CAUSALERECMAL, SUM(P442.IMPORTO) IMPORTO ' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441, P096_INQUADRINPS P096' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND P442.ID_CEDOLINO = P441.ID_CEDOLINO' || chr(10) || 'AND P096.COD_INQUADRINPS = ''IMPIND'' AND P441.DATA_CEDOLINO BETWEEN P096.DECORRENZA AND P096.DECORRENZA_FINE' || chr(10) || 'AND P441.CHIUSO IN (:StatoCedolini) AND P441.DATA_CEDOLINO BETWEEN :DataDa AND :DataA' || chr(10) || 'AND P442.COD_VOCE = :CodVoce AND P442.COD_VOCE_SPECIALE = :CodVoceSpeciale AND P442.TIPO_RECORD = ''M''' || chr(10) || 'GROUP BY P096.COD_QUALIFICA, P096.COD_TIPOORARIO_TEMPOPIENO, P096.COD_TIPOTEMPO' || chr(10) || 'HAVING SUM(P442.IMPORTO) > 0', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D090', 'Imponibile', 'Imponibile previdenziale', 'D080', null, 'S', 'P1000', null, 'S', 'SELECT COD_VOCE, COD_VOCE_SPECIALE, DATA_COMPETENZA_DA, DATA_COMPETENZA_A, SUM(TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''')) IMPONIBILE, SUM(IMPORTO) IMPORTO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND ' || chr(10) || 'P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND DATA_CEDOLINO= :DataElaborazione' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11055 BASE'',''11160 BASE'', ''11170 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M'' AND IMPORTO <> 0' || chr(10) || 'GROUP BY COD_VOCE, COD_VOCE_SPECIALE, DATA_COMPETENZA_DA, DATA_COMPETENZA_A', 'SELECT COD_VOCE, COD_VOCE_SPECIALE, DATA_COMPETENZA_DA, DATA_COMPETENZA_A, SUM(TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''')) IMPONIBILE, SUM(IMPORTO) IMPORTO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND ' || chr(10) || 'P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND DATA_CEDOLINO= :DataElaborazione' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11055 BASE'',''11160 BASE'', ''11170 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M'' AND IMPORTO <> 0' || chr(10) || 'GROUP BY COD_VOCE, COD_VOCE_SPECIALE, DATA_COMPETENZA_DA, DATA_COMPETENZA_A', 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'Z510', 'TotaleADebito', 'Importo totale delle contribuzioni presenti nelle denunce individuali', 'Z500', null, 'S', 'P1000', null, 'N', 'SELECT NVL(SUM(TO_NUMBER(NVL(P673.VALORE,0))),0) DATO FROM P673_XMLDATIINDIVIDUALI P673, P672_XMLTESTATE P672, P670_XMLREGOLE P670' || chr(10) || 'WHERE P673.ID_FLUSSO = :Id_Flusso AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P670.NOME_FLUSSO = P672.NOME_FLUSSO AND P670.NUMERO = P673.NUMERO' || chr(10) || 'AND P672.DATA_FINE_PERIODO BETWEEN P670.DECORRENZA AND P670.DECORRENZA_FINE ' || chr(10) || 'AND P670.TIPO_IMPORTO = ''D'' AND P670.DATO_RIEPILOGATIVO = ''N'' AND P673.TIPO_RECORD = ''M''', 'SELECT NVL(SUM(TO_NUMBER(NVL(P673.VALORE,0))),0) DATO FROM P673_XMLDATIINDIVIDUALI P673, P672_XMLTESTATE P672, P670_XMLREGOLE P670' || chr(10) || 'WHERE P673.ID_FLUSSO = :Id_Flusso AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P670.NOME_FLUSSO = P672.NOME_FLUSSO AND P670.NUMERO = P673.NUMERO' || chr(10) || 'AND P672.DATA_FINE_PERIODO BETWEEN P670.DECORRENZA AND P670.DECORRENZA_FINE ' || chr(10) || 'AND P670.TIPO_IMPORTO = ''D'' AND P670.DATO_RIEPILOGATIVO = ''N'' AND P673.TIPO_RECORD = ''M''', 'N', null, null, null, 'S', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'Z515', 'TotaleACredito', 'Importo totale dei conguagli presenti nelle denunce individuali', 'Z500', null, 'S', 'P1000', null, 'N', 'SELECT NVL(SUM(TO_NUMBER(NVL(P673.VALORE,0))),0) DATO FROM P673_XMLDATIINDIVIDUALI P673, P672_XMLTESTATE P672, P670_XMLREGOLE P670' || chr(10) || 'WHERE P673.ID_FLUSSO = :Id_Flusso AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P670.NOME_FLUSSO = P672.NOME_FLUSSO AND P670.NUMERO = P673.NUMERO' || chr(10) || 'AND P672.DATA_FINE_PERIODO BETWEEN P670.DECORRENZA AND P670.DECORRENZA_FINE ' || chr(10) || 'AND P670.TIPO_IMPORTO = ''C'' AND P670.DATO_RIEPILOGATIVO = ''N'' AND P673.TIPO_RECORD = ''M''', 'SELECT NVL(SUM(TO_NUMBER(NVL(P673.VALORE,0))),0) DATO FROM P673_XMLDATIINDIVIDUALI P673, P672_XMLTESTATE P672, P670_XMLREGOLE P670' || chr(10) || 'WHERE P673.ID_FLUSSO = :Id_Flusso AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P670.NOME_FLUSSO = P672.NOME_FLUSSO AND P670.NUMERO = P673.NUMERO' || chr(10) || 'AND P672.DATA_FINE_PERIODO BETWEEN P670.DECORRENZA AND P670.DECORRENZA_FINE ' || chr(10) || 'AND P670.TIPO_IMPORTO = ''C'' AND P670.DATO_RIEPILOGATIVO = ''N'' AND P673.TIPO_RECORD = ''M''', 'N', null, null, null, 'S', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'C025', 'CodiceAttivita', 'Codice attivita''', 'A450', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'C030', 'Imponibile', 'Compensi effettivamente percepiti', 'A450', null, 'S', 'P1000', null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'C035', 'Aliquota', 'Aliquota applicata espressa in centesimi', 'A450', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'C040', 'AltraAss', 'Altra assicurazione in caso di applicazione di aliquote ridotte', 'A450', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'C045', 'Dal', 'Data di inizio di attività cui si riferisce il compenso erogato', 'A450', 'D10', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'C050', 'Al', 'Data di fine di attività cui si riferisce il compenso erogato', 'A450', 'D10', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A100', 'DatiMittente', 'Informazioni relative al mittente', 'A000', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A000', 'DenunceRetributiveMensili', 'Flusso EMens', null, null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A105', 'CFPersonaMittente', 'Codice fiscale del soggetto (persona fisica) abilitato alla trasmissione', 'A100', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A110', 'RagSocMittente', 'Ragione sociale del titolare che effettua la trasmissione', 'A100', 'L50', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A115', 'CFMittente', 'Codice fiscale del soggetto titolare, persona fisica o giuridica, che effettua la trasmissione', 'A100', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A125', 'SedeINPS', 'Codice sede INPS, destinataria del flusso, che curerà i rapporti con il mittente', 'A100', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A120', 'CFSoftwarehouse', 'Codice fiscale del soggetto giuridico titolare del flusso ', 'A100', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A200', 'Azienda', 'Dettaglio del flusso', 'A000', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A205', 'AnnoMeseDenuncia', 'Anno e mese della denuncia', 'A200', 'D7', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A400', 'ListaCollaboratori', 'Denunce individuali dei lavoratori parasubordinati', 'A200', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A300', 'ListaDenunceIndividuali', 'Denunce individuali dei lavoratori dipendenti relative ad una posizione contributiva DM', 'A200', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A215', 'RagSocAzienda', 'Ragione sociale dell''azienda', 'A200', 'L50', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A210', 'CFAzienda', 'Codice fiscale dell''azienda', 'A200', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A350', 'DenunciaIndividuale', 'Denuncia retributiva di ogni singolo lavoratore dipendente', 'A300', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A305', 'Matricola', 'Matricola aziendale INPS', 'A300', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A410', 'ISTAT', 'Codice ISTAT dell''azienda', 'A400', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A405', 'CAP', 'CAP della Sede legale dell''azienda', 'A400', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'A450', 'Collaboratore', 'Denuncia individuale di ogni singolo lavoratore parasubordinato', 'A400', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'C017', 'CodiceComune', 'Comune in cui il lavoratore svolge prevalentemente la propria attività lavorativa', 'A450', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'C005', 'CFCollaboratore', 'Codice fiscale del collaboratore', 'A450', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'C010', 'Cognome', 'Cognome del collaboratore', 'A450', 'L30', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D050', 'Assunzione', 'Informazioni relative all''eventuale assunzione', 'A350', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D010', 'Cognome', 'Cognome del lavoratore', 'A350', 'L30', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D005', 'CFLavoratore', 'Codice fiscale del lavoratore', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D055', 'GiornoAssunzione', 'Giorno del mese in cui è intervenuta l''assunzione', 'D050', null, 'S', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D060', 'TipoAssunzione', 'Codice tipo assunzione ', 'D050', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D065', 'Cessazione', 'Informazioni relative all''eventuale cessazione', 'A350', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D070', 'GiornoCessazione', 'Giorno del mese in cui è intervenuta la cessazione', 'D065', null, 'S', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D075', 'TipoCessazione', 'Codice tipo cessazione', 'D065', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D080', 'DatiRetributivi', 'Informazioni retributive del mese', 'A350', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D085', 'TipoLavoratore', 'Tipologie particolari di lavoratori', 'D080', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D130', 'TipoCopertura', 'Tipo copertura', 'D120', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D120', 'Settimana', 'Informazioni relative alle settimane o frazione di settimana del mese', 'D080', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D125', 'IdSettimana', 'Progressivo assoluto della settimana (da domenica a sabato), o frazione, nell''anno', 'D120', null, 'S', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D135', 'CodiceEvento', 'Codice evento per settimana parzialmente retribuita o totalmente non retribuita', 'D120', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D160', 'GiorniRetribuiti', 'Numero dei giorni retribuiti nel mese', 'D080', null, 'S', null, null, 'S', 'SELECT (VALORE+VARIAZIONE_TOTALE) DATO FROM P450_DATIMENSILI P450, P441_CEDOLINO P441 ' || chr(10) || '  WHERE P450.PROGRESSIVO = :Progressivo AND P441.PROGRESSIVO = P450.PROGRESSIVO' || chr(10) || '  AND CHIUSO IN (:StatoCedolini) AND TIPO_CEDOLINO = ''NR'' AND DATA_CEDOLINO= :DataElaborazione' || chr(10) || '  AND P441.DATA_RETRIBUZIONE= DATA_CEDOLINO AND DATA_CEDOLINO = P450.DATA_RETRIBUZIONE' || chr(10) || '  AND COD_CAMPO = ''GGINP'' AND TIPO_RECORD = ''M''', 'SELECT (VALORE+VARIAZIONE_TOTALE) DATO FROM P450_DATIMENSILI P450, P441_CEDOLINO P441 ' || chr(10) || '  WHERE P450.PROGRESSIVO = :Progressivo AND P441.PROGRESSIVO = P450.PROGRESSIVO' || chr(10) || '  AND CHIUSO IN (:StatoCedolini) AND TIPO_CEDOLINO = ''NR'' AND DATA_CEDOLINO= :DataElaborazione' || chr(10) || '  AND P441.DATA_RETRIBUZIONE= DATA_CEDOLINO AND DATA_CEDOLINO = P450.DATA_RETRIBUZIONE' || chr(10) || '  AND COD_CAMPO = ''GGINP'' AND TIPO_RECORD = ''M''', 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D165', 'SettimaneUtili', 'Numero delle settimane utili per i lavoratori a tempo parziale', 'D080', null, 'S', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D015', 'Nome', 'Nome del lavoratore', 'A350', 'L20', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D020', 'Qualifica1', 'Qualifica1 (qualifica assicurativa)', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D025', 'Qualifica2', 'Qualifica2 (tipo orario)', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A000', 'DenunceMensili', 'Flusso UNIEMENS', null, null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A100', 'DatiMittente', 'Informazioni relative al mittente', 'A000', null, 'N', null, null, 'S', null, null, 'N', null, 'Tipo=1', null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A105', 'CFPersonaMittente', 'Codice fiscale del soggetto (persona fisica) abilitato alla trasmissione', 'A100', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A110', 'RagSocMittente', 'Ragione sociale del titolare che effettua la trasmissione', 'A100', 'L50', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A115', 'CFMittente', 'Codice fiscale del soggetto titolare, persona fisica o giuridica, che effettua la trasmissione', 'A100', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A120', 'CFSoftwarehouse', 'Codice fiscale del soggetto giuridico titolare del flusso ', 'A100', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A125', 'SedeINPS', 'Codice sede INPS, destinataria del flusso, che curerà i rapporti con il mittente', 'A100', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A200', 'Azienda', 'Dettaglio del flusso', 'A000', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A205', 'AnnoMeseDenuncia', 'Anno e mese della denuncia', 'A200', 'D7', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A210', 'CFAzienda', 'Codice fiscale dell''azienda', 'A200', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A215', 'RagSocAzienda', 'Ragione sociale dell''azienda', 'A200', 'L50', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A300', 'PosContributiva', 'Denunce individuali dei lavoratori dipendenti relative ad una posizione contributiva DM', 'A200', null, 'N', null, null, 'S', null, null, 'N', null, 'Composizione=CP', null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A305', 'Matricola', 'Matricola aziendale INPS', 'A300', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A350', 'DenunciaIndividuale', 'Denuncia retributiva di ogni singolo lavoratore dipendente', 'A300', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A370', 'DenunciaAziendale', 'Importi delle contribuzioni e dei conguagli non rapportabili a livello individuale', 'A300', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'S', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A400', 'ListaCollaboratori', 'Denunce individuali dei lavoratori parasubordinati', 'A200', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A405', 'CAP', 'CAP della Sede legale dell''azienda', 'A400', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A410', 'ISTAT', 'Codice ISTAT dell''azienda', 'A400', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'A450', 'Collaboratore', 'Denuncia individuale di ogni singolo lavoratore parasubordinato', 'A400', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'C005', 'CFCollaboratore', 'Codice fiscale del collaboratore', 'A450', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'C010', 'Cognome', 'Cognome del collaboratore', 'A450', 'L30', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'C015', 'Nome', 'Nome del collaboratore', 'A450', 'L20', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'C017', 'CodiceComune', 'Comune in cui il lavoratore svolge prevalentemente la propria attività lavorativa', 'A450', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'C020', 'TipoRapporto', 'Tipo rapporto', 'A450', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'C025', 'CodiceAttivita', 'Codice attivita''', 'A450', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'C030', 'Imponibile', 'Compensi effettivamente percepiti', 'A450', null, 'S', 'P1000', null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'C035', 'Aliquota', 'Aliquota applicata espressa in centesimi', 'A450', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'C040', 'AltraAss', 'Altra assicurazione in caso di applicazione di aliquote ridotte', 'A450', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'C045', 'Dal', 'Data di inizio di attività cui si riferisce il compenso erogato', 'A450', 'D10', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'C050', 'Al', 'Data di fine di attività cui si riferisce il compenso erogato', 'A450', 'D10', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D005', 'CFLavoratore', 'Codice fiscale del lavoratore', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D010', 'Cognome', 'Cognome del lavoratore', 'A350', 'L30', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D015', 'Nome', 'Nome del lavoratore', 'A350', 'L20', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D020', 'Qualifica1', 'Qualifica1 (qualifica assicurativa)', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D025', 'Qualifica2', 'Qualifica2 (tipo orario)', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D030', 'Qualifica3', 'Qualifica3 (tipo tempo)', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D035', 'TipoContribuzione', 'Tipo contribuzione', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D036', 'Cittadinanza', 'Cittadinanza del lavoratore', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D040', 'CodiceComune', 'Comune in cui il lavoratore svolge prevalentemente la propria attività lavorativa', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D045', 'CodiceContratto', 'Codice contratto (EP per gli enti pubblici)', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D046', 'OrarioContrattuale', 'Numero ore settimanali previste dal contratto di lavoro', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D047', 'PercPartTime', 'Percentuale di part-time indicata nel contratto di lavoro', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D050', 'Assunzione', 'Informazioni relative all''eventuale assunzione', 'A350', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D055', 'GiornoAssunzione', 'Giorno del mese in cui è intervenuta l''assunzione', 'D050', null, 'S', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D060', 'TipoAssunzione', 'Codice tipo assunzione ', 'D050', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D065', 'Cessazione', 'Informazioni relative all''eventuale cessazione', 'A350', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D070', 'GiornoCessazione', 'Giorno del mese in cui è intervenuta la cessazione', 'D065', null, 'S', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D075', 'TipoCessazione', 'Codice tipo cessazione', 'D065', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D080', 'DatiRetributivi', 'Informazioni retributive del mese', 'A350', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D085', 'TipoLavoratore', 'Tipologie particolari di lavoratori', 'D080', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D092', 'ContribuzioneAggiuntiva', 'Informazioni relative alla contribuzione aggiuntiva dell’1%', 'D080', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D093', 'Malattia', 'Informazioni relative ai conguagli dell’indennità di malattia', 'D080', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D094', 'LavPensionato', 'Informazioni relative alle trattenute al lavoratore pensionato', 'D080', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D095', 'RetribTeorica', 'Retribuzione teorica del mese', 'D080', null, 'S', 'P1000', null, 'N', 'SELECT NVL(SUM(IMPORTO),0) IMPORTO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND ' || chr(10) || 'P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND DATA_CEDOLINO= :DataElaborazione' || chr(10) || 'AND TO_CHAR(P442.DATA_COMPETENZA_A,''MMYYYY'') = TO_CHAR(P441.DATA_RETRIBUZIONE,''MMYYYY'')' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''14200 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''', 'SELECT NVL(SUM(IMPORTO),0) IMPORTO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND ' || chr(10) || 'P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND DATA_CEDOLINO= :DataElaborazione' || chr(10) || 'AND TO_CHAR(P442.DATA_COMPETENZA_A,''MMYYYY'') = TO_CHAR(P441.DATA_RETRIBUZIONE,''MMYYYY'')' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''14200 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D120', 'Settimana', 'Informazioni relative alle settimane o frazione di settimana del mese', 'D080', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D125', 'IdSettimana', 'Progressivo assoluto della settimana (da domenica a sabato), o frazione, nell''anno', 'D120', null, 'S', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D130', 'TipoCopertura', 'Tipo copertura', 'D120', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D135', 'CodiceEvento', 'Codice evento per settimana parzialmente retribuita o totalmente non retribuita', 'D120', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D410', 'CausaleTrattPens', 'Causale della trattenuta', 'D405', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D165', 'SettimaneUtili', 'Numero delle settimane utili per i lavoratori a tempo parziale', 'D080', null, 'S', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D300', 'Contrib1PerCento', 'Informazioni relative alla contribuzione aggiuntiva dell’1%', 'D092', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D310', 'ContribAggCorrente', 'Importo della contribuzione aggiuntiva dell’1%', 'D300', null, 'S', 'P1', null, 'S', null, null, 'N', null, null, 'D', 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D160', 'GiorniRetribuiti', 'Numero dei giorni retribuiti nel mese', 'D080', null, 'S', null, null, 'S', 'SELECT (VALORE+VARIAZIONE_TOTALE) DATO FROM P450_DATIMENSILI P450, P441_CEDOLINO P441 ' || chr(10) || '  WHERE P450.PROGRESSIVO = :Progressivo AND P441.PROGRESSIVO = P450.PROGRESSIVO' || chr(10) || '  AND CHIUSO IN (:StatoCedolini) AND TIPO_CEDOLINO = ''NR'' AND DATA_CEDOLINO= :DataElaborazione' || chr(10) || '  AND P441.DATA_RETRIBUZIONE= DATA_CEDOLINO AND DATA_CEDOLINO = P450.DATA_RETRIBUZIONE' || chr(10) || '  AND COD_CAMPO = ''GGINP'' AND TIPO_RECORD = ''M''', 'SELECT (VALORE+VARIAZIONE_TOTALE) DATO FROM P450_DATIMENSILI P450, P441_CEDOLINO P441 ' || chr(10) || '  WHERE P450.PROGRESSIVO = :Progressivo AND P441.PROGRESSIVO = P450.PROGRESSIVO' || chr(10) || '  AND CHIUSO IN (:StatoCedolini) AND TIPO_CEDOLINO = ''NR'' AND DATA_CEDOLINO= :DataElaborazione' || chr(10) || '  AND P441.DATA_RETRIBUZIONE= DATA_CEDOLINO AND DATA_CEDOLINO = P450.DATA_RETRIBUZIONE' || chr(10) || '  AND COD_CAMPO = ''GGINP'' AND TIPO_RECORD = ''M''', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D350', 'MalACredito', 'Informazioni relative ai conguagli dell’indennità di malattia a credito', 'D093', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D365', 'ImportoRecMal', 'Importo dell’indennità di malattia recuperata', 'D355', null, 'S', 'P1', null, 'S', null, null, 'N', null, null, 'C', 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D400', 'LavPensTrattenuta', 'Informazioni relative alle trattenute al lavoratore pensionato', 'D094', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D405', 'FondiDiversi', 'Informazioni relative alle trattenute al lavoratore pensionato di Fondi e Gestioni speciali', 'D400', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D415', 'ImportoTrattPens', 'Importo della trattenuta', 'D405', null, 'S', 'P1', null, 'S', null, null, 'N', null, null, 'D', 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D161', 'GiorniContribuiti', 'Numero dei giorni per i quali è stata versata contribuzione', 'D080', null, 'S', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D162', 'OreContribuite', 'Numero di ore per le quali è stata versata contribuzione', 'D080', null, 'S', 'P1000', null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D090', 'Imponibile', 'Imponibile previdenziale', 'D080', null, 'S', 'P1000', null, 'S', 'SELECT COD_VOCE, COD_VOCE_SPECIALE, DATA_COMPETENZA_DA, DATA_COMPETENZA_A, SUM(TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''')) IMPONIBILE, SUM(IMPORTO) IMPORTO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND ' || chr(10) || 'P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND DATA_CEDOLINO= :DataElaborazione' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11055 BASE'',''11160 BASE'', ''11170 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M'' AND IMPORTO <> 0' || chr(10) || 'GROUP BY COD_VOCE, COD_VOCE_SPECIALE, DATA_COMPETENZA_DA, DATA_COMPETENZA_A', 'SELECT COD_VOCE, COD_VOCE_SPECIALE, DATA_COMPETENZA_DA, DATA_COMPETENZA_A, SUM(TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''')) IMPONIBILE, SUM(IMPORTO) IMPORTO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND ' || chr(10) || 'P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND DATA_CEDOLINO= :DataElaborazione' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11055 BASE'',''11160 BASE'', ''11170 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M'' AND IMPORTO <> 0' || chr(10) || 'GROUP BY COD_VOCE, COD_VOCE_SPECIALE, DATA_COMPETENZA_DA, DATA_COMPETENZA_A', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'Z005', 'DataEsecutivita', 'Data di esecutività dell''atto emesso per il pagamento della somma dovuta', 'A370', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'S', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'Z010', 'TrattQuotaLav', 'Avvenuta o mancata effettuazione delle trattenute contributive a carico del lavoratore', 'A370', null, 'N', null, null, 'N', 'SELECT ''S'' DATO FROM DUAL', 'SELECT ''S'' DATO FROM DUAL', 'N', null, null, null, 'S', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'Z015', 'NumLavoratori', 'Numero dipendenti occupati', 'A370', null, 'S', null, null, 'N', 'SELECT COUNT(DISTINCT P673.PROGRESSIVO) DATO FROM P673_XMLDATIINDIVIDUALI P673' || chr(10) || 'WHERE P673.ID_FLUSSO = :Id_Flusso AND P673.NUMERO=''A350'' AND P673.TIPO_RECORD = ''M''', 'SELECT COUNT(DISTINCT P673.PROGRESSIVO) DATO FROM P673_XMLDATIINDIVIDUALI P673' || chr(10) || 'WHERE P673.ID_FLUSSO = :Id_Flusso AND P673.NUMERO=''A350'' AND P673.TIPO_RECORD = ''M''', 'N', null, null, null, 'S', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'Z500', 'DatiQuadraturaRetrContr', 'Informazioni necessarie alla quadratura del numero e degli importi delle denunce individuali', 'A370', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'S', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'Z035', 'ForzaAziendale', 'Numero di tutti i dipendenti a tempo pieno e i dipendenti a tempo parziale proporzionati', 'A370', null, 'S', null, null, 'N', 'SELECT COUNT(DISTINCT P673.PROGRESSIVO) DATO FROM P673_XMLDATIINDIVIDUALI P673' || chr(10) || 'WHERE P673.ID_FLUSSO = :Id_Flusso AND P673.NUMERO=''A350'' AND P673.TIPO_RECORD = ''M''', 'SELECT COUNT(DISTINCT P673.PROGRESSIVO) DATO FROM P673_XMLDATIINDIVIDUALI P673' || chr(10) || 'WHERE P673.ID_FLUSSO = :Id_Flusso AND P673.NUMERO=''A350'' AND P673.TIPO_RECORD = ''M''', 'N', null, null, null, 'S', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'Z505', 'NumDenIndiv', 'Numero di denunce individuali inviate', 'Z500', null, 'S', null, null, 'N', 'SELECT COUNT(*) DATO FROM P673_XMLDATIINDIVIDUALI P673' || chr(10) || 'WHERE P673.ID_FLUSSO = :Id_Flusso AND P673.NUMERO=''A350'' AND P673.TIPO_RECORD = ''M''', 'SELECT COUNT(*) DATO FROM P673_XMLDATIINDIVIDUALI P673' || chr(10) || 'WHERE P673.ID_FLUSSO = :Id_Flusso AND P673.NUMERO=''A350'' AND P673.TIPO_RECORD = ''M''', 'N', null, null, null, 'S', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D305', 'ImponibileCtrAgg', 'Importo dell’imponibile soggetto a contribuzione aggiuntiva 1%', 'D300', null, 'S', 'P1000', null, 'S', 'SELECT NVL(ROUND(SUM(DATO),2) * 100,0) IMPONIBILE, NVL(ROUND(SUM(DATO),2),0) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT ' || chr(10) || 'DECODE(SIGN(ABS(TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') * ' || chr(10) || '(-- Impostazione percentuale primo scaglione CPDEL/CPS ' || chr(10) || 'SELECT P233.PERC_IMP FROM P232_SCAGLIONI P232,P233_SCAGLIONIFASCE P233 ' || chr(10) || '  WHERE P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || '  AND P232.COD_VOCE = P442.COD_VOCE' || chr(10) || '  AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || '  AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO' || chr(10) || '       AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '       AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '       AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || '  AND P232.ID_SCAGLIONE = P233.ID_SCAGLIONE' || chr(10) || '  AND P233.IMPORTO_DA = 0' || chr(10) || ')' || chr(10) || '/ 100 - IMPORTO) - 0.031),-1,0, IMPORTO - TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') * ' || chr(10) || '(-- Impostazione percentuale primo scaglione CPDEL/CPS ' || chr(10) || 'SELECT P233.PERC_IMP FROM P232_SCAGLIONI P232,P233_SCAGLIONIFASCE P233 ' || chr(10) || '  WHERE P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || '  AND P232.COD_VOCE = P442.COD_VOCE' || chr(10) || '  AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || '  AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO' || chr(10) || '       AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '       AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '       AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || '  AND P232.ID_SCAGLIONE = P233.ID_SCAGLIONE' || chr(10) || '  AND P233.IMPORTO_DA = 0' || chr(10) || ')' || chr(10) || '/ 100) DATO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11160 BASE'',''11170 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || ')', 'SELECT NVL(ROUND(SUM(DATO),2) * 100,0) IMPONIBILE, NVL(ROUND(SUM(DATO),2),0) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT ' || chr(10) || 'DECODE(SIGN(ABS(TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') * ' || chr(10) || '(-- Impostazione percentuale primo scaglione CPDEL/CPS ' || chr(10) || 'SELECT P233.PERC_IMP FROM P232_SCAGLIONI P232,P233_SCAGLIONIFASCE P233 ' || chr(10) || '  WHERE P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || '  AND P232.COD_VOCE = P442.COD_VOCE' || chr(10) || '  AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || '  AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO' || chr(10) || '       AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '       AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '       AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || '  AND P232.ID_SCAGLIONE = P233.ID_SCAGLIONE' || chr(10) || '  AND P233.IMPORTO_DA = 0' || chr(10) || ')' || chr(10) || '/ 100 - IMPORTO) - 0.031),-1,0, IMPORTO - TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') * ' || chr(10) || '(-- Impostazione percentuale primo scaglione CPDEL/CPS ' || chr(10) || 'SELECT P233.PERC_IMP FROM P232_SCAGLIONI P232,P233_SCAGLIONIFASCE P233 ' || chr(10) || '  WHERE P232.COD_CONTRATTO = P442.COD_CONTRATTO' 
            || chr(10) || '  AND P232.COD_VOCE = P442.COD_VOCE' || chr(10) || '  AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || '  AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO' || chr(10) || '       AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '       AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '       AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || '  AND P232.ID_SCAGLIONE = P233.ID_SCAGLIONE' || chr(10) || '  AND P233.IMPORTO_DA = 0' || chr(10) || ')' || chr(10) || '/ 100) DATO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11160 BASE'',''11170 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || ')', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('UNIEMENS', to_date('01-01-2010', 'dd-mm-yyyy'), 'D355', 'MalACredAltre', 'Informazioni relative ad altre causali di recupero dell’indennità di malattia', 'D350', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D046', 'OrarioContrattuale', 'Numero ore settimanali previste dal contratto di lavoro', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D047', 'PercPartTime', 'Percentuale di part-time indicata nel contratto di lavoro', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D030', 'Qualifica3', 'Qualifica3 (tipo tempo)', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D035', 'TipoContribuzione', 'Tipo contribuzione', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D040', 'CodiceComune', 'Comune in cui il lavoratore svolge prevalentemente la propria attività lavorativa', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D045', 'CodiceContratto', 'Codice contratto (EP per gli enti pubblici)', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'C015', 'Nome', 'Nome del collaboratore', 'A450', 'L20', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'C020', 'TipoRapporto', 'Tipo rapporto', 'A450', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
    insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
    values ('EMENS', to_date('01-01-2005', 'dd-mm-yyyy'), 'D095', 'RetribTeorica', 'Retribuzione teorica del mese', 'D080', null, 'S', 'P1000', null, 'N', 'SELECT NVL(SUM(IMPORTO),0) IMPORTO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND ' || chr(10) || 'P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND DATA_CEDOLINO= :DataElaborazione' || chr(10) || 'AND TO_CHAR(P442.DATA_COMPETENZA_A,''MMYYYY'') = TO_CHAR(P441.DATA_RETRIBUZIONE,''MMYYYY'')' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''14200 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''', 'SELECT NVL(SUM(IMPORTO),0) IMPORTO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND ' || chr(10) || 'P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND DATA_CEDOLINO= :DataElaborazione' || chr(10) || 'AND TO_CHAR(P442.DATA_COMPETENZA_A,''MMYYYY'') = TO_CHAR(P441.DATA_RETRIBUZIONE,''MMYYYY'')' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''14200 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''', 'N', null, null, null, 'N', to_date('31-12-2009', 'dd-mm-yyyy'));
  end if;
end;
/

-- *********************************************************************************
-- IMPOSTAZIONE NUOVO SCAGLIONE PER INPGI
-- ****************  2010 ****************
-- *********************************************************************************

declare 
  AnnoNuovo integer;
  Scaglione real;

begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2010;
  -- IMPOSTARE QUI IL NUOVO SCAGLIONE PER MAGGIORAZIONE 1%
  Scaglione:=40602;

  UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_A=Scaglione WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));


  UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_DA=Scaglione+0.01 WHERE P233.IMPORTO_A=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
 
end;

/

-- CREAZIONE POSIZIONE ECONOMICA MV116 COPIANDOLA DA MV121

declare 
  ID_P221 integer;
  
  CURSOR C1 IS  
  select * from p220_livelli t where T.COD_CONTRATTO='EDP' AND t.cod_posizione_economica='MV121'
  and not exists
  (select 'X' from p220_livelli t where T.COD_CONTRATTO='EDP' AND t.cod_posizione_economica='MV116')
  order by t.decorrenza;

begin
  FOR T1 IN C1 LOOP

  SELECT P221_ID_LIVELLO.NEXTVAL INTO ID_P221 FROM DUAL;

  insert into p220_livelli
    (cod_contratto, cod_posizione_economica, decorrenza, id_livello, categoria_economica, cod_livello, descrizione, decorrenza_fine, cod_posizione_economica_succ)
  values
    (t1.cod_contratto, 'MV116', t1.decorrenza, ID_P221, t1.categoria_economica, t1.cod_livello, 
    'Dirigente veterinario I livello (ex 10° legge 724/94)', 
    t1.decorrenza_fine, t1.cod_posizione_economica_succ);
   
  INSERT INTO P221_LIVELLIIMPORTI
  select ID_P221, cod_voce, cod_voce_speciale, importo, erogazione_mesi from p221_livelliimporti v
  where v.id_livello=t1.id_livello;
  
  UPDATE P221_LIVELLIIMPORTI T SET T.IMPORTO=235.07 
  where t.id_livello=ID_P221 and t.cod_voce='00210' and t.importo=86.08;

  UPDATE P221_LIVELLIIMPORTI T SET T.IMPORTO=285.07 
  where t.id_livello=ID_P221 and t.cod_voce='00210' and t.importo=147.64;

  UPDATE P221_LIVELLIIMPORTI T SET T.IMPORTO=357.96 
  where t.id_livello=ID_P221 and t.cod_voce='00210' and t.importo=230.14;

  UPDATE P221_LIVELLIIMPORTI T SET T.IMPORTO=88.72 
  where t.id_livello=ID_P221 and t.cod_voce='00215' and t.importo=216.55;

  END LOOP;

end;

/

create index I006_ID on I006_MSGDATI (ID) tablespace INDICI;
create index I006_TIPO_ID on I006_MSGDATI(TIPO,ID) tablespace INDICI;

INSERT INTO T001_PARAMETRIFUNZIONI  (PROG,NOME,VALORE,PROGOPERATORE)
SELECT 'S101','ASSENZE',T1.VALORE||T2.VALORE||T3.VALORE||T4.VALORE||T5.VALORE||T6.VALORE||T7.VALORE||T8.VALORE,T1.PROGOPERATORE
FROM T001_PARAMETRIFUNZIONI T1,T001_PARAMETRIFUNZIONI T2, T001_PARAMETRIFUNZIONI T3, T001_PARAMETRIFUNZIONI T4, T001_PARAMETRIFUNZIONI T5, T001_PARAMETRIFUNZIONI T6, T001_PARAMETRIFUNZIONI T7, T001_PARAMETRIFUNZIONI T8 
WHERE T1.PROG = 'S101' AND T1.NOME = 'ASSENZE1' 
 AND T1.PROG = T2.PROG AND T2.NOME = 'ASSENZE2' AND T1.PROGOPERATORE = T2.PROGOPERATORE
 AND T1.PROG = T3.PROG AND T3.NOME = 'ASSENZE3' AND T1.PROGOPERATORE = T3.PROGOPERATORE
 AND T1.PROG = T4.PROG AND T4.NOME = 'ASSENZE4' AND T1.PROGOPERATORE = T4.PROGOPERATORE
 AND T1.PROG = T5.PROG AND T5.NOME = 'ASSENZE5' AND T1.PROGOPERATORE = T5.PROGOPERATORE
 AND T1.PROG = T6.PROG AND T6.NOME = 'ASSENZE6' AND T1.PROGOPERATORE = T6.PROGOPERATORE
 AND T1.PROG = T7.PROG AND T7.NOME = 'ASSENZE7' AND T1.PROGOPERATORE = T7.PROGOPERATORE 
 AND T1.PROG = T8.PROG AND T8.NOME = 'ASSENZE8' AND T1.PROGOPERATORE = T8.PROGOPERATORE;

