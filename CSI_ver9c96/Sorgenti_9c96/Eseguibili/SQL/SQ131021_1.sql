-- Assoggettamento della voce EDP-10090-CONG alla voce 10200-BASE
declare
  i integer;

begin
  select COUNT(*) into i from P200_VOCI t where t.cod_contratto='EDP'
    and t.cod_voce='11090' and t.cod_voce_speciale='CONG' and upper(t.descrizione) like '%INPGI%'
    and not exists
    (select 'x' from P201_ASSOGGETTAMENTI v where v.cod_contratto=t.cod_contratto and v.cod_voce_padre=t.cod_voce
     and v.cod_voce_speciale_padre=t.cod_voce_speciale and v.cod_voce_figlio='10200');

if i > 0 then

  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '11090', 'CONG', '10200', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), -100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));

end if;

end;
/

-------------------------------
-- INIZIO MENSILIZZAZIONE CPDEL
-------------------------------

declare
  i integer;
  ID_P200 integer;
  ID_P233 integer;

  CURSOR C1 IS  
  select t.* from P232_SCAGLIONI t
  where t.cod_contratto='EDP' and t.cod_voce='11010' and t.cod_voce_speciale='BASE'
  order by t.decorrenza;
  
begin
  select COUNT(*) into i from P200_VOCI t where t.cod_contratto='EDP'
    and t.cod_voce='11010' and t.cod_voce_speciale='BASE' and upper(t.descrizione) like '%CPDEL%'
    and not exists
    (select 'x' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce='11017'
     and v.cod_voce_speciale='BASE');

