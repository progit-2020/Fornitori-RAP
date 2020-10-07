create sequence T282_ID
  minvalue 1
  maxvalue 999999999999999999999999999
  start with 1
  increment by 1
  nocache;

create table T282_MESSAGGI (
  ID                    number(38) not null,
  STATO                 varchar2(1) default 'S' not null,
  DATA_INVIO            date,
  MITTENTE              varchar2(30) not null,
  OGGETTO               varchar2(200),
  TESTO                 varchar2(4000),
  SELEZIONE_ANAGRAFICA  varchar2(20)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T282_MESSAGGI.ID is 'Identificativo univoco del messaggio = T282_ID.nextval';
comment on column T282_MESSAGGI.MITTENTE is 'Username del mittente del messaggio';
comment on column T282_MESSAGGI.STATO is 'Stato del messaggio. S=Sospeso(default),I=Inviato,C=Cancellato';
comment on column T282_MESSAGGI.DATA_INVIO is 'Data di invio del messaggio. Se il messaggio non è stato inviato vale null';
comment on column T282_MESSAGGI.OGGETTO is 'Oggetto del messaggio';
comment on column T282_MESSAGGI.TESTO is 'Testo del messaggio';
comment on column T282_MESSAGGI.SELEZIONE_ANAGRAFICA is 'Codice della selezione anagrafica eventualmente utilizzata per estrarre i destinatari.';

alter table T282_MESSAGGI
  add constraint T282_PK primary key (ID)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create index T282I_MITTENTE
  on T282_MESSAGGI (MITTENTE) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T283_ALLEGATI (
  ID              number(38),
  NOME            varchar2(200),
  ALLEGATO        blob,
  DIMENSIONE      number(38)
)
lob (ALLEGATO) store as basicfile segname (
  tablespace LAVORO_LOB
  chunk 32K 
  nocache 
  nologging 
  disable storage in row
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;

create table T283_ALLEGATI (
  ID              number(38),
  NOME            varchar2(200),
  ALLEGATO        blob,
  DIMENSIONE      number(38)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T283_ALLEGATI.ID is 'Identificativo del messaggio di riferimento';
comment on column T283_ALLEGATI.NOME is 'Nome del file comprensivo di estensione';
comment on column T283_ALLEGATI.ALLEGATO is 'File allegato: registrarlo preferibilmente su tablespace specifico LAVORO_LOB';
comment on column T283_ALLEGATI.DIMENSIONE is 'Dimensione del file allegato espressa in byte';

alter table T283_ALLEGATI
  add constraint T283_PK primary key (ID, NOME)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T283_ALLEGATI
  add constraint T283_FK_T282 foreign key (ID)
  references T282_MESSAGGI (ID) on delete cascade;

create table T284_DESTINATARI (
  ID             number(38),
  PROGRESSIVO    number(8),
  DATA_LETTURA   date
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T284_DESTINATARI.ID is 'Identificativo del messaggio di riferimento';
comment on column T284_DESTINATARI.PROGRESSIVO is 'Progressivo del destinatario';
comment on column T284_DESTINATARI.DATA_LETTURA is 'Identificativo del messaggio di riferimento';

alter table T284_DESTINATARI
  add constraint T284_PK primary key (ID, PROGRESSIVO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T284_DESTINATARI
  add constraint T284_FK_T282 foreign key (ID)
  references T282_MESSAGGI (ID) on delete cascade;

alter table T284_DESTINATARI
  add constraint T284_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO(PROGRESSIVO) on delete cascade;

update T910_RIEPILOGO set IMPOSTAZIONI = IMPOSTAZIONI||',CEDOLINI_RAPPLAVPREC=S' where APPLICAZIONE = 'PAGHE';

UPDATE P200_VOCI t
SET T.DESCRIZIONE=REPLACE(T.DESCRIZIONE,'ENPDEDP','ENPDEP'),
    T.DESCRIZIONE_STAMPA=REPLACE(T.DESCRIZIONE_STAMPA,'ENPDEDP','ENPDEP')
WHERE T.DESCRIZIONE LIKE '%ENPDEDP%' OR T.DESCRIZIONE_STAMPA LIKE '%ENPDEDP%';

---------------------------------------------------------------------------
-- INIZIO aggiornamento ambiente su voci per gestione massimali contributivi
---------------------------------------------------------------------------

UPDATE P232_SCAGLIONI P232
SET P232.TIPO_APPLICAZIONE='P', P232.COD_VOCE_CONGUAGLIO='', P232.COD_VOCE_SPECIALE_CONGUAGLIO='',
P232.MASSIMALE1=0, P232.MASSIMALE2=0
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11410' AND P232.COD_VOCE_SPECIALE='BASE'
AND P232.TIPO_APPLICAZIONE='Q';

declare 

  CURSOR C1 IS  
  SELECT * FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP'
    AND P232.COD_VOCE IN ('11010','11020') AND P232.COD_VOCE_SPECIALE='BASE'
    ORDER BY P232.COD_VOCE, P232.DECORRENZA;

begin

  FOR T1 IN C1 LOOP

    UPDATE P232_SCAGLIONI P232 SET
      P232.TIPO_APPLICAZIONE=T1.TIPO_APPLICAZIONE, P232.COD_VOCE_CONGUAGLIO=T1.COD_VOCE_CONGUAGLIO,
      P232.COD_VOCE_SPECIALE_CONGUAGLIO=T1.COD_VOCE_SPECIALE_CONGUAGLIO,
      P232.MASSIMALE1=T1.MASSIMALE1, P232.MASSIMALE2=T1.MASSIMALE2
    WHERE P232.COD_CONTRATTO=T1.COD_CONTRATTO AND P232.COD_VOCE=T1.COD_VOCE
      AND P232.COD_VOCE_SPECIALE='ENTE' AND P232.DECORRENZA=T1.DECORRENZA;

  END LOOP;
 
end;
/

UPDATE P200_VOCI P200
SET P200.RITENUTA_MASSIMALI_SCAGLIONI='S', P200.RITENUTA_PERC=0
WHERE P200.COD_CONTRATTO='EDP' AND P200.COD_VOCE IN ('11140','11150')
AND P200.COD_VOCE_SPECIALE IN ('BASE','ENTE');

declare 
  i integer;
  ID_P233 integer;
  
  CURSOR C1 IS  
  SELECT * FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP'
    AND P232.COD_VOCE = '11010' AND P232.COD_VOCE_SPECIALE='BASE'
    ORDER BY P232.COD_VOCE, P232.DECORRENZA;

  CURSOR C2 IS  
  SELECT DISTINCT P200.COD_VOCE, P200.COD_VOCE_SPECIALE FROM P200_VOCI P200
    WHERE P200.COD_CONTRATTO='EDP' AND P200.COD_VOCE IN ('11140','11150')
    AND P200.COD_VOCE_SPECIALE IN ('BASE','ENTE')
    ORDER BY P200.COD_VOCE, P200.COD_VOCE_SPECIALE;  

begin
  select COUNT(*) into i from P232_SCAGLIONI T WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='11140';
  if i = 0 then

  FOR T2 IN C2 LOOP
  
    FOR T1 IN C1 LOOP

      SELECT P233_ID_SCAGLIONE.NEXTVAL INTO ID_P233 FROM DUAL;
     
      INSERT INTO P232_SCAGLIONI
        (COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DECORRENZA, ID_SCAGLIONE, TIPO_IMPORTO, TIPO_RITENUTA, TIPO_APPLICAZIONE, CONGUAGLIO_ANNUALE, CONGUAGLIO_FINE_RAPPORTO, CONGUAGLIO_DOPO_FINE_RAPPORTO, COD_VOCE_CONGUAGLIO, COD_VOCE_SPECIALE_CONGUAGLIO, MENSILITA_ANNUE, MASSIMALE1, MASSIMALE2)
      VALUES
        (T1.COD_CONTRATTO, T2.COD_VOCE, T2.COD_VOCE_SPECIALE, T1.DECORRENZA, ID_P233, T1.TIPO_IMPORTO, T1.TIPO_RITENUTA, T1.TIPO_APPLICAZIONE, T1.CONGUAGLIO_ANNUALE, T1.CONGUAGLIO_FINE_RAPPORTO, T1.CONGUAGLIO_DOPO_FINE_RAPPORTO, '10143', T1.COD_VOCE_SPECIALE_CONGUAGLIO, T1.MENSILITA_ANNUE, T1.MASSIMALE1, T1.MASSIMALE2);

      INSERT INTO P233_SCAGLIONIFASCE
        (ID_SCAGLIONE, IMPORTO_DA, IMPORTO_A, PERC_IMP)
      VALUES
        (ID_P233, 0, 1000000, 0.35);

      INSERT INTO P233_SCAGLIONIFASCE
        (ID_SCAGLIONE, IMPORTO_DA, IMPORTO_A, PERC_IMP)
      VALUES
        (ID_P233, 1000000.01, 0, 0.35);

	  END LOOP;
  END LOOP;

  end if;
 
end;
/

declare 
  i integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  EsisteVoce varchar2(10);
  ID_P200 integer;

begin

-- Creazione voce 10143 copiandola da 10013

  select COUNT(*) into i from P200_VOCI t where T.COD_CONTRATTO='EDP' AND T.COD_VOCE='10013' AND T.COD_VOCE_SPECIALE='BASE'
  AND NOT EXISTS
    (select 'x' from P200_VOCI V WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE='10143' AND V.COD_VOCE_SPECIALE='BASE');
  if i > 0 then

  CodVoceModello:='10013';
  CodVoceCopia:='10143';
  DesVoceCopia:='Abbattimento fondo credito supero mass.';  

  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into p200_voci
  select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ',
  DesVoceCopia, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico,
  importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni,
  ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile,
  stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert,
  ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam,
  abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note,
  cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp,
  abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg,
  retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

  -- Assoggettamenti
  INSERT INTO P201_ASSOGGETTAMENTI
  SELECT cod_contratto, CodVoceCopia, cod_voce_speciale_padre,
  decode(cod_voce_figlio,'10010','10140','10150'), 
  cod_voce_speciale_figlio,   decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
  from P201_ASSOGGETTAMENTI t
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE= CodVoceModello AND T.Cod_Voce_Speciale_Padre='BASE'
  AND T.COD_VOCE_FIGLIO IN('10010','10020');

  end if;
 
end;
/

---------------------------------------------------------------------------
-- FINE aggiornamento ambiente su voci per gestione massimali contributivi
---------------------------------------------------------------------------

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      INSERT INTO I501INCARICO SELECT 'DR065-055-2010-C006','Dirigente ruolo amministrativo equiparato con struttura semplice (dec. 2010-2014) - complessa (dec. 2006)' FROM DUAL WHERE NOT EXISTS (SELECT 'X' FROM I501INCARICO T WHERE T.CODICE='DR065-055-2010-C006');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR065-055-2010-C006', DECORRENZA, 'Dir. ruolo amministr. equiparato con S.S. (dec. 2010-2014) - S.C. (dec. 2006)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',158.87,122.63) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR065-050-2010-S2009' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR065-055-2010-C006');

    end if;
  end if;
end;
/
                  
---------------------------
-- INIZIO NUOVE REGOLE UNIEMENS per massimali contributivi
---------------------------
declare
  i integer;
begin
  select COUNT(*) into i from P670_XMLREGOLE t where t.Nome_Flusso='UNIEMENS';
  if i > 0 then
     DELETE P670_XMLREGOLE t WHERE t.NOME_FLUSSO='UNIEMENS' AND t.NUMERO IN('F317','F625','H317','H625');

insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F317', 'ImponibileEccMass', 'Imponibile pensionistico che eccede il massimale nel periodo', 'F300', null, 'S', 'P1', 'NP', 'S', null, 'SELECT DATA_COMPETENZA_DA,DATA_COMPETENZA_A,-IMPORTO DATO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione AND LAST_DAY(DATA_COMPETENZA_A) = DATA_CEDOLINO' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''10013 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'ORDER BY DATA_COMPETENZA_DA', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F625', 'ImponibileEccMass', 'Imponibile Gestione credito che eccede il massimale nel periodo', 'F600', null, 'S', 'P1', 'NP', 'S', null, 'SELECT DATA_COMPETENZA_DA,DATA_COMPETENZA_A,-IMPORTO DATO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione AND LAST_DAY(DATA_COMPETENZA_A) = DATA_CEDOLINO' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''10143 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'ORDER BY DATA_COMPETENZA_DA', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'H317', 'ImponibileEccMass', 'Imponibile pensionistico che eccede il massimale nel periodo', 'H300', null, 'S', 'P1', 'NP', 'S', null, 'SELECT SUM(P673.VALORE) DATO FROM P673_XMLDATIINDIVIDUALI P673, P672_XMLTESTATE P672' || chr(10) || 'WHERE P672.NOME_FLUSSO = ''UNIEMENS'' AND P672.DATA_FINE_PERIODO = :DataMesePrecedente' || chr(10) || 'AND P672.ID_FLUSSO = P673.ID_FLUSSO AND P673.PROGRESSIVO = :Progressivo' || chr(10) || 'AND P673.NUMERO = ''F317'' AND P673.TIPO_RECORD = ''M''', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'H625', 'ImponibileEccMass', 'Imponibile Gestione credito che eccede il massimale nel periodo', 'H600', null, 'S', 'P1', 'NP', 'S', null, 'SELECT SUM(P673.VALORE) DATO FROM P673_XMLDATIINDIVIDUALI P673, P672_XMLTESTATE P672' || chr(10) || 'WHERE P672.NOME_FLUSSO = ''UNIEMENS'' AND P672.DATA_FINE_PERIODO = :DataMesePrecedente' || chr(10) || 'AND P672.ID_FLUSSO = P673.ID_FLUSSO AND P673.PROGRESSIVO = :Progressivo' || chr(10) || 'AND P673.NUMERO = ''F625'' AND P673.TIPO_RECORD = ''M''', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));

  end if;
end;
/

UPDATE P670_XMLREGOLE t SET T.REGOLA_CALCOLO_AUTOMATICA=T.REGOLA_CALCOLO_MANUALE;

---------------------------
-- FINE NUOVE REGOLE UNIEMENS per massimali contributivi
---------------------------

-- CREAZIONE VOCE EDPSC Sanzione disciplinare
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='09000';
CodVoceCopia:='09002';
DesVoceCopia:='Sanzione disciplinare';
DesVoceCopiaSt:='Sanzione disciplinare';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDPSC' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and upper(t.descrizione) like '%RECUPERO%'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale)
    and exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce='05000'
       and v.cod_voce_speciale=t.cod_voce_speciale
       and upper(v.descrizione) like '%UNA TANTUM%');
  if i > 0 then

-----
-- Inizio Sanzione disciplinare
-----
  
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
    WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre,
    decode(cod_voce_figlio,'12940','12960',cod_voce_figlio),
    cod_voce_speciale_figlio, decorrenza,
    decode(cod_voce_figlio,'12940',assoggettamento,- assoggettamento),
    decode(cod_voce_figlio,'12940',assoggettamento13a,- assoggettamento13a),
    decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto='EDPSC' and t.cod_voce_padre='05000' and t.cod_voce_speciale_padre='BASE'
    and t.cod_voce_figlio not in ('10415','10425');

-----
-- Fine Sanzione disciplinare
-----

  end if;
end if;
end;
/

-- Nuovi dati ENPAM
alter table P500_CUDSETUP add CODICE_AZIENDA_ENPAM varchar2(5);
comment on column P500_CUDSETUP.CODICE_AZIENDA_ENPAM is 'Codice ENPAM dell''azienda';
alter table P430_ANAGRAFICO add COD_CATEG_CONVENZ VARCHAR2(5);
comment on column P430_ANAGRAFICO.COD_CATEG_CONVENZ is 'Codice categoria convenzionato ENPAM';

-----
-- Inizio creazione nuovo dato annuale ENCATCONV
-----

declare 
  i integer;
  annociclo integer;

begin

select COUNT(*) into i from P002_TABANNUALI t where t.cod_tabannuale='IPCAUSCESS'
 and not exists (select 'x' from P002_TABANNUALI v where v.cod_tabannuale='ENCATCONV');
if i = 1 then

insert into p002_tabannuali
  (cod_tabannuale, descrizione, modificabile)
values
  ('ENCATCONV', 'Categorie convenzionati ENPAM', 'N');


insert into p004_codicitabannuali
  (cod_tabannuale, cod_codicitabannuali, anno, descrizione)
values
  ('ENCATCONV', 'A', 1900, 'Ambulatoriali');
insert into p004_codicitabannuali
  (cod_tabannuale, cod_codicitabannuali, anno, descrizione)
values
  ('ENCATCONV', 'B', 1900, 'Medici di assistenza primaria');
insert into p004_codicitabannuali
  (cod_tabannuale, cod_codicitabannuali, anno, descrizione)
values
  ('ENCATCONV', 'D', 1900, 'Transitati alla dipendenza ex fondo generici');
insert into p004_codicitabannuali
  (cod_tabannuale, cod_codicitabannuali, anno, descrizione)
values
  ('ENCATCONV', 'F', 1900, 'Emergenza territoriale');
insert into p004_codicitabannuali
  (cod_tabannuale, cod_codicitabannuali, anno, descrizione)
values
  ('ENCATCONV', 'G', 1900, 'Continuita'' assistenziale');
insert into p004_codicitabannuali
  (cod_tabannuale, cod_codicitabannuali, anno, descrizione)
values
  ('ENCATCONV', 'M', 1900, 'Medicina dei servizi');
insert into p004_codicitabannuali
  (cod_tabannuale, cod_codicitabannuali, anno, descrizione)
values
  ('ENCATCONV', 'O', 1900, 'Odontoiatri');
insert into p004_codicitabannuali
  (cod_tabannuale, cod_codicitabannuali, anno, descrizione)
values
  ('ENCATCONV', 'P', 1900, 'Pediatri di libera scelta');

for annociclo in 2001..2013
loop
  insert into p004_codicitabannuali
  select cod_tabannuale, cod_codicitabannuali, annociclo, descrizione from p004_codicitabannuali t
    where t.cod_tabannuale='ENCATCONV' and t.anno=1900;
end loop;
  
end if;
end;
/

-----
-- Fine creazione nuovo dato annuale ENCATCONV
-----

UPDATE P430_ANAGRAFICO T
  SET T.COD_CATEG_CONVENZ=DECODE(SUBSTR(T.COD_POSIZIONE_ECONOMICA,1,2),
                          'MA','A','MG','B','ME','F','MC','G','MS','M','MP','P','')
  WHERE T.COD_CONTRATTO='EDPSC';
                                 
UPDATE P430_ANAGRAFICO T
  SET T.COD_CATEG_CONVENZ='D'
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_TIPOASSOGGETTAMENTO IN ('ENPFR','ENPFRE');

-- INIZIO nuova riga relazione allegata conto annuale tabella T24
declare 
  i integer;
  j integer;

begin
  select COUNT(*) into i from I500_DATILIBERI t where t.nomecampo='ATTIVITA';
  if i > 0 then

  EXECUTE IMMEDIATE 
  'INSERT INTO I501ATTIVITA
  SELECT ''30800'', ''Attività ambulatoriale'' FROM DUAL
  WHERE NOT EXISTS
  (SELECT ''X'' FROM I501ATTIVITA T WHERE T.CODICE=''30800'')
  AND EXISTS
  (SELECT ''X'' FROM I501ATTIVITA T WHERE T.CODICE=''FGP002'' AND UPPER(T.DESCRIZIONE) LIKE ''%FORMAZIONE%'')';

  select COUNT(*) into j from P552_CONTOANNREGOLE t where t.anno=2012 and t.cod_tabella='RELANNCA' and t.riga=53 and t.colonna=0;
    if j = 0 then

    insert into P552_CONTOANNREGOLE
    select anno, cod_tabella, 53, colonna, 'Attività ambulatoriale', tipo_tabella_righe, cod_arrotondamento, '30800', codici_accorpamentovoci, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, numero_tredcorr, numero_tredprec, numero_arrcorr, numero_arrprec, data_accorpamento, filtro_dipendenti
    from P552_CONTOANNREGOLE t where t.anno=2012 and t.cod_tabella='RELANNCA' and t.riga=52 and t.colonna=0;

    update P552_CONTOANNREGOLE t set t.riga=t.riga + 100
    where t.anno=2012 and t.cod_tabella='RELANNCA' and t.riga>0 and t.colonna=0;
    
    update P552_CONTOANNREGOLE t 
      set t.riga=decode(t.riga,101,7,102,9,103,10,104,8,105,11,106,12,107,13,108,14,109,15,110,25,
                               111,26,112,27,113,28,114,16,115,17,116,18,117,29,118,30,119,31,120,32,
                               121,33,122,34,123,35,124,36,125,37,126,19,127,21,128,38,129,20,130,39,
                               131,40,132,23,133,41,134,42,135,24,136,43,137,44,138,22,139,52,140,45,
                               141,46,142,49,143,47,144,48,145,50,146,51,147,2,148,1,149,3,150,4,151,5,
                               152,6,153,53)
    where t.anno=2012 and t.cod_tabella='RELANNCA' and t.riga>0 and t.colonna=0;
    
    end if;
  end if;
 
end;
/
-- FINE nuova riga relazione allegata conto annuale tabella T24

-- *****************************************************************************
-- CREAZIONE VOCE 15074 Distacco sindacale retribuito 75%
-- *****************************************************************************

declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);

begin
  CodVoceModello:='15070';
  CodVoceCopia:='15074';
  DesVoceCopia:='Distacco sindacale retribuito 75%';

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
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopia, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, 25, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

-- Quote
INSERT INTO P205_QUOTE
SELECT COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE_DA_QUOTARE, COD_VOCE_IN_QUOTA, COD_VOCE_SPECIALE_IN_QUOTA, DECORRENZA, -25, ACCUMULO_RATEO, COD_VOCE_SPECIALE_DETTAGLIO FROM P205_QUOTE T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE=CodVoceModello AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE';

-- Assenze INPDAP
INSERT INTO P206_ASSENZEINPDAP 
SELECT COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE, DECORRENZA, ELIMINA_SEZIONE, ABBATTE_GGUTILI, COD_TIPOSERVIZIO, COD_GESTASSIC_NONCOPERTE, COD_CAUSASOSPENSIONE, 25, perc_retribuzione, note, decorrenza_fine FROM P206_ASSENZEINPDAP T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE ='BASE';

  end if;
end if;
end;
/

--eliminazione V430 per forzare riaggiornamento da applicativo
declare
  c integer;
begin
  SELECT COUNT(*) into C FROM P001_TABP430 WHERE TABELLA = 'T030_ANAGRAFICO';
  if C > 0 then
    execute immediate 'drop view V430_STORICO';
  end if;  
end;
/
