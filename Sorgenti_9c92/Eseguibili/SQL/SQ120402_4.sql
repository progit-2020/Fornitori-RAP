declare
  ID_P242 integer;
  i integer;
begin
  select COUNT(*) into i from P240_TIPIASSOGGETTAMENTI t where t.cod_contratto='EDP'
         and t.cod_tipoassoggettamento='INPFS';
  if i > 0 then
    select COUNT(*) into i from P240_TIPIASSOGGETTAMENTI t where t.cod_contratto='EDP'
           and t.cod_tipoassoggettamento='INPFSCP';
    if i = 0 then

      SELECT P242_ID_TIPOASSOGGETTAMENTO.NEXTVAL INTO ID_P242 FROM DUAL;

      INSERT INTO P240_TIPIASSOGGETTAMENTI
        (COD_TIPOASSOGGETTAMENTO, COD_CONTRATTO, DECORRENZA, ID_TIPOASSOGGETTAMENTO,
         DESCRIZIONE, DECORRENZA_FINE, TFR)
      VALUES
        ('INPFSCP', 'EDP', TO_DATE('01011900','DDMMYYYY'), ID_P242,
         'INPS iscritti + INADELP TFS + Fondo credito CPDEL + IRAP', TO_DATE('31123999','DDMMYYYY'), 'N');

      INSERT INTO P242_TIPIASSOGGETTAMENTIVOCI
      SELECT ID_P242, COD_VOCE, COD_VOCE_SPECIALE FROM P242_TIPIASSOGGETTAMENTIVOCI P242
      WHERE P242.ID_TIPOASSOGGETTAMENTO =
        (SELECT P240.ID_TIPOASSOGGETTAMENTO FROM P240_TIPIASSOGGETTAMENTI P240
         WHERE P240.COD_TIPOASSOGGETTAMENTO='INPFS');

      INSERT INTO P242_TIPIASSOGGETTAMENTIVOCI
        (ID_TIPOASSOGGETTAMENTO, COD_VOCE, COD_VOCE_SPECIALE)
      VALUES
        (ID_P242, '10140', 'BASE');
      INSERT INTO P242_TIPIASSOGGETTAMENTIVOCI
        (ID_TIPOASSOGGETTAMENTO, COD_VOCE, COD_VOCE_SPECIALE)
      VALUES
        (ID_P242, '10140', 'ENTE');

    end if;
  end if;
end;
/

-- CREAZIONE VOCE EDPSC - 01146 (Prest. esterne prof. tit. 35% imp. fisso)
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='01145';
CodVoceCopia:='01146';
DesVoceCopia:='Prest. esterne prof. tit. 35% imp. fisso';
DesVoceCopiaSt:='Prest. esterne prof. tit. 35% imp. fisso';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDPSC' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
          and T.DESCRIZIONE like '%25%'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio Prest. esterne prof. tit. 35% imp. fisso
-----
  
SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine Prest. esterne prof. tit. 35% imp. fisso
-----

  end if;

end if;
end;
/

---------------------------
-- INIZIO Riduzioni per assenza voce 00380 (Indennità ufficiale di polizia giudiz.)
---------------------------

declare 
  CURSOR C1 IS  
  SELECT P200.COD_CONTRATTO,P200.COD_VOCE,P200.COD_VOCE_SPECIALE,P200.ID_VOCE FROM P200_VOCI P200
         WHERE P200.COD_CONTRATTO='EDP' AND P200.COD_VOCE='00375'
         AND P200.COD_VOCE_SPECIALE NOT IN('BASE','15028')
         ORDER BY P200.COD_VOCE,P200.COD_VOCE_SPECIALE;  

  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);

begin
select COUNT(*) into i from P200_VOCI t where T.COD_CONTRATTO='EDP' AND T.COD_VOCE='00380' AND NOT EXISTS
  (select 'x' from P200_VOCI V WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE='00380' AND V.COD_VOCE_SPECIALE='15010');
if i > 0 then

