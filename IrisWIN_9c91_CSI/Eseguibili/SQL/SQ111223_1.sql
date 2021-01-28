UPDATE P220_LIVELLI P220 SET P220.DESCRIZIONE='Specialisti ambulatoriali titolari A.C.N. e A.C.R.'
WHERE P220.COD_CONTRATTO='EDPSC' AND P220.COD_POSIZIONE_ECONOMICA='MA130';

UPDATE P220_LIVELLI P220 SET P220.DESCRIZIONE='Specialisti ambulatoriali non titolari A.C.N. e A.C.R.'
WHERE P220.COD_CONTRATTO='EDPSC' AND P220.COD_POSIZIONE_ECONOMICA='MA132';

UPDATE P220_LIVELLI P220 SET P220.DESCRIZIONE='Professionisti ambulatoriali titolari A.C.N. e A.C.R.'
WHERE P220.COD_CONTRATTO='EDPSC' AND P220.COD_POSIZIONE_ECONOMICA='MA135';

UPDATE P220_LIVELLI P220 SET P220.DESCRIZIONE='Professionisti ambulatoriali non titolari A.C.N. e A.C.R.'
WHERE P220.COD_CONTRATTO='EDPSC' AND P220.COD_POSIZIONE_ECONOMICA='MA137';

UPDATE P220_LIVELLI P220 SET P220.DESCRIZIONE='Medicina dei servizi territoriali A.C.N. e A.C.R.'
WHERE P220.COD_CONTRATTO='EDPSC' AND P220.COD_POSIZIONE_ECONOMICA='MS130';

-- CREAZIONE VOCI CNU
declare 
  i integer;
  ID_P200 integer;
  CodContratto varchar2(5);
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
-----
-- Inizio Aumento orario acc.reg. ambul. titolari 
-----
  
CodContratto:='EDPSC';
CodVoceModello:='01001';
CodVoceCopia:='01003';
DesVoceCopia:='Aumento orario acc.reg. ambul. titolari';
DesVoceCopiaSt:='Aumento orario acc.reg. ambul. titolari';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO=CodContratto and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
    WHERE T.COD_CONTRATTO=CodContratto AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto=CodContratto and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

    DesVoceCopia:='Aumento orario acc.reg. ambul. tit. 13a';
    DesVoceCopiaSt:='Aumento orario acc.reg. ambul. tit. 13a';

    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
    WHERE T.COD_CONTRATTO=CodContratto AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='TRED';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto=CodContratto and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='TRED';

-----
-- Fine Aumento orario acc.reg. ambul. titolari
-----

  end if;
end if;

-----
-- Inizio Aumento orario acc.reg. amb.non titolari 
-----
  
CodContratto:='EDPSC';
CodVoceModello:='01007';
CodVoceCopia:='01019';
DesVoceCopia:='Aumento orario acc.reg. amb.non titolari';
DesVoceCopiaSt:='Aumento orario acc.reg. amb.non titolari';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO=CodContratto and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
    WHERE T.COD_CONTRATTO=CodContratto AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto=CodContratto and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine Aumento orario acc.reg. amb.non titolari
-----

  end if;
end if;

-----
-- Inizio Indennità rischio radiologico ambul. 
-----
  
CodContratto:='EDPSC';
CodVoceModello:='01016';
CodVoceCopia:='01036';
DesVoceCopia:='Indennità rischio radiologico ambul.';
DesVoceCopiaSt:='Indennita'' rischio radiologico ambul.';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO=CodContratto and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
    WHERE T.COD_CONTRATTO=CodContratto AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto=CodContratto and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine Indennità rischio radiologico ambul.
-----

  end if;
end if;

-----
-- Inizio Indennità automezzo guardia medica 
-----
  
CodContratto:='EDPSC';
CodVoceModello:='02023';
CodVoceCopia:='02024';
DesVoceCopia:='Indennità automezzo guardia medica';
DesVoceCopiaSt:='Indennita'' automezzo guardia medica';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO=CodContratto and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
    WHERE T.COD_CONTRATTO=CodContratto AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto=CodContratto and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine Indennità automezzo guardia medica 
-----

  end if;
end if;

-----
-- Inizio Aumento orario acc.reg. medicina servizi 
-----
  
CodContratto:='EDPSC';
CodVoceModello:='03001';
CodVoceCopia:='03010';
DesVoceCopia:='Aumento orario acc.reg. medicina servizi';
DesVoceCopiaSt:='Aumento orario acc.reg. medicina servizi';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO=CodContratto and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
    WHERE T.COD_CONTRATTO=CodContratto AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto=CodContratto and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

    DesVoceCopia:='Aumento orario acc.reg. med. servizi 13a';
    DesVoceCopiaSt:='Aumento orario acc.reg. med. servizi 13a';

    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
    WHERE T.COD_CONTRATTO=CodContratto AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='TRED';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto=CodContratto and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='TRED';