if i > 0 then

  -- Creazione voce 11017-ENTE Ritenuta CPDEL dipendente-ente 1% agg.
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into P200_VOCI (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_voce, descrizione, cod_voce_stampa, descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo)
  values ('EDP', '11017', 'ENTE', to_date('01-01-1900', 'dd-mm-yyyy'), ID_P200, 'Ritenuta CPDEL dipendente-ente 1% agg.', '11017 E', 'Ritenuta CPDEL dipendente-ente 1% agg.', 'S', 'RI', 'N', 'CS', 'S', 'S', 'T', 0, 'E', 'N', null, 'N', 0, 'N', 'P1', 0, 'S', 'S', 'N', 'S', 'N', null, 'N', 'N', 'N', 'S', 'N', 'N', 'N', 'N', 'IB', null, 0, null, 'M', null, null, null, 'N', 'N', 'N', 'N', null, null, 'N', null, to_date('31-12-3999', 'dd-mm-yyyy'), null, null);

  insert into P216_ACCORPAMENTOVOCI
  select cod_contratto, '11017', 'ENTE', cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine from p216_accorpamentovoci t
    where t.cod_contratto='EDP' and t.cod_voce='11010' and t.cod_voce_speciale='ENTE';

  -- Creazione voce 11017-CONG Ritenuta CPDEL dipendente 1% a cong.
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into P200_VOCI (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_voce, descrizione, cod_voce_stampa, descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo)
  values ('EDP', '11017', 'CONG', to_date('01-01-1900', 'dd-mm-yyyy'), ID_P200, 'Ritenuta CPDEL dipendente 1% a cong.', '11017 C', 'Ritenuta CPDEL dipendente 1% a cong.', 'S', 'RI', 'N', 'CS', 'S', 'S', 'T', 0, 'R', 'N', null, 'N', 0, 'N', 'P1', 0, 'S', 'S', 'S', 'S', 'N', null, 'N', 'N', 'N', 'S', 'N', 'N', 'N', 'N', 'IB', null, 0, null, 'M', null, null, null, 'N', 'N', 'N', 'N', null, null, 'N', null, to_date('31-12-3999', 'dd-mm-yyyy'), null, null);

  insert into P216_ACCORPAMENTOVOCI
  select cod_contratto, '11017', 'CONG', cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine from p216_accorpamentovoci t
    where t.cod_contratto='EDP' and t.cod_voce='11010' and t.cod_voce_speciale='BASE';

  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '11017', 'CONG', '10200', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), -100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));
  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '11017', 'CONG', '12960', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), 100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));

  -- Creazione voce 11017-BASE Ritenuta CPDEL dipendente 1% aggiuntivo
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into P200_VOCI (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_voce, descrizione, cod_voce_stampa, descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo)
  values ('EDP', '11017', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), ID_P200, 'Ritenuta CPDEL dipendente 1% aggiuntivo', '11017 ', 'Ritenuta CPDEL dipendente 1% aggiuntivo', 'S', 'RI', 'N', 'CS', 'S', 'S', 'T', 0, 'R', 'N', null, 'S', 0, 'N', 'P1', 0, 'S', 'S', 'D', 'S', 'N', null, 'N', 'N', 'N', 'S', 'N', 'N', 'N', 'N', 'IB', null, 0, null, 'M', null, null, null, 'N', 'N', 'N', 'N', null, 'TLEGG', 'N', null, to_date('31-12-3999', 'dd-mm-yyyy'), null, null);

  insert into P216_ACCORPAMENTOVOCI
  select cod_contratto, '11017', 'BASE', cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine from p216_accorpamentovoci t
    where t.cod_contratto='EDP' and t.cod_voce='11010' and t.cod_voce_speciale='BASE';

  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '11017', 'BASE', '10200', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), -100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));
  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '11017', 'BASE', '12960', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), 100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));

  -- Creazione scaglioni per voce 11017-BASE Ritenuta CPDEL dipendente 1% aggiuntivo
  FOR T1 IN C1 LOOP

    SELECT P233_ID_SCAGLIONE.NEXTVAL INTO ID_P233 FROM DUAL;

    insert into p232_scaglioni
      (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_scaglione, tipo_importo, tipo_ritenuta, tipo_applicazione, conguaglio_annuale, conguaglio_fine_rapporto, conguaglio_dopo_fine_rapporto, cod_voce_conguaglio, cod_voce_speciale_conguaglio, mensilita_annue, massimale1, massimale2)
    values
      ('EDP', '11017', 'BASE', T1.decorrenza, ID_P233, 'A', 'P', 'M', 'S', 'S', 'S', '11017', 'CONG', 12, 0, 0);

    insert into p233_scaglionifasce
    select ID_P233, importo_da, importo_a, decode(importo_da,0,0,1) perc_imp from p233_scaglionifasce t
    where t.id_scaglione=T1.id_Scaglione;

  END LOOP;

  -- Trasformazione scaglioni per voci 11010-BASE-ENTE con percentuale unica
  update p233_scaglionifasce t 
  set t.importo_a=1000000
  where t.importo_da=0 and t.id_scaglione in
  (select v.id_scaglione from P232_SCAGLIONI v
  where v.cod_contratto='EDP' and v.cod_voce='11010' and v.cod_voce_speciale in ('BASE','ENTE'));

  update p233_scaglionifasce t
  set t.importo_da=1000000.01,
      t.perc_imp=(select t1.perc_imp from p233_scaglionifasce t1 where t1.id_scaglione=t.id_scaglione
                  and t1.importo_da=0)
  where t.importo_a=0 and t.id_scaglione in
  (select v.id_scaglione from P232_SCAGLIONI v
  where v.cod_contratto='EDP' and v.cod_voce='11010' and v.cod_voce_speciale in ('BASE','ENTE'));

  -- Creazione voce 10017-BASE Imponibile CPDEL dipendente 1% aggiunt.
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into P200_VOCI (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_voce, descrizione, cod_voce_stampa, descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo)
  values ('EDP', '10017', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), ID_P200, 'Imponibile CPDEL dipendente 1% aggiunt.', '10017 ', 'Imponibile CPDEL dipendente 1% aggiunt.', 'S', 'IM', 'N', 'CS', 'S', 'S', 'T', 0, 'D', 'N', null, 'N', 0, 'N', 'P1', 0, 'S', 'S', 'N', 'N', 'N', null, 'S', 'S', 'N', 'S', 'N', 'N', 'N', 'N', 'NS', null, 0, null, 'M', null, null, null, 'N', 'N', 'S', 'N', null, 'ILEGG', 'N', null, to_date('31-12-3999', 'dd-mm-yyyy'), null, null);

  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '10017', 'BASE', '11017', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), 100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));

  -- Inserimento su tipi assoggettamento della voce 10017-BASE dove già presente la voce voci 11010-BASE-ENTE
  insert into P242_TIPIASSOGGETTAMENTIVOCI
  select distinct v.id_tipoassoggettamento, '10017', 'BASE'
  from P240_TIPIASSOGGETTAMENTI t, P242_TIPIASSOGGETTAMENTIVOCI v
  where t.id_tipoassoggettamento=v.id_tipoassoggettamento and t.cod_contratto='EDP'
  and v.cod_voce='10010' and v.cod_voce_speciale in ('BASE','ENTE');

  -- Assoggettamento delle voci 10010-BASE-ENTE alla voce 10017-BASE
  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '10010', 'BASE', '10017', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), 100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));
  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '10010', 'ENTE', '10017', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), 100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));

  -- Inserimento della voce 10017-BASE sui cedolini chiusi del 2014
  INSERT INTO P442_CEDOLINOVOCI
  SELECT ID_CEDOLINO, 'M', 'EDP', '10017', 'BASE', ID_VOCE, '', '',
         SUM(IMPORTO), SUM(IMPORTO),
         'C', '',
         TO_DATE('01'||TO_CHAR(DATA_CEDOLINO,'MMYYYY'),'DDMMYYYY'), LAST_DAY(DATA_CEDOLINO),
         '', '', '', '', '', '', ''
  FROM
  (
  SELECT P441.DATA_CEDOLINO, P442.ID_CEDOLINO, P442.IMPORTO,
         (SELECT P200.ID_VOCE FROM P200_VOCI P200
          WHERE P200.COD_CONTRATTO='EDP' AND P200.COD_VOCE='10017' AND P200.COD_VOCE_SPECIALE='BASE'
          AND TO_DATE('01012014','DDMMYYYY') BETWEEN P200.DECORRENZA AND P200.DECORRENZA_FINE) ID_VOCE
  FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442
  WHERE P441.ID_CEDOLINO=P442.ID_CEDOLINO AND P441.CHIUSO='S'
  AND TO_CHAR(P441.DATA_CEDOLINO,'YYYY')='2014'
  AND P442.COD_CONTRATTO='EDP' AND P442.COD_VOCE='10010' AND P442.COD_VOCE_SPECIALE IN ('BASE','ENTE')
  AND P442.TIPO_RECORD='M'
  )
  GROUP BY DATA_CEDOLINO, ID_CEDOLINO, ID_VOCE;

  -- Inserimento della voce 11017-BASE con importo nullo sui cedolini chiusi del 2014
  INSERT INTO P442_CEDOLINOVOCI
  SELECT ID_CEDOLINO, 'M', 'EDP', '11017', 'BASE', ID_VOCE,
         lpad('0,00',10,' '), lpad(to_char(SUM(IMPORTO),'9G999G990D99'),15,' '),
         0, 0, 'C', '',
         TO_DATE('01'||TO_CHAR(DATA_CEDOLINO,'MMYYYY'),'DDMMYYYY'), LAST_DAY(DATA_CEDOLINO),
         '', '', '', '', '', '', ''
  FROM
  (
  SELECT P441.DATA_CEDOLINO, P442.ID_CEDOLINO, P442.IMPORTO,
         (SELECT P200.ID_VOCE FROM P200_VOCI P200
          WHERE P200.COD_CONTRATTO='EDP' AND P200.COD_VOCE='11017' AND P200.COD_VOCE_SPECIALE='BASE'
          AND TO_DATE('01012014','DDMMYYYY') BETWEEN P200.DECORRENZA AND P200.DECORRENZA_FINE) ID_VOCE
  FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442
  WHERE P441.ID_CEDOLINO=P442.ID_CEDOLINO AND P441.CHIUSO='S'
  AND TO_CHAR(P441.DATA_CEDOLINO,'YYYY')='2014'
  AND P442.COD_CONTRATTO='EDP' AND P442.COD_VOCE='10010' AND P442.COD_VOCE_SPECIALE IN ('BASE','ENTE')
  AND P442.TIPO_RECORD='M'
  )
  GROUP BY DATA_CEDOLINO, ID_CEDOLINO, ID_VOCE;

