ALTER TABLE T265_CAUASSENZE 
  ADD ABBATTE_GGVALUTAZIONE VARCHAR2(1) DEFAULT 'N';
Comment on column T265_CAUASSENZE.ABBATTE_GGVALUTAZIONE 
  is 'S=Riduce i giorni utili al raggiungimento dei giorni minimi per la valutazione';
UPDATE T265_CAUASSENZE 
SET ABBATTE_GGVALUTAZIONE = 'S' 
WHERE ALLUNGA_PROVA = 'S' OR PERIODO_LUNGO = 'S';

UPDATE P660_FLUSSIREGOLE T
SET T.REGOLA_CALCOLO_MANUALE=REPLACE(T.REGOLA_CALCOLO_MANUALE,
                                     'AND P441.CHIUSO IN (:StatoCedolini)',
                                     'AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''')
WHERE T.NOME_FLUSSO='F24EP' AND UPPER(T.REGOLA_CALCOLO_MANUALE) LIKE '%P441%'
AND T.REGOLA_CALCOLO_MANUALE LIKE '%AND P441.CHIUSO IN (:StatoCedolini)%'
AND T.REGOLA_CALCOLO_MANUALE NOT LIKE '%AND P441.TIPO_CEDOLINO <> ''RP''%';

UPDATE P660_FLUSSIREGOLE T SET T.REGOLA_CALCOLO_AUTOMATICA=T.REGOLA_CALCOLO_MANUALE;

UPDATE P670_XMLREGOLE T
SET T.REGOLA_CALCOLO_MANUALE=REPLACE(T.REGOLA_CALCOLO_MANUALE,
                                     'AND P441.CHIUSO IN (:StatoCedolini)',
                                     'AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''')
WHERE T.NOME_FLUSSO='UNIEMENS' AND UPPER(T.REGOLA_CALCOLO_MANUALE) LIKE '%P441%'
AND T.REGOLA_CALCOLO_MANUALE LIKE '%AND P441.CHIUSO IN (:StatoCedolini)%'
AND T.REGOLA_CALCOLO_MANUALE NOT LIKE '%AND P441.TIPO_CEDOLINO <> ''RP''%';

UPDATE P670_XMLREGOLE T
SET T.REGOLA_CALCOLO_MANUALE=REPLACE(T.REGOLA_CALCOLO_MANUALE,
                                     'AND CHIUSO IN (:StatoCedolini)',
                                     'AND CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''')
WHERE T.NOME_FLUSSO='UNIEMENS' AND UPPER(T.REGOLA_CALCOLO_MANUALE) LIKE '%P441%'
AND T.REGOLA_CALCOLO_MANUALE LIKE '%AND CHIUSO IN (:StatoCedolini)%'
AND T.REGOLA_CALCOLO_MANUALE NOT LIKE '%AND P441.TIPO_CEDOLINO <> ''RP''%';

UPDATE P670_XMLREGOLE T SET T.REGOLA_CALCOLO_AUTOMATICA=T.REGOLA_CALCOLO_MANUALE;

UPDATE P552_CONTOANNREGOLE T
SET T.REGOLA_CALCOLO_MANUALE=REPLACE(T.REGOLA_CALCOLO_MANUALE,
                                     'AND CHIUSO IN (:StatoCedolini)',
                                     'AND CHIUSO IN (:StatoCedolini) AND TIPO_CEDOLINO <> ''RP''')
WHERE T.ANNO=2012 AND T.COD_TABELLA IN ('TRIM01','TRIM02','T12','T13','T14','T15A','T15B','T15C')
AND T.REGOLA_CALCOLO_MANUALE LIKE '%AND CHIUSO IN (:StatoCedolini)%'
AND T.REGOLA_CALCOLO_MANUALE NOT LIKE '%AND TIPO_CEDOLINO <> ''RP''%';

UPDATE P552_CONTOANNREGOLE T SET T.REGOLA_CALCOLO_AUTOMATICA=T.REGOLA_CALCOLO_MANUALE;

-- INIZIO Aggiornamento regole 770

insert into p602_770regole
select anno, parte, '653', tipo_record, sezione_file, formato_file, parte_cud, numero_cud, descrizione,
numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica,
regola_calcolo_manuale, regola_modificabile, commento, formato_annomese, '653', cod_arrotondamento_file
from p602_770regole t where t.anno=2012 and t.parte='B' and t.numero='652';

delete P602_770REGOLE t
where t.anno=2012 and t.parte='D' and t.descrizione like '%Importo inferiore all''unita'' di euro';

update P602_770REGOLE t set t.descrizione='Prima rata acconto cedolare secca locazioni 2012 dichiarante - Importo rimborsato a seguito di rettifica'
where t.anno=2012 and t.parte='D' and t.numero='082';

update P602_770REGOLE t set t.descrizione='Prima rata acconto cedolare secca locazioni 2012 coniuge dichiarante - Importo rimborsato a seguito di rettifica'
where t.anno=2012 and t.parte='D' and t.numero='087';

update P602_770REGOLE t set t.formato_file='N11'
where t.anno=2012 and t.parte='C31' and t.numero='034';

delete P004_CODICITABANNUALI t where t.cod_tabannuale='770SECRAT' and t.anno=2012 and t.cod_codicitabannuali='B';

update P602_770REGOLE t set t.cod_arrotondamento_file='P1'
where t.anno='2012' and t.parte like 'C%' and t.cod_arrotondamento_file='P1000';

update P602_770REGOLE t set t.cod_arrotondamento_file='P1'
where t.anno='2012' and t.parte='E' and t.cod_arrotondamento_file='P1000';

-- FINE Aggiornamento regole 770

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
-- Inizio C.G.I.L. a importo fisso 
-----
  
CodContratto:='EDPSC';
CodVoceModello:='12771';
CodVoceCopia:='12756';
DesVoceCopia:='C.G.I.L. a importo fisso';
DesVoceCopiaSt:='C.G.I.L. a importo fisso';

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
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
    WHERE T.COD_CONTRATTO=CodContratto AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto=CodContratto and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine C.G.I.L. a importo fisso
-----

  end if;
end if;

end;

/