-----
-- Fine Aumento orario acc.reg. medicina servizi
-----

  end if;
end if;

-----
-- Inizio S.I.M.E.T. 
-----
  
CodContratto:='EDPSC';
CodVoceModello:='12771';
CodVoceCopia:='12766';
DesVoceCopia:='S.I.M.E.T.';
DesVoceCopiaSt:='S.I.M.E.T.';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO=CodContratto and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
    WHERE T.COD_CONTRATTO=CodContratto AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto=CodContratto and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine S.I.M.E.T.
-----

  end if;
end if;

-----
-- Inizio C.I.M.O. ASMD
-----
  
CodContratto:='EDPSC';
CodVoceModello:='12771';
CodVoceCopia:='12761';
DesVoceCopia:='C.I.M.O. ASMD';
DesVoceCopiaSt:='C.I.M.O. ASMD';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO=CodContratto and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
    WHERE T.COD_CONTRATTO=CodContratto AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto=CodContratto and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine C.I.M.O. ASMD
-----

  end if;
end if;

end;

/

-----
-- Inizio creazione posizioni economiche EDPSC - MA133 e EDPSC - MA138
-----

declare 
  i integer;
  ID_P221 integer;
  
  CURSOR C1(PosEcon varchar2) IS  
  SELECT P220.*
  FROM P220_LIVELLI P220 
  WHERE P220.COD_CONTRATTO='EDPSC' AND P220.COD_POSIZIONE_ECONOMICA=PosEcon
  ORDER BY P220.DECORRENZA;

begin

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P220_LIVELLI t 
    where T.COD_CONTRATTO='EDPSC' and T.COD_POSIZIONE_ECONOMICA='MA130'
    and not exists
    (select 'X' from P220_LIVELLI v where v.cod_contratto=t.cod_contratto
       and v.cod_posizione_economica='MA133');
  if i > 0 then

    FOR T1 IN C1('MA130') LOOP
  
      SELECT P221_ID_LIVELLO.NEXTVAL INTO ID_P221 FROM DUAL;

      insert into p220_livelli
        (cod_contratto, cod_posizione_economica, decorrenza, id_livello, categoria_economica, cod_livello, descrizione, decorrenza_fine, cod_posizione_economica_succ)
      values
        (T1.COD_CONTRATTO, 'MA133', T1.DECORRENZA, ID_P221, T1.CATEGORIA_ECONOMICA, T1.COD_LIVELLO, 'Specialisti ambulatoriali sostituti/provvisori A.C.N. e A.C.R.', T1.DECORRENZA_FINE, T1.COD_POSIZIONE_ECONOMICA_SUCC);

      INSERT INTO P221_LIVELLIIMPORTI
      select ID_P221, '01007', cod_voce_speciale, importo, erogazione_mesi from p221_livelliimporti P221
        WHERE P221.ID_LIVELLO=T1.ID_LIVELLO AND P221.COD_VOCE='01001' AND P221.COD_VOCE_SPECIALE='BASE';

    END LOOP;

  end if;

  select COUNT(*) into i from P220_LIVELLI t 
    where T.COD_CONTRATTO='EDPSC' and T.COD_POSIZIONE_ECONOMICA='MA135'
    and not exists
    (select 'X' from P220_LIVELLI v where v.cod_contratto=t.cod_contratto
       and v.cod_posizione_economica='MA138');
  if i > 0 then

    FOR T1 IN C1('MA135') LOOP
  
      SELECT P221_ID_LIVELLO.NEXTVAL INTO ID_P221 FROM DUAL;

      insert into p220_livelli
        (cod_contratto, cod_posizione_economica, decorrenza, id_livello, categoria_economica, cod_livello, descrizione, decorrenza_fine, cod_posizione_economica_succ)
      values
        (T1.COD_CONTRATTO, 'MA138', T1.DECORRENZA, ID_P221, T1.CATEGORIA_ECONOMICA, T1.COD_LIVELLO, 'Professionisti ambulatoriali sostituti/provvisori A.C.N. e A.C.R.', T1.DECORRENZA_FINE, T1.COD_POSIZIONE_ECONOMICA_SUCC);

      INSERT INTO P221_LIVELLIIMPORTI
      select ID_P221, '01007', cod_voce_speciale, importo, erogazione_mesi from p221_livelliimporti P221
        WHERE P221.ID_LIVELLO=T1.ID_LIVELLO AND P221.COD_VOCE='01001' AND P221.COD_VOCE_SPECIALE='BASE';

    END LOOP;

  end if;

