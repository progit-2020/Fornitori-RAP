update MONDOEDP.I090_ENTI set VERSIONEDB = '8.6',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

update p200_voci t set t.cod_voce_stampa='10440 '
where t.cod_contratto='EDPSC' and t.cod_voce='10440' and t.cod_voce_speciale='BASE'
and t.cod_voce<>trim(t.cod_voce_stampa);

---------------------------
-- INIZIO Riduzione per assenza 15070 voce 00030
---------------------------

declare 
  i integer;
  ID_P200 integer;

begin
select COUNT(*) into i from P200_VOCI t where T.COD_CONTRATTO='EDP' AND T.COD_VOCE='00030' AND T.COD_VOCE_SPECIALE='15075'
AND EXISTS
  (select 'x' from P200_VOCI Z WHERE Z.COD_CONTRATTO='EDP' AND Z.COD_VOCE='15070' AND Z.COD_VOCE_SPECIALE='BASE')
AND NOT EXISTS
  (select 'x' from P200_VOCI V WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE='00030' AND V.COD_VOCE_SPECIALE='15070');
if i > 0 then

    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
   
    INSERT INTO P200_VOCI
    select cod_contratto, cod_voce, '15070', decorrenza, ID_P200, 'Riduzione per distacco sindacale', cod_voce_stampa, 'Riduzione per distacco sindacale', protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario
    from p200_voci P200 WHERE p200.COD_CONTRATTO='EDP' AND p200.COD_VOCE='00030' AND p200.COD_VOCE_SPECIALE='15075';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, cod_voce_padre, '15070', cod_voce_figlio,
    cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
    FROM P201_ASSOGGETTAMENTI P201 WHERE p201.COD_CONTRATTO='EDP' AND p201.cod_voce_padre='00030' AND p201.cod_voce_speciale_padre='15075';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, cod_voce_padre, cod_voce_speciale_padre, '14100',
    cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
    FROM P201_ASSOGGETTAMENTI P201 WHERE p201.COD_CONTRATTO='EDP' AND p201.cod_voce_padre='00030' AND p201.cod_voce_speciale_padre='15070'
       and p201.cod_voce_figlio='14120' and p201.cod_voce_speciale_figlio='BASE';

    INSERT INTO P205_QUOTE
    select cod_contratto, cod_voce_da_quotare, cod_voce_speciale_da_quotare, '00030', cod_voce_speciale_in_quota, decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio
    from p205_quote T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE='15070' AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE'
      AND T.COD_VOCE_IN_QUOTA='00010' AND T.COD_VOCE_SPECIALE_IN_QUOTA='BASE';

    INSERT INTO P216_ACCORPAMENTOVOCI
    select cod_contratto, cod_voce, '15070', cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine from p216_accorpamentovoci T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE= '00030' AND T.COD_VOCE_SPECIALE='15075';

end if;
end;

---------------------------
-- FINE Riduzione per assenza 15070 voce 00030
---------------------------
/


ALTER TABLE T433_CDC_PERCENT MODIFY PERCENTUALE DEFAULT 100;

alter table SG508_STAMPAPIANTA add RIGHE_IMPAGINAZIONE varchar2(1) default 'N';

alter table SG101_FAMILIARI add NOTE varchar2(2000);

alter table T263_PROFASSIND add NOTE varchar2(2000);

alter table T262_PROFASSANN add FORMULA_PROPORZIONE varchar2(2000);
comment on column T262_PROFASSANN.FORMULA_PROPORZIONE is 'espressione sql per personalizzare il calcolo della proporzione delle competenze';

alter table MONDOEDP.I090_ENTI add PASSWORD_CIFRE number(1) default 0;
alter table MONDOEDP.I090_ENTI add PASSWORD_MAIUSCOLE number(1) default 0;
alter table MONDOEDP.I090_ENTI add PASSWORD_CARSPECIALI number(1) default 0;