end if;

end;
/

-------------------------------
-- FINE MENSILIZZAZIONE CPDEL
-------------------------------

-------------------------------
-- INIZIO MENSILIZZAZIONE CPS
-------------------------------

declare
  i integer;
  ID_P200 integer;
  ID_P233 integer;

  CURSOR C1 IS  
  select t.* from P232_SCAGLIONI t
  where t.cod_contratto='EDP' and t.cod_voce='11020' and t.cod_voce_speciale='BASE'
  order by t.decorrenza;
  
begin
  select COUNT(*) into i from P200_VOCI t where t.cod_contratto='EDP'
    and t.cod_voce='11020' and t.cod_voce_speciale='BASE' and upper(t.descrizione) like '%CPS%'
    and not exists
    (select 'x' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce='11027'
     and v.cod_voce_speciale='BASE');

if i > 0 then

  -- Creazione voce 11027-ENTE Ritenuta CPS dipendente-ente 1% agg.
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into P200_VOCI (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_voce, descrizione, cod_voce_stampa, descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo)
  values ('EDP', '11027', 'ENTE', to_date('01-01-1900', 'dd-mm-yyyy'), ID_P200, 'Ritenuta CPS dipendente-ente 1% agg.', '11027 E', 'Ritenuta CPS dipendente-ente 1% agg.', 'S', 'RI', 'N', 'CS', 'S', 'S', 'T', 0, 'E', 'N', null, 'N', 0, 'N', 'P1', 0, 'S', 'S', 'N', 'S', 'N', null, 'N', 'N', 'N', 'S', 'N', 'N', 'N', 'N', 'IB', null, 0, null, 'M', null, null, null, 'N', 'N', 'N', 'N', null, null, 'N', null, to_date('31-12-3999', 'dd-mm-yyyy'), null, null);

  insert into P216_ACCORPAMENTOVOCI
  select cod_contratto, '11027', 'ENTE', cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine from p216_accorpamentovoci t
    where t.cod_contratto='EDP' and t.cod_voce='11020' and t.cod_voce_speciale='ENTE';

  -- Creazione voce 11027-CONG Ritenuta CPS dipendente 1% a cong.
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into P200_VOCI (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_voce, descrizione, cod_voce_stampa, descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo)
  values ('EDP', '11027', 'CONG', to_date('01-01-1900', 'dd-mm-yyyy'), ID_P200, 'Ritenuta CPS dipendente 1% a cong.', '11027 C', 'Ritenuta CPS dipendente 1% a cong.', 'S', 'RI', 'N', 'CS', 'S', 'S', 'T', 0, 'R', 'N', null, 'N', 0, 'N', 'P1', 0, 'S', 'S', 'S', 'S', 'N', null, 'N', 'N', 'N', 'S', 'N', 'N', 'N', 'N', 'IB', null, 0, null, 'M', null, null, null, 'N', 'N', 'N', 'N', null, null, 'N', null, to_date('31-12-3999', 'dd-mm-yyyy'), null, null);

  insert into P216_ACCORPAMENTOVOCI
  select cod_contratto, '11027', 'CONG', cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine from p216_accorpamentovoci t
    where t.cod_contratto='EDP' and t.cod_voce='11020' and t.cod_voce_speciale='BASE';

  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '11027', 'CONG', '10200', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), -100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));
  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '11027', 'CONG', '12960', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), 100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));

  -- Creazione voce 11027-BASE Ritenuta CPS dipendente 1% aggiuntivo
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into P200_VOCI (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_voce, descrizione, cod_voce_stampa, descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo)
  values ('EDP', '11027', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), ID_P200, 'Ritenuta CPS dipendente 1% aggiuntivo', '11027 ', 'Ritenuta CPS dipendente 1% aggiuntivo', 'S', 'RI', 'N', 'CS', 'S', 'S', 'T', 0, 'R', 'N', null, 'S', 0, 'N', 'P1', 0, 'S', 'S', 'D', 'S', 'N', null, 'N', 'N', 'N', 'S', 'N', 'N', 'N', 'N', 'IB', null, 0, null, 'M', null, null, null, 'N', 'N', 'N', 'N', null, 'TLEGG', 'N', null, to_date('31-12-3999', 'dd-mm-yyyy'), null, null);

  insert into P216_ACCORPAMENTOVOCI
  select cod_contratto, '11027', 'BASE', cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine from p216_accorpamentovoci t
    where t.cod_contratto='EDP' and t.cod_voce='11020' and t.cod_voce_speciale='BASE';

  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '11027', 'BASE', '10200', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), -100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));
  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '11027', 'BASE', '12960', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), 100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));

  -- Creazione scaglioni per voce 11027-BASE Ritenuta CPS dipendente 1% aggiuntivo
  FOR T1 IN C1 LOOP

    SELECT P233_ID_SCAGLIONE.NEXTVAL INTO ID_P233 FROM DUAL;

    insert into p232_scaglioni
      (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_scaglione, tipo_importo, tipo_ritenuta, tipo_applicazione, conguaglio_annuale, conguaglio_fine_rapporto, conguaglio_dopo_fine_rapporto, cod_voce_conguaglio, cod_voce_speciale_conguaglio, mensilita_annue, massimale1, massimale2)
    values
      ('EDP', '11027', 'BASE', T1.decorrenza, ID_P233, 'A', 'P', 'M', 'S', 'S', 'S', '11027', 'CONG', 12, 0, 0);

    insert into p233_scaglionifasce
    select ID_P233, importo_da, importo_a, decode(importo_da,0,0,1) perc_imp from p233_scaglionifasce t
    where t.id_scaglione=T1.id_Scaglione;

  END LOOP;

  -- Trasformazione scaglioni per voci 11020-BASE-ENTE con percentuale unica
  update p233_scaglionifasce t 
  set t.importo_a=1000000
  where t.importo_da=0 and t.id_scaglione in
  (select v.id_scaglione from P232_SCAGLIONI v
  where v.cod_contratto='EDP' and v.cod_voce='11020' and v.cod_voce_speciale in ('BASE','ENTE'));

  update p233_scaglionifasce t
  set t.importo_da=1000000.01,
      t.perc_imp=(select t1.perc_imp from p233_scaglionifasce t1 where t1.id_scaglione=t.id_scaglione
                  and t1.importo_da=0)
  where t.importo_a=0 and t.id_scaglione in
  (select v.id_scaglione from P232_SCAGLIONI v
  where v.cod_contratto='EDP' and v.cod_voce='11020' and v.cod_voce_speciale in ('BASE','ENTE'));

  -- Creazione voce 10027-BASE Imponibile CPS dipendente 1% aggiunt.
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into P200_VOCI (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_voce, descrizione, cod_voce_stampa, descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo)
  values ('EDP', '10027', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), ID_P200, 'Imponibile CPS dipendente 1% aggiunt.', '10027 ', 'Imponibile CPS dipendente 1% aggiunt.', 'S', 'IM', 'N', 'CS', 'S', 'S', 'T', 0, 'D', 'N', null, 'N', 0, 'N', 'P1', 0, 'S', 'S', 'N', 'N', 'N', null, 'S', 'S', 'N', 'S', 'N', 'N', 'N', 'N', 'NS', null, 0, null, 'M', null, null, null, 'N', 'N', 'S', 'N', null, 'ILEGG', 'N', null, to_date('31-12-3999', 'dd-mm-yyyy'), null, null);

  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '10027', 'BASE', '11027', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), 100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));

  -- Inserimento su tipi assoggettamento della voce 10027-BASE dove già presente la voce voci 11020-BASE-ENTE
  insert into P242_TIPIASSOGGETTAMENTIVOCI
  select distinct v.id_tipoassoggettamento, '10027', 'BASE'
  from P240_TIPIASSOGGETTAMENTI t, P242_TIPIASSOGGETTAMENTIVOCI v
  where t.id_tipoassoggettamento=v.id_tipoassoggettamento and t.cod_contratto='EDP'
  and v.cod_voce='10020' and v.cod_voce_speciale in ('BASE','ENTE');

  -- Assoggettamento delle voci 10020-BASE-ENTE alla voce 10027-BASE
  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '10020', 'BASE', '10027', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), 100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));
  insert into P201_ASSOGGETTAMENTI (cod_contratto, cod_voce_padre, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine)
  values ('EDP', '10020', 'ENTE', '10027', 'BASE', to_date('01-01-1900', 'dd-mm-yyyy'), 100, 0, to_date('31-12-3999', 'dd-mm-yyyy'));

  -- Inserimento della voce 10027-BASE sui cedolini chiusi del 2014
  INSERT INTO P442_CEDOLINOVOCI
  SELECT ID_CEDOLINO, 'M', 'EDP', '10027', 'BASE', ID_VOCE, '', '',
         SUM(IMPORTO), SUM(IMPORTO),
         'C', '',
         TO_DATE('01'||TO_CHAR(DATA_CEDOLINO,'MMYYYY'),'DDMMYYYY'), LAST_DAY(DATA_CEDOLINO),
         '', '', '', '', '', '', ''
  FROM
  (
  SELECT P441.DATA_CEDOLINO, P442.ID_CEDOLINO, P442.IMPORTO,
         (SELECT P200.ID_VOCE FROM P200_VOCI P200
          WHERE P200.COD_CONTRATTO='EDP' AND P200.COD_VOCE='10027' AND P200.COD_VOCE_SPECIALE='BASE'
          AND TO_DATE('01012014','DDMMYYYY') BETWEEN P200.DECORRENZA AND P200.DECORRENZA_FINE) ID_VOCE
  FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442
  WHERE P441.ID_CEDOLINO=P442.ID_CEDOLINO AND P441.CHIUSO='S'
  AND TO_CHAR(P441.DATA_CEDOLINO,'YYYY')='2014'
  AND P442.COD_CONTRATTO='EDP' AND P442.COD_VOCE='10020' AND P442.COD_VOCE_SPECIALE IN ('BASE','ENTE')
  AND P442.TIPO_RECORD='M'
  )
  GROUP BY DATA_CEDOLINO, ID_CEDOLINO, ID_VOCE;

  -- Inserimento della voce 11027-BASE con importo nullo sui cedolini chiusi del 2014
  INSERT INTO P442_CEDOLINOVOCI
  SELECT ID_CEDOLINO, 'M', 'EDP', '11027', 'BASE', ID_VOCE,
         lpad('0,00',10,' '), lpad(to_char(SUM(IMPORTO),'9G999G990D99'),15,' '),
         0, 0, 'C', '',
         TO_DATE('01'||TO_CHAR(DATA_CEDOLINO,'MMYYYY'),'DDMMYYYY'), LAST_DAY(DATA_CEDOLINO),
         '', '', '', '', '', '', ''
  FROM
  (
  SELECT P441.DATA_CEDOLINO, P442.ID_CEDOLINO, P442.IMPORTO,
         (SELECT P200.ID_VOCE FROM P200_VOCI P200
          WHERE P200.COD_CONTRATTO='EDP' AND P200.COD_VOCE='11027' AND P200.COD_VOCE_SPECIALE='BASE'
          AND TO_DATE('01012014','DDMMYYYY') BETWEEN P200.DECORRENZA AND P200.DECORRENZA_FINE) ID_VOCE
  FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442
  WHERE P441.ID_CEDOLINO=P442.ID_CEDOLINO AND P441.CHIUSO='S'
  AND TO_CHAR(P441.DATA_CEDOLINO,'YYYY')='2014'
  AND P442.COD_CONTRATTO='EDP' AND P442.COD_VOCE='10020' AND P442.COD_VOCE_SPECIALE IN ('BASE','ENTE')
  AND P442.TIPO_RECORD='M'
  )
  GROUP BY DATA_CEDOLINO, ID_CEDOLINO, ID_VOCE;

