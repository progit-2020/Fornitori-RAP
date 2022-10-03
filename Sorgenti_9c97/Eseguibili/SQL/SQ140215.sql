update MONDOEDP.I090_ENTI set VERSIONEDB = '9.2',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table T240_ORGANIZZAZIONISINDACALI add COD_REGIONALE varchar2(4);

create bitmap index T033I_NOMEPAGINA on T033_LAYOUT (NOMEPAGINA) tablespace INDICI storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;

create index T033I_NOMEPAGINA on T033_LAYOUT (NOMEPAGINA) tablespace INDICI storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;

update MONDOEDP.I073_FILTROFUNZIONI set TAG = TAG - 530
where TAG between 613 AND 629 
and FUNZIONE is null;

delete from MONDOEDP.I073_FILTROFUNZIONI where TAG = 89;

alter table M020_TIPIRIMBORSI add FLAG_MEZZO_PROPRIO varchar2(1) default 'N';
comment on column M020_TIPIRIMBORSI.FLAG_MEZZO_PROPRIO is 'S=la pagina di richiesta missioni (nella sezione mezzi di trasporto) visualizza la scelta della corresponsione delle spese  viaggio, N=nessun comportamento ulteriore';

update M020_TIPIRIMBORSI set FLAG_MEZZO_PROPRIO = 'S' where FLAG_TARGA = 'S';

comment on column M020_TIPIRIMBORSI.PERCENTUALE is 'Obsoleto'/*--NOLOG--*/;
comment on column M020_TIPIRIMBORSI.FLAG_MEZZO_TRASPORTO is 'Obsoleto'/*--NOLOG--*/;

drop view V430_STORICO;

alter table T430_STORICO add INDIRIZZO_DOM_BASE varchar2(80);
alter table T430_STORICO add COMUNE_DOM_BASE varchar2(6);
alter table T430_STORICO add CAP_DOM_BASE varchar2(5);

alter table T430_STORICO modify INDIRIZZO varchar2(80);

comment on column T430_STORICO.INDIRIZZO is 'Indirizzo di residenza';
comment on column T430_STORICO.COMUNE is 'Comune di residenza';
comment on column T430_STORICO.CAP is 'CAP di residenza';

comment on column T430_STORICO.INDIRIZZO_DOM_BASE is 'Indirizzo di domicilio';
comment on column T430_STORICO.COMUNE_DOM_BASE is 'Comune di domicilo';
comment on column T430_STORICO.CAP_DOM_BASE is 'CAP di domicilio';

insert into I010_CAMPIANAGRAFICI (APPLICAZIONE, NOME_CAMPO, NOME_LOGICO)
  select distinct APPLICAZIONE, 'T430INDIRIZZO_DOM_BASE', 'INDIRIZZO_DOM_BASE'
  from   I010_CAMPIANAGRAFICI;
  
insert into I010_CAMPIANAGRAFICI (APPLICAZIONE, NOME_CAMPO, NOME_LOGICO)
  select distinct APPLICAZIONE, 'T430COMUNE_DOM_BASE', 'COMUNE_DOM_BASE'
  from   I010_CAMPIANAGRAFICI;

insert into I010_CAMPIANAGRAFICI (APPLICAZIONE, NOME_CAMPO, NOME_LOGICO)
  select distinct APPLICAZIONE, 'T430CAP_DOM_BASE', 'CAP_DOM_BASE'
  from   I010_CAMPIANAGRAFICI;
  
insert into T033_LAYOUT (NOME,TOP,LFT,CAPTION,ACCESSO,NOMEPAGINA,CAMPODB)
  select distinct NOME,6,4,'Indirizzo di domicilio','N','Domicilio','INDIRIZZO_DOM_BASE'
  from t033_layout;
  
insert into T033_LAYOUT (NOME,TOP,LFT,CAPTION,ACCESSO,NOMEPAGINA,CAMPODB)
  select distinct NOME,6,220,'Comune di domicilio','N','Domicilio','D_COMUNE_DOM_BASE'
  from t033_layout;

insert into T033_LAYOUT (NOME,TOP,LFT,CAPTION,ACCESSO,NOMEPAGINA,CAMPODB)
  select distinct NOME,6,420,'CAP dom.','N','Domicilio','CAP_DOM_BASE'
  from t033_layout;

