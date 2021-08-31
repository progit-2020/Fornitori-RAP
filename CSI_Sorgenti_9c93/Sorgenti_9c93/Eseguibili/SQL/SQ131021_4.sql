UPDATE P200_VOCI t set t.eccezioni_sensibili='a'
where t.cod_contratto='EDP' and t.cod_voce='02100'and t.cod_voce_speciale='BASE' and t.eccezioni_sensibili is null
and upper(t.descrizione) like '%ALIMENTARE%';

---------------------------
-- Inizio creazione voci Assegno alimentare assogg. e Sospensione con assegno alimentare
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

-- Creazione voce EDP-02105-BASE (Assegno alimentare assogg.)

  select COUNT(*) into i from P200_VOCI t where t.cod_contratto='EDP'
    and t.cod_voce='02100' and t.cod_voce_speciale='BASE' and upper(t.descrizione)like '%ALIMENTARE%'
    and not exists
    (select 'x' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce='02105'
     and v.cod_voce_speciale=t.cod_voce_speciale);

if i > 0 then

      CodVoceModello:='02100';
      CodVoceCopia:='02105';
      DesVoceCopia:='Assegno alimentare assogg.';
      DesVoceCopiaSt:='Assegno alimentare assogg.';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', '' from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDP' and t.cod_voce_padre='00010' and t.cod_voce_speciale_padre='BASE'
      and t.cod_voce_figlio not between '12000' and '12900';

      INSERT INTO P216_ACCORPAMENTOVOCI
      select cod_contratto, CodVoceCopia, 'BASE', cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine from p216_accorpamentovoci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

end if;

-- Creazione voce EDP-15082-BASE (Sospensione con assegno alimentare)

  select COUNT(*) into i from P200_VOCI t where t.cod_contratto='EDP'
    and t.cod_voce='15080' and t.cod_voce_speciale='BASE' and upper(t.descrizione)like '%SOSPENSIONE%'
    and not exists
    (select 'x' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce='15082'
     and v.cod_voce_speciale=t.cod_voce_speciale);

if i > 0 then

      CodVoceModello:='15080';
      CodVoceCopia:='15082';
      DesVoceCopia:='Sospensione con assegno alimentare';
      DesVoceCopiaSt:='Sospensione con assegno alimentare';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', '' from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

      INSERT INTO P205_QUOTE
      select cod_contratto, CodVoceCopia, cod_voce_speciale_da_quotare, cod_voce_in_quota, cod_voce_speciale_in_quota, decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio, cod_voce_speciale_dettaglio13a from p205_quote t
      where t.cod_contratto='EDP' and t.cod_voce_da_quotare=CodVoceModello and t.cod_voce_speciale_da_quotare='BASE';

end if;

end;
/

---------------------------
-- Fine creazione voci Assegno alimentare assogg. e Sospensione con assegno alimentare
---------------------------

---------------------------
-- Inizio creazione voci per Sciopero assoggettato
---------------------------

declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);
  CodVoceFiglio varchar2(5);

  CURSOR C1 IS
    select distinct cod_contratto, cod_voce_in_quota, cod_voce_speciale_in_quota from
    (
    (select * from P205_QUOTE t where t.cod_contratto='EDP' and t.cod_voce_da_quotare='15100' and t.cod_voce_speciale_da_quotare='BASE'
    and exists
        (select 'x' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=t.cod_voce_da_quotare
         and v.cod_voce_speciale=t.cod_voce_speciale_da_quotare and upper(v.descrizione)like '%SCIOPERO%'))
    union all
    (select * from P205_QUOTE t where t.cod_contratto='EDP' and t.cod_voce_da_quotare='15102' and t.cod_voce_speciale_da_quotare='BASE'
    and exists
        (select 'x' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=t.cod_voce_da_quotare
         and v.cod_voce_speciale=t.cod_voce_speciale_da_quotare and upper(v.descrizione)like '%SCIOPERO%'))
    )
    where cod_voce_speciale_in_quota='BASE'
    and not exists
        (select 'x' from P200_VOCI v where v.cod_contratto=cod_contratto and v.cod_voce=cod_voce_in_quota
         and v.cod_voce_speciale='15105')
    order by cod_voce_in_quota;

begin

