alter table T370_TIMBMENSA add ID_RICHIESTA number(38);
comment on column T370_TIMBMENSA.ID_RICHIESTA is 'T105.ID della richiesta di modifica della timbratura';

alter table T105_RICHIESTETIMBRATURE add RILEVATORE_ORIG varchar2(2);
comment on column T105_RICHIESTETIMBRATURE.RILEVATORE_ORIG is 'Rilevatore originale della timbratura';

declare
  i integer;
begin
  select COUNT(*) into i from P042_ENTIIRPEF;
  if i = 0 then
    insert into I050_SCRIPTSQL (NOME) values ('SQ140215_2AddIRPEF.sql');
  end if;
exception
  when others then
    insert into I050_SCRIPTSQL (NOME) values ('SQ140215_2AddIRPEF.sql');
end/*--NOLOG--*/;
/
---------------------------
-- INIZIO gestione separata ENPAPI
---------------------------

declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);
  ID_P233 integer;
  ID_P242 integer;

  CURSOR C1(CodVoceScaglione string) IS  
  select t.* from P232_SCAGLIONI t
  where t.cod_contratto='EDP' and t.cod_voce=CodVoceScaglione and t.cod_voce_speciale='BASE'
  order by t.decorrenza;
  

begin
  select COUNT(*) into i from P240_TIPIASSOGGETTAMENTI t where t.cod_contratto='EDP'
         and t.cod_tipoassoggettamento='INPS1' and not exists
         (select 'x' from P240_TIPIASSOGGETTAMENTI v where v.cod_contratto='EDP'
          and v.cod_tipoassoggettamento='ENPAPI1');
  if i > 0 then

    CodVoceModello:='11110';
    CodVoceCopia:='11330';
    DesVoceCopia:='Ritenuta ENPAPI dip. altre  ass. / pens.';
    DesVoceCopiaSt:='Ritenuta ENPAPI dip. altre  ass. / pens.';

  -- Creazione voce 11330-BASE Ritenuta ENPAPI dip. altre  ass. / pens.
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

  -- Creazione scaglioni per voce 11330-BASE Ritenuta ENPAPI dip. altre  ass. / pens.
    FOR T1 IN C1(CodVoceModello) LOOP

      SELECT P233_ID_SCAGLIONE.NEXTVAL INTO ID_P233 FROM DUAL;

      insert into p232_scaglioni
        (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_scaglione, tipo_importo, tipo_ritenuta, tipo_applicazione, conguaglio_annuale, conguaglio_fine_rapporto, conguaglio_dopo_fine_rapporto, cod_voce_conguaglio, cod_voce_speciale_conguaglio, mensilita_annue, massimale1, massimale2, cod_voce_peso1, cod_voce_speciale_peso1, cod_voce_peso2, cod_voce_speciale_peso2, cod_voce_conguaglio2, cod_voce_speciale_conguaglio2)
      values
        (T1.cod_contratto, CodVoceCopia, T1.cod_voce_speciale, T1.decorrenza, ID_P233, T1.tipo_importo, T1.tipo_ritenuta, T1.tipo_applicazione, T1.conguaglio_annuale, T1.conguaglio_fine_rapporto, T1.conguaglio_dopo_fine_rapporto, T1.cod_voce_conguaglio, T1.cod_voce_speciale_conguaglio, T1.mensilita_annue, T1.massimale1, T1.massimale2, T1.cod_voce_peso1, T1.cod_voce_speciale_peso1, T1.cod_voce_peso2, T1.cod_voce_speciale_peso2, T1.cod_voce_conguaglio2, T1.cod_voce_speciale_conguaglio2);

      insert into p233_scaglionifasce
      select ID_P233, importo_da, importo_a, perc_imp from p233_scaglionifasce t
      where t.id_scaglione=T1.id_Scaglione;

    END LOOP;

    CodVoceModello:='11115';
    CodVoceCopia:='11335';
    DesVoceCopia:='Ritenuta ENPAPI ente altre  ass. / pens.';
    DesVoceCopiaSt:='Ritenuta ENPAPI ente altre  ass. / pens.';

  -- Creazione voce 11335-BASE Ritenuta ENPAPI ente altre  ass. / pens.
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

  -- Creazione scaglioni per voce 11335-BASE Ritenuta ENPAPI ente altre  ass. / pens.
    FOR T1 IN C1(CodVoceModello) LOOP

      SELECT P233_ID_SCAGLIONE.NEXTVAL INTO ID_P233 FROM DUAL;

      insert into p232_scaglioni
        (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_scaglione, tipo_importo, tipo_ritenuta, tipo_applicazione, conguaglio_annuale, conguaglio_fine_rapporto, conguaglio_dopo_fine_rapporto, cod_voce_conguaglio, cod_voce_speciale_conguaglio, mensilita_annue, massimale1, massimale2, cod_voce_peso1, cod_voce_speciale_peso1, cod_voce_peso2, cod_voce_speciale_peso2, cod_voce_conguaglio2, cod_voce_speciale_conguaglio2)
      values
        (T1.cod_contratto, CodVoceCopia, T1.cod_voce_speciale, T1.decorrenza, ID_P233, T1.tipo_importo, T1.tipo_ritenuta, T1.tipo_applicazione, T1.conguaglio_annuale, T1.conguaglio_fine_rapporto, T1.conguaglio_dopo_fine_rapporto, T1.cod_voce_conguaglio, T1.cod_voce_speciale_conguaglio, T1.mensilita_annue, T1.massimale1, T1.massimale2, T1.cod_voce_peso1, T1.cod_voce_speciale_peso1, T1.cod_voce_peso2, T1.cod_voce_speciale_peso2, T1.cod_voce_conguaglio2, T1.cod_voce_speciale_conguaglio2);

      insert into p233_scaglionifasce
      select ID_P233, importo_da, importo_a, perc_imp from p233_scaglionifasce t
      where t.id_scaglione=T1.id_Scaglione;

    END LOOP;

    CodVoceModello:='10110';
    CodVoceCopia:='10330';
    DesVoceCopia:='Imponibile ENPAPI altre  ass. / pens.';
    DesVoceCopiaSt:='Imponibile ENPAPI altre  ass. / pens.';

  -- Creazione voce 10330-BASE Imponibile ENPAPI altre  ass. / pens.
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, 
    decode(cod_voce_figlio,'11110','11330','11115','11335'), 
    cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE'
    and t.cod_voce_figlio in ('11110','11115');

    CodVoceModello:='11120';
    CodVoceCopia:='11340';
    DesVoceCopia:='Ritenuta ENPAPI dip. no coperture ass.';
    DesVoceCopiaSt:='Ritenuta ENPAPI dip. no coperture ass.';

  -- Creazione voce 11340-BASE Ritenuta ENPAPI dip. no coperture ass.
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

  -- Creazione scaglioni per voce 11340-BASE Ritenuta ENPAPI dip. no coperture ass.
    FOR T1 IN C1(CodVoceModello) LOOP

      SELECT P233_ID_SCAGLIONE.NEXTVAL INTO ID_P233 FROM DUAL;

      insert into p232_scaglioni
        (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_scaglione, tipo_importo, tipo_ritenuta, tipo_applicazione, conguaglio_annuale, conguaglio_fine_rapporto, conguaglio_dopo_fine_rapporto, cod_voce_conguaglio, cod_voce_speciale_conguaglio, mensilita_annue, massimale1, massimale2, cod_voce_peso1, cod_voce_speciale_peso1, cod_voce_peso2, cod_voce_speciale_peso2, cod_voce_conguaglio2, cod_voce_speciale_conguaglio2)
      values
        (T1.cod_contratto, CodVoceCopia, T1.cod_voce_speciale, T1.decorrenza, ID_P233, T1.tipo_importo, T1.tipo_ritenuta, T1.tipo_applicazione, T1.conguaglio_annuale, T1.conguaglio_fine_rapporto, T1.conguaglio_dopo_fine_rapporto, T1.cod_voce_conguaglio, T1.cod_voce_speciale_conguaglio, T1.mensilita_annue, T1.massimale1, T1.massimale2, T1.cod_voce_peso1, T1.cod_voce_speciale_peso1, T1.cod_voce_peso2, T1.cod_voce_speciale_peso2, T1.cod_voce_conguaglio2, T1.cod_voce_speciale_conguaglio2);

      insert into p233_scaglionifasce
      select ID_P233, importo_da, importo_a, perc_imp from p233_scaglionifasce t
      where t.id_scaglione=T1.id_Scaglione;

    END LOOP;

    CodVoceModello:='11125';
    CodVoceCopia:='11345';
    DesVoceCopia:='Ritenuta ENPAPI ente no coperture ass.';
    DesVoceCopiaSt:='Ritenuta ENPAPI ente no coperture ass.';

  -- Creazione voce 11345-BASE Ritenuta ENPAPI ente no coperture ass.
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

  -- Creazione scaglioni per voce 11345-BASE Ritenuta ENPAPI ente no coperture ass.
    FOR T1 IN C1(CodVoceModello) LOOP

      SELECT P233_ID_SCAGLIONE.NEXTVAL INTO ID_P233 FROM DUAL;

      insert into p232_scaglioni
        (cod_contratto, cod_voce, cod_voce_speciale, decorrenza, id_scaglione, tipo_importo, tipo_ritenuta, tipo_applicazione, conguaglio_annuale, conguaglio_fine_rapporto, conguaglio_dopo_fine_rapporto, cod_voce_conguaglio, cod_voce_speciale_conguaglio, mensilita_annue, massimale1, massimale2, cod_voce_peso1, cod_voce_speciale_peso1, cod_voce_peso2, cod_voce_speciale_peso2, cod_voce_conguaglio2, cod_voce_speciale_conguaglio2)
      values
        (T1.cod_contratto, CodVoceCopia, T1.cod_voce_speciale, T1.decorrenza, ID_P233, T1.tipo_importo, T1.tipo_ritenuta, T1.tipo_applicazione, T1.conguaglio_annuale, T1.conguaglio_fine_rapporto, T1.conguaglio_dopo_fine_rapporto, T1.cod_voce_conguaglio, T1.cod_voce_speciale_conguaglio, T1.mensilita_annue, T1.massimale1, T1.massimale2, T1.cod_voce_peso1, T1.cod_voce_speciale_peso1, T1.cod_voce_peso2, T1.cod_voce_speciale_peso2, T1.cod_voce_conguaglio2, T1.cod_voce_speciale_conguaglio2);

      insert into p233_scaglionifasce
      select ID_P233, importo_da, importo_a, perc_imp from p233_scaglionifasce t
      where t.id_scaglione=T1.id_Scaglione;

    END LOOP;

    CodVoceModello:='10120';
    CodVoceCopia:='10340';
    DesVoceCopia:='Imponibile ENPAPI no coperture ass.';
    DesVoceCopiaSt:='Imponibile ENPAPI no coperture ass.';

  -- Creazione voce 10340-BASE Imponibile ENPAPI no coperture ass.
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, 
    decode(cod_voce_figlio,'11120','11340','11125','11345'), 
    cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE'
    and t.cod_voce_figlio in ('11120','11125');

  -- Creazione assoggettamento ENPAPI1
    SELECT P242_ID_TIPOASSOGGETTAMENTO.NEXTVAL INTO ID_P242 FROM DUAL;

    INSERT INTO P240_TIPIASSOGGETTAMENTI
    SELECT 'ENPAPI1', COD_CONTRATTO, DECORRENZA, ID_P242, 'ENPAPI ALTRE COPERTURE ASSICURATIVE O PENSIONATI + IRAP', DECORRENZA_FINE, TFR
    FROM P240_TIPIASSOGGETTAMENTI T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_TIPOASSOGGETTAMENTO='INPS1';

    INSERT INTO P242_TIPIASSOGGETTAMENTIVOCI
    SELECT ID_P242, DECODE(COD_VOCE,'10110','10330',COD_VOCE), COD_VOCE_SPECIALE FROM P242_TIPIASSOGGETTAMENTIVOCI P242
    WHERE P242.ID_TIPOASSOGGETTAMENTO=
      (SELECT T.ID_TIPOASSOGGETTAMENTO FROM P240_TIPIASSOGGETTAMENTI T
       WHERE T.COD_CONTRATTO='EDP' AND T.COD_TIPOASSOGGETTAMENTO='INPS1');

  -- Creazione assoggettamento ENPAPI2
    SELECT P242_ID_TIPOASSOGGETTAMENTO.NEXTVAL INTO ID_P242 FROM DUAL;

    INSERT INTO P240_TIPIASSOGGETTAMENTI
    SELECT 'ENPAPI2', COD_CONTRATTO, DECORRENZA, ID_P242, 'ENPAPI NO COPERTURE ASSICURATIVE + IRAP', DECORRENZA_FINE, TFR
    FROM P240_TIPIASSOGGETTAMENTI T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_TIPOASSOGGETTAMENTO='INPS2';

    INSERT INTO P242_TIPIASSOGGETTAMENTIVOCI
    SELECT ID_P242, DECODE(COD_VOCE,'10120','10340',COD_VOCE), COD_VOCE_SPECIALE FROM P242_TIPIASSOGGETTAMENTIVOCI P242
    WHERE P242.ID_TIPOASSOGGETTAMENTO=
      (SELECT T.ID_TIPOASSOGGETTAMENTO FROM P240_TIPIASSOGGETTAMENTI T
       WHERE T.COD_CONTRATTO='EDP' AND T.COD_TIPOASSOGGETTAMENTO='INPS2');

  end if;
