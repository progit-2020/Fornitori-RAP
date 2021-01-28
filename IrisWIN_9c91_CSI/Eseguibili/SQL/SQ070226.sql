UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '6.9',PATCHDB = 0 WHERE AZIENDA = :AZIENDA;

--Dovrebbero avere già tutti la colonna
ALTER TABLE T375_ACCESSIMENSA ADD RILEVATORE VARCHAR2(2);

alter table P552_CONTOANNREGOLE modify REGOLA_CALCOLO_AUTOMATICA VARCHAR2(4000);
alter table P552_CONTOANNREGOLE modify REGOLA_CALCOLO_MANUALE VARCHAR2(4000);
alter table P552_CONTOANNREGOLE modify CODICI_ACCORPAMENTOVOCI VARCHAR2(500); 
comment on column P552_CONTOANNREGOLE.NUMERO_TREDCORR
  is 'Codice tabella e numero della riga o colonna sostitutiva in caso di tredicesima anno corrente; NC=Non conteggiare';
comment on column P552_CONTOANNREGOLE.NUMERO_TREDPREC
  is 'Codice tabella e numero della riga o colonna sostitutiva in caso di tredicesima anno precedente; NC=Non conteggiare';
comment on column P552_CONTOANNREGOLE.NUMERO_ARRCORR
  is 'Codice tabella e numero della riga o colonna sostitutiva in caso di arretrati anno corrente; NC=Non conteggiare';
comment on column P552_CONTOANNREGOLE.NUMERO_ARRPREC
  is 'Codice tabella e numero della riga o colonna sostitutiva in caso di arretrati anno precedente; NC=Non conteggiare';
UPDATE P552_CONTOANNREGOLE
SET NUMERO_ARRPREC = 'NC'
WHERE NUMERO_ARRPREC = 'Non conteggiare';
UPDATE P552_CONTOANNREGOLE
SET NUMERO_ARRCORR = 'NC'
WHERE NUMERO_ARRCORR = 'Non conteggiare';
UPDATE P552_CONTOANNREGOLE
SET NUMERO_TREDPREC = 'NC'
WHERE NUMERO_TREDPREC = 'Non conteggiare';
UPDATE P552_CONTOANNREGOLE
SET NUMERO_TREDCORR = 'NC'
WHERE NUMERO_TREDCORR = 'Non conteggiare';
alter table P552_CONTOANNREGOLE add FILTRO_DIPENDENTI VARCHAR2(500);
comment on column P552_CONTOANNREGOLE.FILTRO_DIPENDENTI
  is 'Filtro dipendenti da inserire nella tabella';

alter table P430_ANAGRAFICO modify DETRAZ_LAVDIP default 'S';

create table SG670_CREDITIINDIVIDUALI (
  COD_CORSO varchar2(15),
  PROGRESSIVO number(8),
  CREDITI number
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table SG670_CREDITIINDIVIDUALI add constraint SG570_PK primary key (COD_CORSO,PROGRESSIVO) 
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T910_RIEPILOGO add INTESTAZIONE_COLONNE varchar2(1) default 'N';

alter table MONDOEDP.I150_PARSCARICOGIUST add TIPOFILE varchar2(1) default 'F';
comment on column MONDOEDP.I150_PARSCARICOGIUST.TIPOFILE is 'F=File sequenziale - T=Tabella Oracle';
alter table MONDOEDP.I150_PARSCARICOGIUST add ANOMALIE_BLOCCANTI varchar2(1) default 'N';
alter table MONDOEDP.I150_PARSCARICOGIUST modify matricola varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify badge varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify annoda varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify meseda varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify giornoda varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify annoa varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify mesea varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify giornoa varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify orada varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify minda varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify oraa varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify mina varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify causale varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify tipo varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify numgiorni varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST modify datada   varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST  add ID varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST  add DATAA varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST  add TIPO_OPERAZIONE varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST  add FAMILIARE varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST  add MESSAGGIO varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST  add ELABORATO varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST  add DATA_ELABORAZIONE varchar2(80);
alter table MONDOEDP.I150_PARSCARICOGIUST  add HHMMDA varchar2(80);  
alter table MONDOEDP.I150_PARSCARICOGIUST  add HHMMA varchar2(80); 
alter table T265_CAUASSENZE add CAUSALE_SUCCESSIVA varchar2(5);

--Pianta Organica
UPDATE SG509_DETTAGLIOSTAMPA SET DESCRIZIONE_STAMPA = NOME_CAMPO WHERE TIPO_CAMPO = 'R' AND DESCRIZIONE_STAMPA IS NULL;

--Qualifica ministeriale
declare
  qm varchar2(20);
  CURSORE_DINAMICO INTEGER;
  CURS INTEGER;
begin
  select nomecampo into qm from i500_datiliberi where tipo = '1';
  CURSORE_DINAMICO:=DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(CURSORE_DINAMICO,'ALTER TABLE I501'||qm||' ADD MACRO_CATEG_QM VARCHAR2(10)',DBMS_SQL.NATIVE);
  CURS:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO);
