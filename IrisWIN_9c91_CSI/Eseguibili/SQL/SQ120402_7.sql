UPDATE P201_ASSOGGETTAMENTI t SET T.ASSOGGETTAMENTO=0
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE='10510' AND T.COD_VOCE_SPECIALE_PADRE='BASE'
AND T.COD_VOCE_FIGLIO='11510' AND T.COD_VOCE_SPECIALE_FIGLIO='BASE' AND T.ASSOGGETTAMENTO=100
AND EXISTS
(SELECT 'X' FROM P200_VOCI V WHERE V.COD_CONTRATTO=T.COD_CONTRATTO AND V.COD_VOCE=T.COD_VOCE_PADRE
AND V.COD_VOCE_SPECIALE=T.COD_VOCE_SPECIALE_PADRE AND UPPER(V.DESCRIZIONE) LIKE '%122/2010%');

UPDATE P200_VOCI t SET T.ECCEZIONI_SENSIBILI='a'
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='11510' AND T.COD_VOCE_SPECIALE='BASE'
AND UPPER(T.DESCRIZIONE) LIKE '%122/2010%';

-- *********************************************************************************
-- NUOVA PERCENTUALE CARICO ENTE PER OPTANTI INPS E RELIGIOSI
-- ****************  2013 (FATTO SQL PATCH) ****************
-- *********************************************************************************

declare 
  i integer;
  ID_P200 integer;
  PercEnte real;

begin
  PercEnte:=23.17 + 0.29;

select COUNT(*) into i from P200_VOCI T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='11165' AND T.COD_VOCE_SPECIALE='BASE'
AND T.DECORRENZA=TO_DATE('01012011','DDMMYYYY') AND NOT EXISTS
(select 'X' from P200_VOCI V
WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE='11165' AND V.COD_VOCE_SPECIALE='BASE'
AND V.DECORRENZA=TO_DATE('01012013','DDMMYYYY'));

if i > 0 then

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, cod_voce, cod_voce_speciale, TO_DATE('01012013','DDMMYYYY'), ID_P200, descrizione, cod_voce_stampa, descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, PercEnte, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale,ritenuta_anagrafica,decorrenza_fine,cod_beneficiario from p200_voci t
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='11165' AND T.COD_VOCE_SPECIALE='BASE'
AND T.DECORRENZA=TO_DATE('01012011','DDMMYYYY');

UPDATE p200_voci t SET T.DECORRENZA_FINE=TO_DATE('01012013','DDMMYYYY')-1
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='11165' AND T.COD_VOCE_SPECIALE='BASE'
AND T.DECORRENZA=TO_DATE('01012011','DDMMYYYY');


SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, cod_voce, cod_voce_speciale, TO_DATE('01012013','DDMMYYYY'), ID_P200, descrizione, cod_voce_stampa, descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, PercEnte, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale,ritenuta_anagrafica,decorrenza_fine,cod_beneficiario from p200_voci t
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='11175' AND T.COD_VOCE_SPECIALE='BASE'
AND T.DECORRENZA=TO_DATE('01012011','DDMMYYYY');

UPDATE p200_voci t SET T.DECORRENZA_FINE=TO_DATE('01012013','DDMMYYYY')-1
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='11175' AND T.COD_VOCE_SPECIALE='BASE'
AND T.DECORRENZA=TO_DATE('01012011','DDMMYYYY');

end if;
end;

/

-- Contributi INPDAP per cassa
UPDATE p200_voci t SET T.CASSA_COMPETENZA='CC'
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE||T.COD_VOCE_SPECIALE IN
('10010BASE','11010BASE','10010ENTE','11010ENTE','10015BASE','11015BASE','10020BASE','11020BASE','10020ENTE','11020ENTE','10025BASE','11025BASE','10040BASE','11040BASE','10040ENTE','11040ENTE','10045BASE','11045BASE','10070BASE','11070BASE','10070ENTE','11070ENTE','10075BASE','11075BASE','10140BASE','11140BASE','10140ENTE','11140ENTE','10150BASE','11150BASE','10150ENTE','11150ENTE','10190BASE','11190BASE','10190ENTE','11190ENTE','10195BASE','11195BASE');

