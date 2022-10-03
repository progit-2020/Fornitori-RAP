alter table P042_ENTIIRPEF add SOGLIA_ESENZIONE NUMBER default 0 not null;
comment on column P042_ENTIIRPEF.SOGLIA_ESENZIONE
  is 'Eventuale soglia di esenzione';

delete t482_regioni t where t.cod_regione in ('10P','21D');

---------------------------
-- INIZIO Indennità funzione pos. org. quota min.
---------------------------

declare 
  CURSOR C1 IS  
  SELECT P200.COD_CONTRATTO,P200.COD_VOCE,P200.COD_VOCE_SPECIALE,P200.ID_VOCE FROM P200_VOCI P200
         WHERE P200.COD_CONTRATTO='EDP' AND P200.COD_VOCE='00355'
         AND P200.COD_VOCE_SPECIALE NOT IN('BASE','TRED')
         ORDER BY P200.COD_VOCE,P200.DECORRENZA;  

  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
select COUNT(*) into i from P200_VOCI t where T.COD_CONTRATTO='EDP' AND T.COD_VOCE='00355' AND NOT EXISTS
  (select 'x' from P200_VOCI V WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE='00350');
if i > 0 then

CodVoceModello:='00355';
CodVoceCopia:='00350';
DesVoceCopia:='Indennità funzione pos. org. quota min.';
DesVoceCopiaSt:='Indennita'' funzione pos. org. quota min.';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

INSERT INTO P205_QUOTE
select cod_contratto, cod_voce_da_quotare, cod_voce_speciale_da_quotare, CodVoceCopia, cod_voce_speciale_in_quota, decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio
from p205_quote T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_IN_QUOTA='00355';

INSERT INTO P216_ACCORPAMENTOVOCI
select cod_contratto, CodVoceCopia, cod_voce_speciale, cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine from p216_accorpamentovoci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE= CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

DesVoceCopia:='Indennità funz. pos.org. quota min. 13a';
DesVoceCopiaSt:='Indennita'' funz. pos.org. quota min. 13a';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' T', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='TRED';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='TRED';

INSERT INTO P216_ACCORPAMENTOVOCI
select cod_contratto, CodVoceCopia, cod_voce_speciale, cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine from p216_accorpamentovoci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE= CodVoceModello AND T.COD_VOCE_SPECIALE='TRED';

  FOR T1 IN C1 LOOP
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
   
    INSERT INTO P200_VOCI
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, descrizione, CodVoceCopia || ' A', descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine
    from p200_voci P200 WHERE P200.ID_VOCE=T1.ID_VOCE;

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
    FROM P201_ASSOGGETTAMENTI P201 WHERE P201.COD_CONTRATTO=T1.COD_CONTRATTO 
    AND P201.COD_VOCE_PADRE=T1.COD_VOCE AND P201.COD_VOCE_SPECIALE_PADRE=T1.COD_VOCE_SPECIALE;

    INSERT INTO P216_ACCORPAMENTOVOCI
    select cod_contratto, CodVoceCopia, cod_voce_speciale, cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine
    FROM p216_accorpamentovoci P216 WHERE P216.COD_CONTRATTO=T1.COD_CONTRATTO
    AND P216.COD_VOCE= T1.COD_VOCE AND P216.COD_VOCE_SPECIALE=T1.COD_VOCE_SPECIALE;

  END LOOP;

end if;
end;

---------------------------
-- FINE Indennità funzione pos. org. quota min.
---------------------------
/

-- *****************************************************************************
-- CREAZIONE VOCE 15069 Distacco sindacale retribuito 40%
-- *****************************************************************************

declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);

begin
  CodVoceModello:='15070';
  CodVoceCopia:='15069';
  DesVoceCopia:='Distacco sindacale retribuito 40%';

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
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopia, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, 60, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

-- Quote
INSERT INTO P205_QUOTE
SELECT COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE_DA_QUOTARE, COD_VOCE_IN_QUOTA, COD_VOCE_SPECIALE_IN_QUOTA, DECORRENZA, -60, ACCUMULO_RATEO, COD_VOCE_SPECIALE_DETTAGLIO FROM P205_QUOTE T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE=CodVoceModello AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE';