comment on column MONDOEDP.I090_ENTI.PASSWORD_CIFRE is 'numero di cifre obbligatorie nella password';
comment on column MONDOEDP.I090_ENTI.PASSWORD_MAIUSCOLE is 'numero di lettere maiuscole obbligatore nella password';
comment on column MONDOEDP.I090_ENTI.PASSWORD_CARSPECIALI is 'numero di caratteri speciali obbligatori nella password tra cui: !%&/()=@#-_';

create table MONDOEDP.I065_EXPR_ACCOUNT (
  TIPO varchar2(1),
  CODICE varchar2(20),
  ESPRESSIONE varchar2(2000)
) 
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table MONDOEDP.I065_EXPR_ACCOUNT add constraint I065_PK primary key (TIPO,CODICE) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

insert into MONDOEDP.I065_EXPR_ACCOUNT (TIPO,CODICE,ESPRESSIONE)
select distinct decode(NOME,'EXPR_UTENTE','U','P') TIPO,substr(VALORE,1,20), VALORE 
from T001_PARAMETRIFUNZIONI t 
where PROG = 'A008' and NOME in ('EXPR_UTENTE','EXPR_PASSWORD') and trim(VALORE) is not null;

alter table I000_LOGINFO add HOSTNAME varchar2(24);
alter table I000_LOGINFO add HOSTIPADDRESS varchar2(39);

comment on column I000_LOGINFO.HOSTNAME 
  is 'Hostname della macchina che ha eseguito l''operazione';
comment on column I000_LOGINFO.HOSTIPADDRESS 
  is 'Indirizzo IP della macchina che ha eseguito l''operazione';  