exception
  when no_data_found then null;
end;
/

-- Risorse residue conto annuale
create table P553_CONTOANNRISORRES
(
  ANNO            NUMBER(4) not null,
  COD_TABELLA     VARCHAR2(10) not null,
  COLONNA_RIGA    NUMBER(3) not null,
  MACRO_CATEG     VARCHAR2(10) not null,
  DESCRIZIONE     VARCHAR2(100),
  IMPORTO_RESIDUO NUMBER
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column P553_CONTOANNRISORRES.COD_TABELLA
  is 'Di tipo Qualifica ministeriale o Accorpamento voci';
comment on column P553_CONTOANNRISORRES.COLONNA_RIGA
  is 'Colonna se tipo tabella Qualifica ministeriale, riga se tipo tabella Accorpamento voci';
comment on column P553_CONTOANNRISORRES.MACRO_CATEG
  is 'Macro categoria se tipo tabella Qualifica ministeriale; ''0'' se tipo tabella Accorpamento voci';
comment on column P553_CONTOANNRISORRES.IMPORTO_RESIDUO
  is 'Risorsa residuale di competenza non ancora pagata';
alter table P553_CONTOANNRISORRES
  add constraint P553_PK primary key (ANNO, COD_TABELLA, COLONNA_RIGA, MACRO_CATEG)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

ALTER TABLE MONDOEDP.I070_UTENTI ADD VALIDITA_CESSATI NUMBER(3) DEFAULT 0;
COMMENT ON COLUMN MONDOEDP.I070_UTENTI.VALIDITA_CESSATI
  IS 'NUMERO MESI INDIETRO DALLA DATA DI LAVORO ENTRO CUI VEDERE I CESSATI';

ALTER TABLE SG650_TESTATACORSI MODIFY NUMERO_CREDITI NUMBER(5,2);
ALTER TABLE SG664_DOCENTI MODIFY NUMERO_CREDITI NUMBER(5,2);
ALTER TABLE SG655_PROFILICREDITI MODIFY NUMERO_CREDITI NUMBER(6,2);
ALTER TABLE SG655_PROFILICREDITI MODIFY MASSIMO NUMBER(6,2);
ALTER TABLE SG655_PROFILICREDITI MODIFY MINIMO NUMBER(6,2);
ALTER TABLE SG656_RESIDUOCREDITI MODIFY CREDITI NUMBER(10,2);
alter table SG664_DOCENTI drop primary key;
alter table SG664_DOCENTI add constraint SG664_PK primary key (COD_CORSO, DECORRENZA, PROGRESSIVO, TIPO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table  SG664_DOCENTI add ORE_INTERNE varchar2(7);
alter table  SG664_DOCENTI add ORE_ESTERNE varchar2(7);
alter table SG670_CREDITIINDIVIDUALI add DATA_EMISS_CERTIFICATO date;
create sequence SG650_CODICE
minvalue 1 maxvalue 999999999999999999999999999
start with 1 increment by 1 nocache;

alter table T265_CAUASSENZE add TIMB_PM varchar2(1) default 'N';
alter table T275_CAUPRESENZE add TIMB_PM varchar2(1) default 'N';
alter table T020_ORARI add PMT_TIMB_AUTORIZZATE varchar2(1) default 'N';
alter table T020_ORARI add PMA_PRESERVA_TIMBINFASCIA varchar2(1) default 'N';

alter table P216_ACCORPAMENTOVOCI add DECORRENZA_FINE date;
update P216_ACCORPAMENTOVOCI t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from P216_ACCORPAMENTOVOCI where 
       COD_CONTRATTO = t.COD_CONTRATTO and 
       COD_VOCE = t.COD_VOCE and 
       COD_VOCE_SPECIALE = t.COD_VOCE_SPECIALE and 
       COD_TIPOACCORPAMENTOVOCI = t.COD_TIPOACCORPAMENTOVOCI and 
       COD_CODICIACCORPAMENTOVOCI = t.COD_CODICIACCORPAMENTOVOCI and
       DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from P216_ACCORPAMENTOVOCI where 
                                    COD_CONTRATTO = t.COD_CONTRATTO and 
                                    COD_VOCE = t.COD_VOCE and 
                                    COD_VOCE_SPECIALE = t.COD_VOCE_SPECIALE and 
                                    COD_TIPOACCORPAMENTOVOCI = t.COD_TIPOACCORPAMENTOVOCI and 
                                    COD_CODICIACCORPAMENTOVOCI = t.COD_CODICIACCORPAMENTOVOCI);

update P216_ACCORPAMENTOVOCI t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from P216_ACCORPAMENTOVOCI where 
                                    COD_CONTRATTO = t.COD_CONTRATTO and 
                                    COD_VOCE = t.COD_VOCE and 
                                    COD_VOCE_SPECIALE = t.COD_VOCE_SPECIALE and 
                                    COD_TIPOACCORPAMENTOVOCI = t.COD_TIPOACCORPAMENTOVOCI and 
                                    COD_CODICIACCORPAMENTOVOCI = t.COD_CODICIACCORPAMENTOVOCI);