-- Assenze INPDAP
INSERT INTO P206_ASSENZEINPDAP 
SELECT COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE, DECORRENZA, ELIMINA_SEZIONE, ABBATTE_GGUTILI, COD_TIPOSERVIZIO, COD_GESTASSIC_NONCOPERTE, COD_CAUSASOSPENSIONE, 60 FROM P206_ASSENZEINPDAP T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE ='BASE';

  end if;
end if;
end;
/

insert into p080_causaliirpef
select 'F24145E','Contributo di solidarieta'' di cui all''articolo 2, comma 2, del D.L. n. 138/2011, trattenuto dal sostituto d''imposta a seguito delle operazioni di conguaglio di fine anno' from dual
where not exists
(select 'x' from p080_causaliirpef t where t.cod_causaleirpef='F24145E')
and exists
(select 'x' from p080_causaliirpef t where t.cod_causaleirpef='1001');

update p200_voci t
set t.cod_causaleirpef='F24145E'
where t.cod_contratto='EDP' and t.cod_voce='11525' and t.cod_voce_speciale='BASE';

declare
  i integer;
begin
  select COUNT(*) into i from P660_FLUSSIREGOLE t where t.Nome_Flusso='F24EP';
  if i > 0 then
     DELETE P660_FLUSSIREGOLE t where t.Nome_Flusso='F24EP';

insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'E', '001', 'IRPEF', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || '-- IRPEF da competenze del mese' || chr(10) || 'SELECT ''F'' TIPO_RIGA,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210BASE'',''100E'',''11220BASE'',''102E'',''11230BASE'',''110E'',''11520BASE'',''112E'',''11525BASE'',''145E'',' || chr(10) || '       ''11500BASE'',DECODE(P430.COD_CAUSALEIRPEF,''1045'',''106E'',''104E''),' || chr(10) || '       ''11210CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),1,''111E'',''100E'')) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210CONG'',' || chr(10) || '       DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),' || chr(10) || '              1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) - 1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))),' || chr(10) || '       TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))) ANNO,' || chr(10) || 'P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P430_ANAGRAFICO P430' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.PROGRESSIVO = P430.PROGRESSIVO AND P441.DATA_CEDOLINO BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''11210BASE'',''11220BASE'',''11230BASE'',''11500BASE'',''11520BASE'',''11525BASE'',''11210CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Addizionali saldo e acconto' || chr(10) || 'SELECT DECODE(P258.TIPO_ADDIZIONALE,''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'DECODE(P442.COD_VOCE,''11250'',''384E'',''11255'',''385E'',''11270'',''381E'') COD_TRIBUTO,' || chr(10) || 'P258.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE, P258.ANNO, P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P258_ADDIZIONALIIRPEF P258' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = DECODE(P442.COD_VOCE,''11250'',''C'',''11255'',''C'',''11270'',''R'')' || chr(10) || 'AND P258.TIPO_VERSAMENTO = DECODE(P442.COD_VOCE,''11250'',''S'',''11255'',''A'',''11270'',''S'')' || chr(10) || 'AND P442.COD_VOCE IN (''11250'',''11255'',''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Modello 730' || chr(10) || 'SELECT DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'P260.ANNO + P260.ANNO_IMPOSTA ANNO,' || chr(10) || 'P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ')' || chr(10) || 'GROUP BY TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || 'ORDER BY TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO', 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || '-- IRPEF da competenze del mese' || chr(10) || 'SELECT ''F'' TIPO_RIGA,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210BASE'',''100E'',''11220BASE'',''102E'',''11230BASE'',''110E'',''11520BASE'',''112E'',''11525BASE'',''145E'',' || chr(10) || '       ''11500BASE'',DECODE(P430.COD_CAUSALEIRPEF,''1045'',''106E'',''104E''),' || chr(10) || '       ''11210CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),1,''111E'',''100E'')) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210CONG'',' || chr(10) || '       DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),' || chr(10) || '              1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) - 1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))),' || chr(10) || '       TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))) ANNO,' || chr(10) || 'P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P430_ANAGRAFICO P430' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.PROGRESSIVO = P430.PROGRESSIVO AND P441.DATA_CEDOLINO BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''11210BASE'',''11220BASE'',''11230BASE'',''11500BASE'',''11520BASE'',''11525BASE'',''11210CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Addizionali saldo e acconto' || chr(10) || 'SELECT DECODE(P258.TIPO_ADDIZIONALE,''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'DECODE(P442.COD_VOCE,''11250'',''384E'',''11255'',''385E'',''11270'',''381E'') COD_TRIBUTO,' || chr(10) || 'P258.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE, P258.ANNO, P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P258_ADDIZIONALIIRPEF P258' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = DECODE(P442.COD_VOCE,''11250'',''C'',''11255'',''C'',''11270'',''R'')' || chr(10) || 'AND P258.TIPO_VERSAMENTO = DECODE(P442.COD_VOCE,''11250'',''S'',''11255'',''A'',''11270'',''S'')' || chr(10) || 'AND P442.COD_VOCE IN (''11250'',''11255'',''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Modello 730' || chr(10) || 'SELECT DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'P260.ANNO + P260.ANNO_IMPOSTA ANNO,' || chr(10) || 'P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ')' || chr(10) || 'GROUP BY TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || 'ORDER BY TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO', 'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'E', '002', 'IRAP', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, IMPORTO IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT ''R'' TIPO_RIGA,''380E'' COD_TRIBUTO,' || chr(10) || '  (SELECT T482.COD_IRPEF FROM P500_CUDSETUP P500, T481_PROVINCE T481, T482_REGIONI T482' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') AND P500.PROVINCIA = T481.COD_PROVINCIA' || chr(10) || '     AND T481.COD_REGIONE = T482.COD_REGIONE)' || chr(10) || '  COD_ENTE,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'SUM(P442.IMPORTO) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.COD_VOCE IN (''11100'',''11102'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'GROUP BY P441.DATA_CEDOLINO' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || ')', 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, IMPORTO IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT ''R'' TIPO_RIGA,''380E'' COD_TRIBUTO,' || chr(10) || '  (SELECT T482.COD_IRPEF FROM P500_CUDSETUP P500, T481_PROVINCE T481, T482_REGIONI T482' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') AND P500.PROVINCIA = T481.COD_PROVINCIA' || chr(10) || '     AND T481.COD_REGIONE = T482.COD_REGIONE)' || chr(10) || '  COD_ENTE,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'SUM(P442.IMPORTO) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.COD_VOCE IN (''11100'',''11102'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'GROUP BY P441.DATA_CEDOLINO' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || ')', 'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'I', '001', 'INPS DM10', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT ''I'' TIPO_RIGA, ''DM10'' COD_TRIBUTO, SEDE_INPS CODICE, MATRICOLA_INPS ESTREMI_IDENT, ' || chr(10) || '       TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, '''' RIFERIMENTO_B,' || chr(10) || '       SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT DECODE(P672.MATRICOLA_INPS,'''',P500.MATRICOLA_INPS,P672.MATRICOLA_INPS) MATRICOLA_INPS,' || chr(10) || '       P500.SEDE_INPS, DECODE(P673.NUMERO,''Z510'',1,''Z515'',-1) * P673.VALORE IMPORTO' || chr(10) || 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, P500_CUDSETUP P500' || chr(10) || 'WHERE P672.NOME_FLUSSO = ''UNIEMENS'' AND P672.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P672.Chiuso IN (:StatoUniemens) AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P673.NUMERO IN (''Z510'',''Z515'') AND P673.TIPO_RECORD = ''M''' || chr(10) || 'AND P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')' || chr(10) || ')' || chr(10) || 'GROUP BY SEDE_INPS, MATRICOLA_INPS' || chr(10) || 'ORDER BY MATRICOLA_INPS', 'SELECT ''I'' TIPO_RIGA, ''DM10'' COD_TRIBUTO, SEDE_INPS CODICE, MATRICOLA_INPS ESTREMI_IDENT, ' || chr(10) || '       TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, '''' RIFERIMENTO_B,' || chr(10) || '       SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT DECODE(P672.MATRICOLA_INPS,'''',P500.MATRICOLA_INPS,P672.MATRICOLA_INPS) MATRICOLA_INPS,' || chr(10) || '       P500.SEDE_INPS, DECODE(P673.NUMERO,''Z510'',1,''Z515'',-1) * P673.VALORE IMPORTO' || chr(10) || 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, P500_CUDSETUP P500' || chr(10) || 'WHERE P672.NOME_FLUSSO = ''UNIEMENS'' AND P672.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P672.Chiuso IN (:StatoUniemens) AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P673.NUMERO IN (''Z510'',''Z515'') AND P673.TIPO_RECORD = ''M''' || chr(10) || 'AND P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')' || chr(10) || ')' || chr(10) || 'GROUP BY SEDE_INPS, MATRICOLA_INPS' || chr(10) || 'ORDER BY MATRICOLA_INPS', 'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'I', '002', 'INPS gestione separata', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT ''I'' TIPO_RIGA, COD_TRIBUTO, SEDE_INPS CODICE, CAP||COMUNE ESTREMI_IDENT, ' || chr(10) || '       TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, '''' RIFERIMENTO_B,' || chr(10) || '       SUM(ROUND(IMPONIBILE * ALIQUOTA / 10000,2)) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT P500.SEDE_INPS, TRIM(P500.CAP) CAP, TRIM(P500.COMUNE) COMUNE,' || chr(10) || '       DECODE(P430.COD_TIPOASSOGGETTAMENTO,''INPS1'',''C10'',''INPS2'',''CXX'',''INPS3'',''C10'') COD_TRIBUTO,' || chr(10) || '       P673.VALORE IMPONIBILE,' || chr(10) || '     NVL((SELECT P673A.VALORE FROM P673_XMLDATIINDIVIDUALI P673A WHERE P673A.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || '     AND P673A.PROGRESSIVO = P673.PROGRESSIVO' || chr(10) || '     AND P673A.PROGRESSIVO_NUMERO = P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD = P673.TIPO_RECORD' || chr(10) || '     AND P673A.NUMERO = ''C035''),0) ALIQUOTA' || chr(10) || 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, P500_CUDSETUP P500, P430_ANAGRAFICO P430' || chr(10) || 'WHERE P672.NOME_FLUSSO = ''UNIEMENS'' AND P672.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P672.Chiuso IN (:StatoUniemens) AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P673.NUMERO = ''C030'' AND P673.TIPO_RECORD = ''M''' || chr(10) || 'AND P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')' || chr(10) || 'AND P430.PROGRESSIVO = P673.PROGRESSIVO AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || ')' || chr(10) || 'GROUP BY SEDE_INPS, CAP, COMUNE, COD_TRIBUTO' || chr(10) || 'ORDER BY COD_TRIBUTO', 'SELECT ''I'' TIPO_RIGA, COD_TRIBUTO, SEDE_INPS CODICE, CAP||COMUNE ESTREMI_IDENT, ' || chr(10) || '       TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, '''' RIFERIMENTO_B,' || chr(10) || '       SUM(ROUND(IMPONIBILE * ALIQUOTA / 10000,2)) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT P500.SEDE_INPS, TRIM(P500.CAP) CAP, TRIM(P500.COMUNE) COMUNE,' || chr(10) || '       DECODE(P430.COD_TIPOASSOGGETTAMENTO,''INPS1'',''C10'',''INPS2'',''CXX'',''INPS3'',''C10'') COD_TRIBUTO,' || chr(10) || '       P673.VALORE IMPONIBILE,' || chr(10) || '     NVL((SELECT P673A.VALORE FROM P673_XMLDATIINDIVIDUALI P673A WHERE P673A.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || '     AND P673A.PROGRESSIVO = P673.PROGRESSIVO' || chr(10) || '     AND P673A.PROGRESSIVO_NUMERO = P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD = P673.TIPO_RECORD' || chr(10) || '     AND P673A.NUMERO = ''C035''),0) ALIQUOTA' || chr(10) || 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, P500_CUDSETUP P500, P430_ANAGRAFICO P430' || chr(10) || 'WHERE P672.NOME_FLUSSO = ''UNIEMENS'' AND P672.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P672.Chiuso IN (:StatoUniemens) AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P673.NUMERO = ''C030'' AND P673.TIPO_RECORD = ''M''' || chr(10) || 'AND P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')' || chr(10) || 'AND P430.PROGRESSIVO = P673.PROGRESSIVO AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || ')' || chr(10) || 'GROUP BY SEDE_INPS, CAP, COMUNE, COD_TRIBUTO' || chr(10) || 'ORDER BY COD_TRIBUTO', 'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'Q', '001', 'INPDAP', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT ''Q'' TIPO_RIGA, ''P''||CASSA||CAUSALE COD_TRIBUTO,' || chr(10) || '       (SELECT TRIM(UPPER(P500.PROVINCIA)) FROM P500_CUDSETUP P500 WHERE P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')) CODICE,' || chr(10) || '       '''' ESTREMI_IDENT, TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_B, IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT PROGRESSIVO_NUMERO, CASSA, CAUSALE, SUM(VALORE) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT P663.PROGRESSIVO_NUMERO,' || chr(10) || '  (SELECT P663A.VALORE FROM P663_FLUSSIDATIINDIVIDUALI P663A WHERE P663A.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || '     AND P663A.PROGRESSIVO = P663.PROGRESSIVO AND P663A.PARTE = P663.PARTE' || chr(10) || '     AND P663A.PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND P663A.TIPO_RECORD = P663.TIPO_RECORD' || chr(10) || '     AND P663A.NUMERO = ''001'') CASSA,' || chr(10) || '  P660.CODICI_CAUSALI CAUSALE,' || chr(10) || '  P663.VALORE' || chr(10) || 'FROM P662_FLUSSITESTATE P662, P663_FLUSSIDATIINDIVIDUALI P663, P660_FLUSSIREGOLE P660' || chr(10) || 'WHERE P662.NOME_FLUSSO = ''DMA'' AND P662.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P662.Chiuso IN (:StatoDMA) AND P662.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || 'AND P663.PARTE = ''Z2'' AND P663.TIPO_RECORD = ''M'' AND EXISTS' || chr(10) || '  (SELECT ''X'' FROM P663_FLUSSIDATIINDIVIDUALI P663B WHERE P663B.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || '   AND P663B.PROGRESSIVO = P663.PROGRESSIVO AND P663B.PARTE = P663.PARTE' || chr(10) || '   AND P663B.PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND P663B.TIPO_RECORD = P663.TIPO_RECORD' || chr(10) || '   AND P663B.NUMERO = ''003'' AND P663B.VALORE = ''31'')' || chr(10) || 'AND P660.NOME_FLUSSO = P662.NOME_FLUSSO AND P660.PARTE = P663.PARTE  ' || chr(10) || 'AND P660.NUMERO = P663.NUMERO ' || chr(10) || 'AND P660.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P660_FLUSSIREGOLE P660A ' || chr(10) || '                       WHERE P660.NOME_FLUSSO = P660A.NOME_FLUSSO AND P660.PARTE = P660A.PARTE ' || chr(10) || '                       AND P660.NUMERO = P660A.NUMERO AND P660A.DECORRENZA <= :DataElaborazione)' || chr(10) || 'AND P660.CODICI_CAUSALI IS NOT NULL AND P663.NUMERO <> ''021''' || chr(10) || '' || chr(10) || 'UNION ALL' || chr(10) || '' || chr(10) || 'SELECT 10000 PROGRESSIVO_NUMERO,' || chr(10) || '(SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '    AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''002'' ' || chr(10) || '    AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD) CASSA,' || chr(10) || '(SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '   AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''003'' ' || chr(10) || '   AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD) CAUSALE,' || chr(10) || 'DECODE((SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '   AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''007'' ' || chr(10) || '   AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD),''V'',VALORE,''R'',-VALORE) IMPORTO' || chr(10) || 'FROM P662_FLUSSITESTATE P662, P663_FLUSSIDATIINDIVIDUALI P663' || chr(10) || 'WHERE P662.NOME_FLUSSO = ''DMA'' AND P662.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P662.Chiuso IN (:StatoDMA) AND P662.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || 'AND TIPO_RECORD = ''M'' AND PARTE = ''F1'' AND NUMERO = ''005''' || chr(10) || 'AND (SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '    AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''003'' ' || chr(10) || '    AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD) IN (''12'',''41'')' || chr(10) || ')' || chr(10) || 'GROUP BY PROGRESSIVO_NUMERO, CASSA, CAUSALE' || chr(10) || 'ORDER BY PROGRESSIVO_NUMERO, CASSA, CAUSALE' || chr(10) || ')', 'SELECT ''Q'' TIPO_RIGA, ''P''||CASSA||CAUSALE COD_TRIBUTO,' || chr(10) || '       (SELECT TRIM(UPPER(P500.PROVINCIA)) FROM P500_CUDSETUP P500 WHERE P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')) CODICE,' || chr(10) || '       '''' ESTREMI_IDENT, TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_B, IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT PROGRESSIVO_NUMERO, CASSA, CAUSALE, SUM(VALORE) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT P663.PROGRESSIVO_NUMERO,' || chr(10) || '  (SELECT P663A.VALORE FROM P663_FLUSSIDATIINDIVIDUALI P663A WHERE P663A.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || '     AND P663A.PROGRESSIVO = P663.PROGRESSIVO AND P663A.PARTE = P663.PARTE' || chr(10) || '     AND P663A.PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND P663A.TIPO_RECORD = P663.TIPO_RECORD' || chr(10) || '     AND P663A.NUMERO = ''001'') CASSA,' || chr(10) || '  P660.CODICI_CAUSALI CAUSALE,' || chr(10) || '  P663.VALORE' || chr(10) || 'FROM P662_FLUSSITESTATE P662, P663_FLUSSIDATIINDIVIDUALI P663, P660_FLUSSIREGOLE P660' || chr(10) || 'WHERE P662.NOME_FLUSSO = ''DMA'' AND P662.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P662.Chiuso IN (:StatoDMA) AND P662.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || 'AND P663.PARTE = ''Z2'' AND P663.TIPO_RECORD = ''M'' AND EXISTS' || chr(10) || '  (SELECT ''X'' FROM P663_FLUSSIDATIINDIVIDUALI P663B WHERE P663B.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || '   AND P663B.PROGRESSIVO = P663.PROGRESSIVO AND P663B.PARTE = P663.PARTE' || chr(10) || '   AND P663B.PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND P663B.TIPO_RECORD = P663.TIPO_RECORD' || chr(10) || '   AND P663B.NUMERO = ''003'' AND P663B.VALORE = ''31'')' || chr(10) || 'AND P660.NOME_FLUSSO = P662.NOME_FLUSSO AND P660.PARTE = P663.PARTE  ' || chr(10) || 'AND P660.NUMERO = P663.NUMERO ' || chr(10) || 'AND P660.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P660_FLUSSIREGOLE P660A ' || chr(10) || '                       WHERE P660.NOME_FLUSSO = P660A.NOME_FLUSSO AND P660.PARTE = P660A.PARTE ' || chr(10) || '                       AND P660.NUMERO = P660A.NUMERO AND P660A.DECORRENZA <= :DataElaborazione)' || chr(10) || 'AND P660.CODICI_CAUSALI IS NOT NULL AND P663.NUMERO <> ''021''' || chr(10) || '' || chr(10) || 'UNION ALL' || chr(10) || '' || chr(10) || 'SELECT 10000 PROGRESSIVO_NUMERO,' || chr(10) || '(SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '    AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''002'' ' || chr(10) || '    AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD) CASSA,' || chr(10) || '(SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '   AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''003'' ' || chr(10) || '   AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD) CAUSALE,' || chr(10) || 'DECODE((SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '   AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''007'' ' || chr(10) || '   AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD),''V'',VALORE,''R'',-VALORE) IMPORTO' || chr(10) || 'FROM P662_FLUSSITESTATE P662, P663_FLUSSIDATIINDIVIDUALI P663' || chr(10) || 'WHERE P662.NOME_FLUSSO = ''DMA'' AND P662.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P662.Chiuso IN (:StatoDMA) AND P662.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || 'AND TIPO_RECORD = ''M'' AND PARTE = ''F1'' AND NUMERO = ''005''' || chr(10) || 'AND (SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '    AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''003'' ' || chr(10) || '    AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD) IN (''12'',''41'')' || chr(10) || ')' || chr(10) || 'GROUP BY PROGRESSIVO_NUMERO, CASSA, CAUSALE' || chr(10) || 'ORDER BY PROGRESSIVO_NUMERO, CASSA, CAUSALE' || chr(10) || ')', 'N', null, null, null, null, null, null, null);

  end if;