declare 
  i integer;

begin

select COUNT(*) into i from P670_XMLREGOLE t where t.nome_flusso='UNIEMENS' and t.numero in ('F375','F380');

if i > 0 then

DELETE from P670_XMLREGOLE t where t.nome_flusso='UNIEMENS' and t.numero in ('F375','F380');

insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F375', 'StipendioTabellare', 'Stipendio tabellare', 'F300', null, 'S', 'P1', 'NP', 'N', 'SELECT NVL(SUM(P272.IMPORTO_INTERO * P216.PERCENTUALE / 100),0) DATO' || chr(10) || 'FROM T430_STORICO T430, P272_RETRIBUZIONE_CONTRATTUALE P272, P216_ACCORPAMENTOVOCI P216' || chr(10) || 'WHERE T430.PROGRESSIVO = :Progressivo AND :DataInizioPeriodo BETWEEN T430.DATADECORRENZA AND T430.DATAFINE' || chr(10) || 'AND P272.PROGRESSIVO = T430.PROGRESSIVO' || chr(10) || 'AND LEAST(:DataInizioPeriodo, NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY''))) BETWEEN P272.DECORRENZA_INIZIO AND P272.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_CONTRATTO = P272.COD_CONTRATTO AND P216.COD_VOCE = P272.COD_VOCE AND P216.COD_VOCE_SPECIALE = P272.COD_VOCE_SPECIALE' || chr(10) || 'AND :DataInizioPeriodo BETWEEN P216.DECORRENZA AND P216.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_TIPOACCORPAMENTOVOCI = ''UNIEM'' AND P216.COD_CODICIACCORPAMENTOVOCI = ''DMA2-STIP''', 'SELECT NVL(SUM(P272.IMPORTO_INTERO * P216.PERCENTUALE / 100),0) DATO' || chr(10) || 'FROM T430_STORICO T430, P272_RETRIBUZIONE_CONTRATTUALE P272, P216_ACCORPAMENTOVOCI P216' || chr(10) || 'WHERE T430.PROGRESSIVO = :Progressivo AND :DataInizioPeriodo BETWEEN T430.DATADECORRENZA AND T430.DATAFINE' || chr(10) || 'AND P272.PROGRESSIVO = T430.PROGRESSIVO' || chr(10) || 'AND LEAST(:DataInizioPeriodo, NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY''))) BETWEEN P272.DECORRENZA_INIZIO AND P272.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_CONTRATTO = P272.COD_CONTRATTO AND P216.COD_VOCE = P272.COD_VOCE AND P216.COD_VOCE_SPECIALE = P272.COD_VOCE_SPECIALE' || chr(10) || 'AND :DataInizioPeriodo BETWEEN P216.DECORRENZA AND P216.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_TIPOACCORPAMENTOVOCI = ''UNIEM'' AND P216.COD_CODICIACCORPAMENTOVOCI = ''DMA2-STIP''', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F380', 'RetribIndivAnzianita', 'RIA /Classi e Scatti', 'F300', null, 'S', 'P1', 'NP', 'N', 'SELECT NVL(SUM(P272.IMPORTO_INTERO * P216.PERCENTUALE / 100),0) DATO' || chr(10) || 'FROM T430_STORICO T430, P272_RETRIBUZIONE_CONTRATTUALE P272, P216_ACCORPAMENTOVOCI P216' || chr(10) || 'WHERE T430.PROGRESSIVO = :Progressivo AND :DataInizioPeriodo BETWEEN T430.DATADECORRENZA AND T430.DATAFINE' || chr(10) || 'AND P272.PROGRESSIVO = T430.PROGRESSIVO' || chr(10) || 'AND LEAST(:DataInizioPeriodo, NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY''))) BETWEEN P272.DECORRENZA_INIZIO AND P272.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_CONTRATTO = P272.COD_CONTRATTO AND P216.COD_VOCE = P272.COD_VOCE AND P216.COD_VOCE_SPECIALE = P272.COD_VOCE_SPECIALE' || chr(10) || 'AND :DataInizioPeriodo BETWEEN P216.DECORRENZA AND P216.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_TIPOACCORPAMENTOVOCI = ''UNIEM'' AND P216.COD_CODICIACCORPAMENTOVOCI = ''DMA2-RIA''', 'SELECT NVL(SUM(P272.IMPORTO_INTERO * P216.PERCENTUALE / 100),0) DATO' || chr(10) || 'FROM T430_STORICO T430, P272_RETRIBUZIONE_CONTRATTUALE P272, P216_ACCORPAMENTOVOCI P216' || chr(10) || 'WHERE T430.PROGRESSIVO = :Progressivo AND :DataInizioPeriodo BETWEEN T430.DATADECORRENZA AND T430.DATAFINE' || chr(10) || 'AND P272.PROGRESSIVO = T430.PROGRESSIVO' || chr(10) || 'AND LEAST(:DataInizioPeriodo, NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY''))) BETWEEN P272.DECORRENZA_INIZIO AND P272.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_CONTRATTO = P272.COD_CONTRATTO AND P216.COD_VOCE = P272.COD_VOCE AND P216.COD_VOCE_SPECIALE = P272.COD_VOCE_SPECIALE' || chr(10) || 'AND :DataInizioPeriodo BETWEEN P216.DECORRENZA AND P216.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_TIPOACCORPAMENTOVOCI = ''UNIEM'' AND P216.COD_CODICIACCORPAMENTOVOCI = ''DMA2-RIA''', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));

