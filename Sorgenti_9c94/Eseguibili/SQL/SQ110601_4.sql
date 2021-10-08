declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV035-025-2005'',''Dirigente medico < 5 anni con incarico lett. c) (dec. 2005)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV035-025-2005'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV035-025-2005', DECORRENZA, 'Dir. medico < 5 anni con lett. c) (dec. 2005)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',234.16,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2005',44.92,'2006',53.01,'2007',118.80,'2009',137.42)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV030-020-2005' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV035-025-2005');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV030-025-2006'',''Dirigente medico equiparato con incarico lett. c) (dec. 2006)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV030-025-2006'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV030-025-2006', DECORRENZA, 'Dir. medico equiparato con lett. c) (dec. 2006)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',81.22,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2006',8.09,'2007',8.09,'2009',12.8)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR015-006-2006' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV030-025-2006');

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV030-025-2005'',''Dirigente medico equiparato con incarico lett. c) (dec. 2005)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV030-025-2005'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV030-025-2005', DECORRENZA, 'Dir. medico equiparato con lett. c) (dec. 2005)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',36.3,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2005',44.92,'2006',53.01,'2007',53.01,'2009',57.72)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV030-020-2005' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV030-025-2005');

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
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='12431';
CodVoceCopia:='12441';
DesVoceCopia:='SAUES Sind. Autonomo Urgenza Sanitaria';
DesVoceCopiaSt:='SAUES Sind. Autonomo Urgenza Sanitaria';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio Sindacato SAUES 12 mesi a importo fisso 
-----
  
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine Sindacato SAUES 12 mesi a importo fisso 
-----

  end if;
end if;
end;
/

comment on column T265_CAUASSENZE.VALIDAZIONE
  is 'S=Richiesta validazione assenza per registrazione su storico giustificativi e diversificazione sul tabellone turni';