end if;

end;
/

-------------------------------
-- FINE MENSILIZZAZIONE CPS
-------------------------------

---------------------------
-- INIZIO AGGIORNAMENTO REGOLE UNIEMENS per elementi Contributo e Contrib1PerCento quadro E0
---------------------------
declare
  i integer;
begin
  select COUNT(*) into i from P670_XMLREGOLE t where t.Nome_Flusso='UNIEMENS';
  if i > 0 then
     DELETE P670_XMLREGOLE t WHERE t.NOME_FLUSSO='UNIEMENS' AND t.NUMERO IN ('F315','F320');

insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-01-2014', 'dd-mm-yyyy'), 'F320', 'Contrib1PerCento', 'Contributo 1% a carico iscritto eccedente il tetto retributivo', 'F300', null, 'S', 'P1', null, 'S', 'SELECT DATA_COMPETENZA_DA,DATA_COMPETENZA_A,IMPORTO DATO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP'' AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11017 BASE'',''11017 CONG'',''11017 ENTE'',''11027 BASE'',''11027 CONG'',''11027 ENTE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'ORDER BY DATA_COMPETENZA_DA', 'SELECT DATA_COMPETENZA_DA,DATA_COMPETENZA_A,IMPORTO DATO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP'' AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11017 BASE'',''11017 CONG'',''11017 ENTE'',''11027 BASE'',''11027 CONG'',''11027 ENTE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'ORDER BY DATA_COMPETENZA_DA', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-01-2014', 'dd-mm-yyyy'), 'F315', 'Contributo', 'Totale contributi pensionistici per il periodo', 'F300', null, 'S', 'P1', 'NP', 'S', 'SELECT DATA_COMPETENZA_DA,DATA_COMPETENZA_A,IMPORTO DATO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP'' AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11010 BASE'',''11010 ENTE'',''11015 BASE'',''11020 BASE'',''11020 ENTE'',''11025 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'ORDER BY DATA_COMPETENZA_DA', 'SELECT DATA_COMPETENZA_DA,DATA_COMPETENZA_A,IMPORTO DATO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP'' AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11010 BASE'',''11010 ENTE'',''11015 BASE'',''11020 BASE'',''11020 ENTE'',''11025 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'ORDER BY DATA_COMPETENZA_DA', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F315', 'Contributo', 'Totale contributi pensionistici per il periodo', 'F300', null, 'S', 'P1', 'NP', 'S', 
        'SELECT DATA_COMPETENZA_DA,DATA_COMPETENZA_A,' || chr(10) || 'DECODE(SIGN(ABS(TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') * ' || chr(10) || '(-- Impostazione percentuale primo scaglione CPDEL/CPS ' || chr(10) || 'SELECT P233.PERC_IMP FROM P232_SCAGLIONI P232,P233_SCAGLIONIFASCE P233 ' || chr(10) || '  WHERE P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || '  AND P232.COD_VOCE = P442.COD_VOCE' || chr(10) || '  AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || '  AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO ' || chr(10) || '       AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '       AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '       AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || '  AND P232.ID_SCAGLIONE = P233.ID_SCAGLIONE' || chr(10) || '  AND P233.IMPORTO_DA = 0' || chr(10) || ')' || chr(10) || '/ 100 - IMPORTO) - 0.031),-1,IMPORTO,' || chr(10) || '  TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') * ' || chr(10) || '(-- Impostazione percentuale primo scaglione CPDEL/CPS ' || chr(10) || 'SELECT P233.PERC_IMP FROM P232_SCAGLIONI P232,P233_SCAGLIONIFASCE P233 ' || chr(10) || '  WHERE P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || '  AND P232.COD_VOCE = P442.COD_VOCE' || chr(10) || '  AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || '  AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO ' || chr(10) || '       AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '       AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '       AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || '  AND P232.ID_SCAGLIONE = P233.ID_SCAGLIONE' || chr(10) || '  AND P233.IMPORTO_DA = 0' || chr(10) || ')' || chr(10) || '/ 100) DATO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP'' AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11010 BASE'',''11010 ENTE'',''11020 BASE'',''11020 ENTE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || 'SELECT DATA_COMPETENZA_DA,DATA_COMPETENZA_A,IMPORTO DATO ' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP'' AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11015 BASE'',''11025 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'ORDER BY DATA_COMPETENZA_DA', 
        'SELECT DATA_COMPETENZA_DA,DATA_COMPETENZA_A,' || chr(10) || 'DECODE(SIGN(ABS(TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') * ' || chr(10) || '(-- Impostazione percentuale primo scaglione CPDEL/CPS ' || chr(10) || 'SELECT P233.PERC_IMP FROM P232_SCAGLIONI P232,P233_SCAGLIONIFASCE P233 ' || chr(10) || '  WHERE P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || '  AND P232.COD_VOCE = P442.COD_VOCE' || chr(10) || '  AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || '  AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO ' || chr(10) || '       AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '       AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '       AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || '  AND P232.ID_SCAGLIONE = P233.ID_SCAGLIONE' || chr(10) || '  AND P233.IMPORTO_DA = 0' || chr(10) || ')' || chr(10) || '/ 100 - IMPORTO) - 0.031),-1,IMPORTO,' || chr(10) || '  TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') * ' || chr(10) || '(-- Impostazione percentuale primo scaglione CPDEL/CPS ' || chr(10) || 'SELECT P233.PERC_IMP FROM P232_SCAGLIONI P232,P233_SCAGLIONIFASCE P233 ' || chr(10) || '  WHERE P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || '  AND P232.COD_VOCE = P442.COD_VOCE' || chr(10) || '  AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || '  AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO ' || chr(10) || '       AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '       AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '       AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || '  AND P232.ID_SCAGLIONE = P233.ID_SCAGLIONE' || chr(10) || '  AND P233.IMPORTO_DA = 0' || chr(10) || ')' || chr(10) || '/ 100) DATO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP'' AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11010 BASE'',''11010 ENTE'',''11020 BASE'',''11020 ENTE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || 'SELECT DATA_COMPETENZA_DA,DATA_COMPETENZA_A,IMPORTO DATO ' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP'' AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11015 BASE'',''11025 BASE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'ORDER BY DATA_COMPETENZA_DA', 
        'N', null, null, null, 'N', to_date('31-12-2013', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F320', 'Contrib1PerCento', 'Contributo 1% a carico iscritto eccedente il tetto retributivo', 'F300', null, 'S', 'P1', null, 'S', 
        'SELECT DATA_COMPETENZA_DA,DATA_COMPETENZA_A,' || chr(10) || 'DECODE(SIGN(ABS(TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') * ' || chr(10) || '(-- Impostazione percentuale primo scaglione CPDEL/CPS ' || chr(10) || 'SELECT P233.PERC_IMP FROM P232_SCAGLIONI P232,P233_SCAGLIONIFASCE P233 ' || chr(10) || '  WHERE P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || '  AND P232.COD_VOCE = P442.COD_VOCE' || chr(10) || '  AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || '  AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO ' || chr(10) || '       AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '       AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '       AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || '  AND P232.ID_SCAGLIONE = P233.ID_SCAGLIONE' || chr(10) || '  AND P233.IMPORTO_DA = 0' || chr(10) || ')' || chr(10) || '/ 100 - IMPORTO) - 0.031),-1,0, IMPORTO - TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') * ' || chr(10) || '(-- Impostazione percentuale primo scaglione CPDEL/CPS ' || chr(10) || 'SELECT P233.PERC_IMP FROM P232_SCAGLIONI P232,P233_SCAGLIONIFASCE P233 ' || chr(10) || '  WHERE P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || '  AND P232.COD_VOCE = P442.COD_VOCE' || chr(10) || '  AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || '  AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO' || chr(10) || '       AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '       AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '       AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || '  AND P232.ID_SCAGLIONE = P233.ID_SCAGLIONE' || chr(10) || '  AND P233.IMPORTO_DA = 0' || chr(10) || ')' || chr(10) || '/ 100) DATO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP'' AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11010 BASE'',''11010 ENTE'',''11020 BASE'',''11020 ENTE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'ORDER BY DATA_COMPETENZA_DA', 
        'SELECT DATA_COMPETENZA_DA,DATA_COMPETENZA_A,' || chr(10) || 'DECODE(SIGN(ABS(TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') * ' || chr(10) || '(-- Impostazione percentuale primo scaglione CPDEL/CPS ' || chr(10) || 'SELECT P233.PERC_IMP FROM P232_SCAGLIONI P232,P233_SCAGLIONIFASCE P233 ' || chr(10) || '  WHERE P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || '  AND P232.COD_VOCE = P442.COD_VOCE' || chr(10) || '  AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || '  AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO ' || chr(10) || '       AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '       AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '       AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || '  AND P232.ID_SCAGLIONE = P233.ID_SCAGLIONE' || chr(10) || '  AND P233.IMPORTO_DA = 0' || chr(10) || ')' || chr(10) || '/ 100 - IMPORTO) - 0.031),-1,0, IMPORTO - TO_NUMBER(DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') * ' || chr(10) || '(-- Impostazione percentuale primo scaglione CPDEL/CPS ' || chr(10) || 'SELECT P233.PERC_IMP FROM P232_SCAGLIONI P232,P233_SCAGLIONIFASCE P233 ' || chr(10) || '  WHERE P232.COD_CONTRATTO = P442.COD_CONTRATTO' || chr(10) || '  AND P232.COD_VOCE = P442.COD_VOCE' || chr(10) || '  AND P232.COD_VOCE_SPECIALE = P442.COD_VOCE_SPECIALE' || chr(10) || '  AND P232.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P232_SCAGLIONI' || chr(10) || '     WHERE DECORRENZA <= P441.DATA_CEDOLINO' || chr(10) || '       AND COD_CONTRATTO = P232.COD_CONTRATTO' || chr(10) || '       AND COD_VOCE = P232.COD_VOCE ' || chr(10) || '       AND COD_VOCE_SPECIALE = P232.COD_VOCE_SPECIALE)' || chr(10) || '  AND P232.ID_SCAGLIONE = P233.ID_SCAGLIONE' || chr(10) || '  AND P233.IMPORTO_DA = 0' || chr(10) || ')' || chr(10) || '/ 100) DATO FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 ' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP'' AND P441.PROGRESSIVO = :Progressivo' || chr(10) || 'AND DATA_CEDOLINO = :DataElaborazione ' || chr(10) || 'AND RPAD(COD_VOCE,6,'' '')||COD_VOCE_SPECIALE IN (''11010 BASE'',''11010 ENTE'',''11020 BASE'',''11020 ENTE'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'ORDER BY DATA_COMPETENZA_DA', 
        'N', null, null, null, 'N', to_date('31-12-2013', 'dd-mm-yyyy'));

  end if;