CodVoceModello:='00375';
CodVoceCopia:='00380';

  FOR T1 IN C1 LOOP
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
   
    INSERT INTO P200_VOCI
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, descrizione, CodVoceCopia || ' A', descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario
    from p200_voci P200 WHERE P200.ID_VOCE=T1.ID_VOCE;

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, 
    decode(cod_voce_figlio,'14110','14100',cod_voce_figlio),
    cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
    FROM P201_ASSOGGETTAMENTI P201 WHERE P201.COD_CONTRATTO=T1.COD_CONTRATTO 
    AND P201.COD_VOCE_PADRE=T1.COD_VOCE AND P201.COD_VOCE_SPECIALE_PADRE=T1.COD_VOCE_SPECIALE;

    INSERT INTO P205_QUOTE
    select cod_contratto, cod_voce_da_quotare, cod_voce_speciale_da_quotare, CodVoceCopia, cod_voce_speciale_in_quota, decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio
    from p205_quote T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE=T1.COD_VOCE_SPECIALE AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE'
      AND T.COD_VOCE_IN_QUOTA=CodVoceModello AND T.COD_VOCE_SPECIALE_IN_QUOTA='BASE';

  END LOOP;

end if;
end;

---------------------------
-- FINE Riduzioni per assenza voce 00380 (Indennità ufficiale di polizia giudiz.)
---------------------------
/

---------------------------
-- INIZIO Assegno personale (12 mensilità)
---------------------------

declare 
  CURSOR C1 IS  
  SELECT P200.COD_CONTRATTO,P200.COD_VOCE,P200.COD_VOCE_SPECIALE,P200.ID_VOCE FROM P200_VOCI P200
         WHERE P200.COD_CONTRATTO='EDP' AND P200.COD_VOCE='00016'
         AND P200.COD_VOCE_SPECIALE NOT IN('BASE','TRED')
         ORDER BY P200.COD_VOCE,P200.DECORRENZA;  

  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
select COUNT(*) into i from P200_VOCI t where T.COD_CONTRATTO='EDP' AND T.COD_VOCE='00016' AND NOT EXISTS
  (select 'x' from P200_VOCI V WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE='00050');
if i > 0 then

CodVoceModello:='00016';
CodVoceCopia:='00050';
DesVoceCopia:='Assegno personale (12 mensilità)';
DesVoceCopiaSt:='Assegno personale (12 mensilita'')';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, 0, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

INSERT INTO P205_QUOTE
select cod_contratto, cod_voce_da_quotare, cod_voce_speciale_da_quotare, CodVoceCopia, cod_voce_speciale_in_quota, decorrenza, accumulo, 0, cod_voce_speciale_dettaglio
from p205_quote T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_IN_QUOTA='00016';

INSERT INTO P216_ACCORPAMENTOVOCI
select cod_contratto, CodVoceCopia, cod_voce_speciale, cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine from p216_accorpamentovoci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE= CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

  FOR T1 IN C1 LOOP
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
   
    INSERT INTO P200_VOCI
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, descrizione, CodVoceCopia || ' A', descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario
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
-- FINE Assegno personale (12 mensilità)
---------------------------
/


-- CREAZIONE VOCE Variazione imponibile iscritti INPS
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='10101';
CodVoceCopia:='10161';
DesVoceCopia:='Variazione imponibile iscritti INPS';
DesVoceCopiaSt:='Variazione imponibile iscritti INPS';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce='10160'
       and v.cod_voce_speciale=t.cod_voce_speciale)
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio Variazione imponibile iscritti INPS 
-----
  
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario from p200_voci T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, '10160', cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine Variazione imponibile iscritti INPS
-----

  end if;
end if;
end;
/

-- CREAZIONE SINDACATI VARI
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  CodVoceFiglio varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='12441';
CodVoceCopia:='12466';
DesVoceCopia:='Fassid - SICUS';
DesVoceCopiaSt:='Fassid - SICUS';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio Fassid - SICUS
-----
  
SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine Fassid - SICUS
-----

  end if;

CodVoceModello:='12271';
CodVoceCopia:='12471';
DesVoceCopia:='Trattenuta U.I.L. dirigenti';
DesVoceCopiaSt:='Trattenuta U.I.L. dirigenti';

  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

---------------------------
-- INIZIO U.I.L. dirigenti
---------------------------

