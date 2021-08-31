update T080_PIANIFORARI T080
   set T080.TURNO1 = null
where trim(T080.TURNO1) = 'M';

update T080_PIANIFORARI T080
   set T080.TURNO2 = null
where trim(T080.TURNO2) = 'M';

update T081_PROVVISORIO T081
   set T081.TURNO1 = null
where trim(T081.TURNO1) = 'M';

update T081_PROVVISORIO T081
   set T081.TURNO2 = null
where trim(T081.TURNO2) = 'M';


declare
  i integer;
begin
  select COUNT(*) into i from P042_ENTIIRPEF;
  if i = 0 then
    insert into I050_SCRIPTSQL (NOME) values ('SQ130523_6AddIRPEF.sql');
  end if;
exception
  when others then
    insert into I050_SCRIPTSQL (NOME) values ('SQ130523_6AddIRPEF.sql');
end/*--NOLOG--*/;
/

-- Aggiunta nuovo dato su P205
alter table P205_QUOTE add cod_voce_speciale_dettaglio13a VARCHAR2(5);
comment on column P205_QUOTE.cod_voce_speciale_dettaglio13a
  is 'Codice speciale per dettagliare ogni voce in quota sulla tredicesima, se presente comporta la creazione di una voce con lo stesso codice di quella in quota e come codice speciale il campo stesso';
update P205_QUOTE set cod_voce_speciale_dettaglio13a = cod_voce_speciale_dettaglio;

-- Assegnazione valore a P205.COD_VOCE_SPECIALE_DETTAGLIO13A per le tredicesime ridotte da primi 10 giorni malattia Brunetta
UPDATE P205_QUOTE P205
SET P205.COD_VOCE_SPECIALE_DETTAGLIO13A='15020'
WHERE P205.COD_CONTRATTO='EDP' AND P205.COD_VOCE_DA_QUOTARE='15026'
AND P205.COD_VOCE_SPECIALE_DA_QUOTARE='BASE' AND P205.COD_VOCE_SPECIALE_DETTAGLIO13A='15028'
AND EXISTS
(SELECT 'X' FROM P205_QUOTE P205A WHERE P205A.COD_CONTRATTO=P205.COD_CONTRATTO
AND P205A.COD_VOCE_DA_QUOTARE=P205.COD_VOCE_DA_QUOTARE AND P205A.COD_VOCE_SPECIALE_DA_QUOTARE=P205.COD_VOCE_SPECIALE_DA_QUOTARE
AND P205A.COD_VOCE_SPECIALE_DETTAGLIO='15020');

UPDATE P205_QUOTE P205
SET P205.COD_VOCE_SPECIALE_DETTAGLIO13A='15022'
WHERE P205.COD_CONTRATTO='EDP' AND P205.COD_VOCE_DA_QUOTARE='15027'
AND P205.COD_VOCE_SPECIALE_DA_QUOTARE='BASE' AND P205.COD_VOCE_SPECIALE_DETTAGLIO13A='15028'
AND EXISTS
(SELECT 'X' FROM P205_QUOTE P205A WHERE P205A.COD_CONTRATTO=P205.COD_CONTRATTO
AND P205A.COD_VOCE_DA_QUOTARE=P205.COD_VOCE_DA_QUOTARE AND P205A.COD_VOCE_SPECIALE_DA_QUOTARE=P205.COD_VOCE_SPECIALE_DA_QUOTARE
AND P205A.COD_VOCE_SPECIALE_DETTAGLIO='15022');


-- Previsto codice caaf uguale al codice fiscale
alter table P022_CAAF modify cod_caaf VARCHAR2(20);
alter table P262_MOD730TESTATA modify cod_caaf VARCHAR2(20);

-- INIZIO CREAZIONE INCARICO MV021-041-2005

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      INSERT INTO I501INCARICO SELECT 'MV021-041-2005','Dirigente medico ex modulo (legge 724/94) con struttura complessa area chirurgica (dec. successiva 2005)' FROM DUAL WHERE NOT EXISTS (SELECT 'X' FROM I501INCARICO T WHERE T.CODICE='MV021-041-2005');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV021-041-2005', DECORRENZA, 'Dir. medico ex modulo (legge 724/94) con S.C. chirurgica (dec. successiva 2005)', COD_VOCE, COD_VOCE_SPECIALE,
             78.22 IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV026-046-2005' AND P252.COD_VOCE='00212' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV021-041-2005');

    end if;
  end if;
end;
/

-- FINE CREAZIONE INCARICO MV021-041-2005

---------------------------
-- INIZIO AGGIORNAMENTO REGOLE UNIEMENS per elemento DataCessazione quadro E1
---------------------------
declare
  i integer;
begin
  select COUNT(*) into i from P670_XMLREGOLE t where t.Nome_Flusso='UNIEMENS';
  if i > 0 then
     DELETE P670_XMLREGOLE t WHERE t.NOME_FLUSSO='UNIEMENS' AND t.NUMERO IN('G055');

insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'G055', 'DataCessazione', 'Data sospensione o cessazione della contribuzione al fondo', 'G050', 'D10', 'N', null, null, 'S', 'SELECT P430.DATA_SOSP_CESS_FPC DATO FROM P430_ANAGRAFICO P430' || chr(10) || 'WHERE P430.PROGRESSIVO = :Progressivo AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND NVL(P430.DATA_SOSP_CESS_FPC,TO_DATE(''31123999'',''DDMMYYYY'')) <= :DataElaborazione' || chr(10) || 'AND' || chr(10) || '(' || chr(10) || 'SELECT NVL(SUM(TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''')),0)  FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP'' AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO BETWEEN ADD_MONTHS(:DataElaborazione,-1) AND :DataElaborazione' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11080 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || ') > 0', 'SELECT P430.DATA_SOSP_CESS_FPC DATO FROM P430_ANAGRAFICO P430' || chr(10) || 'WHERE P430.PROGRESSIVO = :Progressivo AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND NVL(P430.DATA_SOSP_CESS_FPC,TO_DATE(''31123999'',''DDMMYYYY'')) <= :DataElaborazione' || chr(10) || 'AND' || chr(10) || '(' || chr(10) || 'SELECT NVL(SUM(TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''')),0)  FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP'' AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO BETWEEN ADD_MONTHS(:DataElaborazione,-1) AND :DataElaborazione' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11080 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || ') > 0', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));

  end if;
end;
/

UPDATE P670_XMLREGOLE t SET T.REGOLA_CALCOLO_AUTOMATICA=T.REGOLA_CALCOLO_MANUALE;

---------------------------
-- FINE AGGIORNAMENTO REGOLE UNIEMENS per elemento DataCessazione quadro E1
---------------------------

-- *********************************************************************************
-- IMPOSTAZIONE NUOVO SCAGLIONE PER INPGI
-- ****************  2014 (FARE SU SQL PATCH) ****************
-- *********************************************************************************

declare 
  AnnoNuovo integer;
  Scaglione real;

begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2014;
  -- IMPOSTARE QUI IL NUOVO SCAGLIONE PER MAGGIORAZIONE 1%
  Scaglione:=44456;

  UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_A=Scaglione WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_DA=Scaglione+0.01 WHERE P233.IMPORTO_A=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
 
end;
/
