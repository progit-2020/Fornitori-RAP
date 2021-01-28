comment on column MONDOEDP.I071_PERMESSI.C700_SALVASELEZIONI
  is 'S=Registrazione abilitata, N=Registrazione disabilitata, I=Solo inserimento abilitato';
  
--Imposto il nuovo flag ai permessi utilizzati dagli operatori di IrisWin, dato che il vecchio N funzionava come il nuovo I
UPDATE MONDOEDP.I071_PERMESSI I071
SET C700_SALVASELEZIONI = 'I'
WHERE C700_SALVASELEZIONI = 'N'
AND AZIENDA = :AZIENDA
AND EXISTS (SELECT 1 
            FROM MONDOEDP.I070_UTENTI I070
            WHERE I070.AZIENDA = I071.AZIENDA
            AND I070.PERMESSI = I071.PROFILO);

-- Calcolo congedo ordinario senza rateo di tredicesima
UPDATE p205_quote t SET T.ACCUMULO_RATEO=0
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE='00455' AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE';
            
-- Creazione sindacato FESMED 12 mesi a importo fisso
declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);
  RitenutaCopia Number;
  CodVoceFiglio varchar2(5);
begin
  select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='12071' AND T.COD_VOCE_SPECIALE='BASE';
  if i > 0 then
    select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='12426' AND T.COD_VOCE_SPECIALE='BASE';
    if i = 0 then
  
      CodVoceModello:='12071';
      CodVoceCopia:='12426';
      DesVoceCopia:='FESMED';
      DesVoceCopiaSt:='FESMED';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

    end if;
  end if;
end;
/

insert into p004_codicitabannuali
select cod_tabannuale, '1E', anno, 'Amministratore e al contempo legale rappresentante in carica'
from p004_codicitabannuali t
WHERE T.COD_TABANNUALE='ISTIPRAPCO' AND T.ANNO=2011 AND T.COD_CODICITABANNUALI='1A' and not exists
(select 'x' from p004_codicitabannuali v WHERE v.COD_TABANNUALE='ISTIPRAPCO' AND v.ANNO=2011 AND v.COD_CODICITABANNUALI='1E');


alter table T025_CONTMENSILI add TIPOLIMITECOMP_NOREC varchar2(1) default 'N';
comment on column T025_CONTMENSILI.TIPOLIMITECOMP_NOREC is 'N= l''abbattimento considera il saldo mese al netto dei recuperi dai saldi precedenti, S=l''abbattimento considera il saldo mese al lordo dei recuperi dai saldi precedenti';