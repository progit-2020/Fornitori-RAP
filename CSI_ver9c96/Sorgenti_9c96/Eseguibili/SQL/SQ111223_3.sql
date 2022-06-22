update p200_voci t
set t.descrizione='Variazione imponibili TFR/TFS', t.descrizione_stampa='Variazione imponibili TFR/TFS'
where t.cod_contratto='EDP' and t.cod_voce='10041' and t.cod_voce_speciale='BASE'
and t.descrizione='Variazione imponibile INADELP TFS/TFR';

-- *****************************************************************************
-- CREAZIONE VOCE 15140 Collocamento in disponibilità
-- CREAZIONE VOCE 00410 Indennità di disponibilità
-- CREAZIONE VOCE 10014 Variaz. imponibili CPDEL/CPS dip.-ente
-- CREAZIONE VOCE 10044 Variazione imponibili TFR/TFS dip.-ente
-- *****************************************************************************

declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
  CodVoceModello:='15034';
  CodVoceCopia:='15140';
  DesVoceCopia:='Collocamento in disponibilità';
  DesVoceCopiaSt:='Collocamento in disponibilita''';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then
  
-----
-- Creazione voce copiandola da 15034
-----

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

-- Quote
INSERT INTO P205_QUOTE
SELECT COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE_DA_QUOTARE, COD_VOCE_IN_QUOTA, COD_VOCE_SPECIALE_IN_QUOTA, DECORRENZA, ACCUMULO, ACCUMULO_RATEO, COD_VOCE_SPECIALE_DETTAGLIO FROM P205_QUOTE T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE=CodVoceModello AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE';

  end if;

  CodVoceModello:='00400';
  CodVoceCopia:='00410';
  DesVoceCopia:='Indennità di disponibilità';
  DesVoceCopiaSt:='Indennita'' di disponibilita''';

  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then
  
-----
-- Creazione voce copiandola da 00400
-----

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, 'S', cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, 'S', 'GG', ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

-- Assoggettamenti
INSERT INTO P201_ASSOGGETTAMENTI
select COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE_PADRE, COD_VOCE_FIGLIO, COD_VOCE_SPECIALE_FIGLIO, DECORRENZA, ASSOGGETTAMENTO, ASSOGGETTAMENTO13A, DECORRENZA_FINE FROM P201_ASSOGGETTAMENTI T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE=CodVoceModello AND T.COD_VOCE_SPECIALE_PADRE='BASE';

-- Assoggettamenti TFS/TFR
INSERT INTO P201_ASSOGGETTAMENTI
select COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE_PADRE,
       DECODE(COD_VOCE_FIGLIO,'10010','10040','10015','10045','10020','10070','10025','10075','14100','14120'),
       COD_VOCE_SPECIALE_FIGLIO, DECORRENZA, ASSOGGETTAMENTO, ASSOGGETTAMENTO13A, DECORRENZA_FINE FROM P201_ASSOGGETTAMENTI T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE=CodVoceCopia AND T.COD_VOCE_SPECIALE_PADRE='BASE'
AND T.COD_VOCE_FIGLIO IN ('10010','10015','10020','10025','14100') AND T.COD_VOCE_SPECIALE_FIGLIO='BASE';

-- Assoggettamento voci all'imponibile fondo previdenza complementare
INSERT INTO p201_assoggettamenti
SELECT cod_contratto, cod_voce_padre, cod_voce_speciale_padre, '10080', cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
from p201_assoggettamenti t
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE=CodVoceCopia AND T.COD_VOCE_SPECIALE_PADRE='BASE'
      and T.Cod_Voce_Figlio='10070' and T.Cod_Voce_Speciale_Figlio='BASE';