end;
/

UPDATE P670_XMLREGOLE t SET T.REGOLA_CALCOLO_AUTOMATICA=T.REGOLA_CALCOLO_MANUALE;

---------------------------
-- FINE AGGIORNAMENTO REGOLE UNIEMENS per elementi Contributo e Contrib1PerCento quadro E0
---------------------------

-------------------------------
-- INIZIO ADEGUAMEMTO SCAGLIONI PER PREVEDERE DUE VOCI DI CONGUAGLIO PESATE
-------------------------------

comment on column P232_SCAGLIONI.cod_voce_conguaglio
  is 'Codice voce conguaglio principale';
comment on column P232_SCAGLIONI.cod_voce_speciale_conguaglio
  is 'Codice voce speciale conguaglio principale';

alter table P232_SCAGLIONI add cod_voce_peso1 VARCHAR2(5);
alter table P232_SCAGLIONI add cod_voce_speciale_peso1 VARCHAR2(5);
alter table P232_SCAGLIONI add cod_voce_peso2 VARCHAR2(5);
alter table P232_SCAGLIONI add cod_voce_speciale_peso2 VARCHAR2(5);
alter table P232_SCAGLIONI add cod_voce_conguaglio2 VARCHAR2(5);
alter table P232_SCAGLIONI add cod_voce_speciale_conguaglio2 VARCHAR2(5);