-- Gestione ANF
comment on column P430_ANAGRAFICO.COD_TABELLAANF
  is 'Tabella INPS di riferimento per ANF; (opzionale)';
comment on column P430_ANAGRAFICO.REDDITO_ANF
  is 'Reddito di lavoro dipendente del richiedente per ANF';
comment on column P430_ANAGRAFICO.SCADENZA_ANF
  is 'Data fine ANF';
comment on column P430_ANAGRAFICO.VARIAZIONE_IMPORTO_ANF
  is 'Variazione all''importo tabellare dell''ANF per situazioni particolari; (opzionale)';
alter table P430_ANAGRAFICO add REDDITO_ALTRO_ANF number;
comment on column P430_ANAGRAFICO.REDDITO_ALTRO_ANF
  is 'Altri redditi del richiedente per ANF';
alter table P430_ANAGRAFICO add INABILE_ANF VARCHAR2(1) default 'N';
comment on column P430_ANAGRAFICO.INABILE_ANF
  is 'Richiedente inabile per ANF';
comment on column SG101_FAMILIARI.GRADOPAR
  is 'Grado parentela: CG=Coniuge, FG=Figlio/Figlia, GT=Genitore, FR=Fratello/Sorella, NP=Nipote, AL=Altro';
alter table SG101_FAMILIARI add SESSO VARCHAR2(1) default 'M';
alter table SG101_FAMILIARI add CODFISCALE VARCHAR2(16);
alter table SG101_FAMILIARI add COMPONENTE_ANF VARCHAR2(1) default 'N';
 comment on column SG101_FAMILIARI.COMPONENTE_ANF
  is 'Componente del nucleo per ANF';
alter table SG101_FAMILIARI add REDDITO_ANF number;
comment on column SG101_FAMILIARI.REDDITO_ANF
  is 'Reddito di lavoro dipendente del componente per ANF';
alter table SG101_FAMILIARI add REDDITO_ALTRO_ANF number;
comment on column SG101_FAMILIARI.REDDITO_ALTRO_ANF
  is 'Altri redditi del componente per ANF';
alter table SG101_FAMILIARI add SPECIALE_ANF VARCHAR2(1) default 'N';
comment on column SG101_FAMILIARI.SPECIALE_ANF
  is 'Figlio studente o apprendista per ANF';
alter table SG101_FAMILIARI add INABILE_ANF VARCHAR2(1) default 'N';
comment on column SG101_FAMILIARI.INABILE_ANF
  is 'Componente inabile per ANF';

alter table SG101_FAMILIARI add DECORRENZA_FINE DATE;
update SG101_FAMILIARI t set
    DECORRENZA_FINE = 
    (select min(DECORRENZA) - 1 from SG101_FAMILIARI where 
       PROGRESSIVO = t.PROGRESSIVO and 
       NUMORD = t.NUMORD and 
       DECORRENZA > t.DECORRENZA)
  where 
    DECORRENZA < (select max(DECORRENZA) from SG101_FAMILIARI where 
                                    PROGRESSIVO = t.PROGRESSIVO and 
                                    NUMORD = t.NUMORD);
update SG101_FAMILIARI t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where 
    DECORRENZA = (select max(DECORRENZA) from SG101_FAMILIARI where 
                                    PROGRESSIVO = t.PROGRESSIVO and 
                                    NUMORD = t.NUMORD);



