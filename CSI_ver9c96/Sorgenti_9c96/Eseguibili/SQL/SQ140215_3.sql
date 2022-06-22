-- CREAZIONE SINDACATI VARI
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='12163';
CodVoceCopia:='12473';
DesVoceCopia:='U.I.L. TEMP a importo fisso';
DesVoceCopiaSt:='U.I.L. TEMP a importo fisso';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio U.I.L. TEMP a importo fisso
-----
  
SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, 0, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine U.I.L. TEMP a importo fisso
-----

  end if;

CodVoceModello:='12371';
CodVoceCopia:='12373';
DesVoceCopia:='FAPI Sanità a importo fisso';
DesVoceCopiaSt:='FAPI Sanita'' a importo fisso';

  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio FAPI Sanità a importo fisso
-----
  
SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, 100, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

DesVoceCopia:='FAPI Sanità a importo fisso 13a';
DesVoceCopiaSt:='FAPI Sanita'' a importo fisso 13a';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' T', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='TRED';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='TRED';

-----
-- Fine FAPI Sanità a importo fisso
-----

  end if;

end if;
end;
/

UPDATE T480_COMUNI t SET T.CITTA='SANTO STEFANO IN ASPROMONTE'
WHERE T.CODCATASTALE='I371';
