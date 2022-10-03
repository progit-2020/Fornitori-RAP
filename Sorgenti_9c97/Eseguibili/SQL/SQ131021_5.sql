alter table T048_ATTESTATIINPS modify via_dom VARCHAR2(80);
alter table T048_ATTESTATIINPS modify via_rep VARCHAR2(80);

alter table SG711_VALUTAZIONI_DIPENDENTE modify PUNTEGGIO_PESATO NUMBER(8,5);
alter table SG711_VALUTAZIONI_DIPENDENTE modify PERC_VALUTAZIONE NUMBER(8,5);

-- Assoggettamento voce 02105 (Assegno alimentare assogg.) a CPS
      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, '02105', cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDP' and t.cod_voce_padre='00025' and t.cod_voce_speciale_padre='BASE'
      and t.cod_voce_figlio not between '12000' and '12900' and t.cod_voce_figlio not in ('10030','10032')
      and exists
        (select 'x' from p200_voci z where z.cod_contratto=t.cod_contratto and z.cod_voce='02105' and z.cod_voce_speciale=t.cod_voce_speciale_padre)
      and not exists
        (select 'x' from p201_assoggettamenti v where v.cod_contratto=t.cod_contratto and v.cod_voce_padre='02105'
           and v.cod_voce_speciale_padre=t.cod_voce_speciale_padre and v.cod_voce_figlio=t.cod_voce_figlio
           and v.cod_voce_speciale_figlio=t.cod_voce_speciale_figlio);

---------------------------
-- INIZIO Riduzione per sciopero voce 00380-15105 (Indennità ufficiale di polizia giudiz.)
---------------------------

declare 
  i integer;
  ID_P200 integer;
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
select COUNT(*) into i from P200_VOCI t where T.COD_CONTRATTO='EDP' AND T.COD_VOCE='00380' AND NOT EXISTS
  (select 'x' from P200_VOCI V WHERE V.COD_CONTRATTO=T.COD_CONTRATTO AND V.COD_VOCE=T.COD_VOCE AND V.COD_VOCE_SPECIALE='15105') AND EXISTS
  (select 'x' from P200_VOCI V WHERE V.COD_CONTRATTO=T.COD_CONTRATTO AND V.COD_VOCE='00370' AND V.COD_VOCE_SPECIALE='15105');
if i > 0 then

  DesVoceCopia:='Riduzione per sciopero';
  DesVoceCopiaSt:='Riduzione per sciopero';

  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
  insert into p200_voci
  select cod_contratto, cod_voce, '15105', to_date('01011900','ddmmyyyy'), ID_P200, DesVoceCopia, cod_voce || ' A', DesVoceCopiaSt, protetta, 'RA', 'N', cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, 'N', '', ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, 0, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', 'P', cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, 'N', ritenuta_anagrafica, decorrenza_fine, '', '' from p200_voci T
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='00380' AND T.COD_VOCE_SPECIALE='BASE'
        and t.decorrenza_fine=to_date('31123999','ddmmyyyy');

  INSERT INTO P201_ASSOGGETTAMENTI
  select cod_contratto, cod_voce_padre, '15105', cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento, decorrenza_fine from p201_assoggettamenti t
  where T.COD_CONTRATTO='EDP' and t.cod_voce_padre='00380' and t.cod_voce_speciale_padre='BASE'
  and t.cod_voce_figlio not between '12000' and '12900';

  INSERT INTO P205_QUOTE
  select cod_contratto, cod_voce_da_quotare, cod_voce_speciale_da_quotare, '00380', cod_voce_speciale_in_quota, decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio, cod_voce_speciale_dettaglio13a from p205_quote T
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE IN ('15105','15107') AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE'
  AND T.COD_VOCE_IN_QUOTA='00370' AND T.COD_VOCE_SPECIALE_IN_QUOTA='BASE';

end if;
end;

---------------------------
-- FINE Riduzione per sciopero voce 00380-15105 (Indennità ufficiale di polizia giudiz.)
---------------------------
/

---------------------------
-- Inizio creazione voci per Bonus riduzione cuneo fiscale
---------------------------

declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);
  CodVoceFiglio varchar2(5);

begin

-- Creazione voci EDP

  select COUNT(*) into i from P200_VOCI t where t.cod_contratto='EDP'
    and t.cod_voce='11905' and t.cod_voce_speciale='BASE'
    and not exists
    (select 'x' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce='13160'
     and v.cod_voce_speciale=t.cod_voce_speciale);