-- Creazione voce EDP-15105-BASE (Sciopero a giorni assogg.)

  select COUNT(*) into i from P200_VOCI t where t.cod_contratto='EDP'
    and t.cod_voce='15100' and t.cod_voce_speciale='BASE' and upper(t.descrizione)like '%SCIOPERO%'
    and not exists
    (select 'x' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce='15105'
     and v.cod_voce_speciale=t.cod_voce_speciale);

if i > 0 then

      CodVoceModello:='15100';
      CodVoceCopia:='15105';
      DesVoceCopia:='Sciopero a giorni assogg.';
      DesVoceCopiaSt:='Sciopero a giorni assogg.';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', '' from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

      insert into p205_quote
      select cod_contratto, CodVoceCopia, cod_voce_speciale_da_quotare, cod_voce_in_quota, cod_voce_speciale_in_quota, decorrenza, -accumulo, -accumulo_rateo, '15105', cod_voce_speciale_dettaglio13a from p205_quote t
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE=CodVoceModello AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE';

end if;

-- Creazione voce EDP-15107-BASE (Sciopero a ore assogg.)

  select COUNT(*) into i from P200_VOCI t where t.cod_contratto='EDP'
    and t.cod_voce='15102' and t.cod_voce_speciale='BASE' and upper(t.descrizione)like '%SCIOPERO%'
    and not exists
    (select 'x' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce='15107'
     and v.cod_voce_speciale=t.cod_voce_speciale);

if i > 0 then

      CodVoceModello:='15102';
      CodVoceCopia:='15107';
      DesVoceCopia:='Sciopero a ore assogg.';
      DesVoceCopiaSt:='Sciopero a ore assogg.';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', '' from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

      insert into p205_quote
      select cod_contratto, CodVoceCopia, cod_voce_speciale_da_quotare, cod_voce_in_quota, cod_voce_speciale_in_quota, decorrenza, -accumulo, -accumulo_rateo, '15105', cod_voce_speciale_dettaglio13a from p205_quote t
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE=CodVoceModello AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE';

end if;

-- Creazione voci EDP-XXXXX-15105 (Riduzione per sciopero)

      CodVoceCopia:='15105';
      DesVoceCopia:='Riduzione per sciopero';
      DesVoceCopiaSt:='Riduzione per sciopero';

for t1 in c1 loop

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, cod_voce, CodVoceCopia, to_date('01011900','ddmmyyyy'), ID_P200, DesVoceCopia, cod_voce || ' A', DesVoceCopiaSt, protetta, 'RA', 'N', cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, 'N', '', ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, 0, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', 'P', cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, 'N', ritenuta_anagrafica, decorrenza_fine, '', '' from p200_voci T
      WHERE T.COD_CONTRATTO=T1.cod_contratto AND T.COD_VOCE=T1.cod_voce_in_quota AND T.COD_VOCE_SPECIALE='BASE'
            and t.decorrenza_fine=to_date('31123999','ddmmyyyy');

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, cod_voce_padre, CodVoceCopia, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento, decorrenza_fine from p201_assoggettamenti t
      where T.COD_CONTRATTO=T1.cod_contratto and t.cod_voce_padre=T1.cod_voce_in_quota and t.cod_voce_speciale_padre='BASE'
      and t.cod_voce_figlio not between '12000' and '12900';

end loop;

end;
/

---------------------------
-- Fine creazione voci per Sciopero assoggettato
---------------------------

---------------------------
-- Inizio creazione voce assenza Dottorato di ricerca retribuito
---------------------------

declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin

CodVoceModello:='15132';
CodVoceCopia:='15162';
DesVoceCopia:='Dottorato di ricerca retribuito';
DesVoceCopiaSt:='Dottorato di ricerca retribuito';

select COUNT(*) into i from P200_VOCI t where T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND NOT EXISTS
  (select 'x' from P200_VOCI V WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE=CodVoceCopia);
if i > 0 then

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P206_ASSENZEINPDAP
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, elimina_sezione, abbatte_ggutili, cod_tiposervizio, cod_gestassic_noncoperte, cod_causasospensione, perc_asp_sindacale, perc_retribuzione, note, decorrenza_fine
from p206_assenzeinpdap T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

update p206_assenzeinpdap t set t.cod_tiposervizio='56'
where t.cod_contratto='EDP' and t.cod_voce=CodVoceCopia and t.cod_voce_speciale='BASE' and t.cod_tiposervizio='47';

end if;

end;

/

---------------------------
-- Fine creazione voce Dottorato di ricerca retribuito
---------------------------