alter table P553_CONTOANNRISORRES add COD_TABELLA_QUOTE VARCHAR2(10);
alter table P553_CONTOANNRISORRES add COLONNA_QUOTE NUMBER(3);
comment on column P553_CONTOANNRISORRES.COD_TABELLA_QUOTE
  is 'Tabella di tipo Qualifica ministeriale per calcolo percentuale distribuzione risorsa residuale';
comment on column P553_CONTOANNRISORRES.COLONNA_QUOTE
  is 'Colonna della tabella di tipo Qualifica ministeriale per calcolo percentuale distribuzione risorsa residuale';
update P553_CONTOANNRISORRES T set COD_TABELLA_QUOTE = COD_TABELLA, COLONNA_QUOTE = COLONNA_RIGA
  WHERE EXISTS (select '*' from p552_contoannregole t1 where t1.cod_tabella = t.cod_tabella 
  and t.anno = t1.anno and t1.tipo_tabella_righe = '0');

alter table i500_datiliberi modify NOMELINK VARCHAR2(500);

alter table T025_CONTMENSILI add ABBATTIMENTO_FISSO_RECUPERO varchar2(1) default 'N';

alter table T220_PROFILIORARI add IGNORA_TIMBNONINSEQ varchar2(1) default 'N';
comment on column T220_PROFILIORARI.IGNORA_TIMBNONINSEQ is 'S=non viene segnalata anomalia bloccante se timbrature non in sequenza';

alter table T191_PARPAGHE add RICREAZIONE_AUTOMATICA varchar2(1) default 'S';

comment on column P200_VOCI.ABBATTE_GGANF
  is 'La voce di assenza abbatte giorni utili per diritto ANF. Richiesto solo se Tipo = AS';

DELETE FROM P452_DATIMENSILIDESC WHERE COD_CAMPO='ANFIM';
UPDATE P452_DATIMENSILIDESC SET DESCRIZIONE='gg maturati per ANF', COD_CAMPO='GGANF' WHERE COD_CAMPO='ANFGG';
DELETE FROM P450_DATIMENSILI WHERE COD_CAMPO='ANFIM';
UPDATE P450_DATIMENSILI SET COD_CAMPO='GGANF' WHERE COD_CAMPO='ANFGG';

INSERT INTO P004_CODICITABANNUALI (COD_TABANNUALE, COD_CODICITABANNUALI, ANNO, DESCRIZIONE)
VALUES ('IPCAUSCESS', '22', 2001, 'Provvedimento disciplinare');

UPDATE P206_ASSENZEINPDAP T SET T.COD_CAUSASOSPENSIONE='22' WHERE T.COD_VOCE='15080' AND T.COD_VOCE_SPECIALE='BASE';

UPDATE P200_VOCI SET ABBATTE_GGANF='S' WHERE COD_VOCE IN ('15024','15030','15032','15036','15040','15045','15050','15060','15065','15075','15085');


-- CREAZIONE TABELLE PER LA GESTIONE RISCHI
create table SG400_TIPORISCHI
( CODICE      	VARCHAR2(5) not null,
  DESCRIZIONE 	VARCHAR2(500),
  PERIODICITA 	NUMBER(2) )
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column SG400_TIPORISCHI.CODICE
  is 'Codice';
comment on column SG400_TIPORISCHI.DESCRIZIONE
  is 'Descrizione';
comment on column SG400_TIPORISCHI.PERIODICITA
  is 'Periodicità in numero mesi ';