end if;

end;

-----
-- Fine creazione posizioni economiche EDPSC - MA133 e EDPSC - MA138
-----

/

UPDATE p200_voci t SET T.PROGRAMMATA='S'
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE='02024' AND T.COD_VOCE_SPECIALE='BASE';


declare 
  CURSOR C1 IS  
  SELECT '01110' VOCE FROM DUAL UNION ALL
  SELECT '01130' VOCE FROM DUAL UNION ALL
  SELECT '01131' VOCE FROM DUAL UNION ALL
  SELECT '01132' VOCE FROM DUAL UNION ALL
  SELECT '01150' VOCE FROM DUAL UNION ALL
  SELECT '01151' VOCE FROM DUAL;

begin

    FOR T1 IN C1 LOOP

      insert into p201_assoggettamenti
        select 'EDPSC', T1.VOCE, 'BASE', '10500', 'BASE', to_date('01011900','ddmmyyyy'),
               100, 0, to_date('31123999','ddmmyyyy') from dual
      where exists
        (select 'x' from p201_assoggettamenti t
         where t.cod_contratto='EDPSC' and t.cod_voce_padre=T1.VOCE and t.cod_voce_speciale_padre='BASE'
         and t.cod_voce_figlio='10200' and t.cod_voce_speciale_figlio='BASE')
      and not exists
        (select 'x' from p201_assoggettamenti t
         where t.cod_contratto='EDPSC' and t.cod_voce_padre=T1.VOCE and t.cod_voce_speciale_padre='BASE'
         and t.cod_voce_figlio='10500' and t.cod_voce_speciale_figlio='BASE');

    END LOOP;

end;

/

update MONDOEDP.I091_DATIENTE set DATO = DATO||'+NC' where TIPO = 'C26_HINTT030V430' and lower(replace(DATO,' ','')) = '/*+ordered*/';

insert into mondoedp.i075_iter_autorizzativi 
  (AZIENDA,PROFILO,ITER,COD_ITER,LIVELLO,ACCESSO)
values 
  (:AZIENDA,'CART_DIPENDENTE','T860','DEFAULT',1,'F');

DECLARE
  I Integer;
BEGIN
  SELECT COUNT(*) INTO I FROM T002_QUERYPERSONALIZZATE
   WHERE NOME = 'PA_Arrotondamenti_Sospesi';
  IF I > 0 THEN
    delete T002_QUERYPERSONALIZZATE where NOME = 'PA_Arrotondamenti_Sospesi';
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',-4,'CHKINTESTAZIONE(N)CHKNORITORNOACAPO(N)','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',0,'SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME, T430.FINE,','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',1,'      P441.DATA_CEDOLINO, P442.COD_VOCE, ''Arrotondamento'' DESCRIZIONE, P442.IMPORTO ','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',2,'FROM  T030_ANAGRAFICO T030, T430_STORICO T430, P441_CEDOLINO P441, P442_CEDOLINOVOCI P442','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',3,'WHERE T030.PROGRESSIVO = T430.PROGRESSIVO','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',4,'  AND T030.PROGRESSIVO = P441.PROGRESSIVO','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',5,'  AND P441.ID_CEDOLINO = P442.ID_CEDOLINO','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',6,'  AND P441.DATA_CEDOLINO = (SELECT MAX(DATA_CEDOLINO) FROM P441_CEDOLINO','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',7,'                             WHERE PROGRESSIVO = P441.PROGRESSIVO','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',8,'                               AND CHIUSO = ''S'')','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',9,'  AND SYSDATE BETWEEN T430.DATADECORRENZA AND T430.DATAFINE','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',10,'  AND P441.CHIUSO = ''S''','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',11,'  AND P442.TIPO_RECORD = ''M''','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',12,'  AND P442.COD_CONTRATTO = ''EDP''','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',13,'  AND P442.COD_VOCE = ''04990''','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',14,'  AND P442.COD_VOCE_SPECIALE = ''BASE''','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',15,'  AND P442.IMPORTO > 1','PAGHE');
    insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',16,'ORDER BY IMPORTO DESC, COGNOME, NOME','PAGHE');  
  END IF;
END;
/


alter table T275_CAUPRESENZE add SEMPRE_APPOGGIATA varchar2(1) default 'N';
comment on column T275_CAUPRESENZE.SEMPRE_APPOGGIATA is 'S=Nel caso di coppia ti timbratura causalizzata, viene mantenuto l''appoggio della timbratura anche per gli orari a turni, N=L''appoggio della timbratura dipende dal tipo orario e dall''uso della causale';
comment on column T275_CAUPRESENZE.RIPLIQ is 'obsoleto';