if i > 0 then

      CodVoceModello:='11905';
      CodVoceCopia:='13160';
      DesVoceCopia:='Bonus riduzione cuneo fiscale';
      DesVoceCopiaSt:='Bonus riduzione cuneo fiscale';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, 'S', 'T', importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', '' from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

      CodVoceCopia:='13162';
      DesVoceCopia:='Bonus riduzione cuneo fiscale a cong.';
      DesVoceCopiaSt:='Bonus riduzione cuneo fiscale a cong.';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, 'CONG', decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' C', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, 'S', 'T', importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, 'S', stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', '' from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, 'CONG', cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

end if;

-- Creazione voci EDPSC

  select COUNT(*) into i from P200_VOCI t where t.cod_contratto='EDPSC'
    and t.cod_voce='11905' and t.cod_voce_speciale='BASE'
    and not exists
    (select 'x' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce='13160'
     and v.cod_voce_speciale=t.cod_voce_speciale);

if i > 0 then

      CodVoceModello:='11905';
      CodVoceCopia:='13160';
      DesVoceCopia:='Bonus riduzione cuneo fiscale';
      DesVoceCopiaSt:='Bonus riduzione cuneo fiscale';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, 'S', 'T', importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', '' from p200_voci T
      WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

      CodVoceCopia:='13162';
      DesVoceCopia:='Bonus riduzione cuneo fiscale a cong.';
      DesVoceCopiaSt:='Bonus riduzione cuneo fiscale a cong.';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, 'CONG', decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' C', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, 'S', 'T', importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, 'S', stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', '' from p200_voci T
      WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, 'CONG', cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

end if;

end;
/

---------------------------
-- Fine creazione voci per Bonus riduzione cuneo fiscale
---------------------------

-----
-- F24EP per Bonus riduzione cuneo fiscale
-----

declare
  i integer;
begin
  select COUNT(*) into i from P660_FLUSSIREGOLE t where t.Nome_Flusso='F24EP' and t.parte='E';
  if i > 0 then
     DELETE P660_FLUSSIREGOLE t where t.Nome_Flusso='F24EP' and t.parte='E';

insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'E', '001', 'IRPEF/IRAP prima parte', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 
        'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE,' || chr(10) || '       SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || '-- IRPEF da competenze del mese' || chr(10) || 'SELECT ''01-IRPEF'' TIPO_TASSA, P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210BASE'',''100E'',''11220BASE'',''102E'',''11230BASE'',''110E'',''11520BASE'',''112E'',''11525BASE'',''145E'',''13160BASE'',''100E'',' || chr(10) || '       ''11500BASE'',DECODE(P430.COD_CAUSALEIRPEF,''1045'',''106E'',''104E''),' || chr(10) || '       ''11210CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),1,''111E'',''100E''),' || chr(10) || '       ''13162CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),1,''111E'',''100E'')) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,' || chr(10) || '       ''11210CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),' || chr(10) || '                          1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) - 1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))),' || chr(10) || '       ''13162CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),' || chr(10) || '                          1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) - 1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))),' || chr(10) || '       TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))) ANNO,' || chr(10) || 'P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442,' || chr(10) || '     P200_VOCI P200, P430_ANAGRAFICO P430' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.PROGRESSIVO = P430.PROGRESSIVO AND P441.DATA_CEDOLINO BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''11210BASE'',''11220BASE'',''11230BASE'',''11500BASE'',''11520BASE'',''11525BASE'',''13160BASE'',''11210CONG'',''13162CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL' || chr(10) || '-- Addizionali IRPEF saldo e acconto' || chr(10) || 'SELECT ''01-IRPEF'' TIPO_TASSA, P441.PROGRESSIVO, DECODE(P258.TIPO_ADDIZIONALE,''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'DECODE(P442.COD_VOCE,''11250'',''384E'',''11255'',''385E'',''11270'',''381E'') COD_TRIBUTO,' || chr(10) || 'P258.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE, P258.ANNO, P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442,' || chr(10) || '     P200_VOCI P200, P258_ADDIZIONALIIRPEF P258' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = DECODE(P442.COD_VOCE,''11250'',''C'',''11255'',''C'',''11270'',''R'')' || chr(10) || 'AND P258.TIPO_VERSAMENTO = DECODE(P442.COD_VOCE,''11250'',''S'',''11255'',''A'',''11270'',''S'')' || chr(10) || 'AND P442.COD_VOCE IN (''11250'',''11255'',''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL' || chr(10) || '', 
        'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE,' || chr(10) || '       SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || '-- IRPEF da competenze del mese' || chr(10) || 'SELECT ''01-IRPEF'' TIPO_TASSA, P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210BASE'',''100E'',''11220BASE'',''102E'',''11230BASE'',''110E'',''11520BASE'',''112E'',''11525BASE'',''145E'',''13160BASE'',''100E'',' || chr(10) || '       ''11500BASE'',DECODE(P430.COD_CAUSALEIRPEF,''1045'',''106E'',''104E''),' || chr(10) || '       ''11210CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),1,''111E'',''100E''),' || chr(10) || '       ''13162CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),1,''111E'',''100E'')) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,' || chr(10) || '       ''11210CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),' || chr(10) || '                          1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) - 1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))),' || chr(10) || '       ''13162CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),' || chr(10) || '                          1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) - 1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))),' || chr(10) || '       TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))) ANNO,' || chr(10) || 'P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442,' || chr(10) || '     P200_VOCI P200, P430_ANAGRAFICO P430' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.PROGRESSIVO = P430.PROGRESSIVO AND P441.DATA_CEDOLINO BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''11210BASE'',''11220BASE'',''11230BASE'',''11500BASE'',''11520BASE'',''11525BASE'',''13160BASE'',''11210CONG'',''13162CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL' || chr(10) || '-- Addizionali IRPEF saldo e acconto' || chr(10) || 'SELECT ''01-IRPEF'' TIPO_TASSA, P441.PROGRESSIVO, DECODE(P258.TIPO_ADDIZIONALE,''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'DECODE(P442.COD_VOCE,''11250'',''384E'',''11255'',''385E'',''11270'',''381E'') COD_TRIBUTO,' || chr(10) || 'P258.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE, P258.ANNO, P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442,' || chr(10) || '     P200_VOCI P200, P258_ADDIZIONALIIRPEF P258' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = DECODE(P442.COD_VOCE,''11250'',''C'',''11255'',''C'',''11270'',''R'')' || chr(10) || 'AND P258.TIPO_VERSAMENTO = DECODE(P442.COD_VOCE,''11250'',''S'',''11255'',''A'',''11270'',''S'')' || chr(10) || 'AND P442.COD_VOCE IN (''11250'',''11255'',''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL' || chr(10) || '', 
        'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'E', '002', 'IRPEF/IRAP seconda parte', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 
        '-- IRPEF da modello 730' || chr(10) || 'SELECT ''01-IRPEF'' TIPO_TASSA, P441.PROGRESSIVO, DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'P260.ANNO + P260.ANNO_IMPOSTA ANNO,' || chr(10) || 'P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || 'UNION ALL' || chr(10) || '-- IRAP' || chr(10) || 'SELECT ''02-IRAP'' TIPO_TASSA, P441.PROGRESSIVO, ''R'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || '''380E'' COD_TRIBUTO,' || chr(10) || '  (SELECT T482.COD_IRPEF FROM P500_CUDSETUP P500, T481_PROVINCE T481, T482_REGIONI T482' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') AND P500.PROVINCIA = T481.COD_PROVINCIA' || chr(10) || '     AND T481.COD_REGIONE = T482.COD_REGIONE)' || chr(10) || '  COD_ENTE,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE IN (''11100'',''11102'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || ')' || chr(10) || 'WHERE PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY TIPO_TASSA, TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || 'ORDER BY TIPO_TASSA, TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || '', 
        '-- IRPEF da modello 730' || chr(10) || 'SELECT ''01-IRPEF'' TIPO_TASSA, P441.PROGRESSIVO, DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'P260.ANNO + P260.ANNO_IMPOSTA ANNO,' || chr(10) || 'P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || 'UNION ALL' || chr(10) || '-- IRAP' || chr(10) || 'SELECT ''02-IRAP'' TIPO_TASSA, P441.PROGRESSIVO, ''R'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || '''380E'' COD_TRIBUTO,' || chr(10) || '  (SELECT T482.COD_IRPEF FROM P500_CUDSETUP P500, T481_PROVINCE T481, T482_REGIONI T482' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') AND P500.PROVINCIA = T481.COD_PROVINCIA' || chr(10) || '     AND T481.COD_REGIONE = T482.COD_REGIONE)' || chr(10) || '  COD_ENTE,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE IN (''11100'',''11102'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || ')' || chr(10) || 'WHERE PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY TIPO_TASSA, TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || 'ORDER BY TIPO_TASSA, TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || '', 
        'N', null, null, null, null, null, null, null);

  end if;
end;
/

