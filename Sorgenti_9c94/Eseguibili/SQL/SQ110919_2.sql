update p026_fondiprevcompl t set t.perc_max_dip_deduz_irpef=12.82 where t.cod_fpc='2142TFR';

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV025-020-2004'',''Dirigente medico incarico lett. c) con struttura semplice (dec. 2004)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV025-020-2004'')';
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV025-020-2004',
             DECODE(TO_CHAR(DECORRENZA,'YYYY'),'2005',TO_DATE('01012004','DDMMYYYY'),DECORRENZA),
             'Dir. medico lett. c) con S.S. (dec. 2004)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',280.09,
                    DECODE(TO_CHAR(P252.DECORRENZA,'YYYY'),'2007',88.10,'2009',107.52)) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV025-020-2005' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV025-020-2004');

    end if;
  end if;
end;
/

-- *********************************************************************************
-- IMPOSTAZIONE MASSIMALE PER I PARASUBORDINATI
-- ****************  2012  ****************
-- *********************************************************************************

declare 
  AnnoNuovo integer;
  CodVoce varchar2(5);
  CodVoceSpeciale varchar2(5);
  Massimale real;

  CURSOR C1 IS  
  SELECT '11110' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL UNION
  SELECT '11115', 'BASE' FROM DUAL UNION
  SELECT '11120', 'BASE' FROM DUAL UNION
  SELECT '11125', 'BASE' FROM DUAL UNION
  SELECT '11130', 'BASE' FROM DUAL UNION
  SELECT '11135', 'BASE' FROM DUAL;  

begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2012;
  -- IMPOSTARE QUI IL NUOVO MASSIMALE
  Massimale:=96149;

  FOR T1 IN C1 LOOP
    CodVoce:=T1.COD_VOCE;
    CodVoceSpeciale:=T1.COD_VOCE_SPECIALE;
    
    UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_A=Massimale WHERE P233.IMPORTO_DA=0
      AND P233.ID_SCAGLIONE=
      (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE=CodVoce AND P232.COD_VOCE_SPECIALE=CodVoceSpeciale AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

    UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_DA=Massimale+0.01 WHERE P233.IMPORTO_A=0
      AND P233.ID_SCAGLIONE=
      (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE=CodVoce AND P232.COD_VOCE_SPECIALE=CodVoceSpeciale AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
  END LOOP;
 
end;
/

-- Gestione tassazione separata su INAIL dipendente e INPS dipendente tipo Co.Co.Co.
UPDATE P200_VOCI T SET T.ECCEZIONI_SENSIBILI='a'
WHERE T.COD_CONTRATTO='EDP' 
AND T.COD_VOCE IN ('10060','10110','10120','10130','11060','11110','11120','11130')
AND T.COD_VOCE_SPECIALE='BASE';

alter table SG101_FAMILIARI add DETR_FIGLIO_100_AFFID VARCHAR2(1) default 'N';
comment on column SG101_FAMILIARI.DETR_FIGLIO_100_AFFID
  is 'Detrazione 100% affidamento figli';


---------------------------
-- INIZIO Congedo per donazione midollo osseo
---------------------------

declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='15110';
CodVoceCopia:='15112';
DesVoceCopia:='Congedo per donazione midollo osseo';
DesVoceCopiaSt:='Congedo per donazione midollo osseo';

select COUNT(*) into i from P200_VOCI t where T.COD_CONTRATTO='EDP' AND T.COD_VOCE='15110' AND NOT EXISTS
  (select 'x' from P200_VOCI V WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE='15112');
if i > 0 then

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P205_QUOTE
select cod_contratto, CodVoceCopia, cod_voce_speciale_da_quotare, cod_voce_in_quota, cod_voce_speciale_in_quota, decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio
from p205_quote T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE=CodVoceModello AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE';

end if;

insert into p215_codiciaccorpamentovoci
select cod_tipoaccorpamentovoci, 'S112', 'Indennita'' donatori di midollo osseo'
from p215_codiciaccorpamentovoci t
where t.cod_tipoaccorpamentovoci='UNIEM' and t.cod_codiciaccorpamentovoci='S110'
and not exists
(select 'x' from p215_codiciaccorpamentovoci v where v.cod_tipoaccorpamentovoci=t.cod_tipoaccorpamentovoci
 and v.cod_codiciaccorpamentovoci='S112');
 
insert into p216_accorpamentovoci
select cod_contratto, CodVoceCopia, cod_voce_speciale, cod_tipoaccorpamentovoci, 'S112', decorrenza, percentuale, importo_colonna, decorrenza_fine
from p216_accorpamentovoci t
where t.cod_tipoaccorpamentovoci='UNIEM' and t.cod_codiciaccorpamentovoci='S110' and t.cod_voce=CodVoceModello
and not exists
(select 'x' from p216_accorpamentovoci v where v.cod_tipoaccorpamentovoci=t.cod_tipoaccorpamentovoci
 and v.cod_codiciaccorpamentovoci='S112' and v.cod_voce=CodVoceCopia);
 
end;

---------------------------
-- FINE Congedo per donazione midollo osseo
---------------------------
/


declare
  i integer;
begin
  select COUNT(*) into i from P670_XMLREGOLE t where t.Nome_Flusso='UNIEMENS';
  if i > 0 then
     DELETE P670_XMLREGOLE t WHERE t.Nome_Flusso='UNIEMENS' AND T.NUMERO IN ('D360','D335');

insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
values ('UNIEMENS', to_date('01-04-2010', 'dd-mm-yyyy'), 'D335', 'CausaleVersMal', 'Causale della contribuzione di malattia o della restituzione della relativa indennità', 'D330', null, 'N', null, null, 'S', 'SELECT ''Z'' QUALIFICA1, ''00'' TIPOCONTRIBUZIONE,' || chr(10) || '       DECODE(P216.COD_CODICIACCORPAMENTOVOCI,''S110'',''E791'',''S112'',''E790'') CAUSALEVERSMAL,' || chr(10) || '       SUM(P442.IMPORTO * P216.PERCENTUALE / 100) IMPORTO ' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441, P216_ACCORPAMENTOVOCI P216' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND P442.ID_CEDOLINO = P441.ID_CEDOLINO' || chr(10) || 'AND P441.CHIUSO IN (:StatoCedolini) AND P441.DATA_CEDOLINO = :DataElaborazione' || chr(10) || 'AND P442.COD_CONTRATTO = P216.COD_CONTRATTO AND P442.COD_VOCE = P216.COD_VOCE AND P442.COD_VOCE_SPECIALE = P216.COD_VOCE_SPECIALE' || chr(10) || 'AND P442.DATA_COMPETENZA_A BETWEEN P216.DECORRENZA AND P216.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_TIPOACCORPAMENTOVOCI = ''UNIEM'' AND P216.COD_CODICIACCORPAMENTOVOCI IN (:InCodCodiciaccorpamentovoci)' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'GROUP BY P216.COD_CODICIACCORPAMENTOVOCI' || chr(10) || 'HAVING SUM(P442.IMPORTO) < 0' || chr(10) || 'ORDER BY DECODE(P216.COD_CODICIACCORPAMENTOVOCI,''S110'',''E791'',''S112'',''E790'')', 'SELECT ''Z'' QUALIFICA1, ''00'' TIPOCONTRIBUZIONE,' || chr(10) || '       DECODE(P216.COD_CODICIACCORPAMENTOVOCI,''S110'',''E791'',''S112'',''E790'') CAUSALEVERSMAL,' || chr(10) || '       SUM(P442.IMPORTO * P216.PERCENTUALE / 100) IMPORTO ' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441, P216_ACCORPAMENTOVOCI P216' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND P442.ID_CEDOLINO = P441.ID_CEDOLINO' || chr(10) || 'AND P441.CHIUSO IN (:StatoCedolini) AND P441.DATA_CEDOLINO = :DataElaborazione' || chr(10) || 'AND P442.COD_CONTRATTO = P216.COD_CONTRATTO AND P442.COD_VOCE = P216.COD_VOCE AND P442.COD_VOCE_SPECIALE = P216.COD_VOCE_SPECIALE' || chr(10) || 'AND P442.DATA_COMPETENZA_A BETWEEN P216.DECORRENZA AND P216.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_TIPOACCORPAMENTOVOCI = ''UNIEM'' AND P216.COD_CODICIACCORPAMENTOVOCI IN (:InCodCodiciaccorpamentovoci)' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'GROUP BY P216.COD_CODICIACCORPAMENTOVOCI' || chr(10) || 'HAVING SUM(P442.IMPORTO) < 0' || chr(10) || 'ORDER BY DECODE(P216.COD_CODICIACCORPAMENTOVOCI,''S110'',''E791'',''S112'',''E790'')', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (NOME_FLUSSO, DECORRENZA, NUMERO, ELEMENTO, DESCRIZIONE, NUMERO_PADRE, FORMATO_FILE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, ATTRIBUTO, TIPO_IMPORTO, DATO_RIEPILOGATIVO, DECORRENZA_FINE)
values ('UNIEMENS', to_date('01-04-2010', 'dd-mm-yyyy'), 'D360', 'CausaleRecMal', 'Causale del recupero dell’indennità di malattia', 'D355', null, 'N', null, null, 'S', 'SELECT ''Z'' QUALIFICA1, ''00'' TIPOCONTRIBUZIONE,' || chr(10) || '       P216.COD_CODICIACCORPAMENTOVOCI CAUSALERECMAL, - SUM(P442.IMPORTO * P216.PERCENTUALE / 100) IMPORTO ' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441, P216_ACCORPAMENTOVOCI P216' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND P442.ID_CEDOLINO = P441.ID_CEDOLINO' || chr(10) || 'AND P441.CHIUSO IN (:StatoCedolini) AND P441.DATA_CEDOLINO = :DataElaborazione' || chr(10) || 'AND P442.COD_CONTRATTO = P216.COD_CONTRATTO AND P442.COD_VOCE = P216.COD_VOCE AND P442.COD_VOCE_SPECIALE = P216.COD_VOCE_SPECIALE' || chr(10) || 'AND P442.DATA_COMPETENZA_A BETWEEN P216.DECORRENZA AND P216.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_TIPOACCORPAMENTOVOCI = ''UNIEM'' AND P216.COD_CODICIACCORPAMENTOVOCI IN (:InCodCodiciaccorpamentovoci)' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'GROUP BY P216.COD_CODICIACCORPAMENTOVOCI' || chr(10) || 'HAVING SUM(P442.IMPORTO) > 0' || chr(10) || 'ORDER BY P216.COD_CODICIACCORPAMENTOVOCI', 'SELECT ''Z'' QUALIFICA1, ''00'' TIPOCONTRIBUZIONE,' || chr(10) || '       P216.COD_CODICIACCORPAMENTOVOCI CAUSALERECMAL, - SUM(P442.IMPORTO * P216.PERCENTUALE / 100) IMPORTO ' || chr(10) || 'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441, P216_ACCORPAMENTOVOCI P216' || chr(10) || 'WHERE P441.PROGRESSIVO = :Progressivo AND P442.ID_CEDOLINO = P441.ID_CEDOLINO' || chr(10) || 'AND P441.CHIUSO IN (:StatoCedolini) AND P441.DATA_CEDOLINO = :DataElaborazione' || chr(10) || 'AND P442.COD_CONTRATTO = P216.COD_CONTRATTO AND P442.COD_VOCE = P216.COD_VOCE AND P442.COD_VOCE_SPECIALE = P216.COD_VOCE_SPECIALE' || chr(10) || 'AND P442.DATA_COMPETENZA_A BETWEEN P216.DECORRENZA AND P216.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_TIPOACCORPAMENTOVOCI = ''UNIEM'' AND P216.COD_CODICIACCORPAMENTOVOCI IN (:InCodCodiciaccorpamentovoci)' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || 'GROUP BY P216.COD_CODICIACCORPAMENTOVOCI' || chr(10) || 'HAVING SUM(P442.IMPORTO) > 0' || chr(10) || 'ORDER BY P216.COD_CODICIACCORPAMENTOVOCI', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));

  end if;
end;
/

-- CREAZIONE VOCE Variazione imponibile fondo prev. compl.
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='10101';
CodVoceCopia:='10081';
DesVoceCopia:='Variazione imponibile fondo prev. compl.';
DesVoceCopiaSt:='Variazione imponibile fondo prev. compl.';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce='10080'
       and v.cod_voce_speciale=t.cod_voce_speciale)
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio Variazione imponibile fondo prev. compl. 
-----
  
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, '10080', cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine Variazione imponibile fondo prev. compl.
-----

  end if;
end if;
end;
/

-- *********************************************************************************
-- IMPOSTAZIONE NUOVO SCAGLIONE PER CPDEL, CPS, ENPAM EX CONVENZIONATI, OPTANTI INPS
-- E PERSONALE RELIGIOSO INPS
-- ****************  2012  ****************
-- *********************************************************************************

declare 
  AnnoNuovo integer;
  CodVoce varchar2(5);
  CodVoceSpeciale varchar2(5);
  Scaglione real;

  CURSOR C1 IS  
  SELECT '11010' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL UNION
  SELECT '11010', 'ENTE' FROM DUAL UNION
  SELECT '11020', 'BASE' FROM DUAL UNION
  SELECT '11020', 'ENTE' FROM DUAL UNION
  SELECT '11160', 'BASE' FROM DUAL UNION
  SELECT '11170', 'BASE' FROM DUAL UNION
  SELECT '11410', 'BASE' FROM DUAL;
begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2012;
  -- IMPOSTARE QUI IL NUOVO SCAGLIONE PER CPDEL, CPS, ENPAM EX CONVENZIONATI E OPTANTI INPS
  Scaglione:=44204;

  FOR T1 IN C1 LOOP
    CodVoce:=T1.COD_VOCE;
    CodVoceSpeciale:=T1.COD_VOCE_SPECIALE;
    
    UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_A=Scaglione WHERE P233.IMPORTO_DA=0
      AND P233.ID_SCAGLIONE=
      (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE=CodVoce AND P232.COD_VOCE_SPECIALE=CodVoceSpeciale AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

    UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_DA=Scaglione+0.01 WHERE P233.IMPORTO_A=0
      AND P233.ID_SCAGLIONE=
      (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE=CodVoce AND P232.COD_VOCE_SPECIALE=CodVoceSpeciale AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
  END LOOP;
 
end;
/