end;
/

-- *********************************************************************************
-- IMPOSTAZIONE NUOVO SCAGLIONE PER INPGI
-- ****************  2012 ****************
-- *********************************************************************************

declare 
  AnnoNuovo integer;
  Scaglione real;

begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2012;
  -- IMPOSTARE QUI IL NUOVO SCAGLIONE PER MAGGIORAZIONE 1%
  Scaglione:=43228;

  UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_A=Scaglione WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));


  UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_DA=Scaglione+0.01 WHERE P233.IMPORTO_A=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
 
end;
/

-- CREAZIONE SINDACATI VARI
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='12371';
CodVoceCopia:='12446';
DesVoceCopia:='Fedir Sanità a importo fisso - SICUS';
DesVoceCopiaSt:='Fedir Sanita'' a importo fisso - SICUS';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio Fedir Sanità a importo fisso - SICUS
-----
  
SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

DesVoceCopia:='Fedir Sanità a importo fisso - SICUS 13a';
DesVoceCopiaSt:='Fedir Sanita'' a importo fisso-SICUS 13a';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' T', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='TRED';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='TRED';

-----
-- Fine Fedir Sanità a importo fisso - SICUS
-----

  end if;
end if;
end;
/
-- Aggiornamento dati liberi legati ai corsi
update sg500_datiliberi 
  set nomecampo = 'CF_EDIZIONE'