insert into T033_LAYOUT (NOME,TOP,LFT,CAPTION,ACCESSO,NOMEPAGINA,CAMPODB)
  select distinct NOME,6,470,'Prov. dom.','N','Domicilio','D_PROVINCIA_DOM_BASE'
  from t033_layout;

delete MONDOEDP.i091_datiente where tipo = 'C21_VALUTAZIONI_STAMPA1';

create table I025_CESTINO
(
  tabella VARCHAR2(40),
  chiave  VARCHAR2(2000),
  id      VARCHAR2(2000) not null,
  utente  VARCHAR2(30),
  data    DATE
)
tablespace LAVORO
storage (initial 256K next 256K pctincrease 0);

comment on column I025_CESTINO.tabella
  is 'Nome tabella del record cancellato';
comment on column I025_CESTINO.chiave
  is 'Codice originale del record cancellato';
comment on column I025_CESTINO.utente
  is 'Utente che ha effettuato la cancellazione';
comment on column I025_CESTINO.data
  is 'Data in cui è avvenuta la cencellazione';

alter table I025_CESTINO
  add constraint I025_PK primary key (ID,TABELLA)
  using index tablespace INDICI 
    storage (initial 256K next 256K pctincrease 0);

create table SG250_SMARTCARD (
  PROGRESSIVO           number(8)     not null,
  DECORRENZA            date          not null,
  DECORRENZA_FINE       date,
  TIPO_CARTA            varchar2(3)   not null,
  TIPO_TOKEN            varchar2(3),
  CELLULARE             varchar2(15),
  COD_CARTA             varchar2(100) not null,
  ENTE_EMITTENTE        varchar2(100),
  DATA_EMISSIONE        date,
  DATA_ATTIVAZIONE      date,
  DATA_SCADENZA         date,
  DATA_SOSPENSIONE      date,
  RIMBORSO_DATO         varchar2(1)   default 'N',
  STATO                 varchar2(3),
  TIPI_UTILIZZO         varchar2(50)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG250_SMARTCARD
add constraint SG250_PK primary key (PROGRESSIVO,DECORRENZA,TIPO_CARTA,COD_CARTA)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG251_TIPI_SMARTCARD (
  TIPO                  varchar2(20)   not null,
  CODICE                varchar2(3)    not null,
  DESCRIZIONE           varchar2(100),
  ABILITA_TIPO_TOKEN    varchar2(1)    default 'N'
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG251_TIPI_SMARTCARD
add constraint SG251_PK primary key (TIPO,CODICE)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

--Script nuova gestione progressiva pianificazione turni
alter table T082_PAR_PIANIFORARI add rendi_operativa varchar2(1) default 'N';
comment on column T082_PAR_PIANIFORARI.rendi_operativa
  is 'Abilità il pulsante per rendere operativa una pianificazione';
alter table T082_PAR_PIANIFORARI add assenze_operative VARCHAR2(1) default 'N';
comment on column T082_PAR_PIANIFORARI.assenze_operative
  is 'Permette l''inserimento su tabella T040 delle assenze';
  
declare
  MyValore varchar2(1);
begin  
  select decode(I091.DATO,'OPERATIVA','S','N') into MyValore
    from I091_DATIENTE I091
   where I091.AZIENDA = :AZIENDA
     and I091.TIPO = 'C11_PIANIFORARI_NO_GIUSTIF';  
     
  update T082_PAR_PIANIFORARI T082
     set T082.ASSENZE_OPERATIVE  = MyValore
   where T082.MODALITA_LAVORO = 'N';
	 
  commit;
end;
/  
  
create index SG650I_CODICEEDIZIONE on SG650_TESTATACORSI (CODICE||'#'||EDIZIONE) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index SG651I_PROGR_DATA_CORSO on SG651_PIANIFICAZIONECORSI (PROGRESSIVO,DATA_CORSO) tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create sequence T250_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

create table T250_SCIOPERI (
  ID number(38),
  DATA date not null,
  CAUSALE varchar2(5),
  TIPOGIUST varchar2(1),
  DAORE varchar2(5),
  AORE varchar2(5),
  SELEZIONE_ANAGRAFICA varchar2(2000),
  GG_NOTIFICA number(2) default 0
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T250_SCIOPERI add constraint T250_PK primary key (ID) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create unique index T250I_DATA on T250_SCIOPERI (DATA) tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column T250_SCIOPERI.ID is 'T250_ID.nextval';
comment on column T250_SCIOPERI.DATA is 'data dello sciopero';
comment on column T250_SCIOPERI.CAUSALE is 'causale da utilizzare per l''inserimento automatico';
comment on column T250_SCIOPERI.TIPOGIUST is 'modalità di fruizione dello sciopero I/M/N/D';
comment on column T250_SCIOPERI.DAORE is 'ora di inizio sciopero se TIPOGIUST = D o numero di ore se TIPOGIUST=N';
comment on column T250_SCIOPERI.AORE is 'ora di fine sciopero se TIPOGIUST = D';
comment on column T250_SCIOPERI.SELEZIONE_ANAGRAFICA is 'selezione delle anagrafiche interessate dallo sciopero';
comment on column T250_SCIOPERI.GG_NOTIFICA is 'numero di giorni antecedenti all''evento in cui visualizzare la notifica di iter non completo all''accesso in IrisWEB';

create table T251_SCIOPERI_STRUTTURA (
  ID_T250 number(38),
  ID number(38),
  PROGRESSIVO number(38),
  MINIMO number(4)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T251_SCIOPERI_STRUTTURA add constraint T251_PK primary key (ID_T250,PROGRESSIVO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T251_SCIOPERI_STRUTTURA add constraint T250_FK_T251 foreign key (ID_T250) references T250_SCIOPERI (ID);
alter table T251_SCIOPERI_STRUTTURA add constraint T251_UQ unique (ID) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column T251_SCIOPERI_STRUTTURA.ID_T250 is 'T250.ID';
comment on column T251_SCIOPERI_STRUTTURA.ID is 'T850_ID.nextval';
comment on column T251_SCIOPERI_STRUTTURA.PROGRESSIVO is 'Progressivo anagrafico dell''account che fa la richiesta, normalmente è un responsabile di struttura';
comment on column T251_SCIOPERI_STRUTTURA.MINIMO is 'Numero minimo di dipendenti richiesti in servizio';

create table T252_SCIOPERI_INDIVIDUALI (
  ID number(38),
  PROGRESSIVO number(38),
  SCIOPERA varchar2(1)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T252_SCIOPERI_INDIVIDUALI add constraint T252_PK primary key (ID,PROGRESSIVO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T252_SCIOPERI_INDIVIDUALI add constraint T251_FK_T252 foreign key (ID) references T251_SCIOPERI_STRUTTURA (ID) on delete cascade;

comment on column T252_SCIOPERI_INDIVIDUALI.ID is 'T251.ID';
comment on column T252_SCIOPERI_INDIVIDUALI.PROGRESSIVO is 'Progressivo anagrafico del dipendente di cui indicare la parteciapzione allo sciopero';
comment on column T252_SCIOPERI_INDIVIDUALI.SCIOPERA is 'S=il dipendente partecipa allo sciopero, N=il dipendente non partecipa allo sciopero';

-- INIZIO CREAZIONE INCARICO MV025-016-2010-S2002

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      INSERT INTO I501INCARICO SELECT 'MV025-016-2010-S2002','Dirigente medico incarico lett. c) con struttura complessa area territorio (dec. 2010-2014) - semplice (dec. 2002)' FROM DUAL WHERE NOT EXISTS (SELECT 'X' FROM I501INCARICO T WHERE T.CODICE='MV025-016-2010-S2002');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV025-016-2010-S2002', DECORRENZA, 'Dir. medico lett. c) con S.C. territorio (dec. 2010-2014) - S.S. (dec. 2002)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00208',159.72,'00212',482.31) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV025-011-2010-S2002' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV025-016-2010-S2002');

    end if;
  end if;
end/*--NOLOG--*/;
/

-- FINE CREAZIONE INCARICO MV025-016-2010-S2002

alter table T282_MESSAGGI add LETTURA_OBBLIGATORIA varchar2(1) default 'N';
comment on column T282_MESSAGGI.LETTURA_OBBLIGATORIA is 'S=se il messaggio non è stato ancora letto forza l''apertura della pagina di lettura messaggi all''accesso in IrisWEB';
