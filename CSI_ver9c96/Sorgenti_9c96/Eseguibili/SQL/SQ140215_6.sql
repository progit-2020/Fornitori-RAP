-- INIZIO SPOSTAMENTO ACCORPAMENTO VOCI INAPT SU CU770

declare
  i integer;
begin
  select COUNT(*) into i from P214_TIPOACCORPAMENTOVOCI WHERE COD_TIPOACCORPAMENTOVOCI='CU770'
         AND EXISTS (select 'X' from P214_TIPOACCORPAMENTOVOCI WHERE COD_TIPOACCORPAMENTOVOCI='INAPT')
         AND NOT EXISTS (select 'X' from P215_CODICIACCORPAMENTOVOCI WHERE COD_TIPOACCORPAMENTOVOCI='CU770' AND COD_CODICIACCORPAMENTOVOCI='INAIL-PT-TABEL');
  if i > 0 then
    insert into p215_codiciaccorpamentovoci
      (cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, descrizione)
    values
      ('CU770', 'INAIL-PT-TABEL', 'Retribuzione tabellare per calcolo INAIL dipendenti part-time del comparto');
    insert into p215_codiciaccorpamentovoci
      (cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, descrizione)
    values
      ('CU770', 'INAIL-PT-STR', 'Straordinario per calcolo INAIL dipendenti part-time del comparto');
    
    insert into p216_accorpamentovoci
    select cod_contratto, cod_voce, cod_voce_speciale, 'CU770', 'INAIL-PT-TABEL', decorrenza, percentuale, importo_colonna, decorrenza_fine
    from p216_accorpamentovoci t where t.cod_tipoaccorpamentovoci='INAPT' and t.cod_codiciaccorpamentovoci='TABEL';

    insert into p216_accorpamentovoci
    select cod_contratto, cod_voce, cod_voce_speciale, 'CU770', 'INAIL-PT-STR', decorrenza, percentuale, importo_colonna, decorrenza_fine
    from p216_accorpamentovoci t where t.cod_tipoaccorpamentovoci='INAPT' and t.cod_codiciaccorpamentovoci='STR';
    
    update p092_codiciinail t set t.cod_accorp_retr_tabell='CU770.INAIL-PT-TABEL' where t.cod_accorp_retr_tabell='INAPT.TABEL';
    update p092_codiciinail t set t.cod_accorp_str='CU770.INAIL-PT-STR' where t.cod_accorp_str='INAPT.STR';

    delete p214_tipoaccorpamentovoci WHERE COD_TIPOACCORPAMENTOVOCI='INAPT';

  end if;
end;
/
-- FINE SPOSTAMENTO ACCORPAMENTO VOCI INAPT SU CU770

-- Inizio creazione, per tutti i contratti, della voce 10231 - Variazione imponibile IRPEF per TFR

declare 
  ID_P200 integer;
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

  CURSOR C1 IS  
  select t.cod_contratto,t.cod_voce,t.cod_voce_speciale from p200_voci t where t.cod_voce='10208' and t.cod_voce_speciale='BASE'
  and exists (select 'x' from p200_voci v where v.cod_contratto=t.cod_contratto and v.cod_voce='10230' and v.cod_voce_speciale='BASE')
  and not exists (select 'x' from p200_voci v where v.cod_contratto=t.cod_contratto and v.cod_voce='10231' and v.cod_voce_speciale='BASE');
  
begin
  CodVoceCopia:='10231';
  DesVoceCopia:='Variazione imponibile IRPEF per TFR';
  DesVoceCopiaSt:='Variazione imponibile IRPEF per TFR';

  FOR T1 IN C1 LOOP
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, 'c', cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
    WHERE T.COD_CONTRATTO=T1.COD_CONTRATTO AND T.COD_VOCE=T1.COD_VOCE AND T.COD_VOCE_SPECIALE=T1.COD_VOCE_SPECIALE;

    -- Assoggettamenti
    INSERT INTO P201_ASSOGGETTAMENTI
    select COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE_PADRE, '10230', COD_VOCE_SPECIALE_FIGLIO, DECORRENZA, ASSOGGETTAMENTO, ASSOGGETTAMENTO13A, DECORRENZA_FINE FROM P201_ASSOGGETTAMENTI T
    WHERE T.COD_CONTRATTO=T1.COD_CONTRATTO AND T.COD_VOCE_PADRE=T1.COD_VOCE AND T.COD_VOCE_SPECIALE_PADRE=T1.COD_VOCE_SPECIALE AND T.COD_VOCE_FIGLIO='10200';
    
  END LOOP;    
end;

/

-- Fine creazione, per tutti i contratti, della voce 10231 - Variazione imponibile IRPEF per TFR