comment on column P232_SCAGLIONI.cod_voce_peso1
  is 'Eventuale codice voce per pesatura voce conguaglio principale';
comment on column P232_SCAGLIONI.cod_voce_speciale_peso1
  is 'Eventuale codice voce speciale per pesatura voce conguaglio principale';
comment on column P232_SCAGLIONI.cod_voce_peso2
  is 'Eventuale codice voce per pesatura voce conguaglio secondaria';
comment on column P232_SCAGLIONI.cod_voce_speciale_peso2
  is 'Eventuale codice voce speciale per pesatura voce conguaglio secondaria';
comment on column P232_SCAGLIONI.cod_voce_conguaglio2
  is 'Eventuale codice voce conguaglio secondaria';
comment on column P232_SCAGLIONI.cod_voce_speciale_conguaglio2
  is 'Eventuale codice voce speciale conguaglio secondaria';

UPDATE P232_SCAGLIONI t 
SET T.COD_VOCE_PESO1='11010', T.COD_VOCE_SPECIALE_PESO1='BASE',
    T.COD_VOCE_PESO2='11010', T.COD_VOCE_SPECIALE_PESO2='ENTE',
    T.COD_VOCE_CONGUAGLIO2='11017', T.COD_VOCE_SPECIALE_CONGUAGLIO2='ENTE'