-- Assoggettamento voci all'imponibile TFS optanti fondo previdenza complementare
INSERT INTO p201_assoggettamenti
SELECT cod_contratto, cod_voce_padre, cod_voce_speciale_padre, '14130', cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
from p201_assoggettamenti t
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE=CodVoceCopia AND T.COD_VOCE_SPECIALE_PADRE='BASE'
      and T.Cod_Voce_Figlio='10045' and T.Cod_Voce_Speciale_Figlio='BASE';

  end if;

  CodVoceModello:='10011';
  CodVoceCopia:='10014';
  DesVoceCopia:='Variaz. imponibili CPDEL/CPS dip.-ente';
  DesVoceCopiaSt:='Variaz. imponibili CPDEL/CPS dip.-ente';

  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then
  
-----
-- Creazione voce copiandola da 10011
-----

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

-- Assoggettamenti
INSERT INTO P201_ASSOGGETTAMENTI
select COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE_PADRE, COD_VOCE_FIGLIO,
       DECODE(T.COD_VOCE_FIGLIO,'10010','ENTE','10020','ENTE','10140','ENTE','10150','ENTE','10190','ENTE',COD_VOCE_SPECIALE_FIGLIO),
       DECORRENZA, ASSOGGETTAMENTO, ASSOGGETTAMENTO13A, DECORRENZA_FINE FROM P201_ASSOGGETTAMENTI T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE=CodVoceModello AND T.COD_VOCE_SPECIALE_PADRE='BASE'
      AND T.COD_VOCE_FIGLIO IN ('10010','10015','10020','10025','10140','10150','10190','10195','14100') AND T.COD_VOCE_SPECIALE_FIGLIO='BASE';

  end if;

  CodVoceModello:='10041';
  CodVoceCopia:='10044';
  DesVoceCopia:='Variazione imponibili TFR/TFS dip.-ente';
  DesVoceCopiaSt:='Variazione imponibili TFR/TFS dip.-ente';

  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then
  
-----
-- Creazione voce copiandola da 10041
-----

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

-- Assoggettamenti
INSERT INTO P201_ASSOGGETTAMENTI
select COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE_PADRE, COD_VOCE_FIGLIO,
       DECODE(T.COD_VOCE_FIGLIO,'10040','ENTE','10070','ENTE',COD_VOCE_SPECIALE_FIGLIO),
       DECORRENZA, ASSOGGETTAMENTO, ASSOGGETTAMENTO13A, DECORRENZA_FINE FROM P201_ASSOGGETTAMENTI T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE=CodVoceModello AND T.COD_VOCE_SPECIALE_PADRE='BASE'
      AND T.COD_VOCE_FIGLIO IN ('10040','10045','10070','10075','14120','14130') AND T.COD_VOCE_SPECIALE_FIGLIO='BASE';

  end if;

end if;
end;

/

-----
-- Aggiornamento anno d'imposta e codici tributo per 730/2012
-----

update p260_mod730tipoimporti t set t.anno_imposta=-1 where t.cod_tipoimporto in ('RLC','RLD');

INSERT INTO P080_CAUSALIIRPEF
SELECT 'F24146E','Contributo di solidarietà di cui all''articolo 2, comma 2 del D.L. n. 138/2011, trattenuto a seguito di assistenza fiscale'
FROM DUAL 
WHERE EXISTS
 (SELECT 'X' FROM P080_CAUSALIIRPEF T WHERE T.COD_CAUSALEIRPEF='F24100E')
AND NOT EXISTS
 (SELECT 'X' FROM P080_CAUSALIIRPEF T WHERE T.COD_CAUSALEIRPEF='F24146E');
 
INSERT INTO P080_CAUSALIIRPEF
SELECT 'F24147E','Imposta sostitutiva dell''IRPEF e delle relative addizionali, nonché delle imposte di registro e di bollo, sul canone di locazione ... - Art. 3, D.Lgs. n. 23/2011 - ASSISTENZA FISCALE - ACCONTO'
FROM DUAL 
WHERE EXISTS
 (SELECT 'X' FROM P080_CAUSALIIRPEF T WHERE T.COD_CAUSALEIRPEF='F24100E')