-- Creazione interrogazione di servizio PA_DMA_2_Quadri_F1
declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    DELETE from t002_querypersonalizzate t where t.nome = 'PA_DMA_2_Quadri_F1';

    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', -4, 'CHKINTESTAZIONE(S)CHKNORITORNOACAPO(S)', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', -2, 'Sostituzione,Data,Data', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', -1, '*,"31/01/2013","31/03/2013"', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 0, 'SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME, P672.DATA_FINE_PERIODO DATA_CEDOLINO,P673.VALORE CASSA,', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 1, '  (SELECT P673A.VALORE FROM P673_XMLDATIINDIVIDUALI P673A WHERE P673A.ID_FLUSSO=P673.ID_FLUSSO', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 2, '   AND P673A.PROGRESSIVO=P673.PROGRESSIVO AND P673A.NUMERO=''G515''', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 3, '   AND P673A.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD=P673.TIPO_RECORD) TIPO_PIANO,', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 4, '  (SELECT DECODE(P673A.VALORE,''V'',1,-1) FROM P673_XMLDATIINDIVIDUALI P673A WHERE P673A.ID_FLUSSO=P673.ID_FLUSSO', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 5, '   AND P673A.PROGRESSIVO=P673.PROGRESSIVO AND P673A.NUMERO=''G555''', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 6, '   AND P673A.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD=P673.TIPO_RECORD) *', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 7, '  (SELECT P673A.VALORE FROM P673_XMLDATIINDIVIDUALI P673A WHERE P673A.ID_FLUSSO=P673.ID_FLUSSO', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 8, '   AND P673A.PROGRESSIVO=P673.PROGRESSIVO AND P673A.NUMERO=''G550''', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 9, '   AND P673A.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD=P673.TIPO_RECORD) IMPORTO', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 10, 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, T030_ANAGRAFICO T030', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 11, 'WHERE P672.NOME_FLUSSO=''UNIEMENS'' AND P672.DATA_FINE_PERIODO BETWEEN :MeseCedolino__Da AND :MeseCedolino_A', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 12, 'AND P673.ID_FLUSSO=P672.ID_FLUSSO AND P673.NUMERO=''G510'' AND P673.TIPO_RECORD=''M''', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 13, 'AND T030.PROGRESSIVO=P673.PROGRESSIVO', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 14, 'AND P673.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 15, 'ORDER BY T030.COGNOME, T030.NOME, P672.DATA_FINE_PERIODO, P673.PROGRESSIVO_NUMERO', 'PAGHE');

  end if;
end;
/

UPDATE p258_addizionaliirpef t SET T.IMPORTO_TOTALE=ROUND(T.IMPORTO_TOTALE,2)
WHERE T.IMPORTO_TOTALE<>ROUND(T.IMPORTO_TOTALE,2) AND T.ANNO=2014;

UPDATE p258_addizionaliirpef t SET T.IMPONIBILE=ROUND(T.IMPONIBILE,2)
WHERE T.IMPONIBILE<>ROUND(T.IMPONIBILE,2) AND T.ANNO=2014;

-- Inizio creazione Cassa Trattamenti pensionistici dei dipendenti statali (CTPS) 

insert into p004_codicitabannuali
select cod_tabannuale, '1', anno, 'Cassa Trattamenti Pensionistici dipendenti Statali' from p004_codicitabannuali t
where t.cod_tabannuale='IPGESASSIC' and t.cod_codicitabannuali='2'
and not exists
(select 'x' from p004_codicitabannuali v where v.cod_tabannuale=t.cod_tabannuale and v.cod_codicitabannuali='1' and v.anno=t.anno);

UPDATE P206_ASSENZEINPDAP T
SET T.COD_GESTASSIC_NONCOPERTE='1,' || T.COD_GESTASSIC_NONCOPERTE
WHERE T.COD_GESTASSIC_NONCOPERTE LIKE '%2,%' AND T.COD_GESTASSIC_NONCOPERTE NOT LIKE '1,%';

-- Fine creazione Cassa Trattamenti pensionistici dei dipendenti statali (CTPS)

update P240_TIPIASSOGGETTAMENTI t
set t.descrizione='CPDEL + INADELP TFR + IRAP (Direttori con DMA ente provenienza)'
where t.cod_tipoassoggettamento='CPDRD' and t.descrizione='CPDEL + INADELP TFR + IRAP (DIRETTORI)';

update P240_TIPIASSOGGETTAMENTI t
set t.descrizione='CPDEL + INADELP TFR + IRAP + ENPDEDP (Direttori con DMA ente provenienza)'
where t.cod_tipoassoggettamento='CPDRDE' and t.descrizione='CPDEL + INADELP TFR + IRAP (DIRETTORI) + ENPDEDP';

update P240_TIPIASSOGGETTAMENTI t
set t.descrizione='CPDEL + INADELP TFS + IRAP (Direttori con DMA ente provenienza)'
where t.cod_tipoassoggettamento='CPDSD' and t.descrizione='CPDEL + INADELP TFS + IRAP (DIRETTORI)';

update P240_TIPIASSOGGETTAMENTI t
set t.descrizione='CPDEL + INADELP TFS + IRAP + ENPDEDP (Direttori con DMA ente provenienza)'
where t.cod_tipoassoggettamento='CPDSDE' and t.descrizione='CPDEL + INADELP TFS + IRAP (DIRETTORI) + ENPDEDP';

update P240_TIPIASSOGGETTAMENTI t
set t.descrizione='CPS + INADELP TFR + IRAP (Direttori con DMA ente provenienza)'
where t.cod_tipoassoggettamento='CPSRD' and t.descrizione='CPS + INADELP TFR + IRAP (DIRETTORI)';

update P240_TIPIASSOGGETTAMENTI t
set t.descrizione='CPS + INADELP TFR + IRAP + ENPDEDP (Direttori con DMA ente provenienza)'
where t.cod_tipoassoggettamento='CPSRDE' and t.descrizione='CPS + INADELP TFR + IRAP (DIRETTORI) + ENPDEDP';

update P240_TIPIASSOGGETTAMENTI t
set t.descrizione='CPS + INADELP TFS + IRAP (Direttori con DMA ente provenienza)'
where t.cod_tipoassoggettamento='CPSSD' and t.descrizione='CPS + INADELP TFS + IRAP (DIRETTORI)';

update P240_TIPIASSOGGETTAMENTI t
set t.descrizione='CPS + INADELP TFS + IRAP + ENPDEDP (Direttori con DMA ente provenienza)'
where t.cod_tipoassoggettamento='CPSSDE' and t.descrizione='CPS + INADELP TFS + IRAP (DIRETTORI) + ENPDEDP';