alter table SG400_TIPORISCHI
  add constraint SG400_PK primary key (CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG401_TIPOCESSAZRISCHI
( CODICE      	VARCHAR2(5) not null,
  DESCRIZIONE 	VARCHAR2(500) )
tablespace LAVORO storage  (initial 256K next 256K pctincrease 0);

comment on column SG401_TIPOCESSAZRISCHI.CODICE
  is 'Codice';
comment on column SG401_TIPOCESSAZRISCHI.DESCRIZIONE
  is 'Descrizione';

alter table SG401_TIPOCESSAZRISCHI
  add constraint SG401_PK primary key (CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG402_TESTATARISCHI
( PROGRESSIVO  	NUMBER not null,
  TIPO_RISCHIO 	VARCHAR2(5) not null,
  DATA_INIZIO  	DATE not null,
  DATA_FINE    	DATE,
  TIPO_CESSAZ  	VARCHAR2(5),
  NOTE         	VARCHAR2(2000) )
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column SG402_TESTATARISCHI.PROGRESSIVO
  is 'Progressivo dipendente';
comment on column SG402_TESTATARISCHI.TIPO_RISCHIO
  is 'Codice tipo rischio';
comment on column SG402_TESTATARISCHI.DATA_INIZIO
  is 'Data inizio rischio';
comment on column SG402_TESTATARISCHI.DATA_FINE
  is 'Data fine rischio';
comment on column SG402_TESTATARISCHI.TIPO_CESSAZ
  is 'Codice tipo cessazione rischio';
comment on column SG402_TESTATARISCHI.NOTE
  is 'Note esposizione rischio';

alter table SG402_TESTATARISCHI
  add constraint SG402_PK primary key (PROGRESSIVO, TIPO_RISCHIO, DATA_INIZIO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG403_DETTAGLIORISCHI
( PROGRESSIVO      	NUMBER not null,
  TIPO_RISCHIO     	VARCHAR2(5) not null,
  DATA_INIZIO      	DATE not null,
  DATA_VISITA      	DATE not null,
  ESITO_VISITA     	VARCHAR2(500),
  DATA_PROX_VISITA 	DATE,
  NOTE             	VARCHAR2(2000) )
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column SG403_DETTAGLIORISCHI.PROGRESSIVO
  is 'Progressivo dipendente';
comment on column SG403_DETTAGLIORISCHI.TIPO_RISCHIO
  is 'Codice tipo rischio';
comment on column SG403_DETTAGLIORISCHI.DATA_INIZIO
  is 'Data inizio rischio';
comment on column SG403_DETTAGLIORISCHI.DATA_VISITA
  is 'Data visita';
comment on column SG403_DETTAGLIORISCHI.ESITO_VISITA
  is 'Esito visita';
comment on column SG403_DETTAGLIORISCHI.DATA_PROX_VISITA
  is 'Data prossima visita';
comment on column SG403_DETTAGLIORISCHI.NOTE
  is 'Note';

alter table SG403_DETTAGLIORISCHI
  add constraint SG403_PK primary key (PROGRESSIVO, TIPO_RISCHIO, DATA_INIZIO, DATA_VISITA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table M040_MISSIONI modify FLAG_MODIFICATO default 'N';

alter table M040_MISSIONI add ID_MISSIONE number(8);

alter table M060_ANTICIPI add ID_MISSIONE number(8);

create sequence M040_ID_MISSIONE
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

--COLLEGAMENTO MISSIONI ANTICIPI TRAMITE ID
DECLARE
  CURSOR C1 IS
    SELECT M040.*
      FROM M040_MISSIONI M040
     ORDER BY M040.DATADA, M040.ORADA DESC;
BEGIN
  UPDATE M060_ANTICIPI M060
     SET M060.ID_MISSIONE='';
  UPDATE M040_MISSIONI M040
     SET M040.ID_MISSIONE='';
  COMMIT;
     
  UPDATE M040_MISSIONI M040
     SET M040.ID_MISSIONE=M040_ID_MISSIONE.NEXTVAL;   
  COMMIT;
  
  FOR T1 IN C1 LOOP              
    UPDATE M060_ANTICIPI M060
       SET M060.ID_MISSIONE=T1.ID_MISSIONE
     WHERE M060.DATA_MISSIONE=T1.DATADA
       AND M060.PROGRESSIVO=T1.PROGRESSIVO;
  END LOOP;

  COMMIT;
END;
/

ALTER TABLE M050_RIMBORSI ADD COD_VALUTA_EST VARCHAR2(10);
ALTER TABLE M050_RIMBORSI ADD IMPRIMB_VALEST NUMBER;
ALTER TABLE M050_RIMBORSI ADD COSTORIMB_VALEST NUMBER;
ALTER TABLE M051_DETTAGLIORIMBORSO ADD IMPORTO_VALEST NUMBER;

alter table P500_CUDSETUP add DECORRENZA_CARICA_FIRMA date;
alter table P602_770REGOLE add NUMERO_FILE varchar2(3);
comment on column P602_770REGOLE.NUMERO_FILE
  is 'Numero sul file di esportazione';

UPDATE P663_FLUSSIDATIINDIVIDUALI T 
SET T.NUMERO = '006A' 
WHERE T.PARTE = 'D0' AND T.NUMERO = '06A';

UPDATE P663_FLUSSIDATIINDIVIDUALI T 
SET T.NUMERO = '006B' 
WHERE T.PARTE = 'D0' AND T.NUMERO = '06B';

UPDATE P663_FLUSSIDATIINDIVIDUALI T 
SET T.NUMERO = '007A' 
WHERE T.PARTE = 'D0' AND T.NUMERO = '07A';

UPDATE P663_FLUSSIDATIINDIVIDUALI T 
SET T.NUMERO = '007B' 
WHERE T.PARTE = 'D0' AND T.NUMERO = '07B';