end;

---------------------------
-- FINE gestione separata ENPAPI
---------------------------
/

insert into t480_comuni
select '099028','POGGIO TORRIANA','47824','RN','M324' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M324');

insert into t480_comuni
select '016253','VAL BREMBILLA','24012','BG','M334' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M334');

insert into t480_comuni
select '025071','LONGARONE','32013','BL','M342' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M342');

insert into t480_comuni
select '030188','RIVIGNANO TEOR','33061','UD','M317' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M317');

insert into t480_comuni
select '025070','QUERO VAS','32038','BL','M332' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M332');

UPDATE T480_COMUNI t SET T.CITTA='LONGARONE (comune soppresso)'
WHERE T.CODCATASTALE='E672';

update P200_VOCI t
set t.ridotta_parttime_vert='N'
where t.cod_contratto='EDP' and t.cod_voce_speciale='15105' and t.ridotta_parttime_vert='S';
	
-- *****************************************************************************
-- AGGIORNAMENTO FASCE DI REDDIT0 2014 PER A.N.F.
-- *****************************************************************************

declare 
  AnnoNuovo integer;
  PercISTAT real;
  ID_P238 integer;
  
  CURSOR C1 IS  
  SELECT * FROM P236_TABELLEANF T WHERE T.DECORRENZA=TO_DATE('01072013','DDMMYYYY')
   AND NOT EXISTS (SELECT 'X' FROM P236_TABELLEANF V WHERE V.DECORRENZA=TO_DATE('01072014','DDMMYYYY'));
   
begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2014;
 
  -- IMPOSTARE QUI LA % ISTAT DI INCREMENTO DA APPLICARE PER IL NUOVO ANNO DA GESTIRE
  PercISTAT:=1.1;  

  FOR T1 IN C1 LOOP

   SELECT P238_ID_TABELLAANF.NEXTVAL INTO ID_P238 FROM DUAL;
   
   INSERT INTO P236_TABELLEANF
     (COD_TABELLAANF, DECORRENZA, ID_TABELLAANF, DESCRIZIONE, DECORRENZA_FINE)
   VALUES
     (T1.COD_TABELLAANF, TO_DATE('0107'||TO_CHAR(AnnoNuovo),'DDMMYYYY'), ID_P238, T1.DESCRIZIONE, TO_DATE(31123999,'DDMMYYYY'));

   UPDATE P236_TABELLEANF SET DECORRENZA_FINE=TO_DATE('3006'||TO_CHAR(AnnoNuovo),'DDMMYYYY')
     WHERE ID_TABELLAANF=T1.ID_TABELLAANF;

   INSERT INTO P238_TABELLEANFSCAGLIONI
     SELECT ID_P238, IMPORTO_DA, ROUND(IMPORTO_A * (1 + PercISTAT / 100), 2),
     IMPORTO_COMPONENTI_1, IMPORTO_COMPONENTI_2, IMPORTO_COMPONENTI_3, IMPORTO_COMPONENTI_4, 
     IMPORTO_COMPONENTI_5, IMPORTO_COMPONENTI_6, IMPORTO_COMPONENTI_7, IMPORTO_COMPONENTI_8, IMPORTO_COMPONENTI_9 
     FROM P238_TABELLEANFSCAGLIONI WHERE ID_TABELLAANF=T1.ID_TABELLAANF;

   UPDATE P238_TABELLEANFSCAGLIONI P238
   SET P238.IMPORTO_DA=
     (SELECT MAX(P238A.IMPORTO_A)+0.01 FROM P238_TABELLEANFSCAGLIONI P238A WHERE
      P238.ID_TABELLAANF=P238A.ID_TABELLAANF AND P238A.IMPORTO_A<P238.IMPORTO_A)
   WHERE P238.ID_TABELLAANF=ID_P238 AND P238.IMPORTO_DA<>0;

  END LOOP;

end;

/