AND NOT EXISTS
 (SELECT 'X' FROM P080_CAUSALIIRPEF T WHERE T.COD_CAUSALEIRPEF='F24147E');
 
INSERT INTO P080_CAUSALIIRPEF
SELECT 'F24148E','Imposta sostitutiva dell''IRPEF e delle relative addizionali, nonché delle imposte di registro e di bollo, sul canone di locazione ... - Art. 3, D.Lgs. n. 23/2011 - ASSISTENZA FISCALE - SALDO'
FROM DUAL 
WHERE EXISTS
 (SELECT 'X' FROM P080_CAUSALIIRPEF T WHERE T.COD_CAUSALEIRPEF='F24100E')
AND NOT EXISTS
 (SELECT 'X' FROM P080_CAUSALIIRPEF T WHERE T.COD_CAUSALEIRPEF='F24148E');
 
UPDATE P200_VOCI T SET T.COD_CAUSALEIRPEF='F24118E' 
WHERE T.COD_CONTRATTO IN ('EDP','EDPSC') AND T.COD_VOCE_SPECIALE='BASE'
AND T.COD_VOCE IN ('11831','11836','11861','11931','11936');

UPDATE P200_VOCI T SET T.COD_CAUSALEIRPEF='F24146E' 
WHERE T.COD_CONTRATTO IN ('EDP','EDPSC') AND T.COD_VOCE_SPECIALE='BASE'
AND T.COD_VOCE IN ('11860','11862');

UPDATE P200_VOCI T SET T.COD_CAUSALEIRPEF='F24147E' 
WHERE T.COD_CONTRATTO IN ('EDP','EDPSC') AND T.COD_VOCE_SPECIALE='BASE'
AND T.COD_VOCE IN ('11930','11932','11935','11937','11940','11942','11945','11947');

UPDATE P200_VOCI T SET T.COD_CAUSALEIRPEF='F24148E' 
WHERE T.COD_CONTRATTO IN ('EDP','EDPSC') AND T.COD_VOCE_SPECIALE='BASE'
AND T.COD_VOCE IN ('11830','11832','11835','11837','11907','11908');

-----
-- F24EP con gestione progressivo dipendente
-----

declare
  i integer;
begin
  select COUNT(*) into i from P660_FLUSSIREGOLE t where t.Nome_Flusso='F24EP' and t.parte='E';
  if i > 0 then
     DELETE P660_FLUSSIREGOLE t where t.Nome_Flusso='F24EP' and t.parte='E';

insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'E', '001', 'IRPEF', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || '-- IRPEF da competenze del mese' || chr(10) || 'SELECT P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210BASE'',''100E'',''11220BASE'',''102E'',''11230BASE'',''110E'',''11520BASE'',''112E'',''11525BASE'',''145E'',' || chr(10) || '       ''11500BASE'',DECODE(P430.COD_CAUSALEIRPEF,''1045'',''106E'',''104E''),' || chr(10) || '       ''11210CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),1,''111E'',''100E'')) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210CONG'',' || chr(10) || '       DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),' || chr(10) || '              1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) - 1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))),' || chr(10) || '       TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))) ANNO,' || chr(10) || 'P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P430_ANAGRAFICO P430' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.PROGRESSIVO = P430.PROGRESSIVO AND P441.DATA_CEDOLINO BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''11210BASE'',''11220BASE'',''11230BASE'',''11500BASE'',''11520BASE'',''11525BASE'',''11210CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Addizionali saldo e acconto' || chr(10) || 'SELECT P441.PROGRESSIVO, DECODE(P258.TIPO_ADDIZIONALE,''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'DECODE(P442.COD_VOCE,''11250'',''384E'',''11255'',''385E'',''11270'',''381E'') COD_TRIBUTO,' || chr(10) || 'P258.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE, P258.ANNO, P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P258_ADDIZIONALIIRPEF P258' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = DECODE(P442.COD_VOCE,''11250'',''C'',''11255'',''C'',''11270'',''R'')' || chr(10) || 'AND P258.TIPO_VERSAMENTO = DECODE(P442.COD_VOCE,''11250'',''S'',''11255'',''A'',''11270'',''S'')' || chr(10) || 'AND P442.COD_VOCE IN (''11250'',''11255'',''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Modello 730' || chr(10) || 'SELECT P441.PROGRESSIVO, DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'P260.ANNO + P260.ANNO_IMPOSTA ANNO,' || chr(10) || 'P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ')' || chr(10) || 'WHERE PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || 'ORDER BY TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO', 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || '-- IRPEF da competenze del mese' || chr(10) || 'SELECT P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210BASE'',''100E'',''11220BASE'',''102E'',''11230BASE'',''110E'',''11520BASE'',''112E'',''11525BASE'',''145E'',' || chr(10) || '       ''11500BASE'',DECODE(P430.COD_CAUSALEIRPEF,''1045'',''106E'',''104E''),' || chr(10) || '       ''11210CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),1,''111E'',''100E'')) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210CONG'',' || chr(10) || '       DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),' || chr(10) || '              1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) - 1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))),' || chr(10) || '       TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))) ANNO,' || chr(10) || 'P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P430_ANAGRAFICO P430' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.PROGRESSIVO = P430.PROGRESSIVO AND P441.DATA_CEDOLINO BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''11210BASE'',''11220BASE'',''11230BASE'',''11500BASE'',''11520BASE'',''11525BASE'',''11210CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Addizionali saldo e acconto' || chr(10) || 'SELECT P441.PROGRESSIVO, DECODE(P258.TIPO_ADDIZIONALE,''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'DECODE(P442.COD_VOCE,''11250'',''384E'',''11255'',''385E'',''11270'',''381E'') COD_TRIBUTO,' || chr(10) || 'P258.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE, P258.ANNO, P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P258_ADDIZIONALIIRPEF P258' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = DECODE(P442.COD_VOCE,''11250'',''C'',''11255'',''C'',''11270'',''R'')' || chr(10) || 'AND P258.TIPO_VERSAMENTO = DECODE(P442.COD_VOCE,''11250'',''S'',''11255'',''A'',''11270'',''S'')' || chr(10) || 'AND P442.COD_VOCE IN (''11250'',''11255'',''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Modello 730' || chr(10) || 'SELECT P441.PROGRESSIVO, DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'P260.ANNO + P260.ANNO_IMPOSTA ANNO,' || chr(10) || 'P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ')' || chr(10) || 'WHERE PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || 'ORDER BY TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO', 'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'E', '002', 'IRAP', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, IMPORTO IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT ''R'' TIPO_RIGA,''380E'' COD_TRIBUTO,' || chr(10) || '  (SELECT T482.COD_IRPEF FROM P500_CUDSETUP P500, T481_PROVINCE T481, T482_REGIONI T482' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') AND P500.PROVINCIA = T481.COD_PROVINCIA' || chr(10) || '     AND T481.COD_REGIONE = T482.COD_REGIONE)' || chr(10) || '  COD_ENTE,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'SUM(P442.IMPORTO) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.COD_VOCE IN (''11100'',''11102'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'AND PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY P441.DATA_CEDOLINO' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || ')', 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, IMPORTO IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT ''R'' TIPO_RIGA,''380E'' COD_TRIBUTO,' || chr(10) || '  (SELECT T482.COD_IRPEF FROM P500_CUDSETUP P500, T481_PROVINCE T481, T482_REGIONI T482' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') AND P500.PROVINCIA = T481.COD_PROVINCIA' || chr(10) || '     AND T481.COD_REGIONE = T482.COD_REGIONE)' || chr(10) || '  COD_ENTE,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'SUM(P442.IMPORTO) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.COD_VOCE IN (''11100'',''11102'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'AND PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY P441.DATA_CEDOLINO' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || ')', 'N', null, null, null, null, null, null, null);

  end if;
end;
/

alter table P215_CODICIACCORPAMENTOVOCI
  enable constraint P215_FK_P214;
  
  