where archivio = 'VSG651_CORSI'
  and decodifica_valore like '%SG660F_ELENCO_DATE%';

-- Aggiornameto parametri avanzati voci per scarico paghe
alter table T193_VOCIPAGHE_PARAMETRI add SPOSTA_VALIMP VARCHAR2(1) default 'N';
comment on column T193_VOCIPAGHE_PARAMETRI.SPOSTA_VALIMP
  is 'Forza la registrazione del valore nel campo Importo e forza a 1 il campo quantità';

update t480_comuni t set t.citta='SAN NICANDRO GARGANICO'
where t.codcatastale='I054';

alter table M010_PARAMETRICONTEGGIO add TIPO_RIMBORSOPASTO varchar2(1) default '0';
comment on column M010_PARAMETRICONTEGGIO.TIPO_RIMBORSOPASTO is '0=scaglioni giornalieri, 1=scaglioni cumulativi, 2=numero pasti';

alter table SG659_GIORNATECORSI add INIZIO1 varchar2(5);
alter table SG659_GIORNATECORSI add FINE1 varchar2(5);
alter table SG659_GIORNATECORSI add INIZIO2 varchar2(5);
alter table SG659_GIORNATECORSI add FINE2 varchar2(5);
comment on column SG659_GIORNATECORSI.INIZIO1 is 'Ora di inizio del primo spezzone (mattino)';
comment on column SG659_GIORNATECORSI.FINE1 is 'Ora di fine del primo spezzone (mattino)';
comment on column SG659_GIORNATECORSI.INIZIO2 is 'Ora di inizio del secondo spezzone (pomeriggio)';
comment on column SG659_GIORNATECORSI.FINE2 is 'Ora di fine del secondo spezzone (pomeriggio)';
