comment on column T265_CAUASSENZE.DETREPERIB is 'Abbattimento turno di reperibilità: 0=no, 1=si, 2=Solo su turni diurni, 3=Solo fruiz. dalle..alle';
update T265_CAUASSENZE set DETREPERIB = decode(DETREPERIB,'N','0','S','1',DETREPERIB);

UPDATE t480_comuni t SET T.CITTA='OLLASTRA' WHERE T.CODCATASTALE='G043';

--Rientri pomeridiani PARMA_AIPO--
alter table T020_ORARI add  RIENTRO_POMERIDIANO varchar2(1) default 'N';
comment on column T020_ORARI.RIENTRO_POMERIDIANO is 'S=viene verificato se l''orario svolto verifica il rientro pomeridiano secondo le regole AIPO';

alter table T670_REGOLEBUONI modify REGOLA_RIENTRO_POMERIDIANO default 'N';
update T670_REGOLEBUONI set REGOLA_RIENTRO_POMERIDIANO = 'N';

create table T077_DATISCHEDA (
  PROGRESSIVO number(8),
  DATA date,
  DATO varchar2(30),
  VALORE_AUT varchar2(50),
  VALORE_MAN varchar2(50)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T077_DATISCHEDA add constraint T077_PK primary key (PROGRESSIVO,DATA,DATO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table I011_DIZIONARIO_DATISCHEDA (
  DATO varchar2(30),
  TIPO varchar2(1) default 'N',
  DESCRIZIONE varchar2(40),
  ORDINAMENTO number(8)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table I011_DIZIONARIO_DATISCHEDA add constraint I011_PK primary key (DATO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column I011_DIZIONARIO_DATISCHEDA.TIPO is 'D=Data, O=Ore, N=Numero, S=Stringa';

insert into I011_DIZIONARIO_DATISCHEDA (DATO,DESCRIZIONE,ORDINAMENTO) values ('RIENTRIPOM_TEORICI','Rientri pom. teorici dovuti','1');
insert into I011_DIZIONARIO_DATISCHEDA (DATO,DESCRIZIONE,ORDINAMENTO) values ('RIENTRIPOM_REALI','Rientri pom. reali dovuti','2');
insert into I011_DIZIONARIO_DATISCHEDA (DATO,DESCRIZIONE,ORDINAMENTO) values ('RIENTRIPOM_RESI','Rientri pom. resi ','3');
insert into I011_DIZIONARIO_DATISCHEDA (DATO,DESCRIZIONE,ORDINAMENTO) values ('RIENTRIPOM_SALDO','Saldo rientri pom.','4');

--Indennità di turno TORINO_COMUNE
alter table T162_INDENNITA add OFFSET_METADEBITO number(3);
alter table T162_INDENNITA add MATURA_SABATO varchar2(1) default 'S';
alter table T162_INDENNITA add PIANIF_NOOP varchar2(1) default 'N';
alter table T162_INDENNITA add MIN_TURNI_PRIORITARI varchar2(2000);
alter table T162_INDENNITA add MIN_TURNI_SECONDARI varchar2(2000);
alter table T162_INDENNITA add OFFSET_GGPREC varchar2(5);
alter table T162_INDENNITA add ESCLUDI_FESTIVI varchar2(1) default 'N';
update T162_INDENNITA set ESCLUDI_FESTIVI = 'S';

comment on column T162_INDENNITA.OFFSET_METADEBITO is 'Tipo I: Minuti  richiesti oltre alla metà del debito per poter maturare l''indennità';
comment on column T162_INDENNITA.MATURA_SABATO is 'Tipo I: S=Si considerano i turni del Sabato, N=Non si considerano i turni del Sabato, A=i turni del Sabato vengono considerati dopo il calcolo dell''equilibrio';
comment on column T162_INDENNITA.PIANIF_NOOP is 'Tipo I: si considera eventuale pianificazione Non Operativa se la pianificazione operativa è cambiata per motivi personali';
comment on column T162_INDENNITA.MIN_TURNI_PRIORITARI is 'Tipo I: Espressione SQL per riconoscere il minimo dei turni prioritari';
comment on column T162_INDENNITA.MIN_TURNI_SECONDARI is 'Tipo I: Espressione SQL per riconoscere il minimo dei turni secondari';
comment on column T162_INDENNITA.OFFSET_GGPREC is 'Tipo I: Ore di scostamento rispetto al giorno precedente';
comment on column T162_INDENNITA.ESCLUDI_FESTIVI is 'Per tipologia H: S=i festivi vengono esclusi dai gg in servizio insieme alle domeniche, N=i festivi non abbattono i gg di servizio';

create sequence T165_ID minvalue 1 maxvalue 999999999999999999999999999 start with 1 increment by 1 nocache;

create table T165_LIMITI_INDORARIA_TESTA (
  CODICE varchar2(5),
  DECORRENZA date,
  DECORRENZA_FINE date,
  ID number(38)
) tablespace LAVORO storage(initial 256K next 256K pctincrease 0);

alter table T165_INDSPECIALI drop primary key;
drop index T165_PK/*--NOLOG--*/;

rename T165_INDSPECIALI to AGG84_T165_INDSPECIALI;

alter table T165_LIMITI_INDORARIA_TESTA add constraint T165_PK primary key (CODICE,DECORRENZA) using index tablespace INDICI storage(initial 256K next 256K pctincrease 0);
alter table T165_LIMITI_INDORARIA_TESTA add constraint T165_UQ unique (ID);

create table T166_LIMITI_INDORARIA_DETT (
  ID number(38),
  TURNI number(2),
  GGLAV number(1) default 0,
  TIPO_PT varchar2(1),
  PERC_PT number,
  ORE_MAX varchar2(6) 
) tablespace LAVORO storage(initial 256K next 256K pctincrease 0);

alter table T166_LIMITI_INDORARIA_DETT add constraint T166_PK primary key (ID,TURNI,GGLAV,TIPO_PT,PERC_PT) using index tablespace INDICI storage(initial 256K next 256K pctincrease 0);
alter table T166_LIMITI_INDORARIA_DETT  add constraint T165_FK_T166 foreign key (ID) references T165_LIMITI_INDORARIA_TESTA (ID) on delete cascade;

alter table T028_SOGLIE_STR_OUTPUT add ESPRESSIONE varchar2(2000);
comment on column T028_SOGLIE_STR_OUTPUT.ESPRESSIONE is 'Espressione SQL per ottenere la soglia con espressioni diverse da quelle previste in SOGLIA. In tal caso SOGLIA serve unicamente come numero d''ordine con cui considerare le espressioni';

-- *****************************************************************************
-- CREAZIONE VOCE 15068 Distacco sindacale retribuito 20%
-- *****************************************************************************

declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);

begin
  CodVoceModello:='15070';
  CodVoceCopia:='15068';
  DesVoceCopia:='Distacco sindacale retribuito 20%';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then
  
-----
-- Creazione voce copiandola da 15070
-----

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopia, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, 80, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

-- Quote
INSERT INTO P205_QUOTE
SELECT COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE_DA_QUOTARE, COD_VOCE_IN_QUOTA, COD_VOCE_SPECIALE_IN_QUOTA, DECORRENZA, -80, ACCUMULO_RATEO, COD_VOCE_SPECIALE_DETTAGLIO FROM P205_QUOTE T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE=CodVoceModello AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE';

-- Assenze INPDAP
INSERT INTO P206_ASSENZEINPDAP 
SELECT COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE, DECORRENZA, ELIMINA_SEZIONE, ABBATTE_GGUTILI, COD_TIPOSERVIZIO, COD_GESTASSIC_NONCOPERTE, COD_CAUSASOSPENSIONE, 80 FROM P206_ASSENZEINPDAP T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE ='BASE';

  end if;
end if;
end;

/

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Inizio Implementazioni alla TABELLA 04 - Nuova colonna per qualifica ministeriale SD048A 
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

DECLARE 
 NRIGHE INTEGER;


BEGIN

SELECT COUNT(*) INTO NRIGHE FROM P552_CONTOANNREGOLE T
 WHERE T.ANNO=2011 AND T.COD_TABELLA='T04' AND T.RIGA=0 AND T.COLONNA=61 AND T.VALORE_COSTANTE LIKE '%SD0483%';
IF NRIGHE = 1 THEN
SELECT COUNT(*) INTO NRIGHE FROM P552_CONTOANNREGOLE T
 WHERE T.ANNO=2011 AND T.COD_TABELLA='T04' AND T.RIGA=0 AND T.COLONNA=62 AND T.VALORE_COSTANTE LIKE '%SD048A%';
IF NRIGHE = 0 THEN

  UPDATE P552_CONTOANNREGOLE T SET T.COLONNA=T.COLONNA + 1
    WHERE T.ANNO=2011 AND T.COD_TABELLA='T04' AND T.RIGA=0 AND T.COLONNA>=62;

  INSERT INTO P552_CONTOANNREGOLE
  SELECT ANNO, COD_TABELLA, RIGA, 62, 'Dir. prof.ni sanitarie a tempo determinato - SD048A',
         TIPO_TABELLA_RIGHE, COD_ARROTONDAMENTO, '=''SD048A''', 
         CODICI_ACCORPAMENTOVOCI, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, 
         REGOLA_MODIFICABILE, NUMERO_TREDCORR, NUMERO_TREDPREC, NUMERO_ARRCORR, 
         NUMERO_ARRPREC, DATA_ACCORPAMENTO, FILTRO_DIPENDENTI
  FROM P552_CONTOANNREGOLE T WHERE T.ANNO=2011 AND T.COD_TABELLA='T04'
  AND T.RIGA=0 AND T.COLONNA=61;

  UPDATE P555_CONTOANNDATIINDIVIDUALI T SET T.COLONNA=T.COLONNA + 1
    WHERE T.COLONNA>=62 AND
    T.ID_CONTOANN=(SELECT V.ID_CONTOANN FROM P554_CONTOANNTESTATE V WHERE V.ANNO=2011 AND V.COD_TABELLA='T04');
    
  UPDATE P552_CONTOANNREGOLE T SET T.DESCRIZIONE='Contrattisti - 000061'
    WHERE T.ANNO=2011 AND T.COD_TABELLA='T04' AND T.RIGA=0 AND T.COLONNA=135 AND T.VALORE_COSTANTE LIKE '%000061%';

END IF;
END IF;

END;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Fine Implementazioni alla TABELLA 04 - Nuova colonna per qualifica ministeriale SD048A
--------------------------------------------------------------------------------

/

--------------------------------------------------------------------------------
-- Storicizzazione DEBITOGGQM sulla tabella delle qualifiche ministeriali in base alla nuova circolare
-- Dal 01/01/2011 si hanno 07.12 per le qualifiche del comparto 07.36 per le qualifiche della dirigenza
--------------------------------------------------------------------------------

CREATE TABLE BCK_T470_20120531 AS SELECT * FROM T470_QUALIFICAMINIST;

DECLARE
  CURSOR C1 IS
  SELECT T.*,T.ROWID FROM T470_QUALIFICAMINIST T
   WHERE TO_DATE('01012011','DDMMYYYY') BETWEEN DECORRENZA AND DECORRENZA_FINE AND DECORRENZA < TO_DATE('01012011','DDMMYYYY');
BEGIN
  FOR T1 IN C1 LOOP
    UPDATE T470_QUALIFICAMINIST
       SET DECORRENZA_FINE = TO_DATE('31122010','DDMMYYYY')
     WHERE ROWID = T1.ROWID;
    INSERT INTO T470_QUALIFICAMINIST
    (codice, descrizione, progressivoqm, debitoggqm, macro_categ_qm, decorrenza, decorrenza_fine)
    VALUES
    (T1.codice, T1.descrizione, T1.progressivoqm, T1.debitoggqm, T1.macro_categ_qm, TO_DATE('01012011','DDMMYYYY'), T1.decorrenza_fine);
  END LOOP;
END;
/
UPDATE T470_QUALIFICAMINIST
  SET DEBITOGGQM = '07.12'
WHERE DECORRENZA >= TO_DATE('01012011','DDMMYYYY')
  AND CODICE IN ('000061','A00062','A11030','A12017','A13018','A14005','A16028','A18029','P00062','P16006','S00062','S13051','S13052','S14053','S14054',
'S14055','S14056','S14E51','S14E52','S16019','S16020','S16021','S16022','S18023','S18920','S18921','S18922','T00062','T11008','T12057','T12058','T13059',
'T13660','T14007','T14050','T14063','T14E59','T16024','T16026','T18025','T18027','000061','000096','025000','027000','028000','032000','034000','036494',
'036495','037492','037493','038490','038491','042000','043000','045000','046000','049000','050000','051488','051489','052486','052487','053000','054000',
'055000','056000','057000','058000','0A5000','0B7000','0B7A00','0D0095','0D6000','0D6A00','0D0I95');

UPDATE T470_QUALIFICAMINIST
  SET DEBITOGGQM = '07.36'
WHERE DECORRENZA >= TO_DATE('01012011','DDMMYYYY')
  AND CODICE IN ('0D0097','0D0163','0D0482','0D0484','AD0032','AD0612','AD0A31','AD0S31','PD0004','PD0010','PD0044','PD0046','PD0605','PD0606','PD0607',
'PD0608','PD0A03','PD0A09','PD0A43','PD0A45','PD0S03','PD0S09','PD0S43','PD0S45','SD0011','SD0014','SD0035','SD0036','SD0037','SD0040','SD0047','SD0064',
'SD0072','SD0483','SD048A','SD0597','SD0598','SD0599','SD0600','SD0601','SD0602','SD0603','SD0604','SD0A12','SD0A15','SD0A38','SD0A41','SD0A48','SD0A65',
'SD0A73','SD0E12','SD0E13','SD0E15','SD0E16','SD0E33','SD0E34','SD0E38','SD0E39','SD0E41','SD0E42','SD0E48','SD0E49','SD0E65','SD0E66','SD0E73','SD0E74',
'SD0N12','SD0N13','SD0N15','SD0N16','SD0N33','SD0N34','SD0N38','SD0N39','SD0N41','SD0N42','SD0N48','SD0N49','SD0N65','SD0N66','SD0N73','SD0N74','TD0002',
'TD0068','TD0071','TD0609','TD0610','TD0611','TD0A01','TD0A67','TD0A70','TD0S01','TD0S67','TD0S70','0D0097','0D0098','0D0099','0D0100','0D0102','0D0103',
'0D0104','0D0485','0D0164','0D0165');