create table I200_PUBBL_DOC (
  CODICE         varchar2(10),
  DESCRIZIONE    varchar2(100),
  FILTRO         varchar2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
  
comment on column I200_PUBBL_DOC.CODICE is 'Codice della tipologia di documento';
comment on column I200_PUBBL_DOC.DESCRIZIONE is 'Descrizione della tipologia di documento';
comment on column I200_PUBBL_DOC.FILTRO is 'Eventuale filtro di visualizzazione della tipologia';
  
alter table I200_PUBBL_DOC 
  add constraint I200_PK primary key (CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table I201_PUBBL_DOC_PATH (
  CODICE         varchar2(10),
  LIVELLO        number(3),
  NOME           varchar2(200),
  EXT            varchar2(10),
  SEPARATORE     varchar2(5),
  FILTRO         varchar2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column I201_PUBBL_DOC_PATH.CODICE is 'Codice della tipologia di documento';
comment on column I201_PUBBL_DOC_PATH.LIVELLO is 'Livello del path. 0=livello radice';
comment on column I201_PUBBL_DOC_PATH.NOME is 'Nome descrittivo della cartella o del file che ne evidenzia la struttura';
comment on column I201_PUBBL_DOC_PATH.EXT is 'Estensione del file senza il prefisso "."';
comment on column I201_PUBBL_DOC_PATH.SEPARATORE is 'Separatore dei campi che compongono la struttura del nome';
comment on column I201_PUBBL_DOC_PATH.FILTRO is 'Eventuale filtro di visualizzazione del livello';

alter table I201_PUBBL_DOC_PATH 
  add constraint I201_PK primary key (CODICE, LIVELLO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
  
alter table I201_PUBBL_DOC_PATH
  add constraint I201_FK_I200 foreign key (CODICE)
  references I200_PUBBL_DOC (CODICE) on delete cascade;
  
create table I202_PUBBL_DOC_DESC (
  CODICE         varchar2(10),
  LIVELLO        number(3),
  CAMPO          varchar2(20),
  DAL            number(3),
  LUNG           number(3),
  VISIBILE       varchar2(1) default 'N'
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);  
  
comment on column I202_PUBBL_DOC_DESC.CODICE is 'Codice della tipologia di documento';
comment on column I202_PUBBL_DOC_DESC.LIVELLO is 'Livello del path. 0=livello radice';
comment on column I202_PUBBL_DOC_DESC.DAL is 'Posizione iniziale del campo oppure posizione di riferimento nel caso di utilizzo del separatore di campo';
comment on column I202_PUBBL_DOC_DESC.LUNG is 'Lunghezza del campo nel caso di dati posizionali';
comment on column I202_PUBBL_DOC_DESC.CAMPO is 'Nome del campo costante oppure variabile. Per convenzione i campi variabili devono avere come prefisso il carattere ":". Il confronto è case-insensitive';
comment on column I202_PUBBL_DOC_DESC.VISIBILE is 'S=il campo è visibile nella tabella web,N=il campo non è visibile nella tabella web';

alter table I202_PUBBL_DOC_DESC 
  add constraint I202_PK primary key (CODICE, LIVELLO, DAL)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
  
alter table I202_PUBBL_DOC_DESC
  add constraint I202_FK_I201 foreign key (CODICE, LIVELLO)
  references I201_PUBBL_DOC_PATH (CODICE, LIVELLO) on delete cascade;

alter table T710_BUDGETESTERNO_ANNUO add UTILIZZO number;

--backup tabelle valutazioni prima della versione 8.6
create table AGG85_SG701 as select * from SG701_AREE_VALUTAZIONI;
create table AGG85_SG700 as select * from SG700_VALUTAZIONI;
create table AGG85_SG705 as select * from SG705_VALUTATORI;
create table AGG85_SG706 as select * from SG706_VALUTATORI_DIPENDENTE;
create table AGG85_SG710 as select * from SG710_TESTATA_VALUTAZIONI;
create table AGG85_SG711 as select * from SG711_VALUTAZIONI_DIPENDENTE;
create table AGG85_SG720 as select * from SG720_PROFILI_AREE;
create table AGG85_SG730 as select * from SG730_PUNTEGGI;
create table AGG85_SG735 as select * from SG735_PUNTEGGIFASCE_INCENTIVI;
create table AGG85_SG740 as select * from SG740_REGOLE_VALUTAZIONI;

create table sg745_consegna_valutazioni
(data date not null,
 progressivo number(8) not null,
 tipo_valutazione varchar2(1) not null,
 stato_avanzamento number(2) not null,
 utente varchar2(30) not null,
 data_consegna date)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table sg745_consegna_valutazioni
  add constraint SG745_PK primary key (DATA, PROGRESSIVO, TIPO_VALUTAZIONE, STATO_AVANZAMENTO, UTENTE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG741_REGOLE_VALUTAZIONI (
decorrenza date not null,
decorrenza_fine date,
codice varchar2(5) not null,
descrizione varchar2(100),
filtro_anagrafe varchar2(4000) not null,
--generale
path_istruzioni varchar2(1000),
giorni_minimi number(3),
cod_tipi_rapporto varchar2(400),
pagine_abilitate varchar2(50),
--stampa
logo_larghezza number(3),
logo_altezza number(3),
dato_stampa_1 varchar2(30),
dato_stampa_2 varchar2(30),
dato_stampa_3 varchar2(30),
dato_stampa_4 varchar2(30),
dato_stampa_5 varchar2(30),
dato_stampa_6 varchar2(30),
desc_lunga_1 varchar2(1) default 'N',
desc_lunga_3 varchar2(1) default 'N',
desc_lunga_5 varchar2(1) default 'N',
stampa_variazioni_5 varchar2(1) default 'N',
aggiorna_data_compilazione varchar2(1) default 'N',
stampa_periodo_valutazione varchar2(1) default 'N',
--firme
dato_variazione_valutatore varchar2(30),
--pagine
testo_valutazioni_complessive varchar2(500),
assegn_preventiva_obiettivi varchar2(1) default 'N',
data_da_obiettivi date,
data_a_obiettivi date,
abilita_aree_formative varchar2(1) default 'N',
area_formativa_obbligatoria varchar2(1) default 'N',
abilita_accettazione_valutato varchar2(1) default 'N',
abilita_commenti_valutato varchar2(1) default '1',
modifica_note_supervisorevalut varchar2(1) default 'N',
--campi opzionali
campi_opzionali_stampa varchar2(10),
campi_opzionali_compilazione varchar2(10)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG741_REGOLE_VALUTAZIONI
  add constraint SG741_PK primary key (DECORRENZA,CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG746_STATI_AVANZAMENTO
(decorrenza date not null,
decorrenza_fine date,
codice number(2) not null,
codregola varchar2(5) not null,
descrizione varchar2(50),
modificabile varchar2(1) default 'S',
codstampa number(2)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG746_STATI_AVANZAMENTO
  add constraint SG746_PK primary key (DECORRENZA,CODICE,CODREGOLA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table SG710_TESTATA_VALUTAZIONI add stato_avanzamento number(2);
UPDATE SG710_TESTATA_VALUTAZIONI SET STATO_AVANZAMENTO = 1 WHERE STATO_AVANZAMENTO IS NULL;
ALTER TABLE SG710_TESTATA_VALUTAZIONI MODIFY STATO_AVANZAMENTO NOT NULL;
alter table SG710_TESTATA_VALUTAZIONI drop constraint SG710_PK;
drop index SG710_PK;
alter table SG710_TESTATA_VALUTAZIONI
  add constraint SG710_PK primary key (DATA, PROGRESSIVO, TIPO_VALUTAZIONE, STATO_AVANZAMENTO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table SG711_VALUTAZIONI_DIPENDENTE add stato_avanzamento number(2);
UPDATE SG711_VALUTAZIONI_DIPENDENTE SET STATO_AVANZAMENTO = 1 WHERE STATO_AVANZAMENTO IS NULL;
ALTER TABLE SG711_VALUTAZIONI_DIPENDENTE MODIFY STATO_AVANZAMENTO NOT NULL;
alter table SG711_VALUTAZIONI_DIPENDENTE drop constraint SG711_PK;
drop index SG711_PK;
alter table SG711_VALUTAZIONI_DIPENDENTE
  add constraint SG711_PK primary key (DATA, PROGRESSIVO, TIPO_VALUTAZIONE, STATO_AVANZAMENTO, COD_AREA, COD_VALUTAZIONE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table I071_PERMESSI add s710_stati_abilitati varchar2(200);
alter table SG710_TESTATA_VALUTAZIONI add progressivi_valutatori varchar2(50);

alter table SG701_AREE_VALUTAZIONI add item_tutti_valutabili varchar2(1) default 'N';
alter table SG701_AREE_VALUTAZIONI add item_personalizzati_min number(2) default 0;
alter table SG701_AREE_VALUTAZIONI add item_personalizzati_max number(2) default 0;
alter table SG701_AREE_VALUTAZIONI add tipo_peso_percentuale varchar2(1) default '0';
alter table SG700_VALUTAZIONI add peso_percentuale number(5,2);

alter table SG701_AREE_VALUTAZIONI add tipo_link_item varchar2(1) default '0';
alter table SG700_VALUTAZIONI add cod_area_link varchar2(5);
alter table SG700_VALUTAZIONI add cod_valutazione_link varchar2(5);

create table SG742_ETICHETTE_VALUTAZIONI (
DECORRENZA date not null,
CODREGOLA varchar2(5) not null,
NOME_CAMPO varchar2(40) not null,
DESCRIZIONE varchar2(50),
ETICHETTA varchar2(40),
ORDINE number
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG742_ETICHETTE_VALUTAZIONI
  add constraint SG742_PK primary key (DECORRENZA,CODREGOLA,NOME_CAMPO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table sg710_testata_valutazioni add punteggio_finale_pesato number(5,2);

alter table SG701_AREE_VALUTAZIONI add stati_abilitati varchar2(200) /*--NOLOG--*/;
alter table SG701_AREE_VALUTAZIONI add stati_abilitati_punteggi varchar2(200);
update SG701_AREE_VALUTAZIONI set stati_abilitati_punteggi = stati_abilitati
where not exists (select 1 from SG701_AREE_VALUTAZIONI where stati_abilitati_punteggi is not null);
alter table SG701_AREE_VALUTAZIONI DROP COLUMN stati_abilitati;
alter table SG701_AREE_VALUTAZIONI add stati_abilitati_elementi varchar2(200);

alter table SG701_AREE_VALUTAZIONI add PESO_EQUO_ITEMS varchar2(1) default 'S';

alter table SG701_AREE_VALUTAZIONI add testo_item_personalizzati varchar2(500);

alter table sg711_valutazioni_dipendente add punteggio_pesato number(5,2);

alter table SG701_AREE_VALUTAZIONI add (peso_perc_min number(5,2), peso_perc_max number(5,2));
update sg701_aree_valutazioni set peso_perc_min = peso_percentuale, peso_perc_max = peso_percentuale
where peso_perc_min is null or peso_perc_max is null;

alter table SG711_VALUTAZIONI_DIPENDENTE modify desc_valutazione_agg varchar2(1000);

alter table SG701_AREE_VALUTAZIONI add punteggi_solo_item_valutabili varchar2(1) default 'N';
update SG701_AREE_VALUTAZIONI set punteggi_solo_item_valutabili = 'S' where tipo_link_item = '1';

alter table SG711_VALUTAZIONI_DIPENDENTE add note_punteggio varchar2(500);
alter table SG730_PUNTEGGI add giustifica varchar2(1) default 'N';

alter table SG710_TESTATA_VALUTAZIONI add NOTE varchar2(500);

alter table SG746_STATI_AVANZAMENTO add (data_da date, data_a date);

alter table SG701_AREE_VALUTAZIONI drop column area_libera /*--NOLOG--*/;
alter table SG710_TESTATA_VALUTAZIONI drop column tipo_stampa /*--NOLOG--*/;

UPDATE MONDOEDP.I073_FILTROFUNZIONI
SET DESCRIZIONE = 'Elaborazione schede di valutazione'
WHERE TAG = '347'
AND DESCRIZIONE = 'Stampa scheda valutazioni';

--solo per ambienti di test:
alter table SG741_REGOLE_VALUTAZIONI drop column firma_1 /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI drop column firma_2 /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI drop column firma_3 /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI drop column firma_4 /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI drop column firma_5 /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI drop column firma_6 /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI drop column label_valutato /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI drop column label_valutatore /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI drop column label_pfp /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI drop column label_valutazioni_complessive /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI drop column data_da /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI drop column data_a /*--NOLOG--*/;
alter table SG741_REGOLE_VALUTAZIONI add modifica_note_supervisorevalut varchar2(1) default 'N' /*--NOLOG--*/;

alter table T760_REGOLEINCENTIVI add scaglioni_ggeff VARCHAR2(1) default 'N';
comment on column T760_REGOLEINCENTIVI.scaglioni_ggeff
  is 'Applica percentuale sui giorni effettivamente lavorati in base a scaglioni';

comment on column SG735_PUNTEGGIFASCE_INCENTIVI.tipologia
  is 'Tipo di gestione (V=valutazioni, I=incentivi part-time, G=incentivi gg.eff.lavorati)';

alter table T265_CAUASSENZE add SIGLA_CAUSALE varchar2(5);
comment on column T265_CAUASSENZE.SIGLA_CAUSALE is 'sigla sintetica della causale usata nel prospetto assenze';

UPDATE t480_comuni t SET T.CITTA='SANTO STINO DI LIVENZA' WHERE T.CODCATASTALE='I373';

UPDATE t480_comuni t SET T.CITTA='SAN VALENTINO IN ABRUZZO CITERIORE' WHERE T.CODCATASTALE='I376';

UPDATE t480_comuni t SET T.CITTA='TRODENA NEL PARCO NATURALE' WHERE T.CODCATASTALE='L444';

comment on column T850_ITER_RICHIESTE.ID_REVOCA is 'ID della richiesta che revoca l''attuale, oppure -1 se sono presenti cancellazioni relative a questa richiesta';

comment on column T850_ITER_RICHIESTE.ID_REVOCATO is 'ID della richiesta da revocare; se not null indica che la richiesta corrente è una revoca (valore > 0) o una cancellazione di periodo (valore = -1)';

create index T850I_IDREVOCATO
  on T850_ITER_RICHIESTE (ID_REVOCATO) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);