end if;
end;

/

-- *********************************************************************************
-- CREAZIONE SCAGLIONI DI INIZIO ANNO E NUOVE PERCENTUALI
-- PER VOCI RELATIVE A CPDEL, CPS, ENPAM EX CONVENZIONATI,
-- INPGI, OPTANTI INPS, PERSONALE RELIGIOSO INPS E GESTIONE SEPARATA INPS
-- ****************  2013 (FATTO SQL PATCH) ****************
-- *********************************************************************************
declare 
  i integer;
  AnnoNuovo integer;
  CodVoce varchar2(5);
  CodVoceSpeciale varchar2(5);
  PercDipCP_1 real;
  PercDipCP_2 real;
  PercDipGI_1 real;
  PercDipGI_2 real;
  PercDipIN_1 real;
  PercDipIN_2 real;
  PercDipINRel_1 real;
  PercDipINRel_2 real;
  PercDip11110 real;
  PercEnte11115 real;
  PercDip11120 real;
  PercEnte11125 real;
  PercDip11130 real;
  PercEnte11135 real;
  ID_P233 integer;

  CURSOR C1 IS  
  SELECT '11010' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL UNION
  SELECT '11010', 'ENTE' FROM DUAL UNION
  SELECT '11020', 'BASE' FROM DUAL UNION
  SELECT '11020', 'ENTE' FROM DUAL UNION
  SELECT '11090', 'BASE' FROM DUAL UNION
  SELECT '11110', 'BASE' FROM DUAL UNION
  SELECT '11115', 'BASE' FROM DUAL UNION
  SELECT '11120', 'BASE' FROM DUAL UNION
  SELECT '11125', 'BASE' FROM DUAL UNION
  SELECT '11130', 'BASE' FROM DUAL UNION
  SELECT '11135', 'BASE' FROM DUAL UNION
  SELECT '11160', 'BASE' FROM DUAL UNION
  SELECT '11170', 'BASE' FROM DUAL UNION
  SELECT '11410', 'BASE' FROM DUAL;  

  CURSOR C2 IS  
  SELECT '11010' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL UNION
  SELECT '11010', 'ENTE' FROM DUAL UNION
  SELECT '11020', 'BASE' FROM DUAL UNION
  SELECT '11020', 'ENTE' FROM DUAL UNION
  SELECT '11410', 'BASE' FROM DUAL;  

begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2013;
  
select COUNT(*) into i from P232_SCAGLIONI T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='11010' AND T.COD_VOCE_SPECIALE='BASE'
AND T.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo-1),'DDMMYYYY') AND NOT EXISTS
(select 'X' from P232_SCAGLIONI V
WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE='11010' AND V.COD_VOCE_SPECIALE='BASE'
AND V.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

if i > 0 then


  FOR T1 IN C1 LOOP
    CodVoce:=T1.COD_VOCE;
    CodVoceSpeciale:=T1.COD_VOCE_SPECIALE;
    
    SELECT P233_ID_SCAGLIONE.NEXTVAL INTO ID_P233 FROM DUAL;
   
    INSERT INTO P232_SCAGLIONI
    SELECT COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'), ID_P233, TIPO_IMPORTO, TIPO_RITENUTA, TIPO_APPLICAZIONE, CONGUAGLIO_ANNUALE, CONGUAGLIO_FINE_RAPPORTO, CONGUAGLIO_DOPO_FINE_RAPPORTO, COD_VOCE_CONGUAGLIO, COD_VOCE_SPECIALE_CONGUAGLIO, MENSILITA_ANNUE, MASSIMALE1, MASSIMALE2 FROM P232_SCAGLIONI P232 
    WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE=CodVoce AND P232.COD_VOCE_SPECIALE=CodVoceSpeciale AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo-1),'DDMMYYYY');
  
    INSERT INTO P233_SCAGLIONIFASCE
    SELECT ID_P233, IMPORTO_DA, IMPORTO_A, PERC_IMP FROM P233_SCAGLIONIFASCE P233,P232_SCAGLIONI P232 WHERE P233.ID_SCAGLIONE=P232.ID_SCAGLIONE
    AND P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE=CodVoce AND P232.COD_VOCE_SPECIALE=CodVoceSpeciale AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo-1),'DDMMYYYY');
  END LOOP;
  
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I DIPENDENTI CPDEL, CPS E ENPAM EX CONVENZIONATI
  PercDipCP_1:=8.85;
  PercDipCP_2:=9.85;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I DIPENDENTI INPGI
  PercDipGI_1:=8.69;
  PercDipGI_2:=9.69;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I DIPENDENTI OPTANTI INPS
  PercDipIN_1:=9.19;
  PercDipIN_2:=10.19;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I DIPENDENTI PERSONALE RELIGIOSO INPS
  PercDipINRel_1:=8.84;
  PercDipINRel_2:=9.84;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I PARASUBORDINATI CON COPERTURE ASSICURATIVE
  PercDip11110:=6.666667;
  PercEnte11115:=13.333333;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I PARASUBORDINATI SENZA COPERTURE ASSICURATIVE
  PercDip11120:=9.24;
  PercEnte11125:=18.48;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I PARASUBORDINATI PENSIONATI ANZIANITA’
  PercDip11130:=6.666667;
  PercEnte11135:=13.333333;

  FOR T2 IN C2 LOOP
    -- CPDEL, CPS E ENPAM EX CONVENZIONATI
    UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipCP_1 WHERE P233.IMPORTO_DA=0
    AND P233.ID_SCAGLIONE=
    (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE=T2.COD_VOCE AND P232.COD_VOCE_SPECIALE=T2.COD_VOCE_SPECIALE AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

    UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipCP_2 WHERE P233.IMPORTO_A=0
    AND P233.ID_SCAGLIONE=
    (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE=T2.COD_VOCE AND P232.COD_VOCE_SPECIALE=T2.COD_VOCE_SPECIALE AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
  END LOOP;

-- INPGI
  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipGI_1 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipGI_2 WHERE P233.IMPORTO_A=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
  
-- OPTANTI INPS
  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipIN_1 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11160' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipIN_2 WHERE P233.IMPORTO_A=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11160' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
  
-- PERSONALE RELIGIOSO INPS
  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipINRel_1 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11170' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipINRel_2 WHERE P233.IMPORTO_A=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11170' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
  
-- Inps con coperture assicurative
  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDip11110 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11110' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercEnte11115 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11115' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

-- Inps no coperture assicurative
  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDip11120 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11120' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercEnte11125 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11125' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

-- Inps pensionati anzianita’
  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDip11130 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11130' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercEnte11135 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11135' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

end if;
end;

/

comment on column P094_INQUADRINPDAP.cod_tipoimpiego_indet
  is 'Codice tipo impiego da utilizzarsi per i dipendenti a tempo indeterminato (tempo pieno)';
comment on column P094_INQUADRINPDAP.cod_tipoimpiego_det
  is 'Codice tipo impiego da utilizzarsi per i dipendenti a tempo determinato (tempo pieno)';

alter table P094_INQUADRINPDAP add cod_tipoimpiego_indet_pt VARCHAR2(5);
alter table P094_INQUADRINPDAP add cod_tipoimpiego_det_pt VARCHAR2(5);
comment on column P094_INQUADRINPDAP.cod_tipoimpiego_indet_pt
  is 'Codice tipo impiego da utilizzarsi per i dipendenti a tempo indeterminato (part-time)';
comment on column P094_INQUADRINPDAP.cod_tipoimpiego_det_pt
  is 'Codice tipo impiego da utilizzarsi per i dipendenti a tempo determinato  (part-time)';

UPDATE P094_INQUADRINPDAP t
SET T.COD_TIPOIMPIEGO_INDET='1', T.COD_TIPOIMPIEGO_DET='17', T.COD_TIPOIMPIEGO_INDET_PT='8', T.COD_TIPOIMPIEGO_DET_PT='18'
where to_char(t.decorrenza,'yyyy')>='2012';

-- Variazione Tipo impiego = 8 per dipendenti part-time su prime DMA2
UPDATE P673_XMLDATIINDIVIDUALI P673 SET P673.VALORE='8'
WHERE P673.NUMERO='F100' AND P673.VALORE='1' AND P673.TIPO_RECORD='M' AND P673.ID_FLUSSO IN
(SELECT P672.ID_FLUSSO FROM P672_XMLTESTATE P672
   WHERE P672.NOME_FLUSSO='UNIEMENS' AND P672.DATA_FINE_PERIODO>=TO_DATE('01102012','DDMMYYYY'))
AND EXISTS
(SELECT 'X' FROM P673_XMLDATIINDIVIDUALI P673A
   WHERE P673A.ID_FLUSSO=P673.ID_FLUSSO AND P673A.PROGRESSIVO=P673.PROGRESSIVO
   AND P673A.NUMERO='F125' AND P673A.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD=P673.TIPO_RECORD);

-- Aggiornamento regole DMA2 per AltriImportiZ2
UPDATE P670_XMLREGOLE SET OMETTI_VUOTO = 'N' WHERE NUMERO = 'A555';   

UPDATE P673_XMLDATIINDIVIDUALI P673 
SET P673.VALORE=ROUND(P673.VALORE*100000/
  (SELECT VALORE FROM P673_XMLDATIINDIVIDUALI P673B
   WHERE P673B.ID_FLUSSO=P673.ID_FLUSSO AND P673B.PROGRESSIVO=P673.PROGRESSIVO
   AND P673B.NUMERO='F135' AND P673B.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673B.TIPO_RECORD=P673.TIPO_RECORD),2)
WHERE P673.NUMERO='F375' AND P673.TIPO_RECORD='M' AND P673.ID_FLUSSO IN
(SELECT P672.ID_FLUSSO FROM P672_XMLTESTATE P672
   WHERE P672.NOME_FLUSSO='UNIEMENS' AND P672.DATA_FINE_PERIODO>=TO_DATE('01102012','DDMMYYYY'))
AND EXISTS
(SELECT 'X' FROM P673_XMLDATIINDIVIDUALI P673A
   WHERE P673A.ID_FLUSSO=P673.ID_FLUSSO AND P673A.PROGRESSIVO=P673.PROGRESSIVO
   AND P673A.NUMERO='F135' AND P673A.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD=P673.TIPO_RECORD
   AND TO_NUMBER(P673A.VALORE) NOT IN (0,100000));
   
UPDATE P673_XMLDATIINDIVIDUALI P673 
SET P673.VALORE=ROUND(P673.VALORE*100000/
  (SELECT VALORE FROM P673_XMLDATIINDIVIDUALI P673B
   WHERE P673B.ID_FLUSSO=P673.ID_FLUSSO AND P673B.PROGRESSIVO=P673.PROGRESSIVO
   AND P673B.NUMERO='H135' AND P673B.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673B.TIPO_RECORD=P673.TIPO_RECORD),2)
WHERE P673.NUMERO='H375' AND P673.TIPO_RECORD='M' AND P673.ID_FLUSSO IN
(SELECT P672.ID_FLUSSO FROM P672_XMLTESTATE P672
   WHERE P672.NOME_FLUSSO='UNIEMENS' AND P672.DATA_FINE_PERIODO>=TO_DATE('01102012','DDMMYYYY'))
AND EXISTS
(SELECT 'X' FROM P673_XMLDATIINDIVIDUALI P673A
   WHERE P673A.ID_FLUSSO=P673.ID_FLUSSO AND P673A.PROGRESSIVO=P673.PROGRESSIVO
   AND P673A.NUMERO='H135' AND P673A.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD=P673.TIPO_RECORD
   AND TO_NUMBER(P673A.VALORE) NOT IN (0,100000));

-- Variazione RIA per dipendenti part-time su prime DMA2
UPDATE P673_XMLDATIINDIVIDUALI P673 
SET P673.VALORE=ROUND(P673.VALORE*100000/
  (SELECT VALORE FROM P673_XMLDATIINDIVIDUALI P673B
   WHERE P673B.ID_FLUSSO=P673.ID_FLUSSO AND P673B.PROGRESSIVO=P673.PROGRESSIVO
   AND P673B.NUMERO='F135' AND P673B.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673B.TIPO_RECORD=P673.TIPO_RECORD),2)
WHERE P673.NUMERO='F380' AND P673.TIPO_RECORD='M' AND P673.ID_FLUSSO IN
(SELECT P672.ID_FLUSSO FROM P672_XMLTESTATE P672
   WHERE P672.NOME_FLUSSO='UNIEMENS' AND P672.DATA_FINE_PERIODO>=TO_DATE('01102012','DDMMYYYY'))
AND EXISTS
(SELECT 'X' FROM P673_XMLDATIINDIVIDUALI P673A
   WHERE P673A.ID_FLUSSO=P673.ID_FLUSSO AND P673A.PROGRESSIVO=P673.PROGRESSIVO
   AND P673A.NUMERO='F135' AND P673A.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD=P673.TIPO_RECORD
   AND TO_NUMBER(P673A.VALORE) NOT IN (0,100000));
   
UPDATE P673_XMLDATIINDIVIDUALI P673 
SET P673.VALORE=ROUND(P673.VALORE*100000/
  (SELECT VALORE FROM P673_XMLDATIINDIVIDUALI P673B
   WHERE P673B.ID_FLUSSO=P673.ID_FLUSSO AND P673B.PROGRESSIVO=P673.PROGRESSIVO
   AND P673B.NUMERO='H135' AND P673B.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673B.TIPO_RECORD=P673.TIPO_RECORD),2)
WHERE P673.NUMERO='H380' AND P673.TIPO_RECORD='M' AND P673.ID_FLUSSO IN
(SELECT P672.ID_FLUSSO FROM P672_XMLTESTATE P672
   WHERE P672.NOME_FLUSSO='UNIEMENS' AND P672.DATA_FINE_PERIODO>=TO_DATE('01102012','DDMMYYYY'))
AND EXISTS
(SELECT 'X' FROM P673_XMLDATIINDIVIDUALI P673A
   WHERE P673A.ID_FLUSSO=P673.ID_FLUSSO AND P673A.PROGRESSIVO=P673.PROGRESSIVO
   AND P673A.NUMERO='H135' AND P673A.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD=P673.TIPO_RECORD
   AND TO_NUMBER(P673A.VALORE) NOT IN (0,100000));

-- Modifica descrizioni per DMA2
ALTER TABLE P094_INQUADRINPDAP MODIFY DESCRIZIONE VARCHAR2(100);
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Comparto e dirigenti (CPDEL)'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'COMPARTO1';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Comparto e dirigenti (CPDEL e ENPDEDP)'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'COMPARTO1E';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Comparto e dirigenti assunti tempo parziale (CPDEL) - solo D.M.A.'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'COMPARTO2';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Comparto e dirigenti assunti tempo parziale (CPDEL e ENPDEDP) - solo D.M.A.'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'COMPARTO2E';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Comparto e dirigenti non vedenti (CPDEL)'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'COMPARTO3';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Comparto e dirigenti non vedenti (CPDEL e ENPDEDP)'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'COMPARTO3E';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Comparto e dirigenti non vedenti assunti tempo parziale (CPDEL) - solo D.M.A.'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'COMPARTO4';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Comparto e dirigenti non vedenti assunti tempo parziale (CPDEL e ENPDEDP) - solo D.M.A.'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'COMPARTO4E';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Comparto e dirigenti sordomuti/invalidi (CPDEL)'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'COMPARTO5';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Comparto e dirigenti sordomuti/invalidi (CPDEL e ENPDEDP)'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'COMPARTO5E';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Comparto e dirigenti sordomuti/invalidi assunti tempo parziale (CPDEL) - solo D.M.A.'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'COMPARTO6';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Comparto e dirigenti sordomuti/invalidi assunti tempo parziale (CPDEL e ENPDEDP) - solo D.M.A.'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'COMPARTO6E';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Medici e veterinari (CPS)'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'MEDICI1';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Medici e veterinari (CPS e ENPDEDP)'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'MEDICI1E';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Medici e veterinari assunti tempo parziale (CPS) - solo D.M.A.'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'MEDICI2';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Medici e veterinari assunti tempo parziale (CPS e ENPDEDP) - solo D.M.A.'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'MEDICI2E';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Medici e veterinari non vedenti (CPS)'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'MEDICI3';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Medici e veterinari non vedenti (CPS e ENPDEDP)'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'MEDICI3E';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Medici e veterinari sordomuti/invalidi (CPS)'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'MEDICI5';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Medici e veterinari sordomuti/invalidi (CPS e ENPDEDP)'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'MEDICI5E';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Medici e veterinari sordomuti/invalidi assunti tempo parziale (CPS) - solo D.M.A.'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'MEDICI6';
UPDATE P094_INQUADRINPDAP T SET DESCRIZIONE = 'Medici e veterinari sordomuti/invalidi assunti tempo parziale (CPS e ENPDEDP) - solo D.M.A.'
WHERE DECORRENZA >= TO_DATE('01012013','DDMMYYYY') AND COD_INQUADRINPDAP = 'MEDICI6E';

-- *********************************************************************************
-- IMPOSTAZIONE PROVVISORIA NUOVO SCAGLIONE PER INPGI
-- ****************  2013 ****************
-- *********************************************************************************

declare 
  AnnoNuovo integer;
  Scaglione real;

begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2013;
  -- IMPOSTARE QUI IL NUOVO SCAGLIONE PER MAGGIORAZIONE 1%
  Scaglione:=44524;

  UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_A=Scaglione WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));


  UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_DA=Scaglione+0.01 WHERE P233.IMPORTO_A=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
 
end;
/