where t.cod_contratto='EDP' and t.cod_voce='11017'
and t.cod_voce_speciale='BASE';

UPDATE P232_SCAGLIONI t 
SET T.COD_VOCE_PESO1='11020', T.COD_VOCE_SPECIALE_PESO1='BASE',
    T.COD_VOCE_PESO2='11020', T.COD_VOCE_SPECIALE_PESO2='ENTE',
    T.COD_VOCE_CONGUAGLIO2='11027', T.COD_VOCE_SPECIALE_CONGUAGLIO2='ENTE'
where t.cod_contratto='EDP' and t.cod_voce='11027'
and t.cod_voce_speciale='BASE';

-------------------------------
-- FINE ADEGUAMEMTO SCAGLIONI PER PREVEDERE DUE VOCI DI CONGUAGLIO PESATE
-------------------------------

---------------------------
-- INIZIO AGGIORNAMENTO REGOLA CUD 2013 PARTE B NUMERO 106
---------------------------
declare
  i integer;
begin
  select COUNT(*) into i from P502_CUDREGOLE t where t.anno=2013 and t.parte='B' and t.numero='106';
  if i > 0 then
     DELETE P502_CUDREGOLE t where t.anno=2013 and t.parte='B' and t.numero='106';

insert into P502_CUDREGOLE (anno, parte, numero, descrizione, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento)
values (2013, 'B', '106', 'Credito per famiglie numerose recuperato', 'S', 'P1', 'M=S,D=2,0=N', 'S', 'SELECT GREATEST(CRED_FAM_NUM_BASE - CRED_FAM_NUM_CONG, 0) DATO FROM' || chr(10) || '(SELECT NVL(SUM(IMPORTO),0) CRED_FAM_NUM_CONG FROM P442_CEDOLINOVOCI WHERE ID_CEDOLINO = :IdCedCongIRPEF AND' || chr(10) || 'TO_CHAR(DATA_COMPETENZA_A,''YYYY'') = :Anno AND' || chr(10) || 'COD_VOCE = ''13154'' AND COD_VOCE_SPECIALE = ''CONG'' AND TIPO_RECORD = ''M''),' || chr(10) || '(SELECT NVL(SUM(IMPORTO),0) CRED_FAM_NUM_BASE FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 WHERE ' || chr(10) || 'P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO = ''S'' AND P441.ID_CEDOLINO <> :IdCedCongIRPEF' || chr(10) || 'AND P441.PROGRESSIVO = :Progressivo AND TO_CHAR(DATA_CEDOLINO,''YYYY'') = :Anno ' || chr(10) || 'AND COD_VOCE = ''13151'' AND COD_VOCE_SPECIALE = ''BASE'' AND TIPO_RECORD = ''M'')', 'SELECT GREATEST(CRED_FAM_NUM_BASE - CRED_FAM_NUM_CONG, 0) DATO FROM' || chr(10) || '(SELECT NVL(SUM(IMPORTO),0) CRED_FAM_NUM_CONG FROM P442_CEDOLINOVOCI WHERE ID_CEDOLINO = :IdCedCongIRPEF AND' || chr(10) || 'TO_CHAR(DATA_COMPETENZA_A,''YYYY'') = :Anno AND' || chr(10) || 'COD_VOCE = ''13154'' AND COD_VOCE_SPECIALE = ''CONG'' AND TIPO_RECORD = ''M''),' || chr(10) || '(SELECT NVL(SUM(IMPORTO),0) CRED_FAM_NUM_BASE FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 WHERE ' || chr(10) || 'P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO = ''S'' AND P441.ID_CEDOLINO <> :IdCedCongIRPEF' || chr(10) || 'AND P441.PROGRESSIVO = :Progressivo AND TO_CHAR(DATA_CEDOLINO,''YYYY'') = :Anno ' || chr(10) || 'AND COD_VOCE = ''13151'' AND COD_VOCE_SPECIALE = ''BASE'' AND TIPO_RECORD = ''M'')', 'N', null);

  end if;
end;
/

UPDATE P502_CUDREGOLE t SET T.REGOLA_CALCOLO_AUTOMATICA=T.REGOLA_CALCOLO_MANUALE;

---------------------------
-- FINE AGGIORNAMENTO REGOLA CUD 2013 PARTE B NUMERO 106
---------------------------

comment on column P010_BANCHE.cin_europa
  is 'Codice di controllo del codice IBAN per i pagamenti esteri - non gestito';
comment on column P010_BANCHE.cin_italia
  is 'Codice di controllo del codice BBAN per i pagamenti nazionali - non gestito';