--Trattenuta Sindacato U.I.L. dirigenti 

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

--Imponibile Sindacato U.I.L. dirigenti

CodVoceModello:='12270';
CodVoceCopia:='12470';
DesVoceCopia:='Imponibile U.I.L. dirigenti';
DesVoceCopiaSt:='Imponibile U.I.L. dirigenti';
CodVoceFiglio:='12471';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, CodVoceFiglio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, cod_voce_padre, cod_voce_speciale_padre, CodVoceCopia, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_figlio='12025' and t.cod_voce_speciale_figlio='BASE';

---------------------------
-- FINE Sindacato U.I.L. dirigenti
---------------------------

  end if;

end if;
end;

-- FINE CREAZIONE SINDACATI VARI
/

insert into p201_assoggettamenti
select cod_contratto, cod_voce_padre, cod_voce_speciale_padre, '12470', cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
from p201_assoggettamenti T
where t.cod_contratto='EDP' and t.cod_voce_padre='12001' and t.cod_voce_speciale_padre='BASE'
and t.cod_voce_figlio='12015' and exists
(select 'x' from p200_voci v where v.cod_contratto=t.cod_contratto and v.cod_voce='12470'
 and v.cod_voce_speciale='BASE') and not exists
 (select 'x' from p201_assoggettamenti t1 where t1.cod_contratto=t.cod_contratto and t1.cod_voce_padre=t.cod_voce_padre
 and t1.cod_voce_speciale_padre=t.cod_voce_speciale_padre and t1.cod_voce_figlio='12470');

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV120-110-2007'',''Dirigente veterinario equiparato con struttura semplice (dec. 2007)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV120-110-2007'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV120-110-2007', DECORRENZA, 'Dir. veterinario equiparato con S.S. (dec. 2007)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',369.4,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2007',88.1,'2009',112.23)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV115-110-2007' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV120-110-2007');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='MV120-110-2007' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'MV120-110-2007');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR065-055-2004'',''Dirigente ruolo amministrativo equiparato con struttura semplice (dec. 2004)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR065-055-2004'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR065-055-2004', DECORRENZA, 'Dir. ruolo amministr. equiparato con S.S. (dec. 2004)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',196.43,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2004',21.09,'2005',45.54,'2006',50.17,'2007',68.63,'2009',85.07)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR065-050-2004' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR065-055-2004');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='DR065-055-2004' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'DR065-055-2004');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR075-050-2004'',''Dirigente ruolo amministrativo < 5 anni con struttura complessa (dec. 2004)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR075-050-2004'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR075-050-2004', DECORRENZA, 'Dir. ruolo amministr. < 5 anni con S.C. (dec. 2004)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',949.75,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2004',28.91,'2005',62.41,'2006',68.76,'2007',160.07,'2009',228.88)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR065-050-2004' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR075-050-2004');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='DR075-050-2004' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'DR075-050-2004');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR070-074-2004'',''Dirigente ruolo tecnico equiparato con struttura complessa (dec. 2004)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR070-074-2004'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR070-074-2004', DECORRENZA, 'Dir. ruolo tecnico equiparato con S.C. (dec. 2004)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',775.8,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2004',32.22,'2005',69.47,'2006',74.58,'2007',144.98,'2009',205.38)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR065-050-2004' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR070-074-2004');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='DR070-074-2004' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'DR070-074-2004');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR071-074-2004'',''Dirigente ruolo tecnico < 5 anni con struttura complessa (dec. 2004)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR071-074-2004'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR071-074-2004', DECORRENZA, 'Dir. ruolo tecnico < 5 anni con S.C. (dec. 2004)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',981.39,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2004',32.22,'2005',69.47,'2006',74.58,'2007',169.13,'2009',244.6)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR065-050-2004' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR071-074-2004');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='DR071-074-2004' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'DR071-074-2004');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV025-011-2008'',''Dirigente medico incarico lett. c) con struttura complessa area chirurgica (dec. 2008)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV025-011-2008'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV025-011-2008', DECORRENZA, 'Dir. medico lett. c) con S.C. chirurgica (dec. 2008)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',775.88,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2009',40.94)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV025-006-2008' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV025-011-2008');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='MV025-011-2008' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'MV025-011-2008');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV021-041'',''Dirigente medico ex modulo (legge 724/94) con struttura complessa area chirurgica (dec. 2002)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV021-041'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV021-041', DECORRENZA, 'Dir. medico ex modulo (legge 724/94) con S.C. chirurgica (dec. 2002)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.IMPORTO,223.86,42.39,34.03,18.33,68.4,35.83) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV026-041' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV021-041');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='MV021-041' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'MV021-041');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR020-006-2008'',''Dirigente ruolo sanitario equiparato con struttura complessa (dec. 2008)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR020-006-2008'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR020-006-2008', DECORRENZA, 'Dir. ruolo sanitario equiparato con S.C. (dec. 2008)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',687.13,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2009',23.65)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR015-010-2008' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR020-006-2008');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='DR020-006-2008' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'DR020-006-2008');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV025-016-2004-S2002'',''Dirigente medico incarico lett. c) con struttura complessa area territorio (dec. 2004) - semplice (dec. 2002)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV025-016-2004-S2002'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV025-016-2004-S2002', DECORRENZA, 'Dir. medico lett. c) con S.C. territorio (dec. 2004) - S.S. (dec. 2002)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',298.53,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2004',82.8,'2005',120.65,'2006',127.46,'2007',302.56,'2009',343.5)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV025-011-2004-S2003' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV025-016-2004-S2002');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='MV025-016-2004-S2002' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'MV025-016-2004-S2002');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV025-011-2003-S2002'',''Dirigente medico incarico lett. c) con struttura complessa area chirurgica (dec. 2003) - semplice (dec. 2002)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV025-011-2003-S2002'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV025-011-2003-S2002', DECORRENZA, 'Dir. medico lett. c) con S.C. chirurgica (dec. 2003) - S.S. (dec. 2002)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00210',123,'00212',362.18,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2004',170,'2005',228.14,'2006',238.6,'2007',413.7,'2009',454.64)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV030-011-2003' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV025-011-2003-S2002');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='MV025-011-2003-S2002' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'MV025-011-2003-S2002');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV025-006-2007-S2002'',''Dirigente medico incarico lett. c) con struttura complessa area medicina (dec. 2007) - semplice (dec. 2002)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV025-006-2007-S2002'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV025-006-2007-S2002', DECORRENZA, 'Dir. medico lett. c) con S.C. medicina (dec. 2007) - S.S. (dec. 2002)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',431.54,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2007',227.29,'2009',268.23)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV115-110-2007' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV025-006-2007-S2002');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='MV025-006-2007-S2002' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'MV025-006-2007-S2002');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV025-011-2008-S2007'',''Dirigente medico incarico lett. c) con struttura complessa area chirurgica (dec. 2008) - semplice (dec. 2007)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV025-011-2008-S2007'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV025-011-2008-S2007', DECORRENZA, 'Dir. medico lett. c) con S.C. chirurgica (dec. 2008) - S.S. (dec. 2007)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',687.78,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2008',88.1,'2009',129.04)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV025-011-2008-S2002' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV025-011-2008-S2007');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='MV025-011-2008-S2007' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'MV025-011-2008-S2007');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR075-055-2004'',''Dirigente ruolo amministrativo < 5 anni con struttura semplice (dec. 2004)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR075-055-2004'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR075-055-2004', DECORRENZA, 'Dir. ruolo amministr. < 5 anni con S.S. (dec. 2004)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',422.21,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2004',21.09,'2005',45.54,'2006',50.17,'2007',90.75,'2009',122.56)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR065-050-2004' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR075-055-2004');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='DR075-055-2004' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'DR075-055-2004');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR070-074-2008-S2002'',''Dirigente ruolo tecnico equiparato con struttura complessa (dec. 2008) - semplice (dec. 2002)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR070-074-2008-S2002'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR070-074-2008-S2002', DECORRENZA, 'Dir. ruolo tecnico equiparato con S.C. (dec. 2008) - S.S. (dec. 2002)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',815.3,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2008',105.48,'2009',165.88)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR065-050-2008-S2002' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR070-074-2008-S2002');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='DR070-074-2008-S2002' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'DR070-074-2008-S2002');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR065-050-2008-S2004'',''Dirigente ruolo amministrativo equiparato con struttura complessa (dec. 2008) - semplice (dec. 2004)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR065-050-2008-S2004'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR065-050-2008-S2004', DECORRENZA, 'Dir. ruolo amministr. equiparato con S.C. (dec. 2008) - S.S. (dec. 2004)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',793.29,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2008',68.63,'2009',122.07)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR065-050-2008-S2002' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR065-050-2008-S2004');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='DR065-050-2008-S2004' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'DR065-050-2008-S2004');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR071-074-2006'',''Dirigente ruolo tecnico < 5 anni con struttura complessa (dec. 2006)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR071-074-2006'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR071-074-2006', DECORRENZA, 'Dir. ruolo tecnico < 5 anni con S.C. (dec. 2006)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',1050.86,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2006',5.11,'2007',99.66,'2009',175.13)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR015-006-2006' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR071-074-2006');
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='DR071-074-2006' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'DR071-074-2006');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR070-074-2010'',''Dirigente ruolo tecnico equiparato con struttura complessa (dec. 2010-2012)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR070-074-2010'')';
      EXECUTE IMMEDIATE 'INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT ''EDP'', ''INCARICO'', ''DR070-074-2010'', TO_DATE(''01012010'',''DDMMYYYY''),
        ''Dir. ruolo tecnico equiparato con S.C. (dec. 2010-2012)'',
        ''00212'', ''BASE'', 981.18, ''SSSSSSSSSSSS'', TO_DATE(''31123999'',''DDMMYYYY''), ''''
           FROM DUAL WHERE NOT EXISTS
            (SELECT ''X'' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO=''EDP''
            AND T.NOME_VOCEAGGIUNTIVA=''INCARICO'' AND T.CODICE=''DR070-074-2010'')';
      DELETE P252_VOCIAGGIUNTIVEIMPORTI P252 WHERE P252.COD_VOCE='00212'
      AND P252.CODICE='DR070-074-2010' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_VOCE='00212'
                  AND T.CODICE<>'DR070-074-2010');

    end if;
  end if;
end;
/

---------------------------
-- INIZIO Indennità/Assegno personale/Posizione
---------------------------

declare 
  CURSOR C1 IS  
  SELECT P200.COD_CONTRATTO,P200.COD_VOCE,P200.COD_VOCE_SPECIALE,P200.ID_VOCE FROM P200_VOCI P200
         WHERE P200.COD_CONTRATTO='EDP' AND P200.COD_VOCE='00235'
         AND P200.COD_VOCE_SPECIALE NOT IN('BASE','TRED')
         ORDER BY P200.COD_VOCE,P200.DECORRENZA;  

  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
select COUNT(*) into i from P200_VOCI t where T.COD_CONTRATTO='EDP' AND T.COD_VOCE='00235' AND NOT EXISTS
  (select 'x' from P200_VOCI V WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE='00055');
if i > 0 then

CodVoceModello:='00235';
CodVoceCopia:='00055';
DesVoceCopia:='Indennità/Assegno personale/Posizione';
DesVoceCopiaSt:='Indennita''/Assegno personale/Posizione';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

INSERT INTO P205_QUOTE
select cod_contratto, cod_voce_da_quotare, cod_voce_speciale_da_quotare, CodVoceCopia, cod_voce_speciale_in_quota, decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio
from p205_quote T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_IN_QUOTA='00235';

  FOR T1 IN C1 LOOP
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
   
    INSERT INTO P200_VOCI
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, descrizione, CodVoceCopia || ' A', descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario
    from p200_voci P200 WHERE P200.ID_VOCE=T1.ID_VOCE;

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
    FROM P201_ASSOGGETTAMENTI P201 WHERE P201.COD_CONTRATTO=T1.COD_CONTRATTO 
    AND P201.COD_VOCE_PADRE=T1.COD_VOCE AND P201.COD_VOCE_SPECIALE_PADRE=T1.COD_VOCE_SPECIALE;

  END LOOP;

end if;
end;

---------------------------
-- FINE Indennità/Assegno personale/Posizione
---------------------------
/
